{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      d3dtypes.h d3dcaps.h d3d.h                                    *}
{*  Content:    Direct3D8 include files                                       *}
{*                                                                            *}
{*  DirectX 9.0 Delphi / FreePascal adaptation by Alexey Barkovoy             *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Modified: 19-Jan-2004                                                     *}
{*                                                                            *}
{*  Partly based upon :                                                       *}
{*    DirectX 7.0 Object Pascal adaptation by                                 *}
{*      Erik Unger, e-Mail: DelphiDirectX@next-reality.com                    *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
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

///////////////////////////////////////////////////////////////////////////////
// Notes:
//----------------------------------------------------------------------------
// Possible input defines for this file, mapped to original C values:
//   DIRECT3D_VERSION_8 : DIRECT3D_VERSION = 0x0800,
//   DIRECT3D_VERSION_7 : DIRECT3D_VERSION = 0x0700,
//   DIRECT3D_VERSION_6 : DIRECT3D_VERSION = 0x0600,
//   DIRECT3D_VERSION_5 : DIRECT3D_VERSION = 0x0500,
//   DIRECT3D_VERSION_LESS_5 : DIRECT3D_VERSION < 0x0500,
//
// By default DIRECT3D_VERSION_7 (DIRECT3D_VERSION = 0x0700) is assumed
///////////////////////////////////////////////////////////////////////////////

unit Direct3D;

{$MINENUMSIZE 4}
{$ALIGN ON}

// Remove "dots" below to exclude DXFile interfaces - these interfaces
// are included for compatibility with original Erik Unger translation

// Assume for what Direct3D version we will compile headers
           // Compiling for Direct3D7 by default

// Emit conditionals to C++Builder compiler
  {$HPPEMIT '#define DIRECT3D_VERSION         0x0700'}

// Define symbols for '>=' comparision

// Define symbols for '<' comparision

interface

uses
  Windows, DXTypes, DirectDraw;

{$NOINCLUDE Windows}
{$NOINCLUDE DirectDraw}

{$HPPEMIT '#include "d3d.h"'}
{$HPPEMIT '#include "d3dtypes.h"'}
{$HPPEMIT '#include "d3dcaps.h"'}

(* TD3DValue is the fundamental Direct3D fractional data type *)

type
  TRefClsID = TGUID;

type
  D3DVALUE = DXTypes.D3DVALUE;
  {$EXTERNALSYM D3DVALUE}
  TD3DValue = DXTypes.TD3DValue;
  PD3DValue = DXTypes.PD3DValue;

  D3DFIXED = Longint;
  {$EXTERNALSYM D3DFIXED}
  TD3DFixed = D3DFIXED;

  float = TD3DValue;
  {$EXTERNALSYM float}

  D3DCOLOR = DXTypes.D3DCOLOR;
  {$EXTERNALSYM D3DCOLOR}
  TD3DColor = DXTypes.TD3DColor;
  PD3DColor = DXTypes.PD3DColor;

function D3DVal(val: Variant): Single;
{$EXTERNALSYM D3DVal}
function D3DDivide(a, b: Double): Single;
{$EXTERNALSYM D3DDivide}
function D3DMultiply(a, b: Double): Single;
{$EXTERNALSYM D3DMultiply}

(*
 * Format of CI colors is
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |    alpha      |         color index           |   fraction    |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *)

// #define CI_GETALPHA(ci)    ((ci) >> 24)
function CI_GETALPHA(ci: DWORD): DWORD;
{$EXTERNALSYM CI_GETALPHA}

// #define CI_GETINDEX(ci)    (((ci) >> 8) & 0xffff)
function CI_GETINDEX(ci: DWORD): DWORD;
{$EXTERNALSYM CI_GETINDEX}

// #define CI_GETFRACTION(ci) ((ci) & 0xff)
function CI_GETFRACTION(ci: DWORD): DWORD;
{$EXTERNALSYM CI_GETFRACTION}

// #define CI_ROUNDINDEX(ci)  CI_GETINDEX((ci) + 0x80)
function CI_ROUNDINDEX(ci: DWORD): DWORD;
{$EXTERNALSYM CI_ROUNDINDEX}

// #define CI_MASKALPHA(ci)   ((ci) & 0xffffff)
function CI_MASKALPHA(ci: DWORD): DWORD;
{$EXTERNALSYM CI_MASKALPHA}

// #define CI_MAKE(a, i, f)    (((a) << 24) | ((i) << 8) | (f))
function CI_MAKE(a,i,f: DWORD): DWORD;
{$EXTERNALSYM CI_MAKE}

(*
 * Format of RGBA colors is
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |    alpha      |      red      |     green     |     blue      |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *)

// #define RGBA_GETALPHA(rgb)      ((rgb) >> 24)
function RGBA_GETALPHA(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGBA_GETALPHA}

// #define RGBA_GETRED(rgb)        (((rgb) >> 16) & 0xff)
function RGBA_GETRED(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGBA_GETRED}

// #define RGBA_GETGREEN(rgb)      (((rgb) >> 8) & 0xff)
function RGBA_GETGREEN(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGBA_GETGREEN}

// #define RGBA_GETBLUE(rgb)       ((rgb) & 0xff)
function RGBA_GETBLUE(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGBA_GETBLUE}

// #define RGBA_MAKE(r, g, b, a)   ((TD3DColor) (((a) << 24) | ((r) << 16) | ((g) << 8) | (b)))
function RGBA_MAKE(r, g, b, a: DWORD): TD3DColor;
{$EXTERNALSYM RGBA_MAKE}

(* D3DRGB and D3DRGBA may be used as initialisers for D3DCOLORs
 * The float values must be in the range 0..1
 *)

// #define D3DRGB(r, g, b) \
//     (0xff000000L | (((long)((r) * 255)) << 16) | (((long)((g) * 255)) << 8) | (long)((b) * 255))
function D3DRGB(r, g, b: Single): TD3DColor;
{$EXTERNALSYM D3DRGB}

// #define D3DRGBA(r, g, b, a) \
//     (  (((long)((a) * 255)) << 24) | (((long)((r) * 255)) << 16) \
//     |   (((long)((g) * 255)) << 8) | (long)((b) * 255) \
//    )
function D3DRGBA(r, g, b, a: Single): TD3DColor;
{$EXTERNALSYM D3DRGBA}

(*
 * Format of RGB colors is
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |    ignored    |      red      |     green     |     blue      |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *)

// #define RGB_GETRED(rgb)         (((rgb) >> 16) & 0xff)
function RGB_GETRED(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGB_GETRED}

// #define RGB_GETGREEN(rgb)       (((rgb) >> 8) & 0xff)
function RGB_GETGREEN(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGB_GETGREEN}

// #define RGB_GETBLUE(rgb)        ((rgb) & 0xff)
function RGB_GETBLUE(rgb: TD3DColor): DWORD;
{$EXTERNALSYM RGB_GETBLUE}

// #define RGBA_SETALPHA(rgba, x) (((x) << 24) | ((rgba) & 0x00ffffff))
function RGBA_SETALPHA(rgba: TD3DColor; x: DWORD): TD3DColor;
{$EXTERNALSYM RGBA_SETALPHA}

// #define RGB_MAKE(r, g, b)       ((TD3DColor) (((r) << 16) | ((g) << 8) | (b)))
function RGB_MAKE(r, g, b: DWORD): TD3DColor;
{$EXTERNALSYM RGB_MAKE}

// #define RGBA_TORGB(rgba)       ((TD3DColor) ((rgba) & 0xffffff))
function RGBA_TORGB(rgba: TD3DColor): TD3DColor;
{$EXTERNALSYM RGBA_TORGB}

// #define RGB_TORGBA(rgb)        ((TD3DColor) ((rgb) | 0xff000000))
function RGB_TORGBA(rgb: TD3DColor): TD3DColor;
{$EXTERNALSYM RGB_TORGBA}

(*
 * Flags for Enumerate functions
 *)
const

(*
 * Stop the enumeration
 *)

  D3DENUMRET_CANCEL                        = DDENUMRET_CANCEL;
  {$EXTERNALSYM D3DENUMRET_CANCEL}

(*
 * Continue the enumeration
 *)

  D3DENUMRET_OK                            = DDENUMRET_OK;
  {$EXTERNALSYM D3DENUMRET_OK}

type
  TD3DValidateCallback = function (lpUserArg: Pointer;
      dwOffset: DWORD): HResult; stdcall;
  {$NODEFINE TD3DValidateCallback}
  {$HPPEMIT 'typedef LPD3DVALIDATECALLBACK TD3DValidateCallback;'}

  TD3DEnumTextureFormatsCallback = function (var lpDdsd: TDDSurfaceDesc;
      lpContext: Pointer): HResult; stdcall;
  {$NODEFINE TD3DEnumTextureFormatsCallback}
  {$HPPEMIT 'typedef LPD3DENUMTEXTUREFORMATSCALLBACK TD3DEnumTextureFormatsCallback;'}

  TD3DEnumPixelFormatsCallback = function (var lpDDPixFmt: TDDPixelFormat;
      lpContext: Pointer): HResult; stdcall;
  {$NODEFINE TD3DEnumPixelFormatsCallback}
  {$HPPEMIT 'typedef LPD3DENUMPIXELFORMATSCALLBACK TD3DEnumPixelFormatsCallback;'}

  PD3DMaterialHandle = ^TD3DMaterialHandle;
  TD3DMaterialHandle = DWORD;

  PD3DTextureHandle = ^TD3DTextureHandle;
  TD3DTextureHandle = DWORD;

  PD3DMatrixHandle = ^TD3DMatrixHandle;
  TD3DMatrixHandle = DWORD;


  PD3DColorValue = ^TD3DColorValue;
  _D3DCOLORVALUE = packed record
    case Integer of
    0: (
      r: TD3DValue;
      g: TD3DValue;
      b: TD3DValue;
      a: TD3DValue;
     );
    1: (
      dvR: TD3DValue;
      dvG: TD3DValue;
      dvB: TD3DValue;
      dvA: TD3DValue;
     );
  end {_D3DCOLORVALUE};
  {$EXTERNALSYM _D3DCOLORVALUE}
  D3DCOLORVALUE = _D3DCOLORVALUE;
  {$EXTERNALSYM D3DCOLORVALUE}
  TD3DColorValue = _D3DCOLORVALUE;


  PD3DRect = ^TD3DRect;
  _D3DRECT = packed record
    case Integer of
    0: (
      x1: LongInt;
      y1: LongInt;
      x2: LongInt;
      y2: LongInt;
     );
    1: (
      lX1: LongInt;
      lY1: LongInt;
      lX2: LongInt;
      lY2: LongInt;
     );
     2: (
       a: array[0..3] of LongInt;
     );
  end {_D3DRECT};
  {$EXTERNALSYM _D3DRECT}
  D3DRECT = _D3DRECT;
  {$EXTERNALSYM D3DRECT}
  TD3DRect = _D3DRECT;


  PD3DVector = ^TD3DVector;
  _D3DVECTOR = packed record
    case Integer of
    0: (
      x: TD3DValue;
      y: TD3DValue;
      z: TD3DValue;
     );
    1: (
      dvX: TD3DValue;
      dvY: TD3DValue;
      dvZ: TD3DValue;
     );
  end {_D3DVECTOR};
  {$EXTERNALSYM _D3DVECTOR}
  D3DVECTOR = _D3DVECTOR;
  {$EXTERNALSYM D3DVECTOR}
  TD3DVector = _D3DVECTOR;



(******************************************************************
 *                                                                *
 *   D3DVec.inl                                                   *
 *                                                                *
 *   float-valued 3D vector class for Direct3D.                   *
 *                                                                *
 *   Copyright (c) 1996-1998 Microsoft Corp. All rights reserved. *
 *                                                                *
 ******************************************************************)

    // Addition and subtraction
  function VectorAdd(const v1, v2: TD3DVector): TD3DVector;
  function VectorSub(const v1, v2: TD3DVector): TD3DVector;
    // Scalar multiplication and division
  function VectorMulS(const v: TD3DVector; s: TD3DValue): TD3DVector;
  function VectorDivS(const v: TD3DVector; s: TD3DValue): TD3DVector;
    // Memberwise multiplication and division
  function VectorMul(const v1, v2: TD3DVector): TD3DVector;
  function VectorDiv(const v1, v2: TD3DVector): TD3DVector;
    // Vector dominance
  function VectorSmaller(v1, v2: TD3DVector): Boolean;
  function VectorSmallerEqual(v1, v2: TD3DVector): Boolean;
    // Bitwise equality
  function VectorEqual(v1, v2: TD3DVector): Boolean;
    // Length-related functions
  function VectorSquareMagnitude(v: TD3DVector): TD3DValue;
  function VectorMagnitude(v: TD3DVector): TD3DValue;
    // Returns vector with same direction and unit length
  function VectorNormalize(const v: TD3DVector): TD3DVector;
    // Return min/max component of the input vector
  function VectorMin(v: TD3DVector): TD3DValue;
  function VectorMax(v: TD3DVector): TD3DValue;
    // Return memberwise min/max of input vectors
  function VectorMinimize(const v1, v2: TD3DVector): TD3DVector;
  function VectorMaximize(const v1, v2: TD3DVector): TD3DVector;
    // Dot and cross product
  function VectorDotProduct(v1, v2: TD3DVector): TD3DValue;
  function VectorCrossProduct(const v1, v2: TD3DVector): TD3DVector;

type
(*
 * Vertex data types supported in an ExecuteBuffer.
 *)

(*
 * Homogeneous vertices
 *)

  PD3DHVertex = ^TD3DHVertex;
  _D3DHVERTEX = packed record
    dwFlags: DWORD;        (* Homogeneous clipping flags *)
    case Integer of
    0: (
      hx: TD3DValue;
      hy: TD3DValue;
      hz: TD3DValue;
     );
    1: (
      dvHX: TD3DValue;
      dvHY: TD3DValue;
      dvHZ: TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DHVERTEX}
  D3DHVERTEX = _D3DHVERTEX;
  {$EXTERNALSYM D3DHVERTEX}
  TD3DHVertex = _D3DHVERTEX;


(*
 * Transformed/lit vertices
 *)

  PD3DTLVertex = ^TD3DTLVertex;
  _D3DTLVERTEX = packed record
    case Integer of
    0: (
      sx: TD3DValue;             (* Screen coordinates *)
      sy: TD3DValue;
      sz: TD3DValue;
      rhw: TD3DValue;            (* Reciprocal of homogeneous w *)
      color: TD3DColor;          (* Vertex color *)
      specular: TD3DColor;       (* Specular component of vertex *)
      tu: TD3DValue;             (* Texture coordinates *)
      tv: TD3DValue;
     );
    1: (
      dvSX: TD3DValue;
      dvSY: TD3DValue;
      dvSZ: TD3DValue;
      dvRHW: TD3DValue;
      dcColor: TD3DColor;
      dcSpecular: TD3DColor;
      dvTU: TD3DValue;
      dvTV: TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DTLVERTEX}
  D3DTLVERTEX = _D3DTLVERTEX;
  {$EXTERNALSYM D3DTLVERTEX}
  TD3DTLVertex = _D3DTLVERTEX;

(*
 * Untransformed/lit vertices
 *)

  PD3DLVertex = ^TD3DLVertex;
  _D3DLVERTEX = packed record
    case Integer of
    0: (
      x: TD3DValue;             (* Homogeneous coordinates *)
      y: TD3DValue;
      z: TD3DValue;
      dwReserved: DWORD;
      color: TD3DColor;         (* Vertex color *)
      specular: TD3DColor;      (* Specular component of vertex *)
      tu: TD3DValue;            (* Texture coordinates *)
      tv: TD3DValue;
     );
    1: (
      dvX: TD3DValue;
      dvY: TD3DValue;
      dvZ: TD3DValue;
      UNIONFILLER1d: DWORD;
      dcColor: TD3DColor;
      dcSpecular: TD3DColor;
      dvTU: TD3DValue;
      dvTV: TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DLVERTEX}
  D3DLVERTEX = _D3DLVERTEX;
  {$EXTERNALSYM D3DLVERTEX}
  TD3DLVertex = _D3DLVERTEX;


(*
 * Untransformed/unlit vertices
 *)

  PD3DVertex = ^TD3DVertex;
  _D3DVERTEX = packed record
    case Integer of
    0: (
      x: TD3DValue;             (* Homogeneous coordinates *)
      y: TD3DValue;
      z: TD3DValue;
      nx: TD3DValue;            (* Normal *)
      ny: TD3DValue;
      nz: TD3DValue;
      tu: TD3DValue;            (* Texture coordinates *)
      tv: TD3DValue;
     );
    1: (
      dvX: TD3DValue;
      dvY: TD3DValue;
      dvZ: TD3DValue;
      dvNX: TD3DValue;
      dvNY: TD3DValue;
      dvNZ: TD3DValue;
      dvTU: TD3DValue;
      dvTV: TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DVERTEX}
  D3DVERTEX = _D3DVERTEX;
  {$EXTERNALSYM D3DVERTEX}
  TD3DVertex = _D3DVERTEX;

(*
 * Matrix, viewport, and tranformation structures and definitions.
 *)

  PD3DMatrix = ^TD3DMatrix;
  _D3DMATRIX = packed record
    case integer of
      0 : (_11, _12, _13, _14: TD3DValue;
           _21, _22, _23, _24: TD3DValue;
           _31, _32, _33, _34: TD3DValue;
           _41, _42, _43, _44: TD3DValue);
      1 : (m : array [0..3, 0..3] of TD3DValue);
  end {_D3DMATRIX};
  {$EXTERNALSYM _D3DMATRIX}
  D3DMATRIX = _D3DMATRIX;
  {$EXTERNALSYM D3DMATRIX}
  TD3DMatrix = _D3DMATRIX;

  PD3DViewport = ^TD3DViewport;
  _D3DVIEWPORT = packed record
    dwSize: DWORD;
    dwX: DWORD;
    dwY: DWORD;                (* Top left *)
    dwWidth: DWORD;
    dwHeight: DWORD;           (* Dimensions *)
    dvScaleX: TD3DValue;       (* Scale homogeneous to screen *)
    dvScaleY: TD3DValue;       (* Scale homogeneous to screen *)
    dvMaxX: TD3DValue;         (* Min/max homogeneous x coord *)
    dvMaxY: TD3DValue;         (* Min/max homogeneous y coord *)
    dvMinZ: TD3DValue;
    dvMaxZ: TD3DValue;         (* Min/max homogeneous z coord *)
  end {_D3DVIEWPORT};
  {$EXTERNALSYM _D3DVIEWPORT}
  D3DVIEWPORT = _D3DVIEWPORT;
  {$EXTERNALSYM D3DVIEWPORT}
  TD3DViewport = _D3DVIEWPORT;


  PD3DViewport2 = ^TD3DViewport2;
  _D3DVIEWPORT2 = packed record
    dwSize: DWORD;
    dwX: DWORD;
    dwY: DWORD;                (* Viewport Top left *)
    dwWidth: DWORD;
    dwHeight: DWORD;           (* Viewport Dimensions *)
    dvClipX: TD3DValue;	       (* Top left of clip volume *)
    dvClipY: TD3DValue;
    dvClipWidth: TD3DValue;    (* Clip Volume Dimensions *)
    dvClipHeight: TD3DValue;
    dvMinZ: TD3DValue;         (* Min/max of clip Volume *)
    dvMaxZ: TD3DValue;
  end;
  {$EXTERNALSYM _D3DVIEWPORT2}
  D3DVIEWPORT2 = _D3DVIEWPORT2;
  {$EXTERNALSYM D3DVIEWPORT2}
  TD3DViewport2 = _D3DVIEWPORT2;
 // DIRECT3D_VERSION_5


  PD3DViewport7 = ^TD3DViewport7;
  _D3DVIEWPORT7 = packed record
    dwX: DWORD;
    dwY: DWORD;                (* Viewport Top left *)
    dwWidth: DWORD;
    dwHeight: DWORD;           (* Viewport Dimensions *)
    dvMinZ: TD3DValue;         (* Min/max of clip Volume *)
    dvMaxZ: TD3DValue;
  end;
  {$EXTERNALSYM _D3DVIEWPORT7}
  D3DVIEWPORT7 = _D3DVIEWPORT7;
  {$EXTERNALSYM D3DVIEWPORT7}
  TD3DViewport7 = _D3DVIEWPORT7;
 // DIRECT3D_VERSION_7

(*
 * Values for clip fields.
 *)


const
// Max number of user clipping planes, supported in D3D.
  D3DMAXUSERCLIPPLANES  = 32;
  {$EXTERNALSYM D3DMAXUSERCLIPPLANES}

// These bits could be ORed together to use with D3DRENDERSTATE_CLIPPLANEENABLE
//
  D3DCLIPPLANE0 = (1 shl 0);
  {$EXTERNALSYM D3DCLIPPLANE0}
  D3DCLIPPLANE1 = (1 shl 1);
  {$EXTERNALSYM D3DCLIPPLANE1}
  D3DCLIPPLANE2 = (1 shl 2);
  {$EXTERNALSYM D3DCLIPPLANE2}
  D3DCLIPPLANE3 = (1 shl 3);
  {$EXTERNALSYM D3DCLIPPLANE3}
  D3DCLIPPLANE4 = (1 shl 4);
  {$EXTERNALSYM D3DCLIPPLANE4}
  D3DCLIPPLANE5 = (1 shl 5);
  {$EXTERNALSYM D3DCLIPPLANE5}

 // DIRECT3D_VERSION_7

const
  D3DCLIP_LEFT                            = $00000001;
  {$EXTERNALSYM D3DCLIP_LEFT}
  D3DCLIP_RIGHT                           = $00000002;
  {$EXTERNALSYM D3DCLIP_RIGHT}
  D3DCLIP_TOP                             = $00000004;
  {$EXTERNALSYM D3DCLIP_TOP}
  D3DCLIP_BOTTOM                          = $00000008;
  {$EXTERNALSYM D3DCLIP_BOTTOM}
  D3DCLIP_FRONT                           = $00000010;
  {$EXTERNALSYM D3DCLIP_FRONT}
  D3DCLIP_BACK                            = $00000020;
  {$EXTERNALSYM D3DCLIP_BACK}
  D3DCLIP_GEN0                            = $00000040;
  {$EXTERNALSYM D3DCLIP_GEN0}
  D3DCLIP_GEN1                            = $00000080;
  {$EXTERNALSYM D3DCLIP_GEN1}
  D3DCLIP_GEN2                            = $00000100;
  {$EXTERNALSYM D3DCLIP_GEN2}
  D3DCLIP_GEN3                            = $00000200;
  {$EXTERNALSYM D3DCLIP_GEN3}
  D3DCLIP_GEN4                            = $00000400;
  {$EXTERNALSYM D3DCLIP_GEN4}
  D3DCLIP_GEN5                            = $00000800;
  {$EXTERNALSYM D3DCLIP_GEN5}

(*
 * Values for d3d status.
 *)

  D3DSTATUS_CLIPUNIONLEFT                 = D3DCLIP_LEFT;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONLEFT}
  D3DSTATUS_CLIPUNIONRIGHT                = D3DCLIP_RIGHT;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONRIGHT}
  D3DSTATUS_CLIPUNIONTOP                  = D3DCLIP_TOP;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONTOP}
  D3DSTATUS_CLIPUNIONBOTTOM               = D3DCLIP_BOTTOM;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONBOTTOM}
  D3DSTATUS_CLIPUNIONFRONT                = D3DCLIP_FRONT;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONFRONT}
  D3DSTATUS_CLIPUNIONBACK                 = D3DCLIP_BACK;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONBACK}
  D3DSTATUS_CLIPUNIONGEN0                 = D3DCLIP_GEN0;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONGEN0}
  D3DSTATUS_CLIPUNIONGEN1                 = D3DCLIP_GEN1;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONGEN1}
  D3DSTATUS_CLIPUNIONGEN2                 = D3DCLIP_GEN2;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONGEN2}
  D3DSTATUS_CLIPUNIONGEN3                 = D3DCLIP_GEN3;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONGEN3}
  D3DSTATUS_CLIPUNIONGEN4                 = D3DCLIP_GEN4;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONGEN4}
  D3DSTATUS_CLIPUNIONGEN5                 = D3DCLIP_GEN5;
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONGEN5}

  D3DSTATUS_CLIPINTERSECTIONLEFT          = $00001000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONLEFT}
  D3DSTATUS_CLIPINTERSECTIONRIGHT         = $00002000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONRIGHT}
  D3DSTATUS_CLIPINTERSECTIONTOP           = $00004000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONTOP}
  D3DSTATUS_CLIPINTERSECTIONBOTTOM        = $00008000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONBOTTOM}
  D3DSTATUS_CLIPINTERSECTIONFRONT         = $00010000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONFRONT}
  D3DSTATUS_CLIPINTERSECTIONBACK          = $00020000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONBACK}
  D3DSTATUS_CLIPINTERSECTIONGEN0          = $00040000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONGEN0}
  D3DSTATUS_CLIPINTERSECTIONGEN1          = $00080000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONGEN1}
  D3DSTATUS_CLIPINTERSECTIONGEN2          = $00100000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONGEN2}
  D3DSTATUS_CLIPINTERSECTIONGEN3          = $00200000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONGEN3}
  D3DSTATUS_CLIPINTERSECTIONGEN4          = $00400000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONGEN4}
  D3DSTATUS_CLIPINTERSECTIONGEN5          = $00800000;
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONGEN5}
  D3DSTATUS_ZNOTVISIBLE                   = $01000000;
  {$EXTERNALSYM D3DSTATUS_ZNOTVISIBLE}
(* Do not use 0x80000000 for any status flags in future as it is reserved *)

  D3DSTATUS_CLIPUNIONALL = (
            D3DSTATUS_CLIPUNIONLEFT or
            D3DSTATUS_CLIPUNIONRIGHT or
            D3DSTATUS_CLIPUNIONTOP or
            D3DSTATUS_CLIPUNIONBOTTOM or
            D3DSTATUS_CLIPUNIONFRONT or
            D3DSTATUS_CLIPUNIONBACK or
            D3DSTATUS_CLIPUNIONGEN0 or
            D3DSTATUS_CLIPUNIONGEN1 or
            D3DSTATUS_CLIPUNIONGEN2 or
            D3DSTATUS_CLIPUNIONGEN3 or
            D3DSTATUS_CLIPUNIONGEN4 or
            D3DSTATUS_CLIPUNIONGEN5);
  {$EXTERNALSYM D3DSTATUS_CLIPUNIONALL}

  D3DSTATUS_CLIPINTERSECTIONALL = (
            D3DSTATUS_CLIPINTERSECTIONLEFT or
            D3DSTATUS_CLIPINTERSECTIONRIGHT or
            D3DSTATUS_CLIPINTERSECTIONTOP or
            D3DSTATUS_CLIPINTERSECTIONBOTTOM or
            D3DSTATUS_CLIPINTERSECTIONFRONT or
            D3DSTATUS_CLIPINTERSECTIONBACK or
            D3DSTATUS_CLIPINTERSECTIONGEN0 or
            D3DSTATUS_CLIPINTERSECTIONGEN1 or
            D3DSTATUS_CLIPINTERSECTIONGEN2 or
            D3DSTATUS_CLIPINTERSECTIONGEN3 or
            D3DSTATUS_CLIPINTERSECTIONGEN4 or
            D3DSTATUS_CLIPINTERSECTIONGEN5);
  {$EXTERNALSYM D3DSTATUS_CLIPINTERSECTIONALL}

  D3DSTATUS_DEFAULT = (
            D3DSTATUS_CLIPINTERSECTIONALL or
            D3DSTATUS_ZNOTVISIBLE);
  {$EXTERNALSYM D3DSTATUS_DEFAULT}

(*
 * Options for direct transform calls
 *)

  D3DTRANSFORM_CLIPPED       = $00000001;
  {$EXTERNALSYM D3DTRANSFORM_CLIPPED}
  D3DTRANSFORM_UNCLIPPED     = $00000002;
  {$EXTERNALSYM D3DTRANSFORM_UNCLIPPED}

type
  PD3DTransformData = ^TD3DTransformData;
  _D3DTRANSFORMDATA = packed record
    dwSize: DWORD;
    lpIn: Pointer;             (* Input vertices *)
    dwInSize: DWORD;           (* Stride of input vertices *)
    lpOut: Pointer;            (* Output vertices *)
    dwOutSize: DWORD;          (* Stride of output vertices *)
    lpHOut: ^TD3DHVertex;      (* Output homogeneous vertices *)
    dwClip: DWORD;             (* Clipping hint *)
    dwClipIntersection: DWORD;
    dwClipUnion: DWORD;        (* Union of all clip flags *)
    drExtent: TD3DRect;        (* Extent of transformed vertices *)
  end;
  {$EXTERNALSYM _D3DTRANSFORMDATA}
  D3DTRANSFORMDATA = _D3DTRANSFORMDATA;
  {$EXTERNALSYM D3DTRANSFORMDATA}
  TD3DTransformData = _D3DTRANSFORMDATA;

(*
 * Structure defining position and direction properties for lighting.
 *)

  PD3DLightingElement = ^TD3DLightingElement;
  _D3DLIGHTINGELEMENT = packed record
    dvPosition: TD3DVector;           (* Lightable point in model space *)
    dvNormal: TD3DVector;             (* Normalised unit vector *)
  end;
  {$EXTERNALSYM _D3DLIGHTINGELEMENT}
  D3DLIGHTINGELEMENT = _D3DLIGHTINGELEMENT;
  {$EXTERNALSYM D3DLIGHTINGELEMENT}
  TD3DLightingElement = _D3DLIGHTINGELEMENT;

(*
 * Structure defining material properties for lighting.
 *)

  PD3DMaterial = ^TD3DMaterial;
  _D3DMATERIAL = packed record
    dwSize: DWORD;
    case Integer of
    0: (
      diffuse: TD3DColorValue;        (* Diffuse color RGBA *)
      ambient: TD3DColorValue;        (* Ambient color RGB *)
      specular: TD3DColorValue;       (* Specular 'shininess' *)
      emissive: TD3DColorValue;       (* Emissive color RGB *)
      power: TD3DValue;               (* Sharpness if specular highlight *)
      hTexture: TD3DTextureHandle;    (* Handle to texture map *)
      dwRampSize: DWORD;
     );
    1: (
      dcvDiffuse: TD3DColorValue;
      dcvAmbient: TD3DColorValue;
      dcvSpecular: TD3DColorValue;
      dcvEmissive: TD3DColorValue;
      dvPower: TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DMATERIAL}
  D3DMATERIAL = _D3DMATERIAL;
  {$EXTERNALSYM D3DMATERIAL}
  TD3DMaterial = _D3DMATERIAL;


  PD3DMaterial7 = ^TD3DMaterial7;
  _D3DMATERIAL7 = packed record
    case Integer of
    0: (
      diffuse: TD3DColorValue;        (* Diffuse color RGBA *)
      ambient: TD3DColorValue;        (* Ambient color RGB *)
      specular: TD3DColorValue;       (* Specular 'shininess' *)
      emissive: TD3DColorValue;       (* Emissive color RGB *)
      power: TD3DValue;               (* Sharpness if specular highlight *)
     );
    1: (
      dcvDiffuse: TD3DColorValue;
      dcvAmbient: TD3DColorValue;
      dcvSpecular: TD3DColorValue;
      dcvEmissive: TD3DColorValue;
      dvPower: TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DMATERIAL7}
  D3DMATERIAL7 = _D3DMATERIAL7;
  {$EXTERNALSYM D3DMATERIAL7}
  TD3DMaterial7 = _D3DMATERIAL7;

 // DIRECT3D_VERSION_7


  PD3DLightType = ^TD3DLightType;
  _D3DLIGHTTYPE = (
    D3DLIGHT_INVALID_0,
    D3DLIGHT_POINT,
    D3DLIGHT_SPOT,
    D3DLIGHT_DIRECTIONAL,
// Note: The following light type (D3DLIGHT_PARALLELPOINT)
// is no longer supported from D3D for DX7 onwards.
    D3DLIGHT_PARALLELPOINT
 // DIRECT3D_VERSION_LESS_5
  );
  {$EXTERNALSYM _D3DLIGHTTYPE}
  D3DLIGHTTYPE = _D3DLIGHTTYPE;
  {$EXTERNALSYM D3DLIGHTTYPE}
  TD3DLightType = _D3DLIGHTTYPE;

 //(DIRECT3D_VERSION < 0x0800)

