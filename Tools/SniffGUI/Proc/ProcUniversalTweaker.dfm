object FrameUniversalTweaker: TFrameUniversalTweaker
  Left = 0
  Top = 0
  Width = 475
  Height = 280
  TabOrder = 0
  DesignSize = (
    475
    280)
  object Label1: TLabel
    Left = 16
    Top = 55
    Width = 443
    Height = 50
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      'Block types to process, separate with comma if several. Or a pat' +
      'h to the specific block if it contains "\" which separates eithe' +
      'r a block name or a block type, for example "\BSFadeNode\arms2:2' +
      '\NiAlphaProperty".'
    WordWrap = True
  end
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 475
    Height = 49
    Align = alTop
    AutoSize = False
    Caption = 
      'Change any element in defined block(s). Path examples: scale val' +
      'ue in transformation structure "Transform\Scale", first texture ' +
      'in texture set "Textures\[0]". You can check elements names by c' +
      'onverting to JSON format using Convert to JSON operation.'
    TabOrder = 0
  end
  object edBlocks: TLabeledEdit
    Left = 16
    Top = 111
    Width = 443
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'edBlocks'
    EditLabel.WordWrap = True
    TabOrder = 1
    Text = 'NiMaterialProperty'
  end
  object edPath: TLabeledEdit
    Left = 16
    Top = 159
    Width = 201
    Height = 21
    EditLabel.Width = 133
    EditLabel.Height = 13
    EditLabel.Caption = 'Path to the element in block'
    TabOrder = 2
    Text = 'Alpha'
  end
  object edValue: TLabeledEdit
    Left = 240
    Top = 159
    Width = 219
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 26
    EditLabel.Height = 13
    EditLabel.Caption = 'Value'
    TabOrder = 3
    Text = '0.8'
  end
end
