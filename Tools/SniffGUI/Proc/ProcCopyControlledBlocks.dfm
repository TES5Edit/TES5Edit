object FrameCopyControlledBlocks: TFrameCopyControlledBlocks
  Left = 0
  Top = 0
  Width = 483
  Height = 302
  TabOrder = 0
  DesignSize = (
    483
    302)
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 483
    Height = 57
    Align = alTop
    AutoSize = False
    Caption = 
      'Copy missing Controlled Blocks in NiControllerSequence. Block'#39's ' +
      'uniqueness is defined by "Node Name" and "Controller Type" field' +
      's. For each file in the Input directory the missing blocks will ' +
      'be copied from the file with the same path and name in the provi' +
      'ded Source directory if exists.'
    TabOrder = 0
  end
  object edSourceDirectory: TLabeledEdit
    Left = 16
    Top = 88
    Width = 401
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 220
    EditLabel.Height = 13
    EditLabel.Caption = 'Source directory with files to copy blocks from'
    TabOrder = 1
  end
  object btnBrowse: TButton
    Left = 423
    Top = 86
    Width = 45
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 2
    OnClick = btnBrowseClick
  end
end
