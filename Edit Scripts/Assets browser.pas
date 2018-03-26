{
  Assets browser.
  Searches for files in Data folder and load BSA/BA2 archives.
  Allows to open files with associated apps, unpack single file
  and multifile unpack/copy preserving paths.
  
  Hotkey: Ctrl+F3
  Mode: Silent
}

unit AssetsBrowser;

var
  slContainers, slResList, sl: TStringList;
  slAssets, slItems, slTextures: TwbFastStringList;
  SaveAsFolder: string;
  frm: TForm;
  edFilter: TLabeledEdit;
  edClipboard: TEdit;
  lblItems: TLabel;
  cmbContainer: TComboBox;
  lvAssets: TListView;
  mInfo: TMemo;
  mnPopup: TPopupMenu;
  MenuItem: TMenuItem;


//===========================================================================
// reduce container name to BSA file name or 'Data'
function SimpleName(aName: string): string;
begin
  Result := ExtractFileName(aName);
  if Result = '' then
    Result := 'Data';
end;

//===========================================================================
// reduce the current selected container
function SelectedContainer: string;
begin
  if cmbContainer.ItemIndex = 0 then
    Result := ''
  else
    Result := slContainers[Pred(cmbContainer.ItemIndex)];
end;

//===========================================================================
// load list of files from container
procedure LoadAssetsList(aIndex: integer);
var
  i: integer;
begin
  slAssets.Clear;
  for i := 0 to Pred(slContainers.Count) do
    if (aIndex = 0) or (Pred(aIndex) = i) then
      ResourceList(slContainers[i], slAssets);
  slAssets.Sort;
  wbRemoveDuplicateStrings(slAssets);
end;
  
//===========================================================================
// open asset (unpack to temp file and execute)
procedure AssetOpen(aContainerName, aFileName: string);
var
  f: string;
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
      ResourceCopy(aContainerName, aFileName, f);
    except
      on E: Exception do begin
        MessageDlg(E.Message, mtError, [mbOk], 0);
        Exit;
      end;
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
  dlgSave: TSaveDialog;
begin
  dlgSave := TSaveDialog.Create(nil);
  try
    dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
    dlgSave.InitialDir := SaveAsFolder;
    dlgSave.FileName := ExtractFileName(aFileName);
    if dlgSave.Execute then begin
      SaveAsFolder := ExtractFilePath(dlgSave.FileName);
      try
        ResourceCopy(aContainerName, aFileName, dlgSave.FileName);
      except
        on E: Exception do begin
          MessageDlg(E.Message, mtError, [mbOk], 0);
          Exit;
        end;
      end;
    end;
  finally
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
  // close on ESC
  if Key = VK_ESCAPE then
    TForm(Sender).ModalResult := mrOk
  // copy selected file name to clipboard on Ctr+C
  else if (Shift = [ssCtrl]) and (Key = 67{C}) then begin
    if lvAssets.Focused and Assigned(lvAssets.Selected) then
      CopyClipboardClick(Sender);
  end;
end;

//===========================================================================
// on change event for container selection
procedure cmbContainerOnChange(Sender: TObject);
begin
  LoadAssetsList(cmbContainer.ItemIndex);
  FilterAssets;
  lvAssets.SetFocus;
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
  f, cont, ext, fname: string;
  nif: TwbNifFile;
  dds: TwbDDSFile;
  bgsm: TwbBGSMFile;
  bgem: TwbBGEMFile;
  lodfo3: TwbLODSettingsFO3File;
  lodtes5: TwbLODSettingsTES5File;
  lst: TwbLODTreeLSTFile;
  btt: TwbLODTreeBTTFile;
