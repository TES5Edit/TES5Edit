{
  Set 'default' water level (means that game will use water level from worldspace WRLD record)
  in exterior CELL records with "Has Water" flag.
}
unit userscript;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'CELL' then
    Exit;
  
  // $01 IsInterior + $02 HasWater = $03
  if GetElementNativeValues(e, 'DATA') and $03 = 2 then
    SetElementEditValues(e, 'XCLW', 'Default') ;
end;

end.