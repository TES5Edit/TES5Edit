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
  TextHeight = 15
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 559
    Height = 286
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 545
    ExplicitHeight = 275
    object pcView: TPageControl
      Left = 1
      Top = 1
      Width = 557
      Height = 284
      Align = alClient
      TabOrder = 0
      TabPosition = tpBottom
      ExplicitWidth = 543
      ExplicitHeight = 273
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
    ExplicitTop = 291
    ExplicitWidth = 561
    object pnlButtons: TFlowPanel
      Left = 0
      Top = 0
      Width = 565
      Height = 33
      Align = alClient
      Alignment = taRightJustify
      AutoWrap = False
      BevelOuter = bvNone
      FlowStyle = fsRightLeftTopBottom
      TabOrder = 0
      ExplicitWidth = 561
      object btnCancel: TButton
        AlignWithMargins = True
        Left = 472
        Top = 3
        Width = 90
        Height = 27
        Caption = 'Close'
        ModalResult = 2
        TabOrder = 4
        OnClick = btnCancelClick
      end
      object btnOK: TButton
        AlignWithMargins = True
        Left = 376
        Top = 3
        Width = 90
        Height = 27
        Caption = 'Save'
        ModalResult = 1
        TabOrder = 3
        Visible = False
      end
      object LiteCompareButton: TButton
        AlignWithMargins = True
        Left = 280
        Top = 3
        Width = 90
        Height = 27
        Caption = 'Compare'
        DropDownMenu = PopupMenu1
        TabOrder = 2
        Visible = False
        OnClick = btnCompareClick
      end
      object btnCompare: TButton
        AlignWithMargins = True
        Left = 184
        Top = 3
        Width = 90
        Height = 27
        Caption = 'Compare'
        DropDownMenu = PopupMenu1
        Style = bsSplitButton
        TabOrder = 1
        OnClick = btnCompareClick
      end
      object LiteCopyButton: TButton
        AlignWithMargins = True
        Left = 88
        Top = 3
        Width = 90
        Height = 27
        Align = alLeft
        Caption = 'Copy'
        TabOrder = 0
        OnClick = btnCopyToClipboard
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
