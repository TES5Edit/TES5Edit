unit frmWorldspaceCellDetailsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TfrmWorldspaceCellDetails = class(TForm)
    rbPersistent: TRadioButton;
    rbTemporary: TRadioButton;
    sedX: TSpinEdit;
    sedY: TSpinEdit;
    lblX: TLabel;
    lblY: TLabel;
    btnCancel: TButton;
    btnOK: TButton;
    procedure rbTemporaryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  frmViewMain,
  wbInterface;

procedure TfrmWorldspaceCellDetails.FormCreate(Sender: TObject);
begin
  wbApplyFontAndScale(Self);
end;

procedure TfrmWorldspaceCellDetails.rbTemporaryClick(Sender: TObject);
begin
  sedX.SetFocus;
end;

function wbGetCellDetailsForWorldspaceImplementation(aWorldspace: IwbMainRecord; var aPersistent: Boolean; var aGridCell: TwbGridCell): Boolean;
begin
  with TfrmWorldspaceCellDetails.Create(frmMain) do try
    Result := ShowModal = mrOk;
    aPersistent := rbPersistent.Checked;
    aGridCell.x := sedX.Value;
    aGridCell.y := sedY.Value;
  finally
    Free;
  end;
end;

initialization
  wbGetCellDetailsForWorldspaceCallback := wbGetCellDetailsForWorldspaceImplementation;
end.
