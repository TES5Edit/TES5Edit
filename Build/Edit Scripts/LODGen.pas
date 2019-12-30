{
  LOD Generator by Ehamloptiran and Zilav
}
unit xLODGen;

const
  sLODOptions = ',Full model,Static LOD4,Static LOD8,Static LOD16,_FAR model';
  iLODNone = 0;
  iLODFull = 1;
  iLOD4 = 2;
  iLOD8 = 3;
  iLOD16 = 4;
  iLODFar = 5;

  // run LODGen.exe
  bExecuteLODGen = True; // True/False

  // Atlas options
  bBuildAtlas = True;
  iAtlasTextureSize = 512; // max size of source lod texture to be included on atlas
  iAtlasTileSize = 512; // max size of tile on atlas, source texture is rescaled if above
  iAtlasWidth = 2048;
  iAtlasHeight = 2048;
  fUVRange = 1.5; // put textures on atlas having -UVRange <= uv <= UVRange in lod nif models

  // vanilla lOD meshes having translation/rotation that must be ignored
  sMeshIgnoreTranslationTES5 =
    'meshes\lod\solitude\cwtower01_lod.nif' + ',' +
    'meshes\lod\solitude\sfarmhousesilo_lod.nif' + ',' +
    'meshes\lod\solitude\slumbermill01_lod.nif' + ',' +
    'meshes\lod\solitude\spatiowall02_lod.nif' + ',' +
    'meshes\lod\solitude\spatiowall03_lod.nif' + ',' +
    'meshes\lod\solitude\spatiowall30_lod.nif' + ',' +
    'meshes\lod\solitude\spatiowallsteps01_lod.nif' + ',' +
    'meshes\lod\solitude\spatiowallsteps02_lod.nif' + ',' +
    'meshes\lod\solitude\sstyrrshouse_lod.nif' + ',' +
    'meshes\lod\solitude\sthe winking skeever_lod.nif' + ',' +
    'meshes\lod\windhelm\wharena_lod.nif' + ',' +
    'meshes\lod\windhelm\whbrunwulfsq_lod.nif' + ',' +
    'meshes\lod\windhelm\whgrayquarter_lod.nif' + ',' +
    'meshes\lod\windhelm\whinnerwall01_lod.nif' + ',' +
    'meshes\lod\windhelm\whinnerwall02_lod.nif' + ',' +
    'meshes\lod\windhelm\whinnland_lod.nif' + ',' +
    'meshes\lod\windhelm\whmaingate_lod.nif' + ',' +
    'meshes\lod\windhelm\whmarket01_lod.nif' + ',' +
    'meshes\lod\windhelm\whouterwall3_lod.nif' + ',' +
    'meshes\lod\windhelm\whpalace_lod.nif' + ',' +
    'meshes\lod\windhelm\whtempletalos_lod.nif' + ',' +
    'meshes\lod\windhelm\whvalunstrad_lod.nif';

var
  slLODTypes, slLOD, slCache, slCacheHPLod, slExport: TStringList;
  slLODMeshes, slLODTextures: TwbFastStringList;
  lstSkip: TList;
  LODRefs: integer;
  LODGenWorld: IInterface;
  LODGenExport, LODGenParams: string;
  sTitle, sExport, sDestination, sDataPath: string;
  bFallout: Boolean;
  sLODBaseObjects: string;

  frm: TForm;
  btnOk, btnCancel, btnSave, btnLoad, btnDefault, btnExport, btnDestination, btnDataPath: TButton;
  cbWorld, cbLODLevel, cbLODX, cbLODY: TComboBox;
  lvRules: TListView;
  SelectedRuleIndex: integer;
  gbOptions: TGroupBox;
  chkDontFixTangents, chkNoTangents, chkNoColors, chkNoMaterial: TCheckBox;
  chkRemoveUnseen, chkIgnoreWater: TCheckBox;
  edExport, edDestination, edDataPath, edLODScale: TEdit;

//============================================================================
// get index of Item in Items, or 0 if not found and Items are not empty
function IndexIn(Items: TStrings; Item: string): integer;
begin
  Result := Items.IndexOf(Item);
  if (Result = -1) and (Items.Count > 0) then
    Result := 0;
end;

//============================================================================
// name of LOD settings file for worldspace
function LODSettingsFileName(wrld: IInterface): string;
begin
  if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then
    Result := 'lodsettings\' + EditorID(wrld) + '.dlodsettings'
  else
    Result := 'lodsettings\' + EditorID(wrld) + '.lod';
end;

//============================================================================
// does worldspace have a lod?
function HasLOD(wrld: IInterface): boolean;
begin
  // a presence of lod settings file
  Result := ResourceExists(LODSettingsFileName(wrld));
end;

//============================================================================
// get south west cell of lod
function LODCellSW(wrld: IInterface; var SWCellX, SWCellY: integer): Boolean;
var
  BytesStream: TBytesStream;
  lodsettings: TBinaryReader;
begin
  if not HasLOD(wrld) then
    Exit;

  // read from lod settings file
  BytesStream := TBytesStream.Create(ResourceOpenData('', LODSettingsFileName(wrld)));
  lodsettings := TBinaryReader.Create(BytesStream);
  try
    if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then
      BytesStream.Position := 12;
    SWCellX := lodsettings.ReadSmallInt;
    SWCellY := lodsettings.ReadSmallInt;
    Result := True;
  finally
    lodsettings.Free;
    BytesStream.Free;
  end;
end;

//============================================================================
// getting lod file for a record depending on lod type
function LODMeshFor(rec: IInterface; LodType: integer): string;
begin
  if LodType = iLODNone then
    Exit
  else if LodType = iLODFull then
    Result := GetElementEditValues(rec, 'Model\MODL')
  else if LODType = iLOD4 then
    Result := GetElementEditValues(rec, 'MNAM\LOD #0 (Level 0)\Mesh')
  else if LODType = iLOD8 then
    Result := GetElementEditValues(rec, 'MNAM\LOD #1 (Level 1)\Mesh')
  else if LODType = iLOD16 then
    Result := GetElementEditValues(rec, 'MNAM\LOD #2 (Level 2)\Mesh')
  else if LODType = iLODFar then begin
    Result := GetElementEditValues(rec, 'Model\MODL');
    Result := Copy(Result, 1, Length(Result) - 4);
    if bFallout then
      Result := Result + '_lod.nif'
    else
      Result := Result + '_far.nif';
  end else
    Exit;

  if Result <> '' then begin
    Result := wbNormalizeResourceName(Result, resMesh);
    if LODType = iLODFar then
      if not ResourceExists(Result) then Result := '';
  end;
