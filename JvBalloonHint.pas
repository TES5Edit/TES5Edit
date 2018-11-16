{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvBalloonHint.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is Remko Bonte <remkobonte att myrealbox dott com>
Portions created by Remko Bonte are Copyright (C) 2002 Remko Bonte.
All Rights Reserved.

Contributor(s):

  2006-01-17 - J. Vignoles - Added support for Unicode hint and header

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.delphi-jedi.org

Known Issues:
  * Only dropdown shadow for windows xp systems.
  * Only custom animation for windows xp systems, because of use of window region.
-----------------------------------------------------------------------------}
// $Id$

unit JvBalloonHint;

{$I jvcl.inc}
{$I windowsonly.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Windows, Messages, Classes, Forms, Controls, Graphics, ImgList,
  {$IFDEF HAS_UNIT_SYSTEM_UITYPES}
  System.UITypes,
  {$ENDIF HAS_UNIT_SYSTEM_UITYPES}
  {$IFDEF JVCLThemesEnabled}
  UxTheme,
  {$ENDIF JVCLThemesEnabled}
  JvComponentBase;

const
  cJvBallonHintVisibleTimeDefault = 5000;

type
  TJvStemSize = (ssExtraSmall, ssSmall, ssNormal, ssLarge);
  TJvIconKind = (ikCustom, ikNone, ikApplication, ikError, ikInformation, ikQuestion, ikWarning);
  TJvBalloonOption = (boUseDefaultHeader, boUseDefaultIcon, boUseDefaultImageIndex,
    boShowCloseBtn, boCustomAnimation, boPlaySound);
  TJvBalloonOptions = set of TJvBalloonOption;
  TJvApplicationHintOption = (ahShowHeaderInHint, ahShowIconInHint, ahPlaySound);
  TJvApplicationHintOptions = set of TJvApplicationHintOption;
  TJvBalloonPosition = (bpAuto, bpLeftDown, bpRightDown, bpLeftUp, bpRightUp);
  TJvAnimationStyle = (atNone, atSlide, atRoll, atRollHorNeg, atRollHorPos, atRollVerNeg,
    atRollVerPos, atSlideHorNeg, atSlideHorPos, atSlideVerNeg, atSlideVerPos, atCenter, atBlend);

  TJvBalloonHint = class;

  PHintData = ^THintData;
  THintData = record
    RAnchorWindow: TCustomForm;
    { Position of the top-left edge of the window balloon inside the client
      rect of the anchor window (Used to move the balloon window if the
      anchor window moves): }
    RAnchorPosition: TPoint;
    { Position of the stem point inside the client rect of the balloon window
      (Used the check on resize of the anchor window whether the stem point is
      still inside the balloon window): }
    RStemPointPosition: TPoint;
    RUTF8Header: {$IFDEF RTL200_UP}UTF8String{$ELSE}string{$ENDIF RTL200_UP};
    RUTF8Hint: {$IFDEF RTL200_UP}UTF8String{$ELSE}string{$ENDIF RTL200_UP};
    RIconKind: TJvIconKind;
    RImageIndex: TImageIndex;
    RVisibleTime: Integer;
    RShowCloseBtn: Boolean;
    RAnimationStyle: TJvAnimationStyle;
    RAnimationTime: Cardinal;
    { If the position of the balloon needs to be changed - for example if
      DefaultBalloonPosition = bpAuto - RSwitchHeight indicates how much we
      change the vertical position; if the balloon is an application hint,
      RSwitchHeight is the height of the cursor; if the balloon is attached to
      a control, RSwitchHeight is the height of that control }
    RSwitchHeight: Integer;
  end;

  TJvBalloonWindow = class(THintWindow)
  private
    FCurrentPosition: TJvBalloonPosition;
    FSwitchHeight: Integer;
    FShowIcon: Boolean;
    FShowHeader: Boolean;
    FMsg: WideString;
    FHeader: WideString;
    FTipHeight: Integer;
    FTipWidth: Integer;
    FTipDelta: Integer;
    FImageSize: TSize;

    FIconPos: TPoint;
    FRoundRect: TRect;
    FStemRect: TRect;
    FMsgRect: TRect;
    FHeaderRect: TRect;
    FCloseBtnRect: TRect;
    FShowCloseBtn: Boolean;
    FIsMultiLineMsg: Boolean;
    FUseRegion: Boolean;

    function GetStemPointPosition: TPoint;
    function GetStemPointPositionInRect(const ARect: TRect): TPoint;
    function MultiLineWidth(const Value: string): Integer;
  protected
    procedure CMTextChanged(var Msg: TMessage); message CM_TEXTCHANGED;
    procedure CMShowingChanged(var Msg: TMessage); message CM_SHOWINGCHANGED;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure NCPaint(DC: HDC); override;
    procedure Paint; override;

    {$IFDEF JVCLThemesEnabled}
    function CreateThemedRegion: HRGN;
    {$ENDIF JVCLThemesEnabled}
    function CreateRegion: HRGN;
    procedure UpdateRegion;
    procedure CalcAutoPosition(var ARect: TRect);
    procedure CheckPosition(var ARect: TRect);

    function CalcOffset(const ARect: TRect): TPoint;
    procedure MeasureHeader(const MaxWidth: Integer; var AWidth, AHeight: Integer); virtual;
    procedure MeasureMsg(const MaxWidth: Integer; var AWidth, AHeight: Integer); virtual;
    procedure Init(AData: Pointer); virtual;
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ActivateHint(Rect: TRect; const AHint: string); override;
    function CalcHintRect(MaxWidth: Integer; const AHint: string;
      AData: Pointer): TRect; override;
    function CalcHintRectUTF8(MaxWidth: Integer; const AUTF8Hint: {$IFDEF RTL200_UP}UTF8String{$ELSE}string{$ENDIF RTL200_UP};
      AData: Pointer): TRect; virtual;
    function CalcHintRectW(MaxWidth: Integer; const AHint: WideString;
      AData: Pointer): TRect; virtual;
    property StemPointPosition: TPoint read GetStemPointPosition;
  end;

  TJvBalloonWindowEx = class(TJvBalloonWindow)
  private
    FCtrl: TJvBalloonHint;
    FCloseState: Cardinal;
    FImageIndex: TImageIndex;
    FIconKind: TJvIconKind;
    FAnimationTime: Cardinal;
    FAnimationStyle: TJvAnimationStyle;
    FIsAnchored: Boolean;
  protected
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMActivateApp(var Msg: TWMActivateApp); message WM_ACTIVATEAPP;

    procedure Paint; override;

    { Either calls NormalizeTopMost or RestoreTopMost depending on whether the
      anchor window has focus }
    procedure EnsureTopMost;
    { Sets the balloon on top of anchor window; but below other windows }
    procedure NormalizeTopMost;
    { Sets the balloon top most }
    procedure RestoreTopMost;

    procedure InternalActivateHint(var Rect: TRect; const AHint: string);
    procedure MoveWindow(NewPos: TPoint);
    procedure ChangeCloseState(const AState: Cardinal);

    procedure Init(AData: Pointer); override;
  end;

  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF RTL230_UP}
  TJvBalloonHint = class(TJvComponent)
  private
    FHint: TJvBalloonWindowEx;
    FActive: Boolean;
    FOptions: TJvBalloonOptions;
    FImages: TCustomImageList;
    FDefaultHeader: WideString;
    FDefaultIcon: TJvIconKind;
    FDefaultImageIndex: TImageIndex;
    FData: THintData;
    FApplicationHintOptions: TJvApplicationHintOptions;
    FDefaultBalloonPosition: TJvBalloonPosition;
    FCustomAnimationTime: Cardinal;
    FCustomAnimationStyle: TJvAnimationStyle;

    FOnBalloonClick: TNotifyEvent;
    FOnClose: TNotifyEvent;
    FOnCloseBtnClick: TCloseQueryEvent;
    FOnDblClick: TNotifyEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;

    FHandle: THandle;
    FTimerActive: Boolean;
    FMaxWidth: Integer;

    function GetHandle: THandle;
    function GetUseBalloonAsApplicationHint: Boolean;
    procedure SetImages(const Value: TCustomImageList);
    procedure SetOptions(const Value: TJvBalloonOptions);
    procedure SetUseBalloonAsApplicationHint(const Value: Boolean);
  protected
    function HookProc(var Msg: TMessage): Boolean;
    procedure Hook;
    procedure UnHook;

    procedure HandleMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure HandleMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure HandleMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure HandleClick(Sender: TObject);
    procedure HandleDblClick(Sender: TObject);
    function HandleCloseBtnClick: Boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure StartHintTimer(Value: Integer);
    procedure StopHintTimer;

    procedure InternalActivateHintPos;
    procedure InternalActivateHint(ACtrl: TControl);

    procedure WndProc(var Msg: TMessage);

    property Handle: THandle read GetHandle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ActivateHint(ACtrl: TControl; const AHint: WideString; const AHeader: WideString = '';
      const VisibleTime: Integer = cJvBallonHintVisibleTimeDefault); overload;
    procedure ActivateHint(ACtrl: TControl; const AHint: WideString; const AImageIndex: TImageIndex;
      const AHeader: WideString = ''; const VisibleTime: Integer = cJvBallonHintVisibleTimeDefault); overload;
    procedure ActivateHint(ACtrl: TControl; const AHint: WideString; const AIconKind: TJvIconKind;
      const AHeader: WideString = ''; const VisibleTime: Integer = cJvBallonHintVisibleTimeDefault); overload;
    procedure ActivateHintPos(AAnchorWindow: TCustomForm; AAnchorPosition: TPoint;
      const AHeader, AHint: WideString; const VisibleTime: Integer = cJvBallonHintVisibleTimeDefault;
      const AIconKind: TJvIconKind = ikInformation; const AImageIndex: TImageIndex = -1);
    procedure ActivateHintRect(ARect: TRect; const AHeader, AHint: WideString;
      const VisibleTime: Integer = cJvBallonHintVisibleTimeDefault; const AIconKind: TJvIconKind = ikInformation;
      const AImageIndex: TImageIndex = -1);
    procedure CancelHint;

    property Active: Boolean read FActive;
  published
    property CustomAnimationStyle: TJvAnimationStyle read FCustomAnimationStyle write
      FCustomAnimationStyle default atBlend;
    property CustomAnimationTime: Cardinal read FCustomAnimationTime write FCustomAnimationTime
      default 100;
    property DefaultBalloonPosition: TJvBalloonPosition read FDefaultBalloonPosition write
      FDefaultBalloonPosition default bpAuto;
    property DefaultImageIndex: TImageIndex read FDefaultImageIndex write FDefaultImageIndex
      default -1;
    property DefaultHeader: WideString read FDefaultHeader write FDefaultHeader;
    property DefaultIcon: TJvIconKind read FDefaultIcon write FDefaultIcon default ikInformation;
    property Images: TCustomImageList read FImages write SetImages;
    property Options: TJvBalloonOptions read FOptions write SetOptions default [boShowCloseBtn];
    property ApplicationHintOptions: TJvApplicationHintOptions read FApplicationHintOptions write
      FApplicationHintOptions default [ahShowHeaderInHint, ahShowIconInHint];
    property UseBalloonAsApplicationHint: Boolean read GetUseBalloonAsApplicationHint write
      SetUseBalloonAsApplicationHint default False;

    property MaxWidth: Integer read FMaxWidth write FMaxWidth default 0;

    property OnBalloonClick: TNotifyEvent read FOnBalloonClick write FOnBalloonClick;
    property OnCloseBtnClick: TCloseQueryEvent read FOnCloseBtnClick write FOnCloseBtnClick;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL$';
    Revision: '$Revision$';
    Date: '$Date$';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  SysUtils, Math, AppEvnts,
  Registry, CommCtrl, MMSystem,
  {$IFDEF JVCLThemesEnabled}
  {$IFNDEF COMPILER7_UP}
  TmSchema,
  {$ENDIF !COMPILER7_UP}
  {$ENDIF JVCLThemesEnabled}
  {$IFDEF SUPPORTS_INLINE}
  Types,
  {$ENDIF SUPPORTS_INLINE}
  ComCtrls, // needed for GetComCtlVersion
  JclSysInfo,
  {$IFNDEF COMPILER12_UP}
  JvJCLUtils,
  {$ENDIF ~COMPILER12_UP}
  JvJVCLUtils, JvThemes, JvWndProcHook, JvWin32,
  JclStringConversions, JclUnicode;