(*
 * Structure defining a light source and its properties.
 *)

  PD3DLight = ^TD3DLight;
  _D3DLIGHT = packed record
    dwSize: DWORD;
    dltType: TD3DLightType;     (* Type of light source *)
    dcvColor: TD3DColorValue;   (* Color of light *)
    dvPosition: TD3DVector;     (* Position in world space *)
    dvDirection: TD3DVector;    (* Direction in world space *)
    dvRange: TD3DValue;         (* Cutoff range *)
    dvFalloff: TD3DValue;       (* Falloff *)
    dvAttenuation0: TD3DValue;  (* Constant attenuation *)
    dvAttenuation1: TD3DValue;  (* Linear attenuation *)
    dvAttenuation2: TD3DValue;  (* Quadratic attenuation *)
    dvTheta: TD3DValue;         (* Inner angle of spotlight cone *)
    dvPhi: TD3DValue;           (* Outer angle of spotlight cone *)
  end;
  {$EXTERNALSYM _D3DLIGHT}
  D3DLIGHT = _D3DLIGHT;
  {$EXTERNALSYM D3DLIGHT}
  TD3DLight = _D3DLIGHT;


  PD3DLight7 = ^TD3DLight7;
  _D3DLIGHT7 = packed record
    dltType: TD3DLightType;     (* Type of light source *)
    dcvDiffuse: TD3DColorValue; (* Diffuse color of light *)
    dcvSpecular: TD3DColorValue;(* Specular color of light *)
    dcvAmbient: TD3DColorValue; (* Ambient color of light *)
    dvPosition: TD3DVector;     (* Position in world space *)
    dvDirection: TD3DVector;    (* Direction in world space *)
    dvRange: TD3DValue;         (* Cutoff range *)
    dvFalloff: TD3DValue;       (* Falloff *)
    dvAttenuation0: TD3DValue;  (* Constant attenuation *)
    dvAttenuation1: TD3DValue;  (* Linear attenuation *)
    dvAttenuation2: TD3DValue;  (* Quadratic attenuation *)
    dvTheta: TD3DValue;         (* Inner angle of spotlight cone *)
    dvPhi: TD3DValue;           (* Outer angle of spotlight cone *)
  end;
  {$EXTERNALSYM _D3DLIGHT7}
  D3DLIGHT7 = _D3DLIGHT7;
  {$EXTERNALSYM D3DLIGHT7}
  TD3DLight7 = _D3DLIGHT7;

 // DIRECT3D_VERSION_7


(*
 * Structure defining a light source and its properties.
 *)

(* flags bits *)
const
  D3DLIGHT_ACTIVE       = $00000001;
  {$EXTERNALSYM D3DLIGHT_ACTIVE}
  D3DLIGHT_NO_SPECULAR  = $00000002;
  {$EXTERNALSYM D3DLIGHT_NO_SPECULAR}
  D3DLIGHT_ALL = D3DLIGHT_ACTIVE or D3DLIGHT_ACTIVE;
  {$EXTERNALSYM D3DLIGHT_ALL}

(* maximum valid light range *)
  D3DLIGHT_RANGE_MAX		= 1.8439088915e+18; //sqrt(FLT_MAX);
  {$EXTERNALSYM D3DLIGHT_RANGE_MAX}

type
  PD3DLight2 = ^TD3DLight2;
  _D3DLIGHT2 = packed record
    dwSize: DWORD;
    dltType: TD3DLightType;     (* Type of light source *)
    dcvColor: TD3DColorValue;   (* Color of light *)
    dvPosition: TD3DVector;     (* Position in world space *)
    dvDirection: TD3DVector;    (* Direction in world space *)
    dvRange: TD3DValue;         (* Cutoff range *)
    dvFalloff: TD3DValue;       (* Falloff *)
    dvAttenuation0: TD3DValue;  (* Constant attenuation *)
    dvAttenuation1: TD3DValue;  (* Linear attenuation *)
    dvAttenuation2: TD3DValue;  (* Quadratic attenuation *)
    dvTheta: TD3DValue;         (* Inner angle of spotlight cone *)
    dvPhi: TD3DValue;           (* Outer angle of spotlight cone *)
    dwFlags: DWORD;
  end;
  {$EXTERNALSYM _D3DLIGHT2}
  D3DLIGHT2 = _D3DLIGHT2;
  {$EXTERNALSYM D3DLIGHT2}
  TD3DLight2 = _D3DLIGHT2;

 // DIRECT3D_VERSION_5
  PD3DLightData = ^TD3DLightData;
  _D3DLIGHTDATA = packed record
    dwSize: DWORD;
    lpIn: ^TD3DLightingElement; (* Input positions and normals *)
    dwInSize: DWORD;            (* Stride of input elements *)
    lpOut: ^TD3DTLVertex;       (* Output colors *)
    dwOutSize: DWORD;           (* Stride of output colors *)
  end;
  {$EXTERNALSYM _D3DLIGHTDATA}
  D3DLIGHTDATA = _D3DLIGHTDATA;
  {$EXTERNALSYM D3DLIGHTDATA}
  TD3DLightData = _D3DLIGHTDATA;

(*
 * Before DX5, these values were in an enum called
 * TD3DColorModel. This was not correct, since they are
 * bit flags. A driver can surface either or both flags
 * in the dcmColorModel member of D3DDEVICEDESC.
 *)

type
  TD3DColorModel = DWORD;

const
  D3DCOLOR_MONO = 1;
  {$EXTERNALSYM D3DCOLOR_MONO}
  D3DCOLOR_RGB  = 2;
  {$EXTERNALSYM D3DCOLOR_RGB}

(*
 * Options for clearing
 *)

const
  D3DCLEAR_TARGET            = $00000001; (* Clear target surface *)
  {$EXTERNALSYM D3DCLEAR_TARGET}
  D3DCLEAR_ZBUFFER           = $00000002; (* Clear target z buffer *)
  {$EXTERNALSYM D3DCLEAR_ZBUFFER}
  D3DCLEAR_STENCIL           = $00000004; (* Clear stencil planes *)
  {$EXTERNALSYM D3DCLEAR_STENCIL}
 // DIRECT3D_VERSION_6

(*
 * Execute buffers are allocated via Direct3D.  These buffers may then
 * be filled by the application with instructions to execute along with
 * vertex data.
 *)

(*
 * Supported op codes for execute instructions.
 *)

type
  PD3DOpcode = ^TD3DOpcode;
  _D3DOPCODE = (
    D3DOP_INVALID_0,
    D3DOP_POINT,
    D3DOP_LINE,
    D3DOP_TRIANGLE,
    D3DOP_MATRIXLOAD,
    D3DOP_MATRIXMULTIPLY,
    D3DOP_STATETRANSFORM,
    D3DOP_STATELIGHT,
    D3DOP_STATERENDER,
    D3DOP_PROCESSVERTICES,
    D3DOP_TEXTURELOAD,
    D3DOP_EXIT,
    D3DOP_BRANCHFORWARD,
    D3DOP_SPAN,
    D3DOP_SETSTATUS);
  {$EXTERNALSYM _D3DOPCODE}
  D3DOPCODE = _D3DOPCODE;
  {$EXTERNALSYM D3DOPCODE}
  TD3DOpcode = _D3DOPCODE;

  PD3DInstruction = ^TD3DInstruction;
  _D3DINSTRUCTION = packed record
    bOpcode: Byte;   (* Instruction opcode *)
    bSize: Byte;     (* Size of each instruction data unit *)
    wCount: Word;    (* Count of instruction data units to follow *)
  end;
  {$EXTERNALSYM _D3DINSTRUCTION}
  D3DINSTRUCTION = _D3DINSTRUCTION;
  {$EXTERNALSYM D3DINSTRUCTION}
  TD3DInstruction = _D3DINSTRUCTION;

(*
 * Structure for texture loads
 *)

  PD3DTextureLoad = ^TD3DTextureLoad;
  _D3DTEXTURELOAD = packed record
    hDestTexture: TD3DTextureHandle;
    hSrcTexture: TD3DTextureHandle;
  end;
  {$EXTERNALSYM _D3DTEXTURELOAD}
  D3DTEXTURELOAD = _D3DTEXTURELOAD;
  {$EXTERNALSYM D3DTEXTURELOAD}
  TD3DTextureLoad = _D3DTEXTURELOAD;

(*
 * Structure for picking
 *)

  PD3DPickRecord = ^TD3DPickRecord;
  _D3DPICKRECORD = packed record
    bOpcode: Byte;
    bPad: Byte;
    dwOffset: DWORD;
    dvZ: TD3DValue;
  end;
  {$EXTERNALSYM _D3DPICKRECORD}
  D3DPICKRECORD = _D3DPICKRECORD;
  {$EXTERNALSYM D3DPICKRECORD}
  TD3DPickRecord = _D3DPICKRECORD;

(*
 * The following defines the rendering states which can be set in the
 * execute buffer.
 *)


  PD3DShadeMode = ^TD3DShadeMode;
  _D3DSHADEMODE = (
    D3DSHADE_INVALID_0,
    D3DSHADE_FLAT,
    D3DSHADE_GOURAUD,
    D3DSHADE_PHONG);
  {$EXTERNALSYM _D3DSHADEMODE}
  D3DSHADEMODE = _D3DSHADEMODE;
  {$EXTERNALSYM D3DSHADEMODE}
  TD3DShadeMode = _D3DSHADEMODE;

  PD3DFillMode = ^TD3DFillMode;
  _D3DFILLMODE = (
    D3DFILL_INVALID_0,
    D3DFILL_POINT,
    D3DFILL_WIREFRAME,
    D3DFILL_SOLID);
  {$EXTERNALSYM _D3DFILLMODE}
  D3DFILLMODE = _D3DFILLMODE;
  {$EXTERNALSYM D3DFILLMODE}
  TD3DFillMode = _D3DFILLMODE;

  PD3DLinePattern = ^TD3DLinePattern;
  _D3DLINEPATTERN = packed record
    wRepeatFactor: WORD;
    wLinePattern: WORD;
  end;
  {$EXTERNALSYM _D3DLINEPATTERN}
  D3DLINEPATTERN = _D3DLINEPATTERN;
  {$EXTERNALSYM D3DLINEPATTERN}
  TD3DLinePattern = _D3DLINEPATTERN;

 // DIRECT3D_VERSION_LESS_8

  PD3DTextureFilter = ^TD3DTextureFilter;
  _D3DTEXTUREFILTER = (
    D3DFILTER_INVALID_0,
    D3DFILTER_NEAREST,
    D3DFILTER_LINEAR,
    D3DFILTER_MIPNEAREST,
    D3DFILTER_MIPLINEAR,
    D3DFILTER_LINEARMIPNEAREST,
    D3DFILTER_LINEARMIPLINEAR);
  {$EXTERNALSYM _D3DTEXTUREFILTER}
  D3DTEXTUREFILTER = _D3DTEXTUREFILTER;
  {$EXTERNALSYM D3DTEXTUREFILTER}
  TD3DTextureFilter = _D3DTEXTUREFILTER;


  PD3DBlend = ^TD3DBlend;
  _D3DBLEND = (
    D3DBLEND_INVALID_0,
    D3DBLEND_ZERO,
    D3DBLEND_ONE,
    D3DBLEND_SRCCOLOR,
    D3DBLEND_INVSRCCOLOR,
    D3DBLEND_SRCALPHA,
    D3DBLEND_INVSRCALPHA,
    D3DBLEND_DESTALPHA,
    D3DBLEND_INVDESTALPHA,
    D3DBLEND_DESTCOLOR,
    D3DBLEND_INVDESTCOLOR,
    D3DBLEND_SRCALPHASAT,
    D3DBLEND_BOTHSRCALPHA,
    D3DBLEND_BOTHINVSRCALPHA);
  {$EXTERNALSYM _D3DBLEND}
  D3DBLEND = _D3DBLEND;
  {$EXTERNALSYM D3DBLEND}
  TD3DBlend = _D3DBLEND;

 // DIRECT3D_VERSION_LESS_8

  PD3DTextureBlend = ^TD3DTextureBlend;
  _D3DTEXTUREBLEND = (
    D3DTBLEND_INVALID_0,
    D3DTBLEND_DECAL,
    D3DTBLEND_MODULATE,
    D3DTBLEND_DECALALPHA,
    D3DTBLEND_MODULATEALPHA,
    D3DTBLEND_DECALMASK,
    D3DTBLEND_MODULATEMASK,
    D3DTBLEND_COPY
,
    D3DTBLEND_ADD
 // DIRECT3D_VERSION_5
  );
  {$EXTERNALSYM _D3DTEXTUREBLEND}
  D3DTEXTUREBLEND = _D3DTEXTUREBLEND;
  {$EXTERNALSYM D3DTEXTUREBLEND}
  TD3DTextureBlend = _D3DTEXTUREBLEND;


  PD3DTextureAddress = ^TD3DTextureAddress;
  _D3DTEXTUREADDRESS = (
    D3DTADDRESS_INVALID_0,
    D3DTADDRESS_WRAP,
    D3DTADDRESS_MIRROR,
    D3DTADDRESS_CLAMP
,
    D3DTADDRESS_BORDER
 // DIRECT3D_VERSION_5
  );
  {$EXTERNALSYM _D3DTEXTUREADDRESS}
  D3DTEXTUREADDRESS = _D3DTEXTUREADDRESS;
  {$EXTERNALSYM D3DTEXTUREADDRESS}
  TD3DTextureAddress = _D3DTEXTUREADDRESS;

  PD3DCull = ^TD3DCull;
  _D3DCULL = (
    D3DCULL_INVALID_0,
    D3DCULL_NONE,
    D3DCULL_CW,
    D3DCULL_CCW);
  {$EXTERNALSYM _D3DCULL}
  D3DCULL = _D3DCULL;
  {$EXTERNALSYM D3DCULL}
  TD3DCull = _D3DCULL;

  PD3DCmpFunc = ^TD3DCmpFunc;
  _D3DCMPFUNC = (
    D3DCMP_INVALID_0,
    D3DCMP_NEVER,
    D3DCMP_LESS,
    D3DCMP_EQUAL,
    D3DCMP_LESSEQUAL,
    D3DCMP_GREATER,
    D3DCMP_NOTEQUAL,
    D3DCMP_GREATEREQUAL,
    D3DCMP_ALWAYS);
  {$EXTERNALSYM _D3DCMPFUNC}
  D3DCMPFUNC = _D3DCMPFUNC;
  {$EXTERNALSYM D3DCMPFUNC}
  TD3DCmpFunc = _D3DCMPFUNC;

  PD3DStencilOp = ^TD3DStencilOp;
  _D3DSTENCILOP = (
    D3DSTENCILOP_INVALID_0,
    D3DSTENCILOP_KEEP,
    D3DSTENCILOP_ZERO,
    D3DSTENCILOP_REPLACE,
    D3DSTENCILOP_INCRSAT,
    D3DSTENCILOP_DECRSAT,
    D3DSTENCILOP_INVERT,
    D3DSTENCILOP_INCR,
    D3DSTENCILOP_DECR);
  {$EXTERNALSYM _D3DSTENCILOP}
  D3DSTENCILOP = _D3DSTENCILOP;
  {$EXTERNALSYM D3DSTENCILOP}
  TD3DStencilOp = _D3DSTENCILOP;
 // DIRECT3D_VERSION_6

  PD3DFogMode = ^TD3DFogMode;
  _D3DFOGMODE = (
    D3DFOG_NONE,
    D3DFOG_EXP,
    D3DFOG_EXP2
,
    D3DFOG_LINEAR
 // DIRECT3D_VERSION_5
  );
  {$EXTERNALSYM _D3DFOGMODE}
  D3DFOGMODE = _D3DFOGMODE;
  {$EXTERNALSYM D3DFOGMODE}
  TD3DFogMode = _D3DFOGMODE;

  PD3DZBufferType = ^TD3DZBufferType;
  _D3DZBUFFERTYPE = (
    D3DZB_FALSE,
    D3DZB_TRUE,   // Z buffering
    D3DZB_USEW);  // W buffering
  {$EXTERNALSYM _D3DZBUFFERTYPE}
  D3DZBUFFERTYPE = _D3DZBUFFERTYPE;
  {$EXTERNALSYM D3DZBUFFERTYPE}
  TD3DZBufferType = _D3DZBUFFERTYPE;
 // DIRECT3D_VERSION_6

 // DIRECT3D_VERSION_LESS_8

  PD3DAntialiasMode = ^TD3DAntialiasMode;
  _D3DANTIALIASMODE = (
    D3DANTIALIAS_NONE,
    D3DANTIALIAS_SORTDEPENDENT,
    D3DANTIALIAS_SORTINDEPENDENT);
  {$EXTERNALSYM _D3DANTIALIASMODE}
  D3DANTIALIASMODE = _D3DANTIALIASMODE;
  {$EXTERNALSYM D3DANTIALIASMODE}
  TD3DAntialiasMode = _D3DANTIALIASMODE;

// Vertex types supported by Direct3D
  PD3DVertexType = ^TD3DVertexType;
  _D3DVERTEXTYPE = (
    D3DVT_INVALID_0,
    D3DVT_VERTEX,
    D3DVT_LVERTEX,
    D3DVT_TLVERTEX);
  {$EXTERNALSYM _D3DVERTEXTYPE}
  D3DVERTEXTYPE = _D3DVERTEXTYPE;
  {$EXTERNALSYM D3DVERTEXTYPE}
  TD3DVertexType = _D3DVERTEXTYPE;


// Primitives supported by draw-primitive API
  PD3DPrimitiveType = ^TD3DPrimitiveType;
  _D3DPRIMITIVETYPE = (
    D3DPT_INVALID_0,
    D3DPT_POINTLIST,
    D3DPT_LINELIST,
    D3DPT_LINESTRIP,
    D3DPT_TRIANGLELIST,
    D3DPT_TRIANGLESTRIP,
    D3DPT_TRIANGLEFAN);
  {$EXTERNALSYM _D3DPRIMITIVETYPE}
  D3DPRIMITIVETYPE = _D3DPRIMITIVETYPE;
  {$EXTERNALSYM D3DPRIMITIVETYPE}
  TD3DPrimitiveType = _D3DPRIMITIVETYPE;

 // DIRECT3D_VERSION_LESS_8

 // DIRECT3D_VERSION_5

(*
 * Amount to add to a state to generate the override for that state.
 *)

const
  D3DSTATE_OVERRIDE_BIAS          = 256;
  {$EXTERNALSYM D3DSTATE_OVERRIDE_BIAS}

(*
 * A state which sets the override flag for the specified state type.
 *)

function D3DSTATE_OVERRIDE(StateType: DWORD): DWORD;
{$EXTERNALSYM D3DSTATE_OVERRIDE}

 // DIRECT3D_VERSION_8
type
  PD3DTransformStateType = ^TD3DTransformStateType;
  TD3DTransformStateType = DWORD;
const
  D3DTRANSFORMSTATE_WORLD         = TD3DTransformStateType(1);
  {$EXTERNALSYM D3DTRANSFORMSTATE_WORLD}
  D3DTRANSFORMSTATE_VIEW          = TD3DTransformStateType(2);
  {$EXTERNALSYM D3DTRANSFORMSTATE_VIEW}
  D3DTRANSFORMSTATE_PROJECTION    = TD3DTransformStateType(3);
  {$EXTERNALSYM D3DTRANSFORMSTATE_PROJECTION}
  D3DTRANSFORMSTATE_WORLD1        = TD3DTransformStateType(4);  // 2nd matrix to blend
  {$EXTERNALSYM D3DTRANSFORMSTATE_WORLD1}
  D3DTRANSFORMSTATE_WORLD2        = TD3DTransformStateType(5);  // 3rd matrix to blend
  {$EXTERNALSYM D3DTRANSFORMSTATE_WORLD2}
  D3DTRANSFORMSTATE_WORLD3        = TD3DTransformStateType(6);  // 4th matrix to blend
  {$EXTERNALSYM D3DTRANSFORMSTATE_WORLD3}
  D3DTRANSFORMSTATE_TEXTURE0      = TD3DTransformStateType(16);
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE0}
  D3DTRANSFORMSTATE_TEXTURE1      = TD3DTransformStateType(17);
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE1}
  D3DTRANSFORMSTATE_TEXTURE2      = TD3DTransformStateType(18);
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE2}
  D3DTRANSFORMSTATE_TEXTURE3      = TD3DTransformStateType(19);
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE3}
  D3DTRANSFORMSTATE_TEXTURE4      = TD3DTransformStateType(20);
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE4}
  D3DTRANSFORMSTATE_TEXTURE5      = TD3DTransformStateType(21);
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE5}
  D3DTRANSFORMSTATE_TEXTURE6      = TD3DTransformStateType(22);
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE6}
  D3DTRANSFORMSTATE_TEXTURE7      = TD3DTransformStateType(23);
  {$EXTERNALSYM D3DTRANSFORMSTATE_TEXTURE7}
 // DIRECT3D_VERSION_7


type
  PD3DLightStateType = ^TD3DLightStateType;
  _D3DLIGHTSTATETYPE = (
    D3DLIGHTSTATE_INVALID_0,
    D3DLIGHTSTATE_MATERIAL,
    D3DLIGHTSTATE_AMBIENT,
    D3DLIGHTSTATE_COLORMODEL,
    D3DLIGHTSTATE_FOGMODE,
    D3DLIGHTSTATE_FOGSTART,
    D3DLIGHTSTATE_FOGEND,
    D3DLIGHTSTATE_FOGDENSITY
,
    D3DLIGHTSTATE_COLORVERTEX
  {$EXTERNALSYM _D3DLIGHTSTATETYPE}
 // DIRECT3D_VERSION_6
  );
  D3DLIGHTSTATETYPE = _D3DLIGHTSTATETYPE;
  {$EXTERNALSYM D3DLIGHTSTATETYPE}
  TD3DLightStateType = _D3DLIGHTSTATETYPE;

type  
  PD3DRenderStateType = ^TD3DRenderStateType;
  TD3DRenderStateType = DWORD;

const
  D3DRENDERSTATE_ANTIALIAS          = 2;    (* D3DANTIALIASMODE *)
  {$EXTERNALSYM D3DRENDERSTATE_ANTIALIAS}
  D3DRENDERSTATE_TEXTUREPERSPECTIVE = 4;    (* TRUE for perspective correction *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREPERSPECTIVE}
  D3DRENDERSTATE_ZENABLE            = 7;    (* D3DZBUFFERTYPE (or TRUE/FALSE for legacy) *)
  {$EXTERNALSYM D3DRENDERSTATE_ZENABLE}
  D3DRENDERSTATE_FILLMODE           = 8;    (* D3DFILL_MODE        *)
  {$EXTERNALSYM D3DRENDERSTATE_FILLMODE}
  D3DRENDERSTATE_SHADEMODE          = 9;    (* D3DSHADEMODE *)
  {$EXTERNALSYM D3DRENDERSTATE_SHADEMODE}
  D3DRENDERSTATE_LINEPATTERN        = 10;   (* D3DLINEPATTERN *)
  {$EXTERNALSYM D3DRENDERSTATE_LINEPATTERN}
  D3DRENDERSTATE_ZWRITEENABLE       = 14;   (* TRUE to enable z writes *)
  {$EXTERNALSYM D3DRENDERSTATE_ZWRITEENABLE}
  D3DRENDERSTATE_ALPHATESTENABLE    = 15;   (* TRUE to enable alpha tests *)
  {$EXTERNALSYM D3DRENDERSTATE_ALPHATESTENABLE}
  D3DRENDERSTATE_LASTPIXEL          = 16;   (* TRUE for last-pixel on lines *)
  {$EXTERNALSYM D3DRENDERSTATE_LASTPIXEL}
  D3DRENDERSTATE_SRCBLEND           = 19;   (* D3DBLEND *)
  {$EXTERNALSYM D3DRENDERSTATE_SRCBLEND}
  D3DRENDERSTATE_DESTBLEND          = 20;   (* D3DBLEND *)
  {$EXTERNALSYM D3DRENDERSTATE_DESTBLEND}
  D3DRENDERSTATE_CULLMODE           = 22;   (* D3DCULL *)
  {$EXTERNALSYM D3DRENDERSTATE_CULLMODE}
  D3DRENDERSTATE_ZFUNC              = 23;   (* D3DCMPFUNC *)
  {$EXTERNALSYM D3DRENDERSTATE_ZFUNC}
  D3DRENDERSTATE_ALPHAREF           = 24;   (* D3DFIXED *)
  {$EXTERNALSYM D3DRENDERSTATE_ALPHAREF}
  D3DRENDERSTATE_ALPHAFUNC          = 25;   (* D3DCMPFUNC *)
  {$EXTERNALSYM D3DRENDERSTATE_ALPHAFUNC}
  D3DRENDERSTATE_DITHERENABLE       = 26;   (* TRUE to enable dithering *)
  {$EXTERNALSYM D3DRENDERSTATE_DITHERENABLE}
  D3DRENDERSTATE_ALPHABLENDENABLE   = 27;   (* TRUE to enable alpha blending *)
  {$EXTERNALSYM D3DRENDERSTATE_ALPHABLENDENABLE}
 // DIRECT3D_VERSION_5
  D3DRENDERSTATE_FOGENABLE          = 28;   (* TRUE to enable fog blending *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGENABLE}
  D3DRENDERSTATE_SPECULARENABLE     = 29;   (* TRUE to enable specular *)
  {$EXTERNALSYM D3DRENDERSTATE_SPECULARENABLE}
  D3DRENDERSTATE_ZVISIBLE           = 30;   (* TRUE to enable z checking *)
  {$EXTERNALSYM D3DRENDERSTATE_ZVISIBLE}
  D3DRENDERSTATE_STIPPLEDALPHA      = 33;   (* TRUE to enable stippled alpha (RGB device only) *)
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEDALPHA}
  D3DRENDERSTATE_FOGCOLOR           = 34;   (* D3DCOLOR *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGCOLOR}
  D3DRENDERSTATE_FOGTABLEMODE       = 35;   (* D3DFOGMODE *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGTABLEMODE}
  D3DRENDERSTATE_FOGSTART           = 36;   (* Fog start (for both vertex and pixel fog) *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGSTART}
  D3DRENDERSTATE_FOGEND             = 37;   (* Fog end      *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGEND}
  D3DRENDERSTATE_FOGDENSITY         = 38;   (* Fog density  *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGDENSITY}
 // DIRECT3D_VERSION_7
  D3DRENDERSTATE_EDGEANTIALIAS      = 40;   (* TRUE to enable edge antialiasing *)
  {$EXTERNALSYM D3DRENDERSTATE_EDGEANTIALIAS}
  D3DRENDERSTATE_COLORKEYENABLE     = 41;   (* TRUE to enable source colorkeyed textures *)
  {$EXTERNALSYM D3DRENDERSTATE_COLORKEYENABLE}
  D3DRENDERSTATE_ZBIAS              = 47;   (* LONG Z bias *)
  {$EXTERNALSYM D3DRENDERSTATE_ZBIAS}
  D3DRENDERSTATE_RANGEFOGENABLE     = 48;   (* Enables range-based fog *)
  {$EXTERNALSYM D3DRENDERSTATE_RANGEFOGENABLE}
 // DIRECT3D_VERSION_5

  D3DRENDERSTATE_STENCILENABLE      = 52;   (* BOOL enable/disable stenciling *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILENABLE}
  D3DRENDERSTATE_STENCILFAIL        = 53;   (* D3DSTENCILOP to do if stencil test fails *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILFAIL}
  D3DRENDERSTATE_STENCILZFAIL       = 54;   (* D3DSTENCILOP to do if stencil test passes and Z test fails *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILZFAIL}
  D3DRENDERSTATE_STENCILPASS        = 55;   (* D3DSTENCILOP to do if both stencil and Z tests pass *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILPASS}
  D3DRENDERSTATE_STENCILFUNC        = 56;   (* D3DCMPFUNC fn.  Stencil Test passes if ((ref & mask) stencilfn (stencil & mask)) is true *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILFUNC}
  D3DRENDERSTATE_STENCILREF         = 57;   (* Reference value used in stencil test *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILREF}
  D3DRENDERSTATE_STENCILMASK        = 58;   (* Mask value used in stencil test *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILMASK}
  D3DRENDERSTATE_STENCILWRITEMASK   = 59;   (* Write mask applied to values written to stencil buffer *)
  {$EXTERNALSYM D3DRENDERSTATE_STENCILWRITEMASK}
  D3DRENDERSTATE_TEXTUREFACTOR      = 60;   (* D3DCOLOR used for multi-texture blend *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREFACTOR}
 // DIRECT3D_VERSION_6


  (*
   * 128 values [128; 255] are reserved for texture coordinate wrap flags.
   * These are constructed with the D3DWRAP_U and D3DWRAP_V macros. Using
   * a flags word preserves forward compatibility with texture coordinates
   * that are >2D.
   *)
  D3DRENDERSTATE_WRAP0              = 128;  (* wrap for 1st texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP0}
  D3DRENDERSTATE_WRAP1              = 129;  (* wrap for 2nd texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP1}
  D3DRENDERSTATE_WRAP2              = 130;  (* wrap for 3rd texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP2}
  D3DRENDERSTATE_WRAP3              = 131;  (* wrap for 4th texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP3}
  D3DRENDERSTATE_WRAP4              = 132;  (* wrap for 5th texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP4}
  D3DRENDERSTATE_WRAP5              = 133;  (* wrap for 6th texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP5}
  D3DRENDERSTATE_WRAP6              = 134;  (* wrap for 7th texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP6}
  D3DRENDERSTATE_WRAP7              = 135;  (* wrap for 8th texture coord. set *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAP7}
 // DIRECT3D_VERSION_6
  D3DRENDERSTATE_CLIPPING            = 136;
  {$EXTERNALSYM D3DRENDERSTATE_CLIPPING}
  D3DRENDERSTATE_LIGHTING            = 137;
  {$EXTERNALSYM D3DRENDERSTATE_LIGHTING}
  D3DRENDERSTATE_EXTENTS             = 138;
  {$EXTERNALSYM D3DRENDERSTATE_EXTENTS}
  D3DRENDERSTATE_AMBIENT             = 139;
  {$EXTERNALSYM D3DRENDERSTATE_AMBIENT}
  D3DRENDERSTATE_FOGVERTEXMODE       = 140;
  {$EXTERNALSYM D3DRENDERSTATE_FOGVERTEXMODE}
  D3DRENDERSTATE_COLORVERTEX         = 141;
  {$EXTERNALSYM D3DRENDERSTATE_COLORVERTEX}
  D3DRENDERSTATE_LOCALVIEWER         = 142;
  {$EXTERNALSYM D3DRENDERSTATE_LOCALVIEWER}
  D3DRENDERSTATE_NORMALIZENORMALS    = 143;
  {$EXTERNALSYM D3DRENDERSTATE_NORMALIZENORMALS}
  D3DRENDERSTATE_COLORKEYBLENDENABLE = 144;
  {$EXTERNALSYM D3DRENDERSTATE_COLORKEYBLENDENABLE}
  D3DRENDERSTATE_DIFFUSEMATERIALSOURCE    = 145;
  {$EXTERNALSYM D3DRENDERSTATE_DIFFUSEMATERIALSOURCE}
  D3DRENDERSTATE_SPECULARMATERIALSOURCE   = 146;
  {$EXTERNALSYM D3DRENDERSTATE_SPECULARMATERIALSOURCE}
  D3DRENDERSTATE_AMBIENTMATERIALSOURCE    = 147;
  {$EXTERNALSYM D3DRENDERSTATE_AMBIENTMATERIALSOURCE}
  D3DRENDERSTATE_EMISSIVEMATERIALSOURCE   = 148;
  {$EXTERNALSYM D3DRENDERSTATE_EMISSIVEMATERIALSOURCE}
  D3DRENDERSTATE_VERTEXBLEND              = 151;
  {$EXTERNALSYM D3DRENDERSTATE_VERTEXBLEND}
  D3DRENDERSTATE_CLIPPLANEENABLE          = 152;
  {$EXTERNALSYM D3DRENDERSTATE_CLIPPLANEENABLE}

 // DIRECT3D_VERSION_7

