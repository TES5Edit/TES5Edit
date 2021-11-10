{
  Export selected quest dialogues for Fallout 3 and Fallout New Vegas
  Apply to quest record(s)
}
unit FNVExportDialogue;

const
  fDebug = False;

var
  slExport: TStringList;
  lstRecursion: TList;
  ExportFileName, InfoNPCID, InfoSPEAKER: string;

//============================================================================
// uncomment to check debug messages
procedure AddDebug(aMsg: string);
begin
  if fDebug then
    AddMessage('DEBUG: ' + aMsg);
end;

//============================================================================
function Initialize: integer;
begin
  slExport := TStringList.Create;
  lstRecursion := TList.Create;
end;

//============================================================================
function InfoFileName(QuestID, DialID: string; InfoFormID, RespNum: integer): string;
var
  qlen, dlen: integer;
begin
  qlen := Length(QuestID);
  dlen := Length(DialID);
  if qlen + dlen > 25 then begin
    if qlen > 10 then begin
      qlen := 10;
      dlen := 15;
    end else
      dlen := 10 - qlen + 15;
  end;
  Result := Format('%s_%s_%s_%d', [
    Copy(QuestID, 1, qlen),
    Copy(DialID, 1, dlen),
    IntToHex(InfoFormID and $FFFFFF, 8),
    RespNum
  ]);
end;

//============================================================================
// get voice types from record or reference of record (not to be called directly)
procedure GetRecordVoiceTypes2(e: IInterface; lstVoice: TStringList);
var
  sig: string;
  i: integer;
  ent, ents: IInterface;
begin
  // recursive function, prevent calling itself in loop
  // check against the list of processed FormIDs
  if lstRecursion.IndexOf(FormID(e)) <> -1 then Exit
    else lstRecursion.Add(FormID(e));
  
  e := WinningOverride(e);
  AddDebug('GetRecordVoiceType '+Name(e));

  sig := Signature(e);
  if (sig = 'REFR') or (sig = 'ACHR') then begin
    e := WinningOverride(BaseRecord(e));
    sig := Signature(e);
  end;
    
  // Voice type record
  if sig = 'VTYP' then begin
    lstVoice.AddObject(EditorID(e), e);
  end
  // NPC_ or CREA record
  else if (sig = 'NPC_') or (sig = 'CREA') then begin
    // if has voice then get it
    if ElementExists(e, 'VTCK - Voice') then begin
      InfoNPCID := Name(e);
      //InfoRACEID := GetElementEditValues(e, 'RNAM - Race');
      ent := LinksTo(ElementByName(e, 'VTCK - Voice'));
      GetRecordVoiceTypes2(ent, lstVoice);
    end
    // otherwise get voice from template
    else if ElementExists(e, 'TPLT - Template') then begin
      ent := LinksTo(ElementByName(e, 'TPLT - Template'));
      GetRecordVoiceTypes2(ent, lstVoice);
    end;
  end
  // npc leveled list
  else if sig = 'LVLN' then begin
    ents := ElementByName(e, 'Leveled List Entries');
    for i := 0 to Pred(ElementCount(ents)) do begin
      ent := ElementByIndex(ents, i);
      ent := LinksTo(ElementByPath(ent, 'LVLO\Reference'));
      GetRecordVoiceTypes2(ent, lstVoice);
    end;
  end
  // Talking activator record
  else if sig = 'TACT' then begin
    ent := WinningOverride(LinksTo(ElementByName(e, 'VNAM - Voice Type')));
    if Signature(ent) = 'VTYP' then lstVoice.AddObject(EditorID(ent), ent);
  end
  // Form List record
  else if sig = 'FLST' then begin
    ents := ElementByName(e, 'FormIDs');
    for i := 0 to Pred(ElementCount(ents)) do begin
      ent := LinksTo(ElementByIndex(ents, i));
      GetRecordVoiceTypes2(ent, lstVoice);
    end;
  end
  // Faction/class record
  else if (sig = 'FACT') or (sig = 'CLAS') then begin
    for i := 0 to Pred(ReferencedByCount(e)) do begin
      ent := ReferencedByIndex(e, i);
      if Signature(ent) = 'NPC_' then
        GetRecordVoiceTypes2(ent, lstVoice);
    end;
  end;
end;

//============================================================================
// get voice types from record or reference of record
procedure GetRecordVoiceTypes(e: IInterface; lstVoice: TStringList);
begin
  // clear recursion list
  lstRecursion.Clear;
  GetRecordVoiceTypes2(e, lstVoice);
end;

