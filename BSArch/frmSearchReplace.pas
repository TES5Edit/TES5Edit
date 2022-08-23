unit frmSearchReplace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormSearchReplace = class(TForm)
    edSearch: TLabeledEdit;
    edReplace: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    rbReplace: TRadioButton;
    rbPrepend: TRadioButton;
    rbAppend: TRadioButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rbReplaceClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SearchText: string;
    ReplaceText: string;
  end;

var
  FormSearchReplace: TFormSearchReplace;

implementation

{$R *.dfm}

//============================================================================
procedure TFormSearchReplace.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

//============================================================================
procedure TFormSearchReplace.rbReplaceClick(Sender: TObject);
begin
  if rbReplace.Checked then begin
    edSearch.EditLabel.Caption := 'Search';
    edReplace.Visible := True;
  end
  else begin
    edSearch.EditLabel.Caption := 'Text';
    edReplace.Visible := False;
  end;
end;

//============================================================================
procedure TFormSearchReplace.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult <> mrOk then
    Exit;

  if rbReplace.Checked and (edSearch.Text = '') then begin
    ShowMessage('Search string can not be empty');
    Action := caNone;
    Exit;
  end;

  SearchText := edSearch.Text;
  ReplaceText := edReplace.Text;
end;

//============================================================================
procedure TFormSearchReplace.FormShow(Sender: TObject);
begin
  Font.Size := Screen.MenuFont.Size;
end;


end.
