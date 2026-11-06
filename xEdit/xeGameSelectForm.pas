{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit xeGameSelectForm;

{$I xeDefines.inc}

interface

uses
  Winapi.Windows,

  System.Classes,

  Vcl.CheckLst,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Menus,
  Vcl.StdCtrls,
  Vcl.Styles.Utils.SystemMenu;

type
  TListBox = class(Vcl.StdCtrls.TListBox)
  protected
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
      override; final;
  end;

  TfrmGameSelect = class(TForm)
    ListBox1: TListBox;
    edSearch: TEdit;
    Label1: TLabel;
    btnOK: TButton;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
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
  System.StrUtils,
  System.SysUtils,

  Vcl.Graphics,

  wbInterface,

  xeMainForm;

procedure TListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  s: string;
begin
  s := Trim(TfrmGameSelect(Self.Parent).edSearch.Text);
  if s <> '' then
    if not (odSelected in State) and ContainsText(Items[Index], s) then
      Canvas.Brush.Color := clGradientInactiveCaption;
  inherited;
end;

procedure TfrmGameSelect.ListBox1DblClick(Sender: TObject);
begin
  btnOK.Click;
end;

procedure TfrmGameSelect.edSearchChange(Sender: TObject);
var
  s, p: string;
  i: integer;
begin
  ListBox1.Invalidate;
  s := Trim(edSearch.Text);
  if s <> '' then
    for i := 0 to ListBox1.Items.Count - 1 do begin
      p := ListBox1.Items[i];
      if ContainsText(p, s) then begin
        ListBox1.ItemIndex := i;
        Exit;
      end;
    end;
  ListBox1.ItemIndex := -1;
end;

procedure TfrmGameSelect.FormCreate(Sender: TObject);
begin
  xeApplyFontAndScale(Self);

  if wbThemesSupported then
    with TVclStylesSystemMenu.Create(Self) do begin
      ShowNativeStyle := True;
      MenuCaption := 'Theme';
    end;

  ListBox1.MultiSelect := False;
end;

procedure TfrmGameSelect.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if edSearch.Focused then
    Exit;

  if Key = VK_RETURN then
    btnOK.Click
  else if Key = VK_ESCAPE then begin
    if not NoEscape then
      ModalResult := mrCancel;
  end;
end;

end.
