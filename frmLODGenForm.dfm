object frmLODGen: TfrmLODGen
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'LODGen Options'
  ClientHeight = 410
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
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 327
    Width = 769
    Height = 39
    AutoSize = False
    Caption = 
      'Only worldspaces that have existing lodsettings file "LODSetting' +
      's\<Worldspace>.lod" are shown either in the Data folder, or in B' +
      'SA archives. Archives are loaded similar to the game itself - th' +
      'e ones specified in Skyrim.ini and those that match loaded plugi' +
      'ns names.'
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
      'ses, castles and the like. Requires lowpoly LOD mesh resources t' +
      'o be present in the Data folder.'
    WordWrap = True
  end
  object Label4: TLabel
    Left = 376
    Top = 198
    Width = 401
    Height = 50
    AutoSize = False
    Caption = 
      'Create distant LOD for trees. Requires 2D billboard images to be' +
      ' present in the Data folder or in BSA archives. Those are not in' +
      'cluded with the game and must be installed separately.'
    WordWrap = True
  end
  object clbWorldspace: TCheckListBox
    Left = 8
    Top = 24
    Width = 329
    Height = 297
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 1
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 369
    Width = 791
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    ExplicitLeft = -135
    ExplicitTop = 407
    ExplicitWidth = 935
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
      ExplicitLeft = 737
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
      ExplicitLeft = 834
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
      ExplicitWidth = 927
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
    Top = 176
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
  end
  object cbNoTangents: TCheckBox
    Left = 376
    Top = 87
    Width = 145
    Height = 17
    Hint = 
      'Reduces size of generated LOD and frees memory for the game at t' +
      'he expense of LOD quality'
    Caption = 'No tangents'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object cbNoVertexColors: TCheckBox
    Left = 376
    Top = 110
    Width = 145
    Height = 17
    Hint = 
      'Reduces size of generated LOD and frees memory for the game at t' +
      'he expense of LOD quality'
    Caption = 'No vertex colors'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
  object btnSplitTreesLOD: TButton
    Left = 672
    Top = 255
    Width = 105
    Height = 25
    Caption = 'Split LOD Atlas'
    TabOrder = 6
    Visible = False
    OnClick = btnSplitTreesLODClick
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
