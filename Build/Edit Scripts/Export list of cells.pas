{
  Export list of CELLs
}
unit UserScript;

var
  sl: TStringList;

function Initialize: integer;
begin
  sl := TStringList.Create;
end;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'CELL' then
    Exit;
  sl.Add(IntToHex(FixedFormID(e), 8) + ';' + GetElementEditValues(e, 'EDID'));
end;

function Finalize: integer;
var
  fname: string;
begin
  fname := ProgramPath + 'Edit Scripts\cells.txt';
  AddMessage('Saving list to ' + fname);
  sl.SaveToFile(fname);
  sl.Free;
end;

end.