const
  { TJvStemSize = (ssSmall, ssNormal, ssLarge);
    ssLarge isn't used (yet)
  }
  cTipHeight: array [TJvStemSize] of Integer = (12, 19, 21, 24);
  cTipWidth: array [TJvStemSize] of Integer = (12, 19, 21, 24);
  cTipDelta: array [TJvStemSize] of Integer = (16, 16, 16, 17);
  DefaultTextFlags: Longint = DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX;

{$IFDEF JVCLThemesEnabled}
const
  {$IFNDEF DELPHI11_UP}
  TTBSS_POINTINGUPLEFTWALL = 1;
  TTBSS_POINTINGUPCENTERED = 2;
  TTBSS_POINTINGUPRIGHTWALL = 3;
  TTBSS_POINTINGDOWNRIGHTWALL = 4;
  TTBSS_POINTINGDOWNCENTERED = 5;
  TTBSS_POINTINGDOWNLEFTWALL = 6;

  TTP_BALLOONSTEM = 6;
  {$ENDIF !DELPHI11_UP}

  cBalloonStemState: array [TJvBalloonPosition] of Integer = (
    TTBSS_POINTINGUPRIGHTWALL, // bpAuto
    TTBSS_POINTINGUPRIGHTWALL, // bpLeftDown
    TTBSS_POINTINGUPLEFTWALL, // bpRightDown
    TTBSS_POINTINGDOWNRIGHTWALL, // bpLeftUp
    TTBSS_POINTINGDOWNLEFTWALL // bpRightUp
    );
{$ENDIF JVCLThemesEnabled}

// Unicode wrapping around DrawTextW  so that if ran under Win98/Me, it
// continues to work.
type
  TDrawTextW = function(hDC: HDC; lpString: PWideChar; nCount: Integer;
    var lpRect: TRect; uFormat: UINT): Integer; stdcall;

var
  _DrawTextW: TDrawTextW = nil;
  {$IFDEF JVCLStylesEnabled}
  _ToolTipThemeHandle: HTHEME = 0;
  {$ENDIF JVCLStylesEnabled}

procedure InitUnicodeWrap;
var
  UserHandle: HMODULE;
begin
  { The system DLLs for Windows 98 have export symbols for wide character
    functions as well, but they all return FALSE, and GetLastError would return
    ERROR_CALL_NOT_IMPLEMENTED (120), so don't try to load DrawTextW for
    Windows 98 }

  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    { All Windows programs already load user32.dll so we can use GetModuleHandle }
    UserHandle := GetModuleHandle('USER32');
    if UserHandle <> 0 then
      @_DrawTextW := GetProcAddress(UserHandle, 'DrawTextW');
  end;
end;

function DrawTextW(hDC: HDC; const WS: WideString; var lpRect: TRect; uFormat: UINT): Integer;
var
  S: string;
begin
  if Assigned(_DrawTextW) then
    Result := _DrawTextW(hDC, PWideChar(WS), Length(WS), lpRect, uFormat)
  else
  begin
    { The Microsoft Layer for Unicode dll UNICOWS.DLL does probably the same as
      the following: }
    S := WideCharLenToString(PWideChar(WS), Length(WS));
    Result := DrawTextA(hDC, PAnsiChar(AnsiString(S)), Length(S), lpRect, uFormat);
  end;
end;

function WorkAreaRect: TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0);
end;

function DesktopRect: TRect;
begin
  Result := Rect(GetSystemMetrics(SM_XVIRTUALSCREEN),
                 GetSystemMetrics(SM_YVIRTUALSCREEN),
                 GetSystemMetrics(SM_CXVIRTUALSCREEN),
                 GetSystemMetrics(SM_CYVIRTUALSCREEN));
end;

function IsWinXP_UP: Boolean;
begin
  Result := (Win32Platform = VER_PLATFORM_WIN32_NT) and JclCheckWinVersion(5, 1);
end;

function IsWinVista_UP: Boolean;
begin
  Result := (Win32Platform = VER_PLATFORM_WIN32_NT) and JclCheckWinVersion(6, 0);
end;

function IsWinSeven_UP: Boolean;
begin
  Result := (Win32Platform = VER_PLATFORM_WIN32_NT) and JclCheckWinVersion(6, 1);
end;

function InternalClientToParent(AControl: TControl; const Point: TPoint;
  AParent: TWinControl): TPoint;
begin
  Result := AControl.ClientToParent(Point, AParent);
end;

{$IFDEF JVCLThemesEnabled}
function GetToolTipThemeHandle: HTHEME;
begin
  {$IFDEF JVCLStylesEnabled}
  if not StyleServices.IsSystemStyle then
  begin
    // Styles don't implement BaloonTips, so we use the System style
    if (_ToolTipThemeHandle = 0) and Assigned(OpenThemeData) then
      _ToolTipThemeHandle := OpenThemeData(Application.Handle, 'tooltip');
    Result := _ToolTipThemeHandle;
  end
  else
  {$ENDIF JVCLStylesEnabled}
    Result := StyleServices.Theme[teToolTip];
end;

{$IFDEF JVCLStylesEnabled}
procedure CloseToolTipThemeHandle;
begin
  if (_ToolTipThemeHandle <> 0) and Assigned(CloseThemeData) then
  begin
    CloseThemeData(_ToolTipThemeHandle);
    _ToolTipThemeHandle := 0;
  end;
end;
{$ENDIF JVCLStylesEnabled}
{$ENDIF JVCLThemesEnabled}

procedure GetHintMessageFont(AFont: TFont);
begin
  AFont.Assign(Screen.HintFont);
  AFont.Style := AFont.Style - [fsBold];
end;

procedure GetHintTitleFont(AFont: TFont);
{$IFDEF JVCLThemesEnabled}
var
  AThemedTextColor: Integer;
  Result: Boolean;
  LogFontW: TLogFontW;
{$ENDIF JVCLThemesEnabled}
begin
  {$IFDEF JVCLThemesEnabled}
  if IsWinVista_UP and StyleServices.Enabled then
  begin
    Result := GetThemeEnumValue(GetToolTipThemeHandle, TTP_BALLOONTITLE, 0, TMT_TEXTCOLOR, AThemedTextColor) = S_OK;
    if Result then
    begin
      // GetThemeFont is defined wrong; so cast it
      Result := GetThemeFont(GetToolTipThemeHandle, 0, TTP_BALLOONTITLE, 0,
        TMT_FONT, {$IFDEF COMPILER12_UP}PLogFontW{$ELSE}PLogFontA{$ENDIF COMPILER12_UP}(@LogFontW)^) = S_OK;

      if Result then
      begin
        AFont.Color := AThemedTextColor;
        AFont.Handle := CreateFontIndirectW(LogFontW);
        Exit;
      end;
    end;
  end;
  {$ENDIF JVCLThemesEnabled}
  AFont.Assign(Screen.HintFont);
  AFont.Style := AFont.Style + [fsBold];
end;

function IsMultiLineStr(const Value: WideString): Boolean;
var
  Head, Tail: PWideChar;
  LineCount: Integer;
begin
  // stripped copy of TWideStrings.SetText
  LineCount := 0;
  Head := PWideChar(Value);
  while (Head^ <> WideNull) and (LineCount < 2) do
  begin
    Tail := Head;
    while True do
    begin
      case Tail^ of
        WideNull, WideLineFeed, WideCarriageReturn, WideVerticalTab, WideFormFeed,
        WideLineSeparator, WideParagraphSeparator:
          Break;
      end;
      Inc(Tail);
    end;
    Inc(LineCount);
    Head := Tail;
    if Head^ <> WideNull then
    begin
      Inc(Head);
      if (Tail^ = WideCarriageReturn) and (Head^ = WideLineFeed) then
        Inc(Head);
    end;
  end;
  Result := LineCount >= 2;
end;

