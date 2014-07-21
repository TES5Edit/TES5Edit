unit uViewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uESSFile, ExtCtrls, StdCtrls, ComCtrls, uHelper, GlassButton,
  VirtualTrees, MMSystem, Clipbrd;

type
  TfViewer = class(TForm)
    pnMenu: TPanel;
    lbSearch: TLabel;
    edSearch: TEdit;
    stNotFound: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure vtPapyrusInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtPapyrusFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtPapyrusGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
    procedure FormDestroy(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSearchChange(Sender: TObject);
    procedure edSearchKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure vtPapyrusKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    btnClose, btnSearch: TGlassButton;
    vtPapyrus: TVirtualStringTree;
  public
    Papyrus: TPapyrus;
    procedure FillTreePapyrus;
  end;

procedure FillTree(vtPapyrus: TVirtualStringTree; Papyrus: TPapyrus);
procedure InitNode(Sender: TBaseVirtualTree; Node: PVirtualNode; Papyrus: TPapyrus);

function MatchStrings(Source, Pattern: PChar): Boolean;
function GetNextNode(Node, Root: PVirtualNode; From: PVirtualNode = nil): PVirtualNode;

procedure vtSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; Text: String; stNotFound: TStaticText);

implementation

uses
  uMain, Math;

{$R *.dfm}

procedure TfViewer.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TfViewer.edSearchChange(Sender: TObject);
begin
  btnSearch.Enabled := Trim(edSearch.Text) <> '';
  stNotFound.Visible := False;
end;

procedure TfViewer.edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Trim(edSearch.Text) <> '') then
    btnSearch.Click;
end;

procedure TfViewer.edSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #0;
end;

procedure TfViewer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Release;
end;

procedure TfViewer.FormCreate(Sender: TObject);
begin
  btnClose := CreateButton('Close', True, clBlack, pnMenu.ClientWidth - 77, 2, 25, 75, 9, 0, [akRight, akTop], Self, pnMenu, fMain.imImages, btnCloseClick, nil);
  btnSearch := CreateButton('Search', False, clBlack, edSearch.Left + edSearch.Width + 4, 2, 25, 75, 7, 2, [akLeft, akTop], Self, pnMenu, fMain.imImages, btnSearchClick, nil);
  vtPapyrus := TVirtualStringTree.Create(Self);
  with vtPapyrus do
  begin
    Parent := Self;
    Align := alClient;
    TabOrder := 1;
    Color := $F7F7F7;
    Colors.UnfocusedSelectionColor := clHighlight;
    IncrementalSearch := isVisibleOnly;
    NodeDataSize := SizeOf(TPapyrusRec);
    OnGetText := vtPapyrusGetText;
    OnFreeNode := vtPapyrusFreeNode;
    OnInitNode := vtPapyrusInitNode;
    OnKeyUp := vtPapyrusKeyUp;
  end;
end;

procedure TfViewer.FormDestroy(Sender: TObject);
begin
  ClearPapyrus(Papyrus);
end;

procedure TfViewer.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_F3) and (Trim(edSearch.Text) <> '') then
    btnSearch.Click;
end;

procedure TfViewer.btnCloseClick(Sender: TObject);
begin
  Close;
end;

{$IF Defined(USEREGION)}{$REGION 'Tree view interface Papyrus'}{$IFEND}
procedure FillTree(vtPapyrus: TVirtualStringTree; Papyrus: TPapyrus);
var
  pRoot, pLvl1, pLvl2, pLvl3, pLvl4: PVirtualNode;
