{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbTaskProgress;

interface

uses
  System.Classes,
  System.SyncObjs,
  System.SysUtils,

  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.StdCtrls,

  Winapi.Messages;

const
  WM_PROGRESS_UPDATE = WM_USER;
  WM_PROGRESS_ERROR = WM_USER + 1;

type
  TwbTaskWorkerThread = class;
  TProcessProc = TProc<Integer>;

  TProgressBarWithText = class(TProgressBar)
  private
    FProgressText: string;
    FProgressTextMult: Double;
  protected
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  public
    property ProgressText: string read FProgressText write FProgressText;
    property ProgressTextMult: Double read FProgressTextMult write FProgressTextMult;
  end;

  TFormTaskProgress = class(TForm)
    ProgressBar: TProgressBar;
    btnCancel: TButton;
    pnlError: TPanel;
    Label1: TLabel;
    memoError: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fLowIndex: Integer;
    fHighIndex: Integer;
    fCurrentIndex: Integer;
    fProgressTextMult: Double;
    {$IF CompilerVersion >= 34.0} { Delphi 10.4 }
    fObjectLock: TLightweightMREW;
    {$ELSE}
    fObjectLock: IReadWriteSync;
    {$IFEND}
    fProcessProc: TProcessProc;
    fThreadPool: array of TwbTaskWorkerThread;
    fThreads: Integer;
    fCancelled: Boolean;
    fCancelCloses: Boolean;
    fExceptionIndex: Integer;
    fExceptionMessage: string;
    fHeight: Integer;
    fRunning: Boolean;
    procedure StartProcessing;
    procedure WMProgressUpdate(var msg: TMessage); message WM_PROGRESS_UPDATE;
    procedure WMProgressError(var msg: TMessage); message WM_PROGRESS_ERROR;
  protected
    // processing function called by worker threads, returns False when no jobs left
    function ProcessNext: Boolean;
  public
    { Public declarations }
    TaskResult: TModalResult;
  end;

  TwbWorkerObjectProc = function: Boolean of object;

  TwbTaskWorkerThread = class(TThread)
  private
    fObjectProc: TwbWorkerObjectProc;
  protected
    procedure Execute; override; final;
  public
    constructor Create(aObjectProc: TwbWorkerObjectProc);
  end;

  TwbTaskProgress = class
  public
    Owner: TComponent;
    Threads: Integer;
    ProcessProc: TProcessProc;
    Caption: string;
    ProgressTextMult: Double;
    LowIndex: Integer;
    HighIndex: Integer;
    ErrorIndex: Integer;
    ErrorMessage: string;
    constructor Create(aOwner: TComponent);
    function Execute: TModalResult;
  end;


implementation

{$R *.dfm}

uses
  System.Win.ComObj,

  WinApi.ShlObj,
  Winapi.Windows;

var
  TaskbarList: ITaskbarList;
  TaskbarList2: ITaskbarList2;
  TaskbarList3: ITaskbarList3;
  TaskbarList4: ITaskbarList4;


//============================================================================
procedure TProgressBarWithText.WMPaint(var Message: TWMPaint);
var
  DC: HDC;
  prevfont: HGDIOBJ;
  prevbkmode: Integer;
  R: TRect;
  s: string;
begin
  inherited;

  s := ProgressText;
  if s = '' then
    s := Format('%d/%d', [Round(Position * FProgressTextMult), Round(Max * FProgressTextMult)]);

  R := ClientRect;
  DC := GetWindowDC(Handle);
  prevbkmode := SetBkMode(DC, TRANSPARENT);
  prevfont := SelectObject(DC, Font.Handle);
  DrawText(DC, PChar(s), Length(s), R, DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  SelectObject(DC, prevfont);
  SetBkMode(DC, prevbkmode);
  ReleaseDC(Handle, DC);
end;

//============================================================================
function CalcThreads(aCores: Integer): Integer;
begin
  // leave one core for the system, we are generous :)
  Result := aCores - 1;
  // multithreading means 2 threads at least
  if Result < 2 then
    Result := 2;
end;

//============================================================================
constructor TwbTaskProgress.Create(aOwner: TComponent);
begin
  Owner := aOwner;
  ProgressTextMult := 1;
end;

//============================================================================
function TwbTaskProgress.Execute: TModalResult;
begin
  Result := mrCancel;

  var Count := HighIndex - LowIndex + 1;
  if Count <= 0 then
    Exit;

  with TFormTaskProgress.Create(Owner) do try
    Caption := Self.Caption;
    fLowIndex := Self.LowIndex;
    fHighIndex := Self.HighIndex;
    fProcessProc := Self.ProcessProc;
    fThreads := Self.Threads;
    fProgressTextMult := Self.ProgressTextMult;
    if fThreads = 0 then begin
      fThreads := CalcThreads(System.CPUCount);
      if fThreads <= 0 then
        fThreads := 1;
    end;
    if fThreads > Count then
      fThreads := Count;

    ShowModal;

    Result := TaskResult;
    Self.ErrorIndex := fExceptionIndex;
    Self.ErrorMessage := fExceptionMessage;
  finally
    Free;
  end;

end;

//============================================================================
procedure InitializeTaskbars;
begin
  if Win32MajorVersion < 6 then
    Exit;

  if Assigned(TaskbarList) then
    Exit;

  try
    TaskbarList := CreateComObject(CLSID_TaskbarList) as ITaskbarList;
  except
    Exit;
  end;

  TaskbarList.HrInit;
  Supports(TaskbarList, IID_ITaskbarList2, TaskbarList2);
  Supports(TaskbarList, IID_ITaskbarList3, TaskbarList3);
  Supports(TaskbarList, IID_ITaskbarList4, TaskbarList4);
end;

//============================================================================
procedure TaskbarShowProgress(Handle: THandle; ProgressPos, ProgressMax: Integer);
begin
  if not Assigned(TaskbarList3) then
    Exit;

  TaskbarList3.SetProgressState(Handle, TBPF_NORMAL);
  TaskbarList3.SetProgressValue(Handle, ProgressPos, ProgressMax);
end;

//============================================================================
procedure TaskbarErrorProgress(Handle: THandle);
begin
  if not Assigned(TaskbarList3) then
    Exit;

  TaskbarList3.SetProgressState(Handle, TBPF_ERROR);
end;

//============================================================================
procedure TaskbarHideProgress(Handle: THandle);
begin
  if not Assigned(TaskbarList3) then
    Exit;

  TaskbarList3.SetProgressState(Handle, TBPF_NOPROGRESS);
end;

//============================================================================
constructor TwbTaskWorkerThread.Create(aObjectProc: TwbWorkerObjectProc);
begin
  fObjectProc := aObjectProc;
  FreeOnTerminate := False;
  inherited Create(False);
end;

//============================================================================
procedure TwbTaskWorkerThread.Execute;
begin
  while not Terminated do
    if not fObjectProc then
      Break;
end;

//============================================================================
function TFormTaskProgress.ProcessNext: Boolean;
var
  CurIndex: Integer;
begin
  fObjectLock.BeginWrite;
  if (fCurrentIndex > fHighIndex) or (fExceptionIndex <> -1) then
    CurIndex := -1
  else begin
    CurIndex := fCurrentIndex;
    Inc(fCurrentIndex);
  end;
  fObjectLock.EndWrite;

  Result := False;
  if CurIndex = -1 then
    Exit;

  PostMessage(Handle, WM_PROGRESS_UPDATE, CurIndex, 0);

  try
    fProcessProc(CurIndex);
    Result := True;
  except
    on E: Exception do if fExceptionIndex = -1 then begin
      fObjectLock.BeginWrite;
      fExceptionIndex := CurIndex;
      fExceptionMessage := E.Message;
      fObjectLock.EndWrite;
    end;
  end;
end;

//============================================================================
procedure TFormTaskProgress.StartProcessing;

  // returns the number of finished threads
  function GetFinishedThreads: Integer;
  begin
    Result := 0;
    for var t in fThreadPool do
      if t.Finished then Inc(Result);
  end;

begin
  fRunning := True;

  // give time for the form to draw itself
  Sleep(100);

  {$IF CompilerVersion < 34.0}
  fObjectLock := TReadWriteSync.Create;
  {$IFEND}
  fCurrentIndex := fLowIndex;
  fExceptionIndex := -1;
  SetLength(fThreadPool, fThreads);

  // create and start worker threads
  for var i := Low(fThreadPool) to High(fThreadPool) do
    fThreadPool[i] := TwbTaskWorkerThread.Create(ProcessNext);

  // poll threads until all have finished
  while GetFinishedThreads <> Length(fThreadPool) do begin
    // stop all threads if Cancel was pressed or exception occured
    if fCancelled or (fExceptionIndex <> -1) then
      for var t in fThreadPool do
        if not t.Finished and not t.Terminated then
          t.Terminate;

    Sleep(200);
  end;

  // clear threads, all have finished by now
  for var t in fThreadPool do
    t.Free;

  fRunning := False;

  if fExceptionIndex <> -1 then begin
    TaskResult := mrAbort;
    PostMessage(Handle, WM_PROGRESS_ERROR, 0, 0);

    // do not close window if error has occured, Cancel button will close
    fCancelCloses := True;
  end
  else begin
    if fCancelled then
      TaskResult := mrCancel
    else
      TaskResult := mrOk;

    // close window
    PostMessage(Handle, WM_CLOSE, 0, 0);
  end;
end;

//============================================================================
procedure TFormTaskProgress.WMProgressUpdate(var msg: TMessage);
begin
  //if Assigned(fProgressProc) then
  //  fProgressProc(msg.WParam);

  ProgressBar.Position := msg.WParam;
  TaskbarShowProgress(Application.MainForm.Handle, ProgressBar.Position, ProgressBar.Max);
end;

//============================================================================
procedure TFormTaskProgress.WMProgressError(var msg: TMessage);
begin
  ProgressBar.State := pbsError;
  ProgressBar.Position := fExceptionIndex;
  TaskbarErrorProgress(Application.MainForm.Handle);

  Height := fHeight;
  pnlError.Visible := True;
  memoError.Lines.Text := fExceptionMessage;
end;

//============================================================================
procedure TFormTaskProgress.btnCancelClick(Sender: TObject);
begin
  // since window autocloses when everything is ok, there are only
  // 2 possibilities when Cancel can be pressed: while running or after error
  if fRunning then
    fCancelled := True
  else if fCancelCloses then
    Close;
end;

//============================================================================
procedure TFormTaskProgress.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // closing with X while running is the same as pressing Cancel
  if fRunning then begin
    btnCancel.Click;
    Action := caNone;
    Exit;
  end;

  TaskbarHideProgress(Application.MainForm.Handle);
end;

//============================================================================
procedure TFormTaskProgress.FormCreate(Sender: TObject);
var
  pg: TProgressBarWithText;
begin
  Font.Size := Screen.MenuFont.Size;
  fHeight := Height;
  Height := Height - pnlError.Top + 2;

  pg := TProgressBarWithText.Create(Self);
  pg.Parent := ProgressBar.Parent;
  pg.Left := ProgressBar.Left;
  pg.Top := ProgressBar.Top;
  pg.Width := ProgressBar.Width;
  pg.Height := ProgressBar.Height;
  pg.Smooth := ProgressBar.Smooth;
  ProgressBar.Free;
  ProgressBar := pg;
end;

//============================================================================
procedure TFormTaskProgress.FormActivate(Sender: TObject);
begin
  InitializeTaskbars;
  ProgressBar.Min := fLowIndex;
  ProgressBar.Max := fHighIndex;
  if ProgressBar is TProgressBarWithText then
    TProgressBarWithText(ProgressBar).ProgressTextMult := fProgressTextMult;

  TThread.CreateAnonymousThread(StartProcessing).Start;
end;


end.
