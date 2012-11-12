{
  Export and import weapons stats from *.csv files.
  Right click and apply script to selected weapons, weapon group,
  plugin or several selected plugins.
}
unit UserScript;

var
  slWeap, slValues, slLookup: TStringList;
  DoExport: boolean;
  
function Initialize: integer;
var
  i: integer;
  dlgOpen: TOpenDialog;
begin
  Result := 0;
  
  // select Export or Import mode
  i := MessageDlg('Export [YES] or import [NO] weapons stats from file?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if i = mrYes then DoExport := true else
    if i = mrNo then DoExport := false else begin
      Result := 1;
      Exit;
    end;

  // strings list with weapons data
  slWeap := TStringList.Create;

  // list used to divide imported values
  slValues := TStringList.Create;
  slValues.Delimiter := ';';
  slValues.StrictDelimiter := true; // don't treat space as a delimiter

  // lookup list to find formids when importing
  slLookup := TStringList.Create;
  
  if DoExport then begin
    // Export: add columns headers line
    slWeap.Add('FormID;Name;Value;Weight;Damage;Speed;Reach;Crit.Damage;Crit.Mult');
  end else begin
    // Import: select file name to import from
    dlgOpen := TOpenDialog.Create(nil);
    dlgOpen.Filter := 'Spreadsheet files (*.csv)|*.csv';
    if dlgOpen.Execute then begin
      slWeap.LoadFromFile(dlgOpen.FileName);
      // remove the first header line
      if slWeap.Count > 0 then slWeap.Delete(0);
      // create lookup list (just to speed up the import process)
      for i := 0 to slWeap.Count - 1 do
        slLookup.Add(Copy(slWeap[i], 2, 8));
    end;
    dlgOpen.Free;
    // nothing to import
    if slWeap.Count = 0 then begin
      slWeap.Free;
      slValues.Free;
      Result := 1;
      Exit;
    end;
  end;
  
end;

function Process(e: IInterface): integer;
var
  i: integer;
begin
  Result := 0;
  
  // prevent import into skyrim.esm, SameText - case insensitive compare
  if not DoExport and SameText(GetFileName(e), 'skyrim.esm') then
    Exit;
  
  // process only weapons, skip other records
  if Signature(e) <> 'WEAP' then
    Exit;
  
  if DoExport then begin
    // use square brackets [] on formid to prevent Excel from treating them as a numbers
    slWeap.Add(Format('[%s];%s;%s;%s;%s;%s;%s;%s;%s', [
      // FixedFormID depends only on explicit masters and not affected by plugin's load order
      IntToHex(FixedFormID(e), 8),
      GetElementEditValues(e, 'FULL - Name'),
      GetElementEditValues(e, 'DATA\Value'),
      GetElementEditValues(e, 'DATA\Weight'),
      GetElementEditValues(e, 'DATA\Damage'),
      GetElementEditValues(e, 'DNAM\Speed'),
      GetElementEditValues(e, 'DNAM\Reach'),
      GetElementEditValues(e, 'CRDT\Damage'),
      GetElementEditValues(e, 'CRDT\% Mult')
    ]));
  end else begin
    i := slLookup.IndexOf(IntToHex(FixedFormID(e), 8));
    // we have a values to import
    if i <> -1 then begin
      // split string by ";" char
      slValues.DelimitedText := slWeap[i];
      // there should be 9 columns in each line
      if slValues.Count = 9 then begin
        // uncomment if you want to import names
        //if GetElementEditValues(e, 'FULL - Name') <> slValues[1] then SetElementEditValues(e, 'FULL - Name', slValues[1]);
        if GetElementEditValues(e, 'DATA\Value')  <> slValues[2] then SetElementEditValues(e, 'DATA\Value', slValues[2]);
        if GetElementEditValues(e, 'DATA\Weight') <> slValues[3] then SetElementEditValues(e, 'DATA\Weight', slValues[3]);
        if GetElementEditValues(e, 'DATA\Damage') <> slValues[4] then SetElementEditValues(e, 'DATA\Damage', slValues[4]);
        if GetElementEditValues(e, 'DNAM\Speed')  <> slValues[5] then SetElementEditValues(e, 'DNAM\Speed', slValues[5]);
        if GetElementEditValues(e, 'DNAM\Reach')  <> slValues[6] then SetElementEditValues(e, 'DNAM\Reach', slValues[6]);
        if GetElementEditValues(e, 'CRDT\Damage') <> slValues[7] then SetElementEditValues(e, 'CRDT\Damage', slValues[7]);
        if GetElementEditValues(e, 'CRDT\% Mult') <> slValues[8] then SetElementEditValues(e, 'CRDT\% Mult', slValues[8]);
      end else
        AddMessage(Format('Line %d doesn''t have 9 columns', [i+1]));
    end;
  end;
end;

function Finalize: integer;
var
  dlgSave: TSaveDialog;
begin
  Result := 0;
  
  if not Assigned(slWeap) then
    Exit;
    
  // save export file only if we have any data besides header line
  if DoExport and (slWeap.Count > 1) then begin
    // ask for file to export to
    dlgSave := TSaveDialog.Create(nil);
    dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
    dlgSave.Filter := 'Spreadsheet files (*.csv)|*.csv';
    dlgSave.InitialDir := ProgramPath;
    dlgSave.FileName := 'weapons.csv';
    if dlgSave.Execute then
      slWeap.SaveToFile(dlgSave.FileName);
    dlgSave.Free;
  end;

  slWeap.Free;
  slValues.Free;
  slLookup.Free;
  
 end;

end.