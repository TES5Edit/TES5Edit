{
  Assets browser.
  
  Hotkey: Ctrl+F3
}

unit userscript;

var
  slContainers, slResList, sl: TStringList;
  slAssets, slItems, slTextures: TwbFastStringList;
  frm: TForm;
  edFilter: TLabeledEdit;
  lblItems, lblInfo, lblHelp: TLabel;
  lvAssets: TListView;
  mInfo: TMemo;
  mnPopup: TPopupMenu;
  MenuItem: TMenuItem;
  btnClose: TButton;


//===========================================================================
// reduce container name to BSA file name or 'Data'
function SimpleName(aName: string): string;
begin
  Result := ExtractFileName(aName);
  if Result = '' then
    Result := 'Data';
end;
  
//===========================================================================
// open asset (unpack to temp file and execute)
procedure AssetOpen(aFileName: string; aContainerIndex: integer);
var
  f: string;
  bs: TBytesStream;
  fs: TFileStream;
begin
  // unpack file if not present
  ResourceCount(aFileName, slResList);
  if aContainerIndex = -1 then
   aContainerIndex := slResList.Count - 1;
  if SimpleName(slResList[aContainerIndex]) = 'Data' then
    f := slResList[aContainerIndex] + aFileName
  else begin
    f := TempPath + ExtractFileName(aFileName);
    try
      bs := TBytesStream.Create(ResourceOpenData(aFileName, aContainerIndex));
      try
        ForceDirectories(TempPath); // TempPath folder is removed by xEdit upon exit
        fs := TFileStream.Create(f, fmCreate);
        fs.CopyFrom(bs, 0);
      except
        on E: Exception do
          MessageDlg(E.Message, mtError, [mbOk], 0);
      end;
    finally
      if Assigned(bs) then bs.Free;
      if Assigned(fs) then fs.Free;
    end;
  end;
  // error 31 - no associated application
  if ShellExecute(TForm(frmMain).Handle, 'open', f, '', '', SW_SHOWNORMAL) = 31 then
    ShellExecute(TForm(frmMain).Handle, 'openas', f, '', '', SW_SHOWNORMAL);
end;

//===========================================================================
// save asset as
procedure AssetSaveAs(aFileName: string; aContainerIndex: integer);
var
  bs: TBytesStream;
  fs: TFileStream;
  dlgSave: TSaveDialog;
begin
  dlgSave := TSaveDialog.Create(nil);
  try
    dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
    dlgSave.InitialDir := DataPath;
    dlgSave.FileName := ExtractFileName(aFileName);
    if dlgSave.Execute then begin
      bs := TBytesStream.Create(ResourceOpenData(aFileName, aContainerIndex));
      try
        fs := TFileStream.Create(dlgSave.FileName, fmCreate);
        fs.CopyFrom(bs, 0);
      except
        on E: Exception do
          MessageDlg(E.Message, mtError, [mbOk], 0);
      end;
    end;
  finally
    if Assigned(bs) then bs.Free;
    if Assigned(fs) then fs.Free;
    dlgSave.Free;
  end;
end;

//===========================================================================
// listview custom data event
procedure lvAssetsData(Sender: TObject; Item: TListItem);
var
  s, cont: string;
  i: integer;
begin
  Item.Caption := slItems[Item.Index];
  if ResourceCount(slItems[Item.Index], slResList) = 0 then
    Exit;
  for i := Pred(slResList.Count) downto 0 do begin
    if cont <> '' then cont := cont + ', ';
    cont := cont + SimpleName(slResList[i]);
  end;
  Item.SubItems.Add(cont);
  slResList.Clear;
end;

//===========================================================================
procedure FilterAssets;
var
  filter: string;
begin
  slItems.Clear;
  filter := LowerCase(edFilter.Text);

  if filter = '' then
    slItems.AddStrings(slAssets)
  else
    wbFilterStrings(slAssets, slItems, filter);

  lvAssets.Items.Count := slItems.Count;
  lvAssets.Refresh;
  lblItems.Caption := Format('%.0n file(s)', [slItems.Count + 0.0]);
end;

//===========================================================================
// on key down event handler for form
procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    TForm(Sender).ModalResult := mrOk;
end;

//===========================================================================
// on key down event handler for filter
procedure edFilterOnChange(Sender: TObject);
begin
  FilterAssets;
end;
  
//===========================================================================
// on select item event handler for assets
procedure lvAssetsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  f, ext: string;
begin
  if not Selected then Exit;
  f := Item.Caption;
  ext := ExtractFileExt(f);
  if SameText(ext, '.nif') then begin
    NifTextureList(ResourceOpenData(f, -1), sl);
    slTextures.AddStrings(sl); // remove duplicates
    mInfo.Lines.BeginUpdate;
    mInfo.Clear;
    mInfo.Lines.Add('TEXTURES USED IN "' + ExtractFileName(f) + '" (only for Skyrim meshes):');
    mInfo.Lines.AddStrings(slTextures);
    mInfo.Lines.EndUpdate;
    slTextures.Clear;
  end;
  //lblItems.Caption := Item.Caption;
end;

//===========================================================================
// on double click event handler for assets
procedure lvAssetsDblClick(Sender: TObject);
begin
  if not Assigned(lvAssets.Selected) then
    Exit;
  AssetOpen(lvAssets.Selected.Caption, -1);
end;

//===========================================================================
// on click event handler for "Open" popup menu
procedure OpenClick(Sender: TObject);
begin
  AssetOpen(lvAssets.Selected.Caption, TMenuItem(Sender).Tag);
end;

//===========================================================================
// on click event handler for "Save As" popup menu
procedure SaveAsClick(Sender: TObject);
begin
  AssetSaveAs(lvAssets.Selected.Caption, TMenuItem(Sender).Tag);
