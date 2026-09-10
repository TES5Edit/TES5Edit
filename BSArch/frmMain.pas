{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

{$WARN SYMBOL_PLATFORM OFF}
unit frmMain;

interface

uses
  System.Classes,
  System.IniFiles,
  System.SysUtils,

  JsonDataObjects,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Mask,
  Vcl.Menus,
  Vcl.StdCtrls,

  VirtualTrees,
  {
  VirtualTrees.AncestorVCL,
  VirtualTrees.BaseAncestorVCL,
  VirtualTrees.BaseTree,
  VirtualTrees.Types,
  }

  WinApi.Messages,
  WinApi.Windows,

  wbBSArchive;

const
  WM_PACK = WM_USER + 3;

type
  TAsset = class;
  TAssets = TArray<TAsset>;
  TArchiveManager = class;

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
    mniAssetCompress: TMenuItem;
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
    mniAssetFindIdentical: TMenuItem;
    dlgIdenticalFiles: TTaskDialog;
    mniAssetOpen: TMenuItem;
    procedure vtAssetsCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vtAssetsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtAssetsHeaderClick(Sender: TVTHeader; const HitInfo: TVTHeaderHitInfo);
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
    procedure mniAssetCompressClick(Sender: TObject);
    procedure mniAssetEditClick(Sender: TObject);
    procedure mniAssetReplaceClick(Sender: TObject);
    procedure vtAssetsBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; const CellRect: TRect; var ContentRect: TRect);
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
    procedure mniAssetFindIdenticalClick(Sender: TObject);
    procedure mniAssetOpenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ArchiveManager: TArchiveManager;
    Assets: TList;
    FilteredAssets: TAssets;
    FilteredCount: Integer;
    Settings: TMemIniFile;
    Theme: string;
    DefaultListFileName: string;
    ListFileName: string;
    bAutoMode: Boolean;
    TempFolder: string;
    // options
    ArchiveType: TwbBSArchiveType;
    ArchiveTarget: TwbBSArchiveTarget;
    ArchiveFileName: string;
    AutodetectFlags: Boolean;
    MultiThreaded: Boolean;
    SharedData: Boolean;
    ArchiveFlags: Cardinal;
    FileFlags: Cardinal;
    Split: Integer;
    CompressionType: string;

    procedure DialogMessage(const aText: string);
    procedure DialogError(const aText: string);
    function DialogYesNo(const aText: string): Boolean;
    function CreateAsset(
      const aFileName: string;
      const aAssetName: string = '';
      const aArchiveName: string = '';
      aCompressed: Boolean = False
    ): TAsset;
    procedure AddAssetsFromFiles(aList: TStrings);
    procedure RefreshAssets(const aAssets: TAssets = nil; aFocusSelected: Boolean = True);
    procedure RefreshFilterLabel;
    function GetAssets(aSelected: Boolean = False): TAssets;
    function SaveList(const aFileName: string; bIgnoreErrors: Boolean = False): Boolean;
    function LoadList(const aFileName: string; bIgnoreErrors: Boolean = False): Boolean;
    function PreloadArchives(const aForAssets: TAssets): Boolean;
    procedure UnpackAssets(Assets: TAssets);
    procedure PackAssets(const Assets: TAssets);
    function BeforePackingChecks(const Assets: TAssets): Boolean;
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

  TAssetsPacker = class(TwbSplitPacker)
    ConvertDDS2XBOX: Boolean;
    function GetSourceFileData(const aFileName: string; aFileObject: Pointer): TBytes; override;
  end;

  TArchiveManager = class
  public
    FList: TArray<TwbBSArchive>;
    function GetCount: Integer;
    function Get(Index: Integer): TwbBSArchive;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TwbBSArchive read Get; default;
    constructor Create;
    destructor Destroy; override;
    function IndexOf(const aFileName: string): Integer;
    function OpenArchive(const aFileName: string): TwbBSArchive;
    procedure CloseArchive(const aFileName: string);
    procedure CloseAll;
  end;

  TAsset = class
  public
    ArchiveManager: TArchiveManager;
    ArchiveName: string;
    FileName: string;
    AssetName: string;
    Compressed: Boolean;
    constructor Create(aArchiveManager: TArchiveManager);
    function Equals(aAsset: TAsset): Boolean; reintroduce;
    function FileNameDescr: string;
    function GetData: TBytes;
    procedure ToJson(const js: TJsonBaseObject);
    procedure FromJson(const js: TJsonBaseObject);
  end;


