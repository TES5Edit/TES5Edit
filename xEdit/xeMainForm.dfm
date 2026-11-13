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
      67F7FF519623D237C18CCF2672CAD568288BD0AA8DF8FF9BE5B8E3496FBF96D3
      1EDFE331390A8730E3DB79F740128CE99E8AA4245E957E204D14C5417EC0F783
      FF22C57753F2DF6D99ABD41BD1C790CB94BCF82A41446487284153F9714E65B0
      6C788B834EF9CA20A27FB2FDA45314D2009788BFF51C05EAE8C1B34A55500190
      694B4D95C89851089F00EB869307A9CB81585900F6D5F067E05857AEB61A097A
      3508BC39A5713A977976391D480E2955061A88D51C4A28A2194C0354BB6D015B
      B88C66FF3B6A7D786709CC4385DE11AA9539FCE86A0B36A3ADC7A8309E51CE83
      6B636920734B319F38AAFF6E92B85A6B85ED66939D8D64A739D4759EC5147AC2
      60F41346644436A2F66C192F62DF40A42C8294CCD538517904438BDC04F9109B
      5B140DCBA367990DDB9C9F287A5F939F0606816F5EACCB482FF8AF6E5598DF78
      7C6AB2CEB027EE01796335558731DC8C7C1281D6260666C9F3CCB21237B6F54B
      5CA98198051D442AE3439D34969424F1C16C1EA7AE8E4CBDF74EF5D6EA8C50A3
      F4D819923D14894D74401E2ABC9934D4E9FCD1C9C2B2304FF1E23CDE456E8621
      CFC66D43CE3AA76A3C56EDE6A8A9EAEA3299E908D065F28A825BF529C29C2848
      8D377B7A44DDA0733AC0047E1975CE6BAAD5393FA79F5AE7839ABAEA35DBF869
      48A7BF9FC059CED61C7F577572A0C41F9A92024A9F03F1777EAEEAF01E6E4C92
      A936C981DCA81142C4C5B250B0B282290088C596415E1BD5BB6C8F94B7143FE1
      E9E7D8B206782AAB32C823C0D4057DD11AB59B2A8547796DD6CF30FC45F3AAAB
      EAAA9FE4307B382FA62EAE7ADD22F6FD8CC766D01EAABAFA104459E97B31646A
      A0FD20274991C5B1B07D3CC3F9687D18A846319F3E2A98D24C9DC71EEB75DE10
      8452497112DEF139A681AC42E508A66222AD38F34C915D36670852BC0996B715
      F00B58873835C76FDEC0AA1875866F54430D879D9A3ABD7C8DFFBCE5BAE0E1E9
      91D334A5408AEB8A0B08561005E99CCBEAB62E9185C46BF2A4E4CBA8949684C5
      E317F221117A7AF9AA717A71E5662E5D5CA1943AB8650F01B056C93165715173
      A9CE3AAD8F12641775C540621420207E1A9317CD010A3E221C5E21C33755F38B
      AB61E7895E169BEA8C7D1EB62ECF8B7DB305E294ACA5200D07823E45C1BF73A3
      9A1E0142ABF107949D124A3BD430C328DA27F7A4027C7FFADBD1EF0C3E82F721
      5FA80155742FF2941C226BF5112E7B1A5005FE64CDD5DECFA14B5A1F6A6AD81A
      9CD754B3D7BB14E1003557E318F9330D7CD13D2525666157C3390215A9EA9F0C
      509741A7156964D2FA52A6FE6477EB750362C3D9178959DD2F621F182C5800C1
      46E987942D93591C24F2239236C472F2F46B797A09E0A7AAAB610541BA0D1765
      A829E31B9E610A652D745DECC54DA60688F0C39F18EC0F3A07FCFCC30F825F20
      6686C8AC42E80B9B16A55A8BED995A82044E513B6DBFABA21816E412859165F9
      25DEA9CFAB2035EAEC1341577C736BB3425CFA532B6AFB755821A9A0CD282ADF
      5601D27ECC5092D9CA1EA9CF4B458C6F2FC73697C4C3ABF2687CD745B35749FC
      27010590A60262957C6C713BA3983019BB84537FFE341CE1F8AEF4529D7E3A3F
      A7E79EA02E8ECE50CB72A921F140952BDF2107BEEEE1B00DEF0E694AE390E060
      EC09BF441285C9131087BE21F8B8F8C59473E08F49FC48BC678239A5F984B39D
      6420213F6B712EFC40AAD3F9E14E9D4EC910E25E3834CD230A168A9E2CA1203A
      0C66110214145DC2018D8ADF69DF319AE5FBEACC64DD54E403596DE5CF16733C
      CBA9D241A4266B718927710411076F66C01BC7534B2BFFA6A85368E809209133
      C55F9F41776EA61037E12255B008992065F4730B36B2D3D894684040BD26FFDB
      919767F236FCE664DD257CD6E62C390C5FC4285EA67F6CBE80EF5EE5FC71601A
      08110A9A42FAD4ACA2453A9C5E61AB20FFA938883E7E6E3769C13E0EBBFFE45C
      1110C010C5344D3A7FAB04C532BE05E43846FF7C5FA59EB61E3A4EEBA7AEC50E
      9FA25699EC6F40915112CED5E772CABE21FBBF43EE5D744F4F77C8FA9D1659BF
      771625864844004359321EBDCB7E9FCAEC0252FE748BC169C42E492FBE311443
      5CE834B5BB593A210F1A8522109EFE367F8A02E6B9818967927734DBE238EA35
      4195D4647EDD2A00323D93CE8773BD3400F00B688E6E9538130FBF891FA4309A
      56CF229A9660CC1C253A4AE19AA6FC3627C35112D08469C3CC2D3BB43E952761
      9F9E615559D47FD037F1B5EA463826FA1DE2A424DD6D69AC4D662C4D6432019F
      F86699CD9F659FD36B44954D3A7F67A54EB930C8A16DE79319B8F134360753B9
      B999D8881A576BC4BE4604F71C078A12DEC08D48CACB72C5417671A1A11A76E8
      0AB4DBC382914EC8E5D2778C44D06AA51326CF63FD42A114203E89B78600A64C
      BA4BAA2022CAD7789980F3D5565CF1662C6247561AD0E0816E5558EF846F6011
      2CD3978838E91ADCB60A7F5EB1A47E2C403C84A289328928F5F0F102951C2C1D
      EB4299168BE806B8740EABB54D795550771150AABA07D6F0E13FE4130388072A
      311C8107BDEFA6FE23FC223C37FC1B2C39372C4143CE7AA435C1F3D99F98FB0D
      6BC9661BD3B1A4358B6E603ED3DA267D615ABB034EC477CFFFF95A4D13E77443
      530C36B67FF308FB504512216049FFAA6D54AF2369CC4E9E6439C11C69A38181
      73D5B3F6556866DA5BD33D5A06B786838B5A807EA7719EB450C70C974CA7AA17
      80342D9EC2101498DA4273655481E3F6E25904EF54ABF62F47879B07C42F6851
      F81EA4DE2974D72EE052BB67E44AA4357503DC0A5BFB47ED422460C893E6311D
      7B67245BB8820081CD404407319920A4D3822976E660B17CC5A79058A5B9A08F
      97A5B04582D493A8087F1194452BC45F6B1448C56729E8FC8CC2D50299260CE1
      0AD72A04A89BCDEB3A1B81D360468B4AC03559341609C26282FB2022CA00E475
      BB757920678F486FFC02728383893E7E2AA576DBCE178EA28F55075ED412225B
      076511A44BF0BEFBF2CE1C4BB3FE09C74C48FC3023FB4A5D99995413528685E8
      A51DB70374D38CE527563F90348422C16CE122AE4B10054C8312C02465384434
      CBE19A14E2D8F2A208ACF74EE19B1379F9BF9F90BCBC5D2189C76908A2DC2A9B
      FFFD1542F325C4B947BA208E2A546B07265DD28BDAE81765B81A42122071A382
      A5D632E5DF058B21E834D77988B59EE5A14EEAE6B650769C572523427871719E
      EB85D4A14AB54237D6C3609268A6F3BAB6C7866F572564297EBAB95DA225411C
      FDA1F4E0E5FAD5375750C853B8CEDF577BB42728364D02769AF76B22D4F069FB
      AD782A555342F80691CC99C682E5C062DEDF179F14C77A12E666992071299BE5
      E9E865E9E9F3FA151F4ACB3FEF4223F7F5FD07E371B9DB691678D7EB86C02091
      3C661AE630AB97A0A51A337D3405AD55D7A130CC94B838B62D1CA77AE738EEF5
      4D120ECCCCDCEE9793B56E30D57232654ACDD6B21513E179112D0E7FB1A094CB
      D6542DE31B5764315F8C4653CCF03A8B7C7B458A1B48018792CCB699B20DC60A
      A54E7A93950F7BF905EB35E81466E2A6C553150613DF4C914C6B84BFBF6EDCDE
      7E8054862CCE2772C076CF29F09DE58BDA28AA60CB2BABF6A0B6479DFE694D8D
      06CDBED40AF4FA231B997EAF3A115D53B0CD2566A5135F82EF947ED84C3CEC23
      E89516E5F7084337286F61F94077BEEAA78931A1064E8D0761A6777B486346BD
      C899163BCE4459BD7DDE2A6AE72CF9F00E1138A647C7D2AD26B64A8E2ABA6A6A
      34941A21AAB9A597AE95B817F8C8C3601671664E242B00787A09C19118709009
      FBD5948509204E751BF123E4BC338D3485B064E2559E113AD100C2F0A4985244
      503A44BD578444543762BB3A88A3FDDAE605C1BB1C9C0C9B8D0358A8A5C2AA72
      88278D6C65F435AA08EEDD86A7201177E10D3F892793B517E6669342BC651058
      AC6DF292A7C124484A7A71EF871A605B0BDD33591207FEBD84E3C4A1A3A3A5CE
      3267F2F17B7928BECB58BE07F20F79DBEE36CF1BEDF39341A37D7EF5594D121D
      79F33A7701A2DA142DC4D81BC8970881959F91F3128423C57F7D45DF73B3E83B
      518A83D49A07A17F86CC9DF5A0999F86B1AA96531A77B0A783482A0608A57D97
      27F9B143FF7A7AF9FA0BBA06BDCC6C38F297CF9DDE264D907444E0904A62845B
      0B94DA8564958410D603A2DD57CB3C59BA7630C0A6B509CA7C92A352C1F86512
      15037DEA72762B0E53B527DC29A04E7164DA1A80EE4269E4CF843311053696CF
      C922A5AF283FB447C85E0E5302C28F29D1F7D27DA158A0C4ACCDED4B89D6C280
      42C069725DB06692B9ED4F3FE8F49F26894742BB1C279BCB325A4D5808B7CDD4
      79DD079DB30B356837479C3913324A40817478ADF89F8C9127D00FC5B2C1D7BE
      2E39CFDD0EE2A8337CFD85A600002D656E5D3D7D3CEB153FEBDCA469E38CE858
      923AC943560028429A18CECA4349339B325E8CAA7D8A8A2005FA87E7EE93F055
      9BFE1B5ED11F94E0FF8ACBB6E97088395A7538DE5150055F111258E19792BE67
      05A1877DE024AF163A930F51FD6C492BB8B1249C3DA97CCF504505C6755319E4
      386F3845D46F00D21E45A55FF58E8480929BD32C628AF7DD3B5B5AA9C245A758
      5306AB1A780F605A82545C382A8C61FCFE329F8484312CCA772400952A1F4B9E
      B3A0A95BCA9C82E59B58CF70903F122103C5621D8F811CBA6AF303B2B39392F9
      837CFFBA8889E337C7045EAFA9D7873FBD6148116FE2F19BD75BCB87DB87A223
      E760A8F00B482F8A0671726C826E3674D8BFF3006145820940A15B0F16E5850C
      BAE0DA90E2A0EA907FC9911B790054419D0B158BA6187C485188BB19A1B2DA5C
      CA738B09EE310B023596613E6C22709CB97289B52551880B84E76F9C64629EBE
      EBB9BFAFBAE9B8AC7297ECE6A0651FCD7217070D1323A26E3A91D1CC66FB2C89
      4E95D39FEA8B6DAF0F2BEEBE8395E16E94E0BBF2E1DF91A0674E0E71E425357F
      B77E0C7D1C218FC3AC5A3255508D364B4E11626FDAFBCB8FC73FD5D45F7E7C73
      E48897342B1BF37807B65F4A526062DC3F8083221813171A7D68D02D808B9351
      9A477419FC35AA61D9FE28AECCBAFEEF5C874C0E06C15EAF72A1BEAF0C0A07F1
      9B43BEF895301B5F68EC179B831794C89A621FC699A7FA03683CB1E052B84F83
      08A5C146B96C165BB38025789C64448330373749E93F08A56E8594C00F12F6C8
      9D0BEAEC3309F84ECFB5C92D73303B502F368FD6DE6BC0DB4FDFA9A343C0DCDF
      A9A3FD17B0D6E34C87AA5170F572489C8FA96A14458BBBD1D216A58FB66F11FD
      F6A5ADC7B4E181976A192FF3659D2A903991B777F75C3F7C97BF1ED57D302541
      F7EB09EF7911BBDBC8AB4BE5CE5345081F8A0A0AA1294470BD8C5052E44D3677
      12BB3ACAFC8A9BD144DB8DA11275DC50687AB90C916B86994C604FB4C1CB92F8
      DA9D29B503EE552AF391D20F506C956B42660D822A16B55742FDC49A7C3C87FC
      A5731323E0B2A44CA86E05124C87447B98C5D711324F721821DB01FB2F3811AC
      86C78A919982E01F012AB6D8F3C841953428788BA8ECCE5A4EA09031DF891BFB
      8EFA2E6987D5CD0CEA66160B4D2805DAE49CC9769923AD106F5298C144B910D4
      643C108DC71EC9C2976F6EE9711748BCEDBF2F71BF95E7A3C90661AD83A800F2
      3FCF2BC2F306D724BC664B2054C642F9E04666C571F2205AE6196ED7CBDEBA17
      FBF0555E6E342FF1625883E55FF913DB13E730DD938A394964D651CD5BC98208
      C74E05CB61D13DA4E18B4891B4BB799E253E8F89AA08BCCD95864A5B76F5662B
      A36799875C988DD80B2E6469BF92314FEE2FF70C6083825C863B2EC73C3009D0
      0242BDB2E577944E6F071168CF34C3D0BE5CEBBC5B02A0812026181FD9F9863F
      5CFC255A8B20C0B63ECBA2FCE5A71F7F2C8D83422AA23EFCDF39F66982F63154
      692CD6D386C545EFCE5C35ECB531EFD6334DF5CD21DB82C379001EBC98681D79
      95DBDD765D78369649BC584A55A6E5B4D320575C21184E3C3B0803586EC0F2B6
      3CCFAC8F0E8F8F0B279C57901807B87D487110CE4C84009719767E7E67B7E100
      C5BECF34ABD76F7E54687920163B190B752183F009D94EDE02E7DE7CF52F14AE
      D119C59F41809A4FE8D3CF32BD0133FFAA51CF2C628E508D0A66083A88187A92
      83C2D4A740545DF0D32CF152B5C7794E7582DA06DC4794A2316FB34D0009BD30
      93470DCCAC738B8664D713746220A6463433E419A0EA1F14435CA53A1AAE23FA
      F563B8271E1D309674ABA9645A6B20099736E745BEF52CA000BEB51E28822F29
      E00A24A231BF072AFF7F2413802DBD1726001B5DA0F0E09E54C83600CE6A584B
      A0313C3DDAB17ABB3FE8A93AF74EF4CD14DE5A840C17D5547083520EEC3CDB04
      9AFD76A5BCBFCFDC594D4403F1F6CCBD1DAB933826BDB877670AAEC39F5D6078
      4A14C8FB738FDA3453C74CAEAE56934F11603F7BC7FB4FFEFE145460B62CCC83
      6AD0EC3E4C5BD2B1873942FC69E796B07CA749BC380117DEC04C9F7C42482662
      26DD8BCB5EA37B71D9BC673ACE0FAE6429EB807D96A949ED43A042F448E11525
      B93712964FF482C35687B69C382DEA4CF0D79F53D55DA26734030BD4A6B8B32D
      1787984D74E4C70B5B8EF744135A4D2AB41158F9F4720517A38E4823C24A340F
      C0DEAD7D819FF9334B0D08B0B83D17A821DCDBA89F969CB563B136F8F3132EF6
      633381713181B5A37386BDBA199F9DE15929DD48E67054002DDD19DB696B8725
      0DBF5838C6A386979F2E98BEA43D6CD9E33CB0916FE133E4583396B006B40BC7
      032D0DA91C84CD1D77546B48CB8DC7AA839B0EC94349DB0F719E20E13034999A
      863198D68319F70454C74F76D2BAEDF34EA159C66345A067BA8964E38AD0CD62
      750E46DA7B4BF19F60058803002B309D52EF8F52D5FD4C90856146556EF0978F
      EB90C08CBCC28DABCABA7DF79ADBF15835C97A492B65DB4118AA1152C5D61F7A
      4F106B16416528C43A49EC10E950E5D134086175B141C4C7D8A025769DC23E16
      524138732A962F725A4374CD563D1D697ABB27DAE50FED3E7499182D4FF6D87E
      B345DBD61FB64715A28D14D4A740F821C1CC8144E08C0430A6FEE36FEAE8F8B8
      64E0E176BE8565F55533E3FBAAFE1E663373141B44165457AF12D4E6A1FB2309
      D9E1E0EC847F767AE8E7D107B2775A619C97982DE19F20A2047B4A48DEA7EA2F
      C73FD5FFF2EA48EDF50E47BF342EF09FCBC3D12FFBCFE5670880ED7CD81A34CE
      21A388015E2432AF264BEB3A0A0470A8E84ADE35FD81B27255889D4AEF375E1A
      7F3AA4E4F02978992FE2CC8A6FC701CE75E49FF302A3009F38089AC82E503811
      2E4D3CCC287F42BCF2726A29245452CF5ABFC9B9DF055E6CB49AB4839BD3B641
      7B1C9DBAB90C62CBA0C2D46E5559635C28CF27130534CEF959BB0B83A8420C51
      8E4427E4B942B0E421C840373A09B8211C39E8F69DF72CDF2AE1E3206F8C7C61
      0910A79F278E4D9085F135317E1EF9203B5D4DFA713A88B3C66A022DC63F14BA
      00593F7D1383A956AD2657C67BC51F705FF66C557D4F5225AB4901AE120ACB18
      BF2BBABF65B19A244623A881B2DCBA6F96E0618CBC35F7EF7DB430C58577DBB4
      E1E81F24F586A3B6E80E6E53AA433833BB9ACD57720810411FC55D121A18C3DC
      8298100BD52889F3AA52EB8F61A6120B8322CC97AF2A98AC02154CD4ACDBD7C5
      73B4AF3ABFF4C194C741F0C2E600C886AA4498BFD6EDF0B75AA38AB966AF62C5
      2FA7C8D486209DA3C76D4EFEB39A10AFC777ADBB3349D6C9E5E5C78A7F41CD15
      C8DCA5D90DD12A141F699C77CF3E94126C97D5D9B66BEB3032671129B16970EB
      161E686EACF8462C0887C62DFF8057BEC70D201A479C93A3376AEF3C888C4EF6
      C9A2BB53D0BF53A8E733308CAA253D23AF4C187B0151496D9F59A6BC846BF29E
      8DC715A11F6DB7C9AFC4A936749C5B6292CC1EA62B290052F5021747C486D22D
      65E8252856462C358BD5C5E545C7A6055A1F0BCE6F7A1E80718909D7A512DE7F
      4A9BE973A7D947C480CA393803B09818CA857FE62EB94C85896035075089158E
      D1C035B54CCC4D10E769B8B605B272658985E7E80E0B4F1530FF5D14646E77F9
      A23DA403CBD131E9C0600D3222BC115548F170EC047311ED71DD7C25E961999D
      F6DD8316E3B11AF14486F32A2D8C2C9C3D31DFB32AEE67B52BCCAC6DE28DB89C
      AA53C1DFF255DA2023E3381A2EF445B3F78639DC9B3DB7715793CB93D17060FE
      2D418B2E9719372C372CBB4858F1926E9572FA97BDCBF6F793D6C15675BBCB97
      AD9EAC065262354CD6FA0E0D81C4E3D0C83D603F95922294984A808342121FF9
      7686A7E6891B2AA47B7141E2EF422FA87B02252B1000C23F4C46E611AD9904A8
      8A75E3D82FBA08C1CC0BBC8026FC1D4BE878B4B066C4E32F15664513B0F5D26D
      05CEBF59CCF615DABBF70C07C9E29C1A0897697AC295DF714DF7DFDD3FBDB7C7
      98DEDBE3EAF44CE4EB745EE051245FFB8E8AE9CA5ABABD965E2CD528C842B3FF
      5E3A324AFBA6FEF93F066A4FA2B305AA6D5F217208701B02CB542D1DA764F435
      9258AC742EB97BCF88CA7BB800CBA6974EAF33E05A3FB5F74BBF356AB42EDB67
      FBB5B21650ED752ECE7B8DCEC5F908FF19EED7B8E1F4A72BB5D7FCF4E96ABFA6
      FAF3751A78A91AAE234FEDF53F0C47FB7C41DABDB311D1F5E5E9AE936C960481
      93108D9190D84F6BEA9F239366A779E4897417F880450A4932EC9EAD7FAF9AAD
      93212285AFD55FF9DA5EF45BBF71E7ECF3ABF32E5BC2527CE87C4EBCB90E4343
      6D31D74B4C4FF8B11A8107FF8B7F476BD519D25ACDCAB8A29B0AEC5F9D580FBF
      E8E54D0016FCF324F6D744E92B32CA3DEF78D51D76B9F9FAA4B9980426CA5A71
      882213D2A4EF8BD2508AA306D134FEEAA5DD893989F456C19A69AB4FDFCBDD00
      AF9C597157C73CBA8EE2D5779421BA6A924A99AA854D56CB55DF574B55D37C52
      B7D00F4D46D81EFA48A0983B0CED94F7DF6FAA67A94379F3A3DBFCEE54D6DED9
      994A91E4668DE57DC0AB7792822BBC5550172C4D722DE057EA72C5B16EFAB9F0
      6571F86BEAE46CD844516C70634649309B990415568D93B3E1CF405B67EB4FCB
      59A27D4ED133CB658D083E705388F5937870A8402CAC74252B8843C99B38851D
      860BED0C40B4BB74F6B9D3567B6789BE819BF319A2D924E2CA5171184B90511B
      1F1B0102A4DA7A81C9563F5310BB4AE91C91FA038C604824DC19802A738B47ED
      132AD0A03A5EA32C3DF60E0818E89EE6646960EF2E45ECEA1C7E070A3DBA6E10
      F43D5BAB2CB0549265A0C452FEA16CBC9EC461D800E3077D48BE56CF8B4D4CB3
      F49942D2D6ADEE0F3E2179C7C13C18963FE73ACAF285EAA429B510B227AA15A7
      8FAB282BEE8363A69C6511DD896221AC5E8037CB155654309D6ED67FD4A8468C
      D073952AB409B25F3EB52C8AEED63CEDE1377F1F5E5E103AD976D7408A8E2898
      9F69F5479D414F35930CA0E605EAB2C4262EEE66BDD23130887CE222DA1B9924
      D1916A260BED6B2BD88E8EF6FF20983B154C5A3E73CAF401C817D6A91294E309
      A4BFCAFEDCFCA1BAB0C1F7C803A864E5B987C90EBAB56A4B43411C9874210543
      A2CDF15BE7880E3B7B6706BD8A082F9CC4084203F16529C8E0F6550A20A9CD1E
      4DE00F220EC614B7C81684A1E4C6243A2C78171AF28F7384444BDCF1C264F318
      D66CD3F7FB1AF5FB82C54E6B148C4118190F6D0CF58D19C5F8A778737162EE9E
      BB0A8B307F4C4AA1B766C80F425899F62931599E48A10293B4CA3B883DC06CD5
      08B13C53F2C31EA3AFF05114D9109E2C57B02AF9D8DE3EB3F312DAB29E1A4047
      A813B8FDBA1478519D86558B4493F62CAFD2B94559BDEAAE26C2DD7B201B1A44
      B3613E910A2FD2B9AB0961170FE8BF48D19FAC3BF660344EDD3BE65A50E56A72
      410C64C1EFC6B6D7C2960BCCD28E7E6632FA07FEE4A69181CD65D6BC2ED2DF34
      604376A7710A610A96C522B9F39E4BCC8A84950A36B23CB67B3B7AFE0A2B0D00
      33774FDEAE8CD9454E98D3FDDCB75C084F28391CD84C533D5D1A2F98069E5078
      D3025EEE1DEDA34DEABC3E21BCE8FD7C284F3E6B5C151B48F68D17E2B417AB46
      24B71668CC94EFA272F9FDF0A566BF5BE94FB84745CECD7EF760A99FCBD2F955
      20BA0208F952AE3C750B2F62317222395FCC8B0C34CA423C91F47DD136564DE2
      F8BA1E909D5AC25A847E0EFD404EB567CE4CA40EA2605A01B9405D2706BB0908
      9278DD8DD65C27F870D93484AB193D533C074846FAFB7B1832C4C5419271D06C
      75D48199D9560C2050A359BC577DBD5CC322E38B57A94670E64AF9F553E49BD0
      08D7BA2DD72D947DFA85DDE85C3EE5575B9E64B1FAA7FA9BAABF3A3C3C3C2C78
      0599858F19026C5F57D911AAFB4CD4DEFF387ABD5F9295C64B8AF7987A3CADCB
      E7EFB829CF43566D938D7101C1393AF8E9E0D8F1E68B875B6DA68D7A107269BF
      C93A44C2FB3EE6A1F74535BB50240F0D9C24D85D26097448C82B82E695C3D629
      47CAF571EF8B62196B3D808BC7D7216CE72A3192640AA8D9111DEC61185B06B0
      A17C950A9ED29AEA27419CC0178AA74C551413AAEB248C3D70B00A46EEEB7F11
      FBC55D5A558B314B1E264BC029FC9D96C8B24A28BAB111AE376683069C394788
      F55BC8CCA5D71B5DFDF7B084032A111C823328516D43043112D7A45EDF39FA0F
      342C8B4E498ACEB026BB8304A5E3CD136D2F84386AEFF0E0E0D5D17E598E2819
      1E0BBA41C7BFF231641499EC3758FDA1905300299B4791313E3A5A41E4373D0F
      8D87601B938207856650EC6832449B7948815DD770C41C595F685B5F0CE01BBD
      A0977BD1CBB9CC4D7EC72042C055F073AD5286B38656D1D2CC81BAD0B38BC5C5
      85E0F571D431DB64F65F6089696ACB2924F3F572B71AC468CFDB623790C0CFB5
      A25CA88EB3B05433F63DD635F5DB61E3B723D2278B3859CEA9022F842AA6A808
      0E32B3B0D73D0416950E9773DDF8D01ED48A8E75C30FCD7667F0DBC52512D5A3
      EEC559F927518D8D47EE245F1AEA269AE8991F87212E304A456F559310CD7BFF
      0A7050E140BBAD27702C0BD86DCD2860E9967E29AA9B6819A4DF0DB284543474
      70EDC66AF4EB7DACF25FD407284C08A682231A24EFCCF95DF2BED0F01930CDE4
      04302378219C779ACFA05C5958A241947D11740FC6F20424825088577C8214ED
      647EDD43B8045AB5FCB2A3E9B445FDFF85CD6DBA2E38251308EB425C4C7425D0
      85FEB2D74144D99A9211DF55061434FB5F5497F9DD777EE815772DA040BCEA63
      8D8268C6C24523FDB53475D240523C4E46CB75B0940BC6328605209AD4171236
      882C9A0D57D4519AC4CBB58D3BAC4523DADD271220A4DE8BD60F96BBBCA0E434
      8EBB3D3090B268B95C46E553BB2227944802FC2D4AA1CF05B7E178AE7C5F5D04
      E797ED8BD8375F546B0E647C41527F110C60609C5FB68B5E1817016342E4776E
      A3DA2B5E584C5F8487426AC76109417696D9334E26BA0558611D7990E4EB1455
      EDC5C51075CCF81A6F5D27B52AB164D806BD619BE5080DCE67F0C1C4DA63F08D
      9F892122AD5BEBB5744AB258F5861F8C5EFE116D27B0EFF7D1C7BEB3F4CB4C99
      9F320D33EF536994D9CCA487E0D37BF94A3F89398FCD5F94D585704C15B56694
      2F67318FCC0FDD211E782FD16D99A8D99BE2EF7E0E4C41C15FE468BE563A9B70
      4E9E685F4A425DE90D883F111D1A1712918926ACEE12ED088AE90A3B3DF0DE6E
      E116D1C196359EACC7B2C859BAA87BF16242897A72DD5EFEF5A5DAAB904BDB24
      FF5D731CECA37007E99E48B5E9021E50C3228C887B7B8A4E373B4D3F5D864156
      0C615F86C062BF1BB557A7BFBFBB506727FB8071C57E4E7406510EA6C66A2F8B
      A2728CD8CD1094073C16C6F14E478C554EA57A5FCAC76F8075A3AE1214864E31
      65921020CAB3D13BB7953159D5DAE1B264A270F1201E59D3495D79414743A1FF
      A5F093498F77127446427224BB2F0752EFB3E1654053C2924B9DD960681D5ED6
      7F7FC9AE09119C50D3742205D99EE65EFDF777BF87C1E47F85BFBFC6FF4FF7DF
      AB781194E843FA94B0970A338A80E19CD325143BE7582A05EB84B887AB719689
      A973B8C6318C4061735D3479C5C502EDBE4F863BAD38EF9A56531DA686BA8048
      D31CB557484FF7645098235785381E9E2C9B6BA576A16176EF50B07CC20E05A3
      391815112A3316E6412C856926232626345464804086B42E787B78F8D7A27701
      49BC23FA45C9BCFC8792FC2398500669BC2460D13EC981DEF9CBD1F1DB1F4023
      A7883701ED264C64D2B4A6FE72F4EAED4F8414AC4460C1578C3FBD7EF556F9C6
      C08E5DA2850BE2121476D041E85CD6D103A1F3CD46699A455108AC18FE4B91BF
      B5556AE0676D540B0A9EAC2C5CE2A96432171CEDE0C6ADD65CD5D5E9D9D9B071
      7A76D66C9C9E8D862458B8376FB816F1E6D80CE4F2ED0FEF844B0BF289A2A9A7
      DDE1070B022C17AA566082303F847BD28C659298706E42DEA62ADFA10C192A2B
      423F8BE40E08A766B509F72EB43CAA9C96B3D8B45A8529121C7F52C1BD13220B
      3BFDEE9E5E778538A9315E5D59BC3A1A8E78F864C17C6FF12EC16299C43794DA
      713416102E7E27B4BDF6E0D2F5FF6710EA1BB577F4437D12D8D262FBDAD44B5E
      9D0C2D00E93FD4D1ABC3725D3759E61D8BEDA593A4BCA15FD090D8A2D7B2E9C9
      67C37DA620DB888EEED6D51AED9B84447BE499776AB834C6CFA98B1B127E7152
      C07F857EE8C9F9EB37C8E6378156B41B7738ED6BEA639EC44196E691A992DA0B
      CEB5A5534FFB81DE60B9A7F38D6C9B0E2B5CF5CD249B2F62347B1F32C9FD67EA
      0482D26D01FD531CF5CF20B067695FC7C5A6F66822F599D2B1B09985F6D67104
      680D54B35B9581566DF112412F69584E2DBF44AF9018B30C6544864F16B24F7C
      ED75620172149EACA30055B25AAA527820FDD52832B6B45C59763AC4A10C85C6
      34DE3A62B65A6661735D941FB028B0EF4ED6404A5C42F4E1C76E7BC310451C97
      9C1931E5DD529CDFC0CE8EF43553F4C0F032B748303239B670D593CC3A33D9D6
      449DC6EA233BFAF2B4A30E0F8F5ED2A1B71441704FF1AEBFF21FBF50E0FDE5E1
      8FFCA997BF1EFEF8E5A5D3909F806888B251FCC1DCE2CCCD12D4C990D113AEB9
      B52E25F10B460346373BED6C757FF68B82C7CC24080731031918A1B24C6C23B2
      E8A7C4211C582DC56BBF887DA2BB78B2699CA3B3600FE6BD9FC44B1FF05C8A3F
      8B6B58F5ACA578C7A2E371EA31F70009366738D47D73CAD64B201540089A69F8
      75A0DFE31EBC4F3206050A41C04245FC595CA913974AFEBDCC78F348CE0235D8
      6518206AAF88F7269BC7798A6F51D779CACE60C615724B576001598DF8CFE08B
      B5C9995419179B82F8419AA22B044139221D72BA82FAB4978CEDE270EC3087C1
      17F5731E78D72835608243DE1C3E1CECE07E6A0F5E6EA4E4EFA4DD2F25B90E5D
      923907AE5133F0659B0A60A374151E296D6919D7F312E035ABAA966EF5DC84C4
      362BED0A834CC5B96B826EB396FB0BE01E108207C2F8449C4921909844A3C438
      2912692845D34C8A5A56A3916895EF3CD97CCAB62D074032D9BA8472F13AB7C6
      CB6DD0967E5DF2ED0CF3495DD05D046D2288CE5374A678F41B0D4F8FBE085061
      23E97E12E6A6FFA43EC2C6C5E3E634C46749AD4126062D635567D8C7452B87DC
      295C580438A996ACAF33B7F0374718EA5413542A30A063AB3CBCC4692B2CA2CC
      2E6929F1E13BDC45977EF7E8BEAFDAD69D6A7CA8F2947238EA6AD0199E5BAAD1
      EA56D2AF237FA3607AA7A9F459486F76C4D8A01D8E36295BDD76519C956F3B2A
      8F06A9C75E5E5CDE7750CAD2986958592DBAB3646E5135A26A9B44C01CFFE7B3
      254A0A136C10CCD163EBFB37C9378626DBED46107D1D9177F1B9043C2E8ED065
      92489A8933BC46AD84772211D81EA690A90DFB5EC44E03FCDEB9A11AF4C62811
      EB6E35074F1DF7CD851D5D90B431016CDAB073765BE92D552980A30A7E185D5E
      4995B34B41BAD3AD30A779D56D5C34AF980AD147BC1E0D7DEFE78AAA15F1B109
      1508717D105AA823DFCD45006E31C1E168D4D8205E2841030D2EFEE098D72EDC
      20CD76FBA2D1BA3CB78C1D40B3F85DB490289B233D25F1611D5473A9B9360606
      0BDA73226EF6CC5C41B6D764996AAC0E78A78A5304494A2862B752C6B274830D
      CC928983F81E3FA28286982DBAC3A346AB3B3CFE2308C5569353C4DFA4A0D2AA
      37CADB70533642861162B184C3EC6680AC2627EBCC6C8C681937295597156DE1
      76F04499D84856BA220E1D1F76A16F509DD242C4C4529394952B73181DD106F4
      C1B5FE8F8CD6D5E4344FA200028CDABFA1BE8047DD8D74D23E5C7B6686C4EB53
      3CAC7D79F2770662A61B8ECA4E67B2152E3282D2F0FEA1B03E9EA23A70662419
      0AD490E3C3110408816329C96B2ECCAAFC6D198A46A4A0806B325E803A310B05
      E86E676994041A703F7B9CA82E9C4E125BAA77A1D90F3212BD729ACDE7D169A7
      0B095CB1953856FF07107075CECFC7E35F5AA467AC32DBCC063478CBAB18BD8A
      BB4BF16477E2C886B046CA19E8C551362738005D3366DC687D74536B979F2EB6
      8D25B784CEA0D39107D9C211F1538914A95225F63413FFDC1C0D64BC8A901679
      CC664CEFEE3CDC8AAD4E871FAC29F320F9DAB70EDFC09D5980DF7435195204D4
      C62D4A4E9A5FCE07E7CF4F0B46DC57C539BC9BBDAB3A915D80B352A386DCF8E1
      1C79F0A21B38D5F3B7E32843AF88DD0F03715C6E90CCDE9D1B6736E16876CECF
      89B8CCEDC28C88EB5CFA70A80F3A458D4C0632C3F3CB76053C2F7E357E49206E
      479F76D41C8DC742DD04FF65B3116D1C95686C47B1FA6150D6855FA233DA06B7
      2A7AB0C12F7774C8E496B26F9F2F6B140411B48D2DC193C816E2498EDB4FE4BA
      75E979115A0F12AE0DBD15B875D9602DE876810CD865280B268FF34A07185BEF
      64DF6F9701FA92DC1E01B492358A7A6CE9875409F0FAF193788D18773CEE7F6C
      8FC66322BF4CF2655690DBDD3D79C476808CDCA7FB2844BE73D4A24813FD9B1B
      8406EEA2395261E78BA4400A46976B63096DB869D50E13F8A5BC5F430003B358
      1D915A710BAA9CB521B0A54C75ABF094830BBB38BD504725591DE9257A26F2D4
      8E3640BF778F97BEEB532FDAB8FA9692E6A2D96346641B88645970865FC9A12E
      4AB159AFB9D9FA9757A3F178D8EFB41B5DDE543B0132D7ECE06EB09E4F838BF1
      B8C78F25AB866227BB2F55EBF2E4EFE3718B1F4C3C92BC20652E7E6B695C0DFA
      5F862D9CCCA2609B2ADDC9703D3C38441B9C389FCDD5D1E1C1A1DB65EA0C3E8E
      C7AB49DF24D7258F27D573DD1743701A03D413E37149404FAA054056A40437A8
      83684FB6882C20B5A487EDAEB146A2D0298E57C5C674EF5BD3D87CE6BD549F6B
      77DD052AAFF2E985F4642ACB92B98650F6BB87AE30DA782CB2DA0AF2FBFA0170
      DF8278855D2C3EFE54B3D8680F52BC7BBF68FC8180051F8B36916ED3B04F355A
      4BD85E2CD4A85A347566B256122CCC193A90958D489EE9BDCF4CD68DA67AB1BE
      873F39E57ED054BF8F94CC9DD9A24B5475B6CF3447E2731F801CAF1076557FA2
      1486C56AEDBC5FA7C3D1B0EACF50D8246D34930479E042A83FD91BA361D2783C
      386B0F4B057E8C441BDB509C1214E14F1461C20BAF23753EEAFCF26807EFF4F2
      D52EE6FA1D6B8F6F4893BA0C95167B296C770BB3C207198FEFF47480ABBDC152
      7BFF28CFC53B8E34D278DCBD68B5CA9B2C39F90BA0CAA56BB5E3C9EFFAA16946
      7AA1EAEA05F58B218CD90BF61FB98C877AE84CD68442744FC180DAB821210439
      71523B85E63496A8788702380C5078A8C7CCA09B569ADFE8547103B09D426F1D
      38DDAD277A2822C136A05331B7D2878CACE76066EE59B841B3F56150015C8BE3
      EAABBDB95E2E4D24E547E94A2F0928032A98FD5DA2177869EA7AB1077F1565E9
      A0B4131425DA42444118DAE6A33B51512EF492C1349681E022BFD6688C18FA44
      DAB58D93DC42ED7E3FD7B1DB29BBEADBE01EAC53C4730B7B75871CEC550F8C81
      2D9D99195A15714351CA39B8DB8920451C8F8717EDB60DDBDE31ACFF387EE8E6
      A0774912663C6E377BD4EC4E722D44C908E38A7469996681D7475A8453BFAF9F
      9F88F95E4E5401EDEF60D8FE2C6E6020A5E5A93BB33389A04A75081523157523
      95A29A67218B9DEBC4E76C7CF3AA7B5A2D43B145C44F3B6C21F48A4A0B6068BA
      579D467F345465F9E8067D6AB539CD93CEA67A512FBE322287290BF66EE76CDA
      D5853D3139F566A01AD4BBA18EE7A0DFB5B19D894E03EF1E32DE46958CD7CDF7
      AFD419559E6F815275AA4C21A019B1F812A384A3FAEE7CBB64C9625C0839B1F3
      DE9DB7464892F534B84A25DC0913644214F31CC8025539644CD17FDE31207A51
      F487433CA8D1B9BC1A54F2BCC2C051C041D945B968F62C8E47E10BE331295802
      338DC7BF1E7FE129321A3756088C8DC7CD6C11A74B2AFFBD62E29860F6042199
      F1B879DEB2F8AB7E1213F11100DDA05D88A7B0E4036B71B962D6C41194980B0D
      657CF54BF3FCAC828FFD839839EFD0CED505656B6BB39C4A2136135A2860DD2E
      A93E89E36BD536C2B8177F2DFEFE88719092B7F7D4FD21421FA4869E0E0DA708
      767926B52CF66335434E27F0A81E22B41C4BD0185C434A043D085F001CBC00D8
      8D4A7BA5BD98D3C8B87A098303297947B5EB44B9376A8E1C5779D06B2AA68EC2
      D43F1BE442D5300C8019754E4BFFBA59F3F7C5F96D2D354E6442A934910A1FF2
      3A88BA38658A80AF09ECDD0E08C9EE61B60E8D9099A6BBB018B5F2348B1772AB
      89680F240B5FB6B009963B8C04287F51D818209A3849BDB34EFC9538440051EF
      530D5A2A9D913DAA36981885CA7E2A56CB6280AEED24816FAFB49B312BD532E0
      2695A27EA7B9D8E4687D6B37AACB5EAC0A6D48B94FD614DA85AA96D8B80DBACE
      93BCA1E620D55FBD2E0DAE3F89E7F16DE3E8E04736BE8975A56858A312CBE4B8
      031CF66BC5C585C1EBD676E5C480806D23B2BC51ADCC4C266E62AB178094AD28
      DCB72E1B0ABFD04886566AABFED9691C1CF00AEF24B1573A3DC85AB9457D5CF9
      54A7E7313ADE57F1248DC917FBD6F3BE750860BB310B135748256986AA47C6EA
      42AB2FC560C201741F02F974211106F82C9FD477E079BECB79E8B496054F22E3
      7138F1D2607CC14339CD6F3C96277732E47463E36468714696A82D44E4298E6C
      7E9007FFBAABFEC8E10A4E3A2E936094EA9E94914DC05AD75E477A1178F683FB
      3B0C579068853198800C795126A3F247A8EBAFC741BFF17822F9432E2C0CF5AD
      AC0D5B57540C21549360AFDC2EDAFFBE1728E82B29D32564B204527D22C2D527
      3991DCEDAE0C405CAEA2DF3A8B2043DFA79B9E5EFE4647EBB753FD35BABF4749
      13214C3A19FEF2400CF051724EF56276B199788E8863B788629DAD350AD250B1
      4A793E76B8A5A7C12D083E290501A7A6A011AF9C0C8685C69112B2DCBE0EA1DB
      A8414EE0D86CEA34B8E5CD2D1AEBD5BFFA7A15B9446269C7F7DD50C9CC41F95B
      136CAD158860510E07D8D36F58A127A5B8AC6F5D706694969136AE3B1FCD47DB
      5D965F6728D4C33BD9C8554E9E2F92A2F2B7A979C8F4A8B2FA6C47014B0E1037
      497B1167E61DB18DA5E4961594F6F1741A304F481C87293310AC95462FC1E99A
      3B8991EAE1C676DACB721DF214D32C660A39C3CCB5F83B969962F5C2494524BF
      D492C669D6986FE7ACD7E8504B399479D124D0FC28204B08CDA3BEA740B8D251
      8ED9BF1D99AB40225B609647ABC0F743F381DD5E547B8395A3C0FC11F8F7DAA8
      4F5D386D314A16D04D69B9341A128D12AFA15B9E552A9DA96E2B04B16230CD36
      D0B9D4E983A248DC7D04B976788912A3761B1459246EF4B0223A4E856EC08D56
      1C0A9F3FB9D6648EEC5036644B6AD955D1244682A97A611995FD179451669CDA
      0E00C9424BBE10FF1857F1531419D49E23D8DB87FDCF858503334D5FECC80B65
      16CB38D14980F08FF41E80C0C429261631263840C2B4D16C0D3A14875D1653D8
      C5191C767EE62513620B4800D4EAE3303F4DF1BF10EA53956AFBFC64D0A0A242
      6118E0BA3277E4A330ABA26F7618AFD4C134FFBDEC9144BDAE0AD2C7BD741E2C
      ABBF207FF4C4647393FADA3191D23D950BCF39864FA949C4353C567F5347AF8E
      8B70CF1E8C56B4EF5A2BE499CC560FE44747E52FDB0D8A0094089EAFF4A2717A
      FC954ED0D359CC429C7ADBE699A94ADDDDB3A62509C243B339A22314C7446241
      ADF0AF6C6ED6A438FCF87BA4F76339B6881C51F848C4E0253257F97611187BE7
      26314A062FA7EF5749BF9C1E20AC6D0B0AB9F00991C08BDB41DBEE7EB7F7AF49
      BC43A39AD25471FABACD77BAE9A64D78859BA0B13C6A6EC96ECBFCB25792A839
      62595054B7FB6300AF02754FC116EEF618C609168070D0173BB24113AEF1ABF3
      7162568DFFF3BB69EA5403F13F5452ED6007FEE5E8F5F11B64C46CCEFF4EF166
      7A50B01C2E347A381B5B27B8C5B5FA5893788334A635E80094229E7751E0086E
      C914192336D7431E975AE6F8F893F234758504EE92A99D28D6D926F2AB3E37E2
      D8617698180079E3B1FA65740EE481F57A74AA4673249FD4B9B931E16E631098
      1C63349B6750CD64505B6B40ABB34F68E86ED91F348AF7BC39A9A4285E95BB22
      31AD339335000BA58A564663C2F0621A203C4A18F01CA74CA442C39CFAA0C145
      ED6B84B5A3E14A2F51E9FC5B9155A7A8012659DC3482943B2FD42649C317EE6C
      6933CA1A3DBD1153D14BE943CEF5F9E81199C584A0ABC1099EA14E8EC31665B3
      A1E267A9E172F3F07E6D9E9F7FD96464808D250B5FD23164B165FAB22D460B5C
      D8C1530DFC99488A200EA8E4C532E107993D24148C94CCCADCA89B00D5E17142
      A6C60D2A2499848080183BCD6AD06936A89A613CE68EE5850548F7A68CBD7027
      4710254AB7B5CD226D65B88C9342089693A8D1FAB8D3ECE0FF79894EE712E421
      AF9718316D581ACDED13E5CD83D04F4CE436D627C80D6E9EE5ABCB1B93840CB3
      93750050794E34822877E4F617B67E708701F95E08A18CDC0BDAE62C9EA12150
      D19289513E381016C8E61697B10C52A7546D4BCE2EE37DB81D22705AF85DD9EA
      94E859C3B064AA4FEF70DC1FEC36133045821B3A4D89768C5A24A2CD54ACCE06
      9FFA6A6E38AE1644056326D55768C67B65712CAD8DD9FA476B3C40FF1132DA7D
      62D45146A7EA7382F849252F48203BDC0DE32B34874DD5EE5645F478ABA268A9
      3830C27E2649C587DC143E6C36FB080C11316DDD7914AE14E41CC261E00FB4C4
      14C511286959493552EE4D7B70B85954057778DDFF38FBE8E80FB68F242446F4
      E4725D2987C5C11D26BDA2D36238746105163A59DE3AEA920261D568F6BB3C32
      1187580DC2802DDB84F8642D78FC0CF09FACC2EF6B3BA5EE6264F0A1EA9C0E7A
      A4A53B9783AEA032E06F232042E159201769AC1D862A8D967673743C1E538327
      2561502EA661D805F76BE404082D7D841C99B38EBC7770791D4A002831AF14EC
      2B4EC94120892DF864A336C763AB98DA868B2B50E287AEC174B288C3E60906B5
      5A7010AF528459F3056ADA440C735ACCCEEAEB5B00C4CB697F54AD203D509FE9
      60AC2055C0A3B3D2042D455FEC200DF584A4293877017C84F809808A08A9E45B
      A3EE8F6FEE81B36C38FEE37DA7575F04ABB2E1CABA3B225FA848002588146067
      1C5F89D24C777972EBFC72F44C4F86E3381E23AAF94F947070E0963AF0A09116
      0D453DD66DF2E26BCC15DFE30F32021D4C2E74C6C8372C21CDBBFB82F27CB883
      F4FC66EB62E7E7DFDBB9E379F6FCEB43359FE110BCF9C26D97CB7A69F80B3D9D
      A2F9186A5A5C5FE2F517D56D9FDB4AFF3E40DE544BB2C82516616EBD3027787B
      B59A9D2210253B27552C5BFE9C5DA67271666994FAA3C1C5D7F0D3DFF750396D
      D405AEFF79F0440FBD0FF6AD5613DB40938EF487F391EB10384BFDF37FD8F2B8
      2636E6041B437A79178BE3190E282BDBCB93BF4348B5BAA71F378348DD8823A2
      16FD8A18C1CA79F969B00AABEAA8DF6DD5B8569C624092152144F62E7AFCF3E0
      BC4DEFC3A5551DDC03B47C4072AA443D91531DC5803540A397950E92E57C3213
      75B660A42ADC09DCC219B7F25E4D1024C03E7E7F85C1D77BD56CB93EDF308DF7
      B4C18FEF5497E9CDFF1707DFDE2B1DF007DED91E09F2977DFA68C93CAE3C1D21
      0C48C5BF859DBDD041F40D63FB4E26499C72791E710750E1B20450F9AFC5C3D0
      2A42DB661942492B1819864350B802DFC1ADFBE6D0E2287C6DF068B3534475F0
      071FFD8F38A7672ED0540DD61E42BE0F7EA3730B44C8366DF3E6676E74F2D09F
      694755B1A5EF1FFA6C623CA5D4D69E3EF88D13B3DD03E5FEE1FF26BD4E9036DD
      7BC93CE107265DBCDCFFE684DEFDED6BA7959E5D53FFE390FFEFF4099EF5D23E
      6BA789555FF0F1CF34D1F65ABB444F167F5E4EE6E850D5ADCAFBB4558549071E
      9598E8BA3355A766A28ED5F1E1F19B02297F78707C70F4F6F0AD2349D05F8E5E
      1F62FC522836FBDDA792D965D1E699A9D0029F994C6A1C84CE82E2C2D4573131
      691C02E42DBD54280BA25182CFDA14ED1C5DD5DAF604099821C8238E5D895D97
      42E0651B8D40A5AF4901464158268AC10AC184464FA6E64A2056D3B764F9DDA9
      E5CEDC024415D3A63EE824DBE9052490045664C4EAA8550FBF92FF35D7FE9BC7
      E4D54F3FE298166999F1F8E7F6A7BE044BC828E03E34470747AF0FDEBE761E05
      7DB5BEEEF9BACFFED5B79CF7A7F6DE29FBB019E49D6B5FBD282CE7172A915009
      6D1F95648AD2F4C8CC2D030A14C678A26C2CFAC41489A4D3E286B231F9AA28C9
      BA3C197654F1E75D86035388242756134B4446AF8C814214BC26C1D77BBA3CD2
      11253FAEE220C263D8F181A846AF58F294B22272ACA9428D7A4DA297439B856C
      085BC58EC30AE72451A9E54B8240A399069F0B7798BA85F6BEFEA24ECF2F2917
      DD3FED22176D0B7598B4921B012C54B08BBBBE95C795957CA8FF81EDFEEBAA46
      5FFD84F09CF4C321E6BBE6A87971B709EA1FE126586DB7A745CF916D28FFDE7F
      57B4A703ECBEF29D0DA578EF77DF2B9DA2EB877D44F9AC7B3C08ACA8D022598B
      7B0A2B5C52090700054E739BF90AA259AAC2E01A141772DEA5D08575AE24DCBF
      61793FA8BEB6FDA4F74A5F4330BE53A321BD057E78AFF404F748BEFC4E4DE298
      F86AFFA646498EEF4C86A4CCAA7F3945A7E5FDED45B8575592AAC2D22CD1CBDB
      AF0E5D13C549711FD198D0A7A0917F9CE27FC46A3CFB22609FEE19F8A15D48F9
      23F8097AC71EAA5D664149D68931113A233264193BC2B4B8F6D3D6C292369ED5
      C1B8F3893CFF6077FBFEFA4FB3EF5FFDF85A4C9A375F98D4C57FF6D401C56CAA
      AD9687D7B0203CE13E727A66B77579B1F1CC2E4885C841A548BC86F8007E9858
      BDDD02F0A02AA59CD8780C8ADA2A1ECA9E198C2CC126CBBBE1BA316FDF3E6C13
      EE60F751F0ACD4AC0543C8C892A36C12FAED32125386DB913628FA44689B72A9
      EEA02F4A79D8FA98EE14AC259D2B346E807B873740310379E31C66969CC2C5E5
      A853E196CD97951BB44BA272D8FFBBA4796DD7EF6F32DF3FFAC1E3F12958CC0A
      D30ACE26E01396D46EA7D02C2CF503CFF3A4DC6407628F32D43B1E5F347B6FB7
      1A8C6275765988CE29D86F3688732BC1766B59EF32733EFD9F87E7C3C6E7E179
      FB091E09CE9FF198987E4ADB1F008932FFB353E0FEACFADC6E34435B1296663B
      3E5AAE897D346AE8767FE83F2F2F2BB4DD8C182C5A864C98EEE009AE4CB34724
      EDEC50DD256FAA914687EFC368CEA2EB4B399F5D767C70F9F76270ECF40E4E16
      BFCDE92976C256D8E0BA82520411A41D9E8A4225DBF7AA2C0CBC31F3C07B1229
      20ECFF6D92E0021C2500320085049A7D88B4EB51438C3A03225DA36A238B3551
      3DBD569AE202DFC0683C2E518C32AE8202953B048FD6CB789710064815B1A184
      14CC027F5DFF1A4DF9E3A6D8ED9D0D1BBDE60839BCD2EE28F4D04E8FE6CC2029
      622B0A76945C5CCBD64F62D10E5CC7867ABC1CB5655362B3909C20F0DF9189F3
      345C53792D9DFC219A19AABF121E496ADC888A6077B3FE5F7F9E59FFF655C1E2
      53311D256AB3ABE9082147BAED3E5F01D9A0D4F297D6C865B0D7078D7C76BB43
      3487CB5304785BE7C37F8EC757DD21623756E4C25464C258C1768DC7407A59BA
      EECD7688A22008F70AA870AC5D81F785B6C7B4DA2081BE4FD33B9DA1E04F3A43
      521A406AEC365F92AC9D24F1B5E144295A97937725EC7C9875D13AD0F9D07E0D
      C3765FA3DBEF943CE8E13D1E7758EE163D45F330549D285F3C592C915A856F78
      031C98A53CF9E382896E11CC1EDAB8E22A746E11C520FC7E70BBABEB76E782AB
      BA1858DF77C19D8EFEFC4F3AFAB6198F45934B16294ED4C2F841BED8A9F1B4F4
      495444C0692107E07F9C22E1370D6EDD92482C829EFEF680CE743C3E6F755ADF
      08563FF6813010CF4C065C4C3FD46BEE8F27EE172761C1FF3C6A374B7A5D4765
      81006BF3AAD70768192E4C015FC408CDAB1EEB315B02C59C0E16B5699D067C0E
      44C3698642BB78CAEC1CCDAB9EDB26517EC376FA405BB9D178FCF98C7A1F0D21
      99DCBBD24B9CE3E90F40E977708EB9757276F14EB574A26F74C450911D7C077E
      3A9A2571EEBD37F88CE58784FC37B57A49513107631C442B6E450C646377D3BE
      60CF7A2634A69965DABBA679DF43E37CB0C3BB9C99EC5C47B35CCF4C4D75D30B
      739BB5C26079AE53E02FB31ACC93A81B5D2697797639EDC72B933493459C7CD0
      A900EFF0355C0D9374A3139366277910FA2DBD58D6A8354BDA8D3AB74BD45606
      A048EFA6B217CD1B1D84089AB113DA4D3F219EDE0CB3569EDC9891D4FBDD61AC
      DEE155EFBE1D1130ADB91D89DB229E1F019A673B311DD5D4F971F517C73575FE
      AAFA8B576E6C85B10F461E62D946D966C19F199A6896CD690183A90AA0979883
      8BFEA9A53DC12EE7A30BFEAD814E88C0C3B2FD63E86BDEFD7497870B5B2C6480
      D2385552FC99AD777E289E5953CDC52246C7EC7C4172BB46D58473A3B95BA7FD
      61A033F36929A5AD95DFB551BCB6327A19477662AE6C5D3C356E0705713EE85D
      3A3DA7D33F3DB69939AD3C5C1595D15D09186688A0020E1CF584DB61AA5662B2
      58C3539DD1223FBC7D06393F5CE6CC617235EAFC22DCE1029DA9D027FB314AE1
      AD6114B8D60B93B17225B12122C09270CB0E986F6E893EB1B636A95268ECE679
      EBC378DCEE0C476A19A7B450073B0C8346399249A03AA0B2E72A2515B7321CCE
      18E38AB7ED3F5508861ED9CF33717C1B84750083009DF782538FCAB185D08626
      50E9DDE451630E4C69270FDEB251CB532B9665A5EF894505A7738DDC50E54329
      A0630B3B653820B4F6F2DD9D1051CD8BF646C0C476D690C8496360A61A3DF06A
      3C834D67889D648E2AF0BA125193EB3D7F035418C94F9D87EC3024323CD9A8E0
      A9F073CA95C14FB71E456C774916AE50F58EB5DC125AA980E7B9E799D3D3C4F3
      6E7013615F218AC38A02911CC77CF2A6B35DBD2F8454457498F8C66AAAF7A13D
      AA5100A92643530069DB31771710EC94938BCE9E393580F90CF960F1742F86D7
      41F4A2F43238BDB95350994AA8A8ED5AEBC380A19A57411AE05A131183ED3A8D
      72F89DC6291EFF0BE8EEBF15B97D842A036C932D7422FA0A220253F6621F6144
      1544C1EE6184D99F178525421BD67667FDCBB3C659FFF2B4D208364E88440265
      AE6B4B87E03C14415309A2572166249990C536C6D959065E41E605C436533CD1
      A25D9999B61063E9EA28B17390137F95ADE51133C31E539BE8624696F80342DE
      147D1B445E118570456A6D6460BE1D42FEF6845E0152CE00EB02EEEAAB93B565
      A780F583EA96D51C09EC7FE781770DC815F14D62DF6CC9AFF3F847C556D96E92
      8877901D44709879BCBA9C4ED5CDD1C18FAEB8F957AF9E23962A5D1D07A353BA
      6E7CDBFCD81324BAB9CD4AB1E6494A3D434F0805A2BA604187CE1261C0858D1D
      7D2902CEA994A84A9427441608521016399EA406863CF261CBC44C83DB469A4F
      C106A47DBF217D71D09AD2A48E11FF7E12DFA0A179157847D948A2D0C75B5A44
      9F58D23B6A942FF6CA08E171D190F745D3F7E3487523DFDCBE2878186C186B62
      14718FE8C52498E530E874AA5E0840A9152F2641C41D8FF9FB3B5ADF1629CD3E
      53E9E0C1A8943B5BB06521EC96139C972E5D1C1143D20EDE04761709886E5B85
      717C9D2FC5AB87BC71BE43CFE1683D70F1FFDEEDABF30B757135EC48171075F3
      E6E8C0B15542A10CB6466946731AE1E6E8E0D5C1D193BF433C8FA2F5591E643A
      51376F0E0EDFEE30C299C92838D61C3443C8176F1E051E016019AB0908196233
      6621E57D3522BA8FD11008A5F670C02220FBA9207AD0BBDCC55FB5D023CE759D
      A2094BC3725610B198B3EE7E03855020BADF9154B537BC9902955522B1416138
      238615FE7B0A3AAA3B4828274369FA7843C91A0EAFD5C599133D8F4EBC39CAD6
      37D9B734D3EA99DB2C012706451F6EDED2EF6E7E5427CD63CEEEFF690C3CAF0E
      5F3F8744189E7EA16C80AA5380513AECDA7EBB95EC833494AB29F7712E7B97C0
      7E425CD232131C424548847A738D6587FE62701DB7823351CE1D0376C0D7947A
      6CD83F6BDBFE78F29EFA815775DE285BA9F5E66AC05797FFAD4EB4778D430862
      9FE1B9B08E096F380321C9360147188E2C25E55070427470CE26DFE1DBCD1BCE
      2ECF42A37FD0C391F8473CFBA7C29CBCE8B7147ACC250FE77FBFFDCCA30215DE
      180E3BAC452E2769A63D4B139EC5AA7D7939A851F2A6A646834EC779B062AFB8
      00A8087910E57579C99C9FFF63E5F938835797C4A4093B5BBC0D220AA04CFD6C
      52A0932BC475CE0EEE116F0E0D7B17C32D8C871ECC316220E3DFBBBB5A52ACFB
      EA0B6AB2D85B91D3BDBD7E4E1AC2FFF35CE943729A20C12CC74AEF9C9237287A
      4B022F539FC0C23142A4A5E0FBCB4C8236A3A15A9828776FBA8BE18FB786B7D8
      C3D35FFAED02DF11F9AAF769386AF486A3D332DFEC3C26E27F1C97945ABECCE8
      85BA6A9F22A56D4B6E113321C189C61D74B8B8EF2326280AD7F83B15AF1DFFF4
      7A537A0D8CF4ABB07C1E211AA72E41D6E58BA5BFB3583BE65ADB07BCE44F7DF5
      3FADAFEC3CC8AB3B72CE864E36C2346DE2BACB8DBA0ACCEAD177A0DCAF3EEFD7
      432692C5E332612DB5F3C406CF8D3C260C26E875206513B6EBE4E3365EF98168
      3832A9E881150EB287A645B6348A9B2B9D349779E2CDE98E65F324CE67F2A607
      407583DF35C9BC5CCAA6F80B8CA091C43EBF0E893B94E4C83C84165687A1B941
      3F9287E6B48851E7EA7184C12B583B5950510460AA0374615121D2C4C8ECD170
      94D225D266CE6E695024D925ACA1123DA01A44F1B56D128C115CB320CDB68A93
      EE703D50F7A127403E798F97B33062CADD8667423415EA6AF0D054292ACC9E38
      DB4518BB66739EB2221CAB96A7D14072465FA8E1C761472DD9450D5239AF4083
      F14B6890199382439B82CA14FF34CBFDF8EDD64D179922702C06CF5532070D7B
      FD9DC7A36A958BAB77F74BAFC8AC900726479CD7D1FDCD7EBAF7CD2EA753D456
      B531A2EBA37F3CBCF7D1167CA1CE5B9D7EA3D9EAF4DD4738AE8E5023FBCF8EA2
      233FF5F4D2B83FFCD5A6DEAA30126F9ADEEE23903F18A49E094371A5A4CB322C
      AFDD4EEC8F923CF8427606D18B9510B63812D6CA4D768B9F0EDE1CB9BFCC0FF2
      3252CBF2895D30C9D9A5EFA950815C975D58E488E28C5C08FBFC9F54FD3FD407
      9DAAA197874B3EB23B0C405E03378BB423BCA9958330B4AAD0E835D5D7484234
      91564DCB4230CF4426B57472A7677D62DF53FFA9FADABBAE77237737989CE056
      EB52FD4258E4FF50AD384E7C0462C51FC06CA4A158EBE3CB54DD0429FA84857A
      8D880BDD959AB24FA2EDA282389296CE5B0F69F56BF58EFFD23A6F51AD6CE7FC
      DCD9BADA121F5C6B278901C74BB7C77DB1D8BEF78314B7615FD5556AF12B880C
      A658B598ADA27477753CF90E756C03074237362032D0522D1355860EA90FF71D
      97ECEB06E1FD8FDD3B3C3CAABF3D3D45413B9A7D72AFB2A2A8FABE010B9E710A
      896A2B442C5F135A021FBC3DFA06991ACCC638B94E95B9D56455E2AC5A8EBFFB
      A7BAD117B8081ED224B6A6707470B86D251CBFDE5EEEE31F79B9BBE80086D4F6
      43136662FB4A03F84D42A54A57E7236B862269951A2A129E98CD4FC802D6540C
      08CB2AA08E4C303FC9F09C1889054B48215917C14DC934C2CC04DE3B41FE08E1
      EB0DD64E6D978D263BD568E54D980E2C71B1B45BDBFFFD5695EB8D7EBD656B2C
      C099028CF806EA82533FF036E26461174FAF74E2EA7E1FBF819E1DD0CDE7CEC2
      D2994F5D7C3A3F47B747E6262F3A315A6A2064105A49B0306771E85F0531F81A
      1AD5DF6DFC701147101BAEBDE1FE7274FC03241E519A5ECA16731C497C632495
      A9991FEC0558DBBFE034FCA300A6E10DEC9DAA47FFEFEBC39F7E70664E3BFE01
      EA7C38ECE0E6FFF09A25D91DE9F8A43298B86EED104135E947DC69C0C5C15F88
      2CE69E8E31B7FD954B1347EAD5F124C89E745A5E1C4D434488D24C67798A4546
      D8B738A5E071CFC8F52B082D8BBCED934E848CB9FE392AB807DA0F782AC57250
      D129A3A28896954B432A21F10720A88E13BA840962AF0CC00E1F5816A32D42B8
      D2EBB420DC22FC333721278CB7DB34A6546A39C18BDE9810CB5F2C4B596F268D
      0EB790814CCAE5512768266A67EB7AA3F04C1D1DFC78F0E32BC73BF395E98D56
      13383CA174AEFD40509AC49EA28C7A30D5533D354F3928B5A1AA804DD48290DD
      185176A6D23CE7CE01E71D8DF44D3063472D4B8C41A2FD29A7F862BBD9FB0B9C
      2EAD22207CB84D02CC12DBBA862349DC2899672D7FA8C93A16657241969A70FA
      689DF614E181238A36DA16B0E02331203D6285AB4E8FE9F051E6D5225708E820
      780B77755AB878E4945248FB5BEC218F782A03AE8AA67000B43FCC1AF358C55F
      D45A7F512B9DD05AE8094C39DB1F948897899EC979A437C59A547804A8347FD7
      90CC9B9F0A196C62E46F19CD4EAD34910A22264DD1095E6270BBB8C0A01906E8
      DAF0F4BA80ADF5FEA03DC4E0C4F45091788FBE018FB2829BD15A75863DEE908B
      C6AEE84E1D780131709A5BFEF7BEA555E6FB5BF473B1062BF1BC66D277B7345D
      1191C65DAFE403C81B4935E2A793B538530B80C726C453487F20A8329B021C76
      B43F915E5A25419699085F2F78C3C598B40D348A7EA4B0A3AD67E3091C78B256
      3F375B07EA5407A1F48EF6011C570BA3A14EA4792A87860D1A95890D1FCC22DB
      1EBB30D4E9D341A90F29EA82693EDEF6EE73EF1432F0AD73F7D0866D97A10AB7
      54F18CB4F4FAB09524898CEFD687D572DE507D13D91F1BB38509CBABC23D4CB6
      F40DC2BF94687BA0B8E21B130043F7C690B61775C53862B6409E9E9629F3E7A0
      77C2B0780BDAAC6F16A938CD08A62C293270881B6AFE53F86FDC518A8E09A80A
      8119D5D3F2DCB94D6368B2221174773A745E05D08815285B74A03504D8EC70F1
      E2A4DB761BBD30431E1CBE6C275F19BFA0EE9A07B339A4E88D20D2D9F976DF94
      3A41777BFADAD8092D75A217388335915B45D22A8559BF8EF34ABF64FC54B44B
      AEF12B10EE03D282E1ABC9B5EA8E00D8AF1C27A911DBBC80D209D3264E50D107
      8D322973471303C4232D4E51A5725F2BBF87821C9F59D53E1C934100666AB235
      616748446D4E3580F699520C82FB7499DBACB0146DB94F4514926FC29DF9F208
      3E0154449CF01527F80E57E7D8D4F796C46073B574FA44BE4E726198CB23738B
      568BB444730DE9BE75249C2275FAFB010A8ED6C4E1F1DB223F3DEA0C5B61B080
      C1D08BE1AA34541FF95175CEE5A4EC9B9053A9A5A60EAB0E2AF9AAFBE76C9B21
      E8D0B23299002D1C75805D9D986962D23993EB15BDDB682E7522DA73C6B61CBF
      46EEE6ECE4B4576DE58574531DF8682A3B55C3B931CED194D7AFACA1048AA3F1
      F8F35573301E334B00321551A3A71993F9873A0B957909AE11550964C1173D5F
      9D1FFDDA3E5A787D7D6E2D74C71FDEFDAE3CFEAADC4FECB26D5F52325DAB451C
      5139800E95994E89E17D4A76940297FF3CCE1382AC2E8CDAAB747FDFAF291D22
      32465150DC0E69D3098979A7D93C70F62681C4A2206CF98938496BD4A4B188D9
      42EE176662D5942A5E0A3A209B935347CE1DB5C6DD02EC6F8BDB18A64F92C972
      6E84208A4E9235CAE4E055EAE9F4A85452B0B7B9164CDE934C84E1E9119E7560
      6ECD7784BFC544DC6EDDBAFD803B3B7B2C876360C200CD7F60C730E23C3DC86E
      1F344B65A2B52A4B362D600038F67299C45A7A434BF945A5E38FA8DB34CED1A1
      956D7E31728BAEB3A081E65EC8D6A02F4991CB191210F8E0D1EFD985F14ACEE9
      C8A419425D47D480A0F8E9507518BDF1D0AB7FFDCB5800D1A5C54968E569162F
      0E8228B0CD0F383FE0076962663A81E498ACED7AB278B6963475142053C62E42
      16DBB5825D49ABF5F87302F3A0BB58E03EB185504CF265CA25687772AEDBBB5E
      9C6F897B51215088D2CAF71C1C5C203E72630ED45970039704FDC083DF4D8D8D
      31ACCC0FAFEB1374042F734D7C7D605A49815AE18FDD6D71FBD0F69E2230591F
      A1C06868B22D82B3AD37B98C360F1EEE31640655AC50E43A9EAA09383738FC66
      D3364125A0425B89F39FE3AE9B05381C64FB5F63A7DEA8B313410C0BBA09B3E2
      AF65680148F2F0E8502D822847DE978B76A9D4F8403543B07ACFE6164C03E334
      8530918EEC49BC424D0355A791ACB3130F10409FB15DCB7E489A21DD0064B37F
      1308F1382C0294B7D1B582E30C55CDA9529547198053145394CA675BAE6507A1
      985ECC12D57FFC160DF3498AB01A72EB58F27CF9E0554354312DBF12EA3CF2E6
      10203437EDC1A0B97F6F248347FD7F8388CF29883BA82A3B9EAAD48005257DFC
      E5F94810820E1BB027D6803D0D352873B9592920120105261E36D2192C9704B3
      98945766B8A315F1207B499E05D15AED594C1DC25D8B65C0799A7DDBF6CA96D5
      554CF59AD264C18BF55FD8D83ECFCD9BC701407225E979E0A36B2C75BF22DF26
      320813DFC063953A4B69B0451BEFE92517B2532917CF02A31FA82EEEBD97E494
      60CE62C8058994E033D4326462E05989CC30B7739DA718E9BDE44C61A58AAFBC
      C051CC230A91DD188A34A42970D85C8D79B70FD743F28073A8A75C5F60FBD3F4
      F47289FF6DDDE9C7B6B94FA863C3F658B628943DD850987DB4942ED0CB86DABB
      E680BBC10D41604CDC1D5B7EBBD0549ABE28545990904EA897547A42A32799DE
      59184F7458A3535C672A0B4DB597455E3D952AFF8DC04861E061FB0B59CAF1F4
      83B24D07E1FBA2CD3381984E90A03E5D7A8DA3FA57AA21C411760B2DF500FAC0
      01419921F7BA2527616832B5D7EDB787FBF6F96EF111B2C308AE03300DFF630F
      C0B47DB2CBF867E494761B47C899D4DEC78B668F1F4D5911FB7B7BB8F63E0E87
      BDDD866AFAFFD25412308CF4525D505FFABD8B6258FCB2A8FFC45FD5DE7074D1
      DE7119A5E533373D2682071A4C7E6D9B40EFA1EFF1D38C248F940EA99CC7ABF6
      9DDE1B9E8E06F70FF5D0D5177C56AAF6FA1FBB17FBAA19C50B1D7EC3B093643D
      474D36BE3FCE7F3C3EFAFF887BDBE6B691246BF4AFE0729E7B4D4D93B4FCD276
      B763A63764BDD8DA962C8F257B66B7DBB10192A0843108B001D0B26663F7B73F
      714E665615408AA42875DFFDB0E3A64854A15E334F9E3CF9F4DFA07DA6040DD4
      8CC0221EDED4497F52947DFC8339C8FA5D013DF842F37C0601ED91448B14E858
      C0396E7F194AB8A6236A4E0BAED285BFBD13ED43B97EF53B1D4FC43737144BA1
      EC31053CA3D7D93C9995298AC2A6B3AAEFCC3B621292F9324B156ACD3D0CAEF4
      F1F0CB64A7C4E4286AEC00073F86725884BEA33C391FAF69BA32728E5CF56199
      49B1BAF0E6764C8E93EA4B5DCC06D17E3113A2CD5552591C511D8795CD554932
      ADC2126AB4A778F1DCE1B629E34B0ABD6060EDEAA13DA2A41E10A081975EAE41
      F100A35002413B143A4E41B85B0E673C1FD731EF115799CB2E077FB06B32BCE2
      3F0C945811933271D12010B7CE4FD45A8D8111A935859027CAC9E480E019E62B
      A669453695D6EAC4F555D5E57CC4D829DC3720AAB423C8B6A5FF3240A68632AB
      381E68D8E207F88DF64ADF9390614ADF5E52172836364E66E03FA1D29D63B1D1
      A71A1180815F256246BA13E7B964BF6759908EFF35910C54B9858B32BD648610
      49EAF542F2D5A2E39F64F11038287D662A8425E534EA04AD775EA118BC7A3374
      FDC484A9DC30D189FB1A67E918B087DEB2765FF7A2FD9F451247C08DBA2832AD
      420893569D95B8AA8A512A93344CEA6B4CB5720160A7D03CF6C13979D932C13A
      69F8D63276642DC753E21ED19E14B1C521D66BF1D10A18DBCEEC1E3365C241C0
      F20D9C14B8933C9726073CB12742B11EF685AD399B2531A58C60250A4DEEB418
      BF761921E904702656CDAC00CE20CE6F8661A80B3B945812B674BD1208A74E4B
      D8941EF176A7E0C479368DBFD3C85B39F5C724570A4D8BCB27C501A33B5F4127
      1C826A75C3289458244CB7AF710E214B2D1C34C6AC80D02B1E8974E81B0E10C2
      26F98DCEB93C4ACE0383AEBC231E14C0F5E74CDF36B42E784EA71AED26C081C0
      2A7DC4BC605C24D7E65C7AB6BD8A1C32385D7375C4B21BFE4ADAE4845F737EA0
      9E673B7E086F1F913BD9C9BC4CC469C978428ED2723417AFA617159800CCD9EB
      0467F738E675C37ECC738C08D73D2003F575D32CEB9B33EBCFA9CD0FEBFD9838
      62B477891D594754C95C81EC6046145E3B114F78D522F958A759FA2FDBCDB73F
      555385A2759891D9E2B379392B44B3C7FCF1C6F4A715C36CE20C8C8A79194308
      2D3A00168090372016A534C49898A24E4751927F4DCB22A76288042F476CBEF9
      68BA68450CB42AC5FD11866E64558C921E188C88EE6182EBA4CC12C6F7A5DCE7
      64928A9A1053F7656FA33FB68F1BCEABF87C3D856C6945CC85F694A5D354AAE0
      F4C4ADA12580EF32A9460545B8A8FCD9494F4754D800600CB364BAE8F9DF6E4B
      06782352DBDE0B04D296755F0CC52D77D2913837CC5204637AD1B8481C0D91B8
      4A03DC841469639E2B78DBC134E33C03A0A77975863477C22E1F12C92E3B7844
      035E07488F13228FC1300CA3E58BDDF0E74D37195C0E7AD1E9D9D39D9EB5299D
      EB4BC2EDB418BB154D80E06E766E9C21C53C29BF2A1625CCA210F3E0FD4C711D
      85265C8CDF37AAC3BDF224E7402610F001975060B038BBF997335A695B625539
      BBC6BD188232A9A411859B04C512F120036DF02859A5840030C44BF1946B6C3B
      B2FA044F1F9BE1A5CD29E38E7B34C05E0C6080E41D7097EB605FC55945E59F34
      9F242505000D3F8776A0C367A476A2D8887911FD368FB94BE2AA9A970C09183A
      158CB7254CC957C5BCD6739BEBDBE2C8366161D497EDEA95AF2FA761681FB2E6
      0A921B253460C510AEAE8AEBAA2E6633B9D6F29B28F9A69EC6D2A10DCD0B9C27
      9C6E802A559D4CA168E60746FAF9A88AB2E4321EC1CE1D27CC2277404AE94A94
      21151635F0E43C146E80BE07919E5470A2E65005F101022D88AF171317736A3A
      2532160DFB3AC0CCF77F7EBA3E3DC39D2EE03A4927DD057B4DD61B18B4242B48
      8C1F7A20B85FED98A94029BA81FA26F61C979FDF8FB20FE34A41E652A9A9D79B
      63AA2738CC759F778F3D7B8926605A83B62A079A2246C5243AF6A0651B8B5510
      16906CB5B3C67C57522CEC12E237B4A50977603E5A2C05B80FFDFA2ACEFBE938
      614E381B1A1BDADB73D11B61D7A753DCD2550B3ECBFCCBBEBA43646EA211B13E
      BCFFB182667599C4D3957E7F830465A8A51D66F831040053A84192BB64ADA8CB
      14E380BB2C63D920A2B8F4DB3C89E679990070E20CA5799F879066A6F98754FA
      94519C63F10D4318C15108F5A8F2A3C20D59DD724C5549B3F330476E50EC89DB
      7AD2ACD57401960DFC8C265ADB30557527D32713C88E8EB17694F688770BE490
      DFFC22FB98E3A13EF94910E875B4CC1053764C43EE5E79182DEAE6C1EF7868F6
      A6E05DE77DEAF848395D61ED3860C05753D80EC68559A3579E36298714BC2071
      47181004E6BF80E8201628B903F7E17E41AD5FE6AA0540E97E0B1A1017B931AC
      6EC024FE969BCA8BF838AC825845BBBBDFF87FE091E182C453E413EFF556DEB5
      15B75513BC1A9DBA838DD9C41B572D9503298E21BEFC726851C6C7437DBD053C
      D41CE1955B5414CE82936DF3F7B1643B077C1565642A698B95EB6EC9D4134286
      E03F061805CF818FCB986AF016C2287EA07E5B99DFB731C98F777D8D63E259B2
      59606339708B3E9DD2094B3A806B5EB27DC110EFCAF54778E508742602432022
      BA66EF607AE350B1F73DC51E7E2D9EEE7A2F47DFD05337C6CCA98E86C5B77022
      D8E759595CA588FE2B6C1BD23DEE0611F394AF42EF142E19C121FED648E6EAB3
      C2E86459BC0559E78D4725AE7C855AFB0CAE112855BA6CD66A6D8075EA1C708F
      95FBF9151EEABC2E10C6568DC3F1787BF89CC31475A88D6DBDEE7819415948E4
      07923C2C37ADCB6D8D79A6DE682440FC12A4300C33184F4579B3F9509E99FF2F
      63AADB6C8F6936F1B87F96B7888FADD17B9D48E6A88F2B3B40C1985678A01A1E
      60556537CD51EB4567D9F8342E2BF90F805935E41A881BF1A375C36AB691CAE5
      F7718F0CA2FF28E67E18018051FA142EC01776CB5561B7A8AE1FE0BB3177F6E1
      884816F8289B8364835714D717C713671EC0D28A2A6C4BB62FC10815F2101FCF
      39B97CA28618421649921BB604647806B5C094442E200882EFD350C65725758A
      3AF555EDC319CE0D11A1F5E86D710D784F6EEC6B5C3E331E6740178A097A32F3
      4430A44E5392BA4E6B7C500200C10EF57495EA3A851406D893EC1D65AC71C002
      3E5B22EEBE8477123203E9EC00B385873E175BF89FD844887568B96A7C4EBF44
      F98E30357039A9AB948F6343C7C988330C48465C876D68836E201900039FA712
      9E123D870A12D065654B6559790417F018CAB2203302EC12B9C864400DE0BBC3
      797861D2ABD1BF83C0E156F6E6B6E49381D4F75154EB5C9143F6CE719759999B
      F8EC2B2ED1D0E21572055C06839E319A87E7A71EF2D66542EACF309980900BA3
      18594F0E45E369CC9197ED4C2D741A0E536A32CAAAAFA22E7E85CEE9137648A9
      9223BC8AEAEB02486B9DE6605C4B191F5CE7962A802381CE3BDCA82C6943E834
      9B2BAC7B6C657A4262C41A5629BA76A852EE926DF0052106F1FD425208731037
      37AA9FCA5460B0C9C30C9CF1576416587297B37841D1615A7B8F25007A51528F
      063D8E20DC329676379F4940FED6E80528A6FCCDDD34CD886D036CC6D921DC3A
      C9E7308D46925D4AC735157F7B1A75039065FEA64CC7C2C0DB09820C308F6030
      F006817FA7A74CA94321FD239B38AEEA5EBBF732F23427D8EB3011CE7B076EE3
      0BF5594143F8D4BDE84B92D0E56487B1E6E4FD74660D5FC1B27F544525D878E0
      59B5B70287430C4BA4308C7B10014CEB24901FF7DC38615656516CF5C14C64A6
      0751B3B8C41F5D88A8BA812F0EF748D8A70AF0CC73F2AFE08295373641BE09DE
      821C4A748E4FAA5CC3BDE84A387A7C543A15B2214D0EDDC30D4992E5635A26AD
      55E323F6CA12237AA01D8D3090CB0661F33DF24CF6C8BE719C47378A340DE70C
      E3BF8ADEF9B5211DD4BC6CB33BAB0840A510A42D2FC92771A3F3A8869094F4DE
      89388DE75CA48ABB0EC48D00ED3302F252467053A7D053205B346720DB5BFD2C
      E27D7EDA8BE620432615897E32364044926952828EFA56E2351EE60E0066829D
      8AFACE90C02257AEA0B2B74E8EDE60D4E333030203138497565EB9A243EFD91B
      52E106586C0C180B804C565CF2F211DE29A0B757B672AA5EC4A8B6C486E59ABF
      B5AFBDE0BA75477F5C352F456E3777195B1E42811CA68A9180A599A355A247B8
      E5D8F63454801713EEAE4B6D0830767D545A6AD03A3CDC99FD389DC535D3E658
      AC5292D0266542AEA63202EF40C21533E251051B271FAD8E92E4512629B1D2EB
      CA7B027257F4FE7FB74A02B5CE77C56AC948901A4C1D6998E4C94478146990B2
      2082F1691D25719592776144D99B06FF40E38870D33C3B9FF82243A87A1F8A48
      A72EB159096C46494B7A10CB450FEA0B3A302B217A298178BA5FA2716967294F
      5825CA329A2186B106E8374EE4B15A4E07A6E3109D4A018B95FE6BF2E8AB2913
      0B5EBEF0F341F45E6ACA105CC3712405411C6765F32E4260357A9FCA39CE23B7
      8C2F1FE58F0ECA62E621E2775EDAE26299B4C5E25AE6CA2C66FD2C21A9A4CCE5
      9EC4C76C92B9FAFCA37E2A99723BD44289663CA3EB1AB98FEF4DE880CB473E85
      D0A8CA5AD8D302660F9C7F10005841C69971E4482793BA8FCB69D91B71EBE12A
      E3D85B4C489EDF84A9C57C5A79CAC25BC5F15133CDA48C6570C718D5858CDD65
      7D29B4B0981D4702AEF6032CD8C43010749794793F18033A56CAF484948DE0F2
      3DC1452C68C9DE3874952DFAF08CB09829492FA61C6BD26AC11377B4E21180CC
      E5198F2A0381158526E83B1005FF7E03846245198842B8D14006428A8F55D8B1
      396830E0BDECAA126C900E4333076F845E6FBEEE4D14EDE58B4DB401426DB8E0
      975E1040F33370F2202151B4B83033248059709A91155E2C3C96F3CB689C6475
      2C72929296824A0C5F42F6A1FFA1A0B4383A55B65CD19D900E6069A87EAC8637
      418FEF986517BCEAB234BB49F1F2C5BA3C3B48B1DF9268D71A6215CE43F80F5B
      BB880E475FAAA48C25B90D0B3FCDE7BC111AFB33E8634BBD08C67FC4027A6EB9
      AAA58F8B9505DA749C375F361787E7CF5E45A74559E2A819BB85D1C5CE23B816
      ED5B50FC66657421C80C95A464584F752B6912CD455DD7DC8EE64E86248D66E0
      DBB37658E8A7B1F2EE9CE7A80A4C6BD68CEA8F49684A147D7A9A40E457921F31
      B79082B87BBF4EAA67DC187D1E7E6E4D8178806B01521780E17AAD15369A4B3C
      A62E38549884BB6574EE8D98D6A1EB490FAF033DE847AB8166F74E94EA0232EF
      58B9E3F42BCCFFAAC5E775273ECBB140C399062E5866F4389A605D0FE350A720
      EF5122076C50110112E8A212794377BABB90F2884EB71ED596A3F2C8F88D034C
      DAB04CC7974AF1BB8C672624CDD2705C859DAF6959CFE3ACE362BA9662CA35A9
      A7764FD277A5EE01D039360896A0C1DE0E2290066E7752564CD227E94AF40635
      E3A5238762331E482ACE4A8A604E34450658C715FDE16B18E90FC02B381C2068
      18BCF42F7F37111B61C57AB82B85E58A2BB94136BBD3E22E89D789ED6AF8951F
      4D790A8C1515B72234E17675515EC6B9EEBBC8F1FE805C14632484B8152288EC
      E66348193566631D9E9C38D202B69CABC9B73AC69673C4C0141CA75FD3B11211
      CC29ED2E85AC76245E341D2674047435C4D207195CE635D7F41BD5FC7030779A
      87B3A6E82F1DF01654A1D5116073849DB3B923053345AA38C6DEEC4DF4819339
      89479840B803A229509731708349515E0349D673D4E6578B25D1F8AC82970BFB
      948F45815291324DD9F08B20EC8EF006AC473DB9E0C70972FB5479C7019F14BA
      5C6A7BAE1213308904857E59608526A5643AE9F6A4E578110F375E50F624751B
      0EBFCD622926CAC7AE7470FCA1E08D77BE36A5EC94F1275106DF5B1E2B48571A
      78DBBAB8BC14DA7F05AB07BFF177CA2FDF7D8645F24BFF7354DD4C87205C4B75
      02571821F43ED8326E96850BE74B72332CB00E7CA185EFF0E07E83FC87FCB002
      2981E695539E5769C402713836255FD555BA5139B098D4527643D430B1B01803
      C4FA9D25A595841EC695B841849944DD2BD174765320C49C5CC7C17D63C6C2F2
      C573FB24BF9E675FA2339FAFCC736ABF2E33E4E1AD8BEB0CF1639FECDC8BAE8A
      6C1C8D4980C772C763BE24009A19A6C764AAA7518C2D91DBDD234C009721F323
      C6FB4826DE00551A0737339792522593B984A45CE933F16FCC7D122025F91623
      A065A9109C2A105D14D482411FCC099A3679011575599800644C0445B79BA137
      4951E7F7F8CF0A8097CF2A0A9F9F019898CF481EA3796E0B5C41EECD27F3406B
      A5ABC4951C081F81770A0D7E03736F5FF153CB7A29432FB4E9DC4308C4AAB3F3
      F8F32B5EF27ED8B4506819BDD53406FB8DA3D80C4DE2D65EFC4C2AF786C6C512
      1040B8F57695BA5DA4FDEDB36626F7D2E60378A826953B52D7A52EE557441DE7
      95B31198752D19CECC445918460C9B5AD15EDD46F02ECD3B7619E061167EA0FE
      C59443F73C17C5B1A3C54D839C4A810883B84F0E17F6AD873A071493C29A9924
      C978085FD593E4E1EDBB88876179DC711E3874EF1EBC1C0D2AE9F0E69321264C
      FF04D8D86633D2CA287283DFCFF80CD721AD35EF626438E26D4A40D9A2F14E36
      BCFEC02832549E0E4DF6E0F4B1A7214F494E39131FA63FC3C38C8E43905BDE44
      AC5AF2B281E1D041F1EE0E66763EBD83CED927A1931EE763849711024047F7A1
      67B5865FC328BCBC3E2B51E10AC26293E26E712DE24024B61869B5E2F9EA5415
      F8455E74780B6F1BF20CD70773154DA7C99850ADB3AF36377D4E8B7182F7F3DB
      84A53516728A568CD147121E402AA0A2C1D9C10594359626492F323EF8752FD1
      D7C80991BB21D0EF43356E97C8842521BD96A82F4F8505EE2D37A97B80879E8C
      A30A9F21EB1B91383C2ED4880D931506792AC9AD0CDA5B3AA54CADB899920F16
      3CC53CA606F37F846C374F0371988B3304F46606DB42DE17D40B958C206666AA
      A41C3E225FD610D287B975A9F167B46889BAE96325EC394CB23451C953A94D8D
      72EFEE36B08A5EFD18C510CC4CBB0B4D28F9C6E34044BCE30AE7C1CA70C894F9
      9620F119EEC9179B15294D90BA3D990A28B2C49864BBA499201F57CCC2F2D11F
      ED89D0F3E6CC87F3A7075700BD1CD968DA10DC8A115D6A7BAC3A2D2C68A65B91
      EE4E2F3435043703C641C43545116BC9514EC50F606283F2A27878696C568ACF
      92D9770D25FE18B63822878D6F6BB126108ED41F6065734B6C039E1C64D4621C
      5C168E216EB031D5C832CABBB7F77DEA90BC27571E735A2CB518171BA59570C0
      DF01453A7728CF482E3FABD8B0D24406773C04FB5C053C2E7CA44CF940ABDDF9
      E1C3ED0C10F738CDEBB218CF472625F44DB2721A829832E9608BD15D515A8D46
      357AD174AE7FC61EB4C843CF5174EC08F055917CE1474D91B7C419F23AB872C8
      EBA01122EEB3BFE05ACF9A0A3947041070B7F19CA3EC8358EC2404A95A9C5767
      62317A311CB17C2C35BB51E4C3076EC23E9AB38838433FCEC77D0987486285AE
      2C8745647E199569F585C69B9656B76348F323C311F7B83D51087BD3F84685E5
      91DCE2A01F85A1BC4EE76216C2ADE32D7313DFDDC1DB33062CA817AE7408FC79
      56FDA0E4FC3A33776A0944C4662CA354A61B1797B26C354F479814D6E9C52B3A
      CC0E59319B5A29D2CFA6CED80269C0AF3089BE60D0436E40100D3620102CFF60
      0616079AC6619206050306D1D1BCC4950E08495FFE51256536FA14E15FCCE713
      F16B0B79B3B2BA130A32AAA3EFBDD306E76B58D64AB853FD31D9D88A1B9B4B87
      CC28C7D92AC5BAC0589B814717758FDF1D9DED4467A4491C4BB851BF7351CCD2
      51D43D38DE3BD9B9437C41CE2A33C50DE0F5A6D5ABE8F8DD9950DA8EDF9DEDAD
      B3B4D0BC6DAFC08312E2609E5CF722C5DE823B560D86463B8B1A5BB4B285931A
      A4480537B545DC60F8DBEA082E5797D4CF5C297E39482708C4DA9158A00163C2
      3AC268966FF0B4BB7B952631DB307732756B158D8D248ABA392450F1B7EE4DC5
      CC537962DCCF1CF6C0720FCF2A388D1389E4B08648EA3A6562F2CDA332FC6D42
      4F524F8C2A697643DA4A4BB54D29F5CF85C9934383CC6A6DE54813D534895257
      F3E6E3B8EF8522A83F25D8CB877509080781A8246F26472F9AC45A3FB085318B
      2B5E92DA720917D345792A0ABAF2F78E9C12AE3CBDEB9DFF389153483E875B67
      C89430831A7EADBAB35EA42840CF0372166E697D75118461D92067C72A7D6CFB
      2C3753860CDF72D98C8BFDB675334C1AF659DD2C2F08E164E5C9B3417FDAEAA2
      E62A0FFAB275EB01CD4CB8FF9C6BD1F01008FD66618257A769A80FC45B400F37
      586EC88815C09C98E77C4A4E3BB22434786E92A71AFC13E119F1BD68782FBFB7
      03D54B719E0257A0B54ED1EE4D31BFC3718513D81DFDEB0E297E3BB8D4C59E94
      5EDCBA84543D772C768353483595A26E998CE625323D9CEEA3265BB993304CCF
      11C11F7F8C913BA66C31DF0D6781802C1ACFEB2BA40B920D5925CC65C85D3EBA
      E915688B8DAC1B7CA7287BCA3CAD287E7ECEC8C69BC3CFFB3FDF6998F7361B66
      956C158802D89378817C801F79EA03AC1E76451F631A3F1205D38A527015BD4A
      8DFA89B62DDC09EF774D4FA517C26086A6DEF9722C42F55FD8EAAD7EEB005F2B
      E7CD69AD75D34132900730C39EB32A989A0BA2EF58090666604B8183F6E5354B
      4AD88662C4E57ABCF11C369B93F04EF365E5334D320892C1F48EF363C451645F
      EE640F58E6910007A7C59805CF344CBF365AC71E9A83690CAE86E1D40B56B956
      1C70E83ECE12C903882BC0538B2C4F234EBB839E05E19BD7B60ECE5892720392
      41E5DC047727810AF5471569FCE1294B599D3D8F3E9DEE1DA86761D7B254E4D3
      3247F4C73118B318F24A5E176BCB865F40BBFE7C3EBC2CE3D995B805CC63BF0E
      8AB8283DF6B1BFE8B76CEC0714B952B51B79C7BC70E7A7CDB2E5D004B1F0BA88
      AEE2722CCEFC7D742CFFF4C38F2CF1CDACA1BDAAC27816B9AB36C4BD260EB923
      348CA3D76415FC733EE5E181A369BBB67FDC7DEEDAE65A35074DEA20C90BAB92
      609A37B74620D945A2008361D302AC214D5366163F36951E45DBF6F187A57D0C
      74DB62590F182FB0FBCE9E3D3E7AF749C858E3740C84D517E402AEF2EEF8E83F
      F91E3F1F1DFD27949C174F8BCDBBC79AA2D2BDE3D3BD8368AEC5A225BB3CCDC9
      857B76B5DDD39FECB214E8E2DB93E1877757FD813450D7D477D6CA7ECECF4668
      423116520460376CD9ABA74FC3D215CC6D5725320D89CA31B1F7E9F4A055B593
      BAA7A828748FC274CF58DC8225B53BA76F0E8FA25F7F8D4EE3CB74A4AEBE689C
      FCFA6B74B077B117F5DD7FEE41EB10AE7032ED281E556921559FE28340DE60EB
      9EA1E81C32EF2790ABD6E41AB29362D6E6A6EB6D253983AD7D9ED4C868A437AB
      64BD02096E27A1817D7C70FFCA7107BE729CACA97FFFCA0B73564ADDA3348F5E
      3C1F6A5906C165626415F9E2457E2AF73EA929E0C3D8C2CCFE1DBA0961561810
      560E57B2F4B8E455867047737218B8611D26A1517B8F139979BF43D72EE2A159
      8AB90BA52370FF981E07E576535D67BF43F3A836059C068252DB1635ECBAC227
      099F6CCAE5CA079488BB446BBEC91E6754CD98270FD2A6ECE743A1168CA3D7E7
      A7EFEF57A97179035269E7E4D3F9FBA8CB183B2AC5CE922CAB762C68F150ADF1
      16FA0C2B550AF0B838088CCCD337E77F64B1A11FBE8735272FDF4A1006D1C7C0
      3AB5EB185D842720FC3F67C0362D1050848BED4AC1FEE9C9EE8FB8D72E0ECF9F
      BF42B71A01A3BDFD0F87BFFEFA8F93B383AD1FAEB6EBABE8F4ECCF478220B1B6
      0772298BFC31F876436499F2927ED05D29634CF551A5863C47A8F31C01C9FA55
      F4BA2828A5E1D30BEA02BF3165103D404C1F4427C400F6AD7A6AD95AE06CCAEE
      7591223DD5A78AB11F24D9EC2A8D9E3C193CDBAA25008B2976D4833CADBDA564
      6465585D884C429EC22351366D2E7E6E7F94A5129E60E8C711C7BB02F4EE67E9
      8C04C89D3BA6BD45E75F6ECA741A9D1FA26C9912CBA3135C3601E778308BB75B
      57EF8A6BF89895D4761F15050D07A05541096F8620ADD8BB0BDD68DB5B35FBBE
      445059A2D92625292B19DC1EBC1B0F02166F26916DAB56DC5958CD92B630D0FA
      DA6379B3F6D8EE5D6A8FDDB74CDF2E8AD41D015C955210146F8ABAE77531C3FA
      9202BF87C8F4F829E287F2094C82BCB5C4EED0EA93A7EEE2DA37E1B5E84D521F
      57C7075E9C11F6D70C69D7D1610EBF80420EDB9A8B6815A7E72F168EFF2CAF52
      3DFE9B56793F3FFDDBBBC0D8025E8655324C729689519D896D1BA7717FECC832
      908A11CD50C4916ECA34CBD291633EB396ADC83868DCEE7D5920B77DEBD6F1EA
      30A9E4745748C0935B52142394E2E3F329B1635213D29C2AECD1C9D9D9857ABF
      747E559FF9412F988116C656DE8745DDBD76198F034007A209EB92EE14661C24
      D5BFF1B70F7228EFC71955B893A37894BC434C30AB4CC26012FBCB2026B2F120
      4D52AB42623E723D4A4B54DDD5F001690C8867B2549914FF434D84B492F3D2EE
      02DE190FD2292BD43A9EBBF894DEDD9D23A487A91EB22B88ADD0493D2F73433F
      51386116579D3BDA853ABD0FF216E7E787AFA293E3376FA36BE48E2B7BED8431
      A59FA293C377E70FD28C2581EF5F1CEC8948352EB83AFA76F6BAC52D7AF016DE
      7D7AA016E476BC2A6A50FD0DB105F7FFBBFD9EFCEF5E56E3DFA2F741CFBF85E0
      2D64A5DCFD067CFE47DD802F5FB24EADB37D1E9F1C7E8EFAD14705BB4EE3198B
      F926657481D522DAA1DFFFB865634465916B7136CCD2AFB8F40C00F0DA92D8F3
      0AFBBF393CDAB2A11F79AD672993BD49FC132CCD38E9A8832639F9149A980FFB
      F29F5B7A61BB80CD62563865797952CF79926166AF8B321B57C8ECD524FA8393
      7D7FC0130992F851A849A2329CF72BFEFBC39367C1646A814654BDE20986C234
      820178F65AB46F0A1C3F83BE465655566CE7A9FFE907C2894767CF5E457BF9E8
      AA80341CA53CFEBFE83D98A42745F1A598D7FC089AD95C6A88F60893C4525554
      F8E66F7BFB5B76E339969DE510F2DAF218BFA58B9AB98309F3817C6799BBF5F9
      38CDFF490F7A5B879D43F2EE1312B274A9446334322D72AA1313624F4ACAEBA0
      30DC65524C93BADC76057C0FE8528AEFFAF6B2513EFF12735D8AC4614A89E534
      8FDECDBFC4FD0BAC16D4394FEAE86B9CA7D59628F70F04B9215A52A733B31EC6
      6925CC1CF009A426B0D45CDCB60D5963CF5F59C2D0D9101344225315750F8ECE
      5E1B86E8A1F4AF691CE1B02DCA6DCDE91F5E3EC1D6E27D24C7D579ADC4C4CCE4
      AEC5C4DFF6F9DF2B90E22E8567E215680239DDE4063CAE2B7CDB88194C64160E
      C331A0F5FE341B063BE0CF79F1675D9EDBB680D520C68D8AE42843B298E39D9C
      5FAFFBBDAD1FBB6D18EEB9BFE03E47E7605BC79954CD5E428BE3AAA7776C92FE
      DB46B77E8CFA86BEC9E2D3D78C670504336757AA97A148C37227E3E61EA6EC9F
      7EA49BE99690117E85E4504A41B442EE9F77C955994E71166CDB1446F9034C04
      CF5C30321F8E76294DEBF5005125B661C96FDB2E56EDC1874622920F27239A01
      8A2B6F79F9D7DE786CB482A3678FDF7DDAB6DD1FD592911CF29334C7B2F95014
      D32ADA2765247C6B335B31F4588074D81ABF21558716FFB60B8E717DC1141073
      F22C3E6A6D45294A5C6FFDF0E778F89BA47E975CBB3816D8EF527B78378ACB4B
      5675570E89BDFDF1F5902927421189D27C36DF1240F8F1F98F0A5E3CFFECAC47
      A9D1475E4F5C917964F44109BF7DFADBF93EC3C5DB868071B5B06CF40C7EEE58
      838A527E07D145D513547775DB56F0667F9BA728AC39AF8B483499F5D09814E5
      28E94B1A41D4F9206ACC6747E7178C7E76B66C52A818276F24EA7F7472863CFD
      4948D164FD33013FF0BA33644E82B2B16D83B8CCA8F0AC064E53CABA4CFA8A4A
      7A4325A8C98797A6F45A57B2963D930301EF2D51B81F5FE2747CF77EFFBFA247
      6F12D655FC388BFE9EC4A0EF3C72160379A8B00D9F30B763DBB6B0920CE073B5
      16E4FA7B1BFF0BF9FA6E0B91E5A81091A497D00CDFB6654C35DDE328CDA9D887
      2A3C5C4EE36494C5962A2F75FEE633EE249AFDE093F21F960FF0B0705752655E
      3C11256924C22B081356BD2B7125C5270396904B12360EA2E0A5563772DB33F4
      B6AEEAA9737800A130E49A9CEF63307D7FE47751E7D072619E73AD88ECC18475
      64763B1AC2D023A3C35415D186C120571D34BAB5C77B5BD70F111389B3F34361
      CD849D9E25A598C852AF36F07598130C5235D2D95C05149B8DC1B042DA5BD962
      413E68B74FC2D335A83F4FD51651DE53CF5D8142A9554495753EEF417BF3E279
      84D2049652E3F079518D5529735FD485B2C242587A7E4F07FEB61EA93226F47D
      358F06926206080B0A894A7F38574C5A3DBB897E9B27730098F157979119D77C
      462F20565B3DA0ACA81E7656DD7E362B17F46CBE01128DA5688DD4EF551DAE09
      35B58DB0F27BB0F4BAB23B19FE52D14AF4F41DC088BAD073884C9A3CCED82906
      B2714BA140B9AC80B2FA03A1DD3FFDF01488DD1EA930E7E787EC14CB62E54818
      4ECC7B52FAFBB6C7F69F7EDC857FDBF9985FC15F8EB36C3018742C4A4B490D32
      8DADB6D934C9E7DB36847B584432C847A4A11A9DBE3DB808C4CD43AB0E22D362
      2F9DE3623679F82AEA2246D03FE603FE0E70830F7121F9CD23C27A6C3A913F0C
      F21AA911D5A06B101E6E798CD761A4D1B352665076820AFB8A989C4839DBC16E
      6285A0D8536FC522337D6650C799E44FBB41D89C67CC21C6E3572676DC48AB98
      18E9AB9690ECFF869FC3267F052014DB9C9AB4AE23AAFEEB8EA0A88B039D6988
      AE9A9E9A794A63A7B22D47193699115994C3A24558CF9D68274EE3D5157B696A
      B9FC13B8C270BB7DA610E270BD08652DC3B719C7D7F9E51C5950F03E908D5BE4
      C3A2A433B2BEF29EE787E89C8E286FED260D76313DF22EB22E5041EA7A6770EF
      70C2B33F2A9CF0826EDA07EA98CFE2DC2E6B500DB77C2069B81A2A6F994CAF5C
      3457EC54212D42B61EF3FF382A0408E4AC62CB9DEF9F9DDC2B74FBA717F4D558
      2342038F2EA3B6EAB5E929D8A522FBB427158E10521699309E99CC5B4BF2B96C
      015C09AA10EE7FD448C0DDB2CB2FD0652AD8C575B4DBDB351DAE6A36271B502A
      09C9A912462AF41E31D0784BEEEC8B97BB6EFE0EE2697C090F10986542CC92C1
      C82C1E92AFE790A36D9B128A8178ADC717A71263E1B96942BC7954D2C725BACE
      F5D24CB19764ED6DDB2748725540743D3A3C7F2F26EA69311611C56D9F8AE0C5
      1EA9B89FD242EA12A9069962872267A935522056058A67F8A65BB6FCE3139DBA
      C750C505556546D0908B49F237442990C737AD3746E9B3381F57A37846DD9C8C
      A53015072B0DCA5098C681A3F9A32D71A11784772BC86ECCB98650F44C7256F9
      2F4DB7F0A5AC689456F3A1965B419E1A8B366F3D4884E96F664CA4007AF0D3C1
      BBBDD39FF6F25405022E6E66C9ABE8758C63281D21DEFE3AC6A8D4E968CB267F
      20AC4BB58AFA2A1AC6489FC50AB6EC7FCA4062E951EF4A14C82B13A1167627C5
      E28A22AAA671966DFBE6845E05D43ED14ABBC524EA1C24C8DAA892E8F0B7793A
      237ED6B1C1818F5B8C3560B16DBBB07FF7A5888E905CCD0B14FB703F035887FA
      0337150AAEE35F75C97FC148FA3B07A04255A66D21BB974C5DD1E269D385E269
      26FFA3B5D35889C26AC5D55A88725E6D0925BD7C82B655C4F86B70202439050B
      55A53BD916AA7AF91407B6009D3E41960C392C2972462090FCF1FC62DB0670AC
      506FEAE2DDA90F4A332263398FE0D5A7758D8A9E308BE6B99477A2EC2AD381E5
      D4DBBD0726F7F2292EC693B38337B8CDE39C678534177A9A72377F4DA2771F4F
      588011A56E913646080DB5772D84BC65379E11864CAEA3FD9F51D304AE399FAA
      43819342753A655AC70C39F85A254A12F381AB7BA0852F9F01A77439484E4D24
      252E04F2B34FC0B784665DEC9A95C42CA434FFE2921C8B32BD64860C568F8BBF
      A27411F252E93B6CDB579CFC525C9A0A1F72B2D17D90F093A39408B638294673
      6A01F8445EE7444C8B2D8D8E97CFE88D4F87E9E5DC8417186A7C54457FFB787E
      1188BC6FD9C0F3DB1B78BFB7FFF30334800365DFE67CCFD8A0CD460CF30AA679
      1FDF9C9197B965CBDFE3A8710B4CA7EB5185FF322C4BC55699B5AD0B49084280
      20B04DD2B196B5820E8A04D098FD807C34BD94D28785031D8DE2A0E1FB893228
      0A9CBC2E406E4071B0F8F292D540B60C6FDEDA038264606BEC7D3AB5786E1AA3
      945C9440271DDA1D5AF58E81B14BD9943D02D2141A914A60AA44AD2E34BFE7CA
      213F0235A9F8C2908046828074B2DE3CDB058782FE0A7E86606605EA5BF6B0AF
      0AB0874004A01E8FF4C0B067B13118B99910A918A5B18A590E397AD0DEBC75A0
      6357C1DEBF443FECEEFAB2C94623106010D9994128BA510D48CE24DE2C2E23DF
      6263BE24F083F6BE511A454327127083742D3043090960D5441D247DE0752E8A
      4E34838CB408D4F85FCA4A124BC1A7333E688F03BF1E7417F411096A4ADDE35D
      5D7D116184076D3764A4E04FA9A67632572E2B207B6682B5EE64E4F24BF33E95
      D45506438D6ED146D0BA37AC07BAE5617D5B7FD3DCEF0671F920652AC761A3AA
      9CE5789A3E8D9203BCF1A02B619E0BE9FC5E24E4DB4EAFD0BC3036C124D09B73
      FDD5686070E7F8AF5348761FC2F425AC8C89962AF0618D7B4009B7F55C31465F
      18689A56D47DF695F07CA5426359ABE9FFE011494DE2787D76F63384BFA90179
      199DBF3F3C7135F7640C112880F1FA9001928BF14433DA06209B1C95C5D4D50B
      753B42C3A2EA785A114D1FABE3A31FB2571214F8052C8ACF4AA350864A53662B
      3C6CBB5A7A91D5DD722448E655B2F390BD12F0CBEBC4060429A1E8E444541EB2
      49E3A82EDC4B38A4B8BF670CF341419202F7AE2A4BFB047BC85E15E5EC2A06D4
      BD64DF56017E246A190B4435E36E5B7154DE47F15751975E2CF1F6FB46E15ED0
      EE0FC0B18B8BC3D701D77AD1A1EDBCCE50F1DA5527D892BBF3E2E58FCD863F1D
      9F1FF3627ABF7FFA3AA434DE2BCBFA4F2F9FC22FADE69349FA4D900C68DC0826
      0C230136BA5CC9DB3A4E862E7E46945146EDC91322453CDBC16FEA331DAFD3E4
      1406D5582867D5792B0E29513FC66A21C3BF8F344BC052DB8DB3CFF34617A25D
      740B47AD56DDEE9CB358DF7D9F4D77A1F3410AF90A2BFF7D59E0622EA36FE787
      D1A12B2E7A525C767C8DDEAD9AFD20C7B1D8548156DDFB3281A1770E53943717
      94BB055B0C4821A825AA690A08426ED503866B8D0E7E958AC0AD1443D07032F4
      ADB7BD2CF974680232CF82480D64DE2004301F0A373ADADB5EC822B873255E72
      F86EFF2DCEA59FF3E29A60104ED0ED9E2DD1FCB862F92D3DED14ECB90FBB017C
      241CA4ACFC02A95498512E855D73D60490179E598BC9C24850D4DDDD7DD23F3A
      3A0A57C30FBBBBF868C76CF3E90CCF576EE4E1F97697593BBEA71A4D12E2B354
      4C61F7F3A28A325A8A4E9D301F476F8F2F4E0F37A7639CA3464E822BE9BD2BE1
      B62A847B8E941E5FEDCD62B85A08453CE9582AEFF0A9286A9317D7DB894D4ACC
      1937B6A741C455D4FFADDA2E70D0878B70CB33BF6EFD5004AC614F11F4C3A3E2
      CBEC1EAF2BD44FBEE6E81E8F41AF8247C5A38D9784CA71600BD29C8431495372
      5DF960E4AF4AD13997DD90E6D141832DC0A0FE38A9896031B88FEF1843CBC290
      3BCC5466A6664CF11786101A05C2B47601FA05705839D6A6C1EBEA89C7632B64
      8790C894348786262BEF4CEABBA9DE74FBC4070C6F25D3712D0BAFD1D7336601
      5FC7C7143A1AE5F2C10D5C4F87108F54368E8E9ADA7DB7A16C64892869E34635
      1FC9D4D8D98047A37A73249E2C1BDB600C17266FEDBBB80A408ED90105C2CCA5
      4A3F0D4E8E2D4F8477059623B2E45C929CD6B997B5E27BCF8915E7DED2E8EAA2
      BD1A1B9C3FCCDF7931CFA2FD382D8DFA3B4E105B1B52DB1C5494EDBA7D041A5D
      A3D7EAD94BD7DA7D37DDCC7075777DFA3B39D137D0BBE545C9AFEDDC9B22F374
      738ACCCF45FF285D791C18BE5A4C545732AE80AFC8E9804B014A3C4A14D33A03
      E228B96AC5ACEB4CFCE07D5C9789A8DC3F862C427CF33ECE36203651B9312037
      AD6E2F1A16D0DD82CC2EF21DB0C9A6455EA34CD2B840B40D216420BE7CF91E9C
      A712F0F238557C5304E24A788D1179A7D27B881ACC92C1A89846DDA2E413E40D
      76989CF3F1FFAC39231269307A0FE6086B643069C6B067F9A316D9D6450C950E
      090B35EB784F810BC375D99C02878C85F27D91D455F4291D27C54AE3608F8BAA
      235FEC58A79A5CBF6DFBB8E4B82125AE9891F2F41FC5FC623E4C50C5F1867427
      4EA9669F59953654292C28F5E25FEB8F521D7D1168FB99B3F73E29BF505FF086
      6565A227DFBFDCF6E12A8225E8B6692B6976B3AC4C6A9D3CAA287ABA2274693F
      92142EC6421E14B89329B1D27C60ACE6D73134E1B39B1D03CADC1A50B106E1F5
      7AC60CEFD71862BF19AA00A9C03543397A33B360DD83F69B94375FEA09273274
      D68911D7D7A8381216C4C27724A7974550E49A11CBC52E1689EB91D0CAA40261
      EB50F904FC9CAB790D5CEA614153BADC1FF3398C1D8D5E00912926D1EB53A960
      C3600645C7A5D6595CF96C990AE4EAAE22AB7A7F0D93E89998443B0FDAD5A058
      6931B1E58A19C6290896B3AE0689E83C263C837F98F0BDE3CDC214115D2C1718
      4BCBD17C6A753B1A029EA2E562215787BB716A9C75C712B70FFAB29D03143E6F
      2B41763C8ECCFCA3D0FE0DEAD1AAB58848A5B99FC6B5E156A0AC8058CB8EE5C8
      039822920FBF47E4D63BCE39929010092A3E723368AE52783303F3647551641C
      64E94CF0AF23D215F2E4DA1134C3DA95789ED1F11F769710E1A0C22A385B7B17
      1FD065D9350F3B5C6AE550BE4E74CC53A8DEDF7A4532561A4743942424B50D0B
      201F47DDFA2A46F0B9BA8AC7BBD7D5557C337EE6EA8D4DD26F0F0AE69F4B7C8C
      F673514A169B1C5B66B51D9E9F32F82E9A00E78762024187E44CA815CEC132DF
      8AEE9927BD775D8882C9D226086572EC28E2EC6041B3A35DE0EEF0FCF441DF77
      6F3C56CDC2EE8E736C62EFD4883A1FB79AC51804A7D128F1F645306E8B3C09EA
      1F969604F61F50C4585290525E8D5ABB53B95883D88FA084F70A71DE12F1F150
      E1DF79661593E87D712DB19EF3B7671F5BDC2D1679DA9E3A716BD8495166A256
      A62EE6A6AA2EE3BCCA625236DCDC05AC111470F8BDFA53D6D1D1C9F9850DC390
      854485177C4F25C25B1A3F30F9AE56ECE9CD878FEF5DB854E39528E89CF72771
      8D6A169A09EBF6ACDC918B253957004AAE8EB093FA5BE9462CFBBE5427F6F1AF
      2085588D2A2955003486F3A9886CF4040E932BEAB4BA59D79855F0F41590FDA4
      0CA23D871FB75C1BAD515B16190BB06CEE5AD81B2B3A2F07CB6B911D34CA0F84
      2C8B1204B8E18D09BDAC77C634ABACB36D0B9DF63B7675184475AF9C27AB5127
      359B51534913E7A444F8D7A4D7E84ABCA417304BA5878BC94FBE28F2E6314F16
      D491A87858DB4DA67B8CA2B894B75BF53AB73FA3FB688F4CEC2349F761615EFD
      D6A35EF408656911CE10D134D9EA81A8EA2351537BA4F2069D6356DC40515624
      36F2ACEE98FDF7C8AADAB03C0EAC8A6155F0D9D7B755FE78D416577824D9D0AE
      6CB9C30445042A9AE21EB9C43D3BCB625F186BE5549F226931AC361B0F610D2C
      E83AE81D2AC7144D9DB432500A2CE071311219802E1863968BC690BC42C63D1A
      8C74B412942A75D3B0B3F96AF805BCBACF4BB3287B4B6814323F7C0B8A3880ED
      87A81AEB21AEAB2B2CF5E738E4BC09E9027302AC0E07AE40C9C230D84862FB28
      31233E31121CD3663D6CD583F498EA6AC8447E20F613BBD243D52795BE6753D4
      CFAE98EFB71D3C7B6B62EA2B68A0E1B597B3192D7DD3947A205B82CFB6EAC4F2
      F635517865DBDFF31BF76EDAAFF557D03973CDBA408A357974C6B7FDDBDE7D5B
      D4C66CF8F861A3257BFBED1B6A2E7DCC279BC2C7F8141FB65E6BEFCDC9426B6B
      F6863B8B944AC81529E92AD17E2C1788EE875398B2F2A79E944BFBC2E26A495C
      09B89C603DC786F6BA5BCC3284515624B7DD653B62F3E383C34195219CF48BE7
      C53A4CD7A7B92EE4C312DCA88BCB84911D498A6D85F48AB2112CDCF0041054BC
      A6808C4F2629141FD5026BE2B40888E66C530B4468919551319DE2388465B5B2
      459E24B6F8B83CDA6FE2C74130C8C538D3BA4938FCB63A3F9BEE52722D2DA136
      E446231E07010C5F8D5856699709D1CBEE08C9A5E9A9BCE48EA8347C7511C886
      E20FB14B651F93DD6FB42872D753680EDEC5BAD174F86D13F41F2E217F6D3AFE
      AA64FCB6092B38B945937DDA0AD7310AEA4EDC1B001466395EBAE6BABDB342AA
      A8F1F6E6CA277A17491E2471713FBBEECBECEE799DC45324CE25F17469F607B2
      AC2B08D439B34B426AEC823CC815833761003163E7226605B00B0ACAFA068F2A
      A9E7831F6D3EEF47E077CEEBE8E58B552379E05264889380F50CA8CEEA27F832
      7F5813692EE98BE36621E5348F9E4098972F847F7D8FAE8EAEEE726C5A495613
      C6DBA070E67B1714C7304BD54F7D8A7F1351CE96025EC117E06C34369DE5DE7A
      774E429259A645D9A5061536AB04660751F7821F39BC0242E0C8B7A08A1DEC36
      87B042F21A3F2D26133117F181C25BC564D22A3224989604A82DD54F58057209
      B6C9EA469EE50B06F573C93F58527A1C0EC8CF839D95D2151E424441EF57CD52
      90561B4E286F2CBFDA75440DA92FED8B4BB9CA99127032C6BFB02058915EEC7C
      49B1FF12A485342A3CE8FC190F1EFC0B3FC92AB7344C2645899AC458B55769C2
      2EA655AFD9FB00F6560E1C96384A4E10D20F5E4A9ED79E09ECCD6CF5ED869B85
      488E4C490B12A86619C06EE48777DCB73ACE7F460B17709FB9523A47987423CC
      A35BCD6F1E41C584760EEB4B961A8F70D3E19817A4A4F84EE150542576AC40BF
      EC577BEDB7418C7455FCD6F10545D9D8C8E34A617D6F87676B3DC8A44CBF1A3F
      2398062DF7D66DD5D6B4A2ACB29EE2AC72346839E5F77FB6B3DD93C95B056055
      0828696C939D10D3D21532BC51DE9F568A35B45793EABC63166AFE9851A48CC1
      068DD38C553F96951BCC9513003F3860D9F93DB0046882F58AAAE9B200ABA81B
      D40F44BD531E547E5926EE44B11FA8B25032DE7915F5B176309B3D706D82FFC0
      02C53CC9C9D67F57D8079B1FFE40FFB5D20CBCE655EF2F8102AD540C68982510
      9923B350179641391D6FAC96474883974122130087FB42D6AE2C4AA7364E46B5
      5BBF1A570B9E8FDA7A224BA8210A61794A9C036B434E735CA424B2862696897E
      2D6A9B17797F9CD0925E3CBF0766346638E06FDAC6A357022C53F0D138604B3B
      B5729D0553E2F0086F1087C62B28D10BBDA094ADB41D2A096393DAB59AB3DC5F
      BB4F22DE302F67B081E55AB02193E43C2FB38500D2A15C69A80BA7B5B1BF0449
      83741FD0964C02EC404D3AE369A8A18E4174A4A5D617312A5E4D6D5CAADDF0BA
      131376031368603C7984A63DC4E984B04B5C26605E5C167A2109360375041351
      B873170A08061ACF2F6F37ECD19E24E53028E823E269E7E787FEFB0DF39D840B
      B370FBC14337B5E143187A4FA2750CA8E3519BC0CB01867CB680210786357782
      2C469E682A1128BA980B0BB01B445FF5B93DAF2A88F847FB47D20A63992483A2
      A5D5F6153B6E228E0BD311A2E2E619D85D2D0E8B239818AD24A961D64A3C74ED
      05AE8F76CBBA84795558809EB329D381BC070EDB161269D0C27C3C18C64FA3B7
      CB6A262E751D1D1F0B89C43C28FC53DC72084478CB84E06F508F5B7E0803E2F5
      F95E39BA5ACF15D34CD0783CAE1A87F3C5E1F93311F404902C55C2AAE81AA933
      71F39B86BC02938776152AEFF1185129ED33718C9092E4BEC057B207AFC366E4
      D8E411C7C2195A625BABE22A7945B44779CE090C917CABCB38FA5A30E7439820
      3118AE22C029DE6BE3F2AF8BE87D91A5D595BDFFF73BAA97D9AC658BF4ED0A3C
      E662A68498A6CCDD1DA0092661E8265B9F5DA0DF0B8C9EC05BC76162491D8025
      C5D4C34642F4E26B2A94123D639197C2C802E881D15E994407386EEFE0AE5E95
      694E5ACD39CABABD1621A19517AAE66E7D3C46E95BEED60E3A8A6C649223E591
      8DE76D4C89ECD801D8426BC2ED8EB3110BC9654A79FF31B459E5C9AA8C442797
      0C12DCC36D1289D44AB53323C5B68493C7FB73F5F9A752841A3C6A9C75AA0CC4
      8E09B0AB547C7CF236C966D163259C468FA377C9B779755A8CF1EF3769FD763E
      8C1E1B91267AECF8C18F950CFB5809B6EEF5EE4D8D7EF287A90752DBE8D9E019
      CF1234BD2BAA3CB010C2AAD796236099E4446A50C5A53B2C9318557DE675D12F
      134131598D679A94F8EA9662E12FA8F7EFCBB89BAE5843D3F9C3E1FB13E47C9E
      9E1D1C9E4447C72787D1BBBDD34325A43EAC94430D7B5AF2C3661E557255F584
      B72099F4FE606B9C6A18620A893C68C7C0CB7A6C1A64D302769D09908D0B57D0
      D8D5A37ED0B64F924BF039599919F73EC328F3995C9CBB42E01432246F18C7A1
      78E0DC7C725C2EF68F3EE22D0590F3A104C1673B47051DA58FB3CEEFA50BD091
      FA89B804AA4EC017695797FCFBD9D9FBC0D97ED8C550165F923CB06FAC040955
      A2D4316C671C5DA662851A535883F10FDA31251A1C5F9C36A41248618004712B
      7DFE81E9AE52D1F2A298A5A38EE05F142B66B665277AE3D3E18789C87A542C7B
      5E808F106FAB98704B6FB41498EAC901953B27A9E0433262ED1099C1FB6DD7E5
      942C63C5D29049AB80DD62768C312A9D3288721CD5986BEAFF2E01EC1EB2B7B4
      425C66BD9C641E8618C52358300EAC13AAAA6217C2D270E93F0179F941251FC4
      A6A1C85932BE05BF84038E1437CA60CE6BEAD1D00891D0921B79F22643BA72C5
      7477AB68C9A735C090877C1333F64DD55172D2092515334A384AE5202439081F
      5AEE39AFDF77AC723D0EAF72052D44CA7F6373462D29B15457C6126EA259319B
      6731105E605AB0781B7658DBD5675595A400B987EB66C6288083776204F0FA40
      AD2DFDAA51A1214BC6347C8ADCECBFCDCD7A6F4FE2EC518B522FE9B5FEBCD8F1
      6A8CC1DA3643BB175AB36661AF6ACAD31D8649342C9054918FE57E46647D7C7F
      BB757773BBD513B056A3391DFFC58EA76A79B7DDAA5B097C81241FCDFA725B0D
      E0D25A0043E0D626DC086B06615D00FA97653C15877480A567055A543883CA62
      62FC50665111FC8E7C6F587CF33B9B758C6010D9C32773BAEE7C76A5BF270D65
      09430DAF6DD181AE95E855482A36D9A6F1022BEDE9F3F62C3CFD4166E1821E1B
      243EE0ADE52DF1B62520CFC5D9FE92E43F14056A399141F7691E76E925D27A1F
      17107677741BFFC58B78B8D3868439AA4519495184C50EAF9C55D5CADD175531
      B00F108CD786F12A02B1F1A855C44BEF38C5F7DDE1BB9A749A8E91CA39718FC5
      521AC3B6626F95E0C100DD3AF812250D93A86BD74251E2329098DDF5925604AE
      0BF2D182D4700EBBD6EABA8CD37CF3552106C9EA7DA94C48669F2ED2925B130B
      AB631D6E7B72117D179D338C7CF1E124FA2E3A52FDD0807789D6563EE5E85950
      AA08571A2108105CF496FE92243388531124831F6B18805DC8A37959E1A22850
      246FE1906FB626CBC935180EC95D9AB4B6CCA2D0E7B0EB18DA32C1AB2020C8A2
      F49708701B5A6E5565F400B9ED11FABBCD97C07F16C5CAFCFBBDE85F055EA38C
      475FA087FD104B006DDE96CAAF6B62B7177DC797EF6F7EFB7E3CC6C9D5AEE9B8
      142926155030D8AA41C91ACE6142A6B97F1841B01BEBAE69BD8C2DD8515F95C5
      FC52D0E30E7F414D2541C30C5EBFA96A24C9E0A32E32B12CB4DB3A52771AC09C
      88EE72102C27DB3A2586BD3C4351CDB5A8FD8ADFE2DE430A338682917FC4C926
      CD7392B964AB6FD65C32DD796AB125BEB005D1C3F6C5A2E12385245F412789C3
      CA83F8845667772CE5B1B9B80BD5A40137C6B14BE4BC3C80C441D7FE6ADFD61F
      875F9606D78D14FAA4E62D441ABE60921034B0CD2BDC0F25FC342052B243315E
      F66A6985EB0CC161DBAEB212F4F16262BBFAA8C91DA06F19CAF81AD13ED67A82
      ED6E890EA3222BE6E5C69A1D7C8A4DB83B1EF90CCAFF4F13D8208CE7C9F1938F
      0141C9FAACF49BF41E78E251ED0839416943079A3DDE41F0E3779A5D9773D034
      EE603939FD0B7BCE63F9FD8E3CCF04FD95B2642F342455CD5153E5C3862051B8
      8730036414644B8A466C3EB18AB42D99CFD50A09F54AA43F440338E5D68E9A78
      4A6C292E2F454517AA7F553A4C511C45D811FA7D488C59A103F9911A1ED035B3
      C45B29BCA3B41431E1E4451831EB72CCE59D64D6DCDF5198A5BB3013EB12814C
      C6DA0FDD94819B1918B34D343BF4E34788C50539C4CE9B97D3C995E8E3F7BA8D
      77781CF698721B41FBBE0C84B6B4F9E4BF4D2FAFFA07EF8F654B6EBC8183D4C2
      E613C2C357D138296C42AF671473AE164A3FCA1F26F18832BB9505F77E8A9EEC
      EEFEBFF6B2B6FB2D743C70A4DA2C9DA612C4716C5A1D12736187B1D51804582C
      42432E03DBE9698E6C27353A389A57B598557677DC6D883B6FE3E9705E5E22EF
      E9B45D596DD12975DFE6976F931EB1CCF7E51E52709B2BFF4B9F82154A416ADC
      93B47EBA8E89CCDB2A9A10CC66D8418A2B6D973E73526030FFC549D9EA019689
      41B1203205F32D8BC38213B0D50F3788F232514C0CAF1AC45E9790DBCC60EEFE
      950B6C9CCC929C3839C80C12C4E45EF6C4ED30B429CAE89749EDA3C60C3E8686
      9EB8F87708609F9F9819BA99CD2A642967B9A24D2BCDBA8CB5D60D2807F85BB3
      32ACC5B8A7EEB2D69CF72A693D7BF5091C14870D749A8577A2D45AAD66D4E1F5
      DB01EA2EB72EBF664AED6969F53EA269CCB47EFE8C2EEEE1B76FDF443471101D
      A2AA6A7623254B17D86DDC602225EA4FC8501382CDCD67F8E7D3EF9F451D8C69
      C775BCBBBB4B5EEC815C4DCF777F7CE1BAEDBE7374B8AB5F3BA454A3BEA57295
      493285D6D35A9BDCCD9D0F1DB17C4F20FAAE268B6B1B7E08FFAAEC622A8AEA1F
      E5E2922A38E3F432AD2D41DF38A4D80BEFCE2E08FB67A2BDA292596384A8A6E0
      83054DC7F9CDB428D724E2064429154C531A49A09326E88588CA27BE9A7043C3
      5D60FFE92CAE39515D2D4E4AECD185A609B0E44EA9122F4CC79351AFD8BFB6EE
      0579ED5EF453F47F384F6EC95DC7259D301F29F3D7CC92E5BC76F91B9FE716A7
      162CDADB14EA5A4FD31A9B78287BEA3888B600B82738EBD8450825E00766DCB8
      A1B59BBFB9E557B6FCBE4AE6E362B165A910ED66A6D111599CDA13CCBE0B2D6D
      D01BDDAC085B57F26398BD922FA1951CB4E4C3D7A431CC3ABDE1BEDF22AF6593
      A337F876C8630DD23D9CD09241D03816CE5EBE584857D2840D49599A142F5FDC
      215F291052E46060C8A41C954BBF19F8AC6F4131344F455FD2A0F385CA9C72A5
      70B2CFB97D6FCED36F1461718AC5370A8B04C59B6C9619FE59BD3F16071C5DF0
      76A884F2F4A017BD32B9B8F31B645AF908BFE536C1A3137229ABA8C4F5B28EA3
      C5E97C441C55EA358C8412D8087D4BCC4B42E72B5FE2F51CA5902E73D00BE3BC
      8EE229B39A203503D28520778CF24E940C5C52E84AB35044142DC895E25C3017
      DFF223E31CB93FD74EB1BB63890BBE4ED6AD79742B96BB5B14638433F6A596C1
      AA376DFE20A434EB5D2A473AE3B2634D33948FB848041091A8AD898E31ABC965
      CD9489826C7235ED7FD87786B2E48822968B24294D9A53159995D3F321998833
      205A03229E56683752E87C691107E0686552A19C1B5AC5F58601CEA3EF7777DB
      6925B4A428E83D69ECA83AE6DEF3BF7DAA926CEB4138933F004B411C6776CE8D
      786BB865A05C417849914095167CDED32ADE9E8489D75E7D8E54EBA7D7748F1A
      208A74C410E85FFF1B27EFAFFFC3CD660AB9B033430344606A591F904A93B826
      CECF5AA2B01314BC49F3790DC305D593C8B4D7DDA398B79991B6F5999366BC43
      59818D57C8379E897085BA5241DE341E94C944BE82212744295197204B29CD45
      4AFFD75F6D40B8BF925F7FEDC82E8847AC442B68031F26D2EF94C5914A065CF6
      761665C5E586FD561CF1367383A93B9B1A1C07455EB3DFD15F4372B4CA06B138
      3C5B5D736EF8E7307BFDAF5A8689174B38D8DE81945927651F1FEA9DB4591B94
      D4B736F888B00D3D956CCF96C964A5DFD8DF7FF5EB7F636A7EFD9FE8AF32477A
      CD1086F30FDE5C1206EA227D1C359259683D6172BBDA9CC5E4F6CDB86E1568E6
      998B58F0793E23E8F64DAE65263486A4CE91AB4D15EAA248E7E5A6D2E8296021
      BA933E31D9054EF6DF7F04EC9104BC8520D92DB83A713E83A30C178CDD802BB6
      E82CADCACE0F2E0751D3E5B5B1FF61FFD9D3BB0CA2FC40EF9EF0C671229CDCA5
      EAD501DCB17B2AD8B01B37A23EA2B39EEDF13A23216F8FA7FCADDCABCD07EA98
      04EB64EC99FB64A616E36486FFD8C0FCD5B24CEAD05900D2599462AAF3645407
      DEB4D0BC79B7F7EEFC38EAC292839A27161B158EE3510DFC5DBFAF4B45E3226A
      F384C9C9AED35D40034255932A98EE61B254A51B6C4AECA71D0C35314294E368
      A8C173FF988CC7580881442F59313BC8D020854FEEFC603CC445495161D9EB06
      C125E12BBB1E2BF6A24776F36FBAA0201090E9373670B6037209C01BC6386E6F
      448E59A338F1AB2E51C658CD1A4032215329F3CB04569D9FF5622B565652F214
      2D02E4D24961866776176ACF504A0DFB17F600DFEC5190709CE602D01150B048
      3A5FCC2EBFA58378767E07FA035FCE5E777D161EE5BC3C38B8304A2C0D9E5CC6
      B02199492B1DDC0EB37D233BC83D9BFA8C10F6286D650B00C6C38A5A913D4FF6
      A3920AE0F41E0BECB1B2645B4F92E9BBC63F31F78BCCE6ED0AD253FF7956A2F9
      1ACAF398969B99C923D2AA872E9B1F2FF74A34DA5953D4974795AB129A1A1A80
      171B4CC6A2595C33D894B6D629BF8112A54474FC9C11ED421841820E4B57F71D
      41759C154BA668B1ABAEC4E7C0FEA6EAA342FED3B78010BB3D78BB7E5D84EA93
      9B75AD358ABA487435D8FE12794FE23D40C1450A69008C2D3A1B66E957263A9A
      B3FF4CB6B6FD278921C9652C1065A31F22055E8531635F33114A99D64113F86E
      FBD2D28560D5E420A0681A24C968693ECAE6A437E4403A2416E24727EA36143C
      CDE7685570BDF3EC79D571F737490E805340C865E934B74E9EF63110B868C188
      E1FA71E7E193A7DF3F8DBA3C2AFBD109CA7947C73B4DE581206D5DB236FBA359
      5FEFEC577FB127FDA43982C107A05E0AF1655E4F7EE0A6F60D8B35C894F65B55
      4D1A0251AE68F55A0DC0F6E1229A0DED61D0298BABE8E3C5D10F8346F2B402DD
      CD2689ACB5ED19FF5CA5729012AD2B8410069E2E8E616E8552DC205CB7521E37
      40C8164F12BE9EE9F6357808CE9453613DC2DF3358F3BA4DB12C437DBFE67ADD
      FC723CD18656DE8BC1CEEB62719F1F0AC85E6463D9826108B3D1757947ECE6CB
      1CAFBEDD251997F1301D457DACF9175B3D017E2D26B8CF49DDEE11FF4A4657D2
      87DDAD1E308E21CA254F78BAD51392FC32BBE7232628F67BCF47C0E7BCD7132E
      93720AF1B67B3CA14C922FF280675B3DE06A9E5FA230417E9F194DEB384BEFF7
      22FF8C67F17D57665E94D7C9E53D3B3293A4EE7B8C064ED7F9E55C5E66EB7E94
      F3AA72AFF264AB4754B37BEFB4EA3A19DFF311F5BCFCE21EF17CEDF17A7EF807
      1CA42B0E90257D32B34E95095C80E70FE9E8D23EAEB8C844A28E4C22BDA299F1
      14881934E42FD6278F344A3FC11256E1083E9B0EAEA4A3B926BA149E29CDF690
      3884938933DF56348586C5D764072833398B5228A4ADD0C15A2940A6AAA8F351
      6A41857F7EE52ABD8640158BBF006F5BABD0252693D744CC0BF2C702404464D1
      E06A2DF6CD2CCC19CB344A493D7068B46C3BADA6E897D1CC0CB1CF80EC434111
      A15449CD6F615A2AD1235D0D6487CF5CF53D5DEA7F8501BBEA7B5F403F2BF2BF
      BE78F1E2C53A94CFB342E99A8BC01C925B9C912CA51B3C8C25DC1B3C3B4A512A
      49A80CCCEE61AE2E59B431D0F8F58A6ABE756F8592082B641218A952785ACCF9
      C0624FABA66C9A2DD9CDCD44957377BF5C8F5E59C28F9AD981185DE750A6A613
      753B877947E44FECA82175D8EFDA099DA9D0F67783B0444CD6BC9CECD55FEC11
      3F41FF87402F37755593C1D2AA1D2372B5D7694D766CE83C0496B82B5ADF500D
      A2A3265A02F8295DE600D074BF76FBFF2FF03E7E1AA479AA5086FB4B6AB638CB
      DE4C1A0EB7312BAA85EFD0D9A52829DD9A3B58FE6D776443FACF22EF7A29822B
      F9A6AD268C3C621C543FD1958EBFF0AB4A29E81C680D993F2F474840D85BBB6D
      267196816CBCBC4738BAE65A4FCD7A43D85ED7AD78985D5ECF4767CF7B5EA447
      BF8001A0A3A893216515936FD406D04368B5CC09E37DE1B0892F2AC0C3A2274F
      D09B79921AE9C648A8C094C66B084FD33B344660E81DFA233D0884FA53D530E4
      01E597D5EFFB2FDDB3C1F724F8C9861506302E571C61DA50EA0A7BD2F56A9C54
      CC25B6775D4D2759BE7CB4B416308E6063F262D273505E5873E1A3D115948D48
      E0E049DC827560AA08ABC15DE8BED1806EB728E678AF45BA2A837309ACB772F1
      2C7EBF19A50803144B06144B6139F2E04AB8D5CD84D9A8ABD0D0B2230DCC9B10
      AF5A388E7738B382C028B7515658CF7799261262692DBB32886A51660BDF4307
      614C79C15DD61F7633628F0813B86E9D268D287BC9772F409D65D19FF3A2FEB3
      298135ACC1D6126A1406EA628471890588E186E19625E666E3D1B69675695E66
      C5906772705874F11633571105E8DCF24B6D27D4751BCD427410E979A3599F4D
      879F376E5E2F8ABE1D98D81FCD9A3436BC2D8E6DEAE0182F91992A3DDF1DDAE9
      24D6946B8B2507C38901330A4AF37045AC99C14B457387710582CE4D78E08667
      E59A73579ED213D3D6970296154BE5BA266C27476E50B039386E573307095B43
      D330BB512181C68D72DBB251F580C6F5422BD2D602F7C65F46B357DFBE7DFBF6
      13533954E35A8E0B792949F8E82E72D37DAE23476210E1312E27DC96437ED336
      9C6559F4643CE0070E82ADCFF1A60E137959CF8D0E4C731C875F9648847DB7D2
      27E005767F7CB6FBD35DCC23978DB1D6C268A76F44791297B7D009E8A46926E6
      522951DDED4B83F9AB5D237112ED87AF0C4A59FF130D09D8FD61E1E257126358
      0832AC7FE092F5D67CEA13FFD4FD9B32CDB274B4C163191E5878DC8BEF77779F
      44DD8F1747FD1FD6EB692EB1008C76E7C6DEA980B5395C5971B9DA39DDDD7DB5
      BBFB395446074D2A295F45BFA821A5933238BFF870FCEECDF9677DB57B8D8E0A
      8B348C385AB6094D22A8553CF2740089D414751B9B69BF8B3F869CF5774BA7A3
      2E6D016B7CE7AE73E2026BB8AD9AEF11D45E4FF9224EA15042843E74B7D1DC3C
      5F3E37C1899B54D3CFA8C2E5925ABAE4F6BCDAFBF1E88767AF8F8E761EAA8D07
      1BC2BB347A4E0B4E79656BA87E8B538363F41FFFF8C73F7E6AA4C7E2E80DAE81
      7B4FD293A7CBDF657F66A56D2F92AA1E24D5EC9641E4ECBD95DCA803DFB1D563
      BA2A59D7E7CA5C6DA0528B2B215BFC8967F096899509088898EC79352A918F2A
      5993165B05CD4652A1A62959ED184847A009C3F65ABAC1B4B35B11CFD54225C1
      E120F516500D0A3EAFC5F8DF7D0ADFAA0D29F1CE1730933CBF35C9022A1D0BA5
      3DF5A89F7B7FC209F1CFB2F9659A5783FA5BBDD1E30C6FF3858FD5234D73117C
      0EB25AB86C830624133378432965D2FE9D98A892C5EAE0B4221EF3371B753478
      E55EAB32AD54C5C51F9B19348D40386BDA4AF85BE5DC2407478BE65649AD288B
      F0C69126A775214241FA3B2CE03620BB0AC37F32207C1F52C737FEED53F9AD69
      885753A8EB9D1F6EFCFB67F2FBB3C9241DC1F73F38D9C72B5FC5E518F693BD4E
      3F9C818D1FFEBCF962FFF5E983F590D7FAA70F8D18C9F3E8D3878D1FFDBD3C7A
      9F1E469147FBD91C715A5DA60FD3FD17D2C68290F9C60F78290F58266CBED23E
      3E9E18F535204407BB50947D250F31A0D08847AD373076A26C6C965C8373C610
      936AD389407F9B7FA3DA81816D27ABDFFF2CE0F24833486850020DE98DD5F2D7
      5576C80CD12A768E2EAA4B62C5F7875931FA721741B96BE3E03A873C1A53E572
      ADF3B1F00329E16E39AC0E39D0EFC1836D1E69B14BE200C6CCAAEEEE6F3A75D0
      2E072D562A21F4A2CE486BCD0F0603BEB8A87056E93485809F2B4556EDDC22C8
      AEF7DF06126EB8FE049988BD0EA32C069D232875BB827D0BCB6293B20B520F15
      7557548B1D77D999A4E5AA98AAA0A52808ACD5198C25EDC59E8222353B3DB7D3
      7A3E3BB26BF5CC75F3EEF4C4B2D09684821C4E8D906C34A9F73D32CDBEAD3DB7
      8DE919261243BE9F65655D111A849D581D8440041DD54DCACAC81AD5FBCA6E15
      2B054EAE1F9D25FEF97FFF178ED697A4AFC8DBFFFEAF78B23178D4045213C8C6
      ADBD2EFDBAB55792ED671B5B9FD34C490F92DDF9779A43ED9561F15576F797C1
      E7501FF2977F7C5E1D9083223C2F658B1053B054F33E88018D250146B2B35BBD
      BC93CADD7E5D66DFA936195E4EDE886C5A89CBAAF48E1E680CBD2E291548B446
      9473F9C6673FAFAFBCEC4E8FCE7E7BC7F75890069127877A0827DCF6635015D2
      907F1F6F90DC07C1E80FCF4F1FBB4DA29C6709AD23A0BED65AD9A0A361A92B7F
      5E3213610A89C945F0705519223A1371163D527DFA22E71EF57252483BC482A5
      C8193A3596191D61461FADC4F1C2E2355B3E7F41DD5F63B792B68A42606BC40F
      698B7ABD7D2B95C2D62CE27D9564E3688CDD83F61B2B56B6A788637BC74F8E8E
      1EFE57049AC5ABE82243B3AA6FB264474349EE9D818CDD4151E98819CCAEBC40
      328E069757053214D7E7BFE8373D22643636E8AC3782777635A4A7C73432FE24
      2792FC4D86AD4DE74093455CBEA13EDE27C4AF31986225D46A03A452045D140E
      BD2CEBF063403E5415587DA81ECA7B98681D3A29C7823CF1E3B1779F28D6B9C1
      1BAC2C4D1F5EFB0519DFA7C55835BA37CB4DD22FC32C8B2689D4F2D274695DE9
      4EB556293905AEEC74AAA14E7CEDB2A0C3ADC93F758D81C527E1DD3D8BABD5EE
      1B4D43AB67591728D4294195AB789E09E2BFF06E3D6F3D69EAB7BE42A3528C00
      C2425F9201C34420A9E352ABBA32734783103DDEDE9643368DF398012FD7F69A
      8A4AF63D1951654CD7E8890C22C7D6B284BAB081AFC11ACD2F771C3EC54BCDC9
      8AAB91A122784EC996EB8B840BB34A5C4656582F14773323162EB588A6FB0E95
      79AF9448A5291D55F00CEE359F240576743A4A67D455665C4FB4BBA07922278A
      988D2D415AA766829351CD3994F1113CE64A70FDF96CD3216550454AE6198344
      07CFD34AD4742CCAF432C545A20E8C0CE69A86AA049994CAF0A1518328B71523
      0F0404B4FC265399B5CEAA1C2548BF6EBDAB4EDCF02658BE920C8A0300C6E274
      56DF2C9544D7CC6F08FF8B918E529494F053AD5FD7B7CE20B85B2C5BCE143328
      08E1B60ADC3CEC946921142290A498E74378C30A523CD9DD7DC47538853EB696
      85313EBE338FFCD87051BA5A79568F4900B4B80E1B74752FC2E224AB5E4CD488
      E22FF0696B3964A49038BDCE42D5835B0853CFA95D8BD7058B51278A39F0523E
      B539C1726B4EB06C20E4041D602BA387FEFBE9830212F1736C1C9C3CAD39DF3C
      10A6CEA92C6F6F92C89DB1D6302356E9C15C5AED440FED9CB3CA46B736E18230
      3ACCFE5329EDA04EA77ADFFA28BA020B4FC2D8E13298E2322B008F55EE345EEB
      59F9761D5FC2BBA4BDA82A5C81BC71AA1A43526E420929E3F46B3A86D9D09824
      755B53EA40AE57C086DBC1E8B5AEC5C073A3F23D809124AEA07FC6DAD0B14F02
      B566D71D30927649C840CBD905D9ECE6D284C2F59B2FA543EAE93C3E10CD013E
      F843C20DE1C6647D0C7FB1746A43D691136CA5492179A58D81992275B35D5BBD
      F0068E7DE544BC7BC97EF1F5B370CA149917B3C8ADD936087357856EC1FEC22B
      7C33D4028A53020A17760C04F6928CCEC7E3F514394A7908D1C1FBDB4F1DD4D6
      C0EB9666AB3B8662581FB0B3DFECD26030E834EA53D6AD09A50A3296181F41BF
      F73450215872FD98F6A64A4CD13D96465BA7CAA8C82BBD423462621E61A85EEB
      30312437CD60583A43D93D092652B15AC849703928946050A5AA5E51504E4613
      DE9D52AB689DD5A02C5475F4CC89D398C5D455E3E03B4C87195F4CF35BBE179A
      8583BF2EEC8C78F5ACF4022389013C5F720976447B6A9C286B730B06A2A83231
      6ED239435C26625A18ECB9705483DB65BBCF013FB44B91699E0EE7B563ADF89A
      667A0798B8313B45610B6E183B9E053FF1A4147DB057A0F27976002083553488
      F668EEE03A4EA1A377D98037DCEA692E3DCB340D6B5B2C5951EE7BC2A9DFFCF0
      683D67DDC26C37EBAB701BEFAE312CAC801D241E6E748DC066682190C2F70F17
      D1718E62701B018EFA0C91E49CCF704C107C68AFC9E8BB685F04FF3FA202A0FE
      FB00C6C3AA66F63FECB7FA491D4BE380058D9C5FA593FA3BE9B9D19863C3CB45
      45578E121E6534FAF4CBE944A217328ACE9E65D3040E963E66AD37D0C4FE8016
      7ED8B757192730B09A837EC0CFD62110619C853D5C54C2B5E109422B81C6974F
      2B6908A2087E44CDE560342A69A42739B6D7A9BA8E7E348290A70435AF632453
      98C2D06AB8231E5D35E9255ECD0688E3965ABB0E05EC33B9D8163B6437039D66
      B143E0E2296EA63D76E103B7190535230B6E4B3D0089DCF42323493475CE58B5
      8A83D070D6B76BEBBC98972364F9EDB5CFE0766372233B34C0C3074DCEA4C638
      6410D41B1595F9606C8371D59715F669400266D3DA3BEBC9F2036BD3573D2ACA
      A1F4A78F8D11BE9B8B1C0A7016A22A697E8F991469D0E8E44C9A0410A7AF1EEC
      B5703F8502BC7E4C35A8EA68D20BE3D1B2235D528C8D7300C50B039E21B25BB6
      CBCBA778A7974FC3774AF2715C5DF19DB47077BFCD2D684A023AE0710A6CAE84
      5D1467D960AB16D33C7A8D282C6A7D620D1679958CE68DC8A7AE41D827083D50
      513E965F0DA2BDFCC645545C948C71DDF6A02B8D1D4EB6AD0CF57B179F44F3E1
      D627998CDE2D0FA2B4A033C55D412C7994530C66FDE51B19DFF5963F4E403B12
      A43000EF0B9A6F6ADF0823C5DD209467E6F5065A34207F15D7E657DDBE66E9D2
      D5629B3A6E4DF00C921C5038248DCCC6E73205A125665CADBD6ECDB6A4F94791
      214E29BCE0A4DCEE707FDFB073DFA99DAB6C1B6717B8CB57A032CDFC0A4519C2
      D3BDFD377D4817DA889547D65B51C74D7BCC8EBA8B9F3817A36C37B6FBB539EA
      15CD6E887C88B4849ACC593A1B16ACF7E1EC7F9E353487F5FCD0EFBE23D56C5D
      E9A6A596F2A2C9CB40646F9923E0045A7C9076C119B8CD380D6AB440945F527F
      A6C59845233583B5711806D6FF06FA9A7C3543478246E1F3B6018DC0E3753297
      8DE86C5DA697978CCD9B639027D700F76869B987D37669AA758A2EDAB230FA0A
      6FA1350C2B8186F67739DE2DCA5A23E7C11B854B52CCDCC3369019E3E6B6C4B6
      C0F303DE191AA76E783406BDF6C0131287B0EE85C468491946E0C899CF729564
      AB5D9C3300CC0B03E4557C6F1D1BF98E24AED0166C8AE8AFF38714DCA175B4BC
      7995D31E26120683A97E9B39AE29AC1AE9130D9B865CFB52436625C4A781A98D
      80AC3D5850D84395874030BB7E56E12601A78B3A8C4CDD8224B558FACB4AD5AF
      57585C601FA9C0AD14BEB91D9F56A30C036BC5EDF45EF016A11D9D5C10ED4310
      5E8D681736827C4D40FF2EA9DA59F2FB4C81F88E419F7EF75968E0157EE06D07
      392029373298472F979D1262CCD22D5E12C4BE7D484949356FFD6146338F3A42
      74A5D79CE67FECA88690DCC2326F5FC3EB2EDE3066585F59AE5F5E081E503AA2
      5808CDED7FD8DFE08A5581BA252BC00D8BEB5E1055B10EDED230FA1CAE8EF578
      F02686CE5551B03131361A311E11C5D67A53DA27A22ACE2070A08AD1BB4296C4
      DDC816787119A764BC56B5B6F5FDE6EAC2958A00FB7500117AECC45F296EB40C
      7088ABC52777BFEDDC41FA770E9988F6333A9B33A76E79802076D43EEEFB93C2
      6712FEF2EDB3BDC46A1AD5F783685F3136092FD169B244745EB9A2105241174F
      56721E3D5DCF63BBBD6FBC3E5CDA8D9F87969AFDD2D88C04631646233C646EB1
      497B8E02D1B8D9AC51FAA0787349660C620EF1708397151AB762F78B2F49915E
      2D1C69A8EA92D7A0F2346926F0619D356DD534974549968E129374C599BF4BE1
      05CBE51152F42FA6ACFDD9FB207EC03AEB76A4D01797FDD2CF56D7455E575D0A
      8DD04FC0C3DE987C6DE9C164529853C90D0445FCC56940E19401CA8396493D2F
      250D4CD28B610F572E89C9D94171158DCBF8D2E5EACB8E7159408D027E6A3FA9
      086392656EC1F351252AF185CBCFAE41B9EBC8A4D0EA85C6039D95C53043F930
      E7C9D800AFC1DC59BD83D3E445D457CD571B3CE7C0A8B9A29AECA497AC987992
      DA0266A421A35289EE6B92390AAE2D08BDED8C17002F3E947FE7F5672CFDBB2C
      763BE29C1894C94DAD178F3170C7492AA0408ED009EC6156B60B03D4388FF835
      C969B34284AB1A7CAB045989D6101BD9CB345EE32847CA7593F302A68F85EE2B
      025AA92859BBBE7980809D59572357ADA0515CE9C51F3298021D2D97EB02928C
      04B78CA5E5BE28826A5A9F51C82226A72418ED1D6E5652B485A0A208C6BA38DE
      729987906AA6E60BCDAEE0F952A2C5986F0D1697C89B057C7BFDA2EA884D6745
      09ED58C77FBD8EC5AB84E28AB114814883D84EC389E599C4E9C68F28ADA6CC3E
      3B5E10834070339916E58D959E5BA696DA1C823E87EC806F84721455AB6C16E8
      9185A59C75DDBFFEAA42CA8CDEF722F7F9381B55BD687FBFDA69C0D0481A13C0
      7549FFEED4BD573112D37A436410F646C8920D3AEC58710D5470832E08F8CC00
      31EA23AAD4B27FADE586F2AA029DE7401C3EE652C4E76D9AD79DA84CA85F56F9
      43BA43430EEFD551DB6EAD51B1ECC1582A6A55B7CAF97651A7D4D57A610EA855
      7156881918EA5C9F660C55EADE8AC5F264D7AADB447104F99502754351DDCAED
      6C7154E6B9FC26899AC5466177547E916A4B0AB781AF565C2B9F19988CDF74FA
      CDD5716D43E7C90C41A73CAB53B604F868A480B7194C9B3FF7977F2073C63781
      B459AB55A78CEC27DF5BC11EDDC1292A2A54585FA8110B0B14693274E7D0BFBC
      28FE95B81FBB11BEE345050F4A0C490BEFF8F2B345BE58A274E1A6EFB41ED37D
      5D64E31DFB6D4717513B36DED5C524749472BE46D9EFD67C0B3D128DD7AAE185
      E9EDEFA4C9CF4A736534C6B8AA0886A1EF77A859AA385E9A372DAA8D13979699
      63A29687F78BB1618417D917D142158EC41B1D83F68E9438A7E82EF1E19D5E74
      94153178C2C88BE30050555E3E903ABBBC6BDDB384C8C8340E15665B97FF82E3
      C396F6B2CEA98EBD68D0200C1D8DCB62267414EC6432926705530BE2CC82A8DD
      846E0D8D19AD7E1AD8E457F34B2448749D41C9E09D709BE3CB3CADE7E364078E
      11EC833BCCA1AC0CC319D1EE3AFF63C94FA2AE8A7C0E6F96CE7093FA457B3010
      FCDFD13947CE491549161BB43C8414439B625826F11765565AC95BDA6C47620E
      C7A5AF0E0037E76E25846845D4C94A5AD41E67C0172C8219628C76CB8390A784
      C6FCE82A4DD69DC01DE9428B3AEEEA8A9F145552569DD03B93D441C0172B7F5A
      49CAADC9D135B2157E19D5F6353450892BEAFF78CC8A84A338BB284E699FFC3D
      CD2BFB452FF2BFC6E7E17FCBD3D622B6CF9A7D27A019D46B0E1D23BBCD1826C2
      E9C97DB5F880A8EBDC225F6E702770B268A054AA8B11445F34D1C0E55AB81FF4
      4CA39176AB14146C36C1DBBF51F8DB16B946FCD5DAC4F4B8CB5EF56A42422A85
      28BC6A9CFEA298D723D4453726505E8C6FA902D96E5E4E3BB929A53090E5B0C8
      339C1E8755BA405194478884F234F52C91A643E9735DEC0B924D1194941897B1
      F7C9DC6E095E4A856554C74C8A66F8D410FD12831C591223AB42A58930448D92
      11FC9574DFA8EEC8035197C0CD1CC27526DFEAFC333E7BCDBE546D1B3F7B3A6F
      BD5B99C669157526A0C850C3AF1375558EC36D5D15F645DE52509CDABC229D1B
      3BC6DC541ACFB700625EF782B97774512D4C06A9C960A82121EC3A6D91639F21
      6F0B0F2531A58A4B5DCE47F51C325F66C676897869CE4D58809900A6F8519EE2
      ABED5A0DD4D6428F6512C9A6A7A95BD545C13B83C916739C7306AE45173EED0A
      048139E2C3883099DD6C983345D174372F9B13484DC6A2FA4D0B4A3ADB98561A
      53EB97829E37C10ADDD7154AEF21F906EE10463A481E104F434E50CEC049124F
      AA8ECC46E76F73DC91FC8A1D9F8291C9B9D280370C445E7BB2765EDF44AFE32A
      F9C089EA2895996ED9B0F8E61589799C59BC3C4058058571B569861438F4186C
      F7AFA220AD82DEFB8727279841E4F959CD61F9EACE269BABD5394F0AEF45DFF5
      A2BE8CD39F21645CB593F21495893A022F02B6E8F4DC7FBD2BF2C486F938FF0A
      43C245863AEB936B25872528A86AC7BE95139745602EA245796D8F596E49B053
      4D13969120CB1BD19812F5786223C26879464BC3D7E9722C17D273F84575425D
      C5B5B16BB7C5542170E423CCD2E25D3CA57874A558F2862515C3E0A11B442333
      ACCEC4AD12180006F30D13DE804050EC8171B6A1264828E16D65AB97BC894B30
      D51A864E116B7823FD5C03F61AAB15EC4732EE1059E8B8A63A84092D5D5B0A69
      F53CC418A3564A75255090C3990D9C0D3301E5460F4118C5F5AB422E0741BEEB
      321D7D41B5B74A84279C9F81CBB2A03AA7B87B75826A89D626C48AD727979EC9
      FE5E368A6E9AAD24F1627D717F72BA473C9EE7FE7176C6F8B713F461D154DC08
      87DF57BD7191AEB444CEE5BD77F526B11E19B2969ADD7349CB9DACACDE6D9AF1
      B19400872A19D49069E5204AE2C2A052DF1E618578C8B31579F9A2F87277B7BB
      A3D70AA4682A167AE804AA762BC3488BE52F09CACAC13A2913789A963E1EB612
      1C7FD6CE207AADA9DC9698CBFBBF203071BA777E1155F3A19B5987FA06C687C6
      29F95CBABDD0A1B48A6B8EC12AAAE47285F3708380ABC42D54E5CE181FF35CEA
      750167C1F4700DE1064DC4BE01BD37CDA39C399D3B1CFF595248A15B52A39C30
      034A732433B355E2DCB4A9C4EFD72A709853573733AC0ABA41F94E7FBAFB5AD2
      66F5C0925510DE8CB1BA68CC866578C92AD71CFD788C8C4ECD0803FFC5CA1724
      51676F3CD60784B1C23BB2469635CA094FDAED92685B89128355A774A9F86A79
      48253E673BB8FC2C7B501EFD364F2A57E0D7BD0A4DAFCD5E66B5C54442858F77
      D8AA37B268B8F899B069951D483BB68BB911AF22DA2E3FE4EF241291FB6CF2BA
      88FAC73FE7C5F5DFAFE2FA787A50A4F9E5207A0F2A9056C07405271A92D938A5
      34D4A52A459AB896336FCD996CE32242B182E81A4FE05F50AD94ADDCB560B0A0
      86B2ACE88A5505AF2DB98DCC4333B5A4D528875F7C3CC245B54B213E9F921D10
      78703AAF464ECE5186C62D82A50849F895A8CB5589CCA2C50B76A7E3D62C73BE
      6D45918180375DCD946FAFC8A59D697C07A6F407DD38F48868D9EA1FEFD91BE4
      1B3D0B5014350835C01B4D514C73E2BD12AC377E462E89C476B4D8AAD4F3409A
      A7DFBB5982D3517140751AF224511C62E80F472C65129BC6A2716FD29BA1F44D
      CAD2B3B8E625B8AFB6EC8E7EDA28026AC8F6164A4CE28985B2AF008757B32D34
      907FCB2F0D8C6F918036903B40F68FF99D82261C9E9F52054EF6952FBB22B917
      5E364DD0651EA4015470AFD2E0EF69917E4826D12FEF4FFEE3C3AB5DFEDF93E7
      9F31E0063DF8CC2D2FDBF96D6568C43FB6AB995BF66096E126E2BBE4F1789DB0
      09970311048205450B12FE54C120CE02254C594C7E21AEAB9D148A7384466B5D
      C27742B73ED8253586E84CDB81E0AC2EB5A0578CFD5BEBEE602C285652D98659
      E7E62FFB6910F9D35D47185DE2B00D26953AAA42E0A67CF0749810480C4CAEE4
      DB9A24D0050BBF5115691CD7B15DF361F5DC24AC1F1047BFFEF79B789A2061E4
      D7FF19F8B7B21445BEDE3059D1A915E37B91CE361E507E5711A5763993A5035B
      F37086536D4A4566A74D6374B6D8C07B740DFBC3D514DC2C33824626F73C9E86
      2F43425818208B9377F731324ED1BE4BEF29F26527CA4A4F4B528B6E67CE6992
      279B32F38C3156AB540B7EB1240FDA670E7251D4BB9584B4DAF3533ACF77FBAD
      867D1906391FB4AD67AC1F82D6371FB75F3E25E5CDE7680986576D47746AF6CF
      B368568AA1F77F43FB58B65EC4A8AF28539058B55C17B389303ABA8AD4D980CE
      91268E10455B1A6AF202475085201F02E63C8C4FF2BC95CFF7D469A7FAAA5986
      3F1A62825468DDF32B5F1871DAA52F6DB11CE2C182252DBE605873852CE4864C
      7DA0F5EDA09690DCDAC8EA0B503A13FE4B2722819856A27ED86093EDF41AD83C
      5D3FAA8039AE45830E64142F3BB25B154D02A90F4BB912F556EBB715AF21C42A
      AA711A51ACEAB89E571B2F7459E1BF8066F35920EF3F7C7DD3D170EB3A9029B6
      2A6281CE40A871BA20E71A96F2581A6C5AE4395B75090BC22DE829E450C3E716
      F9988B9C02FFCB148C9CD9A0E1D88EDAFC1D1762F57E7DC7133AD1530B29DCD6
      F660FDC8E15D6CF4966C10FAD2B2A77BD1C7830F3DF3488E2F4E3B5195FC3627
      A24FD36626F6D633D1EE6F9F1E4A45719EBE4C15B0368474057E6B2A93755E9F
      9D9F3F3E393BBB708194E84302ECB5114F59F992B236C5AD92C04993A33E2F73
      5C3293A8734ED9CF48A2225587AE60923B7482340D78F48E34EFEC9AE38BD376
      C15A515DA6CA55E738822B1FC1978F8E1F4D23BAF31AC6412386E718E924BA8E
      4B0A25AE8195110EC3A80B162D314239D66DB00EE26B94F129C764F331D7C6DD
      A8553187A8425AE600A8B23133B225EDCF79719A096E278F86E9B00172D0D7A2
      B4AAE6AEB0BC89A50720FEB3C1D3C1134DFC7688E6126AFC02E23249BF991754
      CD134354D42B80B767AA3EC1FD838862983DE2484E1A68372A9497975A3CB74C
      69A82889343174E2A851E6B99A069BAC6972B1030EAA04D3418F274AA45B08F5
      1635A8DE6412AC2FA3D08C02873D9755ED20C259598CE7238292E984478A642A
      F136F08839266E1AE7F0A7A7497D558C713939A56B1769D7A30F231BFC39E09A
      7F3C9072050AED1D5F9CDE81198692328FF24707603DB1AE62D170F236668B1D
      2F21885964A11DE1B9D5B86CB40EA0354C28502D2CCA7C37CE2F8036AC4C06F6
      8059A634F673C659361F8C53A81CE0922FEB11EE652850FFFB7C3A8B2E0A579E
      79E31131052311FE5EC69FD337D2A9A49A976BCDF222EFEAA7BE8BBFA236D915
      B4931D2C78D7E22D3D84A6625ED7C9D8D568C33FC1F102BB4BDD99C0284C7EC3
      42B66C63D3BB0C3365DD33F5E40E533E9CFB946BFF7DD513398DB569A422311E
      344EBEF9D083D023A926A9FB6D10753F589C68E14291F303370E02B193C96007
      A99E6867FF6762445C6EF1306574A9BA9A4F262CF9138BEAA59C1B81DE492B5D
      A3D5D95695DC32218507A7BB0A4F073183C6CFAD56A972832E7356F461742ACD
      C12711843D0F6EC2777B9F4EE516E4E2F1169EC8E6F6A24B4031C4A5C7735715
      D09B9BF37282CB07098142BBA11AEB9D8BFFF4A4C46399A2B6423141ECAA4E47
      3A42BA0A787D11950FEB95E29BC9B7685414E538CDC92B0DCEF4E01B5A697255
      CF3E2CC6003D3AA0DB438079468CE2722C405E23C6CC956F8B724DA468793C5B
      3C6E3B052E9A9B8043C259EB0E8B1AC448DD07ADCDD290970E366230A0B25577
      D0E43F718AB8009E239CE9F782484D4F44CDC81CE29B2A9BF50E98A4A12F57F3
      9AAC59F527F822E51CA2F11BC0AC4E8F35102A7564480967BA1461FC02A9229E
      95C11EF4820F111B94E78562692D7A3BD2ADCAF4F20A684699C3AA7617B8EBBC
      0219F25C9759ACED35704E9593D1AAF74974F633ACF6BA4DAA8088E27AB24D2E
      E20DD11538F5B92BDC62F9371AB40E46BDB7A2A3A260E56663898D846B38CDE7
      778A3AB994C1BA408C68834CC8F0EB3E4A82E1664D358071A192D3DBE38BD3C3
      CA2069FD90D9E3C707D1DBE34B38CC1730A834F0772887F04E344CA036B56EA3
      BAB9B6A211EA5B30CCCF84902E8FED785416159408AA257A3EAB07488439C749
      56C722052DB6DFBAE1DA8B3AC16FE86039B111C568651568F24F8310C603CE76
      CE30A9AFC965BC2E3C7D004AEF62176DE29AF248EB69E5C9A01E2D3CA55252B0
      3AA70978F38457D5371E809A8570A6448EDACD877E7F602BFB97EE2D68CF2EB6
      61EC54C9022B9D99188EB7E351096A695AFF4DCDA696D438FEF2341F2FFFF26A
      28D317150E3B214C9240D85A5EABB5234C8C34E49BC14108BAE1C64D084A3615
      2B179ADF6871F52528C49294ED17A419164C4C5BE14A8C26A3B1068D6DB4D338
      9F8C9122D030BB71B4854657DC7C312021FBB0172C8320639E008994D69BF34E
      74CA44DDBF4687DCC0E7A3B2406AB1287350A5C37F8BBB054511DF24A32F08BD
      D4B210E5FE0F5E0FFABC6BFDC2513123F024F5A3ED7DBD145CF00A1C6671F7E2
      6AC92A20C782868BCBAF342DA3E67268016860E898282062A1F64DA7572B5D74
      C2CE81FEA22A8B361A378A4EEAA0AF6EEB254AC3658F2F4E7D59861D7FEA60D1
      5C17CD524E4CB815E157E7836FBA9638D20C688B85DED864B81DEE72245E2D9E
      4B1B6E73B1F2D0C4742A590E6C66E1ECA994D1891157435C125C151BB2D3624D
      DCE9C4D966ED3B34BCAC82C1D512481BDD5F6DCA60A06707097164EED6714EC2
      B71EDDAD5794A480861656F376919F0205926BDA59431A9E5B9DBD058267255A
      CF9CC6D362BCC7013D2DC6AF1578177592FA3DBAB4F77A20DFB92C6A1700C4B7
      F0846BBC09C98D97C0128108210A10FEDA49146ED23B3D779B63122E306C586E
      CD603B8AC2CE9EDE706522514B591F26CDFF4ABF7280E74ACF48557FDD6BBDEB
      66CE885610087D924B1CB32CE4D6D82F691EB6E952108DFFB5627F3598D37A5E
      D9F8B75EDD10D9843A23FDE14DDF458C79C2498A9D6828C938C900B63EB73BCA
      7FDE5A077F87AFCD54758D2062E9B5CF01B7A01A63CD4354392E2A0C03240A6E
      2A1EC8932B1C2878791B4FCCEAFB3A946A77FCF97949A780E9DF9A560DF88489
      1D726EE22F5D4D9B2FE63547541755FBB4D959523987543757DBDE81A278ECFA
      231911009F0F39AF92C93C63CD9E185B5F628D2E2C225AB6C1F3151331FD4F93
      716ABCAB5AFF1E4D0D54428D39674691D624242FAFB84C08008205C299B70BAC
      F5740EA51B48AD45148E8F9EEF02633175471FEDE365CD418BBAA7B163FF8973
      66056103035C8FD13041DD87498393A44A82777755658CCBA5A69995081A6C5E
      0ADB8CA709ABAD793A7DC08DF526D34A69493CC8527DDC63F0E4C623C262A63D
      2086E9D73863C4A5E0B06DD284A432B52DB976D16C680F6319B84090954270CC
      A16A9E0A9668442D482B7F696CCB662D013CCE2DB250A4596D560666361EFAD7
      040708FAB134C5DB249BF5A277C9B779755A2007FA4D5ABF9D0F7B084EE2B0A5
      44EFFBB82E13B8FFF1E56A1D097BFA6DB9872DE8C3DDFA88DC5CA7F918516EE9
      D87692BB781B88977BF54D0EF31296CDA64F7423A3AAD3FEBF3118FEE9A83A05
      4CCB151A8E6B5E0212B047A4CFEB8D38B2BF15858AABED3A277315F5E5CE71A5
      2958B34760851A11CB31C47D8A1953B2834BD1FAED013E89254ACC6DCB2EE9B2
      D1D19277B6CFAAA4FC8A53F14312677D1E6723663BD286E6C124DF97343FDC8E
      DA731082A343D03A106A81F9976448FAD9AE8BB69AFBD16136252A55EE7D7C54
      355679B06C502DA9B4D3457266AA229BB318218035C9D0F7B1E222BF447C379A
      CC5962301C7C1BF4CDB7ABAA3B92A1B1B1D0A42C8B0D730B9AE170A3FF5ADEDD
      52C73DDFA00597ED1B463CFCADD53920C3D737A24B596C3723CEAECDC23373BE
      5149AAD7D650696A407B09156D53F152D3A0BA4B4D333D0B7ECFA1DEA891BB8E
      B63FC5FED001F7CDAE1EF38576DDD9092C05EEE534CD0B3F4C5D268A3F1FEC0E
      BEF5A2E783A7F89FC160008B53AB2F558E686416A140733C85BA26A89F9AA1AE
      123EFAAE8E1FE556BE60DB2C3C1C24DE0A83BD350D2EE1443341EF00E5DA8154
      2653041ECBC620AF8672DB1A422E31F42ABDBCCA7805A34FD6824CC7BA59208F
      41268EB25929B590743CD992220D6EE1410A53C4901CF24D375749B42C3C28EB
      9E49D7EB3397419FA1955462F5A07E4F5E948E67DFCAFFB5A26DAE7B69800ECF
      32C4AD3841360A789E05AFC605A280FCB35FB5B0D693721AE7727DB79FBFB2FB
      9ABC63916BBB50BC865C70510CA223B93C640112C750C313A920952AFDC0DE74
      FD4D6609D46B64AD899C1F222D7A6D39D06B5A480E1E50A4799ED63777A10193
      E2709D8E51B71D94DB75D3B5F88BA82B1B8CE3066DCD65BA9A0BA293664C5A91
      DC75CAFA59A64DAB251AE3BC48A7F3A976A598445771A6F8B3C660F54F0DB2A7
      6ED9D58D39194D4BAD5692C27616ECB975472A021929D6B2DAACDAF926BD6E0E
      BF2B4CA556AA53FF20BA22C9EC226C2B899974F2BDF727D0CB56AF749432F55E
      4DC23A45D564A5CB74435AF78E4FF66ABE9E857EE026B8DA2174FFC1FD908DA8
      D5DCC6513CA574B61F3B4B476483550A49B00502A70D8AD23ED41521DC8A5F6C
      FFDE1758DBF2E26EE909F5C1939D97778580A1887E708378AFC1897DE451352A
      93246FBC219B9145E880C8460BC238668C6221F27A97573B9F0241EC03811A82
      32A15E857B6B723264EA07BFFB00E8EDC46ADABEA1601550ED255172F7284BA5
      6442D0A186CE71BEF0538DC9AF5ABD54332F0B9EEA482803B47155CEF32FA8EA
      EA145CECA178B720936655971E6E7E57661AA12B79E1593964FEB16473595CAF
      3DEB3B6B7EDFBEA4A58CEAF8B1339E1A8205AB858837A032306ABCDD117C8CDA
      85521C5E346EBD7C83E4958DD38A220D608823860B0D5EA509384D2E1C78C2A2
      C71BBC4EF2F432F77F2D107085A18F69BC4F0D3556D9C3AE319AFBAD7D35545D
      52E3A5AAB3767EA717CC13BB24BFD5126A4ADCD8BA830B2AEE4166E386E3776A
      927630B0C335B67620D7677ED2524CB258135199F9C37CA4C63E72718B3BE63D
      3514E551FB226CE7936B67594294CF2131A6DEF08616F5B44A469DDB94E575EE
      BEDF5D0FA02BEF5CCE44F64544BF68D893F923524848035E321212A95FECB778
      63C39BE84A0594B9A7A588665075F34B7243815D8EBD53F3108F4B37BDF4C920
      7C67E3C453E6D2E14BE902F6D98AE4A9D234349A8B68D74C767965A70B41A809
      55E38CA3D4D42530E52E3B6F9D18A4ED36191B46643934DB241FEF65382162FC
      7F296B5D96F18DE39E6F5EB560DD8356562480D0E8A6876B0FE2B10AB8A3894A
      277EBFC845C5A0DAF1A529D09BB5567B7A99132623A05F9B90C0FFB3F2470209
      7C8BC1B4EDB9CC260646381EC026749678C4844951A8A6CC02015AED6D659AD1
      5E14BD8EA2D72BD1EF28DA8FA2BD95B1DB557FD42A24360C36CCA10A08BABC69
      87D77475DDDBAC7E8F68F5AB809D2BAB82F6545A0A73A66B1CC8D08CFA6B23B9
      53170DFDB6AEACAF1D9C195D5D433B1A5250535D5637D5F9B91449A25DB6D856
      6C42CD58C4B6E68973B1C1B97E16CA96C6C35EA031D7B02451FDCA72D987B1C6
      ED4CBC7103F7F21899354B2492863752412FCEC78FD16F048DD7D7690C120B69
      367C81784DA01969626F9AE320E9821817897637820532ADB8D97185D04C8791
      2F722F74D88A626D6AB30C0FEC2C7717B34FBC32AED26C5C26792FC2CB434047
      A2EFD2242480F463DC04F21254EE089234D611322F0AD3D4A4A89C07AEBE2437
      92E93CAFB6B422915BFC0ECBF1DF3880365F3A0548F3DAEEB175F6DD277B2267
      FDDE8F7472BAA06FBF723DEDFF648BABFF936FACFF5353AA77AB16838ADAAFC4
      E6B0466F792FF4EEF6663750A9D1022032CBE4FD2AC1ADF1D4D5E72941E253EC
      F28FB3C7E87BD48587B28312E1E4DA5BCD70FDA3AD2182C96E81D105A43412FC
      C33ABE098B9DA2A37A536F502D0A7A39AE0B5A20FCF65651BD43641915669373
      D49A5B1E43088208665F1CF1916175499720A7E3D959A65E2E7567352F51ED3B
      35C01D759F3916E3D07464AEB458A1E21FE29DED65371822AA6AAF1B087C6976
      EBC8AF47442B00B3140D435A7B160F13292CB362C52E9ECDC14FBB3E3E6177E2
      52956C092A112F6966B31854F07F9BFBD2E6C68D6CCBEF1331FF219B333145B5
      29AA16B95C965F7787D6B29EB5B5A8AAF21BDBD10192A0842E12A001B054EAE8
      F9EF13E7DC7B13098ADA00F58BF607474922814422979BF79EE58A781B9F3731
      8A11FBE2A9F89A3C9EC65F806403C22648F92C072D69301EA401E5CD5CA1A298
      E192A8A676BE875131530D1147A9023FFD3DA82E32B40BE9DA8DF5111C03252D
      2A06D54BCC09ADA1F3CB5E1CCF7F13798B405B6003D134E0150F21E6190C0784
      C8E8D625BBB56BAAEAA9BF76659E2318C725082C62609FDFAFA9A44481670F09
      B01A7AABD8AAA69522F7E9FC688F11913BDF3F38AF7E8F4FAD1949B2124C0E22
      00128B95498B3DFA565F7278F69FA62068E56F2DD048A255D60353859185A158
      75C780D92B6FF97E7A18761511B135F630A78B9DF02CA18E7A183012BE05965C
      34C88A78C48BD58C9F6410DC52C1803595175AD5A4FB289F15B1402EF4409862
      859CCE6CF98B15D63E9A26E58DEB8A7AA6C9E7F0542D8C092B97E21DE719B172
      BB3FAD11FE86E1B94A519D0C464CC678BCF5780ACA61FA7728E5814253844D7D
      6842DDFBC547389629460BB1E03DC2577AC208C4D4557E4A33C6B02B5AF2C313
      ABE7CC8F1EEE56686A302EBB7FF2632814E4C071D4AB1ED655AC04B6CF2098C8
      3FF5DA8556105888ACC168D3E6793C496E991F2E1D493497009EE6F2A9011E8C
      E6BF0E148E6CBF433CC2E19E6C38586E2AAD3B5DA7B1E087D6D86AA1614BA83A
      8EACB6005BB1A530C9821B7925C29BB8AC78D955AFD7341E45888218BC6AB552
      C3D132BE1F29FA49A414B6E4FC53F3D03E39BD30C72748D2D49494F43C3453B0
      5A752AD2F7213F2526B506CAE613285ABA4B8C96361ED71528D4973857F9806A
      AFB877DADCFE5EA762F786892E63BF88D2F09DEDF01BD4A344744F025A1084C6
      6A9D8C976D0D433F57EC92302BE341AEB5EED5C5F731B084955DF02502F55414
      5F29182E959DDB6DA8DD4E8934AA1DBE5A739B29E311BBAAA6FB5BA96A5B4B60
      91C8B167BE70C0585F26C625195D6589109F3BFF057D08E100AB0CCC49E67FF1
      983ED0D8A7AA00DCA6DA5817AC7CA81026F2C0D3E996CCF0C6942E6A3DC864BE
      7EED763398D0C1E7EF7F11A1591ECF468F08F8655926FE6E7913E991955B0BD7
      30FE9F340D57B926AA0449C094933CC5928BF4248C1ACC51449E545F4BF50515
      CAD349339D2E77949A7A55823A721D6944A00875BBEBAD2BA5A6FE5123825D8D
      0824C0A9C713D904F204E845461E914A60853DEB6B7AB30520A74F48BD09B748
      B77CD06D31E0F707479DC78BC74364AFB8B571F315FA0DEECFEE7F1F1C1C086F
      A78433A09C4CAB10802657145A0FB6C5FFF813BF46856E2E0A9308AE63216CBE
      CCD007E94DCDF84247F123385DFF96BBD3B9E96DFB779267B387C9D65A5052F3
      EBCAA4D19EAAB88AA08A8149E0A3CAE008797FECC7F5F0AEB1F2EFD9C5F7CBED
      56167A91985B60E692EDEC434A6A6F5082DC3C4FC2D54BD66579534FAAF3BFA7
      D6BD88C706469CE8CCD393ED639F1DBBEF69D60F92AF67583B8A12EA5F1BEB27
      59FD37785FEB9257C745E503F653785B537411057E02408228DF2B0630C7813E
      9F090D5B71D12463CDF607C7C9E46940B6693497D8F8C454722D937F7FA41348
      EADA17544A8030B35FD67F73C5CD6C984D2B9F94009038921BCB8AF380318134
      51D4F2E3AF739596F7757E39E30432F8B29F5AE6852B1D65E9943E2755547A54
      D97ECE750D3E9C1293E0949BE597196DA86B4569DC17797D0F22D4F14981EF8C
      A391F62158FBF3BEEB4AA8AF791E53D2514B38EE525866C7DEAC48259FABBC90
      6942CA1FEC9B060066E927099C57BCCE975C709987B4226763D9453B084B8291
      80562FD8B14EC18E499E69A559CDB554F1C25EA4BD1CA1912FBF0E66BE2A1D98
      654919B3C90B5F16B6A1E9B452CEE647A12BE2AF8270122B1325C12CAD819CA6
      1EEDC6B75E9E31BA96D17C8F5195090F91DE138DCF657D1070BB659C060A697E
      40924654FFBE7C38FCBAEFD5151720AFD2EEA0D3423F2FF382D7EC06A9637DB9
      0AE55654A1600BD0C32BEEE13B9BD712F49FD8258B227CED1AF61CF7F7615DD3
      DF8F304D7EFEB2FE5B4F2B5721FFB2EA593FF7252B3E16E3C4E5CB8CE3821296
      EA5FAED9DF9772AC0F4BADCC55498EA15809CBD1A33952D90A1732513F4233C3
      FBBB55A5DCC07449ABF768769D2E2BF262D9F51380F02748F24858E664EF0DB4
      D61F04A6D5BFDDF1D3EEB65389956A2BD0540286DCD7872111660A014255206E
      2AA3E72F9CD5752DCC980B9AA6392C09597B44FC410D0FBE71AF9E52CCAE1E47
      B7352E08556ACC34421FEA39BFC379F881D7A10DEF620A63C1912848C315B79C
      B1EEB00CB94B5E5DC03535D451E56B4C3C84F2306B6DD2CC9B1D91325B9B2837
      5A358FD6A0B4035BBE02FEFC64338CB19BC4F1989BA166C838DB7C86EC5E14E5
      DECA6F805492C88A56F9A785FE48A1CE7C4F8BA6F4DF2003860711A4CC20DD15
      BA8569C4D2115FA25FFC0D7F53A34DF98AC75AA4991667EC2F7EFB9D663C62AA
      C9B239341B4D5E9A56938682784EA88DAFC34241D7A368C9332114497B54D18A
      A84DE1E0E901CF744AB0EE2F772F02A0404A20B322A44E4D9CEB8A9BA28C6748
      553E7E40AC63BE339D0AA605872A28A93EF27D68EE55DF0F0C5E2CA1E6A7E12D
      4314CB32A563555833C56E2FEF4D1C324EAFB2CCD792CD81B83583436E48C567
      A8CFEBDDE85A18DC8FA1CB0A09ED4A24DC5B1D3EE18412CDE223E8186E40D40F
      B51BFC743F382BF8A0252830220F3607FBB6AA9B73E9C3B934A8FB6B92A3A8F1
      ADA931A86283464933629966742AAEBEFE020C6041A6557F0F4DDB8C1FB5146C
      99C175D51BF703A43B675179D521C6C8BC3E2B65052B8061863DECDE66B786B0
      ADD4256DDD59B19A9BBB5C92EA93DE49780C0A2E7E67092C851F6B3057CFFED4
      F8D40285F6E7470E00BC31940FE4244F068C32D2653D13B945ABC89076F580EC
      32A726BE46ADCD6A7A2E032B1140A38A1917C16CF6B49B25D6C3ADB79DA4952E
      B80A57AB4234685EF25A77A2D167641F690843ABB5A766016E1BD6D5045C558D
      FBEBFD54AF6DB530AFF440575F235867CDFF22384D867A99A68559693AF0353D
      146B331327F21FA1EBA53737121FAF204B056B4153EC56FD528DC00DA113FC1D
      85673820A50FCCA16D49662423378BD180A49855632328A8EA590F6195A294B3
      89F7780BE3E5555D049F2D2F41E145436E0799229494FA53F4F21147C7EA0AC0
      47A5C244BC7385E9D07AA56FAA1EA844E15A43DE9755A9AF92B8A3204EA2523B
      CDBBD04F60E9BC4E1E035C9E7C893B2BFA491F8D004C7CBC701F8FB7F7201F3A
      8738ACC84BB1333A037AFF75105C75B6092BCD26CE7E299EAACC028AD255B895
      92C7FAA8EBF468759DB9281F26658E3AA6E9AC02C3087154448088A1914179A0
      B6B95AF715F67E5D3CE41A94E892B9CEC0E089C350FAC3A12AC06E0B2F945078
      D1E6062CEAFE8AF372F9E0309D64FE0C158BCB525DD69675912BD24C0A777373
      73B33E9BAD8FC7EE4311E75BEEAB3B84C0F296BB41E7C1A0D775B1034DA7EEE5
      138E8B1FB851621BCAF2C33D8266A7D1A5AAF48B28692AF58D07D693657DE18D
      83D3EFDEBAFDBDC30B7BCAA0C08275A78282E98E1F555495799E64B916544673
      6F5E74FF56E7133D924EAC2B36F38E94F5E1E60AAFD69A245BB87245FAE53E34
      5A6EE90AA9C598F558E03CC2C5D08B6D5B120826DB5442F54F27E73E52A63ABE
      9066A730FBD4FD997AD5C20EE574E8E055F886796718EBEE240D3ABCA6B4E4FB
      66B967780E60A2BDBA9B50F3D41066597289DF222144229BCA1E81ADAB254479
      F838BC387E12F69CDB3B35B625848FCA78837746D124FA123F84B357C168BF2E
      872A4A775C3929DCDFD2ACFC5B909996191C0040BA18FD72C8465E77AD6E486A
      7D50039454459F879FEAF15DA42B13EA9040B7D1B1F5FC14EB5B9911E2262179
      15A5768176EBB9EDDD1FCFE514DC7347DB277B3D77F6FE5C3F4CE96BC8A7E18A
      E0A1DB5A981156DB5DABF98516B28EAE3DC288E0C3E15DEE035897EB0F804B43
      0AD43F4810E22B44035F7AD0A174BB66051EDA800B678A556FA9CC9031870268
      C6CDE71BF7B5E76E1EA40DD4AA661538B588A31CD91432A8AA972F0F89AABA68
      1BD57125323BD55B93E304D90583F588481FE378493AD4AFAA61CE8421AF84D1
      C27D4AE34025F6919B264FB7CB6F68E540F1BA833A60EA1BE88332F5B8A6ECC1
      EFCFF75C9729287A5E981C1E9F5717D63A8F731EE782D6EC55ABD21DDD5E2BCA
      2C037A822EA676491085422D2D93BB148FE07E699870DF74935A7A35CA58584D
      F41E981E5E3C05DDAFA70E1F3A727CC0DA40D3EC51C9EF3DFE4C28B005DA8815
      59701C945C2203A2F005FA0E94792F1AB94F5468B27A830A147090D048DCFA48
      4A32F60A1EEEE57BBB17E27B62DBAC5A3C6511DE5D11C1BE6B557BB217AE020C
      88FC1F78D5906616BAB32A50B62A5D2BD3095424CC551579944F89BA1BDF97BC
      14BE0339FD858375B8A0110F8407C35DDBB7993B773582AADE182792CAA3E58C
      6CBDF6271B3B6A3C5D7D5B16244E329FAB36F459A0CD29EA2ED64398474CE4E2
      23322661C12B14502F03AA73D77052821620414AEB267C627C01CB14FE020215
      6BDEA517B5AE0F8E2704BADB76DCAB28C53846ACE0E4D219094906294489CDF9
      0209008D291FDA03EE746CC47041908E079A60319D2605597AB5A3A88E541A81
      4F986F47D07ABB19B2747885F48ACD698293625C44547855FC138B222D0C721C
      9122B62A877F5BD22A00CC19AC2D12296B00267505150458D534D1F823BB0142
      629C715504565D518926B52C9555F42A6627F3B98B39EBC3345AE9BBEE8E203E
      E8065643E9073082EAC1659D9499AF58913A70EF1A0A0BF3FB6BE3C200922C5D
      3D179066F051D155745981345A390AF117D9B3AB95295CD6D8603C1AB6A12403
      B3810B8B167A6FAF06B52CE492E46F45C3BCA3C0142E6DDAC7964567D6D12E2D
      5A65844F6304C8CA21F000F012833CA57DE311D5ADA7B83788B99E777D52ABA6
      5509DFC7005658FFB44B8611ED23AF6D55E02B62DE291C2D2435BDC41CCA00C3
      7814619780B869368BE9FDE73F58D96BE99C9431BA0CEDA995B18D26A347ECE4
      AB8204AAAD9C1997C7F7EAD1E9DEFB4AFAFBDE8C469493B362C25BB733967A2D
      646489C4801B0E1C7AB2F40F8F6E0FBD6027D34C26CB3C833699C85DC2BF88BE
      31997AB1DCBB301F4B2D4ED1643435B2E05F5F9079DB6053141B96A5DB6A9EB1
      EB9708C48327D1496D66F9A4B53AB6B023C6605B551E9156170C6E2C8E00F7A7
      90EE7984EB9A274D364296CFCAAAF59E4246457FAC08198FA01E2379F739A56B
      FAED9771FB55784304935CDEC14A588C23C922B02A2D60EF09608A969D8585A0
      7CBF7269B795C81BE2408E1881C4654A0011739D5CC67D1E15792049B044E94D
      4996334AE6F8CC30CF3ECB9A294A7B5141D552995A78402CADA050604B7C82F1
      FBA74C8C1689A03816BB9A8D8AD8A5BFC1F83AFF9056428CDBD3846936F7D70F
      838BB5874E474B99E5A54A185D313C6E890956CADA0DC34319C786DDFC6870E1
      FE14D44EA4355F0AFC6977E0FE446C9D962FC3BF1DE16F4799E62BF897B53B8E
      F2C575B2ACB95FB5D164E0AAB37CD87D928AAD77A07DE30E56137EA7FDFB6466
      A47A324B2298957D03FB3FD2A66FDBD41148C35ECAC1579A0772B00A256BB2D9
      301B665FCD5033B80867FA349925E5B2839D5EC5BECB579BDEAD4D20BA60517A
      A323C720B940E33E7C92AD1D3CFC2E2E4D60E1334C5468CB6E610E7B777029E8
      7A63D7A817A1B0BED1A0432894AE3BB0C93F4E8A5194A363ED2B55A9EAFE5574
      D9CE8CF29C90E2FCEF7890F01184B590E969D01FF7F4AEE1E3E84B50EB304368
      88D5987769165CA77E9BB576CB4021E3A3BEB38FB201E6DDD4C82CB22B7A900A
      ED88C3131BA42678FC5B283FC4526B0C0374695E66BFACF072BD2F08601BB88C
      3F722ED2796A0C55A2EDF15870D08793E3842E73DD28462A79CB1D5E0FF18F1F
      5C54C847F01366C4168E5B497AF9838B06595ECA1F8B2DB79365B491FD93BB00
      51FF07AE764AAA305D8E68EA86FAB1AADE7D9BE4EF4D23201C501D0B0C0A08C7
      2CA3BF90AC23C9A4273E72B1E251FDC35C0CF88CC5DA0FF8821CDC0D5E6FF746
      2552BFC0E326AF4609416B28E1CB128C326921546487A32CBE11745F8D41DD7F
      DC93ECC497492A00F66EA460443E8CFE7BED077328D32FECA7E3FB3FBE043337
      3F693DCAE1F0667978B5201E2E86944E613552256B020588ABC525D4CD8B390E
      DD9801E6E2B1219392895DD6FC4DE5E7A1946BD8C2C7C9177D89EEC54855E54C
      F6C5AED1D67FB8EF4B43F4FC7D1FD8D8E8F7EF7D94F0DD554D58BBF7AEE5FD09
      BF8D0DC9F247A93DD48DDF17CB2C78D0FB2EA28EE9F77DA41A458F6D789C8E5B
      FDBD1AC1D743A1CDEC230EDE859CF65136FABC3CCE6F7FEA433AE5E7EE107656
      2E8ED7E79608D09C9EC304782502E693344A97F42E43C082C0C944B47C738107
      5D27AC320A6E21B48444380D3A5805C99A3FB04723BDFC0946EB03C8D7F6DC0B
      24177E39FBED454F165EDC73F5675EF5BEAD3EB5D415183A11CB56796C7E3DB6
      EDAEDD59F7090CDFA5A081D4D627FFCB7B9F43971D140345A7072F517F7912A1
      142BBF96120BCBB5B0221434D634828A534A443DE99A1259301D5D4B92A118A0
      7C8E47EFA83B8BCB06582531BD00C07E71191EF8997730360B7080D8469214C7
      423029C55B2CBD59F9358B102C67C428DEAE81A497820697F2718FD54FFA5FDF
      7EB7E9D6110D8D3E33A70ABC853ACFB0AF5594A5FCA6CA4635BDD15BB76E8EC6
      784B3CC4D24C4072A515528AC775F3AB12180965759ADEF83BB7EEF6E8C7B8E2
      B6CF7DB3EFDDBAC9B06B3FB20432CF41436648E1E2749431C10C543D3044F30A
      511315EEC3C5C1FA3B3127581FCDB716E564FD9D0758356CD6BB3730291927D5
      C1445301510EE142E485590AD13859E4BB2D41CED8BCE98D31BCC818569507A8
      AC31726039289ECD8109006A11690D2FD357A5FF90FC2BA82C625B19353F8394
      C7ABA64DFBF6D6ABF256BA6AB594A5808B58EA9C768595E013083271CE936491
      948B15B0FC27B40593C34BC55587DF0463339BF39131E58BDAEC6C7A334C08FF
      AE87F0AC9B809C669716332DD0F834F7DAF43EEFF0EEADF984EDA9F4EAC84B81
      64B36C0C85916A063CC7036212D6FAED45E1AEB23CF907B6E8A9124100701E61
      5F4792969BC7302BCB6C46E7480CB69B86B7FFFEA55BE79AA952B5E8434226C3
      63CE389679C8505A494FC9849E8EB0E3062EA1E9ED31E53AC83F819AABF8F330
      695F689AAFD1F5BB7E97E3D19E7E4C6BD842F4C463672344175203B149324AF2
      D162869AC988697D03736A46D954DF25347AD6B6C9E97083A319FF58D556DAB2
      0AC12CC92129E33A5518D30995E92484EBFA74AAB65F9568E8FCDB6C33EE0A1A
      854AC6EA5685D61F45E9E50209F160595082DD35F2C0D9C4F5656711B73A9E4B
      FBC322DAE80FA3D70E100FA8843C67933E5C1CBCABB631C463531D6E63DDE40A
      C516446E1261AA8D3E0700DC64E23F25AC6D560F9231AFFB9CEDCCE389F3A427
      120F99E59EC5B34C64CAEE8252B4BCAF06A35AE2ADDE1B6D9A30CEE731CB9848
      9E1947197928AE3AC24C1683379C47B4BE2B605729AB2C52FDCBB3363A253E93
      B4FB20955A95C73782D2F8CD5C31B8A164A3CC1E2BF82D69334859CA2F7AD4A8
      BAB64A5AC3E8F5ED4B2CB5E79CF5928F4B17D3A9F986CEE75EA84C82F4675D54
      7CD637D0FCF2B0715B1B581946FD573FB448CB64AA392BCB211271C8307E3985
      D5B689BF1C9C6EFEE60E209490A4EEFDD1E90E2DEFF2EC99EF73DF8A496AF16D
      00970058B0F0B28B6C55151147757CBDDDC18436B63090B9EB0198D39532CBEE
      C31A3E3D0A2A9519A4383AD5BBF667D3BB35739EB5D1225314B49AC01262427D
      894998495578BA562FCA83B20825ED9CC6ADA0BBC0FDDC0DA7D1124BAE6D5B79
      5C47A1D77754923A56A29E755FDAB578FC2ACBCBD102A5401E6209BB9062B2B1
      B3A500A0DC450373DD544EA9CFD9ACF3281D6733B7FDB13EF3AF83BAC5B3F6F6
      C5E96EB5EDD5C76796BA4F49FADDB3DE4EBA3781A2AFB8F4746A163344385458
      E63A27DB1F329314B96185087AF31AF5B879D6E6FE787871BC5FB8AE2E2B6714
      44743F1E9286001C8693943CE4AC71E0A466EEFBF30F67A6AAABE1A266C8B3E1
      349E3D6F0B6F092AF8775859051A9AD2408AAA20FCC9F7F8B3B668475D007F04
      A641450D0AB7AB0C6B78EE6253E1317263944DE173CAD12DABD368519422F832
      6B1A87DED12E43D9D0685692555FF7163342E852EF8A8BE843953703455C4FDA
      58219BDAFE3404D247FC1594292CAD3CD54D024F356E6A0A4C419482BA200415
      8420CEE3B800999FB559F56C87E65409BEC5A9056E8857411E0EEA38C0B8D190
      44C33BC1A764D365B98CB60B77A89873FA933787AC8957546471765E25012ACF
      416D4ACDC8938BC3AA376B9AA24CFF9C0DBE1E9E4E26455C22AFB89B4D8B5D18
      C9A87E9D80D87296CC2AA754E3CD8B6F03F20037ECF5E76CD5221540805073D0
      A02FD1B4926394499AA4FE73F4B2048D86C38ED8EF4972B930AF8657AFAFE452
      3AE39FB3A9414E10F6D245E9BA7FC2BF154C652A11C51A3A4EA07E9E75358E3D
      CB79968D5536F179632B660C7A2CD0F21F88AA7651B64693AD641B6E049C4041
      2AA36B369D1C00A17082148E601F4A08408057B67C0487C89BFE9BFEDB3FFCE1
      0F6BCF1CE912E900814344092B3616C6E3C122205330F81E2EAF075C5C8299D1
      7802B81244CC2B4AB46122D4335824EA4870955390226F21301B8F3E03A5539D
      7857DC96731E7A0A50FE886652F878D6BE190CF6FDFAE8333B6A8A2A1360354F
      F5552DEAE7CB4363EDB39B9BCF3B343F1A74B1820E5BB0F7AC3792D0CC8D6CD4
      6713B7175D2317958FFB7131D3EC70E13625ABE2617408A164E3FF7D81BA12AF
      F0AC4D5BE107664E6035EBD10A1188973282B7867E7C395B81A95CA524570066
      5B470486181246A3D9D04991438B7C8661926D9A194949E9F5C97344A684CBB1
      64F986F115766E7D12AE3F6D36E63BDA5DB1519817B74CF552F725B59D985EA7
      A87E3F6B8850E653F78D440A68230FB12AB1B462C68ADFAA65B068941942D2F5
      2046F8A56AD6F0A366459DFE2BD20C422797CC204284EBAB1854E7503EF61672
      517B3A445F2E853F64DAAAC210EBDD3500E2F32E0918B6EB95BAF0924EED0AC6
      42C06FAABE4634B14A198B9893DF347CEBBDC5863DA6117F8261F7BC45020192
      A19F43685F6FE54037033F037054CF76DBEA58E099FF9AC5A496F80F95323CAB
      CDD7F9888CA09DC9F3B6254C69F4FCAB0CC31AED06658948119E993FA660242E
      287C431B66825FBD429A492DCD00A4C06BE15ED08F8BB91CC32A60A6F0A69ADE
      EAB516D36D3EB29C57E214BE3F00B5784EE48F6A6051D91909DE3C61B2E97993
      D079545CA994F808850C1916A8AEAAF68AC475ACCCC87BE8C9F9840B6CE42095
      4AB64284A380A0FDC4F7D3C0B0A2DC0404AF27662816A1F26EF076E2C93FBC0B
      4DC01A938D55110F9134FA59BBE1965B8E8962FC1391A3804EE064F0404D1249
      5EEA00F2F86ED1387306C61A0C659F965D5D02BA1C61635E1BAEE9384321F74C
      134C1AC264E3788E7750E6515A4C6F5FBD18E2B24BA8A6B74AC290605A4C8934
      C878D37FDD7FFD97460D140CE0D8D758008CCDC688889981F93AD8F732702DAE
      EF1980177BDB1575B8CD05212B286CC08A892C025F6F7AEEE0E4A36C5941F31B
      DD4CD95DAFFBAFFB2F1B5DE0EB5B80319741688FFDB650F5DC22E554A77F05E9
      6E5CAC7169E5A535BA7805386F73154C4DC522ADFEFE77AFF1FDEF5E87DF8793
      4C712506866343CA609162FE8215106F3CD56F74D90304D5FB8333BF7E2B3B37
      1E5DA5A63F27C8491EDFF7074B82028F7D7C29CEBD47710E7BD3E1C9C1A9D07F
      1B5D8D425501D1156B9B66D3CD38D4EDEE120BD3E8FAF86EA5E822AFBD51F722
      A382AB59EFCAD942C625D3407B47BB3D77CABA1576D3E02FFB83E3663D4DF525
      76B7AD5967FBE73F357D6B6F360E4E3EFE267A1EF775C40357DA4F690B1D19DC
      564A9F285E61F3D13A79607BD06C920988B48CF31CDBDD35F4775C115FCAA918
      AB5E361E2B0DB1D90DF614413DBE49A3593272234D844E92783A36FAAB96BA0C
      FC1F8903081449CBD155DF7DC2D6861C46B94E79815986B425CB3FB58B2513F7
      8F38CF541899788EA8807FA3182188F6BAAAC51020EBCFFFE60225B70D54EB4D
      58025133F6789C9B120A25C6398BCFD8713D8917693C6D13FD27E2E944F30DFA
      693A53A54BB0E7C776E5CE601B722C5F5EF6BF6DBCA0AED31C23947AA5B56024
      D975C30249B2F173EC60BE08219731A8F323EF5861C525E6D1995940E0265FEE
      0B96F62A025759AA1BD17424762D9AF639DEFB5662D28B830C10E9693244F5BF
      DF3A5279D52C52F96530D897F9BFCB218804DE7431F456785D2C34BA20ADF530
      2D00F10CD63B4C145BB092D4FDB13F1A8DD8554DD7238AC1FDE63A229E291870
      D1EC2E3A163A0861AAE52AA5D7DA2EA7C03448EDA9C5767570BA19D0D69B050F
      9F6FF264E63E9E8B161E0A8B8B72133FEBEBD8F2562A0575F33E9EE3FDF7E3AF
      24531C9C6E56BFA019801E5424405E2FE3E2DB2F397EBF3EC936BFE4814548C3
      055465B0B7B0FCBC5B1F279750C9B98ABF46B0B682B4961692950840F79AEC4B
      2252BFAEB3836D5871EF5E17CFB8221D59DA54BB572F640CC12A174EAC73A3E6
      336353C313FBB04654B2A9A398CC9269949322DB33ED19E6D98439AC254BE646
      2AA173C6FCE91255E8B1EDEA9CD311C1745BA0B8B97C5B532CE5EF99809947E0
      6A0A5565266CC5606B88D2864DB172BB0593ABDBE279E063B7732362F692D5FA
      12C8DF06AAC67A6E11F9BF9B79B3C9827C85E8E7FD7330D85F3B8EE6C740ECE7
      54D6E6BBABFEF8D7455C941700E6F18FC94424F54076470282C075A9DFAA5483
      9C28A5364F76B4E85AA357B1F2CAA71A355B79A8E31532AA8DAE87F30B924A10
      7B3209A831C7E54C330ECDAE4B4DF640DAB48ABAB6CF0EB94B562498BF1750C5
      4F9349D103E728CE93685AF4DC3443826FBACC157AFAE6D67C6BFBCDD6D481C8
      EC7099A151962CA86D2E3CD86FBBDEEBC621EBBCDB6CD5A87BC695805129F061
      2CBE7FD7A1D672A4BCEABFF9771B2BCFF88A85EE649119CDA634D5C56386E5BB
      65B3F7F4A84758233C7A3B182819EED15BD2BF74896C323E1AAE25FF0DB38B47
      711F95866FF9722AE2FDB318E78A9651EF014FBD1E67280D1748581C71833B3A
      DD6B752B790EFC5F9F25FA9225E342DDE704D892C771C11B517A6601EE3F427D
      8DF2C04D50C96E681F3137AE7353CFB6E6264920B908C50044265CA90A9A812D
      BDF590697AB2F25DBECDACF8D9CEFE769BCAE973070EA45702DE49E5F9D9BCBC
      5199816629597DD7B8A00DA49DC1763B8A8D5D347874452F20A11EA3BC13A138
      21858B69948E8B51348F31B01ADDEFE0E4A30D596A91BF919F5A8FA097CD4690
      4843B4DF5F25D1A5CC9E691C7D6E739940670479591EFAF70EB78F5A5C92BA60
      1679D369A3E91A1A8DBFA05C1518E2B8494C77CF6699E33CBAFC3F204B8A35AA
      160E98BE592EC6776A2B76E07BC79A6EB3CEC968EC61F2ADA20C59C1645B865A
      EDF3A7D5B52843A3C906044C74529130443EB0D529E3A2ECCF23F4932ED77ED7
      41428345439CD736FFC943DBC1E99B7F1E9C7C5C534DADF86BB317A86CA7A2C8
      4609B394969844DBFED84742641E153DF9E7A6FE7392BD9953647E8C1FD22FF8
      01E41CFA4F36EB2AE6CB8EB3B13BCD2F23D805E4AEFB0A120DA57BBD865D4B34
      BA43416049B0AE0ADDDCFA2CD3AF6CFD87FE037DF8E766A34C00FDEBC4A30170
      603E0285BD296A8730A3D07898AC9F6E05ED679A4440E6D9A29C43E483E02C4E
      1D8C015D842D6000647406531869ABA421410E048BCE75D64FB7FAFD5F7F3DCE
      C6BE777FFD75968D8B5F7FB51CE218B97828921E9DEE755AEEE632FDA2A9BB4A
      4C32DFB8FA6321EB6BE2A5E17D700F8185625BA30A461E4F08D1BA38DFDFD7F8
      FEE874CF8746CB860E96FF6F8126B815C4F5A86EBC1CF4AFFF59CB51EB7F56B3
      A3B2F9EEABF7FC1447F32CDDD8CE6759BEB13D9B2DD432A99823AE28AEE2F8AE
      A2E8E3AEBF73BA77B1B173BAF75A68971E91C478C817EC25E1EC9D933103A9D2
      243A9FEAC7412D1B2E796D1AE46D0DF74E77FE73B533F413AF78BE025524D6BF
      157AEF76E2EDE991CDCBFE9BA6E7299252DE7EBF7587B0F152752B90B416501C
      C27C17CDF0297C3C64DAFA1A77D1A265AF36BFDFAA5CC8C731921D702592C592
      ABB5F62EBDB6415E6E75BBB7AFB702CC729E7962B0D850C3A6C2F043DD608534
      1A6856255BB1F035C3C55F65E5E7F8A60813E155365B53E25DB24580AE1219C3
      1ECE69F368ECBE318B4F7ABCACDB4F6996C63DF7479058E3BC6CDAAEE9D80DAE
      9209406BE8792304EB38C476F239991348961175A58D151BE12EA6ECA24059B2
      2817D09A27158A5FCD16255C77308490B2906A6D5C7C86AB5F94C7D13335D87B
      099FFE746FEFB2E88C3C3E90CC7826D335BAED4E5AD9B7B541E2C45FE9D678E7
      F5ADA5AC18879EF1ADEA65F25DD518237700910F74EEF40C904D4C8F08A99574
      31AB7C5A71CA27FC9934A166EF0770E96F7645E5489DDB613A2F4AA7E2203DA7
      DA4CCFED172311F914954331FAE5CB6A0E45D1B49196FFEBD65D5CE8C68B11D4
      8DA7858156509616988089B031006A8EC4D7CA8604E75449F586B6E37896B917
      82A95EFD3184F12F9EF3F411D4178A2DECFF82706141D04E185DBEB44F6BBD40
      41CDEDE4D97581587A7B5A7E73F0A6D968F04F17E8B80DB3EC33F49F74FAE919
      6F4B46CEAB7EFF5B8B6123FFD19E4323EC6F9719854D1B16B67C9203343A0F32
      20C33FB152754421EF9E7B91A52F8219F14C29BBEE302E238B867A14E3B00D86
      3B56C32D466F6467BE08311E4A9690A1A0437B5710A4C5149813C900AEF5DC5C
      F8623A636E40A1B5D2144D77804D79867869C5ECEC7EBA80230C22B31E614D3D
      95258BE637F9A2E0BBE9B9F771B90F7830D11F1E43B9D6AB125727D19763A654
      E1174F39FB32737FCFD2EBF177AD7A52528B6C52D7DA64465AB8054E0C02DA3C
      FA78F4DE752FA7D9309AF24F471F8F4E28A44ED0DE0BDAB6423A5A6AF3BB3F89
      EA3CD45524B1A14957E52CDC5804204777D32DB895707DCAF36CDAF3FC7CFE7E
      0FF2E316A9664EEC790804949DA105BA0C47391CB1423AC0D9D1DEEBE08E49EA
      CEB6777FA2494992222FB8D6E234B77376B11798B358A268988D6F0847AFC42E
      77CE2E4EA8ACDDE26EE7310487F01AA93A89F7C59543A8A04B06B76D803A83CD
      0D450FEAC998B70917ADD383C145E87ADBE526F66240F91B5B555F583C80A56D
      32596B7F266998B08F8BB962BC14C4AAA6D48A5D8F8B599B08FFCDDB2D004D8B
      127A4F40D34FA0F1A3DAACE6D73E36273FD18DBADBD5FEA937FF6E4BB1F992E8
      F7235D8D9268B228722C8717C724EE9A5B7958284A63D25794F5D822E3ABCE54
      A97B47E7484EB2E2F7054EDBC33C1A7D8ECBDB0DD3D3D86522F4456F16615569
      82388A9E4BFA71DFFDF2BFCF92725066F3DF9A47887BC3A967D4D5704C721434
      4F0DC653D46A0FB85AA1A80841AB0279693682B8EC79104D259F8DC4840F0602
      D54755EE6DB625A26823B3006FC3A6008841B0DB9801952A47ACF2CAFCDBB160
      C97901EB816C374AB3A9BEC0E38431A018EC3E6708D983AFA4FA6B2EC593DB45
      81E1348BD2E81256F0FAF3D06247BEEBA6C1A36EC332B77EDEFDBFE7AE0BED37
      495EFC0367397FA2FACB5A7D83C196D6FE9E67C787833655451F918993503684
      CFBC8807C4D3609DD872C7A77B3B3D777C3AD8EBB983F7EFB7F9FF01FE7F3168
      736BE30B1EED5E9CD4360B75CBA966FA87C14F67BA1AB77A5B7ECE68829B872E
      A852830697D0D99C377787E22889F1DDEA86B2E805A576436233C868FFF65EEC
      49F0FF4251EC573113B5C192F062FDF5ABCDEF36DFBD79BBF9AEFF12FFBDA0D8
      25E96C9EB5457B4A99DA7221448069E67EDE3DFA548D85E788FC3B88157EFD55
      70BD22E959785DB4E580FF5963FD105E5F3385E0AB6ECE2AD200D64673B06687
      839A868E5F5B1405F53632A2CEDE9F9F078B4A20B1812C53545E5DE6005E0818
      932CD4F6F75C318A8FDFEF1FB0F7B0A4C9F0F9F9E874F719468CBF6BE783B0B5
      EC2CFCF3607FAFE3AEA3BC7120521574E40E72ACAD3FD8C9D9EEDF7A2B8E856D
      D1FA2FFB6F1A4202144A92C75F366078149A43C918584038AE0FABF79AFD4760
      E1EB41CAE22B3847323D4775B41933635019E5E6F1EF0BFA79689A9C4553B477
      31BF8630468B278E5C11E3607D574934B061B66AD80B1AE04AAE9E2722744CF3
      68703BE838E4EB208521192AC90736BB74E73FC10705A0CE0E41569F812CB354
      18E6D97C315F6150FD783615A2C10DF37340C1059A194590C66D76E123F8DEB1
      702DFCE0EB3C294B80674AF7E678A721F58F1A65404C428D3AFE3A8A0D614F19
      15A5389BB5B0C89B9ED901AACCCCE099DA2165349B93C934E37628860E930565
      254A1C334419851C6DCCFE7EABB2224C34C8FE3690B8F76352BF11861215D4B5
      EF5406098CA2DD9F9878F61EBFB3FEB39DCAEF496E55FE0C38F5316C45A07CA3
      8093FBAD363CD375AB2DC55502907ECBCBD453CADD0AB09FC7970B5038E2AF66
      3558AC35BF5978CEE85E1C41F6301E635DEFB90B315D498A7227FBDAF016D2AB
      3E0521CA05AAA6E12B7472666185E99B030E1CAC48B2C453B28EEEC83AFE90D0
      6FD818013C8D5D719396D15777955C5E4D3195B0E5100425779075F07E8776C4
      55CD060A740C05DF0CD11A119310F33BEAD9341D38A7819A7CF17C973D9430E2
      D5EB6F7BEED5EBB7F8DFF7F8DF3BD7C5FFA008D6416280D96FDCBBF380756752
      8C9AF5DB2E4A5A95C409710BB3795426C384DEED1C51C3ACBC727BF1747E95B8
      9FF7B944FDBCFFC65B050254A2163E62BCD9620B07D9EB0417F40B6291416D4F
      5674819E8A46A07A107A029446350DEFBE7353C6DBB8BA9BC6E96579E5E55479
      E479BBE9864959B48FE85E7FDF2CA2E38546595A31E386376E9625B3287DF5F2
      A5BB2ACB79B1B5B1E17FD31FC75F92284509BC3FCA661B515E6E5CC4C5B79884
      EB8790295FDF7CFBDDF7AFBF7BF7FDDB56E7241A63A74036484A927E6DA0FC8E
      5D57F694C26D9F1F6FF7DCC9C7C12132037BAF7BA82A9C365C6DF4C6FB94FC54
      3F18617E5F226183AD1A0C4004E82AA94F7516E6A0DADCF0E0AE730DCB2AB647
      0922CF2342DB64635F6EBA2DE8F1A0F84C2147D18543FE9905EF622652D59757
      5951AE31F2F1F14CD375496EEDDEBD735B98EF48F17009F70A4E2410AA845999
      94536F910A10AB303C0A9F5974DDB1F81383EC2C159A3C9EE7192BD7C3C5E59A
      FADC8142CE3CA8AC75827884CEDBD7364FF1EAD5F76ECB172D2180F213420872
      B3A788037F3E3A3FAA440705650AFC891C8424B8410BB32296CF12640B85FF71
      8CE56618A7C9A580C003A99EC38BE376AD7EE9B61C4384A07CCF242ECBFA9241
      5DB24183CF2F0CA0B14A7496BFDBC1028D4A8A8CD186FB60105F2BD2D35C8E58
      E6130F317D737266A4C31F0EDEED86E2EBEA25EE46F3A4AC204E7A22873A3EA8
      9CA80A3051155403C6092DFCC658BBDD5EE09DA08831536D770570BB5432BFED
      CAFCAC016D18B921A4577D79FD2D775B4050C7982FF3A880A2400738CD0EA419
      AF21BAD038260D901486D169114D8763AAF8574575462C46EDD8B46BED0C09B7
      BBCAD6168107861F0EDA3877ABFA63E09C106A3EB69AA1AFBFC50CF51A48EABF
      2C92BBA8C621A781FA59BB9BBCE23270CBC0E13CBE64FC29E05DA22DB89616FD
      C067DB03B5B81B4FA31B352864AAA7B20FF6621BEE84804F5EB9C217FEBC7B74
      6EAB5AFDF1B40ED0EE015F6EBC7A857DA66A764D179090389F96925C51F88C90
      195BCC5DA0A0860F0B4E0E7D62066834939CF26CD06E5DFECE6DC1D690454839
      D17C30E435B6009371F12D2C80806A75472C7DB2F0BA8E56C325A4EAB85934B5
      E9DC72857DF50A236DFB6398FFAD557E59C2A3C4BF0FC0FB6E2061151E5C1943
      E0AE6A591A8305E3AA22DAE95BC268BD71F3ABA868F72E5E62DC7C640088F2B8
      8939727863B1A760F9E09809F4BEDB89469F016B48C71578989EE7B247903300
      A973AB616B6399FD6AD74C0C1928EAC918FE1DF20236A17402C75F41CE65C15C
      07D5248F282E24496C11CC538A033C30EFEDF816F9296BF25BB7E568FA5A4F09
      6BAE16A57EA9E68AA7CB35CABA5F8406DA7707491E8B2709CE0088928208011B
      5E3C99E0FCFC657A530D0DC47D123748CDAE5DF3B1349FEA0621FAC9E873EBD3
      027C22AA3CB86D2DE1218F6521699547ECBB3D190408F27BD6D30855033548FF
      080AFD90E803058876CF8000F063968C62072D8A4AF20461F57C1E4779D177C7
      D2A24246C38AF7BEB407FF94D241109FDB6AB56ABF715BAAC27B2B46551D5380
      9664B8F4AC676A464D000B500D86A28448414D02D5161908B60DF409841391A9
      0A06CCA60090BBD6AEA3B9BE2A85439739CD39085641EB9A51512497207628EE
      784CDA8DB546647B6718FF7AC8A8BCABCC4DA1765D4B9BE844E24F51A9616866
      BE65925FFA17257D6CE5C76CE960795CCCBDCBA1D7928FD2D15586730ED620FA
      3A120A96E50DB3CEE47743CA978B2BD02EA368748533B54D3BD7053F10FD308E
      878B4B443E6BCF907279D72CE5424D355A051BDD475E4D8280122C310181C751
      CA4A4F3611C8A981E16536546C03F2D82813174DDD49FC75C1C56850C6D18C6B
      60719529B0ACEFBAC2EC8A8ACF2E1A02F1C766E8B89964F962D60A6870A610D0
      AEA42E6CAF5FF398430A76F060324B8A916D59A6E156E5CCF7F2E8324B87599E
      4274B04D933AA853EA6474877B9D5589168D481ADDE6029737A5232B9EAD3CFF
      A973AFE0919A253235755AC992077C8932B360FE3FDCBB972F9BF1EE762BA6AF
      6799C134088B304D0289F3A87B48B564635800EA89CC5A8954A6DB08E6ECBA24
      2A1CFE68FB644FD0D06CD4C9F6C743DFEF5DA194D4B9246B7D779A0620752DD7
      0AA38EF3B9A75C03D1C66FFB489E51B712298675842C87E7D19C79D97FFDDD5F
      DACC1013DE1C2711A4A48BC5502C248998234CE555BF99F5A719DD6E8C8909A6
      E7EDA29CBC33A998BEBBA8B492C3FC5E4F6A3DB00A40C15DAAF865C6BCC6A0CC
      853B955B8A43E47218399519EA626D54D9144F30BCD1D9B4E1A32410A20AB06E
      C771EA197FED5FDEDBBFB46593A2E7603B4ACF16D72DF36C31F47646355F90B5
      F6796AE5FC9E6FEFEE6B52490A28C3644EFC1ED7590D5B0EB9735545A01CA499
      E5E39F203275272C7A81E8C1ED4B4ACEB83A32C826D8A6620D37218F6015FA7B
      98CE12E1762C0941C1B170DDE539DC1E35FEFADB56E3E07036073E96473BE0DF
      0FCFF60686D19537D49EE6B1B70F38BD1E1EB78F767F146E63670F0AFA8B51C9
      7E4240378D8BCE5AEB511DA0550BA24654284F8BD1A45027A9D680B6CF8F4F05
      038681E9FD6E28394D6BDFDD9FB08C31CA8C5AB1948211C37A946AE7937CE01B
      807EE118E1FBA0A1171B2DAD68FF2AE8DA1C3CE5B1A00ACFB85C770D4D9BA432
      B436D778E220D3D0CECD800DD13BC82C20220A51DFABFAFD500B89F7B0EDC454
      202BD24C1B18DE9D45B2C1D9BED55A1A5DFF8CA9F0F5210BB2D57EAD6E7FD45D
      090D5E3A528BEAAA7798A7A4868B0140F780EF9659B349D0D19A88DCABD925B6
      D3687AF38F181829B90C229C1C4203707251465533957011C232B6D734BB6C74
      99D3E134F9826DFF1C9663B358BAF74CE444403EB964ED796B63E3FAFABA9FE2
      58036A396BCE997E7703BFD9D87CF5EEED9B46BD742C419A120B79B0CE5C3601
      868C684FF49B17A8EE5069023A3B4319023BC88523CADCC8E368748561D0AB26
      623EBAEAB941FC3B0BAD3D0B8518E9F45C5C8EFACDC6C6014CB4C52485965ABA
      B7AA25B34449DB4717EDB7A3CD67892903A166139650D96BB59FA01C6A61FA5F
      40A8656EE7743060E99F0BBF4DB16728B1D34285999200129DA4EEAF1F06176D
      2E4FA29B20D6A7F0C5420151B53A8631CA97FE3015207D5A6D02DC0D95A63B8D
      2FA3D18D3B3FD93ED600097BD10FDAA75ADCD3BF08A2189B65CF6D1FE3FF9FF6
      B7CF7ADCCD7BEEF870D0EAAC6D78ADD577A9CCB7D192FA8E05D7CB09AB71B467
      F119735B5159EAC7209571B3D682787992851A62900E6BE352B92C6C781B724F
      64727439CEE0AA2E8615D4C589C7229AA38EEA66E567ABD1DED16EB316D168C7
      0B2703DAEBB5C2C467370B21CA81371D4D65430BDE86AA65FEF48BBA5F51E637
      D5D4CF521A9CA8A769A3ABFF08718BDD8BF3A3CA515096432D290075862E9F54
      0B65FBC5B0A9AAAB4C0B1DEA7296B63224DA285B69B83327A51044EEAA6A3FB0
      A91E61F5910958F4DC213AB90739D9E9B4D95E7F72B6BB55BF4C8FBE7ED8DFCA
      A2E70E60F67A6796E4818B9F47A378CBFD182550D9DCBF89DB3575F701D99D87
      1A134B16A2D9B7E9FA07E06DB3AFFF646B74966E390A4FF55486AAE7B667B3AC
      8717D17C04627D021EFB37F7895B6F9CE31484F9F261EF5C6D684CD83E32528B
      B714A3422AABD1818C40FF398283DB42A2CD6C8176CEF62E886CB55404DCD32C
      E124F4395D7899EB26D04A7436F86C5E816B1A2153024E6DB73A36CBD5B8ACDC
      C3C37B781EBD285C9998A062FDF2F8BDA83C350A191EB837821BCF2BACA32DAA
      26F0EECD2F5F94ECB6DB8FC63FB4B8FAE1BD02167BC917682C6579BBBC56348A
      0F7E76F3AB2C8D67DE045A2352D99CF5AC19E416FACF92495BE27BF1FA0882D9
      A95D6982306131BC859E215B073EFA837CAE4247E84B16E6FA42A6317DB72068
      0C1B8176C8583AB4A8FCD57A4C56CF58EAE0C00BFDBE207A66B0FF578933BA48
      FDD14B52484B16D828B91BE988D132C5E3E9492F191D75F9EBA6A65F88E2767F
      DCB67402FBDCB2185256BC8AA600718B6B8406B27BD80F8FB334BE41CCD6E6DE
      0AF4194B50AA416A4F5E7D24F85F2D88D7464D48CF6F08BBCB025616AFDDC1CB
      FB8CB97C8D12327E12EC4D925E761AB2D83422651E0CD43CE65A91B00FB8670C
      B95A11DA2459A36EA39829660D2F691020D248718A4A0DF0E4A9455A0AA95374
      BAF6021E9B9C1D08A70D1765298DD4CF4A337B2CAD4BA25B6AB65A7E2794FA2B
      F4E1A44E0F67F49E54726FDD4C375F9A82E48DF16FFAD041FDCCF6ED56A36320
      188B4A7022AB8715E07B6DFE86BEFCDB34BBE4897E31CF88A06C880996F57196
      0074E9A53AF8B24429881C233DC0C8D9C56A0D7975E8F0BDCB4D5F50CD1E352E
      D5715C1BAF8997661185B93C92A4D3B15C0FB7E93988C4E23395D8E90B484567
      5E3A56368D4A09955AC4BC9A3114BB96F11277A48BFDC147F9575C8E9E038CD0
      5009D33C272425D81CB61B502579DCBBD3E3F1816B79795BA4B82118445FDA22
      06D7B6442518E8956CD9B1EC098C32A12C7B37466A7550A8515D816674E36BB1
      04557532399D2A6C90EB9E70E64CD9A5E166B13D9DFEE63EE53731384D5742D3
      C0F952F121DD3FC256B9AFEC0DAFF7784BEEB1E9DD8F8E7E730747830BD65244
      9A514C2C6B51659BABEFEF41F98290BEA2C221F830B855CC1026629539D8B31E
      9A067FAB6AD6F2518125DAE00C3C7E5BB5667DBA65A78E3AB5BC920619912662
      C8855A9B5A70E2826216D6F684AC0BED0689D018DC0469DA0DE47299CAE512AF
      6924D5F10A853ADB844072EA3DCEC63F25A53B3C3EDDB3582C54B737C5A50A4B
      DCE696CBD26BE1500E0A69F0698C2E9B72B4FD095C30A2722C0AC17F95245763
      72D22FB6C1D80123BB463AE48AD2B47C3649C4435D6FFFE8A8F54D0669767DE3
      AE552E33CC78265FC353DA765E5ECDB22C7F864DEED5F7CF6F9F43D23E362C46
      F20CE40195D06378FB2637C477A865D3C94736061959A87C2AB0DC0015C9A432
      AF199BC21E250886B15A9F362CFC0B285F3CEC95F298894F69E9502B55C4752B
      E85C07597FBC15A95D151D0F41BAA29E59350F059DCCC78DCB28990A6550908B
      58C36F5BA0357A550D211863E26D54971E2145A5DCADD6B6924963A3857E0289
      66429D91C8FEFB6236D73263643DFA3C2F8D1D4B966A9C7FB65786B32BEEB69F
      224C3ECB92B4191E4296B20197320220B938CB6FBFD1DF9FE1BEFB725F62CE71
      A404D4207284F85000835B2B90AE9646F255757A8C81086E150C661B1AB516C7
      E7DA4B42BE048AFE37617D044F21B2763196066C7022B2125D460D59BE46265C
      179747BD1EF80E86F21F61ED17F654062824B8B16C09A201CE66D89A0A17710A
      6228B5F080E51020B12A478B4C3B383182966C38F38F89AE921C2D5B20BF3857
      A815669A64FA744B06E4EC93E48CB70CB6177F9DC77902805C34EDD9F22A9E96
      D1B278DA5367EAEBFEB74D5DF6C817545FEA555892519C0BF3FF8EC0A249531B
      8A81820F76907CDD1273224E614C54D150C89342F092B486407EA23359FCE31F
      371DA53D23EB96C705E245332D5FBA8C094992FD2B97C4DA8E2370FC3B18D7A8
      953B88C25E7284C19B4BDEA0AE69A439D991291A8D16396AD0D9C4E65977D30D
      6FCA786DF9C6C274E8BB1D395033F3011020F2EFC04B5BFA955F2331BDB4ED00
      E40D6D9D34593643FEA6FD7B5A12C42A866F5EDEBAC46BB944E71C9AF038452A
      4B9AB172BFDFEFDC47AA40810AD3547C7B25CA96BA02252CBF249712D4C39B8E
      3BC5FA9FDD5D37BAEF3E2BBF231DADA0712CB5F6C74A5DDC0D63ECB6AABBCA8E
      973CAE905580DDBF61949AC3B1A062B7A3AEE2058ECCFC42D8D3768D35E4C8F8
      13871213C846E616D92C04331C1AF73E9A71FA554649B36E5C2169A60C18F92C
      1B2F707CE1ED98C09B46D4BD53D121E33A2CA0EC211AD37499BF56DE4534BD86
      1088AA6180202AD55BA36A74E3FE655FD5180E4EDF9C091EA10FE361A1F3507E
      09162E5FE27C1A898582F5B61E9AAA9293B69679414E5B5ABF170BE692229284
      BC27A15C9E0C3E3A94C8B138BC3C3656DC02D790DD463807718ED77A6FD77EDA
      3E3F393C79BF55850C6868304A424AB4B45AC6141BAC6954A6BE5060139D17D0
      6CD3B16637F338FA2C4348E81F72093EA43A2A2685FD1621AED27215422CB25A
      E98DDAC844CB5D075D462FBF253AE1D3A9A9C7B2047270FA46CCB864D891C0CB
      4E9739E1D913457DACB2F1B856451DC37297E508DFA637F7F6A94827D4883E78
      430CCDD1470972FD7E0FEF4CA31C93733C66C639BA8E60BD0DE064D08BB1B30C
      25A0F00B48B7B9CDF73B2A32B11044A7D81146EEEDE630292B4BA189FBC4BC4F
      EB4DED4DFFA5DBFFF96CFFFCF078FFE462FBA8D90E278F5B498015085ED4D797
      25ABA5935A4FB734C5DBCE301A281223DB46B09029C50D708A719C96B2BA40F8
      487E84F24199E908EBB073693500D2E3659A4C921186176D30BC9665867231F4
      84976D31743909B431C871857BBCA2C89B9DB3335DA6181EA6C13BCC1665583D
      F76BCA2C2B4A039228CA59A381591CA5C17AC88154C41A6316D85DAF3192C273
      A5FFF0381923E1CE3FDC30214EFFBA2E92A462735A65B58B59CFED0EAA2A25B3
      48BA775BA8CD5944E795A88CD7288E97040469B16491218EA65B1F6A2959505B
      3693C5E02FCD046C079EB5C931DA75B9B08717FFFBA2E0BC2E4C994A2AA7856C
      724589AEF91CC773E97B5CB758ABDD1BA58EE0E65709C667787BDEFDA2D67685
      ADCB71629D1F3F7B7FBE27FB721CE553C0378DFFD038FFEE6F6718BA04317794
      26229FD4ECC23B8B4B2473785891184D4FE8A32BD08835B6107A7255F49785B4
      199BEE2A5E2D7EE01F4F87AFACE26738E6E46E7BF7C773F70B65855FBEDAFC0D
      2F434427815342ABAB45761097F6B701B3FE65E64EE79CCFAC00C81774DD2DE2
      B2EFDE27120AEBC6C19355EE5314286A3309BA986B3F541CA63078F5873D357C
      E01EE51590B0715EC357A627817732A982EEC0162660FB99369095E1A584C193
      B59F6A505DC0994D83B1D8EFD1FD7FE5BBE1A4C3B9C23FB2B837E14F4C0470ED
      B207E9C99C9C269FA57A6626A72F0EC3B55A8EA02FBC4885BF2318D1CD9FA6AA
      88E8B046B39177BB2E6A491DA198BB180913DDD0E551CD3B8EC76EAF6A1B95F6
      D1711C28B6AAD6167A8E964E1A0AF2C6F0F990B3545569BE8A70E601600B01C1
      7245E5E9DBF6EBA6C7E6F708EB06564EEDBE3F1E5CAC19A7FE5AEAD67E7053C6
      1CFC14D41332A9DA823D27420CB23234646A695244C7B2CAD504500D26795515
      0451836CFA913BA0BD2FBFDCBE0B978F892B0E28B659EB5988F58459F4776504
      D9D08DC0E4D5F34710050DB9E2E284AC1998A458C1856CF71C8D5DE805606087
      8349926337A5579C3FA1A759998C84402C6EA92D6F14B9D758E9EA3761BE2C9A
      32E401D7330276B6F1CE59119DA332BE84F845E74721790E6F689A4B27E78E61
      B7451855201C1CE3CD3400A889A338F4E14DA5C591E58E2A95D2C308A12EE332
      D85CCD6D3754D7AF5816ED00DBF328E7B996FB6079E5DE43BEBDE16485835636
      418E1F30A2B4E385D1A0728FCD55352F24214CD164B5D56CEC3F34585ECEBB64
      F1100D8E9EC409C20C9D40E6ED2108D4AA49CFF5FB6B9A991E85991A860E9D81
      5FC63B3DFFD34996C6727EE81CD25FB26A4133935F15FC8212B2A43224DF6A85
      1DCB8667934902C6732BEB4509EDB682A9262632D7798683AD6194A0115163EC
      56B054D9B01290C4196459C01D593777456D91AD5F53B75B1E274C6135F2576B
      F40834664421B8BC86A9BC3F09C538D327C54C67ACE44D0220C1688A5FF9E0BF
      F9FCF5B685CA9B088F1A1D4F0F5359B140CBB4439FB9C2FDBEA0D81C14609962
      A998A595E735D7BEB5BEDB568935EC079644A01496F062584FF30A6163B773D3
      A9B1A72CBC0848807507797CDA375650CF3E59D3AACA8E15D4BCBF720AFE4F71
      C45494B3E42A2CF13E4AF2D16286051D2A67AD8B714A39895C9E71FBA3982653
      95745DF59956C63228F900FE2E56A816BB5FCBB18DEB01B3DD164A082E896947
      416C40CAA9EF06994FE561658BA322E1D61D794720ACF0306D6CE8988A4405B2
      F097EEF0C51756C82E3351BDA79ECB0FED8A2BAF9AD62BEA31225EB4547DC641
      36266DE85A7A60D13E2B885847CE70D466F2C5AB25CA4D4D21D80A690DC302BF
      EB17AECB55D8C47222B004E001DF7083B2183A48DEDCDE89645911E15D49616E
      489D9C89CCC8F5CBB8D8C4C0F5104726EAFD2197B2D9B05FF1EE4108842B6528
      615D76753731EC130E6973D4C618B76B35D203929A3DF0992D883993AC429A0E
      0A6FAAD845495E7B02853857D1DE65963EBEB6FF5FD98292641CDDFC693B8FDD
      1E70CBF705EEFF952D309B384F498EBFCAA6B1CD1004897BD96881D47BDFBD47
      7EEB0FEEC76C8E22C4143A5DB7936C7740A71FD480D574B75448644A4A75DCAD
      1FE2B1D0A2C3191FA74A77F57C258DF54045E191818E1335AFA2155A0FB1C07B
      5DA4C85FA1F3E36BD335F172BCE9D8CF3BBF12FFBFFFF93FFE3FC2A0B116}
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
