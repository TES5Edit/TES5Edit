{
  Plugin translator for Fallout3 and New Vegas.
  Build dictionary from translated mods and translate other mods using it.
  When translating, every string value is replaced matching pair from dictionary.
  When adding to dictionary, plugin must have a master file in original language.
}
unit UserScript;

var
  bTranslate: boolean;
  DictionaryFile: string;
  sl, slSkip: TStringList;
  sl1, sl2: TStringList;  // accumulated strings for each record
  slLang1, slLang2: TStringList; // dictionaries

//=======================================================================
// convert multiline string to oneline
function OneLineStr(s: string): string;
begin
  Result := StringReplace(s, #13, '#13', [rfReplaceAll]);
  Result := StringReplace(Result, #10, '#10', [rfReplaceAll]);
end;

//=======================================================================
// convert oneline string to multiline
function MultiLineStr(s: string): string;
begin
  Result := StringReplace(s, '#13', #13, [rfReplaceAll]);
  Result := StringReplace(Result, '#10', #10, [rfReplaceAll]);
end;

//=======================================================================
// process string element
procedure HandleElement(e: IInterface; sl: TStrings);
var
  s: string;
  i: integer;
begin
  if not Assigned(e) then  Exit;
  s := Trim(OneLineStr(GetEditValue(e)));
  if s = '' then Exit;
  if not bTranslate then
    sl.Add(s)
  else begin
    i := slLang1.IndexOf(s);
    if i <> -1 then
      SetEditValue(e, MultiLineStr(slLang2[i]));
  end;
end;

//=======================================================================
// process record
procedure HandleRecord(e: IInterface; sl: TStrings);
var
  i, j: integer;
  f, s: string;
  entry, entries: IInterface;
  entry2, entries2: IInterface;
begin
  f := Signature(e);

  // skip records without localizable text
  if slSkip.IndexOf(f) <> - 1 then
    Exit;

  // subrecords that are always text regardless record type
  HandleElement(ElementBySignature(e, 'FULL'), sl);
  HandleElement(ElementBySignature(e, 'DESC'), sl);
  HandleElement(ElementBySignature(e, 'XATO'), sl);
  
  if f = 'AMMO' then begin
    HandleElement(ElementBySignature(e, 'ONAM'), sl); // ammo shortname
    HandleElement(ElementBySignature(e, 'QNAM'), sl); // ammo abbrev.
  end else
    
  if f = 'BPTD' then begin
    entries := ElementByName(e, 'Body Parts');
    for i := 0 to ElementCount(entries) - 1 do begin
      entry := ElementByIndex(entries, i);
      HandleElement(ElementBySignature(entry, 'BPTN'), sl); // body part name
    end;
  end else

  if f = 'INFO' then begin
    entries := ElementByName(e, 'Responses');
    for i := 0 to ElementCount(entries) - 1 do begin
      entry := ElementByIndex(entries, i);
      HandleElement(ElementBySignature(entry, 'NAM1'), sl); // response text
      HandleElement(ElementBySignature(entry, 'NAM2'), sl); // response notes
      HandleElement(ElementBySignature(entry, 'NAM3'), sl); // response edits
    end;
  end else

  if f = 'FACT' then begin
    entries := ElementByName(e, 'Ranks');
    for i := 0 to ElementCount(entries) - 1 do begin
      entry := ElementByIndex(entries, i);
      HandleElement(ElementBySignature(entry, 'MNAM'), sl); // male rank
      HandleElement(ElementBySignature(entry, 'FNAM'), sl); // female rank
    end;
  end else

  if f = 'GMST' then begin
    if Copy(GetElementEditValues(e, 'EDID'), 1, 1) = 's' then
      if Pos('.dds', GetElementEditValues(e, 'DATA')) = 0 then
        HandleElement(ElementBySignature(e, 'DATA'), sl); // value
  end else

  if f = 'MESG' then begin
    entries := ElementByName(e, 'Menu Buttons');
    for i := 0 to ElementCount(entries) - 1 do begin
      entry := ElementByIndex(entries, i);
      HandleElement(ElementBySignature(entry, 'ITXT'), sl); // button text
    end;
  end else

  if f = 'NOTE' then begin
    if GetElementEditValues(e, 'DATA') = 'Text' then
      HandleElement(ElementByPath(e, 'TNAM\Text'), sl); // note text
  end else

  if f = 'PERK' then begin
    entries := ElementByName(e, 'Effects');
    for i := 0 to ElementCount(entries) - 1 do begin
      entry := ElementByIndex(entries, i);
      HandleElement(ElementByPath(entry, 'Entry Point Function Parameters\EPF2'), sl); // button label
    end;
  end else

  if f = 'QUST' then begin
    entries := ElementByName(e, 'Objectives');
    for i := 0 to ElementCount(entries) - 1 do begin
      entry := ElementByIndex(entries, i);
      HandleElement(ElementBySignature(entry, 'NNAM'), sl); // objective description
    end;
    entries := ElementByName(e, 'Stages');
    for i := 0 to ElementCount(entries) - 1 do begin
      entry := ElementByIndex(entries, i);
      entries2 := ElementByName(entry, 'Log Entries');
      for j := 0 to ElementCount(entries2) - 1 do begin
        entry2 := ElementByIndex(entries2, j);
        HandleElement(ElementBySignature(entry2, 'CNAM'), sl); // log entry
      end;
    end;
  end else
  
  if f = 'REGN' then begin
    entries := ElementByName(e, 'Region Data Entries');
    for i := 0 to ElementCount(entries) - 1 do begin
      entry := ElementByIndex(entries, i);
      HandleElement(ElementBySignature(entry, 'RDMP'), sl); // map name
    end;
  end else

  if f = 'TERM' then begin
    entries := ElementByName(e, 'Menu Items');
    for i := 0 to ElementCount(entries) - 1 do begin
      entry := ElementByIndex(entries, i);
      HandleElement(ElementBySignature(entry, 'ITXT'), sl); // item text
      HandleElement(ElementBySignature(entry, 'RNAM'), sl); // result text
    end;
  end else

  if f = 'WEAP' then begin
    HandleElement(ElementBySignature(e, 'VANM'), sl); // VATS attack name
  end else

  if f = 'REFR' then begin
    if ElementExists(e, 'Map Marker') then
      HandleElement(ElementByPath(e, 'Map Marker\FULL'), sl); // marker name
  end;
end;

//=======================================================================
function Initialize: integer;
var
  i: integer;
begin
  i := MessageDlg('Translate [YES] or add to dictionary [NO]?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if i = mrYes then bTranslate := True else
    if i = mrNo then bTranslate := False else
      begin
        Result := 1;
        Exit;
      end;
  sl := TStringList.Create;
  sl1 := TStringList.Create;
  sl2 := TStringList.Create;
  slLang1 := TStringList.Create;
  slLang2 := TStringList.Create;
  DictionaryFile := ProgramPath + 'Edit Scripts\TranslatorDictionary.txt';
  // load dictionary if already exists
  if FileExists(DictionaryFile) then begin
    sl.LoadFromFile(DictionaryFile);
    for i := 0 to sl.Count - 1 do
      if i mod 2 = 0 then slLang1.Add(sl[i]) else slLang2.Add(sl[i]);
    sl.Clear;
  end;
  // skip records
  slSkip := TStringList.Create;
  slSkip.Add('ADDN');
  slSkip.Add('ALOC');
  slSkip.Add('ANIO');
  slSkip.Add('ARMA');
  slSkip.Add('ASPC');
  slSkip.Add('CAMS');
  slSkip.Add('CLMT');
  slSkip.Add('CPTH');
  slSkip.Add('CSTY');
  slSkip.Add('DEBR');
  slSkip.Add('DEHY');
  slSkip.Add('ECZN');
  slSkip.Add('EFSH');
  slSkip.Add('FLST');
  slSkip.Add('GLOB');
  slSkip.Add('GRAS');
  slSkip.Add('HUNG');
  slSkip.Add('IDLE');
  slSkip.Add('IDLM');
  slSkip.Add('IMAD');
  slSkip.Add('IMGS');
  slSkip.Add('IPCT');
  slSkip.Add('IPDS');
  slSkip.Add('LGTM');
  slSkip.Add('LTEX');
  slSkip.Add('LVLC');
  slSkip.Add('LVLI');
  slSkip.Add('LVLN');
  slSkip.Add('MUSC');
  slSkip.Add('NAVI');
  slSkip.Add('PACK');
  slSkip.Add('PWAT');
  slSkip.Add('RGDL');
  slSkip.Add('SCOL');
  slSkip.Add('SOUN');
  slSkip.Add('STAT');
  slSkip.Add('TREE');
  slSkip.Add('TXST');
  slSkip.Add('VTYP');
  slSkip.Add('WTHR');
  slSkip.Add('NAVM');
  slSkip.Add('LAND');
end;

//=======================================================================
function Process(e: IInterface): integer;
var
  m: IInterface;
  i, idx: integer;
begin
  // *** Dictionary mode ***
  if not bTranslate then begin
    m := Master(e);
    if not Assigned(m) then
      Exit;
    sl1.Clear;
    sl2.Clear;
    HandleRecord(m, sl1);
    HandleRecord(e, sl2);
    // number of string values in records must match
    if sl1.Count <> sl2.Count then
      Exit;
    // adding to dictionary
    for i := 0 to sl1.Count - 1 do begin
      // skip matching strings or empty translations
      if (sl1[i] = sl2[i]) or (sl2[i] = '') then
        Continue;
      // add only new strings
      idx := slLang1.IndexOf(sl1[i]);
      if idx = -1 then begin
        slLang1.Add(sl1[i]);
        slLang2.Add(sl2[i]);
      end;
    end;
  end else
  // *** Translation mode ***
    HandleRecord(e, sl1);
end;

//=======================================================================
function Finalize: integer;
var
  i, idx: integer;
begin
  // save dictionary when not in translation mode
  if not bTranslate then begin
    if slLang1.Count > 0 then begin
      for i := 0 to slLang1.Count - 1 do begin
        sl.Add(slLang1[i]);
        sl.Add(slLang2[i]);
      end;
      AddMessage('Saving dictionary to ' + DictionaryFile);
      sl.SaveToFile(DictionaryFile);
    end;
  end;
  sl.Free;
  slSkip.Free;
  sl1.Free;
  sl2.Free;
  slLang1.Free;
  slLang2.Free;
end;


end.