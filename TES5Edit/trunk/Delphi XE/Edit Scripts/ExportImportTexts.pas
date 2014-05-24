{
  Export the text of scripts in selected records.
}
unit UserScript;

var
  slText, sl: TStringList;
  basePath, extension: string;
	doScriptsOnly, doImport, doStop: boolean;
  debug: boolean;
    
//=========================================================================
// OptionsForm: Provides user with options for merging
procedure OptionsForm;
var
  frm: TForm;
  btnOk, btnCancel, btnFocus: TButton;
  cb: TGroupBox;
  cbArray: Array[0..254] of TCheckBox;
  rb1, rb2, rb4, rb5: TRadioButton;
  lbl1, lbl2: TLabel;
  rg, rg2: TRadioGroup;
  pnl: TPanel;
  sb: TScrollBox;
  i, j, k, height, m, more: integer;
  holder: TObject;
  masters, e, f: IInterface;
  s: string;
begin
  more := 0;
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Export/Import Texts';
    frm.Width := 276;
    frm.Position := poScreenCenter;
    height := 240;
    if height > (Screen.Height - 100) then begin
      frm.Height := Screen.Height - 100;
      sb := TScrollBox.Create(frm);
      sb.Parent := frm;
      sb.Height := Screen.Height - 290;
      sb.Align := alTop;
      holder := sb;
    end
    else begin
      frm.Height := height;
      holder := frm;
    end;

    pnl := TPanel.Create(frm);
    pnl.Parent := frm;
    pnl.BevelOuter := bvNone;
    pnl.Align := alBottom;
    pnl.Height := 190;
    
    rg := TRadioGroup.Create(frm);
    rg.Parent := pnl;
    rg.Left := 16;
    rg.Height := 60;
    rg.Top := 16;
    rg.Width := 220;
    rg.Caption := 'Direction ?';
    rg.ClientHeight := 45;
    rg.ClientWidth := 220;
    
    rb1 := TRadioButton.Create(rg);
    rb1.Parent := rg;
    rb1.Left := 26;
    rb1.Top := 18;
    rb1.Caption := 'Export';
    rb1.Width := 80;
    rb1.Checked := True;
    
    rb2 := TRadioButton.Create(rg);
    rb2.Parent := rg;
    rb2.Left := rb1.Left + rb1.Width + 30;
    rb2.Top := rb1.Top;
    rb2.Caption := 'Import';
    rb2.Width := 75;
    
		if wbGameMode <> gmTES5 then begin
			rg2 := TRadioGroup.Create(frm);
			rg2.Parent := pnl;
			rg2.Left := 16;
			rg2.Height := 60;
			rg2.Top := rg.Top + rg.Height + 1;
			rg2.Width := 220;
			rg2.Caption := 'Selection ?';
			rg2.ClientHeight := 45;
			rg2.ClientWidth := 220;
			
			rb4 := TRadioButton.Create(rg);
			rb4.Parent := rg2;
			rb4.Left := 26;
			rb4.Top := 18;
			rb4.Caption := 'All texts';
			rb4.Width := 80;
			rb4.Checked := True;
			
			rb5 := TRadioButton.Create(rg);
			rb5.Parent := rg2;
			rb5.Left := rb1.Left + rb1.Width + 30;
			rb5.Top := rb1.Top;
			rb5.Caption := 'Only scripts';
			rb5.Width := 75;
    end;
		
    btnOk := TButton.Create(frm);
    btnOk.Parent := pnl;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;
    btnOk.Left := 60;
    btnOk.Top := pnl.Height - 40;
    
    btnCancel := TButton.Create(frm);
    btnCancel.Parent := pnl;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := btnOk.Left + btnOk.Width + 16;
    btnCancel.Top := btnOk.Top;
    
    frm.ActiveControl := btnOk;
    
    if frm.ShowModal = mrOk then begin
			if rb1.Checked then doImport := False else
			if rb2.Checked then doImport := True;
			if wbGameMode = gmTES5 then
			  doScriptsOnly := False
			else
				if rb4.Checked then doScriptsOnly := False else
				if rb5.Checked then doScriptsOnly := True;
			doStop := False;
		end else
			doStop := True;
  finally
    frm.Free;
  end;
end;

function Initialize: integer;
var
  i: TIniFile;
begin
  debug := False;
  slText := TStringList.Create;
  sl := TStringList.Create;
  i := TIniFile.Create(wbSettingsFileName);

	OptionsForm;

	if doStop then Exit;
	
  if doScriptsOnly then begin
		basePath := i.ReadString('ExportScripts', 'BasePath', wbTempPath);
		extension := i.ReadString('ExportScripts', 'Extension', '.geck');
	end else begin
		basePath := i.ReadString('ExportTexts', 'BasePath', wbTempPath);
		extension := i.ReadString('ExportTexts', 'Extension', '.txt');
	end;
	if Pos('\\?\', basePath)=0 then basePath := '\\?\'+basePath;  // allows program to handle very long file names
	if debug then AddMessage('Using directory: "'+basePath+'" and extension: "'+extension+'"');
end;

function Process(e: IInterface): integer;
var
  s, c, x: string;
  t: IInterface;
  i: integer;
	doThisOne: boolean;
begin
	if doStop then Exit;
	
	if doScriptsOnly then
		doThisOne := (Signature(e) = 'SCTX')
	else
		doThisOne := ((DefType(e) = dtString) or (DefType(e) = dtLString) or (DefType(e) = dtLenString));
		
  if doThisOne then begin
    x := PathName(e);
    x := FullPathToFilename(x);
    c := basePath + x + extension;
    x := ExtractFilePath(c);
    c := ExtractFileName(c);
    if debug then AddMessage('Processing: '+c+' at '+x);
    
    ForceDirectories(x);
    if DirectoryExists(x) then begin
      x := x+c;
      s := GetEditValue(e);
      slText.Text := s;
      if FileExists(x) then begin
        if debug then AddMessage(x+' exists');
        sl.Clear;
        sl.LoadFromFile(x);
        if sl.Text <> slText.Text then begin
					if debug then AddMessage(x+' modified');
          if doImport then
						SetEditValue(e, sl.Text)
					else
						slText.SaveToFile(x);
				end;
      end else
        if not doImport then
					slText.SaveToFile(x);
    end else
      if debug then AddMessage('Directory not created : '+x);
  end;
  
  for i := 0 to ElementCount(e) - 1 do
    Process(ElementByIndex(e, i));
end;

function finalize: integer;
begin
  sl.Free;
  slText.Free;
end;

end.
