object frmLODGen: TfrmLODGen
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'LODGen Options'
  ClientHeight = 487
  ClientWidth = 834
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 401
    Width = 816
    Height = 39
    AutoSize = False
    Caption = 
      'Only worldspaces that have existing lodsettings file "LODSetting' +
      's\<Worldspace>.lod" (.dlodsettings for Fallout3 and New Vegas) a' +
      're shown either in the Data folder, or in BSA/BA2 archives. Arch' +
      'ives are loaded similar to the game itself - the ones specified ' +
      'in the game ini file and those that match loaded plugins names.'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 232
    Height = 13
    Caption = 'Select worldspace(s) to generate LOD for'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 376
    Top = 46
    Width = 448
    Height = 24
    AutoSize = False
    Caption = 
      'Create distant LOD for static objects like mountains, rocks, hou' +
      'ses, castles and the like.'
    WordWrap = True
  end
  object Label4: TLabel
    Left = 376
    Top = 304
    Width = 448
    Height = 33
    AutoSize = False
    Caption = 
      'Create distant LOD for trees. Requires 2D billboard images to be' +
      ' present in the Data folder or in BSA archives. Those are not in' +
      'cluded with the game and must be installed separately.'
    WordWrap = True
  end
  object Label8: TLabel
    Left = 376
    Top = 356
    Width = 73
    Height = 13
    Caption = 'LOD brightness'
  end
  object clbWorldspace: TCheckListBox
    Left = 8
    Top = 24
    Width = 329
    Height = 371
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 1
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 446
    Width = 834
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      834
      41)
    object btnOk: TButton
      Left = 636
      Top = 10
      Width = 91
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Generate'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 733
      Top = 10
      Width = 91
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object pnlBevel: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 0
      Width = 826
      Height = 1
      Margins.Left = 4
      Margins.Top = 0
      Margins.Right = 4
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 2
    end
  end
  object cbObjectsLOD: TCheckBox
    Left = 360
    Top = 24
    Width = 97
    Height = 17
    Caption = 'Objects LOD'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 2
    OnClick = cbObjectsLODClick
  end
  object cbTreesLOD: TCheckBox
    Left = 360
    Top = 282
    Width = 97
    Height = 17
    Caption = 'Trees LOD'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 3
    OnClick = cbObjectsLODClick
  end
  object btnSplitTreesLOD: TButton
    Left = 721
    Top = 350
    Width = 105
    Height = 25
    Caption = 'Split LOD Atlas'
    TabOrder = 5
    Visible = False
    OnClick = btnSplitTreesLODClick
  end
  object gbObjectsOptions: TGroupBox
    Left = 378
    Top = 76
    Width = 448
    Height = 189
    TabOrder = 6
    object Label5: TLabel
      Left = 40
      Top = 33
      Width = 45
      Height = 13
      Caption = 'Atlas size'
    end
    object Label6: TLabel
      Left = 40
      Top = 56
      Width = 80
      Height = 13
      Caption = 'Max texture size'
    end
    object Label7: TLabel
      Left = 192
      Top = 55
      Width = 55
      Height = 13
      Caption = 'in UV range'
    end
    object Label9: TLabel
      Left = 147
      Top = 33
      Width = 6
      Height = 13
      Caption = 'x'
    end
    object Label10: TLabel
      Left = 186
      Top = 160
      Width = 10
      Height = 13
      Caption = 'W'
    end
    object Label11: TLabel
      Left = 244
      Top = 160
      Width = 6
      Height = 13
      Caption = 'S'
    end
    object Label12: TLabel
      Left = 40
      Top = 83
      Width = 102
      Height = 13
      Caption = 'Compression: Diffuse'
    end
    object Label13: TLabel
      Left = 216
      Top = 83
      Width = 33
      Height = 13
      Caption = 'Normal'
    end
    object Label14: TLabel
      Left = 323
      Top = 82
      Width = 23
      Height = 13
      Caption = 'Spec'
    end
    object Label15: TLabel
      Left = 224
      Top = 33
      Width = 113
      Height = 13
      Caption = 'Default Alpha threshold'
    end
    object lblLODX2: TLabel
      Left = 304
      Top = 160
      Width = 6
      Height = 13
      Caption = 'E'
      Visible = False
    end
    object lblLODY2: TLabel
      Left = 363
      Top = 160
      Width = 7
      Height = 13
      Caption = 'N'
      Visible = False
    end
    object cbBuildAtlas: TCheckBox
      Left = 16
      Top = 13
      Width = 81
      Height = 17
      Hint = 'Put LOD textures on texture atlas(es) for better performance'
      Caption = 'Build atlas'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 0
      OnClick = cbBuildAtlasClick
    end
    object cbNoTangents: TCheckBox
      Left = 16
      Top = 133
      Width = 113
      Height = 17
      Hint = 
        'Reduces size of generated LOD and frees memory for the game at t' +
        'he expense of LOD quality'
      Caption = 'No tangents'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
    end
    object cbNoVertexColors: TCheckBox
      Left = 16
      Top = 115
      Width = 113
      Height = 17
      Hint = 
        'Reduces size of generated LOD and frees memory for the game at t' +
        'he expense of LOD quality'
      Caption = 'No vertex colors'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
    end
    object cbUseAlphaThreshold: TCheckBox
      Left = 128
      Top = 115
      Width = 169
      Height = 17
      Hint = 
        'Set transparency threshold to value from source LOD model/materi' +
        'al instead of default alpha threshold - can improve static tree ' +
        'LOD'
      Caption = 'Use source alpha threshold'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      Visible = False
    end
    object cbUseBacklightPower: TCheckBox
      Left = 128
      Top = 133
      Width = 169
      Height = 17
      Hint = 
        'Set backlight power to value from source LOD model/material inst' +
        'ead of default 0 - improves static tree LOD that uses doubleside' +
        'd flag, requires custom models/materials setting backlight power'
      Caption = 'Use backlight power'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      Visible = False
    end
    object cmbDefaultAlphaThreshold: TComboBox
      Left = 343
      Top = 28
      Width = 46
      Height = 21
      Hint = 
        'Default alpha threshold to use for transparancy - lower = "thick' +
        'er", higher = "thinner"'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object cmbLODLevel: TComboBox
      Left = 129
      Top = 156
      Width = 46
      Height = 21
      Hint = 'Dimension - number of cells'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
    end
    object cbChunk: TCheckBox
      Left = 16
      Top = 160
      Width = 107
      Height = 17
      Hint = 'Create LOD for specific chunk only'
      Caption = 'Specific chunk'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 13
      OnClick = cbChunkClick
    end
    object edLODX: TEdit
      Left = 198
      Top = 156
      Width = 40
      Height = 21
      Hint = 'Lower left cell X'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
    end
    object edLODY: TEdit
      Left = 256
      Top = 156
      Width = 40
      Height = 21
      Hint = 'Lower left cell Y'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 15
    end
    object cmbAtlasWidth: TComboBox
      Left = 91
      Top = 29
      Width = 50
      Height = 21
      Hint = 'Atlas width in pixels'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object cmbAtlasHeight: TComboBox
      Left = 159
      Top = 28
      Width = 50
      Height = 21
      Hint = 'Atlas height in pixels'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cmbAtlasTextureSize: TComboBox
      Left = 126
      Top = 52
      Width = 50
      Height = 21
      Hint = 
        'Max LOD texture size to put on atlas, larger textures are ignore' +
        'd'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object cmbAtlasTextureUVRange: TComboBox
      Left = 253
      Top = 52
      Width = 44
      Height = 21
      Hint = 
        'Put only those textures that have -UVRange <= uv <= UVRange in L' +
        'OD models'
      Style = csDropDownList
      DropDownCount = 16
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
    object cmbCompDiffuse: TComboBox
      Left = 148
      Top = 79
      Width = 61
      Height = 21
      Hint = 'Compression of diffuse atlas texture'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnChange = cmbCompDiffuseChange
    end
    object cmbCompNormal: TComboBox
      Left = 252
      Top = 79
      Width = 61
      Height = 21
      Hint = 'Compression of normal atlas texture'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
    end
    object cmbCompSpecular: TComboBox
      Left = 352
      Top = 79
      Width = 61
      Height = 21
      Hint = 'Compression of specular atlas texture'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
    end
    object edLODX2: TEdit
      Left = 316
      Top = 156
      Width = 40
      Height = 21
      Hint = 'Upper right cell X, calculated using selected dimension if empty'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 17
      Visible = False
    end
    object edLODY2: TEdit
      Left = 376
      Top = 156
      Width = 40
      Height = 21
      Hint = 'Upper right cell Y, calculated using selected dimension if empty'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 18
      Visible = False
    end
  end
  object cmbTreesLODBrightness: TComboBox
    Left = 455
    Top = 352
    Width = 43
    Height = 21
    Hint = 
      'Some ENB presets might require different brightness of distant t' +
      'rees for better look, usually negative darker brightness.'
    Style = csDropDownList
    DropDownCount = 16
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object cbTrees3D: TCheckBox
    Left = 469
    Top = 282
    Width = 169
    Height = 17
    Hint = 
      'Insert trees into Objects LOD by using provided LOD nifs or plac' +
      'ing billboard image on a flat mesh. This allows distant trees to' +
      ' be affected by lighting at the small performance cost.'
    Caption = 'Generate as Objects LOD'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 7
  end
  object PopupMenu1: TPopupMenu
    Left = 168
    Top = 104
    object SelectAll1: TMenuItem
      Caption = 'Select All'
      OnClick = SelectAll1Click
    end
    object SelectNone1: TMenuItem
      Caption = 'Select None'
      OnClick = SelectNone1Click
    end
  end
end
