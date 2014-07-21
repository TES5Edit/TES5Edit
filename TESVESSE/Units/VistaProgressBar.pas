unit VistaProgressBar;

// © 2011 by Roy Magne Klever. All rights reserved
// WEB: www.rmklever.com
// Mail: roymagne@rmklever.com

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TVistaProgressBar = class(TGraphicControl)
  private
    FAltMode: boolean;
    FShowPosition: boolean;
    FShowPercent: boolean;
    FPosition: integer;
    FMax: integer;
    FMin: integer;
    procedure SetMax(const Value: integer);
    procedure SetMin(const Value: integer);
    procedure SetShowPercent(const Value: boolean);
    procedure SetPosition(const Value: integer);
    procedure SetShowPosition(const Value: boolean);
    procedure CMFontChanged(var Message: TMessage); message CM_FontChanged;
    procedure SetAltMode(const Value: boolean);
  protected
    procedure Paint; override;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddPosition(APos: integer);
    procedure Draw(Canvas: TCanvas; Pos, Max: integer);
  published
    property Anchors;
    property Max: integer read FMax write SetMax default 100;
    property Min: integer read FMin write SetMin default 0;
    property AltMode: boolean read FAltMode write SetAltMode;
    property ShowPercent: boolean read FShowPercent write SetShowPercent;
    property Position: integer read FPosition write SetPosition;
    property ShowPosition: boolean read FShowPosition write SetShowPosition;
    property Color;
    property Align;
    property Font;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

implementation

function Blend(Color1, Color2: TColor; Value: Byte): TColor;
var
  i: LongInt;
  r1, g1, b1, r2, g2, b2: byte;
begin
  Value := Round(2.56 * Value);
  i := ColorToRGB(Color2);
  R1 := Byte(i);
  G1 := Byte(i shr 8);
  B1 := Byte(i shr 16);
  i := ColorToRGB(Color1);
  R2 := Byte(i);
  G2 := Byte(i shr 8);
  B2 := Byte(i shr 16);
  R1 := (Value * (R2 - R1)) shr 8 + R1;
  G1 := (Value * (G2 - G1)) shr 8 + G1;
  B1 := (Value * (B2 - B1)) shr 8 + B1;
  Result := (B1 shl 16) + (G1 shl 8) + R1;
end;

procedure SmoothGradient(Canvas: TCanvas; const ARect: TRect; const c1: TColor; const Gray: Boolean);
type
  PRGB = ^TRGB;
  TRGB = record
           b, g, r: Byte;
         end;
  PRGBArray = ^TRGBArray;
  TRGBARRAY = array[0..0] of TRGB;
var
  rc1, gc1, bc1, rc2, gc2, bc2, rc3, gc3, bc3, rc4, gc4, bc4: Integer;
  x, y, w, h: Integer;
  i, w1, w2, h1, sp, sm: Integer;
  Row: PRGBArray;
  C: TRGB;
  slMain, slSize, slPtr: Integer;
  Color, tc: Integer;
  Profil: array of TRGB;
  r, g, b: Byte;
  bmp: TBitmap;
