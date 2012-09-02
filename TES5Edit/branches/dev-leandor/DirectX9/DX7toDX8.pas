{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) 1999 Microsoft Corporation.  All Rights Reserved.           *}
{*                                                                            *}
{*  File:       dx7todx8.h                                                    *}
{*  Content:    DX7 to DX8 Direct3D aliases to aid porting DX7 apps to DX8    *}
{*                                                                            *}
{*  Direct3D 8.x Delphi adaptation by Alexey Barkovoy                         *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Modified: 16-Feb-2002                                                     *}
{*                                                                            *}
{*  Partly based upon :                                                       *}
{*    Direct3DX 7.0 Delphi adaptation by                                      *}
{*      Arne Schäpers, e-Mail: [look at www.delphi-jedi.org/DelphiGraphics/]  *}
{*                                                                            *}
{*  Lastest version can be downloaded from:                                   *}
{*    http://clootie.ru                                                       *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
{******************************************************************************}
{                                                                              }
{ Obtained through: Joint Endeavour of Delphi Innovators (Project JEDI)        }
{                                                                              }
{ The contents of this file are used with permission, subject to the Mozilla   }
{ Public License Version 1.1 (the "License"); you may not use this file except }
{ in compliance with the License. You may obtain a copy of the License at      }
{ http://www.mozilla.org/MPL/MPL-1.1.html                                      }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ Alternatively, the contents of this file may be used under the terms of the  }
{ GNU Lesser General Public License (the  "LGPL License"), in which case the   }
{ provisions of the LGPL License are applicable instead of those above.        }
{ If you wish to allow use of your version of this file only under the terms   }
{ of the LGPL License and not to allow others to use your version of this file }
{ under the MPL, indicate your decision by deleting  the provisions above and  }
{ replace  them with the notice and other provisions required by the LGPL      }
{ License.  If you do not delete the provisions above, a recipient may use     }
{ your version of this file under either the MPL or the LGPL License.          }
{                                                                              }
{ For more information about the LGPL: http://www.gnu.org/copyleft/lesser.html }
{                                                                              }
{******************************************************************************}

{$MINENUMSIZE 4}
{$ALIGN ON}

unit DX7toDX8;

interface

uses
  Windows, Direct3D8;

{$NOINCLUDE System}
{$NOINCLUDE SysInit}
{$NOINCLUDE Windows}
{$NOINCLUDE Direct3D8}
{$HPPEMIT '#include <dx7todx8.h>'}

///////////////////////////////////////////////////////////////////////////////
//
// d3d8types.h
//
///////////////////////////////////////////////////////////////////////////////


const
  D3DTRANSFORMSTATE_WORLD               = D3DTS_WORLD;
  {$EXTERNALSYM D3DTRANSFORMSTATE_WORLD}
  D3DTRANSFORMSTATE_VIEW                = D3DTS_VIEW;
  {$EXTERNALSYM D3DTRANSFORMSTATE_VIEW}
  D3DTRANSFORMSTATE_PROJECTION          = D3DTS_PROJECTION;
  {$EXTERNALSYM D3DTRANSFORMSTATE_PROJECTION}
  D3DTRANSFORMSTATE_WORLD1              = D3DTS_WORLD1;
  {$EXTERNALSYM D3DTRANSFORMSTATE_WORLD1}
  D3DTRANSFORMSTATE_WORLD2              = D3DTS_WORLD2;
  {$EXTERNALSYM D3DTRANSFORMSTATE_WORLD2}
  D3DTRANSFORMSTATE_WORLD3              = D3DTS_WORLD3;
  {$EXTERNALSYM D3DTRANSFORMSTATE_WORLD3}
  D3DTRANSFORMSTATE_TEXTURE0            = D3DTS_TEXTURE0;
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE0}
  D3DTRANSFORMSTATE_TEXTURE1            = D3DTS_TEXTURE1;
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE1}
  D3DTRANSFORMSTATE_TEXTURE2            = D3DTS_TEXTURE2;
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE2}
  D3DTRANSFORMSTATE_TEXTURE3            = D3DTS_TEXTURE3;
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE3}
  D3DTRANSFORMSTATE_TEXTURE4            = D3DTS_TEXTURE4;
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE4}
  D3DTRANSFORMSTATE_TEXTURE5            = D3DTS_TEXTURE5;
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE5}
  D3DTRANSFORMSTATE_TEXTURE6            = D3DTS_TEXTURE6;
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE6}
  D3DTRANSFORMSTATE_TEXTURE7            = D3DTS_TEXTURE7;
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE7}
  D3DTRANSFORMSTATE_FORCE_DWORD         = D3DTS_FORCE_DWORD;
  {$EXTERNALSYM D3DTRANSFORMSTATE_FORCE_DWORD}

  D3DRENDERSTATE_ZENABLE                = D3DRS_ZENABLE;
  {$EXTERNALSYM D3DRENDERSTATE_ZENABLE}
  D3DRENDERSTATE_FILLMODE               = D3DRS_FILLMODE;
  {$EXTERNALSYM D3DRENDERSTATE_FILLMODE}
  D3DRENDERSTATE_SHADEMODE              = D3DRS_SHADEMODE;
  {$EXTERNALSYM D3DRENDERSTATE_SHADEMODE}
  D3DRENDERSTATE_LINEPATTERN            = D3DRS_LINEPATTERN;
  {$EXTERNALSYM D3DRENDERSTATE_LINEPATTERN}
  D3DRENDERSTATE_ZWRITEENABLE           = D3DRS_ZWRITEENABLE;
  {$EXTERNALSYM D3DRENDERSTATE_ZWRITEENABLE}
  D3DRENDERSTATE_ALPHATESTENABLE        = D3DRS_ALPHATESTENABLE;
  {$EXTERNALSYM D3DRENDERSTATE_ALPHATESTENABLE}
  D3DRENDERSTATE_LASTPIXEL              = D3DRS_LASTPIXEL;
  {$EXTERNALSYM D3DRENDERSTATE_LASTPIXEL}
  D3DRENDERSTATE_SRCBLEND               = D3DRS_SRCBLEND;
  {$EXTERNALSYM D3DRENDERSTATE_SRCBLEND}
  D3DRENDERSTATE_DESTBLEND              = D3DRS_DESTBLEND;
  {$EXTERNALSYM D3DRENDERSTATE_DESTBLEND}
  D3DRENDERSTATE_CULLMODE               = D3DRS_CULLMODE;
  {$EXTERNALSYM D3DRENDERSTATE_CULLMODE}
  D3DRENDERSTATE_ZFUNC                  = D3DRS_ZFUNC;
  {$EXTERNALSYM D3DRENDERSTATE_ZFUNC}
  D3DRENDERSTATE_ALPHAREF               = D3DRS_ALPHAREF;
  {$EXTERNALSYM D3DRENDERSTATE_ALPHAREF}
  D3DRENDERSTATE_ALPHAFUNC              = D3DRS_ALPHAFUNC;
  {$EXTERNALSYM D3DRENDERSTATE_ALPHAFUNC}
  D3DRENDERSTATE_DITHERENABLE           = D3DRS_DITHERENABLE;
  {$EXTERNALSYM D3DRENDERSTATE_DITHERENABLE}
  D3DRENDERSTATE_ALPHABLENDENABLE       = D3DRS_ALPHABLENDENABLE;
  {$EXTERNALSYM D3DRENDERSTATE_ALPHABLENDENABLE}
  D3DRENDERSTATE_FOGENABLE              = D3DRS_FOGENABLE;
  {$EXTERNALSYM D3DRENDERSTATE_FOGENABLE}
  D3DRENDERSTATE_SPECULARENABLE         = D3DRS_SPECULARENABLE;
  {$EXTERNALSYM D3DRENDERSTATE_SPECULARENABLE}
  D3DRENDERSTATE_ZVISIBLE               = D3DRS_ZVISIBLE;
  {$EXTERNALSYM D3DRENDERSTATE_ZVISIBLE}
  D3DRENDERSTATE_FOGCOLOR               = D3DRS_FOGCOLOR;
  {$EXTERNALSYM D3DRENDERSTATE_FOGCOLOR}
  D3DRENDERSTATE_FOGTABLEMODE           = D3DRS_FOGTABLEMODE;
  {$EXTERNALSYM D3DRENDERSTATE_FOGTABLEMODE}
  D3DRENDERSTATE_FOGSTART               = D3DRS_FOGSTART;
  {$EXTERNALSYM D3DRENDERSTATE_FOGSTART}
  D3DRENDERSTATE_FOGEND                 = D3DRS_FOGEND;
  {$EXTERNALSYM D3DRENDERSTATE_FOGEND}
  D3DRENDERSTATE_FOGDENSITY             = D3DRS_FOGDENSITY;
  {$EXTERNALSYM D3DRENDERSTATE_FOGDENSITY}
  D3DRENDERSTATE_EDGEANTIALIAS          = D3DRS_EDGEANTIALIAS;
  {$EXTERNALSYM D3DRENDERSTATE_EDGEANTIALIAS}
  D3DRENDERSTATE_ZBIAS                  = D3DRS_ZBIAS;
  {$EXTERNALSYM D3DRENDERSTATE_ZBIAS}
  D3DRENDERSTATE_RANGEFOGENABLE         = D3DRS_RANGEFOGENABLE;
  {$EXTERNALSYM D3DRENDERSTATE_RANGEFOGENABLE}
  D3DRENDERSTATE_STENCILENABLE          = D3DRS_STENCILENABLE;
  {$EXTERNALSYM D3DRENDERSTATE_STENCILENABLE}
  D3DRENDERSTATE_STENCILFAIL            = D3DRS_STENCILFAIL;
  {$EXTERNALSYM D3DRENDERSTATE_STENCILFAIL}
  D3DRENDERSTATE_STENCILZFAIL           = D3DRS_STENCILZFAIL;
  {$EXTERNALSYM D3DRENDERSTATE_STENCILZFAIL}
  D3DRENDERSTATE_STENCILPASS            = D3DRS_STENCILPASS;
  {$EXTERNALSYM D3DRENDERSTATE_STENCILPASS}
  D3DRENDERSTATE_STENCILFUNC            = D3DRS_STENCILFUNC;
  {$EXTERNALSYM D3DRENDERSTATE_STENCILFUNC}
  D3DRENDERSTATE_STENCILREF             = D3DRS_STENCILREF;
  {$EXTERNALSYM D3DRENDERSTATE_STENCILREF}
  D3DRENDERSTATE_STENCILMASK            = D3DRS_STENCILMASK;
  {$EXTERNALSYM D3DRENDERSTATE_STENCILMASK}
  D3DRENDERSTATE_STENCILWRITEMASK       = D3DRS_STENCILWRITEMASK;
  {$EXTERNALSYM D3DRENDERSTATE_STENCILWRITEMASK}
  D3DRENDERSTATE_TEXTUREFACTOR          = D3DRS_TEXTUREFACTOR;
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREFACTOR}
  D3DRENDERSTATE_WRAP0                  = D3DRS_WRAP0;
  {$EXTERNALSYM D3DRENDERSTATE_WRAP0}
  D3DRENDERSTATE_WRAP1                  = D3DRS_WRAP1;
  {$EXTERNALSYM D3DRENDERSTATE_WRAP1}
  D3DRENDERSTATE_WRAP2                  = D3DRS_WRAP2;
  {$EXTERNALSYM D3DRENDERSTATE_WRAP2}
  D3DRENDERSTATE_WRAP3                  = D3DRS_WRAP3;
  {$EXTERNALSYM D3DRENDERSTATE_WRAP3}
  D3DRENDERSTATE_WRAP4                  = D3DRS_WRAP4;
  {$EXTERNALSYM D3DRENDERSTATE_WRAP4}
  D3DRENDERSTATE_WRAP5                  = D3DRS_WRAP5;
  {$EXTERNALSYM D3DRENDERSTATE_WRAP5}
  D3DRENDERSTATE_WRAP6                  = D3DRS_WRAP6;
  {$EXTERNALSYM D3DRENDERSTATE_WRAP6}
  D3DRENDERSTATE_WRAP7                  = D3DRS_WRAP7;
  {$EXTERNALSYM D3DRENDERSTATE_WRAP7}
  D3DRENDERSTATE_CLIPPING               = D3DRS_CLIPPING;
  {$EXTERNALSYM D3DRENDERSTATE_CLIPPING}
  D3DRENDERSTATE_LIGHTING               = D3DRS_LIGHTING;
  {$EXTERNALSYM D3DRENDERSTATE_LIGHTING}
