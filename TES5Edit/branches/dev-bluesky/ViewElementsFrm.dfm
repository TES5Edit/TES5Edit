object frmViewElements: TfrmViewElements
  Left = 0
  Top = 0
  ClientHeight = 300
  ClientWidth = 565
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 549
    Height = 251
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
      Height = 249
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
    Top = 267
    Width = 565
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object pnlButtons: TPanel
      Left = 192
      Top = 0
      Width = 373
      Height = 33
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnCompare: TButton
        Left = 53
        Top = 3
        Width = 91
        Height = 27
        Caption = '比较'
        DropDownMenu = PopupMenu1
        Style = bsSplitButton
        TabOrder = 0
        OnClick = btnCompareClick
      end
      object btnOK: TButton
        Left = 177
        Top = 3
        Width = 91
        Height = 27
        Caption = '保存'
        ModalResult = 1
        TabOrder = 1
        Visible = False
      end
      object btnCancel: TButton
        Left = 274
        Top = 3
        Width = 91
        Height = 27
        Caption = '关闭'
        ModalResult = 2
        TabOrder = 2
        OnClick = btnCancelClick
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 200
    Top = 216
    object mniCompareConf: TMenuItem
      Caption = '配置外部工具'
      OnClick = mniCompareConfClick
    end
  end
  object dlgCompareTool: TOpenDialog
    Filter = '可执行文件 (*.exe)|*.exe'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = '选择外部比较工具'
    Left = 288
    Top = 216
  end
end
