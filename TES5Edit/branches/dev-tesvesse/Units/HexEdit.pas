unit HexEdit;

//Copyright © 2006 Tomas Krysl (tk@@tkweb.eu)

interface

uses
  Windows, Messages, System.SysUtils, Classes, Graphics, Controls, ExtCtrls, StdCtrls, Forms;

type
  TEditorArea = (eaNone, eaAddress, eaDigits, eaText);

  TAreaDimensions = record
    Address, AddressOut,
    Digits, DigitsIn, DigitsOut,
    Text, TextIn,
    TotalHorz, TotalVert: Integer;
  end;

  TDisabledDrawStyle = (eddBright, eddGrayed, eddNormal);

  TEditorDrawStyle = (edAddress, edDigits, edText, edHorzLines, edInactiveCaret, edSeparators, edVertLines);
  TEditorDrawStyles = set of TEditorDrawStyle;

  TEditorPaintData = record
    Canvas: TCanvas;
    PaintRect: TRect;
    TopLine, BottomLine,
    LeftChar,
    CharWidth, CharHeight,
    CharSpacing: Integer;
    PaintAll,
    PaintColors,
    PaintSelection,
    CaretShown: Boolean;
  end;

  TEditorSelection = record
    Index, Digit: Integer;
  end;

  TEditorSelText = record
    AsBinaryRaw, AsBinaryMapped, AsDigits, AsDigitsByteAligned: string;
  end;

  TEditorState = (elCaretVisible, elCaretUpdate, elIgnoreNextChar, elModified, elMouseCapture, elOverwrite, elReadOnly);

  TEditorStates = set of TEditorState;

  TEditorColorScheme = (ecsNormal, ecsGrayed, ecsBright, ecsGrayScale);

const
  cAddressSizeMin = 2;
  cAddressSizeMax = 10;
  cAddressSizeDef = 8;

  cAreaSpacingMin = 1;
  cAreaSpacingMax = 20;
  cAreaSpacingDef = 1;

  cCharSpacingMin = 0;
  cCharSpacingMax = 100;
  cCharSpacingDef = 1;

  cDigitGroupingMin = 1;
  cDigitGroupingMax = 8;
  cDigitGroupingDef = 1;

  cLineHeightPercentMin = 10;
  cLineHeightPercentMax = 1000;
  cLineHeightPercentDef = 100;

  cUndoLimitMin = 100;
  cUndoLimitMax = 10000;
  cUndoLimitDef = 1000;

  cLineSizeMin = 1;
  cLineSizeMax = 128;
  cLineSizeDef = 16;

  cScrollSpeedMin = 50;
  cScrollSpeedMax = 1000;
  cScrollSpeedDef = 100;

  cFontSizeMin = 8;
  cFontSizeMax = 100;
  cFontSizeDef = 10;

  cAddressTextDef = clBlue;
  cAddressBkgndDef = $00F0F0F0;
  cBkGndDef = $00F0F0F0;
  cDigitTextEvenDef = clWindowText;
  cDigitTextOddDef = clWindowText;
  cDigitBkGndDef = $00F8F8F8;
  cHorzLinesDef = clWindowText;
  cInactiveCaretBkGndDef = clBlack;
  cInactiveCaretSelBkGndDef = clBlack;
  cInactiveCaretSelTextDef = clYellow;
  cInactiveCaretTextDef = clYellow;
  cLinesHighLightDef = clHighLightText;
  cSelBkGndDef = clGrayText;
  cSelBkGndFocusedDef = clHighlight;
  cSelTextDef = clHighlightText;
  cSelTextFocusedDef = clHighlightText;
  cSeparatorsDef = clWindowText;
  cTextTextDef = clWindowText;
  cTextBkgndDef = $00F0F0F0;
  cVertLinesDef = clWindowText;

  cAddressOffsetDef = 0;

  cDisabledDrawStyleDef = eddBright;

  cDrawStylesDef = [edAddress, edDigits, edText, edInactiveCaret, edSeparators];

  cAddressPrefixDef = ' ';

  cFontNameDef = 'Courier New';
  cFontStyleDef = [fsBold];

  cInvalidIndex = -1;

  cAddressCursorDef = crHandPoint;

  cHeight = 300;
  cWidth = 400;

  cBorderStyleDef = bsSingle;

type
  TCustomHexEditor = class;

  TChangeReason = (crCaretPos, crDeleteChar, crDeleteDigits, crDeleteString, crInsertChar, crInsertDigits, crInsertString);

  TUndoChangeEvent = procedure(Sender: TObject; ItemReason: TChangeReason) of object;

  TChangeItem = record
    Data: string;
    EditArea: TEditorArea;
    Group: Cardinal;
    GroupReason: TChangeReason;
    Inserted: Boolean;
    ItemReason: TChangeReason;
    SelEnd: TEditorSelection;
    SelStart: TEditorSelection;
  end;
  PChangeItem = ^TChangeItem;

  TChangeList = class(TList)
  private
    FEditor: TCustomHexEditor;
    FGroup: Cardinal;
    FGroupUseLock: Integer;
    FGroupReason: TChangeReason;
    FIndex: Integer;
    FModifiedIndex: Integer;
    FLimit: Integer;
    FRedoList: TChangeList;
    FOnChange: TUndoChangeEvent;
    function GetModified: Boolean;
    procedure SetLimit(Value: Integer);
    procedure SetModified(Value: Boolean);
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    constructor Create(AEditor: TCustomHexEditor; RedoList: TChangeList);
    procedure AddChange(ItemReason: TChangeReason; const Data: string = ''; Inserted: Boolean = True); virtual;
    procedure BeginGroup(GroupReason: TChangeReason); virtual;
    function CanPeek: Boolean;
    procedure Clear; override;
    procedure EndGroup; virtual;
    function PeekItem: PChangeItem;
    procedure PokeItem;
    procedure SetGroupData(Group: Integer; GroupReason: TChangeReason);
    property Limit: Integer read FLimit write SetLimit;
    property Modified: Boolean read GetModified write SetModified;
    property OnChange: TUndoChangeEvent read FOnChange write FOnChange;
  end;

  TEBytes = array[0..MaxInt div SizeOf(Byte) - 1] of Byte;
  PEBytes = ^TEBytes;

  TEditCharMapping = array of Char;
  PEditCharMapping = ^TEditCharMapping;

  TEditCommand = (ecLeft, ecRight, ecUp, ecDown,
                  ecLineStart, ecLineEnd,
                  ecPageUp, ecPageDown, ecPageLeft, ecPageRight, ecPageTop, ecPageBottom,
                  ecEditorTop, ecEditorBottom,
                  ecGotoXY,
                  ecSelLeft, ecSelRight, ecSelUp, ecSelDown,
                  ecSelLineStart, ecSelLineEnd,
                  ecSelPageUp, ecSelPageDown, ecSelPageLeft, ecSelPageRight, ecSelPageTop, ecSelPageBottom,
                  ecSelEditorTop, ecSelEditorBottom,
                  ecSelGotoXY,
                  ecScrollUp, ecScrollDown, ecScrollLeft, ecScrollRight, ecScrollCenter,
                  ecUndo, ecRedo, ecCopy, ecCut, ecPaste,
                  ecInsertChar, ecInsertDigits, ecInsertString,
                  ecDeleteLastChar, ecDeleteChar, ecDeleteBOL, ecDeleteEOL, ecDeleteLine,
                  ecSelectAll, ecClearAll, ecClearIndexSelection, ecClearSelection,
                  ecSearch, ecReplace,
                  ecInsertMode, ecOverwriteMode, ecToggleMode,
                  ecGotFocus, ecLostFocus);
  TEditKey = record
    Key: Word;
    Shift: TShiftState;
  end;
  TCommandAssignment = record
    Command: TEditCommand;
    Key: TEditKey;
  end;
  TEditKeyMapping = array of TCommandAssignment;

  TEditOption = (eoDropFiles, eoGroupUndo, eoUndoAfterSave);
  TEditOptions = set of TEditOption;

  TDropFilesEvent = procedure(Sender: TObject; X, Y: integer; Files: TStrings) of object;

  TReplaceAction = (eraCancel, eraYes, eraNo, eraAll);
  TReplaceTextEvent = procedure(Sender: TObject; const TextToFind, TextToReplace: string; var Action: TReplaceAction) of object;

  TDataSize = record
    Data: Pointer;
    Size: Integer;
  end;

  TSearchError = (eseOk, eseNoDigitsFind, eseNoDigitsReplace, eseNoMatch);
  TSearchOption = (esoAll, esoBackwards, esoEntireScope, esoFirstSearch, esoMatchCase, esoPrompt, esoSelectedOnly, esoTreatAsDigits, esoWereDigits);
  TSearchOptions = set of TSearchOption;
  TSearchData = record
    ErrorReason: TSearchError;
    Options: TSearchOptions;
    SelStart, SelEnd: Integer;
    TextToFind, TextToReplace: string;
  end;
  PSearchData = ^TSearchData;

  TCustomHexEditor = class(TCustomControl)
  private
    FBorderStyle: TBorderStyle;
    FAddressCursor: TCursor;
    FAddressOffset: Integer;
    FAddressPrefix: string;
    FAddressSize: Integer;
    FAreaSpacing: Integer;
    FBuffer: PEBytes;
    FCharHeight: Integer;
    FCharMapping: TEditCharMapping;
    FCharSpacing: Integer;
    FCharWidth: Integer;
    FClipboardFormat: Word;
    FDigitGrouping: Integer;
    FDisabledDrawStyle: TDisabledDrawStyle;
    FDrawStyles: TEditorDrawStyles;
    FEditArea: TEditorArea;
    FKeyMapping: TEditKeyMapping;
    FLeftChar: Integer;
    FLineHeightPercent: Integer;
    FLineSize: Integer;
    FMouseWheelAccumulator: Integer;
    FOptions: TEditOptions;
    FRedoList: TChangeList;
    FScrollBars: System.UITypes.TScrollStyle;
    FScrollDeltaX: Integer;
    FScrollDeltaY: Integer;
    FScrollSpeed: Cardinal;
    FScrollTimer: TTimer;
    FSelEnd, FSelStart: TEditorSelection;
    FSize: Integer;
    FStates: TEditorStates;
    FTopLine: Integer;
    FTotalCharSpacing: Integer;
    FUndoList: TChangeList;
    FOnChange: TNotifyEvent;
    FOnDropFiles: TDropFilesEvent;
    FOnReplaceText: TReplaceTextEvent;
    function GetCommandKey(Index: TEditCommand): TEditKey;
    function GetCaretVisible: Boolean;
    function GetData: TDataSize;
    function GetEmpty: Boolean;
    function GetFirstVisibleIndex: Integer;
    function GetInsertMode: Boolean;
    function GetLastVisibleIndex: Integer;
    function GetLineCount: Integer;
    function GetLines(Index: Integer): TDataSize;
    function GetModified: Boolean;
    function GetReadOnly: Boolean;
    function GetSelLength: TEditorSelection;
    function GetSelText: TEditorSelText;
    function GetUndoLimit: Integer;
    function IsAddressPrefixStored: Boolean;
    function IsDrawStylesStored: Boolean;
    function IsOptionsStored: Boolean;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure ScrollTimerHandler(Sender: TObject);
    procedure SetAddressCursor(Value: TCursor);
    procedure SetAddressOffset(Value: Integer);
    procedure SetAddressPrefix(const Value: string);
    procedure SetAddressSize(Value: Integer);
    procedure SetAreaSpacing(Value: Integer);
    procedure SetCharSpacing(Value: Integer);
    procedure SetCommandKey(Index: TEditCommand; Value: TEditKey);
    procedure SetData(Value: TDataSize);
    procedure SetDigitGrouping(Value: Integer);
    procedure SetDisabledDrawStyle(Value: TDisabledDrawStyle);
    procedure SetDrawStyles(const Value: TEditorDrawStyles);
    procedure SetEditArea(Value: TEditorArea);
    procedure SetLeftChar(Value: Integer);
    procedure SetLineHeightPercent(Value: Integer);
    procedure SetLines(Index: Integer; const Value: TDataSize);
    procedure SetLineSize(Value: Integer);
    procedure SetModified(Value: Boolean);
    procedure SetOptions(const Value: TEditOptions);
    procedure SetReadOnly(Value: Boolean);
    procedure SetScrollBars(Value: System.UITypes.TScrollStyle);
    procedure SetScrollSpeed(Value: Cardinal);
    procedure SetSelEnd(Value: TEditorSelection);
    procedure SetSelLength(Value: TEditorSelection);
    procedure SetSelStart(Value: TEditorSelection);
    procedure SetTopLine(Value: Integer);
    procedure SetUndoLimit(Value: Integer);
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure WMDropFiles(var Msg: TMessage); message WM_DROPFILES;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg: TWMNoParams); message WM_GETDLGCODE;
    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
  protected
    procedure AddUndoCaretPos(Force: Boolean = True);
    procedure AddUndoByte(ItemReason: TChangeReason; Data: Byte; Inserted: Boolean = True);
    procedure AddUndoBytes(ItemReason: TChangeReason; Data: PEBytes; Length: Integer; Inserted: Boolean = True);
    procedure AddUndoString(ItemReason: TChangeReason; const S: string; Inserted: Boolean = True);
    procedure BeginUndoGroup(GroupReason: TChangeReason);
    procedure BufferChanged;
    function CanScroll(Command: TEditCommand): Boolean; virtual;
    procedure ClearChar(At: Integer);
    procedure ClearDigitSelection;
    procedure ClearString(At, Size: Integer);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure DoChange; virtual;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;
    procedure EditAreaChanged; virtual;
    procedure EndUndoGroup;
    procedure FontChange(Sender: TObject); virtual;
    function GetPageHorz: Integer; virtual;
    function HasFocus: Boolean; virtual;
    procedure HideEditorCaret; virtual;
    procedure InsertChar(At: Integer; Value: Byte);
    procedure InsertString(At: Integer; Value: String; Size: Integer);
    function InternalGetSelAvail: Boolean;
    procedure InternalMoveLeft; virtual;
    procedure InternalMoveRight; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure ModifyScrollBar(ScrollBar, ScrollCode, Delta: Integer; UpdateNeeded: Boolean);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure PaintToCanvas(ACanvas: TCanvas);
    procedure PaintLines(const Data: TEditorPaintData); virtual;
    procedure SafeSetFocus;
    procedure SelectionChanged(StartEqualEnd: Boolean; ScrollToView: Boolean = True);
    procedure ScrollBy(HChars, VChars: Integer; UpdateNeeded: Boolean);
    procedure ScrollTo(Point: TPoint; Timed, AlwaysScroll: Boolean); virtual;
    function SetMouseCursor(X, Y: Integer): Boolean;
    procedure ShowEditorCaret; virtual;
    procedure UndoChange(Sender: TObject; ItemReason: TChangeReason);
    procedure UpdateEditorCaret(Recreate: Boolean = False); virtual;
    procedure UpdateCharMetrics; virtual;
    procedure UpdateMouseCursor; virtual;
    procedure UpdateScrollRange; virtual;
    procedure UpdateSelEnd(Point: TPoint; ClipToClient: Boolean); virtual;
    property Buffer: PEBytes read FBuffer write FBuffer;
    property RedoList: TChangeList read FRedoList;
    property Size: Integer read FSize write FSize;
    property States: TEditorStates read FStates write FStates;
    property UndoList: TChangeList read FUndoList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function CaretInView: Boolean;
    procedure Clear;
    procedure ClearUndo;
    function CommandEnabled(Command: TEditCommand): Boolean; virtual;
    function ExecuteCommand(Command: TEditCommand; Data: Pointer = nil): Boolean; virtual;
    function GetAreaDimensions: TAreaDimensions; virtual;
    function GetCharMapping: TEditCharMapping;
    function GetClientHeightChars: Integer; virtual;
    function GetClientWidthChars: Integer; virtual;
    function GetKeyMapping: TEditKeyMapping;
    function GetModifiedClientRect: TRect; virtual;
    function GetMaxLeftChar(Extent: Integer = 0): Integer; virtual;
    function GetMaxTopLine(Extent: Integer = 0): Integer; virtual;
    function GetRealSelEnd: TEditorSelection;
    function GetRealSelStart: TEditorSelection;
    procedure LoadFromFile(const FileName: TFileName);
    procedure LoadFromStream(Stream: TStream);
    procedure PaintToCanvasEx(ACanvas: TCanvas; ARect: TRect; ALeftChar, ATopLine: Integer);
    function PointToSel(P: TPoint; OutOfArea: Boolean; var Area: TEditorArea): TEditorSelection; virtual;
    procedure SaveToFile(const FileName: TFileName);
    procedure SaveToStream(Stream: TStream);
    function SelAvail: Boolean;
    function SelectionValid(Value: TEditorSelection; Area: TEditorArea): Boolean; virtual;
    function SelToPoint(Value: TEditorSelection; Area: TEditorArea): TPoint; virtual;
    procedure SetCharMapping(const Value: TEditCharMapping);
    procedure SetKeyMapping(const Value: TEditKeyMapping);
    procedure UpdateSize;
    procedure ValidateSelection(var Value: TEditorSelection; Area: TEditorArea); virtual;
    property AddressCursor: TCursor read FAddressCursor write SetAddressCursor default cAddressCursorDef;
    property AddressOffset: Integer read FAddressOffset write SetAddressOffset default cAddressOffsetDef;
    property AddressPrefix: string read FAddressPrefix write SetAddressPrefix stored IsAddressPrefixStored;
    property AddressSize: Integer read FAddressSize write SetAddressSize default cAddressSizeDef;
    property AreaSpacing: Integer read FAreaSpacing write SetAreaSpacing default cAreaSpacingDef;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default cBorderStyleDef;
    property CaretPos: TEditorSelection read FSelEnd;
    property CaretVisible: Boolean read GetCaretVisible;
    property CharWidth: Integer read FCharWidth;
    property CharSpacing: Integer read FCharSpacing write SetCharSpacing default cCharSpacingDef;
    property CharHeight: Integer read FCharHeight;
    property ClipboardFormat: Word read FClipboardFormat;
    property CommandKey[Index: TEditCommand]: TEditKey read GetCommandKey write SetCommandKey;
    property Data: TDataSize read GetData write SetData;
    property DigitGrouping: Integer read FDigitGrouping write SetDigitGrouping default cDigitGroupingDef;
    property DisabledDrawStyle: TDisabledDrawStyle read FDisabledDrawStyle write SetDisabledDrawStyle default cDisabledDrawStyleDef;
    property DrawStyles: TEditorDrawStyles read FDrawStyles write SetDrawStyles stored IsDrawStylesStored;
    property EditArea: TEditorArea read FEditArea write SetEditArea default eaDigits;
    property Empty: Boolean read GetEmpty;
    property FirstVisibleIndex: Integer read GetFirstVisibleIndex;
    property InsertMode: Boolean read GetInsertMode;
    property LastVisibleIndex: Integer read GetLastVisibleIndex;
    property LeftChar: Integer read FLeftChar write SetLeftChar;
    property LineCount: Integer read GetLineCount;
    property LineHeightPercent: Integer read FLineHeightPercent write SetLineHeightPercent default cLineHeightPercentDef;
    property Lines[Index: Integer]: TDataSize read GetLines write SetLines;
    property LineSize: Integer read FLineSize write SetLineSize default cLineSizeDef;
    property Modified: Boolean read GetModified write SetModified;
    property Options: TEditOptions read FOptions write SetOptions stored IsOptionsStored;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ScrollBars: System.UITypes.TScrollStyle read FScrollBars write SetScrollBars default ssBoth;
    property ScrollSpeed: Cardinal read FScrollSpeed write SetScrollSpeed default cScrollSpeedDef;
    property SelEnd: TEditorSelection read FSelEnd write SetSelEnd;
    property SelLength: TEditorSelection read GetSelLength write SetSelLength;
    property SelStart: TEditorSelection read FSelStart write SetSelStart;
    property SelText: TEditorSelText read GetSelText;
    property TopLine: Integer read FTopLine write SetTopLine;
    property UndoLimit: Integer read GetUndoLimit write SetUndoLimit default cUndoLimitDef;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDropFiles: TDropFilesEvent read FOnDropFiles write FOnDropFiles;
    property OnReplaceText: TReplaceTextEvent read FOnReplaceText write FOnReplaceText;
  end;

  THexEditor = class(TCustomHexEditor)
  published
    property AddressCursor;
    property AddressOffset;
    property AddressPrefix;
    property AddressSize;
    property Align;
    property Anchors;
    property BorderStyle;
    property BorderWidth;
    property CharSpacing;
    property Constraints;
    property Ctl3D;
    property DigitGrouping;
    property DisabledDrawStyle;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DrawStyles;
    property EditArea;
    property Enabled;
    property Font;
    property Height default cHeight;
    property InsertMode;
    property LineHeightPercent;
    property LineSize;
    property Options;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ScrollBars;
    property ScrollSpeed;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property UndoLimit;
    property Visible;
    property Width default cWidth;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnDropFiles;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnReplaceText;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

