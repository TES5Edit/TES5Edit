{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptAdapterContainer;

{$I xeDefines.inc}

interface

uses
  JvInterpreter;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);

implementation

uses
  System.SysUtils,
  System.Variants,

  wbInterface;

const
  cUnit = 'Dummy';


{ IwbContainer }

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

procedure IwbContainer_AdditionalElementCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.AdditionalElementCount;
end;

procedure IwbContainer_ContainerStates(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Word(Container.ContainerStates);
end;

procedure IwbContainer_ElementByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.Elements[Args.Values[1]];
end;

procedure IwbContainer_ElementByName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementByName[Args.Values[1]];
end;

procedure IwbContainer_ElementByPath(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementByPath[Args.Values[1]];
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

procedure IwbContainer_ElementCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  Value := 0;
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementCount;
end;

procedure IwbContainer_ElementExists(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementExists[string(Args.Values[1])];
end;

procedure IwbContainer_GetElementEditValues(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementEditValues[Args.Values[1]];
end;

procedure IwbContainer_GetElementNativeValues(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementNativeValues[Args.Values[1]];
end;

procedure IwbContainer_GetElementValues(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  Value := '';
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementValues[Args.Values[1]];
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

procedure IwbContainer_InsertElement(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
  Element: IwbElement;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    if Supports(IInterface(Args.Values[2]), IwbElement, Element) then
      Container.InsertElement(integer(Args.Values[1]), Element);
end;

procedure IwbContainer_IsSorted(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbSortableContainer;
begin
  Value := False;
  if Supports(IInterface(Args.Values[0]), IwbSortableContainer, Container) then
    Value := Container.Sorted;
end;

procedure IwbContainer_LastElement(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.LastElement;
end;

procedure IwbContainer_RemoveByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.RemoveElement(integer(Args.Values[1]), boolean(Args.Values[2]));
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

procedure IwbContainer_ReverseElements(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, Container) then
    Container.ReverseElements;
end;

function MemberTarget(const aContainer: IwbContainerElementRef; const aPath: string; out aParent: IwbContainerElementRef; out aName: string): Boolean;
begin
  aParent := aContainer;
  aName := aPath;
  var i := LastDelimiter('\', aPath);
  if i > 0 then begin
    aName := Copy(aPath, Succ(i), High(Integer));
    if not Supports(aContainer.ElementByPath[Copy(aPath, 1, Pred(i))], IwbContainerElementRef, aParent) then
      Exit(False);
  end;
  if not (wbAllowUnsafeScripts or aParent.IsEditable) then
    raise Exception.Create(aParent.Path + ': Does not support editing');
  Result := True;
end;

procedure IwbContainer_SetElementEditValues(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
    0, 1, 2: JvInterpreterError(ieNotEnoughParams, -1);
    3: begin
      var lContainer: IwbContainerElementRef;
      if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, lContainer) then
      begin
        var lElement: IwbElement;
        if Supports(lContainer.ElementByPath[Args.Values[1]], IwbElement, lElement) then begin
          if not (wbAllowUnsafeScripts or lElement.IsEditable) then
            raise Exception.Create(lElement.Path + ': Does not support editing')
          else
            lElement.EditValue := String(Args.Values[2]);
        end else begin
          var lParent: IwbContainerElementRef;
          var lName: string;
          if MemberTarget(lContainer, Args.Values[1], lParent, lName) then
            lParent.ElementEditValues[lName] := String(Args.Values[2]);
        end;
      end;
    end;
  else
    JvInterpreterError(ieTooManyParams, -1);
  end;
end;

procedure IwbContainer_SetElementNativeValues(var Value: Variant; Args: TJvInterpreterArgs);
begin
  case Args.Count of
    0, 1, 2: JvInterpreterError(ieNotEnoughParams, -1);
    3: begin
      var lContainer: IwbContainerElementRef;
      if Supports(IInterface(Args.Values[0]), IwbContainerElementRef, lContainer) then
      begin
        var lElement: IwbElement;
        if Supports(lContainer.ElementByPath[Args.Values[1]], IwbElement, lElement) then begin
          if not (wbAllowUnsafeScripts or lElement.IsEditable) then
            raise Exception.Create(lElement.Path + ': Does not support editing')
          else
            lElement.NativeValue := Args.Values[2];
        end else begin
          var lParent: IwbContainerElementRef;
          var lName: string;
          if MemberTarget(lContainer, Args.Values[1], lParent, lName) then
            lParent.ElementNativeValues[lName] := Args.Values[2];
        end;
      end;
    end;
  else
    JvInterpreterError(ieTooManyParams, -1);
  end;
end;


procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    { IwbContainer }
    AddFunction(cUnit, 'Add', IwbContainer_Add, 3, [varEmpty, varString, varBoolean], varEmpty);
    AddFunction(cUnit, 'AddElement', IwbContainer_AddElement, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'AdditionalElementCount', IwbContainer_AdditionalElementCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ContainerStates', IwbContainer_ContainerStates, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementByIndex', IwbContainer_ElementByIndex, 2, [varEmpty, varInteger], varEmpty);
    AddFunction(cUnit, 'ElementByName', IwbContainer_ElementByName, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'ElementByPath', IwbContainer_ElementByPath, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'ElementBySignature', IwbContainer_ElementBySignature, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'ElementCount', IwbContainer_ElementCount, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'ElementExists', IwbContainer_ElementExists, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'GetElementEditValues', IwbContainer_GetElementEditValues, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'GetElementNativeValues', IwbContainer_GetElementNativeValues, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'GetElementValues', IwbContainer_GetElementValues, 2, [varEmpty, varString], varEmpty);
    AddFunction(cUnit, 'IndexOf', IwbContainer_IndexOf, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'InsertElement', IwbContainer_InsertElement, 3, [varEmpty, varInteger, varEmpty], varEmpty);
    AddFunction(cUnit, 'IsSorted', IwbContainer_IsSorted, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'LastElement', IwbContainer_LastElement, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'RemoveByIndex', IwbContainer_RemoveByIndex, 3, [varEmpty, varInteger, varBoolean], varEmpty);
    AddFunction(cUnit, 'RemoveElement', IwbContainer_RemoveElement, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction(cUnit, 'ReverseElements', IwbContainer_ReverseElements, 1, [varEmpty], varEmpty);
    AddFunction(cUnit, 'SetElementEditValues', IwbContainer_SetElementEditValues, 3, [varEmpty, varString, varString], varEmpty);
    AddFunction(cUnit, 'SetElementNativeValues', IwbContainer_SetElementNativeValues, 3, [varEmpty, varString, varEmpty], varEmpty);
  end;
end;

procedure Init;
begin
  RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
end;

initialization
  Init;

end.
