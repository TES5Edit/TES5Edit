{
  Add shadow bias to light references to avoid shadow striping.
}
unit ShadowBias;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'REFR' then
    Exit;
    
  if Signature(LinksTo(ElementBySignature(e, 'NAME'))) <> 'LIGH' then
    Exit;

  Add(e, 'XLIG', True);
  if (GetElementNativeValues(e, 'XLIG\Shadow Depth Bias') = 0) or
     (GetElementNativeValues(e, 'XLIG\Shadow Depth Bias') = 1)
  then
    SetElementNativeValues(e, 'XLIG\Shadow Depth Bias', 23.76);
end;

end.
