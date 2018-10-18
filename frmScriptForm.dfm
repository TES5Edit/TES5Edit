object frmScript: TfrmScript
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Apply Script'
  ClientHeight = 429
  ClientWidth = 682
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
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 682
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      682
      49)
    object Label1: TLabel
      Left = 8
      Top = 10
      Width = 27
      Height = 13
      Caption = 'Script'
    end
    object cmbScripts: TComboBox
      Left = 41
      Top = 6
      Width = 553
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      DropDownCount = 30
      TabOrder = 0
      OnChange = cmbScriptsChange
    end
    object btnSave: TButton
      Left = 600
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save'
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object chkScriptsSubDir: TCheckBox
      Left = 41
      Top = 30
      Width = 192
      Height = 17
      Caption = 'Include scripts from subdirectories'
      TabOrder = 2
      OnClick = chkScriptsSubDirClick
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 394
    Width = 682
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      682
      35)
    object btnCancel: TButton
      Left = 600
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object btnOK: TButton
      Left = 519
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 1
    end
  end
  object pnlStatus: TPanel
    Left = 0
    Top = 373
    Width = 682
    Height = 21
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 2
    object lblPosition: TLabel
      Left = 8
      Top = 4
      Width = 633
      Height = 13
      AutoSize = False
    end
  end
  object Editor: TMemo
    Left = 0
    Top = 49
    Width = 682
    Height = 324
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 3
    WantTabs = True
    WordWrap = False
    OnKeyUp = EditorKeyUp
    OnMouseUp = EditorMouseUp
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'pas'
    Filter = 'Pascal files (*.pas)|*.pas'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    OptionsEx = [ofExNoPlacesBar]
    Title = 'Save script'
    Left = 600
    Top = 48
  end
end
