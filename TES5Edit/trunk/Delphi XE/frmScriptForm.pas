unit frmScriptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

const
  sNewScript = '<new script>';

type
  TfrmScript = class(TForm)
    pnlTop: TPanel;
    Label1: TLabel;
    cmbScripts: TComboBox;
    pnlBottom: TPanel;
    btnCancel: TButton;
    btnOK: TButton;
    pnlStatus: TPanel;
    lblPosition: TLabel;
    btnSave: TButton;
    dlgSave: TSaveDialog;
    Editor: TMemo;
    procedure FormShow(Sender: TObject);
    procedure cmbScriptsChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure EditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    Path: string;
    LastUsedScript: string;
    Script: string;
    procedure UpdateCaretPos;
    procedure ReadScriptsList;
  end;

var
  frmScript: TfrmScript;

implementation

{$R *.dfm}

procedure TfrmScript.btnSaveClick(Sender: TObject);
var
  s, s2: string;
  i: integer;
begin
  if cmbScripts.ItemIndex = -1 then
    Exit;

  s := cmbScripts.Items[cmbScripts.ItemIndex];
  if s = sNewScript then begin
    dlgSave.InitialDir := Path;
    if dlgSave.Execute then begin
      s := dlgSave.FileName;
      s2 := ChangeFileExt(ExtractFileName(s), '');
      i := cmbScripts.Items.IndexOf(s2);
      if i = -1 then begin
        cmbScripts.Items.Add(s2);
        cmbScripts.ItemIndex := Pred(cmbScripts.Items.Count);
      end else
        cmbScripts.ItemIndex := i;
    end else
      Exit;
  end else
    s := Path + s + '.pas';


  with TStringList.Create do try
    Text := Editor.Lines.Text;
    SaveToFile(s);
    lblPosition.Caption := Format('Saved: %s', [ExtractFileName(s)]);
  finally
    Free;
  end;
end;

procedure TfrmScript.cmbScriptsChange(Sender: TObject);
var
  s: string;
begin
  if cmbScripts.ItemIndex = -1 then
    Exit;

  s := cmbScripts.Items[cmbScripts.ItemIndex];
  if s = sNewScript then
    s := '_newscript_';
  Editor.Lines.Clear;

  with TStringList.Create do try
    try LoadFromFile(Path + s + '.pas'); except end;
    Editor.Lines.Text := Text;
    Editor.Modified := False;
    Editor.SetFocus;
    UpdateCaretPos;
  finally
    Free;
  end;
end;

procedure TfrmScript.UpdateCaretPos;
var
  l, c: Word;
begin
  l := SendMessage(Editor.Handle, EM_LINEFROMCHAR, -1, 0);
  c := LoWord(SendMessage(Editor.Handle, EM_GETSEL, 0, 0)) - SendMessage(Editor.Handle, EM_LINEINDEX, -1, 0);
  lblPosition.Caption := Format('Line:%d Col:%d', [Succ(l), Succ(c)]);
end;

procedure TfrmScript.EditorMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  UpdateCaretPos;
end;

procedure TfrmScript.EditorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  UpdateCaretPos;
end;

procedure TfrmScript.ReadScriptsList;
var
  F : TSearchRec;
  sl: TStringList;
  i : Integer;
begin
  sl := TStringList.Create;
  try
    if FindFirst(Path + '*.pas', faAnyFile, F) = 0 then try
      repeat
        if not SameText('_newscript_.pas', F.Name) then
          sl.Add(ChangeFileExt(F.Name, ''));
      until FindNext(F) <> 0;
    finally
      FindClose(F);
    end;
    sl.Sort;
    sl.Insert(0, sNewScript);
    cmbScripts.Items.Assign(sl);
  finally
    sl.Free;
  end;

  i := cmbScripts.Items.IndexOf(LastUsedScript);
  if i = -1 then i := 0;
  cmbScripts.ItemIndex := i;
  cmbScriptsChange(Self);
end;

procedure TfrmScript.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then begin
    if Editor.Modified then
       btnSaveClick(Sender);
    Script := Editor.Lines.Text;
    LastUsedScript := cmbScripts.Items[cmbScripts.ItemIndex];
  end;
end;

procedure TfrmScript.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TfrmScript.FormShow(Sender: TObject);
begin
  ReadScriptsList;
end;

end.
