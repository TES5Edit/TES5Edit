unit frmTipForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, FileContainer;

type
  TfrmTip = class(TForm)
    Shape1: TShape;
    textTip: TStaticText;
    StaticText1: TStaticText;
    cbShowTip: TCheckBox;
    lblNextTip: TLabel;
    fcEditTips: TFileContainer;
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
  if Assigned(slTips) and (slTips.Count <> 0) then
    textTip.Caption := slTips[Random(slTips.Count)];
end;

procedure TfrmTip.lblNextTipClick(Sender: TObject);
begin
  NextTip;
end;

procedure TfrmTip.cbShowTipClick(Sender: TObject);
begin
  wbShowTip := Assigned(cbShowTip) and cbShowTip.Checked;
end;

procedure TfrmTip.FormCreate(Sender: TObject);
var
  FileContainer : TFileContainer;
  Stream        : TStream;

  TipsFile: string;
  i: integer;
begin
  slTips := TStringList.Create;
  try
    FileContainer := FindComponent('fc'+wbToolName+'Tips') as TFileContainer;

    TipsFile := ExtractFilePath(Application.ExeName) + wbToolName + 'Tips.Override.txt';
    if FileExists(TipsFile) then try
      slTips.LoadFromFile(TipsFile, TEncoding.UTF8);
    except end;

    if (slTips.Count < 1) and Assigned(FileContainer) then try
      Stream := FileContainer.CreateReadStream;
      try
        slTips.LoadFromStream(Stream, TEncoding.UTF8);
      finally
        Stream.Free
      end;
    except end;

    if slTips.Count < 1 then try
      TipsFile := ExtractFilePath(Application.ExeName) + wbToolName + 'Tips.txt';
      if FileExists(TipsFile) then
        slTips.LoadFromFile(TipsFile, TEncoding.UTF8);
    except end;

    for i := Pred(slTips.Count) downto 0 do
      if Trim(slTips[i]) = '' then
        slTips.Delete(i);

    if slTips.Count = 0 then
        Exit;

    NextTip;

  except end;
end;

procedure TfrmTip.FormDestroy(Sender: TObject);
begin
  FreeAndNil(slTips);
end;

initialization
  Randomize;

end.
