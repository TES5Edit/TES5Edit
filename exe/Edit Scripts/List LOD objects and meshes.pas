{
  Exports the list of records with LOD data, LOD meshes and used textures
}

unit ListLOD;

var
  slLOD, slTex: TStringList;

procedure ParseLOD(rec, lod: IInterface);
var
  i, j: integer;
  ent: IInterface;
  mesh, s: string;
begin
  for i := 0 to 3 do begin
    ent := ElementByIndex(lod, i);
    mesh := GetElementEditValues(ent, 'Mesh');
    if mesh = '' then Continue;
    s := Format('%s;LOD %d;%s', [Name(rec), i, mesh]);
    NifTextureList(ResourceOpenData('', 'meshes\' + mesh), slTex);
    for j := 0 to Pred(slTex.Count) do
      s := s +  ';' + slTex[j];
    slLOD.Add(s);
  end;
end;

function Initialize: integer;
begin
  slLOD := TStringList.Create;
  slTex := TStringList.Create;
end;

function Process(e: IInterface): integer;
begin
  if Signature(e) = 'STAT' then begin
    e := WinningOverride(e);
    if ElementExists(e, 'MNAM') then begin
      ParseLOD(e, ElementBySignature(e, 'MNAM'));
      Exit;
    end;
  end;
end;

function Finalize: integer;
var
  dlgSave: TSaveDialog;
begin
  if slLOD.Count > 0 then begin
    dlgSave := TSaveDialog.Create(nil);
    dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
    dlgSave.Filter := 'CSV files (*.csv)|*.csv';
    dlgSave.InitialDir := DataPath;
    dlgSave.FileName := 'LOD Objects.csv';
    if dlgSave.Execute then begin
      AddMessage('Saving ' + dlgSave.FileName);
      slLOD.SaveToFile(dlgSave.FileName);
    end;
    dlgSave.Free;
  end;
  slLOD.Free;
  slTex.Free;
end;

end.
