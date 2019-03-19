object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 436
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
    436)
  PixelsPerInch = 96
  TextHeight = 13
  object pcOptions: TPageControl
    Left = 0
    Top = 0
    Width = 466
    Height = 397
    ActivePage = tsGeneral
    Align = alTop
    TabOrder = 0
    object tsGeneral: TTabSheet
      Caption = 'General'
      ImageIndex = 1
      object cbHideUnused: TCheckBox
        Left = 16
        Top = 15
        Width = 233
        Height = 17
        Caption = 'Hide unused'
        TabOrder = 0
      end
      object cbHideIgnored: TCheckBox
        Left = 16
        Top = 38
        Width = 233
        Height = 17
        Caption = 'Hide ignored'
        TabOrder = 1
      end
      object cbHideNeverShow: TCheckBox
        Left = 16
        Top = 61
        Width = 233
        Height = 17
        Caption = 'Hide "never shown"'
        TabOrder = 2
      end
      object cbLoadBSAs: TCheckBox
        Left = 16
        Top = 108
        Width = 233
        Height = 17
        Hint = 
          'Skip loading BSA and BA2 archives. Some functions like LOD gener' +
          'ation and localization may not work properly if disabled.'
        Caption = 'Load BSAs'
        TabOrder = 3
      end
      object cbSimpleRecords: TCheckBox
        Left = 16
        Top = 201
        Width = 439
        Height = 17
        Hint = 'Display binary data as hex arrays'
        Caption = 'Simple records LAND, NAVI, NAVM, CELL, WRLD (requires restart)'
        TabOrder = 6
      end
      object cbShowUnsavedHint: TCheckBox
        Left = 266
        Top = 15
        Width = 189
        Height = 17
        Caption = 'Show Unsaved Hint'
        TabOrder = 4
      end
      object cbTrackAllEditorID: TCheckBox
        Left = 266
        Top = 38
        Width = 189
        Height = 17
        Hint = 'Default only track MGEF and game settings'
        Caption = 'Track all EditorID'
        TabOrder = 5
      end
      object cbRemoveOffsetData: TCheckBox
        Left = 16
        Top = 129
        Width = 243
        Height = 17
        Hint = 'Remove OFST subrecords from worldspaces'
        Caption = 'Remove OFST offset data'
        TabOrder = 7
      end
      object cbActorTemplateHide: TCheckBox
        Left = 16
        Top = 84
        Width = 233
        Height = 17
        Caption = 'Hide templated fields on actors'
        TabOrder = 8
      end
      object cbShowGroupRecordCount: TCheckBox
        Left = 16
        Top = 151
        Width = 243
        Height = 17
        Caption = 'Show elements count for group records'
        TabOrder = 9
      end
      object cbShowTip: TCheckBox
        Left = 266
        Top = 61
        Width = 189
        Height = 17
        Hint = 'Default only track MGEF and game settings'
        Caption = 'Show tip on start'
        TabOrder = 10
      end
      object cbShowFileFlags: TCheckBox
        Left = 16
        Top = 174
        Width = 243
        Height = 17
        Caption = 'Show file header flags'
        TabOrder = 11
      end
      object cbAlignArrayElements: TCheckBox
        Left = 16
        Top = 227
        Width = 439
        Height = 17
        Caption = 'Align alignable array elements'
        TabOrder = 12
      end
      object cbPatron: TCheckBox
        Left = 266
        Top = 84
        Width = 189
        Height = 17
        BiDiMode = bdRightToLeftReadingOnly
        Caption = 'I am a patron or donor'
        ParentBiDiMode = False
        TabOrder = 13
      end
      object cbNoGitHubCheck: TCheckBox
        Left = 266
        Top = 131
        Width = 189
        Height = 17
        BiDiMode = bdRightToLeftReadingOnly
        Caption = 'Don'#39't check for GitHub update'
        ParentBiDiMode = False
        TabOrder = 14
      end
      object cbNoNexusModsCheck: TCheckBox
        Left = 266
        Top = 108
        Width = 189
        Height = 17
        BiDiMode = bdRightToLeftReadingOnly
        Caption = 'Don'#39't check for NexusMods update'
        ParentBiDiMode = False
        TabOrder = 15
      end
      object cbResetModifiedOnSave: TCheckBox
        Left = 265
        Top = 154
        Width = 189
        Height = 17
        BiDiMode = bdRightToLeftReadingOnly
        Caption = 'Reset Modified (Bold) on Save'
        ParentBiDiMode = False
        TabOrder = 16
      end
      object cbAlwaysSaveOnam: TCheckBox
        Left = 265
        Top = 177
        Width = 189
        Height = 17
        BiDiMode = bdRightToLeftReadingOnly
        Caption = 'Always save ONAM'
        ParentBiDiMode = False
        TabOrder = 17
      end
      object cbManualCleaningHide: TCheckBox
        Left = 16
        Top = 250
        Width = 439
        Height = 17
        Caption = 'Hide Manual Cleaning functions'
        TabOrder = 18
      end
    end
    object tsViewSettings: TTabSheet
      Caption = 'View'
      object lblFieldsToCollapse: TLabel
        Left = 16
        Top = 15
        Width = 261
        Height = 13
        Caption = 'Fields to Collapse by Default (requires restart)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTypesToCollapse: TLabel
        Left = 16
        Top = 231
        Width = 263
        Height = 13
        Caption = 'Types to Collapse by Default (requires restart)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbCollapseRecordHeader: TCheckBox
        Left = 16
        Top = 39
        Width = 220
        Height = 17
        Caption = 'Record Header'
        TabOrder = 0
      end
      object cbCollapseObjectBounds: TCheckBox
        Left = 235
        Top = 39
        Width = 220
        Height = 17
        Caption = 'Object Bounds (except TES4)'
        TabOrder = 1
      end
      object cbCollapseConditions: TCheckBox
        Left = 16
        Top = 62
        Width = 89
        Height = 17
        Caption = 'Conditions'
        TabOrder = 2
      end
      object cbCollapseFactionRelations: TCheckBox
        Left = 235
        Top = 62
        Width = 220
        Height = 17
        Caption = 'Faction Relations'
        TabOrder = 3
      end
      object cbCollapseModels: TCheckBox
        Left = 16
        Top = 85
        Width = 439
        Height = 17
        Caption = 'Models / 1st Person Models / Biped Models / World Models'
        TabOrder = 4
      end
      object cbCollapseItems: TCheckBox
        Left = 16
        Top = 108
        Width = 220
        Height = 17
        Caption = 'Items / Components'
        TabOrder = 5
      end
      object cbCollapseScriptProperties: TCheckBox
        Left = 16
        Top = 177
        Width = 439
        Height = 17
        Caption = 'Script Properties (only TES5, FO4, and FO76)'
        TabOrder = 6
      end
      object cbCollapseBenignArray: TCheckBox
        Left = 16
        Top = 200
        Width = 220
        Height = 17
        Caption = 'Arrays with Benign Conflict Priority'
        TabOrder = 7
      end
      object cbCollapseLeveledItems: TCheckBox
        Left = 235
        Top = 108
        Width = 220
        Height = 17
        Caption = 'Leveled List Entries (except FO76)'
        TabOrder = 8
      end
      object cbCollapseObjectProperties: TCheckBox
        Left = 16
        Top = 154
        Width = 439
        Height = 17
        Caption = 'Actor Value Properties (only FO4 and FO76)'
        TabOrder = 9
      end
      object cbCollapseEquipSlots: TCheckBox
        Left = 16
        Top = 131
        Width = 220
        Height = 17
        Caption = 'Race Equip Slots (only FO4 and FO76)'
        TabOrder = 10
      end
      object cbCollapseFactions: TCheckBox
        Left = 138
        Top = 62
        Width = 91
        Height = 17
        Caption = 'Factions'
        TabOrder = 11
      end
      object cbCollapseRGBA: TCheckBox
        Left = 16
        Top = 255
        Width = 213
        Height = 17
        Caption = 'Colors (RGB/A)'
        TabOrder = 12
      end
      object cbCollapseVec3: TCheckBox
        Left = 235
        Top = 255
        Width = 213
        Height = 17
        Caption = 'Vector3 (XYZ)'
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
        Width = 112
        Height = 17
        Caption = 'Set scale to'
        TabOrder = 1
      end
      object cbUDRSetZ: TCheckBox
        Left = 32
        Top = 94
        Width = 112
        Height = 17
        Caption = 'Set Z position to'
        TabOrder = 2
      end
      object edUDRSetScaleValue: TEdit
        Left = 149
        Top = 69
        Width = 84
        Height = 21
        TabOrder = 3
      end
      object edUDRSetZValue: TEdit
        Left = 149
        Top = 92
        Width = 84
        Height = 21
        TabOrder = 4
      end
      object cbUDRSetMSTT: TCheckBox
        Left = 32
        Top = 117
        Width = 213
        Height = 17
        Caption = '[FO3/FNV] Replace MSTT FormID with'
        TabOrder = 5
      end
      object edUDRSetMSTTValue: TEdit
        Left = 247
        Top = 115
        Width = 82
        Height = 21
        TabOrder = 6
      end
    end
    object tsUISettings: TTabSheet
      Caption = 'UI Settings'
      ImageIndex = 2
      object Label3: TLabel
        Left = 16
        Top = 40
        Width = 89
        Height = 13
        Caption = 'Conflict Color Font'
      end
      object Label4: TLabel
        Left = 16
        Top = 96
        Width = 123
        Height = 13
        Caption = 'Conflict Color Background'
      end
      object Label5: TLabel
        Left = 18
        Top = 216
        Width = 66
        Height = 13
        Caption = 'Column Width'
      end
      object Label6: TLabel
        Left = 159
        Top = 215
        Width = 55
        Height = 13
        Caption = 'Row Height'
      end
      object Label7: TLabel
        Left = 16
        Top = 259
        Width = 267
        Height = 13
        Caption = 'Auto "Compare Selected" when multi-selecting less than'
      end
      object Label8: TLabel
        Left = 375
        Top = 259
        Width = 36
        Height = 13
        Caption = 'records'
      end
      object Label9: TLabel
        Left = 16
        Top = 291
        Width = 330
        Height = 13
        Caption = 
          'Delay updating View when navigation treeview selection changes b' +
          'y '
      end
      object Label10: TLabel
        Left = 431
        Top = 291
        Width = 24
        Height = 13
        Caption = 'msec'
      end
      object clbConflictThis: TColorBox
        Left = 223
        Top = 59
        Width = 114
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbCustomColor, cbPrettyNames, cbCustomColors]
        TabOrder = 0
        OnChange = clbConflictThisChange
      end
      object cbConflictThis: TComboBox
        Left = 16
        Top = 59
        Width = 201
        Height = 21
        Style = csDropDownList
        TabOrder = 1
        OnChange = cbConflictThisChange
      end
      object cbConflictAll: TComboBox
        Left = 16
        Top = 115
        Width = 201
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        OnChange = cbConflictAllChange
      end
      object clbConflictAll: TColorBox
        Left = 223
        Top = 115
        Width = 114
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbCustomColor, cbPrettyNames, cbCustomColors]
        TabOrder = 3
        OnChange = clbConflictAllChange
      end
      object pnlFontRecords: TPanel
        Left = 16
        Top = 160
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
        Top = 160
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
        Top = 160
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
      object edColumnWidth: TEdit
        Left = 92
        Top = 212
        Width = 51
        Height = 21
        TabOrder = 7
      end
      object edRowHeight: TEdit
        Left = 223
        Top = 212
        Width = 51
        Height = 21
        TabOrder = 8
      end
      object sedAutoCompareSelectedLimit: TSpinEdit
        Left = 297
        Top = 255
        Width = 64
        Height = 22
        MaxValue = 999999
        MinValue = 0
        TabOrder = 9
        Value = 0
      end
      object sedNavChangeDelay: TSpinEdit
        Left = 360
        Top = 288
        Width = 59
        Height = 22
        MaxValue = 999999
        MinValue = 0
        TabOrder = 10
        Value = 0
      end
      object cbRequireCtrlForDblClick: TCheckBox
        Left = 16
        Top = 321
        Width = 280
        Height = 17
        Caption = 'Selection forms require holding CTRL for double click'
        TabOrder = 11
      end
      object cbFocusAddedElement: TCheckBox
        Left = 16
        Top = 344
        Width = 423
        Height = 17
        Caption = 
          'Focus newly added elements in View (can be inverted by holding C' +
          'TRL)'
        TabOrder = 12
      end
      object cbShrinkButtons: TCheckBox
        Left = 16
        Top = 12
        Width = 439
        Height = 17
        Caption = 'Shrink SpeedButtons in the top right corner of the main form '
        TabOrder = 13
      end
    end
    object tbsUITheme: TTabSheet
      Caption = 'UI Theme'
      ImageIndex = 3
      object pnlThemeTop: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 452
        Height = 46
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object rbThemeSystem: TRadioButton
          Left = 0
          Top = 1
          Width = 65
          Height = 17
          Caption = '&System'
          TabOrder = 0
          OnClick = rbThemeClick
        end
        object cbThemeSystem: TComboBox
          Left = 0
          Top = 24
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 1
          OnSelect = cbThemeSystemSelect
        end
        object rbThemeLight: TRadioButton
          Left = 151
          Top = 1
          Width = 65
          Height = 17
          Caption = 'Light'
          TabOrder = 2
          OnClick = rbThemeClick
        end
        object cbThemeLight: TComboBox
          Left = 151
          Top = 24
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 3
          OnSelect = cbThemeSystemSelect
        end
        object rbThemeDark: TRadioButton
          Left = 302
          Top = 1
          Width = 65
          Height = 17
          Caption = 'Dark'
          TabOrder = 4
          OnClick = rbThemeClick
        end
        object cbThemeDark: TComboBox
          Left = 302
          Top = 24
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 5
          OnSelect = cbThemeSystemSelect
        end
      end
      object pnlThemePreview: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 55
        Width = 452
        Height = 311
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 1
      end
    end
    object tsExperts: TTabSheet
      Caption = 'Experts'
      ImageIndex = 4
      object cbClampFormID: TCheckBox
        Left = 16
        Top = 101
        Width = 439
        Height = 17
        Hint = 'Set FormID index to the number of masters if greater'
        Caption = 'Clamp FormIDs'
        TabOrder = 0
      end
      object cbShowFlagEnumValue: TCheckBox
        Left = 16
        Top = 80
        Width = 439
        Height = 17
        Hint = 
          'Add integer values of flags and enumerations in () brackets at t' +
          'he end'
        Caption = 
          'Show values of flags and enumerations (requires restart, interfe' +
          'res with scripts)'
        TabOrder = 1
      end
      object cbSortINFO: TCheckBox
        Left = 16
        Top = 34
        Width = 243
        Height = 17
        Hint = 'Sort INFOs in DIAL by previous INFO'
        Caption = 'Sort INFOs (requires restart)'
        TabOrder = 2
      end
      object cbFillPNAM: TCheckBox
        Left = 32
        Top = 57
        Width = 227
        Height = 17
        Hint = 'Fill missing PNAM in INFO records'
        Caption = 'Fill missing PNAM (requires restart)'
        TabOrder = 3
      end
      object cbSortFLST: TCheckBox
        Left = 16
        Top = 11
        Width = 233
        Height = 17
        Hint = 
          'Sorting FLST can cause issues for mods relying on the order of f' +
          'orms, unsorted FLST prevents them from being merged in merged pa' +
          'tch.'
        Caption = '[FO3/FNV] Sort FLST'
        TabOrder = 4
      end
      object cbManualCleaningAllow: TCheckBox
        Left = 16
        Top = 124
        Width = 439
        Height = 17
        Caption = 'Allow Manual Cleaning functions'
        TabOrder = 5
      end
    end
  end
  object btnOK: TButton
    Left = 302
    Top = 403
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 383
    Top = 403
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
