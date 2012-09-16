object frmFilterOptions: TfrmFilterOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Filter...'
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
    Height = 161
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
    TabOrder = 2
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 763
    Top = 603
    Width = 75
    Height = 25
    Caption = 'Filter'
    TabOrder = 3
    Kind = bkOK
  end
  object cbInherit: TCheckBox
    Left = 354
    Top = 590
    Width = 279
    Height = 17
    Caption = 'Conflict status inherited by parent'
    TabOrder = 4
  end
  object cbConflictAll: TCheckBox
    Left = 8
    Top = 1
    Width = 329
    Height = 17
    Caption = 'by conflict status overall (that'#39's the background color)'
    TabOrder = 5
  end
  object cbConflictThis: TCheckBox
    Left = 8
    Top = 149
    Width = 361
    Height = 17
    Caption = 
      'by conflict status for this particular record  (that'#39's the text ' +
      'color)'
    TabOrder = 6
  end
  object cbByInjectionStatus: TCheckBox
    Left = 8
    Top = 339
    Width = 145
    Height = 17
    Caption = 'by injection status'
    TabOrder = 7
  end
  object cbInjected: TCheckBox
    Left = 23
    Top = 354
    Width = 139
    Height = 17
    Caption = 'only injected'
    TabOrder = 8
  end
  object cbByNotReachableStatus: TCheckBox
    Left = 168
    Top = 377
    Width = 193
    Height = 17
    Caption = 'by not reachable status'
    TabOrder = 9
  end
  object cbNotReachable: TCheckBox
    Left = 185
    Top = 400
    Width = 163
    Height = 17
    Caption = 'only not reachable'
    TabOrder = 10
  end
  object cbByReferencesInjectedStatus: TCheckBox
    Left = 168
    Top = 339
    Width = 193
    Height = 17
    Caption = 'by references injected status'
    TabOrder = 11
  end
  object cbReferencesInjected: TCheckBox
    Left = 182
    Top = 354
    Width = 187
    Height = 17
    Caption = 'only references injected'
    TabOrder = 12
  end
  object cbByEditorID: TCheckBox
    Left = 8
    Top = 377
    Width = 154
    Height = 17
    Caption = 'EditorID contains'
    TabOrder = 13
  end
  object cbByName: TCheckBox
    Left = 8
    Top = 427
    Width = 161
    Height = 17
    Caption = 'Name contains'
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
    Caption = 'by Record Signature'
    TabOrder = 18
  end
  object cbByPersistent: TCheckBox
    Left = 8
    Top = 475
    Width = 145
    Height = 17
    Caption = 'by persistence'
    TabOrder = 19
  end
  object cbPersistent: TCheckBox
    Left = 23
    Top = 498
    Width = 156
    Height = 17
    Caption = 'only persistent'
    TabOrder = 20
  end
  object cbUnnecessaryPersistent: TCheckBox
    Left = 38
    Top = 521
    Width = 307
    Height = 17
    Caption = 'only possible unnecessary persistent'
    TabOrder = 21
  end
  object cbMasterIsTemporary: TCheckBox
    Left = 54
    Top = 544
    Width = 187
    Height = 17
    Caption = 'only if master is not persistent'
    TabOrder = 22
  end
  object cbByVWD: TCheckBox
    Left = 168
    Top = 427
    Width = 180
    Height = 17
    Caption = 'by Visible When Distant'
    TabOrder = 23
  end
  object cbVWD: TCheckBox
    Left = 185
    Top = 450
    Width = 176
    Height = 17
    Caption = 'only Visible When Distant'
    TabOrder = 24
  end
  object cbIsMaster: TCheckBox
    Left = 247
    Top = 544
    Width = 114
    Height = 17
    Caption = 'or if it'#39's the master'
    TabOrder = 25
  end
  object cbPersistentPosChanged: TCheckBox
    Left = 38
    Top = 567
    Width = 307
    Height = 17
    Caption = 'only if position/rotation was changed'
    TabOrder = 26
  end
  object cbBaseRecordSignature: TCheckBox
    Left = 642
    Top = 1
    Width = 281
    Height = 17
    Caption = 'by Base Record Signature'
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
    Caption = 'Base Record EditorID contains'
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
    Caption = 'Base Record Name contains'
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
    Caption = 'by Has Visible When Distant Mesh'
    TabOrder = 33
  end
  object cbHasVWDMesh: TCheckBox
    Left = 185
    Top = 496
    Width = 184
    Height = 17
    Caption = 'only Has VWD Mesh'
    TabOrder = 34
  end
  object cbFlattenBlocks: TCheckBox
    Left = 8
    Top = 590
    Width = 177
    Height = 17
    Caption = 'Flatten Blocks/Sub-Blocks'
    TabOrder = 35
  end
  object cbFlattenCellChilds: TCheckBox
    Left = 191
    Top = 590
    Width = 157
    Height = 17
    Caption = 'Flatten Cell Children'
    TabOrder = 36
  end
  object cbAssignPersWrldChild: TCheckBox
    Left = 204
    Top = 613
    Width = 277
    Height = 17
    Caption = 'Assign Persistent Worldspace Children to Cells'
    TabOrder = 37
  end
  object cbScaledActors: TCheckBox
    Left = 639
    Top = 602
    Width = 90
    Height = 17
    Caption = 'Scaled Actors'
    TabOrder = 38
  end
  object pmuSelection: TPopupMenu
    Left = 320
    Top = 64
    object mniSelectAll: TMenuItem
      Caption = 'Select All'
      OnClick = mniSelectionClick
    end
    object mniSelectNone: TMenuItem
      Caption = 'Select None'
      OnClick = mniSelectionClick
    end
    object mniInvertSelection: TMenuItem
      Caption = 'Invert Selection'
      OnClick = mniSelectionClick
    end
  end
end
