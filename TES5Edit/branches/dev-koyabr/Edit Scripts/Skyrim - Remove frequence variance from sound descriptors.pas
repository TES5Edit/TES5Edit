{
  Remove frequence variance from sound descriptors.
}
unit UserScript;

function Process(e: IInterface): integer;
begin
  SetElementEditValues(e, 'BNAM\% Frequency Variance', '0');
end;

end.
