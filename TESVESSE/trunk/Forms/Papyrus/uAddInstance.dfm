object fAddInstance: TfAddInstance
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add Instance'
  ClientHeight = 525
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poNone
  Scaled = False
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  DesignSize = (
    449
    525)
  PixelsPerInch = 96
  TextHeight = 13
  object bvInstanceDefinition: TBevel
    Left = 107
    Top = 16
    Width = 333
    Height = 4
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object bvInstanceData: TBevel
    Left = 88
    Top = 152
    Width = 352
    Height = 4
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object bvEnd: TBevel
    Left = 8
    Top = 480
    Width = 432
    Height = 4
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object stScript: TStaticText
    Left = 8
    Top = 62
    Width = 80
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Script:'
    FocusControl = cbScript
    TabOrder = 0
  end
  object cbScript: TComboBox
    Left = 95
    Top = 59
    Width = 335
    Height = 21
    AutoComplete = False
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    DropDownCount = 32
    ItemHeight = 13
    TabOrder = 1
  end
  object lvMembers: TListView
    Left = 13
    Top = 258
    Width = 417
    Height = 150
    Anchors = [akLeft, akTop, akRight]
    Columns = <
      item
        Caption = 'No'
      end
      item
        Caption = 'Type'
        Width = 100
      end
      item
        Caption = 'Data'
        Width = 125
      end
      item
        Caption = 'Reference'
        Width = -2
        WidthType = (
          -2)
      end>
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
    OnSelectItem = lvMembersSelectItem
  end
  object stMembers: TStaticText
    Left = 13
    Top = 232
    Width = 80
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Parameters:'
    TabOrder = 3
  end
  object stCount: TStaticText
    Left = 99
    Top = 232
    Width = 331
    Height = 17
    AutoSize = False
    Caption = '0'
    TabOrder = 4
  end
  object stMData: TStaticText
    Left = 200
    Top = 418
    Width = 71
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Data:'
    FocusControl = edMData
    TabOrder = 5
  end
  object edMData: TEdit
    Left = 277
    Top = 415
    Width = 153
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 8
    TabOrder = 6
    Text = '0'
    OnKeyPress = edKeyPress
  end
  object stMType: TStaticText
    Left = 13
    Top = 415
    Width = 49
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Type:'
    FocusControl = cbMType
    TabOrder = 7
  end
  object cbMType: TComboBox
    Left = 68
    Top = 414
    Width = 125
    Height = 21
    AutoComplete = False
    Style = csDropDownList
    DropDownCount = 32
    ItemHeight = 13
    TabOrder = 8
  end
  object stInstanceID: TStaticText
    Left = 8
    Top = 35
    Width = 80
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Instance ID:'
    FocusControl = meInstanceID
    TabOrder = 9
  end
  object meInstanceID: TMaskEdit
    Left = 95
    Top = 32
    Width = 118
    Height = 21
    EditMask = 'AA AA AA AA;1;_'
    MaxLength = 11
    TabOrder = 10
    Text = '           '
    OnEnter = meInstanceIDEnter
    OnExit = meInstanceIDExit
    OnKeyPress = meInstanceIDKeyPress
  end
  object stIDExists: TStaticText
    Left = 221
    Top = 36
    Width = 130
    Height = 17
    Caption = 'Instance ID already exists'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    Visible = False
  end
  object edUnknow1: TEdit
    Left = 95
    Top = 86
    Width = 121
    Height = 21
    TabOrder = 12
    Text = '0'
    OnKeyPress = edKeyPress
  end
  object stUnknow1: TStaticText
    Left = 8
    Top = 89
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Unknow 1:'
    FocusControl = edUnknow1
    TabOrder = 13
  end
  object stUnknow2: TStaticText
    Left = 222
    Top = 90
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Unknow 2:'
    FocusControl = edUnknow2
    TabOrder = 14
  end
  object edUnknow2: TEdit
    Left = 309
    Top = 87
    Width = 121
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 15
    Text = '0'
    OnKeyPress = edKeyPress
  end
  object stRefID: TStaticText
    Left = 8
    Top = 116
    Width = 80
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Ref ID:'
    FocusControl = meRefID
    TabOrder = 16
  end
  object meRefID: TMaskEdit
    Left = 95
    Top = 113
    Width = 120
    Height = 21
    EditMask = 'AA AA AA;1;_'
    MaxLength = 8
    TabOrder = 17
    Text = '        '
    OnKeyPress = meInstanceIDKeyPress
  end
  object stUsed: TStaticText
    Left = 222
    Top = 116
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Used:'
    FocusControl = edUsed
    TabOrder = 18
  end
  object edUsed: TEdit
    Left = 309
    Top = 113
    Width = 121
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 19
    Text = '0'
    OnKeyPress = edKeyPress
  end
  object stInstanceDefinition: TStaticText
    Left = 8
    Top = 9
    Width = 93
    Height = 17
    Caption = 'Instance definition'
    TabOrder = 20
  end
  object stInstanceData: TStaticText
    Left = 8
    Top = 145
    Width = 71
    Height = 17
    Caption = 'Instance data'
    TabOrder = 21
  end
  object stFlag: TStaticText
    Left = 8
    Top = 171
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Flag:'
    FocusControl = edFlag
    TabOrder = 22
  end
  object edFlag: TEdit
    Left = 95
    Top = 168
    Width = 121
    Height = 21
    TabOrder = 23
    Text = '0'
    OnKeyPress = edKeyPress
  end
  object stReference: TStaticText
    Left = 222
    Top = 172
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Reference:'
    FocusControl = edReference
    TabOrder = 24
  end
  object edReference: TEdit
    Left = 309
    Top = 169
    Width = 121
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 25
    Text = '0'
    OnKeyPress = edKeyPress
  end
  object stData1: TStaticText
    Left = 8
    Top = 197
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Data 1:'
    FocusControl = edData1
    TabOrder = 26
  end
  object edData1: TEdit
    Left = 95
    Top = 194
    Width = 121
    Height = 21
    TabOrder = 27
    Text = '0'
    OnKeyPress = edKeyPress
  end
  object stData2: TStaticText
    Left = 222
    Top = 198
    Width = 81
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Data 2:'
    FocusControl = edData2
    TabOrder = 28
  end
  object edData2: TEdit
    Left = 309
    Top = 195
    Width = 121
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 29
    Text = '0'
    OnKeyPress = edKeyPress
  end
  object edMReference: TEdit
    Left = 277
    Top = 442
    Width = 153
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 30
    Text = '0'
    OnKeyPress = edKeyPress
  end
  object stMReference: TStaticText
    Left = 200
    Top = 445
    Width = 71
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Reference:'
    FocusControl = edMReference
    TabOrder = 31
  end
end
