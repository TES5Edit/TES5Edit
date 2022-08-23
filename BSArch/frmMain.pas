{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

{$WARN SYMBOL_PLATFORM OFF}
unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Menus, System.Types, System.UITypes, System.StrUtils, System.IniFiles,
  Vcl.Themes, wbAssets, wbBSArchive, Vcl.Styles.Utils.SystemMenu;

const
  WM_PACK = WM_USER + 3;

type
  TFormMain = class(TForm)
    pnlFilter: TPanel;
    lblAssets: TLabel;
    edFilter: TLabeledEdit;
    vtAssets: TVirtualStringTree;
    rbAll: TRadioButton;
    rbCompressed: TRadioButton;
    rbUncompressed: TRadioButton;
    mnAssets: TPopupMenu;
    dlgSameAsset: TTaskDialog;
    mniAssetRemoveSelected: TMenuItem;
    mniAssetRemoveUnselected: TMenuItem;
    mniAssetCompressed: TMenuItem;
    mniAssetUncompressed: TMenuItem;
    mniAssetEdit: TMenuItem;
    mniAssetReplace: TMenuItem;
    mniAssetUnpack: TMenuItem;
    N1: TMenuItem;
    btnFilterReset: TButton;
    Panel1: TPanel;
    btnPack: TButton;
    btnExit: TButton;
    N2: TMenuItem;
    mniAssetUnpackSaveAs: TMenuItem;
    mniAssetPack: TMenuItem;
    N3: TMenuItem;
    mniArchiveInfo: TMenuItem;
    pnlTip: TPanel;
    lblTip: TLabel;
    dlgPackingCheck: TTaskDialog;
    btnClearList: TButton;
    timerFilter: TTimer;
    mniLoadList: TMenuItem;
    mniSaveList: TMenuItem;
    N4: TMenuItem;
    procedure vtAssetsCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vtAssetsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtAssetsHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure vtAssetsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure edFilterKeyPress(Sender: TObject; var Key: Char);
    procedure rbAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure vtAssetsChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure mniAssetRemoveSelectedClick(Sender: TObject);
    procedure mnAssetsPopup(Sender: TObject);
    procedure mniAssetRemoveUnselectedClick(Sender: TObject);
    procedure mniAssetCompressedClick(Sender: TObject);
    procedure mniAssetUncompressedClick(Sender: TObject);
    procedure mniAssetEditClick(Sender: TObject);
    procedure mniAssetReplaceClick(Sender: TObject);
    procedure vtAssetsBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure mniAssetUnpackClick(Sender: TObject);
    procedure btnFilterResetClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure mniAssetUnpackSaveAsClick(Sender: TObject);
    procedure btnPackClick(Sender: TObject);
    procedure mniAssetPackClick(Sender: TObject);
    procedure mniArchiveInfoClick(Sender: TObject);
    procedure vtAssetsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnClearListClick(Sender: TObject);
    procedure timerFilterTimer(Sender: TObject);
    procedure mniLoadListClick(Sender: TObject);
    procedure mniSaveListClick(Sender: TObject);
    procedure vtAssetsDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Assets: TList;
    FilteredAssets: TAssets;
    FilteredCount: Integer;
    Options: TPackingOptions;
    Settings: TMemIniFile;
    Theme: string;
    DefaultListFileName: string;
    ListFileName: string;
    bAutoMode: Boolean;
    TempFolder: string;

    procedure DialogMessage(const aText: string);
    procedure DialogError(const aText: string);
    function DialogYesNo(const aText: string): Boolean;
    procedure AddAssetsFromFiles(aList: TStrings);
    procedure RefreshAssets(const aAssets: TAssets = nil);
    procedure RefreshFilterLabel;
    function GetSelectedAssets: TAssets;
    function SaveList(const aFileName: string; bIgnoreErrors: Boolean = False): Boolean;
    function LoadList(const aFileName: string; bIgnoreErrors: Boolean = False): Boolean;
    function PreloadArchives(const aForAssets: TAssets): Boolean;
    procedure UnpackAssets(Assets: TAssets);
    procedure PackAssets(Assets: TAssets);
    function BeforePackingChecks(const Assets: TAssets): Boolean;
    function AfterPackingChecks(const aArchiveName: string;
      aArchiveType: TBSArchiveType; aSize: Int64): Boolean;

    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure WMDropFiles(var msg: TWMDropFiles); message WM_DROPFILES;
    procedure WMPack(var msg: TMessage); message WM_PACK;
    procedure WndProc(var Message: TMessage); override;
  end;

  TAssetNode = record
    Asset: TAsset;
  end;
  PAssetNode = ^TAssetNode;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  WinApi.ShellApi,
  System.Zip,
  ClipBrd,
  wbTaskProgress,
  JsonDataObjects,
  frmSearchReplace,
  frmArchiveInfo,
  frmPack;

//============================================================================
function ListSortAssetName(Item1, Item2: Pointer): Integer;
begin
  Result := CompareText(TAsset(Item1).AssetName, TAsset(Item2).AssetName);
end;

//============================================================================
function IterArchiveFiles(bsa: TwbBSArchive; const aFileName: string;
  aFileRecord: Pointer; aFolderRecord: Pointer; aData: Pointer): Boolean;
var
  Compressed: Boolean;
begin
  case bsa.ArchiveType of
    baTES4, baFO3, baSSE: Compressed := PwbBSFileTES4(aFileRecord).Compressed(bsa);
    baFO4, baFO4dds:      Compressed := PwbBSFileFO4(aFileRecord).Compressed(bsa);
    else                  Compressed := False;
  end;

  TList(aData).Add(CreateAsset(
    aFileName,
    StringReplace(aFileName, '/', '\', [rfReplaceAll]),
    bsa.FileName,
    Compressed
  ));
  Result := False;
end;

//============================================================================
procedure TFormMain.AddAssetsFromFiles(aList: TStrings);
type
  TCollisionOperation = (opNone, opReplace, opSkip, opAdd);
var
  NewAssets: TList;
  SortedAssets: TStringList;
  i, j: Integer;
  f: string;
begin
  NewAssets := TList.Create;
  SortedAssets := TStringList.Create;

  try

  for i := 0 to Pred(aList.Count) do begin
    f := aList[i];

    if TFileAttribute.faDirectory in TPath.GetAttributes(f) then begin
      for var ff in TDirectory.GetFiles(f, '*.*', TSearchOption.soAllDirectories) do
        if not IsSkippedFile(ff) then
          NewAssets.Add(CreateAsset(ff));
    end

    else if IsArchive(f) then
      ArchiveManager.OpenArchive(f).IterateFiles(IterArchiveFiles, NewAssets, True)

    else
      //if not IsSkippedFile(f) then
        NewAssets.Add(CreateAsset(f));
  end;

  // sort by asset name
  NewAssets.Sort(ListSortAssetName);

  // checking for asset name collisions
  var Collisions: TArray<TAsset>;
  SetLength(Collisions, NewAssets.Count);

  // list of existing assets sorted by name to speed up searching
  for i := 0 to Pred(Assets.Count) do
    SortedAssets.AddObject(TAsset(Assets[i]).AssetName, Assets[i]);

  SortedAssets.Sorted := True;

  var op := opNone;

  for i := 0 to Pred(NewAssets.Count) do begin
    var newasset := TAsset(NewAssets[i]);
    j := SortedAssets.IndexOf(newasset.AssetName);
    if j = -1 then
      Continue;

    var oldasset := TAsset(SortedAssets.Objects[j]);

    // decide what to do with collisions, asked once
    // don't ask if assets are the same
    if (op = opNone) and not newasset.Equals(oldasset) then begin
      dlgSameAsset.Caption := Caption;
      dlgSameAsset.CustomMainIcon := Application.Icon;
      dlgSameAsset.Text := Format(
        'Asset Name already exists:'#13 +
        '%s'#13#13 +
        'Old Source File:'#13 +
        '%s'#13#13 +
        'New Source File:'#13 +
        '%s',
        [
          newasset.AssetName,
          oldasset.FileNameDescr,
          newasset.FileNameDescr
        ]
      );

      dlgSameAsset.Execute;
      case dlgSameAsset.ModalResult of
        100: op := opReplace;
        101: op := opSkip;
        102: op := opAdd;
        else Exit;
      end;
    end;
    Collisions[i] := TAsset(SortedAssets.Objects[j]);
  end;

  // at this point op = opNone if there were no collisions, or collisions but
  // assets are same (we are gonna skip them)
  for i := 0 to Pred(NewAssets.Count) do begin
    var a: TAsset := NewAssets[i];
    if Assigned(Collisions[i]) then
      case op of
        opReplace: begin
         Collisions[i].FileName := a.FileName;
         Collisions[i].ArchiveName := a.ArchiveName;
        end;
        opSkip, opNone: ;
        opAdd: begin
          Assets.Add(a);
          NewAssets[i] := nil;
        end;
      end
    else begin
      Assets.Add(a);
      NewAssets[i] := nil;
    end;
  end;

  finally
    for i := 0 to Pred(NewAssets.Count) do
      if Assigned(NewAssets[i]) then TAsset(NewAssets[i]).Free;

    NewAssets.Free;
    SortedAssets.Free;
  end;
end;

//============================================================================
procedure TFormMain.WMDropFiles(var msg: TWMDropFiles);
var
  i, cnt: integer;
  fileName: array[0..MAX_PATH] of char;
  f: string;
  sl: TStringList;
begin
  sl := TStringList.Create;
  sl.Duplicates := dupIgnore;
  try
    cnt := DragQueryFile(msg.Drop, $FFFFFFFF, fileName, MAX_PATH);
    for i := 0 to Pred(cnt) do begin
      DragQueryFile(msg.Drop, i, fileName, MAX_PATH);
      f := fileName;
      sl.Add(f);
    end;

    AddAssetsFromFiles(sl);
  finally
    DragFinish(msg.Drop);
    sl.Free;
  end;

  RefreshAssets;
end;

//============================================================================
procedure TFormMain.WMPack(var msg: TMessage);
begin
  btnPack.Click;
end;

procedure TFormMain.WndProc(var Message: TMessage);
begin
  if Message.Msg = CM_CUSTOMSTYLECHANGED then begin
    //wbDarkMode := wbIsDarkMode;
    var StyleName := TStyleManager.ActiveStyle.Name;
    if Assigned(Settings) then
      if Settings.ReadString('UI', 'Theme', '') <> StyleName then begin
        Settings.WriteString('UI', 'Theme', StyleName);
        try Settings.UpdateFile; except end;
      end;
  end;
  inherited;
end;

//============================================================================
procedure TFormMain.CreateWnd;
begin
  inherited;
  DragAcceptFiles(WindowHandle, True);
end;

//============================================================================
procedure TFormMain.DestroyWnd;
begin
  DragAcceptFiles(WindowHandle, False);
  inherited;
end;

//============================================================================
procedure TFormMain.edFilterKeyPress(Sender: TObject; var Key: Char);
begin
  timerFilter.Enabled := False;
  if Ord(Key) = VK_RETURN then begin
    Key := #0;
    RefreshAssets;
  end else
    timerFilter.Enabled := True;
end;

//============================================================================
procedure TFormMain.btnFilterResetClick(Sender: TObject);
begin
  edFilter.Text := '';
  rbAll.Checked := True;
  RefreshAssets;
end;

//============================================================================
procedure TFormMain.DialogMessage(const aText: string);
begin
  with TTaskDialog.Create(Self) do try
    Text := aText;
    Caption := Application.Title;
    Flags := [tfAllowDialogCancellation, tfUseHiconMain, tfPositionRelativeToWindow, tfSizeToContent];
    CustomMainIcon := Application.Icon;
    CommonButtons := [tcbOk];
    Execute;
  finally
    Free;
  end;
end;

//============================================================================
procedure TFormMain.DialogError(const aText: string);
begin
  with TTaskDialog.Create(Self) do try
    Text := aText;
    Caption := Application.Title;
    Flags := [tfAllowDialogCancellation, tfPositionRelativeToWindow, tfSizeToContent];
    MainIcon := tdiError;
    CommonButtons := [tcbOk];
    Execute;
  finally
    Free;
  end;
end;

//============================================================================
function TFormMain.DialogYesNo(const aText: string): Boolean;
begin
  with TTaskDialog.Create(Self) do try
    Text := aText;
    Caption := Application.Title;
    Flags := [tfAllowDialogCancellation, tfUseHiconMain, tfPositionRelativeToWindow, tfSizeToContent];
    CustomMainIcon := Application.Icon;
    CommonButtons := [tcbYes, tcbNo];
    Execute;
    Result := ModalResult = mrYes;
  finally
    Free;
  end;
end;

//============================================================================
procedure TFormMain.vtAssetsBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
const
  cArchHighlight: array [Boolean, 0..1] of TColor = (
    ($00D9FFFF, $00EBFFFF),
    ($00002929, $00002424)
  );
begin
  var Asset := PAssetNode(Sender.GetNodeData(Node)).Asset;
  if Asset.ArchiveName = '' then
    Exit;

  TargetCanvas.Brush.Color := cArchHighlight[Theme <> 'Windows'][Succ(Column) mod 2];
  TargetCanvas.FillRect(CellRect);
end;

//============================================================================
procedure TFormMain.vtAssetsChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  PAssetNode(Sender.GetNodeData(Node)).Asset.Compressed := Node.CheckState = csCheckedNormal;
end;

//============================================================================
procedure TFormMain.vtAssetsCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Asset1, Asset2: TAsset;
begin
  Result := 0;
  Asset1 := PAssetNode(Sender.GetNodeData(Node1)).Asset;
  Asset2 := PAssetNode(Sender.GetNodeData(Node2)).Asset;

  case Column of
    0: Result := CompareText(Asset1.AssetName, Asset2.AssetName);
    1: Result := CompareText(Asset1.FileName, Asset2.FileName);
  end;
end;

//============================================================================
procedure TFormMain.vtAssetsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Data: PAssetNode;
begin
  Data := Sender.GetNodeData(Node);

  with Data.Asset do
  case Column of
    0: CellText := AssetName;
    1: CellText := FileNameDescr;
  end;
end;

//============================================================================
procedure TFormMain.vtAssetsHeaderClick(Sender: TVTHeader;
  HitInfo: TVTHeaderHitInfo);
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
    vtAssets.ScrollIntoView(vtAssets.FocusedNode, True);
  end;
end;

//============================================================================
procedure TFormMain.vtAssetsInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PAssetNode;
begin
  Data := Sender.GetNodeData(Node);
  Data.Asset := FilteredAssets[Node.Index];
  Node.CheckType := ctTriStateCheckBox;
  if Data.Asset.Compressed then
    Node.CheckState := TCheckState.csCheckedNormal
  else
    Node.CheckState := TCheckState.csUncheckedNormal;
end;

//============================================================================
procedure TFormMain.vtAssetsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = Ord('C')) then begin
    var s: string := '';
    for var asset in GetSelectedAssets do begin
      if s <> '' then s := s + #13#10;
      s := s + asset.AssetName;
    end;
    Clipboard.AsText := s;
  end;
end;
//============================================================================

//============================================================================
procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not bAutoMode then
    SaveList(DefaultListFileName, True);

  if TempFolder <> '' then
    TDirectory.Delete(TempFolder, True);

  if Assigned(Settings) then begin
    for var i := 0 to Pred(vtAssets.Header.Columns.Count) do
      Settings.WriteInteger(Name, 'vtAssetsColumnWidth' + IntToStr(i), vtAssets.Header.Columns[i].Width);

    if WindowState <> wsMinimized then
      Settings.WriteInteger(Name, 'WindowState', Integer(WindowState));
    if WindowState = wsNormal then begin
      Settings.WriteInteger(Name, 'Left', Left);
      Settings.WriteInteger(Name, 'Top', Top);
      Settings.WriteInteger(Name, 'Width', Width);
      Settings.WriteInteger(Name, 'Height', Height);
    end;

    try Settings.UpdateFile; except end;
  end;

  for var i: Integer := 0 to Pred(Assets.Count) do
    TAsset(Assets[i]).Free;
  Assets.Free;

  if Assigned(Settings) then
    FreeAndNil(Settings);
end;

//============================================================================
procedure TFormMain.FormCreate(Sender: TObject);
begin
  with TVclStylesSystemMenu.Create(Self) do begin
    ShowNativeStyle := True;
    MenuCaption := 'Theme';
  end;

  Application.Title := Application.Title + ' ' + csBSAVersion;
  Caption := Application.Title;
  Assets := TList.Create;
  lblTip.Caption :=
    'Drag&drop folders, files and existing Bethesda archives to populate assets list'#13 +
    'Manage compression and asset names using right click menu (Shift+Click, Ctrl+Click or Ctrl+A to change selection)'#13 +
    'Click "Pack" when ready to create a new archive from all assets in the list';
  pnlTip.Align := alClient;

  // settings file be default in the Home path (AppRoaming)
  // or along with executable if no access there
  var SettingsFolder := TPath.GetHomePath;
  SettingsFolder := TPath.Combine(SettingsFolder, 'BSArchPro');
  if not DirectoryExists(SettingsFolder) then
    if not ForceDirectories(SettingsFolder) then
      SettingsFolder := ExtractFilePath(ParamStr(0));

  Settings := TMemIniFile.Create(TPath.Combine(SettingsFolder, 'BSArchPro.ini'));
  Options.LoadSettings(Settings);

  TStyleManager.TrySetStyle(Settings.ReadString('UI', 'Theme', TStyleManager.ActiveStyle.Name), False);

  // skip reading form position if Shift is pressed
  if GetKeyState(VK_SHIFT) >= 0 then begin
    var i := Settings.ReadInteger(Name, 'Left', Left);
    var j := Settings.ReadInteger(Name, 'Top', Top);
    var k := Settings.ReadInteger(Name, 'Width', Width);
    var l := Settings.ReadInteger(Name, 'Height', Height);
    var Rect := Screen.WorkAreaRect;
    if (j >= Rect.Top) and
       (i >= Rect.Left) and
       (i + k <= Rect.Right) and
       (j + l <= Rect.Bottom)
    then begin
      Left := i;
      Top := j;
      Width := k;
      Height := l;
    end;
    WindowState := TWindowState(Settings.ReadInteger(Name, 'WindowState', Integer(WindowState)));
    for i := 0 to Pred(vtAssets.Header.Columns.Count) do
      vtAssets.Header.Columns[i].Width := Settings.ReadInteger(Name, 'vtAssetsColumnWidth' + IntToStr(i), vtAssets.Header.Columns[i].Width);
  end;

  ListFileName := Settings.ReadString('General', 'ListFileName', ExtractFilePath(ParamStr(0) + 'New' + cBSArchExtension));
  DefaultListFileName := TPath.Combine(SettingsFolder, 'Default' + cBSArchExtension);

  // something in the command line
  if ParamCount <> 0 then begin
    // .bsarch list is provided, autopacking mode
    if SameText(TPath.GetExtension(ParamStr(1)), cBSArchExtension) and FileExists(ParamStr(1)) then begin
      LoadList(ParamStr(1));
      bAutoMode := True;
      PostMessage(Handle, WM_PACK, 0, 0);
      Exit;
    end;
    // or just file(s) to add to the list
    var sl := TStringList.Create;
    sl.Sorted := True;
    sl.Duplicates := dupIgnore;
    try
      for var i := 1 to ParamCount do begin
        var f := ParamStr(i);
        if not TPath.IsPathRooted(f) then
          f := TPath.GetFullPath(f);
        if TFile.Exists(f) or TDirectory.Exists(f) then
          sl.Add(f);
      end;
      AddAssetsFromFiles(sl);
    finally
      sl.Free;
    end;
  end
  // empty command line - restore the last session
  else if FileExists(DefaultListFileName) then
    LoadList(DefaultListFileName, False);

  RefreshAssets;
end;

//============================================================================
procedure TFormMain.rbAllClick(Sender: TObject);
begin
  RefreshAssets;
end;

//============================================================================
procedure TFormMain.RefreshFilterLabel;
begin
  lblAssets.Caption := Format('%.0n / %.0n file(s)', [vtAssets.RootNodeCount + 0.0, Assets.Count + 0.0]);

  btnPack.Enabled := Assets.Count <> 0;
  vtAssets.Visible := Assets.Count <> 0;
  pnlTip.Visible := Assets.Count = 0;
end;

//============================================================================
procedure TFormMain.RefreshAssets(const aAssets: TAssets = nil);
var
  i: integer;
  f: string;
  c: TCheckState;
  Asset, FocusedAsset: TAsset;
begin
  FilteredCount := 0;

  FocusedAsset := nil;
  if Assigned(vtAssets.FocusedNode) then
    FocusedAsset := PAssetNode(vtAssets.GetNodeData(vtAssets.FocusedNode)).Asset;

  // show assets from the list only
  if Assigned(aAssets) then begin

    for Asset in aAssets do begin
      if FilteredCount = Length(FilteredAssets) then
        SetLength(FilteredAssets, Length(FilteredAssets) + 4096);

      FilteredAssets[FilteredCount] := Asset;
      Inc(FilteredCount);
    end;

  end

  else begin
    f := edFilter.Text;
    if rbAll.Checked then
      c := TCheckState.csMixedNormal
    else if rbCompressed.Checked then
      c := TCheckState.csCheckedNormal
    else
      c := TCheckState.csUncheckedNormal;

    for i := 0 to Pred(Assets.Count) do begin
      Asset := Assets[i];

      if (f <> '') and
         not ContainsText(Asset.AssetName, f) and
         not ContainsText(Asset.FileName, f) and
         not ContainsText(Asset.ArchiveName, f)
      then
        Continue;

      if (c <> TCheckState.csMixedNormal) and (
        (Asset.Compressed and (c <> TCheckState.csCheckedNormal)) or
        (not Asset.Compressed and (c <> TCheckState.csUncheckedNormal))
      ) then
        Continue;

      if FilteredCount = Length(FilteredAssets) then
        SetLength(FilteredAssets, Length(FilteredAssets) + 4096);

      FilteredAssets[FilteredCount] := Asset;
      Inc(FilteredCount);
    end;
  end;

  vtAssets.Clear;
  vtAssets.RootNodeCount := FilteredCount;
  for var n in vtAssets.Nodes do
    if PAssetNode(vtAssets.GetNodeData(n)).Asset = FocusedAsset then begin
      vtAssets.Selected[n] := True;
      vtAssets.FocusedNode := n;
      vtAssets.ScrollIntoView(n, True);
    end;
  RefreshFilterLabel;
end;

//============================================================================
function TFormMain.GetSelectedAssets: TAssets;
var
  Nodes: TNodeArray;
  i: Integer;
begin
  Nodes := vtAssets.GetSortedSelection(False);
  SetLength(Result, Length(Nodes));
  for i := Low(Nodes) to High(Nodes) do
    Result[i] := PAssetNode(vtAssets.GetNodeData(Nodes[i])).Asset;
end;

//============================================================================
function TFormMain.SaveList(const aFileName: string; bIgnoreErrors: Boolean = False): Boolean;
begin
  Result := False;
  var zip := TZipFile.Create;
  var js := TJsonObject.Create;
  var st := TBytesStream.Create;
  try
    var p := js.O['Packing'];
    p.I['ArchiveType'] := Integer(Options.ArchiveType);
    p.S['ArchiveFileName'] := Options.ArchiveFileName;
    p.I['ArchiveFlags'] := Options.ArchiveFlags;
    p.I['FileFlags'] := Options.FileFlags;
    p.B['AutodetectFlags'] := Options.bAutodetectFlags;
    p.B['MultiThreaded'] := Options.bMultiThreaded;
    p.B['SharedData'] := Options.bSharedData;

    var a := js.A['Assets'];
    for var i := 0 to Pred(Assets.Count) do
      TAsset(Assets[i]).ToJson(a.AddArray);

    try
      zip.Open(aFileName, TZipMode.zmWrite);
      js.SaveToStream(st, True);
      zip.Add(st.Bytes, 'assets.json');
      zip.Close;
      Result := True;
    except
      if not bIgnoreErrors then raise else Exit;
    end;
  finally
    js.Free;
    zip.Free;
    st.Free;
  end;
end;

//============================================================================
function TFormMain.LoadList(const aFileName: string; bIgnoreErrors: Boolean = False): Boolean;
begin
  Result := False;
  var zip := TZipFile.Create;
  var js := TJsonObject.Create;
  var b: TBytes;
  var st: TBytesStream := nil;
  var bZipped := True;
  try
    try
      try
        zip.Open(aFileName, TZipMode.zmRead);
      except
        bZipped := False;
      end;

      if bZipped then begin
        zip.Read('assets.json', b);
        zip.Close;
      end else
        b := TFile.ReadAllBytes(aFileName);

      st := TBytesStream.Create(b);
      js.LoadFromStream(st);
      Result := True;
    except
      if not bIgnoreErrors then raise else Exit;
    end;

    for var i: Integer := 0 to Pred(Assets.Count) do
      TAsset(Assets[i]).Free;
    Assets.Clear;
    ArchiveManager.CloseAll;

    if js.Contains('Packing') then begin
      var p := js.O['Packing'];
      Options.ArchiveType := TBSArchiveType(p.I['ArchiveType']);
      // just in case, could happen when loading lists created by other tools
      if Options.ArchiveType = baNone then
        Options.ArchiveType := High(TBSArchiveType);
      Options.ArchiveFileName := p.S['ArchiveFileName'];
      Options.ArchiveFlags := p.I['ArchiveFlags'];
      Options.FileFlags := p.I['FileFlags'];
      Options.bAutodetectFlags := p.B['AutodetectFlags'];
      Options.bMultiThreaded := p.B['MultiThreaded'];
      Options.bSharedData := p.B['SharedData'];
    end;

    var a := js.A['Assets'];
    for var i := 0 to Pred(a.Count) do begin
      var asset := TAsset.Create;
      asset.FromJson(a.A[i]);
      Assets.Add(asset);
    end;

  finally
    js.Free;
    zip.Free;
    if Assigned(st) then st.Free;
  end;
end;

//============================================================================
procedure TFormMain.timerFilterTimer(Sender: TObject);
begin
  RefreshAssets;
  timerFilter.Enabled := False;
end;

//============================================================================
function TFormMain.PreloadArchives(const aForAssets: TAssets): Boolean;
begin
  var sl := TStringList.Create;
  sl.Sorted := True;
  sl.Duplicates := dupIgnore;

  try
    for var asset in aForAssets do
      if asset.ArchiveName <> '' then
        sl.Add(asset.ArchiveName);

    // unload unneeded ones
    for var i := 0 to Pred(ArchiveManager.Count) do
      if sl.IndexOf(ArchiveManager[i].FileName) = -1 then
        ArchiveManager.CloseArchive(ArchiveManager[i].FileName);

    for var i := 0 to Pred(sl.Count) do try
      ArchiveManager.OpenArchive(sl[i]);
    except
      on E: Exception do begin
        Self.DialogError(E.Message);
        Result := False;
        Exit;
      end;
    end;

  finally
    sl.Free;
  end;

  Result := True;
end;

//============================================================================
procedure TFormMain.mnAssetsPopup(Sender: TObject);
var
  bHasSelection: Boolean;
  asset: TAsset;
begin
  asset := nil;

  bHasSelection := vtAssets.SelectedCount <> 0;
  if bHasSelection then
    asset := PAssetNode(vtAssets.GetNodeData(vtAssets.FocusedNode)).Asset;

  mniAssetEdit.Visible := vtAssets.SelectedCount = 1;
  mniAssetReplace.Visible := bHasSelection;
  mniAssetRemoveSelected.Visible := bHasSelection;
  mniAssetRemoveUnselected.Visible := bHasSelection;
  mniAssetCompressed.Visible := bHasSelection;
  mniAssetUncompressed.Visible := bHasSelection;
  mniAssetUnpack.Visible := Assigned(asset) and (asset.ArchiveName <> '');
  mniAssetUnpackSaveAs.Visible := mniAssetUnpack.Visible;
  mniArchiveInfo.Visible := Assigned(asset) and (asset.ArchiveName <> '');
  mniAssetPack.Visible := bHasSelection;
  mniSaveList.Visible := Assets.Count <> 0;
end;

//============================================================================
procedure TFormMain.mniLoadListClick(Sender: TObject);
begin
  with TFileOpenDialog.Create(Self) do try
    Options := [fdoFileMustExist];
    var f := FileTypes.Add;
    f.DisplayName := 'BSArchPro List (*' + cBSArchExtension + ')';
    f.FileMask := '*' + cBSArchExtension;
    DefaultFolder := ExtractFilePath(ListFileName);
    FileName := ExtractFileName(ListFileName);
    if not Execute then
      Exit;

    LoadList(FileName);
    Settings.WriteString('General', 'ListFileName', FileName);
    btnFilterReset.Click;
  finally
    Free;
  end;
end;

//============================================================================
procedure TFormMain.mniSaveListClick(Sender: TObject);
begin
  with TFileSaveDialog.Create(Self) do try
    var f := FileTypes.Add;
    f.DisplayName := 'BSArchPro List (*' + cBSArchExtension + ')';
    f.FileMask := '*' + cBSArchExtension;
    DefaultFolder := ExtractFilePath(ListFileName);
    FileName := ExtractFileName(ListFileName);
    if not Execute then
      Exit;

    SaveList(TPath.ChangeExtension(FileName, cBSArchExtension));
    Settings.WriteString('General', 'ListFileName', FileName);
  finally
    Free;
  end;
end;

//============================================================================
procedure TFormMain.vtAssetsDblClick(Sender: TObject);
begin
  if vtAssets.SelectedCount <> 1 then
    Exit;

  var asset := PAssetNode(vtAssets.GetNodeData(vtAssets.FocusedNode)).Asset;
  var f: string;
  if asset.ArchiveName <> '' then begin
    TempFolder := TPath.Combine(TPath.GetTempPath, 'BSArchPro');
    f := TPath.Combine(TempFolder, ExtractFileName(asset.ArchiveName));
    f := TPath.Combine(f, asset.AssetName);
    var d := ExtractFilePath(f);
    if not ForceDirectories(d) then begin
      DialogMessage('Unable to create temp folder for extraction:'#13 + d);
      Exit;
    end;

    try
      var data := asset.GetData;
      TFile.WriteAllBytes(f, data);
    except
      on E: Exception do begin
        DialogMessage('Error unpacking:'#13 + asset.FileName + #13#13 + E.Message);
        Exit;
      end;
    end;
  end

  else
    f := asset.FileName;

  // error 31 - no associated application
  if ShellExecute(Handle, 'open', PChar(f), '', '', SW_SHOWNORMAL) = 31 then
    ShellExecute(Handle, 'openas', PChar(f), '', '', SW_SHOWNORMAL);
end;

//============================================================================
procedure TFormMain.mniAssetEditClick(Sender: TObject);
begin
  if vtAssets.SelectedCount <> 1 then
    Exit;

  var asset := PAssetNode(vtAssets.GetNodeData(vtAssets.FocusedNode)).Asset;
  var s := asset.AssetName;
  if not InputQuery('Edit Asset Name', 'Make sure asset name has a folder part and contains valid characters', s) then
    Exit;

  s := s.Trim;
  if s <> '' then
    asset.AssetName := s;

  vtAssets.InvalidateNode(vtAssets.FocusedNode);
end;

//============================================================================
procedure TFormMain.mniAssetReplaceClick(Sender: TObject);
begin
  with TFormSearchReplace.Create(Self) do try

    if ShowModal <> mrOk then
      Exit;

    for var asset in GetSelectedAssets do
      if rbReplace.Checked then
        asset.AssetName := StringReplace(asset.AssetName, SearchText, ReplaceText, [rfReplaceAll, rfIgnoreCase])
      else if rbPrepend.Checked then
        asset.AssetName := SearchText + asset.AssetName
      else if rbAppend.Checked then
        asset.AssetName := asset.AssetName + SearchText;

    vtAssets.Invalidate;
  finally
    Free;
  end;
end;

//============================================================================
procedure TFormMain.mniAssetCompressedClick(Sender: TObject);
begin
  for var node in vtAssets.GetSortedSelection(False) do begin
    PAssetNode(vtAssets.GetNodeData(node)).Asset.Compressed := True;
    node.CheckState := TCheckState.csCheckedNormal;
  end;
  vtAssets.Invalidate;
end;

//============================================================================
procedure TFormMain.mniAssetUncompressedClick(Sender: TObject);
begin
  for var node in vtAssets.GetSortedSelection(False) do begin
    PAssetNode(vtAssets.GetNodeData(node)).Asset.Compressed := False;
    node.CheckState := TCheckState.csUncheckedNormal;
  end;
  vtAssets.Invalidate;
end;

//============================================================================
procedure TFormMain.btnClearListClick(Sender: TObject);
begin
  for var i: Integer := 0 to Pred(Assets.Count) do
    TAsset(Assets[i]).Free;

  Assets.Clear;

  if Assets.Count = 0 then
    ArchiveManager.CloseAll;

  btnFilterReset.Click;
end;

//============================================================================
procedure TFormMain.mniAssetRemoveSelectedClick(Sender: TObject);
begin
  if not DialogYesNo('Remove ' + IntToStr(vtAssets.SelectedCount) + ' selected asset(s)?') then
    Exit;

  if vtAssets.SelectedCount = Assets.Count then begin
    btnClearList.Click;
  end

  else begin
    for var asset in GetSelectedAssets do begin
      Assets.Remove(asset);
      asset.Free;
    end;

    vtAssets.DeleteSelectedNodes;
    RefreshFilterLabel;
  end;

  if Assets.Count = 0 then
    ArchiveManager.CloseAll;
end;

//============================================================================
procedure TFormMain.mniAssetRemoveUnselectedClick(Sender: TObject);
begin
  if not DialogYesNo('Remove ' + IntToStr(Assets.Count - vtAssets.SelectedCount) + ' unselected asset(s)?') then
    Exit;

  var selected := GetSelectedAssets;
  Assets.Clear;
  for var asset in selected do
    Assets.Add(asset);

  RefreshAssets;
  vtAssets.SelectAll(False);

  if Assets.Count = 0 then
    ArchiveManager.CloseAll;
end;

//============================================================================
procedure TFormMain.UnpackAssets(Assets: TAssets);
var
  ErrMessage: string;
  ErrIndex: Integer;
  Folders: TStringList;
  LastUnpackFolder: string;
begin
  Folders := TStringList.Create;
  Folders.Sorted := True;
  Folders.Duplicates := dupIgnore;

  try
    // remove loose files from selection and collect assets folders
    for var i: Integer := High(assets) downto Low(assets) do
      if assets[i].ArchiveName = '' then
        Delete(assets, i, 1)
      else
        Folders.Add(ExtractFilePath(assets[i].AssetName));

    if Length(assets) = 0 then begin
      DialogMessage('No archived files in selection');
      Exit;
    end;

    if not PreloadArchives(assets) then
      Exit;

    LastUnpackFolder := Settings.ReadString('General', 'LastUnpackFolder', ExtractFilePath(ParamStr(0)));

    with TFileOpenDialog.Create(Application.MainForm) do try
      Title := 'Select folder for unpacking';
      Options := [fdoPickFolders, fdoPathMustExist];
      DefaultFolder := LastUnpackFolder;
      if not Execute then
        Exit;

      LastUnpackFolder := IncludeTrailingPathDelimiter(FileName);
      Settings.WriteString('General', 'LastUnpackFolder', LastUnpackFolder);
    finally
      Free;
    end;

    // prepare assets folders
    for var i: integer := 0 to Pred(Folders.Count) do begin
      var f := LastUnpackFolder + Folders[i];
      if not DirectoryExists(f) then
        if not ForceDirectories(f) then begin
          DialogError('Can not create folder:'#13 + f);
          Exit;
        end;
    end;

  finally
    Folders.Free;
  end;

  var ProcUnpack: TProcessProc :=
    procedure(i: Integer) begin
      var data := assets[i].GetData;
      var f: string;
      try
        f := LastUnpackFolder + assets[i].FileName;
        TFile.WriteAllBytes(f, data);
      except
        on E: Exception do
          raise Exception.Create('Error writing:'#13 + f + #13#13 + E.Message);
      end;
    end;


  // single threaded
  //if DebugHook <> 0 then begin
  //  for var i := Low(assets) to High(assets) do
  //    ProcUnpack(i);
  //end else

  // multi threaded
  if wbTaskProgressExecute(
    Self, 'Unpacking...',
    Low(Assets), High(Assets), ProcUnpack, ErrIndex, ErrMessage
  ) = mrAbort then
    DialogError('Error unpacking:'#13 + assets[ErrIndex].FileName + #13#13 + ErrMessage);

end;

//============================================================================
procedure TFormMain.mniAssetUnpackClick(Sender: TObject);
begin
  UnpackAssets(GetSelectedAssets);
end;

//============================================================================
procedure TFormMain.mniAssetUnpackSaveAsClick(Sender: TObject);
var
  SaveFileName: string;
begin
  if vtAssets.SelectedCount = 0 then
    Exit;

  var asset := PAssetNode(vtAssets.GetNodeData(vtAssets.FocusedNode)).Asset;
  SaveFileName := ExtractFileName(asset.FileName);

  with TFileSaveDialog.Create(Application.MainForm) do try
    Title := 'Save As';
    //Options := [fdoPathMustExist];
    FileName := SaveFileName;
    DefaultFolder := Settings.ReadString('General', 'LastUnpackFolder', ExtractFilePath(ParamStr(0)));
    if not Execute then
      Exit;

    SaveFileName := FileName;
    Settings.WriteString('General', 'LastUnpackFolder', ExtractFilePath(FileName));
  finally
    Free;
  end;

  try
    var data := asset.GetData;
    TFile.WriteAllBytes(SaveFileName, data);
  except
    on E: Exception do begin
      DialogError('Error unpacking:'#13 + asset.FileName + #13#13 + E.Message);
    end;
  end;
end;

//============================================================================
function IterShowFileInfo(bsa: TwbBSArchive; const aFileName: string;
  aFileRecord: Pointer; aFolderRecord: Pointer; aData: Pointer): Boolean;
var
  txt: TStringList;
  FileTES3: PwbBSFileTES3;
  FileTES4: PwbBSFileTES4;
  FileFO4: PwbBSFileFO4;
begin
  Result := False;
  txt := TStringList(aData);
  txt.Add(aFileName);
  case bsa.ArchiveType of
    baTES3: begin
      FileTES3 := aFileRecord;
      txt.Add(Format('  Hash1: %s  Hash2: %s  Size: %d', [
        IntToHex(FileTES3.Hash and $FFFFFFFF, 8),
        IntToHex(FileTES3.Hash shr 32, 8),
        FileTES3.Size
      ]));
    end;
    baTES4, baFO3, baSSE: begin
      FileTES4 := aFileRecord;
      txt.Add(Format('  DirHash: %s  NameHash: %s  %sSize: %d', [
        IntToHex(PwbBSFolderTES4(aFolderRecord).Hash, 8),
        IntToHex(FileTES4.Hash, 16),
        IfThen(FileTES4.Compressed(bsa), 'Packed', ''),
        FileTES4.RawSize
      ]));
    end;
    baFO4, baFO4dds: begin
      FileFO4 := aFileRecord;
      txt.Add(Format('  DirHash: %s  NameHash: %s  Ext: %s', [
        IntToHex(FileFO4.DirHash, 8),
        IntToHex(FileFO4.NameHash, 8),
        string(FileFO4.Ext)
      ]));
      if bsa.ArchiveType = baFO4 then
        txt.Add(Format('  Size: %d  PackedSize: %d', [FileFO4.Size, FileFO4.PackedSize]))
      else if bsa.ArchiveType = baFO4dds then begin
        txt.Add(Format('  Width: %04d  Height: %04d  CubeMap: %s  Format: %s', [
          FileFO4.Width,
          FileFO4.Height,
          IfThen(FileFO4.CubeMaps and 1 <> 0, 'Yes', 'No'),
          FileFO4.DXGIFormatName.Replace('DXGI_FORMAT_', '')
        ]));
        for var i := Low(FileFO4.TexChunks) to High(FileFO4.TexChunks) do
          txt.Add(Format('    MipMaps %.2d-%.2d  Size: %8d  PackedSize: %8d', [
            FileFO4.TexChunks[i].StartMip,
            FileFO4.TexChunks[i].EndMip,
            FileFO4.TexChunks[i].Size,
            FileFO4.TexChunks[i].PackedSize
          ]));
      end;
    end;
  end;
  txt.Add('');
end;

 //============================================================================
procedure TFormMain.mniArchiveInfoClick(Sender: TObject);
var
  txt: TStringList;
  bsa: TwbBSArchive;
  s, s2: string;
begin
  var asset := PAssetNode(vtAssets.GetNodeData(vtAssets.FocusedNode)).Asset;
  try
    bsa := ArchiveManager.OpenArchive(asset.ArchiveName);
  except
    on E: Exception do begin
      DialogError(E.Message);
      Exit;
    end;
  end;

  txt := TStringList.Create;
  with TFormArchiveInfo.Create(Self) do try
    txt.Add(Format('%014s: %s', ['Archive Name', bsa.FileName]));
    txt.Add(Format('%014s: %s', ['Format', bsa.FormatName]));
    if bsa.ArchiveType <> baTES3 then
      txt.Add(Format('%014s: 0x%s', ['Version', IntToHex(bsa.Version, 2)]));
    txt.Add(Format('%014s: %d', ['Files', bsa.FileCount]));
    // flags
    if bsa.ArchiveType in [baTES4, baFO3, baSSE] then begin
      txt.Add(Format('%014s: 0x%s%020s: 0x%s', [
        'Archive Flags', IntToHex(bsa.ArchiveFlags, 8),
        'File Flags', IntToHex(bsa.FileFlags, 8)
      ]));
      for var i := 0 to 10 do begin
        if (bsa.ArchiveFlags shr i) and 1 = 1 then s := '*' else s := ' ';
        if cArchiveFlagNames[i] <> '' then
          s := s + cArchiveFlagNames[i]
        else
          s := s + 'Bit ' + IntToStr(i);
        s := Format('%16s%s', [' ', s]);
        if (bsa.FileFlags shr i) and 1 = 1 then s2 := '*' else s2 := ' ';
        if cFileFlagNames[i] <> '' then
          s2 := s2 + cFileFlagNames[i]
        else
          s2 := s2 + 'Bit ' + IntToStr(i);
        txt.Add(Format('%s%s%s', [s, StringOfChar(' ', 48 - Length(s)), s2]));
      end;
    end;
    txt.Add('');
    bsa.IterateFiles(@IterShowFileInfo, txt, True);
    Caption := bsa.FileName + ' - ' + Caption;
    slText := txt;
    aBSA := bsa.FileName;
    aSearch := asset.FileName;
    txt := nil;
    Show;
  finally
    if Assigned(txt) then
      txt.Free;
  end;
end;

//============================================================================
function TFormMain.BeforePackingChecks(const Assets: TAssets): Boolean;
begin
  Result := True;

  var BadAssets: TAssets;
  dlgPackingCheck.Caption := Application.Title;
  dlgPackingCheck.CustomMainIcon := Application.Icon;

  // valid asset names
  for var asset in Assets do
    if not asset.IsValidAssetName then
      BadAssets := BadAssets + [asset];

  if Length(BadAssets) <> 0 then begin
    dlgPackingCheck.Text :=
      'Invalid asset name:'#13 +
      BadAssets[Low(BadAssets)].AssetName + #13#13 +
      'Asset name is empty, contains invalid characters or has no folder part ' +
      '(archives don''t have root folder).';
    dlgPackingCheck.Buttons[1].Enabled := False;
    dlgPackingCheck.Execute;
    if dlgPackingCheck.ModalResult = 100 then
      RefreshAssets(BadAssets);
    Result := False;
    Exit;
  end;


  // skipped files
  for var asset in Assets do
    if IsSkippedFile(asset.FileName) then
      BadAssets := BadAssets + [asset];

  if Length(BadAssets) <> 0 then begin
    dlgPackingCheck.Text :=
      'Packing potentially unwanted file:'#13 +
      BadAssets[Low(BadAssets)].AssetName + #13#13 +
      'This file shouldn''t be packed because the game is unlikely to use it ' +
      'from the archive. Press "Continue" to pack anyway.';
    // enable Continue because this can be ignored
    dlgPackingCheck.Buttons[1].Enabled := True;
    dlgPackingCheck.Execute;
    dlgPackingCheck.Buttons[1].Enabled := False;
    if dlgPackingCheck.ModalResult = 100 then begin
      RefreshAssets(BadAssets);
      Result := False;
      Exit;
    end
    else if dlgPackingCheck.ModalResult = 101 then
      SetLength(BadAssets, 0)
    else begin
      Result := False;
      Exit;
    end;
  end;


  // compressed sound files
  for var asset in Assets do
    if asset.Compressed and asset.AssetName.StartsWith(cAssetSound.Root + '\', True) then
      BadAssets := BadAssets + [asset];

  if Length(BadAssets) <> 0 then begin
    dlgPackingCheck.Text :=
      'Compressed sound file:'#13 +
      BadAssets[Low(BadAssets)].AssetName + #13#13 +
      'Sound files don''t work in the game when compressed. Press "Continue" ' +
      'to compress anyway if you have some sort of a bugfix mod installed to amend that.';
    // enable Continue because this can be ignored
    dlgPackingCheck.Buttons[1].Enabled := True;
    dlgPackingCheck.Execute;
    if dlgPackingCheck.ModalResult = 100 then begin
      RefreshAssets(BadAssets);
      Result := False;
      Exit;
    end
    else if dlgPackingCheck.ModalResult = 101 then
      SetLength(BadAssets, 0)
    else begin
      Result := False;
      Exit;
    end;
  end;


  // find duplicates
  var sl := TStringList.Create;
  try
    for var asset in Assets do
      sl.AddObject(asset.AssetName, asset);
    sl.Sort;
    var s: string := ''; var i: Integer := 0;
    while i < sl.Count do begin
      if SameText(sl[i], s) then begin
        var prevasset := TAsset(sl.Objects[Pred(i)]);
        var asset := TAsset(sl.Objects[i]);
        // found a dup, add previous asset if not added yet
        if (Length(BadAssets) = 0) or (BadAssets[Pred(Length(BadAssets))] <> prevasset) then
          BadAssets := BadAssets + [prevasset];
        // add the current one
        BadAssets := BadAssets + [asset];
      end;
      s := sl[i];
      Inc(i);
    end;
  finally
    sl.Free;
  end;

  if Length(BadAssets) <> 0 then begin
    dlgPackingCheck.Text :=
      'Repeated asset name:'#13 +
      BadAssets[Low(BadAssets)].AssetName + #13#13 +
      'Asset names inside archive must be unique.';
    dlgPackingCheck.Buttons[1].Enabled := False;
    dlgPackingCheck.Execute;
    if dlgPackingCheck.ModalResult = 100 then
      RefreshAssets(BadAssets);
    Result := False;
    Exit;
  end;
end;

//============================================================================
function TFormMain.AfterPackingChecks(const aArchiveName: string;
  aArchiveType: TBSArchiveType; aSize: Int64): Boolean;
begin
  Result := True;

  case aArchiveType of
    baTES3, baTES4, baFO3, baSSE: if aSize > High(Integer) then begin
      DialogMessage(
        Format('Created archive size %.2n MB is too large:'#13'%s'#13#13, [aSize / (1024*1024), aArchiveName]) +
        'Archive size exceeds the game supported limit of 2GB. ' +
        'Pack less assets by selecting part of them, right click -> Pack Selected.'
      );
      Result := False;
    end;
    baFO4, baFO4dds: if aSize > High(Cardinal) then begin
      DialogMessage(
        Format('Created archive size %.2n MB is too large:'#13'%s'#13#13, [aSize / (1024*1024), aArchiveName]) +
        'The game itself has no size limit, however Creation Kit''s limit ' +
        'is 4GB. If you don''t plan on loading this archive into CK then keep it, ' +
        'otherwise pack less assets by selecting part of them, right click -> Pack Selected.'
      );
      Result := False;
    end;
  end;
end;

//============================================================================
var slAssetsDDS: TStringList;

procedure GetDDSInfo(aArchive: TwbBSArchive; const aFileName: string;
  var aInfo: TDDSInfo);
begin
  TAsset(slAssetsDDS.Objects[slAssetsDDS.IndexOf(aFileName)]).GetDDSInfo(aInfo);
end;

//============================================================================
procedure TFormMain.PackAssets(Assets: TAssets);
var
  ErrMessage: string;
  ErrIndex: Integer;
  slFiles: TStringList;
  Threads: Integer;
  NewArchive: TwbBSArchive;
begin
  if Length(Assets) = 0 then
    Exit;

  if not BeforePackingChecks(Assets) then begin
    bAutoMode := False;
    Exit;
  end;

  if not PreloadArchives(Assets) then begin
    bAutoMode := False;
    Exit;
  end;

  // packing options window
  if not bAutoMode then
    with TFormPack.Create(Self) do try
      Color := Self.Color;
      po := @Options;
      lblPack.Caption := Format('Packing %.0n files for', [Length(Assets) + 0.0]);
      if ShowModal <> mrOk then
        Exit;
    finally
      Free;
    end;

  NewArchive := TwbBSArchive.Create;
  NewArchive.MultiThreaded := Options.bMultiThreaded;
  NewArchive.ShareData := Options.bSharedData;
  if not Options.bMultiThreaded then Threads := 1 else Threads := 0;

  // creating files list
  slFiles := TStringList.Create;
  var bCompressArchive := True;
  var pc: TPackingCompression;
  for var asset in Assets do begin
    // FO4 dds archives must be compressed or CTD
    if asset.Compressed or (Options.ArchiveType = baFO4dds) then
      pc := pcCompress
    else begin
      pc := pcUncompress;
      bCompressArchive := False;
    end;

    slFiles.AddObject(asset.AssetName, TObject(pc));
  end;

  // set the Compressed archive flag if all files are to be compressed
  NewArchive.Compress := bCompressArchive;

  try

  // additional preparation for FO4 dds archive
  if Options.ArchiveType = baFO4dds then begin

    // caching DDS files information
    var ProcDDSInfo: TProcessProc :=
      procedure(i: Integer) begin
        var Info: TDDSInfo;
        try
          Assets[i].GetDDSInfo(Info);
        except
          on E: Exception do
            raise Exception.Create('Error reading DDS texture:'#13 + Assets[i].FileNameDescr + #13#13 + E.Message);
        end;
      end;

    case wbTaskProgressExecute(
      Self, 'Scanning textures...',
      Low(Assets), High(Assets), ProcDDSInfo, ErrIndex, ErrMessage
    ) of
      mrAbort: begin
        DialogError('Error scanning textures:'#13 + assets[ErrIndex].FileName + #13#13 + ErrMessage);
        Exit;
      end;
    end;

    // preparing list for our DDS info proc
    slAssetsDDS := TStringList.Create;
    for var asset in Assets do
      slAssetsDDS.AddObject(asset.AssetName, asset);
    slAssetsDDS.Sorted := True;

    // assigning required callback
    NewArchive.DDSInfoProc := GetDDSInfo;
  end;

  NewArchive.CreateArchive(Options.ArchiveFileName, Options.ArchiveType, slFiles);

  if not Options.bAutodetectFlags and (NewArchive.ArchiveType in [baTES4, baFO3, baSSE]) then begin
    NewArchive.ArchiveFlags := Options.ArchiveFlags;
    NewArchive.FileFlags := Options.FileFlags;
  end;

  var ProcPack: TProcessProc :=
    procedure(i: Integer) begin
      var data: TBytes;
      try
        data := Assets[i].GetData;
      except
        on E: Exception do
          raise Exception.Create('Error reading source file:'#13 + Assets[i].FileNameDescr + #13#13 + E.Message);
      end;

      try
        NewArchive.AddFile(Assets[i].AssetName, data);
      except
        on E: Exception do
          raise Exception.Create('Error adding to archive:'#13 + Assets[i].AssetName + #13#13 + E.Message);
      end;
    end;

  // single main thread
  //if DebugHook <> 0 then begin
  //  for var i := Low(assets) to High(assets) do
  //    ProcPack(i);
  //  NewArchive.Save;
  //end else

  // multi threaded
  case wbTaskProgressExecute(
    Self, 'Packing...',
    Low(Assets), High(Assets), ProcPack, ErrIndex, ErrMessage, Threads
  ) of

    mrAbort:
      DialogError('Error packing:'#13 + assets[ErrIndex].FileName + #13#13 + ErrMessage);

    mrOk: begin
      try
        var size := NewArchive.CreatedArchiveSize;
        NewArchive.Save;

        if AfterPackingChecks(Options.ArchiveFileName, Options.ArchiveType, size) then

          if not bAutoMode then
          // final message window if not automated
          with TTaskDialog.Create(Self) do try
            Text :=
              'Archive has been created:'#13 + Options.ArchiveFileName + #13#13 +
              Format('Size: %.2n MB'#13'Assets: %.0n', [size / (1024*1024), Length(Assets) + 0.0]);
            Caption := Application.Title;
            Flags := [tfUseHiconMain, tfAllowDialogCancellation, tfPositionRelativeToWindow,
              tfSizeToContent, tfUseCommandLinks];
            CustomMainIcon := Application.Icon;
            CommonButtons := [tcbOk];
            // optional button to create .override file
            var OvrFileName := ChangeFileExt(Options.ArchiveFileName, '.override');
            if (Options.ArchiveType = baFO3) and not FileExists(OvrFileName) then begin
              var btn := Buttons.Add;
              btn.Caption := 'Create .override file for New Vegas';
              btn.ModalResult := 100;
            end;
            Execute;
            if ModalResult = 100 then
              try TFile.WriteAllBytes(OvrFileName, nil); except end;
          finally
            Free;
          end;

      except
        on E: Exception do
          DialogError('Error saving archive:'#13 + NewArchive.FileName + #13#13 + E.Message);
      end;
    end;

  end;

  // we are here if no errors have occured
  // close the app if automated
  if bAutoMode then
    Close;

  finally
    slFiles.Free;
    NewArchive.Free;
    if Assigned(slAssetsDDS) then
      FreeAndNil(slAssetsDDS);
  end;
end;

//============================================================================
procedure TFormMain.btnPackClick(Sender: TObject);
begin
  // pack all assets when the Pack button is used
  var files: TAssets;
  SetLength(files, Assets.Count);
  for var i: Integer := Low(files) to High(files) do
    files[i] := Assets[i];

  if Length(files) = 0 then
    Exit;

  PackAssets(files);
end;

//============================================================================
procedure TFormMain.mniAssetPackClick(Sender: TObject);
begin
  PackAssets(GetSelectedAssets);
end;

//============================================================================
procedure TFormMain.btnExitClick(Sender: TObject);
begin
  Close;
end;



end.
