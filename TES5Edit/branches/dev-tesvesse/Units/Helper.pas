unit Helper;

{$IF CompilerVersion >= 17} {$DEFINE USEREGION} {$IFEND}

interface

uses
  Windows, uESSFile, Grids, VirtualTrees, ComCtrls, StdCtrls, Dialogs, ExtCtrls,
  Classes, Graphics, Controls, VistaProgressBar, GlassButton, HexEdit;

const
  TVIS_CHECKED   = $2000;
  TVIS_UNCHECKED = $1000;

type
  TBufType = (btNone, btGlobal, btForm, btInt, btHex, btFloat, btString, btRefID, btReadOnly, btCalc, btRec, btShot, btFlags);
  PMyRec = ^TMyRec;
  TMyRec = record
    _Caption: WideString;
    _Type: TBufType;
    _Pointer: Pointer;
    _Size, _Decompressed: Integer;
  end;

  TFormView = record
    No: integer;
    Form: packed record
      formID: TRefID;
      changeFlags: uint32;
      _type: uint8;
      version: uint8;
      length1: uint32;
      length2:uint32;
    end;  
  end;
  TFormViews = array of TFormView;

  TExOpenDialog = class(TOpenDialog)
  public
     pnBackground: TPanel;
     lbInfo: TLabel;
     imPicture: TImage;
  protected
     procedure DoShow; override;
  public
     constructor Create(AOwner: TComponent); override;
  end;

  TEdit = class(StdCtrls.TEdit)
  private
    FAlignment : TAlignment;
    procedure SetAlignment(Value: TAlignment);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    property Alignment: TAlignment read FAlignment write SetAlignment;
  end;

function CreateButton(aCaption: string; aEnabled: Boolean; aColor: TColor;
                      aLeft, aTop, aHeight, aWidth, aImageIndex, aTabOrder: integer;
                      aAnchors: TAnchors;
                      aOwner: TComponent;
                      aParent: TWinControl;
                      aImageList: TImageList;
                      aOnClick: TNotifyEvent;
                      aAction: TBasicAction): TGlassButton;

function lvGD01GeneralNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
function lvGD01QuestNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
function lvGD01CombatNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
function lvGD01MagicNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
function lvGD01CraftingNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
function lvGD01CrimeNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
function lvGD01AllNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
function lvGD02NewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
function lvGD04NewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;

function MinimizeName(const FileName: string; Canvas: TCanvas; MaxLen: Integer): string;

function IsVista: Boolean;
procedure SetListHeadColor(hListView: HWND; var FarProc: TFarProc; NewHeadProc: LongInt);
procedure DrawListHeader(hwnd: HWND; uMsg: UINT);

procedure GetCaptionLevel1(var ESSFile: TESSFile; Index: Integer; var MyData: PMyRec; var Node: PVirtualNode);
procedure GetCaptionLevel2(var ESSFile: TESSFile; Parent, Index: integer; var MyData: PMyRec; var Node: PVirtualNode);
procedure GetCaptionLevel3(var ESSFile: TESSFile; Owner, Parent, Index: integer; var MyData: PMyRec; var Node: PVirtualNode);

function GetData(var Data: TBytes; var BufData: TBytes; Size, Decompressed: Integer; grEdit: THexEditor): Boolean;
procedure SetData(var Data: TBytes; var BufData: TBytes; var Size, Decompressed: Integer; grEdit: THexEditor; TryCompress: Boolean = False);

function WriteHexEditor(var Data: TBytes; Editor: THexEditor): boolean;
procedure ReadHexEditor(var Data: TBytes; Editor: THexEditor);

function GetNodeText(Sender: TBaseVirtualTree; Node: PVirtualNode): string;
procedure SetNodeText(Sender: TBaseVirtualTree; Node: PVirtualNode);

function GetChild(Node: PVirtualNode; Index: Cardinal): PVirtualNode;

function IsChecked(tvView: TTreeView; Index: integer): Boolean;
procedure SetChecked(tvView: TTreeView; Index: integer; Checked: Boolean);

procedure CreateProgress(Owner: TComponent; pnParent: TWinControl; var btnBreak: TGlassButton; var pbProcess: TVistaProgressBar; var pnStatus: TPanel; Click: TNotifyEvent);
procedure FreeProgress(var btnBreak: TGlassButton; var pbProcess: TVistaProgressBar; var pnStatus: TPanel);

procedure SetColumnSortOrder(ListView: TListview; Column, SortColumn: Integer; Ascending: Boolean);
function SortByColumnAscend(Item1, Item2: TListItem; Data: integer): integer; stdcall;
function SortByColumnDescend(Item1, Item2: TListItem; Data: integer): integer; stdcall;

procedure QuickSortForms(var aForms: TFormViews; aLow, aHi: Integer; aAscend: Boolean; aIndex: Integer);