//
// retired renderstates - not supported for DX7 interfaces
//
  D3DRENDERSTATE_TEXTUREHANDLE      = 1;    (* Texture handle for legacy interfaces (Texture;Texture2) *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREHANDLE}
  D3DRENDERSTATE_TEXTUREADDRESS     = 3;    (* D3DTEXTUREADDRESS  *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREADDRESS}
  D3DRENDERSTATE_WRAPU              = 5;    (* TRUE for wrapping in u *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAPU}
  D3DRENDERSTATE_WRAPV              = 6;    (* TRUE for wrapping in v *)
  {$EXTERNALSYM D3DRENDERSTATE_WRAPV}
  D3DRENDERSTATE_MONOENABLE         = 11;   (* TRUE to enable mono rasterization *)
  {$EXTERNALSYM D3DRENDERSTATE_MONOENABLE}
  D3DRENDERSTATE_ROP2               = 12;   (* ROP2 *)
  {$EXTERNALSYM D3DRENDERSTATE_ROP2}
  D3DRENDERSTATE_PLANEMASK          = 13;   (* DWORD physical plane mask *)
  {$EXTERNALSYM D3DRENDERSTATE_PLANEMASK}
  D3DRENDERSTATE_TEXTUREMAG         = 17;   (* D3DTEXTUREFILTER *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREMAG}
  D3DRENDERSTATE_TEXTUREMIN         = 18;   (* D3DTEXTUREFILTER *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREMIN}
  D3DRENDERSTATE_TEXTUREMAPBLEND    = 21;   (* D3DTEXTUREBLEND *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREMAPBLEND}
  D3DRENDERSTATE_SUBPIXEL           = 31;   (* TRUE to enable subpixel correction *)
  {$EXTERNALSYM D3DRENDERSTATE_SUBPIXEL}
  D3DRENDERSTATE_SUBPIXELX          = 32;   (* TRUE to enable correction in X only *)
  {$EXTERNALSYM D3DRENDERSTATE_SUBPIXELX}
  D3DRENDERSTATE_STIPPLEENABLE      = 39;   (* TRUE to enable stippling *)
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEENABLE}
  D3DRENDERSTATE_BORDERCOLOR        = 43;   (* Border color for texturing w/border *)
  {$EXTERNALSYM D3DRENDERSTATE_BORDERCOLOR}
  D3DRENDERSTATE_TEXTUREADDRESSU    = 44;   (* Texture addressing mode for U coordinate *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREADDRESSU}
  D3DRENDERSTATE_TEXTUREADDRESSV    = 45;   (* Texture addressing mode for V coordinate *)
  {$EXTERNALSYM D3DRENDERSTATE_TEXTUREADDRESSV}
  D3DRENDERSTATE_MIPMAPLODBIAS      = 46;   (* D3DVALUE Mipmap LOD bias *)
  {$EXTERNALSYM D3DRENDERSTATE_MIPMAPLODBIAS}
  D3DRENDERSTATE_ANISOTROPY         = 49;   (* Max. anisotropy. 1 = no anisotropy *)
  {$EXTERNALSYM D3DRENDERSTATE_ANISOTROPY}
 // DIRECT3D_VERSION_5
  D3DRENDERSTATE_FLUSHBATCH         = 50;   (* Explicit flush for DP batching (DX5 Only) *)
  {$EXTERNALSYM D3DRENDERSTATE_FLUSHBATCH}
  D3DRENDERSTATE_TRANSLUCENTSORTINDEPENDENT=51; (* BOOL enable sort-independent transparency *)
  {$EXTERNALSYM D3DRENDERSTATE_TRANSLUCENTSORTINDEPENDENT}
 // DIRECT3D_VERSION_6
  D3DRENDERSTATE_STIPPLEPATTERN00   = 64;   (* Stipple pattern 01...  *)
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN00}
  D3DRENDERSTATE_STIPPLEPATTERN01   = 65;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN01}
  D3DRENDERSTATE_STIPPLEPATTERN02   = 66;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN02}
  D3DRENDERSTATE_STIPPLEPATTERN03   = 67;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN03}
  D3DRENDERSTATE_STIPPLEPATTERN04   = 68;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN04}
  D3DRENDERSTATE_STIPPLEPATTERN05   = 69;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN05}
  D3DRENDERSTATE_STIPPLEPATTERN06   = 70;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN06}
  D3DRENDERSTATE_STIPPLEPATTERN07   = 71;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN07}
  D3DRENDERSTATE_STIPPLEPATTERN08   = 72;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN08}
  D3DRENDERSTATE_STIPPLEPATTERN09   = 73;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN09}
  D3DRENDERSTATE_STIPPLEPATTERN10   = 74;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN10}
  D3DRENDERSTATE_STIPPLEPATTERN11   = 75;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN11}
  D3DRENDERSTATE_STIPPLEPATTERN12   = 76;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN12}
  D3DRENDERSTATE_STIPPLEPATTERN13   = 77;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN13}
  D3DRENDERSTATE_STIPPLEPATTERN14   = 78;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN14}
  D3DRENDERSTATE_STIPPLEPATTERN15   = 79;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN15}
  D3DRENDERSTATE_STIPPLEPATTERN16   = 80;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN16}
  D3DRENDERSTATE_STIPPLEPATTERN17   = 81;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN17}
  D3DRENDERSTATE_STIPPLEPATTERN18   = 82;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN18}
  D3DRENDERSTATE_STIPPLEPATTERN19   = 83;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN19}
  D3DRENDERSTATE_STIPPLEPATTERN20   = 84;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN20}
  D3DRENDERSTATE_STIPPLEPATTERN21   = 85;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN21}
  D3DRENDERSTATE_STIPPLEPATTERN22   = 86;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN22}
  D3DRENDERSTATE_STIPPLEPATTERN23   = 87;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN23}
  D3DRENDERSTATE_STIPPLEPATTERN24   = 88;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN24}
  D3DRENDERSTATE_STIPPLEPATTERN25   = 89;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN25}
  D3DRENDERSTATE_STIPPLEPATTERN26   = 90;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN26}
  D3DRENDERSTATE_STIPPLEPATTERN27   = 91;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN27}
  D3DRENDERSTATE_STIPPLEPATTERN28   = 92;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN28}
  D3DRENDERSTATE_STIPPLEPATTERN29   = 93;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN29}
  D3DRENDERSTATE_STIPPLEPATTERN30   = 94;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN30}
  D3DRENDERSTATE_STIPPLEPATTERN31   = 95;
  {$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN31}

//
// retired renderstate names - the values are still used under new naming conventions
//
  D3DRENDERSTATE_FOGTABLESTART      = 36;   (* Fog table start    *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGTABLESTART}
  D3DRENDERSTATE_FOGTABLEEND        = 37;   (* Fog table end      *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGTABLEEND}
  D3DRENDERSTATE_FOGTABLEDENSITY    = 38;   (* Fog table density  *)
  {$EXTERNALSYM D3DRENDERSTATE_FOGTABLEDENSITY}



type
// Values for material source
  PD3DMateralColorSource = ^TD3DMateralColorSource;
  _D3DMATERIALCOLORSOURCE = (
    D3DMCS_MATERIAL,              // Color from material is used
    D3DMCS_COLOR1,                // Diffuse vertex color is used
    D3DMCS_COLOR2                 // Specular vertex color is used
  );
  {$EXTERNALSYM _D3DMATERIALCOLORSOURCE}
  D3DMATERIALCOLORSOURCE = _D3DMATERIALCOLORSOURCE;
  {$EXTERNALSYM D3DMATERIALCOLORSOURCE}
  TD3DMateralColorSource = _D3DMATERIALCOLORSOURCE;

const
  // For back-compatibility with legacy compilations
  D3DRENDERSTATE_BLENDENABLE = D3DRENDERSTATE_ALPHABLENDENABLE;
  {$EXTERNALSYM D3DRENDERSTATE_BLENDENABLE}
 // DIRECT3D_VERSION_5


// Bias to apply to the texture coordinate set to apply a wrap to.
   D3DRENDERSTATE_WRAPBIAS                = 128;
   {$EXTERNALSYM D3DRENDERSTATE_WRAPBIAS}

(* Flags to construct the WRAP render states *)
  D3DWRAP_U   = $00000001;
  {$EXTERNALSYM D3DWRAP_U}
  D3DWRAP_V   = $00000002;
  {$EXTERNALSYM D3DWRAP_V}

 // DIRECT3D_VERSION_6


(* Flags to construct the WRAP render states for 1D thru 4D texture coordinates *)
  D3DWRAPCOORD_0   = $00000001;    // same as D3DWRAP_U
  {$EXTERNALSYM D3DWRAPCOORD_0}
  D3DWRAPCOORD_1   = $00000002;    // same as D3DWRAP_V
  {$EXTERNALSYM D3DWRAPCOORD_1}
  D3DWRAPCOORD_2   = $00000004;
  {$EXTERNALSYM D3DWRAPCOORD_2}
  D3DWRAPCOORD_3   = $00000008;
  {$EXTERNALSYM D3DWRAPCOORD_3}

 // DIRECT3D_VERSION_7

 // DIRECT3D_VERSION_LESS_8

function D3DRENDERSTATE_STIPPLEPATTERN(y: Integer): TD3DRenderStateType;
{$EXTERNALSYM D3DRENDERSTATE_STIPPLEPATTERN}

type
  PD3DState = ^TD3DState;
  _D3DSTATE = packed record
    case Integer of
    0: (
      dtstTransformStateType: TD3DTransformStateType;
     );
     // DIRECT3D_VERSION_LESS_8
    1: (
      dlstLightStateType: TD3DLightStateType;
      dwArg: array [0..0] of DWORD;
     );
    2: (
      drstRenderStateType: TD3DRenderStateType;
      dvArg: array [0..0] of TD3DValue;
     );
  end;
  {$EXTERNALSYM _D3DSTATE}
  D3DSTATE = _D3DSTATE;
  {$EXTERNALSYM D3DSTATE}
  TD3DState = _D3DSTATE;

(*
 * Operation used to load matrices
 * hDstMat = hSrcMat
 *)
  PD3DMatrixLoad = ^TD3DMatrixLoad;
  _D3DMATRIXLOAD = packed record
    hDestMatrix: TD3DMatrixHandle;   (* Destination matrix *)
    hSrcMatrix: TD3DMatrixHandle;    (* Source matrix *)
  end;
  {$EXTERNALSYM _D3DMATRIXLOAD}
  D3DMATRIXLOAD = _D3DMATRIXLOAD;
  {$EXTERNALSYM D3DMATRIXLOAD}
  TD3DMatrixLoad = _D3DMATRIXLOAD;

(*
 * Operation used to multiply matrices
 * hDstMat = hSrcMat1 * hSrcMat2
 *)
  PD3DMatrixMultiply = ^TD3DMatrixMultiply;
  _D3DMATRIXMULTIPLY = packed record
    hDestMatrix: TD3DMatrixHandle;   (* Destination matrix *)
    hSrcMatrix1: TD3DMatrixHandle;   (* First source matrix *)
    hSrcMatrix2: TD3DMatrixHandle;   (* Second source matrix *)
  end;
  {$EXTERNALSYM _D3DMATRIXMULTIPLY}
  D3DMATRIXMULTIPLY = _D3DMATRIXMULTIPLY;
  {$EXTERNALSYM D3DMATRIXMULTIPLY}
  TD3DMatrixMultiply = _D3DMATRIXMULTIPLY;

(*
 * Operation used to transform and light vertices.
 *)
  PD3DProcessVertices = ^TD3DProcessVertices;
  _D3DPROCESSVERTICES = packed record
    dwFlags: DWORD;           (* Do we transform or light or just copy? *)
    wStart: WORD;             (* Index to first vertex in source *)
    wDest: WORD;              (* Index to first vertex in local buffer *)
    dwCount: DWORD;           (* Number of vertices to be processed *)
    dwReserved: DWORD;        (* Must be zero *)
  end;
  {$EXTERNALSYM _D3DPROCESSVERTICES}
  D3DPROCESSVERTICES = _D3DPROCESSVERTICES;
  {$EXTERNALSYM D3DPROCESSVERTICES}
  TD3DProcessVertices = _D3DPROCESSVERTICES;

const
  D3DPROCESSVERTICES_TRANSFORMLIGHT       = $00000000;
  {$EXTERNALSYM D3DPROCESSVERTICES_TRANSFORMLIGHT}
  D3DPROCESSVERTICES_TRANSFORM            = $00000001;
  {$EXTERNALSYM D3DPROCESSVERTICES_TRANSFORM}
  D3DPROCESSVERTICES_COPY                 = $00000002;
  {$EXTERNALSYM D3DPROCESSVERTICES_COPY}
  D3DPROCESSVERTICES_OPMASK               = $00000007;
  {$EXTERNALSYM D3DPROCESSVERTICES_OPMASK}

  D3DPROCESSVERTICES_UPDATEEXTENTS        = $00000008;
  {$EXTERNALSYM D3DPROCESSVERTICES_UPDATEEXTENTS}
  D3DPROCESSVERTICES_NOCOLOR              = $00000010;
  {$EXTERNALSYM D3DPROCESSVERTICES_NOCOLOR}


(*
 * State enumerants for per-stage texture processing.
 *)
type
  PD3DTextureStageStateType = ^TD3DTextureStageStateType;
  TD3DTextureStageStateType = DWORD;
const
  D3DTSS_COLOROP        =  1; (* D3DTEXTUREOP - per-stage blending controls for color channels *)
  {$EXTERNALSYM D3DTSS_COLOROP}
  D3DTSS_COLORARG1      =  2; (* D3DTA_* (texture arg) *)
  {$EXTERNALSYM D3DTSS_COLORARG1}
  D3DTSS_COLORARG2      =  3; (* D3DTA_* (texture arg) *)
  {$EXTERNALSYM D3DTSS_COLORARG2}
  D3DTSS_ALPHAOP        =  4; (* D3DTEXTUREOP - per-stage blending controls for alpha channel *)
  {$EXTERNALSYM D3DTSS_ALPHAOP}
  D3DTSS_ALPHAARG1      =  5; (* D3DTA_* (texture arg) *)
  {$EXTERNALSYM D3DTSS_ALPHAARG1}
  D3DTSS_ALPHAARG2      =  6; (* D3DTA_* (texture arg) *)
  {$EXTERNALSYM D3DTSS_ALPHAARG2}
  D3DTSS_BUMPENVMAT00   =  7; (* D3DVALUE (bump mapping matrix) *)
  {$EXTERNALSYM D3DTSS_BUMPENVMAT00}
  D3DTSS_BUMPENVMAT01   =  8; (* D3DVALUE (bump mapping matrix) *)
  {$EXTERNALSYM D3DTSS_BUMPENVMAT01}
  D3DTSS_BUMPENVMAT10   =  9; (* D3DVALUE (bump mapping matrix) *)
  {$EXTERNALSYM D3DTSS_BUMPENVMAT10}
  D3DTSS_BUMPENVMAT11   = 10; (* D3DVALUE (bump mapping matrix) *)
  {$EXTERNALSYM D3DTSS_BUMPENVMAT11}
  D3DTSS_TEXCOORDINDEX  = 11; (* identifies which set of texture coordinates index this texture *)
  {$EXTERNALSYM D3DTSS_TEXCOORDINDEX}
  D3DTSS_ADDRESS        = 12; (* D3DTEXTUREADDRESS for both coordinates *)
  {$EXTERNALSYM D3DTSS_ADDRESS}
  D3DTSS_ADDRESSU       = 13; (* D3DTEXTUREADDRESS for U coordinate *)
  {$EXTERNALSYM D3DTSS_ADDRESSU}
  D3DTSS_ADDRESSV       = 14; (* D3DTEXTUREADDRESS for V coordinate *)
  {$EXTERNALSYM D3DTSS_ADDRESSV}
  D3DTSS_BORDERCOLOR    = 15; (* D3DCOLOR *)
  {$EXTERNALSYM D3DTSS_BORDERCOLOR}
  D3DTSS_MAGFILTER      = 16; (* D3DTEXTUREMAGFILTER filter to use for magnification *)
  {$EXTERNALSYM D3DTSS_MAGFILTER}
  D3DTSS_MINFILTER      = 17; (* D3DTEXTUREMINFILTER filter to use for minification *)
  {$EXTERNALSYM D3DTSS_MINFILTER}
  D3DTSS_MIPFILTER      = 18; (* D3DTEXTUREMIPFILTER filter to use between mipmaps during minification *)
  {$EXTERNALSYM D3DTSS_MIPFILTER}
  D3DTSS_MIPMAPLODBIAS  = 19; (* D3DVALUE Mipmap LOD bias *)
  {$EXTERNALSYM D3DTSS_MIPMAPLODBIAS}
  D3DTSS_MAXMIPLEVEL    = 20; (* DWORD 0..(n-1) LOD index of largest map to use (0 == largest) *)
  {$EXTERNALSYM D3DTSS_MAXMIPLEVEL}
  D3DTSS_MAXANISOTROPY  = 21; (* DWORD maximum anisotropy *)
  {$EXTERNALSYM D3DTSS_MAXANISOTROPY}
  D3DTSS_BUMPENVLSCALE  = 22; (* D3DVALUE scale for bump map luminance *)
  {$EXTERNALSYM D3DTSS_BUMPENVLSCALE}
  D3DTSS_BUMPENVLOFFSET = 23; (* D3DVALUE offset for bump map luminance *)
  {$EXTERNALSYM D3DTSS_BUMPENVLOFFSET}
  D3DTSS_TEXTURETRANSFORMFLAGS = 24; (* D3DTEXTURETRANSFORMFLAGS controls texture transform *)
  {$EXTERNALSYM D3DTSS_TEXTURETRANSFORMFLAGS}

// Values, used with D3DTSS_TEXCOORDINDEX, to specify that the vertex data(position
// and normal in the camera space) should be taken as texture coordinates
// Low 16 bits are used to specify texture coordinate index, to take the WRAP mode from
//
  D3DTSS_TCI_PASSTHRU                             = $00000000;
  {$EXTERNALSYM D3DTSS_TCI_PASSTHRU}
  D3DTSS_TCI_CAMERASPACENORMAL                    = $00010000;
  {$EXTERNALSYM D3DTSS_TCI_CAMERASPACENORMAL}
  D3DTSS_TCI_CAMERASPACEPOSITION                  = $00020000;
  {$EXTERNALSYM D3DTSS_TCI_CAMERASPACEPOSITION}
  D3DTSS_TCI_CAMERASPACEREFLECTIONVECTOR          = $00030000;
  {$EXTERNALSYM D3DTSS_TCI_CAMERASPACEREFLECTIONVECTOR}

type
(*
 * Enumerations for COLOROP and ALPHAOP texture blending operations set in
 * texture processing stage controls in D3DRENDERSTATE.
 *)
  PD3DTextureOp = ^TD3DTextureOp;
  _D3DTEXTUREOP = (
    D3DTOP_INVALID_0,
// Control
    D3DTOP_DISABLE   ,      // disables stage
    D3DTOP_SELECTARG1,      // the default
    D3DTOP_SELECTARG2,

// Modulate
    D3DTOP_MODULATE  ,      // multiply args together
    D3DTOP_MODULATE2X,      // multiply and  1 bit
    D3DTOP_MODULATE4X,      // multiply and  2 bits

// Add
    D3DTOP_ADD        ,   // add arguments together
    D3DTOP_ADDSIGNED  ,   // add with -0.5 bias
    D3DTOP_ADDSIGNED2X,   // as above but left  1 bit
    D3DTOP_SUBTRACT   ,   // Arg1 - Arg2, with no saturation
    D3DTOP_ADDSMOOTH  ,   // add 2 args, subtract product
                          // Arg1 + Arg2 - Arg1*Arg2
                          // = Arg1 + (1-Arg1)*Arg2

// Linear alpha blend: Arg1*(Alpha) + Arg2*(1-Alpha)
    D3DTOP_BLENDDIFFUSEALPHA  , // iterated alpha
    D3DTOP_BLENDTEXTUREALPHA  , // texture alpha
    D3DTOP_BLENDFACTORALPHA   , // alpha from D3DRENDERSTATE_TEXTUREFACTOR
    // Linear alpha blend with pre-multiplied arg1 input: Arg1 + Arg2*(1-Alpha)
    D3DTOP_BLENDTEXTUREALPHAPM, // texture alpha
    D3DTOP_BLENDCURRENTALPHA  , // by alpha of current color

// Specular mapping
    D3DTOP_PREMODULATE           ,     // modulate with next texture before use
    D3DTOP_MODULATEALPHA_ADDCOLOR,     // Arg1.RGB + Arg1.A*Arg2.RGB
                                       // COLOROP only
    D3DTOP_MODULATECOLOR_ADDALPHA,     // Arg1.RGB*Arg2.RGB + Arg1.A
                                            // COLOROP only
    D3DTOP_MODULATEINVALPHA_ADDCOLOR,  // (1-Arg1.A)*Arg2.RGB + Arg1.RGB
                                       // COLOROP only
    D3DTOP_MODULATEINVCOLOR_ADDALPHA,  // (1-Arg1.RGB)*Arg2.RGB + Arg1.A
                                            // COLOROP only

// Bump mapping
    D3DTOP_BUMPENVMAP         , // per pixel env map perturbation
    D3DTOP_BUMPENVMAPLUMINANCE, // with luminance channel
    // This can do either diffuse or specular bump mapping with correct input.
    // Performs the function (Arg1.R*Arg2.R + Arg1.G*Arg2.G + Arg1.B*Arg2.B)
    // where each component has been scaled and offset to make it signed.
    // The result is replicated into all four (including alpha) channels.
    // This is a valid COLOROP only.
    D3DTOP_DOTPRODUCT3
  );
  {$EXTERNALSYM _D3DTEXTUREOP}
  D3DTEXTUREOP = _D3DTEXTUREOP;
  {$EXTERNALSYM D3DTEXTUREOP}
  TD3DTextureOp = _D3DTEXTUREOP;

(*
 * Values for COLORARG1,2 and ALPHAARG1,2 texture blending operations
 * set in texture processing stage controls in D3DRENDERSTATE.
 *)
const
  D3DTA_SELECTMASK        = $0000000f;  // mask for arg selector
  {$EXTERNALSYM D3DTA_SELECTMASK}
  D3DTA_DIFFUSE           = $00000000;  // select diffuse color
  {$EXTERNALSYM D3DTA_DIFFUSE}
  D3DTA_CURRENT           = $00000001;  // select result of previous stage
  {$EXTERNALSYM D3DTA_CURRENT}
  D3DTA_TEXTURE           = $00000002;  // select texture color
  {$EXTERNALSYM D3DTA_TEXTURE}
  D3DTA_TFACTOR           = $00000003;  // select RENDERSTATE_TEXTUREFACTOR
  {$EXTERNALSYM D3DTA_TFACTOR}
  D3DTA_SPECULAR          = $00000004;  // select specular color
  {$EXTERNALSYM D3DTA_SPECULAR}
  D3DTA_COMPLEMENT        = $00000010;  // take 1.0 - x
  {$EXTERNALSYM D3DTA_COMPLEMENT}
  D3DTA_ALPHAREPLICATE    = $00000020;  // replicate alpha to color components
  {$EXTERNALSYM D3DTA_ALPHAREPLICATE}

 // DIRECT3D_VERSION_LESS_8

(*
 *  IDirect3DTexture2 State Filter Types
 *)
type
  PD3DTextureMagFilter = ^TD3DTextureMagFilter;
  _D3DTEXTUREMAGFILTER = (
    D3DTFG_INVALID_0,
    D3DTFG_POINT        ,    // nearest
    D3DTFG_LINEAR       ,    // linear interpolation
    D3DTFG_FLATCUBIC    ,    // cubic
    D3DTFG_GAUSSIANCUBIC,    // different cubic kernel
    D3DTFG_ANISOTROPIC
  );
  {$EXTERNALSYM _D3DTEXTUREMAGFILTER}
  D3DTEXTUREMAGFILTER = _D3DTEXTUREMAGFILTER;
  {$EXTERNALSYM D3DTEXTUREMAGFILTER}
  TD3DTextureMagFilter = _D3DTEXTUREMAGFILTER;

  PD3DTextureMinFilter = ^TD3DTextureMinFilter;
  _D3DTEXTUREMINFILTER = (
    D3DTFN_INVALID_0,
    D3DTFN_POINT      ,    // nearest
    D3DTFN_LINEAR     ,    // linear interpolation
    D3DTFN_ANISOTROPIC
  );
  {$EXTERNALSYM _D3DTEXTUREMINFILTER}
  D3DTEXTUREMINFILTER = _D3DTEXTUREMINFILTER;
  {$EXTERNALSYM D3DTEXTUREMINFILTER}
  TD3DTextureMinFilter = _D3DTEXTUREMINFILTER;

  PD3DTextureMipFilter = ^TD3DTextureMipFilter;
  _D3DTEXTUREMIPFILTER = (
    D3DTFP_INVALID_0,
    D3DTFP_NONE   ,    // mipmapping disabled (use MAG filter)
    D3DTFP_POINT  ,    // nearest
    D3DTFP_LINEAR      // linear interpolation
  );
  {$EXTERNALSYM _D3DTEXTUREMIPFILTER}
  D3DTEXTUREMIPFILTER = _D3DTEXTUREMIPFILTER;
  {$EXTERNALSYM D3DTEXTUREMIPFILTER}
  TD3DTextureMipFilter = _D3DTEXTUREMIPFILTER;

 // DIRECT3D_VERSION_6


(*
 * Triangle flags
 *)

(*
 * Tri strip and fan flags.
 * START loads all three vertices
 * EVEN and ODD load just v3 with even or odd culling
 * START_FLAT contains a count from 0 to 29 that allows the
 * whole strip or fan to be culled in one hit.
 * e.g. for a quad len = 1
 *)
const
  D3DTRIFLAG_START                        = $00000000;
  {$EXTERNALSYM D3DTRIFLAG_START}
// #define D3DTRIFLAG_STARTFLAT(len) (len)         (* 0 < len < 30 *)
function D3DTRIFLAG_STARTFLAT(len: DWORD): DWORD;
{$EXTERNALSYM D3DTRIFLAG_STARTFLAT}

const
  D3DTRIFLAG_ODD                          = $0000001e;
  {$EXTERNALSYM D3DTRIFLAG_ODD}
  D3DTRIFLAG_EVEN                         = $0000001f;
  {$EXTERNALSYM D3DTRIFLAG_EVEN}

(*
 * Triangle edge flags
 * enable edges for wireframe or antialiasing
 *)
  D3DTRIFLAG_EDGEENABLE1                  = $00000100; (* v0-v1 edge *)
  {$EXTERNALSYM D3DTRIFLAG_EDGEENABLE1}
  D3DTRIFLAG_EDGEENABLE2                  = $00000200; (* v1-v2 edge *)
  {$EXTERNALSYM D3DTRIFLAG_EDGEENABLE2}
  D3DTRIFLAG_EDGEENABLE3                  = $00000400; (* v2-v0 edge *)
  {$EXTERNALSYM D3DTRIFLAG_EDGEENABLE3}
  D3DTRIFLAG_EDGEENABLETRIANGLE = (
      D3DTRIFLAG_EDGEENABLE1 or D3DTRIFLAG_EDGEENABLE2 or D3DTRIFLAG_EDGEENABLE3);
  {$EXTERNALSYM D3DTRIFLAG_EDGEENABLETRIANGLE}

(*
 * Primitive structures and related defines.  Vertex offsets are to types
 * TD3DVertex, TD3DLVertex, or TD3DTLVertex.
 *)

(*
 * Triangle list primitive structure
 *)
type
  PD3DTriangle = ^TD3DTriangle;
  _D3DTRIANGLE = packed record
    case Integer of
    0: (
      v1: WORD;            (* Vertex indices *)
      v2: WORD;
      v3: WORD;
      wFlags: WORD;        (* Edge (and other) flags *)
     );
    1: (
      wV1: WORD;
      wV2: WORD;
      wV3: WORD;
     );
  end;
  {$EXTERNALSYM _D3DTRIANGLE}
  D3DTRIANGLE = _D3DTRIANGLE;
  {$EXTERNALSYM D3DTRIANGLE}
  TD3DTriangle = _D3DTRIANGLE;

(*
 * Line strip structure.
 * The instruction count - 1 defines the number of line segments.
 *)
  PD3DLine = ^TD3DLine;
  _D3DLINE = packed record
    case Integer of
    0: (
      v1: WORD;            (* Vertex indices *)
      v2: WORD;
     );
    1: (
      wV1: WORD;
      wV2: WORD;
     );
  end;
  {$EXTERNALSYM _D3DLINE}
  D3DLINE = _D3DLINE;
  {$EXTERNALSYM D3DLINE}
  TD3DLine = _D3DLINE;