begin
  with vtPapyrus, Papyrus do
  begin
    Clear;
    BeginUpdate;
    try
      RootNodeCount := 1;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      begin
        ChildCount[pRoot] := 12;
        Expanded[pRoot] := True;
        InvalidateToBottom(pRoot);
        pLvl1 := pRoot.FirstChild;
        if Assigned(pLvl1) then
        repeat
          Expanded[pLvl1] := False;
          case pLvl1.Index of
            0: ChildCount[pLvl1] := Length(yStrings);
            1: ChildCount[pLvl1] := Length(yScripts);
            2: ChildCount[pLvl1] := Length(yInstances);
            3: ChildCount[pLvl1] := Length(yReferences);
            4: ChildCount[pLvl1] := Length(yArrays);
            5: ChildCount[pLvl1] := 0;
            6: ChildCount[pLvl1] := Length(yActives);
            7: ChildCount[pLvl1] := Length(yInstanceData);
            8: ChildCount[pLvl1] := Length(yReferenceData);
            9: ChildCount[pLvl1] := Length(yArrayData);
            10: ChildCount[pLvl1] := Length(yActiveData);
            11: ChildCount[pLvl1] := (Length(yOther) - 1) div 16 + 1;
          end;
          InvalidateToBottom(pLvl1);
          pLvl2 := pLvl1.FirstChild;
          if Assigned(pLvl2) then
          repeat
            Expanded[pLvl2] := False;
            case pLvl1.Index of
              1: ChildCount[pLvl2] := 3;
              2: ChildCount[pLvl2] := 6;
              3, 6, 9: ChildCount[pLvl2] := 2;
              4: if yArrays[pLvl2.Index]^.iType in [1, 11] then
                   ChildCount[pLvl2] := 4
                 else
                   ChildCount[pLvl2] := 3;
              7, 8: ChildCount[pLvl2] := 5;
              10: ChildCount[pLvl2] := 2;
            end;
            InvalidateToBottom(pLvl2);
            pLvl3 := pLvl2.FirstChild;
            if Assigned(pLvl3) then
            repeat
              Expanded[pLvl3] := False;
              if (pLvl1.Index = 1) and (pLvl3.Index = 2) then
                ChildCount[pLvl3] := Length(yScripts[pLvl2.Index]^.yParameters);
              if (pLvl1.Index = 7) and (pLvl3.Index = 4) then
                ChildCount[pLvl3] := Length(yInstanceData[pLvl2.Index]^.yMembers);
              if (pLvl1.Index = 8) and (pLvl3.Index = 4) then
                ChildCount[pLvl3] := Length(yReferenceData[pLvl2.Index]^.yMembers);
              if (pLvl1.Index = 9) and (pLvl3.Index = 1) then
                ChildCount[pLvl3] := Length(yArrayData[pLvl2.Index]^.yMembers);
              if (pLvl1.Index = 10) and (pLvl3.Index = 1) then
                ChildCount[pLvl3] := (Length(yActiveData[pLvl2.Index]^.yData) - 1) div 16 + 1;
              InvalidateToBottom(pLvl3);
              pLvl4 := pLvl3.FirstChild;
              if Assigned(pLvl4) then
              repeat
                Expanded[pLvl4] := False;
                if (pLvl1.Index = 7) and (pLvl3.Index = 4) then
                  if yInstanceData[pLvl2.Index]^.yMembers[pLvl4.Index]^.iType in [1, 11] then
                    ChildCount[pLvl4] := 3
                  else
                    ChildCount[pLvl4] := 2;
                if (pLvl1.Index = 8) and (pLvl3.Index = 4) then
                  if yReferenceData[pLvl2.Index]^.yMembers[pLvl4.Index]^.iType in [1, 11] then
                    ChildCount[pLvl4] := 3
                  else
                    ChildCount[pLvl4] := 2;
                if (pLvl1.Index = 9) and (pLvl3.Index = 1) then
                  if yArrayData[pLvl2.Index]^.yMembers[pLvl4.Index]^.iType in [1, 11] then
                    ChildCount[pLvl4] := 3
                  else
                    ChildCount[pLvl4] := 2;
                InvalidateToBottom(pLvl4);
                pLvl4 := pLvl4.NextSibling;
              until not Assigned(pLvl4);
              pLvl3 := pLvl3.NextSibling;
            until not Assigned(pLvl3);
            pLvl2 := pLvl2.NextSibling;
          until not Assigned(pLvl2);
          pLvl1 := pLvl1.NextSibling;
        until not Assigned(pLvl1);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TfViewer.FillTreepapyrus;
