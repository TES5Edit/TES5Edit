unit frmDeveloperMessageForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  JvExStdCtrls, JvRichEdit, FileContainer;

type
  TfrmDeveloperMessage = class(TForm)
    btnCancel: TButton;
    btnOk: TButton;
    reMain: TJvRichEdit;
    tmrEnableButton: TTimer;
    fcMessage: TFileContainer;
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

  reMain.Zoom := MulDiv(MulDiv(reMain.Zoom, Abs(Font.Size), Abs(OldSize)), 90, 100);

  if wbThemesSupported then
    with TVclStylesSystemMenu.Create(Self) do begin
      ShowNativeStyle := True;
      MenuCaption := 'Theme';
    end;
end;

procedure TfrmDeveloperMessage.FormShow(Sender: TObject);
begin
  tmrEnableButton.Enabled := True;
end;

procedure TfrmDeveloperMessage.tmrEnableButtonTimer(Sender: TObject);
begin
  tmrEnableButton.Enabled := False;
  btnCancel.Enabled := True;
end;

end.
