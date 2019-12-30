{
  Add large reference RNAM data to a worldspace

  1. Select ESM plugin that adds new references to a worldspace
     * only new ESMs are listed - see sDefaultPlugins below

  2. Select worldspace for which to add large references
     * only worldspaces for selected ESM without existing RNAM data are listed
     * remove pre-existing RNAM data manually to update
     * any worldspace supports large references regardless of static object LOD

  3. Click OK to add RNAM data for selected worldspace
     * CK default 'size' is 512 - see fLargeRefMinSize below
     * CK adds large references for STAT and MSTT - see sLargeRefBaseObjects below
     * afterwards generate static LOD for worldspaces with LOD

}
unit UserScript;

const
  sDefaultPlugins = 'skyrim.esm,update.esm,dawnguard.esm,hearthfires.esm,dragonborn.esm';
  sLargeRefBaseObjects = 'STAT MSTT';
  fLargeRefMinSize = 512;

var
  cbPlugin, cbWorld: TComboBox;
  slLargeReferences: TwbFastStringList;

//============================================================================
// name of LOD settings file for worldspace
function LODSettingsFileName(wrld: IInterface): string;
begin
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
procedure ProcessReference(e: IInterface);
var
  stat: IInterface;
  Dimensions: TwbVector;
  fScale: float;
  Cell: TwbGridCell;
begin
  // skip XESP
  if ElementExists(e, 'XESP') then
    Exit;

  stat := BaseRecord(e);

  // skip markers
  if GetElementNativeValues(stat, 'Record Header\Record Flags') and $00800000 = $00800000 then
    Exit;

  // skip no model
  if not ElementExists(stat, 'Model') then
    Exit;

  // skip no OBND
  if not ElementExists(stat, 'OBND') then
    Exit;

  // check MSTT has unkown2 flag set
  if (Signature(stat) = 'MSTT') and (GetElementNativeValues(stat, 'DATA - Flags') and $4 <> $4) then
    Exit;

  if ElementExists(e, 'XSCL') then
    fScale := GetElementEditValues(e, 'XSCL')
  else
    fScale := 1.0;

  // get base object size
  Dimensions.x := (GetElementNativeValues(stat, 'OBND\X2') - GetElementNativeValues(stat, 'OBND\X1')) * fScale;
  Dimensions.y := (GetElementNativeValues(stat, 'OBND\Y2') - GetElementNativeValues(stat, 'OBND\Y1')) * fScale;
  Dimensions.z := (GetElementNativeValues(stat, 'OBND\Z2') - GetElementNativeValues(stat, 'OBND\Z1')) * fScale;

  // skipping wierd stuff or data
  if (Dimensions.z = 0) or (Dimensions.y = 0) or (Dimensions.x = 0) then
    Exit;

  // rules based on emperical evidence - could be incomplete
  // technically any reference can be added as large reference, but the game does check bounds and BASE signatures etc.
  // if in-game checks fail -> LOD does not unload and reference might not load at all
  // it seems adding up all bounds needs to be > 1743
  if (Dimensions.x + Dimensions.y + Dimensions.z) > (fLargeRefMinSize * 3.405) then begin
    Cell := wbPositionToGridCell(GetPosition(e));
    slLargeReferences.AddObject(IntToStr(Cell.x) + ' ' + IntToStr(Cell.y), e);
  end;

end;

//============================================================================
procedure IterateWorldspace(e: IInterface);
var
  lst: TList;
  i: integer;
begin
  lst := TList.Create;
  AddMessage('Gathering large references added by ' + GetFileName(GetFile(e)));
  // find all new references added by this plugin
  // no need to include modified references from master plugins again, since all RNAM data is merged anyways
  wbFindREFRsByBase(e, sLargeRefBaseObjects, 1, lst);
  for i := 0 to lst.Count - 1 do
    ProcessReference(ObjectToElement(lst[i]));
  lst.Free;
end;

//============================================================================
// add reference to existing RNAM
procedure AddRNAMItem(rnam, e: IInterface);
var 
  Cell: TwbGridCell;
