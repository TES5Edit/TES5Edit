{
  Batch combine LIP and XWM files into FUZ, or split FUZ into XWM and LIP
}
unit FUZer;

const
  // extensions to use
  sXWM = '.xwm';
  sLIP = '.lip';
  sFUZ = '.fuz';
  
  bShowProgress = True; // show processed files, can slow down on large amount of files
  sDefaultSourcePath = ''; // Data folder will be used if empty
  sDefaultDestinationPath = ''; // Data folder will be used if empty


//============================================================================
procedure BatchProcess(aSrcPath, aDstPath: string; bToFuz: Boolean);
var
  TDirectory: TDirectory; // to access member functions
  i, Processed: integer;
  fuz: TwbFUZFile;
  elLIP, elXWM: TdfElement;
  files: TStringDynArray;
  f, f2, s: string;
begin
  if (aSrcPath = '') or (aDstPath = '') then Exit;
  aSrcPath := IncludeTrailingBackslash(aSrcPath);
  aDstPath := IncludeTrailingBackslash(aDstPath);
  Processed := 0;
  
  fuz := TwbFUZFile.Create;
  fuz.SetToDefault;
  elLIP := fuz.Elements['LIP Data'];
  elXWM := fuz.Elements['XWM Data'];
  // LIP Data is limited by LIP Size field which is 0 by default, ignore that check when creating FUZ
  if bToFuz then elLIP.BeginUpdate;

  try
    if bToFuz then
      files := TDirectory.GetFiles(aSrcPath, '*' + sXWM, soAllDirectories)
    else
      files := TDirectory.GetFiles(aSrcPath, '*' + sFUZ, soAllDirectories);

    AddMessage('Processing files in "' + aSrcPath + '", press and hold ESC to abort...');
    
    // processing files
    for i := 0 to Pred(Length(files)) do begin
      f := files[i];
      f2 := aDstPath + Copy(f, Length(aSrcPath) + 1, Length(f));

      s := ExtractFilePath(f2);
      if not DirectoryExists(s) then
        if not ForceDirectories(s) then
          raise Exception.Create('Can not create destination directory ' + s);

      // combine lip and xwm into fuz
      if bToFuz then begin
        s := ChangeFileExt(f, sLIP);
        if FileExists(s) then begin
          elLIP.LoadFromFile(s);
          elXWM.LoadFromFile(f);
          f2 := ChangeFileExt(f2, sFUZ);
          fuz.SaveToFile(f2);
          AddMessage('Saved: ' + f2);
        end else
          AddMessage('LIP not found: ' + s);
      end
      
      // split fuz to lip and xwm
      else begin
        fuz.LoadFromFile(f);
        elLIP.SaveToFile(ChangeFileExt(f2, sLIP));
        elXWM.SaveToFile(ChangeFileExt(f2, sXWM));
        AddMessage('Split: ' + f);
      end;
      
      Inc(Processed);

      // break the files processing loop if Escape is pressed
      if GetKeyState(VK_ESCAPE) and 128 = 128 then
        Break;
    
    end;
      
    AddMessage(Format(#13#10'Processed Files: %d', [Processed]));
  
  finally
    fuz.Free;
  end;
end;

//============================================================================
procedure btnSrcClick(Sender: TObject);
var
  ed: TLabeledEdit;
  s: string;
begin
  ed := TLabeledEdit(TForm(Sender.Parent).FindComponent('edSrc'));
  s := SelectDirectory('Select source', '', ed.Text, nil);
  if s <> '' then begin
    ed.Text := s;
    ed := TLabeledEdit(TForm(Sender.Parent).FindComponent('edDst'));
    if ed.Text = '' then
      ed.Text := s;
  end;
end;

//============================================================================
procedure btnDstClick(Sender: TObject);
var
  ed: TLabeledEdit;
  s: string;
begin
  ed := TLabeledEdit(TForm(Sender.Parent).FindComponent('edDst'));
  s := SelectDirectory('Select destination', '', ed.Text, nil);
  if s <> '' then
    ed.Text := s;
end;

//============================================================================
function Initialize: Integer;
var
  frm: TForm;
  edSrc, edDst: TLabeledEdit;
  btnOk, btnCancel, btnSrc, btnDst: TButton;
  rbToFuz, rbFromFuz: TRadioButton;
  pnl: TPanel;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'FUZer';
    frm.Width := 500;
    frm.Height := 220;
    frm.Position := poMainFormCenter;
    frm.BorderStyle := bsDialog;
    
    edSrc := TLabeledEdit.Create(frm); edSrc.Parent := frm;
    edSrc.Name := 'edSrc';
    edSrc.Left := 12;
    edSrc.Top := 24;
    edSrc.Width := frm.Width - 70;
    edSrc.LabelPosition := lpAbove;
    edSrc.EditLabel.Caption := 'Source folder';
    if sDefaultSourcePath <> '' then
      edSrc.Text := sDefaultSourcePath
    else
      edSrc.Text := wbDataPath;

    btnSrc := TButton.Create(frm);
    btnSrc.Parent := frm;
    btnSrc.Top := edSrc.Top - 1;
    btnSrc.Left := edSrc.Left + edSrc.Width + 6;
    btnSrc.Width := 32; btnSrc.Height := 22; btnSrc.Caption := '...';
    btnSrc.OnClick := btnSrcClick;

    edDst := TLabeledEdit.Create(frm); edDst.Parent := frm;
    edDst.Name := 'edDst';
    edDst.Left := 12;
    edDst.Top := edSrc.Top + 46;
    edDst.Width := frm.Width - 70;
    edDst.LabelPosition := lpAbove;
    edDst.EditLabel.Caption := 'Destination folder';
    if sDefaultDestinationPath <> '' then
      edDst.Text := sDefaultDestinationPath
    else
      edDst.Text := wbDataPath;

    btnDst := TButton.Create(frm);
    btnDst.Parent := frm;
    btnDst.Top := edDst.Top - 1;
    btnDst.Left := edDst.Left + edDst.Width + 6;
    btnDst.Width := 32; btnDst.Height := 22; btnDst.Caption := '...';
    btnDst.OnClick := btnDstClick;

    rbToFuz := TRadioButton.Create(frm); rbToFuz.Parent := frm;
    rbToFuz.Left := edDst.Left + 12;
    rbToFuz.Top := edDst.Top + 40;
    rbToFuz.Width := 140;
    rbToFuz.Caption := StringReplace(Format('%s + %s  to  %s', [UpperCase(sLIP), UpperCase(sXWM), UpperCase(sFUZ)]), '.', '', [rfReplaceAll]);
    rbToFuz.Checked := True;
    
    rbFromFuz := TRadioButton.Create(frm); rbFromFuz.Parent := frm;
    rbFromFuz.Left := rbToFuz.Left + rbToFuz.Width + 20;
    rbFromFuz.Top := rbToFuz.Top;
    rbFromFuz.Width := 140;
    rbFromFuz.Caption := StringReplace(Format('%s  to  %s + %s', [UpperCase(sFUZ), UpperCase(sLIP), UpperCase(sXWM)]), '.', '', [rfReplaceAll]);

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
      BatchProcess( edSrc.Text, edDst.Text, rbToFuz.Checked );
    
  finally
    frm.Free;
  end;
  
  Result := 1;
end;

end.
