{
  生成所选插件的冲突报告。
}
unit UserScript;

var
  CurrentPlugin: string;
  slWin, slLose, slWarn: TStringList;

procedure ReportPlugin;
var
  i: integer;
begin
  if CurrentPlugin = '' then Exit;
  AddMessage(StringOfChar('-', 16) + ' ' + CurrentPlugin + ' ' + StringOfChar('-', 16));
  if slWin.Count > 0 then begin
    AddMessage(StringOfChar(' ', 4) + '覆盖 (冲突赢方):');
    for i := 0 to Pred(slWin.Count) do
      AddMessage(StringOfChar(' ', 8) + slWin[i]);
  end;
  if slLose.Count > 0 then begin
    AddMessage(StringOfChar(' ', 4) + '被覆盖 (冲突败方):');
    for i := 0 to Pred(slLose.Count) do
      AddMessage(StringOfChar(' ', 8) + slLose[i]);
  end;
  if slWarn.Count > 0 then
    AddMessage(Trim(slWarn.Text));
end;
  
function Initialize: integer;
begin
  if not FilterApplied then begin
    MessageDlg('您需要运行 “应用清理筛选” 才能正常使用此脚本。', mtInformation, [mbOk], 0);
    Result := 1;
  end;
  slWin := TStringList.Create;
  slWin.Sorted := True;
  slWin.Duplicates := dupIgnore;
  slLose := TStringList.Create;
  slLose.Sorted := True;
  slLose.Duplicates := dupIgnore;
  slWarn := TStringList.Create;
  AddMessage('正在创建所选插件/记录的冲突状态报告...');
end;

function Process(e: IInterface): integer;
var
  i, lo1, lo2, ovc: integer;
  s: string;
  m, ovr: IInterface;
begin
  lo1 := GetLoadOrder(GetFile(e));
  if lo1 = 0 then Exit;

  if CurrentPlugin <> Name(GetFile(e)) then begin
    ReportPlugin;
    CurrentPlugin := Name(GetFile(e));
    slWin.Clear;
    slLose.Clear;
    slWarn.Clear;
  end;
  
  if ConflictAllForNode(e) < caOverride then
    Exit;
  
  m := MasterOrSelf(e);
  ovc := OverrideCount(m);
  for i := 0 to Pred(ovc) do begin
    ovr := OverrideByIndex(m, i);
    s := Name(GetFile(ovr));
    lo2 := GetLoadOrder(GetFile(ovr));
    if lo2 <> 0 then
      if lo2 > lo1 then slLose.Add(s) else
        if lo2 < lo1 then slWin.Add(s) else
          if (lo2 = lo1) and (i < Pred(ovc)) and GetIsDeleted(ovr) then
            slWarn.Add('警告：已删除的记录 ' + Name(ovr) + ' 被后续加载的插件所覆盖，这会导致游戏跳出！');
  end;
end;

function Finalize: integer;
begin
  ReportPlugin;
  slWin.Free;
  slLose.Free;
  slWarn.Free;
end;

end.