type
  TGlobalCtrl = class(TComponent)
  private
    FBkColor: TColor;
    FMainCtrl: TJvBalloonHint;
    FDefaultImages: TImageList;
    FNeedUpdateBkColor: Boolean;
    FOldHintWindowClass: THintWindowClass;
    FSounds: array [TJvIconKind] of string;
    FUseBalloonAsApplicationHint: Boolean;
    FDesigning: Boolean;
    FAppEvents: TApplicationEvents;
    function GetMainCtrl: TJvBalloonHint;
    procedure GetDefaultImages;
    procedure GetDefaultSounds;
    procedure SetBkColor(const Value: TColor);
    procedure SetUseBalloonAsApplicationHint(const Value: Boolean);
    procedure SetMainCtrl(const Value: TJvBalloonHint);
    procedure AppEventsShowHint(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function HintImageSize: TSize; overload;
    function HintImageSize(const AIconKind: TJvIconKind;
      const AImageIndex: TImageIndex): TSize; overload;
    procedure DrawHintImage(Canvas: TCanvas; X, Y: Integer; const ABkColor: TColor); overload;
    procedure DrawHintImage(Canvas: TCanvas; X, Y: Integer; const AIconKind: TJvIconKind;
      const AImageIndex: TImageIndex; const ABkColor: TColor); overload;
    procedure PlaySound(const AIconKind: TJvIconKind);

    property BkColor: TColor read FBkColor write SetBkColor;
    property MainCtrl: TJvBalloonHint read GetMainCtrl write SetMainCtrl;
    property UseBalloonAsApplicationHint: Boolean read FUseBalloonAsApplicationHint
      write SetUseBalloonAsApplicationHint;
  end;

var
  GGlobalCtrl: TGlobalCtrl = nil;
  { A TJvBalloonHint may be needed, while there isn't an instance of it around.
    For example, if the user sets HintWindowClass to TJvBalloonWindow.
  }
  GMainCtrl: TJvBalloonHint = nil;

function GlobalCtrl: TGlobalCtrl;
begin
  if not Assigned(GGlobalCtrl) then
    GGlobalCtrl := TGlobalCtrl.Create(nil);
  Result := GGlobalCtrl;
end;

//=== { TJvBalloonWindow } ===================================================

constructor TJvBalloonWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks];
end;

var
  OldAnimateWindowProc: TAnimateWindowProc;

function JvAnimateWindowProc(hWnd: HWND; dwTime: DWORD; dwFlags: DWORD): BOOL; stdcall;
begin
  SendMessage(hWnd, CM_RECREATEWND, 0, 0);
  Result := OldAnimateWindowProc(hWnd, dwTime, dwFlags);
end;

{$IFNDEF COMPILER7_UP}
const
  ComCtlVersionIE6 = $00060000;
{$ENDIF !COMPILER7_UP}

procedure TJvBalloonWindow.ActivateHint(Rect: TRect; const AHint: string);
var
  Delta: Integer;
begin
  ParentWindow := Application.Handle;
  if IsWinVista_UP and (GetComCtlVersion >= ComCtlVersionIE6) then
    RecreateWnd;
  if HandleAllocated and IsWindowVisible(Handle) then
    ShowWindow(Handle, SW_HIDE);

  if UseRightToLeftAlignment then
  begin
    // Remove the offset set by TApplication.ActivateHint
    Delta := MultiLineWidth(AHint) + 5;
    Inc(Rect.Left, Delta);
    Inc(Rect.Right, Delta);
  end;
  CheckPosition(Rect);
  UpdateRegion;

  Inc(Rect.Bottom, 4);
  UpdateBoundsRect(Rect);
  Dec(Rect.Bottom, 4);

  if ahPlaySound in GlobalCtrl.MainCtrl.ApplicationHintOptions then
    GlobalCtrl.PlaySound(GlobalCtrl.MainCtrl.DefaultIcon);
  if IsWinVista_UP and (GetComCtlVersion < ComCtlVersionIE6) then
  begin
    OldAnimateWindowProc := AnimateWindowProc;
    AnimateWindowProc := JvAnimateWindowProc;
    try
      inherited ActivateHint(Rect, AHint);
    finally
      AnimateWindowProc := OldAnimateWindowProc;
    end;
  end
  else
    inherited ActivateHint(Rect, AHint);
end;

procedure TJvBalloonWindow.CalcAutoPosition(var ARect: TRect);
var
  NewPosition: TJvBalloonPosition;
  ScreenRect: TRect;
  LStemPointPosition: TPoint;
  Pt: TPoint;
begin
  { bpAuto returns the same value as bpLeftDown; bpLeftDown is choosen
    arbitrary }
  FCurrentPosition := bpLeftDown;
  ScreenRect := {>>>WorkAreaRect}DesktopRect{<<<};

  { Note: 2*(Left + Width div 2) = 2*(Left + (Right-Left) div 2) ~=
          2*Left + (Right-Left) = Left + Right;

          Thus multiply everything with 2

         Monitor:
     |---------------|
     |       |       |
     |   1   |   2   |
     |       |       |
     |---------------|
     |       |       |
     |   3   |   4   |
     |       |       |
     |---------------|

  }
  Pt := GetStemPointPositionInRect(ARect);
  LStemPointPosition := Point(Pt.X * 2, Pt.Y * 2);

  if LStemPointPosition.Y < ScreenRect.Top + ScreenRect.Bottom then
  begin
    if LStemPointPosition.X < ScreenRect.Left + ScreenRect.Right then
      { 1 }
      NewPosition := bpLeftUp
    else
      { 2 }
      NewPosition := bpRightUp;
  end
  else
  begin
    if LStemPointPosition.X < ScreenRect.Left + ScreenRect.Right then
      { 3 }
      NewPosition := bpLeftDown
    else
      { 4 }
      NewPosition := bpRightDown;
  end;

  if NewPosition <> FCurrentPosition then
  begin
    { Reset the offset.. }
    Pt := CalcOffset(ARect);
    OffsetRect(ARect, -Pt.X, -Pt.Y);

    FCurrentPosition := NewPosition;

    { ..and set the offset }
    Pt := CalcOffset(ARect);
    OffsetRect(ARect, Pt.X, Pt.Y);
  end;
end;

function TJvBalloonWindow.CalcHintRect(MaxWidth: Integer; const AHint: string;
  AData: Pointer): TRect;
begin
  // Mantis 3855: CalcHintRect is called by the VCL code and gives a non
  // UTF-8 string. However, this string may contain characters above 127 which
  // would then be interpreted as UTF-8 markers. So when you are sure the
  // string for the hint is UTF-8, use CalcHintRectUTF8 below. This is what is
  // done by the TJvBalloonHint.InternalActivateHintPos code.
  // In any case the CalcHintRectW function is called in the end.
  Result := CalcHintRectW(MaxWidth, WideString(AHint), AData);
end;

function TJvBalloonWindow.CalcHintRectUTF8(MaxWidth: Integer;
  const AUTF8Hint: {$IFDEF RTL200_UP}UTF8String{$ELSE}string{$ENDIF RTL200_UP}; AData: Pointer): TRect;
begin
  Result := CalcHintRectW(MaxWidth, {$IFDEF RTL200_UP}System.{$ENDIF RTL200_UP}UTF8ToWideString(AUTF8Hint), AData);
end;

function TJvBalloonWindow.CalcHintRectW(MaxWidth: Integer;
  const AHint: WideString; AData: Pointer): TRect;
var
  ASize: TSize;
  StemSize: TJvStemSize;
  Pt: TPoint;
begin
  FUseRegion := False;
  Init(AData);

  FMsg := AHint;
  FIsMultiLineMsg := IsMultiLineStr(FMsg);

  if FShowIcon then
  begin
    if IsWinVista_UP and (GetComCtlVersion >= ComCtlVersionIE6) then
      FIconPos := Point(12, 12)
    else
      FIconPos := Point(12, 9);
  end;

  SetRectEmpty(FHeaderRect);
  MeasureHeader(MaxWidth, FHeaderRect.Right, FHeaderRect.Bottom);
  if not IsRectEmpty(FHeaderRect) then
  begin
    if IsWinVista_UP and (GetComCtlVersion >= ComCtlVersionIE6) then
      OffsetRect(FHeaderRect, 12, 9)
    else
      OffsetRect(FHeaderRect, 12, 10)
  end;

  SetRectEmpty(FMsgRect);
  MeasureMsg(MaxWidth, FMsgRect.Right, FMsgRect.Bottom);
  if not IsRectEmpty(FMsgRect) then
  begin
    if IsWinVista_UP then
    begin
      {$IFDEF JVCLThemesEnabled}
      if StyleServices.Enabled then
        OffsetRect(FMsgRect, 12, Max(9, FHeaderRect.Bottom))
      else
      {$ENDIF JVCLThemesEnabled}
      if GetComCtlVersion >= ComCtlVersionIE6 then
        OffsetRect(FMsgRect, 12, FHeaderRect.Bottom + 3)
      else
      begin
        if FShowIcon then
          OffsetRect(FMsgRect, 12, Max(FIconPos.Y + FImageSize.cy + 6, FHeaderRect.Bottom + 5))
        else
          OffsetRect(FMsgRect, 12, Max(9, FHeaderRect.Bottom + 5));
      end;
    end
    else
    begin
      if FShowIcon then
        OffsetRect(FMsgRect, 12, Max(FIconPos.Y + FImageSize.cy + 5, FHeaderRect.Bottom + 4))
      else
        OffsetRect(FMsgRect, 12, Max(9, FHeaderRect.Bottom + 4));
    end;
  end;

  if FShowIcon then
  begin
    // move the right position of the header
    if IsWinVista_UP and (GetComCtlVersion >= ComCtlVersionIE6) then
      OffsetRect(FHeaderRect, FImageSize.cx + 5, 0)
    else
      OffsetRect(FHeaderRect, FImageSize.cx + 8, 0);

    // move the right position of the msg; only for vista
    if IsWinVista_UP and (GetComCtlVersion >= ComCtlVersionIE6) then
      OffsetRect(FMsgRect, FImageSize.cx + 5, 0);
  end;

  {$IFDEF JVCLThemesEnabled}
  if IsWinVista_UP and StyleServices.Enabled and FIsMultiLineMsg then
  begin
    GetThemePartSize(GetToolTipThemeHandle, 0, TTP_BALLOONSTEM, cBalloonStemState[FCurrentPosition],
      nil, TS_TRUE, ASize);
    FStemRect := Rect(0, 0, ASize.cx, ASize.cy);
    FTipHeight := ASize.cy;
    FTipWidth := ASize.cx;
    FTipDelta := $10;
  end
  else
  {$ENDIF JVCLThemesEnabled}
  begin
    if IsRectEmpty(FHeaderRect) then
      StemSize := ssExtraSmall
    else
    if not FIsMultiLineMsg then
      StemSize := ssSmall
    else
      StemSize := ssNormal;

    FTipHeight := cTipHeight[StemSize];
    FTipWidth := cTipWidth[StemSize];
    FStemRect := Rect(0, 0, FTipWidth, FTipHeight);
    FTipDelta := cTipDelta[StemSize];
  end;

  if FShowCloseBtn then
  begin
    {$IFDEF JVCLThemesEnabled}
    if IsWinXP_UP and StyleServices.Enabled then
      GetThemePartSize(GetToolTipThemeHandle, 0, TTP_CLOSE, TTCS_NORMAL, nil, TS_DRAW, ASize)
    else
    {$ENDIF JVCLThemesEnabled}
    begin
      ASize.cx := GetSystemMetrics(SM_CXSMICON);
      ASize.cy := GetSystemMetrics(SM_CYSMICON);
    end;
    FCloseBtnRect := Rect(0, 0, ASize.cx, ASize.cy);

    Inc(FHeaderRect.Right, ASize.cx);
    Inc(FMsgRect.Right, ASize.cx);
  end;

  if IsWinVista_UP and (GetComCtlVersion >= ComCtlVersionIE6) then
  begin
    FRoundRect := Rect(0, 0, Max(13 + FMsgRect.Right, 13 + FHeaderRect.Right),
      Max(FMsgRect.Bottom + 10, FHeaderRect.Bottom + 10));
    OffsetRect(FStemRect, FTipDelta, FRoundRect.Bottom - 1);
  end
  else
  begin
    FRoundRect := Rect(0, 0, Max(14 + FMsgRect.Right, 14 + FHeaderRect.Right),
      Max(FMsgRect.Bottom + 11, FHeaderRect.Bottom + 11));
    OffsetRect(FStemRect, FTipDelta, FRoundRect.Bottom - 1);
  end;

  UnionRect(Result, FRoundRect, FStemRect);
  Pt := CalcOffset(Result);
  OffsetRect(Result, Pt.X, Pt.Y);

  OffsetRect(FCloseBtnRect, FRoundRect.Right - (FCloseBtnRect.Right - FCloseBtnRect.Left) - 6, 6);
  FUseRegion := True;
