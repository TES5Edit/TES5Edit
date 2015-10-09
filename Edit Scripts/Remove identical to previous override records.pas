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
  // skip master records
  if IsMaster(e) then
    Exit;
    
  // skip records that have elements in child group (WRLD, CELL, DIAL)
  if ElementCount(ChildGroup(e)) <> 0 then
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