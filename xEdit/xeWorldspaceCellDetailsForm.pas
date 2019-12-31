{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeWorldspaceCellDetailsForm;

{$I xeDefines.inc}

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
  xeMainForm,
  wbInterface;

procedure TfrmWorldspaceCellDetails.FormCreate(Sender: TObject);
begin
  xeApplyFontAndScale(Self);
end;

procedure TfrmWorldspaceCellDetails.rbTemporaryClick(Sender: TObject);
begin
  sedX.SetFocus;
end;

function xeGetCellDetailsForWorldspaceImplementation(aWorldspace: IwbMainRecord; var aPersistent: Boolean; var aGridCell: TwbGridCell): Boolean;
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
  wbGetCellDetailsForWorldspaceCallback := xeGetCellDetailsForWorldspaceImplementation;
end.
