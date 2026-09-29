{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptAdapterElement;

{$I xeDefines.inc}

interface

uses
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

implementation

uses
  System.Classes,
  System.SysUtils,
  System.TypInfo,

  wbImplementation,
  wbInterface,
  wbConflict,
  xeMainForm,
  xejviScriptArguments;

const
  cUnit = 'Dummy';


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

function TryHiddenState(const aElement: IwbElement; aState: TwbElementState; out aValue: Boolean): Boolean;
var
  lContainer : IwbContainer;
begin
  aValue := False;
  Result := aState in [esHidden, esParentHidden, esParentHiddenChecked];
  if Result then
    case aState of
      esHidden:
        aValue := frmMain.ConflictView.Hidden.Contains(aElement);
      esParentHidden: begin
        lContainer := aElement.Container;
        aValue := Assigned(lContainer) and frmMain.ConflictView.Hidden.IsHidden(lContainer);
      end;
    else
      aValue := True;
    end;
end;


{ IwbElement }

procedure IwbElement_Assign(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element, Element2: IwbElement;
begin
  Element2 := nil;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    if (V2O(Args.Values[2]) = nil) or Supports(IInterface(Args.Values[2]), IwbElement, Element2) then
      Value := Element.Assign(Args.Values[1], Element2, Args.Values[3]);
end;

procedure IwbElement_AssignTemplateByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  var elementIdx := Integer(Args.Values[1]);
  var templateIdx := Integer(Args.Values[2]);
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
  begin
    var templates := Element.GetAssignTemplates(elementIdx);

    if (templateIdx >= Low(templates)) and (templateIdx <= High(templates)) then
      Value := IInterface(templates[templateIdx]);
  end;
end;

procedure IwbElement_AssignTemplateByName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  var elementIdx := Integer(Args.Values[1]);
  var templateName := String(Args.Values[2]);
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
  begin
    var templates := Element.GetAssignTemplates(elementIdx);

    for var i := Low(templates) to High(templates) do
    begin
      var tEl := templates[i];
      if SameText(tEl.Name, templateName) then
      begin
        Value := IInterface(tEl);
        Exit;
      end;
    end;
  end;
end;

procedure IwbElement_AssignTemplateCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  var elementIdx := Integer(Args.Values[1]);
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
  begin
    var templates := Element.GetAssignTemplates(elementIdx);
    Value := Length(templates);
  end;
end;

procedure IwbElement_BaseName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.BaseName;
end;

procedure IwbElement_BeginUpdate(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.BeginUpdate;
end;

procedure IwbElement_BuildRef(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.BuildRef;
end;

procedure IwbElement_CanContainFormIDs(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.CanContainFormIDs;
end;

procedure IwbElement_CanMoveDown(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.CanMoveDown;
end;

procedure IwbElement_CanMoveUp(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.CanMoveUp;
end;

procedure IwbElement_Check(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.Check;
end;

procedure IwbElement_ClearElementState(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element : IwbElement;
  eState  : TwbElementState;
  Was     : Boolean;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    try
      eState := IntToEsState(Args.Values[1]);
      if TryHiddenState(Element, eState, Was) then begin
        Value := Was;
        if eState = esHidden then
          frmMain.ConflictView.Hidden.Show(Element);
      end else begin
        Value := eState in Element.ElementStates;
        Element.SetElementState(eState, True);
      end;
    except

    end;
  end;
end;

procedure IwbElement_ContainingMainRecord(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.ContainingMainRecord;
end;

procedure IwbElement_ContainingSubRecord(var Value : Variant; Args: TJvInterpreterArgs);
var
  Element : IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.ContainingSubRecord;
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

procedure IwbElement_DisplayName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.DisplayName[True];
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

procedure IwbElement_EndUpdate(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.EndUpdate;
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

procedure IwbElement_Equals(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element, Element2: IwbElement;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    if Supports(IInterface(Args.Values[1]), IwbElement, Element2) then
      Value := Element.Equals(Element2);
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

procedure IwbElement_FullPath(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.FullPath;
end;

procedure IwbElement_GetContainer(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.Container;
end;

procedure IwbElement_GetEditValue(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.EditValue;
end;

procedure IwbElement_GetElementState(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element : IwbElement;
  eState  : TwbElementState;
  Current : Boolean;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    try
      eState := IntToEsState(Args.Values[1]);
      if not TryHiddenState(Element, eState, Current) then
        Current := eState in Element.ElementStates;
      Value := Current;
    except

    end;
  end;
end;

procedure IwbElement_GetFile(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element._File;
end;

procedure IwbElement_GetIsEditable(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.IsEditable;
end;

procedure IwbElement_GetNativeValue(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.NativeValue;
end;

procedure IwbElement_GetSummary(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.GetSummary;
end;

procedure IwbElement_GetValue(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.Value;
end;

procedure IwbElement_IndexedPath(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.IndexedPath[Boolean(Args.Values[1])];
end;

procedure IwbElement_IsInjected(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := false;
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.IsInjected;
end;

procedure IwbElement_LinksTo(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.LinksTo;
end;

procedure IwbElement_MarkModifiedRecursive(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.MarkModifiedRecursive(AllElementTypes);
end;

procedure IwbElement_MoveDown(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.MoveDown;
end;

procedure IwbElement_MoveUp(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.MoveUp;
end;

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

procedure IwbElement_PathName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.PathName;
end;

procedure IwbElement_Remove(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.Remove;
end;

procedure IwbElement_ReportRequiredMasters(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    var lStrings := TStrings(ObjectArgument(Args.Values[1], TStrings, 1));
    var lMasters := TwbFilesSet.Create;
    try
      Element.ReportRequiredMasters(lMasters, Args.Values[2], Args.Values[3]);
      for var lFile in lMasters do
        lStrings.AddObject(lFile.FileName, Pointer(lFile));
    finally
      lMasters.Free;
    end;
  end;
end;

procedure IwbElement_SetEditValue(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
    0, 1: JvInterpreterError(ieNotEnoughParams, -1);
    2: begin
      var lElement: IwbElement;
      if Supports(IInterface(Args.Values[0]), IwbElement, lElement) then
        if not (wbAllowUnsafeScripts or lElement.IsEditable) then
          raise Exception.Create(lElement.Path + ': Does not support editing')
        else
          lElement.EditValue := string(Args.Values[1]);
    end;
  else
    JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure IwbElement_SetElementState(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element : IwbElement;
  eState  : TwbElementState;
  Was     : Boolean;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    try
      eState := IntToEsState(Args.Values[1]);
      if TryHiddenState(Element, eState, Was) then begin
        Value := Was;
        if eState = esHidden then
          frmMain.ConflictView.Hidden.Hide(Element);
      end else begin
        Value := eState in Element.ElementStates;
        Element.SetElementState(eState);
      end;
    except

    end;
  end;
end;

procedure IwbElement_SetNativeValue(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
    0, 1: JvInterpreterError(ieNotEnoughParams, -1);
    2: begin
      var lElement: IwbElement;
      if Supports(IInterface(Args.Values[0]), IwbElement, lElement) then
        if not (wbAllowUnsafeScripts or lElement.IsEditable) then
          raise Exception.Create(lElement.Path + ': Does not support editing')
        else
          lElement.NativeValue := Args.Values[1];
    end;
  else
    JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure IwbElement_SetToDefault(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Element.SetToDefault;
end;

procedure IwbElement_ShortName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.ShortName;
end;

procedure IwbElement_SortKey(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then
    Value := Element.Sortkey[Args.Values[1]];
end;

procedure IwbElement_TemplateAssign(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbElement, Element) then begin
    var TemplateName := String(Args.Values[1]);

    var TargetIndex := High(Integer);

    var lTemplates := Element.GetAssignTemplates(TargetIndex);

    for var i := Low(lTemplates) to High(lTemplates) do begin
      var TemplateElement: IwbTemplateElement := lTemplates[i];

      if SameText(TemplateName, TemplateElement.Name) then begin
        var NewElement: IwbElement := Element.Assign(TargetIndex, TemplateElement, False);

        if Assigned(NewElement) then
          NewElement.SetToDefaultIfAsCreatedEmpty;

        Value := NewElement;

        Break;
      end;
    end;
  end;
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


procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    { IwbElement }
    AddFunction(cUnit, 'AssignTemplateByIndex', IwbElement_AssignTemplateByIndex, 3, [varEmpty, varInteger, varInteger], varEmpty);
    AddFunction(cUnit, 'AssignTemplateByName', IwbElement_AssignTemplateByName, 3, [varEmpty, varInteger, varString], varEmpty);
    AddFunction(cUnit, 'AssignTemplateCount', IwbElement_AssignTemplateCount, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'BaseName', IwbElement_BaseName, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'BeginUpdate', IwbElement_BeginUpdate, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'BuildRef', IwbElement_BuildRef, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CanContainFormIDs', IwbElement_CanContainFormIDs, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CanMoveDown', IwbElement_CanMoveDown, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'CanMoveUp', IwbElement_CanMoveUp, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'Check', IwbElement_Check, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ClearElementState', IwbElement_ClearElementState, 2, [varEmpty, varEmpty], varBoolean);
    AddFunction(cUnit, 'ContainingMainRecord', IwbElement_ContainingMainRecord, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ContainingSubRecord', IwbElement_ContainingSubRecord, 1, [varEmpty], varEmpty);
	  AddFunction(cUnit, 'DefType', IwbElement_DefType, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'DefTypeAsText', IwbElement_DefTypeAsText, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'DisplayName', IwbElement_DisplayName, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementAssign', IwbElement_Assign, 4, [varEmpty, varEmpty, varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'ElementType', IwbElement_ElementType, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementTypeAsText', IwbElement_ElementTypeAsText, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'EndUpdate', IwbElement_EndUpdate, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'EnumValues', IwbElement_EnumValues, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'Equals', IwbElement_Equals, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'FlagValues', IwbElement_FlagValues, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'FullPath', IwbElement_FullPath, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetContainer', IwbElement_GetContainer, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetEditValue', IwbElement_GetEditValue, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetElementState', IwbElement_GetElementState, 2, [varEmpty, varEmpty], varBoolean);
    AddFunction(cUnit, 'GetFile', IwbElement_GetFile, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetNativeValue', IwbElement_GetNativeValue, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetSummary', IwbElement_GetSummary, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'GetValue', IwbElement_GetValue, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IndexedPath', IwbElement_IndexedPath, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'IsEditable', IwbElement_GetIsEditable, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'IsInjected', IwbElement_IsInjected, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'LinksTo', IwbElement_LinksTo, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MarkModifiedRecursive', IwbElement_MarkModifiedRecursive, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MoveDown', IwbElement_MoveDown, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'MoveUp', IwbElement_MoveUp, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'Name', IwbElement_Name, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'Path', IwbElement_Path, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'PathName', IwbElement_PathName, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'Remove', IwbElement_Remove, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ReportRequiredMasters', IwbElement_ReportRequiredMasters, 4, [varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'SetEditValue', IwbElement_SetEditValue, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'SetElementState', IwbElement_SetElementState, 2, [varEmpty, varEmpty], varBoolean);
    AddFunction(cUnit, 'SetNativeValue', IwbElement_SetNativeValue, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'SetToDefault', IwbElement_SetToDefault, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ShortName', IwbElement_ShortName, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SortKey', IwbElement_SortKey, 2, [varEmpty, varBoolean], varEmpty);
    AddFunction(cUnit, 'TemplateAssign', IwbElement_TemplateAssign, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'wbCopyElementToFile', _wbCopyElementToFile, 4, [varEmpty, varEmpty, varBoolean, varBoolean], varEmpty);
    AddFunction(cUnit, 'wbCopyElementToFileWithPrefix', _wbCopyElementToFileWithPrefix, 7, [varEmpty, varEmpty, varBoolean, varBoolean, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbCopyElementToFileWithPrefixAndSuffix', _wbCopyElementToFileWithPrefixAndSuffix, 8, [varEmpty, varEmpty, varBoolean, varBoolean, varEmpty, varEmpty, varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'wbCopyElementToRecord', _wbCopyElementToRecord, 4, [varEmpty, varEmpty, varBoolean, varBoolean], varEmpty);
  end;
end;

procedure Init;
begin
  RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
end;

initialization
  Init;

end.