end;

function TJvBalloonWindow.CalcOffset(const ARect: TRect): TPoint;
begin
  case FCurrentPosition of
    { bpAuto returns the same value as bpLeftDown; bpLeftDown is choosen
      arbitrary }
    bpAuto, bpLeftDown:
      Result := Point(ARect.Left - ARect.Right + FTipDelta, 0);
    bpRightDown:
      Result := Point(-FTipDelta, 0);
    bpLeftUp:
      Result := Point(ARect.Left - ARect.Right + FTipDelta, ARect.Top - ARect.Bottom - FSwitchHeight);
    bpRightUp:
      Result := Point(-FTipDelta, ARect.Top - ARect.Bottom - FSwitchHeight);
  end;
end;

procedure TJvBalloonWindow.CheckPosition(var ARect: TRect);
var
  NewPosition: TJvBalloonPosition;
  ScreenRect: TRect;
  Pt: TPoint;
begin
  if FCurrentPosition = bpAuto then
    CalcAutoPosition(ARect);

  NewPosition := FCurrentPosition;
  ScreenRect := {>>>WorkAreaRect}DesktopRect{<<<};

  if ARect.Bottom > ScreenRect.Bottom - ScreenRect.Top then
  begin
    if NewPosition = bpLeftDown then
      NewPosition := bpLeftUp
    else
    if NewPosition = bpRightDown then
      NewPosition := bpRightUp;
  end;
  if ARect.Right > ScreenRect.Right - ScreenRect.Left then
  begin
    if NewPosition = bpRightDown then
      NewPosition := bpLeftDown
    else
    if NewPosition = bpRightUp then
      NewPosition := bpLeftUp;
  end;
  if ARect.Left < ScreenRect.Left then
  begin
    if NewPosition = bpLeftDown then
      NewPosition := bpRightDown
    else
    if NewPosition = bpLeftUp then
      NewPosition := bpRightUp;
  end;
  if ARect.Top < ScreenRect.Top then
  begin
    if NewPosition = bpLeftUp then
      NewPosition := bpLeftDown
    else
    if NewPosition = bpRightUp then
      NewPosition := bpRightDown;
  end;

  if NewPosition <> FCurrentPosition then
  begin
    { Reset the offset.. }
    Pt := CalcOffset(ARect);
    OffsetRect(ARect, -Pt.X, -Pt.Y);
    FCurrentPosition := NewPosition;

    { ..and set the offset }
    Pt := CalcOffset(ARect);
    OffsetRect(ARect, Pt.X, Pt.Y);
  end;
  { final adjustment - just make sure no part is disappearing outside the top/left edge }
  if ARect.Left < ScreenRect.Left then
  begin
    Pt := CalcOffset(ARect);
    OffsetRect(ARect, -Pt.X, -Pt.Y);
    if FCurrentPosition = bpLeftUp then
      FCurrentPosition := bpRightUp
    else
    if FCurrentPosition = bpLeftDown then
      FCurrentPosition := bpRightDown;
    Pt := CalcOffset(ARect);
    OffsetRect(ARect, Pt.X, Pt.Y);
  end;

  if ARect.Top < ScreenRect.Top then
  begin
    Pt := CalcOffset(ARect);
    OffsetRect(ARect, -Pt.X, -Pt.Y);
    if FCurrentPosition = bpLeftUp then
      FCurrentPosition := bpLeftDown
    else
    if FCurrentPosition = bpRightUp then
      FCurrentPosition := bpRightDown;
    Pt := CalcOffset(ARect);
    OffsetRect(ARect, Pt.X, Pt.Y);
  end;

  case FCurrentPosition of
    bpLeftDown, bpRightDown:
      begin
        OffsetRect(FRoundRect, 0, FTipHeight - 1);
        OffsetRect(FStemRect, 0, -FStemRect.Top);
        OffsetRect(FMsgRect, 0, FTipHeight - 1);
        OffsetRect(FHeaderRect, 0, FTipHeight - 1);
        Inc(FIconPos.y, FTipHeight);
        OffsetRect(FCloseBtnRect, 0, FTipHeight);

        if FCurrentPosition = bpLeftDown then
          OffsetRect(FStemRect, -2 * FTipDelta + (FRoundRect.Right - FRoundRect.Left) - (FStemRect.Right - FStemRect.Left), 0);
      end;
    bpLeftUp, bpRightUp:
      begin
        if FCurrentPosition = bpLeftUp then
          OffsetRect(FStemRect, -2 * FTipDelta + (FRoundRect.Right - FRoundRect.Left) - (FStemRect.Right - FStemRect.Left), 0);
      end;
  end;
end;

procedure TJvBalloonWindow.CMShowingChanged(var Msg: TMessage);
begin
  { In response of RecreateWnd, SetParentWindow calls, only respond when visible }
  { Actually only necessairy for TJvBalloonWindow not for TJvBalloonWindowEx }
  if Showing then
    UpdateRegion;
  inherited;
end;

procedure TJvBalloonWindow.CMTextChanged(var Msg: TMessage);
begin
  {inherited;}
end;

procedure TJvBalloonWindow.CreateParams(var Params: TCreateParams);
{$IFDEF JVCLThemesEnabled}
  {$IFNDEF COMPILER7_UP}
const
  WS_EX_COMPOSITED = $02000000;
  {$ENDIF ~COMPILER7_UP}
{$ENDIF JVCLThemesEnabled}
begin
  inherited CreateParams(Params);
  { Drop shadow in combination with custom animation may cause blurry effect,
    no solution.
  }
  with Params do
  begin
    Style := Style and not WS_BORDER;
    if IsWinXP_UP and (GetComCtlVersion >= ComCtlVersionIE6) then
    begin
      WindowClass.Style := WindowClass.Style or CS_DROPSHADOW;
      {$IFDEF JVCLThemesEnabled}
      if not IsWinSeven_UP and IsWinVista_UP and StyleServices.Enabled then
      begin
        ExStyle := ExStyle or WS_EX_LAYERED;
        if FIsMultiLineMsg then
          ExStyle := ExStyle or WS_EX_COMPOSITED;
      end;
      {$ENDIF JVCLThemesEnabled}
    end
    else
      WindowClass.Style := WindowClass.Style and not CS_DROPSHADOW;
  end;
end;

function TJvBalloonWindow.CreateRegion: HRGN;
var
  RegionRound, RegionTip: HRGN;
  PtTail: array [0..2] of TPoint;
begin
  case FCurrentPosition of
    bpLeftDown:
      begin
        {         0
                / |
               /  |
              /   |
             2----1
        }

        PtTail[0] := Point(FStemRect.Right, FStemRect.Top);
        PtTail[1] := Point(FStemRect.Right, FStemRect.Bottom);
        PtTail[2] := Point(FStemRect.Left, FStemRect.Bottom);
      end;
    bpRightDown:
      begin
        {    0
             | \
             |  \
             |   \
             1----2
        }

        PtTail[0] := Point(FStemRect.Left, FStemRect.Top);
        PtTail[1] := Point(FStemRect.Left, FStemRect.Bottom);
        PtTail[2] := Point(FStemRect.Right, FStemRect.Bottom);
      end;
    bpLeftUp:
      begin
        {    2----1
              \   |
               \  |
                \ |
                  0
        }

        PtTail[0] := Point(FStemRect.Right, FStemRect.Bottom);
        PtTail[1] := Point(FStemRect.Right, FStemRect.Top);
        PtTail[2] := Point(FStemRect.Left, FStemRect.Top);
      end;
    bpRightUp:
      begin
        {    1----2
             |   /
             |  /
             | /
             0
        }

        PtTail[0] := Point(FStemRect.Left, FStemRect.Bottom);
        PtTail[1] := Point(FStemRect.Left, FStemRect.Top);
        PtTail[2] := Point(FStemRect.Right, FStemRect.Top);
      end;
  end;

  RegionTip := CreatePolygonRgn(PtTail, 3, WINDING);
  RegionRound := CreateRoundRectRgn(FRoundRect.Left, FRoundRect.Top, FRoundRect.Right, FRoundRect.Bottom, 11, 11);
  Result := CreateRectRgn(0, 0, 1, 1);

  CombineRgn(Result, RegionTip, RegionRound, RGN_OR);
  DeleteObject(RegionTip);
  DeleteObject(RegionRound);
end;

{$IFDEF JVCLThemesEnabled}
function TJvBalloonWindow.CreateThemedRegion: HRGN;
var
  RegionRound, RegionTip: HRGN;
begin
  Result := CreateRectRgn(0, 0, 1, 1);
  if GetThemeBackgroundRegion(GetToolTipThemeHandle, 0, TTP_BALLOON, 0, FRoundRect, RegionRound) = S_OK then
  begin
    if GetThemeBackgroundRegion(GetToolTipThemeHandle, 0,
      TTP_BALLOONSTEM, cBalloonStemState[FCurrentPosition], FStemRect, RegionTip) = S_OK then
    begin
      CombineRgn(Result, RegionTip, RegionRound, RGN_OR);
      DeleteObject(RegionTip);
    end;
    DeleteObject(RegionRound);
  end;
end;
{$ENDIF JVCLThemesEnabled}

function TJvBalloonWindow.GetStemPointPosition: TPoint;
begin
  Result := GetStemPointPositionInRect(BoundsRect);
end;

