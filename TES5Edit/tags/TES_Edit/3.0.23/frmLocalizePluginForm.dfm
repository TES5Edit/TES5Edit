object frmLocalizePlugin: TfrmLocalizePlugin
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Localize plugin'
  ClientHeight = 351
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 569
    Height = 34
    AutoSize = False
    Caption = 
      'Localization process will create strings files with localizable ' +
      'strings and replace their values in plugin with indexes. Strings' +
      ' can be optionally translated into another language using a pair' +
      's of existing strings files as a vocabulary.'
    WordWrap = True
  end
  object gbTranslation: TGroupBox
    Left = 8
    Top = 56
    Width = 569
    Height = 257
    Enabled = False
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 15
      Width = 71
      Height = 13
      Caption = 'From language'
    end
    object Label3: TLabel
      Left = 296
      Top = 13
      Width = 59
      Height = 13
      Caption = 'To language'
    end
    object clbFrom: TCheckListBox
      Left = 16
      Top = 32
      Width = 257
      Height = 209
      ItemHeight = 13
      TabOrder = 0
    end
    object clbTo: TCheckListBox
      Left = 296
      Top = 32
      Width = 257
      Height = 209
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object cbTranslation: TCheckBox
    Left = 24
    Top = 48
    Width = 73
    Height = 17
    Caption = 'Translation'
    TabOrder = 1
    OnClick = cbTranslationClick
  end
  object btnOK: TButton
    Left = 206
    Top = 319
    Width = 75
    Height = 25
    Caption = 'Localize'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 304
    Top = 319
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
