{
  Set HavokDontSettle flag on references of BOOK records
}
unit UserScript;

function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'REFR' then
    Exit;
  
  if Signature(LinksTo(ElementBySignature(e, 'NAME'))) <> 'BOOK' then
    Exit;
  
  SetElementNativeValues(e, 'Record Header\Record Flags', GetElementNativeValues(e, 'Record Header\Record Flags') or $20000000);
end;

end.
