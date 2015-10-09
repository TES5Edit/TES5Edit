{

  MASTERFILE: Reference attached to wrong cell for its location:
  'Wilderness' (01006609) (27, -8) in WorldSpace 'MyWorld' (01000819)
}
unit FixWorldspaceRefsCells;

function GetCellFromWorldspace(Worldspace: IInterface; GridX, GridY: integer): IInterface;
var
  blockidx, subblockidx, cellidx: integer;
  wrldgrup, block, subblock, cell: IInterface;
  Grid, GridBlock, GridSubBlock: TwbGridCell;
  LabelBlock, LabelSubBlock: Cardinal;
begin
  Grid := wbGridCell(GridX, GridY);
  GridSubBlock := wbSubBlockFromGridCell(Grid);
  LabelSubBlock := wbGridCellToGroupLabel(GridSubBlock);
  GridBlock := wbBlockFromSubBlock(GridSubBlock);
  LabelBlock := wbGridCellToGroupLabel(GridBlock);

  wrldgrup := ChildGroup(Worldspace);
  // iterate over Exterior Blocks
  for blockidx := 0 to Pred(ElementCount(wrldgrup)) do begin
    block := ElementByIndex(wrldgrup, blockidx);
    if GroupLabel(block) <> LabelBlock then Continue;
    // iterate over SubBlocks
    for subblockidx := 0 to Pred(ElementCount(block)) do begin
      subblock := ElementByIndex(block, subblockidx);
      if GroupLabel(subblock) <> LabelSubBlock then Continue;
      // iterate over Cells
      for cellidx := 0 to Pred(ElementCount(subblock)) do begin
        cell := ElementByIndex(subblock, cellidx);
        if (Signature(cell) <> 'CELL') or GetIsPersistent(cell) then Continue;
        if (GetElementNativeValues(cell, 'XCLC\X') = Grid.x) and (GetElementNativeValues(cell, 'XCLC\Y') = Grid.y) then begin
          Result := cell;
          Exit;
        end;
      end;
      Break;
    end;
    Break;
  end;
end;

function Process(e: IInterface): integer;
var
  cell: IInterface;
  c: TwbGridCell;
begin
  // process only references
  if Pos(Signature(e), 'REFR ACHR ACRE PHZD PGRE PMIS PARW PBAR PBEA PCON PFLA') = 0 then
    Exit;
  
  // skip persistent references since they are always in <0, 0> cell
  if GetIsPersistent(e) then
    Exit;

  // check that reference is in the right cell
  cell := LinksTo(ElementByName(e, 'Cell'));
  if wbIsInGridCell(GetPosition(e), GetGridCell(cell)) then
    Exit;
  
  // grid coordinates for the proper cell
  c := wbPositionToGridCell(GetPosition(e));
  AddMessage(Format('%s must be in <%d, %d>', [Name(e), c.x, c.y]));
  
  // get the proper cell for a reference
  cell := GetCellFromWorldSpace(LinksTo(ElementByName(cell, 'Worldspace')), c.x, c.y);
  if not Assigned(cell) then begin
    AddMessage('Can not find the new cell for reference, skipping.');
    Exit;
  end;
  
  // move reference to the new cell
  AddMessage('--> moving to ' + Name(cell));
  SetElementEditValues(e, 'Cell', Name(cell));
end;

end.