var
  lvGD01GeneralProc, lvGD01QuestProc, lvGD01CombatProc, lvGD01MagicProc, lvGD01CraftingProc, lvGD01CrimeProc, lvGD01AllProc: TFarProc;
  lvGD02Proc, lvGD04Proc: TFarProc;

type
  TSelectDirectoryProc = function(const Directory: string): Boolean;

function SelectDirectoryEx(Owner: HWND; var Path: string; const Caption, Root: string; BIFs: DWORD = $59; Callback: TSelectDirectoryProc = nil; const FileName: string = ''): boolean;
function CallBack(const Path: string): boolean;

implementation

uses
  SysUtils, Forms, Messages, CommCtrl, ShlObj, ActiveX;

function CreateButton(aCaption: string; aEnabled: Boolean; aColor: TColor;
                      aLeft, aTop, aHeight, aWidth, aImageIndex, aTabOrder: integer;
                      aAnchors: TAnchors;
                      aOwner: TComponent;
                      aParent: TWinControl;
                      aImageList: TImageList;
                      aOnClick: TNotifyEvent;
                      aAction: TBasicAction): TGlassButton;
begin
  Result := TGlassButton.Create(aOwner);
  with Result do
  begin
    Parent := aParent;
    Left := aLeft;
    Top := aTop;
    Width := aWidth;
    Height := aHeight;
    Anchors := aAnchors;
    Caption := aCaption;
    Images := aImageList;
    ImageIdx := aImageIndex;
    TabOrder := aTabOrder;
    Enabled := aEnabled;
    Font.Color := aColor;
    OnClick := aOnClick;
    Action := aAction;
    Flat := False;
    TextAlign := taCenter;
    ColorDown := clSilver;
    ColorFocused := clSkyBlue;
    ColorOver := clBlue;
    AltFocus := True;
    AltRender := True;
  end;
end;

function lvGD01GeneralNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
begin
  Result := Windows.CallWindowProc(lvGD01GeneralProc, hWnd, uMsg, wParam, lParam);
  DrawListHeader(hwnd, uMsg);
end;

function lvGD01QuestNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
begin
  Result := Windows.CallWindowProc(lvGD01QuestProc, hWnd, uMsg, wParam, lParam);
  DrawListHeader(hwnd, uMsg);
end;

function lvGD01CombatNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
begin
  Result := Windows.CallWindowProc(lvGD01CombatProc, hWnd, uMsg, wParam, lParam);
  DrawListHeader(hwnd, uMsg);
end;

function lvGD01MagicNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
begin
  Result := Windows.CallWindowProc(lvGD01MagicProc, hWnd, uMsg, wParam, lParam);
  DrawListHeader(hwnd, uMsg);
end;

function lvGD01CraftingNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
begin
  Result := Windows.CallWindowProc(lvGD01CraftingProc, hWnd, uMsg, wParam, lParam);
  DrawListHeader(hwnd, uMsg);
end;

function lvGD01CrimeNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
begin
  Result := Windows.CallWindowProc(lvGD01CrimeProc, hWnd, uMsg, wParam, lParam);
  DrawListHeader(hwnd, uMsg);
end;

function lvGD01AllNewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
begin
  Result := Windows.CallWindowProc(lvGD01AllProc, hWnd, uMsg, wParam, lParam);
  DrawListHeader(hwnd, uMsg);
end;

function lvGD02NewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
begin
  Result := Windows.CallWindowProc(lvGD02Proc, hWnd, uMsg, wParam, lParam);
  DrawListHeader(hwnd, uMsg);
end;

function lvGD04NewProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall;
begin
  Result := Windows.CallWindowProc(lvGD04Proc, hWnd, uMsg, wParam, lParam);
  DrawListHeader(hwnd, uMsg);
end;

function MinimizeName(const FileName: string; Canvas: TCanvas; MaxLen: Integer): string;
var
  sNewName: array[0..MAX_PATH] of Char;
  R: TRect;
begin
  StrCopy(sNewName, PChar(FileName));
  R := Rect(0, 0, MaxLen, Canvas.TextHeight('Wq'));
  if DrawText(Canvas.Handle, sNewName, Length(FileName), R, DT_SINGLELINE or DT_MODIFYSTRING or DT_PATH_ELLIPSIS or DT_CALCRECT or DT_NOPREFIX) > 0 then
    Result := sNewName
  else
    Result := FileName;
end;

function IsVista: Boolean;
var
  hKernel32: HMODULE;
begin
  hKernel32 := GetModuleHandle('kernel32');
  if hKernel32 > 0 then
    Result := GetProcAddress(hKernel32, 'GetLocaleInfoEx') <> nil
  else
    Result := False;
end;

