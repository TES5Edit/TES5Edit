{
  Add shadow bias to light references to avoid shadow striping.
}
unit ShadowBias;

function RefusedForMorrowind: Boolean;
begin
  Result := wbGameMode = gmTES3;
  if Result then
    AddMessage('This script does not work for Morrowind: its references have no XLIG');
end;

function Initialize: integer;
begin
  if RefusedForMorrowind then begin
    Result := 1;
    Exit;
  end;
  Result := 0;
end;

function Process(e: IInterface): integer;
begin
  if RefusedForMorrowind then begin
    Result := 1;
    Exit;
  end;

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
