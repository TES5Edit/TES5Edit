{
  List records and elements that require selected master files.
  Can be used to deal with references before using "Clean masters" function.
}
unit ReportMasters;

var
  slCheckMasters, sl: TStringList;

function Initialize: integer;
begin
  slCheckMasters := TStringList.Create;
  sl := TStringList.Create;
  sl.Duplicates := dupIgnore;
  sl.Sorted := True;
end;

function HasCheckMasters(sl: TStrings): Boolean;
var
  i, j: integer;
begin
  for i := 0 to Pred(sl.Count) do
    for j := 0 to Pred(slCheckMasters.Count) do
      if sl[i] = slCheckMasters[j] then begin
        Result := True;
        Exit;
      end;
end;

function Process(e: IInterface): integer;
var
  frm: TForm;
  clb: TCheckListBox;
  i, j: integer;
  el: IInterface;
begin
  if slCheckMasters.Count = 0 then begin
    frm := frmFileSelect;
    try
      frm.Caption := 'Masters';
      clb := TCheckListBox(frm.FindComponent('CheckListBox1'));
      
      for i := 0 to Pred(MasterCount(GetFile(e))) do
        clb.Items.Add(GetFileName(MasterByIndex(GetFile(e), i)));
      // add original file itself
      //clb.Items.Add(GetFileName(e));
      
      if frm.ShowModal <> mrOk then begin
        Finalize;
        Result := 1;
        Exit;
      end;
      
      for i := 0 to Pred(clb.Items.Count) do
        if clb.Checked[i] then
          slCheckMasters.Add(clb.Items[i]);
      
      if slCheckMasters.Count = 0 then begin
        Finalize;
        Result := 1;
        Exit;
      end;
      AddMessage('Selected masters are required by the following records and elements:');
    finally
      frm.Free;
    end;
  end;

  ReportRequiredMasters(e, sl, False, False);
  if HasCheckMasters(sl) then
    AddMessage(Name(e));
  sl.Clear;

  if (Name(ElementByIndex(e, 0)) = 'Cell') or (Name(ElementByIndex(e, 0)) = 'Topic') then j := 2 else j := 1;
  for i := j to Pred(ElementCount(e)) do begin
    el := ElementByIndex(e, i);
    ReportRequiredMasters(el, sl, False, True);
    if HasCheckMasters(sl) then
      AddMessage(Name(e) + ' \ ' + Name(el));
    sl.Clear;
  end;
end;

function Finalize: integer;
begin
  slCheckMasters.Free;
  sl.Free;
end;

end.
