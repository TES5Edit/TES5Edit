{
  Script to copy only book's content from the last overridden record.
  Other fields are unchanged.
}
unit UserScript;

function Process(e: IInterface): integer;
var
  m: IInterface;
begin
  if Signature(e) <> 'BOOK' then Exit;
  m := Master(e);
  if not Assigned(m) then Exit;
  // if record overrides several masters, then get the last one
  if OverrideCount(m) > 1 then
	m := OverrideByIndex(m, OverrideCount(m) - 2);
  SetElementEditValues(e, 'DESC', GetElementEditValues(m, 'DESC'));
end;

end.
