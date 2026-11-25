object frmChangeName: TfrmChangeName
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Change NAME'
  ClientHeight = 600
  ClientWidth = 900
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object lblHeading: TLabel
    AlignWithMargins = True
    Left = 6
    Top = 6
    Width = 888
    Height = 13
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Align = alTop
    ShowAccelChar = False
    WordWrap = True
  end
  object lblFields: TLabel
    AlignWithMargins = True
    Left = 6
    Top = 28
    Width = 888
    Height = 13
    Margins.Left = 6
    Margins.Right = 6
    Align = alTop
    Caption = 'Fields that name the old identity (checked: rewritten to the new one):'
    ShowAccelChar = False
  end
  object vstFields: TVirtualStringTree
    AlignWithMargins = True
    Left = 6
    Top = 47
    Width = 888
    Height = 220
    Margins.Left = 6
    Margins.Right = 6
    Align = alTop
    Header.AutoSizeIndex = 3
    Header.Options = [hoAutoResize, hoColumnResize, hoShowSortGlyphs, hoVisible]
    Header.SortColumn = 0
    TabOrder = 0
    TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toInitOnSave, toWheelPanning]
    TreeOptions.PaintOptions = [toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnChecked = vstFieldsChecked
    OnChecking = vstFieldsChecking
    OnCompareNodes = vstFieldsCompareNodes
    OnGetText = vstFieldsGetText
    OnHeaderClick = vstFieldsHeaderClick
    OnInitNode = vstFieldsInitNode
    Columns = <
      item
        Position = 0
        Text = '#'
        Width = 50
      end
      item
        Position = 1
        Text = 'Record'
        Width = 220
      end
      item
        Position = 2
        Text = 'File'
        Width = 120
      end
      item
        Position = 3
        Text = 'Path'
        Width = 218
      end
      item
        Position = 4
        Text = 'Value'
        Width = 100
      end
      item
        Position = 5
        Text = 'Outcome'
        Width = 180
      end>
  end
  object mmoText: TMemo
    AlignWithMargins = True
    Left = 6
    Top = 273
    Width = 888
    Height = 280
    Margins.Left = 6
    Margins.Right = 6
    Align = alClient
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 556
    Width = 900
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      900
      44)
    object btnApply: TButton
      Left = 732
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Apply'
      TabOrder = 0
      OnClick = btnApplyClick
    end
    object btnCancel: TButton
      Left = 816
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
