{
  Applies filter to show only STAT and SCOL records which are a part of precombined meshes
  of cells in any of loaded plugins (Fallout 4 only).
  Can take some time, so please wait.
}
unit FO4PrecombinedStaticsFilter;

var
  slStatics: TList;

function Filter(e: IInterface): Boolean;
begin
  Result := slStatics.IndexOf(GetLoadOrderFormID(e)) <> -1;
end;

function Initialize: Integer;
var
  i, j, s, k: integer;
  f, g, e: IInterface;
begin
  // first build the list of STAT and SCOL records which are precombined in loaded mods
  slStatics := TList.Create;
  AddMessage('Collecting information on precombined statics, please wait...');

  // iterate over loaded plugins
  for i := 0 to Pred(FileCount) do begin
    f := FileByIndex(i);

    // skip hardcoded forms file
    if Pos('.Hardcoded.', GetFileName(f)) <> 0 then Continue;
    
    // references information must be built for all plugin
    if ContainerStates(f) and (1 shl csRefsBuild) = 0 then begin
      MessageDlg(Format('References are not built for "%s". Please use right click "Other\Build Reference Info" menu of %sEdit', [
        GetFileName(f),
        wbAppName
      ]), mtInformation, [mbOk], 0);
      slStatics.Free;
      Result := 1;
      Exit;
    end;

    for s := 1 to 2 do begin
      // check references of STAT and SCOL, only they can be precombined
      if s = 1 then
        g := GroupBySignature(f, 'STAT')
      else
        g := GroupBySignature(f, 'SCOL');

      // iterate over records in a plugin
      for j := 0 to Pred(ElementCount(g)) do begin
        e := ElementByIndex(g, j);

        // referenced by information is available for master records only
        if not IsMaster(e) then Continue;

        // check if any reference is precombined and add to the list if so
        for k := 0 to Pred(ReferencedByCount(e)) do
          if HasPrecombinedMesh(ReferencedByIndex(e, k)) then begin
            if slStatics.IndexOf(GetLoadOrderFormID(e)) = -1 then
              slStatics.Add(GetLoadOrderFormID(e));
            Break;
          end;
      end;
    end;
    
  end;

  AddMessage(Format('%d STAT and SCOL records are precombined in total', [slStatics.Count]));
  AddMessage('Filtering...');

  FilterConflictAll := False;
  FilterConflictThis := False;
  FilterByInjectStatus := False;
  FilterInjectStatus := False;
  FilterByNotReachableStatus := False;
  FilterNotReachableStatus := False;
  FilterByReferencesInjectedStatus := False;
  FilterReferencesInjectedStatus := False;
  FilterByEditorID := False;
  FilterEditorID := '';
  FilterByName := False;
  FilterName := '';
  FilterByBaseEditorID := False;
  FilterBaseEditorID := '';
  FilterByBaseName := False;
  FilterBaseName := '';
  FilterScaledActors := False;
  FilterByPersistent := False;
  FilterPersistent := False;
  FilterUnnecessaryPersistent := False;
  FilterMasterIsTemporary := False;
  FilterIsMaster := False;
  FilterPersistentPosChanged := False;
  FilterDeleted := False;
  FilterByVWD := False;
  FilterVWD := False;
  FilterByHasVWDMesh := False;
  FilterHasVWDMesh := False;
  FilterBySignature := True; // filter by signature
  FilterSignatures := 'STAT,SCOL'; // statics and static collections only
  FilterByBaseSignature := False;
  FilterBaseSignatures := '';
  FlattenBlocks := False;
  FlattenCellChilds := False;
  AssignPersWrldChild := False;
  InheritConflictByParent := True; // color conflicts
  FilterScripted := True; // use custom Filter() function

  ApplyFilter;

  slStatics.Free;
  
  Result := 1;
end;

end.