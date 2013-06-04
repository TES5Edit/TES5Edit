{
  放置 Master 衍生到相同场景，作为覆盖衍生。
  必须应用到要覆盖的衍生，而不是 Master ！
  整合万 FNV 插件后，用来修正场景放置。
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