begin
  FillTree(vtPapyrus, Papyrus);
end;

procedure TfViewer.vtPapyrusGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
var
  PapyrusRec: PPapyrusRec;
begin
  PapyrusRec := Sender.GetNodeData(Node);
  Text := PapyrusRec^._Caption;
end;

procedure TfViewer.vtPapyrusFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  PapyrusRec: PPapyrusRec;
begin
  PapyrusRec := Sender.GetNodeData(Node);
  Finalize(PapyrusRec^);
end;

procedure InitNode(Sender: TBaseVirtualTree; Node: PVirtualNode; Papyrus: TPapyrus);
var
  PapyrusRec: PPapyrusRec;
  s: string;
  i: integer;
begin
  with Sender do
  begin
    PapyrusRec := GetNodeData(Node);
    with PapyrusRec^, Papyrus do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: _Caption := 'Papyrus';
        1: case Node^.Index of
             0: _Caption := 'Strings (' + IntToStr(Length(yStrings)) + ')';
             1: _Caption := 'Scripts (' + IntToStr(Length(yScripts)) + ')';
             2: _Caption := 'Script Instances (' + IntToStr(Length(yInstances)) + ')';
             3: _Caption := 'References (' + IntToStr(Length(yReferences)) + ')';
             4: _Caption := 'Arrays (' + IntToStr(Length(yArrays)) + ')';
             5: _Caption := 'Papyrus runtime (ID for next active script): [0x' + IntToHex(iPapyrusRuntime, 8) + '] ' + IntToStr(iPapyrusRuntime);
             6: _Caption := 'Active Scripts (' + IntToStr(Length(yActives)) + ')';
             7: _Caption := 'Script Data (' + IntToStr(Length(yInstanceData)) + ')';
             8: _Caption := 'Reference Data (' + IntToStr(Length(yReferenceData)) + ')';
             9: _Caption := 'Array Data (' + IntToStr(Length(yArrayData)) + ')';
             10: _Caption := 'Active Script Data (' + IntToStr(Length(yActiveData)) + ')';
             11: _Caption := 'Other data: ' + IntToStr(Length(yOther)) + ' bytes';
           end;
        2: case Node^.Parent^.Index of
             0: if Node^.Index < Cardinal(Length(yStrings)) then
                  _Caption := IntToStr(Node^.Index + 1) + ' ' + yStrings[Node^.Index]^.sName;
             1: if Node^.Index < Cardinal(Length(yScripts)) then
                  with yScripts[Node^.Index]^ do
                  begin
                    s := IntToStr(Node^.Index) + ' ' + GetName(iSType, Papyrus) + ' ' + GetName(iName, Papyrus) + '(';
                    for i := 0 to Length(yParameters) - 1 do
                    begin
                      s := s + GetName(yParameters[i]^.iSType, Papyrus) + ' ' + GetName(yParameters[i]^.iName, Papyrus);
                      if i < (Length(yParameters) - 1) then
                        s := s + ', ';
                    end;
                    _Caption :=  s + ')';
                  end;
             2: if Node^.Index < Cardinal(Length(yInstances)) then
                  _Caption := IntToStr(Node^.Index);
             3: if Node^.Index < Cardinal(Length(yReferences)) then
                  _Caption := IntToStr(Node^.Index);
             4: if Node^.Index < Cardinal(Length(yArrays)) then
                  _Caption := IntToStr(Node^.Index);
             6: if Node^.Index < Cardinal(Length(yActives)) then
                  _Caption := IntToStr(Node^.Index);
             7: if Node^.Index < Cardinal(Length(yInstanceData)) then
                  _Caption := IntToStr(Node^.Index) + ' ' + GetName(yInstances[Node^.Index]^.iScript, Papyrus);
             8: if Node^.Index < Cardinal(Length(yReferenceData)) then
                  _Caption := IntToStr(Node^.Index) + ' ' + GetName(yReferences[Node^.Index]^.iSType, Papyrus);
             9: if Node^.Index < Cardinal(Length(yArrayData)) then
                  _Caption := IntToStr(Node^.Index);
             10: if Node^.Index < Cardinal(Length(yActiveData)) then
                   _Caption := IntToStr(Node^.Index);
             11: if Node^.Index < Cardinal((Length(yOther) - 1) div 16 + 1) then
                   _Caption := IntToHex(Node^.Index * 16, 8) + ' [' + MidBytesToHex(yOther, Node^.Index * 16) + ']';
           end;
        3: case Node^.Parent^.Parent^.Index of
             1: with yScripts[Node^.Parent^.Index]^ do case Node^.Index of
                  0: _Caption := 'Script: ' + GetName(iName, Papyrus);
                  1: _Caption := 'Type: ' + GetName(iSType, Papyrus);
                  2: _Caption := 'Parameters (' + IntToStr(Length(yParameters)) + ')';
                end;
             2: with yInstances[Node^.Parent^.Index]^ do case Node^.Index of
                  0: _Caption := 'ID: [0x' + IntToHex(iID, 8) + '] ' + IntToStr(iID);
                  1: _Caption := 'Script: ' + GetName(iScript, Papyrus);
                  2: _Caption := 'Unknow 1: [0x' + IntToHex(iUnknow1, 4) + '] ' + IntToStr(iUnknow1);
                  3: _Caption := 'Unknow 2: [0x' + IntToHex(iUnknow2, 4) + '] ' + IntToStr(iUnknow2);
                  4: _Caption := 'RefID: [0x' + RefIDToHex(rRef) + '] ' + RefIDToString(rRef);
                  5: _Caption := 'Used: ' + IntToStr(iUsed);
                end;
             3: with yReferences[Node^.Parent^.Index]^ do case Node^.Index of
                  0: _Caption := 'ID: [0x' + IntToHex(iID, 8) + '] ' + IntToStr(iID);
                  1: _Caption := 'Type: ' + GetName(iSType, Papyrus);
                end;
             4: with yArrays[Node^.Parent^.Index]^ do case Node^.Index of
                  0: _Caption := 'ID: [0x' + IntToHex(iID, 8) + '] ' + IntToStr(iID);
                  1: _Caption := 'Type: ' + GetDataType(iType);
                  2: if iType in [1, 11] then
                       _Caption := 'Reference: ' + GetName(iReference, Papyrus)
                     else
                       _Caption := 'Member count: ' + IntToStr(iMemberCount);
                  3: _Caption := 'Member count: ' + IntToStr(iMemberCount);
                end;
             6: with yActives[Node^.Parent^.Index]^ do case Node^.Index of
                  0: _Caption := 'ID: [0x' + IntToHex(iID, 8) + '] ' + IntToStr(iID);
                  1: _Caption := 'Used: ' + IntToStr(iUsed);
                end;
             7: with yInstanceData[Node^.Parent^.Index]^ do case Node^.Index of
                  0: _Caption := 'ID: [0x' + IntToHex(iID, 8) + '] ' + IntToStr(iID);
                  1: _Caption := 'Flag: ' + IntToStr(iFlag);
                  2:
                  begin
                    if (iReference > 0) and (iReference <= Length(yStrings)) then
                      _Caption := 'State reference: ' + GetName(iReference, Papyrus)
                    else
                      _Caption := 'State reference: 0x[' + IntToHex(iReference, 4) + '] ';
                    if iFlag = $F then
                      _Caption := _Caption + ', Data1: 0x[' + IntToHex(iData1, 8) + '] ' + IntToStr(iData1) + ', Data2: 0x[' + IntToHex(iData2, 8) + '] ' + IntToStr(iData2)
                    else
                      _Caption := _Caption + ', Data: 0x[' + IntToHex(iData1, 8) + '] ' + IntToStr(iData1);
                  end;
                  3: _Caption := 'Members count: ' + IntToStr(iMemberCount);
                  4: _Caption := 'Members: (' + IntToStr(Length(yMembers)) + ')';
                end;
             8: with yReferenceData[Node^.Parent^.Index]^ do case Node^.Index of
                  0: _Caption := 'ID: [0x' + IntToHex(iID, 8) + '] ' + IntToStr(iID);
                  1: _Caption := 'Flag: ' + IntToStr(iFlag);
                  2:
                  begin
                    if (iReference > 0) and (iReference <= Length(yStrings)) then
                      _Caption := 'State reference: ' + GetName(iReference, Papyrus)
                    else
                      _Caption := 'State reference: 0x[' + IntToHex(iReference, 4) + '] ';
                    if iFlag = $F then
                      _Caption := _Caption + ', Data1: 0x[' + IntToHex(iData1, 8) + '] ' + IntToStr(iData1) + ', Data2: 0x[' + IntToHex(iData2, 8) + '] ' + IntToStr(iData2)
                    else
                      _Caption := _Caption + ', Data: 0x[' + IntToHex(iData1, 8) + '] ' + IntToStr(iData1);
                  end;
                  3: _Caption := 'Members count: ' + IntToStr(iMemberCount);
                  4: _Caption := 'Members: (' + IntToStr(Length(yMembers)) + ')';
                end;
             9: with yArrayData[Node^.Parent^.Index]^ do case Node^.Index of
                  0: _Caption := 'ID: [0x' + IntToHex(iID, 8) + '] ' + IntToStr(iID);
                  1: _Caption := 'Members: (' + IntToStr(Length(yMembers)) + ')';
                end;
             10: with yActiveData[Node^.Parent^.Index]^ do case Node^.Index of
                  0: _Caption := 'ID: [0x' + IntToHex(iID, 8) + '] ' + IntToStr(iID);
                  1: _Caption := 'Data: ' + IntToStr(Length(yData)) + ' bytes';
                end;
           end;
        4: case Node^.Parent^.Parent^.Parent^.Index of
             1: with yScripts[Node^.Parent^.Parent^.Index]^.yParameters[Node^.Index]^ do
                 _Caption := IntToStr(Node^.Index) + ' ' + GetName(iSType, Papyrus) + ' ' + GetName(iName, Papyrus);
             7: with yInstanceData[Node^.Parent^.Parent^.Index]^.yMembers[Node^.Index]^ do
                 _Caption := IntToStr(Node^.Index);
             8: with yReferenceData[Node^.Parent^.Parent^.Index]^.yMembers[Node^.Index]^ do
                 _Caption := IntToStr(Node^.Index);
             9: with yArrayData[Node^.Parent^.Parent^.Index]^.yMembers[Node^.Index]^ do
                 _Caption := IntToStr(Node^.Index);
             10: if Node^.Index < Cardinal((Length(yActiveData[Node^.Parent^.Parent^.Index]^.yData) - 1) div 16 + 1) then
                   _Caption := IntToHex(Node^.Index * 16, 8) + ' [' + MidBytesToHex(yActiveData[Node^.Parent^.Parent^.Index]^.yData, Node^.Index * 16) + ']';
           end;
        5: case Node^.Parent^.Parent^.Parent^.Parent^.Index of
             7: with yInstanceData[Node^.Parent^.Parent^.Parent^.Index]^.yMembers[Node^.Parent^.Index]^ do
               case Node^.Index of
                 0: _Caption := 'Type: ' + GetDataType(iType);
                 1: _Caption := 'Data: [0x' + IntToHex(iData, 8) + '] ' + IntToStr(iData);
                 2: _Caption := 'Reference: ' + GetName(iReference, Papyrus);
               end;
             8: with yReferenceData[Node^.Parent^.Parent^.Parent^.Index]^.yMembers[Node^.Parent^.Index]^ do
               case Node^.Index of
                 0: _Caption := 'Type: ' + GetDataType(iType);
                 1: _Caption := 'Data: [0x' + IntToHex(iData, 8) + '] ' + IntToStr(iData);
                 2: _Caption := 'Reference: ' + GetName(iReference, Papyrus);
               end;
             9: with yArrayData[Node^.Parent^.Parent^.Parent^.Index]^.yMembers[Node^.Parent^.Index]^ do
               case Node^.Index of
                 0: _Caption := 'Type: ' + GetDataType(iType);
                 1: _Caption := 'Data: [0x' + IntToHex(iData, 8) + '] ' + IntToStr(iData);
                 2: _Caption := 'Reference: ' + GetName(iReference, Papyrus);
               end;
           end;
      end;
    end;
  end;