function MakeSelection(Index, Digit: Integer): TEditorSelection;
function DigitToBin(Value: Char): Integer;
function DigitsToBinStr(var S: string; Convert: Boolean = True): Boolean;
function BinStrToBinary(const S: string): string;
function BinaryToDigits(Buffer: PEBytes; SelStart, SelEnd: TEditorSelection): string;
function BinaryToText(Buffer: PEBytes; SelStart, SelEnd: Integer; CharMapping: PEditCharMapping): string;
function ReplaceDigit(Value, Digit, Pos: Integer): Integer;

implementation

uses
  Themes, Math, ShellApi, ClipBrd, Types;

const
  cFmtText = '%.2x';
  cBase = 16;
  cDigitCount = 2;

function MakeSelection(Index, Digit: Integer): TEditorSelection;
begin
  Result.Index := Index;
  Result.Digit := Digit;
end;

function DigitToBin(Value: Char): Integer;
begin
  if (Value >= 'a') and (Value <= 'f') then
    Result := Ord(Value) - Ord('a') + 10
  else
    if (Value >= 'A') and (Value <= 'F') then
      Result := Ord(Value) - Ord('A') + 10
    else
      if (Value >= '0') and (Value <= '9') then
        Result := Ord(Value) - Ord('0')
      else
        Result := -1;
end;

function CharInSetEx(AChar: AnsiChar; const ASet: TSysCharSet): Boolean;
begin
  Result := AChar in ASet;
end;

function DigitsToBinStr(var S: string; Convert: Boolean = True): Boolean;
var
  i, j, k: Integer;
  T: string;
