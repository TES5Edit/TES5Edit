object FrameTangents: TFrameTangents
  Left = 0
  Top = 0
  Width = 546
  Height = 201
  TabOrder = 0
  DesignSize = (
    546
    201)
  object chkNormals: TCheckBox
    Left = 16
    Top = 104
    Width = 97
    Height = 17
    Caption = 'Face normals'
    TabOrder = 0
  end
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 546
    Height = 33
    Align = alTop
    AutoSize = False
    Caption = 
      'Recalculate tangents and binormals in BSTriShape, NiTriShapeData' +
      ' and NiTriStripsData'
    TabOrder = 1
  end
  object StaticText2: TStaticText
    Left = 40
    Top = 125
    Width = 489
    Height = 36
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      'Recalculate normals before doing tangents. Check only if existin' +
      'g normals are broken or missing since they are used for tangents' +
      ' calculation.'
    TabOrder = 2
  end
  object chkAddIfMissing: TCheckBox
    Left = 16
    Top = 39
    Width = 97
    Height = 17
    Caption = 'Add if missing'
    TabOrder = 3
  end
  object StaticText3: TStaticText
    Left = 40
    Top = 60
    Width = 489
    Height = 36
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      'Add tangents if they are missing. Use with caution because some ' +
      'nodes don'#39't need tangents.'
    TabOrder = 4
  end
end
