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
    cbChunk: TCheckBox;
    cmbLODLevel: TComboBox;
    edLODX: TEdit;
    edLODY: TEdit;
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
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    cmbCompDiffuse: TComboBox;
    Label13: TLabel;
    Label14: TLabel;
    cmbCompNormal: TComboBox;
    cmbCompSpecular: TComboBox;
    procedure cbObjectsLODClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSplitTreesLODClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SelectAll1Click(Sender: TObject);
    procedure SelectNone1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbChunkClick(Sender: TObject);
    procedure cbBuildAtlasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmLODGen.cbBuildAtlasClick(Sender: TObject);
begin
  cmbAtlasWidth.Enabled := cbBuildAtlas.Checked;
  cmbAtlasHeight.Enabled := cbBuildAtlas.Checked;
  cmbAtlasTextureSize.Enabled := cbBuildAtlas.Checked;
  cmbAtlasTextureUVRange.Enabled := cbBuildAtlas.Checked;
  Label5.Enabled := cbBuildAtlas.Checked;
  Label6.Enabled := cbBuildAtlas.Checked;
  Label7.Enabled := cbBuildAtlas.Checked;
end;

procedure TfrmLODGen.cbChunkClick(Sender: TObject);
begin
  cmbLODLevel.Enabled := cbChunk.Checked;
  edLODX.Enabled := cbChunk.Checked;
  edLODY.Enabled := cbChunk.Checked;
  Label10.Enabled := cbChunk.Checked;
  Label11.Enabled := cbChunk.Checked;
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
  Label8.Enabled := cbTreesLOD.Checked;
end;

procedure TfrmLODGen.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  if ModalResult = mrOk then begin
    for i := 0 to Pred(clbWorldspace.Items.Count) do
      if clbWorldspace.Checked[i] then
        Exit;
    ShowMessage('Select worldspace(s) for LOD generation');
    Action := caNone;
  end;
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
  cmbLODLevel.Items.Text := ''#13'4'#13'8'#13'16';
  cmbCompDiffuse.Items.Text := '888'#13'8888'#13'DXT1'#13'DXT3'#13'DXT5'#13'BC4'#13'BC5';
  cmbCompNormal.Items.Assign(cmbCompDiffuse.Items);
  cmbCompSpecular.Items.Assign(cmbCompDiffuse.Items);
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

