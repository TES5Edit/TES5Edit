unit frmDeveloperMessageForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  JvExStdCtrls, JvRichEdit, FileContainer, JvHtControls;

type
  TfrmDeveloperMessage = class(TForm)
    btnOops: TButton;
    btnCancel: TButton;
    cbDontShowAgain: TCheckBox;
    btnOk: TButton;

    reMain: TJvRichEdit;
    fcMessage: TFileContainer;
    fcMessageThanks: TFileContainer;

    pnlElminster: TPanel;
    imgElminster: TImage;
    fcImage: TFileContainer;

    tmrEnableButton: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure btnOopsClick(Sender: TObject);

    procedure tmrEnableButtonTimer(Sender: TObject);
  private
    procedure FixZoom;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  wbInterface,
  frmViewMain,
  Vcl.Styles.Utils.SystemMenu;

procedure TfrmDeveloperMessage.FixZoom;
var
  i, CharCount : Integer;
  pt        : TPoint;
begin
  if RichEditVersion >= 3 then begin
    reMain.Zoom := reMain.Zoom - 1;
    reMain.SelLength := 0;
    reMain.SelStart := 100000;
    i := reMain.SelStart;
    reMain.SelText := #13#13;
    reMain.SelStart := 100000;
    CharCount := reMain.SelStart;
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

    reMain.SelStart := i;
    reMain.SelLength := 1000;
    reMain.SelText := '';
    reMain.SelStart := 0;
  end else
    pnlElminster.Visible := False;
end;

procedure TfrmDeveloperMessage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not (btnCancel.Enabled or (ModalResult = mrOk)) then
    Action := caNone;
end;

procedure TfrmDeveloperMessage.FormCreate(Sender: TObject);
var
  Stream: TStream;
begin
  wbApplyFontAndScale(Self);

  Stream := fcImage.CreateReadStream;
  try
    imgElminster.Picture.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;

  if wbPatron then begin
    btnOops.Visible := True;
    cbDontShowAgain.Caption := '&Don''t show again until changed';
    Stream := fcMessageThanks.CreateReadStream
  end else begin
    btnOops.Visible := False;
    cbDontShowAgain.Caption := '&Don''t show again for a while';
    Stream := fcMessage.CreateReadStream;
  end;
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
begin
  tmrEnableButton.Enabled := True;
  FixZoom;
end;

procedure TfrmDeveloperMessage.btnOopsClick(Sender: TObject);
var
  Stream: TStream;
begin
  wbPatron := False;
  LockWindowUpdate(Handle);
  try
    btnOops.Visible := False;
    cbDontShowAgain.Caption := '&Don''t show again for a while';
    Stream := fcMessage.CreateReadStream;
    try
      reMain.Lines.LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
    FixZoom;
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TfrmDeveloperMessage.tmrEnableButtonTimer(Sender: TObject);
begin
  tmrEnableButton.Enabled := False;
  btnCancel.Enabled := True;
end;

end.
