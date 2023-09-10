object frmViewElements: TfrmViewElements
  Left = 0
  Top = 0
  ClientHeight = 325
  ClientWidth = 565
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 549
    Height = 276
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 0
    object pcView: TPageControl
      Left = 1
      Top = 1
      Width = 547
      Height = 274
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      TabOrder = 0
      TabPosition = tpBottom
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 292
    Width = 565
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    PopupMenu = PopupMenu1
    TabOrder = 1
    object pnlButtons: TPanel
      Left = 192
      Top = 0
      Width = 373
      Height = 33
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object LiteCopyButton: TButton
        Left = 0
        Top = 3
        Width = 75
        Height = 25
        TabOrder = 0
        Caption = 'Copy'
        OnClick = btnCopyToClipboard
      end
      object btnCompare: TButton
        Left = 53
        Top = 3
        Width = 91
        Height = 27
        Caption = 'Compare'
        DropDownMenu = PopupMenu1
        Style = bsSplitButton
        TabOrder = 1
        OnClick = btnCompareClick
      end
      object btnOK: TButton
        Left = 177
        Top = 3
        Width = 91
        Height = 27
        Caption = 'Save'
        ModalResult = 1
        TabOrder = 2
        Visible = False
      end
      object btnCancel: TButton
        Left = 274
        Top = 3
        Width = 91
        Height = 27
        Caption = 'Close'
        ModalResult = 2
        TabOrder = 3
        OnClick = btnCancelClick
      end
      object LiteCompareButton: TButton
        Left = 105
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Compare'
        DropDownMenu = PopupMenu1
        TabOrder = 4
        Visible = False
        OnClick = btnCompareClick
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 200
    Top = 216
    object mniCompareConf: TMenuItem
      Caption = 'Configure external tool'
      OnClick = mniCompareConfClick
    end
  end
  object dlgCompareTool: TOpenDialog
    Filter = 'Executable file (*.exe)|*.exe'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Select an external comparison tool'
    Left = 288
    Top = 216
  end
  object FindDialog1: TFindDialog
    Options = [frDown, frHideWholeWord, frHideUpDown, frDisableUpDown, frDisableWholeWord]
    OnFind = FindDialog1Find
    Left = 392
    Top = 136
  end
end
