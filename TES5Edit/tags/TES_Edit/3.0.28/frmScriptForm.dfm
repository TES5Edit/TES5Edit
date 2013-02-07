object frmScript: TfrmScript
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Apply Script'
  ClientHeight = 439
  ClientWidth = 681
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Editor: TJvHLEditor
    Left = 0
    Top = 33
    Width = 681
    Height = 350
    Cursor = crIBeam
    BorderStyle = bsNone
    RightMarginVisible = False
    Completion.ItemHeight = 13
    Completion.CRLF = '/n'
    Completion.Separator = '='
    TabStops = '3 5'
    SmartTab = False
    BracketHighlighting.WordPairs.Strings = (
      'begin end')
    BracketHighlighting.StringEscape = #39#39
    OnCaretChanged = EditorCaretChanged
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Colors.Comment.Style = [fsItalic]
    Colors.Comment.ForeColor = clGreen
    Colors.Comment.BackColor = clWindow
    Colors.Number.ForeColor = clNavy
    Colors.Number.BackColor = clWindow
    Colors.Strings.ForeColor = clBlue
    Colors.Strings.BackColor = clWindow
    Colors.Symbol.ForeColor = clBlue
    Colors.Symbol.BackColor = clWindow
    Colors.Reserved.Style = [fsBold]
    Colors.Reserved.ForeColor = clBlack
    Colors.Reserved.BackColor = clWindow
    Colors.Identifier.ForeColor = clBlack
    Colors.Identifier.BackColor = clWindow
    Colors.Preproc.ForeColor = clGreen
    Colors.Preproc.BackColor = clWindow
    Colors.FunctionCall.ForeColor = clWindowText
    Colors.FunctionCall.BackColor = clWindow
    Colors.Declaration.ForeColor = clWindowText
    Colors.Declaration.BackColor = clWindow
    Colors.Statement.Style = [fsBold]
    Colors.Statement.ForeColor = clWindowText
    Colors.Statement.BackColor = clWindow
    Colors.PlainText.ForeColor = clWindowText
    Colors.PlainText.BackColor = clWindow
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 681
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
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
      DropDownCount = 20
      TabOrder = 0
      OnChange = cmbScriptsChange
    end
    object btnSave: TButton
      Left = 600
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 1
      OnClick = btnSaveClick
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 404
    Width = 681
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnCancel: TButton
      Left = 600
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object btnOK: TButton
      Left = 519
      Top = 6
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 1
    end
  end
  object pnlStatus: TPanel
    Left = 0
    Top = 383
    Width = 681
    Height = 21
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 3
    object lblPosition: TLabel
      Left = 8
      Top = 4
      Width = 633
      Height = 13
      AutoSize = False
    end
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'pas'
    Filter = 'Pascal files (*.pas)|*.pas'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofNoChangeDir, ofOldStyleDialog, ofEnableSizing]
    OptionsEx = [ofExNoPlacesBar]
    Title = 'Save script'
    Left = 600
    Top = 48
  end
end
