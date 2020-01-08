{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeScriptHost;

interface

uses
  Classes,
  SysUtils,
  System.Generics.Collections,
  wbInterface;

type
  IxeScript = interface(IInterface)
    ['{3BE80702-B634-46EB-8A45-38D9D911E6B6}']

    function FunctionExists(const aName: string): Boolean;
    function CallFunction(const aName: string; const aParams: array of Variant): Variant;
    function GetLastErrorLocation: string;
  end;

  TxeScriptHost = class(TObject)
  protected
    class procedure Register;
    class function GetName: string; virtual; abstract;

    constructor Create; virtual;

    class function CreateForName(const aName: string): TxeScriptHost;
    function CreateScriptInternal(const aScriptName, aScript: string): IxeScript; virtual; abstract;
  public
    class procedure Init(const aName: string);
    class function CreateScript(const aScriptName, aScript: string): IxeScript;
  end;
  TxeScriptHostClass = class of TxeScriptHost;

implementation

{ TxeScriptHost }

var
  _ScriptHosts: TList<TxeScriptHostClass>;

constructor TxeScriptHost.Create;
begin
  inherited Create;
end;

class function TxeScriptHost.CreateForName(const aName: string): TxeScriptHost;
var
  ScriptHostClass : TxeScriptHostClass;
begin
  ScriptHostClass := nil;
  if Assigned(_ScriptHosts) and (aName <> '') then
    for var i in _ScriptHosts do
      if SameText(i.GetName, aName) then begin
        ScriptHostClass := i;
        break;
      end;
  if not Assigned(ScriptHostClass) then
    raise Exception.Create('ScriptHost "' + aName + '" is not supported');
  Result := ScriptHostClass.Create;
end;

var
  _ScriptHost: TxeScriptHost;

class function TxeScriptHost.CreateScript(const aScriptName, aScript: string): IxeScript;
begin
  if not Assigned(_ScriptHost) then
    raise Exception.Create('TxeScriptHost has not been initialized');
  Result := _ScriptHost.CreateScriptInternal(aScriptName, aScript);
end;

class procedure TxeScriptHost.Init(const aName: string);
begin
  if Assigned(_ScriptHost) then
    raise Exception.Create('TxeScriptHost has already been initialized');
  _ScriptHost := CreateForName(aName);
end;

class procedure TxeScriptHost.Register;
begin
  if not Assigned(_ScriptHosts) then
    _ScriptHosts := TList<TxeScriptHostClass>.Create;
  if _ScriptHosts.IndexOf(Self) < 0 then
    _ScriptHosts.Add(Self);
end;

initialization
finalization
  FreeAndNil(_ScriptHost);
end.