begin
  // check and convert text characters to hex values 0..15
  Result := True;
  if Convert then
    SetLength(T, Length(S));
  j := 0;
  for i := 1 to Length(S) do
    if not CharInSet(S[i], [#9, #32]) then
    begin
      k := DigitToBin(S[i]);
      if k >= 0 then
      begin
        if Convert then
        begin
          Inc(j);
          T[j] := Char(k)
        end;
      end
      else
      begin
        Result := False;
        Break;
      end;
    end;
  if Result and Convert then
  begin
    SetLength(T, j);
    S := T;
  end;
end;

function DivUp(Dividend, Divisor: Integer): Integer;
begin
  if Divisor = 0 then
    Result := 0
  else
    if Dividend mod Divisor > 0 then
      Result := Dividend div Divisor + 1
    else
      Result := Dividend div Divisor;
end;

function BinStrToBinary(const S: string): string;
var
  i, j, l: Integer;
  B1, B2: Byte;
begin
  l := Length(S);
  Result := '';
  if l > 0 then
  begin
    SetLength(Result, DivUp(l, 2));
    if l = 1 then
      Result := S
    else
    begin
      j := 1;
      for i := 1 to Length(Result) do
      begin
        B1 := Byte(S[j]);
        Inc(j);
        if j <= l then
        begin
          B2 := Byte(S[j]);
          Inc(j);
        end
        else
          B2 := 0;
        Result[i] := Char(B1 shl 4 + B2);
      end;
    end;
  end;
end;

function BinaryToDigits(Buffer: PEBytes; SelStart, SelEnd: TEditorSelection): string;
var
  i, j: Integer;
  S: string;
begin
  Result := '';
  S := '%s' + cFmtText;
  for i := SelStart.Index to SelEnd.Index do
  begin
    Result := Format(S, [Result, Buffer[i]]);
    if i = SelStart.Index then
      for j := 0 to SelStart.Digit - 1 do
        Delete(Result, 1, 1);
    if i = SelEnd.Index then
      for j := SelEnd.Digit to cDigitCount - 1 do
        Delete(Result, Length(Result), 1);
  end;
end;

function BinaryToText(Buffer: PEBytes; SelStart, SelEnd: Integer; CharMapping: PEditCharMapping): string;
var
  i: Integer;
begin
  if SelEnd > SelStart then
  begin
    SetLength(Result, SelEnd - SelStart);
    System.Move(Buffer[SelStart], Result[1], SelEnd - SelStart);
    if CharMapping <> nil then
      for i := 1 to Length(Result) do
        Result[i] := CharMapping^[Byte(Result[i])];
  end
  else
    Result := '';
end;

function ReplaceDigit(Value, Digit, Pos: Integer): Integer;
var
  i, Mask, O: Integer;
begin
  O := 1;
  for i := Pos to cDigitCount - 2 do
    O := O * cBase;
  Mask := cBase - 1;
  Result := (((Value div O) and not Mask) + (Digit and Mask)) * O + Value mod O;
end;

function OppositeReason(ItemReason: TChangeReason): TChangeReason;
begin
  case ItemReason of
    crDeleteChar:
      Result := crInsertChar;
    crDeleteDigits:
      Result := crInsertDigits;
    crDeleteString:
      Result := crInsertString;
    crInsertChar:
      Result := crDeleteChar;
    crInsertDigits:
      Result := crDeleteDigits;
    crInsertString:
      Result := crDeleteString;
  else
    Result := ItemReason;
  end;
end;

{ TChangeList }
constructor TChangeList.Create(AEditor: TCustomHexEditor; RedoList: TChangeList);
begin
  inherited Create;
  FEditor := AEditor;
  FGroupUseLock := 0;
  FLimit := cUndoLimitDef;
  FIndex := -1;
  FModifiedIndex := FIndex;
  FRedoList := RedoList;
  FOnChange := nil;
end;

procedure TChangeList.AddChange(ItemReason: TChangeReason; const Data: string; Inserted: Boolean);
var
  P: PChangeItem;
begin
  // don't allow succesive crCaretPos
  if (ItemReason = crCaretPos) and not Inserted and (FIndex >= 0) and (PChangeItem(Items[FIndex]).ItemReason = crCaretPos) then
    Exit;
  if FIndex < (FLimit - 1) then
  begin
    if FIndex < (Count - 1) then
      Inc(FIndex)
    else
      FIndex := Add(New(PChangeItem));
    P := Items[FIndex];
    if FGroupUseLock > 0 then
    begin
      P.Group := FGroup;
      P.GroupReason := FGroupReason;
    end
    else
    begin
      P.Group := 0;
      P.GroupReason := ItemReason;
    end;
    P.ItemReason := ItemReason;
    P.EditArea := FEditor.EditArea;
    P.SelEnd := FEditor.SelEnd;
    P.SelStart := FEditor.SelStart;
    P.Data := Data;
    P.Inserted := Inserted;
    if FRedoList <> nil then
      FRedoList.Clear;
    if Assigned(FOnChange) then
      FOnChange(Self, ItemReason);
  end;
end;

procedure TChangeList.BeginGroup(GroupReason: TChangeReason);
begin
  if FGroupUseLock = 0 then
  begin
    FGroupReason := GroupReason;
    Inc(FGroup);
    if FGroup = 0 then
      Inc(FGroup);
  end;
  Inc(FGroupUseLock);
end;

function TChangeList.CanPeek: Boolean;
begin
  Result := FIndex >= 0;
end;

procedure TChangeList.Clear;
begin
  inherited;
  FGroupUseLock := 0;
  FIndex := -1;
  FModifiedIndex := FIndex;
end;

procedure TChangeList.EndGroup;
begin
  if FGroupUseLock > 0 then
    Dec(FGroupUseLock);
end;

function TChangeList.GetModified: Boolean;

  function CaretPosOnly: Boolean;
  var
    i: Integer;
  begin
    Result := True;
    for i := FModifiedIndex + 1 to FIndex do
      if PChangeItem(Items[i]).ItemReason <> crCaretPos then
      begin
        Result := False;
        Exit;
      end;
  end;
begin
  Result := (FIndex > FModifiedIndex) and not CaretPosOnly;
end;

procedure TChangeList.Notify(Ptr: Pointer; Action: TListNotification);
var
  P: PChangeItem;
begin
  case Action of
    lnDeleted:
      if Ptr <> nil then
      begin
        P := Ptr;
        Dispose(P);
      end;
  end;
end;

function TChangeList.PeekItem: PChangeItem;
begin
  if CanPeek then
  begin
    Result := Items[FIndex];
    Dec(FIndex);
  end
  else
    Result := nil;
end;

procedure TChangeList.PokeItem;
begin
  if FIndex < Count - 1 then
    Inc(FIndex);
end;

procedure TChangeList.SetGroupData(Group: Integer; GroupReason: TChangeReason);
begin
  FGroup := Group;
  FGroupReason := GroupReason;
  FGroupUseLock := 1;
end;

procedure Exchange(var Value1, Value2: Integer);
var
  Tmp: Integer;
begin
  Tmp := Value1;
  Value1 := Value2;
  Value2 := Tmp;
end;

function MinMax(Value, Min, Max: Integer): Integer;
begin
  if Max < Min then
    Exchange(Min, Max);
  if Value <= Max then
    if Value >= Min then
      Result := Value
    else
      Result := Min
  else
    Result := Max;
end;

procedure TChangeList.SetLimit(Value: Integer);
begin
  if Value <> FLimit then
  begin
    FLimit := MinMax(Value, cUndoLimitMin, cUndoLimitMax);
    while Count > FLimit do
      Delete(0);
    FIndex := Min(FIndex, FLimit - 1);
  end;
end;

procedure TChangeList.SetModified(Value: Boolean);
begin
  if not Value then
    FModifiedIndex := FIndex;
end;

function DefaultCharMapping: TEditCharMapping;
var
  i: Integer;
begin
  SetLength(Result, 256);
  for i := 0 to Length(Result) - 1 do
    if (i < $20) or (i >= $80) then
      Result[i] := '.'
    else
      Result[i] := Char(i);
end;

function CreateDefaultKeyMapping: TEditKeyMapping;

  procedure AddKey(Command: TEditCommand; Key: Word; Shift: TShiftState);
  var
    i: Integer;
  begin
    i := Length(Result);
    SetLength(Result, i + 1);
    Result[i].Command := Command;
    Result[i].Key.Key := Key;
    Result[i].Key.Shift := Shift;
  end;
begin
  AddKey(ecLeft, VK_LEFT, []);
  AddKey(ecRight, VK_RIGHT, []);
  AddKey(ecRight, VK_RETURN, []);
  AddKey(ecUp, VK_UP, []);
  AddKey(ecDown, VK_DOWN, []);
  AddKey(ecLineStart, VK_HOME, []);
  AddKey(ecLineEnd, VK_END, []);
  AddKey(ecPageUp, VK_PRIOR, []);
  AddKey(ecPageDown, VK_NEXT, []);
  AddKey(ecPageLeft, VK_LEFT, [ssCtrl, ssAlt]);
  AddKey(ecPageRight, VK_RIGHT, [ssCtrl, ssAlt]);
  AddKey(ecPageTop, VK_PRIOR, [ssCtrl]);
  AddKey(ecPageBottom, VK_NEXT, [ssCtrl]);
  AddKey(ecEditorTop, VK_HOME, [ssCtrl]);
  AddKey(ecEditorBottom, VK_END, [ssCtrl]);
  AddKey(ecSelLeft, VK_LEFT, [ssShift]);
  AddKey(ecSelRight, VK_RIGHT, [ssShift]);
  AddKey(ecSelUp, VK_UP, [ssShift]);
  AddKey(ecSelDown, VK_DOWN, [ssShift]);
  AddKey(ecSelLineStart, VK_HOME, [ssShift]);
  AddKey(ecSelLineEnd, VK_END, [ssShift]);
  AddKey(ecSelPageUp, VK_PRIOR, [ssShift]);
  AddKey(ecSelPageDown, VK_NEXT, [ssShift]);
  AddKey(ecSelPageLeft, VK_LEFT, [ssShift, ssCtrl, ssAlt]);
  AddKey(ecSelPageRight, VK_RIGHT, [ssShift, ssCtrl, ssAlt]);
  AddKey(ecSelPageTop, VK_PRIOR, [ssShift, ssCtrl]);
  AddKey(ecSelPageBottom, VK_NEXT, [ssShift, ssCtrl]);
  AddKey(ecSelEditorTop, VK_HOME, [ssShift, ssCtrl]);
  AddKey(ecSelEditorBottom, VK_END, [ssShift, ssCtrl]);
  AddKey(ecScrollUp, VK_UP, [ssCtrl]);
  AddKey(ecScrollDown, VK_DOWN, [ssCtrl]);
  AddKey(ecScrollLeft, VK_LEFT, [ssCtrl]);
  AddKey(ecScrollRight, VK_RIGHT, [ssCtrl]);
  AddKey(ecScrollCenter, VK_RETURN, [ssCtrl]);
  AddKey(ecUndo, ord('Z'), [ssCtrl]);
  AddKey(ecUndo, VK_BACK, [ssAlt]);
  AddKey(ecRedo, ord('Z'), [ssShift, ssCtrl]);
  AddKey(ecRedo, VK_BACK, [ssShift, ssAlt]);
  AddKey(ecCopy, ord('C'), [ssCtrl]);
  AddKey(ecCopy, VK_INSERT, [ssCtrl]);
  AddKey(ecCut, ord('X'), [ssCtrl]);
  AddKey(ecCut, VK_DELETE, [ssShift]);
  AddKey(ecPaste, ord('V'), [ssCtrl]);
  AddKey(ecPaste, VK_INSERT, [ssShift]);
  AddKey(ecDeleteLastChar, VK_BACK, []);
  AddKey(ecDeleteLastChar, VK_BACK, [ssShift]);
  AddKey(ecDeleteChar, VK_DELETE, []);
  AddKey(ecDeleteEOL, ord('Y'), [ssCtrl,ssShift]);
  AddKey(ecDeleteLine, ord('Y'), [ssCtrl]);
  AddKey(ecSelectAll, ord('A'), [ssCtrl]);
  AddKey(ecToggleMode, VK_INSERT, []);
end;

{ TCustomHexEditor }
constructor TCustomHexEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := clWindow;
  ControlStyle := [csOpaque, csClickEvents, csDoubleClicks, csCaptureMouse];
  Font.Name := cFontNameDef;
  Font.Style := cFontStyleDef;
  Font.Size := cFontSizeDef;
  Font.Pitch := fpFixed;
  Font.OnChange := FontChange;
  Height := cHeight;
  ParentColor := False;
  ParentFont := False;
  TabStop := True;
  Width := cWidth;
  FAddressCursor := cAddressCursorDef;
  FAddressOffset := cAddressOffsetDef;
  FAddressPrefix := cAddressPrefixDef;
  FAddressSize := cAddressSizeDef;
  FAreaSpacing := cAreaSpacingDef;
  FBuffer := nil;
  FClipBoardFormat := RegisterClipboardFormat('Any binary data');
  FCharHeight := 8;
  FCharMapping := DefaultCharMapping;
  FCharSpacing := cCharSpacingDef;
  FCharWidth := 6;
  FDigitGrouping := cDigitGroupingDef;
  FDisabledDrawStyle := cDisabledDrawStyleDef;
  FDrawStyles := cDrawStylesDef;
  FEditArea := eaDigits;
  FLeftChar := 0;
  FLineHeightPercent := cLineHeightPercentDef;
  FLineSize := cLineSizeDef;
  FMouseWheelAccumulator := 0;
  FOptions := [eoGroupUndo];
  FKeyMapping := CreateDefaultKeyMapping;
  FRedoList := TChangeList.Create(Self, nil);
  FScrollBars := ssBoth;
  FScrollSpeed := cScrollSpeedDef;
  FScrollTimer := TTimer.Create(Self);
  FScrollTimer.Enabled := False;
  FScrollTimer.Interval := FScrollSpeed;
  FScrollTimer.OnTimer := ScrollTimerHandler;
  FSelStart := MakeSelection(0, 0);
  FSelEnd := MakeSelection(0, 0);
  FStates := [elOverwrite];
  FTopLine := 0;
  FTotalCharSpacing := 0;
  FUndoList := TChangeList.Create(Self, FRedoList);
  FUndoList.OnChange := UndoChange;
  FOnChange := nil;
  FOnReplaceText := nil;
  UpdateCharMetrics;
end;

destructor TCustomHexEditor.Destroy;
begin
  inherited;
  FOnChange := nil;
  FUndoList.Free;
  FRedoList.Free;
  FreeMem(FBuffer);
  FBuffer := nil;
end;

procedure TCustomHexEditor.AddUndoCaretPos(Force: Boolean);
begin
  FUndoList.AddChange(crCaretPos, '', Force);
end;

procedure TCustomHexEditor.AddUndoByte(ItemReason: TChangeReason; Data: Byte; Inserted: Boolean = True);
var
  S: string;
begin
  SetLength(S, 1);
  S[1] := Char(Data);
  FUndoList.AddChange(ItemReason, S, Inserted);
end;

procedure TCustomHexEditor.AddUndoBytes(ItemReason: TChangeReason; Data: PEBytes; Length: Integer; Inserted: Boolean = True);
var
  S: string;
begin
  if Length > 0 then
  begin
    SetLength(S, Length);
    Move(Data^, S[1], Length);
    FUndoList.AddChange(ItemReason, S, Inserted);
  end;
end;

procedure TCustomHexEditor.AddUndoString(ItemReason: TChangeReason; const S: string; Inserted: Boolean = True);
begin
  if S <> '' then
    FUndoList.AddChange(ItemReason, S, Inserted);
end;

procedure TCustomHexEditor.Assign(Source: TPersistent);
begin
  if Source is TCustomHexEditor then
    with Source as TCustomHexEditor do
    begin
      Self.AddressCursor := AddressCursor;
      Self.AddressPrefix := AddressPrefix;
      Self.AddressSize := AddressSize;
      Self.Align := Align;
      Self.Anchors := Anchors;
      Self.AutoSize := AutoSize;
      Self.BiDiMode := BiDiMode;
      Self.BorderStyle := BorderStyle;
      Self.BorderWidth := BorderWidth;
      Self.CharSpacing := CharSpacing;
      Self.Color := Color;
      Self.Constraints.Assign(Constraints);
      Self.Ctl3D := Ctl3D;
      Self.Data := Data;
      Self.DigitGrouping := DigitGrouping;
      Self.DisabledDrawStyle := DisabledDrawStyle;
      Self.DragCursor := DragCursor;
      Self.DragKind := DragKind;
      Self.DragMode := DragMode;
      Self.DrawStyles := DrawStyles;
      Self.EditArea := EditArea;
      Self.Enabled := Enabled;
      Self.Font := Font;
      Self.ImeMode := ImeMode;
      Self.ImeName := ImeName;
      Self.LineHeightPercent := LineHeightPercent;
      Self.LineSize := LineSize;
      Self.Modified := False;
      Self.Options := Options;
      Self.ParentBiDiMode := ParentBiDiMode;
      Self.ParentColor := ParentColor;
      Self.ParentCtl3D := ParentCtl3D;
      Self.ParentFont := ParentFont;
      Self.ParentShowHint := ParentShowHint;
      Self.PopupMenu := PopupMenu;
      Self.ScrollBars := ScrollBars;
      Self.SelEnd := SelEnd;
      Self.SelStart := SelStart;
      Self.SetCharMapping(GetCharMapping);
      Self.SetKeyMapping(GetKeyMapping);
      Self.ShowHint := ShowHint;
      Self.TabOrder := TabOrder;
      Self.TabStop := TabStop;
      Self.Visible := Visible;
    end
    else
      inherited;
end;

procedure TCustomHexEditor.BeginUndoGroup(GroupReason: TChangeReason);
begin
  FUndoList.BeginGroup(GroupReason);
end;

procedure TCustomHexEditor.BufferChanged;
begin
  FUndoList.Clear;
  FRedoList.Clear;
  UpdateScrollRange;
  SelectionChanged(False);
  DoChange;
end;

function TCustomHexEditor.CanScroll(Command: TEditCommand): Boolean;
var
  XMax, YMax: Integer;
  P: TPoint;
  AD: TAreaDimensions;
begin
  AD := GetAreaDimensions;
  XMax := GetMaxLeftChar(AD.TotalHorz);
  YMax := GetMaxTopLine(AD.TotalVert);
  case Command of
    ecScrollUp:
      Result := FTopLine > 0;
    ecScrollDown:
      Result := FTopLine < YMax;
    ecScrollLeft:
      Result := FLeftChar > 0;
    ecScrollRight:
      Result := FLeftChar < XMax;
    ecScrollCenter:
      begin
        P := SelToPoint(FSelEnd, FEditArea);
        P.X := P.X - ClientWidth div 2;
        P.Y := P.Y - ClientHeight div 2;
        Result := (FLeftChar > 0) and (P.X < 0) or (FLeftChar < XMax) and (P.X > FCharWidth) or
          (FTopLine > 0) and (P.Y < 0) or (FTopLine < YMax) and (P.Y > FCharHeight);
      end;
    else
      Result := False;
  end;
end;

function TCustomHexEditor.CaretInView: Boolean;
begin
  Result := PtInRect(GetModifiedClientRect, SelToPoint(FSelEnd, FEditArea));
end;

procedure TCustomHexEditor.Clear;
begin
  if FBuffer <> nil then
  begin
    FreeMem(FBuffer);
    FBuffer := nil;
    FSize := 0;
    BufferChanged;
  end;
end;

procedure TCustomHexEditor.ClearChar(At: Integer);
begin
  ClearString(At, 1);
end;

procedure TCustomHexEditor.ClearDigitSelection;
begin
  FSelStart.Digit := 0;
  FSelEnd.Digit := 0;
end;

procedure TCustomHexEditor.ClearString(At, Size: Integer);
begin
  if (FBuffer <> nil) and (Size > 0) and (At >= 0) and (At + Size <= FSize) then
  begin
    Move(FBuffer[At + Size], FBuffer[At], (FSize - At - Size) * SizeOf(Byte));
    Dec(FSize, Size);
    ReallocMem(FBuffer, FSize);
    UpdateScrollRange;
    Invalidate;
  end;
end;

procedure TCustomHexEditor.ClearUndo;
begin
  FUndoList.Clear;
  FRedoList.Clear;
end;

procedure TCustomHexEditor.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  UpdateEditorCaret;
  Invalidate;
end;

function TCustomHexEditor.CommandEnabled(Command: TEditCommand): Boolean;
var
  L: TEditorSelection;
begin
  if Enabled and Visible and not (csDesigning in ComponentState) then
  begin
    L := SelLength;
    case Command of
      // movement commands
      ecLeft, ecSelLeft:
        Result := (FSelEnd.Index > 0) or (FEditArea = eaDigits) and (FSelEnd.Digit > 0);
      ecRight, ecSelRight:
        Result := (FEditArea <> eaNone) and (FSelEnd.Index < FSize);
      ecUp, ecSelUp:
        Result := FSelEnd.Index >= FLineSize;
      ecDown, ecSelDown:
        Result := (FEditArea <> eaNone) and (FSelEnd.Index < FSize);
      ecLineStart, ecSelLineStart:
        Result := (FEditArea <> eaNone) and (FSelEnd.Index mod FLineSize > 0);
      ecLineEnd, ecSelLineEnd:
        Result := (FEditArea <> eaNone) and (FSelEnd.Index mod FLineSize < Min(FLineSize - 1, FSize));
      ecPageUp, ecSelPageUp:
        Result := FSelEnd.Index >= FlineSize;
      ecPageDown, ecSelPageDown:
        Result := (FEditArea <> eaNone) and (FSelEnd.Index < FSize div FLineSize * FLineSize);
      ecPageLeft, ecSelPageLeft:
        Result := (FEditArea <> eaNone) and (GetPageHorz > 0) and (FSelEnd.Index mod FLineSize > 0);
      ecPageRight, ecSelPageRight:
        Result := (FEditArea <> eaNone) and (GetPageHorz > 0) and (FSelEnd.Index mod FLineSize < Min(FLineSize - 1, FSize));
      ecPageTop, ecSelPageTop:
        Result := (FEditArea <> eaNone) and (FSelEnd.Index > 0) and (SelToPoint(MakeSelection(FSelEnd.Index, 0), FEditArea).Y div FCharHeight <> 0);
      ecPageBottom, ecSelPageBottom:
        Result := (FEditArea <> eaNone) and (FSelEnd.Index < FSize) and ((ClientHeight - SelToPoint(MakeSelection(FSelEnd.Index, 0), FEditArea).Y) div FCharHeight - 1 <> 0);
      ecEditorTop, ecSelEditorTop:
        Result := FSelEnd.Index > 0;
      ecEditorBottom, ecSelEditorBottom:
        Result := (FEditArea <> eaNone) and (FSelEnd.Index < FSize);
      ecGotoXY, ecSelGotoXY:
        Result := True;
      // scroll commands
      ecScrollUp, ecScrollDown, ecScrollLeft, ecScrollRight, ecScrollCenter:
        Result := CanScroll(Command);
      // editing commands
      ecUndo:
        Result := not ReadOnly and FUndoList.CanPeek;
      ecRedo:
        Result := not ReadOnly and FRedoList.CanPeek;
      ecCopy, ecCut:
        Result := not Empty and (not ReadOnly or (Command = ecCopy)) and ((L.Index <> 0) or (L.Digit <> 0));
      ecPaste:
        Result := not ReadOnly and (FEditArea <> eaNone) and (ClipBoard.FormatCount > 0);
      ecInsertChar:
        Result := not ReadOnly and (FEditArea <> eaNone);
      ecInsertDigits:
        Result := not ReadOnly and (FEditArea = eaDigits);
      ecInsertString:
        Result := not ReadOnly and (FEditArea <> eaNone);
      ecDeleteLastChar:
        Result := not (Empty or ReadOnly) and (FEditArea <> eaNone) and ((L.Index > 0) or (FSelEnd.Index > 0));
      ecDeleteChar:
        Result := not (Empty or ReadOnly) and (FEditArea <> eaNone) and ((L.Index > 0) or (FSelEnd.Index < FSize));
      ecDeleteBOL:
        Result := not (Empty or ReadOnly) and (FEditArea <> eaNone) and ((L.Index > 0) or (FSelEnd.Index mod FLineSize > 0));
      ecDeleteEOL:
        Result := not (Empty or ReadOnly) and (FEditArea <> eaNone) and ((L.Index > 0) or (FSelEnd.Index mod FLineSize < Min(FLineSize, FSize)));
      ecDeleteLine:
        Result := not (Empty or ReadOnly) and (FEditArea <> eaNone) and ((L.Index > 0) or (FSelEnd.Index mod FLineSize > 0) or (FSelEnd.Index < FSize));
      ecSelectAll:
        Result := not (Empty or ReadOnly) and (FEditArea <> eaNone);
      ecClearAll:
        Result := not (Empty or ReadOnly) and (FEditArea <> eaNone);
      ecClearIndexSelection, ecClearSelection:
        Result := not (Empty or ReadOnly) and (FEditArea <> eaNone) and (L.Index > 0);
      ecSearch:
        Result := not Empty;
      ecReplace:
        Result := not (Empty or ReadOnly);
      ecInsertMode:
        Result := elOverwrite in FStates;
      ecOverwriteMode:
        Result := not (elOverwrite in FStates);
      else
        Result := True;
    end;
  end
  else
    Result := False;
end;

procedure TCustomHexEditor.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    if FScrollBars in [ssVertical, ssBoth] then
      Style := Style or WS_VSCROLL;
    if FScrollBars in [ssHorizontal, ssBoth] then
      Style := Style or WS_HSCROLL;
  end;
end;

procedure TCustomHexEditor.CreateWnd;
begin
  inherited;
  if (eoDropFiles in FOptions) and not (csDesigning in ComponentState) then
    DragAcceptFiles(Handle, True);
end;

procedure TCustomHexEditor.DestroyWnd;
begin
  if (eoDropFiles in FOptions) and not (csDesigning in ComponentState) then
    DragAcceptFiles(Handle, False);
  inherited;
end;

procedure TCustomHexEditor.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TCustomHexEditor.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
const
  WHEEL_DIVISOR = 120;
var
  LinesToScroll, WheelClicks: Integer;
begin
  Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);
  if not Result then
  begin
    if ssCtrl in Shift then
      LinesToScroll := GetModifiedClientRect.Bottom div FCharHeight
    else
      LinesToScroll := 3;
    Inc(FMouseWheelAccumulator, WheelDelta);
    WheelClicks := FMouseWheelAccumulator div WHEEL_DIVISOR;
    FMouseWheelAccumulator := FMouseWheelAccumulator mod WHEEL_DIVISOR;
    ScrollBy(0, - WheelClicks * LinesToScroll, True);
    Result := True;
  end;
end;

procedure TCustomHexEditor.EditAreaChanged;
begin
  if FEditArea = eaNone then
    FEditArea := eaDigits;
  if not (edAddress in FDrawStyles) and (FEditArea = eaAddress) then
    FEditArea := eaDigits;
  if not (edDigits in FDrawStyles) and (FEditArea = eaDigits) then
    FEditArea := eaText;
  if not (edText in FDrawStyles) and (FEditArea = eaText) then
    if edDigits in FDrawStyles then
      FEditArea := eaDigits
    else
      FEditArea := eaNone;
end;

procedure TCustomHexEditor.EndUndoGroup;
begin
  FUndoList.EndGroup;
end;

function TCustomHexEditor.ExecuteCommand(Command: TEditCommand; Data: Pointer): Boolean;
var
  i, j, k, m, n, o: Integer;
  CanInsert, MoreBytes, Found, MatchCase: Boolean;
  c1, c2, c3: Char;
  S, S_FirstChar, S_LastChar, T: string;
  P: TPoint;
  Area: TEditorArea;
  L, OldSelStart, OldSelEnd, Sel1, Sel2: TEditorSelection;
  PChI, PChI_First, PChI_Next: PChangeItem;
  PSD: PSearchData;
  ReplaceAction: TReplaceAction;
  BA: PEBytes;
  H: THandle;
begin
  Result := False;
  if CommandEnabled(Command) then
  begin
    Result := True;
    L := SelLength;
    OldSelEnd := FSelEnd;
    OldSelStart := FSelStart;
    case Command of
      ecLeft..ecSelGotoXY: AddUndoCaretPos(False);
    end;
    case Command of
      ecLeft, ecSelLeft:
      begin
        InternalMoveLeft;
        SelectionChanged(Command <> ecSelLeft);
      end;
      ecRight, ecSelRight:
      begin
        InternalMoveRight;
        SelectionChanged(Command <> ecSelRight);
      end;
      ecUp, ecSelUp:
      begin
        Dec(FSelEnd.Index, FLineSize);
        SelectionChanged(Command <> ecSelUp);
      end;
      ecDown, ecSelDown:
      begin
        Inc(FSelEnd.Index, FLineSize);
        SelectionChanged(Command <> ecSelDown);
      end;
      ecLineStart, ecSelLineStart:
      begin
        FSelEnd := MakeSelection((FSelEnd.Index div FLineSize) * FLineSize, 0);
        SelectionChanged(Command <> ecSelLineStart);
      end;
      ecLineEnd, ecSelLineEnd:
      begin
        FSelEnd := MakeSelection((FSelEnd.Index div FLineSize) * FLineSize + FLineSize - 1, cDigitCount - 1);
        SelectionChanged(Command <> ecSelLineEnd);
      end;
      ecPageUp, ecSelPageUp:
      begin
        Dec(FSelEnd.Index, Min(ClientHeight div FCharHeight, FSelEnd.Index div FLineSize) * FLineSize);
        SelectionChanged(Command <> ecSelPageUp);
      end;
      ecPageDown, ecSelPageDown:
      begin
        Inc(FSelEnd.Index, Min(ClientHeight div FCharHeight, (FSize - FSelEnd.Index) div FLineSize) * FLineSize);
        SelectionChanged(Command <> ecSelPageDown);
      end;
      ecPageLeft, ecSelPageLeft:
      begin
        Dec(FSelEnd.Index, Min(GetPageHorz, FSelEnd.Index mod FLineSize));
        SelectionChanged(Command <> ecSelPageLeft);
      end;
      ecPageRight, ecSelPageRight:
      begin
        Inc(FSelEnd.Index, Min(GetPageHorz, FLineSize - 1 - FSelEnd.Index mod FLineSize));
        SelectionChanged(Command <> ecSelPageRight);
      end;
      ecPageTop, ecSelPageTop:
      begin
        P := SelToPoint(MakeSelection(FSelEnd.Index, 0), FEditArea);
        Dec(FSelEnd.Index, P.Y div FCharHeight * FLineSize);
        SelectionChanged(Command <> ecSelPageTop);
      end;
      ecPageBottom, ecSelPageBottom:
      begin
        P := SelToPoint(MakeSelection(FSelEnd.Index, 0), FEditArea);
        Inc(FSelEnd.Index, ((ClientHeight - P.Y) div FCharHeight - 1) * FLineSize);
        SelectionChanged(Command <> ecSelPageBottom);
      end;
      ecEditorTop, ecSelEditorTop:
      begin
        FSelEnd := MakeSelection(0, 0);
        SelectionChanged(Command <> ecSelEditorTop);
      end;
      ecEditorBottom, ecSelEditorBottom:
      begin
        FSelEnd := MakeSelection(FSize, 0);
        SelectionChanged(Command <> ecSelEditorBottom);
      end;
      ecGotoXY, ecSelGotoXY:
      begin
        Sel1 := PointToSel(PPoint(Data)^, False, Area);
        if Area <> eaNone then
        begin
          FSelEnd := Sel1;
          FEditArea := Area;
          SelectionChanged(Command <> ecSelGotoXY);
        end
        else
          Result := False;
      end;
      ecScrollUp: // scroll commands
        if (FEditArea <> eaNone) and (SelToPoint(FSelEnd, FEditArea).Y >= GetModifiedClientRect.Bottom - FCharHeight) then
        begin
          ScrollBy(0, -1, False);
          Dec(FSelEnd.Index, FLineSize);
          SelectionChanged(True, False);
          Invalidate;
        end
        else
          ScrollBy(0, -1, True);
      ecScrollDown:
        if (FEditArea <> eaNone) and (SelToPoint(FSelEnd, FEditArea).Y <= GetModifiedClientRect.Top) then
        begin
          ScrollBy(0, 1, False);
          Inc(FSelEnd.Index, FLineSize);
          SelectionChanged(True, False);
          Invalidate;
        end
        else
          ScrollBy(0, 1, True);
      ecScrollLeft:
        if FEditArea <> eaNone then
        begin // overscroll check
          P := SelToPoint(MakeSelection(0, 0), FEditArea);
          if P.X < GetModifiedClientRect.Right - FCharWidth then
          begin
            ScrollBy(-1, 0, True);
            P := SelToPoint(FSelEnd, FEditArea);
            if (P.X >= GetModifiedClientRect.Right) and ((FSelEnd.Index mod FLineSize > 0) or (FSelEnd.Digit > 0)) then
              ExecuteCommand(ecLeft)
          end;
        end
        else
          ScrollBy(-1, 0, True);
      ecScrollRight:
        if FEditArea <> eaNone then
        begin // overscroll check
          P := SelToPoint(MakeSelection(FLineSize - 1, cDigitCount - 1), FEditArea);
          if P.X > 0 then
          begin
            ScrollBy(1, 0, True);
            P := SelToPoint(FSelEnd, FEditArea);
            if (P.X < 0) and ((FSelEnd.Index mod FLineSize < FLineSize - 1) or (FSelEnd.Digit < cDigitCount - 1)) then
              ExecuteCommand(ecRight)
          end;
        end
        else
          ScrollBy(1, 0, True);
      ecScrollCenter:
      begin
        P := SelToPoint(FSelEnd, FEditArea);
        i := (P.X - ClientWidth div 2) div FCharWidth;
        j := (P.Y - ClientHeight div 2) div FCharHeight;
        ScrollBy(i, j, True);
      end;
      ecUndo: // editing commands
      begin
        PChI := FUndoList.PeekItem;
        PChI_First := PChI;
        while PChI <> nil do
        begin
          i := Length(PChI.Data);
          j := Min(i, FSize - PChI.SelEnd.Index);
          FRedoList.SetGroupData(PChI.Group, PChI.GroupReason);
          case PChI.ItemReason of
            crCaretPos:
              FRedoList.AddChange(crCaretPos, '');
            crDeleteChar, crDeleteDigits, crDeleteString:
            begin
              if FBuffer <> nil then
              begin
                SetLength(S, j);
                System.Move(FBuffer[PChI.SelEnd.Index], S[1], j);
              end
              else
                S := '';
              FRedoList.AddChange(OppositeReason(PChI.ItemReason), S, PChI.Inserted);
            end;
            crInsertChar, crInsertDigits, crInsertString:
              FRedoList.AddChange(OppositeReason(PChI.ItemReason), PChI.Data);
          end;
          FSelEnd := PChI.SelEnd;
          FSelStart := PChI.SelStart;
          FEditArea := PChI.EditArea;
          case PChI.ItemReason of
            crDeleteChar, crDeleteDigits, crDeleteString:
            begin
              if PChI.Inserted then
                ClearString(PChI.SelEnd.Index, i)
              else
                if FBuffer <> nil then
                begin
                  System.Move(PChI.Data[1], FBuffer[PChI.SelEnd.Index], j);
                  Invalidate;
                end;
            end;
            crInsertChar, crInsertDigits, crInsertString:
              InsertString(GetRealSelStart.Index, PChI.Data, I);
          end;
          EditAreaChanged;
          SelectionChanged(False, False);
          if PChI.ItemReason <> crCaretPos then
            DoChange;
          PChI_Next := FUndoList.PeekItem;
          if (PChI_Next <> nil) and not ((PChI.Group <> 0) and (PChI.Group = PChI_Next.Group) or
            (eoGroupUndo in FOptions) and (PChI_First.GroupReason = PChI_Next.GroupReason)) then
          begin
            FUndoList.PokeItem;
            Break;
          end;
          PChI := PChI_Next;
        end;
        if not CaretInView then
          ExecuteCommand(ecScrollCenter);
      end;
      ecRedo:
      begin
        PChI := FRedoList.PeekItem;
        PChI_First := PChI;
        while PChI <> nil do
        begin
          FUndoList.PokeItem;
          i := Length(PChI.Data);
          Sel1 := GetRealSelStart;
          case PChI.ItemReason of
            crInsertChar, crInsertDigits, crInsertString:
            begin
              if PChI.Inserted then
                InsertString(Sel1.Index, PChI.Data, i)
              else
                if FBuffer <> nil then
                begin
                  System.Move(PChI.Data[1], FBuffer[Sel1.Index], Min(i, FSize - FSelEnd.Index));
                  Invalidate;
                end;
            end;
            crDeleteChar, crDeleteDigits, crDeleteString:
              ClearString(Sel1.Index, I);
          end;
          FSelEnd := PChI.SelEnd;
          FSelStart := PChI.SelStart;
          FEditArea := PChI.EditArea;
          EditAreaChanged;
          SelectionChanged(False, False);
          if PChI.ItemReason <> crCaretPos then
            DoChange;
          PChI_Next := FRedoList.PeekItem;
          if (PChI_Next <> nil) and not ((PChI.Group <> 0) and (PChI.Group = PChI_Next.Group) or
            (eoGroupUndo in FOptions) and (PChI_First.GroupReason = PChI_Next.GroupReason)) then
          begin
            FRedoList.PokeItem;
            Break;
          end;
          PChI := PChI_Next;
        end;
        if not CaretInView then
          ExecuteCommand(ecScrollCenter);
      end;
      ecCopy:
      begin
        Sel1 := GetRealSelStart;
        Sel2 := GetRealSelEnd;
        if FEditArea = eaDigits then
          ClipBoard.AsText := BinaryToDigits(FBuffer, Sel1, Sel2)
        else
          if L.Index <> 0 then
          begin
            S := BinaryToText(FBuffer, Sel1.Index, Sel2.Index, @FCharMapping);
            H := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, L.Index);
            try
              BA := GlobalLock(H);
              try
                System.Move(FBuffer[Sel1.Index], BA^, L.Index);
              finally
                GlobalUnlock(H);
              end;
              ClipBoard.Open;
              try
                ClipBoard.SetAsHandle(FClipboardFormat, H);
                ClipBoard.AsText := S;
              finally
                ClipBoard.Close;
              end;
            except
              GlobalFree(H);
            end;
          end;
      end;
      ecCut:
      begin
        ExecuteCommand(ecCopy);
        ExecuteCommand(ecClearSelection);
      end;
      ecPaste:
      begin
        if L.Index > 0 then
          ExecuteCommand(ecClearSelection);
        if ClipBoard.FormatCount > 0 then
        begin
          S := '';
          h := 0;
          if ClipBoard.HasFormat(FClipboardFormat) then // paste as binary data
            h := ClipBoard.GetAsHandle(FClipboardFormat)
          else
            if ClipBoard.HasFormat(CF_TEXT) then
            begin
              S := ClipBoard.AsText;
              if S <> '' then
              begin
                m := Length(S);
                if (FEditArea = eaDigits) and ExecuteCommand(ecInsertDigits, Pointer(S)) then
                begin
                  S := '';
                  if m >= cDigitCount then
                    Inc(FSelEnd.Index, m div cDigitCount)
                  else
                  begin
                    Inc(FSelEnd.Digit, m);
                    if FSelEnd.Digit >= cDigitCount then
                    begin
                      Inc(FSelEnd.Index);
                      FSelEnd.Digit := FSelEnd.Digit mod cDigitCount;
                    end;
                  end;
                  SelectionChanged(True);
                end
                else
                  ExecuteCommand(ecInsertString, Pointer(S));
              end;
            end
            else
              h := ClipBoard.GetAsHandle(ClipBoard.Formats[0]);
            if h <> 0 then
            begin
              BA := GlobalLock(h);
              try
                i := GlobalSize(h);
                if i > 0 then
                begin
                  SetLength(S, i);
                  System.Move(BA^, S[1], i);
                end;
              finally
                GlobalUnlock(h);
              end;
              if S <> '' then
                ExecuteCommand(ecInsertString, Pointer(S));
            end;
            if S <> '' then
            begin
              Inc(FSelEnd.Index, Length(S));
              FSelEnd.Digit := 0;
              SelectionChanged(True);
            end;
          end;
      end;
      ecInsertChar:
      begin
        BeginUndoGroup(crInsertChar);
        try
          n := PByte(Data)^;
          if L.Index > 0 then
            ExecuteCommand(ecClearSelection);
          ValidateSelection(FSelEnd, FEditArea);
          if FBuffer <> nil then
            i := FBuffer[FSelEnd.Index]
          else
            i := 0;
          CanInsert := (FBuffer = nil) or (FSelEnd.Digit = 0) and (not (elOverwrite in FStates) or (FSelEnd.Index = FSize));
          AddUndoByte(crDeleteChar, i, CanInsert);
          if CanInsert then
            InsertChar(FSelEnd.Index, 0)
          else
            Invalidate;
          case FEditArea of
            eaDigits:
            begin
              FBuffer[FSelEnd.Index] := ReplaceDigit(FBuffer[FSelEnd.Index], n, FSelEnd.Digit);
              InternalMoveRight;
            end;
            eaText:
            begin
              FBuffer[FSelEnd.Index] := n;
              InternalMoveRight;
            end;
          end;
          SelectionChanged(True);
        finally
          EndUndoGroup;
        end;
      end;
      ecInsertDigits:
      begin
        S := string(Data);
        if (S <> '') and DigitsToBinStr(S) then
        begin
          BeginUndoGroup(crInsertDigits);
          try
            if L.Index > 0 then
              ExecuteCommand(ecClearSelection);
            ValidateSelection(FSelEnd, FEditArea);
            MoreBytes := Length(S) >= cDigitCount;
            if MoreBytes then // we don't move digit positions of the remaining block
              SetLength(S, Length(S) div cDigitCount * cDigitCount);
            j := 0;
            if (FBuffer <> nil) and (not MoreBytes or (FSelEnd.Digit > 0)) then
            begin
              i := FBuffer[FSelEnd.Index];
              S_FirstChar := Char(i);
              S_LastChar := S_FirstChar;
              // split current byte
              AddUndoByte(crInsertChar, i);
              ClearChar(FSelEnd.Index);
              n := Length(S);
              for i := FSelEnd.Digit to cDigitCount - 1 do
              begin
                if j < n then
                begin
                  Inc(j);
                  S_FirstChar := Char(ReplaceDigit(Ord(S_FirstChar[1]), Ord(S[j]), i));
                end
                else
                  Break;
              end;
              k := Length(S);
              if k > j then
                for i := FSelEnd.Digit - 1 downto 0 do
                begin
                  if k > j then
                  begin
                    S_LastChar := Char(ReplaceDigit(Ord(S_LastChar[1]), Ord(S[k]), i));
                    Dec(k);
                  end
                  else
                    Break;
                end
              else
                S_LastChar := '';
              o := cDigitCount;
            end
            else
            begin
              S_FirstChar := '';
              S_LastChar := '';
              o := 0;
            end;
            T := '';
            if MoreBytes then
            begin
              n := Length(S) - o;
              o := j;
              for i := 0 to n div cDigitCount - 1 do
              begin
                k := 0;
                for j := 1 to cDigitCount do
                begin
                  k := k * cBase;
                  m := i * 2 + j + o;
                  Inc(k, Ord(S[m]));
                end;
                T := Format('%s%s', [T, Char(k)]);
              end;
            end;
            S := S_FirstChar + T + S_LastChar;
            // always insert (don't overwrite)
            AddUndoString(crDeleteDigits, S);
            InsertString(FSelEnd.Index, S, Length(S));
            SelectionChanged(True);
          finally
            EndUndoGroup;
          end;
        end
        else
          Result := False;
      end;
      ecInsertString:
      begin
        S := string(Data);
        if S <> '' then
        begin
          BeginUndoGroup(crInsertString);
          try
            if L.Index > 0 then
              ExecuteCommand(ecClearIndexSelection);
            // always insert (don't overwrite)
            AddUndoString(crDeleteString, S);
            InsertString(FSelEnd.Index, S, Length(S));
            SelectionChanged(True);
          finally
            EndUndoGroup;
          end;
        end else
          Result := False;
      end;
      ecDeleteLastChar:
        if L.Index <> 0 then ExecuteCommand(ecClearSelection) else
        begin
          BeginUndoGroup(crDeleteString);
          try
            AddUndoCaretPos;
            FSelStart.Index := FSelEnd.Index - 1;
            ExecuteCommand(ecClearIndexSelection)
          finally
            EndUndoGroup;
          end;
        end;
      ecDeleteChar:
        if L.Index <> 0 then ExecuteCommand(ecClearSelection) else
        begin
          BeginUndoGroup(crDeleteString);
          try
            AddUndoCaretPos;
            FSelStart.Index := FSelEnd.Index + 1;
            ExecuteCommand(ecClearIndexSelection)
          finally
            EndUndoGroup;
          end;
        end;
      ecDeleteBOL:
        if L.Index <> 0 then ExecuteCommand(ecClearSelection) else
        begin
          BeginUndoGroup(crDeleteString);
          try
            AddUndoCaretPos;
            FSelStart.Index := (FSelEnd.Index div FLineSize) * FLineSize;
            ExecuteCommand(ecClearIndexSelection)
          finally
            EndUndoGroup;
          end;
        end;
      ecDeleteEOL:
        if L.Index <> 0 then ExecuteCommand(ecClearSelection) else
        begin
          BeginUndoGroup(crDeleteString);
          try
            AddUndoCaretPos;
            FSelStart.Index := Min((FSelEnd.Index div FLineSize + 1) * FLineSize, FSize);
            ExecuteCommand(ecClearIndexSelection)
          finally
            EndUndoGroup;
          end;
        end;
      ecDeleteLine:
        if L.Index <> 0 then ExecuteCommand(ecClearSelection) else
        begin
          BeginUndoGroup(crDeleteString);
          try
            AddUndoCaretPos;
            FSelStart.Index := (FSelEnd.Index div FLineSize) * FLineSize;
            FSelEnd.Index := Min(FSelStart.Index + FLineSize, FSize);
            ExecuteCommand(ecClearIndexSelection)
          finally
            EndUndoGroup;
          end;
        end;
      ecSelectAll:
      begin
        AddUndoCaretPos;
        FSelStart := MakeSelection(0, 0);
        FSelEnd := MakeSelection(FSize, 0);
        SelectionChanged(False);
      end;
      ecClearAll:
      begin
        ExecuteCommand(ecSelectAll);
        ExecuteCommand(ecClearIndexSelection);
      end;
      ecClearIndexSelection:
      begin
        i := GetRealSelStart.Index;
        AddUndoBytes(crInsertString, PEBytes(@FBuffer[i]), L.Index, True);
        ClearString(i, L.Index);
        FSelEnd := MakeSelection(i, 0);
        SelectionChanged(True);
      end;
      ecClearSelection:
      begin
        Sel1 := GetRealSelStart;
        Sel2 := GetRealSelEnd;
        if (Sel1.Digit > 0) {and (Sel1.Digit + Sel2.Digit = cDigitCount)} then
        begin
          BeginUndoGroup(crDeleteDigits);
          try // digit clear mode
            AddUndoCaretPos;
            FSelEnd := MakeSelection(Sel1.Index + 1, 0);
            FSelStart := FSelEnd;
            if Sel2.Digit = 0 then
            begin
              Dec(L.Index);
              n := FBuffer[Sel2.Index - 1];
            end
            else
              n := FBuffer[Sel2.Index];
            AddUndoBytes(crInsertDigits, PEBytes(@FBuffer[FSelEnd.Index]), L.Index, True);
            ClearString(FSelEnd.Index, L.Index);
            FSelEnd := Sel1;
            AddUndoByte(crDeleteChar, FBuffer[Sel1.Index], False);
            for i := Sel1.Digit to cDigitCount - 1 do
            begin
              FBuffer[Sel1.Index] := ReplaceDigit(FBuffer[Sel1.Index], n mod cBase, i);
              n := n div cBase;
            end;
            SelectionChanged(True);
          finally
            EndUndoGroup;
          end;
        end else
          ExecuteCommand(ecClearIndexSelection);
      end;
      ecSearch, ecReplace:
      begin // doesn't search for single digits
        PSD := Data;
        if PSD <> nil then
        begin
          PSD.ErrorReason := eseOk;
          S := PSD.TextToFind;
          if Command = ecReplace then
          begin
            T := PSD.TextToReplace;
            ReplaceAction := eraYes;
          end;
          if esoSelectedOnly in PSD.Options then
            if esoFirstSearch in PSD.Options then
            begin
              PSD.SelStart := GetRealSelStart.Index;
              PSD.SelEnd := GetRealSelEnd.Index;
            end else
            begin
              PSD.SelStart := MinMax(PSD.SelStart, 0, FSize);
              PSD.SelEnd := MinMax(PSD.SelEnd, 0, FSize);
            end;
          if esoFirstSearch in PSD.Options then
            Exclude(PSD.Options, esoWereDigits);
          if esoTreatAsDigits in PSD.Options then
          begin
            if DigitsToBinStr(S) then
            begin
              S := BinStrToBinary(S);
              if Command = ecReplace then
              begin
                if DigitsToBinStr(T) then
                begin
                  T := BinStrToBinary(T);
                  PSD.TextToFind := S;
                  PSD.TextToReplace := T;
                  Exclude(PSD.Options, esoTreatAsDigits);
                  Include(PSD.Options, esoWereDigits);
                end
                else
                  PSD.ErrorReason := eseNoDigitsReplace;
              end
              else
              begin
                PSD.TextToFind := S;
                Exclude(PSD.Options, esoTreatAsDigits);
                Include(PSD.Options, esoWereDigits);
              end;
            end
            else
              PSD.ErrorReason := eseNoDigitsFind;
          end;
          if PSD.ErrorReason = eseOk then
          begin
            n := Length(S);
            if esoBackwards in PSD.Options then
            begin
              o := -1;
              if (esoEntireScope in PSD.Options) and (esoFirstSearch in PSD.Options) then
                i := FSize
              else
                i := GetRealSelStart.Index - 1;
              if esoSelectedOnly in PSD.Options then
              begin
                m := PSD.SelStart;
                if esoFirstSearch in PSD.Options then
                  i := PSD.SelEnd
              end
              else
                m := 0;
              i := Min(I, FSize - n);
              if i < m then
                PSD.ErrorReason := eseNoMatch
            end
            else
            begin
              o := 1;
              if (esoEntireScope in PSD.Options) and (esoFirstSearch in PSD.Options) then
                i := 0
              else
                i := GetRealSelEnd.Index;
              if esoSelectedOnly in PSD.Options then
              begin
                m := PSD.SelEnd;
                if esoFirstSearch in PSD.Options then
                  i := PSD.SelStart
              end
              else
                m := FSize;
              m := Min(m, FSize - n);
              if i >= m then
                PSD.ErrorReason := eseNoMatch
            end;
            if PSD.ErrorReason = eseOk then
            begin
              Found := False;
              MatchCase := PSD.Options * [esoMatchCase, esoWereDigits] <> [];
              if MatchCase then
                c1 := S[1]
              else
                c1 := UpCase(S[1]);
              i := MinMax(i, 0, FSize - 1);
              while i <> m do
              begin
                if MatchCase then
                  c2 := Char(FBuffer[i])
                else
                  c2 := UpCase(Char(FBuffer[i]));
                if c1 = c2 then
                begin
                  if FSize - i >= n then
                  begin
                    j := 2;
                    Dec(i);
                    while (j <= n) do
                    begin
                      if MatchCase then
                      begin
                        c2 := Char(FBuffer[i + j]);
                        c3 := S[j];
                      end
                      else
                      begin
                        c2 := Upcase(Char(FBuffer[i + j]));
                        c3 := Upcase(S[j]);
                      end;
                      if c2 = c3 then
                        Inc(j)
                      else
                        Break;
                    end;
                    Inc(i);
                    if j = n + 1 then
                    begin
                      Found := True;
                      FSelStart := MakeSelection(i, 0);
                      FSelEnd := MakeSelection(i + n, 0);
                      if Command = ecReplace then
                      begin
                        if (esoPrompt in PSD.Options) and Assigned(FOnReplaceText) then
                        begin
                          SelectionChanged(False, False);
                          if not CaretInView then
                            ExecuteCommand(ecScrollCenter);
                          FOnReplaceText(Self, S, T, ReplaceAction)
                        end
                        else
                          ReplaceAction := eraYes;
                        case ReplaceAction of
                          eraCancel:
                            Break;
                          eraYes, eraAll:
                          begin
                            if T = '' then
                              ExecuteCommand(ecClearIndexSelection)
                            else
                              ExecuteCommand(ecInsertString, Pointer(T));
                            FSelEnd := MakeSelection(i + Length(T), 0);
                            AddUndoCaretPos;
                            if ReplaceAction  = eraAll then
                              Include(PSD.Options, esoAll);
                          end;
                        end;
                        if not (esoAll in PSD.Options) then
                          Break;
                      end
                      else
                        Break;
                    end
                  end;
                end;
                Inc(i, O);
              end;
              if Found then
              begin
                SelectionChanged(False, False);
                if not CaretInView then
                  ExecuteCommand(ecScrollCenter);
              end
              else
                PSD.ErrorReason := eseNoMatch;
            end;
          end;
          Exclude(PSD.Options, esoFirstSearch);
        end
        else
          Result := False;
      end;
      ecInsertMode:
      begin
        Exclude(FStates, elOverwrite);
        UpdateEditorCaret(True);
      end;
      ecOverwriteMode:
      begin
        Include(FStates, elOverwrite);
        UpdateEditorCaret(True);
      end;
      ecToggleMode:
      begin
        if elOverwrite in FStates then
          Exclude(FStates, elOverwrite)
        else
          Include(FStates, elOverwrite);
        UpdateEditorCaret(True);
      end;
      ecGotFocus, ecLostFocus: // focus change
      begin
        UpdateEditorCaret;
        Invalidate;
      end;
    end;
    if (OldSelStart.Index <> OldSelEnd.Index) or (FSelStart.Index <> FSelEnd.Index) or
      (OldSelStart.Digit <> OldSelEnd.Digit) or (FSelStart.Digit <> FSelEnd.Digit) or
      not (elCaretVisible in FStates) and (edInactiveCaret in FDrawStyles) and
      ((FSelStart.Index <> OldSelStart.Index) or (FSelStart.Digit <> OldSelStart.Digit) or
      (FSelEnd.Index <> OldSelEnd.Index) or (FSelEnd.Digit <> OldSelEnd.Digit)) then
      Invalidate;
  end;
