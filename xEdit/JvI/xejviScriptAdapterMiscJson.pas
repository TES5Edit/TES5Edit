{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptAdapterMiscJson;

{$I xeDefines.inc}

interface

uses
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

implementation

uses
  System.Classes,
  System.SysUtils,

  JsonDataObjects,

  wbInterface;

{ JsonDataObjects }

procedure JsonDataObjects_Write_IndentChar(var Value: Variant; Args: TJvInterpreterArgs);
begin
  JsonSerializationConfig.IndentChar := Args.Values[0];
end;

procedure JsonDataObjects_Write_LineBreak(var Value: Variant; Args: TJvInterpreterArgs);
begin
  JsonSerializationConfig.LineBreak := Args.Values[0];
end;

procedure JsonDataObjects_Write_NullConvertsToValueTypes(var Value: Variant; Args: TJvInterpreterArgs);
begin
  JsonSerializationConfig.NullConvertsToValueTypes := Args.Values[0];
end;

procedure JsonDataObjects_Write_UseUtcTime(var Value: Variant; Args: TJvInterpreterArgs);
begin
  JsonSerializationConfig.UseUtcTime := Args.Values[0];
end;

{ TJsonBaseObject }

procedure TJsonBaseObject_FromJson(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonBaseObject(Args.Obj).FromJSON(Args.Values[0]);
end;

procedure TJsonBaseObject_LoadFromFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  with TJsonBaseObject(Args.Obj) do
  case Args.Count of
   0: JvInterpreterError(ieNotEnoughParams, -1);
   1: LoadFromFile(Args.Values[0]);
   2: LoadFromFile(Args.Values[0], Args.Values[1]);
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TJsonBaseObject_LoadFromResource(var Value: Variant; Args: TJvInterpreterArgs);
var
  Bytes: TBytes;
begin
  with TJsonBaseObject(Args.Obj) do
  case Args.Count of
   0: JvInterpreterError(ieNotEnoughParams, -1);
   1: begin
     Bytes := wbContainerHandler.OpenResourceData('', Args.Values[0]);
     FromUtf8Json(PByte(@Bytes[0]), Length(Bytes));
   end;
   2: begin
     Bytes := wbContainerHandler.OpenResourceData(Args.Values[0], Args.Values[1]);
     FromUtf8Json(PByte(@Bytes[0]), Length(Bytes));
   end;
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TJsonBaseObject_LoadFromStream(var Value: Variant; Args: TJvInterpreterArgs);
begin
  with TJsonBaseObject(Args.Obj) do
  case Args.Count of
   0: JvInterpreterError(ieNotEnoughParams, -1);
   1: LoadFromStream(TStream(V2O(Args.Values[0])));
   2: LoadFromStream(TStream(V2O(Args.Values[0])), TEncoding(V2O(Args.Values[1])));
   3: LoadFromStream(TStream(V2O(Args.Values[0])), TEncoding(V2O(Args.Values[1])), Args.Values[2]);
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TJsonBaseObject_Parse(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonBaseObject(Args.Obj).Parse(String(Args.Values[0])));
end;

procedure TJsonBaseObject_SaveToFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  with TJsonBaseObject(Args.Obj) do
  case Args.Count of
   0: JvInterpreterError(ieNotEnoughParams, -1);
   1: SaveToFile(Args.Values[0]);
   2: SaveToFile(Args.Values[0], Args.Values[1]);
   3: SaveToFile(Args.Values[0], Args.Values[1], TEncoding(V2O(Args.Values[2])));
   4: SaveToFile(Args.Values[0], Args.Values[1], TEncoding(V2O(Args.Values[2])), Args.Values[3]);
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TJsonBaseObject_SaveToLines(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonBaseObject(Args.Obj).SaveToLines(TStrings(V2O(Args.Values[0])));
end;

procedure TJsonBaseObject_SaveToStream(var Value: Variant; Args: TJvInterpreterArgs);
begin
  with TJsonBaseObject(Args.Obj) do
  case Args.Count of
   0: JvInterpreterError(ieNotEnoughParams, -1);
   1: SaveToStream(TStream(V2O(Args.Values[0])));
   2: SaveToStream(TStream(V2O(Args.Values[0])), Args.Values[1]);
   3: SaveToStream(TStream(V2O(Args.Values[0])), Args.Values[1], TEncoding(V2O(Args.Values[2])));
   4: SaveToStream(TStream(V2O(Args.Values[0])), Args.Values[1], TEncoding(V2O(Args.Values[2])), Args.Values[3]);
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TJsonBaseObject_ToJson(var Value: Variant; Args: TJvInterpreterArgs);
begin
  with TJsonBaseObject(Args.Obj) do
  case Args.Count of
   0: Value := ToJSON;
   1: Value := ToJSON(Args.Values[0]);
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TJsonBaseObject_ToString(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonBaseObject(Args.Obj).ToString;
end;

{ TJsonArray }

procedure TJsonArray_Read_V(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonArray(Args.Obj).V[Args.Values[0]];
end;

procedure TJsonArray_Write_V(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).V[Args.Values[0]] := Value;
end;

procedure TJsonArray_Read_A(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonArray(Args.Obj).A[Args.Values[0]]);
end;

procedure TJsonArray_Write_A(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).A[Args.Values[0]] := TJsonArray(V2O(Value));
end;

procedure TJsonArray_Read_B(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonArray(Args.Obj).B[Args.Values[0]];
end;

procedure TJsonArray_Write_B(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).B[Args.Values[0]] := Value;
end;

procedure TJsonArray_Read_D(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonArray(Args.Obj).D[Args.Values[0]];
end;

procedure TJsonArray_Write_D(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).D[Args.Values[0]] := Value;
end;

procedure TJsonArray_Read_F(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonArray(Args.Obj).F[Args.Values[0]];
end;

procedure TJsonArray_Write_F(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).F[Args.Values[0]] := Value;
end;

procedure TJsonArray_Read_I(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonArray(Args.Obj).I[Args.Values[0]];
end;

procedure TJsonArray_Write_I(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).I[Args.Values[0]] := Value;
end;

procedure TJsonArray_Read_L(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonArray(Args.Obj).L[Args.Values[0]];
end;

procedure TJsonArray_Write_L(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).L[Args.Values[0]] := Value;
end;

procedure TJsonArray_Read_O(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonArray(Args.Obj).O[Args.Values[0]]);
end;

procedure TJsonArray_Write_O(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).O[Args.Values[0]] := TJsonObject(V2O(Value));
end;

procedure TJsonArray_Read_S(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonArray(Args.Obj).S[Args.Values[0]];
end;

procedure TJsonArray_Write_S(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).S[Args.Values[0]] := Value;
end;

procedure TJsonArray_Read_U(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonArray(Args.Obj).U[Args.Values[0]];
end;

procedure TJsonArray_Write_U(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).U[Args.Values[0]] := Value;
end;

procedure TJsonArray_Add_V(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).Add(Args.Values[0]);
end;

procedure TJsonArray_Add_Array(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonArray(Args.Obj).AddArray);
end;

procedure TJsonArray_Add_Object(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonArray(Args.Obj).AddObject);
end;

procedure TJsonArray_Assign(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).Assign(TJsonArray(V2O(Args.Values[0])));
end;

procedure TJsonArray_Clear(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).Clear;
end;

procedure TJsonArray_Read_Count(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonArray(Args.Obj).Count;
end;

procedure TJsonArray_Write_Count(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).Count := Value;
end;

procedure TJsonArray_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonArray.Create);
end;

procedure TJsonArray_Delete(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).Delete(Args.Values[0]);
end;

procedure TJsonArray_Extract(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonArray(Args.Obj).Extract(Args.Values[0]));
end;

procedure TJsonArray_ExtractArray(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonArray(Args.Obj).ExtractArray(Args.Values[0]));
end;

procedure TJsonArray_ExtractObject(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonArray(Args.Obj).ExtractObject(Args.Values[0]));
end;

procedure TJsonArray_Insert_V(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonArray(Args.Obj).Insert(Args.Values[0], Args.Values[1]);
end;

procedure TJsonArray_Insert_Array(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonArray(Args.Obj).InsertArray(Args.Values[0]));
end;

procedure TJsonArray_Insert_Object(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
    0: JvInterpreterError(ieNotEnoughParams, -1);
    1: Value := O2V(TJsonArray(Args.Obj).InsertObject(Args.Values[0]));
    2: TJsonArray(Args.Obj).InsertObject( Args.Values[0], TJsonObject(V2O(Args.Values[1])) );
    else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TJsonArray_IsNull(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonArray(Args.Obj).IsNull(Args.Values[0]);
end;

procedure TJsonArray_Parse(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonBaseObject(Args.Obj).Parse(String(Args.Values[0])));
end;

procedure TJsonArray_Read_Types(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonArray(Args.Obj).Types[Args.Values[0]]
end;

{ TJsonObject }

procedure TJsonObject_Read_V(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonObject(Args.Obj).Values[Args.Values[0]].VariantValue;
end;

procedure TJsonObject_Write_V(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).Values[Args.Values[0]].VariantValue := Value;
end;

procedure TJsonObject_Read_A(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonObject(Args.Obj).A[Args.Values[0]]);
end;

procedure TJsonObject_Write_A(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).A[Args.Values[0]] := TJsonArray(V2O(Value));
end;

procedure TJsonObject_Read_B(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonObject(Args.Obj).B[Args.Values[0]];
end;

procedure TJsonObject_Write_B(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).B[Args.Values[0]] := Value;
end;

procedure TJsonObject_Read_D(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonObject(Args.Obj).D[Args.Values[0]];
end;

procedure TJsonObject_Write_D(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).D[Args.Values[0]] := Value;
end;

procedure TJsonObject_Read_F(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonObject(Args.Obj).F[Args.Values[0]];
end;

procedure TJsonObject_Write_F(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).F[Args.Values[0]] := Value;
end;

procedure TJsonObject_Read_I(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonObject(Args.Obj).I[Args.Values[0]];
end;

procedure TJsonObject_Write_I(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).I[Args.Values[0]] := Value;
end;

procedure TJsonObject_Read_L(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonObject(Args.Obj).L[Args.Values[0]];
end;

procedure TJsonObject_Write_L(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).L[Args.Values[0]] := Value;
end;

procedure TJsonObject_Read_O(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonObject(Args.Obj).O[Args.Values[0]]);
end;

procedure TJsonObject_Write_O(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).O[Args.Values[0]] := TJsonObject(V2O(Value));
end;

procedure TJsonObject_Read_S(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonObject(Args.Obj).S[Args.Values[0]];
end;

procedure TJsonObject_Write_S(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).S[Args.Values[0]] := Value;
end;

procedure TJsonObject_Read_U(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonObject(Args.Obj).U[Args.Values[0]];
end;

procedure TJsonObject_Write_U(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).U[Args.Values[0]] := Value;
end;

procedure TJsonObject_Assign(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).Assign(TJsonObject(V2O(Args.Values[0])));
end;

procedure TJsonObject_Clear(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).Clear;
end;

procedure TJsonObject_Contains(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonObject(Args.Obj).Contains(Args.Values[0]);
end;

procedure TJsonObject_Read_Count(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonObject(Args.Obj).Count;
end;

procedure TJsonObject_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonObject.Create);
end;

procedure TJsonObject_Delete(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).Delete(Args.Values[0]);
end;

procedure TJsonObject_Extract(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonObject(Args.Obj).Extract(Args.Values[0]));
end;

procedure TJsonObject_ExtractArray(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonObject(Args.Obj).ExtractArray(Args.Values[0]));
end;

procedure TJsonObject_ExtractObject(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonObject(Args.Obj).ExtractObject(Args.Values[0]));
end;

procedure TJsonObject_IndexOf(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonObject(Args.Obj).IndexOf(Args.Values[0]);
end;

procedure TJsonObject_IsNull(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonObject(Args.Obj).IsNull(Args.Values[0]);
end;

procedure TJsonObject_Read_Names(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if (Args.Values[0] < 0) or (Args.Values[0] >= TJsonObject(Args.Obj).Count) then
    JvInterpreterError(ieArrayIndexOutOfBounds, -1);
  Value := TJsonObject(Args.Obj).Names[Args.Values[0]]
end;

procedure TJsonObject_Parse(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TJsonBaseObject(Args.Obj).Parse(String(Args.Values[0])));
end;

procedure TJsonObject_Remove(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TJsonObject(Args.Obj).Remove(Args.Values[0]);
end;

procedure TJsonObject_Read_Types(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TJsonObject(Args.Obj).Types[Args.Values[0]]
end;

{ Registration }

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    { JsonDataObjects }
    AddConst('JsonDataObjects', 'jdtNone', Ord(TJsonDataType.jdtNone));
    AddConst('JsonDataObjects', 'jdtString', Ord(TJsonDataType.jdtString));
    AddConst('JsonDataObjects', 'jdtInt', Ord(TJsonDataType.jdtInt));
    AddConst('JsonDataObjects', 'jdtLong', Ord(TJsonDataType.jdtLong));
    AddConst('JsonDataObjects', 'jdtULong', Ord(TJsonDataType.jdtULong));
    AddConst('JsonDataObjects', 'jdtFloat', Ord(TJsonDataType.jdtFloat));
    AddConst('JsonDataObjects', 'jdtDateTime', Ord(TJsonDataType.jdtDateTime));
    AddConst('JsonDataObjects', 'jdtBool', Ord(TJsonDataType.jdtBool));
    AddConst('JsonDataObjects', 'jdtArray', Ord(TJsonDataType.jdtArray));
    AddConst('JsonDataObjects', 'jdtObject', Ord(TJsonDataType.jdtObject));
    AddFunction('JsonDataObjects', 'SetJDOIndentChar', JsonDataObjects_Write_IndentChar, 1, [varEmpty], varEmpty);
    AddFunction('JsonDataObjects', 'SetJDOLineBreak', JsonDataObjects_Write_LineBreak, 1, [varEmpty], varEmpty);
    AddFunction('JsonDataObjects', 'SetJDONullConvertsToValueTypes', JsonDataObjects_Write_NullConvertsToValueTypes, 1, [varEmpty], varEmpty);
    AddFunction('JsonDataObjects', 'SetJDOUseUtcTime', JsonDataObjects_Write_UseUtcTime, 1, [varEmpty], varEmpty);

    { TJsonBaseObject }
    AddClass('JsonDataObjects', TJsonBaseObject, 'TJsonBaseObject');
    AddGet(TJsonBaseObject, 'FromJSON', TJsonBaseObject_FromJSON, 1, [varEmpty], varEmpty);
    AddGet(TJsonBaseObject, 'LoadFromFile', TJsonBaseObject_LoadFromFile, -1, [varEmpty], varEmpty);
    AddGet(TJsonBaseObject, 'LoadFromResource', TJsonBaseObject_LoadFromResource, -1, [varEmpty], varEmpty);
    AddGet(TJsonBaseObject, 'LoadFromStream', TJsonBaseObject_LoadFromStream, -1, [varEmpty], varEmpty);
    AddGet(TJsonBaseObject, 'Parse', TJsonBaseObject_Parse, 1, [varEmpty], varEmpty);
    AddGet(TJsonBaseObject, 'SaveToFile', TJsonBaseObject_SaveToFile, -1, [varEmpty], varEmpty);
    AddGet(TJsonBaseObject, 'SaveToLines', TJsonBaseObject_SaveToLines, 1, [varEmpty], varEmpty);
    AddGet(TJsonBaseObject, 'SaveToStream', TJsonBaseObject_SaveToStream, -1, [varEmpty, varEmpty], varEmpty);
    AddGet(TJsonBaseObject, 'ToJSON', TJsonBaseObject_ToJSON, -1, [varEmpty], varEmpty);
    AddGet(TJsonBaseObject, 'ToString', TJsonBaseObject_ToString, 0, [varEmpty], varEmpty);

    { TJsonArray }
    AddClass('JsonDataObjects', TJsonArray, 'TJsonArray');
    AddIDGet(TJsonArray, TJsonArray_Read_V, 1, [varEmpty], varEmpty);
    AddIDSet(TJsonArray, TJsonArray_Write_V, 1, [varEmpty]);
    AddIGet(TJsonArray, 'A', TJsonArray_Read_A, 1, [varEmpty], varEmpty);
    AddISet(TJsonArray, 'A', TJsonArray_Write_A, 1, [varEmpty]);
    AddIGet(TJsonArray, 'B', TJsonArray_Read_B, 1, [varEmpty], varEmpty);
    AddISet(TJsonArray, 'B', TJsonArray_Write_B, 1, [varEmpty]);
    AddIGet(TJsonArray, 'D', TJsonArray_Read_D, 1, [varEmpty], varEmpty);
    AddISet(TJsonArray, 'D', TJsonArray_Write_D, 1, [varEmpty]);
    AddIGet(TJsonArray, 'F', TJsonArray_Read_F, 1, [varEmpty], varEmpty);
    AddISet(TJsonArray, 'F', TJsonArray_Write_F, 1, [varEmpty]);
    AddIGet(TJsonArray, 'I', TJsonArray_Read_I, 1, [varEmpty], varEmpty);
    AddISet(TJsonArray, 'I', TJsonArray_Write_I, 1, [varEmpty]);
    AddIGet(TJsonArray, 'L', TJsonArray_Read_L, 1, [varEmpty], varEmpty);
    AddISet(TJsonArray, 'L', TJsonArray_Write_L, 1, [varEmpty]);
    AddIGet(TJsonArray, 'O', TJsonArray_Read_O, 1, [varEmpty], varEmpty);
    AddISet(TJsonArray, 'O', TJsonArray_Write_O, 1, [varEmpty]);
    AddIGet(TJsonArray, 'S', TJsonArray_Read_S, 1, [varEmpty], varEmpty);
    AddISet(TJsonArray, 'S', TJsonArray_Write_S, 1, [varEmpty]);
    AddIGet(TJsonArray, 'U', TJsonArray_Read_U, 1, [varEmpty], varEmpty);
    AddISet(TJsonArray, 'U', TJsonArray_Write_U, 1, [varEmpty]);
    AddGet(TJsonArray, 'Add', TJsonArray_Add_V, 1, [varEmpty], varEmpty);
    AddGet(TJsonArray, 'AddArray', TJsonArray_Add_Array, 0, [varEmpty], varEmpty);
    AddGet(TJsonArray, 'AddObject', TJsonArray_Add_Object, 0, [varEmpty], varEmpty);
    AddGet(TJsonArray, 'Assign', TJsonArray_Assign, 1, [varEmpty], varEmpty);
    AddGet(TJsonArray, 'Clear', TJsonArray_Clear, 0, [varEmpty], varEmpty);
    AddGet(TJsonArray, 'Count', TJsonArray_Read_Count, 0, [varEmpty], varEmpty);
    AddSet(TJsonArray, 'Count', TJsonArray_Write_Count, 1, [varEmpty]);
    AddGet(TJsonArray, 'Create', TJsonArray_Create, 0, [varEmpty], varEmpty);
    AddGet(TJsonArray, 'Delete', TJsonArray_Delete, 1, [varEmpty], varEmpty);
    AddGet(TJsonArray, 'Extract', TJsonArray_Extract, 1, [varEmpty], varEmpty);
    AddGet(TJsonArray, 'ExtractArray', TJsonArray_ExtractArray, 1, [varEmpty], varEmpty);
    AddGet(TJsonArray, 'ExtractObject', TJsonArray_ExtractObject, 1, [varEmpty], varEmpty);
    AddGet(TJsonArray, 'Insert', TJsonArray_Insert_V, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TJsonArray, 'InsertArray', TJsonArray_Insert_Array, 1, [varEmpty], varEmpty);
    AddGet(TJsonArray, 'InsertObject', TJsonArray_Insert_Object, -1, [varEmpty], varEmpty);
    AddGet(TJsonArray, 'IsNull', TJsonArray_IsNull, 1, [varEmpty], varEmpty);
    AddGet(TJsonArray, 'Parse', TJsonArray_Parse, 1, [varEmpty], varEmpty);
    AddIGet(TJsonArray, 'Types', TJsonArray_Read_Types, 1, [varEmpty], varEmpty);

    { TJsonObject }
    AddClass('JsonDataObjects', TJsonObject, 'TJsonObject');
    AddIDGet(TJsonObject, TJsonObject_Read_V, 1, [varEmpty], varEmpty);
    AddIDSet(TJsonObject, TJsonObject_Write_V, 1, [varEmpty]);
    AddIGet(TJsonObject, 'A', TJsonObject_Read_A, 1, [varEmpty], varEmpty);
    AddISet(TJsonObject, 'A', TJsonObject_Write_A, 1, [varEmpty]);
    AddIGet(TJsonObject, 'B', TJsonObject_Read_B, 1, [varEmpty], varEmpty);
    AddISet(TJsonObject, 'B', TJsonObject_Write_B, 1, [varEmpty]);
    AddIGet(TJsonObject, 'D', TJsonObject_Read_D, 1, [varEmpty], varEmpty);
    AddISet(TJsonObject, 'D', TJsonObject_Write_D, 1, [varEmpty]);
    AddIGet(TJsonObject, 'F', TJsonObject_Read_F, 1, [varEmpty], varEmpty);
    AddISet(TJsonObject, 'F', TJsonObject_Write_F, 1, [varEmpty]);
    AddIGet(TJsonObject, 'I', TJsonObject_Read_I, 1, [varEmpty], varEmpty);
    AddISet(TJsonObject, 'I', TJsonObject_Write_I, 1, [varEmpty]);
    AddIGet(TJsonObject, 'L', TJsonObject_Read_L, 1, [varEmpty], varEmpty);
    AddISet(TJsonObject, 'L', TJsonObject_Write_L, 1, [varEmpty]);
    AddIGet(TJsonObject, 'O', TJsonObject_Read_O, 1, [varEmpty], varEmpty);
    AddISet(TJsonObject, 'O', TJsonObject_Write_O, 1, [varEmpty]);
    AddIGet(TJsonObject, 'S', TJsonObject_Read_S, 1, [varEmpty], varEmpty);
    AddISet(TJsonObject, 'S', TJsonObject_Write_S, 1, [varEmpty]);
    AddIGet(TJsonObject, 'U', TJsonObject_Read_U, 1, [varEmpty], varEmpty);
    AddISet(TJsonObject, 'U', TJsonObject_Write_U, 1, [varEmpty]);
    AddGet(TJsonObject, 'Assign', TJsonObject_Assign, 1, [varEmpty], varEmpty);
    AddGet(TJsonObject, 'Clear', TJsonObject_Clear, 0, [varEmpty], varEmpty);
    AddGet(TJsonObject, 'Contains', TJsonObject_Contains, 1, [varEmpty], varEmpty);
    AddGet(TJsonObject, 'Count', TJsonObject_Read_Count, 0, [varEmpty], varEmpty);
    AddGet(TJsonObject, 'Create', TJsonObject_Create, 0, [varEmpty], varEmpty);
    AddGet(TJsonObject, 'Delete', TJsonObject_Delete, 1, [varEmpty], varEmpty);
    AddGet(TJsonObject, 'Extract', TJsonObject_Extract, 1, [varEmpty], varEmpty);
    AddGet(TJsonObject, 'ExtractArray', TJsonObject_ExtractArray, 1, [varEmpty], varEmpty);
    AddGet(TJsonObject, 'ExtractObject', TJsonObject_ExtractObject, 1, [varEmpty], varEmpty);
    AddGet(TJsonObject, 'IndexOf', TJsonObject_IndexOf, 1, [varEmpty], varEmpty);
    AddGet(TJsonObject, 'IsNull', TJsonObject_IsNull, 1, [varEmpty], varEmpty);
    AddIGet(TJsonObject, 'Names', TJsonObject_Read_Names, 1, [varEmpty], varEmpty);
    AddGet(TJsonObject, 'Parse', TJsonObject_Parse, 1, [varEmpty], varEmpty);
    AddGet(TJsonObject, 'Remove', TJsonObject_Remove, 1, [varEmpty], varEmpty);
    AddIGet(TJsonObject, 'Types', TJsonObject_Read_Types, 1, [varEmpty], varEmpty);

  end;
end;

end.
