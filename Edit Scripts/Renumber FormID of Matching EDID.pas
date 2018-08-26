{
  Script goes over new records in selection and tries to find
  a matching record by Editor ID in the master files.
  If found - turn record into an override.
}
unit ChangeFormIDbyMatchingEditorID;

const
  bCaseSensitive = False; // case sensitivity of Editor ID comparison

var
  slCache: TStringList;


function FindRecordByEditorID(f: IInterface; sig, edid: string): IInterface;
var
  token: string;
  i: Integer;
  g, e: IInterface;
  sl: TStringList;
begin
  if not Assigned(slCache) then
    slCache := TStringList.Create;
  
  token := GetFileName(f) + ' ' + sig;
  i := slCache.IndexOf(token);
  if i = -1 then begin
    sl := TStringList.Create;
    sl.CaseSensitive := bCaseSensitive;
    slCache.AddObject(token, sl);
    g := GroupBySignature(f, sig);
    for i := 0 to Pred(ElementCount(g)) do begin
      e := ElementByIndex(g, i);
      if not ElementExists(e, 'EDID') then
        Continue;
      sl.AddObject(EditorID(e), e);
    end;
    sl.Sorted := True;
    i := Pred(slCache.Count);
  end;
  
  sl := TStringList(slCache.Objects[i]);
  i := sl.IndexOf(edid);
  if i <> -1 then
    Result := ObjectToElement(sl.Objects[i]);
end;

function MasterRecordByEditorID(e: IInterace; edid: string): IInterface;
var
  i: Integer;
  f: IInterface;
begin
  f := GetFile(e);
  for i := Pred(MasterCount(f)) downto 0 do begin
    Result := FindRecordByEditorID( MasterByIndex(f, i), Signature(e), edid );
    if Assigned(Result) then
      Exit;
  end;
  Result := nil;
end;

function Process(e: IInterace): Integer;
var
  edid: string;
  r: IInterface;
  OldFormID, NewFormID, i: Cardinal;
  refs: TList;
begin
  if not IsMaster(e) then
    Exit;
    
  if not ElementExists(e, 'EDID') then
    Exit;
  
  edid := EditorID(e);
  
  r := MasterRecordByEditorID(e, edid);
  if not Assigned(r) then
    Exit;
  
  AddMessage('Found match for ' + Name(e) + ' -> ' + FullPath(r));
  
  OldFormID := GetLoadOrderFormID(e);
  NewFormID := GetLoadOrderFormID(r);
  
  refs := TList.Create;
  try
    // store references
    for i := 0 to Pred(ReferencedByCount(e)) do
      refs.Add(ReferencedByIndex(e, i));

    // change formid of record
    SetLoadOrderFormID(e, NewFormID);

    // update references
    for i := 0 to Pred(refs.Count) do
      CompareExchangeFormID(ObjectToElement(refs[i]), OldFormID, NewFormID);
  
  finally
    refs.Free;
  end;
end;

function Finalize: Integer;
var
  i: Integer;
begin
  if Assigned(slCache) then begin
    for i := 0 to Pred(slCache.Count) do
      TStringList(slCache.Objects[i]).Free;
    slCache.Free;
  end;
end;

end.