end;

procedure TfViewer.vtPapyrusInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  InitNode(Sender, Node, Papyrus);
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

function MatchStrings(Source, Pattern: PChar): Boolean;
begin
  if StrComp(Pattern, '*') = 0 then
    Result := True
  else
    if (Source^ = Chr(0)) and (Pattern^ <> Chr(0)) then
      Result := False
    else
      if Source^ = Chr(0) then
        Result := True
      else
        case Pattern^ of
          '*': if MatchStrings(Source, @Pattern[1]) then
                 Result := True
               else
                 Result := MatchStrings(@Source[1], Pattern);
          '?': Result := MatchStrings(@Source[1], @Pattern[1]);
          else
            if Source^ = Pattern^ then
              Result := MatchStrings(@Source[1], @Pattern[1])
            else
              Result := False;
        end;
end;

function GetNextNode(Node, Root: PVirtualNode; From: PVirtualNode = nil): PVirtualNode;
begin
  if (Node^.ChildCount > 0) and not Assigned(From) then
    Result := Node^.FirstChild
  else
    if Node^.NextSibling <> nil then
      Result := Node^.NextSibling
    else
      if Node^.Parent <> Root then
        Result := GetNextNode(Node^.Parent, Root, Node)
      else
        Result := Root;
end;

procedure vtSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; Text: string; stNotFound: TStaticText);
var
  Start: PVirtualNode;
  PapyrusRec: PPapyrusRec;
