{
  Copy landscape data in defined rectangular area between worldspaces
  with optional height adjustment.
  
  Height adjustment is needed when the default water levels don't match in
  source and destination areas. For example in source area it is -2048, in
  destination 0, then adjustment should be 2048 to raise landscape.
  Adjustment must always be divisible by 8!!!
  
  When patch plugin option is checked a new plugin will be created to patch
  landscape in destination area. When not checked, landscape records
  will be changed directly.
}
unit CopyAreaLandData;

const
  bCopyLayers = False; // True to copy landscape textures, though this requires textures availability in destination plugin

var
  World1, World2, Plugin: IInterface;
  X1, Y1, W, H, X2, Y2, HeightAdjust: Integer;
  bPlugin: Boolean;


//===========================================================================
// returns LAND record for CELL record
function GetLandscapeForCell(cell: IInterface; aAddIfMissing: Boolean; aPlugin: IInterface): IInterface;
var
  cellchild, r: IInterface;
  i: integer;
begin
  cellchild := FindChildGroup(ChildGroup(cell), 9, cell); // get Temporary group of cell
  
  for i := 0 to Pred(ElementCount(cellchild)) do begin
    r := ElementByIndex(cellchild, i);
    if Signature(r) <> 'LAND' then
      Continue;
    
    // copy land as override if new plugin is provided
    if Assigned(aPlugin) then begin
      AddRequiredElementMasters(cell, Plugin, False);
      Result := wbCopyElementToFile(r, aPlugin, False, True);
    end else
      Result := r;
      
    Exit;
  end;
  
  if not aAddIfMissing then
    Exit;

  // add a new one if missing
  // copy cell as override if new plugin is provided
  if Assigned(aPlugin) then begin
    AddRequiredElementMasters(cell, Plugin, False);
    cell := wbCopyElementToFile(cell, aPlugin, False, True);
  end
  Result := Add(cell, 'LAND', True);
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
      s := EditorID(wrld);
      if sl.IndexOf(s) = -1 then
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
  cmbWorldFrom, cmbWorldTo: TComboBox;
  edX1, edY1, edW, edH, edX2, edY2, edH2: TEdit;
  chkPlugin: TCheckBox;
  btnOk, btnCancel: TButton;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Copy landscape';
    frm.Width := 400;
    frm.Height := 310;
    frm.Position := poMainFormCenter;
    frm.BorderStyle := bsDialog;
    
    cmbWorldFrom := TComboBox.Create(frm); cmbWorldFrom.Parent := frm;
    cmbWorldFrom.Left := 8;
    cmbWorldFrom.Top := 26;
    cmbWorldFrom.Width := frm.Width - 26;
    cmbWorldFrom.Style := csDropDownList;
    cmbWorldFrom.DropDownCount := 20;
    FillWorldspaces(cmbWorldFrom.Items);
    if cmbWorldFrom.Items.Count > 0 then
      cmbWorldFrom.ItemIndex := 0;

    lbl := TLabel.Create(frm); lbl.Parent := frm;
    lbl.Left := cmbWorldFrom.Left;
    lbl.Top := cmbWorldFrom.Top - 16;
    lbl.Caption := 'From worldspace';

    edX1 := TEdit.Create(frm); edX1.Parent := frm;
    edX1.Left := 8;
    edX1.Top := cmbWorldFrom.Top + 50;
    edX1.Width := 32;
    edX1.Text := '0';

    edY1 := TEdit.Create(frm); edY1.Parent := frm;
    edY1.Left := edX1.Left + 40;
    edY1.Top := edX1.Top;
    edY1.Width := edX1.Width;
    edY1.Text := '0';

    edW := TEdit.Create(frm); edW.Parent := frm;
    edW.Left := edY1.Left + 40;
    edW.Top := edX1.Top;
    edW.Width := edX1.Width;
    edW.Text := '4';

    edH := TEdit.Create(frm); edH.Parent := frm;
    edH.Left := edW.Left + 40;
    edH.Top := edX1.Top;
    edH.Width := edX1.Width;
    edH.Text := '4';

    lbl := TLabel.Create(frm); lbl.Parent := frm;
    lbl.Left := edX1.Left;
    lbl.Top := edX1.Top - 16;
    lbl.Caption := 'Area: South West cell coordinates, cells Width and Height';

    cmbWorldTo := TComboBox.Create(frm); cmbWorldTo.Parent := frm;
    cmbWorldTo.Left := 8;
    cmbWorldTo.Top := 130;
    cmbWorldTo.Width := frm.Width - 26;
    cmbWorldTo.Style := csDropDownList;
    cmbWorldTo.DropDownCount := 20;
    FillWorldspaces(cmbWorldTo.Items);
    if cmbWorldTo.Items.Count > 0 then
      cmbWorldTo.ItemIndex := Pred(cmbWorldTo.Items.Count);

    lbl := TLabel.Create(frm); lbl.Parent := frm;
    lbl.Left := cmbWorldTo.Left;
    lbl.Top := cmbWorldTo.Top - 16;
    lbl.Caption := 'To worldspace';

    edX2 := TEdit.Create(frm); edX2.Parent := frm;
    edX2.Left := 8;
    edX2.Top := cmbWorldTo.Top + 50;
    edX2.Width := 32;
    edX2.Text := '10';

    edY2 := TEdit.Create(frm); edY2.Parent := frm;
    edY2.Left := edX2.Left + 40;
    edY2.Top := edX2.Top;
    edY2.Width := edX2.Width;
    edY2.Text := '10';

    edH2 := TEdit.Create(frm); edH2.Parent := frm;
    edH2.Left := edY2.Left + 40;
    edH2.Top := edY2.Top;
    edH2.Width := 64;

    lbl := TLabel.Create(frm); lbl.Parent := frm;
    lbl.Left := edX2.Left;
    lbl.Top := edX2.Top - 16;
    lbl.Caption := 'South West cell coordinates, optional Height adjustment in game units';
    
    chkPlugin := TCheckBox.Create(frm); chkPlugin.Parent := frm;
    chkPlugin.Left := 8;
    chkPlugin.Top := edX2.Top + 40;
    chkPlugin.Width := frm.Width - 26;
    chkPlugin.Caption := 'Create patch plugin';
    chkPlugin.Checked := True;

    btnOk := TButton.Create(frm);
    btnOk.Parent := frm;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;
    btnOk.Left := frm.Width - 180;
    btnOk.Top := frm.Height - 64;
    
    btnCancel := TButton.Create(frm);
    btnCancel.Parent := frm;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := btnOk.Left + btnOk.Width + 10;
    btnCancel.Top := btnOk.Top;
    
    if frm.ShowModal <> mrOk then
      Exit;

    if (cmbWorldFrom.ItemIndex = -1) or (cmbWorldTo.ItemIndex = -1) or (cmbWorldFrom.ItemIndex = cmbWorldTo.ItemIndex) then
      Exit;
    
    World1 := ObjectToElement(cmbWorldFrom.Items.Objects[cmbWorldFrom.ItemIndex]);
    World2 := ObjectToElement(cmbWorldTo.Items.Objects[cmbWorldTo.ItemIndex]);
    X1 := StrToInt(edX1.Text);
    Y1 := StrToInt(edY1.Text);
    W := StrToInt(edW.Text);
    H := StrToInt(edH.Text);
    X2 := StrToInt(edX2.Text);
    Y2 := StrToInt(edY2.Text);
    if edH2.Text <> '' then
      HeightAdjust := StrToInt(edH2.Text);
    bPlugin := chkPlugin.Checked;
    
    Result := True;
  finally
    frm.Free;
  end;
