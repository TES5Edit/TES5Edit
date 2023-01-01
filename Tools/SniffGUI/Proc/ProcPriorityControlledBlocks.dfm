object FramePriorityControlledBlocks: TFramePriorityControlledBlocks
  Left = 0
  Top = 0
  Width = 436
  Height = 297
  TabOrder = 0
  DesignSize = (
    436
    297)
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 436
    Height = 49
    Align = alTop
    AutoSize = False
    Caption = 
      'Update priority of controlled blocks in NiControllerSequence if ' +
      'their names in "Node Name" field match or contain provided word(' +
      's). Searching is case insensitive. Leave priority fields empty t' +
      'o not update.'
    TabOrder = 0
  end
  object edNames: TLabeledEdit
    Left = 16
    Top = 72
    Width = 377
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 186
    EditLabel.Height = 13
    EditLabel.Caption = 'Names, separated by comma if several'
    TabOrder = 1
    Text = 'Head,Neck'
  end
  object edPriorityMatched: TLabeledEdit
    Left = 16
    Top = 131
    Width = 41
    Height = 21
    EditLabel.Width = 146
    EditLabel.Height = 13
    EditLabel.Caption = 'priority for the matched blocks'
    LabelPosition = lpRight
    TabOrder = 2
    Text = '10'
  end
  object edPriorityNotMatched: TLabeledEdit
    Left = 16
    Top = 158
    Width = 41
    Height = 21
    EditLabel.Width = 165
    EditLabel.Height = 13
    EditLabel.Caption = 'priority for the not matched blocks'
    LabelPosition = lpRight
    TabOrder = 3
  end
  object chkExactMatch: TCheckBox
    Left = 16
    Top = 99
    Width = 121
    Height = 17
    Hint = 
      'Should block names match names exactly or partially (contain the' +
      'm)'
    Caption = 'Exact match'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 4
  end
end
