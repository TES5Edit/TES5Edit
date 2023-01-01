object FrameJsonConverter: TFrameJsonConverter
  Left = 0
  Top = 0
  Width = 473
  Height = 308
  TabOrder = 0
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 473
    Height = 33
    Align = alTop
    AutoSize = False
    Caption = 
      'Convert files to JSON format and back. Can be used for viewing, ' +
      'comparing in text diff tools or manual tweaking in text editors ' +
      'or other software.'
    TabOrder = 0
  end
  object rbToJson: TRadioButton
    Left = 16
    Top = 48
    Width = 193
    Height = 17
    Caption = 'Convert NIF/KF to JSON'
    Checked = True
    TabOrder = 1
    TabStop = True
    WordWrap = True
    OnClick = rbToJsonClick
  end
  object rbFromJson: TRadioButton
    Left = 16
    Top = 80
    Width = 193
    Height = 19
    Caption = 'Convert JSON to NIF/KF'
    TabOrder = 2
    WordWrap = True
    OnClick = rbToJsonClick
  end
  object edExtension: TLabeledEdit
    Left = 40
    Top = 105
    Width = 33
    Height = 21
    EditLabel.Width = 221
    EditLabel.Height = 13
    EditLabel.Caption = 'default extension for converted files if missing'
    LabelPosition = lpRight
    LabelSpacing = 4
    TabOrder = 3
    Text = 'nif'
  end
end
