{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeEditWarningForm;

{$I xeDefines.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, wbInterface;

type
  TfrmEditWarning = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    Image2: TImage;
    Panel3: TPanel;
    Label1: TLabel;
    Memo1: TMemo;
    Timer1: TTimer;
    Panel4: TPanel;
    btnOk: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    TimerCount: Integer;
  end;

implementation

{$R *.dfm}

procedure TfrmEditWarning.FormCreate(Sender: TObject);
begin
  TimerCount := 3;
  Panel1.Color := Darker(Panel2.Color, 0.1);
  btnOk.Enabled := False;
  btnOk.Caption := '&Yes I''m absolutely sure ('+IntToStr(TimerCount)+')';
end;

procedure TfrmEditWarning.FormShow(Sender: TObject);
begin
  if TimerCount <= 0 then begin
    Timer1.Enabled := False;
    btnOk.Caption := '&Yes I''m absolutely sure';
    btnOk.Enabled := True;
  end else begin
    btnOk.Caption := '&Yes I''m absolutely sure ('+IntToStr(TimerCount)+')';
  end;
end;

procedure TfrmEditWarning.Timer1Timer(Sender: TObject);
begin
  Dec(TimerCount);
  FormShow(Sender);
end;

end.
