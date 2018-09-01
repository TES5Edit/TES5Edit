{
  Find ESP plugins which can be converted to ESL
}
unit FindESPtoESL;

const
  iESLMaxRecords = $800; // max possible new records in ESL
  iESLMaxFormID = $3ff; // max allowed FormID number in ESL


procedure CheckForESL(f: IInterface);
var
  i: Integer;
  e: IInterface;
  RecCount, RecMaxFormID, fid: Cardinal;
begin
  // iterate over all records in plugin
  for i := 0 to Pred(RecordCount(f)) do begin
    e := RecordByIndex(f, i);
    
    // override doesn't affect ESL
    if not IsMaster(e) then
      Continue;
    
    // increase the number of new records found
    Inc(RecCount);
    
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
    AddMessage(#9'Can be turned into ESL by adding ESL flag in TES4 header and changing extension to *.ESL')
  else
    AddMessage(#9'Can be turned into ESL by using ESL conversion in Creation Kit (requires FormID renumbering)');
    
  // check if plugin has ESP masters
  for i := 0 to Pred(MasterCount(f)) do
    if not GetIsESM(MasterByIndex(f, i)) then begin
      AddMessage(#9'Plugin has ESP master(s), turning into ESL will shuffle load order and hence NOT recommended!');
      Break;
    end;
end;
  
function Initialize: integer;
var
  i: integer;
  f: IInterface;
begin
  // iterate over loaded plugins
  for i := 0 to Pred(FileCount) do begin
    f := FileByIndex(i);
    // check non-master plugins only
    if not GetIsESM(f) and SameText(ExtractFileExt(GetFileName(f)), '.esp') then
      CheckForESL(f);
  end;
end;


end.
