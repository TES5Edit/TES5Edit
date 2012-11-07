object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 275
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
  OnKeyDown = FormKeyDown
  DesignSize = (
    466
    275)
  PixelsPerInch = 96
  TextHeight = 13
  object pcOptions: TPageControl
    Left = 0
    Top = 0
    Width = 466
    Height = 233
    ActivePage = tsGeneral
    Align = alTop
    TabOrder = 0
    object tsGeneral: TTabSheet
      Caption = 'General'
      ImageIndex = 1
      object Label2: TLabel
        Left = 24
        Top = 107
        Width = 417
        Height = 30
        AutoSize = False
        Caption = 
          'Deactivate for Skyrim only if you extracted STRINGS files, will ' +
          'reduce loading time greatly.'
        WordWrap = True
      end
      object cbIKnow: TCheckBox
        Left = 304
        Top = 15
        Width = 137
        Height = 17
        Caption = 'I know what I am doing'
        TabOrder = 0
      end
      object cbHideUnused: TCheckBox
        Left = 16
        Top = 15
        Width = 81
        Height = 17
        Caption = 'Hide unused'
        TabOrder = 1
      end
      object cbHideIgnored: TCheckBox
        Left = 16
        Top = 38
        Width = 81
        Height = 17
        Caption = 'Hide ignored'
        TabOrder = 2
      end
      object cbHideNeverShow: TCheckBox
        Left = 16
        Top = 61
        Width = 121
        Height = 17
        Caption = 'Hide "never shown"'
        TabOrder = 3
      end
      object cbLoadBSAs: TCheckBox
        Left = 16
        Top = 84
        Width = 81
        Height = 17
        Caption = 'Load BSAs'
        TabOrder = 4
      end
      object cbSortFLST: TCheckBox
        Left = 16
        Top = 149
        Width = 121
        Height = 17
        Caption = '[FO3/FNV] Sort FLST'
        TabOrder = 5
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
        Width = 201
        Height = 17
        Caption = 'Set enabled state opposite of player'
        TabOrder = 0
      end
      object cbUDRSetScale: TCheckBox
        Left = 32
        Top = 55
        Width = 97
        Height = 17
        Caption = 'Set scale to'
        TabOrder = 1
      end
      object cbUDRSetZ: TCheckBox
        Left = 32
        Top = 78
        Width = 97
        Height = 17
        Caption = 'Set Z position to'
        TabOrder = 2
      end
      object edUDRSetScaleValue: TEdit
        Left = 133
        Top = 53
        Width = 84
        Height = 21
        TabOrder = 3
      end
      object edUDRSetZValue: TEdit
        Left = 133
        Top = 76
        Width = 84
        Height = 21
        TabOrder = 4
      end
      object cbUDRSetMSTT: TCheckBox
        Left = 32
        Top = 101
        Width = 201
        Height = 17
        Caption = '[FO3/FNV] Replace MSTT FormID with'
        TabOrder = 5
      end
      object edUDRSetMSTTValue: TEdit
        Left = 239
        Top = 99
        Width = 82
        Height = 21
        TabOrder = 6
      end
    end
  end
  object btnOK: TButton
    Left = 302
    Top = 242
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 383
    Top = 242
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
