object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'TES4 LOD Generator'
  ClientHeight = 546
  ClientWidth = 976
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Padding.Left = 3
  Padding.Top = 3
  Padding.Right = 3
  Padding.Bottom = 3
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object mmoMessages: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 970
    Height = 537
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object tmrMessages: TTimer
    Interval = 500
    OnTimer = tmrMessagesTimer
    Left = 360
    Top = 160
  end
  object tmrStartup: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrStartupTimer
    Left = 240
    Top = 144
  end
  object tmrGenerator: TTimer
    Enabled = False
    OnTimer = tmrGeneratorTimer
    Left = 240
    Top = 264
  end
end
