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
    procedure vstModGroupItemsCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vstModGroupItemsIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure vstModGroupItemsKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure vstModGroupItemsNodeClick(Sender: TBaseVirtualTree;      const HitInfo: THitInfo);
    procedure edNameChange(Sender: TObject);
  protected
    _ModGroup : TwbModGroup;
    procedure CheckState;
  public
    ModGroup : PwbModGroup;

    procedure AllowCancel;
    function ShowModal: Integer; override;
  end;

  PModGroupItemNodeData = ^TModGroupNodeData;
  TModGroupNodeData = record
    mgindModGroupItem : PwbModGroupItem;
    mgindIndex        : Integer;
  end;

implementation

{$R *.dfm}

uses
  Vcl.Clipbrd,
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
  edName.SetFocus;
end;

procedure TfrmModGroupEdit.AllowCancel;
begin
  btnCancel.Enabled := True;
  btnCancel.Visible := True;
end;

function TfrmModGroupEdit.ShowModal: Integer;
begin
  _ModGroup := ModGroup^;
  with _ModGroup do
    mgItems := Copy(mgItems);

  vstModGroupItems.Clear;

  vstModGroupItems.ChildCount[nil] := Length(_ModGroup.mgItems);
  vstModGroupItems.InitRecursive(nil, 100, False);

  edName.Text := _ModGroup.mgName;

  if Length(ModGroup.mgItems) < 2 then
    Result := mrCancel
  else
    Result := inherited ShowModal;

  if Result = mrOk then begin
    CheckState;
    if btnOK.Enabled then begin
      _ModGroup.mgName := edName.Text;
      ModGroup^ := _ModGroup
    end else
      Result := mrCancel;
  end;
end;

procedure TfrmModGroupEdit.CheckState;
var
  Error         : string;
begin
  Error := '';
  try
    if _ModGroup.mgName = '' then
      Error := 'Name is empty';
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
  _ModGroup.mgName := edName.Text;
  CheckState;
end;

procedure TfrmModGroupEdit.vstModGroupItemsCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  NodeData1, NodeData2: PModGroupItemNodeData;
begin
  NodeData1 := Sender.GetNodeData(Node1);
  NodeData2 := Sender.GetNodeData(Node2);
  Result := CmpI32(NodeData1.mgindIndex, NodeData2.mgindIndex);
end;

procedure TfrmModGroupEdit.vstModGroupItemsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
begin
  Celltext := '';
  with PModGroupItemNodeData(Sender.GetNodeData(Node))^ do begin
    if Assigned(mgindModGroupItem) then
      with mgindModGroupItem^ do
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
        end
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
    mgindIndex := Node.Index;
    mgindModGroupItem := @_ModGroup.mgItems[mgindIndex];
  end;
end;

procedure TfrmModGroupEdit.vstModGroupItemsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  HitInfo  : THitInfo;
  NodeData : PModGroupItemNodeData;
begin
  HitInfo.HitNode := vstModGroupItems.FocusedNode;
  HitInfo.HitColumn := vstModGroupItems.FocusedColumn;
  NodeData := vstModGroupItems.GetNodeData(HitInfo.HitNode);
  case Key of
    Ord('C'): if Shift = [ssCtrl] then begin
      Clipboard.AsText := NodeData.mgindModGroupItem.mgiFileName;
      Key := 0;
    end;
    Ord(' '): begin
      Key := 0;
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
    with NodeData.mgindModGroupItem^ do
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
