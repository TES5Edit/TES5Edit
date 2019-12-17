{
  Replace a LTEX texture in LAND record
}
unit ReplaceLtex;

const
  sReplaceWhat = 'LFieldGrass01 [LTEX:00013428]'; // replace what LTEX record
  sReplaceWith = 'LFieldGrass01NoGrass [LTEX:00024E46]'; // replace with LTEX record

function Process(e: IInterface): integer;
var
  i: integer;
  layers, tex: IInterface;
begin
  if Signature(e) <> 'LAND' then
    Exit;
  
  layers := ElementByName(e, 'Layers');
  for i := 0 to ElementCount(layers) - 1 do begin
    tex := ElementByIndex(ElementByIndex(ElementByIndex(layers, i), 0), 0);
    if SameText(GetEditValue(tex), sReplaceWhat) then
      SetEditValue(tex, sReplaceWith);
  end;
end;

end.
