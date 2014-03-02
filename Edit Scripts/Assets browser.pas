{
  Assets browser.
  Searches for files in Data folder and inside BSA archives.
  Allows to open files with associated apps, unpack single file
  and multifile unpack/copy preserving paths.
  
  Hotkey: Ctrl+F3
}

unit AssetsBrowser;

var
  slContainers, slResList, sl: TStringList;
  slAssets, slItems, slTextures: THashedStringList;
  frm: TForm;
  edFilter: TLabeledEdit;
  edClipboard: TEdit;
  lblItems, lblInfo, lblHelp: TLabel;
  cmbContainer: TComboBox;
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
// load list of files from container
procedure LoadAssetsList(aIndex: integer);
var
  i: integer;
begin
  slAssets.Clear;
  AddMessage('Loading resources, please wait...');
  for i := 0 to Pred(slContainers.Count) do
    if (aIndex = 0) or (Pred(aIndex) = i) then begin
      //AddMessage('Loading files list from ' + SimpleName(slContainers[i]));
      ResourceList(slContainers[i], slAssets);
    end;
  AddMessage('Done.');
end;
  
//===========================================================================
// open asset (unpack to temp file and execute)
procedure AssetOpen(aContainerName, aFileName: string);
var
  f: string;
  bs: TBytesStream;
  fs: TFileStream;
begin
  // unpack file if not present
  ResourceCount(aFileName, slResList);
  if aContainerName = '' then
   aContainerName := slResList[slResList.Count - 1];
  if SimpleName(aContainerName) = 'Data' then
    // container name is the real path, so just append file name
    f := aContainerName + aFileName
  else begin
    f := TempPath + ExtractFileName(aFileName);
    try
      bs := TBytesStream.Create(ResourceOpenData(aContainerName, aFileName));
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
procedure AssetSaveAs(aContainerName, aFileName: string);
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
      bs := TBytesStream.Create(ResourceOpenData(aContainerName, aFileName));
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
// on change event for container selection
procedure cmbContainerOnChange(Sender: TObject);
begin
  LoadAssetsList(cmbContainer.ItemIndex);
  FilterAssets;
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
    NifTextureList(ResourceOpenData('', f), sl);
    slTextures.AddStrings(sl); // remove duplicates
    mInfo.Lines.BeginUpdate;
    mInfo.Clear;
    mInfo.Lines.Add('TEXTURES USED IN "' + ExtractFileName(f) + '" (only for Skyrim meshes):');
    mInfo.Lines.AddStrings(slTextures);
    mInfo.Lines.EndUpdate;
    slTextures.Clear;
  end;
end;

//===========================================================================
// on double click event handler for assets
procedure lvAssetsDblClick(Sender: TObject);
begin
  if not Assigned(lvAssets.Selected) then
    Exit;
  // open from last container
  AssetOpen('', lvAssets.Selected.Caption);
end;

//===========================================================================
// on click event handler for "Open" popup menu
procedure OpenClick(Sender: TObject);
begin
  ResourceCount(lvAssets.Selected.Caption, slResList);
  AssetOpen(slResList[TMenuItem(Sender).Tag], lvAssets.Selected.Caption);
end;

//===========================================================================
// on click event handler for "Save As" popup menu
procedure SaveAsClick(Sender: TObject);
begin
  ResourceCount(lvAssets.Selected.Caption, slResList);
  AssetSaveAs(slResList[TMenuItem(Sender).Tag], lvAssets.Selected.Caption);
end;

//===========================================================================
// on click event handler for "Copy All" popup menu
procedure CopyAllClick(Sender: TObject);
var
  i: integer;
  aPath, aContainerName: string;
begin
  aPath := SelectDirectory('Destination path to copy files to', '', '', nil);
  if aPath = '' then
    Exit;
  // if container is selected, then copy files from that container
  if cmbContainer.ItemIndex = 0 then aContainerName := '' else
    aContainerName := slContainers[Pred(cmbContainer.ItemIndex)];
  AddMessage('Copying files, please wait...');
  try
    for i := 0 to Pred(slItems.Count) do
      // const aContainerName, aFileName, aPathOut: string
      // empty container means last (winning) container for each file
      ResourceCopy(aContainerName, slItems[i], aPath);
    AddMessage('Done.');
  except
    on E: Exception do
      AddMessage('Error copying file ' + slItems[i] + ': ' + E.Message);
  end;
