{
  修改所选衍生的固定标志。
  折叠与展开以显示修改。
}
unit UserScript;

var
  bPersistent: boolean;

function Initialize: integer;
var
  i: integer;
begin
  i := MessageDlg('设置 [YES] 或者清除 [NO] 固定标志？', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
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
