object frmLogAnalyzer: TfrmLogAnalyzer
  Left = 0
  Top = 0
  Caption = 'Log Analyzer'
  ClientHeight = 528
  ClientWidth = 773
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 773
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      773
      41)
    object Label1: TLabel
      Left = 751
      Top = 14
      Width = 14
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'MB'
    end
    object btnFileSelect: TButton
      Left = 602
      Top = 9
      Width = 26
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 0
      OnClick = btnFileSelectClick
    end
    object btnAnalyze: TButton
      Left = 634
      Top = 9
      Width = 58
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Analyze'
      TabOrder = 1
      OnClick = btnAnalyzeClick
    end
    object edLogFile: TLabeledEdit
      Left = 48
      Top = 11
      Width = 548
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 34
      EditLabel.Height = 13
      EditLabel.Caption = 'Log file'
      LabelPosition = lpLeft
      TabOrder = 2
    end
    object edLogSize: TLabeledEdit
      Left = 719
      Top = 11
      Width = 26
      Height = 21
      Anchors = [akTop, akRight]
      EditLabel.Width = 19
      EditLabel.Height = 13
      EditLabel.Caption = 'first'
      LabelPosition = lpLeft
      TabOrder = 3
      Text = '50'
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 41
    Width = 773
    Height = 487
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 0
      Top = 265
      Width = 773
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ResizeStyle = rsUpdate
      ExplicitTop = 249
      ExplicitWidth = 133
    end
    object vstForms: TVirtualEditTree
      Left = 0
      Top = 0
      Width = 773
      Height = 265
      Align = alTop
      Anchors = [akLeft, akTop, akRight, akBottom]
      Colors.SelectionRectangleBlendColor = clGray
      Colors.SelectionRectangleBorderColor = clBlack
      Colors.SelectionTextColor = clBlack
      Header.AutoSizeIndex = 1
      Header.Height = 21
      Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
      Header.SortColumn = 0
      NodeDataSize = 8
      SelectionBlendFactor = 32
      SelectionCurveRadius = 3
      TabOrder = 0
      TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSort, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
      TreeOptions.MiscOptions = [toInitOnSave, toToggleOnDblClick, toWheelPanning]
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
      TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect]
      TreeOptions.StringOptions = [toAutoAcceptEditChange]
      OnChange = vstFormsChange
      OnCompareNodes = vstFormsCompareNodes
      OnDblClick = vstFormsDblClick
      OnFreeNode = vstFormsFreeNode
      OnGetText = vstFormsGetText
      OnHeaderClick = vstFormsHeaderClick
      OnInitChildren = vstFormsInitChildren
      OnInitNode = vstFormsInitNode
      Columns = <
        item
          Position = 0
          Width = 100
          WideText = 'FormID'
        end
        item
          Position = 1
          Width = 473
          WideText = 'Name'
        end
        item
          Alignment = taRightJustify
          Position = 2
          Width = 100
          WideText = 'Value1'
        end
        item
          Alignment = taRightJustify
          Position = 3
          Width = 100
          WideText = 'Value2'
        end>
    end
    object memoText: TMemo
      Left = 0
      Top = 268
      Width = 773
      Height = 219
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object dlgOpen: TOpenDialog
    Left = 472
    Top = 8
  end
end
