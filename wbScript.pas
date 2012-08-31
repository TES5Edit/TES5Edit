{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

unit wbScript;

interface

uses
  wbInterface,
  CocoaBase;

type
  IwbScriptAction = interface
    ['{2BF2E3A4-2F5D-4EA1-987A-96CEE26A3902}']
    function Process(const aElement: IwbElement): Boolean;
  end;
  TDynActions = array of IwbScriptAction;

  TwbScriptScanProgress = procedure(aTotalCount, aCount: Integer) of object;

  IwbScript = interface
    ['{C9010A7A-79BE-4FE3-BD03-645A494E9644}']
    procedure LoadFromFile(const aFileName: string);
    procedure LoadFromString(const s: string);

    procedure ScanForTargets(out aElements: TDynElements; out aActions: TDynActions; aProgress: TwbScriptScanProgress);
  end;

function wbCreateScript(const aFiles: TDynFiles): IwbScript;

type
  TwbModifyType = (
    mtOffset,
    mtFactor,
    mtInclude,
    mtExclude
  );

  TwbTermHandle = TGUID;

  TwbOperator = (
    opOr,
    opAnd,
    opPlus,
    opMinus,
    opConcat,
    opMul,
    opFloatDiv,
    opDiv,
    opMod
  );

  TwbUnaryOperator = (
    uoNot,
    uoMinus
  );

  TwbLiteralType = (
    ltString,
    ltInteger,
    ltFloat,
    ltFormID
  );

  IwbExpressionBuilder = interface
    ['{99BE0457-49F3-40FA-8D4D-05FC1476AE00}']

    function BeginTerm: TwbTermHandle;
    function BeginUnaryTerm(aUnaryOperator: TwbUnaryOperator): TwbTermHandle;
    function BeginDeRefTerm: TwbTermHandle;
    procedure EndTerm(const aHandle: TwbTermHandle);

    procedure SetOperator(aOperator: TwbOperator);

    procedure AddLiteral(aLiteralType: TwbLiteralType; aValue: PTokenRecord);
    procedure AddFieldRef(aName: PTokenRecord);
    procedure AddMatch(aSignature: PTokenRecord; const aExpression: IwbExpressionBuilder);
  end;

  IwbStatementBuilder = interface
    ['{19F099D8-422A-43EB-9C4A-9C950EC559C5}']
  end;

  IwbRuleBuilder = interface
    ['{87F3D163-743E-4CBD-AD45-08BD7E85D1E9}']
  end;

  IwbStatementContainer = interface
    ['{B501F899-6891-4914-9313-AFEA4F6F0D97}']
    procedure AddStatement(const aStatementBuilder: IwbStatementBuilder);
  end;

  IwbMatchRuleBuilder = interface(IwbRuleBuilder)
    ['{C01362D2-1D87-44C2-BE16-9DEE9FE37A1B}']
  end;

  IwbChangeRuleBuilder = interface(IwbRuleBuilder)
    ['{DF5F7B4E-5FFC-4BE8-A76A-2EF1EA02F55E}']
  end;

  IwbScriptBuilder = interface
    ['{20C6A5BF-9368-4E29-A988-9CA12E3D6661}']
    procedure AddRule(const aRuleBuilder: IwbRuleBuilder);

    function CreateStatementBlock: IwbStatementBuilder;
    function CreateWithStatement(aIsEach: Boolean; const aExpression: IwbExpressionBuilder; const aStatement: IwbStatementBuilder): IwbStatementBuilder;
    function CreateSetStatement(const aField, aExpression: IwbExpressionBuilder): IwbStatementBuilder;
    function CreateModifyStatement(const aField: IwbExpressionBuilder; aModifyType: TwbModifyType; const aExpression: IwbExpressionBuilder): IwbStatementBuilder;

    function CreateExpressionBuilder: IwbExpressionBuilder;
  end;

implementation

uses
  Math,
  Windows, Classes, SysUtils, Direct3D9, D3DX9, wbHelpers
  // Previously commented out by Elminster
  {, wbScriptParse};

type
  IwbScriptRule = interface
    ['{688B619A-FBB0-4602-971D-577991C1CC38}']
    function NeedRefsFor(const aFile: IwbFile): Boolean;
    function ShouldScan(const aContainer: IwbContainerElementRef): Boolean;
    function Match(const aElement: IwbElement; var aScanRefBy: Boolean; var aAction: IwbScriptAction): Boolean;
  end;

  IwbScriptRuleInternal = interface(IwbScriptRule)
    ['{63539910-5259-4B01-92C7-13D327E7ED77}']
    function IsEmpty: Boolean;
    procedure AddAction(const aAction: IwbScriptAction);
  end;

  TwbScript = class(TInterfacedObject, IwbScript)
  private
    scFiles    : TDynFiles;
    scFilesMap : TStringList;
    scRules    : array of IwbScriptRule;
  protected
    procedure LoadScript(const aScript: TStrings);

    function NeedRefsFor(const aFile: IwbFile): Boolean;
    function ShouldScan(const aContainer: IwbContainerElementRef): Boolean;
    function Match(const aElement: IwbElement; var aScanRefBy: Boolean; var aAction: IwbScriptAction): Boolean;

    procedure BuildAllRefs;
    procedure ResetAllTags;

    {---IwbScript---}
    procedure LoadFromFile(const aFileName: string);
    procedure LoadFromString(const s: string);

    procedure ScanForTargets(out aElements: TDynElements; out aActions:TDynActions; aProgress: TwbScriptScanProgress);
  public
    constructor Create(const aFiles: TDynFiles);
    destructor Destroy; override;
  end;

  TwbAddRefrAction = class(TInterfacedObject, IwbScriptAction)
  private
    araMainRecord : IwbMainRecord;
    araPos        : TD3DXVector3;
    araRot        : TD3DXVector3;
    araScale      : Single;
    araEDIDPrefix : string;
    araEDIDSuffix : string;
  protected
    {---IwbScriptAction---}
    function Process(const aElement: IwbElement): Boolean;
  public
    constructor Create(const aMainRecord: IwbMainRecord; const aPos, aRot: TD3DXVector3; const aScale: Single; const aEDIDPrefix, aEDIDSuffix: string);
  end;

  TwbDeleteRefrAction = class(TInterfacedObject, IwbScriptAction)
  private
  protected
    {---IwbScriptAction---}
    function Process(const aElement: IwbElement): Boolean;
  public
    constructor Create;
  end;

  TwbSetElementAction = class(TInterfacedObject, IwbScriptAction)
  private
    seaElement    : string;
    seaValue      : string;
    seaMasterFile : IwbFile;
  protected
    {---IwbScriptAction---}
    function Process(const aElement: IwbElement): Boolean;
  public
    constructor Create(const aElement, aValue: string; const aMasterFile: IwbFile);
  end;

  TwbMatchRefrRule = class(TInterfacedObject, IwbScriptRule, IwbScriptRuleInternal)
  private
    mrrMainRecord : IwbMainRecord;
    mrrActions    : TDynActions;
  protected
    {---IwbScriptRule---}
    function NeedRefsFor(const aFile: IwbFile): Boolean;
    function ShouldScan(const aContainer: IwbContainerElementRef): Boolean;
    function Match(const aElement: IwbElement; var aScanRefBy: Boolean; var aAction: IwbScriptAction): Boolean;
    {---IwbScriptRuleInternal---}
    function IsEmpty: Boolean;
    procedure AddAction(const aAction: IwbScriptAction);
  public
    constructor Create(const aMainRecord: IwbMainRecord);
  end;

  TwbNullRule = class(TInterfacedObject, IwbScriptRule, IwbScriptRuleInternal)
  protected
    {---IwbScriptRule---}
    function NeedRefsFor(const aFile: IwbFile): Boolean;
    function ShouldScan(const aContainer: IwbContainerElementRef): Boolean;
    function Match(const aElement: IwbElement; var aScanRefBy: Boolean; var aAction: IwbScriptAction): Boolean;
    {---IwbScriptRuleInternal---}
    function IsEmpty: Boolean;
    procedure AddAction(const aAction: IwbScriptAction);
  public
    constructor Create;
  end;

  IwbActionHub = interface(IwbScriptAction)
    ['{227AA3F7-75EA-4751-AA5E-014AB065E011}']
    procedure AddActions(const aActions: TDynActions);
  end;

  TwbActionHub = class(TInterfacedObject, IwbScriptAction, IwbActionHub)
  private
    ahActions: TDynActions;
  protected
    {---IwbScriptAction---}
    function Process(const aElement: IwbElement): Boolean;
    {---IwbActionHub---}
    procedure AddActions(const aActions: TDynActions);
  public
    class procedure Add(var aAction: IwbScriptAction; const aActions: TDynActions);

    constructor Create(const aAction: IwbScriptAction);
  end;


function wbCreateScript(const aFiles: TDynFiles): IwbScript;
begin
  Result := TwbScript.Create(aFiles);
end;

{ TwbScript }

procedure TwbScript.BuildAllRefs;
var
  i         : Integer;
  _File     : IwbFile;
  OldAction : string;
begin
  OldAction := wbCurrentAction;
  try
    for i := Low(scFiles) to High(scFiles) do begin
      _File := scFiles[i];
      if not (csRefsBuild in _File.ContainerStates) and NeedRefsFor(_File) then begin
        wbCurrentAction := 'Building reference information for ' + _File.Name;
        if Assigned(wbProgressCallback) then
          wbProgressCallback('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] ' + wbCurrentAction);
        _File.BuildRef;
      end;
    end;
  finally
    wbCurrentAction := OldAction;
  end;
end;

constructor TwbScript.Create(const aFiles: TDynFiles);
var
  i: Integer;
begin
  scFiles := aFiles;
  scFilesMap := TStringList.Create;
  for i := Low(scFiles) to High(scFiles) do
    scFilesMap.AddObject(afiles[i].FileName, TObject(Pointer(scFiles[i])));
  scFilesMap.Sorted := True;
  inherited Create;
end;

destructor TwbScript.Destroy;
begin
  FreeAndNil(scFilesMap);
  inherited;
end;

procedure TwbScript.LoadFromFile(const aFileName: string);
var
  Strings: TStringList;
begin
  Strings := TStringList.Create;
  try
    Strings.LoadFromFile(aFileName);
    LoadScript(Strings);
  finally
    Strings.Free;
  end;
end;

procedure TwbScript.LoadFromString(const s: string);
var
  Strings: TStringList;
begin
  Strings := TStringList.Create;
  try
    Strings.Text := s;
    LoadScript(Strings);
  finally
    Strings.Free;
  end;
end;

procedure TwbScript.LoadScript(const aScript: TStrings);
var
  i           : Integer;
  CurrentLine : Integer;
  s, t        : string;
  CurrentRule : IwbScriptRuleInternal;
  Temp        : TStringList;
  _File       : IwbFile;
  MainRecord  : IwbMainRecord;
  Position    : TD3DXVector3;
  Rotation   	: TD3DXVector3;
  Scale       : Single;
  EDIDPrefix  : string;
  EDIDSuffix  : string;
begin
  //very very simple parser for now.

  Temp := TStringList.Create;
  try
    CurrentLine := 0;
    while CurrentLine < aScript.Count do try
      s := Trim(aScript[CurrentLine]);
      i := Pos('#', s);
      if i > 0 then
        s := Trim(Copy(s, 1, Pred(i)));
      if s <> '' then
        if Assigned(CurrentRule) then begin
          if UpperCase(s) = 'END MATCH' then begin
            if not CurrentRule.IsEmpty then begin
              SetLength(scRules, Succ(Length(scRules)));
              scRules[High(scRules)] := CurrentRule;
            end;
            CurrentRule := nil;
            Inc(CurrentLine);
            Continue;
          end;
          if UpperCase(Copy(s, 1, Length('SET '))) = 'SET ' then begin
            Delete(s, 1, Length('SET '));
            Temp.Delimiter := ' ';
            Temp.StrictDelimiter := True;
            Temp.DelimitedText := s;
            Temp.StrictDelimiter := False;
            for i := Pred(Temp.Count) downto 0 do
              if Temp[i] = '' then
                Temp.Delete(i);
            if Temp.Count <> 3 then
              raise Exception.Create('Expected format for SET is: SET <ElementName> TO <Value>');
            if UpperCase(Temp[1]) <> 'TO' then
              raise Exception.Create('Expected format for SET is: SET <ElementName> TO <Value>');

            t := Temp[0];
            s := Temp[2];
            if (Length(s) > 11) and (s[Length(s)-6] = ':') and (LowerCase(Copy(s, Length(s) - 10, 3)) = '.es') then begin
              i := Pos(':', s);
              Temp.Clear;
              Temp.Add(Copy(s, 1, Pred(i)));
              Temp.Add(Copy(s, Succ(i), High(Integer)));
              if (Temp[0] = '') or (Length(Temp[1]) <> 6) then
                raise Exception.Create('Expected format for record references is FileName:FormID');
              if scFilesMap.Find(Temp[0], i) then
                _File := IwbFile(Pointer(scFilesMap.Objects[i]))
              else
                _File := nil;
              if Assigned(_File) then
                MainRecord := _File.RecordByFormID[ Cardinal(StrToInt('$'+Temp[1]) and $00FFFFFF) or (Cardinal(_File.LoadOrder) shl Cardinal(24)) , True]
              else
                MainRecord := nil;

              if Assigned(MainRecord) then
                CurrentRule.AddAction(TwbSetElementAction.Create(t, IntToHex64(MainRecord.LoadOrderFormID, 8), _File));
            end else
              CurrentRule.AddAction(TwbSetElementAction.Create(Temp[0], Temp[2], nil));
          end else if UpperCase(Copy(s, 1, Length('DELETE'))) = 'DELETE' then begin
            CurrentRule.AddAction(TwbDeleteRefrAction.Create);
          end else begin
            if UpperCase(Copy(s, 1, Length('ADD REFR '))) <> 'ADD REFR ' then
              raise Exception.Create('ADD REFR or END MATCH expected');
            Delete(s, 1, Length('ADD REFR '));
            s := Trim(s);
            Temp.CommaText := s;
            for i := 0 to Pred(Temp.Count) do
              Temp[i] := Trim(Temp[i]);
            if Temp.Count < 8 then
              raise Exception.Create('Expected format for ADD REFR is FileName:FormID,PosX,PosY,PosZ,RotX,RotY,RotZ,Scale[,EDIDPrefix[,EDIDSuffix]]');

            with Position do begin
              x := StrToFloat(Temp[1]);
              y := StrToFloat(Temp[2]);
              z := StrToFloat(Temp[3]);
            end;

            with Rotation do begin
              x := (StrToFloat(Temp[4]) * Pi) / 180;
              y := (StrToFloat(Temp[5]) * Pi) / 180;
              z := (StrToFloat(Temp[6]) * Pi) / 180;
            end;

            Scale := StrToFloat(Temp[7]);

            EDIDPrefix := '';
            if Temp.Count >= 9 then
              EDIDPrefix := Temp[8];

            EDIDSuffix := '';
            if Temp.Count >= 10 then
              EDIDSuffix := Temp[9];

            Temp.Delimiter := ':';
            Temp.DelimitedText := Temp[0];
            if Temp.Count <> 2 then
              raise Exception.Create('Expected format for ADD REFR is FileName:FormID,PosX,PosY,PosZ,RotX,RotY,RotZ,Scale[,EDIDPrefix[,EDIDSuffix]]');
            if scFilesMap.Find(Temp[0], i) then
              _File := IwbFile(Pointer(scFilesMap.Objects[i]))
            else
              _File := nil;
            if Assigned(_File) then
              MainRecord := _File.RecordByFormID[ Cardinal(StrToInt('$'+Temp[1]) and $00FFFFFF) or (Cardinal(_File.LoadOrder) shl Cardinal(24)) , True]
            else
              MainRecord := nil;

            if Assigned(MainRecord) then
              CurrentRule.AddAction(TwbAddRefrAction.Create(MainRecord, Position, Rotation, Scale, EDIDPrefix, EDIDSuffix));
          end;
        end else begin
          if UpperCase(Copy(s, 1, Length('MATCH REFR WHERE NAME = '))) <> 'MATCH REFR WHERE NAME = ' then
            raise Exception.Create('MATCH REFR WHERE NAME = expected');
          Delete(s, 1, Length('MATCH REFR WHERE NAME = '));
          s := Trim(s);
          Temp.CommaText := s;
          if Temp.Count <> 1 then
            raise Exception.Create('Expected format for MATCH REFR WHERE NAME = is FileName:FormID');
          Temp.Delimiter := ':';
          Temp.DelimitedText := Temp[0];
          if Temp.Count <> 2 then
            raise Exception.Create('Expected format for MATCH REFR WHERE NAME = is FileName:FormID');
          if scFilesMap.Find(Temp[0], i) then
            _File := IwbFile(Pointer(scFilesMap.Objects[i]))
          else
            _File := nil;
          if Assigned(_File) then
            MainRecord := _File.RecordByFormID[ Cardinal(StrToInt('$'+Temp[1]) and $00FFFFFF) or (Cardinal(_File.LoadOrder) shl Cardinal(24)) , True]
          else
            MainRecord := nil;
          if Assigned(MainRecord) then
            CurrentRule := TwbMatchRefrRule.Create(MainRecord)
          else
            CurrentRule := TwbNullRule.Create;
        end;
      Inc(CurrentLine);
    except
      on E: Exception do begin
        E.Message := 'Line '+IntToStr(CurrentLine)+': '+ E.Message;
        raise;
      end;
    end;
  finally
    Temp.Free;
  end;
end;

function TwbScript.Match(const aElement: IwbElement; var aScanRefBy: Boolean;var aAction: IwbScriptAction): Boolean;
var
  i         : Integer;
  ScanRefBy : Boolean;
begin
  aScanRefBy := False;
  Result := False;
  for i := Low(scRules) to High(scRules) do begin
    ScanRefBy := False;
    Result := scRules[i].Match(aElement, ScanRefBy, aAction) or Result;
    aScanRefBy := aScanRefBy or ScanRefBy;
  end;
end;

function TwbScript.NeedRefsFor(const aFile: IwbFile): Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := Low(scRules) to High(scRules) do begin
    Result := scRules[i].NeedRefsFor(aFile);
    if Result then
      Exit;
  end;
end;

procedure TwbScript.ResetAllTags;
var
  i: Integer;
begin
  for i := Low(scFiles) to High(scFiles) do
    scFiles[i].ResetTags;
end;

procedure TwbScript.ScanForTargets(out aElements: TDynElements; out aActions: TDynActions; aProgress: TwbScriptScanProgress);
var
  StartTick  : Cardinal;
  TotalCount : Integer;
  Count      : Integer;

  procedure ScanRecord(aMainRecord: IwbMainRecord);
  var
    i          : Integer;
    ScanRefBy  : Boolean;
  begin
    aMainRecord := aMainRecord.WinningOverride;
    if not aMainRecord.IsTagged then begin
      Inc(TotalCount);
      aMainRecord.Tag;

      if Match(aMainRecord, ScanRefBy, aActions[Count]) then begin
        aElements[Count] := aMainRecord;
        Inc(Count);
        if High(aElements) < Count then begin
          SetLength(aElements, Length(aElements) * 2);
          SetLength(aActions , Length(aElements));
        end;
      end else
        aActions[Count] := nil;

      if ScanRefBy then
        for i := 0 to Pred(aMainRecord.ReferencedByCount) do
          ScanRecord(aMainRecord.ReferencedBy[i]);
    end;
  end;

  procedure FindRecords(const aElement: IwbElement);
  var
    MainRecord : IwbMainRecord;
    Container  : IwbContainerElementRef;
    i          : Integer;
  begin
    if Assigned(aProgress) then
      if StartTick + 500 < GetTickCount then begin
        aProgress(TotalCount, Count);
        StartTick := GetTickCount;
      end;

    if Supports(aElement, IwbMainRecord, MainRecord) then
      ScanRecord(MainRecord)
    else if Supports(aElement, IwbContainerElementRef, Container) then
      if ShouldScan(Container) then
        for i := 0 to Pred(Container.ElementCount) do
          FindRecords(Container.Elements[i]);
  end;

var
  i: Integer;
begin
  StartTick := GetTickCount;
  TotalCount := 0;
  Count := 0;
  aElements := nil;
  aActions := nil;
  SetLength(aElements, 1024);
  SetLength(aActions, 1024);
  BuildAllRefs;
  ResetAllTags;
  for i := Low(scFiles) to High(scFiles) do
    FindRecords(scFiles[i]);
  SetLength(aElements, Count);
  SetLength(aActions, Count);
end;

function TwbScript.ShouldScan(const aContainer: IwbContainerElementRef): Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := Low(scRules) to High(scRules) do begin
    Result := scRules[i].ShouldScan(aContainer);
    if Result then
      Exit;
  end;
end;

{ TwbAddRefrAction }

constructor TwbAddRefrAction.Create(const aMainRecord: IwbMainRecord;
  const aPos, aRot: TD3DXVector3; const aScale: Single; const aEDIDPrefix, aEDIDSuffix: string);
begin
  araMainRecord := aMainRecord;
  araPos := aPos;
  araRot := aRot;
  araScale := aScale;
  araEDIDPrefix := aEDIDPrefix;
  araEDIDSuffix := aEDIDSuffix;
end;

function NormalizeRotation(const aRot: TD3DXVector3): TD3DXVector3;

  function NormalizeAxis(const aValue: Single): Single;
  begin
    Result := aValue;
    while Result < (-Pi) do
      Result := Result + (2*Pi);
    while Result > Pi do
      Result := Result - (2*Pi);
  end;

begin
  Result.x := NormalizeAxis(aRot.x);
  Result.y := NormalizeAxis(aRot.y);
  Result.z := NormalizeAxis(aRot.z);
end;

  // elevation = x
  // bank = y
  // heading = z

function QuatFromEuler(const aEuler: TD3DXVector3): TD3DXQuaternion;
var
  c1, c2, c3 : Single;
  s1, s2, s3 : Single;
  c1c2, s1s2 : Single;
begin
  with aEuler do begin
    c1 := Cos(x/2);
    c2 := Cos(y/2);
    c3 := Cos(z/2);
    s1 := Sin(x/2);
    s2 := Sin(y/2);
    s3 := Sin(z/2);
  end;

 c1c2 := c1 * c2;
 s1s2 := s1 * s2;

 with Result do begin
   w := c1c2 * c3 + s1s2 * s3;
   x := s1 * c2 * c3 - c1 * s2 * s3;
   y := c1 * s2 * c3 + s1 * c2 * s3;
   z := c1c2 * s3 - s1s2 * c3;
 end;
end;

function EulerFromQuat(const aQuat: TD3DXQuaternion): TD3DXVector3;
var
  sqw, sqx, sqy, sqz : Single;
  _Unit              : Single;
  Test               : Single;
begin
  with aQuat do begin
    sqw := Sqr(w);
    sqx := Sqr(x);
    sqy := Sqr(y);
    sqz := Sqr(z);
    Test := x*z - w*y;
    _Unit := sqw + sqx + sqy + sqz;

    if Test > 0.49992 * _Unit then begin
      Result.x := -ArcTan2( 2.0 * x*y - 2.0 * w*z , sqw - sqx + sqy - sqz );
      Result.y := -Pi/2;
      Result.z := 0.0;
    end else if Test < -0.49992 * _Unit then begin
      Result.x := -ArcTan2( 2.0 * w*z - 2.0 * x*y , sqw - sqx + sqy - sqz );
      Result.y := Pi/2;
      Result.z := 0.0;
    end else begin
      Result.x := -ArcTan2( -2.0 * x*w - 2.0 * y*z , sqw - sqx - sqy + sqz );
      Result.y := -ArcSin( ( 2.0 * Test ) / _Unit );
      Result.z := -ArcTan2( -2.0 * x*y - 2.0 * w*z , sqw + sqx - sqy - sqz );
    end;
  end;
end;

function QuatMultQuat(const a, b: TD3DXQuaternion): TD3DXQuaternion;
begin
  with Result do begin
    w := a.w * b.w - a.x * b.x - a.y * b.y - a.z * b.z;
    x := a.w * b.x + a.x * b.w - a.y * b.z + a.z * b.y;
    y := a.w * b.y + a.x * b.z + a.y * b.w - a.z * b.x;
    z := a.w * b.z - a.x * b.y + a.y * b.x + a.z * b.w;
  end;
end;

function QuatMultVec3(const q: TD3DXQuaternion; const v: TD3DXVector3): TD3DXVector3;
var
  t2, t3, t4, t5, t6, t7, t8, t9, t10: Single;
begin
  with q do begin
    t2  := w * x;
    t3  := w * y;
    t4  := w * z;
    t5  := -x * x;
    t6  := x * y;
    t7  := x * z;
    t8  := -y * y;
    t9  := y * z;
    t10 := -z * z;
  end;
  with Result do begin
    x := 2 * ( ( t8 + t10 ) * v.x + ( t6 + t4 ) * v.y + ( t7 - t3 ) * v.z ) + v.x;
    y := 2 * ( ( t6 - t4 ) * v.x + ( t5 + t10 ) * v.y + ( t9 + t2 ) * v.z ) + v.y;
    z := 2 * ( ( t7 + t3 ) * v.x + ( t9 - t2 ) * v.y + ( t5 + t8 ) * v.z ) + v.z;
  end;
end;


function TwbAddRefrAction.Process(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
  MainRef    : IwbContainerElementRef;
  NameRec    : IwbContainerElementRef;
  DataRec    : IwbContainerElementRef;

  Position   : TD3DXVector3;
  Rotation   : TD3DXVector3;
  Scale      : Single;

  Matrix     : TD3DXMatrix;
//  Matrix2    : TD3DXMatrix;
//  Matrix3    : TD3DXMatrix;

  Quat       : TD3DXQuaternion;
  Quat2      : TD3DXQuaternion;
  Quat3      : TD3DXQuaternion;
//  t          : Single;

  Pos        : TD3DXVector3;
  Rot        : TD3DXVector3;
  Temp       : TD3DXVector3;

//  q1,q2,q3,q4: Single;
//  Test2      : array [0..3,0..3,0..3,0..3] of TD3DXVector3;
//  i,j,k,l    : Integer;

  GroupRecord: IwbGroupRecord;

  NewRecord  : IwbMainRecord;
begin
  Result := False;
  if Supports(aElement, IwbMainRecord, MainRecord) and
     Supports(aElement, IwbContainerElementRef, MainRef) and
     Supports(MainRecord.RecordBySignature['DATA'], IwbContainerElementRef, DataRec) and
     (DataRec.ElementCount = 2) then begin

    with Position, (DataRec.Elements[0] as IwbContainerElementRef) do begin
      if ElementCount >= 1 then
        X := StrToFloatDef(Elements[0].Value, 0);
      if ElementCount >= 2 then
        Y := StrToFloatDef(Elements[1].Value, 0);
      if ElementCount >= 3 then
        Z := StrToFloatDef(Elements[2].Value, 0);
    end;
    with Rotation, (DataRec.Elements[1] as IwbContainerElementRef) do begin
      if ElementCount >= 1 then
        X := StrToFloatDef(Elements[0].Value, 0);
      if ElementCount >= 2 then
        Y := StrToFloatDef(Elements[1].Value, 0);
      if ElementCount >= 3 then
        Z := StrToFloatDef(Elements[2].Value, 0);
    end;
    Rot := NormalizeRotation(Rot);
    if Supports(MainRecord.RecordBySignature['XSCL'], IwbContainerElementRef, DataRec) then
      Scale := StrToFloatDef(DataRec.Value, 1)
    else
      Scale := 1;

    Pos := araPos;
    if Scale <> 1 then begin
      D3DXMatrixScaling(Matrix, Scale, Scale, Scale);
      D3DXVec3TransformCoord(Temp, Pos, Matrix);
      Pos := Temp;
    end;

    Quat := QuatFromEuler(Rotation);
    Temp := QuatMultVec3(Quat, Pos);
    Pos := Temp;

    D3DXVec3Add(Temp, Pos, Position);
    Pos := Temp;

    Quat2 := QuatFromEuler(araRot);
    Quat3 := QuatMultQuat(Quat, Quat2);
    Rot := EulerFromQuat(Quat3);

    Scale := Scale * araScale;

    {
    with Rotation do
      Quat := QuatFromEuler(D3DXVector3(x, y, z));

    D3DXMatrixRotationQuaternion(Matrix, Quat);
    D3DXVec3TransformCoord(Temp, Pos, Matrix);
    Pos := Temp;

    D3DXVec3Add(Temp, Pos, Position);
    Pos := Temp;

    with araRot do
      Quat2 := QuatFromEuler(D3DXVector3(x, y, z));

    D3DXQuaternionMultiply(Quat3, Quat, Quat2);

    Rot := EulerFromQuat(Quat3);

    Scale := Scale * araScale;
    }

    if Supports(MainRecord.Container, IwbGroupRecord, GroupRecord) then begin
      GroupRecord._File.AddMasterIfMissing(araMainRecord.MasterOrSelf._File.FileName);

      NewRecord := GroupRecord.Add('REFR', True) as IwbMainRecord;
      NewRecord.IsPersistent := MainRecord.IsPersistent;
      NewRecord.IsVisibleWhenDistant := MainRecord.IsVisibleWhenDistant;

      if ((araEDIDPrefix <> '') or (araEDIDSuffix <> '')) and (MainRecord.EditorID <> '') then
        NewRecord.EditorID := araEDIDPrefix + MainRecord.EditorID + araEDIDSuffix;

      NameRec := NewRecord.Add('NAME', True) as IwbContainerElementRef;
      NameRec.EditValue := IntToHex64(araMainRecord.LoadOrderFormID, 8);

      DataRec := NewRecord.Add('DATA', True) as IwbContainerElementRef;
      with Pos, (DataRec.Elements[0] as IwbContainerElementRef) do begin
        Assert(ElementCount = 3);
        Elements[0].EditValue := FloatToStr(x);
        Elements[1].EditValue := FloatToStr(y);
        Elements[2].EditValue := FloatToStr(z);
      end;
      with Rot, (DataRec.Elements[1] as IwbContainerElementRef) do begin
        Assert(ElementCount = 3);
        Elements[0].EditValue := FloatToStr(x);
        Elements[1].EditValue := FloatToStr(y);
        Elements[2].EditValue := FloatToStr(z);
      end;

      if Scale <> 1 then begin
        DataRec := NewRecord.Add('XSCL', True) as IwbContainerElementRef;
        DataRec.EditValue := FloatToStr(Scale);
      end;
    end;
  end;
end;

{ TwbMatchRefrRule }

procedure TwbMatchRefrRule.AddAction(const aAction: IwbScriptAction);
begin
  SetLength(mrrActions, Succ(Length(mrrActions)));
  mrrActions[High(mrrActions)] := aAction;
end;

constructor TwbMatchRefrRule.Create(const aMainRecord: IwbMainRecord);
begin
  mrrMainRecord := aMainRecord;
end;

function TwbMatchRefrRule.IsEmpty: Boolean;
begin
  Result := Length(mrrActions) < 1;
end;

function TwbMatchRefrRule.Match(const aElement: IwbElement; var aScanRefBy: Boolean; var aAction: IwbScriptAction): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  aScanRefBy := False;

  if Supports(aElement, IwbMainRecord, MainRecord) then begin
    if MainRecord.LoadOrderFormID = mrrMainRecord.LoadOrderFormID then
      aScanRefBy := True
    else begin
      Result := (MainRecord.BaseRecordID = mrrMainRecord.LoadOrderFormID);
      if Result then
        TwbActionHub.Add(aAction, mrrActions);
    end;
  end;
end;

function TwbMatchRefrRule.NeedRefsFor(const aFile: IwbFile): Boolean;
begin
  Result := aFile.LoadOrder >= mrrMainRecord._File.LoadOrder;
end;

function TwbMatchRefrRule.ShouldScan(const aContainer: IwbContainerElementRef): Boolean;
var
  _File: IwbFile;
begin
  Result :=
    aContainer.Equals(mrrMainRecord.Container) or
    (Supports(aContainer, IwbFile, _File) and (_File.Equals(mrrMainRecord._File)));
end;

{ TwbNullRule }

procedure TwbNullRule.AddAction(const aAction: IwbScriptAction);
begin
  // nothing
end;

constructor TwbNullRule.Create;
begin
  inherited Create;
end;

function TwbNullRule.IsEmpty: Boolean;
begin
  Result := True;
end;

function TwbNullRule.Match(const aElement: IwbElement; var aScanRefBy: Boolean; var aAction: IwbScriptAction): Boolean;
begin
  Result := False;
  aScanRefBy := False;
end;

function TwbNullRule.NeedRefsFor(const aFile: IwbFile): Boolean;
begin
  Result := False;
end;

function TwbNullRule.ShouldScan(const aContainer: IwbContainerElementRef): Boolean;
begin
  Result := False;
end;

{ TwbActionHub }

class procedure TwbActionHub.Add(var aAction: IwbScriptAction; const aActions: TDynActions);
var
  ActionHub: IwbActionHub;
begin
  if not Supports(aAction, IwbActionHub, ActionHub) then
    case Length(aActions) of
      0: Exit;
      1: if not Assigned(aAction) then begin
           aAction := aActions[0];
           Exit;
         end;
    else
      ActionHub := TwbActionHub.Create(aAction);
      aAction := ActionHub;
    end;
  ActionHub.AddActions(aActions);
end;

procedure TwbActionHub.AddActions(const aActions: TDynActions);
var
  OldLength : Integer;
  i         : Integer;
begin
  if Length(aActions) < 1 then
    Exit;
  OldLength := Length(ahActions);
  SetLength(ahActions, OldLength + Length(aActions));
  for i := Low(aActions) to High(aActions) do
    ahActions[i + OldLength] := aActions[i];
end;

constructor TwbActionHub.Create(const aAction: IwbScriptAction);
begin
  if Assigned(aAction) then begin
    SetLength(ahActions, 1);
    ahActions[0] := aAction;
  end;
  inherited Create;
end;

function TwbActionHub.Process(const aElement: IwbElement): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Low(ahActions) to High(ahActions) do
    Result := ahActions[i].Process(aElement) or Result;
end;

{ TwbDeleteRefrAction }

constructor TwbDeleteRefrAction.Create;
begin
 //...
end;


function TwbDeleteRefrAction.Process(const aElement: IwbElement): Boolean;
var
  MainRecord  : IwbMainRecord;
  REFRs       : TDynMainRecords;
  BaseRecord  : IwbContainerElementRef;
  i           : Integer;
begin
  Result := False;
  if Supports(aElement, IwbMainRecord, MainRecord) and (MainRecord.Signature = 'REFR') then begin
    REFRs := wbGetSiblingREFRsWithin(MainRecord, 300);
    for i := Low(REFRs) to High(REFRs) do
      if Supports(REFRs[i].BaseRecord, IwbContainerElementRef, BaseRecord) then
        if (BaseRecord.ElementValues['Record Header\Signature'] = 'LIGH') and
           not BaseRecord.ElementExists['Model'] then begin
             REFRs[i].DeleteInto(MainRecord._File);
             Result := True;
           end;
  end;
end;

{ TwbSetElementAction }

constructor TwbSetElementAction.Create(const aElement, aValue: string; const aMasterFile: IwbFile);
begin
  seaElement := aElement;
  seaValue := aValue;
  seaMasterFile := aMasterFile;
  inherited Create;
end;

function TwbSetElementAction.Process(const aElement: IwbElement): Boolean;
var
  MainRecord  : IwbMainRecord;
//  REFRs       : TDynMainRecords;
//  BaseRecord  : IwbContainerElementRef;
//  i           : Integer;
begin
  Result := False;
  if Supports(aElement, IwbMainRecord, MainRecord) then begin
    if Assigned(seaMasterFile) then
      MainRecord._File.AddMasterIfMissing(seaMasterFile.FileName);
    MainRecord.ElementEditValues[seaElement] := seaValue;
    Result := True;
  end;
end;

//var
//  Quat  : TD3DXQuaternion;
//  Euler : TD3DXVector3;


initialization

{
 Quat.y := -0.048730;
 Quat.x := 0.671283;
 Quat.w := 0.736597;
 Quat.z := 1.179320;

 Euler := EulerFromQuat(Quat);
 Euler.x := Euler.x / Pi * 180;
 Euler.y := Euler.y / Pi * 180;
 Euler.z := Euler.z / Pi * 180;
 Euler := EulerFromQuat(Quat);
}

end.
