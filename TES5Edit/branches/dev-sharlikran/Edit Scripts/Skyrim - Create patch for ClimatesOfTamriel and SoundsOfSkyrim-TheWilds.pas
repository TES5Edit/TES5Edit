{
  Create patch plugin that will contain weather changes
  from Climates of Tamriel and sound changes from Sounds of Skyrim - The Wilds.
}
unit UserScript;

const
  sCoT = 'ClimatesOfTamriel.esm';
  sSoSTheWilds = 'SoS - The Wilds.esp';

// helper function, get record by FormID from group
function GetRecordFromGroup(grp: IInterface; f: Cardinal): IInterface;
var
  e: IInterface;
  i: integer;
begin
  Result := nil;
  for i := 0 to ElementCount(grp) - 1 do begin
    e := ElementByIndex(grp, i);
    if FormID(e) = f then begin
      Result := e;
      Exit;
    end;
  end;
end;

// helper function, finds Region Data Entry of 'Sound' type in REGN Region Data Entries
function SoundDataFromREGN(r: IInterface): IInterface;
var
  entries, e: IInterface;
  i: integer;
begin
  Result := nil;
  entries := ElementByName(r, 'Region Data Entries');
  for i := 0 to ElementCount(entries) - 1 do begin
    e := ElementByIndex(entries, i);
    if GetElementEditValues(e, 'RDAT\Type') = 'Sound' then begin
      Result := e;
      Exit;
    end;
  end;
end;
  
function Initialize: integer;
var
  i: integer;
  s: string;
  f, f_cot, f_sosw: IInterface; // plugins
  g_cot, g_sosw: IInterface; // REGN groups
  r_cot, r_sosw, r_patch: IInterface; // records
  s1, s2: IInterface;
begin
  // find both plugins in load order
  for i := 0 to FileCount - 1 do begin
    f := FileByIndex(i);
    s := GetFileName(f);
    // SameText - case insensitive compare
    if SameText(s, sCoT) then f_cot := f else
      if SameText(s, sSoSTheWilds) then f_sosw := f;
  end;
  
  if not Assigned(f_cot) or not Assigned(f_sosw) then begin
    MessageDlg(Format('You must have both %s and %s loaded', [sCoT, sSoSTheWilds]), mtConfirmation, [mbOk], 0);
    Result := 1;
    Exit;
  end;

  // GRUP of REGN from SoS and CoT
  g_sosw := GroupBySignature(f_sosw, 'REGN');
  g_cot := GroupBySignature(f_cot, 'REGN');
  if not Assigned(g_sosw) or not Assigned(g_cot) then begin
    AddMessage('No REGN groups found');
    Result := 1;
    Exit;
  end;

  // create a new patch file
  f := AddNewFile;
  if not Assigned(f) then begin
    Result := 1;
    Exit;
  end;

  // iterate through all REGN records in SoS
  for i := 0 to ElementCount(g_sosw) - 1 do begin

    // get REGN record from SoS
    r_sosw := ElementByIndex(g_sosw, i);

    // get the same REGN record from CoT
    r_cot := GetRecordFromGroup(g_cot, FormID(r_sosw));

    // if SoS record doesn't override CoT then skip it
    if not Assigned(r_cot) then Continue;
    
    // add required masters before copying record to patch file
    AddRequiredElementMasters(r_cot, f, False);

    // copy REGN record from CoT to patch file
    // Element, File, AsNew, DeepCopy
    r_patch := wbCopyElementToFile(r_cot, f, False, True);
    
    // copy only sounds from SoS REGN record to patch file
    s1 := SoundDataFromREGN(r_sosw);
    s2 := SoundDataFromREGN(r_patch);
    if not Assigned(s1) or not Assigned(s2) then Continue;

    // add SoS as a master before copying data from it
    AddRequiredElementMasters(r_sosw, f, False);
    
    // copy sounds from SoS to patch
    // Element from, index, element to, AsNew
    ElementAssign(s2, LowInteger, s1, False);

  end;
  
  AddMessage('Patch is ready.');

end;

function Process(e: IInterface): integer;
begin
  // everything is done in initialization, terminate
  Result := 1;
end;

end.