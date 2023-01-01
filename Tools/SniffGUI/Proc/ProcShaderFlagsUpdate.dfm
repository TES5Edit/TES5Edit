object FrameShaderFlagsUpdate: TFrameShaderFlagsUpdate
  Left = 0
  Top = 0
  Width = 513
  Height = 323
  TabOrder = 0
  DesignSize = (
    513
    323)
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 513
    Height = 39
    Align = alTop
    AutoSize = False
    Caption = 
      'Update flags in BSLightingShaderProperty and BSShaderPPLightingP' +
      'roperty. "Add" mode checks selected flags, "Set" checks selected' +
      ' flags and clears others, "Remove" unchecks selected flags.'
    TabOrder = 0
  end
  object clbFlags1: TCheckListBox
    Left = 16
    Top = 72
    Width = 234
    Height = 248
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 1
  end
  object cmbGame: TComboBox
    Left = 16
    Top = 45
    Width = 234
    Height = 21
    Style = csDropDownList
    TabOrder = 2
    OnSelect = cmbGameSelect
    Items.Strings = (
      'Fallout 3 and New Vegas'
      'Skyrim LE and SE'
      'Fallout 4')
  end
  object clbFlags2: TCheckListBox
    Left = 263
    Top = 72
    Width = 234
    Height = 248
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 3
  end
  object rbAdd: TRadioButton
    Left = 263
    Top = 49
    Width = 58
    Height = 17
    Caption = 'Add'
    TabOrder = 4
  end
  object rbSet: TRadioButton
    Tag = 1
    Left = 343
    Top = 49
    Width = 58
    Height = 17
    Caption = 'Set'
    TabOrder = 5
  end
  object rbRemove: TRadioButton
    Tag = 2
    Left = 423
    Top = 49
    Width = 74
    Height = 17
    Caption = 'Remove'
    TabOrder = 6
  end
end
