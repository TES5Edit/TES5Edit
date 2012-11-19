  // FormID+prefixed array assertion debug
  //12226
  // error 3109 4787 4727 13066 13325 3889
  // 13132
unit wbScriptAdapter;

interface

uses
  Windows,
  Classes,
  SysUtils,
  Variants,
  wbInterface,
  wbImplementation;

implementation

uses
  JvInterpreter_System,
  JvInterpreter_SysUtils,
  JvInterpreter_Classes,
  JvInterpreter_Dialogs,
  JvInterpreter_Windows,
  //JvInterpreter_JvEditor,
  JvInterpreter;

{ TElement }

procedure _Assigned(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Assigned(V2O(Args.Values[0]));
  //Value := Assigned(IInterface(Args.Values[0]));
end;

procedure AddMessage(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if Assigned(wbProgressCallback) and (VarIsStr(Args.Values[0])) then
    wbProgressCallback(Args.Values[0]);
end;

//procedure IwbElement_Name(var Value: Variant; Args: TJvInterpreterArgs);
//var
//  Element: IwbElement;
//begin
//  Value := '';
//  if Supports(IInterface(Pointer(Args.Obj)), IwbElement, Element) then
//    Value := Element.Name;
//end;

procedure IwbElement_Name(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.Name;
end;

procedure IwbElement_Path(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.Path;
end;

procedure IwbElement_FullPath(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.FullPath;
end;

procedure IwbElement_Signature(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbHasSignature;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbHasSignature, Element) then
    Value := string(Element.Signature);
end;

procedure IwbElement_FormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Element.FormID;
end;

procedure IwbElement_FixedFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Element.FixedFormID;
end;

procedure IwbElement_ElementType(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.ElementType;
end;

procedure IwbElement_GetIsEditable(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Element.IsEditable;
end;

procedure IwbElement_GetIsDeleted(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Element.IsDeleted;
end;

procedure IwbElement_SetIsDeleted(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Element.IsDeleted := Args.Values[1];
end;

procedure IwbElement_GetIsInitiallyDisabled(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Element.IsInitiallyDisabled;
end;

procedure IwbElement_SetIsInitiallyDisabled(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Element.IsInitiallyDisabled := Args.Values[1];
end;

procedure IwbElement_GetIsPersistent(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Element.IsPersistent;
end;

procedure IwbElement_SetIsPersistent(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Element.IsPersistent := Args.Values[1];
end;

procedure IwbElement_GetFormVersion(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Cardinal(Element.Version);
end;

procedure IwbElement_SetFormVersion(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Element.Version := Args.Values[1];
end;

procedure IwbElement_OverrideCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Element.OverrideCount;
end;

procedure IwbElement_OverrideByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Element.Overrides[Args.Values[1]];
end;

procedure IwbElement_SortKey(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.Sortkey[Args.Values[1]];
end;

procedure IwbElement_GetEditValue(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.EditValue;
end;

procedure IwbElement_SetEditValue(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.EditValue := string(Args.Values[1]);
end;

procedure IwbElement_GetNativeValue(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.NativeValue;
end;

procedure IwbElement_SetNativeValue(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.NativeValue := Args.Values[1];
end;

procedure IwbElement_GetElementEditValues(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementEditValues[Args.Values[1]];
end;

procedure IwbElement_SetElementEditValues(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Container.ElementEditValues[Args.Values[1]] := Args.Values[2];
end;

procedure IwbElement_GetElementNativeValues(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementNativeValues[Args.Values[1]];
end;

procedure IwbElement_SetElementNativeValues(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Container.ElementNativeValues[Args.Values[1]] := Args.Values[2];
end;

procedure IwbElement_ElementByName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementByName[Args.Values[1]];
end;

procedure IwbElement_ElementBySignature(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
  Signature: TwbSignature;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then begin
    Signature := StrToSignature(Args.Values[1]);
    Value := Container.ElementBySignature[Signature];
  end;
end;

procedure IwbElement_ElementByPath(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementByPath[Args.Values[1]];
end;

procedure IwbElement_ElementCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementCount;
end;

procedure IwbElement_ElementByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.Elements[Args.Values[1]];
end;

procedure IwbElement_ElementExists(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementExists[string(Args.Values[1])];
end;

procedure IwbElement_AddElement(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.Add(Args.Values[1], Args.Values[2]);
end;

procedure IwbElement_AddElementElement(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    if Supports(IInterface(Args.Values[1]), IwbElement, Element) then
      Container.AddElement(Element);
end;

procedure IwbElement_RemoveElement(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.RemoveElement(string(Args.Values[1]));
end;

procedure IwbElement_GetFile(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element._File;
end;

procedure IwbElement_LinksTo(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.LinksTo;
end;

procedure IwbElement_Master(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Element.Master;
end;

procedure IwbElement_MasterOrSelf(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Element.MasterOrSelf;
end;

procedure IwbElement_IsMaster(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Element.IsMaster;
end;

procedure IwbElement_IsWinningOverride(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Element.IsWinningOverride;
end;

procedure IwbElement_WinningOverride(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, Element) then
    Value := Element.WinningOverride;
end;

procedure IwbElement_Assign(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element, Element2: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    if Supports(IInterface(Args.Values[2]), IwbElement, Element2) then
      Element.Assign(Args.Values[1], Element2, Args.Values[3]);
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
    if Assigned(Element._File) then
      Value := Element._File.FileName
end;

procedure IwbFile_GetLoadOrder(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.LoadOrder;
end;

procedure IwbFile_MasterCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.MasterCount;
end;

procedure IwbFile_MasterByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    if Args.Values[1] < _File.MasterCount then
      Value := _File.Masters[Args.Values[1]];
end;

procedure IwbFile_GroupBySignature(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.GroupBySignature[StrToSignature(Args.Values[1])];
end;

procedure IwbFile_RecordByFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.RecordByFormID[Cardinal(Args.Values[1]), Args.Values[2]];
end;

procedure IwbFile_RecordByEditorID(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.RecordByEditorID[string(Args.Values[1])];
end;

procedure IwbFile_AddMasterIfMissing(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    _File.AddMasterIfMissing(string(Args.Values[1]));
end;

procedure _wbCopyElementToFile(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    if Supports(IInterface(Args.Values[1]), IwbFile, _File) then
      Value := wbCopyElementToFile(Element, _File, Args.Values[2], Args.Values[3], '', '', '');
end;

procedure _wbCopyElementToRecord(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    if Supports(IInterface(Args.Values[1]), IwbMainRecord, MainRecord) then
      Value := wbCopyElementToRecord(Element, MainRecord, Args.Values[2], Args.Values[3]);
end;

{ Missing code }

procedure Pascal_Inc(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Inc(Args.Values[0]);
end;

procedure Pascal_Dec(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Dec(Args.Values[0]);
end;

procedure TStrings_Read_Delimiter(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TStrings(Args.Obj).Delimiter;
end;

procedure TStrings_Write_Delimiter(const Value: Variant; Args: TJvInterpreterArgs);
begin
  if length(string(Value)) > 0 then
    TStrings(Args.Obj).Delimiter := string(Value)[1];
end;

procedure TStrings_Write_StrictDelimiter(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TStrings(Args.Obj).StrictDelimiter := Value;
end;

procedure TStrings_Read_DelimitedText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := TStrings(Args.Obj).DelimitedText;
end;

procedure TStrings_Write_DelimitedText(const Value: Variant; Args: TJvInterpreterArgs);
begin
  TStrings(Args.Obj).DelimitedText := Value;
end;

procedure JvInterpreter_SameText(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := SameText(string(Args.Values[0]), string(Args.Values[1]));
end;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
const
  cUnit = 'Dummy';
begin
  with JvInterpreterAdapter do begin
    AddConst(cUnit, 'gmTES4', ord(gmTES4));
    AddConst(cUnit, 'gmTES5', ord(gmTES5));
    AddConst(cUnit, 'gmFO3', ord(gmFO3));
    AddConst(cUnit, 'gmFNV', ord(gmFNV));

    AddConst(cUnit, 'etFile', ord(etFile));
    AddConst(cUnit, 'etMainRecord', ord(etMainRecord));
    AddConst(cUnit, 'etGroupRecord', ord(etGroupRecord));
    AddConst(cUnit, 'etSubRecord', ord(etSubRecord));
    AddConst(cUnit, 'etSubRecordStruct', ord(etSubRecordStruct));
    AddConst(cUnit, 'etSubRecordArray', ord(etSubRecordArray));
    //AddConst(cUnit, 'etSubRecordUnion', ord(atSubRecordUnion));
    AddConst(cUnit, 'etArray', ord(etArray));
    AddConst(cUnit, 'etStruct', ord(etStruct));
    AddConst(cUnit, 'etValue', ord(etValue));
    AddConst(cUnit, 'etFlag', ord(etFlag));
    AddConst(cUnit, 'etStringListTerminator', ord(etStringListTerminator));

    AddFunction(cUnit, 'Assigned', _Assigned, 1, [varEmpty], varEmpty);
    //AddIntfGet(IwbElement, 'Name', IwbElement_Name, 0, [VarEmpty], varEmpty);
    AddFunction(cUnit, 'AddMessage', AddMessage, 1, [varString], varEmpty);
    AddFunction(cUnit, 'Name', IwbElement_Name, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'Path', IwbElement_Path, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FullPath', IwbElement_FullPath, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'Signature', IwbElement_Signature, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FormID', IwbElement_FormID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FixedFormID', IwbElement_FixedFormID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementType', IwbElement_ElementType, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsEditable', IwbElement_GetIsEditable, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsDeleted', IwbElement_GetIsDeleted, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetIsDeleted', IwbElement_SetIsDeleted, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'GetIsInitiallyDisabled', IwbElement_GetIsInitiallyDisabled, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetIsInitiallyDisabled', IwbElement_SetIsInitiallyDisabled, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'GetIsPersistent', IwbElement_GetIsPersistent, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetIsPersistent', IwbElement_SetIsPersistent, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'GetFormVersion', IwbElement_GetFormVersion, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetFormVersion', IwbElement_SetFormVersion, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'OverrideCount', IwbElement_OverrideCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'OverrideByIndex', IwbElement_OverrideByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'SortKey', IwbElement_SortKey, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'GetEditValue', IwbElement_GetEditValue, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetEditValue', IwbElement_SetEditValue, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'GetNativeValue', IwbElement_GetNativeValue, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetNativeValue', IwbElement_SetNativeValue, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'GetElementEditValues', IwbElement_GetElementEditValues, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'SetElementEditValues', IwbElement_SetElementEditValues, 3, [varEmpty, varString, varString], varEmpty);
    AddFunction(cUnit, 'GetElementNativeValues', IwbElement_GetElementNativeValues, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'SetElementNativeValues', IwbElement_SetElementNativeValues, 3, [varEmpty, varString, varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementByName', IwbElement_ElementByName, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'ElementBySignature', IwbElement_ElementBySignature, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'ElementByPath', IwbElement_ElementByPath, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'ElementCount', IwbElement_ElementCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementByIndex', IwbElement_ElementByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'ElementExists', IwbElement_ElementExists, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'AddElement', IwbElement_AddElement, 3, [varEmpty, varString, varBoolean], varEmpty);
    AddFunction(cUnit, 'AddElementElement', IwbElement_AddElementElement, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'RemoveElement', IwbElement_RemoveElement, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'LinksTo', IwbElement_LinksTo, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'Master', IwbElement_Master, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MasterOrSelf', IwbElement_MasterOrSelf, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IsMaster', IwbElement_IsMaster, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IsWinningOverride', IwbElement_IsWinningOverride, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'WinningOverride', IwbElement_WinningOverride, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementAssign', IwbElement_Assign, 4, [varEmpty, varInteger, varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'GetFile', IwbElement_GetFile, 1, [varEmpty], varEmpty);

    AddFunction(cUnit, 'GetFileName', IwbFile_GetFileName, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetLoadOrder', IwbFile_GetLoadOrder, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MasterCount', IwbFile_MasterCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MasterByIndex', IwbFile_MasterByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'GroupBySignature', IwbFile_GroupBySignature, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'RecordByFormID', IwbFile_RecordByFormID, 3, [varEmpty, varInteger, varBoolean], varEmpty);
    AddFunction(cUnit, 'RecordByEditorID', IwbFile_RecordByEditorID, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'AddMasterIfMissing', IwbFile_AddMasterIfMissing, 2, [varEmpty, varString], varEmpty);

    AddFunction(cUnit, 'wbCopyElementToFile', _wbCopyElementToFile, 4, [varEmpty, varEmpty, varBoolean, varBoolean], varEmpty);
    AddFunction(cUnit, 'wbCopyElementToRecord', _wbCopyElementToRecord, 4, [varEmpty, varEmpty, varBoolean, varBoolean], varEmpty);

    // missing indentifiers from Windows unit
    //AddConst('Windows', 'IDOK', IDOK);
    AddConst(cUnit, 'LowInteger', Low(Integer));
    AddConst(cUnit, 'HighInteger', High(Integer));
    AddFunction(cUnit, 'Inc', Pascal_Inc, 1, [varByRef], varEmpty);
    AddFunction(cUnit, 'Dec', Pascal_Dec, 1, [varByRef], varEmpty);
    AddFunction('SysUtils', 'SameText', JvInterpreter_SameText, 2, [varString, varString], varEmpty);

    // add missing JvInterpreter code
    AddGet(TStrings, 'Delimiter', TStrings_Read_Delimiter, 0, [varEmpty], varEmpty);
    AddSet(TStrings, 'Delimiter', TStrings_Write_Delimiter, 0, [varEmpty]);
    AddSet(TStrings, 'StrictDelimiter', TStrings_Write_StrictDelimiter, 0, [varEmpty]);
    AddGet(TStrings, 'DelimitedText', TStrings_Read_DelimitedText, 0, [varEmpty], varEmpty);
    AddSet(TStrings, 'DelimitedText', TStrings_Write_DelimitedText, 0, [varEmpty]);

  end;
end;

procedure Init;
begin
  RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_System.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_SysUtils.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Classes.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Dialogs.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Windows.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  //JvInterpreter_JvEditor.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
end;

initialization
  Init;

end.
