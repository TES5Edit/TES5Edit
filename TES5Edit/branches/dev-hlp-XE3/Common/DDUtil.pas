unit DDUtil;
{******************************************************************}
{                                                                  }
{       Borland Delphi DirectX 8 SDK Examples                      }
{       Conversion of the DDUtils Files                            }
{                                                                  }
{ Portions created by Microsoft are                                }
{ Copyright (C) 1995-2000 Microsoft Corporation.                   }
{ All Rights Reserved.                                             }
{                                                                  }
{ The original files are : DDUtil.h, DDUtil.cpp                    }
{ The original Pascal code is : DDUtil.pas                         }
{ The initial developer of the Pascal code is : Dominique Louis    }
{ ( Dominique@SavageSoftware.com.au )                              }
{                                                                  }
{ Portions created by Dominique Louis are                          }
{ Copyright (C) 2000 - 2001 Dominique Louis.                       }
{                                                                  }
{ Contributor(s)                                                   }
{ --------------                                                   }
{ <Contributer Name> ( contributer@sp.sw )                         }
{                                                                  }
{ Obtained through:                                                }
{ Joint Endeavour of Delphi Innovators ( Project JEDI )            }
{                                                                  }
{ You may retrieve the latest version of this file at the Project  }
{ JEDI home page, located at http://delphi-jedi.org                }
{                                                                  }
{ The contents of this file are used with permission, subject to   }
{ the Mozilla Public License Version 1.1 (the "License"); you may  }
{ not use this file except in compliance with the License. You may }
{ obtain a copy of the License at                                  }
{ http://www.mozilla.org/NPL/NPL-1_1Final.html                     }
{                                                                  }
{ Software distributed under the License is distributed on an      }
{ "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or   }
{ implied. See the License for the specific language governing     }
{ rights and limitations under the License.                        }
{                                                                  }
{ Description                                                      }
{ -----------                                                      }
{   Routines and class wrapper for loading bitmap and palettes     }
{   from files and resources.                                      }
{                                                                  }
{ Requires                                                         }
{ --------                                                         }
{   Eric Unger and Tim Baumgarten's conversions of the DirectX     }
{   headers. They are available from...                            }
{   http://delphi-jedi.org/DelphiGraphics/ .                       }
{                                                                  }
{ Programming Notes                                                }
{ -----------------                                                }
{                                                                  }
{                                                                  }
{ Revision History                                                 }
{ ----------------                                                 }
{   2000-12-01 - DL  Initial translation.                             }
{                                                                  }
{                                                                  }
{******************************************************************}
interface

uses
  Windows,
  DirectDraw;

const
  RAND_MAX = $7FFF;

type
  TRGBMode = ( rgbmNone, rgbm555, rgbm565, rgbm16, rgbm24, rgbm32 );

  TSurface = class; // Forward declaration
  //-----------------------------------------------------------------------------
  // Name: class TDisplay
  // Desc: Class to handle all DDraw aspects of a display, including creation of
  //       front and back buffers, creating offscreen surfaces and palettes,
  //       and blitting surface and displaying bitmaps.
  //-----------------------------------------------------------------------------
  TDisplay = class
  private
    m_bStereo : boolean;
    m_bWindowed : boolean;

    m_hWnd : HWND;

    m_pDD : IDIRECTDRAW7;
    m_pddsFrontBuffer : IDIRECTDRAWSURFACE7;
    m_pddsBackBuffer : IDIRECTDRAWSURFACE7;
    m_pddsBackBufferLeft : IDIRECTDRAWSURFACE7; // For stereo modes

    m_rcWindow : TRect;
    FHeight : Integer;
    FWidth : Integer;
  public
    constructor Create;
    destructor Destroy; override;

    // Access functions
    function GetBackBuffer : IDIRECTDRAWSURFACE7;
    function GetBackBufferLeft : IDIRECTDRAWSURFACE7;
    function GetDirectDraw : IDIRECTDRAW7;
    function GetHWnd : HWND;

    function GetFrontBuffer : IDIRECTDRAWSURFACE7;


    // Status functions
    function Stereo : Boolean;
    function Windowed : Boolean;


    // Creation/destruction methods
    function CreateFullScreenDisplay( h_Wnd : HWND; dwWidth, dwHeight, dwBPP : LongWord ) : HRESULT;
    function CreateWindowedDisplay( h_Wnd : HWND; dwWidth, dwHeight : LongWord ) : HRESULT;
    function DestroyObjects : HRESULT; virtual;
    function InitClipper : HRESULT;
    function UpdateBounds : HRESULT;
    function ClipRect( var DestRect, SrcRect : TRect; const DestRect2, SrcRect2 : TRect ) : Boolean;


    // Methods to create child objects
    function CreatePaletteFromBitmap( out ppPalette : IDIRECTDRAWPALETTE; const strBMP : string ) : HRESULT;
    function CreateSurface( var ppSurface : TSurface; dwWidth, dwHeight : LongWord ) : HRESULT;
    function CreateSurfaceFromBitmap( var ppSurface : TSurface; strBMP : string; dwDesiredWidth, dwDesiredHeight : LongWord ) : HRESULT;
    function CreateSurfaceFromText( var ppSurface : TSurface; h_Font : HFONT; strText : string; crBackground, crForeground : TColorRef ) : HRESULT;

    // Display methods
    function Blt( x, y : Integer; pdds : IDIRECTDRAWSURFACE7; prc : PRect; dwFlags : LongWord = 0 ) : HRESULT; overload;
    function Blt( x, y : Integer; var pSurface : TSurface; prc : PRect ) : HRESULT; overload;
    function BltAlpha( iDestX : integer; iDestY : integer; lpDDSSource : TSurface; lprcSource : PRECT; iAlpha : Byte; lwMode : TRGBMode ) : HResult;
    function BltAlphaMMX( iDestX : integer; iDestY : integer; lpDDSSource : TSurface; lprcSource : PRECT; iAlpha : integer; lwMode : TRGBMode ) : HResult;
    function BltAlphaFast( iDestX : integer; iDestY : integer; lpDDSSource : TSurface; lprcSource : PRECT; lwMode : TRGBMode ) : HResult;
    function BltAlphaFastMMX( iDestX : integer; iDestY : integer; lpDDSSource : TSurface; lprcSource : PRECT; lwMode : TRGBMode ) : HResult;
    function Clear( dwColor : LongWord = $0 ) : HRESULT;
    function ColorKeyBlt( x, y : Integer; pdds : IDIRECTDRAWSURFACE7; prc : PRect ) : HRESULT;
    function ShowBitmap( hbm : HBITMAP; pPalette : IDIRECTDRAWPALETTE = nil ) : HRESULT;
    function SetPalette( var pPalette : IDIRECTDRAWPALETTE ) : HRESULT;
    function Flip : HRESULT;
    property Height : Integer read FHeight write FHeight;
    property Width : Integer read FWidth write FWidth;
  end;

  //-----------------------------------------------------------------------------
  // Name: class CSurface
  // Desc: Class to handle aspects of a DirectDrawSurface.
  //-----------------------------------------------------------------------------
  TSurface = class
  private
    m_pdds : IDIRECTDRAWSURFACE7;
    m_ddsd : TDDSURFACEDESC2;
    m_bColorKeyed : Boolean;
    FHeight : Integer;
    FWidth : Integer;
    FRGBMode: TRGBMode;
    function GetRGBMode : TRGBMode;
  public
    function ConvertGDIColor( dwGDIColor : TColorRef ) : LongWord;
    constructor Create;
    function CreateSurface( pDD : IDIRECTDRAW7; var pddsd : TDDSURFACEDESC2 ) : HRESULT; overload;
    function CreateSurface( pdds : IDIRECTDRAWSURFACE7 ) : HRESULT; overload;

    destructor Destroy; override;
    function DestroySurface : HRESULT;
    function DrawBitmap( const strBMP : string; dwDesiredWidth, dwDesiredHeight : LongWord ) : HRESULT; overload;
    function DrawBitmap( hBMP : HBITMAP; dwBMPOriginX : LongWord = 0; dwBMPOriginY : LongWord = 0; dwBMPWidth : LongWord = 0; dwBMPHeight : LongWord = 0 ) : HRESULT; overload;

    function DrawText( h_Font : HFONT; strText : string; dwOriginX, dwOriginY : LongWord; crBackground, crForeground : TColorRef ) : HRESULT;

    function GetBitMaskInfo( dwBitMask : LongWord; var pdwShift : LongWord; var pdwBits : LongWord ) : HRESULT;
    function GetDDrawSurface : IDIRECTDRAWSURFACE7;

    function IsColorKeyed : Boolean;

    function SetColorKey( dwColorKey : LongWord ) : HRESULT;
    property Height : Integer read FHeight write FHeight;
    property Width : Integer read FWidth write FWidth;
    property RGBMode : TRGBMode read FRGBMode Write FRGBMode;
  end;

implementation

uses
  Classes;

{ TDisplay }
function TDisplay.Blt( x, y : Integer; var pSurface : TSurface; prc : PRect ) : HRESULT;
var
  SrcRect, dstRect : TRect;
begin
  if pSurface = nil then
  begin
    result := E_INVALIDARG;
    exit;
  end;

  if prc = nil then
    SrcRect := Rect( 0, 0, pSurface.Width, pSurface.Height )
  else
    SrcRect := prc^;

  dstRect := Bounds( X, Y, SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top );

  ClipRect( dstRect, SrcRect, Rect( 0, 0, Width, Height ), Rect( 0, 0, pSurface.Width, pSurface.Height ) );

  if pSurface.IsColorKeyed then
    //result := Blt( x, y, pSurface.GetDDrawSurface, prc, DDBLTFAST_SRCCOLORKEY or DDBLTFAST_WAIT )
    result := Blt( dstRect.Left, dstRect.Top, pSurface.GetDDrawSurface, @SrcRect, DDBLTFAST_SRCCOLORKEY or DDBLTFAST_WAIT )
  else
    //result := Blt( x, y, pSurface.GetDDrawSurface, prc, DDBLTFAST_NOCOLORKEY or DDBLTFAST_WAIT );
    result := Blt( dstRect.Left, dstRect.Top, pSurface.GetDDrawSurface, @SrcRect, DDBLTFAST_NOCOLORKEY or DDBLTFAST_WAIT );
end;

function TDisplay.Blt( x, y : Integer; pdds : IDIRECTDRAWSURFACE7; prc : PRect; dwFlags : LongWord ) : HRESULT;
begin
  if m_pddsBackBuffer = nil then
  begin
    result := E_POINTER;
    exit;
  end;
  result := m_pddsBackBuffer.BltFast( x, y, pdds, prc, dwFlags );
end;

function TDisplay.Clear( dwColor : LongWord ) : HRESULT;
var
  ddbltfx : TDDBLTFX;
begin
  if m_pddsBackBuffer = nil then
  begin
    result := E_POINTER;
    exit;
  end;

  // Erase the background
  FillChar( ddbltfx, SizeOf( ddbltfx ), 0 ); //ZeroMemory( @ddbltfx, SizeOf( TDDBLTFX ) );
  ddbltfx.dwSize := SizeOf( ddbltfx );
  ddbltfx.dwFillColor := dwColor;

  result := m_pddsBackBuffer.Blt( nil, nil, nil, DDBLT_COLORFILL, @ddbltfx );
end;

function TDisplay.ColorKeyBlt( x, y : Integer; pdds : IDIRECTDRAWSURFACE7; prc : PRect ) : HRESULT;
begin
  if m_pddsBackBuffer = nil then
  begin
    result := E_POINTER;
    exit;
  end;

  result := m_pddsBackBuffer.BltFast( x, y, pdds, prc, DDBLTFAST_SRCCOLORKEY );
end;

constructor TDisplay.Create;
begin
  m_pDD := nil;
  m_pddsFrontBuffer := nil;
  m_pddsBackBuffer := nil;
  m_pddsBackBufferLeft := nil;
end;

function TDisplay.CreateFullScreenDisplay( h_Wnd : HWND; dwWidth, dwHeight, dwBPP : LongWord ) : HRESULT;
var
  hr : HRESULT;
  ddsd : TDDSURFACEDESC2;
  ddscaps : TDDSCAPS2;
begin
  // Cleanup anything from a previous call
  DestroyObjects;

  // DDraw stuff begins here
  hr := DirectDrawCreateEx( nil, m_pDD, IID_IDirectDraw7, nil );
  if ( hr <> DD_OK ) then
  begin
    result := E_FAIL;
    exit;
  end;

  // Set cooperative level
  hr := m_pDD.SetCooperativeLevel( h_Wnd, DDSCL_EXCLUSIVE or DDSCL_FULLSCREEN );
  if ( hr <> DD_OK ) then
  begin
    result := E_FAIL;
    exit;
  end;

  // Set the display mode
  hr := m_pDD.SetDisplayMode( dwWidth, dwHeight, dwBPP, 0, 0 );
  if ( hr <> DD_OK ) then
  begin
    result := E_FAIL;
    exit;
  end;


  // Create primary surface (with backbuffer attached)
  FillChar( ddsd, SizeOf( ddsd ), 0 ); //ZeroMemory( @ddsd, SizeOf( ddsd ) );
  ddsd.dwSize := SizeOf( ddsd );
  ddsd.dwFlags := DDSD_CAPS or DDSD_BACKBUFFERCOUNT;
  ddsd.ddsCaps.dwCaps := DDSCAPS_PRIMARYSURFACE or DDSCAPS_FLIP or DDSCAPS_COMPLEX or DDSCAPS_3DDEVICE;
  ddsd.dwBackBufferCount := 1;

  hr := m_pDD.CreateSurface( ddsd, m_pddsFrontBuffer, nil );
  if ( hr <> DD_OK ) then
  begin
    result := E_FAIL;
    exit;
  end;

  // Get a pointer to the back buffer
  FillChar( ddscaps, SizeOf( ddscaps ), 0 ); //ZeroMemory( @ddscaps, SizeOf( TDDSCAPS2 ) );
  ddscaps.dwCaps := DDSCAPS_BACKBUFFER;

  hr := m_pddsFrontBuffer.GetAttachedSurface( ddscaps, m_pddsBackBuffer );
  if ( hr <> DD_OK ) then
  begin
    result := E_FAIL;
    exit;
  end;

  m_hWnd := h_Wnd;
  m_bWindowed := false;
  UpdateBounds;

  FWidth := dwWidth;
  FHeight := dwHeight;

  result := DD_OK;
end;

function TDisplay.CreatePaletteFromBitmap( out ppPalette : IDIRECTDRAWPALETTE; const strBMP : string ) : HRESULT;
var
  hResource : HRSRC;
  pRGB : PRGBQUAD;
  pbi : PBITMAPINFOHEADER;
  aPalette : array[ 0..255 ] of TPALETTEENTRY;
  hFile : THANDLE;
  iColor : LongWord;
  dwColors : LongWord;
  bf : BITMAPFILEHEADER;
  bi : BITMAPINFOHEADER;
  //dwBytesRead : LongWord;
  r : BYTE;
  i : Integer;
begin
  if ( m_pDD = nil ) or ( strBMP = '' ) then
  begin
    result := E_INVALIDARG;
    exit;
  end;


  // Build a 332 palette as the default.
  for i := 0 to 255 do
  begin
    aPalette[ i ].peRed := ( ( i shr 5 ) and $07 ) * 255 div 7;
    aPalette[ i ].peGreen := ( ( i shr 2 ) and $07 ) * 255 div 7;
    aPalette[ i ].peBlue := ( ( i shr 0 ) and $03 ) * 255 div 3;
    aPalette[ i ].peFlags := 0;
  end;

  ppPalette := nil;

  //  Try to load the bitmap as a resource, if that fails, try it as a file
  hResource := FindResource( 0, PChar( strBMP ), RT_BITMAP );
  if ( hResource <> 0 ) then
  begin
    pbi := LockResource( LoadResource( 0, hResource ) );
    if ( pbi = nil ) then
    begin
      result := E_FAIL;
      exit;
    end;
    inc( pbi, pbi^.biSize );
    pRGB := PRGBQUAD( pbi );
    //pRGB := (RGBQUAD*) ( (BYTE*) pbi + pbi.biSize );

    // Figure out how many colors there are
    if ( pbi = nil ) or ( pbi^.biSize < SizeOf( BITMAPINFOHEADER ) ) then
      dwColors := 0
    else if ( pbi^.biBitCount > 8 ) then
      dwColors := 0
    else if ( pbi^.biClrUsed = 0 ) then
      dwColors := 1 shl pbi^.biBitCount
    else
      dwColors := pbi^.biClrUsed;

    //  A DIB color table has its colors stored BGR not RGB
    //  so flip them around.
    for iColor := 0 to dwColors - 1 do
    begin
      aPalette[ iColor ].peRed := pRGB^.rgbRed;
      aPalette[ iColor ].peGreen := pRGB^.rgbGreen;
      aPalette[ iColor ].peBlue := pRGB^.rgbBlue;
      aPalette[ iColor ].peFlags := 0;
      inc( pRGB );
    end;
  end
  else
  begin

    // Attempt to load bitmap as a file
    hFile := _lopen( PChar( strBMP ), OF_READ ); //CreateFile( strBMP, GENERIC_READ, 0, nil, OPEN_EXISTING, 0, 0 );
    if ( hFile = HFILE_ERROR ) then
    begin
      result := E_FAIL;
      exit;
    end;

    // Read the BITMAPFILEHEADER
    //ReadFile( hFile, @bf, SizeOf( bf ), dwBytesRead, nil );
    //if dwBytesRead <> SizeOf( bf ) then
    if ( _lread( hFile, @bf, SizeOf( bf ) ) = HFILE_ERROR ) then
    begin
      _lclose( hFile ); //CloseHandle( hFile );
      result := E_FAIL;
      exit;
    end;

    // Read the BITMAPINFOHEADER
    //ReadFile( hFile, @bi, SizeOf( bi ), dwBytesRead, nil );
    //if dwBytesRead <> SizeOf(bi) then
    if ( _lread( hFile, @bi, SizeOf( bi ) ) = HFILE_ERROR ) then
    begin
      _lclose( hFile ); //CloseHandle( hFile );
      result := E_FAIL;
      exit;
    end;

    // Read the PALETTEENTRY
    //ReadFile( hFile, @aPalette[0], SizeOf( aPalette ), dwBytesRead, nil );
    //if dwBytesRead <> SizeOf(aPalette) then
    if ( _lread( hFile, @aPalette[ 0 ], SizeOf( aPalette ) ) = HFILE_ERROR ) then
    begin
      _lclose( hFile ); //CloseHandle( hFile );
      result := E_FAIL;
      exit;
    end;

    _lclose( hFile ); //CloseHandle( hFile );

    // Figure out how many colors there are
    if ( bi.biSize <> SizeOf( BITMAPINFOHEADER ) ) then
      dwColors := 0
    else if ( bi.biBitCount > 8 ) then
      dwColors := 0
    else if ( bi.biClrUsed = 0 ) then
      dwColors := ( 1 shl bi.biBitCount )
    else
      dwColors := bi.biClrUsed;

    //  A DIB color table has its colors stored BGR not RGB
    //  so flip them around since DirectDraw uses RGB
    for iColor := 0 to dwColors - 1 do
    begin
      r := aPalette[ iColor ].peRed;
      aPalette[ iColor ].peRed := aPalette[ iColor ].peBlue;
      aPalette[ iColor ].peBlue := r;
    end;
  end;

  result := m_pDD.CreatePalette( DDPCAPS_8BIT, @aPalette[ 0 ], ppPalette, nil );
end;

function TDisplay.CreateSurface( var ppSurface : TSurface; dwWidth, dwHeight : LongWord ) : HRESULT;
var
  hr : HRESULT;
  ddsd : TDDSURFACEDESC2;
begin
  if ( m_pDD = nil ) then
  begin
    result := E_POINTER;
    exit;
  end;

  if ( @ppSurface = nil ) then
  begin
    result := E_INVALIDARG;
    exit;
  end;


  FillChar( ddsd, SizeOf( ddsd ), 0 ); //ZeroMemory( @ddsd, SizeOf( ddsd ) );
  ddsd.dwSize := SizeOf( ddsd );
  ddsd.dwFlags := DDSD_CAPS or DDSD_WIDTH or DDSD_HEIGHT;
  ddsd.ddsCaps.dwCaps := DDSCAPS_OFFSCREENPLAIN;
  ddsd.dwWidth := dwWidth;
  ddsd.dwHeight := dwHeight;

  ppSurface := TSurface.Create;
  hr := ppSurface.CreateSurface( m_pDD, ddsd );
  if ( hr <> DD_OK ) then
  begin
    ppSurface.Free;
    result := hr;
    exit;
  end;

  ppSurface.Width := dwWidth;
  ppSurface.Height := dwHeight;

  result := DD_OK;
end;

function TDisplay.CreateSurfaceFromBitmap( var ppSurface : TSurface; strBMP : string; dwDesiredWidth, dwDesiredHeight : LongWord ) : HRESULT;
var
  hr : HRESULT;
  hBMP : HBITMAP;
  bmp : BITMAP;
  ddsd : TDDSURFACEDESC2;
begin
  if ( m_pDD = nil ) or ( strBMP = '' ) then
  begin
    result := E_INVALIDARG;
    exit;
  end;

  ppSurface := nil;

  //  Try to load the bitmap as a resource, if that fails, try it as a file
  hBMP := LoadImage( GetModuleHandle( nil ), PChar( strBMP ), IMAGE_BITMAP, dwDesiredWidth, dwDesiredHeight, LR_CREATEDIBSECTION );
  if ( hBMP = 0 ) then
  begin
    hBMP := LoadImage( 0, PChar( strBMP ), IMAGE_BITMAP, dwDesiredWidth, dwDesiredHeight, LR_LOADFROMFILE or LR_CREATEDIBSECTION );
    if ( hBMP = 0 ) then
    begin
      result := E_FAIL;
      exit;
    end;
  end;

  // Get size of the bitmap
  GetObject( hBMP, SizeOf( bmp ), @bmp );

  // Create a DirectDrawSurface for this bitmap
  FillChar( ddsd, SizeOf( ddsd ), 0 ); //ZeroMemory( @ddsd, SizeOf( ddsd ) );
  ddsd.dwSize := SizeOf( ddsd );
  ddsd.dwFlags := DDSD_CAPS or DDSD_HEIGHT or DDSD_WIDTH;
  ddsd.ddsCaps.dwCaps := DDSCAPS_OFFSCREENPLAIN;
  ddsd.dwWidth := bmp.bmWidth;
  ddsd.dwHeight := bmp.bmHeight;

  ppSurface := TSurface.Create;
  hr := ppSurface.CreateSurface( m_pDD, ddsd );
  if ( hr <> DD_OK ) then
  begin
    ppSurface.Free;
    result := hr;
    exit;
  end;

  ppSurface.Width := bmp.bmWidth;
  ppSurface.Height := bmp.bmHeight;

  // Draw the bitmap on this surface
  hr := ppSurface.DrawBitmap( hBMP, 0, 0, 0, 0 );
  if ( hr <> DD_OK ) then
  begin
    DeleteObject( hBMP );
    result := hr;
    exit;
  end;

  DeleteObject( hBMP );

  result := DD_OK;
end;

function TDisplay.CreateSurfaceFromText( var ppSurface : TSurface; h_Font : HFONT; strText : string; crBackground, crForeground : TColorRef ) : HRESULT;
var
  h_DC : HDC;
  //pDDS : IDIRECTDRAWSURFACE7;
  hr : HRESULT;
  ddsd : TDDSURFACEDESC2;
  sizeText : SIZE;
begin
  if ( m_pDD = nil ) or ( strText = '' ) then
  begin
    result := E_INVALIDARG;
    exit;
  end;

  ppSurface := nil;

  h_DC := GetDC( 0 );

  if h_Font <> 0 then
    SelectObject( h_DC, h_Font );

  GetTextExtentPoint32( h_DC, PChar( strText ), Length( strText ), sizeText );
  ReleaseDC( 0, h_DC );

  // Create a DirectDrawSurface for this bitmap
  FillChar( ddsd, SizeOf( ddsd ), 0 ); //ZeroMemory( @ddsd, SizeOf( ddsd ) );
  ddsd.dwSize := SizeOf( ddsd );
  ddsd.dwFlags := DDSD_CAPS or DDSD_HEIGHT or DDSD_WIDTH;
  ddsd.ddsCaps.dwCaps := DDSCAPS_OFFSCREENPLAIN;
  ddsd.dwWidth := sizeText.cx;
  ddsd.dwHeight := sizeText.cy;

  ppSurface := TSurface.Create;
  hr := ppSurface.CreateSurface( m_pDD, ddsd );
  if ( hr <> DD_OK ) then
  begin
    ppSurface.Free;
    result := hr;
    exit;
  end;

  ppSurface.Width := sizeText.cx;
  ppSurface.Height := sizeText.cy;

  hr := ppSurface.DrawText( h_Font, PChar( strText ), 0, 0, crBackground, crForeground );
  if ( hr <> DD_OK ) then
  begin
    result := hr;
    exit;
  end;

  result := DD_OK;
end;

function TDisplay.CreateWindowedDisplay( h_Wnd : HWND; dwWidth, dwHeight : LongWord ) : HRESULT;
var
  hr : HRESULT;
  rcWork : TRect;
  rc : TRect;
  dwStyle : LongWord;
  pcClipper : IDIRECTDRAWCLIPPER;
  ddsd : TDDSURFACEDESC2;
begin
  // Cleanup anything from a previous call
  DestroyObjects;

  // DDraw stuff begins here
  hr := DirectDrawCreateEx( nil, m_pDD, IID_IDirectDraw7, nil );
  if ( hr <> DD_OK ) then
  begin
    result := E_FAIL;
    exit;
  end;

  // Set cooperative level
  hr := m_pDD.SetCooperativeLevel( h_Wnd, DDSCL_NORMAL );
  if ( hr <> DD_OK ) then
  begin
    result := E_FAIL;
    exit;
  end;

  // If we are still a WS_POPUP window we should convert to a normal app
  // window so we look like a windows app.
  dwStyle := GetWindowLong( h_Wnd, GWL_STYLE ); //GetWindowStyle( h_Wnd );
  dwStyle := dwStyle and not WS_POPUP;
  dwStyle := dwStyle or WS_OVERLAPPED or WS_CAPTION or WS_THICKFRAME or WS_MINIMIZEBOX;
  SetWindowLong( h_Wnd, GWL_STYLE, dwStyle );

  // Aet window size
  SetRect( rc, 0, 0, dwWidth, dwHeight );

  AdjustWindowRectEx( rc, GetWindowLong( h_Wnd, GWL_STYLE ) {GetWindowStyle(h_Wnd)}, ( GetMenu( h_Wnd ) <> 0 ), GetWindowLong( h_Wnd, GWL_EXSTYLE ) {GetWindowExStyle(h_Wnd) } );

  SetWindowPos( h_Wnd, 0, 0, 0, rc.right - rc.left, rc.bottom - rc.top, SWP_NOMOVE or SWP_NOZORDER or SWP_NOACTIVATE );

  SetWindowPos( h_Wnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE );

  //  Make sure our window does not hang outside of the work area
  SystemParametersInfo( SPI_GETWORKAREA, 0, @rcWork, 0 );
  GetWindowRect( h_Wnd, rc );
  if ( rc.left < rcWork.left ) then
    rc.left := rcWork.left;
  if ( rc.top < rcWork.top ) then
    rc.top := rcWork.top;
  SetWindowPos( h_Wnd, 0, rc.left, rc.top, 0, 0, SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE );

  // Create the primary surface
  FillChar( ddsd, SizeOf( ddsd ), 0 ); //ZeroMemory( @ddsd, SizeOf( ddsd ) );
  ddsd.dwSize := SizeOf( ddsd );
  ddsd.dwFlags := DDSD_CAPS;
  ddsd.ddsCaps.dwCaps := DDSCAPS_PRIMARYSURFACE;

  hr := m_pDD.CreateSurface( ddsd, m_pddsFrontBuffer, nil );
  if ( hr <> DD_OK ) then
  begin
    result := E_FAIL;
    exit;
  end;


  // Create the backbuffer surface
  ddsd.dwFlags := DDSD_CAPS or DDSD_WIDTH or DDSD_HEIGHT;
  ddsd.ddsCaps.dwCaps := DDSCAPS_OFFSCREENPLAIN or DDSCAPS_3DDEVICE;
  ddsd.dwWidth := dwWidth;
  ddsd.dwHeight := dwHeight;

  hr := m_pDD.CreateSurface( ddsd, m_pddsBackBuffer, nil );
  if ( hr <> DD_OK ) then
  begin
    result := E_FAIL;
    exit;
  end;

  hr := m_pDD.CreateClipper( 0, pcClipper, nil );
  if ( hr <> DD_OK ) then
  begin
    result := E_FAIL;
    exit;
  end;

  hr := pcClipper.SetHWnd( 0, h_Wnd );
  if ( hr <> DD_OK ) then
  begin
    pcClipper := nil;
    result := E_FAIL;
    exit;
  end;

  hr := m_pddsFrontBuffer.SetClipper( pcClipper );
  if ( hr <> DD_OK ) then
  begin
    pcClipper := nil;
    result := E_FAIL;
    exit;
  end;

  // Done with clipper
  pcClipper := nil;

  m_hWnd := h_Wnd;
  m_bWindowed := true;
  UpdateBounds;

  FWidth := dwWidth;
  FHeight := dwHeight;

  result := DD_OK;
end;

destructor TDisplay.Destroy;
begin
  DestroyObjects;
  inherited;
end;

function TDisplay.DestroyObjects : HRESULT;
begin
  m_pddsBackBufferLeft := nil;
  m_pddsBackBuffer := nil;
  m_pddsFrontBuffer := nil;

  if Assigned( m_pDD ) then
    m_pDD.SetCooperativeLevel( m_hWnd, DDSCL_NORMAL );

  m_pDD := nil;

  result := DD_OK;
end;

function TDisplay.GetBackBuffer : IDIRECTDRAWSURFACE7;
begin
  result := m_pddsBackBuffer;
end;

function TDisplay.GetBackBufferLeft : IDIRECTDRAWSURFACE7;
begin
  result := m_pddsBackBufferLeft;
end;

function TDisplay.GetDirectDraw : IDIRECTDRAW7;
begin
  result := m_pDD;
end;

function TDisplay.GetFrontBuffer : IDIRECTDRAWSURFACE7;
begin
  result := m_pddsFrontBuffer;
end;

function TDisplay.GetHWnd : HWND;
begin
  result := m_hWnd;
end;

function TDisplay.InitClipper : HRESULT;
var
  pClipper : IDIRECTDRAWCLIPPER;
  hr : HRESULT;
begin
  // Create a clipper when using GDI to draw on the primary surface
  hr := m_pDD.CreateClipper( 0, pClipper, nil );
  if ( hr <> DD_OK ) then
  begin
    result := hr;
    exit;
  end;

  pClipper.SetHWnd( 0, m_hWnd );

  hr := m_pddsFrontBuffer.SetClipper( pClipper );
  if ( hr <> DD_OK ) then
  begin
    result := hr;
    exit;
  end;

  // We can release the clipper now since g_pDDSPrimary
  // now maintains a ref count on the clipper
  pClipper := nil;

  result := DD_OK;
end;

function TDisplay.Flip : HRESULT;
var
  hr : HRESULT;
begin
  if ( m_pddsFrontBuffer = nil ) and ( m_pddsBackBuffer = nil ) then
  begin
    result := E_POINTER;
    exit
  end;

  while ( true ) do
  begin
    if ( m_bWindowed ) then
      hr := m_pddsFrontBuffer.Blt( @m_rcWindow, m_pddsBackBuffer, nil, DDBLT_WAIT, nil )
    else
      hr := m_pddsFrontBuffer.Flip( nil, DDFLIP_WAIT );

    if ( hr = DDERR_SURFACELOST ) then
    begin
      m_pddsFrontBuffer._Restore;
      m_pddsBackBuffer._Restore;
    end;

    if ( hr <> DDERR_WASSTILLDRAWING ) then
    begin
      result := hr;
      exit;
    end;
  end;
end;

function TDisplay.SetPalette( var pPalette : IDIRECTDRAWPALETTE ) : HRESULT;
begin
  if ( m_pddsFrontBuffer = nil ) then
  begin
    result := E_POINTER;
    exit;
  end;

  result := m_pddsFrontBuffer.SetPalette( pPalette );
end;

function TDisplay.ShowBitmap( hbm : HBITMAP; pPalette : IDIRECTDRAWPALETTE ) : HRESULT;
var
  backBuffer : TSurface;
  hr : HRESULT;
begin
  backBuffer := nil;
  if ( m_pddsFrontBuffer = nil ) or ( m_pddsBackBuffer = nil ) then
  begin
    result := E_POINTER;
    exit;
  end;

  // Set the palette before loading the bitmap
  if ( pPalette <> nil ) then
    m_pddsFrontBuffer.SetPalette( pPalette );


  backBuffer.CreateSurface( m_pddsBackBuffer );

  hr := backBuffer.DrawBitmap( hbm, 0, 0, 0, 0 );
  if ( hr <> DD_OK ) then
  begin
    result := E_FAIL;
    exit;
  end;

  result := Flip;
end;

function TDisplay.Stereo : Boolean;
begin
  result := m_bStereo;
end;

function TDisplay.UpdateBounds : HRESULT;
begin
  if ( m_bWindowed ) then
  begin
    GetClientRect( m_hWnd, m_rcWindow );
    ClientToScreen( m_hWnd, m_rcWindow.TopLeft );
    ClientToScreen( m_hWnd, m_rcWindow.BottomRight );
  end
  else
  begin
    SetRect( m_rcWindow, 0, 0, GetSystemMetrics( SM_CXSCREEN ), GetSystemMetrics( SM_CYSCREEN ) );
  end;
  result := DD_OK;
end;

function TDisplay.Windowed : Boolean;
begin
  result := m_bWindowed;
end;

{ TSurface }
// Converts a GDI color (0x00bbggrr) into the equivalent color on a
// DirectDrawSurface using its pixel format.

function TSurface.ConvertGDIColor( dwGDIColor : TColorRef ) : LongWord;
var
  rgbT : TCOLORREF;
  h_dc : HDC;
  dw : LongWord;
  ddsd : TDDSURFACEDESC2;
  hr : HRESULT;
begin
  if ( m_pdds = nil ) then
  begin
    result := $00000000;
    exit;
  end;

  dw := CLR_INVALID;
  rgbT := 0;

  //  Use GDI SetPixel to color match for us
  if ( dwGDIColor <> CLR_INVALID ) and ( m_pdds.GetDC( h_dc ) = DD_OK ) then
  begin
    rgbT := GetPixel( h_dc, 0, 0 ); // Save current pixel value
    SetPixel( h_dc, 0, 0, dwGDIColor ); // Set our value
    m_pdds.ReleaseDC( h_dc );
  end;

  // Now lock the surface so we can read back the converted color
  ddsd.dwSize := SizeOf( ddsd );
  hr := m_pdds.Lock( nil, ddsd, DDLOCK_WAIT, 0 );
  if ( hr = DD_OK ) then
  begin
    dw := PLongWord( ddsd.lpSurface )^;
    if ( ddsd.ddpfPixelFormat.dwRGBBitCount < 32 ) then // Mask it to bpp
      dw := dw and ( ( 1 shl ddsd.ddpfPixelFormat.dwRGBBitCount ) - 1 );
    m_pdds.Unlock( nil );
  end;

  //  Now put the color that was there back.
  if ( dwGDIColor <> CLR_INVALID ) and ( m_pdds.GetDC( h_dc ) = DD_OK ) then
  begin
    SetPixel( h_dc, 0, 0, rgbT );
    m_pdds.ReleaseDC( h_dc );
  end;

  result := dw;
end;

constructor TSurface.Create;
begin
  m_pdds := nil;
  m_bColorKeyed := false;
end;

function TSurface.CreateSurface( pDD : IDIRECTDRAW7; var pddsd : TDDSURFACEDESC2 ) : HRESULT;
var
  hr : HRESULT;
begin
  // Create the DDraw surface
  hr := pDD.CreateSurface( pddsd, m_pdds, nil );
  if ( hr <> DD_OK ) then
  begin
    result := hr;
    exit;
  end;

  // Prepare the DDSURFACEDESC structure
  m_ddsd.dwSize := SizeOf( m_ddsd );

  // Get the DDSURFACEDESC structure for this surface
  m_pdds.GetSurfaceDesc( m_ddsd );

  FRGBMode := GetRGBMode;

  result := DD_OK;
end;

function TSurface.CreateSurface( pdds : IDIRECTDRAWSURFACE7 ) : HRESULT;
begin
  m_pdds := pdds;

  if m_pdds <> nil then
  begin
    m_pdds._AddRef;

    // Get the DDSURFACEDESC structure for this surface
    m_ddsd.dwSize := SizeOf( m_ddsd );
    m_pdds.GetSurfaceDesc( m_ddsd );
    FRGBMode := GetRGBMode;
  end;

  result := DD_OK;
end;

destructor TSurface.Destroy;
begin
  m_pdds := nil;
  inherited;
end;

function TSurface.DestroySurface : HRESULT;
begin
  m_pdds := nil;
  result := DD_OK;
end;

function TSurface.DrawBitmap( const strBMP : string; dwDesiredWidth, dwDesiredHeight : LongWord ) : HRESULT;
var
  hBMP : HBITMAP;
  hr : HRESULT;
begin
  if ( m_pdds = nil ) or ( strBMP = '' ) then
  begin
    result := E_INVALIDARG;
    exit
  end;

  //  Try to load the bitmap as a resource, if that fails, try it as a file
  hBMP := LoadImage( GetModuleHandle( nil ), PChar( strBMP ), IMAGE_BITMAP, dwDesiredWidth, dwDesiredHeight, LR_CREATEDIBSECTION );
  if ( hBMP = 0 ) then
  begin
    hBMP := LoadImage( 0, PChar( strBMP ), IMAGE_BITMAP, dwDesiredWidth, dwDesiredHeight, LR_LOADFROMFILE or LR_CREATEDIBSECTION );
    if ( hBMP = 0 ) then
    begin
      result := E_FAIL;
      exit;
    end;
  end;

  // Draw the bitmap on this surface
  hr := DrawBitmap( hBMP, 0, 0, 0, 0 );
  if ( hr <> DD_OK ) then
  begin
    DeleteObject( hBMP );
    result := hr;
    exit;
  end;

  DeleteObject( hBMP );

  result := DD_OK;
end;

// Draws a bitmap over an entire DirectDrawSurface, stretching the
// bitmap if nessasary

function TSurface.DrawBitmap( hBMP : HBITMAP; dwBMPOriginX, dwBMPOriginY, dwBMPWidth, dwBMPHeight : LongWord ) : HRESULT;
var
  hDCImage : HDC;
  h_DC : HDC;
  bmp : BITMAP;
  ddsd : TDDSURFACEDESC2;
  hr : HRESULT;
begin
  if ( hBMP = 0 ) or ( m_pdds = nil ) then
  begin
    result := E_INVALIDARG;
    exit;
  end;

  // Make sure this surface is restored.
  hr := m_pdds._Restore;
  if ( hr <> DD_OK ) then
  begin
    result := hr;
    exit;
  end;

  if ( ddsd.ddpfPixelFormat.dwFlags = DDPF_FOURCC ) then
  begin
    result := E_NOTIMPL;
    exit;
  end;

  // Select bitmap into a memoryDC so we can use it.
  hDCImage := CreateCompatibleDC( 0 );
  if ( hDCImage = 0 ) then
  begin
    result := E_FAIL;
    exit;
  end;

  SelectObject( hDCImage, hBMP );

  // Get size of the bitmap
  GetObject( hBMP, SizeOf( bmp ), @bmp );

  // Use the passed size, unless zero
  if dwBMPWidth = 0 then
    dwBMPWidth := bmp.bmWidth;

  if dwBMPHeight = 0 then
    dwBMPHeight := bmp.bmHeight;

  // Get the surface.description
  ddsd.dwSize := SizeOf( ddsd );
  ddsd.dwFlags := DDSD_HEIGHT or DDSD_WIDTH;
  m_pdds.GetSurfaceDesc( ddsd );

  // Stretch the bitmap to cover this surface
  hr := m_pdds.GetDC( h_DC );
  if ( hr <> DD_OK ) then
  begin
    result := hr;
    exit;
  end;

  StretchBlt( h_DC, 0, 0, ddsd.dwWidth, ddsd.dwHeight, hDCImage, dwBMPOriginX, dwBMPOriginY, dwBMPWidth, dwBMPHeight, SRCCOPY );
  hr := m_pdds.ReleaseDC( h_Dc );
  if ( hr <> DD_OK ) then
  begin
    result := hr;
    exit;
  end;

  DeleteDC( hDCImage );

  result := DD_OK;
end;

// Draws a text string on a DirectDraw surface using hFont or the default
// GDI font if hFont is nil.

function TSurface.DrawText( h_Font : HFONT; strText : string; dwOriginX, dwOriginY : LongWord; crBackground, crForeground : TColorRef ) : HRESULT;
var
  h_DC : HDC;
  hr : HRESULT;
begin
  if ( m_pdds = nil ) or ( strText = '' ) then
  begin
    result := E_INVALIDARG;
    exit;
  end;

  // Make sure this surface is restored.
  hr := m_pdds._Restore;
  if ( hr <> DD_OK ) then
  begin
    result := hr;
    exit;
  end;

  hr := m_pdds.GetDC( h_DC );
  if ( hr <> DD_OK ) then
  begin
    result := hr;
    exit;
  end;

  // Set the background and foreground color
  SetBkColor( h_DC, crBackground );
  SetTextColor( h_DC, crForeground );

  if ( h_Font = 0 ) then
    SelectObject( h_DC, h_Font );

  // Use GDI to draw the text on the surface
  TextOut( h_DC, dwOriginX, dwOriginY, PChar( strText ), Length( strText ) );

  hr := m_pdds.ReleaseDC( h_DC );
  if ( hr <> DD_OK ) then
  begin
    result := hr;
    exit;
  end;

  result := DD_OK;
end;

function TSurface.GetBitMaskInfo( dwBitMask : LongWord; var pdwShift : LongWord; var pdwBits : LongWord ) : HRESULT;
var
  dwShift : LongWord;
  dwBits : LongWord;
begin
  dwShift := 0;
  dwBits := 0;

  if ( pdwShift = 0 ) or ( pdwBits = 0 ) then
  begin
    result := E_INVALIDARG;
    exit;
  end;

  if ( dwBitMask = 0 ) then
  begin
    while ( ( dwBitMask and 1 ) = 0 ) do
    begin
      inc( dwShift );
      dwBitMask := ( dwBitMask shr 1 );
    end;
  end;

  while ( ( dwBitMask and 1 ) <> 0 ) do
  begin
    inc( dwBits );
    dwBitMask := ( dwBitMask shr 1 );
  end;

  pdwShift := dwShift;
  pdwBits := dwBits;

  result := DD_OK;
end;

function TSurface.GetDDrawSurface : IDIRECTDRAWSURFACE7;
begin
  result := m_pdds;
end;

function TSurface.GetRGBMode: TRGBMode;
begin
  case m_ddsd.ddpfPixelFormat.dwRGBBitCount of
    // If we are in 32 bit mode ...
    32 :
      begin
        result := rgbm32;
      end;

    // If we are in 24 bit mode ...
    24 :
      begin
        result := rgbm24;
      end;

    // If we are in 16 bit mode ...
    16 :
      begin
        //
        // ... determine the exact mode.
        //

        // If we are in 565 mode ...
        if ( m_ddsd.ddpfPixelFormat.dwRBitMask = ( 31 shl 11 ) ) and
          ( m_ddsd.ddpfPixelFormat.dwGBitMask = ( 63 shl 5 ) ) and
          ( m_ddsd.ddpfPixelFormat.dwBBitMask = 31 ) then
          // ... inform the caller.
          result := rgbm565
            // If we are in 555 mode ...
        else if ( m_ddsd.ddpfPixelFormat.dwRBitMask = ( 31 shl 10 ) ) and
          ( m_ddsd.ddpfPixelFormat.dwGBitMask = ( 31 shl 5 ) ) and
          ( m_ddsd.ddpfPixelFormat.dwBBitMask = 31 ) then
          // ... inform the caller.
          result := rgbm555
        else
          // We got an unknown 16 bit mode.
          result := rgbm16;
      end;
  else
    // Any other mode must be a palletized one.
    result := rgbmNone;
  end;
end;

function TSurface.IsColorKeyed : Boolean;
begin
  result := m_bColorKeyed;
end;

function TSurface.SetColorKey( dwColorKey : LongWord ) : HRESULT;
var
  ddck : TDDColorKey;
begin
  if ( m_pdds = nil ) then
  begin
    result := E_POINTER;
    exit
  end;

  m_bColorKeyed := true;

  ddck.dwColorSpaceLowValue := ConvertGDIColor( dwColorKey );
  ddck.dwColorSpaceHighValue := ddck.dwColorSpaceLowValue; //ConvertGDIColor( dwColorKey );

  result := m_pdds.SetColorKey( DDCKEY_SRCBLT, @ddck );
end;

function TDisplay.ClipRect( var DestRect, SrcRect : TRect; const DestRect2,
  SrcRect2 : TRect ) : Boolean;
begin
  if DestRect.Left < DestRect2.Left then
  begin
    SrcRect.Left := SrcRect.Left + ( DestRect2.Left - DestRect.Left );
    DestRect.Left := DestRect2.Left;
  end;

  if DestRect.Top < DestRect2.Top then
  begin
    SrcRect.Top := SrcRect.Top + ( DestRect2.Top - DestRect.Top );
    DestRect.Top := DestRect2.Top;
  end;

  if SrcRect.Left < SrcRect2.Left then
  begin
    DestRect.Left := DestRect.Left + ( SrcRect2.Left - SrcRect.Left );
    SrcRect.Left := SrcRect2.Left;
  end;

  if SrcRect.Top < SrcRect2.Top then
  begin
    DestRect.Top := DestRect.Top + ( SrcRect2.Top - SrcRect.Top );
    SrcRect.Top := SrcRect2.Top;
  end;

  if DestRect.Right > DestRect2.Right then
  begin
    SrcRect.Right := SrcRect.Right - ( DestRect.Right - DestRect2.Right );
    DestRect.Right := DestRect2.Right;
  end;

  if DestRect.Bottom > DestRect2.Bottom then
  begin
    SrcRect.Bottom := SrcRect.Bottom - ( DestRect.Bottom - DestRect2.Bottom );
    DestRect.Bottom := DestRect2.Bottom;
  end;

  if SrcRect.Right > SrcRect2.Right then
  begin
    DestRect.Right := DestRect.Right - ( SrcRect.Right - SrcRect2.Right );
    SrcRect.Right := SrcRect2.Right;
  end;

  if SrcRect.Bottom > SrcRect2.Bottom then
  begin
    DestRect.Bottom := DestRect.Bottom - ( SrcRect.Bottom - SrcRect2.Bottom );
    SrcRect.Bottom := SrcRect2.Bottom;
  end;

  Result := ( DestRect.Left < DestRect.Right ) and ( DestRect.Top < DestRect.Bottom ) and
    ( SrcRect.Left < SrcRect.Right ) and ( SrcRect.Top < SrcRect.Bottom );
end;

function TDisplay.BltAlpha( iDestX, iDestY : integer; lpDDSSource : TSurface; lprcSource : PRECT; iAlpha : Byte;
  lwMode : TRGBMode ) : HResult;
var
  ddsdSource : TDDSURFACEDESC2;
  ddsdTarget : TDDSURFACEDESC2;
  rcDest : TRECT;
  dwTargetPad : LongWord;
  dwSourcePad : LongWord;
  dwTargetTemp : LongWord;
  dwSourceTemp : LongWord;
  dwSrcRed, dwSrcGreen, dwSrcBlue : LongWord;
  dwTgtRed, dwTgtGreen, dwTgtBlue : LongWord;
  dwRed, dwGreen, dwBlue : LongWord;
  dwAdd64 : LongWord;
  dwAlphaOver4 : LongWord;
  lpbTarget : PBYTE;
  lpbSource : PBYTE;
  iWidth : integer;
  iHeight : integer;
  gOddWidth : Boolean;
  iRet : HResult;
  i : integer;
begin
  //
  // Determine the dimensions of the source surface.
  //
  if ( lprcSource <> nil ) then
  begin
    //
    // Get the width and height from the passed rectangle.
    //
    iWidth := lprcSource.right - lprcSource.left;
    iHeight := lprcSource.bottom - lprcSource.top;
  end
  else
  begin
    //
    // Get the with and height from the surface description.
    //
    FillChar( ddsdSource, SizeOf( ddsdSource ), 0 );
    ddsdSource.dwSize := SizeOf( ddsdSource );
    ddsdSource.dwFlags := DDSD_WIDTH or DDSD_HEIGHT;
    iRet := lpDDSSource.GetDDrawSurface.GetSurfaceDesc( ddsdSource );
    if ( iRet <> DD_OK ) then
    begin
      Result := iRet;
      exit;
    end;

    //
    // Remember the dimensions.
    //
    iWidth := ddsdSource.dwWidth;
    iHeight := ddsdSource.dwHeight;
  end;

  //
  // Calculate the rectangle to be locked in the target.
  //
  rcDest.left := iDestX;
  rcDest.top := iDestY;
  rcDest.right := iDestX + iWidth;
  rcDest.bottom := iDestY + iHeight;

  //
  // Lock down the destination surface.
  //
  FillChar( ddsdTarget, SizeOf( ddsdTarget ), 0 );
  ddsdTarget.dwSize := SizeOf( ddsdTarget );
  iRet := m_pddsBackBuffer.Lock( @rcDest, ddsdTarget, DDLOCK_WAIT, 0 );
  if ( iRet <> DD_OK ) then
  begin
    Result := iRet;
    exit;
  end;

  //
  // Lock down the source surface.
  //
  FillChar( ddsdSource, SizeOf( ddsdSource ), 0 );
  ddsdSource.dwSize := SizeOf( ddsdSource );
  iRet := lpDDSSource.GetDDrawSurface.Lock( lprcSource, ddsdSource, DDLOCK_WAIT, 0 );
  if ( iRet <> DD_OK ) then
  begin
    Result := iRet;
    exit;
  end;

  //
  // Perform the blit operation.
  //
  case lwMode of
    {* 16 bit mode ( 555 ). This algorithm
       can process two pixels at once. *}
    rgbm555 :
      begin
        //
        // Determine the padding bytes for the target and the source.
        //
        dwTargetPad := ddsdTarget.lPitch - ( iWidth * 2 );
        dwSourcePad := ddsdSource.lPitch - ( iWidth * 2 );

        // If the width is odd ...
        if ( iWidth and $01 ) = 1 then
        begin
          // ... set the flag ...
          gOddWidth := true;

          // ... and calculate the width.
          iWidth := ( iWidth - 1 ) div 2;
        end
          // If the width is even ...
        else
        begin
          // ... clear the flag ...
          gOddWidth := false;

          // ... and calculate the width.
          iWidth := iWidth div 2;
        end;

        //
        // Calculate certain auxiliary values.
        //
        dwAdd64 := 64 or ( 64 shl 16 );
        dwAlphaOver4 := ( iAlpha div 4 ) or ( ( iAlpha div 4 ) shl 16 );

        // Get the address of the target.
        lpbTarget := PBYTE( ddsdTarget.lpSurface );

        // Get the address of the source.
        lpbSource := PBYTE( ddsdSource.lpSurface );

        repeat
          // Reset the width.
          i := iWidth;

          //
          // Alpha-blend two pixels at once.
          //
          while ( i > 0 ) do
          begin
            // Read in two source pixels.
            dwSourceTemp := PLongWord( lpbSource )^;

            // If the two source pixels are not both black ...
            if ( dwSourceTemp <> 0 ) then
            begin
              // ... read in two target pixels.
              dwTargetTemp := PLongWord( lpbTarget )^;

              // Extract the red channels.
              dwTgtRed := ( dwTargetTemp shr 10 ) and $001F001F;
              dwSrcRed := ( dwSourceTemp shr 10 ) and $001F001F;

              // Extract the green channels.
              dwTgtGreen := ( dwTargetTemp shr 5 ) and $001F001F;
              dwSrcGreen := ( dwSourceTemp shr 5 ) and $001F001F;

              // Extract the blue channel.
              dwTgtBlue := dwTargetTemp and $001F001F;
              dwSrcBlue := dwSourceTemp and $001F001F;

              // Calculate the alpha-blended red channel.
              dwRed := ( ( ( ( iAlpha * ( dwSrcRed + dwAdd64 - dwTgtRed ) ) shr 8 )
                + dwTgtRed - dwAlphaOver4 ) and $001F001F ) shl 10;

              // Calculate the alpha-blended green channel.
              dwGreen := ( ( ( ( iAlpha * ( dwSrcGreen + dwAdd64 - dwTgtGreen ) ) shr 8 )
                + dwTgtGreen - dwAlphaOver4 ) and $001F001F ) shl 5;

              // Calculate the alpha-blended blue channel.
              dwBlue := ( ( ( iAlpha * ( dwSrcBlue + dwAdd64 - dwTgtBlue ) ) shr 8 )
                + dwTgtBlue - dwAlphaOver4 ) and $001F001F;

              // If the first source pixel is black ...
              if ( ( dwSourceTemp shr 16 ) = 0 ) then
              begin
                // ... leave the corresponding target pixel unchanged.
                PLongWord( lpbTarget )^ := ( ( dwRed or dwGreen or dwBlue ) and $FFFF ) or
                  ( dwTargetTemp and $FFFF0000 );
              end
                // If the second source pixel is black ...
              else if ( ( dwSourceTemp and $FFFF ) = 0 ) then
              begin
                // ... leave the corresponding target pixel unchanged.
                PLongWord( lpbTarget )^ := ( ( dwRed or dwGreen or dwBlue ) and $FFFF0000 ) or
                  ( dwTargetTemp and $FFFF );
              end
                // If none of the pixels is black ...
              else
              begin
                // ... write both of the new pixels to the target.
                PLongWord( lpbTarget )^ := ( dwRed or dwGreen or dwBlue );
              end;
            end;

            //
            // Proceed to the next two pixels.
            //
            inc( lpbTarget, 4 );
            inc( lpbSource, 4 );
            dec( i );
          end;

          //
          // Handle an odd width.
          //
          if ( gOddWidth ) then
          begin
            // Read in one source pixel.
            dwSourceTemp := PWord( lpbSource )^;

            // If this is not the color key ...
            if ( dwSourceTemp <> 0 ) then
            begin
              //
              // ... apply the alpha blend to it.
              //

              // Read in one target pixel.
              dwTargetTemp := PWord( lpbTarget )^;

              // Extract the red channels.
              dwTgtRed := ( dwTargetTemp shr 10 ) and $1F;
              dwSrcRed := ( dwSourceTemp shr 10 ) and $1F;

              // Extract the green channels.
              dwTgtGreen := ( dwTargetTemp shr 5 ) and $1F;
              dwSrcGreen := ( dwSourceTemp shr 5 ) and $1F;

              // Extract the blue channels.
              dwTgtBlue := dwTargetTemp and $1F;
              dwSrcBlue := dwSourceTemp and $1F;

              // Write the destination pixel.
              PWord( lpbTarget )^ :=
                ( ( ( iAlpha * ( dwSrcRed - dwTgtRed ) shr 8 ) + dwTgtRed ) shl 10 or
                ( ( iAlpha * ( dwSrcGreen - dwTgtGreen ) shr 8 ) + dwTgtGreen ) shl 5 or
                ( ( iAlpha * ( dwSrcBlue - dwTgtBlue ) shr 8 ) + dwTgtBlue ) );
            end;

            //
            // Proceed to next pixel.
            //
            inc( lpbTarget, 2 );
            inc( lpbSource, 2 );
          end;

          //
          // Proceed to the next line.
          //
          inc( lpbTarget, dwTargetPad );
          inc( lpbSource, dwSourcePad );
          dec( iHeight );
        until ( iHeight = 0 );
      end;

    {* 16 bit mode ( 565 ). This algorithm
     can process two pixels at once. *}
    rgbm565 :
      begin
        //
        // Determine the padding bytes for the target and the source.
        //
        dwTargetPad := ddsdTarget.lPitch - ( iWidth * 2 );
        dwSourcePad := ddsdSource.lPitch - ( iWidth * 2 );

        // If the width is odd ...
        if ( iWidth and $01 ) = 1 then
        begin
          // ... set the flag ...
          gOddWidth := true;

          // ... and calculate the width.
          iWidth := ( iWidth - 1 ) div 2;
        end
          // If the width is even ...
        else
        begin
          // ... clear the flag ...
          gOddWidth := false;

          // ... and calculate the width.
          iWidth := iWidth div 2;
        end;

        //
        // Calculate certain auxiliary values.
        //
        dwAdd64 := 64 or ( 64 shl 16 );
        dwAlphaOver4 := ( iAlpha div 4 ) or ( ( iAlpha div 4 ) shl 16 );

        // Get the address of the target.
        lpbTarget := PByte( ddsdTarget.lpSurface );

        // Get the address of the source.
        lpbSource := PByte( ddsdSource.lpSurface );

        repeat
          // Reset the width.
          i := iWidth;

          //
          // Alpha-blend two pixels at once.
          //
          while ( i > 0 ) do
          begin

            // Read in two source pixels.
            dwSourceTemp := PLongWord( lpbSource )^;

            // If the two source pixels are not both black ...
            if ( dwSourceTemp <> 0 ) then
            begin
              // ... read in two target pixels.
              dwTargetTemp := PLongWord( lpbTarget )^;

              // Extract the red channels.
              dwTgtRed := ( dwTargetTemp shr 11 ) and $001F001F;
              dwSrcRed := ( dwSourceTemp shr 11 ) and $001F001F;

              // Extract the green channels.
              dwTgtGreen := ( dwTargetTemp shr 5 ) and $003F003F;
              dwSrcGreen := ( dwSourceTemp shr 5 ) and $003F003F;

              // Extract the blue channel.
              dwTgtBlue := dwTargetTemp and $001F001F;
              dwSrcBlue := dwSourceTemp and $001F001F;

              // Calculate the alpha-blended red channel.
              dwRed := ( ( ( ( iAlpha * ( dwSrcRed + dwAdd64 - dwTgtRed ) ) shr 8 )
                + dwTgtRed - dwAlphaOver4 ) and $001F001F ) shl 11;

              // Calculate the alpha-blended green channel.
              dwGreen := ( ( ( ( iAlpha * ( dwSrcGreen + dwAdd64 - dwTgtGreen ) ) shr 8 )
                + dwTgtGreen - dwAlphaOver4 ) and $003F003F ) shl 5;

              // Calculate the alpha-blended blue channel.
              dwBlue := ( ( ( iAlpha * ( dwSrcBlue + dwAdd64 - dwTgtBlue ) ) shr 8 )
                + dwTgtBlue - dwAlphaOver4 ) and $001F001F;

              // If the first source pixel is black ...
              if ( ( dwSourceTemp shr 16 ) = 0 ) then
              begin
                // ... leave the corresponding target pixel unchanged.
                PLongWord( lpbTarget )^ := ( ( dwRed or dwGreen or dwBlue ) and $FFFF ) or
                  ( dwTargetTemp and $FFFF0000 );
              end
                // If the second source pixel is black ...
              else if ( ( dwSourceTemp and $FFFF ) = 0 ) then
              begin
                // ... leave the corresponding target pixel unchanged.
                PLongWord( lpbTarget )^ := ( ( dwRed or dwGreen or dwBlue ) and $FFFF0000 ) or
                  ( dwTargetTemp and $FFFF );
              end
                // If none of the pixels is black ...
              else
              begin
                // ... write both of the new pixels to the target.
                PLongWord( lpbTarget )^ := ( dwRed or dwGreen or dwBlue );
              end;
            end;
            //
            // Proceed to the next two pixels.
            //
            inc( lpbTarget, 4 );
            inc( lpbSource, 4 );
            dec( i );
          end;

          //
          // Handle an odd width.
          //
          if ( gOddWidth ) then
          begin
            // Read in one source pixel.
            dwSourceTemp := PWord( lpbSource )^;

            // If this is not the color key ...
            if ( dwSourceTemp <> 0 ) then
            begin
              //
              // ... apply the alpha blend to it.
              //

              // Read in one target pixel.
              dwTargetTemp := PWord( lpbTarget )^;

              // Extract the red channels.
              dwTgtRed := ( dwTargetTemp shr 11 ) and $1F;
              dwSrcRed := ( dwSourceTemp shr 11 ) and $1F;

              // Extract the green channels.
              dwTgtGreen := ( dwTargetTemp shr 5 ) and $3F;
              dwSrcGreen := ( dwSourceTemp shr 5 ) and $3F;

              // Extract the blue channels.
              dwTgtBlue := dwTargetTemp and $1F;
              dwSrcBlue := dwSourceTemp and $1F;

              // Write the destination pixel.
              PWord( lpbTarget )^ := Word(
                ( ( ( iAlpha * ( dwSrcRed - dwTgtRed ) shr 8 ) + dwTgtRed ) shl 11 or
                ( ( iAlpha * ( dwSrcGreen - dwTgtGreen ) shr 8 ) + dwTgtGreen ) shl 5 or
                ( ( iAlpha * ( dwSrcBlue - dwTgtBlue ) shr 8 ) + dwTgtBlue ) ) );
            end;

            //
            // Proceed to next pixel.
            //
            inc( lpbTarget, 2 );
            inc( lpbSource, 2 );
          end;

          //
          // Proceed to the next line.
          //
          inc( lpbTarget, dwTargetPad );
          inc( lpbSource, dwSourcePad );
          dec( iHeight );
        until ( iHeight = 0 );
      end;

    {* 16 bit mode ( unknown ). This algorithm
     processes only one pixel at a time. *}
    rgbm16 :
      begin
        //
        // Determine the padding bytes for the target and the source.
        //
        dwTargetPad := ddsdTarget.lPitch - ( iWidth * 2 );
        dwSourcePad := ddsdSource.lPitch - ( iWidth * 2 );

        // Get the address of the target.
        lpbTarget := PByte( ddsdTarget.lpSurface );

        // Get the address of the source.
        lpbSource := PByte( ddsdSource.lpSurface );

        repeat
          // Reset the width.
          i := iWidth;

          //
          // Alpha-blend the pixels in the current row.
          //
          while ( i > 0 ) do
          begin
            // Read in the next source pixel.
            dwSourceTemp := PWord( lpbSource )^;

            // If the source pixel is not black ...
            if ( dwSourceTemp <> 0 ) then
            begin
              // ... read in the next target pixel.
              dwTargetTemp := PWord( lpbTarget )^;

              // Extract the red channels.
              dwTgtRed := dwTargetTemp and ddsdTarget.ddpfPixelFormat.dwRBitMask;
              dwSrcRed := dwSourceTemp and ddsdSource.ddpfPixelFormat.dwRBitMask;

              // Extract the green channels.
              dwTgtGreen := dwTargetTemp and ddsdTarget.ddpfPixelFormat.dwGBitMask;
              dwSrcGreen := dwSourceTemp and ddsdSource.ddpfPixelFormat.dwGBitMask;

              // Extract the blue channel.
              dwTgtBlue := dwTargetTemp and ddsdTarget.ddpfPixelFormat.dwBBitMask;
              dwSrcBlue := dwSourceTemp and ddsdSource.ddpfPixelFormat.dwBBitMask;

              // Calculate the alpha-blended red channel.
              dwRed := ( ( ( iAlpha * ( dwSrcRed - dwTgtRed ) ) shr 8 ) +
                dwTgtRed ) and ddsdTarget.ddpfPixelFormat.dwRBitMask;

              // Calculate the alpha-blended green channel.
              dwGreen := ( ( ( iAlpha * ( dwSrcGreen - dwTgtGreen ) ) shr 8 ) +
                dwTgtGreen ) and ddsdTarget.ddpfPixelFormat.dwGBitMask;

              // Calculate the alpha-blended blue channel.
              dwBlue := ( ( ( iAlpha * ( dwSrcBlue - dwTgtBlue ) ) shr 8 ) +
                dwTgtBlue ) and ddsdTarget.ddpfPixelFormat.dwBBitMask;

              // Write the destination pixel.
              PWord( lpbTarget )^ := ( dwRed or dwGreen or dwBlue );
            end;

            //
            // Proceed to the next pixel.
            //
            inc( lpbTarget, 2 );
            inc( lpbSource, 2 );
            dec( i );
          end;

          //
          // Proceed to the next line.
          //
          inc( lpbTarget, dwTargetPad );
          inc( lpbSource, dwSourcePad );
          dec( iHeight );
        until ( iHeight = 0 );
      end;

    {*24 bit mode. *}
    rgbm24 :
      begin
        //
        // Determine the padding bytes for the target and the source.
        //
        dwTargetPad := ddsdTarget.lPitch - ( iWidth * 3 );
        dwSourcePad := ddsdSource.lPitch - ( iWidth * 3 );

        // Get the address of the target.
        lpbTarget := PByte( ddsdTarget.lpSurface );

        // Get the address of the source.
        lpbSource := PByte( ddsdSource.lpSurface );

        repeat
          // Reset the width.
          i := iWidth;

          //
          // Alpha-blend the pixels in the current row.
          //
          while ( i > 0 ) do
          begin
            // Read in the next source pixel.
            dwSourceTemp := PLongWord( lpbSource )^;

            // If the source pixel is not black ...
            if ( ( dwSourceTemp and $FFFFFF ) <> 0 ) then
            begin
              // ... read in the next target pixel.
              dwTargetTemp := PLongWord( lpbTarget )^;

              // Extract the red channels.
              dwTgtRed := ( dwTargetTemp shr 16 ) and $FF;
              dwSrcRed := ( dwSourceTemp shr 16 ) and $FF;

              // Extract the green channels.
              dwTgtGreen := ( dwTargetTemp shr 8 ) and $FF;
              dwSrcGreen := ( dwSourceTemp shr 8 ) and $FF;

              // Extract the blue channel.
              dwTgtBlue := dwTargetTemp and $FF;
              dwSrcBlue := dwSourceTemp and $FF;

              // Calculate the destination pixel.
              dwTargetTemp :=
                ( ( ( iAlpha * ( dwSrcRed - dwTgtRed ) shr 8 ) + dwTgtRed ) shl 16 or
                ( ( iAlpha * ( dwSrcGreen - dwTgtGreen ) shr 8 ) + dwTgtGreen ) shl 8 or
                ( ( iAlpha * ( dwSrcBlue - dwTgtBlue ) shr 8 ) + dwTgtBlue ) );

              //
              // Write the destination pixel.
              //
              PWord( lpbTarget )^ := ( dwTargetTemp and $FFFF );
              inc( lpbTarget, 2 );
              lpbTarget^ := BYTE( dwTargetTemp shr 16 );
              inc( lpbTarget );
            end
              // If the source pixel is our color key ...
            else
            begin
              // ... advance the target pointer.
              inc( lpbTarget, 3 );
            end;

            // Proceed to the next source pixel.
            inc( lpbSource, 3 );
            dec( i );
          end;

          //
          // Proceed to the next line.
          //
          inc( lpbTarget, dwTargetPad );
          inc( lpbSource, dwSourcePad );
          dec( iHeight );
        until ( iHeight = 0 );
      end;

    {* 32 bit mode. }
    rgbm32 :
      begin
        //
        // Determine the padding bytes for the target and the source.
        //
        dwTargetPad := ddsdTarget.lPitch - ( iWidth * 4 );
        dwSourcePad := ddsdSource.lPitch - ( iWidth * 4 );

        // Get the address of the target.
        lpbTarget := PByte( ddsdTarget.lpSurface );

        // Get the address of the source.
        lpbSource := PByte( ddsdSource.lpSurface );

        repeat
          // Reset the width.
          i := iWidth;

          //
          // Alpha-blend the pixels in the current row.
          //
          while ( i > 0 ) do
          begin
            // Read in the next source pixel.
            dwSourceTemp := PLongWord( lpbSource )^;

            // If the source pixel is not black ...
            if ( ( dwSourceTemp and $FFFFFF ) <> 0 ) then
            begin
              // ... read in the next target pixel.
              dwTargetTemp := PLongWord( lpbTarget )^;

              // Extract the red channels.
              dwTgtRed := dwTargetTemp and $FF0000;
              dwSrcRed := dwSourceTemp and $FF0000;

              // Extract the green channels.
              dwTgtGreen := dwTargetTemp and $FF00;
              dwSrcGreen := dwSourceTemp and $FF00;

              // Extract the blue channel.
              dwTgtBlue := dwTargetTemp and $FF;
              dwSrcBlue := dwSourceTemp and $FF;

              // Calculate the destination pixel.
              dwTargetTemp :=
                ( ( ( ( iAlpha * ( dwSrcRed - dwTgtRed ) shr 8 ) + dwTgtRed ) and $FF0000 ) or
                ( ( ( iAlpha * ( dwSrcGreen - dwTgtGreen ) shr 8 ) + dwTgtGreen ) and $FF00 ) or
                ( ( iAlpha * ( dwSrcBlue - dwTgtBlue ) shr 8 ) + dwTgtBlue ) );

              // Write the destination pixel.
              PLongWord( lpbTarget )^ := dwTargetTemp;
            end;

            //
            // Proceed to the next pixel.
            //
            inc( lpbTarget, 4 );
            inc( lpbSource, 4 );
            dec( i );
          end;

          //
          // Proceed to the next line.
          //
          inc( lpbTarget, dwTargetPad );
          inc( lpbSource, dwSourcePad );
          dec( iHeight );
        until ( iHeight = 0 );
      end;
    { Invalid mode. }
  else
    begin
      Result := DD_FALSE;
      exit;
    end;
  end;

  // Unlock the target surface.
  iRet := m_pddsBackBuffer.Unlock( @rcDest );
  if ( iRet <> DD_OK ) then
  begin
    Result := iRet;
    exit;
  end;

  // Unlock the source surface.
  iRet := lpDDSSource.GetDDrawSurface.Unlock( lprcSource );
  if ( iRet <> DD_OK ) then
  begin
    Result := iRet;
    exit;
  end;

  // Return the result.
  result := iRet;
end;

function TDisplay.BltAlphaFast( iDestX, iDestY : integer; lpDDSSource : TSurface; lprcSource : PRECT;
  lwMode : TRGBMode ) : HResult;
var
  ddsdSource : TDDSURFACEDESC2;
  ddsdTarget : TDDSURFACEDESC2;
  rcDest : TRECT;
  dwTargetPad : LongWord;
  dwSourcePad : LongWord;
  dwTargetTemp : LongWord;
  dwSourceTemp : LongWord;
  wMask : WORD;
  dwDoubleMask : LongWord;
  lpbTarget : PBYTE;
  lpbSource : PBYTE;
  iWidth : integer;
  iHeight : integer;
  gOddWidth : boolean;
  iRet : integer;
  i : integer;
begin
  //
  // Determine the dimensions of the source surface.
  //
  if ( lprcSource <> nil ) then
  begin
    //
    // Get the width and height from the passed rectangle.
    //
    iWidth := lprcSource.right - lprcSource.left;
    iHeight := lprcSource.bottom - lprcSource.top;
  end
  else
  begin
    //
    // Get the with and height from the surface description.
    //
    FillChar( ddsdSource, SizeOf( ddsdSource ), 0 );
    ddsdSource.dwSize := SizeOf( ddsdSource );
    ddsdSource.dwFlags := DDSD_WIDTH or DDSD_HEIGHT;
    iRet := lpDDSSource.GetDDrawSurface.GetSurfaceDesc( ddsdSource );
    if ( iRet <> DD_OK ) then
    begin
      Result := iRet;
      exit;
    end;

    //
    // Remember the dimensions.
    //
    iWidth := ddsdSource.dwWidth;
    iHeight := ddsdSource.dwHeight;
  end;

  //
  // Calculate the rectangle to be locked in the target.
  //
  rcDest.left := iDestX;
  rcDest.top := iDestY;
  rcDest.right := iDestX + iWidth;
  rcDest.bottom := iDestY + iHeight;

  //
  // Lock down the destination surface.
  //
  FillChar( ddsdTarget, SizeOf( ddsdTarget ), 0 );
  ddsdTarget.dwSize := SizeOf( ddsdTarget );
  iRet := m_pddsBackBuffer.Lock( @rcDest, ddsdTarget, DDLOCK_WAIT, 0 );
  if ( iRet <> DD_OK ) then
  begin
    Result := iRet;
    exit;
  end;

  //
  // Lock down the source surface.
  //
  FillChar( ddsdSource, SizeOf( ddsdSource ), 0 );
  ddsdSource.dwSize := SizeOf( ddsdSource );
  iRet := lpDDSSource.GetDDrawSurface.Lock( lprcSource, ddsdSource, DDLOCK_WAIT, 0 );
  if ( iRet <> DD_OK ) then
  begin
    Result := iRet;
    exit;
  end;

  //
  // Perform the blit operation.
  //
  case lwMode of
    { 16 bit mode ( 555 ). This algorithm
       can process two pixels at once. }
    rgbm555 :
      begin
        //
        // Determine the padding bytes for the target and the source.
        //
        dwTargetPad := ddsdTarget.lPitch - ( iWidth * 2 );
        dwSourcePad := ddsdSource.lPitch - ( iWidth * 2 );

        // If the width is odd ...
        if ( iWidth and $01 ) = 1 then
        begin
          // ... set the flag ...
          gOddWidth := true;

          // ... and calculate the width.
          iWidth := ( iWidth - 1 ) div 2;
        end
          // If the width is even ...
        else
        begin
          // ... clear the flag ...
          gOddWidth := false;

          // ... and calculate the width.
          iWidth := iWidth div 2;
        end;

        // Get the address of the target.
        lpbTarget := PByte( ddsdTarget.lpSurface );

        // Get the address of the source.
        lpbSource := PByte( ddsdSource.lpSurface );

        repeat
          // Reset the width.
          i := iWidth;

          //
          // Alpha-blend two pixels at once.
          //
          while ( i > 0 ) do
          begin
            // Read in two source pixels.
            dwSourceTemp := PLongWord( lpbSource )^;

            // If the two source pixels are not both black ...
            if ( dwSourceTemp <> 0 ) then
            begin
              // ... read in two target pixels.
              dwTargetTemp := PLongWord( lpbTarget )^;

              // If the first source is black ...
              if ( ( dwSourceTemp shr 16 ) = 0 ) then
              begin
                // ... make sure the first target pixel won´t change.
                dwSourceTemp := dwSourceTemp or ( dwTargetTemp and $FFFF0000 );
              end;

              // If the second source is black ...
              if ( ( dwSourceTemp and $FFFF ) = 0 ) then
              begin
                // ... make sure the second target pixel won´t change.
                dwSourceTemp := dwSourceTemp or ( dwTargetTemp and $FFFF );
              end;

              // Calculate the destination pixels.
              dwTargetTemp := ( ( dwTargetTemp and $7BDE7BDE ) shr 1 ) +
                ( ( dwSourceTemp and $7BDE7BDE ) shr 1 );

              // Write the destination pixels.
              PLongWord( lpbTarget )^ := dwTargetTemp;
            end;

            //
            // Proceed to the next two pixels.
            //
            inc( lpbTarget, 4 );
            inc( lpbSource, 4 );
            dec( i );
          end;

          //
          // Handle an odd width.
          //
          if ( gOddWidth ) then
          begin
            // Read in one source pixel.
            dwSourceTemp := PWORD( lpbSource )^;

            // If this is not the color key ...
            if ( dwSourceTemp <> 0 ) then
            begin
              //
              // ... apply the alpha blend to it.
              //

              // Read in one target pixel.
              dwTargetTemp := PWORD( lpbTarget )^;

              // Write the destination pixel.
              PWORD( lpbTarget )^ := WORD(
                ( ( ( dwTargetTemp and $7BDE ) shr 1 ) +
                ( ( dwSourceTemp and $7BDE ) shr 1 ) ) );
            end;

            //
            // Proceed to next pixel.
            //
            inc( lpbTarget, 2 );
            inc( lpbSource, 2 );
          end;

          //
          // Proceed to the next line.
          //
          inc( lpbTarget, dwTargetPad );
          inc( lpbSource, dwSourcePad );
          dec( iHeight );
        until ( iHeight = 0 );
      end;

    { 16 bit mode ( 565 ). This algorithm
       can process two pixels at once. }
    rgbm565 :
      begin
        //
        // Determine the padding bytes for the target and the source.
        //
        dwTargetPad := ddsdTarget.lPitch - ( iWidth * 2 );
        dwSourcePad := ddsdSource.lPitch - ( iWidth * 2 );

        // If the width is odd ...
        if ( iWidth and $01 ) = 1 then
        begin
          // ... set the flag ...
          gOddWidth := true;

          // ... and calculate the width.
          iWidth := ( iWidth - 1 ) div 2;
        end
          // If the width is even ...
        else
        begin
          // ... clear the flag ...
          gOddWidth := false;

          // ... and calculate the width.
          iWidth := iWidth div 2;
        end;

        // Get the address of the target.
        lpbTarget := PByte( ddsdTarget.lpSurface );

        // Get the address of the source.
        lpbSource := PByte( ddsdSource.lpSurface );

        repeat
          // Reset the width.
          i := iWidth;

          //
          // Alpha-blend two pixels at once.
          //
          while ( i > 0 ) do
          begin
            // Read in two source pixels.
            dwSourceTemp := PLongWord( lpbSource )^;

            // If the two source pixels are not both black ...
            if ( dwSourceTemp <> 0 ) then
            begin
              // ... read in two target pixels.
              dwTargetTemp := PLongWord( lpbTarget )^;

              // If the first source is black ...
              if ( ( dwSourceTemp shr 16 ) = 0 ) then
              begin
                // ... make sure the first target pixel won´t change.
                dwSourceTemp := dwSourceTemp or ( dwTargetTemp and $FFFF0000 );
              end;

              // If the second source is black ...
              if ( ( dwSourceTemp and $FFFF ) = 0 ) then
              begin
                // ... make sure the second target pixel won´t change.
                dwSourceTemp := dwSourceTemp or ( dwTargetTemp and $FFFF );
              end;

              // Calculate the destination pixels.
              dwTargetTemp := ( ( dwTargetTemp and $F7DEF7DE ) shr 1 ) +
                ( ( dwSourceTemp and $F7DEF7DE ) shr 1 );

              // Write the destination pixels.
              PLongWord( lpbTarget )^ := dwTargetTemp;
            end;

            //
            // Proceed to the next two pixels.
            //
            inc( lpbTarget, 4 );
            inc( lpbSource, 4 );
            dec( i );
          end;

          //
          // Handle an odd width.
          //
          if ( gOddWidth ) then
          begin
            // Read in one source pixel.
            dwSourceTemp := PWord( lpbSource )^;

            // If this is not the color key ...
            if ( dwSourceTemp <> 0 ) then
            begin
              //
              // ... apply the alpha blend to it.
              //

              // Read in one target pixel.
              dwTargetTemp := PWord( lpbTarget )^;

              // Write the destination pixel.
              PWord( lpbTarget )^ := WORD(
                ( ( ( dwTargetTemp and $F7DE ) shr 1 ) +
                ( ( dwSourceTemp and $F7DE ) shr 1 ) ) );
            end;

            //
            // Proceed to next pixel.
            //
            inc( lpbTarget, 2 );
            inc( lpbSource, 2 );
          end;

          //
          // Proceed to the next line.
          //
          inc( lpbTarget, dwTargetPad );
          inc( lpbSource, dwSourcePad );
          dec( iHeight );
        until ( iHeight = 0 );
      end;

    { 16 bit mode ( unknown ). This algorithm
       can process two pixels at once. }
    rgbm16 :
      begin
        //
        // Determine the padding bytes for the target and the source.
        //
        dwTargetPad := ddsdTarget.lPitch - ( iWidth * 2 );
        dwSourcePad := ddsdSource.lPitch - ( iWidth * 2 );

        // If the width is odd ...
        if ( iWidth and $01 ) = 1 then
        begin
          // ... set the flag ...
          gOddWidth := true;

          // ... and calculate the width.
          iWidth := ( iWidth - 1 ) div 2;
        end
          // If the width is even ...
        else
        begin
          // ... clear the flag ...
          gOddWidth := false;

          // ... and calculate the width.
          iWidth := iWidth div 2;
        end;

        // Create the bit mask used to clear the lowest bit of each color channel´s mask.
        wMask := WORD( ( ddsdTarget.ddpfPixelFormat.dwRBitMask and
          ( ddsdTarget.ddpfPixelFormat.dwRBitMask shl 1 ) ) or
          ( ddsdTarget.ddpfPixelFormat.dwGBitMask and
          ( ddsdTarget.ddpfPixelFormat.dwGBitMask shl 1 ) ) or
          ( ddsdTarget.ddpfPixelFormat.dwBBitMask and
          ( ddsdTarget.ddpfPixelFormat.dwBBitMask shl 1 ) ) );

        // Create a double bit mask.
        dwDoubleMask := wMask or ( wMask shl 16 );

        // Get the address of the target.
        lpbTarget := PByte( ddsdTarget.lpSurface );

        // Get the address of the source.
        lpbSource := PByte( ddsdSource.lpSurface );

        repeat
          // Reset the width.
          i := iWidth;

          //
          // Alpha-blend two pixels at once.
          //
          while ( i > 0 ) do
          begin
            // Read in two source pixels.
            dwSourceTemp := PLongWord( lpbSource )^;

            // If the two source pixels are not both black ...
            if ( dwSourceTemp <> 0 ) then
            begin
              // ... read in two target pixels.
              dwTargetTemp := PLongWord( lpbTarget )^;

              // If the first source is black ...
              if ( ( dwSourceTemp shr 16 ) = 0 ) then
              begin
                // ... make sure the first target pixel won´t change.
                dwSourceTemp := dwSourceTemp or ( dwTargetTemp and $FFFF0000 );
              end;

              // If the second source is black ...
              if ( ( dwSourceTemp and $FFFF ) = 0 ) then
              begin
                // ... make sure the second target pixel won´t change.
                dwSourceTemp := dwSourceTemp or ( dwTargetTemp and $FFFF );
              end;

              // Calculate the destination pixels.
              dwTargetTemp := ( ( dwTargetTemp and dwDoubleMask ) shr 1 ) +
                ( ( dwSourceTemp and dwDoubleMask ) shr 1 );

              // Write the destination pixels.
              PLongWord( lpbTarget )^ := dwTargetTemp;
            end;

            //
            // Proceed to the next two pixels.
            //
            inc( lpbTarget, 4 );
            inc( lpbSource, 4 );
            dec( i );
          end;

          //
          // Handle an odd width.
          //
          if ( gOddWidth ) then
          begin
            // Read in one source pixel.
            dwSourceTemp := PWord( lpbSource )^;

            // If this is not the color key ...
            if ( dwSourceTemp <> 0 ) then
            begin
              //
              // ... apply the alpha blend to it.
              //

              // Read in one target pixel.
              dwTargetTemp := PWord( lpbTarget )^;

              // Write the destination pixel.
              PWord( lpbTarget )^ := WORD(
                ( ( ( dwTargetTemp and wMask ) shr 1 ) +
                ( ( dwSourceTemp and wMask ) shr 1 ) ) );
            end;

            //
            // Proceed to next pixel.
            //
            inc( lpbTarget, 2 );
            inc( lpbSource, 2 );
          end;

          //
          // Proceed to the next line.
          //
          inc( lpbTarget, dwTargetPad );
          inc( lpbSource, dwSourcePad );
          dec( iHeight );
        until ( iHeight = 0 );

      end;

    { 24 bit mode. }
    rgbm24 :
      begin
        //
        // Determine the padding bytes for the target and the source.
        //
        dwTargetPad := ddsdTarget.lPitch - ( iWidth * 3 );
        dwSourcePad := ddsdSource.lPitch - ( iWidth * 3 );

        // Get the address of the target.
        lpbTarget := PByte( ddsdTarget.lpSurface );

        // Get the address of the source.
        lpbSource := PByte( ddsdSource.lpSurface );

        repeat
          // Reset the width.
          i := iWidth;

          //
          // Alpha-blend the pixels in the current row.
          //
          while ( i > 0 ) do
          begin
            // Read in the next source pixel.
            dwSourceTemp := PLongWord( lpbSource )^;

            // If the source pixel is not black ...
            if ( ( dwSourceTemp and $00FFFFFF ) <> 0 ) then
            begin
              // ... read in the next target pixel.
              dwTargetTemp := PLongWord( lpbTarget )^;

              // Calculate the destination pixel.
              dwTargetTemp := ( ( dwTargetTemp and $FEFEFE ) shr 1 ) +
                ( ( dwSourceTemp and $FEFEFE ) shr 1 );

              //
              // Write the destination pixel.
              //
              PWord( lpbTarget )^ := dwTargetTemp;
              inc( lpbTarget, 2 );
              lpbTarget^ := ( dwTargetTemp shr 16 );
              inc( lpbTarget );
            end
              // If the source pixel is our color key ...
            else
            begin
              // ... advance the target pointer.
              inc( lpbTarget, 3 );
            end;

            // Proceed to the next source pixel.
            inc( lpbSource, 3 );
            dec( i );
          end;

          //
          // Proceed to the next line.
          //
          inc( lpbTarget, dwTargetPad );
          inc( lpbSource, dwSourcePad );
          dec( iHeight );
        until ( iHeight = 0 );
      end;

    { 32 bit mode. }
    rgbm32 :
      begin
        //
        // Determine the padding bytes for the target and the source.
        //
        dwTargetPad := ddsdTarget.lPitch - ( iWidth * 4 );
        dwSourcePad := ddsdSource.lPitch - ( iWidth * 4 );

        // Get the address of the target.
        lpbTarget := PBYTE( ddsdTarget.lpSurface );

        // Get the address of the source.
        lpbSource := PBYTE( ddsdSource.lpSurface );

        repeat
          // Reset the width.
          i := iWidth;

          //
          // Alpha-blend the pixels in the current row.
          //
          while ( i > 0 ) do
          begin
            // Read in the next source pixel.
            dwSourceTemp := PLongWord( lpbSource )^;

            // If the source pixel is not black ...
            if ( ( dwSourceTemp and $FFFFFF ) <> 0 ) then
            begin
              // ... read in the next target pixel.
              dwTargetTemp := PLongWord( lpbTarget )^;

              // Calculate the destination pixel.
              dwTargetTemp := ( ( dwTargetTemp and $FEFEFE ) shr 1 ) +
                ( ( dwSourceTemp and $FEFEFE ) shr 1 );

              // Write the destination pixel.
              PLongWord( lpbTarget )^ := dwTargetTemp;
            end;

            //
            // Proceed to the next pixel.
            //
            inc( lpbTarget, 4 );
            inc( lpbSource, 4 );
            dec( i );
          end;

          //
          // Proceed to the next line.
          //
          inc( lpbTarget, dwTargetPad );
          inc( lpbSource, dwSourcePad );
          dec( iHeight );
        until ( iHeight = 0 );

      end;

    { Invalid mode. }
  else
    begin
      Result := DD_FALSE;
      exit;
    end;
  end;

  // Unlock the target surface.
  iRet := m_pddsBackBuffer.Unlock( @rcDest );
  if ( iRet <> DD_OK ) then
  begin
    Result := iRet;
    exit;
  end;

  // Unlock the source surface.
  iRet := lpDDSSource.GetDDrawSurface.Unlock( lprcSource );
  if ( iRet <> DD_OK ) then
  begin
    Result := iRet;
    exit;
  end;

  // Return the result.
  result := iRet;
end;

function TDisplay.BltAlphaFastMMX( iDestX, iDestY : integer; lpDDSSource : TSurface; lprcSource : PRECT;
  lwMode : TRGBMode ) : HResult;
var
  iRet : integer;
begin
  iRet := DD_OK;
  
  // Return the result.
  result := iRet;
end;

function TDisplay.BltAlphaMMX( iDestX, iDestY : integer; lpDDSSource : TSurface; lprcSource : PRECT; iAlpha : integer;
  lwMode : TRGBMode ) : HResult;
var
  iRet : integer;
begin
  iRet := DD_OK;

  // Return the result.
  result := iRet;
end;

end.

