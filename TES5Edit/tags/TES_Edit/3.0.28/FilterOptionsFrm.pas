{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

unit FilterOptionsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, Menus;

type
  TfrmFilterOptions = class(TForm)
    clbConflictAll: TCheckListBox;
    clbConflictThis: TCheckListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbInherit: TCheckBox;
    cbConflictAll: TCheckBox;
    cbConflictThis: TCheckBox;
    cbByInjectionStatus: TCheckBox;
    cbInjected: TCheckBox;
    cbByNotReachableStatus: TCheckBox;
    cbNotReachable: TCheckBox;
    cbByReferencesInjectedStatus: TCheckBox;
    cbReferencesInjected: TCheckBox;
    cbByEditorID: TCheckBox;
    cbByName: TCheckBox;
    edEditorID: TEdit;
    edName: TEdit;
    clbRecordSignatures: TCheckListBox;
    cbRecordSignature: TCheckBox;
    pmuSelection: TPopupMenu;
    mniSelectAll: TMenuItem;
    mniSelectNone: TMenuItem;
    mniInvertSelection: TMenuItem;
    cbByPersistent: TCheckBox;
    cbPersistent: TCheckBox;
    cbUnnecessaryPersistent: TCheckBox;
    cbMasterIsTemporary: TCheckBox;
    cbByVWD: TCheckBox;
    cbVWD: TCheckBox;
    cbIsMaster: TCheckBox;
    cbPersistentPosChanged: TCheckBox;
    cbBaseRecordSignature: TCheckBox;
    clbBaseRecordSignatures: TCheckListBox;
    cbByBaseEditorID: TCheckBox;
    edBaseEditorID: TEdit;
    cbByBaseName: TCheckBox;
    edBaseName: TEdit;
    cbByHasVWDMesh: TCheckBox;
    cbHasVWDMesh: TCheckBox;
    cbFlattenBlocks: TCheckBox;
    cbFlattenCellChilds: TCheckBox;
    cbAssignPersWrldChild: TCheckBox;
    cbScaledActors: TCheckBox;
    cbDeleted: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure mniSelectionClick(Sender: TObject);
  private
    function GetRecordSignatures: string;
    procedure SetRecordSignatures(const Value: string);
    function GetBaseRecordSignatures: string;
    procedure SetBaseRecordSignatures(const Value: string);
    { Private declarations }
  public
    property RecordSignatures: string
      read GetRecordSignatures
      write SetRecordSignatures;
    property BaseRecordSignatures: string
      read GetBaseRecordSignatures
      write SetBaseRecordSignatures;
  end;

implementation

{$R *.dfm}

uses
  wbInterface;

procedure TfrmFilterOptions.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  Font := Screen.IconFont;
  if Font.Size > 8 then
    Font.Size := 8;

  clbConflictAll.Items.Add('Single Record');
  clbConflictAll.Items.Add('Multiple but no conflict');
  clbConflictAll.Items.Add('Benign Conflict');
  clbConflictAll.Items.Add('Override without conflict');
  clbConflictAll.Items.Add('Conflict');
  clbConflictAll.Items.Add('Critical Conflict');

  clbConflictThis.Items.Add('Not Defined');
  clbConflictThis.Items.Add('Identical to Master');
  clbConflictThis.Items.Add('Single Record');
  clbConflictThis.Items.Add('Hidden by Mod Group');
  clbConflictThis.Items.Add('Master');
  clbConflictThis.Items.Add('Benign conflict');
  clbConflictThis.Items.Add('Override without conflict');
  clbConflictThis.Items.Add('Identical to Master but conflict winner');
  clbConflictThis.Items.Add('Conflict winner');
  clbConflictThis.Items.Add('Conflict loser');

  for i := 0 to Pred(wbRecordDefMap.Count) do
    with IwbRecordDef(Pointer(wbRecordDefMap.Objects[i])) do begin
      clbRecordSignatures.Items.Add(DefaultSignature + ' - ' + GetName);
      clbBaseRecordSignatures.Items.Add(DefaultSignature + ' - ' + GetName);
    end;
end;

function TfrmFilterOptions.GetBaseRecordSignatures: string;
var
  i : Integer;
begin
  Result := '';
  for i := 0 to Pred(clbBaseRecordSignatures.Items.Count) do
    if clbBaseRecordSignatures.Checked[i] then begin
      if Result <> '' then
        Result := Result + ',';
      Result := Result + Copy(clbBaseRecordSignatures.Items[i], 1, 4);
    end;
end;

function TfrmFilterOptions.GetRecordSignatures: string;
var
  i : Integer;
begin
  Result := '';
  for i := 0 to Pred(clbRecordSignatures.Items.Count) do
    if clbRecordSignatures.Checked[i] then begin
      if Result <> '' then
        Result := Result + ',';
      Result := Result + Copy(clbRecordSignatures.Items[i], 1, 4);
    end;
end;

procedure TfrmFilterOptions.mniSelectionClick(Sender: TObject);
var
  clb : TCheckListBox;
  i   : Integer;
begin
  clb := pmuSelection.PopupComponent as TCheckListBox;
  clb.Items.BeginUpdate;
  try
    for i := 0 to Pred(clb.Items.Count) do
      if Sender = mniSelectAll then
        clb.Checked[i] := True
      else if Sender = mniSelectNone then
        clb.Checked[i] := False
      else if Sender = mniInvertSelection then
        clb.Checked[i] := not clb.Checked[i];
  finally
    clb.Items.EndUpdate;
  end;
end;

procedure TfrmFilterOptions.SetBaseRecordSignatures(const Value: string);
var
  i, Dummy: Integer;
begin
  with TStringList.Create do try
    CommaText := Value;
    Sorted := True;
    for i := 0 to Pred(clbBaseRecordSignatures.Items.Count) do
      clbBaseRecordSignatures.Checked[i] := Find(Copy(clbBaseRecordSignatures.Items[i], 1, 4), Dummy);
  finally
    Free;
  end;
end;

procedure TfrmFilterOptions.SetRecordSignatures(const Value: string);
var
  i, Dummy: Integer;
begin
  with TStringList.Create do try
    CommaText := Value;
    Sorted := True;
    for i := 0 to Pred(clbRecordSignatures.Items.Count) do
      clbRecordSignatures.Checked[i] := Find(Copy(clbRecordSignatures.Items[i], 1, 4), Dummy);
  finally
    Free;
  end;
end;

end.
