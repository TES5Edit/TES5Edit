unit frmScriptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IOUtils, Vcl.ComCtrls;

const
  sNewScript = '<new script>';
  sNewScriptName = '_newscript_';
  sScriptExt = '.pas';

type
  TComboBox = class(StdCtrls.TComboBox)
  protected {private}
    FOnBeforeWheel: TNotifyEvent;
    FOnAfterWheel: TNotifyEvent;
  protected
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;

    property OnBeforeWheel: TNotifyEvent read FOnBeforeWheel write FOnBeforeWheel;
    property OnAfterWheel: TNotifyEvent read FOnAfterWheel write FOnAfterWheel;
  end;

  TfrmScript = class(TForm)
    pnlTop: TPanel;
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
    edFilter: TEdit;
    lblScript: TLabel;
    lblFilter: TLabel;
    procedure FormShow(Sender: TObject);
    procedure cmbScriptsChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure EditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkScriptsSubDirClick(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure cmbScriptsSelect(Sender: TObject);
    procedure cmbScriptsEnter(Sender: TObject);
    procedure cmbScriptsExit(Sender: TObject);
    procedure cmbScriptsCloseUp(Sender: TObject);
    procedure cmbScriptsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbScriptsDropDown(Sender: TObject);
    procedure cmbScriptsBeforeWheel(Sender: TObject);
    procedure cmbScriptsAfterWheel(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    ScriptSelectionChanged : Boolean;
    LastCloseUp : Int64;
    SelectionOnDropDown: string;
    ScriptSelectionChangedOnDropDown : Boolean;
    SelectionOnEnter: string;
    SaveOverride: string;
    procedure DoScriptSelectionChange;
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

  s := SaveOverride;
  if s = '' then
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
      SaveOverride := s2;
    end else
      Exit;
  end else
    s := Path + s + sScriptExt;

  with TStringList.Create do try
    Text := Editor.Lines.Text;
    CopyFile(PChar(s), PChar(s + '.backup.' + FormatDateTime('yyyy_mm_dd_hh_nn_ss', Now)), True);
    SaveToFile(s);
    lblPosition.Caption := Format('Saved: %s', [ExtractFileName(s)]);
    ScriptSelectionChanged := False;
    Editor.Modified := False;
  finally
    Free;
  end;
end;

procedure TfrmScript.cmbScriptsAfterWheel(Sender: TObject);
begin
  if not (cmbScripts.Focused or cmbScripts.DroppedDown) then begin
    if SelectionOnEnter <> cmbScripts.Text then
      ScriptSelectionChanged := True;
    if ScriptSelectionChanged then
      DoScriptSelectionChange;
  end;
end;

procedure TfrmScript.cmbScriptsBeforeWheel(Sender: TObject);
begin
  if not (cmbScripts.Focused or cmbScripts.DroppedDown) then begin
    ScriptSelectionChanged := False;
    SelectionOnEnter := cmbScripts.Text;
  end;
end;

procedure TfrmScript.cmbScriptsChange(Sender: TObject);
begin
  ScriptSelectionChanged := True;
end;

procedure TfrmScript.cmbScriptsCloseUp(Sender: TObject);
begin
  if ScriptSelectionChanged then
    DoScriptSelectionChange
  else
    LastCloseUp := GetTickCount64;
end;

procedure TfrmScript.cmbScriptsDropDown(Sender: TObject);
begin
  SelectionOnDropDown := cmbScripts.Text;
  ScriptSelectionChangedOnDropDown := ScriptSelectionChanged;
end;

procedure TfrmScript.cmbScriptsEnter(Sender: TObject);
begin
  ScriptSelectionChanged := False;
  SelectionOnEnter := cmbScripts.Text;
end;

procedure TfrmScript.cmbScriptsExit(Sender: TObject);
begin
  if ScriptSelectionChanged then
    DoScriptSelectionChange;
end;

procedure TfrmScript.cmbScriptsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: begin
      Key := 0;
      if ScriptSelectionChanged then
        DoScriptSelectionChange
      else
        Editor.SetFocus;
    end;
  end;
end;

procedure TfrmScript.cmbScriptsSelect(Sender: TObject);
begin
  ScriptSelectionChanged := True;
  if (GetTickCount64 - LastCloseUp) < 50 then
    DoScriptSelectionChange;
end;

procedure TfrmScript.DoScriptSelectionChange;
var
  s: string;
begin
  ScriptSelectionChanged := False;
  if cmbScripts.ItemIndex = -1 then
    Exit;

  s := cmbScripts.Items[cmbScripts.ItemIndex];

  if Editor.Modified and (string(Editor.Text).Trim <> '') then
    if MessageDlg('The previous script ("' + SaveOverride + '") has been modified. Do you want to save it before loading the new script?', mtConfirmation,mbYesNo, 0) = mrYes then
      btnSaveClick(Self);

  SaveOverride := s;
  if s = sNewScript then
    s := sNewScriptName;

  Editor.Lines.Clear;

  with TStringList.Create do try
    try
      LoadFromFile(Path + s + sScriptExt);
    except end;
    Editor.Lines.Text := Text;
    Editor.Modified := False;
    if not edFilter.Focused then
      Editor.SetFocus;
    UpdateCaretPos;
  finally
    Free;
  end;
  ScriptSelectionChanged := False;
end;

procedure TfrmScript.edFilterChange(Sender: TObject);
begin
  if Self.Active then
    ReadScriptsList;
end;

procedure TfrmScript.edFilterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: begin
      Key := 0;
      cmbScripts.SetFocus;
      cmbScripts.DroppedDown := True;
    end;
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
  if Self.Active then begin
    ReadScriptsList;
    cmbScripts.SetFocus;
  end;
end;

procedure TfrmScript.ReadScriptsList;
var
  sl1, sl2: TStringList;
  f, sname: string;
  so: TSearchOption;
  i : Integer;
  s : string;
  CurrentSelection: string;
begin
  CurrentSelection := cmbScripts.Text;

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
    sl1.AddStrings(sl2);
    sl1.Insert(0, sNewScript);
    s := edFilter.Text;
    s := s.ToLower.Trim;
    if s <> '' then
      for i := Pred(sl1.Count) downto 0 do
        if not sl1[i].ToLower.Contains(s) then
          sl1.Delete(i);
    cmbScripts.Items.Assign(sl1);
  finally
    sl1.Free;
    sl2.Free;
  end;

  if CurrentSelection = '' then begin
    CurrentSelection := LastUsedScript;
    ScriptSelectionChanged := True;
  end;

  i := cmbScripts.Items.IndexOf(CurrentSelection);
  if i = -1 then begin
    i := 0;
    ScriptSelectionChanged := True;
  end;
  cmbScripts.ItemIndex := i;

  if ScriptSelectionChanged then
    DoScriptSelectionChange;
end;

procedure TfrmScript.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then begin
    if Editor.Modified then
      if MessageDlg('The script has been modified. Do you want to save it?', mtConfirmation,mbYesNo, 0) = mrYes then
        btnSaveClick(Sender);
    Script := Editor.Lines.Text;
    LastUsedScript := cmbScripts.Items[cmbScripts.ItemIndex];
  end;
end;

procedure TfrmScript.FormCreate(Sender: TObject);
begin
  cmbScripts.OnBeforeWheel := cmbScriptsBeforeWheel;
  cmbScripts.OnAfterWheel := cmbScriptsAfterWheel;
end;

procedure TfrmScript.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: Integer;
begin
  if Key = VK_ESCAPE then
    if edFilter.Focused then begin
      edFilter.Text := '';
      edFilterChange(Sender);
    end else if cmbScripts.Focused then begin
      if not cmbScripts.DroppedDown then begin
        i := cmbScripts.Items.IndexOf(SelectionOnEnter);
        if i < 0 then
          i := 0;
        if cmbScripts.ItemIndex <> i then begin
          cmbScripts.ItemIndex := i;
          ScriptSelectionChanged := False;
        end;
      end else
        if SelectionOnDropDown <> cmbScripts.Text then begin
          i := cmbScripts.Items.IndexOf(SelectionOnDropDown);
          if i >= 0 then begin
            cmbScripts.ItemIndex := i;
            ScriptSelectionChanged := ScriptSelectionChangedOnDropDown;
          end;
        end;
    end else
      ModalResult := mrCancel;
end;

procedure TfrmScript.FormShow(Sender: TObject);
begin
  ScriptSelectionChanged := True;
  ReadScriptsList;
end;

{ TComboBox }

procedure TComboBox.WMMouseWheel(var Message: TWMMouseWheel);
begin
  if Assigned(FOnBeforeWheel) then
    FOnBeforeWheel(Self);
  inherited;
  if Assigned(FOnAfterWheel) then
    FOnAfterWheel(Self);
end;

end.
