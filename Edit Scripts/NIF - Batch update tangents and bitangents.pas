{
  Updates tangents and bitangents in NIF files, optionally adding them
  if missing where appropriate.
  
  Supports all game NIF formats starting from Morrowind.
}
unit NifBatchUpdateTangents;


//============================================================================
procedure UpdateTangents(aPath: string; aAddIfMissing: Boolean);
var
  TDirectory: TDirectory; // to access member functions
  i: integer;
  Nif: TwbNifFile;
  files: TStringDynArray;
  f, ext: string;
  bChanged: Boolean;
begin
  if aPath = '' then Exit;
  
  Nif := TwbNifFile.Create;
  try
    files := TDirectory.GetFiles(aPath, '*.nif', soAllDirectories);
    AddMessage('Processing NIF files in "' + aPath + '", press and hold ESC to abort...');
    
    for i := 0 to Pred(Length(files)) do begin
      f := files[i];
      ext := ExtractFileExt(f);
      
      // break the files processing loop if Escape is pressed
      if GetKeyState(VK_ESCAPE) and 128 = 128 then
        Break;

      Nif.LoadFromFile(f);
      
      if aAddIfMissing then
        bChanged := Nif.SpellAddUpdateTangents
      else
        bChanged := Nif.SpellUpdateTangents;
    
      if bChanged then begin
        Nif.SaveToFile(f);
        AddMessage('Updated: ' + f);
      end else
        AddMessage('Nothing to update: ' + f);
      
    end;
  
  finally
    Nif.Free;
  end;
end;

//============================================================================
procedure btnSrcClick(Sender: TObject);
var
  edSrc: TLabeledEdit;
  s: string;
begin
  edSrc := TLabeledEdit(TForm(Sender.Parent).FindComponent('edSrc'));
  s := SelectDirectory('Select a directory', '', edSrc.Text, nil);
  if s <> '' then
    edSrc.Text := s;
end;

//============================================================================
function Initialize: Integer;
var
  frm: TForm;
  edSrc: TLabeledEdit;
  chkAdd: TCheckBox;
  btnOk, btnCancel, btnSrc: TButton;
  pnl: TPanel;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Batch Update Tangents';
    frm.Width := 500;
    frm.Height := 170;
    frm.Position := poMainFormCenter;
    frm.BorderStyle := bsDialog;
    
    edSrc := TLabeledEdit.Create(frm); edSrc.Parent := frm;
    edSrc.Name := 'edSrc';
    edSrc.Left := 12;
    edSrc.Top := 24;
    edSrc.Width := frm.Width - 70;
    edSrc.LabelPosition := lpAbove;
    edSrc.EditLabel.Caption := 'Folder with *.nif files to update';
    edSrc.Text := wbDataPath;

    btnSrc := TButton.Create(frm);
    btnSrc.Parent := frm;
    btnSrc.Top := edSrc.Top - 1;
    btnSrc.Left := edSrc.Left + edSrc.Width + 6;
    btnSrc.Width := 32; btnSrc.Height := 22; btnSrc.Caption := '...';
    btnSrc.OnClick := btnSrcClick;
    
    chkAdd := TCheckBox.Create(frm); chkAdd.Parent := frm;
    chkAdd.Left := edSrc.Left + 12;
    chkAdd.Top := edSrc.Top + 32;
    chkAdd.Width := frm.Width - 60;
    chkAdd.Caption := 'Add tangents if missing where appropriate';
    chkAdd.Checked := True;

    btnOk := TButton.Create(frm); btnOk.Parent := frm;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;
    btnOk.Left := frm.Width - 176;
    btnOk.Top := frm.Height - 62;
    
    btnCancel := TButton.Create(frm); btnCancel.Parent := frm;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := btnOk.Left + btnOk.Width + 8;
    btnCancel.Top := btnOk.Top;

    pnl := TPanel.Create(frm); pnl.Parent := frm; pnl.Left := 8; pnl.Top := btnOk.Top - 12; pnl.Width := frm.Width - 20; pnl.Height := 2;

    if frm.ShowModal = mrOk then
      if edSrc.Text <> '' then
        UpdateTangents( edSrc.Text, chkAdd.Checked );
    
  finally
    frm.Free;
  end;
  
  Result := 1;
end;

end.
