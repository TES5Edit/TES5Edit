object FrameReplaceAssets: TFrameReplaceAssets
  Left = 0
  Top = 0
  Width = 479
  Height = 271
  TabOrder = 0
  DesignSize = (
    479
    271)
  object Label1: TLabel
    Left = 16
    Top = 97
    Width = 449
    Height = 33
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      'Replacement pair(s): odd lines specify what text to replace, eve' +
      'n lines text to replace with. If odd line is empty then replacem' +
      'ent text is prepended.'
    WordWrap = True
  end
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 479
    Height = 41
    Align = alTop
    AutoSize = False
    Caption = 
      'Search and replace assets (textures, hkx files, FO4 materials an' +
      'd ssf bone scales) in NIF meshes and FO4 BGSM/BGEM material file' +
      's.'
    TabOrder = 0
  end
  object memoPairs: TMemo
    Left = 16
    Top = 136
    Width = 449
    Height = 121
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'textures\old\'
      'textures\new\')
    ScrollBars = ssVertical
    TabOrder = 1
    WordWrap = False
  end
  object chkFixAbsolute: TCheckBox
    Left = 16
    Top = 47
    Width = 449
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 
      'Fix absolute paths. Truncate up to and including "Data\" ("Data ' +
      'Files\" for Morrowind)'
    TabOrder = 2
  end
  object chkReport: TCheckBox
    Left = 16
    Top = 70
    Width = 257
    Height = 17
    Caption = 'Report only, don'#39't save anything'
    TabOrder = 3
  end
end
