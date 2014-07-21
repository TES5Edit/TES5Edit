unit GlassButton;

{$IF CompilerVersion >= 17}
  {$DEFINE USEREGION}
{$IFEND}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

// © 2011 by Roy Magne Klever. All rights reserved
// WEB: www.rmklever.com
// Mail: roymagne@rmklever.com

interface

uses
  Windows, Messages, Controls, Graphics, ImgList, Menus, Classes, Math, SysUtils, Forms;

const
  CM_POPREFRESH = WM_USER + 1299;
  CM_POPUP      = WM_USER + 1300;

type
  TWinControlCracker = class(TWinControl);
  PRGB24 = ^TRGB24;
  TRGB24 = packed record
    B: Byte;
    G: Byte;
    R: Byte;
  end;
  PLine24 = ^TLine24;
  TLine24 = array[0..0] of TRGB24;
  PRGBArray = ^TRGBArray;
  TRGBArray = array[0..0] of TRGB24;
  TShadowStyle = (ssNone, ssGlow, ssDrop);
  TTextAlign = (taLeft, taCenter, taRight);
  TAlphaRender = procedure(ABitmap: TBitmap; ARect: TRect; AColor: TColor; Alpha: Byte) of Object;

  TGlassButton = class(TCustomControl)
  private
    FActive: Boolean;
    FCancel: Boolean;
    FDefault: Boolean;
    FModalResult: TModalResult;
    ArrowX, ArrowY, GlyphX, GlyphY, TextX, TextY: Integer;
    TextRect: TRect;
    GlowColor: TRGB24;
    FAltFocus: Boolean;
    FAltRender: Boolean;
    FArrow: Boolean;
    FBlurLevel: Integer;
    FBmp: TBitmap;
    FBtnIdx: Integer;
    FButtonDown: Boolean;
    FCaption: string;
    FColor, FColorDown, FColorFocused, FColorOver, FColorFrame, FColorGlow, FDisabledColor: TColor;
    FDown: Boolean;
    FDuoStyle: Boolean;
    FFlat: Boolean;
    FFont: TFont;
    FGloss: Integer;
    FGlossy: Boolean;
    FGlossyLevel: Byte;
    FImages: TCustomImageList;
    FImageIndex, FImageOffset, FImageSpacing: Integer;
    FLightHeight: Integer;
    FNoClick: Boolean;
    FPopup: Boolean;
    FPopupAlignment: TPopupAlignment;
    FPopupMenu: TPopupMenu;
    FPopupOff: Integer;
    FShadowStyle: TShadowStyle;
    FSingleBorder: Boolean;
    FTextAlign: TTextAlign;
    FOnPopup: TNotifyEvent;
    FOnMouseEnter, FOnMouseLeave, FOnBeforePopup: TNotifyEvent;
    FEnabled: Boolean;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMIsToolControl(var Message: TMessage); message CM_ISTOOLCONTROL;
    procedure CMPopUp(var Message: TMessage); message CM_POPUP;
    procedure CMTextChanged(var Msg: TMessage); message CM_TEXTCHANGED;
    procedure InitPos;
    procedure PaintButton;
    procedure SetColor(const Value: TColor);
    procedure SetDefault(Value: Boolean);
    procedure SetFrameColor(const Value: TColor);
    procedure SetColorDown(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetCaption(const Value: string);
    procedure SetDuoStyle(const Value: Boolean);
    procedure SetArrow(const Value: Boolean);
    procedure SetImgIdx(const Value: Integer);
    procedure PaintAlphaArrow(ShowDown: Boolean);
    procedure PaintAlphaRect(ABitmap: TBitmap; ARect: TRect; AColor: TColor; Alpha: Byte);
    procedure PaintAlphaTxt(ShowDown, ShowArrow: Boolean);
    procedure SetColorFocused(const Value: TColor);
    procedure SetColorOver(const Value: TColor);
    procedure SetDown(const Value: Boolean);
    procedure SetGlossy(const Value: Boolean);
    procedure SetGlossyLevel(const Value: Byte);
    procedure SetImageSpacing(const Value: Integer);
    procedure SetImageOffset(const Value: Integer);
    procedure SetLightHeight(const Value: Integer);
    procedure SetShadowColor(const Value: TColor);
    procedure SetShadowStyle(const Value: TShadowStyle);
    procedure SetSingleBorder(const Value: Boolean);
    procedure WMERASEBKGND(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure SetDisabledColor(const Value: TColor);
    procedure SetFlat(const Value: Boolean);
    procedure SetTextAlign(const Value: TTextAlign);
    procedure PaintAlphaRectAlt(ABitmap: TBitmap; ARect: TRect; AColor: TColor; Alpha: Byte);
    procedure SetAltFocus(const Value: Boolean);
    procedure SetAltRender(const Value: Boolean);
  protected
    AlphaRender: TAlphaRender;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure PaintWindow(DC: HDC); override;
    procedure CreateWnd; override;
    procedure Resize; override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetButtonStyle(ADefault: Boolean); virtual;
    procedure WMGetDlgCode(var message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKILLFOCUS(var Message: TWMKILLFOCUS); message WM_KILLFOCUS;
    procedure WMSETFOCUS(var Message: TWMSETFOCUS); message WM_SETFOCUS;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowPopup;
    procedure Click; override;
  published
    property Align;
    property AltFocus: Boolean read FAltFocus write SetAltFocus;
    property AltRender: Boolean read FAltRender write SetAltRender;
    property Anchors;
    property Arrow: Boolean read FArrow write SetArrow default False;
    property AutoSize;
    property Cancel: Boolean read FCancel write FCancel default False;
    property Caption: string read FCaption write SetCaption;
    property Color: TColor read FColor write SetColor default $00F4F4F4;
    property ColorDown: TColor read FColorDown write SetColorDown default clGray;
    property ColorFocused: TColor read FColorFocused write SetColorFocused default clYellow;
    property ColorOver: TColor read FColorOver write SetColorOver default clGray;
    property ColorFrame: TColor read FColorFrame write SetFrameColor default clGray;
    property ColorShadow: TColor read FColorGlow write SetShadowColor default clBlack;
    property ColorDisabled: TColor read FDisabledColor write SetDisabledColor default clSilver;
    property Default: Boolean read FDefault write SetDefault default False;
    property Down: Boolean read FDown write SetDown default False;
    property DropDownAlignment: TPopupAlignment read FPopupAlignment write FPopupAlignment;
    property DropDownMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    property DuoStyle: Boolean read FDuoStyle write SetDuoStyle default False;
    property Enabled read FEnabled write SetEnabled default True;
    property Flat: Boolean read FFlat write SetFlat default True;
    property Font: TFont read FFOnt write SetFont;
    property Glossy: Boolean read FGlossy write SetGlossy default False;
    property GlossyLevel: Byte read FGlossyLevel write SetGlossyLevel default 20;
    property Height;
    property ImageIdx: Integer read FImageIndex write SetImgIdx default -1;
    property ImageOffset: Integer read FImageOffset write SetImageOffset default 4;
    property Images: TCustomImageList read FImages write FImages;
    property ImageSpacing: Integer read FImageSpacing write SetImageSpacing default 4;
    property Left;
    property LightHeight: Integer read FLightHeight write SetLightHeight;
    property ModalResult: TModalResult read FModalResult write FModalResult default 0;
    property PopupOffset: Integer read FPopupOff write FPopupOff default 0;
    property ShadowStyle: TShadowStyle read FShadowStyle write SetShadowStyle default ssGlow;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TextAlign: TTextAlign read FTextAlign write SetTextAlign;
    property Top;
    property Visible;
    property Width;
    property OnBeforePopup: TNotifyEvent read FOnBeforePopup write FOnBeforePopup;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnKeyDown;
    property OnKeyUp;
    property OnResize;
    property SingleBorder: Boolean read FSingleBorder write SetSingleBorder default False;
  end;

  TGlowLabel = class(TCustomControl)
  private
    TextX, TextY: Integer;
    GlowColor: TRGB24;
    FBlurLevel: Integer;
    FBmp: TBitmap;
    FCaption: string;
    FColor, FColorGlow: TColor;
    FFont: TFont;
    FShadowStyle: TShadowStyle;
    FOnMouseEnter, FOnMouseLeave: TNotifyEvent;
    FEnabled: Boolean;
    procedure InitPos;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMERASEBKGND(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure PaintArea;
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetCaption(const Value: string);
    procedure PaintAlphaTxt;
    procedure SetShadowColor(const Value: TColor);
    procedure SetShadowStyle(const Value: TShadowStyle);
  protected
    procedure SetEnabled(Value: Boolean); override;
    procedure PaintWindow(DC: HDC); override;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property AutoSize;
    property Caption: string read FCaption write SetCaption;
    property Color: TColor read FColor write SetColor default $00F4F4F4;
    property ColorShadow: TColor read FColorGlow write SetShadowColor default clBlack;
    property Enabled read FEnabled write SetEnabled default True;
    property Font: TFont read FFOnt write SetFont;
    property Left;
    property Top;
    property Width;
    property Height;
    property ShadowStyle: TShadowStyle read FShadowStyle write SetShadowStyle default ssGlow;
    property ShowHint;
    property TabOrder;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnKeyDown;
    property OnKeyUp;
    property OnResize;
  end;

function Blend(Color1, Color2: TColor; A: Byte): TColor;

implementation

procedure DrawParentImage(Control: TControl; Dest: TCanvas);
var
  SaveIndex: Integer;
  DC: HDC;
  Position: TPoint;
begin
  with Control do
    if Parent <> nil then
    begin
      DC := Dest.Handle;
      SaveIndex := SaveDC(DC);
      GetViewportOrgEx(DC, Position);
      SetViewportOrgEx(DC, Position.X - Left, Position.Y - Top, nil);
      IntersectClipRect(DC, 0, 0, Parent.ClientWidth, Parent.ClientHeight);
      Parent.Perform(WM_ERASEBKGND, DC, 0);
      Parent.Perform(WM_PAINT, DC, 0);
      RestoreDC(DC, SaveIndex);
    end;
end;

procedure fxBoxBlur(Src: TBitmap; radius, rep: integer);
type
  PintRGB = ^TintRGB;
  TintRGB = packed record
    iB: Integer;
    iG: Integer;
    iR: Integer;
  end;
var
  j, divF, i, w, h, x, y, ny, tx, ty, prg, rad1: integer;
  ox, radm1, boxW, boxH: Integer;
  p: pRGB24;
  ptrS, ptrD, pv: integer;
  s0, s1: pRGB24;
  bool: boolean;
  lutRGB: array of TIntRGB;
  r, g, b: Byte;
begin
  if radius = 0 then
    Exit;
  divF := (radius * 2) + 1;
  w := Src.Width - 1;
  h := Src.Height - 1;
  SetLength(lutRGB, Max(w, h) + 1 + (radius * 2));
  s1 := Src.ScanLine[0];
  ptrD := integer(Src.ScanLine[1]) - integer(s1);
  rad1 := radius - 1;
  ny := Integer(s1);
  for y := 0 to h do
  begin
    for j := 1 to rep do
    begin
      for i := - radius to 0 do
        with pRGB24(ny)^, lutRGB[i + Radius] do
        begin
          iR := r + lutRGB[i + radius - 1].iR;
          iG := g + lutRGB[i + radius - 1].iG;
          iB := b + lutRGB[i + radius - 1].iB;
        end;
      for i := 1 to w do
      begin
        tx := i;
        with pRGB24(ny + tx * 3)^, lutRGB[i + Radius] do
        begin
          iR := r + lutRGB[i + radius - 1].iR;
          iG := g + lutRGB[i + radius - 1].iG;
          iB := b + lutRGB[i + radius - 1].iB;
        end;
      end;
      prg := w * 3;
      for i := w + 1 to w + radius do
        with pRGB24(ny + prg)^, lutRGB[i + Radius] do
        begin
          iR := r + lutRGB[i + radius - 1].iR;
          iG := g + lutRGB[i + radius - 1].iG;
          iB := b + lutRGB[i + radius - 1].iB;
        end;
      ox := 0;
      for x := 0 to w do
      begin
        tx := x + radius;
        with pRGB24(ny + ox)^, lutRGB[tx + radius] do
        begin
          r := ((iR - lutRGB[tx - radius - 1].iR) div divF);
          g := ((iG - lutRGB[tx - radius - 1].iG) div divF);
          b := ((iB - lutRGB[tx - radius - 1].iB) div divF);
        end;
        inc(ox, 3);
      end;
    end;
    inc(ny, PtrD);
  end;
  ox := 0;
  for x := 0 to w do
  begin
    for j := 0 to rep do
    begin
      ny := Integer(s1);
      for i := -radius to 0 do
        with pRGB24(ny + x * 3)^, lutRGB[i + radius] do
        begin
          iR := r + lutRGB[i + radius - 1].iR;
          iG := g + lutRGB[i + radius - 1].iG;
          iB := b + lutRGB[i + radius - 1].iB;
        end;
      for i := 1 to h do
      begin
        inc(ny, PtrD);
        with pRGB24(ny + x * 3)^, lutRGB[i + radius] do
        begin
          iR := r + lutRGB[i + radius - 1].iR;
          iG := g + lutRGB[i + radius - 1].iG;
          iB := b + lutRGB[i + radius - 1].iB;
        end;
      end;
      for i := h + 1 to h + radius do
        with pRGB24(ny + x * 3)^, lutRGB[i + radius] do
        begin
          iR := r + lutRGB[i + radius - 1].iR;
          iG := g + lutRGB[i + radius - 1].iG;
          iB := b + lutRGB[i + radius - 1].iB;
        end;
      ny := Integer(s1);
      for y := 0 to h do
      begin
        ty := y + radius;
        with pRGB24(ny + ox)^, lutRGB[ty + radius] do
        begin
          r := ((iR - lutRGB[ty - radius - 1].iR) div divF);
          g := ((iG - lutRGB[ty - radius - 1].iG) div divF);
          b := ((iB - lutRGB[ty - radius - 1].iB) div divF);
        end;
        inc(ny, PtrD);
      end;
    end;
    inc(ox, 3);
  end;
  SetLength(lutRGB, 0);
  s1 := Src.ScanLine[0];
  for y := 0 to h do
  begin
    for x := 0 to w do
    begin
      r:= PRGBArray(s1)[x].R;
      g:= PRGBArray(s1)[x].G;
      b:= PRGBArray(s1)[x].B;
      r:= Byte((r + g + b) div 3);
      PRGBArray(s1)[x].B := r;
      PRGBArray(s1)[x].G := r;
      PRGBArray(s1)[x].R := r;
    end;
    inc(Integer(s1), PtrD);
  end;
end;

procedure fxBoxBlur8(Src: TBitmap; radius, rep: integer);
var
  j, divF, i, w, h, x, y, ny, tx, ty: integer;
  ox: Integer;
  ptrD: integer;
  s1: pByte;
  lut8: array of Integer;
begin
  if radius = 0 then
    Exit;
  divF := (radius * 2) + 1;
  w := Src.Width - 1;
  h := Src.Height - 1;
  SetLength(lut8, Max(w, h) + 1 + (radius * 2));
  s1 := Src.ScanLine[0];
  ptrD := integer(Src.ScanLine[1]) - integer(s1);
  ny := Integer(s1);
  for y := 0 to h do
  begin
    for j := 1 to rep do
    begin
      for i := - radius to 0 do
        lut8[i + Radius] :=  pByte(ny)^ + lut8[i + radius - 1];
      for i := 1 to w do
      begin
        tx := i;
        lut8[i + Radius]:= pByte(ny + tx)^ + lut8[i + radius - 1];
      end;
      for i := w + 1 to w + radius do
        lut8[i + Radius]:= pByte(ny + w)^ + lut8[i + radius - 1];
      ox := 0;
      for x := 0 to w do
      begin
        tx := x + radius;
        pByte(ny + ox)^:= ((lut8[tx + radius] - lut8[tx - radius - 1]) div divF);
        inc(ox, 1);
      end;
    end;
    inc(ny, PtrD);
  end;
  ox := 0;
  for x := 0 to w do
  begin
    for j := 0 to rep do
    begin
      ny := Integer(s1);
      for i := -radius to 0 do
        lut8[i + radius]:= pByte(ny + x)^ + lut8[i + radius - 1];
      for i := 1 to h do
      begin
        inc(ny, PtrD);
        lut8[i + radius]:= pByte(ny + x)^ + lut8[i + radius - 1];
      end;
      for i := h + 1 to h + radius do
        lut8[i + radius]:= pByte(ny + x)^ + lut8[i + radius - 1];
      ny := Integer(s1);
      for y := 0 to h do
      begin
        ty := y + radius;
        pByte(ny + ox)^:= ((lut8[ty + radius] - lut8[ty - radius - 1]) div divF);
        inc(ny, PtrD);
      end;
    end;
    inc(ox, 1);
  end;
  SetLength(lut8, 0);
end;

function Blend(Color1, Color2: TColor; A: Byte): TColor;  inline;
var
  c1, c2: LongInt;
  r, g, b, v1, v2: byte;
begin
  A := Round(2.55 * A);
  c1 := ColorToRGB(Color1);
  c2 := ColorToRGB(Color2);
  v1 := Byte(c1);
  v2 := Byte(c2);
  r := Byte(A * (v1 - v2) shr 8 + v2);
  v1 := Byte(c1 shr 8);
  v2 := Byte(c2 shr 8);
  g := Byte(A * (v1 - v2) shr 8 + v2);
  v1 := Byte(c1 shr 16);
  v2 := Byte(c2 shr 16);
  b := Byte(A * (v1 - v2) shr 8 + v2);
  Result := (b shl 16) + (g shl 8) + r;
end;

{$IF Defined(USEREGION)} {$REGION 'TGlassButton'} {$IFEND}
procedure TGlassButton.PaintWindow(DC: HDC);
begin
  Canvas.Lock;
  try
    Canvas.Handle := DC;
    try
      FBmp.Canvas.Font.Assign(FFont);
      PaintButton;
    finally
      Canvas.Handle := 0;
    end;
  finally
    Canvas.Unlock;
  end;
end;

procedure PaintArrow(Canvas: TCanvas; x, y: Integer);
begin
  with Canvas do
  begin
    MoveTo(x + 3, y + 3);
    LineTo(x + 7, y + 3);
    LineTo(x + 5, Y + 5);
    LineTo(x + 3, y + 3);
    LineTo(x + 6, y + 5);
    MoveTo(x + 2, y + 2);
    LineTo(x + 9, y + 2);
  end
end;

procedure TGlassButton.PaintAlphaArrow(ShowDown: Boolean);
var
  row, slSize, x, y, i: Integer;
  rowSrc, slSizeSrc: Integer;
  slPnt, slPntSrc: PRGB24;
  Bmp: TBitmap;
begin
  if ShowDown then
    i := 1
  else
    i := 0;
  if FShadowStyle <> ssNone then
  begin
    Bmp := TBitmap.Create;
    try
      Bmp.PixelFormat := pf24bit;
      Bmp.Width := 24;
      Bmp.Height := ClientHeight - 2;
      Bmp.Canvas.Brush.Color := clWhite;
      Bmp.Canvas.FillRect(Bmp.Canvas.ClipRect);
      Bmp.Canvas.Pen.Color:= clBlack;
      if ShadowStyle = ssGlow then
        PaintArrow(Bmp.Canvas, 9, ArrowY)
      else
        PaintArrow(Bmp.Canvas, 10, ArrowY + 1);
      fxBoxBlur(Bmp, FBlurLevel, 3);
      row := Integer(FBmp.Scanline[i]);
      slSize := Integer(FBmp.Scanline[i + 1]) - row;
      rowSrc := Integer(Bmp.Scanline[0]);
      slSizeSrc := Integer(Bmp.Scanline[1]) - rowSrc;
      row:= row  + (((FBmp.Width - 24) + i) * 3);
      for y := 0 to Bmp.Height - 1 do
      begin
        slPnt := pRGB24(row);
        slPntSrc := pRGB24(rowSrc);
        for x := 0 to Bmp.Width - 1 do
        begin
          slPnt.r := Byte(slPntSrc.R * (slPnt.R - GlowColor.R) shr 8 + GlowColor.R);
          slPnt.g := Byte(slPntSrc.R * (slPnt.G - GlowColor.G) shr 8 + GlowColor.G);
          slPnt.b := Byte(slPntSrc.R * (slPnt.B - GlowColor.B) shr 8 + GlowColor.B);
          inc(slPnt);
          Inc(slPntSrc);
        end;
        inc(row, slSize);
        inc(rowSrc, slSizeSrc);
      end;
    finally
      Bmp.Free;
    end;
  end;
  FBmp.Canvas.Pen.Color:= FBmp.Canvas.Font.Color;
  PaintArrow(FBmp.Canvas, ArrowX + i, ArrowY + i);
end;

procedure GrayBitmap(FBitmap: TBitmap);
var
  l: PByteArray;
  x, y: integer;
  r, g, b: Byte;
  c: TColor;
begin
  FBitmap.PixelFormat := pf24bit;
  FBitmap.Transparent := True;
  c := ColorToRGB(FBitmap.Canvas.Pixels[0, FBitmap.Height - 1]);
  r := GetRValue(c);
  g := GetGValue(c);
  b := GetBValue(c);
  for y := 0 to FBitmap.Height - 1 do
  begin
    l := FBitmap.ScanLine[y];
    for x := 0 to FBitmap.Width - 1 do
      if not ((l[x * 3] = b) and (l[x * 3 + 1] = g) and (l[x * 3 + 2] = r)) then
      begin
        l[x * 3] := (l[x * 3] + l[x * 3 + 1] + l[x * 3 + 2]) div 3;
        l[x * 3 + 1] := l[x * 3];
        l[x * 3 + 2] := l[x * 3];
      end;
  end;
  FBitmap.TransparentColor := FBitmap.Canvas.Pixels[0, FBitmap.Height - 1];
end;

procedure TGlassButton.PaintAlphaTxt(ShowDown, ShowArrow: Boolean);
const
  txtLeft   = DT_END_ELLIPSIS or DT_SINGLELINE or DT_LEFT   or DT_VCENTER;
  txtCenter = DT_END_ELLIPSIS or DT_SINGLELINE or DT_CENTER or DT_VCENTER;
  txtRight  = DT_END_ELLIPSIS or DT_SINGLELINE or DT_RIGHT  or DT_VCENTER;
var
  row, slSize, x, y, i, off: Integer;
  rowSrc, slSizeSrc: Integer;
  slPnt, slPntSrc: PRGB24;
  ts: TSize;
  Bmp, BmpAlpha: TBitmap;
  DC: HDC;
  Glyph: Boolean;
  tr: TRect;
begin
  if ShowDown then
    i := 1
  else
    i := 0;
  Glyph := (FImageIndex <> -1) and (Assigned(FImages));
  if (FShadowStyle <> ssNone) and FEnabled then
  begin
    BmpAlpha:= TBitmap.Create;
    try
      BmpAlpha.PixelFormat := pf24bit;
      BmpAlpha.Width := FBmp.Width - 2;
      BmpAlpha.Height := FBmp.Height - 2;
      BmpAlpha.Canvas.Brush.Color := clWhite;
      BmpAlpha.Canvas.FillRect(BmpAlpha.Canvas.ClipRect);
      if Glyph then
      begin
        Bmp := TBitmap.Create;
        try
          Bmp.Monochrome := True;
          FImages.GetBitmap(FImageIndex, bmp);
          BmpAlpha.Canvas.Brush.Color := clBlack;
          DC := BmpAlpha.Canvas.Handle;
          SetTextColor(DC, clBlack);
          SetBkColor(DC, clWhite);
          if FShadowStyle = ssGlow then
            BitBlt(DC, GlyphX, GlyphY , Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCAND)
          else
            BitBlt(DC, GlyphX + 1, GlyphY + 1, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCAND);
        finally
          Bmp.Free;
        end;
      end;
      if FCaption <> '' then
      begin
        BmpAlpha.Canvas.Font.Assign(FFont);
        ts := BmpAlpha.Canvas.TextExtent(FCaption);
        BmpAlpha.Canvas.Brush.Style := bsClear;
        BmpAlpha.Canvas.Font.Color := clBlack;
        if FShadowStyle <> ssGlow then
          off := 1
        else
          off := 0;
        tr := TextRect;
        tr.Left := tr.Left + off;
        tr.Top:= tr.Top + off;
        tr.Right:= tr.Right + off;
        tr.Bottom:= tr.Bottom + off;
        case FTextAlign of
          taCenter: DrawText(BmpAlpha.Canvas.Handle, PChar(FCaption), Length(FCaption), tr, txtCenter);
          taRight: DrawText(BmpAlpha.Canvas.Handle, PChar(FCaption), Length(FCaption), tr, txtRight);
        else
          DrawText(BmpAlpha.Canvas.Handle, PChar(FCaption), Length(FCaption), tr, txtLeft);
        end;
      end;
      if ShowArrow then
      begin
        BmpAlpha.Canvas.Pen.Color := clBlack;
        if FShadowStyle = ssGlow then
          PaintArrow(BmpAlpha.Canvas, ArrowX, ArrowY)
        else
          PaintArrow(BmpAlpha.Canvas, ArrowX + 1, ArrowY + 1);
      end;
      fxBoxBlur(BmpAlpha, FBlurLevel, 3);
      row := Integer(FBmp.Scanline[i]);
      slSize := Integer(FBmp.Scanline[i + 1]) - row;
      rowSrc := Integer(BmpAlpha.Scanline[0]);
      slSizeSrc := Integer(BmpAlpha.Scanline[1]) - rowSrc;
      row := row  + (i * 3);
      for y := 0 to BmpAlpha.Height - 1 do
      begin
        slPnt := pRGB24(row);
        slPntSrc := pRGB24(rowSrc);
        for x := 0 to BmpAlpha.Width - 1 do
        begin
          slPnt.r := Byte(slPntSrc.R * (slPnt.R - GlowColor.R) shr 8 + GlowColor.R);
          slPnt.g := Byte(slPntSrc.R * (slPnt.G - GlowColor.G) shr 8 + GlowColor.G);
          slPnt.b := Byte(slPntSrc.R * (slPnt.B - GlowColor.B) shr 8 + GlowColor.B);
          inc(slPnt);
          Inc(slPntSrc);
        end;
        inc(row, slSize);
        inc(rowSrc, slSizeSrc);
      end;
      finally
        BmpAlpha.Free;
      end;
  end;
  if Glyph then
    if FEnabled then
      FImages.Draw(FBmp.Canvas, GlyphX + i, GlyphY + i, FImageIndex)
    else
    begin
      Bmp:= TBitmap.Create;
      try
        FImages.GetBitmap(FImageIndex, bmp);
        GrayBitmap(Bmp);
        FBmp.Canvas.Draw(GlyphX + i, GlyphY + i, Bmp);
      finally
        Bmp.Free;
      end;
    end;
  tr := TextRect;
  tr.Left := tr.Left + i;
  tr.Top := tr.Top + i;
  tr.Right := tr.Right + i;
  tr.Bottom := tr.Bottom + i;
  if FEnabled then
    FBmp.Canvas.Font.Color := Font.Color
  else
    FBmp.Canvas.Font.Color := FDisabledColor;
  FBmp.Canvas.Brush.Style := bsClear;
  case FTextAlign of
    taCenter: DrawText(FBmp.Canvas.Handle, PChar(FCaption), Length(FCaption), tr, txtCenter);
    taRight: DrawText(FBmp.Canvas.Handle, PChar(FCaption), Length(FCaption), tr, txtRight);
  else
    DrawText(FBmp.Canvas.Handle, PChar(FCaption), Length(FCaption), tr, txtLeft);
  end;
  if ShowArrow then
  begin
    FBmp.Canvas.Pen.Color:= FBmp.Canvas.Font.Color;
    PaintArrow(FBmp.Canvas, ArrowX + i, ArrowY + i);
  end;
end;

procedure TGlassButton.PaintAlphaRect(ABitmap: TBitmap; ARect: TRect; AColor: TColor; Alpha: Byte);
var
  C: LongInt;
  i, row, slSize, x, y: Integer;
  Ra, Ga, Ba: array[0..255] of Byte;
  Col: TRGB24;
  slPnt: PRGB24;
  a, aStep, h: Integer;
begin
  C := ColorToRGB(AColor);
  Col.B := (C shr 16) and $FF;
  Col.G := (C shr 8) and $FF;
  Col.R := C and $FF;
  for i := 0 to 255 do
  begin
    Ra[i] := Byte(Alpha * (Col.R - i) shr 8 + i);
    Ga[i] := Byte(Alpha * (Col.G - i) shr 8 + i);
    Ba[i] := Byte(Alpha * (Col.B - i) shr 8 + i);
  end;
  row := Integer(ABitmap.Scanline[ARect.Top]);
  slSize := Integer(ABitmap.Scanline[ARect.Top + 1]) - row;
  row := row  + (ARect.Left * 3);
  h := 0;
  if FGlossy then
  begin
    a := 176;
    h := (ARect.Bottom - ARect.Top) shr 1;
    aStep := (a - Alpha) div h;
    for y := 0 to h -1 do
    begin
      slPnt := pRGB24(row);
      for x := ARect.Left to ARect.Right - 1 do
      begin
        slPnt.R := Byte(a * (Col.R - slPnt.R) shr 8 + slPnt.R);
        slPnt.G := Byte(a * (Col.G - slPnt.G) shr 8 + slPnt.G);
        slPnt.B := Byte(a * (Col.B - slPnt.B) shr 8 + slPnt.B);
        inc(slPnt)
      end;
      a := a - aStep;
      inc(row, slSize);
    end;
  end;
  for y := h to ARect.Bottom - 1 do
  begin
    slPnt := pRGB24(row);
    for x := ARect.Left to ARect.Right - 1 do
    begin
      slPnt.R := Ra[slPnt.R];
      slPnt.G := Ga[slPnt.G];
      slPnt.B := Ba[slPnt.B];
      inc(slPnt)
    end;
    inc(row, slSize);
  end;
end;

procedure TGlassButton.PaintAlphaRectAlt(ABitmap: TBitmap; ARect: TRect; AColor: TColor; Alpha: Byte);
var
  C: LongInt;
  i, row, slSize, x, y: Integer;
  Ra, Ga, Ba: array[0..255] of Byte;
  Col: TRGB24;
  slPnt: PRGB24;
  a, aStep, h: Integer;
begin
  C:= ColorToRGB(AColor);
  Col.B := (C shr 16) and $FF;
  Col.G := (C shr 8) and $FF;
  Col.R := C and $FF;
  for i := 0 to 255 do
  begin
    Ra[i] := Byte(Alpha * (Col.R - i) shr 8 + i);
    Ga[i] := Byte(Alpha * (Col.G - i) shr 8 + i);
    Ba[i] := Byte(Alpha * (Col.B - i) shr 8 + i);
  end;
  row:= Integer(ABitmap.Scanline[ARect.Top]);
  slSize:= Integer(ABitmap.Scanline[ARect.Top + 1]) - row;
  row:= row  + (ARect.Left * 3);
  if FGlossy then
  begin
    a:= 176;
    h:= (ARect.Bottom - ARect.Top) shr 1;
    aStep:= (a - Alpha) div h;
    for y := 0 to ARect.Bottom - 1 do
    begin
      slPnt := pRGB24(row);
      for x := ARect.Left to ARect.Right - 1 do
      begin
        slPnt.R := Ra[slPnt.R];
        slPnt.G := Ga[slPnt.G];
        slPnt.B := Ba[slPnt.B];
        if y < h then
        begin
          slPnt.R := Byte(a * (255 - slPnt.R) shr 8 + slPnt.R);
          slPnt.G := Byte(a * (255 - slPnt.G) shr 8 + slPnt.G);
          slPnt.B := Byte(a * (255 - slPnt.B) shr 8 + slPnt.B);
        end;
        inc(slPnt);
      end;
      a:= a - aStep;
      inc(row, slSize);
    end;
  end;
end;

procedure AlphaGlow(ABitmap: TBitmap; AVal: Byte; AColor: TColor; ALH: Integer);
var
  x, y, w, h, j, w1: Integer;
  Row: PRGBArray;
  slMain, slSize, slPtr: Integer;
  r, g, b, a: Byte;
begin
  if ALH > ABitmap.Height then
    ALH:= ABitmap.Height;
  h := ABitmap.Height;
  w := ABitmap.Width;
  AColor:= ColorToRGB(AColor);
  r:= Byte(AColor);
  g:= Byte(AColor shr 8);
  b:= Byte(AColor shr 16);
  w1 := w - 1;
  w := (w shr 1) + (w and 1);
  slMain := Integer(ABitmap.ScanLine[h - ALH]);
  slSize := Integer(ABitmap.ScanLine[h - (ALH - 1)]) - slMain;
  for x := 0 to w - 1 do
  begin
    j:= MulDiv(AVal, x, w);
    slPtr := slMain;
    for y := 0 to ALH - 2 do
    begin
      Row := PRGBArray(slPtr);
      a:= 255 - MulDiv(j, y, ALH);
      Row[x].r := a * (Row[x].r - r) shr 8 + r;
      Row[x].g := a * (Row[x].g - g) shr 8 + g;
      Row[x].b := a * (Row[x].b - b) shr 8 + b;
      if (x < (w1 - x)) then
      begin
        Row[w1 - x].r := a * (Row[w1 - x].r - r) shr 8 + r;
        Row[w1 - x].g := a * (Row[w1 - x].g - g) shr 8 + g;
        Row[w1 - x].b := a * (Row[w1 - x].b - b) shr 8 + b;
      end;
      slPtr := slPtr + slSize;
    end;
  end;
end;

procedure TGlassButton.PaintButton;
const
  TxtOp: Integer = DT_END_ELLIPSIS or DT_SINGLELINE or DT_NOPREFIX or DT_VCENTER;
var
  r, r1, r2: TRect;
  bool, down: Boolean;
  c1, c2, c3, c4: TColor;
begin
  InitPos;
  FBmp.Width := ClientWidth;
  FBmp.Height := ClientHeight;
  FBmp.Canvas.Brush.Style := bsClear;
  DrawParentImage(Self, FBmp.Canvas);
  r:= ClientRect;
  if Focused or not FFlat then
  begin
    c1:= Blend(FBmp.Canvas.Pixels[r.Left, r.Bottom - 1], FBmp.Canvas.Pixels[r.Left, r.Top], 50);
    c2:= Blend(FBmp.Canvas.Pixels[r.Left, r.Top], FBmp.Canvas.Pixels[r.Right - 1, r.Top], 50);
    c3:= Blend(FBmp.Canvas.Pixels[r.Right - 1, r.Top], FBmp.Canvas.Pixels[r.Right -1, r. Bottom - 1], 50);
    c4:= Blend(FBmp.Canvas.Pixels[r.Left, r.Bottom - 1], FBmp.Canvas.Pixels[r.Right -1, r.Bottom -1], 50);
    c1:= Blend(c1, c2, 50);
    c2:= Blend(c3, c4, 50);
    c1:= Blend(c1, c2, 50);
    if Focused then
      c1:= Blend(c1, FColorOver, 50)
    else
      c1:= Blend(c1, FColorFrame, 50);
    InflateRect(r, -1, -1);
    if (FBtnIdx = -1) then
      AlphaRender(FBmp, r, Color, FGloss);
    if Focused then
      if FAltFocus then
        AlphaRender(FBmp, r, FColorFocused, FGloss)
      else
        AlphaGlow(FBmp, 255, FColorFocused, FLightHeight);
    r:= ClientRect;
    FBmp.Canvas.Pen.Color:= c1;
    FBmp.Canvas.Polyline([Point(r.Left, r.Top + 2), Point(r.Left + 2, r.Top),
      Point(r.Left + 2, r.Top), Point(r.Right - 3, r.Top), Point(r.Right - 1, r.Top + 2),
      Point(r.Right - 1, r.Bottom - 3), Point(r.Right - 3, r.Bottom - 1), Point(r.Left + 2, r.Bottom - 1),
      Point(r.Left, r.Bottom - 3), Point(r.Left, r.Top + 2)]);
    FBmp.Canvas.Pixels[r.Left, R. Top + 1] := Blend(FBmp.Canvas.Pixels[r.Left, R. Top + 1], c1, 50);
    FBmp.Canvas.Pixels[r.Left + 1, R. Top] := Blend(FBmp.Canvas.Pixels[r.Left + 1, R. Top], c1, 50);
    FBmp.Canvas.Pixels[r.Right - 1, R. Top + 1] := Blend(FBmp.Canvas.Pixels[r.Right -1, R. Top + 1], c1, 50);
    FBmp.Canvas.Pixels[r.Right - 2, R. Top] := Blend(FBmp.Canvas.Pixels[r.Right - 2, R. Top], c1, 50);
    FBmp.Canvas.Pixels[r.Left, R. Bottom - 2] := Blend(FBmp.Canvas.Pixels[r.Left, R. Bottom - 2], c1, 50);
    FBmp.Canvas.Pixels[r.Left + 1, R. Bottom - 1] := Blend(FBmp.Canvas.Pixels[r.Left + 1, R. Bottom -1], c1, 50);
    FBmp.Canvas.Pixels[r.Right - 1, R. Bottom - 2] := Blend(FBmp.Canvas.Pixels[r.Right -1, R. Bottom - 2], c1, 50);
    FBmp.Canvas.Pixels[r.Right - 2, R. Bottom - 1] := Blend(FBmp.Canvas.Pixels[r.Right - 2, R. Bottom - 1], c1, 50);
  end;

  down:= FButtonDown or (FDown and (not FArrow));
  if (FBtnIdx <> -1) or (csDesigning in ComponentState) or Down then
  begin
    InflateRect(r, -1, -1);
    if not (csDesigning in ComponentState) then
      if down then
        if FDuoStyle then
        begin
          r1 := r;
          r1.Right := r1.Right - 18;
          r2 := r;
          r2.Left := r2.Right - 17;
          if FBtnIdx = 0 then
          begin
            AlphaRender(FBmp, r1, FColorDown, FGloss);
            AlphaRender(FBmp, r2, FColor, FGloss);
          end else
          begin
            AlphaRender(FBmp, r2, FColorDown, FGloss);
            AlphaRender(FBmp, r1, FColor, FGloss);
          end;
        end
        else
          AlphaRender(FBmp, r, FColorDown, FGloss)
      else
        AlphaRender(FBmp, r, FColor, FGloss);
    r:= ClientRect;
    c1:= Blend(FBmp.Canvas.Pixels[r.Left, r.Bottom - 1], FBmp.Canvas.Pixels[r.Left, r.Top], 50);
    c2:= Blend(FBmp.Canvas.Pixels[r.Left, r.Top], FBmp.Canvas.Pixels[r.Right - 1, r.Top], 50);
    c3:= Blend(FBmp.Canvas.Pixels[r.Right - 1, r.Top], FBmp.Canvas.Pixels[r.Right -1, r. Bottom - 1], 50);
    c4:= Blend(FBmp.Canvas.Pixels[r.Left, r.Bottom - 1], FBmp.Canvas.Pixels[r.Right -1, r.Bottom -1], 50);
    c1:= Blend(c1, c2, 50);
    c2:= Blend(c3, c4, 50);
    c1:= Blend(c1, c2, 50);
    c1:= Blend(c1, {FColorFrame}FColorOver, 50);
    FBmp.Canvas.Pen.Color:=  c1;
    FBmp.Canvas.Polyline([Point(r.Left, r.Top + 2), Point(r.Left + 2, r.Top),
      Point(r.Left + 2, r.Top), Point(r.Right - 3, r.Top), Point(r.Right - 1, r.Top + 2),
      Point(r.Right - 1, r.Bottom - 3), Point(r.Right - 3, r.Bottom - 1), Point(r.Left + 2, r.Bottom - 1),
      Point(r.Left, r.Bottom - 3), Point(r.Left, r.Top + 2)]);
    FBmp.Canvas.Pixels[r.Left, R. Top + 1] := Blend(FBmp.Canvas.Pixels[r.Left, R. Top + 1], c1, 50);
    FBmp.Canvas.Pixels[r.Left + 1, R. Top] := Blend(FBmp.Canvas.Pixels[r.Left + 1, R. Top], c1, 50);
    FBmp.Canvas.Pixels[r.Right - 1, R. Top + 1] := Blend(FBmp.Canvas.Pixels[r.Right -1, R. Top + 1], c1, 50);
    FBmp.Canvas.Pixels[r.Right - 2, R. Top] := Blend(FBmp.Canvas.Pixels[r.Right - 2, R. Top], c1, 50);
    FBmp.Canvas.Pixels[r.Left, R. Bottom - 2] := Blend(FBmp.Canvas.Pixels[r.Left, R. Bottom - 2], c1, 50);
    FBmp.Canvas.Pixels[r.Left + 1, R. Bottom - 1] := Blend(FBmp.Canvas.Pixels[r.Left + 1, R. Bottom -1], c1, 50);
    FBmp.Canvas.Pixels[r.Right - 1, R. Bottom - 2] := Blend(FBmp.Canvas.Pixels[r.Right -1, R. Bottom - 2], c1, 50);
    FBmp.Canvas.Pixels[r.Right - 2, R. Bottom - 1] := Blend(FBmp.Canvas.Pixels[r.Right - 2, R. Bottom - 1], c1, 50);
    if not FSingleBorder then
    begin
      c3 := Blend(c1, clWhite, 50);
      InflateRect(r, -1, -1);
      FBmp.Canvas.Pen.Color := c3;
      FBmp.Canvas.Polyline([Point(r.Left, r.Top + 1), Point(r.Left + 1, r.Top),
        Point(r.Left + 1, r.Top), Point(r.Right - 2, r.Top), Point(r.Right - 1, r.Top + 1),
        Point(r.Right - 1, r.Bottom - 2), Point(r.Right - 2, r.Bottom - 1), Point(r.Left + 1, r.Bottom - 1),
        Point(r.Left, r.Bottom - 2), Point(r.Left, r.Top + 1)]);
    end;
    r := ClientRect;
    if FDuoStyle then
    begin
      FBmp.Canvas.MoveTo(r.Right - 19, r. Top + 1);
      FBmp.Canvas.LineTo(r.Right - 19, r.Bottom - 1);
      if down then
        if FBtnIdx = 0 then
        begin
          FBmp.Canvas.Pen.Color := Blend(c1, clBlack, 75);
          FBmp.Canvas.Polyline([Point(r.Left + 2, r.Bottom - 2), Point(r.Left + 1, r.Bottom - 3),
            Point(r.Left + 1, r.Top + 2), Point(r.Left + 2, r.Top + 1), Point(r.Right - 19, r.Top + 1)]);
          FBmp.Canvas.Pen.Color := Blend(c1, clWhite, 75);
          FBmp.Canvas.Polyline([Point(r.Right - 20, r.Top + 2), Point(r.Right - 20, r.Bottom - 3),
            Point(r.Right - 20, r.Bottom - 2), Point(r.Left + 2, r.Bottom - 2)]);
        end
        else
        begin
          FBmp.Canvas.Pen.Color := Blend(c1, clBlack, 75);
          FBmp.Canvas.Polyline([Point(r.Right - 18, r.Bottom - 2), Point(r.Right - 18, r.Top + 1),
            Point(r.Right - 2, r.Top + 1), Point(r.Right - 2, r.Top + 1)]);
          FBmp.Canvas.Pen.Color := Blend(c1, clWhite, 75);
          FBmp.Canvas.Polyline([Point(r.Right - 2, r.Top + 2), Point(r.Right - 2, r.Bottom - 3),
            Point(r.Right - 3, r.Bottom - 2), Point(r.Right - 18, r.Bottom - 2)]);
        end
    end
    else
      if down then
      begin
        FBmp.Canvas.Pen.Color := Blend(c1, clBlack, 75);
        FBmp.Canvas.Polyline([Point(r.Left + 2, r.Bottom - 2), Point(r.Left + 1, r.Bottom - 3),
          Point(r.Left + 1, r.Top + 2), Point(r.Left + 2, r.Top + 1), Point(r.Right - 2, r.Top + 1)]);
        FBmp.Canvas.Pen.Color := Blend(c1, clWhite, 75);
        FBmp.Canvas.Polyline([Point(r.Right - 2, r.Top + 2), Point(r.Right - 2, r.Bottom - 3),
          Point(r.Right - 3, r.Bottom - 2), Point(r.Left + 2, r.Bottom - 2)]);
      end;
  end;
  if FDuoStyle then
  begin
    PaintAlphaArrow(down and (FBtnIdx = 1));
    PaintAlphaTxt(down and (FBtnIdx = 0), False);
  end
  else
    PaintAlphaTxt(down, FArrow);
  BitBlt(Canvas.Handle, 0, 0, FBmp.Width, FBmp.Height, FBmp.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure TGlassButton.WMERASEBKGND(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TGlassButton.WMGetDlgCode(var message: TWMGetDlgCode);
begin
  inherited;
  // Answer Delphi that this component wants to handle its own arrow key press:
  message.Result := DLGC_WANTARROWS;
end;

procedure TGlassButton.WMKILLFOCUS(var Message: TWMKILLFOCUS);
begin
  if TabStop then
    Invalidate;
end;

procedure TGlassButton.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TGlassButton.WMSETFOCUS(var Message: TWMSETFOCUS);
begin
  if TabStop then
    Invalidate;
end;

procedure TGlassButton.Click;
var
  Form: TCustomForm;
begin
  Form := GetParentForm(Self);
  if Form <> nil then
    Form.ModalResult := FModalResult;
  if (not Focused) and TabStop then
    SetFocus;
  if FDuoStyle then
  begin
    if FBtnIdx = 0 then
      inherited;
  end
  else
    if FNoClick then
      FNoClick := False
    else
      inherited;
end;

procedure TGlassButton.CMIsToolControl(var Message: TMessage);
begin
  Message.Result := 1;
end;

procedure TGlassButton.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  Invalidate;
  inherited;
  if not (csLoading in ComponentState) then
    Resize;
end;

procedure TGlassButton.SetAltFocus(const Value: Boolean);
begin
  FAltFocus := Value;
  Invalidate;
end;

procedure TGlassButton.SetAltRender(const Value: Boolean);
begin
  FAltRender := Value;
  if Value then
    AlphaRender:= PaintAlphaRectAlt
  else
    AlphaRender:= PaintAlphaRect;
  Invalidate;
end;

procedure TGlassButton.SetArrow(const Value: Boolean);
begin
  FArrow := Value;
  Invalidate;
end;

procedure TGlassButton.SetCaption(const Value: string);
begin
  FCaption := Value;
  Invalidate;
end;

procedure TGlassButton.SetColor(const Value: TColor);
begin
  FColor := ColorToRGB(Value);
  Invalidate;
end;

procedure TGlassButton.SetColorDown(const Value: TColor);
begin
  FColorDown := Value;
  Invalidate;
end;

procedure TGlassButton.SetColorFocused(const Value: TColor);
begin
  FColorFocused := Value;
  Invalidate;
end;

procedure TGlassButton.SetColorOver(const Value: TColor);
begin
  FColorOver := Value;
  Invalidate;
end;

procedure TGlassButton.SetDisabledColor(const Value: TColor);
begin
  FDisabledColor := Value;
  Invalidate;
end;

procedure TGlassButton.SetDown(const Value: Boolean);
begin
  FDown := Value;
  Invalidate;
end;

procedure TGlassButton.SetDuoStyle(const Value: Boolean);
begin
  FDuoStyle := Value;
  Invalidate;
end;

procedure TGlassButton.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
  inherited;
  Invalidate;
end;

procedure TGlassButton.SetFlat(const Value: Boolean);
begin
  FFlat := Value;
  Invalidate;
end;

procedure TGlassButton.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  Caption:= FCaption;
  Invalidate;
end;

procedure TGlassButton.SetDefault(Value: Boolean);
var
  Form: TCustomForm;
begin
  FDefault := Value;
  if HandleAllocated then
  begin
    Form := GetParentForm(Self);
    if Form <> nil then
      Form.Perform(CM_FOCUSCHANGED, 0, Longint(Form.ActiveControl));
  end;
end;

procedure TGlassButton.SetFrameColor(const Value: TColor);
begin
  FColorFrame := ColorToRGB(Value);
  Invalidate;
end;

procedure TGlassButton.SetGlossy(const Value: Boolean);
begin
  FGlossy := Value;
  Invalidate;
end;

procedure TGlassButton.SetGlossyLevel(const Value: Byte);
var
  v: Integer;
begin
  v := Value;
  if v < 0 then
    v := 0;
  if v > 100 then
    v := 100;
  FGlossyLevel := v;
  v := Trunc(v * 2.55);
  v := MulDiv(v, 196, 255);
  FGloss := v;
  Invalidate;
end;

procedure TGlassButton.SetImageOffset(const Value: Integer);
begin
  FImageOffset := Value;
  Invalidate;
end;

procedure TGlassButton.SetImageSpacing(const Value: Integer);
begin
  FImageSpacing := Value;
  Invalidate;
end;

procedure TGlassButton.SetImgIdx(const Value: Integer);
begin
  FImageIndex := Value;
  Invalidate;
end;

procedure TGlassButton.SetLightHeight(const Value: Integer);
begin
  FLightHeight := Value;
  if FLightHeight < 0 then
    FLightHeight := 0;
end;

procedure TGlassButton.SetShadowColor(const Value: TColor);
var
  c: Integer;
begin
  FColorGlow := Value;
  c := ColorToRGB(FColorGlow);
  GlowColor.R := Byte(c);
  GlowColor.G := Byte(c shr 8);
  GlowColor.B := Byte(c shr 16);
  Invalidate;
end;

procedure TGlassButton.SetShadowStyle(const Value: TShadowStyle);
begin
  FShadowStyle := Value;
  Invalidate;
end;

procedure TGlassButton.SetSingleBorder(const Value: Boolean);
begin
  FSingleBorder := Value;
  Invalidate;
end;

procedure TGlassButton.SetTextAlign(const Value: TTextAlign);
begin
  FTextAlign := Value;
  Invalidate;
end;

procedure TGlassButton.ShowPopup;
var
  pt: TPoint;
begin
  if CanFocus then
    SetFocus;
  if Assigned(FPopupMenu) then
  begin
    pt.X := 0;
    if FPopupAlignment = paCenter then
      pt.X := ClientWidth shr 1
    else 
      if FPopupAlignment = paRight then
        pt.X := ClientWidth;
    pt.Y := ClientHeight;
    pt := ClientToScreen(pt);
    if FDuoStyle then
      FBtnidx:= 1
    else
      FBtnIdx:= 0;
    FButtonDown:= True;
    PaintButton;
    if not FPopUp then
      PostMessage(Handle, CM_POPUP, 0, 0);
    FButtonDown := False;
    FBtnIdx := -1;
    FPopUp := False;
    Invalidate;
  end;
end;

procedure TGlassButton.InitPos;
var
  ts: TSize;
begin
  ArrowX := ClientWidth - 15;
  ArrowY := (ClientHeight shr 1) - 4;
  GlyphX := FImageOffset;
  GlyphY := 0;
  if (FImageIndex <> -1) and Assigned(FImages) then
    GlyphY := (ClientHeight - FImages.Height) shr 1;
  ts := FBmp.Canvas.TextExtent(FCaption);
  TextX := FImageOffset;
  if (FImageIndex <> -1) and Assigned(FImages) then
    TextX := TextX + (FImages.Height or FImages.Width) + ImageSpacing;
  TextY := (ClientHeight - ts.cy) shr 1;
  TextRect.Left := TextX;
  TextRect.Right := ClientWidth - FImageOffset;
  if FArrow or FDuoStyle then
    TextRect.Right:=  TextRect.Right - 18;
  TextRect.Bottom := Clientheight;
end;

procedure TGlassButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  FButtonDown := False;
  FPopUp:= False;
  case Key of
    VK_DOWN, VK_UP:
      begin
        if FArrow then
        begin
          Key:= 0;
          FButtonDown:= True;
          if FDuoStyle then
            FBtnIdx:= 1
          else
            FBtnIdx:= 0;
          PaintButton;
        end
        else
          if Key = VK_UP then
            TWinControlCracker(Parent).SelectNext(Self, False, True)
          else
            TWinControlCracker(Parent).SelectNext(Self, True, True);
      end;
    VK_RETURN, VK_SPACE:
      begin
        Key:= 0;
        FButtonDown:= True;
        FBtnIdx:= 0;
        PaintButton;
      end;
    VK_LEFT:
      TWinControlCracker(Parent).SelectNext(Self, False, True);
    VK_RIGHT:
      TWinControlCracker(Parent).SelectNext(Self, True, True);
  end;
end;

procedure TGlassButton.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  FButtonDown := False;
  FPopUp:= False;
  case Key of
    VK_DOWN, VK_UP:
      begin
        Key:= 0;
        if FArrow then
        begin
          if FDuoStyle then
            FBtnIdx:= 1
          else
            FBtnIdx:= 0;
          PostMessage(Handle, CM_POPUP, 0, 0);
        end;
      end;
    VK_SPACE:
      begin
        if not FDuoStyle and Assigned(FPopupMenu) then
          PostMessage(Handle, CM_POPUP, 0, 0)
        else
        begin
          Key:= 0;
          FBtnIdx:= -1;
          PaintButton;
          Click;
        end
      end
  end;
end;

constructor TGlassButton.Create(AOwner: TComponent);
begin
  inherited;
  Color := clWhite;
  ColorFrame := clGray;
  ColorDown := clBlack;
  ColorOver:= clGray;
  ColorFocused:= clSilver;
  ColorShadow:= clBlack;
  ControlStyle := [csClickEvents, csCaptureMouse, csSetCaption];
  if AOwner is TWinControl then
    Parent := TWinControl(AOwner);
  TextRect.Top:= 0;
  TextRect.Bottom:= ClientHeight;
  AlphaRender:= PaintAlphaRect;
  FAltFocus:= False;
  FAltRender:= False;
  FBmp := TBitmap.Create;
  FBmp.PixelFormat := pf24Bit;
  FArrow := False;
  FBlurLevel := 1;
  FBtnIdx := -1;
  FButtonDown := False;
  FDisabledColor:= clGray;
  FDuoStyle := False;
  FFlat:= True;
  FFont := TFont.Create;
  FFont.Name := 'Tahoma';
  FFont.Color := clWhite;
  FFont.Size := 8;
  FGlossy := True;
  GlossyLevel := 37;
  FImageIndex := -1;
  FImageOffset := 4;
  FImageSpacing := 4;
  FEnabled := True;
  FNoClick := False;
  FPopup := False;
  FPopupAlignment := paLeft;
  FPopupOff:= 0;
  FShadowStyle := ssGlow;
  FSingleBorder := False;
  FTextAlign:= taLeft;
  Height := 27;
  FLightHeight:= Height;
  ParentFont := False;
  Width := 57;
  Caption := 'Glass';
  TabStop := True;
end;

destructor TGlassButton.Destroy;
begin
  FBmp.Free;
  FFont.Free;
  inherited Destroy;
end;

procedure TGlassButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (not Focused) and TabStop then
    SetFocus;

  if FPopUp then
  begin
    FPopUp := False;
    if Button = mbLeft then
    begin
      FButtonDown := True;
      if x > ClientWidth - 20 then
        FBtnIdx := 1
      else
        FBtnIdx := 0;
      PaintButton;
    end;
  end
  else
    if Button = mbLeft then
    begin
      FButtonDown := True;
      if x > ClientWidth - 20 then
        FBtnIdx := 1
      else
        FBtnIdx := 0;
      PaintButton;
    end;
  inherited;
end;

procedure TGlassButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  idx: Integer;
begin
  idx := FBtnIdx;
  if Button = mbLeft then
  begin
    FButtonDown := True;
    if FDuoStyle then
    begin
      if x > ClientWidth - 20 then
      begin
        FBtnIdx := 1;
        if not FPopUp and (idx = FBtnIdx) then
          PostMessage(Handle, CM_POPUP, 0, 0);
      end;
    end
    else
    begin
      if Assigned(FPopupMenu) then
        PostMessage(Handle, CM_POPUP, 0, 0);
    end;
  end;
  FButtonDown := False;
  FBtnIdx := -1;
  FPopUp := False;
  Invalidate;
  inherited;
end;

procedure TGlassButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  idx: Integer;
begin
  if (PtInRect(ClientRect, Point(x, y))) and not FButtonDown then
  begin
    if x > ClientWidth - 20 then
      idx := 1
    else
      idx := 0;
    if idx <> FBtnIdx then
    begin
      FBtnIdx := idx;
      Invalidate;
    end;
    FButtonDown := ssLeft in Shift;
  end;
  inherited;
end;

procedure TGlassButton.CMDialogKey(var Message: TCMDialogKey);
begin
  with Message do
    if  (((CharCode in [VK_RETURN, VK_SPACE]) and FActive) or
      ((CharCode = VK_ESCAPE) and FCancel)) and
      (KeyDataToShiftState(Message.KeyData) = []) and CanFocus then
    begin
      Click;
      Result := 1;
    end else
      inherited;
end;

procedure TGlassButton.SetButtonStyle(ADefault: Boolean);
const
  BS_MASK = $000F;
var
  Style: Word;
begin
  if HandleAllocated then
  begin
    if ADefault then Style := BS_DEFPUSHBUTTON else Style := BS_PUSHBUTTON;
    if GetWindowLong(Handle, GWL_STYLE) and BS_MASK <> Style then
      SendMessage(Handle, BM_SETSTYLE, Style, 1);
  end;
end;

procedure TGlassButton.CMFocusChanged(var Message: TCMFocusChanged);
begin
  with Message do
    if Sender is TGlassButton then
      FActive := Sender = Self
    else
      FActive := FDefault;
  SetButtonStyle(FActive);
  inherited;
end;

procedure TGlassButton.CMMouseEnter(var Msg: TMessage);
begin
  FPopUp := False;
  FButtonDown := False;
  FBtnIdx := -1;
  Invalidate;
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
  inherited;
end;

procedure TGlassButton.CMMouseLeave(var Msg: TMessage);
begin
  if not FPopup then
  begin
    FButtonDown := False;
    FBtnIdx := -1;
    Invalidate;
  end;
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
  inherited;
end;

procedure TGlassButton.CMPopUp(var Message: TMessage);
var
  pt: TPoint;
begin
  if Assigned(FPopupMenu) then
  begin
    if Assigned(FOnBeforePopup) then
      FOnBeforePopup(Self);
    pt.X := 0;
    if FPopupAlignment = paCenter then
      pt.X := ClientWidth shr 1
    else
    if FPopupAlignment = paRight then
      pt.X := ClientWidth;
    pt.Y := ClientHeight;
    pt := ClientToScreen(pt);
    PaintButton;
    FPopup:= True;
    if Assigned(FOnPopup) then
      FOnPopup(Self);
    FPopupMenu.Alignment := FPopupAlignment;
    FPopupMenu.Popup(pt.X + FPopupOff, pt.Y);
    FBtnIdx := -1;
    FButtonDown := False;
    Invalidate;
  end;
end;

procedure TGlassButton.CMTextChanged(var Msg: TMessage);
begin
  Invalidate;
end;

procedure TGlassButton.CreateWnd;
begin
  inherited CreateWnd;
  FActive := FDefault;
end;

procedure TGlassButton.Resize;
begin
  Invalidate;
end;
{$IF Defined(USEREGION)} {$ENDREGION} {$IFEND}

{$IF Defined(USEREGION)} {$REGION 'TGlowLabel'} {$IFEND}
procedure TGlowLabel.PaintWindow(DC: HDC);
begin
  Canvas.Lock;
  try
    Canvas.Handle := DC;
    try
      FBmp.Canvas.Font.Assign(FFont);
      PaintArea;
    finally
      Canvas.Handle := 0;
    end;
  finally
    Canvas.Unlock;
  end;
end;

procedure TGlowLabel.PaintAlphaTxt;
var
  row, slSize, x, y: Integer;
  rowSrc, slSizeSrc: Integer;
  slPnt, slPntSrc: PRGB24;
  ts: TSize;
  BmpAlpha: TBitmap;
begin
  if (FShadowStyle <> ssNone) and FEnabled then
  begin
    BmpAlpha:= TBitmap.Create;
    try
      BmpAlpha.PixelFormat := pf24bit;
      BmpAlpha.Width := FBmp.Width - 2;
      BmpAlpha.Height := FBmp.Height - 2;
      BmpAlpha.Canvas.Brush.Color := clWhite;
      BmpAlpha.Canvas.FillRect(BmpAlpha.Canvas.ClipRect);
      if FCaption <> '' then
      begin
        BmpAlpha.Canvas.Font.Assign(FFont);
        ts := BmpAlpha.Canvas.TextExtent(FCaption);
        BmpAlpha.Canvas.Brush.Style := bsClear;
        BmpAlpha.Canvas.Font.Color := clBlack;
        if FShadowStyle = ssGlow then
          BmpAlpha.Canvas.TextOut(TextX + 2, TextY, FCaption)
        else
          BmpAlpha.Canvas.TextOut(TextX + 1, TextY + 1, FCaption);
      end;
      fxBoxBlur(BmpAlpha, FBlurLevel, 3);
      row := Integer(FBmp.Scanline[0]);
      slSize := Integer(FBmp.Scanline[1]) - row;
      rowSrc := Integer(BmpAlpha.Scanline[0]);
      slSizeSrc := Integer(BmpAlpha.Scanline[1]) - rowSrc;
      row := row;
      for y := 0 to BmpAlpha.Height - 1 do
      begin
        slPnt := pRGB24(row);
        slPntSrc := pRGB24(rowSrc);
        for x := 0 to BmpAlpha.Width - 1 do
        begin
          slPnt.r := Byte(slPntSrc.R * (slPnt.R - GlowColor.R) shr 8 + GlowColor.R);
          slPnt.g := Byte(slPntSrc.R * (slPnt.G - GlowColor.G) shr 8 + GlowColor.G);
          slPnt.b := Byte(slPntSrc.R * (slPnt.B - GlowColor.B) shr 8 + GlowColor.B);
          inc(slPnt);
          Inc(slPntSrc);
        end;
        inc(row, slSize);
        inc(rowSrc, slSizeSrc);
      end;
      finally
        BmpAlpha.Free;
      end;
  end;
  if FEnabled then
    FBmp.Canvas.TextOut(TextX + 2, TextY, FCaption)
  else
  begin
    FBmp.Canvas.Font.Color := clBtnShadow;
    FBmp.Canvas.TextOut(TextX, TextY, FCaption);
  end;
end;

procedure TGlowLabel.PaintArea;
begin
  InitPos;
  FBmp.Width := ClientWidth;
  FBmp.Height := ClientHeight;
  FBmp.Canvas.Brush.Style := bsClear;
  DrawParentImage(Self, FBmp.Canvas);
  PaintAlphaTxt;
  BitBlt(Canvas.Handle, 0, 0, FBmp.Width, FBmp.Height, FBmp.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure TGlowLabel.WMERASEBKGND(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TGlowLabel.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TGlowLabel.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  Invalidate;
  inherited;
  if not (csLoading in ComponentState) then
    Resize;
end;

procedure TGlowLabel.SetCaption(const Value: string);
begin
  FCaption := Value;
  Invalidate;
end;

procedure TGlowLabel.SetColor(const Value: TColor);
begin
  FColor := ColorToRGB(Value);
  Invalidate;
end;

procedure TGlowLabel.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
  Invalidate;
  inherited;
end;

procedure TGlowLabel.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  Caption:= FCaption;
  Invalidate;
end;

procedure TGlowLabel.SetShadowColor(const Value: TColor);
var
  c: Integer;
begin
  FColorGlow := Value;
  c := ColorToRGB(FColorGlow);
  GlowColor.R := Byte(c);
  GlowColor.G := Byte(c shr 8);
  GlowColor.B := Byte(c shr 16);
  Invalidate;
end;

procedure TGlowLabel.SetShadowStyle(const Value: TShadowStyle);
begin
  FShadowStyle := Value;
  Invalidate;
end;

procedure TGlowLabel.InitPos;
begin
  TextX := 0;
  TextY := (ClientHeight - FBmp.Canvas.TextExtent(FCaption).cy) shr 1;
end;

constructor TGlowLabel.Create(AOwner: TComponent);
begin
  inherited;
  Color := clWhite;
  ColorShadow:= clBlack;
  ControlStyle := [csClickEvents, csCaptureMouse, csSetCaption];
  if AOwner is TWinControl then
    Parent := TWinControl(AOwner);
  FBmp := TBitmap.Create;
  FBmp.PixelFormat := pf24Bit;
  FBlurLevel := 1;
  FFont := TFont.Create;
  FFont.Name := 'Tahoma';
  FFont.Color := clBlack;
  FFont.Size := 8;
  FEnabled := True;
  FShadowStyle := ssGlow;
  Height := 27;
  ParentFont := False;
  Width := 57;
  Caption := 'Glass';
end;

destructor TGlowLabel.Destroy;
begin
  FBmp.Free;
  FFont.Free;
  inherited Destroy;
end;

procedure TGlowLabel.CMMouseEnter(var Msg: TMessage);
begin
  Invalidate;
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
  inherited;
end;

procedure TGlowLabel.CMMouseLeave(var Msg: TMessage);
begin
  Invalidate;
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
  inherited;
end;

procedure TGlowLabel.Resize;
begin
  Invalidate;
end;
{$IF Defined(USEREGION)} {$ENDREGION} {$IFEND}

end.

