{
  有时候 Mod 是针对其他语言或者作者不小心修改了使用其他语言保存了记录。
  此脚本用来复制 Master 相应子记录的 FULL 和 DESC 以恢复到原来的形式。
}
unit UserScript;

function Process(e: IInterface): integer;
var
  m: IInterface;
begin
  if not ElementExists(e, 'FULL') and not ElementExists(e, 'DESC') then
    Exit;

  // get master record
  m := Master(e);
  
  // no master - nothing to restore
  if not Assigned(m) then
    Exit;
  
  // if record overrides several masters, then get the last one
  if OverrideCount(m) > 1 then
    m := OverrideByIndex(m, OverrideCount(m) - 2);

  if not SameText(GetElementEditValues(e, 'FULL'), GetElementEditValues(m, 'FULL')) then
    SetElementEditValues(e, 'FULL', GetElementEditValues(m, 'FULL'));
  if not SameText(GetElementEditValues(e, 'DESC'), GetElementEditValues(m, 'DESC')) then
    SetElementEditValues(e, 'DESC', GetElementEditValues(m, 'DESC'));
end;

end.