(*
 * Span structure
 * Spans join a list of points with the same y value.
 * If the y value changes, a new span is started.
 *)
  PD3DSpan = ^TD3DSpan;
  _D3DSPAN = packed record
    wCount: WORD;        (* Number of spans *)
    wFirst: WORD;        (* Index to first vertex *)
  end;
  {$EXTERNALSYM _D3DSPAN}
  D3DSPAN = _D3DSPAN;
  {$EXTERNALSYM D3DSPAN}
  TD3DSpan = _D3DSPAN;

(*
 * Point structure
 *)
  PD3DPoint = ^TD3DPoint;
  _D3DPOINT = packed record
    wCount: WORD;        (* number of points         *)
    wFirst: WORD;        (* index to first vertex    *)
  end;
  {$EXTERNALSYM _D3DPOINT}
  D3DPOINT = _D3DPOINT;
  {$EXTERNALSYM D3DPOINT}
  TD3DPoint = _D3DPOINT;

(*
 * Forward branch structure.
 * Mask is logically anded with the driver status mask
 * if the result equals 'value', the branch is taken.
 *)
  PD3DBranch = ^TD3DBranch;
  _D3DBRANCH = packed record
    dwMask: DWORD;         (* Bitmask against D3D status *)
    dwValue: DWORD;
    bNegate: BOOL;         (* TRUE to negate comparison *)
    dwOffset: DWORD;       (* How far to branch forward (0 for exit)*)
  end;
  {$EXTERNALSYM _D3DBRANCH}
  D3DBRANCH = _D3DBRANCH;
  {$EXTERNALSYM D3DBRANCH}
  TD3DBranch = _D3DBRANCH;

(*
 * Status used for set status instruction.
 * The D3D status is initialised on device creation
 * and is modified by all execute calls.
 *)
  PD3DStatus = ^TD3DStatus;
  _D3DSTATUS = packed record
    dwFlags: DWORD;        (* Do we set extents or status *)
    dwStatus: DWORD;       (* D3D status *)
    drExtent: TD3DRect;
  end;
  {$EXTERNALSYM _D3DSTATUS}
  D3DSTATUS = _D3DSTATUS;
  {$EXTERNALSYM D3DSTATUS}
  TD3DStatus = _D3DSTATUS;

const
  D3DSETSTATUS_STATUS    = $00000001;
  {$EXTERNALSYM D3DSETSTATUS_STATUS}
  D3DSETSTATUS_EXTENTS   = $00000002;
  {$EXTERNALSYM D3DSETSTATUS_EXTENTS}
  D3DSETSTATUS_ALL      = (D3DSETSTATUS_STATUS or D3DSETSTATUS_EXTENTS);
  {$EXTERNALSYM D3DSETSTATUS_ALL}

type
  PD3DClipStatus = ^TD3DClipStatus;
  _D3DCLIPSTATUS = packed record
    dwFlags : DWORD; (* Do we set 2d extents, 3D extents or status *)
    dwStatus : DWORD; (* Clip status *)
    minx, maxx : Single; (* X extents *)
    miny, maxy : Single; (* Y extents *)
    minz, maxz : Single; (* Z extents *)
  end;
  {$EXTERNALSYM _D3DCLIPSTATUS}
  D3DCLIPSTATUS = _D3DCLIPSTATUS;
  {$EXTERNALSYM D3DCLIPSTATUS}
  TD3DClipStatus = _D3DCLIPSTATUS;

const
  D3DCLIPSTATUS_STATUS        = $00000001;
  {$EXTERNALSYM D3DCLIPSTATUS_STATUS}
  D3DCLIPSTATUS_EXTENTS2      = $00000002;
  {$EXTERNALSYM D3DCLIPSTATUS_EXTENTS2}
  D3DCLIPSTATUS_EXTENTS3      = $00000004;
  {$EXTERNALSYM D3DCLIPSTATUS_EXTENTS3}
 // DIRECT3D_VERSION_5

(*
 * Statistics structure
 *)
type
  PD3DStats = ^TD3DStats;
  _D3DSTATS = packed record
    dwSize: DWORD;
    dwTrianglesDrawn: DWORD;
    dwLinesDrawn: DWORD;
    dwPointsDrawn: DWORD;
    dwSpansDrawn: DWORD;
    dwVerticesProcessed: DWORD;
  end;
  {$EXTERNALSYM _D3DSTATS}
  D3DSTATS = _D3DSTATS;
  {$EXTERNALSYM D3DSTATS}
  TD3DStats = _D3DSTATS;

(*
 * Execute options.
 * When calling using D3DEXECUTE_UNCLIPPED all the primitives
 * inside the buffer must be contained within the viewport.
 *)
const
  D3DEXECUTE_CLIPPED       = $00000001;
  {$EXTERNALSYM D3DEXECUTE_CLIPPED}
  D3DEXECUTE_UNCLIPPED     = $00000002;
  {$EXTERNALSYM D3DEXECUTE_UNCLIPPED}

type
  PD3DExecuteData = ^TD3DExecuteData;
  _D3DEXECUTEDATA = packed record
    dwSize: DWORD;
    dwVertexOffset: DWORD;
    dwVertexCount: DWORD;
    dwInstructionOffset: DWORD;
    dwInstructionLength: DWORD;
    dwHVertexOffset: DWORD;
    dsStatus: TD3DStatus;       (* Status after execute *)
  end;
  {$EXTERNALSYM _D3DEXECUTEDATA}
  D3DEXECUTEDATA = _D3DEXECUTEDATA;
  {$EXTERNALSYM D3DEXECUTEDATA}
  TD3DExecuteData = _D3DEXECUTEDATA;

(*
 * Palette flags.
 * This are or'ed with the peFlags in the PALETTEENTRYs passed to DirectDraw.
 *)

const
  D3DPAL_FREE     = $00;    (* Renderer may use this entry freely *)
  {$EXTERNALSYM D3DPAL_FREE}
  D3DPAL_READONLY = $40;    (* Renderer may not set this entry *)
  {$EXTERNALSYM D3DPAL_READONLY}
  D3DPAL_RESERVED = $80;    (* Renderer may not use this entry *)
  {$EXTERNALSYM D3DPAL_RESERVED}


type
  PD3DVertexBufferDesc = ^TD3DVertexBufferDesc;
  _D3DVERTEXBUFFERDESC = packed record
    dwSize : DWORD;
    dwCaps : DWORD;
    dwFVF : DWORD;
    dwNumVertices : DWORD;
  end;
  {$EXTERNALSYM _D3DVERTEXBUFFERDESC}
  D3DVERTEXBUFFERDESC = _D3DVERTEXBUFFERDESC;
  {$EXTERNALSYM D3DVERTEXBUFFERDESC}
  TD3DVertexBufferDesc = _D3DVERTEXBUFFERDESC;

const
(* These correspond to DDSCAPS_* flags *)
  D3DVBCAPS_SYSTEMMEMORY      = $00000800;
  {$EXTERNALSYM D3DVBCAPS_SYSTEMMEMORY}
  D3DVBCAPS_WRITEONLY         = $00010000;
  {$EXTERNALSYM D3DVBCAPS_WRITEONLY}
  D3DVBCAPS_OPTIMIZED         = $80000000;
  {$EXTERNALSYM D3DVBCAPS_OPTIMIZED}
  D3DVBCAPS_DONOTCLIP         = $00000001;
  {$EXTERNALSYM D3DVBCAPS_DONOTCLIP}

(* Vertex Operations for ProcessVertices *)
  D3DVOP_LIGHT      = (1 shl 10);
  {$EXTERNALSYM D3DVOP_LIGHT}
  D3DVOP_TRANSFORM  = (1 shl 0);
  {$EXTERNALSYM D3DVOP_TRANSFORM}
  D3DVOP_CLIP       = (1 shl 2);
  {$EXTERNALSYM D3DVOP_CLIP}
  D3DVOP_EXTENTS    = (1 shl 3);
  {$EXTERNALSYM D3DVOP_EXTENTS}


(* The maximum number of vertices user can pass to any d3d
   drawing function or to create vertex buffer with
*)
  D3DMAXNUMVERTICES  =  ((1 shl 16) - 1);
  {$EXTERNALSYM D3DMAXNUMVERTICES}
(* The maximum number of primitives user can pass to any d3d
   drawing function.
*)
  D3DMAXNUMPRIMITIVES = ((1 shl 16) - 1);
  {$EXTERNALSYM D3DMAXNUMPRIMITIVES}


(* Bits for dwFlags in ProcessVertices call *)
  D3DPV_DONOTCOPYDATA = (1 shl 0);
  {$EXTERNALSYM D3DPV_DONOTCOPYDATA}

 // DIRECT3D_VERSION_7
 // DIRECT3D_VERSION_LESS_8

//-------------------------------------------------------------------


// Flexible vertex format bits
//
  D3DFVF_RESERVED0        = $001;
  {$EXTERNALSYM D3DFVF_RESERVED0}
  D3DFVF_POSITION_MASK    = $00E;
  {$EXTERNALSYM D3DFVF_POSITION_MASK}
  D3DFVF_XYZ              = $002;
  {$EXTERNALSYM D3DFVF_XYZ}
  D3DFVF_XYZRHW           = $004;
  {$EXTERNALSYM D3DFVF_XYZRHW}
  D3DFVF_XYZB1            = $006;
  {$EXTERNALSYM D3DFVF_XYZB1}
  D3DFVF_XYZB2            = $008;
  {$EXTERNALSYM D3DFVF_XYZB2}
  D3DFVF_XYZB3            = $00a;
  {$EXTERNALSYM D3DFVF_XYZB3}
  D3DFVF_XYZB4            = $00c;
  {$EXTERNALSYM D3DFVF_XYZB4}
  D3DFVF_XYZB5            = $00e;
  {$EXTERNALSYM D3DFVF_XYZB5}

 // DIRECT3D_VERSION_7
  D3DFVF_NORMAL           = $010;
  {$EXTERNALSYM D3DFVF_NORMAL}
  D3DFVF_RESERVED1        = $020;
  {$EXTERNALSYM D3DFVF_RESERVED1}
  D3DFVF_DIFFUSE          = $040;
  {$EXTERNALSYM D3DFVF_DIFFUSE}
  D3DFVF_SPECULAR         = $080;
  {$EXTERNALSYM D3DFVF_SPECULAR}

  D3DFVF_TEXCOUNT_MASK    = $f00;
  {$EXTERNALSYM D3DFVF_TEXCOUNT_MASK}
  D3DFVF_TEXCOUNT_SHIFT   = 8;
  {$EXTERNALSYM D3DFVF_TEXCOUNT_SHIFT}
  D3DFVF_TEX0             = $000;
  {$EXTERNALSYM D3DFVF_TEX0}
  D3DFVF_TEX1             = $100;
  {$EXTERNALSYM D3DFVF_TEX1}
  D3DFVF_TEX2             = $200;
  {$EXTERNALSYM D3DFVF_TEX2}
  D3DFVF_TEX3             = $300;
  {$EXTERNALSYM D3DFVF_TEX3}
  D3DFVF_TEX4             = $400;
  {$EXTERNALSYM D3DFVF_TEX4}
  D3DFVF_TEX5             = $500;
  {$EXTERNALSYM D3DFVF_TEX5}
  D3DFVF_TEX6             = $600;
  {$EXTERNALSYM D3DFVF_TEX6}
  D3DFVF_TEX7             = $700;
  {$EXTERNALSYM D3DFVF_TEX7}
  D3DFVF_TEX8             = $800;
  {$EXTERNALSYM D3DFVF_TEX8}

  D3DFVF_RESERVED2        = $f000;  // 4 reserved bits
  {$EXTERNALSYM D3DFVF_RESERVED2}

 // DIRECT3D_VERSION_LESS_8

  D3DFVF_VERTEX = ( D3DFVF_XYZ or D3DFVF_NORMAL or D3DFVF_TEX1 );
  {$EXTERNALSYM D3DFVF_VERTEX}
  D3DFVF_LVERTEX = ( D3DFVF_XYZ or D3DFVF_RESERVED1 or D3DFVF_DIFFUSE or
                         D3DFVF_SPECULAR or D3DFVF_TEX1 );
  {$EXTERNALSYM D3DFVF_LVERTEX}
  D3DFVF_TLVERTEX = ( D3DFVF_XYZRHW or D3DFVF_DIFFUSE or D3DFVF_SPECULAR or
                          D3DFVF_TEX1 );
  {$EXTERNALSYM D3DFVF_TLVERTEX}

type
  PD3DDP_PtrStride = ^TD3DDP_PtrStride;
  _D3DDP_PTRSTRIDE = packed record
    lpvData : pointer;
    dwStride : DWORD;
  end;
  {$EXTERNALSYM _D3DDP_PTRSTRIDE}
  D3DDP_PTRSTRIDE = _D3DDP_PTRSTRIDE;
  {$EXTERNALSYM D3DDP_PTRSTRIDE}
  TD3DDP_PtrStride = _D3DDP_PTRSTRIDE;
  TD3DDPPtrStride = _D3DDP_PTRSTRIDE;
  PD3DDPPtrStride = ^TD3DDPPtrStride;

const
  D3DDP_MAXTEXCOORD = 8;
  {$EXTERNALSYM D3DDP_MAXTEXCOORD}

type
  PD3DDrawPrimitiveStridedData = ^TD3DDrawPrimitiveStridedData;
  _D3DDRAWPRIMITIVESTRIDEDDATA = packed record
    position : TD3DDP_PtrStride;
    normal : TD3DDP_PtrStride;
    diffuse : TD3DDP_PtrStride;
    specular : TD3DDP_PtrStride;
    textureCoords : array [0..D3DDP_MAXTEXCOORD-1] of TD3DDP_PtrStride;
  end;
  {$EXTERNALSYM _D3DDRAWPRIMITIVESTRIDEDDATA}
  D3DDRAWPRIMITIVESTRIDEDDATA = _D3DDRAWPRIMITIVESTRIDEDDATA;
  {$EXTERNALSYM D3DDRAWPRIMITIVESTRIDEDDATA}
  TD3DDrawPrimitiveStridedData = _D3DDRAWPRIMITIVESTRIDEDDATA;

//---------------------------------------------------------------------
// ComputeSphereVisibility return values
//
const
  D3DVIS_INSIDE_FRUSTUM      = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_FRUSTUM}
  D3DVIS_INTERSECT_FRUSTUM   = 1;
  {$EXTERNALSYM D3DVIS_INTERSECT_FRUSTUM}
  D3DVIS_OUTSIDE_FRUSTUM     = 2;
  {$EXTERNALSYM D3DVIS_OUTSIDE_FRUSTUM}
  D3DVIS_INSIDE_LEFT         = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_LEFT}
  D3DVIS_INTERSECT_LEFT      = (1 shl 2);
  {$EXTERNALSYM D3DVIS_INTERSECT_LEFT}
  D3DVIS_OUTSIDE_LEFT        = (2 shl 2);
  {$EXTERNALSYM D3DVIS_OUTSIDE_LEFT}
  D3DVIS_INSIDE_RIGHT        = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_RIGHT}
  D3DVIS_INTERSECT_RIGHT     = (1 shl 4);
  {$EXTERNALSYM D3DVIS_INTERSECT_RIGHT}
  D3DVIS_OUTSIDE_RIGHT       = (2 shl 4);
  {$EXTERNALSYM D3DVIS_OUTSIDE_RIGHT}
  D3DVIS_INSIDE_TOP          = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_TOP}
  D3DVIS_INTERSECT_TOP       = (1 shl 6);
  {$EXTERNALSYM D3DVIS_INTERSECT_TOP}
  D3DVIS_OUTSIDE_TOP         = (2 shl 6);
  {$EXTERNALSYM D3DVIS_OUTSIDE_TOP}
  D3DVIS_INSIDE_BOTTOM       = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_BOTTOM}
  D3DVIS_INTERSECT_BOTTOM    = (1 shl 8);
  {$EXTERNALSYM D3DVIS_INTERSECT_BOTTOM}
  D3DVIS_OUTSIDE_BOTTOM      = (2 shl 8);
  {$EXTERNALSYM D3DVIS_OUTSIDE_BOTTOM}
  D3DVIS_INSIDE_NEAR         = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_NEAR}
  D3DVIS_INTERSECT_NEAR      = (1 shl 10);
  {$EXTERNALSYM D3DVIS_INTERSECT_NEAR}
  D3DVIS_OUTSIDE_NEAR        = (2 shl 10);
  {$EXTERNALSYM D3DVIS_OUTSIDE_NEAR}
  D3DVIS_INSIDE_FAR          = 0;
  {$EXTERNALSYM D3DVIS_INSIDE_FAR}
  D3DVIS_INTERSECT_FAR       = (1 shl 12);
  {$EXTERNALSYM D3DVIS_INTERSECT_FAR}
  D3DVIS_OUTSIDE_FAR         = (2 shl 12);
  {$EXTERNALSYM D3DVIS_OUTSIDE_FAR}

  D3DVIS_MASK_FRUSTUM        = (3 shl 0);
  {$EXTERNALSYM D3DVIS_MASK_FRUSTUM}
  D3DVIS_MASK_LEFT           = (3 shl 2);
  {$EXTERNALSYM D3DVIS_MASK_LEFT}
  D3DVIS_MASK_RIGHT          = (3 shl 4);
  {$EXTERNALSYM D3DVIS_MASK_RIGHT}
  D3DVIS_MASK_TOP            = (3 shl 6);
  {$EXTERNALSYM D3DVIS_MASK_TOP}
  D3DVIS_MASK_BOTTOM         = (3 shl 8);
  {$EXTERNALSYM D3DVIS_MASK_BOTTOM}
  D3DVIS_MASK_NEAR           = (3 shl 10);
  {$EXTERNALSYM D3DVIS_MASK_NEAR}
  D3DVIS_MASK_FAR            = (3 shl 12);
  {$EXTERNALSYM D3DVIS_MASK_FAR}

 // DIRECT3D_VERSION_6


// To be used with GetInfo()
  D3DDEVINFOID_TEXTUREMANAGER    = 1;
  {$EXTERNALSYM D3DDEVINFOID_TEXTUREMANAGER}
  D3DDEVINFOID_D3DTEXTUREMANAGER = 2;
  {$EXTERNALSYM D3DDEVINFOID_D3DTEXTUREMANAGER}
  D3DDEVINFOID_TEXTURING         = 3;
  {$EXTERNALSYM D3DDEVINFOID_TEXTURING}

type
  PD3DStateBlockType = ^TD3DStateBlockType;
  _D3DSTATEBLOCKTYPE = (
    D3DSBT_INVALID_0   ,
    D3DSBT_ALL         , // capture all state
    D3DSBT_PIXELSTATE  , // capture pixel state
    D3DSBT_VERTEXSTATE   // capture vertex state
  );
  {$EXTERNALSYM _D3DSTATEBLOCKTYPE}
  D3DSTATEBLOCKTYPE = _D3DSTATEBLOCKTYPE;
  {$EXTERNALSYM D3DSTATEBLOCKTYPE}
  TD3DStateBlockType = _D3DSTATEBLOCKTYPE;

// The D3DVERTEXBLENDFLAGS type is used with D3DRENDERSTATE_VERTEXBLEND state.
//
  PD3DVertexBlendFlags = ^TD3DVertexBlendFlags;
  _D3DVERTEXBLENDFLAGS = (
    D3DVBLEND_DISABLE , // Disable vertex blending
    D3DVBLEND_1WEIGHT , // blend between 2 matrices
    D3DVBLEND_2WEIGHTS, // blend between 3 matrices
    D3DVBLEND_3WEIGHTS  // blend between 4 matrices
  );
  {$EXTERNALSYM _D3DVERTEXBLENDFLAGS}
  D3DVERTEXBLENDFLAGS = _D3DVERTEXBLENDFLAGS;
  {$EXTERNALSYM D3DVERTEXBLENDFLAGS}
  TD3DVertexBlendFlags = _D3DVERTEXBLENDFLAGS;

  PD3DTextureTransformFlags = ^TD3DTextureTransformFlags;
  _D3DTEXTURETRANSFORMFLAGS = (
    D3DTTFF_DISABLE ,    // texture coordinates are passed directly
    D3DTTFF_COUNT1  ,    // rasterizer should expect 1-D texture coords
    D3DTTFF_COUNT2  ,    // rasterizer should expect 2-D texture coords
    D3DTTFF_COUNT3  ,    // rasterizer should expect 3-D texture coords
    D3DTTFF_COUNT4       // rasterizer should expect 4-D texture coords
  );
  {$EXTERNALSYM _D3DTEXTURETRANSFORMFLAGS}
  D3DTEXTURETRANSFORMFLAGS = _D3DTEXTURETRANSFORMFLAGS;
  {$EXTERNALSYM D3DTEXTURETRANSFORMFLAGS}
  TD3DTextureTransformFlags = _D3DTEXTURETRANSFORMFLAGS;

const
  D3DTTFF_PROJECTED       = TD3DTextureTransformFlags(256); // texcoords to be divided by COUNTth element
  {$EXTERNALSYM D3DTTFF_PROJECTED}

// Macros to set texture coordinate format bits in the FVF id

  D3DFVF_TEXTUREFORMAT2 = 0;         // Two floating point values
  {$EXTERNALSYM D3DFVF_TEXTUREFORMAT2}
  D3DFVF_TEXTUREFORMAT1 = 3;         // One floating point value
  {$EXTERNALSYM D3DFVF_TEXTUREFORMAT1}
  D3DFVF_TEXTUREFORMAT3 = 1;         // Three floating point values
  {$EXTERNALSYM D3DFVF_TEXTUREFORMAT3}
  D3DFVF_TEXTUREFORMAT4 = 2;         // Four floating point values
  {$EXTERNALSYM D3DFVF_TEXTUREFORMAT4}

function D3DFVF_TEXCOORDSIZE3(CoordIndex: DWORD): DWORD;
{$EXTERNALSYM D3DFVF_TEXCOORDSIZE3}
function D3DFVF_TEXCOORDSIZE2(CoordIndex: DWORD): DWORD;
{$EXTERNALSYM D3DFVF_TEXCOORDSIZE2}
function D3DFVF_TEXCOORDSIZE4(CoordIndex: DWORD): DWORD;
{$EXTERNALSYM D3DFVF_TEXCOORDSIZE4}
function D3DFVF_TEXCOORDSIZE1(CoordIndex: DWORD): DWORD;
{$EXTERNALSYM D3DFVF_TEXCOORDSIZE1}

 // DIRECT3D_VERSION_7
 // DIRECT3D_VERSION_LESS_8


(*==========================================================================;
 *
 *
 *  File:       d3dcaps.h
 *  Content:    Direct3D capabilities include file
 *
 ***************************************************************************)

(* Description of capabilities of transform *)

type
  PD3DTransformCaps = ^TD3DTransformCaps;
  _D3DTRANSFORMCAPS = packed record
    dwSize: DWORD;
    dwCaps: DWORD;
  end;
  {$EXTERNALSYM _D3DTRANSFORMCAPS}
  D3DTRANSFORMCAPS = _D3DTRANSFORMCAPS;
  {$EXTERNALSYM D3DTRANSFORMCAPS}
  TD3DTransformCaps = _D3DTRANSFORMCAPS;

const
  D3DTRANSFORMCAPS_CLIP         = $00000001; (* Will clip whilst transforming *)
  {$EXTERNALSYM D3DTRANSFORMCAPS_CLIP}

(* Description of capabilities of lighting *)

type
  PD3DLightingCaps = ^TD3DLightingCaps;
  _D3DLIGHTINGCAPS = packed record
    dwSize: DWORD;
    dwCaps: DWORD;                   (* Lighting caps *)
    dwLightingModel: DWORD;          (* Lighting model - RGB or mono *)
    dwNumLights: DWORD;              (* Number of lights that can be handled *)
  end;
  {$EXTERNALSYM _D3DLIGHTINGCAPS}
  D3DLIGHTINGCAPS = _D3DLIGHTINGCAPS;
  {$EXTERNALSYM D3DLIGHTINGCAPS}
  TD3DLightingCaps = _D3DLIGHTINGCAPS;

const
  D3DLIGHTINGMODEL_RGB            = $00000001;
  {$EXTERNALSYM D3DLIGHTINGMODEL_RGB}
  D3DLIGHTINGMODEL_MONO           = $00000002;
  {$EXTERNALSYM D3DLIGHTINGMODEL_MONO}

  D3DLIGHTCAPS_POINT              = $00000001; (* Point lights supported *)
  {$EXTERNALSYM D3DLIGHTCAPS_POINT}
  D3DLIGHTCAPS_SPOT               = $00000002; (* Spot lights supported *)
  {$EXTERNALSYM D3DLIGHTCAPS_SPOT}
  D3DLIGHTCAPS_DIRECTIONAL        = $00000004; (* Directional lights supported *)
  {$EXTERNALSYM D3DLIGHTCAPS_DIRECTIONAL}
 // DIRECT3D_VERSION_LESS_7
 // DIRECT3D_VERSION_LESS_5

(* Description of capabilities for each primitive type *)

type
  PD3DPrimCaps = ^TD3DPrimCaps;
  _D3DPrimCaps = packed record
    dwSize: DWORD;
    dwMiscCaps: DWORD;                 (* Capability flags *)
    dwRasterCaps: DWORD;
    dwZCmpCaps: DWORD;
    dwSrcBlendCaps: DWORD;
    dwDestBlendCaps: DWORD;
    dwAlphaCmpCaps: DWORD;
    dwShadeCaps: DWORD;
    dwTextureCaps: DWORD;
    dwTextureFilterCaps: DWORD;
    dwTextureBlendCaps: DWORD;
    dwTextureAddressCaps: DWORD;
    dwStippleWidth: DWORD;             (* maximum width and height of *)
    dwStippleHeight: DWORD;            (* of supported stipple (up to 32x32) *)
  end;
  {$EXTERNALSYM _D3DPrimCaps}
  D3DPrimCaps = _D3DPrimCaps;
  {$EXTERNALSYM D3DPrimCaps}
  TD3DPrimCaps = _D3DPrimCaps;

const
(* TD3DPrimCaps dwMiscCaps *)

  D3DPMISCCAPS_MASKPLANES         = $00000001;
  {$EXTERNALSYM D3DPMISCCAPS_MASKPLANES}
  D3DPMISCCAPS_MASKZ              = $00000002;
  {$EXTERNALSYM D3DPMISCCAPS_MASKZ}
  D3DPMISCCAPS_LINEPATTERNREP     = $00000004;
  {$EXTERNALSYM D3DPMISCCAPS_LINEPATTERNREP}
  D3DPMISCCAPS_CONFORMANT         = $00000008;
  {$EXTERNALSYM D3DPMISCCAPS_CONFORMANT}
  D3DPMISCCAPS_CULLNONE           = $00000010;
  {$EXTERNALSYM D3DPMISCCAPS_CULLNONE}
  D3DPMISCCAPS_CULLCW             = $00000020;
  {$EXTERNALSYM D3DPMISCCAPS_CULLCW}
  D3DPMISCCAPS_CULLCCW            = $00000040;
  {$EXTERNALSYM D3DPMISCCAPS_CULLCCW}

(* TD3DPrimCaps dwRasterCaps *)

  D3DPRASTERCAPS_DITHER           = $00000001;
  {$EXTERNALSYM D3DPRASTERCAPS_DITHER}
  D3DPRASTERCAPS_ROP2             = $00000002;
  {$EXTERNALSYM D3DPRASTERCAPS_ROP2}
  D3DPRASTERCAPS_XOR              = $00000004;
  {$EXTERNALSYM D3DPRASTERCAPS_XOR}
  D3DPRASTERCAPS_PAT              = $00000008;
  {$EXTERNALSYM D3DPRASTERCAPS_PAT}
  D3DPRASTERCAPS_ZTEST            = $00000010;
  {$EXTERNALSYM D3DPRASTERCAPS_ZTEST}
  D3DPRASTERCAPS_SUBPIXEL         = $00000020;
  {$EXTERNALSYM D3DPRASTERCAPS_SUBPIXEL}
  D3DPRASTERCAPS_SUBPIXELX        = $00000040;
  {$EXTERNALSYM D3DPRASTERCAPS_SUBPIXELX}
  D3DPRASTERCAPS_FOGVERTEX        = $00000080;
  {$EXTERNALSYM D3DPRASTERCAPS_FOGVERTEX}
  D3DPRASTERCAPS_FOGTABLE         = $00000100;
  {$EXTERNALSYM D3DPRASTERCAPS_FOGTABLE}
  D3DPRASTERCAPS_STIPPLE          = $00000200;
  {$EXTERNALSYM D3DPRASTERCAPS_STIPPLE}
  D3DPRASTERCAPS_ANTIALIASSORTDEPENDENT   = $00000400;
  {$EXTERNALSYM D3DPRASTERCAPS_ANTIALIASSORTDEPENDENT}
  D3DPRASTERCAPS_ANTIALIASSORTINDEPENDENT = $00000800;
  {$EXTERNALSYM D3DPRASTERCAPS_ANTIALIASSORTINDEPENDENT}
  D3DPRASTERCAPS_ANTIALIASEDGES           = $00001000;
  {$EXTERNALSYM D3DPRASTERCAPS_ANTIALIASEDGES}
  D3DPRASTERCAPS_MIPMAPLODBIAS            = $00002000;
  {$EXTERNALSYM D3DPRASTERCAPS_MIPMAPLODBIAS}
  D3DPRASTERCAPS_ZBIAS                    = $00004000;
  {$EXTERNALSYM D3DPRASTERCAPS_ZBIAS}
  D3DPRASTERCAPS_ZBUFFERLESSHSR           = $00008000;
  {$EXTERNALSYM D3DPRASTERCAPS_ZBUFFERLESSHSR}
  D3DPRASTERCAPS_FOGRANGE                 = $00010000;
  {$EXTERNALSYM D3DPRASTERCAPS_FOGRANGE}
  D3DPRASTERCAPS_ANISOTROPY               = $00020000;
  {$EXTERNALSYM D3DPRASTERCAPS_ANISOTROPY}
 // DIRECT3D_VERSION_5
  D3DPRASTERCAPS_WBUFFER                      = $00040000;
  {$EXTERNALSYM D3DPRASTERCAPS_WBUFFER}
  D3DPRASTERCAPS_TRANSLUCENTSORTINDEPENDENT   = $00080000;
  {$EXTERNALSYM D3DPRASTERCAPS_TRANSLUCENTSORTINDEPENDENT}
  D3DPRASTERCAPS_WFOG                         = $00100000;
  {$EXTERNALSYM D3DPRASTERCAPS_WFOG}
  D3DPRASTERCAPS_ZFOG                         = $00200000;
  {$EXTERNALSYM D3DPRASTERCAPS_ZFOG}
 // DIRECT3D_VERSION_6

(* TD3DPrimCaps dwZCmpCaps, dwAlphaCmpCaps *)