//  D3DRENDERSTATE_EXTENTS                = D3DRS_EXTENTS; //BAA: Not found in SDK
  D3DRENDERSTATE_AMBIENT                = D3DRS_AMBIENT;
  {$EXTERNALSYM D3DRENDERSTATE_AMBIENT}
  D3DRENDERSTATE_FOGVERTEXMODE          = D3DRS_FOGVERTEXMODE;
  {$EXTERNALSYM D3DRENDERSTATE_FOGVERTEXMODE}
  D3DRENDERSTATE_COLORVERTEX            = D3DRS_COLORVERTEX;
  {$EXTERNALSYM D3DRENDERSTATE_COLORVERTEX}
  D3DRENDERSTATE_LOCALVIEWER            = D3DRS_LOCALVIEWER;
  {$EXTERNALSYM D3DRENDERSTATE_LOCALVIEWER}
  D3DRENDERSTATE_NORMALIZENORMALS       = D3DRS_NORMALIZENORMALS;
  {$EXTERNALSYM D3DRENDERSTATE_NORMALIZENORMALS}
  D3DRENDERSTATE_DIFFUSEMATERIALSOURCE  = D3DRS_DIFFUSEMATERIALSOURCE;
  {$EXTERNALSYM D3DRENDERSTATE_DIFFUSEMATERIALSOURCE}
  D3DRENDERSTATE_SPECULARMATERIALSOURCE = D3DRS_SPECULARMATERIALSOURCE;
  {$EXTERNALSYM D3DRENDERSTATE_SPECULARMATERIALSOURCE}
  D3DRENDERSTATE_AMBIENTMATERIALSOURCE  = D3DRS_AMBIENTMATERIALSOURCE;
  {$EXTERNALSYM D3DRENDERSTATE_AMBIENTMATERIALSOURCE}
  D3DRENDERSTATE_EMISSIVEMATERIALSOURCE = D3DRS_EMISSIVEMATERIALSOURCE;
  {$EXTERNALSYM D3DRENDERSTATE_EMISSIVEMATERIALSOURCE}
  D3DRENDERSTATE_VERTEXBLEND            = D3DRS_VERTEXBLEND;
  {$EXTERNALSYM D3DRENDERSTATE_VERTEXBLEND}
  D3DRENDERSTATE_CLIPPLANEENABLE        = D3DRS_CLIPPLANEENABLE;
  {$EXTERNALSYM D3DRENDERSTATE_CLIPPLANEENABLE}