procedure SetListHeadColor(hListView: HWND; var FarProc: TFarProc; NewHeadProc: LongInt);
var
  FHeaderHandle: HWND;
begin
  FHeaderHandle := FindWindowEx(hListView, 0, 'SysHeader32', nil);
  FarProc := TFarProc(SetWindowLong(FHeaderHandle, GWL_WNDPROC, NewHeadProc));
  InvalidateRect(FHeaderHandle, nil, False);
end;

procedure DrawListHeader(hwnd: HWND; uMsg: UINT);
var
  Rect: TRect;
  Canvas: TCanvas;
  Bmp: TBitmap;
begin
  if uMsg = WM_PAINT then
  begin
    Windows.GetClientRect(hwnd, Rect);
    Rect.Top := Rect.Top - 2;
    Rect.Left := Rect.Left - 2;
    Rect.Right := Rect.Right + 2;
    Canvas := TCanvas.Create;
    try
      Canvas.Handle := GetDC(hwnd);
      Bmp := TBitmap.Create;
      try
        Bmp.Width := Rect.Right;
        Bmp.Height := Rect.Bottom;
        Bmp.Canvas.CopyRect(Rect, Canvas, Rect);
        Bmp.Transparent := True;
        Bmp.TransparentColor := clBtnFace;
        Canvas.Brush.Color := $F0F0F0;
        Canvas.Pen.Color := clWhite;
        Canvas.Rectangle(Rect);
        Canvas.Draw(0, 0, Bmp);
      finally
        Bmp.Free;
      end;
    finally
      ReleaseDC(hwnd, Canvas.Handle);
      Canvas.Free;
    end;
  end;
end;

{$IF Defined(USEREGION)}{$REGION 'Tree view interface'}{$IFEND}
procedure SetTypeCaption(var MyData: PMyRec; Caption: string; BufType: TBufType; Address: Pointer = nil; Size: Integer = 0; Decompressed: Integer = 0);
begin
  with MyData^ do
  begin
    _Caption := Caption;
    _Type := BufType;
    _Pointer := Address;
    _Size := Size;
    _Decompressed := Decompressed;
  end;
end;

procedure GetCaptionLevel1(var ESSFile: TESSFile; Index: Integer; var MyData: PMyRec; var Node: PVirtualNode);
begin
  with ESSFile, MyData^ do
    case Index of
      0: SetTypeCaption(MyData, 'Magic: ' + MagicToString(magic), btReadOnly);
      1: SetTypeCaption(MyData, 'Header size: ', btCalc, @headerSize, SizeOf(headerSize));
      2: _Caption := 'Header';
      3: SetTypeCaption(MyData, 'Screenshot data', btShot, @screenshotData, Length(screenshotData));
      4: SetTypeCaption(MyData, 'Form version: ', btInt, @formVersion, SizeOf(formVersion));
      5: SetTypeCaption(MyData, 'Plugin info size: ', btCalc, @pluginInfoSize, SizeOf(pluginInfoSize));
      6: _Caption := 'Plugin info';
      7: _Caption := 'File location table';
      8: _Caption := 'Global data table 1';
      9: _Caption := 'Global data table 2';
      10: _Caption := 'Change forms';
      11: _Caption := 'Global data table 3';
      12: SetTypeCaption(MyData, 'Form ID array count: ', btCalc, @formIDArrayCount, SizeOf(formIDArrayCount));
      13: _Caption := 'Form ID array';
      14: SetTypeCaption(MyData, 'Unknown 2 table count: ', btCalc, @unknown2TableCount, SizeOf(unknown2TableCount));
      15: _Caption := 'Unknown 2 table';
      16: SetTypeCaption(MyData, 'Unknown 3 table size: ', btCalc, @unknown3TableSize, SizeOf(unknown3TableSize));
      17: _Caption := 'Unknown 3 table';
    end;
end;

