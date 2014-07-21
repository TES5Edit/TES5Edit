unit uPapyrusDataView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uESSFile, ExtCtrls, VirtualTrees, GlassButton, ComCtrls,
  Clipbrd;

type
  PDataRec = ^TDataRec;
  TDataRec = record
    _Caption: WideString;
  end;

type
  TfPapyrusDataView = class(TForm)
    pnMenu: TPanel;
    lbSearch: TLabel;
    edSearch: TEdit;
    stNotFound: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSearchChange(Sender: TObject);
    procedure edSearchKeyPress(Sender: TObject; var Key: Char);
    procedure vtKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure vtGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
    procedure vtFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
  private
    btnClose, btnSearch: TGlassButton;
    vtView: TVirtualStringTree;
    Papyrus: PPapyrus;
    ActiveData: PActiveData;
  end;

procedure ShowActiveData(aCaption: string; var aActiveData: TActiveData; var aPapyrus: TPapyrus);
procedure ShowOtherData(aCaption: string; var aPapyrus: TPapyrus);

implementation

{$R *.dfm}

uses
  uHelper, uMain, uViewer;

procedure ShowTreeActiveData(vtTMP: TVirtualStringTree; var aActiveData: TActiveData; var aPapyrus: TPapyrus); forward;
procedure ShowTreeOtherData(vtTMP: TVirtualStringTree; var aPapyrus: TPapyrus); forward;

procedure TfPapyrusDataView.FormCreate(Sender: TObject);
begin
  btnClose := CreateButton('Close', True, clBlack, pnMenu.ClientWidth - 77, 2, 25, 75, 9, 0, [akRight, akTop], Self, pnMenu, fMain.imImages, btnCloseClick, nil);
  btnSearch := CreateButton('Search', False, clBlack, edSearch.Left + edSearch.Width + 4, 2, 25, 75, 7, 2, [akLeft, akTop], Self, pnMenu, fMain.imImages, btnSearchClick, nil);
  vtView := TVirtualStringTree.Create(Self);
  with vtView do
  begin
    Parent := Self;
    Align := alClient;
    TabOrder := 1;
    Color := $F7F7F7;
    Colors.UnfocusedSelectionColor := clHighlight;
    IncrementalSearch := isVisibleOnly;
    NodeDataSize := SizeOf(TDataRec);
    OnGetText := vtGetText;
    OnFreeNode := vtFreeNode;
    OnKeyUp := vtKeyUp;
  end;
end;

procedure TfPapyrusDataView.edSearchChange(Sender: TObject);
begin
  btnSearch.Enabled := Trim(edSearch.Text) <> '';
  stNotFound.Visible := False;
end;

procedure TfPapyrusDataView.edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Trim(edSearch.Text) <> '') then
    btnSearch.Click;
end;

procedure TfPapyrusDataView.edSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #0;
end;

procedure TfPapyrusDataView.btnSearchClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  if Trim(edSearch.Text) <> '' then
  begin
    if vtView.GetFirstSelected <> nil then
      Node := vtView.GetFirstSelected
    else
      Node := vtView.RootNode;
    try
      Screen.Cursor := crHourGlass;
      vtSearch(vtView, Node, edSearch.Text, stNotFound);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

const
  VK_C = $43;

procedure TfPapyrusDataView.vtKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Rec: PDataRec;
begin
  if Sender is TVirtualStringTree then
    with Sender as TVirtualStringTree do
      case Key of
        VK_C:
          if (GetFirstSelected <> nil) and (ssCtrl in Shift) then
          begin
            Rec := GetNodeData(GetFirstSelected);
            if Assigned(Rec) then
              Clipboard.AsText := Rec^._Caption;
          end;
      end;
end;

procedure TfPapyrusDataView.vtGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
var
  Rec: PDataRec;
begin
  Rec := Sender.GetNodeData(Node);
  Text := Rec^._Caption;
end;

procedure TfPapyrusDataView.vtFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Rec: PDataRec;
begin
  Rec := Sender.GetNodeData(Node);
  Finalize(Rec^);
end;

const
  VK_A = $41;

procedure TfPapyrusDataView.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F3: if Trim(edSearch.Text) <> '' then
             btnSearch.Click;
  end;
end;

procedure TfPapyrusDataView.btnCloseClick(Sender: TObject);
begin
  Close;
end;

function GetStringReference(aStr: Integer; var aPapyrus: TPapyrus): string;
begin
  if aStr < Length(aPapyrus.yStrings) then
    Result := '0x' + IntToHex(aStr, 4) + ' [' + IntToStr(aStr) + '] "' + aPapyrus.yStrings[aStr]^.sName + '"'
  else
    Result := '0x' + IntToHex(aStr, 4) + ' [' + IntToStr(aStr) + ']';
end;

