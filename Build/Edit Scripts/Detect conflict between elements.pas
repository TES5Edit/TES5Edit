{
  Demo script on how to detect a conflict between elements in master record and override.
  Apply to overriding record(s).
}
unit DetectConflict;

var
  caName: array [0..6] of string;
  
function Initialize: integer;
begin
  // Conflict names and their background colors when viewed in xEdit

  // conflict status not initialized
  caName[caUnknown]          := 'Unknown';

  // only 1 elements in comparison, usually a master record without overrides (white)
  caName[caOnlyOne]          := 'OnlyOne';

  // same data, identical to master ITM (green)
  caName[caNoConflict]       := 'NoConflict';

  // data differs, but the changes don't affect the game so treated as ITM too (yellow)
  caName[caConflictBenign]   := 'ConflictBenign';

  // different data, basically what mods do (yellow)
  caName[caOverride]         := 'Override';

  // changed data is changed by later loading mods (red)
  caName[caConflict]         := 'Conflict';

  // changed critical game data is changed by later loading mods (fuchsia)
  caName[caConflictCritical] := 'ConflictCritical';
end;

function Process(e: IInterface): integer;
var
  m, e1, e2: IInterface;
  i, c: integer;
  s: string;
begin
  m := Master(e);
  
  // This is not an override
  if not Assigned(m) then
    Exit;
  
  // Skip ITM records
  // Can be replaced with ConflictAllForNode() for a big speed improvement
  // if user applies "Filter for cleaning" before executing this script, check "Conflict status.pas" script
  if ConflictAllForMainRecord(e) < caOverride then
    Exit;
  
  AddMessage('Conflicts with master for ' + Name(e));
  for i := 0 to Pred(ElementCount(e)) do begin
    e2 := ElementByIndex(e, i);
    s := Name(e2);
    e1 := ElementByName(m, s);
    if not Assigned(e1) then
      AddMessage(Format(#9'%s is new', [s]))
    else begin
      // if called with 4 parameters, then the first and second ones are elements to compare
      // if called with 3 parameters, then the first one is TList containing elements to compare
      // this demo will never return caConflict or caConflictCritical because that requires at least 3 elements to compare
      // only 2 given here
      c := ConflictAllForElements(e1, e2, False, IsInjected(m));
      // show only benign conflicts and overrides
      if c >= caConflictBenign then
        AddMessage(Format(#9'%s [%s]', [s, caName[c]]));
    end;
  end;
end;


end.