begin
  if ((ARect.Right - ARect.Left) - 1 <= 0) or ((ARect.Bottom - ARect.Top) - 1 <= 1) then
    exit;
  bmp := TBitmap.Create;
  bmp.PixelFormat := pf24Bit;
  bmp.Width := (ARect.Right - ARect.Left) - 1;
  bmp.Height := (ARect.Bottom - ARect.Top) - 1;
  h := bmp.Height;
  w := bmp.Width;
  SetLength(Profil, h);
  // Get colors for first gradient
  Color := ColorToRGB(c1);
  if Gray then
  begin
    rc1 := 253;
    gc1 := 253;
    bc1 := 253;
    rc2 := 218;
    gc2 := 218;
    bc2 := 218;
    rc3 := 160;
    gc3 := 160;
    bc3 := 160;
    rc4 := 213;
    gc4 := 213;
    bc4 := 213;
  end
  else
  begin
    tc := Blend(Color, clWhite, 5);
    rc1 := Byte(tc);
    gc1 := Byte(tc shr 8);
    bc1 := Byte(tc shr 16);
    tc := Blend(Color, clWhite, 50);
    rc2 := Byte(tc);
    gc2 := Byte(tc shr 8);
    bc2 := Byte(tc shr 16);
    tc := Blend(Color, clBlack, 60);
    rc3 := Byte(tc);
    gc3 := Byte(tc shr 8);
    bc3 := Byte(tc shr 16);
    tc := Blend(Color, clBlack, 80);
    rc4 := Byte(tc);
    gc4 := Byte(tc shr 8);
    bc4 := Byte(tc shr 16);
  end;
  // Calc first gradient
  sp := Trunc(h / 2.5);
  y := sp;
  for i := 0 to y - 1 do
  begin
    C.r := Byte(rc1 + (((rc2 - rc1) * (i)) div y));
    C.g := Byte(gc1 + (((gc2 - gc1) * (i)) div y));
    C.b := Byte(bc1 + (((bc2 - bc1) * (i)) div y));
    Profil[i] := C;
  end;
  for i := y to h - 1 do
  begin
    C.r := Byte(rc3 + (((rc4 - rc3) * (i)) div h));
    C.g := Byte(gc3 + (((gc4 - gc3) * (i)) div h));
    C.b := Byte(bc3 + (((bc4 - bc3) * (i)) div h));
    Profil[i] := C;
  end;
  // First gradient done
  if Gray then
  begin
    rc1 := 200;
    gc1 := 200;
    bc1 := 200;
    rc2 := 253;
    gc2 := 253;
    bc2 := 253;
  end
  else
  begin
    tc := Blend(Color, clBlack, 50);
    rc1 := Byte(tc);
    gc1 := Byte(tc shr 8);
    bc1 := Byte(tc shr 16);
    tc := Blend(Color, clWhite, 50);
    rc2 := Byte(tc);
    gc2 := Byte(tc shr 8);
    bc2 := Byte(tc shr 16);
  end;
  w1 := w - 1;
  w := (w shr 1) + (w and 1);
  // Init scanline accsess
  slMain := Integer(bmp.ScanLine[0]);
  slSize := Integer(bmp.ScanLine[1]) - slMain;
  // Paint gradient
  h1 := h shr 1;
  w2 := 25;
  for x := 0 to w - 1 do
  begin
    if x < w2 then
    begin
      C.b := Byte(bc1 + (((bc2 - bc1) * x) div w2));
      C.g := Byte(gc1 + (((gc2 - gc1) * x) div w2));
      C.r := Byte(rc1 + (((rc2 - rc1) * x) div w2));
    end
    else
    begin
      C.b := bc2;
      C.g := gc2;
      C.r := rc2;
    end;
    slPtr := slMain;
    for y := 0 to h - 1 do
    begin
      Row := PRGBArray(slPtr);
      r := Profil[y].r;
      g := Profil[y].g;
      b := Profil[y].b;
      if x = 0 then
        sm := 3
      else
        sm := 2;
      if (x = 0) or ((y < sp) or (y = h - 1)) then
      begin
        Row[x].r := (C.r - r) shr sm + r;
        Row[x].g := (C.g - g) shr sm + g;
        Row[x].b := (C.b - b) shr sm + b;
      end
      else
      begin
        Row[x].r := (C.r - r) shr 1 + r;
        Row[x].g := (C.g - g) shr 1 + g;
        Row[x].b := (C.b - b) shr 1 + b;
      end;
      if (x < (w1 - x)) then
      begin
        Row[w1 - x].r := Row[x].r;
        Row[w1 - x].g := Row[x].g;
        Row[w1 - x].b := Row[x].b;
      end;
      slPtr := slPtr + slSize;
    end;
  end;
  Profil := nil;
  Canvas.Draw(ARect.Left, Arect.Top, bmp);
  FreeAndNil(bmp);
end;

procedure TVistaProgressBar.AddPosition(APos: integer);
begin
  Position := Position + APos;
end;

procedure TVistaProgressBar.CMFontChanged(var Message: TMessage);
begin
  Invalidate;
end;

