{
  Counts how much baseforms are used in references
}
unit UserScript;

var
  slForms: TStringList;
  i: integer;

function Initialize: integer;
begin
  slForms := TStringList.Create;
end;

function Process(e: IInterface): integer;
var
  s: string;
begin
  Result := 0;
  
  s := Signature(e);
  
  if (s <> 'REFR') and (s <> 'ACHR') and (s <> 'PHZD') and (s <> 'PGRD') then
    Exit;

  s := GetElementEditValues(e, 'NAME');
  
  if s = '' then Exit;

  i := slForms.IndexOf(s);
  if i = -1 then
    slForms.AddObject(s, 1)
  else
    slForms.Objects[i] := Integer(slForms.Objects[i]) + 1;
 
end;

function Finalize: integer;
begin
  slForms.Sort;
  for i := 0 to slForms.Count - 1 do
    AddMessage(slForms[i] + ' ' + IntToStr(slForms.Objects[i]));
  slForms.Free;
end;

end.
