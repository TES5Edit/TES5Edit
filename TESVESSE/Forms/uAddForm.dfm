object fAddForm: TfAddForm
  Left = 0
  Top = 0
  Caption = 'Add Change Form'
  ClientHeight = 532
  ClientWidth = 820
  Color = clBtnFace
  Constraints.MinHeight = 220
  Constraints.MinWidth = 640
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
    820
    532)
  PixelsPerInch = 96
  TextHeight = 13
  object stFormID: TStaticText
    Left = 8
    Top = 11
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'FormID:'
    FocusControl = meFormID
    TabOrder = 0
  end
  object tvFlags: TTreeView
    Left = 308
    Top = 8
    Width = 503
    Height = 515
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    Indent = 19
    ParentCtl3D = False
    ReadOnly = True
    ShowLines = False
    ShowRoot = False
    TabOrder = 1
    OnCustomDrawItem = tvFlagsCustomDrawItem
  end
  object meFormID: TMaskEdit
    Left = 95
    Top = 8
    Width = 120
    Height = 21
    EditMask = 'AA AA AA;1;_'
    MaxLength = 8
    TabOrder = 2
    Text = '        '
    OnEnter = meFormIDEnter
    OnExit = meFormIDExit
    OnKeyPress = meFormIDKeyPress
  end
  object stType: TStaticText
    Left = 8
    Top = 38
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Type:'
    FocusControl = cbType
    TabOrder = 3
  end
  object cbType: TComboBox
    Left = 95
    Top = 35
    Width = 120
    Height = 21
    AutoComplete = False
    DropDownCount = 32
    ItemHeight = 13
    TabOrder = 4
    OnChange = cbTypeSelect
    OnDropDown = cbTypeDropDown
    OnSelect = cbTypeSelect
  end
  object stTypeView: TStaticText
    Left = 221
    Top = 38
    Width = 59
    Height = 17
    Caption = 'stTypeView'
    TabOrder = 5
  end
  object edVersion: TEdit
    Left = 95
    Top = 62
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '74'
    OnKeyPress = edVersionKeyPress
  end
  object stVersion: TStaticText
    Left = 8
    Top = 65
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Version:'
    FocusControl = edVersion
    TabOrder = 7
  end
  object stChangeFlag: TStaticText
    Left = 221
    Top = 11
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Change flag:'
    FocusControl = tvFlags
    TabOrder = 8
  end
  object stDataSize: TStaticText
    Left = 8
    Top = 92
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Data size:'
    FocusControl = meFormID
    TabOrder = 9
  end
  object stSize: TStaticText
    Left = 95
    Top = 92
    Width = 32
    Height = 17
    Caption = 'stSize'
    TabOrder = 10
  end
  object stIDExists: TStaticText
    Left = 95
    Top = 118
    Width = 113
    Height = 17
    Caption = 'FormID can'#39't be empty'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object odBinOpen: TOpenDialog
    Filter = 'Binary files (*.bin)|*.bin|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 8
    Top = 120
  end
end