var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  System.StrUtils,
  System.Types,
  System.Zip,

  Vcl.ClipBrd,
  Vcl.Graphics,
  Vcl.Styles.Utils.SystemMenu,
  Vcl.Themes,

  WinApi.ShellApi,

  frmArchiveInfo,
  frmPack,
  frmSearchReplace,

  wbCompression,
  wbDDS,
  wbDataFormatMisc,
  wbTaskProgress;


//============================================================================
function DDS2XBOX(const aData: TBytes): TBytes;
var
  TempFile, params: string;
  Info: SHELLEXECUTEINFO;
  ErrCode: Cardinal;
begin
  TempFile := TPath.GetTempPath + TPath.GetGUIDFileName + '.dds';
  try
    TFile.WriteAllBytes(TempFile, aData);
  except
    raise Exception.Create('Can''t create temp file for DDS XBox convertion: ' + TempFile);
  end;

  params := '-xbox "' + TempFile + '"';

  try
    FillChar(Info, SizeOf(Info), 0);
    Info.cbSize := SizeOf(SHELLEXECUTEINFO);
    Info.fMask := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_NO_UI;
    Info.nShow := SW_HIDE;
    Info.lpFile := PChar(ExtractFilePath(ParamStr(0)) + 'xtexconv.exe');
    Info.lpParameters := PChar(params);
    Info.lpDirectory := PChar(ExtractFilePath(TempFile));

    if not ShellExecuteEx(@Info) then
      raise Exception.Create('Unable to start xtexconv.exe');

    WaitForSingleObject(Info.hProcess, INFINITE);
    GetExitCodeProcess(Info.hProcess, ErrCode);
    CloseHandle(Info.hProcess);

    if ErrCode <> 0 then
      raise Exception.Create('xtexconv.exe error code ' + ErrCode.ToHexString(8));

    Result := TFile.ReadAllBytes(TempFile);
  finally
    if FileExists(TempFile) then
      TFile.Delete(TempFile);
  end;
end;