//============================================================================
// get voice types from conditions
procedure GetConditionsVoiceTypes(Conditions: IInterface; lstVoice: TStringList);
var
  Condition, Elem: IInterface;
  ConditionFunction: string;
  lstVoiceCondition: TStringList;
  i, j: integer;
  bGetIsID, boolOR: Boolean;
begin
  AddDebug('GetConditionsVoiceTypes ' + FullPath(Conditions));

  lstVoiceCondition := TStringList.Create; lstVoiceCondition.Duplicates := dupIgnore; lstVoiceCondition.Sorted := True;

  // check all condition functions beforehand
  // GetIsID has priority over everything else, if it is found ignore other functions
  for i := 0 to Pred(ElementCount(Conditions)) do
    if GetElementEditValues(ElementByIndex(Conditions, i), 'Function') = 'GetIsID' then begin
      bGetIsID := True;
      Break;
    end;

  boolOR := True;
  
  for i := 0 to Pred(ElementCount(Conditions)) do begin
    Condition := ElementByIndex(Conditions, i);
    ConditionFunction := GetElementEditValues(Condition, 'Function');
    // NPC
    if ConditionFunction = 'GetIsID' then begin
      Elem := LinksTo(ElementByPath(Condition, 'Referenceable Object'));
      GetRecordVoiceTypes(Elem, lstVoiceCondition);
    end else
    
    // skip other functions if GetIsID is used
    if not bGetIsID then 

    // Voice type of FLST list of voice types
    if ConditionFunction = 'GetIsVoiceType' then begin
      Elem := LinksTo(ElementByPath(Condition, 'Voice Type'));
      GetRecordVoiceTypes(Elem, lstVoiceCondition);
    end

    // voices of all NPC members of a faction
    else if ConditionFunction = 'GetInFaction' then begin
      Elem := LinksTo(ElementByPath(Condition, 'Faction'));
      GetRecordVoiceTypes(Elem, lstVoiceCondition);
      // if faction is applied as AND, then filter by voices instead of adding them
      if not boolOR then begin
        for j := Pred(lstVoice.Count) downto 0 do
          if lstVoiceCondition.IndexOf(lstVoice[j]) = -1 then
            lstVoice.Delete(j);
        lstVoiceCondition.Clear;
      end;
    end

    // voices of all NPC members by a class
    else if ConditionFunction = 'GetIsClass' then begin
      Elem := LinksTo(ElementByPath(Condition, 'Class'));
      GetRecordVoiceTypes(Elem, lstVoiceCondition);
    end;
    
    boolOR := GetElementNativeValues(Condition, 'Type') and 1 <> 0;

    if lstVoiceCondition.Count = 0 then
      Continue;
    
    // not sure about how to combine voice types from several conditions, for now just OR
    lstVoice.AddStrings(lstVoiceCondition);
    
    lstVoiceCondition.Clear;
  end;
  
  lstVoiceCondition.Free;
end;

//============================================================================
// get a list of voice types for INFO record
procedure InfoVoiceTypes(Info: IInterface; lstVoice: TStringList);
var
  Elem: IInterface;
begin
  InfoNPCID := '';
  InfoSPEAKER := '';
  lstVoice.Clear;
  
  // check Speaker
  Elem := ElementByName(Info, 'ANAM - Speaker');
  if Assigned(Elem) then begin
    Elem := LinksTo(Elem);
    GetRecordVoiceTypes(Elem, lstVoice);
    InfoSPEAKER := Name(Elem);
    Exit;
  end

  // check Conditions
  else begin
    if ElementExists(Info, 'Conditions') then
      GetConditionsVoiceTypes(ElementByName(Info, 'Conditions'), lstVoice);
  end;
  
  // if still can't determine voices, then use all of them?
  {if lstVoice.Count = 0 then begin
    AddMessage('Warning: No voice types found for ' + Name(Info));
  end;}
end;

//============================================================================
procedure ExportQuest(Quest: IInterface);
var
  i, j, r, v: integer;
  lstInfo, lstVoice: TStringList;
  Dialogue, Info: IInterface;
  Responses, Response: IInterface;
  ResponseNumber: integer;
  Voice, VoiceFileName, VoiceFilePath: string;
