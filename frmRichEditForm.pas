unit frmRichEditForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExStdCtrls, JvRichEdit,
  Vcl.ExtCtrls;

type
  TfrmRichEdit = class(TForm)
    btnOk: TButton;
    reMain: TJvRichEdit;
    tmrEnableButton: TTimer;
    cbDontShowAgain: TCheckBox;
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

procedure TfrmRichEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not btnOk.Enabled then
    Action := caNone;
end;

procedure TfrmRichEdit.FormCreate(Sender: TObject);
begin
  wbApplyFontAndScale(Self);

  if wbThemesSupported then
    with TVclStylesSystemMenu.Create(Self) do begin
      ShowNativeStyle := True;
      MenuCaption := 'Theme';
    end;
end;

procedure TfrmRichEdit.FormShow(Sender: TObject);
begin
  tmrEnableButton.Enabled := True;
end;

procedure TfrmRichEdit.tmrEnableButtonTimer(Sender: TObject);
begin
  tmrEnableButton.Enabled := False;
  btnOk.Enabled := True;
end;

end.
