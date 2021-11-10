{
  Copy VMAD subrecord (attached papyrus scripts data) to selected record(s)
  from provided source record.
}
unit UserScript;

var
  BaseRecord: IInterface;
  
function Initialize: integer;
var
  s: string;
  i: integer;
  plug: IInterface;
begin
  if not InputQuery('Record FormID', 'Copy VMAD from', s) then begin
    Result := 1;
    Exit;
  end;
  i := StrToIntDef('$' + s, 0);
  if i = 0 then begin
    AddMessage('Invalid input, enter hexadecimal FormID');
    Result := 1;
    Exit;
  end;
  plug := FileByLoadOrder(i shr 24);
  if not Assigned(plug) then begin
    AddMessage('Can''t locate source plugin with load order ' + IntToStr(FileByLoadOrder(i shr 24)));
    Result := 1;
    Exit;
  end;
  BaseRecord := WinningOverride(RecordByFormID(plug, LoadOrderFormIDToFileFormID(plug, i), False));
  if not Assigned(BaseRecord) then begin
    AddMessage('Can''t locate source record ' + s + ' in ' + GetFileName(plug));
    Result := 1;
    Exit;
  end;
end;

function Process(e: IInterface): integer;
begin
  Add(e, 'VMAD', True);
  if ElementExists(e, 'VMAD') then
    ElementAssign(ElementByPath(e, 'VMAD'), LowInteger, ElementByPath(BaseRecord, 'VMAD'), False);
end;

end.
