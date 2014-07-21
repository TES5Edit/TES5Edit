object fAddScript: TfAddScript
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add Script'
  ClientHeight = 361
  ClientWidth = 434
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
  PixelsPerInch = 96
  TextHeight = 13
  object stSName: TStaticText
    Left = 8
    Top = 11
    Width = 80
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Script name:'
    FocusControl = edSName
    TabOrder = 0
  end
  object stSType: TStaticText
    Left = 8
    Top = 53
    Width = 80
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Script type:'
    FocusControl = cbSType
    TabOrder = 1
  end
  object cbSType: TComboBox
    Left = 95
    Top = 50
    Width = 330
    Height = 21
    AutoComplete = False
    DropDownCount = 32
    ItemHeight = 13
    TabOrder = 2
  end
  object edSName: TEdit
    Left = 96
    Top = 8
    Width = 330
    Height = 21
    MaxLength = 8
    TabOrder = 3
    OnEnter = edSNameEnter
    OnExit = edSNameExit
  end
  object stSExists: TStaticText
    Left = 94
    Top = 30
    Width = 331
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Script name already exists'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Visible = False
  end
  object lvParameters: TListView
    Left = 8
    Top = 106
    Width = 417
    Height = 150
    Columns = <
      item
        Caption = 'No'
      end
      item
        Caption = 'Name'
        Width = 200
      end
      item
        Caption = 'Type'
        Width = -2
        WidthType = (
          -2)
      end>
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 5
    ViewStyle = vsReport
    OnSelectItem = lvParametersSelectItem
  end
  object stParameters: TStaticText
    Left = 8
    Top = 80
    Width = 80
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Parameters:'
    TabOrder = 6
  end
  object stCount: TStaticText
    Left = 94
    Top = 80
    Width = 331
    Height = 17
    AutoSize = False
    Caption = '0'
    TabOrder = 7
  end
  object stPName: TStaticText
    Left = 8
    Top = 262
    Width = 49
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Name:'
    FocusControl = edPName
    TabOrder = 8
  end
  object edPName: TEdit
    Left = 64
    Top = 260
    Width = 362
    Height = 21
    MaxLength = 8
    TabOrder = 9
    OnEnter = edPNameEnter
    OnExit = edPNameExit
  end
  object stPExists: TStaticText
    Left = 63
    Top = 281
    Width = 362
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Parametr name already exists'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    Visible = False
  end
  object stPType: TStaticText
    Left = 8
    Top = 305
    Width = 49
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Type:'
    FocusControl = cbPType
    TabOrder = 11
  end
  object cbPType: TComboBox
    Left = 63
    Top = 304
    Width = 362
    Height = 21
    AutoComplete = False
    DropDownCount = 32
    ItemHeight = 13
    TabOrder = 12
  end
end
