{
  Visual workshop menu editor for Fallout 4
  Allows to edit workshop menues based on form list FLST records which
  contain other form lists or keyword KYWD records linked by COBJ recipes.
  
  Apply to menu FLST record, for example WorkshopMenuMain "Main Menu" [FLST:00106DA2]
  When editing vanilla menues, copy them as override into a plugin,
  apply script to edit there, then remove unchanged records using ITM clean menu of xEdit.
  
  Drag&drop nodes in the left tree to rearrange tree structure.
  Hold Shift when dragging to move a node as a child to other form list node.
  Right click for additional options (add, remove, edit).
  Press * to full expand.
  
  Right panel lists COBJ recipes linked to keyword of the selected node.
  Requires built references (in xEdit right click -> Other -> Build Reference Info menu).
  Drag&drop recipe over the keyword node in the left tree to move (relink)
  recipe to another keyword.
}
unit Fallout4WorkshopMenuEditor;

var
  TopFLST: IInterface;
  frm: TForm;
  tvList: TTreeView;
  lbRefs: TListBox;
  NodeNameMode: integer;


//===========================================================================
procedure UpdateNodeFLST(aNode: TTreeNode);
var
  flst, entries, entry: IInterface;
  rec: string;
  i: integer;
begin
  if not Assigned(aNode) then
    Exit;

  flst := ObjectToElement(aNode.Data);
  entries := ElementByName(flst, 'FormIDs');
  if not Assigned(entries) then
    entries := Add(flst, 'FormIDs', True);

  for i := 0 to Pred(aNode.Count) do begin
    if i = ElementCount(entries) then
      entry := ElementAssign(entries, HighInteger, nil, False)
    else
      entry := ElementByIndex(entries, i);
    
    rec := Name(ObjectToElement(aNode.Item[i].Data));
    if GetEditValue(entry) <> rec then
      SetEditValue(entry, rec);
  end;
  
  while ElementCount(entries) > aNode.Count do
    RemoveByIndex(entries, Pred(ElementCount(entries)), True);
end;

//===========================================================================
procedure TreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  Src, Dst, SrcParent: TTreeNode;
  cobj, keywords, kold, knew: IInterface;
  i: integer;
begin
  Src := tvList.Selected;
  Dst := tvList.GetNodeAt(X,Y);

  // dragged COBJ over keyword, update COBJ
  if Source = lbRefs then begin
    cobj := ObjectToElement(lbRefs.Items.Objects[lbRefs.ItemIndex]);
    keywords := ElementBySignature(cobj, 'FNAM');
    kold := ObjectToElement(Src.Data);
    knew := ObjectToElement(Dst.Data);
    for i := 0 to Pred(ElementCount(keywords)) do
      if GetEditValue(ElementByIndex(keywords, i)) = Name(kold) then begin
        SetEditValue(ElementByIndex(keywords, i), Name(knew));
        Break;
      end;
    TreeViewChange(nil, Src);
    Exit;
  end;

  // store the Parent (FLST) of dragged node to update later
  // because after the MoveTo it could be lost when moved under a different parent
  // and we need to update it later
  SrcParent := Src.Parent;
  
  // if Shift is pressed to insert as a child
  if GetKeyState(VK_SHIFT) < 0 then begin
    // append dragged node as a child of destination node
    Src.MoveTo(Dst, naAddChild);
    // update the list we moved from
    UpdateNodeFLST(SrcParent);
    // update destination list
    UpdateNodeFLST(Dst);
    Exit;
  end

  // Shift is not pressed
  else    
    // not dragging over the node below us, insert after the destination node
    if Dst <> Src.GetNextSibling then
      Src.MoveTo(Dst, naInsert)
    // otherwise insert destination node after us (swap positions)
    else
      Dst.MoveTo(Src, naInsert);
  
  // update dragged node's former parent
  UpdateNodeFLST(SrcParent);
  // if we moved under a different parent then update it too
  if Dst.Parent <> SrcParent then
    UpdateNodeFLST(Dst.Parent);
end;

//===========================================================================
procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  Src, Dst: TTreeNode;
begin
  Src := tvList.Selected;
  Dst := tvList.GetNodeAt(X,Y);
  Accept := Assigned(Dst) and (Src <> Dst);

  // when dragging from COBJs list, can drag over keywords only
  if Accept and (Source = lbRefs) then begin
    Accept := Signature(ObjectToElement(Dst.Data)) = 'KYWD';
    Exit;
  end;
  
  // don't drag to the root level
  if Accept then
    Accept := Dst.Level <> 0;
  
  // don't drag over KYWD when Shift is pressed
  if Accept then
    if (GetKeyState(VK_SHIFT) < 0) and (Signature(ObjectToElement(Dst.Data)) <> 'FLST') then
      Accept := False;
