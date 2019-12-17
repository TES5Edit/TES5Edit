{
  Move selected temporary references into another worldspace with provided offset values
  Optionally copy and move persistent references that belong to the selected cells by coordinates
  "only this plugin" option controls which persistent references to move
    - unchecked: refs in master file will be processed, copied as override into this plugin and then moved
    - checked: only already copied refs in this plugin will be moved
  Optionally updated teleport coordinates on doors leading to the moved markers
  
  The plugin that the script is applied to must be the last one loaded in xEdit
  Supports all games (Oblivion, Fallout 3, New Vegas, Skyrim, Fallout 4)
  
  Usage:
  Copy as override temporary cells/refs you want to move (optionally copy persistent refs), apply script to them, set parameters
  After script finished working, don't browse any nodes but immediately exit xEdit and save changes, then reload and check results
}
unit MoveWorldspaceRefs;

const
  sRefSignatures = 'REFR,ACHR,ACRE,PGRE,PMIS,PHZD,PARW,PBAR,PBEA,PCON,PFLA';

var
  DestWorld, SrcPCell, DestPCell, PRefs: IInterface;
  fOffsetX, fOffsetY, fOffsetZ: Double;
  bMovePersistent, bPersistentThisFileOnly, bInitSource, bUpdateDoors: Boolean;
  frm: TForm;
  lbl: TLabel;
  cmbWorldspace: TComboBox;
  edX, edY, edZ: TEdit;
  chkPersistent, chkThisFile, chkDoors: TCheckBox;
  btnOk, btnCancel: TButton;
  
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
// get persistent cell record from worldspace
function GetPersistentCellFromWorldspace(Worldspace: IInterface): IInterface;
begin
  Result := ElementByIndex(ChildGroup(Worldspace), 0);
  if Signature(Result) <> 'CELL' then
    Result := nil;
end;

//===========================================================================
function IsReference(aRecord: IInterface): Boolean;
begin
  Result := Pos(Signature(aRecord), sRefSignatures) <> 0;
end;

//===========================================================================
procedure UpdateRefPosition(aRef: IInterface; aPath: string);
var
  x, y, z: Single;
begin
  // calculate and update new position
  x := GetElementNativeValues(aRef, aPath + 'X') + fOffsetX;
  y := GetElementNativeValues(aRef, aPath + 'Y') + fOffsetY;
  z := GetElementNativeValues(aRef, aPath + 'Z') + fOffsetZ;
  SetElementNativeValues(aRef, aPath + 'X', x);
  SetElementNativeValues(aRef, aPath + 'Y', y);
  SetElementNativeValues(aRef, aPath + 'Z', z);
end;

//===========================================================================
procedure MoveReference(aRef: IInterface);
var
  cell: IInterface;
  c: TwbGridCell;
