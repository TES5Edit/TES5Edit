{
  Assets manager.

  Allows to check existence of used assets including textures in meshes,
  and copy assets used by plugin to separate folder.
}
unit AssetsManager;

const
  // asset type
  atMesh = 1;
  atTexture = 2;
  atSound = 4;
  atMusic = 8;
  atScript = 16;
  atScriptSource = 32;
  atSeqFile = 64;
  // work mode
  wmNone = 0;
  wmCheck = 1;
  wmCopy = 2;

var
  slAssetsType, slAssetsExt, sl, slRes: TStringList;
  slContainers, slTextures: TwbFastStringList;
  CurrentRecord: IInterface;
  optAsset, optMode: integer;
  optPath: string;

  frm: TForm;
  lbl: TLabel;
  clbAssets, clbContainers: TCheckListBox;
  mnPopup: TPopupMenu;
  MenuItem: TMenuItem;
  rbModeCheck, rbModeCopy: TRadioButton;
  edPath: TLabeledEdit;
  btnPath, btnOk, btnCancel: TButton;

  
//===========================================================================
procedure PopupMenuClick(Sender: TObject);
begin
  if TMenuItem(Sender).Tag = 1 then
    clbContainers.CheckAll(cbChecked, False, False)
  else
    clbContainers.CheckAll(cbUnChecked, False, False);
end;

//===========================================================================
procedure rbModeClick(Sender: TObject);
begin
  edPath.Enabled := rbModeCopy.Checked;
  btnPath.Enabled := rbModeCopy.Checked;
end;

//===========================================================================
procedure btnPathClick(Sender: TObject);
var
  s: string;
begin
  s := SelectDirectory('Destination path to copy files to', '', edPath.Text, nil);
  if s <> '' then
    edPath.Text := s;
end;

//===========================================================================
// on key down event handler for form
procedure frmFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    TForm(Sender).ModalResult := mrCancel;
end;

//===========================================================================
// on close event handler for form
procedure frmFormClose(Sender: TObject; var Action: TCloseAction);
begin
  if rbModeCopy.Checked and not DirectoryExists(edPath.Text) then begin
    MessageDlg('Please select existing destination folder', mtInformation, [mbOk], 0);
    Action := caNone;
  end;
end;

