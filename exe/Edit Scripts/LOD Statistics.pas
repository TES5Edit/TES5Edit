{
  Gets LOD usage statistics for worldspace in tabulated spreadsheet text file (apply script to worldspace).
  Used to find out the LOD meshes with biggest impact for primary optimization targets.
  
  Fields:
  Record - base static record
  Uses - number of refs
  Total Tris - total number of triangles in LOD
  LOD0 Mesh - LOD Level 0 mesh name
  LOD0 Tris - number of triangles in mesh
  LOD0 Total Tris - total number of triangles in LOD Level 0
  ... repeats for other LOD Levels

  Supported games: Fallout 3, Fallout New Vegas, Skyrim, SSE, Fallout4 (partially, no SCOL info)
}

unit LODStatistics;

var
  slLOD: TStringList;


// getting _lod.nif file for a record
function FalloutLODMesh(rec: IInterface): string;
begin
  Result := GetElementEditValues(rec, 'Model\MODL');
  Result := Copy(Result, 1, Length(Result) - 4) + '_lod.nif';
  if Result <> '' then begin
    Result := wbNormalizeResourceName(Result, resMesh);
    if not ResourceExists(Result) then Result := '';
  end;
end;

// getting a total number of triangles in a nif mesh
function NifTrisCount(aMesh: string): Integer;
var
  nif: TwbNifFile;
  block: TwbNifBlock;
  i: Integer;
begin
  nif := TwbNifFile.Create;
  try
    try
      nif.LoadFromResource(aMesh);
      for i := 0 to Pred(nif.BlocksCount) do begin
        block := nif.Blocks[i];
        if block.IsNiObject('NiTriBasedGeomData', True) then
          Result := Result + block.NativeValues['Num Triangles']
        else if block.IsNiObject('BSTriShape', True) then
          Result := Result + block.NativeValues['Num Triangles'];
      end;
    except
      on E: Exception do
        AddMessage('Error reading "' + aMesh + '": ' + E.Message);
    end;
  finally
    nif.Free;
  end;
end;
  
function Initialize: integer;
begin
  if wbGameMode = gmTES4 then begin
    AddMessage('Oblivion is not supported.');
    Result := 1;
    Exit;
  end;
  slLOD := TStringList.Create;
end;

function Process(e: IInterface): integer;
var
  base: IInterface;
  idx: Integer;
begin
  if Signature(e) <> 'REFR' then
    Exit;

  //if not GetIsVisibleWhenDistant(e) then
  //  Exit;

  base := WinningOverride(BaseRecord(e));
  idx := slLOD.IndexOfObject(base);

  // check that the base record have LOD if not checked yet
  if idx = -1 then begin
    
    if wbGameMode >= gmTES5 then begin
      if Signature(base) <> 'STAT' then
        Exit;
      if not ElementExists(base, 'MNAM') then
        Exit;
    end
    else begin
      if Pos(Signature(base), 'STAT SCOL ACTI') = 0 then
        Exit;
      if FalloutLODMesh(base) = '' then
        Exit;
    end
    
    slLOD.AddObject('1', base);
  
  end else
    slLOD[idx] := Format('%.4d', [StrToInt(slLOD[idx]) + 1])
end;

function Finalize: integer;
var
  i, j, cnt, faces, totalfaces: Integer;
  stat: IInterface;
  mesh, s: string;
  dlgSave: TSaveDialog;
begin
  for i := 0 to Pred(slLOD.Count) do begin
    stat := ObjectToElement(slLOD.Objects[i]);
    cnt := StrToInt(slLOD[i]);
    totalfaces := 0;
    s := Name(stat) + #9 + IntToStr(cnt) + #9 + '{TOTALFACES}';
    for j := 0 to 3 do begin
      if wbGameMode >= gmTES5 then
        mesh := GetElementEditValues(stat, 'MNAM\[' + IntToStr(j) + ']\Mesh')
      else if j = 0 then
        mesh := FalloutLODMesh(stat)
      else
        mesh := '';
      
      if mesh = '' then begin
        s := s + #9#9#9;
        Continue;
      end;
      
      mesh := wbNormalizeResourceName(mesh, resMesh);
      faces := NifTrisCount(mesh);
      totalfaces := totalfaces + faces * cnt;
      s := s + #9 + mesh + #9 + IntToStr(faces) + #9 + IntToStr(faces * cnt);
    end;
    // prepend total faces count prefix for sorting (in reverse order)
    slLOD[i] := Format('%.8d', [99999999 - totalfaces]) + StringReplace(s, '{TOTALFACES}', IntToStr(totalfaces), [rfReplaceAll]);
  end;

  slLOD.Sort;
  
  // remove prefix
  for i := 0 to Pred(slLOD.Count) do
    slLOD[i] := Copy(slLOD[i], 9, Length(slLOD[i]));
  
  slLOD.Insert(0, 'Record'#9'Uses'#9'Total Tris'#9'LOD0 Mesh'#9'LOD0 Tris'#9'LOD0 Total Tris'#9'LOD1 Mesh'#9'LOD1 Tris'#9'LOD1 Total Tris'#9'LOD2 Mesh'#9'LOD2 Tris'#9'LOD2 Total Tris'#9'LOD3 Mesh'#9'LOD3 Tris'#9'LOD3 Total Tris');
  
  if slLOD.Count > 0 then begin
    dlgSave := TSaveDialog.Create(nil);
    dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
    dlgSave.Filter := 'Tabulated text (*.txt)|*.txt';
    dlgSave.InitialDir := wbScriptsPath;
    dlgSave.FileName := 'LOD Statistics.txt';
    if dlgSave.Execute then begin
      AddMessage('Saving ' + dlgSave.FileName);
      slLOD.SaveToFile(dlgSave.FileName);
    end;
    dlgSave.Free;
  end;
  
  slLOD.Free;
end;

end.
