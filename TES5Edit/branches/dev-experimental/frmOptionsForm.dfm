object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 379
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    466
    379)
  PixelsPerInch = 96
  TextHeight = 13
  object pcOptions: TPageControl
    Left = 0
    Top = 0
    Width = 466
    Height = 337
    ActivePage = tsGeneral
    Align = alTop
    TabOrder = 0
    object tsGeneral: TTabSheet
      Caption = 'General'
      ImageIndex = 1
      object Label5: TLabel
        Left = 16
        Top = 280
        Width = 64
        Height = 13
        Caption = 'Column width'
      end
      object cbIKnow: TCheckBox
        Left = 298
        Top = 278
        Width = 137
        Height = 17
        Caption = 'I know what I am doing'
        TabOrder = 9
        Visible = False
      end
      object cbHideUnused: TCheckBox
        Left = 16
        Top = 15
        Width = 81
        Height = 17
        Caption = 'Hide unused'
        TabOrder = 0
      end
      object cbHideIgnored: TCheckBox
        Left = 16
        Top = 38
        Width = 81
        Height = 17
        Caption = 'Hide ignored'
        TabOrder = 1
      end
      object cbHideNeverShow: TCheckBox
        Left = 16
        Top = 61
        Width = 121
        Height = 17
        Caption = 'Hide "never shown"'
        TabOrder = 2
      end
      object cbLoadBSAs: TCheckBox
        Left = 16
        Top = 108
        Width = 81
        Height = 17
        Hint = 
          'Deactivate for Skyrim only if you extracted STRINGS files, will ' +
          'reduce loading time greatly. Otherwise you'#39'll see "no localizati' +
          'on" text everywhere.'
        Caption = 'Load BSAs'
        TabOrder = 3
      end
      object cbSortFLST: TCheckBox
        Left = 16
        Top = 131
        Width = 121
        Height = 17
        Hint = 
          'Sorting FLST can cause issues for mods relying on the order of f' +
          'orms, unsorted FLST prevents them from being merged in merged pa' +
          'tch.'
        Caption = '[FO3/FNV] Sort FLST'
        TabOrder = 6
      end
      object cbSimpleRecords: TCheckBox
        Left = 16
        Top = 201
        Width = 357
        Height = 17
        Caption = 'Simple records LAND, NAVI, NAVM, CELL, WRLD (requires restart)'
        TabOrder = 7
      end
      object edColumnWidth: TEdit
        Left = 86
        Top = 276
        Width = 51
        Height = 21
        TabOrder = 8
      end
      object cbAutoSave: TCheckBox
        Left = 298
        Top = 15
        Width = 81
        Height = 17
        Caption = 'Auto save'
        TabOrder = 4
      end
      object cbTrackAllEditorID: TCheckBox
        Left = 298
        Top = 38
        Width = 111
        Height = 17
        Hint = 'Default only track MGEF and game settings'
        Caption = 'Track all EditorID'
        TabOrder = 5
      end
      object cbSortGroupRecord: TCheckBox
        Left = 16
        Top = 154
        Width = 81
        Height = 17
        Hint = 'Sort INFOs in DIAL by previous INFO'
        Caption = 'Sort INFOs'
        TabOrder = 10
      end
      object cbShowFlagEnumValue: TCheckBox
        Left = 16
        Top = 224
        Width = 297
        Height = 17
        Hint = 
          'Add integer values of flags and enumerations in () brackets at t' +
          'he end'
        Caption = 'Show values of flags and enumerations (requires restart)'
        TabOrder = 11
      end
      object cbRemoveOffsetData: TCheckBox
        Left = 16
        Top = 177
        Width = 169
        Height = 17
        Hint = 'Sort INFOs in DIAL by previous INFO'
        Caption = 'Remove OFST offset data'
        TabOrder = 12
      end
      object cbActorTemplateHide: TCheckBox
        Left = 16
        Top = 84
        Width = 169
        Height = 17
        Caption = 'Hide templated fields on actors'
        TabOrder = 13
      end
    end
    object tsCleaning: TTabSheet
      Caption = 'Cleaning'
      object Label1: TLabel
        Left = 16
        Top = 9
        Width = 154
        Height = 13
        Caption = 'Undelete and Disable Reference'
      end
      object cbUDRSetXESP: TCheckBox
        Left = 32
        Top = 32
        Width = 385
        Height = 33
        Caption = 
          'Set enabled state opposite of player (deactivate at your own ris' +
          'k, this is a critical setting)'
        TabOrder = 0
        WordWrap = True
      end
      object cbUDRSetScale: TCheckBox
        Left = 32
        Top = 71
        Width = 97
        Height = 17
        Caption = 'Set scale to'
        TabOrder = 1
      end
      object cbUDRSetZ: TCheckBox
        Left = 32
        Top = 94
        Width = 97
        Height = 17
        Caption = 'Set Z position to'
        TabOrder = 2
      end
      object edUDRSetScaleValue: TEdit
        Left = 133
        Top = 69
        Width = 84
        Height = 21
        TabOrder = 3
      end
      object edUDRSetZValue: TEdit
        Left = 133
        Top = 92
        Width = 84
        Height = 21
        TabOrder = 4
      end
      object cbUDRSetMSTT: TCheckBox
        Left = 32
        Top = 117
        Width = 201
        Height = 17
        Caption = '[FO3/FNV] Replace MSTT FormID with'
        TabOrder = 5
      end
      object edUDRSetMSTTValue: TEdit
        Left = 239
        Top = 115
        Width = 82
        Height = 21
        TabOrder = 6
      end
    end
    object tsDoNotBuildRefs: TTabSheet
      Caption = 'References building'
      ImageIndex = 3
      object Label2: TLabel
        Left = 16
        Top = 13
        Width = 187
        Height = 13
        Caption = 'Do not autobuild references for plugins'
      end
      object lbDoNotBuildRef: TListBox
        Left = 16
        Top = 32
        Width = 329
        Height = 257
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 0
      end
      object btnDoNotBuildRefAdd: TButton
        Left = 367
        Top = 32
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 1
        OnClick = btnDoNotBuildRefAddClick
      end
      object btnDoNotBuildRefDel: TButton
        Left = 367
        Top = 63
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 2
        OnClick = btnDoNotBuildRefDelClick
      end
    end
    object tsUISettings: TTabSheet
      Caption = 'UI Settings'
      ImageIndex = 2
      object Label3: TLabel
        Left = 16
        Top = 16
        Width = 89
        Height = 13
        Caption = 'Conflict Color Font'
      end
      object Label4: TLabel
        Left = 16
        Top = 72
        Width = 123
        Height = 13
        Caption = 'Conflict Color Background'
      end
      object clbConflictThis: TColorBox
        Left = 223
        Top = 35
        Width = 114
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbCustomColor, cbPrettyNames, cbCustomColors]
        TabOrder = 0
        OnChange = clbConflictThisChange
      end
      object cbConflictThis: TComboBox
        Left = 16
        Top = 35
        Width = 201
        Height = 21
        Style = csDropDownList
        TabOrder = 1
        OnChange = cbConflictThisChange
      end
      object cbConflictAll: TComboBox
        Left = 16
        Top = 91
        Width = 201
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        OnChange = cbConflictAllChange
      end
      object clbConflictAll: TColorBox
        Left = 223
        Top = 91
        Width = 114
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbCustomColor, cbPrettyNames, cbCustomColors]
        TabOrder = 3
        OnChange = clbConflictAllChange
      end
      object pnlFontRecords: TPanel
        Left = 16
        Top = 136
        Width = 137
        Height = 33
        Cursor = crHandPoint
        BevelKind = bkFlat
        BevelOuter = bvNone
        Caption = 'Records font'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = pnlFontRecordsClick
      end
      object pnlFontMessages: TPanel
        Left = 159
        Top = 136
        Width = 137
        Height = 33
        Cursor = crHandPoint
        BevelKind = bkFlat
        BevelOuter = bvNone
        Caption = 'Messages font'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = pnlFontRecordsClick
      end
      object pnlFontViewer: TPanel
        Left = 302
        Top = 136
        Width = 137
        Height = 33
        Cursor = crHandPoint
        BevelKind = bkFlat
        BevelOuter = bvNone
        Caption = 'Viewer font'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = pnlFontRecordsClick
      end
    end
  end
  object btnOK: TButton
    Left = 302
    Top = 346
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 383
    Top = 346
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
