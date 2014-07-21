object fPapyrus: TfPapyrus
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Copy variables'
  ClientHeight = 322
  ClientWidth = 713
  Color = 15790320
  Constraints.MinHeight = 240
  Constraints.MinWidth = 320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poNone
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
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
  end
  object sdExport: TSaveDialog
    Filter = 
      'RichText files (*.rtf)|*.rtf|Text files (*.txt)|*.txt|All files ' +
      '(*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 16
    Top = 8
  end
end
