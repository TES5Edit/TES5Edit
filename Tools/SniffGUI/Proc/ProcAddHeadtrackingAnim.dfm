object FrameAddHeadtrackingAnim: TFrameAddHeadtrackingAnim
  Left = 0
  Top = 0
  Width = 464
  Height = 298
  TabOrder = 0
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 464
    Height = 33
    Align = alTop
    AutoSize = False
    Caption = 
      'Add headtracking animation. Bip01 Head "HeadTrack" NiFloatExtraD' +
      'ataController controlled block is added if missing with 4 linear' +
      ' interpolated keys.'
    TabOrder = 0
  end
  object chkCycleClampOnly: TCheckBox
    Left = 16
    Top = 47
    Width = 129
    Height = 17
    Caption = 'Cycle clamp only'
    TabOrder = 1
  end
  object edKeyValue14: TLabeledEdit
    Left = 16
    Top = 96
    Width = 129
    Height = 21
    EditLabel.Width = 107
    EditLabel.Height = 13
    EditLabel.Caption = 'Key 1 and Key 4 value'
    TabOrder = 2
    Text = '0'
  end
  object edKeyTime2: TLabeledEdit
    Left = 16
    Top = 152
    Width = 129
    Height = 21
    EditLabel.Width = 64
    EditLabel.Height = 13
    EditLabel.Caption = 'Key 2 time %'
    TabOrder = 3
    Text = '20'
  end
  object edKeyValue23: TLabeledEdit
    Left = 168
    Top = 96
    Width = 129
    Height = 21
    EditLabel.Width = 107
    EditLabel.Height = 13
    EditLabel.Caption = 'Key 2 and Key 3 value'
    TabOrder = 4
    Text = '100'
  end
  object edKeyTime3: TLabeledEdit
    Left = 168
    Top = 152
    Width = 129
    Height = 21
    EditLabel.Width = 64
    EditLabel.Height = 13
    EditLabel.Caption = 'Key 3 time %'
    TabOrder = 5
    Text = '80'
  end
end
