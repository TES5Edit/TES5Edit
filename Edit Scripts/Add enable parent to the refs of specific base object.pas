{
  Add XESP (parent enable) element to the references of specific base object.
  Apply to references (or cell(s)/worldspace(s) they are in).
}
unit AddXESP;

const
  sBaseObject = 'CommonChair01FL "Chair" [FURN:0006E7A6]'; // base object for references to add parent
  sParent = '000E52E4'; // parent object
  sRefSignatures = 'REFR,ACHR,PGRE,PMIS,PHZD,PARW,PBAR,PBEA,PCON,PFLA';

function Process(e: IInterface): integer;
begin
  if Pos(Signature(e), sRefSignatures) = 0 then
    Exit;

  if GetIsDeleted(e) then
    Exit;
  
  if not SameText(GetElementEditValues(e, 'NAME'), sBaseObject) then
    Exit;

  if ElementExists(e, 'XESP') then
    AddMessage('Parent already exists on ' + Name(e))
  else begin
    Add(e, 'XESP', True);
    SetElementEditValues(e, 'XESP\Reference', sParent);
  end;
end;

end.