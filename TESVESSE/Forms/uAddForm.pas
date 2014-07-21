unit uAddForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, GlassButton, uESSFile;

type
  TfAddForm = class(TForm)
    stFormID: TStaticText;
    tvFlags: TTreeView;
    meFormID: TMaskEdit;
    stType: TStaticText;
    cbType: TComboBox;
    stTypeView: TStaticText;
    edVersion: TEdit;
    stVersion: TStaticText;
    stChangeFlag: TStaticText;
    stDataSize: TStaticText;
    stSize: TStaticText;
    odBinOpen: TOpenDialog;
    stIDExists: TStaticText;
    procedure meFormIDKeyPress(Sender: TObject; var Key: Char);
    procedure edVersionKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tvFlagsCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cbTypeSelect(Sender: TObject);
    procedure cbTypeDropDown(Sender: TObject);
    procedure meFormIDExit(Sender: TObject);
    procedure meFormIDEnter(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    btnImport, btnAdd, btnCancel: TGlassButton;
    cfData: PChangeForm;
    pESS: PESSFile;
  public
    function AddChangeForm(var Data: TChangeForm; ESS: PESSFile = nil): Boolean;
  end;

function MaskStringToRefID(S: string): TRefID;
  
implementation

uses
  uHelper, uMain, CommCtrl;

{$R *.dfm}

function MaskStringToRefID(S: string): TRefID;
var
  B0, B1, B2: integer;
begin
  ZeroMemory(@Result, SizeOf(Result));
  S := Trim(S);
  if Length(S) >= 8 then
    if TryStrToInt('$' + Copy(S, 1, 2), B0) and TryStrToInt('$' + Copy(S, 4, 2), B1) and TryStrToInt('$' + Copy(S, 7, 2), B2) then
      with Result do
      begin
        byte0 := B0;
        byte1 := B1;
        byte2 := B2;
      end;
end;

procedure TfAddForm.edVersionKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9']) then
    Key := #0;
end;

procedure TfAddForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  btnImport := CreateButton('Import', True, clBlack, stDataSize.Left, stDataSize.Top + stDataSize.Height + 4, 25, 75, 5, 2, [akLeft, akTop], Self, Self, fMain.imImages, btnImportClick, nil);
  btnCancel := CreateButton('Cancel', True, clBlack, tvFlags.Left - 75 - 4, tvFlags.Top + tvFlags.Height - 25, 25, 75, 12, 1, [akLeft, akBottom], Self, Self, fMain.imImages, btnCancelClick, nil);
  btnAdd := CreateButton('Add form', False, clBlack, btnCancel.Left - btnCancel.Width - 4, btnCancel.Top, 25, 75, 13, 0, [akLeft, akBottom], Self, Self, fMain.imImages, btnAddClick, nil);
  stSize.Caption := '0 bytes';
  stTypeView.Caption := 'None';
  with cbType do
  try
    Items.BeginUpdate;
    for i := 0 to 48 do
      Items.Add(GetFormString(i));
    Text := GetFormString(0);
  finally
    Items.EndUpdate;
  end;
end;

procedure TfAddForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfAddForm.FormShow(Sender: TObject);
var
  i: integer;
begin
  if Assigned(cfData) then
    with tvFlags, cfData^ do
    begin
      Items.Clear;
      Items.Add(nil, ' 0 - CHANGE_FORM_FLAGS');  //0
      Items.Add(nil, ' 1 - CHANGE_REFR_MOVE / CHANGE_QUEST_FLAGS'); //1
      Items.Add(nil, ' 2 - CHANGE_REFR_HAVOK_MOVE'); //2
      Items.Add(nil, ' 3 - CHANGE_REFR_CELL_CHANGED'); //3
      Items.Add(nil, ' 4 - CHANGE_REFR_SCALE'); //4
      Items.Add(nil, ' 5 - CHANGE_REFR_INVENTORY'); //5
      Items.Add(nil, ' 6 - CHANGE_REFR_EXTRA_OWNERSHIP'); //6
      Items.Add(nil, ' 7 - CHANGE_REFR_BASEOBJECT'); //7
      Items.Add(nil, ' 8'); //8
      Items.Add(nil, ' 9'); //9
      Items.Add(nil, ' 10 - CHANGE_OBJECT_EXTRA_ITEM_DATA'); //10
      Items.Add(nil, ' 11'); //11
      Items.Add(nil, ' 12 - CHANGE_OBJECT_EXTRA_LOCK'); //12
      Items.Add(nil, ' 13'); //13
      Items.Add(nil, ' 14'); //14
      Items.Add(nil, ' 15'); //15
      Items.Add(nil, ' 16'); //16
      Items.Add(nil, ' 17'); //17
      Items.Add(nil, ' 18'); //18
      Items.Add(nil, ' 19'); //19
      Items.Add(nil, ' 20'); //20
      Items.Add(nil, ' 21 - CHANGE_OBJECT_EMPTY'); //21
      Items.Add(nil, ' 22'); //22
      Items.Add(nil, ' 23 - CHANGE_OBJECT_OPEN_STATE'); //23
      Items.Add(nil, ' 24'); //24
      Items.Add(nil, ' 25 - CHANGE_REFR_PROMOTED'); //25
      Items.Add(nil, ' 26 - CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN / CHANGE_QUEST_ALREADY_RUN'); //26
      Items.Add(nil, ' 27 - CHANGE_REFR_LEVELED_INVENTORY / CHANGE_QUEST_INSTANCES'); //27
      Items.Add(nil, ' 28 - CHANGE_REFR_ANIMATION / CHANGE_QUEST_RUNDATA'); //28
      Items.Add(nil, ' 29 - CHANGE_REFR_EXTRA_ENCOUNTER_ZONE / CHANGE_QUEST_OBJECTIVES'); //29
      Items.Add(nil, ' 30'); //30
      Items.Add(nil, ' 31 - CHANGE_REFR_EXTRA_GAME_ONLY / CHANGE_QUEST_STAGES'); //31
      SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) or TVS_CHECKBOXES);
      for i := 0 to 31 do
        if (changeFlags and (1 shl i)) <> 0 then
          SetChecked(tvFlags, i, True);
      meFormID.Text := RefIDToString(formID);
      edVersion.Text := IntToStr(version);
      cbType.Text := GetFormString(_type);
      stTypeView.Caption := GetFormString(_type);
      if Assigned(data) then
        stSize.Caption := IntToStr(Length(data^)) + ' bytes';
    end;
