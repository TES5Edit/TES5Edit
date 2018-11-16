object frmRichEdit: TfrmRichEdit
  Left = 0
  Top = 0
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
    TabOrder = 3
  end
  object reMain: TJvRichEdit
    Left = 8
    Top = 35
    Width = 848
    Height = 541
    Anchors = [akLeft, akTop, akRight, akBottom]
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
  object cbDontShowAgain: TCheckBox
    Left = 664
    Top = 586
    Width = 111
    Height = 17
    Anchors = [akRight, akBottom]
    Caption = '&Don'#39't show again'
    TabOrder = 2
  end
  object edSearch: TLabeledEdit
    Left = 48
    Top = 8
    Width = 601
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 37
    EditLabel.Height = 13
    EditLabel.Caption = '&Search:'
    LabelPosition = lpLeft
    TabOrder = 0
    OnKeyPress = edSearchKeyPress
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
    TabOrder = 4
    OnChange = tbrZoomChange
  end
  object tmrEnableButton: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrEnableButtonTimer
    Left = 424
    Top = 320
  end
end
