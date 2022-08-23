object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'BSArchPro'
  ClientHeight = 561
  ClientWidth = 1024
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFilter: TPanel
    Left = 0
    Top = 0
    Width = 1024
    Height = 41
    Align = alTop
    BevelEdges = [beBottom]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 0
    object lblAssets: TLabel
      Left = 375
      Top = 13
      Width = 57
      Height = 13
      Caption = '                   '
    end
    object edFilter: TLabeledEdit
      Left = 40
      Top = 10
      Width = 329
      Height = 21
      EditLabel.Width = 24
      EditLabel.Height = 13
      EditLabel.Caption = 'Filter'
      LabelPosition = lpLeft
      TabOrder = 0
      OnKeyPress = edFilterKeyPress
    end
    object rbAll: TRadioButton
      Left = 522
      Top = 12
      Width = 41
      Height = 17
      Caption = 'All'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = rbAllClick
    end
    object rbCompressed: TRadioButton
      Left = 569
      Top = 12
      Width = 88
      Height = 17
      Caption = 'Compressed'
      TabOrder = 2
      OnClick = rbAllClick
    end
    object rbUncompressed: TRadioButton
      Left = 663
      Top = 12
      Width = 90
      Height = 17
      Caption = 'Uncompressed'
      TabOrder = 3
      OnClick = rbAllClick
    end
    object btnFilterReset: TButton
      Left = 776
      Top = 8
      Width = 90
      Height = 25
      Caption = 'Reset'
      TabOrder = 4
      OnClick = btnFilterResetClick
    end
    object btnClearList: TButton
      Left = 873
      Top = 8
      Width = 90
      Height = 25
      Caption = 'Clear List'
      TabOrder = 5
      OnClick = btnClearListClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 512
    Width = 1024
    Height = 49
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      1024
      47)
    object btnPack: TButton
      Left = 823
      Top = 8
      Width = 90
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'Pack'
      TabOrder = 0
      OnClick = btnPackClick
    end
    object btnExit: TButton
      Left = 919
      Top = 8
      Width = 90
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'Exit'
      TabOrder = 1
      OnClick = btnExitClick
    end
  end
  object pnlTip: TPanel
    Left = 0
    Top = 448
    Width = 1024
    Height = 64
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    ShowCaption = False
    TabOrder = 2
    object lblTip: TLabel
      Left = 0
      Top = 0
      Width = 1024
      Height = 64
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'Tip'
      PopupMenu = mnAssets
      ShowAccelChar = False
      Layout = tlCenter
      ExplicitTop = 40
      ExplicitWidth = 977
      ExplicitHeight = 112
    end
  end
  object vtAssets: TVirtualStringTree
    Left = 0
    Top = 41
    Width = 1024
    Height = 407
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvRaised
    BorderStyle = bsNone
    Colors.SelectionTextColor = clWindowText
    Header.AutoSizeIndex = 1
    Header.Height = 21
    Header.Options = [hoAutoResize, hoColumnResize, hoHotTrack, hoShowImages, hoShowSortGlyphs, hoVisible]
    IncrementalSearch = isAll
    IncrementalSearchStart = ssAlwaysStartOver
    PopupMenu = mnAssets
    SelectionBlendFactor = 32
    SelectionCurveRadius = 3
    TabOrder = 3
    TreeOptions.AutoOptions = [toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
    TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect, toRightClickSelect]
    Visible = False
    OnBeforeCellPaint = vtAssetsBeforeCellPaint
    OnChecked = vtAssetsChecked
    OnCompareNodes = vtAssetsCompareNodes
    OnDblClick = vtAssetsDblClick
    OnGetText = vtAssetsGetText
    OnHeaderClick = vtAssetsHeaderClick
    OnInitNode = vtAssetsInitNode
    OnKeyDown = vtAssetsKeyDown
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Columns = <
      item
        MinWidth = 50
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coEditable, coStyleColor]
        Position = 0
        Text = '[Compressed] Asset Name'
        Width = 400
      end
      item
        MinWidth = 50
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coEditable, coStyleColor]
        Position = 1
        Text = 'Source File'
        Width = 624
      end>
  end
  object mnAssets: TPopupMenu
    OnPopup = mnAssetsPopup
    Left = 384
    Top = 208
    object mniAssetEdit: TMenuItem
      Caption = 'Edit'
      OnClick = mniAssetEditClick
    end
    object mniAssetReplace: TMenuItem
      Caption = 'Search and Replace'
      OnClick = mniAssetReplaceClick
    end
    object mniAssetRemoveSelected: TMenuItem
      Caption = 'Remove Selected'
      ShortCut = 46
      OnClick = mniAssetRemoveSelectedClick
    end
    object mniAssetRemoveUnselected: TMenuItem
      Caption = 'Remove Unselected'
      OnClick = mniAssetRemoveUnselectedClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mniAssetCompressed: TMenuItem
      Caption = 'Compressed'
      OnClick = mniAssetCompressedClick
    end
    object mniAssetUncompressed: TMenuItem
      Caption = 'Uncompressed'
      OnClick = mniAssetUncompressedClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mniAssetUnpack: TMenuItem
      Caption = 'Unpack Selected'
      OnClick = mniAssetUnpackClick
    end
    object mniAssetUnpackSaveAs: TMenuItem
      Caption = 'Unpack Asset and Save As'
      OnClick = mniAssetUnpackSaveAsClick
    end
    object mniArchiveInfo: TMenuItem
      Caption = 'Archive Info'
      OnClick = mniArchiveInfoClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object mniAssetPack: TMenuItem
      Caption = 'Pack Selected'
      OnClick = mniAssetPackClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mniLoadList: TMenuItem
      Caption = 'Load List'
      OnClick = mniLoadListClick
    end
    object mniSaveList: TMenuItem
      Caption = 'Save List'
      OnClick = mniSaveListClick
    end
  end
  object dlgSameAsset: TTaskDialog
    Buttons = <
      item
        Caption = 'Replace All'
        Default = True
        ModalResult = 100
      end
      item
        Caption = 'Skip All'
        ModalResult = 101
      end
      item
        Caption = 'Add All'
        ModalResult = 102
      end>
    CommonButtons = [tcbCancel]
    Flags = [tfUseHiconMain, tfAllowDialogCancellation, tfUseCommandLinksNoIcon, tfExpandedByDefault, tfPositionRelativeToWindow, tfSizeToContent]
    RadioButtons = <>
    Text = 'Text Matching Asset'
    Left = 384
    Top = 264
  end
  object dlgPackingCheck: TTaskDialog
    Buttons = <
      item
        Caption = 'Show All'
        ModalResult = 100
      end
      item
        Caption = 'Continue'
        Enabled = False
        ModalResult = 101
      end>
    CommonButtons = [tcbCancel]
    DefaultButton = tcbCancel
    Flags = [tfUseHiconMain, tfAllowDialogCancellation, tfPositionRelativeToWindow, tfSizeToContent]
    RadioButtons = <>
    Left = 384
    Top = 320
  end
  object timerFilter: TTimer
    Interval = 300
    OnTimer = timerFilterTimer
    Left = 384
    Top = 120
  end
end