constructor TVistaProgressBar.Create(AOwner: TComponent);
begin
  inherited;
  Width:= 150;
  Height:= 17;
  Color:= clLime;
  fPosition := 0;
  fMin := 0;
  fMax := 100;
  fShowPercent := False;
end;

destructor TVistaProgressBar.Destroy;
begin
  inherited;
end;

procedure TVistaProgressBar.Draw(Canvas: TCanvas; Pos, Max: integer);
var
  R: TRect;
  Len: integer;
  Percent: Extended;
  ACap: string;
  TempBmp: TBitmap;
  c: TColor;
  ts: TSize;
begin
  if (Width <= 0) or (Height <= 0) then
    Exit;
  TempBmp := TBitmap.Create;
  TempBmp.PixelFormat := pf24bit;
  if TempBmp.Width <> Width then
    TempBmp.Width := Width;
  if TempBmp.Height <> Height then
    TempBmp.Height := Height;
  c := Blend(clWhite, clSilver, 50);
  TempBmp.Canvas.Brush.Style := bsSolid;
  TempBmp.Canvas.Pen.Color := $00A0A0A0;
  R:= Rect(0, 0, TempBmp.Width, TempBmp.Height);
  TempBmp.Canvas.Rectangle(R);
  TempBmp.Canvas.Pen.Color := clSilver;
  TempBmp.Canvas.MoveTo(1, 0);
  TempBmp.Canvas.LineTo(R.Right - 1, R.Top);
  TempBmp.Canvas.Pixels[R.Left, R.Top] := c;
  TempBmp.Canvas.Pixels[R.Left, R.Bottom - 1] := c;
  TempBmp.Canvas.Pixels[R.Right - 1, R.Top] := c;
  TempBmp.Canvas.Pixels[R.Right - 1, R.Bottom - 1] := c;
  R.Left := 1;
  R.Top := 1;
  if not FAltMode then
    SmoothGradient(TempBmp.Canvas, R, Color, True);
  Len := FMax - FMin;
  if FMax = FMin then
    Percent := 0
  else
    Percent := (fPosition - FMin) / Len;
  R.Right := Round(Width * Percent);
  if R.Right > 0 then
    SmoothGradient(TempBmp.Canvas, r, Color, False);
  if FShowPercent then
    ACap := IntToStr(Round(Percent * 100)) + '%'
  else
    ACap := IntToStr(FPosition);
  TempBmp.Canvas.Font := Font;
  if FShowPosition then
  begin
    TempBmp.Canvas.Brush.Style := bsClear;
    ts:= TempBmp.Canvas.TextExtent(ACap);
    TempBmp.Canvas.TextOut((Width - ts.cx) div 2, (Height - ts.cy) div 2, ACap);
  end;
  TempBmp.Canvas.Brush.Style := bsSolid;
  Canvas.CopyMode := cmSrcCopy;
  Canvas.Draw(0, 0, TempBmp);
  FreeAndNil(TempBmp);
end;

procedure TVistaProgressBar.Paint;
begin
  Draw(Canvas, FPosition, FMax);
end;

procedure TVistaProgressBar.Resize;
begin
  inherited;
end;

procedure TVistaProgressBar.SetAltMode(const Value: boolean);
begin
  FAltMode := Value;
  Invalidate;
end;

procedure TVistaProgressBar.SetMax(const Value: integer);
begin
  if FMax = Value then
    Exit;
  FMax := Value;
  Paint;
end;

procedure TVistaProgressBar.SetMin(const Value: integer);
begin
  if FMin = Value then
    Exit;
  FMin := Value;
  Paint;
end;

procedure TVistaProgressBar.SetShowPercent(const Value: boolean);
begin
  if FShowPercent = Value then
    Exit;
  FShowPercent := Value;
  Paint;
end;

procedure TVistaProgressBar.SetPosition(const Value: integer);
begin
  if FPosition = Value then
    Exit;
  if Value > FMax then
    FPosition := FMax
  else
    if Value < FMin then
      FPosition := FMin
    else
      FPosition := Value;
  Paint;
end;

procedure TVistaProgressBar.SetShowPosition(const Value: boolean);
begin
  if FShowPosition = Value then
    Exit;
  FShowPosition := Value;
  Paint;
end;

end.

