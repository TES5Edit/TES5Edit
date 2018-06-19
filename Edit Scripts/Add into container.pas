{
  Add selected records into existing or new container (CONT record)
  
  If you need to add into existing vanilla containers, then copy them as override
  and set bSamePlugin = False
}
unit AddIntoContainer;

const
  // when True  then container record will be created in the same plugin as selected records
  // when False then container will be created in the last loaded plugin
  bSamePlugin = False;
  
  // template records to use for new containers
  iFO4ContainerTemplate  = $000A1213; // InstM01BillsChest "Chest" [CONT:000A1213]
  iTES5ContainerTemplate = $0001D13C; // TreasUpperChestEMPTY "Chest" [CONT:0001D13C]
  iFNVContainerTemplate  = $00124824; // CrateShippingEmpty "Crate" [CONT:00124824]
  iFO3ContainerTemplate  = $00096D5E; // MetalBox01Empty "Metal Box" [CONT:00096D5E]
  iTES4ContainerTemplate = $000086C1; // ChestClutterLower01Empty "Chest" [CONT:000086C1]
  
  // custom counts for different record types, default is 1
  sCounts = 'AMMO=50,ALCH=10';
  // max allowed number of items
  iMaxItems = 255;
  

var
  Container: IInterface;
  slCounts: TStringList;

function SelectOrCreateContainer(f: IInterface): IInterface;
var
  i, tpl: integer;
  frm: TForm;
  clb: TCheckListBox;
  g: IInterface;
  edid: widestring;
begin
  frm := frmFileSelect;
  try
    frm.Caption := 'Add into container';
    clb := TCheckListBox(frm.FindComponent('CheckListBox1'));
    clb.Items.Add('<new container>');
    
    g := GroupBySignature(f, 'CONT');
    for i := 0 to Pred(ElementCount(g)) do
      clb.Items.InsertObject( 1, Name(ElementByIndex(g, i)), ElementByIndex(g, i) );
    
    if frm.ShowModal <> mrOk then
      Exit;
    
    for i := 0 to Pred(clb.Items.Count) do
      if clb.Checked[i] then begin
        // new container
        if i = 0 then begin
          if wbGameMode = gmFO4  then tpl := iFO4ContainerTemplate  else
          if wbGameMode = gmTES5 then tpl := iTES5ContainerTemplate else
          if wbGameMode = gmSSE  then tpl := iTES5ContainerTemplate else
          if wbGameMode = gmFNV  then tpl := iFNVContainerTemplate  else
          if wbGameMode = gmFO3  then tpl := iFO3ContainerTemplate  else
          if wbGameMode = gmTES4 then tpl := iTES4ContainerTemplate else
            Exit;
          
          Result := RecordByFormID(FileByIndex(0), tpl, False);
          if not Assigned(Result) then begin
            AddMessage('Template container record ' + IntToHex(tpl, 8) + ' not found!');
            Exit;
          end;
          
          edid := 'NewContainer';
          if not InputQuery('Enter', 'Container Editor ID', edid) then begin
            Result := nil;
            Exit;
          end;
          
          // copy as new record
          AddRequiredElementMasters(Result, f, False);
          Result := wbCopyElementToFile(Result, f, True, True);
          // set EditorID and remove existing Items if any
          SetElementEditValues(Result, 'EDID', edid);
          RemoveElement(Result, 'Items');
        end
        // existing one
        else
          Result := ObjectToElement(clb.Items.Objects[i]);
        
        Break;
      end;
  
  finally
    frm.Free;
  end;
end;

function Process(e: IInterface): integer;
var
  f, items, item: IInterface;
  i, cnt: Integer;
  p: string;
begin
  if not Assigned(Container) then begin
    if bSamePlugin then
      f := GetFile(e)
    else
      f := FileByIndex(Pred(FileCount));
    
    Container := SelectOrCreateContainer(f);
    if not Assigned(Container) then begin
      AddMessage('No container selected.');
      Result := 1;
      Exit;
    end;
    
    slCounts := TStringList.Create;
    slCounts.CommaText := sCounts;
  end;
  
  if wbGameMode <> gmTES4 then p := 'CNTO\';
  cnt := StrToIntDef(slCounts.Values[Signature(e)], 1);

  items := ElementByName(Container, 'Items');
  if not Assigned(items) then begin
    items := Add(Container, 'Items', False);
    item := ElementByIndex(items, 0);
  end
  else begin
    if ElementCount(items) >= iMaxItems then begin
      AddMessage('Skipped: ' + Name(e) + ' container is full ' + Name(Container));
      Exit;
    end;
    for i := 0 to Pred(ElementCount(items)) do
      if GetElementEditValues( ElementByIndex(items, i), p + 'Item' ) = Name(e) then begin
        AddMessage('Skipped: ' + Name(e) + ' already exists in ' + Name(Container));
        Exit;
      end;
    item := ElementAssign(items, HighInteger, nil, False);
  end;
  
  SetElementEditValues(item, p + 'Item', Name(e));
  SetElementNativeValues(item, p + 'Count', cnt);
  
  AddMessage('Added: ' + Name(e) + ' into ' + Name(Container));
end;

function Finalize: integer;
begin
  if Assigned(slCounts) then
    slCounts.Free;
end;

end.