object FormSearchReplace: TFormSearchReplace
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Search and Replace'
  ClientHeight = 185
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edSearch: TLabeledEdit
    Left = 14
    Top = 61
    Width = 473
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Search'
    TabOrder = 0
  end
  object edReplace: TLabeledEdit
    Left = 14
    Top = 109
    Width = 473
    Height = 21
    EditLabel.Width = 61
    EditLabel.Height = 13
    EditLabel.Caption = 'Replace with'
    TabOrder = 1
  end
  object Button1: TButton
    Left = 278
    Top = 145
    Width = 97
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 390
    Top = 145
    Width = 97
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object rbReplace: TRadioButton
    Left = 14
    Top = 16
    Width = 91
    Height = 17
    Caption = 'Replace'
    Checked = True
    TabOrder = 4
    TabStop = True
    OnClick = rbReplaceClick
  end
  object rbPrepend: TRadioButton
    Left = 126
    Top = 16
    Width = 91
    Height = 17
    Caption = 'Prepend Text'
    TabOrder = 5
    OnClick = rbReplaceClick
  end
  object rbAppend: TRadioButton
    Left = 246
    Top = 16
    Width = 91
    Height = 17
    Caption = 'Append Text'
    TabOrder = 6
    OnClick = rbReplaceClick
  end
end
