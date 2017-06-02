object frmScript: TfrmScript
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Apply Script'
  ClientHeight = 679
  ClientWidth = 981
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
  object pnlBottom: TPanel
    Left = 0
    Top = 644
    Width = 981
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      981
      35)
    object btnCancel: TButton
      Left = 899
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object btnOK: TButton
      Left = 818
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&OK'
      ModalResult = 1
      TabOrder = 1
    end
    object btnExecute: TButton
      Left = 737
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Execute'
      Enabled = False
      TabOrder = 2
      OnClick = btnExecuteClick
    end
  end
  object pnlStatus: TPanel
    Left = 0
    Top = 623
    Width = 981
    Height = 21
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    object lblPosition: TLabel
      Left = 8
      Top = 4
      Width = 633
      Height = 13
      AutoSize = False
    end
  end
  object pgScriptTabs: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 975
    Height = 617
    ActivePage = tabFileLoader
    Align = alClient
    TabOrder = 2
    OnChange = pgScriptTabsChange
    object tabFileLoader: TTabSheet
      Caption = 'Script File'
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 967
        Height = 49
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          967
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
          Width = 845
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          DropDownCount = 30
          TabOrder = 0
          OnChange = cmbScriptsChange
        end
        object btnSave: TButton
          Left = 892
          Top = 4
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = '&Save'
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
      object Editor: TJvHLEditor
        Left = 0
        Top = 49
        Width = 967
        Height = 540
        Cursor = crIBeam
        GutterWidth = 32
        Completion.ItemHeight = 13
        Completion.CRLF = '/n'
        Completion.Separator = '='
        TabStops = '2 2'
        KeepTrailingBlanks = True
        CursorBeyondEOL = False
        BracketHighlighting.Active = True
        BracketHighlighting.StringEscape = #39#39
        OnKeyUp = EditorKeyUp
        OnMouseUp = EditorMouseUp
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        Font.Quality = fqClearType
        Colors.Comment.Style = [fsItalic]
        Colors.Comment.ForeColor = clNavy
        Colors.Comment.BackColor = clWindow
        Colors.Number.ForeColor = clNavy
        Colors.Number.BackColor = clWindow
        Colors.Strings.ForeColor = clBlue
        Colors.Strings.BackColor = clWindow
        Colors.Symbol.ForeColor = clBlack
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
    end
    object tabInteractive: TTabSheet
      Caption = 'Interactive'
      ImageIndex = 1
      object InterpInput: TJvHLEditor
        Left = 0
        Top = 385
        Width = 967
        Height = 204
        Cursor = crIBeam
        Lines.Strings = (
          '// Interactive fills in the "unit" and last "end" for you.'
          'function Process(e: IInterface): integer;'
          'begin'
          '  Result := 0;'
          ''
          '  // Interactive comes with a '#39'Print'#39' procedure.'
          '  // Signature is: Print(...)'
          '  // Each arg will be converted to a string.'
          '  Print('#39'Processing:'#39', FullPath(e));'
          'end;'
          ''
          '// You can also specify an Initialize, should you so need to.'
          'function Initialize: integer;'
          'begin'
          '  Result := 0;'
          'end;'
          ''
          '// Ditto'
          'function Finalize: integer;'
          'begin'
          '  Result := 0;'
          'end;')
        ScrollBars = ssVertical
        GutterWidth = 32
        RightMarginVisible = False
        RightMarginColor = clHighlight
        Completion.ItemHeight = 13
        Completion.CRLF = '/n'
        Completion.Separator = '='
        TabStops = '2 2'
        KeepTrailingBlanks = True
        CursorBeyondEOL = False
        BracketHighlighting.Active = True
        BracketHighlighting.StringEscape = #39#39
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        Font.Quality = fqClearType
        Colors.Comment.Style = [fsItalic]
        Colors.Comment.ForeColor = clNavy
        Colors.Comment.BackColor = clWindow
        Colors.Number.ForeColor = clNavy
        Colors.Number.BackColor = clWindow
        Colors.Strings.ForeColor = clBlue
        Colors.Strings.BackColor = clWindow
        Colors.Symbol.ForeColor = clBlack
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
      object InterpOutput: TMemo
        Left = 0
        Top = 0
        Width = 967
        Height = 385
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
        WantReturns = False
        WordWrap = False
      end
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
