{
  Output meshes used in selected records
}
unit UserScript;

var
  slModels: TStringList;

function Initialize: integer;
begin
  // list of models, ignore duplicated ones
  slModels := TStringList.Create;
  slModels.Sorted := True;
  slModels.Duplicates := dupIgnore;
end;

function Process(e: IInterface): integer;
var
  s: string;
  i: integer;
begin
  Result := 0;

  // only string fields can contain filenames
  i := DefType(e);
  if (i = dtString) or (i = dtLenString) then begin
    s := GetEditValue(e);
    if SameText(Copy(s, Length(s) - 3, 4), '.nif') then
      slModels.Add(s);
  end;
  
  // recursively process all child elements
  for i := 0 to ElementCount(e) - 1 do
    Process(ElementByIndex(e, i));
 
end;

function Finalize: integer;
begin
  AddMessage(slModels.Text);
  slModels.Free;
end;

end.
