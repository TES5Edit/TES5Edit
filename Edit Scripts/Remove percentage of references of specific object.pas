{
  Remove a percentage amount (iRemovePercents) of references of specific object (sBaseObjectID)
}
unit RemovePercentageOfRefs;

const
  iRemovePercents = 30; // percents of references to remove
  sBaseObjectID = 'CaveGBoulderL02'; // editor id of object
  sRefSignatures = 'REFR,ACHR,PGRE,PMIS,PHZD,PARW,PBAR,PBEA,PCON,PFLA';

var
  lst: TList;

function Initialize: Integer;
begin
  lst := TList.Create;
end;

function Process(e: IInterface): Integer;
begin
  if Pos(Signature(e), sRefSignatures) > 0 then
    if SameText(EditorID(BaseRecord(e)), sBaseObjectID) then
      lst.Add(e);
end;

function Finalize: Integer;
var
  i, RefsToLeave: Integer;
begin
  RefsToLeave := lst.Count - Round(lst.Count * iRemovePercents / 100);
  Randomize;
  while lst.Count > RefsToLeave do begin
    i := Random(lst.Count);
    RemoveNode(ObjectToElement(lst[i]));
    lst.Delete(i);
  end;
  lst.Free;
end;

end.