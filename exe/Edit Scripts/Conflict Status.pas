{
  Generate report of conflicts between selected plugins
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
    AddMessage(StringOfChar(' ', 4) + 'Overrides (wins conflict):');
    for i := 0 to Pred(slWin.Count) do
      AddMessage(StringOfChar(' ', 8) + slWin[i]);
  end;
  if slLose.Count > 0 then begin
    AddMessage(StringOfChar(' ', 4) + 'Overridden by (loses conflict):');
    for i := 0 to Pred(slLose.Count) do
      AddMessage(StringOfChar(' ', 8) + slLose[i]);
  end;
  if slWarn.Count > 0 then
    AddMessage(Trim(slWarn.Text));
end;
  
function Initialize: integer;
begin
  if not FilterApplied then begin
    MessageDlg('You need to "Apply filter for Cleaning" for this script to work properly', mtInformation, [mbOk], 0);
    Result := 1;
    Exit;
  end;
  slWin := TStringList.Create;
  slWin.Sorted := True;
  slWin.Duplicates := dupIgnore;
  slLose := TStringList.Create;
  slLose.Sorted := True;
  slLose.Duplicates := dupIgnore;
  slWarn := TStringList.Create;
  AddMessage('Building conflicts status report for selected plugins/records...');
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
            slWarn.Add('Warning: Deleted record ' + Name(ovr) + ' is overridden by later loaded plugins which can lead to a crash in game!');
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