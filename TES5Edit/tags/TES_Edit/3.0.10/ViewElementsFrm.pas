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

unit ViewElementsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, wbInterface, ComCtrls, ExtCtrls, StdCtrls, Buttons;

type
  TfrmViewElements = class(TForm)
    Panel1: TPanel;
    pcView: TPageControl;
    Panel2: TPanel;
    bnAbort: TBitBtn;
    bnOK: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    Edits: array of record
      eElement: IwbElement;
      eMemo: TMemo;
    end;
    procedure MemoChange(Sender: TObject);
  public
    procedure AddElement(const aElement: IwbElement; aFocused, aEditable: Boolean);
    function ShowModal: Integer; override;
    { Public declarations }
  end;

  TwbTabSheet = class(TTabSheet)
  private
//    Element: IwbElement;
  end;

implementation

{$R *.dfm}

{ TfrmViewElements }

procedure TfrmViewElements.AddElement(const aElement: IwbElement;
  aFocused, aEditable: Boolean);
var
  TabSheet : TwbTabSheet;
  Memo     : TMemo;
begin
  if not Assigned(aElement) then
    Exit;

  TabSheet := TwbTabSheet.Create(Self);
  TabSheet.PageControl := pcView;
  TabSheet.Caption := aElement._File.Name;
//  TabSheet.Element := aElement;

  Memo := TMemo.Create(TabSheet);
  Memo.Parent := TabSheet;
  if aEditable then begin
    Memo.Lines.Text := aElement.EditValue;
    bnOK.Visible := True;
    bnAbort.Kind := bkAbort;
    SetLength(Edits, Succ(Length(Edits)));
    with Edits[High(Edits)] do begin
      eElement := aElement;
      eMemo := Memo;
    end;
  end else
    Memo.Lines.Text := aElement.Value;
  Memo.Align := alClient;
  Memo.ReadOnly := not aEditable;
  if not aEditable then
    Memo.ParentColor := True;
//  Memo.BorderStyle := bsNone;
  Memo.ScrollBars := ssBoth;
  Memo.Modified := False;
  Memo.OnChange := MemoChange;

  if aFocused then
    pcView.ActivePage := TabSheet;
end;

procedure TfrmViewElements.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmViewElements.FormCreate(Sender: TObject);
begin
  Font := Screen.IconFont;
end;

procedure TfrmViewElements.MemoChange(Sender: TObject);
//var
//  s: string;
begin
  if Sender is TMemo then
    with TMemo(Sender) do begin
      if Modified then begin
        (Owner as TwbTabSheet).Highlighted := True;
{        s := (Owner as TwbTabSheet).Caption;
        if (Length(s) < 2) or (s[1] <> '<') or (s[Length(s)] <> '>') then begin
          s := '<' + s + '>';
          (Owner as TwbTabSheet).Caption := s;
        end;}
      end;
    end;
end;

function TfrmViewElements.ShowModal: Integer;
var
  i: Integer;
begin
  if pcView.PageCount > 0 then begin
    if pcView.ActivePage = nil then
      pcView.ActivePage := pcView.Pages[0];
    Result := inherited ShowModal;
  end else
    Result := mrAbort;

  if Result = mrOk then
    for i := Low(Edits) to High(Edits) do
      with Edits[i] do
        if eMemo.Modified then
          eElement.EditValue := eMemo.Text;
end;

end.