end;

procedure TCustomHexEditor.FontChange(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then
  begin
    Font.Pitch := fpFixed;
    if Font.Size >= 0 then
      Font.Size := MinMax(Font.Size, cFontSizeMin, cFontSizeMax);
    UpdateCharMetrics;
    UpdateScrollRange;
  end;
end;

function TCustomHexEditor.GetAreaDimensions: TAreaDimensions;
begin
  FillChar(Result, SizeOf(Result), 0);
  with Result do
  begin
    if edAddress in FDrawStyles then
    begin
      Address := Length(FAddressPrefix) + FAddressSize;
      if FDrawStyles * [edDigits, edText] <> [] then
        AddressOut := FAreaSpacing;
    end;
    if edDigits in FDrawStyles then
    begin
      Digits := FLineSize * cDigitCount + FLineSize div FDigitGrouping;
      if FLineSize mod FDigitGrouping = 0 then
        Dec(Digits);
      if edAddress in FDrawStyles then
        DigitsIn := FAreaSpacing;
      if edText in FDrawStyles then
        DigitsOut := FAreaSpacing;
    end;
    if edText in FDrawStyles then
    begin
      Text := FLineSize;
      if FDrawStyles * [edAddress, edDigits] <> [] then
        TextIn := FAreaSpacing;
    end;
    TotalHorz := Address + AddressOut + Digits + DigitsIn + DigitsOut + Text + TextIn;
    if [edAddress, edDigits, edText] * FDrawStyles <> [] then
      TotalVert := LineCount
    else
      TotalVert := 0;
  end;
end;

function TCustomHexEditor.GetCaretVisible: Boolean;
begin
  Result := elCaretVisible in FStates;
end;

function TCustomHexEditor.GetCharMapping: TEditCharMapping;
begin
  Result := FCharMapping;
end;

function TCustomHexEditor.GetClientHeightChars: Integer;
begin
  Result := ClientHeight div FCharHeight;
end;

function TCustomHexEditor.GetClientWidthChars: Integer;
begin
  Result := ClientWidth div FCharWidth;
end;

function TCustomHexEditor.GetCommandKey(Index: TEditCommand): TEditKey; 
var
  i: Integer;
begin
  Result.Key := 0;
  Result.Shift := [];
  for i := 0 to Length(FKeyMapping) - 1 do
    if FKeyMapping[i].Command = Index then
    begin
      Result := FKeyMapping[i].Key;
      Exit;
    end;
end;

function TCustomHexEditor.GetData: TDataSize;
begin
  Result.Data := FBuffer;
  Result.Size := FSize;
end;

function TCustomHexEditor.GetEmpty: Boolean;
begin
  Result := FBuffer = nil;
end;

function TCustomHexEditor.GetFirstVisibleIndex: Integer;
begin
  Result := PointToSel(Point(0, 0), False, FEditArea).Index;
end;

function TCustomHexEditor.GetInsertMode: Boolean;
begin
  Result := not (elOverwrite in FStates);
end;

function TCustomHexEditor.GetKeyMapping: TEditKeyMapping;
begin
  Result := FKeyMapping;
end;

function TCustomHexEditor.GetLastVisibleIndex: Integer;
begin
  Result := PointToSel(GetModifiedClientRect.BottomRight, False, FEditArea).Index;
end;

function TCustomHexEditor.GetLineCount: Integer;
begin
  Result := DivUp(FSize + 1, FLineSize);
end;

function TCustomHexEditor.GetLines(Index: Integer): TDataSize;
var
  i: Integer;
begin
  i := Index * FLineSize;
  if (FBuffer <> nil) and (i >= 0) and (i < FSize) then
  begin
    Result.Data := @FBuffer[i];
    Result.Size := Min(FLineSize, FSize - i);
  end
  else
  begin
    Result.Data := nil;
    Result.Size := 0;
  end;
end;

function TCustomHexEditor.GetModified: Boolean;
begin
  Result := (elModified in FStates) or FUndoList.Modified;
end;

function TCustomHexEditor.GetModifiedClientRect: TRect;
begin
  Result := Rect(0, 0, GetClientWidthChars * FCharWidth, GetClientHeightChars * FCharHeight);
end;

function TCustomHexEditor.GetMaxLeftChar(Extent: Integer): Integer;
begin
  if Extent <= 0 then
    Extent := GetAreaDimensions.TotalHorz;
  Result := Max(Extent - GetClientWidthChars, 0);
end;

function TCustomHexEditor.GetMaxTopLine(Extent: Integer): Integer;
begin
  if Extent <= 0 then
    Extent := GetAreaDimensions.TotalVert;
  Result := Max(Extent - GetClientHeightChars, 0);
end;

function TCustomHexEditor.GetPageHorz: Integer;
begin
  case FEditArea of
    eaDigits:
      Result := ClientWidth * FDigitgrouping div (FCharWidth * (cDigitCount * FDigitGrouping + 1));
    eaText:
      Result := ClientWidth div FCharWidth;
    else
      Result := 0;
  end;
end;

function TCustomHexEditor.GetReadOnly: Boolean;
begin
  Result := elReadOnly in FStates;
end;

function TCustomHexEditor.GetRealSelEnd: TEditorSelection;
begin
  if FSelStart.Index <= FSelEnd.Index then
    Result := FSelEnd
  else
    Result := FSelStart;
end;

function TCustomHexEditor.GetRealSelStart: TEditorSelection;
begin
  if FSelStart.Index <= FSelEnd.Index then
    Result := FSelStart
  else
    Result := FSelEnd;
end;

function TCustomHexEditor.GetSelLength: TEditorSelection;
begin
  if FSelStart.Index <= FSelEnd.Index then
    Result.Index := FSelEnd.Index - FSelStart.Index
  else
    Result.Index := FSelStart.Index - FSelEnd.Index;
  if FSelStart.Digit <= FSelEnd.Digit then
    Result.Digit := FSelEnd.Digit - FSelStart.Digit
  else
    Result.Digit := FSelStart.Digit - FSelEnd.Digit;
end;

function TCustomHexEditor.GetSelText: TEditorSelText;
var
  L, Sel1, Sel2: TEditorSelection;
begin
  L := SelLength;
  with Result do
  begin
    if L.Index > 0 then
    begin
      Sel1 := GetRealSelStart;
      Sel2 := GetRealSelEnd;
      AsBinaryRaw  := BinaryToText(FBuffer, Sel1.Index, Sel2.Index, nil);
      AsBinaryMapped := BinaryToText(FBuffer, Sel1.Index, Sel2.Index, @FCharMapping);
      AsDigits := BinaryToDigits(FBuffer, Sel1, Sel2);
      Sel1.Digit := 0;
      Sel2.Digit := 0;
      AsDigitsByteAligned := BinaryToDigits(FBuffer, Sel1, Sel2);
    end
    else
    begin
      AsBinaryRaw := '';
      AsBinaryMapped := '';
      AsDigits := '';
      AsDigitsByteAligned := '';
    end;
  end;
end;

function TCustomHexEditor.GetUndoLimit: Integer;
begin
  Result := FUndoList.Limit;
end;

function TCustomHexEditor.HasFocus: Boolean;
var
  Form: TCustomForm;
begin
  Form := GetParentForm(Self);
  if (Form <> nil) and Form.Visible and Form.Enabled and Form.Active then
    Result := Form.ActiveControl = Self
  else
    Result := False;
end;

procedure TCustomHexEditor.InsertChar(At: Integer; Value: Byte);
var
  S: string;
begin
  SetLength(S, 1);
  S[1] := Char(Value);
  InsertString(At, S, 1);
end;

procedure TCustomHexEditor.InsertString(At: Integer; Value: string; Size: Integer);
begin
  if (At >= 0) and (At <= FSize) and (Length(Value) > 0) then
  begin
    Inc(FSize, Size);
    ReallocMem(FBuffer, FSize);
    if At < FSize - Size then
      Move(FBuffer[At], FBuffer[At + Size], (FSize - At - Size) * SizeOf(Byte));
    Move(Value[1], FBuffer[At], Size);
    UpdateScrollRange;
  end;
end;

function TCustomHexEditor.InternalGetSelAvail: Boolean;
begin
  Result := SelAvail;
end;

procedure TCustomHexEditor.InternalMoveLeft;
begin
  if FEditArea = eaDigits then
  begin
    if FSelEnd.Digit > 0 then
      Dec(FSelEnd.Digit)
    else
      if FSelEnd.Index > 0 then
      begin
        FSelEnd.Digit := cDigitCount - 1;
        Dec(FSelEnd.Index);
      end
  end
  else
    Dec(FSelEnd.Index);
end;

procedure TCustomHexEditor.InternalMoveRight;
begin
  if FEditArea = eaDigits then
  begin
    if (FSelEnd.Index < FSize) and (FSelEnd.Digit < cDigitCount - 1) then
      Inc(FSelEnd.Digit)
    else
    begin
      FSelEnd.Digit := 0;
      Inc(FSelEnd.Index);
    end
  end
  else
    Inc(FSelEnd.Index);
end;

function TCustomHexEditor.IsAddressPrefixStored: Boolean;
begin
  Result := FAddressPrefix <> '';
end;

function TCustomHexEditor.IsDrawStylesStored: Boolean;
begin
  Result := FDrawStyles <> cDrawStylesDef;
end;

function TCustomHexEditor.IsOptionsStored: Boolean;
begin
  Result := FOptions <> [eoGroupUndo];
end;

procedure TCustomHexEditor.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomHexEditor.KeyDown(var Key: Word; Shift: TShiftState);
var
  i: Integer;
  HK: TEditKey;
begin
  inherited;
  Exclude(FStates, elIgnoreNextChar);
  if not (csDesigning in ComponentState) then
  begin
    for i := 0 to Length(FKeyMapping) - 1 do
    begin
      HK := FKeyMapping[i].Key;
      if (HK.Key = Key) and (HK.Shift = Shift) then
      begin
        ExecuteCommand(FKeyMapping[i].Command);
        Key := 0;
        Include(FStates, elIgnoreNextChar);
        Exit;
      end;
    end;
    if Key = VK_ESCAPE then
      Include(FStates, elIgnoreNextChar);
  end;
end;

procedure TCustomHexEditor.KeyPress(var Key: Char);
var
  i: Integer;
begin
  inherited;
  if not (csDesigning in ComponentState) then
    if not (elIgnoreNextChar in FStates) then
    begin
      case FEditArea of
        eaDigits:
          i := DigitToBin(Key);
        eaText:
          i := Ord(Key);
        else
          i := -1;
      end;
      if i >= 0 then
        ExecuteCommand(ecInsertChar, @i);
    end
    else
      Exclude(FStates, elIgnoreNextChar);
end;

procedure TCustomHexEditor.LoadFromFile(const FileName: TFileName);
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TCustomHexEditor.LoadFromStream(Stream: TStream);
var
  Size: Integer;
begin
  Size := Stream.Size - Stream.Position;
  if Size > 0 then
  begin
    Clear;
    FSize := Size;
    GetMem(FBuffer, FSize);
    Stream.Read(FBuffer^, FSize);
    BufferChanged;
  end;
end;

const
  cScrollDelta = -2;

procedure TCustomHexEditor.ModifyScrollBar(ScrollBar, ScrollCode, Delta: Integer; UpdateNeeded: Boolean);
var
  i, j, k: Integer;
  HasScrollBar: Boolean;
  SI: TScrollInfo;
begin
  HasScrollBar := (ScrollBar = SB_HORZ) and (ScrollBars = ssHorizontal) or (ScrollBar = SB_VERT) and (ScrollBars = ssVertical) or (ScrollBars = ssBoth);
  if HasScrollBar then
  begin
    FillChar(SI, SizeOf(TScrollInfo), 0);
    SI.cbSize := SizeOf(TScrollInfo);
    SI.fMask := SIF_PAGE or SIF_TRACKPOS;
    GetScrollInfo(Handle, ScrollBar, SI);
  end;
  if ScrollBar = SB_HORZ then
  begin
    i := FLeftChar;
    j := GetMaxLeftChar;
  end
  else
  begin
    i := FTopLine;
    j := GetMaxTopLine;
  end;
  k := i;
  if ScrollCode = cScrollDelta then
    Inc(i, Delta)
  else
    if HasScrollBar then
      case ScrollCode of
        SB_LINEUP:
          Dec(i);
        SB_LINEDOWN:
          Inc(i);
        SB_PAGEUP:
          Dec(i, SI.nPage);
        SB_PAGEDOWN:
          Inc(i, SI.nPage);
        SB_THUMBTRACK, SB_THUMBPOSITION:
          i := SI.nTrackPos;
      end;
  i := MinMax(i, 0, j);
  if k <> i then
  begin
    if HasScrollBar then
    begin
      FillChar(SI, SizeOf(TScrollInfo), 0);
      SI.nPos := i;
      SI.fMask := SIF_POS;
      SetScrollInfo(Handle, ScrollBar, SI, True);
    end;
    if ScrollBar = SB_HORZ then
      FLeftChar := i
    else
      FTopLine := i;
    if UpdateNeeded then
    begin
      UpdateEditorCaret;
      Invalidate;
    end;
  end;
end;

procedure TCustomHexEditor.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  Command: TEditCommand;
begin
  inherited;
  if Enabled and (Button = mbLeft) and not (ssDouble in Shift) then
  begin
    SafeSetFocus;
    P := Point(X, Y);
    if ssShift in Shift then
      Command := ecSelGotoXY
    else
      Command := ecGotoXY;
    if ExecuteCommand(Command, @P) then
      Include(FStates, elMouseCapture);
  end;
end;

procedure TCustomHexEditor.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  R: TRect;
begin
  inherited;
  if (elMouseCapture in FStates) then
  begin
    P := Point(X, Y);
    R := GetModifiedClientRect;
    if PtInRect(R, P) then
      UpdateSelEnd(P, False)
    else
      if not FScrollTimer.Enabled then
        ScrollTo(P, True, False);
  end;
end;

procedure TCustomHexEditor.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Exclude(FStates, elMouseCapture);
end;

procedure TCustomHexEditor.Paint;
begin
  PaintToCanvas(Canvas);
end;

procedure TCustomHexEditor.PaintLines(const Data: TEditorPaintData);
var
  HalfPosWidth, i, Index, j, k, l, m, MaxAddress, WHorz, WVert, WSep, LeftIndent, VTextIndent: Integer;
  BC1, BC2, FC1, FC2, PC1: TColor;
  EditorFocused, DrawInactiveCaret, DrawNormal, DigitSep, SelCondition: Boolean;
  S, Fmt: string;
  C: Char;
  R, R1, RClip: TRect;
  ASelStart, ASelEnd: TEditorSelection;
  AD: TAreaDimensions;
  FStyle: TFontStyles;
begin
  with Data.Canvas do
  begin
    R := Data.PaintRect;
    AD := GetAreaDimensions;
    SetTextCharacterExtra(Handle, Data.CharSpacing);
    LeftIndent := R.Left - Data.LeftChar * Data.CharWidth;
    VTextIndent := (Data.CharHeight - Abs(Font.Height)) div 2;
    HalfPosWidth := Data.CharWidth div 2;
    Fmt := '';
    MaxAddress := 0;
    l := LineCount;
    DrawInactiveCaret := not Data.CaretShown and (edInactiveCaret in FDrawStyles);
    DrawNormal := True;
    EditorFocused := HasFocus;
    if FSelStart.Index <= FSelEnd.Index then
    begin
      ASelStart := FSelStart;
      ASelEnd := FSelEnd;
    end
    else
    begin
      ASelStart := FSelEnd;
      ASelEnd := FSelStart;
    end;
    // preserve space for lines and separators
    if edHorzLines in FDrawStyles then
      WVert := Max(1, Data.CharHeight div 25)
    else
      WVert := 0;
    if edVertLines in FDrawStyles then
      WHorz := Max(1, Data.CharWidth div 20)
    else
      WHorz := 0;
    if edSeparators in FDrawStyles then
      WSep := Max(1, Data.CharWidth div 20)
    else
      WSep := 0;
    // address area pre-comp
    if edAddress in FDrawStyles then
    begin
      c := 'x';
      j := 16;
      Fmt := Format('%s%%.%d%s', [FAddressPrefix, FAddressSize, C]);
      MaxAddress := 1;
      for i := 1 to FAddressSize do
        MaxAddress := MaxAddress * j;
    end;
    // get clip box for updating;
    GetClipBox(Handle, RClip);
    // now paint text lines
    for i := Data.TopLine to Min(l - 1, Data.BottomLine) do
    begin
      k := LeftIndent;
      R.Bottom := R.Top + Data.CharHeight - WVert;
      if (R.Top <= RClip.Bottom) and (R.Bottom >= RClip.Top) then
      begin
        if edAddress in FDrawStyles then
        begin
          Index := i * FLineSize;
          Brush.Color := clRed;
          if (DrawNormal or Data.PaintSelection) and ((ASelStart.Index <> ASelEnd.Index) or (ASelStart.Digit <> ASelEnd.Digit)) and
            (Index + FLineSize - 1 >= ASelStart.Index) and (Index < ASelEnd.Index) then
          begin
            PC1 := cLinesHighLightDef;
            if (FEditArea = eaAddress) and (EditorFocused or Data.PaintSelection) then
            begin
              FC1 := cSelTextFocusedDef;
              BC1 := cSelBkGndFocusedDef;
            end
            else
            begin
              FC1 := cSelTextDef;
              BC1 := cSelBkGndDef;
            end;
          end
          else
          begin
            PC1 := cHorzLinesDef;
            FC1 := cAddressTextDef;
            BC1 := cAddressBkGndDef;
          end;
          Brush.Color := BC1;
          Font.Color := FC1;
          R.Left := k;
          Inc(k, AD.Address * Data.CharWidth);
          R.Right := k;
          j := i * FLineSize + FAddressOffset;
          if MaxAddress <> 0 then
            j := j mod MaxAddress;
          FillRect(R);
          FStyle := Font.Style;
          Font.Style := [];
          TextOut(R.Left, R.Top + VTextIndent, Format(Fmt, [j]));
          Font.Style := FStyle;
          if edHorzLines in FDrawStyles then
          begin
            Brush.Color := PC1;
            FillRect(Rect(R.Left, R.Bottom, R.Right, R.Bottom + WVert));
          end;
          if AD.AddressOut > 0 then
          begin
            R.Left := k;
            Inc(k, AD.AddressOut * Data.CharWidth);
            R.Right := k;
            Brush.Color := cAddressBkGndDef;
            FillRect(Rect(R.Left, R.Top, R.Right - WSep, R.Bottom));
            if edHorzLines in FDrawStyles then
            begin
              Brush.Color := cHorzLinesDef;
              FillRect(Rect(R.Left, R.Bottom, R.Right - WSep, R.Bottom + WVert));
            end;
          end;
        end;
        if edDigits in FDrawStyles then
        begin
          if AD.DigitsIn > 0 then
          begin
            R.Left := k;
            Inc(k, AD.DigitsIn * Data.CharWidth);
            R.Right := k;
            Brush.Color := cDigitBkGndDef;
            FillRect(Rect(R.Left + WSep, R.Top, R.Right, R.Bottom));
            if edHorzLines in FDrawStyles then
            begin
              Brush.Color := cHorzLinesDef;
              FillRect(Rect(R.Left + WSep, R.Bottom, R.Right, R.Bottom + WVert));
            end;
          end;
          Index := 0;
          for j := 0 to FLineSize - 1 do
          begin
            Index := i * FLineSize + j;
            DigitSep := (j < FLineSize - 1) and ((j + 1) mod FDigitGrouping = 0);
            R.Left := k;
            Inc(k, cDigitCount * Data.CharWidth);
            R.Right := k;
            if Index <= FSize then
            begin
              if Index < FSize then
                S := Format(cFmtText, [FBuffer[Index]])
              else
                S := '  ';
              if (Index <> FSelStart.Index) and (Index <> FSelEnd.Index) then
              begin
                SelCondition := (Index >= ASelStart.Index) and (Index < ASelEnd.Index);
                if (DrawNormal or Data.PaintSelection) and SelCondition then
                begin
                  PC1 := cLinesHighLightDef;
                  if (FEditArea = eaDigits) and (EditorFocused or Data.PaintSelection) then
                  begin
                    FC1 := cSelTextFocusedDef;
                    BC1 := cSelBkGndFocusedDef;
                  end
                  else
                  begin
                    FC1 := cSelTextDef;
                    BC1 := cSelBkGndDef;
                  end;
                  FC2 := cInactiveCaretSelTextDef;
                  BC2 := cInactiveCaretSelBkGndDef;
                end
                else
                begin
                  PC1 := cHorzLinesDef;
                  if DrawNormal or Data.PaintAll or SelCondition then
                    if (J div FDigitGrouping) and 1 = 0 then
                      FC1 := cDigitTextEvenDef
                    else
                      FC1 := cDigitTextOddDef
                  else
                    FC1 := cDigitBkGndDef;
                  BC1 := cDigitBkGndDef;
                  FC2 := cInactiveCaretTextDef;
                  BC2 := cInactiveCaretBkGndDef;
                end;
                Brush.Color := BC1;
                Font.Color := FC1;
                Brush.Style := bsSolid;
                FillRect(R);
                Brush.Style := bsClear;
                TextOut(R.Left, R.Top + VTextIndent, S[1]);
                TextOut(R.Left + Data.CharWidth, R.Top + VTextIndent, S[2]);
                if (Index = FSelEnd.Index) and DrawInactiveCaret then
                begin // draw inactive caret - place into previous drawn text
                  R1 := R;
                  Inc(R1.Left, Data.CharWidth * Min(FSelEnd.Digit, cDigitCount - 1));
                  R1.Right := R1.Left + Data.CharWidth;
                  Font.Color := FC2;
                  Brush.Color := BC2;
                  Brush.Style := bsSolid;
                  FillRect(R1);
                  Brush.Style := bsClear;
                  TextOut(R1.Left, R1.Top + VTextIndent, S);
                end;
                if edHorzLines in FDrawStyles then
                begin
                  Brush.Color := PC1;
                  Brush.Style := bsSolid;
                  FillRect(Rect(R.Left, R.Bottom, R.Right, R.Bottom + WVert));
                end;
              end
              else
              begin
                R1 := R;
                R1.Right := R1.Left;
                Inc(R1.Right, Data.CharWidth);
                for m := 0 to cDigitCount - 1 do
                begin
                  SelCondition := (ASelStart.Index = ASelEnd.Index) and ((m >= ASelStart.Digit) and (m < ASelEnd.Digit) or (m >= ASelEnd.Digit) and (m < ASelStart.Digit)) or
                    (ASelStart.Index <> ASelEnd.Index) and ((Index = ASelStart.Index) and (M >= ASelStart.Digit) or (Index = ASelEnd.Index) and (M < ASelEnd.Digit));
                  if (DrawNormal or Data.PaintSelection) and SelCondition then
                  begin
                    PC1 := cLinesHighLightDef;
                    if DrawInactiveCaret and (Index = FSelEnd.Index) and (m = FSelEnd.Digit) then
                    begin
                      FC1 := cInactiveCaretSelTextDef;
                      BC1 := cInactiveCaretSelBkGndDef;
                    end
                    else
                      if (FEditArea = eaDigits) and (EditorFocused or Data.PaintSelection) then
                      begin
                        FC1 := cSelTextFocusedDef;
                        BC1 := cSelBkGndFocusedDef;
                      end
                      else
                      begin
                        FC1 := cSelTextDef;
                        BC1 := cSelBkGndDef;
                      end;
                  end
                  else
                  begin
                    PC1 := cHorzLinesDef;
                    if DrawInactiveCaret and (Index = FSelEnd.Index) and (m = FSelEnd.Digit) then
                    begin
                      FC1 := cInactiveCaretTextDef;
                      BC1 := cInactiveCaretBkGndDef;
                    end
                    else
                    begin
                      if DrawNormal or Data.PaintAll or SelCondition then
                      begin
                        if (j div FDigitGrouping) and 1 = 0 then
                          FC1 := cDigitTextEvenDef
                        else
                          FC1 := cDigitTextOddDef;
                      end
                      else
                        FC1 := cDigitBkGndDef;
                      BC1 := cDigitBkGndDef;
                    end;
                  end;
                  Brush.Color := BC1;
                  Font.Color := FC1;
                  Brush.Style := bsSolid;
                  FillRect(R1);
                  Brush.Style := bsClear;
                  TextOut(R1.Left, R1.Top + VTextIndent, S[m + 1]);
                  if edHorzLines in FDrawStyles then
                  begin
                    Brush.Color := PC1;
                    Brush.Style := bsSolid;
                    FillRect(Rect(R1.Left, R1.Bottom, R1.Right, R1.Bottom + WVert));
                  end;
                  R1.Left := R1.Right;
                  Inc(R1.Right, Data.CharWidth);
                end;
              end;
              if DigitSep then
              begin
                if Index < FSize then
                  M := Data.CharWidth
                else
                  M := HalfPosWidth;
                Brush.Color := cDigitBkGndDef;
                Brush.Style := bsSolid;
                FillRect(Rect(R.Right, R.Top, R.Right + Data.CharWidth, R.Bottom));
                if edHorzLines in FDrawStyles then
                begin
                  Brush.Color := cHorzLinesDef;
                  FillRect(Rect(R.Right, R.Bottom, R.Right + M, R.Bottom + WVert));
                end;
                if edVertLines in FDrawStyles then
                begin
                  M := R.Right + HalfPosWidth;
                  Brush.Color := cVertLinesDef;
                  FillRect(Rect(M, R.Top, M + WHorz, R.Bottom));
                end;
                Inc(K, Data.CharWidth);
              end;
            end
            else
            begin
              Inc(K, Integer(DigitSep) * Data.CharWidth);
              Brush.Color := cDigitBkGndDef;
              Brush.Style := bsSolid;
              FillRect(Rect(R.Left, R.Top, K, R.Bottom + WVert));
            end;
          end;
          if AD.DigitsOut > 0 then
          begin
            R.Left := K;
            Inc(K, AD.DigitsOut * Data.CharWidth);
            R.Right := K;
            Brush.Color := cDigitBkGndDef;
            FillRect(Rect(R.Left, R.Top, R.Right - WSep, R.Bottom));
            if edHorzLines in FDrawStyles then
            begin
              if Index < FSize then
                Brush.Color := cHorzLinesDef
              else
                Brush.Color := cDigitBkGndDef;
              FillRect(Rect(R.Left, R.Bottom, R.Right - WSep, R.Bottom + WVert));
            end;
          end;
        end;
        if edText in FDrawStyles then
        begin
          if AD.TextIn > 0 then
          begin
            R.Left := K;
            Inc(K, AD.TextIn * Data.CharWidth);
            R.Right := K;
            Brush.Color := cTextBkGndDef;
            Brush.Style := bsSolid;
            FillRect(Rect(R.Left + WSep, R.Top, R.Right, R.Bottom));
            if edHorzLines in FDrawStyles then
            begin
              Brush.Color := cHorzLinesDef;
              FillRect(Rect(R.Left + WSep, R.Bottom, R.Right, R.Bottom + WVert));
            end;
          end;
          for j := 0 to FLineSize - 1 do
          begin
            Index := i * FLineSize + j;
            R.Left := k;
            Inc(K, Data.CharWidth);
            R.Right := k;
            if Index <= FSize then
            begin
              SelCondition := (Index >= ASelStart.Index) and (Index < ASelEnd.Index);
              if (DrawNormal or Data.PaintSelection) and SelCondition then
              begin
                PC1 := cLinesHighLightDef;
                if DrawInactiveCaret and (Index = FSelEnd.Index) then
                begin
                  FC1 := cInactiveCaretSelTextDef;
                  BC1 := cInactiveCaretSelBkGndDef;
                end
                else
                  if (FEditArea = eaText) and (EditorFocused or Data.PaintSelection) then
                  begin
                    FC1 := cSelTextFocusedDef;
                    BC1 := cSelBkGndFocusedDef;
                  end
                  else
                  begin
                    FC1 := cSelTextDef;
                    BC1 := cSelBkGndDef;
                  end;
              end
              else
              begin
                PC1 := cHorzLinesDef;
                if DrawInactiveCaret and (Index = FSelEnd.Index) then
                begin
                  FC1 := cInactiveCaretTextDef;
                  BC1 := cInactiveCaretBkGndDef;
                end
                else
                begin
                  if DrawNormal or Data.PaintAll or SelCondition then
                    FC1 := cTextTextDef
                  else
                    FC1 := cTextBkgndDef;
                  BC1 := cTextBkgndDef;
                end;
              end;
              Brush.Color := BC1;
              Brush.Style := bsSolid;
              FillRect(R);
              Brush.Style := bsClear;
              if Index < FSize then
              begin
                Font.Color := FC1;
                FStyle := Font.Style;
                Font.Style := [];
                TextOut(R.Left, R.Top + VTextIndent, FCharMapping[FBuffer[Index]]);
                Font.Style := FStyle;
              end;
              if edHorzLines in FDrawStyles then
              begin
                Brush.Color := PC1;
                Brush.Style := bsSolid;
                FillRect(Rect(R.Left, R.Bottom, R.Right, R.Bottom + WVert));
              end;
            end
            else
            begin
              Brush.Color := cTextBkGndDef;
              Brush.Style := bsSolid;
              FillRect(Rect(R.Left, R.Top, K, R.Bottom + WVert));
            end;
          end;
        end;
      end;
      Inc(R.Top, Data.CharHeight);
    end;
    // now complete blank areas below text and optionally paint separators
    k := LeftIndent;
    R.Bottom := Data.PaintRect.Bottom;
    Brush.Style := bsSolid;
    if edAddress in FDrawStyles then
    begin
      R.Left := k;
      Inc(k, (AD.Address + AD.AddressOut) * Data.CharWidth);
      R.Right := k;
      if FDrawStyles * [edDigits, edText] <> [] then
        Dec(R.Right, WSep);
      if R.Top < R.Bottom then
      begin
        Brush.Color := cAddressBkGndDef;
        FillRect(R);
      end;
      if (edSeparators in FDrawStyles) and (FDrawStyles * [edDigits, edText] <> []) then
      begin
        Brush.Color := cSeparatorsDef;
        FillRect(Rect(k - WSep, Data.PaintRect.Top, k + WSep, Data.PaintRect.Bottom));
      end;
    end;
    if edDigits in FDrawStyles then
    begin
      R.Left := k;
      if edAddress in FDrawStyles then
        Inc(R.Left, WSep);
      Inc(k, (AD.Digits + AD.DigitsIn + AD.DigitsOut) * Data.CharWidth);
      R.Right := k;
      if edText in FDrawStyles then
        Dec(R.Right, WSep);
      if R.Top < R.Bottom then
      begin
        Brush.Color := cDigitBkGndDef;
        FillRect(R);
      end;
      if (edSeparators in FDrawStyles) and (edText in FDrawStyles) then
      begin
        Brush.Color := cSeparatorsDef;
        FillRect(Rect(k - WSep, Data.PaintRect.Top, k + WSep, Data.PaintRect.Bottom));
      end;
    end;
    if edText in FDrawStyles then
    begin
      R.Left := k;
      if FDrawStyles * [edAddress, edDigits] <> [] then
        Inc(R.Left, WSep);
      Inc(k, (AD.TextIn + AD.Text) * Data.CharWidth);
      R.Right := k;
      if R.Top < R.Bottom then
      begin
        Brush.Color := cTextBkGndDef;
        FillRect(R);
      end;
    end;
    if k < ClientWidth then
    begin
      Brush.Color := cBkGndDef;
      FillRect(Rect(k, 0, ClientWidth, ClientHeight));
    end;
  end;
end;

procedure TCustomHexEditor.PaintToCanvas(ACanvas: TCanvas);
var
  Data: TEditorPaintData;
begin
  ACanvas.Font := Font;
  with Data do
  begin
    Canvas := ACanvas;
    PaintRect := ClientRect;
    LeftChar := FLeftChar;
    TopLine := FTopLine;
    CharWidth := FCharWidth;
    CharHeight := FCharHeight;
    BottomLine := TopLine + ClientHeight div FCharHeight;
    CharSpacing := FTotalCharSpacing;
    PaintSelection := False;
    CaretShown := elCaretVisible in FStates;
  end;
  PaintLines(Data);
end;

procedure TCustomHexEditor.PaintToCanvasEx(ACanvas: TCanvas; ARect: TRect; ALeftChar, ATopLine: Integer);
var
  Data: TEditorPaintData;
  Region: HRGN;
begin
  ACanvas.Font := Font;
  with Data do
  begin
    Canvas := ACanvas;
    PaintRect := ARect;
    LeftChar := ALeftChar;
    TopLine := ATopLine;
    CharWidth := FCharWidth;
    CharHeight := FCharHeight;
    BottomLine := TopLine + (ARect.Bottom - ARect.Top) div FCharHeight;
    CharSpacing := FTotalCharSpacing;
    PaintSelection := False;
  end;
  Region := CreateRectRgnIndirect(ARect);
  try
    SelectClipRgn(ACanvas.Handle, Region);
    try
      PaintLines(Data);
    finally
      SelectClipRgn(ACanvas.Handle, 0);
    end;
  finally
    DeleteObject(Region);
  end;
end;

function TCustomHexEditor.PointToSel(P: TPoint; OutOfArea: Boolean; var Area: TEditorArea): TEditorSelection;
var
  Digit, HalfPosWidth, i, X, X1, XMax: Integer;
  DigitSep: Boolean;
  AD: TAreaDimensions;
  Sel: TEditorSelection;
begin
  Result := MakeSelection(cInvalidIndex, 0);
  P.X := P.X + FLeftChar * FCharWidth;
  P.Y := P.Y div FCharHeight + FTopLine;
  AD := GetAreaDimensions;
  HalfPosWidth := FCharWidth div 2;
  X := 0;
  if OutOfArea then
    P.Y := MinMax(P.Y, 0, LineCount - 1)
  else
    Area := eaNone;
  if P.Y < LineCount then
  begin
    if edAddress in FDrawStyles then
    begin
      XMax := X + (AD.Address + AD.AddressOut) * FCharWidth;
      if not OutOfArea or (Area = eaAddress) then
        if (P.X >= X) and (P.X < XMax) then
        begin
          Result := MakeSelection(P.Y * FLineSize, 0);
          Area := eaAddress;
        end
        else
          if Area = eaAddress then // OutOfArea = True
          begin
            Result.Index := P.Y * FLineSize;
            if P.X >= XMax then
              Inc(Result.Index, FLineSize);
          end;
      X := XMax;
    end;
    if (P.X >= X) or OutOfArea then
    begin
      if edDigits in FDrawStyles then
      begin
        XMax := X + (AD.Digits + AD.DigitsIn + AD.DigitsOut) * FCharWidth;
        if not OutOfArea or (Area = eaDigits) then
          if (P.X >= X) and (P.X < XMax) then
          begin
            Inc(X, AD.DigitsIn * FCharWidth);
            for i := 0 to FLineSize - 1 do
            begin
              DigitSep := (i < FLineSize - 1) and ((i + 1) mod FDigitGrouping = 0);
              X1 := X;
              Inc(X, cDigitCount * FCharWidth);
              if DigitSep then
                Inc(X, HalfPosWidth)
              else
                if i = FLineSize - 1 then
                  Inc(X, AD.DigitsOut * FCharWidth);
              if P.X < X then
              begin
                Digit := (Max(P.X - X1, 0) + HalfPosWidth) div FCharWidth;
                Sel := MakeSelection(P.Y * FLineSize + i, Digit);
                if (Digit >= cDigitCount) and (Sel.Index < FSize) then // don't split the FSize character box
                begin
                  Inc(Sel.Index);
                  Sel.Digit := 0;
                end;
                if (Sel.Index <= FSize) or OutOfArea then
                begin
                  Result := Sel;
                  Area := eaDigits;
                end;
                Break;
              end;
              if DigitSep then
                Inc(X, HalfPosWidth);
            end;
          end
          else
            if Area = eaDigits then // OutOfArea = True
            begin
              Result.Index := P.Y * FLineSize;
              if P.X >= XMax then
                Inc(Result.Index, FLineSize);
            end;
        X := XMax;
      end;
      if ((P.X >= X) or OutOfArea) and (edText in FDrawStyles) then
      begin
        XMax := X + (AD.Text + AD.TextIn) * FCharWidth;
        if not OutOfArea or (Area = eaText) then
          if (P.X >= X) and (P.X < XMax) then
          begin
            Inc(X, AD.TextIn * FCharWidth);
            Sel := MakeSelection(P.Y * FLineSize, 0);
            i := Max(P.X - X, 0) div FCharWidth;
            if Sel.Index + i = FSize then
              Sel.Index := FSize // don't split the FSize character box
            else
              Inc(Sel.Index, (Max(P.X - X, 0) + HalfPosWidth) div FCharWidth);
            if (Sel.Index <= FSize) or OutOfArea then
            begin
              Result := Sel;
              Area := eaText;
            end;
          end
          else
            if Area = eaText then // OutOfArea = True
            begin
              Result.Index := P.Y * FLineSize;
              if P.X >= XMax then
                Inc(Result.Index, FLineSize);
            end;
      end;
    end;
  end;
  ValidateSelection(Result, Area);
end;

procedure TCustomHexEditor.SafeSetFocus;
var
  Form: TCustomForm;
begin
  Form := GetParentForm(Self);
  if (Form <> nil) and Form.Visible and Form.Enabled and not (csDestroying in Form.ComponentState)
    and Visible and Enabled then
      Form.ActiveControl := Self;
end;

procedure TCustomHexEditor.SaveToFile(const FileName: TFileName);
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TCustomHexEditor.SaveToStream(Stream: TStream);
begin
  if FBuffer <> nil then
    Stream.Write(FBuffer^, FSize);
end;

procedure TCustomHexEditor.ScrollBy(HChars, VChars: Integer; UpdateNeeded: Boolean);
begin
  if HChars <> 0 then
    ModifyScrollBar(SB_HORZ, cScrollDelta, HChars, UpdateNeeded);
  if VChars <> 0 then
    ModifyScrollBar(SB_VERT, cScrollDelta, VChars, UpdateNeeded);
end;

function DivDown(Dividend, Divisor: Integer): Integer;
begin
  if Divisor = 0 then
    Result := 0
  else
    if Dividend mod Divisor < 0 then
      Result := Dividend div Divisor - 1
    else
      Result := Dividend div Divisor;
end;

procedure TCustomHexEditor.ScrollTo(Point: TPoint; Timed, AlwaysScroll: Boolean);
var
  ScrollHorz: Boolean;
  R: TRect;
begin
  // disable horizontal overscroll when scrolling e.g. with mouse
  ScrollHorz := AlwaysScroll or (FSelEnd.Index mod FLineSize <> 0) and (FSelEnd.Index < FSize) or (FSelEnd.Digit > 0);
  R := GetModifiedClientRect;
  if ScrollHorz then
  begin
    if Point.X < R.Left then
      FScrollDeltaX := DivDown(Point.X, FCharWidth)
    else
      if Point.X >= R.Right then
        FScrollDeltaX := (Point.X - R.Right) div FCharWidth + 1
      else
        FScrollDeltaX := 0;
  end
  else
    FScrollDeltaX := 0;
  if Point.Y < R.Top then
    FScrollDeltaY := DivDown(Point.Y, FCharHeight)
  else
    if Point.Y >= R.Bottom then
      FScrollDeltaY := (Point.Y - R.Bottom) div FCharHeight + 1
    else
      FScrollDeltaY := 0;
  if (FScrollDeltaX <> 0) or (FScrollDeltaY <> 0) then
    if Timed then
    begin
      ScrollBy(FScrollDeltaX, FScrollDeltaY, False);
      FScrollTimer.Enabled := True;
    end
    else
      ScrollBy(FScrollDeltaX, FScrollDeltaY, True);
  UpdateSelEnd(Point, True);
end;

procedure TCustomHexEditor.ScrollTimerHandler(Sender: TObject);
var
  P: TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if (elMouseCapture in FStates) and not (Dragging or PtInRect(GetModifiedClientRect, P)) then
    ScrollTo(P, True, False)
  else
    FScrollTimer.Enabled := False;
end;

function TCustomHexEditor.SelAvail: Boolean;
begin
  Result := SelLength.Index > 0;
end;

procedure TCustomHexEditor.SelectionChanged(StartEqualEnd: Boolean; ScrollToView: Boolean = True);
begin
  ValidateSelection(FSelEnd, FEditArea);
  if StartEqualEnd then
    FSelStart := FSelEnd
  else
    ValidateSelection(FSelStart, FEditArea);
  if HasParent then
  begin
    if ScrollToView and (FEditArea <> eaNone) then
      ScrollTo(SelToPoint(FSelEnd, FEditArea), False, True);
    UpdateEditorCaret;
    Invalidate;
  end;
end;

function TCustomHexEditor.SelectionValid(Value: TEditorSelection; Area: TEditorArea): Boolean;
begin
  Result := (Area <> eaNone) and ((Value.Index >= 0) and (Value.Index < FSize) or (Value.Index = FSize) and (Value.Digit = 0))
end;

function TCustomHexEditor.SelToPoint(Value: TEditorSelection; Area: TEditorArea): TPoint;
var
  AD: TAreaDimensions;
begin
  Result := Point(0, 0);
  AD := GetAreaDimensions;
  ValidateSelection(Value, Area);
  if (Area = eaDigits) and (edDigits in FDrawStyles) then
    Result.X := ((Value.Index mod FLineSize) div FDigitGrouping * (cDigitCount * FDigitGrouping + 1) +
      (Value.Index mod FLineSize) mod FDigitGrouping * cDigitCount + Value.Digit + AD.DigitsIn)
  else
    if (Area = eaText) and (edText in FDrawStyles) then
      Result.X := (Value.Index mod FLineSize + AD.DigitsIn + AD.Digits + AD.DigitsOut + AD.TextIn)
    else
      if Area = eaAddress then
        if edDigits in FDrawStyles then
          Result.X := AD.DigitsIn
        else
          if edText in FDrawStyles then
            Result.X := AD.TextIn;
  Result.X := (Result.X + AD.Address + AD.AddressOut - FLeftChar) * FCharWidth;
  Result.Y := (Value.Index div FLineSize - FTopLine) * FCharHeight;
end;

procedure TCustomHexEditor.SetAddressCursor(Value: TCursor);
begin
  if Value <> FAddressCursor  then
  begin
    FAddressCursor := Value;
    UpdateMouseCursor;
  end;
end;

procedure TCustomHexEditor.SetAddressOffset(Value: Integer);
begin
  if Value <> FAddressOffset then
  begin
    FAddressOffset := Value;
    Invalidate;
  end;
end;

procedure TCustomHexEditor.SetAddressPrefix(const Value: string);
begin
  if Value <> FAddressPrefix then
  begin
    FAddressPrefix := Value;
    UpdateScrollRange;
  end;
end;

procedure TCustomHexEditor.SetAddressSize(Value: Integer);
begin
  Value := MinMax(Value, cAddressSizeMin, cAddressSizeMax);
  if Value <> FAddressSize then
  begin
    FAddressSize := Value;
    UpdateScrollRange;
  end;
end;

procedure TCustomHexEditor.SetAreaSpacing(Value: Integer);
begin
  Value := MinMax(Value, cAreaSpacingMin, cAreaSpacingMax);
  if Value <> FAreaSpacing then
  begin
    FAreaSpacing := Value;
    UpdateScrollRange;
  end;
end;

procedure TCustomHexEditor.SetCharMapping(const Value: TEditCharMapping);
begin
  if not CompareMem(@Value, @FCharMapping, SizeOf(TEditCharMapping)) and
    (edText in FDrawStyles) then
    Invalidate;
end;

procedure TCustomHexEditor.SetCharSpacing(Value: Integer);
begin
  Value := MinMax(Value, cCharSpacingMin, cCharSpacingMax);
  if Value <> FCharSpacing then
  begin
    FCharSpacing := Value;
    UpdateCharMetrics;
    UpdateScrollRange;
  end;
end;

procedure TCustomHexEditor.SetCommandKey(Index: TEditCommand; Value: TEditKey);
var
  i: Integer;
begin
  for i := 0 to Length(FKeyMapping) - 1 do
    if FKeyMapping[i].Command = Index then
    begin
      FKeyMapping[i].Key := Value;
      Exit;
    end;
end;

procedure TCustomHexEditor.SetData(Value: TDataSize);
begin
  if (Value.Data <> FBuffer) or (Value.Size <> FSize) then
  begin
    Clear;
    if Value.Data <> nil then
    begin
      FSize := Value.Size;
      GetMem(FBuffer, FSize);
      System.Move(Value.Data^, FBuffer^, FSize);
      BufferChanged;
    end;
  end;
end;

procedure TCustomHexEditor.SetDigitGrouping(Value: Integer);
begin
  Value := MinMax(Value, cDigitGroupingMin, Min(FLineSize, cDigitGroupingMax));
  if Value <> FDigitGrouping then
  begin
    FDigitGrouping := Value;
    UpdateScrollRange;
  end;
end;

procedure TCustomHexEditor.SetDisabledDrawStyle(Value: TDisabledDrawStyle);
begin
  if Value <> FDisabledDrawStyle then
  begin
    FDisabledDrawStyle := Value;
    if not Enabled then
      Invalidate;
  end;
end;

procedure TCustomHexEditor.SetDrawStyles(const Value: TEditorDrawStyles);
begin
  if Value <> FDrawStyles then
  begin
    FDrawStyles := Value;
    EditAreaChanged; // must be called first
    UpdateScrollRange;
  end;
end;

procedure TCustomHexEditor.SetEditArea(Value: TEditorArea);
begin
  if Value <> FEditArea then
  begin
    FEditArea := Value;
    EditAreaChanged;
    if Value <> FEditArea then
      Invalidate;
  end;
end;

procedure TCustomHexEditor.SetKeyMapping(const Value: TEditKeyMapping);
begin
  SetLength(FKeyMapping, Length(Value));
  Move(Value, FKeyMapping, Length(Value) * SizeOf(TCommandAssignment));
end;

procedure TCustomHexEditor.SetLineHeightPercent(Value: Integer);
begin
  Value := MinMax(Value, cLineHeightPercentMin, cLineHeightPercentMax);
  if Value <> FLineHeightPercent then
  begin
    FLineHeightPercent := Value;
    UpdateCharMetrics;
    UpdateScrollRange;
  end;
end;

procedure TCustomHexEditor.SetLeftChar(Value: Integer);
begin
  Value := MinMax(Value, 0, GetMaxLeftChar);
  if Value <> FLeftChar then
    ScrollBy(Value - FLeftChar, 0, True);
end;

procedure TCustomHexEditor.SetLines(Index: Integer; const Value: TDataSize);
var
  i, Size: Integer;
begin
  i := Index * FLineSize;
  if (Value.Data <> nil) and (Value.Size > 0) and (i >= 0) and (i <= FSize) then
  begin
    Size := Min(FLineSize, Value.Size);
    if (i + Size) > FSize then
    begin
      FSize := Size;
      ReallocMem(FBuffer, FSize);
    end;
    System.Move(Value.Data^, FBuffer[i], Size);
    BufferChanged;
  end;
end;

procedure TCustomHexEditor.SetLineSize(Value: Integer);
begin
  Value := MinMax(Value, cLineSizeMin, cLineSizeMax);
  if Value <> FLineSize then
  begin
    FLineSize := Value;
    UpdateScrollRange;
  end;
end;

procedure TCustomHexEditor.SetModified(Value: Boolean);
begin
  if Value <> GetModified then
  begin
    if Value then
      Include(FStates, elModified)
    else
    begin
      Exclude(FStates, elModified);
      if eoUndoAfterSave in FOptions then
        FUndoList.Modified := False
      else
      begin
        FUndoList.Clear;
        FRedoList.Clear;
      end;
    end;
  end;
end;

function TCustomHexEditor.SetMouseCursor(X, Y: Integer): Boolean;
var
  ACursor: TCursor;
  P: TPoint;
  Area: TEditorArea;
begin
  P := Point(X, Y);
  PointToSel(P, False, Area);
  if PtInRect(ClientRect, P) then
    case Area of
      eaAddress: ACursor := FAddressCursor;
      eaDigits: ACursor := crIBeam;
      eaText: ACursor := crIBeam;
    else
      ACursor := crDefault;
    end
  else
    ACursor := crDefault;
  Windows.SetCursor(Screen.Cursors[ACursor]);
  Result := True;
end;

procedure TCustomHexEditor.SetOptions(const Value: TEditOptions);
var
  UpdateDropFiles: Boolean;
begin
  if Value <> FOptions then
  begin
    UpdateDropFiles := (eoDropFiles in Value) <> (eoDropFiles in FOptions);
    FOptions := Value;
    // (un)register HWND as drop target
    if UpdateDropFiles and not (csDesigning in ComponentState) and HandleAllocated then
      DragAcceptFiles(Handle, (eoDropFiles in fOptions));
  end;
end;

procedure TCustomHexEditor.SetReadOnly(Value: Boolean);
begin
  if Value <> GetReadOnly then
  begin
    if Value then
      Include(FStates, elReadOnly)
    else
      Exclude(FStates, elReadOnly);
  end;
end;

procedure TCustomHexEditor.SetScrollBars(Value: System.UITypes.TScrollStyle);
begin
  if Value <> FScrollBars then
  begin
    FScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TCustomHexEditor.SetScrollSpeed(Value: Cardinal);
begin
  Value := MinMax(Integer(Value), cScrollSpeedMin, cScrollSpeedMax);
  if Value <> FScrollSpeed then
  begin
    FScrollSpeed := Value;
    FScrollTimer.Enabled := False;
    FScrollTimer.Interval := FScrollSpeed;
  end;
end;

procedure TCustomHexEditor.SetSelEnd(Value: TEditorSelection);
begin
  if (Value.Index <> FSelEnd.Index) or (Value.Digit <> FSelEnd.Digit) then
  begin
    FSelEnd := Value;
    SelectionChanged(False, False);
    Invalidate;
  end;
end;

procedure TCustomHexEditor.SetSelLength(Value: TEditorSelection);
var
  X: TEditorSelection;
begin
  X := GetSelLength;
  if (Value.Index <> X.Index) or (Value.Digit <> X.Digit) then
  begin
    FSelEnd.Index := FSelStart.Index + Value.Index;
    FSelEnd.Digit := FSelStart.Digit + Value.Digit;
    if FSelEnd.Digit >= cDigitCount then
      Inc(FSelEnd.Index);
    SelectionChanged(False, False);
    Invalidate;
  end;
end;

procedure TCustomHexEditor.SetSelStart(Value: TEditorSelection);
begin
  if (Value.Index <> FSelStart.Index) or (Value.Digit <> FSelStart.Digit) then
  begin
    FSelStart := Value;
    SelectionChanged(False, False);
    Invalidate;
  end;
end;

procedure TCustomHexEditor.SetTopLine(Value: Integer);
begin
  Value := MinMax(Value, 0, GetMaxTopLine);
  if Value <> FTopLine then
    ScrollBy(0, Value - FTopLine, True);
end;

procedure TCustomHexEditor.SetUndoLimit(Value: Integer);
begin
  Value := MinMax(Value, cUndoLimitMin, cUndoLimitMax);
  if Value <> FUndoList.Limit then
  begin
    FUndoList.Limit := Value;
    FRedoList.Limit := Value;
  end;
end;

procedure TCustomHexEditor.HideEditorCaret;
var
  P: TPoint;
begin
  P := SelToPoint(FSelEnd, FEditArea);
  HideCaret(Handle);
  SetCaretPos(P.X, P.Y + 1);
end;

procedure TCustomHexEditor.ShowEditorCaret;
var
  P: TPoint;
begin
  P := SelToPoint(FSelEnd, FEditArea);
  SetCaretPos(P.X, P.Y + 1);
  ShowCaret(Handle);
end;

procedure TCustomHexEditor.UndoChange(Sender: TObject; ItemReason: TChangeReason);
begin
  if (Sender = FUndoList) and (ItemReason <> crCaretPos) then
    DoChange;
end;

procedure TCustomHexEditor.UpdateEditorCaret(Recreate: Boolean = False);
var
  CW, CH: Integer;
begin
  Include(FStates, elCaretUpdate);
  try
    if Enabled and Focused and (FEditArea in [eaDigits, eaText]) and not (csDesigning in ComponentState) then
    begin
      if not (elCaretVisible in FStates) or Recreate then
      begin
        if elOverwrite in FStates then
          CW := FCharWidth
        else
          CW := Max(2, (Abs(Font.Height) * 2) div 25);
        if edHorzLines in FDrawStyles then
          CH := FCharHeight - Max(1, FCharHeight div 25)
        else
          CH := FCharHeight;
        if CreateCaret(Handle, 0, CW, CH - 2) then
          Include(FStates, elCaretVisible);
        Invalidate;
      end;
      if elCaretVisible in FStates then
        ShowEditorCaret;
    end else
    begin
      Exclude(FStates, elCaretVisible);
      HideEditorCaret;
      DestroyCaret;
    end;
  finally
    Exclude(FStates, elCaretUpdate);
  end;
end;

procedure TCustomHexEditor.UpdateCharMetrics;
var
  DC: HDC;
  TM: TTextMetric;
begin
  DC := GetDC(0);
  try
    SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, TM);
    FTotalCharSpacing := FCharSpacing * 2;
    // ensure even char spacing because of PointToSel
    if TM.tmAveCharWidth and 1 <> 0 then
      Inc(FTotalCharSpacing);
    FCharWidth := TM.tmAveCharWidth + FTotalCharSpacing;
    FCharHeight := TM.tmHeight * FLineHeightPercent div 100;
  finally
    ReleaseDC(0, DC);
  end;
