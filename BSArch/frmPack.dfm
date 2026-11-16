object FormPack: TFormPack
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Packing Options'
  ClientHeight = 480
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    634
    480)
  TextHeight = 13
  object lblTip: TLabel
    Left = 296
    Top = 220
    Width = 316
    Height = 13
    AutoSize = False
    Caption = 'lblTip'
    WordWrap = True
  end
  object Label3: TLabel
    Left = 16
    Top = 383
    Width = 100
    Height = 13
    Caption = 'Archive File Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblPack: TLabel
    Left = 16
    Top = 8
    Width = 32
    Height = 13
    Caption = 'lblPack'
  end
  object Label1: TLabel
    Left = 16
    Top = 254
    Width = 50
    Height = 13
    Caption = 'Split size'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 29
    Top = 278
    Width = 583
    Height = 64
    AutoSize = False
    Caption = 
      'Auto - 2 GB BSA for Morrowind, Oblivion, Fallout 3, Fallout NV a' +
      'nd Skyrim. No splitting on BA2 for Fallout 4 and Starfield.'#13#10'Non' +
      'e - pack all files into single archive'#13#10'Don'#39't use sizes larger t' +
      'han available free memory. Max BSA size pre Fallout 4 is 2 GB, l' +
      'arger ones won'#39't work properly or crash the game.'
    WordWrap = True
  end
  object Label4: TLabel
    Left = 427
    Top = 349
    Width = 104
    Height = 13
    Caption = 'Compression Type'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTarget: TLabel
    Left = 494
    Top = 254
    Width = 38
    Height = 13
    Caption = 'Target'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlArchiveType: TFlowPanel
    Left = 16
    Top = 27
    Width = 249
    Height = 206
    Alignment = taLeftJustify
    AutoWrap = False
    BevelOuter = bvNone
    FlowStyle = fsTopBottomLeftRight
    ParentColor = True
    ShowCaption = False
    TabOrder = 0
    VerticalAlignment = taAlignTop
  end
  object pnlArchiveFlags: TFlowPanel
    Left = 296
    Top = 31
    Width = 185
    Height = 162
    Alignment = taLeftJustify
    AutoWrap = False
    BevelOuter = bvNone
    FlowStyle = fsTopBottomLeftRight
    ParentColor = True
    ShowCaption = False
    TabOrder = 1
    VerticalAlignment = taAlignTop
  end
  object pnlFileFlags: TFlowPanel
    Left = 496
    Top = 27
    Width = 116
    Height = 166
    Alignment = taLeftJustify
    AutoWrap = False
    BevelOuter = bvNone
    FlowStyle = fsTopBottomLeftRight
    ParentColor = True
    ShowCaption = False
    TabOrder = 2
    VerticalAlignment = taAlignTop
  end
  object chkAutodetectFlags: TCheckBox
    Left = 296
    Top = 8
    Width = 185
    Height = 17
    Caption = 'Autodetect Flags'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = chkAutodetectFlagsClick
  end
  object chkMultiThreaded: TCheckBox
    Left = 16
    Top = 348
    Width = 161
    Height = 17
    Hint = 
      'Use available CPU cores to greatly increase packing speed at the' +
      ' expense of higher CPU and disk system load. Archive created fro' +
      'm the same files will have a different checksum each time due to' +
      ' the random order of packed files.'
    Caption = 'Multithreaded Packing'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object chkSharedData: TCheckBox
    Left = 200
    Top = 348
    Width = 121
    Height = 17
    Hint = 
      'Content of identical files will be shared inside archive to redu' +
      'ce occupied space. A typical example is silent voice files when ' +
      'the same file is copied under different names and folders.'
    Caption = 'Shared Data'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
  object edFileName: TEdit
    Left = 16
    Top = 402
    Width = 556
    Height = 21
    ReadOnly = True
    TabOrder = 6
  end
  object btnBrowse: TButton
    Left = 578
    Top = 400
    Width = 34
    Height = 25
    Caption = '...'
    TabOrder = 7
    OnClick = btnBrowseClick
  end
  object btnPack: TButton
    Left = 426
    Top = 441
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 8
  end
  object Button1: TButton
    Left = 522
    Top = 441
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 9
  end
  object cmbSplit: TComboBox
    Left = 80
    Top = 251
    Width = 100
    Height = 21
    Style = csDropDownList
    TabOrder = 10
  end
  object cmbCompression: TComboBox
    Left = 547
    Top = 346
    Width = 65
    Height = 21
    Style = csDropDownList
    TabOrder = 11
  end
  object cmbTarget: TComboBox
    Left = 550
    Top = 251
    Width = 62
    Height = 21
    Style = csDropDownList
    TabOrder = 12
  end
end
