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
  //JvInterpreter_Math,
  //JvInterpreter_JvEditor,
  JvInterpreter_Buttons,
  JvInterpreter_Comctrls,
  JvInterpreter_Contnrs,
  JvInterpreter_Controls,
  JvInterpreter_StdCtrls,
  JvInterpreter_ExtCtrls,
  JvInterpreter_Forms,
  JvInterpreter_Graphics,
  JvInterpreter_Menus,
  JvInterpreter;

{ TElement }

//procedure IwbElement_Name(var Value: Variant; Args: TJvInterpreterArgs);
//var
//  Element: IwbElement;
//begin
//  Value := '';
//  if Supports(IInterface(Pointer(Args.Obj)), IwbElement, Element) then
//    Value := Element.Name;
//end;

procedure _Assigned(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Assigned(V2O(Args.Values[0]));
end;

procedure AddMessage(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if Assigned(wbProgressCallback) and (VarIsStr(Args.Values[0])) then
    wbProgressCallback(Args.Values[0]);
end;

procedure EnableSkyrimSaveFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  wbTestWrite := True;
  wbForceNewHeader := True;
end;

{ IwbElement }

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

procedure IwbElement_ElementType(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.ElementType;
end;

procedure IwbElement_DefType(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    if Assigned(Element.ValueDef) then
      Value := Element.ValueDef.DefType;
end;

procedure IwbElement_IsInjected(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.IsInjected;
end;

procedure IwbElement_GetIsEditable(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.IsEditable;
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

procedure IwbElement_Remove(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.Remove;
end;

procedure IwbElement_GetFile(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element._File;
end;

procedure IwbElement_GetContainer(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.Container;
end;

procedure IwbElement_ContainingMainRecord(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.ContainingMainRecord;
end;

procedure IwbElement_LinksTo(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.LinksTo;
end;

procedure IwbElement_Check(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.Check;
end;

procedure IwbElement_Assign(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element, Element2: IwbElement;
begin
  Element2 := nil;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    if (V2O(Args.Values[2]) = nil) or Supports(IInterface(Args.Values[2]), IwbElement, Element2) then
      Value := Element.Assign(Args.Values[1], Element2, Args.Values[3]);
end;

procedure IwbElement_Equals(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element, Element2: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    if Supports(IInterface(Args.Values[1]), IwbElement, Element2) then
      Value := Element.Equals(Element2);
end;

procedure IwbElement_CanContainFormIDs(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.CanContainFormIDs;
end;

procedure IwbElement_CanMoveUp(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.CanMoveUp;
end;

procedure IwbElement_CanMoveDown(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.CanMoveDown;
end;

procedure IwbElement_MoveUp(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.MoveUp;
end;

procedure IwbElement_MoveDown(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.MoveDown;
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


{ IwbContainer }

procedure IwbContainer_GetElementEditValues(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementEditValues[Args.Values[1]];
end;

procedure IwbContainer_SetElementEditValues(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Container.ElementEditValues[Args.Values[1]] := Args.Values[2];
end;

procedure IwbContainer_GetElementNativeValues(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementNativeValues[Args.Values[1]];
end;

procedure IwbContainer_SetElementNativeValues(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Container.ElementNativeValues[Args.Values[1]] := Args.Values[2];
end;

procedure IwbContainer_ElementByName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementByName[Args.Values[1]];
end;

procedure IwbContainer_ElementBySignature(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
  Signature: TwbSignature;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then begin
    Signature := StrToSignature(Args.Values[1]);
    Value := Container.ElementBySignature[Signature];
  end;
end;

procedure IwbContainer_ElementByPath(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementByPath[Args.Values[1]];
end;

procedure IwbContainer_AdditionalElementCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.AdditionalElementCount;
end;

procedure IwbContainer_ElementCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementCount;
end;

procedure IwbContainer_ElementByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.Elements[Args.Values[1]];
end;

procedure IwbContainer_ElementExists(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementExists[string(Args.Values[1])];
end;

procedure IwbContainer_LastElement(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.LastElement;
end;

procedure IwbContainer_IndexOf(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
  Element: IwbElement;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    if Supports(IInterface(Args.Values[1]), IwbElement, Element) then
      Value := Container.IndexOf(Element);
end;

procedure IwbContainer_Add(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.Add(Args.Values[1], Args.Values[2]);
end;

procedure IwbContainer_AddElement(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    if Supports(IInterface(Args.Values[1]), IwbElement, Element) then
      Container.AddElement(Element);
end;

procedure IwbContainer_InsertElement(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    if Supports(IInterface(Args.Values[1]), IwbElement, Element) then
      Container.InsertElement(integer(Args.Values[1]), Element);
end;

procedure IwbContainer_RemoveElement(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
  Element: IwbElement;
  vtyp: integer;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then begin
    vtyp := VarType(Args.Values[1]);
    case vtyp of
      varInteger, varInt64, varWord, varLongWord, varShortInt:
         Value := Container.RemoveElement(integer(Args.Values[1]), True);
      varString, varUString:
         Value := Container.RemoveElement(string(Args.Values[1]));
    else
      if Supports(IInterface(Args.Values[1]), IwbElement, Element) then
        Value := Container.RemoveElement(Element, True);
    end;
  end;
end;

procedure IwbContainer_RemoveByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.RemoveElement(integer(Args.Values[1]), boolean(Args.Values[2]));
end;

procedure IwbContainer_ReverseElements(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Container.ReverseElements;
end;


{ IwbMainRecord }

procedure IwbMainRecord_Signature(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbHasSignature;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbHasSignature, Element) then
    Value := string(Element.Signature);
end;

procedure IwbMainRecord_FormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.FormID;
end;

procedure IwbMainRecord_FixedFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.FixedFormID;
end;

procedure IwbMainRecord_GetLoadOrderFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.LoadOrderFormID;
end;

procedure IwbMainRecord_SetLoadOrderFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.LoadOrderFormID := Cardinal(Args.Values[1]);
end;

procedure IwbMainRecord_GetIsDeleted(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.IsDeleted;
end;

procedure IwbMainRecord_SetIsDeleted(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.IsDeleted := Args.Values[1];
end;

procedure IwbMainRecord_GetIsInitiallyDisabled(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.IsInitiallyDisabled;
end;

procedure IwbMainRecord_SetIsInitiallyDisabled(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.IsInitiallyDisabled := Args.Values[1];
end;

procedure IwbMainRecord_GetIsPersistent(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.IsPersistent;
end;

procedure IwbMainRecord_SetIsPersistent(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.IsPersistent := Args.Values[1];
end;

procedure IwbMainRecord_GetIsVisibleWhenDistant(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.IsVisibleWhenDistant;
end;

procedure IwbMainRecord_SetIsVisibleWhenDistant(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.IsVisibleWhenDistant := Args.Values[1];
end;

procedure IwbMainRecord_GetFormVersion(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := Cardinal(MainRecord.Version);
end;

procedure IwbMainRecord_SetFormVersion(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.Version := Args.Values[1];
end;

procedure IwbMainRecord_OverrideCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.OverrideCount;
end;

procedure IwbMainRecord_OverrideByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.Overrides[Args.Values[1]];
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

procedure IwbMainRecord_ChildGroup(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.ChildGroup;
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
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.IsWinningOverride;
end;

procedure IwbMainRecord_WinningOverride(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.WinningOverride;
end;

procedure IwbMainRecord_CompareExchangeFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.CompareExchangeFormID(Cardinal(Args.Values[1]), Cardinal(Args.Values[2]));
end;


{ IwbGroupRecord }

procedure IwbGroupRecord_GroupType(var Value: Variant; Args: TJvInterpreterArgs);
var
  GroupRecord: IwbGroupRecord;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbGroupRecord, GroupRecord) then
    Value := GroupRecord.GroupType;
end;

procedure IwbGroupRecord_ChildrenOf(var Value: Variant; Args: TJvInterpreterArgs);
var
  GroupRecord: IwbGroupRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbGroupRecord, GroupRecord) then
    Value := GroupRecord.ChildrenOf;
end;


{ IwbFile }

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

procedure IwbFile_GetIsESM(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.IsESM;
end;

procedure IwbFile_SetIsESM(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    _File.IsESM := Args.Values[1];
end;

procedure IwbFile_SortMasters(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    _File.SortMasters;
end;

procedure IwbFile_CleanMasters(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    _File.CleanMasters;
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

procedure IwbFile_RecordCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.RecordCount;
end;

procedure IwbFile_RecordByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    if Args.Values[1] < _File.MasterCount then
      Value := _File.Records[Args.Values[1]];
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

procedure IwbFile_HasMaster(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.HasMaster(StrToSignature(Args.Values[1]));
end;

procedure IwbFile_HasGroup(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.HasGroup(StrToSignature(Args.Values[1]));
end;

procedure IwbFile_LoadOrderFormIDtoFileFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.LoadOrderFormIDtoFileFormID(Args.Values[1]);
end;

procedure IwbFile_FileFormIDtoLoadOrderFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.FileFormIDtoLoadOrderFormID(Args.Values[1]);
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

procedure JvInterpreter_StringReplace(var Value: Variant; Args: TJvInterpreterArgs);
var
  rf: TReplaceFlags;
  f: byte;
begin
  f := V2S(Args.Values[2]);
  if (f and ord(rfReplaceAll)) > 0 then rf := rf + [rfReplaceAll];
  if (f and ord(rfIgnoreCase)) > 0 then rf := rf + [rfIgnoreCase];
  Value := StringReplace(Args.Values[0], Args.Values[1], Args.Values[2], rf);
end;

procedure JvInterpreter_IntToHex64(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := IntToHex64(Args.Values[0], Args.Values[1]);
end;

procedure JvInterpreter_StrToInt64(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrToInt64(Args.Values[0]);
end;

procedure JvInterpreter_StrToInt64Def(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := StrToInt64Def(Args.Values[0], Args.Values[1]);
end;


procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
const
  cUnit = 'Dummy';
begin
  with JvInterpreterAdapter do begin
    //AddIntfGet(IwbElement, 'Name', IwbElement_Name, 0, [VarEmpty], varEmpty);
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
    AddConst(cUnit, 'etSubRecordUnion', ord(atSubRecordUnion));
    AddConst(cUnit, 'etArray', ord(etArray));
    AddConst(cUnit, 'etStruct', ord(etStruct));
    AddConst(cUnit, 'etValue', ord(etValue));
    AddConst(cUnit, 'etFlag', ord(etFlag));
    AddConst(cUnit, 'etStringListTerminator', ord(etStringListTerminator));

    { TwbDefType }
    AddConst(cUnit, 'dtRecord', ord(dtRecord));
    AddConst(cUnit, 'dtSubRecord', ord(dtSubRecord));
    AddConst(cUnit, 'dtSubRecordArray', ord(dtSubRecordArray));
    AddConst(cUnit, 'dtSubRecordStruct', ord(dtSubRecordStruct));
    AddConst(cUnit, 'dtSubRecordUnion', ord(dtSubRecordUnion));
    AddConst(cUnit, 'dtString', ord(dtString));
    AddConst(cUnit, 'dtLString', ord(dtLString));
    AddConst(cUnit, 'dtLenString', ord(dtLenString));
    AddConst(cUnit, 'dtByteArray', ord(dtByteArray));
    AddConst(cUnit, 'dtInteger', ord(dtInteger));
    AddConst(cUnit, 'dtIntegerFormater', ord(dtIntegerFormater));
    AddConst(cUnit, 'dtFloat', ord(dtFloat));
    AddConst(cUnit, 'dtArray', ord(dtArray));
    AddConst(cUnit, 'dtStruct', ord(dtStruct));
    AddConst(cUnit, 'dtUnion', ord(dtUnion));
    AddConst(cUnit, 'dtEmpty', ord(dtEmpty));

    AddFunction(cUnit, 'Assigned', _Assigned, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'AddMessage', AddMessage, 1, [varString], varEmpty);
    AddFunction(cUnit, 'EnableSkyrimSaveFormat', EnableSkyrimSaveFormat, 0, [], varEmpty);

    { IwbElement }
    AddFunction(cUnit, 'Name', IwbElement_Name, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'Path', IwbElement_Path, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FullPath', IwbElement_FullPath, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementType', IwbElement_ElementType, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'DefType', IwbElement_DefType, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SortKey', IwbElement_SortKey, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'IsInjected', IwbElement_IsInjected, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IsEditable', IwbElement_GetIsEditable, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetEditValue', IwbElement_GetEditValue, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetEditValue', IwbElement_SetEditValue, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'GetNativeValue', IwbElement_GetNativeValue, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetNativeValue', IwbElement_SetNativeValue, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'Remove', IwbElement_Remove, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetFile', IwbElement_GetFile, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetContainer', IwbElement_GetContainer, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ContainingMainRecord', IwbElement_ContainingMainRecord, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'LinksTo', IwbElement_LinksTo, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'Check', IwbElement_Check, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementAssign', IwbElement_Assign, 4, [varEmpty, varInteger, varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'Equals', IwbElement_Equals, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'CanContainFormIDs', IwbElement_CanContainFormIDs, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CanMoveUp', IwbElement_CanMoveUp, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CanMoveDown', IwbElement_CanMoveDown, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MoveUp', IwbElement_MoveUp, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MoveDown', IwbElement_MoveDown, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbCopyElementToFile', _wbCopyElementToFile, 4, [varEmpty, varEmpty, varBoolean, varBoolean], varEmpty);
    AddFunction(cUnit, 'wbCopyElementToRecord', _wbCopyElementToRecord, 4, [varEmpty, varEmpty, varBoolean, varBoolean], varEmpty);

    { IwbContainer }
    AddFunction(cUnit, 'GetElementEditValues', IwbContainer_GetElementEditValues, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'SetElementEditValues', IwbContainer_SetElementEditValues, 3, [varEmpty, varString, varString], varEmpty);
    AddFunction(cUnit, 'GetElementNativeValues', IwbContainer_GetElementNativeValues, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'SetElementNativeValues', IwbContainer_SetElementNativeValues, 3, [varEmpty, varString, varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementByName', IwbContainer_ElementByName, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'ElementBySignature', IwbContainer_ElementBySignature, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'ElementByPath', IwbContainer_ElementByPath, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'AdditionalElementCount', IwbContainer_AdditionalElementCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementCount', IwbContainer_ElementCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementByIndex', IwbContainer_ElementByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'ElementExists', IwbContainer_ElementExists, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'LastElement', IwbContainer_LastElement, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IndexOf', IwbContainer_LastElement, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'Add', IwbContainer_Add, 3, [varEmpty, varString, varBoolean], varEmpty);
    AddFunction(cUnit, 'AddElement', IwbContainer_AddElement, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'InsertElement', IwbContainer_InsertElement, 3, [varEmpty, varInteger, varEmpty], varEmpty);
    AddFunction(cUnit, 'RemoveElement', IwbContainer_RemoveElement, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'RemoveByIndex', IwbContainer_RemoveByIndex, 3, [varEmpty, varInteger, varBoolean], varEmpty);
    AddFunction(cUnit, 'ReverseElements', IwbContainer_ReverseElements, 1, [varEmpty], varEmpty);

    { IwbMainRecord }
    AddFunction(cUnit, 'Signature', IwbMainRecord_Signature, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FormID', IwbMainRecord_FormID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FixedFormID', IwbMainRecord_FixedFormID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetLoadOrderFormID', IwbMainRecord_GetLoadOrderFormID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetLoadOrderFormID', IwbMainRecord_SetLoadOrderFormID, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsDeleted', IwbMainRecord_GetIsDeleted, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetIsDeleted', IwbMainRecord_SetIsDeleted, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'GetIsInitiallyDisabled', IwbMainRecord_GetIsInitiallyDisabled, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetIsInitiallyDisabled', IwbMainRecord_SetIsInitiallyDisabled, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'GetIsPersistent', IwbMainRecord_GetIsPersistent, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetIsPersistent', IwbMainRecord_SetIsPersistent, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'GetIsVisibleWhenDistant', IwbMainRecord_GetIsVisibleWhenDistant, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetIsVisibleWhenDistant', IwbMainRecord_SetIsVisibleWhenDistant, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'GetFormVersion', IwbMainRecord_GetFormVersion, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetFormVersion', IwbMainRecord_SetFormVersion, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'OverrideCount', IwbMainRecord_OverrideCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'OverrideByIndex', IwbMainRecord_OverrideByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'ReferencedByCount', IwbMainRecord_ReferencedByCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ReferencedByIndex', IwbMainRecord_ReferencedByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'Master', IwbMainRecord_Master, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MasterOrSelf', IwbMainRecord_MasterOrSelf, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IsMaster', IwbMainRecord_IsMaster, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IsWinningOverride', IwbMainRecord_IsWinningOverride, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'WinningOverride', IwbMainRecord_WinningOverride, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ChildGroup', IwbMainRecord_ChildGroup, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CompareExchangeFormID', IwbMainRecord_CompareExchangeFormID, 3, [varEmpty, varEmpty, varEmpty], varEmpty);

    { IwbGroupRecord }
    AddFunction(cUnit, 'GroupType', IwbGroupRecord_GroupType, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ChildrenOf', IwbGroupRecord_ChildrenOf, 1, [varEmpty], varEmpty);

    { IwbFile }
    AddFunction(cUnit, 'GetFileName', IwbFile_GetFileName, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetLoadOrder', IwbFile_GetLoadOrder, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsESM', IwbFile_GetIsESM, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetIsESM', IwbFile_SetIsESM, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'SortMasters', IwbFile_SortMasters, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CleanMasters', IwbFile_CleanMasters, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MasterCount', IwbFile_MasterCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MasterByIndex', IwbFile_MasterByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'RecordCount', IwbFile_RecordCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'RecordByIndex', IwbFile_RecordByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'GroupBySignature', IwbFile_GroupBySignature, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'RecordByFormID', IwbFile_RecordByFormID, 3, [varEmpty, varInteger, varBoolean], varEmpty);
    AddFunction(cUnit, 'RecordByEditorID', IwbFile_RecordByEditorID, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'AddMasterIfMissing', IwbFile_AddMasterIfMissing, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'HasMaster', IwbFile_HasMaster, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'HasGroup', IwbFile_HasGroup, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'LoadOrderFormIDtoFileFormID', IwbFile_LoadOrderFormIDtoFileFormID, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'FileFormIDtoLoadOrderFormID', IwbFile_FileFormIDtoLoadOrderFormID, 2, [varEmpty, varString], varEmpty);

    // missing funcs from JvInterpreter
    //AddConst('Windows', 'IDOK', IDOK);
    AddConst(cUnit, 'rfReplaceAll', Ord(rfReplaceAll));
    AddConst(cUnit, 'rfIgnoreCase', Ord(rfIgnoreCase));
    AddConst(cUnit, 'LowInteger', Low(Integer));
    AddConst(cUnit, 'HighInteger', High(Integer));
    AddFunction(cUnit, 'Inc', Pascal_Inc, 1, [varByRef], varEmpty);
    AddFunction(cUnit, 'Dec', Pascal_Dec, 1, [varByRef], varEmpty);
    AddFunction('SysUtils', 'SameText', JvInterpreter_SameText, 2, [varString, varString], varEmpty);
    AddFunction('SysUtils', 'StringReplace', JvInterpreter_StringReplace, 4, [varString, varString, varString, varEmpty], varEmpty);
    AddFunction('SysUtils', 'IntToHex64', JvInterpreter_IntToHex64, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('SysUtils', 'StrToInt64', JvInterpreter_StrToInt64, 1, [varEmpty], varEmpty);
    AddFunction('SysUtils', 'StrToInt64Def', JvInterpreter_StrToInt64Def, 2, [varEmpty, varEmpty], varEmpty);

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
  JvInterpreter_Graphics.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Controls.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Buttons.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_StdCtrls.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_ComCtrls.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_ExtCtrls.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Forms.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Dialogs.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Menus.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
end;

initialization
  Init;

end.
