{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit Colors;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Dialogs, Math, Controls, Forms;

const
  HashNum = 510511; // buckets for hashing colors
  MAXCOL = 1000; // base colors for palettes

type
  PRGBArray = ^TRGBArray;

  TRGBArray = array [0..maxint div 4] of TRGBTriple;

  TColDistribution = ( cdDirect, cdLogarithmic, cdSquareRoot, cdSquare, cdSine, cdCosine, cdCube, cdCubeRoot, cdCircular, cdArcSin, cdExponential );

  TColApplication = ( caLinear, caRepeated, ca2Times, ca3Times, ca4Times, ca8Times, ca16Times, ca32Times, ca64Times );

  TColMethod = ( cmHSL, cmHSV, cmRGB );

  TColorize = class
    private
      FHashIter: array[ 0 .. HashNum ] of extended;
      FHashCol: array[ 0 .. HashNum ] of TRGBTriple;
      FOrigColors: array[ 0 .. MAXCOL ] of TColor;
      FDestColors: array[ 0 .. MAXCOL ] of TColor;
      FColorsNumber: integer; // colors assigned
      FMaxIter: integer;
      FApplication: TColApplication;
      FDistribution: TColDistribution;
      FMethod: TColMethod;
      FLastColor: Tcolor;
      FPrevIter : extended;
      FprevResult : TRGBTriple;
      FOffset: Extended;
      FRecMaxCol: Extended;
      FFileName: string;
      procedure SetApplication(const Value: string);
      procedure SetDistribution(const Value: string);
      procedure SetMaxIter( const Value: integer );
      function GetOrigColors(NumCol: integer): TColor;
      procedure SetOrigColors(NumCol: integer; const Value: TColor);
      function GetDestColors(NumCol: integer): TColor;
      procedure SetDestColors(NumCol: integer; const Value: TColor);
      function GetDistribution: String;
      function GetApplication: string;
      function GetMethod: string;
      procedure SetMethod(const Value: string);
      procedure SetLastColor(const Value: Tcolor);
      procedure SetOffset(const Value: Extended);
      procedure ClearHashes;
    public
      DefaultPath: string;
      constructor Create( AMaxIter: integer );
      function FromIterToColor( Iter: Extended ): TRGBTriple;
      procedure AddColor(Orig, Dest: TColor);
      procedure InsertColor( Orig, Dest: TColor; NumCol: integer = -1 ); // -1 to Append to last
      procedure RemoveColor( NumCol: integer );
      function  LoadFromFile(const AFileName: string; verbose: boolean ): boolean;
      function  SaveToFile(const AFileName: string; Verbose: boolean ): boolean;
      function  ImportMap(const AFileName: string; verbose: boolean ): boolean;

      property OrigColors[ NumCol: integer ] :TColor read GetOrigColors write SetOrigColors;
      property DestColors[ NumCol: integer ] :TColor read GetDestColors write SetDestColors;
      property ColorsNumber: integer read FColorsNumber; // colors assigned
      property LastColor: Tcolor read FLastColor write SetLastColor;
      property Offset: Extended read FOffset write SetOffset;
      property FileName: string read FFileName;

      property MaxIter: integer read FMaxIter write SetMaxIter;
      property ApplyTo: string read GetApplication write SetApplication;
      property Distribution: String read GetDistribution write SetDistribution;
      property Method: string read GetMethod write SetMethod;
      property OrdMethod: TColMethod read FMethod; 
    end;



  
function ColToRGBTriple(ACol: TColor): TRGBTriple;
function RGBTripleToCol( ACol: TRGBTriple ): TColor;
function FindGradientColorRGB(StartCol, EndCol: TRGBTriple; Pos: extended): TRGBTriple;
function FindGradientColorHSL(StartCol, EndCol: TRGBTriple; Pos: extended): TRGBTriple;
function FindGradientColorHSV(StartCol, EndCol: TRGBTriple; Pos: extended): TRGBTriple;
procedure RGBtoHSL(rgb : TRGBTriple; var H, S, L : extended);
procedure HSLtoRGB(H, S, L : extended; var rgb : TRGBTriple);
procedure HSVtoRGB(H, S, V : extended; var rgb : TRGBTriple);
procedure RGBtoHSV(rgb : TRGBTriple; var H, S, V : extended);
procedure SwitchRB(var rgb : TRGBTriple);

function Lighter(Color: TColor; Amount: Double = 0.5): TColor;
function Darker(Color: TColor; Amount: Double = 0.5): TColor;


implementation

{$IFNDEF VER220}
uses
  UITypes;
{$ENDIF VER220}

function RGBTripleToCol( ACol: TRGBTriple ): TColor;
  begin
	result := ACol.rgbtRed * 65536;
	result := Result + ACol.rgbtGreen * 256;
	result := Result + ACol.rgbtBlue;
  end;

function ColToRGBTriple(ACol: TColor): TRGBTriple;
  begin
	ACol := ColorToRGB(Acol);
	result.rgbtRed := (ACol shr 16) and $000000FF;
	result.rgbtGreen := (ACol shr 8) and $000000FF;
	result.rgbtBlue := ACol and $000000FF;
  end;
{
  asm
  mov EAX, Acol
  mov [ EDX ], EAX
  end;
}

function FindGradientColorRGB(StartCol, EndCol: TRGBTriple; Pos: extended): TRGBTriple;
  begin
	Result.rgbtRed := round( ((StartCol.rgbtRed * ( 1.0 - pos ) ) + ( EndCol.rgbtRed * pos ) ) );
	Result.rgbtGreen := round( ( (StartCol.rgbtGreen * ( 1.0 - pos ) ) + (EndCol.rgbtGreen * pos) ) );
  Result.rgbtBlue := round( ( (StartCol.rgbtBlue * ( 1.0 - pos ) ) + (EndCol.rgbtBlue * pos) ) );
  end;

function FindGradientColorHSL(StartCol, EndCol: TRGBTriple; Pos: extended): TRGBTriple;
var
	posH, posS, posL, startH, startS, startL, endH, endS, endL : extended;
begin
	RGBtoHSL(StartCol, startH, startS, startL);
	RGBtoHSL(endCol, endH, endS, endL);

	if (endH - startH) > 0.5 then
		startH := startH + 1;
	if (endH - startH) < -0.5 then
		endH := endH + 1;

	posH := (StartH * (1.0 - pos)) + (EndH * pos);
	posS := (StartS * (1.0 - pos)) + (EndS * pos);
	posL := (StartL * (1.0 - pos)) + (EndL * pos);

	if PosH > 1 then posH := posH - 1;

	HSLtoRGB(posH, posS, posL, result);
end;


function FindGradientColorHSV(StartCol, EndCol: TRGBTriple; Pos: extended): TRGBTriple;
var
	posH, posS, posV, startH, startS, startV, endH, endS, endV : extended;
begin
	RGBtoHSV(StartCol, startH, startS, startV);
	RGBtoHSV(endCol, endH, endS, endV);

	if (endH - startH) > 0.5 then
		startH := startH + 1;
	if (endH - startH) < -0.5 then
		endH := endH + 1;

	posH := (StartH * (1.0 - pos)) + (EndH * pos);
	posS := (StartS * (1.0 - pos)) + (EndS * pos);
	posV := (StartV * (1.0 - pos)) + (EndV * pos);

	if PosH > 1 then posH := posH - 1;

	HSVtoRGB(posH, posS, posV, result);


  end;

procedure RGBtoHSL(rgb : TRGBTriple; var H, S, L : extended);
var
	delta, r, g, b, cmax, cmin: extended;
begin
	r := rgb.rgbtRed / 255;
	g := rgb.rgbtGreen / 255;
	b := rgb.rgbtBlue / 255;
	if (r > b) and (r > g) then
		cmax := r
	else if g > b then
		cmax := g
	else
		cmax := b;
	if (r < b) and (r < g) then
		cmin := r
	else if g < b then
		cmin := g
	else
		cmin := b;
	L := (cmax+cmin) / 2.0;

	if cmax=cmin then
		begin
		S := 0;
		H := 0; //sarebbe indefinita
		end
	else
		begin
		delta := cmax - cmin;
		if L <= 0.5 then
			s := delta / (cmax + cmin)
		else
			s := delta / (2.0 - cmax - cmin);
		if r = cmax then
			H := (g - b) / delta
		else if g = cmax then
			H := 2.0 + (b - r) / delta
		else
			H := 4.0 + (r - g) / delta;
		H := H / 6.0;
		if H < 0 then
			H := H + 1;
		end;
	{
	showMessage('R: '+inttostr(rgb.rgbtRed)+ #13 +
							'G: '+inttostr(rgb.rgbtGreen)+ #13 +
							'B: '+inttostr(rgb.rgbtBlue)+ #13 +
							'H: '+floattostr(H)+ #13 +
							'S: '+floattostr(S)+ #13 +
							'L: '+floattostr(L));
	}
end;

procedure HSLtoRGB(H, S, L : extended; var rgb : TRGBTriple);
var
	r, g, b, m1, m2 : double;

	function HuetoRGB(m1,m2, h: double): double;
		begin
		if h < 0 then
			h := h + 1.0
		else if h > 1 then
			h := h - 1.0;
		if 6.0*h < 1 then
			result := (m1+(m2-m1)*h*6.0)
		else if 2.0*h < 1 then
			result := m2
		else if 3.0*h < 2.0 then
			result := (m1+(m2-m1)*((2.0/3.0)-h)*6.0)
		else
			result := m1;
		end;

begin
	if S = 0 then
		begin
		r := L;
		g := L;
		b := L;
		end
	else
		begin
		if L <= 0.5 then
			m2 := L*(1.0+S)
		else
			m2 := L+S-L*S;
		m1 := 2.0*L-m2;
		r := HuetoRGB(m1,m2,H+1.0/3.0);
		g := HuetoRGB(m1,m2,H);
		b := HuetoRGB(m1,m2,H-1.0/3.0);
		end;
	rgb.rgbtBlue := round(b * 255);
	rgb.rgbtGreen := round(g * 255);
	rgb.rgbtRed := round(r * 255);
	{ showMessage('H: '+floattostr(H)+ #13 +
	'S: '+floattostr(S)+ #13 +
	'L: '+floattostr(L)+ #13 +
	'R: '+inttostr(rgb.rgbtRed)+ #13 +
	'G: '+inttostr(rgb.rgbtGreen)+ #13 +
	'B: '+inttostr(rgb.rgbtBlue));
	}

end;

procedure RGBtoHSV(rgb : TRGBTriple; var H, S, V : extended);
var
	delta, r, g, b, cmax, cmin: double;
begin
	r := rgb.rgbtRed / 255;
	g := rgb.rgbtGreen / 255;
	b := rgb.rgbtBlue / 255;
	if (r > b) and (r > g) then
		cmax := r
	else if g > b then
		cmax := g
	else
		cmax := b;

	if (r < b) and (r < g) then
		cmin := r
	else if g < b then
		cmin := g
	else
		cmin := b;

	if cmax = 0 then
		begin
		H := 0;
		S := 0;
		V := 0;
		exit;
		end;

	delta := cmax - cmin;
	S := delta / cmax;
	V := cmax;

  if delta = 0 then
    begin
    H := 0; //sarebbe indefinito
    exit;
    end;

	if r = cmax then
		H := (g - b) / delta
	else if g = cmax then
		H := 2 + (b - r) / delta
	else
		H := 4 + (r - g) / delta;

	H := H / 6;

	if H < 0 then
		H := H + 1;
	if H >=1 then
		showMessage('H>=1');

end;

procedure HSVtoRGB(H, S, V : extended; var rgb : TRGBTriple);
var
	r, g, b, f, p, q : double;
	i : integer;
begin
	if S = 0 then
		begin
		r := V;
		g := V;
		b := V;
		end
	else
		begin
		if h=1 then
			h :=0
		else
			h := h * 6;
		i := trunc(h);
		if odd(i) then
			f := h - i
		else
			f := (i + 1) - h ;
		p := v *(1 - s);
		q := v *(1 - s * f);
		case i of
			0:begin
				r := v;
				g := q;
				b := p;
				end;
			1:begin
				r := q;
				g := v;
				b := p;
				end;
			2:begin
				r := p;
				g := v;
				b := q;
				end;
			3:begin
				r := p;
				g := q;
				b := v;
				end;
			4:begin
				r := q;
				g := p;
				b := v;
				end;
			else //5
				begin
				r := v;
				g := p;
				b := q;
				end;
			end;
		end;

	rgb.rgbtBlue := round(b * 255);
	rgb.rgbtGreen :=  round(g * 255);
	rgb.rgbtRed := round(r * 255);

  end;

procedure SwitchRB(var rgb : TRGBTriple);
var
	bt : byte;
begin
	bt := rgb.rgbtBlue;
	rgb.rgbtBlue := rgb.rgbtRed;
	rgb.rgbtRed := bt;
end;

{ TColorize }

procedure TColorize.AddColor(Orig, Dest: TColor);
  begin
  if ColorsNumber - 1 < high( FOrigColors ) * 2 then
    inc( FColorsNumber );
  FOrigColors[ ColorsNumber - 1 ] := Orig;
  FDestColors[ ColorsNumber - 1 ] := Dest;
  ClearHashes;
  end;

procedure TColorize.ClearHashes;
  var
    k: integer;
  begin
  FprevIter := -1;
  for k := 0 to HashNum do
    FHashIter[ k ] := -1;
  end;

constructor TColorize.Create( AMaxIter: integer );
  begin
  FColorsNumber := 0;
  Fapplication := caLinear;
  FDistribution := cdDirect;
  MaxIter := AMaxIter;
  FMethod := cmHSL;
  FLastColor := clBlack;
  FOffset := 0;
  AddColor( clWhite, clBlack ); //default
  end;

function TColorize.FromIterToColor(Iter: Extended): TRGBTriple;
  var
  	SCol, ECol : TRGBTriple;
    hhitern, NumCol: integer;
    iternorm: Extended;
    HashVal: Extended;
  begin
  if Iter = FprevIter then
    begin
    Result := FprevResult;
    exit;
    end;
  if ( FColorsNumber < 1 ) or ( FMaxIter < 1 ) then
    exit;

  if Iter >= MaxIter then
    begin
    Iter := MaxIter;
    iternorm := 1; //no offset for the last color
    hhitern := HashNum;
    end
  else // FRecMaxCol = 1/MaxIter
    begin
    iternorm := frac( iter * FRecMaxCol + foffset );
    hhitern := trunc( iternorm * HashNum );
//slower!    hhitern := trunc(iternorm * 4000000000) mod HashNum;
    end;

  HashVal := FHashIter[ hhitern ];
  if ( HashVal > 0 ) and ( abs(HashVal - iternorm) < 2E-16) then
    begin //check if hash bucket has current value
    Result := FHashCol[ hhitern ];
    exit;
    end
  else
    begin
//only for debug
{   if HashVal > 0 then
      OutputDebugString(pchar('fail ' + inttostr(hhitern)
        + '  ' + floattostr( abs(HashVal - iternorm))));
}
    FHashIter[ hhitern ] := iternorm;
    end;

  if Iter >= MaxIter then
    begin
    Result := ColToRGBTriple( LastColor );
    end
  else
    begin
    case FDistribution of
      cdLogarithmic:
        iternorm := log10( iternorm * 9 + 1 );
      cdExponential:
        iternorm := Power( 10, iternorm ) / 10;
      cdSquareRoot:
        iternorm := sqrt( iternorm );
      cdSquare:
        iternorm := ( iternorm * iternorm );
      cdCube:
        iternorm := ( iternorm * iternorm * iternorm );
      cdCubeRoot:
        iternorm := exp( ln( iternorm ) / 3 );
      cdSine:
        iternorm := sin( iternorm * ( pi / 2 ) );
      cdCosine:
        iternorm := 1 - cos( iternorm * ( pi / 2 ) );
      cdCircular:
        iternorm := 1 - ( cos( iternorm * 2 * pi ) / 2 + 0.5 );
      cdArcSin:
        iternorm := ( arcsin( iternorm * 2 - 1 ) ) / pi + 0.5;
      else //direct
        // nothing to do
      end;

    case FApplication of
      caRepeated:
        begin
        NumCol := trunc( iter ) mod FColorsNumber;
        end;
      ca2Times:
        begin
        iternorm := frac( iternorm * 2 );
        iternorm := iternorm * FColorsNumber;
        NumCol := trunc( iternorm );
        iternorm := iternorm - NumCol;
        end;
      ca3Times:
        begin
        iternorm := frac( iternorm * 3 );
        iternorm := iternorm * FColorsNumber;
        NumCol := trunc( iternorm );
        iternorm := iternorm - NumCol;
        end;
      ca4Times:
        begin
        iternorm := frac( iternorm * 4 );
        iternorm := iternorm * FColorsNumber;
        NumCol := trunc( iternorm );
        iternorm := iternorm - NumCol;
        end;
      ca8Times:
        begin
        iternorm := frac( iternorm * 8 );
        iternorm := iternorm * FColorsNumber;
        NumCol := trunc( iternorm );
        iternorm := iternorm - NumCol;
        end;
      ca16Times:
        begin
        iternorm := frac( iternorm * 16 );
        iternorm := iternorm * FColorsNumber;
        NumCol := trunc( iternorm );
        iternorm := iternorm - NumCol;
        end;
      ca32Times:
        begin
        iternorm := frac( iternorm * 32 );
        iternorm := iternorm * FColorsNumber;
        NumCol := trunc( iternorm );
        iternorm := iternorm - NumCol;
        end;
      ca64Times:
        begin
        iternorm := frac( iternorm * 64 );
        iternorm := iternorm * FColorsNumber;
        NumCol := trunc( iternorm );
        iternorm := iternorm - NumCol;
        end
      else
        begin
        iternorm := iternorm * FColorsNumber;
        NumCol := trunc( iternorm );
        iternorm := iternorm - NumCol;
        end;
      end;
    SCol := ColToRGBTriple( OrigColors[ NumCol ] );
    ECol := ColToRGBTriple( DestColors[ NumCol ] );

    case FMethod of
      cmRGB:
        result := FindGradientColorRGB( SCol, ECol, iternorm );
      cmHSV:
        result := FindGradientColorHSV( SCol, ECol, iternorm );
      else
        result := FindGradientColorHSL( SCol, ECol, iternorm );
      end;
    end;

  Fpreviter := iter;
  Fprevresult := Result;
  FHashCol[ hhitern ] := Result;
  end;

function TColorize.GetApplication: string;
  begin
  case FApplication of
    caRepeated:
      Result := 'Repeated';
    ca2Times:
      Result := '2Times';
    ca3Times:
      Result := '3Times';
    ca4Times:
      Result := '4Times';
    ca8Times:
      Result := '8Times';
    ca16Times:
      Result := '16Times';
    ca32Times:
      Result := '32Times';
    ca64Times:
      Result := '64Times';
    else
      Result := 'Linear';
    end;
  end;

function TColorize.GetDestColors(NumCol: integer): TColor;
  begin
  Result := FDestColors[ NumCol ];
  end;

function TColorize.GetDistribution: String;
  begin
  case FDistribution of
    cdLogarithmic:
      Result := 'Logarithmic';
    cdSquareRoot:
      Result := 'SquareRoot';
    cdSquare:
      Result := 'Square';
    cdSine:
      Result := 'Sine';
    cdCosine:
      Result := 'Cosine';
    cdCube:
      Result := 'Cube';
    cdCubeRoot:
      Result := 'CubeRoot';
    cdCircular:
      Result := 'Circular';
    cdArcSin:
      Result := 'ArcSin';
    cdExponential:
      Result := 'Exponential';
    else
      Result := 'Direct';
    end;
  end;

function TColorize.GetMethod: string;
  begin
  case FMethod of
    cmHSV:
      Result := 'HSV';
    cmRGB:
      Result := 'RGB';
    else
      Result := 'HSL';
    end;
  end;

function TColorize.GetOrigColors(NumCol: integer): TColor;
  begin
  Result := FOrigColors[ NumCol ];
  end;


function TColorize.ImportMap(const AFileName: string; verbose: boolean): boolean;
  var
    sl: TStringList;
    k: integer;
    ro, go, bo: Byte;
    s: string;

  function GetValues( astring: string; var r, g, b: Byte ): boolean;
    var
      sr, sg, sb, eb, i: integer;
      s: string;
      inum : boolean;
    begin
    Result := false;
    sr := -1;
    sg := -1;
    sb := -1;
    eb := -1;
    i := 0;
    inum := false;
    while true do
      begin
      inc( i );
      if i > Length( astring ) then
        Break;
      if astring[ i ] = ' ' then
        begin
        inum := False;
        Continue;
        end
      else if inum then
        Continue;
      inum := true;
      if sr = -1 then
        sr := i
      else if sg = -1 then
        sg := i
      else if sb = -1 then
        sb := i
      else if eb = -1 then
        eb := i
      else
        break;
      end;
    if sb > -1 then // found right values
      begin
      if eb = -1 then
        eb := i;
      s := Trim( Copy( astring, sr, sg - sr ) );
      b := StrToIntDef( s, 0 ) mod 256;
      s := Trim( Copy( astring, sg, sb - sg ) );
      g := StrToIntDef( s, 0 ) mod 256;
      s := Trim( Copy( astring, sb, eb - sb ) );
      r := StrToIntDef( s, 0 ) mod 256;
      Result := True;
      end;
    end;

  begin
  Result := false;
  if not FileExists( AFileName ) then
    begin
    if verbose then
      ShowMessage( 'Error: ' + AFileName + ' not found !' );
    exit;
    end;
  sl := TStringList.Create;
    try
    sl.LoadFromFile( AFileName );

    k := sl.count;
    if k < 3 then
      exit;

    FColorsNumber := 0;
    s := sl[ 0 ];
    if not GetValues( s, ro, go, bo ) then
      begin
      ro := 0;
      go := 0;
      bo := 0;
      end;
    LastColor := ro * 65536 + go *256 + bo;
    for k := 1 to sl.count - 1 do
      begin
//    'RRR GGG BBB'
      s := sl[ k ];
      if GetValues( s, ro, go, bo ) then
        begin
        FOrigColors[ FColorsNumber ] := ro * 65536 + go *256 + bo;
        if FColorsNumber > 0 then
          FDestColors[ FColorsNumber - 1 ] := FOrigColors[ FColorsNumber ];
        inc( FColorsNumber );
        if FColorsNumber > MAXCOL then
          break;
        end;
      end;
    if FColorsNumber > 0 then
      begin
      dec( FColorsNumber );
      end;

    ApplyTo := 'Linear';
    Distribution := 'Direct';
    Method := 'RGB';
    Result := True;
    finally
    sl.Free;
    end;
  end;

procedure TColorize.InsertColor(Orig, Dest: TColor; NumCol: integer);
  begin

  end;


function TColorize.LoadFromFile(const AFileName: string; verbose: boolean ): boolean;
  var
    sl: TStringList;
    k: integer;
    ro, go, bo, rd, gd, bd: Byte;
    s: string;
    path: string;
  begin
  Result := false;
  FFileName := ChangeFileExt( AFileName, '.mnc' );
  path := ExtractFilePath( FFileName );
  if path = '' then
    path := DefaultPath
  else
    path := ''; // FileName with path
  if not FileExists( path + FFileName ) then
    begin
    if verbose then
      ShowMessage( 'Error: ' + FFileName + ' not found !' );
    exit;
    end;
  FFileName := path + FFileName;
  sl := TStringList.Create;
    try
    sl.LoadFromFile( FFileName );

    if sl.count < 5 then
      exit;
    k := FColorsNumber;
    FColorsNumber := strtointdef( sl[ 4 ], 1 );
    if sl.count < ( FColorsNumber + 18 ) then
      begin
      FColorsNumber := k;
      exit;
      end;

    for k := 0 to FColorsNumber - 1 do
      begin
//    '| R | G | B |  | R | G | B |' 
      s := sl[ 9 + k ];
      bo := strtointdef( copy( s, 2, 3 ), 0 );
      go := strtointdef( copy( s, 6, 3 ), 0 );
      ro := strtointdef( copy( s, 10, 3 ), 0 );
      bd := strtointdef( copy( s, 17, 3 ), 0 );
      gd := strtointdef( copy( s, 21, 3 ), 0 );
      rd := strtointdef( copy( s, 25, 3 ), 0 );
      FOrigColors[ k ] := ro * 65536 + go *256 + bo;
      FDestColors[ k ] := rd * 65536 + gd *256 + bd;
      end;
    s := sl[ 10 + FColorsNumber];
    bo := strtointdef( copy( s, 2, 3 ), 0 );
    go := strtointdef( copy( s, 6, 3 ), 0 );
    ro := strtointdef( copy( s, 10, 3 ), 0 );
    LastColor := ro * 65536 + go *256 + bo;
    ApplyTo := sl[ 13 + FColorsNumber ];
    Distribution := sl[ 15 + FColorsNumber ];
    Method := sl[ 17 + FColorsNumber ];
    Result := true;
    finally
    sl.Free;
    end;
  end;

procedure TColorize.RemoveColor(NumCol: integer);
  begin
  if ColorsNumber > 1 then
    begin
    DestColors[ ColorsNumber - 1 ] := 0;
    OrigColors[ ColorsNumber - 1 ] := 0;
    dec( FColorsNumber );
    ClearHashes;
    end;
  end;


function TColorize.SaveToFile(const AFileName: string; Verbose: boolean ): boolean;
  var
    sl: TStringList;
    k: integer;
    ro, go, bo, rd, gd, bd: integer;
    path: string;
  begin
  Result := false;
  FFileName := ChangeFileExt( AFileName, '.mnc' );
  path := ExtractFilePath( FFileName );
  if path = '' then
    path := DefaultPath;

  if not DirectoryExists( path ) then
    if Verbose and ( MessageDlg('Create directory ' + path + ' ?', mtWarning, [mbYes, mbNo], 0) <> mrYes ) then
      exit
    else
      ForceDirectories( path );
  FFileName := path + ExtractFileName( FFileName );
  if FileExists( FFileName ) then
    begin
    if Verbose and ( MessageDlg('Do you wish to replace ' + FFileName + ' ?', mtWarning, [mbYes, mbNo], 0) <> mrYes ) then
      exit
    else
      DeleteFile( FFileName );
    end;
  sl := TStringList.Create;
    try
    sl.Add( Application.Title );
    sl.Add( 'By Uberto Barbini    uberto@usa.net' );
    sl.Add( '' );
    sl.Add( 'Number of colors:' );
    sl.Add( IntToStr( FColorsNumber ) );
    sl.Add( 'Colors:' );
    sl.Add( '+---+---+---+  +---+---+---+' );
    sl.Add( '| R | G | B |  | R | G | B |' );
    sl.Add( '+---+---+---+  +---+---+---+' );
    for k := 0 to FColorsNumber - 1 do
      begin
      bo := OrigColors[ k ] div 65536;
      go := OrigColors[ k ] mod 65536 div 256 ;
      ro := OrigColors[ k ] mod 256;
      bd := DestColors[ k ] div 65536;
      gd := DestColors[ k ] mod 65536 div 256 ;
      rd := DestColors[ k ] mod 256;
      sl.Add( Format( '|%3d|%3d|%3d|  |%3d|%3d|%3d|', [ ro, go, bo, rd, gd, bd ] ) );
      end;
    sl.Add( '+---+---+---+  +---+---+---+' );
    bd := LastColor div 65536;
    gd := LastColor mod 65536 div 256 ;
    rd := LastColor mod 256;
    sl.Add( Format( '|%3d|%3d|%3d|', [ rd, gd, bd ] ) );
    sl.Add( '+---+---+---+' );
    sl.Add( 'Application:' );
    sl.Add( ApplyTo );
    sl.Add( 'Distribution:' );
    sl.Add( Distribution );
    sl.Add( 'Method:' );
    sl.Add( Method );
    sl.SaveToFile( FFileName );
    Result := true;
    finally
    sl.Free;
    end;
  end;

procedure TColorize.SetApplication(const Value: string);
  begin
  ClearHashes;
  if CompareText( Value, 'Repeated' ) = 0 then
    FApplication := caRepeated
  else if CompareText( Value, '2Times' ) = 0 then
    FApplication := ca2Times
  else if CompareText( Value, '3Times' ) = 0 then
    FApplication := ca3Times
  else if CompareText( Value, '4Times' ) = 0 then
    FApplication := ca4Times
  else if CompareText( Value, '8Times' ) = 0 then
    FApplication := ca8Times
  else if CompareText( Value, '16Times' ) = 0 then
    FApplication := ca16Times
  else if CompareText( Value, '32Times' ) = 0 then
    FApplication := ca32Times
  else if CompareText( Value, '64Times' ) = 0 then
    FApplication := ca64Times
  else
    FApplication := caLinear;
  end;


procedure TColorize.SetDestColors(NumCol: integer; const Value: TColor);
  begin
  ClearHashes;
  if ( NumCol >= Low( FDestColors ) ) and ( NumCol <= High( FDestColors ) ) then
    FDestColors[ NumCol ] := ColorToRGB( Value );
  end;

procedure TColorize.SetDistribution(const Value: string );
  begin   // use CompareText 'cause it's case-insensitive
  ClearHashes;
  if CompareText( Value, 'Logarithmic' ) = 0 then
    FDistribution := cdLogarithmic
  else if CompareText( Value, 'SquareRoot' ) = 0 then
    FDistribution := cdSquareRoot
  else if CompareText( Value, 'Square' ) = 0 then
    FDistribution := cdSquare
  else if CompareText( Value, 'Sine' ) = 0 then
    FDistribution := cdSine
  else if CompareText( Value, 'Cosine' ) = 0 then
    FDistribution := cdCosine
  else if CompareText( Value, 'Cube' ) = 0 then
    FDistribution := cdCube
  else if CompareText( Value, 'CubeRoot' ) = 0 then
    FDistribution := cdCubeRoot
  else if CompareText( Value, 'Circular' ) = 0 then
    FDistribution := cdCircular
  else if CompareText( Value, 'ArcSin' ) = 0 then
    FDistribution := cdArcSin
  else if CompareText( Value, 'Exponential' ) = 0 then
    FDistribution := cdExponential
  else
    FDistribution := cdDirect;
  end;

procedure TColorize.SetLastColor(const Value: Tcolor);
  begin
  ClearHashes;
  FLastColor := ColorToRGB( Value );
  end;

procedure TColorize.SetMaxIter(const Value: integer);
  begin
  ClearHashes;
  FMaxIter := Value;
  if value > 0 then
    FRecMaxCol := 1 / Value
  else
    FRecMaxCol := 0
  end;

procedure TColorize.SetMethod(const Value: string);
  begin
  ClearHashes;
  if CompareText( Value, 'HSV' ) = 0 then
    FMethod := cmHSV
  else if CompareText( Value, 'RGB' ) = 0 then
    FMethod := cmRGB
  else
    FMethod := cmHSL;
  end;

procedure TColorize.SetOffset(const Value: Extended);
  begin
  if ( Value >= 0 ) and ( Value < 1 ) then
    FOffset := Value;
  end;

procedure TColorize.SetOrigColors(NumCol: integer; const Value: TColor);
  begin
  ClearHashes;
  if ( NumCol >= Low( FOrigColors ) ) and ( NumCol <= High( FOrigColors ) ) then
    FOrigColors[ NumCol ] := ColorToRGB( Value );
  end;

function Lighter(Color: TColor; Amount: Double = 0.5): TColor;
var
  h, s, l: Extended;
  rgb:TRGBTriple;
begin
  RGBtoHSL(ColToRGBTriple(Color), h, s, l);

  l := Min(l + (1.0 - l) * Amount, 1.0);

  HSLtoRGB(h, s, l, rgb);
  Result := RGBTripleToCol(rgb);
end;

function Darker(Color: TColor; Amount: Double = 0.5): TColor;
var
  h, s, l: Extended;
  rgb:TRGBTriple;
begin
  RGBtoHSL(ColToRGBTriple(Color), h, s, l);

  l := Max(l - l * Amount, 0.0);

  HSLtoRGB(h, s, l, rgb);
  Result := RGBTripleToCol(rgb);
end;



end.