begin
  Start := Node;
  Text := AnsiUpperCase('*' + Text + '*');
  stNotFound.Visible := False;
  stNotFound.Tag := 0;
  repeat
    Node := GetNextNode(Node, Sender.RootNode);
    if not (vsInitialized in Node^.States) then
      Sender.ReinitNode(Node, False);
    PapyrusRec := Sender.GetNodeData(Node);
    if Assigned(PapyrusRec) and MatchStrings(PChar(AnsiUpperCase(String(PapyrusRec^._Caption))), PChar(Text)) then
    begin
      Start := Node;
      while Start <> Sender.RootNode do
      begin
        Start := Start.Parent;
        Sender.Expanded[Start] := True;
      end;
      Sender.Selected[Node] := True;
      Sender.FocusedNode := Node;
      Sender.VisiblePath[Node] := True;
      stNotFound.Tag := 1;
      Break;
    end;
  until Node = Start;
  if stNotFound.Tag = 0 then
  begin
    stNotFound.Visible := True;
    PlaySound('APPGPFAULT', 0, SND_ASYNC);
  end;
end;

procedure TfViewer.btnSearchClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  if Trim(edSearch.Text) <> '' then
  begin
    if vtPapyrus.GetFirstSelected <> nil then
      Node := vtPapyrus.GetFirstSelected
    else
      Node := vtPapyrus.RootNode;
    try
      Screen.Cursor := crHourGlass;
      vtSearch(vtPapyrus, Node, edSearch.Text, stNotFound);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

const
  VK_C = $43;

procedure TfViewer.vtPapyrusKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  PapyrusRec: PPapyrusRec;
begin
  if Sender is TVirtualStringTree then
    with Sender as TVirtualStringTree do
      case Key of
        VK_C:
          if (GetFirstSelected <> nil) and (ssCtrl in Shift) then
          begin
            PapyrusRec := GetNodeData(GetFirstSelected);
            if Assigned(PapyrusRec) then
              Clipboard.AsText := PapyrusRec^._Caption;
          end;
      end;
end;

end.
