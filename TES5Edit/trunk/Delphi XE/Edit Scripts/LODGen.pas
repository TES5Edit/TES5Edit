{
  LOD Generator

  LODGen.exe <InputFile> [--dontFixTangents]
--dontFixTangents is more for Skyrim  
--dontGenerateTangents
--dontGenerateVertexColors
you can now specify an individual LOD level to create via --lodLevel <4/8/16> and individual quads via --x <num> and --y <num> inconjuction with lodLevel
--removeUnseenFaces to remove faces under terrain
}
unit xLODGen;

const
  sLODOptions = ',Full model,Static LOD4,Static LOD8,Static LOD16,_FAR model';
  iLODNone = 0;
  iLODFull = 1;
  iLOD4 = 2;
  iLOD8 = 3;
  iLOD16 = 4;
  iLODFar = 5;

var
  slLODTypes, slLOD, slCache, slExport: TStringList;
  lstSkip: TList;
  lod4, lod8, lod16: integer; // Lod types
  AddModels, AddModelsLOD4, AddModelsLOD8, AddModelsLOD16: boolean; // add models flags
  bDefaultVWDOnly: boolean;
  slAddModels: TStringList; // list of models to add

  frm: TForm;
  btnOk, btnCancel, btnSave, btnLoad, btnPath: TButton;
  cbWorld: TComboBox;
  lvRules: TListView;
  SelectedRuleIndex: integer;
  gb: TGroupBox;
  chkDefaultVWDOnly: TCheckBox;
  edExport, edDestination: TEdit;

//==========================================================================
function HexArrayToStr(s: string): string;
var
  i: integer;
  c: char;
  hex: string;
begin
  Result := '';
  i := 1;
  while i < Length(s) do begin
    if s <> ' ' then begin
      c := Chr(StrToInt('$' + Copy(s, i, 2)));
      if c = #0 then
        Exit;
      Result := Result + c;
      i := i + 3;
    end else
      i := i + 1;
  end;
end;

//============================================================================
// get index of Item in Items, or 0 if not found and Items are not empty
function IndexIn(Items: TStrings; Item: string): integer;
begin
  Result := Items.IndexOf(Item);
  if (Result = -1) and (Items.Count > 0) then
    Result := 0;
end;

