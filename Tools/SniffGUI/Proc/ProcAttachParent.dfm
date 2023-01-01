object FrameAttachParent: TFrameAttachParent
  Left = 0
  Top = 0
  Width = 479
  Height = 301
  TabOrder = 0
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 479
    Height = 25
    Align = alTop
    AutoSize = False
    Caption = 
      'Find NiNode or it'#39's descendant blocks by name and attach parent ' +
      'NiNode'
    TabOrder = 0
  end
  object edFindNodeName: TLabeledEdit
    Left = 16
    Top = 48
    Width = 225
    Height = 21
    EditLabel.Width = 97
    EditLabel.Height = 13
    EditLabel.Caption = 'NiNode name to find'
    TabOrder = 1
    Text = '##SightingNode'
  end
  object edAttachNodeName: TLabeledEdit
    Left = 16
    Top = 96
    Width = 225
    Height = 21
    EditLabel.Width = 145
    EditLabel.Height = 13
    EditLabel.Caption = 'Attached parent NiNode name'
    TabOrder = 2
    Text = '##ISControl'
  end
end
