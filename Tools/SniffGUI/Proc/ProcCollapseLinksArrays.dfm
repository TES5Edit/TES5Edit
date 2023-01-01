object FrameCollapseLinksArrays: TFrameCollapseLinksArrays
  Left = 0
  Top = 0
  Width = 479
  Height = 207
  TabOrder = 0
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 479
    Height = 41
    Align = alTop
    AutoSize = False
    Caption = 
      'Remove empty entries from link arrays. Also detect invalid links' +
      ', and duplicate links in the same array, however they are not fi' +
      'xed. Such issues require manual correction.'
    TabOrder = 0
  end
  object chkReport: TCheckBox
    Left = 16
    Top = 47
    Width = 257
    Height = 17
    Caption = 'Report only, don'#39't save anything'
    TabOrder = 1
  end
end
