{
  Shows a list of FormIDs < 800h from selected references
}
unit userscript;

var
  sl: TStringList;

function Initialize: integer;
begin
  sl := TStringList.Create;
end;

function Process(e: IInterface): integer;
var
  s: string;
  formid: integer;
begin
  s := Signature(e);
  
  if (s <> 'REFR') and (s <> 'ACHR') and (s <> 'PHZD') and (s <> 'PGRD') then
    Exit;

  formid := GetElementNativeValues(e, 'NAME');
  
  if (formid = 0 ) or (formid > $800) then
    Exit;
  
  s := IntToHex(formid, 8) + ';' + GetElementEditValues(e, 'NAME');
  
  if sl.IndexOf(s) = -1 then
    sl.Add(s);
end;

function Finalize: integer;
begin
  sl.Sort;
  AddMessage(sl.Text);
  sl.Free;
end;

end.