{
  List old version plugins for Skyrim.
}
unit UserScript;

const
  CheckVersion = 1.7;

function Initialize: integer;
var
  i: integer;
  plugin, tes4: IInterface;
  s: string;
  v: single;
begin
  for i := 0 to FileCount - 1 do begin
    plugin := FileByIndex(i);
    s := GetFileName(plugin);

    // skip old official files
    if
      (GetLoadOrder(Plugin) = 0) or
      SameText(s, 'Skyrim.esm') or
      SameText(s, 'Dawnguard.esm')
    then
      Continue;
    
    tes4 := ElementByIndex(plugin, 0);
    if GetElementNativeValues(tes4, 'HEDR\Version') < CheckVersion then
      AddMessage(Format('Old version %s plugin %s', [GetElementEditValues(tes4, 'HEDR\Version'), s]));

  end;

  // nothing else to do, terminate
  Result := 1;
end;

end.