procedure GetCaptionLevel2(var ESSFile: TESSFile; Parent, Index: integer; var MyData: PMyRec; var Node: PVirtualNode);
begin
  with ESSFile, MyData^ do
    case Parent of
      2: with Header do
           case Index of
             0: SetTypeCaption(MyData, 'Version: ', btInt, @version, SizeOf(version));
             1: SetTypeCaption(MyData, 'Save number: ', btInt, @saveNumber, SizeOf(saveNumber));
             2: SetTypeCaption(MyData, 'Player name: ', btString, @playerName);
             3: SetTypeCaption(MyData, 'Player level: ', btInt, @playerLevel, SizeOf(playerLevel));
             4: SetTypeCaption(MyData, 'Player location: ', btString, @playerLocation);
             5: SetTypeCaption(MyData, 'Game date: ', btString, @gameDate);
             6: SetTypeCaption(MyData, 'Player race editor ID: ', btString, @playerRaceEditorId);
             7: SetTypeCaption(MyData, 'unknown 1: ', btInt, @unknown1, SizeOf(unknown1));
             8: SetTypeCaption(MyData, 'unknown 2: ', btFloat, @unknown2, SizeOf(unknown2));
             9: SetTypeCaption(MyData, 'unknown 3: ', btFloat, @unknown3, SizeOf(unknown3));
             10: SetTypeCaption(MyData, 'File time: ' + FileTimeToString(filetime), btReadOnly);
             11: SetTypeCaption(MyData, 'Shot width: ', btReadOnly, @shotWidth, SizeOf(shotWidth));
             12: SetTypeCaption(MyData, 'Shot height: ', btReadOnly, @shotHeight, SizeOf(shotHeight));
           end;
      6: with PluginInfo do
           case Index of
             0: SetTypeCaption(MyData, 'Plugin count: ', btCalc, @pluginCount, SizeOf(pluginCount));
             1: _Caption := 'plugins';
           end;
      7: with FileLocationTable do
           case Index of
             0: SetTypeCaption(MyData, 'Form ID array offest: ', btCalc, @formIDArrayOffest, SizeOf(formIDArrayOffest));
             1: SetTypeCaption(MyData, 'Unknown table 3 offset: ', btCalc, @unknownTable3Offset, SizeOf(unknownTable3Offset));
             2: SetTypeCaption(MyData, 'Global data table 1 offset: ', btCalc, @globalDataTable1Offset, SizeOf(globalDataTable1Offset));
             3: SetTypeCaption(MyData, 'Global data table 2 offset: ', btCalc, @globalDataTable2Offset, SizeOf(globalDataTable2Offset));
             4: SetTypeCaption(MyData, 'Change forms offset: ', btCalc, @changeFormsOffset, SizeOf(changeFormsOffset));
             5: SetTypeCaption(MyData, 'Global data table 3 offset: ', btCalc, @globalDataTable3Offset, SizeOf(globalDataTable3Offset));
             6: SetTypeCaption(MyData, 'Global data table 1 count: ', btCalc, @globalDataTable1Count, SizeOf(globalDataTable1Count));
             7: SetTypeCaption(MyData, 'Global data table 2 count: ', btCalc, @globalDataTable2Count, SizeOf(globalDataTable2Count));
             8: SetTypeCaption(MyData, 'Global data table 3 count: ', btCalc, @globalDataTable3Count, SizeOf(globalDataTable3Count));
             9: SetTypeCaption(MyData, 'Change form count: ', btCalc, @changeFormCount, SizeOf(changeFormCount));
             10: _Caption := 'Unused';
           end;
      8: with globalDataTable1[Index] do
           SetTypeCaption(MyData, IntToStr(Index + 1) + ' ' + GetTypeString(_type), btRec, @globalDataTable1[Index], Index);
      9: with globalDataTable2[Index] do
           SetTypeCaption(MyData, IntToStr(Index + 1) + ' ' + GetTypeString(_type), btRec, @globalDataTable2[Index], Index);
      10: with changeForms[Index] do
           SetTypeCaption(MyData, IntToStr(Index + 1) + ' [' + RefIDToString(formID) + '] ' + Copy(GetFormString(_type), 1, 4), btRec, @changeForms[Index], Index);
      11: with globalDataTable3[Index] do
           SetTypeCaption(MyData, IntToStr(Index + 1) + ' ' + GetTypeString(_type), btRec, @globalDataTable3[Index], Index);
      13: SetTypeCaption(MyData, IntToStr(Index) + ' [' + RefIDToString(formIDArray[Index].ID) + '] ', btRec, @formIDArray[Index]);
      15: SetTypeCaption(MyData, IntToStr(Index) + ' ', btHex, @unknown2Table[Index], SizeOf(unknown2Table[Index]));
      17: with unknown3Table do
           case Index of
             0: SetTypeCaption(MyData, 'Count: ', btCalc, @Count, SizeOf(Count));
             1: _Caption := 'unknown';
           end;
    end;
end;