function TJvBalloonWindow.GetStemPointPositionInRect(const ARect: TRect): TPoint;
begin
  { bpAuto returns the same value as bpLeftDown; bpLeftDown is choosen
    arbitrary }
  case FCurrentPosition of
    bpAuto, bpLeftDown:
      Result := Point(ARect.Right - FTipDelta, ARect.Top);
    bpRightDown:
      Result := Point(ARect.Left + FTipDelta, ARect.Top);
    bpLeftUp:
      Result := Point(ARect.Right - FTipDelta, ARect.Bottom);
    bpRightUp:
      Result := Point(ARect.Left + FTipDelta, ARect.Bottom);
  end;
end;

procedure TJvBalloonWindow.Init(AData: Pointer);
begin
  with GlobalCtrl.MainCtrl do
  begin
    FShowIcon := (ahShowIconInHint in ApplicationHintOptions) and
      (DefaultIcon <> ikNone) and
      ((DefaultIcon <> ikCustom) or (DefaultImageIndex > -1));
    FShowHeader := (ahShowHeaderInHint in ApplicationHintOptions) and (DefaultHeader <> '');
    FHeader := DefaultHeader;
    FCurrentPosition := DefaultBalloonPosition;
  end;

  FImageSize := GlobalCtrl.HintImageSize;
  FSwitchHeight := GetSystemMetrics(SM_CYCURSOR);
end;

procedure TJvBalloonWindow.MeasureHeader(const MaxWidth: Integer;
  var AWidth, AHeight: Integer);
var
  R: TRect;
begin
  if FShowHeader then
  begin
    R := Rect(0, 0, MaxWidth, 0);
    GetHintTitleFont(Canvas.Font);
    DrawTextW(Canvas.Handle, FHeader, R, DT_CALCRECT or DefaultTextFlags or DrawTextBiDiModeFlagsReadingOnly);
    AWidth := R.Right - R.Left;
    AHeight := R.Bottom - R.Top;
  end
  else
  begin
    AWidth := 0;
    AHeight := 0;
  end;
end;

procedure TJvBalloonWindow.MeasureMsg(const MaxWidth: Integer;
  var AWidth, AHeight: Integer);
var
  R: TRect;
begin
  if FMsg <> '' then
  begin
    R := Rect(0, 0, MaxWidth, 0);
    GetHintMessageFont(Canvas.Font);
    DrawTextW(Canvas.Handle, FMsg, R, DT_CALCRECT or DefaultTextFlags or DrawTextBiDiModeFlagsReadingOnly);
    AWidth := R.Right - R.Left;
    AHeight := R.Bottom - R.Top;
  end
  else
  begin
    AWidth := 0;
    AHeight := 0;
  end;
end;

function TJvBalloonWindow.MultiLineWidth(const Value: string): Integer;
var
  W: Integer;
  P, Start: PChar;
  S: string;
begin
  Result := 0;
  P := Pointer(Value);
  if P <> nil then
    while P^ <> #0 do
    begin
      Start := P;
      while not CharInSet(P^, [#0, #10, #13]) do
        P := StrNextChar(P);
      SetString(S, Start, P - Start);
      W := Canvas.TextWidth(S);
      if W > Result then
        Result := W;
      if P^ = #13 then Inc(P);
      if P^ = #10 then Inc(P);
    end;
end;

procedure TJvBalloonWindow.NCPaint(DC: HDC);
begin
  { Do nothing, thus prevent TJvHintWindow from drawing }
end;

procedure TJvBalloonWindow.Paint;
begin
  if FShowIcon then
    GlobalCtrl.DrawHintImage(Canvas, FIconPos.X, FIconPos.Y, Color);

  if FMsg <> '' then
  begin
    GetHintMessageFont(Canvas.Font);
    DrawTextW(Canvas.Handle, FMsg, FMsgRect,
      DefaultTextFlags or DrawTextBiDiModeFlagsReadingOnly);
  end;

  if FShowHeader then
  begin
    GetHintTitleFont(Canvas.Font);
    DrawTextW(Canvas.Handle, FHeader, FHeaderRect,
      DefaultTextFlags or DrawTextBiDiModeFlagsReadingOnly);
  end;
end;

procedure TJvBalloonWindow.UpdateRegion;
var
  Region: HRGN;
  IsVisible: Boolean;
begin
  if not HandleAllocated or not FUseRegion or (FCurrentPosition = bpAuto) then
    Exit;

  {$IFDEF JVCLThemesEnabled}
  if IsWinVista_UP and StyleServices.Enabled and FIsMultiLineMsg then
    Region := CreateThemedRegion
  else
  {$ENDIF JVCLThemesEnabled}
    Region := CreateRegion;
  IsVisible := IsWindowVisible(Handle);
  if SetWindowRgn(Handle, Region, IsVisible) = 0 then
    DeleteObject(Region);
  { MSDN: After a successful call to SetWindowRgn, the system owns the region
    specified by the region handle hRgn. The system does not make a copy of
    the region. Thus, you should not make any further function calls with
    this region handle. In particular, do not delete this region handle. The
    system deletes the region handle when it no longer needed. }
end;

procedure TJvBalloonWindow.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
var
  Brush, BrushBlack: HBRUSH;
  Region: HRGN;
  RegionType: Integer;
  {$IFDEF JVCLThemesEnabled}
  R: TRect;
  {$ENDIF JVCLThemesEnabled}
begin
  {$IFDEF JVCLThemesEnabled}
  if IsWinVista_UP and StyleServices.Enabled then
  begin
    if FIsMultiLineMsg then
    begin
      DrawThemeBackground(GetToolTipThemeHandle, Msg.DC, TTP_BALLOON, 0, FRoundRect, @FRoundRect);
      DrawThemeBackground(GetToolTipThemeHandle, Msg.DC, TTP_BALLOONSTEM,
        cBalloonStemState[FCurrentPosition], FStemRect, @FStemRect);
    end
    else
    begin
      R := ClientRect;
      DrawThemeBackground(GetToolTipThemeHandle, Msg.DC, TTP_BALLOON, 0, R, @R);
      // draw black border
      BrushBlack := CreateSolidBrush(0);
      try
        Region := CreateRectRgn(0, 0, 0, 0);
        RegionType := GetWindowRgn(Handle, Region);
        if RegionType <> Windows.ERROR then
          FrameRgn(Msg.DC, Region, BrushBlack, 1, 1);
        DeleteObject(Region);
      finally
        DeleteObject(BrushBlack);
      end;
    end;

    Msg.Result := 1;
    Exit;
  end;
  {$ENDIF JVCLThemesEnabled}
  Brush := CreateSolidBrush(ColorToRGB(Color));
  BrushBlack := CreateSolidBrush(0);
  try
    Region := CreateRectRgn(0, 0, 0, 0);
    RegionType := GetWindowRgn(Handle, Region);
    if RegionType <> Windows.ERROR then
    begin
      FillRgn(Msg.DC, Region, Brush);
      // draw black border
      FrameRgn(Msg.DC, Region, BrushBlack, 1, 1);
    end;
    DeleteObject(Region);
  finally
    DeleteObject(Brush);
    DeleteObject(BrushBlack);
  end;
  Msg.Result := 1;
end;

//=== { TJvBalloonHint } =====================================================

constructor TJvBalloonHint.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FActive := False;
  FHint := TJvBalloonWindowEx.Create(Self);
  FHint.FCtrl := Self;
  FHint.Visible := False;
  FHint.OnMouseDown := HandleMouseDown;
  FHint.OnMouseUp := HandleMouseUp;
  FHint.OnMouseMove := HandleMouseMove;
  FHint.OnClick := HandleClick;
  FHint.OnDblClick := HandleDblClick;
  FOptions := [boShowCloseBtn];
  FApplicationHintOptions := [ahShowHeaderInHint, ahShowIconInHint];
  FDefaultIcon := ikInformation;
  FDefaultBalloonPosition := bpAuto;
  FDefaultImageIndex := -1;
  FCustomAnimationTime := 100;
  FCustomAnimationStyle := atBlend;
  FMaxWidth := 0;

  GlobalCtrl.MainCtrl := Self;
end;

destructor TJvBalloonHint.Destroy;
begin
  CancelHint;
  StopHintTimer;

  if FHandle <> 0 then
    DeallocateHWndEx(FHandle);

  if (GGlobalCtrl <> nil) and (GGlobalCtrl.MainCtrl = Self) then
    GlobalCtrl.MainCtrl := nil;

  inherited Destroy;
end;

procedure TJvBalloonHint.ActivateHint(ACtrl: TControl; const AHint: WideString;
  const AImageIndex: TImageIndex; const AHeader: WideString;
  const VisibleTime: Integer);
begin
  if not Assigned(ACtrl) then
    Exit;

  CancelHint;

  with FData do
  begin
    RUTF8Hint := {$IFDEF RTL200_UP}UTF8Encode{$ELSE}WideStringToUTF8{$ENDIF RTL200_UP}(AHint);
    RIconKind := ikCustom;
    RImageIndex := AImageIndex;
    RUTF8Header := {$IFDEF RTL200_UP}UTF8Encode{$ELSE}WideStringToUTF8{$ENDIF RTL200_UP}(AHeader);
    RVisibleTime := VisibleTime;
  end;

  InternalActivateHint(ACtrl);
end;

procedure TJvBalloonHint.ActivateHint(ACtrl: TControl;
  const AHint, AHeader: WideString; const VisibleTime: Integer);
begin
  if not Assigned(ACtrl) then
    Exit;

  CancelHint;

  with FData do
  begin
    RUTF8Hint := {$IFDEF RTL200_UP}UTF8Encode{$ELSE}WideStringToUTF8{$ENDIF RTL200_UP}(AHint);
    RUTF8Header := {$IFDEF RTL200_UP}UTF8Encode{$ELSE}WideStringToUTF8{$ENDIF RTL200_UP}(AHeader);
    RVisibleTime := VisibleTime;
    RIconKind := ikNone;
  end;

  InternalActivateHint(ACtrl);
end;

procedure TJvBalloonHint.ActivateHint(ACtrl: TControl; const AHint: WideString;
  const AIconKind: TJvIconKind; const AHeader: WideString; const VisibleTime: Integer);
begin
  if not Assigned(ACtrl) then
    Exit;

  CancelHint;

  with FData do
  begin
    RUTF8Hint := {$IFDEF RTL200_UP}UTF8Encode{$ELSE}WideStringToUTF8{$ENDIF RTL200_UP}(AHint);
    RIconKind := AIconKind;
    RImageIndex := -1;
    RUTF8Header := {$IFDEF RTL200_UP}UTF8Encode{$ELSE}WideStringToUTF8{$ENDIF RTL200_UP}(AHeader);
    RVisibleTime := VisibleTime;
  end;

  InternalActivateHint(ACtrl);
end;

procedure TJvBalloonHint.ActivateHintPos(AAnchorWindow: TCustomForm;
  AAnchorPosition: TPoint; const AHeader, AHint: WideString;
  const VisibleTime: Integer; const AIconKind: TJvIconKind;
  const AImageIndex: TImageIndex);
begin
  CancelHint;

  with FData do
  begin
    RAnchorWindow := AAnchorWindow;
    RAnchorPosition := AAnchorPosition;
    RUTF8Header := {$IFDEF RTL200_UP}UTF8Encode{$ELSE}WideStringToUTF8{$ENDIF RTL200_UP}(AHeader);
    RUTF8Hint := {$IFDEF RTL200_UP}UTF8Encode{$ELSE}WideStringToUTF8{$ENDIF RTL200_UP}(AHint);
    RVisibleTime := VisibleTime;
    RIconKind := AIconKind;
    RImageIndex := AImageIndex;
    RSwitchHeight := 0;
  end;

  InternalActivateHintPos;
end;

procedure TJvBalloonHint.ActivateHintRect(ARect: TRect; const AHeader,
  AHint: WideString; const VisibleTime: Integer; const AIconKind: TJvIconKind;
  const AImageIndex: TImageIndex);
begin
  CancelHint;

  with FData do
  begin
    RAnchorWindow := nil;
    RAnchorPosition := Point((ARect.Left + ARect.Right) div 2, ARect.Bottom);
    RUTF8Header := {$IFDEF RTL200_UP}UTF8Encode{$ELSE}WideStringToUTF8{$ENDIF RTL200_UP}(AHeader);
    RUTF8Hint := {$IFDEF RTL200_UP}UTF8Encode{$ELSE}WideStringToUTF8{$ENDIF RTL200_UP}(AHint);
    RVisibleTime := VisibleTime;
    RIconKind := AIconKind;
    RImageIndex := AImageIndex;
    RSwitchHeight := ARect.Bottom - ARect.Top;
  end;

  InternalActivateHintPos;
end;

procedure TJvBalloonHint.CancelHint;
begin
  if not FActive then
    Exit;

  FActive := False;
  StopHintTimer;
  UnHook;

  if GetCapture = FHint.Handle then
    ReleaseCapture;
  { Ensure property Visible is set to False: }
  FHint.Hide;
  { If ParentWindow = 0, calling Hide won't trigger the CM_SHOWINGCHANGED message
    thus ShowWindow/SetWindowPos isn't called. We do it ourselfs: }
  if FHint.ParentWindow = 0 then
    ShowWindow(FHint.Handle, SW_HIDE);

  FHint.ParentWindow := 0;

  if Assigned(FOnClose) then
    FOnClose(Self);
end;

procedure TJvBalloonWindow.CreateWnd;
begin
  inherited CreateWnd;
  UpdateRegion;
end;

function TJvBalloonHint.GetHandle: THandle;
begin
  if FHandle = 0 then
    FHandle := AllocateHWndEx(WndProc);
  Result := FHandle;
end;

function TJvBalloonHint.GetUseBalloonAsApplicationHint: Boolean;
begin
  Result := GlobalCtrl.UseBalloonAsApplicationHint;
end;

procedure TJvBalloonHint.HandleClick(Sender: TObject);
begin
  if Assigned(FOnBalloonClick) then
    FOnBalloonClick(Self);
end;

function TJvBalloonHint.HandleCloseBtnClick: Boolean;
begin
  Result := True;
  if Assigned(FOnCloseBtnClick) then
    FOnCloseBtnClick(Self, Result);
end;

procedure TJvBalloonHint.HandleDblClick(Sender: TObject);
begin
  if Assigned(FOnDblClick) then
    FOnDblClick(Self);
end;

procedure TJvBalloonHint.HandleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseDown) then
    FOnMouseDown(Self, Button, Shift, X, Y);
end;

procedure TJvBalloonHint.HandleMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseMove) then
    FOnMouseMove(Self, Shift, X, Y);
end;

procedure TJvBalloonHint.HandleMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseUp) then
    FOnMouseUp(Self, Button, Shift, X, Y);