function GetVariable(var aVariable: TMember; var aPapyrus: TPapyrus): string;
{$IF Defined(USEREGION)}{$REGION 'GetVariable'}{$IFEND}
begin
  with aVariable, aPapyrus do
    case iType of
      0: Result := 'Null 0x' + IntToHex(iData, 8) + ' [' + IntToStr(iData) + ']';
      1: Result := 'RefID Type ' + GetStringReference(iReference, aPapyrus) + ' ID 0x' + IntToHex(iData, 8) + ' [' + IntToStr(iData) + ']';
      2: Result := 'String ' + GetStringReference(iReference, aPapyrus);
      3: Result := 'Integer 0x' + IntToHex(iData, 8) + ' [' + IntToStr(iData) + ']';
      4: Result := 'Float ' + FloatToStr(iData);
      5: Result := 'Boolean 0x' + IntToHex(iData, 8) + ' [' + IntToStr(iData) + ']';
      11: Result := 'RefID Array Type ' + GetStringReference(iReference, aPapyrus) + ' Array ID 0x' + IntToHex(iData, 8) + ' [' + IntToStr(iData) + ']';
      12: Result := 'String Array ID: 0x' + IntToHex(iData, 8) + ' [' + IntToStr(iData) + ']';
      13: Result := 'Integer Array ID: 0x' + IntToHex(iData, 8) + ' [' + IntToStr(iData) + ']';
      14: Result := 'Float Array ID: 0x' + IntToHex(iData, 8) + ' [' + IntToStr(iData) + ']';
      15: Result := 'Boolean Array ID: 0x' + IntToHex(iData, 8) + ' [' + IntToStr(iData) + ']';
      else
        Result := 'Unknown Type 0x' + IntToHex(iReference, 4) + ' [' + IntToStr(iReference) + '] Data 0x' + IntToHex(iData, 8) + ' [' + IntToStr(iData) + ']';
    end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

function GetUnknown4(aType: Byte; var aName: string; var aVariable: TMember; var aRef: TRefID; var aStr: uint16; var aiUnk: uint32; var abUnk: uint8; var aPapyrus: TPapyrus): string;
{$IF Defined(USEREGION)}{$REGION 'GetUnknown4'}{$IFEND}
begin
  Result := 'Type' + IntToStr(aType);
  if aType = 2 then
    Result := Result + ' variable: ' + GetVariable(aVariable, aPapyrus)
  else
  begin
    Result := Result + ' "' + aName + '"';
    aName := AnsiUpperCase(aName);
    if (aName = AnsiUpperCase('QuestStage')) or (aName = AnsiUpperCase('ScenePhaseResults')) or (aName = AnsiUpperCase('SceneActionResults')) or (aName = AnsiUpperCase('SceneResults')) then
      Result := Result + ' RefID ' + RefIDToString(aRef);
    if aName = AnsiUpperCase('QuestStage') then
    begin
      Result := Result + ' String ' + GetStringReference(aStr, aPapyrus);
      Result := Result + ' unknown 0x' + IntToHex(abUnk, 2) + ' [' + IntToStr(0) + ']';
    end;
    if (aName = AnsiUpperCase('ScenePhaseResults')) or (aName = AnsiUpperCase('SceneActionResults')) then
      Result := Result + ' unknown 0x' + IntToHex(aiUnk, 8) + ' [' + IntToStr(aiUnk) + ']';
    if aType = 3 then
      Result := Result + ' variable: ' + GetVariable(aVariable, aPapyrus)
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

function GetOpcode(Opcode: uint8): string;
{$IF Defined(USEREGION)}{$REGION 'GetOpcode'}{$IFEND}
begin
  Result := '0x' + IntToHex(Opcode, 2);
  case Opcode of
    $00: Result := Result + ' NOOP';
    $01: Result := Result + ' Iadd SII';
    $02: Result := Result + ' Fadd SFF';
    $03: Result := Result + ' Isubtract SII';
    $04: Result := Result + ' Fsubtract SFF';
    $05: Result := Result + ' IMultiply SII';
    $06: Result := Result + ' FMultiply SFF';
    $07: Result := Result + ' IDivide SII';
    $08: Result := Result + ' FDivide SFF';
    $09: Result := Result + ' Imod SII';
    $0A: Result := Result + ' Not SA';
    $0B: Result := Result + ' Inegate SI';
    $0C: Result := Result + ' Fnegate SF';
    $0D: Result := Result + ' Assign SA';
    $0E: Result := Result + ' Cast SA';
    $0F: Result := Result + ' CompareEQ SAA';
    $10: Result := Result + ' CompareLT SAA';
    $11: Result := Result + ' CompareLTE SAA';
    $12: Result := Result + ' CompareGT SAA';
    $13: Result := Result + ' CompareLTE SAA';
    $14: Result := Result + ' Jump L';
    $15: Result := Result + ' JumpT AL';
    $16: Result := Result + ' JumpF AL';
    $17: Result := Result + ' CallMethod NSS*';
    $18: Result := Result + ' CallParent NS*';
    $19: Result := Result + ' CallStatic NNS*';
    $1A: Result := Result + ' Return A';
    $1B: Result := Result + ' StrCat SQQ';
    $1C: Result := Result + ' PropGet NSS';
    $1D: Result := Result + ' PropSet NSA';
    $1E: Result := Result + ' ArrayCreate Su';
    $1F: Result := Result + ' ArrayLength SS';
    $20: Result := Result + ' ArrayGetElement SSI';
    $21: Result := Result + ' ArraySetElement SIA';
    $22: Result := Result + ' ArrayFindelement SSAI';
    $23: Result := Result + ' ArrayRFindElement SSAI';
    $24: Result := Result + ' INVALID';
    else
      Result := Result + ' Unknown Opcode';
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure ShowActiveData(aCaption: string; var aActiveData: TActiveData; var aPapyrus: TPapyrus);
{$IF Defined(USEREGION)}{$REGION 'ShowActiveData'}{$IFEND}
begin
  with TfPapyrusDataView.Create(Application) do
  begin
    Caption := aCaption;
    Tag := 1;
    Papyrus := @aPapyrus;
    ActiveData := @aActiveData;
    ShowTreeActiveData(vtView, ActiveData^, Papyrus^);
    Show;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure ShowOtherData(aCaption: string; var aPapyrus: TPapyrus);
{$IF Defined(USEREGION)}{$REGION 'ShowOtherData'}{$IFEND}
begin
  with TfPapyrusDataView.Create(Application) do
  begin
    Caption := aCaption;
    Tag := 2;
    Papyrus := @aPapyrus;
    ShowTreeOtherData(vtView, Papyrus^);
    Show;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

