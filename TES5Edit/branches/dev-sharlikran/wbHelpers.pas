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

unit wbHelpers;

interface

uses
  Classes,
  wbInterface, Direct3D9, D3DX9, DXTypes;

function wbDistance(const a, b: TD3DXVector3): Single; overload
function wbDistance(const a, b: IwbMainRecord): Single; overload;
function wbGetSiblingREFRsWithin(const aMainRecord: IwbMainRecord; aDistance: Single): TDynMainRecords;
function FindMatchText(Strings: TStrings; const Str: string): Integer;
function IsFileESM(const aFileName: string): Boolean;
function IsFileESP(const aFileName: string): Boolean;

type
  PnxLeveledListCheckCircularStack = ^TnxLeveledListCheckCircularStack;
  TnxLeveledListCheckCircularStack = record
    rllcLast       : PnxLeveledListCheckCircularStack;
    rllcMainRecord : IwbMainRecord;
  end;

procedure wbLeveledListCheckCircular(const aMainRecord: IwbMainRecord; aStack: PnxLeveledListCheckCircularStack);

type
  TnxFastStringList = class(TStringList)
  protected
    function CompareStrings(const S1, S2: string): Integer; override;
  public
    constructor CreateSorted(aDups : TDuplicates = dupError);

    procedure Clear(aFreeObjects: Boolean = False); reintroduce;
  end;

  TnxFastStringListCS = class(TnxFastStringList)
  public
    procedure AfterConstruction; override;
  end;

  TnxFastStringListIC = class(TnxFastStringList)
  end;


implementation

uses
  Windows, SysUtils;

procedure wbLeveledListCheckCircular(const aMainRecord: IwbMainRecord; aStack: PnxLeveledListCheckCircularStack);
var
  Stack    : TnxLeveledListCheckCircularStack;
  s          : string;
  CER        : IwbContainerElementRef;
  LLE        : IwbContainerElementRef;
  i          : Integer;
  LVLO       : IwbContainerElementRef;
  Reference  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  Stack.rllcLast := aStack;
  Stack.rllcMainRecord := aMainRecord;

  while Assigned(aStack) do begin
    if aStack.rllcMainRecord.LoadOrderFormID = aMainRecord.LoadOrderFormID then begin
      s := aMainRecord.Name;
      aStack := Stack.rllcLast;
      while Assigned(aStack) do begin
        s := ' -> ' + s;
        s := aStack.rllcMainRecord.Name + s;
        if aStack.rllcMainRecord.LoadOrderFormID = aMainRecord.LoadOrderFormID then
          Break;
        aStack := aStack.rllcLast;
      end;
      s := 'Circular Leveled List found: ' + s;
      raise Exception.Create(s);
    end;
    aStack := aStack.rllcLast;
  end;

  if aMainRecord.IsTagged then
    Exit;
  aMainRecord.Tag;

  if Supports(aMainRecord, IwbContainerElementRef, CER) then begin
    if Supports(CER.ElementByName['Leveled List Entries'], IwbContainerElementRef, LLE) then begin
      for i := 0 to Pred(LLE.ElementCount) do
        if Supports(LLE.Elements[i], IwbContainerElementRef, LVLO) then begin
          if Supports(LVLO.ElementByName['Reference'], IwbContainerElementRef, Reference) then begin
            if Supports(Reference.LinksTo, IwbMainRecord, MainRecord) then begin
              if (MainRecord.Signature = aMainRecord.Signature) then begin
                MainRecord := MainRecord.WinningOverride;
                wbLeveledListCheckCircular(MainRecord, @Stack);
              end;
            end;
          end;
        end;
    end;
  end;
end;

function wbDistance(const a, b: TD3DXVector3): Single;
var
  t: TD3DXVector3;
begin
  Result := D3DXVec3Length(D3DXVec3Subtract(t,a,b)^);
end;

function wbDistance(const a, b: IwbMainRecord): Single; overload;
var
  PosA, PosB: TD3DXVector3;
begin
  if not a.GetPosition(PosA) then
    raise Exception.Create('GetPosition failed');
  if not b.GetPosition(PosB) then
    raise Exception.Create('GetPosition failed');
  Result := wbDistance(PosA, PosB);
end;

