{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xepsScriptHost;

{$I xeDefines.inc}

interface

implementation

uses
  Classes,
  SysUtils,
  System.Generics.Collections,
  Variants,
  Forms,
  System.RegularExpressionsCore,
  wbInterface,
  xeInit,
  xeScriptHost,
  VirtualTrees,
  xeMainForm,
  xeFileSelectForm,
  wbLOD,
  wbHelpers,
  wbDataFormat,

  uPSComponent,
  uPSCompiler,
  uPSRuntime,

  uPSR_std,
  uPSC_std,
  uPSR_stdctrls,
  uPSC_stdctrls,
  uPSR_forms,
  uPSC_forms,
  uPSC_graphics,
  uPSC_controls,
  uPSC_classes,
  uPSR_graphics,
  uPSR_controls,
  uPSR_classes,
  uPSC_comobj,
  uPSR_comobj;

type
  TxepsScript = class(TInterfacedObject, IxeScript)
  protected {private}
    FScriptName : string;
    FScript     : string;

    PSScript    : TPSScript;

    procedure PSScriptCompImport(Sender: TObject; x: TPSPascalCompiler);
    procedure PSScriptExecImport(Sender: TObject; Exec: TPSExec; x: TPSRuntimeClassImporter);
  protected
    constructor Create(const aScriptName: string; aScript: string);

    { IxeScript }
    function CallFunction(const aName: string; const aParams: array of Variant): Variant;
    function FunctionExists(const aName: string): Boolean;
    function GetLastErrorLocation: string;
  public
    destructor Destroy; override;
  end;

  TxepsScriptHost = class(TxeScriptHost)
  protected
    class function GetName: string; override;
    function CreateScriptInternal(const aScriptName, aScript: string): IxeScript; override;
  public
    constructor Create; override;
  end;

type
  PUnitInfo = ^TUnitInfo;
  TUnitInfo = record
    UnitName: string;
    Found: PBoolean;
  end;

procedure HasUnitProc(const Name: string; NameType: TNameType; Flags: Byte; Param: Pointer);
var
  s: string;
begin
  case NameType of
    ntContainsUnit:
      with PUnitInfo(Param)^ do begin
        s := Name;
        s := StringReplace(s, 'system.', '', [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, 'vcl.',    '', [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, 'winapi.', '', [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, 'data.',   '', [rfReplaceAll, rfIgnoreCase]);
        s := StringReplace(s, 'web.',    '', [rfReplaceAll, rfIgnoreCase]);
        if SameText(s, UnitName) then
          Found^ := True;
      end;
  end;
end;

function IsUnitCompiledIn(Module: HMODULE; const UnitName: string): Boolean;
var
  Info: TUnitInfo;
  Flags: Integer;
begin
  Result := False;
  Info.UnitName := UnitName;
  Info.Found := @Result;
  GetPackageInfo(Module, @Info, Flags, HasUnitProc);
end;

function TxepsScript.CallFunction(const aName: string; const aParams: array of Variant): Variant;
begin
  Result := PSScript.ExecuteFunction(aParams, aName);
end;

constructor TxepsScript.Create(const aScriptName: string; aScript: string);

  procedure RaiseCompilerError;
  begin
    with TStringList.Create do try
      for var l := 0 to PSScript.CompilerMessageCount - 1 do
        Add(PSScript.CompilerErrorToStr(l));
      Insert(0, 'Could not compile script:');
      raise Exception.Create(Text);
    finally
      Free;
    end;
  end;

begin
  inherited Create;

  FScriptName := aScriptName;
  FScript := aScript;

  PSScript := TPSScript.Create(nil);
  PSScript.OnCompImport := PSScriptCompImport;
  PSScript.OnExecImport := PSScriptExecImport;

  PSScript.Script.Text := aScript;
  if not PSScript.Compile then
    RaiseCompilerError;
  PSScript.SuppressLoadData := True;
  PSScript.UseDebugInfo := True;
  if not PSScript.LoadExec then
    raise Exception.Create('Could not load execution environment');
end;

destructor TxepsScript.Destroy;
begin
  inherited;
  FreeAndNil(PSScript);
end;

function TxepsScript.FunctionExists(const aName: string): Boolean;
begin
  Result := Assigned(TNotifyEvent(PSScript.GetProcMethod(aName)));
end;

function TxepsScript.GetLastErrorLocation: string;
begin
  {
  var LastError := FProgram.LastError;
  if Assigned(LastError) then
    Result := 'unit ' + LastError.ErrUnitName + ' line ' + IntToStr(LastError.ErrLine)
  else}
    Result := '';
end;

procedure TxepsScript.PSScriptCompImport(Sender: TObject; x: TPSPascalCompiler);
begin
  SIRegister_Std(x);
  SIRegister_Classes(x, true);
  SIRegister_Graphics(x, true);
  SIRegister_Controls(x);
  SIRegister_stdctrls(x);
  SIRegister_Forms(x);
  SIRegister_ComObj(x);
end;

procedure TxepsScript.PSScriptExecImport(Sender: TObject; Exec: TPSExec; x: TPSRuntimeClassImporter);
begin
  RIRegister_Std(x);
  RIRegister_Classes(x, True);
  RIRegister_Graphics(x, True);
  RIRegister_Controls(x);
  RIRegister_stdctrls(x);
  RIRegister_Forms(x);
  RIRegister_ComObj(exec);
end;

{ TxepsScriptHost }

constructor TxepsScriptHost.Create;
begin
  inherited;
end;

function TxepsScriptHost.CreateScriptInternal(const aScriptName, aScript: string): IxeScript;
begin
  Result := TxepsScript.Create(aScriptName, aScript);
end;

class function TxepsScriptHost.GetName: string;
begin
  Result := 'PS';
end;

initialization
  TxepsScriptHost.Register;
end.
