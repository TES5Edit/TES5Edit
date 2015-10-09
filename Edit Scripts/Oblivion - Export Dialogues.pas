{
  Export dialogues for Oblivion.
  Full voice file names are generated and checked only for lines with GetIsID or GetIsRace conditions.
}
unit OblivionExportDialogues;

var
  slExport, slRaceSex, slIDs: TStringList;

//============================================================================
function InfoFileName(QuestID, DialID: string; InfoFormID: integer; RespNumber: string): string;
begin
  Result := Format('%s_%s_%s_%s', [
    QuestID,
    DialID,
    IntToHex(InfoFormID and $FFFFFF, 8),
    RespNumber
  ]);
end;

//============================================================================
// voice name for male of female of RACE record
function VoiceRaceName(race: IInterface; male: Boolean): string;
var
  voicerace: IInterface;
begin
  if ElementExists(race, 'VNAM') then
    if male then
      voicerace := WinningOverride(LinksTo(ElementByPath(race, 'VNAM\Male')))
    else
      voicerace := WinningOverride(LinksTo(ElementByPath(race, 'VNAM\Female')));
  
  if Assigned(voicerace) then
    Result := GetElementEditValues(voicerace, 'FULL')
  else
    Result := GetElementEditValues(race, 'FULL');
  
  if male then
    Result := Result + '\m'
  else
    Result := Result + '\f';
end;

//============================================================================
procedure GetSpeakersFromRace(e: IInterface; lst: TStringList);
begin
  lst.Add(VoiceRaceName(e, True));
  lst.Add(VoiceRaceName(e, False));
end;

//============================================================================
procedure GetSpeakersFromNPC(e: IInterface; lst: TStringList);
var
  race: IInterface;
begin
  race := LinksTo(ElementBySignature(e, 'RNAM'));
  if GetElementNativeValues(e, 'ACBS\Flags') and 1 = 0 then
    lst.Add(VoiceRaceName(race, True))
  else
    lst.Add(VoiceRaceName(race, False));
end;

//============================================================================
function ParseConditions(conditions: IInterface; lstRaceSex, lstIDs: TStringList): string;
var
  ctda, npc: IInterface;
  i, typ: integer;
  func: string;
  sl: TStringList;
