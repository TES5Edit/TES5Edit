{
  Remove master references from overriding cell that have the same scale, position and rotation
  as references in the master cell. Usefull when plugin was merged into the master file, but modified
  later and now there is a need to find refs that have already been merged. Since references usually
  don't have Editor ID and their FormIDs have also changed in master file after the merging process, the only
  way to find them is by using base record or model, position, rotation and scale.
  
  When bDetectByModel = False, base record will be used for detection, in case when duplicated references
    put the same record in the same spot.
  When bDetectByModel = True, base record model file name will be used, in case when duplicated references
    put different records in the same spot, however the put model is the same.
}
unit RemoveSameReferencesAgainstMaster;

const
  bDetectByModel = False;
  bReportOnly = True; // True - only report found refs, False - report and remove them

var
  slRefs: TStringList;
  
function Initialize: integer;
begin
  slRefs := TwbFastStringList.Create;
end;

function IsRef(e: IInterface): Boolean;
begin
  Result := Pos(Signature(e), 'REFR ACHR ACRE PMIS PHZD PGRE PARW PBAR PBEA PCON PFLA') <> 0;
end;

function GetToken(e: IInterface): string;
var
  id: string;
begin
  if bDetectByModel then
    // detect by base record model name
    id := LowerCase(GetElementEditValues(BaseRecord(e), 'Model\MODL'))
  else
    // detect by base record
    id := Name(BaseRecord(e));
   
  Result := Format('%s %s %d %d %d %d %d %d', [
    id,
    GetElementEditValues(e, 'XSCL'),
    Round(GetElementNativeValues(e, 'DATA\Position\X')),
    Round(GetElementNativeValues(e, 'DATA\Position\Y')),
    Round(GetElementNativeValues(e, 'DATA\Position\Z')),
    Round(GetElementNativeValues(e, 'DATA\Rotation\X')),
    Round(GetElementNativeValues(e, 'DATA\Rotation\Y')),
    Round(GetElementNativeValues(e, 'DATA\Rotation\Z'))
  ]);
end;

procedure CompareReferences(cell1, cell2: IInterface; GroupType: integer);
var
  refs, ref: IInterface;
  i: integer;
  token: string;
begin
  slRefs.Clear;
  
  // gather master refs from the first (master) cell
  refs := FindChildGroup(ChildGroup(cell1), GroupType, cell1);
  for i := 0 to Pred(ElementCount(refs)) do begin
    ref := ElementByIndex(refs, i);
    if IsMaster(ref) and IsRef(ref) then
      slRefs.Add(GetToken(ref));
  end;

  // compare against master refs from the second (overriding) cell
  refs := FindChildGroup(ChildGroup(cell2), GroupType, cell2);
  for i := 0 to Pred(ElementCount(refs)) do begin
    ref := ElementByIndex(refs, i);
    if IsMaster(ref) and IsRef(ref) then begin
      token := GetToken(ref);
      if slRefs.IndexOf(token) <> -1 then begin
        AddMessage('Removing: ' + Name(ref));
        if not bReportOnly then
          RemoveNode(ref);
      end;
    end;  
  end;
  
end;

function Process(e: IInterface): integer;
begin
  // check per cell
  if Signature(e) <> 'CELL' then
    Exit;

  // only for overriding cell (we need a master cell to compare)
  if IsMaster(e) then
    Exit;
  
  // persistent refs
  CompareReferences(Master(e), e, 8);
  // temporary refs
  CompareReferences(Master(e), e, 9);
end;

function Finalize: integer;
begin
  slRefs.Free;
end;

end.