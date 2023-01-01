object FrameUnweldedVertices: TFrameUnweldedVertices
  Left = 0
  Top = 0
  Width = 491
  Height = 313
  TabOrder = 0
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 491
    Height = 33
    Align = alTop
    AutoSize = False
    Caption = 
      'Find meshes with unwelded vertices (vertices within a small dist' +
      'ance to each other). '
    TabOrder = 0
  end
  object edDistance: TLabeledEdit
    Left = 16
    Top = 64
    Width = 129
    Height = 21
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'Distance'
    TabOrder = 1
    Text = '0.1000'
  end
  object chkSkipSame: TCheckBox
    Left = 16
    Top = 99
    Width = 393
    Height = 17
    Caption = 'Skip vertices with the same coordinates (zero distance)'
    TabOrder = 2
  end
  object chkReportVertices: TCheckBox
    Left = 16
    Top = 122
    Width = 265
    Height = 17
    Caption = 'Report found vertices coordinates'
    TabOrder = 3
  end
end