end;

//===========================================================================
// on popup menu event handler
procedure MenuPopup(Sender: TObject);
var
  i: integer;
begin
  mnPopup.Items.Clear;
  if not Assigned(lvAssets.Selected) then
    Exit;
  ResourceCount(lvAssets.Selected.Caption, slResList);
  for i := Pred(slResList.Count) downto 0 do begin
    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := 'Open (from ' + SimpleName(slResList[i]) + ')';
    MenuItem.OnClick := OpenClick;
    MenuItem.Tag := i;
    mnPopup.Items.Add(MenuItem);
  end;
  for i := Pred(slResList.Count) downto 0 do begin
    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := 'Saves As (from ' + SimpleName(slResList[i]) + ')';
    MenuItem.OnClick := SaveAsClick;
    MenuItem.Tag := i;
    mnPopup.Items.Add(MenuItem);
  end;
end;

//===========================================================================
procedure ShowBrowser;
var
  i: integer;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := wbGameName + ' Assets Browser';
    frm.Width := 900;
    frm.Height := 550;
    frm.Position := poScreenCenter;
    frm.KeyPreview := True;
    frm.OnKeyDown := FormKeyDown;

    edFilter := TLabeledEdit.Create(frm);
    edFilter.Parent := frm;
    edFilter.LabelPosition := lpLeft;
    edFilter.EditLabel.Caption := 'Filter';
    edFilter.Left := 36;
    edFilter.Top := 8;
    edFilter.Width := 250;
    edFilter.OnChange := edFilterOnChange;

    lblItems := TLabel.Create(frm);
    lblItems.Parent := frm;
    lblItems.Top := 12;
    lblItems.Left := edFilter.Left + edFilter.Width + 24;

    lvAssets := TListView.Create(frm);
    lvAssets.Parent := frm;
    lvAssets.Left := 8;
    lvAssets.Top := 34;
    lvAssets.Width := frm.Width - 20;
    lvAssets.Height := 330;
    lvAssets.Anchors := [akLeft, akTop, akRight, akBottom];
    lvAssets.ReadOnly := True;
    lvAssets.ViewStyle := vsReport;
    lvAssets.Columns.Add.Caption := 'File Name';
    lvAssets.Columns[0].Width := lvAssets.Width - 240;
    lvAssets.Columns.Add.Caption := 'Containers';
    lvAssets.Columns[1].Width := 200;
    lvAssets.OwnerData := True;
    lvAssets.OnData := lvAssetsData;
    lvAssets.OnSelectItem := lvAssetsSelectItem;
    lvAssets.OnDblClick := lvAssetsDblClick;
   
    mInfo := TMemo.Create(frm);
    mInfo.Parent := frm;
    mInfo.Left := 8;
    mInfo.Top := lvAssets.Top + lvAssets.Height + 24;
    mInfo.Width := lvAssets.Width - 160;
    mInfo.Height := 150;
    mInfo.Anchors := [akLeft, akRight, akBottom];
    mInfo.ScrollBars := ssVertical;
    mInfo.ReadOnly := True;

    lblInfo := TLabel.Create(frm);
    lblInfo.Parent := frm;
    lblInfo.Top := mInfo.Top - 16;
    lblInfo.Left := mInfo.Left;
    lblInfo.Anchors := [akLeft, akBottom];
    lblInfo.Caption := 'Additional information';

    lblHelp := TLabel.Create(frm);
    lblHelp.Parent := frm;
    lblHelp.Top := mInfo.Top;
    lblHelp.Left := mInfo.Left + mInfo.Width + 16;
    lblHelp.Anchors := [akRight, akBottom];
    lblHelp.Caption := 'Usage:'#13'Right click - actions menu'#13'Double click - open action'#13'Esc - exit';

    btnClose := TButton.Create(frm);
    btnClose.Parent := frm;
    btnClose.Top := mInfo.Top + mInfo.Height - btnClose.Height;
    btnClose.Left := lblHelp.Left + 20;
    btnClose.Width := 100;
    btnClose.Caption := 'Close';
    btnClose.Anchors := [akRight, akBottom];
    btnClose.ModalResult := mrOk;
    
    mnPopup := TPopupMenu.Create(frm);
    mnPopup.OnPopup := MenuPopup;
    lvAssets.PopupMenu := mnPopup;
    
    FilterAssets;

    frm.ShowModal;
  finally
    frm.Free;
  end;
end;

//===========================================================================
function Initialize: integer;
var
  i: Integer;
begin
  slContainers := TStringList.Create;
  ResourceContainerList(slContainers);
  
  slAssets := TwbFastStringList.Create;
  slAssets.Sorted := True;
  slAssets.Duplicates := dupIgnore;

  slTextures := TwbFastStringList.Create;
  slTextures.Sorted := True;
  slTextures.Duplicates := dupIgnore;

  slItems := TwbFastStringList.Create;
  slResList := TStringList.Create;
  sl := TStringList.Create;

  if not wbLoadBSAs then
    MessageDlg('You disabled loading of BSA archives in xEdit options, only loose files will be shown', mtInformation, [mbOk], 0);

  AddMessage('Loading resources, please wait...');
  //for i := 0 to 2 do begin
  for i := 0 to Pred(slContainers.Count) do begin
    AddMessage('Loading files list from ' + SimpleName(slContainers[i]));
    ResourceList(slContainers[i], slAssets);
  end;

  AddMessage('Done. Opening browser...');
  
  ShowBrowser;
  
  slAssets.Free;
  slItems.Free;
  slContainers.Free;
  slResList.Free;
  slTextures.Free;
  sl.Free;
  Result := 1;
end;

end.