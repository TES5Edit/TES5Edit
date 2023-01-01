{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

{$WARN SYMBOL_PLATFORM OFF}
unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.IniFiles, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, Diagnostics, SniffProcessor;

const
  sSniffVersion = '1.0';
  WM_PROCESSING_START = WM_USER + 10;

type
  TFormMain = class(TForm)
    pnlInput: TPanel;
    chkInputSubdir: TCheckBox;
    Image1: TImage;
    edInput: TLabeledEdit;
    pnlOutput: TPanel;
    Image2: TImage;
    edOutput: TLabeledEdit;
    pnlControl: TPanel;
    btnExit: TButton;
    btnProcess: TButton;
    pnlOperation: TPanel;
    lvProcs: TListView;
    pnlProcFrame: TPanel;
    Label1: TLabel;
    lblSupportedGames: TLabel;
    Label2: TLabel;
    lblProcessedFiles: TLabel;
    tcMain: TTabControl;
    btnInputBrowse: TButton;
    btnOutputBrowse: TButton;
    chkOutputAll: TCheckBox;
    chkSkipOnErrors: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure lvProcsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure tcMainChange(Sender: TObject);
    procedure btnInputBrowseClick(Sender: TObject);
    procedure btnOutputBrowseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnProcessClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FrameMessages: TFrame;
    Settings: TMemIniFile;
    Manager: TProcManager;
    ProcessedFiles: TArray<String>;
    Procs: array of TProcBase;
    Proc: TProcBase;
    ProcFrame: TFrame;
    procedure SniffMessage(const aText: string);
    procedure AddProc(const aGroup: string; aProc: TProcBase);

    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure WMDropFiles(var msg: TWMDropFiles); message WM_DROPFILES;
    procedure WMProcessingStart(var msg: TMessage); message WM_PROCESSING_START;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  ShellApi,
  wbTaskProgress,
  frMessages,
  ProcTangents,
  ProcUpdateBounds,
  ProcReplaceAssets,
  ProcRenameStrings,
  ProcCheckForErrors,
  ProcJsonConverter,
  ProcTriangulate,
  ProcAdjustTransform,
  ProcJamAnim,
  ProcWeiExplosion,
  ProcAttachParent,
  ProcCopyControlledBlocks,
  ProcRenameControlledBlocks,
  ProcRemoveControlledBlocks,
  ProcPriorityControlledBlocks,
  ProcAnimQuadraticToLinear,
  ProcAnimSkeletonDeath,
  ProcShaderFlagsUpdate,
  ProcParallaxUpdate,
  ProcInertiaUpdate,
  ProcRagdollConstraintUpdate,
  ProcMoppUpdate,
  ProcUnweldedVertices,
  ProcFindSeveralStrips,
  ProcHavokSettingsUpdate,
  ProcCopyGeometryBlocks,
  ProcCollapseLinksArrays,
  ProcVertexPaint,
  ProcGroupShapes,
  ProcChangePartitionSlot,
  ProcFixExportedKFAnim,
  ProcOptimizeKF,
  ProcRemoveUnusedNodes,
  ProcConvertRootNode,
  ProcMergeShapes,
  ProcConvertFO3Collision,
  ProcUniversalTweaker,
  ProcAddHeadtrackingAnim;


procedure TFormMain.CreateWnd;
begin
  inherited;
  DragAcceptFiles(WindowHandle, True);
end;

procedure TFormMain.DestroyWnd;
begin
  DragAcceptFiles(WindowHandle, False);
  inherited;
end;

procedure TFormMain.WMDropFiles(var msg: TWMDropFiles);
var
  i, cnt: integer;
  fileName: array[0..MAX_PATH] of char;
  f, ff: string;
  sl: TStringList;
  bFirstFile: Boolean;
begin
  sl := TStringList.Create;
  sl.Duplicates := dupIgnore;
  bFirstFile := True;
  try
    cnt := DragQueryFile(msg.Drop, $FFFFFFFF, fileName, MAX_PATH);
    for i := 0 to Pred(cnt) do begin
      DragQueryFile(msg.Drop, i, fileName, MAX_PATH);
      f := fileName;

      if bFirstFile then begin
        Manager.InputDirectory := ExtractFilePath(f);
        Manager.OutputDirectory := ExtractFilePath(f);
        bFirstFile := False;
      end;

      if TFileAttribute.faDirectory in TPath.GetAttributes(f) then begin
        for ff in TDirectory.GetFiles(f, '*.*', TSearchOption.soAllDirectories) do
          sl.Add(ff);
      end else
        sl.Add(f);
    end;

    SetLength(ProcessedFiles, sl.Count);
    for i := 0 to Pred(sl.Count) do
      ProcessedFiles[i] := sl[i];

    if Length(ProcessedFiles) > 0 then
      PostMessage(Handle, WM_PROCESSING_START, 0, 0);

  finally
    DragFinish(msg.Drop);
    sl.Free;
  end;
end;

procedure TFormMain.WMProcessingStart(var msg: TMessage);
begin
  tcMain.TabIndex := 0;
  tcMainChange(nil);
  btnProcessClick(nil);
end;

procedure TFormMain.SniffMessage(const aText: string);
begin
  with TTaskDialog.Create(Self) do try
    Text := aText;
    Caption := Application.Title;
    Flags := [tfUseHiconMain];
    CustomMainIcon := Application.Icon;
    CommonButtons := [tcbClose];
    Execute;
  finally
    Free;
  end;
end;

procedure TFormMain.AddProc(const aGroup: string; aProc: TProcBase);
var
  i: Integer;
begin
  SetLength(Procs, Succ(Length(Procs)));
  Procs[Pred(Length(Procs))] := aProc;
  with lvProcs.Items.Add do begin
    Caption := aProc.Title;
    for i := 0 to Pred(lvProcs.Groups.Count) do
      if lvProcs.Groups[i].Header = aGroup then
        GroupID := lvProcs.Groups[i].GroupID;
  end;
end;

procedure TFormMain.btnInputBrowseClick(Sender: TObject);
var
  path: string;
begin
  path := edInput.Text;

  if path = '' then
    path := ExtractFilePath(Application.ExeName);

  if SelectFolder(path) then
    edInput.Text := Path;
end;

procedure TFormMain.btnOutputBrowseClick(Sender: TObject);
var
  path: string;
begin
  path := edOutput.Text;

  if path = '' then
    path := ExtractFilePath(Application.ExeName);

  if SelectFolder(path) then
    edOutput.Text := Path;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  LastUsedProc: string;
begin
  FormatSettings.DecimalSeparator := '.';
  Caption := Caption + ' ' + sSniffVersion;
  Application.Title := Caption;
  Settings := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  Manager := TProcManager.Create;
  Manager.SetIniFile(Settings);
  Manager.AddMessage(Application.Title);
  Manager.AddMessage('by Zilav, with love for awesome New Vegas mod makers');

  with lvProcs.Groups.Add do begin Header := 'NIF'; State := [lgsNormal, lgsCollapsible]; end;
  with lvProcs.Groups.Add do begin Header := 'Report'; State := [lgsNormal, lgsCollapsible]; end;
  with lvProcs.Groups.Add do begin Header := 'Animation'; State := [lgsNormal, lgsCollapsible]; end;
  with lvProcs.Groups.Add do begin Header := 'Collision'; State := [lgsNormal, lgsCollapsible]; end;
  with lvProcs.Groups.Add do begin Header := 'Shader'; State := [lgsNormal, lgsCollapsible]; end;

  AddProc('NIF', TProcTangents.Create(Manager));
  AddProc('NIF', TProcUpdateBounds.Create(Manager));
  AddProc('NIF', TProcReplaceAssets.Create(Manager));
  AddProc('NIF', TProcJsonConverter.Create(Manager));
  AddProc('NIF', TProcTriangulate.Create(Manager));
  AddProc('NIF', TProcAdjustTransform.Create(Manager));
  AddProc('NIF', TProcRenameStrings.Create(Manager));
  AddProc('NIF', TProcUniversalTweaker.Create(Manager));
  AddProc('NIF', TProcAttachParent.Create(Manager));
  AddProc('NIF', TProcCopyGeometryBlocks.Create(Manager));
  AddProc('NIF', TProcCollapseLinksArrays.Create(Manager));
  AddProc('NIF', TProcVertexPaint.Create(Manager));
  AddProc('NIF', TProcGroupShapes.Create(Manager));
  AddProc('NIF', TProcMergeShapes.Create(Manager));
  AddProc('NIF', TProcRemoveUnusedNodes.Create(Manager));
  AddProc('NIF', TProcConvertRootNode.Create(Manager));
  AddProc('NIF', TProcChangePartitionSlot.Create(Manager));

  AddProc('Report', TProcCheckForErrors.Create(Manager));
  AddProc('Report', TProcUnweldedVertices.Create(Manager));
  AddProc('Report', TProcFindSeveralStrips.Create(Manager));

  AddProc('Animation', TProcCopyControlledBlocks.Create(Manager));
  AddProc('Animation', TProcRenameControlledBlocks.Create(Manager));
  AddProc('Animation', TProcRemoveControlledBlocks.Create(Manager));
  AddProc('Animation', TProcPriorityControlledBlocks.Create(Manager));
  AddProc('Animation', TProcAnimQuadraticToLinear.Create(Manager));
  AddProc('Animation', TProcFixExportedKFAnim.Create(Manager));
  AddProc('Animation', TProcOptimizeKF.Create(Manager));
  AddProc('Animation', TProcAddHeadtrackingAnim.Create(Manager));
  AddProc('Animation', TProcJamAnim.Create(Manager));
  AddProc('Animation', TProcWeiExplosion.Create(Manager));
  AddProc('Animation', TProcAnimSkeletonDeath.Create(Manager));

  AddProc('Collision', TProcMoppUpdate.Create(Manager));
  AddProc('Collision', TProcHavokSettingsUpdate.Create(Manager));
  AddProc('Collision', TProcInertiaUpdate.Create(Manager));
  AddProc('Collision', TProcRagdollConstraintUpdate.Create(Manager));
  AddProc('Collision', TProcConvertFO3Collision.Create(Manager));

  AddProc('Shader', TProcShaderFlagsUpdate.Create(Manager));
  AddProc('Shader', TProcParallaxUpdate.Create(Manager));

  //ShowScrollBar(lvProcs.Handle, SB_HORZ, False);

  LastUsedProc := Settings.ReadString('Main', 'Operation', Procs[0].ClassName);
  for var i: Integer := Low(Procs) to High(Procs) do
    if Procs[i].Title = LastUsedProc then begin
      lvProcs.Selected := lvProcs.Items[i];
      Break;
    end;

  if lvProcs.ItemIndex = -1 then
    lvProcs.ItemIndex := 0;

  lvProcs.Selected.MakeVisible(False);

  edInput.Text := Settings.ReadString('Main', 'InputDirectory', ExtractFilePath(Application.ExeName));
  edOutput.Text := Settings.ReadString('Main', 'OutputDirectory', ExtractFilePath(Application.ExeName));
  chkInputSubdir.Checked := Settings.ReadBool('Main', 'InputSubDir', chkInputSubdir.Checked);
  chkSkipOnErrors.Checked := Settings.ReadBool('Main', 'SkipOnErrors', chkSkipOnErrors.Checked);
  chkOutputAll.Checked := Settings.ReadBool('Main', 'OutputAll', chkOutputAll.Checked);
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(Proc) then
    Proc.OnHide;

  if Assigned(ProcFrame) then
    FreeAndNil(ProcFrame);

  Settings.WriteString('Main', 'InputDirectory', edInput.Text);
  Settings.WriteString('Main', 'OutputDirectory', edOutput.Text);
  Settings.WriteBool('Main', 'InputSubDir', chkInputSubdir.Checked);
  Settings.WriteBool('Main', 'SkipOnErrors', chkSkipOnErrors.Checked);
  Settings.WriteBool('Main', 'OutputAll', chkOutputAll.Checked);
  Settings.WriteString('Main', 'Operation', Procs[lvProcs.ItemIndex].Title);

  for var p: TProcBase in Procs do
    p.Free;

  Manager.Free;

  try Settings.UpdateFile; except end;
  Settings.Free;
end;

procedure TFormMain.lvProcsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if not Selected then
    Exit;

  if Assigned(Proc) then
    Proc.OnHide;

  if Assigned(ProcFrame) then
    FreeAndNil(ProcFrame);

  Proc := Procs[Item.Index];

  lblSupportedGames.Caption := Proc.SupportedGameNames;
  lblProcessedFiles.Caption := Proc.ExtensionNames;

  pnlOutput.ShowCaption := Proc.NoOutput;
  for var i: Integer := 0 to Pred(pnlOutput.ControlCount) do
    pnlOutput.Controls[i].Visible := not Proc.NoOutput;

  ProcFrame := Proc.GetFrame(Self);

  if Assigned(ProcFrame) then begin
    ProcFrame.Parent := pnlProcFrame;
    ProcFrame.Align := alClient;
  end;

  Proc.OnShow;
end;

procedure TFormMain.tcMainChange(Sender: TObject);
begin
  if tcMain.TabIndex = 0 then begin
    if Assigned(FrameMessages) then
      FrameMessages.Visible := False;

    pnlOperation.Visible := True;
    pnlInput.Visible := True;
    pnlOutput.Visible := True;
    lvProcs.Selected.MakeVisible(False);
    btnProcess.Caption := 'Process';
  end

  else if tcMain.TabIndex = 1 then begin
    pnlOperation.Visible := False;
    pnlInput.Visible := False;
    pnlOutput.Visible := False;
    btnProcess.Caption := 'Save Messages';

    if not Assigned(FrameMessages) then begin
      FrameMessages := TFrameMessages.Create(Self);
      FrameMessages.Parent := Self;
      FrameMessages.Align := alClient;
    end;
    FrameMessages.Visible := True;
    TFrameMessages(FrameMessages).memoMessages.Lines.Assign(Manager.Messages);
  end;
end;

procedure TFormMain.btnProcessClick(Sender: TObject);
var
  objs: TArray<TProcessObject>;
  obj: TProcessObject;
  i: integer;
  s: string;
begin
  if tcMain.TabIndex = 1 then begin
    with TFileSaveDialog.Create(Self) do try
      DefaultFolder := ExtractFilePath(ParamStr(0));
      FileName := 'SniffLog.txt';

      if Execute then
        TFrameMessages(FrameMessages).memoMessages.Lines.SaveToFile(FileName);
    finally
      Free;
    end;

    Exit;
  end;

  // ProcessedFiles is filled when drag&dropping
  if Length(ProcessedFiles) = 0 then begin

    if (Trim(edInput.Text) = '') or not TDirectory.Exists(edInput.Text) then begin
      SniffMessage('Input directory not found');
      Exit;
    end;

    if not Proc.NoOutput then
      if (Trim(edOutput.Text) = '') or not TDirectory.Exists(edOutput.Text) then begin
        SniffMessage('Output directory not found');
        Exit;
      end;

    Manager.InputDirectory := IncludeTrailingPathDelimiter(edInput.Text);
    Manager.OutputDirectory := IncludeTrailingPathDelimiter(edOutput.Text);
  end;

  Manager.InitializeProcessing(Proc);
  Manager.CopyAll := chkOutputAll.Checked;
  Manager.SkipOnErrors := chkSkipOnErrors.Checked;

  try
    Proc.OnStart;
  except
    on E: Exception do begin
      SniffMessage(E.Message);
      SetLength(ProcessedFiles, 0);
      Exit;
    end;
  end;

  btnProcess.Enabled := False;
  btnExit.Enabled := False;
  Application.ProcessMessages;

  try

    // collecting files for processing if not drag&dropped
    if Length(ProcessedFiles) = 0 then begin
      var so: TSearchOption;

      if chkInputSubdir.Checked then
        so := TSearchOption.soAllDirectories
      else
        so := TSearchOption.soTopDirectoryOnly;

      ProcessedFiles := TDirectory.GetFiles(Manager.InputDirectory, '*.*', so);
    end;

    // creating array of processed objects
    for s in ProcessedFiles do begin
      if not Proc.IsAcceptedFile(s) then
        Continue;

      obj := TProcessObject.Create;
      obj.FileName := Copy(s, Length(Manager.InputDirectory) + 1, Length(s));

      SetLength(objs, Succ(Length(objs)));
      objs[Pred(Length(objs))] := obj;
    end;

    var ProcProcess: TProcessProc :=
      procedure(i: Integer) begin
        Manager.Process(objs[i]);
      end;

    var sw := TStopwatch.StartNew;

    // single main thread when debugging
    if DebugHook <> 0 then begin
      for i := Low(objs) to High(objs) do
        ProcProcess(i);
    end else

    // multi threaded
    case wbTaskProgressExecute(
      Self, 'Processing...',
      Low(objs), High(objs), ProcProcess, i, s, Proc.Threads
    ) of
      mrAbort: begin
        s := 'Error: "' + objs[i].FileName + ': ' + s;
        Manager.AddMessage(#13#10 + s);
        Exit;
      end;
    end;

    Manager.AddMessage(Format('Done. Updated %d files out of %d, elapsed time %s.', [
      Manager.ModifiedCount,
      Manager.ProcessedCount,
      sw.Elapsed.ToString
    ]));

  finally
    SetLength(ProcessedFiles, 0);
    for i := Low(objs) to High(objs) do
      objs[i].Free;

    btnProcess.Enabled := True;
    btnExit.Enabled := True;

    tcMain.TabIndex := 1;
    tcMainChange(nil);
  end;

end;

procedure TFormMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

end.
