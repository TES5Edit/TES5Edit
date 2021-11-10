{
  Scale references of TREE records
}
unit ScaleTreeRefs;

const
  fScale = 0.6;

function Process(e: IInterface): integer;
begin
  if (Signature(e) <> 'REFR') or (Signature(BaseRecord(e)) <> 'TREE') then
    Exit;
  
  // search for 'tree' in model name to skip bushes and flowers
  if Pos('tree', LowerCase(GetElementEditValues(BaseRecord(e), 'Model\MODL'))) = 0 then
    Exit;
  
  if not ElementExists(e, 'XSCL') then begin
    Add(e, 'XSCL', True);
    SetElementNativeValues(e, 'XSCL', fScale);
  end else
    SetElementNativeValues(e, 'XSCL', GetElementNativeValues(e, 'XSCL') * fScale);
end;

end.