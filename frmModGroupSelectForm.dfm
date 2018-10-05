object frmModGroupSelect: TfrmModGroupSelect
  Left = 0
  Top = 0
  ActiveControl = vstModGroups
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'ModGroup Selection'
  ClientHeight = 615
  ClientWidth = 864
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    864
    615)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 781
    Top = 582
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
  end
  object vstModGroups: TVirtualStringTree
    Left = 8
    Top = 35
    Width = 848
    Height = 541
    Anchors = [akLeft, akTop, akRight, akBottom]
    Header.AutoSizeIndex = 0
    Header.Height = 16
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.SortColumn = 0
    PopupMenu = pmuModGroups
    TabOrder = 1
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
    TreeOptions.PaintOptions = [toPopupMode, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
    TreeOptions.SelectionOptions = [toFullRowSelect, toLevelSelectConstraint, toMultiSelect, toRightClickSelect, toSiblingSelectConstraint, toAlwaysSelectNode]
    OnChecked = vstModGroupsChecked
    OnCompareNodes = vstModGroupsCompareNodes
    OnFreeNode = vstModGroupsFreeNode
    OnGetText = vstModGroupsGetText
    OnPaintText = vstModGroupsPaintText
    OnIncrementalSearch = vstModGroupsIncrementalSearch
    OnInitChildren = vstModGroupsInitChildren
    OnInitNode = vstModGroupsInitNode
    OnKeyDown = vstModGroupsKeyDown
    OnKeyPress = vstModGroupsKeyPress
    OnNodeDblClick = vstModGroupsNodeDblClick
    OnBeforeGetCheckState = vstModGroupsBeforeGetCheckState
    Columns = <
      item
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coStyleColor]
        Position = 0
        Width = 494
        WideText = 'Name'
      end
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coStyleColor]
        Position = 1
        Width = 70
        WideText = 'Optional'
      end
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coStyleColor]
        Position = 2
        Width = 70
        WideText = 'Target'
      end
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coStyleColor]
        Position = 3
        Width = 70
        WideText = 'Source'
      end
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coStyleColor]
        Position = 4
        Width = 70
        WideText = 'Forbidden'
      end
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coStyleColor]
        Position = 5
        Style = vsOwnerDraw
        Width = 70
        WideText = 'Ignore LO'
      end>
  end
  object pnlError: TPanel
    Left = 8
    Top = 582
    Width = 681
    Height = 25
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvLowered
    BorderWidth = 3
    TabOrder = 2
  end
  object edFilter: TLabeledEdit
    Left = 48
    Top = 8
    Width = 808
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = '&Filter:'
    LabelPosition = lpLeft
    TabOrder = 0
    OnChange = edFilterChange
    OnKeyDown = edFilterKeyDown
  end
  object btnCancel: TButton
    Left = 700
    Top = 582
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
    Visible = False
  end
  object pmuModGroups: TPopupMenu
    OnPopup = pmuModGroupsPopup
    Left = 128
    Top = 184
    object mniSelectAll: TMenuItem
      Caption = 'Select All'
      OnClick = mniSelectAllClick
    end
    object mniSelectNone: TMenuItem
      Caption = 'Select None'
      OnClick = mniSelectNoneClick
    end
    object mniInvertSelection: TMenuItem
      Caption = 'Invert Selection'
      OnClick = mniInvertSelectionClick
    end
  end
end