const
  D3DPCMPCAPS_NEVER               = $00000001;
  {$EXTERNALSYM D3DPCMPCAPS_NEVER}
  D3DPCMPCAPS_LESS                = $00000002;
  {$EXTERNALSYM D3DPCMPCAPS_LESS}
  D3DPCMPCAPS_EQUAL               = $00000004;
  {$EXTERNALSYM D3DPCMPCAPS_EQUAL}
  D3DPCMPCAPS_LESSEQUAL           = $00000008;
  {$EXTERNALSYM D3DPCMPCAPS_LESSEQUAL}
  D3DPCMPCAPS_GREATER             = $00000010;
  {$EXTERNALSYM D3DPCMPCAPS_GREATER}
  D3DPCMPCAPS_NOTEQUAL            = $00000020;
  {$EXTERNALSYM D3DPCMPCAPS_NOTEQUAL}
  D3DPCMPCAPS_GREATEREQUAL        = $00000040;
  {$EXTERNALSYM D3DPCMPCAPS_GREATEREQUAL}
  D3DPCMPCAPS_ALWAYS              = $00000080;
  {$EXTERNALSYM D3DPCMPCAPS_ALWAYS}

(* TD3DPrimCaps dwSourceBlendCaps, dwDestBlendCaps *)

  D3DPBLENDCAPS_ZERO              = $00000001;
  {$EXTERNALSYM D3DPBLENDCAPS_ZERO}
  D3DPBLENDCAPS_ONE               = $00000002;
  {$EXTERNALSYM D3DPBLENDCAPS_ONE}
  D3DPBLENDCAPS_SRCCOLOR          = $00000004;
  {$EXTERNALSYM D3DPBLENDCAPS_SRCCOLOR}
  D3DPBLENDCAPS_INVSRCCOLOR       = $00000008;
  {$EXTERNALSYM D3DPBLENDCAPS_INVSRCCOLOR}
  D3DPBLENDCAPS_SRCALPHA          = $00000010;
  {$EXTERNALSYM D3DPBLENDCAPS_SRCALPHA}
  D3DPBLENDCAPS_INVSRCALPHA       = $00000020;
  {$EXTERNALSYM D3DPBLENDCAPS_INVSRCALPHA}
  D3DPBLENDCAPS_DESTALPHA         = $00000040;
  {$EXTERNALSYM D3DPBLENDCAPS_DESTALPHA}
  D3DPBLENDCAPS_INVDESTALPHA      = $00000080;
  {$EXTERNALSYM D3DPBLENDCAPS_INVDESTALPHA}
  D3DPBLENDCAPS_DESTCOLOR         = $00000100;
  {$EXTERNALSYM D3DPBLENDCAPS_DESTCOLOR}
  D3DPBLENDCAPS_INVDESTCOLOR      = $00000200;
  {$EXTERNALSYM D3DPBLENDCAPS_INVDESTCOLOR}
  D3DPBLENDCAPS_SRCALPHASAT       = $00000400;
  {$EXTERNALSYM D3DPBLENDCAPS_SRCALPHASAT}
  D3DPBLENDCAPS_BOTHSRCALPHA      = $00000800;
  {$EXTERNALSYM D3DPBLENDCAPS_BOTHSRCALPHA}
  D3DPBLENDCAPS_BOTHINVSRCALPHA   = $00001000;
  {$EXTERNALSYM D3DPBLENDCAPS_BOTHINVSRCALPHA}

(* TD3DPrimCaps dwShadeCaps *)

  D3DPSHADECAPS_COLORFLATMONO             = $00000001;
  {$EXTERNALSYM D3DPSHADECAPS_COLORFLATMONO}
  D3DPSHADECAPS_COLORFLATRGB              = $00000002;
  {$EXTERNALSYM D3DPSHADECAPS_COLORFLATRGB}
  D3DPSHADECAPS_COLORGOURAUDMONO          = $00000004;
  {$EXTERNALSYM D3DPSHADECAPS_COLORGOURAUDMONO}
  D3DPSHADECAPS_COLORGOURAUDRGB           = $00000008;
  {$EXTERNALSYM D3DPSHADECAPS_COLORGOURAUDRGB}
  D3DPSHADECAPS_COLORPHONGMONO            = $00000010;
  {$EXTERNALSYM D3DPSHADECAPS_COLORPHONGMONO}
  D3DPSHADECAPS_COLORPHONGRGB             = $00000020;
  {$EXTERNALSYM D3DPSHADECAPS_COLORPHONGRGB}

  D3DPSHADECAPS_SPECULARFLATMONO          = $00000040;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARFLATMONO}
  D3DPSHADECAPS_SPECULARFLATRGB           = $00000080;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARFLATRGB}
  D3DPSHADECAPS_SPECULARGOURAUDMONO       = $00000100;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARGOURAUDMONO}
  D3DPSHADECAPS_SPECULARGOURAUDRGB        = $00000200;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARGOURAUDRGB}
  D3DPSHADECAPS_SPECULARPHONGMONO         = $00000400;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARPHONGMONO}
  D3DPSHADECAPS_SPECULARPHONGRGB          = $00000800;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARPHONGRGB}

  D3DPSHADECAPS_ALPHAFLATBLEND            = $00001000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAFLATBLEND}
  D3DPSHADECAPS_ALPHAFLATSTIPPLED         = $00002000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAFLATSTIPPLED}
  D3DPSHADECAPS_ALPHAGOURAUDBLEND         = $00004000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAGOURAUDBLEND}
  D3DPSHADECAPS_ALPHAGOURAUDSTIPPLED      = $00008000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAGOURAUDSTIPPLED}
  D3DPSHADECAPS_ALPHAPHONGBLEND           = $00010000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAPHONGBLEND}
  D3DPSHADECAPS_ALPHAPHONGSTIPPLED        = $00020000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAPHONGSTIPPLED}

  D3DPSHADECAPS_FOGFLAT                   = $00040000;
  {$EXTERNALSYM D3DPSHADECAPS_FOGFLAT}
  D3DPSHADECAPS_FOGGOURAUD                = $00080000;
  {$EXTERNALSYM D3DPSHADECAPS_FOGGOURAUD}
  D3DPSHADECAPS_FOGPHONG                  = $00100000;
  {$EXTERNALSYM D3DPSHADECAPS_FOGPHONG}

(* TD3DPrimCaps dwTextureCaps *)

(*
 * Perspective-correct texturing is supported
 *)
  D3DPTEXTURECAPS_PERSPECTIVE     = $00000001;
  {$EXTERNALSYM D3DPTEXTURECAPS_PERSPECTIVE}

(*
 * Power-of-2 texture dimensions are required
 *)
  D3DPTEXTURECAPS_POW2            = $00000002;
  {$EXTERNALSYM D3DPTEXTURECAPS_POW2}

(*
 * Alpha in texture pixels is supported
 *)
  D3DPTEXTURECAPS_ALPHA           = $00000004;
  {$EXTERNALSYM D3DPTEXTURECAPS_ALPHA}

(*
 * Color-keyed textures are supported
 *)
  D3DPTEXTURECAPS_TRANSPARENCY    = $00000008;
  {$EXTERNALSYM D3DPTEXTURECAPS_TRANSPARENCY}

(*
 * obsolete, see D3DPTADDRESSCAPS_BORDER
 *)
  D3DPTEXTURECAPS_BORDER          = $00000010;
  {$EXTERNALSYM D3DPTEXTURECAPS_BORDER}

(*
 * Only square textures are supported
 *)
  D3DPTEXTURECAPS_SQUAREONLY      = $00000020;
  {$EXTERNALSYM D3DPTEXTURECAPS_SQUAREONLY}

(*
 * Texture indices are not scaled by the texture size prior
 * to interpolation.
 *)
  D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE = $00000040;
  {$EXTERNALSYM D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE}

(*
 * Device can draw alpha from texture palettes
 *)
  D3DPTEXTURECAPS_ALPHAPALETTE    = $00000080;
  {$EXTERNALSYM D3DPTEXTURECAPS_ALPHAPALETTE}

(*
 * Device can use non-POW2 textures if:
 *  1) D3DTEXTURE_ADDRESS is set to CLAMP for this texture's stage
 *  2) D3DRS_WRAP(N) is zero for this texture's coordinates
 *  3) mip mapping is not enabled (use magnification filter only)
 *)
  D3DPTEXTURECAPS_NONPOW2CONDITIONAL  = $00000100;
  {$EXTERNALSYM D3DPTEXTURECAPS_NONPOW2CONDITIONAL}
 // DIRECT3D_VERSION_6

// 0x00000200L unused

(*
 * Device can divide transformed texture coordinates by the
 * COUNTth texture coordinate (can do D3DTTFF_PROJECTED)
 *)
  D3DPTEXTURECAPS_PROJECTED  = $00000400;
  {$EXTERNALSYM D3DPTEXTURECAPS_PROJECTED}

(*
 * Device can do cubemap textures
 *)
  D3DPTEXTURECAPS_CUBEMAP           = $00000800;
  {$EXTERNALSYM D3DPTEXTURECAPS_CUBEMAP}

  D3DPTEXTURECAPS_COLORKEYBLEND     = $00001000;
  {$EXTERNALSYM D3DPTEXTURECAPS_COLORKEYBLEND}
 // DIRECT3D_VERSION_7


(* TD3DPrimCaps dwTextureFilterCaps *)

  D3DPTFILTERCAPS_NEAREST         = $00000001;
  {$EXTERNALSYM D3DPTFILTERCAPS_NEAREST}
  D3DPTFILTERCAPS_LINEAR          = $00000002;
  {$EXTERNALSYM D3DPTFILTERCAPS_LINEAR}
  D3DPTFILTERCAPS_MIPNEAREST      = $00000004;
  {$EXTERNALSYM D3DPTFILTERCAPS_MIPNEAREST}
  D3DPTFILTERCAPS_MIPLINEAR       = $00000008;
  {$EXTERNALSYM D3DPTFILTERCAPS_MIPLINEAR}
  D3DPTFILTERCAPS_LINEARMIPNEAREST = $00000010;
  {$EXTERNALSYM D3DPTFILTERCAPS_LINEARMIPNEAREST}
  D3DPTFILTERCAPS_LINEARMIPLINEAR = $00000020;
  {$EXTERNALSYM D3DPTFILTERCAPS_LINEARMIPLINEAR}

(* Device3 Min Filter *)
  D3DPTFILTERCAPS_MINFPOINT       = $00000100;
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFPOINT}
  D3DPTFILTERCAPS_MINFLINEAR      = $00000200;
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFLINEAR}
  D3DPTFILTERCAPS_MINFANISOTROPIC = $00000400;
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFANISOTROPIC}

(* Device3 Mip Filter *)
  D3DPTFILTERCAPS_MIPFPOINT       = $00010000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MIPFPOINT}
  D3DPTFILTERCAPS_MIPFLINEAR      = $00020000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MIPFLINEAR}

(* Device3 Mag Filter *)
  D3DPTFILTERCAPS_MAGFPOINT         = $01000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFPOINT}
  D3DPTFILTERCAPS_MAGFLINEAR        = $02000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFLINEAR}
  D3DPTFILTERCAPS_MAGFANISOTROPIC   = $04000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFANISOTROPIC}
  D3DPTFILTERCAPS_MAGFAFLATCUBIC    = $08000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFAFLATCUBIC}
  D3DPTFILTERCAPS_MAGFGAUSSIANCUBIC = $10000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFGAUSSIANCUBIC}
 // DIRECT3D_VERSION_6

(* TD3DPrimCaps dwTextureBlendCaps *)

  D3DPTBLENDCAPS_DECAL            = $00000001;
  {$EXTERNALSYM D3DPTBLENDCAPS_DECAL}
  D3DPTBLENDCAPS_MODULATE         = $00000002;
  {$EXTERNALSYM D3DPTBLENDCAPS_MODULATE}
  D3DPTBLENDCAPS_DECALALPHA       = $00000004;
  {$EXTERNALSYM D3DPTBLENDCAPS_DECALALPHA}
  D3DPTBLENDCAPS_MODULATEALPHA    = $00000008;
  {$EXTERNALSYM D3DPTBLENDCAPS_MODULATEALPHA}
  D3DPTBLENDCAPS_DECALMASK        = $00000010;
  {$EXTERNALSYM D3DPTBLENDCAPS_DECALMASK}
  D3DPTBLENDCAPS_MODULATEMASK     = $00000020;
  {$EXTERNALSYM D3DPTBLENDCAPS_MODULATEMASK}
  D3DPTBLENDCAPS_COPY             = $00000040;
  {$EXTERNALSYM D3DPTBLENDCAPS_COPY}
  D3DPTBLENDCAPS_ADD	        	  = $00000080;
  {$EXTERNALSYM D3DPTBLENDCAPS_ADD}
 // DIRECT3D_VERSION_5

(* TD3DPrimCaps dwTextureAddressCaps *)
  D3DPTADDRESSCAPS_WRAP           = $00000001;
  {$EXTERNALSYM D3DPTADDRESSCAPS_WRAP}
  D3DPTADDRESSCAPS_MIRROR         = $00000002;
  {$EXTERNALSYM D3DPTADDRESSCAPS_MIRROR}
  D3DPTADDRESSCAPS_CLAMP          = $00000004;
  {$EXTERNALSYM D3DPTADDRESSCAPS_CLAMP}
  D3DPTADDRESSCAPS_BORDER         = $00000008;
  {$EXTERNALSYM D3DPTADDRESSCAPS_BORDER}
  D3DPTADDRESSCAPS_INDEPENDENTUV  = $00000010;
  {$EXTERNALSYM D3DPTADDRESSCAPS_INDEPENDENTUV}
 // DIRECT3D_VERSION_5


(* D3DDEVICEDESC dwStencilCaps *)

  D3DSTENCILCAPS_KEEP     = $00000001;
  {$EXTERNALSYM D3DSTENCILCAPS_KEEP}
  D3DSTENCILCAPS_ZERO     = $00000002;
  {$EXTERNALSYM D3DSTENCILCAPS_ZERO}
  D3DSTENCILCAPS_REPLACE  = $00000004;
  {$EXTERNALSYM D3DSTENCILCAPS_REPLACE}
  D3DSTENCILCAPS_INCRSAT  = $00000008;
  {$EXTERNALSYM D3DSTENCILCAPS_INCRSAT}
  D3DSTENCILCAPS_DECRSAT  = $00000010;
  {$EXTERNALSYM D3DSTENCILCAPS_DECRSAT}
  D3DSTENCILCAPS_INVERT   = $00000020;
  {$EXTERNALSYM D3DSTENCILCAPS_INVERT}
  D3DSTENCILCAPS_INCR     = $00000040;
  {$EXTERNALSYM D3DSTENCILCAPS_INCR}
  D3DSTENCILCAPS_DECR     = $00000080;
  {$EXTERNALSYM D3DSTENCILCAPS_DECR}

(* D3DDEVICEDESC dwTextureOpCaps *)

  D3DTEXOPCAPS_DISABLE                    = $00000001;
  {$EXTERNALSYM D3DTEXOPCAPS_DISABLE}
  D3DTEXOPCAPS_SELECTARG1                 = $00000002;
  {$EXTERNALSYM D3DTEXOPCAPS_SELECTARG1}
  D3DTEXOPCAPS_SELECTARG2                 = $00000004;
  {$EXTERNALSYM D3DTEXOPCAPS_SELECTARG2}
  D3DTEXOPCAPS_MODULATE                   = $00000008;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATE}
  D3DTEXOPCAPS_MODULATE2X                 = $00000010;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATE2X}
  D3DTEXOPCAPS_MODULATE4X                 = $00000020;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATE4X}
  D3DTEXOPCAPS_ADD                        = $00000040;
  {$EXTERNALSYM D3DTEXOPCAPS_ADD}
  D3DTEXOPCAPS_ADDSIGNED                  = $00000080;
  {$EXTERNALSYM D3DTEXOPCAPS_ADDSIGNED}
  D3DTEXOPCAPS_ADDSIGNED2X                = $00000100;
  {$EXTERNALSYM D3DTEXOPCAPS_ADDSIGNED2X}
  D3DTEXOPCAPS_SUBTRACT                   = $00000200;
  {$EXTERNALSYM D3DTEXOPCAPS_SUBTRACT}
  D3DTEXOPCAPS_ADDSMOOTH                  = $00000400;
  {$EXTERNALSYM D3DTEXOPCAPS_ADDSMOOTH}
  D3DTEXOPCAPS_BLENDDIFFUSEALPHA          = $00000800;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDDIFFUSEALPHA}
  D3DTEXOPCAPS_BLENDTEXTUREALPHA          = $00001000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDTEXTUREALPHA}
  D3DTEXOPCAPS_BLENDFACTORALPHA           = $00002000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDFACTORALPHA}
  D3DTEXOPCAPS_BLENDTEXTUREALPHAPM        = $00004000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDTEXTUREALPHAPM}
  D3DTEXOPCAPS_BLENDCURRENTALPHA          = $00008000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDCURRENTALPHA}
  D3DTEXOPCAPS_PREMODULATE                = $00010000;
  {$EXTERNALSYM D3DTEXOPCAPS_PREMODULATE}
  D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR     = $00020000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR}
  D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA     = $00040000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA}
  D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR  = $00080000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR}
  D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA  = $00100000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA}
  D3DTEXOPCAPS_BUMPENVMAP                 = $00200000;
  {$EXTERNALSYM D3DTEXOPCAPS_BUMPENVMAP}
  D3DTEXOPCAPS_BUMPENVMAPLUMINANCE        = $00400000;
  {$EXTERNALSYM D3DTEXOPCAPS_BUMPENVMAPLUMINANCE}
  D3DTEXOPCAPS_DOTPRODUCT3                = $00800000;
  {$EXTERNALSYM D3DTEXOPCAPS_DOTPRODUCT3}

(* D3DDEVICEDESC dwFVFCaps flags *)

  D3DFVFCAPS_TEXCOORDCOUNTMASK    = $0000ffff; (* mask for texture coordinate count field *)
  {$EXTERNALSYM D3DFVFCAPS_TEXCOORDCOUNTMASK}
  D3DFVFCAPS_DONOTSTRIPELEMENTS   = $00080000; (* Device prefers that vertex elements not be stripped *)
  {$EXTERNALSYM D3DFVFCAPS_DONOTSTRIPELEMENTS}

 // DIRECT3D_VERSION_6

(*
 * Description for a device.
 * This is used to describe a device that is to be created or to query
 * the current device.
 *)

type
  PD3DDeviceDesc = ^TD3DDeviceDesc;
  _D3DDeviceDesc = packed record
    dwSize: DWORD;                       (* Size of TD3DDeviceDesc structure *)
    dwFlags: DWORD;                      (* Indicates which fields have valid data *)
    dcmColorModel: TD3DColorModel;       (* Color model of device *)
    dwDevCaps: DWORD;                    (* Capabilities of device *)
    dtcTransformCaps: TD3DTransformCaps; (* Capabilities of transform *)
    bClipping: BOOL;                     (* Device can do 3D clipping *)
    dlcLightingCaps: TD3DLightingCaps;   (* Capabilities of lighting *)
    dpcLineCaps: TD3DPrimCaps;
    dpcTriCaps: TD3DPrimCaps;
    dwDeviceRenderBitDepth: DWORD;       (* One of DDBB_8, 16, etc.. *)
    dwDeviceZBufferBitDepth: DWORD;      (* One of DDBD_16, 32, etc.. *)
    dwMaxBufferSize: DWORD;              (* Maximum execute buffer size *)
    dwMaxVertexCount: DWORD;             (* Maximum vertex count *)
    // *** New fields for DX5 *** //

    // Width and height caps are 0 for legacy HALs.
    dwMinTextureWidth, dwMinTextureHeight  : DWORD;
    dwMaxTextureWidth, dwMaxTextureHeight  : DWORD;
    dwMinStippleWidth, dwMaxStippleWidth   : DWORD;
    dwMinStippleHeight, dwMaxStippleHeight : DWORD;
 // DIRECT3D_VERSION_5

    // New fields for DX6
    dwMaxTextureRepeat : DWORD;
    dwMaxTextureAspectRatio : DWORD;
    dwMaxAnisotropy : DWORD;

    // Guard band that the rasterizer can accommodate
    // Screen-space vertices inside this space but outside the viewport
    // will get clipped properly.
    dvGuardBandLeft : TD3DValue;
    dvGuardBandTop : TD3DValue;
    dvGuardBandRight : TD3DValue;
    dvGuardBandBottom : TD3DValue;

    dvExtentsAdjust : TD3DValue;
    dwStencilCaps : DWORD;

    dwFVFCaps : DWORD;  (* low 4 bits: 0 implies TLVERTEX only, 1..8 imply FVF aware *)
    dwTextureOpCaps : DWORD;
    wMaxTextureBlendStages : WORD;
    wMaxSimultaneousTextures : WORD;
 // DIRECT3D_VERSION_6
  end;
  {$EXTERNALSYM _D3DDeviceDesc}
  D3DDeviceDesc = _D3DDeviceDesc;
  {$EXTERNALSYM D3DDeviceDesc}
  TD3DDeviceDesc = _D3DDeviceDesc;

  PD3DDeviceDesc7 = ^TD3DDeviceDesc7;
  _D3DDeviceDesc7 = packed record
    dwDevCaps:               DWORD;             (* Capabilities of device *)
    dpcLineCaps:             TD3DPrimCaps;
    dpcTriCaps:              TD3DPrimCaps;
    dwDeviceRenderBitDepth:  DWORD;             (* One of DDBB_8, 16, etc.. *)
    dwDeviceZBufferBitDepth: DWORD;             (* One of DDBD_16, 32, etc.. *)

    dwMinTextureWidth, dwMinTextureHeight: DWORD;
    dwMaxTextureWidth, dwMaxTextureHeight: DWORD;

    dwMaxTextureRepeat:                    DWORD;
    dwMaxTextureAspectRatio:               DWORD;
    dwMaxAnisotropy:                       DWORD;

    dvGuardBandLeft:                       TD3DValue;
    dvGuardBandTop:                        TD3DValue;
    dvGuardBandRight:                      TD3DValue;
    dvGuardBandBottom:                     TD3DValue;

    dvExtentsAdjust:                       TD3DValue;
    dwStencilCaps:                         DWORD;

    dwFVFCaps:                             DWORD;
    dwTextureOpCaps:                       DWORD;
    wMaxTextureBlendStages:                WORD;
    wMaxSimultaneousTextures:              WORD;

    dwMaxActiveLights:                     DWORD;
    dvMaxVertexW:                          TD3DValue;
    deviceGUID:                            TGUID;

    wMaxUserClipPlanes:                    WORD;
    wMaxVertexBlendMatrices:               WORD;

    dwVertexProcessingCaps:                DWORD;

    dwReserved1:                           DWORD;
    dwReserved2:                           DWORD;
    dwReserved3:                           DWORD;
    dwReserved4:                           DWORD;
  end;
  {$EXTERNALSYM _D3DDeviceDesc7}
  D3DDeviceDesc7 = _D3DDeviceDesc7;
  {$EXTERNALSYM D3DDeviceDesc7}
  TD3DDeviceDesc7 = _D3DDeviceDesc7;
 // DIRECT3D_VERSION_7

const
  D3DDEVICEDESCSIZE = SizeOf(TD3DDeviceDesc);
  {$EXTERNALSYM D3DDEVICEDESCSIZE}
 // There is the BUG in C++Headers
  D3DDEVICEDESC7SIZE = SizeOf(TD3DDeviceDesc7);
  {$EXTERNALSYM D3DDEVICEDESC7SIZE}
 // DIRECT3D_VERSION_7

type
  TD3DEnumDevicesCallbackA = function (lpGuid: PGUID; // nil for the default device
      lpDeviceDescription: PAnsiChar; lpDeviceName: PAnsiChar;
      var lpD3DHWDeviceDesc: TD3DDeviceDesc;
      var lpD3DHELDeviceDesc: TD3DDeviceDesc;
      lpContext: Pointer): HResult; stdcall;
  TD3DEnumDevicesCallback = TD3DEnumDevicesCallbackA;
  {$NODEFINE TD3DEnumDevicesCallbackA}
  {$NODEFINE TD3DEnumDevicesCallback}

  TD3DEnumDevicesCallback7A = function (
      lpDeviceDescription: PAnsiChar; lpDeviceName: PAnsiChar;
      const lpD3DDeviceDesc: TD3DDeviceDesc7; lpContext: Pointer): HResult; stdcall;
  TD3DEnumDevicesCallback7 = TD3DEnumDevicesCallback7A;
  {$NODEFINE TD3DEnumDevicesCallback7A}
  {$NODEFINE TD3DEnumDevicesCallback7}
 // DIRECT3D_VERSION_7

(* TD3DDeviceDesc dwFlags indicating valid fields *)

const
  D3DDD_COLORMODEL            = $00000001; (* dcmColorModel is valid *)
  {$EXTERNALSYM D3DDD_COLORMODEL}
  D3DDD_DEVCAPS               = $00000002; (* dwDevCaps is valid *)
  {$EXTERNALSYM D3DDD_DEVCAPS}
  D3DDD_TRANSFORMCAPS         = $00000004; (* dtcTransformCaps is valid *)
  {$EXTERNALSYM D3DDD_TRANSFORMCAPS}
  D3DDD_LIGHTINGCAPS          = $00000008; (* dlcLightingCaps is valid *)
  {$EXTERNALSYM D3DDD_LIGHTINGCAPS}
  D3DDD_BCLIPPING             = $00000010; (* bClipping is valid *)
  {$EXTERNALSYM D3DDD_BCLIPPING}
  D3DDD_LINECAPS              = $00000020; (* dpcLineCaps is valid *)
  {$EXTERNALSYM D3DDD_LINECAPS}
  D3DDD_TRICAPS               = $00000040; (* dpcTriCaps is valid *)
  {$EXTERNALSYM D3DDD_TRICAPS}
  D3DDD_DEVICERENDERBITDEPTH  = $00000080; (* dwDeviceRenderBitDepth is valid *)
  {$EXTERNALSYM D3DDD_DEVICERENDERBITDEPTH}
  D3DDD_DEVICEZBUFFERBITDEPTH = $00000100; (* dwDeviceZBufferBitDepth is valid *)
  {$EXTERNALSYM D3DDD_DEVICEZBUFFERBITDEPTH}
  D3DDD_MAXBUFFERSIZE         = $00000200; (* dwMaxBufferSize is valid *)
  {$EXTERNALSYM D3DDD_MAXBUFFERSIZE}
  D3DDD_MAXVERTEXCOUNT        = $00000400; (* dwMaxVertexCount is valid *)
  {$EXTERNALSYM D3DDD_MAXVERTEXCOUNT}

(* TD3DDeviceDesc dwDevCaps flags *)

  D3DDEVCAPS_FLOATTLVERTEX        = $00000001; (* Device accepts floating point *)
                                               (* for post-transform vertex data *)
  {$EXTERNALSYM D3DDEVCAPS_FLOATTLVERTEX}
  D3DDEVCAPS_SORTINCREASINGZ      = $00000002; (* Device needs data sorted for increasing Z*)
  {$EXTERNALSYM D3DDEVCAPS_SORTINCREASINGZ}
  D3DDEVCAPS_SORTDECREASINGZ      = $00000004; (* Device needs data sorted for decreasing Z*)
  {$EXTERNALSYM D3DDEVCAPS_SORTDECREASINGZ}
  D3DDEVCAPS_SORTEXACT            = $00000008; (* Device needs data sorted exactly *)
  {$EXTERNALSYM D3DDEVCAPS_SORTEXACT}

  D3DDEVCAPS_EXECUTESYSTEMMEMORY  = $00000010; (* Device can use execute buffers from system memory *)
  {$EXTERNALSYM D3DDEVCAPS_EXECUTESYSTEMMEMORY}
  D3DDEVCAPS_EXECUTEVIDEOMEMORY   = $00000020; (* Device can use execute buffers from video memory *)
  {$EXTERNALSYM D3DDEVCAPS_EXECUTEVIDEOMEMORY}
  D3DDEVCAPS_TLVERTEXSYSTEMMEMORY = $00000040; (* Device can use TL buffers from system memory *)
  {$EXTERNALSYM D3DDEVCAPS_TLVERTEXSYSTEMMEMORY}
  D3DDEVCAPS_TLVERTEXVIDEOMEMORY  = $00000080; (* Device can use TL buffers from video memory *)
  {$EXTERNALSYM D3DDEVCAPS_TLVERTEXVIDEOMEMORY}
  D3DDEVCAPS_TEXTURESYSTEMMEMORY  = $00000100; (* Device can texture from system memory *)
  {$EXTERNALSYM D3DDEVCAPS_TEXTURESYSTEMMEMORY}
  D3DDEVCAPS_TEXTUREVIDEOMEMORY   = $00000200; (* Device can texture from device memory *)
  {$EXTERNALSYM D3DDEVCAPS_TEXTUREVIDEOMEMORY}
  D3DDEVCAPS_DRAWPRIMTLVERTEX     = $00000400; (* Device can draw TLVERTEX primitives *)
  {$EXTERNALSYM D3DDEVCAPS_DRAWPRIMTLVERTEX}
  D3DDEVCAPS_CANRENDERAFTERFLIP	  = $00000800; (* Device can render without waiting for flip to complete *)
  {$EXTERNALSYM D3DDEVCAPS_CANRENDERAFTERFLIP}
  D3DDEVCAPS_TEXTURENONLOCALVIDMEM   = $00001000; (* Device can texture from nonlocal video memory *)
  {$EXTERNALSYM D3DDEVCAPS_TEXTURENONLOCALVIDMEM}
 // DIRECT3D_VERSION_5
  D3DDEVCAPS_DRAWPRIMITIVES2         = $00002000; (* Device can support DrawPrimitives2 *)
  {$EXTERNALSYM D3DDEVCAPS_DRAWPRIMITIVES2}
  D3DDEVCAPS_SEPARATETEXTUREMEMORIES = $00004000; (* Device is texturing from separate memory pools *)
  {$EXTERNALSYM D3DDEVCAPS_SEPARATETEXTUREMEMORIES}
  D3DDEVCAPS_DRAWPRIMITIVES2EX       = $00008000; (* Device can support Extended DrawPrimitives2 i.e. DX7 compliant driver*)
  {$EXTERNALSYM D3DDEVCAPS_DRAWPRIMITIVES2EX}
 // DIRECT3D_VERSION_6
  D3DDEVCAPS_HWTRANSFORMANDLIGHT     = $00010000; (* Device can support transformation and lighting in hardware and DRAWPRIMITIVES2EX must be also *)
  {$EXTERNALSYM D3DDEVCAPS_HWTRANSFORMANDLIGHT}
  D3DDEVCAPS_CANBLTSYSTONONLOCAL     = $00020000; (* Device supports a Tex Blt from system memory to non-local vidmem *)
  {$EXTERNALSYM D3DDEVCAPS_CANBLTSYSTONONLOCAL}
  D3DDEVCAPS_HWRASTERIZATION         = $00080000; (* Device has HW acceleration for rasterization *)
  {$EXTERNALSYM D3DDEVCAPS_HWRASTERIZATION}

(*
 * These are the flags in the D3DDEVICEDESC7.dwVertexProcessingCaps field
 *)

(* device can do texgen *)
  D3DVTXPCAPS_TEXGEN              = $00000001;
  {$EXTERNALSYM D3DVTXPCAPS_TEXGEN}
(* device can do IDirect3DDevice7 colormaterialsource ops *)
  D3DVTXPCAPS_MATERIALSOURCE7     = $00000002;
  {$EXTERNALSYM D3DVTXPCAPS_MATERIALSOURCE7}
