{
  Change persistent flag on selected references.
  Collapse and expand cell group to see changes.
}
unit UserScript;

var
  bPersistent: boolean;

function Initialize: integer;
var
  i: integer;
begin
  i := MessageDlg('Set [YES] or clear [NO] Persistent flag?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if i = mrYes then bPersistent := true else
    if i = mrNo then bPersistent := false else begin
      Result := 1;
      Exit;
    end;
end;

function Process(e: IInterface): integer;
var
  s: string;
begin
  s := Signature(e);
  
  if (s <> 'REFR') and (s <> 'ACHR') and (s <> 'ACRE') and (s <> 'PGRE') and (s <> 'PMIS') and (s <> 'PHZD') then
    Exit;
  
  SetIsPersistent(e, bPersistent);
end;

end.
