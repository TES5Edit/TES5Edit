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

unit frmModuleSelectForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, Menus,
  Vcl.Styles.Utils.SystemMenu, VirtualTrees, VirtualEditTree,
  wbInterface, wbLoadOrder, Vcl.ExtCtrls, System.Actions, Vcl.ActnList;

const
  csPluginsTxt = '<plugins.txt>';

type
  TfrmModuleSelect = class(TForm)
    pmuModules: TPopupMenu;
    mniSelectAll: TMenuItem;
    mniSelectNone: TMenuItem;
    mniInvertSelection: TMenuItem;
    btnOK: TButton;
    vstModules: TVirtualStringTree;
    pnlError: TPanel;
    edFilter: TLabeledEdit;
    btnCancel: TButton;
    bnDelete: TButton;
    bnSave: TButton;
    bnLoad: TButton;
    cbPreset: TComboBox;
    lblPreset: TLabel;
    aclModules: TActionList;
    acPresetLoad: TAction;
    acPresetSave: TAction;
    acPresetDelete: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure vstModulesInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstModulesFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstModulesInitChildren(Sender: TBaseVirtualTree; Node: PVirtualNode; var ChildCount: Cardinal);
    procedure vstModulesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstModulesBeforeGetCheckState(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstModulesChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstModulesHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure vstModulesCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vstModulesPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure vstModulesIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure vstModulesNodeDblClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
    procedure vstModulesKeyPress(Sender: TObject; var Key: Char);

    procedure edFilterChange(Sender: TObject);

    procedure pmuModulesPopup(Sender: TObject);
    procedure mniSelectAllClick(Sender: TObject);
    procedure mniSelectNoneClick(Sender: TObject);
    procedure mniInvertSelectionClick(Sender: TObject);
    procedure edFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure vstModulesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure acPresetLoadUpdate(Sender: TObject);
    procedure acPresetDeleteExecute(Sender: TObject);
    procedure acPresetDeleteUpdate(Sender: TObject);
    procedure acPresetSaveExecute(Sender: TObject);
    procedure acPresetSaveUpdate(Sender: TObject);
    procedure acPresetLoadExecute(Sender: TObject);
    procedure cbPresetKeyPress(Sender: TObject; var Key: Char);
  private
    ChangingChecked : Integer;
    procedure SimulateLoad;
    procedure DoSingleModuleLoad(Node: PVirtualNode = nil);
    function GetSelectedOrAll: TNodeArray;
    function CheckStateForModule(aModule: PwbModuleInfo; aIsRootChild: Boolean): TCheckState;

    procedure PresetLoad(const aPreset: string);
    procedure PresetSave(const aPreset: string; aAfterShowModal: Boolean);
    procedure PresetDelete(const aPreset: string);
    function GetPresetsSection: string;
    procedure PresetsUpdate;
    function IsPresetDifferent(const aPreset: string): Boolean;
  public
    PresetCategory  : string;
    LoadedPreset    : string;
    AllModules      : TwbModuleInfos;
    SelectedModules : TwbModuleInfos;
    FilteredModules : TwbModuleInfos;

    SelectFlag      : TwbModuleFlag;
    FilterFlag      : TwbModuleFlag;
    MaxSelect       : Integer;
    MinSelect       : Integer;

    procedure AllowCancel;
    function ShowModal: Integer; override;
  end;

  PModuleNodeData = ^TModuleNodeData;
  TModuleNodeData = record
    mndModule : PwbModuleInfo;
    mndIndex  : Integer;
    mndName   : string;
  end;


implementation

{$R *.dfm}

uses
  frmViewMain,
  StrUtils;

procedure TfrmModuleSelect.mniInvertSelectionClick(Sender: TObject);
var
  Nodes    : TNodeArray;
  Node     : PVirtualNode;
  NodeData : PModuleNodeData;
begin
  Nodes := GetSelectedOrAll;
  if Length(Nodes) < 1 then
    Exit;

  for Node in Nodes do
    with Node^ do begin
      NodeData := vstModules.GetNodeData(Node);
      with NodeData^ do
        if Assigned(mndModule) then
          with mndModule^ do
            if SelectFlag in miFlags then
              Exclude(miFlags, SelectFlag)
            else
              Include(miFlags, SelectFlag);
    end;

  SimulateLoad;
end;

procedure TfrmModuleSelect.mniSelectAllClick(Sender: TObject);
var
  Nodes    : TNodeArray;
  Node     : PVirtualNode;
  NodeData : PModuleNodeData;
begin
  Nodes := GetSelectedOrAll;
  if Length(Nodes) < 1 then
    Exit;

  for Node in Nodes do
    with Node^ do begin
      NodeData := vstModules.GetNodeData(Node);
      with NodeData^ do
        if Assigned(mndModule) then
          with mndModule^ do
            Include(miFlags, SelectFlag);
    end;

  SimulateLoad;
end;

procedure TfrmModuleSelect.mniSelectNoneClick(Sender: TObject);
var
  Nodes    : TNodeArray;
  Node     : PVirtualNode;
  NodeData : PModuleNodeData;
begin
  Nodes := GetSelectedOrAll;
  if Length(Nodes) < 1 then
    Exit;

  for Node in Nodes do
    with Node^ do begin
      NodeData := vstModules.GetNodeData(Node);
      with NodeData^ do
        if Assigned(mndModule) then
          with mndModule^ do
            Exclude(miFlags, SelectFlag);
    end;

  SimulateLoad;
end;

procedure TfrmModuleSelect.pmuModulesPopup(Sender: TObject);
begin
  mniSelectAll.Enabled := Length(GetSelectedOrAll) > 0;
  mniSelectNone.Enabled := mniSelectAll.Enabled;
  mniInvertSelection.Enabled := mniSelectAll.Enabled;
end;

procedure TfrmModuleSelect.PresetDelete(const aPreset: string);
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

procedure TfrmModuleSelect.PresetLoad(const aPreset: string);
var
  sl   : TStringList;
  i, j : Integer;
begin
  LoadedPreset := '';
  if PresetCategory = '' then
    Exit;
  if aPreset = '' then
    Exit;
  if aPreset.StartsWith('<') then begin
    if aPreset = '<plugins.txt>' then begin
      AllModules.ExcludeAll(SelectFlag);
      for i := Low(AllModules) to High(AllModules) do
        with AllModules[i]^ do
          if (mfActiveInPluginsTxt in miFlags) or (miOfficialIndex < High(Integer)) then
            Include(miFlags, SelectFlag);
      SimulateLoad;
    end;
  end else begin
    if not Assigned(frmMain.Settings) then
      Exit;
    AllModules.ExcludeAll(SelectFlag);
    sl := TStringList.Create;
    try
      sl.CommaText := frmMain.Settings.ReadString(GetPresetsSection, aPreset, '');
      sl.Sorted := True;
      for i := Low(AllModules) to High(AllModules) do
        with AllModules[i]^ do
          if sl.Find(miName, j) then
            Include(miFlags, SelectFlag);
    finally
      sl.Free;
    end;
    LoadedPreset := aPreset;
    SimulateLoad;
  end;
end;

procedure TfrmModuleSelect.PresetSave(const aPreset: string; aAfterShowModal: Boolean);
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
    for i := Low(FilteredModules) to High(FilteredModules) do
      with FilteredModules[i]^ do
        sl.Add(miName);
    frmMain.Settings.WriteString(GetPresetsSection, aPreset, sl.CommaText);
    frmMain.Settings.UpdateFile;
  finally
    sl.Free;
  end;
  PresetsUpdate;
end;

procedure TfrmModuleSelect.PresetsUpdate;
begin
  with cbPreset, Items do begin
    BeginUpdate;
    try
      Clear;
      if Assigned(frmMain.Settings) and (PresetCategory <> '') then
        frmMain.Settings.ReadSection(GetPresetsSection, Items);
      if SelectFlag = mfActive then
        Insert(0, csPluginsTxt);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TfrmModuleSelect.DoSingleModuleLoad(Node: PVirtualNode);
begin
  AllModules.ExcludeAll(SelectFlag);

  if not Assigned(Node) then
    if (MaxSelect > 1) and (vstModules.SelectedCount > 1) then begin
      for Node in vstModules.SelectedNodes do
        with PModuleNodeData(vstModules.GetNodeData(Node))^ do
          if Assigned(mndModule) then
            Include(mndModule.miFlags, SelectFlag)
    end else
      Node := vstModules.FocusedNode;

  if Assigned(Node) then
    with PModuleNodeData(vstModules.GetNodeData(Node))^ do
      if Assigned(mndModule) then
        Include(mndModule.miFlags, SelectFlag);

  SimulateLoad;
  if btnOK.Enabled then
    btnOK.Click;
end;

procedure TfrmModuleSelect.edFilterChange(Sender: TObject);
var
  SearchText : string;
  Node       : PVirtualNode;
  NodeData   : PModuleNodeData;
begin
  SearchText := edFilter.Text;
  SearchText := SearchText.ToLowerInvariant;
  with vstModules do begin
    BeginUpdate;
    try
      Node := GetFirst;
      while Assigned(Node) do begin
        NodeData := GetNodeData(Node);
        IsFiltered[Node] := (SearchText <> '') and
          not NodeData.mndName.ToLowerInvariant.Contains(SearchText);
        Node := GetNextSibling(Node);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TfrmModuleSelect.edFilterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DOWN then begin
    vstModules.FocusedNode := vstModules.GetFirstVisible;
    if Assigned(vstModules.FocusedNode) then begin
      vstModules.ClearSelection;
      vstModules.Selected[vstModules.FocusedNode] := True;
      vstModules.SetFocus;
    end;
  end;
end;

procedure TfrmModuleSelect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SimulateLoad;
end;

procedure TfrmModuleSelect.FormCreate(Sender: TObject);
begin
  wbApplyFontAndScale(Self);
  //vstModules.Header.Height := vstModules.DefaultNodeHeight + 4;

  if wbThemesSupported then
    with TVclStylesSystemMenu.Create(Self) do begin
      ShowNativeStyle := True;
      MenuCaption := 'Theme';
    end;

  if not wbIsEslSupported then
    with vstModules.Header.Columns[3] do
      Options := Options - [coVisible];
  if wbPseudoESL then
    with vstModules.Header.Columns[5] do
      Options := Options - [coVisible];

  vstModules.Header.SortColumn := 1;
  vstModules.IncrementalSearch := isVisibleOnly;
  vstModules.NodeDataSize := SizeOf(TModuleNodeData);

  SelectFlag := mfActive;
  FilterFlag := mfValid;
  MaxSelect := High(Integer);
  MinSelect := 0;
end;

procedure TfrmModuleSelect.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Node: PVirtualNode;
begin
  if Key = VK_RETURN then begin
    if edFilter.Focused then begin
      vstModules.SetFocus;
      vstModules.ClearSelection;
      vstModules.FocusedNode := nil;
      for Node in vstModules.VisibleNodes(nil) do begin
        if not Assigned(vstModules.FocusedNode) then
          vstModules.FocusedNode := Node;
        vstModules.Selected[Node] := True;
      end;
      if Shift = [ssCtrl] then
        DoSingleModuleLoad;
      Exit;
    end else if cbPreset.Focused then begin
      if acPresetLoad.Execute then begin
        if Shift = [ssCtrl] then begin
          SimulateLoad;
          if btnOK.Enabled then
            btnOK.Click;
        end else
          vstModules.SetFocus;
      end else if acPresetSave.Execute then
        vstModules.SetFocus
      else
        Beep;
      Exit;
    end;
    if (ssCtrl in Shift) or (Length(SelectedModules)=0) then
      DoSingleModuleLoad
    else begin
      SimulateLoad;
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

procedure TfrmModuleSelect.FormShow(Sender: TObject);
var
  Node: PVirtualNode;
begin
  if wbIsDarkMode then
    vstModules.Colors.TreeLineColor := Darker(clWindowText)
  else
    vstModules.Colors.TreeLineColor := clBtnShadow;

  SimulateLoad;
  vstModules.SetFocus;
  vstModules.FocusedNode := nil;
  vstModules.ClearSelection;
  for Node in vstModules.CheckedNodes do begin
    if not Assigned(vstModules.FocusedNode) then
      vstModules.FocusedNode := Node;
    vstModules.Selected[Node] := True;
    Break;
  end;
  if not Assigned(vstModules.FocusedNode) then begin
    vstModules.FocusedNode := vstModules.GetFirstVisible;
    vstModules.Selected[vstModules.FocusedNode] := True;
  end;
  if Length(SelectedModules) = 1 then begin
    vstModules.CheckState[vstModules.FocusedNode] := csUncheckedNormal;
    with PModuleNodeData(vstModules.GetNodeData(vstModules.FocusedNode))^ do
      if Assigned(mndModule) then
        Exclude(mndModule.miFlags, SelectFlag);
  end;
end;

function TfrmModuleSelect.GetPresetsSection: string;
begin
  Result := Name + '_' + PresetCategory + '_Presets';
end;

function TfrmModuleSelect.GetSelectedOrAll: TNodeArray;
var
  Node : PVirtualNode;
  i, j : Integer;
begin
  Result := vstModules.GetSortedSelection(True);
  if Length(Result) < 2 then begin
    SetLength(Result, vstModules.RootNode.ChildCount);
    Node := vstModules.RootNode.FirstChild;
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
      if (Node.Parent = nil) or (Node.Parent = vstModules.RootNode) then begin
        if i <> j then
          Result[j] := Result[i];
        Inc(j);
      end;
  end;

  SetLength(Result, j);
end;

function TfrmModuleSelect.IsPresetDifferent(const aPreset: string): Boolean;
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
    for i := Low(FilteredModules) to High(FilteredModules) do
      with FilteredModules[i]^ do
        slCurrent.Add(miName);

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

procedure TfrmModuleSelect.acPresetDeleteExecute(Sender: TObject);
begin
  PresetDelete(cbPreset.Text);
end;

procedure TfrmModuleSelect.acPresetDeleteUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled :=
    Assigned(frmMain.Settings) and
    frmMain.Settings.ValueExists(GetPresetsSection, cbPreset.Text);
end;

procedure TfrmModuleSelect.acPresetLoadExecute(Sender: TObject);
begin
  PresetLoad(cbPreset.Text);
end;

procedure TfrmModuleSelect.acPresetLoadUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled :=
    (cbPreset.Text = csPluginsTxt) or
    (Assigned(frmMain.Settings) and frmMain.Settings.ValueExists(GetPresetsSection, cbPreset.Text));
end;

procedure TfrmModuleSelect.acPresetSaveExecute(Sender: TObject);
begin
  PresetSave(cbPreset.Text, False);
end;

procedure TfrmModuleSelect.acPresetSaveUpdate(Sender: TObject);
var
  s: string;
begin
  s := string(cbPreset.Text).Replace('=', '', [rfReplaceAll]).Trim;
  TAction(Sender).Enabled :=
    (cbPreset.Text = s) and
    (s <> '') and
    (s[1] <> '<') and
    (Length(FilteredModules) > 0);
end;

procedure TfrmModuleSelect.AllowCancel;
var
  Left: Integer;
begin
  btnCancel.Enabled := True;
  btnCancel.Visible := True;
  Left := btnCancel.Left;
  btnCancel.Left := btnOK.Left;
  btnOK.Left := Left;
end;

procedure TfrmModuleSelect.cbPresetKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #0;
end;

function TfrmModuleSelect.CheckStateForModule(aModule: PwbModuleInfo; aIsRootChild: Boolean): TCheckState;
begin
  with aModule^ do
    if aIsRootChild then begin
      if SelectFlag in miFlags then
        Result := csCheckedNormal
      else if (SelectFlag = mfActive) and (mfLoaded in miFlags) then
        Result := csMixedNormal
      else
        Result := csUncheckedNormal;
    end else begin
      if SelectFlag in miFlags then
        Result := csCheckedDisabled
      else if (SelectFlag = mfActive) and (mfLoaded in miFlags) then
        Result := csMixedDisabled
      else
        Result := csUncheckedDisabled;
    end;
end;

function TfrmModuleSelect.ShowModal: Integer;
begin
  vstModules.Clear;
  if Length(AllModules) < 1 then
    AllModules := wbModulesByLoadOrder.FilteredByFlag(mfValid).FilteredByFlag(FilterFlag);
  vstModules.ChildCount[nil] := Length(AllModules);
  vstModules.InitRecursive(nil, 100, False);

  if PresetCategory <> '' then begin
    PresetsUpdate;
  end else begin
    lblPreset.Visible := False;
    cbPreset.Visible := False;
    acPresetDelete.Visible := False;
    acPresetSave.Visible := False;
    acPresetLoad.Visible := False;
    edFilter.Width := (vstModules.Left + vstModules.Width) - edFilter.Left;
  end;

  if Length(AllModules) < 1 then
    Result := mrCancel
  else
    Result := inherited ShowModal;

  if Result <> mrOk then begin
    SelectedModules := nil;
    FilteredModules := nil;
  end else
    SimulateLoad;

  if Length(FilteredModules) < 1 then
    Result := mrCancel;

  if (Result = mrOk) and (LoadedPreset <> '') and IsPresetDifferent(LoadedPreset) then
    PresetSave(LoadedPreset, True);
end;

procedure TfrmModuleSelect.SimulateLoad;
var
  Error           : string;
begin
  Error := '';
  try
    if SelectFlag = mfActive then begin
      SelectedModules := AllModules.SimulateLoad;
      FilteredModules := SelectedModules.FilteredByFlag(SelectFlag).FilteredByFlag(FilterFlag);
    end else begin
      SelectedModules := AllModules.FilteredByFlag(SelectFlag).FilteredByFlag(FilterFlag);
      FilteredModules := SelectedModules;
    end;

    if Length(FilteredModules) < MinSelect then
      if Length(FilteredModules) = 0 then
        Error := 'No modules selected'
      else
        Error := 'Less than ' + MinSelect.ToString + ' modules selected';

    if Length(FilteredModules) > MaxSelect then
      if MaxSelect = 1 then
        Error := 'More than 1 module selected'
      else
        Error := 'More than ' + MaxSelect.ToString + ' modules selected';

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
  vstModules.Invalidate;
end;

procedure TfrmModuleSelect.vstModulesBeforeGetCheckState(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  with PModuleNodeData(Sender.GetNodeData(Node))^ do begin
    if Assigned(mndModule) then begin
      Inc(ChangingChecked);
      try
        vstModules.CheckState[Node] := CheckStateForModule(mndModule,
          (Node.Parent = nil) or (Node.Parent = Sender.RootNode));
      finally
        Dec(ChangingChecked);
      end;
    end;
  end;
end;

procedure TfrmModuleSelect.vstModulesChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  if ChangingChecked < 1 then
    with PModuleNodeData(Sender.GetNodeData(Node))^ do
      if Assigned(mndModule) then
        with mndModule^ do begin
          if SelectFlag in miFlags then
            Exclude(miFlags, SelectFlag)
          else
            Include(miFlags, SelectFlag);
          SimulateLoad;
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


procedure TfrmModuleSelect.vstModulesCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  NodeData1, NodeData2: PModuleNodeData;
  Module1, Module2: PwbModuleInfo;
begin
  NodeData1 := Sender.GetNodeData(Node1);
  NodeData2 := Sender.GetNodeData(Node2);
  Module1 := NodeData1.mndModule;
  Module2 := NodeData2.mndModule;

  if Assigned(Module1) then begin
    if Assigned(Module2) then begin
      Result := 0;
      case Column of
        0: Result := CompareText(NodeData1.mndName, NodeData2.mndName);
        2: Result := CmpBool(mfHasESMFlag in Module1.miFlags, mfHasESMFlag in Module2.miFlags);
        3: Result := CmpBool(mfHasESLFlag in Module1.miFlags, mfHasESLFlag in Module2.miFlags);
        4: Result := CmpI32(Module1.miLoadOrder, Module2.miLoadOrder);
        5: Result := CompareText(Module1.miFileID.ToString, Module2.miFileID.ToString);
      end;
    end else
      Result := -1;
  end else
    if Assigned(Module2) then
      Result := 1;

  if Result = 0 then
    Result := CmpI32(NodeData1.mndIndex, NodeData2.mndIndex);
end;

procedure TfrmModuleSelect.vstModulesFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  with PModuleNodeData(Sender.GetNodeData(Node))^ do begin
    mndModule := nil;
    mndName := '';
  end;
end;

procedure TfrmModuleSelect.vstModulesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
begin
  Celltext := '';
  with PModuleNodeData(Sender.GetNodeData(Node))^ do begin
    if Assigned(mndModule) then
      with mndModule^ do
        case Column of
          0 : CellText := miName;
          1 : CellText := LoadOrderDescription;
          2 : if mfHasESMFlag in miFlags then Celltext := 'ESM';
          3 : if mfHasESLFlag in miFlags then Celltext := 'ESL';
          4 : if miLoadOrder < 10000 then Celltext := miLoadOrder.ToString;
          5 : if miLoadOrder < 10000 then Celltext := miFileID.ToString;
        end
    else
      if Column = 0 then
        CellText := mndName;
  end;
end;

procedure TfrmModuleSelect.vstModulesHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
begin
  with HitInfo do begin
    if Button <> mbLeft then
      Exit;

    if Sender.SortColumn = Column then
      if Sender.SortDirection = sdAscending then
        Sender.SortDirection := sdDescending
      else
        Sender.SortDirection := sdAscending
    else begin
      Sender.SortColumn := Column;
    end;
    vstModules.ScrollIntoView(vstModules.FocusedNode, True);
  end;
end;

procedure TfrmModuleSelect.vstModulesIncrementalSearch(Sender: TBaseVirtualTree;
  Node: PVirtualNode; const SearchText: string; var Result: Integer);
var
  CompareText                 : string;
  i: Integer;
begin
  Result := 1;
  CompareText := '';

  if (Node.Parent = nil) or (Node.Parent = Sender.RootNode) then
    with PModuleNodeData(Sender.GetNodeData(Node))^ do
      CompareText := mndName;

  if Length(SearchText) > Length(CompareText) then
    Exit;

  for i := 1 to Length(SearchText) do
    if UpCase(SearchText[i]) <> UpCase(CompareText[i]) then
      Exit;

  Result := 0;
end;

procedure TfrmModuleSelect.vstModulesInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
begin
  with PModuleNodeData(Sender.GetNodeData(Node))^ do begin
    if Assigned(mndModule) then
      ChildCount := Length(mndModule.miMasters);
  end;
end;

procedure TfrmModuleSelect.vstModulesInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  NodeData: PModuleNodeData;
  ParentNodeData: PModuleNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  with NodeData^ do begin
    mndIndex := Node.Index;
    if not Assigned(mndModule) then
      if not Assigned(ParentNode) or (ParentNode = Sender.RootNode) then begin
        mndModule := AllModules[Node.Index];
      end else begin
        ParentNodeData := Sender.GetNodeData(ParentNode);
        if Assigned(ParentNodeData.mndModule) then
          with ParentNodeData.mndModule^ do begin
            mndModule := miMasters[Node.Index];
            mndName := miMasterNames[Node.Index];
          end
        else begin
          Include(InitialStates, ivsHidden);
          Exit;
        end;
      end;
    vstModules.CheckType[Node] := ctCheckBox;
    if Assigned(mndModule) then begin
      mndName := mndModule.miName;
      if Length(mndModule.miMasters) > 0 then
        Include(InitialStates, ivsHasChildren);
      if not (FilterFlag in mndModule.miFlags) then
        Include(InitialStates, ivsDisabled);
     if mfMastersMissing in mndModule.miFlags then
        Include(InitialStates, ivsDisabled);
    end else
      Include(InitialStates, ivsDisabled);
  end;
end;

procedure TfrmModuleSelect.vstModulesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  FirstVisible: PVirtualNode;
begin
  if Key = VK_UP then
    if Shift = [] then begin
      FirstVisible := vstModules.GetFirstVisible;
      if not Assigned(FirstVisible) or (vstModules.FocusedNode = FirstVisible) then
        edFilter.SetFocus;
    end;
end;

procedure TfrmModuleSelect.vstModulesKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '?' then
    edFilter.SetFocus
  else if Key = '|' then
    cbPreset.SetFocus;
end;

procedure TfrmModuleSelect.vstModulesNodeDblClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
begin
  if not wbRequireCtrlForDblClick or (GetKeyState(VK_CONTROL) < 0) then
    with HitInfo do
      if Assigned(HitNode) then
        DoSingleModuleLoad(HitNode);
end;

procedure TfrmModuleSelect.vstModulesPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  with PModuleNodeData(Sender.GetNodeData(Node))^ do begin
    if (Node.Parent = nil) or (Node.Parent = Sender.RootNode) then begin
      if Assigned(mndModule) then
        with mndModule^ do begin
          if mfGhost in miFlags  then
            TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsItalic]
          else
            TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsItalic];
        end;
    end else
      TargetCanvas.Font.Color := vstModules.Colors.DisabledColor;
    if not Assigned(mndModule) or (mfMastersMissing in mndModule.miFlags) then
      TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsStrikeOut]
    else
      TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsStrikeOut];
  end;
end;

end.
