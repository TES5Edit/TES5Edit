object fAddFormIDArray: TfAddFormIDArray
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add FormID Array'
  ClientHeight = 120
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poNone
  Scaled = False
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  DesignSize = (
    250
    120)
  PixelsPerInch = 96
  TextHeight = 13
  object stFormIDArray: TStaticText
    Left = 8
    Top = 11
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'FormID Array:'
    FocusControl = meFormIDArray
    TabOrder = 0
  end
  object meFormIDArray: TMaskEdit
    Left = 95
    Top = 8
    Width = 147
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditMask = 'AA AA AA;1;_'
    MaxLength = 8
    TabOrder = 1
    Text = '        '
    OnEnter = meFormIDArrayEnter
    OnExit = meFormIDArrayExit
    OnKeyPress = meFormIDArrayKeyPress
  end
  object edCount: TEdit
    Left = 95
    Top = 33
    Width = 132
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Text = '1'
    OnKeyPress = edCountKeyPress
  end
  object stCounter: TStaticText
    Left = 8
    Top = 37
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Count:'
    FocusControl = edCount
    TabOrder = 3
  end
  object udCount: TUpDown
    Left = 227
    Top = 33
    Width = 16
    Height = 21
    Anchors = [akTop, akRight]
    Associate = edCount
    Max = 255
    Position = 1
    TabOrder = 4
  end
  object stIDExists: TStaticText
    Left = 8
    Top = 63
    Width = 113
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'FormID can'#39't be empty'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
end
