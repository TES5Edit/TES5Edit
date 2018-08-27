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
    procedure vstModGroupItemsInitChildren(Sender: TBaseVirtualTree; Node: PVirtualNode; var ChildCount: Cardinal);
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
    mgindCRC32           : TwbCRC32;
  end;

implementation

{$R *.dfm}

uses
  Vcl.Clipbrd,
  wbHelpers,
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

  if wbThemesSupported then
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
  if wbIsDarkMode then
    vstModGroupItems.Colors.TreeLineColor := Darker(clWindowText)
  else
    vstModGroupItems.Colors.TreeLineColor := clBtnShadow;

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
  i, j           : Integer;
  Node           : PVirtualNode;
  NodeData       : PModGroupItemNodeData;
  CRC32Node      : PVirtualNode;
  CRC32NodeData  : PModGroupItemNodeData;
  lModGroup      : TwbModGroup;
  CRC32          : TwbCRC32;
  sl             : TArray<string>;
begin
  vstModGroupItems.Clear;

  lModGroup := ModGroup^;

  sl := nil;
  with lModGroup do begin
    for i := Low(mgItems) to High(mgItems) do
      with mgItems[i] do
        if Length(mgiCRC32s) > 0 then
          if Assigned(mgiModule) and mgiModule.GetCRC32(CRC32) then
            if not mgiCRC32s.Contains(CRC32) then begin
              sl.Add(mgiFileName);
              mgiCRC32s.Add(CRC32);
            end;
  end;

  if Length(sl) > 0 then
    if MessageDlg('The following entries have CRC32s, but don''t contain the CRC of the current file:' +
         CRLF + CRLF + sl.ToText + CRLF + CRLF +
         'Do you want to add the current CRC32s to these entries?', mtConfirmation, mbYesNo, 0, mbNo) <> mrYes then begin
        lModGroup := ModGroup^;
      end;

  with lModGroup do
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
        with ModGroup.mgItems[i] do begin
          CRC32Node := vstModGroupItems.GetFirstChild(Node);
          SetLength(mgiCRC32s, vstModGroupItems.ChildCount[Node]);
          j := 0;
          while Assigned(CRC32Node) do begin
            CRC32NodeData := vstModGroupItems.GetNodeData(CRC32Node);
            mgiCRC32s[j] := CRC32NodeData.mgindCRC32;
            Inc(j);
            CRC32Node := vstModGroupItems.GetNextSibling(CRC32Node);
          end;
        end;
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
var
  ParentNodeData: PModGroupItemNodeData;
begin
  Celltext := '';
  ParentNodeData := Sender.GetNodeData(Node.Parent);
  with PModGroupItemNodeData(Sender.GetNodeData(Node))^ do begin
    if Assigned(ParentNodeData) then begin
      if Column = 0 then
        Celltext := mgindCRC32.ToString;
    end else with mgindModGroupItem do
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

procedure TfrmModGroupEdit.vstModGroupItemsInitChildren(Sender: TBaseVirtualTree; Node: PVirtualNode; var ChildCount: Cardinal);
var
  NodeData : PModGroupItemNodeData;
begin
  if (Node.Parent = nil) or (Node.Parent = Sender.RootNode) then begin
    NodeData := Sender.GetNodeData(Node);
    ChildCount := Length(NodeData.mgindModGroupItem.mgiCRC32s);
  end;
end;

procedure TfrmModGroupEdit.vstModGroupItemsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  NodeData       : PModGroupItemNodeData;
  ParentNodeData : PModGroupItemNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  ParentNodeData := Sender.GetNodeData(ParentNode);
  with NodeData^ do
    if Assigned(ParentNodeData) then begin
      if Assigned(mgindModGroupItemPtr) then begin
        mgindCRC32 := mgindModGroupItemPtr.mgiCRC32s[0];
        mgindModGroupItemPtr := nil;
      end else
        mgindCRC32 := ParentNodeData.mgindModGroupItem.mgiCRC32s[Node.Index];
      if Assigned(ParentNodeData.mgindModGroupItem.mgiModule) and ParentNodeData.mgindModGroupItem.mgiModule.HasCRC32(mgindCRC32) then
        Sender.CheckState[Node] := csCheckedDisabled
      else
        Sender.CheckState[Node] := csUncheckedDisabled;
      Sender.CheckType[Node] := ctRadioButton;
    end else if Assigned(mgindModGroupItemPtr) then begin
      mgindModGroupItem := mgindModGroupItemPtr^;
      mgindModGroupItemPtr := nil;
      if Length(mgindModGroupItem.mgiCRC32s) > 0 then
        Include(InitialStates, ivsHasChildren);
    end;
end;

procedure TfrmModGroupEdit.vstModGroupItemsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  HitInfo          : THitInfo;
  NodeData         : PModGroupItemNodeData;
  ParentNodeData   : PModGroupItemNodeData;
  ModGroupNodeData : PModGroupItemNodeData;
  ModGroupNode     : PVirtualNode;
  CRC32Node        : PVirtualNode;
  CRC32NodeData : PModGroupItemNodeData;
  ModGroupItem     : TwbModGroupItem;
  Mode             : TVTNodeAttachMode;
  TargetNode       : PVirtualNode;
  CRC32            : TwbCRC32;
  s                : string;
