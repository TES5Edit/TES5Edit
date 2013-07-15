{
  Assets browser.
  
  Hotkey: Ctrl+F3
}

unit userscript;

var
  slContainers: TStringList;
  slAssets, slItems: TwbFastStringList;
  frm: TForm;
  edFilter: TLabeledEdit;
  lblItems: TLabel;
  lvAssets: TListView;

//===========================================================================
// listview custom data event
procedure lvAssetsData(Sender: TObject; Item: TListItem);
begin
  Item.Caption := slItems[Item.Index];
end;

//===========================================================================
procedure FilterAssets;
var
  filter: string;
begin
  slItems.Clear;
  filter := LowerCase(edFilter.Text);

  if filter = '' then
    slItems.AddStrings(slAssets)
  else
    wbFilterStrings(slAssets, slItems, filter);

  lvAssets.Items.Count := slItems.Count;
  lvAssets.Refresh;
  lblItems.Caption := Format('Items: %d', [slItems.Count]);
end;

//===========================================================================
// on key down event handler for filter
procedure edFilterOnChange(Sender: TObject);
begin
  FilterAssets;
end;
  
//===========================================================================
function Initialize: integer;
var
  i: Integer;
begin
  slContainers := TStringList.Create;
  ResourceContainerList(slContainers);
  
  slAssets := TwbFastStringList.Create;
  slAssets.Sorted := True;
  slAssets.Duplicates := dupIgnore;

  slItems := TwbFastStringList.Create;
  
  for i := 0 to 0 do
  //for i := 0 to Pred(slContainers.Count) do
    ResourceList(slContainers[i], slAssets);
  
  frm := TForm.Create(nil);
  try
    frm.Caption := 'Assets browser';
    frm.Width := 900;
    frm.Height := 500;
    frm.Position := poScreenCenter;
    //frm.BorderStyle := bsDialog;
    //frm.KeyPreview := True;
    //frm.OnKeyDown := FormKeyDown;

    edFilter := TLabeledEdit.Create(frm);
    edFilter.Parent := frm;
    edFilter.LabelPosition := lpLeft;
    edFilter.EditLabel.Caption := 'Filter';
    edFilter.Left := 36;
    edFilter.Top := 8;
    edFilter.Width := 150;
    edFilter.OnChange := edFilterOnChange;

    lvAssets := TListView.Create(frm);
    lvAssets.Parent := frm;
    lvAssets.Left := 8;
    lvAssets.Top := 34;
    lvAssets.Width := 700;
    lvAssets.Height := 350;
    lvAssets.Anchors := [akLeft, akTop, akRight];
    lvAssets.ViewStyle := vsReport;
    lvAssets.Columns.Add.Caption := 'Name';
    lvAssets.Columns[0].Width := lvAssets.Width - 40;
    lvAssets.OwnerData := True;
    lvAssets.OnData := lvAssetsData;
    
    lblItems := TLabel.Create(frm);
    lblItems.Parent := frm;
    lblItems.Top := 8;
    lblItems.Left := lvAssets.Left + lvAssets.Width - 80;
    lblItems.Anchors := [akTop, akRight];
    
    FilterAssets;

    frm.ShowModal;
  finally
    frm.Free;
  end;

{  ResourceContainerList(sl);
  AddMessage(sl.Text);
  
  d := ResourceOpenData('meshes\effects\fxdripssplash01.nif', 0);
  AddMessage(IntToStr(Length(d)));
  
  NifTextureList(d, sl);
  }
 
  slAssets.Free;
  slItems.Free;
  slContainers.Free;
  Result := 1;
end;

end.