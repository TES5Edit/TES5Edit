{
  Saves a plugin under a different name.
  
  Mode: Silent
  Hotkey: F5
}
unit SaveAs;

var
  PluginFile: IInterface;
  PluginName, PluginNameNew: string;

  frm: TForm;
  edFileName: TLabeledEdit;
  btnFileName, btnOk, btnCancel: TButton;
  chkReset: TCheckBox;

//===========================================================================
procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // close on Escape
  if Key = VK_ESCAPE then
    TForm(Sender).ModalResult := mrCancel;
end;

//===========================================================================
procedure btnFileNameClick(Sender: TObject);
var
  dlgSave: TSaveDialog;
begin
  dlgSave := TSaveDialog.Create(nil);
  try
    dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
    dlgSave.Filter := 'Plugin files (*.esp)|*.esp|Master files (*.esm)|*.esm';
    dlgSave.InitialDir := wbDataPath;
    dlgSave.FileName := ExtractFileName(edFileName.Text);
    if dlgSave.Execute then begin
      PluginNameNew := dlgSave.FileName;
      if dlgSave.FilterIndex = 1 then
        PluginNameNew := ChangeFileExt(PluginNameNew , '.esp')
      else if dlgSave.FilterIndex = 2 then
        PluginNameNew := ChangeFileExt(PluginNameNew , '.esm');

      edFileName.Text := PluginNameNew;
    end;
  finally
    dlgSave.Free;
  end;
  btnOk.SetFocus;
end;

//===========================================================================
procedure SavePlugin(aFile: IInterface; aFileName: string; aReset: Boolean);
var
  fs: TFileStream;
  fdate: Integer;
begin
  if FileExists(aFileName) then
    fdate := FileAge(aFileName);

  fs := TFileStream.Create(aFileName, fmCreate);
  try
    FileWriteToStream(aFile, fs, aReset);
  finally
    fs.Free;
  end;

  // restore original file date for games that use it for load order sorting
  if (fdate <> 0) and ((wbGameMode = gmTES4) or (wbGameMode = gmFO3) or (wbGameMode = gmFNV)) then try
    FileSetDate(aFileName, fdate);
  except
    on E: Exception do
      AddMessage('Can not change file date to original one: ' + E.Message);
  end;
end;

//===========================================================================
procedure SaveForm;
var
  ini: TMemIniFile;
begin
  ini := TMemIniFile.Create(wbScriptsPath + 'SaveAs.ini');
  PluginNameNew := ini.ReadString(wbGameName, PluginName, PluginNameNew);
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Save as (press ESC to Cancel)';
    frm.Width := 700;
    frm.Height := 140;
    frm.Position := poMainFormCenter;
    frm.BorderStyle := bsDialog;
    frm.KeyPreview := True;
    frm.OnKeyDown := FormKeyDown;

    edFileName := TLabeledEdit.Create(frm); edFileName.Parent := frm;
    edFileName.Left := 12;
    edFileName.Top := 28;
    edFileName.Width := frm.Width - 70;
    edFileName.ReadOnly := True;
    edFileName.EditLabel.Caption := 'Save ' + PluginName + ' as';
    edFileName.Text := PluginNameNew;

    btnFileName := TButton.Create(frm); btnFileName.Parent := frm;
    btnFileName.Top := edFileName.Top - 1;
    btnFileName.Left := edFileName.Left + edFileName.Width + 6;
    btnFileName.Width := 32;
    btnFileName.Height := 22;
    btnFileName.Caption := '...';
    btnFileName.OnClick := btnFileNameClick;

    chkReset := TCheckBox.Create(frm); chkReset.Parent := frm;
    chkReset.Left := edFileName.Left;
    chkReset.Top := edFileName.Top + 28;
    chkReset.Width := 200;
    chkReset.Caption := 'Reset modified status';
    chkReset.Checked := False; // ini.ReadBool('Settings', 'ResetModified', chkReset.Checked);
    chkReset.Visible := False; // doesn't work properly

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

    if frm.ShowModal <> mrOk then
      Exit;

    ini.WriteBool('Settings', 'ResetModified', chkReset.Checked);
    ini.WriteString(wbGameName, PluginName, PluginNameNew);
    try
      ini.UpdateFile;
    except
      AddMessage('Can not save settings, no write access to ' + ini.FileName);
    end;

    AddMessage('Saving: ' + PluginNameNew);
    try
      SavePlugin(PluginFile, PluginNameNew, chkReset.Checked);
      AddMessage('Done saving.');
    except
      on E: Exception do begin
        AddMessage('Error: ' + E.Message);
        MessageDlg('Error: ' + E.Message, mtError, [mbOk], 0);
      end;
    end;
    
  finally
    ini.Free;
    frm.Free;
  end;
end;  
  
//===========================================================================
function Process(e: Integer): Integer;
begin
  Result := 1;

  PluginFile := GetFile(e);
  PluginName := GetFileName(PluginFile);
  if GetLoadOrder(PluginFile) = 0 then begin
    AddMessage('Can''t save the game master file.');
    Exit;
  end;

  PluginNameNew := wbDataPath + ChangeFileExt(PluginName, '') + ' Copy' + ExtractFileExt(PluginName);
  SaveForm;
end;

end.
