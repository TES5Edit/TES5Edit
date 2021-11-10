{
  Adjust the height of cells of a region.
  
  What is adjusted:
    - landscape records
    - temporary cells references
    - persistent worldspace references belonging to region cells; if they are referenced by
      any teleportation doors then teleport positions are also updated accordinly
    - water height in cells
  
  What is not adjusted:
    - navmeshes and pathgrids, they are deleted if bRemoveNavmeshes = True
    
  Apply to plugin. All games are supported from Oblivion to Fallout 4.
}
unit WorldspaceRegionChangeHeight;

const
  // remove navmeshes, pathgrids and other records from the moved cells
  bRemoveNavmeshes = True;
  CellSize = 4096;
  sRefSignatures = 'REFR,ACHR,PGRE,PMIS,PHZD,PARW,PBAR,PBEA,PCON,PFLA';


var
  Plugin, Worldspace, Region: IInterface;
  AddPosZ: Double;
  slCells: THashedStringList;


//============================================================================
// get persistent cell record of a worldspace
function GetWorldspacePersistentCell(Worldspace: IInterface): IInterface;
begin
  Result := ElementByIndex(ChildGroup(Worldspace), 0);
  if Signature(Result) <> 'CELL' then
    Result := nil;
end;

//============================================================================
// adjust the height of a cell including it's children records
function AdjustCellHeight(cell: IInterface; h: Double): Boolean;
var
  ChildRefs, r: IInterface;
  i, GroupType: integer;
begin
  Result := True;

  AddMessage(Format('Updating cell %s', [Name(cell)]));
  
  // update CELL water height
  if ElementExists(cell, 'XCLW') then
    if GetElementEditValues(cell, 'XCLW') <> 'Default' then
      SetElementNativeValues(cell, 'XCLW', GetElementNativeValues(cell, 'XCLW') + h);

  // update CELL max height data offset
  if ElementExists(cell, 'MHDT') then
    SetElementNativeValues(cell, 'MHDT\Offset', GetElementNativeValues(cell, 'MHDT\Offset') + h);
  
  // adjust child records
  // process CELL child groups: 8 - temporary, 9 - persistent, 10 - vwd
  for GroupType := 8 to 10 do begin
    ChildRefs := FindChildGroup(ChildGroup(cell), GroupType, cell);
    for i := Pred(ElementCount(ChildRefs)) downto 0 do begin
      r := ElementByIndex(ChildRefs, i);
      
      // update references position
      if Pos(Signature(r), sRefSignatures) <> 0 then
        SetElementNativeValues(r, 'DATA\Position\Z', GetElementNativeValues(r, 'DATA\Position\X') + h)
      
      // update the offset height of landscape
      else if Signature(r) = 'LAND' then
        SetElementNativeValues(r, 'VHGT\Offset', GetElementNativeValues(r, 'VHGT\Offset') + h/8)
      
      // remove everything else (navmeshes, pathgrids, etc.)
      else if bRemoveNavmeshes then begin
        AddMessage(#9'Removing ' + Name(r));
        RemoveNode(r);
      end;
    end;
  end;
end;
  
//============================================================================
function Process(e: IInterface): integer;
var
  i, j, x, y: integer;
  refs, cell, entries, r, rref: IInterface;
  grid: TwbGridCell;
begin
  Result := 1;

  if wbSimpleRecords then begin
    MessageDlg('Uncheck "Simple records" in xEdit options and restart', mtInformation, [mbOk], 0);
    Result := 1;
    Exit;
  end;
  
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
  
  slCells := THashedStringList.Create;
  
  AddMessage(#13#10'*** Building list of cells to adjust ***');

  // list of cells referencing our region (cells to be adjusted)
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

  // adjust cells
  AddMessage(#13#10'*** Adjust cells landscape and temporary references ***');
  for i := 0 to Pred(slCells.Count) do begin
    cell := ObjectToElement(slCells.Objects[i]);
    if not AdjustCellHeight(cell, AddPosZ) then
      Exit;
  end;

  // update position of worldspace persistent refs located in region cells
  AddMessage(#13#10'*** Adjusting persistent references ***');

  refs := GetWorldspacePersistentCell(Worldspace);
  refs := FindChildGroup(ChildGroup(refs), 8, refs); // get Persistent group of cell
  
  for i := 0 to Pred(ElementCount(refs)) do begin
    r := ElementByIndex(refs, i);
    // convert absolute position to X,Y cells grid coordinates
    grid := wbPositionToGridCell(GetPosition(r));
    
    // skips refs not belonging to region cells
    if slCells.IndexOf(IntToStr(grid.X) + ',' + IntToStr(grid.Y)) = -1 then
      Continue;
      
    // update ref position
    SetElementNativeValues(r, 'DATA\Position\Z', GetElementNativeValues(r, 'DATA\Position\Z') + AddPosZ);
    
    // if moved persistent ref is referenced by a DOOR with teleport data then update it
    for j := 0 to Pred(ReferencedByCount(r)) do begin
      rref := ReferencedByIndex(r, j);
      
      // check DOORs only
      if Signature(BaseRecord(rref)) <> 'DOOR' then
        Continue;
      
      // update if teleport is linked to the moved persistent ref
      if GetElementEditValues(rref, 'XTEL\Door') = Name(r) then begin
        SetElementNativeValues(rref, 'XTEL\Position/Rotation\Position\Z', GetElementNativeValues(rref, 'XTEL\Position/Rotation\Position\X') + AddPosZ);
        // if we removed navmeshes, then also remove navmesh ref from door
        if bRemoveNavmeshes then
          RemoveElement(rref, 'XNDP');
        AddMessage('Updated teleport position on ' + Name(rref));
      end;
    end;
  
  end;
  
  slCells.Free;
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
  edZ: TEdit;
  lbl: TLabel;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Adjust the height of worldspace region';
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
    
    edZ := TEdit.Create(frm); edZ.Parent := frm;
    edZ.Left := cmbWorldspace.Left;
    edZ.Top := cmbRegion.Top + 48;
    edZ.Width := 60;
    edZ.Text := '32';
    
    lbl := TLabel.Create(frm); lbl.Parent := frm;
    lbl.Top := edZ.Top - 18;
    lbl.Left := edZ.Left;
    lbl.Caption := 'Height adjustment (positive or negative, divisible by 8)';

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
    AddPosZ := StrToInt(edZ.Text);
    
    if AddPosZ mod 8 <> 0 then
      AddMessage('Height is not divisible by 8 !!!')
    else
      Result := True;
    
  finally
    frm.Free;
  end;
end;


end.
