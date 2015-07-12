{
  Changes height of exterior worldspace cells in specified range, both references and landscape.
  Water level, WRLD properties, navmeshes and doors teleport coordinates are not affected! Tweak manually.
  Works for all games, apply to worldspace in xEdit.
  ShiftZ must be divisible by 8
  Min/Max constants set the range of cells to update
}
unit WorldspaceChangeHeight;

const
  ShiftZ = 888;
  MinX = -10;
  MinY = -10;
  MaxX = 10;
  MaxY = 10;
  CellSize = 4096;
  sRefSignatures = 'REFR,ACHR,PGRE,PMIS,PHZD,PARW,PBAR,PBEA,PCON,PFLA';
 
//===========================================================================
function Initialize: integer;
begin
  if wbSimpleRecords then begin
    MessageDlg('Simple records must be unchecked in xEdit options', mtInformation, [mbOk], 0);
    Result := 1;
    Exit;
  end;
end;

//===========================================================================
function Process(e: IInterface): integer;
var
  Sig: string;
  cell: IInterface;
begin
  Sig := Signature(e);

  if Sig = 'LAND' then begin
    cell := LinksTo(ElementByName(e, 'Cell'));
    if not Assigned(cell) then
      Exit;
    if (GetElementNativeValues(cell, 'XCLC\X') >= MinX) and
       (GetElementNativeValues(cell, 'XCLC\X') <= MaxX) and
       (GetElementNativeValues(cell, 'XCLC\Y') >= MinY) and
       (GetElementNativeValues(cell, 'XCLC\Y') <= MaxY)
    then
      SetElementNativeValues(e, 'VHGT\Offset', GetElementNativeValues(e, 'VHGT\Offset') + ShiftZ/8);
  end
  // update position of reference records
  else if Pos(Sig, sRefSignatures) <> 0 then begin
    if (GetElementNativeValues(e, 'DATA\Position\X')/CellSize >= MinX) and
       (GetElementNativeValues(e, 'DATA\Position\X')/CellSize <= MaxX) and
       (GetElementNativeValues(e, 'DATA\Position\Y')/CellSize >= MinY) and
       (GetElementNativeValues(e, 'DATA\Position\Y')/CellSize <= MaxY)
    then
      SetElementNativeValues(e, 'DATA\Position\Z', GetElementNativeValues(e, 'DATA\Position\Z') + ShiftZ);
  end;
end;

end.