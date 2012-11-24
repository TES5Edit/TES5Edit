{
  Remove invalid items/spells/npcs from containers and leveled lists
}
unit UserScript;

// rec - Record
// lstname - name of list
// refname - path to FormID reference relative to list's entry
// countname - counter subrecord to update
procedure RemoveInvalidEntries(rec: IInterface; lstname, refname, countname: string);
var
  i, num: integer;
  lst, ent: IInterface;
begin
  lst := ElementByName(rec, lstname);
  if not Assigned(lst) then
    Exit;

  num := ElementCount(lst);
  // check from the end since removing items will shift indexes
  for i := num - 1 downto 0 do begin
    // get individual entry element
    ent := ElementByIndex(lst, i);
    // Check() returns error string if any or empty string if no errors
    if Check(ElementByPath(ent, refname)) <> '' then
      Remove(ent);
  end;

  // update counter subrecord
  if num <> ElementCount(lst) then begin
    num := ElementCount(lst);
    // set new value or remove subrecord if list is empty (like CK does)
    if num > 0 then
      SetElementNativeValues(rec, countname, num)
    else
      RemoveElement(rec, countname);
  end;
end;

function Process(e: IInterface): integer;
var
  s: string;
begin
  Result := 0;
  
  s := Signature(e);
  
  // containers
  if s = 'CONT' then
    RemoveInvalidEntries(e, 'Items', 'CNTO\Item', 'COCT')
  else
  // leveled items, npcs and spells
  if (s = 'LVLI') or (s = 'LVLN') or (s = 'LVSP') then
    RemoveInvalidEntries(e, 'Leveled List Entries', 'LVLO\Reference', 'LLCT');

end;

end.