//===========================================================================
procedure ShowOptions;
var
  i: integer;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := wbGameName + ' Assets Manager';
    frm.Width := 700;
    frm.Height := 450;
    frm.Position := poScreenCenter;
    frm.BorderStyle := bsDialog;
    frm.KeyPreview := True;
    frm.OnKeyDown := frmFormKeyDown;
    frm.OnClose := frmFormClose;

    lbl := TLabel.Create(frm);
    lbl.Parent := frm;
    lbl.Top := 8;
    lbl.Left := 8;
    lbl.Caption := 'Processed assets';

    clbAssets := TCheckListBox.Create(frm);
    clbAssets.Parent := frm;
    clbAssets.Top := 24;
    clbAssets.Left := 8;
    clbAssets.Width := 250;
    clbAssets.Height := 120;
    clbAssets.Items.AddStrings(slAssetsType);
    clbAssets.CheckAll(cbChecked, False, False);
    
    lbl := TLabel.Create(frm);
    lbl.Parent := frm;
    lbl.Top := clbAssets.Top + clbAssets.Height + 16;
    lbl.Left := 8;
    lbl.Caption := 'Processed containers';

    clbContainers := TCheckListBox.Create(frm);
    clbContainers.Parent := frm;
    clbContainers.Top := clbAssets.Top + clbAssets.Height + 32;
    clbContainers.Left := 8;
    clbContainers.Width := 250;
    clbContainers.Height := 220;
    for i := 0 to Pred(slContainers.Count) do
      clbContainers.Items.Add(SimpleName(slContainers[i]));
    clbContainers.CheckAll(cbChecked, False, False);
    
    mnPopup := TPopupMenu.Create(frm);
    clbContainers.PopupMenu := mnPopup;
    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := 'Select all';
    MenuItem.OnClick := PopupMenuClick;
    MenuItem.Tag := 1;
    mnPopup.Items.Add(MenuItem);
    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := 'Select none';
    MenuItem.OnClick := PopupMenuClick;
    mnPopup.Items.Add(MenuItem);

    rbModeCheck := TRadioButton.Create(frm);
    rbModeCheck.Parent := frm;
    rbModeCheck.Top := clbAssets.Top;
    rbModeCheck.Left := clbAssets.Left + clbAssets.Width + 32;
    rbModeCheck.Width := 200;
    rbModeCheck.Font.Style := [fsBold];
    rbModeCheck.Caption := 'Check for missing assets';
    rbModeCheck.Checked := True;
    rbModeCheck.OnClick := rbModeClick;

    lbl := TLabel.Create(frm);
    lbl.Parent := frm;
    lbl.AutoSize := False;
    lbl.Wordwrap := True;
    lbl.Top := rbModeCheck.Top + 20;
    lbl.Left := rbModeCheck.Left + 16;
    lbl.Width := frm.Width - lbl.Left - 40;
    lbl.Height := 60;
    lbl.Caption := 'Process all selected records and check referenced asset files for existence in selected containers. Useful to find out if all required files are present for particular mod.';

    rbModeCopy := TRadioButton.Create(frm);
    rbModeCopy.Parent := frm;
    rbModeCopy.Top := rbModeCheck.Top + 100;
    rbModeCopy.Left := rbModeCheck.Left;
    rbModeCopy.Width := 200;
    rbModeCopy.Font.Style := [fsBold];
    rbModeCopy.Caption := 'Copy referenced assets';
    rbModeCopy.OnClick := rbModeClick;

    lbl := TLabel.Create(frm);
    lbl.Parent := frm;
    lbl.AutoSize := False;
    lbl.Wordwrap := True;
    lbl.Top := rbModeCopy.Top + 20;
    lbl.Left := rbModeCopy.Left + 16;
    lbl.Width := frm.Width - lbl.Left - 40;
    lbl.Height := 60;
    lbl.Caption := 'Copy assets used in a mod to the separate destination folder retaining directory structure. Useful to package mod for distribution. You might want to deselect the game''s BSA archives to avoid copying vanilla files. Existing files in destination folder are not overwritten.';

    edPath := TLabeledEdit.Create(frm);
    edPath.Parent := frm;
    edPath.Left := lbl.Left;
    edPath.Top := lbl.Top + 80;
    edPath.Width := lbl.Width - 40;
    edPath.LabelPosition := lpAbove;
    edPath.EditLabel.Caption := 'Destination folder';

    btnPath := TButton.Create(frm);
    btnPath.Parent := frm;
    btnPath.Top := edPath.Top - 1;
    btnPath.Left := edPath.Left + edPath.Width + 6;
    btnPath.Width := 32;
    btnPath.Height := 22;
    btnPath.Caption := '...';
    btnPath.OnClick := btnPathClick;
    
    lbl := TLabel.Create(frm);
    lbl.Parent := frm;
    lbl.AutoSize := False;
    lbl.Wordwrap := True;
    lbl.Top := edPath.Top + 50;
    lbl.Left := rbModeCopy.Left;
    lbl.Width := edPath.Width + 40;
    lbl.Height := 60;
    lbl.Caption := 'Keep in mind that disabling processing of meshes also disables processing of textures used in meshes. The same rule applies for compiled scripts and script sources.';

    btnOk := TButton.Create(frm);
    btnOk.Parent := frm;
    btnOk.Top := frm.Height - 70;
    btnOk.Left := frm.Width - 220;
    btnOk.Width := 90;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;

    btnCancel := TButton.Create(frm);
    btnCancel.Parent := frm;
    btnCancel.Top := frm.Height - 70;
    btnCancel.Left := frm.Width - 120;
    btnCancel.Width := 90;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;

    // update default state of elements
    rbModeClick(nil);
    
    if frm.ShowModal = mrOk then begin

      optAsset := 0;
      for i := 0 to Pred(clbAssets.Items.Count) do
        if clbAssets.Checked[i] then
          optAsset := optAsset or Integer(clbAssets.Items.Objects[i]);

      for i := Pred(clbContainers.Items.Count) downto 0 do
        if not clbContainers.Checked[i] then
          slContainers.Delete(i);

      if rbModeCheck.Checked then
        optMode := wmCheck
      else if rbModeCopy.Checked then begin
        optMode := wmCopy;
        optPath := IncludeTrailingBackslash(edPath.Text);
      end;
    
    end else
      optMode := wmNone;
    
  finally
    frm.Free;
  end;
