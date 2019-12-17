{
  Create patch plugin with "No Respawn" flag on references of ore veins.
}
unit SkyrimOreVeinsDontRespawnPatch;

var
  plugin: IInterface;

function Process(e: IInterface): Integer;
var
  ore, r: IInterface;
begin
  // process only references
  if Signature(e) <> 'REFR' then
    Exit;
    
  // only master references
  if not IsMaster(e) then
    Exit;
  
  // but work with the current winning override
  e := WinningOverride(e);
  
  // getting base object of a reference (record linked in the 'NAME - Base Object' field)
  ore := BaseRecord(e);

  // references of activator only
  if Signature(ore) <> 'ACTI' then
    Exit;
  
  // detect if activator is an ore vein
  // check the presense of mining script
  if GetElementEditValues(ore, 'VMAD\Scripts\Script\scriptName') <> 'MineOreScript' then
    Exit;
  
  // create a new plugin if not created yet or use the last loaded
  if not Assigned(plugin) then begin
    if MessageDlg('Create a new plugin [YES] or append to the last loaded one [NO]?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      plugin := AddNewFile
    else
      plugin := FileByIndex(Pred(FileCount));
    if not Assigned(plugin) then begin
      Result := 1;
      Exit;
    end;
  end;

  // add masters before copying as override for parent CELL
  AddRequiredElementMasters(LinksTo(ElementByIndex(e, 0)), plugin, False);
  // and REFR itself
  AddRequiredElementMasters(e, plugin, False);

  try
    // copy reference as override
    r := wbCopyElementToFile(e, plugin, False, True);
    
    // set No Respawn flag (bit 30)
    SetElementNativeValues(r, 'Record Header\Record Flags', GetElementNativeValues(r, 'Record Header\Record Flags') or (1 shl 30));
  except
    on Ex: Exception do begin
      AddMessage('Failed to copy: ' + FullPath(e));
      AddMessage('    reason: ' + Ex.Message);
    end;
  end;
end;

function Finalize: integer;
begin
  if Assigned(plugin) then
    SortMasters(plugin);
end;

end.
