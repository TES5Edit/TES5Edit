object FrameRemoveUnusedNodes: TFrameRemoveUnusedNodes
  Left = 0
  Top = 0
  Width = 445
  Height = 260
  TabOrder = 0
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 445
    Height = 17
    Align = alTop
    Caption = 
      'Remove unused blocks which are not referenced by root nodes and ' +
      'their children.'
    TabOrder = 0
  end
  object chkSingleRoot: TCheckBox
    Left = 16
    Top = 31
    Width = 417
    Height = 17
    Caption = 'Leave single root node (remaining root nodes will be removed)'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
end