end;

//============================================================================
procedure ProcessReference(e: IInterface);
var
  i, j, idx, statfid: integer;
  stat: IInterface;
  s, mat, mFull, m4, m8, m16, scl: string;
begin
  stat := BaseRecord(e);
  statfid := GetLoadOrderFormID(stat);
  // check if to skip
  if lstSkip.IndexOf(statfid) <> -1 then
    Exit;

  // skip persistent refs of never fade statics in Skyrim
  if (wbGameMode = gmTES5) and GetIsPersistent(e) and (GetElementNativeValues(stat, 'Record Header\Record Flags') and $00000004 > 0) then
    Exit;
  
  // getting lod files from cache
  idx := slCache.IndexOfObject(statfid);
  // not in cache
  if idx = -1 then begin
    stat := WinningOverride(stat);
    mFull := LODMeshFor(stat, iLODFull);
    // checking lod rules
    for i := 0 to Pred(slLOD.Count) do begin
      j := slLOD.Objects[i];
      // VWD only?
      if j and $01000000 = $01000000 then
        if not GetIsVisibleWhenDistant(stat) then
          Continue;
      if Pos(slLOD[i], mFull) > 0 then begin
        m4 := LODMeshFor(stat, j and $FF);
        // other LOD levels only for Skyrim
        if wbGameMode = gmTES5 then begin
          m8 := LODMeshFor(stat, j shr 8 and $FF);
          m16 := LODMeshFor(stat, j shr 16 and $FF);
        end;
        
        if (Length(m4) + Length(m8) + Length(m16)) > 0 then begin
          // LOD material detection for Skyrim
          if wbGameMode = gmTES5 then begin
            mat := EditorID(LinksTo(ElementByPath(stat, 'DNAM\Material')));
            if Pos('Snow', mat) > 0 then mat := 'Snow' else
              if Pos('Ash', mat) > 0 then mat := 'Ash' else
                mat := '';
          end;
          // a tab separated string of Editor ID, flags, material, full mesh and lod files
          s := EditorID(stat) + #9 + IntToHex(GetElementNativeValues(stat, 'Record Header\Record Flags'), 8) + #9 +
               mat + #9 + mFull + #9 + m4 + #9 + m8 + #9 + m16;
          idx := slCache.Count;
          slCache.AddObject(s, statfid);
          
          // Fallout: High Priority LOD info variation with m4 model for m8, at the same index as normal cache
          if bFallout then begin
            s := EditorID(stat) + #9 + IntToHex(GetElementNativeValues(stat, 'Record Header\Record Flags'), 8) + #9 +
                 mat + #9 + mFull + #9 + m4 + #9 + m4 + #9 + m16;
            slCacheHPLod.Add(s)
          end;

          // list of used lod meshes
          if m4 <> '' then slLODMeshes.Add(m4);
          if m8 <> '' then slLODMeshes.Add(m8);
          if m16 <> '' then slLODMeshes.Add(m16);
        end;
        
        Break;
      end;
    end;
  end;
  
  // not a lod object: no matching lod rules and not in cache
  if idx = -1 then begin
    lstSkip.Add(statfid);
    Exit;
  end;

  // get fallout high priority lod from separate cache
  if bFallout and (GetElementNativeValues(e, 'Record Header\Record Flags') and $00010000 <> 0) then
    s := slCacheHPLod[idx]
  else
    s := slCache[idx];

  // reference scale
  if ElementExists(e, 'XSCL') then
    scl := GetElementEditValues(e, 'XSCL')
  else
    scl := '1.0';

  slExport.Add(Format('%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s', [
    IntToHex(GetLoadOrderFormID(e), 8),
    IntToHex(GetElementNativeValues(e, 'Record Header\Record Flags'), 8),
    GetElementEditValues(e, 'DATA\Position\X'),
    GetElementEditValues(e, 'DATA\Position\Y'),
    GetElementEditValues(e, 'DATA\Position\Z'),
    GetElementEditValues(e, 'DATA\Rotation\X'),
    GetElementEditValues(e, 'DATA\Rotation\Y'),
    GetElementEditValues(e, 'DATA\Rotation\Z'),
    scl,
    s
  ]));
  Inc(LODRefs);
end;

//============================================================================
procedure IterateWorldspace(e: IInterface);
var
  lst: TList;
  i: integer;
begin
  lst := TList.Create;
  AddMessage('Gathering references...');
  wbFindREFRsByBase(e, sLODBaseObjects, 7, lst);
  AddMessage('Filtering for valid LOD references...');
  for i := 0 to lst.Count - 1 do
    ProcessReference(ObjectToElement(lst[i]));
  lst.Free;
end;

//============================================================================
function ExportWorldspace(wrld: IInterface): Boolean;
var
  x, y, i: integer;
  ent: IInterface;
  slHeader, sl: TStringList;
  AtlasName, AtlasMapName: string;