end;

procedure TCustomHexEditor.UpdateMouseCursor;
var
  P: TPoint;
begin
  P := ScreenToClient(Mouse.CursorPos);
  SetMouseCursor(P.X, P.Y);
end;

procedure TCustomHexEditor.UpdateScrollRange;
var
  i: Integer;
  AD: TAreaDimensions;
  SI: TScrollInfo;
begin
  if HandleAllocated then
  begin
    AD := GetAreaDimensions;
    // update horizontal scroll position
    i := FLeftChar - GetMaxLeftChar(AD.TotalHorz);
    if i > 0 then
      Dec(FLeftChar, i);
    FLeftChar := Max(FLeftChar, 0);
    // update vertical scroll position
    i := FTopLine - GetMaxTopLine(AD.TotalVert);
    if i > 0 then
      Dec(FTopLine, i);
    FTopLine := Max(FTopLine, 0);
    if FScrollBars in [ssBoth, ssHorizontal, ssVertical] then
    begin
      SI.cbSize := SizeOf(TScrollInfo);
      SI.fMask := SIF_RANGE or SIF_PAGE or SIF_POS;
      SI.nMin := 0;
      if FScrollBars in [ssBoth, ssHorizontal] then
      begin
        SI.nMax := AD.TotalHorz - 1;
        SI.nPage := GetClientWidthChars;
        SI.nPos := FLeftChar;
        SetScrollInfo(Handle, SB_HORZ, SI, True);
        ShowScrollBar(Handle, SB_HORZ, Integer(SI.nPage) < AD.TotalHorz);
      end
      else
        ShowScrollBar(Handle, SB_HORZ, False);
      if FScrollBars in [ssBoth, ssVertical] then
      begin
        SI.nMax := AD.TotalVert - 1;
        SI.nPage := GetClientHeightChars;
        SI.nPos := FTopLine;
        SetScrollInfo(Handle, SB_VERT, SI, True);
        ShowScrollBar(Handle, SB_VERT, Integer(SI.nPage) < AD.TotalVert);
      end
      else
        ShowScrollBar(Handle, SB_VERT, False);
    end;
    UpdateEditorCaret(True);
    Invalidate;
  end;
