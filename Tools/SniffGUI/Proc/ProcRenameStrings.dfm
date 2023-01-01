object FrameRenameStrings: TFrameRenameStrings
  Left = 0
  Top = 0
  Width = 482
  Height = 333
  TabOrder = 0
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 482
    Height = 33
    Align = alTop
    AutoSize = False
    Caption = 
      'Search and replace in the Strings list in NiHeader. Searching is' +
      ' case insensitive, unused strings will be removed.'
    TabOrder = 0
  end
  object edSearchText: TLabeledEdit
    Left = 16
    Top = 64
    Width = 225
    Height = 21
    EditLabel.Width = 56
    EditLabel.Height = 13
    EditLabel.Caption = 'Search text'
    TabOrder = 1
  end
  object edReplaceText: TLabeledEdit
    Left = 16
    Top = 120
    Width = 225
    Height = 21
    EditLabel.Width = 61
    EditLabel.Height = 13
    EditLabel.Caption = 'Replace with'
    TabOrder = 2
  end
  object chkExactMatch: TCheckBox
    Left = 264
    Top = 66
    Width = 153
    Height = 17
    Hint = 'Match against the full string instead of partially'
    Caption = 'Full string match'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object chkTrim: TCheckBox
    Left = 264
    Top = 122
    Width = 153
    Height = 17
    Hint = 'Trim left and right whitespaces if any after replacement'
    Caption = 'Trim whitespaces'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 4
  end
end
