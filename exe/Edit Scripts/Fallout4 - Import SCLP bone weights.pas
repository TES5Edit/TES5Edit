{
  Import *.sclp bone scales into Armor Addon record
  Apply to ARMA record
}
unit FO4ImportSCLP;

const
  bUseDataPath = 0; // 0 - use Edit Scripts folder by default, 1 - use Data folder

procedure ImportSCLP(e: IInterface; aGender, aFileName: string);
var
  BoneData, GenderEntry, Bones, Bone, Scales: IInterface;
  sl: TStringList;
  regexp: TPerlRegEx;
  i: integer;
  bFound: Boolean;
begin
  // if not bone scales present, then create
  if not ElementExists(e, 'Bone Data') then begin
    BoneData := Add(e, 'Bone Data', True);
    // gender entry is created automatically
    GenderEntry := ElementByIndex(BoneData, 0);
  end
  // otherwise find existing one for our gender
  else begin
    BoneData := ElementByName(e, 'Bone Data');
    for i := 0 to Pred(ElementCount(BoneData)) do begin
      GenderEntry := ElementByIndex(BoneData, i);
      if GetElementEditValues(GenderEntry, 'BSMP') = aGender then begin
        // if found, remove current bones
        RemoveElement(GenderEntry, 'Bones');
        bFound := True;
        Break;
      end;
    end;
    // if gender entry not found, then add a new one
    if not bFound then
      GenderEntry := ElementAssign(BoneData, HighInteger, nil, False);
  end;
  
  // setting gender
  SetElementEditValues(GenderEntry, 'BSMP', aGender);
  // adding bone scales
  Bones := ElementAssign(GenderEntry, 1, nil, False);

  sl := TStringList.Create;
  sl.LoadFromFile(aFileName);
  regexp := TPerlRegEx.Create;
  try
    regexp.Subject := sl.Text;
    regexp.RegEx := '"Name"[:\s]*"(\w+)".+?"x"[:\s]*([0-9\.]+).+?"y"[:\s]*([0-9\.]+).+?"z"[:\s]*([0-9\.]+)';
    regexp.Options := [preCaseLess, preMultiLine, preSingleLine];
    i := 0;
    while regexp.MatchAgain do begin
      // skip unchanged 1.0 bone weights
      if SameValue(FloatToStr(regexp.Groups[2]), 1.0) and SameValue(FloatToStr(regexp.Groups[3]), 1.0) and SameValue(FloatToStr(regexp.Groups[4]), 1.0) then begin
        AddMessage('Skipping "' + regexp.Groups[1] + '" because of unchanged weights');
        Continue;
      end;
      
      // first entry is created automatically
      if i = 0 then
        Bone := ElementByIndex(Bones, 0)
      else
        Bone := ElementAssign(Bones, HighInteger, nil, False);
      Inc(i);

      // adding BSMS scale values
      Scales := ElementAssign(Bone, 1, nil, False);
      
      // add 3 values
      while ElementCount(Scales) < 3 do
        ElementAssign(Scales, HighInteger, nil, False);
      
      // setting values
      SetElementEditValues(Bone, 'BSMB', regexp.Groups[1]);
      SetElementEditValues(Bone, 'BSMS\Value #0', regexp.Groups[2]);
      SetElementEditValues(Bone, 'BSMS\Value #1', regexp.Groups[3]);
      SetElementEditValues(Bone, 'BSMS\Value #2', regexp.Groups[4]);
      
      // normalize around 0.0
      SetElementNativeValues(Bone, 'BSMS\Value #0', GetElementNativeValues(Bone, 'BSMS\Value #0') - 1.0);
      SetElementNativeValues(Bone, 'BSMS\Value #1', GetElementNativeValues(Bone, 'BSMS\Value #1') - 1.0);
      SetElementNativeValues(Bone, 'BSMS\Value #2', GetElementNativeValues(Bone, 'BSMS\Value #2') - 1.0);
    end;
  finally
    regexp.Free;
    sl.Free;
  end;
  
  AddMessage(Format('Done. Imported %d bones.', [i]));
end;

function Process(e: IInterface): Integer;
var
  dlg: TOpenDialogue;
  fname, gender: string;
begin
  if Signature(e) <> 'ARMA' then
    Exit;
  
  dlg := TOpenDialog.Create(nil);
  try
    dlg.Filter := 'SCLP files (*.sclp)|*.sclp';
    if bUseDataPath = 1 then
      dlg.InitialDir := wbDataPath
    else
      dlg.InitialDir := wbScriptsPath;
    dlg.FileName := EditorID(e) + '.sclp';
    if dlg.Execute then
      fname := dlg.FileName
    else
      Exit;
  finally
    dlg.Free;
  end;

  if MessageDlg('Import as Male [YES] or Female [NO] bones?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    gender := 'Male'
  else
    gender := 'Female';
  
  ImportSCLP(e, gender, fname);
end;

end.