begin
  if not Selected then Exit;
  f := Item.Caption;
  ext := ExtractFileExt(f);
  cont := SelectedContainer;
  fname := SimpleName(cont) + '\' + f;

  if SameText(ext, '.nif') then begin
    nif := TwbNifFile.Create;
    try
      nif.LoadFromResource(cont, f);
      nif.GetAssetsList(slTextures);
    finally
      nif.Free;
    end;
    mInfo.Lines.BeginUpdate;
    mInfo.Clear;
    mInfo.Lines.Add('Assets used in "' + fname + '":'#13#10);
    mInfo.Lines.AddStrings(slTextures);
    mInfo.Lines.EndUpdate;
    slTextures.Clear;
  end

  else if SameText(ext, '.dds') then begin
    dds := TwbDDSFile.Create;
    try
      dds.LoadFromResource(cont, f);
      mInfo.Lines.Text := fname + #13#10 + dds.ToText;
    finally
      dds.Free;
    end;
  end
  
  else if SameText(ext, '.bgsm') then begin
    bgsm := TwbBGSMFile.Create;
    try
      bgsm.LoadFromResource(cont, f);
      mInfo.Lines.Text := fname + #13#10 + bgsm.ToText;
    finally
      bgsm.Free;
    end;
  end
  
  else if SameText(ext, '.bgem') then begin
    bgem := TwbBGEMFile.Create;
    try
      bgem.LoadFromResource(cont, f);
      mInfo.Lines.Text := fname + #13#10 + bgem.ToText;
    finally
      bgem.Free;
    end;
  end

  else if SameText(ext, '.lod') then begin
    lodtes5 := TwbLODSettingsTES5File.Create;
    try
      lodtes5.LoadFromResource(cont, f);
      mInfo.Lines.Text := fname + #13#10 + lodtes5.ToText;
    finally
      lodtes5.Free;
    end;
  end

  else if SameText(ext, '.dlodsettings') then begin
    lodfo3 := TwbLODSettingsFO3File.Create;
    try
      lodfo3.LoadFromResource(cont, f);
      mInfo.Lines.Text := fname + #13#10 + lodfo3.ToText;
    finally
      lodfo3.Free;
    end;
  end
  
  else if SameText(ext, '.lst') then begin
    lst := TwbLODTreeLSTFile.Create;
    try
      lst.LoadFromResource(cont, f);
      mInfo.Lines.Text := fname + #13#10 + lst.ToText;
    finally
      lst.Free;
    end;
  end
  
  else if SameText(ext, '.btt') or SameText(ext, '.dtl') then begin
    btt := TwbLODTreeBTTFile.Create;
    try
      btt.LoadFromResource(cont, f);
      mInfo.Lines.Text := fname + #13#10 + btt.ToText;
    finally
      btt.Free;
    end;
  end;
end;

//===========================================================================
// on double click event handler for assets
procedure lvAssetsDblClick(Sender: TObject);
begin
  if Assigned(lvAssets.Selected) then
    AssetOpen(SelectedContainer, lvAssets.Selected.Caption);
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
  aContainerName := SelectedContainer;
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
  pnl: TPanel;
  sp: TSplitter;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := wbGameName + ' Assets Browser';
    frm.Width := 950;
    frm.Height := 600;
    frm.Position := poScreenCenter;
    frm.KeyPreview := True;
    frm.OnKeyDown := FormKeyDown;

    pnl := TPanel.Create(frm); pnl.Parent := frm;
    pnl.Height := 38;
    pnl.Align := alTop;
    pnl.BevelOuter := bvNone;

    edFilter := TLabeledEdit.Create(frm); edFilter.Parent := pnl;
    edFilter.LabelPosition := lpLeft;
    edFilter.EditLabel.Caption := 'Filter';
    edFilter.Left := 36;
    edFilter.Top := 8;
    edFilter.Width := 250;
    edFilter.OnChange := edFilterOnChange;

    // invisible edit field used to copy to clipboard
    edClipboard := TEdit.Create(frm); edClipboard.Parent := pnl;
    edClipboard.Visible := False;

    lblItems := TLabel.Create(frm); lblItems.Parent := pnl;
    lblItems.Top := 12;
    lblItems.Left := edFilter.Left + edFilter.Width + 24;

    cmbContainer := TComboBox.Create(frm); cmbContainer.Parent := pnl;
    cmbContainer.Left := pnl.Width - 312;
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

    lvAssets := TListView.Create(frm); lvAssets.Parent := frm;
    lvAssets.Top := pnl.Top + pnl.Height + 10; // make sure it aligns after the top panel
    lvAssets.Height := frm.Height - 300;
    lvAssets.Align := alTop;
    lvAssets.BorderStyle := bsNone;
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

    sp := TSplitter.Create(frm); sp.Parent := frm;
    sp.Align := alTop;
    sp.Height := 5;

    mInfo := TMemo.Create(frm); mInfo.Parent := frm;
    mInfo.Align := alClient;
    mInfo.BorderStyle := bsNone;
    mInfo.ScrollBars := ssVertical;
    mInfo.ReadOnly := True;
    mInfo.Lines.Text := 'Additional information'#13#13'Usage:'#13'Right click - Actions menu'#13'Double click - Open action'#13'Ctrl+C - Copy selected file name to clipboard'#13'Esc - Exit';

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
  
  slAssets := TwbFastStringList.Create;
  slTextures := TwbFastStringList.Create;
  slTextures.Sorted := True;
  slTextures.Duplicates := dupIgnore;

  slItems := TwbFastStringList.Create;
  slResList := TStringList.Create;
  sl := TStringList.Create;
  
  SaveAsFolder := wbDataPath;

  if not wbLoadBSAs then
    MessageDlg('Loading of BSA archives is disabled in xEdit options, only files in Data folder will be shown', mtInformation, [mbOk], 0);

  ResourceContainerList(slContainers);
  AddMessage('Assets Browser: loading resources, please wait...');
  LoadAssetsList(0);
    
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