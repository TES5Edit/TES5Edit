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
    Cancel = True
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 0
  end
  object reMain: TJvRichEdit
    Left = 8
    Top = 8
    Width = 848
    Height = 568
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
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
    Caption = '&Don'#39't show again'
    TabOrder = 2
  end
  object tmrEnableButton: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrEnableButtonTimer
    Left = 424
    Top = 320
  end
end
