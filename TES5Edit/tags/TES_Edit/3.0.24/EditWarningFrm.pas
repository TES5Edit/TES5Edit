{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

unit EditWarningFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

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

uses
  Colors;

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
