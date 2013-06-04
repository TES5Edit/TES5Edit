{
  检测所选记录（或者整个插件）所需要的 BASH 标签。
  只需要加载有疑问或者所依赖的插件（与清理插件一样）。
  标签信息：http://tesfans.org/guides/wrye bash/docs/Wrye Bash Advanced Readme.html#patch-tags
  当前支持的标签：
    Delev, Relev
    Factions
    Invent
    Names
  
  版本：1.0
}
unit BashTagsDetector;

var
  slTags: TStringList;
  
function Initialize: integer;
begin
  Result := 0;
  slTags := TStringList.Create; // list of tags
  slTags.Delimiter := ','; // separated by comma
end;

// tag already exists?
function TagExists(t: string): boolean;
begin
  Result := (slTags.IndexOf(t) <> -1);
end;

// add tag
procedure AddTag(t: string);
begin
  if not TagExists(t) then
    slTags.Add(t);
end;

// helper function: get element from list by some value
function GetElementByValue(el: IInterface; smth, somevalue: string): IInterface;
var
  i: integer;
  entry: IInterface;
begin
  Result := nil;
  for i := 0 to ElementCount(el) - 1 do begin
    entry := ElementByIndex(el, i);
    if GetElementEditValues(entry, smth) = somevalue then begin
      Result := entry;
      Exit;
    end;
  end;
end;

{==================================================================}
// Delev, Relev
function CheckDelevRelev(e, m: IInterface): integer;
var
  i, matched: integer;
  entries, entriesmaster: IInterface; // leveled list entries
  ent, entm: IInterface; // leveled list entry
  coed, coedm: IInterface; // extra data
  s1, s2: string; // sortkeys for extra data, sortkey is a compact text representation of element's values
begin
  Result := 0;

  // nothing to do if already tagged
  if TagExists('Delev') and TagExists('Relev') then
    Exit;
  
  // get 等级列表记录
  entries := ElementByName(e, '等级列表记录');
  entriesmaster := ElementByName(m, '等级列表记录');
  
  if not Assigned(entries) or not Assigned(entriesmaster) then
    Exit;
  
  // count matched on reference entries
  matched := 0;
  // iterate through all entries
  for i := 0 to ElementCount(entries) - 1 do begin
    ent := ElementByIndex(entries, i);
    // find the same entry in master
    entm := GetElementByValue(entriesmaster, 'LVLO\衍生', GetElementEditValues(ent, 'LVLO\衍生'));
    if Assigned(entm) then begin
      Inc(matched);
      // Relev check for changed level, count, extra data
      coed := ElementByName(ent, '额外数据');
      coedm := ElementByName(entm, 'COED - 额外数据');
      if Assigned(coed) then s1 := SortKey(coed, True) else s1 := '';
      if Assigned(coedm) then s2 := SortKey(coedm, True) else s2 := '';
      if (GetElementNativeValues(ent, 'LVLO\等级') <> GetElementNativeValues(entm, 'LVLO\等级')) or
         (GetElementNativeValues(ent, 'LVLO\数量') <> GetElementNativeValues(entm, 'LVLO\数量')) or
         (s1 <> s2) then
        AddTag('Relev');
    end;
  end;
  
  // if number of matched entries less than in master list
  if matched < ElementCount(entriesmaster) then
    AddTag('Delev');
end;

{==================================================================}
// Invent
function CheckInvent(e, m: IInterface): integer;
var
  items, itemsmaster: IInterface;
begin
  Result := 0;
  
  if TagExists('Invent') then
    Exit;

  items := ElementByName(e, '物品');
  itemsmaster := ElementByName(m, '物品');
  
  if Assigned(items) <> Assigned(itemsmaster) then begin
    AddTag('Invent');
    Exit;
  end;
  
  if not Assigned(items) then
    Exit;
  
  // Items are sorted, so we don't need to compare by individual item
  // SortKey combines all the items data
  if SortKey(items, True) <> SortKey(itemsmaster, True) then
    AddTag('Invent');
end;

{==================================================================}
// Factions
function CheckFactions(e, m: IInterface): integer;
var
  f, fm: IInterface;
  ent, entmaster: IInterface;
  i: integer;
begin
  Result := 0;
  
  if TagExists('Factions') then
    Exit;

  f := ElementByName(e, '派系');
  fm := ElementByName(m, '派系');
  
  if Assigned(f) <> Assigned(fm) then begin
    AddTag('Factions');
    Exit;
  end;

  if not Assigned(f) then
    Exit;
  
  if ElementCount(f) <> ElementCount(fm) then begin
    AddTag('Factions');
    Exit;
  end;
  
  for i := 0 to ElementCount(f) - 1 do begin
    ent := ElementByIndex(f, i);
    entmaster := ElementByIndex(fm, i);
    if (GetElementEditValues(ent, '派系') <> GetElementEditValues(entmaster, '派系')) or
       (GetElementEditValues(ent, '等级') <> GetElementEditValues(entmaster, '等级')) then
      AddTag('Factions');
  end;
end;

{==================================================================}
// Names
function CheckNames(e, m: IInterface): integer;
begin
  Result := 0;
  
  if TagExists('Names') then
    Exit;

  if GetElementEditValues(e, 'FULL - 名称') <> GetElementEditValues(m, 'FULL - 名称') then
    AddTag('Names');
end;

{==================================================================}
function Process(e: IInterface): integer;
var
  m: IInterface; // master record
  sig: string;
begin
  Result := 0;
  
  // get master record
  m := Master(e);
  
  // no master - nothing to detect
  if not Assigned(m) then
    Exit;
  
  // debug messages
  //AddMessage(FullPath(e));
  //AddMessage(FullPath(m));
  //AddMessage('overridecount: ' + IntToStr(OverrideCount(m)));
  
  // if record overrides several masters, then get the last one
  if OverrideCount(m) > 1 then
    m := OverrideByIndex(m, OverrideCount(m) - 2);

  // debug messages
  //AddMessage(FullPath(m));

  sig := Signature(e);
  
  if (sig = 'LVLI') or (sig = 'LVLC') or (sig = 'LVLN') or (sig = 'LVSP') then
    Result := CheckDelevRelev(e, m);
  if (sig = 'NPC_') or (sig = 'CREA') or (sig = 'CONT') then
    Result := CheckInvent(e, m);
  if (sig = 'NPC_') or (sig = 'CREA') then
    Result := CheckFactions(e, m);
  if (sig <> 'CELL') and (sig <> 'REFR') and (sig <> 'ACHR') and (sig <> 'NAVM') then
    Result := CheckNames(e, m);
    
end;

function Finalize: integer;
begin
  Result := 0;
  
  if not Assigned(slTags) then
    Exit;
  
  slTags.Sort;
  
  if slTags.Count > 0 then
    AddMessage(Format('{{BASH:%s}}', [slTags.DelimitedText]))
  else
    AddMessage('无建议标签');
  
  slTags.Free;
end;



end.