procedure GetCaptionLevel3(var ESSFile: TESSFile; Owner, Parent, Index: integer; var MyData: PMyRec; var Node: PVirtualNode);
begin
  with ESSFile, MyData^ do
    case Owner of
      6: with pluginInfo do
           if Parent = 1 then
             SetTypeCaption(MyData, IntToStr(Index) + ' - ', btString, @plugins[Index]);
      7: with FileLocationTable do
           if Parent = 10 then
             SetTypeCaption(MyData, IntToStr(Index + 1) + ' ', btInt, @unused[Index + 1], SizeOf(unused[Index + 1]));
      8: with globalDataTable1[Parent] do
           case Index of
             0: _Caption := 'Type: ' + IntToStr(_type) + ' [' + GetTypeString(_type) + ']';
             1: SetTypeCaption(MyData, 'Length: ', btCalc, @_length, SizeOf(_length));
             2: SetTypeCaption(MyData, 'Data', btGlobal, @data, Length(data));
           end;
      9: with globalDataTable2[Parent] do
           case Index of
             0: _Caption := 'Type: ' + IntToStr(_type) + ' [' + GetTypeString(_type) + ']';
             1: SetTypeCaption(MyData, 'Length: ', btCalc, @_length, SizeOf(_length));
             2: SetTypeCaption(MyData, 'Data', btGlobal, @data, Length(data));
           end;
      10: with changeForms[Parent] do
           case Index of
             0: _Caption := 'Form ID: ' + RefIDToString(formID);
             1: SetTypeCaption(MyData, 'Change flags: ', btFlags, @changeFlags, SizeOf(changeFlags));
             2: _Caption := 'Type: ' + IntToStr(_type) + ' [' + GetFormString(_type) + ']';
             3: SetTypeCaption(MyData, 'Version: ', btInt, @version, SizeOf(version));
             4: SetTypeCaption(MyData, 'Length 1: ', btCalc, @length1, SizeOf(length1));
             5: SetTypeCaption(MyData, 'Length 2: ', btCalc, @length2, SizeOf(length2));
             6: SetTypeCaption(MyData, 'Data', btForm, @data, Length(data), length2);
           end;
      11: with globalDataTable3[Parent] do
           case Index of
             0: _Caption := 'Type: ' + IntToStr(_type) + ' [' + GetTypeString(_type) + ']';
             1: SetTypeCaption(MyData, 'Length: ', btCalc, @_length, SizeOf(_length));
             2: SetTypeCaption(MyData, 'Data', btGlobal, @data, Length(data));
           end;
      13: with formIDArray[Parent] do
           case Index of
             0: _Caption := 'Form ID: ' + RefIDToString(ID);
             1: SetTypeCaption(MyData, 'Count: ', btInt, @Count, SizeOf(Count));
           end;
      17: with unknown3Table do
            SetTypeCaption(MyData, IntToStr(Index) + ' ', btString, @unknown[Index]);
    end;
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'Load/save data buffer'}{$IFEND}
function GetData(var Data: TBytes; var BufData: TBytes; Size, Decompressed: Integer; grEdit: THexEditor): Boolean;
begin
  Result := True;
  SetLength(BufData, Size);
  if Size > 0 then
    Move(Data[0], BufData[0], Size);
  if Decompressed > Size then
    if not DecompressData(BufData, uInt32(Decompressed)) then
    begin
      SetLength(BufData, 0);
      Result := False;
    end;
  if Result then
    WriteHexEditor(BufData, grEdit);
end;

procedure SetData(var Data: TBytes; var BufData: TBytes; var Size, Decompressed: Integer; grEdit: THexEditor; TryCompress: Boolean = False);
begin
  ReadHexEditor(BufData, grEdit);
  if TryCompress then
  begin
    Decompressed := Length(BufData);
    if not CompressData(BufData) then
      Decompressed := 0;
  end
  else
    Decompressed := 0;
  Size := Length(BufData);
  SetLength(Data, Size);
  if Size > 0 then
    Move(BufData[0], Data[0], Size);
  SetLength(BufData, 0)
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'Hex Editor Data function'}{$IFEND}
function WriteHexEditor(var Data: TBytes; Editor: THexEditor): boolean;
var
  D: TDataSize;
begin
  if Length(Data) > 0 then
  begin
    D.Data := @Data[0];
    D.Size := Length(Data);
    Editor.Data := D;
  end
  else
    Editor.Clear;
  Result := True;
end;

procedure ReadHexEditor(var Data: TBytes; Editor: THexEditor);
var
  D: TDataSize;
begin
  D := Editor.Data;
  SetLength(Data, D.Size);
  if D.Size > 0 then
    Move(D.Data^, Data[0], D.Size);
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'ExOpenDialog'}{$IFEND}
constructor TExOpenDialog.Create(AOwner: TComponent);
begin
  inherited;
  pnBackground := TPanel.Create(Self);
  with pnBackground do
  begin
    BevelOuter := bvNone;
    BevelInner := bvNone;
    Anchors := [akLeft, akRight];
  end;
  imPicture := TImage.Create(pnBackground);
  with imPicture do
  begin
    Parent := pnBackground;
    Stretch := True;
    Height := 160;
  end;
  lbInfo := TLabel.Create(pnBackground);
  with lbInfo do
  begin
    Parent := pnBackground;
    AutoSize := False;
    ParentFont := False;
    Transparent := True;
    with Font do
    begin
      Name := 'Comic Sans MS';
      Style := [fsBold];
      Size := 10;
    end;
    Height := imPicture.Height;
    Width := Screen.Width;
  end;
