{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xedwsScriptHost;

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
  System.Rtti,
  wbInterface,
  xeInit,
  xeScriptHost,
  VirtualTrees,
  xeMainForm,
  xeFileSelectForm,
  wbLOD,
  wbHelpers,
  wbDataFormat,

  dwsArrayElementContext,
  dwsArrayMethodKinds,
  dwsComConnector,
  dwsComp,
  dwsCompiler,
  dwsCompilerContext,
  dwsCompilerUtils,
  dwsConnectorExprs,
  dwsConnectorSymbols,
  dwsConstExprs,
  dwsContextMap,
  dwsConvExprs,
  dwsCoreExprs,
  dwsCryptoXPlatform,
  dwsCustomData,
  dwsDataContext,
  dwsDateTime,
  dwsDebugFunctions,
  dwsDebugger,
  dwsEncoding,
  dwsErrors,
  dwsEvaluate,
  dwsExprList,
  dwsExprs,
  dwsExternalSymbols,
  dwsFileFunctions,
  dwsFileSystem,
  dwsFilter,
  dwsFunctions,
  dwsGenericExprs,
  dwsGenericSymbols,
  dwsGlobalVars,
  dwsGlobalVarsFunctions,
  dwsHtmlFilter,
  dwsInfo,
  dwsInfoClasses,
  dwsIOCPWorkerThreadPool,
  dwsJSON,
  dwsJSONConnector,
  dwsJSONPath,
  dwsJSONScript,
  dwsLanguageExtension,
  dwsLegacy,
  dwsMagicExprs,
  dwsMath3DFunctions,
  dwsMathComplexFunctions,
  dwsMathFunctions,
  dwsMethodExprs,
  dwsOperators,
  dwsPascalTokenizer,
  dwsRelExprs,
  dwsResultFunctions,
  dwsRTTIConnector,
  dwsRTTIExposer,
  dwsRTTIFunctions,
  dwsSampling,
  dwsScriptSource,
  dwsSetOfExprs,
  dwsSpecializationContext,
  dwsSpecializationMap,
  dwsSpecialKeywords,
  dwsStack,
  dwsStringFunctions,
  dwsStringResult,
  dwsStrings,
  dwsSymbolDictionary,
  dwsSymbols,
  dwsSystemOperators,
  dwsTimeFunctions,
  dwsTokenizer,
  dwsUnicode,
  dwsUnifiedConstants,
  dwsUnitSymbols,
  dwsUtils,
  dwsVariantFunctions,
  dwsVCLGUIFunctions,
  dwsWebUtils,
  dwsXPlatform,
  dwsXXHash;

type
  TxedwsScript = class(TInterfacedObject, IxeScript)
  protected {private}
    FScriptName : string;
    FScript     : string;

    FProgram: IdwsProgram;
  protected
    constructor Create(const aScriptName: string; aScript: string; const aProgram: IdwsProgram);

    { IxeScript }
    function CallFunction(const aName: string; const aParams: array of Variant): Variant;
    function FunctionExists(const aName: string): Boolean;
    function GetLastErrorLocation: string;
  public
    destructor Destroy; override;
  end;

  TxedwsScriptHost = class(TxeScriptHost)
  protected {private}
    FRttiContext: TRttiContext;
    FDelphiWebScript: TDelphiWebScript;
    FdwsRTTIConnector: TdwsRTTIConnector;
    FUnits: TDictionary<string, TdwsUnit>;
  protected
    class function GetName: string; override;
    function CreateScriptInternal(const aScriptName, aScript: string): IxeScript; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

function TxedwsScript.CallFunction(const aName: string; const aParams: array of Variant): Variant;
begin
  Result := Null;
  //FProgram.CallFunction(aName, nil, aParams);
  //Result := FProgram.VResult;
end;

constructor TxedwsScript.Create(const aScriptName: string; aScript: string; const aProgram: IdwsProgram);
begin
  inherited Create;
  FScriptName := aScriptName;
  FScript := aScript;
  FProgram := aProgram;
end;

destructor TxedwsScript.Destroy;
begin
  inherited;
  FProgram := nil;
end;

function TxedwsScript.FunctionExists(const aName: string): Boolean;
begin
  Result := False;
//  Result := FProgram.FunctionExists('', aName);
end;

function TxedwsScript.GetLastErrorLocation: string;
begin
  {
  var LastError := FProgram.LastError;
  if Assigned(LastError) then
    Result := 'unit ' + LastError.ErrUnitName + ' line ' + IntToStr(LastError.ErrLine)
  else
  }
    Result := '';
end;

{ TxedwsScriptHost }

constructor TxedwsScriptHost.Create;
var
  x : TAggregatedObject;
begin
  FRttiContext := TRttiContext.Create;

  FUnits := TDictionary<string, TdwsUnit>.Create;

  FDelphiWebScript := TDelphiWebScript.Create(nil);

  FdwsRTTIConnector := TdwsRTTIConnector.Create(nil);
  FdwsRTTIConnector.Script := FDelphiWebScript;

  {
  for var lType in FRttiContext.GetTypes do
    if lType.IsPublicType then begin
    var QualifiedName := lType.QualifiedName;
    var Name := lType.Name;
    var UnitName := QualifiedName;
    SetLength(UnitName, Length(UnitName) - Succ(Length(Name)));
    var lUnit: TdwsUnit;
    if not FUnits.TryGetValue(UnitName, lUnit) then begin
      lUnit := TdwsUnit.Create(nil);
      lUnit.UnitName := UnitName;
      lUnit.Script := FDelphiWebScript;
      FUnits.Add(UnitName, lUnit);
    end;
    lUnit.ExposeRTTI(lType.Handle, [eoExposeVirtual, eoNoFreeOnCleanup, eoExposePublic]);
  end;
  }

  inherited;
end;

function TxedwsScriptHost.CreateScriptInternal(const aScriptName, aScript: string): IxeScript;
begin
  Result := TxedwsScript.Create(aScriptName, aScript, FDelphiWebScript.Compile(aScript));
end;

destructor TxedwsScriptHost.Destroy;
begin
  inherited;

  FreeAndNil(FDelphiWebScript);
  FreeAndNil(FdwsRTTIConnector);

  if Assigned(FUnits) then
    for var lUnit in FUnits.Values do
      lUnit.Free;
  FreeAndNil(FUnits);
end;

class function TxedwsScriptHost.GetName: string;
begin
  Result := 'DWS';
end;

initialization
  TxedwsScriptHost.Register;
end.
