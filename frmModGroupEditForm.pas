{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

unit frmModGroupEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, Menus,
  Vcl.Styles.Utils.SystemMenu, VirtualTrees, VirtualEditTree,
  wbInterface, wbLoadOrder, wbModGroups, Vcl.ExtCtrls;

type
  TfrmModGroupEdit = class(TForm)
    btnOK: TButton;
    vstModGroupItems: TVirtualStringTree;
    pnlError: TPanel;
    edName: TLabeledEdit;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure vstModGroupItemsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstModGroupItemsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstModGroupItemsIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure vstModGroupItemsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure vstModGroupItemsNodeClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
    procedure edNameChange(Sender: TObject);
    procedure edNameKeyPress(Sender: TObject; var Key: Char);
    procedure edNameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    procedure CheckState;
    procedure TagContainedModules(aExclude: Boolean);
  public
    ModGroup : PwbModGroup;

    procedure AllowCancel;
    function ShowModal: Integer; override;
  end;

  PModGroupItemNodeData = ^TModGroupNodeData;
  TModGroupNodeData = record
    mgindModGroupItemPtr : PwbModGroupItem;
    mgindModGroupItem    : TwbModGroupItem;
  end;

implementation

{$R *.dfm}

uses
  Vcl.Clipbrd,
  frmModuleSelectForm,
  frmViewMain,
  StrUtils;

procedure TfrmModGroupEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CheckState;
end;

procedure TfrmModGroupEdit.FormCreate(Sender: TObject);
begin
  wbApplyFontAndScale(Self);

  with TVclStylesSystemMenu.Create(Self) do begin
    ShowNativeStyle := True;
    MenuCaption := 'Theme';
  end;

  vstModGroupItems.IncrementalSearch := isVisibleOnly;
  vstModGroupItems.NodeDataSize := SizeOf(TModGroupNodeData);
end;

procedure TfrmModGroupEdit.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Node: PVirtualNode;
begin
  if Key = VK_RETURN then begin
    if edName.Focused then begin
      vstModGroupItems.SetFocus;
      Exit;
    end;
    CheckState;
    if btnOK.Enabled then
      btnOK.Click;
  end else if Key = VK_ESCAPE then begin
    if btnCancel.Enabled then
      btnCancel.Click;
  end;
end;

procedure TfrmModGroupEdit.FormShow(Sender: TObject);
var
  Node: PVirtualNode;
begin
  CheckState;
  vstModGroupItems.FocusedNode := nil;
  vstModGroupItems.ClearSelection;
  for Node in vstModGroupItems.CheckedNodes do begin
    if not Assigned(vstModGroupItems.FocusedNode) then
      vstModGroupItems.FocusedNode := Node;
    vstModGroupItems.Selected[Node] := True;
    Break;
  end;
  if not Assigned(vstModGroupItems.FocusedNode) then begin
    vstModGroupItems.FocusedNode := vstModGroupItems.GetFirstVisible;
    vstModGroupItems.Selected[vstModGroupItems.FocusedNode] := True;
  end;
  if edName.Text = '' then
    edName.SetFocus
  else
    vstModGroupItems.SetFocus;
end;

procedure TfrmModGroupEdit.AllowCancel;
var
  Left: Integer;
begin
  btnCancel.Enabled := True;
  btnCancel.Visible := True;
  Left := btnCancel.Left;
  btnCancel.Left := btnOK.Left;
  btnOK.Left := Left;
end;

function TfrmModGroupEdit.ShowModal: Integer;
var
  i        : Integer;
  Node     : PVirtualNode;
  NodeData : PModGroupItemNodeData;
begin
  vstModGroupItems.Clear;

  with ModGroup^ do
    for i := Low(mgItems) to High(mgItems) do
      vstModGroupItems.AddChild(nil, @mgItems[i]);

  vstModGroupItems.InitRecursive(nil, 100, False);

  edName.Text := ModGroup.mgName;

  if Length(ModGroup.mgItems) < 2 then
    Result := mrCancel
  else
    Result := inherited ShowModal;

  if Result = mrOk then begin
    CheckState;
    if btnOK.Enabled then begin
      ModGroup.mgName := edName.Text;
      SetLength(ModGroup.mgItems, vstModGroupItems.ChildCount[nil]);
      i := 0;
      Node := vstModGroupItems.GetFirst;
      while Assigned(Node) do begin
        NodeData := vstModGroupItems.GetNodeData(Node);
        ModGroup.mgItems[i] := NodeData.mgindModGroupItem;
        Inc(i);
        Node := vstModGroupItems.GetNextSibling(Node);
      end;
      SetLength(ModGroup.mgItems, i);
    end else
      Result := mrCancel;
  end;
end;

procedure TfrmModGroupEdit.TagContainedModules(aExclude: Boolean);
var
  Node     : PVirtualNode;
  NodeData : PModGroupItemNodeData;
begin
  Node := vstModGroupItems.GetFirst;
  while Assigned(Node) do begin
    NodeData := vstModGroupItems.GetNodeData(Node);
    with NodeData.mgindModGroupItem do
      if Assigned(mgiModule) then
        if aExclude then
          Exclude(mgiModule.miFlags, mfEphemeralModGroupTagged)
        else
          Include(mgiModule.miFlags, mfEphemeralModGroupTagged);
    Node := vstModGroupItems.GetNextSibling(Node);
  end;
end;

procedure TfrmModGroupEdit.CheckState;
var
  Error         : string;
begin
  Error := '';
  try
    if edName.Text = '' then
      Error := 'Name is empty'
    else
      if vstModGroupItems.ChildCount[nil] < 2 then
        Error := 'ModGroup needs to contain at least 2 items';
  except
    on E: Exception do
      Error := E.Message;
  end;


  btnOK.Enabled := Error = '';
  if btnOK.Enabled then
    pnlError.Caption := ''
  else
    pnlError.Caption := 'Error: ' + Error;
  pnlError.Visible := not btnOK.Enabled;

  vstModGroupItems.Invalidate;
end;

procedure TfrmModGroupEdit.edNameChange(Sender: TObject);
begin
  CheckState;
end;

procedure TfrmModGroupEdit.edNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DOWN then
    vstModGroupItems.SetFocus;
end;

procedure TfrmModGroupEdit.edNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #0;
end;

procedure TfrmModGroupEdit.vstModGroupItemsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
begin
  Celltext := '';
  with PModGroupItemNodeData(Sender.GetNodeData(Node))^ do begin
    with mgindModGroupItem do
      case Column of
        0 : CellText := mgiFileName;
        1 : if mgifOptional in mgiFlags then Celltext := 'Optional';
        2 : if mgifIsTarget in mgiFlags then Celltext := 'Target';
        3 : if mgifIsSource in mgiFlags then Celltext := 'Source';
        4 : if mgifForbidden in mgiFlags then Celltext := 'Forbidden';
        5 : if mgifIgnoreLoadOrderAlways in mgiFlags then
              Celltext := 'Always'
            else if mgifIgnoreLoadOrderInBlock in mgiFlags then
              Celltext := 'in Block';
        6 : if Assigned(mgiModule) then
              if mgiModule.miLoadOrder < High(Integer) then
                CellText := mgiModule.miLoadOrder.ToString;
      end;
  end;
end;

procedure TfrmModGroupEdit.vstModGroupItemsIncrementalSearch(Sender: TBaseVirtualTree;
  Node: PVirtualNode; const SearchText: string; var Result: Integer);
var
  CompareText                 : string;
  i: Integer;
begin
  Result := 1;
  CompareText := '';

  if (Node.Parent = nil) or (Node.Parent = Sender.RootNode) then
    with PModGroupItemNodeData(Sender.GetNodeData(Node))^ do
      CompareText := mgindModGroupItem.mgiFileName;

  if Length(SearchText) > Length(CompareText) then
    Exit;

  for i := 1 to Length(SearchText) do
    if UpCase(SearchText[i]) <> UpCase(CompareText[i]) then
      Exit;

  Result := 0;
end;

procedure TfrmModGroupEdit.vstModGroupItemsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  NodeData: PModGroupItemNodeData;
  ParentNodeData: PModGroupItemNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  with NodeData^ do begin
    if Assigned(mgindModGroupItemPtr) then begin
      mgindModGroupItem := mgindModGroupItemPtr^;
      mgindModGroupItemPtr := nil;
    end;
  end;
end;

procedure TfrmModGroupEdit.vstModGroupItemsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  HitInfo      : THitInfo;
  NodeData     : PModGroupItemNodeData;
  ModGroupItem : TwbModGroupItem;
  Mode         : TVTNodeAttachMode;
  TargetNode   : PVirtualNode;
begin
  HitInfo.HitNode := vstModGroupItems.FocusedNode;
  HitInfo.HitColumn := vstModGroupItems.FocusedColumn;
  NodeData := vstModGroupItems.GetNodeData(HitInfo.HitNode);
  case Key of
    VK_DELETE: begin
      Key := 0;
      if Assigned(NodeData) then
        if (ssShift in Shift) or (MessageDlg('Do you want to delete "'+NodeData.mgindModGroupItem.mgiFileName+'" from this ModGroup?', mtConfirmation, mbYesNo, 0, mbNo) = mrYes) then
          vstModGroupItems.DeleteNode(HitInfo.HitNode);
    end;
    VK_INSERT: begin
      Key := 0;
      with TfrmModuleSelect.Create(Self) do try
        AllModules := wbModulesByLoadOrder;
        SelectFlag := mfTagged;
        FilterFlag := mfEphemeralModGroupTagged;
        AllModules.IncludeAll(mfEphemeralModGroupTagged);
        AllModules.ExcludeAll(mfTagged);
        TagContainedModules(True);
        MaxSelect := 1;
        MinSelect := 1;
        if ShowModal = mrOk then begin
          FillChar(ModGroupItem, SizeOf(TwbModGroupItem), 0);
          ModGroupItem.mgiModule := SelectedModules[0];
          ModGroupItem.mgiFileName := ModGroupItem.mgiModule.miName;
          ModGroupItem.mgiFlags := [mgifIsTarget, mgifIsSource];
        end else
          Exit;
      finally
        Free;
      end;

      Mode := amNoWhere;
      if Shift = [ssShift] then
        Mode := amInsertBefore
      else if Shift = [ssCtrl] then
        Mode := amInsertAfter
      else begin
        HitInfo.HitNode := vstModGroupItems.GetFirst;
        while Assigned(HitInfo.HitNode) do begin
          NodeData := vstModGroupItems.GetNodeData(HitInfo.HitNode);
          with NodeData.mgindModGroupItem do
            if Assigned(mgiModule) then
              if mgiModule.miLoadOrder > ModGroupItem.mgiModule.miLoadOrder then begin
                Mode := amInsertBefore;
                Break;
              end;
          HitInfo.HitNode := vstModGroupItems.GetNext(HitInfo.HitNode);
        end;
      end;
      if Mode = amNoWhere then begin
        HitInfo.HitNode := vstModGroupItems.GetLast;
        Mode := amInsertAfter;
      end;

      vstModGroupItems.FocusedNode := vstModGroupItems.InsertNode(HitInfo.HitNode, Mode, @ModGroupItem);
      vstModGroupItems.ClearSelection;
    end;
    VK_UP: if Shift = [ssCtrl] then begin
      TargetNode := vstModGroupItems.GetPreviousSibling(HitInfo.HitNode);
      if Assigned(TargetNode) then
        vstModGroupItems.MoveTo(HitInfo.HitNode, TargetNode, amInsertBefore, False);
    end else if Shift = [] then begin
      if HitInfo.HitNode = vstModGroupItems.GetFirstVisible then
        edName.SetFocus;
    end;
    VK_DOWN: if Shift = [ssCtrl] then begin
      TargetNode := vstModGroupItems.GetNextSibling(HitInfo.HitNode);
      if Assigned(TargetNode) then
        vstModGroupItems.MoveTo(HitInfo.HitNode, TargetNode, amInsertAfter, False);
    end;
    Ord('C'): if Shift = [ssCtrl] then begin
      Key := 0;
      if Assigned(NodeData) then
        Clipboard.AsText := NodeData.mgindModGroupItem.mgiFileName;
    end;
    Ord('N'): if Shift = [ssCtrl] then begin
      Key := 0;
      if Assigned(NodeData) then
        edName.Text := ChangeFileExt(NodeData.mgindModGroupItem.mgiFileName, '');
    end;
    Ord(' '): begin
      Key := 0;
      if Assigned(NodeData) then
        vstModGroupItemsNodeClick(vstModGroupItems, HitInfo);
    end;
  end;
end;

procedure TfrmModGroupEdit.vstModGroupItemsNodeClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
var
  NodeData: PModGroupItemNodeData;
begin
  with HitInfo do begin
    if not Assigned(HitNode) then
      Exit;
    NodeData := vstModGroupItems.GetNodeData(HitNode);
    if not Assigned(NodeData) then
      Exit;
    with NodeData.mgindModGroupItem do
      case HitColumn of

        1 : if mgifOptional in mgiFlags then
              Exclude(mgiFlags, mgifOptional)
            else begin
              Include(mgiFlags, mgifOptional);
              Exclude(mgiFlags, mgifForbidden)
            end;

        2 : if mgifIsTarget in mgiFlags then
              Exclude(mgiFlags, mgifIsTarget)
            else
              Include(mgiFlags, mgifIsTarget);

        3 : if mgifIsSource in mgiFlags then
              Exclude(mgiFlags, mgifIsSource)
            else
              Include(mgiFlags, mgifIsSource);

        4 : if mgifForbidden in mgiFlags then
              Exclude(mgiFlags, mgifForbidden)
            else begin
              Include(mgiFlags, mgifForbidden);
              Exclude(mgiFlags, mgifOptional)
            end;

        5 : if mgifIgnoreLoadOrderAlways in mgiFlags then begin
              Exclude(mgiFlags, mgifIgnoreLoadOrderAlways);
              Include(mgiFlags, mgifIgnoreLoadOrderInBlock);
            end else if mgifIgnoreLoadOrderInBlock in mgiFlags then begin
              Exclude(mgiFlags, mgifIgnoreLoadOrderInBlock);
            end else begin
              Include(mgiFlags, mgifIgnoreLoadOrderAlways);
            end;
      end;
    vstModGroupItems.InvalidateNode(HitNode);
    CheckState;
  end;
end;

end.
