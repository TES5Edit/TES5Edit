object frmWorldspaceCellDetails: TfrmWorldspaceCellDetails
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Worldspace Cell'
  ClientHeight = 142
  ClientWidth = 172
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblX: TLabel
    Left = 36
    Top = 57
    Width = 6
    Height = 13
    Caption = '&X'
    FocusControl = sedX
  end
  object lblY: TLabel
    Left = 36
    Top = 85
    Width = 6
    Height = 13
    Caption = '&Y'
    FocusControl = sedY
  end
  object rbPersistent: TRadioButton
    Left = 8
    Top = 8
    Width = 113
    Height = 17
    Caption = '&Persistent'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object rbTemporary: TRadioButton
    Left = 8
    Top = 31
    Width = 113
    Height = 17
    Caption = '&Temporary'
    TabOrder = 1
    OnClick = rbTemporaryClick
  end
  object sedX: TSpinEdit
    Left = 48
    Top = 54
    Width = 65
    Height = 22
    MaxValue = 9999
    MinValue = -9999
    TabOrder = 2
    Value = 0
  end
  object sedY: TSpinEdit
    Left = 48
    Top = 82
    Width = 65
    Height = 22
    MaxValue = 9999
    MinValue = -9999
    TabOrder = 3
    Value = 0
  end
  object btnCancel: TButton
    Left = 89
    Top = 110
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object btnOK: TButton
    Left = 8
    Top = 110
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
end