begin
  Cell := wbPositionToGridCell(GetPosition(e));
  rnam := ElementAssign(ElementByPath(rnam, 'References'), HighInteger, nil, False);
  SetElementNativeValues(rnam, 'X', Cell.x);
  SetElementNativeValues(rnam, 'Y', Cell.y);
  SetElementNativeValues(rnam, 'Ref', GetLoadOrderFormID(e));
end;

//============================================================================
// add new RNAM
function AddRNAM(wrld, e: IInterface): IInterface;
var 
  Cell: TwbGridCell;
begin
  Result := nil;
  Cell := wbPositionToGridCell(GetPosition(e));

  if not ElementExists(wrld, 'RNAM') then begin
    Result := ElementByPath(Add(wrld, 'RNAM', True), 'RNAM');
  end
  else begin
    Result := ElementAssign(ElementByPath(wrld, 'RNAM'), HighInteger, nil, False);
  end

  SetElementNativeValues(Result, 'X', Cell.x);
  SetElementNativeValues(Result, 'Y', Cell.y);

  AddRNAMItem(Result, e);
end;

//============================================================================
procedure UpdateWorldspace(wrld: IInterface);
var
  i, j: integer;
  s: string;
  e, rnam: IInterface;
  CurrentCell, Cell: TwbGridCell;
begin

  if slLargeReferences.Count = 0 then
    Exit;

  AddMessage('Adding ' + IntToStr(slLargeReferences.Count) + ' large references to ' + EditorID(wrld));

  i := Pred(slLargeReferences.Count);
  while i >= 0 do begin
    e := ObjectToElement(slLargeReferences.Objects[i]);
    s := slLargeReferences[i];

    // add new RNAM
    rnam := AddRNAM(wrld, e);
    // remove reference from list
    slLargeReferences.Delete(i);

    // add all other references for same cell
    for j := Pred(i) downto 0 do begin
      e := ObjectToElement(slLargeReferences.Objects[j]);
      // go through list sorted by coordinates
      if (s = slLargeReferences[j]) then begin
        // add reference to existing RNAM
        AddRNAMItem(rnam, e);
        // remove reference from list
        slLargeReferences.Delete(j);
      end
      else
        break;
    end;

    i := Pred(slLargeReferences.Count);
  end;
end;

//============================================================================
procedure GenerateWorldspace(wrld: IInterface);
begin
  IterateWorldspace(wrld);
  UpdateWorldspace(wrld);
end;

//============================================================================
// skip vanilla plugins
function IsDefaultPlugin(s: string): Boolean;
var
  i: integer;
  sl: TStringList;
begin
  Result := False;
  sl := TStringList.Create;
  sl.StrictDelimiter := True;
  sl.CommaText := sDefaultPlugins;
  try
    for i := 0 to Pred(sl.Count) do
      if Lowercase(s) = sl[i] then begin
        Result := True;
        exit;
      end;
  finally
    sl.free;
  end;
end;

//============================================================================
// fill plugin drop-down
procedure FillPlugins(cmbWorld: TComboBox);
var
  i: integer;
  f: IInterface;
  sl: TStringList;
begin
  // filling list of worldspaces
  sl := TStringList.Create;
  try
    sl.Duplicates := dupIgnore;
    sl.Sorted := True;
    sl.AddObject(' -- Select a plugin --', nil);
    for i := Pred(FileCount) downto 0 do begin
      f := FileByIndex(i);

      // skip vanilla plugins
      if IsDefaultPlugin(GetFileName(f)) then
        Continue;

      // only ESM for now
      if not GetIsESM(f) then
        Continue;

      sl.AddObject(GetFileName(f), f);
    end;
    cmbWorld.Items.Assign(sl);
  finally
    sl.Free;
  end;
end;

//============================================================================
// fill with worldspaces
procedure FillWorldspaces(cmbWorld: TComboBox; f: IInterface);
var
  i, j: integer;
  wrlds, wrld: IInterface;
  sl: TStringList;
  s: string;