begin
  lstInfo := TStringList.Create; lstInfo.Duplicates := dupIgnore; lstInfo.Sorted := True;
  lstVoice := TStringList.Create; lstVoice.Duplicates := dupIgnore; lstVoice.Sorted := True;

  // scan for all INFO references of quest
  for i := 0 to Pred(ReferencedByCount(Quest)) do begin
    Info := WinningOverride(ReferencedByIndex(Quest, i));
    if Signature(Info) <> 'INFO' then
      Continue;
    if GetElementEditValues(Info, 'QSTI') <> Name(Quest) then
      Continue;
    
    lstInfo.AddObject(IntToHex(GetLoadOrderFormID(Info), 8), Info);
  end;
  
  AddDebug('Infos found: ' + IntToStr(lstInfo.Count));

  // TODO: sort the list of quest topics
  
  // processing quest INFOs
  for i := 0 to Pred(lstInfo.Count) do begin
    Info := ObjectToElement(lstInfo.Objects[i]);
    //if FormID(Info) <> $000E88FA then Continue;
    
    if GetIsDeleted(Info) then
      Continue;

    AddDebug(Name(Info));

    Responses := ElementByName(Info, 'Responses');
    if not Assigned(Responses) then
      Continue;

    Dialogue := LinksTo(ElementByIndex(Info, 0));

    // list of voice types for INFO
    InfoVoiceTypes(Info, lstVoice);
    AddDebug('Voices: ' + Trim(lstVoice.CommaText));
    
    for r := 0 to Pred(ElementCount(Responses)) do begin
      Response := ElementByIndex(Responses, r);
      ResponseNumber := GetElementNativeValues(Response, 'TRDT\Response number');
      
      for v := -1 to Pred(lstVoice.Count) do begin
        // -1 index is when no voices were detected
        if (v = -1) and (lstVoice.Count <> 0) then
          Continue;

        // use * instead of voice when no voices were determined
        if (v = -1) and (lstVoice.Count = 0) then
          Voice := '*'
        else
          Voice := lstVoice[v];

        VoiceFileName := InfoFileName(EditorID(Quest), EditorID(Dialogue), GetLoadOrderFormID(Info), ResponseNumber);
        VoiceFilePath := Format('Data\Sound\Voice\%s\%s\', [GetFileName(Quest), Voice]);
        
        slExport.Add(Format('%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s', [
          GetFileName(Quest),
          Name(Quest),
          InfoNPCID,
          InfoSPEAKER,
          Voice,
          GetElementEditValues(Dialogue, 'DATA\Type'),
          Trim(EditorID(Info) + ' [INFO:' + IntToHex(FormID(Info), 8) + ']'),
          IntToStr(ResponseNumber),
          VoiceFilePath + VoiceFileName + '.ogg',
          GetElementEditValues(Dialogue, 'FULL'),
          GetElementEditValues(INFO, 'RNAM - Prompt'),
          GetElementEditValues(Response, 'NAM1 - Response Text'),
          GetElementEditValues(Response, 'TRDT\Emotion Type') + ' ' + GetElementEditValues(Response, 'TRDT\Emotion Value'),
          GetElementEditValues(Response, 'NAM2 - Script Notes')
        ]));
        //AddMessage(slExport[Pred(slExport.Count)]);
      end
    end;
  end;
  
  lstInfo.Free;
  lstVoice.Free;

  ExportFileName := 'dialogueExport' + EditorID(Quest) + '.csv';
end;

//============================================================================
function Process(e: IInterface): integer;
var
  s: string;
  sl: TStringList;
begin
  if Signature(e) <> 'QUST' then
    Exit;

  AddMessage('=== EXPORTING: ' + Name(e));

  e := MasterOrSelf(e);
  
  if ContainerStates(GetFile(e)) and (1 shl csRefsBuild) = 0 then begin
    AddMessage('Skipping quest, references are not built for file ' + GetFileName(e));
    AddMessage('Use Right click \ Other \ Build Reference Info menu and try again.');
    Exit;
  end;

  ExportQuest(e);
end;

//============================================================================
function Finalize: integer;
var
  dlgSave: TSaveDialog;
begin
  if slExport.Count <> 0 then begin
    dlgSave := TSaveDialog.Create(nil);
    try
      dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
      dlgSave.Filter := 'Excel (*.csv)|*.csv';
      dlgSave.InitialDir := ScriptsPath;
      dlgSave.FileName := ExportFileName;
      if dlgSave.Execute then begin
        ExportFileName := dlgSave.FileName;
        AddMessage('Saving ' + ExportFileName);
        slExport.Insert(0, 'PLUGIN'#9'QUEST'#9'NPCID'#9'SPEAKER'#9'VOICE TYPE'#9'TYPE'#9'TOPIC'#9'RESPONSE INDEX'#9'FILENAME'#9'TOPIC TEXT'#9'PROMPT'#9'RESPONSE TEXT'#9'EMOTION'#9'SCRIPT NOTES');
        slExport.SaveToFile(ExportFileName);
      end;
    finally
      dlgSave.Free;
    end;
  end;
  slExport.Free;
  lstRecursion.Free;
end;

end.