end;

procedure TfAddForm.meFormIDEnter(Sender: TObject);
begin
  stIDExists.Visible := False;
end;

procedure TfAddForm.meFormIDExit(Sender: TObject);
var
  R: TRefID;
  i: integer;
begin
  btnAdd.Enabled := (Trim(meFormID.Text) <> '') and (Trim(meFormID.Text) <> '00 00 00');
  R := MaskStringToRefID(meFormID.Text);
  if (R.byte0 = 0) and (R.byte1 = 0) and (R.byte2 = 0) then
  begin
    stIDExists.Caption := 'FormID can''t be empty';
    stIDExists.Visible := True;
  end
  else
    if Assigned(pESS) then
      with pESS^ do
      for i := 0 to Length(changeForms) - 1 do
        with changeForms[i]^ do
          if RefIDCompare(R, formID) = 0 then
          begin
            stIDExists.Caption := 'FormID already exists';
            stIDExists.Visible := True;
            btnAdd.Enabled := False;
            Break;
          end;
end;

procedure TfAddForm.meFormIDKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['0'..'9', 'a'..'f', 'A'..'F'] then
    Key :=UpCase(Key)
  else
    Key := #0;
end;

procedure TfAddForm.tvFlagsCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Node <> nil then
    with Sender.Canvas.Font do
      if IsChecked(TTreeView(Sender), Node.Index) then
        Style := [fsBold]
      else
        Style := [];
end;

procedure TfAddForm.btnImportClick(Sender: TObject);
var
  f: File;
  Res: Integer;
begin
  if Assigned(cfData) and odBinOpen.Execute then
  begin
    AssignFile(F, odBinOpen.FileName);
    {$IFOPT I+} {$DEFINE IOCHECKS_ON} {$ENDIF} {$I-}
    Reset(F, 1);
    Res := IOResult;
    if Res = 0 then
    try
      try
        SetLength(cfData^.data^, FileSize(F));
        if Length(cfData^.data^) > 0 then
        begin
          BlockRead(f, cfData^.data^[0], Length(cfData^.data^));
          Res := IOResult;
          if Res <> 0 then
            MessageBox(Handle, PChar('Can''t read from selected file:'#13 + odBinOpen.FileName + #13 + SysErrorMessage(Res)), 'Error', MB_OK or MB_ICONERROR);
        end;
      except
        SetLength(cfData^.data^, 0);
        MessageBox(Handle, PChar('File is to large!'), 'Error', MB_OK or MB_ICONERROR);
      end
    finally
      CloseFile(F);
    end
    else
      MessageBox(Handle, PChar('Can''t open selected file:'#13 + odBinOpen.FileName + #13 + SysErrorMessage(Res)), 'Error', MB_OK or MB_ICONERROR);
    {$IFDEF IOCHECKS_ON} {$I+} {$UNDEF IOCHECKS_ON} {$ENDIF}
    stSize.Caption := IntToStr(Length(cfData^.data^)) + ' bytes';
  end;
end;

procedure TfAddForm.cbTypeDropDown(Sender: TObject);
begin
  with Sender as TComboBox do
    if (Items.IndexOf(Text) = -1) and (Tag <= 48) then
      ItemIndex := Tag;
end;

procedure TfAddForm.cbTypeSelect(Sender: TObject);
var
  i: integer;
begin
  with Sender as TComboBox do
  begin
    if Items.IndexOf(Text) <> -1 then
      Tag := Items.IndexOf(Text)
    else
      if TryStrToInt(Text, i) then
        Tag := i;
    stTypeView.Caption := GetFormString(Tag);
  end;
end;

procedure TfAddForm.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfAddForm.btnAddClick(Sender: TObject);
var
  i: integer;
begin
  if Assigned(cfData) then
    with cfData^ do
    begin
      changeFlags := 0;
      for i := 0 to 31 do
        if IsChecked(tvFlags, i) then
          changeFlags := changeFlags or (1 shl i);
      formID := MaskStringToRefID(meFormID.Text);
      _type := cbType.Tag;
      if TryStrToInt(edVersion.Text, i) then
        version := i
      else
        version := 74;
      length2 := Length(data^);
      if not CompressData(data^) then
        length2 := 0;
      length1 := Length(data^);
    end;
  ModalResult := mrOk;
end;

function TfAddForm.AddChangeForm(var Data: TChangeForm; ESS: PESSFile = nil): Boolean;
begin
  cfData := @Data;
  if not Assigned(cfData^.data)  then
    New(cfData^.data);
  pESS := ESS;
  cfData^.version := 74;
  Result := ShowModal = mrOk;
end;

end.
