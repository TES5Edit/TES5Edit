object FrameAnimQuadraticToLinear: TFrameAnimQuadraticToLinear
  Left = 0
  Top = 0
  Width = 441
  Height = 307
  TabOrder = 0
  DesignSize = (
    441
    307)
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 441
    Height = 57
    Align = alTop
    AutoSize = False
    Caption = 
      'Change quadratic interpolation (translation and XYZ rotation) to' +
      ' linear in transform data of controlled blocks of NiControllerSe' +
      'quence if their names in "Node Name" field match or contain prov' +
      'ided word(s). Searching is case insensitive.'
    TabOrder = 0
  end
  object edNames: TLabeledEdit
    Left = 16
    Top = 80
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
    Top = 139
    Width = 297
    Height = 17
    Caption = 'Change in blocks NOT matching the listed names'
    TabOrder = 2
  end
  object chkExactMatch: TCheckBox
    Left = 16
    Top = 107
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
