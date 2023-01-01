object FrameCopyGeometryBlocks: TFrameCopyGeometryBlocks
  Left = 0
  Top = 0
  Width = 483
  Height = 323
  TabOrder = 0
  DesignSize = (
    483
    323)
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 483
    Height = 57
    Align = alTop
    AutoSize = False
    Caption = 
      'Copy and paste over BSTriShape, NiTriShapeData and NiTriStripsDa' +
      'ta blocks from source meshes. Geometry nodes are matched by name' +
      '. For each file in the Input directory geometry will be copied f' +
      'rom the file with the same path and name in the provided Source ' +
      'directory if exists.'
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