begin
  sl := TStringList.Create;
  for i := 0 to ElementCount(conditions) - 1 do begin
    ctda := ElementByIndex(conditions, i);
    // exclude "Run on target"
    typ := GetElementNativeValues(ctda, 'Type');
    if typ and 2 > 0 then
      Continue;
    // skip equal to 0
    typ := typ and $F0;
    if typ = $00 then
      if Copy(GetEditValue(ElementByIndex(ctda, 2)), 1, 1) = '0' then
        Continue;

    func := GetElementEditValues(ctda, 'Function');
    if func = 'GetIsID' then begin
      npc := WinningOverride(LinksTo(ElementByIndex(ctda, 4)));
      GetSpeakersFromNPC(npc, sl);
      lstIDs.Add(EditorID(npc));
    end
    else if func = 'GetIsRace' then
      GetSpeakersFromRace(WinningOverride(LinksTo(ElementByIndex(ctda, 4))), sl);
    {else if func = 'GetIsSex' then begin
      if GetElementEditValues(ctda, 'Sex') = 'Male' then
        spk := spk + sSpkMale + #13#10
      else
        spk := spk + sSpkFemale + #13#10;
    end;
    else if (func = 'GetInFaction') or (func = 'GetIsClass') then
      spk := spk + GetSpeakersFromFaction(LinksTo(ElementByIndex(ctda, 4))) + #13#10;}
  end;
  //if spk = '' then spk := sSpkMale + #13#10 + sSpkFemale;
  //AddMessage(spk);
  lstRaceSex.AddStrings(sl);
  sl.Free;
end;

//============================================================================
function Initialize: integer;
begin
  slExport := TStringList.Create;
  slExport.Add('Quest'#9'Topic'#9'Type'#9'INFO'#9'File'#9'Has MP3'#9'Has LIP'#9'GetIsID'#9'Emotion'#9'Text');
  slRaceSex := TStringList.Create;
  slRaceSex.Sorted := True;
  slRaceSex.Duplicates := dupIgnore;
  slIDs := TStringList.Create;
end;

//============================================================================
function Process(e: IInterface): Integer;
var
  dial, quest, responses, response: IInterface;
  //ctdas, ctda: IInterface;
  //cond, bool, comp, param, value: string;
  i, j, operator: integer;
  line, fname, fullname, voicename, HasMP3, HasLIP: string;
begin
  if Signature(e) <> 'INFO' then
    Exit;

  slRaceSex.Clear;
  slIDs.Clear;
  ParseConditions(ElementByName(e, 'Conditions'), slRaceSex, slIDs);
  //AddMessage(slRaceSex.Text);
  if slRaceSex.Count = 0 then slRaceSex.Add('');
  //AddMessage(slIDs.Text);
  //Exit;
  
  dial := LinksTo(ElementByName(e, 'Topic'));
  quest := LinksTo(ElementBySignature(e, 'QSTI'));
  responses := ElementByName(e, 'Responses');
  
  {ctdas := ElementByName(e, 'Conditions');
  for i := 0 to Pred(ElementCount(ctdas)) do begin
    ctda := ElementByIndex(ctdas, i);
    operator := GetElementNativeValues(ctda, 'Type');
    if operator and 1 <> 0 then bool := 'OR' else bool := 'AND';

    operator := operator and $F0;
    if operator = $00 then comp := '=='
    else if operator = $20 then comp := '!='
    else if operator = $40 then comp := '>'
    else if operator = $60 then comp := '>='
    else if operator = $80 then comp := '<'
    else if operator = $A0 then comp := '<=';

    param := GetEditValue(ElementByIndex(ctda, 4));
    if param = '00 00 00 00' then param := '';
    
    value := GetEditValue(ElementByIndex(ctda, 2));
    value := StringReplace(value, '.000000', '', [rfReplaceAll]);
    
    cond := cond + Format(#9'%s'#9'%s'#9'%s'#9'%s', [
      GetEditValue(ElementByIndex(ctda, 3)),
      param,
      comp,
      value
    ]);
    if i < Pred(ElementCount(ctdas)) then cond := cond + #9 + bool;
  end;}

  for i := 0 to Pred(ElementCount(responses)) do begin
    response := ElementByIndex(responses, i);
    fname := InfoFileName(
      EditorID(quest), // QUST quest editor id
      EditorID(dial), // DIAL dialogue editor id
      FormID(e), // INFO FormID
      GetElementEditValues(response, 'TRDT\Response number') // response number
    );
    for j := 0 to Pred(slRaceSex.Count) do begin
      if slRaceSex[j] <> '' then
        fullname := slRaceSex[j] + '\' + fname
      else
        fullname := fname;
      
      voicename := 'sound\voice\' + LowerCase(GetFileName(MasterOrSelf(e)) + '\' + fullname) + '.mp3';
      if ResourceExists(voicename) then HasMP3 := '*' else HasMP3 := '';
      if ResourceExists(ChangeFileExt(voicename, '.lip')) then HasLIP := '*' else HasLIP := '';
      
      line :=
        EditorID(quest) + #9 +
        GetElementEditValues(dial, 'FULL')  + #9 +
        GetElementEditValues(dial, 'DATA')  + #9 +
        '[INFO:' + IntToHex(FormID(e), 8) + ']' + #9 +
        fullname + #9 +
        HasMP3 + #9 +
        HasLIP + #9 +
        slIDs.CommaText + #9 +
        GetElementEditValues(response, 'TRDT\Emotion Type') + #9 +
        GetElementEditValues(response, 'NAM1');
      
      //AddMessage(line);
      slExport.Add(line);
    end;
  end;
end;

//============================================================================
function Finalize: integer;
var
  dlgSave: TSaveDialog;
begin
  if slExport.Count > 1 then begin
    dlgSave := TSaveDialog.Create(nil);
    dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
    dlgSave.Filter := 'Text files (*.txt)|*.txt';
    dlgSave.InitialDir := DataPath;
    dlgSave.FileName := 'export.txt';
    if dlgSave.Execute then begin
      AddMessage('Saving ' + dlgSave.FileName);
      slExport.SaveToFile(dlgSave.FileName);
    end;
    dlgSave.Free;
  end;
  slExport.Free;
  slRaceSex.Free;
  slIDs.Free;
end;


end.