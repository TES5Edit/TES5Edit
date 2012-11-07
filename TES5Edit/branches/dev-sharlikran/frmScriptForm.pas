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
    procedure FormShow(Sender: TObject);
    procedure cmbScriptsChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmScript.cmbScriptsChange(Sender: TObject);
var
  s: string;
begin
  if cmbScripts.ItemIndex = -1 then
    Exit;

  s := cmbScripts.Items[cmbScripts.ItemIndex];
  Editor.Lines.Clear;

  if s = sNewScript then begin
    with Editor.Lines do begin
      Add('unit userscript;');
      Add('');
      Add('procedure Process(e: IInterface);');
      Add('begin');
      Add('  // comment this out if you don''t want those messages');
      Add('  AddMessage(''Processing: '' + GetFullPath(e));');
      Add('');
      Add('  // processing code goes here');
      Add('');
      Add('end;');
      Add('');
      Add('end.');
    end;
  end else begin
    with TStringList.Create do try
      LoadFromFile(ScriptsPath + s + '.pas');
      Editor.Lines.Text := Text;
    finally
      Free;
    end;
  end;

end;

procedure TfrmScript.ReadScriptsList;
var
  F : TSearchRec;
  i : Integer;
begin
  cmbScripts.Items.Add(sNewScript);
  if FindFirst(ScriptsPath + '*.pas', faAnyFile, F) = 0 then try
    repeat
      cmbScripts.Items.Add(ChangeFileExt(F.Name, ''));
    until FindNext(F) <> 0;
  finally
    FindClose(F);
  end;

  i := cmbScripts.Items.IndexOf(LastUsedScript);
  if i = -1 then i := 0;
  cmbScripts.ItemIndex := i;
  cmbScriptsChange(Self);
end;

procedure TfrmScript.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Script := Editor.Lines.Text;
end;

procedure TfrmScript.FormShow(Sender: TObject);
begin
  ReadScriptsList;
end;

end.
