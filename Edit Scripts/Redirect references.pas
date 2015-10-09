{
  Changes references of selected records to point to another provided FormID
}
unit UserScript;

var
  NewFormID: Cardinal;

function Initialize: integer;
var
  s: string;
begin
  s := InputBox('Enter', 'New FormID for references', '');
  if s = '' then begin
    Result := 1;
    Exit;
  end;

  NewFormID := StrToIntDef('$' + s, 0);

  if NewFormID = 0 then begin
    Result := 1;
    Exit;
  end;
end;
  
function Process(e: IInterface): integer;
var
  OldFormID: Cardinal;
  i: integer;
begin
  OldFormID := GetLoadOrderFormID(e);

  // change formid of references
  for i := Pred(ReferencedByCount(e)) downto 0 do
    CompareExchangeFormID(ReferencedByIndex(e, i), OldFormID, NewFormID);
end;

end.
