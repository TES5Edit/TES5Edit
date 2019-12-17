{
  Find duplicate dialogue responses and create shared INFOs for them.
  Quest and Topic to collect created shared INFOs can be selected from existing shared Topics, or a new Topic can be created.
  
  Apply to a whole plugin or selected topics.
  Use Del key to remove lines you don't want to be shared in the list.
  
  Supported games: Skyrim
}
unit CreateSharedInfos;

var
  slINFOs: TStringList;
  Plugin: IInterface;
  frm: TForm;
  lbl: TLabel;
  cmbQuest, cmbTopic: TComboBox;
  lvLines: TListView;
  btnOk, btnCancel: TButton;

//===========================================================================
procedure DoCreateSharedInfos(quest, dial: IInterface);
var
  i, j: integer;
  list: TList;
  sharedinfo, info: IInterface;
begin
  if slINFOs.Count = 0 then
    Exit;
  
  AddMessage('Creating shared responses, please wait...');
  
  // create new shared topic DIAL if not provided
  if not Assigned(dial) then begin
    dial := Add(GroupBySignature(Plugin, 'DIAL'), 'DIAL', True);
    SetElementEditValues(dial, 'EDID', 'SharedInfosTopic');
    SetElementEditValues(dial, 'QNAM', Name(quest));
    SetElementEditValues(dial, 'PNAM', '50');
    SetElementEditValues(dial, 'SNAM', 'IDAT');
    Add(dial, 'DATA', True);
    SetElementEditValues(dial, 'DATA\Category', 'Miscellaneous');
    SetElementEditValues(dial, 'DATA\Subtype', 'SharedInfo');
  end;
  
  // process duplicate responses
  for i := 0 to Pred(slINFOs.Count) do begin
    list := TList(slINFOs.Objects[i]);
    sharedinfo := nil;
    for j := 0 to Pred(list.Count) do begin
      info := ObjectToElement(list[j]);
      // create shared INFO
      if not Assigned(sharedinfo) then begin
        sharedinfo := Add(dial, 'INFO', True);
        Add(sharedinfo, 'ENAM', True);
        Add(sharedinfo, 'CNAM', True);
        Add(sharedinfo, 'Responses', True);
        ElementAssign(ElementByPath(sharedinfo, 'Responses'), LowInteger, ElementByPath(info, 'Responses'), False);
      end;
      // link response INFO to the shared one
      SetElementEditValues(info, 'DNAM', Name(sharedinfo));
    end;
  end;

  // update the count of INFOs in DIAL
  SetElementNativeValues(dial, 'TIFC', ElementCount(ChildGroup(dial)));
end;

//===========================================================================
procedure lvLinesData(Sender: TObject; Item: TListItem);
begin
  Item.Caption := slINFOs[Item.Index];
  Item.SubItems.Add(IntToStr(TList(slINFOs.Objects[Item.Index]).Count));
end;

//===========================================================================
procedure lvLinesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: integer;
begin
  if Key = VK_DELETE then begin
    if not Assigned(lvLines.Selected) then
      Exit;
    
    i := lvLines.Selected.Index;
    TList(slINFOs.Objects[i]).Free;
    slINFOs.Delete(i);
    lvLines.Items.Count := slINFOs.Count;
    lvLines.Refresh;
  end;
end;

//===========================================================================
procedure cmbQuestOnChange(Sender: TObject);
var
  quest, dial: IInterface;
  i: integer;
begin
  cmbTopic.Items.Clear;
  cmbTopic.Items.Add('<Create new topic>');
  quest := ObjectToElement(cmbQuest.Items.Objects[cmbQuest.ItemIndex]);
  for i := 0 to Pred(ReferencedByCount(quest)) do begin
    dial := ReferencedByIndex(quest, i);
    if Signature(dial) <> 'DIAL' then
      Continue;

      if GetElementEditValues(dial, 'DATA\Subtype') = 'SharedInfo' then
      cmbTopic.Items.AddObject(Name(dial), dial);
  end;
  cmbTopic.ItemIndex := 0;
end;

