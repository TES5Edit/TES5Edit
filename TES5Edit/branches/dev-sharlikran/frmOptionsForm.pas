unit frmOptionsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmOptions = class(TForm)
    pcOptions: TPageControl;
    tsCleaning: TTabSheet;
    btnOK: TButton;
    btnCancel: TButton;
    cbUDRSetXESP: TCheckBox;
    cbUDRSetScale: TCheckBox;
    cbUDRSetZ: TCheckBox;
    edUDRSetScaleValue: TEdit;
    edUDRSetZValue: TEdit;
    cbUDRSetMSTT: TCheckBox;
    edUDRSetMSTTValue: TEdit;
    Label1: TLabel;
    tsGeneral: TTabSheet;
    cbIKnow: TCheckBox;
    cbHideUnused: TCheckBox;
    cbHideIgnored: TCheckBox;
    cbHideNeverShow: TCheckBox;
    cbLoadBSAs: TCheckBox;
    Label2: TLabel;
    cbSortFLST: TCheckBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

{$R *.dfm}

procedure TfrmOptions.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

end.
