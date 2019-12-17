{
  This script checkes to see if an EDID is present in the selected record.  
  If not present it will add an EDID record.  
  Assign 'Position' to the first space found in NAME
  Assign the EDID value to be the Prefix, plus the NAME of the reference up to the first space, and a suffix.
}
unit AddPrefixPlusNameToEDID;

{
Change Prefix to the desired value for your plugin.
}
Const
  Prefix = 'Reserve';
  
Var
  Count: Integer;
  NavCount: Integer;
  Sig: string;

function Process(e: IInterface): integer;
var
  elEditorID: IInterface;
  s, s1: String;
  Position: Integer;
  ESPFlags, SkipIt, NavMesh: Boolean;
  ZPos: Integer;

begin
  Sig := Signature(e);
  Result := 0;
  s1:= '';

  // if (Sig = 'CELL') or (Sig = 'WRLD') then begin
    AddMessage('Processing: ' + Name(e));
    elEditorID := ElementByName(e, 'EDID - Editor ID');
    s := GetElementEditValues(e, 'NAME');
    Position:= pos(' ', s);
    ZPos:= GetElementNativeValues(e, 'DATA\Position\Z');
    ESPFlags:= GetIsInitiallyDisabled(e);
    SkipIt:= False;
    NavMesh:= False;

    if (ZPos = -30000) and ESPFlags then SkipIt:= True;
    if Position > 0 then s1 := Copy(s, 0, (Position - 1));
    if Sig = 'NAVM' then NavMesh:= True;

    if NavMesh then s1 := 'Navigation Mesh';
    if Assigned(elEditorID) then Begin
      if SkipIt then elEditorID := RemoveElement(e, 'EDID');
	  End;
    if Not Assigned(elEditorID) then Begin
      if not SkipIt then elEditorID := Add(e, 'EDID', True);
	  End;
    if (not SkipIt) and Assigned(elEditorID) then Begin
      if NavMesh then SetEditValue(elEditorID, s1 + '_' + IntToStr(NavCount));
      if Not NavMesh then SetEditValue(elEditorID, Prefix + s1 + '_' + IntToStr(Count));
      if NavMesh then Inc(NavCount);
      if Not NavMesh then Inc(Count)
    End;
  // End;
end;

end.
