{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit frmArchiveInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, VirtualTrees, Vcl.Menus;

type
  TFormArchiveInfo = class(TForm)
    vtText: TVirtualStringTree;
    PopupMenu1: TPopupMenu;
    mniSaveAs: TMenuItem;
    procedure vtTextInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtTextGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
    procedure mniSaveAsClick(Sender: TObject);
    procedure vtTextKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    aBSA: string;
    slText: TStringList;
    aSearch: string;
  end;

var
  FormArchiveInfo: TFormArchiveInfo;

implementation

{$R *.dfm}

uses
  System.StrUtils,
  ClipBrd;

//============================================================================
procedure TFormArchiveInfo.mniSaveAsClick(Sender: TObject);
begin
  with TFileSaveDialog.Create(Self) do try
    Title := 'Save As';
    DefaultFolder := ExtractFilePath(aBSA);
    FileName := ExtractFileName(aBSA) + '.txt';
    if Execute then
      slText.SaveToFile(FileName);
  finally
    Free;
  end;
end;

//============================================================================
procedure TFormArchiveInfo.vtTextGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
begin
  case Column of
    0: CellText := slText[Node.Index];
  end;
end;

//============================================================================
procedure TFormArchiveInfo.vtTextInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  //
end;

//============================================================================
procedure TFormArchiveInfo.vtTextKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = Ord('C')) then begin
    {if vtText.SelectedCount > 100000 then begin
      Clipboard.AsText := 'Selection is too large';
      Exit;
    end;}
    var s: string := '';
    for var Node in vtText.SelectedNodes do begin
      if s <> '' then s := s + #13#10;
      s := s + slText[Node.Index];
    end;
    Clipboard.AsText := s;
  end;
end;

//============================================================================
procedure TFormArchiveInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

//============================================================================
procedure TFormArchiveInfo.FormDeactivate(Sender: TObject);
begin
  Close;
end;

//============================================================================
procedure TFormArchiveInfo.FormDestroy(Sender: TObject);
begin
  if Assigned(slText) then
    FreeAndNil(slText);
end;

//============================================================================
procedure TFormArchiveInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

//============================================================================
procedure TFormArchiveInfo.FormShow(Sender: TObject);
begin
  vtText.RootNodeCount := slText.Count;

  if aSearch <> '' then begin
    var bFound := False;
    var i: Cardinal;
    for i := 0 to Pred(slText.Count) do
      if ContainsText(slText[i], aSearch) then begin
        bFound := True;
        Break;
      end;

    if bFound then
      for var n in vtText.Nodes do
        if n.Index = i then begin
          vtText.Selected[n] := True;
          vtText.ScrollIntoView(n, True);
          Break;
        end;
  end;
end;

end.
