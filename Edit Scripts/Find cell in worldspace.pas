{
  Find exterior cell by X,Y grid coordinates.
  
  Hotkey: Ctrl+Shift+F
}
unit userscript;

procedure FindCell(WrldEDID, XVal, YVal: string);
var
  CellX, CellY, x, y: integer;
  modidx, wrldidx, blockidx, subblockidx, cellidx: integer;
  f, wrlds, wrld, wrldgrup, block, subblock, cell: IInterface;
  BlockName, SubBlockName: string;
begin
  CellX := StrToIntDef(XVal, 0);
  CellY := StrToIntDef(YVal, 0);
  x := CellX div 32;
  if (CellX < 0) and (CellX mod 32 <> 0) then Dec(x);
  y := CellY div 32;
  if (CellY < 0) and (CellY mod 32 <> 0) then Dec(y);
  BlockName := Format('Block %d, %d', [x, y]);
  x := CellX div 8;
  if (CellX < 0) and (CellX mod 8 <> 0) then Dec(x);
  y := CellY div 8;
  if (CellY < 0) and (CellY mod 8 <> 0) then Dec(y);
  SubBlockName := Format('Sub-Block %d, %d', [x, y]);

  // traverse mods
  for modidx := 0 to FileCount - 1 do begin
    f := FileByIndex(modidx);
    wrlds := GroupBySignature(f, 'WRLD');
    if not Assigned(wrlds) then Continue;

    // traverse Worldspaces
    for wrldidx := 0 to ElementCount(wrlds) - 1 do begin
      wrld := ElementByIndex(wrlds, wrldidx);
      if GetElementEditValues(wrld, 'EDID') <> WrldEDID then Continue;
      wrldgrup := ChildGroup(wrld);

      // traverse Blocks
      for blockidx := 0 to ElementCount(wrldgrup) - 1 do begin
        block := ElementByIndex(wrldgrup, blockidx);
        if ShortName(block) <> BlockName then Continue;
          
        // traverse SubBlocks
        for subblockidx := 0 to ElementCount(block) - 1 do begin
          subblock := ElementByIndex(block, subblockidx);
          if ShortName(subblock) <> SubBlockName then Continue;

          // traverse Cells
          for cellidx := 0 to ElementCount(subblock) - 1 do begin
            cell := ElementByIndex(subblock, cellidx);
            if Signature(cell) <> 'CELL' then Continue;
            if (GetElementNativeValues(cell, 'XCLC\X') = CellX) and (GetElementNativeValues(cell, 'XCLC\Y') = CellY) then begin
              JumpTo(cell, False);
              Exit;
            end;
          end;

          Break;
        end;

        Break;
      end;

      Break;
    end;
  end;

  AddMessage('Cell not found!');
end;

procedure FillWorldspaces(lst: TStrings);
var
  sl: TStringList;
  i, j: integer;
  f, wrlds, wrld: IInterface;
  s: string;
begin
  sl := TStringList.Create;
  for i := 0 to FileCount - 1 do begin
    f := FileByIndex(i);
    wrlds := GroupBySignature(f, 'WRLD');
    if not Assigned(wrlds) then Continue;
    for j := 0 to ElementCount(wrlds) - 1 do begin
      wrld := ElementByIndex(wrlds, j);
      s := GetElementEditValues(wrld, 'EDID');
      if (s <> '') and (sl.IndexOf(s) = -1) then
        sl.Add(s);
    end;
  end;
  sl.Sort;
  lst.AddStrings(sl);
  sl.Free;
end;

procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    TForm(Sender).ModalResult := mrOk;
  if Key = VK_ESCAPE then
    TForm(Sender).ModalResult := mrCancel;
end;
  
procedure OptionsForm;
var
  frm: TForm;
  btnOk, btnCancel: TButton;
  lbWorld: TListBox;
  edX, edY: TLabeledEdit;
  lbl1, lbl2: TLabel;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Find cell in worldspace';
    frm.Width := 220;
    frm.Height := 500;
    frm.Position := poScreenCenter;
    frm.BorderStyle := bsDialog;
    frm.KeyPreview := True;
    frm.OnKeyDown := FormKeyDown;
    
    edX := TLabeledEdit.Create(frm);
    edX.Parent := frm;
    edX.LabelPosition := lpLeft;
    edX.EditLabel.Caption := 'X:';
    edX.Left := 24;
    edX.Top := 8;
    edX.Width := 40;

    edY := TLabeledEdit.Create(frm);
    edY.Parent := frm;
    edY.LabelPosition := lpLeft;
    edY.EditLabel.Caption := 'Y:';
    edY.Left := edX.Left + 70;
    edY.Top := edX.Top;
    edY.Width := edX.Width;

    lbWorld := TListBox.Create(frm);
    lbWorld.Parent := frm;
    lbWorld.Left := 8;
    lbWorld.Top := 36;
    lbWorld.Width := 200;
    lbWorld.Height := 400;
    
    FillWorldspaces(lbWorld.Items);
    if lbWorld.Items.Count > 0 then begin
      if (wbGameMode = gmTES4) or (wbGameMode = gmTES5) then lbWorld.ItemIndex := lbWorld.Items.IndexOf('Tamriel') else
      if wbGameMode = gmFO3 then lbWorld.ItemIndex := lbWorld.Items.IndexOf('Wasteland') else
      if wbGameMode = gmFNV then lbWorld.ItemIndex := lbWorld.Items.IndexOf('WastelandNV') else
        lbWorld.ItemIndex := 0;
    end;

    btnOk := TButton.Create(frm);
    btnOk.Parent := frm;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;
    btnOk.Left := 24;
    btnOk.Top := 442;
    
    btnCancel := TButton.Create(frm);
    btnCancel.Parent := frm;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := btnOk.Left + btnOk.Width + 16;
    btnCancel.Top := btnOk.Top;
    
    if frm.ShowModal = mrOk then begin
     if (lbWorld.ItemIndex <> -1) and (Trim(edX.Text) <> '') and (Trim(edY.Text) <> '') then
       FindCell(lbWorld.Items[lbWorld.ItemIndex], edX.Text, edY.Text);
    end;
  finally
    frm.Free;
  end;
end;

function Initialize: Integer;
begin
  OptionsForm;
  Result := 1;
end;

end.