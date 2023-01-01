object FrameAnimSkeletonDeath: TFrameAnimSkeletonDeath
  Left = 0
  Top = 0
  Width = 509
  Height = 262
  TabOrder = 0
  DesignSize = (
    509
    262)
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 509
    Height = 49
    Align = alTop
    AutoSize = False
    Caption = 
      'For each death.kf in the input directory try to load skeleton.ni' +
      'f from the same directory, find bone NiNodes without collision a' +
      'nd create controlled blocks named after the bones having the sam' +
      'e transformation in NiTransformController'
    TabOrder = 0
  end
  object edNames: TLabeledEdit
    Left = 16
    Top = 80
    Width = 377
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 300
    EditLabel.Height = 13
    EditLabel.Caption = 'Skip bone(s) with these names, separated by comma if several'
    TabOrder = 1
    Text = 'Weapon,HeadAnims'
  end
  object chkExactMatch: TCheckBox
    Left = 16
    Top = 107
    Width = 121
    Height = 17
    Hint = 
      'Should bone names match names exactly or partially (contain them' +
      ')'
    Caption = 'Exact match'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 2
  end
end
