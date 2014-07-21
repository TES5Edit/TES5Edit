object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'TESV ESS Editor'
  ClientHeight = 476
  ClientWidth = 1015
  Color = 15790320
  Constraints.MinHeight = 360
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PrintScale = poNone
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object spSplit: TSplitter
    Left = 250
    Top = 0
    Height = 476
    Visible = False
    OnMoved = spSplitMoved
    ExplicitLeft = 216
    ExplicitTop = -8
    ExplicitHeight = 475
  end
  object pnWorkplace: TPanel
    Left = 253
    Top = 0
    Width = 762
    Height = 476
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    Color = 15790320
    Constraints.MinWidth = 520
    TabOrder = 0
    DesignSize = (
      762
      476)
    object imLogo: TImage
      Left = 304
      Top = 0
      Width = 97
      Height = 43
      Anchors = [akLeft, akTop, akRight, akBottom]
      Center = True
      Transparent = True
      ExplicitWidth = 100
      ExplicitHeight = 10
    end
    object lbLink: TLabel
      Left = 0
      Top = 16
      Width = 261
      Height = 13
      Cursor = crHandPoint
      Alignment = taCenter
      Caption = 'http://www.uesp.net/wiki/Tes5Mod:Save_File_Format'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = lbLinkClick
    end
    object pnStatus: TPanel
      Left = 0
      Top = 458
      Width = 762
      Height = 18
      Align = alBottom
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      BorderWidth = 2
      Caption = 'File:'
      Color = 15790320
      TabOrder = 1
      VerticalAlignment = taAlignBottom
      Visible = False
    end
    object pcEditors: TPageControl
      Left = 3
      Top = 41
      Width = 758
      Height = 421
      ActivePage = tsGD32
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      Visible = False
      object tsMain: TTabSheet
        Caption = 'Main'
        OnShow = tsMainShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object imMain: TImage
          Left = 0
          Top = 0
          Width = 750
          Height = 105
          Align = alTop
          Center = True
          Proportional = True
          ExplicitWidth = 483
        end
        object lbMain: TLabel
          Left = 0
          Top = 105
          Width = 750
          Height = 288
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'lbMain'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Comic Sans MS'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = -4
          ExplicitTop = 109
          ExplicitWidth = 896
          ExplicitHeight = 285
        end
      end
      object tsScreen: TTabSheet
        Caption = 'Screen'
        ImageIndex = 1
        OnShow = tsScreenShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object imScreen: TImage
          Left = 0
          Top = 0
          Width = 750
          Height = 375
          Align = alClient
          Center = True
          Proportional = True
          Stretch = True
          ExplicitLeft = -4
          ExplicitTop = -6
          ExplicitWidth = 483
          ExplicitHeight = 355
        end
        object pnScreen: TPanel
          Left = 0
          Top = 375
          Width = 750
          Height = 18
          Align = alBottom
          BevelOuter = bvNone
          Caption = ' '
          Color = 15790320
          TabOrder = 0
          object cbScreenCenter: TCheckBox
            Left = 1
            Top = 1
            Width = 97
            Height = 17
            Caption = 'Center'
            TabOrder = 0
            OnClick = cbScreenClick
          end
          object cbScreenProportional: TCheckBox
            Left = 207
            Top = 1
            Width = 97
            Height = 17
            Caption = 'Proportional'
            TabOrder = 2
            OnClick = cbScreenClick
          end
          object cbScreenStrech: TCheckBox
            Left = 104
            Top = 1
            Width = 97
            Height = 17
            Caption = 'Strech'
            TabOrder = 1
            OnClick = cbScreenClick
          end
        end
      end
      object tsData: TTabSheet
        Caption = 'Data'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnData: TPanel
          Left = 0
          Top = 366
          Width = 750
          Height = 27
          Align = alBottom
          BevelOuter = bvNone
          Caption = ' '
          Color = 15790320
          TabOrder = 0
        end
        object sgHeader: TStringGrid
          Left = 0
          Top = 0
          Width = 750
          Height = 18
          Align = alTop
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = 15790320
          ColCount = 35
          Ctl3D = False
          DefaultColWidth = 10
          DefaultRowHeight = 18
          DefaultDrawing = False
          Enabled = False
          FixedCols = 0
          RowCount = 1
          FixedRows = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Options = []
          ParentCtl3D = False
          ParentFont = False
          ScrollBars = ssNone
          TabOrder = 1
          OnDrawCell = sgHeaderDrawCell
        end
      end
      object tsForms: TTabSheet
        Caption = 'Forms'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lvForms: TListView
          Tag = 1
          Left = 0
          Top = 0
          Width = 750
          Height = 366
          Align = alClient
          Color = 15790320
          Columns = <
            item
              Caption = 'Index'
              Width = 75
            end
            item
              Caption = 'Form ID'
              Width = 90
            end
            item
              Caption = 'Change flags'
              Width = 110
            end
            item
              Caption = 'Change flags'
              Width = 110
            end
            item
              Caption = 'Type'
              Width = 75
            end
            item
              Caption = 'Type name'
              Width = 100
            end
            item
              Caption = 'Version'
              Width = 85
            end
            item
              Caption = 'Length'
              Width = 75
            end
            item
              AutoSize = True
              Caption = 'Uncompressed'
            end>
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          MultiSelect = True
          ReadOnly = True
          RowSelect = True
          ParentFont = False
          TabOrder = 0
          ViewStyle = vsReport
          OnColumnClick = lvFormsColumnClick
          OnCustomDrawItem = lvCustomDrawItem
          OnData = lvFormsData
          OnDblClick = lvFormsDblClick
          OnKeyUp = lvFormsKeyUp
          OnSelectItem = lvFormsSelectItem
        end
        object pnForms: TPanel
          Left = 0
          Top = 366
          Width = 750
          Height = 27
          Align = alBottom
          BevelOuter = bvNone
          Caption = ' '
          Color = 15790320
          TabOrder = 1
        end
      end
      object tsInteger: TTabSheet
        Caption = 'Integer'
        ImageIndex = 4
        OnShow = tsIntegerShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lbIntDec: TLabel
          Left = 16
          Top = 16
          Width = 18
          Height = 13
          Caption = '&Dec'
          FocusControl = edIntDec
          Transparent = True
        end
        object lbIntHex: TLabel
          Left = 146
          Top = 16
          Width = 19
          Height = 13
          Caption = '&Hex'
          FocusControl = edIntHex
          Transparent = True
        end
        object lbIntBin: TLabel
          Left = 276
          Top = 16
          Width = 14
          Height = 13
          Caption = '&Bin'
          FocusControl = edIntBin
          Transparent = True
        end
        object sb31: TSpeedButton
          Left = 16
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb30: TSpeedButton
          Left = 32
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb29: TSpeedButton
          Left = 48
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb28: TSpeedButton
          Left = 64
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb27: TSpeedButton
          Left = 80
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb26: TSpeedButton
          Left = 96
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb25: TSpeedButton
          Left = 112
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb24: TSpeedButton
          Left = 128
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb23: TSpeedButton
          Left = 146
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb22: TSpeedButton
          Left = 162
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb21: TSpeedButton
          Left = 178
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb20: TSpeedButton
          Left = 194
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb19: TSpeedButton
          Left = 210
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb18: TSpeedButton
          Left = 226
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb17: TSpeedButton
          Left = 242
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb16: TSpeedButton
          Left = 258
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb07: TSpeedButton
          Left = 406
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb06: TSpeedButton
          Left = 422
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb05: TSpeedButton
          Left = 438
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb04: TSpeedButton
          Left = 454
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb03: TSpeedButton
          Left = 470
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb02: TSpeedButton
          Left = 486
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb01: TSpeedButton
          Left = 502
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb00: TSpeedButton
          Left = 518
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb08: TSpeedButton
          Left = 388
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb09: TSpeedButton
          Left = 372
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb10: TSpeedButton
          Left = 356
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb11: TSpeedButton
          Left = 340
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb12: TSpeedButton
          Left = 324
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb13: TSpeedButton
          Left = 308
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb14: TSpeedButton
          Left = 292
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object sb15: TSpeedButton
          Left = 276
          Top = 59
          Width = 16
          Height = 16
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '1'
          Spacing = 0
        end
        object lbRange: TLabel
          Left = 16
          Top = 88
          Width = 518
          Height = 74
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Range:'
        end
        object edIntDec: TEdit
          Left = 16
          Top = 35
          Width = 128
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = edChange
          OnKeyPress = edKeyPress
        end
        object edIntHex: TEdit
          Left = 146
          Top = 35
          Width = 128
          Height = 21
          TabOrder = 1
          OnChange = edChange
          OnKeyPress = edKeyPress
        end
        object edIntBin: TEdit
          Left = 276
          Top = 35
          Width = 258
          Height = 21
          TabOrder = 2
          OnChange = edChange
          OnKeyPress = edKeyPress
        end
      end
      object tsReadCalc: TTabSheet
        Caption = 'ReadCalc'
        ImageIndex = 5
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lbRODec: TLabel
          Left = 16
          Top = 16
          Width = 18
          Height = 13
          Caption = '&Dec'
          FocusControl = edRODec
          Transparent = True
        end
        object lbROHex: TLabel
          Left = 146
          Top = 16
          Width = 19
          Height = 13
          Caption = '&Hex'
          FocusControl = edROHex
          Transparent = True
        end
        object lbROBin: TLabel
          Left = 276
          Top = 16
          Width = 14
          Height = 13
          Caption = '&Bin'
          FocusControl = edROBin
          Transparent = True
        end
        object lbReadOnly: TLabel
          Left = 16
          Top = 72
          Width = 384
          Height = 23
          Caption = 'Value is read only and can'#39't be changed.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMenuHighlight
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Visible = False
        end
        object lbCalc: TLabel
          Left = 16
          Top = 72
          Width = 524
          Height = 23
          Caption = 'Value is calculated durring save and can'#39't set manualy.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMenuHighlight
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Visible = False
        end
        object edRODec: TEdit
          Left = 16
          Top = 35
          Width = 128
          Height = 21
          CharCase = ecUpperCase
          Color = 15790320
          ReadOnly = True
          TabOrder = 0
        end
        object edROHex: TEdit
          Left = 146
          Top = 35
          Width = 128
          Height = 21
          CharCase = ecUpperCase
          Color = 15790320
          ReadOnly = True
          TabOrder = 1
        end
        object edROBin: TEdit
          Left = 276
          Top = 35
          Width = 258
          Height = 21
          CharCase = ecUpperCase
          Color = 15790320
          ReadOnly = True
          TabOrder = 2
        end
      end
      object tsString: TTabSheet
        Caption = 'String'
        ImageIndex = 6
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        DesignSize = (
          750
          393)
        object edWString: TEdit
          Left = 16
          Top = 16
          Width = 720
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          MaxLength = 65535
          TabOrder = 0
        end
      end
      object tsFloat: TTabSheet
        Caption = 'Float'
        ImageIndex = 7
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        DesignSize = (
          750
          393)
        object edFloat: TEdit
          Left = 16
          Top = 16
          Width = 720
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnKeyPress = edKeyPress
        end
      end
      object tsFlags: TTabSheet
        Caption = 'Flags'
        ImageIndex = 8
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object tvFlags: TTreeView
          Left = 0
          Top = 0
          Width = 750
          Height = 393
          Align = alClient
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = 15790320
          Ctl3D = False
          Indent = 19
          ParentCtl3D = False
          ReadOnly = True
          ShowLines = False
          ShowRoot = False
          TabOrder = 0
          OnCustomDrawItem = tvFlagsCustomDrawItem
        end
      end
      object tsGD01: TTabSheet
        Caption = 'GD01'
        ImageIndex = 9
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pcGD01: TPageControl
          Left = 0
          Top = 0
          Width = 750
          Height = 393
          ActivePage = tsGD01All
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          OwnerDraw = True
          ParentFont = False
          TabOrder = 0
          OnDrawTab = pcGD01DrawTab
          object tsGD01General: TTabSheet
            Caption = 'General'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object lvGD01General: TListView
              Left = 0
              Top = 0
              Width = 742
              Height = 362
              Align = alClient
              Color = 15790320
              Columns = <
                item
                  Caption = 'Value'
                  Width = 100
                end
                item
                  AutoSize = True
                  Caption = 'Description'
                end>
              Ctl3D = False
              RowSelect = True
              TabOrder = 0
              ViewStyle = vsReport
              OnColumnClick = lvColumnClick
              OnCustomDrawItem = lvCustomDrawItem
              OnEdited = lvEdited
              OnKeyUp = lvKeyUp
            end
          end
          object tsGD01Quest: TTabSheet
            Caption = 'Quest'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object lvGD01Quest: TListView
              Left = 0
              Top = 0
              Width = 742
              Height = 362
              Align = alClient
              Color = 15790320
              Columns = <
                item
                  Caption = 'Value'
                  Width = 100
                end
                item
                  AutoSize = True
                  Caption = 'Description'
                end>
              Ctl3D = False
              RowSelect = True
              TabOrder = 0
              ViewStyle = vsReport
              OnColumnClick = lvColumnClick
              OnCustomDrawItem = lvCustomDrawItem
              OnEdited = lvEdited
              OnKeyUp = lvKeyUp
            end
          end
          object tsGD01Combat: TTabSheet
            Caption = 'Combat'
            ImageIndex = 2
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object lvGD01Combat: TListView
              Left = 0
              Top = 0
              Width = 742
              Height = 362
              Align = alClient
              Color = 15790320
              Columns = <
                item
                  Caption = 'Value'
                  Width = 100
                end
                item
                  AutoSize = True
                  Caption = 'Description'
                end>
              Ctl3D = False
              RowSelect = True
              TabOrder = 0
              ViewStyle = vsReport
              OnColumnClick = lvColumnClick
              OnCustomDrawItem = lvCustomDrawItem
              OnEdited = lvEdited
              OnKeyUp = lvKeyUp
            end
          end
          object tsGD01Magic: TTabSheet
            Caption = 'Magic'
            ImageIndex = 3
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object lvGD01Magic: TListView
              Left = 0
              Top = 0
              Width = 742
              Height = 362
              Align = alClient
              Color = 15790320
              Columns = <
                item
                  Caption = 'Value'
                  Width = 100
                end
                item
                  AutoSize = True
                  Caption = 'Description'
                end>
              Ctl3D = False
              RowSelect = True
              TabOrder = 0
              ViewStyle = vsReport
              OnColumnClick = lvColumnClick
              OnCustomDrawItem = lvCustomDrawItem
              OnEdited = lvEdited
              OnKeyUp = lvKeyUp
            end
          end
          object tsGD01Crafting: TTabSheet
            Caption = 'Crafting'
            ImageIndex = 4
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object lvGD01Crafting: TListView
              Left = 0
              Top = 0
              Width = 742
              Height = 362
              Align = alClient
              Color = 15790320
              Columns = <
                item
                  Caption = 'Value'
                  Width = 100
                end
                item
                  AutoSize = True
                  Caption = 'Description'
                end>
              Ctl3D = False
              RowSelect = True
              TabOrder = 0
              ViewStyle = vsReport
              OnColumnClick = lvColumnClick
              OnCustomDrawItem = lvCustomDrawItem
              OnEdited = lvEdited
              OnKeyUp = lvKeyUp
            end
          end
          object tsGD01Crime: TTabSheet
            Caption = 'Crime'
            ImageIndex = 5
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object lvGD01Crime: TListView
              Left = 0
              Top = 0
              Width = 742
              Height = 362
              Align = alClient
              Color = 15790320
              Columns = <
                item
                  Caption = 'Value'
                  Width = 100
                end
                item
                  AutoSize = True
                  Caption = 'Description'
                end>
              Ctl3D = False
              RowSelect = True
              TabOrder = 0
              ViewStyle = vsReport
              OnColumnClick = lvColumnClick
              OnCustomDrawItem = lvCustomDrawItem
              OnEdited = lvEdited
              OnKeyUp = lvKeyUp
            end
          end
          object tsGD01All: TTabSheet
            Caption = 'All'
            ImageIndex = 6
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object lvGD01All: TListView
              Left = 0
              Top = 0
              Width = 742
              Height = 335
              Align = alClient
              Color = 15790320
              Columns = <
                item
                  Caption = 'Value'
                  Width = 100
                end
                item
                  Caption = 'Category'
                  Width = 100
                end
                item
                  AutoSize = True
                  Caption = 'Description'
                end>
              Ctl3D = False
              RowSelect = True
              TabOrder = 0
              ViewStyle = vsReport
              OnColumnClick = lvColumnClick
              OnCustomDrawItem = lvCustomDrawItem
              OnEdited = lvEdited
              OnKeyUp = lvKeyUp
            end
            object pnGD01All: TPanel
              Left = 0
              Top = 335
              Width = 742
              Height = 27
              Align = alBottom
              BevelOuter = bvNone
              Caption = ' '
              Color = 15790320
              TabOrder = 1
            end
          end
        end
      end
      object tsGD02: TTabSheet
        Caption = 'GD02'
        ImageIndex = 10
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lvGD02: TListView
          Left = 0
          Top = 0
          Width = 750
          Height = 393
          Align = alClient
          Color = 15790320
          Columns = <
            item
              Caption = 'Value'
              Width = 200
            end
            item
              AutoSize = True
              Caption = 'Description'
            end>
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          RowSelect = True
          ParentFont = False
          TabOrder = 0
          ViewStyle = vsReport
          OnColumnClick = lvColumnClick
          OnCustomDrawItem = lvCustomDrawItem
          OnEdited = lvGD02Edited
          OnKeyUp = lvKeyUp
        end
      end
      object tsGD0X: TTabSheet
        Caption = 'GD0X'
        ImageIndex = 13
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnInfo: TPanel
          Left = 0
          Top = 0
          Width = 750
          Height = 18
          Align = alTop
          BevelOuter = bvLowered
          Caption = 'Only view'
          TabOrder = 0
        end
      end
      object tsGD04: TTabSheet
        Caption = 'GD04'
        ImageIndex = 11
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lvGD04: TListView
          Left = 0
          Top = 0
          Width = 750
          Height = 366
          Align = alClient
          Color = 15790320
          Columns = <
            item
              Caption = 'Value'
              Width = 200
            end
            item
              AutoSize = True
              Caption = 'Form ID'
            end>
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          RowSelect = True
          ParentFont = False
          TabOrder = 0
          ViewStyle = vsReport
          OnColumnClick = lvColumnClick
          OnCustomDrawItem = lvCustomDrawItem
          OnEdited = lvGD04Edited
          OnKeyUp = lvKeyUp
        end
        object pnGD04: TPanel
          Left = 0
          Top = 366
          Width = 750
          Height = 27
          Align = alBottom
          BevelOuter = bvNone
          Caption = ' '
          Color = 15790320
          TabOrder = 1
        end
      end
      object tsGD32: TTabSheet
        Caption = 'GD32'
        ImageIndex = 12
        object pnGD32Background: TPanel
          Left = 0
          Top = 0
          Width = 609
          Height = 393
          Align = alClient
          BevelKind = bkTile
          BevelOuter = bvNone
          Color = 16250871
          TabOrder = 0
          object pnPath: TPanel
            Left = 0
            Top = 371
            Width = 605
            Height = 18
            Align = alBottom
            Alignment = taLeftJustify
            BevelKind = bkTile
            BevelOuter = bvNone
            Caption = ' '
            Color = 16250871
            TabOrder = 0
          end
        end
        object pnTools: TPanel
          Left = 609
          Top = 0
          Width = 141
          Height = 393
          Align = alRight
          BevelKind = bkTile
          BevelOuter = bvNone
          Caption = ' '
          Color = 16250871
          TabOrder = 1
          DesignSize = (
            137
            389)
          object lbPapyrusSearch: TLabel
            Left = 4
            Top = 147
            Width = 37
            Height = 13
            Alignment = taRightJustify
            Anchors = [akLeft, akBottom]
            Caption = 'Search:'
            FocusControl = edPapyrusSearch
            ExplicitTop = 290
          end
          object edPapyrusSearch: TEdit
            Left = 4
            Top = 163
            Width = 0
            Height = 21
            Anchors = [akLeft, akRight, akBottom]
            TabOrder = 0
            OnChange = edPapyrusSearchChange
            OnKeyDown = edPapyrusSearchKeyDown
            OnKeyPress = edSearchKeyPress
          end
          object stPapyrusNotFound: TStaticText
            Left = 47
            Top = 147
            Width = 87
            Height = 16
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = 'Not found'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Visible = False
          end
        end
      end
    end
  end
  object pnStructure: TPanel
    Left = 0
    Top = 0
    Width = 250
    Height = 476
    Align = alLeft
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    Visible = False
    object pnSearch: TPanel
      Left = 0
      Top = 434
      Width = 250
      Height = 42
      Align = alBottom
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = ' '
      Color = 15790320
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      Visible = False
      object lbSearch: TLabel
        Left = 4
        Top = 3
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'Search:'
        FocusControl = edSearch
      end
      object edSearch: TEdit
        Left = 4
        Top = 19
        Width = 106
        Height = 19
        TabOrder = 0
        OnChange = edSearchChange
        OnKeyDown = edSearchKeyDown
        OnKeyPress = edSearchKeyPress
      end
      object stNotFound: TStaticText
        Left = 47
        Top = 3
        Width = 52
        Height = 16
        AutoSize = False
        Caption = 'Not found'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Visible = False
      end
    end
  end
  object odBinOpen: TOpenDialog
    Filter = 'Binary files (*.bin)|*.bin|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 72
  end
  object sdBinSave: TSaveDialog
    DefaultExt = 'BIN'
    Filter = 'Binary files (*.bin)|*.bin|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 40
  end
  object sdSave: TSaveDialog
    DefaultExt = 'ESS'
    Filter = 'TESV save game file (*.ess)|*.ess|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 136
  end
  object pmSave: TPopupMenu
    Images = imImages
    Left = 104
    object pmiNormal: TMenuItem
      Caption = '&Normal'
      ImageIndex = 1
      OnClick = pmiClick
    end
    object pmiUncompress: TMenuItem
      Tag = 1
      Caption = '&Uncompressed'
      ImageIndex = 3
      OnClick = pmiClick
    end
    object pmiCompress: TMenuItem
      Tag = 2
      Caption = 'Max &compress'
      ImageIndex = 2
      OnClick = pmiClick
    end
  end
  object imImages: TImageList
    Left = 8
    Bitmap = {
      494C010110001300040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000002880001089300010B9900010C990001089300000389000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000364000003640000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000001
      8600010D9D00021CAF00021FB400021FB500021FB500021FB200021CB000010F
      9F00000287000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000035D0500035D050000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000004
      6D000118BC000216A40000036400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000038A000118
      B200021FB700021EB100021DB100021DB100021DB100021DB100021EB200021F
      B4000219AC0000048E0000000000000000000000000000000000000000000000
      00000000000000000000035D05005BF79100058C0D00035D0500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000004B0000004B0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000004
      6F005673F8000220D5000219AA00000364000000000000000000000000000000
      00000000000000000000000000000000000000000000000183000118BB000220
      CC00011CBF000015B400011AB000021DB100021DB100011CB0000015AD00011B
      B000021FB400021AAC0000028700000000000000000000000000000000000000
      00000000000000000000035D05005BF7910005950E00035D0500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000004B00000F9E1C000F9D1E00004B00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000364005673F800021FD3000219AA000003640000000000000000000000
      00000000000000000000000000000000000000000000010CA7000121E000011C
      D3000726CC004966D7000B28BC000018B0000019AF000622B4004A66CE000D2B
      B700011BB000021FB500010F9F00000000000000000000000000000000000000
      00000000000000000000035D05005BF7910005920D00035D0500000000000000
      000000000000000000000000000000000000000000000000000000000000004B
      00001CB1350011A422000C9C190011A02100004B000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000364005673F800021FD1000219AA0000036400000000000000
      00000000000000000000000000000000000000018700011CDC000120ED000017
      DC003655E200FFFFFF00A4B4ED000520BB000119B2008B9EE100FFFFFF004E6A
      CF000014AC00021EB200021CB000000389000000000000000000000000000000
      00000000000000000000035D05005BF7910006950F00035D0500000000000000
      0000000000000000000000000000000000000000000000000000004B00002EC6
      520024BC430013922400004B00000D931A000E9D1D00004B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000364005673F800021FD1000218A600000364000000
      00000000000000000000000000000000000000069A000120F800011FF600001D
      E900031FE100738BEE00FFFFFF00A0B1ED0093A5E700FFFFFF0091A4E2000823
      B400011BB000021DB100021FB400010895000000000000000000035D0500035D
      0500035D0500035D0500035D05005BF791000C9C1800035D0500035D0500035D
      0500035D0500035D0500000000000000000000000000004B000035CA5E0039D4
      65001CA13400004B000000000000004B00000A8615000F991C00004B00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000364005673F800021FD0000217A6000003
      640000000000000000000000000000000000020CAA000A2EFE000323FB00011F
      F600001CEB000018E100788FF000FFFFFF00FFFFFF0096A7EA00021BB5000019
      AF00021DB100021DB1000220B500010C990000000000035D05005BF791003BDA
      690030CF57002AC64D0021B83C0017A62B00119F21000D9E1C000A9A15000692
      0E0005930D00058B0D00035D0500000000000000000000000000004B000029B5
      4800004B000000000000000000000000000000000000004B00000C951800004B
      0000000000000000000000000000000000000000000000000000000000003C63
      CD000081BD00000000000000000000000000000364005673F800021FD0000216
      A70000036400000000000000000000000000040EAC00294DFE000D30FB00011F
      FA00001CF700011CEE008EA1F400FFFFFF00FFFFFF00A6B6EE000520C2000018
      B600021DB100021DB1000220B500010B980000000000035D05005BF791005BF7
      91005BF791005BF791005BF791005BF7910018A92F005BF791005BF791005BF7
      91005BF791005BF79100035D050000000000000000000000000000000000004B
      0000000000000000000000000000000000000000000000000000004B00000986
      1100004B00000000000000000000000000000000000000000000097CBF0000A6
      E60000A6E6000081BD00000000000000000000000000000364005673F8000111
      A00000309800005FB60000000000000000000208A0004162FB002F51FC00001E
      FA000725FA008AA0FE00FFFFFF008EA3F6007991F200FFFFFF00A3B4EE000C29
      C600011BB800021DB400021FB200000793000000000000000000035D0500035D
      0500035D0500035D0500035D05005BF7910025BC4200035D0500035D0500035D
      0500035D0500035D050000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000004B0000004B000000000000000000000000000000000000000000000081
      BD000081BD000000000000000000000000000000000000000000000364000049
      A90000C5FE000090CE000081BD000000000000018900314FEF007690FF000F2D
      FA003354FB00FFFFFF0091A5FE00021EF3000017E700738BF300FFFFFF004765
      E0000016C200021FBD00021CB200000288000000000000000000000000000000
      00000000000000000000035D05005BF7910030CE5700035D0500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000004B0000004B0000000000000000000000000000000000000000
      000000000000000000000081BD00000000000081BD0000000000000000000086
      D5000090CE0000C5FE000081BD0000000000000000000C1BBC00819AFF00728B
      FE001134FA003456FB000526FA00001CFA00001CF4000220ED003353ED000625
      DA00011DD0000220CB00010DA100000000000000000000000000000000000000
      00000000000000000000035D05005BF791003BD96800035D0500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000081BD000081BD000081BD0000000000000000000000
      00000081BD000081BD00000000000000000000000000000189002943E600A5B7
      FF00849AFC002341FB000323FA00011FFA00011FFA00001EF700011BEE00021F
      E5000121E2000118BF0000018400000000000000000000000000000000000000
      00000000000000000000035D05005BF7910048EB7F00035D0500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000081BD0000BAFB0000BDFF0000B1F2000081BD00000000000000
      000000000000000000000000000000000000000000000000000001038F002A45
      E60093A9FF00ABBBFF00758FFE004969FC003658FB003153FC002346FC00092C
      F7000118CB0000038B0000000000000000000000000000000000000000000000
      00000000000000000000035D05005BF791005BF79100035D0500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000081BD000081BD000081BD0000ADEE000087C4000081BD000081BD000000
      0000000000000000000000000000000000000000000000000000000000000001
      89000F1DBF003E5BF3006B87FE00728CFF005E7BFE00395BFB001231EB00010F
      B500000184000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000035D0500035D050000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000081BD0000ADEE000081BD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000018900030AA3000611B200050FB1000107A000000188000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000081BD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000043E9000043E9000043E9000043E9000043E9000043E90000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000824B4B004E1E1F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000992D0000992D000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000005B7000005B700000000000000000000000000034B
      B500034BB5000C5DCF004586CF006392C7005E8CBF003D73B40008479F00003A
      9900043E90000000000000000000000000000000000000000000000000000000
      0000824B4B00824B4B00A64B4B00A94D4D004E1E1F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000992D0000992D0000992D0000A66F3600AD794E00992D0000992D00007E1F
      000000000000000000000000000000000000000000000005B7000005B7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000005B7000005B700000000000000000000000000034BB500045B
      DE0077B1F000F6F4F600D9E6F000B7D3F000B5D0EE00CFDAE600DED9D5005580
      B0000241A400043E900000000000000000000000000000000000824B4B00824B
      4B00B64F5000C24F5000C54D4E00B24D4E004E1E1F00824B4B00824B4B00824B
      4B00824B4B00824B4B00824B4B000000000000000000923C0A00992D0000992D
      0000733F110098622500CF833400C6825500BC7F6400E79E5400B57A3E006C3C
      1900992D0000992D00000000000000000000000000000005B7000005B7000005
      B700000000000000000000000000000000000000000000000000000000000000
      00000005B7000005B700000000000000000000000000034BB400035BDE009ECA
      F800FFFFFF00589EEF001169E500025CE200025CE3001169E5005CA0EF00F8F4
      EF00809EBC000142A500043E9000000000000000000000000000824B4B00D458
      5900CB555600C9545500C9525300B74F52004E1E1F00FE8B8C00FB9A9C00F8AA
      AB00F7B5B600F7B5B600824B4B000000000000000000992D00007B553500AB80
      4E00CE925A00D98E4B00DC9A6600DAA07900BC7F6400E5AB7E00DC9C6B00E7A3
      6A008F7E4D00865C3E00992D0000992D0000000000000005B7000005B6000005
      B7000005B7000000000000000000000000000000000000000000000000000005
      B7000005B70000000000000000000000000000000000034BB5007AB5F600FEFE
      FF00287BE7000157E1000055E0000055E1000054E0000057E1000053E1003688
      ED00F8FAF6005B89BC00043E9000000000000000000000000000824B4B00D75C
      5D00D05A5B00CF595A00CF575800BD5356004E1E1F0023B54A0013C1480016BD
      48000CBC4100F7B5B600824B4B000000000000000000992D0000DDCAC600CF93
      7600D7956E00E5A97E00FFC78B00DDA07500BC7F6400FFD59E00F4D7CE009796
      7400035A05007E974F00DD9377008E2D050000000000000000000006D7000005
      BA000005B7000005B700000000000000000000000000000000000005B7000005
      B700000000000000000000000000000000000F6ADE001169DE00F8FBFF005A9F
      EF000159E100EAF3FE0088BCF3000058E1000662E200C1DDFA00C1DDFA000053
      E00064A6F200EEEAE700094FAF00043E90000000000000000000824B4B00DD63
      6400D75F6000D55E5F00D55C5D00C2575A004E1E1F002AB44D001CBF4C001EBC
      4C0013BC4500F7B5B600824B4B000000000000000000992D0000FCFEFF00C698
      8600F8BA7B00FFC18600FFC48400DC9F7400BC7F6400FFDCAC00C0CEA400035A
      05000A9D1D00035A05008F8047009A2D09000000000000000000000000000000
      00000005B7000005B7000005B600000000000005B6000005B7000005B7000000
      0000000000000000000000000000000000000F6ADE005EA5F200E9F3FC001674
      E7000565E500C5E0FA00FFFFFF0088BCF300C1DDFA00FFFFFF0088BCF3000054
      E0000F6AE500E3EEF7004787D100043E90000000000000000000824B4B00E368
      6900DD656600DA636400DE666700C6595B004E1E1F0026B1490016BC48001BBB
      490010BB4300F7B5B600824B4B000000000000000000992D0000FFFCFF00CF9D
      8A00FBBA7B00FEBD8200FFC28400DC9F7300BC7F6400FFE0B500035A05000A9D
      1D001EBC4C0030CC6300035A05008C2D05000000000000000000000000000000
      0000000000000005B6000006C7000006C7000006CE000005B400000000000000
      0000000000000000000000000000000000000F6ADE0082BCF600C9E3FB001176
      EA00096DE9001577EA00C7E2FB00FFFFFF00FFFFFF0088BCF3000058E1000055
      E100035CE200C4DDF80070A9E600043E90000000000000000000824B4B00EB6D
      6E00E2676800E67E7F00FAD3D400CC6E70004E1E1F00A5D8970050D16F0042C9
      66002DC75800F7B5B600824B4B000000000000000000992D0000FFFCFF00CA97
      8300FFBD8000FEBD8200FFC28400DC9F7300BC7F6400035A0500035A05001EBC
      4C0030CE64003ED76D0002560300035A05000000000000000000000000000000
      000000000000000000000006C1000005C1000006DA0000000000000000000000
      0000000000000000000000000000000000000F6ADE0089C4F700CBE6FC001A82
      EE00117AED001C81ED00C9E2FB00FFFFFF00FFFFFF0088BCF3000058E1000055
      E100035CE200C5DEFA0076B2F400043E90000000000000000000824B4B00F273
      7400E96C6D00EB818200FCD1D300CF6E70004E1E1F00FFF2CC00FFFFD700FFFF
      D400E6FCC700F7B5B600824B4B000000000000000000992D0000B5D9C000CA97
      8300EEB67D00FFC08400FFC28400DD9E7300BC7F6400FFE5BF00FFFCF600035A
      05003ED76D00035A0500E5916D00992A06000000000000000000000000000000
      0000000000000005B6000006D7000006CE000006DA000006E900000000000000
      0000000000000000000000000000000000000F6ADE0077BCF800EBF4FE003298
      F2001F8AF000CCE6FC00FFFFFF0096C7F700C7E2FB00FFFFFF0088BCF3000052
      E000106AE500E7F2FE00529EF400043E90000000000000000000824B4B00F878
      7900F0757600EE727300F0737400D16566004E1E1F00FCEFC700FFFFD500FFFF
      D300FFFFD700F7B5B600824B4B0000000000035A0500035A0500035A0500079D
      2300EEB67D00FFC18900FFC48700E0A17300BC7F6400FFEED000FFF8F000FFFB
      FE00035A05003ED76D00035A0500633905000000000000000000000000000000
      00000006E5000006DA000006D30000000000000000000006E5000006EF000000
      0000000000000000000000000000000000000F6ADE003599F300FBFEFF007FC5
      FA002996F400EFF8FF009ECFF800147BED001679EA00C6E1FB00C1DDFA00004F
      E00066A7EF00F8FCFF000D67E200043E90000000000000000000824B4B00FE7F
      8000F77A7B00F6797A00F7777900D76B6B004E1E1F00FCEFC700FFFFD500FFFF
      D300FFFFD500F7B5B600824B4B000000000000000000035A05003ED76D00035A
      0500238F2800F0B67F00FFD09300C78B6700B5837600FFF4DE00FFFBF400FFFF
      FF00DEBFBA00035A0500035A0500035A05000000000000000000000000000006
      F8000006DA000006EF00000000000000000000000000000000000006F8000006
      F60000000000000000000000000000000000000000000F6ADE00A4DCFC00FEFE
      FF005AB6F8002A99F4001D89F000167FEE000B70E9000768E700035BE2003584
      EA00FCFEFF0073B0F400034BB500000000000000000000000000824B4B00FF83
      8400FC7F8000FB7E7F00FE7F8000DA6E6F004E1E1F00FCEFC700FFFFD500FFFF
      D300FFFFD500F7B5B600824B4B0000000000000000007F4C2D00035A05003ED7
      6D00035A0500598A3500A1885600985953007A424400C4A09600FFFFFF00FFFF
      FF00DCBAB600FBBB8700F0A075009E2C060000000000000000000006F6000006
      F6000006F8000000000000000000000000000000000000000000000000000006
      F6000006F600000000000000000000000000000000000F6ADE0041AFFC00C5ED
      FF00FFFFFF0081C7FA00369CF4001E87EF00137AEA001878E9005EA3F000FFFF
      FF009ECAF800035BDE00034BB500000000000000000000000000824B4B00FF88
      8900FF828300FF818200FF828300E07374004E1E1F00FCEFC700FFFFD500FFFF
      D300FFFFD500F7B5B600824B4B0000000000035A0500025603003ED76D0030CE
      64001EBC4C00035A0500035A050000000000000000007A414100BF9F9E00F6F0
      F200DCC5BC00F4BA7F00DEA06D00912E0500000000000006F6000006F6000006
      F600000000000000000000000000000000000000000000000000000000000000
      0000000000000006F600000000000000000000000000000000000F6ADE0045B4
      FE00A7DEFF00FFFFFF00E9F6FE00CCE7FB00CAE5FB00E6F2FC00FFFFFF0070AF
      F400045BDE00034BB50000000000000000000000000000000000824B4B00824B
      4B00E2757600FE818200FF868700E57677004E1E1F00FAEBC500FCFBD100FCFB
      CF00FCFBD100F7B5B600824B4B000000000000000000035A050030CC63001EBC
      4C000A9D1D00035A0500000000000000000000000000000000007A414100BC9D
      9E00BA939100D89F7500BD805E008C2B05000006F6000006F6000006F6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000F6A
      DE000F6ADE003AA0F60076BFFA008EC7F80087C0F6005CA5F2000F6AE000034B
      B500034BB5000000000000000000000000000000000000000000000000000000
      0000824B4B009C565700CB6C6D00CF6E6E004E1E1F00824B4B00824B4B00824B
      4B00824B4B00824B4B00824B4B00000000000000000000000000035A05000A9D
      1D00035A05000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000006F6000006F600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000F6ADE000F6ADE000F6ADE000F6ADE000F6ADE000F6ADE000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000824B4B00824B4B004E1E1F0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000035A
      0500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A6696B00A6696B00A669
      6B00A6696B00A6696B00A6696B00A6696B000000000000000000000000000000
      00000000000000000000000000000000000000000000A6696B00A6696B00A669
      6B00A6696B00A6696B00A6696B00A6696B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A6696B00F3D3A400F0CB
      9700EFC68A00EDC18000EBBB7600A6696B000000000000000000000000000000
      00000000000000000000000000000000000000000000A6696B00F3D3A400F0CB
      9700EFC68A00EDC18000EBBB7600A6696B000000000000000000000000000000
      0000BD4C00000000000000000000000000008424050084240500842405008424
      0500842405000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A7756B00F6DDBA00707B
      CE000F2EF3006E75BF00EEC48400A6696B000000000000000000000000000000
      00000000000000000000000000000000000000000000A7756B00F6DDBA00707B
      CE000F2EF3006E75BF00EEC48400A6696B000000000000000000000000000000
      0000BD4C0000BD4C0000BD4C0000C24F000084240500FFC17900E58E4000D36E
      1A00842405000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000035A910002416A0004548600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BC826800F8E7CE000F30
      F700001EFF000F2FF300F0CC9600A6696B000000000000000000000000000000
      00000000000000000000000000000000000000000000BC826800F8E7CE000F30
      F700001EFF000F2FF300F0CC9600A6696B000000000000000000000000000000
      0000BD4C00000000000000000000000000008323040084240500842305008323
      0400842405000000000000000000000000000000000000000000000000000000
      0000000000000000000002558E002882A50053392400091114000B5B88000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D1926D00FBF2E2007486
      E7000F30F800727FD700F3D7AB00A6696B000000000000000000000000000000
      00000000000000000000000000000000000000000000D1926D00FBF2E2007486
      E7000F30F800727FD700F3D7AB00A6696B000000000000000000000000000000
      0000BD4C00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000002558E001CBFFF003692AD00FFCF890062442D000D2433000000
      000000386C0000386C0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DA9D7500FEFAF300FBF4
      E700FAEEDC00F8E7CF00F6E1C000A6696B000000000000000000000000000000
      00000000000000000000000000000000000000000000DA9D7500FEFAF300FBF4
      E700FAEEDC00F8E7CF00F6E1C000A6696B000000000000000000000000000000
      0000BD4C00000000000000000000000000008424050084240500842405008424
      0500842405000000000000000000000000000000000000000000000000000255
      8E001BADEB001697D5003FC5FE005DBAE000DAA97600CB925E00161D23000E60
      960000386C0000386C00033E6400000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7AB7900FFFFFF00FEFB
      F800FCF7EE00A6696A00A6696A00AC6C5A000000000000000000000000000000
      00000000000000000000000000000000000000000000E7AB7900FFFFFF00FEFB
      F800FCF7EE00A6696A00A6696A00AC6C5A000000000000000000000000000000
      0000BD4C0000BD4C0000BD4C0000BD4C000084240500FFC17900E58E4000D36E
      1A0084240500000000000000000000000000000000000000000002558E002BC2
      FE0051D4FF0041A0D00099D3EF00EDFFFF00D4D0C900836E580018445B0044AB
      DE004AADD700695A46000A0A0900013B6500A4676900A4676900A4676900A467
      6900A4676900A4676900A4676900A467690000000000E7AB7900FFFFFF00FFFF
      FF00FEFCFB00A6696A00C67F4E0000000000A4676900A4676900A4676900A467
      6900A4676900A4676900A4676900A467690000000000E7AB7900FFFFFF00FFFF
      FF00FEFCFB00A6696A00C67F4E00000000000000000000000000000000000000
      0000BD4C00000000000000000000000000008323040084240500842305008323
      040084240500000000000000000000000000046099001680B8005CD3FF008CDD
      FF00C1EDFF00D0EBF7004093B8009DCCE20072BBDD002182B6000C96CF0031C2
      FF001AA5E000C2AC8600623C230000243D00A4676900E9C49D00D8A57B00D8A3
      7300D59D6600D1965A00EAB66C00A467690000000000E7AB7900D1926D00D192
      6D002A702700A6696A000000000000000000A4676900E9C49D00D8A57B00D8A3
      7300D59D6600D1965A00EAB66C00A467690000000000E7AB7900D1926D00D192
      6D00D1926D00A6696A0000000000005901000000000000000000000000000000
      0000BD4C00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000351880002558E00BFE5F700F8FF
      FF00EEFBFF00D0F2FF0045ABD700027FB6000075AA00006FA5000493C9001FB7
      F8001EC1FF0064A5AD0072503300002A4700A4676900BB7650007D180000821F
      0000811F0000811E0000DCA16200A4676900000000000000000000000000015A
      06002CC558001C9631000000000000000000A4676900BB7650007D180000821F
      0000811F0000811E0000DCA16200A467690000000000000000002D6718000000
      0000000000000000000000000000016405000000000000000000000000000000
      0000BD4C00000000000000000000000000008424050084240500842405008424
      05008424050000000000000000000000000002558E00AAD0E30002558E008AC5
      DE007ACEF40057D0FF0039CAFF001EAFED000B84C0000173AA000089BC000FA1
      DC0021BCFB00129DDD000C4B6D0000447600A7756B00F6E9DD008A2A08007F1A
      00007B160000AB5B3000FCDD9F00A46769000000000000000000005D030030BD
      570041E0750022B63E000875110000000000A7756B00F6E9DD008A2A08007F1A
      00007B160000AB5B3000FCDD9F00A467690000000000005D0300067F14000000
      0000000000000000000001770700036506000000000000000000000000000000
      0000BD4C0000BD4C0000BD4C0000BD4C000084240500FFC17900E58E4000D36E
      1A00842405000000000000000000000000000000000002558E0002558E000255
      8E00148AC5001498D7001CB1F20021BAFA001FB4F40017A1E0000774AC000057
      8A0006609A00000000000000000000000000BC826800FFFFFF00C99379007914
      000089290700E6BD9900FFEAB500A4676900000000002D671800067F14001A92
      2F0027BB4500149A26000C88160003630700BC826800FFFFFF00C99379007914
      000089290700E6BD9900FFEAB500A4676900015A060030BD57001A922F000155
      03000360070004780A0005840C00015804000000000000000000000000000000
      0000BD4C00000000000000000000000000008323040084240500842305008323
      0400842405000000000000000000000000000000000000000000000000000000
      000000000000056BA50004649E00087AB5000474AF0000518800000000000000
      000000000000000000000000000000000000D1926D00FFFFFF00FBF4F2009941
      1E00BF7D5900FAEDD400D4BCA000A46769000000000000000000000000000155
      030015A5280005700B000000000000000000D1926D00FFFFFF00FBF4F2009941
      1E00BF7D5900FAEDD400D4BCA0002A7027002CC5580041E0750027BB450015A5
      280009961300058C0D0002660600000000000000000000000000842405008424
      0500842405008424050084240500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DA9D7500FFFFFF00FFFFFF00E7D0
      C400F7EEE300A4676900A4676900A46A5A000000000000000000000000000360
      070009961300036C07000000000000000000DA9D7500FFFFFF00FFFFFF00E7D0
      C400F7EEE300A4676900A4676900A46A5A001C96310022B63E00149A26000570
      0B00036C0700026005000000000000000000000000000000000084240500FFC1
      7900E58E4000D36E1A0084240500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7AB7900FFFFFF00FFFFFF00FFFF
      FF00FCFFFF00A4676900D1864900000000000000000000000000036E07000478
      0A00058C0D00026005000000000000000000E7AB7900FFFFFF00FFFFFF00FFFF
      FF00FCFFFF00A4676900D18649000000000000000000087511000C8816000000
      0000000000000000000000000000000000000000000000000000832304008424
      0500842305008323040084240500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7AB7900D1926D00D1926D00D192
      6D00D1926D00A467690000000000000000000266060002660600017707000584
      0C0002660600000000000000000000000000E7AB7900D1926D00D1926D00D192
      6D00D1926D00A467690000000000000000000000000000000000036307000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000274AC000274AC000274
      AC000274AC000274AC000274AC000274AC000274AC000274AC000274AC000274
      AC000274AC000274AC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC00138AC40057B7E0006BCB
      F8004BBFF7004ABFF7004ABFF7004ABFF7004ABFF6004ABFF7004ABFF6004BC0
      F7002398CC000274AC00000000000000000000000000000000007F2B28007F2B
      2800A1828300A1828300A1828300A1828300A1828300A1828300A18283007A1C
      1C007F2B28000000000000000000000000000566950005669500000000000000
      0000000000000000000000000000056695000566950005669500056695000566
      9500056695000566950000000000000000000566950005669500000000000566
      9500056695000566950000000000000000000000000000000000000000000566
      9500056695000566950000000000000000000274AC0033AAE0002392C40089D9
      FA0054C7F80054C7F70053C7F80054C7F70054C7F80054C7F80054C7F80053C7
      F700279DCE006ACBE5000274AC0000000000000000007F2B2800CA4D4D00B645
      4500DDD4D5007916170079161700DCE0E000D7DADE00CED5D700BDBABD007610
      0F009A2D2D007F2B2800000000000000000005669500359FD5000D6F9D000000
      0000162830000000000016283000155F81009FD4EE00A1D1EB00026290005DA9
      CB00ACD8F000056695000000000000000000056695002F98CE000D6F9D002280
      AA008BC4E2000566950000000000162830000000000016283000000000000566
      95008CC5E3000566950000000000000000000274AC0057CAF8000274AC0099E3
      FB005ED1FA005ED1FA005ED1FA005ED1FA005ED1FA005FD1FA005ED1F8005ED1
      F8002CA1CE0099EDF7000274AC0000000000000000007F2B2800C24A4B00B144
      4400E2D9D9007916170079161700D9D8DA00D9DEE100D3D9DC00C1BDC1007611
      1100982D2D007F2B280000000000000000000566950073C0E7003596C1004E68
      7200395662001B4458002C4F6000167DAD00B6DDF000BDE1F300015F90007FBB
      D700E7F7FE000566950000000000000000000566950060B7E3002B88B200348C
      B100C7E5F400056695004E687200415966002A51660029485900294859000566
      9500F0FBFF000566950000000000000000000274AC005ED3FA000B81B70082D5
      EF0079E0FA006ADCFA0069DCFB0069DCFB006ADCFB0069DCFB0069DCFA006ADD
      FB002FA6CF009FF0F7000274AC0000000000000000007F2B2800C24A4A00B042
      4200E6DCDC007916170079161700D5D3D500D8DEE100D7DDE000C6C2C500700F
      0F00962C2C007F2B2800000000000000000005669500A9D3E600056695001628
      300000000000162830000000000005699A005FB5E00005669500026290000566
      950073C2EB0005669500000000000000000005669500C0E1F2001978A3000F72
      9F006DBCE3000566950016283000000000001628300000000000162830000566
      950083CBEF000566950000000000000000000274AC0068DAFB002BA4D1004AB2
      D70097EBFC0074E5FB0074E5FB0074E5FC0074E5FC0074E5FB0074E5FC00046B
      0B0033A9CF00A3F4F70052BBD7000274AC00000000007F2B2800C24A4A00B041
      4100EADEDE00E7DDDD00DDD4D500D7D3D500D5D7D900D7D8DA00CAC2C5007E17
      17009E3131007F2B280000000000000000000566950001609000000000000000
      000000000000000000001075A50049A1CB000566950000000000000000000000
      00000566950045A0CC0005669500000000000566950008689600096A99003D99
      C500298EBD000566950000000000000000000000000000000000000000000668
      9700258BBC003C9AC90005669500000000000274AC0070E3FB005CD1EF001184
      B600FCFFFF00B8F4FE00BAF4FE00BAF4FE00BAF4FE00B8F4FE00046B0B0025AA
      4200046B0B00D4F7FA00CAF3F7000274AC00000000007F2B2800BF474800B845
      4500BA4C4C00BD575700BB575600B64E4E00B4494900BD525100BB4B4C00B542
      4200BF4A4A007F2B280000000000000000000000000000000000000000000000
      00000000000005669500A6D4E700056695000000000000000000000000000000
      000000000000056695009DCFE6000566950000000000056695008AC4DE004197
      BD00000000000000000000000000000000000000000000000000000000000000
      0000046492002987B20082C1DD00056695000274AC007AEBFE007AEBFC000A7F
      B5000274AC000274AC000274AC000274AC000274AC00046B0B0038CE650047E7
      7F0029B44A00046B0B000274AC000274AC00000000007F2B2800A33B3900B160
      5D00C6868400CB918F00CC919000CC908F00CB898800C9898800CB939100CC96
      9600BD4B4C007F2B280000000000000000000000000000000000000000000000
      00000000000005669500CAE5EE000566950000000000A4676900A4676900A467
      69000000000000649700D1E9F000056695000000000005669500CFE7F0000566
      950000000000A4676900A4676900A4676900A4676900A4676900A4676900A467
      69000000000005669500D4EAF200056695000274AC0083F2FE0082F3FE0082F3
      FE0083F2FC0083F3FE0082F3FE0083F2FE00046B0B002DC051003FDC6E003ED8
      6E0046E57B0028B04A00046B0B0000000000000000007F2B2800BD4B4C00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700BD4B4C007F2B280000000000000000000000000000000000000000000000
      00000000000005669500B2DCEA000566950000000000A4676900EDC79500A467
      69000000000000669800BDE1ED00056695000000000005669500B7DDEA000566
      950000000000A4676900FFEFCB00F6DAB000F3D09C00EEC78800F8D08200A467
      69000000000005669500C1E2EE00056695000274AC00FEFEFE0089FAFF0089FA
      FE0089FAFE008AF8FE008AFAFE00046B0B00046B0B00046B0B00046B0B003CD8
      6A002EBF5300046B0B00046B0B00046B0B00000000007F2B2800BD4B4C00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700BD4B4C007F2B280000000000000000000000000000000000000000000000
      00000000000005669500A4D7E6000566950000000000A4676900F8E0AD00A467
      69000000000000669800ACDAEA00056695000000000005669500A5D7E7000566
      950000000000A4676900FFEFCB00F6DAB000F3D09C00EEC78800F8D08200A467
      69000000000005669500AFDAEA0005669500000000000274AC00FEFEFE008FFE
      FF008FFEFF008FFEFF000273A3002BA4D1002BA4D1002BA4D100046B0B0035D3
      5E0020A73A00046B0B000000000000000000000000007F2B2800BD4B4C00F7F7
      F700BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00F7F7
      F700BD4B4C007F2B280000000000000000000000000000000000000000000000
      00000000000005669500ADDCEB000566950000000000A7756B00FBE6C000A467
      69000000000000669800B0DDEB00056695000000000005669500AADAEA000566
      950000000000A7756B00FCEFD900F3DDC100F0D4AD00EDCA9900F4CE8A00A467
      69000000000005669500AFDCEA000566950000000000000000000274AC000274
      AC000274AC000274AC0000000000000000000000000000000000046B0B0028C2
      4A00046B0B00000000000000000000000000000000007F2B2800BD4B4C00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700BD4B4C007F2B280000000000000000000000000000000000000000000000
      000000000000056695005CAAC6000566950000000000BC826800FFEFD700A467
      69000000000002699C0083C1D80005669500000000000768970077BBD3000566
      950000000000BC826800FFF8F200F8E7D700F4DDC100F2D3AD00FBD9A000A467
      6900000000000566950096CEE000056695000000000000000000000000000000
      00000000000000000000000000000000000000000000046B0B0017A42B0019A7
      3000046B0B00000000000000000000000000000000007F2B2800BD4B4C00F7F7
      F700BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00F7F7
      F700BD4B4C007F2B280000000000000000000000000000000000000000000000
      00000000000000000000056695000566950000000000D1926D00FFFCEE00A467
      69000000000005679700096B9900000000000000000000000000056695000566
      950000000000D1926D00FFFFFF00FCF3ED00F8E7D400FAE3C600F0D9B100A467
      6900000000000566950005669500000000000000000000000000000000000000
      00000000000000000000000000000000000000000000046B0B0011A12200046B
      0B0000000000000000000000000000000000000000007F2B2800BD4B4C00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700BD4B4C007F2B280000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DA9D7500F2E7E100A56B
      5F00000000000000000000000000000000000000000000000000000000000000
      000000000000DA9D7500FFFFFF00FFFFFE00FEF8F200A56B5F00A56B5F00A56B
      5F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000046B0B00046B0B00046B0B00046B0B000000
      00000000000000000000000000000000000000000000000000007F2B2800F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F7007F2B28000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7AB7900C07849000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7AB7900FFFFFF00FFFFFF00FFFFFF00A56B5F00C07849000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000046B0B00046B0B00046B0B00046B0B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D1926D00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7AB7900D1926D00D1926D00D1926D00A56B5F00000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F81FFFFFFFFFF3FFE007FE7FFFFFE1FF
      C003FC3FF9FFE0FF8001FC3FF0FFF07F8001FC3FE07FF83F0000FC3FC03FFC1F
      0000C003821FFE0F00008001C78FE70700008001EFC7C3830000C003FFF3E7C1
      0000FC3FFFF9FD618001FC3FFFFFFC738001FC3FFFFFF83FC003FC3FFFFFF01F
      E007FE7FFFFFFC7FF81FFFFFFFFFFEFFF81FFE7FFE7FFFFCE007F07FF00F9FF9
      C003C00180038FF38001C001800087E78001C0018000C3CF0000C0018000F11F
      0000C0018000F83F0000C0018000FC7F0000C0018000F83F0000C0010000F19F
      0000C0018000E3CF8001C0018000C7E78001C00101808FFBC003C00183C01FFF
      E007F001C7FF3FFFF81FFC7FEFFFFFFFFF80FF80FFFFFFFFFF80FF80F707FFFF
      FF80FF80F007FE3FFF80FF80F707FC1FFF80FF80F7FFF813FF80FF80F707E001
      FF80FF80F007C00000810081F707000000830082F7FF000000E300DEF7070000
      00C1009CF007800700800000F707F83F00E30001C1FFFFFF00E30003C1FFFFFF
      01C3019FC1FFFFFF030703DFFFFFFFFF8003FFFFFFFFFFFF0003C0073E0323E3
      00018003140302A30001800300030003000180030A030143000080033C7103E1
      00008003F8F88FF000008003F888880800018003F888880800008003F8888808
      80038003F8888808C3C78003F8888808FF878003FC89C809FF8F8003FF8FF80F
      FE1FC007FF9FF81FF87FFFFFFFBFF83F00000000000000000000000000000000
      000000000000}
  end
  object odPapyrus: TOpenDialog
    Filter = 
      'ESS file (*.ESS)|*.ESS|Papyrus Export (*.BIN)|*.BIN|All files (*' +
      '.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 200
  end
  object sdCSVSave: TSaveDialog
    DefaultExt = 'CSV'
    Filter = 'CSV files (*.csv)|*.csv|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 168
  end
end