begin
  slExport.Clear;
  slCache.Clear;
  slCacheHPLod.Clear;
  lstSkip.Clear;
  slLODMeshes.Clear;
  slLODTextures.Clear;

  Result := LODCellSW(wrld, x, y);
  if not Result then begin
    AddMessage('Unable to open lod settings file for worldspace ' + LODSettingsFileName(wrld));
    Exit;
  end;

  AddMessage('Building list of LOD objects, please wait...');
  LODRefs := 0;
  IterateWorldspace(wrld);

  if slExport.Count <> 0 then begin
    // make sure atlas folder exists
    {if not DirectoryExists(ExtractFilePath(sDestination)) then
      if not ForceDirectories(ExtractFilePath(sDestination)) then begin
        AddMessage('Error: can not create output folder for LOD ' + ExtractFilePath(sDestination));
        Exit;
      end;}

    // building atlas
    if bBuildAtlas then begin
      // get list of diffuse textures within UVRange in provided list of meshes
      wbGetUVRangeTexturesList(slLODMeshes, slLODTextures, fUVRange);
      if slLODTextures.Count > 1 then begin
        // remove HD LOD texture if there
        if wbGameMode = gmTES5 then begin
          i := slLODTextures.IndexOf(wbNormalizeResourceName(GetElementEditValues(wrld, 'TNAM'), resTexture));
          if i <> -1 then slLODTextures.Delete(i);
        end;
        // atlas file name and map name
        if Pos('meshes\', LowerCase(sDestination)) = 0 then begin
          AddMessage('Error: LODGen path must contain "meshes\" folder if building atlas');
          Exit;
        end else
          AtlasName := StringReplace(sDestination, 'meshes\', 'textures\', [rfIgnoreCase]) + EditorID(wrld) + 'ObjectsLOD.dds';
        AtlasMapName := ScriptsPath + 'LODGen ' + EditorID(wrld) + ' Atlas Map.txt';
        // make sure atlas folder exists
        if not DirectoryExists(ExtractFilePath(AtlasName)) then
          if not ForceDirectories(ExtractFilePath(AtlasName)) then begin
            AddMessage('Error: can not create output folder for atlas ' + ExtractFilePath(AtlasName));
            Exit;
          end;
        AddMessage('Building LOD textures atlas: ' + AtlasName);
        wbBuildAtlasFromTexturesList(
          slLODTextures,
          iAtlasTextureSize,
          iAtlasTileSize,
          iAtlasWidth,
          iAtlasHeight,
          AtlasName,
          AtlasMapName
        );
      end;
    end;
    slHeader := TStringList.Create;
    slHeader.Add('GameMode=' + wbAppName);
    slHeader.Add('Worldspace=' + EditorID(wrld));
    slHeader.Add('CellSW=' + Format('%d %d', [x, y]));
    if wbGameMode = gmTES5 then begin
      slHeader.Add('TextureDiffuseHD=' + GetElementEditValues(wrld, 'TNAM'));
      slHeader.Add('TextureNormalHD=' + GetElementEditValues(wrld, 'UNAM'));
    end;
    if (AtlasMapName <> '') and FileExists(AtlasMapName) then begin
      slHeader.Add('TextureAtlasMap=' + AtlasMapName);
      if not bFallout then
        slHeader.Add('AtlasTolerance=' + Format('%1.1f', [fUVRange - 1.0]))
      else
        slHeader.Add('AtlasTolerance=100000.0');
    end;
    slHeader.Add('PathData=' + DataPath);
    slHeader.Add('PathOutput=' + sDestination);
    // list of BSAs and meshes to ignore translation/rotation
    sl := TStringList.Create;
    ResourceContainerList(sl);
    for i := 0 to sl.Count - 2 do
      slHeader.Add('Resource=' + sl[i]);
    sl.Clear;
    sl.Delimiter := ',';
    sl.StrictDelimiter := True;
    if wbGameMode = gmTES5 then
      sl.DelimitedText := sMeshIgnoreTranslationTES5;
    for i := 0 to Pred(sl.Count) do
      slHeader.Add('IgnoreTranslation=' + wbNormalizeResourceName(sl[i], resMesh));
    sl.Free;
    slHeader.AddStrings(slExport);
    AddMessage('Saving objects LOD data to ' + sExport);
    slHeader.SaveToFile(sExport);
    slHeader.Free;
    AddMessage(Format('LOD references: %d, unique LOD objects: %d', [LODRefs, slCache.Count]));
  end
  else begin
    MessageDlg('No LOD objects in ' + Name(wrld) + ' world.', mtInformation, [mbOk], 0);
    Result := False;
    Exit;
  end;
  Result := True;
end;

//============================================================================
// Save preset
procedure PresetSave(aFileName: string);
var
  ini: TMemIniFile;
  i, j: integer;
  s: string;
begin
  ini := TMemIniFile.Create(aFileName);
  ini.WriteString(wbGameName, 'World', cbWorld.Text);
  ini.WriteString(wbGameName, 'Export', edExport.Text);
  ini.WriteString(wbGameName, 'Destination', edDestination.Text);
  ini.WriteString(wbGameName, 'DataPath', edDataPath.Text);
  ini.WriteBool(wbGameName, 'DontFixTangents', chkDontFixTangents.Checked);
  ini.WriteBool(wbGameName, 'NoTangents', chkNoTangents.Checked);
  ini.WriteBool(wbGameName, 'NoColors', chkNoColors.Checked);
  ini.WriteBool(wbGameName, 'NoMaterial', chkNoMaterial.Checked);
  ini.WriteBool(wbGameName, 'RemoveUnseen', chkRemoveUnseen.Checked);
  ini.WriteBool(wbGameName, 'RemoveUnseenIgnoreWater', chkIgnoreWater.Checked);
  ini.WriteString(wbGameName, 'LODLevel', cbLODLevel.Text);
  ini.WriteString(wbGameName, 'LODX', cbLODX.Text);
  ini.WriteString(wbGameName, 'LODY', cbLODY.Text);
  ini.WriteString(wbGameName, 'LODScale', edLODScale.Text);
  ini.EraseSection(wbGameName + ' LODGen');
  for i := 0 to Pred(slLOD.Count) do begin
    j := slLOD.Objects[i];
    s := Format('%s,%s,%s,%s,%d', [
      slLOD[i],
      slLODTypes[j and $FF],
      slLODTypes[j shr 8 and $FF],
      slLODTypes[j shr 16 and $FF],
      j shr 24
    ]);
    ini.WriteString(wbGameName + ' LODGen', 'LODGen' + IntToStr(Succ(i)), s);
  end;
  ini.UpdateFile;
  ini.Free;
end;

//============================================================================
// Load preset
procedure PresetLoad(aFileName: string);
var
  ini: TMemIniFile;
  i, lod: integer;
  sl: TStringList;
begin
  ini := TMemIniFile.Create(aFileName);
  cbWorld.ItemIndex := IndexIn(cbWorld.Items, ini.ReadString(wbGameName, 'World', cbWorld.Text));
  edExport.Text := ini.ReadString(wbGameName, 'Export', edExport.Text);
  edDestination.Text := ini.ReadString(wbGameName, 'Destination', edDestination.Text);
  edDataPath.Text := ini.ReadString(wbGameName, 'DataPath', edDataPath.Text);
  chkDontFixTangents.Checked := ini.ReadBool(wbGameName, 'DontFixTangents', chkDontFixTangents.Checked);
  chkNoTangents.Checked := ini.ReadBool(wbGameName, 'NoTangents', chkNoTangents.Checked);
  chkNoColors.Checked := ini.ReadBool(wbGameName, 'NoColors', chkNoColors.Checked);
  chkNoMaterial.Checked := ini.ReadBool(wbGameName, 'NoMaterial', chkNoMaterial.Checked);
  chkRemoveUnseen.Checked := ini.ReadBool(wbGameName, 'RemoveUnseen', chkRemoveUnseen.Checked);
  chkIgnoreWater.Checked := ini.ReadBool(wbGameName, 'RemoveUnseenIgnoreWater', chkIgnoreWater.Checked);
  cbLODLevel.ItemIndex := IndexIn(cbLODLevel.Items, ini.ReadString(wbGameName, 'LODLevel', cbLODLevel.Text));
  cbLODX.ItemIndex := IndexIn(cbLODX.Items, ini.ReadString(wbGameName, 'LODX', cbLODX.Text));
  cbLODY.ItemIndex := IndexIn(cbLODY.Items, ini.ReadString(wbGameName, 'LODY', cbLODY.Text));
  edLODScale.Text := ini.ReadString(wbGameName, 'LODScale', edLODScale.Text);
  slLOD.Clear;
  sl := TStringList.Create;
  sl.StrictDelimiter := True;
  try
    i := 1;
    repeat
      sl.CommaText := ini.ReadString(wbGameName + ' LODGen', 'LODGen' + IntToStr(i), '');
      if sl.Count = 5 then begin
        lod := IndexIn(slLODTypes, sl[1]) + 
               IndexIn(slLODTypes, sl[2]) shl 8 + 
               IndexIn(slLODTypes, sl[3]) shl 16 +
               StrToIntDef(sl[4], 0) shl 24;
        slLOD.AddObject(sl[0], lod);
      end;
      Inc(i);
    until sl.Count <> 5;
  finally
    sl.Free;
  end;
  if slLOD.Count = 0 then
    slLOD.AddObject('\', $01040302);
  lvRules.Items.Count := slLOD.Count;
  lvRules.Refresh;
  ini.Free;
end;

//============================================================================
// fill with worldspaces that have LOD
procedure FillWorldspacesWithLOD(cmbWorld: TComboBox);
var
  i, j: integer;
  f, wrlds, wrld: IInterface;
  sl: TStringList;
  s: string;
begin
  // filling list of worldspaces
  sl := TStringList.Create;
  try
    sl.Duplicates := dupIgnore;
    sl.Sorted := True;
    for i := Pred(FileCount) downto 0 do begin
      wrlds := GroupBySignature(FileByIndex(i), 'WRLD');
      for j := 0 to Pred(ElementCount(wrlds)) do begin
        wrld := ElementByIndex(wrlds, j);
        if ElementType(wrld) <> etMainRecord then
          Continue;
        if HasLOD(wrld) then
          sl.AddObject(EditorID(wrld), MasterOrSelf(wrld));
      end;
    end;
    cmbWorld.Items.Assign(sl);
  finally
    sl.Free;
  end;
end;

//============================================================================
procedure cbWorldSelect(Sender: TObject);
begin
  edExport.Text := ScriptsPath + 'LODGen ' + TComboBox(Sender).Text + '.txt';
  if wbGameMode = gmTES5 then
    edDestination.Text := DataPath + 'meshes\terrain\' + TComboBox(Sender).Text + '\Objects'
  else if bFallout then
    edDestination.Text := DataPath + 'meshes\landscape\lod\' + TComboBox(Sender).Text + '\Blocks';
end;

//============================================================================
procedure btnExportClick(Sender: TObject);
var
  dlgSave: TSaveDialog;
begin
  dlgSave := TSaveDialog.Create(nil);
  try
    dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
    dlgSave.Filter := 'LODGen data (*.txt)|*.txt';
    dlgSave.InitialDir := ScriptsPath;
    dlgSave.FileName := edExport.Text;
    if dlgSave.Execute then
      edExport.Text := dlgSave.FileName;
  finally
    dlgSave.Free;
  end;
end;

//============================================================================
procedure btnDestinationClick(Sender: TObject);
var
  s: string;
begin
  s := SelectDirectory('Destination path', '', edDestination.Text, nil);
  if s <> '' then
    edDestination.Text := s;
end;

//============================================================================
procedure btnDataPathClick(Sender: TObject);
var
  s: string;
begin
  s := SelectDirectory('Data folder', '', edDataPath.Text, nil);
  if s <> '' then
    edDataPath.Text := s;
end;

//============================================================================
procedure btnSaveClick(Sender: TObject);
var
  dlgSave: TSaveDialog;
begin
  dlgSave := TSaveDialog.Create(nil);
  try
    dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
    dlgSave.Filter := 'LODGen preset (*.ini)|*.ini';
    dlgSave.InitialDir := ScriptsPath;
    dlgSave.FileName := 'LODGen preset ' + cbWorld.Text + '.ini';
    if dlgSave.Execute then
      PresetSave(dlgSave.FileName);
  finally
    dlgSave.Free;
  end;
end;

//============================================================================
procedure btnLoadClick(Sender: TObject);
var
  dlgOpen: TOpenDialog;
begin
  dlgOpen := TOpenDialog.Create(nil);
  try
    dlgOpen.Filter := 'LODGen preset (*.ini)|*.ini';
    dlgOpen.InitialDir := ScriptsPath;
    dlgOpen.FileName := 'LODGen preset ' + cbWorld.Text + '.ini';
    if dlgOpen.Execute then
      PresetLoad(dlgOpen.FileName);
  finally
    dlgOpen.Free;
  end;
end;

//============================================================================
procedure btnDefaultClick(Sender: TObject);
begin
  cbWorldSelect(cbWorld);
  edDataPath.Text := DataPath;
  slLOD.Clear;
  slLOD.AddObject('\', $01040302);
  lvRules.Items.Count := slLOD.Count;
  lvRules.Refresh;
  chkDontFixTangents.Checked := True;
  chkNoTangents.Checked := False;
  chkNoColors.Checked := False;
  chkNoMaterial.Checked := False;
  chkRemoveUnseen.Checked := True;
  chkIgnoreWater.Checked := False;
  cbLODLevel.ItemIndex := 0;
  cbLODX.ItemIndex := 0;
  cbLODY.ItemIndex := 0;
  edLODScale.Text := '';
end;

//===========================================================================
// on key down event handler for form
procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    TForm(Sender).ModalResult := mrCancel;
end;

//===========================================================================
// listview custom data event
procedure lvRulesData(Sender: TObject; Item: TListItem);
var
  i: integer;
begin
  Item.Caption := slLOD[Item.Index];
  i := slLOD.Objects[Item.Index];
  Item.SubItems.Add(slLODTypes[i and $FF]);
  Item.SubItems.Add(slLODTypes[i shr 8 and $FF]);
  Item.SubItems.Add(slLODTypes[i shr 16 and $FF]);
  if i shr 24 and 1 = 1 then Item.SubItems.Add('Yes') else Item.SubItems.Add('');
end;

//===========================================================================
procedure lvRulesDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Sender = lvRules) and Assigned(lvRules.GetItemAt(X, Y));
end;

//===========================================================================
procedure lvRulesDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  dropItem : TListItem;
begin
  if Sender <> Source then
    Exit;
  dropItem := lvRules.GetItemAt(X, Y);
  slLOD.Move(SelectedRuleIndex, dropItem.Index);
  dropItem.Selected := True;
  lvRules.Refresh;
end;

//===========================================================================
// on select item event handler for lod rules
procedure lvRulesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if not Selected then Exit;
  SelectedRuleIndex := Item.Index;
end;

//===========================================================================
// on double click event handler for mesh rules
procedure lvRulesDblClick(Sender: TObject);
begin
  RulesMenuEditClick(nil);
end;

//===========================================================================
// click event for lodgen rules Insert menu
procedure RulesMenuInsertClick(Sender: TObject);
var
  mesh: string;
  idx, lod, lod4, lod8, lod16: integer;
  vwd: boolean;
begin
  if Assigned(lvRules.Selected) then
    idx := lvRules.Selected.Index
  else
    idx := 0;
  lod4 := 2;
  lod8 := 3;
  lod16 := 4;
  vwd := True;
  if not EditRuleForm(mesh, lod4, lod8, lod16, vwd) then
    Exit;
  lod := 0;
  if vwd then lod := lod or $01000000;
  slLOD.InsertObject(idx, mesh, lod + lod4 + lod8 shl 8 + lod16 shl 16);
  lvRules.Items.Count := slLOD.Count;
  lvRules.Refresh;
end;

//===========================================================================
// click event for lodgen rules Edit menu
procedure RulesMenuEditClick(Sender: TObject);
var
  mesh: string;
  idx, lod, lod4, lod8, lod16: integer;
  vwd: boolean;
begin
  if not Assigned(lvRules.Selected) then
    Exit;
  idx := lvRules.Selected.Index;
  mesh := slLOD[idx];
  lod := slLOD.Objects[idx];
  if lod and $01000000 = $01000000 then vwd := True;
  lod4 := lod and $FF;
  lod8 := lod shr 8 and $FF;
  lod16 := lod shr 16 and $FF;
  if not EditRuleForm(mesh, lod4, lod8, lod16, vwd) then
    Exit;
  lod := 0;
  if vwd then lod := lod or $01000000;
  slLOD[idx] := mesh;
  slLOD.Objects[idx] := lod + lod4 + lod8 shl 8 + lod16 shl 16;
  lvRules.Refresh;
end;

//===========================================================================
// click event for lodgen rules Delete menu
procedure RulesMenuDeleteClick(Sender: TObject);
begin
  if not Assigned(lvRules.Selected) then
    Exit;
  slLOD.Delete(lvRules.Selected.Index);
  lvRules.Items.Count := slLOD.Count;
  lvRules.Refresh;
end;

//============================================================================
function CreateLabel(aParent: TControl; x, y: Integer; aCaption: string): TLabel;
begin
  Result := TLabel.Create(aParent);
  Result.Parent := aParent;
  Result.Left := x;
  Result.Top := y;
  Result.Caption := aCaption;
end;

//============================================================================
// on close event handler for options form
procedure frmOptionsFormClose(Sender: TObject; var Action: TCloseAction);
begin
  if frm.ModalResult <> mrOk then Exit;

  if cbWorld.ItemIndex = -1 then begin
    MessageDlg('No worldspace selected.', mtInformation, [mbOk], 0);
    Action := caNone;
    Exit;
  end;
  
  if (edExport.Text = '') or (edDestination.Text = '') then begin
    MessageDlg('Export file and destination path can not be empty', mtInformation, [mbOk], 0);
    Action := caNone;
    Exit;
  end;

  if slLOD.Count = 0 then begin
    MessageDlg('No mesh LOD rules specified.', mtInformation, [mbOk], 0);
    Action := caNone;
    Exit;
  end;
end;

//============================================================================
// on close event handler for lodgen rule form
procedure frmRuleFormClose(Sender: TObject; var Action: TCloseAction);
begin
  if TForm(Sender).ModalResult <> mrOk then Exit;
  if TEdit(TForm(Sender).FindComponent('edMesh')).Text = '' then begin
    MessageDlg('Mesh mask can not be empty', mtInformation, [mbOk], 0);
    Action := caNone;
  end;
end;

//============================================================================
// edit a mesh rule in a separate form
function EditRuleForm(var aMesh: string; var aLOD4, aLOD8, aLOD16: integer;
  var aVWD: Boolean): Boolean;
var
  frmRule: TForm;
  pnl: TPanel;
  btnOk, btnCancel: TButton;
  edMesh: TEdit;
  cb4, cb8, cb16: TComboBox;
  chkVWD: TCheckBox;
begin
  frmRule := TForm.Create(nil);
  try
    frmRule.Caption := 'Mesh LODGen export rule';
    frmRule.Width := 420;
    frmRule.Height := 224;
    frmRule.Position := poMainFormCenter;
    frmRule.BorderStyle := bsDialog;
    frmRule.KeyPreview := True;
    frmRule.OnKeyDown := FormKeyDown;
    frmRule.OnClose := frmRuleFormClose;

    edMesh := TEdit.Create(frmRule); edMesh.Parent := frmRule;
    edMesh.Name := 'edMesh';
    edMesh.Left := 80;
    edMesh.Top := 12;
    edMesh.Width := frmRule.Width - 100;
    CreateLabel(frmRule, 16, edMesh.Top + 4, 'Mesh mask');

    cb4 := TComboBox.Create(frmRule); cb4.Parent := frmRule;
    cb4.Left := 80;
    cb4.Top := edMesh.Top + 28;
    cb4.Width := 150;
    cb4.Style := csDropDownList;
    cb4.Items.Assign(slLODTypes);
    CreateLabel(frmRule, 16, cb4.Top + 4, 'LOD 4');

    cb8 := TComboBox.Create(frmRule); cb8.Parent := frmRule;
    cb8.Left := 80;
    cb8.Top := cb4.Top + 28;
    cb8.Width := 150;
    cb8.Style := csDropDownList;
    cb8.Items.Assign(slLODTypes);
    CreateLabel(frmRule, 16, cb8.Top + 4, 'LOD 8');

    cb16 := TComboBox.Create(frmRule); cb16.Parent := frmRule;
    cb16.Left := 80;
    cb16.Top := cb8.Top + 28;
    cb16.Width := 150;
    cb16.Style := csDropDownList;
    cb16.Items.Assign(slLODTypes);
    CreateLabel(frmRule, 16, cb16.Top + 4, 'LOD 16');

    chkVWD := TCheckBox.Create(frmRule); chkVWD.Parent := frmRule;
    chkVWD.Left := 80;
    chkVWD.Top := cb16.Top + 28;
    chkVWD.Width := 200;
    chkVWD.Caption := 'Visible when distant objects only';

    btnOk := TButton.Create(frmRule); btnOk.Parent := frmRule;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;
    btnOk.Left := frmRule.Width - 176;
    btnOk.Top := frmRule.Height - 62;
    btnCancel := TButton.Create(frmRule); btnCancel.Parent := frmRule;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := btnOk.Left + btnOk.Width + 8;
    btnCancel.Top := btnOk.Top;
    pnl := TPanel.Create(frmRule); pnl.Parent := frmRule; pnl.Left := 8; pnl.Top := btnOk.Top - 12; pnl.Width := frmRule.Width - 20; pnl.Height := 2;
    
    edMesh.Text := aMesh;
    cb4.ItemIndex := aLOD4;
    cb8.ItemIndex := aLOD8;
    cb16.ItemIndex := aLOD16;
    chkVWD.Checked := aVWD;
    
    if frmRule.ShowModal <> mrOk then
      Exit;
    
    aMesh := edMesh.Text;
    aLOD4 := cb4.ItemIndex;
    aLOD8 := cb8.ItemIndex;
    aLOD16 := cb16.ItemIndex;
    aVWD := chkVWD.Checked;
    Result := True;
  finally
    frmRule.Free;
  end;
end;

//============================================================================
procedure OptionsForm;
var
  i: integer;
  mnRules: TPopupMenu;
  MenuItem: TMenuItem;
  pnl: TPanel;
  lbl: TLabel;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := sTitle;
    frm.Width := 600;
    frm.Height := 530;
    frm.Position := poMainFormCenter;
    frm.BorderStyle := bsDialog;
    frm.KeyPreview := True;
    frm.OnKeyDown := FormKeyDown;
    frm.OnClose := frmOptionsFormClose;
    
    cbWorld := TComboBox.Create(frm); cbWorld.Parent := frm;
    cbWorld.Left := 54;
    cbWorld.Top := 12;
    cbWorld.Width := 260;
    cbWorld.Style := csDropDownList;
    cbWorld.DropDownCount := 20;
    cbWorld.OnSelect := cbWorldSelect;
    CreateLabel(frm, 16, cbWorld.Top + 4, 'World');
    
    FillWorldspacesWithLOD(cbWorld);
    if cbWorld.Items.Count > 0 then cbWorld.ItemIndex := 0;

    btnSave := TButton.Create(frm); btnSave.Parent := frm;
    btnSave.Caption := 'Save preset';
    btnSave.Left := cbWorld.Left + cbWorld.Width + 8;
    btnSave.Top := cbWorld.Top - 2;
    btnSave.OnClick := btnSaveClick;

    btnLoad := TButton.Create(frm); btnLoad.Parent := frm;
    btnLoad.Caption := 'Load preset';
    btnLoad.Left := btnSave.Left + btnSave.Width + 8;
    btnLoad.Top := btnSave.Top;
    btnLoad.OnClick := btnLoadClick;

    btnDefault := TButton.Create(frm); btnDefault.Parent := frm;
    btnDefault.Caption := 'Default';
    btnDefault.Left := btnLoad.Left + btnLoad.Width + 8;
    btnDefault.Top := btnSave.Top;
    btnDefault.OnClick := btnDefaultClick;

    edExport := TEdit.Create(frm); edExport.Parent := frm;
    edExport.Left := 100;
    edExport.Top := cbWorld.Top + cbWorld.Height + 12;
    edExport.Width := cbWorld.Width + 180;
    //edExport.ReadOnly := True;
    CreateLabel(frm, 16, edExport.Top + 4, 'LODGen export');

    btnExport := TButton.Create(frm); btnExport.Parent := frm;
    btnExport.Top := edExport.Top - 1;
    btnExport.Left := edExport.Left + edExport.Width + 6;
    btnExport.Width := 32;
    btnExport.Height := 22;
    btnExport.Caption := '...';
    btnExport.OnClick := btnExportClick;

    edDestination := TEdit.Create(frm); edDestination.Parent := frm;
    edDestination.Left := edExport.Left;
    edDestination.Top := edExport.Top + 28;
    edDestination.Width := edExport.Width;
    edDestination.ReadOnly := True;
    CreateLabel(frm, 16, edDestination.Top + 4, 'LODGen path');

    btnDestination := TButton.Create(frm); btnDestination.Parent := frm;
    btnDestination.Top := edDestination.Top - 1;
    btnDestination.Left := edDestination.Left + edDestination.Width + 6;
    btnDestination.Width := 32;
    btnDestination.Height := 22;
    btnDestination.Caption := '...';
    btnDestination.OnClick := btnDestinationClick;

    edDataPath := TEdit.Create(frm); edDataPath.Parent := frm;
    edDataPath.Left := edExport.Left;
    edDataPath.Top := edDestination.Top + 28;
    edDataPath.Width := edExport.Width;
    edDataPath.ReadOnly := True;
    CreateLabel(frm, 16, edDataPath.Top + 4, 'Data folder');

    btnDataPath := TButton.Create(frm); btnDataPath.Parent := frm;
    btnDataPath.Top := edDataPath.Top - 1;
    btnDataPath.Left := edDataPath.Left + edDataPath.Width + 6;
    btnDataPath.Width := 32;
    btnDataPath.Height := 22;
    btnDataPath.Caption := '...';
    btnDataPath.OnClick := btnDataPathClick;

    lvRules := TListView.Create(frm); lvRules.Parent := frm;
    lvRules.Left := 16;
    lvRules.Top := edDataPath.Top + 44;
    lvRules.Width := frm.Width - 40;
    lvRules.Height := 140;
    lvRules.ReadOnly := True;
    lvRules.ViewStyle := vsReport;
    lvRules.DragMode := dmAutomatic;
    lvRules.RowSelect := True;
    //lvRules.GridLines := True;
    lvRules.DoubleBuffered := True;
    lvRules.Columns.Add.Caption := 'Mesh';
    lvRules.Columns[0].Width := lvRules.Width - 354;
    lvRules.Columns.Add.Caption := 'LOD4';
    lvRules.Columns[1].Width := 90;
    lvRules.Columns.Add.Caption := 'LOD8';
    lvRules.Columns[2].Width := 90;
    lvRules.Columns.Add.Caption := 'LOD16';
    lvRules.Columns[3].Width := 90;
    lvRules.Columns.Add.Caption := 'VWD Only';
    lvRules.Columns[4].Width := 60;
    lvRules.OwnerData := True;
    lvRules.OnData := lvRulesData;
    lvRules.OnSelectItem := lvRulesSelectItem;
    lvRules.OnDblClick := lvRulesDblClick;
    lvRules.OnDragOver := lvRulesDragOver;
    lvRules.OnDragDrop := lvRulesDragDrop;
    lvRules.Items.Count := slLOD.Count;
    CreateLabel(frm, 16, lvRules.Top - 16, 'Mesh lodgen rules (right click for menu, drag&&drop to change order)');

    mnRules := TPopupMenu.Create(frm);
    lvRules.PopupMenu := mnRules;
    MenuItem := TMenuItem.Create(mnRules);
    MenuItem.Caption := 'Insert';
    MenuItem.OnClick := RulesMenuInsertClick;
    mnRules.Items.Add(MenuItem);
    MenuItem := TMenuItem.Create(mnRules);
    MenuItem.Caption := 'Delete';
    MenuItem.OnClick := RulesMenuDeleteClick;
    mnRules.Items.Add(MenuItem);
    MenuItem := TMenuItem.Create(mnRules);
    MenuItem.Caption := 'Edit';
    MenuItem.OnClick := RulesMenuEditClick;
    mnRules.Items.Add(MenuItem);
    
    gbOptions := TGroupBox.Create(frm); gbOptions.Parent := frm;
    gbOptions.Left := lvRules.Left;
    gbOptions.Top := lvRules.Top + lvRules.Height + 12;
    gbOptions.Width := lvRules.Width;
    gbOptions.Height := 144;
    gbOptions.Caption := 'LODGen Options';
    
    chkDontFixTangents := TCheckBox.Create(frm); chkDontFixTangents.Parent := gbOptions;
    chkDontFixTangents.Left := 12;
    chkDontFixTangents.Top := 18;
    chkDontFixTangents.Width := 140;
    chkDontFixTangents.Caption := 'Don''t fix tangents';
    chkDontFixTangents.Hint := 'Don''t fix tangents';
    chkDontFixTangents.ShowHint := True;
    chkDontFixTangents.Checked := True;

    chkNoTangents := TCheckBox.Create(frm); chkNoTangents.Parent := gbOptions;
    chkNoTangents.Left := 12;
    chkNoTangents.Top := 38;
    chkNoTangents.Width := 140;
    chkNoTangents.Caption := 'Don''t generate tangents';
    chkNoTangents.Hint := 'Don''t generate tangents, might actually look better for some LOD meshes. Reduces lodgen files size.';
    chkNoTangents.ShowHint := True;

    chkNoColors := TCheckBox.Create(frm); chkNoColors.Parent := gbOptions;
    chkNoColors.Left := 12;
    chkNoColors.Top := 58;
    chkNoColors.Width := 180;
    chkNoColors.Caption := 'Don''t generate vertex colors';
    chkNoColors.Hint := 'Don''t generate vertex colors. Reduces lodgen files size.';
    chkNoColors.ShowHint := True;

    chkNoMaterial := TCheckBox.Create(frm); chkNoMaterial.Parent := gbOptions;
    chkNoMaterial.Left := 12;
    chkNoMaterial.Top := 78;
    chkNoMaterial.Width := 180;
    chkNoMaterial.Caption := 'Ignore material';
    chkNoMaterial.Hint := 'Don''t use objSnow for statics with directional material.';
    chkNoMaterial.ShowHint := True;

    chkRemoveUnseen := TCheckBox.Create(frm); chkRemoveUnseen.Parent := gbOptions;
    chkRemoveUnseen.Left := 12;
    chkRemoveUnseen.Top := 98;
    chkRemoveUnseen.Width := 380;
    chkRemoveUnseen.Caption := 'Remove unseen faces';
    chkRemoveUnseen.Hint := 'Remove mesh parts that are under the landscape or water. You must have landscape LOD files generated for selected worldspace';
    chkRemoveUnseen.ShowHint := True;
    chkRemoveUnseen.Checked := True;

    chkIgnoreWater := TCheckBox.Create(frm); chkIgnoreWater.Parent := gbOptions;
    chkIgnoreWater.Left := 32;
    chkIgnoreWater.Top := 118;
    chkIgnoreWater.Width := 150;
    chkIgnoreWater.Caption := 'Keep underwater LOD';
    chkIgnoreWater.Hint := 'Do not remove LOD geometry under water.';
    chkIgnoreWater.ShowHint := True;

    cbLODLevel := TComboBox.Create(frm); cbLODLevel.Parent := gbOptions;
    cbLODLevel.Left := 440;
    cbLODLevel.Top := 18;
    cbLODLevel.Width := 40;
    cbLODLevel.Style := csDropDownList;
    cbLODLevel.Items.Text := ''#13'4'#13'8'#13'16';
    cbLODLevel.ItemIndex := 0;
    CreateLabel(gbOptions, cbLODLevel.Left - 160, cbLODLevel.Top + 4, 'Generate LOD level(s) only');

    cbLODX := TComboBox.Create(frm); cbLODX.Parent := gbOptions;
    cbLODX.Left := cbLODLevel.Left;
    cbLODX.Top := 42;
    cbLODX.Width := 40;
    cbLODX.Style := csDropDownList;
    cbLODX.DropDownCount := 20;
    cbLODX.Items.Text := ''#13'-4'#13'-3'#13'-2'#13'-1'#13'0'#13'1'#13'2'#13'3'#13'4';
    cbLODX.ItemIndex := 0;
    cbLODY := TComboBox.Create(frm); cbLODY.Parent := gbOptions;
    cbLODY.Left := cbLODX.Left + 46;
    cbLODY.Top := cbLODX.Top;
    cbLODY.Width := 40;
    cbLODY.Style := csDropDownList;
    cbLODY.DropDownCount := 20;
    cbLODY.Items.Assign(cbLODX.Items);
    cbLODY.ItemIndex := 0;
    CreateLabel(gbOptions, cbLODX.Left - 160, cbLODX.Top + 4, 'Generate for block(s) [x,y] only');

    edLODScale := TEdit.Create(frm); edLODScale.Parent := gbOptions;
    edLODScale.Left := cbLODLevel.Left;
    edLODScale.Top := 66;
    edLODScale.Width := 40;
    CreateLabel(gbOptions, edLODScale.Left - 160, edLODScale.Top + 4, 'Global LOD objects scale');

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
    
    edDataPath.Text := DataPath;
    PresetLoad(ScriptsPath + 'LODGen preset default.ini');
    if (edExport.Text = '') or (edDestination.Text = '') then
      cbWorldSelect(cbWorld);
    
    if frm.ShowModal <> mrOk then
      Exit;

    sExport := edExport.Text;
    sDestination := IncludeTrailingBackslash(edDestination.Text);
    sDataPath := IncludeTrailingBackslash(edDataPath.Text);
      
    PresetSave(ScriptsPath + 'LODGen preset default.ini');
    
    // lower case all rules since we are searching with Pos()
    for i := 0 to Pred(slLOD.Count) do
      slLOD[i] := LowerCase(slLOD[i]);

    LODGenWorld := ObjectToElement(cbWorld.Items.Objects[cbWorld.ItemIndex]);
    LODGenExport := edExport.Text;
    LODGenParams := Format(' "%s"', [LODGenExport]);
    if chkDontFixTangents.Checked then
      LODGenParams := LODGenParams + ' --dontFixTangents';
    if chkNoTangents.Checked then
      LODGenParams := LODGenParams + ' --dontGenerateTangents';
    if chkNoColors.Checked then
      LODGenParams := LODGenParams + ' --dontGenerateVertexColors';
    if chkNoMaterial.Checked then
      LODGenParams := LODGenParams + ' --ignoreMaterial';
    if chkRemoveUnseen.Checked then begin
      LODGenParams := LODGenParams + ' --removeUnseenFaces';
      if chkIgnoreWater.Checked then
        LODGenParams := LODGenParams + ' --ignoreWater';
    end;
    if cbLODLevel.Text <> '' then
      LODGenParams := LODGenParams + ' --lodLevel ' + cbLODLevel.Text;
    if cbLODX.Text <> '' then
      LODGenParams := LODGenParams + ' --x ' + cbLODX.Text;
    if cbLODY.Text <> '' then
      LODGenParams := LODGenParams + ' --y ' + cbLODY.Text;
    if Trim(edLODScale.Text) <> '' then
      LODGenParams := LODGenParams + ' --globalScale ' + Trim(edLODScale.Text);
    // change 'textures' to 'textures\tes4' if lod mesh is in Oblivion nif format
    LODGenParams := LODGenParams + ' --skyblivionTexPath';
  finally
    frm.Free;
  end;
end;

//============================================================================
// Execute LODGen app
function ExecuteLODGen: Boolean;
var
  lodgenexe: string;
begin
  lodgenexe := ScriptsPath + 'lodgen.exe';
  AddMessage('Executing LODGen...');
  AddMessage(lodgenexe + LODGenParams);
  if bExecuteLODGen then
    CreateProcessWait(lodgenexe, LODGenParams, SW_SHOW, 0);
end;

//============================================================================
procedure DoLODGen(wrld: IInterface);
var
  fExport: Boolean;
begin
  fExport := not FileExists(sExport);
  if not fExport then
    if MessageDlg('LOD export file already exists. Do you want to reexport LOD data (load order has changed)?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      fExport := True;

  // export LOD data
  if fExport then begin
    if not ExportWorldspace(wrld) then
      Exit;
  end;
  
  ExecuteLODGen;
end;

//============================================================================
function Initialize: integer;
begin
  Result := 1;

  if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then
    bFallout := True
  else
    bFallout := False;

  if not ((wbGameMode = gmTES5) or bFallout) then begin
    MessageDlg('LODGen supports Skyrim, Fallout 3 and Fallout New Vegas only.', mtInformation, [mbOk], 0);
    Exit;
  end;
  
  if bFallout then
    sLODBaseObjects := 'STAT SCOL'
  else
    sLODBaseObjects := 'STAT';
  
  sTitle := wbAppName + 'LODGen by Ehamloptiran, Sheson and Zilav';
  AddMessage('');
  AddMessage(sTitle + ', starting...');

  slLODTypes := TStringList.Create;
  slLODTypes.StrictDelimiter := True;
  slLODTypes.CommaText := sLODOptions;
  slLOD := TStringList.Create;
  slCache := TStringList.Create;
  slCacheHPLod := TStringList.Create;
  slExport := TStringList.Create;
  lstSkip := TList.Create;
  slLODMeshes := TwbFastStringList.Create;
  slLODMeshes.Sorted := True;
  slLODMeshes.Duplicates := dupIgnore;
  slLODTextures := TwbFastStringList.Create;
  slLODTextures.Sorted := True;
  slLODTextures.Duplicates := dupIgnore;

  OptionsForm;
  if Assigned(LODGenWorld) then
    DoLODGen(LODGenWorld);

  lstSkip.Free;
  slExport.Free;
  slCache.Free;
  slCacheHPLod.Free;
  slLOD.Free;
  slLODTypes.Free;
  slLODMeshes.Free;
  slLODTextures.Free;
end;

end.
