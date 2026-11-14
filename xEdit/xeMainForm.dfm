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
      789CD4BD6D731A49B62EFAFD46DCFF90E139F758BE034292ED76B71D7BEF4080
      644D2389062CF79EC631915009D4A8A8A2EB4588DE679FDF7EE3596B65568164
      594EA49E7377C4EEB124A8CCCA97F5FAAC67FDD728CDA787231D6721FD67B29C
      1D1EBD3D1A05663A3DF8AFD13489F37C1CFDD7687A309A66AB30CB46D3C95CA7
      99C90FD4C0CC12A33E9D7DF8EFFFFEBFFFAFD152A7C1281BBFFEE16094E9C31F
      0FFE6B34E66FBDFE615444F95CF5CDEF85C972354D52759E04AA59E4F324CD54
      9185F14CDD768230FF6F3CC53D8B9F42CF387AA3CEA66A9D142A9BEBD4E05FA9
      5A2441A692585D98DB22C32333A5E3401599E1A7299D29AD16FA9F49AA26C962
      99C426CE5518ABC0DC9828592E4C9CD7D432323A336A92C4591898540549AC73
      CC48AB6CA1A348464C68F854B5E9CF49AC7A4918E799DA6BF75EA93C519D6811
      C6596ED2E627FC9815CB6592E62A9F1B95C4B3040FAC0C8BC7E5F33053799244
      FB6A38372A359364B130716002994312AB3053FFFBF0E0FFD97F6861F85DC34C
      4DD26212EA08C363A634EF00AB1460743CBD88C37C4D8B44EF3249E23C0DC705
      0D555771A2163ACF4D4AB3CEC23F8CAAE3B9617CA3A3428F23435F0D8C59466B
      A597CBD44C429D9B606B7A0F9C81CF739DBFCCD48559611F78E66FF60FF7DFA6
      FFB1FD8C833BCF38E2670CAED769B8508325468F149E1126F17B95E91BA33A83
      F3FA34D2B39909D4322A66619C293DD361FCD00A0EC27862D44C2F8CBA316986
      D538DC7F5753C7269F9B2CD02F33F56919E8DCEC9B6CA1A230CB3395DC98340D
      83C0C4EAECE2E4B2A6DA67CD6E4DB5BBC77D5AA541AB73417B9A06584115E699
      9A86915173A30393BECCD4E545F37C5FD6204E564A4F2666996758FC8C577A95
      86B9A15F2C5418E709ED0BBEC6C7E7FEB70D735A89AC4617EDFEC5AAD9DF5FF1
      643B7160521DA941675F35E37B1EABF2B9CEED3B9B4C65C564EEDE8EA6AA331A
      3650631C3065741A852695D79BEB0CA78BA66E70E64C46B3C39BBD5751A2034C
      1BCFA14DC4BFB1676A15E673BE27B22FFB8F3E25C3EE8776FFA14D6F8E932257
      87B5A3B7077437B041191D043A90BFF3AD3C372956A1A7F3C91C772135E3228C
      44B4E4F3D498FA4AAFD5021FABA9566A746E54DB44B996EFE0A5E821BC83E71A
      3282F63B4D8A38A8E769B8ACA955924681CA967A024933CD4CAE725CB84C41F6
      E01CE42686ACC3FAD4D47992A6C92A8C038565CAD445F3BCA3A230BEE6CDE89B
      A9494D3C31813A5ED7E857F3220E5203793955935467731C9040E7BA1E2559A6
      963A9FF377173A9A26E9C204759D4EE6E18D51531D46452A539986B726D8579F
      706062A3F3798D0EA28967616CB0C75112CF2045CDD2C42C9EF1F722332916C0
      A4537AC5147F4862A3665132D611DD3D9E281F182C7290F1FEB74DB49C87EAF0
      F5F6E61FBDD9DEFCA31F79F37F366B350F67F3289CCDF36CE36BD3B00EF11485
      F86F7EFBFA87CA91188D8B2832F928D7E3CD8DAFBB538B35C0E6D18607951340
      0736CB95D193B95C9A97994A56B15AD096D75496286DAF5312476B35490A6890
      D5DCA47CE62779A123FC61AE633C3D4B16269F87F1CCEB0D1E7D18EB4AAB803E
      B5A44F8D4DBE322656F92AB1F78ECE8D862E292253B36F3FD693EB52304DC334
      CB6BB43AB3F086E596CACC248903AFF97F2EEF44A6EAEA464761A02E4F0643B9
      1A7C5E5ADDC1DF71984E7414E142BFA1DF469A96FC9ECB03F91498A92EA2DCEF
      5CB8AB57E76B97DACBC687836E616DF30AE27A5FDBF9CECDE49A845F274D61FE
      5CC7C92A2B1FFB32536160E21C8A3A2D2001F6CA21C34C65791845EA26342B3E
      44249B4930911DF3CAEBA506FA0626020E026E3B8E1E96AABCCE91814AC139D1
      0B8DAD275596A42A351A1A4084BFDF398D12B200B13A131D4F4C14F16448B004
      619EA42ACBF51A634C0DAE4B4C96E0244A32DC9B1AE6B14C4D96A96BB3CE6A6A
      35C7E4DCE521B15DC47118CF780BB4FA1CC601563D3319697B13076A6CE6F48E
      51786D945671922E74C48378BDD6F1A09992E8981651A47A915E0F7236EA4E2F
      CE4F9495AE62286E181BB9B9CD8BD4A8C9BC88AF69DA30CD1288DF24C591721F
      4816F4E2A4D237A4B77D3E1FCAD44C8BCC048A2C541D3825E02B5ADA661AC664
      49E066DAABF7EE0755909914C004FDD869F7D5D10F3FD0BC4E9274A1AEC4B63A
      3AF8A9A606B94EA7A1C10D871E1CEBF85AC57A617092715D4C60DF285E93D6C9
      949EA4D055B0C9A12FB247AB8396B57393347BC824A8D8F03595266393E6B3EB
      A383C37735F53758E4731DABCB2C4F8B4CEDFD739CD0BF5ED594995C6726D5F3
      1A44A029E2A018CF6B0A2AD66E0BBE790D635FB592F1986EBFCEB230CB71DC1F
      6FD39C932B73623436FFF1AF5F55655EDBDD2C151AF4E01A370A623ED7D72458
      A3B52831B21245C55925668DB92C271BB8D4881F5438251D632D57FE06AB0DD8
      E23416DB1724CFC9605885B19F423F23A93AD191D2015BC1995AE88014C2C62C
      A09555124F0C4F706ED62A08A753E893722A6E41ECC3FC27D6A46BACF3701C46
      90FAAC84E1CFE1D770E1C40C36AC77717BB192BC8A191916F839358BE446476C
      C6A5069A1B3FD1FB784DAC53B179963AC44CC6D8694D6EED1ABFAFD94BC97BC7
      E6252D2026610D096B3CD1F160775A43567BCDEAC25A5F5929435E662A361904
      CF45AFA596261543180EAE0E63D89EB95940035785D545AF056D1BDF98384F70
      D2F095CB7114DE603FF1245A4918ACD9D24491EFF6566DAB898ED5583632F850
      1A8418C95E8F16EFBB1A266A922C699D559CE4D6EAA2D340666692CF4DEA3529
      B836D766BD4AD280FD59D29A93B98A716E64A49A5AE152D3B9DAD2ED0F4ADB3B
      7667ADFA4AF7DAA04FB0B28FB65A370D565ECE3B13AADDB1616B30B54C882557
      491A78CEF91EA33C9CC509DCAB6614252B75AEAF8DEAE9340F75C427B2B4C2D2
      02D18C29E48F33D4E0459B7411C6A4777941E050FBCD6E739BEE992C54B393E7
      BAA2C559F3CB5A7B6E67F9B4EAC692D4582545145435040F046369BD34EC99B3
      8D43FBA9D5C264999E19353653184E1581C9667AA2034F7BB529810F35A1E5C1
      81BAE34061C348DF63AA953FBDCC64E26A9A260B3E5DB986F947EB1D191DCB01
      84316B962233E53B5648C88B78CE9E4C777E7FF8AF49319B6F881C1D8B141843
      0F7FCFCDFFFCB52886E74C2B2E1FBC827AF599D872EBDAC19EC28CC9D12A6760
      A325A5C757B3A723362B75B9642360028F6C9CDC7EC0379CF82F9D2B088A486C
      1BDE72160B95B1BCDEEFF25EA7951E4D4E2DBD32456167691854DF975E622B5A
      FE3D923F8CEB0BB348D27535C8549AEE09991498C715DC4C7C2B9BC35D22D58F
      489F4CC4BA5359AEB140B42D747C9CC4FAEE2354FABA7B4FECE36E3BEBECEFB1
      BB07F7E4ACCDBEFB7B15214E6F58315ADB05A683FBF2CB4C8D9133603950A39D
      12E785AD7DC3AAD90A8A7254AF996FC612F2544FAE25E4573ED86E459CE458F2
      358595F8F4D26B2CF41A9B11C6302A23937B8A680E76535280CCE969C84621A4
      529E2CC3094DE3ECA279EEA77FB68323A981738CC0032FE5CBCCA635AE0D0C36
      35D6015F0F7EFD71944CAE21922584C2CB42373CDBD8578E3F4FD6131C7FCE40
      61ADE0574AD82E4A92EB62C931185F49AB2710312FE9E492EFCF570DB72946D0
      2435FC099AA57C9A0E92E73929E3F15B5129B2C911158811D1D714438008D3EB
      52C0CD13845C11927FF46D857C90F83F4754FCE68D28AD6A45E1E45AFD3BA528
      ACE075F207DE66B2347126721E61211237642EBC9784553C8B4C3D42203A0875
      94CC688FE913124AD631641F2D804496D8A75B14511EF23725E024D909952263
      B9E712657CDAABA1013F61D40C705A2751B81C271AA604ECFC85890B6B33D837
      7F09072E2A16B1E48DD4DE5F0EDFFCF4B6A6B6A6B4159FF09BD5C7903285E2DD
      2F4DCA71C6549330A3C773BC9EAFD5C73030EA824C85C13C59E17B5A652647F6
      D45B3759AD2C3BC88A072B3249A2482F33A312F904A5606669522C8D5CF17172
      ABF2D418EFC1DD794BCD343588E040B29968CAD234CCD52C41F60BFA8ED70082
      4F76C6DA6B649F92188108E183C76A2CCFD4445BAB23899222F536416FC22CC4
      F9FFC38C5328E0345C92C513E8F45A65F9DAC5C7E99AD3E594216D4A265B52EC
      766E4C9EA902F91CA5D555ABCBDF7E024585335464D6874240E72A4C91E150C3
      D4185A6A9D95974C529AF65A923D9CA7D15F5BB81CA173C52233C19197DCE34B
      4E1E923F265A3C537BF4BD6694FFB5852F8529EB66CFD0384E36A7B8E07DE494
      BD0F4B43111AA9BA9276CDAB1F27DDB4A0B048184BEAF565A656462F61A4965F
      FF50FEB1F25BE7A9CB9DD0CBA5D1E9BD79ED07647597A42C85544D10160B1BF0
      F2771427B95B724402E93A263A7AAF28ED06CF9447F23C4B71B118E350C2A088
      FF6926396928A5F9F1F5F2F92E57CD763A47C3F03B285E388C9E31EE1C63DA7D
      EE0CBAFB4114E1C8F2EB49E0C6023DA030EC67F9F492B5DCD66BDCCDA549DFD0
      D74DCC16F746C6EAAAFFE85DEC50A2D55BC04D92781A851358F1D175AD72E15E
      66940D86924DC552D96B41299DC5795273BB51DBF4516BF7054E7E29A0C89B05
      A2DDF4613A73496A5E7D2DA840F12585B51021B0952E76111BB3DBDBDFC95203
      97A0D5A448535C5302801056284682E5BDD81ACE88D7135108641FD2A7039708
      71F14673EBE7980D38C396DEF1CD3527E3E4D924BE93A55D299A85FC497C80B4
      FA86B9C42874B6D37D6780529614E9042EDE044E6446597A9A905D13A4C3354E
      3E2EA20DA87B47A34A68CCBD70001C500B69125C0BFC9BA8084CE027EBB7F553
      4DFDADD5ADA99B495467955A2FF230CA6AEA6F5912B775AE2FC7904B2CF4A33F
      DED4039E9B75A56D8C274C55B1CCB0150BB54C13FACEA3933EC7C58CD25F8F16
      119CCCF57659EE4BFF0A3EA6B695EEA5CCAB4B0D93F41D9B79885829BB63F234
      1C6DD52C235A8815A4330324D8789D7BBB5722815773E48169C63485898E112D
      1F9B3240671D49F180B66D8E31492132ED92D8667DF88988762C754A1F452E98
      B2B1648E52F639CB93A5DFF47F3666298B86B45A802B244626C757688AB02824
      DAC9BE76966B4FDFFD1226E886C0C78DA5975C684A98389586BDFD80EDCF2669
      B8CC95B92515172466A7774D8DB89E2E79968748F3DDEA491E89ABCEFB541E1D
      092B53CACBD38E8076515AED67E6771BC9B3C2A972C4636302BFB73B096FD502
      68358B87B378862892CB9F1563FB37DAE22C4F52C4A671B8085C19B2BC088A94
      FC2F68141D851929E2C787CEAC4EB646196BA4E5DA571A3873BED4341C79E604
      B69AEB3498245055123FA340B8C4AA21ABA1D1E9C4DDE68C6BF5B7C69C39985D
      87CBCCBD2287D9B0AB584908568B1BD076522E67A0F904532A6D1AE69B72288B
      92BC9245F05D2F608F39BA6C6383B4523617CE539228342B8FB3B63A3838F0B3
      1870536CB660AEE38042B9768F10E58215B10A279C39707F618119C681B9855B
      8213974B1E45D2B8BBBDBE9C005A71440A37B2FE9E1021A3E362297E00C4209D
      8252609019271FE2D7E39D553A82CA5A97C12DD918BF9B9E508AAEE272F24570
      B1C9551823D96C030331ECB55D5E1B06B885FE5492E83036954E53BD463E49DF
      868B62B1213E4B88326216617C27B0BA5BE24B5BC50010CB2CA64497C44958C5
      E3E5E14EF8BF759EA881F5F5C96BA00019C274CBC8A8948242C99D7040459EB3
      0A25CFC16E903B9190002E82B8A7ABA2ED2545FAB732F0F8258E4E29F0586DBF
      B259F3096527CD62997394C73AEC98398B28DA910F7CF1E3C49ECEC84C054B81
      385799B5F47358D364B984FE002C2F59D545F4136AC6695C817C9E90C44C6875
      E252884A288BA456601FA771A328D4EA3EB0F1CDDAF6AA5784908DBAF2D2200C
      63978C5EDD991C9C5CA35514DBED9E04ED83D18D44072588108E9AA70C2357A3
      9AEC11778767E84C4BF273B04A56A32C38972F28FFDA26983D4F16401E45EBDD
      042BC27CC82BCB08F6584B790B80803022E0C6D36C092EB0D402BC329E30DCC1
      75B854FBB310218E2880AA211B06079A4F479440DED2B0FC09AF613EC5A99941
      6555B00DEED4DAEB4D0ED5EE1970C9F20C7238644032C054E3B9433C4C0148B4
      9962426F62B745DAD39710DB0DC7A94EB998462F97C02986532A6FC2D57A8F6D
      BF170D2FE14446F5443AA4B847CDA6A838E220CFB686CC22CCC8A044C0CBE13B
      E93696239023222152403FEFE42C1E4C103C08E7B15E4F059B4BE02E3DB946F4
      1D4B95A4D7FE41194EB88402EFB5D812F6AF52AE1903C86D9EA4F9A4B011D670
      C1488E3424E432471C607991D1E3A258740700B3E2C78981ADEDBB9002283FAC
      B3EBCCC2D87331D4499B799EB3FB60C665428342E224226C5C37DBC21D4B149C
      E62A96E90EB3119DCD09FA9C7127B270EC04BBFD24D9CB70234F9093CEE602DA
      A534AB784472A580AC8A29CD828C279C33643FD950AE6E5329824928EF10D400
      6A5AF65CAD34044811E761446938E7366D453637AC6B9A5C8B3D09F12B103BE4
      9820194438BB4B94047A5F04B2420041D8C021BECC542F2A66334885F85AA506
      F85B887E2DF60C64252F332C6FAE69C403608959DCBB038D5990D45D58FB8322
      80851315FF85D932D27E7AAC6583CFA9C98A28CFDEAB93CBD7AAA14E2EAE54AC
      6F16269BAB3C0D35D2B8CA043397BB66182CBF56A4E3209BE8A5919BC29F3936
      71382BA1C89CE19A1B0AD42FF4B2042C4C74F434C8844A6D44022101F1417882
      70828011E2C99339A202494A50D2DC2C9600F8F06FBD030D30FC2713D43ADC84
      09630A60DF03A04811D0BA8E423A985912715D27E64CA00D51A27E4600879CA7
      862EA6C454E8959DEFC3E803F59154E5CE19D83B796F4A8E978B4E73C93666B2
      61C03ECEC8F42F5A918105A7B085D021C082036DD2274B080B63522B903291C7
      63568538E7545D29B9D10DDF049A8C7D1EEC2CBB331CF1C6017C0006E9190EE7
      1CF3675CA836552B7002F122C9EFFFA32C47AC6FC2199F4DA4E3AB816416A155
      F3FAFF37CB712708B1FD5A5E7B7C8FB3E9291CA29C6FE7DD034908B07B8AB9D2
      6455BAD03451D4550521DF0FFE8BD42D4E29F461EBC8A5548B3E8634B0400A56
      2982493B04589A2A480AAA33679F45621B64F98631FD93ED279DA10609904EFC
      EDDC53A00E1F3CAB54401602D4B7D454EA8F194570A7B06E387990BA1CC39605
      6037177F060478E56BAB91A057FD7032A70C58E7B2C82FA77D49BF65CA4003B1
      9A43F5493C83698042C12D939F2B90BEC3D2979D251C143129C4A003E0C8ADAF
      2DD88CB71EA3A26446E9222E2BA681CC2D85CB92B8FE8749936A991AB69B4D76
      3692BDE650D7459E50D40E83D14F1891C1EC4878B065BC4802F361D3DF2A6218
      5AE426C887D8DCA24062113FCB6CD8E664C2819AFCD437C819F0625DC67AC17F
      F52B60FDC6E333937706E7E21E903756537518C3CD382011686D62C0BD88B2A0
      0CB9DBD22F2E7241B8870E22F9D02831C7929224DE9FCD93CCD791A99FBF57E7
      6B754A805B7AEC0C79320A62A73A240F15DE4C16E96CFEE83C6B59D328640F8F
      CFB836A38867E3B721A79D13351AA97673D854757599CE740CD4377945E1ADFA
      14634E14DFC79B3D3D18B1DF39E96302BF0E3BDD9A6A75BA5DFAA9D5EDD7D4D5
      79B38D9F0674FA7B299CE57CCDA90B5527074AFCA12929A0EC39C092DDAEAAC3
      7BB83169AEDA24070AA38688AEBB65A1386F058E01FC8FAD20BD36EAFCB23D54
      93A5F8094F3FC79635C03359957E1103E12FC095D6B0DD54193CCA6BB37E86E1
      2F9A5767AAAE7A6901B387538AEAE2EAFCCCA50D9EF1D8F4DB0355571FC3382F
      7D2F469BF57510162429F224113A9D67381FAD8F7DD570F3E9A1F82BCB553799
      B05EE70D41149A142785DA9E631A48C8548E602626D28A93F61414677386D0D8
      9B7506963C6001EB10A7E6E8ED5B5815C3CEE0AD6AA8C1A0535327976FF09F77
      5C523D3839F49AA6D4967149B643AF857198CDB92271EB12D96A024D9E947C19
      4148C9F53CFD425E1E5FB4210859C81C2324B5190980F937A69BFC9E0C83A9F5
      25D8FF58281D89F95F5A73BAC4BE3DFD8CC9BFAEABBEC996498C201DA57338F9
      7F932001CBE15A382F216D2AEDE4EB1AC53EB09BD57D660A177E94BAE0B437DE
      85D4A9A68215942252A898FCA1C7BFD0435AECE4F275E3E4E2CACF62BDB80211
      4078CB4E1A40D99221CD135731AC4E3BAD9F2545241603C3E0513E83E87F1297
      9BC4B794235CE47B646A7E7135E83CD1CB62BDBD91FB83D665D75D1D4B6F4050
      038A93712CEE531CFE5E18D59C109CB91A0242D134D518441A9630055C455455
      CA369EFE94F63AFD9FC15A522C549FF8081645463EA935BCA9AA601A527E61BC
      66AE82E750E7AD8F353568F5BB35D53C3FC7C5C1A2C2D2A87186E79906BE383B
      213BC282060773C48A32D53BEEA3AA884E2B4010647809C9C2334C03B71F7A8A
      D8B0EAAA4936F40324628E75CB46B570950EF7DFDDE124A30A654BF8D5F93AC7
      D733BCD3E0A24DBAB7C5EFD436EC2D25A91ABAF2DCDF0BA210600A39F2DD2987
      3FC8751CE834F850C1B3324195C31085F99389B8370D28506FAF3C619DB44802
      0039610B871BF563C27D400E6298CA8FC8FC1255D2D3AFFBC925D0E3AAAE0615
      18FA36E69CF1EA0C927A862994840A7539929B742F30660E7EE28A2170C2E0E7
      1F7E101014D1BBC46615C172B2D80A2AD8DA9EA96559619CCBD34EFB848724F7
      379CC572F56D0D18647626F0F0EF5DC50781BA9E16DCC011E638EFC772E6BC57
      9F576166D4E92782E305E6D6A66BB99CB1E6F84A745421DEA1B772D5BCAB1050
      06665DCA6DB5A2D41C67A2DCBF915E7EA24D2211B9C1B7C814236CFB08C6C4C9
      EC38219CD92E798E5F3E0D86B84D2BBD54279FBA5D7AEE316A7DE948B72C8B28
      3282548DF71D07E101464B1296FE30CD2C8908E2CA42F725B29B4C088304D10D
      95C448C08A9281FC3109EC4A588BA09B59311614043C17604E2C768F1F48B587
      3FDCA93D2C598FFC8B21A7454C517CB19E4A789B8EC2598CC821857D714063F7
      3B1D78869983409D9AFC2C137145AAB6FCD9D651CC0AAADE1221CEB69D047A39
      B48F833733604C15D951F937858323434F007DAA717F7D068B6A33B7BF0981AB
      02E0C8302DD3125B50B89DC6A60C20325D35F9DF8EBC3C7B33F8CDF1FA8C30A7
      9BB3E4FC980B1EBECCFEDC44DE9DF9DB79A3AA9DA69BA4A47EF8D7B5BBEFC394
      87EE352A50705E6F1698B6DC5A1287C08D7D10721206170ACD8EFD2A18EF2436
      204693168208E1799205205BC94F8D4840DBDD3CCE9501EF47791C0C5DB3160F
      103AB41A5BF42A4FC528F7F3E77693DEF2E7C1D9DF397D8D7A0E28219A26DDBC
      558AD2C7C0C22B3D131241A0B289B641432CFDA7335B097202E609F247515802
      820FE61291FBF55DA0AAEF4C2507C5320A2710471527B0BE912AA573AFE335D3
      1A563E1602727ACFFC9E20C827796E479E9627E05ABC0993A2D4C90E9F572760
      364723B1990C4A57DDD6B0E4421E93187C2ACD79717672B203A0E3C4013ADE5B
      EC3482CC212D2A8BFAF3CB5E8F8ACF43B266490F80E98F431DE7C98DA1F4D042
      6799BD156570E341675354CAD36FDAA73864F637F82C267D4FB375D75AAF09C0
      ABC6F3EB96838D9E9B6C3E98EBA541599B40C969E72548F1F09B046106737AF5
      2CCA6D09B6F161AAE30C51C78CDFE678304C439A306D98B9E558654045BBD8A7
      67585536163EEA9BE45A9DC53826FA3D5260641F5867C1E6A9972636B9E00A03
      B3CCE7CFB2CFD9351286269BBFB7D2BB5C18C023B6A1428CC97B9ABBC704A77E
      CE171282D5CAE9AFD1A33EC781222C1320818266B00CAAD0012E7A4257A0DD1E
      389E56A15CCDDE33C84CAB954E9952962D148A92A30E82D8DCA8EC821B16904A
      8D892E3F59A6E0CBB775C8BC198BC493AB0DE4B02021172E5861E15984CBEC25
      A2E5BA8638448555D62D6990083C1D5946221224A2597CDCD5EA844B4FB60426
      8B24121E2E28C76A6D13413A424BC2C056F7C09ACEFC87626C80DE437DA227A6
      ECFCBB097109D58F5004FE0DF3EC8625A8C4EF89579F7C24F9891951B1966CF8
      33495956B3C03566F9AE6D92FA66B53B907D7CB7FBF7376A9A7A67929B62F2B3
      0755C4D8872A4814762AFDABB6C1E9023C10870904C0023E659BE809BDB94074
      A02233D39335DDA365786B386FA405C37D9214690BEC1E70EA75A6CE43508926
      5398E282405E6806B5BBEAA649328B11DFD0AAFDEBE1C1E601091C5918DF836C
      7202DDB54BC985DD337246B39ABA012491FDC5C3B6130918F2B87944C7DE1BA4
      1CAD2040603310FD0F92464C620139A263B5BF58BEE653481D39B8CC9D97C5D9
      2261369100157F11447EAB7BF24CCF285C2D4675CCE8DC68AD22943AB1835667
      637A1ACE685109932C8BC62241B8BD701F444419E0776FB72E0FE4EC21E98D5F
      41F9B33FD6474FA5D46EDBC5C253F4B1EAA0DE1B5B240C8B305BA2674E20EFCC
      C161EBE1B26F47E287BBD9ACD49599498D3DD9F6D474C1733B28776A2B5E366B
      5D6C393FAE4B18874C0E16C22465A45B3C2BE0E239716CD9C2A462C3BB1CDC11
      9FD4363850CA9F6C86DBD1816EB19905C5026EA0D322E4B0B9A21A0096042D6A
      D9E36DCDC5E2FB4EC9F7B7B1F9FD3F9EAE4149BBD22E08B30EE3C2AACEFFFD95
      A6254B28A70969B624AEACDFBEC996B418361A4C508C861001491CD531D1DB9E
      497751CD70F8E6BA8870726645A4D3BAB975AA9B0140641209F73D6E67DDC950
      AA46779ABE6E0BA810B8B697806545E5184830C4DC2ED19CEA6EFF97676D0152
      AE5F7D730585208DB97C02B5477B02428934E450CAAB9A88687CDA7E2B994A65
      B490BA42C13024C63119D9BAB60FEE93126E19478559A640D8C8664D74FCB28C
      7CF1FAB90F65E59F772994FBFAFEA3AB41B9DB591E4EAED70DC1EB03E5C4AD16
      A2BC5EA26B6BCCE6D51458715D47C2225702B8D952F29CEA9DE3B8D73369D437
      3373FBAA9CAC75EA2948C7B468355BAFEE26C2F322EA3BFEA2A38DCDD754111B
      18DF1218BE188DA63815755660F68AB81B4861A892B0BE99B145C9EAB14E5600
      AB528E59B8CE16A04C9A89D3994C5147189829A2868DE88F378DDBDB8FD031D0
      2CC5580ED8EEB933BEB37C511B8EE9A2BCB26A0F46C8B0D33BA9A961BFD993A2
      B6F3DED086843EA84E4CD7148CB2A959E934906414650737F382AF1004CE1CC5
      0ED2320D4A2B5ACEEF9DAFFA496A4CA401A8E641B89B8B3DA409C333E54C8B55
      6AE2BCDEEEB65C7DBC6D30B0435C965BA060E956635B094F55DB35351C481D30
      F16AD04BD74A80263CFE814B628A6405525C2F397A0C9E5161B89CB2300116B7
      6EE3C054E2E5DD2A82027232F12A97189D68203679524C1B267052A2D775011E
      7516B3971026F1ABDAE605C1BBEC1F0F9A8D7DD8DBA5C2AAF609491BF9CAE86B
      40BEEEDD86A76814E2D31BE438198FD793A8309B6D425A06D64B6DB3F748168E
      C3B46C2132F9A1067CF1429F9B3C4DC2E0DEA622C493A7E3A5CE73EF0623F772
      4D7D97E97F4F6D1AE42D702D0DC05A1AEDEED567354E753C99D7B91F2415516A
      697EB101D18C1126FA85FADD31149FB20281A2EFF9F9279D38C3416ACDC32838
      4562C6C60338F9C24515B66F04EEE0B90E63296D2314CBDD5E088F1DFAB793CB
      375FD03FF2656E83ABBF7EEE9C6F52014AD7230E10A546F833D136C349564990
      623D20DA03B52CD2A56F97226C5A9B6A6E8E0B82514AD05E821F488D90C59C44
      99DA137E34D0A379E73AE0D169E49385171995A096B3D196F45C51BE748F4A50
      38E88A5A334C89BE97BD121A25022A58E88DD4122F0CF0927E284E306393B91D
      4C3FEAECEF264D86D25A2149379765B81AB3106E9BA9F7BAF73BA717AADF6E0E
      39932C84D3004CEAE85AF13FB9988BA0911499474F9675D9D7C4EF200281F685
      A6804A0F4232F8C62DF0ACD7FCACAEC9B2C62951AEA5759287AC00502D3B369C
      B18292E68E09783182CDBAD255058AA7E7EE85F4559BFE1B5ED19F0478F98ACB
      B6E97088395A7538DE5388085F11A277E190940EB88EB4CB3E705C54C94CB871
      67E5B32575F0C692702EA8F23D43A57F18D74F6590E3BCE114514F21487BB01F
      7CD53B1292696E40B748287A79EF6C69A59C8B4E91B31C5635F04F809C8599B8
      7054C1C98566CB621C1118DED5994A382D530196BC604153B7B478AE9307319B
      E220FF4CA44B1459F63C0672E8AA0D8EC8CE4E4B762FF2FDEB22268EDE1E5195
      554DBD39F8E92D23FE78138FDEBED95A3EDC3EC0E3BD43BBC22124388406F16E
      6D82D0367418E13E391E438560D683451D3C8390B888D11D541DF12F390EE580
      A3C5B2CE15F5AEF1151F5230466CC6DBAC36171E0937C13D663AA2E671DCF382
      489A67BE7CA16D497BE202E1F91B2799BA4BDCF5DC3F54DD745C56B94B7673D0
      BC9966B98B83868951330E3A91F1CCE62E2D515EB56F0F1161B8E09988BBEF60
      5EBA1B25781694443310DE2D71E405B071B7D0191DBD218FA3BC5ADB4B3E2707
      201C6F183134EEFDE5C7A39F6AEA2F3FBE3DF444959B958D79BC07A33FA55C30
      31EE11C441118C890B8D5E73E808C42C1AA821274A2CFE1AF73CDEFA28AECCBA
      FE7BA12326008560AF57F9CE3F54068583F8CD215FFC46489E2F34F68BCDC15D
      DB034DB10FE3DD8BE223A8BAB1E0C230438308F7CE06AF439E58B380257892E6
      C4D733373769E93F086D7E853D270853F6C8BD2BBFED33A9428B9E6B5375667F
      B6AF5E6C1EADBD37A8CF3979AF0E0F50A7F35E1DBE7A016B3DC975A41A8E8F9F
      03FC7C4C55C355D7EF463DEF6AF46D6F42FAED4B4B1C60C3032FD5325916CB3A
      5165705A72EFEEB97EF82E7F3DAAFB60E89CEED713DE7317BBDB40094889E953
      45081F8A0A0A69394470BD8C5052E44D36779CF83ACAFC8A9BD144DB71A91275
      DC50687AB98C903987994CE067B4BACDD3E4DA9F0DBD037E75AA47951A45D068
      966B42660D822A16C55A425FC59A7C7C9F984BEF468540EB493D2BC53DA9846E
      32D7A99E60165FC7FB3CC961846C47719423EFB11A1E2B46660A827F040FD962
      C825075592BAE026A4FA706B3981EBCC3C139AB0E55A5E9EE506059E8B8526CC
      056D72C184FA8C3775E24DCAD7980C1F829A8C07E29BDA2359F8F2ED2D3DEE02
      69C4571F4A1C7CE5F9A84BA4DA8330767536CFF38AF0BCC1270DAFD9920496B1
      503EB8B159719C3C8C97458EDBF5F27C7D9E04F0555E6E34289B24B006CBBFF2
      27B627CE61BA2715739296AD8376A292051132B80A32C5629548C3BB4891D450
      3DCF127713E2D4436F864AD3C42DBB7AB35DE1B3CC432ECC46EC0517B2B45FC9
      9827F797FB02B141412EC31D97631E9A14D807E108DBF23B4AA7B78308F4C434
      A3C8BE5CAB7B56160400514FA044B2F30D7FD8FD2596A25CDAD6675994BFFCF4
      E38FA571E0A422884C7E2FB04F63B488234A0CB19E362C2E7A772EA566AF8D71
      B9CF34D5B7076C0B0EE621B86E134608D32AB7CFDA7521845AA6C96229F40196
      B75683407985603811C2210C60F97FCBDBF23CB33E3C383A724E38AF2051E370
      8B3077104E4D8C009719747E796FB7611FAC14CF34AB376F7F54686B24163B19
      0B75612D0AA8D283BC05CEBD05EA9F28EFA5338A3F83E4BC18D3A79F09C6CE7D
      D586E7669170846AE8288CE82062E8710144784081A8BAA0EA59E2656A8FF39C
      EA18B53EB88F28D8E5DE0C3601242D04B812A36F669D5B341DBD1EA3DB12B131
      A36131CF00F434E0C2633A85E1601DD3AF1F4392F4E880B1A45B4D25D35A4323
      10162565BEF534A400BEB51E28822F29E00A24A231BFA780E2FF48CA1ACB1123
      943536BA40E1C13DE11168006AD6B09640637072B823CD48AF8FD262EA8F1C98
      29BCB518192EAA31E226E41CD879B609347BED0A0F4D8F491E9B8806E2EDB9BF
      46A28E9384F4E2DE9D29F80E7F7A81E1295120EFCF55A959AE8EB8818A5A8D3F
      C580FDEC1DBD7AF2F7A7A002D33A56CAD6791FA62DE9CA2775DDD3CE2D21134F
      D264710CD2D6BE993EF984904CC44CCE2E2ECF1B671797CD7BA6E3FDE04A9612
      841E95D4A40E2050217AA4109192DC1B09CB277A412AFB1F8D987CA9CE4CB4BD
      3955A1A67A4633A8720138520D88D954C741B2B0E5A94F34A1D5B8C26F8495CF
      2E577031EA883422AC44F30088DFDA17F8993FB3D400348BDB73819ADABD0D96
      09C9597B525AA0474ECAC5AF6C26302E26B47674C1205E3FE3B333382DA51BC9
      1C8E0ADC188B54B5A5FD92865F2C3CE35183CB4F17CCB3D51EB4EC71EE6F5026
      D8583396B006B40BC7032D5FB61C84CD1DDF81CD6634521DDC74481E4ADA7E4C
      8A14098781C9D5344AD04D259C71DF5F75F46427EDACDDED38CD321A298270D3
      4D241B57846E9EA82E58E7EF252C79821520A614ACC0744AFDBD4A55F70B4116
      0639D53EC25F3EAA430233F20A37AE2AEB5EF9D7A08F46AA49D64B56615508A3
      88F934AC3FF48100E32C82CA50887592D821D2912AE26918C1EA6283888FB1B9
      016A89C23E165241A879E2B27039AD418E36E1E73AD6F4764FB4CB1FDB3DE832
      315A9EECB1BD668BB6AD37680F2B74441938BA81F04382990389C01909604CFD
      FBBFA9C3A3A3922A8EA2CBA565F55533E3C908F6FDC506B1DAD5D5EB149586E8
      F04C4276D03F3DE69FBD1EFA79F891B95CA2A428315BC2D2433C26F69490BCCF
      D45F8E7EAAFFE5F5A1DA3B3F18FEDAB8C07F2E0F86BFBE7A2E3F43006CDD41AB
      DFE8424651971791C8BC9A2CADEBC4B5D3902B79D7F407CACA5721762AFD5D79
      6982E98092C32768207091E4567C7B0ED0D571D0E505062105717234915DA070
      225C9A649053FEC4928DB99050C9916EFD26EF9E5678B1E16ADC0E6F4EDA062D
      F074E6E732882D837A59BB5565E5B9539E4F260A689CEE69FB0C06518528A51C
      894EC8738560C94390816E741A72D35772D0ED3BEF596270C2C741DE18F9C212
      20CEA048CD4E25DBA9098A38002BF76ADC4BB27E923756636831FEC1E90264FD
      F44D024A75B51A5F99C96BFE80FFB2E7ABEA7B922A598D1DB84AB89613FCCE75
      78CD13354E8D46500345C6756E9862E2C99A38F51FDFAA0017DE6FD306C3FF24
      A93718B64577702B721DC199D9D56CBE92438008FA303923A18131CC2DD8BFB0
      508D92E1B52AB5FE1CFE3EB13028C27CF9BA82C972A860E210DFBE2E134FFBAA
      F36B0F94AE1C0477360740365425C244EB7E87BFD51A56CC357B152B7E3945A6
      3604E91C140605F9CF6A4C3C37DFB5EEDE5482C797973F57FC0B6AA044E62ECD
      6E8076E0F848A37B76FAB19460BBACCEB65D5B8791398B49894DC35BBFF04073
      63C537624138347EF907BCF23D6E00F10DE39C1CBE557BDD30363A7D4516DD1D
      7A829D423D9F8968A5257DA1AF4C944C42627ADB3EB3CCCD0CD7E4031B8F2B42
      3FDA8ED25F89536DE838BFC424993D4CDFE3005275878B23065EE9883698A428
      BD462C354FD4C5E545C7A6055A3FBBE614F43C00E35213AD4B25FCEA296DA6CF
      9D668FB80151CEC11980C5D8502EFCB3D14BC7D98C60350750893B93D1C035C7
      3A12AD6DB9AF5C5962A53ABCC34A5505CC7F1743A0DF5DBE680FE8C072744C5A
      0559838C08A04415523C1C3BC1DC5C7BCC0250497A58569557FE418BD1480D79
      22837995264916CE9E98EF5915FFB37A2614E26D62C1B89C32DB9EBB4A1B5C81
      1C47C385BE689EBFE56623CD73BF7157E3CBE3E1A06F7E97A0C519174D372C89
      39BB4858F192179C72FA97E797EDEFE79484ADEA77972F5BC4031A049412AB61
      B2D6776808241E8746EE01FBA99414A1C4540A1C1492F8C8B7333CB548FD5021
      67171724FE2EF482DAFC50B2020120FCC3E4641ED19A4980CAAD1BC77ED12910
      665E380969C2DFB1849E470B6B460D67A4C2CC35FA5C2FFD56A0FBCD62B6AFB0
      527E6038489E14E83D5949D313AEFC8E6BFAEAFDFDD37B7784E9BD3BAA4ECFC4
      81CEE60E8F22F9DAF7544C57D6D2EDB5F462A986611E99574CA56A6EA54563AF
      FB9F7DB527D159876A7BA5103904B80D8165AAFD4E3232FA1A6922563A97DC7D
      6044E53D549D65636BAFD7E973AD9FDAFBB5D71A365A97EDD357B5B21650ED75
      2EBAE78DCE457788FF0C5ED554B3C813F5E94AED353F7DBA7A5553BDF93A0B27
      991AACE389DAEB7D1C0C5FF105699F9F0E89BEB2C8769D64B324CC1C47E8E087
      C47E56537F1F9A2C3F29E2894877810F58A49024C3EED9FA0FAAD93A1E2052F8
      46FD95AFED45AFF58F57CC0072D53D634B588A0FBDCFC964AEA3C850EBEBF512
      D313D6B4463881FFC5BFA3B5EA0C68AD66655CD14F05F6AE8EAD872F952B582E
      01EA1E27C19AB8E74546F9E71DAFCE06CC2EB61A3717E3D0C4792B895064429A
      F4832B0DA5386A184F93AF5EDA9D78A0486F39525B5B7DFA41EE067816CD8A3B
      3717F1759CACBEA30CD1579354CA542D6CB25AAEFAA15AAA9A15E3BA857E6832
      C2F6D0F008C5DC5164A7FCEAC3A67A963A94B73FFACDEF4E65ED9D9DA914496E
      D658DE07BC02F93F24BFF356415DB034E9B5805FA91D23C7BAE967E7CBE2F0D7
      D4F1E9A089A2D8F0C60CD3703633292AAC1AC7A7835F80B6CED79F96B354079C
      A267D6D71AD195E0A610A923B1FA50815854699FE98874C99B38811D860BED0D
      40B4BB74FAB9D3567BA7A9BE819BF319A2D9A4E2CA5171184B90611B1F1B0202
      A4DA7A81C9563FE37897A5748EBACF008C604824DC19802A73DDA35E112AD0A0
      3A5EA32C3D99EC1330D03FCDC9D2C0DE5D8AD8D539FC0E147A7CDD20E87BBE56
      7968A955CB4089258244D9783D4DA2A801FE12FA907CAD5EB84DCCF2EC9942D2
      D6ADEEF53F2179C7C13C1896BF143ACE8B85EA64191138DA13D54AB2C75594B9
      FBE0992967594477C22D84D50B44D748155654309D6DD67FD4A8468CD073952A
      B431B25F0135D788EFD63CEDE1377F1B5C5E103AD9B681428A8E18D29F69F587
      9DFEB96AA63940CD0BD465894DECEE66BDD2DA368C036256DA1B9A34D5B16AA6
      0B1D682BD80E0F5FFD4930772A98B45D1F28D307205F54A74A508E2790FE72E6
      9A7CA82E3D33CEC903A864E5B93BC80EBAB56A4B4341505F012E18126D8EDF7A
      4774D8D93B3568AA4778E13441101A882F4BA8C6EDB55D0124F583A509FC4944
      DA98E216D9823094DC50E704CBBBD0907F7411122D71C70B93CF1358B3CD20E8
      69D4EF0B163BAB51300661643CB431D0376698E09FE2CD25A9B97BEE2AACDAFC
      312985DE9A213F086165DAA7D4E4452A850A4CDD2BEF20F600931123C4F24CC9
      0F7B8CBEC247E1B2213C59AE6055F2B1BD57CC564D68CB7A66001DC1DC1C27BF
      147855289651118188D573BC4AE71665F5EA6C35164EE87DD9D0309E0D8AB154
      7891CE5D8D09BBB84FFF458AFE78DDB107A37142C77B2750E56A7C417C6AE11F
      C6F681C4960BCCD28E7E6A72FA07FEE4A79181CD650EC033A4BF69C086EC4EE3
      04C2149C912EB9F3814BCC5CC24A851B591EA98A36B330B354A800CCDC3D79BB
      32C8BB9C30A7FB09556A094F28391CDA4C533D5B9A49380D2742694F0B78B977
      F80AFDBCE7F531E145EFE74379F259E3AAD840726026114EBB5B35A2ECB54063
      6E81202A97DF0F5F6AF6CE2AECD07B54E4DCEC9DED2FF573593ABF0944570021
      5FCA954FB0CC2E16232792F3C5BCC840A32CC413C93EB8FEE66A9C24D7F590EC
      D412D622647AE89A74A227E6D4C46A3F0EA715900B73AE6337014112AFBBD19A
      EB141F2E5B2B7135E3C4B8E700C9487FFF004386B8384832F69BAD8EDA3733DB
      2905046A348B0FAAA7976B58647CF12AD508DE5C29BF7D8A031319E93D60CB75
      9DB2CFBEB01B5DC8A73618F0F244FD5DFD9BAABF3E383838702C89CC29C80C01
      B601B9EC08D57DA66AEF7F1CBE795592E6254B8AF7987A32ADCBE7EFB829CF43
      BD6D938D8983E01CEEFFB47FE479F3C5C305E59DE31B7A2F2EED3759874878DF
      C73CF4C155B30BE1F3C0C04982DD65D2504784BC22685E396C9D72A45C1FF7C1
      15CB58EB015C3C0137A6AB122349A680BAF2D1C11E448965001BC857A9E029AB
      A95E1A26297CA164CA544509A1BA8EA364024659C1C87DFD2F62BFF84BAB6A31
      66C9C364E944858DD4D27256E9513736C2F7C66C909A33E70871980B35BBF40B
      A4ABFF019670482582037006A5AA6D882046E29A80EC460588E81B9645A7A478
      675893DD4182D2F1E689B617421CB577B0BFFFFAF055598E28191E0BBA416BDA
      F231641499FC1FB0FA2321A70052B688636302B45E84C86F4E2668CF06DB9814
      3C084143B7A3E9C0FC5E9014D8750D87CC91F585B6F5451FBED10B7AB917E705
      97B9C9EF184408B80A7EAE55CA70D6D02A5A9A9BE4781576B1B8B810BC3E9E3A
      669B9AFF0B2C314DFDA38532BF5EEE5683F8F9795BEC0612F8B9E6CA85EA380B
      4B3563DF635D53FF3868FCE390F4C922499773AAC08BA08A292A8283CC9CF2F5
      09028B4A47CBB96E7C6CF76BAEB5EAE063B3DDE9FFE3E21289EAE1D9C569F927
      518D8D47EE245F1A6A7B9DEA599044112E304A456F559310CD7BFF0C7150E140
      FBAD27702C0BD86DCD3864E9967D71D54DB40CD2FF0959422A1ADABFF66335FA
      ED3E8EFC2FEA23B78128BB0D10653D339897BC2F347C0E4C333901CC6FEE84F3
      4EF3E9972B0B4B348CF32F82EEC158130189201432719F20453B9E5F9F235C02
      AD5A7ED9D374DA6A64F085CD6DBA2E382563086B272EC6BA12E84223F4EB30A6
      6C4DC9EFEF2B035CD3802FEA8CD9EA777EE815F760A040BCEA618DC278C6C245
      23FDB53475D240523C4E46CB75B8940BC63286056094244B2761C3D8A2D97045
      3DA549B25CDBB8C35A34A2DD7D220142EADD35B2B04CEC8E92D378EE76DF40CA
      860B5389CA6776458E299104F85B9C419F0B6EC3F35C0581BA08BB97ED8B2430
      5F546B0E64BCA3DCBF08FB3030BA976DD7D9E322644C88FCCE6F547BC59DC5F4
      457828A4761C96106467993DE364A25F8015D6D104927C9DA1AADD5D0C51C78C
      AF99ACEBA45625960CDBE07CD066394283F3197C30B1F6187CE3676288C8EAD6
      7A2D9D923C51E7838F462FFF8C261AD8F7FBE863DF5BFA656E0090310D33EF53
      6994D9CCE404C1A70FF2955E9A701E9BBF28AB0BE198296A602B5FCE131E991F
      BA433CF05EA2DB3251B337C5DFCBCE48A4A73CCDD74A9F16CEC913ED4B49A82B
      AD3BF127A243E3422232D184A35EA21D652F24E1DA07DEDB2FDC223AD872E093
      F558163993B70968D0624C897A72DD5EFEF5A5DAAB904BDB24FF5D731CECA370
      07E99E48B5E9021E50C3F56D82873345DF9E9DA69F2DA3307743D89721B0D81F
      46EDD5E9EFEF2FD4E9F12BC0B892A0203A83983A5B573B73B8CA31623743501E
      F05818C73B1D31563995EA7D291FBF01D68D7A6450183AC39449428028CF46EF
      FC56C6E4556B87CB9289C26502F1C89A4EEACA1D1D0D85FE97C24F460AEF836D
      A0C5213992DD977DA9F7D9F032A02961C965DE6C30B40E2FEB7FBC64D784084E
      A8333191826C4F73AFFEC7FB3FA270FCBFA23FDEE0FFA7AF3EA8641196E843FA
      94B0970A338A80E1BCD325143BE7582A05EB84B887AB7196A9A973B8C6338C40
      6173ED5A61E36281763F20C39D569C774DABA98E32433D4DA40590DA73D2D33F
      191415C855218E8727CBE65AA9ED34CCEE1D0A964FD8A1603807A3224265C6C2
      3C88A530CB65C4D444868A0C10C890D605EF0E0EFEEA7A1790C43BA45F94CCCB
      7F2AC93F820965906692862CDAC705D03B7F393C7AF70368E414F126A0798689
      4D96D5D45F0E5FBFFB89908295082CF88AF1A737AFDFA9C018D8B14B34A4415C
      82C20E3A8CBCCB3ACE41E87CB3519A665114022B86FFE2F2B7B64A0DFCAC8D6A
      41C19395854B3C954C66C7D10E6EDC6ACD555D9D9C9E0E1A27A7A7CDC6C9E970
      4082855B67476B116F9EAD4D2EDFFDF05EB8B4209F289A7A7236F8684180E542
      D51C2608F3ABB6731613CE4FC8DB54E57B94214365C5E86791DE01E1D4AC36E1
      8E96964795D372169B56AB304582E34F2AB877426461A7DFDFD3B9CF89931AE3
      D595C5ABA3E1C8049F74CCF716EF122E96697243A91D4F6301E1E2F742DB6B0F
      2E5DFFBF8791BE517B873FD4C7A12D2DB6AF5DA30EE7C7030B40FA7775F8FAA0
      5CD74D9679CF627BE92F2A6F18381A125BF45A363DF96CB86B16641BD1D1DDFA
      5AA33D9392688F27E6BD1A2C8D090AEA4987845F923AF8AFD00F3D397FFD06D9
      FC26D08A76E30EA77D4DFD5CA4499867456CAAA4F682736DE96CA283506FB0DC
      D3F946B60D5D431D577D33CDE78B24496B6AC024F79FA913084AB705F44F71D4
      7F05813D4BFB3A2E36357B13A9CF948E955EA7447BEB3902B406AAD9ADCA40E3
      B96489A0170BC59C1A98895E21316619CA880C9F2CE480F8DAEBC402E4293C59
      4701AA64B554A5F040BAC551646C69B9B2EC748843190A8D69BC75CC6CB5CCC2
      E6BB283F605160DF1DAF8194B884E8C38F67ED0D4314715C7266C494F74B717E
      033B3BD4D74CD103C3CBDC22C1C8E4D8C2554F32EBD4E45B13F51AAB87ECE8CB
      938E3A38387C4987DE5204C13DC5BBFEC67FFC4281F797073FF2A75EFE76F0E3
      97975E437E02A221CE87C947738B33374B512743464FB4E686CB94C4778C068C
      6EF6DAD9EAFEBC72058FB949110E6206323042E5B9D84664D14F894338B45A8A
      D77E91044477F164D3E8A24FE239CCFB204D9601E0B9147F16D7B0EA594BF18E
      45C7E3D463EE21126CDE70A8FBE694AF97402A801034D7F0EB40BFC71D859F64
      0C0A148280858AF8F3A452272E95FC7BB999CC63390BD42E986180A8BD22DE9B
      7C9E1419BE05C1455E11B99E15724B5F6001598DF84FFF8BB5C9995419179B82
      F86196A12B044139621D71BA0222A8C2D82E0EC70E73E87F51BF14E1E41AA506
      4C70C89BC387831DDC4FEDFECB8D94FC9DB4FBA524D7A14B72EFC0356A06BE6C
      53016C94AEC223A52D2DE37A931478CDAAAAA55B3D3711B1CD4AF3C5305749E1
      9BA0DBACE5FE02B80784E0BE303E116752042426D128314E8A441A4AD13493A2
      96D568245AE53B4F369FB26DCB3E904CB62EA15CBCCEAD991436684BBF2EF976
      06C5B82EE82E82361144E7293A533CFA8D0627875F04A8B091743F8E0AD37B52
      1F61E3E271731AE2B3A4D620638306B8AA33E8E1A29543EE142E74014EAA25EB
      E9DC2FFCCD11863AD504950A0CE8D82A0F2F71DA0A8B28B34B5A4A7CF80E77D1
      A5DF3D7A10A8B675A71A1FAB3CA51C8EBAEA77065D4B355ADD4AFA751C6C144C
      EF34951E0BE9CD8E181BB4C3F12665ABDF2E8AB3F26D47E5D120F56452B8CBFB
      1E4A591A330D2AAB457796CC2DAA46546D930A98E3FF7CB6444961820D82397A
      6C7DFF26F9C6C0E4BBDD08A2AF23F22E3E9780C72531BA4C1249337186D7A831
      F24E2402DBC33899DAB0EF45EC34C0EF750DD5A03786A95877AB3978EAB80B30
      EC6847D2C604B059C3CED96FA5B754A5008E2AF861F4AC2555CE2E05E94EBFC2
      9CE6D559E3A279C5548801E2F5684F7C3F5754CDC5C7C65420C4F54168088F7C
      371701F8C50407C361638378A1040D34B8F883635EBB708334DBED8B46EBB26B
      193B806609CED042A26C8EF494C4877550CD65E6DA18182C68CF89B8D9337305
      D95E9365AAB13AE09D2A4E112419A188FD4A19CBD20D36304B260EE27BFC1915
      34C46C7136386CB4CE06477F06A1D86A7C82F89B14545AF546791B6ECA46C830
      422C967098DD0C90D5F8789D9B8D112DE326A5EA72D7166E074F94898D64A52B
      E2D0F36117FA06D5292D444C2C354959B93287D1116F401F7CEBFFC8685D8D4F
      8A340E21C0A8FD1BEA0B78D4DD4827EDC3F5C4CC90787D8A87B52F8FFFC640CC
      6CC351D9E94CB6A2454E501ADE3F14D627535407CE8C2443811AF27C38820011
      702C2579CD855995BF2D43D1881438B826E305A813B35080EE76968669A801F7
      B3C789EAC2E924B1A57A179AFD2023D16BAFD97C1E9E74CE20812BB612C7EAFF
      0402AE4EB73B1AFDDA223D6395D96636A0C15B5EC5E855DC5D8A27FB13473684
      3552CEC07912E7738203D03563C68DD6CF7E6AEDF2D3C5B6B1E497D0E9773AF2
      205B38227E2A912255AAC49E66E29F9BC3BE8C5711D2228FD98C39BF3B0FBF62
      AB93C1476BCA3C48BEF6ADC3D7F76716E0375D8D071401B5718B9293E6D76EBF
      FBFCB460C47DE5CEE1DDEC5DD5893C03382B336AC08D1FBAC883BB6EE054CFDF
      4EE21CBD22763F0CC471B941327B776E9CD984A3D9E97689B8CCEFC20C89EB5C
      FA70A88F3A438D4C0E32C3EE65BB029E17BF1ABF2410B7A74F3B6C0E4723A16E
      82FFB2D98836894B34B6A758FDD82FEBC22FD1196D835B153DD8E0977B3A6472
      4BD9B72F96350A8208DAC696E049640BF124CFED2772DDBAF4BC88AC0709D786
      DE0ADCBA6CB03ABA5D20037619CA82C993A2D201C6D63BD9F7DB65809E24B787
      00ADE40D578F2DFD902A01DE207912AF11E38E46BD9FDBC3D188C82FD362993B
      72BBBB278FD80E9091FB741F85C8778EEA8A34D1BFB94168E03334477276BE48
      0AA46074B93696D0869B56ED30815FCBFB350030304FD421A915BFA0CA691B02
      5BCA54B70A4F39B8B08BD30B755492D5915EA267224FED6903F4CEEFF1D2777D
      EA451B57DF52D25C34CF9911D9062259169CE25772A85D2936EB353F5BFFF26A
      381A0D7A9D76E38C37D54E80CC353BB81FACE753FF62343AE7C7925543B193DD
      97AA7579FCB7D1A8C50F261E495E903217BFB534BE06FDAF83164EA62BD8A64A
      77325C0FF60FD006272966737578B07FE077993AFD9F47A3D5B867D2EB92C793
      EAB9EE8B21788D01EA89D1A824A027D502202B52821BD441B4275B4416905AD2
      C376D7582351E8B8E355B131FDFBD634369F792FD5E7DA5F7781CAAB7CBA939E
      4C655932D710CA7EF7D015461B8D44565B417E5F3F00EE5B90ACB08BEEE34F35
      8B8DF620EEDD7BAEF10702167C2CDA44BA4DC33ED5682D617BB150A36AD1D4A9
      C95B69B830A7E84056362279A6F73E35F9593CD58BF53DFCC919F783A6FA7DA4
      64EECC165DA2AAB37DA639129F7B1FE4784ED855FD895218BAD5DA79BF4E06C3
      41D59FA1B049D668A629F2C04EA83FD91BA361D268D43F6D0F4A057E84441BDB
      509C1214E14F1461C20BAF63D51D767E7DB4837772F97A1773FD8EB5C737A449
      5D864A8BBD14B6BB8559E1838C46777A3AC0D5DE60A9BD7F94E7E21D471A6934
      3ABB68B5CA9B2C39F90BA0CAA56BB5E7C93F0B22D38CF542D5D50BEA174318B3
      17EC3F72190FF5D019AF0985E89F8201B57143420872E2A4760ACD692C51F10E
      057018C079A847CCA09B559ADFE84C7103B09D426F1D38DDAD277A2822C136A0
      5331B7B2878CACE760663EB7708366EB63BF02B816C735507B73BD5C9A58CA8F
      B2955E1250065430AF76895EE0A5A9EBC51EFC5594A583D24E5094680B118751
      649B8FEE4445B9D04B06D35806828BE25AA33162141069D7364E720BB5FBFD5C
      C77EA7ECAA67837BB04E11CF75F6EA0E39D8AB733006B6746E666855C40D4529
      E7E06F27821471341A5CB4DB366C7BC7B0FEF3F8A19BFDF34B9230A351BB794E
      CDEE24D742948C30AE4897966916787DA44538F5FBE6F98998EFE54415D0FE0E
      86ED2FE20686525A9EF9333B9308AA5487503192AB1BA914D53C0B59EC5CA701
      67E39B576727D532145B44FCB4C33AA1E72A2D80A139BBEA347AC3812ACB4737
      E853ABCD699E7436D58B7AF19511394CE9D8BBBDB3695717F6C414D49B816A50
      EF863A9E837ED7C676C63A0B27F790F136AA64BC7EBE7FA5CEA8F27C0B94AA53
      650A01CD88C59718253CD577E7DB254B16E342C8899DF7AEDB1A224976AEC155
      2AE14E982063A298E74016A8CA21635CFF79CF80E885EB0F877850A37379D5AF
      E4798581C3C141D945B9689E5B1C8FC217462352B004661A8D7E3BFAC2536434
      6EA210181B8D9AF922C99654FE7BC5C431E1EC094232A351B3DBB2F8AB5E9A10
      F11100DDA05D48A6B0E4436B71F962D6C41194980B0D6502F56BB37B5AC1C7FE
      49CC9C7768E7EA82B2B5B5595EA5109B092D14B06E97541F27C9B56A1B61DC4B
      BE167F7FC43848C9DB7BEAFF10A10F5283898E0CA708767926B52C0E1235434E
      279C503D44643996A031B88694087A10BE00387801B01B95F64A7B31AF9171F5
      52060752F28E6AD789726FD81C7AAE72FFBCA9983A0A53FF6C900B5583280466
      D43B2DFDDB66CDDF17EFB7B5D438B189A4D2442A7CC8EB20EAE28C2902BE26B0
      773B2024BB07F93A3242669AEDC262D42AB23C59C8AD26A23D902C7CD9C22658
      EE3012A0FC4561638068E224F5CE3AF137E2100144BD4735689974469E50B5C1
      D82854F653B15A9E00746D27097C7BA5DD8C59A9960137A914F57BCDC52647EB
      5BBB515D76B72AB421E53E59536817AA5A62E336E83A4FF2869A83547FF5A634
      B8FE453C8FEF1A87FB3FB2F14DAC2BAE618D4A2D93E30E70D8AF15173B83D7AF
      EDCAB10101DB466479A35A99994CFCC4D67908523657B86F5D36147EA1910CAD
      D456FDB3D73838E015DE4962AFF47A90B5725D7D5CF954AFE7313A3E50C9384B
      C817FBD6F3BE750860BB310B135748A5598EAA47C6EA42AB2FC560C201F41F02
      F974211106F8AC18D777E079BECB79E8B5968E2791F1389C786930BEE0A19CE6
      371ECB933B1E70BAB1713CB038234BD41621F294C4363FC8837FDD557FE4708E
      938ECB2418A5BA27656463B0D6B5D7B15E8413FBC1573B0CE748B4A2044C4086
      BC289353F923D4F5D7E3A0DF783C91FC21171645FA56D686AD2B2A8610AA49B0
      576E17ED7FDF0B38FA4ACA7409992C81549F8870F5494E2477BB2B031097ABF8
      1F9D4598A3EFD3CDB95EFE838ED63F4EF4D7E8FE1E254D8430E978F0EB0331C0
      47C939759EB08BCDC473441CBB4514EB6DAD5190868A55CAF3B1C32D3D096F41
      F049290838358E46BC723218169AC44AC8727B3A826EA30639A167B3A993F096
      37D735D6AB7FF5F52A7289C4D28EEFBBA1929983F21F4DB0B5562082AE1C0EB0
      A77F60859E94E2B2BE75C199515A46DAB8EE7C341F6D77597E9D81500FEF6423
      573979BE488A2AD8A6E621D3A3CAEAB31D052C3940FC24ED45929BF7C4369691
      5BE628ED93E934649E902489326620582B8D5E82D335771223D5C38DEDF4242F
      74C453CCF28429E40C33D7E2EF58668AD50B271591FC524B1AAF5963BE9DD3F3
      46875ACAA1CC8B2681E647215942681EF53D05C2958E72CCFEEDC95C05125987
      591EAEC22088CC47767B51ED0D560E87F923F0EFB5519FCEE0B42528594037A5
      E5D26848344ABC467E7956A974A6BAAD08C48AE134DF40E752A70F8A2271F711
      E4DAE1254A8CDA6F506491B8D1C38AE83815BA01375A49247CFEE45A9339B243
      D9902DA9655745931809A7EA8565540E5E504699716A3B00249D967C21FE31AE
      E2A73836A83D47B0B707FB9F0B0BFB669ABDD89117CA2C9649AAD310E11FE93D
      008189534C2C624C70808469A3D9EA77280EBB7453D8C5191C747EE12513620B
      4800D4EAE3303F4DF1BF10EA53956ABB7BDC6F5051A1300C705D993FF2519855
      D1373B4A566A7F5AFC51F648A25E578EF4712F9B87CBEA2FC81F3D36F9DC6481
      F64CA49C9DC885E71CC3A7CCA4E21A1EA97F5387AF8F5CB8670F462BDA77AD15
      F24C66AB07F2A3A3F297ED0645004A04CF577AD1783DFE4AA7E8E92C66214EBD
      6DF3CC54A5FEEE59D39204E1A1F91CD1118A6322B1A056F8573E376B521C41F2
      3DD2FBB11C5B448E287C2462F01299AB7CDB05C6DEFB498C92C1CBEBFB55D22F
      AF07086BDB82422E7C4224F0E277D0B6BBDFEDFD739CECD0A8A63455BCBE6EF3
      9D7EBA69135EE127682C8F9A5FB2DB32BFEC95246A9E581614D5EDFE18C0AB40
      DDE3D8C2FD1EC338410708077DB1271B34E11ABF3A1F2F66D5E43FBE9BA64E35
      10FF4325D50E76E05F0EDF1CBD4546CCE6FCEF146F66FB8EE570A1D1C3D9D83A
      C12DAED5C79AC41BA431AD7E07A014F1BC5D8123B82533648CD85C8F785C6A99
      13E04F6AA2A92B2470974CED44B1CE36915FF5B811C70EB3C3C400C81B8DD4AF
      C32E9007D6EBD1991ACE917C525D7363A2DDC6203039C668364FA19AC9A0B6D6
      8056A79FD0D0DDB23F6814EF4DE6A492E26455EE8AC4B44E4DDE002C942A5A19
      8D09C38B6980F02861C0F39C32910A0D0AEA830617B5A711D68E072BBD44A5F3
      3F5C569DA20698A4BB690429F75EA84D92862FDCD9D26694357A7A23A6A297D2
      879CEBF3D123324F08415783133C439D1C872DCA6643EE67A9E1F2F3F07E6B76
      BB5F3619196063C9C297740C796299BE6C8B51870BDB7FAA813F134911C40195
      BC5826FC30B7878482919259991B7513A23A3C49C9D4B84185249310101063A7
      59F53BCD0655338C46DCB1DC5980746FCAD80B77720451A2745BDB2CD25686CB
      3829846039891AAD9F779A1DFCBF49AAB3B90479C8EB25464C1B964673FB544D
      E66114A426F61BEB13E40637CF0AD4E58D492386D9C93A00A83C271A41943B72
      FB0B5B3FB8C3807C2F845046EE056D739ECCD010C8B56462940F0E8405B2F9C5
      652C83D40955DB92B3CB781F6E87089C167E57B63A257AD6282A99EAB33B1CF7
      FBBBCD044C91E086CE32A21DA31689683395A8D3FEA79E9A1B8EAB85B163CCA4
      FA0ACD78AF3C49A4B5315BFF688D07E83F4246BB4F8C3ACAE84C7D4E113FA9E4
      05096487BB610285E6B099DADDAA881F6F55B8968A7D23EC6792547CC84DE1C3
      66B38FC01011D3D69D47E14A41CE211C06FE404B4CE18E4049CB4AAA91726F7A
      02879B45557887D7FDCFB38F0EFF64FB484262444F2ED79572581CDC61D22B3A
      2D8643175660A193E5ADA72E7108AB46B377C623137188D5200CD8B24D888FD7
      82C7CF01FFC92BFCBEB653EA2E46061FAACE49FF9CB474E7B27F26A80CF8DB08
      88507816C8451A6B87A14AA3A5DD1C1E8D46D4E0494918948B691876C1FD1A39
      01424B1F2347E6AD23EF1D5C5E8712004ACC2B05FB8A53721048620B3ED9A8CD
      D1C82AA6B6E1E20A94F8A16B309D2CE2B0798241AD16EC27AB0C61D662819A36
      11C39C16B3B3FAFA1600F172D21B562B48F7D5673A182B4815F0E8AC34414BD1
      173BCC223D26690ACE5D001F217E42A022222AF9D6A8FBE39BBBEF2D1B8EFE7C
      DFE9F517C1AA6CB8B2FE8EC8172A1240092205D819C757A234B35D9EDCEA5E0E
      9FE9C9701C47234435FF8E120E0EDC52071E34D2A2A1A8C7BA4D5E7C8DB9E27B
      FC4146A083C985CE18F98625A479775F509E0F77909EDF6C5DECFCFC7B3B773C
      CF9E7F7DA8E6331C82B75FB8ED72592F0D7FE15C67683E869A16DF9778F3459D
      B5BBB6D2BF079037D5922C0A894598DB495410BCBD5ACD4E1188929D932A962D
      7FCE2E53B938B5344ABD61FFE26BF8E9EF7BA89C36EA02D7FBDC7FA287DE07FB
      56ABB16DA04947FA6377E83B04CE52AFFB9FB63CAE898D39C6C6905EDEC5E278
      8603CACAF6F2F86F1052ADB3939F378348673147442DFA15318295F7F2D36015
      56D561EFAC55E35A718A0149568410D9BBE8F1CFFD6E9BDE874BAB3AB80768F9
      80E454897A22A73A4E006B80462F2B1D24CBF96426EA6CC14855B813B885336E
      E5BD1A2348807DFCFE0A83AFF7AAD9727DBE611AEF69831FDFAB33A637FF5F1C
      7CFBA074C81F786F7B24C85F5ED1474BE67135D131C28054FCEBECEC850EE36F
      18DB773249E294CBF3883B800A972580CA7F750F43AB086D9B650825AD606418
      0E41E10A7C07B7EE9B438BA3F0B5C1E3CD4E11D5C11F7CF47F26053D7381A66A
      B0F610F27DF01B9D5B2042B6699B373F73A3D387FE4C3BAADC967E78E8B3A999
      28A5B6F6F4C16F1C9BED1E28F70FFF6FD2EB0469D3BD97CC13BE6FB2C5CB57DF
      9CD0FB7FFBDA69A567D7D4FF38E0FF3B798267BDB4CFDA6962D5177CFC334DBC
      BDD63ED193C5BF2E277378A0EA56E57DDAAAC2A4038F4A4C74DD99AA13335647
      EAE8E0E8AD43CA1FEC1FED1FBE3B78E74912F497C3370718BF148ACDDED953C9
      ECB268F3D45468814F4D2E350E4267417161EAAB989A2C8900F2965E2A9405D1
      28C1676D8A768EBE6A6D7B8204CC10E411C7AEC4AECB20F0F28D46A0D2D7C481
      5110968913B04230A1D193A9B91288D50C2C59FED9D472676E01A2DCB4A90F3A
      C9767A010924811519B13A6AD5C3AF147CCDB5FFE63179FDD38F38A62E2D331A
      FDD2FED49360091905DC87E670FFF0CDFEBB37DEA3A0AFD6D73D5FFFD9BFFE96
      F3FED4DE3B651F3683BC731DA817CE727EA1520995D0F65149A628CD0999B965
      4081C2184F948D459F1897483A7137948DC9D7AE24EBF278D051EECFBB0C07A6
      10494EACC696888C5E19034528784DC3AFF77479A4234A7E5CC54184C7B0E303
      518D5EB1E4296545E45853851AF59A442F07360BD910B68A1D8715CE49A2522B
      96048146330D3E17FE30750BED7DF3459D742F2917DD3B39432EDA16EA306925
      370258A87017777D2B8F2B2BF950FF03DBFDD7578DBEFE09E139E98743CC77CD
      61F3E26E13D43FC34DB0DA6E4F8B9E23DB50FEFDEABD6B4F07D87DE53B1B4AF1
      DEEF7E503A43D70FFB88F259F778105851A145B216F71456B8A412F6010A9C16
      36F315C6B34C45E135282EE4BC4BA10BEB5C49B87FC3F27E507D6DFB491F94BE
      86607CAF86037A0BFCF041E931EE917CF9BD1A2709F1D5FE9B1AA605BE331E90
      32ABFEE5049D965F6D2FC2BDAA9254159666895EDE4175E89A284E8AFB88C684
      3E058DFCE314FF2356E3D91701FB74CFC00FED42C61FC14FD03BF650ED320B4A
      B28E8D89D1199121CBD811A6C5B59FB61696B4F1AC0EC69D4FE4F9FBBBDBF7D7
      FF32FBFEF58F6FC4A479FB85495D82674F1D50CCA6DA6A79700D0B6222DC475E
      CF3C6B5D5E6C3CF30CA442E4A052245E437C003F4CACDE7E01785095524E6C34
      02456D150F65CF0C46966093E5DDF0DD9877EF1EB60977B0FB2878566A56C710
      32B4E4289B847EBB8CC494E176A40D8A3E11DAA65CAA3BE88B521EB67ECE760A
      D692CE151A37C0BDA31BA09881BCF10E334B4EE1E272D8A970CB16CBCA0DDA25
      5139E8FD4DD2BCB6EBF73799EF1FFDE0D1E8042C66CEB482B309F88425B5DB29
      340B4B7D7F329948B9C90EC41E65A87734BA689EBFDB6A308AD5D965213A2760
      BFD920CEAD04DBAD65BDCBCCF9F47F1E74078DCF836EFB091E09CE9FD188987E
      4ADB1F008932FFB353E0FEB4FADCB37886B6242CCD767CB45C13FB68D4D0EDFE
      D0BF5F5E5668BB1931E85A868C99EEE009AE4CF39C48DAD9A1BA4BDE54238D0E
      DF87D19CAEEB4B399F5D76BC7FF9373738767A07278BDFE6E4043B612B6C705D
      41298208D20E4F45A192ED7B551606DE98793879122920ECFF6D92E0021C2500
      320085049A7D88B4EB51430C3B7D225DA36A238B3551E77AAD34C505BE81D178
      5CA218655C8E02953B040FD7CB649710064815B1A18414CCC3605DFF1A4DF9E3
      A678767E3A689C3787C8E1957687D3433B3D9A3383A488AD28D85172712D5B2F
      4D443B701D1BEAF10AD4964D89CD427282C07FC72629B2684DE5B574F2076866
      A8FE4A7824A971232A82DDCDFA7FFEEBCCFA77AF1D8B4FC57494A8CDAEA62384
      1CE9B6FB7C05648332CB5F5A2397C15E1F34F2D9ED0ED11C2E4F10E06D75077F
      1F8DAECE0688DD58910B5391096305DB351A01E965E9BA37DB218A8220DC2BA0
      C289F605DE3B6D8F69B541027D9FA6F73A43E1BFE80C496900A9B1DB6249B276
      9C26D78613A5685D4EDE95B0F361D6AE75A0F7A1FD1A86EDBE46B7DF2979D0C3
      7B34EAB0DC753D458B28529DB8583C592C915A856F78031C98A53CF9E382897E
      11CC73B471C555E8DC228A41F8FDF07657D7EDCE05577531B0BEEF827B1DFDF9
      BFE8E8DB663C164D2E59A424550B1384C562A7C6D3D227511101A7851C80FF71
      8A84DF34BCF54B22B1087AFADB033AD3D1A8DBEAB4BE11AC7EEC0361209E9A1C
      B8985EA4D7DC1F4FDC2F4EC282FF79D86E96F4BA9ECA0201D6E6D5790FA065B8
      300EBE88119A57E7ACC76C0914733A58D4A6751AF039100D67390AED9229B373
      34AFCEFD3689F21BB6D307DACA0D47A3CFA7D4FB6800C9E4DF955EE21C4F7F00
      4ABF8373CCADE3D38BF7AAA5537DA363868AECE03BF0D3D12C8973EFE7FDCF58
      7E48C8DFA9D54B868A3918E3205AF12B62201BFB2CEB09F6ECDC44C634F35C4F
      AE69DEF7D038EFEFF02EA726EFEA7856E899A9A9B3ECC2DCE6AD285C767506FC
      655E8379129FC597E965915F4E7BC9CAA4CD7491A41F7526C03B7C0D57C3A467
      F1B1C9F2E3228C82965E2C6BD49A253B8B3BB74BD45686A0483FCB642F9A373A
      8C10346327F42CFB84787A33CA5B457A638652EF7787B17A8757BDFB7644C0B4
      E676247E8BD83D0434CF76623AACA9EE51F5174735D57D5DFDC56B3FB6C22400
      230FB16CA36CD3F16746269EE5735AC070AA42E825E6E0A27F6A694FB0CBF938
      03FF565FA744E061D9FE31F435EF7EB6CBC3852D163240699C2A29FECCD73B3F
      14CFACA9E66291A06376B120B95DA36AC2B9D1DCADD3FED0D7B9F9B494D2D6CA
      EFDA285E5B19BD4C623B315FB62E9E1AB7838238EF9F5F7A3DA7D33B39B29939
      AD26B82A2AA7BB1232CC1041051C38EA09B7C354ADC464B186A77AA3457E78F7
      0C727EB02C98C3E46AD8F955B8C3053A53A14F0E1294C25BC328F4AD172663E5
      4A6243448025E1961D30DFDC127D6C6D6D52A5D0D8CD6EEBE368D4EE0C866A99
      64B450FB3B0C8346399249A03AA0B2E72A2515B7321CDE18E38AB71D3C550886
      1ED92B72717C1B84750083009D77C7A947E5D842684313A8F46E9A50630E4C69
      270FDEB251CB532B9665A5EF89450567738DDC50E54319A0630B3B653820B4F6
      F2DD9D1051CD8BF646C0C476D690C849A36FA61A3DF06A3C834D67889D648E2A
      F0BA125193EF3D7F0B5418C94F5D44EC30A4323CD9A8E0A9080ACA95C14FB71E
      4562774916CEA97ACF5A6E09AD54C0F3DCF3CCEB69E27937B88970A010C56145
      81488E673E79D3D9AEDE1742AA223A4C7C633575FEB13DAC5100A92643530069
      DB31F71710EC94938BCE9E393580F90CF960F1742F06D761FCA2F43238BDB953
      50994AA8A8ED5AEB639FA19A576116E25A131183ED3A8D72F89DC6718FFF1574
      F7DF8ADC3E429501B6C9163A117D85318129CF9300614415C6E1EE6184D9BF2E
      0A4B8436ACED4E7B97A78DD3DEE549A5116C92128904CA5CD7960EC17B2882A6
      1244AF42CC4832214F6C8CB3B30C278ECC0B886DA678A245BB32336D21C6D2D5
      5162E72027FE2A5BCB2366863DA636D16E4696F80342DEB8BE0D22AF8842B822
      B5363230DF0E217F7B42AF01296780B583BB06EA786DD92960FDA0BA65354702
      FBF7229C5C0372457C93D8375BF2EB3DFEA1DB2ADB4D12F10EB283080E334F56
      97D3A9BA39DCFFD11737FFFAF573C452A5AB637F7842D78D6F5B904C04896E6E
      F352AC4D24A59EA3278402515DB8A043678930E0C2269EBE1401E7544654256A
      2244160852101639196706863CF261CBD44CC3DB46564CC106A483A0217D71D0
      9AD2649E11FF5E9ADCA0A179157847D948A2D0C75B5A449F58D23B6A942FF6CA
      08E1B16BC8FBA2190449ACCEE2C0DCBE703C0C368C35368AB847F4621CCE0A18
      743A532F04A0D44A16E330E68EC7FCFD1DAD6F8B94669FA974F06054CA9D756C
      5908BB1504E7A54B97C4C490B4833781DD4502E2ACADA224B92E96E2D543DE78
      DFA1E770B41EB8F87F3BEBA9EE85BAB81A74A40B88BA797BB8EFD92AC12983AD
      519AF19C46B839DC7FBD7FF8E4EF90CCE3787D5A84B94ED5CDDBFD83773B8C70
      6A720A8E35FBCD08F265328FC309016019AB09081962336621E57D3522BA4FD0
      1008A5F670C06220FBA920BA7F7EB98BBF6AA1479CEB3A41139686E5AC206231
      6FDDFD160AC121BADF9354B537BC9901955522B1416138238615FE7B063AAA3B
      48282F4369FA7843C91A0E6FD4C5A9173D8F4E277394AD6FB26F69A6D533B779
      0A4E0C8A3EDCBCA3DFDDFCA88E9B479CDDFF9731F0BC3E78F31C126170F285B2
      01AA4E0146E9B06BFBED56B20FD250AEA6FCC7B93CBF04F613E2929699E0102A
      46227432D75876E82F06D7712B381317DC3160077C4DA9C706BDD3B6ED8F27EF
      A91F7855EF8DB2955A6FAFFA7C75F9DFEA584FAE710841EC33E80AEB98F08633
      10926C137084E1C852520E05274407E76DF21DBCDBBCE1ECF22C34FA073D1C89
      7FC4B37F72E6E445AFA5D0632E7D38FFFBED671E3A54786330E8B016B91C67B9
      9E589AF03C51EDCBCB7E8D92373535EC773ADE83B9BDE2022017F220CAEBF292
      793FFFC7CAF37106AF2E89491376B6781B44144099FAD9D8A1932BC475DE0EEE
      216F0E0D7B17C32D8C87139863C440C6BFF777B5A458F7F517D464B1B722A77B
      7BFDBC3444F0AF73A50FC8698204B31C2BE75D4ADEA0E82D0D27B9FA04168E21
      222D8EEF2F3729DA8C466A61E2C2BFE92E863FDA1ADE620F4F7EEDB51DBE230E
      D4F9A7C1B0713E189E94F966EF3111FFE3B8A4D4F2E5462FD455FB04296D5B72
      8B9809094E34EEA0C3C57D1F314151B826D8A978EDE8A7379BD2AB6FA45F85E5
      F388D0387509B2AE402CFD9DC5DA11D7DA3EE0257FEAA9FF697D65EF415EDF91
      733674B211A66913D75D61D45568568FBE03E57EF578BF1E32912C1E97096BA9
      9D2736786EE431513846AF03299BB05D271FB7F12A0845C39149450FAC70903D
      342DB2A551DC5CE9A4B92CD2C99CEE583E4F9362266FBA0F5437F85DD37C5248
      D9147F81113492D8E7D7217187921C9987D0C2EA283237E847F2D09C1609EA5C
      271C619838D64E1654140198EA105D5854843431327B341CA57489B499B35B1A
      144976096BA8440FA906517C6D9B046304D72CCCF2ADE2A43B5C0FD47DE80990
      4F93C7CB591831E56EC333219A0A75D57F68AA1415664F9CED228C5DB3394F59
      118E55CBD3682039A32FD4E0E741472DD9450D3339AF4083F14B689019938243
      9B82CA14FF6596FBD1BBAD9B2E3245E0580C9EAB640E1AF6FA7B8F47D52A1757
      EFEF975EB159210F4C8E38AFA3FF9BFD74EF9B5D4EA7A8AD6A6344DF47FF7870
      EFA32DF842755B9D5EA3D9EAF4FC4738AA8E5023FBCF8EA2E3209BE8A5F17FF8
      EB4DBD556124DE34BDFD47207F30CC26268AC495922ECBB0BC763BB13F4AF2E0
      0BD919442F5642D89258582B37D92D7EDA7F7BE8FF323FC8CB482DCB2776C124
      67977DA04205725D766191238A337221ECF37F52F57F571F75A60693225AF291
      DD6100F21AB859A41DE16DAD1C84A1554EA3D7544F2309D1445A352B0BC12626
      3699A5933B39ED11FB9EFA0FD5D393EBFA59ECEF069313DC6A5DAA5F098BFCEF
      AA9524698040ACF803988D34146BFDFC32533761863E61915E23E24277A5A6EC
      9368BBA8208EA4A5F7D6435AFD56BDE3BFB6BA2DAA95ED74BBDED6D596F8E05A
      3B490C785EBA3DEE8BC5F67D1066B80DAF545D6516BF82C86086554BD82ACA76
      57C7E3EF50C736702074637D22032DD5325165E888FA70DF71C9BE6E10DEFFD8
      BD8383C3FABB931314B4A3D927F72A7345D5F70DE878C62924AAAD10B17C4D68
      09BCFFEEF01B646A301B93F43A53E656935589B36A39FEEE9FEA465F60173CA4
      496C4DE170FF60DB4A387AB3BDDC473FF2729FA1031852DB0F4D9889ED2B0DE0
      3709952A5D9D0FAD198AA45566A848786C363F210B585309202CAB903A32C1FC
      24C3736C24162C218574ED829B9269849909BC778AFC11C2D71BAC9DDA2E1B4D
      76AAD1CA9B301D5862B7B45BDBFFFD5695EF8D7EB3656B2CC099028CF806EA82
      533FF036927461174FAF74EAEB7E1FBD859EEDD3CDE7CEC2D2994F5D7CEA76D1
      ED91B9C95D27464B0D840C422B0D17E6348982AB30015F43A3FABB8D1F2E9218
      62C3B737DC5F0E8F7E80C4234AD34BD9628E23896F8CA43235F383BD006BFB57
      9C86FF74C034BC81BD53F5F8FF7D73F0D30FDECC69473F409D0F061DDCFC1FDE
      B024BB231D9F540613D7AD1D22AC26FD883B0DB838F80BB1C5DCD331E6B6BF72
      699258BD3E1A87F9934E6B92C4D30811A22CD77991619111F675A7143CEE39B9
      7E8ED0D2E56D9F742264CCF5BAA8E0EEEB20E4A9B8E5A0A2534645112D2B9786
      5442E20F40503D27740913C45E19801D3EB22C465B8468A5D79923DC22FC3337
      21278CB7DF34A6546A39C68BDE9808CBEF96A5AC379346875BC84026E59A5027
      68266A67EB7AA3F04C1DEEFFB8FFE36BCF3BF395E90D5763383C9174AEFD4850
      9AD49EA29C7A30D5333D354F3928B5A1AA804DD48290DD185176A6D23CE7CE01
      E71D8DF54D3863472D4F8D41A2FD29A7F862BBD9FB0B9C2EAD62207CB84D02CC
      12DBBA862349DC2899672D7FA8C93ABA32B930CF4C347DB44E7B8AF0C021451B
      6D0B58F09118901EB1C255274774F828F36A912B047410BC85BF3A752E1E39A5
      14D2FE167BC8239ECA802BD7140E80F68759631EABF85DADF517B5D229AD851E
      C394B3FD41897899E899BC477AEBD6A4C22340A5F9BB8664DEFEE464B04990BF
      65343BB5D2442A88983445274C5283DBC50506CD2844D786A7D7056CADF7FAED
      010627A6878AC47BF40D789415DC8CD7AA3338E70EB968EC8AEED4E12424064E
      73CBFF7E656995F9FEBA7E2ED660259ED75CFAEE96A62B22D2B8EB957C007923
      9946FC74BC16676A01F0D898780AE90F0455665380C38EF627D24BAB34CC7313
      E3EB8E375C8C49DB40C3F523851D6D3D9B89C081C76BF54BB3B5AF4E741849EF
      E800C071B5301AEA449AA77268D8A05199D8F0E12CB6EDB19DA14E9F0E4B7D48
      51174CF3F1B6778F7BA790816F9DBB87366CBB0C55B8A5DC33B2D2EBC3569224
      32815F1F56CB7943F54D647F6CCC16262CAF0AF730D9D23708FF52A2ED81E28A
      6F4C000CDD1B43DA5ED415E388D902797A5AA6CC9F83DE8922F716B459DF2C52
      F19A114C595264E01037D4FCC7F96FDC518A8E09A80A8119D5D3F2DCF94D6360
      729708BA3B1D3AAF0268C40A942D3AD01A026C76B878497AD6F61BDD99210F0E
      5FB693AF8CEFA8BBE6E16C0E297A23887476BEFD37A54ED0DD737D6DEC84963A
      D50B9CC19AC82D97B4CA60D6AF93A2D22F193FB976C9357E05C27D405A307C35
      BD56674300F62BC7496AC4362FA074C2B4891354F441A38CCBDCD1D800F1488B
      E3AA54EE6BE5F75090E333ABDA87633208C04C4DBE26EC0C89A8CDA986D03E53
      8A41709F2E739B3B4BD196FB544421F926DC99AF88E113404524295F7182EF70
      758E4D7D6F490C36574BA74FE4EBB81086B92236B768B5484B34D790EE5B47C2
      2B52A7BF1FA0E0694D1C1CBD73F9E96167D08AC2050C86F304AE4A43F5901F55
      5D2E2765DF849C4A2D3575587550C957DD3F6FDB0C41879695C90468E1A803EC
      EAD44C5393CD995CCFF56EA3B9D48968CF1BDB72F406B99BD3E393F36A2B2FA4
      9BEAC04753D9A91ACC8DF18EA6BC796D0D25501C8D469FAF9AFDD188590290A9
      881BE79A31997FAAB3509997E01A51954016BCEBF9EAFDE837F6D1C2EB1B706B
      A13BFEF0EE77E5F157E57E62976DFB9292E95A2D9298CA0174A4CC744A0CEF53
      B2A314B8FCE7499112647561D45EA5FBFBAB9AD21122631405C5ED90369D9098
      779ACD03676F52482C0AC2969F48D2AC464D1A5DCC1672DF99895553CABD1474
      403E27A78E9C3B6A8DBB05D8DF16B7094C9F3497E5DC0841B84E9235CAE4E055
      EAD9F4B05452B0B7B9164CDE934C84C1C9219EB56F6ECD7784BFC544DC6EDDBA
      FD803B3B7B2487A36FA210CD7F60C730E23CDBCF6F1F344B65A2B52A4B362D60
      0838F67299265A7A434BF945A5E38FA8DB2C29D0A1956D7E31725DD759D04073
      2F646BD097A4C8E50C0908BCFFE8F73C83F14ACEE9D06439425D87D480C0FD74
      A03A8CDE78E8D5BFFE652C80E85277125A4596278BFD300E6DF303CE0F046196
      9A994E2139C66BBB9E2C9EAD254D1D05C894B18B902776AD6057D26A3DFE9CC0
      3C385B2C709FD84270937C997109DA9D9CEBF6AEBBF32D712F2A048A505AF981
      83830BC4476ECCBE3A0D6FE092A01F78F887A9B1318695F9E14D7D8C8EE065AE
      89AF0F4C2B295073FED8DD16B70F6DEF090293F5210A8C0626DF2238DB7A93CB
      78F3E0E11E436650C50A45AE93A91A837383C36F366D1356022AB49538FF05EE
      BA5980C341B6FF0D76EAAD3A3D16C4B0A09B302BFE5A8E1680240F0F0FD4228C
      0BE47DB968974A8DF7553302ABF76C6EC134304E330813E9C89E262BD4345075
      1AC93A3BF11001F419DBB5EC876439D20D40360737A1108FC32240791B5D2B38
      CE50D59C2A55459C0338453145A97CB6E55A76108AE9252C5183C76FD1A01867
      08AB21B78E252F960F5E354415B3F22B912EE2C91C0284E6A627FF1F71EFDADD
      3692648BFE152CF6B9D7541745CB8FB2AB7CA7EB2C598FB2A6F4709BB2BB67AA
      BCCE024950421B04D80068593D6BE6B79FB577446426408AA42855DDFED22E8A
      4426F219B163C70E1834CBE7462378ACFF9BE6B24E21DCC1ACEC621255095450
      AACD37CF2FA4101C8901FBD60CD8E32C8664AE142B0545222530B1DA4817B25C
      995E15BCBCEA442A5A51077954CEEB34BF8DBAC6A903DC359DA512A7D9B1B257
      96561798EABD28A605AFD6BFB3B1C7D2B7D175918224E745CFD331AAC6B2FA15
      7D9B3C014CFC151EABE6596A812D4EFC289E49223B53B9A41768BD1F9D60DF8F
      CA3903CC7581734191127C87254386093C2B3D33926FD7F1BC424BFF9FC64C61
      A5AAAF3CC5529CE784C8BE26441AAA0A3C6CC9C65CACC3B5EA3C9018EAB1E417
      587D9AB37836C3FF1F2CD4636BCE13F2D8303DA61685B40783C2ECD19ABAC097
      CDE2D11701DC13EC100063EAEE58FAED34666AFAD45D6569C93B61D74BE9A98C
      9E467AAFB26218673DAEE25D91B288997BE9E2EA9566F937801167E061FADD59
      2A787ADF97E920BF2F6FAE09603A6989FC74AD358EEC5FCD865047783B68E90C
      A40F2C10A4194AAD5B3A0983A48EBA27EF0F073BF6FCEDF011DA61A4EB804C23
      FFE88298B643BB4CFE1B31A587B5A3E24C51F797F3FD337934A322F6B92DAEEE
      2F83C1D9C39ADA1FFF23664AC0208F67D139EBD277CF5DB3F8D0E57FE2AF5177
      70797EF8C061D492CF52F498020F6C4C3FB622D05DD43D7E9C96F4915A2155E2
      7861DDE9EEE0F8F2C3F2A6566D7DE5675551F7FD2F27E73BD17E5E4CE36C8D61
      A7C17A414D1ABFFF6DFEC3F367CFFF37B4CF94A0819A1158C4C3DB3AD99D14E5
      2EFEC11C64FDAE801E7CA1793E8380F648A2450A742CE01C77BF0C255CD31135
      A70557E9C2DFDE890EA05CBFFA9D4E26E29B1B8AA550F698029ED1DB6C9ECCCA
      144561D359B5EBCC3B621292F9324B156ACD3D0CAEF4F1F0CB64A7C4E4286AEC
      00073F86725884BEA33C391FAF69BA32728E5CF5619949B1BAF0E6764C8E93EA
      4B5DCCFAD1413113A2CD7552591C511D8795CD554932ADC2126AB4A778F1DCE3
      B629E32B0ABD6060EDEAA13DA2A41E10A081975EAD41F100A35002413B143A4E
      41B85B0E673C1FD731EF115799CB2E077FB06B32BCE23F0C945811933271D120
      10B706A76AADC6C088D49A42C813E5647240F00CF315D3B4229B4A6B75E2FAAA
      EA723E62EC14EE1B1055DA1164DBD27FE923534399551C0F346CF103FC467BA5
      EF49C830A56F2FA90B141B1B2733F09F50E9CEB1D8E8538D08C0C0AF123123DD
      89F35CB2DFB32C48C7FF9A4806AADCC245995E31438824F57A21F96AD1F14FB2
      78081C943E3315C292721A7582D63B6F500C5EBD19BA7E62C2546E98E8C47D8D
      B3740CD8436F59BBAF7BD1C12F228923E0465D149956218449ABCE4A5C55C528
      95491A26F50DA65AB900B053681EFBE09CBC6C99609D347C6B193BB296E32971
      8F685F8AD8E210EBB5F868058C6D67768F9932E12060F9064E0ADC499E4B9303
      9ED817A1580FFBC2D69CCD92985246B012852677568CDFBA8C9074023813AB66
      56006710E737C330D4851D4A2C095BBA5E098453A7256C4A8F78BB5370E23C9B
      C6DF69E4AD9CFA13922B85A6C5E593E280D19DAFA0130E41B5BA61144A2C12A6
      DBD7388790A5160E1A635640E8158F443AF40D07086193FC56E75C1E25E78141
      57DE110F0AE0FA7366D736B42E784EA71AED26C081C02A7DC4BC605C24D7E65C
      7AB6BD8A1C32385D7375C4B25BFE4ADAE484DF707EA09E673B7E086F1F913BD9
      C9BC4CC469C978428ED2723417AFA617159800CCD9DB0467F738E675C37ECC73
      8C08D73D2003F575D32CDB3567D69F539B1FD6073171C468FF0A3BB28EA892B9
      02D9C18C28BC762A9EF0AA45F2B14EB3F45FB69BEF7EAAA60A45EB3023B3C567
      F3725688668FF9E38DE94F2B86D9C4191815F33286105A74082C00216F402C4A
      69883131459D8EA224FF9A96454EC510095E8ED87CF3D174D18A1868558AFB23
      0CDDC8AA18253D301811DDC304D74999258CEF4BB9CFC924153521A6EECBDE46
      7F6C1F379C57F1F97A0AD9D28A980BED294BA7A954C1E9895B434B00DF65528D
      0A8A7051F9B3939E8EA8B001C01866C974D1F3BFDB960CF046A4B6BD1708A42D
      EBBE188A5BEEA423716E98A508C6F4A27191381A22719506B80929D2C63C57F0
      B68369C67906404FF3EA0C69EE845D3E22925D76F08806BC0E901E27441E8361
      1846CB17BBE1CF9B6ED2BFEAF7A2B38BE73B3D6B533AB72B09B7D362EC563401
      82FBD9B9718614F3A4FCAA5894308B42CC83F733C575149A70317EDFA80EF7CA
      939C039940C0075C4281C1E2ECF65FCE68A56D8955E5EC1AF76208CAA4924614
      6E12144BC4830CB4C1A364951202C0102FC5536EB0EDC8EA133C7D6C869736A7
      8C3BEED1007B3180019277C05D6E827D156715957FD27C9294140034FC1CDA81
      0E9F91DA896223E645F4CF79CC5D1257D5BC6448C0D0A960BC2D614ABE2AE6B5
      9EDB5CDF1647B6090BA3BE6C57AF7C7D390D43FB90355790DC28A1012B867075
      5DDC5475319BC9B596DF46C937F534960E6D685EE03CE1740354A9EA640A4533
      3F30D2CF2755942557F10876EE386116B903524A57A20CA9B0A88127E7A17003
      F43D88F4A4821335872A880F1068417CBD98B89853D32991B168D8D701667EF0
      CBF3F5E919EE7401D7493AE92ED81BB2DEC0A025594162FCD003C1FD6AC74C05
      4AD12DD437B1E7B8FCFC7E947D18570A32974A4DBDD91C533DC561AEFBBC7BE2
      D94B3401D31AB45539D014312A26D189072DDB58AC82B08064AB9D35E6BB9262
      619710BFA12D4DB803F3D16229C07DD8ADAFE37C371D27CC09674363437B7B2E
      7A23ECFA748A5BBA6AC167997FD937F788CC4D3422B60BEF7FACA0595D26F174
      A5DFDF2041196A6987197E0C01C0146A90E42E592BEA32C538E0AECA58368828
      2EFD739E44F3BC4C00387186D27C97879066A6F98754FA94519C63F10D4318C1
      5108F5A8F2A3C20D59DD714C5549B3F330476E51EC89DB7AD2ACD57409960DFC
      8C265ADB30557527D32713C88E8EB17694F688770BE490DFFC22FB98E3A13EF9
      4910E875B4CC1053764C43EE5E79182DEAE6C1EF7868F6A6E05DE7BBD4F19172
      BAC2DA71C080AFA6B01D8C0BB346AF3C6D520E297841E28E302008CC7F01D141
      2C5072071EC2FD825ABFCC550B80D2FD1634202E726358DD8049FC2D379517F1
      715805B18AF6F6BEF17FE091E182C453E413EFF556DEB515B75513BC1A9DBA87
      8DD9C41B572D9543298E21BEFC726851C6C7437DBD053CD41CE1955B5414CE82
      936DF3F7B1643B077C1565642A698B95EBEEC8D4134286E03F061805CF818FCB
      986AF016C2287EA47E5B99DF7731C98FF77D8D13E259B259606339708B3E9DD2
      094B3A806B5EB27DC110EFCAF54778E508742602432022BA66EF617AE350B1F7
      3DC31E7E2B9EEE7A2F47DFD05337C6CCA98E86C5B77022D8E759595CA788FE2B
      6C1BD23DEE0711F394AF42EF142E19C121FED648E6EAB3C2E86459BC0559E78D
      4725AE7C855AFB0CAE112855BA6CD66A6D8075EA1C708F95FBF9151EEABC2E10
      C6568DC3F1787BF89CC31475A88D6DBDEE7819415948E407923C2C37ADCB6D8D
      79A6DE6A2440FC12A4300C33184F4579BBF9505E98FF2F63AADB6C9F6936F178
      F7226F111F5BA3F73691CC511F5776808231ADF040353CC0AACA6E9BA3D68B2E
      B2F1595C56F21F00B36AC8351037E247EB86D56C2395CBDFC53DD28FFEA398FB
      61040046E953B8005FD82D5785DDA2BA7E80EFC7DC3980232259E0A36C0E920D
      5E515C5F1C4F9C79004B2BAAB02DD9BE042354C8437C3CE7E4F2891A62085924
      496ED81290E119D4025312B9802008BE4F43195F95D429EAD457B50F67383744
      84D6A377C50DE03DB9B16F70F9CC789C015D2826E8C9CC13C1903A4D49EA3AAD
      F1410900043BD4D355AA9B145218604FB27794B1C6010BF86C89B8FB12DE49C8
      0CA4B303CC161EFA5C6CE17F601321D6A1E5AAF139FD12E53BC2D4C0E5A4AE52
      3E8E0D1D2723CE302019711DB6A10DBA8164000C7C9E4A784AF41C2A48409795
      2D9565E5115CC06328CB82CC08B04BE42293013580EF1EE7E1A549AF46FF0E02
      875BD99BDB92CFFA52DF4751AD812287EC9DE32EB33237F1D9375CA2A1C52BE4
      0AB80C063D63348F06671EF2D66542EACF309980900BA318594F0E45E369CC91
      97ED4C2D741A0E536A32CAAAAFA22E7E85CEE9137648A99223BC8AEA9B02486B
      9DE6605C4B191F5CE7962A802381CE3BDCA82C6943E8349B2BAC7B6C657A4262
      C41A5629BA76A852EE926DF0052106F1FD42520873103737AA9FCB5460B0C9C3
      0C9CF1376416587297B37841D1615A7B8F25007A51528FFA3D8E20DC32967637
      9F4940FED6E80528A6FCCDDD34CD886D036CC6D921DC3AC9E7308D46925D4AC7
      35157F7B1A75039065FE73998E8581B7130419601EC160E00D02FF4E4F995287
      42FA4736715CD5BD76EF65E4694EB0D761229CF70EDCC617EAB38286F0A97BD1
      9724A1CBC90E63CDC9FBE9CC1ABE8265FFA48A4AB0F1C0B36A6F050E87189648
      6118F7200298D649203FEEB971C2ACACA2D8EA8399C84C0FA26671893FBA1051
      750B5F1CEE91B04F15E099E7E45FC1052B6F6D827C13BC053994E81C9F54B986
      7BD1B570F4F8A8742A64439A1CBA871B9224CBC7B44C5AABC647EC952546F440
      3B1A6120970DC2E67BE485EC9103E3388F6E15691ACE19C67F139DFBB5211DD4
      BC6CB33BAB0840A510A42D2FC92771A3F3A8869094F4DE89388DE75CA48ABBF6
      C58D00ED3302F252467053A7D053205B346720DB5BFD2CE23D38EB4573902193
      8A443F191B2022C9342941477D27F11A0F73070033C14E457D674860912B5750
      D93B27476F30EAF19901818109C24B2BAF5CD1A1F7EC0DA970032C36068C0540
      262BAE78F908EF14D0DB1B5B39552F62545B62C372CDDFD9D75E70DDBAA33FAE
      9A9722B79BBB8C2D0FA1400E53C548C0D2CCD12AD123DC726C7B1A2AC08B0977
      D7A5360418BB3E2A2D35681D1EEECC7E9CCEE29A69732C562949689332215753
      1981F720E18A19F1A4828D938F564749F228939458E975E53D01B92B7AFFBF5B
      25815AE779B15A3212A40653471A267932111E451AA42C88607C5A47495CA5E4
      5D1851F6B6C13FD03822DC34CFCE27BEC810AADE8722D2A94B6C56029B51D292
      1EC472D183FA820ECC4A885E4A209EEE97685CDA59CA135689B28C668861AC01
      FA8D1379AC96D3A1E938446752C062A5FF9A3CF96ACAC482972FFCBC1FBD979A
      3204D7701C494110C759D9BC8B10588DDEA7728EF3C82DE3AB27F993C3B29879
      88F8DC4B5B5C2E93B6585CCB5C99C56C374B482A2973B927F1319B64AE3EFFA8
      9F4AA6DC0EB550A219CFE8BA46EEE37B133AE0F2914F2134AAB216F6B480D903
      E71F0400569071661C39D2C9A4DEC5E5B4EC8DB8F5709571EC2D2624CF6FC2D4
      623EAD3C65E1ADE2F8A8996652C632B8638CEA42C6EEB2BE145A58CC8E230157
      77032CD8C43010749794793F187D3A56CAF484948DE0F23DC1452C68C9DE3874
      952DFAF08CB09829492FA61C6BD26AC11377B4E21180CCE5194F2A0381158526
      E8DB1705FFDD0608C58A32108570A3810C84141FABB06373D060C07BD95525D8
      201D86660EDE08BDDE7CDD9B28DAEB579B680384DA70C12FBD2080E667E0E441
      42A2687161664800B3E034232BBC58782CE757D138C9EA58E424252D059518BE
      84EC43FF4341697174AA6CB9A23B211DC0D250FD580D6F831EDF33CB2E78D565
      697693E2F5AB7579769062BF23D1AE35C42A9C87F01FB676111D8DBE5449194B
      721B167E9ACF792334F667D0C7967A118CFF8805F4DC72554B1F172B0BB4E938
      6FBE6C2E8F062FDE44674559E2A819BB85D1C5CE23B8161D5850FC76657421C8
      0C95A464584F752B6912CD455DD7DC8EE64E86248D66E0DBB37658E8A7B1F2EE
      9DE7A80A4C6BD68CEA8F49684A147D7A9A40E457921F31B79082B8FB6E9D542F
      B8317679F8B93505E201AE05485D0086EBB556D8682EF198BAE0506112EE97D1
      B93F625A87AE273DBC0EF5A01FAD069ADD3B51AA0BC8BC63E58ED3AF30FFAB16
      9FD79DF82CC7020D671AB86099D1E36882753D8C439D82BC47891CB041450448
      A08B4AE40DDDE9EE42CA233ADD7A545B8ECA13E337F63169C3321D5F29C5EF2A
      9E9990344BC3711576BEA6653D8FB38E8BE95A8A29D7A49EDA3D49DF95BA0740
      E7D8205882067B3B88401AB8DB495931499FA42BD1CFA8192F1D39129BF15052
      7156520473A22932C03AAEE80F5FC3487F005EC1E10041C3E0A57FF9BB89D808
      2BD6C35D292C575CC90DB2D99D167749BC4E6C57C3AFFC68CA5360ACA8B815A1
      09B7AB8BF22ACE75DF458EF707E4A2182321C4AD104164371F43CAA8311BEBE8
      F4D49116B0E55C4DBED531B69C2306A6E038FD9A8E9588604E69772964B523F1
      A2E930A123A0AB21963EC8E032AFB9A6DFA8E68783B9D33C9C35457FE980B7A0
      0AAD8E009B23EC9CCD1D29982952C531F6666FA20F9CCC493CC204C21D104D81
      BA8C811B4C8AF20648B29EA336BF5A2C89C66715BC5CD8A77C2C0A948A9469CA
      865F0461778437603DEAC9053F4E90DBA7CA3B0EF8A4D0E552DB739598804924
      28F4CB022B342925D349B7272DC7CB78B8F182B227A9DB70F46D164B31513E76
      A583E30F056FBCF3B52965A78C3F8932F8DEF25841BA52DFDBD6C5D595D0FE2B
      583DF88DBF537EFDEE332C925F773F47D5ED7408C2B5542770851142EF832DE3
      6659B870BE24B7C302EBC0175AF80E0FDE6D90FF901F562025D0BC72CAF32A8D
      58200EC7A6E4ABBA4A372A0716935ACA6E881A261616638058BFB3A4B492D0C3
      B81237883093A87B259ACE6E0A8498939B38B86FCC5858BE78EE9EE4B7F3EC4B
      74E1F395794E1DD465863CBC75719D217EEC939D7BD175918DA33109F058EE78
      CC97044033C3F4984CF5348AB12572BB7B8409E032647EC4781FC9C41BA04AE3
      E076E65252AA64329790942B7D26FE8DB94F02A424DF6204B42C15825305A28B
      825A30E8833941D3262FA0A22E0B13808C89A0E87633F42629EAFC1EFF5901F0
      F25945E1F3330013F319C96334CF6D812BC8BDF9641E6AAD7495B89203E123F0
      4EA1C16F60EE1D287E6A592F65E885369D7B08815875761E7F7EC54BDE0F9B16
      0A2DA3B79AC660BF71149BA149DCDA8B5F48E5DED0B858020208B7DEAE52B78B
      B4BFBBAC99C9BDB4F9001EA949E58ED475A94BF93551C779E56C04665D4B8633
      3351168611C3A656B457B711BC4BF38E5D067898851FA87F31E5D03DCF4571EC
      6871D320A75220C220EE93C3857DEBA1CE01C5A4B0662649321EC257F5247978
      FB2EE261581E779C070EDDBB072F47834A3ABCF9648809B37B0A6C6CB3196965
      14B9C1DFCDF80CD721AD35EF626438E26D4A40D9A2F14E36BCFEC02832549E0E
      4DF6E0F4B1A7214F494E39131FA63FC3C38C8E43905BDE44AC5AF2B281E1D041
      F1EE0E66763EBD87CED927A1939EE4638497110240470FA067B5865FC328BCBC
      3E2B51E10AC26293E26E712DE24024B61869B5E2F9EA5415F8455E74780B6F1B
      F20CD70773154DA7C99850ADB3AF36377DCE8A7182F7F3DB84A53516728A568C
      D147121E402AA0A2C1C5E12594359626492F323EF8752FD1D7C80991BB21D0EF
      43356E97C8842521BD96A82F4F8505EE2D37A97B80879E8CA30A9F21DB352271
      785CA8111B262BF4F354925B19B4B7744A995A7133251F2C788A794C0DE6FF08
      D96E9E06E230176708E8CD0CB685BC2FA8172A1941CCCC5449397C44BEAC21A4
      0F73EB52E3CF68D11275D3C74AD873986469A292A7529B1AE5DEDD6D6015BD76
      6314433033ED3E34A1E41B8F0311F18E2B9C072BC32153E65B82C467B8275F6C
      56A43441EAF6642AA0C8126392ED9266827C5C330BCB477FB42742CF9B331FCE
      9F1E5C01F47264A36943702B4674A9EDB1EAB4B0A0996E45BA3BBDD0D410DC0C
      180711D71445AC254739153F80890DCA8BE2E1A5B159293E4B66DF0D94F863D8
      E2881C36BEADC59A4038527F8095CD2DB10D787290518B7170593886B8C1C654
      23CB28EFDEDEF7A943F29E5C79CC69B1D4625C6C9456C2017F0F1469E0509E91
      5C7E56B161A5890CEE7808F6B90A785CF84899F28156BBF3C387DB1920EE719A
      D765319E8F4C4AE89B64E534043165D2C116A3BBA2B41A8D6AF4A2E95CFF8C3D
      6891879EA3E8D811E0AB22F9C28F9A226F8933E47570E590D7412344DC677FC1
      B59E3515728E0820E06EE33947D907B1D8490852B538AFCEC462F4623862F958
      6A76A3C8870FDC847D3467117186DD381FEF4A3844122B7465392C22F3CBA84C
      AB2F34DEB4B4BA1D439A1F198EB8C7ED8942D89BC6B72A2C8FE41607FD280CE5
      753A17B310EE1C6F999BF8FE0EDEBE316041BD70A543E0CFB3EA0725E7D799B9
      534B2022366319A532DDB8B89465AB793AC2A4B04E2F5ED16176C88AD9D44A91
      7E3675C61648037E8549F405831E72038268B0018160F90733B038D0340E9334
      2818D08F8EE725AE744048FAF24F2A29B3B14B11FEC57C3E11BFB690372BAB3B
      A120A33AFADE3B6D70BE8665AD843BD51F938DADB8B1B974C48C729CAD52AC0B
      8CB519787451F7E4FCF86227BA204DE244C28DFA9DCB62968EA2EEE1C9FEE9CE
      3DE20B725699296E00AF37ADDE4427E71742693B39BFD85F6769A179DB5E8107
      25C4C13CB9E9458ABD0577AC1A0C8D761635B668650B273548910A6E6A8BB8C1
      F0B7D5115CAE2EA99FB952FC72904E1088B523B14003C6847584D12CDFE06977
      FF2A4D62B661EE64EAD62A1A1B4914757348A0E26FDD9B8A99A7F2C4B89F39EC
      81E51E9E55701A2712C9610D91D475CAC4E49B4765F8DB849EA49E1855D2EC86
      B495966A9B52EA9F0B9327870699D5DACA9126AA6912A5AEE6CDC7F1C00B4550
      7F4AB0970FEB12100E035149DE4C8E5E3489B57E600B631657BC24B5E50A2EA6
      8BF2541474E5EF1D39255C797AD73BFF7122A7907C0EB7CE9029610635FC5A75
      67BD4851809E07E42CDCD2FAEA2208C3B241CE8E55FAD8F6596EA60C19BEE5B2
      1917FB6DEB669834ECB3BA595E10C2C9CA936783FEB4D545CD551EF465EBD603
      9A9970FF39D7A2E12110FAEDC204AF4ED3501F88B7801E6EB0DC90112B803931
      CFF9949C76644968F0DC244F35F827C233E27BD1F05E7E6F07AA97E23C05AE40
      6B9DA2DDDB627E8FE30A27B03BFAD71D52FC7670A98B3D29BDB87309A97AEE58
      EC06A7906A2A45DD3219CD4B647A38DD474DB6722761989E23823FFE1823774C
      D962BE1BCE020159349ED7D74817241BB24A98CB90BB7C74D32BD0161B5937F8
      4E51F694795A51FC7CC0C8C6CF479F0F7EB9D730EF6F36CC2AD92A1005B027F1
      02F9003FF2D407583DEC8A3EC6347E240AA615A5E02A7A951AF5136D5BB813DE
      EF9A9E4A2F84C10C4DBDF3E55884EABFB0D55BFDD601BE51CE9BD35AEBA6FDA4
      2F0F60863D675530351744DFB1120CCCC0960207EDCB6B9694B00DC588CBF578
      E3396C3627E19DE6CBCA679A64102483E91DE7C788A3C8BEDCCB1EB0CC23010E
      CE8A310B9E69987E6DB48E3D3407D3185C0DC3A917AC72AD38E0D07D9C259207
      105780A716599E469C76073D0BC237AF6D1D9CB124E5062483CAB909EE4E0215
      EA8F2AD2F8C37396B2BA78197D3ADB3F54CFC2AE65A9C8A7658EE88F63306631
      E495BC2ED6960DBF8276FD603EBC2AE3D9B5B805CC63BF098AB8283DF6A9BFE8
      B76CEC0714B952B51B79C7BC70E7A7CDB2E5D004B1F0BA88AEE3722CCEFC4374
      2CFFF4C38F2CF1CDACA1FDAAC27816B9AB36C4BD260EB923348CA3B76415FC63
      3EE5E181A369BBB67FDC7BE9DAE65A35074DEA20C90BAB92609A37B74620D945
      A2008361D302AC214D5366163F36951E45DBF6F187A57D0C74DB62590F182FB0
      FB2E5E3C3D3EFF2464AC713A06C2EA0B720157393F39FE4FBEC72FC7C7FF0925
      E7C5D362F3EEB1A6A874EFE46CFF309A6BB168C92E4F7372E15E5C6FF7F4677B
      2C05BAF8F664F8E1DD557F200DD435F59DB5B29FF3B3119A508C851401D80D5B
      F6EAF9F3B0740573DB55894C43A2724CEC7F3A3B6C55EDA4EE292A0A3DA030DD
      0B16B76049EDCED9CF47C7D16FBF4567F1553A52575F344E7EFB2D3ADCBFDC8F
      76DD7FEE43EB10AE7032ED281E556921559FE283405E7FEB9EA1E81C32EF2790
      ABD6E41AB29362D6E6A6EB6D253983AD3D486A6434D29B55B25E8104B7D3D0C0
      3E397C78E5B8435F394ED6D4BF7FE585392BA5EE519A47AF5E0EB52C83E03231
      B28A7CF1223F95FB9FD414F0616C6166FF0EDD84302B0C082B872B597A5CF22A
      43B8A339390CDCB00E93D0A8BDC789CCBCDFA16B97F1D02CC5DC85D211B87F4A
      8F8372BBA9AEB3DFA179549B024E0341A96D8B1A765DE193844F36E572E5034A
      C45DA235DF648F33AA66CC93476953F6F391500BC6D1DBC1D9FB87556A5CDE80
      54DA39FD34781F75196347A5D8599265D58E052D1EAB35DE429F61A54A011E17
      07819179F6F3E08F2C36F4C3F7B0E6E4E55B09C220FA1858A7761DA38BF00484
      FFE70CD8A605028A70B15D29D83F3DDBFB11F7DAE5D1E0E51B74AB1130DA3FF8
      70F4DB6F7F3FBD38DCFAE16ABBBE89CE2EFE7C2C08126B7B2097B2C89F826F37
      4496292FE947DD9532C6541F556AC84B843A070848D66FA2B74541290D9F5E50
      17F88D2983E80162FA203A2106B06FD553CBD602675376AF8B14E9A93E558CFD
      30C966D769F4EC59FFC5562D01584CB1A31EE569ED2D25232BC3EA426412F214
      1E89B26973F1737747592AE109867E1C71BC2B40EF4196CE4880DCB967DA5B34
      F8725BA6D3687084B2654A2C8F4E71D9049CE3FE2CDE6E5D9D1737F0312BA9ED
      3E2A0A1A0E40AB8212DE0C415AB17717BAD1B6B76AF67D89A0B244B34D4A5256
      32B83D78371E042CDE4C22DB56ADB8B3B09A256D61A0F5B5C7F266EDB1BDFBD4
      1E7B6899BE3D14A93B06B82AA52028DE1475077531C3FA9202BF47C8F4F829E2
      87F2094C82BCB5C4EED1EAB3E7EEE23A30E1B5E8E7A43EA94E0EBD3823ECAF19
      D2AEA3A31C7E01851CB63517D12A4ECF5F2D1CFF595EA57AFA57ADF23E38FBEB
      79606C012FC32A192639CBC4A8CEC4B68DD3B83F71641948C5886628E248B765
      9A65E9C8319F59CB56641C346EF7BE2C90DBBE75EB7875985472BA2B24E0C92D
      298A114AF1F1F994D831A909694E15F6E8F4E2E252BD5F3ABFAACFFCA8174C5F
      0B632BEFC3A2EE5EBB8CC701A003D1847549770A33F693EA7FF3B78F72281FC4
      1955B893E378949C2326985526613089FD651013D9789426A95521311FB91EA5
      25AAEE6AF8803406C43359AA4C8AFFA126425AC979697701EF8C47E994156A1D
      CF5D7C4AEFEECE31D2C3540FD915C456E8A49E97B9A19F289C308BABCE3DED42
      9DDE47798BC1E0E84D747AF2F3BBE806B9E3CA5E3B654CE9A7E8F4E87CF028CD
      5812F8C1E5E1BE8854E382ABA36F176F5BDCA2476FE1FCD323B520B7E3755183
      EA6F882DB8FFDF1DF4E4FFF7B31AFF16BD0F7AFE2D046F212BE5FE37E0CB3FEA
      067CFD9A756A9DEDF3F4F4E873B41B7D54B0EB2C9EB1986F524697582DA21DFA
      FD8F5B36465416B91617C32CFD8A4BCF0000AF2D893DAFB0FFCF47C75B36F423
      AFF52C65B237897F82A519271D75D024279F4213F3E1AEFCE7965ED81E60B398
      154E595E9ED4739E6498D99BA2CCC615327B3589FEF0F4C01FF04482247E146A
      92A80CE7C38AFFFEF0EC4530995AA01155AF7882A1308D60009EBD161D9802C7
      2FA0AF91559515DB79EA7FFA8170E2F1C58B37D17E3EBA2E200D47298FFF377A
      0F26E969517C29E6353F826636971AA23DC224B1541515BEF9EBFEC196DD7889
      65673984BCB63CC66FE9A266EE60C27C20DF59E66E7D3E4DF37FD083DED661E7
      909C7F4242962E95688C46A6454E756242EC4949791D1486BB4A8A695297DBAE
      80EF015D4AF15DDF5E36CAE75F62AE4B91384C29B19CE6D1F9FC4BBC7B89D582
      3AE7491D7D8DF3B4DA12E5FE812037444BEA7466D6C338AD8499033E81D40496
      9A8BDBB6216BECE51B4B18BA1862824864AAA2EEE1F1C55BC3103D94FE358D23
      1CB645B9AD39FDC3EB67D85ABC8FE4B81AD44A4CCC4CEE5A4CFC6D9FFFBD0229
      EE5278215E812690D34D6EC0E3BAC2B78D98C14466E1301C035AEF4FB361B003
      FE9C177FD6E5B96D0B580D62DCA8488E32248B39DEC9F9F5BADFDBFAB1DB86E1
      5EFA0BEE733400DB3ACEA46AF6125A1C573DBD6393F4DF36BAF563B46BE89B2C
      3E7DCD785640307376AD7A198A342C77326E1F60CAFEE947BA996E0919E15748
      0EA514442BE4FE394FAECB748AB360DBA630CA1F602278E68291F970B44B695A
      AF07882AB10D4B7EDB76B16A0F3F3412917C3819D10C505C79CBCBBFF6C763A3
      151CBF787AFE69DB767F544B4672C84FD31CCBE643514CABE8809491F0ADCD6C
      C5D06301D2616BFC86541D5AFCDB2E38C6F5055340CCC9B3F8A8B515A52871BD
      F5C35FE2E13F27F57972E3E25860BF4BEDE1BD282EAF58D55D3924F6F6273743
      A69C0845244AF3D97C4B00E1C7973F2A78F1F2B3B31EA5461F793D7145E691D1
      0725FCF6E9AF8303868BB70D01E36A61D9E819FCDCB10615A5FC0EA28BAA27A8
      EEEAB6ADE0CDFE3A4F5158735E17916832EBA13129CA51B22B690451E783A831
      5F1C0F2E19FDEC6CD9A450314E7F96A8FFF1E905F2F427214593F5CF04FCC0EB
      CE903909CAC6B60DE232A3C2B31A384D29EB32D95554D21B2A414D3EBC34A5D7
      BA92B5EC991C08786F89C2FDF81AA7E3F9FB83FF133DF939615DC58FB3E86F49
      0CFACE13673190870ADBF019733BB66D0B2BC9003E576B41AEBF77F1BF90AFEF
      B610598E0A11497A09CDF06D5BC654D33D8ED29C8A7DA8C2C3E5344E46596CA9
      F252E76F3EE34EA2D90F3E29FF61F9008F0B772555E6C51351924622BC823061
      D5BB1257527C326009B92461E3200A5E6A7523B73D43EFEAAA9E3A4787100A43
      AEC9E00083E9FB23BF8B3A47960BF3926B45640F26AC23B3D7D110861E191DA6
      AA88360C06B9EAA0D1AD3DDEBBBA7E8498489C0D8E843513767A969462224BBD
      DAC0D7614E3048D548677315506C36FAC30A696F658B05F9A8DD3E0D4FD7A0FE
      3C555B44794F3D77050AA5561155D6F9BC47EDCDAB97114A13584A8DC3E74535
      56A5CC7D5117CA0A0B61E9E5031DF8BB7AA4CA98D0F7D53C1A488A19202C2824
      2AFDE15C3169F5EC36FAE73C9903C08CBFBA8CCCB8E6337A01B1DAEA016545F5
      B8B3EAF6B359B9A067F30D90682C456BA47EAFEA704DA8A96D8495DF83A5D795
      DDC9F0978A56A2A7E70023EA42CF213269F23863A718C8C62D8502E5B202CAEA
      0F8476FFF4C3732076FBA4C20C0647EC14CB62E548184ECC7B52FAFBB6C7F69F
      7EDC837FDBF9985FC35F8EB3ACDFEF772C4A4B490D328DADB6D934C9E7DB3684
      7B584432C847A4A11A9DBD3BBC0CC4CD43AB0E22D3622F0D70319B3C7C157511
      23D83DE103FE0670830F7121F9CD23C27A6C3A913F0CF21AA911D5A06B101EEE
      788CD761A4D1B352665076820AFB8A989C4839DBC16E6285A0D8536FC52233BB
      CCA08E33C99F7683B039CF98438CC7AF4CECB895563131D2572D21B9FB4FFC1C
      36F91B00A1D8E6D4A4751D51F55F7704455D1CE84C4374D5F4D4CC531A3B956D
      39CAB0C98CC8A21C162DC23A70A29D388D5757ECA5A9E5F24FE00AC3EDF69942
      88C3F52294B50CDF661CDFE457736441C1FB40366E910F8B92CEC8FACA7B9E1F
      A2733AA2BCB59B34D8C5F4C8BBC8BA4005A99B9DFE83C3092FFEA870C22BBA69
      1FA8633E8B73BBAC4135DCF281A4E16AA8BC6532BD71D15CB15385B408D97ACC
      FFD3A8102090B38A2D3738B8387D50E8F64FAFE8ABB14684061E5D466DD56BD3
      53B04B45F6695F2A1C21A42C32613C3399B796E473D902B8125421DCFFA89180
      BB65975FA1CB54B08BEB68AFB7673A5CD56C4E36A054129253258C54E83D62A0
      F196DCD957AFF7DCFC1DC6D3F80A1E2030CB8498258391593C245FCF2147DB36
      251403F15A4F2ECF24C6C273D38478F3A8A48F4B749DEBA599622FC9DADBB64F
      90E4BA80E87A7434782F26EA59311611C56D9F8AE0C53EA9B89FD242EA12A906
      9962872267A935522056058A67F8A65BB6FCE3339DBAA750C505556546D0908B
      49F237442990C737AD3746E9B3381F57A37846DD9C8CA53015072B0DCA5098C6
      81A3F9932D71A15784772BC86ECCB98650F44C7256F92F4DB7F0A5AC689456F3
      A1965B419E1A8B366F3D4884E96F674CA4007AF0D3E1F9FED94FFB79AA020197
      B7B3E44DF436C631948E106F7F1B6354EA74B465933F10D6A55A457D1D0D63A4
      CF62055BF63F6520B1F4A877250AE49589500BBB936271451155D338CBB67D73
      42AF026A9F6AA5DD6212750E13646D544974F4CF793A237ED6B1C1818F5B8C35
      60B16DBBB07F0FA4888E905CCD0B14FBF020035887FA03B7150AAEE35F75C97F
      C148FA1B07A04255A66D21BBD74C5DD1E269D385E26926FFA3B5D35889C26AC5
      D55A88725E6D0925BD7E86B655C4F86B70202439050B55A53BD916AA7AFD1C07
      B6009D3E41960C392C2972462090FC7170B96D033856A83775797EE683D28CC8
      58CE2378F5695DA3A227CCA2792EE59D28BBCA746039F5F61E80C9BD7E8E8BF1
      F4E2F067DCE671CEB3429A0B3D4DB99BBF26D1F9C753166044A95BA48D114243
      ED5D0B216FD98D178421939BE8E017D434816BCEA7EA50E0A4509D4E99D63143
      0EBE568992C47CE0EA0168E1EB17C0295D0E92531349890B81FCEC13F02DA159
      17BB6625310B29CDBFB824C7A24CAF982183D5E3E2AF285D84BC54FA0EDBF615
      27BF1497A6C2879C6C741F24FCE42825822D4E8AD19C5A003E91D73911D3624B
      A3E3F50B7AE3D3617A3537E105861A9F54D15F3F0E2E0391F72D1B78797703EF
      F70F7E79840670A01CD89CEF1B1BB4D988615EC1341FE09B33F232B76CF97B1C
      356E81E9743DA9F05F8665A9D82AB3B675210941081004B6493AD6B256D04191
      001AB31F908FA69752FAB870A0A3511C367C3F5106458193B705C80D280E165F
      5DB11AC896E1CD3B7B40900C6C8DFD4F6716CF4D6394928B12E8A443BB43ABDE
      313076259BB247409A422352094C95A8D585E6F75C39E427A026155F1812D048
      10904ED69B67BBE050D05FC1CF10CCAC407DCB1EF75501F6108800D4E3911E18
      F62C36062337132215A3345631CB21478FDA9B770E74EC2AD8FB6FD10F7B7BBE
      6CB2D1080418447666108A6E5403923389378BCBC8B7D8982F09FCA8BD6F9446
      D1D08904DC205D0BCC50420258355107491F789DCBA213CD20232D0235FE97B2
      92C452F0E98C8FDAE3C0AF07DD057D44829A52F77857575F4418E151DB0D1929
      F853AAA99DCC95CB0AC89E9960AD3B19B9FCD27C974AEA2A83A146B7682368DD
      1BD603DDF2B0BEABBF69EE7783B87C903295E3B05155CE723C4D9F46C901DE78
      D09530CF8574FE2012F25DA757685E189B6012E8CDB9FE6A3430B873FCD72924
      7B0061FA1256C6444B15F8B0C603A084BB7AAE18A32F0C344D2BEA3EFB4A78BE
      52A1B1ACD5F47FF488A42671BCBDB8F805C2DFD480BC8A06EF8F4E5DCD3D1943
      040A60BC3E6680E4723CD18CB63EC826C7653175F542DD8ED0B0A83A9E5644D3
      C7EAF8E8C7EC9504057E058BE2B3D22894A1D294D90A0FDBAE965E6475B71C09
      927995EC3C66AF04FCF23AB101414A283A391195C76CD238AA0BF7120E29EEEF
      19C37C5090A4C0BDABCAD23EC11EB3574539BB8E01752FD9B755801F895AC602
      51CDB8DB561C95F751FC55D4A5174BBCFDBE51B857B4FB0370ECF2F2E86DC0B5
      5E74683B6F3354BC76D509B6E4EEBC7AFD63B3E14F2783135E4CEF0FCEDE8694
      C6076559FFE9F573F8A5D57C3249BF0992018D1BC1846124C046972B795BC7C9
      D0C5CF8832CAA83D7B46A488673BF84DBB4CC7EB343985413516CA5975DE8943
      4AD48FB15AC8F01F20CD12B0D476E3ECF3BCD185680FDDC251AB55B73B0316EB
      7BE8B3E92E743E48215F61E5BF2F0B5CCC65F46D70141DB9E2A2A7C555C7D7E8
      DDAAD90F721C8B4D1568D5BD2F13187A0398A2BCB9A0DC2DD862400A412D514D
      53401072AB1E305C6B74F0EB54046EA518828693A16FBDED65C9A74313907916
      446A20F3062180F950B8D1D1FEF64216C19D2BF192A3F3837738977EC98B1B82
      413841B77BB644F3E38AE5B7F4B453B0E721EC06F0917090B2F20BA4526146B9
      1476CD5913405E78662D260B234151776FEFD9EEF1F171B81A7ED8DBC3473B66
      9B4F6778BE72238F06DB5D66EDF89E6A344988CF523185DDCF8B2ACA68293A75
      C27C1CBD3BB93C3BDA9C8E31408D9C0457D27B57C26D55087780941E5FEDCD62
      B85A08453CE9582AEFF0A9286A931737DB894D4ACC1937B6A741C455B4FBCF6A
      BBC0C12E5C843B9EF975EB8722600D7B8AA01F1E155F650F785DA17EF235470F
      780C7A153C2A1E6DBC24548E035B90E6248C499A92EBCA07237F558ACEB9EC86
      348F0E1B6C0106F5C7494D048BC17D7CC7185A1686DC61A6323335638ABF3084
      D02810A6B50BD02F80C3CAB1360D5E574F3C1E5B213B8444A6A4393434597967
      52DF4DF5A6DB273E60782B998E6B59788DBE9E310BF83A3EA6D0D128970F6EE0
      7A3A8478A4B27174D4D4EEBB0B65234B44491BB7AAF948A6C6CE063C1AD59B23
      F164D9D80663B830796BDFC5550072CC0E2810662E55FA7970726C79229C1758
      8EC8927349725AE75ED68AEF3D27569C7B4BA3AB8BF66A6C70FE307F83629E45
      07715A1AF5779C20B636A4B639A828DB75FB1834BA46AFD5B397AEB5FB6EBA99
      E1EAEEFAF47772A26FA177CB8B925FDB793045E6F9E614995F8ADDE374E57160
      F86A31515DC9B802BE22A7032E0528F128514CEB0C88A3E4AA15B3AE33F183F7
      715D26A272FF14B208F1EDFB38DB80D844E5C680DCB4BABD685840770B32BBC8
      77C0269B16798D3249E302D136849081F8F2E57B709E4AC0CBE354F14D11882B
      E13546E49D4AEF216A304BFAA3621A758B924F9037D86172CEC7FFB5E68C48A4
      C1E83D9823AC91C1A419C39EE58F5A645B1731543A242CD4ACE33D052E0CD765
      730A1C3216CAF7455257D1A7749C142B8D837D2EAA8E7CB1639D6A72FDB6EDE3
      92E38694B86246CAD37F14F3CBF9304115C75BD29D38A59A7D6655DA50A5B0A0
      D48B7FAD3F4A75F455A0ED67CEDEFBA4FC427DC15B9695899E7DFF7ADB87AB08
      96A0DBA6ADA4D9CDB232A975F2A4A2E8E98AD0A5FD4852B8180B7954E04EA6C4
      4AF381B19ADFC4D084CF6E770C28736B40C51A84D7EB1933BC5F6388FD66A802
      A402D70CE5E8CDCC82758FDA6F52DE7CA9279CC8D05927465CDFA0E24858100B
      DF919C5E1641916B462C17BB5824AE47422B930A84AD43E513F073AEE73570A9
      C7054DE9727FCCE73076347A0144A698446FCFA4820D8319141D975A6771E5B3
      652A90ABBB8AACEAFD354CA2176212ED3C6A578362A5C5C4962B6618A72058CE
      BA1A24A2F394F00CFE61C2F78E370B534474B15C602C2D47F3A9D5ED6808788A
      968B855C1DEEC6A971D61D4BDC3EEACB760E51F8BCAD04D9F13832F38F42FB37
      A847ABD6222295E67E1AD7865B81B202622D3B96230F608A483EFE1E915BEF24
      E748424224A8F8C8CDA0B94AE1CD0CCC93D545917190A533C1BF8E4957C8931B
      47D00C6B57E27946C77FDC5D4284830AABE06CED5F7E409765D73CEE70A99543
      F93AD1314FA17A7FE715C958691C0D519290D4362C807C1C75EBEB18C1E7EA3A
      1EEFDD54D7F1EDF885AB373649BF3D2A983F90F818EDE7A2942C3639B6CC6A3B
      1A9C31F82E9A0083233181A0437221D40AE760996F45F7CC93DEBB2E44C16469
      1384323976147176B0A0D9D12E707734387BD4F7DD1F8F55B3B0BBE31C9BD83B
      35A2CEC7AD663106C169344ABC7D118CBB224F82FA87A52581FD0714319614A4
      9457A3D6EE542ED620F62328E183429C77447C3C54F8379E59C5247A5FDC48AC
      67F0EEE2638BBBC5224FDB5327EE0C3B29CA4CD4CAD4C5DC54D5659C57594CCA
      869BBB803582020EBF577FCA3A3A3E1D5CDA300C59485478C10F5422BCA3F143
      93EF6AC59E7EFEF0F1BD0B976ABC12059DF3DD495CA39A8566C2BA3D2B77E462
      49CE158092AB23ECA4FE56BA11CBBE2FD5897DFC2B482156A34A4A15008DE17C
      2A221B3D83C3E48A3AAD6ED63566153C7D05643F29FD68DFE1C72DD7466BD496
      45C6022C9BBB16F6C68ACECBC1F25664078DF20321CBA204016E786B422FEB9D
      31CD2AEB6CDB42A7FD8E5D1D0651DD2BE7C96AD449CD66D454D2C4392911FE35
      E935BA122FE905CC52E9E162F2932F8ABC79CC930575242A1ED67693E91EA328
      2EE5ED56BDCEDDCFE83ED92713FB58D27D589857BFF5A4173D41595A84334434
      4DB67A20AAFA44D4D49EA8BC41E7841537509415898D3CAB3B66FF3DB1AA362C
      8F03AB6258157CF6CD5D953F9EB4C5159E4836B42B5BEE304111818AA6B847AE
      70CFCEB2D817C65A39D567485A0CABCDC64358030BBA0E7A87CA31455327AD0C
      94020B785C8C4406A00BC698E5A23124AF90718F06231DAD04A54ADD34EC6CBE
      1A7E05AFEEF3D22CCADE121A85CC0FDF82220E60FB21AAC67A88EBEA0A4BFD39
      0E396F42BAC09C00ABC3812B50B2300C3692D83E4ACC884F8C04C7B4590F5BF5
      203DA6BA1A32911F88FDC4AEF450F549A5EFD914F5B32BE6FB6D07CFDE9998FA
      061A6878EDE56C464BDF34A51EC896E0B3AD3AB1BC7D4D145ED9F6F7FCC6839B
      F66BFD0D74CE5CB32E90624D1E5FF06DFFBAFFD016B5311B3E7ED868C9DE7EFB
      869A4B1FF3C9A6F0313EC587ADD7DAFFF974A1B5357BC39D454A25E48A947495
      E820960B44F7C3194C59F9534FCAA57D6171B524AE045C4EB09E63437BDD2D66
      19C2282B92DBEEB21DB1F9F1C1E1A0CA104EFAC5F3621DA6EBD35C17F261096E
      D4C555C2C88E24C5B6427A45D908166E7802082A5E5340C62793148A8F6A8135
      715A044473B6A90522B4C8CAA8984E711CC2B25AD9224F125B7C5C1EED37F1E3
      2018E4629C69DD241C7D5B9D9F4D7729B99196501B72A3118F830086AF462CAB
      B4CB84E8657784E4D2F4545E7247541ABEBA086443F187D8A5B28FC9EE375A14
      B9EB293407EF63DD683AFCB609FA8F9790BF361D7F55327EDB84159CDCA2C93E
      6D85EB18057527EE0D000AB31C2F5D73DDDE592155D4787B73E513BD8B240F92
      B8B89F5DF76576775027F1148973493C5D9AFD812CEB0A0275CEEC92901ABB20
      0F72C5E04D1840CCD8B9885901EC8282B2BEC1934AEAF9E0479BCFFB31F89DF3
      3A7AFD6AD5481EBA1419E224603D03AAB3FA09BECC1FD6449A4BFAE2B8594839
      CDA36710E6E50BE15FDFA3ABA3EBFB1C9B5692D584F136289CF9DE05C531CC52
      F5539FE2DF4494B3A58057F005381B8D4D67B9B7DE9D93906496695176A94185
      CD2A81D97ED4BDE4470EAF801038F22DA86207BBCD21AC90BCC64F8BC944CC45
      7CA0F0563199B48A0C09A625016A4BF51356815C826DB2BA9167F98241FD5CF2
      0F96941E8703F24B7F67A57485871051D0FB4DB314A4D58613CA1BCBAF761D51
      43EA4BFBE252AE72A6049C8CF12F2C0856A4173B5F52ECBF0469218D0A0F3A7F
      C68307FFC24FB2CA2D0D934951A2263156ED759AB08B69D56BF63E80BD950387
      258E921384F4839792E7B567027B335B7DBBE16621922353D28204AA5906B01B
      F9E11DF7AD8EF39FD1C225DC67AE94CE3126DD08F3E856F39BC75031A19DC3FA
      92A5C623DC7438E6052929BE53381455891D2BD02FFBD55EFB5D10235D15BF75
      7C41513636F2B85258DFDBE1D95A0F3229D3AFC6CF08A641CBBD755BB535AD28
      ABACA738AB1C0D5A4EF9835FEC6CF764F256015815024A1ADB6427C4B474850C
      6F95F7A795620DEDD5A43AEF98859A3F66142963B041E33463D58F65E50673E5
      04C00F0E58767E0F2C019A60BDA26ABA2CC02AEA06F50351EF9407955F96893B
      51EC07AA2C948C77DE44BB583B98CD1EB836C17F6081629EE464DB3D2FEC83CD
      0F7FA0FF5A69065EF3AAF7974081562A0634CC1288CC9159A80BCBA09C8E3756
      CB13A4C1CB20910980C37D216B5716A5531B27A3DAAD5F8DAB05CF476D3D9125
      D41085B03C25CE81B521A7392E5212594313CB44BF16B5CD8B7C779CD0925E3C
      BFFB66346638E06FDBC6A357022C53F0D138604B3BB5729D0553E2F0086F1087
      C62B28D10BBDA094ADB41D2A096393DAB59AB3DC5FBB4F22DE302F67B081E55A
      B02193E43C2FB38500D2915C69A80BA7B5B1BF044983741FD0964C02EC404D3A
      E369A8A18E7E74ACA5D617312A5E4D6D5CAADDF0BA131376031368603C7984A6
      3DC4E984B04B5C26605E5C157A2109360375041351B877170A08061ACF2F6F37
      ECD19E24E53028E823E26983C191FF7EC37C27E1C22CDCDDE0A19BDAF0210CBD
      2FD13A06D4F1A84DE0E50043BE58C09003C39A3B4116234F349508145DCC8505
      D80DA2AFFADC9E571544FCA3FD236985B14C9241D1D26AFB8A1D3711C785E908
      5171F30CECAE1687C5114C8C5692D4306B251EBAF602D747BB655DC2BC2A2C40
      CFD994E940DE03876D0B893468613EED0FE3E7D1BB65351397BA8E8E8F854462
      1E14FE296E390422BC6542F037A8C72D3F8401F176B05F8EAED773C53413341E
      8FABC6E17C79347821829E0092A54A5815DD2075266E7ED3905760F2D0AE42E5
      3D1E232AA57D218E115292DC17F84AF6E075D88C1C9B3CE25838434B6C6B555C
      25AF88F628CF398121926F7519475F0BE67C08132406C3550438C57B6D5CFE75
      11BD2FB2B4BAB6F7FF7E47F5329BB56C91BE5D81C75CCC9410D394B9BB0734C1
      240CDD64EBB30BF47B81D11378EB384C2CA903B0A4987AD848885E7C4D8552A2
      672CF2521859003D30DA2F93E810C7ED3DDCD5EB32CD49AB19A0ACDB5B11125A
      79A16AEED6C71394BEE56EEDA0A3C8462639521ED978DEC694C88E1D802DB426
      DCEE381BB1905CA694F71F439B559EACCA487472C920C13DDC269148AD543B33
      526C4B3879BC3F579F7F2A45A8C1A3C659A7CA40EC9800BB4AC5C727EF926C16
      3D55C269F4343A4FBECDABB3628C7FFF9CD6EFE6C3E8A91169A2A78E1FFC54C9
      B04F9560EB5EEFC1D4E8677F987A20B58D5EF45FF02C41D37BA2CA030B21AC7A
      6D390296494EA406555CBAC3328951D5675E17BB65222826ABF14C93125FDD52
      2CFC15F5FE7D1977D3156B683A7F387A7F8A9CCFB38BC3A3D3E8F8E4F4283ADF
      3F3B5242EAE34A39D4B0A7253F6CE6512557554F780B9249EF0FB6C6A98621A6
      90C8A3760CBCACA7A641362D60D79900D9B870058D5D3DEA476DFB34B9029F93
      959971EF338C329FC9C5B927044E2143F286711C8A47CECD27C7E5F2E0F823DE
      5200391F4A107CB6735CD051FA38EBFC5EBA001DA99F884BA0EA047C917675C9
      BF5D5CBC0F9CEDC75D0C65F125C903FBC64A9050254A1DC376C6D1552A56A831
      853518FFA81D53A2C1C9E559432A8114064810B7D2E71F99EE2A152D2F8B593A
      EA08FE45B162665B76A29F7D3AFC3011598F8A65CF0BF011E26D1513EEE88D96
      02533D39A07203920A3E2423D60E91197CD8765D4EC932562C0D99B40AD82D66
      C718A3D2298328C7518DB9A6FEEF12C0EE317B4B2BC465D6CB49E66188513C82
      05E3C03AA1AA2A76212C0D97FE1390971F55F2416C1A8A9C25E33BF04B38E048
      71A30CE6BCA61E0D8D10092DB991276F32A42B574C77B78A967C5A030C79CC37
      3163DF541D25279D505231A384A3540E429283F0A1E59EF3FA7D272AD7E3F02A
      57D042A4FC373667D492124B75652CE1369A15B3791603E105A6058BB76187B5
      5D7D5655490A907BB86E668C0238782746006F17A8B5A55F352A3464C998864F
      919BFDB7B959EFED499C3D6A51EA25BDD69F173B5E8D3158DB6668F7426BD62C
      EC554D79BAC330898605922AF2B1DCCF88AC8F1F6EB7EE6D6EB77A02D66A34A7
      E3BFD8F1542DEFB65B752B812F90E4A3595F6EAB015C5A0B6008DCDA841B61CD
      20AC0B40FFAA8CA7E290F6B1F4AC408B0A6750594C8C1FCA2C2A82DF91EF0D8B
      6F7E67B38E110C227BF8644ED79DCFAEF4F7A4A12C61A8E1B52D3AD0B512BD0A
      49C526DB345E60A53D7FD99E85E73FC82C5CD26383C407BCB5BC25DEB604E4B9
      BC385892FC87A2402D2732E83ECDC32EBD445AEFE302C2EE8E6EE3BF78190F77
      DA903047B52823298AB0D8E195B3AA5AB907A22A06F60182F1DA305E4520361E
      B58A78E91DA7F8BE3B7C57934ED331523927EEB1584A63D856ECAD123C18A05B
      075FA2A4611275ED5A284A5C0612B3BB59D28AC075413E5A901ACE61D75A5D57
      719A6FBE2AC42059BD2F9509C9ECD3455A726B626175ACC36D4F2FA3EFA201C3
      C8971F4EA3EFA263D50F0D7897686DE5538E5F04A58A70A5118200C1456FE92F
      49328338154132F8B18601D8853C9A97152E8A0245F2160EF9666BB29C5C83E1
      90DCA7496BCB2C0A7D0EBB8EA12D13BC0A02822C4A7F8500B7A1E55655460F90
      BB1EA1BFDB7C09FC6751ACCCBFDF8FFE55E035CA78F4057AD88FB104D0E65DA9
      FCBA26F67AD1777CF9DDCD6FDF8F2738B9DA351D9722C5A4020A065B352859C3
      394CC834F70F2308766BDD35AD97B1053BEAEBB2985F097ADCE12FA8A9246898
      C1EBB7558D24197CD445269685765B47EA4E039813D15D0E82E5645BA7C4B097
      6728AAB916B55FF15BDC7B4861C65030F28F38D9A4794E32976CF5CD9A4BA63B
      4F2DB6C417B6207AD8BE58347CA490E42BE824715879109FD2EAEC8EA53C3617
      77A19A34E0C63876899C97879038E8DA5FEDDBFAE3F0CBD2E0BA91429FD4BC85
      48C3174C128206B67985FBA1849F06444A7628C6CB5E2DAD709D21386CDB5556
      823E5E4C6C571F35B907F42D4319DF20DAC75A4FB0DD2DD1615464C5BCDC58B3
      834FB10977C7239F41F9FF69021B84F13C397EF2312028599F957E93DE034F3C
      AA1D2127286DE840B3C73B087EFC4EB3EB720E9AC61D2C27A77F61CF792ABFDF
      91E799A0BF5296EC8586A4AA396AAA7CD810240AF71066808C826C49D188CD27
      5691B625F3B95A21A15E89F4876800A7DCDA51134F892DC5D595A8E842F5AF4A
      87298AA3083B42BF0F89312B74203F52C303BA6696782B8577949622269CBC08
      23665D8EB9BC93CC9AFB3B0AB3741766625D2290C958FBA19B3270330363B689
      66877EFC08B1B82087D879F3723AB9127DFC5EB7F10E4FC31E536E2368DF9781
      D096369FFC77E9D5F5EEE1FB13D9921B6FE020B5B0F984F0F055344E0A9BD0EB
      19C59CAB85D28FF287493CA2CC6E65C1BD9FA2677B7BFF8FBDACED7E0B1DF71D
      A9364BA7A904711C9B5687C45CD8616C350601168BD090CBC0767A9A23DB498D
      0E8EE6552D6695DD1DF71BE2CEBB783A9C9757C87B3A6B57565B744ADDB7F9E5
      BBA4472CF37DB98714DCE6CAFFD2A7608552901AF724AD9FAE6322F3B68A2604
      B3197690E24ADBA5CF9C1618CC7F7152B67A806562502C884CC17CCBE2B0E004
      6CF5C30DA2BC4C1413C3AB06B1D725E4363398BB7FE1021B27B324274E0E3283
      0431B9973D713B0C6D8A32FA5552FBA831838FA1A1272EFE3D02D88353334337
      B359852CE52C57B469A55997B1D6BA01E5007F6B5686B518F7D45DD69AF35E25
      AD67AF3E8183E2B0814EB3F04E945AABD58C3ABC7E3B40DDE5D6E5D74CA93D2D
      ADDE47348D99D6CF9FD1C53DFAF6ED9B8826F6A3235455CD6EA564E902BB8D1B
      4CA444FD09196A42B0B9F90CFF7CFEFD8BA88331EDB88E77F7F6C88B3D94ABE9
      E5DE8FAF5CB7DD778E8FF6F46B47946AD4B754AE3249A6D07A5A6B93BBB9F3A1
      2396EF0944DFD564716DC30FE15F955D4C4551FDA35C5C5205679C5EA5B525E8
      1B87147BE1FCE292B07F26DA2B2A993546886A0A3E58D0749CDF4E8B724D226E
      409452C134A591043A69825E88A87CE2AB093734DC05F69FCEE29A13D5D5E2A4
      C41E5D689A004BEE942AF1C2743C19F58AFD6BEB5E90D7EE453F45FF8BF3E496
      DC4D5CD209F391327FCD2C59CE6B97BFF179EE706AC1A2BD4BA1AEF534ADB189
      87B2A78E83680B807B82B38E5D8450027E60C68D1B5ABBF99B5B7E65CBEFAB64
      3E2E165B960AD16E661A1D91C5A93DC1ECBBD0D206BDD1CD8AB075253F86D92B
      F9125AC9414B3E7C4D1AC3ACD31BEEFB2DF25A36397A836F873CD620DDC3092D
      19048D63E1E2F5AB8574254DD89094A549F1FAD53DF2950221450E06864CCA51
      B9F49BBECFFA161443F354F4250D3A5FA8CC29570A277BC0ED7B3B48BF5184C5
      2916DF2A2C12146FB25966F867F5FE581C7074C1DBA112CAD3835EF4CAE4E2CE
      6F9169E523FC96DB048F4EC8A5ACA212D7CB3A8E16A7F3117154A9D730124A60
      23F42D312F099DAF7C89B7739442BACA412F8CF33A8AA7CC6A82D40C481782DC
      31CA3B51327049A12BCD421151B420578A73C15C7CCB8F8C73E4FEDC38C5EE8E
      252EF83A5977E6D1AD58EE6E518C11CE38905A06ABDEB4F98390D2AC77A91CE9
      8CCB8E35CD503EE222114044A2B6263AC6AC26973553260AB2C9D574F0E1C019
      CA92238A582E92A434694E5564564ECF876422CE80680D88785AA1DD48A1F3A5
      451C80A3954985726E6815D71B06388FBEDFDB6BA795D092A2A0F7A4B1A3EA98
      7BCFFFF6B94AB2AD07E14CFE002C05719CD93937E2ADE196817205E125450255
      5AF0794FAB787B12265E7BF53952AD9F5ED33D6A8028D21143A07FFB2F9CBCBF
      FD37379B29E4C2CE0C0D1081A9657D402A4DE29A383F6B89C24E50F026CDE735
      0C17544F22D35E778F62DE6646DAD6674E9AF10E6505365E21DF7826C215EA4A
      0579D3B85F2613F90A869C10A5445D822CA5341729FDDF7EB301E1FE4A7EFBAD
      23BB201EB112ADA00D7C9848BF5316472A1970D9DB599415571BF65B71C4BBCC
      0DA6EE6C6A701C1679CD7E477F09C9D12A1BC4E2F06C75CDB9E19FC3ECF5BF68
      19265E2CE1607B0752669D947D7CA877D2666D5052DFDAE023C236F454B23D5B
      2693957EE3EEC19BDFFE0B53F3DB7F477F9139D26B86309C7FF0E692305017D9
      C551239985D61326B7ABCD594CEEDE8CEB5681669EB988059FE73382EEDEE45A
      66426348EA1CB9DA54A12E8A745E6E2A8D9E0216A23BE913935DE0E4E0FD47C0
      1E49C05B0892DD82AB13E73338CA70C1D80DB8628BCED2AAECFCE07210355D5E
      1B071F0E5E3CBFCF20CA0FF4EE096F1C27C2C95DAA5E1DC01DBBA7820DBB7123
      EA233AEBD91EAF3312F2F678CADFC9BDDA7CA04E48B04EC69EB94F666A314E66
      F88F0DCC5F2DCBA40E9D05209D4529A63A4F4675E04D0BCD9B77FBE78393A80B
      4B0E6A9E586C54388E4735F077FDBE2E158D8BA8CD132627BB4E77010D08554D
      AA60BA87C952956EB029B19F7630D4C408518EA3A106CFFD63321E63210412BD
      64C5EC204383143EB9F383F1101725458565AF1B049784AFEC7AACD88B1ED9CD
      BFE982824040A6DFD8C0D90EC825006F18E3B8BB1139668DE2C4AFBA44196335
      6B00C9844CA5CC2F1358757ED68BAD585949C953B408904B2785199ED95DA83D
      432935EC5FD8037CB32741C2719A0B404740C122E97C31BBFC960EE2C5E01EF4
      07BE9CBDEEFA2C3CCA797970706194581A3CB98A61433293563AB81D66FBB3EC
      20F76CEA3342D8A3B4952D00180F2B6A45F63CD98F4A2A80D37B2CB0C7CA926D
      3D49A6EF1AFFC4DC2F329BB72B484FFDE75989E66B28CF635A6E67268F48AB1E
      BA6C7EBCDC2BD168674D515F1E55AE4A686A68005E6C30198B6671CD6053DA5A
      A7FC064A9412D1F17346B40B6104093A2C5DDDF704D571562C99A2C5AEBA129F
      7DFB9BAA8F0AF94FDF0242ECF6E0EDFA7519AA4F6ED6B5D628EA22D1D560FB4B
      E43D89F700051729A43E30B6E86298A55F99E868CEFE0BD9DAF69F24862457B1
      40948D7E88147815C68C7DCD4428655A074DE0BBED4B4B178255938380A26990
      24A3A5F9289B93DE9003E99058881F9DA8DB50F0349FA355C1F5DEB3E755C7DD
      DF2439004E012197A5D3DC3A79DAC740E0A2052386EBC79D87CF9E7FFF3CEAF2
      A8DC8D4E51CE3B3AD9692A0F0469EB92B5B93B9AEDEA9DFDE6DFEC493F698E60
      F001A897427C99D7931FB8A97DC3620D32A5FD4E55938640942B5ABD5603B07D
      B88866437B1874CAE22AFA7879FC43BF913CAD4077B349226B6D7BC63F57A91C
      A444EB0A218481A78B63985BA114370837AD94C70D10B2C59384AF67BA7D0D1E
      8233E554588FF0F70CD6BC6E532CCB50DFAFB95E37BF1C4FB5A195F762B0F3BA
      58DC832301D98B6C2C5B300C6136BA2EEF88DD7C95E3D5B7BB24E3321EA6A368
      176BFED5564F805F8B09DEE5A46EF7887F25A36BE9C3DE560F18C710E592273C
      DFEA09497E953DF0111314FB7DE023E0733EE8095749398578DB039E5026C917
      79C08BAD1E703DCFAF5098207FC88CA6759CA50F7B917FC4B3F8A12B332FCA9B
      E4EA811D994952F7034603A7EBFC6A2E2FB3753FCA7955B95779B6D523AAD983
      775A75938C1FF8887A5E7E718F78B9F6781D1CFD0107E98A0364499FCCAC5365
      0217E0F9433ABAB48F2B2E3291A8239348AF68663C0562060DF98BF5C9238DD2
      4FB084553882CFA6832BE968AE892E85674AB33D240EE164E2CCB7154DA161F1
      35D901CA4CCEA2140A692B74B0560A90A92AEA7C945A50E19FDFB84AAF2150C5
      E22FC0DBD62A7489C9E43511F382FCB10010115934B85A8B7D330B73C6328D52
      520F1C1A2DDB4EAB29FA75343343EC3320FB505044285552F35B98964AF44857
      03D9E133577D4F97FA5F60C0AEFADE17D0CF8AFC2FAF5EBD7AB50EE5F3AC50BA
      E6223087E41667244BE9060F6309F706CF8E52944A122A03B37B98AB4B166D0C
      347EBDA29A6FDD5BA124C20A990446AA149E16733EB0D8D3AA299B664B767333
      51E5DCDD2FD7A35796F0A366762046D73992A9E944DDCE51DE11F9133B6A481D
      F6BB7642672AB4FDDD202C1193352F277BF36FF6889FA0FF43A0979BBAAAC960
      69D58E11B9DA9BB4263B36741E024BDC15AD6FA806D151132D01FC942E730068
      BA5FBBFDFF6FF03E7EEAA779AA5086FB4B6AB638CBDE4C1A0EB7312BAA85EFD0
      D9A52829DD9A7B58FE6D776443FACF22EF7A29822BF9A6AD268C3C621C543FD1
      958EBFF0AB4A29E81C680D993F2F474840D85BBB6D267196816CBCBC4738BAE6
      5A4FCD7A43D85ED7AD78985D5ECFC7172F7B5EA447BF8001A0A3A89321651593
      6FD406D04368B5CC09E37DE1B0892F2AC0C3A2274FD09B79921AE9C648A8C094
      C66B084FD33B344660E81DFA233D0884FA53D530E43EE597D5EFFB3FBA6783EF
      49F0930D2B0C605CAE38C2B4A1D415F6A4EBD538A9984B6CEFBA9A4EB27CF968
      692D601CC1C6E4C5A4E7A0BCB0E6C247A36B281B91C0C193B805EBC054115683
      BBD07DA301DD6E51CCF1418B745506E712586FE5E259FC7E334A110628960C28
      96C272E4C19570AB9B09B35157A1A165471A9837215EB5701CEF70660581516E
      A3ACB09EEF324D24C4D25A766510D5A2CC16BE870EC298F282BBAC3FEC66C41E
      112670DD394D1A51F692EF5E803ACBA23FE745FD6753026B5883AD25D4280CD4
      C508E3120B10C30DC32D4BCCCDC6A36D2DEBD2BCCA8A21CFE4E0B0E8E22D66AE
      220AD0B9E597DA4EA8EB369A85E820D2F346B35D361D7EDEB879BD28FA7660E2
      EE68D6A4B1E16D716C5307C77889CC54E9F9EED04E27B1A65C5B2C39184E0C98
      51509A872B62CD0C5E2A9A3B8C2B10746EC303373C2BD79CBBF2949E98B6BE14
      B0AC582AD735613B39728382CDC171BB9A3948D81A9A86D9AD0A09346E94BB96
      8DAA0734AE175A91B616B837FE6D347BF3EDDBB76F3F31954335AEE5B8909792
      848FEE2237DDE73A7224FA111EE372C26D39E4B76DC35996454FC6037E603FD8
      FA1C6FEA309197F5D2E8C034C771F8658944D8F72A7D025E60EFC7177B3FDDC7
      3C72D9186B2D8C76FA4694277179079D804E9A66622E9512D5DDBE3498BFDA35
      1227D17EF8C6A094F53FD19080DD1F162E7E2331868520C3FA072E596FCDA73E
      F34F3DB82DD32C4B471B3C96E18185C7BDFA7E6FEF59D4FD7879BCFBC37A3DCD
      251680D1EEDCD83B15B036872B2BAE563BA77B7B6FF6F63E87CAE8A04925E59B
      E85735A47452FA83CB0F27E73F0F3EEBAB3D68745458A461C4D1B24D681241AD
      E289A70348A4A6A8DBD84CFB5DFC31E4ACBF3B3A1D75690B58E33BF79D131758
      C36DD57C8FA0F67ACA17710A851222F4A1BB8DE6E6E5F2B9094EDCA49A7E4615
      2E97D4D225B7E7CDFE8FC73FBC787B7CBCF3586D3CDA10DEA7D1012D38E595AD
      A1FA2D4E0D8ED1BFFFFDEF7FFFA9911E8BA337B8061E3C49CF9E2F7F97839995
      B6BD4CAABA9F54B33B0691B3F74E72A30E7DC7568FE9AA645D9F2B73BD814A2D
      AE846CF1279EC15B265626202062B2E7D5A8443EAA644D5A6C15341B49859AA6
      64B563201D81260CDB6BE906D3CE6E453C570B95048783D45B403528F8BC16E3
      3FFF14BE551B52E29D2F6026797E6B9205543A164A7BEA51BFF4FE8413E29F65
      F3AB34AFFAF5B77AA3C719DEE60B1FAB479AE622F81C64B570D9060D482666F0
      8652CAA4FD3B3151258BD5C169453CE66F36EA68F0CABD56655AA98A8B3F3633
      681A8170D6B495F0B7CAB9490E8E16CDAD925A5116E18D234D4EEB428482F4F7
      58C06D40761586FFAC4FF83EA48E6FFCDBE7F25BD310AFA650D71B1C6DFCFB17
      F2FB8BC9241DC1F73F3C3DC02B5FC7E518F693BDCE6E38031B3FFC65F3C5FECF
      A70FD6435EEB9F3E3462242FA34F1F367EF4F7F2E8037A18451E1D6473C46975
      993E4EF75F491B0B42E61B3FE0B53C6099B0F94AFBF86462D4D780101DEC4251
      F6953CC48042231EB5DEC0D889B2B159720DCE19434CAA4D2702FD6DFE8D6A07
      06B69DAC7EFFB380CB23CD20A1410934A43756CB5F57D9213344ABD839BAA82E
      8915DF1F66C5E8CB7D04E56E8C83EB1CF2684C95CBB5CEC7C20FA484BBE5B03A
      E440BF070FB679A4C52E89031833ABBABBBFE9D441BB1CB458A984D08B3A23AD
      35DFEFF7F9E2A2C259A5D314027EAE1459B5738720BBDE7F1B48B8E1FA136422
      F63A8CB218748EA0D4ED0AF62D2C8B4DCA2E483D54D45D512D76DC65179296AB
      62AA8296A220B056673096B4177B0A8AD4ECF4DC4EEBF9ECC8AED533D7CDBBD3
      13CB425B120A72383542B2D1A4DEF7C834FBB6F6DC36A66798480CF97E969575
      456810766275100211745437292B236B54EF2BBB55AC1438B97E7496F8E7FFF9
      1F385A5F925D45DEFEE77FC4938DC1A326909A40366EED75E9D7ADBD926C3FDB
      D8FA9C664A7A90ECCEBFD31C6AAF0C8BAFB2BBBFF63F87FA90BFFEFDF3EA801C
      14E179295B849882A59AF7410C682C0930929DDDEAE5BD54EE0EEA32FB4EB5C9
      F072F24664D34A5C56A577F44063E87549A940A235A29CCB37BEF8657DE56577
      7A740EDA3BBEC78234883C39D44338E1B61F83AA9086FCFB7883E43E08467F34
      387BEA3689729E25B48E80FA5A6B65838E86A5AEFC79C94C8429242617C1C355
      6588E84CC459F444F5E98B9C7BD4CB4921ED100B962267E8D458667484197DB2
      12C70B8BD76CF9FC05757F8DDD4ADA2A0A81AD113FA42DEAF5F6AD540A5BB388
      F775928DA331760FDA6FAC58D99E228EED1D3F393A7AF87F116816AFA28B0CCD
      AABECD921D0D25B9770632760F45A5636630BBF202C938EA5F5D17C8505C9FFF
      A2DFF48890D9D8A0B3DE0ADED9D5909E1ED3C8F8939C48F23719B6369D034D16
      71F986FA789F10BFC6608A9550AB0D904A11745138F4B2ACC38F01F9505560F5
      A17A24EF61A275E8A41C0BF2C48F27DE7DA258E7066FB0B2347D78ED17647C9F
      1563D5E8DE2C3749BF0CB32C9A2452CB4BD3A575A53BD55AA5E414B8B2D3A986
      3AF1B5AB820EB726FFD43506169F8477F72CAE56BB6F340DAD9E655DA050A704
      55AEE3792688FFC2BBF5BCF5A4A9DFFA0A8D4A3102080B7D49060C1381A48E2B
      ADEACACC1D0D42F4787B5B0ED934CE6306BC5CDB6B2A2AD9F7644495315DA327
      32881C5BCB12EAC206BE016B34BFDA71F8142F35272BAE46868AE039255BAE2F
      122ECC2A71195961BD50DCCD8C58B8D4229AEE3B54E6BD562295A67454C133B8
      D77C9214D8D1E9289D515799713DD1EE82E6899C286236B604699D9A094E4635
      E750C647F0986BC1F5E7B34D879441152999670C121D3C4F2B51D3B128D3AB14
      17893A3032986B1AAA1264522AC387460DA2DC568C3C1010D0F29B4C65D63AAB
      729420FDBAF5AE3A71C3DB60F94A32280E00188BD3597DBB54125D33BF21FC2F
      463A4A5152C24FB57E5DDF3AFDE06EB16C3953CCA02084DB2A70F3B053A68550
      884092629E0FE10D2B48F16C6FEF09D7E114FAD85A16C6F8F8CE3CF263C345E9
      6AE5593D2601D0E23A6CD0D5BD088B93AC7A3151238ABFC0A7ADE5909142E2F4
      3A0B550F6E214C3DA7762D5E172C469D28E6C04BF9D4E604CBAD39C1B2819013
      7480AD8C1EFAEFA70F0A48C4CFB17170F2B4E67CF340983AA7B2BCBD492277C6
      5AC38C58A5077369B5133DB473CE2A1BDDD9840BC2E830FB4FA5B4833A9DEA7D
      EBA3E80A2C3C096387CB608ACBAC003C56B9D378AD67E5DB757C09EF92F6A2AA
      7005F2C6A96A0C49B90925A48CD3AFE91866436392D46D4DA903B95E011B6E07
      A3D7BA1603CF8DCAF7004692B882FE196B43C73E09D49A5D77C048DA2521032D
      671764B39B4B130AD76FBE948EA8A7F3F4503407F8E00F0937841B93F531FCC5
      D2A90D59474EB0952685E4953606668AD4CD766DF5C21B38F69513F1EE25FBC5
      D7CFC22953645ECC22B766DB20CC7D15BA05FB0BAFF0CD500B284E09285CD831
      10D84B323A1F4FD653E428E5214407EF6F3F77505B03AF5B9AADEE188A617DC0
      CE41B34BFD7EBFD3A84F59B726942AC858627C04FDDEB3408560C9F563DA9B2A
      3145F7581A6D9D2AA322AFF40AD188897984A17AADC3C490DC348361E90C65F7
      249848C56A2127C1E5A050824195AA7A454139194D78774AADA2755683B250D5
      D10B274E631653578D83EF301D667C31CD6FF95E68160EFEBAB033E2D5B3D20B
      8C2406F07CC925D811EDA971A2ACCD2D1888A2CAC4B849E70C7199886961B0E7
      C2510D6E97ED3E07FCD02E45A6793A9CD78EB5E26B9AE91D60E2C6EC14852DB8
      61EC7816FCC49352F4C15E81CAE7D901800C56513FDAA7B983EB38858EDE5503
      DE70ABA7B9F42CD334AC6DB16445B9EF09A77EF3C3A3F59C750BB3DDACAFC26D
      BCBBC6B0B002769078B8D135029BA185400ADF3F5C4427398AC16D0438EA3344
      92733EC33141F0A1BD26A3EFA20311FCFF880A80FAEF43180FAB9A39F870D0EA
      27752C8D03163432B84E27F577D273A331C786978B8AAE1C253CCA68F4E997D3
      89442F64149D3DCBA6091C2C7DCC5A6FA089FD012DFC7060AF324E60603507FD
      909FAD4320C2380B7BB8A8846BC3138456028D2F9F56D2104411FC889ACBC168
      54D2484F726C6F52751DFD6804214F096ADEC448A63085A1D570473CBA6ED24B
      BC9A0D10C72DB5761D0AB8CBE4625BEC90DD0C749AC50E818BA7B899F6D8850F
      DC6614D48C2CB82DF5002472B31B1949A2A973C6AA551C8486B3BE5D5B83625E
      8E90E5B7DF3E83DB8DC98DECD0000F1F3439931AE39041506F5454E683B10DC6
      555F56D8A70109984D6BEFAC27CB0FAC4D5FF5B82887D29F5D6C8CF0DD5CE450
      80B3105549F307CCA4488346A717D22480387DF560AF85FB2914E0F563AA4155
      47935E188F961DE992626C9C03285E18F00C91DDB15D5E3FC73BBD7E1EBE5392
      8FE3EA9AEFA485BB77DBDC82A624A0031EA7C0E64AD8457196F5B76A31CDA3B7
      88C2A2D627D6609157C968DE887CEA1A847D82D00315E563F9553FDACF6F5D44
      C545C918D76D0FBAD2D8E164DBCA50BF77F149341FEE7C92C9E8DDF1204A0B3A
      53DC15C4924739C560D65FBE95F15D6FF9E304B423410A03F0BEA0F9A6F68D30
      52DC0D4279665E6FA04503F257716D7ED5ED6B962E5D2DB6A9E3D604CF20C901
      8543D2C86C7CAE52105A62C6D5DAEBD66C4B9A7F1419E294C20B4ECAED0EF7F7
      0D3BF75CED5C65DB38BBC05DBE029569E65728CA109EEEEDBFE943BAD046AC3C
      B2DE8A3A6EDA6376D45DFCC4B91865BBB5DDAFCD51AF68764BE443A425D464CE
      D2D9B060BD0F67FFF3ACA139ACE7877EF79C54B375A59B965ACA8B262F0391BD
      658E801368F141DA0567E02EE334A8D102517E49FD991663168DD40CD6C66118
      58FF1BE86BF2D50C1D091A85CFDB0634028FD7C95C36A2B375995E5D31366F8E
      419EDC00DCA3A5E51E4EDBA5A9D629BA68CBC2E82BBC85D630AC041ADADFE578
      B7286B8D9C076F142E4931730FDB40668C9BDB12DB02CF0F7867689CBAE1D118
      F4DA034F481CC2BA1712A32565188123673ECB7592AD76712E00302F0C9057F1
      BD736CE43B92B8425BB029A2BFCE1F527087D6D1F2E6554E7B9848180CA6FA5D
      E6B8A6B06AA44F346C1A72ED4B0D9995109F06A63602B2F66141610F551E02C1
      ECFA59859B049C2EEA3032750792D462E92F2B55BF5E6171817DA402B752F8E6
      6E7C5A8D320CAC15B7D37BC15B8476747241B40F417835A25DD808F23501FDFB
      A46A67C9EF3305E23B067DFADD67A18157F881B71DE480A4DCC8601EBD5C764A
      88314BB7784910FBEE212525D5BCF5C719CD3CEA08D1955E739AFFB1A31A4272
      0BCBBC7D0DAFBB78C398617D6DB97E79217840E98862213477F0E160832B5605
      EA96AC00372CAE7B4154C53A7847C3E873B83AD6E3C19B183AD745C1C6C4D868
      C47844145BEB4D699F88AA3883C0812A46EF0A5912F7235BE0C5659C92F15AD5
      DAD6F79BAB0B572A02EC370144E8B1137FA5B8D132C021AE169FDCFDB6730FE9
      DF396422DACFE86CCE9CBAE30182D851FB78D79F143E93F0D76F9FED2556D3A8
      BEEF47078AB14978894E9325A2F3CA1585900ABA78B292F3E8F97A1EDBDD7DE3
      F5E1D26EFC3CB4D4EC97C6662418B3301AE12173874DDA731488C6CD668DD207
      C59B4B3263107388871BBCACD0B815BB5F7C498AF46AE148435597BC0695A749
      33810FEBAC69ABA6B92C4AB2749498A42BCEFC7D0A2F582E8F90A27F3565EDCF
      DE07F103D659B72385BEB8EC977EB6BA2EF2BAEA5268847E021EF6C6E46B4B0F
      2693C29C4A6E2028E22F4E030AA7F4511EB44CEA79296960925E0C7BB872494C
      CE0E8AAB685CC6572E575F768CCB026A14F053FB494518932C730B9E8F2A5189
      2F5C7E760DCA5D472685562F341EE8AC2C8619CA87394FC606780DE6CEEA1D9C
      262FA2BE6ABEDAE0390746CD15D56427BD64C5CC93D41630230D19954A745F93
      CC51706D41E86D67BC0078F1A1FC3BAF3F63E9DF67B1DB11E7C4A04C6E6ABD78
      8C813B4E52010572844E600FB3B25D18A0C679C4AF494E9B15225CD5E03B25C8
      4AB486D8C87EA6F11A473952AE9B9C17307D2C745F11D04A45C9DAF5CD0304EC
      CCBA1AB96A058DE24A2FFE90C114E868B95C17906424B8652C2DF7451154D3FA
      8C4216313925C168EF71B392A22D04154530D6C5F196CB3C845433355F687605
      CF97122DC67C6BB0B844DE2CE0DBEB1755476C3A2B4A68C73AFEEB4D2C5E2514
      578CA508441AC4761A4E2CCF244E377E44693565F6D9F1821804829BC9B4286F
      ADF4DC32B5D4E610EC72C80EF946284751B5CA66811E5958CA59D7FDEB2F2AA4
      CCE87D2F729F8FB351D58B0E0EAA9D060C8DA431015C97F4EF5EDD7B132331AD
      374406616F842CD9A0C38E15D7400537E88280CF0C10A33EA24A2DFBD75A6E28
      AF2AD03900E2F03197223EEFD2BCEE446542FDB2CA1FD21D1A7278AF8EDA766B
      8D8A650FC65251ABBA55CEB78B3AA5AED60B7340AD8AB342CCC050E7FA3463A8
      52F7562C96677B56DD268A23C8AF14A81B8AEA566E678BA332CFE53749D42C36
      0ABBA3F28B545B52B80D7CB5E246F9CCC064FCA6D36FAE8E6B1B3A4F66083AE5
      599DB225C0472305BCCD60DAFCB9BFFE1D9933BE09A4CD5AAD3A65643FFBDE0A
      F6E80E4E5151A1C2FA428D5858A04893A13B87FEE545F1AFC4FDD88DF03D2F2A
      785062485A78C7979F2DF2C512A50B377DA7F598EEDB221BEFD86F3BBA88DAB1
      F1AE2E26A1A394F335CA7E77E65BE89168BC560D2F4CEF7E274D7E569A2BA331
      C65545300C7DBF47CD52C5F1D2BC69516D9CB8B4CC1C13B53CBC5F8C0D23BCC8
      5D112D54E148BCD10968EF4889738AEE121FDEE945C7591183278CBC380E0055
      E5E503A9B3CBBBD63D4B888C4CE35061B675F92F383E6C692FEB9CEAD88B060D
      C2D0D1B82C664247C14E2623795630B520CE2C88DA4DE8D6D098D1EAA7814D7E
      3DBF428244D719940CDE09B739BECAD37A3E4E76E018C13EB8C71CCACA309C11
      EDAEF33F96FC24EAAAC8E7F076E90C37A95FB40703C1FF1D9D73E49C549164B1
      41CB434831B4298665127F5166A595BCA5CD762CE6705CFAEA007073EE574288
      56449DACA445ED73067CC1229821C668B73C08794A68CC8FAED364DD09DC912E
      B4A8E3AEAEF869512565D509BD33491D047CB1F2A795A4DC9A1C5D235BE1D751
      6D5F430395B8A2FE8F27AC48388AB3CBE28CF6C9DFD2BCB25FF422FF6B7C1EFE
      B73C6D2D62FBA2D977029A41BDE6D031B2DB8C61229C9EDC578B0F88BACE2DF2
      E5067702278B064AA5BA1841F445130D5CAE85FB41CF341A69B74A41C16613BC
      FD1B85BF6D916BC45FAD4D4C8FBBEC55AF2624A45288C2ABC6E92F8A793D425D
      746302E5C5F88E2A90EDE6E5B4939B520A03590E8B3CC3E97158A50B14457982
      48284F53CF12693A943ED7C5BE20D91441498971197B9FCCED96E0A554584675
      CCA468864F0DD12F31C8912531B22A549A0843D42819C15F49F78DEA8E3C1075
      09DCCC215C67F2ADCE3FE3B3D7EC4BD5B6F1B3A7F3D6BB93699C565167028A0C
      35FC3A5157E538DCD655615FE42D05C5A9CD2BD2B9B163CC4DA5F17C0B20E675
      2F987B4717D5C264909A0C861A12C2AED31639F619F2B6F0501253AAB8D4E57C
      54CF21F365666C978897E6DC84059809608A1FE529BEDAAED5406D2DF4582691
      6C7A9ABA555D14BC33986C31C73967E05A74E9D3AE401098233E8C0893D9CD86
      3953144D77F3B23981D4642CAADFB4A0A4B38D69A531B57E29E87913ACD0035D
      A1F41E926FE00E61A483E401F134E404E50C9C26F1A4EAC86C74FE3AC71DC9AF
      D8F12918999C2B0D78C340E4B5276BE7ED6DF436AE920F9CA88E5299E9960D8B
      6F5E9198C799C5CB0384555018579B664881438FC176FF220AD22AE87D70747A
      8A19449E9FD51C96AFEE6CB2B95A9DF3A4F05EF45D2FDA9571FA33848CAB7652
      9EA2325147E045C0169D9EFBAFF3224F6C984FF2AF30245C64A8B33EB9567258
      8282AA76EC5B39715904E6225A94D7F698E596043BD534611909B2BC118D2951
      8F2736228C9667B4347C9D2EC772213D875F5427D4555C1BBB765B4C1502473E
      C22C2DDEC7538A47D78A256F5852310C1EBA413432C3EA4CDC2A81016030DF30
      E10D0804C51E18671B6A828412DE56B67AC99BB80453AD61E814B186B7D2CF35
      60AFB15AC17E24E30E91858E6BAA4398D0D2B5A59056CF438C316AA554D70205
      399CD9C0D93013506EF41084515CBF2AE47210E4BB2ED3D117547BAB4478C2F9
      19B82C0BAA738ABB5727A896686D42AC787D72E985ECEF65A3E8A6D94A122FD6
      17F727A77BC4D379EE1F67678C7F3B411F164DC58D70F803D51B17E94A4BE45C
      DE7B576F12EB91216BA9D93D97B4DCC9CAEADDA6191F4B0970A892410D99560E
      A2242E0C2AF5ED115688873C5B91972F8A2FF777BB3B7AAD408AA662A1874EA0
      6AB7328CB458FE92A0AC1CAC933281A769E9E3612BC1F167EDF4A3B79ACA6D89
      B9BCFF0B021367FB83CBA89A0FDDCC3AD437303E344EC9E7D2ED850EA5555C73
      0C565125972B9C871B045C256EA12A77C6F898E752AF0B380BA6876B08376822
      F60DE8BD691EE5CCE9DCE1F8CF92420ADD921AE58419509A239999AD12E7A64D
      257EBF5681C39CBABA996155D00DCA77FAD3DDD79236AB0796AC82F0668CD545
      63362CC34B56B9E6E8C76364746A4618F82F56BE20893AFBE3B13E208C15DE93
      35B2AC514E78D26E9744DB4A9418AC3AA54BC557CB432AF139DBC1E567D983F2
      E89FF3A472057EDDABD0F4DAEC65565B4C2454F87887AD7A238B868B9F099B56
      D981B463BB981BF12AA2EDF243FE4E2211B9CF26AF8B68F7E497BCB8F9DB755C
      9F4C0F8B34BFEA47EF4105D20A98AEE04443321BA79486BA54A54813D772E6AD
      39936D5C44285610DDE009FC0BAA95B295FB160C16D45096155DB1AAE0B525B7
      917968A696B41AE5F08B8F47B8A87629C4E753B203020F4EE7D5C8C9006568DC
      22588A90845F89BA5C95C82C5ABC60773A6ECD32E7DB5614190878D3D54CF9F6
      8A5CDA99C677604A7FD08D438F8896ADFEF181BD41BED18B004551835003BCD1
      14C53427DE2BC17AE367E492486C478BAD4A3D0FA479FABD9B25381D150754A7
      214F12C52186FE70C45226B1692C1AF726BD194ADFA42C3D8B6B5E82FB6ACBEE
      E8A78D22A0866C6FA1C4249E5828FB0A707835DB4203F977FCD2C0F816096803
      B90364FF98DF2968C2D1E08C2A70B2AF7CD915C9BDF0B269822EF3200DA08207
      95067F4F8BF44332897E7D7FFA1F1FDEECF17FCF5E7EC6801BF4E033B7BC6CE7
      B795A111FFD8AE666ED98359869B88EF92C7E375C2265C0E44100816142D48F8
      530583380B94306531F985B8AE765228CE111AAD7509DF09DDFA6097D418A233
      6D0782B3BAD4825E31F6EFACBBFDB1A05849651B669D9BBFECA741E44F771D61
      7489C3369854EAA80A819BF2C1D36142203130B9926F6B9240172CFC4655A471
      5CC776CD87D57393B07E401CFDF65F3FC7D3040923BFFD77DFBF95A528F2F586
      C98A4EAD18DFCB74B6F180F2BB8A28B5CB992C1DD89A87339C6A532A323B6D1A
      A3B3C506DEA36BD81FAEA6E06699113432B9E7F1347C1912C2C200599CBCFB8F
      91718A0E5C7A4F912F3B51567A5A925A7437734E933CD99499678CB15AA55AF0
      8B2579D03E73908BA2DEAD24A4D59E9FD279BE3B6835ECCB30C8F9A06DBD60FD
      10B4BEF9B8FDFA29296F3F474B30BC6A3BA253B37F9E45B3520C7DF79F681FCB
      D68B18ED2ACA1424562DD7C56C228C8EAE227536A073A4892344D196869ABCC0
      115421C88780390FE3933C6FE5F33D77DAA9BE6A96E18F869820155AF7FCCA17
      469C76E94B5B2C8778B060498B2F18D65C210BB921531F687D3BA82524B736B2
      FA0294CE84FFD2894820A695A81F36D8643BBD06364FD78F2A608E6BD1A00319
      C5CB8EEC56459340EAC352AE44BDD5FA6DC56B08B18A6A9C4614AB3AAEE7D5C6
      0B5D56F8AFA0D97C16C8FB0F5FDF7434DCBA0E648AAD8A58A033106A9C2EC8B9
      86A53C96069B1679CE565DC282700B7A0A39D4F0B9453EE622A7C0FF32052367
      366838B6A3367FC78558BD5FDFF1844EF4D4420A77B5DD5F3F7278171BBD251B
      84BEB4ECE95EF4F1F043CF3C9293CBB34E5425FF9C13D1A76933137BEB8568F7
      B74F0FA5A2384F5FA60A581B42BA02BF3595C93A6F2F0683A7A71717972E9012
      7D4880BD36E2292B5F52D6A6B85512386972D4E7658E4B6612750694FD8C242A
      5275E80A26B9432748D38047EF48F3CEAE39B93C6B17AC15D565AA5C754E22B8
      F2117CF9E8E4C934A23BAF611C3462788E914EA29BB8A450E21A5819E1308CBA
      60D112239463DD06EB30BE41199F724C361F736DDC8D5A1573882AA4650E802A
      1B33235BD2FE9C17A799E076F268980E1B20077D2D4AAB6AEE0ACB9B587A00E2
      BFE83FEF3FD3C46F87682EA1C62F202E93F49B7941D53C314445BD02787BA6EA
      13DC3F882886D9238EE4A48176A3427979A9C573CB94868A92481343278E1A65
      9EAB69B0C99A26173BE0A04A301DF478A244BA85506F5183EA4D26C1FA320ACD
      2870D87359D50E229C95C5783E2228994E78A448A6126F038F9863E2A6710E7F
      7A9AD4D7C518979353BA7691763DFA30B2C19F03AEF9C7432957A0D0DEC9E5D9
      3D98612829F3247F7208D613EB2A160D276F63B6D8C91282984516DA119E3B8D
      CB46EB005AC38402D5C2A2CC77E3FC0268C3CA64600F98654A633F679C65F3C1
      3883CA012EF9B21EE15E8602F5BFCFA7B3E8B270E599371E11533012E1EF65FC
      397D239D4AAA79B9D62C2FF2BE7EEA79FC15B5C9AEA19DEC60C1FB166FE92134
      15F3BA4EC6AE461BFE098E17D85DEACE044661F24F2C64CB3636BDCB3053D63D
      534FEE30E5C3B94FB9F6DF573D91D3589B462A12E341E3E49B0F3D083D926A92
      BADFFA51F783C589162E14393F70E320103B99F47790EA89760E7E2146C4E516
      0F534697AAEBF964C2923FB1A85ECAB911E89DB4D2355A9D6D55C92D13527870
      BAABF074103368FCDC6A952A37E82A67451F46A7D21C7C1241D8F3E0263CDFFF
      7426B720178FB7F04436B7175D018A212E3D9EBBAA80DEDC9C97135C3E480814
      DA0DD558EF5DFCA727251ECB14B5158A096257753AD211D255C0EB8BA87C58AF
      14DF4CBE45A3A228C7694E5E6970A607DFD04A93AB7AF6613106E8D101DD1E02
      CC336214976301F21A3166AE7C5B946B2245CBE3D9E271DB2970D9DC041C12CE
      5A7758D42046EA3E686D9686BC74B011830195ADBA8326FF8153C405F01CE14C
      BF17446A7A226A46E610DF54D9ACF7C0240D7DB99ED764CDAA3FC11729E7108D
      DF0066757AAC8150A923434A38D3A508E3174815F1AC0CF6A0177C88D8A03C2F
      144B6BD1DB916E55A657D74033CA1C56B5BBC05DE715C890E7BACC626DAF8173
      AA9C8C56BD4FA28B5F60B5D76D52054414D7936D72116F88AEC1A9CF5DE116CB
      BFD1A07530EABD151D15052B371B4B6C245CC3693EBF57D4C9A50CD60562441B
      6442865FF751120C376BAA018C0B959CDE9D5C9E1D550649EB87CC1E3F398CDE
      9D5CC161BE8441A581BF23398477A26102B5A9751BD5CDB5158D50DF82617E26
      8474796CC7A3B2A8A044502DD1F3593D4022CC394EB23A162968B1FDD60DD77E
      D4097E4307CB898D28462BAB40937F1A84301E70B67386497D432EE34DE1E903
      507A17BB6813D794475A4F2B4F06F568E129959282D5394BC09B27BCAABE711F
      D42C84332572D46E3EF4FB035BD9BF746F417B76B10D63A74A1658E9CCC470BC
      1D8F4A504BD3FA6F6A36B5A4C6F197E7F978F997574399BEA870D809619204C2
      D6F25AAD1D6162A421DF0C0E42D00D376E4250B2A958B9D0FC468BAB2F412196
      A46CBF20CDB06062DA0A576234198D35686CA39DC6F9648C148186D9ADA32D34
      BAE2E68B0109D987BD60190419F30448A4B4DE9C77A25326EAFE253AE2061E8C
      CA02A9C5A2CC41950EFF2DEE161445FC39197D41E8A5968528F77FF07AD0E75D
      EB178E8A198127A91F6DEFEBA5E08257E0308BBB17574B56013916345C5C7EA5
      69193597430B400343C74401110BB56F3ABD5AE9A213760EF4175559B4D1B851
      7452077D755B2F511A2E7B7279E6CB32ECF853078BE6A668967262C2AD08BF3A
      1F7CD3B5C49166405B2CF4C626C3ED709F23F17AF15CDA709B8B958726A653C9
      7260330B674FA58C4E8CB81AE292E0AAD8909D166BE24EA7CE366BDFA1E16515
      0CAE9640DAE8FE6A5306033D3B48882373B78E7312BEF5E86EBDA2240534B4B0
      9AB78BFC1428905CD3CE1AD2F0DCEAEC2D103C2BD17AE6349E15E37D0EE85931
      7EABC0BBA893D4EFD1A5FDB77DF9CE5551BB0020BE8527DCE04D486EBC029608
      44085180F0D74EA27093DEE9B9DB1C93708161C3726B06DB511476F6F5862B13
      895ACAFA3069FE37FA95433C577A46AAFADB5EEB5D377346B48240E8935CE198
      6521B7C67E49F3B04D978268FCAF15FBABC19CD6F3CAC6BFF5EA86C826D419D9
      1DDEEEBA88314F3849B1130D25192719C0D6E77647F9CF5BEBE06FF0B599AAAE
      11442CBDF639E0165463AC79882AC74585618044C14DC50379728503052F6FE3
      89597D5F8752ED8E3F3F2FE91430FD5BD3AA019F30B143CE4DFCA5AB69F3C5BC
      E688EAA26A9F363B4B2AE790EAE66ADB3B50148F5D7F242302E0F321E7553299
      67ACD91363EB4BACD1854544CB3678BE6222A6FF69324E8D7755EBDFA3A9814A
      A831E7CC28D29A84E4E51557090140B04038F37681B59ECEA17403A9B588C2F1
      D1F35D602CA6EEE8A37DBCAC396851F72C76EC3F71CEAC206C6080EB311A26A8
      FB306970925449F0EEAEAA8C71B9D434B31241FDCD4B619BF13461B5354FA70F
      B8B1DE645A292D890759AA8F7B0C9EDC784458CCB407C430FD1A678CB8141CB6
      4D9A9054A6B625D72E9A0DED612C031708B252088E3954CD53C1128DA80569E5
      2F8D6DD9AC2580C7B945168A34ABCDCAC0CCC643FF96E000413F96A6789764B3
      5E749E7C9B57670572A07F4EEB77F3610FC1491CB694E87D1FD76502F73FBE5A
      AD23614FBF2BF7B0057DB85B1F919B9B341F23CA2D1DDB4E72176F03F172AFBE
      C9615EC2B2D9F4896E645475DAFF3706C33F1D55A78069B942C371CD4B4002F6
      88F479BD1147F6B7A25071B55DE764AEA25DB9735C690AD6EC1158A146C4720C
      719F62C694ECE052B47E7B804F62891273DBB24BBA6C74B4E49DEDB32A29BFE2
      54FC90C4D92E8FB311B31D6943F36092EF4B9A1F6E47ED3908C1D111681D08B5
      C0FC4B3224FD6CD7455BCDBBD15136252A55EE7F7C52355679B06C502DA9B4D3
      457266AA229BB318218035C9D0F7B1E222BF427C379ACC5962301C7C1BF4CDB7
      ABAA3B92A1B1B1D0A42C8B0D730B9AE170A3FF5ADEDD52C73DDFA00597ED1B46
      3CFCADD53924C3D737A24B596C3723CEAECDC23373BE5149AAD7D650696A407B
      09156D53F152D3A0BA4F4D333D0B7ECFA1DEA891FB8EB63FC5FED001F7CDAE1E
      F38576DDD9092C05EEE534CD0B3F4C5D268ABFECEFF5BFF5A297FDE7F8BF7EBF
      0F8B53AB2F558E686416A140733C85BA26A89F9AA1AE123EFAAE8E1FE556BE60
      DB2C3C1C24DE0A83BD350D2EE1443341EF01E5DA81542653041ECBC620AF8672
      DB1A422E31F43ABDBACE7805A34FD6824CC7BA59208F41268EB25929B590743C
      D992220D6EE1410A53C4901CF24D375749B42C3C28EB9E49D7EB3397419FA195
      5462F5A07E4F5E948E67DFCAFFB5A26DAE7B69800ECF32C4AD3841360A789E05
      AFC605A280FCB35FB5B0D693721AE7727DB79FBFB2FB9ABC63916BBB50BC865C
      7051F4A363B93C640112C750C313A920952AFDC0DE74FD4D6609D46B64AD899C
      1F222D7A6D39D06B5A480E1E50A4799ED6B7F7A10193E270938E51B71D94DB75
      D3B5F88BA82B1B8CE3066DCD65BA9A0BA293664C5A91DC75CAFA59A64DAB251A
      E3BC48A7F3A976A59844D771A6F8B3C660F54F0DB2A76ED9D58D39194D4BAD56
      92C27616ECC0BA2315818C146B596D56ED7C935E3787DF15A6522BD5A97F105D
      91647611B695C44C3AF9DEFB13E865AB573A4E997AAF26619DA26AB2D265BA21
      AD7BC7277B355FCF423F70135CED10BAFFE07EC846D46A6EE3289E523ADB8F9D
      A523B2C12A8524D80281D30645691FEA8A106EC52FB67FEF4BAC6D7971B7F484
      FAE0C9CECBBB42C050443FB841BCD7E0C43EF2A81A95499237DE90CDC8227440
      64A305611C3346B11079BDCFAB0DA640107781400D419950AFC2BD35391932F5
      FDDF7D00F47662356DDF50B00AA8F69228B97B94A5523221E85043E7385FF8A9
      C6E457AD5EAA9997054F75249401DAB82EE7F9175475750A2EF650BC5B9049B3
      AA4B8F37BF2B338DD095BCF0AC1C32FF58B2B92C6ED69EF59D35BF6F5FD25246
      75FCD4194F0DC182D542C41B50191835DEEE083E41ED42290E2F1AB75EBE41F2
      CAC66945910630C411C38506AFD2049C26170E3C61D1E30DDE26797A95FBBF16
      08B8C2D0C7343EA4861AABEC61D718CDFDCEBE1AAA2EA9F152D5593BBFD30BE6
      895D92DF6A0935256E6CDDC10515F720B371C3F13B33493B18D8E11A5B3B90EB
      333F69292659AC89A8CCFC613E52631FB9B8C53DF39E1A8AF2A87D11B6F3C9B5
      B32C21CAE79018536F784B8B7A5A25A3CE5DCAF23A77DFEFAD07D095772E6722
      FB22A25F34ECC9FC112924A4012F190989D42FF65BBCB1E16D74AD02CADCD352
      4433A8BAF925B9A5C02EC7DEA97988C7A59B5EFA6410BEB371E22973E9F0A574
      01FB6C45F254691A1ACD45B46726BBBCB2D38520D484AA71C6516AEA12987297
      9DB74E0CD2769B8C0D23B21C9A6D928FF7B3FFDBDCB736376E245B7EDF88FD0F
      35DC8D6D6A4C51FD90DB6DF98E27F46CEB5AAF11D5DDBE6B774C802428619A24
      68006C498ED9FFBE714E66160A14454980E6C6F883A3259140A1508FACCCF348
      2EB1ED2497E22F1D655974EBB1E78F772D78E8422B1D092034FAD8C5B503F158
      4DB8E316B9BEF8DD742A2A06F95A694D81D63C18B5279753A6C998D02F4C48E0
      4F2BBF2429819B0848DB8E6736B130C2FE406E42DF12979890140537651A04A8
      DBDB4A9AD1B6733BCEEDACCC7E3BB7EBDCF6CADAEDAA3FAA0B8975837573A802
      82263FB6C10F34F5A1A759FD1C6EF5A3009D2BA382F154920972A66D18C8308C
      FA4B85DCA98386E7B6B68CAF35AC196D1D436B5A52D0505D4637D5F9391409A2
      5D36D8564C42652C625A73C5B978C4BA7E1ACA9646FD4EA031578924E17E655C
      F67EA4753B136F7CC4F1F210CC9A251249FD5B71D08BA6C30DB41B45E3877D1A
      036221C3862F10AF0934234DEC4D390E421744BF48B5BB522C90D78A9D1D5B08
      C37404F922F7C2035B9A3E486D96EE419CE5F762B6895BC655321E66F1B4E3F0
      F010D091EABBDC121240FA6BEC04F21054EE08481A0F01322F52D3D4A4A85C99
      B8FA12DF0AD3799ED78C22C12D3EC170FC2B3BD0DE97BE02D0BCEA5DB6187FF3
      D1AEC8B7DEF8925E4E17F0ED2DDFD2F51F6D70ADFF58DE6CFDC7AA546FAD3B06
      8EDA5B1273D84DEF792EB4EEFEDB3E42A5460D40E42D13F7AB00B7CA5557AFA7
      4C121F63967F986DA0EDAE8D13CA1A2CC289B537CF70FDA38D212693FD00E311
      90D248381F16D16D68768A86EA4EFD08B728E8E5F826A841F8FD77857B87C832
      6A9A4DD651BBDDF21A425044B0F8E280970CDD253D414EFBB3B54CBD5C7C6795
      97A8F19D06E01EBA4F8EC5300C1DC995962854CE8778667BD847741155B51FEA
      087C68766FCF3F9C11CD9198A5681868EDE3A81F8BB1CC8A117B776D0EBEDA2E
      EB13B6272E55C996A212F32555368BA50A046FE3F3264631625F3C155F93C5E3
      F82B906C40D804299FC5A0651A8C076940713B53A82866B824AAA99DEF6154CC
      5443C451AAC04F7F0FAA8B0CED42BA76637D04C740498B8A41F51273426B68FD
      BA17C7B3CF226F11680B6C209A06BCE221C43C83E1801019DDB964BB724D553D
      F5D72ECD7304E3B80081450CECF3FB15959428F0EC210156436F155BD5B452E4
      3E9D1FED312272E7FB07E7E5EFF1A93523499682C941044062B13269B147DFE9
      4B0ECFEED31404ADFCAD051A49B4CA7A60AA30B230E4CBEE18307BE52DAFA687
      615711115B630F73BAD809CF12EAA8870123E15B60C94583AC8847BC58CDF849
      06C12D150C585379A1654D5A45F92C890572A107C2142BE4B4268B5F2CB1F6D1
      38296E5D5BD4334D3E87A76A614C58B914EF384B8995DBFD798DF0370CCF658A
      EA64306232C6C3ADC753500EA7FF80521E283479D8D48726D4CA2F3EC2B14C31
      5A880557085FE90923105357F929CD18C3AE68C10F4FAC9E533F7AB85BA1A9C1
      B86CFFC58FA1509003C751AF7A5855B112D83E836022FFD46B175A416021B206
      A34D9B65F128B9637EB87024D15C02789A8BA70678309AFF3A5038B2FDF6F108
      877BB2E160B929B5EE749DC6821F5A63AB85862DA1EA38B2DC026CC996C2240B
      6EE495086FE3A2E46597BD5ED17814210A62F0CAD54A0D478B783552F4934829
      6CC9F9A7E2A17D727A618E4F90A4A92829E97968A260B5F254A4EF437E4A4C6A
      0D94CD2750B47497182C6C3CAE2D50A8AF71A6F201E55EB172DADCFD5EAB64F7
      86892E63BF88D2F0BDEDF01BD4A344744F025A1084C62A9D8C976D0D433F97EC
      92302BE341AE95EED5C5F731B084A55DF03502F554145F29182E959DBB6DA8DC
      4E8934AA1DBE5C739B29E301BBAAA2FB5BAA6A5B4B6091C8B167BE70C0585F26
      C625195CA589109F5BFF057D08E100AB0CCC49EA7FF1983ED0D8A7AC00DCA5DA
      58172C7DA81026F2C0D3E996CCF0C6942E2A3DC864BE7EED6E3398D0C1E757BF
      88D02C8F67A34704FCB22C137FB7B88974C8CAAD846B18FF4F9A86CB5C135582
      2460CA499E62C1457A14460DE628224FAAAFA5FC820AE5E9A4198F173B4A4DBD
      4A411DB98E34225084BADBF5D6955253FFA811C1AE460412E054E38974047902
      F422238F4825B0C29EF535BDC91C90D327A4DE845BA45B3EE8B618F0FBBDA3D6
      E3C5E321B297DFD9B8F90AFD06F7A3FBDF070707C2DB29E00C2827D33204A0C9
      1585D6836DF13FFEC2AF51A19B8BC22882EB58089B2F52F4C1F4B6627CA1A3F8
      119CAE7FCBDDE9DCF4B6FD3BC9D2C9C3646B2D28A9F97569D2684F955F4550C5
      C024F0516570845C1DFB713DBC6FACFC7B76F16AB9DDD2422F12730BCC5CB29D
      7D4849ED0D4A909BE749B87AC9BA2C6FEA4975FEF7D4BA17F1D8C088139D797A
      B27DECB363AB9E66FD20B939C3DA911750FFDA583F49ABBFC1FB5A97BC3A2E2A
      1FB09FC2DB9AA28B28F013001244F95E3180390EF4F94468D88A8B26196BB2DF
      3B4E464F03B28DA399C4C627A6926B99FCD5914E20A96B5F502901C2CC7E5DFF
      ECF2DB493F1D973E2901207120379615E701630269A2A8E5C737339596F7757E
      39E30432F8B29F5AE6852B1D65E9943E2755547A54D97ECE750D3E9C1293E094
      9B6697296DA82B4569DC17797D0F22D4F14981EF94A391F62158FBB3AE6B4BA8
      AF791E53D2514B38EE52586687DEAC48259FCBBC906942CA1FEC9B060066E927
      099C57BCCE975C709187B4246763D9453B084B829180562FD8B14EC18E51966A
      A559CDB554F1C25EA4BD1CA1912FBE0E66BE4A1D98454919B3C90B5F16B6A1F1
      B854CEE647A12BE2AF8270122B1325C12CAD819CA61EED86775E9E31BA16D17C
      8F5195090F91DE138DCF657D1070BB659C060A697E40924654FDBE7C38FCBAEF
      D5251720AFD2EEA0D3423F2FF382D76C07A9637DB90AE55654A1600BD0C34BEE
      E13B9BD712F49FD8258B227CE51AF61CABFBB0AAE9EF4798263F7F5DFFDCD1CA
      55C8BF2C7BD6CF7DC98A0FC53871F132C338A784A5FA976BF6F7A51CEBC3522B
      73559263C897C272F4688E54B6C2854CD48FD0CCF0FE6E592937305DD2EA3D9A
      5DA5CB8ABC587AFD0420FC09923C129639D97B03ADF5078169D56FB7FCB4BBEB
      5462A5DA123495802177F33024C24C2140A80AC44D65F4FC95B3BAAA85197341
      D3348725212B8F883FA8E1C137EED5538AD9E5E3E8B6C605A14C8D9946E8433D
      E777380F3FF03AB4E15D4C612C38120569B8FC8E33D63D9621F7C9AB0BB8A682
      3A2A7D8D8987501E66A54D9A79B323526A6B13E546CBE6D11A9476608B57C09F
      9F6C863174A3381E7233D40C19679BCF90AD4451EE2DFD06482589AC68A57F5A
      E88F14EACC77B4684AFF0D3260781041CA0CD25DA15B98462C2DF125FAD5DFF0
      B31A6DCA573CD6629A6A71C6FEE2B7DF71CA23A69A2C9B43B3D1E4A569156928
      88E784DAF83A2C14743D88163C134291B44715AD88DA140E9E1EF04CA704EBFE
      62F722000AA404522B42EAD4C4B92EBFCD8B788254E5E307C43AE63BD3A9605A
      70A88292EA23DF87E65EF9FDC0E0C5126A7E1ADE3144B12CD374A80A6BA6D8ED
      E5BD8943C6E95596F94AB23910B76670C80D29FF02F579BD1B5D0B83FB317459
      22A15D8A847BABC3279C50A2497C041DC30D88FAA176839F5683B3820F5A8202
      23F260B3B76FABBA39973E9C4B83BABF2639F20ADF9A1A832A36689434239669
      46A7E4EAEB2FC00016645AF9F7D0B4CDF8510BC196195C97BDB11A20DD3A8B8A
      AB163146E6F5592A2B58010C33EC61F736BB35846DA52E69EBCE92D5DCDCE592
      A93EE9BD84C7A0E0E27796C052F8B10673D5EC4F854F2D50687F7EE400C01B43
      F9404EF264C028235DD633915BB48A0C69570FC82E736AE26BD4DA2CA7E722B0
      120134AA98711ECC664FBB59603DDC79DBC9B4D40557E16A558806CD4B5EEB4E
      34F882EC230D6168B5F6D42CC05DC3BA8A80ABAA71DFACA67A6DAB8579A907BA
      FC1AC13A6BFE17C16932D4CB342DCC52D381AFE9A1589B993891FF085D2FBDB9
      91F87805592A580B9A62B7EA976A046E089DE0EF283CC30169FAC01CDA966446
      327093180D48F24939368282AA9EF51056294A391D798FB7305E5ED645F0D9F2
      12145E34E46E90294249537F8A5E3CE2E8585D02F828559888772E311D5AAFF4
      4DD50395285C6BC8FBB22CF595127714C449546AA77E17FA092C9DD7CA6280CB
      93AF716B493FE9A31180898FE7EEE3F1F61EE4436710871579297646AB47EFBF
      1682ABD63661A5E9C8D92FC55395594051BA0AB752F2581F759D0EADAE531765
      FDA4C850C7349D556018218E8A0810313432280FD43697EBBEC2DEAF8D875C83
      125D32D319183C71184A7F385405D86DE185120A2FDADC8045ADAE382F960F0E
      A7A3D49FA1627159AACADAB22E72459A49EE6E6F6F6FD72793F5E1D07DC8E36C
      CBDDB843082C6FB95B741E0C7A5D1B3BD078EC5E3EE1B8F8811B25B6A1343BDC
      2368761C5DAA4ABF88924EA5BEF1C07AB2A82FBC7170FADD5BB7BF7778614F19
      1458B0EE945030DDF1A392AA32CB9234D382CA60E6CD8B566F753ED123E9C4AA
      6233EF48591F6EAEF06AAD48B2852B57A45FEE42A3E58EAE905A8C598F05CE23
      5C0CBDD8B6258160B24D2554FF7472EE2365AAE50B69760AB34FADCED4AB1676
      28A74307AFDC37CC3BC3587727D3A0C32B4A4BBE6F167B86E70026DACBBB0935
      4F0D61162597F82D124224B229ED11D8BA4A4294878FC38BE32761CFB9BD5363
      5B42F8A888377867144DA2AFF143387B158CF6EB72A8A274CF9593DCFD7D9A16
      7F0F32D332830300481BA35F0ED9C8EBAE550D49AD0F2A8092B2E8F3F0533DBE
      8B7465421D12E8363AB69E9F627D2B5242DC24242FA3D436D06E1DB7BDFBD3B9
      9C823BEE68FB64AFE3CEDE9FEB87297D0DF9345C113C745B0B53C26ADB6B15BF
      D05CD6D1B54718117C38BCCF7D00EB72F50170694881FA0709427C8568E04B0F
      3A946E57ACC0431B70E14CB1EA2D951932E650004DB9F97CE36E3AEEF641DA40
      A56A568253F338CA904D2183AA7CF9F290A8AA8BB651155722B353BD35394E90
      5D30588F88F4318E97A443F5AA1AE68C18F24A182DDCA7691CA8C43E72D3E4E9
      76F10D2D1D285E7750074C75037D50A61ED7943DF8FDF99E6B330545CF0B93C3
      E3F3EAC25AE571CEE24CD09A9D7255BAA7DB2B459945404FD0C5D42E09A250A8
      A5A57297FC11DC2F0D13564D37A9A597A38C85D544EF81E9E1C553D0FD7AEAF0
      A123C707AC0D34CD1E15FCDEE3CF84025BA08D589E06C741C92532200A5FA0EF
      4099F7A291FB448526AB37A8400107098DC4AD8FA42463AFE0E15E5ED9BD10DF
      13DB66D5E229F2F0EE8A08F65DABDA939D70156040E4FFC0AB8634B3D09D5581
      B265E95A994EA02261AEAAC8A37C4AD4DDF8BEE4A5F01DC8E92F1CACFD398D78
      203C18EEDABECDDCB9CB1154F6C63091541E2D6764EBB53FD9D851E3E9F2DBB2
      207192F95CB5A1CF026D4E5177B11EC23C6222171F9131090B5EA1807A19509D
      BB869312B40009525A37E113E30B58A6F01710A858F32EBCA87575703C21D0DD
      B6E35E4929C63162092797CE48483248214A6CCEE74800684CF9D01E70AF6323
      860B82743CD0088BE938C9C9D2AB1C4575A4D2087CC47C3B82D6BBCD90A5C32B
      A4976C4E139C14E322A2C2CBE29F5814696190E38814B16539FCBB92560160CE
      606D9148590330A92BA820C0CAA689C61FD90D1012E38C2B23B0F28A4A34A964
      A9ACA257323B99CF9DCF581FA6D14AD7B57704F14137B00A4A3F8011940F2EEB
      A4CC7CC58A54817BD7505898ADAE8D0B0348B274D55CC034858F8AAEA28B0AA4
      D1D25188BFC89E5DAE4CE1B2C606E3D1B00D2529980D5C58B4D07B7735A86421
      17247F4B1AE63D05A67069D33EB62C3AB38E7669D12A237C1A2340560E810780
      9718E429ED1B8FA86E3DC5BD41CCF5BCEB935A352D4BF83E06B0C2FAA75D328C
      681F796DAB025F11F34EE16821A9E925665006E8C78308BB04C44DD3494CEF3F
      FFC1D25E4BE7A48CD145684FA58C6D34193D6227370A1228B772665C1EDFAB47
      A77BEF4BE9EF95198D282367C584B7EE662CF55AC8C8128901371C38F4A4D33F
      3DBA3DF4821D8D53992CB314DA64227709FF22FAC6A4EAC5B272613E965A9CA2
      C9686A64C1BFBE20F3B6C1A628362C0BB7D53C63DB2F1188074FA293CACCF249
      6B756C61470CC1B62A3D22AD2E18DC581C0156A790563CC275C593261D20CB67
      65D56A4F21A3A23F96848C47508F91BCFB32A56BFADD9771F755784304935CDE
      C14A980F23C922B02A2D60EF11608A969D8585A07CBF7469B795C81BE2408E18
      81C4E5940022E63AB98CFB3C2AF240926089A6B70559CE2899E333FD2CFD226B
      A628ED4539554B656AE101B1B48242812DF109C6EF9F52315A2482E258EC6A36
      4A6297FE06E3EBFCC3B41462DC1E274CB3B9BF7DE85DAC3D743A5AC82C2F54C2
      E88AE1714B4CB052D6AE1F1ECA3836ECE647BD0BF797A07622ADF99AE34FBB3D
      F71762EBB47C19FEED087F3B4A355FC1BFACDD7394CFAF9345CDFDB28D260357
      9EE5C3EE93546CB503ED1BF7B09AF03BEDDF273323D5935912C1ACEC1BD8FF91
      367DDBA68E401AF6420EBED43C9083552859934EFA693FBD3143CDE0229CE9E3
      6492148B0E767A15FB2E5FEDF47E6D02D1058BA6B73A720C920B34EEC327D9CA
      C1C3EFE2D204163EC34485B6EC0EE6B0730F9782AE37768D6A110AEB1B0D3A84
      42E9DA3D9BFCC3241F44193AD6BE5296AA56AFA28B766694E78414E77FC78384
      8F20AC85544F83FEB8A7770D1F475F825A87194243ACC6BC4BB3E03AF5DBACB5
      5B060A191FF59D7D940D30EFA64666915DD1835468471C9ED82035C1E3DF5CF9
      21965A6318A04BF322FB658997EBAA20806DE032FEC8B948E7A9215489B68743
      C1411F8E8E13BACCB5A318A9E42D7778DDC73F7E70512E1FC14F98115B386E25
      D3CB1F5CD44BB342FE986FB99D34A58DEC5FDC0588FA3F70B5535285E9724463
      D7D78F95F5EEBB247F6F1A01E180F258605040386619FD85641D49263DF191F3
      258FEA1FE6A2C767CCD77EC017E4E06EF07ABB372A91FA051E3779354A085A43
      095F966094490BA1223B1C65F18DA0FB2A0CEAEEE39E6427BE4CA602606F470A
      46E4C3E8BFD77E308732FDC2FE74B8FAE30B3073F393D6A31C0E6F9687570BE2
      FEBC4FE914562355B2265080B89A5F42DD3C9FE1D08D19602E1E1B322999D865
      CDDF547E1E4AB9862D7C9C7CD1D7682546AA2C67B22F768DB6FEC3AA2FF5D1F3
      AB3EB0B1D1EDAE7C94F0DD954D585B79D76275C26F6343B2FCD1D41EEAD6EF8B
      451A3CE8AA8BA863FAAA8F94A3E8B10D8FA7C3467F2F47F0755F6833FB888377
      21A77D940EBE2C8EF3BB9FFA301DF373F7083B2B17C7EB734B04684ECF6102BC
      1401F3491AA54B7A97216041E064225ABE99C083AE13561905B7105A42229C06
      1DAC8464CD1ED8A3915EFE04A3F51EE46B3BEE05920BBF9E7D7ED1918517F75C
      FE99579D6FCB4F2D7405864EC4B255169B5F8F6DBB6BF7D67D02C377296820B5
      F5C9FF72E573E8B28362A0E8F4E025EA2F4F229462E5D7526261B916568482C6
      1A4750719A12514FBAA644164C475792642806289FE3D13BEACEFCB20656494C
      2F00B09F5F86077EE61D8CCD021C20B691648A63219894E22D36BD5DFA358B10
      2C67C428DEAE81A497820617F2718FD54FFA5FDF7EB7E9D6110D0DBE30A70ABC
      853ACFB0AF5594A5F8A6CC46D5BDD15BB76E8EC6784B3CC4D24C4072A525528A
      C775F3AB1218096575EADEF83BB7EEF6E8C7B8E4B6CF7DB3EFDDBAC9B06B3FB2
      0432CB40436648E1E2E920658219A87A60886625A226CADD878B83F577624EB0
      3E986DCD8BD1FA3B0FB0AAD9AC776F6052324CCA8389A602A20CC285C80BB314
      A271B2C8775B829CB179DD1B63789131AC2A0F505963E4C072503C99011300D4
      22D21A5EA6AF4CFF21F9975359C4B6326A7E06298F57759BF6ED9D57E5AD74D5
      6A299D022E62A973DA1596824F20C8C4194F927952CC97C0F29FD0164C0E2F15
      571E7E138CCD74C647C694CF2BB3B3EECD3021FCBBEEC3B36E04729A5D5ACCB4
      40E3D3DC6BDDFBBCC3BBB7E613B6A7D2AB032F05924ED2211446CA19F01C0F88
      4958E9B717B9BB4AB3E40F6CD163258200E03CC0BE8E242D378F7E5A14E984CE
      91186CB7356FFFFD4BB7CE3553A56AD187844C86C79C612CF390A1B4929E9211
      3D1D61C70D5C42DDDB63CAB5907F023557F1E761D23ED7345FADEBB7FD2EC7A3
      3DFD98D6B085E889C7CE46882EA406629364906483F904359301D3FA06E6D48C
      B2A9BE4B68F4AC6D93D3E1064733FEB1ACADB465158259924152C6B5CA30A615
      2AD34908D7F6E9546DBF2AD1D0F9B7DE66DC16340A958CD5AD0AAD3F8AA69773
      24C48365410976D7C803A723D7959D45DCEA782EEDF6F368A3DB8F5E3B403CA0
      12F29C4DFA7071F0AEDCC6108F8D75B80D7593CB155B10B95184A936F8120070
      9391FF94B0B6593D4886BCEE73B6338B47CE939E483C64967B124F529129BB0F
      4AD1F0BE1A8C6A89B77C6FB469C2389FC52C632279661C65E4A1B8EA0833590C
      DE701ED1FAAE805DA5AC329FEA5F9EB5D153E23349BB0F52A965797C23288DDF
      CE14831B4A36CAECB182DF82368394A5FCA2478DAA6BABA4D58C5EDFBEC4527B
      CE592FF9B8E97C3C36DFD0D9CC0B954990FEAC8B8ACFFA069A5F1E366E6B032B
      C3A8FFEA87E6D322196BCECA7288441C328C5F4C61356DE2AF07A79B9FDD0184
      1292A97B7F74BA43CBBB2C7DE6FBAC5A31492DBE0BE012000B165E7691ADAA22
      E2A88EAF773B98D0C6060632F73D0073BA5266D97D58C3A74341A522851447AB
      7CD7FE6C7ABF66CEB3365A648A82561358424CA82F310933A90C4FD7AA457950
      16A1A49DD1B8157417B89FBBFE385A60C9356D2B8FEB28F4FA8E4AA68E95A867
      DD97762D1EBF4AB362304729908758C22EA4986CEC6C29002877D1C05CB7A553
      EA7336EB3C9A0ED389DBFE589DF9D741DDE2597BFBE274B7DCF6AAE3339DBA4F
      C9F4BB67BD9D746F02455F71E969552C66887028B1CC554EB63F642653E48615
      22E8CD6BD4E3E6599BFBD3E1C5F17EEEDABAAC9C5110D1FD74481A0270184E52
      F290B3C681939AB9EFCF3F9C99AAAE868B9A214FFBE378F2BC2DBC23A8E0DF61
      691568684A0329AA82F027DFE3CFDAA21D7501FC0998061535C8DDAE32ACE1B9
      8B4D85C7C88D413A86CF2947B7AC4E83795E88E0CBA46E1C7A4FBB0C6543A359
      4956DDECCD2784D04DBD2B2EA20F55DE0C14713D6963896C6AF3D310481FF10D
      2853585A79AA1B059E6ADCD414988228057541082A08419CC77101323F6BB3AA
      D90ECDA9127C8B530BDC10AF823C1CD4718071A321898677824F49C78B72194D
      17EE5031E7F4676F0E5911AF28C9E2ECBC5202549E83DA949A91271787556FD6
      344599FE391B7CDD3F1D8DF2B8405E71371DE7BB309251FD3A01B1652C99954E
      A9C69B17DF06E4016ED9EBCFD9AAF954000142CD4183BE46E3528E51266932F5
      9FA3972568341C76C47E8F92CBB97935BC7A7D2597D219FF9C4D0D7282B097CE
      0BD7FE0BFEAD602A5389C8D7D07102F5F3ACAB61EC59CE9374A8B289CF1B5B31
      63D0618196FF4054B58BB2359A6C25DB7023E0040A52196DB3E9E400088513A4
      7004FB50420002BCB2E5233844DE74DF74DFFEE94F7F5A7BE648974807081C22
      4A58B2B1301E0F16019982C1F770793DE0E212CC8CC623C09520625E52A20D13
      A19EC122514782AB9C8214790B81D978F005289DF2C4BBE4B69CF3D05380F247
      3491C2C7B3F64DAFB7EFD7479FD95153549900CB79AAAF2A513F5F1E1A6B9FDD
      DC7CDEA1F9D1A08B2574D882BD67BD9184666E60A33E1DB9BDE81AB9A86CD88D
      F389668773B72959150FA34308251BFFEF73D4957885676DDA123F307302AB58
      8F968840BC9401BC35F4E38BD90A4CE53225B90430DB382230C490301ACD864E
      8A1C5AE4330C936CD3CC484A4AAF4B9E2332255C8E25CBD78FAFB073EB9370FD
      69B231DFD3EE928DC2BCB865AA17BA2FA9ECC4F43A45F5FB594384221BBB6F24
      52401B79885589A5253356FC562D8345A3CC1092AE0731C22F55B3861F352BEA
      E9BF22CD207472C90C2244B8BE8A41750EE563EF2017B5A743F4E542F843A6AD
      2A0CB1DE5D01203EEF928061BB5EAA0B2FE8D42E612C04FCA6F26B4413AB94B1
      8839F94DC3B7DE5B6CD8631AF1271876CF5B24102019FA3984F675960E7433F0
      330047F96C77AD8E059EF9AF594C2A89FF5029C3B3DA7C9D8FC808DA993C6F5B
      C29446C7BFCA30ACD16E50968814E199F9630A46E282DC37B46626F8D52BA499
      D4D20C400ABC16EE05DD389FC931AC04660A6FAAEEAD5E6B31DDE623CB79054E
      E1FB3D508B6744FEA80616959D91E0CD12269B9E37099D45F9954A890F50C890
      6181EAAA6AAF485CC7CA8CBC878E9C4FB8C0460E52A9642B44380A08DA4F7C3F
      0D0C2BCA4D40F07A628662114AEF066F279EFCE15D6802D6986CAC8A7888A4D1
      CFDA0D77DC724C14E39F881C0574022783076A9248F2520790C7778BC6993330
      D66028FBB4E8EA12D0E5081BF3DA7075C7190AB9679A60D210261DC633BC8322
      8BA6F9F8EED5F33E2EBB806A7AAB240C09A6C59448838C37DDD7DDD77FADD540
      C1000E7D8D05C0D87488889819989BDEBE97816B707DCF00BCD8DB2EA9C34D2E
      0859416103964C6411F87AD37107271F65CB0A9A5FEB66CAEE7ADD7DDD7D59EB
      02376F01C65C04A13DF6DB42D573F329A73AFD2B4877E3628D4B2B2FADD6C54B
      C07993AB606A2A1669F9F7BF7B8DEF7FF73AFC3E9C64F22B31301C1A52068B14
      F317AC8078E3A96EADCB1E20A8DEEF9DF9F55BD9B9F1E06A6AFA73829CE4F17D
      BFB72028F0D8C797E2DC7B14E7B0371D9E1C9C0AFDB7D6D5285415105DB1B669
      36DD8C43DDEE2EB130B5AE8FEF968A2EF2DA6B752F322AB89AF5AE9C2D645C32
      0DB477B4DB71A7AC5B61370DFEB2DF3BAED7D3545F6277DB9A75B67FFE73DDB7
      F666E3E0E4E367D1F358D5110F5C697F4A5BE8C8E0B652FA44F10A9B8FD6C903
      DB837A934C40A4459C65D8EEAEA1BFE3F2F8524EC558F5D2E1506988F56EB0A7
      08EAE1ED349A240337D044E82889C743A3BF6AA9CBC0FF9138804091B4185C75
      DD276C6DC86114EB941798A4485BB2FC53B95832727FC459AAC2C8C4734439FC
      1BC50841B4D7552D8600597FFE371728B96DA05A6FC212889AB1C7E3DC945028
      31CE587CC68EEB49BC48E3699BE83F118F479A6FD04FD3996ABA007B7E6C57EE
      F4B621C7F2F565F7DBDA0BEA3ACD3142A9575A0B46925D372C90241BBFC40EE6
      8B107219823A3FF08E15565C621E9D9905046EF2E5AE6069AF227095A5BA118D
      0762D7A2699FE3BD6F2526BD384801911E277D54FFBB8D239557F522955F7BBD
      7D99FFBB1C8248E08DE77D6F85D7C642A30BD25A07D30210CF60BDC344B1052B
      99BA3F77078301BBAAEE7A4431B8CFAE25E299820117CDEEBC65A18310A61AAE
      527AADED620C4C83D49E1A6C5707A79B016DBD5EF0F0E5364B26EEE3B968E1A1
      B0382F36F1B3BE8E2D6FA5925337EFE339DE7F37BE2199E2E074B3FC05CD00F4
      A02201F27A11E7DF7ECDF0FBF551BAF9350B2C426A2EA02A83BD85E5E7DDFA30
      B9844ACE557C13C1DA0AD25A5A48562200DD6BD2AF8948FDBAD60EB661C5BD7B
      5D3CE38AB4646953ED5EBD903104CB5C38B1CEB59ACF8C4D054FECC31A51C9A6
      8E623249C651468A6CC7B467986713E6B0962C991B2985CE19F34F17A8428F6D
      57EB9C8E08A6DB02C5CDC5DB9A62297FCF04CC2C025753A82A13612B065B4334
      ADD9142BB75B30B9BC2D9E073E743BB722662F59ADAF81FC6DA06AACE71691FF
      BB9DD59B2CC857887EDE3F7BBDFDB5E368760CC47E46656DBEBBF28F7F9BC779
      7101601EFF988C44520F64772420085C97FAAD4A35C889526AF364478BAE357A
      152BAF7CAA56B395873A5C22A35AEB7A38BF20A904B12793801A725C4E34E350
      EFBAD4640FA44DCBA86BFBEC90BB644982F9470E55FC6932CA3BE01CC559128D
      F38E1BA748F08D17B9424FDFDCEA6F6D9F6D4DED89CC0E97191A65C982DAE4C2
      BDFDA6EBBD6E1CB2CEBBCD468D5A31AE048C4A810F63F1FDBB0EB58623E555F7
      CDBFDB5879C6572C74278BCC6836A5A92E1E332CDF2D9BBDA7473DC21AE1D1DB
      414FC9708FDE92FEA54B649DF151732DF96F985D3C8AFBA8347CCB976311EF9F
      C43857348C7A0F78EAF5384369B840C2E2881BDCD1E95EA35BC973E0FFFA2CD1
      D73419E6EA3E27C0962C8E73DE88D2337370FF11EA6B94076E824A7643FB88B9
      719D9B7AB635374902C94528062032E14A95D00C6CE98D874CDD9395EFF26D66
      C5CF76F6B79B544E9F3B7020BD12F04E2ACF4F66C5ADCA0CD44BC9EABBC6056D
      20EDF4B69B516CECA2C1A32B7A0109F518E59D08C509295C8CA3E9301F44B318
      03ABD6FD0E4E3EDA90A516F91BF9A9F1087A596F04893444F3FD55125DCAEC19
      C7D19726970974469097E5A17FEF70FBA8C125A90B6691379D36EAAEA1D1F02B
      CA5581218E1BC574F7AC9739CEA2CBFF03B2A458A36AE180E99BC5627CABB262
      07BE77ACE9D6EB9C94C61E26DF2ACA90254CB661A8D53C7F5A5E8B32349A6C40
      C04427150943E4035BAD22CE8BEE2C423FE972ED771D24345834C4796DF39F3C
      B41D9CBEF9E7C1C9C735D5D48A6FEABD40653BE5793A4898A5B4C424DAF6E72E
      1222B328EFC83F37F59FA3F4CD8C22F343FC30FD8A1F40CEA1FF64BDAE62BEEC
      381DBAD3EC32825D40E6DAAF20D150B8D76BD8B544A33B14049604EBB2D0CDAD
      4F52FDCAD67FE83FD0873FD61B6502E85F271E0D8003F311C8ED4D513B841985
      DAC364FD742B683FD32402324FE7C50C221F046771EA600CE8226C010320A313
      98C2485B250D0972205874AEB57EBAD5EDFEF6DB713AF4BDFBDB6F937498FFF6
      9BE51087C8C54391F4E874AFD5703797E9178DDD556292F9C6D51F0A595F132F
      35EF837B082C14DB1A5530B2784488D6C5F9FEBEC6F747A77B3E345A3474B0FC
      7F0334C19D20AE4375E3C5A07FFD472D47ADFFA8664745FDDD57EFF9298E66E9
      74633B9BA4D9C6F6643257CBA47C86B822BF8AE3FB8AA28FBBFECEE9DEC5C6CE
      E9DE6BA15D7A4412E3215FB09784B3774EC60CA44A93E87CAA1F07B56CB8E435
      6990B735DC3BDDF9CFE5CED04FBCE2F912549158FF96E8BDBB89B7A747362FBB
      6FEA9EA7484A79FBFDD63DC2C60BD5AD40D25A407108F35D34C1A7F0F19069EB
      6BDC798396BDDAFC7EAB74211FC64876C09548164BAED6DABBF4DA0679B9D1ED
      DEBEDE0A30CB59EA89C162430D9B0AC30FB58315D268A069996CC5C2570F177F
      95165FE2DB3C4C8497D96C4D89B7C91601BA4A640C3B38A7CDA2A1FBC62C3EE9
      F1B26E3F4DD369DC717F068935CE8ABAED1A0F5DEF2A1901B4869E3742B08E43
      6C275F92198164295157DA58B1116E63CACE739425F3620EAD7952A1F8D5745E
      C075074308290BA9D6C6F917B8FA45591C3D5383BD97F0E9CF2B7B974567E4F1
      8164C63399AED15D77D2D2BEAD091227BEA15BE3BDD7B796B2621C7AC637AA97
      C97755638CDC01443ED0B9D333403A323D22A456A6F349E9D38A533EE1CFA409
      D57B3F804B7FB32B2A47EADC0ED379513A1507E919D5663A6E3F1F88C8A7A81C
      8AD12F5F567D288AA68DB4FC5FB5EEE242379C0FA06E3CCE0DB482B2B4C0044C
      848D01507D24BE56362438A74AAA37B41DC693D4BD104CF5F28F218C7FF19CA7
      8FA0BE906F61FF17840B0B8276C268F3A57D5AEB040A6A6E274BAF73C4D2DBE3
      E29B8337F546837FBA40C7AD9FA65FA0FFA4D34FCF785B32725E75BBDF5A0C1B
      F98F761C1A617FBB4C296C5AB3B0E5931CA0D179900119FE8995AA230A7977DC
      8B74FA229811CF94B26BF7E322B268A843310EDB60B863D5DC62F44676E68B10
      E3A16409190A3AB4B705419A8F8139910CE05AC7CD842FA633E616145A2B4DD1
      7407D89467889796CCCEF6A70B38C22032EB10D6D45159B268769BCD73BE9B8E
      7B1F17FB800713FDE131946B9D327175127D3D664A157EF194B32F52F78F747A
      3DFCAE514F4A6A914D6A5B9BCC480BB7C08941409B471F8FDEBBF6E538ED4763
      FEE9E8E3D10985D409DA7B41DB5648474B6D7EF767519D87BA8A243634E9AA9C
      855B8B00E4E86EBA057712AE4F799E4D7B9E5FCEDFEF417EDC22D5D4893D0F81
      80B233344097E1288723564807383BDA7B1DDC3199BAB3EDDD9F6952924C9117
      5C6B709ADB39BBD80BCC592C51D44F87B784A39762973B67172754D66E70B7F3
      188243788D549DC4FBE2CA2154D00583DB26409DDEE686A207F564CCDB848BD6
      E941EF2274BD6D73137BD1A3FC8DADAA2F2C1EC0D2361AAD353F93D44CD8C7F9
      4C315E0A6255536AC5AEC7F9A44984FFE6ED1680A67901BD27A0E947D0F8516D
      56F36B1F9A939FE846DDEF6AFFD49B7FB7A5D87C49F4FB91AE46493459143996
      C38B631277CDAD3C2C144D63D25794F5D820E3ABCE5453F78ECE919C64F9EF73
      9CB6FB5934F81217771BA6A7B1CB44E88BDE2CC2AAD20471E41D9774E3AEFBF5
      7F9F2545AF48679FEB47887BFDB167D455704C7214344F0DC653D46A0FB85AA1
      A80841AB0279A93782B8EC79104D299F8DC4840F0602D54755EEADB725A26823
      B3006FC3A6008841B0DB9800952A47ACE2CAFCDBB160C97901EB816C374AB329
      BFC0E38431A018EC3E6708D981AFA4FA6B2EC493DB798EE13489A6D125ACE0F5
      E7BEC58E7CD7758347DD86656EFDB2FB7FCF5D1BDA6F92BCF80367397FA2FAEB
      5A7583C196D6FC9E67C787BD2655451F91899350DA87CFBC8807C4E3609DD872
      C7A77B3B1D777CDADBEBB883F7EFB7F9FF1EFE7FD16B726BE30B1EED5E9C5436
      0B75CB2967FA87DECF67BA1A377A5B7ECE68829B872EA852830697D0D99C3777
      87E22889F1DDE886B2E805A576436233C868FEF65EEC49F0FF4251EC573113B5
      C192F062FDF5ABCDEF36DFBD79BBF9AEFB12FFBDA0D825E96C9EB5457B4A99DA
      72214480D3D4FDB27BF4A91C0BCF11F9B7102BFCF69BE07A45D233F7BA688B01
      FFB3C6FA21BCBE620AC1575D9F55A401AC8DE660CD0E07350D1D6F1A1405F536
      32A2CEDE9F9F078B4A20B1812C53545C5D66005E0818932CD4E6F75C328A8FDF
      EF1FB0F7B0A4C9F0F9E5E874F719468CBF6BEB83B0B5EC2CFC4B6F7FAFE5AEA3
      AC7620521674E40E72ACAD3ED8C9D9EEDF3B4B8E854DD1FA2FBB6F6A4202144A
      92C55F376078149A43C918984338AE0BABF78AFD4760E1EB41CAE22B3843323D
      4375B41E33A3571AE566F1EF73FA79689A9C4553B4773EBB86304683278E5C1E
      E3607D5F4934B061B66AD80B1AE04AAE9E2722744CFD68703BE838E4EB208521
      192AC907D6BB74EB3FC10705A0CE0E41569F812CB3541866E96C3E5B6250FD78
      3615A2C10DF37340C1059A197990C6AD77E123F8DEB1702DFCE0EB2C290A8067
      0AF7E678A726F58F1A65404C428D3ABE19C486B0A78C8A529CCD5A58E44DCFEC
      0055A466F04CED90229ACCC8649A703B144387D19CB212058E19A28C428E3666
      7FB7515911261A647F1B48DCFB31A9DF08438912EADA752A830446D1EECF4C3C
      7B8FDF49F7D94EE52B925BA53F034E7D0C5B1128DF2AE064B5D58667BA6E35A5
      B84A00D26D78996A4AB95D02F6B3F8720E0A477C635683F95AFD9B85E78CF6C5
      11640FE321D6F58EBB10D395242F76D29B9AB7905EF52908512E50350D5FA193
      330B2B4CDF1C70E0604592259E92757447D6F187847ECDC608E069E8F2DB6911
      DDB8ABE4F26A8CA9842D872028B983AC83AB1DDA1157D51B28D031147C33446B
      444C42CCEFA8675377E09C066AF2F9F35DF650C28857AFBFEDB857AFDFE27FDF
      E37FEF5C1BFF8322580B890166BF71EFD603D69D493EA8D76FBB2869951227C4
      2D4C665191F4137AB77344F5D3E2CAEDC5E3D955E27ED9E712F5CBFE1B6F1508
      50895AF888F166832D1C64AF135CD02F88790AB53D59D1057A2A1A81EA41E809
      501AD5D4BCFBCE6D116FE3EA6E1C4F2F8B2B2FA7CA23CFDB4DD74F8ABC7944F7
      FAFB7A111D2F3448A72533AE7FEB26693289A6AF5EBE74574531CBB73636FC6F
      BAC3F86B124D5102EF0ED2C94694151B1771FE2D26E1FA2164CAD737DF7EF7FD
      EBEFDE7DFFB6D13989C6D853201B242549BF36507E87AE2D7B4AEEB6CF8FB73B
      EEE463EF109981BDD71D54154E6BAE367AE37D4A7EAA1F8C30BF2F91B0C1560D
      0620027495D4A73A0B73504D6E7870DFB9866515DBA30491E711A14DB2B12F37
      DD16F478507CA690A3E8C221FFCC82773E11A9EACBAB342FD618F9F878A6EEBA
      24B776EFDEB92DCC77A478B8847B0527120855C2AC488AB1B748058855181EB9
      CF2CBAF650FC894176960A4D16CFB29495EBFEFC724D7DEE4021671E54D63A41
      3C42E7EDA6C953BC7AF5BDDBF2454B08A0FC8C1082DCEC31E2C05F8ECE8F4AD1
      414199027F220721096ED0C2348FE5B304D942E17F1863B9E9C7D3E45240E081
      54CFE1C571B356BF745B8E214250BE671297657DC9A02ED8A0C1E71706D05825
      5A8BDF6D6181462545C668CD7D3088AF15E9692E472CF3898798BE393933D2E1
      0F07EF6643F175F91277A359529410273D91431D1F544E540598A80AAA01C384
      167E43ACDD6E2FF04E50C498A9B6BB1CB85D2A99DF75657ED680368CDC10D2AB
      BEBCFE96BB2D20A843CC9759944351A0059C660BD28CD7105DA81D9306480AC3
      E83488A6C33195FFABA23A2316A3766CDAB5768684DB5D696B8BC003C30F076D
      9CBB55FD31704E08351F1BCDD0D7DF62867A0D24F55F16C95D54E390D340FDAC
      D94D5E7119B863E0701E5F32FE14F02ED1165C4BF36EE0B3ED815ADC8DC7D1AD
      1A1432D553DA077BB10D7742C027AF5CE20B7FD93D3AB755ADFA785A0768F680
      2F375EBDC23E5336BBA20B48489C4F4B49AE287C46C88CCD672E5050C3870527
      873E3103349A498E793668B62E7FE7B6606BC822A49C683E18F21A5B80C9B8F8
      16E6404035BA23963E59785D4BABE11252B5DC241ADB746EB8C2BE7A8591B6FD
      31CCFF562ABF2CE151E2DF07E05DD793B00A0FAE8C217057B52C8DC182715512
      EDF42D61B4DEBAD95594377B172F316E3E32004479DCC41C39BCB1D853B0BC77
      CC047AD7ED44832F80354C872578989EE7B247903300A973AB616B6399FD6AD6
      4C0C1928EAC918FE1DF20236A17402C73720E7B260AE836A944514179224B608
      E629C5011E982B3BBE417ECA9AFCD66D399ABE5653C29AAB45A95FAAB9E2E972
      8DB2EE57A18176DD4192C5E249823300A2A42042C086178F46383F7F1DDF9643
      03719FC40D52B36BD67C2CCDA7BA41887E32FADCFA34079F882A0F6E5B4B78C8
      6359485AE611BB6E4F060182FC8EF53442D5400DD23F82423F24FA4001A2D933
      2000FC982683D8418BA2943C41583D9BC5519677DDB1B42897D1B0E4BD2FECC1
      3F4FE92088CF6D355AB5DFB82D55E1BD13A3AA8E29404B325C3AD63315A32680
      05A806435142A4A046816A8B0C04DB06BA04C289C8540903665300C85D6BD6D1
      5C5F95C2A1CB9CE61C04ABA075CD28CF934B103B14773C24EDC65A23B2BD138C
      7F3D6494DE55E6A650B9AEA54D7422F1A7A8D0303435DF32C92FFD8B923EB6F2
      63B6B4B03CCE67DEE5D06BC947D3C1558A730ED620FA3A120A966635B3CEE477
      43CA978B2BD02E8368708533B54D3BD7063F10FD308CFBF34B443E6BCF907279
      572FE5424D355A051BDD475E4D8280122C310181C7D194959E7424905303C3CB
      6C28D906E4B151262E1ABB93F866CEC5A857C4D1846B607E952AB0ACEBDAC2EC
      8AF22F2EEA03F1C766E8B819A5D97CD2086870A610D0B6A42E6CAF5FF398430A
      76F0603249F2816D59A6E156E6CCF7B2E8329DF6D36C0AD1C1264D6AA14EA993
      D11DEEB596255A3422A9759B0B5CDE948EAC78B6F4FCA7CEBD8247AA97C8D4D4
      69294B1EF0258AD482F9FF70EF5EBEACC7BBDB2D99BE9E6506D3202CC2340924
      CEA3EA21D5908D6101A827326B2552996E0398B3EB92A870F8A3ED933D4143B3
      5127DB1F0F7DBFB7855252E592AC75DDE93400A96BB95618759CCF1DE51A8836
      7ED347F28CBAA54831AC2364393C8FE6CCCBEEEBEFFEDA648698F0E630892025
      9DCFFB622149C41C612AAFBAF5AC3FCDE87663484C303D6FE7C5E89D49C574DD
      45A9951CE6F73A52EB8155000AEE52C52F52E6357A4526DCA9CC521C2297C3C8
      A94851176BA2CAA67882FEADCEA60D1F2581109583753B8CA79EF1D7FCE5BDFD
      6B5336297A0EB6A3F46C71ED224BE77D6F6754F105596B9EA756CEEFF9F6EEBE
      2695A480D24F66C4EF719DD5B0E5903B575904CA409A593CFE09225377C2BC13
      881EDCBDA4E48CCB23836C824D2AD67013F20856A1BF87E92C116EC79210141C
      73D75E9CC3CD51E3AFBF6D340E0E2733E06379B403FEFDF06CAF67185D7943CD
      691E7BFB80D3EBE171FB68F727E136B6F6A0A03F1F14EC270474E3386FAD351E
      D5015A35276A4485F2B4184D0A7532D51AD0F6F9F1A960C03030BDDF0D25A769
      EDBBFB3396314699512396523062588F52ED7C920F7C03D02F1C237C1F34F462
      A3A515CD5F055D9B83A73C1654E11997EBB6A16993A90CADCD359E38C834B473
      336043F40E320B888842D42B55BF1F6A21F11EB69D980A64499A6902C3BBB748
      D63BDBB75A4BADEB9F3115BEDE6741B6DCAFD5ED8FBA2BA1C14B4B6A516DF50E
      F394D4703100E81EF0DD22AD37095A5A13917BD5BBC4F6341ADFFE1103232597
      4184934168004E2ECAA8AAA7122E4258C6F61AA797B52E73DA1F275FB1ED9FC3
      726C124BF79E899C08C82797AC3D6F6D6C5C5F5F77A738D6805ACE9A73AADFDD
      C06F36365FBD7BFBA6562F1D4B90A6C4421EAC53978E802123DA13FDE605AA5B
      549A80CE4E5F86C00E72E1883237B2381A5C611874CA89980DAE3AAE17FFCE42
      6BC74221463A1D1717836EBDB17100136D3149A1A596EEAD6AC92C51D2F6D145
      F3ED68F35962CA40A8D9842554F65AED2728879A9BFE17106AA9DB39EDF558FA
      E7C26F53EC194AECB45061A62480442753F7B70FBD8B269727D14D10EB63F862
      A180A85A1DFD18E54B7F980A903E8D3601EE864AD31DC797D1E0D69D9F6C1F6B
      8084BDE807ED532DEEE95F04518CCDB2E3B68FF1FF4FFBDB671DEEE61D777CD8
      6B74D636BCD6F2BB94E6DB684975C782EBE588D538DAB3F88CB9ADA82CF56390
      CAB8596B40BC3C49430D3148873571A95C1436BC0BB9273239BA1CA6705517C3
      0AEAE2C44311CD514775B3F2B3D568EF68B75E8B68B4E3859301EDF55A61E2B3
      9B8610E5C09B8EA6B2A1056F4DD5327FFA45DD2F2FB2DB72EAA7531A9CA8A769
      ADABFF04718BDD8BF3A3D2515096432D290075862E1F950B65F3C5B0AEAAAB4C
      0B1DEA7296B63224DA285B69B83327851044EEAB6A3FB0A91E61F591099877DC
      213AB90339D9F1B8DE5E7F72B6BB55BD4C87BE7ED8DF8ABCE30E60F67A6F96E4
      818B9F478378CBFD142550D9DCBF8D9B3575F701D99D871A134B16A2DEB7E9FA
      07E06DBDAFFF6C6B743ADD72149EEAA80C55C76D4F2669072FA2FE08C4FA043C
      F667F7895B6F9CE11484F9F261EF5C6D684CD83E32528BB714A3422AABD1818C
      40F7398283BB42A2F56C8176CEF62E886CB55404DCD32CE124F4395D7899EB26
      D04A7436F86C5E816B1C2153024E6DBB3C36CBD5B8ACACE0E13D3C8F5EE4AE48
      4C50B17A79FC5E549E6A850C0FDC1BC18DE71556D116651378F7FA97CF0B76DB
      DD47E31F1A5CFD70A580C55EF2151A4B69D62CAF150DE2835FDCEC2A9DC6136F
      02AD11A96CCE7AD60C720BDD67C9A42DF0BD787D04C1ECD4B6344198B018DE42
      CF90AD031FFD413E57A223F4250B737D2ED398BE5B1034868D4033642C1D5A54
      FE6A3D26AB67287570E0857E9F133DD3DBFF9BC4196DA4FEE82529A4250B6C94
      DC8D74C46091E2F1F4A4978C8EAAFC755DD32F4471BB3F6D5B3A817D6E590C29
      2B5E456380B8C5354203D93DEC87C7E934BE45CCD6E4DE0AF4194A50AA416A47
      5E7D24F85F2D8857464D48CFAF09BB4B035616AFDDC2CBFB82B97C8D12327E12
      EC4D32BD6CD564B16944CA3C18A879CCB522611F70CF18723522B449B246DD46
      3153CC1A5ED22040A491E214151AE0C9538BB41452A7E874ED053C36393B104E
      EBCF8B421AA99F956676585A9744B7D46CB5FC4E28F50DF4E1A44E0F67F48E54
      72EFDC4C375F9A8264B5F16FFAD041FDCCF6ED46A3A327188B527022AD8615E0
      7B6D7E465FFE7D9C5EF2443F9FA54450D6C404CBFA384900BAF4521D7C59A214
      448E911E60E4EC62B586AC3C74F8DEE5A62FA8668F1A97EA38AE8DD7C44BB388
      C25C1E49D2D3A15C0FB7E93888C4E233A5D8E90B4845A75E3A56368D5209955A
      C4BC9A3114DB96F11277A48BFDDE47F9575C0C9E038C505309D33C272425581F
      B61B502579DCBBD7E3F1816B79795BA4B82118445FDA3C06D7B6402518E89574
      D1B1EC098C32A12C7B37466A7550A8515D812674E36BB004957532399D2A6C90
      EB9E70E64CD9A5E666B13D1E7F769FB2DB189CA62BA169E07CA9F890F69F61AB
      DC55F686D77BBC23F758F7EE47479FDDC151EF82B51491661413CB4A54D9E4EA
      FB7B50BE20A42F2F71083E0C6E1433848958650E76AC87C6C1DFCA9AB57C5460
      893638038FDF46AD591F6FD9A9A34A2D2FA54106A4891872A1D2A6069CB8A098
      85B53D21EB42BB4122340637419A7603B95CA672B9C46B1A4975BC42A1CE2621
      909C7A8FD3E1CF49E10E8F4FF72C160BD5ED4D71A9C41237B9E5A2F45A389483
      421A7C1AA3CBBA1C6D7F02178CA81C8B42F05F29C9559B9CF4AB6D3076C048AF
      910EB9A2342D9F4D12F150D7DB3F3A6A7C93DE34BDBE75D72A9719663C939BF0
      94B69D15579334CD9E61937BF5FDF3DBE790B48F0D8B913C03794025F418DEBC
      C935F11D6AD974F2918D4146162A9F0A2C374045322ACD6B86A6B04709827EAC
      D6A7350BFF02CA170F7BA53CA6E2535A38D44A1571DD083AD742D61F6F456A57
      79CB4390AEA86756CE434127F371E3224AC6421914E422D6F0BB1668B55E554D
      08C690781BD5A54748512A77ABB5AD64D2D868A19F40A299506724B2FF319FCC
      B4CC18598F3ECF4B63C792A51A675FEC95E1EC8ABBED4F11269FA5C9B41E1E42
      96B21E97320220B938CB6FBFD1DF9FE1BEFB725F62CE71A404D4207284F85000
      835B2B90AE9646F255757A8C81086E150C661B6AB516C7E7CA4B42BE048AFEB7
      617D044F21B2763196066C7022B2125D463559BE46265C179747BD1EF80E86F2
      1F60ED17F6540A2824B8B16C09A201CE66D89A0A17710C6228B5F080E51020B1
      2A478B4C3B38318296AC39F38F89AE921C2D5B20BF3857A815669A64FA744B06
      E4EC93E48CB70CB617DFCCE22C01402E1A776C79154FCB68513CEDA933F575F7
      DBBA2E7BE40BAA2FF5322CC920CE84F97F4F6051A7A935C540C1073B486EB6C4
      9C88531813553414B22417BC24AD21909F688DE67FFC71DB52DA33B26E599C23
      5E34D3F285CB989024D9BF7249ACED3802C7BF83718D5AB98328EC254718BCB9
      E40DEA9A469A931D99A2C1609EA1069D8E6C9EB5375DFFB688D7166F2C4C87AE
      DB910335331F000122FF0EBCB4A55FF93512D30BDB0E40DED0D649936533E46F
      9ABFA70541ACBCFFE6E59D4BBC964BB4CEA1098F53A4B2A4192B77BBDDD62A52
      050A5498A6E2DB2B51B6D4152861F935B994A01EDE74DC29D67F74F7DD68D57D
      967E473A5A41E3586AED8FA5BAB8EBC7D86D5577951D2F795C21AB00BB7FCB28
      35836341C96E475DC50B1C99F985B0A7ED1A6BC891F1270E2526908DCC2DB259
      08663834563E9A71FA554649B36E5C2169A60C18F9241DCE717CE1ED98C01B47
      D4BD53D121E33ACCA1EC211AD37499BF56DE4534BE861088AA6180202AD55BA3
      6AB4E3EE6557D5180E4EDF9C091EA10BE361A1F3507E09162E5FE36C1C898582
      F5B61E9ACA9293B69679414E5B5ABFE773E692229284BC27A15C9E0C3E3A94C8
      B138BC3C3656DC02D790DD4638077186D7BAB26B3F6D9F9F1C9EBCDF2A430634
      34182521255A5A2D638A0DD6342A535F28B089CE0B68B6D3A16637B338FA2243
      48E81F72093EA43A2A26B9FD1621AED27215422CB25AD35BB5918916BB0EBA8C
      5E7E4B74C2C763538F6509E4E0F48D9871C9B02381979D2E73C2B327F2EA5865
      E371AD923A86E52ECD10BE8D6F57F6A9482754883E78430CCDD1470972FD7E0F
      6F8DA30C93733864C639BA8E60BD0DE064D08BB1B30C25A0F07348B7B9CDF73B
      2A32311744A7D81146EEED663F294A4BA191FBC4BC4FE34DED4DF7A5DBFFE56C
      FFFCF078FFE462FBA8DE0E278F5B4A80E5085ED4D79725AB85935A47B734C5DB
      4E301A281223DB46B09029C50D708A613C2D647581F091FC08E58322D511D662
      E7D26A00A4C7CB69324A06185EB4C1F05A9629CAC5D0135EB4C5D0E524D0C620
      C715EEF18A22AF77CE4E75996278380DDE613A2FC2EAB95F5326695E18904451
      CE1A0D4CE2681AAC871C4879AC31668EDDF51A23293C57FA0F0F932112EEFCC3
      2D13E2F4AF6B23492A36A765563B9F74DC6EAFAC52328BA47BB785DA9C45745E
      898A788DE278494090164B1619E268BAF5A1969205B56533590CFEA6A980EDC0
      B3363946BB2E17F6F0E2FF98E79CD7B9295349E534974D2E2FD0355FE278267D
      8FEBE66B957BA3D411DCFC2AC1F80C6FCFBB5F54DAAEB075394EACF3E367EFCF
      F7645F8EA36C0CF8A6F11F6AE7DFFDED0C439720E68EA689C827D5BBF0CEFC12
      C91C1E562446D313FAE00A34628D2D849E5C16FD6521ADC7A6BB8A978B1FF8C7
      D3E12BABF8198E3999DBDEFDE9DCFD4A59E197AF363FE36588E824704A6875B9
      C8F6E2C2FED663D6BF48DDE98CF3991500F982AEBB795C74DDFB444261DD3878
      B2CA7C8A02456D2641E733ED8792C31406AFFEB0A7860FDCA3BC021236CE6BF8
      CA7424F04E4665D01DD8C2046C3FD306B232BC943078B2F6530DAA0B38B36930
      16FB3DBAFBAF7C379C743857F84716F726FC898900AE5DF6201D9993E3E48B54
      CFCCE4F4C561B856CB11F48517A9F0770423BAFED39415111DD66836F26ED779
      25A9231473172361A21BBA3CAA79C7F1D8ED556DA3C23E3A8C03C556D5DA42CF
      D1D2494341DE183E1F72962A2BCD5711CE3C006C212058ACA83C7DDB7E5DF7D8
      FC1E615DCFCAA9EDF7C7BD8B35E3D45F4BDDDA0F6ECA98839F827A422A555BB0
      E744884156869A4C2D4D8AE85856B99A00AAC124AFAA82206A904D3F7207B4F7
      E5979B77E1E23171C901C5366B3D0BB19E3089FEA18C201BBA1198BC7AFE08A2
      A03E575C9C90350393E44BB890CD9EA3B60BBD000CEC70304A32ECA6F48AF327
      F4695A240321108B5B6AC31B45EE3556BAEA4D982F8BC60C79C0F58C809DADBD
      739644E7A8882F217ED1FA49489EFD5B9AE6D2C9B965D86D1146150807C7783D
      0D006AE2280EBD7F5B6A71A499A34AA5F43042A8CBB808365773DB0DD5F54B96
      4533C0F62CCA78AEE53E585CB9F7906FAF3959E1A0958E90E3078C68DAF2C268
      50B9C7E6AA9A179210A668B2DA6AD6F61FEA2D2EE76DB2788806474FE2046186
      4E20F37610046AD5A4E3BADD35CD4C0FC24C0D438756CF2FE3AD8EFFE9249DC6
      727E681DD25FB26C413D935F15FC8212B2A43224DF6A851DCB86A7A35102C673
      23EB4509EDB682A9262632D7598A83AD6194A0115161EC96B054D9B01290C419
      6459C01D5937B7456D91AD5F53B75B1E274C6135F257ABF50834664421B8B886
      A9BC3F09C538D327F94467ACE44D0220C1608C5FF9E0BFFEFCF5B685CA9B088F
      1A2D4F0F5359B140CBB4459FB9DCFD3EA7D81C146099622999A5A5E735D7BEB5
      AEDB568935EC079644A01496F062584FF30A6143B773DBAAB0A72CBC08488055
      07797CDA375650CF3E59D3A8CA8E15D4BCBF320AFE8F71C45494B3E42A2CF13E
      48B2C17C82051D2A678D8B714A39895C9672FBA398265395745DF59956C63228
      F900FE2E56A816BB5FCBB18DEB01B3DD164A082E896947416C40CAA9EB7AA94F
      E561658BA33CE1D61D794720ACF0306DACE9988A4405B2F097EEF0C55756C82E
      5351BDA79ECB0FCD8A2BAFEAD62BAA31225EB4547D864136665AD3B5F4C0A27D
      5610B18E9CE1A8CDE48B574B949B9A42B015D26A86057ED7CF5D9BABB089E544
      6009C003BEE60665317490BCB9BB13C9B222C2BB92C2DC903A39139991EB1671
      BE8981EB218E4CD4FB432E65B361BFE2DD83100897CA50C2BA6CEB6E62D8271C
      D266A88D316ED76AA40724D57BE0335B1033265985341D14DE54B18B92BCF604
      0A712EA3BDCB74FAF8DAFE7FA5734A927174F3A7ED2C767BC02DAF0ADCFF2B9D
      6336719E921C7F958E639B210812F7D2C11CA9F7AE7B8FFCD69FDC4FE90C4588
      3174BAEE26D9EE814E3FA801ABE96EA990C89494EAB85B3FC463A14587133E4E
      99EEEAF84A1AEB818AC223031D276A5E452BB41E6281F73A9F227F85CE8FAF4D
      D7C4CBF14E877EDEF995F8FFFDCFFFF1FF01B9882746}
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
