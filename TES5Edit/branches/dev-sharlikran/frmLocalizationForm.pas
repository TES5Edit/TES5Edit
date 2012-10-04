unit frmLocalizationForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, VirtualTrees, VirtualEditTree;

type
  TfrmLocalization = class(TForm)
    Panel1: TPanel;
    vetStrings: TVirtualEditTree;
    Panel2: TPanel;
    Splitter1: TSplitter;
    memoText: TMemo;
    procedure vetStringsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vetStringsInitChildren(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var ChildCount: Cardinal);
    procedure vetStringsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure FormCreate(Sender: TObject);
    procedure vetStringsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EditValue(aFileName: String; ID: Integer);
  end;

var
  frmLocalization: TfrmLocalization;

implementation

{$R *.dfm}

uses
  wbLocalization;

type
  TTreeData = record
    FileIndex: Integer;
    ID: Integer;
  end;
  PTreeData = ^TTreeData;

procedure TfrmLocalization.FormCreate(Sender: TObject);
begin
  vetStrings.NodeDataSize := SizeOf(TTreeData);
  vetStrings.RootNodeCount := wbLocalizationHandler.Count;
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
    memoText.Lines.Text := wbLocalizationHandler[Data.FileIndex][Data.ID];
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
        CellText := wbLocalizationHandler[Data.FileIndex].Name;
    end;
    1: begin
      if Data.ID > 0 then
        CellText := wbLocalizationHandler[Data.FileIndex][Data.ID]
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
    ChildCount := wbLocalizationHandler[Data.FileIndex].Count
  else
    ChildCount := 0;
end;

procedure TfrmLocalization.vetStringsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PTreeData;
  FileIndex: Integer;
begin
  Data := Sender.GetNodeData(Node);
  if ParentNode = nil then begin
    Data.ID := 0;
    Data.FileIndex := Node.Index;
    if wbLocalizationHandler[Data.FileIndex].Count > 0 then
      Include(InitialStates, ivsHasChildren);
  end else begin
    FileIndex := PTreeData(Sender.GetNodeData(Node.Parent)).FileIndex;
    Data.FileIndex := FileIndex;
    Data.ID := wbLocalizationHandler[Data.FileIndex].IndexToID(Node.Index);
  end;
end;

procedure TfrmLocalization.EditValue(aFileName: String; ID: Integer);
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
     if s = Copy(wbLocalizationHandler[Data.FileIndex].Name , 0, length(s)) then begin
       vetStrings.FocusedNode := Node;
       vetStrings.ScrollIntoView(Node, True);
       Exit;
     end;
    Node := vetStrings.GetNextSibling(Node);
  end;
end;


end.
