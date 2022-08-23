object FormArchiveInfo: TFormArchiveInfo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Archive Info'
  ClientHeight = 528
  ClientWidth = 988
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object vtText: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 988
    Height = 528
    Align = alClient
    BorderStyle = bsNone
    Colors.SelectionTextColor = clWindowText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Header.AutoSizeIndex = 0
    Header.Height = 21
    Header.Options = [hoAutoResize, hoColumnResize, hoHotTrack, hoShowImages, hoShowSortGlyphs]
    IncrementalSearch = isAll
    IncrementalSearchStart = ssAlwaysStartOver
    ParentFont = False
    PopupMenu = PopupMenu1
    SelectionBlendFactor = 32
    SelectionCurveRadius = 3
    TabOrder = 0
    TreeOptions.AutoOptions = [toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
    TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
    TreeOptions.SelectionOptions = [toMultiSelect]
    OnGetText = vtTextGetText
    OnInitNode = vtTextInitNode
    OnKeyDown = vtTextKeyDown
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Columns = <
      item
        MinWidth = 50
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coEditable, coStyleColor]
        Position = 0
        Text = 'Text'
        Width = 988
      end>
  end
  object PopupMenu1: TPopupMenu
    Left = 376
    Top = 176
    object mniSaveAs: TMenuItem
      Caption = 'Save As'
      OnClick = mniSaveAsClick
    end
  end
end