end;

procedure TExOpenDialog.DoShow;
var
  rCRect, rWRect: TRect;
  hParent: HWND;
begin
  inherited;
  hParent := GetParent(Handle);
  pnBackground.ParentWindow := hParent;
  GetClientRect(hParent, rCRect);
  GetWindowRect(hParent, rWRect);
  MoveWindow(hParent, rWRect.Left, rWRect.Top, rWRect.Right - rWRect.Left,
                      rWRect.Bottom - rWRect.Top + imPicture.Height, True);
  GetClientRect(hParent, rWRect);
  pnBackground.SetBounds(0, rCRect.Bottom, rWRect.Right - rWRect.Left + 1, rWRect.Bottom - rCRect.Bottom);
  imPicture.Picture := nil;
  lbInfo.Caption := '';
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure TEdit.CreateParams(var Params: TCreateParams);
const
  Alignments : array[TAlignment] of Longword = (ES_LEFT,ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or Alignments[FAlignment];
end;

procedure TEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

function GetNodeText(Sender: TBaseVirtualTree; Node: PVirtualNode): string;
var
  MyData: PMyRec;
begin
  MyData := Sender.GetNodeData(Node);
  if Assigned(MyData) then
    with MyData^ do
    begin
      Result := _Caption;
      if _Pointer <> nil then
        case _Type of
          btInt, btCalc, btReadOnly:
            case _Size of
              4: Result := Result + IntToStr(uint32(_Pointer^));
              2: Result := Result + IntToStr(uint16(_Pointer^));
              else
                Result := Result + IntToStr(uint8(_Pointer^));
             end;
          btHex, btFlags:
            case _Size of
              4: Result := Result + '[0x' + IntToHex(uint32(_Pointer^), _Size * 2) + '] ' + IntToStr(uint32(_Pointer^));
              2: Result := Result + '[0x' + IntToHex(uint16(_Pointer^), _Size * 2) + '] ' + IntToStr(uint16(_Pointer^));
              else
                Result := Result + '[0x' + IntToHex(uint8(_Pointer^), _Size * 2) + '] ' + IntToStr(uint(_Pointer^));
            end;
          btFloat:
            if _Size = 8 then
              Result := Result + FloatToStr(Double(_Pointer^))
            else
              Result := Result + FloatToStr(Single(_Pointer^));
          btString:
            Result := Result + wstringToString(wstring(_Pointer^));
          btRefID:
            Result := Result + '[' + RefIDToString(TRefID(_Pointer^)) + ']';
        end;
    end
    else
      Result := '';
end;

procedure SetNodeText(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  with (Sender as TCustomVirtualStringTree) do
    Text[Node, 0] := GetNodeText(Sender, Node);
end;

function GetChild(Node: PVirtualNode; Index: Cardinal): PVirtualNode;
begin
  Result := nil;
  Node := Node^.FirstChild;
  while Assigned(Node) do
  begin
    if Node^.Index = Index then
    begin
      Result := Node;
      Break;
    end;
    Node := Node.NextSibling;
  end;
end;

function IsChecked(tvView: TTreeView; Index: integer): Boolean;
var
  TvItem: TTVItem;
begin
  Result := False;
  if (Index >= 0) and (Index < tvView.Items.Count) then
  begin
    TvItem.Mask := TVIF_STATE;
    TvItem.hItem := tvView.Items.Item[Index].ItemId;
    TreeView_GetItem(tvView.Items.Item[Index].TreeView.Handle, TvItem);
    Result := TvItem.State and TVIS_CHECKED > 0;
  end;
end;

procedure SetChecked(tvView: TTreeView; Index: integer; Checked: Boolean);
var
  TvItem: TTVItem;
begin
  if (Index >= 0) and (Index < tvView.Items.Count) then
  begin
    ZeroMemory(@TvItem, SizeOf(TvItem));
    TvItem.hItem := tvView.Items.Item[Index].ItemId;
    TvItem.Mask := TVIF_STATE;
    TvItem.StateMask := TVIS_STATEIMAGEMASK;
    if Checked then
      TvItem.State := TVIS_CHECKED
    else
      TvItem.State := TVIS_UNCHECKED;
    TreeView_SetItem(tvView.Items.Item[Index].TreeView.Handle, TvItem);
  end;
end;

procedure CreateProgress(Owner: TComponent; pnParent: TWinControl; var btnBreak: TGlassButton; var pbProcess: TVistaProgressBar; var pnStatus: TPanel; Click: TNotifyEvent);
begin
  pnStatus.Visible := False;
  btnBreak := CreateButton('x', True, clBlack, pnParent.ClientWidth - 16, pnParent.ClientHeight - 16, 16, 16, 0, 0, [akRight, akBottom], Owner, pnParent, nil, Click , nil);
  pbProcess := TVistaProgressBar.Create(Owner);
  with pbProcess do
  begin
    Parent := pnParent;
    Left := 0;
    Top := pnParent.ClientHeight - 16;
    Width := pnParent.ClientWidth - 17;
    Height := 16;
    Position := 0;
    Anchors := [akLeft, akRight, akBottom]
  end;
end;

procedure FreeProgress(var btnBreak: TGlassButton; var pbProcess: TVistaProgressBar; var pnStatus: TPanel);
begin
  btnBreak.Free;
  btnBreak := nil;
  pbProcess.Free;
  pbProcess := nil;
  pnStatus.Visible := True;
end;

procedure SetColumnSortOrder(ListView: TListview; Column, SortColumn: Integer; Ascending: Boolean);
var
  hdr: HWND;
  hdrItem: THDItem;
Begin
  hdr := Listview_GetHeader(ListView.Handle);
  ZeroMemory(@hdrItem, SizeOf(hdrItem));
  hdrItem.Mask := HDI_FORMAT;
  Header_GetItem(hdr, Column, hdrItem);
  if Column = SortColumn then
  begin
    hdrItem.Mask := HDI_FORMAT or HDI_BITMAP;
    If Ascending Then
      hdrItem.hbm := LoadImage(hInstance, 'ArrUp', IMAGE_BITMAP, 0, 0, LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS)
    else
      hdrItem.hbm := LoadImage(hInstance, 'ArrDown', IMAGE_BITMAP, 0, 0, LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
    hdrItem.fmt := hdrItem.fmt OR HDF_BITMAP_ON_RIGHT OR HDF_BITMAP;
  end
  else
    hdrItem.fmt := hdrItem.fmt and not (HDF_BITMAP or HDF_BITMAP_ON_RIGHT);
  Header_SetItem(hdr, Column, hdrItem);
end;

function SortByColumnAscend(Item1, Item2: TListItem; Data: integer): integer; stdcall;
var
  iVal1, iVal2: Integer;
begin
  if Data <> 0 then
    Result := AnsiCompareText(Item1.SubItems[Data - 1], Item2.SubItems[Data - 1])
  else
    if not (TryStrToInt(Item1.Caption, iVal1) and TryStrToInt(Item2.Caption, iVal2)) or (iVal1 = iVal2) then
      Result := 0
    else
      if iVal1 < iVal2 then
        Result := -1
      else
        Result := 1;
end;

function SortByColumnDescend(Item1, Item2: TListItem; Data: integer): integer; stdcall;
var
  iVal1, iVal2: Integer;
begin
  if Data <> 0 then
    Result := AnsiCompareText(Item2.SubItems[Data - 1], Item1.SubItems[Data - 1])
  else
    if not (TryStrToInt(Item1.Caption, iVal1) and TryStrToInt(Item2.Caption, iVal2)) or (iVal1 = iVal2) then
      Result := 0
    else
      if iVal2 < iVal1 then
        Result := -1
      else
        Result := 1;
end;

procedure QuickSortForms(var aForms: TFormViews; aLow, aHi: Integer; aAscend: Boolean; aIndex: Integer);
var
  Act, Temp: TFormView;
  iL, iH: integer;
begin
  iL := aLow;
  iH := aHi;
  Act := aForms[(aLow + aHi) div 2];
  repeat
    if aAscend then
      case aIndex of
        0: while aForms[iL].No < Act.No do
             inc(iL);
        1: while RefIDCompare(aForms[iL].Form.formID, Act.Form.formID) < 0 do
             inc(iL);
        2, 3: while aForms[iL].Form.changeFlags < Act.Form.changeFlags do
                inc(iL);
        4, 5: while aForms[iL].Form._type < Act.Form._type do
                inc(iL);
        6: while aForms[iL].Form.version < Act.Form.version do
             inc(iL);
        7: while aForms[iL].Form.length1 < Act.Form.length1 do
             inc(iL);
        8: while aForms[iL].Form.length2 < Act.Form.length2 do
             inc(iL);
      end
    else
      case aIndex of
        0: while Act.No < aForms[iL].No do
             inc(iL);
        1: while RefIDCompare(Act.Form.formID, aForms[iL].Form.formID) < 0 do
             inc(iL);
        2, 3: while Act.Form.changeFlags < aForms[iL].Form.changeFlags do
                inc(iL);
        4, 5: while Act.Form._type < aForms[iL].Form._type do
                inc(iL);
        6: while Act.Form.version < aForms[iL].Form.version do
             inc(iL);
        7: while Act.Form.length1 < aForms[iL].Form.length1 do
             inc(iL);
        8: while Act.Form.length2 < aForms[iL].Form.length2 do
             inc(iL);
      end;
    if aAscend then
      case aIndex of
        0: while Act.No < aForms[iH].No do
             dec(iH);
        1: while RefIDCompare(Act.Form.formID, aForms[iH].Form.formID) < 0 do
             dec(iH);
        2, 3: while Act.Form.changeFlags < aForms[iH].Form.changeFlags do
                dec(iH);
        4, 5: while Act.Form._type < aForms[iH].Form._type do
                dec(iH);
        6: while Act.Form.version < aForms[iH].Form.version do
             dec(iH);
        7: while Act.Form.length1 < aForms[iH].Form.length1 do
             dec(iH);
        8: while Act.Form.length2 < aForms[iH].Form.length2 do
             dec(iH);
      end
    else
      case aIndex of
        0: while aForms[iH].No < Act.No do
             dec(iH);
        1: while RefIDCompare(aForms[iH].Form.formID, Act.Form.formID) < 0 do
             dec(iH);
        2, 3: while aForms[iH].Form.changeFlags < Act.Form.changeFlags do
                dec(iH);
        4, 5: while aForms[iH].Form._type < Act.Form._type do
                dec(iH);
        6: while aForms[iH].Form.version < Act.Form.version do
             dec(iH);
        7: while aForms[iH].Form.length1 < Act.Form.length1 do
             dec(iH);
        8: while aForms[iH].Form.length2 < Act.Form.length2 do
             dec(iH);
      end;
    if iL <= iH then
    begin
      Temp := aForms[iL];
      aForms[iL] := aForms[iH];
      aForms[iH] := Temp;
      inc(iL);
      dec(iH)
    end;
  until iL > iH;
  if aLow < iH then
    QuickSortForms(aForms, aLow, iH, aAscend, aIndex);
  if iL < aHi then
    QuickSortForms(aForms, iL, aHi, aAscend, aIndex)
end;

function SelectDirectoryEx(Owner: HWND; var Path: string; const Caption, Root: string; BIFs: DWORD = $59; Callback: TSelectDirectoryProc = nil; const FileName: string = ''): boolean;
const
  BIF_NEWDIALOGSTYLE = $0040;
type
  TMyData = packed record
    IniPath: PChar;
    FileName: PChar;
    Proc: TSelectDirectoryProc;
  end;
  PMyData = ^TMyData;
var
  BrowseInfo: TBrowseInfo;
  Buffer: PChar;
  RootItemIDList, ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Dummy: LongWord;
  Data: TMyData;

  function BrowseCallbackProc(hwnd: HWND; uMsg: UINT; lParam: Cardinal; lpData: Cardinal): integer; stdcall;
  var
    PathName: array[0..MAX_PATH] of char;
  begin
    case uMsg of
      BFFM_INITIALIZED:
        SendMessage(Hwnd, BFFM_SETSELECTION, Ord(True), integer(PMyData(lpData).IniPath));
      BFFM_SELCHANGED:
        begin
          SHGetPathFromIDList(PItemIDList(lParam), @PathName);
          SendMessage(hwnd, BFFM_SETSTATUSTEXT, 0, LongInt(PChar(@PathName)));
          if Assigned(PMyData(lpData).Proc) then
            SendMessage(hWnd, BFFM_ENABLEOK, 0, Ord(PMyData(lpData).Proc(PathName)))
          else if PMyData(lpData).FileName <> nil then
            SendMessage(hWnd, BFFM_ENABLEOK, 0, Ord(FileExists(IncludeTrailingPathDelimiter(PathName) + PMyData(lpData).FileName)))
          else
            SendMessage(hWnd, BFFM_ENABLEOK, 0, Ord(DirectoryExists(PathName)));
        end;
    end;
    Result := 0;
  end;

begin
  Result := False;
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then
  begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      RootItemIDList := nil;
      if Root <> '' then
      begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(GetActiveWindow, nil, POleStr(WideString(Root)), Dummy, RootItemIDList, Dummy);
      end;
      with BrowseInfo do
      begin
        hwndOwner := Owner;
        pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
        lpszTitle := PChar(Caption);
        ulFlags := BIFs;
        lpfn := @BrowseCallbackProc;
        Data.IniPath := PChar(Path);
        if FileName <> '' then
          Data.FileName := PChar(FileName)
        else
          Data.FileName := nil;
        Data.Proc := Callback;
        lParam := Integer(@Data);
      end;
      ItemIDList := ShBrowseForFolder(BrowseInfo);
      Result := ItemIDList <> nil;
      if Result then
      begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Path := IncludeTrailingPathDelimiter(StrPas(Buffer));
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;

function CallBack(const Path: string): boolean;
begin
  Result := DirectoryExists(Path);
end;

end.