(* device can do vertex fog *)
  D3DVTXPCAPS_VERTEXFOG           = $00000004;
  {$EXTERNALSYM D3DVTXPCAPS_VERTEXFOG}
(* device can do directional lights *)
  D3DVTXPCAPS_DIRECTIONALLIGHTS   = $00000008;
  {$EXTERNALSYM D3DVTXPCAPS_DIRECTIONALLIGHTS}
(* device can do positional lights (includes point and spot) *)
  D3DVTXPCAPS_POSITIONALLIGHTS    = $00000010;
  {$EXTERNALSYM D3DVTXPCAPS_POSITIONALLIGHTS}
(* device can do local viewer *)
  D3DVTXPCAPS_LOCALVIEWER         = $00000020;
  {$EXTERNALSYM D3DVTXPCAPS_LOCALVIEWER}
 // DIRECT3D_VERSION_7

  D3DFDS_COLORMODEL        = $00000001; (* Match color model *)
  {$EXTERNALSYM D3DFDS_COLORMODEL}
  D3DFDS_GUID              = $00000002; (* Match guid *)
  {$EXTERNALSYM D3DFDS_GUID}
  D3DFDS_HARDWARE          = $00000004; (* Match hardware/software *)
  {$EXTERNALSYM D3DFDS_HARDWARE}
  D3DFDS_TRIANGLES         = $00000008; (* Match in triCaps *)
  {$EXTERNALSYM D3DFDS_TRIANGLES}
  D3DFDS_LINES             = $00000010; (* Match in lineCaps  *)
  {$EXTERNALSYM D3DFDS_LINES}
  D3DFDS_MISCCAPS          = $00000020; (* Match primCaps.dwMiscCaps *)
  {$EXTERNALSYM D3DFDS_MISCCAPS}
  D3DFDS_RASTERCAPS        = $00000040; (* Match primCaps.dwRasterCaps *)
  {$EXTERNALSYM D3DFDS_RASTERCAPS}
  D3DFDS_ZCMPCAPS          = $00000080; (* Match primCaps.dwZCmpCaps *)
  {$EXTERNALSYM D3DFDS_ZCMPCAPS}
  D3DFDS_ALPHACMPCAPS      = $00000100; (* Match primCaps.dwAlphaCmpCaps *)
  {$EXTERNALSYM D3DFDS_ALPHACMPCAPS}
  D3DFDS_SRCBLENDCAPS      = $00000200; (* Match primCaps.dwSourceBlendCaps *)
  {$EXTERNALSYM D3DFDS_SRCBLENDCAPS}
  D3DFDS_DSTBLENDCAPS      = $00000400; (* Match primCaps.dwDestBlendCaps *)
  {$EXTERNALSYM D3DFDS_DSTBLENDCAPS}
  D3DFDS_SHADECAPS         = $00000800; (* Match primCaps.dwShadeCaps *)
  {$EXTERNALSYM D3DFDS_SHADECAPS}
  D3DFDS_TEXTURECAPS       = $00001000; (* Match primCaps.dwTextureCaps *)
  {$EXTERNALSYM D3DFDS_TEXTURECAPS}
  D3DFDS_TEXTUREFILTERCAPS = $00002000; (* Match primCaps.dwTextureFilterCaps *)
  {$EXTERNALSYM D3DFDS_TEXTUREFILTERCAPS}
  D3DFDS_TEXTUREBLENDCAPS  = $00004000; (* Match primCaps.dwTextureBlendCaps *)
  {$EXTERNALSYM D3DFDS_TEXTUREBLENDCAPS}
  D3DFDS_TEXTUREADDRESSCAPS  = $00008000; (* Match primCaps.dwTextureBlendCaps *)
  {$EXTERNALSYM D3DFDS_TEXTUREADDRESSCAPS}

(*
 * FindDevice arguments
 *)
type
  PD3DFindDeviceSearch = ^TD3DFindDeviceSearch;
  _D3DFINDDEVICESEARCH = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    bHardware: BOOL;
    dcmColorModel: TD3DColorModel;
    guid: TGUID;
    dwCaps: DWORD;
    dpcPrimCaps: TD3DPrimCaps;
  end;
  {$EXTERNALSYM _D3DFINDDEVICESEARCH}
  D3DFINDDEVICESEARCH = _D3DFINDDEVICESEARCH;
  {$EXTERNALSYM D3DFINDDEVICESEARCH}
  TD3DFindDeviceSearch = _D3DFINDDEVICESEARCH;

  PD3DFindDeviceResult = ^TD3DFindDeviceResult;
  _D3DFINDDEVICERESULT = packed record
    dwSize: DWORD;
    guid: TGUID;                (* guid which matched *)
    ddHwDesc: TD3DDeviceDesc;   (* hardware TD3DDeviceDesc *)
    ddSwDesc: TD3DDeviceDesc;   (* software TD3DDeviceDesc *)
  end;
  {$EXTERNALSYM _D3DFINDDEVICERESULT}
  D3DFINDDEVICERESULT = _D3DFINDDEVICERESULT;
  {$EXTERNALSYM D3DFINDDEVICERESULT}
  TD3DFindDeviceResult = _D3DFINDDEVICERESULT;

(*
 * Description of execute buffer.
 *)
  PD3DExecuteBufferDesc = ^TD3DExecuteBufferDesc;
  _D3DExecuteBufferDesc = packed record
    dwSize: DWORD;         (* size of this structure *)
    dwFlags: DWORD;        (* flags indicating which fields are valid *)
    dwCaps: DWORD;         (* capabilities of execute buffer *)
    dwBufferSize: DWORD;   (* size of execute buffer data *)
    lpData: Pointer;       (* pointer to actual data *)
  end;
  {$EXTERNALSYM _D3DExecuteBufferDesc}
  D3DExecuteBufferDesc = _D3DExecuteBufferDesc;
  {$EXTERNALSYM D3DExecuteBufferDesc}
  TD3DExecuteBufferDesc = _D3DExecuteBufferDesc;

(* D3DEXECUTEBUFFER dwFlags indicating valid fields *)

const
  D3DDEB_BUFSIZE          = $00000001;     (* buffer size valid *)
  {$EXTERNALSYM D3DDEB_BUFSIZE}
  D3DDEB_CAPS             = $00000002;     (* caps valid *)
  {$EXTERNALSYM D3DDEB_CAPS}
  D3DDEB_LPDATA           = $00000004;     (* lpData valid *)
  {$EXTERNALSYM D3DDEB_LPDATA}

(* D3DEXECUTEBUFFER dwCaps *)

  D3DDEBCAPS_SYSTEMMEMORY = $00000001;     (* buffer in system memory *)
  {$EXTERNALSYM D3DDEBCAPS_SYSTEMMEMORY}
  D3DDEBCAPS_VIDEOMEMORY  = $00000002;     (* buffer in device memory *)
  {$EXTERNALSYM D3DDEBCAPS_VIDEOMEMORY}
  D3DDEBCAPS_MEM          = (D3DDEBCAPS_SYSTEMMEMORY or D3DDEBCAPS_VIDEOMEMORY);
  {$EXTERNALSYM D3DDEBCAPS_MEM}

type
  PD3DDevInfo_TextureManager = ^TD3DDevInfo_TextureManager;
  _D3DDEVINFO_TEXTUREMANAGER = packed record
    bThrashing:              BOOL;       (* indicates if thrashing *)
    dwApproxBytesDownloaded: DWORD;      (* Approximate number of bytes downloaded by texture manager *)
    dwNumEvicts:             DWORD;      (* number of textures evicted *)
    dwNumVidCreates:         DWORD;      (* number of textures created in video memory *)
    dwNumTexturesUsed:       DWORD;      (* number of textures used *)
    dwNumUsedTexInVid:       DWORD;      (* number of used textures present in video memory *)
    dwWorkingSet:            DWORD;      (* number of textures in video memory *)
    dwWorkingSetBytes:       DWORD;      (* number of bytes in video memory *)
    dwTotalManaged:          DWORD;      (* total number of managed textures *)
    dwTotalBytes:            DWORD;      (* total number of bytes of managed textures *)
    dwLastPri:               DWORD;      (* priority of last texture evicted *)
  end;
  {$EXTERNALSYM _D3DDEVINFO_TEXTUREMANAGER}
  D3DDEVINFO_TEXTUREMANAGER = _D3DDEVINFO_TEXTUREMANAGER;
  {$EXTERNALSYM D3DDEVINFO_TEXTUREMANAGER}
  TD3DDevInfo_TextureManager = _D3DDEVINFO_TEXTUREMANAGER;
  PD3DDevInfoTextureManager = PD3DDevInfo_TextureManager;
  TD3DDevInfoTextureManager = _D3DDEVINFO_TEXTUREMANAGER;

  PD3DDevInfo_Texturing = ^TD3DDevInfo_Texturing;
  _D3DDEVINFO_TEXTURING = packed record
    dwNumLoads:          DWORD;          (* counts Load() API calls *)
    dwApproxBytesLoaded: DWORD;          (* Approximate number bytes loaded via Load() *)
    dwNumPreLoads:       DWORD;          (* counts PreLoad() API calls *)
    dwNumSet:            DWORD;          (* counts SetTexture() API calls *)
    dwNumCreates:        DWORD;          (* counts texture creates *)
    dwNumDestroys:       DWORD;          (* counts texture destroys *)
    dwNumSetPriorities:  DWORD;          (* counts SetPriority() API calls *)
    dwNumSetLODs:        DWORD;          (* counts SetLOD() API calls *)
    dwNumLocks:          DWORD;          (* counts number of texture locks *)
    dwNumGetDCs:         DWORD;          (* counts number of GetDCs to textures *)
  end;
  {$EXTERNALSYM _D3DDEVINFO_TEXTURING}
  D3DDEVINFO_TEXTURING = _D3DDEVINFO_TEXTURING;
  {$EXTERNALSYM D3DDEVINFO_TEXTURING}
  TD3DDevInfo_Texturing = _D3DDEVINFO_TEXTURING;
  PD3DDevInfoTexturing = PD3DDevInfo_Texturing;
  TD3DDevInfoTexturing = TD3DDevInfo_Texturing;
 // DIRECT3D_VERSION_7
 // DIRECT3D_VERSION_LESS_8



(*==========================================================================;
 *
 *
 *  File:   d3d.h
 *  Content:    Direct3D include file
 *
 ****************************************************************************)

// include this file content only if compiling for <=DX7 interfaces

function D3DErrorString(Value: HResult): String;


const
  IID_IDirect3DRampDevice: TGUID =
      (D1:$F2086B20;D2:$259F;D3:$11CF;D4:($A3,$1A,$00,$AA,$00,$B9,$33,$56));
  {$EXTERNALSYM IID_IDirect3DRampDevice}
  IID_IDirect3DRGBDevice: TGUID =
      (D1:$A4665C60;D2:$2673;D3:$11CF;D4:($A3,$1A,$00,$AA,$00,$B9,$33,$56));
  {$EXTERNALSYM IID_IDirect3DRGBDevice}
  IID_IDirect3DHALDevice: TGUID =
      (D1:$84E63dE0;D2:$46AA;D3:$11CF;D4:($81,$6F,$00,$00,$C0,$20,$15,$6E));
  {$EXTERNALSYM IID_IDirect3DHALDevice}
  IID_IDirect3DMMXDevice: TGUID =
      (D1:$881949a1;D2:$d6f3;D3:$11d0;D4:($89,$ab,$00,$a0,$c9,$05,$41,$29));
  {$EXTERNALSYM IID_IDirect3DMMXDevice}
 // DIRECT3D_VERSION_5

  IID_IDirect3DRefDevice: TGUID =
      (D1:$50936643;D2:$13e9;D3:$11d1;D4:($89,$aa,$00,$a0,$c9,$05,$41,$29));
  {$EXTERNALSYM IID_IDirect3DRefDevice}
  IID_IDirect3DNullDevice: TGUID =
      (D1:$8767df22;D2:$bacc;D3:$11d1;D4:($89,$69,$00,$a0,$c9,$06,$29,$a8));
  {$EXTERNALSYM IID_IDirect3DNullDevice}
 // DIRECT3D_VERSION_6
  IID_IDirect3DTnLHalDevice: TGUID = '{f5049e78-4861-11d2-a407-00a0c90629a8}';
  {$EXTERNALSYM IID_IDirect3DTnLHalDevice}
 // DIRECT3D_VERSION_7

type
  IDirect3D = interface;
  {$EXTERNALSYM IDirect3D}
  IDirect3D2 = interface;
   // DIRECT3D_VERSION_5
  IDirect3D3 = interface;
   // DIRECT3D_VERSION_5
  IDirect3D7 = interface;
   // DIRECT3D_VERSION_5
  IDirect3DDevice = interface;
  IDirect3DDevice2 = interface;
   // DIRECT3D_VERSION_5
  IDirect3DDevice3 = interface;
   // DIRECT3D_VERSION_6
  IDirect3DDevice7 = interface;
   // DIRECT3D_VERSION_7
  IDirect3DExecuteBuffer = interface;
  IDirect3DLight = interface;
  IDirect3DMaterial = interface;
  IDirect3DMaterial2 = interface;
   // DIRECT3D_VERSION_5
  IDirect3DMaterial3 = interface;
   // DIRECT3D_VERSION_6
  IDirect3DTexture = interface;
  IDirect3DTexture2 = interface;
   // DIRECT3D_VERSION_5
  IDirect3DViewport = interface;
  IDirect3DViewport2 = interface;
   // DIRECT3D_VERSION_5
  IDirect3DViewport3 = interface;
  IDirect3DVertexBuffer = interface;
   // DIRECT3D_VERSION_6
  IDirect3DVertexBuffer7 = interface;
   // DIRECT3D_VERSION_7


(*
 * Interface IID's
 *)
  IID_IDirect3D = IDirect3D;
  {$EXTERNALSYM IID_IDirect3D}
  IID_IDirect3D2 = IDirect3D2;
  {$EXTERNALSYM IID_IDirect3D2}
   // DIRECT3D_VERSION_5
  IID_IDirect3D3 = IDirect3D3;
  {$EXTERNALSYM IID_IDirect3D3}
   // DIRECT3D_VERSION_6
  IID_IDirect3D7 = IDirect3D7;
  {$EXTERNALSYM IID_IDirect3D7}
   // DIRECT3D_VERSION_7


(*
 * Internal Guid to distinguish requested MMX from MMX being used as an RGB rasterizer
 *)

  IID_IDirect3DDevice = IDirect3DDevice;
  {$EXTERNALSYM IID_IDirect3DDevice}
  IID_IDirect3DDevice2 = IDirect3DDevice2;
  {$EXTERNALSYM IID_IDirect3DDevice2}
  IID_IDirect3DDevice3 = IDirect3DDevice3;
  {$EXTERNALSYM IID_IDirect3DDevice3}
  IID_IDirect3DDevice7 = IDirect3DDevice7;
  {$EXTERNALSYM IID_IDirect3DDevice7}

  IID_IDirect3DTexture = IDirect3DTexture;
  {$EXTERNALSYM IID_IDirect3DTexture}
  IID_IDirect3DTexture2 = IDirect3DTexture2;
  {$EXTERNALSYM IID_IDirect3DTexture2}

  IID_IDirect3DLight = IDirect3DLight;
  {$EXTERNALSYM IID_IDirect3DLight}

  IID_IDirect3DMaterial = IDirect3DMaterial;
  {$EXTERNALSYM IID_IDirect3DMaterial}
  IID_IDirect3DMaterial2 = IDirect3DMaterial2;
  {$EXTERNALSYM IID_IDirect3DMaterial2}
  IID_IDirect3DMaterial3 = IDirect3DMaterial3;
  {$EXTERNALSYM IID_IDirect3DMaterial3}

  IID_IDirect3DExecuteBuffer = IDirect3DExecuteBuffer;
  {$EXTERNALSYM IID_IDirect3DExecuteBuffer}
  IID_IDirect3DViewport = IDirect3DViewport;
  {$EXTERNALSYM IID_IDirect3DViewport}
  IID_IDirect3DViewport2 = IDirect3DViewport2;
  {$EXTERNALSYM IID_IDirect3DViewport2}
  IID_IDirect3DViewport3 = IDirect3DViewport3;
  {$EXTERNALSYM IID_IDirect3DViewport3}
  IID_IDirect3DVertexBuffer = IDirect3DVertexBuffer;
  {$EXTERNALSYM IID_IDirect3DVertexBuffer}
  IID_IDirect3DVertexBuffer7 = IDirect3DVertexBuffer7;
  {$EXTERNALSYM IID_IDirect3DVertexBuffer7}



(*
 * Direct3D interfaces
 *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3D);'}
  IDirect3D = interface(IUnknown)
    ['{3BBA0080-2421-11CF-A31A-00AA00B93356}']
    (*** IDirect3D methods ***)
    function Initialize(lpREFIID: {REFIID} PGUID): HResult; stdcall;
    function EnumDevices(lpEnumDevicesCallback: TD3DEnumDevicesCallback;
        lpUserArg: Pointer): HResult; stdcall;
    function CreateLight(var lplpDirect3Dlight: IDirect3DLight;
        pUnkOuter: IUnknown): HResult; stdcall;
    function CreateMaterial(var lplpDirect3DMaterial: IDirect3DMaterial;
        pUnkOuter: IUnknown): HResult; stdcall;
    function CreateViewport(var lplpD3DViewport: IDirect3DViewport;
        pUnkOuter: IUnknown): HResult; stdcall;
    function FindDevice(var lpD3DFDS: TD3DFindDeviceSearch;
        var lpD3DFDR: TD3DFindDeviceResult): HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3D2);'}
  {$EXTERNALSYM IDirect3D2}
  IDirect3D2 = interface(IUnknown)
    ['{6aae1ec1-662a-11d0-889d-00aa00bbb76a}']
    (*** IDirect3D2 methods ***)
    function EnumDevices(lpEnumDevicesCallback: TD3DEnumDevicesCallback;
        lpUserArg: Pointer): HResult; stdcall;
    function CreateLight(var lplpDirect3Dlight: IDirect3DLight;
        pUnkOuter: IUnknown): HResult; stdcall;
    function CreateMaterial(var lplpDirect3DMaterial2: IDirect3DMaterial2;
        pUnkOuter: IUnknown): HResult; stdcall;
    function CreateViewport(var lplpD3DViewport2: IDirect3DViewport2;
        pUnkOuter: IUnknown): HResult; stdcall;
    function FindDevice(var lpD3DFDS: TD3DFindDeviceSearch;
        var lpD3DFDR: TD3DFindDeviceResult): HResult; stdcall;
    function CreateDevice(const rclsid: TRefClsID; lpDDS: IDirectDrawSurface;
        out lplpD3DDevice2: IDirect3DDevice2): HResult; stdcall;
  end;
 // DIRECT3D_VERSION_5

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3D3);'}
  {$EXTERNALSYM IDirect3D3}
  IDirect3D3 = interface(IUnknown)
    ['{bb223240-e72b-11d0-a9b4-00aa00c0993e}']
    (*** IDirect3D3 methods ***)
    function EnumDevices(lpEnumDevicesCallback: TD3DEnumDevicesCallback;
        lpUserArg: pointer): HResult; stdcall;
    function CreateLight(var lplpDirect3Dlight: IDirect3DLight;
        pUnkOuter: IUnknown): HResult; stdcall;
    function CreateMaterial(var lplpDirect3DMaterial3: IDirect3DMaterial3;
        pUnkOuter: IUnknown): HResult; stdcall;
    function CreateViewport(var lplpD3DViewport3: IDirect3DViewport3;
        pUnkOuter: IUnknown): HResult; stdcall;
    function FindDevice(var lpD3DFDS: TD3DFindDeviceSearch;
        var lpD3DFDR: TD3DFindDeviceResult): HResult; stdcall;
    function CreateDevice(const rclsid: TRefClsID; lpDDS: IDirectDrawSurface4;
        out lplpD3DDevice: IDirect3DDevice3; pUnkOuter: IUnknown): HResult; stdcall;
    function CreateVertexBuffer(var lpVBDesc: TD3DVertexBufferDesc;
        var lpD3DVertexBuffer: IDirect3DVertexBuffer;
        dwFlags: DWORD; pUnkOuter: IUnknown): HResult; stdcall;
    function EnumZBufferFormats(const riidDevice: TRefClsID; lpEnumCallback:
        TD3DEnumPixelFormatsCallback; lpContext: Pointer): HResult; stdcall;
    function EvictManagedTextures : HResult; stdcall;
  end;
 // DIRECT3D_VERSION_6

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3D7);'}
  {$EXTERNALSYM IDirect3D7}
  IDirect3D7 = interface(IUnknown)
    ['{f5049e77-4861-11d2-a407-00a0c90629a8}']
    (*** IDirect3D7 methods ***)
    function EnumDevices(lpEnumDevicesCallback: TD3DEnumDevicesCallback7;
        lpUserArg: pointer): HResult; stdcall;
    function CreateDevice(const rclsid: TGUID; lpDDS: IDirectDrawSurface7;
        out lplpD3DDevice: IDirect3DDevice7): HResult; stdcall;
    function CreateVertexBuffer(const lpVBDesc: TD3DVertexBufferDesc;
        out lplpD3DVertexBuffer: IDirect3DVertexBuffer7;
        dwFlags: DWORD): HResult; stdcall;
    function EnumZBufferFormats(const riidDevice: TGUID; lpEnumCallback:
        TD3DEnumPixelFormatsCallback; lpContext: pointer): HResult; stdcall;
    function EvictManagedTextures : HResult; stdcall;
  end;
 // DIRECT3D_VERSION_7

