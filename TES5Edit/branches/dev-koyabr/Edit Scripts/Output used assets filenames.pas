{
  Output meshes used in selected records
}
unit UserScript;

var
  sl: TStringList;

function Initialize: integer;
begin
  sl := TStringList.Create;
end;

function Process(e: IInterface): integer;
var
  sig, s, ext: string;
  i: integer;
begin
  sig := Signature(e);
  
  // those records don't use assets
  if ElementType(e) = etMainRecord then begin
    if (sig = 'CELL') or (sig = 'REFR') or (sig = 'ACHR') then
      Exit;
  end else
    sig := Signature(ContainingMainRecord(e));

  // only string fields can contain filenames
  i := DefType(e);
  if (i = dtString) or (i = dtLenString) then begin
    s := GetEditValue(e);
    ext := Copy(s, Length(s) - 3, 4);
    if SameText(ext, '.nif') or SameText(ext, '.dds') then
      sl.Add(IntToHex(GetLoadOrderFormID(ContainingMainRecord(e)), 8) + ';' + sig + ';' + Path(e) + ';' + s);
  end;
  
  // recursively process all child elements
  for i := 0 to ElementCount(e) - 1 do
    Process(ElementByIndex(e, i));
 
end;

function Finalize: integer;
begin
  AddMessage(sl.Text);
  sl.Free;
end;

end.
