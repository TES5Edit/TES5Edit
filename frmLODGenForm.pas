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
    cbNoTangents: TCheckBox;
    cbNoVertexColors: TCheckBox;
    Label4: TLabel;
    btnSplitTreesLOD: TButton;
    PopupMenu1: TPopupMenu;
    SelectAll1: TMenuItem;
    SelectNone1: TMenuItem;
    procedure cbObjectsLODClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSplitTreesLODClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SelectAll1Click(Sender: TObject);
    procedure SelectNone1Click(Sender: TObject);
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
      SplitTreesLOD(IwbMainRecord(Integer(clbWorldspace.Items.Objects[i])));
end;

procedure TfrmLODGen.cbObjectsLODClick(Sender: TObject);
begin
  cbNoTangents.Enabled := cbObjectsLOD.Checked;
  cbNoVertexColors.Enabled := cbObjectsLOD.Checked;
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
