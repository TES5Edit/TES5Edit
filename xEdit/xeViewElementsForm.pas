{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeViewElementsForm;

{$I xeDefines.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, wbInterface, ComCtrls, ExtCtrls, StdCtrls, Buttons, Menus, IniFiles,
  SynEdit, SynMemo, xeMainForm, Clipbrd;

type
  TwbEdit = record
    eElement: IwbElement;
    eMemo: TMemo;
  end;

  TwbEdits = TArray<TwbEdit>;

  TfrmViewElements = class(TForm)
    Panel1: TPanel;
    pcView: TPageControl;
    Panel2: TPanel;
    PopupMenu1: TPopupMenu;
    mniCompareConf: TMenuItem;
    pnlButtons: TFlowPanel;
    btnCompare: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    dlgCompareTool: TOpenDialog;
    LiteCompareButton: TButton;
    FindDialog1: TFindDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure mniCompareConfClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCopyToClipboard(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FindDialog1Find(Sender: TObject);
  private
    FMemo   : TMemo;
    FSelPos : Integer;

    Edits: TwbEdits;
    procedure MemoChange(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    Settings: TMemIniFile;
    CompareCmdLine: string;
    procedure AddElement(const aElement: IwbElement; aFocused, aEditable: Boolean);
    function ShowModal: Integer; override;
    destructor Destroy; override;
  end;

  TwbTabSheet = class(TTabSheet)
  private
//    Element: IwbElement;
  end;

implementation

{$R *.dfm}

uses
  wbHelpers, ShellApi;

{ TfrmViewElements }

procedure TfrmViewElements.AddElement(const aElement: IwbElement;
  aFocused, aEditable: Boolean);
var
  TabSheet : TwbTabSheet;
  Edit     : TwbEdit;
  Memo     : TMemo;
begin
  if not Assigned(aElement) then
    Exit;
  if not Assigned(aElement._File) then
    Exit;

  TabSheet := TwbTabSheet.Create(Self);
  TabSheet.PageControl := pcView;
  TabSheet.Caption := aElement._File.Name;
//  TabSheet.Element := aElement;

  Memo := TMemo.Create(TabSheet);
  Memo.Parent := TabSheet;
  LoadFont(Settings, 'UI', 'FontViewer', Memo.Font);
  if frmMain.MonospaceFontName <> '' then
    Memo.Font.Name := frmMain.MonospaceFontName;
  if aEditable then begin
    Memo.Lines.Text := aElement.EditValue;
    btnOK.Visible := True;
    //btnCancel.Kind := bkAbort;
    SetLength(Edits, Succ(Length(Edits)));
    with Edits[High(Edits)] do begin
      eElement := aElement;
      eMemo := Memo;
    end;
  end else
    Memo.Lines.Text := aElement.Value;
  Memo.Align := alClient;
  Memo.ReadOnly := not aEditable;
  if not Memo.ReadOnly then
    Memo.WantReturns := True;
  if not aEditable then
    Memo.ParentColor := True;
//  Memo.BorderStyle := bsNone;
  Memo.ScrollBars := ssBoth;
  Memo.Modified := False;
  Memo.OnChange := MemoChange;
  Memo.OnKeyDown := MemoKeyDown;

  if aFocused then
    pcView.ActivePage := TabSheet;
end;

procedure TfrmViewElements.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmViewElements.btnCopyToClipboard(Sender: TObject);
var
  Memo: TMemo;
begin
  if pcView.PageCount > 0 then
  begin
    Memo := TMemo(pcView.ActivePage.Controls[0]);
    Clipboard.AsText := Memo.Text;
    frmMain.PostAddMessage('Copied field to clipboard');
  end
end;

procedure TfrmViewElements.btnCompareClick(Sender: TObject);
var
  TabSheet1, TabSheet2 : TTabSheet;
  idx: integer;
  Path, aFile1, aFile2, aExe, aParams: string;
  StartUpInfo: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  sl: TStringList;
begin
  if pcView.PageCount < 2 then
    Exit;

  idx := pcView.TabIndex;
  if idx = 0 then
    Inc(idx);

  Path := ExtractFilePath(Application.ExeName);
  aExe := Trim(Copy(CompareCmdLine, 1, Pred(Pos('%', CompareCmdLine))));
  aParams := Copy(CompareCmdLine, Succ(Length(aExe)), Length(CompareCmdLine));

  try
    TabSheet2 := pcView.Pages[idx];
    aFile2 := Path + TabSheet2.Caption + '.txt';
    TMemo(TabSheet2.Controls[0]).Lines.SaveToFile(aFile2);
    aParams := StringReplace(aParams, '%2', '"'+aFile2+'"', []);

    TabSheet1 := pcView.Pages[Pred(idx)];
    aFile1 := Path + TabSheet1.Caption + '.txt';
    TMemo(TabSheet1.Controls[0]).Lines.SaveToFile(aFile1);
    aParams := StringReplace(aParams, '%1', '"'+aFile1+'"', []);

    FillChar(StartUpInfo, SizeOf(TStartUpInfo), 0);
    with StartUpInfo do begin
      cb := SizeOf(TStartUpInfo);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
      wShowWindow := SW_SHOWNORMAL;
    end;

    aParams := '"'+aExe+'"'+aParams;

    if CreateProcess(PChar(aExe), PChar(aParams),
      nil, nil, false, NORMAL_PRIORITY_CLASS,
      nil, nil, StartUpInfo, ProcessInfo)
    then begin
      WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
      //GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);
      CloseHandle(ProcessInfo.hThread);
      CloseHandle(ProcessInfo.hProcess);
      sl := TStringList.Create;
      try
        sl.LoadfromFile(aFile1);
        with TMemo(TabSheet1.Controls[0]) do
          if (sl.Text<>Lines.Text) and not ReadOnly then begin
            TMemo(TabSheet1.Controls[0]).Lines.Text := sl.Text;
            TMemo(TabSheet1.Controls[0]).Modified := True;
            with TabSheet1 do
              if (Length(Caption)>0) and (Caption[Length(Caption)]<>'*') then Caption := Caption + '*';
          end;
        sl.LoadfromFile(aFile2);
        with TMemo(TabSheet2.Controls[0]) do
          if (sl.Text<>Lines.Text) and not ReadOnly then begin
            TMemo(TabSheet2.Controls[0]).Lines.Text := sl.Text;
            TMemo(TabSheet2.Controls[0]).Modified := True;
            with TabSheet2 do
              if (Length(Caption)>0) and (Caption[Length(Caption)]<>'*') then Caption := Caption + '*';
          end;
      finally
        FreeAndNil(sl);
      end;
      DeleteFile(aFile1);
      DeleteFile(aFile2);
    end else
      raise Exception.Create(SysErrorMessage(GetLastError));
  except
    on E: Exception do
      MessageBox(0, PChar('Could not execute command line'#13 + aExe + ' ' + aParams + #13'Error: ' + E.Message), 'Error', 0);
  end;
end;

destructor TfrmViewElements.Destroy;
begin
  inherited;
end;

procedure TfrmViewElements.mniCompareConfClick(Sender: TObject);
var
  s: string;
begin
  if not dlgCompareTool.Execute then
    Exit;

  s := dlgCompareTool.FileName + ' %1 %2';

  if InputQuery('Comparison program', 'Command line (%1 and %2 are temp text files)', s) then begin
    CompareCmdLine := s;
    Settings.WriteString('External', 'CompareCommandLine', CompareCmdLine);
    Settings.UpdateFile;
  end;
end;

procedure TfrmViewElements.FindDialog1Find(Sender: TObject);
var
  S, T : string;
  startpos : integer;
begin
  with TFindDialog(Sender) do begin
    {If the stored position is 0 this cannot be a find next. }
    if FSelPos = 0 then
      Options := Options - [frFindNext];

     { Figure out where to start the search and get the corresponding
       text from the memo. }
    if frfindNext in Options then begin
      { This is a find next, start after the end of the last found word. }
      StartPos := FSelPos + Length(Findtext);
      S := Copy(FMemo.Lines.Text, StartPos, MaxInt);
    end else begin
      { This is a find first, start at the, well, start. }
      S := FMemo.Lines.Text;
      StartPos := 1;
    end;
    T := FindText;

    if not (frMatchCase in Options) then begin
      S := S.ToLower;
      T := T.ToLower;
    end;

    { Perform a global search for T in S }
    FSelPos := Pos(FindText, S);
    if FSelPos > 0 then begin
       { Found something, correct position for the location of the start
         of search. }
      FSelPos := FSelPos + StartPos - 1;
      FMemo.SelStart := FSelPos - 1;
      FMemo.SelLength := Length(FindText);
      FMemo.SetFocus;
    end else begin
      { No joy, show a message. }
      if frfindNext in Options then
        S := Concat('There are no further occurences of "', FindText,
          '".')
      else
        S := Concat('Could not find "', FindText, '".');
      MessageDlg(S, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TfrmViewElements.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if Assigned(Settings) then begin
    if WindowState <> wsMinimized then
      Settings.WriteInteger(Name, 'WindowState', Integer(WindowState));
    if WindowState = wsNormal then begin
      Settings.WriteInteger(Name, 'Left', Left);
      Settings.WriteInteger(Name, 'Top', Top);
      Settings.WriteInteger(Name, 'Width', Width);
      Settings.WriteInteger(Name, 'Height', Height);
    end;
    Settings.UpdateFile;
  end;
end;

procedure TfrmViewElements.FormCreate(Sender: TObject);
var
  lLeft, lTop, lWidth, lHeight : Integer;
  lRect: TRect;
begin
  xeApplyFontAndScale(Self);

  Settings := frmMain.Settings;

  if Assigned(Settings) then begin
    lLeft := Settings.ReadInteger(Name, 'Left', 0);
    lTop := Settings.ReadInteger(Name, 'Top', 0);
    lWidth := Settings.ReadInteger(Name, 'Width', 0);
    lHeight := Settings.ReadInteger(Name, 'Height', 0);
    if (lWidth > 100) and (lHeight > 100) then begin
      lRect := Screen.DesktopRect;
      if (lLeft+16 >= lRect.Left) and
         (lTop+16 >= lRect.Top) and
         ((lLeft + lWidth)-16 <= lRect.Right) and
         ((lTop + lHeight)-16 <= lRect.Bottom)
      then begin
        Left := lLeft;
        Top := lTop;
        Width := lWidth;
        Height := lHeight;
        Position := poDesigned;
      end;
    end;
    WindowState := TWindowState(Settings.ReadInteger(Name, 'WindowState', Integer(WindowState)));
    if WindowState = wsMaximized then
      Position := poDesigned;
  end;
end;

procedure TfrmViewElements.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancel.Click;
end;

procedure TfrmViewElements.FormShow(Sender: TObject);
begin
  if Assigned(Settings) then
    CompareCmdLine := Settings.ReadString('External', 'CompareCommandLine', 'bcompare.exe %1 %2');
  {$IFDEF LiteVersion}
  LiteCompareButton.Visible := True;
  btnCompare.Visible := False;
  {$ENDIF}
end;

procedure TfrmViewElements.MemoChange(Sender: TObject);
//var
//  s: string;
begin
  if Sender is TMemo then
    with TMemo(Sender) do begin
      if Modified then begin
        (Owner as TwbTabSheet).Highlighted := True;
{        s := (Owner as TwbTabSheet).Caption;
        if (Length(s) < 2) or (s[1] <> '<') or (s[Length(s)] <> '>') then begin
          s := '<' + s + '>';
          (Owner as TwbTabSheet).Caption := s;
        end;}
      end;
    end;
end;

procedure TfrmViewElements.MemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = Ord('A')) and (ssCtrl in Shift) then
    TMemo(Sender).SelectAll
  else if (Key = Ord('F')) and (ssCtrl in Shift) then begin
    FMemo := TMemo(Sender);
    FSelPos := 0;
    FindDialog1.Execute;
  end;
end;

function TfrmViewElements.ShowModal: Integer;
var
  i: Integer;
begin
  if pcView.PageCount > 0 then begin
    if pcView.ActivePage = nil then
      pcView.ActivePage := pcView.Pages[0];
    Result := inherited ShowModal;
  end else
    Result := mrAbort;

  if Result = mrOk then
    for i := Low(Edits) to High(Edits) do
      with Edits[i] do
        if eMemo.Modified then try
          LockProcessMessages;
          try
            eElement.EditValue := eMemo.Text;
            frmMain.PostResetActiveTree;
          finally
            UnLockProcessMessages;
          end;
        except
          on E: Exception do
            ShowMessage(Format('Assignment error: %s'#13#10'File: %s'#13#10'Element: %s',
              [E.Message, eElement._File.FileName, eElement.Name]));
        end;
end;

end.
