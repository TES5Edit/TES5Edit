object frmFileSelect: TfrmFileSelect
  Left = 0
  Top = 0
  Caption = 'Master/Plugin Selection'
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
  object CheckListBox1: TCheckListBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 326
    Height = 572
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
    TabOrder = 1
    Kind = bkOK
  end
  object PopupMenu1: TPopupMenu
    Left = 128
    Top = 184
    object SelectAll1: TMenuItem
      Caption = 'Select All'
      OnClick = SelectAll1Click
    end
    object SelectNone1: TMenuItem
      Caption = 'Select None'
      OnClick = SelectNone1Click
    end
    object InvertSelection1: TMenuItem
      Caption = 'Invert Selection'
      OnClick = InvertSelection1Click
    end
  end
end
