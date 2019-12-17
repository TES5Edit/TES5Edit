{
  Find plugins which can be converted to ESL
}
unit FindPotentialESL;

const
  iESLMaxRecords = $800; // max possible new records in ESL
  iESLMaxFormID = $fff; // max allowed FormID number in ESL


procedure CheckForESL(f: IInterface);
var
  i: Integer;
  e: IInterface;
  RecCount, RecMaxFormID, fid: Cardinal;
  HasCELL: Boolean;
begin
  // iterate over all records in plugin
  for i := 0 to Pred(RecordCount(f)) do begin
    e := RecordByIndex(f, i);
    
    // override doesn't affect ESL
    if not IsMaster(e) then
      Continue;
    
    if Signature(e) = 'CELL' then
      HasCell := True;
    
    // increase the number of new records found
    Inc(RecCount);
    
    // no need to check for more if we are already above the limit
    if RecCount > iESLMaxRecords then
      Break;
    
    // get raw FormID number
    fid := FormID(e) and $FFFFFF;
    
    // determine the max one
    if fid > RecMaxFormID then
      RecMaxFormID := fid;
  end;

  // too many new records, can't be ESL
  if RecCount > iESLMaxRecords then
    Exit;
  
  AddMessage(Name(f));
  
  if RecMaxFormID <= iESLMaxFormID then
    AddMessage(#9'Can be turned into ESL by adding ESL flag in TES4 header')
  else
    AddMessage(#9'Can be turned into ESL by compacting FormIDs first, then adding ESL flag in TES4 header');
    
  // check if plugin has new cell(s)
  if HasCELL then
    AddMessage(#9'Warning: Plugin has new CELL(s) which won''t work when turned into ESL and overridden by other mods due to the game bug');
end;
  
function Initialize: integer;
var
  i: integer;
  f: IInterface;
begin
  // iterate over loaded plugins
  for i := 0 to Pred(FileCount) do begin
    f := FileByIndex(i);
    // skip the game master
    if GetLoadOrder(f) = 0 then
      Continue;
    // check non-light plugins only
    if (GetElementNativeValues(ElementByIndex(f, 0), 'Record Header\Record Flags\ESL') = 0) and not SameText(ExtractFileExt(GetFileName(f)), '.esl') then
      CheckForESL(f);
  end;
end;


end.
