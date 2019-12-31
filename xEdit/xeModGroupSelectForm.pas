{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeModGroupSelectForm;

{$I xeDefines.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, Menus,
  Vcl.Styles.Utils.SystemMenu, VirtualTrees, VirtualEditTree,
  wbInterface, wbLoadOrder, wbModGroups, Vcl.ExtCtrls, System.Actions, Vcl.ActnList;

const
  csLast = '<Last>';

type
  TfrmModGroupSelect = class(TForm)
    pmuModGroups: TPopupMenu;
    mniSelectAll: TMenuItem;
    mniSelectNone: TMenuItem;
    mniInvertSelection: TMenuItem;
    btnOK: TButton;
    vstModGroups: TVirtualStringTree;
    pnlError: TPanel;
    edFilter: TLabeledEdit;
    btnCancel: TButton;
    bnDelete: TButton;
    bnSave: TButton;
    bnLoad: TButton;
    cbPreset: TComboBox;
    lblPreset: TLabel;
    aclModGroups: TActionList;
    acPresetLoad: TAction;
    acPresetSave: TAction;
    acPresetDelete: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure vstModGroupsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstModGroupsFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstModGroupsInitChildren(Sender: TBaseVirtualTree; Node: PVirtualNode; var ChildCount: Cardinal);
    procedure vstModGroupsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstModGroupsBeforeGetCheckState(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstModGroupsChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstModGroupsCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vstModGroupsPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure vstModGroupsIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure vstModGroupsKeyPress(Sender: TObject; var Key: Char);

    procedure edFilterChange(Sender: TObject);

    procedure pmuModGroupsPopup(Sender: TObject);
    procedure mniSelectAllClick(Sender: TObject);
    procedure mniSelectNoneClick(Sender: TObject);
    procedure mniInvertSelectionClick(Sender: TObject);
    procedure vstModGroupsNodeDblClick(Sender: TBaseVirtualTree;
      const HitInfo: THitInfo);
    procedure edFilterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vstModGroupsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure acPresetLoadUpdate(Sender: TObject);
    procedure acPresetDeleteExecute(Sender: TObject);
    procedure acPresetDeleteUpdate(Sender: TObject);
    procedure acPresetSaveExecute(Sender: TObject);
    procedure acPresetSaveUpdate(Sender: TObject);
    procedure acPresetLoadExecute(Sender: TObject);
    procedure cbPresetKeyPress(Sender: TObject; var Key: Char);
  private
    ChangingChecked : Integer;
    procedure CollectSelected;
    procedure DoSingleModGroupLoad(Node: PVirtualNode = nil);
    function GetSelectedOrAll: TNodeArray;
    function CheckStateForModGroup(aModGroup: PwbModGroup; aIsRootChild: Boolean): TCheckState;

    procedure PresetLoad(const aPreset: string);
    procedure PresetSave(const aPreset: string; aAfterShowModal: Boolean);
    procedure PresetDelete(const aPreset: string);
    function GetPresetsSection: string;
    procedure PresetsUpdate;
    function IsPresetDifferent(const aPreset: string): Boolean;
  public
    PresetCategory  : string;
    LoadedPreset    : string;
    AllModGroups      : TwbModGroupPtrs;
    SelectedModGroups : TwbModGroupPtrs;

    SelectFlag      : TwbModGroupFlag;
    FilterFlag      : TwbModGroupFlag;
    MinSelect       : Integer;
    MaxSelect       : Integer;

    procedure AllowCancel;
    function ShowModal: Integer; override;
  end;

  PModGroupNodeData = ^TModGroupNodeData;
  TModGroupNodeData = record
    mgndModGroup     : PwbModGroup;
    mgndModGroupItem : PwbModGroupItem;
    mgndIndex        : Integer;
    mgndCRC32        : PwbCRC32;
  end;

implementation

{$R *.dfm}

uses
  xeMainForm,
  StrUtils;

procedure TfrmModGroupSelect.mniInvertSelectionClick(Sender: TObject);
var
  Nodes    : TNodeArray;
  Node     : PVirtualNode;
  NodeData : PModGroupNodeData;
begin
  Nodes := GetSelectedOrAll;
  if Length(Nodes) < 1 then
    Exit;

  for Node in Nodes do
    with Node^ do begin
      NodeData := vstModGroups.GetNodeData(Node);
      with NodeData^ do
        if Assigned(mgndModGroup) then
          with mgndModGroup^ do
            if SelectFlag in mgFlags then
              Exclude(mgFlags, SelectFlag)
            else
              Include(mgFlags, SelectFlag);
    end;

  CollectSelected;
end;

procedure TfrmModGroupSelect.mniSelectAllClick(Sender: TObject);
var
  Nodes    : TNodeArray;
  Node     : PVirtualNode;
  NodeData : PModGroupNodeData;
begin
  Nodes := GetSelectedOrAll;
  if Length(Nodes) < 1 then
    Exit;

  for Node in Nodes do
    with Node^ do begin
      NodeData := vstModGroups.GetNodeData(Node);
      with NodeData^ do
        if Assigned(mgndModGroup) then
          with mgndModGroup^ do
            Include(mgFlags, SelectFlag);
    end;

  CollectSelected;
end;

procedure TfrmModGroupSelect.mniSelectNoneClick(Sender: TObject);
var
  Nodes    : TNodeArray;
  Node     : PVirtualNode;
  NodeData : PModGroupNodeData;
begin
  Nodes := GetSelectedOrAll;
  if Length(Nodes) < 1 then
    Exit;

  for Node in Nodes do
    with Node^ do begin
      NodeData := vstModGroups.GetNodeData(Node);
      with NodeData^ do
        if Assigned(mgndModGroup) then
          with mgndModGroup^ do
            Exclude(mgFlags, SelectFlag);
    end;

  CollectSelected;
end;

procedure TfrmModGroupSelect.pmuModGroupsPopup(Sender: TObject);
begin
  mniSelectAll.Enabled := Length(GetSelectedOrAll) > 0;
  mniSelectNone.Enabled := mniSelectAll.Enabled;
  mniInvertSelection.Enabled := mniSelectAll.Enabled;
end;

procedure TfrmModGroupSelect.PresetDelete(const aPreset: string);
begin
  if PresetCategory = '' then
    Exit;
  if aPreset = '' then
    Exit;
  if aPreset.StartsWith('<') then
    Exit;
  if not Assigned(frmMain.Settings) then
    Exit;
  if not frmMain.Settings.ValueExists(GetPresetsSection, aPreset) then
    Exit;
  if MessageDlg('Are you sure you want to delete preset "'+aPreset+'"?', mtConfirmation, mbYesNo, 0) <> mrYes then
    Exit;
  frmMain.Settings.DeleteKey(GetPresetsSection, aPreset);
  frmMain.Settings.UpdateFile;
  PresetsUpdate;
  if cbPreset.Text = aPreset then
    cbPreset.Text := '';
end;

procedure TfrmModGroupSelect.PresetLoad(const aPreset: string);
var
  sl   : TStringList;
  i, j : Integer;
begin
  LoadedPreset := '';
  if PresetCategory = '' then
    Exit;
  if aPreset = '' then
    Exit;
  if not Assigned(frmMain.Settings) then
    Exit;
  AllModGroups.ExcludeAll(SelectFlag);
  sl := TStringList.Create;
  try
    if aPreset.StartsWith('<') then begin
      if aPreset = csLast then
        sl.CommaText := frmMain.Settings.ReadString('ModGroups', 'Selection', '')
      else
        Exit;
    end else
       sl.CommaText := frmMain.Settings.ReadString(GetPresetsSection, aPreset, '');
    sl.Sorted := True;
    for i := Low(AllModGroups) to High(AllModGroups) do
      with AllModGroups[i]^ do
        if sl.Find(mgName, j) then
          Include(mgFlags, SelectFlag);
  finally
    sl.Free;
  end;
  LoadedPreset := aPreset;
  CollectSelected;
end;

procedure TfrmModGroupSelect.PresetSave(const aPreset: string; aAfterShowModal: Boolean);
var
  sl            : TStringList;
  i             : Integer;
  s             : string;
  DefaultButton : TMsgDlgBtn;
begin
  if PresetCategory = '' then
    Exit;
  if aPreset = '' then
    Exit;
  if aPreset.StartsWith('<') then
    Exit;
  if not Assigned(frmMain.Settings) then
    Exit;

  DefaultButton := mbYes;
  if aAfterShowModal then begin
    DefaultButton := mbNo;
    s := 'You have changed the selection after loading a preset. Do you want to update the preset "'+aPreset+'" with your new selection?';
  end else
    s := 'Are you sure you want to overwrite existing preset "'+aPreset+'"?';
  if frmMain.Settings.ValueExists(GetPresetsSection, aPreset) then
    if MessageDlg(s, mtConfirmation, mbYesNo, 0, DefaultButton) <> mrYes then
      Exit;

  sl := TStringList.Create;
  try
    for i := Low(SelectedModGroups) to High(SelectedModGroups) do
      with SelectedModGroups[i]^ do
        sl.Add(mgName);
    frmMain.Settings.WriteString(GetPresetsSection, aPreset, sl.CommaText);
    frmMain.Settings.UpdateFile;
  finally
    sl.Free;
  end;
  PresetsUpdate;
end;

procedure TfrmModGroupSelect.PresetsUpdate;
begin
  with cbPreset, Items do begin
    BeginUpdate;
    try
      Clear;
      if Assigned(frmMain.Settings) and (PresetCategory <> '') then
        frmMain.Settings.ReadSection(GetPresetsSection, Items);
      if frmMain.Settings.ValueExists('ModGroups', 'Selection') then
        Insert(0, csLast);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TfrmModGroupSelect.DoSingleModGroupLoad(Node: PVirtualNode);
begin
  AllModGroups.ExcludeAll(SelectFlag);

  if not Assigned(Node) then
    if (MaxSelect > 1) and (vstModGroups.SelectedCount > 1) then begin
      for Node in vstModGroups.SelectedNodes do
        with PModGroupNodeData(vstModGroups.GetNodeData(Node))^ do
          if Assigned(mgndModGroup) then
            Include(mgndModGroup.mgFlags, SelectFlag)
    end else
      Node := vstModGroups.FocusedNode;

  if Assigned(Node) then
    with PModGroupNodeData(vstModGroups.GetNodeData(Node))^ do
      if Assigned(mgndModGroup) then
        Include(mgndModGroup.mgFlags, SelectFlag);

  CollectSelected;
  if btnOK.Enabled then
    btnOK.Click;
end;

procedure TfrmModGroupSelect.edFilterChange(Sender: TObject);
var
  SearchText : string;
  Node       : PVirtualNode;
  NodeData   : PModGroupNodeData;
begin
  SearchText := edFilter.Text;
  SearchText := SearchText.ToLowerInvariant;
  with vstModGroups do begin
    BeginUpdate;
    try
      Node := GetFirst;
      while Assigned(Node) do begin
        NodeData := GetNodeData(Node);
        IsFiltered[Node] := (SearchText <> '') and
          not NodeData.mgndModGroup.mgName.ToLowerInvariant.Contains(SearchText);
        Node := GetNextSibling(Node);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TfrmModGroupSelect.edFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DOWN then begin
    vstModGroups.FocusedNode := vstModGroups.GetFirstVisible;
    if Assigned(vstModGroups.FocusedNode) then
      vstModGroups.ClearSelection;
      vstModGroups.Selected[vstModGroups.FocusedNode] := True;
      vstModGroups.SetFocus;
  end;
end;

procedure TfrmModGroupSelect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CollectSelected;
end;

procedure TfrmModGroupSelect.FormCreate(Sender: TObject);
begin
  xeApplyFontAndScale(Self);

  if wbThemesSupported then
    with TVclStylesSystemMenu.Create(Self) do begin
      ShowNativeStyle := True;
      MenuCaption := 'Theme';
    end;

  vstModGroups.Header.SortColumn := 1;
  vstModGroups.IncrementalSearch := isVisibleOnly;
  vstModGroups.NodeDataSize := SizeOf(TModGroupNodeData);

  SelectFlag := mgfTagged;
  FilterFlag := mgfValid;
  MaxSelect := High(Integer);
  MinSelect := 0;
end;

procedure TfrmModGroupSelect.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Node: PVirtualNode;
begin
  if Key = VK_RETURN then begin
    if edFilter.Focused then begin
      vstModGroups.SetFocus;
      vstModGroups.ClearSelection;
      vstModGroups.FocusedNode := nil;
      for Node in vstModGroups.VisibleNodes(nil) do begin
        if not Assigned(vstModGroups.FocusedNode) then
          vstModGroups.FocusedNode := Node;
        vstModGroups.Selected[Node] := True;
      end;
      if Shift = [ssCtrl] then
        DoSingleModGroupLoad;
      Exit;
    end else if cbPreset.Focused then begin
      if acPresetLoad.Execute then begin
        if Shift = [ssCtrl] then begin
          CollectSelected;
          if btnOK.Enabled then
            btnOK.Click;
        end else
          vstModGroups.SetFocus;
      end else if acPresetSave.Execute then
        vstModGroups.SetFocus
      else
        Beep;
      Exit;
    end;

    if (ssCtrl in Shift) or (Length(SelectedModGroups)=0) then
      DoSingleModGroupLoad
    else begin
      CollectSelected;
      if btnOK.Enabled then
        btnOK.Click;
    end;
  end else if Key = VK_ESCAPE then begin
    if btnCancel.Enabled then
      btnCancel.Click;
  end else if Key = VK_MULTIPLY then
    mniInvertSelection.Click
  else if Key = VK_DELETE then
    if cbPreset.Focused then begin
      if Shift = [ssShift] then begin
        Key := 0;
        if not acPresetDelete.Execute then
          Beep;
        Exit;
      end;
    end;
end;

procedure TfrmModGroupSelect.FormShow(Sender: TObject);
begin
  if wbIsDarkMode then
    vstModGroups.Colors.TreeLineColor := Darker(clWindowText)
  else
    vstModGroups.Colors.TreeLineColor := clBtnShadow;

  CollectSelected;

  vstModGroups.SetFocus;
  vstModGroups.FocusedNode := vstModGroups.GetFirstChecked;
  if not Assigned(vstModGroups.FocusedNode) then
    vstModGroups.FocusedNode := vstModGroups.GetFirstVisible;
  vstModGroups.ClearSelection;
  if Assigned(vstModGroups.FocusedNode) then
    vstModGroups.Selected[vstModGroups.FocusedNode] := True;
end;

function TfrmModGroupSelect.GetPresetsSection: string;
begin
  Result := Name + '_' + PresetCategory + '_Presets';
end;

function TfrmModGroupSelect.GetSelectedOrAll: TNodeArray;
var
  Node : PVirtualNode;
  i, j : Integer;
begin
  Result := vstModGroups.GetSortedSelection(True);
  if Length(Result) < 2 then begin
    SetLength(Result, vstModGroups.RootNode.ChildCount);
    Node := vstModGroups.RootNode.FirstChild;
    i := 0;
    while Assigned(Node) do begin
      if not (vsDisabled in Node.States) then begin
        Result[i] := Node;
        Inc(i);
      end;
      Node := Node.NextSibling;
    end;
    SetLength(Result, i);
  end;
  j := 0;
  for i := Low(Result) to High(Result) do begin
    Node := Result[i];
    if  not (vsDisabled in Node.States) then
      if (Node.Parent = nil) or (Node.Parent = vstModGroups.RootNode) then begin
        if i <> j then
          Result[j] := Result[i];
        Inc(j);
      end;
  end;

  SetLength(Result, j);
end;

function TfrmModGroupSelect.IsPresetDifferent(const aPreset: string): Boolean;
var
  slCurrent, slPreset : TStringList;
  i  : Integer;
begin
  Result := False;

  if PresetCategory = '' then
    Exit;
  if aPreset = '' then
    Exit;
  if aPreset.StartsWith('<') then
    Exit;
  if not Assigned(frmMain.Settings) then
    Exit;
  if not frmMain.Settings.ValueExists(GetPresetsSection, aPreset) then
    Exit;

  slCurrent := TStringList.Create;
  slPreset := TStringList.Create;
  try
    slCurrent.Sorted := True;
    slCurrent.Duplicates := dupIgnore;
    for i := Low(SelectedModGroups) to High(SelectedModGroups) do
      with SelectedModGroups[i]^ do
        slCurrent.Add(mgName);

    slPreset.Sorted := True;
    slPreset.Duplicates := dupIgnore;
    slPreset.CommaText := frmMain.Settings.ReadString(GetPresetsSection, aPreset, '');

    Result :=
          (slCurrent.Count <> slPreset.Count) or
      not SameText(slCurrent.CommaText,slPreset.CommaText);
  finally
    slCurrent.Free;
    slPreset.Free;
  end;
end;

procedure TfrmModGroupSelect.acPresetDeleteExecute(Sender: TObject);
begin
  PresetDelete(cbPreset.Text);
end;

procedure TfrmModGroupSelect.acPresetDeleteUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled :=
    Assigned(frmMain.Settings) and
    frmMain.Settings.ValueExists(GetPresetsSection, cbPreset.Text);
end;

procedure TfrmModGroupSelect.acPresetLoadExecute(Sender: TObject);
begin
  PresetLoad(cbPreset.Text);
end;

procedure TfrmModGroupSelect.acPresetLoadUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled :=
    (cbPreset.Text = csLast) or
    (Assigned(frmMain.Settings) and frmMain.Settings.ValueExists(GetPresetsSection, cbPreset.Text));
end;

procedure TfrmModGroupSelect.acPresetSaveExecute(Sender: TObject);
begin
  PresetSave(cbPreset.Text, False);
end;

procedure TfrmModGroupSelect.acPresetSaveUpdate(Sender: TObject);
var
  s: string;
begin
  s := string(cbPreset.Text).Replace('=', '', [rfReplaceAll]).Trim;
  TAction(Sender).Enabled :=
    (cbPreset.Text = s) and
    (s <> '') and
    (s[1] <> '<') and
    (Length(SelectedModGroups) > 0);
end;

procedure TfrmModGroupSelect.AllowCancel;
var
  Left: Integer;
begin
  btnCancel.Enabled := True;
  btnCancel.Visible := True;
  Left := btnCancel.Left;
  btnCancel.Left := btnOK.Left;
  btnOK.Left := Left;
end;

procedure TfrmModGroupSelect.cbPresetKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #0;
end;

function TfrmModGroupSelect.CheckStateForModGroup(aModGroup: PwbModGroup; aIsRootChild: Boolean): TCheckState;
begin
  with aModGroup^ do
    if aIsRootChild then begin
      if SelectFlag in mgFlags then
        Result := csCheckedNormal
      else
        Result := csUncheckedNormal;
    end else begin
      if SelectFlag in mgFlags then
        Result := csCheckedDisabled
      else 
        Result := csUncheckedDisabled;
    end;
end;

function TfrmModGroupSelect.ShowModal: Integer;
begin
  vstModGroups.Clear;
  if Length(AllModGroups) < 1 then
    AllModGroups := wbModGroupsByName.FilteredByFlag(FilterFlag);
  vstModGroups.ChildCount[nil] := Length(AllModGroups);
  vstModGroups.InitRecursive(nil, 100, False);

  if PresetCategory <> '' then begin
    PresetsUpdate;
  end else begin
    lblPreset.Visible := False;
    cbPreset.Visible := False;
    acPresetDelete.Visible := False;
    acPresetSave.Visible := False;
    acPresetLoad.Visible := False;
    edFilter.Width := (vstModGroups.Left + vstModGroups.Width) - edFilter.Left;
  end;

  if Length(AllModGroups) < 1 then
    Result := mrCancel
  else
    Result := inherited ShowModal;

  if Result <> mrOk then
    SelectedModGroups := nil
  else
    CollectSelected;

  if Length(SelectedModGroups) < MinSelect then
    Result := mrCancel;

  if (Result = mrOk) and (LoadedPreset <> '') and IsPresetDifferent(LoadedPreset) then
    PresetSave(LoadedPreset, True);
end;

procedure TfrmModGroupSelect.CollectSelected;
var
  Error         : string;
begin
  Error := '';
  try
    SelectedModGroups := AllModGroups.FilteredByFlag(SelectFlag);

    if Length(SelectedModGroups) < MinSelect then
      if Length(SelectedModGroups) = 0 then
        Error := 'No ModGroups selected'
      else
        Error := 'Less than ' + MinSelect.ToString + ' ModGroups selected';

    if Length(SelectedModGroups) > MaxSelect then begin
      if MaxSelect = 1 then
        Error := 'More than 1 ModGroup selected'
      else
        Error := 'More than ' + MaxSelect.ToString + ' ModGroups selected';
    end;

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

  vstModGroups.Invalidate;
end;

procedure TfrmModGroupSelect.vstModGroupsBeforeGetCheckState(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  ParentNodeData : PModGroupNodeData;
begin
  with PModGroupNodeData(Sender.GetNodeData(Node))^ do begin
    if Assigned(mgndModGroup) then begin
      Inc(ChangingChecked);
      try
        vstModGroups.CheckState[Node] := CheckStateForModGroup(mgndModGroup,
          (Node.Parent = nil) or (Node.Parent = Sender.RootNode));
      finally
        Dec(ChangingChecked);
      end;
    end else if Assigned(mgndCRC32) then begin
      Inc(ChangingChecked);
      try
        vstModGroups.CheckType[Node] := ctRadioButton;
        ParentNodeData := Sender.GetNodeData(Node.Parent);
        if Assigned(ParentNodeData) and
           Assigned(ParentNodeData.mgndModGroupItem) and
           Assigned(ParentNodeData.mgndModGroupItem.mgiModule) and
           ParentNodeData.mgndModGroupItem.mgiModule.HasCRC32(mgndCRC32^) then
          vstModGroups.CheckState[Node] := csCheckedDisabled
        else
          vstModGroups.CheckState[Node] := csUnCheckedDisabled;
      finally
        Dec(ChangingChecked);
      end;
    end;
  end;
end;

procedure TfrmModGroupSelect.vstModGroupsChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  if ChangingChecked < 1 then
    with PModGroupNodeData(Sender.GetNodeData(Node))^ do
      if Assigned(mgndModGroup) then
        with mgndModGroup^ do begin
          if SelectFlag in mgFlags then
            Exclude(mgFlags, SelectFlag)
          else
            Include(mgFlags, SelectFlag);
          CollectSelected;
        end;
end;

function CmpBool(a, b: Boolean): Integer;
begin
  Result := 0;
  if a then begin
    if not b then
      Result := 1;
  end else
    if b then
      Result := -1
end;


procedure TfrmModGroupSelect.vstModGroupsCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  NodeData1, NodeData2: PModGroupNodeData;
begin
  NodeData1 := Sender.GetNodeData(Node1);
  NodeData2 := Sender.GetNodeData(Node2);
  Result := CmpI32(NodeData1.mgndIndex, NodeData2.mgndIndex);
end;

procedure TfrmModGroupSelect.vstModGroupsFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  with PModGroupNodeData(Sender.GetNodeData(Node))^ do begin
    mgndModGroup := nil;
  end;
end;

procedure TfrmModGroupSelect.vstModGroupsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
begin
  Celltext := '';
  with PModGroupNodeData(Sender.GetNodeData(Node))^ do begin
    if Assigned(mgndModGroup) then
      with mgndModGroup^ do
        case Column of
          0 : CellText := mgName;
        end
    else if Assigned(mgndModGroupItem) then
      with mgndModGroupItem^ do
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
    else if Assigned(mgndCRC32) then
      if Column = 0 then
        CellText := mgndCRC32^.ToString;
  end;
end;

procedure TfrmModGroupSelect.vstModGroupsIncrementalSearch(Sender: TBaseVirtualTree;
  Node: PVirtualNode; const SearchText: string; var Result: Integer);
var
  CompareText                 : string;
  i: Integer;
begin
  Result := 1;
  CompareText := '';

  if (Node.Parent = nil) or (Node.Parent = Sender.RootNode) then
    with PModGroupNodeData(Sender.GetNodeData(Node))^ do
      CompareText := mgndModGroup.mgName;

  if Length(SearchText) > Length(CompareText) then
    Exit;

  for i := 1 to Length(SearchText) do
    if UpCase(SearchText[i]) <> UpCase(CompareText[i]) then
      Exit;

  Result := 0;
end;

procedure TfrmModGroupSelect.vstModGroupsInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
begin
  with PModGroupNodeData(Sender.GetNodeData(Node))^ do begin
    if Assigned(mgndModGroup) then
      ChildCount := Length(mgndModGroup.mgItems)
    else if Assigned(mgndModGroupItem) then
      ChildCount := Length(mgndModGroupItem.mgiCRC32s)
    else
  end;
end;

procedure TfrmModGroupSelect.vstModGroupsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  NodeData: PModGroupNodeData;
  ParentNodeData: PModGroupNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  with NodeData^ do begin
    mgndIndex := Node.Index;
    if not Assigned(mgndModGroup) then
      if not Assigned(ParentNode) or (ParentNode = Sender.RootNode) then begin
        mgndModGroup := AllModGroups[Node.Index];
        vstModGroups.CheckType[Node] := ctCheckBox;
      end else begin
        ParentNodeData := Sender.GetNodeData(ParentNode);
        if Assigned(ParentNodeData.mgndModGroup) then begin
          with ParentNodeData.mgndModGroup^ do
            mgndModGroupItem := @mgItems[Node.Index];
          if Length(mgndModGroupItem.mgiCRC32s) > 0 then
            Include(InitialStates, ivsHasChildren);
          Sender.CheckType[Node] := ctNone;
        end else if Assigned(ParentNodeData.mgndModGroupItem) then begin
          with ParentNodeData.mgndModGroupItem^ do
            mgndCRC32 := @mgiCRC32s[Node.Index];
          Inc(ChangingChecked);
          try
            Sender.CheckType[Node] := ctRadioButton;
            if Assigned(ParentNodeData.mgndModGroupItem.mgiModule) and
               ParentNodeData.mgndModGroupItem.mgiModule.HasCRC32(mgndCRC32^) then
              Sender.CheckState[Node] := csCheckedDisabled
            else
              Sender.CheckState[Node] := csUnCheckedDisabled;
          finally
            Dec(ChangingChecked);
          end;
        end else begin
          Include(InitialStates, ivsHidden);
          Exit;
        end;
      end;
    if Assigned(mgndModGroup) then begin
      if Length(mgndModGroup.mgItems) > 0 then
        Include(InitialStates, ivsHasChildren);
      if (FilterFlag <> mgfNone) and not (FilterFlag in mgndModGroup.mgFlags) then
        Include(InitialStates, ivsDisabled);
    end else
      Include(InitialStates, ivsDisabled);
  end;
end;

procedure TfrmModGroupSelect.vstModGroupsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  FirstVisible: PVirtualNode;
begin
  if Key = VK_UP then
    if Shift = [] then begin
      FirstVisible := vstModGroups.GetFirstVisible;
      if not Assigned(FirstVisible) or (vstModGroups.FocusedNode = FirstVisible) then
        edFilter.SetFocus;
    end;
end;

procedure TfrmModGroupSelect.vstModGroupsKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '?' then
    edFilter.SetFocus
  else if Key = '|' then
    cbPreset.SetFocus;
end;

procedure TfrmModGroupSelect.vstModGroupsNodeDblClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
begin
  if not wbRequireCtrlForDblClick or (GetKeyState(VK_CONTROL) < 0) then
    with HitInfo do
      if Assigned(HitNode) then
        DoSingleModGroupLoad(HitNode);
end;

procedure TfrmModGroupSelect.vstModGroupsPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  with PModGroupNodeData(Sender.GetNodeData(Node))^ do begin
    if (Node.Parent = nil) or (Node.Parent = Sender.RootNode) then begin
      if Assigned(mgndModGroup) then
        with mgndModGroup^ do begin
        end;
    end else
      TargetCanvas.Font.Color := vstModGroups.Colors.DisabledColor;

    if Assigned(mgndModGroup) then begin
      if not (mgfValid in mgndModGroup.mgFlags) then
        TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsStrikeOut]
      else
        TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsStrikeOut];
    end else if Assigned(mgndModGroupItem) then begin
      if not (mgifHasFile in mgndModGroupItem.mgiFlags) then
        TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsStrikeOut]
      else
        TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsStrikeOut];
    end;
  end;
end;

end.
