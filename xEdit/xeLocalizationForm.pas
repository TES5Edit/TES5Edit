{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit frmLocalizationForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, VirtualTrees, VirtualEditTree, ExtDlgs, Menus;

type
  TfrmLocalization = class(TForm)
    Panel1: TPanel;
    vetStrings: TVirtualEditTree;
    Panel2: TPanel;
    Splitter1: TSplitter;
    memoText: TMemo;
    pnlControls: TPanel;
    btnSave: TButton;
    pmuStrings: TPopupMenu;
    mniFileExport: TMenuItem;
    mniFileImport: TMenuItem;
    dlgExport: TSaveTextFileDialog;
    procedure vetStringsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vetStringsInitChildren(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var ChildCount: Cardinal);
    procedure vetStringsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure FormCreate(Sender: TObject);
    procedure vetStringsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure btnSaveClick(Sender: TObject);
    procedure vetStringsPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure memoTextChange(Sender: TObject);
    procedure pmuStringsPopup(Sender: TObject);
    procedure mniFileExportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EditValue(aFileName: string; ID: integer);
  end;

var
  frmLocalization: TfrmLocalization;

implementation

{$R *.dfm}

uses
  frmViewMain,
  wbLocalization;

type
  TTreeData = record
    lFile: TwbLocalizationFile;
    ID: Cardinal;
  end;
  PTreeData = ^TTreeData;

procedure TfrmLocalization.FormCreate(Sender: TObject);
begin
  wbApplyFontAndScale(Self);

  vetStrings.NodeDataSize := SizeOf(TTreeData);
  vetStrings.RootNodeCount := wbLocalizationHandler.Count;
  pnlControls.Visible := false;
end;

procedure TfrmLocalization.memoTextChange(Sender: TObject);
begin
  if memoText.Modified and (vetStrings.FocusedNode.Parent <> vetStrings.RootNode) then
    pnlControls.Visible := true;
end;

procedure TfrmLocalization.mniFileExportClick(Sender: TObject);
var
  Data: PTreeData;
begin
  Data := vetStrings.GetNodeData(vetStrings.FocusedNode);
  dlgExport.FileName := Data.lFile.Name + '.txt';

  if not dlgExport.Execute then
    Exit;

  Data.lFile.ExportToFile(dlgExport.FileName);
end;

procedure TfrmLocalization.pmuStringsPopup(Sender: TObject);
//var
//  Data: PTreeData;
begin
  {Data :=} vetStrings.GetNodeData(vetStrings.FocusedNode);

  mniFileExport.Visible :=  vetStrings.FocusedNode.Parent = vetStrings.RootNode;
end;

procedure TfrmLocalization.vetStringsChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PTreeData;
begin
  Data := Sender.GetNodeData(Node);
  if not Assigned(Data) then Exit;
  if Data.ID = 0 then
    memoText.Lines.Clear
  else
    memoText.Lines.Text := Data.lFile[Data.ID];
  pnlControls.Visible := false;
end;

procedure TfrmLocalization.vetStringsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Data: PTreeData;
begin
  Data := Sender.GetNodeData(Node);
  case Column of
    0: begin
      if Data.ID > 0 then
        CellText := IntToHex(Data.ID, 8)
      else
        CellText := Data.lFile.Name;
    end;
    1: begin
      if Data.ID > 0 then
        CellText := Data.lFile[Data.ID]
      else
        CellText := '';
    end;
  end;
end;

procedure TfrmLocalization.vetStringsInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
var
  Data: PTreeData;
begin
  Data := Sender.GetNodeData(Node);
  if Data.ID = 0 then
    ChildCount := Data.lFile.Count
  else
    ChildCount := 0;
end;

procedure TfrmLocalization.vetStringsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PTreeData;
begin
  Data := Sender.GetNodeData(Node);
  if ParentNode = nil then begin
    Data.ID := 0;
    Data.lFile := wbLocalizationHandler[Node.Index];
    if Data.lFile.Count > 0 then
      Include(InitialStates, ivsHasChildren);
  end else begin
    Data.lFile := PTreeData(Sender.GetNodeData(Node.Parent)).lFile;
    Data.ID := Data.lFile.IndexToID(Node.Index);
  end;
end;

procedure TfrmLocalization.vetStringsPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PTreeData;
begin
  if Node.Parent <> Sender.RootNode then
    Exit;

  TargetCanvas.Font.Color := clWindowText;
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
    if Data.lFile.Modified then
      TargetCanvas.Font.Style := [fsBold];
end;

procedure TfrmLocalization.btnSaveClick(Sender: TObject);
var
  Data: PTreeData;
begin
  Data := vetStrings.GetNodeData(vetStrings.FocusedNode);
  Data.lFile[Data.ID] := memoText.Lines.Text;
  memoText.Modified := false;
  pnlControls.Visible := false;
  vetStrings.Invalidate;
end;

procedure TfrmLocalization.EditValue(aFileName: string; ID: integer);
var
  Data: PTreeData;
  Node: PVirtualNode;
  s: string;
begin
  s := ChangeFileExt(aFileName, '') + '_';
  Node := vetStrings.GetFirst;
  while Assigned(Node) do begin
    Data := vetStrings.GetNodeData(Node);
    if Data.ID = ID then
      if s = Copy(Data.lFile.Name , 0, length(s)) then begin
        vetStrings.FocusedNode := Node;
        vetStrings.Selected[vetStrings.FocusedNode] := True;
        vetStrings.ScrollIntoView(Node, True);
        Exit;
      end;
    Node := vetStrings.GetNext(Node);
  end;
end;


end.
