object FrameMergeShapes: TFrameMergeShapes
  Left = 0
  Top = 0
  Width = 433
  Height = 245
  TabOrder = 0
  object Label1: TLabel
    Left = 16
    Top = 59
    Width = 90
    Height = 13
    AutoSize = False
    Caption = 'NiNode Index'
  end
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 433
    Height = 49
    Align = alTop
    AutoSize = False
    Caption = 
      'Merge BSTriShape, NiTriShape and NiTriStrips blocks under the sp' +
      'ecified NiNode. Shapes must have transforms and scale applied fo' +
      'r consistent result. All children shapes will be merged into the' +
      ' first one and removed if not used anymore.'
    TabOrder = 0
  end
  object edNiNodeIndex: TEdit
    Left = 112
    Top = 55
    Width = 49
    Height = 21
    TabOrder = 1
    Text = '0'
  end
end
