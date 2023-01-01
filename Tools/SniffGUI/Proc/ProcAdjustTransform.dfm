object FrameAdjustTransform: TFrameAdjustTransform
  Left = 0
  Top = 0
  Width = 471
  Height = 264
  TabOrder = 0
  object Label1: TLabel
    Left = 16
    Top = 133
    Width = 53
    Height = 13
    Caption = 'Translation'
  end
  object Label2: TLabel
    Left = 16
    Top = 160
    Width = 41
    Height = 13
    Caption = 'Rotation'
  end
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 471
    Height = 41
    Align = alTop
    AutoSize = False
    Caption = 
      'Adjust transformation of the root node or nodes by name ("Name" ' +
      'field matches or contains provided word(s), case insensitive). L' +
      'eave values you don'#39't need to update empty.'
    TabOrder = 0
  end
  object edNames: TLabeledEdit
    Left = 16
    Top = 64
    Width = 337
    Height = 21
    EditLabel.Width = 378
    EditLabel.Height = 13
    EditLabel.Caption = 
      'Names, separated by comma if several. Leave empty to update the ' +
      'root node.'
    TabOrder = 1
  end
  object chkExactMatch: TCheckBox
    Left = 359
    Top = 66
    Width = 89
    Height = 17
    Hint = 
      'Should block names match names exactly or partially (contain the' +
      'm)'
    Caption = 'Exact match'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 2
  end
  object edPosX: TLabeledEdit
    Left = 112
    Top = 130
    Width = 41
    Height = 21
    EditLabel.Width = 10
    EditLabel.Height = 13
    EditLabel.Caption = 'X:'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 3
  end
  object edPosY: TLabeledEdit
    Left = 200
    Top = 130
    Width = 41
    Height = 21
    EditLabel.Width = 10
    EditLabel.Height = 13
    EditLabel.Caption = 'Y:'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 4
  end
  object edPosZ: TLabeledEdit
    Left = 288
    Top = 130
    Width = 41
    Height = 21
    EditLabel.Width = 10
    EditLabel.Height = 13
    EditLabel.Caption = 'Z:'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 5
  end
  object edRotY: TLabeledEdit
    Left = 112
    Top = 157
    Width = 41
    Height = 21
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = 'Yaw:'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 6
  end
  object edRotP: TLabeledEdit
    Left = 200
    Top = 157
    Width = 41
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Pitch:'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 7
  end
  object edRotR: TLabeledEdit
    Left = 288
    Top = 157
    Width = 41
    Height = 21
    EditLabel.Width = 21
    EditLabel.Height = 13
    EditLabel.Caption = 'Roll:'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 8
  end
  object edScale: TLabeledEdit
    Left = 385
    Top = 140
    Width = 41
    Height = 21
    EditLabel.Width = 29
    EditLabel.Height = 13
    EditLabel.Caption = 'Scale:'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 9
  end
  object rbAdd: TRadioButton
    Left = 16
    Top = 99
    Width = 53
    Height = 17
    Hint = 'Add values to originals'
    Caption = 'Add'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    TabStop = True
  end
  object rbMult: TRadioButton
    Left = 88
    Top = 99
    Width = 65
    Height = 17
    Hint = 'Multiply originals by values'
    Caption = 'Multiply'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
  end
  object rbSet: TRadioButton
    Left = 168
    Top = 99
    Width = 53
    Height = 17
    Hint = 'Replace originals with values'
    Caption = 'Set'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
  end
end