end;

//===========================================================================
procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
var
  e, r: IInterface;
  i: integer;
begin
  if not Assigned(Node) then
    Exit;
  
  lbRefs.Clear;
  
  e := MasterOrSelf(ObjectToElement(Node.Data));
  if Signature(e) <> 'KYWD' then
    Exit;
  
  for i := 0 to Pred(ReferencedByCount(e)) do begin
    r := WinningOverride(ReferencedByIndex(e, i));
    if Signature(r) = 'COBJ' then
      lbRefs.Items.AddObject(EditorID(r), r);
  end;
end;

//===========================================================================
procedure TreeViewDblClick(Sender: TObject);
begin
  if Assigned(tvList.Selected) then
    JumpTo(ObjectToElement(tvList.Selected.Data), False);
end;

//===========================================================================
// on key down event handler for form
procedure TreeViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
    MenuRemoveClick(nil);
end;

//===========================================================================
procedure lbRefsDblClick(Sender: TObject);
begin
  if lbRefs.ItemIndex <> -1 then
    JumpTo(ObjectToElement(lbRefs.Items.Objects[lbRefs.ItemIndex]), False);
end;

//===========================================================================
procedure UpdateNodeText(aNode: TTreeNode);
begin
  if NodeNameMode = 0 then aNode.Text := GetElementEditValues(ObjectToElement(aNode.Data), 'FULL') else
  if NodeNameMode = 1 then aNode.Text := EditorID(ObjectToElement(aNode.Data)) else
  if NodeNameMode = 2 then aNode.Text := Name(ObjectToElement(aNode.Data));
end;

//===========================================================================
procedure rbNameClick(Sender: TObject);
var
  i: integer;
  node: TTreeNode;
begin
  NodeNameMode := TRadioButton(Sender).Tag;

  tvList.Items.BeginUpdate;
  for i := 0 to Pred(tvList.Items.Count) do
    UpdateNodeText(tvList.Items.Item(i));
  tvList.Items.EndUpdate;
  tvList.SetFocus;
end;

//===========================================================================
function EditEditorIDandName(var aEditorID, aName: WideString): Boolean;
begin
  repeat
    Result := InputQuery('Enter', 'Editor ID', aEditorID);
    if not Result then Exit;
  until aEditorID <> '';
  
  Result := InputQuery('Enter', 'Name', aName);
end;

//===========================================================================
// Edit popup menu click
procedure MenuEditClick(Sender: TObject);
var
  e: IInterface;
  edid, fullname: WideString;
begin
  e := ObjectToElement(tvList.Selected.Data);
  edid := EditorID(e);
  fullname := GetElementEditValues(e, 'FULL');
  if not EditEditorIDandName(edid, fullname) then
    Exit;

  if edid <> EditorID(e) then
    SetElementEditValues(e, 'EDID', edid);
  if fullname <> GetElementEditValues(e, 'FULL') then
    SetElementEditValues(e, 'FULL', fullname);
  
  UpdateNodeText(tvList.Selected);
end;

//===========================================================================
// Remove popup menu click
procedure MenuRemoveClick(Sender: TObject);
var
  Parent: TTreeNode;
begin
  Parent := tvList.Selected.Parent;
  if not Assigned(Parent) then Exit;
  if Parent.Count = 1 then begin
    ShowMessage('Can not remove the last remaining item from the list, remove the list itself instead');
    Exit;
  end;
  tvList.Selected.Delete;
  UpdateNodeFLST(Parent);
end;

//===========================================================================
// Add existing keyword popup menu click
procedure MenuAddKeywordClick(Sender: TObject);
var
  g, e: IInterface;
  sl: TStringList;
  sel, n: TTreeNode;
  i: integer;
  frm: TForm;
  clb: TCheckListBox;
