{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptAdapterRecord;

{$I xeDefines.inc}

interface

uses
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

implementation

uses
  System.SysUtils,

  wbInterface,
  xejviScriptAdapterContainer;

const
  cUnit = 'Dummy';
  cTwbVector = 'TwbVector';
  cTwbGridCell = 'TwbGridCell';


function wbVector2Var(const wbVector: TwbVector): Variant;
var
  Rec: ^TwbVector;
begin
  New(Rec);
  Rec^ := wbVector;
  Result := R2V(cTwbVector, Rec);
end;

function wbGridCell2Var(const wbGridCell: TwbGridCell): Variant;
var
  Rec: ^TwbGridCell;
begin
  New(Rec);
  Rec^ := wbGridCell;
  Result := R2V(cTwbGridCell, Rec);
end;


{ IwbMainRecord }

procedure IwbMainRecord_BaseRecord(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.BaseRecord;
end;

procedure IwbMainRecord_BaseRecordID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.BaseRecordID.ToCardinal;
end;

procedure IwbMainRecord_ChangeFormSignature(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
  Signature: TwbSignature;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    RequireEditable(MainRecord);
    Signature := StrToSignature(Args.Values[1]);
    MainRecord.ChangeFormSignature(Signature);
  end;
end;

procedure IwbMainRecord_ChildGroup(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.ChildGroup;
end;

procedure IwbMainRecord_CompareExchangeFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.CompareExchangeFormID(TwbFormID.FromVar(Args.Values[1]), TwbFormID.FromVar(Args.Values[2]));
end;

procedure IwbMainRecord_EditorID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.EditorID;
end;

procedure IwbMainRecord_FixedFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.FixedFormID.ToCardinal;
end;

procedure IwbMainRecord_FormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.FormID.ToCardinal;
end;

procedure IwbMainRecord_GetFormVCS1(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.VCS1;
end;

procedure IwbMainRecord_GetFormVCS2(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.VCS2;
end;

procedure IwbMainRecord_GetFormVersion(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := Cardinal(MainRecord.Version);
end;

procedure IwbMainRecord_GetGridCell(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
  Rec: TwbGridCell;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    MainRecord.GetGridCell(Rec);
    Value := wbGridCell2Var(Rec);
  end;
end;

procedure IwbMainRecord_GetIsDeleted(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.IsDeleted;
end;

procedure IwbMainRecord_GetIsInitiallyDisabled(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.IsInitiallyDisabled;
end;

procedure IwbMainRecord_GetIsPersistent(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.IsPersistent;
end;

procedure IwbMainRecord_GetIsVisibleWhenDistant(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.IsVisibleWhenDistant;
end;

procedure IwbMainRecord_GetLoadOrderFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.LoadOrderFormID.ToCardinal;
end;

procedure IwbMainRecord_GetPosition(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
  Vec: TwbVector;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    MainRecord.GetPosition(Vec);
    Value := wbVector2Var(Vec);
  end;
end;

procedure IwbMainRecord_GetRotation(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
  Vec: TwbVector;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    MainRecord.GetRotation(Vec);
    Value := wbVector2Var(Vec);
  end;
end;

procedure IwbMainRecord_HasPrecombinedMesh(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.HasPrecombinedMesh;
end;

procedure IwbMainRecord_HighestOverrideOrSelf(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.HighestOverrideOrSelf[Integer(Args.Values[1])];
end;

procedure IwbMainRecord_IsMaster(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.IsMaster;
end;

procedure IwbMainRecord_IsWinningOverride(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.IsWinningOverride;
end;

procedure IwbMainRecord_Master(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.Master;
end;

procedure IwbMainRecord_MasterOrSelf(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.MasterOrSelf;
end;

procedure IwbMainRecord_OverrideByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.Overrides[Args.Values[1]];
end;

procedure IwbMainRecord_OverrideCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.OverrideCount;
end;

procedure IwbMainRecord_PrecombinedMesh(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.PrecombinedMesh;
end;

procedure IwbMainRecord_ReferencedByCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.ReferencedByCount;
end;

procedure IwbMainRecord_ReferencedByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.ReferencedBy[Args.Values[1]];
end;

procedure IwbMainRecord_ReferencesByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.References[Args.Values[1]];
end;

procedure IwbMainRecord_ReferencesCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.ReferencesCount;
end;

procedure IwbMainRecord_SetEditorID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    RequireEditable(MainRecord);
    MainRecord.EditorID := Args.Values[1];
  end;
end;

procedure IwbMainRecord_SetFormVCS1(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.VCS1 := Args.Values[1];
end;

procedure IwbMainRecord_SetFormVCS2(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.VCS2 := Args.Values[1];
end;

procedure IwbMainRecord_SetFormVersion(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.Version := Args.Values[1];
end;

procedure IwbMainRecord_SetIsDeleted(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    RequireEditable(MainRecord);
    MainRecord.IsDeleted := Args.Values[1];
  end;
end;

procedure IwbMainRecord_SetIsInitiallyDisabled(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    RequireEditable(MainRecord);
    MainRecord.IsInitiallyDisabled := Args.Values[1];
  end;
end;

procedure IwbMainRecord_SetIsPersistent(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    RequireEditable(MainRecord);
    MainRecord.IsPersistent := Args.Values[1];
  end;
end;

procedure IwbMainRecord_SetIsVisibleWhenDistant(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    RequireEditable(MainRecord);
    MainRecord.IsVisibleWhenDistant := Args.Values[1];
  end;
end;

procedure IwbMainRecord_SetLoadOrderFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    RequireEditable(MainRecord);
    MainRecord.LoadOrderFormID := TwbFormID.FromVar(Args.Values[1]);
  end;
end;

procedure IwbMainRecord_Signature(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbHasSignature;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbHasSignature, Element) then
    Value := string(Element.Signature);
end;

procedure IwbMainRecord_UpdateRefs(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.UpdateRefs;
end;

procedure IwbMainRecord_WinningOverride(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.WinningOverride;
end;


{ IwbGroupRecord }

procedure IwbGroupRecord_ChildrenOf(var Value: Variant; Args: TJvInterpreterArgs);
var
  GroupRecord: IwbGroupRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbGroupRecord, GroupRecord) then
    Value := GroupRecord.ChildrenOf;
end;

procedure IwbGroupRecord_FindChildGroup(var Value: Variant; Args: TJvInterpreterArgs);
var
  GroupRecord: IwbGroupRecord;
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbGroupRecord, GroupRecord) then
    if Supports(IInterface(Args.Values[2]), IwbMainRecord, MainRecord) then
      Value := GroupRecord.FindChildGroup(Args.Values[1], MainRecord);
end;

procedure IwbGroupRecord_GroupLabel(var Value: Variant; Args: TJvInterpreterArgs);
var
  GroupRecord: IwbGroupRecord;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbGroupRecord, GroupRecord) then
    Value := GroupRecord.GroupLabel;
end;

procedure IwbGroupRecord_GroupType(var Value: Variant; Args: TJvInterpreterArgs);
var
  GroupRecord: IwbGroupRecord;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbGroupRecord, GroupRecord) then
    Value := GroupRecord.GroupType;
end;

procedure IwbGroupRecord_MainRecordByEditorID(var Value: Variant; Args: TJvInterpreterArgs);
var
  GroupRecord: IwbGroupRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbGroupRecord, GroupRecord) then
    Value := GroupRecord. MainRecordByEditorID[string(Args.Values[1])];
end;


procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    { IwbMainRecord }
    AddFunction(cUnit, 'BaseRecord', IwbMainRecord_BaseRecord, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'BaseRecordID', IwbMainRecord_BaseRecordID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ChangeFormSignature', IwbMainRecord_ChangeFormSignature, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'ChildGroup', IwbMainRecord_ChildGroup, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CompareExchangeFormID', IwbMainRecord_CompareExchangeFormID, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'EditorID', IwbMainRecord_EditorID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FixedFormID', IwbMainRecord_FixedFormID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FormID', IwbMainRecord_FormID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetFormVCS1', IwbMainRecord_GetFormVCS1, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetFormVCS2', IwbMainRecord_GetFormVCS2, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetFormVersion', IwbMainRecord_GetFormVersion, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetGridCell', IwbMainRecord_GetGridCell, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsDeleted', IwbMainRecord_GetIsDeleted, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsInitiallyDisabled', IwbMainRecord_GetIsInitiallyDisabled, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsPersistent', IwbMainRecord_GetIsPersistent, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsVisibleWhenDistant', IwbMainRecord_GetIsVisibleWhenDistant, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetLoadOrderFormID', IwbMainRecord_GetLoadOrderFormID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetPosition', IwbMainRecord_GetPosition, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetRotation', IwbMainRecord_GetRotation, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'HasPrecombinedMesh', IwbMainRecord_HasPrecombinedMesh, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'HighestOverrideOrSelf', IwbMainRecord_HighestOverrideOrSelf, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'IsMaster', IwbMainRecord_IsMaster, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IsWinningOverride', IwbMainRecord_IsWinningOverride, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'Master', IwbMainRecord_Master, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MasterOrSelf', IwbMainRecord_MasterOrSelf, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'OverrideByIndex', IwbMainRecord_OverrideByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'OverrideCount', IwbMainRecord_OverrideCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'PrecombinedMesh', IwbMainRecord_PrecombinedMesh, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ReferencedByCount', IwbMainRecord_ReferencedByCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ReferencedByIndex', IwbMainRecord_ReferencedByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'ReferencesByIndex', IwbMainRecord_ReferencesByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'ReferencesCount', IwbMainRecord_ReferencesCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetEditorID', IwbMainRecord_SetEditorID, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'SetFormVCS1', IwbMainRecord_SetFormVCS1, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'SetFormVCS2', IwbMainRecord_SetFormVCS2, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'SetFormVersion', IwbMainRecord_SetFormVersion, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'SetIsDeleted', IwbMainRecord_SetIsDeleted, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'SetIsInitiallyDisabled', IwbMainRecord_SetIsInitiallyDisabled, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'SetIsPersistent', IwbMainRecord_SetIsPersistent, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'SetIsVisibleWhenDistant', IwbMainRecord_SetIsVisibleWhenDistant, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'SetLoadOrderFormID', IwbMainRecord_SetLoadOrderFormID, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'Signature', IwbMainRecord_Signature, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'UpdateRefs', IwbMainRecord_UpdateRefs, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'WinningOverride', IwbMainRecord_WinningOverride, 1, [varEmpty], varEmpty);

    { IwbGroupRecord }
    AddFunction(cUnit, 'ChildrenOf', IwbGroupRecord_ChildrenOf, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FindChildGroup', IwbGroupRecord_FindChildGroup, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'GroupLabel', IwbGroupRecord_GroupLabel, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GroupType', IwbGroupRecord_GroupType, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MainRecordByEditorID', IwbGroupRecord_MainRecordByEditorID, 2, [varEmpty], varEmpty);
  end;
end;

procedure Init;
begin
  RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
end;

initialization
  Init;

end.
