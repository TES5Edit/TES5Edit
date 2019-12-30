{
  Move region of worldspace by defined X,Y amount of cells.
  Content of destination cells is completely wiped before movement occures.
  Destination cells must exist in plugin, for example if cell <5,7> is moved
  by 10,10 cells, then the script will abort if cell <15,17> does not exist.
  
  What is moved:
    - landscape records
    - temporary cells references
    - persistent worldspace references belonging to moved cells; if they are referenced by
      any teleportation doors then teleport positions are also updated accordinly
  
  What is not moved:
    - CELL records themselves are not moved, only their content, however a few values
      (Editor ID, flags, water level) are copied to the destination CELL record
    - navmeshes and pathgrids, they are deleted if bRemoveNavmeshes = True
    
  Apply to plugin. All games are supported from Oblivion to Fallout 4.
}
unit WorldspaceRegionMove;

const
  // remove navmeshes, pathgrids and other records from the moved cells
  bRemoveNavmeshes = True;
  CellSize = 4096;
  sRefSignatures = 'REFR,ACHR,PGRE,PMIS,PHZD,PARW,PBAR,PBEA,PCON,PFLA';


var
  Plugin, Worldspace, Region: IInterface;
  AddCellX, AddCellY, AddPosX, AddPosY: double;
  slCells: THashedStringList;
  lstMoved: TList;


//============================================================================
// get cell record by X,Y grid coordinates from worldspace
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

//============================================================================
// get persistent cell record of a worldspace
function GetWorldspacePersistentCell(Worldspace: IInterface): IInterface;
begin
  Result := ElementByIndex(ChildGroup(Worldspace), 0);
  if Signature(Result) <> 'CELL' then
    Result := nil;
end;

//============================================================================
// remove all child records of a cell
procedure CleanCell(cell: IInterface);
var
  ChildRefs: IInterface;
  i, GroupType: integer;
begin
  for GroupType := 8 to 10 do begin
    ChildRefs := FindChildGroup(ChildGroup(cell), GroupType, cell);
    for i := Pred(ElementCount(ChildRefs)) downto 0 do
      RemoveNode(ElementByIndex(ChildRefs, i));
  end;
end;

//============================================================================
procedure CopyElement(recsrc, recdst: IInterface; elName: string);
var
  el: IInterface;
begin
  el := ElementByPath(recsrc, elName);
  if not Assigned(el) then begin
    RemoveElement(recdst, elName);
    Exit;
  end;
  if not ElementExists(recdst, elName) then
    Add(recdst, elName, True);
  ElementAssign(ElementByPath(recdst, elName), LowInteger, el, False);
end;

//============================================================================
// move the content of source cell to the destination one at <x,y>
function MoveCell(SrcCell: IInterface; x, y: integer): Boolean;
var
  DstCell, ChildRefs, r: IInterface;
  i, GroupType: integer;
