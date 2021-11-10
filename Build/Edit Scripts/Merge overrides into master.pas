{
  Copy changed data from overrides into the master records or previous overrides.
  If overrides reference new records, then inject and copy them into the master first.
  
  Don't select anything (just click OK) in plugin's selection window to always merge
  into the master records only.
}
unit MergeOverridesIntoMaster;

var
  sFiles: string;

//==================================================================================
// Merge changes from record e into m
procedure MergeInto(e, m: IInterface);
var
  slElems: TStringList;
  e1, e2: IInterface;
  i, c: integer;
  s: string;
begin
  if not IsEditable(m) then
    Exit;
  
  slElems := TStringList.Create;
  
  // iterate over all elements in override
  for i := 0 to Pred(ElementCount(e)) do begin
    e2 := ElementByIndex(e, i);
    s := Name(e2);
    // build a list of all elements in override
    slElems.Add(s);

    // special treatment for record header
    if s = 'Record Header' then begin
      // copy flags
      SetElementNativeValues(m, 'Record Header\Record Flags', GetElementNativeValues(e, 'Record Header\Record Flags'));
      Continue;
    end;
    
    // get the same element from master
    e1 := ElementByName(m, s);

    // element exists in override but not in master, add and copy it
    if not Assigned(e1) then begin
      if Pos(' - ', s) = 5 then s := Copy(s, 1, 4); // leave only subrecord's signature if present
      e1 := Add(m, s, True);
      ElementAssign(e1, LowInteger, e2, False);
      Continue;
    end;

    // element exists in both master and override, detect conflict
    c := ConflictAllForElements(e1, e2, False, IsInjected(m));
    // copy it into master if data is different
    if c >= caConflictBenign then
      ElementAssign(e1, LowInteger, e2, False);
  end;

  // remove elements from master that don't exist in override
  for i := Pred(ElementCount(m)) downto 0 do begin
    e1 := ElementByIndex(m, i);
    if slElems.IndexOf(Name(e1)) = -1 then
      Remove(e1);
  end;
  
  slElems.Free;
end;  

//==================================================================================
function Process(e: IInterface): integer;
var
  frm: TForm;
  clb: TCheckListBox;
  m, ovr: IInterface;
  i: integer;
begin
  m := Master(e);
  
  // this is not an override, skip
  if not Assigned(m) then
    Exit;

  // plugins selection window if files are not selected yet
  if sFiles = '' then begin
    frm := frmFileSelect;
    try
      frm.Caption := 'Select plugin(s) to merge into';
      frm.Width := 420;
      clb := TCheckListBox(frm.FindComponent('CheckListBox1'));

      // add files loaded before the current plugin
      i := 1;
      while not SameText(GetFileName(e), GetFileName(FileByIndex(i))) do begin
        clb.Items.Add(GetFileName(FileByIndex(i)));
        Inc(i);
      end;

      // create list of checked files in a string
      if frm.ShowModal = mrOk then
        for i := 0 to Pred(clb.Items.Count) do
          if clb.Checked[i] then
            sFiles := sFiles + '[' + clb.Items[i] + ']';

      // if nothing is checked, use * to signal for merging into master records only
      if sFiles = '' then
        sFiles := '*';

    finally
      frm.Free;
    end;
  end;

  if sFiles = '*' then
    // nothing selected - merge into master only
    MergeInto(e, m)
  else
    // merge into selected files
    for i := -1 to Pred(OverrideCount(m)) do begin
      if i = -1 then
        ovr := m
      else
        ovr := OverrideByIndex(m, i);
      if Pos(GetFileName(ovr), sFiles) > 0 then
        MergeInto(e, ovr);
    end;
end;


end.
