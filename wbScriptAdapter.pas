unit wbScriptAdapter;

interface

uses
  Classes,
  SysUtils,
  Variants,
  wbInterface,
  wbImplementation;

type
  TElement = class//(TInterfacedObject, IInterface)
  public
    Name: String;
  end;

implementation

uses
  JvInterpreter_System,
  JvInterpreter_SysUtils,
  JvInterpreter_Classes,
  JvInterpreter_Windows,
  JvInterpreter_JvEditor,
  JvInterpreter;

{ TElement }

procedure AddMessage(var Value: Variant; Args: TJvInterpreterArgs);
begin
  if Assigned(wbProgressCallback) and (VarIsStr(Args.Values[0])) then
    wbProgressCallback(Args.Values[0]);
end;

procedure TElement_Name(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := 'test'; Exit;
  if Supports(Args.Obj, IwbElement, Element) then
    Value := Element.Name;
end;

procedure IwbElement_Name(var Value: Variant; Args: TJvInterpreterArgs);
var
  Element: IwbElement;
begin
  Value := 'test2';
  if Supports(IUnknown(Pointer(Args.Obj)), IwbElement, Element) then
    Value := Element.Name;
end;

procedure RegisterJvInterpreterAdapter(JvInterpreterAdapter: TJvInterpreterAdapter);
const
  cInterface = 'wbInterface';
begin
  with JvInterpreterAdapter do
  begin
    AddFunction('Dummy', 'AddMessage', AddMessage, 1, [varString], varEmpty);
    AddIntfGet(IwbElement, 'Name', IwbElement_Name, 0, [VarEmpty], varEmpty);
    { TElement }
    //AddClass('Dummy', TElement, 'TElement');
    //AddGet(TElement, 'Name', TElement_Name, 0, [varEmpty], varEmpty);
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
