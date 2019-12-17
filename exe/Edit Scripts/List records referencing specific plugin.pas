{
  Search for references in selected records and check their load order.
}
unit UserScript;

var
  ModLoadOrder: integer;

function Initialize: integer;
var
  s: string;
begin
  if not InputQuery('Enter', 'Hexadecimal load order of references to search for', s) then 
    Exit;
  if s = '' then
    Exit;
  ModLoadOrder := StrToInt64('$' + s);
end;

function Process(e: IInterface): integer;
var
  ref: IInterface;
  i: integer;
begin
  Result := 0;

  if (ElementType(e) = etMainRecord) and (GetLoadOrder(GetFile(MasterOrSelf(e))) = ModLoadOrder) then
    AddMessage(FullPath(e) + ' is override');
  
  ref := LinksTo(e);
  if Assigned(ref) then
    if GetLoadOrder(GetFile(ref)) = ModLoadOrder then
      AddMessage(FullPath(e) + ' = ' + Name(ref));
  
  if CanContainFormIDs(e) then
    for i := 0 to ElementCount(e) - 1 do
      Process(ElementByIndex(e, i));
end;

end.
