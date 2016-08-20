object frmTip: TfrmTip
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Tip'
  ClientHeight = 213
  ClientWidth = 534
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 0
    Top = 0
    Width = 534
    Height = 213
    Align = alClient
    Brush.Color = clWindow
    Pen.Color = clWindowText
    ExplicitWidth = 550
  end
  object lblNextTip: TLabel
    Left = 470
    Top = 182
    Width = 34
    Height = 13
    Cursor = crHandPoint
    Caption = 'Next >'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = lblNextTipClick
  end
  object textTip: TStaticText
    Left = 24
    Top = 56
    Width = 488
    Height = 113
    AutoSize = False
    Caption = 
      'Please always try the latest xEdit version from Nexus before rep' +
      'orting any issues'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ShowAccelChar = False
    TabOrder = 0
  end
  object StaticText1: TStaticText
    Left = 24
    Top = 18
    Width = 34
    Height = 27
    Caption = 'Tip'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object cbShowTip: TCheckBox
    Left = 24
    Top = 188
    Width = 257
    Height = 17
    Caption = 'Show tip (you can enable back in Options)'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = cbShowTipClick
  end
end
