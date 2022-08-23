{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbTaskProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, SyncObjs;

const
  WM_PROGRESS_UPDATE = WM_USER;
  WM_PROGRESS_ERROR = WM_USER + 1;

type
  TwbTaskWorkerThread = class;
  TProcessProc = TProc<Integer>;

  TProgressBarWithText = class(TProgressBar)
  private
    FProgressText: string;
  protected
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  published
    property ProgressText: string read FProgressText write FProgressText;
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
    {$IF CompilerVersion >= 34.0} { Delphi 10.4 }
    fObjectLock: TLightweightMREW;
    {$ELSE}
    fObjectLock: IReadWriteSync;
    {$IFEND}
    fProcessProc: TProcessProc;
    //fProgressProc: TProcessProc;
    fThreadPool: array of TwbTaskWorkerThread;
    fThreads: Integer;
    fCancel: Boolean;
    fError: Boolean;
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
  end;

  TwbWorkerObjectProc = function: Boolean of object;

  TwbTaskWorkerThread = class(TThread)
  private
    fObjectProc: TwbWorkerObjectProc;
  protected
    procedure Execute; override;
  public
    constructor Create(aObjectProc: TwbWorkerObjectProc);
  end;


function wbTaskProgressExecute(
  aOwner: TComponent;
  const aCaption: string;
  aLowIndex: Integer;
  aHighIndex: Integer;
  const aProcessProc: TProcessProc;
  out aExceptionIndex: Integer;
  out aExceptionMessage: string;
  aThreads: Integer = 0
): TModalResult;


implementation

{$R *.dfm}

uses
  ComObj, ShlObj;

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
    s := Format('%d/%d', [Position, Max]);

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
  Result:= Round(aCores * 0.9);
end;

//============================================================================
function wbTaskProgressExecute(
  aOwner: TComponent;
  const aCaption: string;
  aLowIndex: Integer;
  aHighIndex: Integer;
  const aProcessProc: TProcessProc;
  out aExceptionIndex: Integer;
  out aExceptionMessage: string;
  aThreads: Integer = 0
): TModalResult;
begin
  Result := mrCancel;

  var Count := aHighIndex - aLowIndex + 1;
  if Count <= 0 then
    Exit;

  with TFormTaskProgress.Create(aOwner) do try
    Caption := aCaption;
    fLowIndex := aLowIndex;
    fHighIndex := aHighIndex;
    fProcessProc := aProcessProc;
    //fProgressProc := aProgressProc;
    fThreads := aThreads;
    if fThreads = 0 then begin
      fThreads := CalcThreads(System.CPUCount);
      if fThreads <= 0 then
        fThreads := 1;
    end;
    if fThreads > Count then
      fThreads := Count;

    Result := ShowModal;

    aExceptionIndex := fExceptionIndex;
    aExceptionMessage := fExceptionMessage;
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

  // Succ() proactive progress update to 100% fill progress bar
  // for the last objects in queue
  PostMessage(Handle, WM_PROGRESS_UPDATE, Succ(CurIndex) - fLowIndex, 0);

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
  function Poll: Integer;
  var
    t: TwbTaskWorkerThread;
  begin
    Result := 0;
    for t in fThreadPool do
      if t.Finished then Inc(Result);
  end;

var
  t: TwbTaskWorkerThread;
  i, j: integer;
begin
  {$IF CompilerVersion < 34.0}
  fObjectLock := TSimpleRWSync.Create;
  {$IFEND}
  fCurrentIndex := fLowIndex;
  fExceptionIndex := -1;
  fRunning := True;
  SetLength(fThreadPool, fThreads);

  // create and start worker threads
  for i := Low(fThreadPool) to High(fThreadPool) do
    fThreadPool[i] := TwbTaskWorkerThread.Create(ProcessNext);

  // poll threads until all have finished
  repeat
    Sleep(200);
    j := Poll;

    // if Cancel is pressed or exception occured
    if fCancel or (fExceptionIndex <> -1) then begin
      // stop all threads
      for t in fThreadPool do
        if not t.Finished then t.Terminate;
    end;
  until j = Length(fThreadPool);

  // clear threads, all have finished by now
  for t in fThreadPool do
    t.Free;

  fRunning := False;

  // do not autoclose window if error has occured
  if fExceptionMessage <> '' then begin
    PostMessage(Handle, WM_PROGRESS_ERROR, 0, 0);
    ProgressBar.State := pbsError;
    // Cancel button will close the window
    fError := True;
  end
  else begin
    // close progress window
    PostMessage(Handle, WM_CLOSE, 0, 0);

    if fCancel then
      ModalResult := mrCancel
    else
      ModalResult := mrOk;
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
    fCancel := True
  else if fError then
    Close;
end;

//============================================================================
procedure TFormTaskProgress.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // closing with X is the same as Cancel while running
  if (ModalResult = mrCancel) and fRunning then begin
    btnCancel.Click;
    Action := caNone;
    Exit;
  end;

  // Pressing X sets ModalResult to mrCancel, make sure it is mrAbort if error occured
  if fError then
    ModalResult := mrAbort;

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
  ProgressBar.Min := 1;
  ProgressBar.Max := fHighIndex - fLowIndex + 1;
  TThread.CreateAnonymousThread(StartProcessing).Start;
end;


end.