end;

procedure TCustomHexEditor.UpdateSelEnd(Point: TPoint; ClipToClient: Boolean);
var
  R: TRect;
  Sel: TEditorSelection;
begin
  if ClipToClient then
  begin
    R := GetModifiedClientRect;
    Dec(R.Right, FCharWidth);
    Dec(R.Bottom, FCharHeight);
    if CanScroll(ecScrollLeft) and (Point.X < R.Left) then
      Point.X := R.Left
    else
      if CanScroll(ecScrollRight) and (Point.X > R.Right) then
        Point.X := R.Right;
    if CanScroll(ecScrollUp) and (Point.Y < R.Top) then
      Point.Y := R.Top
    else if CanScroll(ecScrollDown) and (Point.Y > R.Bottom) then
      Point.Y := R.Bottom;
  end;
  Sel := PointToSel(Point, True, FEditArea);
  if (Sel.Index <> cInvalidIndex) and ((Sel.Index <> FSelEnd.Index) or (Sel.Digit <> FSelEnd.Digit)) then
  begin
    FSelEnd := Sel;
    UpdateEditorCaret;
    Invalidate;
  end;
end;

procedure TCustomHexEditor.UpdateSize;
begin
  UpdateScrollRange;
end;

procedure TCustomHexEditor.ValidateSelection(var Value: TEditorSelection; Area: TEditorArea);
begin
  if Area <> eaNone then
  begin
    Value.Index := MinMax(Value.Index, 0, FSize);
    if Value.Index = FSize then
      Value.Digit := 0
    else
      Value.Digit := MinMax(Value.Digit, 0, cDigitCount - 1);
  end
  else
    Value := MakeSelection(cInvalidIndex, 0);