begin
  UpdateRefPosition(aRef, 'DATA\Position\');
  // find destination cell coordinates
  c := wbPositionToGridCell(GetPosition(aRef));
  // get cell from the current plugin
  cell := GetCellFromWorldspace(WinningOverride(DestWorld), c.X, c.Y);
  // if not found, try to get from master file
  if not Assigned(cell) then
    cell := GetCellFromWorldspace(DestWorld, c.X, c.Y);
  if not Assigned(cell) then
    raise Exception.Create('Can not find destination cell ' + IntToStr(c.X) + ',' + IntToStr(c.Y));
  
  // if cell is not in our plugin yet, then copy as override
  if not Equals(GetFile(cell), GetFile(aRef)) then begin
    AddRequiredElementMasters(cell, GetFile(aRef), False);
    cell := wbCopyElementToFile(cell, GetFile(aRef), False, True);
  end;
  
  // move reference
  SetElementEditValues(aRef, 'Cell', Name(cell));
end;

//============================================================================
procedure chkPersistentClick(Sender: TObject);
begin
  chkThisFile.Enabled := TCheckBox(Sender).Checked;
  chkDoors.Enabled := TCheckBox(Sender).Checked;
end;

//===========================================================================
function Initialize: integer;
var
  sl: TStringList;
  i, j: integer;
  wrlds, wrld: IInterface;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Move references';
    frm.Width := 400;
    frm.Height := 200;
    frm.Position := poMainFormCenter;
    frm.BorderStyle := bsDialog;

    lbl := TLabel.Create(frm); lbl.Parent := frm;
    lbl.Left := 12;
    lbl.Top := 12;
    lbl.Width := 100;
    lbl.Caption := 'Destination worldspace';
    
    cmbWorldspace := TComboBox.Create(frm); cmbWorldspace.Parent := frm;
    cmbWorldspace.Left := 12;
    cmbWorldspace.Top := 28;
    cmbWorldspace.Width := frm.Width - 36;
    cmbWorldspace.Style := csDropDownList; cmbWorldspace.DropDownCount := 20;

    sl := TStringList.Create;
    try
      sl.Duplicates := dupIgnore;
      sl.Sorted := True;
      for i := Pred(FileCount) downto 0 do begin
        wrlds := GroupBySignature(FileByIndex(i), 'WRLD');
        for j := 0 to Pred(ElementCount(wrlds)) do begin
          wrld := ElementByIndex(wrlds, j);
          if Signature(wrld) = 'WRLD' then
            sl.AddObject(EditorID(wrld), MasterOrSelf(wrld));
        end;
      end;
      cmbWorldspace.Items.Assign(sl);
    finally
      sl.Free;
    end;

    chkPersistent := TCheckBox.Create(frm); chkPersistent.Parent := frm;
    chkPersistent.Left := 12; chkPersistent.Top := 54;
    chkPersistent.Width := 150;
    chkPersistent.Caption := 'Move persistent references';
    chkPersistent.OnClick := chkPersistentClick;
    
    chkThisFile := TCheckBox.Create(frm); chkThisFile.Parent := frm;
    chkThisFile.Left := 170; chkThisFile.Top := 54;
    chkThisFile.Width := 156;
    chkThisFile.Caption := 'only from the current plugin';
    chkThisFile.Hint := 'Persistent references won''t be copied from the master file of source worldspace, but only existing ones in this plugin will be moved';
    chkThisFile.ShowHint := True;
    chkThisFile.Enabled := False;

    chkDoors := TCheckBox.Create(frm); chkDoors.Parent := frm;
    chkDoors.Left := 170; chkDoors.Top := 70;
    chkDoors.Width := 156;
    chkDoors.Caption := 'update doors teleport data';
    chkDoors.Hint := 'If the moved persistent reference is a door and destination door ref links to it, then offset teleport data';
    chkDoors.ShowHint := True;
    chkDoors.Enabled := False;

    lbl := TLabel.Create(frm); lbl.Parent := frm;
    lbl.Left := 12; lbl.Top := 82;
    lbl.Width := 100;
    lbl.Caption := 'Offset X,Y,Z';
    
    edX := TEdit.Create(frm); edX.Parent := frm;
    edX.Left := 12; edX.Top := 98; edX.Width := 80;
    edY := TEdit.Create(frm); edY.Parent := frm;
    edY.Left := edX.Left + 100; edY.Top := 98; edY.Width := 80;
    edZ := TEdit.Create(frm); edZ.Parent := frm;
    edZ.Left := edY.Left + 100; edZ.Top := 98; edZ.Width := 80;

    btnOk := TButton.Create(frm); btnOk.Parent := frm;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;
    btnOk.Left := frm.Width - 176;
    btnOk.Top := frm.Height - 62;
    btnOk.TabOrder := 0;
    
    btnCancel := TButton.Create(frm); btnCancel.Parent := frm;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := btnOk.Left + btnOk.Width + 8;
    btnCancel.Top := btnOk.Top;

    if (frm.ShowModal <> mrOk) or (cmbWorldspace.ItemIndex = -1) then begin
      Result := 1;
      Exit;
    end;

    DestWorld := ObjectToElement(cmbWorldspace.Items.Objects[cmbWorldspace.ItemIndex]);
    bMovePersistent := chkPersistent.Checked;
    bPersistentThisFileOnly := chkThisFile.Checked;
    bUpdateDoors := chkDoors.Checked;
    if edX.Text = '' then edX.Text := '0'; fOffsetX := FloatToStr(edX.Text);
    if edY.Text = '' then edY.Text := '0'; fOffsetY := FloatToStr(edY.Text);
    if edZ.Text = '' then edZ.Text := '0'; fOffsetZ := FloatToStr(edZ.Text);
    
  finally
    frm.Free;
  end;
end;

//===========================================================================
function Process(e: IInterface): integer;
var
  i, cellx, celly: integer;
  c: TwbGridCell;
  w, ref, doorref: IInterface;
begin
  if GetIsDeleted(e) or not IsEditable(e) then
    Exit;
  
  if IsReference(e) then begin
    if not GetIsPersistent(e) then
      MoveReference(e);
  end
  // moving persistent refs for a cell
  else if bMovePersistent and (Signature(e) = 'CELL') then begin
    // get persistent cell of source worldspace and it's persistent child group
    if not bInitSource then begin
      w := LinksTo(ElementByName(e, 'Worldspace'));
      // what persistent refs to scan - in this plugin or in master file of worldspace
      if not bPersistentThisFileOnly then
        w := MasterOrSelf(w);
      SrcPCell := GetPersistentCellFromWorldspace(w);
      if Assigned(SrcPCell) then
        PRefs := FindChildGroup(ChildGroup(SrcPCell), 8, SrcPCell);
      bInitSource := True;
    end;

    // nothing to move
    if not Assigned(PRefs) then
      Exit;

    cellx := GetElementNativeValues(e, 'XCLC\X');
    celly := GetElementNativeValues(e, 'XCLC\Y');

    // iterate over all persistent refs of worldspace and check if they belong to the current cell by coordinates
    // in reverse order since elements count might change
    for i := Pred(ElementCount(PRefs)) downto 0 do begin
      ref := WinningOverride(ElementByIndex(PRefs, i));
      c := wbPositionToGridCell(GetPosition(ref));
      // not in our cell
      if (c.X <> cellx) or (c.Y <> celly) then
        Continue;

      // if destination persistent cell is unknown, then locate it first
      if not Assigned(DestPCell) then begin
        DestPCell := WinningOverride(GetPersistentCellFromWorldspace(DestWorld));
        if not Assigned(DestPCell) then
          raise Exception.Create('Can not find destination persistent cell for worldspace ' + Name(DestWorld));
        
        // if destination persistent cell is not in our plugin yet, then copy it as override
        if not Equals(GetFile(DestPCell), GetFile(e)) then begin
          AddRequiredElementMasters(DestPCell, GetFile(e), False);
          DestPCell := wbCopyElementToFile(DestPCell, GetFile(e), False, True);
        end;
      end;

      // if persistent ref is not in our plugin, then copy it as override
      if not Equals(GetFile(ref), GetFile(e)) then begin
        AddRequiredElementMasters(ref, GetFile(e), False);
        ref := wbCopyElementToFile(ref, GetFile(e), False, True);
      end;

      // calculate and update new position
      UpdateRefPosition(ref, 'DATA\Position\');

      // move persistent reference
      SetElementEditValues(ref, 'Cell', Name(DestPCell));
      
      // update teleport coordinates leading to the moved persistent ref
      if bUpdateDoors and ElementExists(ref, 'XTEL') then begin
        // getting the door reference
        doorref := WinningOverride(LinksTo(ElementByPath(ref, 'XTEL\Door')));
        // no valid door ref or no teleport data, then skip
        if not Assigned(doorref) then Continue;
        if not ElementExists(doorref, 'XTEL') then Continue;
        // copy it to plugin and update teleport position
        if not Equals(GetFile(doorref), GetFile(e)) then begin
          AddRequiredElementMasters(doorref, GetFile(e), False);
          doorref := wbCopyElementToFile(doorref, GetFile(e), False, True);
          UpdateRefPosition(doorref, 'XTEL\Position/Rotation\Position\');
        end;
      end;
    
    end;
  end;
end;

end.
