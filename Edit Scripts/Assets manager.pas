{
  Assets manager.

  Allows to check existence of used assets including textures, materials, etc. in meshes,
  and copy assets used by a plugin to separate folder or create list files of different format.
}
unit AssetsManager;

const
  // asset type
  atMesh = 1;
  atTexture = 2;
  atSound = 4;
  atMusic = 8;
  atPapyrusScript = 16;
  atSeqFile = 32;
  atLODAsset = 64;
  atSpeedTree = 128;
  atAnimation = 256;
  atInterface = 512;
  atMaterial = 1024;
  atProgram = 2048;

  // work mode
  wmNone = 0;
  wmCheck = 1;
  wmList = 2;
  wmListCSV = 3;
  wmListJSON = 4;
  wmCopy = 5;

  // records to skip without assets
  sSkipSignatures = 'REFR,ACHR,ACRE,PGRE,LAND,NAVM,PGRD,PACK';

  // music record signature
  sMusicSignatures = 'MUSC,MUST,MSET';

var
  slAssetsType, slAssetsExt, sl, slRes, slDump: TStringList;
  slContainers, slTextures, slChecksum: TwbFastStringList;
  CurrentRecord: IInterface;
  optAsset, optMode: integer;
  optPath: string;
  ResDescrPrefix: string;
  ChecksumsFileName: string;
  bSkipChecksum: boolean;

  frm: TForm;
  lbl: TLabel;
  clbAssets, clbContainers: TCheckListBox;
  mnPopup: TPopupMenu;
  MenuItem: TMenuItem;
  rbModeCheck, rbModeList, rbModeCopy: TRadioButton;
  rgList: TRadioGroup;
  edPath: TLabeledEdit;
  chkSkipChecksums: TCheckBox;
  btnChecksums, btnPath, btnOk, btnCancel: TButton;


//===========================================================================
procedure GetTexturesFromTextureSet(aSet: TwbNifBlock; sl: TStringList);  
var
  i: integer;
  el: TdfElement;
begin
  if not Assigned(aSet) then
    Exit;
  
  el := aSet.Elements['Textures'];
  for i := 0 to Pred(el.Count) do
    sl.Add(wbNormalizeResourceName(el[i].EditValue, resTexture));
end;
  
//===========================================================================
procedure GetTexturesFromMaterial(aFileName: string; sl: TStringList);  
var
  bgsm: TwbBGSMFile;
  bgem: TwbBGEMFile;
  i: integer;
  el: TdfElement;
begin
  if SameText(ExtractFileExt(aFileName), '.bgsm') then begin
    bgsm := TwbBGSMFile.Create;
    bgsm.LoadFromResource(aFileName);
    el := bgsm.Elements['Textures'];
    if Assigned(el) then
      for i := 0 to Pred(el.Count) do
        sl.Add(wbNormalizeResourceName(el[i].EditValue, resTexture));
    bgsm.Free;
  end
  else if SameText(ExtractFileExt(aFileName), '.bgem') then begin
    bgem := TwbBGEMFile.Create;
    bgem.LoadFromResource(aFileName);
    el := bgem.Elements['Textures'];
    if Assigned(el) then
      for i := 0 to Pred(el.Count) do
        sl.Add(wbNormalizeResourceName(el[i].EditValue, resTexture));
    bgem.Free;
  end
end;
  
//===========================================================================
procedure GetNifAssets(aFileName: string; sl: TStringList);
var
  nif: TwbNifFile;
  Block: TwbNifBlock;
  el: TdfElement;
  s: string;
  i: integer;
  bMaterial: Boolean;
begin
  nif := TwbNifFile.Create;
  try
    nif.LoadFromResource(aFileName);
    
    // iterate over all blocks in a nif file and gather used assets
    for i := 0 to Pred(Nif.BlocksCount) do begin
      Block := Nif.Blocks[i];
      
      if Block.BlockType = 'BSLightingShaderProperty' then begin
        // check for material file in the Name field of FO4 meshes
        bMaterial := False;
        if nif.NifVersion = nfFO4 then begin
          // if shader material is used, get textures from it
          s := Block.EditValues['Name'];
          if SameText(ExtractFileExt(s), '.bgsm') then begin
            s := wbNormalizeResourceName(s, resMaterial);
            sl.Add(s);
            GetTexturesFromMaterial(s, sl);
            bMaterial := True;
          end;
          // wet material
          s := Block.EditValues['Wet Material'];
          if SameText(ExtractFileExt(s), '.bgsm') then begin
            s := wbNormalizeResourceName(s, resMaterial);
            sl.Add(s);
            GetTexturesFromMaterial(s, sl);
          end;
        end;
        // no material used, get textures from texture set
        if not bMaterial then
          GetTexturesFromTextureSet(Block.Elements['Texture Set'].LinksTo, sl);
      end

      else if Block.BlockType = 'BSEffectShaderProperty' then begin
        // check for material file in the Name field of FO4 meshes
        bMaterial := False;
        if nif.NifVersion = nfFO4 then begin
          s := Block.EditValues['Name'];
          // if effect material is used, get textures from it
          if SameText(ExtractFileExt(s), '.bgem') then begin
            s := wbNormalizeResourceName(s, resMaterial);
            sl.Add(s);
            GetTexturesFromMaterial(s, sl);
          end;
        end;
        // no material used, get textures from effect shader
        if not bMaterial then begin
          sl.Add(wbNormalizeResourceName(Block.EditValues['Source Texture'], resTexture));
          sl.Add(wbNormalizeResourceName(Block.EditValues['Grayscale Texture'], resTexture));
          sl.Add(wbNormalizeResourceName(Block.EditValues['Env Map Texture'], resTexture));
          sl.Add(wbNormalizeResourceName(Block.EditValues['Normal Texture'], resTexture));
          sl.Add(wbNormalizeResourceName(Block.EditValues['Env Mask Texture'], resTexture));
        end;
      end

      else if Block.BlockType = 'BSShaderPPLightingProperty' then
        GetTexturesFromTextureSet(Block.Elements['Texture Set'].LinksTo, sl)

      else if (Block.BlockType = 'BSShaderNoLightingProperty') or
              (Block.BlockType = 'TallGrassShaderProperty') or
              (Block.BlockType = 'TileShaderProperty')
      then
        sl.Add(wbNormalizeResourceName(Block.EditValues['File Name'], resTexture))

      else if Block.BlockType = 'BSSkyShaderProperty' then
        sl.Add(wbNormalizeResourceName(Block.EditValues['Source Name'], resTexture))

      // any block inherited from NiTexture
      else if Block.IsNiObject('NiTexture', True) then
        sl.Add(wbNormalizeResourceName(Block.EditValues['File Name'], resTexture))

      // linked *.hkx file
      else if Block.BlockType = 'BSBehaviorGraphExtraData' then
        sl.Add(wbNormalizeResourceName(Block.EditValues['Behavior Graph File'], resMesh))
      
      // linked bone weights *.ssf file
      else if Block.BlockType = 'BSSubIndexTriShape' then
        sl.Add(wbNormalizeResourceName(Block.EditValues['Segment Data\SSF File'], resMesh));

    end;    
  finally
    nif.Free;
  end;
