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

unit FileSelectFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, Menus,
  Vcl.Styles.Utils.SystemMenu;

type
  TCheckListBox = class(CheckLst.TCheckListbox)
  protected
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
      override;
  end;

  TfrmFileSelect = class(TForm)
    CheckListBox1: TCheckListBox;
    PopupMenu1: TPopupMenu;
    SelectAll1: TMenuItem;
    SelectNone1: TMenuItem;
    InvertSelection1: TMenuItem;
    edSearch: TEdit;
    Label1: TLabel;
    cbBackup: TCheckBox;
    btnOK: TButton;
    procedure SelectAll1Click(Sender: TObject);
    procedure SelectNone1Click(Sender: TObject);
    procedure InvertSelection1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckListBox1DblClick(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    NoEscape: Boolean;
  end;

implementation

{$R *.dfm}

uses
  wbInterface,
  frmViewMain,
  StrUtils;

procedure TCheckListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  s: string;
begin
  s := Trim(TfrmFileSelect(Self.Parent).edSearch.Text);
  if s <> '' then
    if not (odSelected in State) and ContainsText(Items[Index], s) then
      Canvas.Brush.Color := clGradientInactiveCaption;
  inherited;
end;

procedure TfrmFileSelect.CheckListBox1DblClick(Sender: TObject);
begin
  SelectNone1.Click;
  if (CheckListBox1.ItemIndex >= 0) and (CheckListBox1.ItemIndex < CheckListBox1.Count) then begin
    CheckListBox1.Checked[CheckListBox1.ItemIndex] := True;
    btnOK.Click;
  end;
end;

procedure TfrmFileSelect.edSearchChange(Sender: TObject);
var
  s, p: string;
  i: integer;
begin
  CheckListBox1.Invalidate;
  s := Trim(edSearch.Text);
  if s <> '' then
    for i := 0 to CheckListBox1.Items.Count - 1 do begin
      p := CheckListBox1.Items[i];
      if ContainsText(p, s) then begin
        CheckListBox1.ItemIndex := i;
        Exit;
      end;
    end;
  CheckListBox1.ItemIndex := -1;
end;

procedure TfrmFileSelect.FormCreate(Sender: TObject);
begin
  wbApplyFontAndScale(Self);

  if wbThemesSupported then
    with TVclStylesSystemMenu.Create(Self) do begin
      ShowNativeStyle := True;
      MenuCaption := 'Theme';
    end;

  CheckListBox1.MultiSelect := True;
end;

procedure TfrmFileSelect.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if edSearch.Focused then
    Exit;

  if Key = VK_RETURN then
    btnOK.Click
  else if Key = VK_ESCAPE then begin
    if not NoEscape then
      ModalResult := mrCancel;
  end else if Key = VK_SUBTRACT then
    SelectNone1.Click
  else if Key = VK_ADD then
    SelectAll1.Click
  else if Key = VK_MULTIPLY then
    InvertSelection1.Click;
end;

procedure TfrmFileSelect.InvertSelection1Click(Sender: TObject);
var
  i: Integer;
begin
  CheckListBox1.Items.BeginUpdate;
  try
    for i := 0 to Pred(CheckListBox1.Items.Count) do
      if CheckListBox1.ItemEnabled[i] and ((CheckListBox1.SelCount < 2) or CheckListBox1.Selected[i]) then
        CheckListBox1.Checked[i] := not CheckListBox1.Checked[i];
  finally
    CheckListBox1.Items.EndUpdate;
  end;
end;

procedure TfrmFileSelect.SelectAll1Click(Sender: TObject);
var
  i: Integer;
begin
  CheckListBox1.Items.BeginUpdate;
  try
    for i := 0 to Pred(CheckListBox1.Items.Count) do
      if CheckListBox1.ItemEnabled[i] and ((CheckListBox1.SelCount < 2) or CheckListBox1.Selected[i]) then
        CheckListBox1.Checked[i] := True;
  finally
    CheckListBox1.Items.EndUpdate;
  end;
end;

procedure TfrmFileSelect.SelectNone1Click(Sender: TObject);
var
  i: Integer;
begin
  CheckListBox1.Items.BeginUpdate;
  try
    for i := 0 to Pred(CheckListBox1.Items.Count) do
      if CheckListBox1.ItemEnabled[i] and ((CheckListBox1.SelCount < 2) or CheckListBox1.Selected[i]) then
        CheckListBox1.Checked[i] := False;
  finally
    CheckListBox1.Items.EndUpdate;
  end;
end;

end.
