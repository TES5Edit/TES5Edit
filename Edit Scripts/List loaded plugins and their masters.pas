(*
  This script will prepend or append supplied value to the EditorID field
  of every selected record.
*)
unit UserScript;

var
  DoPrepend: boolean;
  s: string;
  
function Initialize: integer;
var
  i, j: integer;
  plugin, master: IInterface;
begin
  for i := 0 to FileCount - 1 do begin
    plugin := FileByIndex(i);
    AddMessage(GetName(plugin)); // or GetFileName
    for j := 0 to GetMasterCount(plugin) - 1 do begin
      master := GetMasterByIndex(plugin, j);
      AddMessage('      ' + GetName(master));
    end;
  end;

  // nothing else to do
  Result := 1;
end;

end.