{
  Find records that should be compressed, but stored as uncompressed.
  Indicate usage of tesvsnip or other 3rd party tools that might corrupt plugins.
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

  if (GetElementNativeValues(Master(e), 'Record Header\Record Flags') and $40000 > 0) and
     (GetElementNativeValues(e, 'Record Header\Record Flags') and $40000 = 0)
  then
    AddMessage('Uncompressed record: ' + FullPath(e));
end;

end.