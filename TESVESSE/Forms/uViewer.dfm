object fViewer: TfViewer
  Left = 0
  Top = 0
  Caption = 'Papyrus Viewer'
  ClientHeight = 322
  ClientWidth = 713
  Color = 15790320
  Constraints.MinHeight = 240
  Constraints.MinWidth = 480
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PrintScale = poNone
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object pnMenu: TPanel
    Left = 0
    Top = 291
    Width = 713
    Height = 31
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = 15790320
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object lbSearch: TLabel
      Left = 20
      Top = 8
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Search:'
      FocusControl = edSearch
    end
    object edSearch: TEdit
      Left = 63
      Top = 5
      Width = 162
      Height = 19
      TabOrder = 0
      OnChange = edSearchChange
      OnKeyDown = edSearchKeyDown
      OnKeyPress = edSearchKeyPress
    end
    object stNotFound: TStaticText
      Left = 311
      Top = 8
      Width = 52
      Height = 17
      Caption = 'Not found'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Visible = False
    end
  end
end
