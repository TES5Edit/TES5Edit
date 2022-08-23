object FormTaskProgress: TFormTaskProgress
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Progress'
  ClientHeight = 126
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBar: TProgressBar
    Left = 16
    Top = 16
    Width = 452
    Height = 33
    Smooth = True
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 474
    Top = 16
    Width = 112
    Height = 33
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object pnlError: TPanel
    Left = 0
    Top = 55
    Width = 594
    Height = 71
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    object Label1: TLabel
      Left = 16
      Top = 2
      Width = 102
      Height = 13
      Caption = 'Error has occured:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object memoError: TMemo
      Left = 16
      Top = 21
      Width = 570
      Height = 41
      BorderStyle = bsNone
      ParentColor = True
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