begin
  frm := frmFileSelect;
  frm.Width := 500;
  try
    frm.Caption := 'Select keyword(s) to add';
    clb := TCheckListBox(frm.FindComponent('CheckListBox1'));
    g := GroupBySignature(GetFile(TopFLST), 'KYWD');
    sl := TStringList.Create;
    for i := 0 to Pred(ElementCount(g)) do begin
      e := ElementByIndex(g, i);
      if GetElementEditValues(e, 'TNAM') = 'Recipe Filter' then
        sl.AddObject(EditorID(e), e);
    end;
    sl.Sort;
    clb.Items.Assign(sl);
    sl.Free;

    if frm.ShowModal <> mrOk then Exit;

    sel := tvList.Selected;
    tvList.Items.BeginUpdate;
    for i := 0 to Pred(clb.Items.Count) do
      if clb.Checked[i] then begin
        e := ObjectToElement(clb.Items.Objects[i]);
        n := tvList.Items.AddChildObject(sel.Parent, '', e);
        UpdateNodeText(n);
        n.MoveTo(sel, naInsert);
      end;
    tvList.Items.EndUpdate;
    UpdateNodeFLST(sel.Parent);
  finally
    frm.Free;
  end;
end;

//===========================================================================
// Add new keyword popup menu click
procedure MenuAddNewKeywordClick(Sender: TObject);
var
  e: IInterface;
  n: TTreeNode;
  edid, fullname: WideString;
begin
  edid := 'NewEditorID';
  fullname := 'NewName';
  if not EditEditorIDandName(edid, fullname) then
    Exit;

  // use WorkshopAlwaysShowIconKeyword [KYWD:00237B63] as a template
  e := RecordByFormID(FileByIndex(0), $00237B63, False);
  e := wbCopyElementToFile(e, GetFile(TopFLST), True, True);
  SetElementEditValues(e, 'EDID', edid);
  if fullname <> '' then
    SetElementEditValues(e, 'FULL', fullname);

  n := tvList.Items.AddChildObject(tvList.Selected.Parent, '', e);
  n.MoveTo(tvList.Selected, naInsert);
  UpdateNodeText(n);
end;

//===========================================================================
// Add existing list popup menu click
procedure MenuAddListClick(Sender: TObject);
var
  g, e: IInterface;
  sl: TStringList;
  sel, n: TTreeNode;
  i: integer;
  frm: TForm;
  clb: TCheckListBox;
begin
  frm := frmFileSelect;
  frm.Width := 500;
  try
    frm.Caption := 'Select list(s) to add';
    clb := TCheckListBox(frm.FindComponent('CheckListBox1'));
    g := GroupBySignature(GetFile(TopFLST), 'FLST');
    sl := TStringList.Create;
    for i := 0 to Pred(ElementCount(g)) do begin
      e := ElementByIndex(g, i);
      sl.AddObject(EditorID(e), e);
    end;
    sl.Sort;
    clb.Items.Assign(sl);
    sl.Free;
    
    if frm.ShowModal <> mrOk then Exit;
    
    sel := tvList.Selected;
    tvList.Items.BeginUpdate;
    for i := 0 to Pred(clb.Items.Count) do
      if clb.Checked[i] then begin
        e := ObjectToElement(clb.Items.Objects[i]);
        n := BuildMenuTree(e, sel.Parent);
        n.MoveTo(sel, naInsert);
      end;
    tvList.Items.EndUpdate;
    UpdateNodeFLST(sel.Parent);
  finally
    frm.Free;
  end;
end;

//===========================================================================
// Add new list popup menu click
procedure MenuAddNewListClick(Sender: TObject);
var
  e: IInterface;
  n: TTreeNode;
  edid, fullname: WideString;
begin
  edid := 'NewEditorID';
  fullname := 'NewName';
  if not EditEditorIDandName(edid, fullname) then
    Exit;

  e := Add(GroupBySignature(GetFile(TopFLST), 'FLST'), 'FLST', True);
  
  SetElementEditValues(e, 'EDID', edid);
  if fullname <> '' then
    SetElementEditValues(e, 'FULL', fullname);

  n := tvList.Items.AddChildObject(tvList.Selected.Parent, '', e);
  n.MoveTo(tvList.Selected, naInsert);
  UpdateNodeText(n);
end;

//===========================================================================
// on popup menu event handler
procedure MenuPopup(Sender: TObject);
var
  mnPopup: TPopupMenu;
  MenuItem: TMenuItem;
begin
  mnPopup := TPopupMenu(Sender);
  mnPopup.Items.Clear;
  if not Assigned(tvList.Selected) then
    Exit;

  // focus the right click selected node
  tvList.Selected := tvList.Selected;
  
  // can't add/remove from the root node
  if tvList.Selected.Level > 0 then begin
    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := 'Add existing keyword(s)';
    MenuItem.OnClick := MenuAddKeywordClick;
    mnPopup.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := 'Add new keyword';
    MenuItem.OnClick := MenuAddNewKeywordClick;
    mnPopup.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := '-';
    mnPopup.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := 'Add existing list(s)';
    MenuItem.OnClick := MenuAddListClick;
    mnPopup.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := 'Add new list';
    MenuItem.OnClick := MenuAddNewListClick;
    mnPopup.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := '-';
    mnPopup.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(mnPopup);
    MenuItem.Caption := 'Remove';
    MenuItem.OnClick := MenuRemoveClick;
    mnPopup.Items.Add(MenuItem);
  end;

  MenuItem := TMenuItem.Create(mnPopup);
  MenuItem.Caption := 'Edit';
  MenuItem.OnClick := MenuEditClick;
  mnPopup.Items.Add(MenuItem);