(*
 * Direct3D Device interfaces
 *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DDevice);'}
  {$EXTERNALSYM IDirect3DDevice}
  IDirect3DDevice = interface(IUnknown)
    ['{64108800-957d-11d0-89ab-00a0c9054129}']
    (*** IDirect3DDevice methods ***)
    function Initialize(lpd3d: IDirect3D; lpGUID: PGUID;
        var lpd3ddvdesc: TD3DDeviceDesc): HResult; stdcall;
    function GetCaps(var lpD3DHWDevDesc: TD3DDeviceDesc;
        var lpD3DHELDevDesc: TD3DDeviceDesc): HResult; stdcall;
    function SwapTextureHandles(lpD3DTex1: IDirect3DTexture;
        lpD3DTex2: IDirect3DTexture): HResult; stdcall;
    function CreateExecuteBuffer(var lpDesc: TD3DExecuteBufferDesc ;
        var lplpDirect3DExecuteBuffer: IDirect3DExecuteBuffer;
        pUnkOuter: IUnknown): HResult; stdcall;
    function GetStats(var lpD3DStats: TD3DStats): HResult; stdcall;
    function Execute(lpDirect3DExecuteBuffer: IDirect3DExecuteBuffer;
        lpDirect3DViewport: IDirect3DViewport; dwFlags: DWORD): HResult; stdcall;
    function AddViewport(lpDirect3DViewport: IDirect3DViewport): HResult; stdcall;
    function DeleteViewport(lpDirect3DViewport: IDirect3DViewport): HResult; stdcall;
    function NextViewport(lpDirect3DViewport: IDirect3DViewport;
        var lplpDirect3DViewport: IDirect3DViewport; dwFlags: DWORD): HResult; stdcall;
    function Pick(lpDirect3DExecuteBuffer: IDirect3DExecuteBuffer;
        lpDirect3DViewport: IDirect3DViewport; dwFlags: DWORD;
        var lpRect: TD3DRect): HResult; stdcall;
    function GetPickRecords(var lpCount: DWORD;
        var lpD3DPickRec: TD3DPickRecord): HResult; stdcall;
    function EnumTextureFormats(lpd3dEnumTextureProc:
        TD3DEnumTextureFormatsCallback; lpArg: Pointer):
        HResult; stdcall;
    function CreateMatrix(var lpD3DMatHandle: TD3DMatrixHandle): HResult; stdcall;
    function SetMatrix(d3dMatHandle: TD3DMatrixHandle;
        var lpD3DMatrix: TD3DMatrix): HResult; stdcall;
    function GetMatrix(var lpD3DMatHandle: TD3DMatrixHandle;
        var lpD3DMatrix: TD3DMatrix): HResult; stdcall;
    function DeleteMatrix(d3dMatHandle: TD3DMatrixHandle): HResult; stdcall;
    function BeginScene: HResult; stdcall;
    function EndScene: HResult; stdcall;
    function GetDirect3D(var lpD3D: IDirect3D): HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DDevice2);'}
  {$EXTERNALSYM IDirect3DDevice2}
  IDirect3DDevice2 = interface(IUnknown)
    ['{93281501-8cf8-11d0-89ab-00a0c9054129}']
    (*** IDirect3DDevice2 methods ***)
    function GetCaps(var lpD3DHWDevDesc: TD3DDeviceDesc;
        var lpD3DHELDevDesc: TD3DDeviceDesc): HResult; stdcall;
    function SwapTextureHandles(lpD3DTex1: IDirect3DTexture2;
        lpD3DTex2: IDirect3DTexture2): HResult; stdcall;
    function GetStats(var lpD3DStats: TD3DStats): HResult; stdcall;
    function AddViewport(lpDirect3DViewport2: IDirect3DViewport2): HResult; stdcall;
    function DeleteViewport(lpDirect3DViewport: IDirect3DViewport2): HResult; stdcall;
    function NextViewport(lpDirect3DViewport: IDirect3DViewport2;
        var lplpDirect3DViewport: IDirect3DViewport2; dwFlags: DWORD):
        HResult; stdcall;
    function EnumTextureFormats(
        lpd3dEnumTextureProc: TD3DEnumTextureFormatsCallback; lpArg: Pointer):
        HResult; stdcall;
    function BeginScene: HResult; stdcall;
    function EndScene: HResult; stdcall;
    function GetDirect3D(var lpD3D: IDirect3D2): HResult; stdcall;

    (*** DrawPrimitive API ***)
    function SetCurrentViewport(lpd3dViewport2: IDirect3DViewport2)
        : HResult; stdcall;
    function GetCurrentViewport(var lplpd3dViewport2: IDirect3DViewport2)
        : HResult; stdcall;

    function SetRenderTarget(lpNewRenderTarget: IDirectDrawSurface)
        : HResult; stdcall;
    function GetRenderTarget(var lplpNewRenderTarget: IDirectDrawSurface)
        : HResult; stdcall;

    function Begin_(d3dpt: TD3DPrimitiveType; d3dvt: TD3DVertexType;
        dwFlags: DWORD): HResult; stdcall;
    function BeginIndexed(dptPrimitiveType: TD3DPrimitiveType; dvtVertexType:
        TD3DVertexType; lpvVertices: pointer; dwNumVertices: DWORD;
        dwFlags: DWORD): HResult; stdcall;
    function Vertex(lpVertexType: pointer): HResult;  stdcall;
    function Index(wVertexIndex: WORD): HResult;  stdcall;
    function End_(dwFlags: DWORD): HResult; stdcall;

    function GetRenderState(dwRenderStateType: TD3DRenderStateType;
        var lpdwRenderState): HResult; stdcall;
    function SetRenderState(dwRenderStateType: TD3DRenderStateType;
        dwRenderState: DWORD): HResult; stdcall;
    function GetLightState(dwLightStateType: TD3DLightStateType;
        var lpdwLightState): HResult; stdcall;
    function SetLightState(dwLightStateType: TD3DLightStateType;
        dwLightState: DWORD): HResult; stdcall;
    function SetTransform(dtstTransformStateType: TD3DTransformStateType;
        var lpD3DMatrix: TD3DMatrix): HResult; stdcall;
    function GetTransform(dtstTransformStateType: TD3DTransformStateType;
        var lpD3DMatrix: TD3DMatrix): HResult; stdcall;
    function MultiplyTransform(dtstTransformStateType: TD3DTransformStateType;
        var lpD3DMatrix: TD3DMatrix): HResult; stdcall;

    function DrawPrimitive(dptPrimitiveType: TD3DPrimitiveType;
        dvtVertexType: TD3DVertexType; var lpvVertices; dwVertexCount,
        dwFlags: DWORD): HResult; stdcall;
    function DrawIndexedPrimitive(dptPrimitiveType: TD3DPrimitiveType;
        dwVertexTypeDesc: DWORD; lpvVertices: pointer; dwVertexCount: DWORD;
        var lpwIndices: WORD; dwIndexCount, dwFlags: DWORD): HResult; stdcall;
    function SetClipStatus(var lpD3DClipStatus: TD3DClipStatus): HResult; stdcall;
    function GetClipStatus(var lpD3DClipStatus: TD3DClipStatus): HResult; stdcall;
  end;
 // DIRECT3D_VERSION_5

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DDevice3);'}
  {$EXTERNALSYM IDirect3DDevice3}
  IDirect3DDevice3 = interface(IUnknown)
    ['{b0ab3b60-33d7-11d1-a981-00c04fd7b174}']
    (*** IDirect3DDevice2 methods ***)
    function GetCaps(var lpD3DHWDevDesc: TD3DDeviceDesc;
        var lpD3DHELDevDesc: TD3DDeviceDesc): HResult; stdcall;
    function GetStats(var lpD3DStats: TD3DStats): HResult; stdcall;
    function AddViewport(lpDirect3DViewport: IDirect3DViewport3): HResult; stdcall;
    function DeleteViewport(lpDirect3DViewport: IDirect3DViewport3): HResult; stdcall;
    function NextViewport(lpDirect3DViewport: IDirect3DViewport3;
        var lplpAnotherViewport: IDirect3DViewport3; dwFlags: DWORD): HResult; stdcall;
    function EnumTextureFormats(
        lpd3dEnumPixelProc: TD3DEnumPixelFormatsCallback; lpArg: Pointer):
        HResult; stdcall;
    function BeginScene: HResult; stdcall;
    function EndScene: HResult; stdcall;
    function GetDirect3D(var lpD3D: IDirect3D3): HResult; stdcall;
    function SetCurrentViewport(lpd3dViewport: IDirect3DViewport3)
        : HResult; stdcall;
    function GetCurrentViewport(var lplpd3dViewport: IDirect3DViewport3)
        : HResult; stdcall;
    function SetRenderTarget(lpNewRenderTarget: IDirectDrawSurface4)
        : HResult; stdcall;
    function GetRenderTarget(var lplpNewRenderTarget: IDirectDrawSurface4)
        : HResult; stdcall;
    function Begin_(d3dpt: TD3DPrimitiveType; dwVertexTypeDesc: DWORD;
        dwFlags: DWORD): HResult; stdcall;
    function BeginIndexed(dptPrimitiveType: TD3DPrimitiveType;
        dwVertexTypeDesc: DWORD; lpvVertices: pointer; dwNumVertices: DWORD;
        dwFlags: DWORD): HResult; stdcall;
    function Vertex(lpVertex: pointer): HResult;  stdcall;
    function Index(wVertexIndex: WORD): HResult;  stdcall;
    function End_(dwFlags: DWORD): HResult; stdcall;
    function GetRenderState(dwRenderStateType: TD3DRenderStateType;
        var lpdwRenderState): HResult; stdcall;
    function SetRenderState(dwRenderStateType: TD3DRenderStateType;
        dwRenderState: DWORD): HResult; stdcall;
    function GetLightState(dwLightStateType: TD3DLightStateType;
        var lpdwLightState): HResult; stdcall;
    function SetLightState(dwLightStateType: TD3DLightStateType;
        dwLightState: DWORD): HResult; stdcall;
    function SetTransform(dtstTransformStateType: TD3DTransformStateType;
        var lpD3DMatrix: TD3DMatrix): HResult; stdcall;
    function GetTransform(dtstTransformStateType: TD3DTransformStateType;
        var lpD3DMatrix: TD3DMatrix): HResult; stdcall;
    function MultiplyTransform(dtstTransformStateType: TD3DTransformStateType;
        var lpD3DMatrix: TD3DMatrix): HResult; stdcall;
    function DrawPrimitive(dptPrimitiveType: TD3DPrimitiveType;
        dwVertexTypeDesc: DWORD; const lpvVertices;
        dwVertexCount, dwFlags: DWORD): HResult; stdcall;
    function DrawIndexedPrimitive(dptPrimitiveType: TD3DPrimitiveType;
        dwVertexTypeDesc: DWORD; const lpvVertices; dwVertexCount: DWORD;
        var lpwIndices: WORD; dwIndexCount, dwFlags: DWORD): HResult; stdcall;
    function SetClipStatus(var lpD3DClipStatus: TD3DClipStatus): HResult; stdcall;
    function GetClipStatus(var lpD3DClipStatus: TD3DClipStatus): HResult; stdcall;
    function DrawPrimitiveStrided(dptPrimitiveType: TD3DPrimitiveType;
        dwVertexTypeDesc : DWORD;
        var lpVertexArray: TD3DDrawPrimitiveStridedData;
        dwVertexCount, dwFlags: DWORD): HResult; stdcall;
    function DrawIndexedPrimitiveStrided(dptPrimitiveType: TD3DPrimitiveType;
        dwVertexTypeDesc : DWORD;
        var lpVertexArray: TD3DDrawPrimitiveStridedData; dwVertexCount: DWORD;
        var lpwIndices: WORD; dwIndexCount, dwFlags: DWORD): HResult; stdcall;
    function DrawPrimitiveVB(dptPrimitiveType: TD3DPrimitiveType;
        lpd3dVertexBuffer: IDirect3DVertexBuffer;
        dwStartVertex, dwNumVertices, dwFlags: DWORD): HResult; stdcall;
    function DrawIndexedPrimitiveVB(dptPrimitiveType: TD3DPrimitiveType;
        lpd3dVertexBuffer: IDirect3DVertexBuffer; var lpwIndices: WORD;
        dwIndexCount, dwFlags: DWORD): HResult; stdcall;
    function ComputeSphereVisibility(var lpCenters: TD3DVector;
        var lpRadii: TD3DValue; dwNumSpheres, dwFlags: DWORD;
        var lpdwReturnValues: DWORD): HResult; stdcall;
    function GetTexture(dwStage: DWORD; var lplpTexture: IDirect3DTexture2)
        : HResult; stdcall;
    function SetTexture(dwStage: DWORD; lplpTexture: IDirect3DTexture2)
        : HResult; stdcall;
    function GetTextureStageState(dwStage: DWORD;
        dwState: TD3DTextureStageStateType; var lpdwValue: DWORD): HResult; stdcall;
    function SetTextureStageState(dwStage: DWORD;
        dwState: TD3DTextureStageStateType; lpdwValue: DWORD): HResult; stdcall;
    function ValidateDevice(var lpdwExtraPasses: DWORD): HResult; stdcall;
  end;
 // DIRECT3D_VERSION_6

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DDevice7);'}
  {$EXTERNALSYM IDirect3DDevice7}
  IDirect3DDevice7 = interface(IUnknown)
    ['{f5049e79-4861-11d2-a407-00a0c90629a8}']
    (*** IDirect3DDevice7 methods ***)
    function GetCaps(out lpD3DDevDesc: TD3DDeviceDesc7): HResult; stdcall;
    function EnumTextureFormats(lpd3dEnumPixelProc: TD3DEnumPixelFormatsCallback; lpArg: Pointer): HResult; stdcall;
    function BeginScene: HResult; stdcall;
    function EndScene: HResult; stdcall;
    function GetDirect3D(out lpD3D: IDirect3D7): HResult; stdcall;
    function SetRenderTarget(lpNewRenderTarget: IDirectDrawSurface7; dwFlags: DWORD): HResult; stdcall;
    function GetRenderTarget(out lplpRenderTarget: IDirectDrawSurface7): HResult; stdcall;
    function Clear(dwCount: DWORD; lpRects: PD3DRect; dwFlags, dwColor: DWORD; dvZ: TD3DValue; dwStencil: DWORD): HResult; stdcall;
    function SetTransform(dtstTransformStateType: TD3DTransformStateType;
        const lpD3DMatrix: TD3DMatrix): HResult; stdcall;
    function GetTransform(dtstTransformStateType: TD3DTransformStateType;
        out lpD3DMatrix: TD3DMatrix): HResult; stdcall;
    function SetViewport(const lpViewport: TD3DViewport7): HResult; stdcall;
    function MultiplyTransform(dtstTransformStateType: TD3DTransformStateType;
        const lpD3DMatrix: TD3DMatrix): HResult; stdcall;
    function GetViewport(out lpViewport: TD3DViewport7): HResult; stdcall;
    function SetMaterial(const lpMaterial: TD3DMaterial7): HResult; stdcall;
    function GetMaterial(out lpMaterial: TD3DMaterial7): HResult; stdcall;
    function SetLight(dwLightIndex: DWORD; const lpLight: TD3DLight7): HResult; stdcall;
    function GetLight(dwLightIndex: DWORD; out lpLight: TD3DLight7): HResult; stdcall;
    function SetRenderState(dwRenderStateType: TD3DRenderStateType; dwRenderState: DWORD): HResult; stdcall;
    function GetRenderState(dwRenderStateType: TD3DRenderStateType; out dwRenderState: DWORD): HResult; stdcall;
    function BeginStateBlock : HResult; stdcall;
    function EndStateBlock(out lpdwBlockHandle: DWORD): HResult; stdcall;
    function PreLoad(lpddsTexture: IDirectDrawSurface7): HResult; stdcall;
    function DrawPrimitive(dptPrimitiveType: TD3DPrimitiveType;
        dwVertexTypeDesc: DWORD; const lpvVertices;
        dwVertexCount, dwFlags: DWORD): HResult; stdcall;
    function DrawIndexedPrimitive(dptPrimitiveType: TD3DPrimitiveType;
        dwVertexTypeDesc: DWORD; const lpvVertices; dwVertexCount: DWORD;
        const lpwIndices; dwIndexCount, dwFlags: DWORD): HResult; stdcall;
    function SetClipStatus(const lpD3DClipStatus: TD3DClipStatus): HResult; stdcall;
    function GetClipStatus(out lpD3DClipStatus: TD3DClipStatus): HResult; stdcall;
    function DrawPrimitiveStrided(dptPrimitiveType: TD3DPrimitiveType;
        dwVertexTypeDesc : DWORD;
        const lpVertexArray: TD3DDrawPrimitiveStridedData;
        dwVertexCount, dwFlags: DWORD): HResult; stdcall;
    function DrawIndexedPrimitiveStrided(dptPrimitiveType: TD3DPrimitiveType;
        dwVertexTypeDesc : DWORD;
        const lpVertexArray: TD3DDrawPrimitiveStridedData; dwVertexCount: DWORD;
        var lpwIndices: WORD; dwIndexCount, dwFlags: DWORD): HResult; stdcall;
    function DrawPrimitiveVB(dptPrimitiveType: TD3DPrimitiveType;
        lpd3dVertexBuffer: IDirect3DVertexBuffer7;
        dwStartVertex, dwNumVertices, dwFlags: DWORD): HResult; stdcall;
    function DrawIndexedPrimitiveVB(dptPrimitiveType: TD3DPrimitiveType;
        lpd3dVertexBuffer: IDirect3DVertexBuffer7; dwStartVertex, dwNumVertices: DWORD;
        var lpwIndices: WORD; dwIndexCount, dwFlags: DWORD): HResult; stdcall;
    function ComputeSphereVisibility(const lpCenters: TD3DVector;
        var lpRadii: TD3DValue; dwNumSpheres, dwFlags: DWORD;
        var lpdwReturnValues: DWORD): HResult; stdcall;
    function GetTexture(dwStage: DWORD; out lplpTexture: IDirectDrawSurface7): HResult; stdcall;
    function SetTexture(dwStage: DWORD; lpTexture: IDirectDrawSurface7): HResult; stdcall;
    function GetTextureStageState(dwStage: DWORD;
        dwState: TD3DTextureStageStateType; out lpdwValue: DWORD): HResult; stdcall;
    function SetTextureStageState(dwStage: DWORD;
        dwState: TD3DTextureStageStateType; lpdwValue: DWORD): HResult; stdcall;
    function ValidateDevice(out lpdwExtraPasses: DWORD): HResult; stdcall;
    function ApplyStateBlock(dwBlockHandle: DWORD): HResult; stdcall;
    function CaptureStateBlock(dwBlockHandle: DWORD): HResult; stdcall;
    function DeleteStateBlock(dwBlockHandle: DWORD): HResult; stdcall;
    function CreateStateBlock(d3dsbType: TD3DStateBlockType; out lpdwBlockHandle: DWORD): HResult; stdcall;
    function Load(lpDestTex: IDirectDrawSurface7; lpDestPoint: PPoint;
        lpSrcTex: IDirectDrawSurface7; lprcSrcRect: PRect; dwFlags: DWORD): HResult; stdcall;
    function LightEnable(dwLightIndex: DWORD; bEnable: BOOL): HResult; stdcall;
    function GetLightEnable(dwLightIndex: DWORD; out bEnable: BOOL): HResult; stdcall;
    function SetClipPlane(dwIndex: DWORD; pPlaneEquation: PD3DValue): HResult; stdcall;
    function GetClipPlane(dwIndex: DWORD; pPlaneEquation: PD3DValue): HResult; stdcall;
    function GetInfo(dwDevInfoID: DWORD; pDevInfoStruct: Pointer; dwSize: DWORD): HResult; stdcall;
  end;
 // DIRECT3D_VERSION_7

(*
 * Execute Buffer interface
 *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DExecuteBuffer);'}
  {$EXTERNALSYM IDirect3DExecuteBuffer}
  IDirect3DExecuteBuffer = interface(IUnknown)
    ['{4417C145-33AD-11CF-816F-0000C020156E}']
    (*** IDirect3DExecuteBuffer methods ***)
    function Initialize(lpDirect3DDevice: IDirect3DDevice;
        var lpDesc: TD3DExecuteBufferDesc): HResult; stdcall;
    function Lock(var lpDesc: TD3DExecuteBufferDesc): HResult; stdcall;
    function Unlock: HResult; stdcall;
    function SetExecuteData(var lpData: TD3DExecuteData): HResult; stdcall;
    function GetExecuteData(var lpData: TD3DExecuteData): HResult; stdcall;
    function Validate(var lpdwOffset: DWORD; lpFunc: TD3DValidateCallback;
        lpUserArg: Pointer; dwReserved: DWORD): HResult; stdcall;
    (*** Warning!  Optimize is defined differently in the header files
         and the online documentation ***)
    function Optimize(dwFlags: DWORD): HResult; stdcall;
  end;

(*
 * Light interfaces
 *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DLight);'}
  {$EXTERNALSYM IDirect3DLight}
  IDirect3DLight = interface(IUnknown)
    ['{4417C142-33AD-11CF-816F-0000C020156E}']
    (*** IDirect3DLight methods ***)
    function Initialize(lpDirect3D: IDirect3D): HResult; stdcall;
    function SetLight(var lpLight: TD3DLight2): HResult; stdcall;
    function GetLight(var lpLight: TD3DLight2): HResult; stdcall;
  end;

(*
 * Material interfaces
 *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DMaterial);'}
  {$EXTERNALSYM IDirect3DMaterial}
  IDirect3DMaterial = interface(IUnknown)
    ['{4417C144-33AD-11CF-816F-0000C020156E}']
    (*** IDirect3DMaterial methods ***)
    function Initialize(lpDirect3D: IDirect3D): HResult; stdcall;
    function SetMaterial(var lpMat: TD3DMaterial): HResult; stdcall;
    function GetMaterial(var lpMat: TD3DMaterial): HResult; stdcall;
    function GetHandle(lpDirect3DDevice: IDirect3DDevice;
        var lpHandle: TD3DMaterialHandle): HResult; stdcall;
    function Reserve: HResult; stdcall;
    function Unreserve: HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DMaterial2);'}
  {$EXTERNALSYM IDirect3DMaterial2}
  IDirect3DMaterial2 = interface(IUnknown)
    ['{93281503-8cf8-11d0-89ab-00a0c9054129}']
    (*** IDirect3DMaterial2 methods ***)
    function SetMaterial(var lpMat: TD3DMaterial): HResult; stdcall;
    function GetMaterial(var lpMat: TD3DMaterial): HResult; stdcall;
    function GetHandle(lpDirect3DDevice: IDirect3DDevice2;
        var lpHandle: TD3DMaterialHandle): HResult; stdcall;
  end;
 // DIRECT3D_VERSION_5

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DMaterial3);'}
  {$EXTERNALSYM IDirect3DMaterial3}
  IDirect3DMaterial3 = interface(IUnknown)
    ['{ca9c46f4-d3c5-11d1-b75a-00600852b312}']
    (*** IDirect3DMaterial2 methods ***)
    function SetMaterial(var lpMat: TD3DMaterial): HResult; stdcall;
    function GetMaterial(var lpMat: TD3DMaterial): HResult; stdcall;
    function GetHandle(lpDirect3DDevice: IDirect3DDevice3;
        var lpHandle: TD3DMaterialHandle): HResult; stdcall;
  end;
 // DIRECT3D_VERSION_6

(*
 * Texture interfaces
 *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DTexture);'}
  {$EXTERNALSYM IDirect3DTexture}
  IDirect3DTexture = interface(IUnknown)
    ['{2CDCD9E0-25A0-11CF-A31A-00AA00B93356}']
    (*** IDirect3DTexture methods ***)
    function Initialize(lpD3DDevice: IDirect3DDevice;
        lpDDSurface: IDirectDrawSurface): HResult; stdcall;
    function GetHandle(lpDirect3DDevice: IDirect3DDevice;
        var lpHandle: TD3DTextureHandle): HResult; stdcall;
    function PaletteChanged(dwStart: DWORD; dwCount: DWORD): HResult; stdcall;
    function Load(lpD3DTexture: IDirect3DTexture): HResult; stdcall;
    function Unload: HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DTexture2);'}
  {$EXTERNALSYM IDirect3DTexture2}
  IDirect3DTexture2 = interface(IUnknown)
    ['{93281502-8cf8-11d0-89ab-00a0c9054129}']
    (*** IDirect3DTexture2 methods ***)
    function GetHandle(lpDirect3DDevice: IDirect3DDevice2;
        var lpHandle: TD3DTextureHandle): HResult; stdcall;
    function PaletteChanged(dwStart: DWORD; dwCount: DWORD): HResult; stdcall;
    function Load(lpD3DTexture: IDirect3DTexture2): HResult; stdcall;
  end;
 // DIRECT3D_VERSION_5

(*
 * Viewport interfaces
 *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DViewport);'}
  {$EXTERNALSYM IDirect3DViewport}
  IDirect3DViewport = interface(IUnknown)
    ['{4417C146-33AD-11CF-816F-0000C020156E}']
    (*** IDirect3DViewport methods ***)
    function Initialize(lpDirect3D: IDirect3D): HResult; stdcall;
    function GetViewport(out lpData: TD3DViewport): HResult; stdcall;
    function SetViewport(const lpData: TD3DViewport): HResult; stdcall;
    function TransformVertices(dwVertexCount: DWORD;
        const lpData: TD3DTransformData; dwFlags: DWORD;
        out lpOffscreen: DWORD): HResult; stdcall;
    function LightElements(dwElementCount: DWORD;
        var lpData: TD3DLightData): HResult; stdcall;
    function SetBackground(hMat: TD3DMaterialHandle): HResult; stdcall;
    function GetBackground(out hMat: TD3DMaterialHandle): HResult; stdcall;
    function SetBackgroundDepth(lpDDSurface: IDirectDrawSurface):
        HResult; stdcall;
    function GetBackgroundDepth(out lplpDDSurface: IDirectDrawSurface;
        out lpValid: BOOL): HResult; stdcall;
    function Clear(dwCount: DWORD; const lpRects: TD3DRect; dwFlags: DWORD):
        HResult; stdcall;
    function AddLight(lpDirect3DLight: IDirect3DLight): HResult; stdcall;
    function DeleteLight(lpDirect3DLight: IDirect3DLight): HResult; stdcall;
     function NextLight(lpDirect3DLight: IDirect3DLight;
        out lplpDirect3DLight: IDirect3DLight; dwFlags: DWORD): HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DViewport2);'}
  {$EXTERNALSYM IDirect3DViewport2}
  IDirect3DViewport2 = interface(IUnknown)
    ['{93281500-8cf8-11d0-89ab-00a0c9054129}']
    (*** IDirect3DViewport2 methods ***)
    function Initialize(lpDirect3D: IDirect3D): HResult; stdcall;
    function GetViewport(out lpData: TD3DViewport): HResult; stdcall;
    function SetViewport(const lpData: TD3DViewport): HResult; stdcall;
    function TransformVertices(dwVertexCount: DWORD;
        const lpData: TD3DTransformData; dwFlags: DWORD;
        out lpOffscreen: DWORD): HResult; stdcall;
    function LightElements(dwElementCount: DWORD;
        var lpData: TD3DLightData): HResult; stdcall;
    function SetBackground(hMat: TD3DMaterialHandle): HResult; stdcall;
    function GetBackground(out hMat: TD3DMaterialHandle): HResult; stdcall;
    function SetBackgroundDepth(lpDDSurface: IDirectDrawSurface):
        HResult; stdcall;
    function GetBackgroundDepth(out lplpDDSurface: IDirectDrawSurface;
        out lpValid: BOOL): HResult; stdcall;
    function Clear(dwCount: DWORD; const lpRects: TD3DRect; dwFlags: DWORD):
        HResult; stdcall;
    function AddLight(lpDirect3DLight: IDirect3DLight): HResult; stdcall;
    function DeleteLight(lpDirect3DLight: IDirect3DLight): HResult; stdcall;
    function NextLight(lpDirect3DLight: IDirect3DLight;
        out lplpDirect3DLight: IDirect3DLight; dwFlags: DWORD): HResult; stdcall;
    (*** IDirect3DViewport2 methods ***)
    function GetViewport2(out lpData: TD3DViewport2): HResult; stdcall;
    function SetViewport2(const lpData: TD3DViewport2): HResult; stdcall;
  end;
 // DIRECT3D_VERSION_5

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DViewport3);'}
  {$EXTERNALSYM IDirect3DViewport3}
  IDirect3DViewport3 = interface(IUnknown)
    ['{b0ab3b61-33d7-11d1-a981-00c04fd7b174}']
    (*** IDirect3DViewport3 methods ***)
    function Initialize(lpDirect3D: IDirect3D): HResult; stdcall;
    function GetViewport(out lpData: TD3DViewport): HResult; stdcall;
    function SetViewport(const lpData: TD3DViewport): HResult; stdcall;
    function TransformVertices(dwVertexCount: DWORD;
        const lpData: TD3DTransformData; dwFlags: DWORD;
        out lpOffscreen: DWORD): HResult; stdcall;
    function LightElements(dwElementCount: DWORD;
        var lpData: TD3DLightData): HResult; stdcall;
    function SetBackground(hMat: TD3DMaterialHandle): HResult; stdcall;
    function GetBackground(var hMat: TD3DMaterialHandle): HResult; stdcall;
    function SetBackgroundDepth(
        lpDDSurface: IDirectDrawSurface): HResult; stdcall;
    function GetBackgroundDepth(out lplpDDSurface: IDirectDrawSurface;
        out lpValid: BOOL): HResult; stdcall;
    function Clear(dwCount: DWORD; const lpRects: TD3DRect; dwFlags: DWORD):
        HResult; stdcall;
    function AddLight(lpDirect3DLight: IDirect3DLight): HResult; stdcall;
    function DeleteLight(lpDirect3DLight: IDirect3DLight): HResult; stdcall;
    function NextLight(lpDirect3DLight: IDirect3DLight;
        out lplpDirect3DLight: IDirect3DLight; dwFlags: DWORD): HResult; stdcall;
    function GetViewport2(out lpData: TD3DViewport2): HResult; stdcall;
    function SetViewport2(const lpData: TD3DViewport2): HResult; stdcall;
    function SetBackgroundDepth2(
        lpDDSurface: IDirectDrawSurface4): HResult; stdcall;
    function GetBackgroundDepth2(out lplpDDSurface: IDirectDrawSurface4;
        out lpValid: BOOL): HResult; stdcall;
    function Clear2(dwCount: DWORD; const lpRects: TD3DRect; dwFlags: DWORD;
        dwColor: DWORD; dvZ: TD3DValue; dwStencil: DWORD): HResult; stdcall;
  end;
 // DIRECT3D_VERSION_6

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVertexBuffer);'}
  {$EXTERNALSYM IDirect3DVertexBuffer}
  IDirect3DVertexBuffer = interface(IUnknown)
    ['{7a503555-4a83-11d1-a5db-00a0c90367f8}']
    (*** IDirect3DVertexBuffer methods ***)
    function Lock(dwFlags: DWORD; var lplpData: pointer; var lpdwSize: DWORD)
        : HResult; stdcall;
    function Unlock : HResult; stdcall;
    function ProcessVertices(dwVertexOp, dwDestIndex, dwCount: DWORD;
        lpSrcBuffer: IDirect3DVertexBuffer; dwSrcIndex: DWORD;
        lpD3DDevice: IDirect3DDevice3; dwFlags: DWORD): HResult; stdcall;
    function GetVertexBufferDesc(var lpVBDesc: TD3DVertexBufferDesc): HResult; stdcall;
    function Optimize(lpD3DDevice: IDirect3DDevice3; dwFlags: DWORD): HResult; stdcall;
  end;
 // DIRECT3D_VERSION_6

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVertexBuffer7);'}
  {$EXTERNALSYM IDirect3DVertexBuffer7}
  IDirect3DVertexBuffer7 = interface(IUnknown)
    ['{f5049e7d-4861-11d2-a407-00a0c90629a8}']
    (*** IDirect3DVertexBuffer methods ***)
    function Lock(dwFlags: DWORD; out lplpData: Pointer; out lpdwSize: DWORD): HResult; stdcall;
    function Unlock : HResult; stdcall;
    function ProcessVertices(dwVertexOp, dwDestIndex, dwCount: DWORD;
        lpSrcBuffer: IDirect3DVertexBuffer7; dwSrcIndex: DWORD;
        lpD3DDevice: IDirect3DDevice7; dwFlags: DWORD): HResult; stdcall;
    function GetVertexBufferDesc(out lpVBDesc: TD3DVertexBufferDesc): HResult; stdcall;
    function Optimize(lpD3DDevice: IDirect3DDevice7; dwFlags: DWORD): HResult; stdcall;
    function ProcessVerticesStrided(dwVertexOp, dwDestIndex, dwCount: DWORD;
      lpVertexArray: TD3DDrawPrimitiveStridedData; dwVertexTypeDesc: DWORD;
      lpD3DDevice: IDirect3DDevice7; dwFlags: DWORD): HResult; stdcall;
  end;
 // DIRECT3D_VERSION_7

const
(****************************************************************************
 *
 * Flags for IDirect3DDevice::NextViewport
 *
 ****************************************************************************)

(*
 * Return the next viewport
 *)
  D3DNEXT_NEXT =	$00000001;
  {$EXTERNALSYM D3DNEXT_NEXT}

(*
 * Return the first viewport
 *)
  D3DNEXT_HEAD =	$00000002;
  {$EXTERNALSYM D3DNEXT_HEAD}

(*
 * Return the last viewport
 *)
  D3DNEXT_TAIL =	$00000004;
  {$EXTERNALSYM D3DNEXT_TAIL}


(****************************************************************************
 *
 * Flags for DrawPrimitive/DrawIndexedPrimitive
 *   Also valid for Begin/BeginIndexed
 *   Also valid for VertexBuffer::CreateVertexBuffer
 ****************************************************************************)

(*
 * Wait until the device is ready to draw the primitive
 * This will cause DP to not return DDERR_WASSTILLDRAWING
 *)
  D3DDP_WAIT =					$00000001;
  {$EXTERNALSYM D3DDP_WAIT}

 // DIRECT3D_VERSION_LESS_6

(*
 * Hint that the primitives have been clipped by the application.
 *)
  D3DDP_DONOTCLIP =				$00000004;
  {$EXTERNALSYM D3DDP_DONOTCLIP}

(*
 * Hint that the extents need not be updated.
 *)
  D3DDP_DONOTUPDATEEXTENTS =	$00000008;
  {$EXTERNALSYM D3DDP_DONOTUPDATEEXTENTS}
 // DIRECT3D_VERSION_5


(*
 * Hint that the lighting should not be applied on vertices.
 *)

  D3DDP_DONOTLIGHT            = $00000010;
  {$EXTERNALSYM D3DDP_DONOTLIGHT}

 // DIRECT3D_VERSION_6


(*
 * Direct3D Errors
 * DirectDraw error codes are used when errors not specified here.
 *)

const
  MAKE_DDHRESULT = HResult($88760000);
  {$EXTERNALSYM MAKE_DDHRESULT}

  D3D_OK                          = DD_OK;
  {$EXTERNALSYM D3D_OK}
  D3DERR_BADMAJORVERSION          = MAKE_DDHRESULT + 700;
  {$EXTERNALSYM D3DERR_BADMAJORVERSION}
  D3DERR_BADMINORVERSION          = MAKE_DDHRESULT + 701;
  {$EXTERNALSYM D3DERR_BADMINORVERSION}

(*
 * An invalid device was requested by the application.
 *)
  D3DERR_INVALID_DEVICE   = MAKE_DDHRESULT + 705;
  {$EXTERNALSYM D3DERR_INVALID_DEVICE}
  D3DERR_INITFAILED       = MAKE_DDHRESULT + 706;
  {$EXTERNALSYM D3DERR_INITFAILED}

(*
 * SetRenderTarget attempted on a device that was
 * QI'd off the render target.
 *)
  D3DERR_DEVICEAGGREGATED = MAKE_DDHRESULT + 707;
  {$EXTERNALSYM D3DERR_DEVICEAGGREGATED}
 // DIRECT3D_VERSION_5

  D3DERR_EXECUTE_CREATE_FAILED    = MAKE_DDHRESULT + 710;
  {$EXTERNALSYM D3DERR_EXECUTE_CREATE_FAILED}
  D3DERR_EXECUTE_DESTROY_FAILED   = MAKE_DDHRESULT + 711;
  {$EXTERNALSYM D3DERR_EXECUTE_DESTROY_FAILED}
  D3DERR_EXECUTE_LOCK_FAILED      = MAKE_DDHRESULT + 712;
  {$EXTERNALSYM D3DERR_EXECUTE_LOCK_FAILED}
  D3DERR_EXECUTE_UNLOCK_FAILED    = MAKE_DDHRESULT + 713;
  {$EXTERNALSYM D3DERR_EXECUTE_UNLOCK_FAILED}
  D3DERR_EXECUTE_LOCKED           = MAKE_DDHRESULT + 714;
  {$EXTERNALSYM D3DERR_EXECUTE_LOCKED}
  D3DERR_EXECUTE_NOT_LOCKED       = MAKE_DDHRESULT + 715;
  {$EXTERNALSYM D3DERR_EXECUTE_NOT_LOCKED}

  D3DERR_EXECUTE_FAILED           = MAKE_DDHRESULT + 716;
  {$EXTERNALSYM D3DERR_EXECUTE_FAILED}
  D3DERR_EXECUTE_CLIPPED_FAILED   = MAKE_DDHRESULT + 717;
  {$EXTERNALSYM D3DERR_EXECUTE_CLIPPED_FAILED}

  D3DERR_TEXTURE_NO_SUPPORT       = MAKE_DDHRESULT + 720;
  {$EXTERNALSYM D3DERR_TEXTURE_NO_SUPPORT}
  D3DERR_TEXTURE_CREATE_FAILED    = MAKE_DDHRESULT + 721;
  {$EXTERNALSYM D3DERR_TEXTURE_CREATE_FAILED}
  D3DERR_TEXTURE_DESTROY_FAILED   = MAKE_DDHRESULT + 722;
  {$EXTERNALSYM D3DERR_TEXTURE_DESTROY_FAILED}
  D3DERR_TEXTURE_LOCK_FAILED      = MAKE_DDHRESULT + 723;
  {$EXTERNALSYM D3DERR_TEXTURE_LOCK_FAILED}
  D3DERR_TEXTURE_UNLOCK_FAILED    = MAKE_DDHRESULT + 724;
  {$EXTERNALSYM D3DERR_TEXTURE_UNLOCK_FAILED}
  D3DERR_TEXTURE_LOAD_FAILED      = MAKE_DDHRESULT + 725;
  {$EXTERNALSYM D3DERR_TEXTURE_LOAD_FAILED}
  D3DERR_TEXTURE_SWAP_FAILED      = MAKE_DDHRESULT + 726;
  {$EXTERNALSYM D3DERR_TEXTURE_SWAP_FAILED}
  D3DERR_TEXTURE_LOCKED           = MAKE_DDHRESULT + 727;
  {$EXTERNALSYM D3DERR_TEXTURE_LOCKED}
  D3DERR_TEXTURE_NOT_LOCKED       = MAKE_DDHRESULT + 728;
  {$EXTERNALSYM D3DERR_TEXTURE_NOT_LOCKED}
  D3DERR_TEXTURE_GETSURF_FAILED   = MAKE_DDHRESULT + 729;
  {$EXTERNALSYM D3DERR_TEXTURE_GETSURF_FAILED}

  D3DERR_MATRIX_CREATE_FAILED     = MAKE_DDHRESULT + 730;
  {$EXTERNALSYM D3DERR_MATRIX_CREATE_FAILED}
  D3DERR_MATRIX_DESTROY_FAILED    = MAKE_DDHRESULT + 731;
  {$EXTERNALSYM D3DERR_MATRIX_DESTROY_FAILED}
  D3DERR_MATRIX_SETDATA_FAILED    = MAKE_DDHRESULT + 732;
  {$EXTERNALSYM D3DERR_MATRIX_SETDATA_FAILED}
  D3DERR_MATRIX_GETDATA_FAILED    = MAKE_DDHRESULT + 733;
  {$EXTERNALSYM D3DERR_MATRIX_GETDATA_FAILED}
  D3DERR_SETVIEWPORTDATA_FAILED   = MAKE_DDHRESULT + 734;
  {$EXTERNALSYM D3DERR_SETVIEWPORTDATA_FAILED}

  D3DERR_INVALIDCURRENTVIEWPORT   = MAKE_DDHRESULT + 735;
  {$EXTERNALSYM D3DERR_INVALIDCURRENTVIEWPORT}
  D3DERR_INVALIDPRIMITIVETYPE     = MAKE_DDHRESULT + 736;
  {$EXTERNALSYM D3DERR_INVALIDPRIMITIVETYPE}
  D3DERR_INVALIDVERTEXTYPE        = MAKE_DDHRESULT + 737;
  {$EXTERNALSYM D3DERR_INVALIDVERTEXTYPE}
  D3DERR_TEXTURE_BADSIZE          = MAKE_DDHRESULT + 738;
  {$EXTERNALSYM D3DERR_TEXTURE_BADSIZE}
  D3DERR_INVALIDRAMPTEXTURE	  = MAKE_DDHRESULT + 739;
  {$EXTERNALSYM D3DERR_INVALIDRAMPTEXTURE}
 // DIRECT3D_VERSION_5

  D3DERR_MATERIAL_CREATE_FAILED   = MAKE_DDHRESULT + 740;
  {$EXTERNALSYM D3DERR_MATERIAL_CREATE_FAILED}
  D3DERR_MATERIAL_DESTROY_FAILED  = MAKE_DDHRESULT + 741;
  {$EXTERNALSYM D3DERR_MATERIAL_DESTROY_FAILED}
  D3DERR_MATERIAL_SETDATA_FAILED  = MAKE_DDHRESULT + 742;
  {$EXTERNALSYM D3DERR_MATERIAL_SETDATA_FAILED}
  D3DERR_MATERIAL_GETDATA_FAILED  = MAKE_DDHRESULT + 743;
  {$EXTERNALSYM D3DERR_MATERIAL_GETDATA_FAILED}

  D3DERR_INVALIDPALETTE	          = MAKE_DDHRESULT + 744;
  {$EXTERNALSYM D3DERR_INVALIDPALETTE}

  D3DERR_ZBUFF_NEEDS_SYSTEMMEMORY = MAKE_DDHRESULT + 745;
  {$EXTERNALSYM D3DERR_ZBUFF_NEEDS_SYSTEMMEMORY}
  D3DERR_ZBUFF_NEEDS_VIDEOMEMORY  = MAKE_DDHRESULT + 746;
  {$EXTERNALSYM D3DERR_ZBUFF_NEEDS_VIDEOMEMORY}
  D3DERR_SURFACENOTINVIDMEM       = MAKE_DDHRESULT + 747;
  {$EXTERNALSYM D3DERR_SURFACENOTINVIDMEM}
 // DIRECT3D_VERSION_5

  D3DERR_LIGHT_SET_FAILED         = MAKE_DDHRESULT + 750;
  {$EXTERNALSYM D3DERR_LIGHT_SET_FAILED}
  D3DERR_LIGHTHASVIEWPORT	  = MAKE_DDHRESULT + 751;
  {$EXTERNALSYM D3DERR_LIGHTHASVIEWPORT}
  D3DERR_LIGHTNOTINTHISVIEWPORT   = MAKE_DDHRESULT + 752;
  {$EXTERNALSYM D3DERR_LIGHTNOTINTHISVIEWPORT}
 // DIRECT3D_VERSION_5

  D3DERR_SCENE_IN_SCENE           = MAKE_DDHRESULT + 760;
  {$EXTERNALSYM D3DERR_SCENE_IN_SCENE}
  D3DERR_SCENE_NOT_IN_SCENE       = MAKE_DDHRESULT + 761;
  {$EXTERNALSYM D3DERR_SCENE_NOT_IN_SCENE}
  D3DERR_SCENE_BEGIN_FAILED       = MAKE_DDHRESULT + 762;
  {$EXTERNALSYM D3DERR_SCENE_BEGIN_FAILED}
  D3DERR_SCENE_END_FAILED         = MAKE_DDHRESULT + 763;
  {$EXTERNALSYM D3DERR_SCENE_END_FAILED}

  D3DERR_INBEGIN                  = MAKE_DDHRESULT + 770;
  {$EXTERNALSYM D3DERR_INBEGIN}
  D3DERR_NOTINBEGIN               = MAKE_DDHRESULT + 771;
  {$EXTERNALSYM D3DERR_NOTINBEGIN}
  D3DERR_NOVIEWPORTS              = MAKE_DDHRESULT + 772;
  {$EXTERNALSYM D3DERR_NOVIEWPORTS}
  D3DERR_VIEWPORTDATANOTSET       = MAKE_DDHRESULT + 773;
  {$EXTERNALSYM D3DERR_VIEWPORTDATANOTSET}
  D3DERR_VIEWPORTHASNODEVICE      = MAKE_DDHRESULT + 774;
  {$EXTERNALSYM D3DERR_VIEWPORTHASNODEVICE}
  D3DERR_NOCURRENTVIEWPORT        = MAKE_DDHRESULT + 775;
  {$EXTERNALSYM D3DERR_NOCURRENTVIEWPORT}
 // DIRECT3D_VERSION_5

  D3DERR_INVALIDVERTEXFORMAT      = MAKE_DDHRESULT + 2048;
  {$EXTERNALSYM D3DERR_INVALIDVERTEXFORMAT}

