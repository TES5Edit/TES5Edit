{
  设置 HavokDontSettle 标志 到 BOOK 记录的衍生
}
unit UserScript;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'REFR' then
    Exit;
  
  if Signature(LinksTo(ElementBySignature(e, 'NAME'))) <> 'BOOK' then
    Exit;
  
  SetElementNativeValues(e, '记录头\记录标志', GetElementNativeValues(e, '记录头\记录标志') or $20000000);
end;

end.
