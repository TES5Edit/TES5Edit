{
  检查所选记录中未使用的脚本并生成报告。
  同时检查脚本是否存在于 BSAs 或者游戏 Data\Scripts 目录。
}
unit UserScript;

var
  slScripts: TStringList;

function Initialize: integer;
begin
  slScripts := TStringList.Create;
end;

function Process(e: IInterface): integer;
var
  s: string;
  i: integer;
  sl: TStringList;
begin
  if ElementType(e) = etMainRecord then
    if ElementExists(e, 'VMAD') then
      Process(ElementBySignature(e, 'VMAD'))
    else
      Exit;

  if Name(e) = '脚本' then begin
    s := GetEditValue(e);
    i := slScripts.IndexOf(s); 
    if i = -1 then begin
      // new script
      sl := TStringList.Create;
      sl.Sorted := True;
      sl.Duplicates := dupIgnore;
      sl.Add(FullPath(e));
      slScripts.AddObject(s, sl);
    end else
      // existing script
      TStringList(slScripts.Objects[i]).Add(FullPath(e));
  end;
  
  // recursively process all child elements
  for i := 0 to ElementCount(e) - 1 do
    Process(ElementByIndex(e, i));
end;

function Finalize: integer;
var
  i: integer;
  slRep: TStringList;
  s, fname: string;
begin
  if slScripts.Count > 0 then begin
    slRep := TStringList.Create;
    slScripts.Sort;
    for i := 0 to slScripts.Count - 1 do begin
      s := slScripts[i];
      if not ResourceExists('Scripts\' + s + '.pex') then
        s := s + ' - MISSING!';
      slRep.Add(s);
      slRep.Add(StringOfChar('-', 60));
      slRep.Add(TStringList(slScripts.Objects[i]).Text);
    end;
    
    fname := ProgramPath + 'Edit Scripts\Scripts report.txt';
    AddMessage('Saving report to ' + fname);
    slRep.SaveToFile(fname);
    slRep.Free;
  end else
    AddMessage('No scripts found.');
  
  for i := 0 to slScripts.Count - 1 do
    TStringList(slScripts.Objects[i]).Free;
  slScripts.Free;
end;

end.
