unit frmScriptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IOUtils;

const
  sNewScript = '<new script>';
  sNewScriptName = '_newscript_';
  sScriptExt = '.pas';

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
    chkScriptsSubDir: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure cmbScriptsChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure EditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkScriptsSubDirClick(Sender: TObject);
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
    s := Path + s + sScriptExt;


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
    s := sNewScriptName;
  Editor.Lines.Clear;

  with TStringList.Create do try
    try LoadFromFile(Path + s + sScriptExt); except end;
    Editor.Lines.Text := Text;
    Editor.Modified := False;
    Editor.SetFocus;
    UpdateCaretPos;
  finally
    Free;
  end;
end;

procedure TfrmScript.UpdateCaretPos;
begin
  with Editor.CaretPos do
    lblPosition.Caption := Format('Line:%d Col:%d', [Succ(y), Succ(x)]);
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

procedure TfrmScript.chkScriptsSubDirClick(Sender: TObject);
begin
  if Self.Active then
    ReadScriptsList;
end;

procedure TfrmScript.ReadScriptsList;
var
  sl1, sl2: TStringList;
  f, sname: string;
  so: TSearchOption;
  i : Integer;
begin
  sl1 := TStringList.Create;
  sl2 := TStringList.Create;
  try
    if chkScriptsSubDir.Checked then
      so := TSearchOption.soAllDirectories
    else
      so := TSearchOption.soTopDirectoryOnly;
    for f in TDirectory.GetFiles(Path, '*' + sScriptExt, so) do begin
      sname := ChangeFileExt(Copy(f, Length(Path) + 1, Length(f)), '');
      if SameText(sNewScriptName, sname) then Continue;
      if Pos('\', sname) <> 0 then
        sl1.Add(sname)
      else
        sl2.Add(sname);
    end;
    sl1.Sort;
    sl2.Sort;
    sl1.Insert(0, sNewScript);
    sl1.AddStrings(sl2);
    cmbScripts.Items.Assign(sl1);
  finally
    sl1.Free;
    sl2.Free;
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