(*
 * Attempted to CreateTexture on a surface that had a color key
 *)
  D3DERR_COLORKEYATTACHED                 = MAKE_DDHRESULT + 2050;
  {$EXTERNALSYM D3DERR_COLORKEYATTACHED}

  D3DERR_VERTEXBUFFEROPTIMIZED            = MAKE_DDHRESULT + 2060;
  {$EXTERNALSYM D3DERR_VERTEXBUFFEROPTIMIZED}
  D3DERR_VBUF_CREATE_FAILED               = MAKE_DDHRESULT + 2061;
  {$EXTERNALSYM D3DERR_VBUF_CREATE_FAILED}
  D3DERR_VERTEXBUFFERLOCKED               = MAKE_DDHRESULT + 2062;
  {$EXTERNALSYM D3DERR_VERTEXBUFFERLOCKED}

  D3DERR_ZBUFFER_NOTPRESENT               = MAKE_DDHRESULT + 2070;
  {$EXTERNALSYM D3DERR_ZBUFFER_NOTPRESENT}
  D3DERR_STENCILBUFFER_NOTPRESENT         = MAKE_DDHRESULT + 2071;
  {$EXTERNALSYM D3DERR_STENCILBUFFER_NOTPRESENT}

  D3DERR_WRONGTEXTUREFORMAT               = MAKE_DDHRESULT + 2072;
  {$EXTERNALSYM D3DERR_WRONGTEXTUREFORMAT}
  D3DERR_UNSUPPORTEDCOLOROPERATION        = MAKE_DDHRESULT + 2073;
  {$EXTERNALSYM D3DERR_UNSUPPORTEDCOLOROPERATION}
  D3DERR_UNSUPPORTEDCOLORARG              = MAKE_DDHRESULT + 2074;
  {$EXTERNALSYM D3DERR_UNSUPPORTEDCOLORARG}
  D3DERR_UNSUPPORTEDALPHAOPERATION        = MAKE_DDHRESULT + 2075;
  {$EXTERNALSYM D3DERR_UNSUPPORTEDALPHAOPERATION}
  D3DERR_UNSUPPORTEDALPHAARG              = MAKE_DDHRESULT + 2076;
  {$EXTERNALSYM D3DERR_UNSUPPORTEDALPHAARG}
  D3DERR_TOOMANYOPERATIONS                = MAKE_DDHRESULT + 2077;
  {$EXTERNALSYM D3DERR_TOOMANYOPERATIONS}
  D3DERR_CONFLICTINGTEXTUREFILTER         = MAKE_DDHRESULT + 2078;
  {$EXTERNALSYM D3DERR_CONFLICTINGTEXTUREFILTER}
  D3DERR_UNSUPPORTEDFACTORVALUE           = MAKE_DDHRESULT + 2079;
  {$EXTERNALSYM D3DERR_UNSUPPORTEDFACTORVALUE}
  D3DERR_CONFLICTINGRENDERSTATE           = MAKE_DDHRESULT + 2081;
  {$EXTERNALSYM D3DERR_CONFLICTINGRENDERSTATE}
  D3DERR_UNSUPPORTEDTEXTUREFILTER         = MAKE_DDHRESULT + 2082;
  {$EXTERNALSYM D3DERR_UNSUPPORTEDTEXTUREFILTER}
  D3DERR_TOOMANYPRIMITIVES                = MAKE_DDHRESULT + 2083;
  {$EXTERNALSYM D3DERR_TOOMANYPRIMITIVES}
  D3DERR_INVALIDMATRIX                    = MAKE_DDHRESULT + 2084;
  {$EXTERNALSYM D3DERR_INVALIDMATRIX}
  D3DERR_TOOMANYVERTICES                  = MAKE_DDHRESULT + 2085;
  {$EXTERNALSYM D3DERR_TOOMANYVERTICES}
  D3DERR_CONFLICTINGTEXTUREPALETTE        = MAKE_DDHRESULT + 2086;
  {$EXTERNALSYM D3DERR_CONFLICTINGTEXTUREPALETTE}

 // DIRECT3D_VERSION_6

  D3DERR_INVALIDSTATEBLOCK        = MAKE_DDHRESULT + 2100;
  {$EXTERNALSYM D3DERR_INVALIDSTATEBLOCK}
  D3DERR_INBEGINSTATEBLOCK        = MAKE_DDHRESULT + 2101;
  {$EXTERNALSYM D3DERR_INBEGINSTATEBLOCK}
  D3DERR_NOTINBEGINSTATEBLOCK     = MAKE_DDHRESULT + 2102;
  {$EXTERNALSYM D3DERR_NOTINBEGINSTATEBLOCK}
 // DIRECT3D_VERSION_7

 // DIRECT3D_VERSION_LESS_8

procedure DisableFPUExceptions;
procedure EnableFPUExceptions;


implementation


function D3DFVF_TEXCOORDSIZE3(CoordIndex: DWORD): DWORD;
begin
  Result := (D3DFVF_TEXTUREFORMAT3 shl (CoordIndex*2 + 16));
end;

function D3DFVF_TEXCOORDSIZE2(CoordIndex: DWORD): DWORD;
begin
  Result := (D3DFVF_TEXTUREFORMAT2);
end;

function D3DFVF_TEXCOORDSIZE4(CoordIndex: DWORD): DWORD;
begin
  Result := (D3DFVF_TEXTUREFORMAT4 shl (CoordIndex*2 + 16));
end;

function D3DFVF_TEXCOORDSIZE1(CoordIndex: DWORD): DWORD;
begin
  Result := (D3DFVF_TEXTUREFORMAT1 shl (CoordIndex*2 + 16));
end;

 // DIRECT3D_VERSION_7
 // DIRECT3D_VERSION_LESS_8

function D3DVal(val: variant): Single;
begin
  Result := val;
end;

function D3DDivide(a, b: double): Single;
begin
  Result := a / b;
end;

function D3DMultiply(a, b: double): Single;
begin
  Result := a * b;
end;

// #define CI_GETALPHA(ci)    ((ci) >> 24)
function CI_GETALPHA(ci: DWORD): DWORD;
begin
  Result := ci shr 24;
end;

// #define CI_GETINDEX(ci)    (((ci) >> 8) & 0xffff)
function CI_GETINDEX(ci: DWORD): DWORD;
begin
  Result := (ci shr 8) and $ffff;
end;

// #define CI_GETFRACTION(ci) ((ci) & 0xff)
function CI_GETFRACTION(ci: DWORD): DWORD;
begin
  Result := ci and $ff;
end;

// #define CI_ROUNDINDEX(ci)  CI_GETINDEX((ci) + 0x80)
function CI_ROUNDINDEX(ci: DWORD): DWORD;
begin
  Result := CI_GETINDEX(ci + $80);
end;

// #define CI_MASKALPHA(ci)   ((ci) & 0xffffff)
function CI_MASKALPHA(ci: DWORD): DWORD;
begin
  Result := ci and $ffffff;
end;

// #define CI_MAKE(a, i, f)    (((a) << 24) | ((i) << 8) | (f))
function CI_MAKE(a,i,f: DWORD): DWORD;
begin
  Result := (a shl 24) or (i shl 8) or f;
end;

// #define RGBA_GETALPHA(rgb)      ((rgb) >> 24)
function RGBA_GETALPHA(rgb: TD3DColor): DWORD;
begin
  Result := rgb shr 24;
end;

// #define RGBA_GETRED(rgb)        (((rgb) >> 16) & 0xff)
function RGBA_GETRED(rgb: TD3DColor): DWORD;
begin
  Result := (rgb shr 16) and $ff;
end;

// #define RGBA_GETGREEN(rgb)      (((rgb) >> 8) & 0xff)
function RGBA_GETGREEN(rgb: TD3DColor): DWORD;
begin
  Result := (rgb shr 8) and $ff;
end;

// #define RGBA_GETBLUE(rgb)       ((rgb) & 0xff)
function RGBA_GETBLUE(rgb: TD3DColor): DWORD;
begin
  Result := rgb and $ff;
end;

// #define RGBA_MAKE(r, g, b, a)   ((TD3DColor) (((a) << 24) | ((r) << 16) | ((g) << 8) | (b)))
function RGBA_MAKE(r, g, b, a: DWORD): TD3DColor;
begin
  Result := (a shl 24) or (r shl 16) or (g shl 8) or b;
end;

// #define D3DRGB(r, g, b) \
//     (0xff000000L | (((long)((r) * 255)) << 16) | (((long)((g) * 255)) << 8) | (long)((b) * 255))
function D3DRGB(r, g, b: Single): TD3DColor;
begin
  Result := $ff000000 or DWORD(Round(r * 255) shl 16)
                      or DWORD(Round(g * 255) shl 8)
                      or DWORD(Round(b * 255));
end;

// #define D3DRGBA(r, g, b, a) \
//     (  (((long)((a) * 255)) << 24) | (((long)((r) * 255)) << 16) \
//     |   (((long)((g) * 255)) << 8) | (long)((b) * 255) \
//    )
function D3DRGBA(r, g, b, a: Single): TD3DColor;
begin
  Result := DWORD(Round(a * 255) shl 24) or DWORD(Round(r * 255) shl 16)
                                         or DWORD(Round(g * 255) shl 8)
                                         or DWORD(Round(b * 255));
end;

// #define RGB_GETRED(rgb)         (((rgb) >> 16) & 0xff)
function RGB_GETRED(rgb: TD3DColor): DWORD;
begin
  Result := (rgb shr 16) and $ff;
end;

// #define RGB_GETGREEN(rgb)       (((rgb) >> 8) & 0xff)
function RGB_GETGREEN(rgb: TD3DColor): DWORD;
begin
  Result := (rgb shr 8) and $ff;
end;

// #define RGB_GETBLUE(rgb)        ((rgb) & 0xff)
function RGB_GETBLUE(rgb: TD3DColor): DWORD;
begin
  Result := rgb and $ff;
end;

// #define RGBA_SETALPHA(rgba, x) (((x) << 24) | ((rgba) & 0x00ffffff))
function RGBA_SETALPHA(rgba: TD3DColor; x: DWORD): TD3DColor;
begin
  Result := (x shl 24) or (rgba and $00ffffff);
end;

// #define RGB_MAKE(r, g, b)       ((TD3DColor) (((r) << 16) | ((g) << 8) | (b)))
function RGB_MAKE(r, g, b: DWORD): TD3DColor;
begin
  Result := (r shl 16) or (g shl 8) or b;
end;

// #define RGBA_TORGB(rgba)       ((TD3DColor) ((rgba) & 0xffffff))
function RGBA_TORGB(rgba: TD3DColor): TD3DColor;
begin
  Result := rgba and $00ffffff;
end;

// #define RGB_TORGBA(rgb)        ((TD3DColor) ((rgb) | 0xff000000))
function RGB_TORGBA(rgb: TD3DColor): TD3DColor;
begin
  Result := rgb or $ff000000;
end;


function D3DSTATE_OVERRIDE(StateType: DWORD): DWORD;
begin
  Result := StateType + D3DSTATE_OVERRIDE_BIAS;
end;

function D3DTRIFLAG_STARTFLAT(len: DWORD): DWORD;
begin
  if not (len in [1..29]) then len := 0;
  Result := len;
end;

// #define D3DRENDERSTATE_STIPPLEPATTERN(y) (D3DRENDERSTATE_STIPPLEPATTERN00 + (y))
function D3DRENDERSTATE_STIPPLEPATTERN(y: Integer): TD3DRenderStateType;
begin
  Result := TD3DRenderStateType(Ord(D3DRENDERSTATE_STIPPLEPATTERN00) + y);
end;




    // Addition and subtraction
function VectorAdd(const v1, v2: TD3DVector): TD3DVector;
begin
  Result.x := v1.x+v2.x;
  Result.y := v1.y+v2.y;
  Result.z := v1.z+v2.z;
end;

function VectorSub(const v1, v2: TD3DVector): TD3DVector;
begin
  Result.x := v1.x-v2.x;
  Result.y := v1.y-v2.y;
  Result.z := v1.z-v2.z;
end;

    // Scalar multiplication and division
function VectorMulS(const v: TD3DVector; s: TD3DValue): TD3DVector;
begin
  Result.x := v.x*s;
  Result.y := v.y*s;
  Result.z := v.z*s;
end;

function VectorDivS(const v: TD3DVector; s: TD3DValue): TD3DVector;
begin
  Result.x := v.x/s;
  Result.y := v.y/s;
  Result.z := v.z/s;
end;

    // Memberwise multiplication and division
function VectorMul(const v1, v2: TD3DVector): TD3DVector;
begin
  Result.x := v1.x*v2.x;
  Result.y := v1.y*v2.y;
  Result.z := v1.z*v2.z;
end;

function VectorDiv(const v1, v2: TD3DVector): TD3DVector;
begin
  Result.x := v1.x/v2.x;
  Result.y := v1.y/v2.y;
  Result.z := v1.z/v2.z;
end;

    // Vector dominance
function VectorSmaller(v1, v2: TD3DVector): boolean;
begin
  result := (v1.x < v2.x) and (v1.y < v2.y) and (v1.z < v2.z);
end;

function VectorSmallerEqual(v1, v2: TD3DVector): boolean;
begin
  result := (v1.x <= v2.x) and (v1.y <= v2.y) and (v1.z <= v2.z);
end;

    // Bitwise equality
function VectorEqual(v1, v2: TD3DVector): boolean;
begin
  result := (v1.x = v2.x) and (v1.y = v2.y) and (v1.z = v2.z);
end;

    // Length-related functions
function VectorSquareMagnitude(v: TD3DVector): TD3DValue;
begin
  result := (v.x*v.x) + (v.y*v.y) + (v.z*v.z);
end;

function VectorMagnitude(v: TD3DVector): TD3DValue;
begin
  result := sqrt((v.x*v.x) + (v.y*v.y) + (v.z*v.z));
end;

    // Returns vector with same direction and unit length
function VectorNormalize(const v: TD3DVector): TD3DVector;
begin
  result := VectorDivS(v,VectorMagnitude(v));
end;

    // Return min/max component of the input vector
function VectorMin(v: TD3DVector): TD3DValue;
var
  ret : TD3DValue;
begin
  ret := v.x;
  if (v.y < ret) then ret := v.y;
  if (v.z < ret) then ret := v.z;
  Result := ret;
end;

function VectorMax(v: TD3DVector): TD3DValue;
var
  ret : TD3DValue;
begin
  ret := v.x;
  if (ret < v.y) then ret := v.y;
  if (ret < v.z) then ret := v.z;
  Result := ret;
end;

    // Return memberwise min/max of input vectors
function VectorMinimize(const v1, v2: TD3DVector): TD3DVector;
begin
  if v1.x < v2.x then Result.x := v1.x else Result.x := v2.x;
  if v1.y < v2.y then Result.y := v1.y else Result.y := v2.y;
  if v1.z < v2.z then Result.z := v1.z else Result.z := v2.z;
end;

function VectorMaximize(const v1, v2: TD3DVector): TD3DVector;
begin
  if v1.x > v2.x then Result.x := v1.x else Result.x := v2.x;
  if v1.y > v2.y then Result.y := v1.y else Result.y := v2.y;
  if v1.z > v2.z then Result.z := v1.z else Result.z := v2.z;
end;

    // Dot and cross product
function VectorDotProduct(v1, v2: TD3DVector): TD3DValue;
begin
  Result := (v1.x*v2.x) + (v1.y * v2.y) + (v1.z*v2.z);
end;

function VectorCrossProduct(const v1, v2: TD3DVector): TD3DVector;
begin
  Result.x := (v1.y*v2.z) - (v1.z*v2.y);
  Result.y := (v1.z*v2.x) - (v1.x*v2.z);
  Result.z := (v1.x*v2.y) - (v1.y*v2.x);
end;

procedure DisableFPUExceptions;
var
  FPUControlWord: Word;
asm
  FSTCW   FPUControlWord;
  OR      FPUControlWord, $4 + $1; { Divide by zero + invalid operation }
  FLDCW   FPUControlWord;
end;

procedure EnableFPUExceptions;
var
  FPUControlWord: Word;
asm
  FSTCW   FPUControlWord;
  AND     FPUControlWord, $FFFF - $4 - $1; { Divide by zero + invalid operation }
  FLDCW   FPUControlWord;
end;

function D3DErrorString(Value: HResult): String; //Full description not available yet
begin
  case Value of
    D3D_OK: Result := 'No error';

    D3DERR_BADMAJORVERSION: Result := 'D3DERR_BADMAJORVERSION';
    D3DERR_BADMINORVERSION: Result := 'D3DERR_BADMINORVERSION';

    D3DERR_INVALID_DEVICE: Result := 'D3DERR_INITFAILED';
    D3DERR_INITFAILED: Result := 'D3DERR_INITFAILED';

    D3DERR_DEVICEAGGREGATED: Result := 'D3DERR_DEVICEAGGREGATED';
   // DIRECT3D_VERSION_5

    D3DERR_EXECUTE_CREATE_FAILED: Result := 'D3DERR_EXECUTE_CREATE_FAILED';
    D3DERR_EXECUTE_DESTROY_FAILED: Result := 'D3DERR_EXECUTE_DESTROY_FAILED';
    D3DERR_EXECUTE_LOCK_FAILED: Result := 'D3DERR_EXECUTE_LOCK_FAILED';
    D3DERR_EXECUTE_UNLOCK_FAILED: Result := 'D3DERR_EXECUTE_UNLOCK_FAILED';
    D3DERR_EXECUTE_LOCKED: Result := 'D3DERR_EXECUTE_LOCKED';
    D3DERR_EXECUTE_NOT_LOCKED: Result := 'D3DERR_EXECUTE_NOT_LOCKED';

    D3DERR_EXECUTE_FAILED: Result := 'D3DERR_EXECUTE_FAILED';
    D3DERR_EXECUTE_CLIPPED_FAILED: Result := 'D3DERR_EXECUTE_CLIPPED_FAILED';

    D3DERR_TEXTURE_NO_SUPPORT: Result := 'D3DERR_TEXTURE_NO_SUPPORT';
    D3DERR_TEXTURE_CREATE_FAILED: Result := 'D3DERR_TEXTURE_CREATE_FAILED';
    D3DERR_TEXTURE_DESTROY_FAILED: Result := 'D3DERR_TEXTURE_DESTROY_FAILED';
    D3DERR_TEXTURE_LOCK_FAILED: Result := 'D3DERR_TEXTURE_LOCK_FAILED';
    D3DERR_TEXTURE_UNLOCK_FAILED: Result := 'D3DERR_TEXTURE_UNLOCK_FAILED';
    D3DERR_TEXTURE_LOAD_FAILED: Result := 'D3DERR_TEXTURE_LOAD_FAILED';
    D3DERR_TEXTURE_SWAP_FAILED: Result := 'D3DERR_TEXTURE_SWAP_FAILED';
    D3DERR_TEXTURE_LOCKED: Result := 'D3DERR_TEXTURELOCKED';
    D3DERR_TEXTURE_NOT_LOCKED: Result := 'D3DERR_TEXTURE_NOT_LOCKED';
    D3DERR_TEXTURE_GETSURF_FAILED: Result := 'D3DERR_TEXTURE_GETSURF_FAILED';

    D3DERR_MATRIX_CREATE_FAILED: Result := 'D3DERR_MATRIX_CREATE_FAILED';
    D3DERR_MATRIX_DESTROY_FAILED: Result := 'D3DERR_MATRIX_DESTROY_FAILED';
    D3DERR_MATRIX_SETDATA_FAILED: Result := 'D3DERR_MATRIX_SETDATA_FAILED';
    D3DERR_MATRIX_GETDATA_FAILED: Result := 'D3DERR_MATRIX_GETDATA_FAILED';
    D3DERR_SETVIEWPORTDATA_FAILED: Result := 'D3DERR_SETVIEWPORTDATA_FAILED';

    D3DERR_INVALIDCURRENTVIEWPORT: Result := 'D3DERR_INVALIDCURRENTVIEWPORT';
    D3DERR_INVALIDPRIMITIVETYPE: Result := 'D3DERR_INVALIDPRIMITIVETYPE';
    D3DERR_INVALIDVERTEXTYPE: Result := 'D3DERR_INVALIDVERTEXTYPE';
    D3DERR_TEXTURE_BADSIZE: Result := 'D3DERR_TEXTURE_BADSIZE';
    D3DERR_INVALIDRAMPTEXTURE: Result := 'D3DERR_INVALIDRAMPTEXTURE';
   // DIRECT3D_VERSION_5

    D3DERR_MATERIAL_CREATE_FAILED: Result := 'D3DERR_MATERIAL_CREATE_FAILED';
    D3DERR_MATERIAL_DESTROY_FAILED: Result := 'D3DERR_MATERIAL_DESTROY_FAILED';
    D3DERR_MATERIAL_SETDATA_FAILED: Result := 'D3DERR_MATERIAL_SETDATA_FAILED';
    D3DERR_MATERIAL_GETDATA_FAILED: Result := 'D3DERR_MATERIAL_GETDATA_FAILED';

    D3DERR_INVALIDPALETTE: Result := 'D3DERR_INVALIDPALETTE';

    D3DERR_ZBUFF_NEEDS_SYSTEMMEMORY: Result := 'D3DERR_ZBUFF_NEEDS_SYSTEMMEMORY';
    D3DERR_ZBUFF_NEEDS_VIDEOMEMORY: Result := 'D3DERR_ZBUFF_NEEDS_VIDEOMEMORY';
    D3DERR_SURFACENOTINVIDMEM: Result := 'D3DERR_SURFACENOTINVIDMEM';
   // DIRECT3D_VERSION_5

    D3DERR_LIGHT_SET_FAILED: Result := 'D3DERR_LIGHT_SET_FAILED';
    D3DERR_LIGHTHASVIEWPORT: Result := 'D3DERR_LIGHTHASVIEWPORT';
    D3DERR_LIGHTNOTINTHISVIEWPORT: Result := 'D3DERR_LIGHTNOTINTHISVIEWPORT';
   // DIRECT3D_VERSION_5

    D3DERR_SCENE_IN_SCENE: Result := 'D3DERR_SCENE_IN_SCENE';
    D3DERR_SCENE_NOT_IN_SCENE: Result := 'D3DERR_SCENE_NOT_IN_SCENE';
    D3DERR_SCENE_BEGIN_FAILED: Result := 'D3DERR_SCENE_BEGIN_FAILED';
    D3DERR_SCENE_END_FAILED: Result := 'D3DERR_SCENE_END_FAILED';

    D3DERR_INBEGIN: Result := 'D3DERR_INBEGIN';
    D3DERR_NOTINBEGIN: Result := 'D3DERR_NOTINBEGIN';
    D3DERR_NOVIEWPORTS: Result := 'D3DERR_NOVIEWPORTS';
    D3DERR_VIEWPORTDATANOTSET: Result := 'D3DERR_VIEWPORTDATANOTSET';
    D3DERR_VIEWPORTHASNODEVICE: Result := 'D3DERR_VIEWPORTHASNODEVICE';
    D3DERR_NOCURRENTVIEWPORT: Result := 'D3DERR_NOCURRENTVIEWPORT';
   // DIRECT3D_VERSION_5

    D3DERR_INVALIDVERTEXFORMAT: Result := 'D3DERR_INVALIDVERTEXFORMAT';

    D3DERR_COLORKEYATTACHED: Result := 'D3DERR_COLORKEYATTACHED';

    D3DERR_VERTEXBUFFEROPTIMIZED: Result := 'D3DERR_VERTEXBUFFEROPTIMIZED';
    D3DERR_VBUF_CREATE_FAILED: Result := 'D3DERR_VBUF_CREATE_FAILED';
    D3DERR_VERTEXBUFFERLOCKED: Result := 'D3DERR_VERTEXBUFFERLOCKED';

    D3DERR_ZBUFFER_NOTPRESENT: Result := 'D3DERR_ZBUFFER_NOTPRESENT';
    D3DERR_STENCILBUFFER_NOTPRESENT: Result := 'D3DERR_STENCILBUFFER_NOTPRESENT';

    D3DERR_WRONGTEXTUREFORMAT: Result := 'D3DERR_WRONGTEXTUREFORMAT';
    D3DERR_UNSUPPORTEDCOLOROPERATION: Result := 'D3DERR_UNSUPPORTEDCOLOROPERATION';
    D3DERR_UNSUPPORTEDCOLORARG: Result := 'D3DERR_UNSUPPORTEDCOLORARG';
    D3DERR_UNSUPPORTEDALPHAOPERATION: Result := 'D3DERR_UNSUPPORTEDALPHAOPERATION';
    D3DERR_UNSUPPORTEDALPHAARG: Result := 'D3DERR_UNSUPPORTEDALPHAARG';
    D3DERR_TOOMANYOPERATIONS: Result := 'D3DERR_TOOMANYOPERATIONS';
    D3DERR_CONFLICTINGTEXTUREFILTER: Result := 'D3DERR_CONFLICTINGTEXTUREFILTER';
    D3DERR_UNSUPPORTEDFACTORVALUE: Result := 'D3DERR_UNSUPPORTEDFACTORVALUE';

    D3DERR_CONFLICTINGRENDERSTATE: Result := 'D3DERR_CONFLICTINGRENDERSTATE';
    D3DERR_UNSUPPORTEDTEXTUREFILTER: Result := 'D3DERR_UNSUPPORTEDTEXTUREFILTER';
    D3DERR_TOOMANYPRIMITIVES: Result := 'D3DERR_TOOMANYPRIMITIVES';
    D3DERR_INVALIDMATRIX: Result := 'D3DERR_INVALIDMATRIX';
    D3DERR_TOOMANYVERTICES: Result := 'D3DERR_TOOMANYVERTICES';
    D3DERR_CONFLICTINGTEXTUREPALETTE: Result := 'D3DERR_CONFLICTINGTEXTUREPALETTE';
   // DIRECT3D_VERSION_6

    D3DERR_INVALIDSTATEBLOCK: Result := 'D3DERR_INVALIDSTATEBLOCK';
    D3DERR_INBEGINSTATEBLOCK: Result := 'D3DERR_INBEGINSTATEBLOCK';
    D3DERR_NOTINBEGINSTATEBLOCK: Result := 'D3DERR_NOTINBEGINSTATEBLOCK';
   // DIRECT3D_VERSION_7

    else Result := 'Unrecognized Error';
  end;
end;
 // DIRECT3D_VERSION_LESS_8

end.