//============================================================================
function TAssetsPacker.GetSourceFileData(const aFileName: string; aFileObject: Pointer): TBytes;
begin
  try
    Result := TAsset(aFileObject).GetData;
    if ConvertDDS2XBOX and TwbDDS.IsDDS(Result, Length(Result)) and not TwbDDS.IsXBOX(Result) then
      Result := DDS2XBOX(Result);
  except
    on E: Exception do
      raise Exception.Create('Error reading source file:'#13 + TAsset(aFileObject).FileNameDescr + #13#13 + E.Message);
  end;
end;

//============================================================================
constructor TAsset.Create(aArchiveManager: TArchiveManager);
begin
  ArchiveManager := aArchiveManager;
end;

//============================================================================
function TAsset.Equals(aAsset: TAsset): Boolean;
begin
  Result :=
    SameText(AssetName, aAsset.AssetName) and
    SameText(FileName, aAsset.FileName) and
    SameText(ArchiveName, aAsset.ArchiveName);
end;

//============================================================================
function TAsset.FileNameDescr: string;
begin
  if ArchiveName = '' then
    Result := FileName
  else
    Result := ArchiveName + ' -> ' + FileName;
end;

//============================================================================
function TAsset.GetData: TBytes;
begin
  if ArchiveName <> '' then
    Result := ArchiveManager.OpenArchive(ArchiveName).Unpack(FileName)
  else
    Result := TFile.ReadAllBytes(FileName);
end;

//============================================================================
procedure TAsset.ToJson(const js: TJsonBaseObject);
var
  arr: TJsonArray;
begin
  arr := js as TJsonArray;
  if ArchiveName <> '' then arr.Count := 4 else arr.Count := 3;
  if Compressed then arr.I[0] := 1 else arr.I[0] := 0;
  arr.S[1] := AssetName;
  arr.S[2] := IfThen(FileName = AssetName, '', FileName);
  if arr.Count = 4 then
    arr.S[3] := ArchiveName;
end;

//============================================================================
procedure TAsset.FromJson(const js: TJsonBaseObject);
var
  arr: TJsonArray;
begin
  arr := js as TJsonArray;
  Compressed := arr.I[0] <> 0;
  AssetName := arr.S[1];
  FileName := arr.S[2];
  if FileName = '' then
    FileName := AssetName;

  if arr.Count = 4 then
    ArchiveName := arr.S[3]
  else
    ArchiveName := '';
end;

//============================================================================
constructor TArchiveManager.Create;
begin
  //
end;

//============================================================================
destructor TArchiveManager.Destroy;
begin
  CloseAll;
end;

//============================================================================
function TArchiveManager.GetCount: Integer;
begin
  Result := Length(FList);
end;

//============================================================================
function TArchiveManager.Get(Index: Integer): TwbBSArchive;
begin
  Result := FList[Index];
end;

//============================================================================
function TArchiveManager.IndexOf(const aFileName: string): Integer;
begin
  for Result := Low(FList) to High(FList) do
    if SameText(FList[Result].FileName, aFileName) then
      Exit;
  Result := -1;
end;

//============================================================================
function TArchiveManager.OpenArchive(const aFileName: string): TwbBSArchive;
begin
  var i := IndexOf(aFileName);
  if i <> -1 then begin
    Result := Get(i);
    Exit;
  end;

  Result := TwbBSArchive.Create;
  try
    Result.LoadFromFile(aFileName);
    Result.MultiThreaded := True;
    FList := FList + [Result];
  except
    on E: Exception do begin
      Result.Free;
      raise Exception.CreateFmt('Error opening archive:'#13'%s'#13#13'%s', [aFileName, E.Message]);
    end;
  end;
end;

//============================================================================
procedure TArchiveManager.CloseAll;
begin
  for var arch in FList do
    arch.Free;

  SetLength(FList, 0);
end;

//============================================================================
procedure TArchiveManager.CloseArchive(const aFileName: string);
begin
  var i := IndexOf(aFileName);
  if i <> -1 then begin
    FList[i].Free;
    Delete(FList, i, 1);
  end;
end;

//============================================================================
function ListSortAssetName(Item1, Item2: Pointer): Integer;
begin
  Result := CompareText(TAsset(Item1).AssetName, TAsset(Item2).AssetName);
end;

//============================================================================
function TFormMain.CreateAsset(
  const aFileName: string;
  const aAssetName: string = '';
  const aArchiveName: string = '';
  aCompressed: Boolean = False
): TAsset;
begin
  Result := TAsset.Create(ArchiveManager);
  Result.FileName := aFileName;
  if aAssetName <> '' then
    Result.AssetName := aAssetName
  else
    Result.AssetName := TwbAsset.GetAssetName(aFileName);
  Result.ArchiveName := aArchiveName;
  Result.Compressed := aCompressed;
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
        if not TwbAsset.DoNotPack(ff) then
          NewAssets.Add(CreateAsset(ff));
    end

    else if TwbBSArchive.IsArchive(f) then
      for var entry in ArchiveManager.OpenArchive(f) do
        NewAssets.Add(CreateAsset(entry.Name, entry.Name, f, entry.Compressed))

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

//============================================================================
procedure TFormMain.WndProc(var Message: TMessage);
begin
  if Message.Msg = CM_CUSTOMSTYLECHANGED then begin
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
  CellPaintMode: TVTCellPaintMode; const CellRect: TRect; var ContentRect: TRect);
begin
  var Asset := PAssetNode(Sender.GetNodeData(Node)).Asset;
  if Asset.ArchiveName = '' then
    Exit;

  var bgColor := TStyleManager.ActiveStyle.GetSystemColor(clWindow);
  if (Succ(Column) mod 2) = 0 then
    TargetCanvas.Brush.Color := bgColor - $D0D0D
  else
    TargetCanvas.Brush.Color := bgColor;
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
  const HitInfo: TVTHeaderHitInfo);
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
    for var asset in GetAssets(True) do begin
      if s <> '' then s := s + #13#10;
      s := s + asset.AssetName;
    end;
    Clipboard.AsText := s;
  end;
