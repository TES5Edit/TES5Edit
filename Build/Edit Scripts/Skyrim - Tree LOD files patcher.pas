{
  Correct position of LOD objects for trees (BTT files) in cells over -32 or 32
}
unit UserScript;

var
  LodPath: string;

function PatchBTTFile(aFileName: string): boolean;
var
  fsRead, fsWrite: TFileStream;
  reader: TBinaryReader;
  writer: TBinaryWriter;
  NumTypes, NumTrees, TreeType: Integer;
  i, t, formid: integer;
  x, y, z, rot, scale: single;
  r, f: IInterface;
begin
  Result := True;
  fsRead := TFileStream.Create(aFileName, fmOpenRead);
  fsWrite := TFileStream.Create(aFileName + '.patched', fmCreate);
  try
    reader := TBinaryReader.Create(fsRead);
    writer := TBinaryWriter.Create(fsWrite);
    NumTypes := reader.ReadInteger;
    writer.Write(NumTypes);
    for i := 1 to NumTypes do begin
      TreeType := reader.ReadInteger;
      NumTrees := reader.ReadInteger;
      writer.Write(TreeType);
      writer.Write(NumTrees);
      for t := 1 to NumTrees do begin
        x := reader.ReadSingle;
        y := reader.ReadSingle;
        z := reader.ReadSingle;
        rot := reader.ReadSingle;
        scale := reader.ReadSingle;
        formid := reader.ReadInteger;
        f := FileByLoadOrder(formid shr 24); 
        r := RecordByFormID(f, LoadOrderFormIDtoFileFormID(f, formid), false);
        if not Assigned(r) then begin
          AddMessage('Can''t locate record with formid=' + IntToHex(formid, 8));
          Result := False;
          Exit;
        end else
        if (Signature(r) <> 'REFR') or (Signature(LinksTo(ElementBySignature(r, 'NAME'))) <> 'TREE') then begin
          AddMessage('Record with formid=' + IntToHex(formid, 8) + ' in BTT file is not a reference of TREE');
          Result := False;
          Exit;
        end else
        begin
          x := GetElementNativeValues(r, 'DATA\Position\X');
          y := GetElementNativeValues(r, 'DATA\Position\Y');
        end;
        writer.WriteSingle(x);
        writer.WriteSingle(y);
        writer.WriteSingle(z);
        writer.WriteSingle(rot);
        writer.WriteSingle(scale);
        writer.Write(formid);
        writer.Write(reader.ReadInteger); // unknown int
        writer.Write(reader.ReadInteger); // unknown int
      end;
    end;
  finally
    reader.Free;
    writer.Free;
    fsRead.Free;
    fsWrite.Free;
    if Result then begin
      DeleteFile(aFileName);
      RenameFile(aFilename + '.patched', aFileName);
    end else
      AddMessage('Most likely load orders in CK and TES5Edit does not match. Please restore BTT files from backup.');
  end;
end;

procedure PatchWorldspace(aName: string);
var
  wspath: string;
  F: TSearchRec;
  slv: TStringList;
  x, y: integer;
begin
  wspath := LodPath + aName + '\Trees\';
  if FindFirst(wspath + '*.BTT', faAnyFile, F) = 0 then try
    slv := TStringList.Create;
    slv.Delimiter := '.';
    slv.StrictDelimiter := true;
    repeat
      slv.DelimitedText := F.Name;
      x := StrToIntDef(slv[2], 0);
      y := StrToIntDef(slv[3], 0);
      if (x <= -28) or (x >= 28) or (y <= -28) or (y >= 28) then begin
        AddMessage('Patching: ' + F.Name);
        PatchBTTFile(wspath + F.Name);
      end;
    until FindNext(F) <> 0;
  finally
    FindClose(F);
    slv.Free;
  end;
end;

procedure FillWorldspacesWithTreeLOD(lst: TStrings);
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
        if DirectoryExists(LodPath + s + '\Trees') then
          lst.Add(s);
    end;
  end;
end;

procedure OptionsForm;
var
  frm: TForm;
  btnOk, btnCancel: TButton;
  cbWS: TComboBox;
  lbl1, lbl2: TLabel;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'BTT Patcher';
    frm.Width := 400;
    frm.Height := 300;
    frm.Position := poScreenCenter;
    
    btnOk := TButton.Create(frm);
    btnOk.Parent := frm;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;
    btnOk.Left := 200;
    btnOk.Top := 220;
    
    btnCancel := TButton.Create(frm);
    btnCancel.Parent := frm;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := btnOk.Left + btnOk.Width + 16;
    btnCancel.Top := 220;
    
    cbWS := TComboBox.Create(frm);
    cbWS.Parent := frm;
    cbWS.Left := 8;
    cbWS.Top := 32;
    cbWS.Width := 360;
    cbWS.Style := csDropDownList;
    
    FillWorldspacesWithTreeLOD(cbWS.Items);
    if cbWS.Items.Count > 0 then cbWS.ItemIndex := 0;

    lbl1 := TLabel.Create(frm);
    lbl1.Parent := frm;
    lbl1.Top := cbWS.Top - 16;
    lbl1.Left := cbWS.Left;
    lbl1.Caption := 'Worldspace';
    
    lbl2 := TLabel.Create(frm);
    lbl2.Parent := frm;
    lbl2.Top := cbWS.Top + 40;
    lbl2.Left := cbWS.Left;
    lbl2.AutoSize := False;
    lbl2.Wordwrap := True;
    lbl2.Width := 360;
    lbl2.Height := 100;
    lbl2.Caption := 'Select Worldspace to patch BTT Tree LOD files ' +
      '(only worldspaces with generated lod in Meshes\Terrain\_wordspace_\Trees are shown).'#13#10 +
      'The load order of plugins in TES5Edit *MUST MATCH* load order in CK used ' +
      'to generate tree LOD files.'#13#10 +
      'Please backup BTT files before patching.';

    if frm.ShowModal = mrOk then begin
      if cbWS.ItemIndex <> -1 then
        PatchWorldspace(cbWS.Items[cbWS.ItemIndex]);
    end;
  finally
    frm.Free;
  end;
end;

function Initialize: integer;
begin
  LodPath := DataPath + 'meshes\terrain\';
  OptionsForm;
  Result := 1;
end;

end.
