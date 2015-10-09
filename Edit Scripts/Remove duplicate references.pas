{
  Remove duplicate reference records that have the same scale, position and rotation.
  When bDetectByModel = False, base record will be used for detection, in case when duplicated references
    put the same record in the same spot.
  When bDetectByModel = True, base record model file name will be used, in case when duplicated references
    put different records in the same spot, however the put model is the same.
}
unit RemoveDuplicateReferences;

const
  bDetectByModel = False;

var
  slRefs: TStringList;
  
function Initialize: integer;
begin
  slRefs := TwbFastStringList.Create;
end;

function Process(e: IInterface): integer;
var
  token, id: string;
begin
  // clear unique refs list for each new CELL, purely for optimization
  if Signature(e) = 'CELL' then begin
    slRefs.Clear;
    Exit;
  end
  // handle only reference type records
  else if Pos(Signature(e), 'REFR ACHR ACRE PMIS PHZD PGRE PARW PBAR PBEA PCON PFLA') = 0 then
    Exit;

  if bDetectByModel then
    // detect duplicates by base record model name
    id := LowerCase(GetElementEditValues(BaseRecord(e), 'Model\MODL'))
  else
    // detect duplicates by base record
    id := Name(BaseRecord(e));
   
  token := Format('%s %s %d %d %d %d %d %d', [
    id,
    GetElementEditValues(e, 'XSCL'),
    Round(GetElementNativeValues(e, 'DATA\Position\X')),
    Round(GetElementNativeValues(e, 'DATA\Position\Y')),
    Round(GetElementNativeValues(e, 'DATA\Position\Z')),
    Round(GetElementNativeValues(e, 'DATA\Rotation\X')),
    Round(GetElementNativeValues(e, 'DATA\Rotation\Y')),
    Round(GetElementNativeValues(e, 'DATA\Rotation\Z'))
  ]);
  
  if slRefs.IndexOf(token) <> -1 then begin
    AddMessage('Removing: ' + Name(e));
    RemoveNode(e);
  end else
    slRefs.Add(token);
end;

function Finalize: integer;
begin
  slRefs.Free;
end;

end.