end;

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

  for var i := 0 to Pred(Assets.Count) do
    TAsset(Assets[i]).Free;
  Assets.Free;

  if Assigned(Settings) then
    FreeAndNil(Settings);

  if Assigned(ArchiveManager) then
    FreeAndNil(ArchiveManager);
end;

//============================================================================
procedure TFormMain.FormCreate(Sender: TObject);
begin
  with TVclStylesSystemMenu.Create(Self) do begin
    ShowNativeStyle := True;
    MenuCaption := 'Theme';
  end;

  Application.Title := Application.Title + ' ' + cBSArchVersion;
  {$IFDEF WIN64}
  Application.Title := Application.Title + ' x64';
  {$ENDIF WIN64}
  Caption := Application.Title;
  Assets := TList.Create;
  lblTip.Caption :=
    'Drag&drop folders, files and existing Bethesda archives to populate assets list'#13 +
    'Manage compression and asset names using right click menu (Shift+Click, Ctrl+Click or Ctrl+A to change selection)'#13 +
    'Click "Pack" when ready to create a new archive from all assets in the list';
  pnlTip.Align := alClient;

  // settings file by default in the Home path (AppRoaming)
  // or along with executable if no access there
  var SettingsFolder := TPath.GetHomePath;
  SettingsFolder := TPath.Combine(SettingsFolder, 'BSArchPro');
  if not DirectoryExists(SettingsFolder) then
    if not ForceDirectories(SettingsFolder) then
      SettingsFolder := ExtractFilePath(ParamStr(0));

  Settings := TMemIniFile.Create(TPath.Combine(SettingsFolder, 'BSArchPro.ini'));

  ArchiveType := TwbBSArchiveType(Settings.ReadInteger('General', 'ArchiveType',
    Integer(High(TwbBSArchiveType))) );
  ArchiveTarget := TwbBSArchiveTarget(Settings.ReadInteger('General', 'ArchiveTarget',
    Integer(Low(TwbBSArchiveTarget))) );
  ArchiveFileName := Settings.ReadString('General', 'ArchiveFileName',
    ExtractFilePath(ParamStr(0)) + 'New' + TwbBSArchive.DefaultExtension(ArchiveType));
  ArchiveFlags := Settings.ReadInteger('General', 'ArchiveFlags', 0);
  FileFlags := Settings.ReadInteger('General', 'FileFlags', 0);
  AutodetectFlags := Settings.ReadBool('General', 'AutodetectFlags', True);
  MultiThreaded := Settings.ReadBool('General', 'MultiThreaded', True);
  SharedData := Settings.ReadBool('General', 'SharedData', True);
  Split := Settings.ReadInteger('General', 'Split', -1);
  CompressionType := Settings.ReadString('General', 'CompressionType', '');

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

  ArchiveManager := TArchiveManager.Create;

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
procedure TFormMain.RefreshAssets(const aAssets: TAssets = nil; aFocusSelected: Boolean = True);
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

  // filter assets
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
  if aFocusSelected then
    for var n in vtAssets.Nodes do
      if PAssetNode(vtAssets.GetNodeData(n)).Asset = FocusedAsset then begin
        vtAssets.Selected[n] := True;
        vtAssets.FocusedNode := n;
        vtAssets.ScrollIntoView(n, True);
      end;
  RefreshFilterLabel;

  btnFilterReset.Visible := (Assets.Count <> 0) and ( (FilteredCount <> Assets.Count) or (edFilter.Text <> '') or not rbAll.Checked );
end;

//============================================================================
function TFormMain.GetAssets(aSelected: Boolean = False): TAssets;
var
  Nodes: TNodeArray;
  i: Integer;
