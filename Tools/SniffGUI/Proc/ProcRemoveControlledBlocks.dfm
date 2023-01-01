object FrameRemoveControlledBlocks: TFrameRemoveControlledBlocks
  Left = 0
  Top = 0
  Width = 433
  Height = 266
  TabOrder = 0
  DesignSize = (
    433
    266)
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 433
    Height = 33
    Align = alTop
    AutoSize = False
    Caption = 
      'Remove controlled blocks from NiControllerSequence if their name' +
      's in "Node Name" field match or contain provided word(s). Search' +
      'ing is case insensitive.'
    TabOrder = 0
  end
  object edNames: TLabeledEdit
    Left = 16
    Top = 64
    Width = 369
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 186
    EditLabel.Height = 13
    EditLabel.Caption = 'Names, separated by comma if several'
    TabOrder = 1
    Text = 'Head,Neck'
  end
  object chkNotMatching: TCheckBox
    Left = 16
    Top = 123
    Width = 297
    Height = 17
    Caption = 'Remove blocks NOT matching the listed names'
    TabOrder = 2
  end
  object chkExactMatch: TCheckBox
    Left = 16
    Top = 91
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
    TabOrder = 3
  end
end
