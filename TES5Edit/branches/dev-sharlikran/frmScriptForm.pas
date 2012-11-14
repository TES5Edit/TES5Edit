unit frmScriptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, JvExControls, JvEditorCommon, JvEditor,
  JvHLEditor;

const
  sNewScript = '<new script>';

type
  TfrmScript = class(TForm)
    Editor: TJvHLEditor;
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
    procedure FormShow(Sender: TObject);
    procedure cmbScriptsChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditorCaretChanged(Sender: TObject; LastCaretX,
      LastCaretY: Integer);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ScriptsPath: string;
    LastUsedScript: string;
    Script: string;
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
    dlgSave.InitialDir := ScriptsPath;
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
    s := ScriptsPath + s + '.pas';


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
    LoadFromFile(ScriptsPath + s + '.pas');
    Editor.Lines.Text := Text;
    Editor.SetFocus;
    EditorCaretChanged(Editor, 0, 0);
  finally
    Free;
  end;
end;

procedure TfrmScript.ReadScriptsList;
var
  F : TSearchRec;
  sl: TStringList;
  i : Integer;
begin
  sl := TStringList.Create;
  try
    if FindFirst(ScriptsPath + '*.pas', faAnyFile, F) = 0 then try
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

procedure TfrmScript.EditorCaretChanged(Sender: TObject; LastCaretX,
  LastCaretY: Integer);
begin
  lblPosition.Caption := Format('Line:%d Col:%d', [Editor.CaretY + 1, Editor.CaretX + 1]);
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

procedure TfrmScript.FormShow(Sender: TObject);
begin
  ReadScriptsList;
end;

end.
