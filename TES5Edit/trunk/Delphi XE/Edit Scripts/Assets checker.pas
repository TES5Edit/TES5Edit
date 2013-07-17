unit userscript;

const
  atMesh = 1;
  atTexture = 2;
  atSound = 3;
  atMusic = 4;
  atScript = 5;

var
  slAssetsExt, sl: TStringList;
  slTextures: TwbFastStringList;
  CurrentRecord: IInterface;

  
//==========================================================================
function NormalizePath(value: string; atype: integer): string;
begin
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
procedure CheckAsset(el: IInterface);
var
  value, ext, s: string;
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
  end else begin
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
  
  //AddMessage(Name(CurrentRecord) + ' \ ' + Path(el) + ': ' + value);
  if not ResourceExists(value) then
    AddMessage(value + '   <-- ' + Name(CurrentRecord) +  ' \ ' + Path(el))

  // mesh exists, check textures in mesh
  else if atype = atMesh then begin
    NifTextureList(ResourceOpenData(value, -1), sl);
    slTextures.AddStrings(sl); // remove duplicates
    for i := 0 to Pred(sl.Count) do begin
      s := NormalizePath(LowerCase(sl[i]), atTexture);
      if not ResourceExists(s) then
        AddMessage(s + '   <-- ' + Name(CurrentRecord) +  ' \ ' + Path(el) + ': ' + value);
    end;
    slTextures.Clear;
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
      CheckAsset(e);
  end;
  
  if Name(e) <> 'Properties' then  // skip VMAD properties section
  for i := 0 to ElementCount(e) - 1 do
    ScanForAssets(ElementByIndex(e, i));
end;

//==========================================================================
function Initialize: integer;
begin
  if wbGameMode <> gmTES5 then begin
    AddMessage('Sorry, script works for Skyrin only for now.');
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

  slTextures := TwbFastStringList.Create;
  slTextures.Sorted := True;
  slTextures.Duplicates := dupIgnore;

  sl := TStringList.Create;
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
    CheckAsset(ElementByPath(e, 'XNAM'));

  // skip records without assets
  if (sig = 'REFR') or (sig = 'ACHR') or (sig = 'ACRE') or (sig = 'CELL') or
     (sig = 'NAVM') or (sig = 'PGRD') or (sig = 'LAND') or (sig = 'PACK')
  then
    Exit;
  
  // generic model common for all records
  CheckAsset(ElementByPath(e, 'Model\MODL'));

  // generic icon common for all records
  CheckAsset(ElementByPath(e, 'ICON'));

  // generic destruction models common for all records
  ScanForAssets(ElementByPath(e, 'Destructable'));
  
  // papyrus scripts
  ScanForAssets(ElementByPath(e, 'VMAD'));
  
  if (sig = 'ARMA') or (sig = 'ARMO') then begin
    CheckAsset(ElementByPath(e, 'Male world model\MOD2'));
    CheckAsset(ElementByPath(e, 'Female world model\MOD2'));
    CheckAsset(ElementByPath(e, 'Male 1st Person\MOD4'));
    CheckAsset(ElementByPath(e, 'Female 1st Person\MOD5'));
  end
  
  else if (sig = 'BPTD') then
    ScanForAssets(ElementByPath(e, 'Body Parts'))

  else if (sig = 'CLMT') then begin
    CheckAsset(ElementByPath(e, 'FNAM'));
    CheckAsset(ElementByPath(e, 'GNAM'));
  end
  
  else if (sig = 'MUST') then begin
    CheckAsset(ElementByPath(e, 'ANAM'));
    CheckAsset(ElementByPath(e, 'BNAM'));
  end

  else if (sig = 'PROJ') then
    CheckAsset(ElementByPath(e, 'Muzzle Flash Model\NAM1'))

  else if (sig = 'RACE') then begin
    CheckAsset(ElementByPath(e, 'ANAM - Male Skeletal Model'));
    CheckAsset(ElementByPath(e, 'ANAM - Female Skeletal Model'));
    ScanForAssets(ElementByPath(e, 'Body Data'));
    CheckAsset(ElementByPath(e, 'Male Behavior Graph\Model\MODL'));
    CheckAsset(ElementByPath(e, 'Female Behavior Graph\Model\MODL'));
    CheckAsset(ElementByPath(e, 'Head Data\Male Head Data\Model'));
    CheckAsset(ElementByPath(e, 'Head Data\Female Head Data\Model'));
  end

  else if (sig = 'SNDR') then
    ScanForAssets(ElementByPath(e, 'Sounds'))

  else if (sig = 'TXST') then
    ScanForAssets(ElementByPath(e, 'Textures (RGB/A)'))

  else if (sig = 'WATR') then
    CheckAsset(ElementByPath(e, 'NAM2'))

  else if (sig = 'WRLD') then begin
    CheckAsset(ElementByPath(e, 'Cloud Model\Model\MODL'));
    CheckAsset(ElementByPath(e, 'XNAM'));
    CheckAsset(ElementByPath(e, 'TNAM'));
    CheckAsset(ElementByPath(e, 'UNAM'));
  end

  else if (sig = 'WTHR') then
    ScanForAssets(e);

end;

//==========================================================================
function Finalize: integer;
begin
  slAssetsExt.Free;
  slTextures.Free;
  sl.Free;
end;

end.