unit WinningOverrideReferences;

function Process(e: IInterface): Integer;
var
  m, r: IInterface;
  i: Integer;
begin
  m := MasterOrSelf(e);
  for i := 0 to Pred(ReferencedByCount(m)) do begin
    r := ReferencedByIndex(m, i);
    if IsWinningOverride(r) then
      AddMessage(GetFileName(r) + #9 + Name(r));
  end;
    
end;

end.
