{
  Export selected quest dialogues
}
unit ExportDialogue;

var
  slDial, slInfo: TStringList;
  CurrentQuest: IInterface; // for optimization to avoid lookups

//============================================================================
function Initialize: integer;
begin
  //AddMessage(InfoFileName('DLC1DialogueHunterBase', '', $0004BCB7, 1));
  //Result := 1; Exit;
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
procedure GetRecordVoiceTypes(e: IInterface; lst: TStringList);
var
  s: string;
  i: integer;
  ent, ents: IInterface;
begin
  e := HighestOverrideOrSelf(e);

  s := Signature(e);
  if s = 'REFR' then
    e := HighestOverrideOrSelf(BaseObject(e));
    
  s := Signature(e);
  // Voice type record
  if s = 'VTYP' then begin
    lst.AddObject('', e);
  end
  // NPC record
  else if s = 'NPC_' then begin
    ent := HighestOverrideOrSelf(LinksTo(ElementByName(e, 'VTCK - Voice')));
    if Signature(ent) = 'VTYP' then lst.AddObject('', ent);
  end
  // Talking activator record
  else if s = 'TACT' then begin
    ent := HighestOverrideOrSelf(LinksTo(ElementByName(e, 'VNAM - Voice Type')));
    if Signature(ent) = 'VTYP' then lst.AddObject('', ent);
  end
  // Form List record
  else if s = 'FLST' then begin
    ents := ElementByName(e, 'FormIDs');
    for i := 0 to Pred(ElementCount(ents)) do begin
      ent := LinksTo(ElementByIndex(ents, i));
      if Signature(ent) = 'VTYP' then lst.AddObject('', ent);
    end;
  end;
end;

//============================================================================
// get voice types from quest alias
procedure GetAliasVoiceTypes(Quest: IInterface; aAlias: integer; lstVoice: TStringList);
var
  Aliases, Alias: IInterface;
  i: integer;
begin
  Quest := HighestOverrideOrSelf(Quest);
  Aliases := ElementByName(Quest, 'Aliases');
  for i := 0 to Pred(ElementCount(Aliases)) do begin
    Alias := ElementByIndex(Aliases, i);
    if GetElementNativeValues(Alias, 'ALID - Reference Alias ID') <> aAlias then
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
        );
    Break;
  end;
end;

//============================================================================
// get a list of voice types for INFO record
procedure InfoVoiceTypes(Info: IInterface; lstVoice: TStringList);
var
  el, npc, VoiceType, Dialogue: IInterface;
  Condition, Conditions: IInterface;
  Scene, Actions, Action: IInterface;
  i, j, Alias: integer;
  ConditionFunction: string;
  bAliasFound: Boolean;
begin
  if not Assigned(lst) then
    Exit;
  
  // first check for Speaker
  el := ElementByName(Info, 'ANAM - Speaker');
  if Assigned(el) then begin
    npc := LinksTo(el);
    GetRecordVoiceTypes(npc, lstVoice);
    Exit;
  end;
  
  // check conditions
  Conditions := ElementByName(e, 'Conditions');
  for i := 0 to Pred(ElementCount(Conditions)) do begin
    Condition := ElementByIndex(Conditions, i);
    ConditionFunction := GetElementEditValues(Condition, 'CTDA\Function');
    // NPC
    if ConditionFunction = 'GetIsID' then begin
      npc := LinksTo(ElementByPath(Condition, 'CTDA\Referenceable Object'));
      GetRecordVoiceTypes(npc, lstVoice);
      Break;
    end
    // Voice type of FLST list of voice types
    else if ConditionFunction = 'GetIsVoiceType' then begin
      el := LinksTo(ElementByPath(Condition, 'CTDA\Voice Type'));
      GetRecordVoiceTypes(el, lstVoice);
      Break;
    end
    // Quest alias
    else if ConditionFunction = 'GetIsAliasRef' then begin
      Alias := GetElementNativeValues(Condition, 'CTDA\Alias');
      GetAliasVoiceTypes(CurrentQuest, Alias, lstVoice);
      Break;
    end
  end;
  
  // check scene aliases if above has no result
  if lstVoice.Count <> 0 then
    Exit;
  bAliasFound := False;
  Dialogue := LinksTo(ElementByName(Info, 'Topic'));

  if GetElementEditValues(Dialogue, 'DATA\Category') = 'Scene' then begin

    for i := Pred(ReferencedByCount(Dialogue)) downto 0 do begin
      Scene := ReferencedByIndex(Dialogue, i);
      if Signature(Scene) <> 'SCEN' then Continue;
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
  i, j, k: integer;
  lstDial, lstInfo: TStringList;
  Dialogue, DialogueOvr: IInterface;
  InfoGroup, Info: IInterface;
  Responses, Response: IInterface;
  ResponseNumber: integer;
begin
  CurrentQuest := Quest;
  
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
  
  lstInfo := TStringList.Create;
  lstInfo.Duplicates := dupIgnore;
  lstInfo.Sorted := True;

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
    
    // processing responses INFOs of quest topic
    for i := 0 to Pred(lstInfo.Count) do begin
      Info := ObjectToElement(lstInfo.Objects[i]);
      if GetIsDeleted(Info) then Continue;
      //AddMessage(Name(Info));
      Responses := ElementByName(Info, 'Responses');
      for j := 0 to Pred(ElementCount(Responses)) do begin
        Response := ElementByIndex(Responses, j);
        ResponseNumber := GetElementNativeValues(Response, 'TRDT\Response number');
        
      end;
    end;
    
  end;
  
  lstInfo.Free;
  lstDial.Free;
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
  ExportQuest(e);
  
end;

//============================================================================
function Finalize: integer;
begin

end;


end.