function AddData(Tree: TVirtualStringTree; Node: PVirtualNode; Caption: string): PVirtualNode;
var
  Rec: PDataRec;
begin
  Result := Tree.AddChild(Node);
  Rec := Tree.GetNodeData(Result);
  Rec^._Caption := Caption;
end;

procedure ShowTreeActiveData(vtTMP: TVirtualStringTree; var aActiveData: TActiveData; var aPapyrus: TPapyrus);
{$IF Defined(USEREGION)}{$REGION 'ShowTreeActiveData'}{$IFEND}
var
  Root, L1, L2, L3, L4, L5: PVirtualNode;
  i, j, k: integer;
begin
  vtTMP.Clear;
  with vtTMP, aActiveData do
  begin
    BeginUpdate;
    try
      Root := AddData(vtTMP, nil, 'Active Script Data');
      AddData(vtTmp, Root, 'ID: 0x' + IntToHex(iID, 8));
      AddData(vtTmp, Root, 'Version: ' + IntToStr(iMajorVersion) + '.' + IntToStr(iMinorVersion));
      AddData(vtTmp, Root, 'Unknown variable: ' + GetVariable(tUnknown, aPapyrus));
      AddData(vtTmp, Root, 'Flag: 0x' + IntToHex(bFlag, 8) + ' bin ' + IntToBin(bFlag, 8));
      AddData(vtTmp, Root, 'UnknownByte: 0x' + IntToHex(bUnknownByte, 2) + ' [' + IntToStr(bUnknownByte) + ']');
      if (bFlag and $01) <> 0 then
        AddData(vtTmp, Root, 'Unknown2: 0x' + IntToHex(iUnknown2, 8) + ' [' + IntToStr(iUnknown2) + ']');
      AddData(vtTmp, Root, 'Unknown3: 0x' + IntToHex(iUnknown3, 2) + ' [' + IntToStr(iUnknown3) + ']');
      if iUnknown3 in [1..3] then
        with tUnknown4 do
          AddData(vtTmp, Root, 'Unknown4: ' + GetUnknown4(iUnknown3, sName, tVariable, tRef, iStr, iUnk, bUnk, aPapyrus));
      L1 := AddData(vtTmp, Root, 'Stack Frames (' + IntToStr(iStackframecount) + ')');
      for i := 0 to iStackframecount- 1 do
        with yStackframe[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Variable Count: ' + IntToStr(iVariablecount));
          AddData(vtTmp, L2, 'Flag: 0x' + IntToHex(bFlag, 8) + ' bin ' + IntToBin(bFlag, 8));
          AddData(vtTmp, L2, 'Function Type: ' + IntToStr(bFunctionType));
          AddData(vtTmp, L2, 'Script Name: ' + GetStringReference(iScriptName, aPapyrus));
          AddData(vtTmp, L2, 'Script Base Name: ' + GetStringReference(iScriptBaseName, aPapyrus));
          AddData(vtTmp, L2, 'Event: ' + GetStringReference(iEvent, aPapyrus));
          if ((bFlag and $01) = 0) and (bFunctionType = 0) then
            AddData(vtTmp, L2, 'Status: ' + GetStringReference(iStatus, aPapyrus));
          AddData(vtTmp, L2, 'OpcodeVersion: ' + IntToStr(iOpcodeVersion) + '.' + IntToStr(iOpcodeMinorVersion));
          AddData(vtTmp, L2, 'Return Type: ' + GetStringReference(iReturnType, aPapyrus));
          AddData(vtTmp, L2, 'Function Doc String: ' + GetStringReference(iFunctionDocString, aPapyrus));
          AddData(vtTmp, L2, 'Function Flags: 0x' + IntToHex(iFunctionFlags, 8) + ' [' + IntToStr(iFunctionFlags) + '] bin ' + IntToBin(iFunctionFlags, 32));
          L3 := AddData(vtTmp, L2, 'Function Parameters (' + IntToStr(iFunctionParameterCount) + ')');
          for j := 0 to iFunctionParameterCount - 1 do
            with uFunctionParam[j] do
            begin
              L4 := AddData(vtTmp, L3, IntToStr(j));
              AddData(vtTmp, L4, 'Name: ' + GetStringReference(iName, aPapyrus));
              AddData(vtTmp, L4, 'Type: ' + GetStringReference(iType, aPapyrus));
            end;
          L3 := AddData(vtTmp, L2, 'Function Locals (' + IntToStr(iFunctionLocalsCount) + ')');
          for j := 0 to iFunctionLocalsCount - 1 do
            with yFunctionLocal[j] do
            begin
              L4 := AddData(vtTmp, L3, IntToStr(j));
              AddData(vtTmp, L4, 'Name: ' + GetStringReference(iName, aPapyrus));
              AddData(vtTmp, L4, 'Type: ' + GetStringReference(iType, aPapyrus));
            end;
          L3 := AddData(vtTmp, L2, 'Opcodes: (' + IntToStr(iOpcodeCount) + ')');
          for j := 0 to iOpcodeCount - 1 do
            with yOpcodeData[j] do
            begin
              L4 := AddData(vtTmp, L3, IntToStr(j));
              L5 := AddData(vtTmp, L4, 'Opcode: ' + GetOpcode(iOpcode));
              for k := 0 to Length(yParameter) - 1 do
                with yParameter[k] do
                  case iType of
                    0: AddData(vtTmp, L5, IntToStr(k) + ' null');
                    1, 2: AddData(vtTmp, L5, IntToStr(k) + ' Reference: ' + GetStringReference(iData, aPapyrus));
                    3: AddData(vtTmp, L5, IntToStr(k) + ' int32: 0x' + IntToHex(iData, 8) + ' [' + IntToStr(iData) + ']');
                    4: AddData(vtTmp, L5, IntToStr(k) + ' float: ' + FloatToStr(fData));
                    5: AddData(vtTmp, L5, IntToStr(k) + ' uint8: 0x' + IntToHex(iData, 2) + ' [' + IntToStr(iData) + '] bin ' + IntToBin(bFlag, 8));
                    else
                      AddData(vtTmp, L5, IntToStr(k) + ' unknown type: ' + IntToStr(iType));
                  end;
            end;
            FullExpand(L3);
            Expanded[L3] := False;
            AddData(vtTmp, L2, 'Unknown3: 0x' + IntToHex(iUnknown3, 8) + ' [' + IntToStr(iUnknown3) + ']');
            L3 := AddData(vtTmp, L2, 'Variables (' + IntToStr(iVariablecount + 1) + ')');
            for j := 0 to iVariablecount do
              AddData(vtTmp, L3, IntToStr(j) + ': ' + GetVariable(tUnknown[j], aPapyrus));
        end;
      if iStackframecount > 0 then
        AddData(vtTmp, Root, 'Unknown5: 0x' + IntToHex(unknown5, 2) + ' [' + IntToStr(unknown5) + ']');
      Expanded[Root] := True;
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure ShowTreeOtherData(vtTMP: TVirtualStringTree; var aPapyrus: TPapyrus);
{$IF Defined(USEREGION)}{$REGION 'ShowTreeOtherData'}{$IFEND}
var
  Root, L1, L2, L3, L4, L5, L6, L7, L8: PVirtualNode;
  i, j, k, l: integer;
  procedure ShowMessageData(var MessageData: TFunctionMessageData; var aPapyrus: TPapyrus; var Root, L1, L2: PVirtualNode);
  var
    i: integer;
  begin
    with MessageData do
    begin
      L1 := AddData(vtTmp, Root, 'FunctionMessageData');
      AddData(vtTmp, L1, 'unknown: 0x' + IntToHex(unknown, 2) + ' [' + IntToStr(unknown) + ']');
      AddData(vtTmp, L1, 'Script Name: ' + GetStringReference(iScriptName, aPapyrus));
      AddData(vtTmp, L1, 'Event: ' + GetStringReference(iEvent, aPapyrus));
      AddData(vtTmp, L1, 'Unknow: ' + GetVariable(tUnknow, aPapyrus));
      L2 := AddData(vtTmp, L1, 'Variables (' + IntToStr(iVariableCount) + ')');
      for i := 0 to iVariableCount - 1 do
        AddData(vtTmp, L2, 'unknown var' + IntToStr(i) + ': ' + GetVariable(yUnknown[i], aPapyrus));
    end
  end;
begin
  vtTMP.Clear;
  with vtTMP, aPapyrus do
  begin
    BeginUpdate;
    try
      Root := AddData(vtTMP, nil, 'Other Papyrus Data');
      L1 := AddData(vtTmp, Root, 'Function Messages (' + IntToStr(iFunctionMessageCount) + ')');
      for i := 0 to iFunctionMessageCount - 1 do
        with yFunctionMessages[i]^ do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'unknown: 0x' + IntToHex(unknown, 8) + ' bin ' + IntToBin(unknown, 8));
          if unknown <= 2 then
          begin
            AddData(vtTmp, L2, 'ID: 0x' + IntToHex(iID, 8) + ' [' + IntToStr(iID) + ']');
            AddData(vtTmp, L2, 'Flag: 0x' + IntToHex(iFlag, 8) + ' bin ' + IntToBin(iFlag, 8));
            if iFlag > 0 then
              ShowMessageData(tMessageData, aPapyrus, L2, L3, L4);
          end;
        end;
      L1 := AddData(vtTmp, Root, 'Suspended Stacks 1 (' + IntToStr(iSuspendedStackCount1) + ')');
      for i := 0 to iSuspendedStackCount1 - 1 do
        with ySuspendedStacks1[i]^ do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'ID: 0x' + IntToHex(iID, 8) + ' [' + IntToStr(iID) + ']');
          AddData(vtTmp, L2, 'Flag: 0x' + IntToHex(iFlag, 8) + ' bin ' + IntToBin(iFlag, 8));
          if iFlag > 0 then
            ShowMessageData(tMessageData, aPapyrus, L2, L3, L4);
        end;
      L1 := AddData(vtTmp, Root, 'Suspended Stacks 2 (' + IntToStr(iSuspendedStackCount2) + ')');
      for i := 0 to iSuspendedStackCount2 - 1 do
        with ySuspendedStacks2[i]^ do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'ID: 0x' + IntToHex(iID, 8) + ' [' + IntToStr(iID) + ']');
          AddData(vtTmp, L2, 'Flag: 0x' + IntToHex(iFlag, 8) + ' bin ' + IntToBin(iFlag, 8));
          if iFlag > 0 then
            ShowMessageData(tMessageData, aPapyrus, L2, L3, L4);
        end;
      AddData(vtTmp, Root, 'Unknown1: 0x' + IntToHex(iUnknown1, 8) + ' [' + IntToStr(iUnknown1) + ']');
      AddData(vtTmp, Root, 'Unknown2: 0x' + IntToHex(iUnknown2, 8) + ' [' + IntToStr(iUnknown2) + ']');
      L1 := AddData(vtTmp, Root, 'Unknowns (' + IntToStr(iUnknownCount) + ')');
      for i := 0 to iUnknownCount - 1 do
        AddData(vtTmp, L1, 'Unknown [' + IntToStr(i) + ']: 0x' + IntToHex(tUnknown[i], 8) + ' [' + IntToStr(tUnknown[i]) + ']');
      L1 := AddData(vtTmp, Root, 'Queued Unbind (' + IntToStr(iQueuedUnbindCount) + ')');
      for i := 0 to iQueuedUnbindCount - 1 do
        with yQueuedUnbinds[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Unk 1: 0x' + IntToHex(iUnk1, 8) + ' [' + IntToStr(iUnk1) + ']');
          AddData(vtTmp, L2, 'Unk 2: 0x' + IntToHex(iUnk2, 8) + ' [' + IntToStr(iUnk2) + ']');
        end;
      AddData(vtTmp, Root, 'Save File Version: ' + IntToStr(saveFileVersion) + ' bin ' + IntToBin(saveFileVersion, 8));
      Expanded[Root] := True;

      Root := AddData(vtTMP, nil, 'Another Recognized Data');
      L1 := AddData(vtTmp, Root, 'Array 1 (' + IntToStr(iArrayCount1) + ')');
      for i := 0 to iArrayCount1 - 1 do
        with yArray1[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Unk 1: 0x' + IntToHex(iUnk1, 8) + ' [' + IntToStr(iUnk1) + ']');
          AddData(vtTmp, L2, 'Unk 2: 0x' + IntToHex(iUnk2, 8) + ' [' + IntToStr(iUnk2) + ']');
        end;
      AddData(vtTmp, Root, 'Array 1a (' + IntToStr(iArrayCount1a) + ')');
      L1 := AddData(vtTmp, Root, 'Array 2 (' + IntToStr(iArrayCount2) + ')');
      for i := 0 to iArrayCount2 - 1 do
        with yArray2[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Unk 1: 0x' + IntToHex(iUnk1, 8) + ' [' + IntToStr(iUnk1) + ']');
          AddData(vtTmp, L2, 'Unk 2: 0x' + IntToHex(iUnk2, 8) + ' [' + IntToStr(iUnk2) + ']');
        end;
      L1 := AddData(vtTmp, Root, 'Array 3 (' + IntToStr(iArrayCount3) + ')');
      for i := 0 to iArrayCount3 - 1 do
        with yArray3[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Type: ' + IntToStr(iType));
          AddData(vtTmp, L2, 'Str1: ' + GetStringReference(iStr1, aPapyrus));
          AddData(vtTmp, L2, 'Unk1: 0x' + IntToHex(iUnk1, 4) + ' [' + IntToStr(iUnk1) + ']');
          AddData(vtTmp, L2, 'Str2: ' + GetStringReference(iStr2, aPapyrus));
          AddData(vtTmp, L2, 'Unk2: 0x' + IntToHex(iUnk2, 8) + ' [' + IntToStr(iUnk2) + ']');
          AddData(vtTmp, L2, 'Flag: 0x' + IntToHex(iFlag, 4) + ' [' + IntToStr(iFlag) + ']' + ' bin ' + IntToBin(iFlag, 16));
          AddData(vtTmp, L2, 'Ref: ' + RefIDToString(tRef));
        end;
      L1 := AddData(vtTmp, Root, 'Array 4 (' + IntToStr(iArrayCount4) + ')');
      for i := 0 to iArrayCount4 - 1 do
        with yArray4[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Str1: ' + GetStringReference(iStr1, aPapyrus));
          AddData(vtTmp, L2, 'Unk1: 0x' + IntToHex(iUnk1, 4) + ' [' + IntToStr(iUnk1) + ']');
          AddData(vtTmp, L2, 'Unk2: 0x' + IntToHex(iUnk2, 2) + ' [' + IntToStr(iUnk2) + ']');
          AddData(vtTmp, L2, 'Str2: ' + GetStringReference(iStr2, aPapyrus));
          AddData(vtTmp, L2, 'Unk3: 0x' + IntToHex(iUnk3, 8) + ' [' + IntToStr(iUnk3) + ']');
          AddData(vtTmp, L2, 'Flag: 0x' + IntToHex(iFlag, 4) + ' [' + IntToStr(iFlag) + ']' + ' bin ' + IntToBin(iFlag, 16));
          AddData(vtTmp, L2, 'Ref: ' + RefIDToString(tRef));
        end;
      L1 := AddData(vtTmp, Root, 'Script List (' + IntToStr(iScriptListCount) + ')');
      for i := 0 to iScriptListCount - 1 do
        AddData(vtTmp, L1, IntToStr(i) +': ' + yScriptList[i]);
      AddData(vtTmp, Root, 'Array 4a (' + IntToStr(iArrayCount4a) + ')');
      L1 := AddData(vtTmp, Root, 'Array 4b (' + IntToStr(iArrayCount4b) + ')');
      for i := 0 to iArrayCount4b - 1 do
        with yArray4b[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Unk1: 0x' + IntToHex(iUnk1, 2) + ' [' + IntToStr(iUnk1) + ']');
          AddData(vtTmp, L2, 'Unk2: 0x' + IntToHex(iUnk2, 4) + ' [' + IntToStr(iUnk2) + ']');
          AddData(vtTmp, L2, 'Unk3: 0x' + IntToHex(iUnk3, 4) + ' [' + IntToStr(iUnk3) + ']');
          AddData(vtTmp, L2, 'Ref1: ' + RefIDToString(tRef1));
          AddData(vtTmp, L2, 'Ref2: ' + RefIDToString(tRef2));
          AddData(vtTmp, L2, 'Ref3: ' + RefIDToString(tRef3));
          AddData(vtTmp, L2, 'Ref4: ' + RefIDToString(tRef4));
        end;
      L1 := AddData(vtTmp, Root, 'Array 4c (' + IntToStr(iArrayCount4c) + ')');
      for i := 0 to iArrayCount4c - 1 do
        with yArray4c[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Flag: 0x' + IntToHex(iFlag, 2) + ' [' + IntToStr(iFlag) + ']');
          AddData(vtTmp, L2, 'Unk2: 0x' + IntToHex(iUnk2, 8) + ' [' + IntToStr(iUnk2) + ']');
          AddData(vtTmp, L2, 'Ref1: ' + RefIDToString(tRef1));
          if iFlag = 0 then
            AddData(vtTmp, L2, 'Ref2: ' + RefIDToString(tRef2));
          AddData(vtTmp, L2, 'Unk2: 0x' + IntToHex(iUnk2, 8) + ' [' + IntToStr(iUnk2) + ']');
          AddData(vtTmp, L2, 'Unk3: 0x' + IntToHex(iUnk3, 8) + ' [' + IntToStr(iUnk3) + ']');
          if iFlag = 0 then
            AddData(vtTmp, L2, 'Unk4: 0x' + IntToHex(iUnk4, 4) + ' [' + IntToStr(iUnk4) + ']');
          if iFlag = 0 then
            AddData(vtTmp, L2, 'Unk5: 0x' + IntToHex(iUnk5, 4) + ' [' + IntToStr(iUnk5) + ']');
          AddData(vtTmp, L2, 'Unk6: 0x' + IntToHex(iUnk6, 8) + ' [' + IntToStr(iUnk6) + ']');
          if iFlag = 0 then
            AddData(vtTmp, L2, 'Unk7: 0x' + IntToHex(iUnk7, 8) + ' [' + IntToStr(iUnk7) + ']');
          if iFlag = 0 then
            AddData(vtTmp, L2, 'Unk8: 0x' + IntToHex(iUnk8, 8) + ' [' + IntToStr(iUnk8) + ']');
          if iFlag = 0 then
            AddData(vtTmp, L2, 'Unk9: 0x' + IntToHex(iUnk9, 4) + ' [' + IntToStr(iUnk9) + ']');
        end;
      AddData(vtTmp, Root, 'Array 4d (' + IntToStr(iArrayCount4d) + ')');
      L1 := AddData(vtTmp, Root, 'Array 5 (' + IntToStr(iArrayCount5) + ')');
      for i := 0 to iArrayCount5 - 1 do
        with yArray5[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Unk1: 0x' + IntToHex(iUnk1, 4) + ' [' + IntToStr(iUnk1) + ']');
          AddData(vtTmp, L2, 'Unk2: 0x' + IntToHex(iUnk2, 4) + ' [' + IntToStr(iUnk2) + ']');
          AddData(vtTmp, L2, 'Ref1: ' + RefIDToString(tUnk3));
          AddData(vtTmp, L2, 'Ref2: ' + RefIDToString(tUnk4));
          AddData(vtTmp, L2, 'Ref3: ' + RefIDToString(tUnk5));
          AddData(vtTmp, L2, 'Unk6: 0x' + IntToHex(iUnk6, 4) + ' [' + IntToStr(iUnk6) + ']');
        end;
      L1 := AddData(vtTmp, Root, 'Array 6 (' + IntToStr(iArrayCount6) + ')');
      for i := 0 to iArrayCount6 - 1 do
        with yArray6[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Unk: 0x' + IntToHex(iUnk1, 4) + ' [' + IntToStr(iUnk1) + ']');
          AddData(vtTmp, L2, 'Flag: 0x' + IntToHex(iFlag, 4) + ' [' + IntToStr(iFlag) + ']' + ' bin ' + IntToBin(iFlag, 16));
          AddData(vtTmp, L2, 'Ref: ' + RefIDToString(tRef));
        end;
      L1 := AddData(vtTmp, Root, 'Array 7 (' + IntToStr(iArrayCount7) + ')');
      for i := 0 to iArrayCount7 - 1 do
        with yArray7[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Unk: 0x' + IntToHex(iUnk1, 4) + ' [' + IntToStr(iUnk1) + ']');
          AddData(vtTmp, L2, 'Flag: 0x' + IntToHex(iFlag, 4) + ' [' + IntToStr(iFlag) + ']' + ' bin ' + IntToBin(iFlag, 16));
          AddData(vtTmp, L2, 'Ref: ' + RefIDToString(tRef));
        end;
      L1 := AddData(vtTmp, Root, 'Array 8 (' + IntToStr(iArrayCount8) + ')');
      for i := 0 to iArrayCount8 - 1 do
        with yArray8[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Unk: 0x' + IntToHex(iUnk1, 4) + ' [' + IntToStr(iUnk1) + ']');
          AddData(vtTmp, L2, 'Flag: 0x' + IntToHex(iType, 4) + ' [' + IntToStr(iType) + ']' + ' bin ' + IntToBin(iType, 16));
          AddData(vtTmp, L2, 'Ref: ' + RefIDToString(tRef));
          AddData(vtTmp, L2, 'Count 1: ' + IntToStr(iCount1));
          AddData(vtTmp, L2, 'Count 2: ' + IntToStr(iCount2));
          L3 := AddData(vtTmp, L2, 'References (' + IntToStr(Length(yRef)) + ')');
          for j := 0 to Length(yRef) - 1 do
            AddData(vtTmp, L3, 'Ref [' + IntToStr(j) + ']: ' + RefIDToString(yRef[j]));
        end;
      L1 := AddData(vtTmp, Root, 'Array 9 (' + IntToStr(iArrayCount9) + ')');
      for i := 0 to iArrayCount9 - 1 do
        AddData(vtTmp, L1, IntToStr(i) + ': ' + IntToHex(yArray9[i], 8) + ' [' + IntToStr(yArray9[i]) + ']');
      L1 := AddData(vtTmp, Root, 'Array 10 (' + IntToStr(iArrayCount10) + ')');
      for i := 0 to iArrayCount10 - 1 do
        with yArray10[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Array Ref: ' + RefIDToString(tArrayRef));
          L3 := AddData(vtTmp, L2, 'Array (' + IntToStr(iArrayCount) + ')');
          for j := 0 to iArrayCount - 1 do
            with yArray[j] do
            begin
              L4 := AddData(vtTmp, L3, IntToStr(j));
              AddData(vtTmp, L4, 'Name: ' + sName);
              L5 := AddData(vtTmp, L4, 'Data 1 (' + IntToStr(iCount1) + ')');
              for k := 0 to iCount1 - 1 do
                with yData1[k] do
                begin
                  L6 := AddData(vtTmp, L5, IntToStr(k));
                  L7 := AddData(vtTmp, L6, 'Data (' + IntToStr(iCount) + ')');
                  for l := 0 to iCount - 1 do
                    with yData[l] do
                    begin
                      L8 := AddData(vtTmp, L7, IntToStr(l));
                      AddData(vtTmp, L8, 'Str: ' + GetStringReference(iStr, aPapyrus));
                      AddData(vtTmp, L8, 'Flag: 0x' + IntToHex(iFlag, 4) + ' [' + IntToStr(iFlag) + ']' + ' bin ' + IntToBin(iFlag, 16));
                    end;
                end;
              L5 := AddData(vtTmp, L4, 'Data 2 (' + IntToStr(iCount2) + ')');
              for k := 0 to iCount2 - 1 do
                with yData2[k] do
                begin
                  L6 := AddData(vtTmp, L5, IntToStr(k));
                  AddData(vtTmp, L6, 'Unk: 0x' + IntToHex(iUnk, 4) + ' [' + IntToStr(iUnk) + ']' + ' bin ' + IntToBin(iUnk, 16));
                  AddData(vtTmp, L6, 'Flag: 0x' + IntToHex(iFlag, 4) + ' [' + IntToStr(iFlag) + ']' + ' bin ' + IntToBin(iFlag, 16));
                  AddData(vtTmp, L6, 'Ref: ' + RefIDToString(tRef));
                end;
            end;
        end;
      L1 := AddData(vtTmp, Root, 'Array 11 (' + IntToStr(iArrayCount11) + ')');
      for i := 0 to iArrayCount11 - 1 do
        with yArray11[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Unk1: 0x' + IntToHex(iUnk1, 8) + ' [' + IntToStr(iUnk1) + ']');
          AddData(vtTmp, L2, 'Ref: ' + RefIDToString(tRef));
          AddData(vtTmp, L2, 'Unk2: 0x' + IntToHex(iUnk2, 2) + ' [' + IntToStr(iUnk2) + ']' + ' bin ' + IntToBin(iUnk2, 8));
        end;
      L1 := AddData(vtTmp, Root, 'Array 12 (' + IntToStr(iArrayCount12) + ')');
      for i := 0 to iArrayCount12 - 1 do
        with yArray12[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Unk1: 0x' + IntToHex(iUnk1, 2) + ' [' + IntToStr(iUnk1) + ']' + ' bin ' + IntToBin(iUnk1, 8));
          AddData(vtTmp, L2, 'Unk2: 0x' + IntToHex(iUnk2, 4) + ' [' + IntToStr(iUnk2) + ']');
          L3 := AddData(vtTmp, L2, 'Elements (' + IntToStr(iCount) + ')');
          for j := 0 to iCount - 1 do
            with yData[j] do
            begin
              L4 := AddData(vtTmp, L3, IntToStr(j));
              AddData(vtTmp, L4, 'Unk1: 0x' + IntToHex(iUnk1, 8) + ' [' + IntToStr(iUnk1) + ']');
              AddData(vtTmp, L4, 'Unk2: 0x' + IntToHex(iUnk1, 2) + ' [' + IntToStr(iUnk2) + ']' + ' bin ' + IntToBin(iUnk2, 8));
              AddData(vtTmp, L4, 'Str: ' + GetStringReference(iStr, aPapyrus));
              AddData(vtTmp, L4, 'Unk3: 0x' + IntToHex(iUnk3, 4) + ' [' + IntToStr(iUnk3) + ']');
            end;
        end;
      L1 := AddData(vtTmp, Root, 'Array 13 (' + IntToStr(iArrayCount13) + ')');
      for i := 0 to iArrayCount13 - 1 do
        with yArray13[i] do
        begin
          L2 := AddData(vtTmp, L1, IntToStr(i));
          AddData(vtTmp, L2, 'Ref: ' + RefIDToString(tRef));
          L3 := AddData(vtTmp, L2, 'Elements 1 (' + IntToStr(iCount1) + ')');
          for j := 0 to iCount1 - 1 do
            AddData(vtTmp, L3, '[' + IntToStr(j) + ']: 0x' + IntToHex(yData1[j], 8) + ' [' + IntToStr(yData1[j]) + ']');
          L3 := AddData(vtTmp, L2, 'Elements 2 (' + IntToStr(iCount2) + ')');
          for j := 0 to iCount2 - 1 do
            AddData(vtTmp, L3, '[' + IntToStr(j) + ']: 0x' + IntToHex(yData2[j], 8) + ' [' + IntToStr(yData2[j]) + ']');
          L3 := AddData(vtTmp, L2, 'Elements 3 (' + IntToStr(iCount3) + ')');
          for j := 0 to iCount3 - 1 do
            AddData(vtTmp, L3, '[' + IntToStr(j) + ']: 0x' + IntToHex(yData3[j], 8) + ' [' + IntToStr(yData3[j]) + ']');
          AddData(vtTmp, L2, 'Unk: 0x' + IntToHex(iUnk, 2) + ' [' + IntToStr(iUnk) + ']');
        end;
      L1 := AddData(vtTmp, Root, 'Array 14 (' + IntToStr(iArrayCount14) + ')');
      for i := 0 to iArrayCount14 - 1 do
        AddData(vtTmp, L1, IntToStr(i) + ': ' + IntToHex(yArray14[i], 8) + ' [' + IntToStr(yArray14[i]) + ']');
      AddData(vtTmp, Root, 'Array 15 (' + IntToStr(iArrayCount15) + ')');
      if iOther <> 0 then
        AddData(vtTmp, Root, 'Other not recognized bytes: ' + IntToStr(iOther));
      Expanded[Root] := True;
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

end.
