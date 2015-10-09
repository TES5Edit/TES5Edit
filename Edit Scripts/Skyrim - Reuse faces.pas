{
  Collect facegen data from all loaded plugins and then randomly
  reassign faces on selected NPC_ records.
}
unit ReuseFaces;

var
  slRaces: TStringList;
  lstTemplates: TList;

//============================================================================
function Initialize: integer;
var
  female, race, i, j: integer;
  f, npcs, npc: IInterface;
  lst: TList;
begin
  slRaces := TStringList.Create;
  slRaces.Add('DarkElfRace');
  slRaces.Add('ArgonianRace');
  slRaces.Add('BretonRace');
  slRaces.Add('HighElfRace');
  slRaces.Add('ImperialRace');
  slRaces.Add('KhajiitRace');
  slRaces.Add('NordRace');
  slRaces.Add('OrcRace');
  slRaces.Add('RedguardRace');
  slRaces.Add('WoodElfRace');
  slRaces.Add('NordRaceVampire');
  
  lstTemplates := TList.Create;
  for i := 1 to slRaces.Count do begin
    lstTemplates.Add(TList.Create); // males
    lstTemplates.Add(TList.Create); // females
  end;
  
  AddMessage('Building list of templates');
  for i := 0 to Pred(FileCount) do begin
    f := FileByIndex(i);
    if not (SameText(GetFileName(f), 'skyrim.esm') or SameText(GetFileName(f), 'dragonborn.esm')) then
      Continue;
    AddMessage('Scanning ' + GetFileName(f));
    npcs := GroupBySignature(f, 'NPC_');
    for j := 0 to Pred(ElementCount(npcs)) do begin
      npc := ElementByIndex(npcs, j);
      // only not overridden records count to avoid additions from overrides
      if not IsMaster(npc) then Continue;
      // skip unknown races
      race := slRaces.IndexOf(EditorID(LinksTo(ElementBySignature(npc, 'RNAM'))));
      if race = -1 then Continue;
      //AddMessage(slRaces[race]);
      // NPC must have all those entries to be a template
      if not ElementExists(npc, 'Head Parts') then Continue;
      if not ElementExists(npc, 'QNAM - Texture lighting') then Continue;
      if not ElementExists(npc, 'NAM9 - Face morph') then Continue;
      if not ElementExists(npc, 'NAMA - Face parts') then Continue;
      if not ElementExists(npc, 'Tint Layers') then Continue;
      // adding to list
      female := GetElementNativeValues(npc, 'ACBS\Flags') and 1;
      lst := TList(lstTemplates[race*2 + female]);
      lst.Add(npc);
    end;
  end;
  
  // report the number of templates
  AddMessage('Available templates');
  for i := 0 to Pred(slRaces.Count) do begin
    AddMessage(Format('    %s   Males: %d   Females: %d', [
      slRaces[i],
      TList(lstTemplates[i*2]).Count,
      TList(lstTemplates[i*2+1]).Count
    ]));
  end;
  
  Randomize;
end;

//============================================================================
function Process(e: IInterface): integer;
var
  i, race, female: integer;
  m: float;
  npc, morphs, morph: IInterface;
  lst: TList;
  s: string;
begin
  if Signature(e) <> 'NPC_' then
    Exit;
  
  race := slRaces.IndexOf(EditorID(LinksTo(ElementBySignature(e, 'RNAM'))));
  if race = -1 then
    Exit;
  
  female := GetElementNativeValues(e, 'ACBS\Flags') and 1;
  lst := TList(lstTemplates[race*2 + female]);
  if lst.Count = 0 then begin
    AddMessage('No template for ' + Name(e));
    Exit;
  end;
  npc := ObjectToElement(lst[Random(lst.Count)]);
  
  AddMessage('Generating face for ' + Name(e) + ' from ' + Name(npc));
  
  s := 'Head Parts';
  Add(e, s, True);
  ElementAssign(ElementByPath(e, s), LowInteger, ElementByPath(npc, s), False);
  
  s := 'HCLF';
  if ElementExists(npc, s) then begin
    if GetElementNativeValues(npc, s) shr 24 = 0 then begin
      Add(e, s, True);
      ElementAssign(ElementByPath(e, s), LowInteger, ElementByPath(npc, s), False);
    end;
  end else
    RemoveElement(e, s);
  
  s := 'FTST';
  if ElementExists(npc, s) then begin
    if GetElementNativeValues(npc, s) shr 24 = 0 then begin
      Add(e, s, True);
      ElementAssign(ElementByPath(e, s), LowInteger, ElementByPath(npc, s), False);
    end;
  end else
    RemoveElement(e, s);

  s := 'QNAM';
  Add(e, s, True);
  ElementAssign(ElementByPath(e, s), LowInteger, ElementByPath(npc, s), False);

  s := 'NAM9';
  Add(e, s, True);
  ElementAssign(ElementByPath(e, s), LowInteger, ElementByPath(npc, s), False);
  // slightly adjust face morphs
  morphs := ElementByPath(e, s);
  for i := 0 to ElementCount(morphs) - 2 do begin
    morph := ElementByIndex(morphs, i);
    m := GetNativeValue(morph);
    m := m + random(11)/100 - 0.05;
    if m > 1 then m := 1
      else if m < -1 then m := -1;
    SetNativeValue(morph, m);
  end;
  
  s := 'NAMA';
  Add(e, s, True);
  ElementAssign(ElementByPath(e, s), LowInteger, ElementByPath(npc, s), False);

  s := 'Tint Layers';
  Add(e, s, True);
  ElementAssign(ElementByPath(e, s), LowInteger, ElementByPath(npc, s), False);
end;

//============================================================================
function Finalize: integer;
var
  i: integer;
begin
  slRaces.Free;
  for i := 0 to lstTemplates.Count - 1 do
    TList(lstTemplates[i]).Free;
  lstTemplates.Free;
end;

end.