end;

//===========================================================================
// reduce container name to BSA file name or 'Data'
function SimpleName(aName: string): string;
begin
  Result := ExtractFileName(aName);
  if Result = '' then
    Result := 'Data';
end;

//==========================================================================
function NormalizePath(value: string; atype: integer): string;
begin
  // uncomment to not show errors on full paths
  //if not SameText(Copy(value, 1, 3), 'c:\') then
  if (atype = atMesh) and not (Copy(value, 1, 7) = 'meshes\') then
    value := 'meshes\' + value
  else if (atype = atTexture) and not (Copy(value, 1, 9) = 'textures\') then
    value := 'textures\' + value
  else if (atype = atSound) and not (Copy(value, 1, 6) = 'sound\') then
    value := 'sound\' + value
  else if (atype = atMusic) and not (Copy(value, 1, 6) = 'music\') then
    value := 'music\' + value;
  Result := value;
end;

//==========================================================================
// perform operation with resource depending on workmode
// returns the last container's name (in selected) of resource if exists
function ProcessResource(aResName, aResDescr: string; aResType: integer): string;
var
  i: integer;
begin
  Result := '';

  if optAsset and aResType = 0 then
    Exit;

  slRes.Clear;
  ResourceCount(aResName, slRes);

  // check if resource is in any of selected containers
  // starting from the last one
  for i := Pred(slRes.Count) downto 0 do
    if slContainers.IndexOf(slRes[i]) <> -1 then begin
      Result := slRes[i];
      Break;
    end;
  
  if optMode = wmCheck then begin
    if Result = '' then
      AddMessage(aResName + '   <-- ' + aResDescr);
  end
  else if optMode = wmCopy then begin
    // do not overwrite existing files or copy same files several times
    if (Result <> '') and not FileExists(optPath + aResName) then begin
      AddMessage(aResName + '   <-- ' + aResDescr);
      ResourceCopy(Result, aResName, optPath);
    end;
  end;
end;

//==========================================================================
procedure ProcessAsset(el: IInterface);
var
  value, valuedescr, ext, s, rescont: string;
  i, atype: integer;
begin
  if not Assigned(el) then
    Exit;
  
  value := LowerCase(GetEditValue(el));
  if value = '' then
    Exit;
  
  if Name(el) = 'scriptName' then begin
    value := 'scripts\' + value + '.pex';
    atype := atScript;
  end
  else if Signature(el) = 'QUST' then begin
    value := 'seq\' + LowerCase(ChangeFileExt(GetFileName(el), '.seq'));
    valuedescr := 'Start-game enabled quest requires SEQ file ' + Name(el);
    atype := atSeqFile;
  end
  else begin
    ext := Copy(value, Length(value) - 3, 4);
    if value[1] = '\' then
      Delete(value, 1, 1);
    if SameText(Copy(value, 1, 5), 'data\') then
      value := Copy(value, 6, Length(value));
    i := slAssetsExt.IndexOf(ext);
    if i = -1 then Exit;
    atype := Integer(slAssetsExt.Objects[i]);
    if (atype = atSound) and (Signature(CurrentRecord) = 'MUST') then
      atype := atMusic;
    value := NormalizePath(value, atype);
  end;
  
  if valuedescr = '' then
    valuedescr := Name(CurrentRecord) +  ' \ ' + Path(el);

  rescont := ProcessResource(value, valuedescr, atype);
  if rescont = '' then
    Exit;

  // if resource exists, check additional resources tied to it

  // check textures in mesh
  if (atype = atMesh) and (optAsset and atTexture > 0) then begin
    // suppress possible errors for invalid meshes
    try
      NifTextureList(ResourceOpenData(rescont, value), sl);
    except on E: Exception do
      AddMessage('NIF: ' + E.Message + ' ' + value);
    end;
    slTextures.AddStrings(sl); // remove duplicates
    for i := 0 to Pred(slTextures.Count) do begin
      s := NormalizePath(LowerCase(slTextures[i]), atTexture);
      ProcessResource(s, valuedescr + ': ' + value, atTexture);
    end;
    slTextures.Clear;
  end;

  // copy additional lod and collision meshes
  if (atype = atMesh) and (optMode = wmCopy) then begin
      if wbGameMode = gmTES5 then s := '_lod'
        else s := '_far';
      ProcessResource(Copy(value, 1, Length(value) - 4) + s + ext, 'LOD mesh for ' + valuedescr + ': ' + value, atMesh);
  end;

  // script's source
  if (atype = atScript) and (optAsset and atScript > 0) then begin
    s := ExtractFilePath(value) + 'source\' + ChangeFileExt(ExtractFileName(value), '.psc');
    ProcessResource(s, valuedescr, atScriptSource);
  end;
end;

//==========================================================================
procedure ScanForAssets(e: IInterface);
var
  s, ext: string;
  i: integer;
begin
  if not Assigned(e) then
    Exit;

  i := DefType(e);
  if (i = dtString) or (i = dtLenString) then begin
    s := GetEditValue(e);
    ext := LowerCase(Copy(s, Length(s) - 3, 4));
    if (slAssetsExt.IndexOf(ext) <> -1) or (Name(e) = 'scriptName') then
      ProcessAsset(e);
  end;
  
  if Name(e) <> 'Properties' then  // skip VMAD properties section
  for i := 0 to ElementCount(e) - 1 do
    ScanForAssets(ElementByIndex(e, i));
end;

//==========================================================================
function Initialize: integer;
begin
  if wbGameMode <> gmTES5 then begin
    AddMessage('Sorry, script supports Skyrim only for now.');
    Result := 1;
    Exit;
  end;
  
  slAssetsExt := TStringList.Create;
  slAssetsExt.AddObject('.nif', atMesh);
  slAssetsExt.AddObject('.dds', atTexture);
  slAssetsExt.AddObject('.wav', atSound);
  slAssetsExt.AddObject('.mp3', atSound);
  slAssetsExt.AddObject('.xwm', atSound);
  slAssetsExt.AddObject('.hkx', atMesh);
  slAssetsExt.AddObject('.kf', atMesh);
  slAssetsExt.AddObject('.seq', atSeqFile);

  slAssetsType := TStringList.Create;
  slAssetsType.AddObject('Meshes', atMesh);
  slAssetsType.AddObject('Textures', atTexture);
  slAssetsType.AddObject('Sounds', atSound);
  slAssetsType.AddObject('Music', atMusic);
  slAssetsType.AddObject('Papyrus scripts (compiled)', atScript);
  slAssetsType.AddObject('Papyrus scripts (source)', atScriptSource);
  slAssetsType.AddObject('SEQ file', atSeqFile);

  slTextures := TwbFastStringList.Create;
  slTextures.Sorted := True;
  slTextures.Duplicates := dupIgnore;

  slContainers := TwbFastStringList.Create;
  ResourceContainerList(slContainers);

  slRes := TStringList.Create;
  sl := TStringList.Create;

  ShowOptions;
  
  if optMode = wmCheck then begin
    AddMessage('LIST OF MISSING ASSET FILES:');
  end
  else if optMode = wmCopy then begin
    AddMessage('COPYING USED ASSET FILES:');
  end
  else if optMode = wmNone then begin
    Finalize;
    Result := 1;
  end;
end;

//==========================================================================
function Process(e: IInterface): integer;
var
  el: IInterface;
  sig: string;
  i: integer;
begin
  CurrentRecord := e;
  
  sig := Signature(e);
  
  if (sig = 'CELL') then
    ProcessAsset(ElementByPath(e, 'XNAM'));

  // skip records without assets
  if (sig = 'REFR') or (sig = 'ACHR') or (sig = 'ACRE') or (sig = 'CELL') or
     (sig = 'NAVM') or (sig = 'PGRD') or (sig = 'LAND') or (sig = 'PACK')
  then
    Exit;
  
  // generic model common for all records
  ProcessAsset(ElementByPath(e, 'Model\MODL'));

  // generic icon common for all records
  ProcessAsset(ElementByPath(e, 'ICON'));

  // generic destruction models common for all records
  ScanForAssets(ElementByPath(e, 'Destructable'));
  
  // papyrus scripts
  if optAsset and atScript > 0 then
    ScanForAssets(ElementByPath(e, 'VMAD'));
  
  if (sig = 'ARMA') or (sig = 'ARMO') then begin
    ProcessAsset(ElementByPath(e, 'Male world model\MOD2'));
    ProcessAsset(ElementByPath(e, 'Female world model\MOD2'));
    ProcessAsset(ElementByPath(e, 'Male 1st Person\MOD4'));
    ProcessAsset(ElementByPath(e, 'Female 1st Person\MOD5'));
  end
  
  // looks like those are not real mesh files
  {else if (sig = 'BPTD') then
    ScanForAssets(ElementByPath(e, 'Body Parts'))}

  else if (sig = 'CLMT') then begin
    ProcessAsset(ElementByPath(e, 'FNAM'));
    ProcessAsset(ElementByPath(e, 'GNAM'));
  end
  
  else if (sig = 'MUST') then begin
    ProcessAsset(ElementByPath(e, 'ANAM'));
    ProcessAsset(ElementByPath(e, 'BNAM'));
  end

  else if (sig = 'PROJ') then
    ProcessAsset(ElementByPath(e, 'Muzzle Flash Model\NAM1'))

  else if (sig = 'QUST') and (wbGameMode = gmTES5) then begin
    if GetElementNativeValues(e, 'DNAM\Flags') and 1 > 0 then
      if not Assigned(Master(e)) or (GetElementNativeValues(Master(e), 'DNAM\Flags') and 1 = 0) then
        ProcessAsset(e);
  end
              
  else if (sig = 'RACE') then begin
    ProcessAsset(ElementByPath(e, 'ANAM - Male Skeletal Model'));
    ProcessAsset(ElementByPath(e, 'ANAM - Female Skeletal Model'));
    ScanForAssets(ElementByPath(e, 'Body Data'));
    ProcessAsset(ElementByPath(e, 'Male Behavior Graph\Model\MODL'));
    ProcessAsset(ElementByPath(e, 'Female Behavior Graph\Model\MODL'));
    ProcessAsset(ElementByPath(e, 'Head Data\Male Head Data\Model'));
    ProcessAsset(ElementByPath(e, 'Head Data\Female Head Data\Model'));
  end

  else if (sig = 'SNDR') then
    ScanForAssets(ElementByPath(e, 'Sounds'))

  else if (sig = 'TXST') then
    ScanForAssets(ElementByPath(e, 'Textures (RGB/A)'))

  else if (sig = 'WATR') then
    ProcessAsset(ElementByPath(e, 'NAM2'))

  else if (sig = 'WRLD') then begin
    ProcessAsset(ElementByPath(e, 'Cloud Model\Model\MODL'));
    ProcessAsset(ElementByPath(e, 'XNAM'));
    ProcessAsset(ElementByPath(e, 'TNAM'));
    ProcessAsset(ElementByPath(e, 'UNAM'));
  end

  else if (sig = 'WTHR') then
    ScanForAssets(e);

end;

//==========================================================================
function Finalize: integer;
begin
  slAssetsType.Free;
  slAssetsExt.Free;
  slContainers.Free;
  slTextures.Free;
  slRes.Free;
  sl.Free;
end;

end.