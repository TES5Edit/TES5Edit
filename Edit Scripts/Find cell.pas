{
  Find cell by X,Y coordinates.
  
  Hotkey: Ctrl+Shift+F
}
unit userscript;

procedure FindCell(WrldEDID, XVal, YVal: string);
var
  x, y: integer;
  modidx, wrldidx, blockidx, subblockidx, cellidx: integer;
  f, wrlds, wrld, wrldgrup, block, subblock, cell: IInterface;
  BlockName, SubBlockName: string;
begin
  x := StrToIntDef(XVal, 0);
  y := StrToIntDef(YVal, 0);
  BlockName := Format('Block %d, %d', [(x + 32) div 32 - 1, (y + 32) div 32 - 1]);
  SubBlockName := Format('Sub-Block %d, %d', [(x + 8) div 8 - 1, (y + 8) div 8 - 1]);
  AddMessage(BlockName);
  AddMessage(SubBlockName);
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
        //AddMessage(ShortName(block));
        if ShortName(block) <> BlockName then Continue;
          
        // traverse SubBlocks
        for subblockidx := 0 to ElementCount(block) - 1 do begin
          subblock := ElementByIndex(block, subblockidx);
          if ShortName(subblock) <> SubBlockName then Continue;

          // traverse Cells
          for cellidx := 0 to ElementCount(subblock) - 1 do begin
            cell := ElementByIndex(subblock, cellidx);
            if Signature(cell) <> 'CELL' then Continue;
            if (GetElementNativeValues(cell, 'XCLC\X') = x) and (GetElementNativeValues(cell, 'XCLC\Y') = y) then begin
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
end;

procedure FillWorldspaces(lst: TStrings);
var
  i, j: integer;
  f, wrlds, wrld: IInterface;
  s: string;
begin
  for i := 0 to FileCount - 1 do begin
    f := FileByIndex(i);
    wrlds := GroupBySignature(f, 'WRLD');
    if not Assigned(wrlds) then Continue;
    for j := 0 to ElementCount(wrlds) - 1 do begin
      wrld := ElementByIndex(wrlds, j);
      s := GetElementEditValues(wrld, 'EDID');
      if (s <> '') and (lst.IndexOf(s) = -1) then
        if not ElementExists(wrld, 'WNAM') then
          lst.Add(s);
    end;
  end;
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
    frm.Height := 300;
    frm.Position := poScreenCenter;
    frm.BorderStyle := bsDialog;
    
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
    lbWorld.Height := 200;
    
    FillWorldspaces(lbWorld.Items);
    if lbWorld.Items.Count > 0 then lbWorld.ItemIndex := 0;

    btnOk := TButton.Create(frm);
    btnOk.Parent := frm;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;
    btnOk.Left := 24;
    btnOk.Top := 242;
    
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
  //JumpTo(RecordByFormID(FileByIndex(0), $162, False), False);
  OptionsForm;
  Result := 1;
end;

end.