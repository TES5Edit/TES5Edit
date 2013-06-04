{
  从 OCO 插件创建脸部列表，并根据种族和性别随机分配到所选NPC记录。 
  未知种族（OCO 中不存在的）NPC将被跳过。
  表单序号与 OCO 相同的 NPC 则直接复制 OCO 插件的脸部数据。
  发型与眼睛（和其他）不会被修改。
}
unit UserScript;

const
  OCOFileName = 'Oblivion_Character_Overhaul.esp';

var
  slRace: TStringList;
  lOCOForms: TList;
  arNPC: array [0..10000] of IInterface;
  npccount: integer;

//========================================================================================
function IsOCOnizedPlugin(aFileName: string): boolean;
begin
  // add checks for plugins with correct OCO faces here using "or"
  // the more the merrier (bigger faces variety)
  Result := SameText(aFileName, OCOFileName); // or SameText(aFileName, 'SomeOtherMod.esp');
end;

//========================================================================================
// build a list of npc records with correct OCO faces
procedure CollectOCOnizedNPC;
var
  lst: TList;
  i, j, idx: integer;
  race: string;
  plugin, npcs, npc: IInterface;
begin
  npccount := 0;
  // iterate over all loaded mods in reverse order
  // so overriding records come first
  for i := FileCount - 1 downto 0 do begin
    plugin := FileByIndex(i);
    // check plugin name
    if IsOCOnizedPlugin(GetFileName(plugin)) then begin
      // get NPC_ group from plugin
      npcs := GroupBySignature(plugin, 'NPC_');
      // iterate over all records
      for j := 0 to ElementCount(npcs) - 1 do begin
        npc := ElementByIndex(npcs, j);
        // build unique race + gender key string
        race := GetElementEditValues(npc, 'RNAM');
        if race = '' then Continue;
        if GetElementNativeValues(npc, 'ACBS\标志') and 1 > 0 then race := race + ' Female'
          else race := race + ' Male';
        arNPC[npccount] := npc;
        // check if key string already exists, or add a new one
        idx := slRace.IndexOf(race);
        if idx = -1 then begin
          // list holding indexes if NPC records in array of race + gender
          lst := TList.Create;
          slRace.AddObject(race, lst);
        end else
          lst := TList(slRace.Objects[idx]);
        // add npc to array
        lst.Add(TObject(npccount));
        // add FormID of npc record for a quick lookup later
        lOCOForms.Add(TObject(GetLoadOrderFormID(npc)));
        // increate array counter
        Inc(npccount);
      end;
    end;
  end;
end;

//========================================================================================
function Initialize: integer;
begin
  // lookup list to races and genders
  slRace := TStringList.Create;
  // lookup list of FormIDs with OCO faces
  lOCOForms := TList.Create;
  CollectOCOnizedNPC;
  if npccount = 0 then begin
    MessageDlg(OCOFileName + ' is not loaded.', mtInformation, [mbOk], 0);
    Finalize;
    Result := 1;
    Exit;
  end;
  // initialize pseudo random numbers generator with the current time
  Randomize;
end;

//========================================================================================
function Process(e: IInterface): integer;
var
  i, idx: integer;
  race: string;
  lst: TList;
begin
  // skip anything but NPC_ records
  if Signature(e) <> 'NPC_' then
    Exit;

  // don't patch records in already OCOnized plugins
  if IsOCOnizedPlugin(GetFileName(e)) then
    Exit;
  
  // check if npc record has the same FormID as one of the OCOnized records
  idx := lOCOForms.IndexOf(TObject(GetLoadOrderFormID(e)));
  // if not, select random OCOnized NPC of the same race and gender
  if idx = -1 then begin
    race := GetElementEditValues(e, 'RNAM');
    if race = '' then
      Exit;
      
    if GetElementNativeValues(e, 'ACBS\标志') and 1 > 0 then race := race + ' Female'
      else race := race + ' Male';

    idx := slRace.IndexOf(race);
    // skip unknown races
    if idx = -1 then
      Exit;
    
    lst := TList(slRace.Objects[idx]);
    idx := integer(lst[Random(lst.Count)]);
  end;

  // copy facegen data
  ElementAssign(ElementByPath(e, '脸部生成数据'), LowInteger, ElementByPath(arNPC[idx], '脸部生成数据'), False);
  ElementAssign(ElementByPath(e, 'FNAM'), LowInteger, ElementByPath(arNPC[idx], 'FNAM'), False); // just in case
end;

//========================================================================================
function Finalize: integer;
begin
  // cleanup
  slRace.Free;
  lOCOForms.Free;
end;

end.