begin
  if aSelected then begin
    Nodes := vtAssets.GetSortedSelection(False);
    SetLength(Result, Length(Nodes));
    for i := Low(Nodes) to High(Nodes) do
      Result[i] := PAssetNode(vtAssets.GetNodeData(Nodes[i])).Asset;
  end
  else begin
    SetLength(Result, vtAssets.TotalCount);
    for var n in vtAssets.Nodes do
      Result[n.Index] := PAssetNode(vtAssets.GetNodeData(n)).Asset;
  end;
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
    p.I['ArchiveType'] := Integer(ArchiveType);
    p.I['ArchiveTarget'] := Integer(ArchiveTarget);
    p.S['ArchiveFileName'] := ArchiveFileName;
    p.I['ArchiveFlags'] := ArchiveFlags;
    p.I['FileFlags'] := FileFlags;
    p.B['AutodetectFlags'] := AutodetectFlags;
    p.B['MultiThreaded'] := MultiThreaded;
    p.B['SharedData'] := SharedData;
    p.I['Split'] := Split;
    p.S['CompressionType'] := CompressionType;

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

    for var i := 0 to Pred(Assets.Count) do
      TAsset(Assets[i]).Free;
    Assets.Clear;
    ArchiveManager.CloseAll;

    if js.Contains('Packing') then begin
      var p := js.O['Packing'];
      ArchiveType := TwbBSArchiveType(p.I['ArchiveType']);
      // just in case, could happen when loading lists created by other tools
      if ArchiveType = baNone then
        ArchiveType := High(TwbBSArchiveType);
      ArchiveTarget := TwbBSArchiveTarget(p.I['ArchiveTarget']);
      ArchiveFileName := p.S['ArchiveFileName'];
      ArchiveFlags := p.I['ArchiveFlags'];
      FileFlags := p.I['FileFlags'];
      AutodetectFlags := p.B['AutodetectFlags'];
      MultiThreaded := p.B['MultiThreaded'];
      SharedData := p.B['SharedData'];
      if p.IndexOf('Split') <> -1 then Split := p.I['Split'] else Split := -1;
      CompressionType := p.S['CompressionType'];
    end;

    var a := js.A['Assets'];
    for var i := 0 to Pred(a.Count) do begin
      var asset := TAsset.Create(ArchiveManager);
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
  Asset: TAsset;
begin
  Asset := nil;

  bHasSelection := vtAssets.SelectedCount <> 0;
  if bHasSelection then
    Asset := PAssetNode(vtAssets.GetNodeData(vtAssets.FocusedNode)).Asset;

  mniAssetOpen.Visible := vtAssets.SelectedCount = 1;
  mniAssetEdit.Visible := vtAssets.SelectedCount = 1;
  mniArchiveInfo.Visible := Assigned(Asset) and (Asset.ArchiveName <> '');
  mniAssetReplace.Visible := vtAssets.SelectedCount > 1;
  mniAssetRemoveSelected.Visible := bHasSelection;
  mniAssetRemoveUnselected.Visible := bHasSelection;
  mniAssetCompress.Visible := Assets.Count <> 0;
  mniAssetFindIdentical.Visible := Assets.Count <> 0;
  mniAssetUnpack.Visible := Assigned(Asset) and (Asset.ArchiveName <> '');
  mniAssetUnpackSaveAs.Visible := mniAssetUnpack.Visible and (vtAssets.SelectedCount = 1);
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
  mniAssetOpen.Click;
end;

//============================================================================
procedure TFormMain.mniAssetOpenClick(Sender: TObject);
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

      if f.EndsWith('.fuz', True) then with TwbFuzFile.Create do try
        try
          Unserialize(data, PByte(data) + Length(data), Length(data));
          data := NativeValues['XWM Data'];
          f := ChangeFileExt(f, '.xwm');
        except end;
      finally
        Free;
      end;

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

    for var asset in GetAssets(True) do
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
procedure TFormMain.mniAssetCompressClick(Sender: TObject);
begin
  for var node in vtAssets.Nodes do begin
    var Asset := PAssetNode(vtAssets.GetNodeData(node)).Asset;
    Asset.Compressed := not TwbAsset.DoNotCompress(Asset.AssetName);
    if Asset.Compressed then
      node.CheckState := TCheckState.csCheckedNormal
    else
      node.CheckState := TCheckState.csUncheckedNormal;
  end;
  vtAssets.Invalidate;
end;

//============================================================================
procedure TFormMain.btnClearListClick(Sender: TObject);
begin
  if Assets.Count = 0 then
    Exit;

  if not DialogYesNo('Clear assets list?') then
    Exit;

  for var i := 0 to Pred(Assets.Count) do
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
    for var asset in GetAssets(True) do begin
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

  var selected := GetAssets(True);
  Assets.Clear;
  for var asset in selected do
    Assets.Add(asset);

  RefreshAssets;
  vtAssets.SelectAll(False);

  if Assets.Count = 0 then
    ArchiveManager.CloseAll;
