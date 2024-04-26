object FormPack: TFormPack
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Packing Options'
  ClientHeight = 580
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
    580)
  TextHeight = 13
  object lblTip: TLabel
    Left = 296
    Top = 253
    Width = 316
    Height = 13
    AutoSize = False
    Caption = 'lblTip'
    WordWrap = True
  end
  object Label1: TLabel
    Left = 32
    Top = 376
    Width = 580
    Height = 35
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      'Use available CPU cores to greatly increase packing speed at the' +
      ' expense of higher CPU and disk system load. Archive created fro' +
      'm the same files will have a different checksum each time due to' +
      ' the random order of packed files.'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 32
    Top = 440
    Width = 580
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      'Content of identical files will be shared inside archive to redu' +
      'ce occupied space. A typical example is silent voice files when ' +
      'the same file is copied under different names and folders. Reduc' +
      'es packing speed.'
    WordWrap = True
  end
  object Label3: TLabel
    Left = 16
    Top = 488
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
  object pnlArchiveType: TFlowPanel
    Left = 16
    Top = 27
    Width = 249
    Height = 310
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
    Top = 8
    Width = 116
    Height = 185
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
    Top = 354
    Width = 161
    Height = 17
    Caption = 'Multithreaded Packing'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object chkSharedData: TCheckBox
    Left = 16
    Top = 418
    Width = 161
    Height = 17
    Caption = 'Shared Data'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object edFileName: TEdit
    Left = 16
    Top = 506
    Width = 556
    Height = 21
    ReadOnly = True
    TabOrder = 6
  end
  object btnBrowse: TButton
    Left = 578
    Top = 504
    Width = 34
    Height = 25
    Caption = '...'
    TabOrder = 7
    OnClick = btnBrowseClick
  end
  object btnPack: TButton
    Left = 426
    Top = 542
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 8
  end
  object btnCancel: TButton
    Left = 522
    Top = 542
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 9
  end
end
