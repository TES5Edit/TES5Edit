{
  Crop worldspace by removing cells and child references
}
unit userscript;

const
  NWCellX = -64;
  NWCellY = 64;
  SECellX = 63;
  SECellY = -63;
  CellSize = 4096;

function Process(e: IInterface): integer;
var
  Sig: string;
  x, y: integer;
begin
  Sig := Signature(e);
  
  // remove out of bounds cells, skip 0,0 persistent cell
  if (Sig = 'CELL') and not GetIsPersistent(e) then begin
    x := GetElementNativeValues(e, 'XCLC\X');
    y := GetElementNativeValues(e, 'XCLC\Y');
    if (x < NWCellX) or (x > SECellX) or (y > NWCellY) or (y < SECellY) then
      RemoveNode(e);
  end else

  // remove out of bounds references
  if (Sig = 'REFR') or (Sig = 'PGRE') or (Sig = 'PMIS') or (Sig = 'ACHR') or (Sig = 'ACRE') or
     (Sig = 'PARW') or (Sig = 'PBAR') or (Sig = 'PBEA') or (Sig = 'PCON') or (Sig = 'PFLA') or
     (Sig = 'PHZD')
  then begin
    x := GetElementNativeValues(e, 'DATA\Position\X');
    y := GetElementNativeValues(e, 'DATA\Position\Y');
    if (x < NWCellX*CellSize) or (x > SECellX*CellSize) or (y > NWCellY*CellSize) or (y < SECellY*CellSize) then
      RemoveNode(e);
  end;
end;

end.