begin
  HitInfo.HitNode := vstModGroupItems.FocusedNode;
  HitInfo.HitColumn := vstModGroupItems.FocusedColumn;
  NodeData := vstModGroupItems.GetNodeData(HitInfo.HitNode);
  if Assigned(NodeData) then
    ParentNodeData := vstModGroupItems.GetNodeData(HitInfo.HitNode.Parent)
  else
    ParentNodeData := nil;
  case Key of
    VK_DELETE: begin
      Key := 0;
      if Assigned(ParentNodeData) then begin
        if (ssShift in Shift) or (MessageDlg('Do you want to delete CRC32 "'+NodeData.mgindCRC32.ToString+'" from "'+ParentNodeData.mgindModGroupItem.mgiFileName+'"?', mtConfirmation, mbYesNo, 0, mbNo) = mrYes) then
          vstModGroupItems.DeleteNode(HitInfo.HitNode);
      end else if Assigned(NodeData) then
        if (ssShift in Shift) or (MessageDlg('Do you want to delete "'+NodeData.mgindModGroupItem.mgiFileName+'" from this ModGroup?', mtConfirmation, mbYesNo, 0, mbNo) = mrYes) then
          vstModGroupItems.DeleteNode(HitInfo.HitNode);
    end;
    VK_INSERT: begin
      Key := 0;
      if Assigned(ParentNodeData) or (Shift = [ssShift]) then begin
        if Assigned(ParentNodeData) then begin
          ModGroupNodeData := ParentNodeData;
          ModGroupNode := HitInfo.HitNode.Parent;
        end else begin
          ModGroupNodeData := NodeData;
          ModGroupNode := HitInfo.HitNode;
        end;

        if Assigned(ModGroupNodeData.mgindModGroupItem.mgiModule) and ModGroupNodeData.mgindModGroupItem.mgiModule.GetCRC32(CRC32) then begin
          CRC32Node := vstModGroupItems.GetFirstChild(ModGroupNode);
          while Assigned(CRC32Node) do begin
            CRC32NodeData := vstModGroupItems.GetNodeData(CRC32Node);
            if CRC32NodeData.mgindCRC32 = CRC32 then begin
              CRC32 := 0;
              Break;
            end;
            CRC32Node := vstModGroupItems.GetNextSibling(CRC32Node);
          end;
        end;

        repeat
          if CRC32 <> 0 then
            s := CRC32.ToString
          else
            s := '';
          if not InputQuery('New file CRC32', 'Please enter the to be added CRC32 as an 8 digit Hex number, e.g 1A2B3C4D', s) then
            Exit;
          if CRC32.AssignFromString(s) then begin
            CRC32Node := vstModGroupItems.GetFirstChild(ModGroupNode);
            while Assigned(CRC32Node) do begin
              CRC32NodeData := vstModGroupItems.GetNodeData(CRC32Node);
              if CRC32NodeData.mgindCRC32 = CRC32 then begin
                CRC32 := 0;
                ShowMessage('The entered CRC32 has already been previously added. Please try again.');
                Break;
              end;
              CRC32Node := vstModGroupItems.GetNextSibling(CRC32Node);
            end;
          end else begin
            CRC32 := 0;
            ShowMessage('The entered text was not a valid CRC32. Please try again.');
          end;
        until CRC32 <> 0;
        ModGroupItem.mgiCRC32s := [CRC32];
        vstModGroupItems.FocusedNode := vstModGroupItems.InsertNode(ModGroupNode, amAddChildLast, @ModGroupItem);
        vstModGroupItems.ClearSelection;
        vstModGroupItems.Selected[vstModGroupItems.FocusedNode] := True;
      end else begin
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

        HitInfo.HitNode := vstModGroupItems.GetFirst;
        while Assigned(HitInfo.HitNode) do begin
          NodeData := vstModGroupItems.GetNodeData(HitInfo.HitNode);
          with NodeData.mgindModGroupItem do
            if Assigned(mgiModule) then
              if mgiModule.miLoadOrder > ModGroupItem.mgiModule.miLoadOrder then begin
                Mode := amInsertBefore;
                Break;
              end;
          HitInfo.HitNode := vstModGroupItems.GetNextSibling(HitInfo.HitNode);
        end;

        if Mode = amNoWhere then begin
          HitInfo.HitNode := vstModGroupItems.GetLastChild(nil);
          Mode := amInsertAfter;
        end;

        vstModGroupItems.FocusedNode := vstModGroupItems.InsertNode(HitInfo.HitNode, Mode, @ModGroupItem);
        vstModGroupItems.ClearSelection;
        vstModGroupItems.Selected[vstModGroupItems.FocusedNode] := True;
      end
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
      if Assigned(ParentNodeData) then begin
        if Assigned(NodeData) then
          Clipboard.AsText := NodeData.mgindCRC32.ToString
      end else begin
        if Assigned(NodeData) then
          Clipboard.AsText := NodeData.mgindModGroupItem.mgiFileName;
      end;
    end;
    Ord('N'): if Shift = [ssCtrl] then begin
      Key := 0;
      if Assigned(ParentNodeData) then begin

      end else begin
        if Assigned(NodeData) then
          edName.Text := ChangeFileExt(NodeData.mgindModGroupItem.mgiFileName, '');
      end;
    end;
    Ord(' '): begin
      Key := 0;
      if Assigned(ParentNodeData) then begin

      end else begin
        if Assigned(NodeData) then
          vstModGroupItemsNodeClick(vstModGroupItems, HitInfo);
      end;
    end;
  end;
end;

procedure TfrmModGroupEdit.vstModGroupItemsNodeClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
var
  NodeData: PModGroupItemNodeData;
  ParentNodeData: PModGroupItemNodeData;
begin
  with HitInfo do begin
    if not Assigned(HitNode) then
      Exit;
    NodeData := vstModGroupItems.GetNodeData(HitNode);
    ParentNodeData := vstModGroupItems.GetNodeData(HitNode.Parent);
    if not Assigned(NodeData) then
      Exit;
    if Assigned(ParentNodeData) then
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