end;

procedure TCustomHexEditor.WMDropFiles(var Msg: TMessage);
var
  i, FileCount: Integer;
  PathName: array[0..260] of Char;
  Point: TPoint;
  FilesList: TStringList;
begin
  try
    if Assigned(FOnDropFiles) then
    begin
      FilesList := TStringList.Create;
      try
        FileCount := DragQueryFile(THandle(Msg.wParam), Cardinal(-1), nil, 0);
        DragQueryPoint(THandle(Msg.wParam), Point);
        for i := 0 to FileCount - 1 do
        begin
          DragQueryFile(THandle(Msg.wParam), i, PathName, SizeOf(PathName));
          FilesList.Add(PathName);
        end;
        FOnDropFiles(Self, Point.X, Point.Y, FilesList);
      finally
        FilesList.Free;
      end;
    end;
  finally
    Msg.Result := 0;
    DragFinish(THandle(Msg.wParam));
  end;
end;

procedure TCustomHexEditor.WMEraseBkgnd(var Msg: TMessage);
begin
  Msg.Result := 1;
end;

procedure TCustomHexEditor.WMGetDlgCode(var Msg: TWMNoParams);
begin
  Msg.Result := DLGC_WANTARROWS;
end;

procedure TCustomHexEditor.WMHScroll(var Msg: TWMHScroll);
begin
  SafeSetFocus;
  ModifyScrollBar(SB_HORZ, Msg.ScrollCode, Msg.Pos, True);
end;

procedure TCustomHexEditor.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  ExecuteCommand(ecLostFocus);
end;

procedure TCustomHexEditor.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  ExecuteCommand(ecGotFocus);
end;

procedure TCustomHexEditor.WMVScroll(var Msg: TWMVScroll);
begin
  SafeSetFocus;
  ModifyScrollBar(SB_VERT, Msg.ScrollCode, Msg.Pos, True);
end;

end.
