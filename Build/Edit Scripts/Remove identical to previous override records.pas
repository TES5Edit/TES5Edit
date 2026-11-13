{
  Compare record to the previous override and remove if the same.
  This process depends on the plugins and their load order in xEdit!
  Not to be used on DLC, mods, nor any part of the cleaning process.
  Recomended use: for removing unneeded records from dynamic patch files.
}
unit RemoveITPO;

var
  CountITPO: Integer;

function Process(e: IInterface): integer;
var
  m, prevovr, ovr: IInterface;
  i: integer;
begin
  if ((Signature(e) = 'NAVI') or (IsMaster(e)) or (ElementCount(ChildGroup(e)) <> 0)) then
    Exit;                                                     
               
  m := MasterOrSelf(e);

  // find previous override record in a list of overrides for master record
  prevovr := m;
  for i := 0 to Pred(OverrideCount(m)) do begin
    ovr := OverrideByIndex(m, i);
    if Equals(ovr, e) then
      Break;
    prevovr := ovr;
  end;
  
  // remove record if no conflicts
  if Signature(e) = 'LCTN' then
  begin
    if Assigned(ElementBySignature(e, 'ACPR')) or
       Assigned(ElementBySignature(e, 'RCPR')) or
	   Assigned(ElementBySignature(e, 'ACUR')) or
	   Assigned(ElementBySignature(e, 'RCUR')) or
       Assigned(ElementBySignature(e, 'ACUN')) or
       Assigned(ElementBySignature(e, 'RCUN')) or
       Assigned(ElementBySignature(e, 'ACSR')) or
       Assigned(ElementBySignature(e, 'RCSR')) or
       Assigned(ElementByName(e, 'Added Worldspace Cells')) or
       Assigned(ElementByName(e, 'Removed Worldspace Cells')) or
       Assigned(ElementBySignature(e, 'ACID')) or
       Assigned(ElementBySignature(e, 'ACEP'))
    then
      Exit;

    if ConflictAllForElements(prevovr, e, False, False) <= caConflictBenign then begin
      AddMessage('Removing: ' + Name(e));
      RemoveNode(e);
      Inc(CountITPO);
    end;  
  end
  else
  if ConflictAllForElements(prevovr, e, False, False) <= caNoConflict then begin
    AddMessage('Removing: ' + Name(e));
    RemoveNode(e);
    Inc(CountITPO);
  end;
end;

function Finalize: integer;
begin
  AddMessage('ITPO records removed: ' + IntToStr(CountITPO));
end;

end.