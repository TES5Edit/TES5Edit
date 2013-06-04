{
  从 sound descriptors 移除频差。
}
unit UserScript;

function Process(e: IInterface): integer;
begin
  SetElementEditValues(e, 'BNAM\% 频差', '0');
end;

end.
