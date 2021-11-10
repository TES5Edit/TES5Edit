{
  Copy XPRI subrecord (attached papyrus scripts data) to selected record(s)
  from provided source record.
}
unit UserScript;

function Process(e: IInterface): Integer;
var
  m: IInterface;
begin
  if Signature(e) <> 'CELL' then
    Exit;
  
  m := MasterOrSelf(e);
  
  if Equals(e, m) then
    Exit;
  
  if not ElementExists(m, 'XPRI') then
    Exit;
  
  Add(e, 'XPRI', True);
  ElementAssign(ElementByPath(e, 'XPRI'), LowInteger, ElementByPath(m, 'XPRI'), False);
end;

end.
