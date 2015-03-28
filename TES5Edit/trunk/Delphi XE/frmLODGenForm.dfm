object frmLODGen: TfrmLODGen
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'LODGen Options'
  ClientHeight = 437
  ClientWidth = 791
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 351
    Width = 769
    Height = 39
    AutoSize = False
    Caption = 
      'Only worldspaces that have existing lodsettings file "LODSetting' +
      's\<Worldspace>.lod" (.dlodsettings for Fallout3 and New Vegas) a' +
      're shown either in the Data folder, or in BSA archives. Archives' +
      ' are loaded similar to the game itself - the ones specified in S' +
      'kyrim.ini and those that match loaded plugins names.'
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
    Width = 401
    Height = 33
    AutoSize = False
    Caption = 
      'Create distant LOD for static objects like mountains, rocks, hou' +
      'ses, castles and the like.'
    WordWrap = True
  end
  object Label4: TLabel
    Left = 376
    Top = 232
    Width = 401
    Height = 50
    AutoSize = False
    Caption = 
      'Create distant LOD for trees. Requires 2D billboard images to be' +
      ' present in the Data folder or in BSA archives. Those are not in' +
      'cluded with the game and must be installed separately.'
    WordWrap = True
  end
  object Label8: TLabel
    Left = 376
    Top = 292
    Width = 73
    Height = 13
    Caption = 'LOD brightness'
  end
  object clbWorldspace: TCheckListBox
    Left = 8
    Top = 24
    Width = 329
    Height = 321
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 1
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 396
    Width = 791
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      791
      41)
    object btnOk: TButton
      Left = 593
      Top = 10
      Width = 91
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Generate'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 690
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
      Width = 783
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
    Top = 210
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
    Left = 672
    Top = 288
    Width = 105
    Height = 25
    Caption = 'Split LOD Atlas'
    TabOrder = 4
    Visible = False
    OnClick = btnSplitTreesLODClick
  end
  object gbObjectsOptions: TGroupBox
    Left = 376
    Top = 80
    Width = 401
    Height = 119
    TabOrder = 5
    object Label5: TLabel
      Left = 32
      Top = 28
      Width = 45
      Height = 13
      Caption = 'Atlas size'
    end
    object Label6: TLabel
      Left = 32
      Top = 52
      Width = 80
      Height = 13
      Caption = 'Max texture size'
    end
    object Label7: TLabel
      Left = 192
      Top = 52
      Width = 55
      Height = 13
      Caption = 'in UV range'
    end
    object Label9: TLabel
      Left = 145
      Top = 28
      Width = 6
      Height = 13
      Caption = 'x'
    end
    object cbBuildAtlas: TCheckBox
      Left = 16
      Top = 5
      Width = 81
      Height = 17
      Hint = 'Put LOD textures on texture atlas(es) for better performance'
      Caption = 'Build atlas'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 0
    end
    object cbNoTangents: TCheckBox
      Left = 16
      Top = 93
      Width = 145
      Height = 17
      Hint = 
        'Reduces size of generated LOD and frees memory for the game at t' +
        'he expense of LOD quality'
      Caption = 'No tangents'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object cbNoVertexColors: TCheckBox
      Left = 16
      Top = 75
      Width = 145
      Height = 17
      Hint = 
        'Reduces size of generated LOD and frees memory for the game at t' +
        'he expense of LOD quality'
      Caption = 'No vertex colors'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cmbAtlasWidth: TComboBox
      Left = 91
      Top = 24
      Width = 50
      Height = 21
      Hint = 'Atlas width in pixels'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object cmbAtlasHeight: TComboBox
      Left = 154
      Top = 24
      Width = 50
      Height = 21
      Hint = 'Atlas width in pixels'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object cmbAtlasTextureSize: TComboBox
      Left = 126
      Top = 48
      Width = 50
      Height = 21
      Hint = 
        'Max LOD texture size to put on atlas, larger textures are ignore' +
        'd'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
    object cmbAtlasTextureUVRange: TComboBox
      Left = 253
      Top = 48
      Width = 44
      Height = 21
      Hint = 
        'Put only those textures that have -UVRange <= uv <= UVRange in L' +
        'OD models'
      Style = csDropDownList
      DropDownCount = 16
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
  end
  object cmbTreesLODBrightness: TComboBox
    Left = 455
    Top = 288
    Width = 43
    Height = 21
    Hint = 
      'Some ENB presets might require different brightness of distant t' +
      'rees for better look, usually negative darker brightness.'
    Style = csDropDownList
    DropDownCount = 16
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
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
