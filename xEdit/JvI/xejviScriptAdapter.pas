{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptAdapter;

{$I xeDefines.inc}

interface

uses
  Classes,
  System.TypInfo,
  SysUtils,
  Variants,
  Windows,
  Graphics,
  wbInterface,
  wbImplementation,
  wbHelpers,
  wbBSA,
  wbLocalization,
  wbSort,
  wbNifScanner,
  wbBSArchive,
  wbLOD;

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
  JvInterpreter,
  JvInterpreterFm,
  xejviScriptAdapterMisc,
  xejviScriptAdapterDF;

const
  cUnit = 'Dummy';
  cInterface = 'wbInterface';
  cTwbVector = 'TwbVector';
  cTwbGridCell = 'TwbGridCell';


{ TElement }
//procedure IwbElement_Name(var Value: Variant; Args: TJvInterpreterArgs);
//var
//  Element: IwbElement;
//begin
//  Value := '';
//  if Supports(IInterface(Pointer(Args.Obj)), IwbElement, Element) then
//    Value := Element.Name;
//end;

function VarToCardinal(v: Variant): Cardinal;
var
  i64: Int64;
begin
  case VarType(v) and VarTypeMask of
    varSmallInt, varShortInt, varInteger, varByte, varWord, varLongWord:
      Result := v;
    varSingle, varDouble:
      Result := Round(v);
    varInt64, varUInt64:
      begin
        i64 := v;
        Result := Int64Rec(i64).Lo;
      end;
    varString, varUString:
      Result := StrToInt(v);
    else
      // will most likely cause an exception
      Result := v;
  end;
end;

procedure _Assigned(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Assigned(V2O(Args.Values[0]));
end;

procedure ObjectToElement(var Value: Variant; Args: TJvInterpreterArgs);
begin
  try
    Value := IwbElement(Pointer(V2O(Args.Values[0])));
  except
  end;
end;

procedure _FullPathToFilename(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := FullPathToFilename(String(Args.Values[0]));
end;

procedure EnableSkyrimSaveFormat(var Value: Variant; Args: TJvInterpreterArgs);
begin
  wbTestWrite := True;
  wbForceNewHeader := True;
end;

procedure GetRecordDefNames(var Value: Variant; Args: TJvInterpreterArgs);
var
  sl: TStrings;
  i: integer;
begin
  sl := TStrings(V2O(Args.Values[0]));

  if not Assigned(sl) then
    Exit;

  for i := Low(wbRecordDefs) to High(wbRecordDefs) do
    with wbRecordDefs[i].rdeDef do
      sl.Add(DefaultSignature + ' - ' + GetName);
end;

procedure wbFilterStrings(var Value: Variant; Args: TJvInterpreterArgs);
var
  slIn, slOut: TStrings;
  Filter: string;
  i: integer;
begin
  slIn := TStrings(V2O(Args.Values[0]));
  slOut := TStrings(V2O(Args.Values[1]));
  if not Assigned(slIn) or not Assigned(slOut) then
    Exit;
  Filter := Lowercase(string(Args.Values[2]));
  for i := 0 to Pred(slIn.Count) do
    if Pos(Filter, Lowercase(slIn[i])) > 0 then
      slOut.Add(slIn[i]);
end;

procedure wbRemoveDuplicateStrings(var Value: Variant; Args: TJvInterpreterArgs);
var
  sl: TStringList;
  i, j: integer;
begin
  sl := TStringList(V2O(Args.Values[0]));
  for i := Pred(sl.Count) downto 0 do begin
    sl.Find(sl[i], j);
    if (j <> -1) and (j <> i) then
      sl.Delete(i);
  end;
end;

procedure wbGetVersionNumber(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := VersionString.ToCardinal;
end;

{ TwbVector }

function wbVector2Var(const wbVector: TwbVector): Variant;
var
  Rec: ^TwbVector;
begin
  New(Rec);
  Rec^ := wbVector;
  Result := R2V(cTwbVector, Rec);
end;

function Var2wbVector(const wbVector: Variant): TwbVector;
begin
  Result := TwbVector(V2R(wbVector)^);
end;

procedure JvInterpreter_wbVector(var Value: Variant; Args: TJvInterpreterArgs);
var
  Rec: TwbVector;
begin
  Rec.x := Args.Values[0];
  Rec.y := Args.Values[1];
  Rec.z := Args.Values[2];
  Value := wbVector2Var(Rec);
end;


{ TwbGridCell }

function wbGridCell2Var(const wbGridCell: TwbGridCell): Variant;
var
  Rec: ^TwbGridCell;
begin
  New(Rec);
  Rec^ := wbGridCell;
  Result := R2V(cTwbGridCell, Rec);
end;

function Var2wbGridCell(const wbGridCell: Variant): TwbGridCell;
begin
  Result := TwbGridCell(V2R(wbGridCell)^);
end;

procedure JvInterpreter_wbGridCell(var Value: Variant; Args: TJvInterpreterArgs);
var
  Rec: TwbGridCell;
begin
  Rec.x := Args.Values[0];
  Rec.y := Args.Values[1];
  Value := wbGridCell2Var(Rec);
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

procedure IwbElement_ShortName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.ShortName;
end;

procedure IwbElement_BaseName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.BaseName;
end;

procedure IwbElement_DisplayName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.DisplayName[True];
end;

function IntToEsState(anInt: Integer): TwbElementState;
begin
  case anInt of
    0: Result := esModified;
    1: Result := esInternalModified;
    2: Result := esUnsaved;
    3: Result := esSortKeyValid;
    4: Result := esExtendedSortKeyValid;
    5: Result := esHidden;
    6: Result := esParentHidden;
    7: Result := esParentHiddenChecked;
    8: Result := esNotReachable;
    9: Result := esReachable;
    10: Result := esTagged;
    11: Result := esResolving;
    12: Result := esNotSuitableToAddTo;
  else
    Result := esDummy;
  end;
end;

procedure IwbElement_ClearElementState(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element : IwbElement;
  eState  : TwbElementState;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    try
      eState := IntToEsState(Args.Values[1]);
      Value := eState in Element.ElementStates;
      Element.SetElementState(eState, True);
    except

    end;
  end;
end;

procedure IwbElement_SetElementState(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element : IwbElement;
  eState  : TwbElementState;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    try
      eState := IntToEsState(Args.Values[1]);
      Value := eState in Element.ElementStates;
      Element.SetElementState(eState);
    except

    end;
  end;
end;

procedure IwbElement_GetElementState(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element : IwbElement;
  eState  : TwbElementState;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    try
      eState := IntToEsState(Args.Values[1]);
      Value := eState in Element.ElementStates;
    except

    end;
  end;
end;

procedure IwbElement_Path(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.Path;
end;

procedure IwbElement_IndexedPath(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.IndexedPath[Boolean(Args.Values[1])];
end;

procedure IwbElement_FullPath(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.FullPath;
end;

procedure IwbElement_PathName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.PathName;
end;

procedure IwbElement_ElementType(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.ElementType;
end;

procedure IwbElement_ElementTypeAsText(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := GetEnumName(TypeInfo(TwbElementType), Ord(Element.ElementType));
end;

procedure IwbElement_DefType(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
  begin
    var ValueDef: IwbValueDef := Element.ValueDef;
    if Assigned(ValueDef) then
      Value := ValueDef.DefType;
  end;
end;

procedure IwbElement_DefTypeAsText(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
  begin
    var ValueDef: IwbValueDef := Element.ValueDef;
    if Assigned(ValueDef) then
      Value := GetEnumName(TypeInfo(TwbDefType), Ord(ValueDef.DefType));
  end;
end;

procedure IwbElement_EnumValues(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element    : IwbElement;
  NamedDef   : IwbNamedDef;
  IntegerDef : IwbIntegerDef;
  Enums      : IwbEnumDef;
  i          : integer;
  s          : string;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    if Supports(Element.Def, IwbSubRecordDef) then
      NamedDef := (Element.Def as IwbSubrecordDef).Value
    else
      NamedDef := Element.Def;

    if Supports(NamedDef, IwbIntegerDef, IntegerDef) and
      Supports(IntegerDef.Formater[Element], IwbEnumDef, Enums) then begin

      for i := 0 to Pred(Enums.NameCount) do begin
        if i > 0 then s := s + #13#10;
        s := s + Enums.Names[i];
      end;

      Value := s;
    end;
  end;
end;

procedure IwbElement_FlagValues(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element    : IwbElement;
  NamedDef   : IwbNamedDef;
  IntegerDef : IwbIntegerDef;
  Flags      : IwbFlagsDef;
  i          : integer;
  s          : string;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    if Supports(Element.Def, IwbSubRecordDef) then
      NamedDef := (Element.Def as IwbSubrecordDef).Value
    else
      NamedDef := Element.Def;

    if Supports(NamedDef, IwbIntegerDef, IntegerDef) and
      Supports(IntegerDef.Formater[Element], IwbFlagsDef, Flags) then begin

      for i := 0 to Pred(Flags.FlagCount) do begin
        if i > 0 then s := s + #13#10;
        s := s + Flags.Flags[i, False];
      end;

      Value := s;
    end;
  end;
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
  Value := '';
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
  Value := '';
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
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    if Supports(IInterface(Args.Values[1]), IwbElement, Element2) then
      Value := Element.Equals(Element2);
end;

procedure IwbElement_CanContainFormIDs(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.CanContainFormIDs;
end;

procedure IwbElement_CanMoveUp(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.CanMoveUp;
end;

procedure IwbElement_CanMoveDown(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := False;
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

procedure IwbElement_ReportRequiredMasters(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    var lStrings := TStrings(V2O(Args.Values[1]));
    var lDict := TwbFilesDictionary.Create;
    try
      Element.ReportRequiredMasters(lDict, Args.Values[2], Args.Values[3]);
      for var lFile in lDict.Keys do
        lStrings.AddObject(lFile.FileName, Pointer(lFile));
    finally
      lDict.Free;
    end;
  end;
end;

procedure IwbElement_BuildRef(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.BuildRef;
end;

procedure IwbElement_MarkModifiedRecursive(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.MarkModifiedRecursive(AllElementTypes);
end;

procedure IwbElement_SetToDefault(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.SetToDefault;
end;

procedure IwbElement_BeginUpdate(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.BeginUpdate;
end;

procedure IwbElement_EndUpdate(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.EndUpdate;
end;

procedure IwbElement_GetSummary(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.GetSummary;
end;

procedure _wbCopyElementToFile(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    if Supports(IInterface(Args.Values[1]), IwbFile, _File) then
      Value := wbCopyElementToFile(Element, _File, Args.Values[2], Args.Values[3], '', '', '', '', False);
end;

procedure _wbCopyElementToFileWithPrefix(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    if Supports(IInterface(Args.Values[1]), IwbFile, _File) then
      Value := wbCopyElementToFile(Element, _File, Args.Values[2], Args.Values[3], Args.Values[4], '', Args.Values[5], Args.Values[6], False);
end;

procedure _wbCopyElementToFileWithPrefixAndSuffix(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    if Supports(IInterface(Args.Values[1]), IwbFile, _File) then
      Value := wbCopyElementToFile(Element, _File, Args.Values[2], Args.Values[3], Args.Values[4], Args.Values[5], Args.Values[6], Args.Values[7], False);
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
  Value := False;
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
    if Supports(IInterface(Args.Values[2]), IwbElement, Element) then
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

procedure IwbContainer_ContainerStates(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Word(Container.ContainerStates);
end;

procedure IwbContainer_IsSorted(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbSortableContainer;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbSortableContainer, Container) then
    Value := Container.Sorted;
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
    Value := MainRecord.FormID.ToCardinal;
end;

procedure IwbMainRecord_EditorID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.EditorID;
end;

procedure IwbMainRecord_SetEditorID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.EditorID := Args.Values[1];
end;

procedure IwbMainRecord_FixedFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.FixedFormID.ToCardinal;
end;

procedure IwbMainRecord_GetLoadOrderFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.LoadOrderFormID.ToCardinal;
end;

procedure IwbMainRecord_SetLoadOrderFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.LoadOrderFormID := TwbFormID.FromVar(Args.Values[1]);
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

procedure IwbMainRecord_GetFormVCS1(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.VCS1;
end;

procedure IwbMainRecord_SetFormVCS1(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.VCS1 := Args.Values[1];
end;

procedure IwbMainRecord_GetFormVCS2(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.VCS2;
end;

procedure IwbMainRecord_SetFormVCS2(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.VCS2 := Args.Values[1];
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

procedure IwbMainRecord_ReferencesCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.ReferencesCount;
end;

procedure IwbMainRecord_ReferencesByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.References[Args.Values[1]];
end;

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

procedure IwbMainRecord_UpdateRefs(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    MainRecord.UpdateRefs;
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
  Value := false;
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

procedure IwbMainRecord_HighestOverrideOrSelf(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.HighestOverrideOrSelf[Integer(Args.Values[1])];
end;

procedure IwbMainRecord_CompareExchangeFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.CompareExchangeFormID(TwbFormID.FromVar(Args.Values[1]), TwbFormID.FromVar(Args.Values[2]));
end;

procedure IwbMainRecord_ChangeFormSignature(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
  Signature: TwbSignature;
begin
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then begin
    Signature := StrToSignature(Args.Values[1]);
    MainRecord.ChangeFormSignature(Signature);
  end;
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

procedure IwbMainRecord_HasPrecombinedMesh(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.HasPrecombinedMesh;
end;

procedure IwbMainRecord_PrecombinedMesh(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord: IwbMainRecord;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Value := MainRecord.PrecombinedMesh;
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

procedure IwbGroupRecord_GroupLabel(var Value: Variant; Args: TJvInterpreterArgs);
var
  GroupRecord: IwbGroupRecord;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbGroupRecord, GroupRecord) then
    Value := GroupRecord.GroupLabel;
end;

procedure IwbGroupRecord_ChildrenOf(var Value: Variant; Args: TJvInterpreterArgs);
var
  GroupRecord: IwbGroupRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbGroupRecord, GroupRecord) then
    Value := GroupRecord.ChildrenOf;
end;

procedure IwbGroupRecord_MainRecordByEditorID(var Value: Variant; Args: TJvInterpreterArgs);
var
  GroupRecord: IwbGroupRecord;
begin
  if Supports(IInterface(Args.Values[0]), IwbGroupRecord, GroupRecord) then
    Value := GroupRecord. MainRecordByEditorID[string(Args.Values[1])];
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
  begin
    var ElementFile: IwbFile := Element._File;
    if Assigned(ElementFile) then
      Value := ElementFile.FileName;
  end;
end;

procedure IwbFile_GetLoadOrder(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := -1;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.LoadOrder;
end;

procedure IwbFile_GetNewFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.NewFormID.ToCardinal;
end;

procedure IwbFile_GetIsESM(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := False;
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

procedure IwbFile_CanBeESL(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    if (_File.LoadOrderFileID.IsLightSlot = true) then
        Value :=  true;
end;

procedure Misc_wbIsPseudoESLMode(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbIsEslSupported and wbPseudoESL;
end;

procedure IwbFile_GetIsESL(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.IsESL;
end;

procedure IwbFile_SetIsESL(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    _File.IsESL := Args.Values[1];
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
    Value := _File.MasterCount[True];
end;

procedure IwbFile_MasterByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    if Args.Values[1] < _File.MasterCount[True] then
      Value := _File.Masters[Args.Values[1], True];
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
    if Args.Values[1] < _File.RecordCount then
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
    Value := _File.RecordByFormID[TwbFormID.FromVar(Args.Values[1]), Args.Values[2], True];
end;

procedure IwbFile_RecordByEditorID(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.RecordByEditorID[string(Args.Values[1])];
end;

procedure IwbFile_GetMasters(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File : IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    _File.GetMasters(TStrings(V2O(Args.Values[1])));
end;

procedure IwbFile_AddMasters(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    _File.AddMasters(TStrings(V2O(Args.Values[1])));
end;

procedure IwbFile_AddMasterIfMissing(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    case Args.Count of
    0, 1: JvInterpreterError(ieNotEnoughParams, -1);
    3: _File.AddMasterIfMissing(string(Args.Values[1]), Boolean(Args.Values[2]));
    2: _File.AddMasterIfMissing(string(Args.Values[1]));
    else
     JvInterpreterError(ieTooManyParams, -1);
    end;
end;

procedure IwbFile_HasMaster(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.HasMaster(Args.Values[1]);
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
    Value := _File.LoadOrderFormIDtoFileFormID(TwbFormID.FromVar(Args.Values[1]), True).ToCardinal;
end;

procedure IwbFile_FileFormIDtoLoadOrderFormID(var Value: Variant; Args: TJvInterpreterArgs);
var
  _File: IwbFile;
begin
  if Supports(IInterface(Args.Values[0]), IwbFile, _File) then
    Value := _File.FileFormIDtoLoadOrderFormID(TwbFormID.FromVar(Args.Values[1]), True).ToCardinal;
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


{ wbContainerHandler }

procedure IwbContainerHandler_ResourceContainerList(var Value: Variant; Args: TJvInterpreterArgs);
begin
  wbContainerHandler.ContainerList(TStrings(V2O(Args.Values[0])));
end;

procedure IwbContainerHandler_ResourceList(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
    0, 1: JvInterpreterError(ieNotEnoughParams, -1);
    2: wbContainerHandler.ContainerResourceList(Args.Values[0], TStrings(V2O(Args.Values[1])));
    3: wbContainerHandler.ContainerResourceList(Args.Values[0], TStrings(V2O(Args.Values[1])), string(Args.Values[2]));
    else
     JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure IwbContainerHandler_ResourceExists(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbContainerHandler.ResourceExists(Args.Values[0]);
end;

procedure IwbContainerHandler_ResourceCount(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbContainerHandler.ResourceCount(Args.Values[0], TStrings(V2O(Args.Values[1])));
end;

procedure IwbContainerHandler_ResourceOpenData(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbContainerHandler.OpenResourceData(Args.Values[0], Args.Values[1]);
end;

procedure IwbContainerHandler_ResourceCopy(var Value: Variant; Args: TJvInterpreterArgs);
begin
  wbContainerHandler.ResourceCopy(Args.Values[0], Args.Values[1], Args.Values[2]);
end;


{ TwbFastStringList }

procedure TwbFastStringList_Create(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := O2V(TwbFastStringList.Create);
end;


{ Nif routines }

procedure NifUtils_NifBlockList(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := NifBlockList(TBytes(Args.Values[0]), TStrings(V2O(Args.Values[1])));
end;

procedure NifUtils_NifTextureList(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := NifTextures(TBytes(Args.Values[0]), TStrings(V2O(Args.Values[1])));
end;

procedure NifUtils_NifTextureListResource(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := NifTextures(wbContainerHandler.OpenResourceData(Args.Values[0], Args.Values[1]), TStrings(V2O(Args.Values[2])));
end;

procedure NifUtils_NifTextureListUVRange(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := NifTexturesUVRange(TBytes(Args.Values[0]), Single(Args.Values[1]), TStrings(V2O(Args.Values[2])));
end;


{ DDS routines }

procedure DDSUtils_wbDDSStreamToBitmap(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbDDSStreamToBitmap(TStream(V2O(Args.Values[0])), TBitmap(V2O(Args.Values[1])));
end;

procedure DDSUtils_wbDDSDataToBitmap(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbDDSDataToBitmap(TBytes(Args.Values[0]), TBitmap(V2O(Args.Values[1])));
end;

procedure DDSUtils_wbDDSResourceToBitmap(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbDDSDataToBitmap(wbContainerHandler.OpenResourceData('', Args.Values[0]), TBitmap(V2O(Args.Values[1])));
end;


{ Misc routines }

procedure Misc_wbFlipBitmap(var Value: Variant; Args: TJvInterpreterArgs);
begin
  wbFlipBitmap(TBitmap(V2O((Args.Values[0]))), Integer(Args.Values[1]));
end;

procedure Misc_wbAlphaBlend(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbAlphaBlend(
    Args.Values[0], // DestDC
    Args.Values[1], // X
    Args.Values[2], // Y
    Args.Values[3], // Width
    Args.Values[4], // Height
    Args.Values[5], // SrcDC
    Args.Values[6], // SrcX
    Args.Values[7], // SrcY
    Args.Values[8], // SrcWidth
    Args.Values[9], // SrcHeight
    Args.Values[10] // Alpha
  );
end;

procedure Misc_wbPositionToGridCell(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbGridCell2Var(wbPositionToGridCell(Var2wbVector(Args.Values[0])));
end;

procedure Misc_wbSubBlockFromGridCell(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbGridCell2Var(wbSubBlockFromGridCell(Var2wbGridCell(Args.Values[0])));
end;

procedure Misc_wbBlockFromSubBlock(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbGridCell2Var(wbBlockFromSubBlock(Var2wbGridCell(Args.Values[0])));
end;

procedure Misc_wbGridCellToGroupLabel(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbGridCellToGroupLabel(Var2wbGridCell(Args.Values[0]));
end;

procedure Misc_wbIsInGridCell(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbIsInGridCell(Var2wbVector(Args.Values[0]), Var2wbGridCell(Args.Values[1]));
end;

procedure Misc_wbCRC32Data(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbCRC32Data(Args.Values[0]);
end;

procedure Misc_wbCRC32Resource(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbCRC32Data(wbContainerHandler.OpenResourceData(Args.Values[0], Args.Values[1]));
end;

procedure Misc_wbCRC32File(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbCRC32File(string(Args.Values[0]));
end;

procedure Misc_CreateHashFO4(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := CreateHashFO4(string(Args.Values[0]));
end;

procedure Misc_bscrc32(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := bscrc32(string(Args.Values[0]));
end;

procedure Misc_wbSHA1Data(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbSHA1Data(Args.Values[0]);
end;

procedure Misc_wbSHA1File(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbSHA1File(string(Args.Values[0]));
end;

procedure Misc_wbMD5Data(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbMD5Data(Args.Values[0]);
end;

procedure Misc_wbMD5File(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbMD5File(string(Args.Values[0]));
end;

// find REFR records in child groups by base record signatures
// that are not deleted or disabled
procedure Misc_wbFindREFRsByBase(var Value: Variant; Args: TJvInterpreterArgs);
var
  MainRecord          : IwbMainRecord;
  REFRs               : TDynMainRecords;
  i, Opt              : Integer;
  lst                 : TList;
  BaseSignatures      : string;
begin
  if not Supports(IInterface(Args.Values[0]), IwbMainRecord, MainRecord) then
    Exit;
  BaseSignatures := string(Args.Values[1]);
  Opt := Integer(Args.Values[2]);
  lst := TList(V2O(Args.Values[3]));
  if not Assigned(lst) then
    Exit;

  REFRs := wbGetSiblingRecords(MainRecord, wbStringToSignatures('REFR'), True);
  for i := Low(REFRs) to High(REFRs) do
    if  not ((Opt and 1 <> 0) and REFRs[i].IsDeleted)
    and not ((Opt and 2 <> 0) and REFRs[i].IsInitiallyDisabled)
    and not ((Opt and 4 <> 0) and REFRs[i].ElementExists['XESP'])
    then
      if Assigned(REFRs[i].BaseRecord) and (Pos(REFRs[i].BaseRecord.Signature, BaseSignatures) <> 0) then
        lst.Add(Pointer(REFRs[i]));
end;

procedure Misc_wbGetSiblingRecords(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element             : IwbElement;
  Records             : TDynMainRecords;
  Overrides           : Boolean;
  i                   : Integer;
  lst                 : TList;
  sigs                : string;
begin
  if not Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Exit;
  sigs := string(Args.Values[1]);
  Overrides := Boolean(Args.Values[2]);
  lst := TList(V2O(Args.Values[3]));
  if not Assigned(lst) then
    Exit;

  Records := wbGetSiblingRecords(Element, wbStringToSignatures(sigs), Overrides);
  for i := Low(Records) to High(Records) do
    lst.Add(Pointer(Records[i]));
end;

procedure Misc_wbNormalizeResourceName(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbNormalizeResourceName(string(Args.Values[0]), Args.Values[1]);
end;

procedure Misc_wbStringListInString(var Value: Variant; Args: TJvInterpreterArgs);
var
  sl: TStringList;
  s: string;
  i: integer;
begin
  Value := -1;
  sl := TStringList(V2O(Args.Values[0]));
  if not Assigned(sl) then
    Exit;
  s := string(Args.Values[1]);
  for i := 0 to Pred(sl.Count) do
    if Pos(Lowercase(sl[i]), Lowercase(s)) > 0 then begin
      Value := i;
      Exit;
    end;
end;

procedure Misc_LocalizationGetStringsFromFile(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if Assigned(wbLocalizationHandler) then
    wbLocalizationHandler.GetStringsFromFile(string(Args.Values[0]), TStrings(V2O(Args.Values[1])));
end;

procedure Misc_wbFormIDErrorCheckLock(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbFormIDErrorCheckLock;
end;

procedure Misc_wbFormIDErrorCheckUnlock(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := wbFormIDErrorCheckUnlock;
end;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    AddExtUnit(cInterface);
    { TwbVector }
    AddRec(cInterface, cTwbVector, SizeOf(TwbVector), [RFD('x', 0, varSingle), RFD('y', 4, varSingle), RFD('z', 8, varSingle)], nil, nil, nil);
    AddFunction(cInterface, 'wbVector', JvInterpreter_wbVector, 3, [varEmpty, varEmpty, varEmpty], varRecord);
    { TwbGridCell }
    AddRec(cInterface, cTwbGridCell, SizeOf(TwbGridCell), [RFD('x', 0, varInteger), RFD('y', 4, varInteger)], nil, nil, nil);
    AddFunction(cInterface, 'wbGridCell', JvInterpreter_wbGridCell, 2, [varEmpty, varEmpty], varRecord);

    //AddIntfGet(IwbElement, 'Name', IwbElement_Name, 0, [VarEmpty], varEmpty);
    AddConst(cUnit, 'gmTES4', ord(gmTES4));
    AddConst(cUnit, 'gmTES5', ord(gmTES5));
    AddConst(cUnit, 'gmTES5VR', ord(gmTES5VR));
    AddConst(cUnit, 'gmFO3', ord(gmFO3));
    AddConst(cUnit, 'gmFNV', ord(gmFNV));
    AddConst(cUnit, 'gmFO4', ord(gmFO4));
    AddConst(cUnit, 'gmFO4VR', ord(gmFO4VR));
    AddConst(cUnit, 'gmFO76', ord(gmFO76));
    AddConst(cUnit, 'gmSSE', ord(gmSSE));
    AddConst(cUnit, 'gmEnderal', ord(gmEnderal));
    AddConst(cUnit, 'gmEnderalSE', ord(gmEnderalSE));
    AddConst(cUnit, 'gmSF1', ord(gmSF1));

    { TwbElementType }
    AddConst(cUnit, 'etFile', ord(etFile));
    AddConst(cUnit, 'etMainRecord', ord(etMainRecord));
    AddConst(cUnit, 'etGroupRecord', ord(etGroupRecord));
    AddConst(cUnit, 'etSubRecord', ord(etSubRecord));
    AddConst(cUnit, 'etSubRecordStruct', ord(etSubRecordStruct));
    AddConst(cUnit, 'etSubRecordArray', ord(etSubRecordArray));
    AddConst(cUnit, 'etSubRecordUnion', ord(etSubRecordUnion));
    AddConst(cUnit, 'etArray', ord(etArray));
    AddConst(cUnit, 'etStruct', ord(etStruct));
    AddConst(cUnit, 'etValue', ord(etValue));
    AddConst(cUnit, 'etFlag', ord(etFlag));
    AddConst(cUnit, 'etStringListTerminator', ord(etStringListTerminator));
    AddConst(cUnit, 'etUnion', ord(etUnion));
    AddConst(cUnit, 'etStructChapter', ord(etStructChapter));

    { TwbElementState }
    AddConst(cUnit, 'esModified', Ord(esModified));
    AddConst(cUnit, 'esInternalModified', Ord(esInternalModified));
    AddConst(cUnit, 'esUnsaved', Ord(esUnsaved));
    AddConst(cUnit, 'esSortKeyValid', Ord(esSortKeyValid));
    AddConst(cUnit, 'esExtendedSortKeyValid', Ord(esExtendedSortKeyValid));
    AddConst(cUnit, 'esHidden', Ord(esHidden));
    AddConst(cUnit, 'esParentHidden', Ord(esParentHidden));
    AddConst(cUnit, 'esParentHiddenChecked', Ord(esParentHiddenChecked));
    AddConst(cUnit, 'esNotReachable', Ord(esNotReachable));
    AddConst(cUnit, 'esReachable', Ord(esReachable));
    AddConst(cUnit, 'esTagged', Ord(esTagged));
    AddConst(cUnit, 'esDeciding', Ord(esResolving));
    AddConst(cUnit, 'esResolving', Ord(esResolving));
    AddConst(cUnit, 'esNotSuitableToAddTo', Ord(esNotSuitableToAddTo));

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
    AddConst(cUnit, 'dtStructChapter', ord(dtStructChapter));

    { TConflictThis }
    AddConst(cUnit, 'ctUnknown', ord(ctUnknown));
    AddConst(cUnit, 'ctIgnored', ord(ctIgnored));
    AddConst(cUnit, 'ctNotDefined', ord(ctNotDefined));
    AddConst(cUnit, 'ctIdenticalToMaster', ord(ctIdenticalToMaster));
    AddConst(cUnit, 'ctOnlyOne', ord(ctOnlyOne));
    AddConst(cUnit, 'ctHiddenByModGroup', ord(ctHiddenByModGroup));
    AddConst(cUnit, 'ctMaster', ord(ctMaster));
    AddConst(cUnit, 'ctConflictBenign', ord(ctConflictBenign));
    AddConst(cUnit, 'ctOverride', ord(ctOverride));
    AddConst(cUnit, 'ctIdenticalToMasterWinsConflict', ord(ctIdenticalToMasterWinsConflict));
    AddConst(cUnit, 'ctConflictWins', ord(ctConflictWins));
    AddConst(cUnit, 'ctConflictLoses', ord(ctConflictLoses));

    { TConflictAll }
    AddConst(cUnit, 'caUnknown', ord(caUnknown));
    AddConst(cUnit, 'caOnlyOne', ord(caOnlyOne));
    AddConst(cUnit, 'caNoConflict', ord(caNoConflict));
    AddConst(cUnit, 'caConflictBenign', ord(caConflictBenign));
    AddConst(cUnit, 'caOverride', ord(caOverride));
    AddConst(cUnit, 'caConflict', ord(caConflict));
    AddConst(cUnit, 'caConflictCritical', ord(caConflictCritical));

    { TwbContainerState }
    AddConst(cUnit, 'csInit', ord(csInit));
    AddConst(cUnit, 'csInitOnce', ord(csInitOnce));
    AddConst(cUnit, 'csInitDone', ord(csInitDone));
    AddConst(cUnit, 'csInitializing', ord(csInitializing));
    AddConst(cUnit, 'csRefsBuild', ord(csRefsBuild));
    AddConst(cUnit, 'csAsCreatedEmpty', ord(csAsCreatedEmpty));

    {TGameResourceType}
    AddConst(cUnit, 'resMesh', ord(resMesh));
    AddConst(cUnit, 'resTexture', ord(resTexture));
    AddConst(cUnit, 'resSound', ord(resSound));
    AddConst(cUnit, 'resMusic', ord(resMusic));
    AddConst(cUnit, 'resMaterial', ord(resMaterial));

    AddFunction(cUnit, 'Assigned', _Assigned, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ObjectToElement', ObjectToElement, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FullPathToFilename', _FullPathToFilename, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'EnableSkyrimSaveFormat', EnableSkyrimSaveFormat, 0, [], varEmpty);
    AddFunction(cUnit, 'GetRecordDefNames', GetRecordDefNames, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbFilterStrings', wbFilterStrings, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbRemoveDuplicateStrings', wbRemoveDuplicateStrings, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbVersionNumber', wbGetVersionNumber, 0, [], varEmpty);

    { IwbElement }
    AddFunction(cUnit, 'Name', IwbElement_Name, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ShortName', IwbElement_ShortName, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'BaseName', IwbElement_BaseName, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'DisplayName', IwbElement_DisplayName, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'Path', IwbElement_Path, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IndexedPath', IwbElement_IndexedPath, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'FullPath', IwbElement_FullPath, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'PathName', IwbElement_PathName, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementType', IwbElement_ElementType, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementTypeAsText', IwbElement_ElementTypeAsText, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'DefType', IwbElement_DefType, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'DefTypeAsText', IwbElement_DefTypeAsText, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'EnumValues', IwbElement_EnumValues, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FlagValues', IwbElement_FlagValues, 1, [varEmpty], varEmpty);
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
    AddFunction(cUnit, 'ElementAssign', IwbElement_Assign, 4, [varEmpty, varEmpty, varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'Equals', IwbElement_Equals, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'CanContainFormIDs', IwbElement_CanContainFormIDs, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CanMoveUp', IwbElement_CanMoveUp, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CanMoveDown', IwbElement_CanMoveDown, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MoveUp', IwbElement_MoveUp, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MoveDown', IwbElement_MoveDown, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbCopyElementToFile', _wbCopyElementToFile, 4, [varEmpty, varEmpty, varBoolean, varBoolean], varEmpty);
    AddFunction(cUnit, 'wbCopyElementToFileWithPrefix', _wbCopyElementToFileWithPrefix, 7, [varEmpty, varEmpty, varBoolean, varBoolean, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbCopyElementToFileWithPrefixAndSuffix', _wbCopyElementToFileWithPrefixAndSuffix, 8, [varEmpty, varEmpty, varBoolean, varBoolean, varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbCopyElementToRecord', _wbCopyElementToRecord, 4, [varEmpty, varEmpty, varBoolean, varBoolean], varEmpty);
    AddFunction(cUnit, 'ClearElementState', IwbElement_ClearElementState, 2, [varEmpty, varEmpty], varBoolean);
    AddFunction(cUnit, 'SetElementState', IwbElement_SetElementState, 2, [varEmpty, varEmpty], varBoolean);
    AddFunction(cUnit, 'GetElementState', IwbElement_GetElementState, 2, [varEmpty, varEmpty], varBoolean);
    AddFunction(cUnit, 'ReportRequiredMasters', IwbElement_ReportRequiredMasters, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'BuildRef', IwbElement_BuildRef, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MarkModifiedRecursive', IwbElement_MarkModifiedRecursive, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetToDefault', IwbElement_SetToDefault, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'BeginUpdate', IwbElement_BeginUpdate, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'EndUpdate', IwbElement_EndUpdate, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetSummary', IwbElement_GetSummary, 1, [varEmpty], varEmpty);

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
    AddFunction(cUnit, 'IndexOf', IwbContainer_IndexOf, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'Add', IwbContainer_Add, 3, [varEmpty, varString, varBoolean], varEmpty);
    AddFunction(cUnit, 'AddElement', IwbContainer_AddElement, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'InsertElement', IwbContainer_InsertElement, 3, [varEmpty, varInteger, varEmpty], varEmpty);
    AddFunction(cUnit, 'RemoveElement', IwbContainer_RemoveElement, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'RemoveByIndex', IwbContainer_RemoveByIndex, 3, [varEmpty, varInteger, varBoolean], varEmpty);
    AddFunction(cUnit, 'ReverseElements', IwbContainer_ReverseElements, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ContainerStates', IwbContainer_ContainerStates, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IsSorted', IwbContainer_IsSorted, 1, [varEmpty], varEmpty);

    { IwbMainRecord }
    AddFunction(cUnit, 'Signature', IwbMainRecord_Signature, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FormID', IwbMainRecord_FormID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'EditorID', IwbMainRecord_EditorID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetEditorID', IwbMainRecord_SetEditorID, 2, [varEmpty, varEmpty], varEmpty);
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
    AddFunction(cUnit, 'GetFormVCS1', IwbMainRecord_GetFormVCS1, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetFormVCS1', IwbMainRecord_SetFormVCS1, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'GetFormVCS2', IwbMainRecord_GetFormVCS2, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetFormVCS2', IwbMainRecord_SetFormVCS2, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'OverrideCount', IwbMainRecord_OverrideCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'OverrideByIndex', IwbMainRecord_OverrideByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'ReferencedByCount', IwbMainRecord_ReferencedByCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ReferencedByIndex', IwbMainRecord_ReferencedByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'ReferencesCount', IwbMainRecord_ReferencesCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ReferencesByIndex', IwbMainRecord_ReferencesByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'Master', IwbMainRecord_Master, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MasterOrSelf', IwbMainRecord_MasterOrSelf, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IsMaster', IwbMainRecord_IsMaster, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IsWinningOverride', IwbMainRecord_IsWinningOverride, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'WinningOverride', IwbMainRecord_WinningOverride, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'HighestOverrideOrSelf', IwbMainRecord_HighestOverrideOrSelf, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'BaseRecord', IwbMainRecord_BaseRecord, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'BaseRecordID', IwbMainRecord_BaseRecordID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'UpdateRefs', IwbMainRecord_UpdateRefs, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ChildGroup', IwbMainRecord_ChildGroup, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CompareExchangeFormID', IwbMainRecord_CompareExchangeFormID, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'ChangeFormSignature', IwbMainRecord_ChangeFormSignature, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'GetPosition', IwbMainRecord_GetPosition, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetRotation', IwbMainRecord_GetRotation, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetGridCell', IwbMainRecord_GetGridCell, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'HasPrecombinedMesh', IwbMainRecord_HasPrecombinedMesh, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'PrecombinedMesh', IwbMainRecord_PrecombinedMesh, 1, [varEmpty], varEmpty);

    { IwbGroupRecord }
    AddFunction(cUnit, 'GroupType', IwbGroupRecord_GroupType, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GroupLabel', IwbGroupRecord_GroupLabel, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ChildrenOf', IwbGroupRecord_ChildrenOf, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MainRecordByEditorID', IwbGroupRecord_MainRecordByEditorID, 2, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FindChildGroup', IwbGroupRecord_FindChildGroup, 3, [varEmpty, varEmpty, varEmpty], varEmpty);

    { IwbFile }
    AddFunction(cUnit, 'GetFileName', IwbFile_GetFileName, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetLoadOrder', IwbFile_GetLoadOrder, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetNewFormID', IwbFile_GetNewFormID, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetIsESM', IwbFile_GetIsESM, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetIsESM', IwbFile_SetIsESM, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'GetIsESL', IwbFile_GetIsESL, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetIsESL', IwbFile_SetIsESL, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'CanBeESL', IwbFile_CanBeESL, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SortMasters', IwbFile_SortMasters, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CleanMasters', IwbFile_CleanMasters, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MasterCount', IwbFile_MasterCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MasterByIndex', IwbFile_MasterByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'RecordCount', IwbFile_RecordCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'RecordByIndex', IwbFile_RecordByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'GroupBySignature', IwbFile_GroupBySignature, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'RecordByFormID', IwbFile_RecordByFormID, 3, [varEmpty, varInteger, varBoolean], varEmpty);
    AddFunction(cUnit, 'RecordByEditorID', IwbFile_RecordByEditorID, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'GetMasters', IwbFile_GetMasters, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'AddMasters', IwbFile_AddMasters, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'AddMasterIfMissing', IwbFile_AddMasterIfMissing, -1, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'HasMaster', IwbFile_HasMaster, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'HasGroup', IwbFile_HasGroup, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'LoadOrderFormIDtoFileFormID', IwbFile_LoadOrderFormIDtoFileFormID, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'FileFormIDtoLoadOrderFormID', IwbFile_FileFormIDtoLoadOrderFormID, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'FileWriteToStream', IwbFile_WriteToStream, 3, [varEmpty, varEmpty, varEmpty], varEmpty);

    { IwbContainerHandler }
    AddFunction(cUnit, 'ResourceContainerList', IwbContainerHandler_ResourceContainerList, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ResourceExists', IwbContainerHandler_ResourceExists, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ResourceCount', IwbContainerHandler_ResourceCount, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'ResourceList', IwbContainerHandler_ResourceList, -1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ResourceOpenData', IwbContainerHandler_ResourceOpenData, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'ResourceCopy', IwbContainerHandler_ResourceCopy, 3, [varEmpty, varEmpty, varEmpty], varEmpty);

    { IwbFastStringList }
    AddClass('TwbFastStringList', TwbFastStringList, 'TwbFastStringList');
    AddGet(TwbFastStringList, 'Create', TwbFastStringList_Create, 0, [varEmpty], varEmpty);

    { Nif routines }
    AddFunction(cUnit, 'NifBlockList', NifUtils_NifBlockList, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'NifTextureList', NifUtils_NifTextureList, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'NifTextureListResource', NifUtils_NifTextureListResource, 3, [varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'NifTextureListUVRange', NifUtils_NifTextureListUVRange, 3, [varEmpty, varEmpty, varEmpty], varEmpty);

    { DDS routines }
    AddFunction(cUnit, 'wbDDSStreamToBitmap', DDSUtils_wbDDSStreamToBitmap, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbDDSDataToBitmap', DDSUtils_wbDDSDataToBitmap, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbDDSResourceToBitmap', DDSUtils_wbDDSResourceToBitmap, 2, [varEmpty, varEmpty], varEmpty);

    { Misc routines }
    AddFunction(cUnit, 'wbFlipBitmap', Misc_wbFlipBitmap, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbAlphaBlend', Misc_wbAlphaBlend, 11, [varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbPositionToGridCell', Misc_wbPositionToGridCell, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbSubBlockFromGridCell', Misc_wbSubBlockFromGridCell, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbBlockFromSubBlock', Misc_wbBlockFromSubBlock, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbGridCellToGroupLabel', Misc_wbGridCellToGroupLabel, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbIsInGridCell', Misc_wbIsInGridCell, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbCRC32Data', Misc_wbCRC32Data, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbCRC32Resource', Misc_wbCRC32Resource, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbCRC32File', Misc_wbCRC32File, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'bscrc32', Misc_bscrc32, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CreateHashFO4', Misc_CreateHashFO4, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbSHA1Data', Misc_wbSHA1Data, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbSHA1File', Misc_wbSHA1File, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbMD5Data', Misc_wbMD5Data, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbMD5File', Misc_wbMD5File, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'wbFindREFRsByBase', Misc_wbFindRefrsByBase, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbGetSiblingRecords', Misc_wbGetSiblingRecords, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbNormalizeResourceName', Misc_wbNormalizeResourceName, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbStringListInString', Misc_wbStringListInString, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'LocalizationGetStringsFromFile', Misc_LocalizationGetStringsFromFile, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbFormIDErrorCheckLock', Misc_wbFormIDErrorCheckLock, 0, [], varEmpty);
    AddFunction(cUnit, 'wbFormIDErrorCheckUnlock', Misc_wbFormIDErrorCheckUnlock, 0, [], varEmpty);
    AddFunction(cUnit, 'wbIsPseudoESLMode', Misc_wbIsPseudoESLMode, 0, [], varEmpty);

  end;
end;

procedure Init;
begin
  RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreterFm.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_System.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_SysUtils.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Classes.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Dialogs.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Windows.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Graphics.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Controls.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Buttons.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_StdCtrls.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_ComCtrls.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_ExtCtrls.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Forms.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Dialogs.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Menus.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  //JvInterpreter_JvEditor.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  xejviScriptAdapterMisc.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  xejviScriptAdapterDF.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
end;

initialization
  Init;

end.
