{
  Renumber FormIDs of selected records starting from provided value
}
unit UserScript;

var
  NewFormID: Cardinal;

function Initialize: integer;
begin
  NewFormID := 0;
end;
  
function Process(e: IInterface): integer;
var
  OldFormID: Cardinal;
  m: IInterface;
  s: string;
begin
  // file header doesn't have formid
  if Signature(e) = 'TES4' then
    Exit;

  OldFormID := GetLoadOrderFormID(e);

  if NewFormID = 0 then begin
    Result := 1;
    s := InputBox('Enter', 'New starting FormID', IntToHex64(OldFormID, 8));
    if s = '' then
      Exit;
    NewFormID := StrToInt64('$' + s);
  end;

  Result := 0;
 
  if NewFormID = OldFormID then
    Exit;
  
  // here we shoud check for availability of NewFormID, but it will generate error and abort anyway if that happens
  // ...

  // the record in question might originate from master file
  m := MasterOrSelf(e);
  
  // skip overridden records
  if not Equals(m, e) then
    Exit;
  
  AddMessage(Format('Changing FormID from [%s] to [%s] on %s', [IntToHex64(OldFormID, 8), IntToHex64(NewFormID, 8), Name(e)]));

  // first change formid of references
  while ReferencedByCount(m) > 0 do
    CompareExchangeFormID(ReferencedByIndex(m, 0), OldFormID, NewFormID);

  // change formid of record
  SetLoadOrderFormID(e, NewFormID);
  
  // increment formid
  Inc(NewFormID);

end;

end.
