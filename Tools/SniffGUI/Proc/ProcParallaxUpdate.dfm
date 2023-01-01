object FrameParallaxUpdate: TFrameParallaxUpdate
  Left = 0
  Top = 0
  Width = 494
  Height = 307
  TabOrder = 0
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 494
    Height = 25
    Align = alTop
    AutoSize = False
    Caption = 'Update parallax settings in BSShaderPPLightingProperty'
    TabOrder = 0
  end
  object edMaxPasses: TLabeledEdit
    Left = 16
    Top = 48
    Width = 129
    Height = 21
    EditLabel.Width = 97
    EditLabel.Height = 13
    EditLabel.Caption = 'Parallax max passes'
    TabOrder = 1
    Text = '8.0000'
  end
  object edScale: TLabeledEdit
    Left = 16
    Top = 96
    Width = 129
    Height = 21
    EditLabel.Width = 65
    EditLabel.Height = 13
    EditLabel.Caption = 'Parallax scale'
    TabOrder = 2
    Text = '0.0500'
  end
end
