object fCompare: TfCompare
  Left = 0
  Top = 0
  Caption = 'Compare ESS files'
  ClientHeight = 545
  ClientWidth = 1008
  Color = 15790320
  Constraints.MinHeight = 240
  Constraints.MinWidth = 320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PrintScale = poNone
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnMenu: TPanel
    Left = 0
    Top = 354
    Width = 1008
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = ' '
    Color = 15790320
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
  end
  object lvDiffs: TListView
    Left = 0
    Top = 0
    Width = 1008
    Height = 354
    Align = alClient
    Color = 15790320
    Columns = <
      item
        Caption = 'Index'
      end
      item
        Caption = 'Type'
        Width = 90
      end
      item
        Caption = 'State'
        Width = 75
      end
      item
        Caption = 'Reference'
        Width = 125
      end
      item
        Caption = 'Size 1st'
        Width = 75
      end
      item
        Caption = 'Size 2nd'
        Width = 75
      end
      item
        Caption = 'Type 1st'
        Width = 75
      end
      item
        Caption = 'Type 2nd'
        Width = 75
      end
      item
        Caption = 'Flags 1st'
        Width = 75
      end
      item
        Caption = 'Flags 2nd'
        Width = 75
      end
      item
        Caption = 'Version 1st'
        Width = 80
      end
      item
        Caption = 'Version 2nd'
        Width = 80
      end>
    Ctl3D = False
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 1
    ViewStyle = vsReport
    OnColumnClick = lvDiffsColumnClick
    OnCustomDrawItem = lvDiffsCustomDrawItem
    OnData = lvDiffsData
    OnSelectItem = lvDiffsSelectItem
  end
  object mmDiff: TMemo
    Left = 0
    Top = 385
    Width = 1008
    Height = 160
    Align = alBottom
    BevelOuter = bvSpace
    Color = 15790320
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
    Visible = False
    WordWrap = False
  end
  object sdCSVSave: TSaveDialog
    DefaultExt = 'CSV'
    Filter = 'CSV files (*.csv)|*.csv|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 24
    Top = 24
  end
end
