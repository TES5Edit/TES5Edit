{
  Export the text of selected records.
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
  sf: TMemIniFile;
  frm: TForm;
  btnOk, btnCancel: TButton;
  rb1, rb2, rb4, rb5: TRadioButton;
  rg, rg2: TRadioGroup;
  lb1, lb2: TLabel;
  ed1, ed2: TEdit;
  pnl: TPanel;
  sb: TScrollBox;
  i, j, k, height, m, more: integer;
  holder: TObject;
  masters, e, f: IInterface;
  s: string;
  doCloseSF: boolean;
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
    
    if wbGameMode < gmTES5 then begin
      rg2 := TRadioGroup.Create(frm);
      rg2.Parent := pnl;
      rg2.Left := 16;
      rg2.Height := 60;
      rg2.Top := rg.Top + rg.Height + 1;
      rg2.Width := rg.Width;
      rg2.Caption := 'Selection ?';
      rg2.ClientHeight := 45;
      rg2.ClientWidth := rg2.Width;
    end;
    rb4 := TRadioButton.Create(rg);
    if wbGameMode < gmTES5 then begin
      rb4.Parent := rg2;
      rb4.Left := rb1.left;
      rb4.Top := rb1.Top;
      rb4.Caption := 'All texts';
      rb4.Width := rb1.Width;
      
      rb5 := TRadioButton.Create(rg);
      rb5.Parent := rg2;
      rb5.Left := rb4.Left + rb4.Width + 30;
      rb5.Top := rb4.Top;
      rb5.Caption := 'Only scripts';
      rb5.Width := rb4.Width;
    end;
    rb4.Checked := True;

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
      if rb4.Checked then doScriptsOnly := False else
      if rb5.Checked then doScriptsOnly := True;
      doStop := False;
    end else
      doStop := True;
  finally
    frm.Free;
  end;

  if not doStop then begin
    frm := TForm.Create(nil);
    if Assigned(wbSettings) then begin
      sf := wbSettings;
      doCloseSF := False;
    end else begin
      sf := TIniFile.Create(wbSettingsFileName);
      doCloseSF := True;
    end;
    try
      if doScriptsOnly then
        if doImport then
          frm.Caption := 'Import Scripts from'
        else
          frm.Caption := 'Export Scripts to'
      else
        if doImport then
          frm.Caption := 'Import texts from'
        else
          frm.Caption := 'Export texts to';

      if doScriptsOnly then begin
        basePath := sf.ReadString('ExportScripts', 'BasePath', wbTempPath);
        extension := sf.ReadString('ExportScripts', 'Extension', '.geck');
      end else begin
        basePath := sf.ReadString('ExportTexts', 'BasePath', wbTempPath);
        extension := sf.ReadString('ExportTexts', 'Extension', '.txt');
      end;

      frm.Width := Screen.Width / 3 * 2;
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
      
      lb1 := TLabel.Create(frm);
      lb1.Parent := pnl;
      lb1.Left := 26;
      lb1.Top := 18;
      lb1.Caption := 'Path';
      lb1.Width := 80;
      
      ed1 := TEdit.Create(frm);
      ed1.Parent := pnl;
      ed1.Left := lb1.Left + lb1.width;
      ed1.Top := lb1.top;
      ed1.Width := frm.Width - lb1.Width - 60;
      ed1.Text := basePath;
      
      lb2 := TLabel.Create(frm);
      lb2.Parent := pnl;
      lb2.Left := lb1.Left;
      lb2.Top := lb1.Top + lb1.Height + 30;
      lb2.Caption := 'Extension';
      lb2.Width := lb1.Width;

      ed2 := TEdit.Create(frm);
      ed2.Parent := pnl;
      ed2.Left := lb2.Left + lb2.width;
      ed2.Top := lb2.top;
      ed2.Width := ed1.Width;
      ed2.Text := extension;
      
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
        basePath := ed1.Text;
        extension := ed2.Text;
        if doScriptsOnly then begin
          sf.WriteString('ExportScripts', 'BasePath', basePath);
          sf.WriteString('ExportScripts', 'Extension', extension);
        end else begin
          sf.WriteString('ExportTexts', 'BasePath', basePath);
          sf.WriteString('ExportTexts', 'Extension', extension);
        end;
      end;
    finally
      if doCloseSF then
        sf.Free;
      frm.Free;
    end;
  end;
  
end;

function Initialize: integer;
begin
  slText := TStringList.Create;
  sl := TStringList.Create;

  OptionsForm;

  if doStop then Exit;
  
  if Pos('\\?\', basePath)=0 then basePath := '\\?\'+basePath;  // allows program to handle very long file names
  debug := False;
  AddMessage('Using directory: "'+basePath+'" and extension: "'+extension+'"');
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
    // if debug then AddMessage('Processing: '+c+' at '+x);
    
    while (Length(x)>0) and (x[Length(x)]=' ') do Delete(x, 1, 1);
    ForceDirectories(x);
    if DirectoryExists(x) then begin
      x := x+c;
      while (Length(x)>0) and (x[Length(x)]=' ') do Delete(x, 1, 1);
      s := GetEditValue(e);
      slText.Text := s;
      // if debug then AddMessage('Checking: '+x);
      if FileExists(x) then begin
        if debug then AddMessage(x+' exists');
        sl.Clear;
        sl.LoadFromFile(x);
        if sl.Text <> slText.Text then begin
          // if debug then AddMessage(x+' modified');
          if doImport then
            SetEditValue(e, sl.Text)
          else
            try slText.SaveToFile(x); except end;
        end;
      end else begin
        // if debug then AddMessage(x+' created');
        if (not doImport) and (Length(s)>0) then
          try slText.SaveToFile(x); except end;
      end;
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
