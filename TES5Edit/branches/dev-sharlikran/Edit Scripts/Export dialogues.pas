{
  Export selected quest dialogues
}
unit ExportDialogue;

var
  slExport: TStringList;
  InfoNPCID, InfoSPEAKER, InfoRACEID, InfoCONDITION: string;

//============================================================================
// uncomment to check debug messages
procedure AddDebug(aMsg: string);
begin
  AddMessage('DEBUG: ' + aMsg);
end;

//============================================================================
function Initialize: integer;
begin
  slExport := TStringList.Create;
end;

//============================================================================
function InfoFileName(QuestID, DialID: string; InfoFormID, RespNumber: integer): string;
var
  qlen, dlen: integer;
begin
  if Length(QuestID) > 25 then
    QuestID := Copy(QuestID, 1, 25);
  dlen := 15 + Max(0, 10 - Length(QuestID));
  DialID := Copy(DialID, 1, dlen);
  qlen := 25 - Length(DialID);
  QuestID := Copy(QuestID, 1, qlen);
  Result := Format('%s_%s_%s_%d', [
    QuestID,
    DialID,
    IntToHex(InfoFormID and $FFFFFF, 8),
    RespNumber
  ]);
end;

//============================================================================
// get voice types from record or reference of record
procedure GetRecordVoiceTypes(e: IInterface; lstVoice: TStringList);
var
  sig: string;
  i: integer;
  ent, ents: IInterface;
begin
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
  // NPC record
  else if sig = 'NPC_' then begin
    // if has voice then get it
    if ElementExists(e, 'VTCK - Voice') then begin
      InfoNPCID := Name(e);
      InfoRACEID := GetElementEditValues(e, 'RNAM - Race');
      ent := WinningOverride(LinksTo(ElementByName(e, 'VTCK - Voice')));
      if Signature(ent) = 'VTYP' then lstVoice.AddObject(EditorID(ent), ent);
    end
    // otherwise get voice from template
    else if ElementExists(e, 'TPLT - Template') then begin
      ent := WinningOverride(LinksTo(ElementByName(e, 'TPLT - Template')));
      GetRecordVoiceTypes(ent, lstVoice);
    end;
  end
  // npc leveled list
  else if sig = 'LVLN' then begin
    ents := ElementByName(e, 'Leveled List Entries');
    for i := 0 to Pred(ElementCount(ents)) do begin
      ent := ElementByIndex(ents, i);
      ent := WinningOverride(LinksTo(ElementByPath(ent, 'LVLO\Reference')));
      GetRecordVoiceTypes(ent, lstVoice);
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
      ent := WinningOverride(LinksTo(ElementByIndex(ents, i)));
      if Signature(ent) = 'VTYP' then lstVoice.AddObject(EditorID(ent), ent);
    end;
  end;
end;

//============================================================================
// get voice types from quest alias
procedure GetAliasVoiceTypes(Quest: IInterface; aAlias: integer; lstVoice: TStringList);
var
  Aliases, Alias: IInterface;
  i, j: integer;
  lstLimit: TStringList;
begin
  Quest := WinningOverride(Quest);
  AddDebug('GetAliasVoiceTypes ' + Name(Quest) + ' -- ' + IntToStr(aAlias));
  
  Aliases := ElementByName(Quest, 'Aliases');
  for i := 0 to Pred(ElementCount(Aliases)) do begin
    Alias := ElementByIndex(Aliases, i);
    if GetNativeValue(ElementByIndex(Alias, 0)) <> aAlias then
      Continue;

    if ElementExists(Alias, 'ALFR - Forced Reference') then
      GetRecordVoiceTypes(LinksTo(ElementByName(Alias, 'ALFR - Forced Reference')), lstVoice)
    else if ElementExists(Alias, 'ALUA - Unique Actor') then
      GetRecordVoiceTypes(LinksTo(ElementByName(Alias, 'ALUA - Unique Actor')), lstVoice)
    else if ElementExists(Alias, 'External Alias Reference') then
      GetAliasVoiceTypes(
        LinksTo(ElementByPath(Alias, 'External Alias Reference\ALEQ - Quest')),
        GetElementNativeValues(Alias, 'External Alias Reference\ALEA - Alias'),
        lstVoice
      )
    else if ElementExists(Alias, 'Conditions') then
      GetConditionsVoiceTypes(ElementByName(Alias, 'Conditions'), lstVoice);
    
    // from CK Wiki "... list of voice types which the editor uses to limit any dialogue assigned to this alias"
    // so remove everything that is not in list
    if GetElementNativeValues(Alias, 'VTCK - Voice Types') <> 0 then begin
      lstLimit := TStringList.Create;
      GetRecordVoiceTypes(LinksTo(ElementByName(Alias, 'VTCK - Voice Types')), lstLimit);
      for j := Pred(lstVoice.Count) downto 0 do
        if lstLimit.IndexOf(lstVoice[j]) = -1 then
          lstVoice.Delete(j);
      lstLimit.Free;
    end;

    // stop processing other aliases
    Break;
  end;
end;

