unit frmDeveloperMessageForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  JvExStdCtrls, JvRichEdit, FileContainer, dxGDIPlusClasses;

type
  TfrmDeveloperMessage = class(TForm)
    btnCancel: TButton;
    btnOk: TButton;
    reMain: TJvRichEdit;
    tmrEnableButton: TTimer;
    fcMessage: TFileContainer;
    pnlElminster: TPanel;
    imgElminster: TImage;
    procedure FormCreate(Sender: TObject);
    procedure tmrEnableButtonTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  wbInterface,
  frmViewMain,
  Vcl.Styles.Utils.SystemMenu;

procedure TfrmDeveloperMessage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not (btnCancel.Enabled or (ModalResult = mrOk)) then
    Action := caNone;
end;

procedure TfrmDeveloperMessage.FormCreate(Sender: TObject);
var
  Stream: TStream;
  OldSize: Integer;
begin
  OldSize := Font.Size;

  wbApplyFontAndScale(Self);

  Stream := fcMessage.CreateReadStream;
  try
    reMain.Lines.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;

  if wbThemesSupported then
    with TVclStylesSystemMenu.Create(Self) do begin
      ShowNativeStyle := True;
      MenuCaption := 'Theme';
    end;
end;

procedure TfrmDeveloperMessage.FormShow(Sender: TObject);
var
  CharCount : Integer;
  pt        : TPoint;
begin
  tmrEnableButton.Enabled := True;

  if RichEditVersion >= 3 then begin
    reMain.Zoom := reMain.Zoom - 1;
    CharCount := Length(reMain.Text);
    pt := reMain.GetCharPos(CharCount);
    while pt.Y < reMain.Height do begin
      reMain.Zoom := reMain.Zoom + 1;
      pt := reMain.GetCharPos(CharCount);
    end;
    while pt.Y > reMain.Height do begin
      reMain.Zoom := reMain.Zoom - 1;
      pt := reMain.GetCharPos(CharCount);
    end;
    while pt.Y < reMain.Height do begin
      reMain.Zoom := reMain.Zoom + 1;
      pt := reMain.GetCharPos(CharCount);
    end;
    while pt.Y > reMain.Height do begin
      reMain.Zoom := reMain.Zoom - 1;
      pt := reMain.GetCharPos(CharCount);
    end;
    pt := reMain.GetCharPos(80);
    pnlElminster.Top := reMain.Top + 10;
    pnlElminster.Height := pt.y - 20;
    pnlElminster.Width := pnlElminster.Height;
    pnlElminster.Left := (reMain.Left + reMain.Width) - (pnlElminster.Width + 10);
  end else
    pnlElminster.Visible := False;
end;

procedure TfrmDeveloperMessage.tmrEnableButtonTimer(Sender: TObject);
begin
  tmrEnableButton.Enabled := False;
  btnCancel.Enabled := True;
end;

end.