end;

//===========================================================================
function BuildMenuTree(e: IInterface; aNode: TTreeNode): TTreeNode;
var
  i: integer;
  entries: IInterface;
begin
  Result := tvList.Items.AddChildObject(aNode, '', e);
  UpdateNodeText(Result);

  if Signature(e) = 'FLST' then begin
    entries := ElementByName(e, 'FormIDs');
    for i := 0 to Pred(ElementCount(entries)) do
      BuildMenuTree(WinningOverride(LinksTo(ElementByIndex(entries, i))), Result);
  end;
end;

//===========================================================================
procedure MenuEditor(e: IInterface);
var
  pnl: TPanel;
  sp: TSplitter;
  rbName, rbEDID, rbRec: TRadioButton;
  mnPopup: TPopupMenu;
begin
  frm := TForm.Create(nil);
  try
    frm.Caption := wbGameName + ' Workshop Menu Editor';
    frm.Width := 850;
    frm.Height := 700;
    frm.Position := poScreenCenter;
    frm.PopupMode := pmAuto;

    pnl := TPanel.Create(frm); pnl.Parent := frm;
    pnl.Height := 28;
    pnl.Align := alTop;
    pnl.BevelOuter := bvNone;
    
    rbName := TRadioButton.Create(frm); rbName.Parent := pnl;
    rbName.Left := 8;
    rbName.Top := 4;
    rbName.Width := 60;
    rbName.Caption := 'Name';
    rbName.Checked := True;
    rbName.OnClick := rbNameClick;

    rbEDID := TRadioButton.Create(frm); rbEDID.Parent := pnl;
    rbEDID.Left := rbName.Left + rbName.Width + 12;;
    rbEDID.Top := rbName.Top;
    rbEDID.Width := 60;
    rbEDID.Caption := 'EditorID';
    rbEDID.Tag := 1;
    rbEDID.OnClick := rbNameClick;
    
    rbRec := TRadioButton.Create(frm); rbRec.Parent := pnl;
    rbRec.Left := rbEDID.Left + rbEDID.Width + 12;;
    rbRec.Top := rbName.Top;
    rbRec.Width := 60;
    rbRec.Caption := 'Record';
    rbRec.Tag := 2;
    rbRec.OnClick := rbNameClick;

    lbRefs := TListBox.Create(frm); lbRefs.Parent := frm;
    lbRefs.Align := alRight;
    lbRefs.DragMode := dmAutomatic;
    lbRefs.BorderStyle := bsNone;
    lbRefs.Width := 350;
    lbRefs.OnDblClick := lbRefsDblClick;
    
    sp := TSplitter.Create(frm); sp.Parent := frm;
    sp.Align := alRight;
    sp.Width := 5;

    tvList := TTreeView.Create(frm); tvList.Parent := frm;
    tvList.Align := alClient;
    tvList.DragMode := dmAutomatic;
    tvList.BorderStyle := bsNone;
    tvList.ShowLines := False;
    tvList.RowSelect := True;
    tvList.ToolTips := False;
    tvList.HotTrack := True;
    tvList.RightClickSelect := True;
    tvList.ReadOnly := True;
    tvList.OnDragDrop := TreeViewDragDrop;
    tvList.OnDragOver := TreeViewDragOver;
    tvList.OnChange := TreeViewChange;
    tvList.OnDblClick := TreeViewDblClick;
    tvList.OnKeyDown := TreeViewKeyDown;
    
    mnPopup := TPopupMenu.Create(frm);
    mnPopup.OnPopup := MenuPopup;
    tvList.PopupMenu := mnPopup;

    TopFLST := e;
    BuildMenuTree(TopFLST, nil);
    tvList.Items.GetFirstNode.Expand(False);
    
    frm.ShowModal;
  finally
    frm.Free;
  end;
end;

//===========================================================================
function Process(e: IInterface): integer;
begin
  if Signature(e) <> 'FLST' then
    Exit;
  
  MenuEditor(e);
  Result := 1;
end;

end.

end.