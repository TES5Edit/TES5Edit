object FrameChangePartitionSlot: TFrameChangePartitionSlot
  Left = 0
  Top = 0
  Width = 525
  Height = 317
  TabOrder = 0
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 525
    Height = 25
    Align = alTop
    AutoSize = False
    Caption = 'Change partition body slot in BSDismemberSkinInstance.'
    TabOrder = 0
  end
  object edSlotOld: TLabeledEdit
    Left = 64
    Top = 40
    Width = 49
    Height = 21
    EditLabel.Width = 36
    EditLabel.Height = 13
    EditLabel.Caption = 'Old slot'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object edSlotNew: TLabeledEdit
    Left = 184
    Top = 40
    Width = 49
    Height = 21
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'New slot'
    LabelPosition = lpLeft
    TabOrder = 2
  end
end
