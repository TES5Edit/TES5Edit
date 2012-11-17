object frmLogAnalyzer: TfrmLogAnalyzer
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Log Analyzer'
  ClientHeight = 447
  ClientWidth = 786
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
    Width = 786
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      786
      65)
    object Label1: TLabel
      Left = 133
      Top = 39
      Width = 83
      Height = 13
      Caption = 'MB (0 - unlimited)'
    end
    object btnFileSelect: TButton
      Left = 669
      Top = 9
      Width = 34
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 0
      OnClick = btnFileSelectClick
    end
    object btnAnalyze: TButton
      Left = 709
      Top = 9
      Width = 66
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Analyze'
      TabOrder = 1
      OnClick = btnAnalyzeClick
    end
    object edLogFile: TLabeledEdit
      Left = 48
      Top = 11
      Width = 615
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 34
      EditLabel.Height = 13
      EditLabel.Caption = 'Log file'
      LabelPosition = lpLeft
      TabOrder = 2
    end
    object edLogSize: TLabeledEdit
      Left = 96
      Top = 36
      Width = 33
      Height = 21
      EditLabel.Width = 82
      EditLabel.Height = 13
      EditLabel.Caption = 'Process only first'
      LabelPosition = lpLeft
      TabOrder = 3
      Text = '10'
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 65
    Width = 786
    Height = 382
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 345
      Top = 0
      Height = 382
      ResizeStyle = rsUpdate
      ExplicitLeft = 408
      ExplicitTop = 176
      ExplicitHeight = 100
    end
    object vstForms: TVirtualEditTree
      Left = 0
      Top = 0
      Width = 345
      Height = 382
      Align = alLeft
      Colors.SelectionRectangleBlendColor = clGray
      Colors.SelectionRectangleBorderColor = clBlack
      Colors.SelectionTextColor = clBlack
      Header.AutoSizeIndex = 1
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Height = 21
      Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
      NodeDataSize = 8
      SelectionBlendFactor = 32
      SelectionCurveRadius = 3
      TabOrder = 0
      TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
      TreeOptions.MiscOptions = [toInitOnSave, toToggleOnDblClick, toWheelPanning]
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
      TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect]
      TreeOptions.StringOptions = [toAutoAcceptEditChange]
      Columns = <
        item
          Position = 0
          Width = 100
          WideText = 'String ID'
        end
        item
          Position = 1
          Width = 241
          WideText = 'Text'
        end>
    end
    object memoText: TMemo
      Left = 348
      Top = 0
      Width = 438
      Height = 382
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
      ExplicitLeft = 351
    end
  end
  object dlgOpen: TOpenDialog
    Left = 456
    Top = 16
  end
end
