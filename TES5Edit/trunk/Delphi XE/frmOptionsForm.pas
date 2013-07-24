unit frmOptionsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

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
    cbSortFLST: TCheckBox;
    tsColors: TTabSheet;
    clbConflictThis: TColorBox;
    Label3: TLabel;
    cbConflictThis: TComboBox;
    Label4: TLabel;
    cbConflictAll: TComboBox;
    clbConflictAll: TColorBox;
    cbSimpleRecords: TCheckBox;
    Label5: TLabel;
    edColumnWidth: TEdit;
    cbAutoSave: TCheckBox;
    cbTrackAllEditorID: TCheckBox;
    cbResolveAliases: TCheckBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cbConflictThisChange(Sender: TObject);
    procedure clbConflictThisChange(Sender: TObject);
    procedure cbConflictAllChange(Sender: TObject);
    procedure clbConflictAllChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

{$R *.dfm}

uses
  wbInterface, TypInfo;

var
  wbColorConflictAllDefault: TConflictAllColors;
  wbColorConflictThisDefault: TConflictThisColors;

procedure TfrmOptions.cbConflictAllChange(Sender: TObject);
begin
  clbConflictAll.Selected := wbColorConflictAll[TConflictAll(cbConflictAll.Items.Objects[cbConflictAll.ItemIndex])];
end;

procedure TfrmOptions.cbConflictThisChange(Sender: TObject);
begin
  clbConflictThis.Selected := wbColorConflictThis[TConflictThis(cbConflictThis.Items.Objects[cbConflictThis.ItemIndex])];
end;

procedure TfrmOptions.clbConflictAllChange(Sender: TObject);
begin
  wbColorConflictAll[TConflictAll(cbConflictAll.Items.Objects[cbConflictAll.ItemIndex])] := clbConflictAll.Selected;
end;

procedure TfrmOptions.clbConflictThisChange(Sender: TObject);
begin
  wbColorConflictThis[TConflictThis(cbConflictThis.Items.Objects[cbConflictThis.ItemIndex])] := clbConflictThis.Selected;
end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then begin
    wbColorConflictAll := wbColorConflictAllDefault;
    wbColorConflictThis := wbColorConflictThisDefault;
  end;
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
var
  ct: TConflictThis;
  ca: TConflictAll;
begin
  for ct := ctNotDefined to High(TConflictThis) do
    cbConflictThis.Items.AddObject(Copy(GetEnumName(TypeInfo(TConflictThis), Integer(ct)), 3, 100), Pointer(ct));
  cbConflictThis.ItemIndex := 0;
  cbConflictThisChange(nil);

  for ca := caNoConflict to High(TConflictAll) do
    cbConflictAll.Items.AddObject(Copy(GetEnumName(TypeInfo(TConflictAll), Integer(ca)), 3, 100), Pointer(ca));
  cbConflictAll.ItemIndex := 0;
  cbConflictAllChange(nil);

  wbColorConflictAllDefault := wbColorConflictAll;
  wbColorConflictThisDefault := wbColorConflictThis;
end;

procedure TfrmOptions.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

end.
