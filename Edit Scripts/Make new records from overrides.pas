{
  Convert overrides into new records, all references are updated with reindexed FormIDs
  too so they must already exist in a plugin.
  For example if you have an override of worldspace record [WRLD:00001234]
  which references water [WATR:00005678], after applying script it would become
  [WRLD:01001234] referencing [WATR:01005678] (assuming plugin is loaded at index 01).
}
unit OverridesToNewRecords;

procedure UpdateReferences(e: IInterface; ModLoadOrder: integer);
var
  ref: IInterface;
  i: integer;
begin
  ref := LinksTo(e);
  if Assigned(ref) then
    if GetLoadOrder(GetFile(ref)) <> ModLoadOrder then begin
      i := GetLoadOrderFormID(ref);
      i := (i and $FFFFFF) or (ModLoadOrder shl 24);
      AddMessage('Updating ref: ' + Path(e) + ' \ ' + GetEditValue(e));
      SetEditValue(e, IntToHex(i, 8));
    end;
  
  if CanContainFormIDs(e) then
    for i := 0 to ElementCount(e) - 1 do
      UpdateReferences(ElementByIndex(e, i), ModLoadOrder);
end;

function Process(e: IInterface): integer;
var
  i, fid: integer;
begin
  // not an override
  if IsMaster(e) then
    Exit;
    
  AddMessage('Override to new record: ' + Name(e));
  i := GetLoadOrder(GetFile(e));
  UpdateReferences(e, i);
  fid := GetLoadOrderFormID(e);
  fid := (fid and $FFFFFF) or (i shl 24);
  SetLoadOrderFormID(e, fid);
end;

end.
