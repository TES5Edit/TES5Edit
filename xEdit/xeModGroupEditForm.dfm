object frmModGroupEdit: TfrmModGroupEdit
  Left = 0
  Top = 0
  ActiveControl = vstModGroupItems
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
  object vstModGroupItems: TVirtualStringTree
    Left = 8
    Top = 35
    Width = 848
    Height = 541
    Anchors = [akLeft, akTop, akRight, akBottom]
    DefaultText = 'Node'
    Header.AutoSizeIndex = 0
    Header.Height = 16
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowImages, hoVisible]
    LineStyle = lsCustomStyle
    TabOrder = 1
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
    TreeOptions.PaintOptions = [toPopupMode, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
    TreeOptions.SelectionOptions = [toExtendedFocus, toLevelSelectConstraint, toRightClickSelect, toSiblingSelectConstraint, toAlwaysSelectNode]
    OnGetText = vstModGroupItemsGetText
    OnIncrementalSearch = vstModGroupItemsIncrementalSearch
    OnInitChildren = vstModGroupItemsInitChildren
    OnInitNode = vstModGroupItemsInitNode
    OnKeyDown = vstModGroupItemsKeyDown
    OnNodeClick = vstModGroupItemsNodeClick
    Columns = <
      item
        Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coStyleColor]
        Position = 0
        Text = 'Name'
        Width = 424
      end
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coStyleColor]
        Position = 1
        Text = 'Optional'
        Width = 70
      end
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coStyleColor]
        Position = 2
        Text = 'Target'
        Width = 70
      end
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coStyleColor]
        Position = 3
        Text = 'Source'
        Width = 70
      end
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coStyleColor]
        Position = 4
        Text = 'Forbidden'
        Width = 70
      end
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coStyleColor]
        Position = 5
        Text = 'Ignore LO'
        Width = 70
      end
      item
        Alignment = taRightJustify
        CaptionAlignment = taCenter
        Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coStyleColor]
        Position = 6
        Text = 'Load Order'
        Width = 70
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
  object edName: TLabeledEdit
    Left = 48
    Top = 8
    Width = 808
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 31
    EditLabel.Height = 13
    EditLabel.Caption = '&Name:'
    LabelPosition = lpLeft
    TabOrder = 0
    OnChange = edNameChange
    OnKeyDown = edNameKeyDown
    OnKeyPress = edNameKeyPress
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
end
