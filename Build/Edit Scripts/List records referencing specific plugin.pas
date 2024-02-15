{
  Search for references in selected records and check their load order.
  
  When searching for ESL flagged file use 'FE nnn' with a space between FE and
  the file index nnn. If searching for a non ESL flagged file you must also
  include leading zeros.
  
  The game master would be '00', the next non ESL would be '01'. The first ESL
  flagged file would be 'FE 000'. Then 'FE 001' and so forth.
}
unit UserScript;

var
  ModLoadOrder: string;

function Initialize: integer;
var
  s: string;
begin
  if not InputQuery('Enter', 'Hexadecimal load order of references to search for', s) then 
    Exit;
  if s = '' then
    Exit;
  ModLoadOrder := UpperCase(s);
end;

function Process(e: IInterface): integer;
var
  ref: IInterface;
  i: integer;
begin
  Result := 0;

  if (ElementType(e) = etMainRecord) and (SameText(GetLoadOrderFileID(GetFile(MasterOrSelf(e))), ModLoadOrder)) then
    AddMessage(FullPath(e) + ' is override');
  
  ref := LinksTo(e);
  if Assigned(ref) then
    if SameText(GetLoadOrderFileID(GetFile(ref)), ModLoadOrder) then
      AddMessage(FullPath(e) + ' = ' + Name(ref));
  
  if CanContainFormIDs(e) then
    for i := 0 to ElementCount(e) - 1 do
      Process(ElementByIndex(e, i));
end;

end.
