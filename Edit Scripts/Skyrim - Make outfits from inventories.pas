{
  Create outfits from ARMO records and LVLI lists (containing armors)
  in NPCs inventories.
}

unit UserScript;

var
  baserecord: IInterface;
  slOutfit: TStringList;
  
//============================================================================
function Initialize: integer;
begin
  // template record for new outfits
  // DefaultSleepOutfit [OTFT:0001697D]
  baserecord := RecordByFormID(FileByIndex(0), $0001697D, True);
  if not Assigned(baserecord) then begin
    AddMessage('Can not find base record');
    Result := 1;
    Exit;
  end;
  slOutfit := TStringList.Create;
end;

//============================================================================
function Process(e: IInterface): integer;
var
  items, item, rec, outfit: IInterface;
  i: integer;
  IsArmor: boolean;
  s: string;
begin
  // process only NPC_ records
  if Signature(e) <> 'NPC_' then
    Exit;

  // no inventory - nothing to do
  items := ElementByName(e, 'Items');
  if not Assigned(items) then
    Exit;
  
  // gather all armor items from inventory into a list and remove them from inventory
  for i := ElementCount(items) - 1 downto 0 do begin
    item := ElementByIndex(items, i);
    rec := LinksTo(ElementByPath(item, 'CNTO\Item'));
    IsArmor := False;
    // check if inventory item is ARMO or LVLI with armors (EditorID check)
    if Signature(rec) = 'ARMO' then IsArmor := True else
    if Signature(rec) = 'LVLI' then begin
      s := LowerCase(GetElementEditValues(rec, 'EDID'));
      if (Pos('armor', s) > 0) or (Pos('shield', s) > 0) or (Pos('amulet', s) > 0) or
         (Pos('ring', s) > 0) or (Pos('cloth', s) > 0) then
        IsArmor := True;
    end;
    // is armor - add to list and remove from inventory
    if IsArmor then begin
      slOutfit.Add(Name(rec));
      RemoveElement(items, i);
    end;
  end;

  // create outfit if list is not empty
  if slOutfit.Count > 0 then begin

    // first update COCT count of inventory items or remove if none left
    if ElementCount(items) > 0 then
      SetElementNativeValues(e, 'COCT', ElementCount(items))
    else begin
      RemoveElement(e, 'Items');
      RemoveElement(e, 'COCT');
    end;
  
    // grab existing outfit or make a new one using template
    outfit := LinksTo(ElementByPath(e, 'DOFT'));
    if not Assigned(outfit) then
      outfit := wbCopyElementToFile(baserecord, GetFile(e), True, True);
    if not Assigned(outfit) then begin
      AddMessage('Can''t copy base record as new');
      Result := 1;
      Exit;
    end;

    // set new EditorID
    SetElementEditValues(outfit, 'EDID', GetElementEditValues(e, 'EDID') + 'Outfit');
    // clear items from template
    items := ElementByPath(outfit, 'INAM');
    while ElementCount(items) > 0 do RemoveElement(items, 0);
    // assign new items from list
    for i := 0 to slOutfit.Count - 1 do begin
      item := ElementAssign(items, HighInteger, nil, False);
      SetEditValue(item, slOutfit[i]);
    end;
    // clear list
    slOutfit.Clear;
    // give NPC outfit
    SetElementNativeValues(e, 'DOFT', FormID(outfit));
  end;
end;

//============================================================================
function Finalize: integer;
begin
  slOutfit.Free;
end;

end.
