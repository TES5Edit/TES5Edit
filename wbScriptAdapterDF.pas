{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbScriptAdapterDF;

interface

uses
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

implementation

uses
  Classes,
  wbDataFormat,
  wbDataFormatNif,
  wbDataFormatMaterial,
  wbDataFormatMisc;

const
  sDFUnitName = 'wbDataFormat';


procedure JvInterpreter_dfFloatToStr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := dfFloatToStr(Args.Values[0]);
end;

procedure JvInterpreter_dfStrToFloat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := dfStrToFloat(Args.Values[0]);
end;

procedure JvInterpreter_dfCalcHash(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := dfCalcHash(Args.Values[0]);
end;


{ TdfDef }

procedure TdfDef_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  //Value := O2V(TdfDef.Create(V2O(Args.Values[0]) as TComponent));
end;

procedure TdfDef_Read_Name(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfDef(Args.Obj).Name;
end;

procedure TdfDef_DefaultDataSize(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfDef(Args.Obj).DefaultDataSize;
end;

procedure TdfDef_DefaultValue(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfDef(Args.Obj).DefaultDataSize;
end;

procedure TdfDef_Size(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfDef(Args.Obj).Size;
end;



{ TdfElement }

procedure TdfElement_DataType(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).DataType;
end;

procedure TdfElement_Def(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TdfElement(Args.Obj).Def);
end;

procedure TdfElement_Name(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).Name;
end;

procedure TdfElement_Path(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).Path;
end;

procedure TdfElement_Root(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TdfElement(Args.Obj).Root);
end;

procedure TdfElement_Read_Parent(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TdfElement(Args.Obj).Parent);
end;

procedure TdfElement_Write_Parent(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).Parent := TdfElement(V2O(Value));
end;

procedure TdfElement_DataSize(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).DataSize;
end;

procedure TdfElement_BeginUpdate(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).BeginUpdate;
end;

procedure TdfElement_EndUpdate(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).EndUpdate;
end;

procedure TdfElement_Read_Enabled(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).Enabled;
end;

procedure TdfElement_Write_Enabled(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).Enabled := Value;
end;

procedure TdfElement_Read_Count(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).Count;
end;

procedure TdfElement_Write_Count(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).Count := Value;
end;

procedure TdfElement_Index(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).Index;
end;

procedure TdfElement_IndexOf(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).IndexOf(TdfElement(V2O(Args.Values[0])));
end;

procedure TdfElement_Add(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TdfElement(Args.Obj).Add);
end;

procedure TdfElement_Remove(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).Remove;
end;

procedure TdfElement_Delete(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).Delete(Args.Values[0]);
end;

procedure TdfElement_Move(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).Move(Args.Values[0], Args.Values[1]);
end;

procedure TdfElement_LinksTo(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TdfElement(Args.Obj).LinksTo);
end;

procedure TdfElement_Read_NativeValue(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).NativeValue;
end;

procedure TdfElement_Write_NativeValue(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).NativeValue := Value;
end;

procedure TdfElement_Read_NativeValues(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).NativeValues[Args.Values[0]];
end;

procedure TdfElement_Write_NativeValues(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).NativeValues[Args.Values[0]] := Value;
end;

procedure TdfElement_Read_EditValue(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).EditValue;
end;

procedure TdfElement_Write_EditValue(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).EditValue := Value;
end;

procedure TdfElement_Read_EditValues(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).EditValues[Args.Values[0]];
end;

procedure TdfElement_Write_EditValues(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).EditValues[Args.Values[0]] := Value;
end;

procedure TdfElement_Read_Items(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TdfElement(Args.Obj).Items[Args.Values[0]]);
end;

procedure TdfElement_Read_Elements(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TdfElement(Args.Obj).Elements[Args.Values[0]]);
end;

procedure TdfElement_ElementByName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TdfElement(Args.Obj).ElementByName(Args.Values[0], Args.Values[1]));
end;

procedure TdfElement_ElementByPath(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TdfElement(Args.Obj).ElementByPath(Args.Values[0], Args.Values[1]));
end;

procedure TdfElement_LoadFromData(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).LoadFromData(Args.Values[0]);
end;

procedure TdfElement_LoadFromFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).LoadFromFile(Args.Values[0]);
end;

procedure TdfElement_LoadFromJSONFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).LoadFromJSONFile(Args.Values[0]);
end;

procedure TdfElement_LoadFromResource(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
   0: JvInterpreterError(ieNotEnoughParams, -1);
   1: TdfElement(Args.Obj).LoadFromResource(Args.Values[0]);
   2: TdfElement(Args.Obj).LoadFromResource(Args.Values[0], Args.Values[1]);
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TdfElement_SaveToFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).SaveToFile(Args.Values[0]);
end;

procedure TdfElement_SaveToJSONFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).SaveToJSONFile(Args.Values[0], Args.Values[1]);
end;

procedure TdfElement_SetToDefault(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).SetToDefault;
end;

procedure TdfElement_Assign(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).Assign(TdfElement(V2O(Args.Values[0])));
end;

procedure TdfElement_FromJSON(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TdfElement(Args.Obj).FromJSON(Args.Values[0]);
end;

procedure TdfElement_ToJSON(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).ToJSON(Args.Values[0]);
end;

procedure TdfElement_ToText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TdfElement(Args.Obj).ToText;
end;



{ TwbNiRef }

procedure TwbNiRef_Template(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbNiRef(Args.Obj).Template;
end;

procedure TwbNiRef_Ptr(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbNiRef(Args.Obj).Ptr;
end;


{ TwbNifBlock }

procedure TwbNifBlock_BlockType(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbNifBlock(Args.Obj).BlockType;
end;

procedure TwbNifBlock_NifFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifBlock(Args.Obj).NifFile);
end;

procedure TwbNifBlock_RefsCount(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbNifBlock(Args.Obj).RefsCount;
end;

procedure TwbNifBlock_Read_Refs(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifBlock(Args.Obj).Refs[Args.Values[0]]);
end;

procedure TwbNifBlock_StringsCount(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbNifBlock(Args.Obj).StringsCount;
end;

procedure TwbNifBlock_Read_Strings(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifBlock(Args.Obj).Strings[Args.Values[0]]);
end;

procedure TwbNifBlock_IsNiObject(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
   0: JvInterpreterError(ieNotEnoughParams, -1);
   1: Value := TwbNifBlock(Args.Obj).IsNiObject(Args.Values[0]);
   2: Value := TwbNifBlock(Args.Obj).IsNiObject(Args.Values[0], Args.Values[1]);
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TwbNifBlock_AddChild(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifBlock(Args.Obj).AddChild(Args.Values[0]));
end;

procedure TwbNifBlock_AddExtraData(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifBlock(Args.Obj).AddExtraData(Args.Values[0]));
end;

procedure TwbNifBlock_AddProperty(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifBlock(Args.Obj).AddProperty(Args.Values[0]));
end;

procedure TwbNifBlock_PropertyByName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifBlock(Args.Obj).PropertyByName(Args.Values[0]));
end;

procedure TwbNifBlock_ExtraDataByName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifBlock(Args.Obj).ExtraDataByName(Args.Values[0]));
end;

procedure TwbNifBlock_ChildrenByType(var Value: Variant; Args: TJvInterpreterArgs);
var
  b: TwbNifBlock;
  lst: TList;
begin
  case Args.Count of
    0, 1: JvInterpreterError(ieNotEnoughParams, -1);
    2: begin
      lst := TList(V2O(Args.Values[1]));
      if Assigned(lst) then
        for b in TwbNifBlock(Args.Obj).ChildrenByType(Args.Values[0]) do lst.Add(b);
    end;
    3: begin
      lst := TList(V2O(Args.Values[2]));
      if Assigned(lst) then
        for b in TwbNifBlock(Args.Obj).ChildrenByType(Args.Values[0], Args.Values[1]) do lst.Add(b);
    end else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TwbNifBlock_ChildByType(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
   0: JvInterpreterError(ieNotEnoughParams, -1);
   1: Value := O2V(TwbNifBlock(Args.Obj).ChildByType(Args.Values[0]));
   2: Value := O2V(TwbNifBlock(Args.Obj).ChildByType(Args.Values[0], Args.Values[1]));
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TwbNifBlock_PropertiesByType(var Value: Variant; Args: TJvInterpreterArgs);
var
  b: TwbNifBlock;
  lst: TList;
begin
  case Args.Count of
    0, 1: JvInterpreterError(ieNotEnoughParams, -1);
    2: begin
      lst := TList(V2O(Args.Values[1]));
      if Assigned(lst) then
        for b in TwbNifBlock(Args.Obj).PropertiesByType(Args.Values[0]) do lst.Add(b);
    end;
    3: begin
      lst := TList(V2O(Args.Values[2]));
      if Assigned(lst) then
        for b in TwbNifBlock(Args.Obj).PropertiesByType(Args.Values[0], Args.Values[1]) do lst.Add(b);
    end else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TwbNifBlock_PropertyByType(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
   0: JvInterpreterError(ieNotEnoughParams, -1);
   1: Value := O2V(TwbNifBlock(Args.Obj).PropertyByType(Args.Values[0]));
   2: Value := O2V(TwbNifBlock(Args.Obj).PropertyByType(Args.Values[0], Args.Values[1]));
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TwbNifBlock_ExtraDatasByType(var Value: Variant; Args: TJvInterpreterArgs);
var
  b: TwbNifBlock;
  lst: TList;
begin
  case Args.Count of
    0, 1: JvInterpreterError(ieNotEnoughParams, -1);
    2: begin
      lst := TList(V2O(Args.Values[1]));
      if Assigned(lst) then
        for b in TwbNifBlock(Args.Obj).ExtraDatasByType(Args.Values[0]) do lst.Add(b);
    end;
    3: begin
      lst := TList(V2O(Args.Values[2]));
      if Assigned(lst) then
        for b in TwbNifBlock(Args.Obj).ExtraDatasByType(Args.Values[0], Args.Values[1]) do lst.Add(b);
    end else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TwbNifBlock_ExtraDataByType(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
   0: JvInterpreterError(ieNotEnoughParams, -1);
   1: Value := O2V(TwbNifBlock(Args.Obj).ExtraDataByType(Args.Values[0]));
   2: Value := O2V(TwbNifBlock(Args.Obj).ExtraDataByType(Args.Values[0], Args.Values[1]));
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TwbNifBlock_UpdateBounds(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbNifBlock(Args.Obj).UpdateBounds;
end;

procedure TwbNifBlock_UpdateNormals(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
   0: Value := TwbNifBlock(Args.Obj).UpdateNormals;
   1: Value := TwbNifBlock(Args.Obj).UpdateNormals(Args.Values[0]);
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TwbNifBlock_UpdateTangents(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
   0: Value := TwbNifBlock(Args.Obj).UpdateTangents;
   1: Value := TwbNifBlock(Args.Obj).UpdateTangents(Args.Values[0]);
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TwbNifBlock_GetAssetsList(var Value: Variant; Args: TJvInterpreterArgs);
var
  s: string;
begin
  case Args.Count of
   0: Value := TwbNifBlock(Args.Obj).GetAssetsList;
   1: for s in TwbNifBlock(Args.Obj).GetAssetsList do TStrings(V2O(Args.Values[0])).Add(s);
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;



{ TwbNifFile }

procedure TwbNifFile_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifFile.Create);
end;

procedure TwbNifFile_Read_NifVersion(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbNifFile(Args.Obj).NifVersion;
end;

procedure TwbNifFile_Write_NifVersion(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TwbNifFile(Args.Obj).NifVersion := Value;
end;

procedure TwbNifFile_Read_InternalUpdates(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbNifFile(Args.Obj).InternalUpdates;
end;

procedure TwbNifFile_Write_InternalUpdates(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TwbNifFile(Args.Obj).InternalUpdates := Value;
end;

procedure TwbNifFile_Read_Options(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := S2V(Byte(TwbNifFile(Args.Obj).Options));
end;

procedure TwbNifFile_Write_Options(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TwbNifFile(Args.Obj).Options := TwbNifOptions(Byte(V2S(Value)));
end;

procedure TwbNifFile_Header(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifFile(Args.Obj).Header);
end;

procedure TwbNifFile_Footer(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifFile(Args.Obj).Footer);
end;

procedure TwbNifFile_BlocksCount(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbNifFile(Args.Obj).BlocksCount;
end;

procedure TwbNifFile_Read_Blocks(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifFile(Args.Obj).Blocks[Args.Values[0]]);
end;

procedure TwbNifFile_AddBlock(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifFile(Args.Obj).AddBlock(Args.Values[0]));
end;

procedure TwbNifFile_InsertBlock(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifFile(Args.Obj).InsertBlock(Args.Values[0], Args.Values[1]));
end;

procedure TwbNifFile_ConvertBlock(var Value: Variant; Args: TJvInterpreterArgs);
begin
  TwbNifFile(Args.Obj).ConvertBlock(Args.Values[0], Args.Values[1]);
end;

procedure TwbNifFile_CopyBlock(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifFile(Args.Obj).CopyBlock(Args.Values[0]));
end;

procedure TwbNifFile_BlockByType(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
   0: JvInterpreterError(ieNotEnoughParams, -1);
   1: Value := O2V(TwbNifFile(Args.Obj).BlockByType(Args.Values[0]));
   2: Value := O2V(TwbNifFile(Args.Obj).BlockByType(Args.Values[0], Args.Values[1]));
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TwbNifFile_BlocksByType(var Value: Variant; Args: TJvInterpreterArgs);
var
  b: TwbNifBlock;
  lst: TList;
begin
  case Args.Count of
    0, 1: JvInterpreterError(ieNotEnoughParams, -1);
    2: begin
      lst := TList(V2O(Args.Values[1]));
      if Assigned(lst) then
        for b in TwbNifFile(Args.Obj).BlocksByType(Args.Values[0]) do lst.Add(b);
    end;
    3: begin
      lst := TList(V2O(Args.Values[2]));
      if Assigned(lst) then
        for b in TwbNifFile(Args.Obj).BlocksByType(Args.Values[0], Args.Values[1]) do lst.Add(b);
    end else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure TwbNifFile_BlockByName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbNifFile(Args.Obj).BlockByName(Args.Values[0]));
end;

procedure TwbNifFile_SpellTriangulate(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbNifFile(Args.Obj).SpellTriangulate;
end;

procedure TwbNifFile_SpellFaceNormals(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbNifFile(Args.Obj).SpellFaceNormals;
end;

procedure TwbNifFile_SpellUpdateTangents(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbNifFile(Args.Obj).SpellUpdateTangents;
end;

procedure TwbNifFile_SpellAddUpdateTangents(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TwbNifFile(Args.Obj).SpellAddUpdateTangents;
end;

procedure TwbNifFile_GetAssetsList(var Value: Variant; Args: TJvInterpreterArgs);
var
  s: string;
begin
  case Args.Count of
   0: Value := TwbNifFile(Args.Obj).GetAssetsList;
   1: for s in TwbNifFile(Args.Obj).GetAssetsList do TStrings(V2O(Args.Values[0])).Add(s);
   else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;




{ TwbBGSMFile }

procedure TwbBGSMFile_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbBGSMFile.Create);
end;


{ TwbBGEMFile }

procedure TwbBGEMFile_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbBGEMFile.Create);
end;


{ TwbLODTreeLSTFile }

procedure TwbLODTreeLSTFile_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbLODTreeLSTFile.Create);
end;


{ TwbLODTreeBTTFile }

procedure TwbLODTreeBTTFile_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbLODTreeBTTFile.Create);
end;


{ TwbLODSettingsFO3File }

procedure TwbLODSettingsFO3File_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbLODSettingsFO3File.Create);
end;


{ TwbLODSettingsTES5File }

procedure TwbLODSettingsTES5File_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbLODSettingsTES5File.Create);
end;


{ TwbFUZFile }

procedure TwbFUZFile_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbFUZFile.Create);
end;


{ TwbDDSFile }

procedure TwbDDSFile_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbDDSFile.Create);
end;


procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin

    // 'dt' prefix conflicts with xEdit's data types for plugins, use 'dft' instead
    AddConst(sDFUnitName, 'dftNone', Ord(TdfDataType.dtNone));
    AddConst(sDFUnitName, 'dftStruct', Ord(TdfDataType.dtStruct));
    AddConst(sDFUnitName, 'dftArray', Ord(TdfDataType.dtArray));
    AddConst(sDFUnitName, 'dftUnion', Ord(TdfDataType.dtUnion));
    AddConst(sDFUnitName, 'dftMerge', Ord(TdfDataType.dtMerge));
    AddConst(sDFUnitName, 'dftBytes', Ord(TdfDataType.dtBytes));
    AddConst(sDFUnitName, 'dftChars', Ord(TdfDataType.dtChars));
    AddConst(sDFUnitName, 'dftU8', Ord(TdfDataType.dtU8));
    AddConst(sDFUnitName, 'dftS8', Ord(TdfDataType.dtS8));
    AddConst(sDFUnitName, 'dftU16', Ord(TdfDataType.dtU16));
    AddConst(sDFUnitName, 'dftS16', Ord(TdfDataType.dtS16));
    AddConst(sDFUnitName, 'dftU32', Ord(TdfDataType.dtU32));
    AddConst(sDFUnitName, 'dftS32', Ord(TdfDataType.dtS32));
    AddConst(sDFUnitName, 'dftU64', Ord(TdfDataType.dtU64));
    AddConst(sDFUnitName, 'dftS64', Ord(TdfDataType.dtS64));
    AddConst(sDFUnitName, 'dftFloat16', Ord(TdfDataType.dtFloat16));
    AddConst(sDFUnitName, 'dftFloat32', Ord(TdfDataType.dtFloat32));

    AddFunction(sDFUnitName, 'dfFloatToStr', JvInterpreter_dfFloatToStr, 1, [varEmpty], varEmpty);
    AddFunction(sDFUnitName, 'dfStrToFloat', JvInterpreter_dfStrToFloat, 1, [varEmpty], varEmpty);
    AddFunction(sDFUnitName, 'dfCalcHash', JvInterpreter_dfCalcHash, 1, [varEmpty], varEmpty);

    { TdfDef }
    AddClass(sDFUnitName, TdfDef, 'TdfDef');
    //AddGet(TdfDef, 'Create', TdfDef_Create, 1, [varEmpty], varEmpty);
    AddGet(TdfDef, 'Name', TdfDef_Read_Name, 0, [varEmpty], varEmpty);
    AddGet(TdfDef, 'DefaultDataSize', TdfDef_DefaultDataSize, 0, [varEmpty], varEmpty);
    AddGet(TdfDef, 'DefaultValue', TdfDef_DefaultValue, 0, [varEmpty], varEmpty);
    AddGet(TdfDef, 'Size', TdfDef_Size, 0, [varEmpty], varEmpty);

    { TdfElement }
    AddClass(sDFUnitName, TdfElement, 'TdfElement');
    AddGet(TdfElement, 'DataType', TdfElement_DataType, 0, [varEmpty], varEmpty);
    AddGet(TdfElement, 'Def', TdfElement_Def, 0, [varEmpty], varEmpty);
    AddGet(TdfElement, 'Name', TdfElement_Name, 0, [varEmpty], varEmpty);
    AddGet(TdfElement, 'Path', TdfElement_Path, 0, [varEmpty], varEmpty);
    AddGet(TdfElement, 'Root', TdfElement_Root, 0, [varEmpty], varEmpty);
    AddGet(TdfElement, 'Parent', TdfElement_Read_Parent, 0, [varEmpty], varEmpty);
    AddSet(TdfElement, 'Parent', TdfElement_Write_Parent, 0, [varEmpty]);
    AddGet(TdfElement, 'DataSize', TdfElement_DataSize, 0, [varEmpty], varEmpty);
    AddGet(TdfElement, 'BeginUpdate', TdfElement_BeginUpdate, 0, [varEmpty], varEmpty);
    AddGet(TdfElement, 'EndUpdate', TdfElement_EndUpdate, 0, [varEmpty], varEmpty);
    AddGet(TdfElement, 'Enabled', TdfElement_Read_Enabled, 0, [varEmpty], varEmpty);
    AddSet(TdfElement, 'Enabled', TdfElement_Write_Enabled, 0, [varEmpty]);
    AddGet(TdfElement, 'Count', TdfElement_Read_Count, 0, [varEmpty], varEmpty);
    AddSet(TdfElement, 'Count', TdfElement_Write_Count, 0, [varEmpty]);
    AddGet(TdfElement, 'Index', TdfElement_Index, 0, [varEmpty], varEmpty);
    AddGet(TdfElement, 'IndexOf', TdfElement_IndexOf, 1, [varEmpty], varEmpty);
    AddGet(TdfElement, 'Add', TdfElement_Add, 0, [varEmpty], varEmpty);
    AddGet(TdfElement, 'Remove', TdfElement_Remove, 0, [varEmpty], varEmpty);
    AddGet(TdfElement, 'Delete', TdfElement_Delete, 1, [varEmpty], varEmpty);
    AddGet(TdfElement, 'Move', TdfElement_Move, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TdfElement, 'LinksTo', TdfElement_LinksTo, 0, [varEmpty], varEmpty);
    AddGet(TdfElement, 'NativeValue', TdfElement_Read_NativeValue, 0, [varEmpty], varEmpty);
    AddSet(TdfElement, 'NativeValue', TdfElement_Write_NativeValue, 0, [varEmpty]);
    AddIGet(TdfElement, 'NativeValues', TdfElement_Read_NativeValues, 1, [varEmpty], varEmpty);
    AddISet(TdfElement, 'NativeValues', TdfElement_Write_NativeValues, 1, [varNull]);
    AddGet(TdfElement, 'EditValue', TdfElement_Read_EditValue, 0, [varEmpty], varEmpty);
    AddSet(TdfElement, 'EditValue', TdfElement_Write_EditValue, 0, [varEmpty]);
    AddIGet(TdfElement, 'EditValues', TdfElement_Read_EditValues, 1, [varEmpty], varEmpty);
    AddISet(TdfElement, 'EditValues', TdfElement_Write_EditValues, 1, [varNull]);
    AddIGet(TdfElement, 'Items', TdfElement_Read_Items, 1, [varEmpty], varEmpty);
    AddIDGet(TdfElement, TdfElement_Read_Items, 1, [varEmpty], varEmpty);
    AddIGet(TdfElement, 'Elements', TdfElement_Read_Elements, 1, [varEmpty], varEmpty);
    AddGet(TdfElement, 'ElementByName', TdfElement_ElementByName, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TdfElement, 'ElementByPath', TdfElement_ElementByPath, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TdfElement, 'LoadFromData', TdfElement_LoadFromData, 1, [varEmpty], varEmpty);
    AddGet(TdfElement, 'LoadFromFile', TdfElement_LoadFromFile, 1, [varEmpty], varEmpty);
    AddGet(TdfElement, 'LoadFromJSONFile', TdfElement_LoadFromJSONFile, 1, [varEmpty], varEmpty);
    AddGet(TdfElement, 'LoadFromResource', TdfElement_LoadFromResource, -1, [varEmpty, varEmpty], varEmpty);
    AddGet(TdfElement, 'SaveToFile', TdfElement_SaveToFile, 1, [varEmpty], varEmpty);
    AddGet(TdfElement, 'SaveToJSONFile', TdfElement_SaveToJSONFile, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TdfElement, 'SetToDefault', TdfElement_SetToDefault, 0, [varEmpty], varEmpty);
    AddGet(TdfElement, 'Assign', TdfElement_Assign, 1, [varEmpty], varEmpty);
    AddGet(TdfElement, 'FromJSON', TdfElement_FromJSON, 1, [varEmpty], varEmpty);
    AddGet(TdfElement, 'ToJSON', TdfElement_ToJSON, 1, [varEmpty], varEmpty);
    AddGet(TdfElement, 'ToText', TdfElement_ToText, 0, [varEmpty], varEmpty);

    { TdfValue }
    AddClass(sDFUnitName, TdfValueDef, 'TdfValueDef');
    AddClass(sDFUnitName, TdfValue, 'TdfValue');

    { TdfContainer }
    AddClass(sDFUnitName, TdfContainer, 'TdfContainer');

    { TdfArray }
    AddClass(sDFUnitName, TdfArrayDef, 'TdfArrayDef');
    AddClass(sDFUnitName, TdfArray, 'TdfArray');

    { TdfStruct }
    AddClass(sDFUnitName, TdfStructDef, 'TdfStructDef');
    AddClass(sDFUnitName, TdfStruct, 'TdfStruct');

    { TdfUnion }
    AddClass(sDFUnitName, TdfUnionDef, 'TdfUnionDef');
    AddClass(sDFUnitName, TdfUnion, 'TdfUnion');

    { TdfValueUnion }
    AddClass(sDFUnitName, TdfValueUnionDef, 'TdfValueUnionDef');
    AddClass(sDFUnitName, TdfValueUnion, 'TdfValueUnion');

    { TdfMerge }
    AddClass(sDFUnitName, TdfMergeDef, 'TdfMergeDef');
    AddClass(sDFUnitName, TdfMerge, 'TdfMerge');

    { TdfInteger }
    AddClass(sDFUnitName, TdfIntegerDef, 'TdfIntegerDef');
    AddClass(sDFUnitName, TdfInteger, 'TdfInteger');
    AddClass(sDFUnitName, TdfMappedIntegerDef, 'TdfMappedIntegerDef');

    { TdfFlags }
    AddClass(sDFUnitName, TdfFlagsDef, 'TdfFlagsDef');
    AddClass(sDFUnitName, TdfFlags, 'TdfFlags');

    { TdfEnum }
    AddClass(sDFUnitName, TdfEnumDef, 'TdfEnumDef');
    AddClass(sDFUnitName, TdfEnum, 'TdfEnum');

    { TdfFloat }
    AddClass(sDFUnitName, TdfFloatDef, 'TdfFloatDef');
    AddClass(sDFUnitName, TdfFloat, 'TdfFloat');

    { TdfBytes }
    AddClass(sDFUnitName, TdfBytesDef, 'TdfBytesDef');
    AddClass(sDFUnitName, TdfBytes, 'TdfBytes');

    { TdfChars }
    AddClass(sDFUnitName, TdfCharsDef, 'TdfCharsDef');
    AddClass(sDFUnitName, TdfChars, 'TdfChars');


    { NIF }

    { TwbNifOptions }
    AddConst(sDFUnitName, 'nfoCollapseLinkArrays', Ord(TwbNifOption.nfoCollapseLinkArrays));
    AddConst(sDFUnitName, 'nfoRemoveUnusedStrings', Ord(TwbNifOption.nfoRemoveUnusedStrings));

    { TwbNifVersion }
    AddConst(sDFUnitName, 'nfTES3', Ord(TwbNifVersion.nfTES3));
    AddConst(sDFUnitName, 'nfTES4', Ord(TwbNifVersion.nfTES4));
    AddConst(sDFUnitName, 'nfFO3', Ord(TwbNifVersion.nfFO3));
    AddConst(sDFUnitName, 'nfTES5', Ord(TwbNifVersion.nfTES5));
    AddConst(sDFUnitName, 'nfSSE', Ord(TwbNifVersion.nfSSE));
    AddConst(sDFUnitName, 'nfFO4', Ord(TwbNifVersion.nfFO4));

    { TwbNiRef }
    AddClass(sDFUnitName, TwbNiRefDef, 'TwbNiRefDef');
    AddClass(sDFUnitName, TwbNiRef, 'TwbNiRef');
    AddGet(TwbNiRef, 'Template', TwbNiRef_Template, 0, [varEmpty], varEmpty);
    AddGet(TwbNiRef, 'Ptr', TwbNiRef_Ptr, 0, [varEmpty], varEmpty);

    { TwbNifBlock }
    AddClass(sDFUnitName, TwbNifBlockDef, 'TwbNifBlockDef');
    AddClass(sDFUnitName, TwbNifBlock, 'TwbNifBlock');
    AddGet(TwbNifBlock, 'BlockType', TwbNifBlock_BlockType, 0, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'NifFile', TwbNifBlock_NifFile, 0, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'RefsCount', TwbNifBlock_RefsCount, 0, [varEmpty], varEmpty);
    AddIGet(TwbNifBlock, 'Refs', TwbNifBlock_Read_Refs, 1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'StringsCount', TwbNifBlock_StringsCount, 0, [varEmpty], varEmpty);
    AddIGet(TwbNifBlock, 'Strings', TwbNifBlock_Read_Strings, 1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'IsNiObject', TwbNifBlock_IsNiObject, -1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'AddChild', TwbNifBlock_AddChild, 1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'AddExtraData', TwbNifBlock_AddExtraData, 1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'AddProperty', TwbNifBlock_AddProperty, 1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'PropertyByName', TwbNifBlock_PropertyByName, 1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'ExtraDataByName', TwbNifBlock_ExtraDataByName, 1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'ChildrenByType', TwbNifBlock_ChildrenByType, -1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'ChildByType', TwbNifBlock_ChildByType, -1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'PropertiesByType', TwbNifBlock_PropertiesByType, -1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'PropertyByType', TwbNifBlock_PropertyByType, -1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'ExtraDatasByType', TwbNifBlock_ExtraDatasByType, -1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'ExtraDataByType', TwbNifBlock_ExtraDataByType, -1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'UpdateBounds', TwbNifBlock_UpdateBounds, 0, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'UpdateNormals', TwbNifBlock_UpdateNormals, -1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'UpdateTangents', TwbNifBlock_UpdateTangents, -1, [varEmpty], varEmpty);
    AddGet(TwbNifBlock, 'GetAssetsList', TwbNifBlock_GetAssetsList, -1, [varEmpty], varEmpty);

    { TwbNifFile }
    AddClass(sDFUnitName, TwbNifFile, 'TwbNifFile');
    AddGet(TwbNifFile, 'Create', TwbNifFile_Create, 0, [varEmpty], varEmpty);
    AddGet(TwbNifFile, 'NifVersion', TwbNifFile_Read_NifVersion, 0, [varEmpty], varEmpty);
    AddSet(TwbNifFile, 'NifVersion', TwbNifFile_Write_NifVersion, 0, [varEmpty]);
    AddGet(TwbNifFile, 'InternalUpdates', TwbNifFile_Read_InternalUpdates, 0, [varEmpty], varEmpty);
    AddSet(TwbNifFile, 'InternalUpdates', TwbNifFile_Write_InternalUpdates, 0, [varEmpty]);
    AddGet(TwbNifFile, 'Options', TwbNifFile_Read_Options, 0, [varEmpty], varEmpty);
    AddSet(TwbNifFile, 'Options', TwbNifFile_Write_Options, 0, [varEmpty]);
    AddGet(TwbNifFile, 'Header', TwbNifFile_Header, 0, [varEmpty], varEmpty);
    AddGet(TwbNifFile, 'Footer', TwbNifFile_Footer, 0, [varEmpty], varEmpty);
    AddGet(TwbNifFile, 'BlocksCount', TwbNifFile_BlocksCount, 0, [varEmpty], varEmpty);
    AddIGet(TwbNifFile, 'Blocks', TwbNifFile_Read_Blocks, 1, [varEmpty], varEmpty);
    AddGet(TwbNifFile, 'AddBlock', TwbNifFile_AddBlock, 1, [varEmpty], varEmpty);
    AddGet(TwbNifFile, 'InsertBlock', TwbNifFile_InsertBlock, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TwbNifFile, 'ConvertBlock', TwbNifFile_ConvertBlock, 2, [varEmpty, varEmpty], varEmpty);
    AddGet(TwbNifFile, 'CopyBlock', TwbNifFile_CopyBlock, 1, [varEmpty, varEmpty], varEmpty);
    AddGet(TwbNifFile, 'BlockByType', TwbNifFile_BlockByType, -1, [varEmpty], varEmpty);
    AddGet(TwbNifFile, 'BlocksByType', TwbNifFile_BlocksByType, -1, [varEmpty], varEmpty);
    AddGet(TwbNifFile, 'BlockByName', TwbNifFile_BlockByName, 1, [varEmpty], varEmpty);
    AddGet(TwbNifFile, 'SpellTriangulate', TwbNifFile_SpellTriangulate, 0, [varEmpty], varEmpty);
    AddGet(TwbNifFile, 'SpellFaceNormals', TwbNifFile_SpellFaceNormals, 0, [varEmpty], varEmpty);
    AddGet(TwbNifFile, 'SpellUpdateTangents', TwbNifFile_SpellUpdateTangents, 0, [varEmpty], varEmpty);
    AddGet(TwbNifFile, 'SpellAddUpdateTangents', TwbNifFile_SpellAddUpdateTangents, 0, [varEmpty], varEmpty);
    AddGet(TwbNifFile, 'GetAssetsList', TwbNifFile_GetAssetsList, -1, [varEmpty], varEmpty);


    { Others }

    { TwbBGSMFile }
    AddClass(sDFUnitName, TwbBGSMFile, 'TwbBGSMFile');
    AddGet(TwbBGSMFile, 'Create', TwbBGSMFile_Create, 0, [varEmpty], varEmpty);

    { TwbBGEMFile }
    AddClass(sDFUnitName, TwbBGEMFile, 'TwbBGEMFile');
    AddGet(TwbBGEMFile, 'Create', TwbBGEMFile_Create, 0, [varEmpty], varEmpty);

    { TwbLODTreeLSTFile }
    AddClass(sDFUnitName, TwbLODTreeLSTFile, 'TwbLODTreeLSTFile');
    AddGet(TwbLODTreeLSTFile, 'Create', TwbLODTreeLSTFile_Create, 0, [varEmpty], varEmpty);

    { TwbLODTreeBTTFile }
    AddClass(sDFUnitName, TwbLODTreeBTTFile, 'TwbLODTreeBTTFile');
    AddGet(TwbLODTreeBTTFile, 'Create', TwbLODTreeBTTFile_Create, 0, [varEmpty], varEmpty);

    { TwbLODSettingsFO3File }
    AddClass(sDFUnitName, TwbLODSettingsFO3File, 'TwbLODSettingsFO3File');
    AddGet(TwbLODSettingsFO3File, 'Create', TwbLODSettingsFO3File_Create, 0, [varEmpty], varEmpty);

    { TwbLODSettingsTES5File }
    AddClass(sDFUnitName, TwbLODSettingsTES5File, 'TwbLODSettingsTES5File');
    AddGet(TwbLODSettingsTES5File, 'Create', TwbLODSettingsTES5File_Create, 0, [varEmpty], varEmpty);

    { TwbFUZFile }
    AddClass(sDFUnitName, TwbFUZFile, 'TwbFUZFile');
    AddGet(TwbFUZFile, 'Create', TwbFUZFile_Create, 0, [varEmpty], varEmpty);

    { TwbDDSFile }
    AddClass(sDFUnitName, TwbDDSFile, 'TwbDDSFile');
    AddGet(TwbDDSFile, 'Create', TwbDDSFile_Create, 0, [varEmpty], varEmpty);

  end;
end;

procedure Init;
begin
  RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
end;

initialization
  Init;

end.