end;

//===========================================================================
// on click event handler for "Copy to clpboard" popup menu
procedure CopyClipboardClick(Sender: TObject);
begin
  edClipboard.Text := lvAssets.Selected.Caption;
  edClipboard.SelectAll;
  edClipboard.CopyToClipboard;
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
  MenuItem := TMenuItem.Create(mnPopup); MenuItem.Caption := '-'; mnPopup.Items.Add(MenuItem);
  for i := Pred(slResList.Count) downto 0 do begin
    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := 'Saves As (from ' + SimpleName(slResList[i]) + ')';
    MenuItem.OnClick := SaveAsClick;
    MenuItem.Tag := i;
    mnPopup.Items.Add(MenuItem);
  end;
  MenuItem := TMenuItem.Create(mnPopup); MenuItem.Caption := '-'; mnPopup.Items.Add(MenuItem);
  MenuItem := TMenuItem.Create(mnPopup);
  MenuItem.Caption := 'Copy All to...';
  MenuItem.OnClick := CopyAllClick;
  mnPopup.Items.Add(MenuItem);
  MenuItem := TMenuItem.Create(mnPopup); MenuItem.Caption := '-'; mnPopup.Items.Add(MenuItem);
  MenuItem := TMenuItem.Create(mnPopup);
  MenuItem.Caption := 'Copy name to clipboard';
  MenuItem.OnClick := CopyClipboardClick;
  mnPopup.Items.Add(MenuItem);
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

    // invisible edit field used to copy to clipboard
    edClipboard := TEdit.Create(frm);
    edClipboard.Parent := frm;
    edClipboard.Visible := False;

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
    lvAssets.DoubleBuffered := True;
    lvAssets.RowSelect := True;
    lvAssets.Columns.Add.Caption := 'File Name';
    lvAssets.Columns[0].Width := lvAssets.Width - 240;
    lvAssets.Columns.Add.Caption := 'Containers';
    lvAssets.Columns[1].Width := 200;
    lvAssets.OwnerData := True;
    lvAssets.OnData := lvAssetsData;
    lvAssets.OnSelectItem := lvAssetsSelectItem;
    lvAssets.OnDblClick := lvAssetsDblClick;
   
    cmbContainer := TComboBox.Create(frm);
    cmbContainer.Parent := frm;
    cmbContainer.Left := lvAssets.Left + lvAssets.Width - 300;
    cmbContainer.Top := edFilter.Top;
    cmbContainer.Width := 300;
    cmbContainer.Style := csDropDownList;
    cmbContainer.DropDownCount := 20;
    cmbContainer.Anchors := [akTop, akRight];
    cmbContainer.OnChange := cmbContainerOnChange;
    cmbContainer.Items.Add('All containers');
    for i := 0 to Pred(slContainers.Count) do
      cmbContainer.Items.Add(SimpleName(slContainers[i]));
    cmbContainer.ItemIndex := 0;

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
    btnClose.Left := lblHelp.Left + 10;
    btnClose.Width := 120;
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
begin
  slContainers := TStringList.Create;
  
  slAssets := THashedStringList.Create;
  slAssets.Sorted := True;
  slAssets.Duplicates := dupIgnore;

  slTextures := THashedStringList.Create;
  slTextures.Sorted := True;
  slTextures.Duplicates := dupIgnore;

  slItems := THashedStringList.Create;
  slResList := TStringList.Create;
  sl := TStringList.Create;

  if not wbLoadBSAs then
    MessageDlg('Loading of BSA archives is disabled in xEdit options, only files in Data folder will be shown', mtInformation, [mbOk], 0);

  ResourceContainerList(slContainers);
  LoadAssetsList(0);
    
  AddMessage('Opening browser...');
  
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