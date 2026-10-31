{
  Set HavokDontSettle flag on references of BOOK records
}
unit UserScript;

function RefusedForMorrowind: Boolean;
begin
  Result := wbGameMode = gmTES3;
  if Result then
    AddMessage('This script does not work for Morrowind: its references have no such record flag');
end;

function Initialize: integer;
begin
  if RefusedForMorrowind then begin
    Result := 1;
    Exit;
  end;
  Result := 0;
end;

function Process(e: IInterface): integer;
begin
  if RefusedForMorrowind then begin
    Result := 1;
    Exit;
  end;

  if Signature(e) <> 'REFR' then
    Exit;
  
  if Signature(LinksTo(ElementBySignature(e, 'NAME'))) <> 'BOOK' then
    Exit;
  
  SetElementNativeValues(e, 'Record Header\Record Flags', GetElementNativeValues(e, 'Record Header\Record Flags') or $20000000);
end;

end.
