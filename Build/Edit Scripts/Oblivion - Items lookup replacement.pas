{
  Replace NPC and container items according to replacements lookup file.
  Each line in lookup file defines item to replace, plugin for replacement item, replacement item (separated by comma).
  "Item to replace" will be replaced by several items if more than one line defines it.
}
unit UserScript;

const
  LookupFileName = 'Oblivion - Items lookup replacement.txt';

var
  sl, slLookup: TStringList;
  arRec: array [0..5000] of IInterface;
  PatchMode: integer;
  PatchFile: IInterface;

//========================================================================================
procedure LoadLookupFile(aFileName: string);
var
  slv: TStringList;
  lst: TList;
  i, j, formid, repcount: integer;
  s: string;
  plugin, r: IInterface;
begin
  repcount := 0;
  
  slv := TStringList.Create;
  slv.Delimiter := ',';
  slv.StrictDelimiter := True;
  sl.LoadFromFile(ProgramPath + 'Edit Scripts\' + aFileName);

  // parse lookup file
  for i := 0 to sl.Count - 1 do begin
    if sl[i] = '' then Continue;
    slv.DelimitedText := sl[i];

    // skip lines without two commas
    if slv.Count <> 3 then begin
      AddMessage(Format('Error parsing line %d in lookup file %s (must have 2 commas)', [i + 1, aFileName]));
      Continue;
    end;

    s := Trim(slv[1]); // plugin's file name
    // find plugin by name in load order if it differs from the previous one
    if (s <> '') and not SameText(s, GetFileName(plugin)) then
      for j := 0 to FileCount - 1 do
        if SameText(s, GetFileName(FileByIndex(j))) then begin
          plugin := FileByIndex(j);
          Break;
        end;
    if (s = '') or not Assigned(plugin) then begin
      AddMessage(Format('Plugin "%s" is not loaded (lookup file line %d)', [s, i + 1]));
      Continue;
    end;

    // get formid of replacement
    s := Trim(slv[2]);
    if Length(s) > 8 then
      s := Copy(s, Length(s) - 8, 8);
    formid := StrToIntDef('$' + s, 0);
    if formid = 0 then begin
      AddMessage(Format('Can not detect FormID number in "%s" (lookup file line %d)', [Trim(slv[2]), i + 1]));
      Continue;
    end;

    // get replacement record
    formid := FileFormIDtoLoadOrderFormID(plugin, formid);
    r := RecordByFormID(plugin, formid, True);
    if not Assigned(r) then begin
      AddMessage(Format('Unknown FormID %s in plugin %s (lookup file line %d)', [IntToHex(formid, 8), GetFileName(plugin), i + 1]));
      Continue;
    end;

    // all checks passed, add to replacements list
    s := Trim(slv[0]);
    j := slLookup.IndexOf(s);
    if j = -1 then begin
      lst := TList.Create;
      slLookup.AddObject(s, lst);
    end else begin
      lst := TList(slLookup.Objects[j]);
    end;
    arRec[repcount] := r;
    lst.Add(TObject(repcount));
    Inc(repcount);
  end;
  
  sl.Clear;
  slv.Free;
end;

//========================================================================================
function Initialize: integer;
begin
  sl := TStringList.Create;
  slLookup := TStringList.Create;

  LoadLookupFile(LookupFileName);
  if slLookup.Count = 0 then begin
    AddMessage('Lookup replacements list is empty, nothing to do.');
    Finalize;
    Result := 1;
    Exit;
  end;
  
  PatchMode := -1; // -1: ask later, 1: create overriding patch file, 0: modify original
  
  // will use it in Process() as a list of additional items that must be added to NPC, no duplicates
  sl.Duplicates := dupIgnore;
end;

//========================================================================================
function Process(e: IInterface): integer;
var
  i, j, idx, cnt: integer;
  item, items, r, patchrecord: IInterface;
  lst: TStringList;
  replaced: Boolean;
begin
  // replace in NPC inventories and containers
  if (Signature(e) <> 'NPC_') and (Signature(e) <> 'CONT') then
    Exit;

  sl.Clear;
  items := ElementByName(e, 'Items');

  // check every item in inventory
  for i := 0 to ElementCount(items) - 1 do begin
    item := ElementByIndex(items, i);
    cnt := GetElementNativeValues(item, 'Count');

    // can't add or replace items immediately because items are sorted by xEdit and changes will shuffle items
    // we don't want it now, so build a new inventory list instead
    // item is in lookup list to replace?
    idx := slLookup.IndexOf(GetElementEditValues(item, 'Item'));
    if idx <> -1 then begin
      lst := TList(slLookup.Objects[idx]);
      // replace it
      for j := 0 to lst.Count - 1 do begin
        // get replacement record for current item
        r := arRec[Integer(lst[j])];
        // add to replacements list
        sl.AddObject(Name(r), cnt);

        // need to add masters for replacement record
        // time to decide on patching mode
        if PatchMode = -1 then
          if MessageDlg('Create a new patch file [YES] or modify existing plugins [NO]?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            PatchMode := 1
          else
            PatchMode := 0;
          
        // creating patch file
        if PatchMode = 1 then begin
          if not Assigned(PatchFile) then
            PatchFile := AddNewFile;
          if not Assigned(PatchFile) then begin
            AddMessage('Patch file creation cancelled by user');
            Result := 1;
            Exit;
          end;
          // add current plugin as a master
          AddRequiredElementMasters(GetFile(e), PatchFile, False);
          // copy record to patch file as override
          patchrecord := wbCopyElementToFile(e, PatchFile, False, True);
          // add masters for replacement record to patch file
          AddRequiredElementMasters(r, PatchFile, False);
        end else
          // add masters for replacement record to the current file
          AddRequiredElementMasters(r, GetFile(e), False);
      end;
      // set flag that items were replaced
      replaced := True;
    end else
      // not in list, add without changes
      sl.AddObject(GetElementEditValues(item, 'Item'), cnt);
  end;
  
  // recreate items list if needed
  if replaced then begin
    if Assigned(patchrecord) then
      items := ElementByName(patchrecord, 'Items');
    // clear items
    while ElementCount(items) > 0 do RemoveElement(items, 0);
    // build new
    for i := 0 to sl.Count - 1 do begin
      item := ElementAssign(items, HighInteger, nil, False);
      SetElementEditValues(item, 'Item', sl[i]);
      SetElementEditValues(item, 'Count', Integer(sl.Objects[i]));
    end;
  end;
end;

//========================================================================================
function Finalize: integer;
var
  i: integer;
begin
  // sort master in patch file if created
  if Assigned(PatchFile) then
    SortMasters(PatchFile);
  // cleanup
  for i := 0 to slLookup.Count - 1 do
    TList(slLookup.Objects[i]).Free;
  slLookup.Free;
  sl.Free;
end;

end.
