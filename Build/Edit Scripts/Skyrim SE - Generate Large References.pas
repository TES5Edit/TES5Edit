{
  Add large reference RNAM data to a worldspace

  1. Select ESM plugin that modifies existing or adds new references to a worldspace
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
  bAddPrimitives = False;

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
procedure ProcessReference(wrld, e: IInterface);
var
  i: integer;
  stat: IInterface;
  Dimensions: TwbVector;
  fScale: float;
  Cell: IInterface;
  Grid: TwbGridCell;
begin
  // safety check
  if GetFile(wrld) <> GetFile(e) then
    Exit;

  // is a large reference that is overwritten
  if GetFile(wrld) <> GetFile(MasterOrSelf(e)) then begin
    if ReferencedByCount(MasterOrSelf(e)) > 0 then begin
      for i := 0 to Pred(ReferencedByCount(MasterOrSelf(e))) do begin
        stat := ReferencedByIndex(MasterOrSelf(e), i);
        if SameText(Name(wrld), Name(stat)) then begin
          Cell := LinksTo(ElementByPath(e, 'Cell'));
          if not Assigned(Cell) then
            Exit;
          Grid := GetGridCell(Cell);
          AddMessage('Overwrite: ' + Name(e));
          slLargeReferences.AddObject(IntToStr(Grid.x) + ' ' + IntToStr(Grid.y), e);
          Exit;
        end;
      end;
    end;
    Exit;
  end;

  // IsPersistent - causes large reference to never unload
  if GetElementNativeValues(e, 'Record Header\Record Flags') and $00000400 = $00000400 then
    Exit;

  // IsFullLOD
  if GetElementNativeValues(e, 'Record Header\Record Flags') and $00010000 = $00010000 then
    Exit;

  // InitiallyDisabled - causes large ref LOD for the cell to not unload
  if GetElementNativeValues(e, 'Record Header\Record Flags') and $00000800 = $00000800 then
    Exit;

  stat := BaseRecord(e);

  // Marker
  if GetElementNativeValues(stat, 'Record Header\Record Flags') and $00800000 = $00800000 then
    Exit;

  // Primitive
  if ElementExists(e, 'XPRM') then begin
    if not bAddPrimitives then
      Exit;
    Dimensions.x := GetElementNativeValues(e, 'XPRM - Primitive\Bounds\X') / 2;
    Dimensions.y := GetElementNativeValues(e, 'XPRM - Primitive\Bounds\Y') / 2;
    Dimensions.z := GetElementNativeValues(e, 'XPRM - Primitive\Bounds\Z') / 2;
    // rule based on debugging thanks to aers
    if SQRT(Power(Dimensions.x, 2) + Power(Dimensions.y, 2) + Power(Dimensions.z, 2)) >= fLargeRefMinSize then begin
      Cell := LinksTo(ElementByPath(e, 'Cell'));
      if not Assigned(Cell) then
        Exit;
      Grid := GetGridCell(Cell);
      AddMessage('XPRM: ' + Name(e));
      slLargeReferences.AddObject(IntToStr(Cell.x) + ' ' + IntToStr(Cell.y), e);
    end;
    Exit;
  end;

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
  Dimensions.x := GetElementNativeValues(stat, 'OBND\X2') - GetElementNativeValues(stat, 'OBND\X1');
  Dimensions.y := GetElementNativeValues(stat, 'OBND\Y2') - GetElementNativeValues(stat, 'OBND\Y1');
  Dimensions.z := GetElementNativeValues(stat, 'OBND\Z2') - GetElementNativeValues(stat, 'OBND\Z1');

  // skipping wierd stuff or data
  if (Dimensions.z = 0) or (Dimensions.y = 0) or (Dimensions.x = 0) then
    Exit;
  
  if (Dimensions.z = 65535) or (Dimensions.y = 65535) or (Dimensions.x = 65535) then
    Exit;  
    

  // rule based on debugging thanks to aers
  if SQRT(Power(Dimensions.x, 2) + Power(Dimensions.y, 2) + Power(Dimensions.z, 2)) * 0.5 * fscale >= fLargeRefMinSize then begin
    Cell := LinksTo(ElementByPath(e, 'Cell'));
    if not Assigned(Cell) then
      Exit;
    Grid := GetGridCell(Cell);
    AddMessage('New: ' + Name(e));
    slLargeReferences.AddObject(IntToStr(Grid.x) + ' ' + IntToStr(Grid.y), e);
  end;

end;

//============================================================================
procedure IterateWorldspace(wrld: IInterface);
var
  lst: TList;
  i: integer;
begin
  lst := TList.Create;
  try
    AddMessage('Gathering large references added by ' + GetFileName(GetFile(wrld)));
    // find all references added/modified by this plugin
    wbFindREFRsByBase(wrld, sLargeRefBaseObjects, 1, lst);
    for i := 0 to lst.Count - 1 do
      ProcessReference(wrld, ObjectToElement(lst[i]));
  finally
    lst.Free;
  end;
end;

//============================================================================
// add reference to existing RNAM
procedure AddRNAMItem(rnam, e: IInterface);
var 
  Cell: IInterface;
  Grid: TwbGridCell;
begin
  Cell := LinksTo(ElementByPath(e, 'Cell'));
  if not Assigned(Cell) then
    Exit;
  Grid := GetGridCell(Cell);
  rnam := ElementAssign(ElementByPath(rnam, 'References'), HighInteger, nil, False);
  BeginUpdate(rnam);
  try
    SetElementNativeValues(rnam, 'X', Grid.x);
    SetElementNativeValues(rnam, 'Y', Grid.y);
    SetElementEditValues(rnam, 'Ref', Name(e));
  finally
    EndUpdate(rnam);
  end;
end;

//============================================================================
// add new RNAM
function AddRNAM(wrld, e: IInterface): IInterface;
var 
  Cell: IInterface;
  Grid: TwbGridCell;
begin
  Result := nil;
  Cell := LinksTo(ElementByPath(e, 'Cell'));
  if not Assigned(Cell) then
    Exit;
  Grid := GetGridCell(Cell);

  if not ElementExists(wrld, 'RNAM') then begin
    Result := ElementByPath(Add(wrld, 'RNAM', True), 'RNAM');
  end
  else begin
    Result := ElementAssign(ElementByPath(wrld, 'RNAM'), HighInteger, nil, False);
  end

  BeginUpdate(Result);
  try
    SetElementNativeValues(Result, 'X', Grid.x);
    SetElementNativeValues(Result, 'Y', Grid.y);
    AddRNAMItem(Result, e);
  finally
    EndUpdate(Result);
  end;
end;

//============================================================================
procedure UpdateWorldspace(wrld: IInterface);
var
  i, j: integer;
  s: string;
  e, rnam: IInterface;
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

    BeginUpdate(rnam);
    try
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
    finally
      EndUpdate(rnam);
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
    frm.Width := 1000;
    frm.Height := 1000;
    frm.Position := poMainFormCenter;
    frm.BorderStyle := bsDialog;
    frm.KeyPreview := True;

    cbPlugin := TComboBox.Create(frm); cbPlugin.Parent := frm;
    cbPlugin.Left := 54;
    cbPlugin.Top := 12;
    cbPlugin.Width := 500;
    cbPlugin.Style := csDropDownList;
    cbPlugin.DropDownCount := 20;
    cbPlugin.OnSelect := UpdatecbWorld;
    CreateLabel(frm, 16, cbPlugin.Top + 4, 'Plugin');

    FillPlugins(cbPlugin);
    if cbPlugin.Items.Count > 0 then cbPlugin.ItemIndex := 0;
    if cbPlugin.Items.Count = 2 then cbPlugin.ItemIndex := 1;
    
    cbWorld := TComboBox.Create(frm); cbWorld.Parent := frm;
    cbWorld.Left := 54;
    cbWorld.Top := cbPlugin.Top + cbPlugin.Height + 16;
    cbWorld.Width := 500;
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
    frm.Height := btnOk.Top + btnOk.Height + 64;

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
  try
    if (wbGameMode <> gmSSE) then begin
      AddMessage('Game not supported');
      Exit;
    end;

    wrld := OptionsForm;
    if Assigned(wrld) then begin
      BeginUpdate(wrld);
      try
        GenerateWorldspace(wrld);
      finally
        EndUpdate(wrld);
      end;
    end;
  finally
    slLargeReferences.Free;
  end;

end;

end.