//#define RGBA_MAKE                               D3DCOLOR_RGBA
function RGBA_MAKE(r, g, b, a: DWORD): TD3DColor;
{$EXTERNALSYM RGBA_MAKE}
//#define RGB_MAKE                                D3DCOLOR_XRGB
function RGB_MAKE(r, g, b: DWORD): TD3DColor;
{$EXTERNALSYM RGB_MAKE}
//#define D3DRGBA                                 D3DCOLOR_COLORVALUE
function D3DRGBA(r, g, b, a: Single): TD3DColor;
{$EXTERNALSYM D3DRGBA}
//#define D3DRGB(_r,_g,_b)                        D3DCOLOR_COLORVALUE(_r,_g,_b,1.f)
function D3DRGB(r, g, b: Single): TD3DColor;
{$EXTERNALSYM D3DRGB}

implementation

// #define RGBA_MAKE(r, g, b, a)   ((TD3DColor) (((a) << 24) | ((r) << 16) | ((g) << 8) | (b)))
function RGBA_MAKE(r, g, b, a: DWORD): TD3DColor;
begin
  Result := (a shl 24) or (r shl 16) or (g shl 8) or b;
end;

// #define RGB_MAKE(r, g, b)       ((TD3DColor) (((r) << 16) | ((g) << 8) | (b)))
function RGB_MAKE(r, g, b: DWORD): TD3DColor;
begin
  Result := (r shl 16) or (g shl 8) or b;
end;

// #define D3DRGBA(r, g, b, a) \
//     (  (((long)((a) * 255)) << 24) | (((long)((r) * 255)) << 16) \
//     |   (((long)((g) * 255)) << 8) | (long)((b) * 255) \
//    )
function D3DRGBA(r, g, b, a: Single): TD3DColor;
begin
  Result := (round(a * 255) shl 24) or (round(r * 255) shl 16)
                                    or (round(g * 255) shl 8)
                                    or round(b * 255);
end;

// #define D3DRGB(r, g, b) \
//     (0xff000000L | (((long)((r) * 255)) << 16) | (((long)((g) * 255)) << 8) | (long)((b) * 255))
function D3DRGB(r, g, b: Single): TD3DColor;
begin
  Result := $ff000000 or (round(r * 255) shl 16)
                      or (round(g * 255) shl 8)
                      or round(b * 255);
end;

end.
