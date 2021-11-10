{
  Converts selected ALCH records to SPEL records
}

unit FO4ConvertALCHtoSPEL;

const
  bReplace = 0; // set to 1 to replace the original ALCH record with a new SPEL one

var
  template: IInterface;
  
function Initialize: integer;
begin
  // AbRaceBloodbug [SPEL:0002866A]
  template := RecordByFormID(FileByIndex(0), $0002866A, True);
  if not Assigned(template) then begin
    AddMessage('Can not find template record');
    Result := 1;
    Exit;
  end;
end;

function Process(e: IInterface): integer;
var
  r: IInterface;
  fid: Cardinal;
begin
  if Signature(e) <> 'ALCH' then
    Exit;

  // copy template as a new record
  r := wbCopyElementToFile(template, GetFile(e), True, True);
  if not Assigned(r) then begin
    AddMessage('Can''t copy template as a new record');
    Result := 1;
    Exit;
  end;
  
  // copy compatible data
  ElementAssign(Add(r, 'EDID', True), LowInteger, ElementByPath(e, 'EDID'), False);
  ElementAssign(Add(r, 'FULL', True), LowInteger, ElementByPath(e, 'FULL'), False);
  ElementAssign(Add(r, 'DESC', True), LowInteger, ElementByPath(e, 'DESC'), False);
  ElementAssign(Add(r, 'OBND', True), LowInteger, ElementByPath(e, 'OBND'), False);
  ElementAssign(Add(r, 'KWDA', True), LowInteger, ElementByPath(e, 'KWDA'), False);
  ElementAssign(Add(r, 'Effects', True), LowInteger, ElementByPath(e, 'Effects'), False);
  
  if bReplace = 1 then begin
    // remember ALCH formid
    fid := GetLoadOrderFormID(e);
    // remove it
    RemoveNode(e);
    // change SPEL formid
    SetLoadOrderFormID(r, fid);
  end;
end;

end.
