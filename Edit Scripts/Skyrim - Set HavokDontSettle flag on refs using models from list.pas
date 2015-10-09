{
  Set HavokDontSettle flag on references of meshes from the list
}
unit UserScript;

var
  slModels: TStringList;

function Initialize: integer;
var
  i: integer;
begin
  slModels := TStringList.Create;
  slModels.LoadFromFile(ScriptsPath + 'Skyrim - Set HavokDontSettle models list.txt');
  slModels.Text := StringReplace(LowerCase(slModels.Text), '/', '\', [rfReplaceAll]);
  for i := 0 to Pred(slModels.Count) do
    if Copy(slModels[i], 1, 7) = 'meshes\' then
      slModels[i] := Copy(slModels[i], 8, Length(slModels[i]));
end;

function Process(e: IInterface): integer;
var
  s: string;
begin
  if Signature(e) <> 'REFR' then
    Exit;
  
  s := LowerCase(GetElementEditValues(BaseRecord(e), 'Model\MODL'));
  
  if s = '' then
    Exit;

  if Copy(s, 1, 7) = 'meshes\' then
    Delete(s, 1, 7);

  if slModels.IndexOf(s) <> -1 then  
    SetElementNativeValues(e, 'Record Header\Record Flags', GetElementNativeValues(e, 'Record Header\Record Flags') or $20000000);
end;

function Finalize: integer;
begin
  slModels.Free;
end;

end.