//==========================================================================
// make sure that mesh file name starts with 'meshes\'
function NormalizePath(value: string): string;
begin
  if value = '' then
    Exit;
  if Copy(value, 1, 1) = '\' then
    Delete(value, 1, 1);
  value := LowerCase(value);
  if Copy(value, 1, 5) = 'data\' then
    value := Copy(value, 6, Length(value));
  if not (Copy(value, 1, 7) = 'meshes\') then
    value := 'meshes\' + value;
  Result := value;
end;

//============================================================================
// name of LOD settings file for worldspace
function LODSettingsFileName(wrld: IInterface): string;
begin
  if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then
    Result := 'lodsettings\' + EditorID(wrld) + '.dlodsettings'
  else
    Result := 'lodsettings\' + EditorID(wrld) + '.lod';
end;

//============================================================================
// does worldspace have a lod?
function HasLOD(wrld: IInterface): boolean;
begin
  // a presence of lod settings file
  Result := ResourceExists(LODSettingsFileName(wrld));
end;

//============================================================================
// get south west cell of lod
function LODCellSW(wrld: IInterface; var SWCellX, SWCellY: integer): Boolean;
var
  BytesStream: TBytesStream;
  lodsettings: TBinaryReader;
begin
  if not HasLOD(wrld) then
    Exit;

  // read from lod settings file
  BytesStream := TBytesStream.Create(ResourceOpenData('', LODSettingsFileName(wrld)));
  lodsettings := TBinaryReader.Create(BytesStream);
  try
    if (wbGameMode = gmFO3) or (wbGameMode = gmFNV) then
      BytesStream.Position := 12;
    SWCellX := lodsettings.ReadSmallInt;
    SWCellY := lodsettings.ReadSmallInt;
    Result := True;
  finally
    lodsettings.Free;
    BytesStream.Free;
  end;
end;

//============================================================================
// getting lod file for a record depending on lod type
function LODMeshFor(rec: IInterface; LodType: integer): string;
begin
  if LodType = iLODNone then
    Exit
  else if LodType = iLODFull then
    Result := GetElementEditValues(rec, 'Model\MODL')
  else if LODType = iLOD4 then
    Result := HexArrayToStr(GetElementEditValues(rec, 'MNAM\LOD #0 (Level 0)\Mesh'))
  else if LODType = iLOD8 then
    Result := HexArrayToStr(GetElementEditValues(rec, 'MNAM\LOD #1 (Level 1)\Mesh'))
  else if LODType = iLOD16 then
    Result := HexArrayToStr(GetElementEditValues(rec, 'MNAM\LOD #2 (Level 2)\Mesh'))
  else if LODType = iLODOblivion then begin
    Result := GetElementEditValues(rec, 'Model\MODL');
    Result := Copy(Result, 1, Length(Result) - 4) + '_far.nif';
    if not ResourceExists(Result) then Result := '';
  end else
    Exit;
  if Result <> '' then
    Result := NormalizePath(Result);
end;

//============================================================================
procedure ProcessReference(e: IInterface);
var
  i, j, idx, statfid: integer;
  stat: IInterface;
  s, mFull, m4, m8, m16: string;
begin
  // get the last override and check if deleted or disabled
  e := WinningOverride(e);
  if GetIsDeleted(e) or GetIsInitiallyDisabled(e) then
    Exit;
  
  // no position
  if not ElementExists(e, 'DATA') then
    Exit;

  stat := BaseRecord(e);
  statfid := GetLoadOrderFormID(stat);
  // check if to skip
  if lstSkip.IndexOf(statfid) <> -1 then
    Exit;

  // not a reference of STAT
  if Signature(stat) <> 'STAT' then
    Exit;

  // getting lod files from cache
  idx := slCache.IndexOfObject(statfid);
  // not in cache
  if idx = -1 then begin
    stat := WinningOverride(stat);
    mFull := LODMeshFor(stat, iLODFull);
    // checking lod rules
    for i := 0 to Pred(slLOD.Count) do begin
      if (slLOD[i] = '\') and bDefaultVWDOnly then
        if not GetIsVisibleWhenDistant(stat) then
          Continue;
      if Pos(slLOD[i], mFull) > 0 then begin
        j := slLOD.Objects[i];
        m4 := LODMeshFor(stat, j and $FF);
        m8 := LODMeshFor(stat, j shr 8 and $FF);
        m16 := LODMeshFor(stat, j shr 16 and $FF);
        if (Length(m4) + Length(m8) + Length(m16)) > 0 then begin
          // a tab separated string of Editor ID, flags, material, original mesh and lod files
          s := EditorID(stat) + #9 + IntToHex(GetElementNativeValues(stat, 'Record Header\Record Flags'), 8) + #9
            + EditorID(LinksTo(ElementByPath(stat, 'DNAM\Material'))) + #9 + mFull + #9 + m4 + #9 + m8 + #9 + m16;
          idx := slCache.Count;
          slCache.AddObject(s, statfid);
          Break;
        end
      end;
    end;
  end;
  
  // not a lod object: no matching lod rules and not in cache
  if idx = -1 then begin
    lstSkip.Add(statfid);
    Exit;
  end;

  // reference scale
  if ElementExists(e, 'XSCL') then
    s := GetElementEditValues(e, 'XSCL')
  else
    s := '1.0';

  slExport.Add(Format('%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s', [
    IntToHex(GetLoadOrderFormID(e), 8),
    IntToHex(GetElementNativeValues(e, 'Record Header\Record Flags'), 8),
    GetElementEditValues(e, 'DATA\Position\X'),
    GetElementEditValues(e, 'DATA\Position\Y'),
    GetElementEditValues(e, 'DATA\Position\Z'),
    GetElementEditValues(e, 'DATA\Rotation\X'),
    GetElementEditValues(e, 'DATA\Rotation\Y'),
    GetElementEditValues(e, 'DATA\Rotation\Z'),
    s,
    slCache[idx]
  ]));
end;

//============================================================================
procedure IterateWorldspace(e: IInterface);
var
  i: integer;
begin
  if ElementType(e) = etGroupRecord then begin
    // Exterior cell block progress messages
    if GroupType(e) = 4 then
      AddMessage('Processing: ' + Name(e) + ' in ' + GetFileName(e));
    for i := 0 to Pred(ElementCount(e)) do
      IterateWorldspace(ElementByIndex(e, i));
  end
  // processing master references
  else if Signature(e) = 'REFR' then
    if IsMaster(e) then
      ProcessReference(e);
end;

//============================================================================
function ExportWorldspace(wrld: IInterface): Boolean;
var
  x, y, i: integer;
  ent: IInterface;
  fname: string;
begin
  slExport.Add(EditorID(wrld));
  Result := LODCellSW(wrld, x, y);
  if not Result then begin
    AddMessage('Unable to open lod settings file for worldspace ' + LODSettingsFileName(wrld));
    Exit;
  end;
  slExport.Add(Format('%d %d', [x, y]));
  slExport.Add(GetElementEditValues(wrld, 'TNAM'));
  slExport.Add(GetElementEditValues(wrld, 'UNAM'));
  slExport.Add(edDestination.Text);

  AddMessage('Building a list of LOD objects, please wait...');
  IterateWorldspace(ChildGroup(wrld));
  for i := 0 to Pred(OverrideCount(wrld)) do begin
    ent := OverrideByIndex(wrld, i);
    IterateWorldspace(ChildGroup(ent));
  end;

  if slExport.Count > 5 then begin
    fname := ScriptsPath + 'LODGen ' + EditorID(wrld) + '.txt';
    AddMessage('Saving objects LOD data to ' + fname);
    slExport.SaveToFile(fname);
    AddMessage(Format('LOD references: %d, unique LOD objects: %d', [slExport.Count-5, slCache.Count]));
  end else
    AddMessage('No LOD objects in ' + Name(wrld));

  slExport.Clear;
  slCache.Clear;
  lstSkip.Clear;
end;

//============================================================================
// Save preset
procedure PresetSave(aFileName: string);
var
  ini: TMemIniFile;
  i: integer;
  s: string;
begin
  ini := TMemIniFile.Create(aFileName);
  ini.WriteString(wbGameName, 'World', cbWorld.Text);
  ini.WriteString(wbGameName, 'Destination', edDestination.Text);
  ini.WriteString(wbGameName, 'ModelLOD4', cbLOD4.Text);
  ini.WriteString(wbGameName, 'ModelLOD8', cbLOD8.Text);
  ini.WriteString(wbGameName, 'ModelLOD16', cbLOD16.Text);
  ini.WriteBool(wbGameName, 'AddModels', chkAddModels.Checked);
  ini.WriteBool(wbGameName, 'AddModelsLOD4', chkAddModels4.Checked);
  ini.WriteBool(wbGameName, 'AddModelsLOD8', chkAddModels8.Checked);
  ini.WriteBool(wbGameName, 'AddModelsLOD16', chkAddModels16.Checked);
  for i := 0 to Pred(memoModels.Lines.Count) do begin
    if Trim(memoModels.Lines[i]) = '' then
      Continue;
    if s <> '' then s := s + ',';
    s := s + memoModels.Lines[i];
  end;
  ini.WriteString(wbGameName, 'AddModelsText', s);
  ini.UpdateFile;
  ini.Free;
end;

//============================================================================
// Load preset
procedure PresetLoad(aFileName: string);
var
  ini: TMemIniFile;
begin
  ini := TMemIniFile.Create(aFileName);
  cbWorld.ItemIndex := IndexIn(cbWorld.Items, ini.ReadString(wbGameName, 'World', cbWorld.Text));
  edDestination.Text := ini.ReadString(wbGameName, 'Destination', edDestination.Text);
  cbLOD4.ItemIndex := IndexIn(cbLOD4.Items, ini.ReadString(wbGameName, 'ModelLOD4', cbLOD4.Text));
  cbLOD8.ItemIndex := IndexIn(cbLOD8.Items, ini.ReadString(wbGameName, 'ModelLOD8', cbLOD8.Text));
  cbLOD16.ItemIndex := IndexIn(cbLOD16.Items, ini.ReadString(wbGameName, 'ModelLOD16', cbLOD16.Text));
  chkAddModels.Checked := ini.ReadBool(wbGameName, 'AddModels', chkAddModels.Checked);
  chkAddModels4.Checked := ini.ReadBool(wbGameName, 'AddModelsLOD4', chkAddModels4.Checked);
  chkAddModels8.Checked := ini.ReadBool(wbGameName, 'AddModelsLOD8', chkAddModels8.Checked);
  chkAddModels16.Checked := ini.ReadBool(wbGameName, 'AddModelsLOD16', chkAddModels16.Checked);
  memoModels.Lines.CommaText := ini.ReadString(wbGameName, 'AddModelsText', '');
  ini.Free;
end;

//============================================================================
// fill with worldspaces that have LOD
procedure FillWorldspacesWithLOD(cmbWorld: TComboBox);
var
  i, j: integer;
  f, wrlds, wrld: IInterface;
  sl: TStringList;
  s: string;
begin
  // filling list of worldspaces
  sl := TStringList.Create;
  try
    sl.Duplicates := dupIgnore;
    sl.Sorted := True;
    for i := Pred(FileCount) downto 0 do begin
      wrlds := GroupBySignature(FileByIndex(i), 'WRLD');
      for j := 0 to Pred(ElementCount(wrlds)) do begin
        wrld := ElementByIndex(wrlds, j);
        if ElementType(wrld) <> etMainRecord then
          Continue;
        if HasLOD(wrld) then
          sl.AddObject(EditorID(wrld), MasterOrSelf(wrld));
      end;
    end;
    cmbWorld.Items.Assign(sl);
  finally
    sl.Free;
  end;
end;

//============================================================================
procedure cbWorldSelect(Sender: TObject);
begin
  edExport.Text := ScriptsPath + 'LODGen ' + TComboBox(Sender).Text + '.txt';
  edDestination.Text := DataPath + 'meshes\terrain\' + TComboBox(Sender).Text + '\Objects';
end;

//============================================================================
procedure btnPathClick(Sender: TObject);
var
  s: string;
begin
  s := SelectDirectory('Destination path', '', edDestination.Text, nil);
  if s <> '' then
    edDestination.Text := s;
end;

//============================================================================
procedure btnSaveClick(Sender: TObject);
var
  dlgSave: TSaveDialog;
begin
  dlgSave := TSaveDialog.Create(nil);
  try
    dlgSave.Options := dlgSave.Options + [ofOverwritePrompt];
    dlgSave.Filter := 'LODGen preset (*.ini)|*.ini';
    dlgSave.InitialDir := ScriptsPath;
    dlgSave.FileName := 'LODGen preset ' + cbWorld.Text + '.ini';
    if dlgSave.Execute then
      PresetSave(dlgSave.FileName);
  finally
    dlgSave.Free;
  end;
end;

//============================================================================
procedure btnLoadClick(Sender: TObject);
var
  dlgOpen: TOpenDialog;
begin
  dlgOpen := TOpenDialog.Create(nil);
  try
    dlgOpen.Filter := 'LODGen preset (*.ini)|*.ini';
    dlgOpen.InitialDir := ScriptsPath;
    dlgOpen.FileName := 'LODGen preset ' + cbWorld.Text + '.ini';
    if dlgOpen.Execute then
      PresetLoad(dlgOpen.FileName);
  finally
    dlgOpen.Free;
  end;
end;

//===========================================================================
// on key down event handler for form
procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    TForm(Sender).ModalResult := mrCancel;
end;

//===========================================================================
// listview custom data event
procedure lvRulesData(Sender: TObject; Item: TListItem);
var
  i: integer;
begin
  //Item.Caption := slItems[Item.Index];
  Item.Caption := slLOD[Item.Index];
  i := slLOD.Objects[Item.Index];
  Item.SubItems.Add(slLODTypes[i and $FF]);
  Item.SubItems.Add(slLODTypes[i shr 8 and $FF]);
  Item.SubItems.Add(slLODTypes[i shr 16 and $FF]);
end;

//===========================================================================
procedure lvRulesDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Sender = lvRules) and Assigned(lvRules.GetItemAt(X, Y));
end;

//===========================================================================
procedure lvRulesDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  dropItem : TListItem;
begin
  if Sender <> Source then
    Exit;
  dropItem := lvRules.GetItemAt(X, Y);
  slLOD.Exchange(SelectedRuleIndex, dropItem.Index);
  dropItem.Selected := True;
  lvRules.Refresh;
end;

//===========================================================================
// on select item event handler for lod rules
procedure lvRulesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if not Selected then Exit;
  SelectedRuleIndex := Item.Index;
end;

//===========================================================================
// on double click event handler for mesh rules
procedure lvRulesDblClick(Sender: TObject);
begin
  if not Assigned(lvRules.Selected) then
    Exit;
end;

//============================================================================
function CreateLabel(aParent: TControl; x, y: Integer; aCaption: string): TLabel;
begin
  Result := TLabel.Create(aParent);
  Result.Parent := aParent;
  Result.Left := x;
  Result.Top := y;
  Result.Caption := aCaption;
end;

//============================================================================
procedure OptionsForm;
var
  i: integer;
  pnl: TPanel;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := wbAppName + 'LODGen';
    frm.Width := 560;
    frm.Height := 410;
    frm.Position := poMainFormCenter;
    frm.BorderStyle := bsDialog;
    frm.KeyPreview := True;
    frm.OnKeyDown := FormKeyDown;
    
    cbWorld := TComboBox.Create(frm);
    cbWorld.Parent := frm;
    cbWorld.Left := 54;
    cbWorld.Top := 12;
    cbWorld.Width := 220;
    cbWorld.Style := csDropDownList;
    cbWorld.DropDownCount := 20;
    cbWorld.OnSelect := cbWorldSelect;
    CreateLabel(frm, 16, cbWorld.Top + 4, 'World');
    
    FillWorldspacesWithLOD(cbWorld);
    if cbWorld.Items.Count > 0 then cbWorld.ItemIndex := 0;

    btnSave := TButton.Create(frm);
    btnSave.Parent := frm;
    btnSave.Caption := 'Save preset';
    btnSave.Left := cbWorld.Left + cbWorld.Width + 8;
    btnSave.Top := cbWorld.Top - 2;
    btnSave.OnClick := btnSaveClick;

    btnLoad := TButton.Create(frm);
    btnLoad.Parent := frm;
    btnLoad.Caption := 'Load preset';
    btnLoad.Left := btnSave.Left + btnSave.Width + 8;
    btnLoad.Top := btnSave.Top;
    btnLoad.OnClick := btnLoadClick;

    edExport := TEdit.Create(frm);
    edExport.Parent := frm;
    edExport.Left := 100;
    edExport.Top := cbWorld.Top + cbWorld.Height + 12;
    edExport.Width := cbWorld.Width + 180;
    edExport.ReadOnly := True;
    CreateLabel(frm, 16, edExport.Top + 4, 'LODGen export');

    edDestination := TEdit.Create(frm);
    edDestination.Parent := frm;
    edDestination.Left := edExport.Left;
    edDestination.Top := edExport.Top + 28;
    edDestination.Width := edExport.Width;
    edDestination.ReadOnly := True;
    CreateLabel(frm, 16, edDestination.Top + 4, 'LODGen path');

    btnPath := TButton.Create(frm);
    btnPath.Parent := frm;
    btnPath.Top := edDestination.Top - 1;
    btnPath.Left := edDestination.Left + edDestination.Width + 6;
    btnPath.Width := 32;
    btnPath.Height := 22;
    btnPath.Caption := '...';
    btnPath.OnClick := btnPathClick;

    lvRules := TListView.Create(frm);
    lvRules.Parent := frm;
    lvRules.Left := 16;
    lvRules.Top := edDestination.Top + 32;
    lvRules.Width := frm.Width - 40;
    lvRules.Height := 140;
    lvRules.ReadOnly := True;
    lvRules.ViewStyle := vsReport;
    lvRules.DragMode := dmAutomatic;
    lvRules.RowSelect := True;
    //lvRules.GridLines := True;
    lvRules.DoubleBuffered := True;
    lvRules.Columns.Add.Caption := 'Mesh';
    lvRules.Columns[0].Width := lvRules.Width - 294;
    lvRules.Columns.Add.Caption := 'LOD4';
    lvRules.Columns[1].Width := 90;
    lvRules.Columns.Add.Caption := 'LOD8';
    lvRules.Columns[2].Width := 90;
    lvRules.Columns.Add.Caption := 'LOD16';
    lvRules.Columns[3].Width := 90;
    lvRules.OwnerData := True;
    lvRules.OnData := lvRulesData;
    lvRules.OnSelectItem := lvRulesSelectItem;
    lvRules.OnDblClick := lvRulesDblClick;
    lvRules.OnDragOver := lvRulesDragOver;
    lvRules.OnDragDrop := lvRulesDragDrop;
    lvRules.Items.Count := slLOD.Count;
    
    chkDefaultVWDOnly := TCheckBox.Create(frm);
    chkDefaultVWDOnly.Parent := frm;
    chkDefaultVWDOnly.Left := lvRules.Left;
    chkDefaultVWDOnly.Top := lvRules.Top + lvRules.Height + 8;
    chkDefaultVWDOnly.Width := 250;
    chkDefaultVWDOnly.Caption := 'Default "\" rule applies only for VWD objects';
    chkDefaultVWDOnly.Checked := True;
    
    btnOk := TButton.Create(frm);
    btnOk.Parent := frm;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;
    btnOk.Left := frm.Width - 176;
    btnOk.Top := frm.Height - 62;
    
    btnCancel := TButton.Create(frm);
    btnCancel.Parent := frm;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := btnOk.Left + btnOk.Width + 8;
    btnCancel.Top := btnOk.Top;
    
    pnl := TPanel.Create(frm);
    pnl.Parent := frm;
    pnl.Left := 8;
    pnl.Top := btnOk.Top - 12;
    pnl.Width := frm.Width - 20;
    pnl.Height := 2;
    
    //PresetLoad(ScriptsPath + 'LODGen preset default.ini');
    cbWorldSelect(cbWorld);
    
    if frm.ShowModal <> mrOk then
      Exit;

    if cbWorld.ItemIndex = -1 then
      Exit;
    
    if edDestination.Text = '' then begin
      AddMessage('No destination path specified');
      Exit;
    end;
      
    bDefaultVWDOnly := chkDefaultVWDOnly.Checked;
    
    //PresetSave(ScriptsPath + 'LODGen preset default.ini');
    ExportWorldspace(ObjectToElement(cbWorld.Items.Objects[cbWorld.ItemIndex]));
  finally
    frm.Free;
  end;
end;

//============================================================================
function Initialize: integer;
begin
  Result := 1;
  if (wbGameMode <> gmFO3) and
     (wbGameMode <> gmFNV) and
     (wbGameMode <> gmTES5)
  then begin
    MessageDlg('LODGen supports Skyrim and Fallouts only.', mtInformation, [mbOk], 0);
    Exit;
  end;

  slLODTypes := TStringList.Create;
  slLODTypes.StrictDelimiter := True;
  slLODTypes.CommaText := sLODOptions;
  slLOD := TStringList.Create;
  //slLOD.AddObject('\rocks\', $00000201);
  //slLOD.AddObject('ship.nif', $00000000);
  slLOD.AddObject('\', $00040302);
  slCache := TStringList.Create;
  slExport := TStringList.Create;
  lstSkip := TList.Create;

  OptionsForm;

  lstSkip.Free;
  slExport.Free;
  slCache.Free;
  slLOD.Free;
  slLODTypes.Free;
end;

end.
