{
  Find records in selection.
  
  Hotkey: Ctrl+F
}
unit userscript;

var
  frm: TForm;
  lbRecords: TCheckListBox;
  mnRecords: TPopupMenu;
  MenuItem: TMenuItem;
  chkHas: TCheckBox;
  btnFind, btnJump, btnCancel: TButton;
  edHas: TLabeledEdit;
  
  findMode: integer;
  findRecords: string;
  slHasElements: TStringList;
  slFound: TStringList;
  
//===========================================================================
// on key down event handler for options form
procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    TForm(Sender).ModalResult := mrYes;
  if Key = VK_ESCAPE then
    TForm(Sender).ModalResult := mrCancel;
end;
  
//===========================================================================
// on click event handler for "Select All" popup menu
procedure SelectAllClick(Sender: TObject);
begin
  lbRecords.CheckAll(cbChecked, True, True);
end;

//===========================================================================
// on click event handler for "Select None" popup menu
procedure SelectNoneClick(Sender: TObject);
begin
  lbRecords.CheckAll(cbUnchecked, True, True);
end;

//===========================================================================
// prepare search criterias
procedure PrepareData;
var
  i: integer;
begin
  for i := 0 to lbRecords.Items.Count - 1 do
    if lbRecords.Checked[i] then begin
      if findRecords <> '' then
        findRecords := findRecords + ',';
      findRecords := findRecords + Copy(lbRecords.Items[i], 1, 4);
    end;

  if findRecords = '' then
    Exit;
    
  if chkHas.Checked then begin
    slHasElements.DelimitedText := edHas.Text;
    for i := Pred(slHasElements.Count) downto 0 do begin
      slHasElements[i] := Trim(slHasElements[i]);
      if slHasElements[i] = '' then
        slHasElements.Delete(i);
    end;
  end;
end;

//===========================================================================
// show search options form
procedure OptionsForm;
var
  ini: TMemIniFile;
  s: string;
  i: integer;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Find records';
    frm.Width := 650;
    frm.Height := 400;
    frm.Position := poScreenCenter;
    frm.BorderStyle := bsDialog;
    frm.KeyPreview := True;
    frm.OnKeyDown := FormKeyDown;

    lbRecords := TCheckListBox.Create(frm);
    lbRecords.Parent := frm;
    lbRecords.Left := 8;
    lbRecords.Top := 8;
    lbRecords.Width := 240;
    lbRecords.Height := 350;
    GetRecordDefNames(lbRecords.Items);
    
    mnRecords := TPopupMenu.Create(frm);
    lbRecords.PopupMenu := mnRecords;
    MenuItem := TMenuItem.Create(mnRecords);
    MenuItem.Caption := 'Select &All';
    MenuItem.OnClick := SelectAllClick;
    mnRecords.Items.Add(MenuItem);
    MenuItem := TMenuItem.Create(mnRecords);
    MenuItem.Caption := 'Select &None';
    MenuItem.OnClick := SelectNoneClick;
    mnRecords.Items.Add(MenuItem);
  
    chkHas := TCheckBox.Create(frm);
    chkHas.Parent := frm;
    chkHas.Caption := 'Has Element(s)';
    chkHas.Left := 260;
    chkHas.Top := 8;

    edHas := TLabeledEdit.Create(frm);
    edHas.Parent := frm;
    edHas.LabelPosition := lpAbove;
    edHas.EditLabel.Caption := 'List of names as they appear when viewing record separated by comma';
    edHas.Left := chkHas.Left + 16;
    edHas.Top := chkHas.Top + 36;
    edHas.Width := 350;

    btnFind := TButton.Create(frm);
    btnFind.Parent := frm;
    btnFind.Caption := 'Find all records';
    btnFind.ModalResult := mrOk;
    btnFind.Width := 130;
    btnFind.Left := 260;
    btnFind.Top := 332;
    
    btnJump := TButton.Create(frm);
    btnJump.Parent := frm;
    btnJump.Caption := 'Jump to first matched';
    btnJump.ModalResult := mrYes;
    btnJump.Width := 130;
    btnJump.Left := btnFind.Left + btnFind.Width + 16;
    btnJump.Top := btnFind.Top;

    btnCancel := TButton.Create(frm);
    btnCancel.Parent := frm;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := btnJump.Left + btnJump.Width + 16;
    btnCancel.Top := btnFind.Top;

    // read settings from ini file
    ini := TMemIniFile.Create(ScriptsPath + 'Find records.ini');
    s := ini.ReadString(wbGameName, 'Records', '');
    for i := 0 to Pred(lbRecords.Items.Count) do
      if Pos(Copy(lbRecords.Items[i], 1, 4), s) > 0 then
        lbRecords.Checked[i] := True;
    chkHas.Checked := ini.ReadBool(wbGameName, 'DoHasElements', chkHas.Checked);
    edHas.Text := ini.ReadString(wbGameName, 'HasElements', edHas.Text);
    
    findMode := 0;
    i := frm.ShowModal;
    if i = mrOk then findMode := 1 else
      if i = mrYes then findMode := 2;
     
    // prepare search data and write settings to ini file
    if findMode <> 0 then begin
      PrepareData;
      ini.WriteString(wbGameName, 'Records', findRecords);
      ini.WriteBool(wbGameName, 'DoHasElements', chkHas.Checked);
      ini.WriteString(wbGameName, 'HasElements', edHas.Text);
      ini.UpdateFile;
    end;

  finally
    frm.Free;
    if Assigned(ini) then ini.Free;
  end;
end;

//===========================================================================
// Free memory
procedure CleanUp;
begin
  slHasElements.Free;
  slFound.Free;
end;

//===========================================================================
function Initialize: Integer;
begin
  slHasElements := TStringList.Create;
  slHasElements.Delimiter := ',';
  slHasElements.StrictDelimiter := true;

  slFound := TStringList.Create;

  OptionsForm;

  if findMode = 0 then begin
    Result := 1;
  end else
  if findRecords = '' then begin
    AddMessage('No records selected.');
    Result := 1;
  end;
  
  if Result <> 0 then
    CleanUp;
end;

//===========================================================================
function Process(e: IInterface): Integer;
var
  i: integer;
  matched: boolean;
begin
  if Pos(Signature(e), findRecords) = 0 then
    Exit;
  
  for i := 0 to Pred(slHasElements.Count) do
    if ElementExists(e, slHasElements[i]) then begin
      matched := True;
      Break;
    end;

  if matched then
    if findMode = 1 then
      slFound.Add(Name(GetFile(e)) + ' - ' + Name(e))
    else
    if findMode = 2 then begin
      JumpTo(e, True);
      Result := 1;
      CleanUp;
      Exit;
    end;
end;

//===========================================================================
function Finalize: Integer;
begin
  if slFound.Count > 0 then begin
    if MessageDlg(Format('Found %d records. Show them in messages?', [slFound.Count]), mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
      AddMessage(slFound.Text);
  end else
    AddMessage('No matching records found.');

  CleanUp;
end;


end.