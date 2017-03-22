{
  Disable PreVis in selected exterior worldspaces/cells.
  Supports Fallout 4 only.
}
unit FO4DisableExteriorPreVis;

var
  plugin: IInterface;

function Process(e: IInterface): Integer;
var
  r: IInterface;
begin
  if Signature(e) <> 'CELL' then
    Exit;
    
  // exterior cells only (comment out to work on interiors too)
  if GetElementEditValues(e, 'DATA\Is Interior Cell') = '1' then
    Exit;

  // operate on the last override
  e := WinningOverride(e);

  // skip cells without precombination
  if not ElementExists(e, 'PCMB') then
    Exit;
  
  // create new plugin
  if not Assigned(plugin) then begin
    if MessageDlg('Create new plugin [YES] or use the last one [NO]?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      plugin := AddNewFile
    else
      plugin := FileByIndex(Pred(FileCount));
    if not Assigned(plugin) then begin
      Result := 1;
      Exit;
    end;
  end;

  // skip already copied
  if GetFileName(e) = GetFileName(plugin) then
    Exit;
    
  // add masters
  AddRequiredElementMasters(e, plugin, False);
    
  try
    // copy cell as override
    r := wbCopyElementToFile(e, plugin, False, True);
    
    // setting No PreVis flag and removing PreVis data
    SetElementNativeValues(r, 'Record Header\Record Flags', GetElementNativeValues(r, 'Record Header\Record Flags') or $80);
    RemoveElement(r, 'VISI');
    RemoveElement(r, 'RVIS');
    RemoveElement(r, 'PCMB');
    RemoveElement(r, 'XCRI');
    
  except
    on Ex: Exception do begin
      AddMessage('Failed to copy: ' + FullPath(e));
      AddMessage('    reason: ' + Ex.Message);
    end
  end;

end;

function Finalize: integer;
begin
  if Assigned(plugin) then
    SortMasters(plugin);
end;

end.
