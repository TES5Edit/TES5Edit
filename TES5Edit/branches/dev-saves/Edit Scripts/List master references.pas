{
  List forms with load order 00 from containers, leveled lists and references
  Used for Skywind project
}
unit UserScript;

var
  slList: TStringList;

function Initialize: integer;
begin
  // list, ignore duplicated ones
  slList := TStringList.Create;
  slList.Sorted := True;
  slList.Duplicates := dupIgnore;
end;

function IsMasterRef(FormID: Cardinal): boolean;
begin
  Result := (FormID shr 24) = 0;
end;

// rec - Record
// lstname - name of list
// refname - path to FormID reference relative to list's entry
procedure ListEntries(rec: IInterface; lstname, refname: string);
var
  i, num: integer;
  lst, ent: IInterface;
  formid: Cardinal;
begin
  lst := ElementByName(rec, lstname);
  if not Assigned(lst) then
    Exit;

  num := ElementCount(lst);
  for i := 0 to num - 1 do begin
    // get individual entry element
    ent := ElementByIndex(lst, i);
    formid := GetElementNativeValues(ent, refname);
    if formid = 0 then Continue;
    if IsMasterRef(formid) then
      slList.Add(IntToHex64(formid, 8) + ';' + GetElementEditValues(ent, refname));
  end;
end;

function Process(e: IInterface): integer;
var
  s: string;
  formid: Cardinal;
begin
  s := Signature(e);
  
  if wbGameMode = gmTES4 then begin
    // containers
    if s = 'CONT' then
      ListEntries(e, 'Items', 'Item')
    else
    // leveled items, npcs and spells
    if (s = 'LVLI') or (s = 'LVLN') then
      ListEntries(e, 'Leveled List Entries', 'Reference');
  end;
  
  if (s = 'REFR') or (s = 'ACHR') then begin
    formid := GetElementNativeValues(e, 'NAME');
    if (formid <> 0) and IsMasterRef(formid) then
      slList.Add(IntToHex64(formid, 8) + ';' + GetElementEditValues(e, 'NAME'));
  end;
 
end;

function Finalize: integer;
begin
  //AddMessage(slList.Text);
  slList.SaveToFile(ProgramPath + 'Edit Scripts\masterrecords.txt');
  slList.Free;
end;

end.
