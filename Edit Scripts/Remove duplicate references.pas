{
  Remove duplicate reference records that have the same scale, position and rotation.
  
  When bDetectByModel = False, base record will be used for detection, in case when duplicated references
    put the same record in the same spot.
  
  When bDetectByModel = True, base record model file name will be used, in case when duplicated references
    put different records in the same spot, however the put model is the same.
  
  When bDetectSpecial = True, both duplicate refs will be checked for having additional data like enabled parents,
    linked refs, door teleport, attached scripts, etc. The record with less significance (without such data)
    will be removed.
}
unit RemoveDuplicateReferences;

const
  bDetectByModel = False;
  bDetectSpecial = True;

var
  slRefs: TStringList;
  

function IsSpecial(e: IInterface): Boolean;
var
  i: Integer;
begin
  // check if ref has any of special data fields
  Result :=
    ElementExists(e, 'EDID') or
    ElementExists(e, 'VMAD') or
    ElementExists(e, 'XESP') or
    ElementExists(e, 'XTEL') or
    ElementExists(e, 'XLKR') or
    ElementExists(e, 'XNDP') or
    ElementExists(e, 'Activate Parents') or
    ElementExists(e, 'Patrol Data');
  
  // or referenced by PACK
  if not Result then
    for i := 0 to Pred(ReferencedByCount(e)) do
      if Signature(ReferencedByIndex(e, i)) = 'PACK' then begin
        Result := True;
        Break;
      end;
end;

function Initialize: integer;
begin
  slRefs := TwbFastStringList.Create;
end;

function Process(e: IInterface): integer;
var
  token, id: string;
  i: integer;
  dup: IInterface;
  specialref, specialdup: Boolean;
begin
  // clear unique refs list for each new CELL, purely for optimization
  if Signature(e) = 'CELL' then begin
    slRefs.Clear;
    Exit;
  end;
  
  // master records only
  if not IsMaster(e) then
    Exit;
    
  // handle only reference type records
  if Pos(Signature(e), 'REFR ACHR ACRE PMIS PHZD PGRE PARW PBAR PBEA PCON PFLA') = 0 then
    Exit;

  if bDetectByModel then
    // detect duplicates by base record model name
    id := wbNormalizeResourceName(GetElementEditValues(BaseRecord(e), 'Model\MODL'), resMesh)
  else
    // detect duplicates by base record
    id := Name(BaseRecord(e));
    
  if id = '' then
    Exit;
   
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
  
  // find a dup by existing token for the current cell
  i := slRefs.IndexOf(token);
  if i = -1 then begin
    slRefs.AddObject(token, e);
    Exit;
  end;

  // we found a duplicate record for ourselves
  dup := ObjectToElement(slRefs.Objects[i]);
  
  // delect which record to delete by "special" status
  if bDetectSpecial then begin
    specialref := IsSpecial(e);
    specialdup := IsSpecial(dup);
    
    // both are special, report and don't delete any
    if specialref and specialdup then begin
      AddMessage('Both dups are special, skipping:');
      AddMessage(#9 + Name(e));
      AddMessage(#9 + Name(dup));
    end
    
    // current record is special, dup is not - delete the dup
    else if specialref then begin
      AddMessage('One of the dups is special:');
      AddMessage(#9'Removing: ' + Name(dup));
      AddMessage(#9'Remaining: ' + Name(e));
      RemoveNode(dup);
      slRefs.Objects[i] := e; // replace deleted dup with ourselves
    end
    
    // dup is special, current record is not - delete the current record
    else begin
      AddMessage('One of the dups is special:');
      AddMessage(#9'Removing: ' + Name(e));
      AddMessage(#9'Remaining: ' + Name(dup));
      RemoveNode(e);
    end;
  end
  
  // no special detection, simply delete the current record
  else begin
    AddMessage('Found duplicates:');
    AddMessage(#9'Removing: ' + Name(e));
    AddMessage(#9'Remaining: ' + Name(dup));
    RemoveNode(e);
  end;
  
  AddMessage('');
end;

function Finalize: integer;
begin
  slRefs.Free;
end;

end.