begin
  // filling list of worldspaces
  sl := TStringList.Create;
  try
    sl.Duplicates := dupIgnore;
    sl.Sorted := True;
    sl.AddObject(' -- Select a worldspace --', nil);
    wrlds := GroupBySignature(f, 'WRLD');
    for j := 0 to Pred(ElementCount(wrlds)) do begin
      wrld := ElementByIndex(wrlds, j);
      if ElementType(wrld) <> etMainRecord then
        Continue;
      // skip if RNAM data already exists
      if ElementExists(wrld, 'RNAM') then
        Continue;
      sl.AddObject(EditorID(wrld), wrld);
    end;
    cmbWorld.Items.Assign(sl);
  finally
    sl.Free;
  end;
end;

//============================================================================
procedure UpdatecbWorld(Sender: TObject);
begin
  FillWorldspaces(cbWorld, ObjectToElement(cbPlugin.Items.Objects[cbPlugin.ItemIndex]));
  if cbWorld.Items.Count > 0 then cbWorld.ItemIndex := 0;
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
function OptionsForm: IInterface;
var
  frm: TForm;
  btnOk, btnCancel: TButton;
begin
  Result := nil;

  frm := TForm.Create(nil);
  try
    frm.Caption := 'Generate Large References';
    frm.Width := 400;
    frm.Height := 200;
    frm.Position := poMainFormCenter;
    frm.BorderStyle := bsDialog;
    frm.KeyPreview := True;

    cbPlugin := TComboBox.Create(frm); cbPlugin.Parent := frm;
    cbPlugin.Left := 54;
    cbPlugin.Top := 12;
    cbPlugin.Width := 260;
    cbPlugin.Style := csDropDownList;
    cbPlugin.DropDownCount := 20;
    cbPlugin.OnSelect := UpdatecbWorld;
    CreateLabel(frm, 16, cbPlugin.Top + 4, 'Plugin');

    FillPlugins(cbPlugin);
    if cbPlugin.Items.Count > 0 then cbPlugin.ItemIndex := 0;
    if cbPlugin.Items.Count = 2 then cbPlugin.ItemIndex := 1;
    
    cbWorld := TComboBox.Create(frm); cbWorld.Parent := frm;
    cbWorld.Left := 54;
    cbWorld.Top := cbPlugin.Top + cbPlugin.Height + 4;
    cbWorld.Width := 260;
    cbWorld.Style := csDropDownList;
    cbWorld.DropDownCount := 20;
    CreateLabel(frm, 16, cbWorld.Top + 4, 'World');

    FillWorldspaces(cbWorld, ObjectToElement(cbPlugin.Items.Objects[cbPlugin.ItemIndex]));
    if cbWorld.Items.Count > 0 then cbWorld.ItemIndex := 0;

    btnCancel := TButton.Create(frm); btnCancel.Parent := frm;
    btnCancel.Caption := 'Cancel';
    btnCancel.ModalResult := mrCancel;
    btnCancel.Left := cbWorld.Left + cbWorld.Width - btnCancel.Width;
    btnCancel.Top := cbWorld.Top + cbWorld.Height + 8;

    btnOk := TButton.Create(frm); btnOk.Parent := frm;
    btnOk.Caption := 'OK';
    btnOk.ModalResult := mrOk;
    btnOk.Left := btnCancel.Left - btnOk.Width - 8;
    btnOk.Top := btnCancel.Top;

    frm.Width := cbWorld.Left + cbWorld.Width + 32;
    frm.Height := btnOk.Top + btnOk.Height + 32;

    if frm.ShowModal <> mrOk then
      Exit;

    Result := ObjectToElement(cbWorld.Items.Objects[cbWorld.ItemIndex]);

  finally
    frm.Free;
  end;
end;


//============================================================================
function Initialize: integer;
var
  wrld: IInterface;
begin
  Result := 0;

  slLargeReferences := TwbFastStringList.Create;
  slLargeReferences.Duplicates := dupAccept;
  slLargeReferences.Sorted := True;

  if (wbGameMode <> gmSSE) then begin
    AddMessage('Game not supported');
    Exit;
  end;

  wrld := OptionsForm;
  if Assigned(wrld) then
    GenerateWorldspace(wrld);

  slLargeReferences.Free;

end;

end.
