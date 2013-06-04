{
  转换所选 BOOK 记录为 SCRL 记录。
  FormIDs 不发生变化。
}

unit UserScript;

var
  baserecord: IInterface;
  
//============================================================================
function Initialize: integer;
begin
  // RallyScroll "Scroll of Rally" [SCRL:000A44B5]
  baserecord := RecordByFormID(FileByIndex(0), $000A44B5, True);
  if not Assigned(baserecord) then begin
    AddMessage('Can not find base record');
    Result := 1;
    Exit;
  end;
end;

//============================================================================
function Process(e: IInterface): integer;
var
  r: IInterface;
  formid: Cardinal;
begin
  if Signature(e) <> 'BOOK' then
    Exit;

  r := wbCopyElementToFile(baserecord, GetFile(e), True, True);
  if not Assigned(r) then begin
    AddMessage('Can''t copy base record as new');
    Result := 1;
    Exit;
  end;
  SetElementEditValues(r, 'EDID', GetElementEditValues(e, 'EDID'));
  SetElementEditValues(r, 'FULL', GetElementEditValues(e, 'FULL'));
  SetElementEditValues(r, 'DESC', GetElementEditValues(e, 'DESC'));
  SetElementEditValues(r, '模型\MODL', GetElementEditValues(e, '模型\MODL'));
  SetElementEditValues(r, 'DATA\价值', GetElementEditValues(e, 'DATA\价值'));
  SetElementEditValues(r, 'DATA\重量', GetElementEditValues(e, 'DATA\重量'));
  
  formid := GetLoadOrderFormID(e);
  RemoveNode(e);
  SetLoadOrderFormID(r, formid);
end;

end.
