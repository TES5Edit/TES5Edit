object FrameConvertRootNode: TFrameConvertRootNode
  Left = 0
  Top = 0
  Width = 435
  Height = 293
  TabOrder = 0
  object Label1: TLabel
    Left = 24
    Top = 37
    Width = 24
    Height = 13
    Caption = 'From'
  end
  object Label2: TLabel
    Left = 24
    Top = 93
    Width = 12
    Height = 13
    Caption = 'To'
  end
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 435
    Height = 25
    Align = alTop
    AutoSize = False
    Caption = 'Convert root node from one type into another'
    TabOrder = 0
  end
  object cmbNodeFrom: TComboBox
    Left = 24
    Top = 56
    Width = 161
    Height = 21
    Style = csDropDownList
    TabOrder = 1
  end
  object cmbNodeTo: TComboBox
    Left = 24
    Top = 112
    Width = 161
    Height = 21
    Style = csDropDownList
    TabOrder = 2
  end
end
