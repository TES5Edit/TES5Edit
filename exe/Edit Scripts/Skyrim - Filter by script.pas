{
  Filtering by papyrus script name.
}
unit ApplyFilterForPapyrusScript;

var
  sScriptName: string;
  bSkipSection: Boolean;

function HasScript(e: IInterface; aScript: string): Boolean;
var
  i: integer;
begin
  if Name(e) = 'ScriptName' then begin
    Result := SameText(GetEditValue(e), aScript);
    bSkipSection := True;
  end else
    for i := 0 to Pred(ElementCount(e)) do begin
      Result := HasScript(ElementByIndex(e, i), aScript);
      if bSkipSection then begin
        bSkipSection := False;
        Exit;
      end;
      if Result then Exit;
    end;
end;

function Filter(e: IInterface): Boolean;
begin
  if ElementExists(e, 'VMAD') then
    Result := HasScript(ElementBySignature(e, 'VMAD'), sScriptName);
end;

function Initialize: Integer;
begin
  Result := 1;

  if not wbGameMode = gmTES5 and not wbGameMode = gmSSE then begin
    AddMessage('Filtering by papyrus script works only for Skyrim.');
    Exit;
  end;

  if not InputQuery('Filter By', 'Papyrus script name (case insensitive)', sScriptName) then
    Exit;

  if sScriptName = '' then
    Exit;
  
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
  FilterBySignature := False;
  FilterSignatures := '';
  FilterByBaseSignature := False;
  FilterBaseSignatures := '';
  FlattenBlocks := False;
  FlattenCellChilds := False;
  AssignPersWrldChild := False;
  InheritConflictByParent := False;
  FilterScripted := True; // use custom Filter() function

  ApplyFilter;
end;

end.
