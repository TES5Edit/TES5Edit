unit frmTipForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uniGUIBaseClasses, uniGUIClasses, uniLabel;

type
  TfrmTip = class(TForm)
    Shape1: TShape;
    textTip: TStaticText;
    StaticText1: TStaticText;
    cbShowTip: TCheckBox;
    lblNextTip: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lblNextTipClick(Sender: TObject);
    procedure cbShowTipClick(Sender: TObject);
  private
    { Private declarations }
    slTips: TStringList;
  public
    { Public declarations }
    procedure NextTip;
  end;

var
  frmTip: TfrmTip;

procedure ShowTip;
procedure HideTip;

implementation

{$R *.dfm}

uses
  wbInterface;

procedure ShowTip;
begin
  if not Assigned(frmTip) then begin
    frmTip := TfrmTip.Create(Application);
    ShowWindow(frmTip.Handle, SW_SHOWNOACTIVATE);
    frmTip.Visible := True;
  end;
end;

procedure HideTip;
begin
  if Assigned(frmTip) then begin
    if frmTip.Visible then frmTip.Hide;
    FreeAndNil(frmTip);
  end;
end;

procedure TfrmTip.NextTip;
begin
  if slTips.Count <> 0 then
    textTip.Caption := slTips[Random(slTips.Count)];
end;

procedure TfrmTip.lblNextTipClick(Sender: TObject);
begin
  NextTip;
end;

procedure TfrmTip.cbShowTipClick(Sender: TObject);
begin
  wbShowTip := cbShowTip.Checked;
end;

procedure TfrmTip.FormCreate(Sender: TObject);
var
  TipsFile: string;
  i: integer;
begin
  TipsFile := ExtractFilePath(Application.ExeName) + wbToolName + 'Tips.txt';

  try
    if not FileExists(TipsFile) then
      Exit;

    slTips := TStringList.Create;
    slTips.LoadFromFile(TipsFile, TEncoding.UTF8);

    if slTips.Count = 0 then
        Exit;

    for i := Pred(slTips.Count) downto 0 do
      if Trim(slTips[i]) = '' then
        slTips.Delete(i);

    NextTip;

  except end;
end;

procedure TfrmTip.FormDestroy(Sender: TObject);
begin
  if Assigned(slTips) then
    slTips.Free;
end;

initialization
  Randomize;

end.
