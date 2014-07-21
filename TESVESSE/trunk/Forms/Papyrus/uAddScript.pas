unit uAddScript;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, GlassButton, uESSFile;

type
  TfAddScript = class(TForm)
    stSName: TStaticText;
    stSType: TStaticText;
    cbSType: TComboBox;
    edSName: TEdit;
    stSExists: TStaticText;
    lvParameters: TListView;
    stParameters: TStaticText;
    stCount: TStaticText;
    stPName: TStaticText;
    edPName: TEdit;
    stPExists: TStaticText;
    stPType: TStaticText;
    cbPType: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnAddScriptClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lvParametersSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure edSNameEnter(Sender: TObject);
    procedure edSNameExit(Sender: TObject);
    procedure edPNameEnter(Sender: TObject);
    procedure edPNameExit(Sender: TObject);
  private
    btnAdd, btnDelete, btnAddScript, btnCancel: TGlassButton;
    pP: PPapyrus;
  public
    function AddScript(Papyrus: PPapyrus = nil): Boolean;
  end;

function SetStrings(S: string; var P: TPapyrus): integer;

implementation

uses
  uHelper, uMain, uPapyrus;

{$R *.dfm}

procedure TfAddScript.FormCreate(Sender: TObject);
begin
  btnCancel := CreateButton('Cancel', True, clBlack, ClientWidth - 75 - 4, ClientHeight - 29, 25, 75, 12, 1, [akRight, akBottom], Self, Self, fMain.imImages, btnCancelClick, nil);
  btnAddScript := CreateButton('Add script', False, clBlack, btnCancel.Left - 94, btnCancel.Top, 25, 90, 13, 0, [akRight, akBottom], Self, Self, fMain.imImages, btnAddScriptClick, nil);

  btnAdd := CreateButton('Add', False, clBlack, 4, btnCancel.Top, 25, 75, 13, 2, [akLeft, akBottom], Self, Self, fMain.imImages, btnAddClick, nil);
  btnDelete := CreateButton('Delete', False, clBlack, btnAdd.Left + btnAdd.Width + 4, btnCancel.Top, 25, 75, 11, 3, [akLeft, akBottom], Self, Self, fMain.imImages, btnDeleteClick, nil);
end;

procedure TfAddScript.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfAddScript.lvParametersSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  btnDelete.Enabled := lvParameters.SelCount > 0;
end;

procedure TfAddScript.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfAddScript.edPNameEnter(Sender: TObject);
begin
  stPExists.Visible := False;
end;

procedure TfAddScript.edPNameExit(Sender: TObject);
var
  i: integer;
begin
  edPName.Text := Trim(edPName.Text);
  btnAdd.Enabled := edPName.Text <> '';
  for i := 0 to lvParameters.Items.Count - 1 do
    with lvParameters.Items[i] do
      if AnsiCompareStr(AnsiUpperCase(edPName.Text), AnsiUpperCase(SubItems[0])) = 0 then
      begin
        stPExists.Visible := True;
        btnAdd.Enabled := False;
        Break;
      end;
end;

procedure TfAddScript.edSNameEnter(Sender: TObject);
begin
  stSExists.Visible := False;
end;

procedure TfAddScript.edSNameExit(Sender: TObject);
var
  i: integer;
begin
  edSName.Text := Trim(edSName.Text);
  btnAddScript.Enabled := edSName.Text <> '';
  if Assigned(pP) then
    with pP^ do
    for i := 0 to Length(yScripts) - 1 do
      with yScripts[i]^ do
        if AnsiCompareStr(AnsiUpperCase(edSName.Text), AnsiUpperCase(yStrings[iName].sName)) = 0 then
        begin
          stSExists.Visible := True;
          btnAddScript.Enabled := False;
          Break;
        end;
end;

function SetStrings(S: string; var P: TPapyrus): integer;
begin
  if S = '' then
    Result := 0
  else
  begin
    Result := GetStringIndex(S, P);
    if Result = -1 then
    begin
      Inc(P.iStringCount);
      Result := Length(P.yStrings) + 1;
      SetLength(P.yStrings, Result);
      New(P.yStrings[Result - 1]);
      P.yStrings[Result - 1]^.sName := S;
    end;
  end;
end;

procedure TfAddScript.btnAddScriptClick(Sender: TObject);
var
  i: integer;
begin
  ModalResult := mrOk;
  if Assigned(pP) then
    with pP^ do
    begin
      iScriptCount := Length(yScripts) + 1;
      SetLength(yScripts, iScriptCount);
      New(yScripts[iScriptCount - 1]);
      with yScripts[iScriptCount - 1]^ do
      begin
        iName := SetStrings(Trim(edSName.Text), pP^);
        iSType := SetStrings(Trim(cbSType.Text), pP^);
        iParameterCount := lvParameters.Items.Count;
        SetLength(yParameters, iParameterCount);
        for i := 0 to iParameterCount - 1 do
        begin
          New(yParameters[i]);
          with yParameters[i]^, lvParameters do
          begin
            iName := SetStrings(Trim(Items[i].SubItems[0]), pP^);
            iSType := SetStrings(Trim(Items[i].SubItems[1]), pP^);
          end;
        end;  
      end;
    end;
end;

function TfAddScript.AddScript(Papyrus: PPapyrus = nil): Boolean;
var
  slT: TStrings;
  i: integer;
begin
  pP := Papyrus;
  if Assigned(pP) then
    with pP^ do
    begin
      slT := TStringList.Create;
      try
        for i := 0 to Length(yStrings) - 1 do
          if Pos('::', yStrings[i].sName) <> 1 then
            slT.AddObject(yStrings[i].sName, Pointer(i));
        cbSType.Items.Assign(slT);
        if cbSType.Items.Count > 0 then
          cbSType.ItemIndex := 0;
        cbPType.Items.Assign(slT);
        if cbPType.Items.Count > 0 then
          cbPType.ItemIndex := 0;
      finally
        slT.Free;
      end;
    end;
  Result := ShowModal = mrOk;
end;

procedure TfAddScript.btnAddClick(Sender: TObject);
begin
  with lvParameters.Items, Add do
  begin
    Caption := IntToStr(Count);
    SubItems.Add(edPName.Text);
    SubItems.Add(cbPType.Text);
//    Data := cbPType.Items.Objects[cbPType.ItemIndex];
    stCount.Caption := IntToStr(Count);
    btnAdd.Enabled := False;
  end;
end;

procedure TfAddScript.btnDeleteClick(Sender: TObject);
var
  i: integer;
begin
  with lvParameters do
  begin
    for i := Items.Count - 1 downto 0 do
      if Items[i].Selected then
        Items[i].Delete;
    for i := 0 to Items.Count - 1 do
      Items[i].Caption := IntToStr(i + 1);
    stCount.Caption := IntToStr(Items.Count);
    btnDelete.Enabled := False;
  end;
end;

end.
