{
  List NPCs that belong to more than one faction flagged as "Vendor"
}
unit ActorsWithManyVendorFactions;

var
  sl: TStringList;

function Initialize: integer;
begin
  sl := TStringList.Create;
end;

function Process(e: IInterface): integer;
var
  ents, ent, faction: IInterface;
  i: integer;
begin
  if Signature(e) <> 'NPC_' then
    Exit;
  
  sl.Clear;
  ents := ElementByName(e, 'Factions');
  for i := 0 to Pred(ElementCount(ents)) do begin
    ent := ElementByIndex(ents, i);
    faction := LinksTo(ElementByName(ent, 'Faction'));
    if GetElementNativeValues(faction, 'DATA\Flags') and $4000 > 0 then
      sl.Add(Name(faction));
  end;

  if sl.Count > 1 then
    AddMessage(Name(e) + #13#10'Vendor Factions:'#13#10 + sl.Text);
end;

function Finalize: integer;
begin
  sl.Free;
end;

end.
