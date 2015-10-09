{
  Convert LIGH record with mesh to
  1) STAT: duplicate mesh to a new STAT record and duplicate all references and point them to that STAT
  2) MISC: convert LIGH record to MISC (LIGH is removed, references redirected to the newly created MISC)
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
  
  if not ElementExists(e, 'Model') then
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
  SetElementEditValues(r, 'Model\MODL', GetElementEditValues(e, 'Model\MODL'));
  if Signature(r) = 'MISC' then begin
    SetElementEditValues(r, 'FULL', GetElementEditValues(e, 'EDID'));
    SetElementEditValues(r, 'DATA\Value', '1');
    SetElementEditValues(r, 'DATA\Weight', '1');
    formid := GetLoadOrderFormID(e);
    RemoveNode(e);
    SetLoadOrderFormID(r, formid);
  end else begin
    // remove mesh from LIGH
    RemoveElement(e, 'Model');
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
