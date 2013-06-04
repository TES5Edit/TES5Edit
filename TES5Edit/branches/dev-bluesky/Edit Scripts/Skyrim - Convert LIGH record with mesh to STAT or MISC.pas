{
  转换含模型的 LIGH 记录为
  1) STAT: 重复的模型为 STAT 记录，并复制所有衍生然后指定他们到该 STAT
  2) MISC: 转换 LIGH 记录为 MISC (LIGH 会被移除，衍生重定向到新建的 MISC)
}

unit UserScript;

var
  baserecord: IInterface;
 
  
//============================================================================
function Initialize: integer;
var
  i: integer;
begin
  i := MessageDlg('Copy light records to STAT [YES] or MISC [NO]?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if i = mrYes then begin
    // LoadScreenHelmetDaedric [STAT:0010FCCE]
    baserecord := RecordByFormID(FileByIndex(0), $0010FCCE, True)
  end else
  if i = mrNo then begin
    // BasicPlate01 "Plate" [MISC:000E2617]
    baserecord := RecordByFormID(FileByIndex(0), $000E2617, True)
  end else begin
    Result := 1;
    Exit;
  end;

  if not Assigned(baserecord) then begin
    AddMessage('Can not find base record');
    Result := 1;
    Exit;
  end;
end;

//============================================================================
function Process(e: IInterface): integer;
var
  r, ref: IInterface;
  oldid, newid: string;
  i, formid: integer;
begin
  if Signature(e) <> 'LIGH' then
    Exit;
  
  if not ElementExists(e, '模型') then
    Exit;

  r := wbCopyElementToFile(baserecord, GetFile(e), True, True);
  if not Assigned(r) then begin
    AddMessage('Can not copy base record as new');
    Result := 1;
    Exit;
  end;

  oldid := GetElementEditValues(e, 'EDID');
  newid := StringReplace(oldid, 'light', '', [rfReplaceAll, rfIgnoreCase]);
  if SameText(oldid, newid) then newid := newid + 'LIGH';

  SetElementEditValues(r, 'EDID', newid);
  SetElementEditValues(r, '模型\MODL', GetElementEditValues(e, '模型\MODL'));
  if Signature(r) = 'MISC' then begin
    SetElementEditValues(r, 'FULL', GetElementEditValues(e, 'EDID'));
    SetElementEditValues(r, 'DATA\价值', '1');
    SetElementEditValues(r, 'DATA\重量', '1');
    formid := GetLoadOrderFormID(e);
    RemoveNode(e);
    SetLoadOrderFormID(r, formid);
  end else begin
    // remove mesh from LIGH
    RemoveElement(e, '模型');
    // copy references for STAT
    for i := 0 to ReferencedByCount(e) - 1 do begin
      // copy reference and point to STAT
      ref := wbCopyElementToFile(ReferencedByIndex(e, i), GetFile(e), True, True);
      SetElementEditValues(ref, 'NAME', Name(r));
      // remove scale from LIGH reference since it has no mesh now
      RemoveElement(ReferencedByIndex(e, i), 'XSCL');
    end;
  end;
end;

end.