end;

procedure TJvBalloonHint.Hook;
begin
  if Assigned(FData.RAnchorWindow) then
    RegisterWndProcHook(FData.RAnchorWindow, HookProc, hoBeforeMsg);
end;

function TJvBalloonHint.HookProc(var Msg: TMessage): Boolean;
begin
  Result := False;
  case Msg.Msg of
    WM_MOVE:
      with FData do
        FHint.MoveWindow(RAnchorWindow.ClientToScreen(RAnchorPosition));
    WM_SIZE:
      with FData do
        { (rb) This goes wrong if the balloon is anchored to the window itself }
        if not PtInRect(RAnchorWindow.ClientRect, RStemPointPosition) then
          CancelHint;
    WM_SHOWWINDOW:
      ;
    WM_WINDOWPOSCHANGED:
      { Hide/Restore the balloon if the window is minimized }
      FHint.Visible :=
        not IsIconic(FData.RAnchorWindow.Handle) and
        not IsIconic(Application.Handle);
    WM_ACTIVATE:
      if Msg.WParam = WA_INACTIVE then
        { Remove HWND_TOPMOST flag }
        FHint.NormalizeTopMost
      else
        { Restore HWND_TOPMOST flag }
        FHint.RestoreTopMost;
    WM_CLOSE:
      CancelHint;
    WM_NCACTIVATE, WM_EXITSIZEMOVE:
      { (rb) Weird behaviour of windows ? }
      FHint.RestoreTopMost;
  end;
end;

procedure TJvBalloonHint.InternalActivateHint(ACtrl: TControl);
var
  LParentForm: TCustomForm;
begin
  if not Assigned(ACtrl) then
    Exit;

  LParentForm := GetParentForm(ACtrl);
  with FData do
  begin
    RAnchorWindow := LParentForm;
    if LParentForm = ACtrl then
      RAnchorPosition := Point(ACtrl.Width div 2, ACtrl.ClientHeight)
    else
      RAnchorPosition := InternalClientToParent(ACtrl, Point(ACtrl.Width div 2, ACtrl.Height), LParentForm);

    RSwitchHeight := ACtrl.Height;
  end;

  InternalActivateHintPos;
end;

procedure TJvBalloonHint.InternalActivateHintPos;
var
  Rect: TRect;
  Animate: BOOL;
  TmpMaxWidth: Integer;
  Pt: TPoint;
begin
  GlobalCtrl.MainCtrl := Self;
  with FData do
  begin
    { Use defaults if necessairy: }
    if boUseDefaultHeader in Options then
      RUTF8Header := {$IFDEF RTL200_UP}UTF8Encode{$ELSE}WideStringToUTF8{$ENDIF RTL200_UP}(DefaultHeader);
    if boUseDefaultIcon in Options then
      RIconKind := DefaultIcon;
    if boUseDefaultImageIndex in Options then
      RImageIndex := DefaultImageIndex;
    RShowCloseBtn := boShowCloseBtn in Options;

    { Determine animation style }
    if not IsWinXP_UP then
      RAnimationStyle := atNone
    else
    if boCustomAnimation in Options then
    begin
      RAnimationStyle := FCustomAnimationStyle;
      RAnimationTime := FCustomAnimationTime;
    end
    else
    begin
      SystemParametersInfo(SPI_GETTOOLTIPANIMATION, 0, @Animate, 0);
      if Animate then
      begin
        SystemParametersInfo(SPI_GETTOOLTIPFADE, 0, @Animate, 0);
        if Animate then
          RAnimationStyle := atBlend
        else
          RAnimationStyle := atSlide;
      end
      else
        RAnimationStyle := atNone;
      RAnimationTime := 100;
    end;

    { Hook the anchor window }
    FActive := True;
    Hook;

    { Determine the size of the balloon rect, the stem point will be on
      position (0, 0) }
    if MaxWidth = 0 then
      TmpMaxWidth := Screen.Width
    else
      TmpMaxWidth := MaxWidth;
    Rect := FHint.CalcHintRectUTF8(TmpMaxWidth, RUTF8Hint, @FData);

    { Offset the rectangle to the anchor position }
    if Assigned(RAnchorWindow) then
    begin
      Pt := RAnchorWindow.ClientToScreen(RAnchorPosition);
      OffsetRect(Rect, Pt.X, Pt.Y)
    end
    else
      OffsetRect(Rect, RAnchorPosition.X, RAnchorPosition.Y);

    if boPlaySound in Options then
      GlobalCtrl.PlaySound(RIconKind);

    FHint.InternalActivateHint(Rect, {$IFDEF RTL200_UP}System.UTF8ToString{$ENDIF RTL200_UP}(RUTF8Hint));

    { Now we can determine the actual anchor & stempoint position: }
    if Assigned(RAnchorWindow) then
    begin
      RAnchorPosition := RAnchorWindow.ScreenToClient(Rect.TopLeft);
      RStemPointPosition := RAnchorWindow.ScreenToClient(FHint.StemPointPosition);
    end
    else
    begin
      RAnchorPosition := Rect.TopLeft;
      RStemPointPosition := FHint.StemPointPosition;
    end;

    { Last call because of possible CancelHint call in StartHintTimer }
    if RVisibleTime > 0 then
      StartHintTimer(RVisibleTime);
    {if GetCapture = 0 then
      SetCapture(FHint.Handle);
    ReleaseCapture;}
  end;
end;

procedure TJvBalloonHint.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;

procedure TJvBalloonHint.SetImages(const Value: TCustomImageList);
begin
  ReplaceComponentReference(Self, Value, TComponent(FImages));
end;

procedure TJvBalloonHint.SetOptions(const Value: TJvBalloonOptions);
begin
  if Value <> FOptions then
    FOptions := Value;
end;

procedure TJvBalloonHint.SetUseBalloonAsApplicationHint(
  const Value: Boolean);
begin
  GlobalCtrl.UseBalloonAsApplicationHint := Value;
end;

procedure TJvBalloonHint.StartHintTimer(Value: Integer);
begin
  StopHintTimer;
  if SetTimer(Handle, 1, Value, nil) = 0 then
    CancelHint
  else
    FTimerActive := True;
end;

procedure TJvBalloonHint.StopHintTimer;
begin
  if FTimerActive then
  begin
    KillTimer(Handle, 1);
    FTimerActive := True;
  end;
end;

procedure TJvBalloonHint.UnHook;
begin
  if Assigned(FData.RAnchorWindow) then
    UnRegisterWndProcHook(FData.RAnchorWindow, HookProc, hoBeforeMsg);
end;

procedure TJvBalloonHint.WndProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_TIMER then
    try
      CancelHint;
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self);
    end
    else
      Result := DefWindowProc(Handle, Msg, WParam, LParam);
