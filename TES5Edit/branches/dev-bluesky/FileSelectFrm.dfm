object frmFileSelect: TfrmFileSelect
  Left = 0
  Top = 0
  Caption = '选择插件'
  ClientHeight = 615
  ClientWidth = 332
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    332
    615)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 33
    Height = 13
    Caption = '搜索'
  end
  object CheckListBox1: TCheckListBox
    AlignWithMargins = True
    Left = 3
    Top = 40
    Width = 326
    Height = 535
    Margins.Top = 40
    Margins.Bottom = 40
    Align = alClient
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnDblClick = CheckListBox1DblClick
  end
  object BitBtn1: TBitBtn
    Left = 249
    Top = 582
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '确定'
    DoubleBuffered = True
    Kind = bkOK
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object edSearch: TEdit
    Left = 47
    Top = 8
    Width = 282
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    OnChange = edSearchChange
  end
  object cbBackup: TCheckBox
    Left = 8
    Top = 582
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = '备份插件'
    Checked = True
    State = cbChecked
    TabOrder = 3
    Visible = False
  end
  object PopupMenu1: TPopupMenu
    Left = 128
    Top = 184
    object SelectAll1: TMenuItem
      Caption = '全部'
      OnClick = SelectAll1Click
    end
    object SelectNone1: TMenuItem
      Caption = '全不'
      OnClick = SelectNone1Click
    end
    object InvertSelection1: TMenuItem
      Caption = '反选'
      OnClick = InvertSelection1Click
    end
  end
end
