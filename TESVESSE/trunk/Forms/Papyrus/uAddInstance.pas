unit uAddInstance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, GlassButton, uESSFile, ExtCtrls;

type
  TfAddInstance = class(TForm)
    stScript: TStaticText;
    cbScript: TComboBox;
    lvMembers: TListView;
    stMembers: TStaticText;
    stCount: TStaticText;
    stMData: TStaticText;
    edMData: TEdit;
    stMType: TStaticText;
    cbMType: TComboBox;
    stInstanceID: TStaticText;
    meInstanceID: TMaskEdit;
    stIDExists: TStaticText;
    edUnknow1: TEdit;
    stUnknow1: TStaticText;
    stUnknow2: TStaticText;
    edUnknow2: TEdit;
    stRefID: TStaticText;
    meRefID: TMaskEdit;
    stUsed: TStaticText;
    edUsed: TEdit;
    bvInstanceDefinition: TBevel;
    stInstanceDefinition: TStaticText;
    stInstanceData: TStaticText;
    bvInstanceData: TBevel;
    stFlag: TStaticText;
    edFlag: TEdit;
    stReference: TStaticText;
    edReference: TEdit;
    stData1: TStaticText;
    edData1: TEdit;
    stData2: TStaticText;
    edData2: TEdit;
    edMReference: TEdit;
    stMReference: TStaticText;
    bvEnd: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure btnAddInstanceClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lvMembersSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure edKeyPress(Sender: TObject; var Key: Char);
    procedure meInstanceIDKeyPress(Sender: TObject; var Key: Char);
    procedure meInstanceIDEnter(Sender: TObject);
    procedure meInstanceIDExit(Sender: TObject);
  private
    btnAdd, btnDelete, btnAddInstance, btnCancel: TGlassButton;
    pP: PPapyrus;
  public
    function AddInstance(Papyrus: PPapyrus = nil): Boolean;
  end;

implementation

uses
  uHelper, uMain, uPapyrus;

{$R *.dfm}

procedure TfAddInstance.FormCreate(Sender: TObject);
begin
  btnCancel := CreateButton('Cancel', True, clBlack, ClientWidth - 75 - 7, ClientHeight - 33, 25, 75, 12, 1, [akRight, akBottom], Self, Self, fMain.imImages, btnCancelClick, nil);
  btnAddInstance := CreateButton('Add instance', False, clBlack, btnCancel.Left - 94, btnCancel.Top, 25, 90, 13, 0, [akRight, akBottom], Self, Self, fMain.imImages, btnAddInstanceClick, nil);

  btnAdd := CreateButton('Add', True, clBlack, lvMembers.Left, bvEnd.Top - 33, 25, 75, 13, 2, [akLeft, akBottom], Self, Self, fMain.imImages, btnAddClick, nil);
  btnDelete := CreateButton('Delete', False, clBlack, btnAdd.Left + btnAdd.Width + 4, btnAdd.Top, 25, 75, 11, 3, [akLeft, akBottom], Self, Self, fMain.imImages, btnDeleteClick, nil);

  cbMType.Items.AddObject('Null', Pointer(0));
  cbMType.Items.AddObject('RefID', Pointer(1));
  cbMType.Items.AddObject('String', Pointer(2));
  cbMType.Items.AddObject('Integer', Pointer(3));
  cbMType.Items.AddObject('Float', Pointer(4));
  cbMType.Items.AddObject('Boolean', Pointer(5));
  cbMType.Items.AddObject('RefID Array', Pointer(11));
  cbMType.Items.AddObject('String Array', Pointer(12));
  cbMType.Items.AddObject('Integer Array', Pointer(13));
  cbMType.Items.AddObject('Float Array', Pointer(14));
  cbMType.Items.AddObject('Boolean Array', Pointer(15));
  cbMType.ItemIndex := 0;
end;

procedure TfAddInstance.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfAddInstance.lvMembersSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  btnDelete.Enabled := lvMembers.SelCount > 0;
end;

procedure TfAddInstance.meInstanceIDEnter(Sender: TObject);
begin
  stIDExists.Visible := False;
end;

procedure TfAddInstance.meInstanceIDExit(Sender: TObject);
var
  ID, i: integer;
  sID: string;
