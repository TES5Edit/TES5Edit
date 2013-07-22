{
  Shows all references from cells which have provided location type LCTN
}
unit UserScript;

const
  LCTNRef = $00020006; // Dragon Bridge Farm 

function Process(e: IInterface): integer;
var
  s: string;
  cell: IInterface;
begin
  Result := 0;
  
  s := Signature(e);
  
  // skip records that are not references
  if (s <> 'ACHR') and (s <> 'REFR') then
    Exit;
  
  // go through plugin structure tree up to find group record (GRUP) of reference
  cell := GetContainer(e);
  while Assigned(cell) and (ElementType(cell) <> etGroupRecord) do
    cell := GetContainer(cell);
  
  if not Assigned(cell) then
    Exit;

  // get CELL record of GRUP record
  cell := ChildrenOf(cell);
  
  if not Assigned(cell) then
    Exit;
  
  // dump reference if matches location type
  if GetElementNativeValues(cell, 'XLCN') = LCTNRef then
    AddMessage(Name(e));
  
end;

end.