begin
  Result := True;

  // skip if cell has been moved already
  if lstMoved.IndexOf(GetLoadOrderFormID(SrcCell)) <> -1 then
    Exit;

  // find destination cell record
  DstCell := GetCellFromWorldspace(Worldspace, x, y);
  if not Assigned(DstCell) then begin
    AddMessage(Format('Error: Destination cell <%d,%d> not found in %s for source cell %s', [x, y, Name(Worldspace), Name(SrcCell)]));
    Result := False;
    Exit;
  end;

  // if destination cell has to be moved too, then move it first to prevent overlapping
  if slCells.IndexOf(IntToStr(x) + ',' + IntToStr(y)) <> -1 then
    MoveCell(DstCell, x + AddCellX, y + AddCellY);

  AddMessage(Format('Moving content of %s to %s', [Name(SrcCell), Name(DstCell)]));
  
  // copy CELL record data
  CopyElement(SrcCell, DstCell, 'EDID'); // Editor ID
  RemoveElement(SrcCell, 'EDID'); // avoid id dups
  CopyElement(SrcCell, DstCell, 'DATA'); // Flags
  CopyElement(SrcCell, DstCell, 'XCLW'); // Water height
  
  // wipe out content of destination cell
  CleanCell(DstCell);

  // move and update child records
  // process CELL child groups: 8 - temporary, 9 - persistent, 10 - vwd
  for GroupType := 8 to 10 do begin
    ChildRefs := FindChildGroup(ChildGroup(SrcCell), GroupType, SrcCell);
    for i := Pred(ElementCount(ChildRefs)) downto 0 do begin
      r := ElementByIndex(ChildRefs, i);
      
      // move references to destination cell and update position
      if Pos(Signature(r), sRefSignatures) <> 0 then begin
        SetElementEditValues(r, 'Cell', Name(DstCell));
        SetElementNativeValues(r, 'DATA\Position\X', GetElementNativeValues(r, 'DATA\Position\X') + AddPosX);
        SetElementNativeValues(r, 'DATA\Position\Y', GetElementNativeValues(r, 'DATA\Position\Y') + AddPosY);
      end
      
      // move landscape data, no updates needed
      else if Signature(r) = 'LAND' then
        SetElementEditValues(r, 'Cell', Name(DstCell))
      
      // remove everything else (navmeshes, pathgrids, etc.)
      else if bRemoveNavmeshes then begin
        AddMessage(#9'Removing ' + Name(r));
        RemoveNode(r);
      end;
    end;
  end;
  
  // add to the moved list
  lstMoved.Add(GetLoadOrderFormID(SrcCell));
end;
  
//============================================================================
function Process(e: IInterface): integer;
var
  i, j, x, y: integer;
  refs, cell, entries, r, rref: IInterface;
  grid: TwbGridCell;
begin
  Result := 1;

  Plugin := GetFile(e);
  if ContainerStates(Plugin) and (1 shl csRefsBuild) = 0 then begin
    MessageDlg(Format('References are not built for "%s". Please use right click "Other\Build Reference Info" menu of %sEdit', [
      GetFileName(Plugin),
      wbAppName
    ]), mtInformation, [mbOk], 0);
    Exit;
  end;
  
  if not OptionsForm then begin
    AddMessage('Region was not selected!');
    Exit;
  end;
    
  //Exit;
  
  AddPosX := AddCellX * CellSize;
  AddPosY := AddCellY * CellSize;
  slCells := THashedStringList.Create;
  lstMoved := TList.Create;
  
  AddMessage(#13#10'*** Building list of cells to move ***');

  // list of cells referencing our region (cells to be moved)
  for i := 0 to Pred(ReferencedByCount(Region)) do begin
    cell := ReferencedByIndex(Region, i);
    if Signature(cell) <> 'CELL' then
      Continue;
    // ensure they are indeed referenced by cell's regions list and not by something else
    entries := ElementBySignature(cell, 'XCLR');
    for j := 0 to Pred(ElementCount(entries)) do
      if GetLoadOrderFormID(LinksTo(ElementByIndex(entries, j))) = GetLoadOrderFormID(Region) then begin
        slCells.AddObject(GetElementEditValues(cell, 'XCLC\X') + ',' + GetElementEditValues(cell, 'XCLC\Y'), cell);
        Break;
      end;
  end;
  AddMessage(IntToStr(slCells.Count) + ' cells found in region ' + Name(Region));

  // move cells
  AddMessage(#13#10'*** Moving cells landscape and temporary references ***');
  for i := 0 to Pred(slCells.Count) do begin
    cell := ObjectToElement(slCells.Objects[i]);
    x := GetElementNativeValues(cell, 'XCLC\X') + AddCellX;
    y := GetElementNativeValues(cell, 'XCLC\Y') + AddCellY;
    if not MoveCell(cell, x, y) then
      Exit;
  end;

  // update position of worldspace persistent refs located in moved cells
  AddMessage(#13#10'*** Moving persistent references ***');

  refs := GetWorldspacePersistentCell(Worldspace);
  refs := FindChildGroup(ChildGroup(refs), 8, refs); // get Persistent group of cell
  
  for i := 0 to Pred(ElementCount(refs)) do begin
    r := ElementByIndex(refs, i);
    // convert absolute position to X,Y cells grid coordinates
    grid := wbPositionToGridCell(GetPosition(r));
    
    // skips refs not belonging to moved cells
    if slCells.IndexOf(IntToStr(grid.X) + ',' + IntToStr(grid.Y)) = -1 then
      Continue;
      
    // update ref position
    SetElementNativeValues(r, 'DATA\Position\X', GetElementNativeValues(r, 'DATA\Position\X') + AddPosX);
    SetElementNativeValues(r, 'DATA\Position\Y', GetElementNativeValues(r, 'DATA\Position\Y') + AddPosY);
    
    // if moved persistent ref is referenced by a DOOR with teleport data then update it
    for j := 0 to Pred(ReferencedByCount(r)) do begin
      rref := ReferencedByIndex(r, j);
      
      // check DOORs only
      if Signature(BaseRecord(rref)) <> 'DOOR' then
        Continue;
      
      // update if teleport is linked to the moved persistent ref
      if GetElementEditValues(rref, 'XTEL\Door') = Name(r) then begin
        SetElementNativeValues(rref, 'XTEL\Position/Rotation\Position\X', GetElementNativeValues(rref, 'XTEL\Position/Rotation\Position\X') + AddPosX);
        SetElementNativeValues(rref, 'XTEL\Position/Rotation\Position\Y', GetElementNativeValues(rref, 'XTEL\Position/Rotation\Position\Y') + AddPosY);
        // if we removed navmeshes, then also remove navmesh ref from door
        if bRemoveNavmeshes then
          RemoveElement(rref, 'XNDP');
        AddMessage('Updated teleport position on ' + Name(rref));
      end;
    end;
  
  end;
  
  slCells.Free;
  lstMoved.Free;
end;

//============================================================================
// fill regions list when worldspace is selected
procedure WorldspaceSelect(Sender: TObject);
var
  cmbWorldspace, cmbRegion: TComboBox;
  g, e: IInterface;
  i: integer;
  sl: TStringList;
begin
  cmbWorldspace := TComboBox(Sender);
  Worldspace := ObjectToElement(cmbWorldspace.Items.Objects[cmbWorldspace.ItemIndex]);
  cmbRegion := TComboBox(TForm(cmbWorldspace.Parent).FindComponent('Region'));
  
  sl := TStringList.Create;
  g := GroupBySignature(Plugin, 'REGN');
  for i := 0 to Pred(ElementCount(g)) do begin
    e := ElementByIndex(g, i);
    if (GetElementEditValues(e, 'WNAM') = Name(Worldspace)) and ElementExists(e, 'Region Areas') then
      sl.AddObject(EditorID(e), e);
  end;
  sl.Sort;
  cmbRegion.Items.Assign(sl);
  if sl.Count <> 0 then cmbRegion.ItemIndex := 0;
  sl.Free;
end;

//============================================================================
function OptionsForm: Boolean;
var
  g, e: IInterface;
  i: integer;
  sl: TStringList;
  frm: TForm;
  btnOk, btnCancel: TButton;
  cmbWorldspace, cmbRegion: TComboBox;
  edX, edY: TEdit;
  lbl: TLabel;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Move region of worldspace';
    frm.Width := 400;
    frm.Height := 250;
    frm.Position := poMainFormCenter;
    
    cmbWorldspace := TComboBox.Create(frm); cmbWorldspace.Parent := frm;
    cmbWorldspace.Left := 12;
    cmbWorldspace.Top := 32;
    cmbWorldspace.Width := frm.Width - 40;
    cmbWorldspace.Style := csDropDownList;
    cmbWorldspace.DropDownCount := 20;
    cmbWorldspace.OnSelect := WorldspaceSelect;

    lbl := TLabel.Create(frm); lbl.Parent := frm;
    lbl.Top := cmbWorldspace.Top - 18;
    lbl.Left := cmbWorldspace.Left;
    lbl.Caption := 'Worldspace';

    sl := TStringList.Create;
    g := GroupBySignature(Plugin, 'WRLD');
    for i := 0 to Pred(ElementCount(g)) do begin
      e := ElementByIndex(g, i);
      if Signature(e) = 'WRLD' then
        sl.AddObject(EditorID(e), e);
    end;
    sl.Sort;
    cmbWorldspace.Items.Assign(sl);
    sl.Free;
    
    cmbRegion := TComboBox.Create(frm); cmbRegion.Parent := frm;
    cmbRegion.Name := 'Region';
    cmbRegion.Left := cmbWorldspace.Left;
    cmbRegion.Top := cmbWorldspace.Top + 48;
    cmbRegion.Width := cmbWorldspace.Width;
    cmbRegion.Style := csDropDownList;
    cmbRegion.DropDownCount := 20;
    
    lbl := TLabel.Create(frm); lbl.Parent := frm;
    lbl.Top := cmbRegion.Top - 18;
    lbl.Left := cmbRegion.Left;
    lbl.Caption := 'Region';
    
    edX := TEdit.Create(frm); edX.Parent := frm;
    edX.Left := cmbWorldspace.Left;
    edX.Top := cmbRegion.Top + 48;
    edX.Width := 30;
    edX.Text := '1';
    
    edY := TEdit.Create(frm); edY.Parent := frm;
    edY.Left := edX.Left + edX.Width + 8;
    edY.Top := edX.Top;
    edY.Width := edX.Width;
    edY.Text := '-2';

    lbl := TLabel.Create(frm); lbl.Parent := frm;
    lbl.Top := edX.Top - 18;
    lbl.Left := edX.Left;
    lbl.Caption := 'Move by (X,Y) cells';

    btnOk := TButton.Create(frm); btnOk.Parent := frm;
    btnOk.Top := frm.Height - 70;
    btnOk.Left := frm.Width - 220;
    btnOk.Width := 90;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;

    btnCancel := TButton.Create(frm); btnCancel.Parent := frm;
    btnCancel.Top := frm.Height - 70;
    btnCancel.Left := frm.Width - 120;
    btnCancel.Width := 90;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    
    if cmbWorldspace.Items.Count <> 0 then begin
      cmbWorldspace.ItemIndex := 0;
      WorldspaceSelect(cmbWorldspace);
    end;

    if frm.ShowModal <> mrOk then
      Exit;
      
    if cmbRegion.ItemIndex = -1 then
      Exit;
  
    Region := ObjectToElement(cmbRegion.Items.Objects[cmbRegion.ItemIndex]);
    AddCellX := StrToInt(edX.Text);
    AddCellY := StrToInt(edY.Text);
    Result := True;
    
  finally
    frm.Free;
  end;
end;


end.
