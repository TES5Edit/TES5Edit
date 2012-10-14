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

unit ViewElementsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, wbInterface, ComCtrls, ExtCtrls, StdCtrls, Buttons, Menus, IniFiles;

type
  TfrmViewElements = class(TForm)
    Panel1: TPanel;
    pcView: TPageControl;
    Panel2: TPanel;
    PopupMenu1: TPopupMenu;
    mniCompareConf: TMenuItem;
    pnlButtons: TPanel;
    btnCompare: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure mniCompareConfClick(Sender: TObject);
  private
    Edits: TList;
    procedure MemoChange(Sender: TObject);
  public
    Settings: TMemIniFile;
    CompareCmdLine: string;
    procedure AddElement(const aElement: IwbElement; aFocused, aEditable: Boolean);
    function ShowModal: Integer; override;
    { Public declarations }
  end;

  TwbTabSheet = class(TTabSheet)
  private
//    Element: IwbElement;
  end;

  TwbEdit = class
    eElement: IwbElement;
    eMemo: TMemo;
  end;

implementation

{$R *.dfm}

uses
  ShellApi;

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

  if not Assigned(Edits) then
    Edits := TList.Create;

  TabSheet := TwbTabSheet.Create(Self);
  TabSheet.PageControl := pcView;
  TabSheet.Caption := aElement._File.Name;
//  TabSheet.Element := aElement;

  Memo := TMemo.Create(TabSheet);
  Memo.Parent := TabSheet;
  if aEditable then begin
    Memo.Lines.Text := aElement.EditValue;
    btnOK.Visible := True;
    //btnCancel.Kind := bkAbort;
    Edit := TwbEdit.Create;
    Edit.eElement := aElement;
    Edit.eMemo := Memo;
    Edits.Add(Edit);
  end else
    Memo.Lines.Text := aElement.Value;
  Memo.Align := alClient;
  Memo.ReadOnly := not aEditable;
  if not aEditable then
    Memo.ParentColor := True;
//  Memo.BorderStyle := bsNone;
  Memo.ScrollBars := ssBoth;
  Memo.Modified := False;
  Memo.OnChange := MemoChange;

  if aFocused then
    pcView.ActivePage := TabSheet;
end;

procedure TfrmViewElements.btnCompareClick(Sender: TObject);
var
  TabSheet : TTabSheet;
  idx, hinst: integer;
  Path, aFile1, aFile2, aExe, aParams: string;
  StartUpInfo: TStartUpInfo;
  ProcessInfo: TProcessInformation;
begin
  if pcView.PageCount < 2 then
    Exit;

  idx := pcView.TabIndex;
  if idx = 0 then
    Inc(idx);

  Path := ExtractFilePath(Application.ExeName);
  aExe := Trim(Copy(CompareCmdLine, 1, Pred(Pos('%', CompareCmdLine))));
  aParams := Copy(CompareCmdLine, Succ(Length(aExe)), Length(CompareCmdLine));
  //aExe := '"' + aExe + '"';

  try
    TabSheet := pcView.Pages[idx];
    aFile2 := Path + TabSheet.Caption + '.txt';
    TMemo(TabSheet.Controls[0]).Lines.SaveToFile(aFile2);
    aParams := StringReplace(aParams, '%2', '"'+aFile2+'"', []);

    TabSheet := pcView.Pages[Pred(idx)];
    aFile1 := Path + TabSheet.Caption + '.txt';
    TMemo(TabSheet.Controls[0]).Lines.SaveToFile(aFile1);
    aParams := StringReplace(aParams, '%1', '"'+aFile1+'"', []);

    FillChar(StartUpInfo, SizeOf(TStartUpInfo), 0);
    with StartUpInfo do begin
      cb := SizeOf(TStartUpInfo);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
      wShowWindow := SW_SHOWNORMAL;
    end;

    if CreateProcess(PChar(aExe), PChar(aParams),
      nil, nil, false, NORMAL_PRIORITY_CLASS,
      nil, nil, StartUpInfo, ProcessInfo)
    then begin
      WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
      //GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);
      CloseHandle(ProcessInfo.hThread);
      CloseHandle(ProcessInfo.hProcess);
      DeleteFile(aFile1);
      DeleteFile(aFile2);
    end else
      raise Exception.Create(SysErrorMessage(GetLastError));
  except
    on E: Exception do
      MessageBox(0, PChar('Could not execute command line'#13 + aExe + ' ' + aParams + #13'Error: ' + E.Message), 'Error', 0);
  end;
end;

procedure TfrmViewElements.mniCompareConfClick(Sender: TObject);
begin
  if InputQuery('Comparison program', 'Command line (%1 and %2 are temp text files)', CompareCmdLine) then begin
    Settings.WriteString('External', 'CompareCommandLine', CompareCmdLine);
    Settings.UpdateFile;
  end;
end;

procedure TfrmViewElements.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmViewElements.FormCreate(Sender: TObject);
begin
  Font := Screen.IconFont;
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

function TfrmViewElements.ShowModal: Integer;
var
  i: Integer;
begin
  if Assigned(Settings) then
    CompareCmdLine := Settings.ReadString('External', 'CompareCommandLine', 'bcompare.exe %1 %2');

  if pcView.PageCount > 0 then begin
    if pcView.ActivePage = nil then
      pcView.ActivePage := pcView.Pages[0];
    Result := inherited ShowModal;
  end else
    Result := mrAbort;

  try

  if Result = mrOk then
    for i := 0 to Edits.Count - 1 do
      with TwbEdit(Edits[i]) do
        if eMemo.Modified then try
            eElement.EditValue := eMemo.Text;
          except
            on E: Exception do
              ShowMessage(Format('Assignment error: %s'#13#10'File: %s'#13#10'Element: %s',
                [E.Message, eElement._File.FileName, eElement.Name]));
          end;

  finally
    for i := 0 to Pred(Edits.Count) do
      TwbEdit(Edits[i]).Free;
    Edits.Free;
  end;
end;

end.
