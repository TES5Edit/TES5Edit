{
  Changes references of selected records to point to another provided FormID
}
unit UserScript;

var
  NewFormID: Cardinal;

function ReferencesReady: Boolean;
var
  i: integer;
  f: IInterface;
  s, t: string;
begin
  Result := True;
  if wbGameMode <> gmTES3 then
    Exit;
  for i := 0 to Pred(FileCount) do begin
    f := FileByIndex(i);
    if IsDeltaPatch(f) then
      Continue;
    if not NameReferencesJudged(f) then
      t := t + ' ' + GetFileName(f)
    else if HoldsCorruptKey(f) then
      s := s + ' ' + GetFileName(f) + ' (two or more records share a key)'
    else if not ReferencesComplete(f) then
      s := s + ' ' + GetFileName(f);
  end;
  if t <> '' then
    AddMessage('NAME references build no entries in:' + t);
  if s <> '' then begin
    AddMessage('Nothing changed. References are not complete and current in:' + s);
    Result := False;
  end;
end;

function Initialize: integer;
var
  s: string;
begin
  if not ReferencesReady then begin
    Result := 1;
    Exit;
  end;
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