//============================================================================
// get voice types from conditions
procedure GetConditionsVoiceTypes(Conditions: IInterface; lstVoice: TStringList);
var
  Condition, Elem, Quest: IInterface;
  ConditionFunction: string;
  i, Alias: integer;
begin
  AddDebug('GetConditionsVoiceTypes ' + FullPath(Conditions));

  for i := 0 to Pred(ElementCount(Conditions)) do begin
    Condition := ElementByIndex(Conditions, i);
    ConditionFunction := GetElementEditValues(Condition, 'CTDA\Function');
    // NPC
    if ConditionFunction = 'GetIsID' then begin
      InfoCONDITION := ConditionFunction;
      Elem := LinksTo(ElementByPath(Condition, 'CTDA\Referenceable Object'));
      GetRecordVoiceTypes(Elem, lstVoice);
    end
    // Voice type of FLST list of voice types
    else if ConditionFunction = 'GetIsVoiceType' then begin
      InfoCONDITION := ConditionFunction;
      Elem := LinksTo(ElementByPath(Condition, 'CTDA\Voice Type'));
      GetRecordVoiceTypes(Elem, lstVoice);
    end
    // Quest alias
    else if ConditionFunction = 'GetIsAliasRef' then begin
      InfoCONDITION := ConditionFunction;
      Alias := GetElementNativeValues(Condition, 'CTDA\Alias');
      Elem := ContainingMainRecord(Conditions);
      if Signature(Elem) = 'INFO' then begin
        Elem := LinksTo(ElementByName(Elem, 'Topic'));
        Quest := LinksTo(ElementByName(Elem, 'QNAM - Quest'));
      end
      else if Signature(Elem) = 'QUST' then
        Quest := Elem;

      GetAliasVoiceTypes(Quest, Alias, lstVoice);
    end;
  end;
end;

//============================================================================
// get a list of voice types for INFO record
procedure InfoVoiceTypes(Info: IInterface; lstVoice: TStringList);
var
  Elem, Dialogue: IInterface;
  Conditions: IInterface;
  Scene, Actions, Action: IInterface;
  i, j, Alias: integer;
  bAliasFound: Boolean;
begin
  if not Assigned(lstVoice) then
    Exit;

  lstVoice.Clear;
  
  // check Speaker
  Elem := ElementByName(Info, 'ANAM - Speaker');
  if Assigned(Elem) then begin
    Elem := LinksTo(Elem);
    GetRecordVoiceTypes(Elem, lstVoice);
    InfoSPEAKER := Name(Elem);
    Exit;
  end;
  
  // check Conditions
  if ElementExists(Info, 'Conditions') then
    GetConditionsVoiceTypes(ElementByName(Info, 'Conditions'), lstVoice);
  
  // check Scene aliases if above has no result
  if lstVoice.Count <> 0 then
    Exit;

  bAliasFound := False;
  Dialogue := LinksTo(ElementByName(Info, 'Topic'));

  if GetElementEditValues(Dialogue, 'DATA\Category') = 'Scene' then begin
    for i := Pred(ReferencedByCount(Dialogue)) downto 0 do begin
      Scene := ReferencedByIndex(Dialogue, i);
      if Signature(Scene) <> 'SCEN' then Continue;
      
      AddDebug('Searching for alias and dialog in scene ' + Name(Scene));
      Actions := ElementByName(Scene, 'Actions');
      for j := 0 to Pred(ElementCount(Actions)) do begin
        Action := ElementByIndex(Actions, j);
        if (GetElementEditValues(Action, 'ANAM - Type') = 'Dialogue') and
           (GetElementNativeValues(Action, 'DATA - Topic') = GetLoadOrderFormID(Dialogue))
        then begin
          Alias := GetElementNativeValues(Action, 'ALID - Actor ID');
          GetAliasVoiceTypes(LinksTo(ElementByName(Scene, 'PNAM - Quest')), Alias, lstVoice);
          bAliasFound := True;
          Break;
        end;
      end;
      if bAliasFound then
        Break;
    end;
  end;

  // if still can't determine voices, then use all of them
  if lstVoice.Count = 0 then begin
    AddDebug('!!! No voice types found, using all voices !!!');
    GetRecordVoiceTypes(RecordByFormID(FileByIndex(0), $0003B4A5, False), lstVoice); // DefaultNPCVoiceTypes [FLST:0003B4A5]
  end;
  
end;

//============================================================================
// adds child INFOs of DIAL record to list
procedure AddInfosFromDial(Dialogue: IInterface; lst: TStringList);
var
  i: integer;
  InfoGroup, Info: IInterface;
begin
  InfoGroup := ChildGroup(Dialogue);
  for i := 0 to Pred(ElementCount(InfoGroup)) do begin
    Info := ElementByIndex(InfoGroup, i);
    lst.AddObject(IntToHex(GetLoadOrderFormID(Info), 8), Info);
  end;
end;

//============================================================================
procedure ExportQuest(Quest: IInterface);
var
  i, j, r, v: integer;
  lstDial, lstInfo, lstVoice: TStringList;
  Dialogue, DialogueOvr: IInterface;
  InfoGroup, Info: IInterface;
  Responses, Response: IInterface;
  ResponseNumber: integer;
  VoiceFileName, VoiceFilePath: string;
