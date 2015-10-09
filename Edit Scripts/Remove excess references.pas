{
  Remove random temporary references from cells if there are more than iMinRefs of them
  in a cell.
  Uncomment NAME check to process only references of specific base object.
}
unit RemoveExcessRefs;

const
  iMinRefs = 3;
  sRefSignatures = 'REFR,ACHR,PGRE,PMIS,PHZD,PARW,PBAR,PBEA,PCON,PFLA';

var
  lst: TList;

function Initialize: Integer;
begin
  lst := TList.Create;
  Randomize;
end;

function Process(e: IInterface): Integer;
var
  i: Integer;
begin
  if Pos(Signature(e), sRefSignatures) > 0 then begin
    //if GetElementEditValues(e, 'NAME') = 'IronArrow "Iron Arrow" [AMMO:0001397D]' then
      lst.Add(e);
  end 
  else if Signature(e) = 'CELL' then begin
    if not GetIsPersistent(e) and (lst.Count > iMinRefs) then
      while lst.Count > iMinRefs do begin
        i := Random(lst.Count);
        RemoveNode(ObjectToElement(lst[i]));
        lst.Delete(i);
      end;
    lst.Clear;
  end;
end;

function Finalize: Integer;
begin
  lst.Free;
end;

end.