{
  Copy landscape data between worldspaces matching cells by grid X,Y coordinates.
  Worldspaces can be from different plugins and with different masters or none at all.
  Designed to be used in conjunction with TESAnnwyn to import back modified
  landscape data into existing mods. For example you exported heightmap or vertex colors with
  TESAnnwyn from your existing worldspace, modifed it, then imported it using TESAnnwyn
  into a new plugin, and can apply this script to copy modified data back into your mod.
  Destination (where to copy) is what you applied this script for: single LAND record,
  selected cell(s), exterior block(s) or the whole worldspace.
  Select source worldspace to copy from and what landscape data to copy in options window.
}
unit CopyLandData;

var
  DestWorld: IInterface;
  bNormals, bHeightmap, bColors, bLayers: Boolean;
  CellCount: integer;

//===========================================================================
// returns LAND record for CELL record
function GetLandscapeForCell(cell: IInterface): IInterface;
var
  cellchild, r: IInterface;
  i: integer;
begin
  cellchild := FindChildGroup(ChildGroup(cell), 9, cell); // get Temporary group of cell
  for i := 0 to Pred(ElementCount(cellchild)) do begin
    r := ElementByIndex(cellchild, i);
    if Signature(r) = 'LAND' then begin
      Result := r;
      Exit;
    end;
  end;
end;

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

//===========================================================================
procedure FillWorldspaces(lst: TStrings);
var
  sl: TStringList;
  i, j: integer;
  f, wrlds, wrld: IInterface;
  s: string;
begin
  sl := TStringList.Create;
  for i := 0 to Pred(FileCount) do begin
    f := FileByIndex(i);
    wrlds := GroupBySignature(f, 'WRLD');
    for j := 0 to Pred(ElementCount(wrlds)) do begin
      wrld := ElementByIndex(wrlds, j);
      if ElementType(wrld) <> etMainRecord then Continue;
      s := EditorID(wrld) + ' in ' + Name(f);
      sl.AddObject(s, wrld);
    end;
  end;
  sl.Sort;
  lst.AddStrings(sl);
  sl.Free;
end;

//===========================================================================
function OptionsForm: Boolean;
var
  frm: TForm;
  lbl: TLabel;
  cmbWorld: TComboBox;
  clbOptions: TCheckListBox;
  btnOk, btnCancel: TButton;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Copy landscape data';
    frm.Width := 326;
    frm.Height := 260;
    frm.Position := poMainFormCenter;
    frm.BorderStyle := bsDialog;
    
    lbl := TLabel.Create(frm);
    lbl.Parent := frm;
    lbl.Left := 8;
    lbl.Top := 8;
    lbl.Caption := 'From worldspace';
    
    cmbWorld := TComboBox.Create(frm);
    cmbWorld.Parent := frm;
    cmbWorld.Left := 8;
    cmbWorld.Top := 26;
    cmbWorld.Width := 300;
    cmbWorld.Style := csDropDownList;
    FillWorldspaces(cmbWorld.Items);
    if cmbWorld.Items.Count > 0 then
      cmbWorld.ItemIndex := 0;

    clbOptions := TCheckListBox.Create(frm);
    clbOptions.Parent := frm;
    clbOptions.Top := 60;
    clbOptions.Left := 8;
    clbOptions.Width := 300;
    clbOptions.Height := 60;
    clbOptions.Items.Add('Vertex normals');
    clbOptions.Items.Add('Vertex heightmap');
    clbOptions.Items.Add('Vertex colors');
    clbOptions.Items.Add('Texture layers');

    lbl := TLabel.Create(frm);
    lbl.Parent := frm;
    lbl.Left := 8;
    lbl.Top := 128;
    lbl.Width := 300;
    lbl.Height := 40;
    lbl.AutoSize := False;
    lbl.Wordwrap := True;
    lbl.Caption := 'If you checked Texture layers, then FormIDs of LTEX landscape textures must match in source and destination plugins, otherwise copy will fail';
    
    btnOk := TButton.Create(frm);
    btnOk.Parent := frm;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;
    btnOk.Left := 150;
    btnOk.Top := 200;
    
    btnCancel := TButton.Create(frm);
    btnCancel.Parent := frm;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := btnOk.Left + btnOk.Width + 10;
    btnCancel.Top := btnOk.Top;
    
    if frm.ShowModal <> mrOk then
      Exit;

    if cmbWorld.ItemIndex <> -1 then begin
      DestWorld := ObjectToElement(cmbWorld.Items.Objects[cmbWorld.ItemIndex]);
      bNormals := clbOptions.Checked[0];
      bHeightmap := clbOptions.Checked[1];
      bColors := clbOptions.Checked[2];
      bLayers := clbOptions.Checked[3];
      if bNormals or bHeightmap or bColors or bLayers then
        Result := True
      else
        AddMessage('Nothing to copy');
    end;
  
  finally
    frm.Free;
  end;
end;

//===========================================================================
function Initialize: integer;
begin
  if not wbSimpleRecords then begin
    MessageDlg('Simple records must be checked in xEdit options', mtInformation, [mbOk], 0);
    Result := 1;
    Exit;
  end;
  
  if not OptionsForm then begin
    Result := 1;
    Exit;
  end;
end;

//===========================================================================
function Process(e: IInterface): integer;
var
  cell, land: IInterface;
begin
  if Signature(e) <> 'LAND' then
    Exit;
  
  cell := LinksTo(ElementByName(e, 'Cell'));
  if not Assigned(cell) then
    Exit;
  cell := GetCellFromWorldspace(DestWorld, GetElementNativeValues(cell, 'XCLC\X'), GetElementNativeValues(cell, 'XCLC\Y'));
  land := GetLandscapeForCell(cell);
  if not Assigned(land) then
    Exit;
  
  if bNormals then
    ElementAssign(ElementBySignature(e, 'VNML'), LowInteger, ElementBySignature(land, 'VNML'), False);
  if bHeightmap then
    ElementAssign(ElementBySignature(e, 'VHGT'), LowInteger, ElementBySignature(land, 'VHGT'), False);
  if bColors then
    ElementAssign(ElementBySignature(e, 'VCLR'), LowInteger, ElementBySignature(land, 'VCLR'), False);
  if bLayers then
    ElementAssign(ElementByName(e, 'Layers'), LowInteger, ElementByName(land, 'Layers'), False);
  
  Inc(CellCount);
  if CellCount mod 1000 = 0 then
    AddMessage(Format('%d cell(s) copied', [CellCount]));
end;

//===========================================================================
function Finalize: integer;
begin
  AddMessage(Format('%d cell(s) copied', [CellCount]));
end;

end.