end;

//=== { TGlobalCtrl } ========================================================

procedure TGlobalCtrl.AppEventsShowHint(var HintStr: string;
  var CanShow: Boolean; var HintInfo: THintInfo);
begin
  if UseBalloonAsApplicationHint and (MainCtrl.MaxWidth > 0) then
    HintInfo.HintMaxWidth := MainCtrl.MaxWidth;
end;

constructor TGlobalCtrl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FAppEvents := TApplicationEvents.Create(Self);
  FAppEvents.OnShowHint := AppEventsShowHint;

  if IsWinXP_UP then
  begin
    FDefaultImages := TImageList.Create(nil);
    { According to MSDN flag ILC_COLOR32 needs to be included (?) }
    FDefaultImages.Handle := ImageList_Create(16, 16, ILC_COLOR32 or ILC_MASK, 4, 4);
  end
  else
    FDefaultImages := TImageList.CreateSize(16, 16);

  { Only need to update the background color in XP when using pre v6.0 ComCtl32.dll
    image lists }
  FNeedUpdateBkColor := IsWinXP_UP and (GetComCtlVersion < $00060000);

  if FNeedUpdateBkColor then
    FDefaultImages.BkColor := Application.HintColor
  else
    FDefaultImages.BkColor := clNone;

  FBkColor := Application.HintColor;
  FUseBalloonAsApplicationHint := False;

  GetDefaultImages;
  GetDefaultSounds;
end;

destructor TGlobalCtrl.Destroy;
begin
  FDefaultImages.Free;
  FAppEvents.Free;

  inherited Destroy;
end;

procedure TGlobalCtrl.DrawHintImage(Canvas: TCanvas; X, Y: Integer; const ABkColor: TColor);
begin
  DrawHintImage(Canvas, X, Y, MainCtrl.DefaultIcon, MainCtrl.DefaultImageIndex, ABkColor);
end;

procedure TGlobalCtrl.DrawHintImage(Canvas: TCanvas; X, Y: Integer;
  const AIconKind: TJvIconKind; const AImageIndex: TImageIndex; const ABkColor: TColor);
const
  cDefaultImages: array [TJvIconKind] of Integer = (-1, -1, 0, 1, 2, 3, 4);
begin
  case AIconKind of
    ikCustom:
      with MainCtrl do
        if not Assigned(Images) or (AImageIndex < 0) or (AImageIndex >= Images.Count) then
        begin
          BkColor := ABkColor;
          FDefaultImages.Draw(Canvas, X, Y, cDefaultImages[ikInformation]);
        end
        else
          Images.Draw(Canvas, X, Y, AImageIndex);
    ikNone:
      ;
  else
    BkColor := ABkColor;
    FDefaultImages.Draw(Canvas, X, Y, cDefaultImages[AIconKind]);
  end;
end;

procedure TGlobalCtrl.GetDefaultImages;
type
  TPictureType = (ptXP, ptNormal, ptSimple);
const
  { Get the images:

    For        From          ID   TJvIconKind    Spec
    ---------------------------------------------------------------------------
    Windows XP User32.dll   100   ikApplication  16x16 32x32 48x48 1,4,8,32 bpp
                            101   ikWarning
                            102   ikQuestion
                            103   ikError
                            104   ikInformation
                            105   ikApplication
    All (?)    comctl32.dll 20480 ikError        16x16 32x32 4 bpp
                            20481 ikInformation
                            20482 ikWarning
  }

  { ikApplication, ikError, ikInformation, ikQuestion, ikWarning }
  cIcons: array [TPictureType, ikApplication..ikWarning] of Integer =
   (
    (100, 103, 104, 102, 101),                             // XP
    (OIC_SAMPLE, 20480, 20481, OIC_QUES, 20482),           // Normal
    (OIC_SAMPLE, OIC_HAND, OIC_NOTE, OIC_QUES, OIC_BANG)   // Paranoid
   );
  cFlags: array [Boolean] of UINT = (0, LR_SHARED);
var
  IconKind: TJvIconKind;
  PictureType: TPictureType;
  IconHandle: THandle;
  Shared: Boolean;
  Modules: array [Boolean] of HMODULE;
begin
  PictureType := ptNormal;
  Modules[True] := 0;

  if IsWinXP_UP and (GetComCtlVersion >= ComCtlVersionIE6) then
  begin
    Modules[False] := GetModuleHandle('user32.dll');
    if Modules[False] <> 0 then
      PictureType := ptXP
  end;

  if PictureType = ptNormal then
  begin
    Modules[False] := GetModuleHandle('comctl32.dll');
    if Modules[False] = 0 then
      PictureType := ptSimple;
  end;

  { Now   PictureType = ptXP     -> Modules = (user32.dll handle, 0)
          PictureType = ptNormal -> Modules = (comctl32.dll handle, 0)
          PictureType = ptSimple -> Modules = (0, 0)
  }

  for IconKind := Low(cIcons[PictureType]) to High(cIcons[PictureType]) do
  begin
    Shared := (PictureType = ptSimple) or
      ((PictureType = ptNormal) and (IconKind in [ikApplication, ikQuestion]));
    IconHandle :=
      LoadImage(Modules[Shared], MakeIntResource(cIcons[PictureType, IconKind]),
      IMAGE_ICON, 16, 16, cFlags[Shared]);
    ImageList_AddIcon(FDefaultImages.Handle, IconHandle);
    { MSDN: Do not use DestroyIcon to destroy a shared icon. A shared icon is
      valid as long as the module from which it was loaded remains in memory }
    if not Shared then
      DestroyIcon(IconHandle);
  end;
end;

