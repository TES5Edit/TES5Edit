unit uFormIDArray;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, GlassButton, uESSFile;

type
  TfAddFormIDArray = class(TForm)
    stFormIDArray: TStaticText;
    meFormIDArray: TMaskEdit;
    edCount: TEdit;
    stCounter: TStaticText;
    udCount: TUpDown;
    stIDExists: TStaticText;
    procedure meFormIDArrayKeyPress(Sender: TObject; var Key: Char);
    procedure edCountKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure meFormIDArrayExit(Sender: TObject);
    procedure meFormIDArrayEnter(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    btnAdd, btnCancel: TGlassButton;
    faData: PFormIDArray;
    pESS: PESSFile;
  public
    function AddFormIDArray(var Data: TFormIDArray; ESS: PESSFile = nil): Boolean;
  end;

implementation

uses
  uHelper, uMain, CommCtrl, uAddForm;

{$R *.dfm}

procedure TfAddFormIDArray.edCountKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9']) then
    Key := #0;
end;

procedure TfAddFormIDArray.FormCreate(Sender: TObject);
begin
  btnCancel := CreateButton('Cancel', True, clBlack, ClientWidth - 75 - 4, ClientHeight - 25 - 4, 25, 75, 12, 1, [akLeft, akBottom], Self, Self, fMain.imImages, btnCancelClick, nil);
  btnAdd := CreateButton('Add formID array', False, clBlack, btnCancel.Left - 115 - 4, btnCancel.Top, 25, 115, 13, 0, [akLeft, akBottom], Self, Self, fMain.imImages, btnAddClick, nil);
end;

procedure TfAddFormIDArray.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfAddFormIDArray.FormShow(Sender: TObject);
begin
  if Assigned(faData) then
    with faData^ do
    begin
      meFormIDArray.Text := RefIDToString(ID);
      edCount.Text := IntToStr(Count);
    end;
end;

procedure TfAddFormIDArray.meFormIDArrayEnter(Sender: TObject);
begin
  stIDExists.Visible := False;
end;

procedure TfAddFormIDArray.meFormIDArrayExit(Sender: TObject);
var
  R: TRefID;
  i: integer;
begin
  btnAdd.Enabled := (Trim(meFormIDArray.Text) <> '') and (Trim(meFormIDArray.Text) <> '00 00 00');
  R := MaskStringToRefID(meFormIDArray.Text);
  if (R.byte0 = 0) and (R.byte1 = 0) and (R.byte2 = 0) then
  begin
    stIDExists.Caption := 'FormID array can''t be empty';
    stIDExists.Visible := True;
  end
  else
    if Assigned(pESS) then
      with pESS^ do
      for i := 0 to Length(formIDArray) - 1 do
        with formIDArray[i]^ do
          if RefIDCompare(R, ID) = 0 then
          begin
            stIDExists.Caption := 'FormID array already exists';
            stIDExists.Visible := True;
            Break;
          end;
end;

procedure TfAddFormIDArray.meFormIDArrayKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['0'..'9', 'a'..'f', 'A'..'F'] then
    Key :=UpCase(Key)
  else
    Key := #0;
end;

procedure TfAddFormIDArray.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfAddFormIDArray.btnAddClick(Sender: TObject);
var
  i: integer;
begin
  if Assigned(faData) then
    with faData^ do
    begin
      ID := MaskStringToRefID(meFormIDArray.Text);
      if TryStrToInt(edCount.Text, i) then
        Count := i
      else
        count := 1;
    end;
  ModalResult := mrOk;
end;

function TfAddFormIDArray.AddFormIDArray(var Data: TFormIDArray; ESS: PESSFile = nil): Boolean;
begin
  faData := @Data;
  pESS := ESS;
  faData^.Count := 1;
  Result := ShowModal = mrOk;
end;

end.
