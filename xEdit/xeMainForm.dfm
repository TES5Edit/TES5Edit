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
      789CD4BD6B731B47962DFAFD46DCFF90219F7B44DE060892922C5B8A9E091000
      29B6F980018872B7A170245009A09A852AB81E04E139737EFB8DB5F7CEAC0248
      515482B4CF9D88718B245099958FFD5C7BEDFF1AA6F9E460A8E32CA4FF8C17D3
      83C33787C3C04C26FBFF359C24719E8FA2FF1A4EF687936C1966D970329EE934
      33F9BEEA9B6962D4C7D3F7FFFDDFFFF7FF355CE8341866A357DFEF0F337DF0C3
      FE7F0D47FCAD57DF0F8B289FA99EF9BD3059AE2649AACE9340358B7C96A4992A
      B2309EAADB4E10E6FF8DA7B867F153E81987AFD5E944AD924265339D1AFC2B55
      F324C85412AB0B735B647864A6741CA82233FC34A533A5D55CFF3B49D538992F
      92D8C4B90A6315981B13258BB989F39A5A444667468D93380B0393AA2089758E
      196995CD7514C988090D9FAA36FD3989553709E33C533BEDEEAECA13D589E661
      9CE5266D7EC48F59B1582469AEF29951493C4DF0C0CAB0785C3E0B33952749B4
      A70633A352334EE673130726903924B10A33F5BF0FF6FF9FBD871686DF35CCD4
      382DC6A18E303C664AF30EB04A0146C7D38B38CC57B448F42EE324CED37054D0
      507515276AAEF3DCA434EB2CFCC3A83A9E1BC6373A2AF42832F4D5C09845B452
      7AB148CD38D4B90936A6F7C019F834D3F9CB4C5D9825F68167FE7AEF60EF4DFA
      9F9BCFD8BFF38C437E46FF7A958673D55F60F448E1196112BF5399BE31AAD33F
      AF4F223D9D9A402DA2621AC699D2531DC60FAD603F8CC7464DF5DCA81B936658
      8D83BDB7357564F299C902FD32531F1781CECD9EC9E62A0AB33C53C98D49D330
      084CAC4E2F8E2F6BAA7DDA3CABA9F6D9518F56A9DFEA5CD09EA60156508579A6
      266164D4CCE8C0A42F337579D13CDF93358893A5D2E3B159E419163FE3955EA6
      616EE8177315C67942FB82AFF1F1B9FF6DC39C5622ABD145BB7FB16AF6F7573C
      D94E1C985447AADFD953CDF89EC7AA7CA673FBCE265359319EB9B7A3A9EA8C86
      0DD408074C199D46A149E5F5663AC3E9A2A91B9C3993D1ECF066EF5494E800D3
      C6736813F16FEC995A86F98CEF89ECCBDEA34FC9E0EC7DBBF7D0A637474991AB
      83DAE19B7DBA1BD8A08C0E021DC8DFF9569E9B14ABD0D5F97886BB909A511146
      225AF2596A4C7DA9576A8E8FD5542B353A37AA6DA25CCB77F052F410DEC1730D
      1941FB9D26451CD4F3345CD4D43249A340650B3D86A499642657392E5CA6207B
      700E721343D6617D6AEA3C49D36419C681C23265EAA279DE5151185FF366F4CC
      C4A4261E9B401DAD6AF4AB591107A981BC9CA871AAB3190E48A0735D8F922C53
      0B9DCFF8BB731D4D92746E82BA4EC7B3F0C6A8890EA32295A94CC25B13ECA98F
      3830B1D1F9AC4607D1C4D33036D8E32889A790A266616216CFF87B9199140B60
      D209BD628A3F24B151D32819E988EE1E4F940F0C1639C878FFDB265ACC4275F0
      6A73F30F5F6F6EFEE10FBCF93F99959A85D359144E6779B6F6B5495887788A42
      FC37BF7DF57DE5480C474514997C98EBD1FAC6D7DDA9C51A60F368C383CA09A0
      039BE5CAE8F14C2ECDCB4C25CB58CD69CB6B2A4B94B6D72989A3951A270534C8
      7266523EF3E3BCD011FE30D3319E9E257393CFC278EAF5068F3E8C75A555409F
      5AD0A746265F1A13AB7C99D87B47E74643971491A9D9B71FE9F175299826619A
      E5355A9D6978C3724B65669CC481D7FC3F957722537575A3A3305097C7FD815C
      0D3E2FADB3FEBF70988E7514E142BFA6DF469A96FC9ECB03F91498892EA2DCEF
      5CB8AB57E76B97DACBC687836E616DFD0AE27A5FDBF9CECCF89A845F274D61FE
      5CC7C9322B1FFB32536160E21C8A3A2D200176CA21C34C65791845EA26344B3E
      44249B4930911DB3EBF5527D7D0313010701B71D470F4B555EE7C840A5E09CE8
      B9C6D6932A4B52951A0D0D20C2DFEF9C46095980589DB18EC7268A7832245882
      304F5295E57A85312606D725264B701C2519EE4D0DF358A426CBD4B5596535B5
      9C6172EEF290D82EE2388CA7BC055A7D0AE300AB9E998CB4BD89033532337AC7
      28BC364AAB3849E73AE241BC5EEBA8DF4C49744C8A2852DD48AFFA391B752717
      E7C7CA4A573114D78C8DDCDCE6456AD47856C4D7346D986609C46F92E248B90F
      24737A7152E96BD2DB3E9F0F656A264566024516AA0E9C12F0152D6D330963B2
      247033EDD57BFBBD2AC84C0A60827EE8B47BEAF0FBEF695EC7493A5757625B1D
      EEFF5853FD5CA793D0E086430F8E747CAD623D3738C9B82E26B06F14AF48EB64
      4A8F53E82AD8E4D017D9A3D541CBDAB9499A3D6412546CF89A4A939149F3E9F5
      E1FEC1DB9AFA072CF2998ED56596A745A676FE3D4AE85FBB3565C6D79949F5AC
      0611688A382846B39A828AB5DB826F5EC3D857AD6434A2DBAFB32CCC721CF7C7
      DB34E7E4CA1C1B8DCD7FFCEB575599D776374B85063DB8C28D8298CFF53509D6
      68254A8CAC445171568959632ECBC9062E35E27B154E48C758CB95BFC16A03B6
      388DC5F605C97332189661ECA7D04F49AA8E75A474C05670A6E63A2085B0360B
      686595C463C3139C99950AC2C904FAA49C8A5B10FB30FF8935E91AEB3C1C8511
      A43E2B61F873F8355C3831830DEB5DDC5EAC24AF624686057E4ECD3CB9D1119B
      71A981E6C64FF43E5E13EB546C9E850E319311765A935BBBC2EF6BF652F2DEB1
      79490B88495843C21A4F743CD89DD690D55EB3BAB0D65756CA9097998A4D06C1
      73D16DA98549C5108683ABC318B6676EE6D0C0556175D16D41DBC63726CE139C
      347CE572148537D84F3C895612066BB63051E4BBBD55DB6AAC6335928D0CDE97
      062146B2D7A3C5FBAE06891A270B5A671527B9B5BAE834909999E433937A4D0A
      AECDB5592D9334607F96B4E678A6629C1B19A9A696B8D474AE3674FB83D2F68E
      DD59ABBED2BD36E813ACECA3ADD675839597F3CE846A776CD81A4C2D1362C955
      92069E73BEC7280FA77102F7AA1945C9529DEB6BA3BA3ACD431DF1892CADB0B4
      40346302F9E30C3578D1269D8731E95D5E1038D47EB35BDFA67B260BD5ECE4B9
      AE6871D6FCB2D69EDB593EADBAB1243596491105550DC103C1585A2D0C7BE66C
      E3D07E6A353759A6A7468DCC0486534560B2999EE8C0D35E6D4AE0438D697970
      A0EE3850D830D2F7986AE54F2F3399B89AA4C99C4F57AE61FED17A4746C77200
      61CC9A85C84CF98E1512F2229EB327D39DDF1FFE6B524C676B2247C7220546D0
      C3DF72F33F7D298AE139D38ACB07AFA05E7D26B6DCBA76B0A7306372B4CA19D8
      6849E9F1D5ECE988CD525D2ED80818C3231B25B7EFF10D27FE4BE70A822212DB
      86B79CC542652CAFF7BBBCD769A54793534BAF4C51D8691A06D5F7A597D88896
      7F8BE40FE3FADCCC9374550D3295A67B422605E671053713DFCA66709748F523
      D22713B1EE54966B2C106D0B1D1F27B1BEF90895BEEECE13FBB89BCE3AFB7BEC
      EEC13D396DB3EFFE4E4588D31B568CD67681E9E0BEFC325323E40C580ED468A7
      C479616BDFB06AB682A21CD56BE6EBB1843CD5E36B09F9950FB65B112739967C
      4561253EBDF41A73BDC26684318CCAC8E49E229A83DD941420737A12B25108A9
      94278B704CD338BD689EFBE99FCDE0486AE01C23F0C04BF932B3698D6B03834D
      8D74C0D7835F7F1425E36B886409A1F0B2D00DCFD6F695E3CFE3D518C79F3350
      582BF89512B68B92E4BA58700CC657D2EA3144CC4B3AB9E4FBF355C36D8A1134
      490D7F8266299FA683E4794ECA78FC46548A6C7244056244F435C51020C2F4AA
      1470B304215784E41F7D5B211F24FECF1115BF79234AAB5A5138BE56FF41290A
      2B789DFC81B7992C4C9C899C475888C40D990BEF2461154F23538F10880E421D
      2553DA63FA848492750CD9470B209125F6E9E6459487FC4D0938497642A5C858
      EEB844199FF66A68C04F1835039CD671142E46898629013B7F6EE2C2DA0CF6CD
      5FC2818B8A792C7923B5F3DDC1EB1FDFD4D4C69436E2137EB3FA1052A650BCFB
      854939CE986A1266F4788ED7F3B5FA1006465D90A9D09F254B7C4FABCCE4C89E
      7AEB26AB95650759F16045C64914E9456654229FA014CC344D8A85912B3E4A6E
      559E1AE33DB83B6FA999A406111C4836134D589A86B99A26C87E41DFF11A40F0
      C9CE587B8DEC53122310217CF0588DE5991A6B6B75245152A4DE26E84D988538
      FF7F98510A059C860BB278029D5EAB2C5FB9F8385D73BA9C32A44DC9640B8ADD
      CE8CC93355209FA3B4BA6A9DF1B79F4051E10C1599F5A110D0B90A536438D420
      3586965A67E5259394A6BD96640FE769F4B7162E47E85CB1C88C71E425F7F892
      9387E48F8916CFD40E7DAF19E57F6BE14B61CABAD933348E93CD292E781F3965
      EFC3D2508446AAAEA45DF3EAC74937CD292C12C6927A7D99A9A5D10B18A9E5D7
      DF977FACFCD679EA7227F46261747A6F5EFB01597D46529642AA26088BB90D78
      F93B8AE3DC2D392281741D131DBD5394768367CA23799EA5B8988F70286150C4
      FF36E39C3494D2FCF87AF97C97AB663B9DA361F81D142F1C46CF18778E31ED3E
      77FA677B4114E1C8F2EB49E0C6023DA030EC67F9F492B5DCD62BDCCD85495FD3
      D74DCC16F75AC6EAAAF7E85DEC50A2D55BC08D937812856358F1D175AD72E15E
      66940D86924DC552D96941299DC6795273BB515BF7516BF7054E7E2EA0C89B05
      A2DDF4613A73496A76BF1454A0F892C25A8810D84817BB888DD9EEEDEF64A981
      4BD06A5CA429AE290140082B1423C1F24E6C0D67C4EBB12804B20FE9D3814B84
      B878A3B9F573CCFA9C614BEFF8E69A9371F26C12DFC9C2AE14CD42FE243E405A
      7DC35C62143ADBEABE3340294B8A740C176F0C2732A32C3D4DC8AE09D2E11A27
      1F17D106D4BDA3512534E65E38000EA8853409AE05FE4D540426F093F59BFAA9
      A6FED13AABA99B715467955A2FF230CA6AEA1F5912B775AE2F47904B2CF4A33F
      5ED7039E9B75A56D8C274C55B1C8B01573B54813FACEA3933E47C594D25F8F16
      119CCCF57659EE4BFF0A3EA6B691EEA5CCAB4B0D93F41D9959885829BB63F234
      1C6DD52C235A8815A4530324D868957BBB5722819733E48169C63485B18E112D
      1F993240671D49F180366D8E11492132ED92D8667DF88988762C744A1F452E98
      B2B1648E52F639CB9385DFF47F3266218B86B45A802B244626C757688AB02824
      DAC9BE76966B4FDFFD1226E89AC0C78DA5979C6B4A98389586BD7D8FEDCFC669
      B8C895B92515172466AB774D8DB89E2E79968748F3DDEA711E89ABCEFB541E1D
      092B53CACBD38E8076515AED65E6771BC9B3C2A972C4636302BFB73B0E6FD51C
      68358B87B378862892CB9F1523FB37DAE22C4F52C4A671B8085C19B2BC088A94
      FC2F68141D851929E2C787CEAC4EB646196BA4C5CA571A3873BED4341C79E604
      B69AE93418275055123FA340B8C4AA21ABA1D1E9C4DDE68C6BF5B7C69C39985D
      878BCCBD2287D9B0AB584908568B1BD076522E67A0F904532A6D12E6EB72288B
      92BC9245F05D2F608F39BA6C6383B4523617CE539228342B8FD3B6DADFDFF7B3
      1870536CB660A6E38042B9768F10E58215B10CC79C39707F618119C681B9855B
      8213974B1E45D2B8DBBDBE9C005A71440AD7B2FE9E1021A3E362217E00C4209D
      8252609019271FE2D7E39D553A82CA5A95C12DD918BF9B9E508AAEE272F24570
      B1C9651823D96C030331ECB56D5E1B06B885FE5492E83036954E53BD423E49DF
      86F362BE263E4B88326216617C27B0BA5DE24B5BC50010CB34A64497C44958C5
      E3E5E14EF8BF759EA8BEF5F5C96BA00019C2748BC8A8948242C99D7040459EB3
      0A25CFC16E903B9190002E82B8A3ABA2ED2545FA3732F0F8258E4E29F0586DEF
      DAACF998B29366BEC839CA631D76CC9C4514EDC87BBEF871624F67642682A540
      9CABCC5AFA39AC69B258407F0096972CEB22FA0935E334AE403E8F496226B43A
      712944259445522BB08FD3B851146A751F58FB666D73D52B42C8465D79691086
      B14B46AFEE4C0E4EAED12A8AED764F82F6C1E846A28312440847CD538691AB51
      4DF688BBC33374A625F9395825AB51E69CCB17947F6D1DCC9E2773208FA2D576
      8215613EE49565047BACA5BC054040181170E369B604175868015E194F186EFF
      3A5CA8BD698810471440D5900D8303CDA7234A206F6958FE84D7301FE3D44CA1
      B22AD806776AEDF52687EA4B19F0073129D674AF004C09A1A4C7D70821235C93
      A4D7FE9105CE1A848251B500097612522E7C02526B96A4F9B8B061C270CE7084
      3424F82DBBCD301F4873BB500C6D24B042FC38B112B57D179262E58775769D59
      2C762ED62689644F997F1F56B68CCA535C97CEB90D4E661BE05909E5D25CC5BC
      DA6236A27838CB9C337842168E3D39B79F24401833E389D4D1D94C90A7942B14
      B35E10048007C5942B40DA0E1E0652786CED55B7A994232459B6F0CC01FD953D
      574B8D5B50C47918512EC9D9FE1BE1B935139126D76273588C6304C038B0455A
      1D677781BA36EF8B40AA1479F43530DDCB4C75A3623A5DF19F52031029E49716
      A58C0BCFCB0CF3910BF3F000981316BCED904F16E973179BFDA008E0243055B0
      85D922D27EC2B86523A8A9C98A28CFDEA9E3CB57AAA18E2FAE54AC6FE6269BA9
      3C0D357291CA04539780652C27BF56A4E3201BEB85919BC29F393271382DF1B4
      9CA699198A36CFF5A2CCBA8F75F434E9F50AC03F819080F8A0A4783846D40341
      D1F10CAE6D92121E3237F305502AFC5B6F6F19D6EB780CC0FE4D9870621C462A
      507614C6ABEB28A483992511172762CE843C104DE0A7C9386E3A317431253040
      AFEC0C784EA1AB0F64E56C9D46BC93BCA50C6FB9E834976C6D266B56D8E32C25
      FFCA0B195892ED1B3013CABA3BE4217DB2C46130B0B2828B12793C625588734E
      258292E05B33B0A1C9D870C7CEB24DCE615B1CC007B07C9E315D4E947EC2856A
      13E49EB36017497EFF1F6539627D134EF96C22A75C8D86B208ADDA88FFBF598E
      3B9EF4E66B79EDF13D1E93A7708872BE9D770F24C198EEA9484A9365E907D244
      511C14847C3FF82F527C3721FFDD16434BBD117D0CB94CC98B2F534444B68812
      34559014542CCD86B738E894AF0C63FA27DB4F3A43210D7089F8DBB9A7401D3C
      7856A90A2A04326DA1A95E1D338AE01360DD70F2207539102B0BC0BE1AFE0C1C
      EBD2D7562341AF7AE17846699CCE65915F4E7A9243CA948106623587128A780A
      D300D56E1BC0162EA3D9FD865A1FDE5902F3101D408C9A760E3FFADA82CD78E3
      312A4AA694F3E0DA581AC8DC52CC2789EB7F9834A9D65A61BBD9646723D96B0E
      755DE409859E3018FD841119918DA83D5BC6F324301029F330237335495511C3
      D02237413EC4E61645C38AF85966C3362757CDD7E4A79E41E09B17EB32D673FE
      AB5F15E6571E9F99BCD33F17F780BCB19AAAC3186EC60189406B1303B34475F7
      65DCD8D62F71A50662167410A98C0F75D2585292C47BD35992F93A32F5F377EA
      7CA54E08354A8F9D22D94391D85487E4A1C29BC9229DCD1E9D2C2C0BF384B1E0
      F12E72338A78367E1B72D23956C3A16A37074D555797E954C7802E935714DEAA
      8F31E644416ABCD9D323EA7A9DE31E26F0CBA0735653ADCED919FDD43AEBD5D4
      D579B38D9FFA74FABB299CE57CC5F1775527074AFCA10929A0EC39107F6767AA
      0EEFE1C6A4B96A931C288C1A2044EC96858295154C01402CB60CF2DAA8F3CBF6
      408D17E2273CFD1C5BD600CF64557A450C98BAA02F5A83765365F028AFCDEA19
      86BF685E9DAABAEAA605CC1ECE8BA98BABF35317FB7EC663D36BF7555D7D08E3
      BCF4BD1832D5D3415890A4C8934438619EE17CB43EF454C3CDA78B0AA62C5767
      C998F53A6F0842A9A43809EFF81CD34056A17204333191969C79A6C82E9B3304
      295E07CBDB0AF839AC439C9AC3376F60550C3AFD37AAA1FAFD4E4D1D5FBEC67F
      DE725D70FFF8C06B9A5220C575C50E8215C66136E3B2BA8D4B6421F19A3C29F9
      322AA52561F1F40B797974D186206421738490D47A2400E6DF886EF23B320C26
      D69760FF63AE7424E67F69CDE912C0F5F43326FFBAAE7A265B243182749493E0
      0CF64D822C22F902508898E3A0D3A79D7C55A3D80776B3BACFCC43C28F52179C
      BBC5BB903AD55475817A3A4258913FF4F8177A488B1D5FBE6A1C5F5CF959AC17
      57A8660F6FD94903B258D27C79E2CA5ED549A7F593E439C462602C376A4010C2
      4EE27293F89672848B7C8F4CCD2EAEFA9D277A59ACB737FCBCDFBA3C7357C7D6
      E853BE9CE2641C8BFB1887BF174635C784C9AD868050F94B40F948C312A680AB
      88AA4AEDC1D39FD26EA7F713A8378AB9EA5151FDBCC8C827B5863741E3272191
      208C565C70FF1CEABCF5A1A6FAADDE594D35CFCF7171B0A8B0346A9CA678A681
      2F4E8FC98EB0C8B7FE0CB1A24C758F7A288DA1D38A4C3E195EC214F00CD3C0ED
      879E224AA7BA6A920DFD001396A38EB2512D5CA583BDB77788B5A8CCD6B25675
      BE4C54F564F2E27503DAC8DBC54D58C0CF9300D03E1896E15A459154C393B715
      A6F2237281449EF3F41B737C093CB1AAAB7E0598BC8942660433C3669E610A65
      897D5DF6779D000496C1FE8F5C43029610FCFCFDF7028B21C28FD82C23982136
      DB4E253C9B33B5BC1B8C7C78DA691FF390E44B86D358EE91AD0A8200CC0430FC
      ADABF82074D3D31CEA3B0A15E74A58169577EAD332CC8C3AF94800ADC0DCDADC
      2717B8D51C83858E2A542CF456AEBE731922B9CD3C3CB9AD5F932AD44C34E5E6
      0A6C32A63CCD2691BC5963E063D20936240475E004609C10F2689BA4C1CF1FFB
      03DCA6A55EA8E38F6767F4DC23547FD2916E595E49A4D7A83EEB1B0EC2031C87
      E4A9FA03F7B22422D023C77B5E2255C81421C8B6DC509184447F28B3C61F9328
      A9C48808CC971523CEE9931B0014824573F103A91AEDFB3BD568250F8E7F79DC
      A48829242EA6480978D251388D1186A3182A0E68EC7EA703CF986D10A813939F
      6622AE486F953F5B64FDB4A07A1E11E26C2849D494E3E4387853030E4D911D95
      7F536C3532F404106A1AF7D767304FD613E5EBA0A82A248AACBC32C6BF018EDA
      6A6C4AA7216D5493FFEDC8CBB36B80DF1CAD4E0985B83E4B4E36B948DCCBECCF
      CD8ADD99BF9D37EA9C69BA494AEA877F5DBBFB3E4C82E75EA3020EE6F5668169
      0B70250B0724D17BA1AB60B89910AFD8AF82034D1C6D01C569A10C10E61F5900
      62F6F25323121D76378F134F408051520443D7ACC503B80BADC606E1C653718C
      FDF4A9DDA4B7FCA97FFA2FCE0503E10F2544D3A49BB74C510C1758C09D67743F
      085436D6360287A5FF786A6B038EC14540CE1D4A0D40F9C0EC1272BFBEA2F53C
      835272228A45148E218E2A1E557D2DEF48E75EC72B26BAAB7C2C0408F19EF93D
      41C44C92C68E4E2B4FC0BE77132645A9931D62AB4E505D0EED613319A6ACCE5A
      83921D774462F0A934E7C5E9F1F116E88863878E7867D1B488D886B4A82CEACF
      2FBB5D2A470EC99A253D00EE378E1B9C273786722D739D65F656949182073D37
      51294FBF691FE390F9C0E0B398F41DCDD65D6BBD2248A71ACDAE5B0E48786EB2
      597FA61706854E022EA69D178FFFE13709C20CE6F4F25994DB02FCD38354C719
      427819BFCD517F90863461DA3073CB81BF80CA38B14FCFB0AA6C2C7CD037C9B5
      3A8D714CF43BE493C83EB0CE824DFA2E4C6C7201E9056691CF9E659FB36B64DF
      4C367B67A577B930C01A6CE26E18E0F634778F292FFD9C2F64D7AAB5B45F22CC
      7C8E0345C020E0EB041A603935A1035C2882AE40BBDD77CC9D42C299BD63C496
      564B9D32C9285B28147206329EF8BD0888CF14F6A4526322504F162918D46D65
      2A6FC63CF164EF025D2868A9851D547859E6E1227B89D0B3AE210E51E119754B
      1A24025846CA8EA8E5887A141F77D51BE1C2B37E9EE9038996854B8CB15A9BD4
      808EE29000A5D53DB0A633FFA1181940E150B1E609D03AFF668A54C279231481
      7FC33CBB61092AC170625A271F497E628E4CAC251BFE4C5B95D52C0A8C799F6B
      EB34AF59ED0E881BDF3DFBD76B3549BDD3B24D31F9D9832A62EC431571093B95
      FE555B63F900B886C304820601C3AECD9A84DEEC103A509199EAF18AEED122BC
      359C84D102883E4E8AB405BE0738F53A53E721C82593094C7181F3CE355790BA
      7A9771328D11DFD0AAFDCBC1FEFA01091C7D14DF836C7C0CDDB50D08DFEE1939
      A3594DDD00DFC7FEE241DB89040C79D43CA463EF8DF88D961020B01988100619
      18A635801CD1B1DA9B2F5EF129A41E0D5CF8CCCBE26C91301B4B808ABF086AB7
      E53D499B6714AE16F03962A86BB452118A5FD841ABB3313D09A7B4A804F09545
      6391206C4FB80F22A20CC0B0B71B970772F680F4C62F2081D91BE9C3A7526AB7
      ED62EE29FA58755037868DB2FC79982DD045259077E6E0B0F570D9B723F1C3FD
      4D96EACA4CA5EA9A6C7BA2E1F7DC0E4A445AA62B883B24B45982D9026F5C9730
      0E992E2A8449CAB0B1785AC0C573E2D8F24749F9837781B0A3C2A8ADB162943F
      D974B12388DCE0B70A8A39DC40A745C861B324B50AE81F815E5A3E715BC030FF
      B653F2ED8D4D7EFFCFA76B59D1AE3490C1ACC3B8B0AAF37F7FA18DC502CA694C
      9A2D892BEBB767B2052D868D0613AEA121D430124775DCE4B68BCE5D88301CBE
      992E229C9C6911E9B46E6E9DEA66340D9944C2868EDB59773294EA939DA6AF47
      E128D54CE2786D2F01CB8ACA31906088B95DA05DD1DD8E20CFDA14A25CBFFAFA
      0A0A6516B3BB046A87F604140369C8A194DD9A88687CDA7E2B9948ADACD07C42
      C130BEC471DBD84AA7F7EE93126E19458559A480ABC8668D75FCB28C7CF1FAB9
      0F65E59FB7210FFDF2FE83E7BEDCED2C0FC7D7AB8680DF011962F2FD28AF9750
      D51AF33B3505A35BD791F08A956868B6943CA77AE738EE744D1AF5CCD4DCEE96
      93B54E3D05E99828AB662B98DD44785E4486C65F7444A2F98A6A2403E35B4FC2
      17A3D114A7A2CE0ACC5E117703290C5552983733B628593DD6C90A6055CA310B
      D7EB00243A53713A93898AC2516026881A36A23F5E376E6F3F40C740B3142339
      60DBE7CEF8CEF2456D38EE83F2CAAA1D1821834EF7B8A606BD66572AC4CEBB03
      1B127AAF3A315D53708CA666A9D3409251941D5CCF0BEE22089C39D215A4651A
      9456B42CD05B5FF5E3D49848039DCC83707F0F7B4813C63ACA9916ABD4C479BD
      7DD67215D396727E8BB82C37C5C0D22D47B6369AEA786B6AD097CA50625AA097
      AE95684778FC7D97C414C90AD8B55E70F418CC93C27938616102606BDDC681A9
      5ECABB790005E464E25576293AD1803FF2A498484AB09944B8EA023CEA34662F
      214CE2DDDAFA05C1BBEC1DF59B8D3DD8DBA5C2AA768E481BF9D2E86BE0A7EEDD
      86A7681DE1D32DE228198D56E3A830EB8D235A06D64B6DBD1B45168EC2B46C2A
      31FEBE06B0EE5C9F9B3C4DC2E0DE3613C49CA6E385CE73EF9613F7B20F7D93E9
      7F4FA117E42D40220D60441AEDB3AB4F6A94EA783CAB738740AA48D4D20E610D
      EF18234CF4337540635C3B65050245DFF3F34F3A718683D49A85517082C48C8D
      0770F2852B146C2701DCC1731DC6522746B53977D9F11F3BF4AFC797AF3FA3A3
      E0CBDC06577FF9D4395F2787933E381C204A8D302AA2918293AC9220C57A40B4
      076A51A40BDFBE35D8B43615B01C15844994A0BD043F901A218B398932B5238C
      5920CCF2CE75C0A3D3C8270B532ECA2A2D8B9FAD8FB9A27CE90ED57370D01585
      5B98127D2FDB15621D022A58E88D14E6CE0DC0877E9048702593B91D4C3EE8EC
      5F264D0642B69FA4EBCB32588E5808B7CDC47BDD7B9D930BD56B37079C49160A
      62A00F7574ADF89F5C194538438ACCA34BC7AAEC74E1771001E7FA4C5340D904
      21197CE31678D62B7ED699C9B2C6099170A5759287AC00507A3A329CB1829266
      0E7DBC1861505D1DA802E9CF7377C7F9A24DFF15AFE84F02BC7CC1655B7738C4
      1CAD3A1CEF284484AF08F5B7B00A4A4F5447E3641F382AAAF416DCCAB1F2D992
      4C766D49381754F99EA13A3A8CEBA732C8715E738AA8CB0CA43DA804BEE81D09
      ED30B7249B2714BDBC77B6B452CE45A7C8590EAB1AF82740CEC24C5C382A87E4
      AAAD45318A0859EE8A36259C96A9004B5EB0A0A95BA234D7DB81B82E71907F22
      1A1E8A2C7B1E033974D596376467A725DF13F9FE751113876F0EA964A9A65EEF
      FFF886117FBC89876F5E6F2C1F6E1FB0E6DEA15D6195111C42839898D641686B
      3AECF722449094603350E8D6834551398390B822D01D541DF12F390E250F802A
      A87379BA6B85C48714F40BEBF136ABCD8594C14D7087B96FA89D18774120DADE
      A92F83645BD29EB84078FEDA49A67E03773DF7F755371D9755EE92DD1CB4F3A5
      596EE3A06162D49E814E643CB5B94B4B9D56EDE442AC122E7826E2EE1BB878EE
      46099E0525D10C8489491C79016CDCAD1A468F67C8E328AF16CA92CFC90108C7
      24459C7D3BDFFD70F8634D7DF7C39B034F88B659DA98C73B70BC53CA0513E3AE
      311C14C198B8D0E83E861E314C4981826C2249E2AF7117DC8D8FE2CAACEABF17
      3A624A4808F67A9501FB7D655038885F1DF2C5AF84E4F94C63BF581FDC11E16B
      8A7D18EFEE041F40DE8C0517BA161A44886CD64812F2C49A052CC1933427F29B
      99B9494BFF4188D42B54344198B247EE5D466D9F49E54EF45C9BAA337BD33DF5
      62FD68EDBC46B1CBF13B75B08FA29777EA60F705ACF524D7916A3886760EF0F3
      31550D57AABE1D19B92B78B7DDEAE8B72F6D15BE0D0FBC548B64512CEAC43BC1
      69C99DBBE7FAE1BBFCE5A8EE83A173BA5F4F78CF5DEC6E0D2520F59A4F15217C
      282A2834D610C1F53242499137D9DC51E2EB28F32BAE47136D0F9E4AD4714DA1
      E9C52242E61C6632819FD1FC344F936B7F7EEC0E18B7A9B8530AFE40AC58AE09
      993508AA58146B097D156BF2F19D432EBD5BD701AD27C5A114F7A47AB4F14CA7
      7A8C597C19EFF3248711B21D95468E09C76A78EAE00E3305C13F82876C70A692
      832A495DB0D551B1B5B59C401C669E094DD8724D104F73836AC9F95C13E68236
      B9608A75C69B3AF126B5604C8F0E414DC6039137ED902C7CF9E6961E778134E2
      EEFB12075F793E8AFCA8F6208C5D9DCDF3BC223C6F300CC36B762DEB5D2C940F
      6E6C961C270FE34591E376BD3C5F9D27017C95976B2DABC609ACC1F2AFFC89CD
      897398EE49C59CA465EBE070A864418459AD824CB15825D2F02E52244DCE9E67
      89CF1222A8035B7FA58DDE865DBDDEC0EE59E62117662DF6820B59DAAF64CC93
      FBCB9D62D8A02097E18ECB310B4D0AEC83106E6DF81DA5D3DB41047A6C9A5164
      5FAE75765A160400514FA044B2F30D7FD8FD25960A57DAD6675994EF7EFCE187
      D238705211AC20BF17D8A7119A8611BF84584F6B1617BD3BD725B3D7C6B8DC67
      9AEA9B7DB605FBB310ECA70923846995DBA7EDBAB02B2DD264BE905A7CCB64AA
      41A9BB44309CD8D51006B08CB0E56D799E591FEC1F1E3A279C57907866B86994
      3B0827264680CBF43B3FBFB3DBB0078A87679AD5EB373F2834BA118B9D8C85BA
      50000554E941DE02E7DE02F56FD4CAD219C59F417B5D8CE8D3CF0463E74E5B83
      73334F384235707C40741031F4A800223CA040545D50F52CF132B5C3794E7584
      5A1FDC4754BF325BBF4D0009A93C5762F4CCB4738B3694D723F4DF217E5EB4B0
      E51980EB05C472CC4D30E8AF62FAF56318871E1D309674ABA9645A6B680DC1A2
      A4CCB79E8414C0B7D60345F025055C81443466F71450FC1FC9FF62095784FFC5
      4617283CB82345F90D40CD1AD61268F48F0FB6E4ECE8F6507B4C1D73033381B7
      1623C3453546DC969A033BCF368166B75D2175E932636213D140BC3D775C48D4
      5192905EDCB93305DFE14F2E303C250AE4FDB92A35CBD521B7D450CBD1C718B0
      9F9DC3DD277F7F0A2A304762A5069CF761D2923E6D5CA2144C3AB7844C3C4E93
      F91118507B66F2E4134232113339BDB83C6F9C5E5C36EF998EF7832B594AB063
      5452933A804085E89142444A72AF252C9FE805A9867E386426A33AD3BA766754
      859AEA29CDA05A58EF182A2066531D07C9DC96A73ED18496A30A5910563EBB5C
      C2C5A823D288B012CD03207E6B5FE067FECC4203D02C6ECF056A6A77D6281B24
      67EDC90F81AE292917BFB299C0B898D0DAD1058378FD8CCF4EFFA4946E247338
      2A70632C52D596F64B1A7E3EF78C47F52F3F5E306955BBDFB2C7B96723DFC262
      CBB1662C610D68178E075AF2693908EB3BBE0535CC70A83AB8E9903C94B4FD90
      1429120E7D93AB4994A0BF4638E54EB0EAF0C94EDA69FBACE334CB70A808C24D
      37916C5C11BA79A2CEC0437E2FFBC713AC00D18E60052613EAF854AABA9F09B2
      D0CFA9F611FEF2611D12989157B8715559B7EB5F833E1CAA26592F598555218C
      223540AAD8FA43EF0930CE22A80C855827891D221DA9229E8411AC2E3688F818
      9B1BA09628EC632115849A272E0B97D3EAE7681C7DAE634D6FF744BBFCA1DD85
      2E13A3E5C91EDB6DB668DBBAFDF6A0C2ED9381F01A083F24983990089C9100C6
      D47FFC5D1D1C1E96BC6BDCC4DD59565F3433BEC588FE1A87A5A7D8208AB8BA7A
      95A2D2103D7F49C8F67B2747FCB3D7433F0D3E90BDD38A92A2C46C09E50DF198
      D85342F23E53DF1DFE58FFEED581DA39DF1FFCD2B8C07F2EF707BFEC3E979F21
      00B6B37EABD738838CA2BE1F22917935595AD789B8A62157F2AEE90F9495AF42
      EC543A7EF2D204933E25878FC1C67F91E4567C7B0E70A6E3E08C17188414C4C9
      D1447681C2897069927E4EF913CBDCE5424225E1B8F59BBCBB1CE1C506CB513B
      BC396E1B3445D3999FCB20B60CEA65ED569595E74E793E9928A071CE4EDAA730
      882A4429E54874429E2B044B1E820C74A3D390DB8092836EDF79C7B26C133E0E
      F2C6C81716007106456AB62AD94E4D50C40128AE97A36E92F592BCB11C418BF1
      0F4E1720EBA76F12F093ABE5E8CA8C5FF107FC973D5F56DF9354C972E4C05542
      5C9CE077AEE7679EA8516A34821A2832AE076601F6DD78BCE2AEED8F16A6B8F0
      7E9BD61FFC93A45E7FD016DDC1CDA9750467665BB3F94A0E0122E883E4948406
      C630B7A0D2C242354ABAD4AAD4FA73C8F0C4C2A008F3E5AB0A26CBA18289907B
      F3BA8C3DEDABCE2F5DF0A37210DCD91C00D9509508B396FB1DFE566B5031D7EC
      55ACF8E514995A13A433501814E43FAB11F1DC7CD3BA7BF3F21D5D5EFE54F12F
      A8A50E99BB34BB3E1A44E3238DB3D3930FA504DB667536EDDA3A8CCC694C4A6C
      12DEFA85079A6B2BBE160BC2A1F1CB3FE095EF710388BC17E7E4E08DDA390B63
      A3D35DB2E8EED0136C15EAF944442B2DE9147C65A2641C12D3DBE69965A263B8
      26EFD9785C12FAD1F618FE429C6A4DC7F92526C9EC61FA1E0790AA3B5C1CD1D9
      4A8FACFE3845E93562A979A22E2E2F3A362DD0FAC9757AA0E70118979A68552A
      E1DDA7B4993E759A5D440CA89C833300F391A15CF827EE8DCE04C80856730095
      8828190D5C73AC23D1CA96FBCA952556AA833BAC5455C0FC373104FADDE58B76
      9F0E2C47C7A4EF8E35C888004A5421C5C3B113CCCDB5C32C0095A4876555D9F5
      0F5A0C876AC013E9CFAA3449B270F6C47CCBAAF89FD553E1E36E130BC6E584D9
      F6DC555AE30AE4381A2EF445F3FC0D77EE689EFB8DBB1C5D1E0DFA3DF3BB042D
      4EB968BA6119C1D945C28A9724DB94D3BF3CBF6C7F3BA7246C55BFBB7CD92252
      CD20A094580D93B5BE434320F13834720FD84FA5A40825A652E0A090C447BE9D
      E1A945EA870A39BDB820F177A1E7D4338792150800E11F2627F388D64C02546E
      DD38F68BDE7130F3C2714813FE8625F43C5A5833EADE221566AEF5E36AE1B702
      675F2D66FB022BE57B8683E449416DE3CB343DE1CAEFB8A6BBEFEE9FDEDB434C
      EFED61757A260E7436737814C9D7BEA362BAB2966EA7A5E70B3508F3C8ECBE97
      3EBCD2B4AF7BF6CF9EDA91E8AC43B5ED2A440E016E4360996ABF938C8CBE469A
      8895CE2577EF1951790F5567D9EAD8EB757A5CEBA7767EE9B6068DD665FB64B7
      56D602AA9DCEC5D979A3737136C07FFABB35D52CF2447DBC523BCD8F1FAF766B
      AA3B5B65E13853FD553C563BDD0FFDC12E5F90F6F9C980E82B8B6CDB49364BC2
      CC5184767848EC6735F5AF81C9F2E3221E8B7417F880450A4932EC9EAD7FAF9A
      ADA33E2285AFD5DFF8DA5E745BBFED3203C8D5D9295BC2527CE87D4EC6331D45
      869A21AF16989EB0A635C231FC2FFE1DAD55A74F6B352DE38A7E2AB07B75643D
      7CA95CC1720950F728095644E42E32CA3FEF7875DA6776B1E5A8391F8526CE5B
      49842213D2A4EF5D6928C551C378927CF1D26EC503457ACB91DADAEAD3F77237
      C0B36896DCCBB788AFE364F90D6588BE9AA452A66A6193D572D5F7D552D5AC18
      D52DF4439311B683EE4128E68E223BE5DDF7EBEA59EA50DEFCE037BF3B95B577
      76A65224B95E63791FF00A4CFA90FCCE5B0575C1C2A4D7027EA5DE861CEBA69F
      9D2F8BC35F534727FD268A62C31B3348C3E9D4A4A8B06A1C9DF47F06DA3A5F7D
      5C4C531D708A9E595F6B4457829B42A48EC4EA43056251A517A523D2256FE218
      76182EB43700D1EED2C9A74E5BED9CA4FA066ECE278866938A2B47C5612C4106
      6D7C6C0008906AEB39265BFD8CE35D96D2396AE50230822191706700AACC758F
      DA2554A04175BC46597A32DE2360A07F9A93A581BDBB14B1AB73F81D28F4F8BA
      41D0F77CA5F2D052AB9681124B0489B2F17A9A445103FC25F421F95ABD709B98
      E5D93385A4AD5BDDED7D44F28E8379302C7F2E749C1773D5C9322270B427AA95
      648FAB2873F7C13353CEB288EE845B08AB1788AE912AACA8603A5BAFFFA8518D
      18A1E72A55682364BF02EA5411DFAD79DAC16FFED1BFBC2074B2EDA984141D31
      A43FD3EA0F3ABD73D54C73809AE7A8CB129BD8DDCD7AA54F6C1807C4ACB43330
      69AA63D54CE73AD056B01D1CECFE4930772A98B42D1428D307205F54A74A508E
      2790FE72E69A7CA82E0D28CEC903A864E5B9D5C616BAB56A4B434110493F170C
      8936C76FBD233AECEC9D1874A823BC709A20080DC497255483DB572980A4E6AA
      34813F89481B53DC205B1086921B6A436079171AF28F3384444BDCF1DCE4B304
      D66C3308BA1AF5FB82C5CE6A148C4118190F6DF4F58D1924F8A77873496AEE9E
      BB0AAB367F4C4AA13766C80F425899F6293579914AA10253F7CA3B883DC064C4
      08B13C53F2C31EA32FF051B86C084F962B58957C6C6797D9AA096D59CF0CA023
      989BE3E49702AF0AC5322A2210B17A8E57E9DCA2AC5E9D2E47C209BD271B1AC6
      D37E31920A2FD2B9CB116117F7E8BF48D11FAD3AF660348EFDFBA45B50E57274
      417C6AE11FC63655C4960BCCD28E7E6272FA07FEE4A79181CD650EC053A4BF69
      C086EC4EE318C2149C912EB9F39E4BCC5CC24A856B591EA98AA64EEFC24A03C0
      CCDD93B72D83BCCB0973BA9F50A596F08492C3A1CD34D5B385198793702C94F6
      B480973B07BB688E3DAB8F082F7A3F1FCA93CF1A57C5069203338E70DADDAA11
      65AF051A730B0451B9FC7EF852B37B5A6187DEA122E766F7746FA19FCBD2F955
      20BA0208F95CAE7C826576B11839919C2FE645061A652E9E48F6DE350B57A324
      B9AE8764A796B01621D3430BA2633D362726567B7138A9805C98731DBB090892
      78DD8DD64CA7F870D9A788AB19C7C63D074846FAFB7B1832C4C54192B1D76C75
      D49E99DA4E292050A359BC575DBD58C122E38B57A946F0E64AF9F5631C98C848
      EF015BAEEB947DF699DDE8423EB5C6809727EA5FEAEFAAFE6A7F7F7FDFB12432
      A7203304D86EDEB22354F799AA9DFF71F07AB724CD4B1614EF31F5645297CFDF
      71539E877ADB261B1307C139D8FB71EFD0F3E68B870BCA3BC737F44E5CDAAFB2
      0E91F0BE8F79E8BDAB6617C2E7BE819304BBCBA4A18E087945D0BC72D83AE548
      B93EEEBD2B96B1D603B87802EEF2562546924C01B5B8A383DD8F12CB00D697AF
      52C1535653DD344C52F842C984A98A1242751D45C9188CB28291FBF25FC47EF1
      9756D562CC9287C9D2890A1BA9A5E5ACD2A3AE6D84EF8D59233567CE11E23017
      6A7669BE4757FF3D2CE1904A04FBE00C4A55DB10418CC43501D98D0A10D1372C
      8B4E49F1CEB026BB8304A5E3CD136D2F84386A677F6FEFD5C16E598E28191E0B
      BA419FD7F231641499FC3758FD91905300295BC4B13101FA1842E437C763F43A
      836D4C0A1E84A0A1DBD1B46F7E2F480A6CBB8603E6C8FA4CDBFAA207DFE805BD
      DC8BF382CBDCE4770C22045C053FD72A65382B68152DCD4D72BC0ABB585C5C08
      5E1F4F1DB349CDFF199698A666CC42995F2F77AB41FCFCBC2D760309FC5C73E5
      42759C85859AB2EFB1AAA9DFF61BBF1D903E9927E96246157811543145457090
      9953BE3E466051E96831D38D0FED5ECDF529ED7F68B63BBDDF2E2E91A81E9C5E
      9C947F12D5D878E44EF2A5A11ED2A99E064914E102A354F4563509D1BCF3EF10
      07150EB4DF7A02C73287DDD68C43966ED96757DD44CB20FD9F9025A4A2A1BD6B
      3F56A35FEFE3C8FFAC3E701B88B2DB0051D6338379C9FB42C3E7C0349313C0FC
      E64E386F359F5EB9B2B044C338FF2CE81E8C35169008422163F70952B4A3D9F5
      39C225D0AAE5973D4DA78D46069FD9DCA6EB82533282B076E262A42B812E7415
      BF0E63CAD694FCFEBE32C0350DF8AC4E99AD7EEB875E710F060AC4AB2ED6288C
      A72C5C34D25F0B53270D24C5E364B45C870BB9602C6358004649B27012368C2D
      9A0D57D4539A248B958D3BAC4423DADD271220A4DE5D230BCBC4EE28398DE76E
      F70CA46C383795A87C6657E488124980BFC519F4B9E0363CCF5510A88BF0ECB2
      7D9104E6B36ACD808C7794FB17610F06C6D965DB75F6B808191322BFF31BD55E
      7167317D161E0AA91D872504D95966CF3899E8176085753486245F65A86A7717
      43D431E36BC6AB3AA9558925C33638EFB7598ED0E07C061F4CAC3D06DFF88918
      22B2BAB55E4BA7244FD479FF83D18B3FA38906F6FD3EFAD877967E991B00644C
      C3CCFB541A6536333946F0E9BD7CA59B269CC7E62FCAEA4238668ABAC1CA97F3
      8447E6876E110FBC97E8B64CD4EC4CF0F7B23312E9294FF3B5D2A78573F244FB
      5212EA4AEB4EFC89E8D0B890884C34E1A8976847D90B49B8F681F7F60BB7880E
      B61CF8643D9645CEE46D021A341F51A29E5CB7977F7BA9762AE4D236C97FD71C
      07FB28DC41BA27526D3A8707D4707D9BE0E14CD0B767ABE9678B28CCDD10F665
      082CF687513B75FAFBBB0B7572B40B18571214446710539BE86A670E573946EC
      6608CA031E0BE378AB23C62AA752BD2FE5E337C0BA518F0C0A43679832490810
      E5D9E89DDFCA98BC6AED70593251B88C211E59D3495DB9A3A3A1D0FF42F8C948
      E1BDB70DB4382447B2FBB227F53E6B5E0634252CB9CC9B0D86D6E165FD8F97EC
      9A10C109B5F9255290CD69EED4FF78F747148EFE57F4C76BFCFF64F7BD4AE661
      893EA44F097BA930A30818CE3B5D42B1738EA552B04E887BB81A67919A3A876B
      3CC3081436D7AEAF342E1668F70332DC69C579D7B49AE82833D4D3445A00A91D
      273DFD934151815C15E27878B26CAE95DA4EC36CDFA160F1841D0A0633302A22
      54662CCC83580AB35C464C4D64A8C800810C695DF0767FFF6FAE770149BC03FA
      45C9BCFCA792FC2398500669C669C8A27D5400BDF3DDC1E1DBEF4123A7883701
      CD334C6CB2ACA6BE3B78F5F647420A5622B0E02BC69F5EBF7AAB026360C72ED0
      900671090A3BE830F22EEB3807A1F3CD5A699A455108AC18FE8BCBDFDA2A35F0
      B336AA05054F56162EF15432991D473BB871AB355775757C72D26F1C9F9C341B
      C727833E09166E9D1DAD44BC79B636B97CFBFD3BE1D2827CA268EAF169FF8305
      01960B55739820CCAFDACE594C383F216F5395EF50860C9515A39F457A078453
      B3DA843B5A5A1E554ECB596C5AADC214098E3FA9E0DE0A91859D7E774FE73E27
      4E6A8C575716AF8E8623637CD231DF5BBC4B385FA4C90DA5763C8D05848BDF09
      6DAF3DB874FDFF1546FA46ED1C7C5F1F85B6B4D8BE768D3A9C1FF52D00E93FD4
      C1ABFD725DD759E63D8BEDA5BFA8BC61E068486CD16BD9F4E493E1AE59906D44
      4777EB6B8D764D4AA23D1E9B77AABF302628A8271D127E49EAE0BF423FF4E4FC
      F56B64F3EB402BDA8D3B9CF635F5539126619E15B1A992DA0BCEB5A5B3B10E42
      BDC6724FE71BD936740D755CF5CD349FCD9324ADA93E93DC7FA24E2028DD16D0
      3FC551FF0A027B96F6755C6C6AF626529F291D2BBD4E89F6D67304680D54B35B
      9581C673C902412F168A39353013BD4262CC329411193E59C801F1B5D78905C8
      5378B28E0254C96AA94AE181748BA3C8D8C27265D9E9108732141AD378EB98D9
      6A9985CD7751BEC7A2C0BE3B5A01297109D1871F4FDB6B8628E2B8E4CC8829EF
      97E2FC0A7676A0AF99A2078697B9458291C9B185AB9E64D689C93726EA355617
      D9D197C71DB5BF7FF0920EBDA508827B8A77FD95FFF89902EF2FF77FE04FBDFC
      75FF87CF2FBD86FC0844439C0F920FE616676E9AA24E868C9E68C50D972989EF
      180D18DDECB5B3D5FDD975058FB949110E6206323042E5B9D84664D14F884338
      B45A8AD77E9E044477F164D338439FC47398F7419A2C02C07329FE2CAE61D5B3
      96E21D8B8EC7A9C7DC4324D8BCE150F7CD295F2D8054002168AEE1D7817E8F3B
      0A3FC918142804010B15F1E749A54E5C2AF97772339EC57216A85D30C300517B
      45BC37F92C29327C0B828BBC22723D2BE496BEC002B21AF19FDE676B9333A932
      2E3605F1C32C4357088272C43AE27405445085B15D1C8E2DE6D0FBAC7E2EC2F1
      354A0D98E09037870F073BB81FDBBD976B29F93B69F74B49AE4397E4DE816BD4
      0C7CDEA402582B5D85474A5B5AC6F5C629F09A55554BB77A6622629B95E68B61
      AE92C23741B75ECBFD19700F08C13D617C22CEA408484CA251629C14893494A2
      6926452DABD148B4CA779E6C3E65DB963D20996C5D42B9789D5B332E6CD0967E
      5DF2EDF48B515DD05D046D2288CE5374A678F41BF58F0F3E0B50612DE97E1415
      A6FBA43EC2DAC5E3E634C46749AD4146060D7055A7DFC5452B87DC2A5CE8029C
      544BD6D5B95FF89B230C75AA092A1518D0B1551E5EE2B41516516697B494F8F0
      1DEEA24BBF79F420506DEB4E353E54794A391C75D5EBF4CF2CD568752BE9D771
      B05630BDD554BA2CA4D73B62ACD10EC7EB94AD7EBB28CECAD71D954783D49371
      E12EEF3B286569CCD4AFAC16DD5932B7A81A51B54D2A608EFFF3D91225850936
      08E6E8B1F5FDEBE41B7D936F772388BE8EC8BBF85C021E97C4E8324924CDC419
      5EA3C6C85B91086C0EE3646AC3BE17B1D300BF7766A806BD3148C5BA5BCEC053
      C75D8061473B92362680CD1A76CE7E2BBDA12A057054C10FA3672DA972762948
      77FA15E634AF4E1B17CD2BA6420C10AF477BE2FBB9A26A2E3E36A20221AE0F42
      4378E4BBB908C02F26D81F0C1A6BC40B2568A0C1C51F1CF3DA861BA4D96E5F34
      5A976796B1036896E0142D24CAE6484F497C5807D55C66AE8D81C182F69C889B
      3D335790ED3559A61AAB03DEA9E2144192118AD8AF94B12CDD6003B364E220BE
      C79F504143CC16A7FD8346EBB47FF867108A2D47C788BF4941A5556F94B7E1A6
      6C840C23C4620987D9CE00598E8E56B9591BD1326E52AA2E776DE1B6F04499D8
      4856BA220E3D1F76A16F509DD242C4C4529394952B33181DF11AF4C1B7FE8F8C
      D6E5E8B848E310028CDABFA1BE8047DD8E74D23E5C8FCD1489D7A77858FBF2E8
      1F0CC4CCD61C95ADCE642B9AE704A5E1FD43617D324175E0D4483214A821CF87
      23081001C75292D75C9865F9DB32148D4881836B325E803A310B05E876676990
      861A703F7B9CA82E9C4E125BAA77A1D90F3212BDF29ACDA7C171E71412B8622B
      71ACFE4F20E0EA9C9D0D87BFB448CF5865B69E0D68F09657317A157797E2C9FE
      C4910D618D9433709EC4F98CE00074CD9871A3F5939F5ABBFC78B1692CF92574
      7A9D8E3CC8168E889F4AA448952AB1A799F8A7E6A027E35584B4C8633663CEEF
      CEC3AFD8EAB8FFC19A320F92AF7DEDF0F5FC9905F84D97A33E45406DDCA2E4A4
      F9E5AC77F6FCB460C47DE5CEE1DDEC5DD5893C05382B33AACF8D1FCE900777DD
      C0A99EBF9DC4397A456C7F1888E3728D64F6EEDC38B30947B3737646C4657E17
      66405CE7D287437DD0196A647290199E5DB62BE079F1ABF14B02717BFAB483E6
      603814EA26F82FEB8D6893B844637B8AD50FBDB22EFC129DD1D6B855D1830D7E
      B9A74326B7947DFB6251A32088A06D6C099E44B6104FF2DC7E22D7AD4BCF8BC8
      7A90706DE8ADC0ADCB06ABA3DB0532609BA12C983C292A1D606CBD937DBF6D06
      E84A727B00D04ADE70F5D8D20FA912E00D9227F11A31EE70D8FDA93D180E89FC
      322D16B923B7BB7BF288ED0019B98FF751887CE3A8AE4813FD9B1B84063E4573
      2467E78BA4400A46976B63096DB869D51613F8A5BC5F7D0003F3441D905AF10B
      AA9CB421B0A54C75A3F094830BDB38BD504725591DE9257A26F2D49E3640F7FC
      1E2F7DDBA75EB471F52D25CD45F39C19916D209265C1097E2587DA9562B35EF3
      B3F52FAF06C361BFDB69374E7953ED04C85CB383FBC17A3EF62E86C3737E2C59
      35143BD97EA95A9747FF180E5BFC60E291E4052973F11B4BE36BD0FFD26FE164
      BA826DAA7427C3757F6F1F6D7092623A5307FB7BFB7E97A9D3FB69385C8EBA26
      BD2E793CA99EEBBE1882D718A09E180E4B027A522D00B22225B8461D447BB241
      6401A9253D6CB78D3512858E3B5E151BD3BF6F4D63FD99F7527DAEFC7517A8BC
      CAA73BE9C9549625730DA1ECB70F5D61B4E15064B515E4F7F503E0BE05C912BB
      E83EFE54B3586B0FE2DEBDEB1A7F2060C1C7A24DA4DB34EC538DD612B6170B35
      AA164D9D98BC95867373820E64652392677AEF13939FC6133D5FDDC39F9C713F
      68AADF474AE6CE6CD125AA3ADB679A23F1B9F7408EE7845DD59F2885A15BADAD
      F7EBB83FE857FD190A9B648D669A220FEC84FA93BD311A260D87BD9376BF54E0
      8748B4B10DC5294111FE441126BCF03A566783CE2F8F76F08E2F5F6D63AEDFB1
      F6F88634A9CB5069B197C276BB302B7C90E1F04E4F07B8DA6B2CB5F78FF25CBC
      E348230D87A717AD56799325277F0154B974ADF63CF9A741649AB19EABBA7A41
      FD620863F682FD472EE3A11E3AA315A110FD5330A0366E4808414E9CD44EA139
      8D252ADEA2000E03380FF5901974B34AF31B9D296E00B655E8AD03A7BBF5440F
      4524D806742AE656F69091F51CCCCCE7166ED06C7DE85500D7E2B8066A67A617
      0B134BF951B6D40B02CA800A66779BE8055E9ABA5EECC05F45593A28ED044589
      B610711845B6F9E856549473BD60308D6520B828AE351A23460191766DE22437
      50BBDFCE75EC77CAAEBA36B807EB14F15C67AF6E9183BD3A0763604BE7668A56
      45DC5094720EFE7622481187C3FE45BB6DC3B6770CEB3F8F1FBAD93BBF240933
      1CB69BE7D4EC4E722D44C908E38A7469996681D7475A8453BFAF9F9F88F95E4E
      5401ED6F61D8FE2C6E6028A5E5993FB33389A04A75081523B9BA914A51CDB390
      C5CE741A7036BE79757A5C2D43B145C44F3BAC137AAED202189AD3AB4EA33BE8
      ABB27C748D3EB5DA9CE6496753BDA8175F1891C3948EBDDB3B9B7675614F4C41
      BD19A806F56EA8E339E8776D6C67A4B3707C0F196FA34AC6EBE7FB57EA8C2ACF
      B740A93A55A610D08C587C8951C2537D77BE5EB264312E849CD87AEFCE5A0324
      C9CE35B84A25DC0913644414F31CC8025539648CEB3FEF1910BD70FDE1100F6A
      742EAF7A953CAF3070383828BB2817CD738BE351F8C270480A96C04CC3E1AF87
      9F798A8CC64D140263C361339F27D982CA7FAF9838269C3E414866386C9EB52C
      FEAA9B26447C044037681792092CF9D05A5CBE9835710425E642439940FDD23C
      3BA9E063FF2466CE3BB4737541D9DADA2CAF5288F584160A58374BAA8F92E45A
      B58D30EE255F8ABF3F621CA4E4ED3DF57F88D007A9FE5847865304DB3C935A16
      07899A22A7138EA91E22B21C4BD0185C434A043D085F001C3C07D88D4A7BA5BD
      98D7C8B87A298303297947B5EB44B937680E3C57B977DE544C1D85A97F32C885
      AA7E140233EA9D96FE75BDE6EFB3F7DB5A6A9CD844526922153EE475107571C6
      14015F12D8DB1D1092DDFD7C15192133CDB661316A15599ECCE55613D11E4816
      3E6F60132C77180950FEA2B031403471927A6B9DF82B718800A2DEA51AB44C3A
      238FA9DA6064142AFBA9582D4F00BAB69304BEBDD26EC62C55CB809B548AFABD
      E66293A3F58DDDA82EBB5B15DA90729FAC29B40D552DB1711B749D277943CD41
      AABF7A5D1A5C7F11CFE3DBC6C1DE0F6C7C13EB8A6B58A352CBE4B8051CF64BC5
      C5CEE0F56BBB726440C0B616595EAB566626133FB1751E8294CD15EE5B970D85
      5F6824432BB551FFEC350E0E78857792D82BBD1E64AD5C571F573ED5EB798C8E
      0F5432CA12F2C5BEF6BCAF1D02D86ECCC2C415526996A3EA91B1BAD0EA0B3198
      7000FD87403E5D4884013E2B46F52D789EEF721E7AADA5E349643C0E275E1A8C
      2F7828A7F995C7F2E48EFA9C6E6C1CF52DCEC812B545883C25B1CD0FF2E05F76
      D51F399CE3A4E3320946A9EE4819D908AC75ED55ACE7E1D87E70778BE11C8956
      948009C8901765722A7F84BAFE721CF42B8F27923FE4C2A248DFCADAB07545C5
      10423509F6CACDA2FD6F7B01475F49992E21932590EA1311AE3EC989E46E7765
      00E27219FFD6998739FA3EDD9CEBC56F74B47E3BD65FA2FB7B943411C2A4A3FE
      2F0FC4001F25E7D479C22E3613CF1171EC0651ACB7B546411A2A5629CFC716B7
      F438BC05C127A520E0D4381AF1CAC9605868122B21CBEDEA08BA8D1AE4849ECD
      A68EC35BDE5CD758AFFEC5D7ABC825124B5BBEEF9A4A660ECADF9A606BAD4004
      5D391C604FBF61859E94E2B2BE71C199515A465ABBEE7C341F6D77597E9DBE50
      0F6F65235739793E4B8A2AD8A4E621D3A3CAEAB319052C3940FC24ED45929B77
      C43696915BE628ED93C924649E90248932662058298D5E829315771223D5C38D
      EDF4382F74C453CCF28429E40C33D7E2EF58668AD50B271591FC524B1AAF5963
      BE9D93F346875ACAA1CC8B2681E647215942681EF52D05C2958E72CCFEEDC95C
      05125987591E2CC32088CC07767B51ED0D560E87F923F0EFB5511F4FE1B42528
      594037A5C5C26848344ABC467E7956A974A6BAAD08C48AE1245F43E752A70F8A
      2271F711E4DAE1254A8CDA6F506491B8D1C392E83815BA01375A49247CFEE45A
      9339B245D9902DA965574593180927EA8565540E5E504699716A5B00249D967C
      21FE31AEE2C73836A83D47B0B70BFB9F0B0B7B6692BDD89217CACC1749AAD310
      E11FE93D008189534C2C624C70808469A3D9EA75280EBB7053D8C619EC777EE6
      2513620B4800D4EAE3303F4DF1BF10EA53956AFBECA8D7A0A2426118E0BA327F
      E4A330ABA26F76942CD5DEA4F8A3EC9144BDAE1CE9E34E360B17D55F903F7A64
      F299C902ED9948393D960BCF39868F9949C5353C547F5707AF0E5DB86707462B
      DA77AD14F24C66A307F2A3A3F297ED0645004A04CF177AD1783DFE4AA7E8E92C
      66214EBD6DF3CC54A5FEEE59D39204E1A1F90CD1118A6322B1A096F8573E332B
      521C41F22DD2FBB11C5B448E287C2462F01299AB7CDB05C6DEF9498C92C1CBEB
      FB55D22FAF07086BDB9C422E7C4224F0E277D036BBDFEDFC7B946CD1A8A63455
      BCBE6EF39D7EBA691D5EE127682C8F9A5FB2DB32BFEC94246A9E581614D56DFF
      18C0AB40DDE3D8C2FD1EC338410708077DB1271B34E11ABF381F2F66D5E43FBF
      99A64E3510FF4325D51676E07707AF0FDF20236673FE778A37B33DC77238D7E8
      E16C6C9DE006D7EA634DE235D29856AF03508A78DEAEC011DC921932466CAE47
      3C2EB5CC09F02735D6D41512B84BA676A258679BC8AFBADC88638BD9616200E4
      0D87EA97C1199007D6EBD1991ACC907C5267E6C644DB8D4160728CD16C9E4035
      93416DAD01AD4E3EA2A1BB657FD028DE1BCF4825C5C9B2DC1589699D98BC0158
      2855B4321A138617D300E151C280E739652215EA17D4070D2E6A5723AC1DF797
      7A814AE7DF5C569DA20698A4BB690429F75EA8759286CFDCD9D26694357A7A23
      A6A217D2879CEBF3D123324F08415783133C459D1C872DCA6643EE67A9E1F2F3
      F07E6D9E9D7D5E6764808D250B5FD231E48965FAB22D461D2E6CEFA906FE4424
      45100754F26299F0C3DC1E120A464A666566D44D88EAF0242553E30615924C42
      40408CAD66D5EB341B54CD301C72C7726701D2BD29632FDCC9114489D26D6DBD
      485B192EE3A41082E5246AB47EDA6A76F0FFC6A9CE6612E421AF9718316D581A
      CDED53359E8551909AD86FAC8F901BDC3C2B509737268D186627EB00A0F28C68
      0451EEC8ED2F6CFDE01603F2BD104219B917B4CD7932454320D79289513E3810
      16C8E61797B10C52C7546D4BCE2EE37DB81D22705AF85DD9EA94E859A3A864AA
      CFEE70DCEF6D37133045821B3ACB88768C5A24A2CD54A24E7A1FBB6A6638AE16
      C68E3193EA2B34E3BDF22491D6C66CFDA3351EA0FF08196D3F31EA28A333F529
      45FCA4921724901DEE8609149AC3666A7BAB227EBC55E15A2AF68CB09F4952F1
      2137850F9BCD3E0243444C5B771E852B0539877018F8032D31853B02252D2BA9
      46CABDE9311C6E1655E11D5EF73FCF3E3AF893ED230989113DB95C57CA617170
      8749AFE8B4180E5D5881854E96B79EBAC421AC1ACDEE298F4CC42156833060CB
      36213E5A091E3F07FC27AFF0FBDA4EA9DB18197CA83AC7BD73D2D29DCBDEA9A0
      32E06F232042E159201769AC2D862A8D96767370381C5283272561502EA661D8
      05F76BE404082D7D8C1C99B78EBC7770791D4A002831AF14EC2B4EC94120892D
      F864A3368743AB98DA868B2B50E287AEC174B288C3E60906B55AB0972C338459
      8B396ADA440C735ACCCEEACB5B00C4CB717750AD20DD539FE8602C2155C0A3B3
      D4042D455FEC308BF488A4293877017C84F809818A88A8E45BA3EE8F6FEE9EB7
      6C38FCF37DA7579F05ABB2E6CAFA3B229FA9480025881460671C5F89D2CCB679
      72EBEC72F04C4F86E3381C22AAF92F947070E0963AF0A091160D453DD66DF2E2
      4BCC15DFE20F32021D4C2E74C6C8372C21CDDBFB82F27CB883F4FC66EB62EBE7
      DFDBB9E379F6FCCB43359FE110BCF9CC6D97CB7A69F80BE73A43F331D4B4F8BE
      C4EBCFEAB47D662BFDBB0079532DC9BC905884B91D4705C1DBABD5EC148128D9
      39A962D9F2E76C33958B134BA3D41DF42EBE849FFEB687CA69A32E70DD4FBD27
      7AE87DB06FB51CD9069A74A43F9C0D7C87C059EA9EFDD396C735B13147D818D2
      CBDB581CCF704059D95E1EFD0342AA757AFCD37A10E934E688A845BF2246B0F4
      5E7E1AACC2AA3AE89EB66A5C2B4E3120C98A10227B1B3DFEA977D6A6F7E1D2AA
      0EEE015A3E203955A29EC8A98E13C01AA0D1CB4A07C9723E99893A9D335215EE
      046EE1945B792F470812601FBFBDC2E0CBBD6A365C9FAF98C63BDAE0C777EA94
      E9CDFF1707DFDE2B1DF207DED91E09F2975DFA68C93CAEC63A4618908A7F9D9D
      3DD761FC1563FB4E26499C72791E710750E1B20450F9AFEE616815A16DB30CA1
      A4158C0CC321285C81EFE0D67D75687114BE3478BCDE29A23AF8838FFE6752D0
      33E768AA066B0F21DF07BFD1B905226493B679FD33373A7DE8CFB4A3CA6DE9FB
      873E9B9AB1526A634F1FFCC691D9EC8172FFF07F975E27489BEEBC649EF03D93
      CD5FEE7E7542EFFEFEA5D34ACFAEA9FFB1CFFF77FC04CF7A699FB5D5C4AA2FF8
      F8679A7873AD7DA227F3BF2E2773B0AFEA56E57DDCA8C2A4038F4A4C74DD99A8
      63335287EA70FFF08D43CAEFEF1DEE1DBCDD7FEB4912F4DDC1EB7D8C5F0AC566
      F7F4A9647659B479622AB4C02726971A07A1B3A0B830F5554C4D964400794B2F
      15CA826894E0B336453B475FB5B63941026608F288635762D7651078F95A2350
      E96BE2C02808CBC409582198D0E8C9D45C09C46A06962CFF7462B9333700516E
      DAD4079D643BBD800492C08A8C581DB5EAE1570ABEE4DA7FF598BCFAF1071C53
      9796190E7F6E7FEC4AB0848C02EE4373B077F07AEFED6BEF51D057EBCB9EAFFF
      EC5F7DCD797F6AEF9DB20FEB41DE990ED40B6739BF50A9844A68FBA8245394E6
      98CCDC32A040618C27CAC6A24F8C4B241DBB1BCAC6E42B57927579D4EF28F7E7
      6D86035388242796234B4446AF8C812214BCA6E1977BBA3CD211253FAEE220C2
      63D8F281A846AF58F294B22272AC89428D7A4DA2977D9B856C085BC596C30AE7
      2451A9150B8240A399069F0B7F98BA85F6BEFEAC8ECF2E2917DD3D3E452EDA16
      EA306925370298AB701B777D238F2B2BF950FF03DBFDD7578DBEFA11E139E987
      43CC77CD41F3E26E13D43FC34DB0DA6E478B9E23DB50FEBDFBCEB5A703ECBEF2
      9D35A578EF77DF2B9DA1EB877D44F9AC7B3C08ACA8D022598B7B022B5C52097B
      00054E0A9BF90AE369A6A2F01A141772DEA5D08575AE24DCBF62793FA8BE36FD
      A4F74A5F4330BE53833EBD057E78AFF408F748BEFC4E8D9284F86AFFAE066981
      EF8CFAA4CCAA7F3946A7E5DDCD45B8575592AAC2D22CD0CB3BA80E5D13C54971
      1FD198D0A7A0917F9CE27FC46A3CFB22609FEE19F8A15DC8F823F8097AC71EAA
      6D664149D69131313A233264193BC2B4B8F6D3D6C292369ED5C1B8F3893C7F6F
      7BFBFEFA2FB3EF5FFDF05A4C9A379F99D42578F6D401C56CAAAD96FBD7B020C6
      C27DE4F5CCD3D6E5C5DA334F412A440E2A45E235C407F0C3C4EAED1780075529
      E5C4864350D456F150F6CC6064093659DE0DDF8D79FBF6619B700BBB8F8267A5
      66750C21034B8EB24EE8B7CD484C196E475AA3E813A16DCAA5BA83BE28E561EB
      A76CAB602DE95CA17103DC3BBA018A19C81BEF30B3E4142E2E079D0AB76CB1A8
      DCA06D1295FDEE3F24CD6BBB7E7F95F9FED10F1E0E8FC162E64C2B389B804F58
      52BBAD42B3B0D4F7C6E3B1949B6C41EC51867A87C38BE6F9DB8D06A3589D6D16
      A2730CF69B35E2DC4AB0DD5AD6DBCC9C4FFFA7FE59BFF1A97FD67E824782F367
      3824A69FD2F60740A2CCFF6C15B83FA93EF7349EA22D094BB32D1F2DD7C43E1A
      3574DB3FF45F979715DA6E460CBA962123A63B78822BD33C27927676A8EE9237
      D548A3C3F76134A7EBFA52CE679B1DEF5DFEC30D8E9DDEC2C9E2B7393EC64ED8
      0A1B5C57508A2082B4C55351A864FB5E9585813766168E9F440A08FB7F9B24B8
      004709800C402181661F22ED7AD410834E8F48D7A8DAC8624DD4B95E294D7181
      AF60341E9728461997A340E50EC183D522D926840152456C282105F33058D5BF
      4453FEB8299E9E9FF41BE7CD017278A5DDE1F4D0568FE6CC2029622B0AB6945C
      5CCBD64D13D10E5CC7867ABC02B5651362B3909C20F0DFB1498A2C5A51792D9D
      FC3E9A19AABF111E496ADC888A607BB3FEDF7F9D59FFF69563F1A9988E12B5D9
      D674849023DD769FAF806C5066F94B6BE432D8EB83463EDBDD219AC3E53102BC
      ADB3FEBF86C3ABD33E623756E4C25464C258C1760D87407A59BAEEF57688A220
      08F70AA870A27D81F74EDB635A6D9040DFA7E9BDCE50F8179D21290D2035765B
      2C48D68ED2E4DA70A214ADCBC9BB12763ECCDAB50EF43EB45FC2B0DDD7E8F61B
      250F7A780F871D96BBAEA7681145AA1317F3278B2552ABF0356F8003B394277F
      5C30D12F82798E36AEB80A9D5B443108BF1FDE6EEBBADDB9E0AA2E06D6B75D70
      AFA33FFB8B8EBE6DC663D1E492454A5235374158CCB76A3C2D7D121511705AC8
      01F81F2748F84DC25BBF24128BA0A7BF3DA0331D0ECF5A9DD65782D58F7D200C
      C413930317D38DF48AFBE389FBC54958F03F0FDACD925ED7535920C0DABC3AEF
      02B40C17C6C1173142F3EA9CF5982D81624E078BDAB44E033E07A2E12C47A15D
      3261768EE6D5B9DF26517EC376FA405BB9C170F8E9847A1FF52199FCBBD24B9C
      E3E90F40E977708EB9757472F14EB574AA6F74CC50912D7C077E3A9A2571EEFD
      BCF709CB0F09F93BB57AC9503107631C442B7E450C64639F665DC19E9D9BC898
      669EEBF135CDFB1E1AE7BD2DDEE5C4E4673A9E167A6A6AEA34BB30B7792B0A17
      673A03FE32AFC13C894FE3CBF4B2C82F27DD6469D2663A4FD20F3A13E01DBE86
      AB61D2D3F8C864F9511146414BCF17356ACD929DC69DDB056A2B4350A49F66B2
      17CD1B1D46089AB1137A9A7D443CBD19E5AD22BD3103A9F7BBC358BDC5ABDE7D
      3B22605A713B12BF453C3B0034CF76623AA8A9B3C3EA2F0E6BEAEC55F517AFFC
      D80A93008C3CC4B28DB24DC79F1999789ACF6801C3890AA19798838BFEA9A53D
      C136E7E314FC5B3D9D12818765FBC7D0D7BCFBD9360F17B658C800A571AAA4F8
      335F6DFD503CB3A69AF379828ED9C59CE4768DAA09674673B74EFB434FE7E6E3
      424A5B2BBF6BA3786D69F42289EDC47CD9BA786ADC0E0AE2BC777EE9F59C4EF7
      F8D066E6B41AE3AAA89CEE4AC83043041570E0A827DC1653B51293C51A9EEA8D
      16F9FEED33C8F9FEA2600E93AB41E717E10E17E84C853E3948500A6F0DA3D0B7
      5E988C952B890D110196845BB6C07C734BF491B5B54995426337CF5A1F86C376
      A73F508B24A385DADB621834CA914C02D501953D5729A9B891E1F0C61857BCED
      E0A94230F4C86E918BE3DB20AC031804E8BC3B4E3D2AC716421B9A40A577D398
      1A73604A5B79F0968D5A9E5AB12C2B7D4F2C2A389B69E4862A1FCA001D9BDB29
      C301A1B597EF6E85886A5EB4D70226B6B386444E1A3D33D1E88157E319AC3B43
      EC24735481D795889A7CEFF91BA0C2487EEA2262872195E1C946054F455050AE
      0C7EBAF52812BB4BB2704ED57BD6724B68A5029EE79E675E4F13CFBBC14D8403
      85280E2B0A44723CF3C9EBCE76F5BE105215D161E21BABA9F30FED418D024835
      199A02489B8EB9BF8060A79C5C74F6CCA901CC27C8078BA77BD1BF0EE317A597
      C1E9CDAD82CA5442456DD75A1F7A0CD5BC0AB310D79A88186CD76994C36F358E
      7BFC2FA0BBFF5AE4F611AA0CB04DB6D089E82B8C094C799E040823AA300EB70F
      234CFFBA282C11DAB0B63BE95E9E344EBA97C79546B0494A241228735D593A04
      EFA1089A4A10BD0A3123C9843CB131CECE221C3B322F20B699E28916EDCA4CB5
      85184B5747899D839CF88B6C2D8F9819F698DA44BB1959E20F0879E3FA3688BC
      220AE18AD45ACBC07C3D84FCF509BD02A49C01D60EEE1AA8A39565A780F583EA
      96E50C09ECDF8B707C0DC815F14D62DF6CC9AFF7F8076EAB6C3749C43BC80E22
      38CC2C595E4E26EAE660EF075FDCFCAB57CF114B95AE8EBDC1315D37BE6D4132
      1624BAB9CD4BB13696947A8E9E100A4475E19C0E9D25C2800B9B78FA52049C53
      195195A8B1105920484158E464941918F2C8872D5233096F1B5931011B900E82
      86F4C5416B4A937946FCBB69728386E655E01D652389421F6F69117D62496FA9
      513EDB2B2384C7AE21EF8B661024B13A8D0373FBC2F130D830D6C828E21ED1F3
      51382D60D0E94CBD1080522B998FC2983B1EF3F7B7B4BE2D529A7DA6D2C18351
      2977D6B16521EC56109C972E5D121343D216DE0476170988D3B68A92E4BA5888
      570F79E37D879EC3D17AE0E2FFE3B4ABCE2ED4C555BF235D40D4CD9B833DCF56
      094E196C8CD28C6734C2CDC1DEABBD83277F876416C7AB9322CC75AA6EDEECED
      BFDD628413935370ACD96B46902FE3591C8E0900CB584D40C8109B317329EFAB
      11D17D82864028B587031603D94F05D1BDF3CB6DFC550B3DE25CD7319AB0342C
      6705118B79EBEE3750080ED1FD8EA4AABDE1CD0CA8AC12890D0AC32931ACF0DF
      33D051DD414279194A93C71B4AD67078AD2E4EBCE879743A9EA16C7D9D7D4B33
      AD9EB9CD53706250F4E1E62DFDEEE60775D43CE4ECFE5FC6C0F36AFFF5734884
      FEF167CA06A83A0518A5C3AEEDB75BC93E4843B99AF21FE7F2FC12D84F884B5A
      668243A81889D0F14C63D9A1BF185CC7ADE04C5C70C7802DF035A51EEB774FDA
      B63F9EBCA77EE055BD37CA566ABDB9EAF1D5E57FAB233DBEC62104B14FFF4C58
      C784379C8190649B80230C479692722838213A386F936FFFEDFA0D679767AED1
      3FE8E148FC239EFDA333272FBA2D851E73E9C3F9DFAF3FF3C0A1C21BFD7E87B5
      C8E528CBF5D8D284E7896A5F5EF66A94BCA9A941AFD3F11ECCED151700B99007
      515E9797CCFBF93F549E8F337875494C9AB0B3C5DB20A200CAD44F470E9D5C21
      AEF376700F787368D8BB186E613C1CC31C230632FEBDBFAB25C5BAAF3EA3268B
      BD1539DD9BEBE7A52182BFCE95DE27A70912CC72AC9C9F51F206456F6938CED5
      47B0700C1069717C7FB949D1663452731317FE4D7731FCE1C6F0167B78FC4BB7
      EDF01D71A0CE3FF6078DF3FEE0B8CC377B8F89F81FC725A5962F377AAEAEDAC7
      4869DB925BC44C4870A271071D2EEEFB88098AC235C156C56B873FBE5E975E3D
      23FD2A2C9F4784C6A90B90750562E96F2DD60EB9D6F6012FF96357FD4FEB2B7B
      0FF2EA8E9CB3A193B5304D9BB8EE0AA3AE42B37CF41D28F7ABCBFBF5908964F1
      B84C584BED3CB1C133238F89C2117A1D48D984ED3AF9B88D5741281A8E4C2A7A
      608583ECA169912D8DE2E64A27CD45918E6774C7F2599A145379D33DA0BAC1EF
      9AE6E342CAA6F80B8CA091C43EBF0E893B94E4C83C8416564791B9413F9287E6
      344F50E73AE608C3D8B176B2A0A208C04487E8C2A222A48991D9A3E128A54BA4
      CD9CDDD2A048B24B5843257A483588E26BDB241823B8A661966F1427DDE17AA0
      EE434F807C1A3F5ECEC28829771B9E09D154A8ABDE4353A5A8307BE26C1761EC
      9ACD79CA8A70AC5A9E4603C9197DA1FA3FF53B6AC12E6A98C979051A8C5F4283
      CC98141CDA1454A6F89759EE876F376EBAC81481633178AE923968D8EBEF3D1E
      55AB5C5CBDBB5F7AC566893C3039E2BC8EFE6FF6E3BD6F763999A0B6AA8D117D
      1FFDC3FEBD8FB6E00B75D6EA741BCD56A7EB3FC26175841AD97F76141D07D958
      2F8CFFC35FADEBAD0A23F1BAE9ED3F02F9836136365124AE94745986E5B5DD89
      FD4192079FC9CE207AB112C296C4C25AB9CE6EF1E3DE9B03FF97F95E5E466A59
      3EB20B2639BBEC3D152A90EBB20D8B1C519C910B619FFFA3AAFF87FAA033D51F
      17D1828FEC160390D7C0CD22ED086F6AE5200CAD721ABDA6BA1A498826D2AA59
      59083636B1C92C9DDCF14997D8F7D47FAAAE1E5FD74F637F37989CE056EB52FD
      4258E4FF50AD2449030462C51FC06CA4A158EBA79799BA0933F4098BF40A1117
      BA2B35659F44DB450571242DBDB71ED2EAD7EA1DFFA575D6A25AD9CED999B775
      B5213EB8D64E12039E976E87FB62B17D1F84196EC3AEAAABCCE2571019CCB06A
      095B45D9F6EA78F40DEAD8060E846EAC4764A0A55A26AA0C1D511FEE3B2ED997
      0DC2FB1FBBB3BF7F507F7B7C8C827634FBE45E65AEA8FABE011DCF388544B515
      2296AF092D81F7DE1E7C854C0D6663925E67CADC6AB22A71562DC7DFFD535DEB
      0BEC828734898D291CECED6F5A0987AF3797FBF0075EEE537400436AFBA10933
      B17DA501FC3AA152A5ABF381354391B4CA0C15098FCCFA2764016B2A01846519
      524726989F64788E8CC48225A490AE5C7053328D303381F74E913F42F87A8DB5
      53DB65A3C94E345A7913A6034BEC967663FBBFDDAAF2BDD1AF376C8D39385380
      115F435D70EA07DE4692CEEDE2E9A54E7DDDEFC337D0B33DBAF9DC59583AF3A9
      8B8F6767E8F6C8DCE4AE13A3A5064206A1958673739244C1559880AFA151FDDD
      DA0F17490CB1E1DB1BEEBB83C3EF21F188D2F452B698E348E21B23A94CCDFC60
      2FC0DAFE05A7E19F0E988637B077AA1EFFBFAFF77FFCDE9B39EDF07BA8F37EBF
      839BFFFD6B966477A4E393CA60E2BAB54384D5A41F71A70117077F21B6987B3A
      C6DCF6572E4D12AB5787A3307FD2698D937812214294E53A2F322C32C2BEEE94
      82C73D27D7CF115ABABCED934E848CB9EE192AB87B3A08792A6E39A8E8945151
      44CBCAA5219590F8031054CF095DC204B1570660870F2C8BD116215AEA55E608
      B708FFCC4DC809E3ED378D09955A8EF0A23726C2F2BB6529EBCDA4D1E1063290
      49B9C6D4099A89DAD9BA5E2B3C53077B3FECFDF0CAF3CE7C617A83E5080E4F24
      9D6B3F109426B5A728A71E4CF54C4FCC530E4A6DA82A60133527643746949DA9
      34CFB973C07947637D134ED951CB536390687FCA29BED86CF6FE02A74BAB1808
      1F6E9300B3C4B6AEE14812374AE659CB1F6AB28EAE4C2ECC33134D1EADD39E22
      3C7040D146DB02167C2406A447AC70D5F1211D3ECABC5AE40A011D046FE1AF4E
      9D8B474E2985B4BFC61EF288A732E0CA358503A0FD61D698C72A7E576BFD592D
      754A6BA14730E56C7F50225E267A26EF91DEB835A9F0085069FEB62199373F3A
      196C12E46F19CD4EAD34910A22264DD109E3D4E076718141330AD1B5E1E97501
      5BEBDD5EBB8FC189E9A122F11E7D031E650537E395EAF4CFB9432E1ABBA23B75
      380E8981D3DCF2BF772DAD32DF5FD7CFC51AACC4F39A4BDFDDD27445441A77BD
      920F206F24D3889F8E56E24CCD011E1B114F21FD81A0CA6C0A70D8D1FE447A69
      9986796E627CDDF1868B31691B68B87EA4B0A3AD67331638F068A57E6EB6F6D4
      B10E23E91D1D0038AEE646439D48F3540E0D1B342A131B3E9CC6B63DB633D4E9
      D361A90F29EA82693EDEF6EE72EF1432F0AD73F7D0866D96A10AB7947B46567A
      7DD84A924426F0EBC36A396FA8BE89EC8FB5D9C284E555E11E261BFA06E15F4A
      B43D505CF1950980A17B6D48DB8BBA621C315B204F4FCB94F973D03B51E4DE82
      36EBAB452A5E3382294B8A0C1CE2869AFF38FF8D3B4AD13101552130A37A529E
      3BBF69F44DEE124177A743E755008D5881B245075A4380CD0E172F494FDB7EA3
      3B33E4C1E1CB76F295F11D75D72C9CCE20456F0491CECEB7FFA6D409BA7BAEAF
      8D9DD042A77A8E335813B9E5925619CCFA555254FA25E327D72EB9C6AF40B80F
      480B86AFA6D7EA7400C07EE538498DD8FA05944E983671828A3E689451993B1A
      19201E69715C95CA7DADFC1E0A727C6255FB704C06019889C957849D2111B53E
      D510DA67423108EED3656E736729DA729F8A2824DF843BF315317C02A88824E5
      2B4EF01DAECEB1A9EF0D89C1E66AE9F4897C1D15C23057C4E616AD166989661A
      D27DE3487845EAF4B703143CAD89FDC3B72E3F3DE8F45B513887C1709EC05569
      A82EF2A3EA8CCB49D93721A7524B4D1D561D54F255F7CFDB3643D0A165653201
      5A38EA00BB3A3593D4643326D773BDDB682E7522DAF3C6B61CBE46EEE6E4E8F8
      BCDACA0BE9A63AF0D15476AAFA3363BCA329AF5F5943091447C3E1A7AB666F38
      649600642AE2C6B9664CE69FEA2C54E625B84654259005EF7ABE7A3FFAB57DB4
      F0FA06DC5AE88E3FBCFD5D79FC55B99FD865D3BEA464BA56F324A672001D2933
      9910C3FB84EC28052EFF5952A404599D1BB553E9FEBE5B533A42648CA2A0B81D
      D2A61312F34EB379E0EC4D0A894541D8F213499AD5A849A38BD942EE3B33B16A
      4AB997820EC867E4D4917347AD713700FB9BE23681E993E6B29C6B2108D749B2
      46991CBC4A3D9B1C944A0AF636D782C97B9289D03F3EC0B3F6CCADF986F0B798
      889BAD5B371F7067670FE570F44C14A2F90FEC18469C677BF9ED8366A94CB456
      65C9A6050C01C75E2CD2444B6F6829BFA874FC11759B25053AB4B2CD2F46AEEB
      3A0B1A68EE856C0DFA9214B99C210181F71EFD9EA7305EC9391D982C47A8EB80
      1A10B89FF65587D11B0FBDFA97BF8C05105DEA4E42ABC8F264BE17C6A16D7EC0
      F98120CC5233D52924C76865D793C5B3B5A4A9A30099327611F2C4AE15EC4A5A
      ADC79F139807A7F339EE135B086E922F332E41BB9373DDDC7577BE25EE458540
      114A2BDF7370708EF8C88DD95327E10D5C12F4030FFF303536C6B032DFBFAE8F
      D011BCCC35F1F5816925056ACE1FBBDBE2F6A1ED3D4660B23E408151DFE41B04
      671B6F7219AF1F3CDC63C80CAA58A1C875325123706E70F8CDA66DC24A4085B6
      12E7BFC05D37737038C8F6BFC64EBD512747821816741366C55FCBD10290E4E1
      C1BE9A877181BC2F17ED52A9F19E6A4660F59ECE2C9806C6690661221DD9D364
      899A06AA4E235967271E22803E65BB96FD902C47BA01C8E6E02614E271580428
      6FA36B05C719AA9A53A5AA887300A728A62895CFB65CCB0E4231BD84256AF0F8
      2DEA17A30C6135E4D6B1E4C5E2C1AB86A862567E25D2453C9E4180D0DCF41806
      CDFD7B23193CEAFF1BC67C4E41DC4155D9C94465062C28D9E32FCF4F0421E8B0
      017B640DD8E3488332979B950222115260E261239DC17269384D4879E5863B5A
      110FF2382DF2305EA91D8BA943B86BBE08394FB36BDB5ED9B2BA8AA95E539A2C
      78B1FE9D8D1DF0DCFE3FE2DEB5BB6D24C916FD2BB8EC73AFA92E8A961F6557F9
      4ED759B21E654DE9E1366577CF54799D0592A0843608B001D0B27AD6CC6FBF6B
      EF88C84C80144951AABAF361DA4591C8443E2376ECD831BA2E5290E4BCE8793A
      46D55856BFA26F93278089BFC263D53C4B2DB0C5891FC5334964672A97F402AD
      F7A313ECFB51396780B92E702E285282EFB064C8308167A56746F2ED3A9E5768
      E9FFD59829AC54F595A7588AF39C10D9D78448435581872DD9988B75B8569D07
      12433D96FC02AB4F7316CF66F8DF83857A6CCD79421E1BA6C7D4A290F6605098
      3D5A5317F8B2593CFA22807B821D02604CDD1D4BBF9DC64C4D9FBAAB2C2D7927
      EC7A293D95D1D348EF55560CE3ACC755BC2B521631732F5D5CBDD22CFF0630E2
      0C3C4CBF3B4B054FEFFB321DE4F7E5CD35014C272D919FAEB5C691FDABD910EA
      086F072D9D81F48105823443A9754B276190D451F7E4FDE160C79EBF1D3E423B
      8C741D9069E41F5D10D3766897C97F23A6F4B076549C29EAFE72BE7F268F6654
      C43EB7C5D5FD6530387B5853FBE37FC44C0918E4F12C3A675DFAEEB96B161FBA
      FC4FFC35EA0E2ECF0F1F388C5AF2598A1E53E0818DE9C75604BA8BBAC78FD392
      3E522BA44A1C2FAC3BDD1D1C5F7E58DED4AAADAFFCAC2AEABEFFE5E47C27DACF
      8B699CAD31EC34582FA849E3F7BFCD7F78FEECF9FF86F69912345033028B7878
      5B27BB93A2DCC53F9883ACDF15D0832F34CF6710D01E49B448818E059CE3EE97
      A1846B3AA2E6B4E02A5DF8DB3BD10194EB57BFD3C9447C7343B114CA1E53C033
      7A9BCD935999A2286C3AAB769D79474C42325F66A942ADB987C1953E1E7E99EC
      94981C458D1DE0E0C7500E8BD0779427E7E3354D5746CE91AB3E2C33295617DE
      DC8EC971527DA98B593F3A286642B4B94E2A8B23AAE3B0B2B92A49A65558428D
      F6142F9E7BDC36657C45A1170CAC5D3DB44794D4030234F0D2AB35281E60144A
      20688742C7290877CBE18CE7E33AE63DE22A73D9E5E00F764D8657FC8781122B
      6252262E1A04E2D6E054ADD51818915A530879A29C4C0E089E61BE629A566453
      69AD4E5C5F555DCE478C9DC27D03A24A3B826C5BFA2F7D646A28B38AE381862D
      7E80DF68AFF43D0919A6F4ED2575816263E36406FE132ADD39161B7DAA110118
      F8552266A43B719E4BF67B9605E9F85F13C940955BB828D32B660891A45E2F24
      5F2D3AFE49160F8183D267A64258524EA34ED07AE70D8AC1AB3743D74F4C98CA
      0D139DB8AF71968E017BE82D6BF7752F3AF845247104DCA88B22D32A843069D5
      5989ABAA18A53249C3A4BEC1542B1700760ACD631F9C93972D13AC93866F2D63
      47D6723C25EE11ED4B115B1C62BD161FAD80B1EDCCEE3153261C042CDFC04981
      3BC9736972C013FB2214EB615FD89AB3591253CA0856A2D0E4CE8AF15B971192
      4E006762D5CC0AE00CE2FC661886BAB0438925614BD72B8170EAB4844DE9116F
      770A4E9C67D3F83B8DBC95537F4272A5D0B4B87C521C30BAF31574C221A85637
      8C428945C274FB1AE710B2D4C24163CC0A08BDE2914887BEE100216C92DFEA9C
      CBA3E43C30E8CA3BE241015C7FCEECDA86D605CFE954A3DD04381058A58F9817
      8C8BE4DA9C4BCFB657914306A76BAE8E5876CB5F499B9CF01BCE0FD4F36CC70F
      E1ED2372273B999789382D194FC8515A8EE6E2D5F4A2021380397B9BE0EC1EC7
      BC6ED88F798E11E1BA0764A0BE6E9A65BBE6CCFA736AF3C3FA20268E18ED5F61
      47D611553257203B981185D74EC5135EB5483ED66996FECB76F3DD4FD554A168
      1D6664B6F86C5ECE0AD1EC317FBC31FD69C5309B3803A3625EC610428B0E8105
      20E40D8845290D3126A6A8D35194E45FD3B2C8A91822C1CB119B6F3E9A2E5A11
      03AD4A717F84A11B5915A3A4070623A27B98E03A29B384F17D29F73999A4A226
      C4D47DD9DBE88FEDE386F32A3E5F4F215B5A1173A13D65E934952A383D716B68
      09E0BB4CAA5141112E2A7F76D2D31115360018C32C992E7AFE77DB9201DE88D4
      B6F70281B465DD174371CB9D7424CE0DB314C1985E342E12474324AED2003721
      45DA98E70ADE7630CD38CF00E8695E9D21CD9DB0CB4744B2CB0E1ED180D701D2
      E384C863300CC368F96237FC79D34DFA57FD5E7476F17CA7676D4AE77625E176
      5A8CDD8A2640703F3B37CE90629E945F158B1266518879F07EA6B88E42132EC6
      EF1BD5E15E799273201308F8804B2830589CDDFECB19ADB42DB1AA9C5DE35E0C
      419954D288C24D826289789081367894AC52420018E2A578CA0DB61D597D82A7
      8FCDF0D2E69471C73D1A602F063040F20EB8CB4DB0AFE2ACA2F24F9A4F929202
      80869F433BD0E133523B516CC4BC88FE398FB94BE2AA9A970C09183A158CB725
      4CC957C5BCD6739BEBDBE2C8366161D497EDEA95AF2FA761681FB2E60A921B25
      3460C510AEAE8B9BAA2E6633B9D6F2DB28F9A69EC6D2A10DCD0B9C279C6E802A
      559D4CA168E60746FAF9A48AB2E42A1EC1CE1D27CC2277404AE94A9421151635
      F0E43C146E80BE07919E5470A2E65005F101022D88AF171317736A3A2532160D
      FB3AC0CC0F7E79BE3E3DC39D2EE03A4927DD057B43D61B18B4242B488C1F7A20
      B85FED98A94029BA85FA26F61C979FDF8FB20FE34A41E652A9A9379B63AAA738
      CC759F774F3C7B8926605A83B62A079A2246C5243AF1A0651B8B551016906CB5
      B3C67C57522CEC12E237B4A50977603E5A2C05B80FBBF5759CEFA6E38439E16C
      686C686FCF456F845D9F4E714B572DF82CF32FFBE61E91B98946C476E1FD8F15
      34ABCB249EAEF4FB1B2428432DED30C38F210098420D92DC256B455DA61807DC
      5519CB0611C5A57FCE93689E97090027CE509AEFF210D2CC34FF904A9F328A73
      2CBE610823380AA11E557E54B821AB3B8EA92A69761EE6C82D8A3D715B4F9AB5
      9A2EC1B2819FD1446B1BA6AAEE64FA6402D9D131D68ED21EF16E811CF29B5F64
      1F733CD4273F0902BD8E961962CA8E69C8DD2B0FA345DD3CF81D0FCDDE14BCEB
      7C973A3E524E57583B0E18F0D514B6837161D6E895A74DCA21052F48DC110604
      81F92F203A88054AEEC043B85F50EB97B96A0150BADF8206C4456E0CAB1B3089
      BFE5A6F2223E0EAB2056D1DEDE37FE1F7864B820F114F9C47BBD95776DC56DD5
      04AF46A7EE616336F1C6554BE5508A63882FBF1C5A94F1F1505F6F010F354778
      E5161585B3E064DBFC7D2CD9CE015F4519994ADA62E5BA3B32F5849021F88F01
      46C173E0E332A61ABC85308A1FA9DF56E6F75D4CF2E37D5FE38478966C16D858
      0EDCA24FA774C2920EE09A976C5F30C4BB72FD115E39029D89C0108888AED97B
      98DE3854EC7DCFB087DF8AA7BBDECBD137F4D48D3173AAA361F12D9C08F67956
      16D729A2FF0ADB86748FFB41C43CE5ABD03B854B467088BF3592B9FAAC303A59
      166F41D679E351892B5FA1D63E836B044A952E9BB55A1B609D3A07DC63E57E7E
      85873AAF0B84B155E3703CDE1E3EE730451D6A635BAF3B5E46501612F981240F
      CB4DEB725B639EA9B71A0910BF04290CC30CC65351DE6E3E9417E6FFCB98EA36
      DB679A4D3CDEBDC85BC4C7D6E8BD4D2473D4C7951DA0604C2B3C500D0FB0AAB2
      DBE6A8F5A28B6C7C169795FC07C0AC1A720DC48DF8D1BA6135DB48E5F277718F
      F4A3FF28E67E18018051FA142EC01776CB5561B7A8AE1FE0FB31770EE0884816
      F8289B8364835714D717C713671EC0D28A2A6C4BB62FC10815F2101FCF39B97C
      A28618421649921BB604647806B5C094442E200882EFD350C65725758A3AF555
      EDC319CE0D11A1F5E85D7103784F6EEC1B5C3E331E6740178A097A32F34430A4
      4E5392BA4E6B7C500200C10EF57495EA26851406D893EC1D65AC71C0023E5B22
      EEBE8477123203E9EC00B385873E175BF81FD844887568B96A7C4EBF44F98E30
      357039A9AB948F6343C7C988330C48465C876D68836E201900039FA7129E123D
      870A12D065654B6559790417F018CAB2203302EC12B9C864400DE0BBC7797869
      D2ABD1BF83C0E156F6E6B6E4B3BED4F751546BA0C8217BE7B8CBACCC4D7CF60D
      976868F10AB9022E8341CF18CDA3C19987BC759990FA334C2620E4C22846D693
      43D1781A73E4653B530B9D86C3949A8CB2EAABA88B5FA173FA841D52AAE408AF
      A2FAA600D25AA73918D752C607D7B9A50AE048A0F30E372A4BDA103ACDE60AEB
      1E5B999E9018B186558AAE1DAA94BB641B7C4188417CBF9014C21CC4CD8DEAE7
      3215186CF2300367FC0D990596DCE52C5E507498D6DE6309805E94D4A37E8F23
      08B78CA5DDCD671290BF357A018A297F73374D3362DB009B717608B74EF2394C
      A3916497D2714DC5DF9E46DD006499FF5CA66361E0ED044106984730187883C0
      BFD353A6D4A190FE914D1C5775AFDD7B19799A13EC759808E7BD03B7F185FAAC
      A0217CEA5EF42549E872B2C35873F27E3AB386AF60D93FA9A2126C3CF0ACDA5B
      81C32186255218C63D8800A67512C88F7B6E9C302BAB28B6FA602632D383A859
      5CE28F2E4454DDC217877B24EC530578E639F95770C1CA5B9B20DF046F410E25
      3AC72755AEE15E742D1C3D3E2A9D0AD9902687EEE18624C9F2312D93D6AAF111
      7B6589113DD08E4618C86583B0F91E79217BE4C038CEA35B459A867386F1DF44
      E77E6D4807352FDBECCE2A0250290469CB4BF249DCE83CAA212425BD77224EE3
      3917A9E2AE7D712340FB8C80BC9411DCD429F414C816CD19C8F6563F8B780FCE
      7AD11C64C8A422D14FC6068848324D4AD051DF49BCC6C3DC01C04CB05351DF19
      1258E4CA1554F6CEC9D11B8C7A7C6640606082F0D2CA2B5774E83D7B432ADC00
      8B8D01630190C98A2B5E3EC23B05F4F6C6564ED58B18D596D8B05CF377F6B517
      5CB7EEE88FABE6A5C8EDE62E63CB432890C3543112B03473B44AF408B71CDB9E
      860AF062C2DD75A90D01C6AE8F4A4B0D5A87873BB31FA7B3B866DA1C8B554A12
      DAA44CC8D55446E03D48B862463CA960E3E4A3D551923CCA2425567A5D794F40
      EE8ADEFFEF5649A0D6795EAC968C04A9C1D49186499E4C84479106290B22189F
      D65112572979174694BD6DF00F348E0837CDB3F3892F3284AAF7A18874EA129B
      95C06694B4A407B15CF4A0BEA003B312A2971288A7FB251A977696F28455A22C
      A31962186B807EE3441EABE574683A0ED19914B058E9BF264FBE9A32B1E0E50B
      3FEF47EFA5A60CC1351C475210C4715636EF220456A3F7A99CE33C72CBF8EA49
      FEE4B02C661E223EF7D21697CBA42D16D732576631DBCD12924ACA5CEE497CCC
      2699ABCF3FEAA79229B7432D9468C633BAAE91FBF8DE840EB87CE453088DAAAC
      853D2D60F6C0F907018015649C19478E7432A97771392D7B236E3D5C651C7B8B
      09C9F39B30B5984F2B4F5978AB383E6AA69994B10CEE18A3BA90B1BBAC2F8516
      16B3E348C0D5DD000B36310C04DD2565DE0F469F8E95323D216523B87C4F7011
      0B5AB2370E5D658B3E3C232C664AD28B29C79AB45AF0C41DAD7804207379C693
      CA406045A109FAF645C17FB70142B1A20C4421DC68200321C5C72AECD81C3418
      F05E765509364887A199833742AF375FF7268AF6FAD526DA00A1365CF04B2F08
      A0F91938799090285A5C981912C02C38CDC80A2F161ECBF955344EB23A163949
      494B4125862F21FBD0FF50505A1C9D2A5BAEE84E4807B034543F56C3DBA0C7F7
      CCB20B5E75599ADDA478FD6A5D9E1DA4D8EF48B46B0DB10AE721FC87AD5D4447
      A32F5552C692DC86859FE673DE088DFD19F4B1A55E04E33F62013DB75CD5D2C7
      C5CA026D3ACE9B2F9BCBA3C18B37D1595196386AC66E6174B1F308AE45071614
      BF5D195D083243252919D653DD4A9A447351D735B7A3B9932149A319F8F6AC1D
      16FA69ACBC7BE739AA02D39A35A3FA63129A12459F9E2610F995E447CC2DA420
      EEBE5B27D50B6E8C5D1E7E6E4D8178806B01521780E17AAD15369A4B3CA62E38
      549884FB6574EE8F98D6A1EB490FAF433DE847AB8166F74E94EA0232EF58B9E3
      F42BCCFFAAC5E775273ECBB140C399062E5866F4389A605D0FE350A720EF5122
      076C50110112E8A212794377BABB90F2884EB71ED596A3F2C4F88D7D4CDAB04C
      C7574AF1BB8A672624CDD2705C859DAF6959CFE3ACE362BA9662CA35A9A7764F
      D277A5EE01D039360896A0C1DE0E229006EE7652564CD227E94AF4336AC64B47
      8EC4663C94549C9514C19C688A0CB08E2BFAC3D730D21F8057703840D03078E9
      5FFE6E2236C28AF570570ACB155772836C76A7C55D12AF13DBD5F02B3F9AF214
      182B2A6E4568C2EDEAA2BC8A73DD7791E3FD01B928C64808712B4410D9CDC790
      326ACCC63A3A3D75A4056C3957936F758C2DE7888129384EBFA66325229853DA
      5D0A59ED48BC683A4CE808E86A88A50F32B8CC6BAEE937AAF9E160EE340F674D
      D15F3AE02DA842AB23C0E6083B6773470A668A54718CBDD99BE8032773128F30
      8170074453A02E63E00693A2BC0192ACE7A8CDAF164BA2F159052F17F6291F8B
      02A522659AB2E11741D81DE10D588F7A72C18F13E4F6A9F28E033E2974B9D4F6
      5C25266012090AFDB2C00A4D4AC974D2ED49CBF1321E6EBCA0EC49EA361C7D9B
      C5524C948F5DE9E0F843C11BEF7C6D4AD929E34FA20CBEB73C5690AED4F7B675
      717525B4FF0A560F7EE3EF945FBFFB0C8BE4D7DDCF51753B1D82702DD5095C61
      84D0FB60CBB859162E9C2FC9EDB0C03AF08516BEC383771BE43FE48715480934
      AF9CF2BC4A231688C3B129F9AAAED28DCA81C5A496B21BA2868985C51820D6EF
      2C29AD24F430AEC40D22CC24EA5E89A6B39B0221E6E4260EEE1B3316962F9EBB
      27F9ED3CFB125DF87C659E53077599210F6F5D5C67881FFB64E75E745D64E368
      4C023C963B1EF32501D0CC303D26533D8D626C89DCEE1E6102B80C991F31DE47
      32F106A8D238B89DB994942A99CC2524E54A9F897F63EE930029C9B718012D4B
      85E05481E8A2A0160CFA604ED0B4C90BA8A8CBC20420632228BADD0CBD498A3A
      BFC77F5600BC7C5651F8FC0CC0C47C46F218CD735BE00A726F3E99875A2B5D25
      AEE440F808BC5368F01B987B078A9F5AD64B197AA14DE71E4220569D9DC79F5F
      F192F7C3A68542CBE8ADA631D86F1CC5666812B7F6E21752B937342E968000C2
      ADB7ABD4ED22EDEF2E6B66722F6D3E80476A52B923755DEA527E4DD4715E391B
      8159D792E1CC4C948561C4B0A915EDD56D04EFD2BC6397011E66E107EA5F4C39
      74CF73511C3B5ADC34C8A914883088FBE47061DF7AA873403129AC9949928C87
      F0553D491EDEBE8B781896C71DE78143F7EEC1CBD1A0920E6F3E1962C2EC9E02
      1BDB6C465A19456EF077333EC375486BCDBB18198E789B1250B668BC930DAF3F
      308A0C95A743933D387DEC69C8539253CEC487E9CFF030A3E310E4963711AB96
      BC6C60387450BCBB83999D4FEFA173F649E8A427F918E1658400D0D103E859AD
      E1D7300A2FAFCF4A54B882B0D8A4B85B5C8B3810892D465AAD78BE3A55057E91
      171DDEC2DB863CC3F5C15C45D369322654EBECABCD4D9FB3629CE0FDFC366169
      8D859CA21563F4918407900AA86870717809658DA549D28B8C0F7EDD4BF43572
      42E46E08F4FB508DDB2532614948AF25EACB5361817BCB4DEA1EE0A127E3A8C2
      67C8768D481C1E176AC486C90AFD3C95E45606ED2D9D52A656DC4CC9070B9E62
      1E5383F93F42B69BA78138CCC519027A33836D21EF0BEA854A4610333355520E
      1F912F6B08E9C3DCBAD4F8335AB444DDF4B112F61C26599AA8E4A9D4A646B977
      771B5845AFDD18C510CC4CBB0F4D28F9C6E34044BCE30AE7C1CA70C894F99620
      F119EEC9179B15294D90BA3D990A28B2C49864BBA499201FD7CCC2F2D11FED89
      D0F3E6CC87F3A7075700BD1CD968DA10DC8A115D6A7BAC3A2D2C68A65B91EE4E
      2F3435043703C641C43545116BC9514EC50F606283F2A27878696C568ACF92D9
      770325FE18B63822878D6F6BB126108ED41F6065734B6C039E1C64D4621C5C16
      8E216EB031D5C832CABBB7F77DEA90BC27571E735A2CB518171BA59570C0DF03
      451A38946724979F556C586922833B1E827DAE021E173E52A67CA0D5EEFCF0E1
      7606887B9CE675598CE7239312FA2659390D414C9974B0C5E8AE28AD46A31ABD
      683AD73F630F5AE4A1E7283A7604F8AA48BEF0A3A6C85BE20C791D5C39E475D0
      0811F7D95F70AD674D859C230208B8DB78CE51F6412C761282542DCEAB33B118
      BD188E583E969ADD28F2E10337611FCD59449C6137CEC7BB120E91C40A5D590E
      8BC8FC322AD3EA0B8D372DAD6EC790E6478623EE717BA210F6A6F1AD0ACB23B9
      C5413F0A43799DCEC52C843BC75BE626BEBF83B76F0C58502F5CE910F8F3ACFA
      41C9F97566EED4128888CD5846A94C372E2E65D96A9E8E3029ACD38B5774981D
      B26236B552A49F4D9DB105D2805F61127DC1A087DC80201A6C402058FEC10C2C
      0E348DC3240D0A06F4A3E379892B1D1092BEFC934ACA6CEC52847F319F4FC4AF
      2DE4CDCAEA4E28C8A88EBEF74E1B9CAF61592BE14EF5C764632B6E6C2E1D31A3
      1C67AB14EB02636D061E5DD43D393FBED8892E4893389170A37EE7B298A5A3A8
      7B78B27FBA738FF8829C55668A1BC0EB4DAB37D1C9F98550DA4ECE2FF6D7595A
      68DEB657E0410971304F6E7A91626FC11DAB0643A39D458D2D5AD9C2490D52A4
      829BDA226E30FC6D750497AB4BEA67AE14BF1CA4130462ED482CD08031611D61
      34CB3778DADDBF4A93986D983B99BAB58AC6461245DD1C12A8F85BF7A662E6A9
      3C31EE670E7B60B98767159CC6894472584324759D3231F9E65119FE36A127A9
      27469534BB216DA5A5DAA694FAE7C2E4C9A14166B5B672A4896A9A44A9AB79F3
      713CF04211D49F12ECE5C3BA0484C34054923793A3174D62AD1FD8C298C5152F
      496DB9828BE9A23C15055DF97B474E09579EDEF5CE7F9CC829249FC3AD33644A
      98410DBF56DD592F5214A0E701390BB7B4BEBA08C2B06C90B363953EB67D969B
      2943866FB96CC6C57EDBBA19260DFBAC6E96178470B2F2E4D9A03F6D75517395
      077DD9BAF5806626DC7FCEB5687808847EBB30C1ABD334D407E22DA0871B2C37
      64C40A604ECC733E25A71D59121A3C37C9530DFE89F08CF85E34BC97DFDB81EA
      A5384F812BD05AA768F7B698DFE3B8C209EC8EFE758714BF1D5CEA624F4A2FEE
      5C42AA9E3B16BBC129A49A4A51B74C46F312991E4EF75193ADDC4918A6E788E0
      8F3FC6C81D53B698EF86B34040168DE7F535D205C986AC12E632E42E1FDDF40A
      B4C546D60DBE53943D659E56143F1F30B2F1F3D1E7835FEE35CCFB9B0DB34AB6
      0A4401EC49BC403EC08F3CF501560FBBA28F318D1F8982694529B88A5EA546FD
      44DB16EE84F7BBA6A7D20B61304353EF7C3916A1FA2F6CF556BF75806F94F3E6
      B4D6BA693FE9CB039861CF59154CCD05D177AC040333B0A5C041FBF29A25256C
      4331E2723DDE780E9BCD4978A7F9B2F299261904C9607AC7F931E228B22FF7B2
      072CF3488083B362CC82671AA65F1BAD630FCDC1340657C370EA05AB5C2B0E38
      741F6789E401C415E0A94596A711A7DD41CF82F0CD6B5B07672C49B901C9A072
      6E82BB934085FAA38A34FEF09CA5AC2E5E469FCEF60FD5B3B06B592AF2699923
      FAE3188C590C7925AF8BB565C3AFA05D3F980FAFCA78762D6E01F3D86F82222E
      4A8F7DEA2FFA2D1BFB0145AE54ED46DE312FDCF969B36C3934412CBC2EA2EBB8
      1C8B33FF101DCB3FFDF0234B7C336B68BFAA309E45EEAA0D71AF8943EE080DE3
      E82D5905FF984F7978E068DAAEED1FF75EBAB6B956CD41933A48F2C2AA2498E6
      CDAD1148769128C060D8B4006B48D39499C58F4DA547D1B67DFC61691F03DDB6
      58D603C60BECBE8B174F8FCF3F09196B9C8E81B0FA825CC055CE4F8EFF93EFF1
      CBF1F17F42C979F1B4D8BC7BAC292ADD3B39DB3F8CE65A2C5AB2CBD39C5CB817
      D7DB3DFDD91E4B812EBE3D197E7877D51F4803754D7D67ADECE7FC6C84261463
      21450076C396BD7AFE3C2C5DC1DC765522D390A81C13FB9FCE0E5B553BA97B8A
      8A420F284CF782C52D5852BB73F6F3D171F4DB6FD1597C958ED4D5178D93DF7E
      8B0EF72FF7A35DF79FFBD03A842B9C4C3B8A47555A48D5A7F82090D7DFBA6728
      3A87CCFB09E4AA35B986ECA498B5B9E97A5B49CE606B0F921A198DF46695AC57
      20C1ED3434B04F0E1F5E39EED0578E9335F5EF5F7961CE4AA97B94E6D1AB9743
      2DCB20B84C8CAC225FBCC84FE5FE2735057C185B98D9BF433721CC0A03C2CAE1
      4A961E97BCCA10EE684E0E0337ACC324346AEF712233EF77E8DA653C344B3177
      A17404EE9FD2E3A0DC6EAAEBEC77681ED5A680D340506ADBA2865D57F824E193
      4DB95CF98012719768CD37D9E38CAA19F3E451DA94FD7C24D48271F47670F6FE
      61951A97372095764E3F0DDE475DC6D8512976966459B563418BC76A8DB7D067
      58A95280C7C54160649EFD3CF8238B0DFDF03DAC3979F9568230883E06D6A95D
      C7E8223C01E1FF3903B6698180225C6C570AF64FCFF67EC4BD76793478F906DD
      6A048CF60F3E1CFDF6DBDF4F2F0EB77EB8DAAE6FA2B38B3F1F0B82C4DA1EC8A5
      2CF2A7E0DB0D9165CA4BFA5177A58C31D547951AF212A1CE010292F59BE86D51
      504AC3A717D4057E63CA207A80983E884E8801EC5BF5D4B2B5C0D994DDEB2245
      7AAA4F15633F4CB2D9751A3D7BD67FB1554B001653ECA847795A7B4BC9C8CAB0
      BA1099843C8547A26CDA5CFCDCDD51964A7882A11F471CEF0AD07B90A5331220
      77EE99F6160DBEDC96E9341A1CA16C9912CBA3535C3601E7B83F8BB75B57E7C5
      0D7CCC4A6ABB8F8A828603D0AAA08437439056ECDD856EB4EDAD9A7D5F22A82C
      D16C939294950C6E0FDE8D07018B3793C8B6552BEE2CAC66495B18687DEDB1BC
      597B6CEF3EB5C71E5AA66F0F45EA8E01AE4A29088A3745DD415DCCB0BEA4C0EF
      11323D7E8AF8A17C0293206F2DB17BB4FAECB9BBB80E4C782DFA39A94FAA9343
      2FCE08FB6B86B4EBE828875F4021876DCD45B48AD3F3570BC77F9657A99EFE55
      ABBC0FCEFE7A1E185BC0CBB04A8649CE3231AA33B16DE334EE4F1C59065231A2
      198A38D26D9966593A72CC67D6B21519078DDBBD2F0BE4B66FDD3A5E1D26959C
      EE0A0978724B8A6284527C7C3E25764C6A429A53853D3ABDB8B854EF97CEAFEA
      333FEA05D3D7C2D8CAFBB0A8BBD72EE37100E84034615DD29DC28CFDA4FADFFC
      EDA31CCA07714615EEE4381E25E78809669549184C627F19C444361EA5496A55
      48CC47AE476989AABB1A3E208D01F14C962A93E27FA8899056725EDA5DC03BE3
      513A65855AC773179FD2BBBB738CF430D5437605B1153AA9E7656EE8270A27CC
      E2AA734FBB50A7F751DE6230387A139D9EFCFC2EBA41EEB8B2D74E1953FA293A
      3D3A1F3C4A3396047E7079B82F22D5B8E0EAE8DBC5DB16B7E8D15B38FFF4482D
      C8ED785DD4A0FA1B620BEEFF77073DF9DFFDACC6BF45EF839E7F0BC15BC84AB9
      FF0DF8F28FBA015FBF669D5A67FB3C3D3DFA1CED461F15EC3A8B672CE69B94D1
      25568B68877EFFE3968D119545AEC5C5304BBFE2D23300C06B4B62CF2BECFFF3
      D1F1960DFDC86B3D4B99EC4DE29F6069C649471D34C9C9A7D0C47CB82BFFB9A5
      17B607D82C668553969727F59C271966F6A628B37185CC5E4DA23F3C3DF0073C
      9120891F859A242AC3F9B0E2BF3F3C7B114CA6166844D52B9E60284C23188067
      AF4507A6C0F10BE86B645565C5769EFA9F7E209C787CF1E24DB49F8FAE0B48C3
      51CAE3FF89DE83497A5A145F8A79CD8FA099CDA586688F30492C5545856FFEBA
      7FB065375E62D9590E21AF2D8FF15BBAA8993B98301FC87796B95B9F4FD3FC1F
      F4A0B775D83924E79F9090A54B251AA3916991539D98107B52525E0785E1AE92
      629AD4E5B62BE07B4097527CD7B7978DF2F99798EB52240E534A2CA779743EFF
      12EF5E62B5A0CE7952475FE33CADB644B97F20C80DD1923A9D99F5304E2B61E6
      804F203581A5E6E2B66DC81A7BF9C612862E8698201299AAA87B787CF1D63044
      0FA57F4DE308876D516E6B4EFFF0FA19B616EF2339AE06B512133393BB16137F
      DBE77FAF408ABB145E8857A009E474931BF0B8AEF06D2366309159380CC780D6
      FBD36C18EC803FE7C59F75796EDB02568318372A92A30CC9628E77727EBDEEF7
      B67EECB661B897FE82FB1C0DC0B68E33A99ABD8416C7554FEFD824FDB78D6EFD
      18ED1AFA268B4F5F339E1510CC9C5DAB5E86220DCB9D8CDB0798B27FFA916EA6
      5B4246F81592432905D10AB97FCE93EB329DE22CD8B6298CF20798089EB96064
      3E1CED529AD6EB01A24A6CC392DFB65DACDAC30F8D44241F4E4634031457DEF2
      F2AFFDF1D86805C72F9E9E7FDAB6DD1FD592911CF2D334C7B2F95014D32A3A20
      65247C6B335B31F4588074D81ABF21558716FFB60B8E717DC1141073F22C3E6A
      6D45294A5C6FFDF09778F8CF497D9EDCB83816D8EF527B782F8ACB2B5675570E
      89BDFDC9CD902927421189D27C36DF1240F8F1E58F0A5EBCFCECAC47A9D1475E
      4F5C917964F44109BF7DFAEBE080E1E26D43C0B85A58367A063F77AC414529BF
      83E8A2EA09AABBBA6D2B78B3BFCE5314D69CD745249ACC7A684C8A7294EC4A1A
      41D4F9206ACC17C7834B463F3B5B3629548CD39F25EA7F7C7A813CFD4948D164
      FD33013FF0BA33644E82B2B16D83B8CCA8F0AC064E53CABA4C761595F4864A50
      930F2F4DE9B5AE642D7B260702DE5BA2703FBEC6E978FEFEE0FF444F7E4E5857
      F1E32CFA5B1283BEF3C4590CE4A1C2367CC6DC8E6DDBC24A3280CFD55A90EBEF
      5DFC2FE4EBBB2D4496A34244925E42337CDB9631D5748FA334A7621FAAF07039
      8D9351165BAABCD4F99BCFB89368F6834FCA7F583EC0E3C25D499579F14494A4
      9108AF204C58F5AEC495149F0C58422E49D8388882975ADDC86DCFD0BBBAAAA7
      CED12184C2906B3238C060FAFEC8EFA2CE91E5C2BCE45A11D98309EBC8EC7534
      84A1474687A92AA20D8341AE3A68746B8FF7AEAE1F21261267832361CD849D9E
      25A598C852AF36F07598130C5235D2D95C05149B8DFEB042DA5BD962413E6AB7
      4FC3D335A83F4FD51651DE53CF5D8142A9554495753EEF517BF3EA6584D20496
      52E3F079518D5529735FD485B2C242587AF94007FEAE1EA93226F47D358F0692
      6206080B0A894A7F38574C5A3DBB8DFE394FE60030E3AF2E2333AEF98C5E40AC
      B67A4059513DEEACBAFD6C562EE8D97C03241A4BD11AA9DFAB3A5C136A6A1B61
      E5F760E975657732FCA5A295E8E939C088BAD073884C9A3CCED82906B2714BA1
      40B9AC80B2FA03A1DD3FFDF01C88DD3EA93083C1113BC5B25839128613F39E94
      FEBEEDB1FDA71FF7E0DF763EE6D7F097E32CEBF7FB1D8BD25252834C63AB6D36
      4DF2F9B60DE11E16910CF21169A84667EF0E2F0371F3D0AA83C8B4D84B035CCC
      260F5F455DC408764FF880BF01DCE0435C487EF388B01E9B4EE40F83BC466A44
      35E81A84873B1EE3751869F4AC9419949DA0C2BE22262752CE76B09B582128F6
      D45BB1C8CC2E33A8E34CF2A7DD206CCE33E610E3F12B133B6EA5554C8CF4554B
      48EEFE133F874DFE064028B63935695D4754FDD71D415117073AD3105D353D35
      F394C64E655B8E326C3223B22887458BB00E9C68274EE3D5157B696AB9FC13B8
      C270BB7DA610E270BD08652DC3B719C737F9D51C5950F03E908D5BE4C3A2A433
      B2BEF29EE787E89C8E286FED260D76313DF22EB22E5041EA66A7FFE070C28B3F
      2A9CF08A6EDA07EA98CFE2DC2E6B500DB77C2069B81A2A6F994C6F5C3457EC54
      212D42B61EF3FF342A0408E4AC62CB0D0E2E4E1F14BAFDD32BFA6AAC11A18147
      97515BF5DAF414EC52917DDA970A4708298B4C18CF4CE6AD25F95CB600AE0455
      08F73F6A24E06ED9E557E83215ECE23ADAEBED990E57359B930D289584E45409
      23157A8F1868BC2577F6D5EB3D377F87F134BE820708CC322166C96064160FC9
      D773C8D1B64D09C540BCD693CB3389B1F0DC3421DE3C2AE9E3125DE77A69A6D8
      4BB2F6B6ED1324B92E20BA1E1D0DDE8B897A568C454471DBA72278B14F2AEEA7
      B490BA44AA41A6D8A1C8596A8D14885581E219BEE9962DFFF84CA7EE29547141
      55991134E46292FC0D510AE4F14DEB8D51FA2CCEC7D5289E51372763294CC5C1
      4A833214A671E068FE644B5CE815E1DD0AB21B73AE21143D939C55FE4BD32D7C
      292B1AA5D57CA8E55690A7C6A2CD5B0F1261FADB191329801EFC7478BE7FF6D3
      7E9EAA40C0E5ED2C7913BD8D710CA523C4DBDFC618953A1D6DD9E40F8475A956
      515F47C318E9B358C196FD4F19482C3DEA5D8902796522D4C2EEA4585C5144D5
      34CEB26DDF9CD0AB80DAA75A69B798449DC304591B55121DFD739ECE889F756C
      70E0E316630D586CDB2EECDF0329A2232457F302C53E3CC800D6A1FEC06D8582
      EBF8575DF25F3092FEC601A85095695BC8EE355357B478DA74A1789AC9FF68ED
      3456A2B05A71B516A29C575B4249AF9FA16D1531FE1A1C08494EC14255E94EB6
      85AA5E3FC7812D40A74F9025430E4B8A9C1108247F1C5C6EDB008E15EA4D5D9E
      9FF9A034233296F3085E7D5AD7A8E809B3689E4B7927CAAE321D584EBDBD0760
      72AF9FE3623CBD38FC19B7799CF3AC90E6424F53EEE6AF4974FEF194051851EA
      16696384D0507BD742C85B76E30561C8E4263AF805354DE09AF3A93A14382954
      A753A675CC9083AF55A224311FB87A005AF8FA05704A9783E4D44452E242203F
      FB047C4B68D6C5AE5949CC424AF32F2EC9B128D32B66C860F5B8F82B4A17212F
      95BEC3B67DC5C92FC5A5A9F021271BDD07093F394A89608B936234A716804FE4
      754EC4B4D8D2E878FD82DEF874985ECD4D7881A1C62755F4D78F83CB40E47DCB
      065EDEDDC0FBFD835F1EA1011C280736E7FBC6066D3662985730CD07F8E68CBC
      CC2D5BFE1E478D5B603A5D4F2AFC9761592AB6CAAC6D5D4842100204816D928E
      B5AC1574502480C6EC07E4A3E9A5943E2E1CE86814870DDF4F944151E0E46D01
      72038A83C55757AC06B26578F3CE1E1024035B63FFD399C573D318A5E4A2043A
      E9D0EED0AA770C8C5DC9A6EC1190A6D088540253256A75A1F93D570EF909A849
      C5178604341204A493F5E6D92E3814F457F03304332B50DFB2C77D55803D0422
      00F578A407863D8B8DC1C8CD8448C5288D55CC72C8D1A3F6E69D031DBB0AF6FE
      5BF4C3DE9E2F9B6C34020106919D1984A21BD580E44CE2CDE232F22D36E64B02
      3F6AEF1BA551347422013748D70233949000564DD441D2075EE7B2E84433C848
      8B408DFFA5AC24B1147C3AE3A3F638F0EB4177411F91A0A6D43DDED5D5171146
      78D47643460AFE946A6A2773E5B202B2672658EB4E462EBF34DFA592BACA60A8
      D12DDA085AF786F540B73CACEFEA6F9AFBDD202E1FA44CE5386C5495B31C4FD3
      A7517280371E7425CC73219D3F88847CD7E9159A17C62698047A73AEBF1A0D0C
      EE1CFF750AC91E4098BE849531D152053EACF10028E1AE9E2BC6E80B034DD38A
      BACFBE129EAF54682C6B35FD1F3D22A9491C6F2F2E7E81F0373520AFA2C1FBA3
      5357734FC610810218AF8F1920B91C4F34A3AD0FB2C971594C5DBD50B723342C
      AA8EA715D1F4B13A3EFA317B2541815FC1A2F8AC340A65A83465B6C2C3B6ABA5
      1759DD2D4782645E253B8FD92B01BFBC4E6C4090128A4E4E44E5319B348EEAC2
      BD84438AFB7BC6301F14242970EFAAB2B44FB0C7EC5551CEAE6340DD4BF66D15
      E047A296B1405433EEB61547E57D147F1575E9C5126FBF6F14EE15EDFE001CBB
      BC3C7A1B70AD171DDACEDB0C15AF5D75822DB93BAF5EFFD86CF8D3C9E08417D3
      FB83B3B721A5F14159D67F7AFD1C7E69359F4CD26F826440E34630611809B0D1
      E54ADED6713274F133A28C326ACF9E1129E2D90E7ED32ED3F13A4D4E61508D85
      72569D77E29012F563AC1632FC0748B3042CB5DD38FB3C6F7421DA43B770D46A
      D5EDCE80C5FA1EFA6CBA0B9D0F52C85758F9EFCB021773197D1B1C4547AEB8E8
      6971D5F1357AB76AF6831CC76253055A75EFCB0486DE00A6286F2E28770BB618
      9042504B54D3141084DCAA070CD71A1DFC3A15815B2986A0E164E85B6F7B59F2
      E9D004649E05911AC8BC4108603E146E74B4BFBD904570E74ABCE4E8FCE01DCE
      A55FF2E28660104ED0ED9E2DD1FCB862F92D3DED14EC7908BB017C241CA4ACFC
      02A95498512E855D73D60490179E598BC9C24850D4DDDB7BB67B7C7C1CAE861F
      F6F6F0D18ED9E6D3199EAFDCC8A3C17697593BBEA71A4D12E2B3544C61F7F3A2
      8A325A8A4E9D301F47EF4E2ECF8E36A7630C502327C195F4DE95705B15C21D20
      A5C7577BB318AE1642114F3A96CA3B7C2A8ADAE4C5CD7662931273C68DED6910
      7115EDFEB3DA2E70B00B17E18E677EDDFAA10858C39E22E88747C557D9035E57
      A89F7CCDD1031E835E058F8A471B2F0995E3C016A439096392A6E4BAF2C1C85F
      95A2732EBB21CDA3C3065B8041FD715213C162701FDF31869685217798A9CC4C
      CD98E22F0C21340A8469ED02F40BE0B072AC4D83D7D5138FC756C80E21912969
      0E0D4D56DE99D47753BDE9F6890F18DE4AA6E35A165EA3AF67CC02BE8E8F2974
      34CAE5831BB89E0E211EA96C1C1D35B5FBEE42D9C81251D2C6AD6A3E92A9B1B3
      018F46F5E6483C5936B6C1182E4CDEDA777115801CB3030A84994B957E1E9C1C
      5B9E08E7059623B2E45C929CD6B997B5E27BCF8915E7DED2E8EAA2BD1A1B9C3F
      CCDFA09867D1419C9646FD1D2788AD0DA96D0E2ACA76DD3E068DAED16BF5ECA5
      6BEDBE9B6E66B8BABB3EFD9D9CE85BE8DDF2A2E4D7761E4C9179BE3945E69762
      F7385D791C18BE5A4C545732AE80AFC8E9804B014A3C4A14D33A03E228B96AC5
      ACEB4CFCE07D5C9789A8DC3F852C427CFB3ECE36203651B9312037AD6E2F1A16
      D0DD82CC2EF21DB0C9A6455EA34CD2B840B40D216420BE7CF91E9CA712F0F238
      557C5304E24A788D1179A7D27B881ACC92FEA89846DDA2E413E40D76989CF3F1
      7FAD39231269307A0FE6086B643069C6B067F9A316D9D6450C950E090B35EB78
      4F810BC375D99C02878C85F27D91D455F4291D27C54AE3609F8BAA235FEC58A7
      9A5CBF6DFBB8E4B82125AE9891F2F41FC5FC723E4C50C5F19674274EA9669F59
      953654292C28F5E25FEB8F521D7D1568FB99B3F73E29BF505FF0966565A267DF
      BFDEF6E12A8225E8B6692B6976B3AC4C6A9D3CA9287ABA2274693F92142EC642
      1E15B89329B1D27C60ACE6373134E1B3DB1D03CADC1A50B106E1F57AC60CEFD7
      1862BF19AA00A9C03543397A33B360DDA3F69B94375FEA09273274D68911D737
      A8381216C4C27724A7974550E49A11CBC52E1689EB91D0CAA40261EB50F904FC
      9CEB790D5CEA714153BADC1FF3398C1D8D5E00912926D1DB33A960C3600645C7
      A5D6595CF96C990AE4EAAE22AB7A7F0D93E88598443B8FDAD5A0586931B1E58A
      19C6290896B3AE0689E83C253C837F98F0BDE3CDC214115D2C17184BCBD17C6A
      753B1A029EA2E562215787BB716A9C75C712B78FFAB29D43143E6F2B41763C8E
      CCFCA3D0FE0DEAD1AAB58848A5B99FC6B5E156A0AC8058CB8EE5C8039822928F
      BF47E4D63BC939929010092A3E723368AE52783303F3647551641C64E94CF0AF
      63D215F2E4C61134C3DA95789ED1F11F779710E1A0C22A385BFB971FD065D935
      8F3B5C6AE550BE4E74CC53A8DEDF794532561A4743942424B50D0B201F47DDFA
      3A46F0B9BA8EC77B37D5757C3B7EE1EA8D4DD26F8F0AE60F243E46FBB928258B
      4D8E2DB3DA8E06670CBE8B26C0E0484C20E8905C08B5C23958E65BD13DF3A4F7
      AE0B513059DA04A14C8E1D459C1D2C6876B40BDC1D0DCE1EF57DF7C763D52CEC
      EE38C726F64E8DA8F371AB598C41701A8D126F5F04E3AEC893A0FE61694960FF
      01458C250529E5D5A8B53B958B3588FD084AF8A010E71D111F0F15FE8D675631
      89DE173712EB19BCBBF8D8E26EB1C8D3F6D4893BC34E8A3213B5327531375575
      19E7551693B2E1E62E608DA080C3EFD59FB28E8E4F0797360C431612155EF003
      9508EF68FCD0E4BB5AB1A79F3F7C7CEFC2A51AAF4441E77C7712D7A866A199B0
      6ECFCA1DB958927305A0E4EA083BA9BF956EC4B2EF4B75621FFF0A5288D5A892
      52054063389F8AC846CFE030B9A24EAB9B758D59054F5F01D94F4A3FDA77F871
      CBB5D11AB56591B100CBE6AE85BDB1A2F372B0BC15D941A3FC40C8B22841801B
      DE9AD0CB7A674CB3CA3ADBB6D069BF6357874154F7CA79B21A7552B319359534
      714E4A847F4D7A8DAEC44B7A01B3547AB898FCE48B226F1EF364411D898A87B5
      DD64BAC7288A4B79BB55AF73F733BA4FF6C9C43E96741F16E6D56F3DE9454F50
      9616E10C114D93AD1E88AA3E1135B5272A6FD03961C50D1465456223CFEA8ED9
      7F4FACAA0DCBE3C0AA1856059F7D7357E58F276D718527920DEDCA963B4C5044
      A0A229EE912BDCB3B32CF685B1564EF5199216C36AB3F110D6C082AE83DEA172
      4CD1D4492B03A5C0021E17239101E8823166B9680CC92B64DCA3C148472B41A9
      52370D3B9BAF865FC1ABFBBC348BB2B7844621F3C3B7A08803D87E88AAB11EE2
      BABAC2527F8E43CE9B902E3027C0EA70E00A942C0C838D24B68F1233E21323C1
      316DD6C3563D488FA9AE864CE407623FB12B3D547D52E97B3645FDEC8AF97EDB
      C1B37726A6BE81061A5E7B399BD1D2374DA907B225F86CAB4E2C6F5F138557B6
      FD3DBFF1E0A6FD5A7F039D33D7AC0BA45893C7177CDBBFEE3FB4456DCC868F1F
      365AB2B7DFBEA1E6D2C77CB2297C8C4FF161EBB5F67F3E5D686DCDDE70679152
      09B922255D253A88E502D1FD70065356FED49372695F585C2D892B019713ACE7
      D8D05E778B598630CA8AE4B6BB6C476C7E7C7038A83284937EF1BC5887E9FA34
      D7857C58821B75719530B22349B1AD905E513682851B9E00828AD71490F1C924
      85E2A35A604D9C1601D19C6D6A81082DB2322AA6531C87B0AC56B6C893C4161F
      9747FB4DFC380806B918675A370947DF56E767D35D4A6EA425D486DC68C4E320
      80E1AB11CB2AED32217AD91D21B9343D9597DC119586AF2E02D950FC2176A9EC
      63B2FB8D1645EE7A0ACDC1FB58379A0EBF6D82FEE325E4AF4DC75F958CDF3661
      0527B768B24F5BE13A4641DD897B0380C22CC74BD75CB77756481535DEDE5CF9
      44EF22C983242EEE67D77D99DD1DD4493C45E25C124F97667F20CBBA82409D33
      BB24A4C62EC8835C317813061033762E625600BBA0A0AC6FF0A4927A3EF8D1E6
      F37E0C7EE7BC8E5EBF5A3592872E4586380958CF80EAAC7E822FF3873591E692
      BE386E16524EF3E8198479F942F8D7F7E8EAE8FA3EC7A695643561BC0D0A67BE
      7741710CB354FDD4A7F83711E56C29E0157C01CE4663D359EEAD77E724249965
      5A945D6A5061B34A60B61F752FF991C32B20048E7C0BAAD8C16E73082B24AFF1
      D362321173111F28BC554C26AD224382694980DA52FD84552097609BAC6EE459
      BE60503F97FC8325A5C7E180FCD2DF59295DE1214414F47ED32C0569B5E184F2
      C6F2AB5D47D490FAD2BEB894AB9C29012763FC0B0B8215E9C5CE9714FB2F415A
      48A3C283CE9FF1E0C1BFF093AC724BC3645294A8498C557B9D26EC625AF59ABD
      0F606FE5C06189A3E40421FDE0A5E479ED99C0DECC56DF6EB85988E4C894B420
      816A9601EC467E78C77DABE3FC67B47009F7992BA5738C4937C23CBAD5FCE631
      544C68E7B0BE64A9F108371D8E79414A8AEF140E455562C70AF4CB7EB5D77E17
      C44857C56F1D5F50948D8D3CAE14D6F77678B6D6834CCAF4ABF1338269D0726F
      DD566D4D2BCA2AEB29CE2A47839653FEE0173BDB3D99BC550056858092C636D9
      09312D5D21C35BE5FD69A558437B35A9CE3B66A1E68F1945CA186CD038CD58F5
      6359B9C15C3901F08303969DDF034B802658AFA89A2E0BB08ABA41FD40D43BE5
      41E59765E24E14FB812A0B25E39D37D12ED60E66B307AE4DF01F58A0982739D9
      76CF0BFB60F3C31FE8BF569A81D7BCEAFD2550A0958A010DB30422736416EAC2
      3228A7E38DD5F20469F032486402E0705FC8DA9545E9D4C6C9A876EB57E36AC1
      F3515B4F64093544212C4F8973606DC8698E8B9444D6D0C432D1AF456DF322DF
      1D27B4A417CFEFBE198D190EF8DBB6F1E89500CB147C340ED8D24EAD5C67C194
      383CC21BC4A1F10A4AF4422F28652B6D874AC2D8A476ADE62CF7D7EE938837CC
      CB196C60B9166CC82439CFCB6C21807424571AEAC2696DEC2F41D220DD07B425
      93003B5093CE781A6AA8A31F1D6BA9F5458C8A57531B976A37BCEEC484DDC004
      1A184F1EA1690F713A21EC129709981757855E4882CD401DC14414EEDD850282
      81C6F3CBDB0D7BB42749390C0AFA8878DA6070E4BFDF30DF49B8300B773778E8
      A6367C0843EF4BB48E01753C6A137839C0902F1630E4C0B0E64E90C5C8134D25
      0245177361017683E8AB3EB7E7550511FF68FF485A612C936450B4B4DABE62C7
      4DC471613A4254DC3C03BBABC561710413A3952435CC5A8987AEBDC0F5D16E59
      9730AF0A0BD07336653A90F7C061DB42220D5A984FFBC3F879F46E59CDC4A5AE
      A3E36321919807857F8A5B0E81086F9910FC0DEA71CB0F6140BC1DEC97A3EBF5
      5C31CD048DC7E3AA71385F1E0D5E88A0278064A912564537489D899BDF34E415
      983CB4AB50798FC7884A695F8863849424F705BE923D781D3623C7268F3816CE
      D012DB5A1557C92BA23DCA734E6088E45B5DC6D1D782391FC20489C17015014E
      F15E1B977F5D44EF8B2CADAEEDFDBFDF51BDCC662D5BA46F57E031173325C434
      65EEEE014D30094337D9FAEC02FD5E60F404DE3A0E134BEA002C29A61E3612A2
      175F53A194E8198BBC144616400F8CF6CB243AC4717B0F77F5BA4C73D26A0628
      EBF6568484565EA89ABBF5F104A56FB95B3BE828B291498E9447369EB73125B2
      6307600BAD09B73BCE462C249729E5FDC7D0669527AB32129D5C3248700FB749
      24522BD5CE8C14DB124E1EEFCFD5E79F4A116AF0A871D6A932103B26C0AE52F1
      F1C9BB249B454F95701A3D8DCE936FF3EAAC18E3DF3FA7F5BBF9307A6A449AE8
      A9E3073F5532EC5325D8BAD77B3035FAD91FA61E486DA317FD173C4BD0F49EA8
      F2C04208AB5E5B8E80659213A9411597EEB04C6254F599D7C56E99088AC96A3C
      D3A4C457B7140B7F45BD7F5FC6DD74C51A9ACE1F8EDE9F22E7F3ECE2F0E8343A
      3E393D8ACEF7CF8E9490FAB8520E35EC69C90F9B7954C955D513DE8264D2FB83
      AD71AA61882924F2A81D032FEBA969904D0BD8752640362E5C4163578FFA51DB
      3E4DAEC0E7646566DCFB0CA3CC677271EE098153C890BC611C87E29173F3C971
      B93C38FE88B71440CE8712049FED1C1774943ECE3ABF972E4047EA27E212A83A
      015FA45D5DF26F1717EF0367FB711743597C49F2C0BEB11224548952C7B09D71
      74958A156A4C610DC63F6AC79468707279D6904A20850112C4ADF4F947A6BB4A
      45CBCB62968E3A827F51AC98D9969DE8679F0E3F4C44D6A362D9F3027C84785B
      C5843B7AA3A5C0544F0EA8DC80A4820FC988B54364061FB65D9753B28C154B43
      26AD02768BD931C6A874CA20CA715463AEA9FFBB04B07BCCDED20A7199F57292
      791862148F60C138B04EA8AA8A5D084BC3A5FF04E4E547957C109B862267C9F8
      0EFC120E3852DC288339AFA947432344424B6EE4C99B0CE9CA15D3DDADA2259F
      D600431EF34DCCD8375547C949279454CC28E128958390E4207C68B9E7BC7EDF
      89CAF538BCCA15B41029FF8DCD19B5A4C4525D194BB88D66C56C9EC540788169
      C1E26DD8616D579F55559202E41EAE9B19A3000EDE8911C0DB056A6DE9578D0A
      0D5932A6E153E466FF6D6ED67B7B12678F5A947A49AFF5E7C58E57630CD6B619
      DABDD09A350B7B55539EEE304CA26181A48A7C2CF73322EBE387DBAD7B9BDBAD
      9E80B51ACDE9F82F763C55CBBBED56DD4AE00B24F968D697DB6A0097D6021802
      B736E146583308EB02D0BF2AE3A938A47D2C3D2BD0A2C219541613E387328B8A
      E077E47BC3E29BDFD9AC630483C81E3E99D375E7B32BFD3D69284B186A786D8B
      0E74AD44AF4252B1C9368D175869CF5FB667E1F90F320B97F4D820F1016F2D6F
      89B72D01792E2F0E9624FFA12850CB890CBA4FF3B04B2F91D6FBB880B0BBA3DB
      F82F5EC6C39D3624CC512DCA488A222C7678E5ACAA56EE81A88A817D8060BC36
      8C5711888D47AD225E7AC729BEEF0EDFD5A4D3748C54CE897B2C96D218B6157B
      AB040F06E8D6C197286998445DBB168A129781C4EC6E96B422705D908F16A486
      73D8B556D7559CE69BAF0A314856EF4B654232FB749196DC9A58581DEB70DBD3
      CBE8BB68C030F2E587D3E8BBE858F54303DE255A5BF994E31741A9225C698420
      4070D15BFA4B92CC204E45900C7EAC610076218FE665858BA24091BC8543BED9
      9A2C27D7603824F769D2DA328B429FC3AE6368CB04AF8280208BD25F21C06D68
      B95595D103E4AE47E8EF365F02FF59142BF3EFF7A37F15788D321E7D811EF663
      2C01B479572ABFAE89BD5EF41D5F7E77F3DBF7E3094EAE764DC7A54831A98082
      C1560D4AD6700E1332CDFDC30882DD5A774DEB656CC18EFABA2CE657821E77F8
      0B6A2A091A66F0FA6D552349061F75918965A1DDD691BAD300E6447497836039
      D9D62931ECE5198A6AAE45ED57FC16F71E529831148CFC234E36699E93CC255B
      7DB3E692E9CE538B2DF1852D881EB62F160D1F2924F90A3A491C561EC4A7B43A
      BB63298FCDC55DA8260DB8318E5D22E7E521240EBAF657FBB6FE38FCB234B86E
      A4D027356F21D2F0059384A0816D5EE17E28E1A70191921D8AF1B2574B2B5C67
      080EDB769595A08F1713DBD5474DEE017DCB50C63788F6B1D6136C774B741815
      59312F37D6ECE0536CC2DDF1C86750FE7F9AC006613C4F8E9F7C0C084AD667A5
      DFA4F7C0138F6A47C8094A1B3AD0ECF10E821FBFD3ECBA9C83A67107CBC9E95F
      D8739ECAEF77E47926E8AF94257BA121A96A8E9A2A1F360489C23D841920A320
      5B523462F38955A46DC97CAE5648A85722FD211AC029B776D4C453624B717525
      2ABA50FDABD2618AE228C28ED0EF4362CC0A1DC88FD4F080AE9925DE4AE11DA5
      A58809272FC2885997632EEF24B3E6FE8EC22CDD85995897086432D67EE8A60C
      DCCCC0986DA2D9A11F3F422C2EC82176DEBC9C4EAE441FBFD76DBCC3D3B0C794
      DB08DAF76520B4A5CD27FF5D7A75BD7BF8FE44B6E4C61B38482D6C3E213C7C15
      8D93C226F47A4631E76AA1F4A3FC61128F28B35B5970EFA7E8D9DEDEFF6D2F6B
      BBDF42C77D47AACDD2692A411CC7A6D521311776185B8D4180C52234E432B09D
      9EE6C87652A383A379558B596577C7FD86B8F32E9E0EE7E515F29ECEDA95D516
      9D52F76D7EF92EE911CB7C5FEE2105B7B9F2BFF42958A114A4C63D49EBA7EB98
      C8BCADA209C16C861DA4B8D276E933A70506F35F9C94AD1E609918140B225330
      DFB2382C38015BFD7083282F13C5C4F0AA41EC7509B9CD0CE6EE5FB8C0C6C92C
      C9899383CC20414CEE654FDC0E439BA28C7E95D43E6ACCE06368E8898B7F8F00
      F6E0D4CCD0CD6C56214B39CB156D5A69D665ACB56E4039C0DF9A95612DC63D75
      97B5E6BC5749EBD9AB4FE0A0386CA0D32CBC13A5D66A35A30EAFDF0E5077B975
      F935536A4F4BABF7114D63A6F5F36774718FBE7DFB26A289FDE8085555B35B29
      59BAC06EE3061329517F42869A106C6E3EC33F9F7FFF22EA604C3BAEE3DDBD3D
      F2620FE56A7AB9F7E32BD76DF79DE3A33DFDDA11A51AF52D95AB4C9229B49ED6
      DAE46EEE7CE888E57B02D17735595CDBF043F8576517535154FF28179754C119
      A757696D09FAC621C55E38BFB824EC9F89F68A4A668D11A29A820F16341DE7B7
      D3A25C93881B10A554304D6924814E9AA017222A9FF86AC20D0D7781FDA7B3B8
      E64475B53829B147179A26C0923BA54ABC301D4F46BD62FFDABA17E4B57BD14F
      D1FFE23CB92577139774C27CA4CC5F334B96F3DAE56F7C9E3B9C5AB068EF52A8
      6B3D4D6B6CE2A1ECA9E320DA02E09EE0AC63172194801F9871E386D66EFEE696
      5FD9F2FB2A998F8BC596A542B49B99464764716A4F30FB2EB4B4416F74B3226C
      5DC98F61F64ABE845672D0920F5F93C630EBF486FB7E8BBC964D8EDEE0DB218F
      3548F770424B0641E358B878FD6A215D49133624656952BC7E758F7CA5404891
      8381219372542EFDA6EFB3BE05C5D03C157D4983CE172A73CA95C2C91E70FBDE
      0ED26F1461718AC5B70A8B04C59B6C9619FE59BD3F16071C5DF076A884F2F4A0
      17BD32B9B8F35B645AF908BFE536C1A3137229ABA8C4F5B28EA3C5E97C441C55
      EA358C8412D8087D4BCC4B42E72B5FE2ED1CA590AE72D00BE3BC8EE229B39A20
      3503D28520778CF24E940C5C52E84AB35044142DC895E25C3017DFF223E31CB9
      3F374EB1BB63890BBE4ED69D79742B96BB5B146384330EA496C1AA376DFE20A4
      34EB5D2A473AE3B2634D33948FB848041091A8AD898E31ABC965CD9489826C72
      351D7C387086B2E48822968B24294D9A53159995D3F321998833205A03229E56
      683752E87C691107E0686552A19C1B5AC5F58601CEA3EFF7F6DA6925B4A428E8
      3D69ECA83AE6DEF3BF7DAE926CEB4138933F004B411C6776CE8D786BB865A05C
      417849914095167CDED32ADE9E8489D75E7D8E54EBA7D7748F1A208A74C410E8
      DFFE0B27EF6FFFCDCD660AB9B033430344606A591F904A93B826CECF5AA2B013
      14BC49F3790DC305D593C8B4D7DDA398B79991B6F5999366BC4359818D57C837
      9E897085BA5241DE34EE97C944BE82212744295197204B29CD454AFFB7DF6C40
      B8BF92DF7EEBC82E8847AC442B68031F26D2EF94C5914A065CF6761665C5D586
      FD561CF12E7383A93B9B1A1C87455EB3DFD15F4272B4CA06B1383C5B5D736EF8
      E7307BFD2F5A8689174B38D8DE81945927651F1FEA9DB4591B94D4B736F888B0
      0D3D956CCF96C964A5DFB87BF0E6B7FFC2D4FCF6DFD15F648EF49A210CE71FBC
      B9240CD4457671D44866A1F584C9ED6A731693BB37E3BA55A099672E62C1E7F9
      8CA0BB37B99699D018923A47AE3655A88B229D979B4AA3A78085E84EFAC46417
      383978FF11B04712F0168264B7E0EAC4F90C8E325C307603AED8A2B3B42A3B3F
      B81C444D97D7C6C1878317CFEF3388F203BD7BC21BC789707297AA570770C7EE
      A960C36EDC88FA88CE7AB6C7EB8C84BC3D9EF27772AF361FA81312AC93B167EE
      93995A8C9319FE6303F357CB32A94367014867518AA9CE93511D78D342F3E6DD
      FEF9E024EAC292839A27161B158EE3510DFC5DBFAF4B45E3226AF384C9C9AED3
      5D40034255932A98EE61B254A51B6C4AECA71D0C35314294E368A8C173FF988C
      C7580881442F59313BC8D020854FEEFC603CC445495161D9EB06C125E12BBB1E
      2BF6A24776F36FBAA0201090E9373670B6037209C01BC638EE6E448E59A338F1
      AB2E51C658CD1A4032215329F3CB04569D9FF5622B565652F2142D02E4D24961
      866776176ACF504A0DFB17F600DFEC4990709CE602D01150B0483A5FCC2EBFA5
      837831B807FD812F67AFBB3E0B8F725E1E1C5C182596064FAE62D890CCA4950E
      6E87D9FE2C3BC83D9BFA8C10F6286D650B00C6C38A5A913D4FF6A3920AE0F41E
      0BECB1B2645B4F92E9BBC63F31F78BCCE6ED0AD253FF7956A2F91ACAF39896DB
      99C923D2AA872E9B1F2FF74A34DA5953D4974795AB129A1A1A80171B4CC6A259
      5C33D894B6D629BF8112A54474FC9C11ED421841820E4B57F73D41759C154BA6
      68B1ABAEC467DFFEA6EAA342FED3B78010BB3D78BB7E5D86EA939B75AD358ABA
      487435D8FE12794FE23D40C1450AA90F8C2DBA1866E957263A9AB3FF42B6B6FD
      278921C9552C1065A31F22055E8531635F33114A99D64113F86EFBD2D28560D5
      E420A0681A24C968693ECAE6A437E4403A2416E24727EA36143CCDE7685570BD
      F7EC79D571F737490E805340C865E934B74E9EF63110B868C188E1FA71E7E1B3
      E7DF3F8FBA3C2A77A35394F38E4E769ACA0341DABA646DEE8E66BB7A67BFF937
      7BD24F9A23187C00EAA5105FE6F5E4076E6ADFB058834C69BF53D5A42110E58A
      56AFD5006C1F2EA2D9D01E069DB2B88A3E5E1EFFD06F244F2BD0DD6C92C85ADB
      9EF1CF552A0729D1BA420861E0E9E218E65628C50DC24D2BE57103846CF124E1
      EB996E5F8387E04C3915D623FC3D8335AFDB14CB32D4F76BAED7CD2FC7536D68
      E5BD18ECBC2E16F7E04840F6221BCB160C43988DAECB3B62375FE578F5ED2EC9
      B88C87E928DAC59A7FB5D513E0D762827739A9DB3DE25FC9E85AFAB0B7D503C6
      3144B9E409CFB77A42925F650F7CC404C57E1FF808F89C0F7AC255524E21DEF6
      80279449F2451EF062AB075CCFF32B1426C81F32A3691D67E9C35EE41FF12C7E
      E8CACC8BF226B97A60476692D4FD80D1C0E93ABF9ACBCB6CDD8F725E55EE559E
      6DF5886AF6E09D56DD24E3073EA29E975FDC235EAE3D5E07477FC041BAE20059
      D22733EB5499C00578FE908E2EEDE38A8B4C24EAC824D22B9A194F81984143FE
      627DF248A3F4132C61158EE0B3E9E04A3A9A6BA24BE199D26C0F8943389938F3
      6D455368587C4D76803293B3288542DA0A1DAC950264AA8A3A1FA51654F8E737
      AED26B0854B1F80BF0B6B50A5D6232794DC4BC207F2C004444160DAED662DFCC
      C29CB14CA394D4038746CBB6D36A8A7E1DCDCC10FB0CC83E1414114A95D4FC16
      A6A5123DD2D54076F8CC55DFD3A5FE1718B0ABBEF705F4B322FFCBAB57AF5EAD
      43F93C2B94AEB908CC21B9C519C952BAC1C358C2BDC1B3A314A59284CAC0EC1E
      E6EA92451B038D5FAFA8E65BF7562889B0422681912A85A7C59C0F2CF6B46ACA
      A6D992DDDC4C543977F7CBF5E89525FCA8991D88D1758E646A3A51B773947744
      FEC48E1A5287FDAE9DD0990A6D7F37084BC464CDCBC9DEFC9B3DE227E8FF10E8
      E5A6AE6A32585AB56344AEF626ADC98E0D9D87C0127745EB1BAA4174D4444B00
      3FA5CB1C009AEED76EFFFF1BBC8F9FFA699E2A94E1FE929A2DCEB2379386C36D
      CC8A6AE13B7476294A4AB7E61E967FDB1DD990FEB3C8BB5E8AE04ABE69AB0923
      8F1807D54F74A5E32FFCAA520A3A075A43E6CFCB111210F6D66E9B499C65201B
      2FEF118EAEB9D653B3DE10B6D7752B1E6697D7F3F1C5CB9E17E9D12F6000E828
      EA644859C5E41BB501F4105A2D73C2785F386CE28B0AF0B0E8C913F4669EA446
      BA31122A30A5F11AC2D3F40E8D11187A87FE480F02A1FE54350CB94FF965F5FB
      FE8FEED9E07B12FC64C30A0318972B8E306D2875853DE97A354E2AE612DBBBAE
      A6932C5F3E5A5A0B1847B0317931E939282FACB9F0D1E81ACA462470F0246EC1
      3A305584D5E02E74DF6840B75B14737CD0225D95C1B904D65BB97816BFDF8C52
      84018A25038AA5B01C797025DCEA66C26CD4556868D99106E64D88572D1CC73B
      9C59416094DB282BACE7BB4C1309B1B4965D1944B528B385EFA18330A6BCE02E
      EB0FBB19B14784095C774E934694BDE4BB17A0CEB2E8CF7951FFD994C01AD660
      6B09350A037531C2B8C402C470C370CB1273B3F1685BCBBA34AFB262C8333938
      2CBA788B99AB8802746EF9A5B613EABA8D66213A88F4BCD16C974D879F376E5E
      2F8ABE1D98B83B9A35696C785B1CDBD4C1315E2233557ABE3BB4D349AC29D716
      4B0E861303661494E6E18A583383978AE60EE30A049DDBF0C00DCFCA35E7AE3C
      A527A6AD2F052C2B96CA754DD84E8EDCA0607370DCAE660E12B686A66176AB42
      028D1BE5AE65A3EA018DEB8556A4AD05EE8D7F1BCDDE7CFBF6EDDB4F4CE5508D
      6B392EE4A524E1A3BBC84DF7B98E1C897E84C7B89C705B0EF96DDB709665D193
      F1801FD80FB63EC79B3A4CE465BD343A30CD711C7E592211F6BD4A9F8017D8FB
      F1C5DE4FF7318F5C36C65A0BA39DBE11E5495CDE4127A093A699984BA54475B7
      2F0DE6AF768DC449B41FBE312865FD4F342460F787858BDF488C6121C8B0FE81
      4BD65BF3A9CFFC530F6ECB34CBD2D1068F657860E171AFBEDFDB7B16753F5E1E
      EFFEB05E4F73890560B43B37F64E05ACCDE1CA8AABD5CEE9DEDE9BBDBDCFA132
      3A685249F926FA550D299D94FEE0F2C3C9F9CF83CFFA6A0F1A1D1516691871B4
      6C139A4450AB78E2E90012A929EA3636D37E177F0C39EBEF8E4E475DDA02D6F8
      CE7DE7C405D6705B35DF23A8BD9EF2459C42A184087DE86EA3B979B97C6E8213
      37A9A69F5185CB25B574C9ED79B3FFE3F10F2FDE1E1FEF3C561B8F3684F76974
      400B4E79656BA87E8B538363F4EF7FFFFBDF7F6AA4C7E2E80DAE81074FD2B3E7
      CBDFE56066A56D2F93AAEE27D5EC8E41E4ECBD93DCA843DFB1D563BA2A59D7E7
      CA5C6FA0528B2B215BFC8967F096899509088898EC79352A918F2A5993165B05
      CD4652A1A62959ED184847A009C3F65ABAC1B4B35B11CFD54225C1E120F51650
      0D0A3EAFC5F8CF3F856FD5869478E70B98499EDF9A6401958E85D29E7AD42FBD
      3FE184F867D9FC2ACDAB7EFDADDEE87186B7F9C2C7EA91A6B9083E07592D5CB6
      4103928919BCA1943269FF4E4C54C96275705A118FF99B8D3A1ABC72AF559956
      AAE2E28FCD0C9A46209C356D25FCAD726E9283A34573ABA456944578E34893D3
      BA10A120FD3D16701B905D85E13FEB13BE0FA9E31BFFF6B9FCD634C4AB29D4F5
      06471BFFFE85FCFE62324947F0FD0F4F0FF0CAD7713986FD64AFB31BCEC0C60F
      7FD97CB1FFF3E983F590D7FAA70F8D18C9CBE8D3878D1FFDBD3CFA801E469147
      07D91C715A5DA68FD3FD57D2C68290F9C60F782D0F58266CBED23E3E9918F535
      204407BB50947D250F31A0D08847AD373076A26C6C965C8373C610936AD38940
      7F9B7FA3DA81816D27ABDFFF2CE0F24833486850020DE98DD5F2D75576C80CD1
      2A768E2EAA4B62C5F7875931FA721F41B91BE3E03A873C1A53E572ADF3B1F003
      29E16E39AC0E39D0EFC1836D1E69B14BE200C6CCAAEEEE6F3A75D02E072D562A
      21F4A2CE486BCDF7FB7DBEB8A87056E93485809F2B4556EDDC21C8AEF7DF0612
      6EB8FE049988BD0EA32C069D232875BB827D0BCB6293B20B520F157557548B1D
      77D985A4E5AA98AAA0A52808ACD5198C25EDC59E8222353B3DB7D37A3E3BB26B
      F5CC75F3EEF4C4B2D09684821C4E8D906C34A9F73D32CDBEAD3DB78DE9192612
      43BE9F65655D111A849D581D8440041DD54DCACAC81AD5FBCA6E152B054EAE1F
      9D25FEF97FFE078ED697645791B7FFF91FF16463F0A809A426908D5B7B5DFA75
      6BAF24DBCF36B63EA799921E24BBF3EF3487DA2BC3E2ABECEEAFFDCFA13EE4AF
      7FFFBC3A200745785ECA1621A660A9E67D10031A4B028C6467B77A792F95BB83
      BACCBE536D32BC9CBC11D9B4129755E91D3DD0187A5D522A90688D28E7F28D2F
      7E595F79D99D1E9D83F68EEFB1200D224F0EF5104EB8EDC7A02AA421FF3EDE20
      B90F82D11F0DCE9EBA4DA29C6709AD23A0BED65AD9A0A361A92B7F5E3213610A
      89C945F0705519223A1371163D517DFA22E71EF57252483BC482A5C8193A3596
      191D61469FACC4F1C2E2355B3E7F41DD5F63B792B68A42606BC40F698B7ABD7D
      2B95C2D62CE27D9D64E3688CDD83F61B2B56B6A788637BC74F8E8E1EFE57049A
      C5ABE82243B3AA6FB364474349EE9D818CDD4351E99819CCAEBC40328EFA57D7
      053214D7E7BFE8373D22643636E8ACB782777635A4A7C73432FE242792FC4D86
      AD4DE74093455CBEA13EDE27C4AF31986225D46A03A452045D140EBD2CEBF063
      403E5415587DA81EC97B98681D3A29C7823CF1E389779F28D6B9C11BAC2C4D1F
      5EFB0519DF67C55835BA37CB4DD22FC32C8B2689D4F2D274695DE94EB5562939
      05AEEC74AAA14E7CEDAAA0C3ADC93F758D81C527E1DD3D8BABD5EE1B4D43AB67
      591728D4294195EB789E09E2BFF06E3D6F3D69EAB7BE42A3528C00C2425F9201
      C34420A9E34AABBA32734783103DDEDE9643368DF398012FD7F69A8A4AF63D19
      51654CD7E8890C22C7D6B284BAB0816FC01ACDAF761C3EC54BCDC98AAB91A122
      784EC996EB8B840BB34A5C4656582F14773323162EB588A6FB0E9579AF9548A5
      291D55F00CEE359F240576743A4A67D455665C4FB4BBA07922278A988D2D415A
      A766829351CD3994F1113CE65A70FDF96CD3216550454AE619834407CFD34AD4
      742CCAF42AC545A20E8C0CE69A86AA049994CAF0A1518328B715230F0404B4FC
      265399B5CEAA1C2548BF6EBDAB4EDCF03658BE920C8A0300C6E27456DF2E9544
      D7CC6F08FF8B918E529494F053AD5FD7B74E3FB85B2C5BCE14332808E1B60ADC
      3CEC946921142290A498E74378C30A523CDBDB7BC27538853EB69685313EBE33
      8FFCD87051BA5A79568F4900B4B80E1B74752FC2E224AB5E4CD488E22FF0696B
      3964A49038BDCE42D5835B0853CFA95D8BD7058B51278A39F0523EB539C1726B
      4EB06C20E4041D602BA387FEFBE9830212F1736C1C9C3CAD39DF3C10A6CEA92C
      6F6F92C89DB1D6302356E9C15C5AED440FED9CB3CA467736E182303ACCFE5329
      EDA04EA77ADFFA28BA020B4FC2D8E13298E2322B008F55EE345EEB59F9761D5F
      C2BBA4BDA82A5C81BC71AA1A43526E420929E3F46B3A86D9D09824755B53EA40
      AE57C086DBC1E8B5AEC5C073A3F23D809124AEA07FC6DAD0B14F02B566D71D30
      927649C840CBD905D9ECE6D284C2F59B2FA523EAE93C3D14CD013EF843C20DE1
      C6647D0C7FB1746A43D691136CA5492179A58D81992275B35D5BBDF0068E7DE5
      44BC7BC97EF1F5B370CA149917B3C8ADD93608735F856EC1FEC22B7C33D4028A
      53020A17760C04F6928CCEC793F514394A7908D1C1FBDBCF1DD4D6C0EB9666AB
      3B8662581FB073D0EC52BFDFEF34EA53D6AD09A50A3296181F41BFF72C502158
      72FD98F6A64A4CD13D96465BA7CAA8C82BBD423462621E61A85EEB30312437CD
      60583A43D93D092652B15AC849703928946050A5AA5E51504E4613DE9D52AB68
      9DD5A02C5475F4C289D398C5D455E3E03B4C87195F4CF35BBE179A8583BF2EEC
      8C78F5ACF4022389013C5F720976447B6A9C286B730B06A2A832316ED239435C
      26625A18ECB9705483DB65BBCF013FB44B91699E0EE7B563ADF89A667A0798B8
      313B45610B6E183B9E053FF1A4147DB057A0F2797600208355D48FF669EEE03A
      4EA1A377D58037DCEA692E3DCB340D6B5B2C5951EE7BC2A9DFFCF0683D67DDC2
      6C37EBAB701BEFAE312CAC801D241E6E748DC066682190C2F70F17D1498E6270
      1B018EFA0C91E49CCF704C107C68AFC9E8BBE84004FF3FA202A0FEFB10C6C3AA
      660E3E1CB4FA491D4BE380058D0CAED349FD9DF4DC68CCB1E1E5A2A22B47098F
      321A7DFAE57422D10B194567CFB26902074B1FB3D61B68627F400B3F1CD8AB8C
      131858CD413FE467EB108830CEC21E2E2AE1DAF004A19540E3CBA79534045104
      3FA2E672301A9534D2931CDB9B545D473F1A41C853829A373192294C616835DC
      118FAE9BF412AF6603C4714BAD5D8702EE32B9D8163B6437039D66B143E0E229
      6EA63D76E103B7190535230B6E4B3D0089DCEC46469268EA9CB16A1507A1E1AC
      6FD7D6A098972364F9EDB7CFE0766372233B34C0C3074DCEA4C6386410D41B15
      95F9606C8371D59715F669400266D3DA3BEBC9F2036BD3573D2ECAA1F467171B
      237C37173914E02C4455D2FC013329D2A0D1E9853409204E5F3DD86BE17E0A05
      78FD986A50D5D1A417C6A36547BAA4181BE7008A17063C4364776C97D7CFF14E
      AF9F87EF94E4E3B8BAE63B69E1EEDD36B7A02909E880C729B0B91276519C65FD
      AD5A4CF3E82DA2B0A8F5893558E455329A37229FBA06619F20F44045F9587ED5
      8FF6F35B1751715132C675DB83AE347638D9B632D4EF5D7C12CD873B9F64327A
      773C88D282CE147705B1E4514E3198F5976F657CD75BFE3801ED4890C200BC2F
      68BEA97D238C147783509E99D71B68D180FC555C9B5F75FB9AA54B578B6DEAB8
      35C133487240E19034321B9FAB1484969871B5F6BA35DB92E61F458638A5F082
      9372BBC3FD7DC3CE3D573B57D936CE2E7097AF40659AF9158A3284A77BFB6FFA
      902EB4112B8FACB7A28E9BF6981D75173F712E46D96E6DF76B73D42B9ADD12F9
      1069093599B374362C58EFC3D9FF3C6B680EEBF9A1DF3D27D56C5DE9A6A596F2
      A2C9CB40646F9923E0045A7C9076C119B8CB380D6AB440945F527FA6C5984523
      3583B5711806D6FF06FA9A7C3543478246E1F3B6018DC0E37532978DE86C5DA6
      57578CCD9B6390273700F76869B987D37669AA758A2EDAB230FA0A6FA1350C2B
      8186F67739DE2DCA5A23E7C11B854B52CCDCC3369019E3E6B6C4B6C0F303DE19
      1AA76E783406BDF6C0131287B0EE85C468491946E0C899CF729D64AB5D9C0B00
      CC0B03E4557CEF1C1BF98E24AED0166C8AE8AFF38714DCA175B4BC7995D31E26
      120683A97E9739AE29AC1AE9130D9B865CFB52436625C4A781A98D80AC7D5850
      D84395874030BB7E56E12601A78B3A8C4CDD8124B558FACB4AD5AF57585C601F
      A9C0AD14BEB91B9F56A30C036BC5EDF45EF016A11D9D5C10ED43105E8D681736
      827C4D40FF3EA9DA59F2FB4C81F88E419F7EF75968E0157EE06D073920293732
      98472F979D1262CCD22D5E12C4BE7B484949356FFD7146338F3A4274A5D79CE6
      7FECA88690DCC2326F5FC3EB2EDE3066585F5BAE5F5E081E503AA25808CD1D7C
      38D8E08A5581BA252BC00D8BEB5E1055B10EDED130FA1CAE8EF578F02686CE75
      51B03131361A311E11C5D67A53DA27A22ACE2070A08AD1BB4296C4FDC8167871
      19A764BC56B5B6F5FDE6EAC2958A00FB4D00117AECC45F296EB40C7088ABC527
      77BFEDDC43FA770E9988F6333A9B33A7EE78802076D43EDEF52785CF24FCF5DB
      677B89D534AAEFFBD181626C125EA2D36489E8BC724521A4822E9EACE43C7ABE
      9EC77677DF787DB8B41B3F0F2D35FBA5B11909C62C8C4678C8DC6193F61C05A2
      71B359A3F441F1E692CC18C41CE2E1062F2B346EC5EE175F9222BD5A38D250D5
      25AF41E569D24CE0C33A6BDAAA692E8B922C1D2526E98A337F9FC20B96CB23A4
      E85F4D59FBB3F741FC8075D6ED48A12F2EFBA59FADAE8BBCAEBA141AA19F8087
      BD31F9DAD283C9A430A7921B088AF88BD380C2297D94072D937A5E4A1A98A417
      C31EAE5C1293B383E22A1A97F195CBD5971DE3B2801A05FCD47E5211C624CBDC
      82E7A34A54E20B979F5D8372D79149A1D50B8D073A2B8B6186F261CE93B1015E
      83B9B37A07A7C98BA8AF9AAF3678CE8151734535D9492F5931F324B505CC4843
      46A512DDD72473145C5B107ADB192F005E7C28FFCEEBCF58FAF759EC76C43931
      28939B5A2F1E63E08E935440811CA113D8C3AC6C1706A8711EF16B92D3668508
      5735F84E09B212AD2136B29F69BCC6518E94EB26E7054C1F0BDD5704B45251B2
      767DF300013BB3AE46AE5A41A3B8D28B3F6430053A5A2ED7052419096E194BCB
      7D5104D5B43EA390454C4E4930DA7BDCACA4680B4145118C7571BCE5320F21D5
      4CCD179A5DC1F3A5448B31DF1A2C2E91370BF8F6FA45D5119BCE8A12DAB18EFF
      7A138B5709C5156329029106B19D8613CB3389D38D1F515A4D997D76BC200681
      E066322DCA5B2B3DB74C2DB53904BB1CB243BE11CA5154ADB259A047169672D6
      75FFFA8B0A29337ADF8BDCE7E36C54F5A283836AA7014323694C00D725FDBB57
      F7DEC4484CEB0D9141D81B214B36E8B063C53550C10DBA20E03303C4A88FA852
      CBFEB5961BCAAB0A740E80387CCCA588CFBB34AF3B519950BFACF2877487861C
      DEABA3B6DD5AA362D983B154D4AA6E95F3EDA24EA9ABF5C21C50ABE2AC103330
      D4B93ECD18AAD4BD158BE5D99E55B789E208F22B05EA86A2BA95DBD9E2A8CC73
      F94D12358B8DC2EEA8FC22D596146E035FADB8513E333019BFE9F49BABE3DA86
      CE9319824E7956A76C09F0D148016F3398367FEEAF7F47E68C6F0269B356AB4E
      19D9CFBEB7823DBA83535454A8B0BE5023161628D264E8CEA17F7951FC2B713F
      76237CCF8B0A1E94189216DEF1E5678B7CB144E9C24DDF693DA6FBB6C8C63BF6
      DB8E2EA2766CBCAB8B49E828E57C8DB2DF9DF9167A241AAF55C30BD3BBDF4993
      9F95E6CA688C7155110C43DFEF51B35471BC346F5A541B272E2D33C7442D0FEF
      1763C3082F7257440B5538126F7402DA3B52E29CA2BBC487777AD17156C4E009
      232F8E03405579F940EAECF2AE75CF122223D33854986D5DFE0B8E0F5BDACB3A
      A73AF6A241833074342E8B99D051B093C9489E154C2D88330BA27613BA353466
      B4FA6960935FCFAF9020D17506258377C26D8EAFF2B49E8F931D3846B00FEE31
      87B2320C6744BBEBFC8F253F89BA2AF239BC5D3AC34DEA17EDC140F07F47E71C
      39275524596CD0F210520C6D8A6199C45F945969256F69B31D8B391C97BE3A00
      DC9CFB9510A21551272B6951FB9C015FB008668831DA2D0F429E121AF3A3EB34
      59770277A40B2DEAB8AB2B7E5A5449597542EF4C5207015FACFC692529B72647
      D7C856F87554DBD7D04025AEA8FFE3092B128EE2ECB238A37DF2B734AFEC17BD
      C8FF1A9F87FF2D4F5B8BD8BE68F69D806650AF39748CEC36639808A727F7D5E2
      03A2AE738B7CB9C19DC0C9A28152A92E46107DD14403976BE17ED0338D46DAAD
      5250B0D9046FFF46E16F5BE41AF1576B13D3E32E7BD5AB0909A914A2F0AA71FA
      8B625E8F5017DD98407931BEA30A64BB7939EDE4A694C24096C322CF707A1C56
      E90245519E2012CAD3D4B3449A0EA5CF75B12F4836455052625CC6DE2773BB25
      78291596511D33299AE15343F44B0C7264498CAC0A9526C210354A46F057D27D
      A3BA230F445D02377308D7997CABF3CFF8EC35FB52B56DFCECE9BCF5EE641AA7
      55D4998022430DBF4ED455390EB77555D817794B41716AF38A746EEC18735369
      3CDF028879DD0BE6DED145B53019A42683A18684B0EBB4458E7D86BC2D3C94C4
      942A2E75391FD573C87C9919DB25E2A539376101660298E247798AAFB66B3550
      5B0B3D9649249B9EA66E551705EF0C265BCC71CE19B8165DFAB42B1004E6880F
      23C26476B361CE1445D3DDBC6C4E2035198BEA372D28E96C635A694CAD5F0A7A
      DE042BF4405728BD87E41BB84318E92079403C0D39413903A7493CA93A321B9D
      BFCE7147F22B767C0A4626E74A03DE301079EDC9DA797B1BBD8DABE40327AAA3
      5466BA65C3E29B5724E67166F1F200611514C6D5A61952E0D063B0DDBF8882B4
      0A7A1F1C9D9E620691E7673587E5AB3B9B6CAE56E73C29BC177DD78B76659CFE
      0C21E3AA9D94A7A84CD4117811B045A7E7FEEBBCC8131BE693FC2B0C091719EA
      AC4FAE951C96A0A0AA1DFB564E5C1681B98816E5B53D66B925C14E354D584682
      2C6F44634AD4E3898D08A3E5192D0D5FA7CBB15C48CFE117D5097515D7C6AEDD
      165385C0918F304B8BF7F194E2D1B562C91B96540C83876E108DCCB03A13B74A
      600018CC374C78030241B107C6D9869A20A184B795AD5EF2262EC1546B183A45
      ACE1ADF4730DD86BAC56B01FC9B84364A1E39AEA1026B4746D29A4D5F310638C
      5A29D5B540410E67367036CC04941B3D046114D7AF0AB91C04F9AECB74F405D5
      DE2A119E707E062ECB82EA9CE2EED509AA255A9B102B5E9F5C7A21FB7BD928BA
      69B692C48BF5C5FDC9E91EF1749EFBC7D919E3DF4ED087455371231CFE40F5C6
      45BAD2123997F7DED59BC47A64C85A6A76CF252D77B2B27AB769C6C752021CAA
      645043A6958328890B834A7D7B8415E221CF56E4E58BE2CBFDDDEE8E5E2B90A2
      A958E8A113A8DAAD0C232D96BF24282B07EBA44CE0695AFA78D84A70FC593BFD
      E8ADA6725B622EEFFF82C0C4D9FEE032AAE64337B30EF50D8C0F8D53F2B9747B
      A1436915D71C835554C9E50AE7E1060157895BA8CA9D313EE6B9D4EB02CE82E9
      E11AC20D9A887D037A6F9A4739733A7738FEB3A49042B7A44639610694E64866
      66ABC4B9695389DFAF55E030A7AE6E6658157483F29DFE74F7B5A4CDEA8125AB
      20BC196375D1980DCBF09255AE39FAF118199D9A1106FE8B952F48A2CEFE78AC
      0F086385F7648D2C6B94139EB4DB25D1B6122506AB4EE952F1D5F2904A7CCE76
      70F959F6A03CFAE73CA95C815FF72A34BD367B99D5161309153EDE61ABDEC8A2
      E1E267C2A6557620EDD82EE646BC8A68BBFC90BF934844EEB3C9EB22DA3DF925
      2F6EFE761DD727D3C322CDAFFAD17B5081B402A62B38D190CCC629A5A12E5529
      D2C4B59C796BCE641B17118A1544377802FF826AA56CE5BE0583053594654557
      AC2A786DC96D641E9AA925AD4639FCE2E3112EAA5D0AF1F994EC80C083D37935
      723240191AB708962224E157A22E5725328B162FD89D8E5BB3CCF9B615450602
      DE743553BEBD229776A6F11D98D21F74E3D023A265AB7F7C606F906FF4224051
      D420D4006F344531CD89F74AB0DEF819B92412DBD162AB52CF03699E7EEF6609
      4E47C501D569C893447188A13F1CB194496C1A8BC6BD496F86D237294BCFE29A
      97E0BEDAB23BFA69A308A821DB5B2831892716CABE021C5ECDB6D040FE1DBF34
      30BE4502DA40EE00D93FE6770A9A703438A30A9CEC2B5F7645722FBC6C9AA0CB
      3C4803A8E041A5C1DFD322FD904CA25FDF9FFEC787377BFCBF672F3F63C00D7A
      F0995B5EB6F3DBCAD0887F6C5733B7ECC12CC34DC477C9E3F13A61132E072208
      040B8A1624FCA982419C054A98B298FC425C573B2914E7088DD6BA84EF846E7D
      B04B6A0CD199B603C1595D6A41AF18FB77D6DDFE5850ACA4B20DB3CECD5FF6D3
      20F2A7BB8E30BAC4611B4C2A755485C04DF9E0E930219018985CC9B73549A00B
      167EA32AD238AE63BBE6C3EAB949583F208E7EFBAF9FE369828491DFFEBBEFDF
      CA5214F97AC36445A7568CEF653ADB7840F95D4594DAE54C960E6CCDC3194EB5
      2915999D368DD1D96203EFD135EC0F575370B3CC081A99DCF3781ABE0C096161
      802C4EDEFDC7C83845072EBDA7C8979D282B3D2D492DBA9B39A7499E6CCACC33
      C658AD522DF8C5923C689F39C84551EF5612D26ACF4FE93CDF1DB41AF66518E4
      7CD0B65EB07E085ADF7CDC7EFD9494B79FA325185EB51DD1A9D93FCFA2592986
      BEFB4FB48F65EB458C7615650A12AB96EB623611464757913A1BD039D2C411A2
      684B434D5EE008AA10E443C09C87F1499EB7F2F99E3BED545F35CBF047434C90
      0AAD7B7EE50B234EBBF4A52D96433C58B0A4C5170C6BAE9085DC90A90FB4BE1D
      D412925B1B597D014A67C27FE9442410D34AD40F1B6CB29D5E039BA7EB471530
      C7B568D0818CE2654776ABA24920F5612957A2DE6AFDB6E235845845354E238A
      551DD7F36AE3852E2BFC57D06C3E0BE4FD87AF6F3A1A6E5D0732C556452CD019
      08354E17E45CC3521E4B834D8B3C67AB2E6141B8053D851C6AF8DC221F739153
      E07F998291331B341CDB519BBFE342ACDEAFEF7842277A6A2185BBDAEEAF1F39
      BC8B8DDE920D425F5AF6742FFA78F8A1671EC9C9E55927AA927FCE89E8D3B499
      89BDF542B4FBDBA78752519CA72F5305AC0D215D81DF9ACA649DB71783C1D3D3
      8B8B4B1748893E24C05E1BF194952F296B53DC2A099C3439EAF332C72533893A
      03CA7E461215A93A740593DCA113A469C0A377A47967D79C5C9EB50BD68AEA32
      55AE3A27115CF908BE7C74F2641AD19DD7300E1A313CC74827D14D5C5228710D
      AC8C7018465DB0688911CAB16E837518DFA08C4F39269B8FB936EE46AD8A3944
      15D2320740958D99912D697FCE8BD34C703B79344C870D9083BE16A555357785
      E54D2C3D00F15FF49FF79F69E2B743349750E317109749FACDBCA06A9E18A2A2
      5E01BC3D53F509EE1F4414C3EC114772D240BB51A1BCBCD4E2B9654A434549A4
      89A113478D32CFD534D8644D938B1D705025980E7A3C5122DD42A8B7A841F526
      93607D1985661438ECB9AC6A0711CECA623C1F11944C273C52245389B78147CC
      3171D338873F3D4DEAEB628CCBC9295DBB48BB1E7D18D9E0CF01D7FCE3A1942B
      5068EFE4F2EC1ECC30949479923F3904EB8975158B8693B7315BEC640941CC22
      0BED08CF9DC665A37500AD6142816A6151E6BB717E01B4616532B007CC32A5B1
      9F33CEB2F9609C41E500977C598F702F4381FADFE7D3597459B8F2CC1B8F8829
      1889F0F732FE9CBE914E25D5BC5C6B9617795F3FF53CFE8ADA64D7D04E76B0E0
      7D8BB7F4109A8A795D276357A30DFF04C70BEC2E756702A330F92716B2651B9B
      DE659829EB9EA9277798F2E1DCA75CFBEFAB9EC869AC4D231589F1A071F2CD87
      1E841E493549DD6FFDA8FBC1E2440B178A9C1FB87110889D4CFA3B48F5443B07
      BF1023E2728B8729A34BD5F57C3261C99F58542FE5DC08F44E5AE91AADCEB6AA
      E49609293C38DD55783A8819347E6EB54A951B7495B3A20FA353690E3E8920EC
      7970139EEF7F3A935B908BC75B78229BDB8BAE00C510971ECF5D55406F6ECECB
      092E1F24040AED866AACF72EFED393128F658ADA0AC504B1AB3A1DE908E92AE0
      F545543EAC578A6F26DFA2515194E33427AF3438D3836F68A5C9553DFBB01803
      F4E8806E0F01E619318ACBB100798D183357BE2DCA3591A2E5F16CF1B8ED14B8
      6C6E020E0967AD3B2C6A1023751FB4364B435E3AD888C180CA56DD4193FFC029
      E202788E70A6DF0B22353D11352373886FAA6CD67B609286BE5CCF6BB266D59F
      E08B947388C66F00B33A3DD640A8D49121259CE95284F10BA48A7856067BD00B
      3E446C509E178AA5B5E8ED48B72AD3AB6BA019650EABDA5DE0AEF30A64C8735D
      66B1B6D7C039554E46ABDE27D1C52FB0DAEB36A902228AEBC936B9883744D7E0
      D4E7AE708BE5DF68D03A18F5DE8A8E8A82959B8D253612AEE1349FDF2BEAE452
      06EB0231A20D3221C3AFFB2809869B35D500C6854A4EEF4E2ECF8E2A83A4F543
      668F9F1C46EF4EAEE0305FC2A0D2C0DF911CC23BD13081DAD4BA8DEAE6DA8A46
      A86FC1303F1342BA3CB6E35159545022A896E8F9AC1E2011E61C27591D8B14B4
      D87EEB866B3FEA04BFA183E5C44614A39555A0C93F0D42180F38DB39C3A4BE21
      97F1A6F0F40128BD8B5DB4896BCA23ADA79527837AB4F0944A49C1EA9C25E0CD
      135E55DFB80F6A16C29912396A371FFAFD81ADEC5FBAB7A03DBBD886B153250B
      AC74666238DE8E4725A8A569FD37359B5A52E3F8CBF37CBCFCCBABA14C5F5438
      EC84304902616B79ADD68E3031D2906F060721E8861B372128D954AC5C687EA3
      C5D597A0104B52B65F90665830316D852B319A8CC61A34B6D14EE37C32468A40
      C3ECD6D1161A5D71F3C58084ECC35EB00C828C790224525A6FCE3BD1291375FF
      121D71030F466581D46251E6A04A87FF16770B8A22FE9C8CBE20F452CB4294FB
      3F783DE8F3AEF50B47C58CC093D48FB6F7F55270C12B7098C5DD8BAB25AB801C
      0B1A2E2EBFD2B48C9ACBA105A081A163A2808885DA379D5EAD74D1093B07FA8B
      AA2CDA68DC283AA983BEBAAD97280D973DB93CF3651976FCA983457353344B39
      31E156845F9D0FBEE95AE24833A02D167A6393E176B8CF9178BD782E6DB8CDC5
      CA4313D3A96439B09985B3A7524627465C0D714970556CC84E8B3571A753679B
      B5EFD0F0B20A06574B206D747FB52983819E1D24C491B95BC73909DF7A74B75E
      5192021A5A58CDDB457E0A1448AE69670D69786E75F616089E95683D731ACF8A
      F13E07F4AC18BF55E05DD449EAF7E8D2FEDBBE7CE7AAA85D0010DFC2136EF026
      24375E014B0422842840F86B2751B849EFF4DC6D8E49B8C0B061B93583ED280A
      3BFB7AC39589442D657D9834FF1BFDCA219E2B3D2355FD6DAFF5AE9B39235A41
      20F449AE70CCB2905B63BFA479D8A64B4134FED78AFDD5604EEB7965E3DF7A75
      436413EA8CEC0E6F775DC498279CA4D88986928C930C60EB73BBA3FCE7AD75F0
      37F8DA4C55D70822965EFB1C700BAA31D63C4495E3A2C23040A2E0A6E2813CB9
      C2818297B7F1C4ACBEAF43A976C79F9F97740A98FEAD69D5804F98D821E726FE
      D2D5B4F9625E73447551B54F9B9D259573487573B5ED1D288AC7AE3F921101F0
      F990F32A99CC33D6EC89B1F525D6E8C222A2651B3C5F3111D3FF3419A7C6BBAA
      F5EFD1D44025D498736614694D42F2F28AAB84002058209C79BBC05A4FE750BA
      81D45A44E1F8E8F92E30165377F4D13E5ED61CB4A87B163BF69F386756103630
      C0F5180D13D47D98343849AA2478775755C6B85C6A9A5989A0FEE6A5B0CD789A
      B0DA9AA7D307DC586F32AD9496C4832CD5C73D064F6E3C222C66DA0362987E8D
      33465C0A0EDB264D482A53DB926B17CD86F63096810B04592904C71CAAE6A960
      8946D482B4F297C6B66CD612C0E3DC220B459AD566656066E3A17F4B7080A01F
      4B53BC4BB2592F3A4FBECDABB30239D03FA7F5BBF9B087E0240E5B4AF4BE8FEB
      3281FB1F5FADD691B0A7DF957BD8823EDCAD8FC8CD4D9A8F11E5968E6D27B98B
      B78178B957DFE4302F61D96CFA443732AA3AEDFF1B83E19F8EAA53C0B45CA1E1
      B8E62520017B44FABCDE8823FB5B51A8B8DAAE733257D1AEDC39AE34056BF608
      AC5023623986B84F31634A7670295ABF3DC027B14489B96DD9255D363A5AF2CE
      F65995945F712A7E48E26C97C7D988D98EB4A17930C9F725CD0FB7A3F61C84E0
      E808B40E845A60FE2519927EB6EBA2ADE6DDE8289B12952AF73F3EA91AAB3C58
      36A89654DAE92239335591CD598C10C09A64E8FB5871915F21BE1B4DE62C3118
      0EBE0DFAE6DB55D51DC9D0D858685296C586B905CD70B8D17F2DEF6EA9E39E6F
      D082CBF60D231EFED6EA1C92E1EB1BD1A52CB69B1167D766E19939DFA824D56B
      6BA83435A0BD848AB6A978A96950DDA7A6999E05BFE7506FD4C87D47DB9F627F
      E880FB66578FF942BBEEEC049602F7729AE6851FA62E13C55FF6F7FADF7AD1CB
      FE73FC4FBFDF87C5A9D5972A4734328B50A0399E425D13D44FCD5057091F7D57
      C78F722B5FB06D161E0E126F85C1DE9A069770A299A0F78072ED402A9329028F
      6563905743B96D0D2197187A9D5E5D67BC82D1276B41A663DD2C90C7201347D9
      AC945A483A9E6C499106B7F020852962480EF9A69BAB245A161E9475CFA4EBF5
      99CBA0CFD04A2AB17A50BF272F4AC7B36FE5FF5AD136D7BD3440876719E2569C
      201B053CCF8257E3025140FED9AF5A58EB49398D73B9BEDBCF5FD97D4DDEB1C8
      B55D285E432EB828FAD1B15C1EB2008963A8E18954904A957E606FBAFE26B304
      EA35B2D644CE0F9116BDB61CE8352D24070F28D23C4FEBDBFBD0804971B849C7
      A8DB0ECAEDBAE95AFC45D4950DC67183B6E6325DCD05D1493326AD48EE3A65FD
      2CD3A6D5128D715EA4D3F954BB524CA2EB3853FC5963B0FAA706D953B7ECEAC6
      9C8CA6A5562B49613B0B7660DD918A40468AB5AC36AB76BE49AF9BC3EF0A53A9
      95EAD43F88AE4832BB08DB4A62269D7CEFFD09F4B2D52B1DA74CBD5793B04E51
      3559E932DD90D6BDE393BD9AAF67A11FB809AE7608DD7F703F64236A35B77114
      4F299DEDC7CED211D9609542126C81C06983A2B40F754508B7E217DBBFF725D6
      B6BCB85B7A427DF064E7E55D216028A21FDC20DE6B70621F79548DCA24C91B6F
      C86664113A20B2D182308E19A35888BCDEE7D506532088BB40A086A04CA857E1
      DE9A9C0C99FAFEEF3E007A3BB19AB66F285805547B4994DC3DCA5229991074A8
      A1739C2FFC5463F2AB562FD5CCCB82A73A12CA006D5C97F3FC0BAABA3A05177B
      28DE2DC8A459D5A5C79BDF959946E84A5E78560E997F2CD95C16376BCFFACE9A
      DFB72F6929A33A7EEA8CA78660C16A21E20DA80C8C1A6F77049FA076A1148717
      8D5B2FDF207965E3B4A2480318E288E142835769024E930B079EB0E8F1066F93
      3CBDCAFD5F0B045C61E8631A1F52438D55F6B06B8CE67E675F0D5597D478A9EA
      AC9DDFE905F3C42EC96FB5849A1237B6EEE0828A7B90D9B8E1F89D99A41D0CEC
      708DAD1DC8F5999FB414932CD6445466FE301FA9B18F5CDCE29E794F0D4579D4
      BE08DBF9E4DA599610E573488CA937BCA5453DAD9251E72E65799DBBEFF7D603
      E8CA3B9733917D11D12F1AF664FE881412D280978C8444EA17FB2DDED8F036BA
      560165EE6929A21954DDFC92DC52609763EFD43CC4E3D24D2F7D3208DFD938F1
      94B974F852BA807DB62279AA340D8DE622DA33935D5ED9E942106A42D538E328
      3575094CB9CBCE5B270669BB4DC68611590ECD36C9C7FB194E8818FF5FCA5A97
      657CEBB8E79B572D58F7A09515092034BAE9E1DA8378AC02EE68A2D2893F2872
      5131A8767C690AF466ADD59E5EE584C908E8D72624F07FADFC914002DF62306D
      7B2EB38981118E07B0099D251E31615214AA29B34080567B5B9966B41F456FA3
      E8ED4AF43B8A0EA2687F65ECF6FF6BEE5B9BDB36B26DBFDFAAFB1F7A784F5D53
      138AB26CC571943399D2D3D1895E23CA76E626AE299004258C49820140CB9A9A
      F3DF6FADB5F76E34288A9200CDA9C98794259140A3D18FDD7BAFC77FAFF8A3BA
      9058375837872A2068F2631BFC40531F7A9AD5CFE1563F0AD0B9322A184F2599
      2067DA86810CC3A83F55C89D3A68786E6BCBF85AC39AD1D631B4A625050DD565
      74539D9F439120DA65836DC52454C622A635579CCB47ACEB67A16C69D4EF041A
      73954812EE57C665EF475AB733F1C6471C2F8FC0AC592291D4BF1507BD683ADC
      40BB51347ED8A7312016326CF80CF19A4033D2C4DE94E3207441F48B54BB2BC5
      0279ADD8D9B185304C47902F722F3CB0A5E983D466E91EC4597E2F669BB8655C
      27E361164F3B0E0F0F011DA9BECB2D2101A4BFC64E200F41E58E80A4F11020F3
      32354D4D8ACA9589ABCFF1AD309DE779CD2812DCE2530CC73FB303ED7DE92B00
      CDABDE658BF1371FEC8A7CEB8D2FE9E57401DFDEF62D5DFFD106D7FA8FE5CDD6
      7FAC4AF5D6BA63E0A8BD2D3187DDF49EE742EBEEBFED23546AD40044DE3271BF
      0A70AB5C75F57ACA24F10966F9FBD906DAEEDA38A1ACC1229C587BF30CD73FDA
      186232D90F301E01298D84F36111DD8666A768A8EED48F708B825E8E6F821A84
      DF7F57B877882CA3A6D9641DB5DB2DAF210445048B2F0E79C9D05DD213E4B43F
      5BCBD4CBC5775679891ADF6900EEA1FBE4580CC3D0915C698942E57C8867B687
      7D44175155FBA18EC08766F7F6FCC319D11C89598A8681D63E8EFAB118CBAC18
      B177D7E6E0ABEDB23E617BE252956C292A315F5265B358AA40F0363E6F621423
      F6C553F135593C8EBF00C906844D90F2590C5AA6C178900614B733858A62864B
      A29ADAF91E46C54C35441CA50AFCF4F7A0BAC8D02EA46B37D647700C94B4A818
      542F3127B486D6AFFB713CFB24F21681B6C006A269C02B1E42CC33180E0891D1
      9D4BB62BD754D5537FEDD23C47308E0B1058C4C03EBF5F51498902CF1E126035
      F456B1554D2B45EEE3C5F13E23227771707851FE1E9F5A33926429981C440024
      162B93167BF49DBEE4F0EC3E4D41D0CADF5AA09144ABAC07A60A230B43BEEC8E
      01B357DEF26A7A18761511B135F630A78B9DF02CA18E7A183012BE05965C34C8
      8A78C48BD58C9F6410DC52C1803595175AD6A45594CF925820177A204CB1424E
      6BB2F8C5126B1F8D93E2D6B5453DD3E47378AA16C684954BF18EB39458B9BD9F
      D7087FC3F05CA6A84E062326633CDC7E3C05E568FA7728E5814293874D7D6842
      ADFCE2231CCB14A385587085F0959E30023175959FD28C31EC8A16FCF0C4EA39
      F5A387BB159A1A8CCBF69FFC180A0539701CF5AA8755152B81ED330826F24FBD
      76A1150416226B30DAB459168F923BE6870B4712CD2580A7B9786A8007A3F9AF
      038523DB6F1F8F70B42F1B0E969B52EB4ED7692CF8A135B65A68D812AA8E23CB
      2DC0966C294CB2E0465E89F0362E4A5E76D9EB158D4711A22006AF5CADD470B4
      885723453F8A94C2B69C7F2A1EDAA76797E6F804499A8A92929E87260A562B4F
      45FA3EE4A7C4A4D640D97C02454B7789C1C2C6E3DA0285FA12672A1F50EE152B
      A7CDDDEFB54A766F98E832F68B280DDFDB0EBF413D4A44F734A0054168ACD2C9
      78D9D630F473C92E09B3321EE45AE95E5D7C1F034B58DA055F22504F45F19582
      E152D9B9DB86CAED9448A3DAE1CB35B799321EB0AB2ABABFA5AAB6B50416891C
      7BE60B078CF555625C92C1759A08F1B9F557E84308075865604E53FF8BC7F481
      C63E6505E02ED5C6BA60E943853091079E4EB7648637A67451E94126F3F56B77
      9BC1840E3EBFFA458466793C1B3D22E0976599F8BBC54DA443566E255CC3F87F
      D2345CE69AA8122401534EF2140B2ED2A3306A30471179527D2DE51754284F27
      CD78BCD8516AEA550AEAC875A4118122D4DDAEB7AE949AFA078D08F634229000
      A71A4FA423C813A0171979442A8115F6ACAFE94DE6809C3E21F526DC22DDF241
      B7C5803FE81DB71E2F1E0F91BDFCCEC6CD57E837B81FDD7F1C1E1E0A6FA78033
      A09C4CCB10802657145A0FB6C5FFFC13BF46856E2E0AA308AE63216CBE48D107
      D3DB8AF1858EE24770BAFE2D77A70BD3DBF6EF244B270F93ADB5A0A4E6D7A549
      A33D557E1D41150393C04795C1117275ECC7F5F0BEB1F2EFD9C5ABE5764B0BBD
      48CC2D3073C976F62125B53728416E9E27E1EA25EBB2BCA927D5F9DF51EB5EC4
      6303234E74E6D9E9CE89CF8EAD7A9AF5C3E4EB39D68EBC80FAD7C6FA695AFD0D
      DED7BAE4D57151F980FD14DED6145D44819F009020CAF78A01CC71A0CF2742C3
      565C34C9589383DE49327A1A906D1CCD24363E35955CCBE4AF8E7402495DFB82
      4A091066F6EBFA2797DF4EFAE9B8F44909008903B9B1AC380F18134813452D3F
      FE3A5369795FE797334E20832FFBA9655EB8D251964EE9735245A54795EDE75C
      D7E0C32931094EB9697695D286BA5294C67D91D7F720421D9F14F84E391A691F
      82B53FEBBAB684FA9AE731251DB584E32E856576E8CD8A54F2B9CC0B9926A4FC
      C1BE690060967E92C079C5EB7CC9051779484B7236965DB483B024180968F582
      1DEB14EC1865A9569AD55C4B152FEC45DACB111AF9E2EB60E6ABD48159949431
      9BBCF065611B1A8F4BE56C7E14BA22FE2A0827B1325112CCD21AC869EAD16E78
      E7E519A36B11CDF7185599F010E93DD1F85CD60701B75BC669A090E607246944
      D5EFCB87C3AFFB5E5D7201F22AED0E3A2DF4F3322F78CD76903AD697AB506E45
      150AB6003DBCE41EBEB3792D41FF895DB228C257AE61CFB1BA0FAB9AFE7E8469
      F2F3D7F54F1DAD5C85FCCBB267FDDC97ACF8508C13172F338C734A58AA7FB966
      7F5FCAB13E2CB532572539867C292C478FE648652B5CC844FD08CD0CEFEF9695
      7203D325ADDEA3D955BAACC88BA5374F00C29F22C923619993BD37D05A7F1098
      56FD76CB4FBBBB4E2556AA2D41530918725F1F8644982904085581B8A98C9E3F
      735657B530632E689AE6B02464E511F107353CF8C66D3EA5985D3E8E6E6B5C10
      CAD49869843ED4737E87F3F003AF431BDEC514C68223519086CBEF3863DD6319
      729FBCBA806B2AA8A3D2D7987808E56156DAA499373B22A5B636516EB46C1EAD
      416907B67805FCF9C9661843378AE3213743CD9071B6F90CD94A14E5FED26F80
      5492C88A56FAA785FE48A1CE7C478BA6F4DF2003860711A4CC20DD15BA8569C4
      D2125FA25FFD0D3FA9D1A67CC5632DA6A91667EC2F7EFB1DA73C62AAC9B23934
      1B4D5E9A56918682784EA88DAFC34241D78368C1332114497B54D18AA84DE1E0
      E901CF744AB0EE2F762F02A0404A20B522A44E4D9CEBF2DBBC882748553E7E40
      AC63BE339D0AA605872A28A93EF27D68EE95DF0F0C5E2CA1E6A7E11D4314CB32
      4D87AAB0668ADD5EDE9B38649C5E6599AF249B03716B0687DC90F2CF509FD7BB
      D1B530B81F43972512DAA548B8B73A7CC209259AC4C7D031DC80A81F6A37F869
      35382BF8A0252830220FB77A07B6AA9B73E9C3B934A8FB6B9223AFF0ADA931A8
      6283464933629966744AAEBEFE020C6041A6957F0F4DDB8C1FB5106C99C175D9
      1BAB01D2ADF3A8B86E1163645E9FA5B28215C030C31E766FB35B43D856EA92B6
      EE2C59CDCD5D2E99EA93DE4B780C0A2E7E67092C851F6B3057CDFE54F8D40285
      F6E7470E00BC31940FE4244F068C32D2653D13B945ABC89076F580EC32A726BE
      46ADCD727A2E022B1140A38A19E7C16CF6B49B05D6C39DB79D4C4B5D7015AE56
      8568D0BCE4B5EE4683CFC83ED21086566B4FCD02DC35ACAB08B8AA1AF7D7D554
      AF1DB5302FF540975F235867CDFF22384D867A99A685596A3AF0353D146B3313
      27F21FA1EBA53737121FAF204B056B4153EC56FD528DC00DA113FC1D85673820
      4D1F98433B92CC48066E12A301493E29C7465050D5B31EC22A4529A723EFF116
      C6CBCBBA083E5B5E82C28B86DC0D32452869EA4FD18B471C1DAB4B001FA50A13
      F1CE25A643EB95BEA97AA012856B0D795F96A5BE52E28E8238894AEDD4EF423F
      81A5F35A590C7079F2256E2DE9277D340230F1F1DC7D38D9D9877CE80CE2B022
      2FC5CE68F5E8FDD74270D5DA21AC341D39FBA578AA320B284A57E1564A1EEBA3
      AED3A1D575EAA2AC9F1419EA98A6B30A0C23C451110122864606E581DAE672DD
      57D8FBB5F1906B50A24B663A0383270E43E9F747AA00BB23BC5042E1459B1BB0
      A8D515E7C5F2C1D17494FA33542C2E4B55595BD645AE4933C9DDEDEDEDEDFA64
      B23E1CBAF7799C6DBBAFEE0802CBDBEE169D07835ED7C60E341EBB974F382EBE
      E746896D28CD8EF6099A1D4757AAD22FA2A453A96F3CB09E2CEA0B6F1C9E7DF7
      C61DEC1F5DDA53060516AC3B25144C77FCA8A4AACCB224CDB4A0329879F3A2D5
      5B9D4FF4483AB1AAD8CC3B52D6879B2BBC5A2B926CE1CA15E997BBD068B9A32B
      A41663D66381F30817432FB66D4920986C5309D53F9D9CFB48996AF9429A9DC2
      EC53AB33F5AA851DCAE9D0C12BF70DF3CE30D6DDC934E8F08AD292EF9BC59EE1
      398089F6F26E42CD53439845C9257E8B8410896C4A7B04B6AE9210E5E1E3E8F2
      E449D8736EEFD4D896103E2AE20DDE194593E84BFC10CE5E05A3FDBA1CAA28DD
      73E524777F9BA6C5DF82CCB4CCE00000D2C6E8974336F2BA6B554352EB830AA0
      A42CFA3CFC548FEF225D99508704BA8D8EAD176758DF8A94103709C9CB28B50D
      B45BC7EDECFD7421A7E08E3BDE39DDEFB8F37717FA614A5F433E0D57040FDDD6
      C294B0DAF65AC52F34977574ED114604EF8FEE731FC0BA5C7D005C1A52A0FE41
      82105F211AF8D2830EA53B152BF0D0065C3853AC7A4B65868C391440536E3EDF
      B8AF1D77FB206DA052352BC1A9791C65C8A6904155BE7C794854D545DBA88A2B
      91D9A9DE9A1C27C82E18AC4744FA18C74BD2A17A550D73460C79258C16EED334
      0E54621FB969F274BBF886960E14AF3BA803A6BA813E28538F6BCA1EFCEE62DF
      B59982A2E785C9E1F1797561ADF23867712668CD4EB92ADDD3ED95A2CC22A027
      E8626A97045128D4D252B94BFE08EE978609ABA69BD4D2CB51C6C26AA2F7C0F4
      F0E229E87E3D75F8D091E303D6069A668F0A7EEFF16742812DD0462C4F83E3A0
      E4121910852FD077A0CC7BD1C87DA24293D51B54A080838446E2D6475292B157
      F0702FAFEC5E88EF896DB36AF1147978774504FBAE55EDC94EB80A3020F27FE0
      55439A59E8CEAA40D9B274AD4C275091305755E4513E25EA6E7C5FF252F80EE4
      F4170ED6FE9C463C101E0C776DDF66EEDCE5082A7B6398482A8F9633B2F5DA9F
      6CECA8F174F96D599038C97CAEDAD0678136A7A8BB580F611E31918B8FC89884
      05AF5040BD0CA8CE5DC349095A800429AD9BF089F1052C53F80B0854AC79175E
      D4BA3A389E10E8EED871AFA414E318B184934B67242419A4102536E773240034
      A67C680FB8D7B111C305413A1E6884C5749CE464E9558EA23A5269043E62BE1D
      41EBDD66C8D2E115D24B36A7094E8A711151E165F14F2C8AB430C871448AD8B2
      1CFE5D49AB003067B0B648A4AC0198D41554106065D344E38FEC06088971C695
      11587945259A54B25456D12B999DCCE7CE67AC0FD368A5EBDABB82F8A01B5805
      A51FC008CA0797755266BE6245AAC0BD1B282CCC56D7C685012459BA6A2E609A
      C2474557D14505D268E928C45F64CF2E57A670596383F168D8869214CC062E2C
      5AE8BDBB1A54B2900B92BF250DF39E0253B8B4691F5B169D5947BBB46895113E
      8D11202B87C003C04B0CF294F68D4754B79EE2DE20E67ADEF549AD9A96257C1F
      035861FDD32E1946B48FBCB65581AF8979A770B490D4F412332803F4E341845D
      02E2A6E924A6F79FFF6069AFA57352C6E822B4A752C6369A8C1EB193AF0A1228
      B772665C1EDFABC767FBEF4AE9EF95198D282367C584B7EE662CF55AC8C81289
      01371C38F4A4D33F3CBA3DF4821D8D53992CB314DA64227709FF22FAC6A4EAC5
      B272613E915A9CA2C9686A64C1BFBE20F3B6C1A628362C0BB7D53C63DB2F1188
      074FA3D3CACCF2496B756C61470CC1B62A3D22AD2E18DC581C0156A790563CC2
      4DC593261D20CB6765D56A4F21A3A23F96848C47508F91BCFB3CA56BFADD9771
      F755784304935CDEC54A980F23C922B02A2D60EF11608A969D8585A07CBF7469
      B795C81BE2408E1881C4D5940022E63AB98CFB3C2AF240926089A6B70559CE28
      99E333FD2CFD2C6BA628ED4539554B656AE101B1B48242812DF109C6EF1F5331
      5A2482E244EC6A364A6297FE06E3EBE2FDB41462DC19274CB3B9BFBCEF5DAE3D
      743A5AC82C2F54C2E88AE1714B4CB052D6AE1F1ECA3836ECE6C7BD4BF7A7A076
      22ADF992E34F7B3DF72762EBB47C19FEED187F3B4E355FC1BFACDD7394CF6F92
      45CDFDB28D2603579EE5C3EE93546CB503ED1BF7B09AF03BEDDF273323D59359
      12C1ACEC1BD8FF91367D3BA68E401AF6420EBED43C9083552859934EFA693FFD
      6A869AC14538D3C7C92429161DECF42AF65DBEDAE9FDDA04A20B164D6F75E418
      241768DC874FB2958387DFC5A5092C7C86890A6DD91DCC61E71E2E055D6FEC1A
      D52214D6371A740885D2B57B36F987493E883274AC7DA52C55AD5E4517EDCC28
      CF0929CEFF8907091F41580BA99E06FD714FEF1A3E8EBE04B50E338486588D79
      9766C175EAB7596BB70C14323EEA3BFB281B60DE4D8DCC22BBA207A9D08E383C
      B1416A82C7BFB9F2432CB5C6304097E645F6CB122FD7554100DBC065FC917391
      CE5343A812ED0C8782833E1A9D2474996B473152C9DBEEE8A68F7FFCE0A25C3E
      829F3023B671DC4AA6573FB8A8976685FC31DF76BB694A1BD93FB94B10F57FE0
      6AA7A40AD3E588C6AEAF1F2BEBDD7749FEDE3402C201E5B1C0A08070CC32FA0B
      C93A924C7AE223E74B1ED53FCC658FCF98AFFD802FC8C1DDE0F5766F5422F50B
      3C6EF26A9410B48612BE2CC128931642457638CAE21B41F75518D4DDC73DC96E
      7C954C05C0DE8E148CC887D17FAFFD600E65FA8583E970F5C71760E6E627AD47
      391CDE2C0FAF16C4FD799FD229AC46AA644DA000713DBF82BA793EC3A11B33C0
      5C3C36645232B1CB9ABFA9FC3C94720D5BF838F9A22FD14A8C5459CE645FEC19
      6DFD87555FEAA3E7577D6063A3DB5DF928E1BB2B9BB0B6F2AEC5EA84DFC68664
      F9A3A93DD4ADDF178B3478D0551751C7F4551F2947D1631B1E4F878DFE5E8EE0
      9BBED0660E1007EF414EFB381D7C5E1CE7773FF57E3AE6E7EE1176562E8ED7E7
      9608D09C9EC304782902E693344A97F42E43C082C0C944B47C338107DD24AC32
      0A6E21B48444380D3A5809C99A3DB04723BDFC1146EB3DC8D776DC0B24177E3D
      FFF4A2230B2FEEB9FC339B9D6FCB4F2D7405864EC4B255169B5F8F6DBB6BF7D6
      7D02C377296820B5F5D1FF72E573E8B28362A0E8F4E025EA2F4F239462E5D752
      6261B916568482C61A4750719A12514FBAA644164C475792642806289FE3D13B
      EAEEFCAA0656494C2F00B09F5F85077EE61D8CCD021C20B691648A63219894E2
      2D36BD5DFA358B102C67C428DEAE81A497820617F2718FD54FFA3FDF7EB7E5D6
      110D0D3E33A70ABC853ACFB0AF5594A5F8A6CC46D5BDD11BB76E8EC6784B3CC4
      D24C4072A525528AC775F3AB1218096575EADEF83BB7EEF6E9C7B8E4B6CF7DB3
      EFDDBAC9B06B3FB20432CB40436648E1E2E920658219A87A60886625A226CADD
      FBCBC3F5B7624EB03E986DCF8BD1FA5B0FB0AAD9ACB7AF6152324CCA8389A602
      A20CC285C80BB314A271B2C8775B829CB179DD1B63789131AC2A0F505963E4C0
      72503C99011300D422D21A5EA6AF4CFF21F9975359C4B6326A7E06298FCDBA4D
      FBF6CEABF256BA6AB5944E0117B1D439ED0A4BC1271064E28C27C93C29E64B60
      F94F680B2687978A2B0FBF09C6663AE32363CAE795D959F7669810FE5DF7E159
      370239CD2E2D665AA0F169EEB5EE7DDEE2DD5BF309DB53E9D58197024927E910
      0A23E50C788E07C424ACF4DB8BDC5DA759F20F6CD163258200E03CC0BE8E242D
      378F7E5A14E984CE91186CB7356FFFFD4BB7CE3553A56AD187844C86C79C612C
      F390A1B4929E92113D1D61C70D5C42DDDB63CAB5907F023557F1E761D23ED734
      5FADEBB7FD2EC7A33DFD98D6B085E889C7CE46882EA406629364906483F90435
      9301D3FA06E6D48CB2A9BE4B68F4AC6D93D3E1064733FEB1ACADB46515825992
      4152C6B5CA30A6152AD34908D7F6E9546DBF2AD1D0F9B7DE66DC16340A958CD5
      AD0AAD3F8EA6577324C4836541097637C803A723D7959D45DCEA782EEDF6F368
      A3DB8F5E39403CA012F29C4D7A7F79F8B6DCC6108F8D75B80D7593CB155B10B9
      5184A936F81C00709391FF94B0B6593D4886BCEE73B6338B47CE939E483C6496
      7B124F529129BB0F4AD1F0BE1A8C6A89B77C6FB469C2389FC52C632279661C65
      E4A1B8EA0833590CDE701ED1FAAE805DA5AC329FEA5F9EB5D153E23349BB0F52
      A965797C23288DDFCE14831B4A36CAECB182DF82368394A5FCA2478DAA1BABA4
      D58C5EDFBCC4527BC1592FF9B8E97C3C36DFD0D9CC0B954990FEAC8B8ACFFA06
      9A5F1E366E6B032BC3A8FFEA87E6D322196BCECA7288441C328C5F4C61356DE2
      AF87675B9FDC21841292A97B777CB64BCBBB2C7DE6FBAC5A31492DBE0BE01200
      0B165E7691ADAA22E2A88EAF773B98D0C6060632F73D0073BA5266D97B58C3A7
      4341A522851447AB7CD7FE6C7ABF66CEB3365A648A82561358424CA82F310933
      A90C4FD7AA45795016A1A49DD1B8157417B89FBBFE385A60C9356D2B8FEB28F4
      FA8E4AA68E95A867DD97F62C1EBF4EB362304729908758C22EA4986CEC6C2900
      2877D1C05CB7A553EA7336EB229A0ED389DBF9509DF93741DDE2597BFBF26CAF
      DCF6AAE3339DBA8FC9F4BB67BD9D746F02455F71E969552C66887028B1CC554E
      B63F642653E4861522E8CD6BD4E3E6599BFBD3D1E5C941EEDABAAC9C5310D1FD
      74441A0270184E52F290B3C681939AB9EF2EDE9F9BAAAE868B9A214FFBE378F2
      BC2DBC23A8E0DF61691568684A0329AA82F047DFE3CFDAA25D7501FC09980615
      35C8DD9E32ACE1B98B4D85C7C88D413A86CF2947B7AC4E83795E88E0CBA46E1C
      7A4FBB0C6543A35949567DDD9F4F08A19B7A575C441FAABC1928E27AD2C612D9
      D4E6A721903EE2AFA04C6169E5A96E1478AA715353600AA214D40521A8200471
      1EC705C8FCACCDAA663B34A74AF02D4E2D7043BC0EF27050C701C68D86241ADE
      093E251D2FCA65345DB843C59CB39FBD396445BCA2248BB3F34A0950790E6A53
      6A469E5C1C56BD59D31465FAE76CF04DFF6C34CAE30279C5BD749CEFC14846F5
      EB04C496B164563AA51A6F5E7C1B9007B865AF3F67ABE65301040835070DFA12
      8D4B394699A4C9D47F8E5E96A0D170D811FB3D4AAEE6E6D5B0F9EA5A2EA533FE
      399B1AE404612F9D17AEFD27FC5BC154A61291AFA1E304EAE75957C3D8B39C27
      E95065139F37B662C6A0C3022DFF81A86A0F656B34D94AB6E146C00914A432DA
      66D3C901100A2748E108F6A18400047865CB477088BCEEBEEEBEF9C31FFEB0F6
      CC912E910E10384494B06463613C1E2C02320583EFE1F27AC0C52598198D4780
      2B41C4BCA4441B26423D8345A28E0457390529F21602B3F1E033503AE58977C9
      6D39E7A1A700E58F6822858F67ED9B5EEFC0AF8F3EB3A3A6A8320196F354372B
      513F5F1E1A6B9FDDDA7ADEA1F9C1A08B2574D882BD67BD9184666E60A33E1DB9
      FDE806B9A86CD88DF389668773B72559150FA34308251BFFEF73D4957885676D
      DA123F307302AB588F968840BC9401BC35F4E38BD90A4CE53225B90430DB3822
      30C490301ACD864E8A1C5AE4330C936CD3CC484A4AAF4B9E2332255C8E25CBD7
      8FAFB173EB9370FD69B231DFD3EE928DC2BCB865AA17BA2FA9ECC4F43A45F5FB
      594384221BBB6F2452401B79885589A5253356FC562D8345A3CC1092AE0731C2
      2F55B3861F352BEAE9BF22CD207472C90C2244B8B98E41750EE563EF2017B5A7
      43F4E542F843A6AD2A0CB1DE5D01203EEF928061BB5EAA0B2FE8D42E612C04FC
      A6F26B4413AB94B18839F94DC3B7DE5B6CD8631AF1271876CF5B24102019FA39
      84F675960E7433F0330047F96C77AD8E059EF9AF594C2A89FF5029C3B3DA7C9D
      8FC808DA993C6F5BC29446C7BFCA30ACD16E50968814E199F9630A46E282DC37
      B466267873136926B534039002AF857B4137CE67720C2B8199C29BAA7BAB575A
      4CB7F9C8725E8153F8410FD4E219913FAA814565672478B384C9A6E74D426751
      7EAD52E20314326458A0BAAADA2B12D7B13223EFA123E7132EB09183542AD90A
      118E0282F613DF4F03C38A721310BC9E98A15884D2BBC1DB8927FFF02E34016B
      4C3656453C44D2E867ED863B6E39268AF14F448E023A8193C10335492479A903
      C8E3BB45E3CC19186B30947D5A747509E872848D796DB8BAE30C85DC734D3069
      08930EE319DE419145D37C7CF7EA791F975D4035BD51128604D3624AA441C6EB
      EEABEEAB3FD76AA0600087BEC602606C3A4444CC0CCCD7DE8197816B707DCF00
      BCDCDF29A9C34D2E0859416103964C6411F87ADD7187A71F64CB0A9A5FEB66CA
      EE7AD57DD57D59EB025FDF008CB908427BECB785AAE7E6534E75FA5790EEC6C5
      1A97565E5AAD8B9780F32657C1D4542CD2F2EF7FF70ADFFFEE55F87D38C9E4D7
      62603834A40C1629E62F5801F1C653DD5A973D44507DD03BF7EBB7B273E3C1F5
      D4F4E70439C9E3FB416F4150E0B18F2FC5B97728CE616F3A3A3D3C13FA6FADAB
      51A82A20BA626DD36CBA1987BABD3D62616A5D1FDF2D155DE4B5D7EA5E645470
      35EB5D395BC8B8641A68FF78AFE3CE58B7C26E1AFCE5A07752AFA7A9BEC4EEB6
      35EBFCE0E2E7BA6FEDF5C6E1E9874FA2E7B1AA231EB8D2C194B6D091C16DA5F4
      89E215361FAD9307B607F5269980488B38CBB0DDDD407FC7E5F1959C8AB1EAA5
      C3A1D210EBDD605F11D4C3DB693449066EA089D051128F87467FD5529781FF23
      710081226931B8EEBA8FD8DA90C328D6292F304991B664F9A772B164E4FE1167
      A90A2313CF11E5F06F142304D15E57B5180264FDF9DF5CA0E4B6816ABD094B20
      6AC61E8F735342A1C43863F1193BAE27F1228DA76DA2FF443C1E69BE413F4D67
      AAE902ECF9B15DB9DBDB811CCB9797DD6F6B2FA8EB34C708A55E692D184976DD
      B040926CFC1C3B982F42C86508EAFCC03B565871897974661610B8C997BB82A5
      BD8EC05596EA46341E885D8BA67D4EF6BF9598F4F23005447A9CF451FDEF368E
      5436EB452ABFF67A0732FFF7380491C01BCFFBDE0AAF8D854617A4B50EA60520
      9EC17A8789620B5632757FEC0E06037655DDF58862709F5C4BC43305032E9ADD
      79CB4207214C355CA5F45A3BC5189806A93D35D8AE0ECFB602DA7ABDE0E1F36D
      964CDC870BD1C24361715E6CE1677D1DDBDE4A25A76EDE870BBCFF6EFC95648A
      C3B3ADF2173403D0838A04C8EB459C7FFB25C3EFD747E9D6972CB008A9B980AA
      0CF636969FB7EBC3E40A2A39D7F1D708D65690D6D242B21201E85E937E4944EA
      D7B576B10D2BEEDDEBE21957A4254B9B6AF7EA858C2158E6C28975AED57C666C
      2A78621FD6884A3675149349328E3252643BA63DC33C9B3087B564C9DC482974
      CE987FBA40157A6CBB5A17744430DD16286E2EDED6144BF97B26606611B89A42
      5599085B31D81AA269CDA658B9DD82C9E56DF13CF0A1DBBD15317BC96A7D09E4
      6F0355633DB788FCDFEDACDE6441BE42F4F3FED9EB1DAC9D44B31320F6332A6B
      F3DD957FFCCB3CCE8B4B00F3F8C76424927A20BB230141E0BAD46F55AA414E94
      529B273B5A74ADD1AB5879E553B59AAD3CD4E11219D55AD7C3F9054925883D99
      04D490E372A219877AD7A5267B206D5A465D3BE747DC254B12CCDF73A8E24F93
      51DE01E728CE92689C77DC3845826FBCC8157AFAE6567F6BFB646B6A4F6476B8
      CCD0284B16D42617EE1D345DEF75E39075DE6D356AD48A712560540A7C188BEF
      DF75A8351C299BDDD7FF6E63E5195FB1D09D2C32A3D994A6BA78CCB07CB76CF6
      9E1EF5086B84476F073D25C33D7A4BFA972E9175C647CDB5E47F6076F128EEA3
      D2F02D5F8D45BC7F12E35CD130EA3DE4A9D7E30CA5E102098B236E70C767FB8D
      6E25CF81FFEBB3445FD26498ABFB9C005BB238CE79234ACFCCC1FD47A8AF511E
      B8092AD90DED23E6C6756EEAD9D6DC24092417A11880C8842B554233B0A5371E
      32754F56BECB7798153FDF3DD86952397DEEC081F44AC03BA93C3F9915B72A33
      502F25ABEF1A17B481B4DBDB6946B1B18B068FAEE80524D4639477221427A470
      318EA6C37C10CD620CAC5AF73B3CFD6043965AE4AFE5A7C623E865BD1124D210
      CDF757497429B3671C479F9B5C26D019415E9687FEFDA39DE30697A42E9845DE
      74DAA8BB8646C32F28570586386E14D3DDB35EE6388BAEFE2FC892628DAA8503
      A66F168BF1ADCA8A1DF8DEB1A65BAF73521A7B987CAB28439630D986A156F3FC
      69792DCAD068B20101139D54240C910F6CB78A382FBAB308FDA4CBB5DF7590D0
      60D110E7B5AD7FF2D07678F6FA9F87A71FD654532BFE5AEF052ADB29CFD341C2
      2CA52526D1B63F76911099457947FEB9A5FF1CA5AF6714991FE287E917FC0072
      0EFD27EB7515F36527E9D09D655711EC0232D7DE844443E15EAD61D7128DEE50
      105812ACCB4237B73E49F52BDBFFA9FF401FFE586F9409A07F9D7834000ECC47
      20B73745ED1066146A0F93F5B3EDA0FD4C9308C83C9D1733887C109CC5A98331
      A08BB0050C808C4E600A236D953424C88160D1B9D6FAD976B7FBDB6F27E9D0F7
      EE6FBF4DD261FEDB6F96431C22170F45D2E3B3FD56C3DD5CA65F3476D78949E6
      1B577F28647D4DBCD4BC0FEE21B0506C6B54C1C8E211215A971707071ADF1F9F
      EDFBD068D1D0C1F2FF0DD0047782B80ED58D1783FEF51FB51CB5FEA39A1D15F5
      775FBDE7C7389AA5D38D9D6C92661B3B93C95C2D93F219E28AFC3A8EEF2B8A3E
      EEFABB67FB971BBB67FBAF8476E911498C877CC15E12CEDE391933902A4DA2F3
      A97E1CD4B2E192D7A441DED670FF6CF7BF963B433FF18A174B504562FD5BA2F7
      EE26DE9E1ED9BCECBEAE7B9E2229E5CDF7DBF7081B2F54B702496B01C521CC77
      D1049FC2C743A6ADAF71E70D5AB6B9F5FD76E9423E8C91EC802B912C965CADB5
      77E9B50DF272A3DBBD79B51D6096B3D41383C5861A3615861F6A072BA4D140D3
      32D98A85AF1E2EFE3A2D3EC7B77998082FB3D99A126F932D027495C81876704E
      9B4543F78D597CD2E365DD7E9AA6D3B8E3FE08126B9C1575DB351EBADE753202
      680D3D6F84601D87D84E3E273302C952A2AEB4B16223DCC6949DE7284BE6C51C
      5AF3A442F1ABE9BC80EB0E8610521652AD8DF3CF70F58BB2387AA6067B2FE1B3
      9F57F62E8BCEC8E303C98C67325DA3BBEEA4A57D5B13244EFC956E8DF75EDF5A
      CA8A71E819DFA85E26DF558D31720710F940E74ECF00E9C8F488905A99CE27A5
      4F2B4EF9843F932654EFFD002EFDCD9EA81CA9733B4CE745E9541CA467549BE9
      B8837C20229FA2722846BF7C59F5A1289A36D2F27FD5BA8B0BDD703E80BAF138
      37D00ACAD202133011360640F591F85AD990E09C2AA9DED076184F52F74230D5
      CB3F8630FEC5739E3E82FA42BE8DFD5F102E2C08DA09A3CD97F671AD1328A8B9
      DD2CBDC9114BEF8C8B6F0E5FD71B0DFEE9021DB77E9A7E86FE934E3F3DE36DCB
      C8D9EC76BFB51836F21FED3834C2FE769552D8B46661CB273940A3F3200332FC
      132B554714F2EEB817E9F44530239E2965D7EEC74564D15087621CB6C170C7AA
      B9C5E88DECCC1721C643C912321474686F0B82341F03732219C0B58E9B095F4C
      67CC2D28B4569AA2E90EB029CF102F2D999DED8F9770844164D621ACA9A3B264
      D1EC369BE77C371DF72E2E0E000F26FAC36328D73A65E2EA34FA72C2942AFCE2
      29675FA4EEEFE9F466F85DA39E94D4229BD4B6369991166E81138380368F3F1C
      BF73EDAB71DA8FC6FCD3F187E3530AA913B4F782B6AD908E96DAFCDECFA23A0F
      7515496C68D255390BB71601C8D1DD740BEE245C9FF23C5BF63CBF5CBCDB87FC
      B845AAA9137B1E0201656768802EC3510E47AC900E707EBCFF2AB8633275E73B
      7B3FD3A42499222FB8D6E034B77B7EB91F98B358A2A89F0E6F09472FC52E77CF
      2F4FA9ACDDE06E17310487F01AA93A89F7C59543A8A00B06B74D803ABDAD0D45
      0FEAC998B70917ADB3C3DE65E87ADBE626F6A247F91B5B555F583C80A56D345A
      6B7E26A999B08FF39962BC14C4AAA6D48A5D8FF3499308FFF59B6D004DF3027A
      4F40D38FA0F1A3DAACE6D73E34273FD18DBADFD5FEA937FF6E5BB1F992E8F723
      5D8D9268B228722C47972724EE9A5B7958289AC6A4AF28EBB141C6579DA9A6EE
      2D9D2339C9F2DFE7386DF7B368F0392EEE364C4F635789D017BD598455A509E2
      C83B2EE9C65DF7EB7F9C2745AF48679FEA4788FBFDB167D455704C7214344F0D
      C653D46A0FB85AA1A80841AB0279A93782B8EC79104D299F8DC4840F0602D547
      55EEADB725A26823B3006FC3A6008841B0DB9800952A47ACE2DAFCDBB160C979
      01EB816C374AB329BFC0E38431A018EC3E6708D981AFA4FA6B2EC4933B798EE1
      3489A6D115ACE0F5E7BEC58E7CD7758347DD86656EFDB2F7FF2E5C1BDA6F92BC
      F807CE72FE44F5E7B5EA06832DADF93DCF4F8E7A4DAA8A3E221327A1B40F9F79
      110F88C7C13AB1ED4ECEF6773BEEE4ACB7DF7187EFDEEDF0FF3DFCFFB2D7E4D6
      C6173CDEBB3CAD6C16EA9653CEF4F7BD9FCF75356EF4B6FC9CD104370F5D50A5
      060D2EA1B3396FEE8EC45112E3BBD10D65D10B4AED86C46690D1FCEDBDD897E0
      FF85A2D8AF63266A8325E1C5FAABCDADEFB6DEBE7EB3F5B6FB12FFBDA0D825E9
      6C9EB5457B4A99DA72214480D3D4FDB277FCB11C0BCF11F9B7102BFCF69BE07A
      45D233F7BA688B01FFB3C6FA21BCBE620AC1575D9F55A401AC8DE660CD0E0735
      0D1DBF36280AEA6D64449DBFBBB808169540620359A6A8B8BECA00BC10302659
      A8CDEFB964149FBC3B3864EF614993E1F3CBF1D9DE338C187FD7D67B616BD959
      F897DEC17ECBDD4459ED40A42CE8C81DE4585B7DB0D3F3BDBF75961C0B9BA2F5
      5F765FD784042894248BBF6CC0F028348792313087705C1756EF15FB8FC0C2D7
      8394C5577086647A86EA683D6646AF34CACDE2DFE7F4F3D034398BA668EF7C76
      03618C064F1CB93CC6C1FABE926860C36CD5B01734C0955C3D4F44E898FAD1E0
      4ED071C8D7410A433254920FAC77E9D67F810F0A409D1D82AC3E035966A930CC
      D2D97CB6C4A0FAF16C2A44831BE6E780820B3433F2208D5BEFC2C7F0BD63E15A
      F8C13759521400CF14EEF5C96E4DEA1F35CA8098841A75FC75101BC29E322A4A
      71366B6191373DB70354919AC133B5438A6832239369C2ED500C1D4673CA4A14
      386688320A39DA98FDDD466545986890FD6D2071EFC7A47E230C254AA86BD7A9
      0C1218457B3F33F1EC3D7E27DD673B95AF486E95FE0C38F5316C45A07CAB8093
      D5561B9EE9BADD94E22A0148B7E165AA29E57609D8CFE2AB39281CF157B31ACC
      D7EADF2C3C67B42F8F217B180FB1AE77DCA598AE2479B19B7EAD790BE9559F82
      10E50255D3F0153A39B3B0C2F4CD21070E562459E229594777641D7F48E8D76C
      8C009E862EBF9D16D157779D5C5D8F3195B0E510042577907570B5433BE2AA7A
      03053A86826F86688D884988F91DF56CEA0E9CB3404D3E7FBECB1E4918B1F9EA
      DB8EDB7CF506FFFB1EFF7BEBDAF81F14C15A480C30FB8D7BB71EB0EE4CF241BD
      7EDB4349AB9438216E61328B8AA49FD0BB9D23AA9F16D76E3F1ECFAE13F7CB01
      97A85F0E5E7BAB40804AD4C2478C371B6CE1207B9DE2827E41CC53A8EDC98A2E
      D053D108540F424F80D2A8A6E6DD776F8B78075777E3787A555C7B39551E79DE
      6CB97E52E4CD23BA57DFD78BE878A1413A2D9971FD5B3749934934DD7CF9D25D
      17C52CDFDED8F0BFE90EE32F49344509BC3B48271B51566C5CC6F9B79884EB47
      90295FDF7AF3DDF7AFBE7BFBFD9B46E7241A634F816C909424FDDA40F91DBAB6
      EC29B9DBB938D9E9B8D30FBD236406F65F75505538ABB9DAE88D0F28F9A97E30
      C2FCBE42C2065B35188008D055529FEA2CCC4135B9E1E17DE71A96556C8F1244
      9E478436C9C6BEDC72DBD0E341F199428EA20B87FC330BDEF944A4AAAFAED3BC
      5863E4E3E399BAEB92DCDABD7DEBB631DF91E2E112EE159C48205409B32229C6
      DE221520566178E43EB3E8DA43F12706D9592A34593CCB5256AEFBF3AB35F5B9
      03859C795059EB04F1089DB7AF4D9E6273F37BB7ED8B961040F9192104B9D963
      C481BF1C5F1C97A283823205FE440E4212DCA085691ECB6709B285C2FF30C672
      D38FA7C99580C003A99EA3CB9366AD7EE9B61D4384A07CCF242ECBFA92415DB0
      4183CF2F0CA0B14AB416BFDBC2028D4A8A8CD19AFB60105F2BD2D35C8E58E613
      0F317D737266A4C31F0EDECD86E2ABF225EE45B3A428214E7A22873A3EA89CA8
      0A305115540386092DFC8658BBDD7EE09DA08831536D773970BB5432BFEBCAFC
      AC016D18B921A4577D79FD2D775B405087982FB32887A2400B38CD16A4196F20
      BA503B260D901486D169104D87632AFF574575462C46EDD8B46BED0C09B7BBD2
      D6168107861F0EDA3877ABFA63E09C106A3E369AA1AFBEC50CF51A48EABF2C92
      BBA8C621A781FA59B39B6C7219B863E070115F31FE14F02ED1165C4BF36EE0B3
      ED815ADC8DC7D1AD1A1432D553DA077BB10D774AC027AF5CE20B7FD93BBEB055
      ADFA785A0768F6802F373637B1CF94CDAEE8021212E7D352922B0A9F113263F3
      990B14D4F061C1C9A14FCC008D6692639E0D9AADCBDFB96DD81AB20829279AF7
      86BCC61660322EBE853910508DEE88A54F165ED7D26AB884542D3789C6369D1B
      AEB09B9B18693B1FC2FC6FA5F2CB121E25FE7D00DE753D09ABF0E0CA18027755
      CBD2182C185725D14EDF1246EBAD9B5D4779B377F112E3E603034094C74DCC91
      C31B8B3D05CB7B274CA077DD6E34F80C58C374588287E9792E7B043903903AB7
      1AB63696D9AF66CDC49081A29E8CE1DF212F60134A2770FC15E45C16CC75508D
      B288E24292C416C13CA538C0037365C737C84F5993DFB86D47D3D76A4A5873B5
      28F54B35573C5D6E50D6FD2234D0AE3B4CB2583C4970064094144408D8F0E2D1
      08E7E72FE3DB726820EE93B8416A76CD9A8FA5F94C3708D14F469F5B9FE6E013
      51E5C1ED68090F792C0B49CB3C62D7EDCB204090DFB19E46A81AA841FA4750E8
      87441F2840347B0604801FD264103B685194922708AB67B338CAF2AE3B9116E5
      321A96BCF7853DF8E7291D04F1B9ED46ABF66BB7AD2ABC776254D53105684986
      4BC77AA662D404B000D560284A8814D428506D918160DB4097403811992A61C0
      6C0A00B96BCD3A9AEBAB52387499D39C836015B4AE19E57972056287E28E87A4
      DD586B44B67782F1AF878CD2BBCADC142AD7B5B4894E24FE14151A86A6E65B26
      F9A57F51D2C7567ECC961696C7F9CCBB1C7A2DF9683AB84E71CEC11A445F4742
      C1D2AC66D699FC6E48F9727105DA65100DAE71A6B669E7DAE007A21F86717F7E
      85C867ED19522E6FEBA55CA8A946AB60A3FBC8AB49105082252620F0389AB2D2
      938E04726A6078990D25DB803C36CAC44563771A7F9D7331EA157134E11A985F
      A70A2CEBBAB630BBA2FCB38BFA40FCB1193A6E4669369F34021A9C2B04B42DA9
      0BDBEBD73CE690821D3C984C927C605B9669B89539F3FD2CBA4AA7FD349B4274
      B049935AA853EA647447FBAD6589168D486ADDE6129737A5232B9E2D3DFFA973
      AFE091EA253235755ACA92077C8922B560FE3FDDDB972FEBF1EEF64AA6AF6799
      C134088B304D0289F3A87A483564635800EA89CC5A8954A6DB00E6ECBA242A1C
      FE78E7745FD0D06CD4E9CE8723DFEF6DA19454B9246B5D77360D40EA5AAE1546
      1DE77347B906A28DDFF4913CA36E29520CEB08590ECFA339F3B2FBEABB3F3799
      2126BC394C224849E7F3BE584812314798CA66B79EF5A719DD6E0C8909A6E7ED
      BC18BD35A998AEBB2CB592C3FC5E476A3DB00A40C15DAAF845CABC46AFC8843B
      95598A43E47218391529EA624D54D9144FD0BFD5D9B4E1A32410A272B06E87F1
      D433FE9ABFBC377F6ECA2645CFC176949E2DAE5D64E9BCEFED8C2ABE206BCDF3
      D4CAF9BDD8D93BD0A4921450FAC98CF83DAEB31AB61C71E72A8B401948338BC7
      3F4164EA4E987702D183BB97949C717964904DB049C51A6E421EC12AF4F7309D
      25C2ED5812828263EEDA8B73B8396AFCD5B78DC6C1D164067C2C8F76C0BF1F9D
      EFF70CA32B6FA839CD63FF00707A3D3CEE1CEFFD24DCC6D63E14F4E78382FD84
      806E1CE7ADB5C6A33A40ABE6448DA8509E16A349A14EA65A03DAB93839130C18
      06A6F7BBA1E434AD7DF77EC632C628336AC4520A460CEB51AA9D4FF2816F00FA
      856384EF83865E6CB4B4A2F9ABA06B73F09427822A3CE772DD36346D3295A1B5
      B5C613079986766E066C88DE4166011151887AA5EAF7432D24DEC3B61353812C
      49334D6078F716C97AE707566BA975FD73A6C2D7FB2CC896FBB5BAFD51772534
      7869492DAAADDE619E921A2E0600DD03BE5BA4F526414B6B2272AF7A97D89946
      E3DB7FC4C048C96510E164101A80938B32AAEAA9848B1096B1BDC6E955ADCB9C
      F5C7C9176CFB17B01C9BC4D2BDE7222702F2C9156BCFDB1B1B373737DD298E35
      A096B3E69CEA7737F09B8DADCDB76F5ED7EAA51309D29458C88375EAD2113064
      447BA2DFBC40758B4A13D0D9E9CB10D8452E1C51E6461647836B0C834E3911B3
      C175C7F5E2DF5968ED5828C448A7E3E262D0AD37360E61A22D2629B4D4D2BD55
      2D99254ADA39BE6CBE1D6D3D4B4C1908359BB084CA5EABFD04E55073D3FF0242
      2D75BB67BD1E4BFF5CF86D8A3D43899D162ACC940490E864EAFEF2BE77D9E4F2
      24BA09627D0C5F2C141055ABA31FA37CE90F5301D2A7D126C0DD5069BAE3F82A
      1ADCBA8BD39D130D90B017FDA07DAAC53DFD8B208AB15976DCCE09FEFFF160E7
      BCC3DDBCE34E8E7A8DCEDA86D75A7E97D27C1B2DA9EE5870BD1CB11A477B169F
      31B71595A57E0C5219376B0D8897A769A82106E9B0262E958BC2867721F74426
      4757C314AEEA6258415D9C7828A239EAA86E567EB61AED1FEFD56B118D76BC70
      32A0BD5E2B4C7C76D310A21C78D3D15436B4E0ADA95AE64FBFA8FBE545765B4E
      FD744A8313F534AD75F59F206EB17779715C3A0ACA72A82505A0CED0E5A372A1
      6CBE18D655759569A1435DCED25686441B652B0D77E6A41082C87D55ED0736D5
      63AC3E3201F38E3B42277720273B1ED7DBEB4FCFF7B6AB97E9D0D70FFB5B9177
      DC21CC5EEFCD923C70F18B68106FBB9FA2042A9B07B771B3A6EE3D20BBF35063
      62C942D4FB365DFF00BCADF7F59F6D8D4EA7DB8EC2531D95A1EAB89DC924EDE0
      45D41F81589F80C7FEE43E72EB8D339C82305FDEEF5FA80D8D09DB47466AF196
      62544865353A9011E83E4770705748B49E2DD0EEF9FE2591AD968A807B9A259C
      843EA70B2F73DD045A89CE069FCD2B708D23644AC0A96D97C766B91A9795153C
      BC87E7D18BDC1589092A562F8FDF8BCA53AD90E1817B23B8F1BCC22ADAA26C02
      EF5EFFF279C16EBBFB68FC4383AB1FAD14B0D84FBE406329CD9AE5B5A2417CF8
      8B9B5DA7D378E24DA0352295CD59CF9A416EA1FB2C99B405BE17AF8F20989DDA
      9626081316C35BE819B275E0A33FC8E74A7484BE6461AECF651AD3770B82C6B0
      1168868CA5438BCA5FADC764F50CA50E0EBCD0EF73A2677A077F9138A38DD41F
      BD2485B464818D92BB918E182C523C9E9EF492D15195BFAE6BFA85286EEFA71D
      4B27B0CF2D8B2165C5EB680C10B7B8466820BB8FFDF0249DC6B788D99ADC5B81
      3E43094A3548EDC8AB8F04FFAB05F1CAA809E9F935617769C0CAE2B55B78799F
      31976F5042C64F82BD49A657AD9A2C368D48990703358FB95624EC03EE1943AE
      46843649D6A8DB28668A59C34B1A048834529CA242033C796A919642EA149DAE
      BD80C7266707C269FD79514823F5B3D2CC0E4BEB92E8969AAD96DF09A5FE0A7D
      38A9D3C319BD2395DC3B37D3CD97A620596DFC9B3E74503FB37DBBD1E8E809C6
      A2149C48AB6105F85E5B9FD0977F1BA7573CD1CF672911943531C1B23E4E1280
      2EBD54075F9628059163A4071839BB58AD212B0F1DBE77B9E90BAAD9A3C6A53A
      8E6BE335F1D22CA230974792F47428D7C36D3A0E22B1F84C2976FA0252D1A997
      8E954DA35442A51631AF660CC5B665BCC41DE9F2A0F741FE151783E70023D454
      C234CF094909D687ED0654491EF7EEF5787CE05A5EDE16296E0806D197368FC1
      B52D5009067A255D742C7B02A34C28CBDE8D915A1D146A5457A009DDF81A2C41
      659D4C4EA70A1BE4BA279C395376A9B959EC8CC79FDCC7EC3606A7E95A681A38
      5F2A3EA4FD47D82A7795BDE1F51EEFC83DD6BDFBF1F1277778DCBB642D45A419
      C5C4B2125536B9FAC13E942F08E9CB4B1C820F831BC50C61225699831DEBA171
      F0B7B2662D1F1558A20DCEC0E3B7516BD6C7DB76EAA852CB4B6990016922865C
      A8B4A901272E2866616D4FC8BAD06E90088DC14D90A6DD402E97A95C2EF19A46
      521DAF50A8B3490824A7DE9374F87352B8A393B37D8BC542757B535C2AB1C44D
      6EB928BD160EE5A090069FC6E8AA2E47DB9FC005232AC7A210FC574A72D52627
      FD6A1B8C1D30D21BA443AE294DCB6793443CD4F50E8E8F1BDFA4374D6F6EDD8D
      CA658619CFE46B784ADBC98AEB499A66CFB0C96D7EFFFCF63924ED63C36224CF
      401E50093D86376F724D7C875A369D7E6063909185CAA702CB0D50918C4AF39A
      A129EC5182A01FABF569CDC2BF80F2C5C35E298FA9F894160EB552455C3782CE
      B590F5C75B91DA55DEF210A46BEA9995F350D0C97CDCB88892B1500605B98835
      FCAE055AAD575513823124DE4675E9115294CADD6A6D2B9934365AE827906826
      D41989ECBFCF27332D3346D6A3CFF3D2D8B164A9C6D9677B6538BBE26E075384
      C9E76932AD878790A5ACC7A58C00482ECEF2DB6FF4F7E7B8EF81DC9798731C29
      0135881C213E14C0E0D60AA4ABA5917C559D1E6320825B0583D9865AADC5F1B9
      F292902F81A2FF6D581FC15388AC5D8CA5011B9C88AC4457514D96AF9109D7C5
      E551AF07BE83A1FC0758FB853D95020A096E2C5B826880B319B6A6C2451C8318
      4A2D3C60390448ACCAD122D30E4E8CA0256BCEFC13A2AB2447CB16C82F2E146A
      859926993EDD920139FB2839E36D83EDC55F6771960020178D3BB6BC8AA765B4
      289EF6D499FAAAFB6D5D973DF205D5977A1996641067C2FCBF27B0A8D3D49A62
      A0E0831D265FB7C59C88531813553414B22417BC24AD21909F688DE6FFF8C76D
      4B69CFC8BA65718E78D14CCB172E63429264FFCA25B1B6E3081CFF0EC6356AE5
      0EA2B0571C61F0E69237A86B1A694E76648A068379861A743AB279D6DE72FDDB
      225E5BBCB1301DBA6E570ED4CC7C000488FC3BF0D2967EE5D7484C2F6C3B0079
      435B274D96CD90BF69FE9E1604B1F2FEEB97772EF14A2ED1BA80263C4E91CA92
      66ACDCED765BAB48152850619A8A6FAF44D95257A084E597E44A827A78D371A7
      58FFD1DD77A355F759FA1DE968058D63A9B53F96EAE2AE1F63B755DD5576BCE4
      7185AC02ECFE2DA3D40C8E0525BB1D75152F7064E617C29EB66BAC2147C69F38
      9498403632B7C8662198E1D058F968C6E9571925CDBA7185A4993260E4937438
      C7F185B763026F1C51F74E45878CEB3087B287684CD365FE467917D1F8064220
      AA860182A8546F8DAAD18EBB575D5563383C7B7D2E78842E8C8785CE43F92558
      B87C89B37124160AD6DB7A682A4B4EDA5AE605396D69FD9ECF994B8A4812F29E
      84727932F8E85022C7E2F0F2D858710B5C43761BE11CC4195EEBCAAEFDB87371
      7A74FA6EBB0C19D0D0609484946869B58C293658D3A84C7DA1C0263A2FA0D94E
      879ADDCCE2E8B30C21A17FC825F890EAA898E4F65B84B84ACB5508B1C86A4D6F
      D546265AEC3AE8327AF92DD1091F8F4D3D962590C3B3D762C625C38E045E76BA
      CC09CF9EC8AB63958DC7B54AEA1896BB3443F836BE5DD9A7229D5021FAE00D31
      34471F25C8F5FB3DBC358E324CCEE19019E7E82682F5368093412FC6CE329480
      C2CF21DDE6B6DEEDAAC8C45C109D624718B9375BFDA4282D8546EE23F33E8D37
      B5D7DD97EEE097F3838BA39383D3CB9DE37A3B9C3C6E2901962378515F5F96AC
      164E6A1DDDD2146F3BC168A0488C6C1BC142A61437C02986F1B490D505C247F2
      23940F8A5447588B9D4BAB01901EAFA6C928196078D106C36B59A62817434F78
      D116439793401B831C57B8C72B8ABCDE393BD5658AE1E1347887E9BC08ABE77E
      4D99A47961401245396B343089A369B01E7220E5B1C6983976D71B8CA4F05CE9
      3F3C4C8648B8F30FB74C88D3BFAE8D24A9D89C9659ED7CD2717BBDB24AC92C92
      EEDD166A7316D179252AE2358AE32501415A2C596488A3E9D6875A4A16D496CD
      6431F89BA602B603CFDAE418EDBA5CD8C38BFF7D9E735EE7A64C2595D35C36B9
      BC40D77C8EE399F43DAE9BAF55EE8D524770F3EB04E333BC3DEF7E5969BBC2D6
      E538B1CE8F9FBFBBD8977D398EB231E09BC67FA89D7FF7B7330C5D82983B9A26
      229F54EFC2BBF32B2473785891184D4FE8836BD08835B6107A7259F49785B41E
      9BEE3A5E2E7EE01F4F87AFACE2E738E6646E67EFA70BF72B65855F6E6E7DC2CB
      10D149E094D0EA7291EDC585FDADC7AC7F91BAB319E7332B00F2055D77F3B8E8
      BA778984C2BA71F06495F914058ADA4C82CE67DA0F2587290C5EFD614F0D1FB8
      477905246C9C37F095E948E09D8CCAA03BB08509D87EA60D6465782961F064ED
      A71A54177066D3602CF67B74F75FF96E38E970AEF08F2CEE4DF81313015CBBEC
      413A3227C7C967A99E99C9E98BA370AD9623E80B2F52E1EF084674FDA7292B22
      3AACD16CE4DD6EF24A524728E62E46C24437747954F38EE3B1DBABDA46857D74
      18078AADAAB5859EA3A5938682BC317C3EE42C55569AAF239C7900D84240B058
      5179FAB6FDAAEEB1F91DC2BA9E9553DBEF4E7A976BC6A9BF91BAB51FDC943107
      3F05F58454AAB660CF891083AC0C35995A9A14D1B1AC7235015483495E550541
      D4209B7EE40E69EFCB2F37EFC2C563E292038A6DD67A16623D6112FD5D194136
      74233079F5FC1144417DAEB838216B0626C99770219B3D476D177A0118D8E160
      9464D84DE915E74FE8D3B44806422016B7D486378ADC2BAC74D59B305F168D19
      F280EB19013B5B7BE72C89CE51115F41FCA2F593903CFBB734CDA59373CBB0DB
      228C2A100E8EF17A1A00D4C4511C7AFFB6D4E2483347954AE96184505771116C
      AEE6B61BAAEB972C8B6680ED5994F15CCB7DB0B876EF20DF5E73B2C2412B1D21
      C70F18D1B4E585D1A0728FCD55352F24214CD164B5D5ACED3FD45B5CCEDB64F1
      100D8E9EC409C20C9D40E6ED2008D4AA49C775BB6B9A991E84991A860EAD9E5F
      C65B1DFFD3693A8DE5FCD03AA2BF64D9827A26BF2AF8052564496548BED50A3B
      960D4F47A3048CE746D68B12DA6D07534D4C646EB214075BC3284123A2C2D82D
      61A9B26125208933C8B2803BB26E6E8BDA225BBFA66EB73C4E98C26AE4AF56EB
      1168CC884270710353797F128A71A64FF289CE58C99B044082C118BFF2C17FFD
      F9EB6D0B9537111E355A9E1EA6B2628196698B3E73B9FB7D4EB13928C032C552
      324B4BCF6BAE7D6B5DB7A3126BD80F2C8940292CE1C5B09EE615C2866EF7B655
      614F5978119000AB0EF2F8B46FACA09E7DB2A651951D2BA8797F6514FC1FE388
      A92867C95558E27D906483F9040B3A54CE1A17E3947212B92CE5F647314DA62A
      E9BAEA33AD8C6550F201FC5DAC502D76BF91631BD70366BB2D94105C12D38E82
      D8809453D7F5529FCAC3CA164779C2AD3BF28E4058E161DA58D33115890A64E1
      AFDCD18B2FAC905DA5A27A4F3D971F9A155736EBD62BAA31225EB4547D864136
      665AD3B5F4D0A27D5610B18E9CE3A8CDE48B574B949B9A42B015D26A86057ED7
      CF5D9BABB089E5446009C003BEE60665317490BCB9BB13C9B222C2BB92C2DC90
      3A39139991EB1671BE8581EB218E4CD4FB432E65B361BFE2DD83100897CA50C2
      BA6CEB6E62D8271CD266A88D316ED76AA40724D57BE0735B1033265985341D14
      DE54B18B92BCF6040A712EA3BDAB74FAF8DAFE5FD33925C938BAF9D34E16BB7D
      E0965705EE7F4DE7984D9CA724C75FA7E3D8660882C4FD743047EABDEBDE21BF
      F507F7533A4311620C9DAEBB49B67BA0D30F6AC06ABA5B2A243225A53AEED68F
      F05868D1D1848F53A6BB3ABE92C67AA0A2F0C840C7899A57D10AAD8758E0BDCE
      A7C85FA1F3E31BD335F172BCD3A19F777E25FEEFFFFDBFFE3F985A7987}
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
