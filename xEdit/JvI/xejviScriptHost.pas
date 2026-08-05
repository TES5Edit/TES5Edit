{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xejviScriptHost;

{$I xeDefines.inc}

interface

implementation

uses
  System.Classes,
  System.RegularExpressionsCore,
  System.SysUtils,

  JvInterpreter,

  wbDataFormat,
  wbInterface,

  xeMainForm,
  xeScriptHost;

type
  TxejviScript = class(TInterfacedObject, IxeScript)
  protected {private}
    FScriptPath : string;
    FScript     : string;
    FProgram    : TJvInterpreterProgram;

    procedure JvInterpreterProgramGetUnitSource(UnitName: string; var Source: string; var Done: Boolean);
    procedure JvInterpreterProgramStatement(Sender: TObject);
    procedure JvInterpreterProgramSetValue(Sender: TObject; Identifier: string; const Value: Variant; Args: TJvInterpreterArgs; var Done: Boolean);
  protected
    constructor Create(const aScriptFile: string; aScript: string);

    { IxeScript }
    function CallFunction(const aName: string; const aParams: array of Variant): Variant;
    function FunctionExists(const aName: string): Boolean;
    function FunctionIsEmpty(const aName: string): Boolean;
    function GetLastErrorLocation: string;
  public
    destructor Destroy; override;
  end;

  TxejviScriptHost = class(TxeScriptHost)
  protected
    class function GetName: string; override;
    function CreateScriptInternal(const aScriptFile, aScript: string): IxeScript; override;
  public
    constructor Create; override;
  end;

procedure TxejviScript.JvInterpreterProgramSetValue(Sender: TObject;
  Identifier: string; const Value: Variant; Args: TJvInterpreterArgs;
  var Done: Boolean);
var
  i, v: Integer;
begin
  with frmMain do
  if SameText(Identifier, 'ScriptProcessElements') then begin
    ScriptProcessElements := [];
    v := V2S(Value);
    for i := Integer(Low(TwbElementType)) to Integer(High(TwbElementType)) do
      if (v and (1 shl i)) > 0 then
        Include(ScriptProcessElements, TwbElementType(i));
    if ScriptProcessElements = [] then
      ScriptProcessElements := [etMainRecord];
    Done := True;
  end else
  if SameText(Identifier, 'ScriptProcessSignatures') then begin
    var sl := TStringList.Create;
    try
      sl.CommaText := Value;
      for i := 0 to Pred(sl.Count) do begin
        var s := Trim(sl[i]);
        if Length(s) <> 4 then
          JvInterpreterErrorN(ieDirectInvalidArgument, 0, Format('ScriptProcessSignatures expects a comma separated list of 4 character signatures. The signature "%s" is not a valid candidate.', [s])); // or ieNotEnoughParams, ieIncompatibleTypes or others.
        sl[i] := UpperCase(s); // trimmed and semi-validated so set uppercase to simplify check later
      end;
      ScriptProcessSignatures := sl.CommaText;
    finally
      sl.free;
    end;
    Done := True;
  end else
  if SameText(Identifier, 'wbOutputPath') then begin
    wbOutputPath := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterScripted') then begin
    FilterScripted := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterConflictAll') then begin
    FilterConflictAll := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterConflictAllSet') then begin
    FilterConflictAllSet := [];
    v := V2S(Value);
    for i := Integer(Low(TConflictAll)) to Integer(High(TConflictAll)) do
      if (v and (1 shl i)) > 0 then
        Include(FilterConflictAllSet, TConflictAll(i));
    Done := True;
  end else
  if SameText(Identifier, 'FilterConflictThis') then begin
    FilterConflictThis := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterConflictThisSet') then begin
    FilterConflictThisSet := [];
    v := V2S(Value);
    for i := Integer(Low(TConflictThis)) to Integer(High(TConflictThis)) do
      if (v and (1 shl i)) > 0 then
        Include(FilterConflictThisSet, TConflictThis(i));
    Done := True;
  end else
  if SameText(Identifier, 'FilterByInjectStatus') then begin
    FilterByInjectStatus := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterInjectStatus') then begin
    FilterInjectStatus := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByNotReachableStatus') then begin
    FilterByNotReachableStatus := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterNotReachableStatus') then begin
    FilterNotReachableStatus := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByReferencesInjectedStatus') then begin
    FilterByReferencesInjectedStatus := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterReferencesInjectedStatus') then begin
    FilterReferencesInjectedStatus := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByEditorID') then begin
    FilterByEditorID := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterEditorID') then begin
    FilterEditorID := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByName') then begin
    FilterByName := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterName') then begin
    FilterName := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByElementValue') then begin
    FilterByElementValue := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterElementValue') then begin
    FilterElementValue := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByRegexComparison') then begin
    FilterByRegexComparison := Value;
	Done := True;
  end else
  if SameText(Identifier, 'FilterByBaseEditorID') then begin
    FilterByBaseEditorID := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterBaseEditorID') then begin
    FilterBaseEditorID := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByBaseName') then begin
    FilterByBaseName := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterBaseName') then begin
    FilterBaseName := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterScaledActors') then begin
    FilterScaledActors := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterBySignature') then begin
    FilterBySignature := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterSignatures') then begin
    FilterSignatures := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByBaseSignature') then begin
    FilterByBaseSignature := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterBaseSignatures') then begin
    FilterBaseSignatures := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByPersistent') then begin
    FilterByPersistent := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterPersistent') then begin
    FilterPersistent := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterUnnecessaryPersistent') then begin
    FilterUnnecessaryPersistent := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterMasterIsTemporary') then begin
    FilterMasterIsTemporary := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterIsMaster') then begin
    FilterIsMaster := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterPersistentPosChanged') then begin
    FilterPersistentPosChanged := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterDeleted') then begin
    FilterDeleted := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByVWD') then begin
    FilterByVWD := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterVWD') then begin
    FilterVWD := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByHasVWDMesh') then begin
    FilterByHasVWDMesh := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterHasVWDMesh') then begin
    FilterHasVWDMesh := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterByHasPrecombinedMesh') then begin
    FilterByHasPrecombinedMesh := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FilterHasPrecombinedMesh') then begin
    FilterHasPrecombinedMesh := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FlattenBlocks') then begin
    FlattenBlocks := Value;
    Done := True;
  end else
  if SameText(Identifier, 'FlattenCellChilds') then begin
    FlattenCellChilds := Value;
    Done := True;
  end else
  if SameText(Identifier, 'AssignPersWrldChild') then begin
    AssignPersWrldChild := Value;
    Done := True;
  end else
  if SameText(Identifier, 'InheritConflictByParent') then begin
    InheritConflictByParent := Value;
    Done := True;
  end
  else if SameText(Identifier, 'dfFloatDecimalDigits') then begin
    Assert(dfFloatDecimalDigits > 0, 'dfFloatDecimalDigits must be greater than 0');
    dfFloatDecimalDigits := Value;
    Done := True;
  end;
end;


procedure TxejviScript.JvInterpreterProgramStatement(Sender: TObject);
begin
  wbTick;
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

function TxejviScript.CallFunction(const aName: string; const aParams: array of Variant): Variant;
begin
  FProgram.CallFunction(aName, nil, aParams);
  Result := FProgram.VResult;
end;

constructor TxejviScript.Create(const aScriptFile: string; aScript: string);
begin
  inherited Create;
  // Try to remove namespaces from unit names in uses clause if script is written in newer Delphi version
  // jvInterpreter doesn't support them (causes syntax error)
  with TPerlRegEx.Create do try
    Subject := aScript;
    RegEx := '^\s*uses\s+(.+?);';
    Options := [preCaseLess, preSingleLine, preMultiLine];
    while MatchAgain do begin
      var i := MatchedOffset;
      var s := MatchedText;
      s := StringReplace(s, 'system.', '', [rfReplaceAll, rfIgnoreCase]);
      s := StringReplace(s, 'vcl.',    '', [rfReplaceAll, rfIgnoreCase]);
      s := StringReplace(s, 'winapi.', '', [rfReplaceAll, rfIgnoreCase]);
      s := StringReplace(s, 'data.',   '', [rfReplaceAll, rfIgnoreCase]);
      s := StringReplace(s, 'web.',    '', [rfReplaceAll, rfIgnoreCase]);
      if s <> MatchedText then begin
        aScript := Copy(aScript, 1, i-1) + s + Copy(aScript, i + Length(MatchedText), Length(aScript));
        Subject := aScript;
      end;
      Start := i + Length(s);
    end;
  finally
    Free;
  end;

  FScriptPath := ExtractFilePath(aScriptFile);
  if FScriptPath = '' then
    FScriptPath := wbScriptsPath;
  FScript := aScript;

  FProgram := TJvInterpreterProgram.Create(nil);
  FProgram.OnSetValue := JvInterpreterProgramSetValue;
  FProgram.OnGetUnitSource := JvInterpreterProgramGetUnitSource;
  FProgram.OnStatement := JvInterpreterProgramStatement;
  FProgram.Pas.Text := FScript;
  FProgram.Compile;
end;

destructor TxejviScript.Destroy;
begin
  inherited;
  FreeAndNil(FProgram);
end;

function TxejviScript.FunctionExists(const aName: string): Boolean;
begin
  Result := FProgram.FunctionExists('', aName);
end;

function TxejviScript.FunctionIsEmpty(const aName: string): Boolean;
var
  FunctionDesc: TJvInterpreterFunctionDesc;
  Body: string;
  P, I: Integer;
begin
  Result := False;
  FunctionDesc := nil;
  for I := FProgram.Adapter.SrcFunctionList.Count - 1 downto 0 do begin
    var SrcFun := TJvInterpreterSrcFunction(FProgram.Adapter.SrcFunctionList.Items[I]);
    if SameText(SrcFun.FunctionDesc.Identifier, aName) then begin
      FunctionDesc := SrcFun.FunctionDesc;
      Break;
    end;
  end;
  if not Assigned(FunctionDesc) then
    Exit;

  Body := Copy(FScript, FunctionDesc.PosBeg, FunctionDesc.PosEnd - FunctionDesc.PosBeg);
  Body := LowerCase(Body);

  // skip any var section before begin
  P := Pos('begin', Body);
  if P = 0 then
    Exit;
  Body := Copy(Body, P, Length(Body) - P + 1);

  // strip all whitespace to normalize
  I := 1;
  while I <= Length(Body) do
    if CharInSet(Body[I], [' ', #9, #10, #13]) then
      Delete(Body, I, 1)
    else
      Inc(I);

  // trivially empty: no statements, or only Result := 0
  Result := (Body = 'beginend') or
            (Body = 'beginend;') or
            (Body = 'beginend.') or
            (Body = 'beginresult:=0;end') or
            (Body = 'beginresult:=0;end;') or
            (Body = 'beginresult:=0;end.');
end;

function TxejviScript.GetLastErrorLocation: string;
begin
  var LastError := FProgram.LastError;
  if Assigned(LastError) then
    Result := 'unit ' + LastError.ErrUnitName + ' line ' + IntToStr(LastError.ErrLine)
  else
    Result := '';
end;

procedure TxejviScript.JvInterpreterProgramGetUnitSource(UnitName: string; var Source: string; var Done: Boolean);
var
  UnitFile: string;
begin
  // return empty unit source code if the standard one is used
  if SameText(UnitName, 'xEditAPI') or SameText(UnitName, 'UITypes') or IsUnitCompiledIn(HInstance, UnitName) then begin
    Source := 'unit ' + UnitName + '; end.';
    Done := True;
    Exit;
  end;

  // look next to the script first so scripts in subdirectories can ship their own units
  UnitFile := FScriptPath + UnitName + '.pas';
  if not FileExists(UnitFile) then begin
    UnitFile := wbScriptsPath + UnitName + '.pas';
    if not FileExists(UnitFile) then
      raise Exception.CreateFmt('Cannot find unit "%s" in "%s" or "%s"', [UnitName, FScriptPath, wbScriptsPath]);
  end;

  with TStringList.Create do try
    LoadFromFile(UnitFile);
    Source := Text;
    Done := True;
  finally
    Free;
  end;
end;


{ TxejviScriptHost }

constructor TxejviScriptHost.Create;
begin
  inherited;
  wbVarPointer := varPointer;
end;

function TxejviScriptHost.CreateScriptInternal(const aScriptFile, aScript: string): IxeScript;
begin
  Result := TxejviScript.Create(aScriptFile, aScript);
end;

class function TxejviScriptHost.GetName: string;
begin
  Result := 'JvI';
end;

initialization
  TxejviScriptHost.Register;
end.