end;

//===========================================================================
function Initialize: integer;
var
  cell1, land1, cell2, land2: IInterface;
  i, j: Integer;
begin
  Result := 1;

  if wbSimpleRecords then begin
    MessageDlg('Simple records must be unchecked in xEdit options', mtInformation, [mbOk], 0);
    Exit;
  end;
  
  if not OptionsForm then
    Exit;
  
  //Exit;
  
  if bPlugin then begin
    Plugin := AddNewFile;
    if not Assigned(Plugin) then
      Exit;
    AddRequiredElementMasters(World2, Plugin, False);
  end;

  for i := 0 to Pred(W) do
    for j := 0 to Pred(H) do begin
      cell1 := GetCellFromWorldspace(World1, X1 + i, Y1 + j);
      land1 := GetLandscapeForCell(cell1, False, nil);
      if not Assigned(land1) then
        Continue;

      cell2 := GetCellFromWorldspace(World2, X2 + i, Y2 + j);
      if not Assigned(cell2) then begin
        AddMessage(Format('Skipped: Destination cell not found %s <%d,%d>', [EditorID(World2), X2 + i, Y2 + j]));
        Continue;
      end;
      land2 := GetLandscapeForCell(cell2, True, Plugin);
      
      CopyElement(land1, land2, 'DATA');
      CopyElement(land1, land2, 'VNML');
      CopyElement(land1, land2, 'VHGT');
      CopyElement(land1, land2, 'VCLR');
      if bCopyLayers then
        CopyElement(land1, land2, 'Layers');

      SetElementNativeValues(land2, 'VHGT\Offset', GetElementNativeValues(land2, 'VHGT\Offset') + HeightAdjust / 8);
      
      AddMessage(Format('Copied: %s <%d,%d> to %s <%d,%d>', [
        EditorID(World1), X1 + i, Y1 + j,
        EditorID(World2), X2 + i, Y2 + j
      ]));
    end;
end;

end.