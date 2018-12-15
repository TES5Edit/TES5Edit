object frmLegend: TfrmLegend
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Legend'
  ClientHeight = 636
  ClientWidth = 1296
  Color = clBtnFace
  Constraints.MinHeight = 100
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dgLegend: TDrawGrid
    Left = 0
    Top = 0
    Width = 1296
    Height = 636
    Align = alClient
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    ScrollBars = ssNone
    TabOrder = 0
    OnDrawCell = dgLegendDrawCell
  end
end