procedure TGlobalCtrl.GetDefaultSounds;
{ Taken from ActnMenus.pas }
var
  Registry: TRegistry;

  function ReadSoundSetting(KeyStr: string): string;
  var
    S: string;
  begin
    Registry.RootKey := HKEY_CURRENT_USER;
    Result := '';
    if Registry.OpenKeyReadOnly('\AppEvents\Schemes\Apps\.Default\' + KeyStr) then
    try
      S := Registry.ReadString('');
      SetLength(Result, 4096);
      SetLength(Result, ExpandEnvironmentStrings(PChar(S), PChar(Result), 4096) - 1);
    finally
      Registry.CloseKey;
    end;
  end;

begin
  Registry := TRegistry.Create;
  try
    FSounds[ikCustom] := ReadSoundSetting('SystemNotification\.Current');
    FSounds[ikNone] := FSounds[ikCustom];
    FSounds[ikApplication] := FSounds[ikCustom];
    FSounds[ikError] := ReadSoundSetting('SystemHand\.Current');
    FSounds[ikInformation] := ReadSoundSetting('SystemAsterisk\.Current');
    FSounds[ikQuestion] := ReadSoundSetting('SystemQuestion\.Current');
    FSounds[ikWarning] := ReadSoundSetting('SystemExclamation\.Current');
  finally
    Registry.Free;
  end;
end;

function TGlobalCtrl.GetMainCtrl: TJvBalloonHint;
begin
  if not Assigned(FMainCtrl) then
  begin
    if GMainCtrl = nil then
      GMainCtrl := TJvBalloonHint.Create(Self);
    Result := GMainCtrl;
  end
  else
    Result := FMainCtrl;
end;

function TGlobalCtrl.HintImageSize: TSize;
begin
  Result := HintImageSize(MainCtrl.DefaultIcon, MainCtrl.DefaultImageIndex);
end;

function TGlobalCtrl.HintImageSize(const AIconKind: TJvIconKind;
  const AImageIndex: TImageIndex): TSize;
begin
  case AIconKind of
    ikCustom:
      with MainCtrl do
        if not Assigned(Images) or (AImageIndex < 0) or (AImageIndex >= Images.Count) then
        begin
          Result.cx := 16;
          Result.cy := 16;
        end
        else
        begin
          Result.cx := Images.Width;
          Result.cy := Images.Height;
        end;
    ikNone:
      begin
        Result.cx := 0;
        Result.cy := 0;
      end;
  else
    begin
      Result.cx := 16;
      Result.cy := 16;
    end;
  end;
end;

procedure TGlobalCtrl.PlaySound(const AIconKind: TJvIconKind);
begin
  if Length(FSounds[AIconKind]) > 0 then
    sndPlaySound(PChar(FSounds[AIconKind]), SND_NOSTOP or SND_ASYNC);
end;

procedure TGlobalCtrl.SetBkColor(const Value: TColor);
begin
  if FNeedUpdateBkColor and (FBkColor <> Value) then
  begin
    { Icons in windows XP use an alpha channel to 'blend' with the background.
      If the background color changes, then the images must be redrawn,
      when using pre v6.0 ComCtl32.dll image lists
    }
    FBkColor := Value;
    FDefaultImages.Clear;
    FDefaultImages.BkColor := FBkColor;
    GetDefaultImages;
  end;
end;

procedure TGlobalCtrl.SetMainCtrl(const Value: TJvBalloonHint);
begin
  FMainCtrl := Value;
  { Determine whether we are designing }
  if Assigned(FMainCtrl) then
    FDesigning := csDesigning in FMainCtrl.ComponentState
  else
    UseBalloonAsApplicationHint := False;
end;

procedure TGlobalCtrl.SetUseBalloonAsApplicationHint(const Value: Boolean);
begin
  if FDesigning then
    FUseBalloonAsApplicationHint := Value
  else
  if Value <> FUseBalloonAsApplicationHint then
  begin
    FUseBalloonAsApplicationHint := Value;

    Application.CancelHint;

    if FUseBalloonAsApplicationHint then
    begin
      FOldHintWindowClass := HintWindowClass;
      HintWindowClass := TJvBalloonWindow;
    end
    else
      HintWindowClass := FOldHintWindowClass;
  end;
end;

//=== { TJvBalloonWindowEx } =================================================

procedure TJvBalloonWindowEx.ChangeCloseState(const AState: Cardinal);
begin
  if AState <> FCloseState then
  begin
    FCloseState := AState;
    InvalidateRect(Self.Handle, @FCloseBtnRect, True);
  end;
end;

function FormHasFocus(FormHandle: HWND): Boolean;
var
  H: HWND;
begin
  H := GetFocus;
  while IsWindow(H) and (H <> FormHandle) do
    H := GetParent(H);
  Result := H = FormHandle;
end;

procedure TJvBalloonWindowEx.EnsureTopMost;
begin
  if not Assigned(FCtrl.FData.RAnchorWindow) then
    Exit;

  if not FormHasFocus(FCtrl.FData.RAnchorWindow.Handle) then
    { Current window is not focused, thus place the balloon behind the
      window that has focus }
    NormalizeTopMost
  else
    RestoreTopMost;
end;

procedure TJvBalloonWindowEx.Init(AData: Pointer);
begin
  Canvas.Font := Screen.HintFont;
  Color := Application.HintColor;

  with PHintData(AData)^ do
  begin
    FImageIndex := RImageIndex;
    FIconKind := RIconKind;
    FHeader := {$IFDEF RTL200_UP}System.{$ENDIF RTL200_UP}UTF8ToWideString(RUTF8Header);
    if FHeader = '' then
      FHeader := WideString(RUTF8Header);

    FShowHeader := FHeader <> '';
    FShowIcon := (FIconKind <> ikNone) and
      ((FIconKind <> ikCustom) or (FImageIndex <> -1));
    FShowCloseBtn := RShowCloseBtn;

    FAnimationTime := RAnimationTime;
    FAnimationStyle := RAnimationStyle;

    FSwitchHeight := RSwitchHeight;
    FIsAnchored := Assigned(RAnchorWindow);
  end;

  FImageSize := GlobalCtrl.HintImageSize(FIconKind, FImageIndex);
  FCurrentPosition := FCtrl.DefaultBalloonPosition;
end;

procedure BoundRect(var ARect: TRect; const BoundingRect: TRect);
begin
  if BoundingRect.Left > ARect.Left then
  begin
    ARect.Right := ARect.Right + (BoundingRect.Left - ARect.Left);
    ARect.Left := BoundingRect.Left;
  end;
  if BoundingRect.Top > ARect.Top then
  begin
    ARect.Bottom := ARect.Bottom + (BoundingRect.Top - ARect.Top);
    ARect.Top := BoundingRect.Top;
  end;
  if BoundingRect.Right < ARect.Right then
  begin
    ARect.Left := ARect.Left - (ARect.Right - BoundingRect.Right);
    ARect.Right := BoundingRect.Right;
  end;
  if BoundingRect.Bottom < ARect.Bottom then
  begin
    ARect.Top := ARect.Top - (ARect.Bottom - BoundingRect.Bottom);
    ARect.Bottom := BoundingRect.Bottom;
  end;
end;

procedure TJvBalloonWindowEx.InternalActivateHint(var Rect: TRect;
  const AHint: string);
const
  {TJvAnimationStyle = (atNone, atSlide, atRoll, atRollHorNeg, atRollHorPos, atRollVerNeg,
    atRollVerPos, atSlideHorNeg, atSlideHorPos, atSlideVerNeg, atSlideVerPos, atCenter, atBlend);}
  cAnimationStyle: array [TJvAnimationStyle] of Integer =
   (0, AW_SLIDE, 0, AW_HOR_NEGATIVE,
    AW_HOR_POSITIVE, AW_VER_NEGATIVE, AW_VER_POSITIVE, AW_HOR_NEGATIVE or AW_SLIDE,
    AW_HOR_POSITIVE or AW_SLIDE, AW_VER_NEGATIVE or AW_SLIDE, AW_VER_POSITIVE or AW_SLIDE,
    AW_CENTER, AW_BLEND);
var
  AutoValue: Integer;
begin
  FCloseState := DFCS_FLAT;
  CheckPosition(Rect);

  if HandleAllocated and IsWindowVisible(Handle) then
  begin
    Hide;
    if ParentWindow = 0 then
      ShowWindow(Handle, SW_HIDE);
  end;

  { This will prevent focusing/unfocusing of the application button on the
    taskbar when clicking on the balloon window }
  if FIsAnchored then
    { Application Handle, so we automatically get minimized/restored when the
      application minimizes/restores }
    ParentWindow := Application.Handle
  else
    ParentWindow := 0;
  HandleNeeded;

  BoundRect(Rect, DesktopRect);

  SetBounds(Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top);
  UpdateRegion;

  { Set the Z order of the balloon }
  if Assigned(FCtrl.FData.RAnchorWindow) then
  begin
    if not IsWindowVisible(FCtrl.FData.RAnchorWindow.Handle) or
      IsIconic(FCtrl.FData.RAnchorWindow.Handle) then
      { Current window is minimized, thus do not show the balloon }
      Exit
    else
      EnsureTopMost;
  end
  else
    RestoreTopMost;

  // can only blend on Vista
  if IsWinVista_UP and (GetComCtlVersion >= ComCtlVersionIE6) then
    if FAnimationStyle <> atNone then
      FAnimationStyle := atBlend;

  if (FAnimationStyle <> atNone) and IsWinXP_UP and (GetComCtlVersion >= ComCtlVersionIE6) and Assigned(AnimateWindowProc) then
  begin
    if FAnimationStyle in [atSlide, atRoll] then
      case FCurrentPosition of
        bpLeftDown, bpRightDown:
          AutoValue := AW_VER_POSITIVE;
      else {bpLeftUp, bpRightUp:}
        AutoValue := AW_VER_NEGATIVE;
      end
    else
      AutoValue := 0;
    { This function will fail on systems other than Windows XP,
      because of use of the window region: }
    AnimateWindowProc(Handle, FAnimationTime, cAnimationStyle[FAnimationStyle] or AutoValue);
  end;

  { Ensure property Visible is set to True: }
  Show;
  { If ParentWindow = 0, calling Show won't trigger the CM_SHOWINGCHANGED message
    thus ShowWindow/SetWindowPos isn't called. We do it ourselfs: }
  if ParentWindow = 0 then
    ShowWindow(Handle, SW_SHOWNOACTIVATE);
  Invalidate;
end;

procedure TJvBalloonWindowEx.MoveWindow(NewPos: TPoint);
begin
  BoundsRect := Rect(NewPos.X, NewPos.Y, NewPos.X + Width, NewPos.Y + Height);
end;

procedure TJvBalloonWindowEx.NormalizeTopMost;
var
  TopWindow: HWND;
begin
  if not Assigned(FCtrl.FData.RAnchorWindow) then
    Exit;

  { Retrieve the window below the anchor window in the Z order. }
  TopWindow := GetWindow(FCtrl.FData.RAnchorWindow.Handle, GW_HWNDPREV);
  if GetWindowLong(TopWindow, GWL_EXSTYLE) and WS_EX_TOPMOST <> 0 then
    TopWindow := HWND_NOTOPMOST;

  SetWindowPos(Handle, TopWindow, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_NOOWNERZORDER);
end;

procedure TJvBalloonWindowEx.Paint;
{$IFDEF JVCLThemesEnabled}
var
  ButtonState: Cardinal;
{$ENDIF JVCLThemesEnabled}
begin
  if FShowIcon then
    with FIconPos do
      GlobalCtrl.DrawHintImage(Canvas, X, Y, FIconKind, FImageIndex, Color);

  if FShowCloseBtn then
  begin
    {$IFDEF JVCLThemesEnabled}
    if StyleServices.Enabled then
    begin
      if (FCloseState and DFCS_PUSHED > 0) and (FCloseState and DFCS_HOT = 0) then
        ButtonState := TTCS_NORMAL
      else
      if FCloseState and DFCS_PUSHED > 0 then
        ButtonState := TTCS_PRESSED
      else
      if (FCloseState and DFCS_HOT > 0) and not (csDesigning in ComponentState) then
        ButtonState := TTCS_HOT
      else
        ButtonState := TTCS_NORMAL;

      DrawThemeBackground(GetToolTipThemeHandle, Canvas.Handle, TTP_CLOSE, ButtonState, FCloseBtnRect, nil);
    end
    else
    {$ENDIF JVCLThemesEnabled}
      DrawFrameControl(Canvas.Handle, FCloseBtnRect, DFC_CAPTION, DFCS_TRANSPARENT or
        DFCS_CAPTIONCLOSE or FCloseState);
  end;

  SetBkMode(Canvas.Handle, TRANSPARENT);
  if FMsg <> '' then
  begin
    GetHintMessageFont(Canvas.Font);
    DrawTextW(Canvas.Handle, FMsg, FMsgRect,
      DefaultTextFlags or DrawTextBiDiModeFlagsReadingOnly);
  end;

  if FShowHeader then
  begin
    GetHintTitleFont(Canvas.Font);
    DrawTextW(Canvas.Handle, FHeader, FHeaderRect, DefaultTextFlags or DrawTextBiDiModeFlagsReadingOnly);
  end;
end;

procedure TJvBalloonWindowEx.RestoreTopMost;
begin
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_NOOWNERZORDER);
end;

procedure TJvBalloonWindowEx.WMActivateApp(var Msg: TWMActivateApp);
begin
  inherited;
  if Msg.Active then
    EnsureTopMost;
end;

procedure TJvBalloonWindowEx.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  inherited;
  if FShowCloseBtn then
  begin
    if PtInRect(FCloseBtnRect, SmallPointToPoint(Msg.Pos)) then
    begin
      {SetCapture(Handle);}// handled in inherited
      ChangeCloseState(FCloseState or DFCS_PUSHED);
    end;
  end;
end;

procedure TJvBalloonWindowEx.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  if FShowCloseBtn then
  begin
    if FCloseState and DFCS_PUSHED > 0 then
    begin
      {ReleaseCapture;}// handled in inherited
      ChangeCloseState(FCloseState and not DFCS_PUSHED);
      if PtInRect(FCloseBtnRect, SmallPointToPoint(Msg.Pos)) then
      begin
        { Prevent firing of OnClick event in inherited call }
        ControlState := ControlState - [csClicked];
        if FCtrl.HandleCloseBtnClick then
          FCtrl.CancelHint;
      end;
    end;
  end;
  inherited;
end;

procedure TJvBalloonWindowEx.WMMouseMove(var Msg: TWMMouseMove);
var
  State: Cardinal;
begin
  inherited;
  if FShowCloseBtn then
  begin
    State := DFCS_FLAT;

    if PtInRect(FCloseBtnRect, SmallPointToPoint(Msg.Pos)) and
       not (csDesigning in ComponentState) then
    begin
      { Note: DFCS_HOT is not supported in windows 95 systems }
      State := State or DFCS_HOT;
      if FCloseState and DFCS_PUSHED > 0 then
        State := State or DFCS_PUSHED;
    end;
    ChangeCloseState(State);
  end;
end;

procedure TJvBalloonWindowEx.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  Msg.Result := HTCLIENT;
end;

initialization
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}
  InitUnicodeWrap;

finalization
  FreeAndNil(GGlobalCtrl);
  {$IFDEF JVCLStylesEnabled}
  CloseToolTipThemeHandle;
  {$ENDIF JVCLStylesEnabled}
  {$IFDEF UNITVERSIONING}
  UnregisterUnitVersion(HInstance);
  {$ENDIF UNITVERSIONING}

end.
