unit frmLODGenForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CheckLst, Menus, wbInterface;

type
  TfrmLODGen = class(TForm)
    clbWorldspace: TCheckListBox;
    pnlBottom: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    pnlBevel: TPanel;
    Label1: TLabel;
    cbObjectsLOD: TCheckBox;
    Label2: TLabel;
    cbTreesLOD: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    btnSplitTreesLOD: TButton;
    PopupMenu1: TPopupMenu;
    SelectAll1: TMenuItem;
    SelectNone1: TMenuItem;
    gbObjectsOptions: TGroupBox;
    cbBuildAtlas: TCheckBox;
    cbNoTangents: TCheckBox;
    cbNoVertexColors: TCheckBox;
    cmbAtlasWidth: TComboBox;
    cmbAtlasHeight: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    cmbAtlasTextureSize: TComboBox;
    Label7: TLabel;
    cmbAtlasTextureUVRange: TComboBox;
    Label8: TLabel;
    cmbTreesLODBrightness: TComboBox;
    Label9: TLabel;
    procedure cbObjectsLODClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSplitTreesLODClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SelectAll1Click(Sender: TObject);
    procedure SelectNone1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SplitTreesLOD: procedure (const aWorldspace: IwbMainRecord) of object;
  end;

var
  frmLODGen: TfrmLODGen;

implementation

{$R *.dfm}

procedure TfrmLODGen.btnSplitTreesLODClick(Sender: TObject);
var
  i: integer;
begin
  if not Assigned(SplitTreesLOD) then
    Exit;

  for i := 0 to Pred(clbWorldspace.Count) do
    if clbWorldspace.Checked[i] then
      SplitTreesLOD(IwbMainRecord(Pointer(clbWorldspace.Items.Objects[i])));
end;

procedure TfrmLODGen.cbObjectsLODClick(Sender: TObject);
begin
  gbObjectsOptions.Enabled := cbObjectsLOD.Checked;
  gbObjectsOptions.Visible := cbObjectsLOD.Checked;
  if wbGameMode in [gmFO3, gmFNV] then begin
    gbObjectsOptions.Enabled := False;
    gbObjectsOptions.Visible := False;
  end;
  cmbTreesLODBrightness.Enabled := cbTreesLOD.Checked;
end;

procedure TfrmLODGen.FormCreate(Sender: TObject);
var
  i: integer;
  v: double;
begin
  i := 1024;
  while i <= 8192 do begin
    cmbAtlasWidth.Items.Add(IntToStr(i));
    cmbAtlasHeight.Items.Add(IntToStr(i));
    i := i * 2;
  end;
  i := 256;
  while i <= 1024 do begin
    cmbAtlasTextureSize.Items.Add(IntToStr(i));
    i := i * 2;
  end;
  v := 1.0;
  while v <= 10.0 do begin
    cmbAtlasTextureUVRange.Items.Add(Format('%1.1f', [v]));
    v := v + 0.1;
  end;
  i := -30;
  while i <= 30 do begin
    cmbTreesLODBrightness.Items.Add(IntToStr(i));
    Inc(i);
  end;
end;

procedure TfrmLODGen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TfrmLODGen.FormShow(Sender: TObject);
begin
  cbObjectsLODClick(nil);
end;

procedure TfrmLODGen.SelectAll1Click(Sender: TObject);
var
  i: Integer;
begin
  clbWorldspace.Items.BeginUpdate;
  try
    for i := 0 to Pred(clbWorldspace.Items.Count) do
      if clbWorldspace.ItemEnabled[i] then
        clbWorldspace.Checked[i] := True;
  finally
    clbWorldspace.Items.EndUpdate;
  end;
end;

procedure TfrmLODGen.SelectNone1Click(Sender: TObject);
var
  i: Integer;
begin
  clbWorldspace.Items.BeginUpdate;
  try
    for i := 0 to Pred(clbWorldspace.Items.Count) do
      if clbWorldspace.ItemEnabled[i] then
        clbWorldspace.Checked[i] := False;
  finally
    clbWorldspace.Items.EndUpdate;
  end;
end;

end.
