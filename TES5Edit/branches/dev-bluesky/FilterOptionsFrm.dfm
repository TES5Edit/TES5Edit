object frmFilterOptions: TfrmFilterOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = '筛选...'
  ClientHeight = 636
  ClientWidth = 927
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object clbConflictAll: TCheckListBox
    Left = 30
    Top = 24
    Width = 318
    Height = 113
    BevelKind = bkTile
    BevelWidth = 3
    BorderStyle = bsNone
    ItemHeight = 13
    ParentColor = True
    PopupMenu = pmuSelection
    TabOrder = 0
  end
  object clbConflictThis: TCheckListBox
    Left = 30
    Top = 172
    Width = 318
    Height = 141
    BevelKind = bkTile
    BevelWidth = 3
    BorderStyle = bsNone
    ItemHeight = 13
    ParentColor = True
    PopupMenu = pmuSelection
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 844
    Top = 603
    Width = 75
    Height = 25
    Caption = '取消'
    DoubleBuffered = True
    Kind = bkCancel
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 763
    Top = 603
    Width = 75
    Height = 25
    Caption = '开始'
    DoubleBuffered = True
    Kind = bkOK
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 3
  end
  object cbInherit: TCheckBox
    Left = 354
    Top = 590
    Width = 279
    Height = 17
    Caption = '继承自父系的冲突状态'
    TabOrder = 4
  end
  object cbConflictAll: TCheckBox
    Left = 8
    Top = 1
    Width = 329
    Height = 17
    Caption = '根据全局的冲突状态（这边决定背景颜色）'
    TabOrder = 5
  end
  object cbConflictThis: TCheckBox
    Left = 8
    Top = 149
    Width = 361
    Height = 17
    Caption = 
      '根据特定记录的冲突状态（这边决定文本颜色）'
    TabOrder = 6
  end
  object cbByInjectionStatus: TCheckBox
    Left = 8
    Top = 339
    Width = 145
    Height = 17
    Caption = '根据注入状态'
    TabOrder = 7
  end
  object cbInjected: TCheckBox
    Left = 23
    Top = 354
    Width = 139
    Height = 17
    Caption = '仅被注入'
    TabOrder = 8
  end
  object cbByNotReachableStatus: TCheckBox
    Left = 168
    Top = 377
    Width = 193
    Height = 17
    Caption = '根据不可用状态'
    TabOrder = 9
  end
  object cbNotReachable: TCheckBox
    Left = 185
    Top = 400
    Width = 163
    Height = 17
    Caption = '仅不可用'
    TabOrder = 10
  end
  object cbByReferencesInjectedStatus: TCheckBox
    Left = 168
    Top = 339
    Width = 193
    Height = 17
    Caption = '根据引用被注入状态'
    TabOrder = 11
  end
  object cbReferencesInjected: TCheckBox
    Left = 182
    Top = 354
    Width = 187
    Height = 17
    Caption = '仅被注入的引用'
    TabOrder = 12
  end
  object cbByEditorID: TCheckBox
    Left = 8
    Top = 377
    Width = 154
    Height = 17
    Caption = 'EditorID 包含'
    TabOrder = 13
  end
  object cbByName: TCheckBox
    Left = 8
    Top = 427
    Width = 161
    Height = 17
    Caption = '名字包含'
    TabOrder = 14
  end
  object edEditorID: TEdit
    Left = 30
    Top = 400
    Width = 132
    Height = 21
    TabOrder = 15
  end
  object edName: TEdit
    Left = 30
    Top = 450
    Width = 132
    Height = 21
    TabOrder = 16
  end
  object clbRecordSignatures: TCheckListBox
    Left = 375
    Top = 24
    Width = 258
    Height = 560
    BevelKind = bkTile
    BevelWidth = 3
    BorderStyle = bsNone
    ItemHeight = 13
    ParentColor = True
    PopupMenu = pmuSelection
    TabOrder = 17
  end
  object cbRecordSignature: TCheckBox
    Left = 354
    Top = 1
    Width = 281
    Height = 17
    Caption = '根据记录签名'
    TabOrder = 18
  end
  object cbByPersistent: TCheckBox
    Left = 8
    Top = 475
    Width = 145
    Height = 17
    Caption = '根据 persistence'
    TabOrder = 19
  end
  object cbPersistent: TCheckBox
    Left = 23
    Top = 498
    Width = 156
    Height = 17
    Caption = '仅 persistent'
    TabOrder = 20
  end
  object cbUnnecessaryPersistent: TCheckBox
    Left = 38
    Top = 521
    Width = 307
    Height = 17
    Caption = '仅可能但不必要的 persistent'
    TabOrder = 21
  end
  object cbMasterIsTemporary: TCheckBox
    Left = 54
    Top = 544
    Width = 187
    Height = 17
    Caption = '仅当 Master 不是 persistent'
    TabOrder = 22
  end
  object cbByVWD: TCheckBox
    Left = 168
    Top = 427
    Width = 180
    Height = 17
    Caption = '根据远景可见'
    TabOrder = 23
  end
  object cbVWD: TCheckBox
    Left = 185
    Top = 450
    Width = 176
    Height = 17
    Caption = '仅远景可见'
    TabOrder = 24
  end
  object cbIsMaster: TCheckBox
    Left = 220
    Top = 544
    Width = 130
    Height = 17
    Caption = '或者当对象是 master'
    TabOrder = 25
  end
  object cbPersistentPosChanged: TCheckBox
    Left = 38
    Top = 567
    Width = 307
    Height = 17
    Caption = '仅当方位/角度发生变化'
    TabOrder = 26
  end
  object cbBaseRecordSignature: TCheckBox
    Left = 642
    Top = 1
    Width = 281
    Height = 17
    Caption = '根据基本记录签名'
    TabOrder = 27
  end
  object clbBaseRecordSignatures: TCheckListBox
    Left = 663
    Top = 24
    Width = 258
    Height = 466
    BevelKind = bkTile
    BevelWidth = 3
    BorderStyle = bsNone
    ItemHeight = 13
    ParentColor = True
    PopupMenu = pmuSelection
    TabOrder = 28
  end
  object cbByBaseEditorID: TCheckBox
    Left = 639
    Top = 496
    Width = 234
    Height = 17
    Caption = '基本记录 EditorID 包含'
    TabOrder = 29
  end
  object edBaseEditorID: TEdit
    Left = 661
    Top = 519
    Width = 132
    Height = 21
    TabOrder = 30
  end
  object cbByBaseName: TCheckBox
    Left = 639
    Top = 552
    Width = 234
    Height = 17
    Caption = '基本记录名字包含'
    TabOrder = 31
  end
  object edBaseName: TEdit
    Left = 661
    Top = 575
    Width = 139
    Height = 21
    TabOrder = 32
  end
  object cbByHasVWDMesh: TCheckBox
    Left = 168
    Top = 473
    Width = 201
    Height = 17
    Caption = '根据是否含远景模型'
    TabOrder = 33
  end
  object cbHasVWDMesh: TCheckBox
    Left = 185
    Top = 496
    Width = 184
    Height = 17
    Caption = '仅含远景模型'
    TabOrder = 34
  end
  object cbFlattenBlocks: TCheckBox
    Left = 8
    Top = 590
    Width = 165
    Height = 17
    Caption = '简化 Blocks/Sub-Blocks 显示'
    TabOrder = 35
  end
  object cbFlattenCellChilds: TCheckBox
    Left = 185
    Top = 590
    Width = 157
    Height = 17
    Caption = '简化 Cell Children 显示'
    TabOrder = 36
  end
  object cbAssignPersWrldChild: TCheckBox
    Left = 204
    Top = 613
    Width = 277
    Height = 17
    Caption = '分配 Persistent Worldspace Children 到 Cells'
    TabOrder = 37
  end
  object cbScaledActors: TCheckBox
    Left = 639
    Top = 602
    Width = 95
    Height = 17
    Caption = '含 scale 的角色'
    TabOrder = 38
  end
  object cbDeleted: TCheckBox
    Left = 8
    Top = 319
    Width = 145
    Height = 17
    Caption = 'deleted'
    TabOrder = 39
  end
  object pmuSelection: TPopupMenu
    Left = 320
    Top = 64
    object mniSelectAll: TMenuItem
      Caption = '全部'
      OnClick = mniSelectionClick
    end
    object mniSelectNone: TMenuItem
      Caption = '全不'
      OnClick = mniSelectionClick
    end
    object mniInvertSelection: TMenuItem
      Caption = '反选'
      OnClick = mniSelectionClick
    end
  end
end
