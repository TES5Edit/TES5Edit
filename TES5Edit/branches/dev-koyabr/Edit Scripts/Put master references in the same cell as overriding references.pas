{
  Put master references in the same cell as overriding references.
  Must be applied to overriding references, not to master!
  To correct cell placements after merging with FNVPlugin.
}
unit UserScript;

function Process(e: IInterface): integer;
var
  s: string;
  m: IInterface;
begin
  s := Signature(e);
  if (s <> 'REFR') and (s <> 'ACHR') and (s <> 'ACRE') and (s <> 'PGRE') and (s <> 'PMIS') and (s <> 'PHZD') then
    Exit;
  
  m := Master(e);
  if not Assigned(m) then
    Exit;
  
  if GetElementEditValues(m, 'Cell') <> GetElementEditValues(e, 'Cell') then
    SetElementNativeValues(m, 'Cell', GetElementNativeValues(e, 'Cell'));
end;

end.
