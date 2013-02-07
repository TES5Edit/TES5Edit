{
  Outputs records that have FORMID of 0.
  Can be used to search for corrupted plugins.
}
unit UserScript;

function Process(e: IInterface): integer;
begin
  
  // file header has formid of 0, skip it
  if Signature(e) = 'TES4' then
    Exit;
  
  if FormID(e) and $00FFFFFF = 0 then
    AddMessage(FullPath(e));
 
end;

end.
