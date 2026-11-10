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
      C3D8543A8EF51AF9247D1B2CB2C586F8E408A74564868369DB81D5DD125FDA29
      068058661125BA244EC22A1E2F0F77E2E9CEA9D57E8101839D5DF10892A5588E
      D58BB5CAD99BDC322033D5C6854058702A168E63E0623BA41B015F49ED02C091
      70BDDBBD409406694119C1ADA6E0CE81E3820E801746B3A56CEF520B6EC65444
      510EAF83A53A9805F050431F928254104E08C3D7438BEB42C3F2272A0DF3398A
      CD0C12A7949ACED5BC537E640F3F94C07C1452E02CAF123E900026DABB460410
      DEB68DAFAB3B861CF40D0462E8F2DB6CE3C55C9100A0CDDCC6A997B9284FB0E0
      6C721C107A92BD1E487F12BCB9274D1B09A8073F4E94BC76EF4261ECE2C33AB9
      4E1C94361563816E54C52B7B1FD4B108AA52588ECEB98B2D255BD84789C4D15C
      453BEE301B911B9C244C39F72D0BC78678BE9FE40433E4A122D0422773010E52
      AA47AC32490003DD1151A81759171888C8C0B0B22E6F53214748B2ECE05801B9
      297BAE561AB7208BD220A454406EBA6D455736343C4DAEC5D68CD836885F705C
      828432CEEE120527952F02197948836E60A15E27AA1F66B3D99AFF141B600021
      BF34411B53BAF0BCCCD0FE5C318307401B38EC6D0E5C71408DBBD0DA474500E7
      F0A8B4244896A1AE268C5B2E00169B240BD3E4833ABD7CA31AEAF4E24A45FA66
      6192B94AE3402395A48C3FCBF3670CC5E3D70A75E4279E5E1AB929FC99131305
      B3020EC951F6B9A160E1422F8BA4A9A7C3E7C98E96F0D9164202E283729A8107
      A715312D6F0ECFC4C604674BCD62099001FFB6B2B303E3C3F380B7BE092CE735
      61630024455198BA0E033A98890DB96A0873A6C4B168826A9A8CC35E53431753
      FC3A7AE5DCFEE20CA8FA4409998AEF17A63C00766F33A14189F47B30F1B15D15
      8909BA0F80A7FB01A05BA9FC45CA3FA66441BA422B41BCD3C7104D97CCCC2A86
      4DBE839DDA54BECDA8108B6D07311129621E44F44F56013A01941BC818FCADB7
      CB995083C09B53C0AE7399A597D381440B13657058F946002C1BCD204550D7B0
      95C264C0F4FE77A0BA7905296D4B257D11EAD2D8D1ACAA369AD1D66354686714
      DDE22A281AC8DC92756FA3FA1F26B665543D9695B53BEBD34A73A8EB2CB5E464
      6030FA092332F60EF11956A20BEB1B98158B2021CD6663954590C96451C88758
      3293DF93452F321B564F9F294E53939F0606210E5EACCB482FF8AFD5EA6DBEF1
      F8C4A49D614F2C0932DC6AAA0EBDD98C7CD2A64E7D223BED7966598A1038A43A
      63729124A48348051BA888C39292BD70309BDBA4AACD53EF7D50BDB53A237C10
      3D7686B01EF9DCB10EC89885E193843A993F392C5C9460285E9CA75BD3CD30E4
      D954DB90B3CEA91A8F55BB396AAABABA8C673A02488D0CA8E0567D8E30270A47
      E0CD9E1F3B31E89C0E30815F479DF39A6A75CECFE9A7D6F9A0A6AE7ACD367E1A
      D2E9EFC7B0ABD335475A549D6C2D319DA624E89397C0769C9FAB3A0C8D1B13A7
      AA4D7220336A846040BE2C29B441297B8474A52B78B936AA77D91E296F2926C5
      F3CFB1E5747522AB32C822001225CFD61AB59B2A81F1796DD62F30FC45F3AAAB
      EAAA1F671102518CF3BCB8EA75F328C70B1E9B417BA8EAEA5310A58599C6C9F1
      81F6838C24456AADD475BFC0F9687D1AA8463E9F3EB0EA49AACEADC7A6146F88
      8E447112B2E525A681F851E90826628AAC38C740E142361B083CB6098B74B58E
      8B40AABD8EDFBD83F932EA0CDFA9861A0E3B35757AF916FF79CF1560C3D3A34A
      D314283C5790E5C9F6200A923917506C5D22077ED448222CE5CBA88993D0D4D3
      17F231117A7AF9A6717A7155CD5CBAB842D15C70CB61750098249A98DABCBA46
      9D755A3F731EC8613B193206A829422D960C6EF665F888B027460666A2E61757
      C3CE33BD2C36B532CA6DD8BA3CCFF7CD950252589EFC39F6193F47C1EF99514D
      8FA03F655705054684C70B35CC300A0CC83D29411C9FFF76F43B839F51E19B2D
      D4806AF7165942914367F511026F1A50ADE564CD757D2FA14B5A9F6A6AD81A9C
      D754B3D7BB14E1003557E370DA0B0D7CD13D2525E612ECC3395CAA44F54F0640
      E0D26945C280B4BE14243EDBDD7ADB80D8A8EC8B5856F70BEB23DB0E0B20D800
      F94A811A99C5412C3F22BE4BF5ECCFBF96A79780F8A8BA1A96B042DBC0200615
      7126EB05A65054BDD5C55EDCACC985083FFC89619D28DCC5CF3FFC20992AAAC1
      8DCC2A84BEE08C9FA06AB767EA4A6139195169FBAB2A8A615E469C1B59AE92F8
      83FAB20A12A3CE3E5392D237B72E80CC20EF5A5EC5A9C35239326D465EE3B00A
      9021E05AF4D461B8A512231131BEBD1CDB55C38FAFCA9333F917CD5E29C51307
      3E175E325C49927CF9ED8C2C65DF7689BCFCF27938C2F15DE9A53AFD7C7E4ECF
      3D4105049DA19663CD418C9230CADF21071EF670D886AF9EBC4E6C48897FF684
      5F23DECA65B20859DD105050FC620A4FF2C7244E23DE3325B4936CC289113290
      90CA71194D7E2021B27FB883C82E6AC1AB43C4A759443501A2278BA49F0E8359
      84000545717040A3FC77DAAF1835F27D7566D26E22F281ACB6E267872E9B6584
      6915A9C95A5C02578CAEC0C19B193004F1D492D2BF090D101A7A02E8824CFED7
      17D09D9BD90617B6636C0DF95F928073896A84E15C614135112431977CD738D4
      ADB484F470676B4E3D21DF4429F8AD82C5E7E268F8F94BBB496BFEF3B0FB0F0E
      C60221050146D3A45D5BC50013FB0E615C3166E6FB2AF1B4F36BB1C79FBB0E5B
      758A5A2EB25A01D542C91C57E7C9DE7C43627E87B4B8E89E9EEE10563FCDC3EA
      1F5C161DFE7B00F352AA517A97FD3E952104A432E9EC83F3810DF99EBD311479
      5BE82471BB5998EE8F9A52728D9EFF0E7C8E02E601806164E20F34DBFC38EA35
      912AA8C9FCBA9567A07B26990FE77A69007014500185DAC5047FFC4DFC2081A9
      B17A910BBD04A3D828D65102872EE1B739198EE280264C1B666ED90DF409BE8D
      7D7A81556501F949DFD86BD58D704CF40744174926BAD221176A5F9AC8A492DD
      F5CD329DBFC83E27D788C59A64FEC1499D6261907DDE4ED87066F479343553DD
      54334C116B2D63E81F22CA79890345192524662521E3B87420BBB810430D3B74
      05DAED61CED823E43BC9074EF569B5D231930B31850205208088A1BA7E02E030
      2921A9828828F1EC3206279E43A4F3662C6CC5AA7DD004818E4E5881A41E7311
      2C93D788D3E81A9C9D12BF50BEA4BE15A40B02B84429419443F8788EDA0A9615
      EB66983684CA31B9B400ABB54D0992539B1012A1BC07CE5CE03F6413831C2A90
      AA15337BBDEFA646228010FC1DFC1B2C02372C4143CE15243501CCB89F981B07
      6BC9C60E97AB27355720C67C6FB54D7AA7A47607FD83EF9EFFE3AD9AC69583F4
      4D3173D86ACC22EC4339558F301FFDABB651DD879426BB46CA2C96E99A98B55C
      0C2DA85C15A67D159A99F6D6748F96C1ADE1909C1624CDA9CDE216EABCE0C8E8
      44F50290CAD8298C76C1812C3423C7739C9B6767117C3AADDABF1E1D6E1E103F
      2F1BE77B9078A7D05DBBA0B7DC9E91019ED4D40D8A32D9463E6AE72201439E34
      8FE9D857868A842B0810D80C54086AC904219D164CB133078BE51B3E85C4BAC9
      050FBC2CB92D12249EC412F88BA07458216A59A3F0233E4BA1DA1714AE0E2930
      618C44B8562120998C2EAFB311380D66B4A8840C914563912055DEB80F22A20C
      5014B75B970772F688F4C6AF28FE3C98E8E3E7526AB7ED6C5151F4B1EAC08B3A
      C248E77C2C8264095E5C5FDE9923502C1F5CA481C40F33D6AED4959949B505E5
      25887EB3E276808E53BB0A77883BA4375882B9C20E5C97200AB84C3C80498ADF
      843A9A65704D7271ECEAC6053777A730A012B9EBEFCF48EEDA2E91E8E2340451
      E694CDFF7E80F0750971EE912EB051898AE6C0244B7A511733A2BC50438A2825
      DA92B3F83926E12DCE063DA150CD5C6721D67A96853AAE9BDB5CD97136928C08
      E10DC479AEE7528790FCB96EAC87C124D64C7772ED8E0DDFAE52A04FBC5B73BB
      0465B38DFE54FAD462FDEA9B2B28C5E55C07E9AB3DDA1314E3C4013BCDFB3511
      6AF8B4FB969D0AAA5C08712092393F9757813A50E9C7FC93E2584FC2CC2C63A4
      FB64B33C1DBDA658BE14311192D47D2829FEBC0BCDCEC3FB0F46C862B79334F0
      AED70DA9F147CA95692AC3B41EE99B604686708D2BA19B8225AAEB502AF0F967
      CE05C1B6A838D53BC771AF6FE2706066E676BF98AC7383A9D6854BCA6B0EEB9F
      4F84E745B401FCC59C72275D2F99DEBA2A748F2F46A32966789D45BEBB22F90D
      A4804341F6D74CD80663855227BDC9CA87BDFC9C1514E5A63371D3EC5485C1C4
      3753A4A01AE11F6F1BB7B79F2095218BB3891CB0DD23F17C67F9A236F22AA1E2
      CAAA3DA8ED51A77F5A53A341B32F60DC5E7FE4E2B91F5527A26B0A369ED8AC74
      EC4BC89A82F69BE1FA7D205E92BC3C11C1DB0645FB1D5FDACE57FD343626D440
      77F120CC84EB0EA965AC889C69B1E34C94D6DBE7ADBCB6C09133EE108163FA58
      2CDD6A321460DE2907F3474301E1534D12BD74AD408BC0471E06B388F3592259
      015BD34B088ED880A345D841A62C4C000CAABB881F41532BD36C52084B265EAE
      C3A6130DF8084F8A4BAE05DB42D4447948447523B6AB031BEDD7362F08DEE5E0
      64D86C1CC0422D14569963356EA42BA3AF01D3BD771B9E8364B50AAFEA899D4C
      D65E98994D8AD5964160B1B6C9DB9A0493202EE857BD1F6A003B2D74CFA4B10D
      FC7B0959896340474B9DA695C959EFADD3FD2E63F91E4C2DE46DBBDB3C6FB4CF
      4F068DF6F9D517358975E4CDEBDC2581C0DF5A884337F02211022BBF205324B8
      408AFFFA8ABE57CDA2EF44090E526B1E84FE19F25DCE83E6FA7D46783ACE4DDC
      C19E0E2281E45269DD5D1EC9A70EFDDBE9E5DBAFE8AAF03A75E1C85FBF747A9B
      340AC218CD2195D808F708284773C92A6914AC0744BBAF9659BCACCAF08C4D6B
      13D0F624032CD9F845EA11037DEE724EC88689DA93DA72949657642219A01C58
      69649D84530A0876C777E170BC579455D9233C2C872941148329D1F7927D2941
      A574A6CB884B0DC4C2A0C4B2D2E4BA60152373DB9F7ED2C93F4C6C47424B69E3
      CD6519AD262C84DB665A79DD079DB30B356837479C6F12B22E00687478ADF89F
      8CE026A80CC5B2C167BB2E3861AB1DC45167F8F62B4D01B053CA7756F5F4F1AC
      37FCAC7393248D332A578FEB240F590100E53F319CCB869266B649BC18C1E973
      C8BD4279EC4BF3483F68D37FC32BFA93D2E20FB86C9B0E8798A36587E3030555
      F01521C913FE0DE90B93173CBB074EB2722521F910E5CF16B44B1B4BC2D993D2
      F70CE1FD316E3595418EF38653447CCC90F6A8DA7AD03B12822E26EF5F588AF7
      DD3B5B5AA9DC45A758530AAB1A2809204182445C382A1A66D4FB329B8484CC93
      F15EBB0054A27C2C79C682A6EE28057216546285C141FE990A5629165BF118C8
      A12B9343939D1D1795D1E4FBD7454C1CBF3B26C8774DBD3DFCE91D037178138F
      DFBDDD5A3EDC3EB090570E864ACB0DE1EA6E50CDF22654654387FD9E05082B52
      721D0ADD79B0A8DF61A8025754E4075587FC4B8EDCC803A00AEA5C09949386F3
      2145A5DB6684CA6973A97FCB27B8C7A5F644BCCF7CA1447035ABCAB5D2964421
      2E109EBF71928999F3AEE7FEB1ECA6E3B2CA5D729B83964634CB5D1C344C8C88
      4CE944463397ED73240365CE632AE0735CE84EDC7D07DBE9DD28C177E5C3BF23
      41CFEC58E2C84B6AFE6E7513FA5C411E87A92AA20F05155B937A56914345EC16
      7B7FF9F1F8A79AFACB8FEF8E2AA20CCDCAC53C3E800D9192149818F32B735004
      63E24283A71F6CCA5CFD677C4ABBD4E46B54F9B1FD515C9975FDF74C874C9E02
      C15E2F73C57D2C0D0A07F19B43BEFA8D301B5F69EC579B83E794919A621FA632
      8FE727D09C61C1A5329606919AE10D2EC8D43AB38025B88D53AA339E9B9BB8F0
      1F8472B054F5EB07317BE495EB44DD33092E4ECF75C92D73303B50AF368FD6DE
      5B80C24F3FA8A34380C33FA8A3FD57B0D66DAA43D5C8B90C3924CEC75435F292
      BADD68FBF2C23CD7D7817EFBDA115EBBF0C06BB5B4CB6C59270E4E4EE4EDDD3D
      D78FDFE587A3BA8FA624E87E3DE33DCF63771B7975A97779AE08E1635141217C
      8308AE17114A8ABCC9E64E6C5547995F71339AE8D8AA4B51C70D85A697CB10B9
      6698C90491449BA034B6D7D599E43AE0A6A3E2182998000549B12664D620A8E2
      B06E05404EACC9A773EC5E566EF2005C9614D7D49D4082E9106B0FB3781821F3
      2C8711B21D60F9BCE8D86978AC18992908FE11A0628B5D881C5449838218848A
      D59CE5048E06F39DB8B1EFA88A927621DDD4A0DA64B1D08452A04DCE988C9039
      6472F126E50C4C2408414DC603D5C9EF912C7CFDEE961E7781C4DBFEC7022D5B
      7A3E48C809A11C4439FCFD655E119E37B8B8E0353B868E2216CA0737322B8E93
      07D1324B71BB5EF7D63DEBC35779BD41EEEE595883C55FF913DB13E730DDB38A
      394964D651035BCA8208894509CBE1D03DA4E1F34891B4037899253EB7C40502
      5ECB52C3892DBB7AB3D5C38BCC432ECC46EC0517B2B05FC99827F7973995D9A0
      2097E18ECB310F4C0CB480701B6CF91D85D3DB4104DA33CD30742FD73AEF16B0
      61E06E09C64776BEE10FE77F89D62208B0AD2FB2287FF9E9C71F0BE320978AA8
      AAFE3DC33E4D40AF4FF5B9623D6D585CF4EE4C06C15E1B13DBBCD054DF1DB22D
      389C07535A20D05EF12AB7BB6D7874E00259C676B1945A46A17B83388AC05FC9
      9CE8140600C5F9B29CAA7BA1591F1D1E1FE74E38AF20D5E933BD7A7E10CE4C84
      009719767EF9E0B6E10025B22F34ABB7EF7E54A084168B9D8C853AC8C25584C3
      965AF61638F7E6AB7FA1DC8BCE28FE0C82B86C429F7E91E90D9819518D7A6661
      394235CAF914E82062E849068A379F025175C14FB3C44BD41EE739D5092A0270
      1F51C0C5BC962E0124F48BCCCE3230B3CE2D1AB65C4FC054BD0FF0229A3DF10C
      502B0F0E0FAEED1C0DD711FDFA298C0D4F0E184BBAD59432AD3590A84A1BD83C
      DF7A165000DF590F14C19714700912D198DF0395FF3FB27EDE15AC4BFDBC8B2E
      5078704FEA4A1B0067359C25D0189E1EED58F3DC1FF4549D7B4BF9660A6F2D42
      868BC8C9B9811B07765E6C02CD7EBB5414DF67729A26A281787BE626B5EAC45A
      D28B7B77A65075F8B30B0C4F8902797FEEE197A4EA98C967D56AF23902EC67EF
      78FFD9DF9F820A4C47837950E596DB87694B3A1A30B3863FEDDC1296EF34B68B
      13904D0DCCF4D92784642266D2BDB8EC35BA1797CD7BA653F9C1A52C651DB0CF
      2235A97D0854881E2957A224F746C2F2995E70D8EAD0961313449D19B4FA73AA
      558BF58C66E080DA14777645D610B3B18E7CBB70456CCF34A1D5A444B680954F
      2E577031EA883422AC44F300ECDDD917F8993FB3D480008BDB7381CABBBD8DAA
      63C959572C7106BF70CC25726C26302E26707674C6B0D76AC667677856483792
      391C1540CB5BC676BA8A5B49C32F1615E351C3CBCF174CFAD11EB6DC711EB8C8
      B7108671AC194B5803DA85E3818EE74F0EC2E68E57546B48CB8DC7AA839B0EC9
      4349DB4F368B9170189A544D430B26DA60C63D93D4F1B39DB46EFBBC936B96F1
      5811E8996E22D9B8227453ABCE41F9786F01FB33AC0055CE6305A653E2462F54
      DD2F045918A654E5067FF9B80E09CCC82BDCB8B2ACDBAF5EA93A1EAB26592F49
      A9D8195DB34748153B7FE82341AC590415A110E724B143A4439545D32084D5C5
      06111F638396A1750AFB384805E1CCA9C43CCF690DD15554F574A4E9ED9E6997
      3FB5FBD06562B43CDB63FBCD166D5B7FD81E95E82912700B02E1870433071281
      3312C098FA8FBFA9A3E3E382B786DB1DE696D58366C6F755FD3DCE0156516C10
      C54E5DBD89519B87EE5824648783B313FEB9D243BF8C3E91BDD30A6D5660B684
      B581E805DC2921799FA8BF1CFF54FFCB9B23B5D73B1CFDDAB8C07F2E0F47BFEE
      BF949F2100B6F3616BD038878CA2DE1A22917935595AD7512080434557F2AEE9
      0F94555585D829F5C6E1A5F1A7434A0E9F82F8F4C2A64E7C571CE05C47FE392F
      30CAD6A972BF89EC028513E1D2D8614AF913242FDCA9A59050C1EDE8FCA6CA7C
      E078B1D16AD20E6E4EDB06ED037452CD65105B0615A66EAB8A1AE35C793E9B28
      A071CECFDA5D1844253A8562243A212F1582250F4106BAD171C00D73C84177EF
      BCC7D134CE66912767E40B4B8038FD2CAED82452582563E36791AFC11035E9DB
      6460D3C66A022DC63FE4BA00593F7D6363441A57932BE3BDE10F545F76742F2E
      55FD4395AC2639B88AF3B140394DE03F4B40DAAA496C34821A28CBADFB6609F6
      C2C85B737FC3270B535CF86A9B361CFD1749BDE1A82DBA83DBB8E910CECCAE66
      F3951C0244D047B64B420363985BD0F961A11A05DD5C596AFD397C4E62615084
      F9F24D099395A382893874FBBA7815EDABCEAF7DF0CB71103CB73900B2A12A11
      26C1AF76F85BAD51C95C7357B1E49753646A4390CED1033023FF594D880DE3BB
      D6BD32B5D4C9E5E5CF25FF82D8CBC9DCA5D90DD14A0D1F699C77CF3E15126C97
      D5D9B66BEB3032671129B169705B2D3CD0DC58F18D58100E4DB5FC035EF91E37
      80C80F714E8EDEA9BDF320323ADE278BEE4E41FF4EA19E2FD4C5B8253DB5AE4C
      68BD800898B6CF2C1345C235F9C8C6E38AD08FAE1BD70371AA0D1D572D314966
      0FD37DE400A97A8E8B233A40694730F462142B23969A5A757179D1716981D6CF
      92D149F87900C6C5265C174A78FF396DA62F9D661F11032AE7E00CC062622817
      FE85BB0832812482D51C40252E354603D7D432363781CD9270ED0A64E5CA1277
      CDD11DEE9A3260FEBB88BBAADDE58BF6900E2C47C784E2DC1964441323AA90E2
      E1D80966F0D9E3BAF952D2C3F121ED570F5A8CC76AC41319CEA9E97C0E32A385
      7327E67B56A5FA59ED0A9F699B78232EA7EA54F0B77C953628BC388E860B7DD1
      ECBDA34370D1EC551B7735B93C190D07E677095A74B9CCB8E11855D945C28A17
      24A594D3BFEC5DB6BF9FEA0DB66AB5BB7CD9EAC96A202556C3649DEFD010483C
      0E8DDC03F65329294289A918382824F1916F67786A16574385742F2E48FC5DE8
      05D19353B2020120FCC3A4641ED19A49802A5F378EFDA24D07CCBCC00B68C2DF
      B184158F16D60CABE02ACC7236A4F5B2DA0A9C7FB398ED01B2B88F0C07496D46
      0D168B343DE1CAEFB8A6FB1FEE9FDEFB634CEFFD71797A26F27532CFF12892AF
      FD40C574452DDD5E4B2F966A14A4A1D9FF281DABA43F4AFFFCBF066A4FA2B339
      AA6D5F217208701B02CB542D6D1332FA1AB1152B9D4BEE3E32A2F21E06BDA229
      58A5D71970AD9FDAFBB5DF1A355A97EDB3FD5A510BA8F63A17E7BD46E7E27C84
      FF0CF76BDC90F3F395DA6B7EFE7CB55F53FDF93A09BC440DD791A7F6FA9F86A3
      7DBE20EDDED98848EEB264D749360B5ABD4988CE2348EC2735F58F9149D2D32C
      F244BA0B7CC02185241976CFD67F54CDD6C91091C2B7EAAF7C6D2FFAAD7F7267
      D1F3ABF32E5BC2527C58F99C78731D8686DA86AD97989EF06335020FFE17FF8E
      D6AA33A4B59A1571C56A2AB07F75E23CFCBCD7290158F0CF13EBAF8908576454
      F5BCE35577D8E5E6B493E6621298286DD9104526A4493FE6A5A114470DA2A97D
      F0D2EEC49C447A2BE79A74D5A71FE56E806DDFACB8EB55165D4776F51D658855
      3549A94CD5C126CBE5AA1FCBA5AA4936A93BE88726236C2FB168A49322CA2C53
      DEFFB8A99EA50EE5DD8FD5E677A7B2F6CECE948A24376B2CEF035E7D90145CEE
      AD82BA6069E26B01BF521B198E75D3CFB92F8BC35F532767C3268A62831B338A
      83D9CCC4A8B06A9C9C0D7F01DA3A5D7F5ECE62ED738A9EB9216B44F0819B425C
      99C48343056261A9ED4F4EB749DEC429EC305CE8CA0044B74B675F3A6DB57716
      EB1BB8395F209A4D2CAE1C1587B10419B5F1B1112040AAAD17986CF933391DAA
      94CE11153EC0088644C29D01A832377FD43EA1020DAAE335CAD2AD7740C0C0EA
      694E9606EEEE52C4AECEE177A0D0A3EB0641DFD3B54A0347C058044A1CE51FCA
      C6EBB10DC306183FE843F2B57A966F6292262F1492766E757FF019C93B0EE6C1
      B0FC25D3519A2D542749A8FF923B512D9B3CADA22CBF0F1533E52C8BE84EE40B
      E1F402BC59AEB0A282E964B3FEA3463562849E2B55A14D90FDF2513DE47CC872
      CDD31E7EF3F7E1E505A1935D4F0AA4E888B8F885567FD419F454334E016A5EA0
      2E4B6CE2FC6ED64B2DB982C8272EA2BD9189631DA966BCD0BE7682EDE868FF4F
      82B953C1A46301A74C1F807C619D2A41399E40FAABE85FCA1FAA0B877A8F3C80
      52569E3B7FECA05BCBB63414C4814916523024DA1CBFAD1CD16167EFCCD88561
      D6B4D822080DC497A32083DB572A80A43E5634813F896E1753DC225B1086921B
      13A3A5B6F02E34E41FE7088916B8E38549E716D66CD3F7FB1AF5FB82C54E6A14
      8C4118190F6DA095F4C8E29FB5525FF9BD87B977F963520ABD35437E10C2CAB4
      4FB149B3580A1598A455DE41EC01E6784688E585921FEE183DC04791674378B2
      5CC1AAE4637BFBCC694B68CB7A62001DA14EA9EEEB52E0B5D1A99868D25EE455
      3AB728AB57DDD5A4C3A98B03D9D0209A0DB389547891CE5D4D08BB7840FF458A
      FE64DD7107A3715ABD25A50355AE2617C44016FC615C532A6CB9C02CDDE86726
      A57FE04FD53432B0B9CC9AD79506CE7F50C004BBD338853005CB629EDCF9C825
      6679C24A051B591ED7DD164D358595068099BB276F579EE93C27CCE97EEEEB2A
      8427941C0E5CA6A99E2C8D174C034F88AFB98BF1DED13EFA10CEEB13C28BDECF
      87F2ECB3C655718164DF78214E7BBE6A4472EB80C64C942E2A97DF0F5F6AF6BB
      A5E68E7B54E4DCEC770F96FAA52C9DDF04A22B8090AFC5CA5B2C731E8B9113C9
      F9625E64A05116E289241FF3BE8C6A62ED753D203BB580B508FD1CBA689C6ACF
      9C99481D44C1B4047281BA8E0D76131024F1BA1BADB98EF1E1A2D50657337A26
      7F0E908CF4F78F3064888B8324E3A0D9EAA80333730D0C40A046B3F8A8FA7AB9
      8645C617AF548D50992BE5B7CF916F42230CE5AE5C3757F6C95776A333F9945F
      6E14925AF50FF537557F7378787898F30A320B1F3304B8C689B22354F719ABBD
      FF71F476BF202BB54B8AF798BA9DD6E5F377DC949721AB76C9469B43708E0E7E
      3A38AE78F3C5C32D77AB453D08B9B4DF641D22E17D1FF3D0C7BC9A5D28928706
      4E12EC2E13073A24E41541F38A61EB9423E5FAB88F79B18CB31EC0C5E3EB10B6
      739918493205D422880EF630B48E016C285FA582A7A4A6FA716063F84276CA54
      4596505D27A1F5C0C12A18B987FF22F64B7569552EC62C78981C01A7F0773A22
      CB32A1E8C64654BD311B34E0CC3942ACDF42662E1DD2E8EA7FA446D554223804
      6750ACDA86086224AE49CD7433B0F6371C8B4E418ACEB026B78304A5E3CD136D
      2F84386AEFF0E0E0CDD17E518E28191E07BA419FBCE231641499F49FB0FA4321
      A70052368B22637CF48182C86F7A1EDAF5C03626050F0ACD20DFD178883ECE90
      02BBAEE18839B2BED2B6BE1AC0377A452FF7AA9771999BFC8E418480ABE0E75A
      A90C670DADA2A50502B57966178B8B0BC1EB5351C76C93D97F8525A6A999A590
      CCD78BDD6A10A33D6F8BDB40023FD7F272A13ACEC252CDD8F758D7D43F0F1BFF
      3C227DB2B0F1724E1578215431454570909985BDEE21B0A874B89CEBC6A7F6A0
      96F7791B7E6AB63B837F5E5C22513DEA5E9C157F12D5D878E24EF2A5A11E9CB1
      9EF9360C7181512A7AAB9A8468DEFB5780830A07BADA7A02C7B280DDD68C0296
      6EC9D7BCBA899641BAC4204B48454307D7D5588D7EBB8F55FEABFA048509C194
      734483E49D39BF0BDE171A3E05A6999C006604CF85F34EF319142B0B4B3488D2
      AF82EEC1589E8044100AF1F24F90A29DCCAF7B089740AB165FAE683A6D51FF7F
      65739BAE0B4EC904C23A1717135D0A74A12BEB751051B6A660C4AF2A03729AFD
      AFAACBFCEE3B3FF48ABB1650205EF5B146413463E1A291FE5A9A3A6920291E27
      A3E53A58CA056319C302105DA073091B440ECD862B5A519AD8E5DAC51DD6A211
      DDEE13091052EF79EB07C75D9E53729A8ABB3D3090B2C1C294A2F2895B91134A
      2401FE1625D0E782DBA878AE7C5F5D04E797ED0BEB9BAFAA3507323E27A9BF08
      063030CE2FDB792F8C8B803121F2BB6AA3BA2B9E5B4C5F8587426AC761094176
      16D9334E26560BB0C23AF220C9D709AADAF38B21EA98F135DEBA4E6A5562C9B0
      0D7AC336CB111A9CCFE0A389B5A7E01BBF1043445277D66BE194A456F5869F8C
      5EFE196D27B0EFF7D1C77E70F4CB4C999F300D33EF536194B9CCA487E0D347F9
      4A3FB69CC7E62FCAEA4238268A1A1ACA9753CB23F343778807DE4B745B246AF6
      A6F8BB9F015390F31755345F4B9D4D38274FB42F05A1AE74D4C39F880E8D0B89
      C844135677897604F974859D1E78EF6AE116D1C18E359EACC7A2C8597A8F7B76
      31A1443DB96EAFFFFA5AED95C8A55D92FFAE390EF651B883744FA4DA74010FA8
      E11046C4BD3D45A79B9DA69F2CC320CD87702F4360B13F8CDAABD3DF3F5CA8B3
      937DC0B8AC9F119D419481A9B1DCCB22AF1C23763304E5018F8571BCD3116395
      53AADE97F2F11B60DDA8AB0485A1134C99240488F25CF4AEDACA98B46CED7059
      3251B878108FACE9A4AE3CA7A3A1D0FF52F8C9A4333A093A23213992DD9703A9
      F7D9F032A02961C92595D960681D5ED7FF78CDAE09119C50AB712205D99EE65E
      FD8F0F7F84C1E47F867FBCC5FF4FF73F2ABB080AF4217D4AD84B851945C07095
      D325143BE7582A05EB84B887AB7196B1A973B8A6621881C2E63A6F8D8A8B05DA
      7D9F0C775A71DE35ADA63A4C0C750191A6396A2F979ED5934161865C15E27878
      B26CAE93DAB986D9BD43C1F2193B148CE6605444A8CC389807B11426A98C189B
      D05091010219D2BAE0FDE1E15FF3DE0524F18EE81705F3F29F4AF28F604211A4
      F1E28045FB24037AE72F47C7EF7F008D9C22DE04B49B309149929AFACBD19BF7
      3F1152B01481055F31FEF4F6CD7BE51B033B7689162E884B50D8410761E5B28E
      1E089D6F364AD31C8A4260C5F05FF2FCADAB52033F6BA35C50F06C65E1124F25
      9339E76807376EB9E6AAAE4ECFCE868DD3B3B366E3F46C3424C1C21D6DC3B588
      B78ACD402EDFFFF041B8B4209F289A7ADA1D7E7220C062A16A392608F343B827
      4959268909574DC8BB54E5079421436545E86711DF01E1D49C36E1DE858E4795
      D3720E9B562B314582E34F2AB877426461A73FDCD3EB2E172735C6AB2B875747
      C3110F9FCC99EF1DDE25582C637B43A99D8AC602C2C51F84B6D71D5CBAFEFF08
      427DA3F68E7EA84F02575AEC5E9B3AB0AB93A10320FD873A7A7358ACEB26CB7C
      C5627BE924296FE8E73424AEE8B5687AF2C5709F29C836A2A3BBAD6A8DF64D4C
      A23DF2CC07355C1AE367D4C50D093F1BE7F05FA11F7A76FEFA0DB2F94DA015ED
      C61D4EFB9AFA398B6D90265964CAA4F682736DE9C4D37EA03758EEE97C23DBA6
      C312577D334EE70B8B16E94326B9FF429D4050BA2DA07F8AA3FE3B08EC59DAD7
      71B1A93D9A487DA674CC6D66A1BDAD3802B406AAD99DCA40AB36BB44D04BDA7C
      53CB2FD12B24C61C431991E19385EC135F7B9D58802A0A4FD651802A392D552A
      3C90FE6A14195B3AAE2C371DE2508642631A6F1D315B2DB3B0555D941FB028B0
      EF4ED6404A5C42F4E1C76E7BC310451C979C1931E5ABA538BF819D1DE96BA6E8
      81E1656E916064726CE1AA27997566D2AD89561AAB8FECE8EBD38E3A3C3C7A4D
      87DE5104C13DC5BBFEC67FFC4A81F7D7873FF2A75EFF76F8E3D7D79586FC0C44
      43948EEC27738B33378B512743464FB8E6D6BA94C4CF190D18DD5C6967CBFBB3
      9F173CA62646388819C8C00895A6621B91453F250EE1C069295EFB85F589EEE2
      D9A6718ECE823D98F77E6C973EE0B9147F16D7B0EC594BF18E43C7E3D463EE01
      126C95E150F7CD295D2F8154002168AAE1D7817E8F7BF03ECB18142804010B15
      F1A7B654272E95FC7BA9F1E6919C056AB0CB3040D45E11EF4D3AB759826F51AF
      76CACE60C62572CBAAC002B21AF19FC157679333A9322E3605F1832441570882
      72443AE4740575372F18DBC5E1D8610E83AFEA972CF0AE516AC00487BC397C38
      D8C1FDDC1EBCDE48C9DF49BB5F4A721DBA24AD1CB846CDC0D76D2A808DD25578
      A4B4A5455CCF8B81D72CAB5ABAD5731312DBACB42B0C5265B3AA09BACD5AEEAF
      807B40081E08E3137126854062128D12E3A448A4A1144D33296A518D46A255BE
      F36CF329DAB61C00C9E4EA128AC5EBDC1A2F73415BFA75C1B733CC2675417711
      B489203ACFD199E2C96F343C3DFA2A40858DA4FB499899FEB3FA081B178F9BD3
      109F25B5069918B48C559D611F17AD1872A770611EE0A45AB2BE4EAB85BF39C2
      50A79AA04281011D5BE6E1254E5B611165764947890FDFE12EBAF4BB47F77DD5
      76EE54E35399A794C3515783CEF0DC518D96B7927E1DF91B05D33B4DA5CF427A
      B323C606ED70B449D95A6D17C559F9B6A3F26490BAF5B2FCF27E805296C64CC3
      D26AD19D25738BAA1155DBC402E6F83F9F2D5152986083608E1E57DFBF49BE31
      34E96E3782E8EB88BC8BCF25E07136429749226926CEF01AB512DE8944607B98
      5CA636DC7B113B0DF07BE7866AD01BA358ACBBD51C3C75DC371776744ED2C604
      B049C3CDB9DA4A6FA94A011C95F0C3E8F24AAA9C5D0AD29DD50A739A57DDC645
      F38AA9107DC4EBD1D0F77EAEA85A1E1F9B508110D707A1853AF2DD5C04502D26
      381C8D1A1BC40B0568A0C1C51F1CF3DA851BA4D96E5F345A97E78EB1036816BF
      8B16124573A4E7243EAC836A2E31D7C6C060417B4EC4CD5E982BC8F59A2C528D
      E501EF54718A204908455CAD94B128DD6003B360E220BEC79F514143CC16DDE1
      51A3D51D1EFF198462ABC929E26F5250E9D41BE56DB8291B21C308B158C06176
      3340569393756A3646748C9B94AA4BF3B6703B78A24C6C242B5D1287151F76A1
      6F509DD242C4C4519314952B73181DD106F4A16AFD1F19ADABC9691647010418
      B57F437D018FBA1BE9A47BB8F6CC0C89D7E77858FBF2E4EF0CC44C361C959DCE
      642B5CA404A5E1FD4361BD9DA23A706624190AD450C58723081002C75290D75C
      9855F1DB22148D48410ED764BC007562160AD0DDCED2280E34E07EEE38515D38
      9D24B654EF42B31F65247A5369365F46A79D2E2470C956E258FD9F40C0D5393F
      1F8F7F6D919E71CA6C331BD0E02D2F63F44AEE2EC593AB134736843552CE40CF
      46E99CE00074CD9871A3F57335B576F9F962DB58AA96D019743AF2205738227E
      2A912295AAC49E67E25F9AA3818C5712D2228FD98CE9DD9D47B562ABD3E12767
      CA3C4ABEF6ADC337A8CE2CC06FBA9A0C2902EAE2160527CDAFE783F397A70523
      EEABFC1CDECDDE959DC82EC0598951436EFC708E3C78DE0D9CEAF9DB364AD12B
      62F7C3401C971B24B377E7C6994D389A9DF373222EAB766146C4752E7D38D427
      9DA046260599E1F965BB049E17BF1ABF241077459F76D41C8DC742DD04FF65B3
      11AD8D0A347645B1FA6950D4855FA233DA06B72A7AB0C12FAFE890C92D65DF3E
      5BD6280822681B578227912DC4932A6E3F91EBD6A5E745E83C48B836F456E0D6
      658335A7DB05326097A11C98DC66A50E30AEDEC9BDDF2E03F425B93D0268256D
      E4F5D8D20FA914E0F5EDB3788D18773CEEFFDC1E8DC7447E1967CB3427B7BB7B
      F288ED0019B9CFF751887CE7A8799126FA3737080DDC4573A4DCCE174981148C
      2ED6C611DA70D3AA1D26F06B71BF860006A6561D915AA91654396B43604B99EA
      56E129071776717AA18E0AB23AD24BF44CE4A92BDA00FDDE3D5EFAAE4FBD68E3
      EA3B4A9A8B668F19915D209265C1197E25873A2FC566BD56CDD6BFBC1A8DC7C3
      7EA7DDE8F2A6BA0990B9E606AF06EBF93CB8188F7BFC58B26A2876B2FB52B52E
      4FFE3E1EB7F8C1C423C90B52E4E2B796A6AA41FFEBB0859399176C53A53B19AE
      870787688363B3D95C1D1D1E1C56BB4C9DC1CFE3F16AD237F175C1E349F55CF7
      C5102A8D01EA89F1B820A027D502202B52821BD441B4275B4416905AD2C376D7
      582351E8E4C7AB646356EF5BD3D87CE6BD549FEBEABA0B545EC5D373E9C95496
      05730DA1EC770F5D61B4F15864B513E4F7F503E0BE0576855DCC3FFE5CB3D868
      0F92BF7B3F6FFC8180051F8B36916ED3B0CF355A4BD85E1CD4A85C347566D256
      1C2CCC193A90158D485EE8BDCF4CDA8DA67AB1BE873F39E17ED054BF8F94CC9D
      D9A24B5479B62F3447E2731F801C2F1776657FA21086F96AEDBC5FA7C3D1B0EC
      CF50D8246934E31879E05CA83FDB1BA361D2783C386B0F0B057E8C441BDB509C
      1214E14F1461C20BAF23753EEAFCFA6407EFF4F2CD2EE6FA1D6B8F6F4893BA0C
      15167B216C770BB3C207198FEFF47480ABBDC1527BFF282FC53B8E34D278DCBD
      68B58A9B2C39F90BA0CAA56B75C593DFF543D38CF442D5D52BEA174318B357EC
      3F72190FF5D099AC0985583D05036AE3868410E4C449ED149AD338A2E21D0AE0
      3040EEA11E33836E526A7EA313C50DC0760ABD75E074B79EE9A18804BB804EC9
      DC4A1E33B25E8299B9E7E006CDD6A74109702D8EABAFF6E67AB93491941F252B
      BD24A00CA860F677895EE0A5A9EBC51EFC5594A583D24E5094680B110561E89A
      8FEE4445B9D04B06D33806828BEC5AA33162E81369D7364E720BB5FBFD5CC7D5
      4ED955DF05F7609D229E9BDBAB3BE460AF7A600C6CE9D4CCD0AA881B8A52CEA1
      BA9D0852C4F17878D16EBBB0ED1DC3FACFE3876E0E7A972461C6E376B347CDEE
      24D742948C30AE4897166916787DA44538F5FBF6E58998EFE54415D0FE0E86ED
      2FE20606525A9E546776261154AA0EA162A4BC6EA45454F32264B1731DFB9C8D
      6F5E754FCB6528AE88F87987CD855E5E69010C4DF7AAD3E88F86AA281FDDA04F
      2D37A779D6D9942FEAC5032372983267EFAE9C4DBBBA702726A3DE0C54837A37
      D4F112F4BB2EB633D149E0DD43C6DB2893F156F3FD4B7546A5E73BA0549D2A53
      0868462CBEC42851517D77BE5DB2E4302E849CD879EFCE5B2324C97A1A5CA512
      EE840932218A790E6481AA1C3226EF3F5F31207A91F787433CA8D1B9BC1A94F2
      BCC2C091C341D945B968F61C8E47E10BE331295802338DC7BF1D7FE529321AD7
      2A04C6C6E366BAB0C992CA7FAF983826983D4348663C6E9EB71CFEAA1F5B223E
      02A01BB40B760A4B3E70165755CC9A38821273A1A18CAF7E6D9E9F95F0B17F12
      33E71DDAB9BAA06C5D6D56A55288CD84160A58B74BAA4FACBD566D238C7BF6A1
      F8FB13C6414ADEDDD3EA0F11FA2035F474683845B0CB33A965B16FD50C399DC0
      A37A88D0712C4163700D2911F4207C0170F00260372AED95F6629546C6D58B19
      1C48C93BAA5D27CABD517354719507BDA662EA284CFD8B412E540DC30098D1CA
      69E9DF366BFEBE567E5B478D1399502A4DA4C287BC0EA22E4E9822E02181BDDB
      0121D93D4CD7A11132D3641716A35696A47621B79A88F640B2F0750B9BE0B8C3
      4880F217858D01A28993D43BEBC4DF88430410F53ED5A025D219D9A36A838951
      A8ECA762B5D40274ED26097C7BA9DD8C59A9960137A914F5579A8B4B8ED6B776
      A3BCECF9AAD08614FBE44CA15DA86A898DDBA0EB3CC91B6A0E52FED5DBC2E0FA
      37F13CBE6F1C1DFCC8C637B1AEE40D6B54EC981C7780C33E545C9C1BBCD5DAAE
      9C1810B06D449637AA9599C9A49AD8EA052065CB0BF79DCB86C22F3492A195DA
      AA7FAE340E0E78897792D82B2B3DC859B9797D5CF1D44ACF6374BCAFEC24B1E4
      8B7DEB79DF3A04B0DD9885892BA4E22445D5236375A1D5976230E100561F02F9
      74211106F82C9BD477E079BECB7958692D739E44C6E370E2A5C1F882C7729ADF
      782C4FEE64C8E9C6C6C9D0E18C1C515B88C8938D5C7E90077FD8557FE2703927
      1D9749304A754FCAC82660AD6BAF23BD083CF7C1FD1D86CB49B4420B2620435E
      9449A9FC11EAFAE138E8371E4F247FC88585A1BE95B561EB8A8A21846A12EC95
      DB45FBDFF702397D2565BA844C9640AACF44B8FA2C2792BBDD150188CB55F4CF
      CE2248D1F7E9A6A797FFA4A3F5CF53FD10DDDF93A48910269D0C7F7D2406F824
      39A77A965D6C269E23E2D82DA2D8CAD61A0569A858A5381F3BDCD2D3E016049F
      9482805393D388974E06C3426DA4842CB7AF43E8366A9013546C36751ADCF2E6
      E68DF5EA0FBE5E492E9158DAF17D3754327350FEB309B6D61244302F8703ECE9
      9F58A167A5B8AC6F5D706694969136AE3B1FCD27DB5D8E5F6728D4C33BD9C865
      4E9EAF92A2F2B7A979C8F428B3FA6C47010B0E906A92F6C2A6E603B18D25E496
      E594F6763A0D9827C4DA30610682B5D2E825385D732731523DDCD84E7B69A643
      9E62925AA69033CC5C8BBF639929562F9C5444F24B2D692ACD1AF3ED9CF51A1D
      6A2987322F9A049A1F056409A179D4F71408973ACA31FB7745E62A90C8E698E5
      D12AF0FDD07C62B717D5DE60E5C8317F04FEBD36EA73174E9B45C902BA292D97
      4643A251E235AC9667954A67AADB0A41AC184CD30D742E75FAA02812771F41AE
      1D5EA2C4A8AB0D8A2C12377A58111DA74237E046CB86C2E74FAE3599233B940D
      B9925A765534899160AA5E394665FF15659419A7B6034032D792AFC43FC655FC
      1C4506B5E708F6F661FF7361E1C04C93573BF24299C5D2C63A0E10FE91DE0310
      9838C5C422C604074898369AAD4187E2B0CB7C0ABB3883C3CE2FBC64426C0109
      805A7D1CE6E729FE17427DAA526D9F9F0C1A5454280C035C57561DF928CCAAE8
      9B1DDA953A98667F143D92A8D7554EFAB897CC8365F917E48F9E98746E125F57
      4CA4744FE5C2738EE1736262710D8FD5DFD4D19BE33CDCB307A315EDBBD60A79
      26B3D503F9C951F9CB768322000582E7815E34951E7FA563F47416B310A7DEB5
      7966AAD2EAEE59D39104E1A1E91CD1118A6322B1A056F8573A376B521CBEFD1E
      E9FD548E2D2247143E12317889CC55BE9D07C63E549318058357A5EF9749BF2A
      3D4058DB161472E1132281976A076DBBFBDDDEBF267687463585A952E9EB2EDF
      594D376DC22BAA091AC7A3562DD9ED985FF60A12B58A581614D5EDFE18C0AB40
      DD93B385577B0CE304734038E88B2BB24113AEF1C1F9546256B5FFF9DD3475AA
      81F81F2AA976B003FF72F4F6F81D32622EE77FA7783339C8590E171A3D9C8DAB
      13DCE25A7DAA49BC411AD31A74004A11CF3B2F7004B764828C119BEB218F4B2D
      737CFC49799ABA420277C9D44E14EB6C13F9559F1B71EC303B4C0C80BCF158FD
      3A3A07F2C0793D3A51A339924FEADCDC9870B731084C8E319ACD33A86632A89D
      35A0D5D967347477EC0F1AC57BDE9C54526457C5AE484CEBCCA40DC042A9A295
      D19830BC9806088F1206BC8A532652A161467DD0E0A2F635C2DAD170A597A874
      FE679E55A7A8012699DF348294575EA84D9286AFDCD9D26594357A7A23A6A297
      D2879CEBF3D12332B584A0ABC1099EA14E8EC31645B3A1FC67A9E1AAE6E1FDD6
      3C3FFFBAC9C8001B4B16BEA06348AD63FA722D46735CD8C1730DFC85488A200E
      A8E4C531E107A93B24148C94CCCADCA89B00D5E1362653E30615924C4240408C
      9D6635E8341B54CD301E73C7F2DC02A47B53C45EB893238812A5DBDA6691B632
      5CC6492104C749D468FDBCD3ECE0FF79B14EE612E421AF9718315D581ACDED63
      E5CD83D08F4D546DACCF901BDC3CCB579737260E196627EB00A0F29C680451EE
      C8ED2F5CFDE00E03F2BD104219B917B4CDA99DA12150DE9289513E38100EC856
      2D2EE318A44EA9DA969C5DC6FB703B44E0B4F0BBA2D529D1B38661C1549FDCE1
      B83FD86D26608A0437749210ED18B548449B29ABCE069FFB6A6E38AE16443963
      26D55768C67BA5D64A6B63B6FED11A0FD07F848C769F187594D189FA12237E52
      CA0B12C80E77C3F80ACD6113B5BB55113DDDAAC85B2A0E8CB09F4952F1313785
      0F9BCB3E0243444C5B771E852B0539877018F8031D31457E040A5A56528D947B
      D31E1C6E1655C11D5EF73FCF3E3AFA93ED230989113DB95C57CA6171708749AF
      E8B4180E5D3881854E96B71575498EB06A34FB5D1E9988439C0661C0966B427C
      B2163C7E0AF84F5AE2F7759D52773132F850754E073DD2D29DCB41575019F0B7
      1110A1F02C908B34D60E4315464BBB393A1E8FA9C19392302817D330EC82FB35
      720284963E428EACB28EBC7770791D4A002831AF14EC2B4EC94120892DF86CA3
      36C763A798DA868B2B50E287AEC174B288C3E61906755A70605709C2ACD90235
      6D2286392DE666F5F01600F172DA1F952B480FD4173A182B4815F0E8AC34414B
      D1173B48423D21690ACE5D001F217E02A022422AF9D6A8FBE39B7B5059361CFF
      F9BED39BAF8255D97065AB3B225FA9480025881460671C5F81D24C767972EBFC
      72F4424F86E3381E23AAF90F947070E0963AF0A091160D453DD65DF2E221E68A
      EFF10719810E26173A63E41B1690E6DD7D41793EDC417A7EB375B1F3F3EFEDDC
      F1327BFEF050CD173804EFBE72DBE5A25E1AFE424F27683E869A96AA2FF1F6AB
      EAB6CF5DA57F1F206FAA255964128B30B75E9811BCBD5CCD4E1188829D932A96
      1D7FCE2E53B93873344AFDD1E0E221FCF4F73D544E1B7581EB7F193CD343EF83
      7DABD5C435D0A423FDE97C5475089CA5FEF97FB9F2B82636E6041B437A79178B
      E3050E282BDBCB93BF4348B5BAA73F6F0691BA1147441DFA15318255E5E5A7C1
      4AACAAA37EB755E35A718A0149568410D9BBE8F12F83F336BD0F975675700FD0
      F201C9A902F5444E7564016B80462F2A1D24CBF96C26EA6CC14855B813B88533
      6EE5BD9A2048807DFCFE0A83877BD56CB93EDF308DF7B4C18F1F5497E9CDFF27
      07DF3E2A1DF0073EB81E09F2977DFA68C13CAE3C1D210C48C5BFB99DBDD041F4
      0D63FB4E26499C72791E710750E1B20450F9AFF9C3D02A42BB661942492B1819
      864350B802DFC1ADFBE6D0E2283C3478B4D929A23CF8A38FFE2F9BD1331768AA
      066B0F21DF47BFD1B90522649BB679F333373A7EECCFB4A32ADFD28F8F7D3636
      9E526A6B4F1FFDC689D9EE8172FFF07F935E27489BEEBD669EF003932C5EEF7F
      73421FFEF6D069A567D7D4FF38E4FF3B7D8667BD76CFDA6962E5177CFA334DB4
      BDD655A2278B7F5F4EE6E850D59DCAFBBC558549071E9598E8BA3355A766A28E
      D5F1E1F1BB1C297F78707C70F4FEF07D4592A0BF1CBD3DC4F885506CF6BBCF25
      B38BA2CD3353A2053E33A9D438089D05C585A9AF626C121B02E42DBD54280BA2
      5182CFDA14ED1CABAAB5ED0912304390471CBB12BB2E81C04B371A814A5F931C
      8C82B04C64C10AC18446CFA6E60A2056D37764F9DDA9E3CEDC0244E5D3A63EE8
      24DBE9052490045664C4EAA8550FBF92FF906BFFCD63F2E6A71F714CF3B4CC78
      FC4BFB735F82256414701F9AA383A3B707EFDF561E057DB51EF67CABCFFECDB7
      9CF7E7F6DE29FBB019E49D6B5FBDCA2DE7572A9650096D1F95648AD2F4C8CC2D
      020A14C678A66C2CFAC4E489A4D3FC86B231F9262FC9BA3C197654FEE75D8603
      538824275613474446AF8C814214BCC6C1C33D5D9EE888921F577210E131ECF8
      4054A3972C794A591139D654A146BD26D1CBA1CB423684AD62C761857392A8D4
      B22541A0D14C83CF457598BA83F6BEFDAA4ECF2F2917DD3FED2217ED0A7598B4
      921B012C54B08BBBBE95C795957CACFF81EBFE5B558DBEF909E139E98743CC77
      CD51F3E26E13D43FC34D70DA6E4F8B9E23DB50FEBDFF216F4F07D87DE93B1B4A
      F1DEEF7E543A41D70FF788E259F778105851A1457216F71456B8A4120E000A9C
      662EF31544B34485C135282EE4BC4BA10BEB5C49B87FC3F27E547D6DFB491F95
      BE8660FCA046437A0BFCF051E909EE917CF9839A584B7CB57F53A338C3772643
      5266E5BF9CA2D3F2FEF622DCAB2A4955616996E8E5ED9787AE89E2A4B88F684C
      E853D0C83F4DF13F61355E7C11B04FF70CFCD82E24FC11FC04BDE30ED52EB3A0
      24EBC498089D1119B28C1D615A5CF7696761491BCFF260DCF9449E7FB0BB7D7F
      FD6FB3EFDFFCF8564C9A775F99D4C57FF1D401C56CCAAD9687D7B0203CE13EAA
      F4CC6EEBF262E3995D900A91834A91780DF101FC30B17A570BC083AA947262E3
      31286ACB7828776630B2049B1CEF46D58D79FFFE719B7007BB8F82678566CD19
      42468E1C6593D06F97919832DC8DB441D12742DB144B75077D51C8C3D6CFC94E
      C15AD2B942E306B87778031433903795C3CC9253B8B81C754ADCB2D9B2748376
      49540EFB7F9734AFEBFAFD4DE6FB273F783C3E058B596E5AC1D9047CC291DAED
      149A85A57EE0799E949BEC40EC51847AC7E38B66EFFD568351ACCE2E0BD13905
      FBCD06716E29D8EE2CEB5D66CEA7FFCBF07CD8F8323C6F3FC323C1F9331E13D3
      4F61FB032051E47F760ADC9F959FDB8D66684BC2D26CC747CB35718F460DDDEE
      0FFDC7E56589B69B118379CB9009D31D3CC39569F688A49D1DAABBE44D35D2E8
      F07D18CD99777D29E6B3CB8E0F2EFF9E0F8E9DDEC1C9E2B7393DC54EB80A1B5C
      57508A2082B4C35351A8E4FA5E15858137661E78CF220584FDBF4D125C80A304
      4006A09040B38F91763D6988516740A46B546DE4B026AAA7D74A535CE01B188D
      A7258A51C69553A07287E0D17A697709618054111B4A48C134F0D7F58768CA9F
      36C56EEF6CD8E83547C8E1157647AE87767A34670649113B51B0A3E4E25AB67E
      6C453B701D1BEAF132D4964D89CD427282C07F47C66649B8A6F25A3AF9433433
      547F253C92D4B81115C1EE66FDBFFE7D66FDFB37398B4FC97494A8CDAEA62384
      1CE9B6FB7C05648312C75F5A2397C15D1F34F2D9ED0ED11C2E4F11E06D9D0FFF
      311E5F758788DD38910B5391096305DB351E03E9E5E8BA37DB218A8220DC2BA0
      C2565705DEE7DA1ED36A8304FA3E4D5FE90C05FFA63324A501A4C66EB325C9DA
      496CAF0D274AD1BA9CBC2B61E7C3ACF3D681950FED4318B6FB1ADD7EA7E4410F
      EFF1B8C37237EF299A85A1EA44D9E2D96289D42A7CC31BE0C02CE5C99F164CAC
      16C1ECA18D2BAE42E716510CC2EF07B7BBBA6E772EB8AA8B81F57D17BCD2D19F
      FF9B8EBE6BC6E3D0E49245B2B15A183FC8163B359E963E898A08381DE400FC8F
      5324FCA6C16DB524128BA0E7BF3DA0331D8FCF5B9DD63782D54F7D200CC43393
      0217D30FF59AFBE389FBC54958F03F8FDACD825EB7A2B24080B579D5EB03B40C
      1726872F6284E6558FF5982B81624E0787DA744E033E07A2E12445A19D9D323B
      47F3AA576D9328BFE13A7DA0ADDC683CFE7246BD8F86904CD5BBD24B9CE3F90F
      40E177708EB9757276F141B574AC6F74C450911D7C077E3A9A2571EEBD37F882
      E58784FC9D5ABD24A89883310EA2956A450C64637793BE60CF7A2634A699A6DA
      BBA679DF43E37CB0C3BB9C99F45C47B34CCF4C4D75930B739BB6C26079AE13E0
      2FD31ACC93A81B5DC697597A39EDDB95899BF1C2C69F7422C03B7C0D57C3C4DD
      E8C424E94916847E4B2F96356ACD9274A3CEED12B5950128D2BB89EC45F34607
      218266EC847693CF88A737C3B495C5376624F57E7718AB7778D5BB6F47044C6B
      6E47526D11CF8F00CD739D988E6AEAFCB8FC8BE39A3A7F53FEC59B6A6C85D607
      230FB16CA36C33E7CF0C4D344BE7B480C15405D04BCCC145FFD4D29E6097F3D1
      05FFD640C744E0E1D8FE31F435EF7EB2CBC3852D163240699C2A29FE4CD73B3F
      14CFACA9E66261D1313B5B90DCAE5135E1DC68EED6E97E18E8D47C5E4A696BE9
      776D14AFAD8C5EDAC84DAC2A5B174F8DDB41419C0F7A97959ED3E99F1EBBCC9C
      561EAE8A4AE9AE040C33445001078E7AC2ED3055273159ACE1A995D1223FBC7F
      01393F5C66CC617235EAFC2ADCE1029D29D127FB16A5F0CE300AAAD60B93B172
      25B12122C09270CB0E986F6E893E71B636A95268ECE679EBD378DCEE0C476A69
      135AA8831D8641A31CC924501D50D17395928A5B198ECA18E392B7ED3F570886
      1ED9CF52717C1B84750083009DF79C538FCAB185D0862650EADDE451630E4C69
      270FDEB151CB534B9665A9EF89430527738DDC50E94309A0630B37653820B4F6
      F2DD9D1051CD8BF646C0C475D690C8496360A61A3DF06A3C834D67889D648E2A
      F0BA125153D57BFE0EA830929F3A0BD961886578B251C153E167942B839FEE3C
      0AEB7649162E57F5156BB925B45202CF73CFB34A4F13CFBBC14D847D85280E2B
      0A44722AE693379DEDF27D21A42AA2C3C4375653BD4FED518D024835199A0248
      DB8E797501C14E39B9E8EC995303982F900F0E4FF76A781D44AF0A2F83D39B3B
      0595A9848ADAAEB53E0D18AA79152401AE351131B8AED32887DF699CFCF1BF82
      EEFE5B91DB27A832C036D94227A2AF20223065CFFA0823AA200A760F23CCFE7D
      515822B4616D77D6BF3C6B9CF52F4F4B8D606D4C241228735D3B3A84CA431134
      95207A2562469209A97531CECE32F072322F20B699E28916EDCACCB483184B57
      47899D839CF841B69627CC0C7B4C6DA2F31939E20F087993F76D10794514C225
      A9B59181F97608F9DB137A03483903AC73B8ABAF4ED68E9D02D60FAA5B567324
      B07FCF02EF1A902BE29BC4BEB992DFCAE31FE55BE5BA4922DE417610C161E676
      75399DAA9BA3831FABE2E6DFBC798958AA74751C8C4EE9BAF16DF3AD27487473
      9B1662CD93947A8A9E100A4475C1820E9D23C2800B6B2BFA52049C5309519528
      4F882C10A4202CB29D2406863CF261CBD84C83DB46924DC106A47DBF217D71D0
      9AD2241523FEFDD8DEA0A179197847D948A2D0C75B3A449F58D23B6A94AFEECA
      08E171DE90F755D3F76DA4BA916F6E5FE53C0C2E8C35318AB847F46212CC3218
      743A51AF04A0D4B28B491071C763FEFE8ED6B7434AB3CF543878302AE5CEE66C
      5908BB6504E7A54B67236248DAC19BC0EE2201D16DABD0DAEB6C295E3DE44DE5
      3BF4128ED62317FFEFDDBE3ABF501757C38E74015137EF8E0E2AB64AC895C1D6
      28CD684E23DC1C1DBC39387AF677B0F3285A9F6541AA6375F3EEE0F0FD0E239C
      99948263CD4133847CF1E651E0110096B19A80902136631652DE5723A27B8B86
      4028B587031601D94F05D183DEE52EFEAA831E71AEEB144D581A8EB38288C52A
      EBEE77500839A2FB03495577C39B09505905121B1486336258E1BF27A0A3BA83
      84AA64284D9F6E2839C3E1ADBA38AB44CFA3636F8EB2F54DF62DCDB47AE6368D
      C18941D1879BF7F4BB9B1FD549F398B3FBFF36069E37876F5F42220C4FBF5236
      40D529C0281D765DBFDD52F6411ACAD554F5712E7B97C07E425CD232131C4245
      48847A738D6587FE62701DB7823351C61D0376C0D7147A6CD83F6BBBFE78F29E
      FA9157ADBC51AE52EBDDD580AF2EFF5B9D68EF1A8710C43EC373611D13DE7006
      42926D028E301C594ACAA1E084E8E02A9B7C87EF376F38BB3C0B8DFE418F47E2
      9FF0EC9F7273F2A2DF52E831173F9EFFFDF6338F7254786338ECB016B99C24A9
      F61C4D786A55FBF27250A3E44D4D8D069D4EE5C1F2BDE202A03CE44194D7C525
      ABFCFC1F4BCFC719BCBA24264DD8D9E26D10510065EA67931C9D5C22AEABECE0
      1EF1E6D0B07731DCC278E8C11C230632FE7D75574B8A75DF7C454D167B2B72BA
      B7D7AF9286F0FF7DAEF421394D90608E63A5774EC91B14BDC58197AACF60E118
      21D292F3FDA526469BD1502D4C94556FBA8BE18FB78677D8C3D35FFBED1CDF11
      F9AAF779386AF486A3D322DF5C794CC4FF382E29B57CA9D10B75D53E454ADB95
      DC22664282138D3BE87071DF474C5014AEF1772A5E3BFEE9EDA6F41A18E957E1
      F83C42344E5D82ACCB174B7F67B176CCB5B68F78C99FFBEAFF75BE72E541DEDC
      91732E74B211A66913D75D66D45560564FBE03C57EF579BF1E33911C1E97096B
      A99D2736786EE431613041AF03299B705D279FB6F1CA0F44C39149450F2C7190
      3D362DB2A551DC5CEAA4B9CC626F4E772C9DC7369BC99B1E00D50D7ED738F532
      299BE22F30824612FBFC3A24EE509223F3105A581D86E606FD481E9BD3C2A2CE
      D5E3088397B376B2A0A208C05407E8C2A242A48991D9A3E128A54BA4CD9CDDD2
      A048724B5843257A403588E26BBB241823B86641926E1527DDE17AA0EE43CF80
      7CF29E2E6761C414BB0DCF84682AD4D5E0B1A95254983D71B68B3076CDE53C65
      4538562D4FA381E48CBE52C39F871DB564173548E4BC020DC62FA141664C0A0E
      6D0A4A53FCB759EEC7EFB76EBAC81481633178AE943968B8EB5F793CAA56B9B8
      FA70BFF48ACC0A796072C4791DABBFD94FF7BED9E5748ADAAA3646ACFAE81F0F
      EF7DB4035FA8F356A7DF68B63AFDEA231C9747A891FDE746D1919F787A69AA3F
      FCCDA6DE2A31126F9ADED547207F30483C1386E24A499765585EBB9DD81F2579
      F095EC0CA2172B206C3612D6CA4D768B9F0EDE1D557F991FE465A496E533BB60
      92B34B3E52A102B92EBBB0C811C519B910EEF93FA9FA7FA84F3A51432F0B977C
      64771880BC066E16E94678572B06616855AED16BAAAF91846822AD9A1485609E
      894CE2E8E44ECFFAC4BEA7FE53F5B5775DEF46D5DD6072825BAD4BF52B6191FF
      43B5AC8D7D0462C51FC06CA4A158EBE7D789BA0912F4090BF51A1117BA2B35E5
      9E44DB450571242D2B6F3DA4D56FE53BFE6BEBBC45B5B29DF3F3CAD6D596F8E0
      5A3B490C54BC747BDC178BED7B3F48701BF6555D250EBF82C8608255B36C1525
      BBABE3C977A863173810BAB1019181166A99A83274487DB8EFB8640F1B84F73F
      76EFF0F0A8FEFEF41405ED68F6C9BDCAF2A2EAFB06CC79C62924AA9D10717C4D
      68097CF0FEE81B646A301B6D7C9D2873ABC9AAC459751C7FF74F75A32F701E3C
      A4496C4DE1E8E070DB4A387EBBBDDCC73FF27277D1010CA9EDC726CCC4F6A506
      F09B844AA5AECE47CE0C45D22A3154243C319B9F9005AC290B08CB2AA08E4C30
      3FC9F09C1889054B48215EE7C14DC934C2CC04DE3B46FE08E1EB0DD64EED968D
      263BD568E54D980E2C71BEB45BDBFFFD5655D51BFD76CBD65880330518F10DD4
      05A77EE06DD878E1164FAF745CD5FD3E7E073D3BA09BCF9D85A5339FBAF87C7E
      8E6E8FCC4D9E776274D440C820B4E26061CE6CE85F05167C0D8DF2EF367EB8B0
      11C446D5DE707F393AFE01128F284D2F658B398E24BE3192CAD4CC0FF602ACED
      5F711AFE2B07A6E10DDC9DAA47FFDFDBC39F7EA8CC9C76FC03D4F970D8C1CDFF
      E12D4BB23BD2F159653071DDBA218272D28FB8D3808B83BF1039CC3D1D636EFB
      2B97C646EACDF124489F755A9E8DA621224449AAD32CC12223EC9B9F52F0B8A7
      E4FAE5849679DEF6592742C65CFF1C15DC03ED073C957C39A8E894515144CBCA
      A521A590F82310D48A13BA8409E2AE0CC00E9F5816A32D42B8D2EB2427DC22FC
      333721278C77B5694CA9D4728217BD3121963F5F96A2DE4C1A1D6E21039994CB
      A34ED04CD4CED6F546E1993A3AF8F1E0C73715EFCC03D31BAD26707842E95CFB
      89A034B13B4529F560AA277A6A9E73506A4355029BA80521BB31A2EC4CA979CE
      9D03CE3B1AE99B60C68E5A1A1B8344FB734EF1D576B3F757385D5A4540F8709B
      049825AE750D4792B85132CF5AFE509375CCCBE4823431E1F4C93AED39C20347
      146D742D60C14762407AC40A579D1ED3E1A3CCAB43AE10D041F016D5D569EEE2
      91534A21ED6FB1873CE1A90CB8CA9BC201D0FE386BCC53157F5E6BFD55AD744C
      6BA12730E55C7F50225E267AA6CA23BDCBD7A4C42340A5F9BB8664DEFD94CB60
      6391BF65343BB5D2442A889834452778B1C1EDE202836618A06BC3F3EB02B6D6
      FB83F6108313D34349E23DF9063CC90A6E466BD519F6B8432E1ABBA23B75E005
      C4C0696EF9DFFB8E5699EF6FDECFC519ACC4F39A4ADFDDC27445441A77BD940F
      206F24D1889F4ED6E24C2D001E9B104F21FD81A0CA6C0A70D8D1FD447A691507
      696A227C3DE70D1763D235D0C8FB91C28E769E8D2770E0C95AFDD26C1DA8531D
      84D23BDA07705C2D8C863A91E6A91C1A36685426367C308B5C7BECDC50A74F07
      853EA4A80BA6F974DBBBCFBD53C8C077CEDD631BB65D862ADC52F93392C2EBC3
      569224327EB53EAC8EF386EA9BC8FED8982D4C585E15EE61B2A56F10FEA544DB
      23C515DF980018BA378674BDA84BC611B305F2F4B44C993F07BD1386F95BD066
      7DB348A5D28C60CA92220387B8A1E63FB9FFC61DA5E89880AA1098513D2DCE5D
      B5690C4D9A2782EE4E87CEAB001AB102458B0EB486009B1D2E9E8DBBED6AA3E7
      66C8A3C317EDE44BE3E7D45DF360368714BD11443A3BDFD537A54ED0DD9EBE36
      6E424B1DEB05CE604DE4569EB44A60D6AF6D56EA978C9FF276C9357E05C27D40
      5A307C35BE56DD1100FBA5E32435629B17503A61BAC4092AFAA0512645EE6862
      8078A4C5C9AB54EE6BE5F75890E30BABDAC7633208C04C4DBA26EC0C89A8CDA9
      06D03E538A41709F2E739BE696A22BF7298942F24DB8335F16C127808AB0315F
      7182EF70758E4B7D6F490C36570BA74FE4EB241386B92C32B768B5484B34D790
      EE5B47A252A44E7F3F40A1A2357178FC3ECF4F8F3AC356182C6030F42C5C9586
      EA233FAACEB99C947D13722AB5D4D461D541255F76FF2ADB66083AB49C4C2640
      0B471D6057C7661A9B64CEE47A79EF369A4B9D88F62A635B8EDF2277737672DA
      2BB7F242BAA90E7C34959DAAE1DC98CAD194B76F9CA1048AA3F1F8CB5573301E
      334B00321551A3A71993F9A73A0BA57909AE11550964C1E73D5F2B3FFAAD7BB4
      F0FAFADC5AE88E3FBCFB5D79FA55B99FD865DBBEA464BA560B1B5139800E9599
      4E89E17D4A76940297FFDC663141561746ED95BABFEFD7940E1119A328286E87
      B4E984C4BCD36C1E387B1343625110B6F8848D931A3569CC63B690FBB9995836
      A5F297820E48E7E4D4917347AD71B700FBDBE2D6C2F4895359CE8D1044DE49B2
      46991CBC4A3D991E154A0AF636D782C97B9289303C3DC2B30ECCADF98EF0B798
      88DBAD5BB71F7067678FE5700C4C18A0F90FEC18469C2707E9EDA366A94CB456
      66C9A6050C00C75E2E63ABA537B4945F943AFE88BA4D6C860EAD6CF38B919B77
      9D050D34F74276067D418A5CCC9080C0074F7ECF2E8C57724E47264911EA3AA2
      0604F94F87AAC3E88DC75EFDE12F63014497E627A19525A95D1C0451E09A1F70
      7EC00F92D8CC740CC93159BBF564F1EC2C69EA2840A68C5B84D4BAB5825D49AB
      F5F47302F3A0BB58E03EB185904FF275C225687772AEDBBB9E9F6F897B512150
      88D2CA8F1C1C5C203E72630ED45970039704FDC0833F4C8D8D31ACCC0F6FEB13
      74042F724D7C7D605A49815AEE8FDD6D71FBD8F69E2230591FA1C06868D22D82
      B3AD37B98C360F1EEE31640655AC50E4DA4ED5049C1B1C7E73699BA01450A1AD
      C4F9CF70D7CD021C0EB2FD6FB153EFD4D989208605DD8459F1D752B400247978
      74A816419421EFCB45BB546A7CA09A2158BD677307A681719A40984847F6D8AE
      50D340D56924EBDCC40304D0676CD7B21F92A4483700D9ECDF04423C0E8B00E5
      6D74ADE038435573AA5465510AE014C514A5F2D9956BB94128A66759A2FA4FDF
      A26136491056436E1D4B9E2D1FBD6A882A26C557429D45DE1C0284E6A63D1834
      F7EF8D64F0A8FF6F10F1390571075565DBA94A0C585092A75F9E9F0942D06103
      F6C419B0A7A106652E372B054422A0C0C4E3463A83E5E260664979A5863B5A11
      0FB217676910ADD59EC3D421DCB558069CA7D9776DAF5C595DC954AF294D16BC
      58FFB98DEDF3DCBCB90D00922B48CF031F5D63A9FB15F936914198F8061EABD4
      594A832DDA784F2FB9909D4AB9781618FD407571EFBD38A304736A2117245282
      CF50CB908981672532C3DCCE759660A48F923385952ABEF20247318B28447663
      28D29024C0617335E6DD3E5C8FC903CEA19E727D81EB4FD3D3CB25FEB775A71F
      DBE63EA18E0DDBE3D8A250F6E04261EED152BA402F1B6AEF9A03EE0637048131
      71775CF9ED425369FA225765414C3AA15E50E9098D9E647A67A19DE8B046A7B8
      CE54169A6A2FF3BC7A2255FE1B8191DCC0C3F6E7B294E3E907459B0EC2F7459B
      6702319D20467DBAF41A47F5AF544388235C2DB4D403E80307046586DCEB969C
      84A149D55EB7DF1EEEBBE7578B8F901D46701D8069F81F7B00A6ED935DC63F23
      A7B4DB3842CEA4F67EBE68F6F8D1941571BF77876BEFE7E1B0B7DB504DFF5F9A
      4A0286915EAA0BEA4BBF77910F8B5FE6F59FF8ABDA1B8E2EDA3B2EA3B47CE6A6
      C744F04083C9AF5D13E83DF43D7E9E91E491D22195F378E5BED37BC3D3D1E0FE
      A11EBBFA82CF4AD45EFFE7EEC5BE6A4676A1C36F187692ACE7A8C9C6F7C7D98F
      C747C7FF09EE330168A067040EF1649D9AFAD4C675FC836A90E5B31CF4A017CA
      A22508B43DCE1649A0E34E9CE3E197210AD7C023CE698EABECC1DFDE572D30D7
      3FFE4EDD29FBE62E8A25A16C9F083CD5499899651CA0296CB04CEAB979473109
      AE7C5906126A8D8A30B8C0C7CB1F26748A268CA2E40E20F8B194135BF61DF9C9
      91FF8DA11307CE61555F6E33C95617DEDC8949DF24D7A95D1EA8965D32D0666E
      12974714C7E1D1E112631649B9851AD953A478BE43DBC47A46442F5858A77AC8
      1E11500F00D08897CEBE11C54318852810644265C7A994EE66E18CE7431D931E
      C93B7339E5500876298697F80F254A5C1393D8E4D92000B786E762AD6AC488C4
      9A42CA13ED642284E029CD67174142682AE9D509F595A4F1FF4FDCDB36B78D24
      D9C27F059773EF636A9AA4E597B6BB1D337D43D68BAD6DC9F258B26776BB1D1B
      20094A1883001B002D6B36767FFB8D7332B3AA00522445A9FBD90F3B6E8A4415
      EA35F3E4C993F31163A770DF80A8D28E20DB96FECB00991ACAACE278A0618B1F
      E037DA2B7D4F4286297D7B495DA0D8D8389981FF844A778EC5469F6A4400067E
      958819E94E9CE792FD9E65413AFED7443250E5162ECAF492194224A9D70BC957
      8B8E7F92C543E0A0F499A9109694D3A813B4DE798562F0EACDD0F51313A672C3
      4427EE6B9CA563C01E7ACBDA7DDD8BF67F16491C0137EAA2C8B40A214C5A7556
      E2AA2A46A94CD230A9AF31D5CA05809D42F3D807E7E465CB04EBA4E15BCBD891
      B51C4F897B447B52C4168758AFC5472B606C3BB37BCC94090701CB377052E04E
      F25C9A1CF0C49E08C57AD817B6E66C96C4943282952834B9D362FCDA6584A413
      C0995835B302388338BF1986A12EEC506249D8D2F54A209C3A2D61537AC4DB9D
      8213E7D934FE4E236FE5D41F935C29342D2E9F14078CEE7C059D7008AAD50DA3
      50629130DDBEC639842CB570D018B30242AF7824D2A16F3840089BE4373AE7F2
      28390F0CBAF28E785000D79F337DDBD0BAE0399D6AB49B000702ABF411F38271
      915C9B73E9D9F62A72C8E074CDD511CB6EF82B6993137ECDF9817A9EEDF821BC
      7D44EE6427F33211A725E309394ACBD15CBC9A5E5460023067AF139CDDE398D7
      0DFB31CF31225CF7800CD4D74DB3AC6FCEAC3FA7363FACF763E288D1DE257664
      1D51257305B283195178ED443CE1558BE4639D66E9BF6C37DFFE544D158AD661
      46668BCFE6E5AC10CD1EF3C71BD39F560CB38933302AE6650C21B4E800580042
      DE805894D21063628A3A1D4549FE352D8B9C8A2112BC1CB1F9E6A3E9A21531D0
      AA14F74718BA9155314A7A603022BA8709AE93324B18DF97729F93492A6A424C
      DD97BD8DFED83E6E38AFE2F3F514B2A5153117DA53964E53A982D313B7869600
      BECBA41A1514E1A2F267273D1D5161038031CC92E9A2E77FBB2D19E08D486D7B
      2F10485BD67D3114B7DC4947E2DC304B118CE945E322713444E22A0D701352A4
      8D79AEE06D07D38CF30C809EE6D519D2DC09BB7C4824BBECE0110D781D203D4E
      883C06C3308C962F76C39F37DD647039E845A7674F777AD6A674AE2F09B7D362
      EC56340182BBD9B9718614F3A4FCAA5894308B42CC83F733C575149A70317EDF
      A80EF7CA939C039940C0075C4281C1E2ECE65FCE68A56D8955E5EC1AF76208CA
      A49246146E12144BC4830CB4C1A364951202C0102FC553AEB1EDC8EA133C7D6C
      869736A78C3BEED1007B3180019277C05DAE837D156715957FD27C9294140034
      FC1CDA810E9F91DA896223E645F4DB3CE62E89AB6A5E322460E85430DE963025
      5F15F35ACF6DAE6F8B23DB8485515FB6AB57BEBE9C86A17DC89A2B486E94D080
      1543B8BA2AAEABBA98CDE45ACB6FA2E49B7A1A4B8736342F709E70BA01AA5475
      3285A2991F18E9E7A32ACA92CB78043B779C308BDC0129A52B51865458D4C093
      F350B801FA1E447A52C1899A4315C40708B420BE5E4C5CCCA9E994C85834ECEB
      0033DFFFF9E9FAF40C77BA80EB249D7417EC35596F60D092AC20317EE881E07E
      B563A602A5E806EA9BD8735C7E7E3FCA3E8C2B05994BA5A65E6F8EA99EE030D7
      7DDE3DF6EC259A80690DDAAA1C688A181593E8D883966D2C56415840B2D5CE1A
      F35D49B1B04B88DFD09626DC81F968B114E03EF4EBAB38EFA7E38439E16C686C
      686FCF456F845D9F4E714B572DF82CF32FFBEA0E91B98946C4FAF0FEC70A9AD5
      65124F57FAFD0D1294A1967698E1C710004CA10649EE92B5A22E538C03EEB28C
      658388E2D26FF3249AE76502C0893394E67D1E429A99E61F52E95346718EC537
      0C61044721D4A3CA8F0A376475CB315525CDCEC31CB941B1276EEB49B356D305
      5836F0339A686DC354D59D4C9F4C203B3AC6DA51DA23DE2D90437EF38BEC638E
      87FAE42741A0D7D132434CD9310DB97BE561B4A89B07BFE3A1D99B82779DF7A9
      E323E57485B5E380015F4D613B1817668D5E79DAA41C52F082C41D61401098FF
      02A28358A0E40EDC87FB05B57E99AB1600A5FB2D68405CE4C6B0BA0193F85B6E
      2A2FE2E3B00A6215EDEE7EE3FF8147860B124F914FBCD75B79D756DC564DF06A
      74EA0E3666136F5CB5540EA43886F8F2CBA145191F0FF5F516F0507384576E51
      51380B4EB6CDDFC792ED1CF0559491A9A42D56AEBB25534F081982FF1860143C
      073E2E63AAC15B08A3F881FA6D657EDFC6243FDEF5358E8967C966818DE5C02D
      FA744A272CE900AE79C9F60543BC2BD71FE19523D099080C8188E89ABD83E98D
      43C5DEF7147BF8B578BAEBBD1C7D434FDD1833A73A1A16DFC289609F67657195
      22FAAFB06D48F7B81B44CC53BE0ABD53B8640487F85B2399ABCF0AA39365F116
      649D371E95B8F2156AED33B846A054E9B259ABB501D6A973C03D56EEE75778A8
      F3BA40185B350EC7E3EDE1730E53D4A136B6F5BAE365046521911F48F2B0DCB4
      2EB735E6997AA39100F14B90C230CC603C15E5CDE6437966FEBF8CA96EB33DA6
      D9C4E3FE59DE223EB646EF752299A33EAEEC0005635AE1816A78805595DD3447
      AD179D65E3D3B8ACE43F0066D5906B206EC48FD60DABD9462A97DFC73D3288FE
      BD98FB61040046E953B8005FD82D5785DDA2BA7E80EFC6DCD987232259E0A36C
      0E920D5E515C5F1C4F9C79004B2BAAB02DD9BE042354C8437C3CE7E4F2891A62
      085924496ED81290E119D4025312B9802008BE4F43195F95D429EAD457B50F67
      38374484D6A3B7C535E03DB9B1AF71F9CC789C015D2826E8C9CC13C1903A4D49
      EA3AADF1410900043BD4D355AAEB145218604FB27794B1C6010BF86C89B8FB12
      DE49C80CA4B303CC161EFA5C6CE17F621321D6A1E5AAF139FD12E53BC2D4C0E5
      A4AE523E8E0D1D2723CE302019711DB6A10DBA8164000C7C9E4A784AF41C2A48
      4097952D9565E5115CC06328CB82CC08B04BE42293013580EF0EE7E18549AF46
      FF0602875BD99BDB924F0652DF4751AD73450ED93BC75D66656EE2B3AFB84443
      8B57C81570190C7AC6681E9E9F7AC85B9709A93FC36402422E8C62643D39148D
      A731475EB633B5D069384CA9C928ABBE8ABAF8153AA74FD821A54A8EF02AAAAF
      0B20AD759A83712D657C709D5BAA008E043AEF70A3B2A40DA1D36CAEB0EEB195
      E90989116B58A5E8DAA14AB94BB6C1178418C4F70B4921CC41DCDCA87E2A5381
      C1260F3370C65F915960C95DCEE205458769ED3D9600E845493D1AF4388270CB
      58DADD7C2601F95BA317A098F23777D33423B60DB019678770EB249FC3341A49
      76291DD754FCED69D40D4096F99B321D0B036F270832C03C82C1C01B04FE9D9E
      32A50E85F48F6CE2B8AA7BEDDECBC8D39C60AFC34438EF1DB88D2FD467050DE1
      53F7A22F494297931DC69A93F7D399357C05CBFE51159560E38167D5DE0A1C0E
      312C91C230EE410430AD93407EDC73E384595945B1D5073391991E44CDE2127F
      7421A2EA06BE38DC23619F2AC033CFC9BF820B56DED804F926780B7228D1393E
      A9720DF7A22BE1E8F151E954C8863439740F372449968F6999B4568D8FD82B4B
      8CE8817634C2402E1B84CDF7C833D923FBC6711EDD28D2349C338CFF2A7AE7D7
      867450F3B2CDEEAC2200954290B6BC249FC48DCEA31A4252D27B27E2349E7391
      2AEE3A103702B4CF08C84B19C14D9D424F816CD19C816C6FF5B388F7F9692F9A
      830C995424FAC9D8001149A649093AEA5B89D778983B009809762AEA3B43028B
      5CB982CADE3A397A83518FCF0C080C4C105E5A79E58A0EBD676F48851B60B131
      602C00325971C9CB4778A780DE5ED9CAA97A11A3DA121B966BFED6BEF682EBD6
      1DFD71D5BC14B9DDDC656C79080572982A460296668E56891EE19663DBD35001
      5E4CB8BB2EB521C0D8F55169A941EBF07067F6E37416D74C9B63B14A49429B94
      09B99ACA08BC030957CC8847156C9C7CB43A4A924799A4C44AAF2BEF09C85DD1
      FBFFDD2A09D43ADF15AB2523416A3075A461922713E151A441CA8208C6A77594
      C4554ADE8511656F1AFC038D23C24DF3EC7CE28B0CA1EA7D28229DBAC46625B0
      19252DE9412C173DA82FE8C0AC84E8A504E2E97E89C6A59DA53C619528CB6886
      18C61AA0DF3891C76A391D988E43742A052C56FAAFC9A3AFA64C2C78F9C2CF07
      D17BA92943700DC7911404719C95CDBB0881D5E87D2AE7388FDC32BE7C943F3A
      288B998788DF79698B8B65D2168B6B992BB398F5B384A49232977B121FB349E6
      EAF38FFAA964CAED500B259AF18CAE6BE43EBE37A1032E1FF91442A32A6B614F
      0B983D70FE410060051967C691239D4CEA3E2EA7656FC4AD87AB8C636F312179
      7E13A616F369E5290B6F15C747CD34933296C11D635417327697F5A5D0C26276
      1C09B8DA0FB06013C340D05D52E6FD600CE85829D313523682CBF70417B1A025
      7BE3D055B6E8C333C262A624BD9872AC49AB054FDCD18A47003297673CAA0C04
      56149AA0EF4014FCFB0D108A1565200AE146031908293E5661C7E6A0C180F7B2
      AB4AB0413A0CCD1CBC117ABDF9BA3751B4972F36D10608B5E1825F7A4100CDCF
      C0C9838444D1E2C2CC900066C169465678B1F058CE2FA37192D5B1C8494A5A0A
      2A317C09D987FE8782D2E2E854D9724577423A80A5A1FAB11ADE043DBE63965D
      F0AACBD2EC26C5CB17EBF2EC20C57E4BA25D6B8855380FE13F6CED223A1C7DA9
      923296E4362CFC349FF34668ECCFA08F2DF52218FF110BE8B9E5AA963E2E5616
      68D371DE7CD95C1C9E3F7B159D166589A366EC1646173B8FE05AB46F41F19B95
      D1852033549292613DD5ADA4493417755D733B9A3B1992349A816FCFDA61A19F
      C6CABB739EA32A30AD5933AA3F26A12951F4E96902915F497EC4DC420AE2EEFD
      3AA99E7163F479F8B93505E201AE05485D0086EBB556D8682EF198BAE0506112
      EE96D1B937625A87AE273DBC0EF4A01FAD069ADD3B51AA0BC8BC63E58ED3AF30
      FFAB169FD79DF82CC7020D671AB86099D1E36882753D8C439D82BC47891CB041
      450448A08B4AE40DDDE9EE42CA233ADD7A545B8ECA23E3370E3069C3321D5F2A
      C5EF329E9990344BC3711576BEA6653D8FB38E8BE95A8A29D7A49EDA3D49DF95
      BA0740E7D8205882067B3B88401AB8DD495931499FA42BD11BD48C978E1C8ACD
      7820A9382B298239D11419601D57F487AF61A43F00AFE07080A061F0D2BFFCDD
      446C8415EBE1AE14962BAEE406D9EC4E8BBB245E27B6ABE1577E34E529305654
      DC8AD084DBD5457919E7BAEF22C7FB0372518C9110E2568820B29B8F2165D498
      8D757872E2480BD872AE26DFEA185BCE110353709C7E4DC74A4430A7B4BB14B2
      DA9178D17498D011D0D5104B1F647099D75CD36F54F3C3C1DC691ECE9AA2BF74
      C05B5085564780CD1176CEE68E14CC14A9E2187BB337D1074EE6241E6102E10E
      88A6405DC6C00D2645790D2459CF519B5F2D9644E3B30A5E2EEC533E16054A45
      CA3465C32F82B03BC21BB01EF5E4821F27C8ED53E51D077C52E872A9EDB94A4C
      C0241214FA6581159A9492E9A4DB9396E3453CDC7841D993D46D38FC368BA598
      281FBBD2C1F1878237DEF9DA94B253C69F44197C6F79AC205D69E06DEBE2F252
      68FF15AC1EFCC6DF29BF7CF71916C92FFDCF5175331D82702DD5095C6184D0FB
      60CBB859162E9C2FC9CDB0C03AF08516BEC383FB0DF21FF2C30AA4049A574E79
      5EA5110BC4E1D8947C5557E946E5C062524BD90D51C3C4C2620C10EB77969456
      127A1857E20611661275AF44D3D94D811073721D07F78D190BCB17CFED93FC7A
      9E7D89CE7CBE32CFA9FDBACC9087B72EAE33C48F7DB2732FBA2AB2713426011E
      CB1D8FF992006866981E93A99E4631B6446E778F30015C86CC8F18EF23997803
      54691CDCCC5C4A4A954CE6129272A5CFC4BF31F7498094E45B8C8096A54270AA
      407451500B067D302768DAE40554D465610290311114DD6E86DE24459DDFE33F
      2B005E3EAB287C7E0660623E23798CE6B92D7005B9379FCC03AD95AE12577220
      7C04DE2934F80DCCBD7DC54F2DEBA50CBDD0A6730F2110ABCECEE3CFAF78C9FB
      61D342A165F456D318EC378E623334895B7BF133A9DC1B1A174B4000E1D6DB55
      EA7691F6B7CF9A99DC4B9B0FE0A19A54EE485D97BA945F11759C57CE4660D6B5
      64383313656118316C6A457B751BC1BB34EFD865808759F881FA17530EDDF35C
      14C78E16370D722A05220CE23E395CD8B71EEA1C504C0A6B669224E3217C554F
      9287B7EF221E86E571C779E0D0BD7BF07234A8A4C39B4F869830FD1360639BCD
      482BA3C80D7E3FE3335C87B4D6BC8B91E188B72901658BC63BD9F0FA03A3C850
      793A34D983D3C79E863C2539E54C7C98FE0C0F333A0E416E7913B16AC9CB0686
      4307C5BB3B98D9F9F40E3A679F844E7A9C8F115E4608001DDD879ED51A7E0DA3
      F0F2FAAC44852B088B4D8ABBC5B5880391D862A4D58AE7AB5355E01779D1E12D
      BC6DC8335C1FCC55349D266342B5CEBEDADCF4392DC609DECF6F1396D658C829
      5A31461F497800A9808A0667071750D6589A24BDC8F8E0D7BD445F232744EE86
      40BF0FD5B85D22139684F45AA2BE3C1516B8B7DCA4EE011E7A328E2A7C86AC6F
      44E2F0B85023364C5618E4A924B732686FE99432B5E2664A3E58F014F3981ACC
      FF11B2DD3C0DC4612ECE10D09B196C0B795F502F5432829899A99272F8887C59
      43481FE6D6A5C69FD1A225EAA68F95B0E730C9D244254FA53635CABDBBDBC02A
      7AF56314433033ED2E34A1E41B8F0311F18E2B9C072BC32153E65B82C467B827
      5F6C56A43441EAF6642AA0C8126392ED9266827C5C310BCB477FB42742CF9B33
      1FCE9F1E5C01F47264A36943702B4674A9EDB1EAB4B0A0996E45BA3BBDD0D410
      DC0C180711D71445AC254739153F80890DCA8BE2E1A5B159293E4B66DF3594F8
      63D8E2881C36BEADC59A4038527F8095CD2DB10D787290518B7170593886B8C1
      C65423CB28EFDEDEF7A943F29E5C79CC69B1D4625C6C9456C2017F0714E9DCA1
      3C23B9FCAC62C34A1319DCF110EC7315F0B8F09132E503AD76E7870FB73340DC
      E334AFCB623C1F9994D037C9CA690862CAA4832D46774569351AD5E845D3B9FE
      197BD0220F3D47D1B123C05745F2851F3545DE1267C8EBE0CA21AF834688B8CF
      FE826B3D6B2AE41C1140C0DDC6738EB20F62B19310A46A715E9D89C5E8C570C4
      F2B1D4EC46910F1FB809FB68CE22E20CFD381FF7251C228915BAB21C1691F965
      54A6D5171A6F5A5ADD8E21CD8F0C47DCE3F64421EC4DE31B159647728B837E14
      86F23A9D8B5908B78EB7CC4D7C77076FCF18B0A05EB8D221F0E759F58392F3EB
      CCDCA92510119BB18C52996E5C5CCAB2D53C1D615258A717AFE8303B64C56C6A
      A5483F9B3A630BA401BFC224FA82410FB9014134D88040B0FC8319581C681A87
      491A140C184447F312573A20247DF9479594D9E853847F319F4FC4AF2DE4CDCA
      EA4E28C8A88EBEF74E1B9CAF61592BE14EF5C764632B6E6C2E1D32A31C67AB14
      EB02636D061E5DD43D7E7774B6139D9126712CE146FDCE45314B4751F7E078EF
      64E70EF10539ABCC143780D79B56AFA2E3776742693B7E77B6B7CED242F3B6BD
      020F4A88837972DD8B147B0BEE5835181AED2C6A6CD1CA164E6A902215DCD416
      7183E16FAB23B85C5D523F73A5F8E5209D20106B476281068C09EB08A359BEC1
      D3EEEE559AC46CC3DCC9D4AD5534369228EAE69040C5DFBA3715334FE589713F
      73D803CB3D3CABE0344E2492C31A22A9EB9489C9378FCAF0B7093D493D31AAA4
      D90D692B2DD536A5D43F17264F0E0D32ABB595234D54D3244A5DCD9B8FE3BE17
      8AA0FE94602F1FD625201C04A292BC991CBD68126BFDC016C62CAE78496ACB25
      5C4C17E5A928E8CADF3B724AB8F2F4AE77FEE3444E21F91C6E9D2153C20C6AF8
      B5EACE7A91A2003D0FC859B8A5F5D545108665839C1DABF4B1EDB3DC4C19327C
      CB65332EF6DBD6CD3069D86775B3BC2084939527CF06FD69AB8B9AAB3CE8CBD6
      AD073433E1FE73AE45C34320F49B85095E9DA6A13E106F013DDC60B921235600
      73629EF32939EDC892D0E0B9499E6AF04F8467C4F7A2E1BDFCDE0E542FC5790A
      5C81D63A45BB37C5FC0EC7154E6077F4AF3BA4F8EDE052177B527A71EB1252F5
      DCB1D80D4E21D5548ABA65329A97C8F470BA8F9A6CE54EC2303D47047FFC3146
      EE98B2C57C379C0502B2683CAFAF902E4836649530972177F9E8A657A02D36B2
      6EF09DA2EC29F3B4A2F8F939231B6F0E3FEFFF7CA761DEDB6C9855B255200A60
      4FE205F2017EE4A90FB07AD8157D8C69FC48144C2B4AC155F42A35EA27DAB670
      27BCDF353D955E0883199A7AE7CBB108D57F61ABB7FAAD037CAD9C37A7B5D64D
      07C9401EC00C7BCEAA606A2E88BE63251898812D050EDA97D72C29611B8A1197
      EBF1C673D86C4EC23BCD9795CF34C9204806D33BCE8F1147917DB9933D609947
      021C9C1663163CD330FDDA681D7B680EA631B81A86532F58E55A71C0A1FB384B
      240F20AE004F2DB23C8D38ED0E7A16846F5EDB3A386349CA0D4806957313DC9D
      042AD41F55A4F187A72C6575F63CFA74BA77A09E855DCB52914FCB1CD11FC760
      CC62C82B795DAC2D1B7E01EDFAF3F9F0B28C6757E216308FFD3A28E2A2F4D8C7
      FEA2DFB2B11F50E44AD56EE41DF3C29D9F36CB964313C4C2EB22BA8ACBB138F3
      F7D1B1FCD30F3FB2C437B386F6AA0AE359E4AEDA10F79A38E48ED0308E5E9355
      F0CFF99487078EA6EDDAFE71F7B96B9B6BD51C34A983242FAC4A8269DEDC1A81
      641789020C864D0BB086344D9959FCD8547A146DDBC71F96F631D06D8B653D60
      BCC0EE3B7BF6F8E8DD2721638DD33110565F900BB8CABBE3A3FFE07BFC7C74F4
      1F50725E3C2D36EF1E6B8A4AF78E4FF70EA2B9168B96ECF2342717EED9D5764F
      7FB2CB52A08B6F4F861FDE5DF507D2405D53DF592BFB393F1BA109C558481180
      DDB065AF9E3E0D4B5730B75D95C834242AC7C4DEA7D38356D54EEA9EA2A2D03D
      0AD33D63710B96D4EE9CBE393C8A7EFD353A8D2FD391BAFAA271F2EBAFD1C1DE
      C55ED477FFB907AD43B8C2C9B4A37854A585547D8A0F027983AD7B86A273C8BC
      9F40AE5A936BC84E8A599B9BAEB795E40CB6F6795223A391DEAC92F50A24B89D
      8406F6F1C1FD2BC71DF8CA71B2A6FEED2B2FCC5929758FD23C7AF17CA8651904
      97899155E48B17F9A9DCFBA4A6800F630B33FB77E8268459614058395CC9D2E3
      925719C21DCDC961E08675988446ED3D4E64E6FD0E5DBB88876629E62E948EC0
      FD637A1C94DB4D759DFD0ECDA3DA14701A084A6D5BD4B0EB0A9F247CB229972B
      1F5022EE12ADF9267B9C5135639E3C489BB29F0F855A308E5E9F9FBEBF5FA5C6
      E50D48A59D934FE7EFA32E63ECA8143B4BB2ACDAB1A0C543B5C65BE833AC5429
      C0E3E22030324FDF9CFF91C5867EF81ED69CBC7C2B4118441F03EBD4AE637411
      9E80F0FF9C01DBB44040112EB62B05FBA727BB3FE25EBB383C7FFE0ADD6A048C
      F6F63F1CFEFAEB3F4ECE0EB67EB8DAAEAFA2D3B33F1F0982C4DA1EC8A52CF2C7
      E0DB0D9165CA4BFA4177A58C31D547951AF21CA1CE730424EB57D1EBA2A09486
      4F2FA80BFCC69441F400317D109D1003D8B7EAA9656B81B329BBD7458AF4549F
      2AC67E9064B3AB347AF264F06CAB96002CA6D8510FF2B4F69692919561752132
      09790A8F44D9B4B9F8B9FD51964A7882A11F471CEF0AD0BB9FA533122077EE98
      F6169D7FB929D369747E88B2654A2C8F4E70D9049CE3C12CDE6E5DBD2BAEE163
      5652DB7D5414341C80560525BC1982B462EF2E74A36D6FD5ECFB12416589669B
      94A4AC64707BF06E3C0858BC9944B6AD5A716761354BDAC240EB6B8FE5CDDA63
      BB77A93D76DF327DBB2852770470554A4150BC29EA9ED7C50CEB4B0AFC1E22D3
      E3A7881FCA273009F2D612BB43AB4F9EBA8B6BDF84D7A237497D5C1D1F787146
      D85F33A45D478739FC020A396C6B2EA2559C9EBF5838FEB3BC4AF5F86F5AE5FD
      FCF46FEF02630B781956C930C95926467526B66D9CC6FDB123CB402A46344311
      47BA29D32C4B478EF9CC5AB622E3A071BBF76581DCF6AD5BC7ABC3A492D35D21
      014F6E49518C508A8FCFA7C48E494D4873AAB04727676717EAFDD2F9557DE607
      BD60065A185B791F1675F7DA653C0E001D8826AC4BBA5398719054FF97BF7D90
      43793FCEA8C29D1CC5A3E41D62825965120693D85F0631918D0769925A1512F3
      91EB515AA2EAAE860F4863403C93A5CAA4F81F6A22A4959C977617F0CE78904E
      59A1D6F1DCC5A7F4EEEE1C213D4CF5905D416C854EEA79991BFA89C209B3B8EA
      DCD12ED4E97D90B7383F3F7C159D1CBF791B5D23775CD96B278C29FD149D1CBE
      3B7F90662C097CFFE2604F44AA71C1D5D1B7B3D72D6ED183B7F0EED303B520B7
      E3555183EA6F882DB8FFDFEDF7E47FF7B21AFF16BD0F7AFE2D046F212BE5EE37
      E0F33FEA067CF992756A9DEDF3F8E4F073D48F3E2AD8751ACF58CC3729A30BAC
      16D10EFDFEC72D1B232A8B5C8BB361967EC5A5670080D796C49E57D8FFCDE1D1
      960DFDC86B3D4B99EC4DE29F6069C649471D34C9C9A7D0C47CD897FFDCD20BDB
      056C16B3C229CBCB937ACE930C337B5D94D9B84266AF26D11F9CECFB039E4890
      C48F424D1295E1BC5FF1DF1F9E3C0B26530B34A2EA154F3014A6110CC0B3D7A2
      7D53E0F819F435B2AAB2623B4FFD4F3F104E3C3A7BF62ADACB475705A4E128E5
      F1FF45EFC1243D298A2FC5BCE647D0CCE65243B447982496AAA2C2377FDBDBDF
      B21BCFB1EC2C8790D796C7F82D5DD4CC1D4C980FE43BCBDCADCFC769FE4F7AD0
      DB3AEC1C92779F9090A54B251AA3916991539D98107B52525E0785E12E93629A
      D4E5B62BE07B4097527CD7B7978DF2F99798EB52240E534A2CA779F46EFE25EE
      5F60B5A0CE7952475FE33CADB644B97F20C80DD1923A9D99F5304E2B61E6804F
      203581A5E6E2B66DC81A7BFECA1286CE8698201299AAA87B7074F6DA30440FA5
      7F4DE308876D516E6B4EFFF0F209B616EF2339AECE6B25266626772D26FEB6CF
      FF5E811477293C13AF4013C8E92637E0715DE1DB46CC6022B370188E01ADF7A7
      D930D8017FCE8B3FEBF2DCB605AC06316E5424471992C51CEFE4FC7ADDEF6DFD
      D86DC370CFFD05F7393A07DB3ACEA46AF6125A1C573DBD6393F4DF36BAF563D4
      37F44D169FBE663C2B209839BB52BD0C451A963B1937F73065FFF423DD4CB784
      8CF02B2487520AA21572FFBC4BAECA748AB360DBA630CA1F602278E68291F970
      B44B695AAF07882AB10D4B7EDB76B16A0F3E3412917C3819D10C505C79CBCBBF
      F6C663A3151C3D7BFCEED3B6EDFEA8968CE4909FA43996CD87A29856D13E2923
      E15B9BD98AA1C702A4C3D6F80DA93AB4F8B75D708CEB0BA680989367F1516B2B
      4A51E27AEB873FC7C3DF24F5BBE4DAC5B1C07E97DAC3BB515C5EB2AABB7248EC
      ED8FAF874C39118A4894E6B3F99600C28FCF7F54F0E2F967673D4A8D3EF27AE2
      8ACC23A30F4AF8EDD3DFCEF7192EDE36048CAB8565A367F073C71A5494F23B88
      2EAA9EA0BAABDBB68237FBDB3C4561CD795D44A2C9AC87C6A42847495FD208A2
      CE0751633E3B3ABF60F4B3B3659342C538792351FFA39333E4E94F428A26EB9F
      09F881D79D217312948D6D1BC46546856735709A52D665D25754D21B2A414D3E
      BC34A5D7BA92B5EC991C08786F89C2FDF812A7E3BBF7FBFF193D7A93B0AEE2C7
      59F4F724067DE791B318C843856DF884B91DDBB6859564009FABB520D7DFDBF8
      5FC8D7775B882C47858824BD8466F8B62D63AAE91E47694EC53E54E1E1721A27
      A32CB65479A9F3379F7127D1EC079F94FFB07C808785BB922AF3E28928492311
      5E4198B0EA5D892B293E19B0845C92B07110052FB5BA91DB9EA1B775554F9DC3
      03088521D7E47C1F83E9FB23BF8B3A87960BF39C6B45640F26AC23B3DBD11086
      1E191DA6AA88360C06B9EAA0D1AD3DDEDBBA7E8898489C9D1F0A6B26ECF42C29
      C544967AB581AFC39C6090AA91CEE62AA0D86C0C8615D2DECA160BF241BB7D12
      9EAE41FD79AAB688F29E7AEE0A144AAD22AAACF3790FDA9B17CF239426B0941A
      87CF8B6AAC4A99FBA22E941516C2D2F37B3AF0B7F5489531A1EFAB7934901433
      4058504854FAC3B962D2EAD94DF4DB3C9903C08CBFBA8CCCB8E6337A01B1DAEA
      016545F5B0B3EAF6B359B9A067F30D90682C456BA47EAFEA704DA8A96D8495DF
      83A5D795DDC9F0978A56A2A7EF0046D4859E4364D2E471C64E31908D5B0A05CA
      650594D51F08EDFEE987A740ECF64885393F3F64A758162B47C27062DE93D2DF
      B73DB6FFF4E32EFCDBCEC7FC0AFE729C6583C1A063515A4A6A90696CB5CDA649
      3EDFB621DCC32292413E220DD5E8F4EDC145206E1E5A751099167BE91C17B3C9
      C35751173182FE311FF077801B7C880BC96F1E11D663D389FC6190D7488DA806
      5D83F070CB63BC0E238D9E953283B21354D857C4E444CAD90E76132B04C59E7A
      2B1699E933833ACE247FDA0DC2E63C630E311EBF32B1E3465AC5C4485FB58464
      FF37FC1C36F92B00A1D8E6D4A4751D51F55F7704455D1CE84C4374D5F4D4CC53
      1A3B956D39CAB0C98CC8A21C162DC27AEE443B711AAFAED84B53CBE59FC01586
      DBED33851087EB45286B19BECD38BECE2FE7C88282F7816CDC221F16259D91F5
      95F73C3F44E77444796B3769B08BE991779175810A52D73B837B87139EFD51E1
      841774D33E50C77C16E77659836AB8E50349C3D55079CB647AE5A2B962A70A69
      11B2F598FFC75121402067155BEE7CFFECE45EA1DB3FBDA0AFC61A111A787419
      B555AF4D4FC12E15D9A73DA9708490B2C884F1CC64DE5A92CF650BE04A508570
      FFA34602EE965D7E812E53C12EAEA3DDDEAEE97055B339D9805249484E953052
      A1F78881C65B72675FBCDC75F377104FE34B7880C02C1362960C4666F1907C3D
      871C6DDB94500CC46B3DBE3895180BCF4D13E2CDA3923E2ED175AE97668ABD24
      6B6FDB3E4192AB02A2EBD1E1F97B31514F8BB188286EFB54042FF648C5FD9416
      52974835C8143B14394BAD9102B12A503CC337DDB2E51F9FE8D43D862A2EA82A
      3382865C4C92BF214A813CBE69BD314A9FC5F9B81AC533EAE6642C85A9385869
      5086C2340E1CCD1F6D890BBD20BC5B417663CE3584A26792B3CA7F69BA852F65
      45A3B49A0FB5DC0AF2D458B479EB41224C7F33632205D0839F0EDEED9DFEB497
      A72A107071334B5E45AF631C43E908F1F6D73146A54E475B36F903615DAA55D4
      57D13046FA2C56B065FF5306124B8F7A57A2405E9908B5B03B2916571451358D
      B36CDB3727F42AA0F68956DA2D2651E72041D646954487BFCDD319F1B38E0D0E
      7CDC62AC018B6DDB85FDBB2F457484E46A5EA0D887FB19C03AD41FB8A950701D
      FFAA4BFE0B46D2DF390015AA326D0BD9BD64EA8A164F9B2E144F33F91FAD9DC6
      4A14562BAED64294F36A4B28E9E513B4AD22C65F830321C92958A82ADDC9B650
      D5CBA738B005E8F409B264C8614991330281E48FE717DB368063857A5317EF4E
      7D509A1119CB7904AF3EAD6B54F4845934CFA5BC136557990E2CA7DEEE3D30B9
      974F71319E9C1DBCC16D1EE73C2BA4B9D0D394BBF96B12BDFB78C2028C28758B
      B4314268A8BD6B21E42DBBF18C3064721DEDFF8C9A2670CDF9541D0A9C14AAD3
      29D33A66C8C1D72A5192980F5CDD032D7CF90C38A5CB41726A22297121909F7D
      02BE2534EB62D7AC246621A5F91797E45894E9253364B07A5CFC15A58B90974A
      DF61DBBEE2E497E2D254F890938DEE83849F1CA544B0C549319A530BC027F23A
      27625A6C6974BC7C466F7C3A4C2FE726BCC050E3A32AFADBC7F38B40E47DCB06
      9EDFDEC0FBBDFD9F1FA0011C28FB36E77BC6066D3662985730CDFBF8E68CBCCC
      2D5BFE1E478D5B603A5D8F2AFC9761592AB6CAAC6D5D4842100204816D928EB5
      AC1574502480C6EC07E4A3E9A5943E2C1CE86814070DDF4F944151E0E4750172
      038A83C59797AC06B26578F3D61E1024035B63EFD3A9C573D318A5E4A2043AE9
      D0EED0AA770C8C5DCAA6EC1190A6D088540253256A75A1F93D570EF911A849C5
      178604341204A493F5E6D92E3814F457F03304332B50DFB2877D55803D042200
      F578A407863D8B8DC1C8CD8448C5288D55CC72C8D183F6E6AD031DBB0AF6FE25
      FA6177D7974D361A810083C8CE0C42D18D6A407226F1667119F9161BF325811F
      B4F78DD2281A3A91801BA46B81194A4800AB26EA20E903AF735174A21964A445
      A0C6FF525692580A3E9DF1417B1CF8F5A0BBA08F485053EA1EEFEAEA8B08233C
      68BB2123057F4A35B593B9725901D93313AC752723975F9AF7A9A4AE32186A74
      8B3682D6BD613DD02D0FEBDBFA9BE67E3788CB072953390E1B55E52CC7D3F469
      941CE08D075D09F35C48E7F72221DF767A85E685B1092681DE9CEBAF4603833B
      C77F9D42B2FB10A62F61654CB454810F6BDC034AB8ADE78A31FAC240D3B4A2EE
      B3AF84E72B151ACB5A4DFF078F486A12C7EBB3B39F21FC4D0DC8CBE8FCFDE189
      ABB927638840018CD7870C905C8C279AD13600D9E4A82CA6AE5EA8DB111A1655
      C7D38A68FA581D1FFD90BD92A0C02F60517C561A8532549A325BE161DBD5D28B
      ACEE96234132AF929D87EC95805F5E2736204809452727A2F2904D1A4775E15E
      C221C5FD3D63980F0A9214B8775559DA27D843F6AA28675731A0EE25FBB60AF0
      2351CB5820AA1977DB8AA3F23E8ABF8ABAF46289B7DF370AF782767F008E5D5C
      1CBE0EB8D68B0E6DE775868AD7AE3AC196DC9D172F7F6C36FCE9F8FC9817D3FB
      FDD3D721A5F15E59D67F7AF9147E69359F4CD26F826440E34630611809B0D1E5
      4ADED6713274F133A28C326A4F9E1029E2D90E7E539FE9789D26A730A8C64239
      ABCE5B714889FA31560B19FE7DA4590296DA6E9C7D9E37BA10EDA25B386AB5EA
      76E79CC5FAEEFB6CBA0B9D0F52C85758F9EFCB021773197D3B3F8C0E5D71D193
      E2B2E36BF46ED5EC07398EC5A60AB4EADE97090CBD7398A2BCB9A0DC2DD86240
      0A412D514D53401072AB1E305C6B74F0AB54046EA518828693A16FBDED65C9A7
      4313907916446A20F3062180F950B8D1D1DEF64216C19D2BF192C377FB6F712E
      FD9C17D7048370826EF76C89E6C715CB6FE969A760CF7DD80DE023E12065E517
      48A5C28C7229EC9AB32680BCF0CC5A4C164682A2EEEEEE93FED1D151B81A7ED8
      DDC5473B669B4F6778BE72230FCFB7BBCCDAF13DD56892109FA5620ABB9F1755
      94D15274EA84F9387A7B7C717AB8391DE31C3572125C49EF5D09B75521DC73A4
      F4F86A6F16C3D54228E249C75279874F45519BBCB8DE4E6C5262CEB8B13D0D22
      AEA2FE6FD57681833E5C845B9EF975EB8722600D7B8AA01F1E155F66F7785DA1
      7EF23547F7780C7A153C2A1E6DBC24548E035B90E6248C499A92EBCA07237F55
      8ACEB9EC86348F0E1A6C0106F5C7494D048BC17D7CC7185A1686DC61A6323335
      638ABF3084D02810A6B50BD02F80C3CAB1360D5E574F3C1E5B213B8444A6A439
      343459796752DF4DF5A6DB273E60782B998E6B59788DBE9E310BF83A3EA6D0D1
      28970F6EE07A3A8478A4B27174D4D4EEBB0D65234B44491B37AAF948A6C6CE06
      3C1AD59B23F164D9D80663B830796BDFC5550072CC0E2810662E55FA6970726C
      7922BC2BB01C9125E792E4B4CEBDAC15DF7B4EAC38F796465717EDD5D8E0FC61
      FECE8B7916EDC76969D4DF7182D8DA90DAE6A0A26CD7ED23D0E81ABD56CF5EBA
      D6EEBBE96686ABBBEBD3DFC989BE81DE2D2F4A7E6DE7DE1499A79B53647E2EFA
      47E9CAE3C0F0D562A2BA9271057C454E075C0A50E251A298D6191047C9552B66
      5D67E207EFE3BA4C44E5FE316411E29BF771B601B189CA8D01B969757BD1B080
      EE16647691EF804D362DF21A6592C605A26D082103F1E5CBF7E03C958097C7A9
      E29B221057C26B8CC83B95DE43D460960C46C534EA16259F206FB0C3E49C8FFF
      7BCD19914883D17B30475823834933863DCB1FB5C8B62E62A8744858A859C77B
      0A5C18AECBE61438642C94EF8BA4AEA24FE93829561A077B5C541DF962C73AD5
      E4FA6DDBC725C70D2971C58C94A77F2FE617F361822A8E37A43B714A35FBCCAA
      B4A14A6141A917FF5A7F94EAE88B40DBCF9CBDF749F985FA82372C2B133DF9FE
      E5B60F57112C41B74D5B49B39B656552EBE45145D1D315A14BFB91A4703116F2
      A0C09D4C8995E6036335BF8EA1099FDDEC1850E6D6808A3508AFD7336678BFC6
      10FBCD50054805AE19CAD19B9905EB1EB4DFA4BCF9524F3891A1B34E8CB8BE46
      C591B02016BE2339BD2C8222D78C582E76B1485C8F84562615085B87CA27E0E7
      5CCD6BE0520F0B9AD2E5FE98CF61EC68F402884C31895E9F4A051B0633283A2E
      B5CEE2CA67CB542057771559D5FB6B9844CFC424DA79D0AE06C54A8B892D57CC
      304E41B09C75354844E731E119FCC384EF1D6F16A688E862B9C0585A8EE653AB
      DBD110F0142D170BB93ADC8D53E3AC3B96B87DD097ED1CA0F0795B09B2E37164
      E61F85F66F508F56AD45442ACDFD34AE0DB7026505C45A762C471EC014917CF8
      3D22B7DE71CE9184844850F1919B417395C29B199827AB8B22E3204B67827F1D
      91AE9027D78EA019D6AEC4F38C8EFFB0BB8408071556C1D9DABBF8802ECBAE79
      D8E1522B87F275A2639E42F5FED62B92B1D2381AA22421A96D5800F938EAD657
      3182CFD5553CDEBDAEAEE29BF133576F6C927E7B5030FF5CE263B49F8B52B2D8
      E4D832ABEDF0FC94C177D104383F1413083A246742AD700E96F95674CF3CE9BD
      EB42144C963641289363471167070B9A1DED027787E7A70FFABE7BE3B16A1676
      779C63137BA746D4F9B8D52CC620388D4689B72F82715BE44950FFB0B424B0FF
      8022C6928294F26AD4DA9DCAC51AC47E0425BC5788F396888F870AFFCE33AB98
      44EF8B6B89F59CBF3DFBD8E26EB1C8D3F6D4895BC34E8A3213B5327531375575
      19E7551693B2E1E62E608DA080C3EFD59FB28E8E4ECE2F6C18862C242ABCE07B
      2A11DED2F881C977B5624F6F3E7C7CEFC2A51AAF4441E7BC3F896B54B3D04C58
      B767E58E5C2CC9B902507275849DD4DF4A3762D9F7A53AB18F7F0529C46A5449
      A902A0319C4F4564A32770985C51A7D5CDBAC6AC82A7AF80EC276510ED39FCB8
      E5DA688DDAB2C858806573D7C2DE58D17939585E8BECA0517E2064599420C00D
      6F4CE865BD33A659659D6D5BE8B4DFB1ABC320AA7BE53C598D3AA9D98C9A4A9A
      382725C2BF26BD4657E225BD80592A3D5C4C7EF24591378F79B2A08E44C5C3DA
      6E32DD6314C5A5BCDDAAD7B9FD19DD477B64621F49BA0F0BF3EAB71EF5A24728
      4B8B708688A6C9560F44551F899ADA239537E81CB3E2068AB222B1916775C7EC
      BF4756D586E57160550CAB82CFBEBEADF2C7A3B6B8C223C9867665CB1D262822
      50D114F7C825EED95916FBC2582BA7FA14498B61B5D978086B6041D741EF5039
      A668EAA495815260018F8B91C80074C118B35C3486E41532EED160A4A395A054
      A99B869DCD57C32FE0D57D5E9A45D95B42A390F9E15B50C4016C3F44D5580F71
      5D5D61A93FC721E74D4817981360753870054A1686C14612DB478919F18991E0
      9836EB61AB1EA4C754574326F203B19FD8951EAA3EA9F43D9BA27E76C57CBFED
      E0D95B13535F41030DAFBD9CCD68E99BA6D403D9127CB6552796B7AF89C22BDB
      FE9EDFB877D37EADBF82CE996BD60552ACC9A333BEEDDFF6EEDBA23666C3C70F
      1B2DD9DB6FDF5073E9633ED9143EC6A7F8B0F55A7B6F4E165A5BB337DC59A454
      42AE48495789F663B940743F9CC294953FF5A45CDA1716574BE24AC0E504EB39
      36B4D7DD6296218CB222B9ED2EDB119B1F1F1C0EAA0CE1A45F3C2FD661BA3ECD
      75211F96E0465D5C268CEC48526C2BA457948D60E1862780A0E23505647C3249
      A1F8A8165813A7454034679B5A20428BAC8C8AE914C7212CAB952DF224B1C5C7
      E5D17E133F0E82412EC699D64DC2E1B7D5F9D97497926B6909B521371AF13808
      60F86AC4B24ABB4C885E7647482E4D4FE5257744A5E1AB8B4036147F885D2AFB
      98EC7EA34591BB9E4273F02ED68DA6C36F9BA0FF7009F96BD3F15725E3B74D58
      C1C92D9AECD356B88E515077E2DE00A030CBF1D235D7ED9D1552458DB737573E
      D1BB48F220898BFBD9755F6677CFEB249E22712E89A74BB33F90655D41A0CE99
      5D12526317E441AE18BC090388193B17312B805D5050D6377854493D1FFC68F3
      793F02BF735E472F5FAC1AC9039722439C04AC674075563FC197F9C39A487349
      5F1C370B29A779F404C2BC7C21FCEB7B747574759763D34AB29A30DE068533DF
      BBA0388659AA7EEA53FC9B8872B614F00ABE0067A3B1E92CF7D6BB731292CC32
      2DCA2E35A8B05925303B88BA17FCC8E115100247BE0555EC60B739841592D7F8
      69319988B9880F14DE2A2693569121C1B424406DA97EC22A904BB04D5637F22C
      5F30A89F4BFEC192D2E370407E1EECAC94AEF010220A7ABF6A9682B4DA704279
      63F9D5AE236A487D695F5CCA55CE94809331FE8505C18AF462E74B8AFD97202D
      A451E141E7CF78F0E05FF84956B9A56132294AD424C6AABD4A137631AD7ACDDE
      07B0B772E0B0C4517282907EF052F2BCF64C606F66AB6F37DC2C4472644A5A90
      4035CB0076233FBCE3BED571FE335AB880FBCC95D239C2A41B611EDD6A7EF308
      2A26B473585FB2D478849B0EC7BC2025C5770A87A22AB16305FA65BFDA6BBF0D
      62A4ABE2B78E2F28CAC6461E570AEB7B3B3C5BEB412665FAD5F819C13468B9B7
      6EABB6A6156595F5146795A341CB29BFFFB39DED9E4CDE2A00AB424049639BEC
      849896AE90E18DF2FEB452ACA1BD9A54E71DB350F3C78C22650C36689C66ACFA
      B1ACDC60AE9C00F8C101CBCEEF81254013AC57544D97055845DDA07E20EA9DF2
      A0F2CB3271278AFD40958592F1CEABA88FB583D9EC816B13FC071628E6494EB6
      FEBBC23ED8FCF007FAAF9566E035AF7A7F091468A56240C32C81C81C9985BAB0
      0CCAE97863B53C421ABC0C12990038DC17B27665513AB57132AADDFAD5B85AF0
      7CD4D61359420D5108CB53E21C581B729AE32225913534B14CF46B51DBBCC8FB
      E38496F4E2F93D30A331C3017FD3361EBD126099828FC6015BDAA995EB2C9812
      8747788338345E41895EE805A56CA5ED5049189BD4AED59CE5FEDA7D12F18679
      39830D2CD7820D9924E779992D04900EE54A435D38AD8DFD25481AA4FB80B664
      1260076AD2194F430D750CA2232DB5BE8851F16A6AE352ED86D79D98B01B9840
      03E3C92334ED214E27845DE23201F3E2B2D00B49B019A8239888C29DBB504030
      D0787E79BB618FF624298741411F114F3B3F3FF4DF6F98EF245C9885DB0F1EBA
      A90D1FC2D07B12AD63401D8FDA045E0E30E4B3050C3930ACB9136431F2445389
      40D1C55C5880DD20FAAACFED795541C43FDA3F925618CB2419142DADB6AFD871
      13715C988E101537CFC0EE6A71581CC1C46825490DB356E2A16B2F707DB45BD6
      25CCABC202F49C4D990EE43D70D8B690488316E6E3C1307E1ABD5D563371A9EB
      E8F8584824E641E19FE2964320C25B26047F837ADCF2431810AFCFF7CAD1D57A
      AE986682C6E371D5389C2F0ECF9F89A0278064A9125645D7489D899BDF34E415
      983CB4AB50798FC7884A699F8963849424F705BE923D781D3623C7268F3816CE
      D012DB5A1557C92BA23DCA734E6088E45B5DC6D1D782391FC20489C17015014E
      F15E1B977F5D44EF8B2CADAEECFDBFDF51BDCC662D5BA46F57E031173325C434
      65EEEE004D30094337D9FAEC02FD5E60F404DE3A0E134BEA002C29A61E3612A2
      175F53A194E8198BBC144616400F8CF6CA243AC0717B0777F5AA4C73D26ACE51
      D6EDB50809ADBC503577EBE3314ADF72B776D0516423931C298F6C3C6F634A64
      C70EC0165A136E779C8D58482E53CAFB8FA1CD2A4F5665243AB96490E01E6E93
      48A456AA9D1929B6259C3CDE9FABCF3F9522D4E051E3AC536520764C805DA5E2
      E393B749368B1E2BE1347A1CBD4BBECDABD3628C7FBF49EBB7F361F4D88834D1
      63C70F7EAC64D8C74AB075AF776F6AF4933F4C3D90DA46CF06CF7896A0E95D51
      E581851056BDB61C01CB242752832A2EDD6199C4A8EA33AF8B7E99088AC96A3C
      D3A4C457B7140B7F41BD7F5FC6DD74C51A9ACE1F0EDF9F20E7F3F4ECE0F0243A
      3A3E398CDEED9D1E2A21F561A51C6AD8D3921F36F3A892ABAA27BC05C9A4F707
      5BE354C3105348E4413B065ED663D3209B16B0EB4C806C5CB882C6AE1EF583B6
      7D925C82CFC9CACCB8F7194699CFE4E2DC1502A7902179C3380EC503E7E693E3
      72B17FF4116F29809C0F25083EDB392AE8287D9C757E2F5D808ED44FC4255075
      02BE48BBBAE4DFCFCEDE07CEF6C32E86B2F892E4817D632548A812A58E613BE3
      E832152BD498C21A8C7FD08E29D1E0F8E2B42195400A0324885BE9F30F4C7795
      8A9617C52C1D7504FFA25831B32D3BD11B9F0E3F4C44D6A362D9F3027C84785B
      C5845B7AA3A5C0544F0EA8DC3949051F92116B87C80CDE6FBB2EA764192B9686
      4C5A05EC16B3638C51E9944194E3A8C65C53FF770960F790BDA515E232EBE524
      F330C4281EC18271609D505515BB1096864BFF09C8CB0F2AF920360D45CE92F1
      2DF8251C70A4B85106735E538F8646888496DCC8933719D2952BA6BB5B454B3E
      AD01863CE49B98B16FAA8E92934E28A99851C2512A0721C941F8D072CF79FDBE
      6395EB7178952B682152FE1B9B336A4989A5BA32967013CD8AD93C8B81F002D3
      82C5DBB0C3DAAE3EABAA2405C83D5C373346011CBC132380D7076A6DE9578D0A
      0D5932A6E153E466FF6D6ED67B7B12678F5A947A49AFF5E7C58E57630CD6B619
      DABDD09A350B7B55539EEE304CA26181A48A7C2CF73322EBE3FBDBADBB9BDBAD
      9E80B51ACDE9F82F763C55CBBBED56DD4AE00B24F968D697DB6A0097D6021802
      B736E146583308EB02D0BF2CE3A938A4032C3D2BD0A2C219541613E387328B8A
      E077E47BC3E29BDFD9AC630483C81E3E99D375E7B32BFD3D69284B186A786D8B
      0E74AD44AF4252B1C9368D1758694F9FB767E1E90F320B17F4D820F1016F2D6F
      89B72D01792ECEF69724FFA12850CB890CBA4FF3B04B2F91D6FBB880B0BBA3DB
      F82F5EC4C39D3624CC512DCA488A222C7678E5ACAA56EEBEA88A817D8060BC36
      8C5711888D47AD225E7AC729BEEF0EDFD5A4D3748C54CE897B2C96D218B6157B
      AB040F06E8D6C197286998445DBB168A129781C4ECAE97B422705D908F16A486
      73D8B556D7659CE69BAF0A314856EF4B654232FB749196DC9A58581DEB70DB93
      8BE8BBE89C61E48B0F27D177D191EA8706BC4BB4B6F22947CF825245B8D20841
      80E0A2B7F4972499419C8A2019FC58C300EC421ECDCB0A17458122790B877CB3
      35594EAEC17048EED2A4B56516853E875DC7D096095E05014116A5BF4480DBD0
      72AB2AA307C86D8FD0DF6DBE04FEA32856E6DFEF45FF2AF01A653CFA023DEC87
      580268F3B6547E5D13BBBDE83BBE7C7FF3DBF7E3314EAE764DC7A54831A98082
      C1560D4AD6700E1332CDFDC30882DD58774DEB656CC18EFAAA2CE697821E77F8
      0B6A2A091A66F0FA4D552349061F75918965A1DDD691BAD300E6447497836039
      D9D62931ECE5198A6AAE45ED57FC16F71E529831148CFC234E36699E93CC255B
      7DB3E692E9CE538B2DF1852D881EB62F160D1F2924F90A3A491C561EC427B43A
      BB63298FCDC55DA8260DB8318E5D22E7E501240EBAF657FBB6FE38FCB234B86E
      A4D027356F21D2F0059384A0816D5EE17E28E1A70191921D8AF1B2574B2B5C67
      080EDB769595A08F1713DBD5474DEE007DCB50C6D788F6B1D6136C774B741815
      59312F37D6ECE0536CC2DDF1C86750FE7F9AC006613C4F8E9F7C0C084AD667A5
      DFA4F7C0138F6A47C8094A1B3AD0ECF10E821FBFD3ECBA9C83A67107CBC9E95F
      D8731ECBEF77E47926E8AF94257BA121A96A8E9A2A1F360489C23D841920A320
      5B523462F38955A46DC97CAE5648A85722FD211AC029B776D4C453624B717929
      2ABA50FDABD2618AE228C28ED0EF4362CC0A1DC88FD4F080AE9925DE4AE11DA5
      A58809272FC2885997632EEF24B3E6FE8EC22CDD85995897086432D67EE8A60C
      DCCCC0986DA2D9A11F3F422C2EC82176DEBC9C4EAE441FBFD76DBCC3E3B0C794
      DB08DAF76520B4A5CD27FF6D7A79D53F787F2C5B72E30D1CA416369F101EBE8A
      C64961137A3DA39873B550FA51FE30894794D9AD2CB8F753F46477F7FFD8CBDA
      EEB7D0F1C0916AB3749A4A10C7B1697548CC851DC656631060B1080DB90C6CA7
      A739B29DD4E8E0685ED56256D9DD71B721EEBC8DA7C3797989BCA7D37665B545
      A7D47D9B5FBE4D7AC432DF977B48C16DAEFC2F7D0A562805A9714FD2FAE93A26
      326FAB6842309B610729AEB45DFACC4981C1FC172765AB07582606C582C814CC
      B72C0E0B4EC0563FDC20CACB443131BC6A107B5D426E3383B9FB572EB071324B
      72E2E420334810937BD913B7C3D0A628A35F26B58F1A33F8181A7AE2E2DF2180
      7D7E6266E86636AB90A59CE58A36AD34EB32D65A37A01CE06FCDCAB016E39EBA
      CB5A73DEABA4F5ECD52770501C36D06916DE89526BB59A5187D76F07A8BBDCBA
      FC9A29B5A7A5D5FB88A631D3FAF933BAB887DFBE7D13D1C4417488AAAAD98D94
      2C5D60B771838994A83F21434D0836379FE19F4FBF7F167530A61DD7F1EEEE2E
      79B10772353DDFFDF185EBB6FBCED1E1AE7EED90528DFA96CA5526C9145A4F6B
      6D7237773E74C4F23D81E8BB9A2CAE6DF821FCABB28BA928AA7F948B4BAAE08C
      D3CBB4B6047DE390622FBC3BBB20EC9F89F68A4A668D11A29A820F16341DE737
      D3A25C93881B10A554304D6924814E9AA017222A9FF86AC20D0D7781FDA7B3B8
      E64475B53829B147179A26C0923BA54ABC301D4F46BD62FFDABA17E4B57BD14F
      D1FFE63CB925771D9774C27CA4CC5F334B96F3DAE56F7C9E5B9C5AB0686F53A8
      6B3D4D6B6CE2A1ECA9E320DA02E09EE0AC63172194801F9871E386D66EFEE696
      5FD9F2FB2A998F8BC596A542B49B99464764716A4F30FB2EB4B4416F74B3226C
      5DC98F61F64ABE845672D0920F5F93C630EBF486FB7E8BBC964D8EDEE0DB218F
      3548F770424B0641E358387BF962215D49133624656952BC7C71877CA5404891
      8381219372542EFD66E0B3BE05C5D03C157D4983CE172A73CA95C2C93EE7F6BD
      394FBF5184C52916DF282C12146FB25966F867F5FE581C7074C1DBA112CAD383
      5EF4CAE4E2CE6F9069E523FC96DB048F4EC8A5ACA212D7CB3A8E16A7F3117154
      A9D730124A6023F42D312F099DAF7C89D7739442BACC412F8CF33A8AA7CC6A82
      D40C481782DC31CA3B51327049A12BCD421151B420578A73C15C7CCB8F8C73E4
      FE5C3BC5EE8E252EF83A59B7E6D1AD58EE6E518C11CED8975A06ABDEB4F98390
      D2AC77A91CE98CCB8E35CD503EE222114044A2B6263AC6AC26973553260AB2C9
      D5B4FF61DF19CA92238A582E92A434694E5564564ECF876422CE80680D88785A
      A1DD48A1F3A5451C80A3954985726E6815D71B06388FBEDFDD6DA795D092A2A0
      F7A4B1A3EA987BCFFFF6A94AB2AD07E14CFE002C05719CD93937E2ADE1968172
      05E1254502555AF0794FAB787B12265E7BF53952AD9F5ED33D6A8028D21143A0
      7FFD2F9CBCBFFE37379B29E4C2CE0C0D1081A9657D402A4DE29A383F6B89C24E
      50F026CDE7350C17544F22D35E778F62DE6646DAD6674E9AF10E6505365E21DF
      7826C215EA4A0579D378502613F90A869C10A5445D822CA5341729FD5F7FB501
      E1FE4A7EFDB523BB201EB112ADA00D7C9848BF5316472A1970D9DB599415971B
      F65B71C4DBCC0DA6EE6C6A701C1479CD7E477F0DC9D12A1BC4E2F06C75CDB9E1
      9FC3ECF5BF6A19265E2CE1607B0752669D947D7CA877D2666D5052DFDAE023C2
      36F454B23D5B2693957E637FFFD5AFFF85A9F9F5BFA3BFCA1CE9354318CE3F78
      734918A88BF471D44866A1F584C9ED6A731693DB37E3BA55A099672E62C1E7F9
      8CA0DB37B99699D018923A47AE3655A88B229D979B4AA3A78085E84EFAC46417
      38D97FFF11B04712F0168264B7E0EAC4F90C8E325C307603AED8A2B3B42A3B3F
      B81C444D97D7C6FE87FD674FEF3288F203BD7BC21BC789707297AA570770C7EE
      A960C36EDC88FA88CE7AB6C7EB8C84BC3D9EF2B772AF361FA86312AC93B167EE
      93995A8C9319FE6303F357CB32A94367014867518AA9CE93511D78D342F3E6DD
      DEBBF3E3A80B4B0E6A9E586C54388E4735F077FDBE2E158D8BA8CD132627BB4E
      77010D08554DAA60BA87C952956EB029B19F7630D4C408518EA3A106CFFD6332
      1E63210412BD64C5EC204383143EB9F383F1101725458565AF1B049784AFEC7A
      ACD88B1ED9CDBFE982824040A6DFD8C0D90EC825006F18E3B8BD1139668DE2C4
      AFBA441963356B00C9844CA5CC2F1358757ED68BAD585949C953B408904B2785
      199ED95DA83D432935EC5FD8037CB34741C2719A0B404740C122E97C31BBFC96
      0EE2D9F91DE80F7C397BDDF5597894F3F2E0E0C228B134787219C3866426AD74
      703BCCF68DEC20F76CEA3342D8A3B4952D00180F2B6A45F63CD98F4A2A80D37B
      2CB0C7CA926D3D49A6EF1AFFC4DC2F329BB72B484FFDE75989E66B28CF635A6E
      66268F48AB1EBA6C7EBCDC2BD168674D515F1E55AE4A686A68005E6C30198B66
      71CD6053DA5AA7FC064A9412D1F17346B40B6104093A2C5DDD7704D571562C99
      A2C5AEBA129F03FB9BAA8F0AF94FDF0242ECF6E0EDFA7511AA4F6ED6B5D628EA
      22D1D560FB4BE43D89F700051729A40130B6E86C98A55F99E868CEFE33D9DAF6
      9F24862497B140948D7E88147815C68C7DCD4428655A074DE0BBED4B4B178255
      938380A2699024A3A5F9289B93DE9003E99058881F9DA8DB50F0349FA355C1F5
      CEB3E755C7DDDF2439004E012197A5D3DC3A79DAC740E0A2052386EBC79D874F
      9E7EFF34EAF2A8EC472728E71D1DEF34950782B475C9DAEC8F667DBDB35FFDC5
      9EF493E608061F807A29C497793DF9819BDA372CD62053DA6F5535690844B9A2
      D56B3500DB878B6836B48741A72CAEA28F17473F0C1AC9D30A74379B24B2D6B6
      67FC7395CA414AB4AE10421878BA3886B9154A718370DD4A79DC00215B3C49F8
      7AA6DBD7E02138534E85F5087FCF60CDEB36C5B20CF5FD9AEB75F3CBF1441B5A
      792F063BAF8BC57D7E28207B918D650B8621CC46D7E51DB19B2F73BCFA769764
      5CC6C37414F5B1E65F6CF504F8B598E03E2775BB47FC2B195D491F76B77AC038
      8628973CE1E9564F48F2CBEC9E8F98A0D8EF3D1F019FF35E4FB84CCA29C4DBEE
      F1843249BEC8039E6DF580AB797E89C204F97D6634ADE32CBDDF8BFC339EC5F7
      5D9979515E2797F7ECC84C92BAEF311A385DE797737999ADFB51CEABCABDCA93
      AD1E51CDEEBDD3AAEB647CCF47D4F3F28B7BC4F3B5C7EBF9E11F7090AE384096
      F4C9CC3A552670019E3FA4A34BFBB8E22213893A3289F48A66C6532066D090BF
      589F3CD228FD044B588523F86C3AB8928EE69AE85278A634DB43E2104E26CE7C
      5BD1141A165F931DA0CCE42C4AA190B642076BA50099AAA2CE47A90515FEF995
      ABF41A02552CFE02BC6DAD4297984C5E13312FC81F0B0011914583ABB5D837B3
      30672CD32825F5C0A1D1B2EDB49AA25F463333C43E03B20F054584522535BF85
      69A9448F7435901D3E73D5F774A9FF1506ECAAEF7D01FDACC8FFFAE2C58B17EB
      503ECF0AA56B2E0273486E7146B2946EF03096706FF0EC2845A924A13230BB87
      B9BA64D1C640E3D72BAAF9D6BD154A22AC904960A44AE16931E7038B3DAD9AB2
      69B66437371355CEDDFD723D7A65093F6A660762749D43999A4ED4ED1CE61D91
      3FB1A386D461BF6B2774A642DBDF0DC2123159F372B2577FB147FC04FD1F02BD
      DCD4554D064BAB768CC8D55EA735D9B1A1F31058E2AE687D4335888E9A6809E0
      A774990340D3FDDAEDFFBFC0FBF86990E6A94219EE2FA9D9E22C7B336938DCC6
      ACA816BE436797A2A4746BEE60F9B7DD910DE93F8BBCEBA508AEE49BB69A30F2
      887150FD44573AFEC2AF2AA5A073A03564FEBC1C2101616FEDB699C45906B2F1
      F21EE1E89A6B3D35EB0D617B5DB7E26176793D1F9D3DEF79911EFD0206808EA2
      4E8694554CBE511B400FA1D532278CF785C326BEA8000F8B9E3C416FE6496AA4
      1B23A102531AAF213C4DEFD01881A177E88FF42010EA4F55C39007945F56BFEF
      3F75CF06DF93E0271B5618C0B85C71846943A92BEC49D7AB71523197D8DE7535
      9D64F9F2D1D25AC038828DC98B49CF417961CD858F4657503622818327710BD6
      81A922AC0677A1FB4603BADDA298E3BD16E9AA0CCE25B0DECAC5B3F8FD669422
      0C502C19502C85E5C8832BE156371366A3AE4243CB8E34306F42BC6AE138DEE1
      CC0A02A3DC4659613DDF659A4888A5B5ECCA20AA45992D7C0F1D8431E5057759
      7FD8CD883D224CE0BA759A34A2EC25DFBD007596457FCE8BFACFA604D6B0065B
      4BA85118A88B11C6251620861B865B96989B8D47DB5AD6A5799915439EC9C161
      D1C55BCC5C4514A073CB2FB59D50D76D340BD141A4E78D667D361D7EDEB879BD
      28FA7660627F346BD2D8F0B638B6A98363BC4466AAF47C7768A7935853AE2D96
      1C0C2706CC2828CDC315B166062F15CD1DC615083A37E1811B9E956BCE5D794A
      4F4C5B5F0A58562C95EB9AB09D1CB941C1E6E0B85DCD1C246C0D4DC3EC468504
      1A37CA6DCB46D5031AD70BAD485B0BDC1B7F19CD5E7DFBF6EDDB4F4CE5508D6B
      392EE4A524E1A3BBC84DF7B98E1C894184C7B89C705B0EF94DDB709665D193F1
      801F3808B63EC79B3A4CE4653D373A30CD711C7E592211F6DD4A9F8017D8FDF1
      D9EE4F77318F5C36C65A0BA39DBE11E5495CDE4227A093A699984BA54475B72F
      0DE6AF768DC449B41FBE322865FD4F342460F787858B5F498C6121C8B0FE814B
      D65BF3A94FFC53F76FCA34CBD2D1068F657860E1712FBEDFDD7D12753F5E1CF5
      7F58AFA7B9C40230DA9D1B7BA702D6E67065C5E56AE77477F7D5EEEEE750191D
      34A9A47C15FDA286944ECAE0FCE2C3F1BB37E79FF5D5EE353A2A2CD230E268D9
      263489A056F1C8D301245253D46D6CA6FD2EFE1872D6DF2D9D8EBAB405ACF19D
      BBCE890BACE1B66ABE47507B3DE58B3885420911FAD0DD4673F37CF9DC04276E
      524D3FA30A974B6AE992DBF36AEFC7A31F9EBD3E3ADA79A8361E6C08EFD2E839
      2D38E595ADA1FA2D4E0D8ED17FFCE31FFFF8A9911E8BA337B806EE3D494F9E2E
      7F97FD9995B6BD48AA7A9054B35B0691B3F75672A30E7CC7568FE9AA645D9F2B
      73B5814A2DAE846CF1279EC15B265626202062B2E7D5A8443EAA644D5A6C1534
      1B49859AA664B563201D81260CDB6BE906D3CE6E453C570B95048783D45B4035
      28F8BC16E37FF7297CAB36A4C43B5FC04CF2FCD6240BA8742C94F6D4A37EEEFD
      0927C43FCBE697695E0DEA6FF5468F33BCCD173E568F34CD45F039C86AE1B20D
      1A904CCCE00DA59449FB7762A24A16AB83D38A78CCDF6CD4D1E0957BADCAB452
      15177F6C66D03402E1AC692BE16F9573931C1C2D9A5B25B5A22CC21B479A9CD6
      850805E9EFB080DB80EC2A0CFFC980F07D481DDFF8B74FE5B7A6215E4DA1AE77
      7EB8F1EF9FC9EFCF26937404DFFFE0641FAF7C159763D84FF63AFD7006367EF8
      F3E68BFDE7A70FD6435EEB9F3E346224CFA34F1F367EF4F7F2E87D7A18451EED
      6773C46975993E4CF75F481B0B42E61B3FE0A53C6099B0F94AFBF87862D4D780
      101DEC4251F6953CC48042231EB5DEC0D889B2B159720DCE19434CAA4D2702FD
      6DFE8D6A0706B69DAC7EFFB380CB23CD20A1410934A43756CB5F57D9213344AB
      D839BAA82E8915DF1F66C5E8CB5D04E5AE8D83EB1CF2684C95CBB5CEC7C20FA4
      84BBE5B03AE440BF070FB679A4C52E89031833ABBABBBFE9D441BB1CB458A984
      D08B3A23AD353F180CF8E2A2C259A5D314027EAE1459B5738B20BBDE7F1B48B8
      E1FA136422F63A8CB218748EA0D4ED0AF62D2C8B4DCA2E483D54D45D512D76DC
      65679296AB62AA8296A220B056673096B4177B0A8AD4ECF4DC4EEBF9ECC8AED5
      33D7CDBBD313CB425B120A72383542B2D1A4DEF7C834FBB6F6DC36A66798480C
      F97E969575456810766275100211745437292B236B54EF2BBB55AC1438B97E74
      96F8E7FFF91F385A5F92BE226FFFF33FE2C9C6E05113484D201BB7F6BAF4EBD6
      5E49B69F6D6C7D4E33253D4876E7DF690EB55786C557D9DD5F069F437DC85FFE
      F17975400E8AF0BC942D424CC152CDFB200634960418C9CE6EF5F24E2A77FB75
      997DA7DA6478397923B269252EABD23B7AA031F4BAA45420D11A51CEE51B9FFD
      BCBEF2B23B3D3AFBED1DDF63411A449E1CEA219C70DB8F41554843FE7DBC4172
      1F04A33F3C3F7DEC3689729E25B48E80FA5A6B65838E86A5AEFC79C94C842924
      2617C1C3556588E84CC459F448F5E98B9C7BD4CB4921ED100B962267E8D45866
      7484197DB412C70B8BD76CF9FC05757F8DDD4ADA2A0A81AD113FA42DEAF5F6AD
      540A5BB388F755928DA331760FDA6FAC58D99E228EED1D3F393A7AF85F116816
      AFA28B0CCDAABEC9921D0D25B9770632760745A5236630BBF202C9381A5C5E15
      C8505C9FFFA2DFF48890D9D8A0B3DE08DED9D5909E1ED3C8F8939C48F23719B6
      369D034D1671F986FA789F10BFC6608A9550AB0D904A11745138F4B2ACC38F01
      F9505560F5A17A28EF61A275E8A41C0BF2C48FC7DE7DA258E7066FB0B2347D78
      ED17647C9F1663D5E8DE2C3749BF0CB32C9A2452CB4BD3A575A53BD55AA5E414
      B8B2D3A9863AF1B5CB820EB726FFD43506169F8477F72CAE56BB6F340DAD9E65
      5DA050A70455AEE2792688FFC2BBF5BCF5A4A9DFFA0A8D4A3102080B7D49060C
      1381A48E4BADEACACC1D0D42F4787B5B0ED934CE6306BC5CDB6B2A2AD9F76444
      95315DA32732881C5BCB12EAC206BE066B34BFDC71F8142F35272BAE46868AE0
      39255BAE2F122ECC2A71195961BD50DCCD8C58B8D4229AEE3B54E6BD522295A6
      7454C133B8D77C9214D8D1E9289D515799713DD1EE82E6899C286236B604699D
      9A094E4635E750C647F0982BC1F5E7B34D879441152999670C121D3C4F2B51D3
      B128D3CB1417893A3032986B1AAA1264522AC387460DA2DC568C3C1010D0F29B
      4C65D63AAB729420FDBAF5AE3A71C39B60F94A32280E00188BD3597DB354125D
      33BF21FC2F463A4A5152C24FB57E5DDF3A83E06EB16C3953CCA02084DB2A70F3
      B053A68550884092629E0FE10D2B48F16477F711D7E114FAD85A16C6F8F8CE3C
      F263C345E96AE5593D2601D0E23A6CD0D5BD088B93AC7A3151238ABFC0A7ADE5
      909142E2F43A0B550F6E214C3DA7762D5E172C469D28E6C04BF9D4E604CBAD39
      C1B28190137480AD8C1EFAEFA70F0A48C4CFB17170F2B4E67CF340983AA7B2BC
      BD492277C65AC38C58A5077369B5133DB473CE2A1BDDDA840BC2E830FB4FA5B4
      833A9DEA7DEBA3E80A2C3C096387CB608ACBAC003C56B9D378AD67E5DB757C09
      EF92F6A2AA7005F2C6A96A0C49B90925A48CD3AFE91866436392D46D4DA903B9
      5E011B6E07A3D7BA1603CF8DCAF7004692B882FE196B43C73E09D49A5D77C048
      DA2521032D671764B39B4B130AD76FBE940EA9A7F3F8403407F8E00F0937841B
      93F531FCC5D2A90D59474EB0952685E4953606668AD4CD766DF5C21B38F69513
      F1EE25FBC5D7CFC22953645ECC22B766DB20CC5D15BA05FB0BAFF0CD500B284E
      09285CD83110D84B323A1F8FD753E428E5214407EF6F3F75505B03AF5B9AADEE
      188A617DC0CE7EB34B83C1A0D3A84F59B726942AC858627C04FDDED3408560C9
      F563DA9B2A3145F7581A6D9D2AA322AFF40AD188897984A17AADC3C490DC3483
      61E90C65F7249848C56A2127C1E5A050824195AA7A454139194D78774AADA275
      5683B250D5D133274E631653578D83EF301D667C31CD6FF95E68160EFEBAB033
      E2D5B3D20B8C2406F07CC925D811EDA971A2ACCD2D1888A2CAC4B849E70C7199
      886961B0E7C2510D6E97ED3E07FCD02E45A6793A9CD78EB5E26B9AE91D60E2C6
      EC14852DB861EC7816FCC49352F4C15E81CAE7D901800C56D120DAA3B983EB38
      858EDE6503DE70ABA7B9F42CD334AC6DB16445B9EF09A77EF3C3A3F59C750BB3
      DDACAFC26DBCBBC6B0B002769078B8D135029BA185400ADF3F5C44C7398AC16D
      0438EA334492733EC33141F0A1BD26A3EFA27D11FCFF880A80FAEF03180FAB9A
      D9FFB0DFEA27752C8D031634727E954EEAEFA4E746638E0D2F17155D394A7894
      D1E8D32FA713895EC8283A7B964D133858FA98B5DE4013FB035AF861DF5E659C
      C0C06A0EFA013F5B8740847116F6705109D7862708AD041A5F3EADA4218822F8
      11359783D1A8A4919EE4D85EA7EA3AFAD108429E12D4BC8E914C610A43ABE18E
      7874D5A49778351B208E5B6AED3A14B0CFE4625BEC90DD0C749AC50E818BA7B8
      99F6D8850FDC6614D48C2CB82DF5002472D38F8C24D1D43963D52A0E42C359DF
      AEADF3625E8E90E5B7D73E83DB8DC98DECD0000F1F3439931AE39041506F5454
      E683B10DC6555F56D8A70109984D6BEFAC27CB0FAC4D5FF5A82887D29F3E3646
      F86E2E7228C05988AAA4F93D6652A441A393336912409CBE7AB0D7C2FD140AF0
      FA31D5A0AAA3492F8C47CB8E74493136CE01142F0C7886C86ED92E2F9FE29D5E
      3E0DDF29C9C77175C577D2C2DDFD36B7A02909E880C729B0B91276519C6583AD
      5A4CF3E835A2B0A8F5893558E455329A37229FBA06619F20F44045F9587E3588
      F6F21B1751715132C675DB83AE347638D9B632D4EF5D7C12CD875B9F64327AB7
      3C88D282CE147705B1E4514E3198F5976F647CD75BFE3801ED4890C200BC2F68
      BEA97D238C147783509E99D71B68D180FC555C9B5F75FB9AA54B578B6DEAB835
      C133487240E19034321B9FCB1484969871B5F6BA35DB92E61F458638A5F08293
      72BBC3FD7DC3CE7DA776AEB26D9C5DE02E5F81CA34F32B1465084FF7F6DFF421
      5D6823561E596F451D37ED313BEA2E7EE25C8CB2DDD8EED7E6A85734BB21F221
      D2126A3267E96C58B0DE87B3FF79D6D01CD6F343BFFB8E54B375A59B965ACA8B
      262F0391BD658E801368F141DA0567E036E334A8D102517E49FD991663168DD4
      0CD6C6611858FF1BE86BF2D50C1D091A85CFDB0634028FD7C95C36A2B375995E
      5E32366F8E419E5C03DCA3A5E51E4EDBA5A9D629BA68CBC2E82BBC85D630AC04
      1ADADFE578B7286B8D9C076F142E4931730FDB40668C9BDB12DB02CF0F786768
      9CBAE1D118F4DA034F481CC2BA1712A32565188123673ECB5592AD7671CE0030
      2F0C9057F1BD756CE43B92B8425BB029A2BFCE1F527087D6D1F2E6554E7B9848
      180CA6FA6DE6B8A6B06AA44F346C1A72ED4B0D9995109F06A63602B2F6604161
      0F551E02C1ECFA59859B049C2EEA3032750B92D462E92F2B55BF5E6171817DA4
      02B752F8E6767C5A8D320CAC15B7D37BC15B8476747241B40F417835A25DD808
      F23501FDBBA46A67C9EF3305E23B067DFADD67A18157F881B71DE480A4DCC860
      1EBD5C764A88314BB7784910FBF6212525D5BCF58719CD3CEA08D1955E739AFF
      B1A31A42720BCBBC7D0DAFBB78C398617D65B97E79217840E988622134B7FF61
      7F832B5605EA96AC00372CAE7B4154C53A784BC3E873B83AD6E3C19B183A5745
      C1C6C4D868C47844145BEB4D699F88AA3883C0812A46EF0A591277235BE0C565
      9C92F15AD5DAD6F79BAB0B572A02ECD70144E8B1137FA5B8D132C021AE169FDC
      FDB67307E9DF396422DACFE86CCE9CBAE50182D851FBB8EF4F0A9F49F8CBB7CF
      F612AB6954DF0FA27DC5D824BC44A7C912D179E58A4248055D3C59C979F4743D
      8FEDF6BEF1FA7069377E1E5A6AF64B6333128C59188DF090B9C526ED390A44E3
      66B346E983E2CD2599318839C4C30D5E5668DC8ADD2FBE24457AB570A4A1AA4B
      5E83CAD3A499C08775D6B455D35C1625593A4A4CD21567FE2E85172C974748D1
      BF98B2F667EF83F801EBACDB91425F5CF64B3F5B5D17795D752934423F010F7B
      63F2B5A5079349614E25371014F117A701855306280F5A26F5BC943430492F86
      3D5CB924266707C555342EE34B97AB2F3BC66501350AF8A9FDA4228C4996B905
      CF4795A8C4172E3FBB06E5AE239342AB171A0F745616C30CE5C39C276303BC06
      7367F50E4E9317515F355F6DF09C03A3E68A6AB2935EB262E6496A0B9891868C
      4A25BAAF49E628B8B620F4B6335E00BCF850FE9DD79FB1F4EFB2D8ED88736250
      2637B55E3CC6C01D27A98002394227B08759D92E0C50E33CE2D724A7CD0A11AE
      6AF0AD1264255A436C642FD3788DA31C29D74DCE0B983E16BAAF0868A5A264ED
      FAE6010276665D8D5CB5824671A5177FC8600A74B45CAE0B483212DC329696FB
      A208AA697D46218B989C9260B477B85949D116828A2218EBE278CB651E42AA99
      9A2F34BB82E74B891663BE35585C226F16F0EDF58BAA23369D1525B4631DFFF5
      3A16AF128A2BC65204220D623B0D27966712A71B3FA2B49A32FBEC78410C02C1
      CD645A9437567A6E995A6A7308FA1CB203BE11CA5154ADB259A047169672D675
      FFFAAB0A29337ADF8BDCE7E36C54F5A2FDFD6AA7014323694C00D725FDBB53F7
      5EC5484CEB0D9141D81B214B36E8B063C53550C10DBA20E03303C4A88FA852CB
      FEB5961BCAAB0A749E0371F8984B119FB7695E77A232A17E59E50FE90E0D39BC
      57476DBBB546C5B20763A9A855DD2AE7DB459D5257EB8539A056C559216660A8
      737D9A3154A97B2B16CB935DAB6E13C511E4570AD40D45752BB7B3C55199E7F2
      9B246A161B85DD51F945AA2D29DC06BE5A71AD7C6660327ED3E93757C7B50D9D
      2733049DF2AC4ED912E0A39102DE66306DFEDC5FFE81CC19DF04D266AD569D32
      B29F7C6F057B7407A7A8A850617DA1462C2C50A4C9D09D43FFF2A2F857E27EEC
      46F88E17153C2831242DBCE3CBCF16F96289D2859BBED37A4CF775918D77ECB7
      1D5D44EDD878571793D051CAF91A65BF5BF32DF448345EAB8617A6B7BF93263F
      2BCD95D118E3AA221886BEDFA166A9E27869DEB4A8364E5C5A668E895A1EDE2F
      C686115E645F440B5538126F740CDA3B52E29CA2BBC487777AD15156C4E00923
      2F8E03405579F940EAECF2AE75CF122223D33854986D5DFE0B8E0F5BDACB3AA7
      3AF6A241833074342E8B99D051B093C9489E154C2D88330BA27613BA353466B4
      FA6960935FCD2F9120D17506258377C26D8E2FF3B49E8F931D3846B00FEE3087
      B2320C6744BBEBFC8F253F89BA2AF239BC593AC34DEA17EDC140F07F47E71C39
      275524596CD0F210520C6D8A6199C45F945969256F69B31D89391C97BE3A00DC
      9CBB9510A21551272B69517B9C015FB008668831DA2D0F429E121AF3A3AB3459
      770277A40B2DEAB8AB2B7E525449597542EF4C5207015FACFC692529B72647D7
      C856F86554DBD7D04025AEA8FFE3312B128EE2ECA238A57DF2F734AFEC17BDC8
      FF1A9F87FF2D4F5B8BD83E6BF69D806650AF39748CEC36639808A727F7D5E203
      A2AE738B7CB9C19DC0C9A28152A92E46107DD14403976BE17ED0338D46DAAD52
      50B0D9046FFF46E16F5BE41AF1576B13D3E32E7BD5AB0909A914A2F0AA71FA8B
      625E8F5017DD98407931BEA50A64BB7939EDE4A694C24096C322CF707A1C56E9
      0245511E2112CAD3D4B3449A0EA5CF75B12F4836455052625CC6DE2773BB2578
      291596511D33299AE15343F44B0C7264498CAC0A9526C210354A46F057D27DA3
      BA230F445D02377308D7997CABF3CFF8EC35FB52B56DFCECE9BCF56E651AA755
      D4998022430DBF4ED455390EB77555D817794B41716AF38A746EEC187353693C
      DF028879DD0BE6DED145B53019A42683A18684B0EBB4458E7D86BC2D3C94C494
      2A2E75391FD573C87C9919DB25E2A539376101660298E247798AAFB66B35505B
      0B3D9649249B9EA66E551705EF0C265BCC71CE19B8165DF8B42B1004E6880F23
      C26476B361CE1445D3DDBC6C4E2035198BEA372D28E96C635A694CAD5F0A7ADE
      042B745F5728BD87E41BB84318E92079403C0D3941390327493CA93A321B9DBF
      CD7147F22B767C0A4626E74A03DE301079EDC9DA797D13BD8EABE40327AAA354
      66BA65C3E29B5724E67166F1F200611514C6D5A61952E0D063B0DDBF8A82B40A
      7AEF1F9E9C600691E7673587E5AB3B9B6CAE56E73C29BC177DD78BFA324E7F86
      9071D54ECA535426EA08BC08D8A2D373FFF5AEC8131BE6E3FC2B0C091719EAAC
      4FAE951C96A0A0AA1DFB564E5C1681B98816E5B53D66B925C14E354D5846822C
      6F44634AD4E3898D08A3E5192D0D5FA7CBB15C48CFE117D5097515D7C6AEDD16
      5385C0918F304B8B77F194E2D19562C91B96540C83876E108DCCB03A13B74A60
      0018CC374C78030241B107C6D9869A20A184B795AD5EF2262EC1546B183A45AC
      E18DF4730DD86BAC56B01FC9B84364A1E39AEA1026B4746D29A4D5F310638C5A
      29D59540410E67367036CC04941B3D046114D7AF0AB91C04F9AECB74F405D5DE
      2A119E707E062ECB82EA9CE2EED509AA255A9B102B5E9F5C7A26FB7BD928BA69
      B692C48BF5C5FDC9E91EF1789EFBC7D919E3DF4ED087455371231C7E5FF5C645
      BAD2123997F7DED59BC47A64C85A6A76CF252D77B2B27AB769C6C752021CAA64
      5043A6958328890B834A7D7B8415E221CF56E4E58BE2CBDDDDEE8E5E2B90A2A9
      58E8A113A8DAAD0C232D96BF24282B07EBA44CE0695AFA78D84A70FC593B83E8
      B5A6725B622EEFFF82C0C4E9DEF94554CD876E661DEA1B181F1AA7E473E9F642
      87D22AAE3906ABA892CB15CEC30D02AE12B750953B637CCC73A9D7059C05D3C3
      35841B3411FB06F4DE348F72E674EE70FC674921856E498D72C20C28CD91CCCC
      568973D3A612BF5FABC0614E5DDDCCB02AE806E53BFDE9EE6B499BD5034B5641
      7833C6EAA2311B96E125AB5C73F4E331323A35230CFC172B5F90449DBDF1581F
      10C60AEFC81A59D628273C69B74BA26D254A0C569DD2A5E2ABE52195F89CEDE0
      F2B3EC4179F4DB3CA95C815FF72A34BD367B99D5161309153EDE61ABDEC8A2E1
      E267C2A6557620EDD82EE646BC8A68BBFC90BF934844EEB3C9EB22EA1FFF9C17
      D77FBF8AEBE3E94191E69783E83DA8405A01D3159C684866E394D25097AA1469
      E25ACEBC3567B28D8B08C50AA26B3C817F41B552B672D782C1821ACAB2A22B56
      15BCB6E436320FCDD49256A31C7EF1F10817D52E85F87C4A7640E0C1E9BC1A39
      3947191AB708962224E157A22E5725328B162FD89D8E5BB3CCF9B615450602DE
      743553BEBD229776A6F11D98D21F74E3D023A265AB7FBC676F906FF42C4051D4
      20D4006F344531CD89F74AB0DEF819B92412DBD162AB52CF03699E7EEF66094E
      47C501D569C893447188A13F1CB194496C1A8BC6BD496F86D237294BCFE29A97
      E0BEDAB23BFA69A308A821DB5B2831892716CABE021C5ECDB6D040FE2DBF3430
      BE4502DA40EE00D93FE6770A9A70787E4A1538D957BEEC8AE45E78D934419779
      900650C1BD4A83BFA745FA219944BFBC3FF9F70FAF76F97F4F9E7FC6801BF4E0
      33B7BC6CE7B795A111FFD8AE666ED98359869B88EF92C7E375C2265C0E441008
      16142D48F8530583380B94306531F985B8AE765228CE111AAD7509DF09DDFA60
      97D418A2336D0782B3BAD4825E31F66FADBB83B1A05849651B669D9BBFECA741
      E44F771D617489C3369854EAA80A819BF2C1D36142203130B9926F6B9240172C
      FC4655A4715CC776CD87D57393B07E401CFDFA5F6FE2698284915FFF7BE0DFCA
      5214F97AC36445A7568CEF453ADB7840F95D4594DAE54C960E6CCDC3194EB529
      15999D368DD1D96203EFD135EC0F575370B3CC081A99DCF3781ABE0C09616180
      2C4EDEDDC7C83845FB2EBDA7C8979D282B3D2D492DBA9D39A7499E6CCACC33C6
      58AD522DF8C5923C689F39C84551EF5612D26ACF4FE93CDFEDB71AF66518E47C
      D0B69EB17E085ADF7CDC7EF99494379FA325185EB51DD1A9D93FCFA2592986DE
      FF0DED63D97A11A3BEA24C4162D5725DCC26C2E8E82A5267033A479A3842146D
      69A8C90B1C4115827C0898F3303EC9F3563EDF53A79DEAAB6619FE68880952A1
      75CFAF7C61C46997BEB4C57288070B96B4F88261CD15B2901B32F581D6B7835A
      42726B23AB2F40E94CF82F9D8804625A89FA61834DB6D36B60F374FDA802E6B8
      160D3A9051BCECC86E553409A43E2CE54AD45BADDF56BC8610ABA8C66944B1AA
      E37A5E6DBCD06585FF029ACD6781BCFFF0F54D47C3ADEB40A6D8AA88053A03A1
      C6E9829C6B58CA6369B06991E76CD5252C08B7A0A790430D9F5BE4632E720AFC
      2F533072668386633B6AF3775C88D5FBF51D4FE8444F2DA4705BDB83F5238777
      B1D15BB241E84BCB9EEE451F0F3EF4CC2339BE38ED4455F2DB9C883E4D9B99D8
      5BCF44BBBF7D7A2815C579FA3255C0DA10D215F8ADA94CD6797D767EFEF8E4EC
      ECC20552A20F09B0D7463C65E54BCADA14B74A02274D8EFABCCC71C94CA2CE39
      653F23898A541DBA8249EED009D234E0D13BD2BCB36B8E2F4EDB056B4575992A
      579DE308AE7C045F3E3A7E348DE8CE6B18078D189E63A493E83A2E2994B80656
      46380CA32E58B4C408E558B7C13A88AF51C6A71C93CDC75C1B77A356C51CA20A
      699903A0CAC6CCC896B43FE7C56926B89D3C1AA6C306C8415F8BD2AA9ABBC2F2
      26961E80F8CF064F074F34F1DB219A4BA8F10B88CB24FD665E50354F0C5151AF
      00DE9EA9FA04F70F228A61F688233969A0DDA8505E5E6AF1DC32A5A1A224D2C4
      D089A34699E76A1A6CB2A6C9C50E38A8124C073D9E28916E21D45BD4A07A9349
      B0BE8C42330A1CF65C56B583086765319E8F084AA6131E2992A9C4DBC023E698
      B8699CC39F9E26F55531C6E5E494AE5DA45D8F3E8C6CF0E7806BFEF140CA1528
      B4777C717A0766184ACA3CCA1F1D80F5C4BA8A45C3C9DB982D76BC8420669185
      7684E756E3B2D13A80D630A140B5B028F3DD38BF00DAB03219D8036699D2D8CF
      1967D97C304EA172804BBEAC47B897A140FD6FF3E92CBA285C79E68D47C4148C
      44F87B197F4EDF48A7926A5EAE35CB8BBCAB9FFA2EFE8ADA6457D04E76B0E05D
      8BB7F4109A8A795D276357A30DFF04C70BEC2E756702A330F90D0BD9B28D4DEF
      32CC9475CFD4933B4CF970EE53AEFDF7554FE434D6A6918AC478D038F9E6430F
      428FA49AA4EEB741D4FD6071A2850B45CE0FDC3808C44E26831DA47AA29DFD9F
      891171B9C5C394D1A5EA6A3E99B0E44F2CAA97726E047A27AD748D56675B5572
      CB84141E9CEE2A3C1DC40C1A3FB75AA5CA0DBACC59D187D1A934079F4410F63C
      B809DFED7D3A955B908BC75B78229BDB8B2E01C510971ECF5D55406F6ECECB09
      2E1F24040AED866AAC772EFED393128F658ADA0AC504B1AB3A1DE908E92AE0F5
      45543EAC578A6F26DFA2515194E33427AF3438D3836F68A5C9553DFBB01803F4
      E8806E0F01E619318ACBB100798D183357BE2DCA3591A2E5F16CF1B8ED14B868
      6E020E0967AD3B2C6A1023751FB4364B435E3AD888C180CA56DD4193FFC429E2
      02788E70A6DF0B22353D11352373886FAA6CD63B609286BE5CCD6BB266D59FE0
      8B947388C66F00B33A3DD640A8D49121259CE95284F10BA48A7856067BD00B3E
      446C509E178AA5B5E8ED48B72AD3CB2BA019650EABDA5DE0AEF30A64C8735D66
      B1B6D7C039554E46ABDE27D1D9CFB0DAEB36A902228AEBC936B988374457E0D4
      E7AE708BE5DF68D03A18F5DE8A8E8A82959B8D253612AEE1349FDF29EAE45206
      EB0231A20D3221C3AFFB2809869B35D500C6854A4E6F8F2F4E0F2B83A4F54366
      8F1F1F446F8F2FE1305FC0A0D2C0DFA11CC23BD13081DAD4BA8DEAE6DA8A46A8
      6FC1303F1342BA3CB6E35159545022A896E8F9AC1E2011E61C27591D8B14B4D8
      7EEB866B2FEA04BFA183E5C44614A39555A0C93F0D42180F38DB39C3A4BE2697
      F1BAF0F40128BD8B5DB4896BCA23ADA79527837AB4F0944A49C1EA9C26E0CD13
      5E55DF78006A16C29912396A371FFAFD81ADEC5FBAB7A03DBBD886B153250BAC
      74666238DE8E4725A8A569FD37359B5A52E3F8CBD37CBCFCCBABA14C5F5438EC
      84304902616B79ADD68E3031D2906F060721E8861B372128D954AC5C687EA3C5
      D597A0104B52B65F90665830316D852B319A8CC61A34B6D14EE37C32468A40C3
      ECC6D1161A5D71F3C58084ECC35EB00C828C790224525A6FCE3BD1291375FF1A
      1D72039F8FCA02A9C5A2CC41950EFF2DEE1614457C938CBE20F452CB4294FB3F
      783DE8F3AEF50B47C58CC093D48FB6F7F55270C12B7098C5DD8BAB25AB801C0B
      1A2E2EBFD2B48C9ACBA105A081A163A2808885DA379D5EAD74D1093B07FA8BAA
      2CDA68DC283AA983BEBAAD97280D973DBE38F5651976FCA98345735D344B3931
      E156845F9D0FBEE95AE24833A02D167A6393E176B8CB9178B5782E6DB8CDC5CA
      4313D3A96439B09985B3A7524627465C0D714970556CC84E8B3571A713679BB5
      EFD0F0B20A06574B206D747FB52983819E1D24C491B95BC73909DF7A74B75E51
      92021A5A58CDDB457E0A1448AE69670D69786E75F616089E95683D731A4F8BF1
      1E07F4B418BF56E05DD449EAF7E8D2DEEB817CE7B2A85D0010DFC213AEF12624
      375E024B0422842840F86B2751B849EFF4DC6D8E49B8C0B061B93583ED280A3B
      7B7AC39589442D657D9834FF2BFDCA019E2B3D2355FD75AFF5AE9B39235A4120
      F4492E71CCB2905B63BFA479D8A64B4134FED78AFDD5604EEB7965E3DF7A7543
      6413EA8CF487377D1731E609272976A2A124E32403D8FADCEE28FF796B1DFC1D
      BE3653D5358288A5D73E07DC826A8C350F51E5B8A8300C9028B8A978204FAE70
      A0E0E56D3C31ABEFEB50AADDF1E7E7259D02A67F6B5A35E0132676C8B989BF74
      356DBE98D71C515D54EDD3666749E51C52DD5C6D7B078AE2B1EB8F6444007C3E
      E4BC4A26F38C357B626C7D8935BAB08868D906CF574CC4F43F4DC6A9F1AE6AFD
      7B3435500935E69C19455A9390BCBCE232210008160867DE2EB0D6D339946E20
      B51651383E7ABE0B8CC5D41D7DB48F9735072DEA9EC68EFD27CE9915840D0C70
      3D46C304751F260D4E922A09DEDD5595312E979A66562268B079296C339E26AC
      B6E6E9F40137D69B4C2BA525F1204BF5718FC1931B8F088B99F68018A65FE38C
      119782C3B6491392CAD4B6E4DA45B3A13D8C65E00241560AC13187AA792A58A2
      11B520ADFCA5B12D9BB504F038B7C8429166B5591998D978E85F131C20E8C7D2
      146F936CD68BDE25DFE6D569811CE83769FD763EEC213889C39612BDEFE3BA4C
      E0FEC797AB7524ECE9B7E51EB6A00F77EB2372739DE66344B9A563DB49EEE26D
      205EEED53739CC4B58369B3ED18D8CAA4EFBFFC660F8A7A3EA14302D576838AE
      790948C01E913EAF37E2C8FE56142AAEB6EB9CCC55D4973BC795A660CD1E8115
      6A442CC710F729664CC90E2E45EBB707F824962831B72DBBA4CB46474BDED93E
      AB92F22B4EC50F499CF5799C8D98ED481B9A07937C5FD2FC703B6ACF41088E0E
      41EB40A805E65F9221E967BB2EDA6AEE4787D994A854B9F7F151D558E5C1B241
      B5A4D24E17C999A98A6CCE628400D62443DFC78A8BFC12F1DD68326789C170F0
      6DD037DFAEAAEE4886C6C64293B22C36CC2D6886C38DFE6B79774B1DF77C8316
      5CB66F18F1F0B756E7800C5FDF882E65B1DD8C38BB360BCFCCF94625A95E5B43
      A5A901ED2554B44DC54B4D83EA2E35CDF42CF83D877AA346EE3ADAFE14FB4307
      DC37BB7ACC17DA756727B014B897D3342FFC30759928FE7CB03BF8D68B9E0F9E
      E27F0683012C4EADBE5439A291598402CDF114EA9AA07E6A86BA4AF8E8BB3A7E
      945BF9826DB3F07090782B0CF6D634B88413CD04BD03946B0752994C11782C1B
      83BC1ACA6D6B08B9C4D0ABF4F22AE3158C3E590B321DEB66813C069938CA66A5
      D442D2F1644B8A34B88507294C114372C837DD5C25D1B2F0A0AC7B265DAFCF5C
      067D86565289D583FA3D79513A9E7D2BFFD78AB6B9EEA5013A3CCB10B7E204D9
      28E07916BC1A178802F2CF7ED5C25A4FCA699CCBF5DD7EFECAEE6BF28E45AEED
      42F11A72C14531888EE4F29005481C430D4FA48254AAF4037BD3F537992550AF
      91B526727E88B4E8B5E540AF692139784091E6795ADFDC85064C8AC3753A46DD
      76506ED74DD7E22FA2AE6C308E1BB43597E96A2E884E9A31694572D729EB6799
      36AD96688CF3229DCEA7DA9562125DC599E2CF1A83D53F35C89EBA655737E664
      342DB55A490ADB59B0E7D61DA90864A458CB6AB36AE79BF4BA39FCAE30955AA9
      4EFD83E88A24B38BB0AD2466D2C9F7DE9F402F5BBDD251CAD47B3509EB145593
      952ED30D69DD3B3ED9ABF97A16FA819BE06A87D0FD07F74336A256731B47F194
      D2D97EEC2C1D910D562924C116089C36284AFB505784702B7EB1FD7B5F606DCB
      8BBBA527D4074F765EDE15028622FAC10DE2BD0627F69147D5A84C92BCF1866C
      4616A103221B2D08E398318A85C8EB5D5EED7C0A04B10F046A08CA847A15EEAD
      C9C990A91FFCEE03A0B713AB69FB86825540B59744C9DDA32C95920941871A3A
      C7F9C24F3526BF6AF552CDBC2C78AA23A10CD0C65539CFBFA0AAAB5370B187E2
      DD824C9A555D7AB8F95D996984AEE48567E590F9C792CD6571BDF6ACEFACF97D
      FB929632AAE3C7CE786A0816AC1622DE80CAC0A8F17647F0316A174A7178D1B8
      F5F20D9257364E2B8A3480218E182E34789526E034B970E0098B1E6FF03AC9D3
      CBDCFFB540C015863EA6F13E35D458650FBBC668EEB7F6D55075498D97AACEDA
      F99D5E304FEC92FC564BA8297163EB0E2EA8B807998D1B8EDFA949DAC1C00ED7
      D8DA815C9FF9494B31C9624D4465E60FF3911AFBC8C52DEE98F7D4509447ED8B
      B09D4FAE9D6509513E87C4987AC31B5AD4D32A19756E5396D7B9FB7E773D80AE
      BC733913D91711FDA2614FE68F4821210D78C94848A47EB1DFE28D0D6FA22B15
      50E69E96229A41D5CD2FC90D057639F64ECD433C2EDDF4D22783F09D8D134F99
      4B872FA50BD8672B92A74AD3D0682EA25D33D9E5959D2E04A126548D338E5253
      97C094BBECBC756290B6DB646C1891E5D06C937CBC97E18488F1FFA5AC7559C6
      378E7BBE79D582750F5A59910042A39B1EAE3D88C72AE08E262A9DF8FD221715
      836AC797A6406FD65AEDE9654E988C807E6D4202FF6BE58F0412F8168369DB73
      994D0C8C703C804DE82CF1880993A2504D990502B4DADBCA34A3BD287A1D45AF
      57A2DF51B41F457B2B63B7ABFEA855486C186C984315107479D30EAFE9EABAB7
      59FD1ED1EA57013B575605EDA9B414E64CD73890A119F5D74672A72E1AFA6D5D
      595F3B3833BABA867634A4A0A6BAAC6EAAF373299244BB6CB1ADD8849AB1886D
      CD13E7628373FD2C942D8D87BD4063AE6149A2FA95E5B20F638DDB9978E306EE
      E531326B9648240D6FA4825E9C8F1FA3DF081AAFAFD3182416D26CF802F19A40
      33D2C4DE34C741D205312E12ED6E040B645A71B3E30AA1990E235FE45EE8B015
      C5DAD466191ED859EE2E669F78655CA5D9B84CF25E849787808E44DFA5494800
      E9C7B809E425A8DC112469AC23645E14A6A94951390F5C7D496E24D3795E6D69
      4522B7F81D96E3FFE500DA7CE91420CD6BBBC7D6D9779FEC899CF57B3FD2C9E9
      82BEFDCAF5B4FF932DAEFE4FBEB1FE4F4DA9DEAD5A0C2A6ABF129BC31ABDE5BD
      D0BBDB9BDD40A5460B80C82C93F7AB04B7C653579FA704894FB1CB3FCE1EA3EF
      51171ECA0E4A84936B6F35C3F58FB6860826BB05461790D248F00FEBF8262C76
      8A8EEA4DBD41B528E8E5B82E6881F0DB5B45F50E916554984DCE516B6E790C21
      0822987D71C44786D5255D829C8E6767997AB9D49DD5BC44B5EFD40077D47DE6
      588C43D391B9D262858A7F8877B697DD6088A8AABD6E20F0A5D9AD23BF1E11AD
      00CC52340C69ED593C4CA4B0CC8A15BB7836073FEDFAF884DD894B55B225A844
      BCA499CD625081F06D1C6E6229461C8BBBF26BCA244BBE82C906864D00F9B48D
      963C580FD281FA66A65451EC7001AAA99DEF685444AA21E22851E0BBCF83EA22
      43BB9055BB713E22C74093169583EA24E624ADA1F3CB4192CC3E8BBC45A02DF0
      18D634E815EB18F334868384C878E191DDC63355F5D43DDB17CF118E638B020B
      1BD8E1FB0D959438A8D9C3045835BD556C5561A538FAFB8793035A44D187C3A3
      0FFE737C6BC79224BD6072600130B158336971472F8C2597E7E06E0A8216FED6
      008D00AD721E982A8C1C0CD5B21683CC5E99E5D5E961B85544C4D6B287B95DCC
      C333401DF13070245C0F0C5C34CA8AD4889752336E9341704B050376545E6859
      9756A57CFAC40279D01A33C502399D69FB879E6B1F67697D1375453DD3E473E8
      554BC684854B31C76541AEDCFECF3BA4BF61792E53546706233663327EB5790A
      CA71FE4F28E52185A60ABBBA6E43ADFCE1FF6BEE5B9BDB46922DBF6FC4FE871A
      EEC69A9AA628CB56BBDDEA3B33A1A75BB7F51A51B6FB6E77C704488212C624C0
      0640CB9A98FDEF1BE76466A140510F039A1BD31F3A2C89040A85AAAC7C9C3CC7
      3DAE58A6182DF8820F105F69841190A92BFD94668C2157B4A4872752CF995F3D
      3CAD30D4605D76FFE4D75048C88170D4B31ED659AC04B64F2798C83FD5DA0557
      10BA105983D1A1CDF37892DC113F5C0A493497803ECDE5A8011A8CA6BF0E148E
      1CBF433CC2D1BE1C38303715D79DDA6918FC501A5B2534CC84AAE2C86A09B015
      470A932CB8916722BC8DCBAA2FBB9AF51AC7A31051108357592B151C2DE38791
      A21F854A615BE29F9A86F6E9D9A5293E8192A6C6A4A4F1D04CC16A5554A4EF43
      7E4A8C6A0D2D9B5FD1A2A5A7C468E9E0715D81427D8E73A50FA8CE8A07B7CDDD
      EF75AAEEDE30D165DD2FC2347CEF38FC01F52412DDD3A02D084463B549C6CBB6
      81619EABEE92302BE341AEB5E955E3FB1458C2CA29F81CA1F554185F49182E95
      9DBB63A8DD4E1B69943B7C35E73653C6234E558DF7B762D5B6914022916BCF74
      E180B1BE4AAC9764749D25D2F8DCF92FF043480FB0D2C09C66FE174F9903F57D
      AA0AC0DD561B9B82950F15C2441E793A3D92E9DE18D3456D0699CCD7AFDD1D06
      133AF8FCC32F2214CB636CF404875FCC32F177CB87488F5DB935770DEBFFABB6
      E12AD544A520093AE5244FB1A4223D09BD0653149127D5D7527D4189F274D34C
      A7CB13A5A25E15A18E5C4706113042DD9D7A9B4AA9A97F508F604F3D027170EA
      FE4436013D0166919E47A41458E1CCFA9ADE6C01C8E957A4DEA4B7488F7CB4DB
      62C11F0C8E3B4F278F07C95E71E7E0E62BF407DC9FDDFF3E3C3C94BE9D12CA80
      1299562E0045AE48B41E1C8BFFF1277E8D0CDD340A9308AA63216CBECC3007E9
      6D4DF84257F1137ABAFE2D4FA70BE3DBF6EF24CF668F375B6B4149C5AF2B9146
      7BAAE23A022B063681F72A8310F261DF8FF6F0BEB5F2EF39C50FD3ED56127A91
      885B60E7B2DBD9BB94E4DE2005B9699E84D64BECB2BCA9AFAAF3BF23D7BD90C7
      06429C98CCB3D39D139F1D7BE869D60F932FE7B01D4509F6AF8DF5D3ACFE1BBC
      AF75C9ABE3A2F201FB29BCAD31BA08033F01208197EF190398E3C09CCFA40D5B
      71D16CC69A1D0C4E92C9D701D9A6D15C7CE35363C9B54CFEC39E4E40A96B5F50
      2A01C2CC7E59FFCD15B7B36136AD74520240E2486E2C16E711610219A2B0E5C7
      5FE64A2DEFEBFC12E30434F8729E5AE685968EB474DA3E2755546A54D9794EBB
      061D4EF14910E566F9554619EA5A511AF7455EDF8308757D92E03BE36AA47C08
      6C7FDE775D71F535CF634C3A2A09C7530A6676ECC58A94F2B9CA0B1927A4FCC1
      BE690060967E924079C5F37CC90597FB9056E46C2CBB6881B024180968F5841D
      EB24EC98E499569A555C4B192FEC45DACB9136F2E5D7C1CC57C503B34C296332
      79E1CBC231349D56CCD9FC287845FC55E04EC2329112CCD21AC8696A6837BEF3
      F2ACA36B19CDF71456993088F49A687C2E9B83A0B75BD669C090E61724DB88EA
      DF970F875FF7B3BAE202ECABB43BE8B6D0CFCBBEE035BB41EA585FAE42B91555
      28D802CCF08A7BF8C9E6B504FD2772C9C2085FBB863DC7C37358E7F4F72B4C93
      9FBFACFFD6D3CA55D87F59CDACDFFB92151F8B70E2F265C671410A4BD52FD7EC
      EF4B09EBC3522B735592632856C2723434472A5BE14246EA476866787FB7AA94
      1B882E69F51EC3AEB7CB0ABD5876F31540F8532479C42D7372F6065CEB8F02D3
      EADFEEF86D7757A9C44AB515682A4187DC97C72111260A8186AA80DC5456CF5F
      B8ABEB5C98310D9AA6392C09597B44FC41050FBE719B5F53CCAE1E478F351A84
      2A35661CA18FCD9C3FE13CFCC0F3D086773186B120240AD270C51D65AC7B2443
      EEA35717704D0D7554E91A130FA17D98B53169E6CD42A4CC6C13E946ABE1511A
      947260CB57C09FBF5A0C63EC26713CE661A81932EE369F217B1045B9BFF21B68
      2A49C4A255FA69A13E52C833DFD3A229F537D801C3400429335077856A61EAB1
      744497E8177FC3DF546853BEE2B11669A6C519FB8B3F7EA719434C1559368566
      6B9397A1D5A8A1409E1372E3EBB250D0F5285AD24C0849D29E54B4226A537AF0
      34C0339E12D8FDE5E98503145009645684D4AD89B8AEB82DCA788654E5D317C4
      3AF63BD3A9E8B4E052454BAAF77C1FDB7BD5F70381174BA8F96D784710C5B24C
      E95819D68CB1DBD37B13878CE855CC7C2DD91C905BD339E481547C02FBBCDE8D
      AA85C1FDE8BAACA0D0AE48C2BDD4E1574428D12C3E068FE10648FD50BBC14F0F
      83B3820F5A82022BF2706B706056DD944B1FCFA581DD5F931C45ADDF9A1C834A
      36682D69D658A6199DAA575F7F810E6041A6557F0F45DBAC3F6AC9D93281EB6A
      361E064877CEA3F2BA438C91697D56CC0A5600C30E7B5CBDCD6E0D625BA94B9A
      DD5961CD4D5D2E49F549EF6D780C0A2EFE640924859F2A3057CFFED4FAA9050A
      EDE3472E00BC31940F249267078C76A48B3D13BA45ABC8B0EDEA11DA656E4D7C
      8D5C9BD5F65C0656C2814615332E82DDECDB6E96BA1EEEBCED24AD78C195B85A
      19A2D1E625AF75371A7D42F6918230945AFBDA2CC05DC1BA1A81ABB2717F79B8
      D56B4725CC2B3ED0D5D708ECACE95F04D164C897695C9815A7035FD363BE3633
      7142FF11AA5E7A7123D1F10AB254901634C66EE52F550FDC103AC1DF51788602
      52FAC81EDA9164463272B31803488A59B5368282AAC67A70AB14A59C4DBCC65B
      E82FAF9A22E86C790A0A4F1A72D7C914A2A4D447D1CB218EAED515808F8A8589
      78E70AD3A1F54A3F540DA884E15A5DDE9755A9AFA2B823214EA2543BCDA7D06F
      6099BC4E1E035C9E7C8E3B2BE6491F8D004C7CBC701F4E76F6411F3A0739ACD0
      4B71323A036AFF75E05C7576082BCD26CE7E299AAACC020AD3557894B28FF549
      D7E951EA3A73513E4CCA1C754CE359058611E4A8F000E1432383F2486D7335EF
      2BE4FDBA78C83530D12573DD81C11387AEF4FB236580DD91BE5042E1859B1BB0
      A8872BCECBE583A37492F9182A1695A53AAD2DEB22D76C3329DCEDEDEDEDFA6C
      B63E1EBBF7459C6FBB2FEE0804CBDBEE169307815ED7C509349DBA975F112EBE
      E741896328CB8FF6099A9D4657CAD22FA4A4A9D4371EB127CBFCC21B8767DFBD
      7107FB4797F69441810576A78282E9891F55AD2AF33CC9722DA88CE65EBCE8E1
      A3CE277A249D58676CE61D49EBC3C3155AAD354AB6D07245FAE53E385AEEF00A
      A9C498CD58A03C4263E8C9B62D0904916D32A1FAA793B88F2D531D5F48B328CC
      3EF570A65EB9B0433A1D2A78157E605E19C6A63B498309AF312DF9B9599E19C6
      014CB4577793D63C158459A65CE2B7D810229E4D258FC0D1D512A20C3E8E2E4F
      BE0A7BCEE39D1CDBE2C24765BCC13BA368127D8E1FC3D92B61B4B7CB218BD23D
      574E0AF7B7342BFF1664A665070700902E56BF04D9C8EBAED505496D0E6A8092
      AAE8F3F8533D7D8AD432A10E09741B155B2FCE60DFCA8C103771C92B2FB50BB4
      5BCFEDECFD78215170CF1DEF9CEEF7DCF9BB0BFD30A9AF419F862BA20FDD6C61
      46586D77ADA6175A881D5D7B8210C1FBA3FBD4076097EB0F804B830AD43F48E0
      E22B44035F7A54A174A726051ECA804BCF14ABDE529961C71C0AA0190F9F6FDC
      979EBB7DB46DA05635ABC0A9451CE5C8A6B083AA7AF9F290A8AA0BB7511D5722
      BB53B535B94E905D30588F90F4D18F97A443FDAAEAE64CE8F28A1B2DBD4F691C
      B0C43EF1D06474BBFC86562E14CF3BA80BA67E803E4A538F6BCA19FCEE62DF75
      9982A2E685D1E1F179D5B0D6FB38E7712E68CD5E6595EE99F65A516619D0134C
      31B94B022F146C6999DCA57842EF97BA090F6D37A9A557AB8C85D544EF81EDE1
      C95330FD1A7578D791EB03D2069A668F4A7EEFE931A1C01628235664413828B9
      443A44E10BF41328FB5E3872BF92A1C9EA0D4A50C0454221719B2329C9D82B78
      7C961F9C5E90EF896CB372F1944578774504FBA955EEC95E6805E810F93FF0AA
      619B59A8CEAA40D9AA74AD9D4E6845C25E559247F994B0BBF17DC94BE13B90E8
      2F5CACC3058578403C189EDA7ECC3CB9AB1554CDC63891541E2567E4E8B53FD9
      DA51E1E9EADB6290B8C97CAEDAD0670137A7B0BBD80C611F31918B8FC89A8404
      AFB4807A1A50DDBB869312B4001BA4B46EC227C61760A6F0173450B1E65D7A52
      EBFAE2F80A4777C7C2BDAAA51861C48A9E5C2A2321C920852891395F2001A03E
      E56367C0BD8A8D582E70D2F1401318D36952B04BAF168AEA4AA510F884F97638
      AD778721A6C333A457DD9C463829C245448557C53F9128D2C220D7115BC456E5
      F0EF525A05803983B54542650DC0A45A5041805543138E3F763780488C3BAEF2
      C0AA2B6AA3492D4B6515BDAAB393F9DCC59CF5610AADF45D7757101F5403ABA1
      F4031841F5E0622765E72B56A40EDCBB01C3C2FCE1DAB874004996AE9E0B4833
      E8A8A8155D66208D56AE42FC45CEECCA3285668D03C6A3E1184A327436D0B068
      A1F7AE35A8652197287FAB36CC7B0A4CA169D339B62C3AB38E7669E12A237C1A
      2B402C87C003D09718E429ED1B4FA86E7D8D7A8388EB79D527956A5A95F07D0A
      6085F54FBB64E8D13EF1DA5605BE26E69DC4D1D2A4A69798831960188F229C12
      2037CD6631B5FFFC072B792DDD93B24697A13DB532B6B5C968889D7C51904075
      9433E3F2F4593D3EDB7F57517F3F98D18872F6AC18F1D6DD8CA55E0B19592231
      A08603859E2CFDC393C7432DD8C93493CD32CFC04D267497D02FA26E4CA65A2C
      0F1AE613A9C5299A8CA246E6FCEB0B326D1B1C8A22C3B2745BCD3376BD89803F
      781A9DD676964F5AAB620B27628C6EAB4A23D2EA82C18D4511E0E114D2038F70
      53D3A4C946C8F25959B53E53C8A8E88F5543C6135A8F91BCFB945235FDEECBB8
      FB2ABC2082512EEFC21216E348B208AC4A0BD87B0298A26567212128DFAF54DA
      CD1279411CD011C391B84A092062AE9366DCE751910792044B94DE96EC7246C9
      1C9F19E6D927B199C2B41715642D95AD85078469450B058EC4AF107EFF9889D0
      221114272257B3513576E96FB0BE2EDEA71511E3CE34619ACDFDF5FDE072EDB1
      E86829B3BC5409A32A86C72D31C14A5ABB611894716DD8CD8F0797EE4F41ED44
      46F3B9C09FF606EE4FC4D669F932FCDB31FE769C69BE827F59BB27942F6E9265
      CEFD6A8C460357C5F2E1F4492AB63E81F68D7BBA9AF03B9DDFAFEE8C544D6649
      04B3B26F60FF27CAF4ED183B02DBB09772F015E781045621654D361B66C3EC8B
      096A0617E14E9F26B3A45C56B0D3ABD877F96AD3FBB90984172C4A6F75E51824
      1768DCC723D95AE0E14F7119020B9F61A24247760773D8BBA79782AA37768D7A
      110AF68D021DD242E9BA03DBFCE3A418453926D6BE5295AA1EB6A2CB7266A4E7
      0415E77FC783848F205D0B9946833EDCD3BB868FA32F41A5C30CA12152635EA5
      59709DFA6DD6DA2D03858C8FEACE3E490698775321B3C8AEE8412A94230E2336
      504D30FC5B687F88A5D6E806A8695EEE7E59A1E5FA9013C031D08C3F712F5279
      6A0C56A29DF15870D0479393842A73DD28462A79DB1DDD0CF18F1F5C54C847F0
      1376C436C2AD24BDFAC145832C2FE58FC5B6DBCD32CAC8FEC95DA251FF075A3B
      6DAA305E8E68EA86FAB1AADE7DB7C9DF8B468038A00A0B0C0A08C52C6B7F61B3
      8E2493BEF2918B158FEA1FE672C0672CD67EC01724703778BDDD1B9548FD02C3
      4D5E8D14823650C297C51965D2425A911D42597C2398BE5A0775FF694FB21B5F
      25A900D8BB918211F930FAEFB51F4CA14CBF70908E1FFEF812CCDCF4A4359443
      F066797895201E2E86A44E613552296B020688EBC515D8CD8B39826EEC0053F1
      D8904DC9C42E6BFEC6F2F358CA351CE1D3E88B3E470F62A4AA7226E762CFDAD6
      7F78E84B43CCFC431FD8D8E8F71F7C94F0DD5543587BF0AEE5C309BF8D0DC9F2
      47A93DD4AD3F17CB2C78D0872EA28AE90F7DA45A454F1D789C8E5BFDBD5AC137
      43699B39801FBC073AEDE36CF469799DDFFDD4FB74CACFDD43ECACBD389E9F5B
      3C40537A0E13E01509984FD268BBA457190216044A26C2E59B0B3CE826619551
      700BA12424DC69B4835590ACF9236734D2CB1F21B43E007D6DCFBD4072E197F3
      DF5EF4C4F0E29EAB3FB3D9FBB6FAD4D25460E9442C5BE5B1E9F5D8B1BB766FDD
      27107C978206525B1FFD2F1F7C0E353B28060A4F0F5EA2FEF2344229567E2D25
      16966B21452868AC690416A794887AB66B8A67C174742D49866280F6733CF944
      DD5D5C35C02A89E80500F68BAB30E067DEC1BA598003C43192A4080BD14929DA
      62E9EDCAAF99876039237AF1760D24BD1434B8948F7B2A7FD2FFFAF6BB2DB70E
      6F68F4893955E02D54798673ADA42CE5375536AAE98DDEB8755334C65B62104B
      3101C99556482986EBA657253012D2EA34BDF1776EDDED538F71C56D9FFB66DF
      BB75A361D7796409649EA30D992E858BD351C6043350F5C010CD2B444D54B8F7
      9787EB6F459C607D34DF5E9493F5B71E60D570586F5F43A4649C548189A602A2
      1CC485C80BB314A27EB2D0775B829CBE79D31B6379B16358591EC0B246CF81E5
      A07836072600A845A4353C4D5F95FE43F2AF20B3881D65E4FC0C521E9B4D87F6
      ED9D57E5A574556A294B0117B1D439E50A2BC22734C8C43923C92229172B60F9
      5F31166C0E4F155705BF09D66636E72363CB17B5DDD9F466D810FE5D0FA15937
      41739A5D5AC4B4D0C6A7B9D7A6F7798B776FC3276C4FA957479E0A249B656330
      8C543BE0391E109BB0366F2F0A779DE5C93F70444FB5110400E711CE75246979
      780CB3B2CC66548EC462BB6D78FBEF5FBA75DA4CA5AAC51C1232198639E358F6
      215D696D7A4A26D474841C3770094D6F8F2DD741FE09ADB98A3F0F93F685A6F9
      1A5DBFEB4F3986F6D4635AC311A2118FC546F02EA406629B6494E4A3C50C3593
      11D3FA06E6D48CB2B1BE8B6BF4AC6393E87083AB19FF583556CAB24A83599283
      52C6752A37A61332D3890BD7F5E9541DBF32D150F9B7D961DC15340A998C55AD
      0AA33F8ED2AB0512E28159D006BB1BE481B389EBCBC9226A758C4BFBC322DAE8
      0FA3570E100FB0843CE790DE5F1EBEAD8E31F863535D6E633DE40AC516446E12
      61AB8D3E0500DC64E23F255DDBAC1E24635EF739C799C713E79B9ED878C82CF7
      2C9E654253761F94A2E57DD519D5126FF5DE28D384753E8F59C644F2CC7A9491
      87A2D591CE641178433CA2F55D01BB4A596591EA5F9E75D029F1996CBB0F52A9
      55797C23288DDFCE15831B5236CAEEB182DF12378394A5BCD12347D58D55D21A
      7AAF6F5EC2D45E70D74B3E2E5D4CA7A61B3A9F7BA23271D29FD5A8F8AC6FC0F9
      E561E3661B581946FD573FB448CB64AA392BCB21127148377E3985D57688BF1C
      9E6DFDE60E419490A4EEDDF1D92E25EFF2EC99EFF390C5646BF15D0097005860
      783945665585C451155FEF4E30A18D2D0464EE7B00E674A5CCB2F738874F8F84
      4A65062A8E4EF5AE7D6C7A3F67CEB30E5A688A82511358424CA82F31496752E5
      9EAED58BF268590493764EE156B4BB40FDDC0DA7D152975CDBB1325C47A1D74F
      54923A56A29EF55CDA337FFC3ACBCBD102A54006B1845D4831D9BAB3A500A0BD
      8B06E6BAAD94529F735817513ACE666EE7437DE7DF04758B679DEDCBB3BDEAD8
      ABAFCF2C751F93F4BB67BD9D4C6F02465F51E9E9D424668870A8B0CCF59E6C1F
      64262972C30A11F4E235AA71F3ACC3FDF1E8F2E4A0705D352BE72444743F1EB1
      0D01380C272979D05923E02467EEBB8BF7E7C6AAABEEA266C8B3E1349E3DEF08
      EF102AF8775849051A9AD2408ACA20FCD1CFF8B38E685755007F04A641490D0A
      B7A71DD6D0DCC5A1C2307263944DA173CAD52DD669B4284A217C9935F543EF19
      97A16C28342BC9AA2FFB8B192174A957C585F7A1CC9B0123AE6FDA58419BDA3E
      1A42D347FC052D5330AD8CEA2681A61A0F3505A6C04B415D10840AD220CE705C
      80CCCF3AAC7AB64373AA04DF226A811AE2759087033B0E306E142451F74EF029
      D974992EA3ADE10E1973CE7EF2E29035F28AAA599C93575180CA73909B5233F2
      ECC561D59B354D61A67FCE01DF0CCF2693222E9157DCCBA6C51E846494BF4E40
      6C394B669552AAF5CD8B6E03F200B79CF5E71CD522154080B4E660409FA36945
      C7289B3449FDE7A86589361A2E3B62BF27C9D5C2B41A365F5DCBA574C73FE750
      839C20E4A58BD275FF847F2B98CA58228A354C9C40FD7CD7D538F65DCEB36CAC
      B489CFEB5B3163D0638196FF8057B587B235866C25DBF020E0060A52195D93E9
      E402088913A47004F950420002BCB2E523B8445EF75FF7DFFCE10F7F587B664F
      974807101CC24B5871B0D01F0F8C806CC1E07BB8BC06B8B80433A3F104702590
      98572DD1868950CD60A1A86383AB44418ABC05C16C3CFA04944E15F1AEB82DF7
      3CF814C0FC11CDA4F0F1AC7333181C78FBE8333B2A8A2A1B60759FEA66CDEBE7
      CBC360EDB35B5BCFBB343F1874B1820E9BB3F7AC3712D7CC8D6CD56713B71FDD
      2017958FFB7131D3EC70E1B624ABE2617470A1E4E0FF7D81BA12AFF0AC435BA1
      07664A6035E9D10A1188973282B6867E7C395B81AD5CA5245700665B7B048618
      928E4693A193228716F90CC324C734339292D2EBB3CF1199129A63C9F20DE36B
      9CDCFA24B43F6D0EE67BC65D75A3302F6E99EAA5E94B6A2731B54E51FD7E5617
      A1CCA7EE1BF114304606B14AB1B462C78ADEAA65B028941942D2351023FC5239
      6BF85193A24EFF156906692797CC205C849BEB18ADCE217DEC1DE4A2CE7488BE
      5C727FD869AB0C43AC77D70088CF6B12B06CD72B76E1259EDA151D0B417F53F5
      35A28995CA58C89CFCA1E147EF2536EC31ADF1275876CF5B24102019E63984F6
      F5562E7413F0330047F56C77A58E059EF9AF3126B5C47FC894E1BBDA7C9D8FC8
      08CA993CEF58C29446CFBFCAD0ADD169D02E1129C233F3C7148CF805851F68C3
      4CF0E626D24C2A690620055E0BCF827E5CCC250CAB8099D237D5F456AFB4986E
      FB91E5BC1251F8C100ADC573227F94038BCCCE48F0E609934DCF9B84CEA3E25A
      A9C4472864C8B2407555B957C4AF636546DE434FE2131AD8C8812A95DD0A1142
      0141FB89EEA7816185B909085EDF98A158844ABBC1CB8927FFF02A3441D7981C
      AC8A788864D0CF3A0D77D4728C14E39FF01C0574022583476A9248F2920790E1
      BB79E3CC1958D76048FBB4ACEA12B4CB1136E6B9E19AAE331472CF35C1A42E4C
      368EE77807651EA5C5F4EED58B212EBB846A7AA34D18E24C8B28913A19AFFBAF
      FAAFFED2688082011CFB1A0B80B1D9181E3133305F06079E06AEC5F57D07E0E5
      FE4ED53ADCE682A015946EC0AA135908BE5EF7DCE1E90739B282E137BA997677
      BDEABFEABF6C74812F6F00C65C06A13DF5DBD2AAE71629B73AF52BD8EE46638D
      4B6B5F5AA38B5780F33657C1D6542CD2EAEF7FF70ADFFFEE55F87D28C914D722
      603836A40C8C14F317AC8078E1A97EA3CB1EC2A93E189C7BFBADDDB9F1E83A35
      FE39414E327C3F182C110A3CF5F1A538F70EC5399C4D47A78767D2FEDBE86A24
      AA0A1A5D61DB349B6EC2A16E6F8F589846D7C7772B461779ED8DA61719155CCD
      6657620B59974C03ED1FEFF5DC19EB56384D83BF1C0C4E9ACD34D99738DD66B3
      CE0F2E7E6AFAD65E6F1C9E7EF84DF83C1E9A8847AE749052163A32B8AD943E51
      BCC2E1A375F240F6A0D92613106919E7398EBB1BF0EFB822BE92A818562F1B8F
      B50DB1D90DF615413DBE4DA3593272234D844E92783AB6F6572D7519F83F1205
      10309296A3EBBEFB88A30D398C729DF402B30C694B967F6A174B26EE1F719E29
      3132F11C5101FD46114210EE75658B2140D6C7FFA60225B70D58EB8D58025E33
      CE78C44D098912E39CC5679CB8BE8917693C1D13F527E2E944F30DFA692A53A5
      4BB0E7A74EE5EE6007742C9F5FF6BF6D6C50D7298E1152BD525A3092ECBA6181
      24D9F82976105F0491CB18ADF323AF5861C525E6D1995980E3265FEE0B96F63A
      42AFB25437A2E948E45A34ED73B2FFADF8A497871920D2D36488EA7FBFB5A7B2
      D9CC53F965303890FDBFC7258804DE7431F452785D181A35486B3D6C0B403C03
      7B878D62062B49DD1FFBA3D18853D5D41E910CEE37D711F24CC1800B6777D131
      D7411AA65A5A29BDD64E3905A6416A4F2D8EABC3B3ADA06DBD99F3F0E9364F66
      EEC38570E1A1B0B828B7F0B3BE8E6D2FA5529037EFC305DE7F3FFEC2668AC3B3
      ADEA171403D040451CE4F5322EBEFD9CE3F7EB936CEB731E48843434A04A83BD
      0DF3F3767D9C5C8125E73AFE1241DA0AD45A5A48D64600AAD7649F13A1FA759D
      5D1CC38A7BF7BC78D62BD211D3A6DCBD7A21EB10AC72E1C43A371A3E3336353C
      B1776B84259B3C8AC92C9946395B647BC63DC33C9B740E6BC992B9918AE89C3E
      7FBAD42AF4D471752EA88860BC2D60DC5CBEAD3196F2F74CC0CC23F46A4AABCA
      4CBA1583A3214A1B0EC5CAEDE64CAE1E8BEF031FBBDD5B21B397ACD6E780FE36
      6035D6B845E8FF6EE7CD360BF215C29FF7CFC1E060ED249A9F00B19F93599BEF
      AEFAE35F1771515E0298C73F2613A1D443B33B121004AE4BFD56A91A24A294DA
      3CBBA385D71AB30ACB2B9F6A346CED431DAFA0516D743DC42F482A81ECC928A0
      C65C9733CD3834BB2E39D9036AD3CAEBDA393FE2295935C1FCBD002B7E9A4C8A
      1E7A8EE23C89A645CF4D3324F8A6CBBD425F7FB8353FDA7E339B3A109A1D9A19
      0A6589416D73E1C1415B7BAF0787D879B7D56A500FAC2B01A392E0C3BAF8FE5D
      975ACB95B2D97FFDEFB6569EF1154BBB937966149BD25417C30CCB77CB61EFDB
      A39E208DF0E4E360A0CD704F3E92FEA526B2C9FA68684BFE1B76174371EF9586
      6FF96A2AE4FDB31871454BAFF79051AFC719CAC0051216473CE08ECFF65BDD4A
      9E03FFD767893E67C9B850F53901B6E4715CF046A49E59A0F71FAEBE7A79E84D
      50CA6E701F3137AE7B53635B539324905C88620022935EA90A9A8123BDF59269
      1A59F929DF6156FC7CF760A74DE5F4B91D07B65702DE49E6F9D9BCBC559A8166
      29597DD7B8A02DA4DDC14EBB161BBB68F0E88A5E40423D4679274271420A17D3
      281D17A3681E636135BADFE1E9075BB2E4227F2D3FB55E412F9BAD20A186687F
      BE4AA24B3B7BA671F4A9CD65029E11E46519F4EF1FED1CB7B82479C1CCF3A6D2
      46531B1A8D3FA35C1508E2B8494C75CF6699E33CBAFA3F68961469542D1C307D
      B35C8CEFD42C76A07BC79A6EB3C9C928EC61F4ADC20C59C1645BBA5AEDF3A7D5
      B54843A3C906384C54521137443EB0DD29E3A2ECCF23CC939A6B7FEA20A1C1A2
      21E2B5AD7F32683B3C7BFDCFC3D30F6BCAA9157F69F602B5DBA928B251C22CA5
      252631B63FF691109947454FFEB9A5FF9C64AFE724991FE387F4337E40730EF5
      279B4D15F36527D9D89DE55711E40272D7DD044543E95EADE1D4128EEE901058
      12ACAB5C37B73ECBF42BDBFFA1FFC01CFEB9D92A1340FF3AF168001C988E4061
      6F8ADC21CC28345E26EB67DBC1F89926119079B628E720F920388B5B076B408D
      B0390C808CCE200A23639534249A03D145E73AEB67DBFDFEAFBF9E64633FBBBF
      FE3ACBC6C5AFBF5A0E718C5C3C18498FCFF63B2D4F73D97ED1D45D2746996FBD
      FA6369D6D7C44BC3FBE01E020BC5B146168C3C9E10A275797170A0FEFDF1D9BE
      778D96051D2CFFDF024D70C789EB91DD78D9E95FFFB396A3D6FFAC624765F3D3
      57EFF9318EE659BAB193CFB27C6367365BA8645231875F515CC7F17D45D1A75D
      7FF76CFF7263F76CFF95B45D7A4412FD215FB09784B3574EC60E244B93F07CAA
      1E07B96C68F2DA0CC8CB1AEE9FEDFEE76A65E8AFBCE2C50A549148FF56E8BDBB
      89B7AFF76C5EF65F378DA7D894F2E6FBED7B888D97AA5B01A5B580E2E0E6BB68
      864FE1E361A7ADAF71172D46B6B9F5FD76A5423E8E91EC802A91184B5A6B9D5D
      6A6DA379B9D5EDDEBCDA0E30CB79E61B8345861A3215861FEA0616D2DA40B32A
      D90AC3D70C177F9D959FE2DB224C8457D96C4D8977D92D027495D018F610A7CD
      A3B1FBC6243EA9F1B26E3FA5591AF7DC1FD1C41AE765D3714DC76E709D4C005A
      C3CC5B43B0AE431C279F923981641951573A589111EE62CB2E0A94258B7201AE
      79B642F1ABD9A284EA0E9610521652AD8D8B4F50F58BF2387AA6017B2DE1B39F
      1E9C5D169D91C7079219CF64BC4677D5492BF9B636489CF80BD51AEFBDBE8D94
      15E35033BE55BD4CBEAB1C63EC1D80E7039E3B8D01B289F11121B5922E66954E
      2BA27CC29FD926D4ECFD002EFDCD9EB01CA9723B44E785E95414A4E7649BE9B9
      836224249FC2722842BF7C59CDA1289A36D2F27F5DBA8B866EBC1881DD785A18
      68056569810918091B1DA0E6487CAD6C88734E96542F683B8E67997B2198EAD5
      1F831BFFE239A38FA0BE506CE3FC17840B0B82166174F9D23EAEF5020635B79B
      6737057CE99D69F9CDE1EB66ABC13F5DC0E336CCB24FE07FD2EDA731DEB6AC9C
      CD7EFF5BF36123FFD19EC320EC6F5719894D1B16B67C92036D741E64C00EFFC4
      4AD51189BC7BEE4596BE0876C433A5ECBAC3B88CCC1BEA918CC30E189E580D8F
      18BD91C57C117C3C942C41434185F6AE20488B29302792015CEBB9B9F48BE98E
      B9450BAD95A628BA036CCA33F84B2B7667F7E3251461E099F5086BEA292D5934
      BFCD1705DF4DCFBD8BCB03C08389FEF018CAB55E95B83A8D3E9F30A50ABD78D2
      D99799FB7B96DE8CBF6B3593925AE490BA362613D2C22D10310868F3F8C3F13B
      D7BD9A66C368CA3F1D7F383E25913A417B2F28DB0AEA68A9CDEFFD24ACF36057
      91C486265DB567E1D63C0009DD8DB7E04EC2F56B9E67CB9EE7E78B77FBA01F37
      4F357322CF4320A09C0C2DD06508E5106285ED00E7C7FBAF823B26A93BDFD9FB
      892225498ABCE05A8B686EF7FC723F1067B144D1301BDF128E5E915DEE9E5F9E
      9259BBC5DD2E62100EE135927512EF8B96435A4197046EDB0075065B1B8A1ED4
      C898B7098DD6D9E1E03254BDEDF2107B3120FD8D59D517E60FC0B44D266BED63
      928609FBB8982BC64B41AC2A4AADD8F5B898B5F1F05FBFD906D0B428C1F70434
      FD041C3FCACD6A7AED6353F213DEA8FB55EDBFF6E6DF6D2B365F12FD7EA5AB50
      124516858EE5E8F2848DBBA6561E168AD298ED2BDAF5D822E3ABCA54A97B4BE5
      486EB2E2F705A2ED611E8D3EC5E5DD816934769548FBA2178BB0AA34411C45CF
      25FDB8EF7EF9DFE7493928B3F96FCD3DC4FDE1D477D4D5704C120A9AA606FD29
      72B507BD5A21A90841AB027969B68268F63C88A6A2CF4662C23B0301EBA332F7
      363B1251B4915D80B7615B008D4190DB9801952A2156796DFAED3058122FC01E
      C871A36D36D517184E5807149DDDE774217BD095547DCD257F72A728B09C6651
      1A5D410A5E7F1E9AEFC877DDD479D46358F6D6CF7BFFF7C275C1FD26C98B7F20
      96F311D55FD6EA070C8EB4F6F73C3F391AB4A92A7A8F4C9484B22174E6853C20
      9E067662DB9D9CEDEFF6DCC9D960BFE70EDFBDDBE1FF07F8FFE5A0CDADAD5FF0
      78EFF2B47658A85A4EB5D3DF0F7E3A576BDCEA6DF93DA3096E065D60A5461B5C
      426573DEDC1D89A224D677AB1B8AD10B4AED86C4A693D1FEEDBDD817E7FF85A2
      D8AF63266A0393F062FDD5E6D6775B6F5FBFD97ADB7F89FF5E90EC92ED6CBE6B
      8BF294B2B5E542F000D3CCFDBC77FCB15A0BCFE1F977E02BFCFAABE07A85D2B3
      F0BC68CB0EFFB3FAFA21BCBE260AC157DDBCAB481D585BCD81CD0E1735051DBF
      B4280AEA6D64459DBFBBB8088C4A40B1812C53545E5FE5005E0818935DA8EDEF
      B962159FBC3B38E4ECC1A4C9F2F9F9F86CEF19568CBF6BE7BD746B592CFCF3E0
      60BFE36EA2BCB123521574E40E12D6D61FECF47CEF6FBD1561615BB4FECBFEEB
      8690008592E4F1E70D081E85E250B20616208EEB43EABD26FF1148F87A90B2E8
      0ACE914CCF511D6DD69931A88472F3F8F705F53C344DCEA229C6BB98DF8018A3
      C51347AE881158DF57120D6498AD1AF68202B892AB6744848969EE0DEE041387
      7C1DA830244325F9C06697EEFC27FA4101A8B320C8EA33A065960AC33C9B2FE6
      2B04AA9FDE4D056F70C3F41C507001674611A4719B5DF818BA772C5C4B7FF04D
      9E9425C033A57B7DB2DBB0F58F1C65404C828D3AFE328A0D614F1A156D713669
      61A1373DB700AACC4CE099DC2165349BB39369C6E350041D260BD24A94083384
      19853DDAD8FDFD5665458868B0FBDB40E25E8F49F546E84A5450D7BE531A2474
      14EDFDC4C4B3D7F89DF59F2D2A7F20B955E93320EAA3DB0A47F95601270F4B6D
      F84ED7EDB62DAEE280F45B5EA69E52EE5680FD3CBE5AA08523FE625283C55AF3
      9B857146F7F218B487F11876BDE72E45742529CADDEC4BC35BC8ACFA14843017
      289B86AFD049CCC20AD337875C38B04862E249594775645D7F48E8371C8C009E
      C6AEB84DCBE88BBB4EAEAEA7D84A38720882923B881D7C58A11D7E55B385021E
      43C13783B446C82444FC8E7C364D17CE59C0265F3CDF658FC48DD87CF56DCF6D
      BE7A83FF7D8FFFBD755DFC0F8C601D240698FDC6BD3B8F487726C5A8D9BCEDA1
      A455519C10B7309B4765324CA8DDCE1535CCCA6BB71F4FE7D789FBF98026EAE7
      83D75E2A10A01295F011E1CD1647389ABD4E71416F108B0C6C7B62D1057A2A1C
      81AA41E81BA0D4AB6978F7DDDB32DEC1D5DD344EAFCA6B4FA7CA90E7CD961B26
      65D1DEA37BF57D338F8E171A6569D51937BC75B32C9945E9E6CB97EEBA2CE7C5
      F6C686FF4D7F1C7F4EA21425F0FE289B6D4479B9711917DF6213AE1F81A67C7D
      EBCD77DFBFFAEEEDF76F5AC54914C64E816C909424F5DAD0F23B765D39530AB7
      7371B2D373A71F0647C80CECBFEAA1AA70D6D0DAE88D0F48F9A97A30D2F97D85
      840D8E6A7400C241574A7DB2B33007D5E68687F7C5352CABD81925883C8F086D
      938D7DB9E5B6C1C783E233891C85170EF96716BC8B9950555F5D6745B946CFC7
      FB334DED92DCDABD7DEBB6B1DF91E2A109F70C4E6C20540AB33229A75E221520
      56E9F0287C66D175C7A24F8C6667A9D0E4F13CCF58B91E2EAED654E70E2DE4CC
      838AAD13C42378DEBEB4798ACDCDEFDDB62F5A8200E527B810ECCD9EC20FFCF9
      F8E2B8221D149429F02712088973831166452C9F25C8160CFFE318E66618A7C9
      9580C003AA9EA3CB9376A37EE9B61D5D84A07CCF242ECBFA92415D924183CE2F
      04A061253ACBDFEDC040A392226BB4E13918F8D78AF434952396F944434CDF9C
      C48C54F843E0DD6E29BEAA5EE25E344FCA0AE2A41139D8F1D1CA89AA00135541
      35609C50C26F0CDBEDF603ED04458C196BBB2B80DB2593F95D55E667756843CF
      0D2EBDF2CBEB6F79DA02823AC67E99470518053AC0697640CD7803D285C63E69
      80A4308C4E0B6F3A5C53C5BFCAABB3C662D48E8DBBD66248A8DD55B2B6703CB0
      FC106823EE56F6C7403921E47C6CB5435F7D8B1DEA3990547F592877518D434E
      03F5B37637D9A419B823E070115FD1FF14F02ED116B4A5453FD0D9F6402D9EC6
      D3E856050A99EAA9E4833DD9863B25E09357AEF0853FEF1D5F9855AB3F9ED601
      DA3DE0CB8DCD4D9C33D5B06BBC8084C4F9B494E48AC26704CDD862EE0206357C
      58707298131340A398E494B1413BBBFC9DDB86AC218B9012D1BC37E4358E00A3
      71F1232C80806A7547983E31BCAEA3D57071A93A6E164D6D3BB7B4B09B9B5869
      3B1FC2FC6FADF2CB121E29FEBD03DE770371ABF0E0DA3184DE552D4B63B1605D
      558D76FA96B05A6FDDFC3A2ADABD8B9758371FE800A23C6E648E5CDE30F6242C
      1F9C3081DE77BBD1E813600DE9B8020F53F35CCE08F60C80EADC6AD83A5866BF
      DA0D134B068C7AB2867F07BD806D28DDC0F11734E7B260AE8B6A924724179224
      B610E6698B0334301F9CF816F9291BF21BB7ED28FA5A4F096BAE16A57EA9E68A
      A6CB0DCABA9FA50DB4EF0E933C164D12C400F092020F01075E3C99207EFE3CBD
      AD9606FC3EF11BA466D76EF830CD677A40087F32E6DCE6B4403F11591EDC8E96
      F090C73297B4CA23F6DDBE2C0238F93D9B69B8AA011BA47F04857E88F7810244
      BB678003F8214B46B1031745457902B77A3E8FA3BCE8BB13195121AB61C57B5F
      3A837F4AA92088CF6DB7B2DAAFDDB6B2F0DEF15195C714A025592E3D9B999A50
      13C002648321292152509380B54516821D037D02E18464AA8201732800E4AEB5
      9B68DA576DE15033A73907C12A685D332A8AE40A8D1D8A3B1EB3EDC64623B4BD
      33AC7F0D322AED2A5353A85DD7D226BA91F85354AA1B9A996E99E497FE45491F
      B3FCD82D1D98C7C5DCAB1C7A2EF9281D5D6788736083A8EB4828589637CC3AB3
      BF1B54BE34AE40BB8CA2D135626ADB76AE8BFE40CCC3381E2EAEE0F9AC3D43CA
      E56DB3940B39D528156CED3EF26A123894E8121310781CA5ACF46413819C1A18
      5E7643D56DC03E36D2C44553771A7F59D0180DCA389AD10616D79902CBFAAE2B
      9D5D51F1C9454320FE380C5D37932C5FCC5A010DCE1502DA95D4859DF56B1E73
      48C20E0626B3A418D991651C6E55CE7C3F8FAEB27498E5294807DB0CA9833AA5
      6E4677B4DF599568518FA4D16D2E7179633AB2E2D9CAF84F957B058FD42C91A9
      A9D38A963CE897283373E6FFC3BD7DF9B259DFDD5ED5E9EBBBCC201A04234C91
      40E23CEA1A522DBB31CC01F58DCC5A89D44EB711C4D9D5242A1CFE78E7745FD0
      D01CD4E9CE87233FEF5D6929A9F792ACF5DD591A80D4B55C2B1D75DCCF3DED35
      106EFCB68FE43BEA5622C56047D8E5F03C9C332FFBAFBEFB4B9B1D62C49BE324
      029574B1188A8424117384A96CF69B497F9AD0EDC69898606ADE2ECAC95BA38A
      E9BBCB8A2B39CCEFF5A4D603A90014DCA58A5F66CC6B0CCA5C7AA7724B71085D
      0E3DA732435DAC0D2B9BE20986B7BA9B36BC978486A8025DB7E338F51D7FED5F
      DE9BBFB4ED26C5CC4176949A2DAE5BE6D962E8E58C6ABA206BEDF3D4DAF37BB1
      B377A0492529A00C9339F17BB4B3EAB61CF1E4AA8A40399A6696C33F4164EA49
      58F402D283BB97949C711532C821D8A6620D35218F6095F6F7309D25C4ED3009
      41C1B170DDE53DDC1E35FEEADB56EBE06836073E96A11DF0EF47E7FB03C3E8CA
      1B6ADFE6B17F0038BD068F3BC77B3F4A6F63671F0CFA8B51C9798243378D8BCE
      5AEB551DA0550BA24694284F8BD16CA14E52AD01ED5C9C9C09060C0BD3EBDD90
      729AD2BE7B3FC18CD1CB8C5A7529052B86F528E5CE67F3811F00E6856B84EF83
      825E1CB48CA2FDABA06A73F09427822A3CA7B9EE1A9A364965696DAD31E260A7
      A1C5CD800D513BC824202212513FC8FAFDD80889F7B0E3C45820ABA6993630BC
      7B8B6483F303ABB534BAFE3953E1EB431664ABF35AD5FEC8BB120ABC74A416D5
      55ED30DF921A1A0380EE01DF2DB3669BA0A33511B957B34BECA4D1F4F61F3130
      5272197838398806A0E4A21D55CD58C28508CBBABDA6D955A3CB9C0DA7C9671C
      FB17901C9BC532BDE7422782E6932BD69EB737366E6E6EFA29C21AB496B3E69C
      E97737F09B8DADCDB76F5E379AA51371D2B4B1908175E6B2093064447B62DE3C
      4175874C13E0D919CA12D8452E1C5EE6461E47A36B2C835EB511F3D175CF0DE2
      DF5968ED992B444FA7E7E272D46FB6360E21A22D222994D4D2B3552599C54BDA
      39BE6C7F1C6D3D8B4F1910351BB184D25EABFC04E9500BE3FF02422D73BB6783
      014BFF34FCB6C59EA1C44E0915664A02487492BABFBE1F5CB6B93C1BDD04B13E
      852E160A88CAD5318C51BEF4C15480F4697508F034D436DD697C158D6EDDC5E9
      CE893A48388B7ED039D5E29EFE4510C5382C7B6EE704FFFF78B073DEE369DE73
      27478356B1B6E1B556DFA512DFC648EA2716542F27ACC6519EC567CCCDA2B2D4
      8F452AEB66AD45E3E569167288813AAC8D4AE532B1E15DC83D91C9D1D53883AA
      BA08569017271E0B698E2AAA9B949F59A3FDE3BD6623A2D08E274E06B4D77385
      89CE6E164294036D3A8ACA8612BC0D59CB7CF48BBA5F51E6B7D5D6CF520A9CA8
      A669A3ABFF08728BBDCB8BE34A5150CCA19614803AC3944F2A43D9DE18366575
      956DA14B5D62692B43628C7294862773524A83C87D55ED470ED563581FD98045
      CF1D61927BA0939D4E9B9DF5A7E77BDBF5CBF4A8EB87F3AD2C7AEE1062AFF766
      491EB9F845348AB7DD8F510296CD83DBB8DD50F71EA1DD796C30B164219A7D9B
      AA7F00DE36FBFA4F66A3B374DB9178AAA734543DB7339B653DBC88E62B10F609
      78ECDFDC471EBD718E2808FBE5FDFE85CAD018B17D644D2D5E528C0CA9AC4607
      3402FDE7700EEE1289369305DA3DDFBF24B2D55211504FB38493B4CFA9E165AE
      9B402BE1D9E0B37906AE69844C097A6ABB55D82C57A35979A00FEFF17DF4A270
      6562848AF5CBE3F7C2F2D4C86578E4DE706E7C5F611D6D510D81776F7EF9A2E4
      B4DD7D34FEA1C5D58F1E24B0D84F3E836329CBDBE5B5A2517CF8B39B5F67693C
      F322D0EA91CAE1ACB166905BE83F4B266DA9DF8BD78713CC49EDCA10A41316CB
      5BDA33E4E8C0477F90CF55E8087DC9D2B9BE906D4CDD2D101A4346A01D32960A
      2D4A7FB51EB3AB672C7570E0857E5F103D3338F8ABF8195DA4FEA825294D4BE6
      D8687337D211A3E5168FAF4F7AC9EAA8D35F3715FD8217B7F7E38EA51338E796
      C590B2E2753405885B5423D491DDC7797892A5F12D7CB636F756A0CF589C5275
      527BF2EA23C1FF6A41BCB66AC2F6FC86B0BB2CE8CAE2B53B78799FB0976F5042
      C64F82BD49D2AB4EC32E36F5489907436B1E73AD48D807BD6774B95A35B449B2
      46D546B1534C1A5ED22040A4B1C5292AD5C193A7166A29A44E31E93A0B786CF6
      EC80386DB8284B19A47E5686D963695D12DD52B3D5F23BA1D45FC00F27757A28
      A3F7A4927BE7667AF85214246F8C7FD3870EEA67766EB75A1D03C15854841359
      DDAD40BFD7D66F98CBBF4DB32B46F48B79460465434CB0D8C75902D0A5A7EAE0
      CB12A620F618690023B18BD51AF22AE8F0B3CB435F50CD1E352ED5715C1BAF89
      97661185B93C3649A763B91E6ED3732089C5672AB2D317A08ACE3C75AC1C1A15
      132AB9887935EB50EC5AC64BD4912E0F061FE45F71397A0E304243264CD39C90
      946073D86ED02AC970EF5E8DC747AEE5E96D91E206611075698B18BDB6252AC1
      40AF64CB8A655FD151262DCB5E8D915C1D246A5455A019D5F85A98A0AA4E26D1
      A9C20669F7A467CE985D1A1E163BD3E96FEE637E1BA3A7E95ADA34105F2A3EA4
      FB47C82AF7B57BC3F33DDEA17B6C7AF7E3E3DFDCE1F1E092B514A1661411CB9A
      57D9E6EA07FB60BE20A4AFA87008DE0D6EE533848958ED1CECD90C4D83BF5535
      6BF9A8C0126D71061ABFAD46B33EDDB6A8A3DE5A5E51838CD82662C885DA985A
      F4C405C52CD8F6845D173A0DE2A1D1B909D2B41BC8E532954B13AF6924E5F10A
      893ADBB84012F59E64E39F92D21D9D9CED9B2F16B2DB1BE35285256E73CB65EA
      B57029078534E83446574D7BB47D042E1851098B42F05F45C9D5B839E9173B60
      2CC0C86E900EB926352D9F4D12F160D73B383E6E7D93419ADDDCBA1BA5CB0C33
      9EC997304ADBC9CBEB5996E5CF70C86D7EFFFCF2396CDAC781454F9E8E3CA012
      1A86B71F72437C874A369D7EE060909105CBA702CB0D50914C2AF19AB131EC91
      826018ABF469C3C2BF80F245C35E5B1E33D1292D1D6AA58AB86E059DEB20EB8F
      B722B5ABA2E32148D7E433ABF6A1A093F9B871192553691914E4226CF85D09B4
      46AFAA2104634CBC8DF2D2C3A5A898BB55DA5632691CB4B49F80A299506724B2
      FFBE98CDB5CC18D98C3ECF4BE3C4B24B35CE3FD92B43EC8ABB1DA47093CFB324
      6D8687105336A029230092C6597EFB8DFEFE1CF73D90FB12738E90125083C811
      E243020C1EAD40BA5A1AC957D5A931864670AB6030DBD068B4089F6B2F09F912
      30FADF86F5113C85D0DAC5300D38E0846425BA8A1A76F95A33E1BAA83CEAF5D0
      EF6028FF116CBF744F658042A23796238137C0DD0C5953E9459CA231945C78C0
      7208905899A385A61D3D3182966CB8F34F88AE921C2D4720BFB850A815769A64
      FAF44806E4ECA3E48CB70DB6177F99C77902805C34ED9979154DCB68993CED6B
      77EAABFEB74D55F6D82FA8BAD4ABB024A33897CEFF7B1C8B26436D48068A7EB0
      C3E4CBB68813710B63A30A87429E148297A43404F2139DC9E21FFFB8ED68DB33
      B26E795CC05F34D1F2A5CB189124BB7FE592B0ED0881E3DFD1718D5AB90329EC
      155718B4B9E40DAA4D639B93854CD168B4C85183CE26B6CFBA5B6E785BC66BCB
      37964E87BEDB95809A990F8000917F075EDAD2AFFC1A1BD34B3B0ED0BCA1A393
      21CB61C8DFB47F4F4B8458C5F0F5CB3B97782597E85C80131E51A47649D357EE
      F7FB9D879A2A50A0C23615DD5EF1B2A5AE400ACBCFC99538F5D0A6E349B1FE67
      77DF8D1EBACFCAEFC8442B681CA6D6FE58B18BBB618CD356795739F192C79566
      1560F76FE9A5E6502CA8BADB5157F10447267E21DDD3768D35E4C8F813971213
      C8D6CC2DB4597066B8341E7C34EBE9571A25CDBAD142524C1930F259365E207C
      E1ED98C09B46E4BD53D221EB755880D94338A6A9327FA37D17D1F4064420CA86
      810651A9DE5AAB4637EE5FF5958DE1F0ECF5B9E011FA101E96761ED22F41C2E5
      739C4F239150B0D9D6A0A92A39E9689917E4B6A5F47BB1602E29629390D72494
      CBB3838F0A2512168797C7C18A5BE01A72DA48CF419CE3B53E38B51F772E4E8F
      4EDF6D572E03061AAC92B0255A462D6B8A03D6342A535F28B009CF0BDA6CD3B1
      6637F338FA244B48DA3FE4127C4855544C0AFB2D5C5C6DCB5508B1D06AA5B72A
      23132D4F1D78193DFD96F0844FA7C61ECB12C8E1D96B11E39265C7065E4EBAEC
      09DF3D51D4D72A078F6B55AD633077590EF76D7AFBE09C0A7542ADD1076F88AE
      39E62841AEDF9FE19D699463738EC7CC38473711A4B7019C0C66317696A10414
      7E01EA36B7F56E5749261682E81439C2C8BDD91A2665252934711F99F7697DA8
      BDEEBF74073F9F1F5C1C9D1C9C5EEE1C373BE1E4712B0AB002CE8BEAFAB264B5
      14A9F5F44853BCED0CAB812431726C04864C5BDC00A718C76929D605C447F223
      980FCA4C575887934BA901343D5EA5C9241961795106C37359662817834F7859
      1643CD49C08DC11E57A8C72B8ABC599C9DA999A27B9806EF305B9461F5DCDB94
      59569406245194B37A03B3384A037BC88554C4EA6316385D6FB092C2B8D27F78
      9C8C9170E71F6E9910A77E5D1749529139ADB2DAC5ACE7F60655959259243DBB
      CDD5E62EA2F24A54C66B24C74B820669916491258EA1DB1C6A2959505BB69345
      E02FCD046C873E6BA363B4EBD2B08717FFFBA2E0BE2E8C994A2AA7851C724589
      A9F914C773997B5CB758ABDD1BA58EE0E6D709D667787BDEFDB2367685AD4B38
      B1CE8F9FBFBBD89773398EF229E09BD6FFD038FFEE6F6718BA043E779426429F
      D4ECC2BB8B2B247318AC888FA611FAE81A6DC4EA5B487B7255F41743DAAC9BEE
      3A5E4D7EE01F4F97AF58F1738439B9DBD9FBF1C2FD425AE1979B5BBFE16508E9
      24704A187565640771697F1B30EB5F66EE6CCEFDCC0A807C41ED6E11977DF72E
      1157580F0E4656B94F51A0A8CD24E862AEF350F53085CEAB0FF654F081679467
      40C2C179035D999E38DEC9A472BA035998A0DBCFB881AC0C2F250C46D67EAB81
      7501319B3A63B13FA3FBFFCA77C34D87B8C23FB2A837E14F4C04D076D983F464
      4F4E934F523D3391D31747A1AD9610F48527A9F077444774F3A7A92A22BAAC31
      6CE4DD6E8A5A52475ACC5D8C84891EE8F2A8A61DC7B0DBB3DA46A57D741C078C
      ADCAB58599A3A493BA82BC31743E2496AA2ACDD711621E00B6E0102C5754BEFE
      D87ED5346C7E07B76E60E5D4EEBB93C1E59AF5D4DF48DDDA2F6ED298A33F05F5
      844CAAB6E89E132206B10C0D3BB53429A26B59E96A02A80693BCCA0A02AF410E
      FDC81D52DE975F6E3F85CB61E28A00C50E6B8D85584F98457FD78E205BBA113A
      7935FE08BCA0212D2E2264CDC024C58A5EC876CFD158855E0006161C4C921CA7
      29B5E27C849E666532920662514B6D79A3C8BD82A5ABDF84F9B2684A9707BD9E
      11B0B38D4FCEAAD1392AE32B905F747E9426CFE12D4573A9E4DC31ECB610A30A
      84836BBC190700397114873EBCADB838B2DC91A55266182ED4555C0687ABA9ED
      86ECFA5597453BC0F63CCA19D7F21C2CAFDD3BD0B737DCAC50D0CA26C8F10346
      94763C311A58EE71B82AE7852484499AACB29A8DF58706CBE6BCCB2E1EA2C131
      9388204CD009CDBC3D38815A35E9B97E7F4D33D3A3305343D7A133F066BCD3F3
      3F9D66692CF143E788FA92D5089A89FC2AE1179890259521F9562BEC58363C9B
      4C12743CB7925E14D76E3BD86A2222739367086C0DA3048E885AC76E054B9503
      2B4193389D2C73B8239BE6AEB02D72F46BAA76CB70C21856237FB5468F406146
      1482CB1B88CAFB4828464C9F1433DDB19237098004A3297EE59DFFE6FBD7CB16
      6ADF44186A747C7B98D28A055CA61DEACC15EEF705C9E6C000CB144BD5595A69
      5ED3F6ADF5DD8E52ACE13CB02402A9B0A42F86F534CF103676BBB79D5AF794B9
      174113605D411E9FF68315D4B34FD6B4AAB2C3829AF6574EC2FF29424C45394B
      AEC212EFA3241F2D6630E860396B5D8CD39693C8E5198F3F9269325549D5559F
      69A52F83920FE0EF22856ABEFB8D846DB407CC769B2B21B824A61D05B1012AA7
      BE1B643E9507CB164745C2A33BF28A40B0F0106D6CA8988A4405B2F057EEE8C5
      6756C8AE3261BD279FCB0FED8A2B9B4DEB15751F112F5AAA3EE3201B9336542D
      3D346F9F1544D8917384DA4CBE78B644B9A931045B21ADA15BE04FFDC2756985
      8D2C2742970034E01B1E50E64307C99BBB2791981521DE9514E686D4C999C88C
      5CBF8C8B2D2C5C0F7164A2DE07B9A4CD86FC8A570F82235C314349D765574F13
      C33E21489BA33646BF5DAB911E90D4EC81CFCD20E64CB24AD374507853C62E52
      F2DA1328C4B9F2F6AEB2F4E9B5FDFFCA16A424E3EAE64F3B79ECF6815B7EC871
      FFAF6C81DDC47DCAE6F8EB6C1ADB0E8193B89F8D1648BDF7DD3BE4B7FEE07ECC
      E628424CC1D37537C9760F74FA510E584D774B8544B6A454C7DDFA111E0B233A
      9AF171AA7457CF57D2580F54141E3BD01151F32A5AA1F5100BBCD7458AFC1526
      3FBE315E134FC79B8EFDBEF396F8FFFDCFFFF1FF016CC4459D}
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
