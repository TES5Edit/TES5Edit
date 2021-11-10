{
  Remove invalid entries from from the following list records:
    - forms list FLST
    - leveled lists LVLN, LVLI, LVSP, LVLC
    - region REGN (weathers and sounds)
    - outfit OTFT
    - non-player character NPC_ (inventory, factions, packages, head parts)
    - keywords in all records if supported
    - papyrus script properties if supported (Skyrim and later games)
  
  Supports all games starting from Oblivion
}
unit RemoveInvalidEntriesFromLists;

procedure SanitizeList(entries: IInterface; refpath: string);
var
  entry: IInterface;
  i: integer;
begin
  for i := Pred(ElementCount(entries)) downto 0 do begin
    entry := ElementByIndex(entries, i);
    if refpath <> '' then
      entry := ElementByPath(entry, refpath);
    // remove invalid (reported in Check for Errors) or NULL entries
    if (Check(entry) <> '') or not Assigned(LinksTo(entry)) then begin
      AddMessage('Removing ' + FullPath(entry));
      RemoveByIndex(entries, i, True);
    end;
  end;
end;

function Process(e: IInterface): integer;
var
  entries, entry: IInterface;
  i: integer;
begin
  if Signature(e) = 'FLST' then
    SanitizeList(ElementByName(e, 'FormIDs'), '')
  
  else if Pos(Signature(e), 'LVLI LVLN LVLC LVSP') > 0 then begin
    entries := ElementByName(e, 'Leveled List Entries');
    if wbGameMode <> gmTES4 then
      SanitizeList(entries, 'LVLO\Reference')
    else
      SanitizeList(entries, 'Reference');
  end
  
  else if Signature(e) = 'REGN' then begin
    entries := ElementByName(e, 'Region Data Entries');
    for i := 0 to Pred(ElementCount(entries)) do begin
      entry := ElementByIndex(entries, i);
      SanitizeList(ElementBySignature(entry, 'RDWT'), 'Weather');
      SanitizeList(ElementBySignature(entry, 'RDSA'), 'Sound');
    end;
  end
  
  else if Signature(e) = 'OTFT' then
    SanitizeList(ElementBySignature(e, 'INAM'), '')
  
  else if Signature(e) = 'NPC_' then begin
    SanitizeList(ElementByName(e, 'Items'), 'CNTO\Item');
    SanitizeList(ElementByName(e, 'Factions'), 'Faction');
    SanitizeList(ElementByName(e, 'Packages'), '');
    SanitizeList(ElementByName(e, 'Head Parts'), '');
  end;
  
  if ElementExists(e, 'KWDA') then
    SanitizeList(ElementBySignature(e, 'KWDA'), '');
  
  if ElementExists(e, 'VMAD') then begin
    entries := ElementByPath(e, 'VMAD\Scripts');
    for i := 0 to Pred(ElementCount(entries)) do begin
      entry := ElementByIndex(entries, i);
      SanitizeList(ElementByName(entry, 'Properties'), 'Value\Object Union\Object v2\FormID');
    end;
  end;
end;

end.