end;

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
  rgList.Enabled := rbModeList.Checked;
  edPath.Enabled := rbModeCopy.Checked;
  btnPath.Enabled := rbModeCopy.Checked;
  chkSkipChecksums.Enabled := rbModeCopy.Checked and FileExists(ChecksumsFileName);
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
procedure btnChecksumsClick(Sender: TObject);
var
  i, j: integer;
  cont, fname: string;
  slAssets: TStringList;
begin
  if MessageDlg('Build checksums index of files from selected containers? Warning: this can take some time, wait for a message box to appear.', mtConfirmation, [mbOk, mbCancel], 0) <> mrOk then
    Exit;
  
  slAssets := TStringList.Create;
  slChecksum.Clear;
  for i := 0 to Pred(clbContainers.Items.Count) do begin
    if not clbContainers.Checked[i] then
      Continue;
    cont := slContainers[i];
    AddMessage('Building index for ' + clbContainers.Items[i]);
    slAssets.Clear;
    ResourceList(cont, slAssets);
    for j := 0 to Pred(slAssets.Count) do begin
      fname := slAssets[j];
      // index only valid assets
      try
        if slAssetsExt.IndexOf(ExtractFileExt(fname)) <> -1 then
          slChecksum.Values[fname] := IntToHex(wbCRC32Data(ResourceOpenData(cont, fname)), 8);
      except
        AddMessage('Error reading file ' + fname + ' from ' + cont);
        Exit;
      end;
    end;
  end;
  if slChecksum.Count > 0 then begin
    slChecksum.SaveToFile(ChecksumsFileName);
    chkSkipChecksums.Enabled := rbModeCopy.Checked;
    ShowMessage(Format('%d files were indexed.', [slChecksum.Count]));
  end else
    ShowMessage('Nothing to index.');
  slAssets.Free;
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
  if frm.ModalResult <> mrOk then Exit;
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
    frm.Height := 650;
    frm.Position := poScreenCenter;
    frm.BorderStyle := bsDialog;
    frm.PopupMode := pmAuto;
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
    clbAssets.Height := 170;
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
    clbContainers.Height := 340;
    for i := 0 to Pred(slContainers.Count) do
      clbContainers.Items.Add(SimpleName(slContainers[i]));
    clbContainers.CheckAll(cbChecked, False, False);
    
    btnChecksums := TButton.Create(frm);
    btnChecksums.Parent := frm;
    btnChecksums.Width := 100;
    btnChecksums.Height := 22;
    btnChecksums.Top := clbContainers.Top - 24;
    btnChecksums.Left := clbContainers.Left + clbContainers.Width - btnChecksums.Width;
    btnChecksums.Caption := 'Build cheksums';
    btnChecksums.OnClick := btnChecksumsClick;

    mnPopup := TPopupMenu.Create(frm);
    clbContainers.PopupMenu := mnPopup;
    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := 'Select All';
    MenuItem.OnClick := PopupMenuClick;
    MenuItem.Tag := 1;
    mnPopup.Items.Add(MenuItem);
    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := 'Select None';
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

    rbModeList := TRadioButton.Create(frm);
    rbModeList.Parent := frm;
    rbModeList.Top := rbModeCheck.Top + 80;
    rbModeList.Left := rbModeCheck.Left;
    rbModeList.Width := 200;
    rbModeList.Font.Style := [fsBold];
    rbModeList.Caption := 'List referenced assets';
    rbModeList.OnClick := rbModeClick;

    lbl := TLabel.Create(frm);
    lbl.Parent := frm;
    lbl.AutoSize := False;
    lbl.Wordwrap := True;
    lbl.Top := rbModeList.Top + 20;
    lbl.Left := rbModeList.Left + 16;
    lbl.Width := frm.Width - lbl.Left - 40;
    lbl.Height := 40;
    lbl.Caption := 'List asset files referenced by selected records. All assets are shown no matter if they exist in selected containers or not.';

    rgList := TRadioGroup.Create(frm);
    rgList.Parent := frm;
    rgList.Top := rbModeList.Top + 60;
    rgList.Left := rbModeList.Left + 16;
    rgList.Width := 200; rgList.Height := 80;
    rgList.Items.Text := 'to Messages Tab'#13'to CSV file'#13'to CK import file';
    rgList.ItemIndex := 0;
    
    rbModeCopy := TRadioButton.Create(frm);
    rbModeCopy.Parent := frm;
    rbModeCopy.Top := rbModeList.Top + 170;
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
    
    chkSkipChecksums := TCheckBox.Create(frm);
    chkSkipChecksums.Parent := frm;
    chkSkipChecksums.Top := edPath.Top + 32;
    chkSkipChecksums.Left := edPath.Left;
    chkSkipChecksums.Width := 360;
    chkSkipChecksums.Caption := 'Skip copying files with matching checksums (requires built checksums)';

    lbl := TLabel.Create(frm);
    lbl.Parent := frm;
    lbl.AutoSize := False;
    lbl.Wordwrap := True;
    lbl.Top := chkSkipChecksums.Top + 80;
    lbl.Left := rbModeCopy.Left;
    lbl.Width := edPath.Width + 40;
    lbl.Height := 60;
    lbl.Caption := 'Keep in mind that disabling processing of meshes also disables processing of textures used in meshes.';

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

      // consider speedtree is in mesh category
      if optAsset and atMesh > 0 then
        optAsset := optAsset or atSpeedTree;

      for i := Pred(clbContainers.Items.Count) downto 0 do
        if not clbContainers.Checked[i] then
          slContainers.Delete(i);

      if rbModeCheck.Checked then
        optMode := wmCheck
      
      else if rbModeList.Checked then begin
        if rgList.ItemIndex = 0 then
          optMode := wmList
        else if rgList.ItemIndex = 1 then begin
          optMode := wmListCSV;
          slDump := TStringList.Create;
        end
        else if rgList.ItemIndex = 2 then begin
          optMode := wmListJSON;
          slDump := TStringList.Create;
        end;
      end
      
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
  if value = '' then
    Exit;
  // uncomment to not show errors on full paths
  //if not SameText(Copy(value, 1, 3), 'c:\') then
  if Copy(value, 1, 1) = '\' then
    Delete(value, 1, 1);
  if SameText(Copy(value, 1, 5), 'data\') then
    value := Copy(value, 6, Length(value));
  if (atype = atMesh) and not (Copy(value, 1, 7) = 'meshes\') then
    value := 'meshes\' + value
  else if (atype = atAnimation) and not (Copy(value, 1, 7) = 'meshes\') then
    value := 'meshes\' + value
  else if (atype = atTexture) and not (Copy(value, 1, 9) = 'textures\') then
    value := 'textures\' + value
  else if (atype = atSound) and not (Copy(value, 1, 6) = 'sound\') then
    value := 'sound\' + value
  else if (atype = atMusic) and not (Copy(value, 1, 6) = 'music\') then
    value := 'music\' + value
  else if (atype = atSpeedTree) and not (Copy(value, 1, 6) = 'trees\') then
    value := 'trees\' + value
  else if (atype = atInterface) and not (Copy(value, 1, 10) = 'interface\') then
    value := 'interface\' + value
  else if (atype = atMaterial) and not (Copy(value, 1, 9) = 'material\') then
    value := 'materials\' + value
  else if (atype = atProgram) and not (Copy(value, 1, 9) = 'programs\') then
    value := 'programs\' + value;
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

  aResDescr := ResDescrPrefix + aResDescr;
  slRes.Clear;
  ResourceCount(aResName, slRes);

  // dump everything regardless of asset existance in selected containers
  if optMode = wmList then
    AddMessage(aResName + '   <-- ' + aResDescr)
  else if optMode = wmListCSV then
    slDump.Add(Format('[%s];%s;%s', [
      IntToHex(GetLoadOrderFormID(CurrentRecord), 8),
      aResName,
      aResDescr
    ]))
  else if optMode = wmListJSON then
    slDump.Add(aResName);

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
  else if (optMode = wmCopy) and (Result <> '') then begin
    // do not overwrite existing files or copy same files several times
    if FileExists(optPath + aResName) then
      Exit;
    // skip matching checksums
    if bSkipChecksum then begin
      i := slChecksum.IndexOfName(aResName);
      if i <> - 1 then
        if slChecksum.ValueFromIndex[i] = IntToHex(wbCRC32Data(ResourceOpenData(Result, aResName)), 8) then begin
          AddMessage('[Skipped] matching checksum: ' + aResName + '   <-- ' + aResDescr);
          Result := '';
          Exit;
        end;
    end;
    AddMessage(aResName + '   <-- ' + aResDescr);
    ResourceCopy(Result, aResName, optPath);
  end;
end;

//==========================================================================
procedure ProcessMeshAssets(aMesh, aContainer, aDescr: string);
var
  i: integer;
begin
  // some assets are in the "mesh" category but not nifs
  if not SameText(ExtractFileExt(aMesh), '.nif') then
    Exit;
    
  // suppress possible errors for invalid meshes
  sl.Clear;
  try
    GetNifAssets(aMesh, sl);
  except on E: Exception do
    AddMessage('Error reading NIF: ' + E.Message + ' ' + aMesh);
  end;
  
  // remove duplicates and empty
  for i := 0 to Pred(sl.Count) do
    if sl[i] <> '' then
      slTextures.Add(sl[i]);
  
  for i := 0 to Pred(slTextures.Count) do
    ProcessResource(slTextures[i], 'Asset for ' + aDescr + ': ' + aMesh, atTexture);
  
  slTextures.Clear;
end;

//==========================================================================
procedure ProcessMaterialAssets(aMaterial, aContainer, aDescr: string);
var
  i: integer;
begin
  // suppress possible errors for invalid meshes
  sl.Clear;
  try
    GetTexturesFromMaterial(aMaterial, sl);
  except on E: Exception do
    AddMessage('Error reading material: ' + E.Message + ' ' + aMaterial);
  end;
  
  // remove duplicates and empty
  for i := 0 to Pred(sl.Count) do
    if sl[i] <> '' then
      slTextures.Add(sl[i]);
  
  for i := 0 to Pred(slTextures.Count) do
    ProcessResource(slTextures[i], 'Asset for ' + aDescr + ': ' + aMaterial, atTexture);
  
  slTextures.Clear;
end;

//==========================================================================
// process resource by value and type
procedure ProcessAssetEx(el: IInterface; value, valuedescr: string; atype: integer);
var
  rescont, s: string;
begin
  if value = '' then
    Exit;

  // just in case, resource container index is lowercased
  value := LowerCase(value);
  
  if valuedescr = '' then
    if ResDescrPrefix = '' then
      valuedescr := Name(CurrentRecord) +  ' \ ' + Path(el)
    else
      valuedescr := Path(el);

  rescont := ProcessResource(value, valuedescr, atype);

  if rescont = '' then
    Exit;

  // check embedded assets
  if ((atype = atMesh) or (atype = atLODAsset)) and (optAsset and (atTexture + atMaterial) <> 0) then
    ProcessMeshAssets(value, rescont, valuedescr)
  
  else if atype = atMaterial then
    ProcessMaterialAssets(value, rescont, valuedescr);
end;

//==========================================================================
// detect asset type of element and process it
procedure ProcessAsset(el: IInterface);
var
  value, ext, s: string;
  i, atype: integer;
begin
  if not Assigned(el) then
    Exit;
  
  value := LowerCase(GetEditValue(el));
  if value = '' then
    Exit;

  // [FO3/FNV] Hardcoded: model lists in CREA use creature model path
  if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then begin
    s := Path(el);
    if SameText(s, 'CREA \ NIFZ - Model List \ Model') then
      value := ExtractFilePath(GetElementEditValues(CurrentRecord, 'Model\MODL')) + value
    else if SameText(s, 'CREA \ KFFZ - Animations \ Animation') then
      value := ExtractFilePath(GetElementEditValues(CurrentRecord, 'Model\MODL')) + 'specialanims\' + value;
  end;
  
  // asset extension
  ext := ExtractFileExt(value);
  // detect asset type
  i := slAssetsExt.IndexOf(ext);
  if i = -1 then Exit;
  atype := Integer(slAssetsExt.Objects[i]);

  // more detailed asset type detection depending on different factors
  // sound files in those records are music
  if (atype = atSound) and (Pos(Signature(CurrentRecord), sMusicSignatures) > 0) then
    atype := atMusic
  // speedtree files
  else if (atype = atMesh) and SameText(ext, '.spt') then
    atype := atSpeedTree
  // hardcoded location for speedtree leaves billboards
  else if (atype = atTexture) and ((wbGameMode = gmFO3) or (wbGameMode = gmFNV)) and (Signature(CurrentRecord) = 'TREE') then
    value := 'textures\trees\leaves\' + value;

  value := NormalizePath(LowerCase(value), atype);
  
  ProcessAssetEx(el, value, '', atype);
end;

//==========================================================================
procedure ScanForAssets(e: IInterface);
var
  i: integer;
begin
  if not Assigned(e) then
    Exit;

  // special scanning case for Alternate textures
  if SameText(Name(e), 'Alternate Texture') then begin
    ResDescrPrefix := Format('Alternate texture for node %s in %s from %s \ ', [
      GetElementEditValues(e, '3D Name'), // node name
      GetEditValue(ElementByIndex(GetContainer(GetContainer(e)), 0)), // model file name
      Name(LinksTo(ElementByName(e, 'New Texture'))) // TXST record name
    ]);
    ScanForAssets(LinksTo(ElementByName(e, 'New Texture')));
    ResDescrPrefix := '';
    Exit;
  end;

  i := DefType(e);
  if (i = dtString) or (i = dtLenString) then
    // do extension check before processing asset to speed up execution
    if (slAssetsExt.IndexOf(LowerCase(ExtractFileExt(GetEditValue(e)))) <> -1) then
      ProcessAsset(e);
  
  for i := 0 to Pred(ElementCount(e)) do
    ScanForAssets(ElementByIndex(e, i));
end;

//==========================================================================
// scan VMAD subrecord for scripts
procedure ScanForPapyrusScripts(e: IInterface);
var
  i: integer;
  s: string;
begin
  if not Assigned(e) then
    Exit;

  // skip VMAD properties
  if Name(e) = 'Properties' then 
    Exit;

  if Name(e) = 'scriptName' then begin
    s := StringReplace(GetEditValue(e), ':', '\', [rfReplaceAll]);
    ProcessAssetEx(e, 'scripts\' + s + '.pex', 'Papyrus script attached to ' + Name(CurrentRecord), atPapyrusScript);
    ProcessAssetEx(e, 'scripts\source\' + s + '.psc', 'Source of papyrus script attached to ' + Name(CurrentRecord), atPapyrusScript);
  end;
  
  for i := 0 to Pred(ElementCount(e)) do
    ScanForPapyrusScripts(ElementByIndex(e, i));
end;

//==========================================================================
function Initialize: integer;
begin
  {if (wbGameMode <> gmFO3) and
     (wbGameMode <> gmFNV) and
     (wbGameMode <> gmTES4) and
     (wbGameMode <> gmTES5) and
     (wbGameMode <> gmSSE)
  then begin
    MessageDlg('Sorry, script supports Skyrim, SSE, Oblivion and Fallouts only for now.', mtInformation, [mbOk], 0);
    Result := 1;
    Exit;
  end;}
  
  // known extensions, unknown ones are skipped
  slAssetsExt := TStringList.Create;
  slAssetsExt.AddObject('.nif', atMesh);
  slAssetsExt.AddObject('.dds', atTexture);
  slAssetsExt.AddObject('.bgsm', atMaterial);
  slAssetsExt.AddObject('.bgem', atMaterial);
  slAssetsExt.AddObject('.wav', atSound);
  slAssetsExt.AddObject('.mp3', atSound);
  slAssetsExt.AddObject('.xwm', atSound);
  slAssetsExt.AddObject('.kf', atAnimation);
  slAssetsExt.AddObject('.hkx', atAnimation);
  slAssetsExt.AddObject('.spt', atMesh); // speedtree is in mesh category
  slAssetsExt.AddObject('.psa', atMesh); // pose is in mesh category
  slAssetsExt.AddObject('.tri', atMesh); // morphs
  slAssetsExt.AddObject('.ssf', atMesh); // FO4 bone weights is in mesh category
  slAssetsExt.AddObject('.seq', atSeqFile);
  slAssetsExt.AddObject('.pex', atPapyrusScript);
  slAssetsExt.AddObject('.psc', atPapyrusScript);
  slAssetsExt.AddObject('.swf', atInterface);

  // selection list
  slAssetsType := TStringList.Create;
  slAssetsType.AddObject('Meshes', atMesh);
  slAssetsType.AddObject('Textures', atTexture);
  slAssetsType.AddObject('[FO4] Materials', atMaterial);
  slAssetsType.AddObject('Sounds', atSound);
  slAssetsType.AddObject('Music', atMusic);
  slAssetsType.AddObject('Animations', atAnimation);
  slAssetsType.AddObject('Papyrus scripts', atPapyrusScript);
  slAssetsType.AddObject('[TES5] SEQ file', atSeqFile);
  slAssetsType.AddObject('Interface', atInterface);
  slAssetsType.AddObject('LOD Assets ', atLODAsset);
  slAssetsType.AddObject('[FO4] PipBoy Programs', atProgram);

  slTextures := TwbFastStringList.Create;
  slTextures.Sorted := True;
  slTextures.Duplicates := dupIgnore;

  slChecksum := TwbFastStringList.Create;

  slContainers := TwbFastStringList.Create;
  ResourceContainerList(slContainers);

  slRes := TStringList.Create;
  sl := TStringList.Create;
  
  ChecksumsFileName := Format('%sAssets manager %s checksums.txt', [ScriptsPath, wbGameName]);

  ShowOptions;
  
  if optMode = wmCheck then
    AddMessage('LIST OF MISSING ASSET FILES:')
  else if optMode = wmList then
    AddMessage('LIST OF USED ASSET FILES:')
  else if optMode = wmCopy then begin
    bSkipChecksum := chkSkipChecksums.Checked;
    if bSkipChecksum and (slChecksum.Count = 0) and FileExists(ChecksumsFileName) then
      slChecksum.LoadFromFile(ChecksumsFileName);
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
  el, ent, ents: IInterface;
  sig, s, contnr: string;
  i, i1, i2: integer;
  DisabledClouds: LongWord;
  sl: TStringList;
begin
  CurrentRecord := e;
  
  sig := Signature(e);
  
  // skip records without assets
  if Pos(sig, sSkipSignatures) > 0 then
    Exit;
  
  // generic model common for all records
  ScanForAssets(ElementByName(e, 'Model'));

  // generic icon common for all records
  ProcessAsset(ElementBySignature(e, 'ICON'));
  ScanForAssets(ElementByName(e, 'Icon'));

  // generic destruction models common for all records
  ScanForAssets(ElementByPath(e, 'Destructible'));
  
  // GAME SPECIFIC ELEMENTS

  // --------------------------------------------------------------------------------
  // Skyrim and SSE
  // --------------------------------------------------------------------------------
  if (wbGameMode = gmTES5) or (wbGameMode = gmSSE) then begin
  
    // papyrus scripts
    if optAsset and atPapyrusScript > 0 then
      ScanForPapyrusScripts(ElementByPath(e, 'VMAD'));
    
    if (sig = 'ARMA') then begin
      i1 := GetElementNativeValues(e, 'DNAM\Weight slider - Male');
      i2 := GetElementNativeValues(e, 'DNAM\Weight slider - Female');
      for i := 1 to 4 do begin
        if i = 1 then s := 'Male world model\MOD2'
        else if i = 2 then s := 'Female world model\MOD3'
        else if i = 3 then s := 'Male 1st Person\MOD4'
        else if i = 4 then s := 'Female 1st Person\MOD5';
        ent := ElementByPath(e, s);
        if not Assigned(ent) then Continue;
        ProcessAsset(ent);
        // additional weight models
        if ((i mod 2 = 1) and (i1 = 2)) or ((i mod 2 = 0) and (i2 = 2)) or (optMode = wmCopy) then begin
          s := wbNormalizeResourceName(GetEditValue(ent), resMesh);
          if SameText(Copy(s, Length(s)-5, 6), '_1.nif') then
            ProcessAssetEx(ent, Copy(s, 1, Length(s)-6) + '_0.nif', '', atMesh)
          else if SameText(Copy(s, Length(s)-5, 6), '_0.nif') then
            ProcessAssetEx(ent, Copy(s, 1, Length(s)-6) + '_1.nif', '', atMesh);
        end;
        // the last element in the same container as model is alternate textures
        ent := ElementByIndex(GetContainer(ent), ElementCount(GetContainer(ent)) - 1);
        if Pos('Alternate', Name(ent)) > 0 then
          ScanForAssets(ent);
      end;
      ScanForAssets(ElementByPath(e, 'Icon 2 (female)'));
    end
    
    else if (sig = 'ARMO') then begin
      ScanForAssets(ElementByName(e, 'Male world model'));
      ScanForAssets(ElementByName(e, 'Female world model'));
      ScanForAssets(ElementByName(e, 'Icon 2 (female)'));
    end

    else if (sig = 'CELL') then begin
      ProcessAsset(ElementByPath(e, 'XNAM'));
      ProcessAsset(ElementByPath(e, 'XWEM'));
    end

    else if (sig = 'CLMT') then begin
      ProcessAsset(ElementByPath(e, 'FNAM'));
      ProcessAsset(ElementByPath(e, 'GNAM'));
    end
    
    else if (sig = 'DEBR') then
      ScanForAssets(ElementByPath(e, 'Models'))

    else if (sig = 'EFSH') then begin
      ProcessAsset(ElementByPath(e, 'ICO2'));
      ProcessAsset(ElementByPath(e, 'NAM7'));
      ProcessAsset(ElementByPath(e, 'NAM8'));
      ProcessAsset(ElementByPath(e, 'NAM9'));
    end

    else if (sig = 'FURN') then
      ProcessAsset(ElementByPath(e, 'XMRK'))

    else if (sig = 'LSCR') then
      ProcessAsset(ElementByPath(e, 'MOD2'))

    else if sig = 'LENS' then begin
      ents := ElementByName(e, 'Lens Flare Sprites');
      for i := 0 to Pred(ElementCount(ents)) do
        ProcessAsset( ElementBySignature(ElementByIndex(ents, i), 'FNAM') );
    end

    else if (sig = 'MUST') then begin
      ProcessAsset(ElementByPath(e, 'ANAM'));
      ProcessAsset(ElementByPath(e, 'BNAM'));
    end

    else if (sig = 'PROJ') then
      ProcessAsset(ElementByPath(e, 'Muzzle Flash Model\NAM1'))

    else if (sig = 'QUST') then begin
      if GetElementNativeValues(e, 'DNAM\Flags') and 1 > 0 then
        if not Assigned(Master(e)) or (GetElementNativeValues(Master(e), 'DNAM\Flags') and 1 = 0) then
          ProcessAssetEx(e, 'seq\' + ChangeFileExt(GetFileName(e), '.seq'), 'Start-game enabled quest requires SEQ file ' + Name(e), atSeqFile);
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

    // STAT LOD
    else if (sig = 'STAT') and ElementExists(e, 'MNAM') then begin
      ents := ElementBySignature(e, 'MNAM');
      for i := 0 to Pred(ElementCount(ents)) do begin
        ent := ElementByIndex(ents, i);
        s := wbNormalizeResourceName(GetElementEditValues(ent, 'Mesh'), resMesh);
        ProcessAssetEx(e, s, 'Static LOD level ' + IntToStr(i) + ' mesh for ' + Name(e), atLODAsset);
      end;
    end

    // TREE LOD
    // we don't know if a mesh must have lod or not since it is not referenced directly from record, so skip it in "check missing" mode
    else if (sig = 'TREE') and (optMode <> wmCheck) then begin
      s := GetElementEditValues(e, 'Model\MODL');
      if s <> '' then begin
        s := wbNormalizeResourceName(ChangeFileExt(s, '') + '_lod_flat.nif', resMesh);
        ProcessAssetEx(e, s, 'Tree LOD mesh for ' + Name(e), atLODAsset);
      end;
    end

    else if (sig = 'TXST') then
      ScanForAssets(ElementByPath(e, 'Textures (RGB/A)'))

    else if (sig = 'WATR') then
      ProcessAsset(ElementByPath(e, 'NAM2'))

    else if (sig = 'WRLD') then begin
      ScanForAssets(ElementByPath(e, 'Cloud Model\Model'));
      ProcessAsset(ElementByPath(e, 'XNAM'));
      ProcessAsset(ElementByPath(e, 'TNAM'));
      ProcessAsset(ElementByPath(e, 'UNAM'));
    end

    else if (sig = 'WTHR') then begin
      // check cloud texture layers except disabled ones
      sl := TStringList.Create;
      sl.CommaText := '00TX,10TX,20TX,30TX,40TX,50TX,60TX,70TX,80TX,90TX,:0TX,;0TX,<0TX,=0TX,>0TX,?0TX,@0TX,A0TX,B0TX,C0TX,D0TX,E0TX,F0TX,G0TX,H0TX,I0TX,J0TX,K0TX,L0TX';
      DisabledClouds := GetElementNativeValues(e, 'NAM1');
      for i := 0 to Pred(sl.Count) do begin
        if DisabledClouds and (1 shl i) = 0 then
          ProcessAsset(ElementBySignature(e, sl[i]));
      end;
      sl.Free;
      ProcessAsset(ElementByPath(e, 'Aurora\Model\MODL'));
    end;
    
  end

  
  // --------------------------------------------------------------------------------
  // Oblivion
  // --------------------------------------------------------------------------------
  else if wbGameMode = gmTES4 then begin
  
    if (sig = 'WTHR') then begin
      ProcessAsset(ElementByPath(e, 'DNAM'));
      ProcessAsset(ElementByPath(e, 'CNAM'));
    end;
  
  end
  
  
  // --------------------------------------------------------------------------------
  // Fallout 3 and New Vegas
  // --------------------------------------------------------------------------------
  else if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then begin

    if (sig = 'ARMA') or (sig = 'ARMO') then begin
      ScanForAssets(ElementByPath(e, 'Male biped model'));
      ScanForAssets(ElementByPath(e, 'Male world model'));
      ScanForAssets(ElementByPath(e, 'Female biped model'));
      ScanForAssets(ElementByPath(e, 'Female world model'));
      ProcessAsset(ElementBySignature(e, 'MICO'));
      ProcessAsset(ElementBySignature(e, 'ICO2'));
      ProcessAsset(ElementBySignature(e, 'MIC2'));
    end

    else if (sig = 'CCRD') then
      ScanForAssets(ElementByPath(e, 'High Res Image'))

    else if (sig = 'CLMT') then begin
      ProcessAsset(ElementByPath(e, 'FNAM'));
      ProcessAsset(ElementByPath(e, 'GNAM'));
    end
  
    else if (sig = 'CREA') then begin
      ScanForAssets(ElementByPath(e, 'NIFZ'));
      ScanForAssets(ElementByPath(e, 'KFFZ'));
    end

    else if (sig = 'CSNO') then begin
      ProcessAsset(ElementByPath(e, 'MODL'));
      ProcessAsset(ElementByPath(e, 'MOD2'));
      ProcessAsset(ElementByPath(e, 'MOD3'));
      ProcessAsset(ElementByPath(e, 'MOD4'));
      ScanForAssets(ElementByPath(e, 'Casino Chip Models'));
      ScanForAssets(ElementByPath(e, 'Slot Reel Textures'));
      ScanForAssets(ElementByPath(e, 'BlackJack Decks'));
    end

    else if (sig = 'DEBR') then
      ScanForAssets(ElementByPath(e, 'Models'))

    else if (sig = 'EFSH') then begin
      ProcessAsset(ElementByPath(e, 'ICO2'));
      ProcessAsset(ElementByPath(e, 'NAM7'));
    end

    else if (sig = 'MSET') then begin
      ProcessAsset(ElementByPath(e, 'NAM2'));
      ProcessAsset(ElementByPath(e, 'NAM3'));
      ProcessAsset(ElementByPath(e, 'NAM4'));
      ProcessAsset(ElementByPath(e, 'NAM5'));
      ProcessAsset(ElementByPath(e, 'NAM6'));
      ProcessAsset(ElementByPath(e, 'NAM7'));
    end

    else if (sig = 'MUSC') then
      ProcessAsset(ElementByPath(e, 'FNAM'))

    else if (sig = 'PROJ') then
      ProcessAsset(ElementByPath(e, 'Muzzle Flash Model\NAM1'))

    else if (sig = 'RACE') then begin
      ScanForAssets(ElementByPath(e, 'Head Data'));
      ScanForAssets(ElementByPath(e, 'Female Head Data'));
      ScanForAssets(ElementByPath(e, 'Body Data'));
    end

    else if (sig = 'RGDL') then
      ProcessAsset(ElementByPath(e, 'ANAM'))

    else if (sig = 'SOUN') then
      ProcessAsset(ElementByPath(e, 'FNAM'))

    // Statics LOD
    // we don't know if a mesh must have lod or not since it is not referenced directly from record, so skip it in "check missing" mode
    else if (sig = 'STAT') and (optMode <> wmCheck) then begin
      s := GetElementEditValues(e, 'Model\MODL');
      if s <> '' then begin
        s := wbNormalizeResourceName(ChangeFileExt(s, '') + '_lod.nif', resMesh);
        ProcessAssetEx(e, s, 'Static LOD mesh for ' + Name(e), atLODAsset);
      end;
    end

    // Trees billboard LOD
    else if (sig = 'TREE') and (optMode <> wmCheck) then begin
      s := ExtractFileName(GetElementEditValues(e, 'Model\MODL'));
      if s <> '' then begin
        s := 'textures\trees\billboards\' + ChangeFileExt(s, '.dds');
        ProcessAssetEx(e, s, 'Tree billboard LOD texture for ' + Name(e), atLODAsset);
      end;
    end

    else if (sig = 'TXST') then
      ScanForAssets(ElementByPath(e, 'Textures (RGB/A)'))

    else if (sig = 'WATR') then
      ProcessAsset(ElementByPath(e, 'NNAM'))

    else if (sig = 'WEAP') then begin
      ScanForAssets(ElementByPath(e, 'Shell Casing Model'));
      ScanForAssets(ElementByPath(e, 'Scope Model'));
      ScanForAssets(ElementByPath(e, 'World Model'));
      ProcessAsset(ElementByPath(e, 'MWD1'));
      ProcessAsset(ElementByPath(e, 'MWD2'));
      ProcessAsset(ElementByPath(e, 'MWD3'));
      ProcessAsset(ElementByPath(e, 'MWD4'));
      ProcessAsset(ElementByPath(e, 'MWD5'));
      ProcessAsset(ElementByPath(e, 'MWD6'));
      ProcessAsset(ElementByPath(e, 'MWD7'));
    end

    else if (sig = 'WRLD') then begin
      ProcessAsset(ElementByPath(e, 'XNAM'));
      ProcessAsset(ElementByPath(e, 'NNAM'));
    end

    else if (sig = 'WTHR') then begin
      ProcessAsset(ElementByPath(e, 'DNAM'));
      ProcessAsset(ElementByPath(e, 'CNAM'));
      ProcessAsset(ElementByPath(e, 'ANAM'));
      ProcessAsset(ElementByPath(e, 'BNAM'));
    end;
  end

  
  // --------------------------------------------------------------------------------
  // Fallout 4
  // --------------------------------------------------------------------------------
  else if wbGameMode = gmFO4 then begin
  
    // generic second icon common for records
    ProcessAsset(ElementBySignature(e, 'MICO'));

    // papyrus scripts
    if optAsset and atPapyrusScript > 0 then
      ScanForPapyrusScripts(ElementBySignature(e, 'VMAD'));

    if sig = 'ARMA' then begin
      ProcessAsset(ElementByPath(e, 'Male world model\MOD2'));
      ProcessAsset(ElementByPath(e, 'Female world model\MOD3'));
      ProcessAsset(ElementByPath(e, 'Male 1st Person\MOD4'));
      ProcessAsset(ElementByPath(e, 'Female 1st Person\MOD5'));
    end

    else if sig = 'ARMO' then begin
      ProcessAsset(ElementByPath(e, 'Male world model\MOD2'));
      ProcessAsset(ElementByPath(e, 'Female world model\MOD4'));
      ProcessAsset(ElementBySignature(e, 'ICO2'));
      ProcessAsset(ElementBySignature(e, 'MIC2'));
    end

    else if sig = 'BPTD' then begin
      ents := ElementByName(e, 'Body Parts');
      for i := 0 to Pred(ElementCount(ents)) do
        ProcessAsset( ElementBySignature(ElementByIndex(ents, i), 'NAM1') );
    end

    else if (sig = 'DEBR') then
      ScanForAssets(ElementByPath(e, 'Models'))
    
    else if (sig = 'EFSH') then begin
      ProcessAsset(ElementBySignature(e, 'ICO2'));
      ProcessAsset(ElementBySignature(e, 'NAM7'));
      ProcessAsset(ElementBySignature(e, 'NAM8'));
      ProcessAsset(ElementBySignature(e, 'NAM9'));
    end

    else if (sig = 'FURN') then
      ProcessAsset(ElementBySignature(e, 'XMRK'))
  
    else if (sig = 'HDPT') then
      ScanForAssets(ElementByName(e, 'Parts'))
  
    else if (sig = 'IDLE') then begin
      ProcessAsset(ElementBySignature(e, 'DNAM'));
      ProcessAsset(ElementBySignature(e, 'GNAM'));
    end
  
    else if (sig = 'IMGS') then
      ProcessAsset(ElementBySignature(e, 'TX00'))
  
    else if sig = 'LENS' then begin
      ents := ElementByName(e, 'Lens Flare Sprites');
      for i := 0 to Pred(ElementCount(ents)) do
        ProcessAsset( ElementBySignature(ElementByIndex(ents, i), 'FNAM') );
    end

    else if (sig = 'LIGH') then
      ProcessAsset(ElementBySignature(e, 'NAM0'))
  
    else if (sig = 'LSCR') then
      ProcessAsset(ElementByPath(e, 'MOD2'))
  
    else if (sig = 'MATT') then
      ProcessAsset(ElementByPath(e, 'ANAM'))
  
    else if (sig = 'MESG') then
      ProcessAsset(ElementByPath(e, 'SNAM'))
  
    else if sig = 'MSWP' then begin
      ents := ElementByName(e, 'Material Substitutions');
      for i := 0 to Pred(ElementCount(ents)) do
        ProcessAsset( ElementBySignature(ElementByIndex(ents, i), 'SNAM') );
    end
  
    else if (sig = 'MUSC') then begin
      ProcessAsset(ElementByPath(e, 'ANAM'));
      ProcessAsset(ElementByPath(e, 'BNAM'));
    end

    else if (sig = 'NOTE') then begin
      s := GetElementEditValues(e, 'PNAM');
      if s <> '' then
        ProcessAssetEx(e, NormalizePath(s, atProgram), 'PipBoy program for ' + Name(e), atProgram);
    end

    else if (sig = 'PERK') then
      ProcessAsset(ElementByPath(e, 'FNAM'))

    else if (sig = 'PROJ') then
      ProcessAsset(ElementByPath(e, 'Muzzle Flash Model\NAM1'))

    else if (sig = 'QUST') then
      ProcessAsset(ElementByPath(e, 'SNAM'))
  
    else if (sig = 'RACE') then begin
      ProcessAsset(ElementByPath(e, 'ANAM - Male Skeletal Model'));
      ProcessAsset(ElementByPath(e, 'ANAM - Female Skeletal Model'));
      ScanForAssets(ElementByPath(e, 'Body Data'));
      ProcessAsset(ElementByPath(e, 'Male Behavior Graph\Model\MODL'));
      ProcessAsset(ElementByPath(e, 'Female Behavior Graph\Model\MODL'));
      // need to scan tint layers for textures, but whatever... noone creates new races for FO4
    end
  
    else if (sig = 'SNDR') then
      ScanForAssets(ElementByPath(e, 'Sounds'))

    else if (sig = 'SPGD') then
      ScanForAssets(ElementByPath(e, 'MNAM'))
  
    // STAT LOD
    else if (sig = 'STAT') and ElementExists(e, 'MNAM') then begin
      ents := ElementBySignature(e, 'MNAM');
      for i := 0 to Pred(ElementCount(ents)) do begin
        ent := ElementByIndex(ents, i);
        s := wbNormalizeResourceName(GetElementEditValues(ent, 'Mesh'), resMesh);
        ProcessAssetEx(e, s, 'Static LOD level ' + IntToStr(i) + ' mesh for ' + Name(e), atLODAsset);
      end;
    end

    else if (sig = 'TERM') then begin
      ProcessAsset(ElementBySignature(e, 'XMRK'));
      ents := ElementByName(e, 'Menu Items');
      for i := 0 to Pred(ElementCount(ents)) do
        ProcessAsset( ElementBySignature(ElementByIndex(ents, i), 'VNAM') );
    end
    
    else if (sig = 'TXST') then begin
      ScanForAssets(ElementByPath(e, 'Textures (RGB/A)'));
      ProcessAsset(ElementByPath(e, 'MNAM'));
    end
  
    else if (sig = 'WATR') then begin
      ProcessAsset(ElementByPath(e, 'NAM2'));
      ProcessAsset(ElementByPath(e, 'NAM3'));
      ProcessAsset(ElementByPath(e, 'NAM4'));
    end

    else if (sig = 'WEAP') then
      ProcessAsset(ElementByPath(e, '1st Person Model\MOD4'))
    
    else if (sig = 'WRLD') then begin
      ProcessAsset(ElementByPath(e, 'XWEM'));
      ScanForAssets(ElementByPath(e, 'Cloud Model\Model'));
    end

    else if (sig = 'WTHR') then begin
      // check cloud texture layers except disabled ones
      sl := TStringList.Create;
      sl.CommaText := '00TX,10TX,20TX,30TX,40TX,50TX,60TX,70TX,80TX,90TX,:0TX,;0TX,<0TX,=0TX,>0TX,?0TX,@0TX,A0TX,B0TX,C0TX,D0TX,E0TX,F0TX,G0TX,H0TX,I0TX,J0TX,K0TX,L0TX';
      DisabledClouds := GetElementNativeValues(e, 'NAM1');
      for i := 0 to Pred(sl.Count) do begin
        if DisabledClouds and (1 shl i) = 0 then
          ProcessAsset(ElementBySignature(e, sl[i]));
      end;
      sl.Free;
      ProcessAsset(ElementByPath(e, 'Aurora\Model\MODL'));
    end;

  end;
end;

//==========================================================================
function Finalize: integer;
var
  dlgSave: TSaveDialog;
  json: TJSONArray;
  slNoDups: TStringList;
  i: integer;
begin
  if optMode = wmListCSV then begin
    dlgSave := TSaveDialog.Create(nil);
    try
      dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
      dlgSave.InitialDir := wbDataPath;
      dlgSave.FileName := 'UsedAssets.csv';
      if dlgSave.Execute then begin
        AddMessage('Saving assets list to ' + dlgSave.FileName);
        slDump.SaveToFile(dlgSave.FileName);
      end;
    finally
      dlgSave.Free;
    end;
    slDump.Free;
  end;
  
  if optMode = wmListJSON then begin
    dlgSave := TSaveDialog.Create(nil);
    try
      dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
      dlgSave.InitialDir := wbDataPath;
      dlgSave.FileName := 'UsedAssets.achlist';
      if dlgSave.Execute then begin
        slNoDups := TStringList.Create;
        slNoDups.Sorted := True;
        slNoDups.Duplicates := dupIgnore;
        slNoDups.Assign(slDump);
        json := TJSONArray.Create;
        for i := 0 to slNoDups.Count - 1 do
          json.Add('data\' + slNoDups[i]);
        AddMessage('Saving assets list to ' + dlgSave.FileName);
        json.SaveToFile(dlgSave.FileName, False);
        json.Free;
        slNoDups.Free;
      end;
    finally
      dlgSave.Free;
    end;
    slDump.Free;
  end;
  
  slAssetsType.Free;
  slAssetsExt.Free;
  slContainers.Free;
  slTextures.Free;
  slChecksum.Free;
  slRes.Free;
  sl.Free;
end;

end.