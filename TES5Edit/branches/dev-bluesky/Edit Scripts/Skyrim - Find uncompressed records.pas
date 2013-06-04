{
  查找应该压缩但是没有压缩的记录。
  用来检测 tesvsnip 或者其他第三方工具是否损坏插件。
}
unit userscript;

function Process(e: IInterface): integer;
var
  s: string;
begin
  if IsMaster(e) then
    Exit;

  s := Signature(e);
  if (s <> 'CELL') and (s <> 'LAND') and (s <> 'NAVM') and (s <> 'NPC_') then
    Exit;

  if (GetElementNativeValues(Master(e), '记录头\记录标志') and $40000 > 0) and
     (GetElementNativeValues(e, '记录头\记录标志') and $40000 = 0)
  then
    AddMessage('未压缩的数据：' + FullPath(e));
end;

end.