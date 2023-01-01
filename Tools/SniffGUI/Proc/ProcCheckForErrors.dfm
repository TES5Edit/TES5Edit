object FrameCheckForErrors: TFrameCheckForErrors
  Left = 0
  Top = 0
  Width = 534
  Height = 330
  TabOrder = 0
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 534
    Height = 25
    Align = alTop
    AutoSize = False
    Caption = 'Perform selected checks and report found issues'
    TabOrder = 0
  end
  object txtComment: TStaticText
    AlignWithMargins = True
    Left = 385
    Top = 25
    Width = 149
    Height = 305
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    AutoSize = False
    TabOrder = 1
  end
  object lvChecks: TListView
    Left = 0
    Top = 25
    Width = 377
    Height = 305
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alLeft
    BevelEdges = []
    BevelInner = bvSpace
    BevelOuter = bvRaised
    BevelKind = bkSoft
    BorderStyle = bsNone
    Checkboxes = True
    Columns = <
      item
        Width = 350
      end>
    ColumnClick = False
    DoubleBuffered = True
    HideSelection = False
    GroupView = True
    ReadOnly = True
    RowSelect = True
    ParentColor = True
    ParentDoubleBuffered = False
    PopupMenu = menuChecks
    ShowColumnHeaders = False
    TabOrder = 2
    ViewStyle = vsReport
    OnSelectItem = lvChecksSelectItem
  end
  object menuChecks: TPopupMenu
    Tag = 1
    Left = 192
    Top = 152
    object mniCheckAll: TMenuItem
      Tag = 1
      Caption = 'Check all'
      OnClick = mniCheckAllClick
    end
    object mniUncheckAll: TMenuItem
      Caption = 'Uncheck all'
      OnClick = mniCheckAllClick
    end
  end
end
