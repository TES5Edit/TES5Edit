{
  Apply filter for cleaning implemented via script.

  Hotkey: Ctrl+Shift+C
}
unit userscript;

function Initialize: Integer;
begin
  FilterConflictAll := False;
  //FilterConflictAllSet := [caUnknown, caOnlyOne, caNoConflict, caConflictBenign, caOverride, caConflict, caConflictCritical];
  FilterConflictThis := False;
  //FilterConflictThisSet := [ctUnknown, ctIgnored, ctNotDefined, ctIdenticalToMaster, ctOnlyOne, ctHiddenByModGroup, ctMaster, ctConflictBenign, ctOverride, ctIdenticalToMasterWinsConflict, ctConflictWins, ctConflictLoses];
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
  //FilterSignatures := 'ARMO,AMMO,WEAP';
  FilterByBaseSignature := False;
  FilterBaseSignatures := '';
  FlattenBlocks := False;
  FlattenCellChilds := False;
  AssignPersWrldChild := False;
  InheritConflictByParent := True; // *********************

  ApplyFilter;

  Result := 1;
end;

end.