function wbGetSiblingREFRsWithin(const aMainRecord: IwbMainRecord; aDistance: Single): TDynMainRecords;
var
  Count       : Integer;
  Position    : TD3DXVector3;
  MaxLoadOrder: Integer;

  procedure FindREFRs(const aElement: IwbElement);
  var
    MainRecord : IwbMainRecord;
    Container  : IwbContainerElementRef;
    i          : Integer;
    Temp       : TD3DXVector3;
  begin
    if Supports(aElement, IwbMainRecord, MainRecord) then begin
      if not (aMainRecord.LoadOrderFormID = MainRecord.LoadOrderFormID) and
        MainRecord.GetPosition(Temp) and
        (wbDistance(Temp,Position) <= aDistance) then begin

        if High(Result) < Count then
          SetLength(Result, Length(Result) * 2);
        Result[Count] := MainRecord.HighestOverrideOrSelf[MaxLoadOrder];
        Inc(Count);

      end;
    end else
      if Supports(aElement, IwbContainerElementRef, Container) then
        for i := 0 to Pred(Container.ElementCount) do
          FindREFRs(Container.Elements[i]);
  end;

var
  GroupRecord : IwbGroupRecord;
  CellMaster  : IwbMainRecord;
  i, j        : Integer;
begin
  Result := nil;
  if not aMainRecord.GetPosition(Position) then
    Exit;
  if not Supports(aMainRecord.Container, IwbGroupRecord, GroupRecord) then
    Exit;
  if not (GroupRecord.GroupType in [8..10]) then
    Exit;
  CellMaster := GroupRecord.ChildrenOf;
  if not Assigned(CellMaster) then
    Exit;
  CellMaster := CellMaster.MasterOrSelf;
  MaxLoadOrder := aMainRecord._File.LoadOrder;

  Count := 0;
  SetLength(Result, 1024);
  FindREFRs(CellMaster.ChildGroup);
  for i := 0 to Pred(CellMaster.OverrideCount) do
    if CellMaster.Overrides[i]._File.LoadOrder <= aMainRecord._File.LoadOrder then
      FindREFRs(CellMaster.Overrides[i])
    else
      Break;
  SetLength(Result, Count);


  if Length(Result) > 1 then begin
    QuickSort(@Result[0], Low(Result), High(Result), CompareElementsFormIDAndLoadOrder);

    j := 0;
    for i := Succ(Low(Result)) to High(Result) do begin
      if (Result[j].LoadOrderFormID <> Result[i].LoadOrderFormID) and not (Result[j].IsDeleted) then
        Inc(j);
      if j <> i then
        Result[j] := Result[i];
    end;
    SetLength(Result, Succ(j));
  end;
end;

function FindMatchText(Strings: TStrings; const Str: string): Integer;
begin
  for Result := 0 to Strings.Count-1 do
    if SameText(Strings[Result], Str) then
      Exit;
  Result := -1;
end;

function IsFileESM(const aFileName: string): Boolean;
const
  ghostesm = '.esm.ghost';
begin
  Result := SameText(ExtractFileExt(aFileName), '.esm') or
    SameText(Copy(aFileName, Length(aFileName) - Length(ghostesm) + 1, Length(ghostesm)), ghostesm)
end;

function IsFileESP(const aFileName: string): Boolean;
const
  ghostesp = '.esp.ghost';
begin
  Result := SameText(ExtractFileExt(aFileName), '.esp') or
    SameText(Copy(aFileName, Length(aFileName) - Length(ghostesp) + 1, Length(ghostesp)), ghostesp)
end;


{ TnxFastStringList }

procedure TnxFastStringList.Clear(aFreeObjects: Boolean);
var
  i: Integer;
begin
  if aFreeObjects then
    for i := 0 to Pred(Count) do
      Objects[i].Free;
  inherited Clear;
end;

function TnxFastStringList.CompareStrings(const S1, S2: string): Integer;
begin
  {x$IFDEF DCC6OrLater}
  if CaseSensitive then
    Result := CompareStr(S1, S2)
  else
  {x$ENDIF}
    Result := CompareText(S1, S2);
end;

constructor TnxFastStringList.CreateSorted(aDups: TDuplicates);
begin
  Create;
  Duplicates := aDups;
  Sorted := True;
end;

{ TnxFastStringListCS }

procedure TnxFastStringListCS.AfterConstruction;
begin
  inherited;
  {x$IFDEF DCC6OrLater}
  CaseSensitive := True;
  {x$ENDIF}
end;

end.
