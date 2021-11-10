{
  List blocks and their references in a NIF mesh.
  Unreferenced blocks are not shown.
}
unit NifListBlockRefs;

procedure ListRefs(aNifFileName: string);
var
  nif: TwbNifFile;
  block, b: TwbNifBlock;
  ref: TdfElement;
  sl: TStringList;
  lst: TList;
  i, j: integer;
begin
  nif := TwbNifFile.Create;
  sl := TStringList.Create;
  try
    nif.LoadFromFile(aNifFileName);
    
    // fill with all block names and TList objects to hold referencing elements
    for i := 0 to Pred(nif.BlocksCount) do
      sl.AddObject(nif.Blocks[i].Name, TList.Create);
    
    // iterate over all nif blocks
    for i := 0 to Pred(nif.BlocksCount) do begin
      block := nif.Blocks[i];
      // iterate over references contained in each block
      for j := 0 to Pred(block.RefsCount) do begin
        ref := block.Refs[j];
        // find the block a ref is pointing to
        b := TwbNifBlock(ref.LinksTo);
        // add ref to the list of that block
        if Assigned(b) then
          TList(sl.Objects[b.Index]).Add(ref);
      end;
    end;
  
    // show blocks and refs
    AddMessage(#13'List of blocks and their references in ' + aNifFileName);
    for i := 0 to Pred(sl.Count) do begin
      lst := TList(sl.Objects[i]);
      // skip unreferenced blocks
      if lst.Count = 0 then Continue;
      AddMessage(sl[i]);
      for j := 0 to Pred(lst.Count) do
        AddMessage(#9 + TdfElement(lst[j]).Path);
    end;
    
  finally
    nif.Free;
    for i := 0 to Pred(sl.Count) do
      TList(sl.Objects[i]).Free;
    sl.Free;
  end;
end;

function Initialize: Integer;
var
  dlg: TOpenDialog;
begin
  Result := 1;
  dlg := TOpenDialog.Create(nil);
  try
    dlg.Filter := 'NIF files (*.nif)|*.nif';
    dlg.InitialDir := wbDataPath;
    if dlg.Execute then
      ListRefs(dlg.FileName);
  finally
    dlg.Free;
  end;
end;

end.
