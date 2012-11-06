unit wbScriptAdapter;

interface

uses
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
  JvInterpreter_Windows,
  JvInterpreter_JvEditor,
  JvInterpreter;

{ TElement }

procedure _Assigned(var Value: Variant; Args: TJvInterpreterArgs);
begin
  Value := Assigned(Pointer(NativeInt(Args.Values[0])));
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
//  if Supports(IUnknown(Pointer(Args.Obj)), IwbElement, Element) then
//    Value := Element.Name;
//end;

procedure IwbElement_GetName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IUnknown(Args.Values[0]), IwbElement, Element) then
    Value := Element.Name;
end;

procedure IwbElement_GetFullPath(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IUnknown(Args.Values[0]), IwbElement, Element) then
    Value := Element.FullPath;
end;

procedure IwbElement_GetEditValue(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IUnknown(Args.Values[0]), IwbElement, Element) then
    Value := Element.EditValue;
end;

procedure IwbElement_SetEditValue(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IUnknown(Args.Values[0]), IwbElement, Element) then
    Element.EditValue := string(Args.Values[1]);
end;

procedure IwbElement_GetNativeValue(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := '';
  if Supports(IUnknown(Args.Values[0]), IwbElement, Element) then
    Value := Element.NativeValue;
end;

procedure IwbElement_SetNativeValue(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  if Supports(IUnknown(Args.Values[0]), IwbElement, Element) then
    Element.NativeValue := Args.Values[1];
end;

procedure IwbElement_ElementByName(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IUnknown(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementByName[Args.Values[1]];
end;

procedure IwbElement_ElementBySignature(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
  Signature: TwbSignature;
begin
  if Supports(IUnknown(Args.Values[0]), IwbContainerElementRef, Container) then begin
    Signature := StrToSignature(Args.Values[1]);
    Value := Container.ElementBySignature[Signature];
  end;
end;

procedure IwbElement_ElementCount(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  Value := -1;
  if Supports(IUnknown(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.ElementCount;
end;

procedure IwbElement_ElementByIndex(var Value: Variant; Args: TJvInterpreterArgs);
var
  Container: IwbContainerElementRef;
begin
  if Supports(IUnknown(Args.Values[0]), IwbContainerElementRef, Container) then
    Value := Container.Elements[Args.Values[1]];
end;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
begin
  with JvInterpreterAdapter do begin
    //AddFunction('Dummy', 'Assigned', _Assigned, 1, [varEmpty], varEmpty);
    AddFunction('Dummy', 'AddMessage', AddMessage, 1, [varString], varEmpty);
    //AddIntfGet(IwbElement, 'Name', IwbElement_Name, 0, [VarEmpty], varEmpty);
    AddFunction('Dummy', 'GetName', IwbElement_GetName, 1, [varEmpty], varEmpty);
    AddFunction('Dummy', 'GetFullPath', IwbElement_GetFullPath, 1, [varEmpty], varEmpty);
    AddFunction('Dummy', 'GetEditValue', IwbElement_GetEditValue, 1, [varEmpty], varEmpty);
    AddFunction('Dummy', 'SetEditValue', IwbElement_SetEditValue, 2, [varEmpty, varString], varEmpty);
    AddFunction('Dummy', 'GetNativeValue', IwbElement_GetNativeValue, 1, [varEmpty], varEmpty);
    AddFunction('Dummy', 'SetNativeValue', IwbElement_SetNativeValue, 2, [varEmpty, varEmpty], varEmpty);
    AddFunction('Dummy', 'ElementByName', IwbElement_ElementByName, 2, [varEmpty, varString], varEmpty);
    AddFunction('Dummy', 'ElementBySignature', IwbElement_ElementBySignature, 2, [varEmpty, varString], varEmpty);
    AddFunction('Dummy', 'ElementCount', IwbElement_ElementCount, 1, [varEmpty], varEmpty);
    AddFunction('Dummy', 'ElementByIndex', IwbElement_ElementByIndex, 2, [varEmpty, varInteger], varEmpty);
  end;
end;

procedure Init;
begin
  RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_System.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_SysUtils.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Classes.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_Windows.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
  JvInterpreter_JvEditor.RegisterJvInterpreterAdapter(GlobalJvInterpreterAdapter);
end;

initialization
  Init;

end.
