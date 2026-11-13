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
      AC9C9DD3887792B794E12D179DE6926ECC64C30A7B9CA5E45E79711A84192F06
      4EDA66F68E5023F7148024F1AA34BB6932A8C5F0039E0EFF456A9DA6E42ED9AA
      4229EFA08F21752469C85502077407A7ACA9FC38A7AA43B673C41FA2F45010D1
      3F595DE914750B8081E16F3DC7F38BFD8DF44D30E3638B74736599A8E8240010
      68A9A9F013330A618261DD901DC721E7B8972C009BC6F83360832B57D548F74A
      0D026F4E51F3CE659E5D4E0712B24F95C18567A902C47A3483244671D1168E80
      AB16F6BFA3B4827796B01354571BA13894A33DAEAAB7196D3D4685F18C42CC5C
      8A4803995B72B1E3A8FE8749E26A690BB69B2D24B6499CE650D7791693A78FC1
      E8278CC800580449D91059C4BE8169B60852B20EE244E511F41A5965F221D66E
      147CC8A367990DABF84F142CADC94F038338232FD665A417FC57B7A2B76F3C3E
      355967D8136B8C8CDF9AAAC3F668463E5924D6040144C4F3CCB212A6B3E5220C
      8C878B480791AAA650968A25259BEB60368F5357BBB1DE7BA77A6B7546203D7A
      EC0CB1750A7C253A208700C6631AEA74FEE8DC4C5907A578711EEF9134C39067
      E3B621679D53351EAB7673D454757599CC7404A42819A1C1ADFA14614E1413C4
      9B3D3D8069D0391D6002BF8E3AE735D5EA9C9FD34FADF3414D5DF59A6DFC34A4
      D3DF4FE09B646B0E77AA3AD9AB627E4E4901A5CF01B03A3F5775186B3726C954
      9BE4406ED40811B9625928365449E1023360ABCEAE8DEA5DB647CA5B8A59F6F4
      736C597B27955519E41150C192EC6E8DDA4D95C280BF36EB6718FEA279D55575
      D54FF2088132065B5F5CF5BA45A8F1198FCDA03D5475F52188B2D2D46584CA40
      FB414E92228B6321577886F3D1FA30508D623E7D148CA4993A8F3DD6EBBC2188
      5C91E22478D9734C0341DCCA114CC5445A71A28F02696CCE108273139B6C0B8E
      1781945C1EBF7903AB62D419BE510D351C766AEAF4F235FEF396CB3087A7474E
      D3947A142EE32C102F4114A473AE62DABA441681ACC970952FA33055E2C38F5F
      C88744E8E9E5ABC6E9C5959BB9747185CAD5E096735B40114A483F8B8B123775
      D6697D9498A6A82BC66D02EF8D70554C4E0BFB837C44D89B25C33755F38BAB61
      E7895E169BEA0C351DB62ECF8B7DB3F5B8941B239F98FDEE4F51F07B6E54D323
      FC5DD5DD43951F8162430D338C822B724F2A38E3A7BF1DFDCEE023CAECF3851A
      5001ED224FC9E5B1561FC160A701153C4FD65C5CFB1CBAA4F5A1A686ADC1794D
      357BBD4B110E5073350E493ED3C017DD53526216E5329CC32F4C55FF6400183C
      9D5664ED48EB4B55F093DDADD70D880D675F246675BF887D405E6001041B487B
      A91225B33848E447C4C88954E2E9D7F2F412383B5557C30A606F1B9DC7C83E4E
      273FC314CAD2D3BAD88B9B85F110E1873F33B61AD5F3F8F9C71F255D4C85F091
      5985D017360B45D0F6ED99DA7A74CE083A6DBFABA21816B5FC859165CBF9DFA9
      CFAB2035EAEC1321057C736B83F05C69512B4AA97558E104A0CD280A8D5601B2
      2C4C0891D9420A29874A458C6F2FC776E9FEC3ABF26838CD45B357C9B32681CF
      D5CF8C1994F457713BA39852E0BB44AF7EF9341CE1F8AEF4529D7E3A3FA7E79E
      A00C89CE50CB525721CE4B8502DF2107BEEEE1B00DEF8E2049E390D037EC09BF
      44CC9A6BD511F6BB21B4AEF8C514E2E58F49FC48BC674295A4F984934B642021
      1D666105FC402A8BF8F14E594449C8E05EA731CD232ACC113D5966DE7518CC22
      042828BA84031A15BFD3BE6334CBF7D599C9BAA9C807B2DACA9F2DC4739613B0
      5CA4266B71892731C409076F6640D3C5534B2BFFA6A85368E809E0EC32C55F9F
      41776E666C36B3F3D5DC3C992065A1E55696DE4D1849F4A5D83F4E1C20A14D41
      47DCDE9A5554C8DE112266AB7EF8A928533E7E6E3769F53F0EBBFFE4D036008B
      1065344DDABF55026CBF6FF1038ED133DF57A9A7AD878BDDFED4B550C7539456
      92FD0AE4242A58B9585676E91BB2F33BE4C645F7F4748724C56991A47867412D
      F0E403189A521CD6BBECF7A92A2820E549B700142C6CD2F7E21B4331B8854E53
      BB9BA511FFA0512517EAE96FC3A728605A0E9848267947B32D8EA35E13B2424D
      E6D7AD229FDF33E97C38D74B03BCB1607C285D20C6F8C36FE207298C8ED5B35C
      ED2508FE46898E52B87629BFCDC97094043461DA3073CB0EA14FD514D8A76758
      5516951FF44D7CADBA118E897E87382349475BC96793014B13994C72E5BE5966
      F367D9E7F41A515993CEDF59A9532E0C72F9DBE92FCE333F8DCE66E629371315
      51D76A49CBD778AB9EE340517E0E696E4919596A2BC82EAE8B52C30E5D81767B
      581068091756FA8E13A75AAD74C25C5F9C3EA35004006A44B3417838E6082555
      10114365BC4C4051690B44783316B123890658BBC00E29245D521EBD0896E94B
      446C740D6E4F85EEAB58523F16DC1042B9C4F0420C60F87801A20C968E656CCC
      E243D5D15CE983D5DA66E829988608D751DD036B38F01FF28941461AC071C73C
      69EFBB99CA086E05CF07FF06A9C70D4BD090B306694DE047F627A6AAC25AB2D9
      C3EC1169CD2663997EB1B6C9B696D6EE60A9F0DDF37FBE56D3C4395CDF148387
      EDC73CC23E54810F08F8D1BF6A1BC5B648BAB29324594210DDD9685AE05CA4A9
      7D159A99F6D6748F96C1ADE1E09C165CD2699C272D945DC2A5D1A9EA05E0788A
      A730DF0555B3D05CC851C04EBD7816C1BBD3AAFDEBD1E1E601F10B1607BE07A9
      770ADDB50B16CEEE1999E2694DDD20CDCED6F251BB100918F2A4794CC7DE1978
      13AE20406033505D764C2608E9B4608A9D39582C5FF12924125CAE3FE265296C
      9120F524AAC05F04C3CA0AF1CB1A0522F1590ADA3EA370B5B88B09234EC2B50A
      814165F4409D8DC06930A345259C8D2C1A8B04215DC07D1011658049B9DDBA3C
      90B347A4377E452DF6C1441F3F9552BB6DE70B47D1C7AA032F6AF95BAD1BB208
      D22568AA7D79678E4559F805C71C48FC3081F44A5D9999143F518682D8701DB7
      03ECB80C3D261232D4948722C16C9D15AE4B1005CCDA10C02465384134CBE19A
      14E2D8D238080AF14E9D8E13D7F2EF4FC8B5DCAE705AE33404516E95CDFFFE0A
      FFF212E2DC235D10471566A803932EE9456DF48832440DA96996B84B41AA6989
      BDB72854F4848236739D8758EB591EEAA46E6E0B65C77949322284C613E7B95E
      481D2AAC2974633D0C268966F6A16B7B6CF87655427EE2E79ADB2518D4E3E84F
      65332ED7AFBEB982C2F5C065C9BEDAA33D416D5C12B0D3BC5F13A1864FDB6FC5
      5329F2107E2A8864CED41545D916A2FBBEF8A438D6933037CB04893FD92C4F47
      2F4B2013AF5FF1A1B4FCF32EAC575FDF7F10B496BB9D668177BD6E086A0BC957
      668D0DB37A09FAA931314153D04E751D0A2106FFCC5921D8168E53BD731CF7FA
      26090766666EF7CBC95A37984ACF98E1A1664B6F8A89F0BC88C583BF58306065
      6B02F7FBC61508C917A3D11433BCCE22DF5E91E20652C0A1E4DE6CA66C83B142
      A993DE64E5C35E7E41D28BEAEF99B869F15485C1C4375324A31AE11FAF1BB7B7
      1F2095218BF3891CB0DD63F27C67F9A2368AA2BDF2CAAA3DA8ED51A77F5A53A3
      41B32FD0E65E7F6423BBEF5527A26B0A72ACC4AC74E24BF09AC2F79B81FB7D60
      5FD2A25A1861DC06C5FD2D7DE1CE57FD343126D4C079F1204C4C6D0F69CCA811
      39D362C79928ABB7CF5B45A98FE54ADD2102C76CCE58BAD5C416F550014A4D8D
      8652D2402582F4D2B51237021F7918CC22CE6C896405804D2F21381203CA2421
      EB99B2300144A86E237E04F47566BDA510964CBC4A8B40271A40129E14332008
      CA8598C28A9088EA466C570771B45FDBBC207897839361B371000BB5545855CA
      E3A491AD8CBE06E8F9DE6D780ACE63179AE3937832597B616E36198F5B0681C5
      DA268D721A4C82A46443F67EAC01F6B4D03D932571E0DFCB8F4C941F3A5AEA2C
      73E64ABEB76CFEBB8CE57B10CA90B7ED6EF3BCD13E3F1934DAE7579FD524D191
      37AF73D31282D26BE1F1DD408E4408ACFC829C91200429FEEB2BFA9E9B45DF89
      521CA4D63C08FD3364BEAC07CD741A8CF5B414B8B8833D1D440270A64AD7BBB4
      AE8F1DFAB7D3CBD75FD0E4E46566C391BF7EEEF436594D84C09D432A89112A20
      3000179255122A580F88765F2DF364E94AB88E4D6B1314F82407B0DAF8651212
      037DEA7276280E53B527540F607A7024061AA03A5F69E49F84E20DF500967EC6
      228DAF28BFB247C8580E5382B70953A2EFA5FB52114E894D9B1B978A928541C5
      B3D3E4BA20F92373DB9F7ED0E93F4D128F8425364E369765B49AB0106E9BA9F3
      BA0F3A67176AD06E8E38F324DC7980D2E8F05AF13F19634EA0198A65835E7A5D
      5234BB1DC45167F8FA0B4D010054CA7CBA7AFA78D62B7ED6B949D3C619B14724
      759287AC00503331319CD5869266F257BC18152714050C0AD5EACF4DEBFE559B
      FE1B5ED19F9420FF8ACBB6E97088395A7538DE5150055F11CE4AA1C391364D05
      FF807DE024AFD665920F51FD6CC982B6B1249C3DA97CCF504502C6755319E438
      6F3845448F0E698F1AB8AF7A47C297C7BD341631C5FBEE9D2DAD54E1A253AC29
      83550DBC043021412A2E1CD5F033FE7D994F42C2E815D5CD12804A958F25CF59
      D0D42DC347414A4C244D38C81FA97E9C62B18EC7400E5D95AB9DECECA4242A20
      DFBF2E62E2F8CD3181BF6BEAF5E1CF6F1892C39B78FCE6F5D6F2E1F6A1BCD939
      182AE5D0429DDF200A814DD0CA860EFB3D0F1056A4343B14BAF560510DC5A005
      AEAD280EAA0EF9971CB991074015D4B9AEAAE0F0E7438ABAC1CD0895D5E6524D
      584C708F8BB6A90F06D3F712DFDCCC95FAA82D89425C203C7FE3241351EE5DCF
      FD7DD54DC76595BB6437071DC66896BB38689818F10AD3898C6636DB67393FAA
      14E4540E695B135871F71D45E477A304DF950FFF8E043D530888232FA9F9BBF5
      57683B07791C66D592A38219B159522010D9CCDE0F3F1DFF5C533FFCF4E6C811
      6F685636E6F10EE4A494A4C0C498EE9C83221813171A6D33406ECEB594C697EA
      7EFE1AD5806C7F1457665DFF3DD721731941B0D7ABD48DEF2B83C241FCE6902F
      7E23CCC6171AFBC5E6E00583ABA6D88771A6D5FD00D6412CB8D419D3205281BD
      51DD97C5D62C60091E2719556DCFCD4D52FA0FC2005AA9A1F683843D72E78234
      FB4C028ED3736D72CB1CCC0ED48BCDA3B5F71AF0F0D377EAE81030F177EA68FF
      05ACF538D3A16A14D4A21C12E763AA1A45D1DF6E2C9A45E9A06DB342BF7D6909
      376C78E0A55AC6CB7C59A782494EE4EDDD3DD70FDFE5AF47751F4C49D0FD7AC2
      7B5EC4EE36F2EA52F9F25411C287A282C2BF08115C2F2394147993CD9DC4AE8E
      32BFE26634D192C757A28E1B0A4D2F972172CD3093092C89AE5D59125FBB133B
      764015496532523A0146A0724DC8AC4150C5A2DE4AA89C58938FA7BCBE74EEB9
      025C9694D9D4AD4082E990680FB3F83A42E6490E23643B60F34509B7D5F05831
      325310FC2340C516D91739A8920605CD0A95AD59CB098C17E63B7163DF511F25
      DD7BBA9941DDC962A109A5409B9C333728533A15E24D0A1B98D713829A8C0762
      1DD82359F8F2CD2D3DEE0289B7FDF7256EB6F27CF40420AC72101540F8E77945
      78DEA0C683D76CF94ECA58281FDCC8AC384E1E44CB3CC3ED7AD95BF7621FBECA
      CB8D5E0B5E0C6BB0FC2B7F627BE21CA67B52312789CC3AAA612B5910A104A960
      392CBA87347C112992EE1CCFB3C4E73131AB8066B6D2FF65CBAEDEECBCF22CF3
      900BB3117BC1852CED5732E6C9FD658A733628C865B8E372CC0393002D204C11
      5B7E47E9F4761081F64C330CEDCBB5CEBB258018085C82F1919D6FF8C3C55FA2
      B508026CEBB32CCA0F3FFFF453691C145211F5D5BFE7D8A709BA5D50A5AE584F
      1B1617BD3B536BB0D7C63441CF34D537876C0B0EE70168BB6262A1E3556E77DB
      F0E8C0ACB24CE2C552AA1A2D05970617DC0AC170A2054118C0529995B7E57966
      7D74787C5C38E1BC8254B1CFDD0E8A8370662204B8CCB0F3CB3BBB0D0728967D
      A659BD7EF3930243BB58EC642CD4854CC1276438790B9C7BF3D5BF51F8456714
      7F065F633EA14F3FCBF4064C54AA463DB3883942352A9815E82062E8490EC645
      9F025175C14FB3C44BD51EE739D5096A03701F51CAC534B33601246CA8CC7533
      30B3CE2DFA275D4F401C4FC472E8BDC63340D53C1851B8CA73345C47F4EBC770
      373C3A602CE95653C9B4D6C0692C5D998B7CEB5940017C6B3D50045F52C01548
      44637E0F54FEFFC84A7A5BBA2E95F436BA40E1C13DA9306D009CD5B096406378
      7AB463F5737FD053756EF5E69B29BCB508192EEA15C0FD1439B0F36C1368F6DB
      95F2F83E53FD34110DC4DB335570AC4EE298F4E2DE9D29B80E7F7681E1295120
      EFCF2D35D34C1D3317B45A4D3E4580FDEC1DEF3FF9FB535081C97D300FAAE1B2
      FB306D498311E6D8F0A79D5BC2F29D26F1E204D45D03337DF20921998899742F
      2E7B8DEEC565F39EE9383FB892A5AC03F659A626B50F810AD123854B94E4DE48
      583ED10B0E5B1DDA72E284A8331F597F4E556B899ED10C2C509BE2CEB6DC1A62
      36D1911F2F6C39DB134D6835A9D02E60E5D3CB155C8C3A228D082BD13C007BB7
      F6057EE6CF2C3520C0E2F65CA0066F6FA3FE5872D68EC5CEA0FB4EB8588ECD04
      C6C504D68ECE19F6EA667C768667A5742399C3510174A0666CA7ADBD9534FC62
      E1188F1A5E7EBA60FA8FF6B0658FF3C046BE857E8D63CD58C21AD02E1C0FB4AC
      8972103677DC51AD212D371EAB0E6E3A240F256D3FC4798284C3D0646A1AC620
      860E66DCC24C1D3FD949EBB6CF3B8566198F15819EE926928D2B42378BD53908
      34EF2D657F8215A01A7AACC0744AAD0A4A55F70B4116861955B9C15F3EAE4302
      33F20A37AE2AEBF6DD6B56C763D524EB25AD943DA389FD08A962EB0FBD278835
      8BA03214629D24768874A8F2681A84B0BAD820E2636CD0C1B74E611F0BA9209C
      39159B1739AD219AFCAA9E8E34BDDD13EDF287761FBA4C8C96277B6CBFD9A26D
      EB0FDBA30A51450AA64620FC9060E640227046021853FFF17775747C5C32D870
      F7D1C2B2FAAA99F17D557F0FB381398A0D22DBA9AB57096AF3D0AC8E84EC7070
      76C23F3B3DF4F3E803D93BAD30CE4BCC96F03710D1803D2524EF53F5C3F1CFF5
      1F5E1DA9BDDEE1E8D7C605FE737938FA75FFB9FC0C01B09D0F5B83C639641411
      568B44E6D564695D4781000E155DC9BBA63F5056AE0AB1536955C54BE34F8794
      1C3E058DEC459C59F1ED38C0B98EFC735E6014B0530D7F13D9050A27C2A58987
      19E54F88065B4E2D85844AA64CEB3739D3F3E3C546AB493BB8396D1B74F3D0A9
      9BCB20B60C2A4CED569535C685F27C325140E39C9FB5BB30882AC40AE5487442
      9E2B044B1E820C74A39380FB5791836EDF798FA3699CCD224FCEC817960071FA
      79E2D8B355983113E3E791AFC11535E9C7E920CE1AAB09B418FF50E80264FDF4
      4D0C624DB59A5C19EF157FC07DD9D14CBC52FF0F55B29A14E02AA1808CF1BBA2
      595516AB496234821A28CBADFB66091EC3C85B73BBD1470B535C78B74D1B8EFE
      8BA4DE70D416DDC15D157508676657B3F94A0E0122E8A3B84B420363985B10FB
      61A11A25F15C556AFD39CC4E62615084F9F255059355A08289DA74FBBA788EF6
      55E7D73E98E638085ED81C00D9509508F7A4703BFCADD6A862AED9AB58F1CB29
      32B52148E768C99993FFAC26C48BF15DEBEE4C32757279F9B1E25F10173C99BB
      34BB213A1BE2238DF3EED9875282EDB23ADB766D1D46E62C2225360D6EDDC203
      CD8D15DF8805E1D0B8E51FF0CAF7B8014483887372F446ED9D0791D1C93E5974
      770AFA770AF57CA6A6E22D69717765C2D80B888A69FBCC3265245C93F76C3CAE
      08FD689BE37D254EB5A1E3DC129364F630DD470190AA17B838220694E60E432F
      41B13262A959AC2E2E2F3A362DD0FA28199D949F07605C62C275A984F79FD266
      FADC69F61131A0720ECE002C268672E19FB9A92753492258CD01546255633470
      4D2D137313C4791AAE6D81AC5C5962B139BAC3625305CC7F178597DB5DBE680F
      E9C072744C08E3AD41468431A20A291E8E9D602E9F3DAE9BAF243D2C33D2BE7B
      D0623C56239EC8705E65BD9685B327E67B56C5FDAC7685D9B44DBC119753752A
      F85BBE4A1B645E1C47C385BE68F6DED021B868F6DCC65D4D2E4F46C381F95D82
      165D2E336E586E557691B0E2255D29E5F42F7B97EDEF277D83ADEA76972F5B3D
      590DA4C46A98ACF51D1A0289C7A1917BC07E2A2545283195000785243EF2ED0C
      4FCD13375448F7E282C4DF855E10D93B252B1000C23F4C46E611AD9904A88A75
      E3D82F9A9EC0CC0BBC8026FC1D4BE878B4B06658055B6156F42C5A2FDD56E0FC
      9BC56C5FA18D7BCF70902CCEA9DF6999A6275CF91DD774FFDDFDD37B7B8CE9BD
      3DAE4ECF44BE4EE7051E45F2B5EFA898AEACA5DB6BE9C5528D822C34FBEFA581
      9C749BE99FFFD740ED4974B640B5ED2B440E016E436099AAA5E3948CBE46128B
      95CE2577EF1951790F975ED9A3CFE975065CEBA7F67EEDB7468DD665FB6CBF56
      D602AABDCEC579AFD1B9381FE13FC3FD1AF7C7FD74A5F69A9F3E5DEDD7547FBE
      4E032F55C375E4A9BDFE87E1689F2F48BB773622BABB3CDD7592CD92606F12A2
      8F0B12FB694DFD7364D2EC348F3C91EE021FB048214986DDB3F5EF55B3753244
      A4F0B5FA1B5FDB8B7EEB5FDCE8F7FCEABCCB96B0141F3A9F136FAEC3D05017BF
      F512D3137EAC46E0C1FFE2DFD15A7586B456B332AEE8A602FB5727D6C32F5A0F
      138005FF3C89FD3551E28A8C72CF3B5E75875DEE153D692E268189B2561CA2C8
      8434E9FBA23494E2A841348DBF7A6977624E22BD55B04EDAEAD3F77237C0CB66
      56DC842E8FAEA378F51D6588AE9AA452A66A6193D572D5F7D552D5349FD42DF4
      439311B6873E0C28E60E433BE5FDF79BEA59EA50DEFCE436BF3B95B57776A652
      24B95963791FF0EA9DA4E00A6F15D4054B935C0BF8959AF270AC9B7E2E7C591C
      FE9A3A391B3651141BDC985112CC6626418555E3E46CF80BD0D6D9FAD3729668
      9F53F4CC125923820FDC1462CD241E1C2A100B2B4D940AE24DF2264E6187E142
      3B0310ED2E9D7DEEB4D5DE59A26FE0E67C86683689B872541CC61264D4C6C746
      8000A9B65E60B2D5CF14C4A8523A47A4F800231812097706A0CADCE251FB840A
      34A88ED7284B8FBD030206BAA739591AD8BB4B11BB3A87DF81428FAE1B047DCF
      D62A0B2C15631928B1947F281BAF27711836C0F8411F92AFD5F36213D32C7DA6
      90B475ABFB834F48DE71300F86E52FB98EB27CA13A694ADDACEC896AC5E9E32A
      CA8AFBE0982967594477A25808AB17E0CD728515154CA79BF51F35AA1123F45C
      A50A6D82EC978FEA21EB43566B9EF6F09B7F0C2F2F089D6CBB5320454714C6CF
      B4FAA3CEA0A79A490650F302755962131777B35E697016443E7111ED8D4C92E8
      48359385F6B5156C4747FB7F12CC9D0A262D1F3865FA00E40BEB5409CAF104D2
      5F653B61FE505DD8D47BE40154B2F2DC036407DD5AB5A5A1200E4CBA908221D1
      E6F8AD7344879DBD33835E3F84174E6204A181F8B2146470FB2A0590D4158C26
      F02711EF628A5B640BC25072631274B817DE8586FCE31C21D11277BC30D93C86
      35DBF4FDBE46FDBE60B1D31A05631046C6431BE8EC3E8AF14FF1E6E2C4DC3D77
      15165EFE9894426FCD901F84B032ED5362B23C91420526699577107B80D99E11
      6279A6E4873D465FE1A328B2213C59AE6055F2B1BD7D66B725B4653D35808E50
      E362FB7529F0DA681C4E3469CFF22A9D5B94D5ABEE6AD2E1D4C5816C6810CD86
      F9442ABC48E7AE26845D3CA0FF22457FB2EED883D138756FF0694195ABC90531
      90057F18DB9E0A5B2E304B3BFA99C9E81FF8939B4606369759F3BAD24FFD0F0A
      9860771AA710A660592C923BEFB9C4AC4858A96023CB639B4DA345A9B0D20030
      73F7E4EDCA385DE48439DDCF6D9685F08492C381CD34D5D3A5F18269E0090536
      3715DF3BDA4757C7797D4278D1FBF9509E7CD6B82A3690EC1B2FC4692F568D48
      6E2DD09829D345E5F2FBE14BCD7EB7D22A738F8A9C9BFDEEC1523F97A5F39B40
      740510F2A55C796A6E5CC462E44472BE9817196894857822E9FBA2CBA59AC4F1
      753D203BB584B508FD1CFA699C6ACF9C99481D44C1B4027281BA4E0C76131024
      F1BA1BADB94EF0E1B2E90657337AA6780E908CF4F7F73064888B8324E3A0D9EA
      A80333B3AD0C40A046B378AFFA7AB98645C617AF528DE0CC95F2DBA7C837A111
      AE725BAE5B28FBF40BBBD1B97CCAAFB60CC962F54FF577557F7578787858F00A
      320B1F3304D83694B22354F799A8BDFF71F47ABF242B8D9714EF31F5785A97CF
      DF71539E87ACDA261BE302827374F0F3C1B1E3CD170FB7DAFB17F520E4D27E93
      758884F77DCC43EF8B6A76A1481E1A3849B0BB4C12E890905704CD2B87AD538E
      94EBE3DE17C532D67A00178FAF43D8CE556224C91450B3203AD8C330B60C6043
      F92A153CA535D54F8238812F144F99AA282654D749187BE060158CDCD7FF22F6
      8BBBB4AA1663963C4C968053F83B2D916595507463235C6FCC060D38738E10EB
      B790994BAF34BAFAEFA9ED3795080EC11994A8B6218218896B526BE21CFCFD0D
      CBA25392A233ACC9EE2041E978F344DB0B218EDA3B3C387875B45F96234A86C7
      826ED031AF7C0C194526FB17ACFE50C8298094CDA3C8181F1DA120F29B9E87C6
      3DB08D49C183423328763419A22B36A4C0AE6B38628EAC2FB4AD2F06F08D5ED0
      CBBDE8E55CE626BF631021E02AF8B95629C35943AB686986404DB3D9C5E2E242
      F0FA38EA986D32FB2FB0C434B5B51492F97AB95B0D62B4E76DB11B48E0E75A51
      2E54C75958AA19FB1EEB9AFAD761E35F47A44F1671B29C53055E08554C51111C
      646661AF7B082C2A1D2EE7BAF1A13DA8151DDF861F9AEDCEE05F179748548FBA
      1767E59F4435361EB9937C69A81B67A2677E1C86B8C02815BD554D4234EFFD3B
      C0418503EDB69EC0B12C60B735A380A55BFAA5A86EA265907E31C81252D1D0C1
      B51BABD16FF7B1CA7F511FA03021980A8E6890BC33E777C9FB42C367C0349313
      C08CE08570DE693E83726561890651F645D03D18CB13900842215EF10952B493
      F9750FE11268D5F2CB8EA6D316F5FF1736B7E9BAE0944C20AC0B7131D1954017
      FAB35E0711656B4A467C571950D0EC7F515DE677DFF9A157DCB58002F1AA8F35
      0AA2190B178DF4D7D2D4490349F138192DD7C1522E18CB181680E8A95D48D820
      B268365C514769122FD736EEB0168D68779F4880907A2F5A3F58EEF28292D338
      EEF6C040CAA2657119954FED8A9C502209F0B728853E17DC86E3B9F27D75119C
      5FB62F62DF7C51AD3990F10549FD45308081717ED92E7A615C048C0991DFB98D
      6AAF7861317D111E0AA91D872504D95966CF3899E816608575E44192AF5354B5
      171743D431E36BBC759DD4AAC492611BF4866D962334389FC107136B8FC1377E
      268688B46EADD7D229C962D51B7E307AF967B49DC0BEDF471FFBCED22F33657E
      CA34CCBC4FA5516633931E824FEFE52BFD24E63C367F515617C23155D4DA50BE
      9CC53C323F748778E0BD44B765A2666F8ABFFB393005057F91A3F95AE96CC239
      79A27D290975A5B71EFE4474685C4844269AB0BA4BB42328A62BECF4C07BBB85
      5B44075BD678B21ECB2267E942EEC58B0925EAC9757BF9B7976AAF422E6D93FC
      77CD71B08FC21DA47B22D5A60B78400D8B3022EEED293ADDEC34FD7419065931
      847D19028BFD61D45E9DFEFEEE429D9DEC03C615FB39D1194439981AABBD2C8A
      CA31623743501EF05818C73B1D31563995EA7D291FBF01D68DBA4A50183AC594
      49428028CF46EFDC56C664556B87CB9289C2C58378644D2775E5051D0D85FE97
      C24F263DD249D0D976F724BB2F0752EFB3E1654053C2924B9DD960681D5ED6FF
      78C9AE09119C50D3712205D99EE65EFD8F777F84C1E47F867FBCC6FF4FF7DFAB
      781194E843FA94B0970A338A80E19CD325143BE7582A05EB84B887AB719689A9
      73B8C6318C4061735D3449C5C502EDBE4F863BAD38EF9A56531DA686BA8048D3
      1CB557484FF7645098235785381E9E2C9B6BA576A16176EF50B07CC20E05A339
      1815112A3316E6412C856926232626345464804086B42E787B78F8B7A2770149
      BC23FA45C9BCFCA792FC2398500669BC2460D13EC981DEF9E1E8F8ED8FA09153
      C49B8076132632695A533F1CBD7AFB3321052B1158F015E34FAF5FBD55BE31B0
      639768E182B804851D74103A9775F440E87CB3519A665114022B86FF52E46F6D
      951AF8591BD58282272B0B97782A99CC05473BB871AB355775757A76366C9C9E
      9D351BA767A3210916EE6D1BAE45BC393603B97CFBE33BE1D2827CA268EA6977
      F8C18200CB85AA159820CC0FE19E34639924269C9B90B7A9CA77284386CA8AD0
      CF22B903C2A9596DC2BD0B2D8F2AA7E52C36AD56618A04C79F5470EF84C8C24E
      BFBBA7D75D214E6A8C575716AF8E86231E3E5930DF5BBC4BB05826F10DA5761C
      8D05848BDF096DAF3DB874FDFF1984FA46ED1DFD589F04B6B4D8BE36F5625727
      430B40FA0F75F4EAB05CD74D9679C7627BE924296FE8173424B6E8B56C7AF2D9
      709F29C836A2A3BB75B546FB2621D11E79E69D1A2E8DF173EAE286845F9C14F0
      5FA11F7A72FEFA0DB2F94DA015EDC61D4EFB9AFA98277190A57964AAA4F68273
      6DE9D4D37EA03758EEE97C23DBA6C30A577D33C9E68B18CDD2874C72FF993A81
      A0745B40FF1447FD2B08EC59DAD771B1A93D9A487DA6742C6C66A1BD751C015A
      03D5EC5665A0555BBC44D04B1A7E53CB2FD12B24C62C431991E19385EC135F7B
      9D58801C8527EB284095AC96AA141E487F358A8C2D2D57969D0E712843A1318D
      B78E98AD9659D85C17E5472C0AECBB9335901297107DF8B1DBDE304411C72567
      464C79B714E737B0B3237DCD143D30BCCC2D128C4C8E2D5CF524B3CE4CB63551
      A7B1FAC88EBE3CEDA8C3C3A39774E82D4510DC53BCEB6FFCC72F14787F79F813
      7FEAE56F873F7D79E934E427201AA26C147F30B73873B304753264F4846B6EAD
      4B49FC82D180D1CD4E3B5BDD9FFDA2E0313309C241CC400646A82C13DB882CFA
      29710807564BF1DA2F629FE82E9E6C1AE7E82CD88379EF27F1D2073C97E2CFE2
      1A563D6B29DEB1E8789C7ACC3D4082CD190E75DF9CB2F51248051082661A7E1D
      E8F7B807EF938C41814210B050117F1657EAC4A5927F2F33DE3C92B3400D7619
      0688DA2BE2BDC9E6719EE25BD4B59DB233987185DCD21558405623FE33F8626D
      722655C6C5A6207E90A6E80A41508E48879CAEA03EE72563BB381C3BCC61F045
      FD9207DE354A0D98E09037870F073BB89FDA83971B29F93B69F74B49AE439764
      CE816BD40C7CD9A602D8285D85474A5B5AC6F5BC0478CDAAAAA55B3D3721B1CD
      4ABBC2205371EE9AA0DBACE5FE02B80784E081303E116752082426D128314E8A
      441A4AD13493A296D568245AE53B4F369FB26DCB01904CB62EA15CBCCEADF172
      1BB4A55F977C3BC37C52177417419B08A2F3149D291EFD46C3D3A32F0254D848
      BA9F84B9E93FA98FB071F1B8390DF159526B908941CB58D519F671D1CA21770A
      1716014EAA25EBEBCC2DFCCD11863AD504950A0CE8D82A0F2F71DA0A8B28B34B
      5A4A7CF80E77D1A5DF3DBAEFABB675A71A1FAA3CA51C8EBA1A7486E7966AB4BA
      95F4EBC8DF2898DE692A7D16D29B1D31366887A34DCA56B75D1467E5DB8ECAA3
      41EAB1971797F71D94B234661A56568BEE2C995B548DA8DA261130C7FFF96C89
      92C2041B0473F4D8FAFE4DF28DA1C976BB11445F47E45D7C2E018F8B23749924
      9266E20CAF512BE19D4804B68729646AC3BE17B1D300BF776EA806BD314AC4BA
      5BCDC153C77D73614717246D4C009B36EC9CDD567A4B550AE0A8821F46975752
      E5EC5290EE742BCC695E751B17CD2BA642F411AF4743DFFBB9A26A457C6C4205
      425C1F8416EAC8777311805B4C70381A353688174AD040838B3F38E6B50B3748
      B3DDBE68B42ECF2D6307D02C7E172D24CAE6484F497C5807D55C6AAE8D81C182
      F69C889B3D335790ED3559A61AAB03DEA9E2144192128AD8AD94B12CDD6003B3
      64E220BEC78FA8A021668BEEF0A8D1EA0E8FFF0C42B1D5E414F13729A8B4EA8D
      F236DC948D906184582CE130BB1920ABC9C93A331B235AC64D4AD565455BB81D
      3C5126369295AE8843C7875DE81B54A7B41031B1D42465E5CA1C4647B4017D70
      ADFF23A3753539CD93288000A3F66FA82FE05177239DB40FD79E9921F1FA140F
      6B5F9EFC838198E986A3B2D3996C858B8CA034BC7F28AC8FA7A80E9C19498602
      35E4F870040142E0584AF29A0BB32A7F5B86A2112928E09A8C17A04ECC4201BA
      DB591A258106DCCF1E27AA0BA793C496EA5D68F6838C44AF9C66F37974DAE942
      02576C258ED5FF09045C9DF3F3F1F8D716E919ABCC36B3010DDEF22A46AFE2EE
      523CD99D38B221AC9172067A7194CD090E40D78C19375A1FDDD4DAE5A78B6D63
      C92DA133E874E441B67044FC542245AA54893DCDC43F37470319AF22A4451EB3
      19D3BB3B0FB762ABD3E1076BCA3C48BEF6ADC337706716E0375D4D861401B571
      8B9293E6D7F3C1F9F3D38211F755710EEF66EFAA4E6417E0ACD4A821377E3847
      1EBCE8064EF5FCED38CAD02B62F7C3401C971B24B377E7C6994D389A9DF37322
      2E73BB3023E23A973E1CEA834E51239381CCF0FCB25D01CF8B5F8D5F1288DBD1
      A71D3547E3B15037C17FD96C441B47251ADB51AC7E189475E197E88CB6C1AD8A
      1E6CF0CB1D1D32B9A5ECDBE7CB1A0541046D634BF024B2857892E3F613B96E5D
      7A5E84D683846B436F056E5D36580BBA5D20037619CA82C9E3BCD201C6D63BD9
      F7DB6580BE24B74700AD648DA21E5BFA215502BC7EFC245E23C61D8FFB1FDBA3
      F198C82F937C9915E476774F1EB11D2023F7E93E0A91EF1CB528D244FFE606A1
      81BB688E54D8F922299082D1E5DA58421B6E5AB5C3047E2DEFD710C0C02C5647
      A456DC822A676D086C2953DD2A3CE5E0C22E4E2FD4514956477A899E893CB5A3
      0DD0EFDDE3A5EFFAD48B36AEBEA5A4B968F69811D9062259169CE15772A88B52
      6CD66B6EB6FEE5D5683C1EF63BED469737D54E80CC353BB81BACE7D3E0623CEE
      F163C9AAA1D8C9EE4BD5BA3CF9C778DCE207138F242F48998BDF5A1A5783FED7
      610B27B328D8A64A77325C0F0F0ED10627CE677375747870E876993A838FE3F1
      6AD237C975C9E349F55CF7C5109CC600F5C4785C12D0936A01901529C10DEA20
      DA932D220B482DE961BB6BAC9128748AE355B131DDFBD634369F792FD5E7DA5D
      7781CAAB7C7A213D99CAB264AE2194FDEEA12B8C361E8BACB682FCBE7E00DCB7
      205E61178B8F3FD52C36DA8314EFDE2F1A7F2060C1C7A24DA4DB34EC538DD612
      B6170B35AA164D9D99AC95040B73860E64652392677AEF339375A3A95EACEFE1
      4F4EB91F34D5EF23257367B6E812559DED33CD91F8DC0720C72B845DD59F2885
      61B15A3BEFD7E97034ACFA331436491BCD24411EB810EA4FF6C66898341E0FCE
      DAC352811F23D1C63614A70445F8134598F0C2EB489D8F3ABF3EDAC13BBD7CB5
      8BB97EC7DAE31BD2A42E43A5C55E0ADBDDC2ACF041C6E33B3D1DE06A6FB0D4DE
      3FCA73F18E238D341E772F5AADF2264B4EFE02A872E95AED78F2BB7E689A915E
      A8BA7A41FD620863F682FD472EE3A11E3A9335A110DD5330A0366E4808414E9C
      D44EA1398D252ADEA1000E03141EEA3133E8A695E6373A55DC006CA7D05B074E
      77EB891E8A48B00DE854CCADF42123EB3998997B166ED06C7D185400D7E2B8FA
      6A6FAE974B1349F951BAD24B02CA800A667F97E8055E9ABA5EECC15F45593A28
      ED044589B610511086B6F9E84E54940BBD64308D6520B8C8AF351A23863E9176
      6DE324B750BBDFCF75EC76CAAEFA36B807EB14F1DCC25EDD21077BD50363604B
      6766865645DC5094720EEE76224811C7E3E145BB6DC3B6770CEB3F8F1FBA39E8
      5D9284198FDBCD1E35BB935C0B5132C2B8225D5AA659E0F59116E1D4EFEBE727
      62BE97135540FB3B18B6BF881B18486979EACEEC4C22A8521D42C54845DD48A5
      A8E659C862E73AF1391BDFBCEA9E56CB506C11F1D30E5B08BDA2D202189AEE55
      A7D11F0D55593EBA419F5A6D4EF3A4B3A95ED48BAF8CC861CA82BDDB399B7675
      614F4C4EBD19A806F56EA8E339E8776D6C67A2D3C0BB878CB75125E375F3FD2B
      754695E75BA0549D2A530868462CBEC428E1A8BE3BDF2E59B21817424EECBC77
      E7AD1192643D0DAE520977C2049910C53C07B240550E1953F49F770C885E14FD
      E1100F6A742EAF06953CAF307014705076512E9A3D8BE351F8C2784C0A96C04C
      E3F16FC75F788A8CC68D150263E371335BC4E992CA7FAF983826983D4148663C
      6E9EB72CFEAA9FC4447C0440376817E2292CF9C05A5CAE9835710425E6424319
      5FFDDA3C3FABE063FF2466CE3BB4737541D9DADA2CA75288CD84160A58B74BAA
      4FE2F85AB58D30EEC55F8BBF3F621CA4E4ED3D757F88D007A9A1A743C329825D
      9E492D8BFD58CD90D3093CAA87082DC7123406D79012410FC21700072F0076A3
      D25E692FE63432AE5EC2E0404ADE51ED3A51EE8D9A23C7551EF49A8AA9A330F5
      CF06B950350C0360469DD3D2BF6DD6FC7D717E5B4B8D1399502A4DA4C287BC0E
      A22E4E9922E06B027BB70342B27B98AD432364A6E92E2C46AD3CCDE285DC6A22
      DA03C9C2972D6C82E50E2301CA5F14360688264E52EFAC137F230E1140D4FB54
      83964A67648FAA0D2646A1B29F8AD5B218A06B3B49E0DB2BED66CC4AB50CB849
      A5A8DF692E36395ADFDA8DEAB217AB421B52EE93358576A1AA25366E83AEF324
      6FA83948F557AF4B83EB2FE2797CDB383AF8898D6F625D291AD6A8C43239EE00
      87FD5A717161F0BAB55D39312060DB882C6F542B3393899BD8EA0520652B0AF7
      ADCB86C22F3492A195DAAA7F761A0707BCC23B49EC954E0FB2566E511F573ED5
      E9798C8EF7553C4963F2C5BEF5BC6F1D02D86ECCC2C41552499AA1EA91B1BAD0
      EA4B31987000DD87403E5D4884013ECB27F51D789EEF721E3AAD65C193C8781C
      4EBC34185FF0504EF31B8FE5C99D0C39DDD838195A9C91256A0B11798A239B1F
      E4C1BFEEAA3F72B882938ECB2418A5BA27656413B0D6B5D7915E049EFDE0FE0E
      C315245A610C2620435E94C9A8FC11EAFAEB71D06F3C9E48FE900B0B437D2B6B
      C3D615154308D524D82BB78BF6BFEF050AFA4ACA7409992C81549F8870F5494E
      2477BB2B031097ABE85F9D4590A1EFD34D4F2FFF4547EB5FA7FA6B747F8F9226
      42987432FCF58118E0A3E49CEAC5EC6233F11C11C76E11C53A5B6B14A4A16295
      F27CEC704B4F835B107C520A024E4D41235E39190C0B8D232564B97D1D42B751
      839CC0B1D9D46970CB9B5B34D6AB7FF5F52A7289C4D28EEFBBA1929983F25F4D
      B0B556208245391C604FFFC20A3D29C5657DEB8233A3B48CB471DDF9683EDAEE
      B2FC3A43A11EDEC946AE72F27C911495BF4DCD43A64795D5673B0A587280B849
      DA8B3833EF886D2C25B7ACA0B48FA7D3807942E2384C998160AD347A094ED7DC
      498C540F37B6D35E96EB90A798663153C81966AEC5DFB1CC14AB174E2A22F9A5
      96344EB3C67C3B67BD46875ACAA1CC8B2681E647015942681EF53D05C2958E72
      CCFEEDC85C0512D902B33C5A05BE1F9A0FECF6A2DA1BAC1C05E68FC0BFD7467D
      EAC2698B51B2806E4ACBA5D1906894780DDDF2AC52E94C755B2188158369B681
      CEA54E1F1445E2EE23C8B5C34B9418B5DBA0C82271A38715D1712A74036EB4E2
      50F8FCC9B526736487B2215B52CBAE8A2631124CD50BCBA8ECBFA08C32E3D476
      0048165AF285F8C7B88A9FA2C8A0F61CC1DE3EEC7F2E2C1C9869FA62475E28B3
      58C6894E02847FA4F70004264E31B18831C10112A68D666BD0A138ECB298C22E
      CEE0B0F30B2F99105B4002A0561F87F9698AFF85509FAA54DBE727830615150A
      C300D795B9231F8559157DB3C378A50EA6F91F658F24EA7555903EEEA5F36059
      FD05F9A327269B9BD4D78E8994EEA95C78CE317C4A4D22AEE1B1FABB3A7A755C
      847BF660B4A27DD75A21CF64B67A203F3A2A7FD96E5004A044F07CA5178DD3E3
      AF74829ECE6216E2D4DB36CF4C55EAEE9E352D49101E9ACD111DA13826120B6A
      857F6573B326C5E1C7DF23BD1FCBB145E488C24722062F91B9CAB78BC0D83B37
      89513278397DBF4AFAE5F400616D5B50C8854F88045EDC0EDA76F7BBBD7F4FE2
      1D1AD594A68AD3D76DBED34D376DC22BDC048DE551734B765BE697BD9244CD11
      CB82A2BADD1F037815A87B0AB670B7C7304EB0008483BED8910D9A708D5F9D8F
      13B36AFC9FDF4D53A71A88FFA1926A073BF087A3D7C76F9011B339FF3BC59BE9
      41C172B8D0E8E16C6C9DE016D7EA634DE20DD298D6A003508A78DE458123B825
      53648CD85C0F795C6A99E3E34FCAD3D41512B84BA676A258679BC8AFFADC8863
      87D9616200E48DC7EAD7D1399007D6EBD1A91ACD917C52E7E6C684BB8D416072
      8CD16C9E413593416DAD01ADCE3EA1A1BB657FD028DEF3E6A492A27855EE8AC4
      B4CE4CD6002C942A5A198D09C38B6980F02861C0739C32910A0D73EA830617B5
      AF11D68E862BBD44A5F3BF8AAC3A450D30C9E2A611A4DC79A136491ABE70674B
      9B51D6E8E98D988A5E4A1F72AECF478FC82C26045D0D4EF00C75721CB6289B0D
      153F4B0D979B87F75BF3FCFCCB2623036C2C59F8928E218B2DD3976D315AE0C2
      0E9E6AE0CF4452047140252F96093FC8EC21A160A46456E646DD04A80E8F1332
      356E5021C9240404C4D86956834EB341D50CE331772C2F2C40BA3765EC853B39
      822851BAAD6D16692BC3659C1442B09C448DD6C79D6607FFCF4B743A97200F79
      BDC48869C3D2686E9F286F1E847E6222B7B13E416E70F32C5F5DDE982464989D
      AC0380CA73A21144B923B7BFB0F5833B0CC8F7420865E45ED03667F10C0D818A
      964C8CF2C181B04036B7B88C65903AA56A5B727619EFC3ED1081D3C2EFCA56A7
      44CF1A8625537D7A87E3FE60B799802912DCD0694AB463D422116DA6627536F8
      D45773C371B5202A1833A9BE4233DE2B8B63696DCCD63F5AE301FA8F90D1EE13
      A38E323A559F13C44F2A794102D9E16E185FA1396CAA76B72AA2C75B15454BC5
      8111F633492A3EE4A6F061B3D94760888869EBCEA370A520E7100E037FA025A6
      288E4049CB4AAA91726FDA83C3CDA22AB8C3EBFEE7D947477FB27D242131A227
      97EB4A392C0EEE30E9159D16C3A10B2BB0D0C9F2D651971408AB46B3DFE59189
      38C46A10066CD926C4276BC1E36780FF64157E5FDB29751723830F55E774D023
      2DDDB91C740595017F1B01110ACF02B94863ED305469B4B49BA3E3F1981A3C29
      098372310DC32EB85F23274068E923E4C89C75E4BD83CBEB5002408979A5605F
      714A0E02496CC1271BB5391E5BC5D4365C5C81123F740DA693451C364F30A8D5
      8283789522CC9A2F50D3266298D36276565FDF02205E4EFBA36A05E981FA4C07
      6305A9021E9D95266829FA620769A827244DC1B90BE023C44F0054444825DF1A
      757F7C730F9C65C3F19FEF3BBDFA2258950D57D6DD11F94245022841A4003BE3
      F84A9466BACB935BE797A3677A321CC7F11851CD7FA2848303B7D481078DB468
      28EAB16E93175F63AEF81E7F9011E86072A13346BE610969DEDD1794E7C31DA4
      E7375B173B3FFFDECE1DCFB3E75F1FAAF90C87E0CD176EBB5CD64BC35FE8E914
      CDC750D3E2FA12AFBFA86EFBDC56FAF701F2A65A92452EB10873EB8539C1DBAB
      D5EC148128D939A962D9F2E7EC32958B334BA3D41F0D2EBE869FFEBE87CA69A3
      2E70FDCF83277AE87DB06FB59AD8069A74A43F9C8F5C87C059EA9FFF972D8F6B
      62634EB031A49777B1389EE180B2B2BD3CF9078454AB7BFA713388D48D38226A
      D1AF8811AC9C979F06ABB0AA8EFADD568D6BC529062459114264EFA2C73F0FCE
      DBF43E5C5AD5C13D40CB0724A74AD41339D5510C5803347A59E92059CE273351
      670B46AAC29DC02D9C712BEFD5044102ECE3F757187CBD57CD96EBF30DD3784F
      1BFCF84E7599DEFC7F72F0EDBDD2017FE09DED91207FD9A78F96CCE3CAD311C2
      8054FC5BD8D90B1D44DF30B6EF6492C42997E7117700152E4B0095FF5A3C0CAD
      22B46D962194B48291613804852BF01DDCBA6F0E2D8EC2D7068F363B4554077F
      F0D1FF15E7F4CC059AAAC1DA43C8F7C16F746E8108D9A66DDEFCCC8D4E1EFA33
      EDA82AB6F4FD439F4D8CA794DADAD307BF7162B67BA0DC3FFCDFA5D709D2A67B
      2F9927FCC0A48B97FBDF9CD0BBBF7FEDB4D2B36BEA7F1CF2FF9D3EC1B35EDA67
      ED34B1EA0B3EFE9926DA5E6B97E8C9E2AFCBC91C1DAABA55799FB6AA30E9C0A3
      12135D77A6EAD44CD4B13A3E3C7E5320E50F0F8E0F8EDE1EBE752409FAE1E8F5
      21C62F8562B3DF7D2A995D166D9E990A2DF099C9A4C641E82C282E4C7D151393
      C62140DED24B85B2201A25F8AC4DD1CED155AD6D4F908019823CE2D895D87529
      045EB6D10854FA9A1460148465A218AC104C68F4646AAE0462357D4B96DF9D5A
      EECC2D4054316DEA834EB29D5E400249604546AC8E5AF5F02BF95F73EDBF794C
      5EFDFC138E699196198F7F697FEA4BB0848C02EE43737470F4FAE0ED6BE751D0
      57EBEB9EAFFBEC5F7DCB797F6AEF9DB20F9B41DEB9F6D58BC2727EA1120995D0
      F65149A6284D8FCCDC32A040618C27CAC6A24F4C91483A2D6E281B93AF8A92AC
      CB936147157FDE6538308548726235B14464F4CA182844C16B127CBDA7CB231D
      51F2E32A0E223C861D1F886AF48A254F292B22C79A2AD4A8D7247A39B459C886
      B055EC38AC704E12955ABE2408349A69F0B97087A95B68EFEB2FEAF4FC9272D1
      FDD32E72D1B65087492BB911C04205BBB8EB5B795C59C987FA1FD8EEBFAE6AF4
      D5CF08CF493F1C62BE6B8E9A17779BA0FE196E82D5767B5AF41CD986F2EFFD77
      457B3AC0EE2BDFD9508AF77EF7BDD229BA7ED84794CFBAC783C08A0A2D92B5B8
      A7B0C22595700050E034B799AF209AA52A0CAE417121E75D0A5D58E74AC2FD1B
      96F783EA6BDB4F7AAFF43504E33B351AD25BE087F74A4F708FE4CBEFD4248E89
      AFF6EF6A94E4F8CE6448CAACFA9753745ADEDF5E847B5525A92A2CCD12BDBCFD
      EAD035519C14F7118D097D0A1AF9C729FE47ACC6B32F02F6E99E811FDA85943F
      829FA077ECA1DA651694649D1813A133224396B1234C8B6B3F6D2D2C69E3591D
      8C3B9FC8F30F76B7EFAFFF32FBFED54FAFC5A479F385495DFC674F1D50CCA6DA
      6A79780D0BC213EE23A767765B97171BCFEC8254881C548AC46B880FE08789D5
      DB2D000FAA52CA898DC7A0A8ADE2A1EC99C1C8126CB2BC1BAE1BF3F6EDC336E1
      0E761F05CF4ACD5A30848C2C39CA26A1DF2E233165B81D6983A24F84B62997EA
      0EFAA29487AD8FE94EC15AD2B942E306B877780314339037CE6166C9295C5C8E
      3A156ED97C59B941BB242A87FD7F489AD776FDFE26F3FDA31F3C1E9F82C5AC30
      ADE06C023E6149ED760ACDC2523FF03C4FCA4D7620F62843BDE3F145B3F776AB
      C12856679785E89C82FD668338B7126CB796F52E33E7D3FF79783E6C7C1E9EB7
      9FE091E0FC198F89E9A7B4FD019028F33F3B05EECFAACFED4633B4256169B6E3
      A3E59AD847A3866EF787FEF3F2B242DBCD88C1A265C884E90E9EE0CA347B44D2
      CE0ED55DF2A61A6974F83E8CE62CBABE94F3D965C70797FF2806C74EEFE064F1
      DB9C9E62276C850DAE2B28451041DAE1A92854B27DAFCAC2C01B330FBC279102
      C2FEDF26092EC0510220035048A0D98748BB1E35C4A83320D235AA36B25813D5
      D36BA5292EF00D8CC6E312C528E32A2850B943F068BD8C7709618054111B4A48
      C12CF0D7F5AFD1943F6E8ADDDED9B0D16B8E90C32BED8E420FEDF468CE0C9222
      B6A26047C9C5B56CFD2416EDC0756CA8C7CB515B3625360BC90902FF1D99384F
      C33595D7D2C91FA299A1FA1BE191A4C68DA8087637EBFFFDD799F56F5F152C3E
      15D351A236BB9A8E1072A4DBEEF315900D4A2D7F698D5C067B7DD0C867B73B44
      73B83C4580B7753EFCE7787CD51D227663452E4C45268C156CD7780CA497A5EB
      DE6C87280A8270AF800AC7DA15785F687B4CAB0D12E8FB34BDD3190AFEA23324
      A501A4C66EF325C9DA49125F1B4E94A275397957C2CE875917AD039D0FEDD730
      6CF735BAFD4EC9831EDEE37187E56ED153340F43D589F2C593C512A955F88637
      C08159CA933F2E98E816C1ECA18D2BAE42E716510CC2EF07B7BBBA6E772EB8AA
      8B81F57D17DCE9E8CFFFA2A36F9BF15834B96491E2442D8C1FE48B9D1A4F4B9F
      4445049C167200FEC729127ED3E0D62D89C422E8E96F0FE84CC7E3F356A7F58D
      60F5631F0803F1CC64C0C5F443BDE6FE78E27E711216FCCFA376B3A4D7755416
      08B036AF7A7D8096E1C214F0458CD0BCEAB11EB32550CCE960519BD669C0E740
      349C6628B48BA7CCCED1BCEAB96D12E5376CA70FB4951B8DC79FCFA8F7D11092
      C9BD2BBDC4399EFE00947E07E7985B276717EF544B27FA46470C15D9C177E0A7
      A35912E7DE7B83CF587E48C8DFA9D54B8A8A3918E3205A712B62201BBB9BF605
      7BD633A131CD2CD3DE35CDFB1E1AE7831DDEE5CC64E73A9AE57A666AAA9B5E98
      DBAC1506CB739D027F99D5609E44DDE832B9CCB3CB693F5E99A4992CE2E4834E
      057887AFE16A98A41B9D98343BC983D06FE9C5B246AD59D26ED4B95DA2B63200
      457A3795BD68DEE82044D08C9DD06EFA09F1F46698B5F2E4C68CA4DEEF0E63F5
      0EAF7AF7ED888069CDED48DC16F1FC08D03CDB89E9A8A6CE8FABBF38AEA9F357
      D55FBC72632B8C7D30F210CB36CA360BFECCD044B36C4E0B184C5500BDC41C5C
      F44F2DED0976391F5DF06F0D7442041E96ED1F435FF3EEA7BB3C5CD862210394
      C6A992E2CF6CBDF343F1CC9A6A2E16313A66E70B92DB35AA269C1BCDDD3AED0F
      039D994F4B296DADFCAE8DE2B595D1CB38B2137365EBE2A9713B2888F341EFD2
      E9399DFEE9B1CDCC69E5E1AAA88CEE4AC03043041570E0A827DC0E53B51293C5
      1A9EEA8C16F9F1ED33C8F9E132670E93AB51E757E10E17E84C853ED98F510A6F
      0DA3C0B55E988C952B890D110196845B76C07C734BF489B5B54995426337CF5B
      1FC6E376673852CB38A5853AD8611834CA914C02D501953D5729A9B895E170C6
      1857BC6DFFA94230F4C87E9E89E3DB20AC031804E8BC179C7A548E2D84363481
      4AEF268F1A73604A3B79F0968D5A9E5AB12C2B7D4F2C2A389D6BE4862A1F4A01
      1D5BD829C301A1B597EFEE84886A5EB4370226B6B386444E1A0333D5E88157E3
      196C3A43EC24735481D795889A5CEFF91BA0C2487EEA3C64872191E1C946054F
      859F53AE0C7EBAF52862BB4BB27085AA77ACE596D04A053CCF3DCF9C9E269E77
      839B08FB0A511C561488E438E693379DEDEA7D21A42AA2C3C4375653BD0FED51
      8D024835199A0248DB8EB9BB8060A79C5C74F6CCA901CC67C8078BA77B31BC0E
      A217A597C1E9CD9D82CA5442456DD75A1F060CD5BC0AD200D79A88186CD76994
      C3EF344EF1F85F4177FFADC8ED235419609B6CA113D157101198B217FB0823AA
      200A760F23CCFEBA282C11DAB0B63BEB5F9E35CEFA97A79546B0714224122873
      5D5B3A04E7A1089A4A10BD0A3123C9842CB631CECE32F00A322F20B699E28916
      EDCACCB485184B5747899D839CF8AB6C2D8F9819F698DA441733B2C41F10F2A6
      E8DB20F28A28842B526B2303F3ED10F2B727F40A907206581770575F9DAC2D3B
      05AC1F54B7ACE64860FF9E07DE352057C437897DB325BFCEE31F155B65BB4922
      DE417610C161E6F1EA723A553747073FB9E2E65FBD7A8E58AA74751C8C4EE9BA
      F16DF3634F90E8E6362BC59A2729F50C3D211488EA82051D3A4B8401173676F4
      A50838A752A22A519E105920484158E478921A18F2C8872D13330D6E1B693E05
      1B90F6FD86F4C5416B4A933A46FCFB497C8386E655E01D652389421F6F69117D
      6249EFA851BED82B2384C74543DE174DDF8F23D58D7C73FBA2E061B061AC8951
      C43DA217936096C3A0D3A97A2100A556BC980411773CE6EFEF687D5BA434FB4C
      A58307A352EE6CC19685B05B4E705EBA7471440C493B7813D85D2420BA6D15C6
      F175BE14AF1EF2C6F90E3D87A3F5C0C5FF47B7AFCE2FD4C5D5B0235D40D4CD9B
      A303C756098532D81AA519CD69849BA3835707474FFE0EF13C8AD6677990E944
      DDBC39387CBBC3086726A3E05873D00C215FBC791478048065AC26206488CD98
      8594F7D588E83E46432094DAC3018B80ECA782E841EF72177FD5428F38D7758A
      262C0DCB5941C462CEBAFB0D144281E87E4752D5DEF0660A545689C40685E18C
      1856F8EF29E8A8EE20A19C0CA5E9E30D256B38BC5617674EF43C3AF1E6285BDF
      64DFD24CAB676EB3049C18147DB8794BBFBBF9499D348F39BBFF9731F0BC3A7C
      FD1C126178FA85B201AA4E0146E9B06BFBED56B20FD250AEA6DCC7B9EC5D02FB
      097149CB4C7008152111EACD35961DFA8BC175DC0ACE4439770CD8015F53EAB1
      61FFAC6DFBE3C97BEA075ED579A36CA5D69BAB015F5DFEB73AD1DE350E21887D
      86E7C23A26BCE10C8424DB041C6138B2949443C109D1C1399B7C876F376F38BB
      3C0B8DFE410F47E21FF1EC9F0B73F2A2DF52E831973C9CFFFDF6338F0A547863
      38ECB016B99CA499F62C4D7816ABF6E5E5A046C99B9A1A0D3A1DE7C18ABDE202
      A022E44194D7E525737EFE4F95E7E30C5E5D129326EC6CF13688288032F5B349
      814EAE10D7393BB847BC3934EC5D0CB7301E7A30C788818C7FEFEE6A49B1EEAB
      2FA8C9626F454EF7F6FA396908FFAF73A50FC9698204B31C2BBD734ADEA0E82D
      09BC4C7D020BC708919682EF2F3309DA8C866A61A2DCBDE92E863FDE1ADE620F
      4F7FEDB70B7C47E4ABDEA7E1A8D11B8E4ECB7CB3F39888FF715C526AF932A317
      EAAA7D8A94B62DB945CC8404271A77D0E1E2BE8F98A0285CE3EF54BC76FCF3EB
      4DE93530D2AFC2F27984689CBA0459972F96FECE62ED986B6D1FF0923FF5D5FF
      6B7D65E7415EDD91733674B211A66913D75D6ED45560568FBE03E57EF579BF1E
      32912C1E97096BA99D2736786EE431613041AF03299BB05D271FB7F1CA0F44C3
      9149450FAC70903D342DB2A551DC5CE9A4B9CC136F4E772C9B27713E93373D00
      AA1BFCAE49E6E55236C55F60048D24F6F97548DCA12447E621B4B03A0CCD0DFA
      913C34A7458C3A578F230C5EC1DAC9828A2200531DA00B8B0A912646668F86A3
      942E913673764B8322C92E610D95E801D5208AAF6D93608CE09A0569B6559C74
      87EB81BA0F3D01F2C97BBC9C851153EE363C13A2A950578387A64A5161F6C4D9
      2EC2D8359BF39415E158B53C8D069233FA420D3F0E3B6AC92E6A90CA79051A8C
      5F4283CC98141CDA1454A6F89759EEC76FB76EBAC81481633178AE923968D8EB
      EF3C1E55AB5C5CBDBB5F7A4566853C3039E2BC8EEE6FF6F3BD6F76399DA2B6AA
      8D115D1FFDD3E1BD8FB6E00B75DEEAF41BCD56A7EF3EC27175841AD97F76141D
      F9A9A797C6FDE1AF36F556859178D3F4761F81FCC120F54C188A2B255D966179
      ED76627F92E4C117B233885EAC84B0C591B0566EB25BFC7CF0E6C8FD657E9497
      915A964FEC8249CE2E7D4F850AE4BAECC222471467E442D8E7FFACEAFFA13EE8
      540DBD3C5CF291DD6100F21AB859A41DE14DAD1C84A1558546AFA9BE4612A289
      B46A5A1682792632A9A5933B3DEB13FB9EFA4FD5D7DE75BD1BB9BBC1E404B75A
      97EA57C222FF876AC571E223102BFE0066230DC55A1F5FA6EA2648D1272CD46B
      445CE8AED4947D126D1715C491B474DE7A48ABDFAA77FCD7D6798B6A653BE7E7
      CED6D596F8E05A3B490C385EBA3DEE8BC5F6BD1FA4B80DFBAAAE528B5F416430
      C5AAC56C15A5BBABE3C977A8631B3810BAB1019181966A99A83274487DB8EFB8
      645F3708EF7FECDEE1E151FDEDE9290ADAD1EC937B951545D5F70D58F08C5348
      545B2162F99AD012F8E0EDD137C8D46036C6C975AACCAD26AB1267D572FCDD3F
      D58DBEC045F09026B13585A383C36D2BE1F8F5F6721FFFC4CBDD450730A4B61F
      9A3013DB571AC06F122A55BA3A1F59331449ABD45091F0C46C7E4216B0A66240
      585601756482F94986E7C4482C58420AC9BA086E4AA6116626F0DE09F247085F
      6FB0766ABB6C34D9A9462B6FC27460898BA5DDDAFEEFB7AA5C6FF4EB2D5B6301
      CE1460C43750179CFA81B711270BBB787AA51357F7FBF80DF4EC806E3E771696
      CE7CEAE2D3F939BA3D323779D189D152032183D04A8285398B43FF2A88C1D7D0
      A8FE6EE3878B3882D870ED0DF7C3D1F18F907844697A295BCC7124F18D9154A6
      667EB017606DFF8AD3F05F05300D6F60EF543DFAFF5E1FFEFCA33373DAF18F50
      E7C3610737FFC7D72CC9EE48C72795C1C4756B8708AA493FE24E032E0EFE4264
      31F7748CB9EDAF5C9A3852AF8E2741F6A4D3F2E2681A224294663ACB532C32C2
      BEC529058F7B46AE5F416859E46D9F742264CCF5CF51C13DD07EC0532996838A
      4E191545B4AC5C1A5209893F0041759CD0254C107B650076F8C0B2186D11C295
      5EA705E116E19FB9093961BCDDA631A552CB095EF4C68458FE6259CA7A336974
      B8850C64522E8F3A4133513B5BD71B8567EAE8E0A7839F5E39DE99AF4C6FB49A
      C0E109A573ED0782D224F61465D483A99EEAA979CA41A90D55056CA21684ECC6
      88B23395E639770E38EF68A46F82193B6A59620C12ED4F39C517DBCDDE5FE074
      691501E1C36D126096D8D6351C49E246C93C6BF9434DD6B128930BB2D484D347
      EBB4A7080F1C51B4D1B680051F8901E9112B5C757A4C878F32AF16B9424007C1
      5BB8ABD3C2C523A79442DADF620F79C453197055348503A0FD61D698C72AFEA2
      D6FA8B5AE984D6424F60CAD9FEA044BC4CF44CCE23BD29D6A4C22340A5F9BB86
      64DEFC5CC86013237FCB68766AA589541031698A4EF01283DBC50506CD3040D7
      86A7D7056CADF707ED210627A6878AC47BF40D789415DC8CD6AA33EC71875C34
      764577EAC00B8881D3DCF2BFF72DAD32DFDFA29F8B355889E73593BEBBA5E98A
      8834EE7A251F40DE48AA113F9DACC5995A003C36219E42FA034195D914E0B0A3
      FD89F4D22A09B2CC44F87AC11B2EC6A46DA051F423851D6D3D1B4FE0C093B5FA
      A5D93A50A73A08A577B40FE0B85A180D7522CD5339346CD0A84C6CF86016D9F6
      D885A14E9F0E4A7D4851174CF3F1B6779F7BA790816F9DBB87366CBB0C55B8A5
      8A67A4A5D787AD2449647CB73EAC96F386EA9BC8FED8982D4C585E15EE61B2A5
      6F10FEA544DB03C515DF980018BA3786B4BDA82BC611B305F2F4B44C993F07BD
      1386C55BD0667DB348C56946306549918143DC50F39FC27FE38E52744C405508
      CCA89E96E7CE6D1A43931589A0BBD3A1F32A8046AC40D9A203AD21C066878B17
      27DDB6DBE88519F2E0F0653BF9CAF80575D73C98CD21456F0491CECEB7FBA6D4
      09BADBD3D7C64E68A913BDC019AC89DC2A925629CCFA759C57FA25E3A7A25D72
      8D5F81701F90160C5F4DAE557704C07EE538498DD8E605944E983671828A3E68
      9449993B9A18201E69718A2A95FB5AF93D14E4F8CCAAF6E1980C02305393AD09
      3B43226A73AA01B4CF946210DCA7CBDC6685A568CB7D2AA2907C13EECC9747F0
      09A022E284AF38C177B83AC7A6BEB724069BABA5D327F275920BC35C1E995BB4
      5AA4259A6B48F7AD23E114A9D3DF0F5070B4260E8FDF16F9E95167D80A83050C
      865E0C57A5A1FAC88FAA732E2765DF849C4A2D3575587550C957DD3F67DB0C41
      879695C90468E1A803ECEAC44C1393CE995CAFE8DD4673A913D19E33B6E5F835
      72376727A7BD6A2B2FA49BEAC04753D9A91ACE8D718EA6BC7E650D25501C8DC7
      9FAF9A83F198590290A9881A3DCD98CC3FD559A8CC4B708DA84A200BBEE8F9EA
      FCE8D7F6D1C2EBEB736BA13BFEF0EE77E5F157E57E62976DFB9292E95A2DE288
      CA0174A8CC744A0CEF53B2A314B8FCE7719E10647561D45EA5FBFB7E4DE91091
      318A82E276489B4E48CC3BCDE681B3370924160561CB4FC4495AA3268D45CC16
      72BF3013ABA654F152D001D99C9C3A72EEA835EE16607F5BDCC6307D924C9673
      2304517492AC512607AF524FA747A59282BDCDB560F29E64220C4F8FF0AC0373
      6BBE23FC2D26E276EBD6ED07DCD9D963391C03130668FE033B8611E7E94176FB
      A0592A13AD5559B2690103C0B197CB24D6D21B5ACA2F2A1D7F44DDA6718E0EAD
      6CF38B915B749D050D34F742B6067D498A5CCE9080C0078F7ECF2E8C57724E47
      26CD10EA3AA20604C54F87AAC3E88D875EFDEB5FC602882E2D4E422B4FB37871
      1044816D7EC0F9013F481333D30924C7646DD793C5B3B5A4A9A30099327611B2
      D8AE15EC4A5AADC79F139807DDC502F7892D8462922F532E41BB9373DDDEF5E2
      7C4BDC8B0A81429456BEE7E0E002F1911B73A0CE821BB824E8071EFC616A6C8C
      61657E7C5D9FA02378996BE2EB03D34A0AD40A7FEC6E8BDB87B6F71481C9FA08
      054643936D119C6DBDC965B479F0708F2133A8628522D7F1544DC0B9C1E1379B
      B6092A0115DA4A9CFF1C77DD2CC0E120DBFF1A3BF5469D9D086258D04D98157F
      2D430B40928747876A114439F2BE5CB44BA5C607AA1982D57B36B7601A18A729
      848974644FE2156A1AA83A8D649D9D788000FA8CED5AF643D20CE906209BFD9B
      4088C76111A0BC8DAE151C67A86A4E95AA3CCA009CA298A2543EDB722D3B08C5
      F46296A8FEE3B768984F5284D5905BC792E7CB07AF1AA28A69F99550E7913787
      00A1B9690F06CDFD7B23193CEAFF1B447C4E41DC4155D9F154A5062C28E9E32F
      CF47821074D8803DB106EC69A84199CBCD4A0191082830F1B091CE60B92498C5
      A4BC32C31DAD8807D94BF22C88D66ACF62EA10EE5A2C03CED3ECDBB657B6ACAE
      62AAD794260B5EACFFC2C6F6796EDE3C0E00922B49CF031F5D63A9FB15F93691
      4198F8061EABD4594A832DDA784F2FB9909D4AB9781618FD407571EFBD24A704
      7316432E48A4049FA196211303CF4A6486B99DEB3CC548EF25670A2B557CE505
      8E621E5188ECC650A4214D81C3E66ACCBB7DB81E92079C433DE5FA02DB9FA6A7
      974BFC6FEB4E3FB6CD7D421D1BB6C7B245A1ECC186C2ECA3A574815E36D4DE35
      07DC0D6E080263E2EED8F2DB85A6D2F445A1CA82847442BDA4D2131A3DC9F4CE
      C278A2C31A9DE23A535968AABD2CF2EAA954F96F04460A030FDB5FC8528EA71F
      946D3A08DF176D9E09C4748204F5E9D26B1CD5BF520D218EB05B68A907D0070E
      08CA0CB9D72D39094393A9BD6EBF3DDCB7CF778B8F901D46701D8069F81F7B00
      A6ED935DC63F23A7B4DB3842CEA4F63E5E347BFC68CA8AD8DFDBC3B5F77138EC
      ED3654D3FFB7A6928061A497EA82FAD2EF5D14C3E29745FD27FEAAF686A38BF6
      8ECB282D9FB9E931113CD060F26BDB047A0F7D8F9F662479A47448E53C5EB5EF
      F4DEF07434B87FA887AEBEE0B352B5D7FFD8BDD857CD285EE8F01B869D24EB39
      6AB2F1FD71FED3F1D1F17F82FB4C001AE81981433C5967A63E8D933AFE4135C8
      F2590E7AD00BE5D11204DA1E678B24D07127CEF1F597210AD7C023CE698EABEC
      C1DFDE572D30D73FFC4EDD29FBE6368A25A16C9F083CD549989B6512A0296CB0
      4CEB8579473109AE7C5906126AFDFF897BDBE6B691245BF8AFE072EE7D4C4D53
      B4FCD276B763A66FC87AB1B52D591E4BF6CC6EB7630324410A63106003A065CD
      C6EE6FBF714E665615408AA428753FFB61C74D91A842BD669E3C7932F730B8D2
      C7C32F939D1293A3A8B1031CFC18CA4111FA8EF2E47CB4A6E9CAC83972D58765
      26C5EAC29BDB31394AAA2F7531EB4707C54C88365749657144751C56365725C9
      B40A4BA8D19EE2C57387DBA68C27147AC1C0DAD5437B44493D2040032F9DAC41
      F100A35002413B143A4E41B85B0E673C1FD731EF115799CB2E077FB06B32BCE2
      3F0C945811933271D12010B72E4ED55A8D8111A935859027CAC9E480E019E62B
      A669453695D6EAC4F555D5E57CC8D829DC3720AAB423C8B6A5FFD247A68632AB
      381E68D8E207F88DF64ADF9390614ADF5E52172836364A66E03FA1D29D63B1D1
      A71A1280815F256246BA13E7B964BF6759908EFF35910C54B9858B329D304388
      24F57A21F96AD1F14FB278001C943E3315C292721A7582D63BAF500C5EBD19BA
      7E62C2546E98E8C47D8DB37404D8436F59BBAF7BD1C1CF228923E0465D149956
      218449ABCE4A5C55C53095491A24F535A65AB900B053681EFBE09CBC6C99609D
      347C6B193BB296E329718F685F8AD8E210EBB5F868058C6D67768F9832E12060
      F9064E0ADC499E4B93039ED817A1580FFBC2D69CCD92985246B012852677568C
      5EBB8C90740C3813AB6656006710E737C330D4851D4A2C095BBA5E098453A725
      6C4A8F78BB5370EC3C9BC6DF69E4AD9CFA13922B85A6C5E593E280D19DAFA013
      0E41B5BA61144A2C12A6DBD7388790A5160E1A615640E8158F443AF40D070861
      93FC46E75C1E25E7814157DE110F0AE0FA7366D736B42E784EA71AED26C081C0
      2A7DC4BC605C24D7E65C7AB6BD8A1C32385D7375C4B21BFE4ADAE4845F737EA0
      9E673B7E006F1F913BD9C9BC4CC469C978420ED3723817AFA617159800CCD9EB
      0467F728E675C37ECC738C08D73D2003F575D32CDB3567D69F539B1FD6073171
      C4687F821D594754C95C81EC6046145E3B154F78D522F958A759FA2FDBCDB73F
      555385A2759891D9E2B379392B44B3C7FCF1C6F4A715C36CE20C0C8B79194308
      2D3A04168090372016A534C49898A24E8751927F4DCB22A76288042F876CBEF9
      68BA68450CB42AC5FD11866E64550C931E188C88EE6182EBA4CC12C6F7A5DCE7
      789C8A9A1053F7656FA33FB68F1BCEABF87C3D856C6945CC85F694A5D354AAE0
      F4C4ADA12580EF32A9460545B8A8FCD9494F4754D800600CB264BAE8F9DF6E4B
      06782352DBDE0B04D296755F0CC52D77D2913837C85204637AD1A8481C0D91B8
      4A03DC841469639E2B78DBC134E33C03A0A77975863477C22E1F11C92E3B7844
      035E07488F13228FC1300CA3E58BDDF0E74D37E94FFABDE8ECFCE94ECFDA94CE
      ED4AC2EDB418B9154D80E06E766E9C21C53C29BF2A1625CCA210F3E0FD4C711D
      85265C8CDF37AAC3BDF224E7402610F001975060B038BBF997335A695B625539
      BBC6BD188232A9A411859B04C512F120036DF02859A5840030C44BF1946B6C3B
      B2FA044F1F99E1A5CD29E38E7B34C05E0C6080E41D7097EB605FC55945E59F34
      1F272505000D3F8776A0C367A476A2D8887911FD368FB94BE2AA9A970C09183A
      158CB7254CC957C5BCD6739BEBDBE2C8366161D497EDEA95AF2FA761681FB2E6
      0A921B253460C510AEAE8AEBAA2E6633B9D6F29B28F9A69EC6D2A10DCD0B9C27
      9C6E802A559D4CA168E60746FAF9A88AB264120F61E78E1266913B20A57425CA
      900A8B1A78721E0A3740DF83484F2A385173A882F8008116C4D78BB18B39359D
      12198B867D1D60E6073F3F5D9F9EE14E17709DA493EE82BD26EB0D0C5A921524
      C60F3D10DCAF76CC54A014DD407D137B8ECBCFEF47D98771A52073A9D4D4EBCD
      31D5531CE6BACFBB279EBD441330AD415B95034D11A3621C9D78D0B28DC52A08
      0B48B6DA5963BE2B29167609F11BDAD2843B301F2D9602DC87DDFA2ACE77D351
      C29C70363432B4B7E7A237C2AE4FA7B8A5AB167C96F9977D7587C8DC582362BB
      F0FE470A9AD565124F57FAFD0D1294A1967698E1C710004CA10649EE92B5A22E
      538C036E52C6B2414471E9B77912CDF33201E0C4194AF35D1E429A99E61F52E9
      5386718EC5370861044721D4A3CA8F0A376475CB315525CDCEC31CB941B1276E
      EB71B356D3255836F0339A686DC354D59D4C9F4C203B3AC6DA51DA23DE2D9043
      7EF38BEC638E87FAE42741A0D7D132434CD9310DB97BE561B4A89B07BFE3A1D9
      9B82779DEF52C747CAE90A6BC70103BE9AC276302ECC1ABDF2B44939A4E00589
      3BC2802030FF054407B140C91DB80FF70B6AFD32572D004AF75BD080B8C88D61
      750326F1B7DC545EC4C76115C42ADADBFBC6FF038F0C17249E229F78AFB7F2AE
      ADB8AD9AE0D5E8D41D6CCC26DEB86AA91C4A710CF1E597438B323E1EEAEB2DE0
      A1E608AFDCA2A270169C6C9BBF8F25DB39E0AB282353495BAC5C774BA69E1032
      04FF31C028780E7C5CC65483B71046F103F5DBCAFCBE8D497EBCEB6B9C10CF92
      CD021BCB815BF4E9944E58D2015CF392ED0B867857AE3FC22B47A03311180211
      D1357B07D31B878ABDEF19F6F06BF174D77B39FA869EBA31624E753428BE8513
      C13ECFCAE22A45F45F61DB90EE71378898A77C157AA770C9080EF1B74632579F
      154627CBE22DC83A6F3C2A71E52BD4DA67708D40A9D265B3566B03AC53E7807B
      ACDCCFAFF050E7758130B66A1C8E46DBC3E71CA6A8436D6CEB75C7CB08CA4222
      3F90E461B9695D6E6BCC33F5462301E29720856190C1782ACA9BCD87F2DCFC7F
      1953DD66FB4CB38947BBE7798BF8D81ABDD789648EFAB8B203148C698507AAE1
      01565576D31CB55E749E8DCEE2B292FF00985543AE81B8113F5A37AC661BA95C
      FE2EEE917EF4EFC5DC0F2300304A9FC205F8C26EB92AEC16D5F5037C37E6CE01
      1C11C9021F6673906CF08AE2FAE278E2CC03585A51856DC9F62518A1421EE2E3
      3927974FD41043C8224972C396800CCFA0169892C8050441F07D1ACAF8AAA44E
      51A7BEAA7D38C3B92122B41EBD2DAE01EFC98D7D8DCB67C6E30CE84231464F66
      9E0886D4694A52D7698D0F4A0020D8A19EAE525DA790C2007B92BDA38C350E58
      C0674BC4DD97F04E4266209D1D60B6F0D0E7620BFF139B08B10E2D578DCFE997
      28DF11A6062E277595F2516CE83819718601C988EBB00D6CD00D240360E0F354
      C253A2E7504102BAAC6CA92C2B8FE0021E4359166446805D2217990CA8017C77
      380F2F4D7A35FA371038DCCADEDC967CD297FA3E8A6A5D2872C8DE39EE322B73
      139F7DC5251A5ABC42AE80CB60D03346F3E8E2CC43DEBA4C48FD192463107261
      1423EBC9A1683C8D39F2B29DA9854EC3614A4D4659F555D4C5AFD0397DC20E29
      55728457517D5D0069ADD31C8C6B29E383EBDC52057024D079871B95256D089D
      667385758FAD4C4F488C58C32A45D70E55CA5DB20DBE20C420BE5F480A610EE2
      E646F553990A0C3679988133FE8ACC024BEE72162F283A4C6BEFB104402F4AEA
      61BFC711845BC6D2EEE63309C8DF1ABD00C594BFB99BA619B16D80CD383B845B
      27F91CA6D148B24BE9B8A6E26F4FA36E00B2CCDF94E94818783B419001E6110C
      06DE20F0EFF494297528A47F6413C755DD6BF75E469EE6047B1D26C279EFC06D
      7CA13E2B68089FBA177D4912BA9CEC30D69CBC9FCEACE12B58F68FAAA8041B0F
      3CABF656E0708861891486510F2280699D04F2E39E1B27CCCA2A8AAD3E9889CC
      F4206A1697F8A30B115537F0C5E11E09FB54019E794EFE155CB0F2C626C837C1
      5B904389CEF149956BB8175D09478F8F4AA74236A4C9A17BB82149B27C4CCBA4
      B56A7CC45E5962440FB4A3110672D9206CBE479EC91E39308EF3F04691A6C19C
      61FC57D13BBF36A4839A976D76671501A81482B4E525F9246E741ED5109292DE
      3B11A7D19C8B5471D7BEB811A07D46405ECA086EEA147A0A648BE60C647BAB9F
      45BC2FCE7AD11C64C8A422D14FC6068848324D4AD051DF4ABCC6C3DC01C04CB0
      5351DF191258E4CA1554F6D6C9D11B8C7A7C6640606082F0D2CA2B5774E83D7B
      432ADC008B8D01630190C98A092F1FE19D027A7B652BA7EA458C6A4B6C58AEF9
      5BFBDA0BAE5B77F4C755F352E4767397B1E52114C861AA1809589A395A257A84
      5B8E6D4F43057831E1EEBAD4860063D747A5A506ADC3C39DD98FD3595C336D8E
      C52A25096D5C26E46A2A23F00E245C31231E55B071F2E1EA28491E6592122BBD
      AEBC27207745EFFF77AB2450EB7C57AC968C04A9C1D49106499E8C8547910629
      0B22189FD65112572979174694BD69F00F348E0837CDB3F3892F3284AAF7A188
      74EA129B95C06694B4A407B15CF4A0BEA003B312A2971288A7FB251A977696F2
      8455A22CA31962186B807EE3441EABE574683A0ED19914B058E9BF268FBE9A32
      B1E0E50B3FEF47EFA5A60CC1351C475210C4715636EF220456A3F7A99CE33C72
      CB78F2287F745816330F11BFF3D21697CBA42D16D732576631DBCD12924ACA5C
      EE497CCC2699ABCF3FEAA79229B7432D9468C633BAAE91FBF8DE840EB87CE453
      088DAAAC853D2D60F6C0F907018015649C19478E7432AE7771392D7B236E3D5C
      651C7B8B09C9F39B30B5984F2B4F5978AB383E6AA69994B10CEE08A3BA90B1BB
      AC2F851616B3E348C0D5DD000B36310C04DD2565DE0F469F8E95323D216523B8
      7C4F70110B5AB2370E5D658B3E3C232C664AD28B29C79AB45AF0C41DAD780420
      7379C6A3CA406045A109FAF645C17FB70142B1A20C4421DC68200321C5C72AEC
      D81C3418F05E765509364887A199833742AF375FF7268AF6F2C526DA00A1365C
      F04B2F08A0F91938799090285A5C981912C02C38CDC80A2F161ECBF9241A2559
      1D8B9CA4A4A5A012C397907DE87F28282D8E4E952D577427A403581AAA1FABC1
      4DD0E33B66D905AFBA2CCD6E5CBC7CB12ECF0E52ECB724DAB5865885F310FEC3
      D62EA2A3E1972A2963496EC3C24FF3396F84C6FE0CFAD8522F82F11FB1809E5B
      AE6AE9E3626581361DE7CD97CDE5D1C5B357D1595196386A466E6174B1F308AE
      45071614BF59195D083243252919D653DD4A9A447351D735B7A3B9932149A319
      F8F6AC1D16FA69ACBC3BE739AA02D39A35A3FA63129A12459F9E2610F995E447
      CC2DA420EEBE5B27D5336E8C5D1E7E6E4D8178806B01521780E17AAD15369C4B
      3CA62E38549884BB6574EE0F99D6A1EB490FAF433DE887AB8166F74E94EA0232
      EF58B9A3F42BCCFFAAC5E775273ECBB140C399062E5866F4389A605D0FE350A7
      20EF5122076C50110112E8A212794377BABB90F2904EB71ED596A3F2C8F88D7D
      4CDAA04C4713A5F84DE2990949B3341C5761E76B5AD6F338EBB898AEA598724D
      EAA9DD93F45DA97B00748E0D822568B0B78308A481DB9D941593F449BA12BD41
      CD78E9C891D88C87928AB3922298134D9101D671457FF81A46FA03F00A0E0708
      1A062FFDCBDF4DC44658B11EEE4A61B9E24A6E90CDEEB4B84BE27562BB1A7EE5
      47539E026345C5AD084DB85D5D949338D77D1739DE1F908B62848410B7420491
      DD7C0C29A3C66CACA3D353475AC0967335F956C7D8728E189882A3F46B3A5222
      8239A5DDA590D58EC48BA683848E80AE8658FA2083CBBCE69A7EA39A1F0EE64E
      F370D614FDA503DE822AB43A026C8EB0733677A460A64815C7D89BBD893E7032
      C7F110130877403405EA32066E302ECA6B20C97A8EDAFC6AB1241A9F55F07261
      9FF29128502A52A6291B7E1184DD11DE80F5A82717FC28416E9F2AEF38E09342
      974B6DCF5562022691A0D02F0BACD0A4944C27DD9EB41C2FE3C1C60BCA9EA46E
      C3D1B7592CC544F9D8950E8E3F14BCF1CED7A6949D32FE24CAE07BCB6305E94A
      7D6F5B179389D0FE2B583DF88DBF537EF9EE332C925F763F47D5CD7400C2B554
      2770851142EF832DE36659B870BE24378302EBC0175AF80E0FDE6D90FF901F56
      2025D0BC72CAF32A8D58200EC7A6E4ABBA4A372A0716935ACA6E881A26161663
      8058BFB3A4B492D083B81237883093A87B259ACE6E0A849893EB38B86FCC5858
      BE786E9FE4D7F3EC4B74EEF395794E1DD465863CBC75719D017EEC939D7BD155
      918DA21109F058EE78CC97044033C3F4984CF5348A912572BB7B8409E032647E
      C4781FC9C41BA04AE3E066E65252AA643C9790942B7D26FE8DB94F02A424DF62
      04B42C15825305A28B825A30E8833941D3262FA0A22E0B13808C89A0E87633F4
      2629EAFC1EFF5901F0F25945E1F3330013F319C96334CF6D812BC8BDF9641E6A
      AD7495B89203E123F04EA1C16F60EE1D287E6A592F65E885369D7B0881587576
      1E7F7EC54BDE0F9B160A2DA3B79AC660BF71149B8149DCDA8B9F4BE5DED0B858
      020208B7DEAE52B78BB4BFBBAC99C9BDB4F9001EA949E58ED475A94BF91551C7
      79E56C04665D4B86333351168611C3A656B457B711BC4BF38E5D067898851FA8
      7F31E5D03DCF4571EC6871D320A75220C220EE93C3857DEBA1CE01C5A4B066C6
      49321AC057F5247978FB2EE261581E779C070EDDBB072F47834A3ABCF9648809
      B37B0A6C6CB319696514B9C1DFCDF80CD721AD35EF626438E26D4A40D9A2F14E
      36BCFEC02832549E0E4DF6E0F4B1A7214F494E39131FA63FC3C38C8E43905BDE
      44AC5AF2B281E1D041F1EE0E66763EBD83CED927A1939EE4238497110240470F
      A067B5865FC328BCBC3E2B51E10AC26293E26E712DE24024B61869B5E2F9EA54
      15F8455E74780B6F1BF20CD70773154DA7C98850ADB3AF36377DCE8A5182F7F3
      DB84A53516728A568CD147121E402AA0A2C1F9E12594359626492F323EF8752F
      D1D7C80991BB21D0EF43356E97C8842521BD96A82F4F8505EE2D37A97B80879E
      8CA30A9F21DB352271785CA8111B262BF4F354925B19B4B7744A995A7133251F
      2C788A794C0DE6FF10D96E9E06E230176708E8CD0CB685BC2FA8172A1941CCCC
      5449397C44BEAC21A40F73EB52E3CF68D11275D3C74AD873906469A292A7529B
      1AE5DEDD6D6015BD766314433033ED2E34A1E41B8F0311F18E2B9C072BC32153
      E65B82C467B8275F6C56A43441EAF6642AA0C8126392ED9266827C5C310BCB47
      7FB42742CF9B331FCE9F1E5C01F47264A36943702B8674A9EDB1EAB4B0A0996E
      45BA3BBDD0D410DC0C180711D71445AC254739153F80890DCA8BE2E1A5B15929
      3E4B66DF3594F863D8E2881C36BEADC59A4038527F8095CD2DB10D787290518B
      7170593886B8C1C65423CB28EFDEDEF7A943F29E5C79CC69B1D4625C6C9456C2
      017F0714E9C2A13C43B9FCAC62C34A1319DCF110EC7315F0B8F09132E503AD76
      E7870FB73340DCE334AFCB62341F9A94D037C9CA690862CAA4832D4677456935
      1AD5E845D3B9FE197BD0220F3D47D1B123C05745F2851F3545DE1267C8EBE0CA
      21AF834688B8CFFE826B3D6B2AE41C1140C0DDC6738EB20F62B19310A46A715E
      9D89C5E8C570C4F2B1D4EC46910F1FB809FB68CE22E20CBB713EDA9570882456
      E8CA725844E6975199565F68BC6969753B86343F321C718FDB1385B0378D6F54
      581EC92D0EFA5118CAEB742E6621DC3ADE3237F1DD1DBC7D63C0827AE14A87C0
      9F67D50F4ACEAF3373A79640446CC6324A65BA717129CB56F3748449619D5EBC
      A2C3EC9015B3A99522FD6CEA8C2D9006FC0A93E80B063DE40604D1600302C1F2
      0F666071A0691C26695030A01F1DCF4B5CE98090F4E51F555266639722FC8BF9
      7C227E6D216F56567742414675F4BD77DAE07C0DCB5A0977AA3F261B5B716373
      E98819E5385BA55817186B33F0E8A2EEC9BBE3F39DE89C3489130937EA772E8B
      593A8CBA8727FBA73B77882FC85965A6B801BCDEB47A159DBC3B174ADBC9BBF3
      FD7596169AB7ED157850421CCC93EB5EA4D85B70C7AAC1D0686751638B56B670
      528314A9E0A6B6881B0C7F5B1DC1E5EA92FA992BC52F07E90481583B120B3460
      4C584718CDF20D9E7677AFD224661BE64EA66EADA2B19144513787042AFED6BD
      A998792A4F8CFB99C31E58EEE15905A7712C911CD610495DA74C4CBE795486BF
      4DE849EA895125CD6E485B69A9B629A5FEB9307972689059ADAD1C69A29A2651
      EA6ADE7C1C0FBC5004F5A7047BF9B02E01E1301095E4CDE4E845E358EB07B630
      6671C54B525B2670315D94A7A2A02B7FEFC829E1CAD3BBDEF98F633985E473B8
      75864C0933A8E1D7AA3BEB458A02F43C2067E196D657174118960D7276ACD2C7
      B6CF723365C8F02D97CDB8D86F5B37C3A4619FD5CDF282104E569E3C1BF4A7AD
      2E6AAEF2A02F5BB71ED0CC84FBCFB9160D0F81D06F162678759A86FA40BC05F4
      7083E5868C5801CC8979CEA7E4B4234B4283E72679AAC13F119E11DF8B86F7F2
      7B3B50BD14E72970055AEB14EDDE14F33B1C573881DDD1BFEE90E2B7834B5DEC
      49E9C5AD4B48D5734762373885545329EA96C9705E22D3C3E93E6AB2953B09C3
      F41C11FCF1C718B963CA16F3DD701608C8A2F1BCBE42BA20D99055C25C86DCE5
      A39B5E81B6D8C8BAC1778AB2A7CCD38AE2E7178C6CBC39FA7CF0F39D86797FB3
      6156C9568128803D8917C807F891A73EC0EA6157F431A6F1235130AD280557D1
      ABD4A89F68DBC29DF07ED7F4547A210C6668EA9D2FC72254FF85ADDEEAB70EF0
      B572DE9CD65A37ED277D790033EC39AB82A9B920FA8E95606006B61438685F5E
      B3A4846D28465CAEC71BCF61B33909EF345F563ED3248320194CEF383F461C45
      F6E54EF680651E097070568C58F04CC3F46BA375ECA13998C6E06A184EBD6095
      6BC50187EEE32C913C80B8023CB5C8F234E2B43BE85910BE796DEBE08C242937
      201954CE4D707712A8507F5491C61F9EB294D5F9F3E8D3D9FEA17A16762D4B45
      3E2D73447F1C83318B21AFE475B1B66CF805B4EB2FE6834919CFAEC42D601EFB
      7550C445E9B18FFD45BF65633FA0C895AADDC83BE6853B3F6D962D87268885D7
      457415972371E6EFA363F9A71F7E64896F660DED5715C6B3C85DB521EE3571C8
      1DA16114BD26ABE09FF3290F0F1C4DDBB5FDE3DE73D736D7AA39685207495E58
      9504D3BCB93502C92E1205180C9B16600D699A32B3F8B1A9F428DAB68F3F2CED
      63A0DB16CB7AC07881DD77FEECF1F1BB4F42C61AA52320ACBE201770957727C7
      FFC1F7F8F9F8F83FA0E4BC785A6CDE3DD61495EE9D9CED1F46732D162DD9E569
      4E2EDCB3ABED9EFE648FA54017DF9E0C3FBCBBEA0FA481BAA6BEB356F6737E36
      42138AB1902200BB61CB5E3D7D1A96AE606EBB2A916948548E89FD4F6787ADAA
      9DD43D4545A17B14A67BC6E2162CA9DD397B73741CFDFA6B74164FD2A1BAFAA2
      71F2EBAFD1E1FEE57EB4EBFE731F5A877085936947F1A84A0BA9FA141F04F2FA
      5BF70C45E790793F865CB526D7909D14B336375D6F2BC9196CED8BA4464623BD
      5925EB1548703B0D0DEC93C3FB578E3BF495E3644DFDDB575E98B352EA1EA579
      F4E2F940CB32082E1323ABC8172FF253B9FF494D011FC61666F6EFD04D08B3C2
      80B072B892A5C725AF32843B9A93C3C00DEB30098DDA7B9CC8CCFB1DBA76190F
      CC52CC5D281D81FBC7F43828B79BEA3AFB1D9A47B529E0341094DAB6A861D715
      3E49F864532E573EA044DC255AF34DF638A36AC63C799036653F1F09B56014BD
      BE387B7FBF4A8DCB1B904A3BA79F2EDE475DC6D8512976966459B563418B876A
      8DB7D06758A95280C7C54160649EBDB9F8238B0DFDF03DAC3979F9568230883E
      06D6A95DC7E8223C01E1FF3903B6698180225C6C570AF64F4FF67EC4BD767974
      F1FC15BAD50818ED1F7C38FAF5D77F9C9E1F6EFD70B55D5F4567E77F3E160489
      B53D904B59E48FC1B71B20CB9497F483EE4A1963AA8F2A35E439429D170848D6
      AFA2D74541290D9F5E5017F88D2983E80162FA203A2106B06FD553CBD6026753
      76AF8B14E9A93E558CFD30C9665769F4E449FFD9562D01584CB1A31EE469ED2D
      25232BC3EA426412F2141E89B26973F1737787592AE109867E1C71BC2B40EF41
      96CE4880DCB963DA5B74F1E5A64CA7D1C511CA9629B13C3AC56513708EFBB378
      BB75F5AEB8868F59496DF76151D070005A1594F06608D28ABDBBD08DB6BD55B3
      EF4B0495259A6D5292B292C1EDC1BBF12060F16612D9B66AC59D85D52C690B03
      ADAF3D96376B8FEDDDA5F6D87DCBF4EDA148DD31C055290541F1A6A87B511733
      AC2F29F07B844C8F9F227E289FC024C85B4BEC0EAD3E79EA2EAE03135E8BDE24
      F5497572E8C519617FCD90761D1DE5F00B28E4B0ADB98856717AFE62E1F8CFF2
      2AD5E3BF6995F78BB3BFBD0B8C2DE06558258324679918D599D8B6711AF7278E
      2C03A918D10C451CE9A64CB32C1D3AE6336BD98A8C83C6EDDE970572DBB76E1D
      AF0E934A4E7785043CB925453142293E3E9F123B263521CDA9C21E9D9E9F5FAA
      F74BE757F5991FF482E96B616CE57D58D4DD6B97F1380074209AB02EE94E61C6
      7E52FD5FFEF6410EE58338A30A77721C0F93778809669549188C637F19C44436
      1EA4496A5548CC47AE476989AABB1A3E208D01F14C962A93E27FA8899056725E
      DA5DC03BE3413A65855A4773179FD2BBBB738CF430D5437605B1153AA9E7656E
      E8270A27CCE2AA7347BB50A7F741DEE2E2E2E855747AF2E66D748DDC7165AF9D
      32A6F453747AF4EEE2419AB124F083CBC37D11A9C6055747DFCE5FB7B8450FDE
      C2BB4F0FD482DC8E57450DAABF21B6E0FE7F77D093FFDDCF6AFC5BF43EE8F9B7
      10BC85AC94BBDF80CFFFA81BF0E54BD6A975B6CFE3D3A3CFD16EF451C1AEB378
      C662BE49195D62B58876E8F73F6ED9185159E45A9C0FB2F42B2E3D0300BCB624
      F6BCC2FE6F8E8EB76CE8475EEB59CA646F12FF044B334E3AEAA0494E3E8526E6
      835DF9CF2DBDB03DC066312B9CB2BC3CA9E73CC930B3D745998D2A64F66A12FD
      E1E9813FE0890449FC28D4245119CEFB15FFFDE1C9B36032B54023AA5EF10443
      611AC1003C7B2D3A30058E9F415F23AB2A2BB6F3D4FFF403E1C4E3F367AFA2FD
      7C7855401A8E521EFF5FF41E4CD2D3A2F852CC6B7E04CD6C2E35447B844962A9
      2A2A7CF3B7FD832DBBF11CCBCE7208796D798CDFD245CDDCC184F940BEB3CCDD
      FA7C9CE6FFA407BDADC3CE2179F7090959BA54A2111A991639D58909B12725E5
      7550186E9214D3A42EB75D01DF03BA94E2BBBEBD6C98CFBFC45C972271985262
      39CDA377F32FF1EE25560BEA9C2775F435CED36A4B94FB0782DC102DA9D39959
      0FA3B412660EF8045213586A2E6EDB86ACB1E7AF2C61E87C80092291A98ABA87
      C7E7AF0D43F450FAD7348E70D816E5B6E6F40F2F9F606BF13E92E3EAA2566262
      6672D762E26FFBFCEF15487197C233F10A34819C6E72031ED715BE6DC40C2632
      0B87E118D07A7F9A0D831DF0E7BCF8B32ECF6D5BC06A10E3464572942159CCF1
      4ECEAFD7FDDED68FDD360CF7DC5F709FA30BB0ADE34CAA662FA1C571D5D33B36
      49FF6DA35B3F46BB86BEC9E2D3D78C670504336757AA97A148C37227E3E61EA6
      EC9F7EA49BE99690117E85E4504A41B442EE9F77C955994E71166CDB1446F903
      4C04CF5C30321F8E76294DEBF5005125B661C96FDB2E56EDE1874622920F2723
      9A018A2B6F79F9D7FE6864B482E3678FDF7DDAB6DD1FD592911CF2D334C7B2F9
      5014D32A3A2065247C6B335B31F4588074D81ABF21558716FFB60B8E717DC114
      1073F22C3E6A6D45294A5C6FFDF0E778F89BA47E975CBB3816D8EF527B782F8A
      CB09ABBA2B87C4DEFEE47AC09413A18844693E9B6F0920FCF8FC47052F9E7F76
      D6A3D4E823AF27AEC83C32FAA084DF3EFDEDE280E1E26D43C0B85A58367A063F
      77A4414529BF83E8A2EA09AABBBA6D2B78B3BFCD5314D69CD745249ACC7A688C
      8B7298EC4A1A41D4F9206ACCE7C717978C7E76B66C52A818A76F24EA7F7C7A8E
      3CFD7148D164FD33013FF0BA33644E82B2B16D83B8CCA8F0AC064E53CABA4C76
      1595F4864A50930F2F4DE9B5AE642D7B260702DE5BA2703FBEC4E9F8EEFDC17F
      468FDE24ACABF87116FD3D8941DF79E42C06F250611B3E616EC7B66D612519C0
      E76A2DC8F5F736FE17F2F5DD1622CB512122492FA119BE6DCB986ABAC7519A53
      B10F5578B89C46C9308B2D555EEAFCCD67DC4934FBC127E53F2C1FE061E1AEA4
      CABC78224AD24884571026AC7A57E24A8A4F062C2197246C1C44C14BAD6EE4B6
      67E86D5DD553E7E8104261C835B938C060FAFEC8EFA2CE91E5C23CE75A11D983
      31EBC8EC753484A1474687A92AA20D8341AE3A68746B8FF7B6AE1F2126126717
      47C29A093B3D4B4A3191A55E6DE0EB302718A46AA4B3B90A28361BFD4185B4B7
      B2C5827CD06E9F86A76B507F9EAA2DA2BCA79EBB028552AB882AEB7CDE83F6E6
      C5F308A5092CA5C6E1F3A21AAB52E6BEA80B658585B0F4FC9E0EFC6D3D52654C
      E8FB6A1E0D24C50C1016141295FE70AE98B47A7613FD364FE60030E3AF2E2333
      AEF98C5E40ACB67A4059513DECACBAFD6C562EE8D97C03241A4BD11AA9DFAB3A
      5C636A6A1B61E5F760E975657732FCA5A295E8E93B801175A1E7109934799CB1
      530C64E396428172590165F50742BB7FFAE12910BB7D52612E2E8ED82996C5CA
      91309C98F7A4F4F76D8FED3FFDB807FFB6F331BF82BF1C6759BFDFEF58949692
      1A641A5B6DB36992CFB76D08F7B08864908F4843353A7B7B7819889B87561D44
      A6C55EBAC0C56CF2F055D4458C60F7840FF83BC00D3EC485E4378F08EBB1E944
      FE30C86BA4465483AE4178B8E5315E879146CF4A9941D9092AEC2B627222E56C
      07BB891582624FBD158BCCEC32833ACE247FDA0DC2E63C630E311EBF32B1E346
      5AC5C4485FB584E4EE6FF8396CF2570042B1CDA949EB3AA2EABFEE088ABA38D0
      9986E8AAE9A999A734762ADB72946193199145392C5A84F5C28976E2345E5DB1
      97A696CB3F812B0CB7DB670A210ED78B50D6327C9B517C9D4FE6C88282F7816C
      DC221F14259D91F595F73C3F44E77448796B3769B08BE991779175810A52D73B
      FD7B87139EFD51E1841774D33E50C77C16E77659836AB8E50349C3D55079CB64
      7AE5A2B962A70A6911B2F598FFC75121402067155BEEE2E0FCF45EA1DB3FBDA0
      AFC61A111A787419B555AF4D4FC12E15D9A77DA9708490B2C884F1CC64DE5A92
      CF650BE04A508570FFA34602EE965D7E812E53C12EAEA3BDDE9EE97055B339D9
      805249484E953052A1F78881C65B72675FBCDC73F377184FE3093C4060960931
      4B0623B37840BE9E438EB66D4A2806E2B59E5C9E498C85E7A609F1E651491F97
      E83AD74B33C55E92B5B76D9F20C95501D1F5E8E8E2BD98A867C5484414B77D2A
      8217FBA4E27E4A0BA94BA41A648A1D8A9CA5D648815815289EE19B6ED9F28F4F
      74EA1E43151754951941432E26C9DF10A5401EDFB4DE18A5CFE27C540DE31975
      733296C2541CAC342843611A078EE68FB6C4855E10DEAD20BB31E71A42D133C9
      59E5BF34DDC297B2A2515ACD075A6E05796A2CDABCF52011A6BF99319102E8C1
      4F87EFF6CF7EDACF531508B8BC9925AFA2D7318EA1748878FBEB18A352A7C32D
      9BFC81B02ED52AEAAB6810237D162BD8B2FF290389A547BD2B5120AF4C845AD8
      9D148B2B8AA89AC659B6ED9B137A1550FB542BED16E3A87398206BA34AA2A3DF
      E6E98CF859C706073E6E31D280C5B6EDC2FE3D90223A4272352F50ECC3830C60
      1DEA0FDC5428B88E7FD525FF0523E9EF1C800A5599B685EC5E3275458BA74D17
      8AA799FC8FD64E63250AAB15576B21CA79B52594F4F209DA5611E3AFC18190E4
      142C5495EE645BA8EAE5531CD80274FA045932E4B0A4C8198140F2C78BCB6D1B
      C0B142BDA9CB77673E28CD888CE53C82579FD6352A7AC22C9AE752DE89B2AB4C
      0796536FEF1E98DCCBA7B8184FCF0FDFE0368F739E15D25CE869CADDFC3589DE
      7D3C65014694BA45DA182134D4DEB510F296DD78461832B98E0E7E464D13B8E6
      7CAA0E054E0AD5E994691D31E4E06B952849CC07AEEE8116BE7C069CD2E52039
      359194B810C8CF3E01DF129A75B16B5612B390D2FC8B4B722CCA74C20C19AC1E
      177F45E922E4A5D277D8B6AF38F9A5B834153EE464A3FB20E1274729116C715C
      0CE7D402F089BCCE8998165B1A1D2F9FD11B9F0ED2C9DC8417186A7C54457FFB
      78711988BC6FD9C0F3DB1B78BF7FF0F303348003E5C0E67CDFD8A0CD460CF30A
      A6F900DF9C9197B965CBDFE3A8710B4CA7EB5185FF322C4BC55699B5AD0B4908
      428020B04DD29196B5820E8A04D098FD807C34BD94D28785031D8DE2B0E1FB89
      32280A9CBC2E406E4071B078326135902DC39BB7F6802019D81AFB9FCE2C9E9B
      C628251725D04987768756BD63606C229BB247409A422352094C95A8D585E6F7
      5C39E447A026155F1812D04810904ED69B67BBE050D05FC1CF10CCAC407DCB1E
      F65501F6108800D4E3911E18F62C36062337132215A3345631CB21470FDA9BB7
      0E74EC2AD8FB97E887BD3D5F36D96804020C223B33084537AA01C999C49BC565
      E45B6CCC97047ED0DE374AA368E844026E90AE0566282101AC9AA883A40FBCCE
      65D18966909116811AFF4B59496229F874C607ED71E0D783EE823E22414DA97B
      BCABAB2F228CF0A0ED868C14FC29D5D44EE6CA650564CF4CB0D69D8C5C7E69BE
      4B257595C150A35BB411B4EE0DEB816E7958DFD6DF34F7BB415C3E4899CA71D8
      A82A67399EA64FA3E4006F3CE84A98E7423ABF1709F9B6D32B342F8C4D300EF4
      E65C7F351A18DC39FEEB14923D80307D092B63ACA50A7C58E31E50C26D3D578C
      D117069AA615759F7D253C5FA9D058D66AFA3F78445293385E9F9FFF0CE16F6A
      404EA28BF747A7AEE69E8C210205305E1F324072391A6B465B1F6493E3B298BA
      7AA16E476858541D4F2BA2E963757CF443F64A8202BF8045F1596914CA5069CA
      6C85876D574B2FB2BA5B8E04C9BC4A761EB257027E799DD8802025149D9C88CA
      4336691CD5857B098714F7F78C613E284852E0DE5565699F600FD9ABA29C5DC5
      80BA97ECDB2AC08F442D6381A866DC6D2B8ECAFB28FE2AEAD28B25DE7EDF28DC
      0BDAFD0138767979F43AE05A2F3AB49DD7192A5EBBEA045B72775EBCFCB1D9F0
      A7938B135E4CEF0FCE5E8794C67B6559FFE9E553F8A5D57C3C4EBF0992018D1B
      C1846124C046972B795BC7C9D0C5CF8832CAA83D7942A488673BF84DBB4CC7EB
      343985413516CA5975DE8A434AD48FB15AC8F01F20CD12B0D476E3ECF3BCD185
      680FDDC251AB55B73B172CD677DF67D35DE87C9042BEC2CA7F5F16B898CBE8DB
      C55174E48A8B9E16938EAFD1BB55B31FE438169B2AD0AA7B5F2630F42E608AF2
      E68272B7608B012904B544354D0141C8AD7AC070ADD1C1AF5211B89562081A4E
      86BEF5B697259F0E4D40E65910A981CC1B8400E603E14647FBDB0B590477AEC4
      4B8EDE1DBCC5B9F4735E5C130CC209BADDB3259A1F572CBFA5A79D823DF76137
      808F848394955F20950A33CAA5B06BCE9A00F2C2336B315918098ABA7B7B4F76
      8F8F8FC3D5F0C3DE1E3EDA31DB7C3AC3F3951B7974B1DD65D68EEFA9469384F8
      2C1553D8FDBCA8A28C96A25327CC47D1DB93CBB3A3CDE91817A89193E04A7AEF
      4AB8AD0AE15E20A5C7577BB318AE1642114F3A96CA3B7C2A8ADAE4C5F5766293
      1273C68DED69107115EDFE566D1738D8858B70CB33BF6EFD5004AC614F11F4C3
      A3E249768FD715EA275F73788FC7A057C1A3E2E1C64B42E538B005694EC298A4
      29B9AE7C30F257A5E89CCB6E48F3E8B0C11660507F94D444B018DCC7778CA165
      61C81D662A335333A6F80B43088D02615ABB00FD0238AC1C6BD3E075F5C4E391
      15B24348644A9A434393957726F5DD546FBA7DE20386B792E9B89685D7E8EB19
      B380AFE3630A1D8D72F9E006AEA74388472A1B47474DEDBEDB5036B24494B471
      A39A8F646AEC6CC0A351BD39124F968D6D30860B93B7F65D5C0520C7EC800261
      E652A59F0627C79627C2BB02CB1159722E494EEBDCCB5AF1BDE7C48A736F6974
      75D15E8D0DCE1FE6EFA29867D1419C9646FD1D2588AD0DA86D0E2ACA76DD3E06
      8DAED16BF5ECA56BEDBE9B6E66B8BABB3EFD9D9CE81BE8DDF2A2E4D776EE4D91
      79BA3945E6E762F7385D791C18BE5A8C555732AE80AFC8E9804B014A3C4A14D3
      3A03E228B96AC5ACEB4CFCE07D5C9789A8DC3F862C427CF33ECE36203651B931
      2037AD6E2F1A14D0DD82CC2EF21DB0C9A6455EA34CD2A840B40D216420BE7CF9
      1E9CA712F0F228557C5304E24A788D1179A7D27B881ACC92FEB09846DDA2E413
      E40D76989CF3F17FAF39231269307A0FE6086B643069C6B067F9A316D9D6450C
      950E090B35EB784F810BC375D99C02878C85F27D91D455F4291D25C54AE3609F
      8BAA235FEC58A79A5CBF6DFBB8E4B82125AE9891F2F4EFC5FC723E4850C5F186
      74274EA9669F59953654292C28F5E25FEB8F521D7D1168FB99B3F73E29BF505F
      F0866565A227DFBFDCF6E12A8225E8B6692B6976B3AC4C6A9D3CAA287ABA2274
      693F92142EC6421E14B89329B1D27C60ACE6D73134E1B39B1D03CADC1A50B106
      E1F57AC60CEFD71862BF19AA00A9C03543397A33B360DD83F69B94375FEA0927
      3274D68911D7D7A8381216C4C27724A7974550E49A11CBC52E1689EB91D0CAA4
      0261EB50F904FC9CAB790D5CEA614153BADC1FF3398C1D8D5E009129C6D1EB33
      A960C3600645C7A5D6595CF96C990AE4EAAE22AB7A7F0D92E89998443B0FDAD5
      A0586931B6E58A19C6290896B3AE0689E83C263C837F98F0BDE3CDC214115D2C
      17184BCBE17C6A753B1A029EA2E562215787BB716A9C75C712B70FFAB29D4314
      3E6F2B41763C8ECCFCA3D0FE0DEAD1AAB58848A5B99FC6B5E156A0AC8058CB8E
      E5C8039822920FBF47E4D63BC939929010092A3E723368AE52783303F3647551
      641C64E94CF0AF63D215F2E4DA1134C3DA95789ED1F11F769710E1A0C22A385B
      FB971FD065D9350F3B5C6AE550BE4E74CC53A8DEDF7A4532561A4703942424B5
      0D0B201F45DDFA2A46F0B9BA8A477BD7D5557C337AE6EA8D8DD36F0F0AE65F48
      7C8CF673514A169B1C5B66B51D5D9C31F82E9A00174762024187E45CA815CEC1
      32DF8AEE9927BD775D8882C9D226086572EC28E2EC6041B3A35DE0EEE8E2EC41
      DF777F3452CDC2EE8E736C62EFD4883A1FB79AC51804A7D128F1F645306E8B3C
      09EA1F969604F61F50C4585290525E8D5ABB53B95883D88FA084F70A71DE12F1
      F150E1DF796615E3E87D712DB19E8BB7E71F5BDC2D1679DA9E3A716BD8495166
      A256A62EE6A6AA2EE3BCCA625236DCDC05AC111470F8BDFA53D6D1F1E9C5A50D
      C380854485177C4F25C25B1A3F34F9AE56ECE9CD878FEF5DB854E39528E89CEF
      8EE31AD52C3413D6ED59B923174B72AE00945C1D6127F5B7D28D58F67DA94EEC
      E35F410AB11A5552AA00680CE75311D9E8091C2657D46975B3AE31ABE0E92B20
      FB49E947FB0E3F6EB9365AA3B62C321660D9DCB5B03756745E0E96D7223B6894
      1F085916250870831B137A59EF8C69565967DB163AED77ECEA3088EA5E394F56
      A34E6A36A3A69226CE4989F0AF49AFD19578492F60964A0F17939F7C51E4CD63
      9E2CA82351F1B0B69B4CF7084571296FB7EA756E7F46F7D13E99D8C792EEC3C2
      BCFAAD47BDE811CAD2229C21A269B2D50351D547A2A6F648E50D3A27ACB881A2
      AC486CE459DD31FBEF9155B561791C581583AAE0B3AF6FABFCF1A82DAEF048B2
      A15DD97287098A085434C53D32C13D3BCB625F186BE5549F216931AC361B0F60
      0D2CE83AE81D2AC7144D9DB432500A2CE051311419802E1863968BC690BC42C6
      3D1A8C74B412942A75D3B0B3F96AF805BCBACF4BB3287B4B6814323F7C0B8A38
      80ED87A81AEB21AEAB2B2CF5E738E4BC09E9027302AC0E07AE40C9C230D84862
      FB2831233E31121CD3663D6CD583F498EA6AC8447E20F613BBD243D52795BE67
      53D4CFAE98EFB71D3C7B6B62EA2B68A0E1B597B3192D7DD3947A205B82CFB6EA
      C4F2F635517865DBDFF31BF76EDAAFF557D03973CDBA408A35797CCEB7FDDBFE
      7D5BD4C66CF8F861A3257BFBED1B6A2E7DCC279BC2C7F8141FB65E6BFFCDE942
      6B6BF6863B8B944AC81529E92AD1412C1788EE873398B2F2A79E944BFBC2E26A
      495C09B89C603DC786F6BA5BCC3284515624B7DD653B62F3E383C34195219CF4
      8BE7C53A4CD7A7B92EE4C312DCA88B49C2C88E24C5B6427A45D908166E780208
      2A5E5340C62793148A8F6A8135715A044473B6A90522B4C8CAB0984E711CC2B2
      5AD9224F125B7C5C1EED37F1E32018E4629C69DD241C7D5B9D9F4D7729B99696
      501B72A3118F830086AF462CABB4CB84E8657784E4D2F4545E7247541ABEBA08
      6443F187D8A5B28FC9EE375A14B9EB293407EF62DD683AFCB609FA0F9790BF36
      1D7F55327EDB84159CDCA2C93E6D85EB180575C7EE0D000AB31C2F5D73DDDE59
      2155D4787B73E513BD8B240F92B8B89F5DF76576F7A24EE22912E79278BA34FB
      0359D61504EA9CD925213576411EE48AC19B308098B17311B302D80505657D83
      4795D4F3C18F369FF763F03BE775F4F2C5AA913C742932C449C07A065467F513
      7C993FAC893497F4C551B390729A474F20CCCB17C2BFBE47578757773936AD24
      AB09E36D5038F3BD0B8A6398A5EAA73EC5BF8928674B01AFE00B70361A9BCE72
      6FBD3B2721C92CD3A2EC52830A9B5502B3FDA87BC98F1C5E012170E45B50C50E
      769B435821798D9F16E3B1988BF840E1AD623C6E1519124C4B02D496EA27AC02
      B904DB647523CFF20583FAB9E41F2C293D0E07E4E7FECE4AE90A0F21A2A0F7AB
      662948AB0D279437965FED3AA286D497F6C5A55CE54C093819E35F5810AC482F
      76BEA4D87F09D2421A151E74FE8C070FFE859F64955B1A24E3A2444D62ACDAAB
      346117D3AAD7EC7D007B2B070E4B1C252708E9072F25CF6BCF04F666B6FA76C3
      CD422447A6A4050954B30C6037F2C33BEE5B1DE73FA3854BB8CF5C299D634CBA
      11E6D1ADE6378FA162423B87F5254B8D47B8E970CC0B52527CA77028AA123B56
      A05FF6ABBDF6DB2046BA2A7EEBF882A26C6CE871A5B0BEB7C3B3B51E6452A65F
      8D9F114C83967BEBB66A6B5A5156594F7156391AB49CF2073FDBD9EEC9E4AD02
      B02A049434B6C94E8869E90A19DC28EF4F2BC51ADAAB4975DE310B357FCC2852
      C66083C669C6AA1FCBCA0DE6CA09801F1CB0ECFC1E580234C17A45D574598055
      D40DEA07A2DE290F2ABF2C1377A2D80F54592819EDBC8A76B176309B3D706D82
      FFC002C53CC9C9B6FBAEB00F363FFC81FE6BA51978CDABDE5F02055AA918D030
      4B20324766A12E2C83723ADE582D8F90062F834426000EF785AC5D59944E6D9C
      8C6AB77E35AE163C1FB5F54496504314C2F2943807D6869CE6B84849640D4D2C
      13FD5AD4362FF2DD51424B7AF1FCEE9BD198E180BF691B8F5E09B04CC147E380
      2DEDD4CA75164C89C323BC411C1AAFA0442FF48252B6D276A8248C4D6AD76ACE
      727FED3E8978C3BC9CC106966BC1864C92F3BCCC1602484772A5A12E9CD6C6FE
      12240DD27D405B3209B00335E98CA7A1863AFAD1B1965A5FC4A87835B571A976
      C3EB4E4CD80D4CA081F1E4119AF610A763C22E719980793129F442126C06EA08
      26A270E72E14100C349E5FDE6ED8A33D49CA6150D047C4D32E2E8EFCF71BE63B
      091766E1EE060FDDD4860F61E87D89D631A08E476D022F0718F2F902861C18D6
      DC09B21879A2A944A0E8622E2CC06E107DD5E7F6BCAA20E21FED1F492B8C6592
      0C8A9656DB57ECB889382E4C47888A9B676077B5382C8E6062B492A486592BF1
      D0B517B83EDA2DEB12E65561017ACEA64C07F21E386C5B48A4410BF3717F103F
      8DDE2EAB99B8D475747C2C2412F3A0F04F71CB2110E12D1382BF413D6EF9210C
      88D717FBE5F06A3D574C3341E3D1A86A1CCE974717CF44D01340B25409ABA26B
      A4CEC4CD6F1AF20A4C1EDA55A8BCC76344A5B4CFC531424A92FB025FC91EBC0E
      9B916393471C0B6768896DAD8AABE415D11EE539273044F2AD2EE3E86BC19C0F
      6182C460B88A00A778AF8DCBBF2EA2F745965657F6FEDFEFA85E66B3962DD2B7
      2BF0988B9912629A32777780269884A19B6C7D76817E2F307A026F1D87892575
      009614530F1B09D18BAFA9504AF48C455E0A230BA00746FB65121DE2B8BD83BB
      7A55A63969351728EBF65A8484565EA89ABBF5F104A56FB95B3BE828B291498E
      9447369EB73125B26307600BAD09B73BCE462C249729E5FDC7D0669527AB3212
      9D5C3248700FB74924522BD5CE8C14DB124E1EEFCFD5E79F4A116AF0A871D6A9
      32103B26C0AE52F1F1C9DB249B458F95701A3D8EDE25DFE6D55931C2BFDFA4F5
      DBF9207A6C449AE8B1E3073F5632EC6325D8BAD7BB3735FAC91FA61E486DA367
      FD673C4BD0F49EA8F2C04208AB5E5B8E80659213A9411597EEA04C6254F599D7
      C56E99088AC96A3CD3A4C457B7140B7F41BD7F5FC6DD74C51A9ACE1F8EDE9F22
      E7F3ECFCF0E8343A3E393D8ADEED9F1D2921F561A51C6AD8D3921F36F3A892AB
      AA27BC05C9A4F7075BE354C3105348E4413B065ED663D3209B16B0EB4C806C54
      B882C6AE1EF583B67D9A4CC0E7646566DCFB0CA3CC677271EE098153C890BC61
      1C87E28173F3C971B93C38FE88B71440CE8712049FED1C1774943ECE3ABF972E
      4047EA27E212A83A015FA45D5DF2EFE7E7EF0367FB611743597C49F2C0BEB112
      24548952C7B09D713449C50A35A6B006E31FB4634A3438B93C6B482590C20009
      E256FAFC03D35DA5A2E565314B871DC1BF2856CC6CCB4EF4C6A7C30F1291F5A8
      58F6BC001F21DE5631E196DE682930D593032A774152C18764C8DA213283F7DB
      AECB2959C68AA521935601BBC5EC1863543A6510E538AA31D7D4FF5D02D83D64
      6F6985B8CC7A39C93C0C318C87B0601C58275455C52E84A5E1D27F02F2F2834A
      3E884D4391B364740B7E09071C296E94C19CD7D4A3A11122A12537F2E44D8674
      E58AE9EE56D1924F6B80210FF92666EC9BAAA3E4A4134A2A66947094CA414872
      103EB4DC735EBFEF44E57A1C5EE50A5A8894FFC6E68C5A5262A9AE8C25DC44B3
      6236CF6220BCC0B460F136ECB0B6ABCFAA2A4901720FD7CD8C510007EFC408E0
      ED02B5B6F4AB4685862C19D1F02972B3FF3637EBBD3D89B3472D4ABDA4D7FAF3
      62C7AB31066BDB0CED5E68CD9A85BDAA294F771824D1A04052453E92FB1991F5
      D1FDEDD6BDCDED564FC05A8DE674FC173B9EAAE5DD76AB6E25F005927C34EBCB
      6D35804B6B010C815B9B7023AC19847501E84FCA782A0E691F4BCF0AB4A87006
      95C5C4F8A1CCA222F81DF9DEA0F8E67736EB18C120B2878FE774DDF9EC4A7F4F
      1ACA12861A5EDBA2035D2BD1AB90546CB24DA30556DAD3E7ED5978FA83CCC225
      3D36487CC05BCB5BE26D4B409ECBF38325C97F280AD4722283EED33CECD24BA4
      F53E2A20ECEEE836FE8B97F160A70D0973548B3292A2088B1D5E39ABAA957B20
      AA62601F2018AF0DE3550462E351AB8897DE718AEFBBC37735E9341D219573EC
      1E8BA534826DC5DE2AC18301BA75F0254A1A2651D7AE85A2C4652031BBEB25AD
      085C17E4A305A9E11C76ADD53589D37CF3552106C9EA7DA94C48669F2ED2925B
      130BAB631D6E7B7A197D175D308C7CF9E134FA2E3A56FDD0807789D6563EE5F8
      5950AA08571A2108105CF496FE92243388531124831F6B18805DC8C37959E1A2
      2850246FE1906FB626CBC935180EC95D9AB4B6CCA2D0E7B0EB18DA32C1AB2020
      C8A2F41304B80D2DB7AA327A80DCF608FDDDE64BE03F8A6265FEFD7EF4AF02AF
      51C6C32FD0C37E882580366F4BE5D735B1D78BBEE3CBEF6E7EFB7E3CC1C9D5AE
      E9B8142926155030D8AA41C91ACC6142A6B97F1841B01BEBAE69BD8C2CD8515F
      95C57C22E87187BFA0A692A06106AFDF54359264F05117995816DA6D1DA93B0D
      604E4477390896936D9D12C35E9EA1A8E65AD47EC56F71EF21851943C1C83FE2
      64E3E639C95CB2D5376B2E99EE3CB5D8125FD882E861FB62D1F0914292AFA093
      C461E5417C4AABB33B92F2D85CDC856AD2801BE3D825725E1E42E2A06B7FB56F
      EB8FC32F4B83EB460A7D52F316220D5F3049081AD8E615EE87127E1A1029D9A1
      182F7BB5B4C27586E0B06D575909FA7831B15D7DD4E40ED0B70C657C8D681F6B
      3DC176B74487619115F37263CD0E3EC526DC1D8F7C06E5FFA7096C10C6F3E4F8
      C94780A0647D56FA4D7A0F3CF1A876849CA0B4A103CD1EEF20F8F13BCDAECB39
      681A77B09C9CFE853DE7B1FC7E479E6782FE4A59B2171A90AAE6A8A9F2614390
      28DC439801320AB2254523369F5845DA96CCE76A85847A25D21FA2019C726B47
      4D3C25B6149389A8E842F5AF4A07298AA3083B42BF0F89312B74203F52C303BA
      6696782B8577949622269CBC0823665D8EB9BC93CC9AFB3B0AB3741766625D22
      90C958FBA19B3270330363B68966877EFC10B1B82087D879F3723AB9127DFC5E
      B7F10E8FC31E536E2368DF9781D096369FFCB7E9E46AF7F0FD896CC98D377090
      5AD87C4278F82A1A27854DE8F50C63CED542E947F9C3381E5266B7B2E0DE4FD1
      93BDBDFF632F6BBBDF42C77D47AACDD2692A411CC7A6D521311776105B8D4180
      C52234E432B09D9EE6D07652A383C379558B596577C7DD86B8F3369E0EE6E504
      794F67EDCA6A8B4EA9FB36BF7C9BF48865BE2FF79082DB5CF95FFA14AC500A52
      E39EA4F5D3754C64DE56D1986036C30E525C69BBF499D30283F92F4ECA560FB0
      4C0C8A059129986F591C169C80AD7EB841949789626278D520F6BA84DC660673
      F7AF5C60A36496E4C4C94166902026F7B2276E87A14D51469F24B58F1A33F818
      1A7AE2E2DF21807D716A66E86636AB90A59CE58A36AD34EB32D65A37A01CE06F
      CDCAB016E39EBACB5A73DEABA4F5ECD52770501C36D06916DE89526BB59A5187
      D76F07A8BBDCBAFC9A29B5A7A5D5FB88A631D3FAF933BAB847DFBE7D13D1C47E
      7484AAAAD98D942C5D60B771838994A83F21434D0836379FE19F4FBF7F167530
      A61DD7F1EEDE1E79B18772353DDFFBF185EBB6FBCEF1D19E7EED88528DFA96CA
      5526C9145A4F6B6D7237773E74C4F23D81E8BB9A2CAE6DF821FCABB28BA928AA
      7F948B4BAAE08CD2495A5B82BE7148B117DE9D5F12F6CF447B4525B34608514D
      C1070B9A8EF39B6951AE49C40D88522A98A6349240274DD00B11954F7C35E186
      86BBC0FED3595C73A2BA5A9C94D8A30B4D1360C99D52255E988E27A35EB17F6D
      DD0BF2DABDE8A7E87F739EDC92BB8E4B3A613E52E6AF9925CB79EDF2373ECF2D
      4E2D58B4B729D4B59EA63536F150F6D471106D01704F70D6B18B104AC00FCCB8
      71436B377F73CBAF6CF97D95CC47C562CB5221DACD4CA323B238B527987D175A
      DAA037BA5911B6AEE4C7307B255F422B3968C987AF496398757AC37DBF455ECB
      26476FF0ED90C71AA47B38A12583A0712C9CBF7CB190AEA4091B92B2342E5EBE
      B843BE5220A4C8C1C09049392A977ED3F759DF8262689E8ABEA441E70B9539E5
      4AE1645F70FBDE5CA4DF28C2E2148B6F1416098A37D92C33FCB37A7F2C0E38BA
      E0ED5009E5E9412F7A657271E737C8B4F2117ECB6D824727E452565189EB651D
      478BD3F99038AAD46B180A25B011FA96989784CE57BEC4EB394A214D72D00BE3
      BC8EE229B39A203503D28520778CF28E950C5C52E84AB35044142DC895E25C30
      17DFF223E31CB93FD74EB1BB63890BBE4ED6AD79742B96BB5B142384330EA496
      C1AA376DFE20A434EB5D2A473AE3B2234D33948FB848041091A8AD898E31ABC9
      65CD9489826C72351D7C387086B2E48822968B24294D9A53159995D3F321198B
      33205A03229E56683752E87C691107E0686552A19C1B5AC5F58601CEA3EFF7F6
      DA6925B4A428E83D6EECA83AE6DEF3BF7DAA926CEB4138933F004B411C6776CE
      8D786BB865A05C417849914095167CDED32ADE9E8489D75E7D8E54EBA7D7748F
      1A208A74C410E85FFF0B27EFAFFFCDCD660AB9B033430344606A591F904A93B8
      26CECF5AA2B06314BC49F3790DC305D593C8B4D7DDA398B79991B6F5999366BC
      4359818D57C8379E897085BA5241DE34EE97C958BE82212744295197204B29CD
      454AFFD75F6D40B8BF925F7FEDC82E8887AC442B68031F26D2EF94C5914A065C
      F6761665C564C37E2B8E789BB9C1D49D4D0D8EC322AFD9EFE8AF21395A658358
      1C9EADAE3937FC7398BDFE572DC3C48B251C6CEF40CAAC93B28F0FF54EDAAC0D
      4AEA5B1B7C44D8869E4AB667CB64BCD26FDC3D78F5EB7F616A7EFDEFE8AF3247
      7ACD1086F30FDE5C1206EA22BB386A24B3D07AC2E476B5398BF1ED9B71DD2AD0
      CC3317B1E0F37C46D0ED9B5CCB4C680C499D23579B2AD44591CECB4DA5D153C0
      4274277D62B20B9C1CBCFF08D82309780B41B25B7075E27C0647192E18BB0157
      6CD1595A959D1F5C0EA2A6CB6BE3E0C3C1B3A7771944F981DE3DE18DE34438B9
      4BD5AB03B863F754B061376E447D44673DDBE3754642DE1E4FF95BB9579B0FD4
      0909D6C9C833F7C94C2D46C90CFFB181F9AB6599D4A1B300A4B328C554E7C9A8
      0EBC69A179F36EFFDDC549D4852507354F2C362A1CC7C31AF8BB7E5F978AC645
      D4E60993935DA7BB800684AA265530DDC364A94A37D894D84F3B186A628428C7
      D15083E7FE31198F911002895EB2627690A1410A9FDCF9C178888B92A2C2B2D7
      0D824BC257763D56EC458FECE6DF7441412020D36F6CE06C07E41280378C71DC
      DE881CB34671E2575DA28CB19A35806442A652E69709AC3A3FEBC556ACACA4E4
      295A04C8A593C20CCFEC2ED49EA1941AF62FEC01BED9A320E138CD05A023A060
      9174BE985D7E4B07F1FCE20EF407BE9CBDEEFA2C3CCA797970706194581A3C99
      C4B02199492B1DDC0EB37D233BC83D9BFA8C10F6286D650B00C6C38A5A913D4F
      F6A3920AE0F41E0BECB1B2645B4F92E9BBC63F31F78BCCE6ED0AD253FF7956A2
      F91ACAF398969B99C923D2AA872E9B1F2FF74A34DA5953D4974795AB129A1A1A
      80171B4CC6A2595C33D894B6D629BF8112A54474FC9C11ED421841820E4B57F7
      1D41759C154BA668B1ABAEC467DFFEA6EAA342FED3B78010BB3D78BB7E5D86EA
      939B75AD358ABA487435D8FE12794FE23D40C1450AA90F8C2D3A1F64E957263A
      9AB3FF4CB6B6FD278921C9241688B2D10F9102AFC298B1AF9908A54CEBA0097C
      B77D69E942B06A721050340D9264B4341F6673D21B72201D120BF1A313751B0A
      9EE673B42AB8DE79F6BCEAB8FB9B2407C02920E4B2749A5B274FFB18085CB460
      C470FDB8F3F0C9D3EF9F465D1E95BBD129CA7947273B4DE581206D5DB2367787
      B35DBDB35FFDC59EF493E608061F807A29C497793DFE819BDA372CD62053DA6F
      5535690844B9A2D56B3500DB878B6836B48741A72CAEA28F97C73FF41BC9D30A
      74379B24B2D6B667FC7395CA414AB4AE10421878BA3886B9154A718370DD4A79
      DC00215B3C49F87AA6DBD7E02138534E85F5087FCF60CDEB36C5B20CF5FD9AEB
      75F3CBF1541B5A792F063BAF8BC57D7124207B918D640B8621CC46D7E51DB19B
      27395E7DBB4B322EE3413A8C76B1E65F6CF504F8B598E05D4EEA768FF85732BC
      923EEC6DF580510C512E79C2D3AD9E90E493EC9E8F18A3D8EF3D1F019FF35E4F
      9824E514E26DF7784299245FE401CFB67AC0D53C9FA030417E9F194DEB384BEF
      F722FF8C67F17D57665E94D7C9E49E1D994952F73D4603A7EB7C329797D9BA1F
      E5BCAADCAB3CD9EA11D5ECDE3BADBA4E46F77C443D2FBFB8473C5F7BBC5E1CFD
      0107E98A0364499FCCAC53650217E0F9433ABAB48F2B2E3291A8239348AF6866
      3C0562060DF98BF5C9238DD24FB084553882CFA6832BE968AE892E85674AB33D
      240EE164E2CCB7154DA141F135D901CA4CCEA2140A692B74B0560A90A92AEA7C
      945A50E19F5FB94AAF2150C5E22FC0DBD62A7489C9E43511F382FCB100101159
      34B85A8B7D330B73C6328D52520F1C1A2DDB4EAB29FA65383343EC3320FB5050
      44285552F35B98964AF4485703D9E133577D4F97FA5F61C0AEFADE17D0CF8AFC
      AF2F5EBC78B10EE5F3AC50BAE6223087E41667244BE9060F6309F706CF8E5294
      4A122A03B37B98AB4B166D0C347EBDA29A6FDD5BA124C20A990446AA149E1673
      3EB0D8D3AA299B664B76733351E5DCDD2FD7A35796F0A366762046D73992A9E9
      44DDCE51DE11F9133B6A481DF6BB764C672AB4FDDD202C1193352F277BF5177B
      C44FD0FF21D0CB4D5DD564B0B46AC7885CED755A931D1B3A0F8125EE8AD63754
      83E8A88996007E4A97390034DDAFDDFEFF0BBC8F9FFA699E2A94E1FE929A2DCE
      B237E386C36DCC8A6AE13B7476294A4AB7E60E967FDB1DD990FEB3C8BB5E8AE0
      4ABE69AB09238F1807D54F74A5E32FFCAA520A3A075A43E6CFCB111210F6D66E
      9B719C65201B2FEF118EAEB9D653B3DE10B6D7752B1E6697D7F3F1F9F39E17E9
      D12F6000E828EA644859C5E41BB501F4105A2D73C2785F386CE28B0AF0B0E8C9
      13F4669EA446BA31122A30A5F11AC2D3F40E8D11187A87FE480F02A1FE54350C
      B94FF965F5FBFE53F76CF03D097EB26185018CCB1547983694BAC29E74BD1A25
      157389ED5D57D349962F1F2DAD058C23D898BC98F41C9417D65CF86878056523
      12387812B7601D982AC26A7017BA6F34A0DB2D8A39DE6B91AECAE05C02EBAD5C
      3C8BDF6F4629C200C59201C552588E3CB8126E75336136EA2A34B4EC4803F326
      C4AB168EE31DCEAC2030CA6D9415D6F35DA68984585ACBAE0CA25A94D9C2F7D0
      4118535E7097F587DD8CD823C204AE5BA74923CA5EF2DD0B506759F4E7BCA8FF
      6C4A600D6BB0B5841A8581BA18615C620162B861B86589B9D978B4AD655D9A93
      AC18F04C0E0E8B2EDE62E62AA2009D5B7EA9ED84BA6EC359880E223D6F38DB65
      D3E1E78D9BD78BA26F0726EE0E674D1A1BDE16C73675708C97C84C959EEF0EED
      74126BCAB5C59283E1C4801905A579B822D6CCE0A5A2B983B80241E7263C70C3
      B372CDB92B4FE98969EB4B01CB8AA5725D13B693233728D81C1CB7AB998384AD
      A16998DDA89040E346B96DD9A87A40E37AA115696B817BE32FC3D9AB6FDFBE7D
      FB89A91CAA712DC785BC94247C7417B9E93ED79123D18FF01897136ECB21BF69
      1BCEB22C7A321EF003FBC1D6E778538789BCACE74607A6398EC32F4B24C2BE57
      E913F0027B3F3EDBFBE92EE691CBC6586B61B4D337A23C89CB5BE80474D23413
      73A994A8EEF6A5C1FCD5AE913889F6C35706A5ACFF898604ECFEB070F12B8931
      2C0419D63F70C97A6B3EF5897FEAC14D9966593ADCE0B10C0F2C3CEEC5F77B7B
      4FA2EEC7CBE3DD1FD6EB692EB1008C76E7C6DEA980B5395C593159ED9CEEEDBD
      DADBFB1C2AA383269594AFA25FD490D249E95F5C7E3879F7E6E2B3BEDABD4647
      85451A461C2DDB842611D42A1E793A80446A8ABA8DCDB4DFC51F43CEFABBA5D3
      5197B68035BE73D739718135DC56CDF7086AAFA77C11A7502821421FBADB686E
      9E2F9F9BE0C44DAAE96754E172492D5D727B5EEDFF78FCC3B3D7C7C73B0FD5C6
      830DE15D1ABDA005A7BCB23554BFC5A9C131FA8F7FFCE31F3F35D26371F406D7
      C0BD27E9C9D3E5EF7230B3D2B6974955F7936A76CB2072F6DE4A6ED4A1EFD8EA
      315D95ACEB7365AE3650A9C595902DFEC43378CBC4CA0404444CF6BC1A96C847
      95AC498BAD826623A950D394AC760CA423D084617B2DDD60DAD9AD88E76AA192
      E070907A0BA806059FD762FCEF3E856FD5869478E70B98499EDF9A6401958E85
      D29E7AD4CFBD3FE184F867D97C92E655BFFE566FF438C3DB7CE163F548D35C04
      9F83AC162EDBA001C9C40CDE504A99B47F2726AA64B13A38AD8847FCCD461D0D
      5EB9D7AA4C2B5571F1C766064D2310CE9AB612FE563937C9C1D1A2B955522BCA
      22BC71A4C9695D885090FE0E0BB80DC8AEC2F09FF409DF87D4F18D7FFB547E6B
      1AE2D514EA7A17471BFFFE99FCFE7C3C4E87F0FD0F4F0FF0CA57713982FD64AF
      B31BCEC0C60F7FDE7CB1FFFCF4C17AC86BFDD387468CE479F4E9C3C68FFE5E1E
      7D400FA3C8A3836C8E38AD2ED387E9FE0B696341C87CE307BC94072C13365F69
      1F9F8C8DFA1A10A2835D28CABE9287185068C4A3D61B183B5136364BAEC13963
      8849B5E944A0BFCDBF51EDC0C0B693D5EF7F167079A4192434288186F4C66AF9
      EB2A3B648668153B4717D525B1E2FB83AC187EB98BA0DCB571709D431E8DA872
      B9D6F958F8819470B71C56871CE8F7E0C1368FB4D825710063665577F7379D3A
      689783162B95107A5167A8B5E6FBFD3E5F5C5438AB749A42C0CF9522AB766E11
      64D7FB6F0309375C7F824CC45E87511683CE1194BA5DC1BE8565B149D905A987
      8ABA2BAAC58EBBEC5CD272554C55D0521404D6EA0CC692F6624F41919A9D9EDB
      693D9F1DD9B57AE6BA79777A6259684B42410EA74648369AD4FB1E9966DFD69E
      DBC6F40C138921DFCFB2B2AE080DC24EAC0E4220828EEA266565648DEA7D65B7
      8A950227D78FCE12FFFC3FFF0347EB4BB2ABC8DBFFFC8F78B23178D4045213C8
      C6ADBD2EFDBAB55792ED671B5B9FD34C490F92DDF9779A43ED9561F15576F797
      FEE7501FF2977F7C5E1D9083223C2F658B1053B054F33E88018D240146B2B35B
      BDBC93CADD415D66DFA936195E4EDE886C5A89CBAAF48E1E680CBD2E291548B4
      469473F9C6E73FAFAFBCEC4E8FCE417BC7F75890069127877A0827DCF6635015
      D2907F1F6F90DC07C1E88F2ECE1EBB4DA29C6709AD23A0BED65AD9A0A361A92B
      7F5E3213610A89C945F0705519223A1371163D527DFA22E71EF57252483BC482
      A5C8193A3592191D62461FADC4F1C2E2355B3E7F41DD5F63B792B68A42606BC4
      0F698B7ABD7D2B95C2D62CE27D9564A36884DD83F61B2B56B6A788637BC74F8E
      8E1EFE57049AC5ABE82243B3AA6FB264474349EE9D818CDD4151E99819CCAEBC
      40328AFA93AB02198AEBF35FF49B1E11321B1B74D61BC13BBB1AD2D3631A197F
      921349FE26C3D6A673A0C9222EDF501FEF13E2D7184CB1126AB5015229822E0A
      875E9675F831201FAA0AAC3E548FE43D4CB40E9D9463419EF8F1C4BB4F14EBDC
      E00D5696A60FAFFD828CEFB362A41ADD9BE526E997619645E3446A7969BAB4AE
      74A75AAB949C0257763AD55027BE3629E8706BF24F5D6360F1497877CFE26AB5
      FB46D3D0EA59D6050A754A50E52A9E6782F82FBC5BCF5B4F9AFAADAFD0A81423
      80B0D09764C0301148EA9868555766EE6810A2C7DBDB72C8A6711E33E0E5DA5E
      5351C9BE2723AA8CE91A3D9141E4D85A96501736F03558A3F964C7E153BCD49C
      ACB81A192A82E7946CB9BE48B830ABC4656485F54271373362E1528B68BAEF50
      99F74A89549AD25105CFE05EF349526047A7C374465D65C6F544BB0B9A2772A2
      88D9D812A4756A263819D59C43191FC163AE04D79FCF361D520655A4649E3148
      74F03CAD444DC7A24C27292E1275606430D7345425C8A454860F8D1A44B9AD18
      792020A0E53799CAAC7556E52841FA75EB5D75E20637C1F29564501C003016A7
      B3FA66A924BA667E43F85F8C7494A2A4849F6AFDBABE75FAC1DD62D972A69841
      4108B755E0E661A74C0BA1108124C53C1FC21B5690E2C9DEDE23AEC329F4B1B5
      2C8CF1F19D79E4C7868BD2D5CAB37A4C02A0C575D8A0AB7B11162759F562A246
      147F814F5BCB212385C4E97516AA1EDC42987A4EED5ABC2E588C3A51CC8197F2
      A9CD09965B738C65032127E8005B193DF4DF4F1F1490889F63E3E0E469CDF9E6
      8130754E65797B9344EE8CB58619B14A0FE6D26A277A68E79C5536BAB5091784
      D161F69F4A6907753AD5FBD647D115587812C60E97C11497590178AC72A7F15A
      CFCAB7EBF812DE25ED4555E10AE48D52D5189272134A4819A55FD311CC86C624
      A9DB9A520772BD0236DC0E46AF752D069E1B95EF018C247105FD33D6868E7D12
      A835BBEE8091B44B42065ACE2EC86637972614AEDF7C291D514FE7F1A1680EF0
      C11F126E083726EB63F88BA5531BB28E9C602B4D0AC92B6D0CCC14A99BEDDAEA
      853770EC2B27E2DD4BF68BAF9F8553A6C8BC98456ECDB64198BB2A740BF6175E
      E19BA116509C1250B8B06320B09764743E9EACA7C851CA43880EDEDF7EEAA0B6
      065EB7345BDD3114C3FA809D836697FAFD7EA7519FB26E4D285590B1C4F808FA
      BD67810AC192EBC7B43755628AEEB134DA3A5586455EE915A21113F30843F55A
      878921B96906C3D219CAEE4930918AD5424E82CB41A104832A55F58A8272329A
      F0EE945A45EBAC0665A1AAA3674E9CC62CA6AE1A07DF613ACCF8629ADFF2BDD0
      2C1CFC756167C4AB67A51718490CE0F9924BB023DA53E344599B5B3010459589
      7193CE19E23211D3C260CF85A31ADC2EDB7D0EF8A15D8A4CF37430AF1D6BC5D7
      34D33BC0C48DD9290A5B70C3D8F12CF88927A5E883BD0295CFB3030019ACA27E
      B44F7307D7710A1DBD4903DE70ABA7B9F42CD334AC6DB16445B9EF09A77EF3C3
      A3F59C750BB3DDACAFC26DBCBBC6B0B002769078B8D135029BA185400ADF3F5C
      4427398AC16D0438EA334492733EC33141F0A1BD26A3EFA20311FCFF880A80FA
      EF43180FAB9A39F870D0EA27752C8D0316347271958EEBEFA4E746638E0D2F17
      155D394A7894D1E8D32FA763895EC8283A7B964D133858FA98B5DE4013FB035A
      F8E1C05E6594C0C06A0EFA213F5B8740847116F6705109D7862708AD041A5F3E
      ADA4218822F811359783D1A8A4919EE4D85EA7EA3AFAD108429E12D4BC8E914C
      610A43ABE18E7878D5A49778351B208E5B6AED3A147097C9C5B6D821BB19E834
      8B1D02174F7133EDB10B1FB8CD28A81959705BEA0148E4663732924453E78C55
      AB38080D677DBBB62E8A79394496DF7EFB0C6E372637B243033C7CD0E44C6A8C
      430641BD5151990FC63618577D59619F06246036ADBDB39E2C3FB0367DD5E3A2
      1C487F76B131C27773914301CE425425CDEF3193220D1A9D9E4B9300E2F4D583
      BD16EEA75080D78FA906551D4D7A613C5A76A44B8AB1710EA07861C0334476CB
      7679F914EFF4F269F84E493E8AAB2BBE9316EEDE6D730B9A92800E789C029B2B
      6117C559D6DFAAC5348F5E230A8B5A9F5883455E25C37923F2A96B10F609420F
      54948FE557FD683FBF7111151725635CB73DE84A6387936D2B43FDDEC527D17C
      B8F54926A377CB83282DE84C7157104B1EE51483597FF946C677BDE58F13D08E
      04290CC0FB82E69BDA37C248713708E59979BD81160DC85FC5B5F955B7AF59BA
      74B5D8A68E5B133C832407140E4923B3F199A420B4C48CABB5D7ADD99634FF28
      32C42985179C94DB1DEEEF1B76EE3BB573956DE3EC0277F90A54A6995FA12843
      78BAB7FFA60FE9421BB1F2C87A2BEAB8698FD95177F113E76294EDC676BF3647
      BDA2D90D910F91965093394B678382F53E9CFDCFB386E6B09E1FFADD77A49AAD
      2BDDB4D4525E34791988EC2D73049C408B0FD22E3803B719A7418D1688F24BEA
      CFB418B168A466B0360EC3C0FADF405F93AF66E848D0287CDE36A01178BC4EE6
      B2119DADCB7432616CDE1C833CB906B8474BCB3D9CB64B53AD5374D19685D157
      780BAD61580934B4BFCBF16E51D61A390FDE285C9262E61EB681CC1837B725B6
      059E1FF0CED03875C3A331E8B5079E903884752F24464BCA300247CE7C96AB24
      5BEDE29C03605E1820AFE27BEBD8C877247185B66053447F9D3FA4E00EADA3E5
      CDAB9CF6209130184CF5DBCC714D61D5489F68D834E4DA971A322B213E0D4C6D
      0464EDC382C21EAA3C0482D9F5B30A3709385DD46164EA1624A9C5D25F56AA7E
      BDC2E202FB48056EA5F0CDEDF8B41A6518582B6EA7F782B708EDE8E482681F82
      F06A44BBB011E46B02FA7749D5CE92DF670AC4770CFAF4BBCF4203AFF0036F3B
      C80149B991C13C7AB9EC941063966EF19220F6ED434A4AAA79EB0F339A79D411
      A22BBDE634FF63473584E4169679FB1A5E77F18631C3FACA72FDF242F080D211
      C54268EEE0C3C10657AC0AD42D59016E585CF782A88A75F09686D1E77075ACC7
      83373174AE8A828D89B1D188F18828B6D69BD23E115571068103558CDE15B224
      EE46B6C08BCB3825A3B5AAB5ADEF375717AE5404D8AF0388D06327FE4A71A365
      80435C2D3EB9FB6DE70ED2BF73C844B49FD1D99C3975CB0304B1A3F6F1AE3F29
      7C26E12FDF3EDB4BACA6517DDF8F0E146393F0129D264B44E7952B0A211574F1
      6425E7D1D3F53CB6DBFBC6EBC3A5DDF87968A9D92F8DCD4830666134C243E616
      9BB4E728108D9BCD1AA50F8A379764C620E6100F367859A1712B76BFF89214E9
      D5C29186AA2E790D2A4F9366021FD659D3564D73599464E9283149579CF9BB14
      5EB05C1E2145FF62CADA9FBD0FE207ACB36E470A7D71D92FFD6C755DE475D5A5
      D008FD043CEC8DC9D7961E4C26853995DC4050C45F9C06144EE9A33C6899D4F3
      52D2C024BD18F670E592989C1D1457D1A88C272E575F768CCB026A14F053FB49
      4518932C730B9E8F2A51892F5C7E760DCA5D472685562F341EE8AC2C0619CA87
      394FC606780DE6CEEA1D9C262FA2BE6ABEDAE0390746CD15D56427BD64C5CC93
      D41630230D19954A745F93CC51706D41E86D67BC0078F1A1FC3BAF3F63E9DF65
      B1DB11E7C4A04C6E6ABD788C813B4E52010572844E600FB3B25D18A0C679C4AF
      494E9B15225CD5E05B25C84AB486D8C87EA6F11A473952AE9B9C17307D2C745F
      11D04A45C9DAF5CD0304ECCCBA1AB96A050DE34A2FFE90C114E868B95C179064
      24B8652C2DF7451154D3FA8C4216313925C168EF70B392A22D04154530D6C5F1
      96CB3C845433355F687605CF97122DC67C6BB0B844DE2CE0DBEB1755476C3A2B
      4A68C73AFEEB752C5E2514578CA508441AC4761A4E2CCF244E377E44693565F6
      D9F1821804829BC9B4286FACF4DC32B5D4E610EC72C80EF946284751B5CA6681
      1E5958CA59D7FDEBAF2AA4CCE87D2F729F8FB261D58B0E0EAA9D060C8DA43101
      5C97F4EF4EDD7B152331AD374006616F882CD9A0C38E15D7400537E88280CF0C
      10A33EA24A2DFBD75A6E28AF2AD07901C4E1632E457CDEA679DD89CA84FA6595
      3FA43B34E4F05E1DB5EDD61A15CB1E8CA5A25675AB9C6F17754A5DAD17E6805A
      1567859881A1CEF569C650A5EEAD582C4FF6ACBA4D1447905F29503714D5ADDC
      CE1647659ECB6F92A8596C147647E517A9B6A4701BF86AC5B5F29981C9F84DA7
      DF5C1DD736749ECC1074CAB33A654B808F460A789BC1B4F9737FF90732677C13
      489BB55A75CAC87EF2BD15ECD11D9CA2A24285F5851AB1B040912643770EFDCB
      8BE25F89FBB11BE13B5E54F0A0C490B4F08E2F3F5BE48B254A176EFA4EEB31DD
      D74536DAB1DF767411B563E35D5D4C424729E76B94FD6ECDB7D023D178AD1A5E
      98DEFE4E9AFCAC345746638CAB8A6018FA7E879AA58AE3A579D3A2DA38716999
      39266A7978BF181B467891BB225AA8C29178A313D0DE9112E714DD253EBCD38B
      8EB322064F1879711C00AACACB0752679777AD7B96101999C6A1C26CEBF25F70
      7CD8D25ED639D5B1170D1A84A1A35159CC848E829D4C46F2AC606A419C5910B5
      9BD0ADA131A3D54F039BFC6A3E418244D719940CDE09B7399EE4693D1F253B70
      8C601FDC610E656518CE8876D7F91F4B7E127555E47370B374869BD42FDA8381
      E0FF8ECE39724EAA48B2D8A0E521A418DA14833289BF28B3D24ADED2663B1673
      382E7D7500B839772B21442BA24E56D2A2F63903BE6011CC1063B45B1E843C25
      34E6875769B2EE04EE48175AD4715757FCB4A892B2EA84DE99A40E02BE58F9D3
      4A526E4D8EAE91ADF0CBB0B6AFA1814A5C51FFC71356241CC6D9657146FBE4EF
      695ED92F7A91FF353E0FFF5B9EB616B17DD6EC3B01CDA05E73E818D96DC63011
      4E4FEEABC507445DE716F972833B81934503A5525D8C20FAA289062ED7C2FDA0
      671A8DB45BA5A060B309DEFE8DC2DFB6C835E2AFD626A6C75DF6AA5713125229
      44E155E3F417C5BC1EA22EBA3181F262744B15C876F372DAC94D2985812C8745
      9EE1F438ACD2058AA23C422494A7A96789341D4A9FEB625F906C8AA0A4C4A88C
      BD4FE6764BF0522A2CA33A665234C3A786E89718E4C8921859152A4D84216A94
      8CE0AFA4FB4675471E88BA046EE610AE33F956E79FF1D96BF6A56ADBF8D9D379
      EBDDCA344EABA8330645861A7E9DA8AB721C6EEBAAB02FF29682E2D4E615E9DC
      D831E6A6D278BE0510F3BA17CCBDA38B6A6132484D06430D0961D7698B1CFB0C
      795B78288929555CEA723EACE790F93233B64BC44B736EC202CC0430C58FF214
      5F6DD76AA0B6167A2C9348363D4DDDAA2E0ADE194CB698E39C33702DBAF46957
      2008CC111F4684C9EC66C39C298AA6BB79D99C406A3216D56F5A50D2D9C6B4D2
      985ABF14F4BC0956E881AE507A0FC937708730D241F280781A728272064E9378
      5C7564363A7F9BE38EE457ECF8148C4CCE9506BC6120F2DA93B5F3FA267A1D57
      C9074E5447A9CC74CB06C537AF48CCE3CCE2E501C22A288CAB4D33A0C0A1C760
      BB7F15056915F43E383A3DC50C22CFCF6A0ECB577736D95CADCE7952782FFAAE
      17EDCA38FD1942C6553B294F5199A823F022608B4ECFFDD7BB224F6C984FF2AF
      30245C64A8B33EB95672588282AA76EC5B39715904E6225A94D7F698E596043B
      D534611909B2BC118D29518F2736228C9667B4347C9D2EC772213D875F5427D4
      555C1BB9765B4C1502473EC22C2DDEC5538A87578A256F5852310C1EBA413432
      C3EA4CDC2A81016030DF20E10D0804C51E18671B6A828412DE56B67AC99BB804
      53AD61E814B10637D2CF3560AFB15AC17E24E30E91858E6BAA4398D0D2B5A590
      56CF438C316AA554570205399CD9C0D93013506EF41084515CBF2AE47210E4BB
      2ED3E117547BAB4478C2F919B82C0BAA738ABB5727A896686D42AC787D72E9B9
      ECEF65A3E8A6D94A122FD617F727A77BC4E379EE1F67678C7F3B411F164DC58D
      70F803D51B17E94A4BE45CDE7B576F12EB91216BA9D93D97B4DCF1CAEADDA619
      1F4B0970A892410D99560EA2242E0C2AF5ED115688073C5B91972F8A2F7777BB
      3B7AAD408AA662A1874EA06AB7328CB458FE92A0AC1CACE33281A769E9E3612B
      C1F167EDF4A3D79ACA6D89B9BCFF0B021367FB179751351FB89975A86F607C68
      9C92CFA5DB0B1D4AABB8E618ACA24A2E57380F3708B84ADC4255EE8CF131CFA5
      5E1770164C0FD7106ED044EC1BD07BD33CCA99D3B9C3F19F258514BA2535CA09
      33A0344732335B25CE4D9B4AFC7EAD028739757533C3AAA01B94EFF4A7BBAF25
      6D560F2C5905E1CD18AB8BC66C588697AC72CDD18F47C8E8D48C30F05FAC7C41
      1275F647237D40182BBC236B6459A39CF0A4DD2E89B695283158754A978AAF96
      8754E273B683CBCFB207E5D16FF3A472057EDDABD0F4DAEC65565B4C2454F878
      87AD7A238B868B9F099B56D981B463BB981BF12AA2EDF243FE4E2211B9CF26AF
      8B68F7E4E7BCB8FEFB555C9F4C0F8B349FF4A3F7A00269054C5770A221998D53
      4A435DAA52A4896B39F3D69CC9362A22142B88AEF104FE05D54AD9CA5D0B060B
      6A28CB8AAE5855F0DA92DBC83C34534B5A8D72F8C5C7235C54BB14E2F329D901
      8107A7F36AE4E4026568DC22588A90845F89BA5C95C82C5ABC60773A6ECD32E7
      DB5614190878D3D54CF9F68A5CDA99C677604A7FD08D438F8896ADFEF19EBD41
      BED1B3004551835003BCD114C534C7DE2BC17AE367E492486C478BAD4A3D0FA4
      79FABD9B25381D150754A7214F12C52106FE70C45226B169241AF726BD194ADF
      A42C3D8B6B5E82FB6ACBEEE8A78D22A0866C6FA1C4249E5828FB0A707835DB42
      03F9B7FCD2C0F816096803B90364FF98DF2968C2D1C51955E0645FF9B22B927B
      E165D3045DE6411A4005F72A0DFE9E16E987641CFDF2FEF4DF3FBCDAE3FF3D79
      FE19036ED083CFDCF2B29DDF568646FC63BB9AB9650F66196E22BE4B1E8FD709
      9B70391041205850B420E14F150CE22C50C294C5E417E2BADA49A1384768B4D6
      257C2774EB835D522388CEB41D08CEEA520B7AC5D8BFB5EEF647826225956D98
      756EFEB29F06913FDD7584D1250EDB6052A9A32A046ECA074F070981C4C0E44A
      BEAD49025DB0F01B559146711DDB351F56CF4DC2FA0171F4EB7FBD89A7091246
      7EFDEFBE7F2B4B51E4EB0D92159D5A31BE97E96CE301E57715516A9733593AB0
      350F6738D5A6546476DA3446678B0DBC47D7B03F5C4DC1CD3223686472CFE369
      F83224848501B23879771F23E3141DB8F49E225F76A2ACF4B424B5E876E69C26
      79B22933CF1863B54AB5E0174BF2A07DE6201745BD5B4948AB3D3FA5F37C77D0
      6AD8976190F341DB7AC6FA21687DF371FBE55352DE7C8E966078D57644A766FF
      3C8B66A518FAEE6F681FCBD68B18ED2ACA1424562DD7C56C228C8EAE227536A0
      73A4892344D196869ABCC0115421C88780390FE3933C6FE5F33D75DAA9BE6A96
      E18F869820155AF7FCCA17469C76E94B5B2C8778B060498B2F18D65C210BB921
      531F687D3BA82524B736B2FA0294CE84FFD2B14820A695A81F36D8643BBD0636
      4FD78F2A608E6BD1A00319C5CB8EEC56459340EAC352AE44BDD5FA6DC56B08B1
      8A6A9C4614AB3AAEE7D5C60B5D56F82FA0D97C16C8FB0F5FDF7434DCBA0E648A
      AD8A58A033106A9C2EC8B986A53C96069B1679CE565DC282700B7A0A39D4F0B9
      453EE622A7C0FF32052367366838B6A3367FC78558BD5FDFF1844EF4D4420AB7
      B5DD5F3F7278171BBD251B84BEB4ECE95EF4F1F043CF3C9293CBB34E5425BFCD
      89E8D3B49989BDF54CB4FBDBA78752519CA72F5305AC0D215D81DF9ACA649DD7
      E717178F4FCFCF2F5D2025FA90007B6DC45356BEA4AC4D71AB2470D2E4A8CFCB
      1C97CC38EA5C50F63392A848D5A12B98E40E9D204D031EBD23CD3BBBE6E4F2AC
      5DB0565497A972D53989E0CA47F0E5A39347D388EEBC8671D088E139463A89AE
      E39242896B606584C330EA82454B8C508E751BACC3F81A657CCA11D97CCCB571
      376A55CC21AA90963900AA6CC48C6C49FB735E9C6682DBC9A3613A6C801CF4B5
      28ADAAB92B2C6F62E90188FFACFFB4FF4413BF1DA2B9841ABF80B88CD36FE605
      55F3C41015F50AE0ED99AA4F70FF20A218668F38929306DA8D0AE5E5A516CF2D
      531A2A4A224D0C9D386A9479AEA6C1266B9A5CEC80832AC174D0E38912E91642
      BD450DAA379904EBCB2834A3C061CF65553B88705616A3F990A0643AE6912299
      4ABC0D3C628E899BC639FCE969525F15235C4E4EE9DA45DAF5E8C3C8067F0EB8
      E61F0FA55C81427B279767776086A1A4CCA3FCD121584FACAB58349CBC8DD962
      274B086216596847786E352E1BAD03680D130A540B8B32DF8DF30BA00D2B9381
      3D6096298DFD9C7196CD07E30C2A07B8E4CB7A887B190AD4FF369FCEA2CBC295
      67DE78444CC14884BF97F1E7F48D742AA9E6E55AB3BCC8BBFAA9EFE2AFA84D76
      05ED64070BDEB5784B0FA1A998D775327235DAF04F70BCC0EE527726300A93DF
      B0902DDBD8F42EC34C59F74C3DB9C3940FE73EE5DA7F5FF5444E636D1AA9488C
      078D926F3EF420F448AA49EA7EEB47DD0F16275AB850E4FCC08D8340EC78DCDF
      41AA27DA39F8991811975B3C48195DAAAEE6E3314BFEC4A27A29E746A077D24A
      D76875B65525B74C48E1C1E9AEC2D341CCA0F173AB55AADCA049CE8A3E8C4EA5
      39F82482B0E7C14DF86EFFD399DC825C3CDEC213D9DC5E340114435C7A347755
      01BDB9392FC7B87C901028B41BAAB1DEB9F84F4F4A3C96296A2B1463C4AEEA74
      A823A4AB80D71751F9B05E29BE997C8B8645518ED29CBCD2E04C0FBEA1952657
      F5ECC3620CD0A303BA3D049867C4282E4702E43562CC5CF9B628D7448A96C7B3
      C5E3B653E0B2B90938249CB5EEA0A8418CD47DD0DA2C0D79E9602306032A5B75
      074DFE13A7880BE039C2997E2F88D4F444D48CCC21BEA9B259EF80491AFA7235
      AFC99A557F822F52CE211ABF01CCEAF45803A15247869470A64B11C62F902AE2
      5919EC412FF810B141795E2896D6A2B723DDAA4C27574033CA1C56B5BBC05DE7
      15C890E7BACC626DAF8173AA9C8C56BD4FA2F39F61B5D76D52054414D7936D72
      116F88AEC0A9CF5DE116CBBFD1A07530EABD151D15052B371B4B6C245CC3693E
      BF53D4C9A50CD60562441B6442865FF751120C376BAA018C0B959CDE9E5C9E1D
      550649EB87CC1E3F398CDE9E4CE0305FC2A0D2C0DF911CC23BD12081DAD4BA8D
      EAE6DA8A46A86FC1303F1342BA3CB6E36159545022A896E8F9AC1E2011E61C25
      591D8B14B4D87EEB866B3FEA04BFA183E5C44614A39555A0C93F0D42180F38DB
      3983A4BE2697F1BAF0F40128BD8B5DB4896BCA23ADA79527837AB4F0944A49C1
      EA9C25E0CD135E55DFB80F6A16C29912396A371FFAFD81ADEC5FBAB7A03DBBD8
      86B153250BAC74666238DE8E4725A8A569FD37359B5A52E3F8CBD37CB4FCCBAB
      A14C5F5438EC84304902616B79ADD68E3031D2906F060721E8861B372128D954
      AC5C687EA3C5D597A0104B52B65F90665830316D852B319A8CC61A34B6D14EE3
      7C32468A40C3ECC6D1161A5D71F3C58084ECC35EB00C828C790224525A6FCE3B
      D1291375FF1A1D71035F0CCB02A9C5A2CC41950EFF2DEE1614457C930CBF20F4
      52CB4294FB3F783DE8F3AEF50B87C58CC093D48FB6F7F55270C12B7098C5DD8B
      AB25AB801C0B1A2E2EBFD2B48C9ACBA105A081A163A2808885DA379D5EAD74D1
      093B07FA8BAA2CDA68DC283AA983BEBAAD97280D973DB93CF3651976FCA98345
      735D344B3931E156845F9D0FBEE95AE24833A02D167A6393E176B8CB9178B578
      2E6DB8CDC5CA4313D3A96439B09985B3A7524627465C0D714970556CC84E8B35
      71A753679BB5EFD0F0B20A06574B206D747FB52983819E1D24C491B95BC73909
      DF7A74B75E5192021A5A58CDDB457E0A1448AE69670D69786E75F616089E9568
      3D731ACF8AD13E07F4AC18BD56E05DD449EAF7E8D2FEEBBE7C6752D42E00886F
      E109D77813921B27C0128108210A10FEDA49146ED23B3D779B63122E306C586E
      CD603B8AC2CEBEDE706522514B591F26CDFF4ABF7288E74ACF48557FDD6BBDEB
      66CE885610087D92098E5916726BEC97340FDB742988C6FF5AB1BF1ACC693DAF
      6CFC5BAF6E886C429D91DDC1CDAE8B18F38493143BD150927192016C7D6E7794
      FFBCB50EFE0E5F9BA9EA1A41C4D26B9F036E4135C69A87A8725C5418064814DC
      543C9027573850F0F2369E98D5F77528D5EEF8F3F3924E01D3BF35AD1AF00913
      3BE4DCC45FBA9A365FCC6B8EA82EAAF669B3B3A4720EA96EAEB6BD0345F1D8F5
      473222003E1F725E25E379C69A3D31B6BEC41A5D5844B46C83E72B2662FA9F26
      E3D47857B5FE3D9A1AA8841A73CE8C22AD49485E5E314908008205C299B70BAC
      F5740EA51B48AD45148E8F9EEF02633175471FEDE365CD418BBA67B163FF8973
      66056103035C8FD13041DD87498393A44A82777755658CCBA5A6999508EA6F5E
      0ADB8CA731ABAD793A7DC08DF526D34A69493CC8527DDC63F0E4C623C262A63D
      2086E9D73863C4A5E0B06DD284A432B52DB976D16C680F6319B84090954270CC
      A16A9E0A9668442D482B7F696CCB662D013CCE2DB250A4596D560666361EFAD7
      040708FAB134C5DB249BF5A277C9B77975562007FA4D5ABF9D0F7A084EE2B0A5
      44EFFBB82E13B8FFF164B58E843DFDB6DCC316F4E16E7D446EAED37C8428B774
      6C3BC95DBC0DC4CBBDFA26877909CB66D327BA9151D569FFDF180CFF74549D02
      A6E50A0DC7352F0109D823D2E7F5461CD9DF8A42C5D5769D93B98A76E5CE71A5
      2958B34760851A11CB11C47D8A1953B2834BD1FAED013E89254ACC6DCB2EE9B2
      D1D19277B6CFAAA4FC8A53F1431267BB3CCE86CC76A40DCD8349BE2F697EB81D
      B5E720044747A07520D402F32FC990F4B35D176D35EF4647D994A854B9FFF151
      D558E5C1B241B5A4D24E17C999A98A6CCE628400D62443DFC78A8B7C82F86E34
      9EB3C46038F836E89B6F57557724436363A14959161BE61634C3E146FFB5BCBB
      A58E7BBE410B2EDB378C78F85BAB734886AF6F4497B2D86E469C5D9B8567E67C
      A39254AFADA1D2D480F6122ADAA6E2A5A64175979A667A16FC9E43BD5123771D
      6D7F8AFDA103EE9B5D3DE60BEDBAB313580ADCCB699A177E98BA4C147FDEDFEB
      7FEB45CFFB4FF13FFD7E1F16A7565FAA1CD1C82C4281E6780A754D503F35435D
      257CF45D1D3FCAAD7CC1B659783848BC15067B6B1A5CC2896682DE01CAB503A9
      4CA6083C968D415E0DE5B635845C62E8553AB9CA7805A34FD6824CC7BA59208F
      41268EB25929B590743CD992220D6EE1410A53C4901CF24D375749B42C3C28EB
      9E49D7EB3397419FA1955462F5A07E4F5E948E67DFCAFFB5A26DAE7B69800ECF
      32C4AD3841360A789E05AF4605A280FCB35FB5B0D693721AE7727DB79FBFB2FB
      9ABC63916BBB50BC865C7051F4A363B93C640112C750C313A920952AFDC0DE74
      FD4D6609D46B64AD899C1F222D7A6D39D06B5A480E1E50A4799ED63777A10193
      E2709D8E50B71D94DB75D3B5F88BA82B1B8CE3066DCD65BA9A0BA293664C5A91
      DC75CAFA59A64DAB251AE3BC48A7F3A976A518475771A6F8B3C660F54F0DB2A7
      6ED9D58D39194D4BAD5692C27616EC8575472A021929D6B2DAACDAF926BD6E0E
      BF2B4CA556AA53FF20BA22C9EC226C2B899974F2BDF727D0CB56AF749C32F55E
      4DC23A45D564A5CB74435AF78E4FF66ABE9E857EE026B8DA2174FFC1FD908DA8
      D5DC46513CA574B61F3B4B476483550A49B00502A70D8AD23ED41521DC8A5F6C
      FFDE9758DBF2E26EE909F5C1939D97778580A1887E708378AFC1897DE451352C
      93246FBC219B9145E880C8460BC238668C6221F27A9757BB980241DC05023500
      6542BD0AF7D6E464C8D4F77FF701D0DB89D5B47D43C12AA0DA4BA2E4EE61964A
      C984A0430D9DE37CE1A71A935FB57AA9665E163CD591500668E3AA9CE75F50D5
      D529B8D843F16E4126CDAA2E3DDCFCAECC344257F2C2B372C8FC63C9E6B2B85E
      7BD677D6FCBE7D494B19D5D163673C35040B560B116F406560D478BB23F804B5
      0BA538BC68DC7AF906C92B1BA515451AC010470C171ABC4A13709A5C38F08445
      8F37789DE4E924F77F2D107085A18F69BC4F0D3556D9C3AE319AFBAD7D35545D
      52E3A5AAB3767EA717CC13BB24BFD5126A4ADCD8BA830B2AEE4166E386E37766
      927630B0C335B67620D7677ED2524CB258135199F9C37CA4C63E72718B3BE63D
      3514E551FB226CE7936B67594294CF2131A6DEE08616F5B44A869DDB94E575EE
      BEDF5B0FA02BEF5CCE44F64544BF68D893F923524848035E321212A95FECB778
      63839BE84A0594B9A7A588665075F34B7243815D8EBD53F3108F4B37BDF4C920
      7C67E3C453E6D2E14BE902F6D98AE4A9D234349A8B68CF4C767965A70B41A809
      55E38CA3D4D42530E52E3B6F9D18A4ED36191B46643934DB241FEF67382162FC
      7F296B5D96F18DE39E6F5EB560DD8356562480D0E8A6876B0FE2B10AB8A3894A
      27FEA0C845C5A0DAF1A529D09BB5567B3AC9099311D0AF4D48E07FADFC914002
      DF62306D7B2EB38981118E07B0099D251E31615214AA29B34080567B5B9966B4
      1F45AFA3E8F54AF43B8A0EA2687F65EC76D51FB50A890D830D73A802822E6FDA
      E1355D5DF736ABDF235AFD2A60E7CAAAA03D9596C29CE91A073234A3FEDA48EE
      D44543BFAD2BEB6B07674657D7D08E8614D45497D54D757E2E459268972DB615
      9B503316B1AD79E25C6E70AE9F87B2A5F1A01768CC352C4954BFB25CF641AC71
      3B136FDCC0BD3C4166CD1289A4C18D54D08BF3D163F41B41E3F5751A83C4429A
      0D5F205E1368469AD89BE63848BA20C645A2DD8D60814C2B6E765C2134D361E4
      8BDC0B1DB6A2589BDA2CC3033BCBDDC5EC13AF8CAB341B9549DE8BF0F210D091
      E8BB34090920FD183781BC04953B82248D7584CCCBC23435292AE781AB2FC98D
      643ACFAB2DAD48E416BFC372FCBF1C409B2F9D02A4796DF7D83AFBEE933D91B3
      7EEF473A395DD0B75FB99EEEFE648B6BF727DFD8EE4F4DA9DEAD5A0C2A6ABF12
      9BC31ABDE5BDD0BBDB9BDD40A5460B80C82C93F7AB04B7C653579FA70489CFB0
      CB3FCE1EA3EF51171ECA0E4A84936B6F35C3F58FB6860826BB05461790D248F0
      0FEBF8262C768A8EEA4DBD41B528E8E5B82E6881F0DB5B45F50E916554984DCE
      516B6E790C210822987D71CC4786D5255D829C8E6767997AB9D49DD5BC44B5EF
      D40077D47DE6588C42D391B9D262858A7F8877B697DD6088A8AABD6E20F0A5D9
      AD23BF1E11AD00CC52340C69ED593C48A4B0CC8A15BB7836073FEDFAF884DD89
      4B55B225A844BCA499CD625081F06D1C6E6229461C8BBBF26BCA244BBE82C906
      864D00F9B48D963C580FD281FA66A65451EC7001AAA99DEF685444AA21E22851
      E0BBCF83EA2243BB9055BB713E22C74093169583EA24E624ADA1F3CB6192CC3E
      8BBC45A02DF018D634E815EB18F334868384C878E191DDC63355F5D43DDB17CF
      118E638B020B1BD8E1FB0D959438A8D9F3FF9AFBD2E6C68D6CCBEF1331FF219B
      333145B529AA16B95C965F7787D6B29EB5B5A8AAF21BDBD10192A0842E12A001
      B054EAE8F9EF13E7DC7B13098ADA00F58BF607474922814422979BF79EE5929E
      76127AABD8AAA69522F7E9FC688F11913BDF3F38AF7E8F4FAD1949B2124C0E22
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
      5DA4C85FA1F3E36BD335F172BCE9D8CF3BBF12FFBFFFF93FFE3FA45487FF}
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
