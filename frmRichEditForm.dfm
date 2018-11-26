object frmRichEdit: TfrmRichEdit
  Left = 0
  Top = 0
  ActiveControl = edSearch
  BorderIcons = [biSystemMenu, biMaximize]
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
  object Label1: TLabel
    Left = 669
    Top = 11
    Width = 30
    Height = 13
    Anchors = [akTop, akRight]
    Caption = '&Zoom:'
    FocusControl = tbrZoom
  end
  object btnOK: TButton
    Left = 781
    Top = 582
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Enabled = False
    ModalResult = 1
    TabOrder = 5
  end
  object cbDontShowAgain: TCheckBox
    Left = 600
    Top = 586
    Width = 175
    Height = 17
    Anchors = [akRight, akBottom]
    Caption = '&Don'#39't show again until changed'
    TabOrder = 4
  end
  object tbrZoom: TTrackBar
    Left = 706
    Top = 8
    Width = 150
    Height = 21
    Anchors = [akTop, akRight]
    Max = 400
    Min = 25
    Frequency = 10
    Position = 100
    PositionToolTip = ptTop
    ShowSelRange = False
    TabOrder = 2
    OnChange = tbrZoomChange
  end
  object pnlMain: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 35
    Width = 858
    Height = 545
    Margins.Top = 35
    Margins.Bottom = 35
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object splTOC: TJvSplitter
      Left = 185
      Top = 0
      Height = 545
      AutoSnap = False
      MinSize = 150
      ResizeStyle = rsUpdate
      Visible = False
      OnMoved = splTOCMoved
      ExplicitLeft = 1000
      ExplicitHeight = 536
    end
    object reMain: TJvRichEdit
      Left = 188
      Top = 0
      Width = 670
      Height = 545
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      HideSelection = False
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      SelText = ''
      StreamFormat = sfRichText
      TabOrder = 1
      WantReturns = False
    end
    object pnlTOC: TPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 545
      Align = alLeft
      BevelOuter = bvNone
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Visible = False
      object vstTOC: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 185
        Height = 545
        Align = alClient
        DefaultText = 'Node'
        Header.AutoSizeIndex = 0
        Header.MainColumn = -1
        HintMode = hmTooltip
        ScrollBarOptions.ScrollBars = ssVertical
        TabOrder = 0
        TreeOptions.PaintOptions = [toHideFocusRect, toHideSelection, toShowHorzGridLines, toThemeAware, toUseBlendedImages, toZebra]
        TreeOptions.SelectionOptions = [toFullRowSelect]
        OnCollapsing = vstTOCCollapsing
        OnGetText = vstTOCGetText
        OnNodeDblClick = vstTOCNodeDblClick
        Columns = <>
      end
    end
  end
  object edSearch: TLabeledEdit
    Left = 104
    Top = 8
    Width = 545
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 37
    EditLabel.Height = 13
    EditLabel.Caption = '&Search:'
    LabelPosition = lpLeft
    TabOrder = 1
    OnKeyPress = edSearchKeyPress
  end
  object btnTOC: TButton
    Left = 8
    Top = 8
    Width = 49
    Height = 21
    Caption = '&TOC'
    TabOrder = 0
    OnClick = btnTOCClick
  end
  object tmrEnableButton: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrEnableButtonTimer
    Left = 672
    Top = 344
  end
end
