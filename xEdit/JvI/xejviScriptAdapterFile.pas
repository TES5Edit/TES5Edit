{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptAdapterFile;

{$I xeDefines.inc}

interface

uses
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

implementation

uses
  System.Classes,
  System.SysUtils,

  wbInterface;

const
  cUnit = 'Dummy';


{ IwbFile }

procedure IwbFile_AddMasterIfMissing(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    case Args.Count of
    0, 1: JvInterpreterError(ieNotEnoughParams, -1);
    4: _File.AddMasterIfMissing(string(Args.Values[1]), Boolean(Args.Values[2]), Boolean(Args.Values[3]));
    3: _File.AddMasterIfMissing(string(Args.Values[1]), Boolean(Args.Values[2]));
    2: _File.AddMasterIfMissing(string(Args.Values[1]));
    else
     JvInterpreterError(ieTooManyParams, -1);
    end;
end;

procedure IwbFile_AddMasters(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    case Args.Count of
    0, 1: JvInterpreterError(ieNotEnoughParams, -1);
    3: _File.AddMasters(TStrings(V2O(Args.Values[1])), Boolean(Args.Values[2]));
    2: _File.AddMasters(TStrings(V2O(Args.Values[1])));
    else
     JvInterpreterError(ieTooManyParams, -1);
    end;
end;

procedure IwbFile_AddMastersIfMissing(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    case Args.Count of
    0, 1: JvInterpreterError(ieNotEnoughParams, -1);
    4: _File.AddMastersIfMissing(TStrings(V2O(Args.Values[1])), Boolean(Args.Values[2]), Boolean(Args.Values[3]));
    3: _File.AddMastersIfMissing(TStrings(V2O(Args.Values[1])), Boolean(Args.Values[2]));
    2: _File.AddMastersIfMissing(TStrings(V2O(Args.Values[1])));
    else
     JvInterpreterError(ieTooManyParams, -1);
    end;
end;

procedure IwbFile_CanBeLight(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    if (_File.LoadOrderFileID.IsLightSlot = true) then
        Value :=  true;
end;

procedure IwbFile_CanBeMedium(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    if (_File.LoadOrderFileID.IsMediumSlot = true) then
        Value :=  true;
end;

procedure IwbFile_CleanMasters(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    _File.CleanMasters;
end;

procedure IwbFile_FileFormIDtoLoadOrderFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.FileFormIDtoLoadOrderFormID(TwbFormID.FromVar(Args.Values[1]), True).ToCardinal;
end;

procedure IwbFile_GetFileName(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.FileName
  else
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
  begin
    var ElementFile: IwbFile := Element._File;
    if Assigned(ElementFile) then
      Value := ElementFile.FileName;
  end;
end;

procedure IwbFile_GetIsESM(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.IsESM;
end;

procedure IwbFile_GetIsLight(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.IsLight;
end;

procedure IwbFile_GetIsMedium(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.IsMedium;
end;

procedure IwbFile_GetLoadOrder(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.LoadOrder;
end;

procedure IwbFile_GetLoadOrderFileID(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.LoadOrderFileID.ToString;
end;

procedure IwbFile_GetMasters(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File : IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    _File.GetMasters(TStrings(V2O(Args.Values[1])));
end;

procedure IwbFile_GetNewFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.NewFormID.ToCardinal;
end;

procedure IwbFile_GroupBySignature(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.GroupBySignature[StrToSignature(Args.Values[1])];
end;

procedure IwbFile_HasGroup(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.HasGroup(StrToSignature(Args.Values[1]));
end;

procedure IwbFile_HasMaster(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.HasMaster(Args.Values[1]);
end;

procedure IwbFile_LoadOrderFormIDtoFileFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.LoadOrderFormIDtoFileFormID(TwbFormID.FromVar(Args.Values[1]), True).ToCardinal;
end;

procedure IwbFile_MasterByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    if (Args.Values[1] >= 0) and (Args.Values[1] < _File.MasterCount[True]) then
      Value := _File.Masters[Args.Values[1], True];
end;

procedure IwbFile_MasterCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.MasterCount[True];
end;

procedure IwbFile_RecordByEditorID(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.RecordByEditorID[string(Args.Values[1])];
end;

procedure IwbFile_RecordByFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.RecordByFormID[TwbFormID.FromVar(Args.Values[1]), Args.Values[2], True];
end;

procedure IwbFile_RecordByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    if (Args.Values[1] >= 0) and (Args.Values[1] < _File.RecordCount) then
      Value := _File.Records[Args.Values[1]];
end;

procedure IwbFile_RecordCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.RecordCount;
end;

procedure IwbFile_SetIsESM(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    _File.IsESM := Args.Values[1];
end;

procedure IwbFile_SetIsLight(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    _File.IsLight := Args.Values[1];
end;

procedure IwbFile_SetIsMedium(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    _File.IsMedium := Args.Values[1];
end;

procedure IwbFile_SortMasters(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    _File.SortMasters;
end;

procedure IwbFile_WriteToStream(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File  : IwbFile;
  Stream : TStream;
  i      : Integer;
  rm     : TwbResetModified;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then begin
    Stream := TStream(V2O(Args.Values[1]));
    if Assigned(Stream) then begin
      i := Args.Values[2];
      case i of
        0: rm := rmNo;
        2: rm := rmSetInternal;
      else
        rm := rmYes;
      end;
      _File.WriteToStream(Stream, rm);
    end;
  end;
end;


procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    { IwbFile }
    AddFunction(cUnit, 'AddMasterIfMissing', IwbFile_AddMasterIfMissing, -1, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'AddMasters', IwbFile_AddMasters, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'AddMastersIfMissing', IwbFile_AddMastersIfMissing, -1, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'CanBeESL', IwbFile_CanBeLight, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CanBeLight', IwbFile_CanBeLight, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CanBeMedium', IwbFile_CanBeMedium, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CanBeSmall', IwbFile_CanBeLight, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CleanMasters', IwbFile_CleanMasters, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FileFormIDtoLoadOrderFormID', IwbFile_FileFormIDtoLoadOrderFormID, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'FileWriteToStream', IwbFile_WriteToStream, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'GetFileName', IwbFile_GetFileName, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsESL', IwbFile_GetIsLight, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsESM', IwbFile_GetIsESM, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsLight', IwbFile_GetIsLight, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsMedium', IwbFile_GetIsMedium, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsSmall', IwbFile_GetIsLight, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetLoadOrder', IwbFile_GetLoadOrder, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetLoadOrderFileID', IwbFile_GetLoadOrderFileID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetMasters', IwbFile_GetMasters, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'GetNewFormID', IwbFile_GetNewFormID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GroupBySignature', IwbFile_GroupBySignature, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'HasGroup', IwbFile_HasGroup, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'HasMaster', IwbFile_HasMaster, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'LoadOrderFormIDtoFileFormID', IwbFile_LoadOrderFormIDtoFileFormID, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'MasterByIndex', IwbFile_MasterByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'MasterCount', IwbFile_MasterCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'RecordByEditorID', IwbFile_RecordByEditorID, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'RecordByFormID', IwbFile_RecordByFormID, 3, [varEmpty, varInteger, varBoolean], varEmpty);
    AddFunction(cUnit, 'RecordByIndex', IwbFile_RecordByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'RecordCount', IwbFile_RecordCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetIsESL', IwbFile_SetIsLight, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'SetIsESM', IwbFile_SetIsESM, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'SetIsLight', IwbFile_SetIsLight, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'SetIsMedium', IwbFile_SetIsMedium, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'SetIsSmall', IwbFile_SetIsLight, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'SortMasters', IwbFile_SortMasters, 1, [varEmpty], varEmpty);
  end;
end;

procedure Init;
begin
  RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
end;

initialization
  Init;

end.
