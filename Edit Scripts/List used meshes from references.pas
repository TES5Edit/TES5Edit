{
  Output meshes used in selected references, for example to build a list of meshes from a cell
}
unit UserScript;

const
  sRefSignatures = 'REFR,ACHR,PGRE,PMIS,PHZD,PARW,PBAR,PBEA,PCON,PFLA';

var
  slModels: TStringList;

function Initialize: integer;
begin
  // list of models, ignore duplicated ones
  slModels := TStringList.Create;
  slModels.Sorted := True;
  slModels.Duplicates := dupIgnore;
end;

function Process(e: IInterface): integer;
var
  s: string;
  r: IInterface;
begin
  if Pos(Signature(e), sRefSignatures) = 0 then
    Exit;
    
  r := BaseRecord(e);
  
  if not Assigned(r) then
    Exit;

  r := WinningOverride(r);

  if Signature(r) = 'ARMO' then
    s := GetElementEditValues(r, 'Male world model\MOD2')
  else
    s := GetElementEditValues(r, 'Model\MODL');
 
  if s <> '' then
    slModels.Add(LowerCase(s))
end;

function Finalize: integer;
begin
  AddMessage(slModels.Text);
  slModels.Free;
end;

end.
