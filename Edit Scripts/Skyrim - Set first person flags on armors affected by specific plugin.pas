{
  Set body flags in armor record if it was altered in specific plugin.
}

unit userscript;

function Process(e: IInterface): Integer;
var
  i: integer;
  m: IInterface;
begin
  if Signature(e) <> 'ARMO' then Exit;
  m := Master(e);
  for i := 0 to OverrideCount(m) - 1 do
    if SameText(GetFileName(OverrideByIndex(m, i)), 'Dragonborn.esm') then
      SetElementNativeValues(e, 'BOD2\First Person Flags', GetElementNativeValues(e, 'BOD2\First Person Flags') or $00400000);
end;

end.