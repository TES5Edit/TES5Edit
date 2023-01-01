object FrameRenameControlledBlocks: TFrameRenameControlledBlocks
  Left = 0
  Top = 0
  Width = 459
  Height = 256
  TabOrder = 0
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 459
    Height = 33
    Align = alTop
    AutoSize = False
    Caption = 
      'Change "Node Name" field in controlled blocks of NiControllerSeq' +
      'uence. Searching is case insensitive.'
    TabOrder = 0
  end
  object edOldName: TLabeledEdit
    Left = 16
    Top = 64
    Width = 225
    Height = 21
    EditLabel.Width = 45
    EditLabel.Height = 13
    EditLabel.Caption = 'Old name'
    TabOrder = 1
  end
  object edNewName: TLabeledEdit
    Left = 16
    Top = 112
    Width = 225
    Height = 21
    EditLabel.Width = 50
    EditLabel.Height = 13
    EditLabel.Caption = 'New name'
    TabOrder = 2
  end
end