begin
  lstDial := TStringList.Create;
  lstDial.Duplicates := dupIgnore;
  lstDial.Sorted := True;

  // scan for all DIAL references of quest
  for i := 0 to Pred(ReferencedByCount(Quest)) do begin
    Dialogue := ReferencedByIndex(Quest, i);
    if Signature(Dialogue) <> 'DIAL' then
      Continue;
    lstDial.AddObject(IntToHex(GetLoadOrderFormID(Dialogue), 8), Dialogue);
  end;

  // TODO: sort the list of quest topics
  
  lstInfo := TStringList.Create; lstInfo.Duplicates := dupIgnore; lstInfo.Sorted := True;
  lstVoice := TStringList.Create; lstVoice.Duplicates := dupIgnore; lstVoice.Sorted := True;

  // processing topics DIAL of quest
  for i := 0 to Pred(lstDial.Count) do begin
    Dialogue := ObjectToElement(lstDial.Objects[i]);
    if GetIsDeleted(Dialogue) then Continue;

    // building a list of all INFOs from all plugins that override quest topics
    // and from topic record masters afterwards
    lstInfo.Clear;
    for j := Pred(OverrideCount(Dialogue)) downto 0 do begin
      DialogueOvr := OverrideByIndex(Dialogue, j);
      AddInfosFromDial(DialogueOvr, lstInfo);
    end;
    AddInfosFromDial(Dialogue, lstInfo);
    
    // processing INFOs of quest topic
    for j := 0 to Pred(lstInfo.Count) do begin
      Info := ObjectToElement(lstInfo.Objects[j]);
      //if FormID(Info) <> $000CA13B then Continue;

      if GetIsDeleted(Info) then
        Continue;

      AddDebug(Name(Info));

      Responses := ElementByName(Info, 'Responses');
      if not Assigned(Responses) then
        Continue;

      // list of voice types for INFO
      InfoVoiceTypes(Info, lstVoice);
      AddDebug(Trim(lstVoice.Text));
      
      for r := 0 to Pred(ElementCount(Responses)) do begin
        Response := ElementByIndex(Responses, r);
        ResponseNumber := GetElementNativeValues(Response, 'TRDT\Response number');
        for v := 0 to Pred(lstVoice.Count) do begin
          VoiceFileName := InfoFileName(EditorID(Quest), EditorID(Dialogue), GetLoadOrderFormID(Info), ResponseNumber);
          VoiceFilePath := Format('Data\Sound\Voice\%s\%s\', [GetFileName(Quest), lstVoice[v]]);
          slExport.Add(Format('%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s', [
            GetFileName(Quest),
            Name(Quest),
            InfoNPCID,
            InfoSPEAKER,
            InfoRACEID,
            lstVoice[v],
            InfoCONDITION,
            EditorID(LinksTo(ElementByName(Dialogue, 'BNAM - Branch'))),
            GetElementEditValues(Dialogue, 'DATA\Category'),
            GetElementEditValues(Dialogue, 'SNAM'),
            GetElementEditValues(Dialogue, 'DATA\Subtype'),
            Trim(EditorID(Dialogue) + ' [DIAL:' + IntToHex(FormID(Dialogue), 8) + ']'),
            IntToStr(ResponseNumber),
            VoiceFileName,
            VoiceFilePath + VoiceFileName + '.xwm',
            GetElementEditValues(Dialogue, 'FULL'),
            GetElementEditValues(INFO, 'RNAM - Prompt'),
            GetElementEditValues(Response, 'NAM1 - Response Text'),
            GetElementEditValues(Response, 'TRDT\Emotion Type') + ' ' + GetElementEditValues(Response, 'TRDT\Emotion Value'),
            GetElementEditValues(Response, 'NAM2 - Script Notes')
          ]));
        end;
      end;
    end;
    
  end;
  
  lstInfo.Free;
  lstDial.Free;
  lstVoice.Free;
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
  
  if ContainerStates(GetFile(e)) and Round(IntPower(2, csRefsBuild)) = 0 then begin
    AddMessage('Skipping quest, references are not built for file ' + GetFileName(e));
    AddMessage('Use Right click \ Other \ Build Reference Info menu and try again.');
    Exit;
  end;

  ExportQuest(e);
end;

//============================================================================
function Finalize: integer;
var
  ExportFileName: string;
begin
  if slExport.Count <> 0 then begin
    ExportFileName := ScriptsPath + 'a.txt';
    AddMessage('Saving ' + ExportFileName);
    slExport.Insert(0, 'PLUGIN'#9'QUEST'#9'NPCID'#9'SPEAKER'#9'RACEID'#9'VOICE TYPE'#9'CONDITION'#9'BRANCH'#9'CATEGORY'#9'TYPE'#9'SUBTYPE'#9'TOPIC'#9'RESPONSE INDEX'#9'FILENAME'#9'FULLPATH'#9'TOPIC TEXT'#9'PROMPT'#9'RESPONSE TEXT'#9'EMOTION'#9'SCRIPT NOTES');
    slExport.SaveToFile(ExportFileName);
  end;
  
  slExport.Free;
end;

end.