begin
  btnAddInstance.Enabled := (Trim(meInstanceID.Text) <> '') and (Trim(meInstanceID.Text) <> '00 00 00 00');
  sID := Trim(meInstanceID.Text);
  while Pos(' ', sID) <> 0 do
    Delete(sID, Pos(' ', sID), 1);
  if Assigned(pP) and TryStrToInt(sID, ID) then
    with pP^ do
    begin
      for i := 0 to Length(yInstances) - 1 do
        with yInstances[i]^ do
          if iID = ID then
          begin
            stIDExists.Visible := True;
            btnAddInstance.Enabled := False;
            Break;
          end;
      if not stIDExists.Visible then
        for i := 0 to Length(yReferences) - 1 do
          with yReferences[i]^ do
            if iID = ID then
            begin
              stIDExists.Visible := True;
              btnAddInstance.Enabled := False;
              Break;
            end;
    end;
end;

procedure TfAddInstance.meInstanceIDKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['0'..'9', 'a'..'f', 'A'..'F'] then
    Key :=UpCase(Key)
  else
    Key := #0;
end;

procedure TfAddInstance.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfAddInstance.edKeyPress(Sender: TObject; var Key: Char);
begin
  with Sender as TCustomEdit do
    if not ((Key in ['0'..'9']) or ((Key = '$') and (Pos('$', Text) = 0) and (SelStart = 0))) then
      Key := #0;
end;

procedure TfAddInstance.btnAddInstanceClick(Sender: TObject);
{var
  i: integer;}
begin
  ModalResult := mrOk;
  if Assigned(pP) then
    with pP^ do
    begin
//      iScriptCount := Length(yScripts) + 1;
//      SetLength(yScripts, iScriptCount);
//      New(yScripts[iScriptCount - 1]);
//      with yScripts[iScriptCount - 1]^ do
//      begin
//        iName := SetStrings(Trim(edSName.Text), pP^);
//        iSType := SetStrings(Trim(cbSType.Text), pP^);
//        iParameterCount := lvParameters.Items.Count;
//        SetLength(yParameters, iParameterCount);
//        for i := 0 to iParameterCount - 1 do
//        begin
//          New(yParameters[i]);
//          with yParameters[i]^, lvParameters do
//          begin
//            iName := SetStrings(Trim(Items[i].SubItems[0]), pP^);
//            iSType := SetStrings(Trim(Items[i].SubItems[1]), pP^);
//          end;
//        end;  
//      end;
    end;
end;

function TfAddInstance.AddInstance(Papyrus: PPapyrus = nil): Boolean;
var
  slT: TStrings;
  i: integer;
  sName, sType: string;
begin
  pP := Papyrus;
  if Assigned(pP) then
    with pP^ do
    begin
      slT := TStringList.Create;
      try
        for i := 0 to Length(yScripts) - 1 do
          with yScripts[i]^ do
          begin
            if iName < iStringCount then
              sName := yStrings[iName].sName
            else
              sName := 'Unknow script ' + IntToStr(i) + ' = ' + IntToStr(iName);
            if iSType < iStringCount then
              sType := yStrings[iSType].sName
            else
              sType := 'Unknow type ' + IntToStr(i) + ' = ' + IntToStr(iSType);
            slT.AddObject(sName + ' : ' + sType, Pointer(i));
          end;
        cbScript.Items.Assign(slT);
        if cbScript.Items.Count > 0 then
          cbScript.ItemIndex := 0;
      finally
        slT.Free;
      end;
    end;
  Result := ShowModal = mrOk;
end;

procedure TfAddInstance.btnAddClick(Sender: TObject);
begin
  with lvMembers.Items, Add do
  begin
    Caption := IntToStr(Count);
    SubItems.Add(cbMType.Text);
    SubItems.Add(Trim(edMData.Text));
    SubItems.Add(Trim(edMReference.Text));
    Data := cbMType.Items.Objects[cbMType.ItemIndex];
    stCount.Caption := IntToStr(Count);
  end;
end;

procedure TfAddInstance.btnDeleteClick(Sender: TObject);
var
  i: integer;
begin
  with lvMembers do
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
