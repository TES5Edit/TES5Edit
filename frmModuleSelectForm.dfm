object frmModuleSelect: TfrmModuleSelect
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Module Selection'
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
  object vstModules: TVirtualStringTree
    Left = 8
    Top = 35
    Width = 848
    Height = 541
    Anchors = [akLeft, akTop, akRight, akBottom]
    Header.AutoSizeIndex = 0
    Header.Height = 21
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
    Header.SortColumn = 0
    TabOrder = 1
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
    TreeOptions.PaintOptions = [toPopupMode, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
    TreeOptions.SelectionOptions = [toFullRowSelect, toLevelSelectConstraint, toMultiSelect, toRightClickSelect]
    OnChecked = vstModulesChecked
    OnCompareNodes = vstModulesCompareNodes
    OnFreeNode = vstModulesFreeNode
    OnGetText = vstModulesGetText
    OnPaintText = vstModulesPaintText
    OnHeaderClick = vstModulesHeaderClick
    OnIncrementalSearch = vstModulesIncrementalSearch
    OnInitChildren = vstModulesInitChildren
    OnInitNode = vstModulesInitNode
    OnNodeDblClick = vstModulesNodeDblClick
    OnBeforeGetCheckState = vstModulesBeforeGetCheckState
    Columns = <
      item
        Position = 0
        Width = 409
        WideText = 'Filename'
      end
      item
        Alignment = taRightJustify
        CaptionAlignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable, coStyleColor]
        Position = 1
        Width = 200
        WideText = 'File Order'
      end
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable, coStyleColor]
        Position = 2
        Width = 40
        WideText = 'ESM'
      end
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable, coStyleColor]
        Position = 3
        Width = 40
        WideText = 'ESL'
      end
      item
        Alignment = taRightJustify
        CaptionAlignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable, coStyleColor]
        Position = 4
        Width = 75
        WideText = 'Load Order'
      end
      item
        CaptionAlignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable, coStyleColor]
        Position = 5
        Width = 80
        WideText = 'FormID Prefix'
      end>
  end
  object pnlError: TPanel
    Left = 8
    Top = 582
    Width = 761
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
  end
end