end;

//============================================================================
procedure TFormMain.mniAssetFindIdenticalClick(Sender: TObject);
var
  Same: TwbSameData;
begin
  var CompareAssets := GetAssets;

  if Length(CompareAssets) <> Assets.Count then begin
    DialogMessage('This function works on the entire assets list. Please remove filter and try again.');
    Exit;
  end;

  if not PreloadArchives(CompareAssets) then
    Exit;

  var ProcCompare: TProcessProc :=
    procedure(i: Integer) begin
      Same.Add(i, CompareAssets[i].GetData);
    end;

  with TwbTaskProgress.Create(Self) do try
    Caption := 'Comparing assets data...';
    LowIndex := Low(CompareAssets);
    HighIndex := High(CompareAssets);
    ProcessProc := ProcCompare;
    var mr := Execute;
    if mr = mrAbort then begin
      DialogError('Error reading:'#13 + CompareAssets[ErrorIndex].FileName + #13#13 + ErrorMessage);
      Exit;
    end
    else if mr = mrCancel then
      Exit;
  finally
    Free;
  end;

  var Dups, NotDups: TAssets;
  var sl := TStringList.Create;
  try
    var count := 0;
    var size: UInt64 := 0;
    for var i := 0 to Pred(Same.DatasCount) do with Same.Datas[i] do
      if Length(DataIndices) > 1 then begin
        for var idx in DataIndices do with CompareAssets[idx] do begin
          Dups := Dups + [CompareAssets[idx]];
          if ArchiveName <> '' then
            sl.Add(ArchiveName + '\' + FileName)
          else
            sl.Add(FileName);
        end;
        sl.Add('');
        Inc(count, Pred(Length(DataIndices)));
        Inc(size, DataSize * UInt64(Pred(Length(DataIndices))));
      end else
        NotDups := NotDups + [CompareAssets[DataIndices[0]]];

    if sl.Count = 0 then begin
      DialogMessage('No identical assets found');
      Exit;
    end;

    sl.Insert(0, '');
    sl.Insert(0, 'Duplicate Size: ' + FormatSize(size) + ' (uncompressed saved space if all identical files will end up in the same archive with Shared Data option)');
    sl.Insert(0, 'Duplicate Files: ' + count.ToString);

    dlgIdenticalFiles.CustomMainIcon := Application.Icon;
    dlgIdenticalFiles.Title := sl[0] + #13 + sl[1];

    if not dlgIdenticalFiles.Execute then
      Exit;

    if dlgIdenticalFiles.ModalResult = 100 then begin
      for var i := Low(Dups) to High(Dups) do
        Assets[i] := Dups[i];
      for var i := Low(NotDups) to High(NotDups) do
        Assets[Length(Dups) + i] := NotDups[i];
      vtAssets.Header.SortColumn := -1;
      RefreshAssets(nil, False);
    end

    else if dlgIdenticalFiles.ModalResult = 101 then
      RefreshAssets(Dups, False)

    else if dlgIdenticalFiles.ModalResult = 102 then
      with TFormArchiveInfo.Create(Self) do begin
        Caption := 'Identical assets';
        aBSA := Caption;
        slText := sl;
        sl := nil;
        ShowModal;
      end;

  finally
    if Assigned(sl) then
      sl.Free;
  end;
end;

//============================================================================
procedure TFormMain.UnpackAssets(Assets: TAssets);
var
  Folders: TStringList;
  LastUnpackFolder: string;
begin
  Folders := TStringList.Create;
  Folders.Sorted := True;
  Folders.Duplicates := dupIgnore;

  try
    // remove loose files from selection and collect assets folders
    for var i := High(assets) downto Low(assets) do
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
  with TwbTaskProgress.Create(Self) do try
    Caption := 'Unpacking...';
    LowIndex := Low(Assets);
    HighIndex := High(Assets);
    ProcessProc := ProcUnpack;
    if Execute = mrAbort then
      DialogError('Error unpacking:'#13 + assets[ErrorIndex].FileName + #13#13 + ErrorMessage);
  finally
    Free;
  end;
end;

//============================================================================
procedure TFormMain.mniAssetUnpackClick(Sender: TObject);
begin
  UnpackAssets(GetAssets(True));
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
procedure TFormMain.mniArchiveInfoClick(Sender: TObject);
var
  txt: TStringList;
  bsa: TwbBSArchive;
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
    txt.Text := bsa.Info;
    for var f in bsa do begin
      txt.Add('');
      txt.Add(f.Name);
      for var s in f.Info.Split([#13#10]) do
        txt.Add(s);
    end;
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
    if not TwbAsset.IsValidAssetName(asset.AssetName) then
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

  // non-ascii characters
  for var asset in Assets do
    if TwbAsset.GetNonASCII(asset.AssetName) <> '' then
      BadAssets := BadAssets + [asset];

  if Length(BadAssets) <> 0 then begin
    dlgPackingCheck.Text :=
      'Found non-ASCII characters "' + TwbAsset.GetNonASCII(BadAssets[Low(BadAssets)].AssetName) + '":'#13 +
      BadAssets[Low(BadAssets)].AssetName + #13#13 +
      'Usage of non-ASCII characters is not recommended in packed asset names, ' +
      'the game might not find such files in archive. Either rename them or keep loose. ' +
      'Press "Continue" to pack anyway.';
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

  // skipped files
  for var asset in Assets do
    if TwbAsset.DoNotPack(asset.FileName) then
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

  // compressed sound and string files
  for var asset in Assets do
    if asset.Compressed and TwbAsset.DoNotCompress(asset.AssetName) then
      BadAssets := BadAssets + [asset];

  if Length(BadAssets) <> 0 then begin
    dlgPackingCheck.Text :=
      'Compressed Music/Sound/String file:'#13 +
      BadAssets[Low(BadAssets)].AssetName + #13#13 +
      'Music/Sound/String files don''t work in the game when compressed (except .fuz). Press "Continue" ' +
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
procedure TFormMain.PackAssets(const Assets: TAssets);
var
  slFiles: TStringList;
  bsa: TAssetsPacker;
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

  // creating files and compressions lists
  slFiles := TStringList.Create;
  var lstComp: TArray<Boolean>;
  SetLength(lstComp, Length(Assets));
  for var i := Low(Assets) to High(Assets) do begin
    slFiles.AddObject(Assets[i].AssetName, Assets[i]);
    lstComp[i] := Assets[i].Compressed;
  end;

  // packing options window
  if not bAutoMode then
    with TFormPack.Create(Self) do try
      Color := Self.Color;
      SourceArchives := ArchiveManager.FList;
      FilesList := slFiles;
      CompressionList := lstComp;
      ArchiveType := Self.ArchiveType;
      ArchiveTarget := Self.ArchiveTarget;
      ArchiveFileName := Self.ArchiveFileName;
      AutodetectFlags := Self.AutodetectFlags;
      MultiThreaded := Self.MultiThreaded;
      SharedData := Self.SharedData;
      ArchiveFlags := Self.ArchiveFlags;
      FileFlags := Self.FileFlags;
      Split := Self.Split;
      CompressionType := Self.CompressionType;
      lblPack.Caption := Format('Packing %.0n files for', [Length(Assets) + 0.0]);
      if ShowModal <> mrOk then
        Exit;

      Self.ArchiveType := ArchiveType;
      Self.ArchiveTarget := ArchiveTarget;
      Self.ArchiveFileName := ArchiveFileName;
      Self.AutodetectFlags := AutodetectFlags;
      Self.MultiThreaded := MultiThreaded;
      Self.SharedData := SharedData;
      Self.ArchiveFlags := ArchiveFlags;
      Self.FileFlags := FileFlags;
      Self.Split := Split;
      Self.CompressionType := CompressionType;
    finally
      Free;
    end;

  // DDS archives must be compressed or CTD
  if TwbBSArchive.IsDDSArchive(ArchiveType) then
    for var i := Low(Assets) to High(Assets) do
      lstComp[i] := True;

  bsa := TAssetsPacker.Create;
  try
  bsa.MultiThreaded := MultiThreaded;
  bsa.ShareData := SharedData;
  if Split = -1 then
    bsa.SplitSize := bsa.DefaultSplitSize(ArchiveType)
  else
    bsa.SplitSize := Int64(Split) * 1024 * 1024 * 1024;

  bsa.CompressionType := TwbCompression.TypeByName(CompressionType);
  if not bsa.SupportsCompression(ArchiveType, bsa.CompressionType) then
    bsa.CompressionType := bsa.DefaultCompression(ArchiveType);

  if not AutodetectFlags then begin
    bsa.ArchiveFlags := ArchiveFlags;
    bsa.FileFlags := FileFlags;
  end;

  bsa.ArchiveTarget := ArchiveTarget;
  // single texture chunk for xbox archives, tests showed chunking causes issues there for unknown reason
  // PS must always be single chunk, chunking not supported for GNF textures
  if bsa.ArchiveTarget in [btXBox, btPS] then
    bsa.MaxChunkCount := 1;
  bsa.ConvertDDS2XBOX := bsa.IsDDSArchive(ArchiveType) and (bsa.ArchiveTarget = btXBox) and
   FileExists(ExtractFilePath(ParamStr(0)) + 'xtexconv.exe');

  var bSuccess := False;
  bsa.CreateArchive(ArchiveFileName, ArchiveType, slFiles, lstComp);

  // single main thread
  if DebugHook <> 0 then begin
    for var i := 0 to Pred(bsa.ProcessCount) do bsa.Process;
    bsa.Save;
    bSuccess := True;
  end else

  // multi threaded
  with TwbTaskProgress.Create(Self) do try
    Caption := 'Packing...';
    if not MultiThreaded then Threads := 1 else Threads := 0;
    LowIndex := 0;
    HighIndex := bsa.ProcessCount;
    ProgressTextMult := slFiles.Count / bsa.ProcessCount;
    ProcessProc :=
      procedure(i: Integer) begin
        bsa.Process;
      end;

    case Execute of
      mrAbort: DialogError('Packing error:'#13 + ErrorMessage);
      mrOk: try
        bsa.Save;
        bSuccess := True;
      except
        on E: Exception do
          DialogError('Archive saving error:'#13 + E.Message);
      end;
    end;
  finally
    Free;
  end;

  // if not automated then final message window after successful packing
  if not bAutoMode and bSuccess then with TTaskDialog.Create(Self) do try
    var s := 'Created archive(s):'#13;
    for var b in bsa.Archives do begin
      s := s + Format('%s   %s  %.0n files', [b.FileName, FormatSize(b.ArchiveSize), b.Count + 0.0]);
      if b.ArchiveSharedFiles <> 0 then
        s := s + Format('  %.0n shared saving %s', [b.ArchiveSharedFiles + 0.0, FormatSize(b.ArchiveSharedSize)]);
      s := s + #13;
      for var w in b.Warnings do
        s := s + '  Warning: ' + w + #13;
    end;
    Text := s;
    Caption := Application.Title;
    Flags := [tfUseHiconMain, tfAllowDialogCancellation, tfPositionRelativeToWindow, tfSizeToContent];
    CustomMainIcon := Application.Icon;
    CommonButtons := [tcbOk];
    // optional button to create .override file(s)
    if ArchiveType = baFO3 then begin
      var btn := Buttons.Add;
      btn.Caption := 'Create .override file(s) for New Vegas';
      btn.ModalResult := 100;
    end;
    Execute;
    if ModalResult = 100 then
      for var b in bsa.Archives do
        try TFile.WriteAllBytes(ChangeFileExt(b.FileName, '.override'), nil); except end;
  finally
    Free;
  end;

  // we are here if no errors have occured
  // close the app if automated
  if bAutoMode then
    Close;

  finally
    FreeAndNil(slFiles);
    bsa.Free;
  end;
end;

//============================================================================
procedure TFormMain.btnPackClick(Sender: TObject);
begin
  // pack all assets when the Pack button is used
  var files: TAssets;
  SetLength(files, Assets.Count);
  for var i := Low(files) to High(files) do
    files[i] := Assets[i];

  if Length(files) = 0 then
    Exit;

  PackAssets(files);
end;

//============================================================================
procedure TFormMain.mniAssetPackClick(Sender: TObject);
begin
  PackAssets(GetAssets(True));
end;

//============================================================================
procedure TFormMain.btnExitClick(Sender: TObject);
begin
  Close;
end;


end.