//===========================================================================
procedure CreateSharedForm;
var
  quests, quest: IInterface;
  i: integer;
  sl: TStringList;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Shared Infos';
    frm.Width := 900;
    frm.Height := 550;
    frm.Position := poScreenCenter;

    lbl := TLabel.Create(frm); lbl.Parent := frm;
    lbl.Top := 12;
    lbl.Left := 8;
    lbl.Caption := 'Create shared infos in Quest';

    cmbQuest := TComboBox.Create(frm);
    cmbQuest.Parent := frm;
    cmbQuest.Left := lbl.Left + lbl.Width + 10;
    cmbQuest.Top := 8;
    cmbQuest.Width := 250;
    cmbQuest.Style := csDropDownList;
    cmbQuest.DropDownCount := 20;
    cmbQuest.OnChange := cmbQuestOnChange;
    quests := GroupBySignature(Plugin, 'QUST');
    sl := TStringList.Create;
    for i := 0 to Pred(ElementCount(quests)) do begin
      quest := ElementByIndex(quests, i);
      sl.AddObject(EditorID(quest), quest);
    end;
    sl.Sort;
    cmbQuest.Items.Assign(sl);
    sl.Free;
    cmbQuest.ItemIndex := 0;

    lbl := TLabel.Create(frm); lbl.Parent := frm;
    lbl.Top := 12;
    lbl.Left := cmbQuest.Left + cmbQuest.Width + 10;
    lbl.Caption := 'under Shared Topic';

    cmbTopic := TComboBox.Create(frm);
    cmbTopic.Parent := frm;
    cmbTopic.Left := lbl.Left + lbl.Width + 10;
    cmbTopic.Top := 8;
    cmbTopic.Width := 350;
    cmbTopic.Anchors := [akLeft, akTop, akRight];
    cmbTopic.Style := csDropDownList;
    cmbTopic.DropDownCount := 20;
    cmbQuestOnChange(nil);

    lvLines := TListView.Create(frm);
    lvLines.Parent := frm;
    lvLines.Left := 8;
    lvLines.Top := 36;
    lvLines.Width := frm.Width - 40;
    lvLines.Height := frm.Height - 120;
    lvLines.TabOrder := 0;
    lvLines.Anchors := [akLeft, akTop, akRight, akBottom];
    lvLines.ReadOnly := True;
    lvLines.ViewStyle := vsReport;
    lvLines.DoubleBuffered := True;
    lvLines.RowSelect := True;
    lvLines.Columns.Add.Caption := 'Responses';
    lvLines.Columns[0].Width := lvLines.Width - 110;
    lvLines.Columns.Add.Caption := 'Duplicates';
    lvLines.Columns[1].Width := 80;
    lvLines.OwnerData := True;
    lvLines.OnData := lvLinesData;
    lvLines.OnKeyDown := lvLinesKeyDown;
    lvLines.Items.Count := slINFOs.Count;

    btnOk := TButton.Create(frm); btnOk.Parent := frm;
    btnOk.Caption := 'Create';
    btnOk.ModalResult := mrOk;
    btnOk.Left := frm.Width - 190;
    btnOk.Top := frm.Height - 72;
    btnOk.Anchors := [akBottom, akRight];
    
    btnCancel := TButton.Create(frm); btnCancel.Parent := frm;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := btnOk.Left + btnOk.Width + 8;
    btnCancel.Top := btnOk.Top;
    btnCancel.Anchors := [akBottom, akRight];

    if frm.ShowModal = mrOk then
      DoCreateSharedInfos(
        ObjectToElement(cmbQuest.Items.Objects[cmbQuest.ItemIndex]),
        ObjectToElement(cmbTopic.Items.Objects[cmbTopic.ItemIndex])
      )
      
  finally
    frm.Free;
  end;
end;
  
//===========================================================================
function Initialize: Integer;
begin
  if wbGameMode <> gmTES5 then begin
    MessageDlg('Supported games: Skyrim', mtInformation, [mbOk], 0);
    Result := 1;
    Exit;
  end;
  
  slINFOs := TStringList.Create;
end;

//===========================================================================
function Process(e: IInterface): Integer;
var
  responses, response: IInterface;
  i: integer;
  line: string;
  list: TList;
begin
  // process only INFO records
  if Signature(e) <> 'INFO' then
    Exit;
    
  // skip overrides
  if not IsMaster(e) then
    Exit;
  
  // skip INFOs that already use shared info
  if ElementExists(e, 'DNAM') then
    Exit;
  
  // skip INFOs which are shared INFOs themselves
  if GetElementEditValues(LinksTo(ElementByName(e, 'Topic')), 'DATA\Subtype') = 'SharedInfo' then
    Exit;
  
  responses := ElementByName(e, 'Responses');
  if not Assigned(responses) then
    Exit;
    
  // iterate over responses
  for i := 0 to Pred(ElementCount(responses)) do begin
    response := ElementByIndex(responses, i);
    // create a line with emotion value and response text
    line := ' [' + GetElementEditValues(response, 'TRDT\Emotion Type') + '] ' + GetElementEditValues(response, 'NAM1');
  end;
  
  // collect list of all responses
  i := slINFOs.IndexOf(line);
  // if duplicate, then add under existing entry
  if i <> - 1 then
    TList(slINFOs.Objects[i]).Add(e)
  // if new, then add to the list
  else begin
    list := TList.Create;
    list.Add(e);
    slINFOs.AddObject(line, list);
  end;

  Plugin := GetFile(e);
end;

//===========================================================================
function Finalize: Integer;
var
  i: integer;
  list: TList;
begin
  // remove single responses
  for i := Pred(slINFOs.Count) downto 0 do begin
    list := TList(slINFOs.Objects[i]);
    if list.Count < 2 then begin
      list.Free;
      slINFOs.Delete(i);
    end;
  end;
  
  if slINFOs.Count > 0 then
    CreateSharedForm
  else
    MessageDlg('No duplicate responses found.', mtInformation, [mbOk], 0);
  
  for i := 0 to Pred(slINFOs.Count) do
    TList(slINFOs.Objects[i]).Free;
  slINFOs.Free;
end;

end.