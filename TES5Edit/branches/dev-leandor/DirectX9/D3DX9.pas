{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  File:       d3dx9.h, d3dx9anim.h, d3dx9core.h, d3dx9effect.h,             *}
{*              d3dx9math.h, d3dx9math.inl, d3dx9mesh.h, d3dx9shader.h,       *}
{*              d3dx9shape.h, d3dx9tex.h, d3dx9xof.h                          *}
{*                                                                            *}
{*  Content:    Direct3DX 9.0 headers                                         *}
{*                                                                            *}
{*  Direct3DX 9.0 April 2007 Delphi adaptation by Alexey Barkovoy          *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://www.clootie.ru                                                   *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
{*----------------------------------------------------------------------------*}
{*  $Id: D3DX9.par,v 1.36 2007/04/14 21:35:00 clootie Exp $ }
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

// Original source contained in "D3DX9.par"

{$MINENUMSIZE 4}
{$ALIGN ON}

unit D3DX9;

interface

// Remove "dot" below to link with debug version of D3DX9
// (for Delphi it works only in JEDI version of headers)
{.$DEFINE DEBUG}

// Remove "dot" below to link with separate DLL's (one DLL per part of D3DX9 API)
// instead of monolithic "all-in-one" version of D3DX9 (not supported currently)
{.$DEFINE D3DX_SEPARATE}

(*$HPPEMIT '#include "d3dx9.h"' *)

(*$HPPEMIT 'namespace D3dx9' *)

(*$HPPEMIT '{' *)

//Clootie: has to temporary disable INLINE support for FreePascal
//         due to bug in compiler

uses
  Windows, ActiveX,
  SysUtils, Direct3D9, DXTypes;

const
  //////////// DLL export definitions ///////////////////////////////////////
  d3dx9MicrosoftDLL = 'd3dx9_33.dll';
  d3dx9MicrosoftDebugDLL = 'd3dx9d_33.dll';
  d3dx9BorlandDLL = d3dx9MicrosoftDLL; // Compatibility with previous header releases
  d3dx9dll = d3dx9MicrosoftDLL;
  d3dx9mathDLL   = d3dx9dll;
  d3dx9coreDLL   = d3dx9dll;
  d3dx9shaderDLL = d3dx9dll;
  d3dx9effectDLL = d3dx9dll;
  d3dx9meshDLL   = d3dx9dll;
  d3dx9shapesDLL = d3dx9dll;
  d3dx9texDLL    = d3dx9dll;
  d3dx9animDLL   = d3dx9dll;


//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9.h
//  Content:    D3DX utility library
//
//////////////////////////////////////////////////////////////////////////////

const
  // #define D3DX_DEFAULT ULONG_MAX
  // #define D3DX_DEFAULT            ((UINT) -1)
  D3DX_DEFAULT          = Cardinal(-1);
  {$EXTERNALSYM D3DX_DEFAULT}
  // #define D3DX_DEFAULT_NONPOW2    ((UINT) -2)
  D3DX_DEFAULT_NONPOW2  = Cardinal(-2);
  {$EXTERNALSYM D3DX_DEFAULT_NONPOW2}

var
  // #define D3DX_DEFAULT_FLOAT FLT_MAX
  // Forced to define as 'var' cos pascal compiler treats all consts as Double
  D3DX_DEFAULT_FLOAT: Single = 3.402823466e+38;  // max single value
  {$EXTERNALSYM D3DX_DEFAULT_FLOAT}

const
  D3DX_FROM_FILE          = LongWord(-3);
  {$EXTERNALSYM D3DX_FROM_FILE}
  D3DFMT_FROM_FILE        = TD3DFormat(-3);
  {$EXTERNALSYM D3DFMT_FROM_FILE}

type
  _D3DXERR = HResult;
  {$EXTERNALSYM _D3DXERR}

const
  D3DXERR_CANNOTMODIFYINDEXBUFFER       = HResult(MAKE_D3DHRESULT_R or 2900);
  {$EXTERNALSYM D3DXERR_CANNOTMODIFYINDEXBUFFER}
  D3DXERR_INVALIDMESH                   = HResult(MAKE_D3DHRESULT_R or 2901);
  {$EXTERNALSYM D3DXERR_INVALIDMESH}
  D3DXERR_CANNOTATTRSORT                = HResult(MAKE_D3DHRESULT_R or 2902);
  {$EXTERNALSYM D3DXERR_CANNOTATTRSORT}
  D3DXERR_SKINNINGNOTSUPPORTED          = HResult(MAKE_D3DHRESULT_R or 2903);
  {$EXTERNALSYM D3DXERR_SKINNINGNOTSUPPORTED}
  D3DXERR_TOOMANYINFLUENCES             = HResult(MAKE_D3DHRESULT_R or 2904);
  {$EXTERNALSYM D3DXERR_TOOMANYINFLUENCES}
  D3DXERR_INVALIDDATA                   = HResult(MAKE_D3DHRESULT_R or 2905);
  {$EXTERNALSYM D3DXERR_INVALIDDATA}
  D3DXERR_LOADEDMESHASNODATA            = HResult(MAKE_D3DHRESULT_R or 2906);
  {$EXTERNALSYM D3DXERR_LOADEDMESHASNODATA}
  D3DXERR_DUPLICATENAMEDFRAGMENT        = HResult(MAKE_D3DHRESULT_R or 2907);
  {$EXTERNALSYM D3DXERR_DUPLICATENAMEDFRAGMENT}
  D3DXERR_CANNOTREMOVELASTITEM          = HResult(MAKE_D3DHRESULT_R or 2908);
  {$EXTERNALSYM D3DXERR_CANNOTREMOVELASTITEM}




//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9math.h
//  Content:    D3DX math types and functions
//
//////////////////////////////////////////////////////////////////////////////

//===========================================================================
//
// General purpose utilities
//
//===========================================================================
const
  D3DX_PI: Single       = 3.141592654;
  {$EXTERNALSYM D3DX_PI}
  D3DX_1BYPI: Single    = 0.318309886;
  {$EXTERNALSYM D3DX_1BYPI}

//#define D3DXToRadian( degree ) ((degree) * (D3DX_PI / 180.0f))
function D3DXToRadian(Degree: Single): Single; inline;
{$EXTERNALSYM D3DXToRadian}
//#define D3DXToDegree( radian ) ((radian) * (180.0f / D3DX_PI))
function D3DXToDegree(Radian: Single): Single; inline;
{$EXTERNALSYM D3DXToDegree}



//===========================================================================
//
// 16 bit floating point numbers
//
//===========================================================================

const
  D3DX_16F_DIG          = 3;               // # of decimal digits of precision
  {$EXTERNALSYM D3DX_16F_DIG}
  D3DX_16F_EPSILON      = 4.8875809e-4;    // smallest such that 1.0 + epsilon <> 1.0
  {$EXTERNALSYM D3DX_16F_EPSILON}
  D3DX_16F_MANT_DIG     = 11;              // # of bits in mantissa
  {$EXTERNALSYM D3DX_16F_MANT_DIG}
  D3DX_16F_MAX          = 6.550400e+004;   // max value
  {$EXTERNALSYM D3DX_16F_MAX}
  D3DX_16F_MAX_10_EXP   = 4;               // max decimal exponent
  {$EXTERNALSYM D3DX_16F_MAX_10_EXP}
  D3DX_16F_MAX_EXP      = 15;              // max binary exponent
  {$EXTERNALSYM D3DX_16F_MAX_EXP}
  D3DX_16F_MIN          = 6.1035156e-5;    // min positive value
  {$EXTERNALSYM D3DX_16F_MIN}
  D3DX_16F_MIN_10_EXP   = -4;              // min decimal exponent
  {$EXTERNALSYM D3DX_16F_MIN_10_EXP}
  D3DX_16F_MIN_EXP      = -14;             // min binary exponent
  {$EXTERNALSYM D3DX_16F_MIN_EXP}
  D3DX_16F_RADIX        = 2;               // exponent radix
  {$EXTERNALSYM D3DX_16F_RADIX}
  D3DX_16F_ROUNDS       = 1;               // addition rounding: near
  {$EXTERNALSYM D3DX_16F_ROUNDS}


type
  (*$HPPEMIT 'typedef D3DXFLOAT16       TD3DXFloat16;' *)
  (*$HPPEMIT 'typedef D3DXFLOAT16      *PD3DXFloat16;' *)
  PD3DXFloat16 = ^TD3DXFloat16;
  {$EXTERNALSYM PD3DXFloat16}
  TD3DXFloat16 = packed record
    value: Word;
  end;
  {$NODEFINE TD3DXFloat16}

// Some pascal equalents of C++ class functions & operators
const D3DXFloat16Zero: TD3DXFloat16 = (value:0); // 0
function D3DXFloat16(value: Single): TD3DXFloat16; inline;
function D3DXFloat16Equal(const v1, v2: TD3DXFloat16): Boolean; inline;
function D3DXFloat16ToFloat(value: TD3DXFloat16): Single; inline;



//===========================================================================
//
// Vectors
//
//===========================================================================


//--------------------------
// 2D Vector
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR2       TD3DXVector2;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR2      *PD3DXVector2;' *)
  PD3DXVector2 = ^TD3DXVector2;
  {$EXTERNALSYM PD3DXVector2}
  TD3DXVector2 = record
    x, y: Single;
  end;
  {$NODEFINE TD3DXVector2}

// Some pascal equalents of C++ class functions & operators
const D3DXVector2Zero: TD3DXVector2 = (x:0; y:0);  // (0,0)
function D3DXVector2(_x, _y: Single): TD3DXVector2; inline;
function D3DXVector2Equal(const v1, v2: TD3DXVector2): Boolean; inline;



//--------------------------
// 2D Vector (16 bit)
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR2_16F       TD3DXVector2_16F;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR2_16F      *PD3DXVector2_16F;' *)
  PD3DXVector2_16F = ^TD3DXVector2_16F;
  {$EXTERNALSYM PD3DXVector2_16F}
  TD3DXVector2_16F = packed record
    x, y: TD3DXFloat16;
  end;
  {$NODEFINE TD3DXVector2_16F}

// Some pascal equalents of C++ class functions & operators
const D3DXVector2_16fZero: TD3DXVector2_16F = (x:(value:0); y:(value:0));  // (0,0)
function D3DXVector2_16F(_x, _y: TD3DXFloat16): TD3DXVector2_16F; inline;
function D3DXVector2_16fEqual(const v1, v2: TD3DXVector2_16F): Boolean; inline;
function D3DXVector2_16fFromVector2(const v: TD3DXVector2): TD3DXVector2_16f; inline;
function D3DXVector2FromVector2_16f(const v: TD3DXVector2_16f): TD3DXVector2; inline;



//--------------------------
// 3D Vector
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR3       TD3DXVector3;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR3      *PD3DXVector3;' *)
  PD3DXVector3 = ^TD3DXVector3;
  {$EXTERNALSYM PD3DXVector3}
  TD3DXVector3 = TD3DVector;
  {$NODEFINE TD3DXVector3}

// Some pascal equalents of C++ class functions & operators
const D3DXVector3Zero: TD3DXVector3 = (x:0; y:0; z:0);  // (0,0,0)
function D3DXVector3(_x, _y, _z: Single): TD3DXVector3; inline;
function D3DXVector3Equal(const v1, v2: TD3DXVector3): Boolean; inline;



//--------------------------
// 3D Vector (16 bit)
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR3_16F       TD3DXVector3_16F;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR3_16F      *PD3DXVector3_16F;' *)
  PD3DXVector3_16F = ^TD3DXVector3_16F;
  {$EXTERNALSYM PD3DXVector3}
  TD3DXVector3_16F = packed record
    x, y, z: TD3DXFloat16;
  end;
  {$NODEFINE TD3DXVector3_16F}

// Some pascal equalents of C++ class functions & operators
const D3DXVector3_16fZero: TD3DXVector3_16F = (x:(value:0); y:(value:0); z:(value:0));  // (0,0,0)
function D3DXVector3_16F(_x, _y, _z: TD3DXFloat16): TD3DXVector3_16F; inline;
function D3DXVector3_16fEqual(const v1, v2: TD3DXVector3_16F): Boolean; inline;
function D3DXVector3_16fFromVector3(const v: TD3DXVector3): TD3DXVector3_16f; inline;
function D3DXVector3FromVector3_16f(const v: TD3DXVector3_16f): TD3DXVector3; inline;



//--------------------------
// 4D Vector
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR4       TD3DXVector4;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR4      *PD3DXVector4;' *)
  PD3DXVector4 = ^TD3DXVector4;
  {$EXTERNALSYM PD3DXVector4}
  TD3DXVector4 = record
    x, y, z, w: Single;
  end;
  {$NODEFINE TD3DXVector4}

// Some pascal equalents of C++ class functions & operators
const D3DXVector4Zero: TD3DXVector4 = (x:0; y:0; z:0; w:0);  // (0,0,0,0)
function D3DXVector4(_x, _y, _z, _w: Single): TD3DXVector4; overload; inline;
function D3DXVector4(xyz: TD3DXVector3; _w: Single): TD3DXVector4; overload; inline;
function D3DXVector4Equal(const v1, v2: TD3DXVector4): Boolean; inline;



//--------------------------
// 4D Vector (16 bit)
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR4_16F       TD3DXVector4_16F;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR4_16F      *PD3DXVector4_16F;' *)
  PD3DXVector4_16F = ^TD3DXVector4_16F;
  {$EXTERNALSYM PD3DXVector4_16F}
  TD3DXVector4_16F = packed record
    x, y, z, w: TD3DXFloat16;
  end;
  {$NODEFINE TD3DXVector4_16F}

// Some pascal equalents of C++ class functions & operators
const D3DXVector4_16fZero: TD3DXVector4_16F = (x:(value:0); y:(value:0); z:(value:0); w:(value:0));  // (0,0,0,0)
function D3DXVector4_16F(_x, _y, _z, _w: TD3DXFloat16): TD3DXVector4_16F; overload; inline;
function D3DXVector4_16F(xyz: TD3DXVector3_16f; _w: TD3DXFloat16): TD3DXVector4_16F; overload; inline;
function D3DXVector4_16fEqual(const v1, v2: TD3DXVector4_16F): Boolean; inline;
function D3DXVector4_16fFromVector4(const v: TD3DXVector4): TD3DXVector4_16f; inline;
function D3DXVector4FromVector4_16f(const v: TD3DXVector4_16f): TD3DXVector4; inline;



//===========================================================================
//
// Matrices
//
//===========================================================================
type
  (*$HPPEMIT 'typedef D3DXMATRIX        TD3DXMatrix;' *)
  (*$HPPEMIT 'typedef D3DXMATRIX       *PD3DXMatrix;' *)
  (*$HPPEMIT 'typedef D3DXMATRIX      **PPD3DXMatrix;' *)
  PPD3DXMatrix = ^PD3DXMatrix;
  PD3DXMatrix = ^TD3DXMatrix;
  {$EXTERNALSYM PD3DXMatrix}
  TD3DXMatrix = TD3DMatrix;
  {$NODEFINE TD3DXMatrix}

// Some pascal equalents of C++ class functions & operators
function D3DXMatrix(
  _m00, _m01, _m02, _m03,
  _m10, _m11, _m12, _m13,
  _m20, _m21, _m22, _m23,
  _m30, _m31, _m32, _m33: Single): TD3DXMatrix; inline;
function D3DXMatrixAdd(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix; inline;
function D3DXMatrixSubtract(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix; inline;
function D3DXMatrixMul(out mOut: TD3DXMatrix; const m: TD3DXMatrix; MulBy: Single): PD3DXMatrix; inline;
function D3DXMatrixEqual(const m1, m2: TD3DXMatrix): Boolean; inline;


//---------------------------------------------------------------------------
// Aligned Matrices
//
// This class helps keep matrices 16-byte aligned as preferred by P4 cpus.
// It aligns matrices on the stack and on the heap or in global scope.
// It does this using __declspec(align(16)) which works on VC7 and on VC 6
// with the processor pack. Unfortunately there is no way to detect the
// latter so this is turned on only on VC7. On other compilers this is the
// the same as D3DXMATRIX.
//
// Using this class on a compiler that does not actually do the alignment
// can be dangerous since it will not expose bugs that ignore alignment.
// E.g if an object of this class in inside a struct or class, and some code
// memcopys data in it assuming tight packing. This could break on a compiler
// that eventually start aligning the matrix.
//---------------------------------------------------------------------------

// Translator comments: None of current pascal compilers can even align data
// inside records to 16 byte boundary, so we just leave aligned matrix
// declaration equal to standart matrix
type
  PD3DXMatrixA16 = ^TD3DXMatrixA16;
  TD3DXMatrixA16 = TD3DXMatrix;


//===========================================================================
//
//    Quaternions
//
//===========================================================================
type
  (*$HPPEMIT 'typedef D3DXQUATERNION TD3DXQuaternion;' *)
  PD3DXQuaternion = ^TD3DXQuaternion;
  TD3DXQuaternion = record
    x, y, z, w: Single;
  end;
  {$NODEFINE TD3DXQuaternion}

// Some pascal equalents of C++ class functions & operators
function D3DXQuaternion(_x, _y, _z, _w: Single): TD3DXQuaternion; inline;
function D3DXQuaternionAdd(const q1, q2: TD3DXQuaternion): TD3DXQuaternion; inline;
function D3DXQuaternionSubtract(const q1, q2: TD3DXQuaternion): TD3DXQuaternion; inline;
function D3DXQuaternionEqual(const q1, q2: TD3DXQuaternion): Boolean; inline;
function D3DXQuaternionScale(out qOut: TD3DXQuaternion; const q: TD3DXQuaternion;
  s: Single): PD3DXQuaternion; inline;



//===========================================================================
//
// Planes
//
//===========================================================================
type
  (*$HPPEMIT 'typedef D3DXPLANE TD3DXPlane;' *)
  PD3DXPlane = ^TD3DXPlane;
  TD3DXPlane = record
    a, b, c, d: Single;
  end;
  {$NODEFINE TD3DXPlane}

// Some pascal equalents of C++ class functions & operators
const D3DXPlaneZero: TD3DXPlane = (a:0; b:0; c:0; d:0);  // (0,0,0,0)
function D3DXPlane(_a, _b, _c, _d: Single): TD3DXPlane; inline;
function D3DXPlaneEqual(const p1, p2: TD3DXPlane): Boolean; inline;


//===========================================================================
//
// Colors
//
//===========================================================================
type
  (*$HPPEMIT 'typedef D3DXCOLOR TD3DXColor;' *)
  (*$HPPEMIT 'typedef D3DXCOLOR *PD3DXColor;' *)
  PD3DXColor = PD3DColorValue;
  {$EXTERNALSYM PD3DXColor}
  TD3DXColor = TD3DColorValue;
  {$EXTERNALSYM TD3DXColor}

function D3DXColor(_r, _g, _b, _a: Single): TD3DXColor; inline;
function D3DXColorToDWord(c: TD3DXColor): DWord; inline;
function D3DXColorFromDWord(c: DWord): TD3DXColor; inline;
function D3DXColorEqual(const c1, c2: TD3DXColor): Boolean; inline;


//===========================================================================
//
// D3DX math functions:
//
// NOTE:
//  * All these functions can take the same object as in and out parameters.
//
//  * Out parameters are typically also returned as return values, so that
//    the output of one function may be used as a parameter to another.
//
//===========================================================================

//--------------------------
// Float16
//--------------------------

// non-inline

// Converts an array 32-bit floats to 16-bit floats
function D3DXFloat32To16Array(pOut: PD3DXFloat16; pIn: PSingle; n: LongWord): PD3DXFloat16; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXFloat32To16Array}

// Converts an array 16-bit floats to 32-bit floats
function D3DXFloat16To32Array(pOut: PSingle; pIn: PD3DXFloat16; n: LongWord): PSingle; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXFloat16To32Array}


//--------------------------
// 2D Vector
//--------------------------

// inline

function D3DXVec2Length(const v: TD3DXVector2): Single; inline;
{$EXTERNALSYM D3DXVec2Length}

function D3DXVec2LengthSq(const v: TD3DXVector2): Single; inline;
{$EXTERNALSYM D3DXVec2LengthSq}

function D3DXVec2Dot(const v1, v2: TD3DXVector2): Single; inline;
{$EXTERNALSYM D3DXVec2Dot}

// Z component of ((x1,y1,0) cross (x2,y2,0))
function D3DXVec2CCW(const v1, v2: TD3DXVector2): Single; inline;
{$EXTERNALSYM D3DXVec2CCW}

function D3DXVec2Add(const v1, v2: TD3DXVector2): TD3DXVector2; inline;
{$EXTERNALSYM D3DXVec2Add}

function D3DXVec2Subtract(const v1, v2: TD3DXVector2): TD3DXVector2; inline;
{$EXTERNALSYM D3DXVec2Subtract}

// Minimize each component.  x = min(x1, x2), y = min(y1, y2)
function D3DXVec2Minimize(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2): PD3DXVector2; inline;
{$EXTERNALSYM D3DXVec2Minimize}

// Maximize each component.  x = max(x1, x2), y = max(y1, y2)
function D3DXVec2Maximize(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2): PD3DXVector2; inline;
{$EXTERNALSYM D3DXVec2Maximize}

function D3DXVec2Scale(out vOut: TD3DXVector2; const v: TD3DXVector2; s: Single): PD3DXVector2; inline;
{$EXTERNALSYM D3DXVec2Scale}

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec2Lerp(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2; s: Single): PD3DXVector2; inline;
{$EXTERNALSYM D3DXVec2Lerp}

// non-inline
function D3DXVec2Normalize(out vOut: TD3DXVector2; const v: TD3DXVector2): PD3DXVector2; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec2Normalize}

// Hermite interpolation between position V1, tangent T1 (when s == 0)
// and position V2, tangent T2 (when s == 1).
function D3DXVec2Hermite(out vOut: TD3DXVector2;
   const v1, t1, v2, t2: TD3DXVector2; s: Single): PD3DXVector2; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec2Hermite}

// CatmullRom interpolation between V1 (when s == 0) and V2 (when s == 1)
function D3DXVec2CatmullRom(out vOut: TD3DXVector2;
   const v0, v1, v2, v3: TD3DXVector2; s: Single): PD3DXVector2; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec2CatmullRom}

// Barycentric coordinates.  V1 + f(V2-V1) + g(V3-V1)
function D3DXVec2BaryCentric(out vOut: TD3DXVector2;
   const v1, v2, v3: TD3DXVector2; f, g: Single): PD3DXVector2; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec2BaryCentric}

// Transform (x, y, 0, 1) by matrix.
function D3DXVec2Transform(out vOut: TD3DXVector4;
  const v: TD3DXVector2; const m: TD3DXMatrix): PD3DXVector4; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec2Transform}

// Transform (x, y, 0, 1) by matrix, project result back into w=1.
function D3DXVec2TransformCoord(out vOut: TD3DXVector2;
  const v: TD3DXVector2; const m: TD3DXMatrix): PD3DXVector2; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec2TransformCoord}

// Transform (x, y, 0, 0) by matrix.
function D3DXVec2TransformNormal(out vOut: TD3DXVector2;
  const v: TD3DXVector2; const m: TD3DXMatrix): PD3DXVector2; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec2TransformNormal}


// Transform Array (x, y, 0, 1) by matrix.
function D3DXVec2TransformArray(pOut: PD3DXVector4; OutStride: LongWord;
  pV: PD3DXVector2; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector4; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec2TransformArray}

// Transform Array (x, y, 0, 1) by matrix, project result back into w=1.
function D3DXVec2TransformCoordArray(pOut: PD3DXVector2; OutStride: LongWord;
  pV: PD3DXVector2; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector2; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec2TransformCoordArray}

// Transform Array (x, y, 0, 0) by matrix.
function D3DXVec2TransformNormalArray(pOut: PD3DXVector2; OutStride: LongWord;
  pV: PD3DXVector2; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector2; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec2TransformNormalArray}


//--------------------------
// 3D Vector
//--------------------------

// inline

function D3DXVec3Length(const v: TD3DXVector3): Single; inline;
{$EXTERNALSYM D3DXVec3Length}

function D3DXVec3LengthSq(const v: TD3DXVector3): Single; inline;
{$EXTERNALSYM D3DXVec3LengthSq}

function D3DXVec3Dot(const v1, v2: TD3DXVector3): Single; inline;
{$EXTERNALSYM D3DXVec3Dot}

function D3DXVec3Cross(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3; inline;
{$EXTERNALSYM D3DXVec3Cross}

function D3DXVec3Add(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3; inline;
{$EXTERNALSYM D3DXVec3Add}

function D3DXVec3Subtract(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3; inline;
{$EXTERNALSYM D3DXVec3Subtract}

// Minimize each component.  x = min(x1, x2), y = min(y1, y2), ...
function D3DXVec3Minimize(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3; inline;
{$EXTERNALSYM D3DXVec3Minimize}

// Maximize each component.  x = max(x1, x2), y = max(y1, y2), ...
function D3DXVec3Maximize(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3; inline;
{$EXTERNALSYM D3DXVec3Maximize}

function D3DXVec3Scale(out vOut: TD3DXVector3; const v: TD3DXVector3; s: Single): PD3DXVector3; inline;
{$EXTERNALSYM D3DXVec3Scale}

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec3Lerp(out vOut: TD3DXVector3;
  const v1, v2: TD3DXVector3; s: Single): PD3DXVector3; inline;
{$EXTERNALSYM D3DXVec3Lerp}

// non-inline

function D3DXVec3Normalize(out vOut: TD3DXVector3;
   const v: TD3DXVector3): PD3DXVector3; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3Normalize}

// Hermite interpolation between position V1, tangent T1 (when s == 0)
// and position V2, tangent T2 (when s == 1).
function D3DXVec3Hermite(out vOut: TD3DXVector3;
   const v1, t1, v2, t2: TD3DXVector3; s: Single): PD3DXVector3; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3Hermite}

// CatmullRom interpolation between V1 (when s == 0) and V2 (when s == 1)
function D3DXVec3CatmullRom(out vOut: TD3DXVector3;
   const v0, v1, v2, v3: TD3DXVector3; s: Single): PD3DXVector3; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3CatmullRom}

// Barycentric coordinates.  V1 + f(V2-V1) + g(V3-V1)
function D3DXVec3BaryCentric(out vOut: TD3DXVector3;
   const v1, v2, v3: TD3DXVector3; f, g: Single): PD3DXVector3; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3BaryCentric}

// Transform (x, y, z, 1) by matrix.
function D3DXVec3Transform(out vOut: TD3DXVector4;
  const v: TD3DXVector3; const m: TD3DXMatrix): PD3DXVector4; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3Transform}

// Transform (x, y, z, 1) by matrix, project result back into w=1.
function D3DXVec3TransformCoord(out vOut: TD3DXVector3;
  const v: TD3DXVector3; const m: TD3DXMatrix): PD3DXVector3; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3TransformCoord}

// Transform (x, y, z, 0) by matrix.  If you transforming a normal by a
// non-affine matrix, the matrix you pass to this function should be the
// transpose of the inverse of the matrix you would use to transform a coord.
function D3DXVec3TransformNormal(out vOut: TD3DXVector3;
  const v: TD3DXVector3; const m: TD3DXMatrix): PD3DXVector3; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3TransformNormal}


// Transform Array (x, y, z, 1) by matrix.
function D3DXVec3TransformArray(pOut: PD3DXVector4; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector4; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3TransformArray}

// Transform Array (x, y, z, 1) by matrix, project result back into w=1.
function D3DXVec3TransformCoordArray(pOut: PD3DXVector3; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector3; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3TransformCoordArray}

// Transform (x, y, z, 0) by matrix.  If you transforming a normal by a
// non-affine matrix, the matrix you pass to this function should be the
// transpose of the inverse of the matrix you would use to transform a coord.
function D3DXVec3TransformNormalArray(pOut: PD3DXVector3; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector3; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3TransformNormalArray}

// Project vector from object space into screen space
function D3DXVec3Project(out vOut: TD3DXVector3;
  const v: TD3DXVector3; const pViewport: TD3DViewport9;
  const pProjection, pView, pWorld: TD3DXMatrix): PD3DXVector3; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3Project}

// Project vector from screen space into object space
function D3DXVec3Unproject(out vOut: TD3DXVector3;
  const v: TD3DXVector3; const pViewport: TD3DViewport9;
  const pProjection, pView, pWorld: TD3DXMatrix): PD3DXVector3; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3Unproject}

// Project vector Array from object space into screen space
function D3DXVec3ProjectArray(pOut: PD3DXVector3; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const pViewport: TD3DViewport9;
  const pProjection, pView, pWorld: TD3DXMatrix; n: LongWord): PD3DXVector3; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3ProjectArray}

// Project vector Array from screen space into object space
function D3DXVec3UnprojectArray(pOut: PD3DXVector3; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const pViewport: TD3DViewport9;
  const pProjection, pView, pWorld: TD3DXMatrix; n: LongWord): PD3DXVector3; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec3UnprojectArray}


//--------------------------
// 4D Vector
//--------------------------

// inline

function D3DXVec4Length(const v: TD3DXVector4): Single; inline;
{$EXTERNALSYM D3DXVec4Length}

function D3DXVec4LengthSq(const v: TD3DXVector4): Single; inline;
{$EXTERNALSYM D3DXVec4LengthSq}

function D3DXVec4Dot(const v1, v2: TD3DXVector4): Single; inline;
{$EXTERNALSYM D3DXVec4Dot}

function D3DXVec4Add(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4; inline;
{$EXTERNALSYM D3DXVec4Add}

function D3DXVec4Subtract(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4; inline;
{$EXTERNALSYM D3DXVec4Subtract}

// Minimize each component.  x = min(x1, x2), y = min(y1, y2), ...
function D3DXVec4Minimize(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4; inline;
{$EXTERNALSYM D3DXVec4Minimize}

// Maximize each component.  x = max(x1, x2), y = max(y1, y2), ...
function D3DXVec4Maximize(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4; inline;
{$EXTERNALSYM D3DXVec4Maximize}

function D3DXVec4Scale(out vOut: TD3DXVector4; const v: TD3DXVector4; s: Single): PD3DXVector4; inline;
{$EXTERNALSYM D3DXVec4Scale}

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec4Lerp(out vOut: TD3DXVector4;
  const v1, v2: TD3DXVector4; s: Single): PD3DXVector4; inline;
{$EXTERNALSYM D3DXVec4Lerp}

// non-inline

// Cross-product in 4 dimensions.
function D3DXVec4Cross(out vOut: TD3DXVector4;
  const v1, v2, v3: TD3DXVector4): PD3DXVector4; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec4Cross}

function D3DXVec4Normalize(out vOut: TD3DXVector4;
  const v: TD3DXVector4): PD3DXVector4; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec4Normalize}

// Hermite interpolation between position V1, tangent T1 (when s == 0)
// and position V2, tangent T2 (when s == 1).
function D3DXVec4Hermite(out vOut: TD3DXVector4;
   const v1, t1, v2, t2: TD3DXVector4; s: Single): PD3DXVector4; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec4Hermite}

// CatmullRom interpolation between V1 (when s == 0) and V2 (when s == 1)
function D3DXVec4CatmullRom(out vOut: TD3DXVector4;
   const v0, v1, v2, v3: TD3DXVector4; s: Single): PD3DXVector4; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec4CatmullRom}

// Barycentric coordinates.  V1 + f(V2-V1) + g(V3-V1)
function D3DXVec4BaryCentric(out vOut: TD3DXVector4;
   const v1, v2, v3: TD3DXVector4; f, g: Single): PD3DXVector4; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec4BaryCentric}

// Transform vector by matrix.
function D3DXVec4Transform(out vOut: TD3DXVector4;
  const v: TD3DXVector4; const m: TD3DXMatrix): PD3DXVector4; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec4Transform}

// Transform vector array by matrix.
function D3DXVec4TransformArray(pOut: PD3DXVector4; OutStride: LongWord;
  pV: PD3DXVector4; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector4; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXVec4TransformArray}


//--------------------------
// 4D Matrix
//--------------------------

// inline

function D3DXMatrixIdentity(out mOut: TD3DXMatrix): PD3DXMatrix; inline;
{$EXTERNALSYM D3DXMatrixIdentity}

function D3DXMatrixIsIdentity(const m: TD3DXMatrix): BOOL; inline;
{$EXTERNALSYM D3DXMatrixIsIdentity}

// non-inline

function D3DXMatrixDeterminant(const m: TD3DXMatrix): Single; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixDeterminant}

function D3DXMatrixDecompose(pOutScale: PD3DXVector3; pOutRotation: PD3DXQuaternion;
   pOutTranslation: PD3DXVector3; const M: TD3DXMatrix): HRESULT; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixDecompose}

function D3DXMatrixTranspose(out pOut: TD3DXMatrix; const pM: TD3DXMatrix): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixTranspose}

// Matrix multiplication.  The result represents the transformation M2
// followed by the transformation M1.  (Out = M1 * M2)
function D3DXMatrixMultiply(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixMultiply}

// Matrix multiplication, followed by a transpose. (Out = T(M1 * M2))
function D3DXMatrixMultiplyTranspose(out pOut: TD3DXMatrix; const pM1, pM2: TD3DXMatrix): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixMultiplyTranspose}

// Calculate inverse of matrix.  Inversion my fail, in which case NULL will
// be returned.  The determinant of pM is also returned it pfDeterminant
// is non-NULL.
function D3DXMatrixInverse(out mOut: TD3DXMatrix; pfDeterminant: PSingle;
    const m: TD3DXMatrix): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixInverse}

// Build a matrix which scales by (sx, sy, sz)
function D3DXMatrixScaling(out mOut: TD3DXMatrix; sx, sy, sz: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixScaling}

// Build a matrix which translates by (x, y, z)
function D3DXMatrixTranslation(out mOut: TD3DXMatrix; x, y, z: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixTranslation}

// Build a matrix which rotates around the X axis
function D3DXMatrixRotationX(out mOut: TD3DXMatrix; angle: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixRotationX}

// Build a matrix which rotates around the Y axis
function D3DXMatrixRotationY(out mOut: TD3DXMatrix; angle: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixRotationY}

// Build a matrix which rotates around the Z axis
function D3DXMatrixRotationZ(out mOut: TD3DXMatrix; angle: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixRotationZ}

// Build a matrix which rotates around an arbitrary axis
function D3DXMatrixRotationAxis(out mOut: TD3DXMatrix; const v: TD3DXVector3;
  angle: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixRotationAxis}

// Build a matrix from a quaternion
function D3DXMatrixRotationQuaternion(out mOut: TD3DXMatrix; const Q: TD3DXQuaternion): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixRotationQuaternion}

// Yaw around the Y axis, a pitch around the X axis,
// and a roll around the Z axis.
function D3DXMatrixRotationYawPitchRoll(out mOut: TD3DXMatrix; yaw, pitch, roll: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixRotationYawPitchRoll}

// Build transformation matrix.  NULL arguments are treated as identity.
// Mout = Msc-1 * Msr-1 * Ms * Msr * Msc * Mrc-1 * Mr * Mrc * Mt
function D3DXMatrixTransformation(out mOut: TD3DXMatrix;
   pScalingCenter: PD3DXVector3;
   pScalingRotation: PD3DXQuaternion; pScaling, pRotationCenter: PD3DXVector3;
   pRotation: PD3DXQuaternion; pTranslation: PD3DXVector3): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixTransformation}

// Build 2D transformation matrix in XY plane.  NULL arguments are treated as identity.
// Mout = Msc-1 * Msr-1 * Ms * Msr * Msc * Mrc-1 * Mr * Mrc * Mt
function D3DXMatrixTransformation2D(out pOut: TD3DXMatrix;
   pScalingCenter: PD3DXVector2;
   ScalingRotation: Single; pScaling: PD3DXVector2; pRotationCenter: PD3DXVector2;
   Rotation: Single; pTranslation: PD3DXVector2): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixTransformation2D}

// Build affine transformation matrix.  NULL arguments are treated as identity.
// Mout = Ms * Mrc-1 * Mr * Mrc * Mt
function D3DXMatrixAffineTransformation(out mOut: TD3DXMatrix;
   Scaling: Single; pRotationCenter: PD3DXVector3;
   pRotation: PD3DXQuaternion; pTranslation: PD3DXVector3): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixAffineTransformation}

// Build 2D affine transformation matrix in XY plane.  NULL arguments are treated as identity.
// Mout = Ms * Mrc-1 * Mr * Mrc * Mt
function D3DXMatrixAffineTransformation2D(out mOut: TD3DXMatrix;
   Scaling: Single; pRotationCenter: PD3DXVector2;
   Rotation: Single; pTranslation: PD3DXVector2): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixAffineTransformation2D}

// Build a lookat matrix. (right-handed)
function D3DXMatrixLookAtRH(out mOut: TD3DXMatrix; const Eye, At, Up: TD3DXVector3): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixLookAtRH}

// Build a lookat matrix. (left-handed)
function D3DXMatrixLookAtLH(out mOut: TD3DXMatrix; const Eye, At, Up: TD3DXVector3): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixLookAtLH}

// Build a perspective projection matrix. (right-handed)
function D3DXMatrixPerspectiveRH(out mOut: TD3DXMatrix; w, h, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixPerspectiveRH}

// Build a perspective projection matrix. (left-handed)
function D3DXMatrixPerspectiveLH(out mOut: TD3DXMatrix; w, h, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixPerspectiveLH}

// Build a perspective projection matrix. (right-handed)
function D3DXMatrixPerspectiveFovRH(out mOut: TD3DXMatrix; flovy, aspect, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixPerspectiveFovRH}

// Build a perspective projection matrix. (left-handed)
function D3DXMatrixPerspectiveFovLH(out mOut: TD3DXMatrix; flovy, aspect, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixPerspectiveFovLH}

// Build a perspective projection matrix. (right-handed)
function D3DXMatrixPerspectiveOffCenterRH(out mOut: TD3DXMatrix;
   l, r, b, t, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixPerspectiveOffCenterRH}

// Build a perspective projection matrix. (left-handed)
function D3DXMatrixPerspectiveOffCenterLH(out mOut: TD3DXMatrix;
   l, r, b, t, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixPerspectiveOffCenterLH}

// Build an ortho projection matrix. (right-handed)
function D3DXMatrixOrthoRH(out mOut: TD3DXMatrix; w, h, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixOrthoRH}

// Build an ortho projection matrix. (left-handed)
function D3DXMatrixOrthoLH(out mOut: TD3DXMatrix; w, h, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixOrthoLH}

// Build an ortho projection matrix. (right-handed)
function D3DXMatrixOrthoOffCenterRH(out mOut: TD3DXMatrix;
  l, r, b, t, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixOrthoOffCenterRH}

// Build an ortho projection matrix. (left-handed)
function D3DXMatrixOrthoOffCenterLH(out mOut: TD3DXMatrix;
  l, r, b, t, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixOrthoOffCenterLH}

// Build a matrix which flattens geometry into a plane, as if casting
// a shadow from a light.
function D3DXMatrixShadow(out mOut: TD3DXMatrix;
  const Light: TD3DXVector4; const Plane: TD3DXPlane): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixShadow}

// Build a matrix which reflects the coordinate system about a plane
function D3DXMatrixReflect(out mOut: TD3DXMatrix;
   const Plane: TD3DXPlane): PD3DXMatrix; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXMatrixReflect}


//--------------------------
// Quaternion
//--------------------------

// inline

function D3DXQuaternionLength(const q: TD3DXQuaternion): Single; inline;
{$EXTERNALSYM D3DXQuaternionLength}

// Length squared, or "norm"
function D3DXQuaternionLengthSq(const q: TD3DXQuaternion): Single; inline;
{$EXTERNALSYM D3DXQuaternionLengthSq}

function D3DXQuaternionDot(const q1, q2: TD3DXQuaternion): Single; inline;
{$EXTERNALSYM D3DXQuaternionDot}

// (0, 0, 0, 1)
function D3DXQuaternionIdentity(out qOut: TD3DXQuaternion): PD3DXQuaternion; inline;
{$EXTERNALSYM D3DXQuaternionIdentity}

function D3DXQuaternionIsIdentity (const q: TD3DXQuaternion): BOOL; inline;
{$EXTERNALSYM D3DXQuaternionIsIdentity}

// (-x, -y, -z, w)
function D3DXQuaternionConjugate(out qOut: TD3DXQuaternion;
  const q: TD3DXQuaternion): PD3DXQuaternion; inline;
{$EXTERNALSYM D3DXQuaternionConjugate}


// non-inline

// Compute a quaternin's axis and angle of rotation. Expects unit quaternions.
procedure D3DXQuaternionToAxisAngle(const q: TD3DXQuaternion;
  out Axis: TD3DXVector3; out Angle: Single); stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXQuaternionToAxisAngle}

// Build a quaternion from a rotation matrix.
function D3DXQuaternionRotationMatrix(out qOut: TD3DXQuaternion;
  const m: TD3DXMatrix): PD3DXQuaternion; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXQuaternionRotationMatrix}

// Rotation about arbitrary axis.
function D3DXQuaternionRotationAxis(out qOut: TD3DXQuaternion;
  const v: TD3DXVector3; Angle: Single): PD3DXQuaternion; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXQuaternionRotationAxis}

// Yaw around the Y axis, a pitch around the X axis,
// and a roll around the Z axis.
function D3DXQuaternionRotationYawPitchRoll(out qOut: TD3DXQuaternion;
  yaw, pitch, roll: Single): PD3DXQuaternion; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXQuaternionRotationYawPitchRoll}

// Quaternion multiplication.  The result represents the rotation Q2
// followed by the rotation Q1.  (Out = Q2 * Q1)
function D3DXQuaternionMultiply(out qOut: TD3DXQuaternion;
   const q1, q2: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXQuaternionMultiply}

function D3DXQuaternionNormalize(out qOut: TD3DXQuaternion;
   const q: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXQuaternionNormalize}

// Conjugate and re-norm
function D3DXQuaternionInverse(out qOut: TD3DXQuaternion;
   const q: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXQuaternionInverse}

// Expects unit quaternions.
// if q = (cos(theta), sin(theta) * v); ln(q) = (0, theta * v)
function D3DXQuaternionLn(out qOut: TD3DXQuaternion;
   const q: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXQuaternionLn}

// Expects pure quaternions. (w == 0)  w is ignored in calculation.
// if q = (0, theta * v); exp(q) = (cos(theta), sin(theta) * v)
function D3DXQuaternionExp(out qOut: TD3DXQuaternion;
   const q: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXQuaternionExp}

// Spherical linear interpolation between Q1 (s == 0) and Q2 (s == 1).
// Expects unit quaternions.
function D3DXQuaternionSlerp(out qOut: TD3DXQuaternion;
   const q1, q2: TD3DXQuaternion; t: Single): PD3DXQuaternion; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXQuaternionSlerp}

// Spherical quadrangle interpolation.
// Slerp(Slerp(Q1, C, t), Slerp(A, B, t), 2t(1-t))
function D3DXQuaternionSquad(out qOut: TD3DXQuaternion;
   const pQ1, pA, pB, pC: TD3DXQuaternion; t: Single): PD3DXQuaternion; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXQuaternionSquad}

// Setup control points for spherical quadrangle interpolation
// from Q1 to Q2.  The control points are chosen in such a way
// to ensure the continuity of tangents with adjacent segments.
procedure D3DXQuaternionSquadSetup(out pAOut, pBOut, pCOut: TD3DXQuaternion;
   const pQ0, pQ1, pQ2, pQ3: TD3DXQuaternion); stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXQuaternionSquadSetup}

// Barycentric interpolation.
// Slerp(Slerp(Q1, Q2, f+g), Slerp(Q1, Q3, f+g), g/(f+g))
function D3DXQuaternionBaryCentric(out qOut: TD3DXQuaternion;
   const q1, q2, q3: TD3DXQuaternion; f, g: Single): PD3DXQuaternion; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXQuaternionBaryCentric}


//--------------------------
// Plane
//--------------------------

// inline

// ax + by + cz + dw
function D3DXPlaneDot(const p: TD3DXPlane; const v: TD3DXVector4): Single; inline;
{$EXTERNALSYM D3DXPlaneDot}

// ax + by + cz + d
function D3DXPlaneDotCoord(const p: TD3DXPlane; const v: TD3DXVector3): Single; inline;
{$EXTERNALSYM D3DXPlaneDotCoord}

// ax + by + cz
function D3DXPlaneDotNormal(const p: TD3DXPlane; const v: TD3DXVector3): Single; inline;
{$EXTERNALSYM D3DXPlaneDotNormal}

function D3DXPlaneScale(out pOut: TD3DXPlane; const pP: TD3DXPlane; s: Single): PD3DXPlane; inline;
{$EXTERNALSYM D3DXPlaneScale}


// non-inline

// Normalize plane (so that |a,b,c| == 1)
function D3DXPlaneNormalize(out pOut: TD3DXPlane; const p: TD3DXPlane): PD3DXPlane; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXPlaneNormalize}

// Find the intersection between a plane and a line.  If the line is
// parallel to the plane, NULL is returned.
function D3DXPlaneIntersectLine(out pOut: TD3DXVector3;
   const p: TD3DXPlane; const v1, v2: TD3DXVector3): PD3DXVector3; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXPlaneIntersectLine}

// Construct a plane from a point and a normal
function D3DXPlaneFromPointNormal(out pOut: TD3DXPlane;
   const vPoint, vNormal: TD3DXVector3): PD3DXPlane; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXPlaneFromPointNormal}

// Construct a plane from 3 points
function D3DXPlaneFromPoints(out pOut: TD3DXPlane;
   const v1, v2, v3: TD3DXVector3): PD3DXPlane; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXPlaneFromPoints}

// Transform a plane by a matrix.  The vector (a,b,c) must be normal.
// M should be the inverse transpose of the transformation desired.
function D3DXPlaneTransform(out pOut: TD3DXPlane; const p: TD3DXPlane; const m: TD3DXMatrix): PD3DXPlane; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXPlaneTransform}

// Transform an array of planes by a matrix.  The vectors (a,b,c) must be normal.
// M should be the inverse transpose of the transformation desired.
function D3DXPlaneTransformArray(pOut: PD3DXPlane; OutStride: LongWord;
  pP: PD3DXPlane; PStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXPlane; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXPlaneTransformArray}


//--------------------------
// Color
//--------------------------

// inline

// (1-r, 1-g, 1-b, a)
function D3DXColorNegative(out cOut: TD3DXColor; const c: TD3DXColor): PD3DXColor; inline;
{$EXTERNALSYM D3DXColorNegative}

function D3DXColorAdd(out cOut: TD3DXColor; const c1, c2: TD3DXColor): PD3DXColor; inline;
{$EXTERNALSYM D3DXColorAdd}

function D3DXColorSubtract(out cOut: TD3DXColor; const c1, c2: TD3DXColor): PD3DXColor; inline;
{$EXTERNALSYM D3DXColorSubtract}

function D3DXColorScale(out cOut: TD3DXColor; const c: TD3DXColor; s: Single): PD3DXColor; inline;
{$EXTERNALSYM D3DXColorScale}

// (r1*r2, g1*g2, b1*b2, a1*a2)
function D3DXColorModulate(out cOut: TD3DXColor; const c1, c2: TD3DXColor): PD3DXColor; inline;
{$EXTERNALSYM D3DXColorModulate}

// Linear interpolation of r,g,b, and a. C1 + s(C2-C1)
function D3DXColorLerp(out cOut: TD3DXColor; const c1, c2: TD3DXColor; s: Single): PD3DXColor; inline;
{$EXTERNALSYM D3DXColorLerp}

// non-inline

// Interpolate r,g,b between desaturated color and color.
// DesaturatedColor + s(Color - DesaturatedColor)
function D3DXColorAdjustSaturation(out cOut: TD3DXColor;
   const pC: TD3DXColor; s: Single): PD3DXColor; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXColorAdjustSaturation}

// Interpolate r,g,b between 50% grey and color.  Grey + s(Color - Grey)
function D3DXColorAdjustContrast(out cOut: TD3DXColor;
   const pC: TD3DXColor; c: Single): PD3DXColor; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXColorAdjustContrast}


//--------------------------
// Misc
//--------------------------

// Calculate Fresnel term given the cosine of theta (likely obtained by
// taking the dot of two normals), and the refraction index of the material.
function D3DXFresnelTerm(CosTheta, RefractionIndex: Single): Single; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXFresnelTerm}



//===========================================================================
//
//    Matrix Stack
//
//===========================================================================

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXMatrixStack);'}
  {$EXTERNALSYM ID3DXMatrixStack}
  ID3DXMatrixStack = interface(IUnknown)
    ['{C7885BA7-F990-4fe7-922D-8515E477DD85}']
    //
    // ID3DXMatrixStack methods
    //

    // Pops the top of the stack, returns the current top
    // *after* popping the top.
    function Pop: HResult; stdcall;

    // Pushes the stack by one, duplicating the current matrix.
    function Push: HResult; stdcall;

    // Loads identity in the current matrix.
    function LoadIdentity: HResult; stdcall;

    // Loads the given matrix into the current matrix
    function LoadMatrix(const M: TD3DXMatrix): HResult; stdcall;

    // Right-Multiplies the given matrix to the current matrix.
    // (transformation is about the current world origin)
    function MultMatrix(const M: TD3DXMatrix): HResult; stdcall;

    // Left-Multiplies the given matrix to the current matrix
    // (transformation is about the local origin of the object)
    function MultMatrixLocal(const M: TD3DXMatrix): HResult; stdcall;

    // Right multiply the current matrix with the computed rotation
    // matrix, counterclockwise about the given axis with the given angle.
    // (rotation is about the current world origin)
    function RotateAxis(const V: TD3DXVector3; Angle: Single): HResult; stdcall;

    // Left multiply the current matrix with the computed rotation
    // matrix, counterclockwise about the given axis with the given angle.
    // (rotation is about the local origin of the object)
    function RotateAxisLocal(const V: TD3DXVector3; Angle: Single): HResult; stdcall;

    // Right multiply the current matrix with the computed rotation
    // matrix. All angles are counterclockwise. (rotation is about the
    // current world origin)

    // The rotation is composed of a yaw around the Y axis, a pitch around
    // the X axis, and a roll around the Z axis.
    function RotateYawPitchRoll(yaw, pitch, roll: Single): HResult; stdcall;

    // Left multiply the current matrix with the computed rotation
    // matrix. All angles are counterclockwise. (rotation is about the
    // local origin of the object)

    // The rotation is composed of a yaw around the Y axis, a pitch around
    // the X axis, and a roll around the Z axis.
    function RotateYawPitchRollLocal(yaw, pitch, roll: Single): HResult; stdcall;

    // Right multiply the current matrix with the computed scale
    // matrix. (transformation is about the current world origin)
    function Scale(x, y, z: Single): HResult; stdcall;

    // Left multiply the current matrix with the computed scale
    // matrix. (transformation is about the local origin of the object)
    function ScaleLocal(x, y, z: Single): HResult; stdcall;

    // Right multiply the current matrix with the computed translation
    // matrix. (transformation is about the current world origin)
    function Translate(x, y, z: Single): HResult; stdcall;

    // Left multiply the current matrix with the computed translation
    // matrix. (transformation is about the local origin of the object)
    function TranslateLocal(x, y, z: Single): HResult; stdcall;

    // Obtain the current matrix at the top of the stack
    function GetTop: PD3DXMatrix; stdcall;
  end;

type
  IID_ID3DXMatrixStack = ID3DXMatrixStack;
  {$EXTERNALSYM IID_ID3DXMatrixStack}

function D3DXCreateMatrixStack(Flags: DWord; out Stack: ID3DXMatrixStack): HResult; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXCreateMatrixStack}

//===========================================================================
//
//  Spherical Harmonic Runtime Routines
//
// NOTE:
//  * Most of these functions can take the same object as in and out parameters.
//    The exceptions are the rotation functions.
//
//  * Out parameters are typically also returned as return values, so that
//    the output of one function may be used as a parameter to another.
//
//============================================================================


//============================================================================
//
//  Basic Spherical Harmonic math routines
//
//============================================================================

const
  D3DXSH_MINORDER = 2;
  {$EXTERNALSYM D3DXSH_MINORDER}
  D3DXSH_MAXORDER = 6;
  {$EXTERNALSYM D3DXSH_MAXORDER}

//============================================================================
//
//  D3DXSHEvalDirection:
//  --------------------
//  Evaluates the Spherical Harmonic basis functions
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned.
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pDir
//      Direction to evaluate in - assumed to be normalized
//
//============================================================================

function D3DXSHEvalDirection(pOut: PSingle; Order: LongWord;
    const pDir: TD3DXVector3): PSingle; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHEvalDirection}

//============================================================================
//
//  D3DXSHRotate:
//  --------------------
//  Rotates SH vector by a rotation matrix
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned (should not alias with pIn.)
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pMatrix
//      Matrix used for rotation - rotation sub matrix should be orthogonal
//      and have a unit determinant.
//   pIn
//      Input SH coeffs (rotated), incorect results if this is also output.
//
//============================================================================

function D3DXSHRotate(pOut: PSingle; Order: LongWord;
    const pMatrix: TD3DXMatrix; pIn: PSingle): PSingle; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHRotate}

//============================================================================
//
//  D3DXSHRotateZ:
//  --------------------
//  Rotates the SH vector in the Z axis by an angle
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned (should not alias with pIn.)
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   Angle
//      Angle in radians to rotate around the Z axis.
//   pIn
//      Input SH coeffs (rotated), incorect results if this is also output.
//
//============================================================================

function D3DXSHRotateZ(pOut: PSingle; Order: LongWord;
    Angle: Single; pIn: PSingle): PSingle; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHRotateZ}

//============================================================================
//
//  D3DXSHAdd:
//  --------------------
//  Adds two SH vectors, pOut[i] = pA[i] + pB[i];
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned.
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pA
//      Input SH coeffs.
//   pB
//      Input SH coeffs (second vector.)
//
//============================================================================

function D3DXSHAdd(pOut: PSingle; Order: LongWord;
    pA, pB: PSingle): PSingle; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHAdd}

//============================================================================
//
//  D3DXSHScale:
//  --------------------
//  Adds two SH vectors, pOut[i] = pA[i]*Scale;
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned.
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pIn
//      Input SH coeffs.
//   Scale
//      Scale factor.
//
//============================================================================

function D3DXSHScale(pOut: PSingle; Order: LongWord;
    pIn: PSingle; Scale: Single): PSingle; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHScale}

//============================================================================
//
//  D3DXSHDot:
//  --------------------
//  Computes the dot product of two SH vectors
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pA
//      Input SH coeffs.
//   pB
//      Second set of input SH coeffs.
//
//============================================================================

function D3DXSHDot(Order: LongWord; pA, pB: PSingle): Single; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHDot}

//============================================================================
//
//  D3DXSHMultiply[O]:
//  --------------------
//  Computes the product of two functions represented using SH (f and g), where:
//  pOut[i] = int(y_i(s) * f(s) * g(s)), where y_i(s) is the ith SH basis
//  function, f(s) and g(s) are SH functions (sum_i(y_i(s)*c_i)).  The order O
//  determines the lengths of the arrays, where there should always be O^2
//  coefficients.  In general the product of two SH functions of order O generates
//  and SH function of order 2*O - 1, but we truncate the result.  This means
//  that the product commutes (f*g == g*f) but doesn't associate
//  (f*(g*h) != (f*g)*h.
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned.
//   pF
//      Input SH coeffs for first function.
//   pG
//      Second set of input SH coeffs.
//
//============================================================================

function D3DXSHMultiply2(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHMultiply2}
function D3DXSHMultiply3(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHMultiply3}
function D3DXSHMultiply4(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHMultiply4}
function D3DXSHMultiply5(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHMultiply5}
function D3DXSHMultiply6(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHMultiply6}

//============================================================================
//
//  Basic Spherical Harmonic lighting routines
//
//============================================================================

//============================================================================
//
//  D3DXSHEvalDirectionalLight:
//  --------------------
//  Evaluates a directional light and returns spectral SH data.  The output 
//  vector is computed so that if the intensity of R/G/B is unit the resulting
//  exit radiance of a point directly under the light on a diffuse object with
//  an albedo of 1 would be 1.0.  This will compute 3 spectral samples, pROut
//  has to be specified, while pGout and pBout are optional.
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pDir
//      Direction light is coming from (assumed to be normalized.)
//   RIntensity
//      Red intensity of light.
//   GIntensity
//      Green intensity of light.
//   BIntensity
//      Blue intensity of light.
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green (optional.)
//   pBOut
//      Output SH vector for Blue (optional.)
//
//============================================================================

function D3DXSHEvalDirectionalLight(Order: LongWord; const pDir: TD3DXVector3;
    RIntensity: Single; GIntensity: Single; BIntensity: Single;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHEvalDirectionalLight}

//============================================================================
//
//  D3DXSHEvalSphericalLight:
//  --------------------
//  Evaluates a spherical light and returns spectral SH data.  There is no
//  normalization of the intensity of the light like there is for directional
//  lights, care has to be taken when specifiying the intensities.  This will
//  compute 3 spectral samples, pROut has to be specified, while pGout and
//  pBout are optional.
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pPos
//      Position of light - reciever is assumed to be at the origin.
//   Radius
//      Radius of the spherical light source.
//   RIntensity
//      Red intensity of light.
//   GIntensity
//      Green intensity of light.
//   BIntensity
//      Blue intensity of light.
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green (optional.)
//   pBOut
//      Output SH vector for Blue (optional.)
//
//============================================================================

function D3DXSHEvalSphericalLight(Order: LongWord; const pPos: TD3DXVector3; Radius: Single;
    RIntensity: Single; GIntensity: Single; BIntensity: Single;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHEvalSphericalLight}

//============================================================================
//
//  D3DXSHEvalConeLight:
//  --------------------
//  Evaluates a light that is a cone of constant intensity and returns spectral
//  SH data.  The output vector is computed so that if the intensity of R/G/B is
//  unit the resulting exit radiance of a point directly under the light oriented
//  in the cone direction on a diffuse object with an albedo of 1 would be 1.0.
//  This will compute 3 spectral samples, pROut has to be specified, while pGout
//  and pBout are optional.
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pDir
//      Direction light is coming from (assumed to be normalized.)
//   Radius
//      Radius of cone in radians.
//   RIntensity
//      Red intensity of light.
//   GIntensity
//      Green intensity of light.
//   BIntensity
//      Blue intensity of light.
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green (optional.)
//   pBOut
//      Output SH vector for Blue (optional.)
//
//============================================================================

function D3DXSHEvalConeLight(Order: LongWord; const pDir: TD3DXVector3; Radius: Single;
    RIntensity: Single; GIntensity: Single; BIntensity: Single;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHEvalConeLight}
      
//============================================================================
//
//  D3DXSHEvalHemisphereLight:
//  --------------------
//  Evaluates a light that is a linear interpolant between two colors over the
//  sphere.  The interpolant is linear along the axis of the two points, not
//  over the surface of the sphere (ie: if the axis was (0,0,1) it is linear in
//  Z, not in the azimuthal angle.)  The resulting spherical lighting function
//  is normalized so that a point on a perfectly diffuse surface with no
//  shadowing and a normal pointed in the direction pDir would result in exit
//  radiance with a value of 1 if the top color was white and the bottom color
//  was black.  This is a very simple model where Top represents the intensity 
//  of the "sky" and Bottom represents the intensity of the "ground".
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pDir
//      Axis of the hemisphere.
//   Top
//      Color of the upper hemisphere.
//   Bottom
//      Color of the lower hemisphere.
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green
//   pBOut
//      Output SH vector for Blue        
//
//============================================================================

function D3DXSHEvalHemisphereLight(Order: LongWord; const pDir: TD3DXVector3;
    Top, Bottom: TD3DXColor;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHEvalHemisphereLight}

//============================================================================
//
//  Basic Spherical Harmonic projection routines
//
//============================================================================

//============================================================================
//
//  D3DXSHProjectCubeMap:
//  --------------------
//  Projects a function represented on a cube map into spherical harmonics.
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pCubeMap
//      CubeMap that is going to be projected into spherical harmonics
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green
//   pBOut
//      Output SH vector for Blue
//
//============================================================================

function D3DXSHProjectCubeMap(Order: LongWord; pCubeMap: IDirect3DCubeTexture9;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx9mathDLL;
{$EXTERNALSYM D3DXSHProjectCubeMap}







///////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9core.h
//  Content:    D3DX core types and functions
//
///////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////
// D3DX_SDK_VERSION:
// -----------------
// This identifier is passed to D3DXCheckVersion in order to ensure that an
// application was built against the correct header files and lib files.
// This number is incremented whenever a header (or other) change would
// require applications to be rebuilt. If the version doesn't match,
// D3DXCheckVersion will return FALSE. (The number itself has no meaning.)
///////////////////////////////////////////////////////////////////////////

const
  D3DX_VERSION          = $0902;
  {$EXTERNALSYM D3DX_VERSION}
  D3DX_SDK_VERSION      = 33;
  {$EXTERNALSYM D3DX_SDK_VERSION}

function D3DXCheckVersion(D3DSdkVersion, D3DXSdkVersion: LongWord): BOOL; stdcall; external d3dx9coreDLL;
{$EXTERNALSYM D3DXCheckVersion}



///////////////////////////////////////////////////////////////////////////
// D3DXDebugMute
//    Mutes D3DX and D3D debug spew (TRUE - mute, FALSE - not mute)
//
//  returns previous mute value
//
///////////////////////////////////////////////////////////////////////////

function D3DXDebugMute(Mute: BOOL): BOOL; stdcall; external d3dx9coreDLL;
{$EXTERNALSYM D3DXDebugMute}



///////////////////////////////////////////////////////////////////////////
// D3DXGetDriverLevel:
//    Returns driver version information:
//
//    700 - DX7 level driver
//    800 - DX8 level driver
//    900 - DX9 level driver
///////////////////////////////////////////////////////////////////////////

function D3DXGetDriverLevel(pDevice: IDirect3DDevice9): LongWord; stdcall; external d3dx9coreDLL;
{$EXTERNALSYM D3DXGetDriverLevel}


///////////////////////////////////////////////////////////////////////////
// ID3DXBuffer:
// ------------
// The buffer object is used by D3DX to return arbitrary size data.
//
// GetBufferPointer -
//    Returns a pointer to the beginning of the buffer.
//
// GetBufferSize -
//    Returns the size of the buffer, in bytes.
///////////////////////////////////////////////////////////////////////////

type
  PID3DXBuffer = ^ID3DXBuffer;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXBuffer);'}
  {$EXTERNALSYM ID3DXBuffer}
  ID3DXBuffer = interface(IUnknown)
    ['{8BA5FB08-5195-40e2-AC58-0D989C3A0102}']
    // ID3DXBuffer
    function GetBufferPointer: Pointer; stdcall;
    function GetBufferSize: DWord; stdcall;
  end;

  IID_ID3DXBuffer = ID3DXBuffer;
  {$EXTERNALSYM IID_ID3DXBuffer}


//////////////////////////////////////////////////////////////////////////////
// D3DXSPRITE flags:
// -----------------
// D3DXSPRITE_DONOTSAVESTATE
//   Specifies device state is not to be saved and restored in Begin/End.
// D3DXSPRITE_DONOTMODIFY_RENDERSTATE
//   Specifies device render state is not to be changed in Begin.  The device
//   is assumed to be in a valid state to draw vertices containing POSITION0,
//   TEXCOORD0, and COLOR0 data.
// D3DXSPRITE_OBJECTSPACE
//   The WORLD, VIEW, and PROJECTION transforms are NOT modified.  The
//   transforms currently set to the device are used to transform the sprites
//   when the batch is drawn (at Flush or End).  If this is not specified,
//   WORLD, VIEW, and PROJECTION transforms are modified so that sprites are
//   drawn in screenspace coordinates.
// D3DXSPRITE_BILLBOARD
//   Rotates each sprite about its center so that it is facing the viewer.
// D3DXSPRITE_ALPHABLEND
//   Enables ALPHABLEND(SRCALPHA, INVSRCALPHA) and ALPHATEST(alpha > 0).
//   ID3DXFont expects this to be set when drawing text.
// D3DXSPRITE_SORT_TEXTURE
//   Sprites are sorted by texture prior to drawing.  This is recommended when
//   drawing non-overlapping sprites of uniform depth.  For example, drawing
//   screen-aligned text with ID3DXFont.
// D3DXSPRITE_SORT_DEPTH_FRONTTOBACK
//   Sprites are sorted by depth front-to-back prior to drawing.  This is
//   recommended when drawing opaque sprites of varying depths.
// D3DXSPRITE_SORT_DEPTH_BACKTOFRONT
//   Sprites are sorted by depth back-to-front prior to drawing.  This is
//   recommended when drawing transparent sprites of varying depths.
// D3DXSPRITE_DO_NOT_ADDREF_TEXTURE
//   Disables calling AddRef() on every draw, and Release() on Flush() for
//   better performance.
//////////////////////////////////////////////////////////////////////////////

const
  D3DXSPRITE_DONOTSAVESTATE               = (1 shl 0);
  {$EXTERNALSYM D3DXSPRITE_DONOTSAVESTATE}
  D3DXSPRITE_DONOTMODIFY_RENDERSTATE      = (1 shl 1);
  {$EXTERNALSYM D3DXSPRITE_DONOTMODIFY_RENDERSTATE}
  D3DXSPRITE_OBJECTSPACE                  = (1 shl 2);
  {$EXTERNALSYM D3DXSPRITE_OBJECTSPACE}
  D3DXSPRITE_BILLBOARD                    = (1 shl 3);
  {$EXTERNALSYM D3DXSPRITE_BILLBOARD}
  D3DXSPRITE_ALPHABLEND                   = (1 shl 4);
  {$EXTERNALSYM D3DXSPRITE_ALPHABLEND}
  D3DXSPRITE_SORT_TEXTURE                 = (1 shl 5);
  {$EXTERNALSYM D3DXSPRITE_SORT_TEXTURE}
  D3DXSPRITE_SORT_DEPTH_FRONTTOBACK       = (1 shl 6);
  {$EXTERNALSYM D3DXSPRITE_SORT_DEPTH_FRONTTOBACK}
  D3DXSPRITE_SORT_DEPTH_BACKTOFRONT       = (1 shl 7);
  {$EXTERNALSYM D3DXSPRITE_SORT_DEPTH_BACKTOFRONT}
  D3DXSPRITE_DO_NOT_ADDREF_TEXTURE        = (1 shl 8);
  {$EXTERNALSYM D3DXSPRITE_DO_NOT_ADDREF_TEXTURE}


//////////////////////////////////////////////////////////////////////////////
// ID3DXSprite:
// ------------
// This object intends to provide an easy way to drawing sprites using D3D.
//
// Begin -
//    Prepares device for drawing sprites.
//
// Draw -
//    Draws a sprite.  Before transformation, the sprite is the size of
//    SrcRect, with its top-left corner specified by Position.  The color
//    and alpha channels are modulated by Color.
//
// Flush -
//    Forces all batched sprites to submitted to the device.
//
// End -
//    Restores device state to how it was when Begin was called.
//
// OnLostDevice, OnResetDevice -
//    Call OnLostDevice() on this object before calling Reset() on the
//    device, so that this object can release any stateblocks and video
//    memory resources.  After Reset(), the call OnResetDevice().
//////////////////////////////////////////////////////////////////////////////

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXSprite);'}
  {$EXTERNALSYM ID3DXSprite}
  ID3DXSprite = interface(IUnknown)
    ['{BA0B762D-7D28-43ec-B9DC-2F84443B0614}']
    // ID3DXSprite
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;

    function GetTransform(out pTransform: TD3DXMatrix): HResult; stdcall;
    function SetTransform(const pTransform: TD3DXMatrix): HResult; stdcall;

    function SetWorldViewRH(pWorld, pView: PD3DXMatrix): HResult; stdcall;
    function SetWorldViewLH(pWorld, pView: PD3DXMatrix): HResult; stdcall;

    function _Begin(Flags: DWORD): HResult; stdcall;
    function Draw(pTexture: IDirect3DTexture9; pSrcRect: PRect; pCenter, pPosition: PD3DXVector3; Color: TD3DColor): HResult; stdcall;
    function Flush: HResult; stdcall;
    function _End: HResult; stdcall;

    function OnLostDevice: HResult; stdcall;
    function OnResetDevice: HResult; stdcall;
  end;

  IID_ID3DXSprite = ID3DXSprite;
  {$EXTERNALSYM IID_ID3DXSprite}

function D3DXCreateSprite(pDevice: IDirect3DDevice9;
  out ppSprite: ID3DXSprite): HResult; stdcall; external d3dx9coreDLL;
{$EXTERNALSYM D3DXCreateSprite}



//////////////////////////////////////////////////////////////////////////////
// ID3DXFont:
// ----------
// Font objects contain the textures and resources needed to render a specific 
// font on a specific device.
//
// GetGlyphData -
//    Returns glyph cache data, for a given glyph.
//
// PreloadCharacters/PreloadGlyphs/PreloadText -
//    Preloads glyphs into the glyph cache textures.
//
// DrawText -
//    Draws formatted text on a D3D device.  Some parameters are 
//    surprisingly similar to those of GDI's DrawText function.  See GDI 
//    documentation for a detailed description of these parameters.
//    If pSprite is NULL, an internal sprite object will be used.
//
// OnLostDevice, OnResetDevice -
//    Call OnLostDevice() on this object before calling Reset() on the
//    device, so that this object can release any stateblocks and video
//    memory resources.  After Reset(), the call OnResetDevice().
//////////////////////////////////////////////////////////////////////////////

type
  PD3DXFontDescA = ^TD3DXFontDescA;
  PD3DXFontDescW = ^TD3DXFontDescW;
  PD3DXFontDesc = PD3DXFontDescA;
  _D3DXFONT_DESCA = record
    Height: Integer;
    Width: Longint;
    Weight: LongWord;
    MipLevels: LongWord;
    Italic: BOOL;
    CharSet: Byte;
    OutputPrecision: Byte;
    Quality: Byte;
    PitchAndFamily: Byte;
    FaceName: array[0..LF_FACESIZE-1] of AnsiChar;
  end;
  {$EXTERNALSYM _D3DXFONT_DESCA}
  _D3DXFONT_DESCW = record
    Height: Integer;
    Width: Longint;
    Weight: LongWord;
    MipLevels: LongWord;
    Italic: BOOL;
    CharSet: Byte;
    OutputPrecision: Byte;
    Quality: Byte;
    PitchAndFamily: Byte;
    FaceName: array[0..LF_FACESIZE-1] of WideChar;
  end;
  {$EXTERNALSYM _D3DXFONT_DESCW}
  _D3DXFONT_DESC = _D3DXFONT_DESCA;
  {$EXTERNALSYM _D3DXFONT_DESC}
  D3DXFONT_DESCA = _D3DXFONT_DESCA;
  {$EXTERNALSYM D3DXFONT_DESCA}
  D3DXFONT_DESCW = _D3DXFONT_DESCW;
  {$EXTERNALSYM D3DXFONT_DESCW}
  D3DXFONT_DESC = D3DXFONT_DESCA;
  {$EXTERNALSYM D3DXFONT_DESC}
  TD3DXFontDescA = _D3DXFONT_DESCA;
  TD3DXFontDescW = _D3DXFONT_DESCW;
  TD3DXFontDesc = TD3DXFontDescA;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXFont);'}
  {$EXTERNALSYM ID3DXFont}
  ID3DXFont = interface(IUnknown)
    ['{D79DBB70-5F21-4d36-BBC2-FF525C213CDC}']
    // ID3DXFont
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetDescA(out pDesc: TD3DXFontDescA): HResult; stdcall;
    function GetDescW(out pDesc: TD3DXFontDescW): HResult; stdcall;
    function GetTextMetricsA(out pTextMetrics: TTextMetricA): BOOL; stdcall;
    function GetTextMetricsW(out pTextMetrics: TTextMetricW): BOOL; stdcall;

    function GetDC: HDC; stdcall;
    function GetGlyphData(Glyph: LongWord; out ppTexture: IDirect3DTexture9; pBlackBox: PRect; pCellInc: PPoint): HResult; stdcall;

    function PreloadCharacters(First, Last: LongWord): HResult; stdcall;
    function PreloadGlyphs(First, Last: LongWord): HResult; stdcall;
    function PreloadTextA(pString: PAnsiChar; Count: Integer): HResult; stdcall;
    function PreloadTextW(pString: PWideChar; Count: Integer): HResult; stdcall;

    function DrawTextA(pSprite: ID3DXSprite; pString: PAnsiChar; Count: Integer; pRect: PRect; Format: DWORD; Color: TD3DColor): Integer; stdcall;
    function DrawTextW(pSprite: ID3DXSprite; pString: PWideChar; Count: Integer; pRect: PRect; Format: DWORD; Color: TD3DColor): Integer; stdcall;

    function OnLostDevice: HResult; stdcall;
    function OnResetDevice: HResult; stdcall;
  end;

  IID_ID3DXFont = ID3DXFont;
  {$EXTERNALSYM IID_ID3DXFont}


function D3DXCreateFontA(
  pDevice: IDirect3DDevice9;
  Height: Integer;
  Width: Longint;
  Weight: LongWord;
  MipLevels: LongWord;
  Italic: BOOL;
  CharSet: DWORD;
  OutputPrecision: DWORD;
  Quality: DWORD;
  PitchAndFamily: DWORD;
  pFaceName: PAnsiChar;
  out ppFont: ID3DXFont): HResult; stdcall; external d3dx9coreDLL name 'D3DXCreateFontA';
{$EXTERNALSYM D3DXCreateFontA}

function D3DXCreateFontW(
  pDevice: IDirect3DDevice9;
  Height: Integer;
  Width: Longint;
  Weight: LongWord;
  MipLevels: LongWord;
  Italic: BOOL;
  CharSet: DWORD;
  OutputPrecision: DWORD;
  Quality: DWORD;
  PitchAndFamily: DWORD;
  pFaceName: PWideChar;
  out ppFont: ID3DXFont): HResult; stdcall; external d3dx9coreDLL name 'D3DXCreateFontW';
{$EXTERNALSYM D3DXCreateFontW}

function D3DXCreateFont(
  pDevice: IDirect3DDevice9;
  Height: Integer;
  Width: Longint;
  Weight: LongWord;
  MipLevels: LongWord;
  Italic: BOOL;
  CharSet: DWORD;
  OutputPrecision: DWORD;
  Quality: DWORD;
  PitchAndFamily: DWORD;
  pFaceName: PChar;
  out ppFont: ID3DXFont): HResult; stdcall; external d3dx9coreDLL name 'D3DXCreateFontA';
{$EXTERNALSYM D3DXCreateFont}


function D3DXCreateFontIndirectA(
  pDevice: IDirect3DDevice9;
  const pDesc: TD3DXFontDescA;
  out ppFont: ID3DXFont): HResult; stdcall; external d3dx9coreDLL name 'D3DXCreateFontIndirectA';
{$EXTERNALSYM D3DXCreateFontIndirectA}

function D3DXCreateFontIndirectW(
  pDevice: IDirect3DDevice9;
  const pDesc: TD3DXFontDescW;
  out ppFont: ID3DXFont): HResult; stdcall; external d3dx9coreDLL name 'D3DXCreateFontIndirectW';
{$EXTERNALSYM D3DXCreateFontIndirectW}

function D3DXCreateFontIndirect(
  pDevice: IDirect3DDevice9;
  const pDesc: TD3DXFontDesc;
  out ppFont: ID3DXFont): HResult; stdcall; external d3dx9coreDLL name 'D3DXCreateFontIndirectA';
{$EXTERNALSYM D3DXCreateFontIndirect}





///////////////////////////////////////////////////////////////////////////
// ID3DXRenderToSurface:
// ---------------------
// This object abstracts rendering to surfaces.  These surfaces do not
// necessarily need to be render targets.  If they are not, a compatible
// render target is used, and the result copied into surface at end scene.
//
// BeginScene, EndScene -
//    Call BeginScene() and EndScene() at the beginning and ending of your
//    scene.  These calls will setup and restore render targets, viewports,
//    etc..
//
// OnLostDevice, OnResetDevice -
//    Call OnLostDevice() on this object before calling Reset() on the
//    device, so that this object can release any stateblocks and video
//    memory resources.  After Reset(), the call OnResetDevice().
///////////////////////////////////////////////////////////////////////////
type

  PD3DXRTSDesc = ^TD3DXRTSDesc;
  _D3DXRTS_DESC = record
    Width: LongWord;
    Height: LongWord;
    Format: TD3DFormat;
    DepthStencil: BOOL;
    DepthStencilFormat: TD3DFormat;
  end {_D3DXRTS_DESC};
  {$EXTERNALSYM _D3DXRTS_DESC}
  D3DXRTS_DESC = _D3DXRTS_DESC;
  {$EXTERNALSYM D3DXRTS_DESC}
  TD3DXRTSDesc = _D3DXRTS_DESC;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXRenderToSurface);'}
  {$EXTERNALSYM ID3DXRenderToSurface}
  ID3DXRenderToSurface = interface(IUnknown)
    ['{6985F346-2C3D-43b3-BE8B-DAAE8A03D894}']
    // ID3DXRenderToSurface
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetDesc(out pDesc: TD3DXRTSDesc): HResult; stdcall;

    function BeginScene(pSurface: IDirect3DSurface9; pViewport: PD3DViewport9): HResult; stdcall;
    function EndScene(MipFilter: DWORD): HResult; stdcall;

    function OnLostDevice: HResult; stdcall;
    function OnResetDevice: HResult; stdcall;
  end;

  IID_ID3DXRenderToSurface = ID3DXRenderToSurface;
  {$EXTERNALSYM IID_ID3DXRenderToSurface}


function D3DXCreateRenderToSurface(ppDevice: IDirect3DDevice9;
  Width: LongWord;
  Height: LongWord;
  Format: TD3DFormat;
  DepthStencil: BOOL;
  DepthStencilFormat: TD3DFormat;
  out ppRenderToSurface: ID3DXRenderToSurface): HResult; stdcall; external d3dx9coreDLL;
{$EXTERNALSYM D3DXCreateRenderToSurface}




///////////////////////////////////////////////////////////////////////////
// ID3DXRenderToEnvMap:
// --------------------
// This object abstracts rendering to environment maps.  These surfaces
// do not necessarily need to be render targets.  If they are not, a
// compatible render target is used, and the result copied into the
// environment map at end scene.
//
// BeginCube, BeginSphere, BeginHemisphere, BeginParabolic -
//    This function initiates the rendering of the environment map.  As
//    parameters, you pass the textures in which will get filled in with
//    the resulting environment map.
//
// Face -
//    Call this function to initiate the drawing of each face.  For each
//    environment map, you will call this six times.. once for each face
//    in D3DCUBEMAP_FACES.
//
// End -
//    This will restore all render targets, and if needed compose all the
//    rendered faces into the environment map surfaces.
//
// OnLostDevice, OnResetDevice -
//    Call OnLostDevice() on this object before calling Reset() on the
//    device, so that this object can release any stateblocks and video
//    memory resources.  After Reset(), the call OnResetDevice().
///////////////////////////////////////////////////////////////////////////
type

  PD3DXRTEDesc = ^TD3DXRTEDesc;
  _D3DXRTE_DESC = record
    Size: LongWord;
    MipLevels: LongWord;
    Format: TD3DFormat;
    DepthStencil: Bool;
    DepthStencilFormat: TD3DFormat;
  end {_D3DXRTE_DESC};
  {$EXTERNALSYM _D3DXRTE_DESC}
  D3DXRTE_DESC = _D3DXRTE_DESC;
  {$EXTERNALSYM D3DXRTE_DESC}
  TD3DXRTEDesc = _D3DXRTE_DESC;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXRenderToEnvMap);'}
  {$EXTERNALSYM ID3DXRenderToEnvMap}
  ID3DXRenderToEnvMap = interface(IUnknown)
    ['{313F1B4B-C7B0-4fa2-9D9D-8D380B64385E}']
    // ID3DXRenderToEnvMap
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetDesc(out pDesc: TD3DXRTEDesc): HResult; stdcall;

    function BeginCube(pCubeTex: IDirect3DCubeTexture9): HResult; stdcall;

    function BeginSphere(pTex: IDirect3DTexture9): HResult; stdcall;

    function BeginHemisphere(pTexZPos, pTexZNeg: IDirect3DTexture9): HResult; stdcall;

    function BeginParabolic(pTexZPos, pTexZNeg: IDirect3DTexture9): HResult; stdcall;

    function Face(Face: TD3DCubemapFaces; MipFilter: DWORD): HResult; stdcall;
    function _End(MipFilter: DWORD): HResult; stdcall;

    function OnLostDevice: HResult; stdcall;
    function OnResetDevice: HResult; stdcall;
  end;

  IID_ID3DXRenderToEnvMap = ID3DXRenderToEnvMap;
  {$EXTERNALSYM IID_ID3DXRenderToEnvMap}


function D3DXCreateRenderToEnvMap(ppDevice: IDirect3DDevice9;
  Size: LongWord;
  MipLevels: LongWord;
  Format: TD3DFormat;
  DepthStencil: BOOL;
  DepthStencilFormat: TD3DFormat;
  out ppRenderToEnvMap: ID3DXRenderToEnvMap): HResult; stdcall; external d3dx9coreDLL;
{$EXTERNALSYM D3DXCreateRenderToEnvMap}



///////////////////////////////////////////////////////////////////////////
// ID3DXLine:
// ------------
// This object intends to provide an easy way to draw lines using D3D.
//
// Begin -
//    Prepares device for drawing lines
//
// Draw -
//    Draws a line strip in screen-space.
//    Input is in the form of a array defining points on the line strip. of D3DXVECTOR2 
//
// DrawTransform -
//    Draws a line in screen-space with a specified input transformation matrix.
//
// End - 
//     Restores device state to how it was when Begin was called.
//
// SetPattern - 
//     Applies a stipple pattern to the line.  Input is one 32-bit
//     DWORD which describes the stipple pattern. 1 is opaque, 0 is
//     transparent.
//
// SetPatternScale -
//     Stretches the stipple pattern in the u direction.  Input is one
//     floating-point value.  0.0f is no scaling, whereas 1.0f doubles
//     the length of the stipple pattern.
//
// SetWidth - 
//     Specifies the thickness of the line in the v direction.  Input is
//     one floating-point value.
//
// SetAntialias - 
//     Toggles line antialiasing.  Input is a BOOL.
//     TRUE  = Antialiasing on.
//     FALSE = Antialiasing off.
//
// SetGLLines - 
//     Toggles non-antialiased OpenGL line emulation.  Input is a BOOL.
//     TRUE  = OpenGL line emulation on.
//     FALSE = OpenGL line emulation off.
//
// OpenGL line:     Regular line:
//   *\                *\
//   | \              /  \
//   |  \            *\   \
//   *\  \             \   \
//     \  \             \   \
//      \  *             \   *
//       \ |              \ /
//        \|               *
//         *
//
// OnLostDevice, OnResetDevice -
//    Call OnLostDevice() on this object before calling Reset() on the
//    device, so that this object can release any stateblocks and video
//    memory resources.  After Reset(), the call OnResetDevice().
///////////////////////////////////////////////////////////////////////////
type

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXLine);'}
  {$EXTERNALSYM ID3DXLine}
  ID3DXLine = interface(IUnknown)
    ['{D379BA7F-9042-4ac4-9F5E-58192A4C6BD8}']
    // ID3DXLine
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;

    function _Begin: HResult; stdcall;

    function Draw(pVertexList: PD3DXVector2; dwVertexListCount: DWORD; Color: TD3DColor): HResult; stdcall;

    function DrawTransform(pVertexList: PD3DXVector3; dwVertexListCount: DWORD;
      const pTransform: TD3DXMatrix; Color: TD3DColor): HResult; stdcall;

    function SetPattern(dwPattern: DWORD): HResult; stdcall;
    function GetPattern: DWORD; stdcall;

    function SetPatternScale(fPatternScale: Single): HResult; stdcall;
    function GetPatternScale: Single; stdcall;

    function SetWidth(fWidth: Single): HResult; stdcall;
    function GetWidth: Single; stdcall;

    function SetAntialias(bAntialias: BOOL): HResult; stdcall;
    function GetAntialias: BOOL; stdcall;

    function SetGLLines(bGLLines: BOOL): HResult; stdcall;
    function GetGLLines: BOOL; stdcall;

    function _End: HResult; stdcall;

    function OnLostDevice: HResult; stdcall;
    function OnResetDevice: HResult; stdcall;
  end;

  IID_ID3DXLine = ID3DXLine;
  {$EXTERNALSYM IID_ID3DXLine}


function D3DXCreateLine(ppDevice: IDirect3DDevice9;
  out ppLine: ID3DXLine): HResult; stdcall; external d3dx9coreDLL;
{$EXTERNALSYM D3DXCreateLine}





//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//
//  File:       d3dx9shader.h
//  Content:    D3DX Shader APIs
//
//////////////////////////////////////////////////////////////////////////////


//---------------------------------------------------------------------------
// D3DXTX_VERSION:
// --------------
// Version token used to create a procedural texture filler in effects
// Used by D3DXFill[]TX functions
//---------------------------------------------------------------------------
// #define D3DXTX_VERSION(_Major,_Minor) (('T' << 24) | ('X' << 16) | ((_Major) << 8) | (_Minor))
function D3DXTX_VERSION(_Major, _Minor: Byte): DWORD;
{$EXTERNALSYM D3DXTX_VERSION}



//----------------------------------------------------------------------------
// D3DXSHADER flags:
// -----------------
// D3DXSHADER_DEBUG
//   Insert debug file/line/type/symbol information.
//
// D3DXSHADER_SKIPVALIDATION
//   Do not validate the generated code against known capabilities and
//   constraints.  This option is only recommended when compiling shaders
//   you KNOW will work.  (ie. have compiled before without this option.)
//   Shaders are always validated by D3D before they are set to the device.
//
// D3DXSHADER_SKIPOPTIMIZATION 
//   Instructs the compiler to skip optimization steps during code generation.
//   Unless you are trying to isolate a problem in your code using this option 
//   is not recommended.
//
// D3DXSHADER_PACKMATRIX_ROWMAJOR
//   Unless explicitly specified, matrices will be packed in row-major order
//   on input and output from the shader.
//
// D3DXSHADER_PACKMATRIX_COLUMNMAJOR
//   Unless explicitly specified, matrices will be packed in column-major
//   order on input and output from the shader.  This is generally more
//   efficient, since it allows vector-matrix multiplication to be performed
//   using a series of dot-products.
//
// D3DXSHADER_PARTIALPRECISION
//   Force all computations in resulting shader to occur at partial precision.
//   This may result in faster evaluation of shaders on some hardware.
//
// D3DXSHADER_FORCE_VS_SOFTWARE_NOOPT
//   Force compiler to compile against the next highest available software
//   target for vertex shaders.  This flag also turns optimizations off, 
//   and debugging on.
//
// D3DXSHADER_FORCE_PS_SOFTWARE_NOOPT
//   Force compiler to compile against the next highest available software
//   target for pixel shaders.  This flag also turns optimizations off, 
//   and debugging on.
//
// D3DXSHADER_NO_PRESHADER
//   Disables Preshaders. Using this flag will cause the compiler to not 
//   pull out static expression for evaluation on the host cpu
//
// D3DXSHADER_AVOID_FLOW_CONTROL
//   Hint compiler to avoid flow-control constructs where possible.
//
// D3DXSHADER_PREFER_FLOW_CONTROL
//   Hint compiler to prefer flow-control constructs where possible.
//
//----------------------------------------------------------------------------
const
  D3DXSHADER_DEBUG                    = (1 shl 0);
  {$EXTERNALSYM D3DXSHADER_DEBUG}
  D3DXSHADER_SKIPVALIDATION           = (1 shl 1);
  {$EXTERNALSYM D3DXSHADER_SKIPVALIDATION}
  D3DXSHADER_SKIPOPTIMIZATION         = (1 shl 2);
  {$EXTERNALSYM D3DXSHADER_SKIPOPTIMIZATION}
  D3DXSHADER_PACKMATRIX_ROWMAJOR      = (1 shl 3);
  {$EXTERNALSYM D3DXSHADER_PACKMATRIX_ROWMAJOR}
  D3DXSHADER_PACKMATRIX_COLUMNMAJOR   = (1 shl 4);
  {$EXTERNALSYM D3DXSHADER_PACKMATRIX_COLUMNMAJOR}
  D3DXSHADER_PARTIALPRECISION         = (1 shl 5);
  {$EXTERNALSYM D3DXSHADER_PARTIALPRECISION}
  D3DXSHADER_FORCE_VS_SOFTWARE_NOOPT  = (1 shl 6);
  {$EXTERNALSYM D3DXSHADER_FORCE_VS_SOFTWARE_NOOPT}
  D3DXSHADER_FORCE_PS_SOFTWARE_NOOPT  = (1 shl 7);
  {$EXTERNALSYM D3DXSHADER_FORCE_PS_SOFTWARE_NOOPT}
  D3DXSHADER_NO_PRESHADER             = (1 shl 8);
  {$EXTERNALSYM D3DXSHADER_NO_PRESHADER}
  D3DXSHADER_AVOID_FLOW_CONTROL       = (1 shl 9);
  {$EXTERNALSYM D3DXSHADER_AVOID_FLOW_CONTROL}
  D3DXSHADER_PREFER_FLOW_CONTROL      = (1 shl 10);
  {$EXTERNALSYM D3DXSHADER_PREFER_FLOW_CONTROL}
  D3DXSHADER_ENABLE_BACKWARDS_COMPATIBILITY = (1 shl 12);
  {$EXTERNALSYM D3DXSHADER_ENABLE_BACKWARDS_COMPATIBILITY}
  D3DXSHADER_IEEE_STRICTNESS          = (1 shl 13);
  {$EXTERNALSYM D3DXSHADER_IEEE_STRICTNESS}
  D3DXSHADER_USE_LEGACY_D3DX9_31_DLL  = (1 shl 16);
  {$EXTERNALSYM D3DXSHADER_USE_LEGACY_D3DX9_31_DLL}


  // optimization level flags
  D3DXSHADER_OPTIMIZATION_LEVEL0            = (1 shl 14);
  {$EXTERNALSYM D3DXSHADER_OPTIMIZATION_LEVEL0}
  D3DXSHADER_OPTIMIZATION_LEVEL1            = 0;
  {$EXTERNALSYM D3DXSHADER_OPTIMIZATION_LEVEL1}
  D3DXSHADER_OPTIMIZATION_LEVEL2            = ((1 shl 14) or (1 shl 15));
  {$EXTERNALSYM D3DXSHADER_OPTIMIZATION_LEVEL2}
  D3DXSHADER_OPTIMIZATION_LEVEL3            = (1 shl 15);
  {$EXTERNALSYM D3DXSHADER_OPTIMIZATION_LEVEL3}



//----------------------------------------------------------------------------
// D3DXHANDLE:
// -----------
// Handle values used to efficiently reference shader and effect parameters.
// Strings can be used as handles.  However, handles are not always strings.
//----------------------------------------------------------------------------

type
  {$HPPEMIT 'typedef D3DXHANDLE TD3DXHandle;'}
  {$HPPEMIT 'typedef D3DXHANDLE *PD3DXHandle;'}
  PD3DXHandle = ^TD3DXHandle;
  {$EXTERNALSYM PD3DXHandle}
  TD3DXHandle = type PAnsiChar;
  {$NODEFINE TD3DXHandle}


//----------------------------------------------------------------------------
// D3DXMACRO:
// ----------
// Preprocessor macro definition.  The application pass in a NULL-terminated
// array of this structure to various D3DX APIs.  This enables the application
// to #define tokens at runtime, before the file is parsed.
//----------------------------------------------------------------------------

  PD3DXMacro = ^TD3DXMacro;
  _D3DXMACRO = record
    Name: PAnsiChar;
    Definition: PAnsiChar;
  end;
  {$EXTERNALSYM _D3DXMACRO}
  D3DXMACRO = _D3DXMACRO;
  {$EXTERNALSYM D3DXMACRO}
  TD3DXMacro = _D3DXMACRO;


//----------------------------------------------------------------------------
// D3DXSEMANTIC:
//----------------------------------------------------------------------------

  PD3DXSemantic = ^TD3DXSemantic;
  _D3DXSEMANTIC = record
    Usage: LongWord;
    UsageIndex: LongWord;
  end;
  {$EXTERNALSYM _D3DXSEMANTIC}
  D3DXSEMANTIC = _D3DXSEMANTIC;
  {$EXTERNALSYM D3DXSEMANTIC}
  TD3DXSemantic = _D3DXSEMANTIC;



//----------------------------------------------------------------------------
// D3DXFRAGMENT_DESC:
//----------------------------------------------------------------------------

  PD3DXFragmentDesc = ^TD3DXFragmentDesc;
  _D3DXFRAGMENT_DESC = record
    Name: PAnsiChar;
    Target: DWORD;
  end;
  {$EXTERNALSYM _D3DXFRAGMENT_DESC}
  D3DXFRAGMENT_DESC = _D3DXFRAGMENT_DESC;
  {$EXTERNALSYM D3DXFRAGMENT_DESC}
  TD3DXFragmentDesc = _D3DXFRAGMENT_DESC;


//----------------------------------------------------------------------------
// D3DXREGISTER_SET:
//----------------------------------------------------------------------------

  _D3DXREGISTER_SET = (
    D3DXRS_BOOL,
    D3DXRS_INT4,
    D3DXRS_FLOAT4,
    D3DXRS_SAMPLER
  );
  {$EXTERNALSYM _D3DXREGISTER_SET}
  D3DXREGISTER_SET = _D3DXREGISTER_SET;
  {$EXTERNALSYM D3DXREGISTER_SET}
  TD3DXRegisterSet = _D3DXREGISTER_SET;


//----------------------------------------------------------------------------
// D3DXPARAMETER_CLASS:
//----------------------------------------------------------------------------

  _D3DXPARAMETER_CLASS = (
    D3DXPC_SCALAR,
    D3DXPC_VECTOR,
    D3DXPC_MATRIX_ROWS,
    D3DXPC_MATRIX_COLUMNS,
    D3DXPC_OBJECT,
    D3DXPC_STRUCT
  );
  {$EXTERNALSYM _D3DXPARAMETER_CLASS}
  D3DXPARAMETER_CLASS = _D3DXPARAMETER_CLASS;
  {$EXTERNALSYM D3DXPARAMETER_CLASS}
  TD3DXParameterClass = _D3DXPARAMETER_CLASS;


//----------------------------------------------------------------------------
// D3DXPARAMETER_TYPE:
//----------------------------------------------------------------------------

  _D3DXPARAMETER_TYPE = (
    D3DXPT_VOID,
    D3DXPT_BOOL,
    D3DXPT_INT,
    D3DXPT_FLOAT,
    D3DXPT_STRING,
    D3DXPT_TEXTURE,
    D3DXPT_TEXTURE1D,
    D3DXPT_TEXTURE2D,
    D3DXPT_TEXTURE3D,
    D3DXPT_TEXTURECUBE,
    D3DXPT_SAMPLER,
    D3DXPT_SAMPLER1D,
    D3DXPT_SAMPLER2D,
    D3DXPT_SAMPLER3D,
    D3DXPT_SAMPLERCUBE,
    D3DXPT_PIXELSHADER,
    D3DXPT_VERTEXSHADER,
    D3DXPT_PIXELFRAGMENT,
    D3DXPT_VERTEXFRAGMENT,
    D3DXPT_UNSUPPORTED
  );
  {$EXTERNALSYM _D3DXPARAMETER_TYPE}
  D3DXPARAMETER_TYPE = _D3DXPARAMETER_TYPE;
  {$EXTERNALSYM D3DXPARAMETER_TYPE}
  TD3DXParameterType = _D3DXPARAMETER_TYPE;



//----------------------------------------------------------------------------
// D3DXCONSTANTTABLE_DESC:
//----------------------------------------------------------------------------

  PD3DXConstantTableDesc = ^TD3DXConstantTableDesc;
  _D3DXCONSTANTTABLE_DESC = record
    Creator: PAnsiChar;                 // Creator string
    Version: DWORD;                     // Shader version
    Constants: LongWord;                // Number of constants
  end;
  {$EXTERNALSYM _D3DXCONSTANTTABLE_DESC}
  D3DXCONSTANTTABLE_DESC = _D3DXCONSTANTTABLE_DESC;
  {$EXTERNALSYM D3DXCONSTANTTABLE_DESC}
  TD3DXConstantTableDesc = _D3DXCONSTANTTABLE_DESC;


//----------------------------------------------------------------------------
// D3DXCONSTANT_DESC:
//----------------------------------------------------------------------------

   PD3DXConstantDesc = ^TD3DXConstantDesc;
  _D3DXCONSTANT_DESC = record
    Name: PAnsiChar;                    // Constant name

    RegisterSet: TD3DXRegisterSet;      // Register set
    RegisterIndex: LongWord;            // Register index
    RegisterCount: LongWord;            // Number of registers occupied

    _Class: TD3DXParameterClass;        // Class
    _Type: TD3DXParameterType;          // Component type

    Rows: LongWord;                     // Number of rows
    Columns: LongWord;                  // Number of columns
    Elements: LongWord;                 // Number of array elements
    StructMembers: LongWord;            // Number of structure member sub-parameters

    Bytes: LongWord;                    // Data size, in bytes
    DefaultValue: Pointer;              // Pointer to default value
  end;
  {$EXTERNALSYM _D3DXCONSTANT_DESC}
  D3DXCONSTANT_DESC = _D3DXCONSTANT_DESC;
  {$EXTERNALSYM D3DXCONSTANT_DESC}
  TD3DXConstantDesc = _D3DXCONSTANT_DESC;



//----------------------------------------------------------------------------
// ID3DXConstantTable:
//----------------------------------------------------------------------------


  PID3DXConstantTable = ^ID3DXConstantTable;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXConstantTable);'}
  {$EXTERNALSYM ID3DXConstantTable}
  ID3DXConstantTable = interface(ID3DXBuffer)
    ['{AB3C758F-093E-4356-B762-4DB18F1B3A01}']
    // Descs
    function GetDesc(out pDesc: TD3DXConstantTableDesc): HResult; stdcall;
    function GetConstantDesc(hConstant: TD3DXHandle; pConstantDesc: PD3DXConstantDesc; var pCount: LongWord): HResult; stdcall;
    function GetSamplerIndex(hConstant: TD3DXHandle): LongWord; stdcall;

    // Handle operations
    function GetConstant(hConstant: TD3DXHandle; Index: LongWord): TD3DXHandle; stdcall;
    function GetConstantByName(hConstant: TD3DXHandle; pName: PAnsiChar): TD3DXHandle; stdcall;
    function GetConstantElement(hConstant: TD3DXHandle; Index: LongWord): TD3DXHandle; stdcall;

    // Set Constants
    function SetDefaults(pDevice: IDirect3DDevice9): HResult; stdcall;
    function SetValue(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; pData: Pointer; Bytes: LongWord): HResult; stdcall;
    function SetBool(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; b: BOOL): HResult; stdcall;
    function SetBoolArray(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; pb: PBOOL; Count: LongWord): HResult; stdcall;
    function SetInt(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; n: Integer): HResult; stdcall;
    function SetIntArray(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; pn: PInteger; Count: LongWord): HResult; stdcall;
    function SetFloat(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; f: Single): HResult; stdcall;
    function SetFloatArray(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; pf: PSingle; Count: LongWord): HResult; stdcall;
    function SetVector(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; const pVector: TD3DXVector4): HResult; stdcall;
    function SetVectorArray(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; pVector: PD3DXVector4; Count: LongWord): HResult; stdcall;
    function SetMatrix(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; const pMatrix: TD3DXMatrix): HResult; stdcall;
    function SetMatrixArray(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; pMatrix: PD3DXMatrix; Count: LongWord): HResult; stdcall;
    function SetMatrixPointerArray(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; ppMatrix: PPD3DXMatrix; Count: LongWord): HResult; stdcall;
    function SetMatrixTranspose(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; const pMatrix: TD3DXMatrix): HResult; stdcall;
    function SetMatrixTransposeArray(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; pMatrix: PD3DXMatrix; Count: LongWord): HResult; stdcall;
    function SetMatrixTransposePointerArray(pDevice: IDirect3DDevice9; hConstant: TD3DXHandle; ppMatrix: PPD3DXMatrix; Count: LongWord): HResult; stdcall;
  end;

  IID_ID3DXConstantTable = ID3DXConstantTable;
  {$EXTERNALSYM IID_ID3DXConstantTable}


//----------------------------------------------------------------------------
// ID3DXTextureShader:
//----------------------------------------------------------------------------

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXTextureShader);'}
  {$EXTERNALSYM ID3DXTextureShader}
  ID3DXTextureShader = interface(IUnknown)
    ['{3E3D67F8-AA7A-405d-A857-BA01D4758426}']
    // Gets
    function GetFunction(out ppFunction: ID3DXBuffer): HResult; stdcall;
    function GetConstantBuffer(out ppConstantBuffer: ID3DXBuffer): HResult; stdcall;

    // Descs
    function GetDesc(out pDesc: TD3DXConstantTableDesc): HResult; stdcall;
    function GetConstantDesc(hConstant: TD3DXHandle; pConstantDesc: PD3DXConstantDesc; out pCount: LongWord): HResult; stdcall;

    // Handle operations
    function GetConstant(hConstant: TD3DXHandle; Index: LongWord): TD3DXHandle; stdcall;
    function GetConstantByName(hConstant: TD3DXHandle; pName: PAnsiChar): TD3DXHandle; stdcall;
    function GetConstantElement(hConstant: TD3DXHandle; Index: LongWord): TD3DXHandle; stdcall;

    // Set Constants
    function SetDefaults: HResult; stdcall;
    function SetValue(hConstant: TD3DXHandle; pData: Pointer; Bytes: LongWord): HResult; stdcall;
    function SetBool(hConstant: TD3DXHandle; b: BOOL): HResult; stdcall;
    function SetBoolArray(hConstant: TD3DXHandle; const pb: PBOOL; Count: LongWord): HResult; stdcall;
    function SetInt(hConstant: TD3DXHandle; n: Integer): HResult; stdcall;
    function SetIntArray(hConstant: TD3DXHandle; const pn: PInteger; Count: LongWord): HResult; stdcall;
    function SetFloat(hConstant: TD3DXHandle; f: Single): HResult; stdcall;
    function SetFloatArray(hConstant: TD3DXHandle; const pf: PSingle; Count: LongWord): HResult; stdcall;
    function SetVector(hConstant: TD3DXHandle; const pVector: TD3DXVector4): HResult; stdcall;
    function SetVectorArray(hConstant: TD3DXHandle; const pVector: PD3DXVector4; Count: LongWord): HResult; stdcall;
    function SetMatrix(hConstant: TD3DXHandle; const pMatrix: TD3DXMatrix): HResult; stdcall;
    function SetMatrixArray(hConstant: TD3DXHandle; const pMatrix: PD3DXMatrix; Count: LongWord): HResult; stdcall;
    function SetMatrixPointerArray(hConstant: TD3DXHandle; const ppMatrix: PPD3DXMatrix; Count: LongWord): HResult; stdcall;
    function SetMatrixTranspose(hConstant: TD3DXHandle; const pMatrix: TD3DXMatrix): HResult; stdcall;
    function SetMatrixTransposeArray(hConstant: TD3DXHandle; const pMatrix: PD3DXMatrix; Count: LongWord): HResult; stdcall;
    function SetMatrixTransposePointerArray(hConstant: TD3DXHandle; const ppMatrix: PPD3DXMatrix; Count: LongWord): HResult; stdcall;
  end;

  IID_ID3DXTextureShader = ID3DXTextureShader;
  {$EXTERNALSYM IID_ID3DXTextureShader}


//----------------------------------------------------------------------------
// ID3DXFragmentLinker
//----------------------------------------------------------------------------

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXFragmentLinker);'}
  {$EXTERNALSYM ID3DXFragmentLinker}
  ID3DXFragmentLinker = interface(IUnknown)
    ['{1A2C0CC2-E5B6-4ebc-9E8D-390E057811B6}']
    // ID3DXFragmentLinker

    // fragment access and information retrieval functions
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetNumberOfFragments: LongWord; stdcall;

    function GetFragmentHandleByIndex(Index: LongWord): TD3DXHandle; stdcall;
    function GetFragmentHandleByName(Name: PAnsiChar): TD3DXHandle; stdcall;
    function GetFragmentDesc(Name: TD3DXHandle; out FragDesc: TD3DXFragmentDesc): HResult; stdcall;

    // add the fragments in the buffer to the linker
    function AddFragments(Fragments: PDWORD): HResult; stdcall;

    // Create a buffer containing the fragments.  Suitable for saving to disk
    function GetAllFragments(out ppBuffer: ID3DXBuffer): HResult; stdcall;
    function GetFragment(Name: TD3DXHandle; out ppBuffer: ID3DXBuffer): HResult; stdcall;

    function LinkShader(pProfile: PAnsiChar; Flags: DWORD; rgFragmentHandles: PD3DXHandle; cFragments: LongWord; out ppBuffer: ID3DXBuffer; ppErrorMsgs: PID3DXBuffer): HResult; stdcall;
    function LinkVertexShader(pProfile: PAnsiChar; Flags: DWORD; rgFragmentHandles: PD3DXHandle; cFragments: LongWord; out pVShader: IDirect3DVertexShader9; ppErrorMsgs: PID3DXBuffer): HResult; stdcall;
    function LinkPixelShader(pProfile: PAnsiChar; Flags: DWORD; rgFragmentHandles: PD3DXHandle; cFragments: LongWord; out pPShader: IDirect3DPixelShader9; ppErrorMsgs: PID3DXBuffer): HResult; stdcall;

    function ClearCache: HResult; stdcall;
  end;


//----------------------------------------------------------------------------
// D3DXINCLUDE_TYPE:
//----------------------------------------------------------------------------
type
  PD3DXIncludeType = ^TD3DXIncludeType;
  _D3DXINCLUDE_TYPE = (
    D3DXINC_LOCAL,
    D3DXINC_SYSTEM
  );
  {$EXTERNALSYM _D3DXINCLUDE_TYPE}
  D3DXINCLUDE_TYPE = _D3DXINCLUDE_TYPE;
  {$EXTERNALSYM D3DXINCLUDE_TYPE}
  TD3DXIncludeType = _D3DXINCLUDE_TYPE;


//----------------------------------------------------------------------------
// ID3DXInclude:
// -------------
// This interface is intended to be implemented by the application, and can
// be used by various D3DX APIs.  This enables application-specific handling
// of #include directives in source files.
//
// Open()
//    Opens an include file.  If successful, it should fill in ppData and
//    pBytes.  The data pointer returned must remain valid until Close is
//    subsequently called.
// Close()
//    Closes an include file.  If Open was successful, Close is guaranteed
//    to be called before the API using this interface returns.
//----------------------------------------------------------------------------

  PID3DXInclude = ^ID3DXInclude;
  {$EXTERNALSYM ID3DXInclude}
  ID3DXInclude = class
    function Open(IncludeType: TD3DXIncludeType; pFileName: PAnsiChar; pParentData: Pointer; out ppData: Pointer; out pBytes: LongWord): HResult; virtual; stdcall; abstract;
    function Close(pData: Pointer): HResult; virtual; stdcall; abstract;
  end;


//////////////////////////////////////////////////////////////////////////////
// APIs //////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////



//----------------------------------------------------------------------------
// D3DXAssembleShader:
// -------------------
// Assembles a shader.
//
// Parameters:
//  pSrcFile
//      Source file name
//  hSrcModule
//      Module handle. if NULL, current module will be used
//  pSrcResource
//      Resource name in module
//  pSrcData
//      Pointer to source code
//  SrcDataLen
//      Size of source code, in bytes
//  pDefines
//      Optional NULL-terminated array of preprocessor macro definitions.
//  pInclude
//      Optional interface pointer to use for handling #include directives.
//      If this parameter is NULL, #includes will be honored when assembling
//      from file, and will error when assembling from resource or memory.
//  Flags
//      See D3DXSHADER_xxx flags
//  ppShader
//      Returns a buffer containing the created shader.  This buffer contains
//      the assembled shader code, as well as any embedded debug info.
//  ppErrorMsgs
//      Returns a buffer containing a listing of errors and warnings that were
//      encountered during assembly.  If you are running in a debugger,
//      these are the same messages you will see in your debug output.
//----------------------------------------------------------------------------

function D3DXAssembleShaderFromFileA(
  pSrcFile: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXAssembleShaderFromFileA';
{$EXTERNALSYM D3DXAssembleShaderFromFileA}

function D3DXAssembleShaderFromFileW(
  pSrcFile: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXAssembleShaderFromFileW';
{$EXTERNALSYM D3DXAssembleShaderFromFileW}

function D3DXAssembleShaderFromFile(
  pSrcFile: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXAssembleShaderFromFileA';
{$EXTERNALSYM D3DXAssembleShaderFromFile}


function D3DXAssembleShaderFromResourceA(
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWord;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXAssembleShaderFromResourceA';
{$EXTERNALSYM D3DXAssembleShaderFromResourceA}

function D3DXAssembleShaderFromResourceW(
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWord;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXAssembleShaderFromResourceW';
{$EXTERNALSYM D3DXAssembleShaderFromResourceW}

function D3DXAssembleShaderFromResource(
  hSrcModule: HModule;
  pSrcResource: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWord;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXAssembleShaderFromResourceA';
{$EXTERNALSYM D3DXAssembleShaderFromResource}


function D3DXAssembleShader(
  pSrcData: PAnsiChar;
  SrcDataLen: LongWord;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWord;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXAssembleShader}


  
//----------------------------------------------------------------------------
// D3DXCompileShader:
// ------------------
// Compiles a shader.
//
// Parameters:
//  pSrcFile
//      Source file name.
//  hSrcModule
//      Module handle. if NULL, current module will be used.
//  pSrcResource
//      Resource name in module.
//  pSrcData
//      Pointer to source code.
//  SrcDataLen
//      Size of source code, in bytes.
//  pDefines
//      Optional NULL-terminated array of preprocessor macro definitions.
//  pInclude
//      Optional interface pointer to use for handling #include directives.
//      If this parameter is NULL, #includes will be honored when compiling
//      from file, and will error when compiling from resource or memory.
//  pFunctionName
//      Name of the entrypoint function where execution should begin.
//  pProfile
//      Instruction set to be used when generating code.  Currently supported
//      profiles are "vs_1_1", "vs_2_0", "vs_2_a", "vs_2_sw", "ps_1_1",
//      "ps_1_2", "ps_1_3", "ps_1_4", "ps_2_0", "ps_2_a", "ps_2_sw", "tx_1_0"
//  Flags
//      See D3DXSHADER_xxx flags.
//  ppShader
//      Returns a buffer containing the created shader.  This buffer contains
//      the compiled shader code, as well as any embedded debug and symbol
//      table info.  (See D3DXGetShaderConstantTable)
//  ppErrorMsgs
//      Returns a buffer containing a listing of errors and warnings that were
//      encountered during the compile.  If you are running in a debugger,
//      these are the same messages you will see in your debug output.
//  ppConstantTable
//      Returns a ID3DXConstantTable object which can be used to set
//      shader constants to the device.  Alternatively, an application can
//      parse the D3DXSHADER_CONSTANTTABLE block embedded as a comment within
//      the shader.
//----------------------------------------------------------------------------

function D3DXCompileShaderFromFileA(
  pSrcFile: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pFunctionName: PAnsiChar;
  pProfile: PAnsiChar;
  Flags: DWORD;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer;
  ppConstantTable: PID3DXConstantTable): HResult; stdcall; external d3dx9shaderDLL name 'D3DXCompileShaderFromFileA';
{$EXTERNALSYM D3DXCompileShaderFromFileA}

function D3DXCompileShaderFromFileW(
  pSrcFile: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pFunctionName: PAnsiChar;
  pProfile: PAnsiChar;
  Flags: DWORD;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer;
  ppConstantTable: PID3DXConstantTable): HResult; stdcall; external d3dx9shaderDLL name 'D3DXCompileShaderFromFileW';
{$EXTERNALSYM D3DXCompileShaderFromFileW}

function D3DXCompileShaderFromFile(
  pSrcFile: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pFunctionName: PAnsiChar;
  pProfile: PAnsiChar;
  Flags: DWORD;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer;
  ppConstantTable: PID3DXConstantTable): HResult; stdcall; external d3dx9shaderDLL name 'D3DXCompileShaderFromFileA';
{$EXTERNALSYM D3DXCompileShaderFromFile}


function D3DXCompileShaderFromResourceA(
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pFunctionName: PAnsiChar;
  pProfile: PAnsiChar;
  Flags: DWORD;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer;
  ppConstantTable: PID3DXConstantTable): HResult; stdcall; external d3dx9shaderDLL name 'D3DXCompileShaderFromResourceA';
{$EXTERNALSYM D3DXCompileShaderFromResourceA}

function D3DXCompileShaderFromResourceW(
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pFunctionName: PAnsiChar;
  pProfile: PAnsiChar;
  Flags: DWORD;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer;
  ppConstantTable: PID3DXConstantTable): HResult; stdcall; external d3dx9shaderDLL name 'D3DXCompileShaderFromResourceW';
{$EXTERNALSYM D3DXCompileShaderFromResourceW}

function D3DXCompileShaderFromResource(
  hSrcModule: HModule;
  pSrcResource: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pFunctionName: PAnsiChar;
  pProfile: PAnsiChar;
  Flags: DWORD;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer;
  ppConstantTable: PID3DXConstantTable): HResult; stdcall; external d3dx9shaderDLL name 'D3DXCompileShaderFromResourceA';
{$EXTERNALSYM D3DXCompileShaderFromResource}


function D3DXCompileShader(
  pSrcData: PAnsiChar;
  SrcDataLen: LongWord;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pFunctionName: PAnsiChar;
  pProfile: PAnsiChar;
  Flags: DWORD;
  ppShader: PID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer;
  ppConstantTable: PID3DXConstantTable): HResult; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXCompileShader}


//----------------------------------------------------------------------------
// D3DXDisassembleShader:
// ----------------------
// Takes a binary shader, and returns a buffer containing text assembly.
//
// Parameters:
//  pShader
//      Pointer to the shader byte code.
//  ShaderSizeInBytes
//      Size of the shader byte code in bytes.
//  EnableColorCode
//      Emit HTML tags for color coding the output?
//  pComments
//      Pointer to a comment string to include at the top of the shader.
//  ppDisassembly
//      Returns a buffer containing the disassembled shader.
//----------------------------------------------------------------------------

function D3DXDisassembleShader(
  const pShader: PDWORD;
  EnableColorCode: BOOL;
  pComments: PAnsiChar;
  out ppDisassembly: ID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXDisassembleShader}


//----------------------------------------------------------------------------
// D3DXGetPixelShaderProfile/D3DXGetVertexShaderProfile:
// -----------------------------------------------------
// Returns the name of the HLSL profile best suited to a given device.
//
// Parameters:
//  pDevice
//      Pointer to the device in question
//----------------------------------------------------------------------------

function D3DXGetPixelShaderProfile(pDevice: IDirect3DDevice9): PAnsiChar; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXGetPixelShaderProfile}

function D3DXGetVertexShaderProfile(pDevice: IDirect3DDevice9): PAnsiChar; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXGetVertexShaderProfile}


//----------------------------------------------------------------------------
// D3DXFindShaderComment:
// ----------------------
// Searches through a shader for a particular comment, denoted by a FourCC in
// the first DWORD of the comment.  If the comment is not found, and no other
// error has occurred, S_FALSE is returned.
//
// Parameters:
//  pFunction
//      Pointer to the function DWORD stream
//  FourCC
//      FourCC used to identify the desired comment block.
//  ppData
//      Returns a pointer to the comment data (not including comment token
//      and FourCC).  Can be NULL.
//  pSizeInBytes
//      Returns the size of the comment data in bytes.  Can be NULL.
//----------------------------------------------------------------------------

function D3DXFindShaderComment(
  pFunction: PDWORD;
  FourCC: DWORD;
  ppData: PPointer;
  pSizeInBytes: PLongWord): HResult; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXFindShaderComment}


//----------------------------------------------------------------------------
// D3DXGetShaderSize:
// ------------------
// Returns the size of the shader byte-code, in bytes.
//
// Parameters:
//  pFunction
//      Pointer to the function DWORD stream
//----------------------------------------------------------------------------

function D3DXGetShaderSize(const pFunction: PDWORD): LongWord; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXGetShaderSize}


//----------------------------------------------------------------------------
// D3DXGetShaderVersion:
// -----------------------
// Returns the shader version of a given shader.  Returns zero if the shader
// function is NULL.
//
// Parameters:
//  pFunction
//      Pointer to the function DWORD stream
//----------------------------------------------------------------------------

function D3DXGetShaderVersion(pFunction: PDWORD): DWORD; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXGetShaderVersion}


//----------------------------------------------------------------------------
// D3DXGetShaderSemantics:
// -----------------------
// Gets semantics for all input elements referenced inside a given shader.
//
// Parameters:
//  pFunction
//      Pointer to the function DWORD stream
//  pSemantics
//      Pointer to an array of D3DXSEMANTIC structures.  The function will
//      fill this array with the semantics for each input element referenced
//      inside the shader.  This array is assumed to contain at least
//      MAXD3DDECLLENGTH elements.
//  pCount
//      Returns the number of elements referenced by the shader
//----------------------------------------------------------------------------

function D3DXGetShaderInputSemantics(
  pFunction: PDWORD;
  pSemantics: PD3DXSemantic;
  pCount: PLongWord): HResult; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXGetShaderInputSemantics}

function D3DXGetShaderOutputSemantics(
  pFunction: PDWORD;
  pSemantics: PD3DXSemantic;
  pCount: PLongWord): HResult; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXGetShaderOutputSemantics}


//----------------------------------------------------------------------------
// D3DXGetShaderSamplers:
// ----------------------
// Gets semantics for all input elements referenced inside a given shader.
//
// pFunction
//      Pointer to the function DWORD stream
// pSamplers
//      Pointer to an array of LPCSTRs.  The function will fill this array
//      with pointers to the sampler names contained within pFunction, for
//      each sampler referenced inside the shader.  This array is assumed to
//      contain at least 16 elements.
// pCount
//      Returns the number of samplers referenced by the shader
//----------------------------------------------------------------------------

function D3DXGetShaderSamplers(
  pFunction: PDWORD;
  pSamplers: PPAnsiChar;
  pCount: PLongWord): HResult; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXGetShaderSamplers}


//----------------------------------------------------------------------------
// D3DXGetShaderConstantTable:
// ---------------------------
// Gets shader constant table embedded inside shader.  A constant table is
// generated by D3DXAssembleShader and D3DXCompileShader, and is embedded in
// the body of the shader.
//
// Parameters:
//  pFunction
//      Pointer to the function DWORD stream
//  ppConstantTable
//      Returns a ID3DXConstantTable object which can be used to set
//      shader constants to the device.  Alternatively, an application can
//      parse the D3DXSHADER_CONSTANTTABLE block embedded as a comment within
//      the shader.
//----------------------------------------------------------------------------

function D3DXGetShaderConstantTable(
  pFunction: PDWORD;
  out ppConstantTable: ID3DXConstantTable): HResult; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXGetShaderConstantTable}


//----------------------------------------------------------------------------
// D3DXCreateTextureShader:
// ------------------------
// Creates a texture shader object, given the compiled shader.
//
// Parameters
//  pFunction
//      Pointer to the function DWORD stream
//  ppTextureShader
//      Returns a ID3DXTextureShader object which can be used to procedurally
//      fill the contents of a texture using the D3DXFillTextureTX functions.
//----------------------------------------------------------------------------

function D3DXCreateTextureShader(
  const pFunction: PDWORD;
  out ppTextureShader: ID3DXTextureShader): HResult; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXCreateTextureShader}


//----------------------------------------------------------------------------
// D3DXGatherFragments:
// -------------------
// Assembles shader fragments into a buffer to be passed to a fragment linker.
//   will generate shader fragments for all fragments in the file
//
// Parameters:
//  pSrcFile
//      Source file name
//  hSrcModule
//      Module handle. if NULL, current module will be used
//  pSrcResource
//      Resource name in module
//  pSrcData
//      Pointer to source code
//  SrcDataLen
//      Size of source code, in bytes
//  pDefines
//      Optional NULL-terminated array of preprocessor macro definitions.
//  pInclude
//      Optional interface pointer to use for handling #include directives.
//      If this parameter is NULL, #includes will be honored when assembling
//      from file, and will error when assembling from resource or memory.
//  Flags
//      See D3DXSHADER_xxx flags
//  ppShader
//      Returns a buffer containing the created shader fragments.  This buffer contains
//      the assembled shader code, as well as any embedded debug info.
//  ppErrorMsgs
//      Returns a buffer containing a listing of errors and warnings that were
//      encountered during assembly.  If you are running in a debugger,
//      these are the same messages you will see in your debug output.
//----------------------------------------------------------------------------


function D3DXGatherFragmentsFromFileA(
  pSrcFile: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  out ppShader: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXGatherFragmentsFromFileA';
{$EXTERNALSYM D3DXGatherFragmentsFromFileA}

function D3DXGatherFragmentsFromFileW(
  pSrcFile: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  out ppShader: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXGatherFragmentsFromFileW';
{$EXTERNALSYM D3DXGatherFragmentsFromFileW}

function D3DXGatherFragmentsFromFile(
  pSrcFile: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  out ppShader: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXGatherFragmentsFromFileA';
{$EXTERNALSYM D3DXGatherFragmentsFromFile}


function D3DXGatherFragmentsFromResourceA(
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWord;
  out ppShader: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXGatherFragmentsFromResourceA';
{$EXTERNALSYM D3DXGatherFragmentsFromResourceA}

function D3DXGatherFragmentsFromResourceW(
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWord;
  out ppShader: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXGatherFragmentsFromResourceW';
{$EXTERNALSYM D3DXGatherFragmentsFromResourceW}

function D3DXGatherFragmentsFromResource(
  hSrcModule: HModule;
  pSrcResource: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWord;
  out ppShader: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXGatherFragmentsFromResourceA';
{$EXTERNALSYM D3DXGatherFragmentsFromResource}


function D3DXGatherFragments(
  pSrcData: PAnsiChar;
  SrcDataLen: LongWord;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWord;
  out ppShader: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXGatherFragments}


//----------------------------------------------------------------------------
// D3DXCreateFragmentLinker:
// -------------------------
// Creates a fragment linker with a given cache size.  The interface returned
// can be used to link together shader fragments.  (both HLSL & ASM fragements)
//
// Parameters:
//  pDevice
//      Pointer to the device on which to create the shaders
//  ShaderCacheSize
//      Size of the shader cache
//  ppFragmentLinker
//      pointer to a memory location to put the created interface pointer
//
//----------------------------------------------------------------------------

function D3DXCreateFragmentLinker(
  pDevice: IDirect3DDevice9;
  ShaderCacheSize: LongWord;
  out ppFragmentLinker: ID3DXFragmentLinker): HResult; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXCreateFragmentLinker}


//----------------------------------------------------------------------------
// D3DXPreprocessShader:
// ---------------------
// Runs the preprocessor on the specified shader or effect, but does
// not actually compile it.  This is useful for evaluating the #includes
// and #defines in a shader and then emitting a reformatted token stream
// for debugging purposes or for generating a self-contained shader.
//
// Parameters:
//  pSrcFile
//      Source file name
//  hSrcModule
//      Module handle. if NULL, current module will be used
//  pSrcResource
//      Resource name in module
//  pSrcData
//      Pointer to source code
//  SrcDataLen
//      Size of source code, in bytes
//  pDefines
//      Optional NULL-terminated array of preprocessor macro definitions.
//  pInclude
//      Optional interface pointer to use for handling #include directives.
//      If this parameter is NULL, #includes will be honored when assembling
//      from file, and will error when assembling from resource or memory.
//  ppShaderText
//      Returns a buffer containing a single large string that represents
//      the resulting formatted token stream
//  ppErrorMsgs
//      Returns a buffer containing a listing of errors and warnings that were
//      encountered during assembly.  If you are running in a debugger,
//      these are the same messages you will see in your debug output.
//----------------------------------------------------------------------------

function D3DXPreprocessShaderFromFileA(
  pSrcFile: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  out ppShaderText: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXPreprocessShaderFromFileA';
{$EXTERNALSYM D3DXPreprocessShaderFromFileA}

function D3DXPreprocessShaderFromFileW(
  pSrcFile: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  out ppShaderText: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXPreprocessShaderFromFileW';
{$EXTERNALSYM D3DXPreprocessShaderFromFileW}

function D3DXPreprocessShaderFromFile(
  pSrcFile: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  out ppShaderText: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXPreprocessShaderFromFileA';
{$EXTERNALSYM D3DXPreprocessShaderFromFile}


function D3DXPreprocessShaderFromResourceA(
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  out ppShaderText: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXPreprocessShaderFromResourceA';
{$EXTERNALSYM D3DXPreprocessShaderFromResourceA}

function D3DXPreprocessShaderFromResourceW(
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  out ppShaderText: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXPreprocessShaderFromResourceW';
{$EXTERNALSYM D3DXPreprocessShaderFromResourceW}

function D3DXPreprocessShaderFromResource(
  hSrcModule: HModule;
  pSrcResource: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  out ppShaderText: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL name 'D3DXPreprocessShaderFromResourceA';
{$EXTERNALSYM D3DXPreprocessShaderFromResource}


function D3DXPreprocessShader(
  pSrcData: PAnsiChar;
  SrcDataSize: LongWord;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  out ppShaderText: ID3DXBuffer;
  ppErrorMsgs: PID3DXBuffer): HResult; stdcall; external d3dx9shaderDLL;
{$EXTERNALSYM D3DXPreprocessShader}


//////////////////////////////////////////////////////////////////////////////
// Shader comment block layouts //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// D3DXSHADER_CONSTANTTABLE:
// -------------------------
// Shader constant information; included as an CTAB comment block inside
// shaders.  All offsets are BYTE offsets from start of CONSTANTTABLE struct.
// Entries in the table are sorted by Name in ascending order.
//----------------------------------------------------------------------------

type
  PD3DXShaderConstantTable = ^TD3DXShaderConstantTable;
  _D3DXSHADER_CONSTANTTABLE = record
    Size: DWORD;             // sizeof(D3DXSHADER_CONSTANTTABLE)
    Creator: DWORD;          // LPCSTR offset
    Version: DWORD;          // shader version
    Constants: DWORD;        // number of constants
    ConstantInfo: DWORD;     // D3DXSHADER_CONSTANTINFO[Constants] offset
    Flags: DWORD;            // flags shader was compiled with
    Target: DWORD;           // LPCSTR offset
  end;
  {$EXTERNALSYM _D3DXSHADER_CONSTANTTABLE}
  D3DXSHADER_CONSTANTTABLE = _D3DXSHADER_CONSTANTTABLE;
  {$EXTERNALSYM D3DXSHADER_CONSTANTTABLE}
  TD3DXShaderConstantTable = _D3DXSHADER_CONSTANTTABLE;


  PD3DXShaderConstantInfo = ^TD3DXShaderConstantInfo;
  _D3DXSHADER_CONSTANTINFO = record
    Name: DWORD;             // LPCSTR offset
    RegisterSet: Word;       // D3DXREGISTER_SET
    RegisterIndex: Word;     // register number
    RegisterCount: Word;     // number of registers
    Reserved: Word;          // reserved
    TypeInfo: DWORD;         // D3DXSHADER_TYPEINFO offset
    DefaultValue: DWORD;     // offset of default value
  end;
  {$EXTERNALSYM _D3DXSHADER_CONSTANTINFO}
  D3DXSHADER_CONSTANTINFO = _D3DXSHADER_CONSTANTINFO;
  {$EXTERNALSYM D3DXSHADER_CONSTANTINFO}
  TD3DXShaderConstantInfo = _D3DXSHADER_CONSTANTINFO;


  PD3DXShaderTypeInfo = ^TD3DXShaderTypeInfo;
  _D3DXSHADER_TYPEINFO = record
    _Class: Word;            // D3DXPARAMETER_CLASS
    _Type: Word;             // D3DXPARAMETER_TYPE
    Rows: Word;              // number of rows (matrices)
    Columns: Word;           // number of columns (vectors and matrices)
    Elements: Word;          // array dimension
    StructMembers: Word;     // number of struct members
    StructMemberInfo: DWORD; // D3DXSHADER_STRUCTMEMBERINFO[Members] offset
  end;
  {$EXTERNALSYM _D3DXSHADER_TYPEINFO}
  D3DXSHADER_TYPEINFO = _D3DXSHADER_TYPEINFO;
  {$EXTERNALSYM D3DXSHADER_TYPEINFO}
  TD3DXShaderTypeInfo = _D3DXSHADER_TYPEINFO;


  PD3DXShaderStructMemberInfo = ^TD3DXShaderStructMemberInfo;
  _D3DXSHADER_STRUCTMEMBERINFO = record
    Name: DWORD;             // LPCSTR offset
    TypeInfo: DWORD;         // D3DXSHADER_TYPEINFO offset
  end;
  {$EXTERNALSYM _D3DXSHADER_STRUCTMEMBERINFO}
  D3DXSHADER_STRUCTMEMBERINFO = _D3DXSHADER_STRUCTMEMBERINFO;
  {$EXTERNALSYM D3DXSHADER_STRUCTMEMBERINFO}
  TD3DXShaderStructMemberInfo = _D3DXSHADER_STRUCTMEMBERINFO;






//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//
//  File:       d3dx9effect.h
//  Content:    D3DX effect types and Shaders
//
//////////////////////////////////////////////////////////////////////////////


//----------------------------------------------------------------------------
// D3DXFX_DONOTSAVESTATE
//   This flag is used as a parameter to ID3DXEffect::Begin().  When this flag
//   is specified, device state is not saved or restored in Begin/End.
// D3DXFX_DONOTSAVESHADERSTATE
//   This flag is used as a parameter to ID3DXEffect::Begin().  When this flag
//   is specified, shader device state is not saved or restored in Begin/End.
//   This includes pixel/vertex shaders and shader constants
// D3DXFX_DONOTSAVESAMPLERSTATE
//   This flag is used as a parameter to ID3DXEffect::Begin(). When this flag
//   is specified, sampler device state is not saved or restored in Begin/End.
// D3DXFX_NOT_CLONEABLE
//   This flag is used as a parameter to the D3DXCreateEffect family of APIs.
//   When this flag is specified, the effect will be non-cloneable and will not
//   contain any shader binary data.
//   Furthermore, GetPassDesc will not return shader function pointers. 
//   Setting this flag reduces effect memory usage by about 50%.
//----------------------------------------------------------------------------
const
  D3DXFX_DONOTSAVESTATE         = (1 shl 0);
  {$EXTERNALSYM D3DXFX_DONOTSAVESTATE}
  D3DXFX_DONOTSAVESHADERSTATE   = (1 shl 1);
  {$EXTERNALSYM D3DXFX_DONOTSAVESHADERSTATE}
  D3DXFX_DONOTSAVESAMPLERSTATE  = (1 shl 2);
  {$EXTERNALSYM D3DXFX_DONOTSAVESAMPLERSTATE}
  D3DXFX_NOT_CLONEABLE          = (1 shl 11);
  {$EXTERNALSYM D3DXFX_NOT_CLONEABLE}


//----------------------------------------------------------------------------
// D3DX_PARAMETER_SHARED
//   Indicates that the value of a parameter will be shared with all effects
//   which share the same namespace.  Changing the value in one effect will
//   change it in all.
//
// D3DX_PARAMETER_LITERAL
//   Indicates that the value of this parameter can be treated as literal.
//   Literal parameters can be marked when the effect is compiled, and their
//   cannot be changed after the effect is compiled.  Shared parameters cannot
//   be literal.
//----------------------------------------------------------------------------
const
  D3DX_PARAMETER_SHARED       = (1 shl 0);
  {$EXTERNALSYM D3DX_PARAMETER_SHARED}
  D3DX_PARAMETER_LITERAL      = (1 shl 1);
  {$EXTERNALSYM D3DX_PARAMETER_LITERAL}
  D3DX_PARAMETER_ANNOTATION   = (1 shl 2);
  {$EXTERNALSYM D3DX_PARAMETER_ANNOTATION}


//----------------------------------------------------------------------------
// D3DXEFFECT_DESC:
//----------------------------------------------------------------------------

type
  _D3DXEFFECT_DESC = record
    Creator: PAnsiChar;                 // Creator string
    Parameters: LongWord;               // Number of parameters
    Techniques: LongWord;               // Number of techniques
    Functions: LongWord;                // Number of function entrypoints
  end;
  {$EXTERNALSYM _D3DXEFFECT_DESC}
  D3DXEFFECT_DESC = _D3DXEFFECT_DESC;
  {$EXTERNALSYM D3DXEFFECT_DESC}
  TD3DXEffectDesc = _D3DXEFFECT_DESC;


//----------------------------------------------------------------------------
// D3DXPARAMETER_DESC:
//----------------------------------------------------------------------------

  PD3DXParameterDesc = ^TD3DXParameterDesc;
  _D3DXPARAMETER_DESC = record
    Name: PAnsiChar;                    // Parameter name
    Semantic: PAnsiChar;                // Parameter semantic
    _Class: TD3DXParameterClass;        // Class
    _Type: TD3DXParameterType;          // Component type
    Rows: LongWord;                     // Number of rows
    Columns: LongWord;                  // Number of columns
    Elements: LongWord;                 // Number of array elements
    Annotations: LongWord;              // Number of annotations
    StructMembers: LongWord;            // Number of structure member sub-parameters
    Flags: DWORD;                       // D3DX_PARAMETER_* flags
    Bytes: LongWord;                    // Parameter size, in bytes
  end;
  {$EXTERNALSYM _D3DXPARAMETER_DESC}
  D3DXPARAMETER_DESC = _D3DXPARAMETER_DESC;
  {$EXTERNALSYM D3DXPARAMETER_DESC}
  TD3DXParameterDesc = _D3DXPARAMETER_DESC;


//----------------------------------------------------------------------------
// D3DXTECHNIQUE_DESC:
//----------------------------------------------------------------------------

  PD3DXTechniqueDesc = ^TD3DXTechniqueDesc;
  _D3DXTECHNIQUE_DESC = record
    Name: PAnsiChar;                    // Technique name
    Passes: LongWord;                   // Number of passes
    Annotations: LongWord;              // Number of annotations
  end;
  {$EXTERNALSYM _D3DXTECHNIQUE_DESC}
  D3DXTECHNIQUE_DESC = _D3DXTECHNIQUE_DESC;
  {$EXTERNALSYM D3DXTECHNIQUE_DESC}
  TD3DXTechniqueDesc = _D3DXTECHNIQUE_DESC;


//----------------------------------------------------------------------------
// D3DXPASS_DESC:
//----------------------------------------------------------------------------

  PD3DXPassDesc = ^TD3DXPassDesc;
  _D3DXPASS_DESC = record
    Name: PAnsiChar;                    // Pass name
    Annotations: LongWord;              // Number of annotations

    pVertexShaderFunction: PDWORD;      // Vertex shader function
    pPixelShaderFunction: PDWORD;       // Pixel shader function
  end;
  {$EXTERNALSYM _D3DXPASS_DESC}
  D3DXPASS_DESC = _D3DXPASS_DESC;
  {$EXTERNALSYM D3DXPASS_DESC}
  TD3DXPassDesc = _D3DXPASS_DESC;


//----------------------------------------------------------------------------
// D3DXFUNCTION_DESC:
//----------------------------------------------------------------------------

  PD3DXFunctionDesc = ^TD3DXFunctionDesc;
  _D3DXFUNCTION_DESC = record
    Name: PAnsiChar;                    // Function name
    Annotations: LongWord;              // Number of annotations
  end;
  {$EXTERNALSYM _D3DXFUNCTION_DESC}
  D3DXFUNCTION_DESC = _D3DXFUNCTION_DESC;
  {$EXTERNALSYM D3DXFUNCTION_DESC}
  TD3DXFunctionDesc = _D3DXFUNCTION_DESC;



//////////////////////////////////////////////////////////////////////////////
// ID3DXEffectPool ///////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXEffectPool);'}
  {$EXTERNALSYM ID3DXEffectPool}
  ID3DXEffectPool = interface(IUnknown)
    ['{9537AB04-3250-412e-8213-FCD2F8677933}']
    // No public methods
  end;

  IID_ID3DXEffectPool = ID3DXEffectPool;
  {$EXTERNALSYM IID_ID3DXEffectPool}


//////////////////////////////////////////////////////////////////////////////
// ID3DXBaseEffect ///////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXBaseEffect);'}
  {$EXTERNALSYM ID3DXBaseEffect}
  ID3DXBaseEffect = interface(IUnknown)
    ['{017C18AC-103F-4417-8C51-6BF6EF1E56BE}']
    // Descs
    function GetDesc(out pDesc: TD3DXEffectDesc): HResult; stdcall;
    function GetParameterDesc(hParameter: TD3DXHandle; out pDesc: TD3DXParameterDesc): HResult; stdcall;

    function GetTechniqueDesc(hTechnique: TD3DXHandle; out pDesc: TD3DXTechniqueDesc): HResult; stdcall;
    function GetPassDesc(hPass: TD3DXHandle; out pDesc: TD3DXPassDesc): HResult; stdcall;
    function GetFunctionDesc(hShader: TD3DXHandle; out pDesc: TD3DXFunctionDesc): HResult; stdcall;

    // Handle operations
    function GetParameter(hParameter: TD3DXHandle; Index: LongWord): TD3DXHandle; stdcall;
    function GetParameterByName(hParameter: TD3DXHandle; pName: PAnsiChar): TD3DXHandle; stdcall;
    function GetParameterBySemantic(hParameter: TD3DXHandle; pSemantic: PAnsiChar): TD3DXHandle; stdcall;
    function GetParameterElement(hParameter: TD3DXHandle; Index: LongWord): TD3DXHandle; stdcall;
    function GetTechnique(Index: LongWord): TD3DXHandle; stdcall;
    function GetTechniqueByName(pName: PAnsiChar): TD3DXHandle; stdcall;
    function GetPass(hTechnique: TD3DXHandle; Index: LongWord): TD3DXHandle; stdcall;
    function GetPassByName(hTechnique: TD3DXHandle; pName: PAnsiChar): TD3DXHandle; stdcall;
    function GetFunction(Index: LongWord): TD3DXHandle; stdcall;
    function GetFunctionByName(pName: PAnsiChar): TD3DXHandle; stdcall;
    function GetAnnotation(hObject: TD3DXHandle; Index: LongWord): TD3DXHandle; stdcall;
    function GetAnnotationByName(hObject: TD3DXHandle; pName: PAnsiChar): TD3DXHandle; stdcall;

    // Get/Set Parameters
    function SetValue(hParameter: TD3DXHandle; pData: Pointer; Bytes: LongWord): HResult; stdcall;
    function GetValue(hParameter: TD3DXHandle; pData: Pointer; Bytes: LongWord): HResult; stdcall;
    function SetBool(hParameter: TD3DXHandle; b: BOOL): HResult; stdcall;
    function GetBool(hParameter: TD3DXHandle; out pb: BOOL): HResult; stdcall;
    function SetBoolArray(hParameter: TD3DXHandle; pb: PBOOL; Count: LongWord): HResult; stdcall;
    function GetBoolArray(hParameter: TD3DXHandle; pb: PBOOL; Count: LongWord): HResult; stdcall;
    function SetInt(hParameter: TD3DXHandle; n: Integer): HResult; stdcall;
    function GetInt(hParameter: TD3DXHandle; out pn: Integer): HResult; stdcall;
    function SetIntArray(hParameter: TD3DXHandle; pn: PInteger; Count: LongWord): HResult; stdcall;
    function GetIntArray(hParameter: TD3DXHandle; pn: PInteger; Count: LongWord): HResult; stdcall;
    function SetFloat(hParameter: TD3DXHandle; f: Single): HResult; stdcall;
    function GetFloat(hParameter: TD3DXHandle; out pf: Single): HResult; stdcall;
    function SetFloatArray(hParameter: TD3DXHandle; pf: PSingle; Count: LongWord): HResult; stdcall;
    function GetFloatArray(hParameter: TD3DXHandle; pf: PSingle; Count: LongWord): HResult; stdcall;
    function SetVector(hParameter: TD3DXHandle; const pVector: TD3DXVector4): HResult; stdcall;
    function GetVector(hParameter: TD3DXHandle; out pVector: TD3DXVector4): HResult; stdcall;
    function SetVectorArray(hParameter: TD3DXHandle; pVector: PD3DXVector4; Count: LongWord): HResult; stdcall;
    function GetVectorArray(hParameter: TD3DXHandle; pVector: PD3DXVector4; Count: LongWord): HResult; stdcall;
    function SetMatrix(hParameter: TD3DXHandle; const pMatrix: TD3DXMatrix): HResult; stdcall;
    function GetMatrix(hParameter: TD3DXHandle; out pMatrix: TD3DXMatrix): HResult; stdcall;
    function SetMatrixArray(hParameter: TD3DXHandle; pMatrix: PD3DXMatrix; Count: LongWord): HResult; stdcall;
    function GetMatrixArray(hParameter: TD3DXHandle; pMatrix: PD3DXMatrix; Count: LongWord): HResult; stdcall;
    function SetMatrixPointerArray(hParameter: TD3DXHandle; ppMatrix: PPD3DXMatrix; Count: LongWord): HResult; stdcall;
    function GetMatrixPointerArray(hParameter: TD3DXHandle; ppMatrix: PPD3DXMatrix; Count: LongWord): HResult; stdcall;
    function SetMatrixTranspose(hParameter: TD3DXHandle; const pMatrix: TD3DXMatrix): HResult; stdcall;
    function GetMatrixTranspose(hParameter: TD3DXHandle; out pMatrix: TD3DXMatrix): HResult; stdcall;
    function SetMatrixTransposeArray(hParameter: TD3DXHandle; pMatrix: PD3DXMatrix; Count: LongWord): HResult; stdcall;
    function GetMatrixTransposeArray(hParameter: TD3DXHandle; pMatrix: PD3DXMatrix; Count: LongWord): HResult; stdcall;
    function SetMatrixTransposePointerArray(hParameter: TD3DXHandle; ppMatrix: PPD3DXMatrix; Count: LongWord): HResult; stdcall;
    function GetMatrixTransposePointerArray(hParameter: TD3DXHandle; ppMatrix: PPD3DXMatrix; Count: LongWord): HResult; stdcall;
    function SetString(hParameter: TD3DXHandle; pString: PAnsiChar): HResult; stdcall;
    function GetString(hParameter: TD3DXHandle; out ppString: PAnsiChar): HResult; stdcall;
    function SetTexture(hParameter: TD3DXHandle; pTexture: IDirect3DBaseTexture9): HResult; stdcall;
    function GetTexture(hParameter: TD3DXHandle; out ppTexture: IDirect3DBaseTexture9): HResult; stdcall;
    function GetPixelShader(hParameter: TD3DXHandle; out ppPShader: IDirect3DPixelShader9): HResult; stdcall;
    function GetVertexShader(hParameter: TD3DXHandle; out ppVShader: IDirect3DVertexShader9): HResult; stdcall;

    //Set Range of an Array to pass to device
    //Useful for sending only a subrange of an array down to the device
    function SetArrayRange(hParameter: TD3DXHandle; uStart, uEnd: LongWord): HResult; stdcall; 
  end;


//----------------------------------------------------------------------------
// ID3DXEffectStateManager:
// ------------------------
// This is a user implemented interface that can be used to manage device
// state changes made by an Effect.
//----------------------------------------------------------------------------

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXEffectStateManager);'}
  {$EXTERNALSYM ID3DXEffectStateManager}
  ID3DXEffectStateManager = interface(IUnknown)
    ['{79AAB587-6DBC-4fa7-82DE-37FA1781C5CE}']

    // The following methods are called by the Effect when it wants to make
    // the corresponding device call.  Note that:
    // 1. Users manage the state and are therefore responsible for making the
    //    the corresponding device calls themselves inside their callbacks.
    // 2. Effects pay attention to the return values of the callbacks, and so
    //    users must pay attention to what they return in their callbacks.

    function SetTransform(State: TD3DTransformStateType; const pMatrix: TD3DMatrix): HResult; stdcall;
    function SetMaterial(const pMaterial: TD3DMaterial9): HResult; stdcall;
    function SetLight(Index: DWORD; const pLight: TD3DLight9): HResult; stdcall;
    function LightEnable(Index: DWORD; Enable: BOOL): HResult; stdcall;
    function SetRenderState(State: TD3DRenderStateType; Value: DWORD): HResult; stdcall;
    function SetTexture(Stage: DWORD; pTexture: IDirect3DBaseTexture9): HResult; stdcall;
    function SetTextureStageState(Stage: DWORD; _Type: TD3DTextureStageStateType; Value: DWORD): HResult; stdcall;
    function SetSamplerState(Sampler: DWORD; _Type: TD3DSamplerStateType; Value: DWORD): HResult; stdcall;
    function SetNPatchMode(nSegments: Single): HResult; stdcall;
    function SetFVF(FVF: DWORD): HResult; stdcall;
    function SetVertexShader(pShader: IDirect3DVertexShader9): HResult; stdcall;
    function SetVertexShaderConstantF(StartRegister: LongWord; pConstantData: PSingle; Vector4fCount: LongWord): HResult; stdcall;
    function SetVertexShaderConstantI(StartRegister: LongWord; pConstantData: PInteger; Vector4iCount: LongWord): HResult; stdcall;
    function SetVertexShaderConstantB(StartRegister: LongWord; pConstantData: PBOOL; BoolCount: LongWord): HResult; stdcall;
    function SetPixelShader(pShader: IDirect3DPixelShader9): HResult; stdcall;
    function SetPixelShaderConstantF(StartRegister: LongWord; pConstantData: PSingle; Vector4fCount: LongWord): HResult; stdcall;
    function SetPixelShaderConstantI(StartRegister: LongWord; pConstantData: PInteger; Vector4iCount: LongWord): HResult; stdcall;
    function SetPixelShaderConstantB(StartRegister: LongWord; pConstantData: PBOOL; BoolCount: LongWord): HResult; stdcall;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3DXEffect ///////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXEffect);'}
  {$EXTERNALSYM ID3DXEffect}
  ID3DXEffect = interface(ID3DXBaseEffect)
    ['{F6CEB4B3-4E4C-40dd-B883-8D8DE5EA0CD5}']
    // Pool
    function GetPool(out ppPool: ID3DXEffectPool): HResult; stdcall;

    // Selecting and setting a technique
    function SetTechnique(hTechnique: TD3DXHandle): HResult; stdcall;
    function GetCurrentTechnique: TD3DXHandle; stdcall;
    function ValidateTechnique(hTechnique: TD3DXHandle): HResult; stdcall;
    function FindNextValidTechnique(hTechnique: TD3DXHandle; out pTechnique: TD3DXHandle): HResult; stdcall;
    function IsParameterUsed(hParameter: TD3DXHandle; hTechnique: TD3DXHandle): BOOL; stdcall;

    // Using current technique
    // Begin           starts active technique
    // BeginPass       begins a pass
    // CommitChanges   updates changes to any set calls in the pass. This should be called before
    //                 any DrawPrimitive call to d3d
    // EndPass         ends a pass
    // End             ends active technique
    function _Begin(pPasses: PLongWord; Flags: DWORD): HResult; stdcall;
    function BeginPass(Pass: LongWord): HResult; stdcall;
    function CommitChanges: HResult; stdcall;
    function EndPass: HResult; stdcall;
    function _End: HResult; stdcall;

    // Managing D3D Device
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function OnLostDevice: HResult; stdcall;
    function OnResetDevice: HResult; stdcall;

    // Logging device calls
    function SetStateManager(pManager: ID3DXEffectStateManager): HResult; stdcall;
    function GetStateManager(out ppManager: ID3DXEffectStateManager): HResult; stdcall;

    // Parameter blocks
    function BeginParameterBlock: HResult; stdcall;
    function EndParameterBlock: TD3DXHandle; stdcall;
    function ApplyParameterBlock(hParameterBlock: TD3DXHandle): HResult; stdcall;
    function DeleteParameterBlock(hParameterBlock: TD3DXHandle): HResult; stdcall;

    // Cloning
    function CloneEffect(pDevice: IDirect3DDevice9; out ppEffect: ID3DXEffect): HResult; stdcall;

    // Fast path for setting variables directly in ID3DXEffect
    function SetRawValue(hParameter: TD3DXHandle; pData: Pointer; ByteOffset, Bytes: LongWord): HResult; stdcall;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3DXEffectCompiler ///////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXEffectCompiler);'}
  {$EXTERNALSYM ID3DXEffectCompiler}
  ID3DXEffectCompiler = interface(ID3DXBaseEffect)
    ['{51B8A949-1A31-47e6-BEA0-4B30DB53F1E0}']
    // Parameter sharing, specialization, and information
    function SetLiteral(hParameter: TD3DXHandle; Literal: BOOL): HResult; stdcall;
    function GetLiteral(hParameter: TD3DXHandle; out pLiteral: BOOL): HResult; stdcall;

    // Compilation
    function CompileEffect(Flags: DWORD; ppEffect, ppErrorMsgs: PID3DXBuffer): HResult; stdcall;

    function CompileShader(hFunction: TD3DXHandle; pTarget: PAnsiChar; Flags: DWORD;
      ppShader, ppErrorMsgs: PID3DXBuffer; ppConstantTable: PID3DXConstantTable): HResult; stdcall;
  end;

type
  IID_ID3DXBaseEffect = ID3DXBaseEffect;
  {$EXTERNALSYM IID_ID3DXBaseEffect}
  IID_ID3DXEffectStateManager = ID3DXEffectStateManager;
  {$EXTERNALSYM IID_ID3DXEffectStateManager}
  IID_ID3DXEffect = ID3DXEffect;
  {$EXTERNALSYM IID_ID3DXEffect}
  IID_ID3DXEffectCompiler = ID3DXEffectCompiler;
  {$EXTERNALSYM IID_ID3DXEffectCompiler}

//////////////////////////////////////////////////////////////////////////////
// APIs //////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////


//----------------------------------------------------------------------------
// D3DXCreateEffectPool:
// ---------------------
// Creates an effect pool.  Pools are used for sharing parameters between
// multiple effects.  For all effects within a pool, shared parameters of the
// same name all share the same value.
//
// Parameters:
//  ppPool
//      Returns the created pool.
//----------------------------------------------------------------------------

function D3DXCreateEffectPool(
  out ppPool: ID3DXEffectPool): HResult; stdcall; external d3dx9effectDLL;
{$EXTERNALSYM D3DXCreateEffectPool}


//----------------------------------------------------------------------------
// D3DXCreateEffect:
// -----------------
// Creates an effect from an ascii or binary effect description.
//
// Parameters:
//  pDevice
//      Pointer of the device on which to create the effect
//  pSrcFile
//      Name of the file containing the effect description
//  hSrcModule
//      Module handle. if NULL, current module will be used.
//  pSrcResource
//      Resource name in module
//  pSrcData
//      Pointer to effect description
//  SrcDataSize
//      Size of the effect description in bytes
//  pDefines
//      Optional NULL-terminated array of preprocessor macro definitions.
//  Flags
//      See D3DXSHADER_xxx flags.
//  pSkipConstants
//      A list of semi-colon delimited variable names.  The effect will
//      not set these variables to the device when they are referenced
//      by a shader.  NOTE: the variables specified here must be
//      register bound in the file and must not be used in expressions
//      in passes or samplers or the file will not load.
//  pInclude
//      Optional interface pointer to use for handling #include directives.
//      If this parameter is NULL, #includes will be honored when compiling
//      from file, and will error when compiling from resource or memory.
//  pPool
//      Pointer to ID3DXEffectPool object to use for shared parameters.
//      If NULL, no parameters will be shared.
//  ppEffect
//      Returns a buffer containing created effect.
//  ppCompilationErrors
//      Returns a buffer containing any error messages which occurred during
//      compile.  Or NULL if you do not care about the error messages.
//
//----------------------------------------------------------------------------

function D3DXCreateEffectFromFileA(
  pDevice: IDirect3DDevice9;
  pSrcFile: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectFromFileA';
{$EXTERNALSYM D3DXCreateEffectFromFileA}

function D3DXCreateEffectFromFileW(
  pDevice: IDirect3DDevice9;
  pSrcFile: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectFromFileW';
{$EXTERNALSYM D3DXCreateEffectFromFileW}

function D3DXCreateEffectFromFile(
  pDevice: IDirect3DDevice9;
  pSrcFile: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectFromFileA';
{$EXTERNALSYM D3DXCreateEffectFromFile}


function D3DXCreateEffectFromResourceA(
  pDevice: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectFromResourceA';
{$EXTERNALSYM D3DXCreateEffectFromResourceA}

function D3DXCreateEffectFromResourceW(
  pDevice: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectFromResourceW';
{$EXTERNALSYM D3DXCreateEffectFromResourceW}

function D3DXCreateEffectFromResource(
  pDevice: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectFromResourceA';
{$EXTERNALSYM D3DXCreateEffectFromResource}


function D3DXCreateEffect(
  pDevice: IDirect3DDevice9;
  pSrcData: Pointer;
  SrcDataLen: LongWord;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL;
{$EXTERNALSYM D3DXCreateEffect}


//
// Ex functions that accept pSkipConstants in addition to other parameters
//

function D3DXCreateEffectFromFileExA(
  pDevice: IDirect3DDevice9;
  pSrcFile: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pSkipConstants: PAnsiChar;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectFromFileExA';
{$EXTERNALSYM D3DXCreateEffectFromFileExA}

function D3DXCreateEffectFromFileExW(
  pDevice: IDirect3DDevice9;
  pSrcFile: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pSkipConstants: PAnsiChar;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectFromFileExW';
{$EXTERNALSYM D3DXCreateEffectFromFileExW}

function D3DXCreateEffectFromFileEx(
  pDevice: IDirect3DDevice9;
  pSrcFile: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pSkipConstants: PAnsiChar;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectFromFileExA';
{$EXTERNALSYM D3DXCreateEffectFromFileEx}


function D3DXCreateEffectFromResourceExA(
  pDevice: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pSkipConstants: PAnsiChar;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectFromResourceExA';
{$EXTERNALSYM D3DXCreateEffectFromResourceExA}

function D3DXCreateEffectFromResourceExW(
  pDevice: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pSkipConstants: PAnsiChar;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectFromResourceExW';
{$EXTERNALSYM D3DXCreateEffectFromResourceExW}

function D3DXCreateEffectFromResourceEx(
  pDevice: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pSkipConstants: PAnsiChar;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectFromResourceExA';
{$EXTERNALSYM D3DXCreateEffectFromResourceEx}


function D3DXCreateEffectEx(
  pDevice: IDirect3DDevice9;
  pSrcData: Pointer;
  SrcDataLen: LongWord;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  pSkipConstants: PAnsiChar;
  Flags: DWORD;
  pPool: ID3DXEffectPool;
  out ppEffect: ID3DXEffect;
  ppCompilationErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL;
{$EXTERNALSYM D3DXCreateEffectEx}



//----------------------------------------------------------------------------
// D3DXCreateEffectCompiler:
// -------------------------
// Creates an effect from an ascii or binary effect description.
//
// Parameters:
//  pSrcFile
//      Name of the file containing the effect description
//  hSrcModule
//      Module handle. if NULL, current module will be used.
//  pSrcResource
//      Resource name in module
//  pSrcData
//      Pointer to effect description
//  SrcDataSize
//      Size of the effect description in bytes
//  pDefines
//      Optional NULL-terminated array of preprocessor macro definitions.
//  pInclude
//      Optional interface pointer to use for handling #include directives.
//      If this parameter is NULL, #includes will be honored when compiling
//      from file, and will error when compiling from resource or memory.
//  pPool
//      Pointer to ID3DXEffectPool object to use for shared parameters.
//      If NULL, no parameters will be shared.
//  ppCompiler
//      Returns a buffer containing created effect compiler.
//  ppParseErrors
//      Returns a buffer containing any error messages which occurred during
//      parse.  Or NULL if you do not care about the error messages.
//
//----------------------------------------------------------------------------

function D3DXCreateEffectCompilerFromFileA(
  pSrcFile: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  out ppCompiler: ID3DXEffectCompiler;
  ppParseErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectCompilerFromFileA';
{$EXTERNALSYM D3DXCreateEffectCompilerFromFileA}

function D3DXCreateEffectCompilerFromFileW(
  pSrcFile: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  out ppCompiler: ID3DXEffectCompiler;
  ppParseErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectCompilerFromFileW';
{$EXTERNALSYM D3DXCreateEffectCompilerFromFileW}

function D3DXCreateEffectCompilerFromFile(
  pSrcFile: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  out ppCompiler: ID3DXEffectCompiler;
  ppParseErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectCompilerFromFileA';
{$EXTERNALSYM D3DXCreateEffectCompilerFromFile}


function D3DXCreateEffectCompilerFromResourceA(
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  out ppCompiler: ID3DXEffectCompiler;
  ppParseErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectCompilerFromResourceA';
{$EXTERNALSYM D3DXCreateEffectCompilerFromResourceA}

function D3DXCreateEffectCompilerFromResourceW(
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  out ppCompiler: ID3DXEffectCompiler;
  ppParseErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectCompilerFromResourceW';
{$EXTERNALSYM D3DXCreateEffectCompilerFromResourceW}

function D3DXCreateEffectCompilerFromResource(
  hSrcModule: HModule;
  pSrcResource: PChar;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  out ppCompiler: ID3DXEffectCompiler;
  ppParseErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL name 'D3DXCreateEffectCompilerFromResourceA';
{$EXTERNALSYM D3DXCreateEffectCompilerFromResource}


function D3DXCreateEffectCompiler(
  pSrcData: Pointer;
  SrcDataLen: LongWord;
  pDefines: PD3DXMacro;
  pInclude: ID3DXInclude;
  Flags: DWORD;
  out ppCompiler: ID3DXEffectCompiler;
  ppParseErrors: PID3DXBuffer): HResult; stdcall; external d3dx9effectDLL;
{$EXTERNALSYM D3DXCreateEffectCompiler}


//----------------------------------------------------------------------------
// D3DXDisassembleEffect:
// -----------------------
//
// Parameters:
//----------------------------------------------------------------------------

function D3DXDisassembleEffect(
  pEffect: ID3DXEffect;
  EnableColorCode: BOOL;
  out ppDisassembly: ID3DXBuffer): HResult; stdcall; external d3dx9effectDLL;
{$EXTERNALSYM D3DXDisassembleEffect}





///////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9xof.h
//  Content:    D3DX .X File types and functions
//
///////////////////////////////////////////////////////////////////////////

//#include "d3dx9.h"


//----------------------------------------------------------------------------
// D3DXF_FILEFORMAT
//   This flag is used to specify what file type to use when saving to disk.
//   _BINARY, _BINARY, and _TEXT are mutually exclusive, while
//   _COMPRESSED is an optional setting that works with all file types.
//----------------------------------------------------------------------------
type
  D3DXF_FILEFORMAT = DWORD;
  {$EXTERNALSYM D3DXF_FILEFORMAT}
  TD3DXFFileFormat = D3DXF_FILEFORMAT;

const
  D3DXF_FILEFORMAT_BINARY     = 0;
  {$EXTERNALSYM D3DXF_FILEFORMAT_BINARY}
  D3DXF_FILEFORMAT_TEXT       = 1;
  {$EXTERNALSYM D3DXF_FILEFORMAT_TEXT}
  D3DXF_FILEFORMAT_COMPRESSED = 2;
  {$EXTERNALSYM D3DXF_FILEFORMAT_COMPRESSED}

  //----------------------------------------------------------------------------
  // D3DXF_FILESAVEOPTIONS
  //   This flag is used to specify where to save the file to. Each flag is
  //   mutually exclusive, indicates the data location of the file, and also
  //   chooses which additional data will specify the location.
  //   _TOFILE is paired with a filename (LPCSTR)
  //   _TOWFILE is paired with a filename (LPWSTR)
  //----------------------------------------------------------------------------
type
  D3DXF_FILESAVEOPTIONS = DWORD;
  {$EXTERNALSYM D3DXF_FILESAVEOPTIONS}
  TD3DXFFileSaveOptions = D3DXF_FILESAVEOPTIONS;

const  
  D3DXF_FILESAVE_TOFILE     = $00;
  {$EXTERNALSYM D3DXF_FILESAVE_TOFILE}
  D3DXF_FILESAVE_TOWFILE    = $01;
  {$EXTERNALSYM D3DXF_FILESAVE_TOWFILE}

//----------------------------------------------------------------------------
// D3DXF_FILELOADOPTIONS
//   This flag is used to specify where to load the file from. Each flag is
//   mutually exclusive, indicates the data location of the file, and also
//   chooses which additional data will specify the location.
//   _FROMFILE is paired with a filename (LPCSTR)
//   _FROMWFILE is paired with a filename (LPWSTR)
//   _FROMRESOURCE is paired with a (D3DXF_FILELOADRESOUCE*) description.
//   _FROMMEMORY is paired with a (D3DXF_FILELOADMEMORY*) description.
//----------------------------------------------------------------------------
type
  D3DXF_FILELOADOPTIONS = DWORD;
  {$EXTERNALSYM D3DXF_FILELOADOPTIONS}
  TD3DXFFileLoadOptions = D3DXF_FILELOADOPTIONS;

const
  D3DXF_FILELOAD_FROMFILE     = $00;
  {$EXTERNALSYM D3DXF_FILELOAD_FROMFILE}
  D3DXF_FILELOAD_FROMWFILE    = $01;
  {$EXTERNALSYM D3DXF_FILELOAD_FROMWFILE}
  D3DXF_FILELOAD_FROMRESOURCE = $02;
  {$EXTERNALSYM D3DXF_FILELOAD_FROMRESOURCE}
  D3DXF_FILELOAD_FROMMEMORY   = $03;
  {$EXTERNALSYM D3DXF_FILELOAD_FROMMEMORY}

//----------------------------------------------------------------------------
// D3DXF_FILELOADRESOURCE:
//----------------------------------------------------------------------------
type
  PD3DXFFileLoadResource = ^TD3DXFFileLoadResource;
  _D3DXF_FILELOADRESOURCE = record
    hModule: HMODULE; // Desc
    lpName: PAnsiChar;  // Desc
    lpType: PAnsiChar;  // Desc
  end;
  {$EXTERNALSYM _D3DXF_FILELOADRESOURCE}
  D3DXF_FILELOADRESOURCE = _D3DXF_FILELOADRESOURCE;
  {$EXTERNALSYM D3DXF_FILELOADRESOURCE}
  TD3DXFFileLoadResource = _D3DXF_FILELOADRESOURCE;

//----------------------------------------------------------------------------
// D3DXF_FILELOADMEMORY:
//----------------------------------------------------------------------------

  PD3DXFFileLoadMemory = ^TD3DXFFileLoadMemory;
  _D3DXF_FILELOADMEMORY = record
    lpMemory: Pointer; // Desc
    dSize: SIZE_T;     // Desc
  end;
  {$EXTERNALSYM _D3DXF_FILELOADMEMORY}
  D3DXF_FILELOADMEMORY = _D3DXF_FILELOADMEMORY;
  {$EXTERNALSYM D3DXF_FILELOADMEMORY}
  TD3DXFFileLoadMemory = _D3DXF_FILELOADMEMORY;


const  
  IID_ID3DXFile: TGUID = '{cef08cf9-7b4f-4429-9624-2a690a933201}';
  {$EXTERNALSYM IID_ID3DXFile}
  IID_ID3DXFileSaveObject: TGUID = '{cef08cfa-7b4f-4429-9624-2a690a933201}';
  {$EXTERNALSYM IID_ID3DXFileSaveObject}
  IID_ID3DXFileSaveData: TGUID = '{cef08cfb-7b4f-4429-9624-2a690a933201}';
  {$EXTERNALSYM IID_ID3DXFileSaveData}
  IID_ID3DXFileEnumObject: TGUID = '{cef08cfc-7b4f-4429-9624-2a690a933201}';
  {$EXTERNALSYM IID_ID3DXFileEnumObject}
  IID_ID3DXFileData: TGUID = '{cef08cfd-7b4f-4429-9624-2a690a933201}';
  {$EXTERNALSYM IID_ID3DXFileData}


type
  ID3DXFileEnumObject = interface;
  ID3DXFileSaveObject = interface;
  ID3DXFileSaveData = interface;
  ID3DXFileData = interface;

  //////////////////////////////////////////////////////////////////////////////
  // ID3DXFile /////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXFile);'}
  {$EXTERNALSYM ID3DXFile}
  ID3DXFile = interface(IUnknown)
    ['{cef08cf9-7b4f-4429-9624-2a690a933201}']
    function CreateEnumObject(pvSource: Pointer; flags: TD3DXFFileLoadOptions; out EnumObj: ID3DXFileEnumObject): HResult; stdcall;
    function CreateSaveObject(pvSource: Pointer; flags: TD3DXFFileSaveOptions; Format: TD3DXFFileFormat; out SaveObj: ID3DXFileSaveObject): HResult; stdcall;
    function RegisterTemplates(pvData: Pointer; Size: SIZE_T): HResult; stdcall;
    function RegisterEnumTemplates(pEnum: ID3DXFileEnumObject): HResult; stdcall;
  end;

  //////////////////////////////////////////////////////////////////////////////
  // ID3DXFileSaveObject ///////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXFileSaveObject);'}
  {$EXTERNALSYM ID3DXFileSaveObject}
  ID3DXFileSaveObject = interface(IUnknown)
    ['{cef08cfa-7b4f-4429-9624-2a690a933201}']
    function GetFile(out ppFile: ID3DXFile): HResult; stdcall;
    function AddDataObject(const rguidTemplate: TGUID; szName: PAnsiChar;
        const pId: TGUID; cbSize: SIZE_T; pvData: Pointer; out ppObj: ID3DXFileSaveData): HResult; stdcall;
    function Save: HResult; stdcall;
  end;

  //////////////////////////////////////////////////////////////////////////////
  // ID3DXFileSaveData /////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXFileSaveData);'}
  {$EXTERNALSYM ID3DXFileSaveData}
  ID3DXFileSaveData = interface(IUnknown)
    ['{cef08cfb-7b4f-4429-9624-2a690a933201}']
    function GetSave(out SaveObj: ID3DXFileSaveObject): HResult; stdcall;
    function GetName(szName: PAnsiChar; Size: PSIZE_T): HResult; stdcall;
    function GetId(out Id: TGUID): HResult; stdcall;
    function GetType(out TypeGuid: TGUID): HResult; stdcall;
    function AddDataObject(const rguidTemplate: TGUID; szName: PAnsiChar;
        const pId: TGUID; cbSize: SIZE_T; pvData: Pointer;
        out ppObj: ID3DXFileSaveData): HResult; stdcall;
    function AddDataReference(szName: PAnsiChar; const pId: TGUID): HResult; stdcall;
  end;

  //////////////////////////////////////////////////////////////////////////////
  // ID3DXFileEnumObject ///////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXFileEnumObject);'}
  {$EXTERNALSYM ID3DXFileEnumObject}
  ID3DXFileEnumObject = interface(IUnknown)
    ['{cef08cfc-7b4f-4429-9624-2a690a933201}']
    function GetFile(out ppFile: ID3DXFile): HResult; stdcall;
    function GetChildren(out Children: SIZE_T): HResult; stdcall;
    function GetChild(id: SIZE_T; out Obj: ID3DXFileData): HResult; stdcall;
    function GetDataObjectById(const rguid: TGUID; out Obj: ID3DXFileData): HResult; stdcall;
    function GetDataObjectByName(szName: PAnsiChar; out Obj: ID3DXFileData): HResult; stdcall;
  end;

  //////////////////////////////////////////////////////////////////////////////
  // ID3DXFileData /////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXFileData);'}
  {$EXTERNALSYM ID3DXFileData}
  ID3DXFileData = interface(IUnknown)
    ['{cef08cfd-7b4f-4429-9624-2a690a933201}']
    function GetEnum(out Obj: ID3DXFileEnumObject): HResult; stdcall;
    function GetName(szName: PAnsiChar; Size: PSIZE_T): HResult; stdcall;
    function GetId(out Id: TGUID): HResult; stdcall;
    function Lock(pSize: PSIZE_T; out ppData: Pointer): HResult; stdcall;
    function Unlock: HResult; stdcall;
    function GetType(out TypeGuid: TGUID): HResult; stdcall;
    function IsReference: BOOL; stdcall;
    function GetChildren(out Children: SIZE_T): HResult; stdcall;
    function GetChild(id: SIZE_T; out Obj: ID3DXFileData): HResult; stdcall;
  end;

function D3DXFileCreate(out DirectXFile: ID3DXFile): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXFileCreate}

(*
 * DirectX File errors.
 *)

const
  _FACD3DXF = $876;
  {$EXTERNALSYM _FACD3DXF}
  MAKE_D3DXFERR_D     = (1 shl 31) or (_FACD3DXF shl 16);

  D3DXFERR_BADOBJECT              = HResult(MAKE_D3DXFERR_D or 900);
  {$EXTERNALSYM D3DXFERR_BADOBJECT}
  D3DXFERR_BADVALUE               = HResult(MAKE_D3DXFERR_D or 901);
  {$EXTERNALSYM D3DXFERR_BADVALUE}
  D3DXFERR_BADTYPE                = HResult(MAKE_D3DXFERR_D or 902);
  {$EXTERNALSYM D3DXFERR_BADTYPE}
  D3DXFERR_NOTFOUND               = HResult(MAKE_D3DXFERR_D or 903);
  {$EXTERNALSYM D3DXFERR_NOTFOUND}
  D3DXFERR_NOTDONEYET             = HResult(MAKE_D3DXFERR_D or 904);
  {$EXTERNALSYM D3DXFERR_NOTDONEYET}
  D3DXFERR_FILENOTFOUND           = HResult(MAKE_D3DXFERR_D or 905);
  {$EXTERNALSYM D3DXFERR_FILENOTFOUND}
  D3DXFERR_RESOURCENOTFOUND       = HResult(MAKE_D3DXFERR_D or 906);
  {$EXTERNALSYM D3DXFERR_RESOURCENOTFOUND}
  D3DXFERR_BADRESOURCE            = HResult(MAKE_D3DXFERR_D or 907);
  {$EXTERNALSYM D3DXFERR_BADRESOURCE}
  D3DXFERR_BADFILETYPE            = HResult(MAKE_D3DXFERR_D or 908);
  {$EXTERNALSYM D3DXFERR_BADFILETYPE}
  D3DXFERR_BADFILEVERSION         = HResult(MAKE_D3DXFERR_D or 909);
  {$EXTERNALSYM D3DXFERR_BADFILEVERSION}
  D3DXFERR_BADFILEFLOATSIZE       = HResult(MAKE_D3DXFERR_D or 910);
  {$EXTERNALSYM D3DXFERR_BADFILEFLOATSIZE}
  D3DXFERR_BADFILE                = HResult(MAKE_D3DXFERR_D or 911);
  {$EXTERNALSYM D3DXFERR_BADFILE}
  D3DXFERR_PARSEERROR             = HResult(MAKE_D3DXFERR_D or 912);
  {$EXTERNALSYM D3DXFERR_PARSEERROR}
  D3DXFERR_BADARRAYSIZE           = HResult(MAKE_D3DXFERR_D or 913);
  {$EXTERNALSYM D3DXFERR_BADARRAYSIZE}
  D3DXFERR_BADDATAREFERENCE       = HResult(MAKE_D3DXFERR_D or 914);
  {$EXTERNALSYM D3DXFERR_BADDATAREFERENCE}
  D3DXFERR_NOMOREOBJECTS          = HResult(MAKE_D3DXFERR_D or 915);
  {$EXTERNALSYM D3DXFERR_NOMOREOBJECTS}
  D3DXFERR_NOMOREDATA             = HResult(MAKE_D3DXFERR_D or 916);
  {$EXTERNALSYM D3DXFERR_NOMOREDATA}
  D3DXFERR_BADCACHEFILE           = HResult(MAKE_D3DXFERR_D or 917);
  {$EXTERNALSYM D3DXFERR_BADCACHEFILE}




//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9mesh.h
//  Content:    D3DX mesh types and functions
//
//////////////////////////////////////////////////////////////////////////////

type
  //patch mesh can be quads or tris
  _D3DXPATCHMESHTYPE = (
    D3DXPATCHMESH_RECT   = $001,
    D3DXPATCHMESH_TRI    = $002,
    D3DXPATCHMESH_NPATCH = $003
  );
  {$EXTERNALSYM _D3DXPATCHMESHTYPE}
  D3DXPATCHMESHTYPE = _D3DXPATCHMESHTYPE;
  {$EXTERNALSYM D3DXPATCHMESHTYPE}
  TD3DXPatchMeshType = _D3DXPATCHMESHTYPE;

type
  _D3DXMESH = type DWord;
  {$EXTERNALSYM _D3DXMESH}
  TD3DXMesh = _D3DXMESH;

// Mesh options - lower 3 bytes only, upper byte used by _D3DXMESHOPT option flags
const
  D3DXMESH_32BIT                  = $001; // If set, then use 32 bit indices, if not set use 16 bit indices.
  {$EXTERNALSYM D3DXMESH_32BIT}
  D3DXMESH_DONOTCLIP              = $002; // Use D3DUSAGE_DONOTCLIP for VB & IB.
  {$EXTERNALSYM D3DXMESH_DONOTCLIP}
  D3DXMESH_POINTS                 = $004; // Use D3DUSAGE_POINTS for VB & IB.
  {$EXTERNALSYM D3DXMESH_POINTS}
  D3DXMESH_RTPATCHES              = $008; // Use D3DUSAGE_RTPATCHES for VB & IB.
  {$EXTERNALSYM D3DXMESH_RTPATCHES}
  D3DXMESH_NPATCHES      = $4000;// Use D3DUSAGE_NPATCHES for VB & IB.
  {$EXTERNALSYM D3DXMESH_NPATCHES}
  D3DXMESH_VB_SYSTEMMEM      = $010; // Use D3DPOOL_SYSTEMMEM for VB. Overrides D3DXMESH_MANAGEDVERTEXBUFFER
  {$EXTERNALSYM D3DXMESH_VB_SYSTEMMEM}
  D3DXMESH_VB_MANAGED             = $020; // Use D3DPOOL_MANAGED for VB.
  {$EXTERNALSYM D3DXMESH_VB_MANAGED}
  D3DXMESH_VB_WRITEONLY           = $040; // Use D3DUSAGE_WRITEONLY for VB.
  {$EXTERNALSYM D3DXMESH_VB_WRITEONLY}
  D3DXMESH_VB_DYNAMIC             = $080; // Use D3DUSAGE_DYNAMIC for VB.
  {$EXTERNALSYM D3DXMESH_VB_DYNAMIC}
  D3DXMESH_VB_SOFTWAREPROCESSING = $8000; // Use D3DUSAGE_SOFTWAREPROCESSING for VB.
  {$EXTERNALSYM D3DXMESH_VB_SOFTWAREPROCESSING}
  D3DXMESH_IB_SYSTEMMEM      = $100; // Use D3DPOOL_SYSTEMMEM for IB. Overrides D3DXMESH_MANAGEDINDEXBUFFER
  {$EXTERNALSYM D3DXMESH_IB_SYSTEMMEM}
  D3DXMESH_IB_MANAGED             = $200; // Use D3DPOOL_MANAGED for IB.
  {$EXTERNALSYM D3DXMESH_IB_MANAGED}
  D3DXMESH_IB_WRITEONLY           = $400; // Use D3DUSAGE_WRITEONLY for IB.
  {$EXTERNALSYM D3DXMESH_IB_WRITEONLY}
  D3DXMESH_IB_DYNAMIC             = $800; // Use D3DUSAGE_DYNAMIC for IB.
  {$EXTERNALSYM D3DXMESH_IB_DYNAMIC}
  D3DXMESH_IB_SOFTWAREPROCESSING= $10000; // Use D3DUSAGE_SOFTWAREPROCESSING for IB.
  {$EXTERNALSYM D3DXMESH_IB_SOFTWAREPROCESSING}

  D3DXMESH_VB_SHARE               = $1000; // Valid for Clone* calls only, forces cloned mesh/pmesh to share vertex buffer
  {$EXTERNALSYM D3DXMESH_VB_SHARE}

  D3DXMESH_USEHWONLY              = $2000; // Valid for ID3DXSkinInfo.ConvertToBlendedMesh
  {$EXTERNALSYM D3DXMESH_USEHWONLY}

  // Helper options
  D3DXMESH_SYSTEMMEM      = $110; // D3DXMESH_VB_SYSTEMMEM | D3DXMESH_IB_SYSTEMMEM
  {$EXTERNALSYM D3DXMESH_SYSTEMMEM}
  D3DXMESH_MANAGED                = $220; // D3DXMESH_VB_MANAGED | D3DXMESH_IB_MANAGED
  {$EXTERNALSYM D3DXMESH_MANAGED}
  D3DXMESH_WRITEONLY              = $440; // D3DXMESH_VB_WRITEONLY | D3DXMESH_IB_WRITEONLY
  {$EXTERNALSYM D3DXMESH_WRITEONLY}
  D3DXMESH_DYNAMIC                = $880; // D3DXMESH_VB_DYNAMIC | D3DXMESH_IB_DYNAMIC
  {$EXTERNALSYM D3DXMESH_DYNAMIC}
  D3DXMESH_SOFTWAREPROCESSING   = $18000; // D3DXMESH_VB_SOFTWAREPROCESSING | D3DXMESH_IB_SOFTWAREPROCESSING
  {$EXTERNALSYM D3DXMESH_SOFTWAREPROCESSING}

type
  //patch mesh options
  _D3DXPATCHMESH = (
    D3DXPATCHMESH_DEFAULT {= 000,}
  );
  {$EXTERNALSYM _D3DXPATCHMESH}
  D3DXPATCHMESH = _D3DXPATCHMESH;
  {$EXTERNALSYM D3DXPATCHMESH}
  TD3DXPatchMesh = _D3DXPATCHMESH;

  // option field values for specifying min value in D3DXGeneratePMesh and D3DXSimplifyMesh
  _D3DXMESHSIMP = (
    D3DXMESHSIMP_VERTEX   = $1,
    D3DXMESHSIMP_FACE     = $2
  );
  {$EXTERNALSYM _D3DXMESHSIMP}
  TD3DXMeshSimp = _D3DXMESHSIMP;

  _D3DXCLEANTYPE = (
    D3DXCLEAN_BACKFACING     = $00000001,
    D3DXCLEAN_BOWTIES        = $00000002,

    // Helper options
    D3DXCLEAN_SKINNING       = D3DXCLEAN_BACKFACING,  // Bowtie cleaning modifies geometry and breaks skinning
    D3DXCLEAN_OPTIMIZATION   = D3DXCLEAN_BACKFACING,
    D3DXCLEAN_SIMPLIFICATION = D3DXCLEAN_BACKFACING + D3DXCLEAN_BOWTIES
  );
  {$EXTERNALSYM _D3DXCLEANTYPE}

  D3DXCLEANTYPE = _D3DXCLEANTYPE;
  {$EXTERNALSYM D3DXCLEANTYPE}
  TD3DXCleanType = _D3DXCLEANTYPE;

  _MAX_FVF_DECL_SIZE = DWord;
  {$EXTERNALSYM _MAX_FVF_DECL_SIZE}
const
  MAX_FVF_DECL_SIZE = MAXD3DDECLLENGTH + 1; // +1 for END
  {$EXTERNALSYM MAX_FVF_DECL_SIZE}

type
  TFVFDeclaration = array [0..MAX_FVF_DECL_SIZE-1] of TD3DVertexElement9;

const
  D3DXTANGENT_WRAP_U =                    $01;
  {$EXTERNALSYM D3DXTANGENT_WRAP_U}
  D3DXTANGENT_WRAP_V =                    $02;
  {$EXTERNALSYM D3DXTANGENT_WRAP_V}
  D3DXTANGENT_WRAP_UV =                   $03;
  {$EXTERNALSYM D3DXTANGENT_WRAP_UV}
  D3DXTANGENT_DONT_NORMALIZE_PARTIALS =   $04;
  {$EXTERNALSYM D3DXTANGENT_DONT_NORMALIZE_PARTIALS}
  D3DXTANGENT_DONT_ORTHOGONALIZE =        $08;
  {$EXTERNALSYM D3DXTANGENT_DONT_ORTHOGONALIZE}
  D3DXTANGENT_ORTHOGONALIZE_FROM_V =      $010;
  {$EXTERNALSYM D3DXTANGENT_ORTHOGONALIZE_FROM_V}
  D3DXTANGENT_ORTHOGONALIZE_FROM_U =      $020;
  {$EXTERNALSYM D3DXTANGENT_ORTHOGONALIZE_FROM_U}
  D3DXTANGENT_WEIGHT_BY_AREA =            $040;
  {$EXTERNALSYM D3DXTANGENT_WEIGHT_BY_AREA}
  D3DXTANGENT_WEIGHT_EQUAL =              $080;
  {$EXTERNALSYM D3DXTANGENT_WEIGHT_EQUAL}
  D3DXTANGENT_WIND_CW =                   $0100;
  {$EXTERNALSYM D3DXTANGENT_WIND_CW}
  D3DXTANGENT_CALCULATE_NORMALS =         $0200;
  {$EXTERNALSYM D3DXTANGENT_CALCULATE_NORMALS}
  D3DXTANGENT_GENERATE_IN_PLACE =         $0400;
  {$EXTERNALSYM D3DXTANGENT_GENERATE_IN_PLACE}

type
  _D3DXTANGENT = DWord;
  {$EXTERNALSYM _D3DXTANGENT}
  D3DXTANGENT = _D3DXTANGENT;
  {$EXTERNALSYM D3DXCLEANTYPE}
  TD3DXTangent = _D3DXTANGENT;

  // D3DXIMT_WRAP_U means the texture wraps in the U direction
  // D3DXIMT_WRAP_V means the texture wraps in the V direction
  // D3DXIMT_WRAP_UV means the texture wraps in both directions
  _D3DXIMT = (
    D3DXIMT_WRAP_U                    = $01,
    D3DXIMT_WRAP_V                    = $02,
    D3DXIMT_WRAP_UV                   = $03
  );
  {$EXTERNALSYM _D3DXIMT}
  D3DXIMT = _D3DXIMT;
  {$EXTERNALSYM D3DXIMT}
  TD3DXIMT = _D3DXIMT;


  // These options are only valid for UVAtlasCreate and UVAtlasPartition, we may add more for UVAtlasPack if necessary
  // D3DXUVATLAS_DEFAULT - Meshes with more than 25k faces go through fast, meshes with fewer than 25k faces go through quality
  // D3DXUVATLAS_GEODESIC_FAST - Uses approximations to improve charting speed at the cost of added stretch or more charts.
  // D3DXUVATLAS_GEODESIC_QUALITY - Provides better quality charts, but requires more time and memory than fast.
  _D3DXUVATLAS = (
    D3DXUVATLAS_DEFAULT               {= $00},
    D3DXUVATLAS_GEODESIC_FAST         {= $01},
    D3DXUVATLAS_GEODESIC_QUALITY      {= $02}
   );
   {$EXTERNALSYM _D3DXUVATLAS}
   D3DXUVATLAS = _D3DXUVATLAS;
   {$EXTERNALSYM D3DXUVATLAS}
   TD3DXUVAtlas = D3DXUVATLAS;

  PD3DXAttributeRange = ^TD3DXAttributeRange;
  _D3DXATTRIBUTERANGE = record
    AttribId:    DWord;
    FaceStart:   DWord;
    FaceCount:   DWord;
    VertexStart: DWord;
    VertexCount: DWord;
  end;
  {$EXTERNALSYM _D3DXATTRIBUTERANGE}
  D3DXATTRIBUTERANGE = _D3DXATTRIBUTERANGE;
  {$EXTERNALSYM D3DXATTRIBUTERANGE}
  TD3DXAttributeRange = _D3DXATTRIBUTERANGE;

  PD3DXMaterial = ^TD3DXMaterial;
  _D3DXMATERIAL = record
    MatD3D: TD3Dmaterial9;
    pTextureFilename: PAnsiChar;
  end;
  {$EXTERNALSYM _D3DXMATERIAL}
  D3DXMATERIAL = _D3DXMATERIAL;
  {$EXTERNALSYM D3DXMATERIAL}
  TD3DXMaterial = _D3DXMATERIAL;

  _D3DXEFFECTDEFAULTTYPE = (
    D3DXEDT_STRING = $1,        // pValue points to a null terminated ASCII string
    D3DXEDT_FLOATS = $2,        // pValue points to an array of floats - number of floats is NumBytes / sizeof(float)
    D3DXEDT_DWORD  = $3         // pValue points to a DWORD
  );
  {$EXTERNALSYM _D3DXEFFECTDEFAULTTYPE}
  D3DXEFFECTDEFAULTTYPE = _D3DXEFFECTDEFAULTTYPE;
  {$EXTERNALSYM D3DXEFFECTDEFAULTTYPE}
  TD3DXEffectDefaultType = _D3DXEFFECTDEFAULTTYPE;

  PD3DXEffectDefault = ^TD3DXEffectDefault;
  _D3DXEFFECTDEFAULT = record
    pParamName: PAnsiChar;
    _Type: TD3DXEffectDefaultType;        // type of the data pointed to by pValue
    NumBytes: DWORD;                      // size in bytes of the data pointed to by pValue
    pValue: Pointer;                      // data for the default of the effect
  end;
  {$EXTERNALSYM _D3DXEFFECTDEFAULT}
  D3DXEFFECTDEFAULT = _D3DXEFFECTDEFAULT;
  {$EXTERNALSYM D3DXEFFECTDEFAULT}
  TD3DXEffectDefault = _D3DXEFFECTDEFAULT;

  PD3DXEffectInstance = ^TD3DXEffectInstance;
  _D3DXEFFECTINSTANCE = record
    pEffectFilename: PAnsiChar;
    NumDefaults: DWORD;
    pDefaults: PD3DXEffectDefault;
  end;
  {$EXTERNALSYM _D3DXEFFECTINSTANCE}
  D3DXEFFECTINSTANCE = _D3DXEFFECTINSTANCE;
  {$EXTERNALSYM D3DXEFFECTINSTANCE}
  TD3DXEffectInstance = _D3DXEFFECTINSTANCE;

  PD3DXAttributeWeights = ^TD3DXAttributeWeights;
  _D3DXATTRIBUTEWEIGHTS = record
    Position: Single;
    Boundary: Single;
    Normal:   Single;
    Diffuse:  Single;
    Specular: Single;
    Texcoord: array[0..7] of Single;
    Tangent: Single;
    Binormal: Single;
  end;
  {$EXTERNALSYM _D3DXATTRIBUTEWEIGHTS}
  D3DXATTRIBUTEWEIGHTS = _D3DXATTRIBUTEWEIGHTS;
  {$EXTERNALSYM D3DXATTRIBUTEWEIGHTS}
  TD3DXAttributeWeights = _D3DXATTRIBUTEWEIGHTS;

  _D3DXWELDEPSILONSFLAGS = type DWord;
  {$EXTERNALSYM _D3DXWELDEPSILONSFLAGS}
  TD3DXWeldEpsilonsFlags = _D3DXWELDEPSILONSFLAGS;

const
  D3DXWELDEPSILONS_WELDALL = $1;              // weld all vertices marked by adjacency as being overlapping
  {$EXTERNALSYM D3DXWELDEPSILONS_WELDALL}

  D3DXWELDEPSILONS_WELDPARTIALMATCHES = $2;   // if a given vertex component is within epsilon, modify partial matched
                                                 // vertices so that both components identical AND if all components "equal"
                                                 // remove one of the vertices
  {$EXTERNALSYM D3DXWELDEPSILONS_WELDPARTIALMATCHES}
  D3DXWELDEPSILONS_DONOTREMOVEVERTICES = $4;  // instructs weld to only allow modifications to vertices and not removal
                                                 // ONLY valid if D3DXWELDEPSILONS_WELDPARTIALMATCHES is set
                                                 // useful to modify vertices to be equal, but not allow vertices to be removed
  {$EXTERNALSYM D3DXWELDEPSILONS_DONOTREMOVEVERTICES}
  D3DXWELDEPSILONS_DONOTSPLIT          = $8;  // instructs weld to specify the D3DXMESHOPT_DONOTSPLIT flag when doing an Optimize(ATTR_SORT)
                                                 // if this flag is not set, all vertices that are in separate attribute groups
                                                 // will remain split and not welded.  Setting this flag can slow down software vertex processing
  {$EXTERNALSYM D3DXWELDEPSILONS_DONOTSPLIT}

type
  PD3DXWeldEpsilons = ^TD3DXWeldEpsilons;
  _D3DXWELDEPSILONS = record
    Position: Single; // NOTE: This does NOT replace the epsilon in GenerateAdjacency
                      // in general, it should be the same value or greater than the one passed to GeneratedAdjacency
    BlendWeights: Single;
    Normal: Single;
    PSize: Single;
    Specular: Single;
    Diffuse: Single;
    Texcoord: array[0..7] of Single;
    Tangent: Single;
    Binormal: Single;
    TessFactor: Single;
  end;
  {$EXTERNALSYM _D3DXWELDEPSILONS}
  D3DXWELDEPSILONS = _D3DXWELDEPSILONS;
  {$EXTERNALSYM D3DXWELDEPSILONS}
  TD3DXWeldEpsilons = _D3DXWELDEPSILONS;

  PID3DXMesh = ^ID3DXMesh;
  ID3DXMesh = interface;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXBaseMesh);'}
  {$EXTERNALSYM ID3DXBaseMesh}
  ID3DXBaseMesh = interface(IUnknown)
    ['{7ED943DD-52E8-40b5-A8D8-76685C406330}']
    // ID3DXBaseMesh
    function DrawSubset(AttribId: DWord): HResult; stdcall;
    function GetNumFaces: DWord; stdcall;
    function GetNumVertices: DWord; stdcall;
    function GetFVF: DWord; stdcall;
    function GetDeclaration(out Declaration: TFVFDeclaration): HResult; stdcall;
    function GetNumBytesPerVertex: DWORD; stdcall;
    function GetOptions: DWord; stdcall;
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function CloneMeshFVF(Options, FVF: DWord; pD3DDevice: IDirect3DDevice9;
      out ppCloneMesh: ID3DXMesh): HResult; stdcall;
    function CloneMesh(Options: DWORD; pDeclaration: PD3DVertexElement9;
      pD3DDevice: IDirect3DDevice9; out ppCloneMesh: ID3DXMesh): HResult; stdcall;
    function GetVertexBuffer(out ppVB: IDirect3DVertexBuffer9): HResult; stdcall;
    function GetIndexBuffer(out ppIB: IDirect3DIndexBuffer9): HResult; stdcall;
    function LockVertexBuffer(Flags: DWord; out ppData: Pointer): HResult; stdcall;
    function UnlockVertexBuffer: HResult; stdcall;
    function LockIndexBuffer(Flags: DWord; out ppData: Pointer): HResult; stdcall;
    function UnlockIndexBuffer: HResult; stdcall;
    function GetAttributeTable(pAttribTable: PD3DXAttributeRange;
      pAttribTableSize: PDWord): HResult; stdcall;

    function ConvertPointRepsToAdjacency(pPRep: PDWord; pAdjacency: PDWord): HResult; stdcall;
    function ConvertAdjacencyToPointReps(pAdjacency: PDWord; pPRep: PDWord): HResult; stdcall;
    function GenerateAdjacency(Epsilon: Single; pAdjacency: PDWord): HResult; stdcall;

    function UpdateSemantics(const Declaration: TFVFDeclaration): HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXMesh);'}
  {$EXTERNALSYM ID3DXMesh}
  ID3DXMesh = interface(ID3DXBaseMesh)
    ['{4020E5C2-1403-4929-883F-E2E849FAC195}']
    // ID3DXMesh
    function LockAttributeBuffer(Flags: DWord; out ppData: PDWORD): HResult; stdcall;
    function UnlockAttributeBuffer: HResult; stdcall;
    function Optimize(Flags: DWord; pAdjacencyIn, pAdjacencyOut: PDWord;
      pFaceRemap: PDWord; ppVertexRemap: PID3DXBuffer;
      out ppOptMesh: ID3DXMesh): HResult; stdcall;
    function OptimizeInplace(Flags: DWord; pAdjacencyIn, pAdjacencyOut: PDWord;
      pFaceRemap: PDWord; ppVertexRemap: PID3DXBuffer): HResult; stdcall;
    function SetAttributeTable(pAttribTable: PD3DXAttributeRange; cAttribTableSize: DWORD): HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXPMesh);'}
  {$EXTERNALSYM ID3DXPMesh}
  ID3DXPMesh = interface(ID3DXBaseMesh)
    ['{8875769A-D579-4088-AAEB-534D1AD84E96}']
    // ID3DXPMesh
    function ClonePMeshFVF(Options, FVF: DWord; pD3DDevice: IDirect3DDevice9;
      out ppCloneMesh: ID3DXPMesh): HResult; stdcall;
    function ClonePMesh(Options: DWORD; pDeclaration: PD3DVertexElement9;
      pD3DDevice: IDirect3DDevice9; out ppCloneMesh: ID3DXPMesh): HResult; stdcall;
    function SetNumFaces(Faces: DWord): HResult; stdcall;
    function SetNumVertices(Vertices: DWord): HResult; stdcall;
    function GetMaxFaces: DWord; stdcall;
    function GetMinFaces: DWord; stdcall;
    function GetMaxVertices: DWord; stdcall;
    function GetMinVertices: DWord; stdcall;
    function Save(pStream: IStream; pMaterials: PD3DXMaterial;
      pEffectInstances: PD3DXEffectInstance; NumMaterials: DWORD): HResult; stdcall;

    function Optimize(Flags: DWord; pAdjacencyOut: PDWord;
      pFaceRemap: PDWord; ppVertexRemap: PID3DXBuffer;
      out ppOptMesh: ID3DXMesh): HResult; stdcall;

    function OptimizeBaseLOD(Flags: DWord; pFaceRemap: PDWord): HResult; stdcall;
    function TrimByFaces(NewFacesMin, NewFacesMax: DWord; rgiFaceRemap, rgiVertRemap: PDWord): HResult; stdcall;
    function TrimByVertices(NewVerticesMin, NewVerticesMax: DWord; rgiFaceRemap, rgiVertRemap: PDWord): HResult; stdcall;

    function GetAdjacency(pAdjacency: PDWord): HResult; stdcall;

    //  Used to generate the immediate "ancestor" for each vertex when it is removed by a vsplit.  Allows generation of geomorphs
    //     Vertex buffer must be equal to or greater than the maximum number of vertices in the pmesh
    function GenerateVertexHistory(pVertexHistory: PDWORD): HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXSPMesh);'}
  {$EXTERNALSYM ID3DXSPMesh}
  ID3DXSPMesh = interface(IUnknown)
    ['{667EA4C7-F1CD-4386-B523-7C0290B83CC5}']
    // ID3DXSPMesh
    function GetNumFaces: DWord; stdcall;
    function GetNumVertices: DWord; stdcall;
    function GetFVF: DWord; stdcall;
    function GetDeclaration(out Declaration: TFVFDeclaration): HResult; stdcall;
    function GetOptions: DWord; stdcall;
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function CloneMeshFVF(Options, FVF: DWord; pD3DDevice: IDirect3DDevice9;
      pAdjacencyOut, pVertexRemapOut: PDWord;
      out ppCloneMesh: ID3DXMesh): HResult; stdcall;
    function CloneMesh(Options: DWORD; pDeclaration: PD3DVertexElement9;
      pD3DDevice: IDirect3DDevice9; pAdjacencyOut, pVertexRemapOut: PDWORD;
      out ppCloneMesh: ID3DXMesh): HResult; stdcall;
    function ClonePMeshFVF(Options, FVF: DWORD; pD3DDevice: IDirect3DDevice9;
      pVertexRemapOut: PDWORD; pErrorsByFace: PSingle; out ppCloneMesh: ID3DXPMesh): HResult; stdcall;
    function ClonePMesh(Options: DWORD; pDeclaration: PD3DVertexElement9;
      pD3DDevice: IDirect3DDevice9; pVertexRemapOut: PDWORD; pErrorsbyFace: PSingle;
      out ppCloneMesh: ID3DXPMesh): HResult; stdcall;
    function ReduceFaces(Faces: DWord): HResult; stdcall;
    function ReduceVertices(Vertices: DWord): HResult; stdcall;
    function GetMaxFaces: DWord; stdcall;
    function GetMaxVertices: DWord; stdcall;
    function GetVertexAttributeWeights(pVertexAttributeWeights: PD3DXAttributeWeights): HResult; stdcall;
    function GetVertexWeights(pVertexWeights: PSingle): HResult; stdcall;
  end;

const
  UNUSED16      = $ffff;
  {$EXTERNALSYM UNUSED16}
  UNUSED32      = $ffffffff;
  {$EXTERNALSYM UNUSED32}

// ID3DXMesh::Optimize options - upper byte only, lower 3 bytes used from _D3DXMESH option flags
type
  _D3DXMESHOPT = type DWord;
  {$EXTERNALSYM _D3DXMESHOPT}
  TD3DXMeshOpt = _D3DXMESHOPT;

const
  D3DXMESHOPT_COMPACT       = $01000000;
  {$EXTERNALSYM D3DXMESHOPT_COMPACT}
  D3DXMESHOPT_ATTRSORT      = $02000000;
  {$EXTERNALSYM D3DXMESHOPT_ATTRSORT}
  D3DXMESHOPT_VERTEXCACHE   = $04000000;
  {$EXTERNALSYM D3DXMESHOPT_VERTEXCACHE}
  D3DXMESHOPT_STRIPREORDER  = $08000000;
  {$EXTERNALSYM D3DXMESHOPT_STRIPREORDER}
  D3DXMESHOPT_IGNOREVERTS   = $10000000;  // optimize faces only; don't touch vertices
  {$EXTERNALSYM D3DXMESHOPT_IGNOREVERTS}
  D3DXMESHOPT_DONOTSPLIT    = $20000000;  // do not split vertices shared between attribute groups when attribute sorting
  {$EXTERNALSYM D3DXMESHOPT_DONOTSPLIT}
  D3DXMESHOPT_DEVICEINDEPENDENT = $00400000;  // Only affects VCache.  uses a static known good cache size for all cards
  {$EXTERNALSYM D3DXMESHOPT_DEVICEINDEPENDENT}

  // D3DXMESHOPT_SHAREVB has been removed, please use D3DXMESH_VB_SHARE instead

// Subset of the mesh that has the same attribute and bone combination.
// This subset can be rendered in a single draw call
type
  PDWordArray = ^TDWordArray;
  {$NODEFINE PDWordArray}
  TDWordArray = array[0..MaxInt div SizeOf(DWORD) - 1] of DWord;
  {$NODEFINE TDWordArray}

  PD3DXBoneCombination = ^TD3DXBoneCombination;
  _D3DXBONECOMBINATION = record
    AttribId: DWord;
    FaceStart: DWord;
    FaceCount: DWord;
    VertexStart: DWord;
    VertexCount: DWord;
    BoneId: PDWordArray; // [ DWORD* ]  in original d3dx8mesh.h
  end;
  {$EXTERNALSYM _D3DXBONECOMBINATION}
  D3DXBONECOMBINATION = _D3DXBONECOMBINATION;
  {$EXTERNALSYM D3DXBONECOMBINATION}
  TD3DXBoneCombination = _D3DXBONECOMBINATION;

// The following types of patch combinations are supported:
// Patch type   Basis       Degree
// Rect         Bezier      2,3,5
// Rect         B-Spline    2,3,5
// Rect         Catmull-Rom 3
// Tri          Bezier      2,3,5
// N-Patch      N/A         3

  PD3DXPatchInfo = ^TD3DXPatchInfo;
  _D3DXPATCHINFO = record
    PatchType: TD3DXPatchMeshType;
    Degree: TD3DDegreeType;
    Basis: TD3DBasisType;
  end;
  {$EXTERNALSYM _D3DXPATCHINFO}
  D3DXPATCHINFO = _D3DXPATCHINFO;
  {$EXTERNALSYM D3DXPATCHINFO}
  TD3DXPatchInfo = _D3DXPATCHINFO;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXPatchMesh);'}
  {$EXTERNALSYM ID3DXPatchMesh}
  ID3DXPatchMesh = interface(IUnknown)
    ['{3CE6CC22-DBF2-44f4-894D-F9C34A337139}']
    // ID3DXPatchMesh

    // Return creation parameters
    function GetNumPatches: DWORD; stdcall;
    function GetNumVertices: DWORD; stdcall;
    function GetDeclaration(out Declaration: TFVFDeclaration): HResult; stdcall;
    function GetControlVerticesPerPatch: DWORD; stdcall;
    function GetOptions: DWORD; stdcall;
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetPatchInfo(out PatchInfo: TD3DXPatchInfo): HResult; stdcall;

    // Control mesh access    
    function GetVertexBuffer(out ppVB: IDirect3DVertexBuffer9): HResult; stdcall;
    function GetIndexBuffer(out ppIB: IDirect3DIndexBuffer9): HResult; stdcall;
    function LockVertexBuffer(flags: DWORD; out ppData: Pointer): HResult; stdcall;
    function UnlockVertexBuffer: HResult; stdcall;
    function LockIndexBuffer(flags: DWORD; out ppData: Pointer): HResult; stdcall;
    function UnlockIndexBuffer: HResult; stdcall;
    function LockAttributeBuffer(flags: DWORD; out ppData: PDWORD): HResult; stdcall;
    function UnlockAttributeBuffer: HResult; stdcall;

    // This function returns the size of the tessellated mesh given a tessellation level.
    // This assumes uniform tessellation. For adaptive tessellation the Adaptive parameter must
    // be set to TRUE and TessellationLevel should be the max tessellation.
    // This will result in the max mesh size necessary for adaptive tessellation.
    function GetTessSize(fTessLevel: Single; Adaptive: LongBool; out NumTriangles, NumVertices: DWORD): HResult; stdcall;

    //GenerateAdjacency determines which patches are adjacent with provided tolerance
    //this information is used internally to optimize tessellation
    function GenerateAdjacency(Tolerance: Single): HResult; stdcall;

    //CloneMesh Creates a new patchmesh with the specified decl, and converts the vertex buffer
    //to the new decl. Entries in the new decl which are new are set to 0. If the current mesh
    //has adjacency, the new mesh will also have adjacency
    function CloneMesh(Options: DWORD; pDecl: PD3DVertexElement9; out pMesh: ID3DXPatchMesh): HResult; stdcall;

    // Optimizes the patchmesh for efficient tessellation. This function is designed
    // to perform one time optimization for patch meshes that need to be tessellated
    // repeatedly by calling the Tessellate() method. The optimization performed is
    // independent of the actual tessellation level used.
    // Currently Flags is unused.
    // If vertices are changed, Optimize must be called again
    function Optimize(flags: DWORD): HResult; stdcall;

    //gets and sets displacement parameters
    //displacement maps can only be 2D textures MIP-MAPPING is ignored for non adapative tessellation
    function SetDisplaceParam(Texture: IDirect3DBaseTexture9;
                              MinFilter: TD3DTextureFilterType;
                              MagFilter: TD3DTextureFilterType;
                              MipFilter: TD3DTextureFilterType;
                              Wrap: TD3DTextureAddress;
                              dwLODBias: DWORD): HResult; stdcall;

    function GetDisplaceParam(out Texture: IDirect3DBaseTexture9;
                              out MinFilter: TD3DTextureFilterType;
                              out MagFilter: TD3DTextureFilterType;
                              out MipFilter: TD3DTextureFilterType;
                              out Wrap: TD3DTextureAddress;
                              out dwLODBias: DWORD): HResult; stdcall;
        
    // Performs the uniform tessellation based on the tessellation level. 
    // This function will perform more efficiently if the patch mesh has been optimized using the Optimize() call.
    function Tessellate(fTessLevel: Single; pMesh: ID3DXMesh): HResult; stdcall;

    // Performs adaptive tessellation based on the Z based adaptive tessellation criterion.
    // pTrans specifies a 4D vector that is dotted with the vertices to get the per vertex
    // adaptive tessellation amount. Each edge is tessellated to the average of the criterion
    // at the 2 vertices it connects.
    // MaxTessLevel specifies the upper limit for adaptive tesselation.
    // This function will perform more efficiently if the patch mesh has been optimized using the Optimize() call.
    function TessellateAdaptive(const pTrans: TD3DXVector4;
                                dwMaxTessLevel, dwMinTessLevel: DWORD;
                                pMesh: ID3DXMesh): HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXSkinInfo);'}
  {$EXTERNALSYM ID3DXSkinInfo}
  ID3DXSkinInfo = interface(IUnknown)
    ['{11EAA540-F9A6-4d49-AE6A-E19221F70CC4}']
    // Specify the which vertices do each bones influence and by how much
    function SetBoneInfluence(bone, numInfluences: DWORD; vertices: PDWORD; weights: PSingle): HResult; stdcall;
    function SetBoneVertexInfluence(boneNum, influenceNum: DWORD; weight: Single): HResult; stdcall;
    function GetNumBoneInfluences(bone: DWORD): DWORD; stdcall;
    function GetBoneInfluence(bone: DWORD; vertices: PDWORD; weights: PSingle): HResult; stdcall;
    function GetBoneVertexInfluence(boneNum, influenceNum: DWORD; out pWeight: Single; out pVertexNum: DWORD): HResult; stdcall;
    function GetMaxVertexInfluences(out maxVertexInfluences: DWORD): HResult; stdcall;
    function GetNumBones: DWORD; stdcall;
    function FindBoneVertexInfluenceIndex(boneNum, vertexNum: DWORD; out pInfluenceIndex: DWORD): HResult; stdcall;

    // This gets the max face influences based on a triangle mesh with the specified index buffer
    function GetMaxFaceInfluences(pIB: IDirect3DIndexBuffer9; NumFaces: DWORD; out maxFaceInfluences:DWORD): HResult; stdcall;

    // Set min bone influence. Bone influences that are smaller than this are ignored
    function SetMinBoneInfluence(MinInfl: Single): HResult; stdcall;
    // Get min bone influence.
    function GetMinBoneInfluence: Single; stdcall;

    // Bone names are returned by D3DXLoadSkinMeshFromXof. They are not used by any other method of this object
    function SetBoneName(Bone: DWORD; pName: PAnsiChar): HResult; stdcall; // pName is copied to an internal string buffer
    function GetBoneName(Bone: DWORD): PAnsiChar; stdcall; // A pointer to an internal string buffer is returned. Do not free this.

    // Bone offset matrices are returned by D3DXLoadSkinMeshFromXof. They are not used by any other method of this object
    function SetBoneOffsetMatrix(Bone: DWORD; const pBoneTransform: TD3DXMatrix): HResult; stdcall; // pBoneTransform is copied to an internal buffer
    function GetBoneOffsetMatrix(Bone: DWORD): PD3DXMatrix; stdcall; // A pointer to an internal matrix is returned. Do not free this.

    // Clone a skin info object
    function Clone(out ppSkinInfo: ID3DXSkinInfo): HResult; stdcall;

    // Update bone influence information to match vertices after they are reordered. This should be called
    // if the target vertex buffer has been reordered externally.
    function Remap(NumVertices: DWORD; pVertexRemap: PDWORD): HResult; stdcall;

    // These methods enable the modification of the vertex layout of the vertices that will be skinned
    function SetFVF(FVF: DWORD): HResult; stdcall;
    function SetDeclaration(pDeclaration: PD3DVertexElement9): HResult; stdcall;
    function GetFVF: DWORD; stdcall;
    function GetDeclaration(out Declaration: TFVFDeclaration): HResult; stdcall;

    // Apply SW skinning based on current pose matrices to the target vertices.
    function UpdateSkinnedMesh(
      pBoneTransforms: PD3DXMatrix;
      pBoneInvTransposeTransforms: PD3DXMatrix;
      pVerticesSrc: Pointer;
      pVerticesDst: Pointer): HResult; stdcall;

    // Takes a mesh and returns a new mesh with per vertex blend weights and a bone combination
    // table that describes which bones affect which subsets of the mesh
    function ConvertToBlendedMesh(
      pMesh: ID3DXMesh;
      Options: DWORD;
      pAdjacencyIn: PDWORD;
      pAdjacencyOut: PDWORD;
      pFaceRemap: PDWORD;
      ppVertexRemap: PID3DXBuffer;
      pMaxFaceInfl: PDWORD;
      out pNumBoneCombinations: DWORD;
      out ppBoneCombinationTable: ID3DXBuffer;
      out ppMesh: ID3DXMesh): HResult; stdcall;

    // Takes a mesh and returns a new mesh with per vertex blend weights and indices 
    // and a bone combination table that describes which bones palettes affect which subsets of the mesh
    function ConvertToIndexedBlendedMesh(
      pMesh: ID3DXMesh;
      Options: DWORD;
      paletteSize: DWORD;
      pAdjacencyIn: PDWORD;
      pAdjacencyOut: PDWORD;
      pFaceRemap: PDWORD;
      ppVertexRemap: PID3DXBuffer;
      pMaxVertexInfl: PDWORD;
      out pNumBoneCombinations: DWORD;
      out ppBoneCombinationTable: ID3DXBuffer;
      out ppMesh: ID3DXMesh): HResult; stdcall;
  end;

type
  IID_ID3DXBaseMesh     = ID3DXBaseMesh;
  {$EXTERNALSYM IID_ID3DXBaseMesh}
  IID_ID3DXMesh         = ID3DXMesh;
  {$EXTERNALSYM IID_ID3DXMesh}
  IID_ID3DXPMesh        = ID3DXPMesh;
  {$EXTERNALSYM IID_ID3DXPMesh}
  IID_ID3DXSPMesh       = ID3DXSPMesh;
  {$EXTERNALSYM IID_ID3DXSPMesh}
  IID_ID3DXSkinInfo     = ID3DXSkinInfo;
  {$EXTERNALSYM IID_ID3DXSkinInfo}
  IID_ID3DXPatchMesh    = ID3DXPatchMesh;
  {$EXTERNALSYM IID_ID3DXPatchMesh}


function D3DXCreateMesh(NumFaces, NumVertices: DWord; Options: DWord;
  pDeclaration: PD3DVertexElement9;
  pD3DDevice: IDirect3DDevice9; out ppMesh: ID3DXMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreateMesh}

function D3DXCreateMeshFVF(NumFaces, NumVertices: DWord; Options: DWord;
  FVF: DWord; pD3DDevice: IDirect3DDevice9; out ppMesh: ID3DXMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreateMeshFVF}

function D3DXCreateSPMesh(pMesh: ID3DXMesh; pAdjacency: PDWord;
  pVertexAttributeWeights: PD3DXAttributeWeights; pVertexWeights: PSingle;
  out ppSMesh: ID3DXSPMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreateSPMesh}

// clean a mesh up for simplification, try to make manifold
function D3DXCleanMesh(CleanType: TD3DXCleanType; pMeshIn: ID3DXMesh; pAdjacencyIn: PDWord;
  out ppMeshOut: ID3DXMesh; pAdjacencyOut: PDWord;
  ppErrorsAndWarnings: PID3DXBuffer): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCleanMesh}

function D3DXValidMesh(pMeshIn: ID3DXMesh; pAdjacency: PDWord;
  ppErrorsAndWarnings: PID3DXBuffer): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXValidMesh}

function D3DXGeneratePMesh(pMesh: ID3DXMesh; pAdjacency: PDWord;
  pVertexAttributeWeights: PD3DXAttributeWeights; pVertexWeights: PSingle;
  MinValue: DWord; Options: TD3DXMeshSimp; out ppPMesh: ID3DXPMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXGeneratePMesh}

function D3DXSimplifyMesh(pMesh: ID3DXMesh; pAdjacency: PDWord;
  pVertexAttributeWeights: PD3DXAttributeWeights; pVertexWeights: PSingle;
  MinValue: DWord; Options: TD3DXMeshSimp; out ppMesh: ID3DXMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXSimplifyMesh}

function D3DXComputeBoundingSphere(
  pFirstPosition: PD3DXVector3;       // pointer to first position
  NumVertices: DWORD;
  dwStride: DWORD;                     // count in bytes to subsequent position vectors
  out pCenter: TD3DXVector3;
  out pRadius: Single): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXComputeBoundingSphere}

function D3DXComputeBoundingBox(
  pFirstPosition: PD3DXVector3;       // pointer to first position
  NumVertices: DWORD;
  dwStride: DWORD;                     // count in bytes to subsequent position vectors
  out pMin, pMax: TD3DXVector3): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXComputeBoundingBox}

function D3DXComputeNormals(pMesh: ID3DXBaseMesh; pAdjacency: PDWord): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXComputeNormals}

function D3DXCreateBuffer(NumBytes: DWord; out ppBuffer: ID3DXBuffer): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreateBuffer}

function D3DXLoadMeshFromXA(
  pFilename: PAnsiChar;
  Options: DWord;
  pD3DDevice: IDirect3DDevice9;
  ppAdjacency, ppMaterials, ppEffectInstances: PID3DXBuffer;
  pNumMaterials: PDWORD;
  out ppMesh: ID3DXMesh): HResult; stdcall; external d3dx9meshDLL name 'D3DXLoadMeshFromXA';
{$EXTERNALSYM D3DXLoadMeshFromXA}

function D3DXLoadMeshFromXW(
  pFilename: PWideChar;
  Options: DWord;
  pD3DDevice: IDirect3DDevice9;
  ppAdjacency, ppMaterials, ppEffectInstances: PID3DXBuffer;
  pNumMaterials: PDWORD;
  out ppMesh: ID3DXMesh): HResult; stdcall; external d3dx9meshDLL name 'D3DXLoadMeshFromXW';
{$EXTERNALSYM D3DXLoadMeshFromXW}

function D3DXLoadMeshFromX(
  pFilename: PChar;
  Options: DWord;
  pD3DDevice: IDirect3DDevice9;
  ppAdjacency, ppMaterials, ppEffectInstances: PID3DXBuffer;
  pNumMaterials: PDWORD;
  out ppMesh: ID3DXMesh): HResult; stdcall; external d3dx9meshDLL name 'D3DXLoadMeshFromXA';
{$EXTERNALSYM D3DXLoadMeshFromX}


function D3DXLoadMeshFromXInMemory(
  Memory: Pointer;
  SizeOfMemory: DWORD;
  Options: DWORD;
  pD3DDevice: IDirect3DDevice9;
  ppAdjacency, ppMaterials, ppEffectInstances: PID3DXBuffer;
  pNumMaterials: PDWORD;
  out ppMesh: ID3DXMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXLoadMeshFromXInMemory}

function D3DXLoadMeshFromXResource(
  Module: HModule;
  Name: PAnsiChar;
  _Type: PAnsiChar;
  Options: DWORD;
  pD3D: IDirect3DDevice9;
  ppAdjacency, ppMaterials, ppEffectInstances: PID3DXBuffer;
  pNumMaterials: PDWORD;
  out ppMesh: ID3DXMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXLoadMeshFromXResource}

function D3DXSaveMeshToXA(
  pFilename: PAnsiChar;
  pMesh: ID3DXMesh;
  pAdjacency: PDWORD;
  pMaterials: PD3DXMaterial;
  pEffectInstances: PD3DXEffectInstance;
  NumMaterials: DWORD;
  Format: DWORD): HResult; stdcall; external d3dx9meshDLL name 'D3DXSaveMeshToXA';
{$EXTERNALSYM D3DXSaveMeshToXA}

function D3DXSaveMeshToXW(
  pFilename: PWideChar;
  pMesh: ID3DXMesh;
  pAdjacency: PDWORD;
  pMaterials: PD3DXMaterial;
  pEffectInstances: PD3DXEffectInstance;
  NumMaterials: DWORD;
  Format: DWORD): HResult; stdcall; external d3dx9meshDLL name 'D3DXSaveMeshToXW';
{$EXTERNALSYM D3DXSaveMeshToXW}

function D3DXSaveMeshToX(
  pFilename: PChar;
  pMesh: ID3DXMesh;
  pAdjacency: PDWORD;
  pMaterials: PD3DXMaterial;
  pEffectInstances: PD3DXEffectInstance;
  NumMaterials: DWORD;
  Format: DWORD): HResult; stdcall; external d3dx9meshDLL name 'D3DXSaveMeshToXA';
{$EXTERNALSYM D3DXSaveMeshToX}


function D3DXCreatePMeshFromStream(
  pStream: IStream;
  Options: DWORD;
  pD3DDevice: IDirect3DDevice9;
  ppMaterials: PID3DXBuffer;
  ppEffectInstances: PID3DXBuffer;
  pNumMaterials: PDWORD;
  out ppPMesh: ID3DXPMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreatePMeshFromStream}

// Creates a skin info object based on the number of vertices, number of bones, and a declaration describing the vertex layout of the target vertices
// The bone names and initial bone transforms are not filled in the skin info object by this method.
function D3DXCreateSkinInfo(
  NumVertices: DWORD;
  pDeclaration: PD3DVertexElement9;
  NumBones: DWORD;
  out ppSkinInfo: ID3DXSkinInfo): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreateSkinInfo}

// Creates a skin info object based on the number of vertices, number of bones, and a FVF describing the vertex layout of the target vertices
// The bone names and initial bone transforms are not filled in the skin info object by this method.
function D3DXCreateSkinInfoFVF(
  NumVertices: DWORD;
  FVF: DWORD;
  NumBones: DWORD;
  out ppSkinInfo: ID3DXSkinInfo): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreateSkinInfoFVF}

function D3DXLoadMeshFromXof(
  pxofMesh: ID3DXFileData;
  Options: DWord;
  pD3D: IDirect3DDevice9;
  ppAdjacency, ppMaterials, ppEffectInstances: PID3DXBuffer;
  pNumMaterials: PDWord;
  out ppMesh: ID3DXMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXLoadMeshFromXof}

// This similar to D3DXLoadMeshFromXof, except also returns skinning info if present in the file
// If skinning info is not present, ppSkinInfo will be NULL
function D3DXLoadSkinMeshFromXof(
  pxofMesh: ID3DXFileData;
  Options: DWORD;
  pD3DDevice: IDirect3DDevice9;
  ppAdjacency, ppMaterials, ppEffectInstances: PID3DXBuffer;
  pMatOut: PDWORD;
  out ppSkinInfo: ID3DXSkinInfo;
  out ppMesh: ID3DXMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXLoadSkinMeshFromXof}


// The inverse of D3DXConvertTo{Indexed}BlendedMesh() functions. It figures out the skinning info from
// the mesh and the bone combination table and populates a skin info object with that data. The bone
// names and initial bone transforms are not filled in the skin info object by this method. This works
// with either a non-indexed or indexed blended mesh. It examines the FVF or declarator of the mesh to
// determine what type it is.
function D3DXCreateSkinInfoFromBlendedMesh(
  pMesh: ID3DXBaseMesh;
  NumBones: DWORD;
  pBoneCombinationTable: PD3DXBoneCombination;
  out ppSkinInfo: ID3DXSkinInfo): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreateSkinInfoFromBlendedMesh}

function D3DXTessellateNPatches(pMeshIn: ID3DXMesh;
  pAdjacencyIn: PDWord; NumSegs: Single;
  QuadraticInterpNormals: BOOL; // if false use linear intrep for normals, if true use quadratic
  out ppMeshOut: ID3DXMesh; ppAdjacencyOut: PDWord): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXTessellateNPatches}


//generates implied outputdecl from input decl
//the decl generated from this should be used to generate the output decl for
//the tessellator subroutines.

function D3DXGenerateOutputDecl(
  pOutput: PD3DVertexElement9;
  pInput: PD3DVertexElement9): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXGenerateOutputDecl}

//loads patches from an XFileData
//since an X file can have up to 6 different patch meshes in it,
//returns them in an array - pNumPatches will contain the number of
//meshes in the actual file.
function D3DXLoadPatchMeshFromXof(
  pxofMesh: ID3DXFileData;
  Options: DWORD;
  pD3DDevice: IDirect3DDevice9;
  ppMaterials: PID3DXBuffer;
  ppEffectInstances: PID3DXBuffer;
  pNumMaterials: PDWORD;
  out ppMesh: ID3DXPatchMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXLoadPatchMeshFromXof}

//computes the size a single rect patch.
function D3DXRectPatchSize(
  pfNumSegs: PSingle;           //segments for each edge (4)
  pdwTriangles: PDWORD;         //output number of triangles
  pdwVertices: PDWORD           //output number of vertices
 ): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXRectPatchSize}

//computes the size of a single triangle patch
function D3DXTriPatchSize(
  pfNumSegs: PSingle;           //segments for each edge (3)
  pdwTriangles: PDWORD;         //output number of triangles
  pdwVertices: PDWORD           //output number of vertices
 ): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXTriPatchSize}


//tessellates a patch into a created mesh
//similar to D3D RT patch
function D3DXTessellateRectPatch(
  pVB: IDirect3DVertexBuffer9;
  pNumSegs: PSingle;
  pdwInDecl: PD3DVertexElement9;
  const pRectPatchInfo: TD3DRectPatchInfo;
  pMesh: ID3DXMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXTessellateRectPatch}


function D3DXTessellateTriPatch(
  pVB: IDirect3DVertexBuffer9;
  pNumSegs: PSingle;
  pInDecl: PD3DVertexElement9;
  pTriPatchInfo: TD3DTriPatchInfo;
  pMesh: ID3DXMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXTessellateTriPatch}



//creates an NPatch PatchMesh from a D3DXMESH
function D3DXCreateNPatchMesh(
  pMeshSysMem: ID3DXMesh;
  out pPatchMesh: ID3DXPatchMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreateNPatchMesh}


//creates a patch mesh
function D3DXCreatePatchMesh(
  const pInfo: TD3DXPatchInfo; //patch type
  dwNumPatches: DWORD;         //number of patches
  dwNumVertices: DWORD;        //number of control vertices
  dwOptions: DWORD;            //options
  pDecl: PD3DVertexElement9;   //format of control vertices
  pD3DDevice: IDirect3DDevice9;
  out pPatchMesh: ID3DXPatchMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreatePatchMesh}


//returns the number of degenerates in a patch mesh -
//text output put in string.
function D3DXValidPatchMesh(
  pMesh: ID3DXPatchMesh;
  dwcDegenerateVertices: PDWORD;
  dwcDegeneratePatches: PDWORD;
  ppErrorsAndWarnings: PID3DXBuffer): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXValidPatchMesh}

function D3DXGetFVFVertexSize(FVF: DWord): LongWord; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXGetFVFVertexSize}

function D3DXGetDeclVertexSize(pDecl: PD3DVertexElement9; Stream: DWORD): LongWord; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXGetDeclVertexSize}

function D3DXGetDeclLength(pDecl: PD3DVertexElement9): LongWord; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXGetDeclLength}

function D3DXDeclaratorFromFVF(FVF: DWord; out Declaration: TFVFDeclaration): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXDeclaratorFromFVF}

function D3DXFVFFromDeclarator(pDeclarator: PD3DVertexElement9; out pFVF: DWord): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXFVFFromDeclarator}

function D3DXWeldVertices(
  pMesh: ID3DXMesh;
  Flags: DWORD;
  pEpsilons: PD3DXWeldEpsilons;
  rgdwAdjacencyIn, rgdwAdjacencyOut, pFaceRemap: PDWord;
  ppVertexRemap: PID3DXBuffer): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXWeldVertices}

type
  PD3DXIntersectInfo = ^TD3DXIntersectInfo;
  _D3DXINTERSECTINFO = record
    FaceIndex: DWord;                // index of face intersected
    U: Single;                       // Barycentric Hit Coordinates
    V: Single;                       // Barycentric Hit Coordinates
    Dist: Single;                    // Ray-Intersection Parameter Distance
  end;
  {$EXTERNALSYM _D3DXINTERSECTINFO}
  D3DXINTERSECTINFO = _D3DXINTERSECTINFO;
  {$EXTERNALSYM D3DXINTERSECTINFO}
  TD3DXIntersectInfo = _D3DXINTERSECTINFO;

function D3DXIntersect(pMesh: ID3DXBaseMesh;
  const pRayPos, pRayDir: TD3DXVector3;
  out pHit: BOOL;                   // True if any faces were intersected
  pFaceIndex: PDWord;               // index of closest face intersected
  pU: PSingle;                      // Barycentric Hit Coordinates
  pV: PSingle;                      // Barycentric Hit Coordinates
  pDist: PSingle;                   // Ray-Intersection Parameter Distance
  ppAllHits: PID3DXBuffer;          // Array of D3DXINTERSECTINFOs for all hits (not just closest)
  pCountOfHits: PDWord              // Number of entries in AllHits array
 ): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXIntersect}

function D3DXIntersectSubset(pMesh: ID3DXBaseMesh; AttribId: DWord;
  const pRayPos, pRayDir: TD3DXVector3;
  out pHit: BOOL;                   // True if any faces were intersected
  pFaceIndex: PDWord;               // index of closest face intersected
  pU: PSingle;                      // Barycentric Hit Coordinates
  pV: PSingle;                      // Barycentric Hit Coordinates
  pDist: PSingle;                   // Ray-Intersection Parameter Distance
  ppAllHits: PID3DXBuffer;          // Array of D3DXINTERSECTINFOs for all hits (not just closest)
  pCountOfHits: PDWord              // Number of entries in AllHits array
 ): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXIntersectSubset}


function D3DXSplitMesh(pMeshIn: ID3DXMesh; pAdjacencyIn: PDWord;
  MaxSize, Options: DWord;
  out pMeshesOut: DWord; out ppMeshArrayOut: ID3DXBuffer;
  ppAdjacencyArrayOut, ppFaceRemapArrayOut, ppVertRemapArrayOut: PID3DXBuffer
 ): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXSplitMesh}

function D3DXIntersectTri(
  const p0: TD3DXVector3;           // Triangle vertex 0 position
  const p1: TD3DXVector3;           // Triangle vertex 1 position
  const p2: TD3DXVector3;           // Triangle vertex 2 position
  const pRayPos: TD3DXVector3;      // Ray origin
  const pRayDir: TD3DXVector3;      // Ray direction
  out pU: Single;                   // Barycentric Hit Coordinates
  out pV: Single;                   // Barycentric Hit Coordinates
  out pDist: Single                 // Ray-Intersection Parameter Distance
 ): BOOL; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXIntersectTri}

function D3DXSphereBoundProbe(const pCenter: TD3DXVector3; Radius: Single;
  out pRayPosition, pRayDirection: TD3DXVector3): BOOL; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXSphereBoundProbe}

function D3DXBoxBoundProbe(const pMin, pMax: TD3DXVector3;
  out pRayPosition, pRayDirection: TD3DXVector3): BOOL; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXBoxBoundProbe}


function D3DXComputeTangentFrame(pMesh: ID3DXMesh; dwOptions: DWORD): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXComputeTangentFrame}

function D3DXComputeTangentFrameEx(pMesh: ID3DXMesh;
                                   dwTextureInSemantic: DWORD;
                                   dwTextureInIndex: DWORD;
                                   dwUPartialOutSemantic: DWORD;
                                   dwUPartialOutIndex: DWORD;
                                   dwVPartialOutSemantic: DWORD;
                                   dwVPartialOutIndex: DWORD;
                                   dwNormalOutSemantic: DWORD;
                                   dwNormalOutIndex: DWORD;
                                   dwOptions: DWORD;
                                   {CONST} pdwAdjacency: PDWORD;
                                   fPartialEdgeThreshold: Single;
                                   fSingularPointThreshold: Single;
                                   fNormalEdgeThreshold: Single;
                                   out ppMeshOut: ID3DXMesh;
                                   ppVertexMapping: PID3DXBuffer
 ): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXComputeTangentFrameEx}

//D3DXComputeTangent
//
//Computes the Tangent vectors for the TexStage texture coordinates
//and places the results in the TANGENT[TangentIndex] specified in the meshes' DECL
//puts the binorm in BINORM[BinormIndex] also specified in the decl.
//
//If neither the binorm or the tangnet are in the meshes declaration,
//the function will fail. 
//
//If a tangent or Binorm field is in the Decl, but the user does not
//wish D3DXComputeTangent to replace them, then D3DX_DEFAULT specified
//in the TangentIndex or BinormIndex will cause it to ignore the specified 
//semantic.
//
//Wrap should be specified if the texture coordinates wrap.

function D3DXComputeTangent(
  Mesh: ID3DXMesh;
  TexStage: DWORD;
  TangentIndex: DWORD;
  BinormIndex: DWORD;
  Wrap: DWORD;
  Adjacency: PDWORD): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXComputeTangent}

//============================================================================
//
// UVAtlas apis
//
//============================================================================
type
  TD3DXUVAtlasCB = function (fPercentDone: Single; lpUserContext: Pointer): HRESULT; stdcall;
  {$NODEFINE TD3DXUVAtlasCB}
  {$HPPEMIT 'typedef LPD3DXUVATLASCB TD3DXUVAtlasCB;'}

// This function creates atlases for meshes. There are two modes of operation,
// either based on the number of charts, or the maximum allowed stretch. If the
// maximum allowed stretch is 0, then each triangle will likely be in its own
// chart.

//
// The parameters are as follows:
//  pMesh - Input mesh to calculate an atlas for. This must have a position
//          channel and at least a 2-d texture channel.
//  uMaxChartNumber - The maximum number of charts required for the atlas.
//                    If this is 0, it will be parameterized based solely on
//                    stretch.
//  fMaxStretch - The maximum amount of stretch, if 0, no stretching is allowed,
//                if 1, then any amount of stretching is allowed.
//  uWidth - The width of the texture the atlas will be used on.
//  uHeight - The height of the texture the atlas will be used on.
//  fGutter - The minimum distance, in texels between two charts on the atlas.
//            this gets scaled by the width, so if fGutter is 2.5, and it is
//            used on a 512x512 texture, then the minimum distance will be
//            2.5 / 512 in u-v space.
//  dwTextureIndex - Specifies which texture coordinate to write to in the
//                   output mesh (which is cloned from the input mesh). Useful
//                   if your vertex has multiple texture coordinates.
//  pdwAdjacency - a pointer to an array with 3 DWORDs per face, indicating
//                 which triangles are adjacent to each other.
//  pdwFalseEdgeAdjacency - a pointer to an array with 3 DWORDS per face, indicating
//                          at each face, whether an edge is a false edge or not (using
//                          the same ordering as the adjacency data structure). If this
//                          is NULL, then it is assumed that there are no false edges. If
//                          not NULL, then a non-false edge is indicated by -1 and a false
//                          edge is indicated by any other value (it is not required, but
//                          it may be useful for the caller to use the original adjacency
//                          value). This allows you to parameterize a mesh of quads, and
//                          the edges down the middle of each quad will not be cut when
//                          parameterizing the mesh.
//  pfIMTArray - a pointer to an array with 3 FLOATs per face, describing the
//               integrated metric tensor for that face. This lets you control
//               the way this triangle may be stretched in the atlas. The IMT
//               passed in will be 3 floats (a,b,c) and specify a symmetric
//               matrix (a b) that, given a vector (s,t), specifies the
//                      (b c)
//               distance between a vector v1 and a vector v2 = v1 + (s,t) as
//               sqrt((s, t) * M * (s, t)^T).
//               In other words, this lets one specify the magnitude of the
//               stretch in an arbitrary direction in u-v space. For example
//               if a = b = c = 1, then this scales the vector (1,1) by 2, and
//               the vector (1,-1) by 0. Note that this is multiplying the edge
//               length by the square of the matrix, so if you want the face to
//               stretch to twice its
//               size with no shearing, the IMT value should be (2, 0, 2), which
//               is just the identity matrix times 2.
//               Note that this assumes you have an orientation for the triangle
//               in some 2-D space. For D3DXUVAtlas, this space is created by
//               letting S be the direction from the first to the second
//               vertex, and T be the cross product between the normal and S.
//
//  pStatusCallback - Since the atlas creation process can be very CPU intensive,
//                    this allows the programmer to specify a function to be called
//                    periodically, similarly to how it is done in the PRT simulation
//                    engine.
//  fCallbackFrequency - This lets you specify how often the callback will be
//                       called. A decent default should be 0.0001f.
//  pUserContext - a void pointer to be passed back to the callback function
//  dwOptions - A combination of flags in the D3DXUVATLAS enum
//  ppMeshOut - A pointer to a location to store a pointer for the newly created
//              mesh.
//  ppFacePartitioning - A pointer to a location to store a pointer for an array,
//                       one DWORD per face, giving the final partitioning
//                       created by the atlasing algorithm.
//  ppVertexRemapArray - A pointer to a location to store a pointer for an array,
//                       one DWORD per vertex, giving the vertex it was copied
//                       from, if any vertices needed to be split.
//  pfMaxStretchOut - A location to store the maximum stretch resulting from the
//                    atlasing algorithm.
//  puNumChartsOut - A location to store the number of charts created, or if the
//                   maximum number of charts was too low, this gives the minimum
//                    number of charts needed to create an atlas.

function D3DXUVAtlasCreate(
  pMesh: ID3DXMesh;
  uMaxChartNumber: LongWord;
  fMaxStretch: Single;
  uWidth: LongWord;
  uHeight: LongWord;
  fGutter: Single;
  dwTextureIndex: DWORD;
  {CONST} pdwAdjacency: PDWORD;
  {CONST} pdwFalseEdgeAdjacency: PDWORD;
  {CONST} pfIMTArray: PSingle;
  pStatusCallback: TD3DXUVAtlasCB;
  fCallbackFrequency: Single;
  pUserContext: Pointer;
  dwOptions: TD3DXUVAtlas;
  out ppMeshOut: ID3DXMesh;
  ppFacePartitioning: PID3DXBuffer;
  ppVertexRemapArray: PID3DXBuffer;
  pfMaxStretchOut: PSingle;
  puNumChartsOut: PLongWord): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXUVAtlasCreate}

// This has the same exact arguments as Create, except that it does not perform the
// final packing step. This method allows one to get a partitioning out, and possibly
// modify it before sending it to be repacked. Note that if you change the
// partitioning, you'll also need to calculate new texture coordinates for any faces
// that have switched charts.
//
// The partition result adjacency output parameter is meant to be passed to the
// UVAtlasPack function, this adjacency cuts edges that are between adjacent
// charts, and also can include cuts inside of a chart in order to make it
// equivalent to a disc. For example:
//
// _______
// | ___ |
// | |_| |
// |_____|
//
// In order to make this equivalent to a disc, we would need to add a cut, and it
// Would end up looking like:
// _______
// | ___ |
// | |_|_|
// |_____|
//
// The resulting partition adjacency parameter cannot be NULL, because it is
// required for the packing step.



function D3DXUVAtlasPartition(
  pMesh: ID3DXMesh;
  uMaxChartNumber: LongWord;
  fMaxStretch: Single;
  dwTextureIndex: DWORD;
  {CONST} pdwAdjacency: PDWORD;
  {CONST} pdwFalseEdgeAdjacency: PDWORD;
  {CONST} pfIMTArray: PSingle;
  pStatusCallback: TD3DXUVAtlasCB;
  fCallbackFrequency: Single;
  pUserContext: Pointer;
  dwOptions: TD3DXUVAtlas;
  out ppMeshOut: ID3DXMesh;
  ppFacePartitioning: PID3DXBuffer;
  ppVertexRemapArray: PID3DXBuffer;
  ppPartitionResultAdjacency: PID3DXBuffer;
  pfMaxStretchOut: PSingle;
  puNumChartsOut: PLongWord): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXUVAtlasPartition}

// This takes the face partitioning result from Partition and packs it into an
// atlas of the given size. pdwPartitionResultAdjacency should be derived from
// the adjacency returned from the partition step. This value cannot be NULL
// because Pack needs to know where charts were cut in the partition step in
// order to find the edges of each chart.
// The options parameter is currently reserved.
function D3DXUVAtlasPack(
  pMesh: ID3DXMesh;
  uWidth: LongWord;
  uHeight: LongWord;
  fGutter: Single;
  dwTextureIndex: DWORD;
  {CONST} pdwPartitionResultAdjacency: PDWORD;
  pStatusCallback: TD3DXUVAtlasCB;
  fCallbackFrequency: Single;
  pUserContext: Pointer;
  dwOptions: TD3DXUVAtlas;
  pFacePartitioning: ID3DXBuffer): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXUVAtlasPack}


//============================================================================
//
// IMT Calculation apis
//
// These functions all compute the Integrated Metric Tensor for use in the
// UVAtlas API. They all calculate the IMT with respect to the canonical
// triangle, where the coordinate system is set up so that the u axis goes
// from vertex 0 to 1 and the v axis is N x u. So, for example, the second
// vertex's canonical uv coordinates are (d,0) where d is the distance between
// vertices 0 and 1. This way the IMT does not depend on the parameterization
// of the mesh, and if the signal over the surface doesn't change, then
// the IMT doesn't need to be recalculated.
//============================================================================

type
  // This callback is used by D3DXComputeIMTFromSignal.
  //
  // uv               - The texture coordinate for the vertex.
  // uPrimitiveID     - Face ID of the triangle on which to compute the signal.
  // uSignalDimension - The number of floats to store in pfSignalOut.
  // pUserData        - The pUserData pointer passed in to ComputeIMTFromSignal.
  // pfSignalOut      - A pointer to where to store the signal data.
  TD3DXIMTSignalCallback = function (const uv: PD3DXVector2; uPrimitiveID: LongWord;
    uSignalDimension: LongWord; pUserData: Pointer; pfSignalOut: PSingle): HRESULT; stdcall;
  {$NODEFINE TD3DXIMTSignalCallback}
  {$HPPEMIT 'typedef LPD3DXIMTSIGNALCALLBACK TD3DXIMTSignalCallback;'}

// This function is used to calculate the IMT from per vertex data. It sets
// up a linear system over the triangle, solves for the jacobian J, then
// constructs the IMT from that (J^TJ).
// This function allows you to calculate the IMT based off of any value in a
// mesh (color, normal, etc) by specifying the correct stride of the array.
// The IMT computed will cause areas of the mesh that have similar values to
// take up less space in the texture.
//
// pMesh            - The mesh to calculate the IMT for.
// pVertexSignal    - A float array of size uSignalStride * v, where v is the
//                    number of vertices in the mesh.
// uSignalDimension - How many floats per vertex to use in calculating the IMT.
// uSignalStride    - The number of bytes per vertex in the array. This must be
//                    a multiple of sizeof(float)
// ppIMTData        - Where to store the buffer holding the IMT data

function D3DXComputeIMTFromPerVertexSignal(
  pMesh: ID3DXMesh;
  const pfVertexSignal: PSingle; // uSignalDimension floats per vertex
  uSignalDimension: LongWord;
  uSignalStride: LongWord;       // stride of signal in bytes
  dwOptions: DWORD;              // reserved for future use
  pStatusCallback: TD3DXUVAtlasCB;
  pUserContext: Pointer;
  out ppIMTData: ID3DXBuffer): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXComputeIMTFromPerVertexSignal}

// This function is used to calculate the IMT from data that varies over the
// surface of the mesh (generally at a higher frequency than vertex data).
// This function requires the mesh to already be parameterized (so it already
// has texture coordinates). It allows the user to define a signal arbitrarily
// over the surface of the mesh.
//
// pMesh            - The mesh to calculate the IMT for.
// dwTextureIndex   - This describes which set of texture coordinates in the
//                    mesh to use.
// uSignalDimension - How many components there are in the signal.
// fMaxUVDistance   - The subdivision will continue until the distance between
//                    all vertices is at most fMaxUVDistance.
// dwOptions        - reserved for future use
// pSignalCallback  - The callback to use to get the signal.
// pUserData        - A pointer that will be passed in to the callback.
// ppIMTData        - Where to store the buffer holding the IMT data
function D3DXComputeIMTFromSignal(
  pMesh: ID3DXMesh;
  dwTextureIndex: DWORD;
  uSignalDimension: LongWord;
  fMaxUVDistance: Single;
  dwOptions: DWORD; // reserved for future use
  pSignalCallback: TD3DXIMTSignalCallback;
  pUserData: Pointer;
  pStatusCallback: TD3DXUVAtlasCB;
  pUserContext: Pointer;
  out ppIMTData: ID3DXBuffer): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXComputeIMTFromSignal}

// This function is used to calculate the IMT from texture data. Given a texture
// that maps over the surface of the mesh, the algorithm computes the IMT for
// each face. This will cause large areas that are very similar to take up less
// room when parameterized with UVAtlas. The texture is assumed to be
// interpolated over the mesh bilinearly.
//
// pMesh            - The mesh to calculate the IMT for.
// pTexture         - The texture to load data from.
// dwTextureIndex   - This describes which set of texture coordinates in the
//                    mesh to use.
// dwOptions        - Combination of one or more D3DXIMT flags.
// ppIMTData        - Where to store the buffer holding the IMT data
function D3DXComputeIMTFromTexture(
  pMesh: ID3DXMesh;
  pTexture: IDirect3DTexture9;
  dwTextureIndex: DWORD;
  dwOptions: DWORD;
  pStatusCallback: TD3DXUVAtlasCB;
  pUserContext: Pointer;
  out ppIMTData: ID3DXBuffer): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXComputeIMTFromTexture}

// This function is very similar to ComputeIMTFromTexture, but it uses a
// float array to pass in the data, and it can calculate higher dimensional
// values than 4.
//
// pMesh            - The mesh to calculate the IMT for.
// dwTextureIndex   - This describes which set of texture coordinates in the
//                    mesh to use.
// pfFloatArray     - a pointer to a float array of size
//                    uWidth*uHeight*uComponents
// uWidth           - The width of the texture
// uHeight          - The height of the texture
// uSignalDimension - The number of floats per texel in the signal
// uComponents      - The number of floats in each texel
// dwOptions        - Combination of one or more D3DXIMT flags
// ppIMTData        - Where to store the buffer holding the IMT data
function D3DXComputeIMTFromPerTexelSignal(
  pMesh: ID3DXMesh;
  dwTextureIndex: DWORD;
  pfTexelSignal: PSingle;
  uWidth: LongWord;
  uHeight: LongWord;
  uSignalDimension: LongWord;
  uComponents: LongWord;
  dwOptions: DWORD;
  pStatusCallback: TD3DXUVAtlasCB;
  pUserContext: Pointer;
  out ppIMTData: ID3DXBuffer): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXComputeIMTFromPerTexelSignal}

function D3DXConvertMeshSubsetToSingleStrip(
  MeshIn: ID3DXBaseMesh;
  AttribId: DWord;
  IBOptions: DWord;
  out ppIndexBuffer: IDirect3DIndexBuffer9;
  pNumIndices: PDWord): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXConvertMeshSubsetToSingleStrip}

function D3DXConvertMeshSubsetToStrips(
  MeshIn: ID3DXBaseMesh;
  AttribId: DWord;
  IBOptions: DWord;
  out ppIndexBuffer: IDirect3DIndexBuffer9;
  pNumIndices: PDWord;
  ppStripLengths: PID3DXBuffer;
  pNumStrips: PDWord): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXConvertMeshSubsetToStrips}


//============================================================================
//
//  D3DXOptimizeFaces:
//  --------------------
//  Generate a face remapping for a triangle list that more effectively utilizes
//    vertex caches.  This optimization is identical to the one provided
//    by ID3DXMesh::Optimize with the hardware independent option enabled.
//
//  Parameters:
//   pbIndices
//      Triangle list indices to use for generating a vertex ordering
//   NumFaces
//      Number of faces in the triangle list
//   NumVertices
//      Number of vertices referenced by the triangle list
//   b32BitIndices
//      TRUE if indices are 32 bit, FALSE if indices are 16 bit
//   pFaceRemap
//      Destination buffer to store face ordering
//      The number stored for a given element is where in the new ordering
//        the face will have come from.  See ID3DXMesh::Optimize for more info.
//
//============================================================================
function D3DXOptimizeFaces(
  pbIndices: Pointer;
  cFaces: LongWord;
  cVertices: LongWord;
  b32BitIndices: BOOL;
  pFaceRemap: PDWORD): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXOptimizeFaces}

//============================================================================
//
//  D3DXOptimizeVertices:
//  --------------------
//  Generate a vertex remapping to optimize for in order use of vertices for 
//    a given set of indices.  This is commonly used after applying the face
//    remap generated by D3DXOptimizeFaces
//
//  Parameters:
//   pbIndices
//      Triangle list indices to use for generating a vertex ordering
//   NumFaces
//      Number of faces in the triangle list
//   NumVertices
//      Number of vertices referenced by the triangle list
//   b32BitIndices
//      TRUE if indices are 32 bit, FALSE if indices are 16 bit
//   pVertexRemap
//      Destination buffer to store vertex ordering
//      The number stored for a given element is where in the new ordering
//        the vertex will have come from.  See ID3DXMesh::Optimize for more info.
//
//============================================================================
function D3DXOptimizeVertices(
  pbIndices: Pointer;
  cFaces: LongWord;
  cVertices: LongWord;
  b32BitIndices: BOOL;
  pVertexRemap: PDWORD): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXOptimizeVertices}


//===========================================================================
//
//  Data structures for Spherical Harmonic Precomputation
//
//
//============================================================================

type
  PD3DXSHCompressQualityType = ^TD3DXSHCompressQualityType;
  _D3DXSHCOMPRESSQUALITYTYPE = (
    D3DXSHCQUAL_FASTLOWQUALITY  = 1,
    D3DXSHCQUAL_SLOWHIGHQUALITY = 2
  );
  {$EXTERNALSYM _D3DXSHCOMPRESSQUALITYTYPE}
  D3DXSHCOMPRESSQUALITYTYPE = _D3DXSHCOMPRESSQUALITYTYPE;
  {$EXTERNALSYM D3DXSHCOMPRESSQUALITYTYPE}
  TD3DXSHCompressQualityType = _D3DXSHCOMPRESSQUALITYTYPE;

  _D3DXSHGPUSIMOPT = DWORD;
  {$EXTERNALSYM _D3DXSHGPUSIMOPT}
  D3DXSHGPUSIMOPT = _D3DXSHGPUSIMOPT;
  {$EXTERNALSYM D3DXSHGPUSIMOPT}
  TD3DXSHGPUSimOpt = _D3DXSHGPUSIMOPT;

const
  //Clootie: These should not be enums as it's correct to use:
  // D3DXSHGPUSIMOPT_SHADOWRES512 or D3DXSHGPUSIMOPT_HIGHQUALITY
  D3DXSHGPUSIMOPT_SHADOWRES256  = 1;
  {$EXTERNALSYM D3DXSHGPUSIMOPT_SHADOWRES256}
  D3DXSHGPUSIMOPT_SHADOWRES512  = 0;
  {$EXTERNALSYM D3DXSHGPUSIMOPT_SHADOWRES512}
  D3DXSHGPUSIMOPT_SHADOWRES1024 = 2;
  {$EXTERNALSYM D3DXSHGPUSIMOPT_SHADOWRES1024}
  D3DXSHGPUSIMOPT_SHADOWRES2048 = 3;
  {$EXTERNALSYM D3DXSHGPUSIMOPT_SHADOWRES2048}

  D3DXSHGPUSIMOPT_HIGHQUALITY = 4;
  {$EXTERNALSYM D3DXSHGPUSIMOPT_HIGHQUALITY}

  // for all properties that are colors the luminance is computed
  // if the simulator is run with a single channel using the following
  // formula:  R * 0.2125 + G * 0.7154 + B * 0.0721

type
  PPD3DXSHMaterial = ^PD3DXSHMaterial;
  PD3DXSHMaterial = ^TD3DXSHMaterial;
  _D3DXSHMATERIAL = record
    Diffuse: TD3DColorValue;  // Diffuse albedo of the surface.  (Ignored if object is a Mirror)
    bMirror: BOOL;  // Must be set to FALSE.  bMirror == TRUE not currently supported
    bSubSurf: BOOL; // true if the object does subsurface scattering - can't do this and be a mirror

    // subsurface scattering parameters
    {Clootie: taken from: "A Practical Model for Subsurface Light Transport", Jensen et al Siggraph 2001}
    RelativeIndexOfRefraction: Single;
    Absorption: TD3DColorValue;
    ReducedScattering: TD3DColorValue;
  end;
  {$EXTERNALSYM _D3DXSHMATERIAL}
  D3DXSHMATERIAL = _D3DXSHMATERIAL;
  {$EXTERNALSYM D3DXSHMATERIAL}
  TD3DXSHMaterial = _D3DXSHMATERIAL;

  // allocated in D3DXSHPRTCompSplitMeshSC
  // vertices are duplicated into multiple super clusters but
  // only have a valid status in one super cluster (fill in the rest)

  PD3DXSHPRTSplitMeshVertData = ^TD3DXSHPRTSplitMeshVertData;
  _D3DXSHPRTSPLITMESHVERTDATA = record
    uVertRemap: LongWord;     // vertex in original mesh this corresponds to
    uSubCluster: LongWord;    // cluster index relative to super cluster
    ucVertStatus: Byte;       // 1 if vertex has valid data, 0 if it is "fill"
  end;
  {$EXTERNALSYM _D3DXSHPRTSPLITMESHVERTDATA}
  D3DXSHPRTSPLITMESHVERTDATA = _D3DXSHPRTSPLITMESHVERTDATA;
  {$EXTERNALSYM D3DXSHPRTSPLITMESHVERTDATA}
  TD3DXSHPRTSplitMeshVertData = _D3DXSHPRTSPLITMESHVERTDATA;

  // used in D3DXSHPRTCompSplitMeshSC
  // information for each super cluster that maps into face/vert arrays

  PD3DXSHPRTSplitMeshClusterData = ^TD3DXSHPRTSplitMeshClusterData;
  _D3DXSHPRTSPLITMESHCLUSTERDATA = record
    uVertStart: LongWord;     // initial index into remapped vertex array
    uVertLength: LongWord;    // number of vertices in this super cluster

    uFaceStart: LongWord;     // initial index into face array
    uFaceLength: LongWord;    // number of faces in this super cluster

    uClusterStart: LongWord;  // initial index into cluster array
    uClusterLength: LongWord; // number of clusters in this super cluster
  end;
  {$EXTERNALSYM _D3DXSHPRTSPLITMESHCLUSTERDATA}
  D3DXSHPRTSPLITMESHCLUSTERDATA = _D3DXSHPRTSPLITMESHCLUSTERDATA;
  {$EXTERNALSYM D3DXSHPRTSPLITMESHCLUSTERDATA}
  TD3DXSHPRTSplitMeshClusterData = _D3DXSHPRTSPLITMESHCLUSTERDATA;

  // call back function for simulator
  // return S_OK to keep running the simulator - anything else represents
  // failure and the simulator will abort.

  TD3DXSHPRTSimCB = function (fPercentDone: Single; lpUserContext: Pointer): HRESULT; stdcall;
  {$NODEFINE TD3DXSHPRTSimCB}
  {$HPPEMIT 'typedef LPD3DXSHPRTSIMCB TD3DXSHPRTSimCB;'}



// interfaces for PRT buffers/simulator

// interface definitions


type
  ID3DXTextureGutterHelper = interface;

  // Buffer interface - contains "NumSamples" samples
  // each sample in memory is stored as NumCoeffs scalars per channel (1 or 3)
  // Same interface is used for both Vertex and Pixel PRT buffers

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXPRTBuffer);'}
  {$EXTERNALSYM ID3DXPRTBuffer}
  ID3DXPRTBuffer = interface(IUnknown)
    ['{F1827E47-00A8-49cd-908C-9D11955F8728}']
    // ID3DXPRTBuffer
    function GetNumSamples: LongWord; stdcall;
    function GetNumCoeffs: LongWord; stdcall;
    function GetNumChannels: LongWord; stdcall;

    function IsTexture: BOOL; stdcall;
    function GetWidth: LongWord; stdcall;
    function GetHeight: LongWord; stdcall;

    // changes the number of samples allocated in the buffer
    function Resize(NewSize: LongWord): HResult; stdcall;

    // ppData will point to the memory location where sample Start begins
    // pointer is valid for at least NumSamples samples
    function LockBuffer(Start: LongWord; NumSamples: LongWord; out ppData: PSingle): HResult; stdcall;
    function UnlockBuffer: HResult; stdcall;

    // every scalar in buffer is multiplied by Scale
    function ScaleBuffer(Scale: Single): HResult; stdcall;

    // every scalar contains the sum of this and pBuffers values
    // pBuffer must have the same storage class/dimensions
    function AddBuffer(pBuffer: ID3DXPRTBuffer): HResult; stdcall;

    // GutterHelper (described below) will fill in the gutter
    // regions of a texture by interpolating "internal" values
    function AttachGH(pGH: ID3DXTextureGutterHelper): HResult; stdcall;
    function ReleaseGH: HResult; stdcall;

    // Evaluates attached gutter helper on the contents of this buffer
    function EvalGH: HResult; stdcall;

    // extracts a given channel into texture pTexture
    // NumCoefficients starting from StartCoefficient are copied
    function ExtractTexture(Channel, StartCoefficient, NumCoefficients: LongWord;
        pTexture: IDirect3DTexture9): HResult; stdcall;

    // extracts NumCoefficients coefficients into mesh - only applicable on single channel
    // buffers, otherwise just lockbuffer and copy data.  With SHPRT data NumCoefficients
    // should be Order^2
    function ExtractToMesh(NumCoefficients: LongWord; Usage: TD3DDeclUsage;
        UsageIndexStart: LongWord; pScene: ID3DXMesh): HResult; stdcall;
  end;


  // compressed buffers stored a compressed version of a PRTBuffer

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXPRTCompBuffer);'}
  {$EXTERNALSYM ID3DXPRTCompBuffer}
  ID3DXPRTCompBuffer = interface(IUnknown)
    ['{A758D465-FE8D-45ad-9CF0-D01E56266A07}']
    // ID3DPRTCompBuffer

    // NumCoeffs and NumChannels are properties of input buffer
    function GetNumSamples: LongWord; stdcall;
    function GetNumCoeffs: LongWord; stdcall;
    function GetNumChannels: LongWord; stdcall;

    function IsTexture: BOOL; stdcall;
    function GetWidth: LongWord; stdcall;
    function GetHeight: LongWord; stdcall;

    // number of clusters, and PCA vectors per-cluster
    function GetNumClusters: LongWord; stdcall;
    function GetNumPCA: LongWord; stdcall;

    // normalizes PCA weights so that they are between [-1,1]
    // basis vectors are modified to reflect this
    function NormalizeData: HResult; stdcall;

    // copies basis vectors for cluster "Cluster" into pClusterBasis
    // (NumPCA+1)*NumCoeffs*NumChannels floats
    function ExtractBasis(Cluster: LongWord; pClusterBasis: PSingle): HResult; stdcall;

    // UINT per sample - which cluster it belongs to
    function ExtractClusterIDs(pClusterIDs: PLongWord): HResult; stdcall;

    // copies NumExtract PCA projection coefficients starting at StartPCA
    // into pPCACoefficients - NumSamples*NumExtract floats copied
    function ExtractPCA(StartPCA: LongWord; NumExtract: LongWord; pPCACoefficients: PSingle): HResult; stdcall;

    // copies NumPCA projection coefficients starting at StartPCA
    // into pTexture - should be able to cope with signed formats
    function ExtractTexture(StartPCA, NumpPCA: LongWord; pTexture: IDirect3DTexture9): HResult; stdcall;

    // copies NumPCA projection coefficients into mesh pScene
    // Usage is D3DDECLUSAGE where coefficients are to be stored
    // UsageIndexStart is starting index
    function ExtractToMesh(NumPCA: LongWord; Usage: D3DDECLUSAGE;
        UsageIndexStart: LongWord; pScene: ID3DXMesh): HResult; stdcall;
  end;


  // ID3DXTextureGutterHelper will build and manage
  // "gutter" regions in a texture - this will allow for
  // bi-linear interpolation to not have artifacts when rendering
  // It generates a map (in texture space) where each texel
  // is in one of 3 states:
  //   0  Invalid - not used at all
  //   1  Inside triangle
  //   2  Gutter texel
  //   4  represents a gutter texel that will be computed during PRT
  // For each Inside/Gutter texel it stores the face it
  // belongs to and barycentric coordinates for the 1st two
  // vertices of that face.  Gutter vertices are assigned to
  // the closest edge in texture space.
  //
  // When used with PRT this requires a unique parameterization
  // of the model - every texel must correspond to a single point
  // on the surface of the model and vice versa

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXTextureGutterHelper);'}
  {$EXTERNALSYM ID3DXTextureGutterHelper}
  ID3DXTextureGutterHelper = interface(IUnknown)
    ['{838F01EC-9729-4527-AADB-DF70ADE7FEA9}']
    // ID3DXTextureGutterHelper

    // dimensions of texture this is bound too
    function GetWidth: LongWord; stdcall;
    function GetHeight: LongWord; stdcall;


    // Applying gutters recomputes all of the gutter texels of class "2"
    // based on texels of class "1" or "4"

    // Applies gutters to a raw float buffer - each texel is NumCoeffs floats
    // Width and Height must match GutterHelper
    function ApplyGuttersFloat(pDataIn: PSingle; NumCoeffs, Width, Height: LongWord): HResult; stdcall;

    // Applies gutters to pTexture
    // Dimensions must match GutterHelper
    function ApplyGuttersTex(pTexture: IDirect3DTexture9): HResult; stdcall;

    // Applies gutters to a D3DXPRTBuffer
    // Dimensions must match GutterHelper
    function ApplyGuttersPRT(pBuffer: ID3DXPRTBuffer): HResult; stdcall;

    // Resamples a texture from a mesh onto this gutterhelpers
    // parameterization.  It is assumed that the UV coordinates
    // for this gutter helper are in TEXTURE 0 (usage/usage index)
    // and the texture coordinates should all be within [0,1] for
    // both sets.
    //
    // pTextureIn - texture represented using parameterization in pMeshIn
    // pMeshIn    - Mesh with texture coordinates that represent pTextureIn
    //              pTextureOut texture coordinates are assumed to be in
    //              TEXTURE 0
    // Usage      - field in DECL for pMeshIn that stores texture coordinates
    //              for pTextureIn
    // UsageIndex - which index for Usage above for pTextureIn
    // pTextureOut- Resampled texture
    //
    // Usage would generally be D3DDECLUSAGE_TEXCOORD  and UsageIndex other than zero
    function ResampleTex(const pTextureIn: IDirect3DTexture9; const pMeshIn: ID3DXMesh;
        Usage: TD3DDeclUsage; UsageIndex: LongWord; const pTextureOut: IDirect3DTexture9): HResult; stdcall;

    // the routines below provide access to the data structures
    // used by the Apply functions

    // face map is a UINT per texel that represents the
    // face of the mesh that texel belongs too -
    // only valid if same texel is valid in pGutterData
    // pFaceData must be allocated by the user
    function GetFaceMap(pFaceData: PLongWord): HResult; stdcall;

    // BaryMap is a D3DXVECTOR2 per texel
    // the 1st two barycentric coordinates for the corresponding
    // face (3rd weight is always 1-sum of first two)
    // only valid if same texel is valid in pGutterData
    // pBaryData must be allocated by the user
    function GetBaryMap(pBaryData: PD3DXVector2): HResult; stdcall;

    // TexelMap is a D3DXVECTOR2 per texel that
    // stores the location in pixel coordinates where the
    // corresponding texel is mapped
    // pTexelData must be allocated by the user
    function GetTexelMap(pTexelData: PD3DXVector2): HResult; stdcall;

    // GutterMap is a BYTE per texel
    // 0/1/2 for Invalid/Internal/Gutter texels
    // 4 represents a gutter texel that will be computed
    // during PRT
    // pGutterData must be allocated by the user
    function GetGutterMap(pGutterData: PByte): HResult; stdcall;

    // face map is a UINT per texel that represents the
    // face of the mesh that texel belongs too -
    // only valid if same texel is valid in pGutterData
    function SetFaceMap(pFaceData: PLongWord): HResult; stdcall;

    // BaryMap is a D3DXVECTOR2 per texel
    // the 1st two barycentric coordinates for the corresponding
    // face (3rd weight is always 1-sum of first two)
    // only valid if same texel is valid in pGutterData
    function SetBaryMap(pBaryData: PD3DXVector2): HResult; stdcall;

    // TexelMap is a D3DXVECTOR2 per texel that
    // stores the location in pixel coordinates where the
    // corresponding texel is mapped
    function SetTexelMap(pTexelData: PD3DXVector2): HResult; stdcall;

    // GutterMap is a BYTE per texel
    // 0/1/2 for Invalid/Internal/Gutter texels
    // 4 represents a gutter texel that will be computed
    // during PRT
    function SetGutterMap(pGutterData: PByte): HResult; stdcall;
  end;



  // ID3DXPRTEngine is used to compute a PRT simulation
  // Use the following steps to compute PRT for SH
  // (1) create an interface (which includes a scene)
  // (2) call SetSamplingInfo
  // (3) [optional] Set MeshMaterials/albedo's (required if doing bounces)
  // (4) call ComputeDirectLightingSH
  // (5) [optional] call ComputeBounce
  // repeat step 5 for as many bounces as wanted.
  // if you want to model subsurface scattering you
  // need to call ComputeSS after direct lighting and
  // each bounce.
  // If you want to bake the albedo into the PRT signal, you
  // must call MutliplyAlbedo, otherwise the user has to multiply
  // the albedo themselves.  Not multiplying the albedo allows you
  // to model albedo variation at a finer scale then illumination, and
  // can result in better compression results.
  // Luminance values are computed from RGB values using the following
  // formula:  R * 0.2125 + G * 0.7154 + B * 0.0721

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXPRTEngine);'}
  {$EXTERNALSYM ID3DXPRTEngine}
  ID3DXPRTEngine = interface(IUnknown)
    ['{683A4278-CD5F-4d24-90AD-C4E1B6855D53}']
    // ID3DXPRTEngine

    // material functions

    // This sets a material per attribute in the scene mesh and it is
    // the only way to specify subsurface scattering parameters.  if
    // bSetAlbedo is FALSE, NumChannels must match the current
    // configuration of the PRTEngine.  If you intend to change
    // NumChannels (through some other SetAlbedo function) it must
    // happen before SetMeshMaterials is called.
    //
    // NumChannels 1 implies "grayscale" materials, set this to 3 to enable
    //  color bleeding effects
    // bSetAlbedo sets albedo from material if TRUE - which clobbers per texel/vertex
    //  albedo that might have been set before.  FALSE won't clobber.
    // fLengthScale is used for subsurface scattering - scene is mapped into a 1mm unit cube
    //  and scaled by this amount
    function SetMeshMaterials(const ppMaterials: PPD3DXSHMaterial; NumMeshes, NumChannels: LongWord;
        bSetAlbedo: BOOL; fLengthScale: Single): HResult; stdcall;

    // setting albedo per-vertex or per-texel over rides the albedos stored per mesh
    // but it does not over ride any other settings

    // sets an albedo to be used per vertex - the albedo is represented as a float
    // pDataIn input pointer (pointint to albedo of 1st sample)
    // NumChannels 1 implies "grayscale" materials, set this to 3 to enable
    //  color bleeding effects
    // Stride - stride in bytes to get to next samples albedo
    function SetPerVertexAlbedo(const pDataIn: Pointer; NumChannels, Stride: LongWord): HResult; stdcall;

    // represents the albedo per-texel instead of per-vertex (even if per-vertex PRT is used)
    // pAlbedoTexture - texture that stores the albedo (dimension arbitrary)
    // NumChannels 1 implies "grayscale" materials, set this to 3 to enable
    //  color bleeding effects
    // pGH - optional gutter helper, otherwise one is constructed in computation routines and
    //  destroyed (if not attached to buffers)
    function SetPerTexelAlbedo(pAlbedoTexture: IDirect3DTexture9; NumChannels: LongWord; pGH: ID3DXTextureGutterHelper): HResult; stdcall;

    // gets the per-vertex albedo
    function GetVertexAlbedo(pVertColors: PD3DXColor; NumVerts: LongWord): HResult; stdcall;

    // If pixel PRT is being computed normals default to ones that are interpolated
    // from the vertex normals.  This specifies a texture that stores an object
    // space normal map instead (must use a texture format that can represent signed values)
    // pNormalTexture - normal map, must be same dimensions as PRTBuffers, signed
    function SetPerTexelNormal(pNormalTexture: IDirect3DTexture9): HResult; stdcall;

    // Copies per-vertex albedo from mesh
    // pMesh - mesh that represents the scene.  It must have the same
    //  properties as the mesh used to create the PRTEngine
    // Usage - D3DDECLUSAGE to extract albedos from
    // NumChannels 1 implies "grayscale" materials, set this to 3 to enable
    //  color bleeding effects
    function ExtractPerVertexAlbedo(pMesh: ID3DXMesh; Usage: TD3DDeclUsage; NumChannels: LongWord): HResult; stdcall;

    // Resamples the input buffer into the output buffer
    // can be used to move between per-vertex and per-texel buffers.  This can also be used
    // to convert single channel buffers to 3-channel buffers and vice-versa.
    function ResampleBuffer(pBufferIn, pBufferOut: ID3DXPRTBuffer): HResult; stdcall;

    // Returns the scene mesh - including modifications from adaptive spatial sampling
    // The returned mesh only has positions, normals and texture coordinates (if defined)
    // pD3DDevice - d3d device that will be used to allocate the mesh
    // pFaceRemap - each face has a pointer back to the face on the original mesh that it comes from
    //  if the face hasn't been subdivided this will be an identity mapping
    // pVertRemap - each vertex contains 3 vertices that this is a linear combination of
    // pVertWeights - weights for each of above indices (sum to 1.0f)
    // ppMesh - mesh that will be allocated and filled
    function GetAdaptedMesh(pD3DDevice: IDirect3DDevice9; pFaceRemap, pVertRemap: PLongWord;
        pfVertWeights: PSingle; out ppMesh: ID3DXMesh): HResult; stdcall;

    // Number of vertices currently allocated (includes new vertices from adaptive sampling)
    function GetNumVerts: LongWord; stdcall;
    // Number of faces currently allocated (includes new faces)
    function GetNumFaces: LongWord; stdcall;

    // Sets the Minimum/Maximum intersection distances, this can be used to control
    // maximum distance that objects can shadow/reflect light, and help with "bad"
    // art that might have near features that you don't want to shadow.  This does not
    // apply for GPU simulations.
    //  fMin - minimum intersection distance, must be positive and less than fMax
    //  fMax - maximum intersection distance, if 0.0f use the previous value, otherwise
    //      must be strictly greater than fMin
    function SetMinMaxIntersection(fMin: Single; fMax: Single): HResult; stdcall;

    // This will subdivide faces on a mesh so that adaptively simulations can
    // use a more conservative threshold (it won't miss features.)
    // MinEdgeLength - minimum edge length that will be generated, if 0.0f a
    //  reasonable default will be used
    // MaxSubdiv - maximum level of subdivision, if 0 is specified a default
    //  value will be used (5)
    function RobustMeshRefine(MinEdgeLength: Single; MaxSubdiv: LongWord): HResult; stdcall;

    // This sets to sampling information used by the simulator.  Adaptive sampling
    // parameters are currently ignored.
    // NumRays - number of rays to shoot per sample
    // UseSphere - if TRUE uses spherical samples, otherwise samples over
    //  the hemisphere.  Should only be used with GPU and Vol computations
    // UseCosine - if TRUE uses a cosine weighting - not used for Vol computations
    //  or if only the visiblity function is desired
    // Adaptive - if TRUE adaptive sampling (angular) is used
    // AdaptiveThresh - threshold used to terminate adaptive angular sampling
    //  ignored if adaptive sampling is not set
    function SetSamplingInfo(NumRays: LongWord; UseSphere, UseCosine, Adaptive: BOOL;
        AdaptiveThresh: Single): HResult; stdcall;

    // Methods that compute the direct lighting contribution for objects
    // always represente light using spherical harmonics (SH)
    // the albedo is not multiplied by the signal - it just integrates
    // incoming light.  If NumChannels is not 1 the vector is replicated
    //
    // SHOrder - order of SH to use
    // pDataOut - PRT buffer that is generated.  Can be single channel
    function ComputeDirectLightingSH(SHOrder: LongWord; pDataOut: ID3DXPRTBuffer): HResult; stdcall;
                                       
    // Adaptive variant of above function.  This will refine the mesh
    // generating new vertices/faces to approximate the PRT signal
    // more faithfully.
    // SHOrder - order of SH to use
    // AdaptiveThresh - threshold for adaptive subdivision (in PRT vector error)
    //  if value is less then 1e-6f, 1e-6f is specified
    // MinEdgeLength - minimum edge length that will be generated
    //  if value is too small a fairly conservative model dependent value
    //  is used
    // MaxSubdiv - maximum subdivision level, if 0 is specified it 
    //  will default to 4
    // pDataOut - PRT buffer that is generated.  Can be single channel.
    function ComputeDirectLightingSHAdaptive(SHOrder: LongWord; AdaptiveThresh: Single;
        MinEdgeLength: Single; MaxSubdiv: LongWord; pDataOut: ID3DXPRTBuffer): HResult; stdcall;

    // Function that computes the direct lighting contribution for objects
    // light is always represented using spherical harmonics (SH)
    // This is done on the GPU and is much faster then using the CPU.
    // The albedo is not multiplied by the signal - it just integrates
    // incoming light.  If NumChannels is not 1 the vector is replicated.
    // ZBias/ZAngleBias are akin to parameters used with shadow zbuffers.
    // A reasonable default for both values is 0.005, but the user should
    // experiment (ZAngleBias can be zero, ZBias should not be.)
    // Callbacks should not use the Direct3D9Device the simulator is using.
    // SetSamplingInfo must be called with TRUE for UseSphere and
    // FALSE for UseCosine before this method is called.
    //
    // pD3DDevice - device used to run GPU simulator - must support PS2.0
    //  and FP render targets
    // Flags - parameters for the GPU simulator, combination of one or more
    //  D3DXSHGPUSIMOPT flags.  Only one SHADOWRES setting should be set and
    //  the defaults is 512
    // SHOrder - order of SH to use
    // ZBias - bias in normal direction (for depth test)
    // ZAngleBias - scaled by one minus cosine of angle with light (offset in depth)
    // pDataOut - PRT buffer that is filled in.  Can be single channel
    function ComputeDirectLightingSHGPU(pD3DDevice: IDirect3DDevice9; Flags: LongWord;
        SHOrder: LongWord; ZBias, ZAngleBias: Single; pDataOut: ID3DXPRTBuffer): HResult; stdcall;


    // Functions that computes subsurface scattering (using material properties)
    // Albedo is not multiplied by result.  This only works for per-vertex data
    // use ResampleBuffer to move per-vertex data into a texture and back.
    //
    // pDataIn - input data (previous bounce)
    // pDataOut - result of subsurface scattering simulation
    // pDataTotal - [optional] results can be summed into this buffer
    function ComputeSS(pDataIn, pDataOut, pDataTotal: ID3DXPRTBuffer): HResult; stdcall;

    // Adaptive version of ComputeSS.
    //
    // pDataIn - input data (previous bounce)
    // AdaptiveThresh - threshold for adaptive subdivision (in PRT vector error)
    //  if value is less then 1e-6f, 1e-6f is specified
    // MinEdgeLength - minimum edge length that will be generated
    //  if value is too small a fairly conservative model dependent value
    //  is used
    // MaxSubdiv - maximum subdivision level, if 0 is specified it
    //  will default to 4
    // pDataOut - result of subsurface scattering simulation
    // pDataTotal - [optional] results can be summed into this buffer
    function ComputeSSAdaptive(pDataIn: ID3DXPRTBuffer; AdaptiveThresh, MinEdgeLength: Single;
        MaxSubdiv: LongWord; pDataOut, pDataTotal: ID3DXPRTBuffer): HResult; stdcall;

    // computes a single bounce of inter-reflected light
    // works for SH based PRT or generic lighting
    // Albedo is not multiplied by result
    //
    // pDataIn - previous bounces data
    // pDataOut - PRT buffer that is generated
    // pDataTotal - [optional] can be used to keep a running sum
    function ComputeBounce(pDataIn, pDataOut, pDataTotal: ID3DXPRTBuffer): HResult; stdcall;

    // Adaptive version of above function.
    //
    // pDataIn - previous bounces data, can be single channel
    // AdaptiveThresh - threshold for adaptive subdivision (in PRT vector error)
    //  if value is less then 1e-6f, 1e-6f is specified
    // MinEdgeLength - minimum edge length that will be generated
    //  if value is too small a fairly conservative model dependent value
    //  is used
    // MaxSubdiv - maximum subdivision level, if 0 is specified it
    //  will default to 4
    // pDataOut - PRT buffer that is generated
    // pDataTotal - [optional] can be used to keep a running sum
    function ComputeBounceAdaptive(pDataIn: ID3DXPRTBuffer; AdaptiveThresh, MinEdgeLength: Single;
        MaxSubdiv: LongWord; pDataOut, pDataTotal: ID3DXPRTBuffer): HResult; stdcall;

    // Computes projection of distant SH radiance into a local SH radiance
    // function.  This models how direct lighting is attenuated by the
    // scene and is a form of "neighborhood transfer."  The result is
    // a linear operator (matrix) at every sample point, if you multiply
    // this matrix by the distant SH lighting coefficients you get an
    // approximation of the local incident radiance function from
    // direct lighting.  These resulting lighting coefficients can
    // than be projected into another basis or used with any rendering
    // technique that uses spherical harmonics as input.
    // SetSamplingInfo must be called with TRUE for UseSphere and
    // FALSE for UseCosine before this method is called.  
    // Generates SHOrderIn*SHOrderIn*SHOrderOut*SHOrderOut scalars 
    // per channel at each sample location.
    //
    // SHOrderIn  - Order of the SH representation of distant lighting
    // SHOrderOut - Order of the SH representation of local lighting
    // NumVolSamples  - Number of sample locations
    // pSampleLocs    - position of sample locations
    // pDataOut       - PRT Buffer that will store output results    
    function ComputeVolumeSamplesDirectSH(SHOrderIn, SHOrderOut: LongWord;
        NumVolSamples: LongWord; const pSampleLocs: PD3DXVector3; pDataOut: ID3DXPRTBuffer): HResult; stdcall;
                                    
    // At each sample location computes a linear operator (matrix) that maps
    // the representation of source radiance (NumCoeffs in pSurfDataIn)
    // into a local incident radiance function approximated with spherical 
    // harmonics.  For example if a light map data is specified in pSurfDataIn
    // the result is an SH representation of the flow of light at each sample
    // point.  If PRT data for an outdoor scene is used, each sample point
    // contains a matrix that models how distant lighting bounces of the objects
    // in the scene and arrives at the given sample point.  Combined with
    // ComputeVolumeSamplesDirectSH this gives the complete representation for
    // how light arrives at each sample point parameterized by distant lighting.
    // SetSamplingInfo must be called with TRUE for UseSphere and
    // FALSE for UseCosine before this method is called.    
    // Generates pSurfDataIn->NumCoeffs()*SHOrder*SHOrder scalars
    // per channel at each sample location.
    //
    // pSurfDataIn    - previous bounce data
    // SHOrder        - order of SH to generate projection with
    // NumVolSamples  - Number of sample locations
    // pSampleLocs    - position of sample locations
    // pDataOut       - PRT Buffer that will store output results
    function ComputeVolumeSamples(pSurfDataIn: ID3DXPRTBuffer; SHOrder: LongWord;
        NumVolSamples: LongWord; const pSampleLocs: PD3DXVector3; pDataOut: ID3DXPRTBuffer): HResult; stdcall;


    // Computes direct lighting (SH) for a point not on the mesh
    // with a given normal - cannot use texture buffers.
    //
    // SHOrder      - order of SH to use
    // NumSamples   - number of sample locations
    // pSampleLocs  - position for each sample
    // pSampleNorms - normal for each sample
    // pDataOut     - PRT Buffer that will store output results
    function ComputeSurfSamplesDirectSH(SHOrder: LongWord; NumSamples: LongWord;
        const pSampleLocs, pSampleNorms: PD3DXVector3; pDataOut: ID3DXPRTBuffer): HResult; stdcall;

    // given the solution for PRT or light maps, computes transfer vector at arbitrary
    // position/normal pairs in space
    //
    // pSurfDataIn  - input data
    // NumSamples   - number of sample locations
    // pSampleLocs  - position for each sample
    // pSampleNorms - normal for each sample
    // pDataOut     - PRT Buffer that will store output results
    // pDataTotal   - optional buffer to sum results into - can be NULL
    function ComputeSurfSamplesBounce(pSurfDataIn: ID3DXPRTBuffer; NumSamples: LongWord;
        const pSampleLocs, pSampleNorms: PD3DXVector3; pDataOut, pDataTotal: ID3DXPRTBuffer): HResult; stdcall;

    // Frees temporary data structures that can be created for subsurface scattering
    // this data is freed when the PRTComputeEngine is freed and is lazily created
    function FreeSSData: HResult; stdcall;
    
    // Frees temporary data structures that can be created for bounce simulations
    // this data is freed when the PRTComputeEngine is freed and is lazily created
    function FreeBounceData: HResult; stdcall;

    // This computes the Local Deformable PRT (LDPRT) coefficients relative to the 
    // per sample normals that minimize error in a least squares sense with respect 
    // to the input PRT data set.  These coefficients can be used with skinned/transformed 
    // normals to model global effects with dynamic objects.  Shading normals can 
    // optionally be solved for - these normals (along with the LDPRT coefficients) can
    // more accurately represent the PRT signal.  The coefficients are for zonal
    // harmonics oriented in the normal/shading normal direction.
    //
    // pDataIn  - SH PRT dataset that is input
    // SHOrder  - Order of SH to compute conv coefficients for 
    // pNormOut - Optional array of vectors (passed in) that will be filled with
    //             "shading normals", LDPRT coefficients are optimized for
    //             these normals.  This array must be the same size as the number of
    //             samples in pDataIn
    // pDataOut - Output buffer (SHOrder zonal harmonic coefficients per channel per sample)
    function ComputeLDPRTCoeffs(pDataIn: ID3DXPRTBuffer; SHOrder: LongWord;
        pNormOut: PD3DXVector3; pDataOut: ID3DXPRTBuffer): HResult; stdcall;

    // scales all the samples associated with a given sub mesh
    // can be useful when using subsurface scattering
    // fScale - value to scale each vector in submesh by
    function ScaleMeshChunk(uMeshChunk: LongWord; fScale: Single; pDataOut: ID3DXPRTBuffer): HResult; stdcall;

    // mutliplies each PRT vector by the albedo - can be used if you want to have the albedo
    // burned into the dataset, often better not to do this.  If this is not done the user
    // must mutliply the albedo themselves when rendering - just multiply the albedo times
    // the result of the PRT dot product.
    // If pDataOut is a texture simulation result and there is an albedo texture it
    // must be represented at the same resolution as the simulation buffer.  You can use
    // LoadSurfaceFromSurface and set a new albedo texture if this is an issue - but must
    // be careful about how the gutters are handled.
    //
    // pDataOut - dataset that will get albedo pushed into it
    function MultiplyAlbedo(pDataOut: ID3DXPRTBuffer): HResult; stdcall;

    // Sets a pointer to an optional call back function that reports back to the
    // user percentage done and gives them the option of quitting
    // pCB - pointer to call back function, return S_OK for the simulation
    //  to continue
    // Frequency - 1/Frequency is roughly the number of times the call back
    //  will be invoked
    // lpUserContext - will be passed back to the users call back
    function SetCallBack(pCB: TD3DXSHPRTSimCB; Frequency: Single; lpUserContext: Pointer): HResult; stdcall;
    
    // Returns TRUE if the ray intersects the mesh, FALSE if it does not.  This function
    // takes into account settings from SetMinMaxIntersection.  If the closest intersection
    // is not needed this function is more efficient compared to the ClosestRayIntersection
    // method.
    // pRayPos - origin of ray
    // pRayDir - normalized ray direction (normalization required for SetMinMax to be meaningful)
    function ShadowRayIntersects(const pRayPos: TD3DXVector3; const pRayDir: TD3DXVector3): BOOL; stdcall;

    // Returns TRUE if the ray intersects the mesh, FALSE if it does not.  If there is an
    // intersection the closest face that was intersected and its first two barycentric coordinates
    // are returned.  This function takes into account settings from SetMinMaxIntersection.
    // This is a slower function compared to ShadowRayIntersects and should only be used where
    // needed.  The third vertices barycentric coordinates will be 1 - pU - pV.
    // pRayPos     - origin of ray
    // pRayDir     - normalized ray direction (normalization required for SetMinMax to be meaningful)
    // pFaceIndex  - Closest face that intersects.  This index is based on stacking the pBlockerMesh
    //  faces before the faces from pMesh
    // pU          - Barycentric coordinate for vertex 0
    // pV          - Barycentric coordinate for vertex 1
    // pDist       - Distance along ray where the intersection occured
    function ClosestRayIntersects(const pRayPos: TD3DXVector3; const pRayDir: TD3DXVector3;
        out pFaceIndex: DWORD; pU, pV: PSingle; pDist: PSingle): BOOL; stdcall;
  end;

type
  // GUIDs
  IID_ID3DXPRTBuffer = ID3DXPRTBuffer;
  {$EXTERNALSYM IID_ID3DXPRTBuffer}
  IID_ID3DXPRTCompBuffer = ID3DXPRTCompBuffer;
  {$EXTERNALSYM IID_ID3DXPRTCompBuffer}
  IID_ID3DXTextureGutterHelper = ID3DXTextureGutterHelper;
  {$EXTERNALSYM IID_ID3DXTextureGutterHelper}
  IID_ID3DXPRTEngine = ID3DXPRTEngine;
  {$EXTERNALSYM IID_ID3DXPRTEngine}


// API functions for creating interfaces

//============================================================================
//
//  D3DXCreatePRTBuffer:
//  --------------------
//  Generates a PRT Buffer that can be compressed or filled by a simulator
//  This function should be used to create per-vertex or volume buffers.
//  When buffers are created all values are initialized to zero.
//
//  Parameters:
//    NumSamples
//      Number of sample locations represented
//    NumCoeffs
//      Number of coefficients per sample location (order^2 for SH)
//    NumChannels
//      Number of color channels to represent (1 or 3)
//    ppBuffer
//      Buffer that will be allocated
//
//============================================================================

function D3DXCreatePRTBuffer(
  NumSamples: LongWord;
  NumCoeffs: LongWord;
  NumChannels: LongWord;
  ppBuffer: ID3DXPRTBuffer): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreatePRTBuffer}

//============================================================================
//
//  D3DXCreatePRTBufferTex:
//  --------------------
//  Generates a PRT Buffer that can be compressed or filled by a simulator
//  This function should be used to create per-pixel buffers.
//  When buffers are created all values are initialized to zero.
//
//  Parameters:
//    Width
//      Width of texture
//    Height
//      Height of texture
//    NumCoeffs
//      Number of coefficients per sample location (order^2 for SH)
//    NumChannels
//      Number of color channels to represent (1 or 3)
//    ppBuffer
//      Buffer that will be allocated
//
//============================================================================

function D3DXCreatePRTBufferTex(
  Width: LongWord;
  Height: LongWord;
  NumCoeffs: LongWord;
  NumChannels: LongWord;
  ppBuffer: ID3DXPRTBuffer): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreatePRTBufferTex}

//============================================================================
//
//  D3DXLoadPRTBufferFromFile:
//  --------------------
//  Loads a PRT buffer that has been saved to disk.
//
//  Parameters:
//    pFilename
//      Name of the file to load
//    ppBuffer
//      Buffer that will be allocated
//
//============================================================================

function D3DXLoadPRTBufferFromFileA(
  pFilename: PAnsiChar;
  ppBuffer: ID3DXPRTBuffer): HResult; stdcall; external d3dx9meshDLL name 'D3DXLoadPRTBufferFromFileA';
{$EXTERNALSYM D3DXLoadPRTBufferFromFileA}

function D3DXLoadPRTBufferFromFileW(
  pFilename: PWideChar;
  ppBuffer: ID3DXPRTBuffer): HResult; stdcall; external d3dx9meshDLL name 'D3DXLoadPRTBufferFromFileW';
{$EXTERNALSYM D3DXLoadPRTBufferFromFileW}

function D3DXLoadPRTBufferFromFile(
  pFilename: PChar;
  ppBuffer: ID3DXPRTBuffer): HResult; stdcall; external d3dx9meshDLL name 'D3DXLoadPRTBufferFromFileA';
{$EXTERNALSYM D3DXLoadPRTBufferFromFile}


//============================================================================
//
//  D3DXSavePRTBufferToFile:
//  --------------------
//  Saves a PRTBuffer to disk.
//
//  Parameters:
//    pFilename
//      Name of the file to save
//    pBuffer
//      Buffer that will be saved
//
//============================================================================

function D3DXSavePRTBufferToFileA(
  pFilename: PAnsiChar;
  ppBuffer: ID3DXPRTBuffer): HResult; stdcall; external d3dx9meshDLL name 'D3DXSavePRTBufferToFileA';
{$EXTERNALSYM D3DXSavePRTBufferToFileA}

function D3DXSavePRTBufferToFileW(
  pFilename: PWideChar;
  ppBuffer: ID3DXPRTBuffer): HResult; stdcall; external d3dx9meshDLL name 'D3DXSavePRTBufferToFileW';
{$EXTERNALSYM D3DXSavePRTBufferToFileW}

function D3DXSavePRTBufferToFile(
  pFilename: PChar;
  ppBuffer: ID3DXPRTBuffer): HResult; stdcall; external d3dx9meshDLL name 'D3DXSavePRTBufferToFileA';
{$EXTERNALSYM D3DXSavePRTBufferToFile}


//============================================================================
//
//  D3DXLoadPRTCompBufferFromFile:
//  --------------------
//  Loads a PRTComp buffer that has been saved to disk.
//
//  Parameters:
//    pFilename
//      Name of the file to load
//    ppBuffer
//      Buffer that will be allocated
//
//============================================================================

function D3DXLoadPRTCompBufferFromFileA(
  pFilename: PAnsiChar;
  ppBuffer: ID3DXPRTCompBuffer): HResult; stdcall; external d3dx9meshDLL name 'D3DXLoadPRTCompBufferFromFileA';
{$EXTERNALSYM D3DXLoadPRTCompBufferFromFileA}

function D3DXLoadPRTCompBufferFromFileW(
  pFilename: PWideChar;
  ppBuffer: ID3DXPRTCompBuffer): HResult; stdcall; external d3dx9meshDLL name 'D3DXLoadPRTCompBufferFromFileW';
{$EXTERNALSYM D3DXLoadPRTCompBufferFromFileW}

function D3DXLoadPRTCompBufferFromFile(
  pFilename: PChar;
  ppBuffer: ID3DXPRTCompBuffer): HResult; stdcall; external d3dx9meshDLL name 'D3DXLoadPRTCompBufferFromFileA';
{$EXTERNALSYM D3DXLoadPRTCompBufferFromFile}


//============================================================================
//
//  D3DXSavePRTCompBufferToFile:
//  --------------------
//  Saves a PRTCompBuffer to disk.
//
//  Parameters:
//    pFilename
//      Name of the file to save
//    pBuffer
//      Buffer that will be saved
//
//============================================================================

function D3DXSavePRTCompBufferToFileA(
  pFilename: PAnsiChar;
  ppBuffer: ID3DXPRTCompBuffer): HResult; stdcall; external d3dx9meshDLL name 'D3DXSavePRTCompBufferToFileA';
{$EXTERNALSYM D3DXSavePRTCompBufferToFileA}

function D3DXSavePRTCompBufferToFileW(
  pFilename: PWideChar;
  ppBuffer: ID3DXPRTCompBuffer): HResult; stdcall; external d3dx9meshDLL name 'D3DXSavePRTCompBufferToFileW';
{$EXTERNALSYM D3DXSavePRTCompBufferToFileW}

function D3DXSavePRTCompBufferToFile(
  pFilename: PChar;
  ppBuffer: ID3DXPRTCompBuffer): HResult; stdcall; external d3dx9meshDLL name 'D3DXSavePRTCompBufferToFileA';
{$EXTERNALSYM D3DXSavePRTCompBufferToFile}


//============================================================================
//
//  D3DXCreatePRTCompBuffer:
//  --------------------
//  Compresses a PRT buffer (vertex or texel)
//
//  Parameters:
//    D3DXSHCOMPRESSQUALITYTYPE
//      Quality of compression - low is faster (computes PCA per voronoi cluster)
//      high is slower but better quality (clusters based on distance to affine subspace)
//    NumClusters
//      Number of clusters to compute
//    NumPCA
//      Number of basis vectors to compute
//    pCB
//      Optional Callback function
//    lpUserContext
//      Optional user context
//    pBufferIn
//      Buffer that will be compressed
//    ppBufferOut
//      Compressed buffer that will be created
//
//============================================================================

function D3DXCreatePRTCompBuffer(
  Quality: TD3DXSHCompressQualityType;
  NumClusters: LongWord;
  NumPCA: LongWord;
  pCB: TD3DXSHPRTSimCB;
  lpUserContext: Pointer;
  pBufferIn:  ID3DXPRTBuffer;
  out ppBufferOut: ID3DXPRTCompBuffer): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreatePRTCompBuffer}


//============================================================================
//
//  D3DXCreateTextureGutterHelper:
//  --------------------
//  Generates a "GutterHelper" for a given set of meshes and texture
//  resolution
//
//  Parameters:
//    Width
//      Width of texture
//    Height
//      Height of texture
//    pMesh
//      Mesh that represents the scene
//    GutterSize
//      Number of texels to over rasterize in texture space
//      this should be at least 1.0
//    ppBuffer
//      GutterHelper that will be created
//
//============================================================================

function D3DXCreateTextureGutterHelper(
  Width: LongWord;
  Height: LongWord;
  pMesh: ID3DXMesh;
  GutterSize: Single;
  out ppBuffer: ID3DXTextureGutterHelper): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreateTextureGutterHelper}


//============================================================================
//
//  D3DXCreatePRTEngine:
//  --------------------
//  Computes a PRTEngine which can efficiently generate PRT simulations
//  of a scene
//
//  Parameters:
//    pMesh
//      Mesh that represents the scene - must have an AttributeTable
//      where vertices are in a unique attribute.
//    pAdjacency
//      Optional adjacency information
//    ExtractUVs
//      Set this to true if textures are going to be used for albedos
//      or to store PRT vectors
//    pBlockerMesh
//      Optional mesh that just blocks the scene
//    ppEngine
//      PRTEngine that will be created
//
//============================================================================

function D3DXCreatePRTEngine(
  pMesh: ID3DXMesh;
  pAdjacency: PDWORD;
  ExtractUVs: BOOL;
  pBlockerMesh: ID3DXMesh;
  out ppEngine: ID3DXPRTEngine): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXCreatePRTEngine}


//============================================================================
//
//  D3DXConcatenateMeshes:
//  --------------------
//  Concatenates a group of meshes into one common mesh.  This can optionaly transform
//  each sub mesh or its texture coordinates.  If no DECL is given it will
//  generate a union of all of the DECL's of the sub meshes, promoting channels
//  and types if neccesary.  It will create an AttributeTable if possible, one can
//  call OptimizeMesh with attribute sort and compacting enabled to ensure this.
//
//  Parameters:
//    ppMeshes
//      Array of pointers to meshes that can store PRT vectors
//    NumMeshes
//      Number of meshes
//    Options
//      Passed through to D3DXCreateMesh
//    pGeomXForms
//      [optional] Each sub mesh is transformed by the corresponding
//      matrix if this array is supplied
//    pTextureXForms
//      [optional] UV coordinates for each sub mesh are transformed
//      by corresponding matrix if supplied
//    pDecl
//      [optional] Only information in this DECL is used when merging
//      data
//    pD3DDevice
//      D3D device that is used to create the new mesh
//    ppMeshOut
//      Mesh that will be created
//
//============================================================================

function D3DXConcatenateMeshes(
  ppMeshes: PID3DXMesh;
  NumMeshes: LongWord;
  Options: DWORD;
  const pGeomXForms: PD3DXMatrix;
  const pTextureXForms: PD3DXMatrix;
  const pDecl: PD3DVertexElement9;
  pD3DDevice: IDirect3DDevice9;
  out ppMeshOut: ID3DXMesh): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXConcatenateMeshes}

//============================================================================
//
//  D3DXSHPRTCompSuperCluster:
//  --------------------------
//  Used with compressed results of D3DXSHPRTSimulation.
//  Generates "super clusters" - groups of clusters that can be drawn in
//  the same draw call.  A greedy algorithm that minimizes overdraw is used
//  to group the clusters.
//
//  Parameters:
//   pClusterIDs
//      NumVerts cluster ID's (extracted from a compressed buffer)
//   pScene
//      Mesh that represents composite scene passed to the simulator
//   MaxNumClusters
//      Maximum number of clusters allocated per super cluster
//   NumClusters
//      Number of clusters computed in the simulator
//   pSuperClusterIDs
//      Array of length NumClusters, contains index of super cluster
//      that corresponding cluster was assigned to
//   pNumSuperClusters
//      Returns the number of super clusters allocated
//
//============================================================================


function D3DXSHPRTCompSuperCluster(
  pClusterIDs: PLongWord;
  pScene: ID3DXMesh;
  MaxNumClusters, NumClusters: LongWord;
  pSuperClusterIDs: PLongWord;
  out pNumSuperClusters: LongWord): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXSHPRTCompSuperCluster}

//============================================================================
//
//  D3DXSHPRTCompSplitMeshSC:
//  -------------------------
//  Used with compressed results of the vertex version of the PRT simulator.
//  After D3DXSHRTCompSuperCluster has been called this function can be used
//  to split the mesh into a group of faces/vertices per super cluster.
//  Each super cluster contains all of the faces that contain any vertex
//  classified in one of its clusters.  All of the vertices connected to this
//  set of faces are also included with the returned array ppVertStatus 
//  indicating whether or not the vertex belongs to the supercluster.
//
//  Parameters:
//   pClusterIDs
//      NumVerts cluster ID's (extracted from a compressed buffer)
//   NumVertices
//      Number of vertices in original mesh
//   NumClusters
//      Number of clusters (input parameter to compression)
//   pSuperClusterIDs
//      Array of size NumClusters that will contain super cluster ID's (from
//      D3DXSHCompSuerCluster)
//   NumSuperClusters
//      Number of superclusters allocated in D3DXSHCompSuerCluster
//   pInputIB
//      Raw index buffer for mesh - format depends on bInputIBIs32Bit
//   InputIBIs32Bit
//      Indicates whether the input index buffer is 32-bit (otherwise 16-bit
//      is assumed)
//   NumFaces
//      Number of faces in the original mesh (pInputIB is 3 times this length)
//   ppIBData
//      LPD3DXBUFFER holds raw index buffer that will contain the resulting split faces.  
//      Format determined by bIBIs32Bit.  Allocated by function
//   pIBDataLength
//      Length of ppIBData, assigned in function
//   OutputIBIs32Bit
//      Indicates whether the output index buffer is to be 32-bit (otherwise 
//      16-bit is assumed)
//   ppFaceRemap
//      LPD3DXBUFFER mapping of each face in ppIBData to original faces.  Length is
//      *pIBDataLength/3.  Optional paramter, allocated in function
//   ppVertData
//      LPD3DXBUFFER contains new vertex data structure.  Size of pVertDataLength
//   pVertDataLength
//      Number of new vertices in split mesh.  Assigned in function
//   pSCClusterList
//      Array of length NumClusters which pSCData indexes into (Cluster* fields)
//      for each SC, contains clusters sorted by super cluster
//   pSCData
//      Structure per super cluster - contains indices into ppIBData,
//      pSCClusterList and ppVertData
//
//============================================================================

function D3DXSHPRTCompSplitMeshSC(
  pClusterIDs: PLongWord;
  NumVertices, NumClusters: LongWord;
  pSuperClusterIDs: PLongWord; NumSuperClusters: LongWord;
  pInputIB: Pointer;
  InputIBIs32Bit: BOOL;
  NumFaces: LongWord;
  out ppIBData: ID3DXBuffer; out pIBDataLength: LongWord; OutputIBIs32Bit: BOOL;
  out ppFaceRemap, ppVertData: ID3DXBuffer; out pVertDataLength: LongWord;
  pSCClusterList: PLongWord;
  pSCData: PD3DXSHPRTSplitMeshClusterData): HResult; stdcall; external d3dx9meshDLL;
{$EXTERNALSYM D3DXSHPRTCompSplitMeshSC}


//////////////////////////////////////////////////////////////////////////////
//
//  Definitions of .X file templates used by mesh load/save functions
//    that are not RM standard
//
//////////////////////////////////////////////////////////////////////////////

const
  DXFILEOBJ_XSkinMeshHeader: TGUID    = '{3CF169CE-FF7C-44ab-93C0-F78F62D172E2}';
  {$EXTERNALSYM DXFILEOBJ_XSkinMeshHeader}
  DXFILEOBJ_VertexDuplicationIndices: TGUID = '{B8D65549-D7C9-4995-89CF-53A9A8B031E3}';
  {$EXTERNALSYM DXFILEOBJ_VertexDuplicationIndices}
  DXFILEOBJ_FaceAdjacency: TGUID      = '{A64C844A-E282-4756-8B80-250CDE04398C}';
  {$EXTERNALSYM DXFILEOBJ_FaceAdjacency}
  DXFILEOBJ_SkinWeights: TGUID        = '{6F0D123B-BAD2-4167-A0D0-80224F25FABB}';
  {$EXTERNALSYM DXFILEOBJ_SkinWeights}
  DXFILEOBJ_Patch: TGUID              = '{A3EB5D44-FC22-429d-9AFB-3221CB9719A6}';
  {$EXTERNALSYM DXFILEOBJ_Patch}
  DXFILEOBJ_PatchMesh: TGUID          = '{D02C95CC-EDBA-4305-9B5D-1820D7704BBF}';
  {$EXTERNALSYM DXFILEOBJ_PatchMesh}
  DXFILEOBJ_PatchMesh9: TGUID         = '{B9EC94E1-B9A6-4251-BA18-94893F02C0EA}';
  {$EXTERNALSYM DXFILEOBJ_PatchMesh9}
  DXFILEOBJ_PMInfo: TGUID             = '{B6C3E656-EC8B-4b92-9B62-681659522947}';
  {$EXTERNALSYM DXFILEOBJ_PMInfo}
  DXFILEOBJ_PMAttributeRange: TGUID   = '{917E0427-C61E-4a14-9C64-AFE65F9E9844}';
  {$EXTERNALSYM DXFILEOBJ_PMAttributeRange}
  DXFILEOBJ_PMVSplitRecord: TGUID     = '{574CCC14-F0B3-4333-822D-93E8A8A08E4C}';
  {$EXTERNALSYM DXFILEOBJ_PMVSplitRecord}
  DXFILEOBJ_FVFData: TGUID            = '{B6E70A0E-8EF9-4e83-94AD-ECC8B0C04897}';
  {$EXTERNALSYM DXFILEOBJ_FVFData}
  DXFILEOBJ_VertexElement: TGUID      = '{F752461C-1E23-48f6-B9F8-8350850F336F}';
  {$EXTERNALSYM DXFILEOBJ_VertexElement}
  DXFILEOBJ_DeclData: TGUID           = '{BF22E553-292C-4781-9FEA-62BD554BDD93}';
  {$EXTERNALSYM DXFILEOBJ_DeclData}
  DXFILEOBJ_EffectFloats: TGUID       = '{F1CFE2B3-0DE3-4e28-AFA1-155A750A282D}';
  {$EXTERNALSYM DXFILEOBJ_EffectFloats}
  DXFILEOBJ_EffectString: TGUID       = '{D55B097E-BDB6-4c52-B03D-6051C89D0E42}';
  {$EXTERNALSYM DXFILEOBJ_EffectString}
  DXFILEOBJ_EffectDWord: TGUID        = '{622C0ED0-956E-4da9-908A-2AF94F3CE716}';
  {$EXTERNALSYM DXFILEOBJ_EffectDWord}
  DXFILEOBJ_EffectParamFloats: TGUID  = '{3014B9A0-62F5-478c-9B86-E4AC9F4E418B}';
  {$EXTERNALSYM DXFILEOBJ_EffectParamFloats}
  DXFILEOBJ_EffectParamString: TGUID  = '{1DBC4C88-94C1-46ee-9076-2C28818C9481}';
  {$EXTERNALSYM DXFILEOBJ_EffectParamString}
  DXFILEOBJ_EffectParamDWord: TGUID   = '{E13963BC-AE51-4c5d-B00F-CFA3A9D97CE5}';
  {$EXTERNALSYM DXFILEOBJ_EffectParamDWord}
  DXFILEOBJ_EffectInstance: TGUID     = '{E331F7E4-0559-4cc2-8E99-1CEC1657928F}';
  {$EXTERNALSYM DXFILEOBJ_EffectInstance}
  DXFILEOBJ_AnimTicksPerSecond: TGUID = '{7F9B00B3-F125-4890-876E-1CFFBF697C4D}';
  {$EXTERNALSYM DXFILEOBJ_AnimTicksPerSecond}

type
  PXFileCompressedAnimationSet = ^TXFileCompressedAnimationSet;
  _XFILECOMPRESSEDANIMATIONSET = packed record {#pragma pack(push, 1)}
    CompressedBlockSize: DWORD;
    TicksPerSec: Single;
    PlaybackType: DWORD;
    BufferLength: DWORD;
  end;
  {$EXTERNALSYM _XFILECOMPRESSEDANIMATIONSET}
  XFILECOMPRESSEDANIMATIONSET = _XFILECOMPRESSEDANIMATIONSET;
  {$EXTERNALSYM XFILECOMPRESSEDANIMATIONSET}
  TXFileCompressedAnimationSet = _XFILECOMPRESSEDANIMATIONSET;

const
  XSKINEXP_TEMPLATES =
        'xof 0303txt 0032' +
        'template XSkinMeshHeader ' +
        '{ ' +
        '    <3CF169CE-FF7C-44ab-93C0-F78F62D172E2> ' +
        '    WORD nMaxSkinWeightsPerVertex; ' +
        '    WORD nMaxSkinWeightsPerFace; ' +
        '    WORD nBones; ' +
        '} ' +
        'template VertexDuplicationIndices ' +
        '{ ' +
        '    <B8D65549-D7C9-4995-89CF-53A9A8B031E3> ' +
        '    DWORD nIndices; ' +
        '    DWORD nOriginalVertices; ' +
        '    array DWORD indices[nIndices]; ' +
        '} ' +
        'template FaceAdjacency ' +
        '{ ' +
        '    <A64C844A-E282-4756-8B80-250CDE04398C> ' +
        '    DWORD nIndices; ' +
        '    array DWORD indices[nIndices]; ' +
        '} ' +
        'template SkinWeights ' +
        '{ ' +
        '    <6F0D123B-BAD2-4167-A0D0-80224F25FABB> ' +
        '    STRING transformNodeName; ' +
        '    DWORD nWeights; ' +
        '    array DWORD vertexIndices[nWeights]; ' +
        '    array float weights[nWeights]; ' +
        '    Matrix4x4 matrixOffset; ' +
        '} ' +
        'template Patch ' +
        '{ ' +
        '    <A3EB5D44-FC22-429D-9AFB-3221CB9719A6> ' +
        '    DWORD nControlIndices; ' +
        '    array DWORD controlIndices[nControlIndices]; ' +
        '} ' +
        'template PatchMesh ' +
        '{ ' +
        '    <D02C95CC-EDBA-4305-9B5D-1820D7704BBF> ' +
        '    DWORD nVertices; ' +
        '    array Vector vertices[nVertices]; ' +
        '    DWORD nPatches; ' +
        '    array Patch patches[nPatches]; ' +
        '    [ ... ] ' +
        '} ' +
        'template PatchMesh9 ' +
        '{ ' +
        '    <B9EC94E1-B9A6-4251-BA18-94893F02C0EA> ' +
        '    DWORD Type; ' +
        '    DWORD Degree; ' +
        '    DWORD Basis; ' +
        '    DWORD nVertices; ' +
        '    array Vector vertices[nVertices]; ' +
        '    DWORD nPatches; ' +
        '    array Patch patches[nPatches]; ' +
        '    [ ... ] ' +
        '} ' +
        'template EffectFloats ' +
        '{ ' +
        '    <F1CFE2B3-0DE3-4e28-AFA1-155A750A282D> ' +
        '    DWORD nFloats; ' +
        '    array float Floats[nFloats]; ' +
        '} ' +
        'template EffectString ' +
        '{ ' +
        '    <D55B097E-BDB6-4c52-B03D-6051C89D0E42> ' +
        '    STRING Value; ' +
        '} ' +
        'template EffectDWord ' +
        '{ ' +
        '    <622C0ED0-956E-4da9-908A-2AF94F3CE716> ' +
        '    DWORD Value; ' +
        '} ' +
        'template EffectParamFloats ' +
        '{ ' +
        '    <3014B9A0-62F5-478c-9B86-E4AC9F4E418B> ' +
        '    STRING ParamName; ' +
        '    DWORD nFloats; ' +
        '    array float Floats[nFloats]; ' +
        '} ' +
        'template EffectParamString ' +
        '{ ' +
        '    <1DBC4C88-94C1-46ee-9076-2C28818C9481> ' +
        '    STRING ParamName; ' +
        '    STRING Value; ' +
        '} ' +
        'template EffectParamDWord ' +
        '{ ' +
        '    <E13963BC-AE51-4c5d-B00F-CFA3A9D97CE5> ' +
        '    STRING ParamName; ' +
        '    DWORD Value; ' +
        '} ' +
        'template EffectInstance ' +
        '{ ' +
        '    <E331F7E4-0559-4cc2-8E99-1CEC1657928F> ' +
        '    STRING EffectFilename; ' +
        '    [ ... ] ' +
        '} ' +
        'template AnimTicksPerSecond ' +
        '{ ' +
        '    <9E415A43-7BA6-4a73-8743-B73D47E88476> ' +
        '    DWORD AnimTicksPerSecond; ' +
        '} ' +
        'template CompressedAnimationSet ' +
        '{ ' +
        '    <7F9B00B3-F125-4890-876E-1C42BF697C4D> ' +
        '    DWORD CompressedBlockSize; ' +
        '    FLOAT TicksPerSec; ' +
        '    DWORD PlaybackType; ' +
        '    DWORD BufferLength; ' +
        '    array DWORD CompressedData[BufferLength]; ' +
        '} ';
  {$EXTERNALSYM XSKINEXP_TEMPLATES}

  XEXTENSIONS_TEMPLATES =
        'xof 0303txt 0032' +
        'template FVFData ' +
        '{ ' +
        '    <B6E70A0E-8EF9-4e83-94AD-ECC8B0C04897> ' +
        '    DWORD dwFVF; ' +
        '    DWORD nDWords; ' +
        '    array DWORD data[nDWords]; ' +
        '} ' +
        'template VertexElement ' +
        '{ ' +
        '    <F752461C-1E23-48f6-B9F8-8350850F336F> ' +
        '    DWORD Type; ' +
        '    DWORD Method; ' +
        '    DWORD Usage; ' +
        '    DWORD UsageIndex; ' +
        '} ' +
        'template DeclData ' +
        '{ ' +
        '    <BF22E553-292C-4781-9FEA-62BD554BDD93> ' +
        '    DWORD nElements; ' +
        '    array VertexElement Elements[nElements]; ' +
        '    DWORD nDWords; ' +
        '    array DWORD data[nDWords]; ' +
        '} ' +
        'template PMAttributeRange ' +
        '{ ' +
        '    <917E0427-C61E-4a14-9C64-AFE65F9E9844> ' +
        '    DWORD iFaceOffset; ' +
        '    DWORD nFacesMin; ' +
        '    DWORD nFacesMax; ' +
        '    DWORD iVertexOffset; ' +
        '    DWORD nVerticesMin; ' +
        '    DWORD nVerticesMax; ' +
        '} ' +
        'template PMVSplitRecord ' +
        '{ ' +
        '    <574CCC14-F0B3-4333-822D-93E8A8A08E4C> ' +
        '    DWORD iFaceCLW; ' +
        '    DWORD iVlrOffset; ' +
        '    DWORD iCode; ' +
        '} ' +
        'template PMInfo ' +
        '{ ' +
        '    <B6C3E656-EC8B-4b92-9B62-681659522947> ' +
        '    DWORD nAttributes; ' +
        '    array PMAttributeRange attributeRanges[nAttributes]; ' +
        '    DWORD nMaxValence; ' +
        '    DWORD nMinLogicalVertices; ' +
        '    DWORD nMaxLogicalVertices; ' +
        '    DWORD nVSplits; ' +
        '    array PMVSplitRecord splitRecords[nVSplits]; ' +
        '    DWORD nAttributeMispredicts; ' +
        '    array DWORD attributeMispredicts[nAttributeMispredicts]; ' +
        '} ';
  {$EXTERNALSYM XEXTENSIONS_TEMPLATES}





///////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9shape.h
//  Content:    D3DX simple shapes
//
///////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////
// Functions:
///////////////////////////////////////////////////////////////////////////


//-------------------------------------------------------------------------
// D3DXCreatePolygon:
// ------------------
// Creates a mesh containing an n-sided polygon.  The polygon is centered
// at the origin.
//
// Parameters:
//
//  pDevice     The D3D device with which the mesh is going to be used.
//  Length      Length of each side.
//  Sides       Number of sides the polygon has.  (Must be >= 3)
//  ppMesh      The mesh object which will be created
//  ppAdjacency Returns a buffer containing adjacency info.  Can be NULL.
//-------------------------------------------------------------------------
function D3DXCreatePolygon(ppDevice: IDirect3DDevice9;
  Length: Single;
  Sides: LongWord;
  out ppMesh: ID3DXMesh;
  ppAdjacency: PID3DXBuffer): HResult; stdcall; external d3dx9shapesDLL;
{$EXTERNALSYM D3DXCreatePolygon}


//-------------------------------------------------------------------------
// D3DXCreateBox:
// --------------
// Creates a mesh containing an axis-aligned box.  The box is centered at
// the origin.
//
// Parameters:
//
//  pDevice     The D3D device with which the mesh is going to be used.
//  Width       Width of box (along X-axis)
//  Height      Height of box (along Y-axis)
//  Depth       Depth of box (along Z-axis)
//  ppMesh      The mesh object which will be created
//  ppAdjacency Returns a buffer containing adjacency info.  Can be NULL.
//-------------------------------------------------------------------------
function D3DXCreateBox(ppDevice: IDirect3DDevice9;
  Width,
  Height,
  Depth: Single;
  out ppMesh: ID3DXMesh;
  ppAdjacency: PID3DXBuffer): HResult; stdcall; external d3dx9shapesDLL;
{$EXTERNALSYM D3DXCreateBox}


//-------------------------------------------------------------------------
// D3DXCreateCylinder:
// -------------------
// Creates a mesh containing a cylinder.  The generated cylinder is
// centered at the origin, and its axis is aligned with the Z-axis.
//
// Parameters:
//
//  pDevice     The D3D device with which the mesh is going to be used.
//  Radius1     Radius at -Z end (should be >= 0.0f)
//  Radius2     Radius at +Z end (should be >= 0.0f)
//  Length      Length of cylinder (along Z-axis)
//  Slices      Number of slices about the main axis
//  Stacks      Number of stacks along the main axis
//  ppMesh      The mesh object which will be created
//  ppAdjacency Returns a buffer containing adjacency info.  Can be NULL.
//-------------------------------------------------------------------------
function D3DXCreateCylinder(ppDevice: IDirect3DDevice9;
  Radius1,
  Radius2,
  Length: Single;
  Slices,
  Stacks: LongWord;
  out ppMesh: ID3DXMesh;
  ppAdjacency: PID3DXBuffer): HResult; stdcall; external d3dx9shapesDLL;
{$EXTERNALSYM D3DXCreateCylinder}


//-------------------------------------------------------------------------
// D3DXCreateSphere:
// -----------------
// Creates a mesh containing a sphere.  The sphere is centered at the
// origin.
//
// Parameters:
//
//  pDevice     The D3D device with which the mesh is going to be used.
//  Radius      Radius of the sphere (should be >= 0.0f)
//  Slices      Number of slices about the main axis
//  Stacks      Number of stacks along the main axis
//  ppMesh      The mesh object which will be created
//  ppAdjacency Returns a buffer containing adjacency info.  Can be NULL.
//-------------------------------------------------------------------------
function D3DXCreateSphere(ppDevice: IDirect3DDevice9;
  Radius: Single;
  Slices,
  Stacks: LongWord;
  out ppMesh: ID3DXMesh;
  ppAdjacency: PID3DXBuffer): HResult; stdcall; external d3dx9shapesDLL;
{$EXTERNALSYM D3DXCreateSphere}


//-------------------------------------------------------------------------
// D3DXCreateTorus:
// ----------------
// Creates a mesh containing a torus.  The generated torus is centered at
// the origin, and its axis is aligned with the Z-axis.
//
// Parameters:
//
//  pDevice     The D3D device with which the mesh is going to be used.
//  InnerRadius Inner radius of the torus (should be >= 0.0f)
//  OuterRadius Outer radius of the torue (should be >= 0.0f)
//  Sides       Number of sides in a cross-section (must be >= 3)
//  Rings       Number of rings making up the torus (must be >= 3)
//  ppMesh      The mesh object which will be created
//  ppAdjacency Returns a buffer containing adjacency info.  Can be NULL.
//-------------------------------------------------------------------------
function D3DXCreateTorus(ppDevice: IDirect3DDevice9;
  InnerRadius,
  OuterRadius: Single;
  Sides,
  Rings: LongWord;
  out ppMesh: ID3DXMesh;
  ppAdjacency: PID3DXBuffer): HResult; stdcall; external d3dx9shapesDLL;
{$EXTERNALSYM D3DXCreateTorus}


//-------------------------------------------------------------------------
// D3DXCreateTeapot:
// -----------------
// Creates a mesh containing a teapot.
//
// Parameters:
//
//  pDevice     The D3D device with which the mesh is going to be used.
//  ppMesh      The mesh object which will be created
//  ppAdjacency Returns a buffer containing adjacency info.  Can be NULL.
//-------------------------------------------------------------------------
function D3DXCreateTeapot(ppDevice: IDirect3DDevice9;
  out ppMesh: ID3DXMesh;
  ppAdjacency: PID3DXBuffer): HResult; stdcall; external d3dx9shapesDLL;
{$EXTERNALSYM D3DXCreateTeapot}


//-------------------------------------------------------------------------
// D3DXCreateText:
// ---------------
// Creates a mesh containing the specified text using the font associated
// with the device context.
//
// Parameters:
//
//  pDevice       The D3D device with which the mesh is going to be used.
//  hDC           Device context, with desired font selected
//  pText         Text to generate
//  Deviation     Maximum chordal deviation from true font outlines
//  Extrusion     Amount to extrude text in -Z direction
//  ppMesh        The mesh object which will be created
//  pGlyphMetrics Address of buffer to receive glyph metric data (or NULL)
//-------------------------------------------------------------------------

function D3DXCreateTextA(ppDevice: IDirect3DDevice9;
  hDC: HDC;
  pText: PAnsiChar;
  Deviation: Single;
  Extrusion: Single;
  out ppMesh: ID3DXMesh;
  ppAdjacency: PID3DXBuffer;
  pGlyphMetrics: PGlyphMetricsFloat): HResult; stdcall; external d3dx9shapesDLL name 'D3DXCreateTextA';
{$EXTERNALSYM D3DXCreateTextA}

function D3DXCreateTextW(ppDevice: IDirect3DDevice9;
  hDC: HDC;
  pText: PWideChar;
  Deviation: Single;
  Extrusion: Single;
  out ppMesh: ID3DXMesh;
  ppAdjacency: PID3DXBuffer;
  pGlyphMetrics: PGlyphMetricsFloat): HResult; stdcall; external d3dx9shapesDLL name 'D3DXCreateTextW';
{$EXTERNALSYM D3DXCreateTextW}

function D3DXCreateText(ppDevice: IDirect3DDevice9;
  hDC: HDC;
  pText: PChar;
  Deviation: Single;
  Extrusion: Single;
  out ppMesh: ID3DXMesh;
  ppAdjacency: PID3DXBuffer;
  pGlyphMetrics: PGlyphMetricsFloat): HResult; stdcall; external d3dx9shapesDLL name 'D3DXCreateTextA';
{$EXTERNALSYM D3DXCreateText}







//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9tex.h
//  Content:    D3DX texturing APIs
//
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// D3DX_FILTER flags:
// ------------------
//
// A valid filter must contain one of these values:
//
//  D3DX_FILTER_NONE
//      No scaling or filtering will take place.  Pixels outside the bounds
//      of the source image are assumed to be transparent black.
//  D3DX_FILTER_POINT
//      Each destination pixel is computed by sampling the nearest pixel
//      from the source image.
//  D3DX_FILTER_LINEAR
//      Each destination pixel is computed by linearly interpolating between
//      the nearest pixels in the source image.  This filter works best
//      when the scale on each axis is less than 2.
//  D3DX_FILTER_TRIANGLE
//      Every pixel in the source image contributes equally to the
//      destination image.  This is the slowest of all the filters.
//  D3DX_FILTER_BOX
//      Each pixel is computed by averaging a 2x2(x2) box pixels from
//      the source image. Only works when the dimensions of the
//      destination are half those of the source. (as with mip maps)
//
// And can be OR'd with any of these optional flags:
//
//  D3DX_FILTER_MIRROR_U
//      Indicates that pixels off the edge of the texture on the U-axis
//      should be mirrored, not wraped.
//  D3DX_FILTER_MIRROR_V
//      Indicates that pixels off the edge of the texture on the V-axis
//      should be mirrored, not wraped.
//  D3DX_FILTER_MIRROR_W
//      Indicates that pixels off the edge of the texture on the W-axis
//      should be mirrored, not wraped.
//  D3DX_FILTER_MIRROR
//      Same as specifying D3DX_FILTER_MIRROR_U | D3DX_FILTER_MIRROR_V |
//      D3DX_FILTER_MIRROR_V
//  D3DX_FILTER_DITHER
//      Dithers the resulting image using a 4x4 order dither pattern.
//  D3DX_FILTER_SRGB_IN
//      Denotes that the input data is in sRGB (gamma 2.2) colorspace.
//  D3DX_FILTER_SRGB_OUT
//      Denotes that the output data is in sRGB (gamma 2.2) colorspace.
//  D3DX_FILTER_SRGB
//      Same as specifying D3DX_FILTER_SRGB_IN | D3DX_FILTER_SRGB_OUT
//
//----------------------------------------------------------------------------

const
  D3DX_FILTER_NONE      = (1 shl 0);
  {$EXTERNALSYM D3DX_FILTER_NONE}
  D3DX_FILTER_POINT     = (2 shl 0);
  {$EXTERNALSYM D3DX_FILTER_POINT}
  D3DX_FILTER_LINEAR    = (3 shl 0);
  {$EXTERNALSYM D3DX_FILTER_LINEAR}
  D3DX_FILTER_TRIANGLE  = (4 shl 0);
  {$EXTERNALSYM D3DX_FILTER_TRIANGLE}
  D3DX_FILTER_BOX       = (5 shl 0);
  {$EXTERNALSYM D3DX_FILTER_BOX}

  D3DX_FILTER_MIRROR_U  = (1 shl 16);
  {$EXTERNALSYM D3DX_FILTER_MIRROR_U}
  D3DX_FILTER_MIRROR_V  = (2 shl 16);
  {$EXTERNALSYM D3DX_FILTER_MIRROR_V}
  D3DX_FILTER_MIRROR_W  = (4 shl 16);
  {$EXTERNALSYM D3DX_FILTER_MIRROR_W}
  D3DX_FILTER_MIRROR    = (7 shl 16);
  {$EXTERNALSYM D3DX_FILTER_MIRROR}

  D3DX_FILTER_DITHER    = (1 shl 19);
  {$EXTERNALSYM D3DX_FILTER_DITHER}
  D3DX_FILTER_DITHER_DIFFUSION = (2 shl 19);
  {$EXTERNALSYM D3DX_FILTER_DITHER_DIFFUSION}

  D3DX_FILTER_SRGB_IN   = (1 shl 21);
  {$EXTERNALSYM D3DX_FILTER_SRGB_IN}
  D3DX_FILTER_SRGB_OUT  = (2 shl 21);
  {$EXTERNALSYM D3DX_FILTER_SRGB_OUT}
  D3DX_FILTER_SRGB      = (3 shl 21);
  {$EXTERNALSYM D3DX_FILTER_SRGB}


//-----------------------------------------------------------------------------
// D3DX_SKIP_DDS_MIP_LEVELS is used to skip mip levels when loading a DDS file:
//-----------------------------------------------------------------------------

const
  D3DX_SKIP_DDS_MIP_LEVELS_MASK   = $1F;
  {$EXTERNALSYM D3DX_SKIP_DDS_MIP_LEVELS_MASK}
  D3DX_SKIP_DDS_MIP_LEVELS_SHIFT  = 26;
  {$EXTERNALSYM D3DX_SKIP_DDS_MIP_LEVELS_SHIFT}

function D3DX_SKIP_DDS_MIP_LEVELS(levels, filter: DWORD): DWORD; inline;
{$EXTERNALSYM D3DX_SKIP_DDS_MIP_LEVELS}



//----------------------------------------------------------------------------
// D3DX_NORMALMAP flags:
// ---------------------
// These flags are used to control how D3DXComputeNormalMap generates normal
// maps.  Any number of these flags may be OR'd together in any combination.
//
//  D3DX_NORMALMAP_MIRROR_U
//      Indicates that pixels off the edge of the texture on the U-axis
//      should be mirrored, not wraped.
//  D3DX_NORMALMAP_MIRROR_V
//      Indicates that pixels off the edge of the texture on the V-axis
//      should be mirrored, not wraped.
//  D3DX_NORMALMAP_MIRROR
//      Same as specifying D3DX_NORMALMAP_MIRROR_U | D3DX_NORMALMAP_MIRROR_V
//  D3DX_NORMALMAP_INVERTSIGN
//      Inverts the direction of each normal
//  D3DX_NORMALMAP_COMPUTE_OCCLUSION
//      Compute the per pixel Occlusion term and encodes it into the alpha.
//      An Alpha of 1 means that the pixel is not obscured in anyway, and
//      an alpha of 0 would mean that the pixel is completly obscured.
//
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------

const
  D3DX_NORMALMAP_MIRROR_U     = (1 shl 16);
  {$EXTERNALSYM D3DX_NORMALMAP_MIRROR_U}
  D3DX_NORMALMAP_MIRROR_V     = (2 shl 16);
  {$EXTERNALSYM D3DX_NORMALMAP_MIRROR_V}
  D3DX_NORMALMAP_MIRROR       = (3 shl 16);
  {$EXTERNALSYM D3DX_NORMALMAP_MIRROR}
  D3DX_NORMALMAP_INVERTSIGN   = (8 shl 16);
  {$EXTERNALSYM D3DX_NORMALMAP_INVERTSIGN}
  D3DX_NORMALMAP_COMPUTE_OCCLUSION = (16 shl 16);
  {$EXTERNALSYM D3DX_NORMALMAP_COMPUTE_OCCLUSION}


//----------------------------------------------------------------------------
// D3DX_CHANNEL flags:
// -------------------
// These flags are used by functions which operate on or more channels
// in a texture.
//
// D3DX_CHANNEL_RED
//     Indicates the red channel should be used
// D3DX_CHANNEL_BLUE
//     Indicates the blue channel should be used
// D3DX_CHANNEL_GREEN
//     Indicates the green channel should be used
// D3DX_CHANNEL_ALPHA
//     Indicates the alpha channel should be used
// D3DX_CHANNEL_LUMINANCE
//     Indicates the luminaces of the red green and blue channels should be
//     used.
//
//----------------------------------------------------------------------------

const
  D3DX_CHANNEL_RED            = (1 shl 0);
  {$EXTERNALSYM D3DX_CHANNEL_RED}
  D3DX_CHANNEL_BLUE           = (1 shl 1);
  {$EXTERNALSYM D3DX_CHANNEL_BLUE}
  D3DX_CHANNEL_GREEN          = (1 shl 2);
  {$EXTERNALSYM D3DX_CHANNEL_GREEN}
  D3DX_CHANNEL_ALPHA          = (1 shl 3);
  {$EXTERNALSYM D3DX_CHANNEL_ALPHA}
  D3DX_CHANNEL_LUMINANCE      = (1 shl 4);
  {$EXTERNALSYM D3DX_CHANNEL_LUMINANCE}


//----------------------------------------------------------------------------
// D3DXIMAGE_FILEFORMAT:
// ---------------------
// This enum is used to describe supported image file formats.
//
//----------------------------------------------------------------------------

type
  PD3DXImageFileFormat = ^TD3DXImageFileFormat;
  _D3DXIMAGE_FILEFORMAT = (
    D3DXIFF_BMP        {= 0},
    D3DXIFF_JPG        {= 1},
    D3DXIFF_TGA        {= 2},
    D3DXIFF_PNG        {= 3},
    D3DXIFF_DDS        {= 4},
    D3DXIFF_PPM        {= 5},
    D3DXIFF_DIB        {= 6},
    D3DXIFF_HDR        {= 7},       //high dynamic range formats
    D3DXIFF_PFM        {= 8}        //
  );
  {$EXTERNALSYM _D3DXIMAGE_FILEFORMAT}
  D3DXIMAGE_FILEFORMAT = _D3DXIMAGE_FILEFORMAT;
  {$EXTERNALSYM D3DXIMAGE_FILEFORMAT}
  TD3DXImageFileFormat = _D3DXIMAGE_FILEFORMAT;


//----------------------------------------------------------------------------
// LPD3DXFILL2D and LPD3DXFILL3D:
// ------------------------------
// Function types used by the texture fill functions.
//
// Parameters:
//  pOut
//      Pointer to a vector which the function uses to return its result.
//      X,Y,Z,W will be mapped to R,G,B,A respectivly.
//  pTexCoord
//      Pointer to a vector containing the coordinates of the texel currently
//      being evaluated.  Textures and VolumeTexture texcoord components
//      range from 0 to 1. CubeTexture texcoord component range from -1 to 1.
//  pTexelSize
//      Pointer to a vector containing the dimensions of the current texel.
//  pData
//      Pointer to user data.
//
//----------------------------------------------------------------------------

type
  //typedef VOID (WINAPI *LPD3DXFILL2D)(D3DXVECTOR4 *pOut,
  //    CONST D3DXVECTOR2 *pTexCoord, CONST D3DXVECTOR2 *pTexelSize, LPVOID pData);
  TD3DXFill2D = procedure (out pOut: TD3DXVector4; const pTexCoord, pTexelSize: TD3DXVector2; var pData); stdcall;
  {$NODEFINE TD3DXFill2D}
  {$HPPEMIT 'typedef LPD3DXFILL2D TD3DXFill2D;'}

  //typedef VOID (WINAPI *LPD3DXFILL3D)(D3DXVECTOR4 *pOut,
  //    CONST D3DXVECTOR3 *pTexCoord, CONST D3DXVECTOR3 *pTexelSize, LPVOID pData);
  TD3DXFill3D = procedure (out pOut: TD3DXVector4; const pTexCoord, pTexelSize: TD3DXVector3; var pData); stdcall;
  {$NODEFINE TD3DXFill3D}
  {$HPPEMIT 'typedef LPD3DXFILL3D TD3DXFill3D;'}



//----------------------------------------------------------------------------
// D3DXIMAGE_INFO:
// ---------------
// This structure is used to return a rough description of what the
// the original contents of an image file looked like.
//
//  Width
//      Width of original image in pixels
//  Height
//      Height of original image in pixels
//  Depth
//      Depth of original image in pixels
//  MipLevels
//      Number of mip levels in original image
//  Format
//      D3D format which most closely describes the data in original image
//  ResourceType
//      D3DRESOURCETYPE representing the type of texture stored in the file.
//      D3DRTYPE_TEXTURE, D3DRTYPE_VOLUMETEXTURE, or D3DRTYPE_CUBETEXTURE.
//  ImageFileFormat
//      D3DXIMAGE_FILEFORMAT representing the format of the image file.
//
//----------------------------------------------------------------------------

type
  PD3DXImageInfo = ^TD3DXImageInfo;
  _D3DXIMAGE_INFO = record
    Width:      LongWord;
    Height:     LongWord;
    Depth:      LongWord;
    MipLevels:  LongWord;
    Format:     TD3DFormat;
    ResourceType: TD3DResourceType;
    ImageFileFormat: TD3DXImageFileFormat;
  end;
  {$EXTERNALSYM _D3DXIMAGE_INFO}
  D3DXIMAGE_INFO = _D3DXIMAGE_INFO;
  {$EXTERNALSYM D3DXIMAGE_INFO}
  TD3DXImageInfo = _D3DXIMAGE_INFO;


//////////////////////////////////////////////////////////////////////////////
// Image File APIs ///////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// GetImageInfoFromFile/Resource:
// ------------------------------
// Fills in a D3DXIMAGE_INFO struct with information about an image file.
//
// Parameters:
//  pSrcFile
//      File name of the source image.
//  pSrcModule
//      Module where resource is located, or NULL for module associated
//      with image the os used to create the current process.
//  pSrcResource
//      Resource name
//  pSrcData
//      Pointer to file in memory.
//  SrcDataSize
//      Size in bytes of file in memory.
//  pSrcInfo
//      Pointer to a D3DXIMAGE_INFO structure to be filled in with the
//      description of the data in the source image file.
//
//----------------------------------------------------------------------------

function D3DXGetImageInfoFromFileA(
  pSrcFile: PAnsiChar;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXGetImageInfoFromFileA';
{$EXTERNALSYM D3DXGetImageInfoFromFileA}

function D3DXGetImageInfoFromFileW(
  pSrcFile: PWideChar;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXGetImageInfoFromFileW';
{$EXTERNALSYM D3DXGetImageInfoFromFileW}

function D3DXGetImageInfoFromFile(
  pSrcFile: PChar;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXGetImageInfoFromFileA';
{$EXTERNALSYM D3DXGetImageInfoFromFile}


function D3DXGetImageInfoFromResourceA(
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXGetImageInfoFromResourceA';
{$EXTERNALSYM D3DXGetImageInfoFromResourceA}

function D3DXGetImageInfoFromResourceW(
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXGetImageInfoFromResourceW';
{$EXTERNALSYM D3DXGetImageInfoFromResourceW}

function D3DXGetImageInfoFromResource(
  hSrcModule: HModule;
  pSrcResource: PChar;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXGetImageInfoFromResourceA';
{$EXTERNALSYM D3DXGetImageInfoFromResource}


function D3DXGetImageInfoFromFileInMemory(
  const pSrcData: Pointer;
  SrcDataSize: LongWord;
  out pSrcInfo: TD3DXImageInfo): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXGetImageInfoFromFileInMemory}


//////////////////////////////////////////////////////////////////////////////
// Load/Save Surface APIs ////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////


//----------------------------------------------------------------------------
// D3DXLoadSurfaceFromFile/Resource:
// ---------------------------------
// Load surface from a file or resource
//
// Parameters:
//  pDestSurface
//      Destination surface, which will receive the image.
//  pDestPalette
//      Destination palette of 256 colors, or NULL
//  pDestRect
//      Destination rectangle, or NULL for entire surface
//  pSrcFile
//      File name of the source image.
//  pSrcModule
//      Module where resource is located, or NULL for module associated
//      with image the os used to create the current process.
//  pSrcResource
//      Resource name
//  pSrcData
//      Pointer to file in memory.
//  SrcDataSize
//      Size in bytes of file in memory.
//  pSrcRect
//      Source rectangle, or NULL for entire image
//  Filter
//      D3DX_FILTER flags controlling how the image is filtered.
//      Or D3DX_DEFAULT for D3DX_FILTER_TRIANGLE.
//  ColorKey
//      Color to replace with transparent black, or 0 to disable colorkey.
//      This is always a 32-bit ARGB color, independent of the source image
//      format.  Alpha is significant, and should usually be set to FF for
//      opaque colorkeys.  (ex. Opaque black == 0xff000000)
//  pSrcInfo
//      Pointer to a D3DXIMAGE_INFO structure to be filled in with the
//      description of the data in the source image file, or NULL.
//
//----------------------------------------------------------------------------
function D3DXLoadSurfaceFromFileA(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  pSrcFile: PAnsiChar;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXLoadSurfaceFromFileA';
{$EXTERNALSYM D3DXLoadSurfaceFromFileA}

function D3DXLoadSurfaceFromFileW(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  pSrcFile: PWideChar;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXLoadSurfaceFromFileW';
{$EXTERNALSYM D3DXLoadSurfaceFromFileW}

function D3DXLoadSurfaceFromFile(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  pSrcFile: PChar;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXLoadSurfaceFromFileA';
{$EXTERNALSYM D3DXLoadSurfaceFromFile}



function D3DXLoadSurfaceFromResourceA(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXLoadSurfaceFromResourceA';
{$EXTERNALSYM D3DXLoadSurfaceFromResourceA}

function D3DXLoadSurfaceFromResourceW(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXLoadSurfaceFromResourceW';
{$EXTERNALSYM D3DXLoadSurfaceFromResourceW}

function D3DXLoadSurfaceFromResource(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  hSrcModule: HModule;
  pSrcResource: PChar;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXLoadSurfaceFromResourceA';
{$EXTERNALSYM D3DXLoadSurfaceFromResource}



function D3DXLoadSurfaceFromFileInMemory(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  const pSrcData: Pointer;
  SrcDataSize: LongWord;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXLoadSurfaceFromFileInMemory}



//----------------------------------------------------------------------------
// D3DXLoadSurfaceFromSurface:
// ---------------------------
// Load surface from another surface (with color conversion)
//
// Parameters:
//  pDestSurface
//      Destination surface, which will receive the image.
//  pDestPalette
//      Destination palette of 256 colors, or NULL
//  pDestRect
//      Destination rectangle, or NULL for entire surface
//  pSrcSurface
//      Source surface
//  pSrcPalette
//      Source palette of 256 colors, or NULL
//  pSrcRect
//      Source rectangle, or NULL for entire surface
//  Filter
//      D3DX_FILTER flags controlling how the image is filtered.
//      Or D3DX_DEFAULT for D3DX_FILTER_TRIANGLE.
//  ColorKey
//      Color to replace with transparent black, or 0 to disable colorkey.
//      This is always a 32-bit ARGB color, independent of the source image
//      format.  Alpha is significant, and should usually be set to FF for
//      opaque colorkeys.  (ex. Opaque black == 0xff000000)
//
//----------------------------------------------------------------------------

function D3DXLoadSurfaceFromSurface(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  pSrcSurface: IDirect3DSurface9;
  pSrcPalette: PPaletteEntry;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXLoadSurfaceFromSurface}



//----------------------------------------------------------------------------
// D3DXLoadSurfaceFromMemory:
// ---------------------------
// Load surface from memory.
//
// Parameters:
//  pDestSurface
//      Destination surface, which will receive the image.
//  pDestPalette
//      Destination palette of 256 colors, or NULL
//  pDestRect
//      Destination rectangle, or NULL for entire surface
//  pSrcMemory
//      Pointer to the top-left corner of the source image in memory
//  SrcFormat
//      Pixel format of the source image.
//  SrcPitch
//      Pitch of source image, in bytes.  For DXT formats, this number
//      should represent the width of one row of cells, in bytes.
//  pSrcPalette
//      Source palette of 256 colors, or NULL
//  pSrcRect
//      Source rectangle.
//  Filter
//      D3DX_FILTER flags controlling how the image is filtered.
//      Or D3DX_DEFAULT for D3DX_FILTER_TRIANGLE.
//  ColorKey
//      Color to replace with transparent black, or 0 to disable colorkey.
//      This is always a 32-bit ARGB color, independent of the source image
//      format.  Alpha is significant, and should usually be set to FF for
//      opaque colorkeys.  (ex. Opaque black == 0xff000000)
//
//----------------------------------------------------------------------------

function D3DXLoadSurfaceFromMemory(
  pDestSurface: IDirect3DSurface9;
  pDestPalette: PPaletteEntry;
  pDestRect: PRect;
  const pSrcMemory: Pointer;
  SrcFormat: TD3DFormat;
  SrcPitch: LongWord;
  pSrcPalette: PPaletteEntry;
  pSrcRect: PRect;
  Filter: DWord;
  ColorKey: TD3DColor): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXLoadSurfaceFromMemory}



//----------------------------------------------------------------------------
// D3DXSaveSurfaceToFile:
// ----------------------
// Save a surface to a image file.
//
// Parameters:
//  pDestFile
//      File name of the destination file
//  DestFormat
//      D3DXIMAGE_FILEFORMAT specifying file format to use when saving.
//  pSrcSurface
//      Source surface, containing the image to be saved
//  pSrcPalette
//      Source palette of 256 colors, or NULL
//  pSrcRect
//      Source rectangle, or NULL for the entire image
//
//----------------------------------------------------------------------------

function D3DXSaveSurfaceToFileA(
  pDestFile: PAnsiChar;
  DestFormat: TD3DXImageFileFormat;
  pSrcSurface: IDirect3DSurface9;
  pSrcPalette: PPaletteEntry;
  pSrcRect: PRect): HResult; stdcall; external d3dx9texDLL name 'D3DXSaveSurfaceToFileA';
{$EXTERNALSYM D3DXSaveSurfaceToFileA}

function D3DXSaveSurfaceToFileW(
  pDestFile: PWideChar;
  DestFormat: TD3DXImageFileFormat;
  pSrcSurface: IDirect3DSurface9;
  pSrcPalette: PPaletteEntry;
  pSrcRect: PRect): HResult; stdcall; external d3dx9texDLL name 'D3DXSaveSurfaceToFileW';
{$EXTERNALSYM D3DXSaveSurfaceToFileW}

function D3DXSaveSurfaceToFile(
  pDestFile: PChar;
  DestFormat: TD3DXImageFileFormat;
  pSrcSurface: IDirect3DSurface9;
  pSrcPalette: PPaletteEntry;
  pSrcRect: PRect): HResult; stdcall; external d3dx9texDLL name 'D3DXSaveSurfaceToFileA';
{$EXTERNALSYM D3DXSaveSurfaceToFile}


//----------------------------------------------------------------------------
// D3DXSaveSurfaceToFileInMemory:
// ----------------------
// Save a surface to a image file.
//
// Parameters:
//  ppDestBuf
//      address of pointer to d3dxbuffer for returning data bits
//  DestFormat
//      D3DXIMAGE_FILEFORMAT specifying file format to use when saving.
//  pSrcSurface
//      Source surface, containing the image to be saved
//  pSrcPalette
//      Source palette of 256 colors, or NULL
//  pSrcRect
//      Source rectangle, or NULL for the entire image
//
//----------------------------------------------------------------------------

function D3DXSaveSurfaceToFileInMemory(
  out ppDestBuf: ID3DXBuffer;
  DestFormat: TD3DXImageFileFormat;
  pSrcSurface: IDirect3DSurface9;
  pSrcPalette: PPaletteEntry;
  pSrcRect: PRect): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXSaveSurfaceToFileInMemory}


//////////////////////////////////////////////////////////////////////////////
// Load/Save Volume APIs /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////


//----------------------------------------------------------------------------
// D3DXLoadVolumeFromFile/Resource:
// --------------------------------
// Load volume from a file or resource
//
// Parameters:
//  pDestVolume
//      Destination volume, which will receive the image.
//  pDestPalette
//      Destination palette of 256 colors, or NULL
//  pDestBox
//      Destination box, or NULL for entire volume
//  pSrcFile
//      File name of the source image.
//  pSrcModule
//      Module where resource is located, or NULL for module associated
//      with image the os used to create the current process.
//  pSrcResource
//      Resource name
//  pSrcData
//      Pointer to file in memory.
//  SrcDataSize
//      Size in bytes of file in memory.
//  pSrcBox
//      Source box, or NULL for entire image
//  Filter
//      D3DX_FILTER flags controlling how the image is filtered.
//      Or D3DX_DEFAULT for D3DX_FILTER_TRIANGLE.
//  ColorKey
//      Color to replace with transparent black, or 0 to disable colorkey.
//      This is always a 32-bit ARGB color, independent of the source image
//      format.  Alpha is significant, and should usually be set to FF for
//      opaque colorkeys.  (ex. Opaque black == 0xff000000)
//  pSrcInfo
//      Pointer to a D3DXIMAGE_INFO structure to be filled in with the
//      description of the data in the source image file, or NULL.
//
//----------------------------------------------------------------------------

function D3DXLoadVolumeFromFileA(
  pDestVolume: IDirect3DVolume9;
  pDestPalette: PPaletteEntry;
  pDestBox: TD3DBox;
  pSrcFile: PAnsiChar;
  pSrcBox: TD3DBox;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXLoadVolumeFromFileA';
{$EXTERNALSYM D3DXLoadVolumeFromFileA}

function D3DXLoadVolumeFromFileW(
  pDestVolume: IDirect3DVolume9;
  pDestPalette: PPaletteEntry;
  pDestBox: TD3DBox;
  pSrcFile: PWideChar;
  pSrcBox: TD3DBox;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXLoadVolumeFromFileW';
{$EXTERNALSYM D3DXLoadVolumeFromFileW}

function D3DXLoadVolumeFromFile(
  pDestVolume: IDirect3DVolume9;
  pDestPalette: PPaletteEntry;
  pDestBox: TD3DBox;
  pSrcFile: PChar;
  pSrcBox: TD3DBox;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXLoadVolumeFromFileA';
{$EXTERNALSYM D3DXLoadVolumeFromFile}


function D3DXLoadVolumeFromResourceA(
  pDestVolume: IDirect3DVolume9;
  pDestPalette: PPaletteEntry;
  pDestBox: TD3DBox;
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  pSrcBox: TD3DBox;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXLoadVolumeFromResourceA';
{$EXTERNALSYM D3DXLoadVolumeFromResourceA}

function D3DXLoadVolumeFromResourceW(
  pDestVolume: IDirect3DVolume9;
  pDestPalette: PPaletteEntry;
  pDestBox: TD3DBox;
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  pSrcBox: TD3DBox;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXLoadVolumeFromResourceW';
{$EXTERNALSYM D3DXLoadVolumeFromResourceW}

function D3DXLoadVolumeFromResource(
  pDestVolume: IDirect3DVolume9;
  pDestPalette: PPaletteEntry;
  pDestBox: TD3DBox;
  hSrcModule: HModule;
  pSrcResource: PChar;
  pSrcBox: TD3DBox;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL name 'D3DXLoadVolumeFromResourceA';
{$EXTERNALSYM D3DXLoadVolumeFromResource}


function D3DXLoadVolumeFromFileInMemory(
  pDestVolume: IDirect3DVolume9;
  pDestPalette: PPaletteEntry;
  pDestBox: TD3DBox;
  const pSrcData: Pointer;
  SrcDataSize: LongWord;
  pSrcBox: TD3DBox;
  Filter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXLoadVolumeFromFileInMemory}



//----------------------------------------------------------------------------
// D3DXLoadVolumeFromVolume:
// ---------------------------
// Load volume from another volume (with color conversion)
//
// Parameters:
//  pDestVolume
//      Destination volume, which will receive the image.
//  pDestPalette
//      Destination palette of 256 colors, or NULL
//  pDestBox
//      Destination box, or NULL for entire volume
//  pSrcVolume
//      Source volume
//  pSrcPalette
//      Source palette of 256 colors, or NULL
//  pSrcBox
//      Source box, or NULL for entire volume
//  Filter
//      D3DX_FILTER flags controlling how the image is filtered.
//      Or D3DX_DEFAULT for D3DX_FILTER_TRIANGLE.
//  ColorKey
//      Color to replace with transparent black, or 0 to disable colorkey.
//      This is always a 32-bit ARGB color, independent of the source image
//      format.  Alpha is significant, and should usually be set to FF for
//      opaque colorkeys.  (ex. Opaque black == 0xff000000)
//
//----------------------------------------------------------------------------

function D3DXLoadVolumeFromVolume(
  pDestVolume: IDirect3DVolume9;
  pDestPalette: PPaletteEntry;
  pDestBox: TD3DBox;
  pSrcVolume: IDirect3DVolume9;
  pSrcPalette: PPaletteEntry;
  pSrcBox: TD3DBox;
  Filter: DWord;
  ColorKey: TD3DColor): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXLoadVolumeFromVolume}



//----------------------------------------------------------------------------
// D3DXLoadVolumeFromMemory:
// ---------------------------
// Load volume from memory.
//
// Parameters:
//  pDestVolume
//      Destination volume, which will receive the image.
//  pDestPalette
//      Destination palette of 256 colors, or NULL
//  pDestBox
//      Destination box, or NULL for entire volume
//  pSrcMemory
//      Pointer to the top-left corner of the source volume in memory
//  SrcFormat
//      Pixel format of the source volume.
//  SrcRowPitch
//      Pitch of source image, in bytes.  For DXT formats, this number
//      should represent the size of one row of cells, in bytes.
//  SrcSlicePitch
//      Pitch of source image, in bytes.  For DXT formats, this number
//      should represent the size of one slice of cells, in bytes.
//  pSrcPalette
//      Source palette of 256 colors, or NULL
//  pSrcBox
//      Source box.
//  Filter
//      D3DX_FILTER flags controlling how the image is filtered.
//      Or D3DX_DEFAULT for D3DX_FILTER_TRIANGLE.
//  ColorKey
//      Color to replace with transparent black, or 0 to disable colorkey.
//      This is always a 32-bit ARGB color, independent of the source image
//      format.  Alpha is significant, and should usually be set to FF for
//      opaque colorkeys.  (ex. Opaque black == 0xff000000)
//
//----------------------------------------------------------------------------

function D3DXLoadVolumeFromMemory(
  pDestVolume: IDirect3DVolume9;
  pDestPalette: PPaletteEntry;
  pDestBox: TD3DBox;
  const pSrcMemory: Pointer;
  SrcFormat: TD3DFormat;
  SrcRowPitch: LongWord;
  SrcSlicePitch: LongWord;
  pSrcPalette: PPaletteEntry;
  pSrcBox: TD3DBox;
  Filter: DWord;
  ColorKey: TD3DColor): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXLoadVolumeFromMemory}



//----------------------------------------------------------------------------
// D3DXSaveVolumeToFile:
// ---------------------
// Save a volume to a image file.
//
// Parameters:
//  pDestFile
//      File name of the destination file
//  DestFormat
//      D3DXIMAGE_FILEFORMAT specifying file format to use when saving.
//  pSrcVolume
//      Source volume, containing the image to be saved
//  pSrcPalette
//      Source palette of 256 colors, or NULL
//  pSrcBox
//      Source box, or NULL for the entire volume
//
//----------------------------------------------------------------------------

function D3DXSaveVolumeToFileA(
  pDestFile: PAnsiChar;
  DestFormat: TD3DXImageFileFormat;
  pSrcVolume: IDirect3DVolume9;
  pSrcPalette: PPaletteEntry;
  pSrcBox: TD3DBox): HResult; stdcall; external d3dx9texDLL name 'D3DXSaveVolumeToFileA';
{$EXTERNALSYM D3DXSaveVolumeToFileA}

function D3DXSaveVolumeToFileW(
  pDestFile: PWideChar;
  DestFormat: TD3DXImageFileFormat;
  pSrcVolume: IDirect3DVolume9;
  pSrcPalette: PPaletteEntry;
  pSrcBox: TD3DBox): HResult; stdcall; external d3dx9texDLL name 'D3DXSaveVolumeToFileW';
{$EXTERNALSYM D3DXSaveVolumeToFileW}

function D3DXSaveVolumeToFile(
  pDestFile: PChar;
  DestFormat: TD3DXImageFileFormat;
  pSrcVolume: IDirect3DVolume9;
  pSrcPalette: PPaletteEntry;
  pSrcBox: TD3DBox): HResult; stdcall; external d3dx9texDLL name 'D3DXSaveVolumeToFileA';
{$EXTERNALSYM D3DXSaveVolumeToFile}



//----------------------------------------------------------------------------
// D3DXSaveVolumeToFileInMemory:
// ---------------------
// Save a volume to a image file.
//
// Parameters:
//  pDestFile
//      File name of the destination file
//  DestFormat
//      D3DXIMAGE_FILEFORMAT specifying file format to use when saving.
//  pSrcVolume
//      Source volume, containing the image to be saved
//  pSrcPalette
//      Source palette of 256 colors, or NULL
//  pSrcBox
//      Source box, or NULL for the entire volume
//
//----------------------------------------------------------------------------

function D3DXSaveVolumeToFileInMemory(
  out ppDestBuf: ID3DXBuffer;
  DestFormat: TD3DXImageFileFormat;
  pSrcVolume: IDirect3DVolume9;
  pSrcPalette: PPaletteEntry;
  pSrcBox: TD3DBox): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXSaveVolumeToFileInMemory}

        
//////////////////////////////////////////////////////////////////////////////
// Create/Save Texture APIs //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////


//----------------------------------------------------------------------------
// D3DXCheckTextureRequirements:
// -----------------------------
// Checks texture creation parameters.  If parameters are invalid, this
// function returns corrected parameters.
//
// Parameters:
//
//  pDevice
//      The D3D device to be used
//  pWidth, pHeight, pDepth, pSize
//      Desired size in pixels, or NULL.  Returns corrected size.
//  pNumMipLevels
//      Number of desired mipmap levels, or NULL.  Returns corrected number.
//  Usage
//      Texture usage flags
//  pFormat
//      Desired pixel format, or NULL.  Returns corrected format.
//  Pool
//      Memory pool to be used to create texture
//
//----------------------------------------------------------------------------
function D3DXCheckTextureRequirements(
  pDevice: IDirect3DDevice9;
  pWidth: PLongWord;
  pHeight: PLongWord;
  pNumMipLevels: PLongWord;
  Usage: DWord;
  pFormat: PD3DFormat;
  Pool: TD3DPool): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXCheckTextureRequirements}

function D3DXCheckCubeTextureRequirements(
  pDevice: IDirect3DDevice9;
  pSize: PLongWord;
  pNumMipLevels: PLongWord;
  Usage: DWord;
  pFormat: PD3DFormat;
  Pool: TD3DPool): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXCheckCubeTextureRequirements}

function D3DXCheckVolumeTextureRequirements(
  pDevice: IDirect3DDevice9;
  pWidth: PLongWord;
  pHeight: PLongWord;
  pDepth: PLongWord;
  pNumMipLevels: PLongWord;
  Usage: DWord;
  pFormat: PD3DFormat;
  Pool: TD3DPool): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXCheckVolumeTextureRequirements}


//----------------------------------------------------------------------------
// D3DXCreateTexture:
// ------------------
// Create an empty texture
//
// Parameters:
//
//  pDevice
//      The D3D device with which the texture is going to be used.
//  Width, Height, Depth, Size
//      size in pixels. these must be non-zero
//  MipLevels
//      number of mip levels desired. if zero or D3DX_DEFAULT, a complete
//      mipmap chain will be created.
//  Usage
//      Texture usage flags
//  Format
//      Pixel format.
//  Pool
//      Memory pool to be used to create texture
//  ppTexture, ppCubeTexture, ppVolumeTexture
//      The texture object that will be created
//
//----------------------------------------------------------------------------

function D3DXCreateTexture(
  Device: IDirect3DDevice9;
  Width: LongWord;
  Height: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXCreateTexture}

function D3DXCreateCubeTexture(
  Device: IDirect3DDevice9;
  Size: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXCreateCubeTexture}

function D3DXCreateVolumeTexture(
  Device: IDirect3DDevice9;
  Width: LongWord;
  Height: LongWord;
  Depth: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXCreateVolumeTexture}



//----------------------------------------------------------------------------
// D3DXCreateTextureFromFile/Resource:
// -----------------------------------
// Create a texture object from a file or resource.
//
// Parameters:
//
//  pDevice
//      The D3D device with which the texture is going to be used.
//  pSrcFile
//      File name.
//  hSrcModule
//      Module handle. if NULL, current module will be used.
//  pSrcResource
//      Resource name in module
//  pvSrcData
//      Pointer to file in memory.
//  SrcDataSize
//      Size in bytes of file in memory.
//  Width, Height, Depth, Size
//      Size in pixels.  If zero or D3DX_DEFAULT, the size will be taken from 
//      the file and rounded up to a power of two.  If D3DX_DEFAULT_NONPOW2, 
//      and the device supports NONPOW2 textures, the size will not be rounded.
//      If D3DX_FROM_FILE, the size will be taken exactly as it is in the file, 
//      and the call will fail if this violates device capabilities.
//  MipLevels
//      Number of mip levels.  If zero or D3DX_DEFAULT, a complete mipmap
//      chain will be created.  If D3DX_FROM_FILE, the size will be taken 
//      exactly as it is in the file, and the call will fail if this violates 
//      device capabilities.
//  Usage
//      Texture usage flags
//  Format
//      Desired pixel format.  If D3DFMT_UNKNOWN, the format will be
//      taken from the file.  If D3DFMT_FROM_FILE, the format will be taken
//      exactly as it is in the file, and the call will fail if the device does
//      not support the given format.
//  Pool
//      Memory pool to be used to create texture
//  Filter
//      D3DX_FILTER flags controlling how the image is filtered.
//      Or D3DX_DEFAULT for D3DX_FILTER_TRIANGLE.
//  MipFilter
//      D3DX_FILTER flags controlling how each miplevel is filtered.
//      Or D3DX_DEFAULT for D3DX_FILTER_BOX.
//      Use the D3DX_SKIP_DDS_MIP_LEVELS macro to specify both a filter and the
//      number of mip levels to skip when loading DDS files.
//  ColorKey
//      Color to replace with transparent black, or 0 to disable colorkey.
//      This is always a 32-bit ARGB color, independent of the source image
//      format.  Alpha is significant, and should usually be set to FF for
//      opaque colorkeys.  (ex. Opaque black == 0xff000000)
//  pSrcInfo
//      Pointer to a D3DXIMAGE_INFO structure to be filled in with the
//      description of the data in the source image file, or NULL.
//  pPalette
//      256 color palette to be filled in, or NULL
//  ppTexture, ppCubeTexture, ppVolumeTexture
//      The texture object that will be created
//
//----------------------------------------------------------------------------

// FromFile

function D3DXCreateTextureFromFileA(
  Device: IDirect3DDevice9;
  pSrcFile: PAnsiChar;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateTextureFromFileA';
{$EXTERNALSYM D3DXCreateTextureFromFileA}

function D3DXCreateTextureFromFileW(
  Device: IDirect3DDevice9;
  pSrcFile: PWideChar;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateTextureFromFileW';
{$EXTERNALSYM D3DXCreateTextureFromFileW}

function D3DXCreateTextureFromFile(
  Device: IDirect3DDevice9;
  pSrcFile: PChar;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateTextureFromFileA';
{$EXTERNALSYM D3DXCreateTextureFromFile}


function D3DXCreateCubeTextureFromFileA(
  Device: IDirect3DDevice9;
  pSrcFile: PAnsiChar;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateCubeTextureFromFileA';
{$EXTERNALSYM D3DXCreateCubeTextureFromFileA}

function D3DXCreateCubeTextureFromFileW(
  Device: IDirect3DDevice9;
  pSrcFile: PWideChar;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateCubeTextureFromFileW';
{$EXTERNALSYM D3DXCreateCubeTextureFromFileW}

function D3DXCreateCubeTextureFromFile(
  Device: IDirect3DDevice9;
  pSrcFile: PChar;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateCubeTextureFromFileA';
{$EXTERNALSYM D3DXCreateCubeTextureFromFile}


function D3DXCreateVolumeTextureFromFileA(
  Device: IDirect3DDevice9;
  pSrcFile: PAnsiChar;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateVolumeTextureFromFileA';
{$EXTERNALSYM D3DXCreateVolumeTextureFromFileA}

function D3DXCreateVolumeTextureFromFileW(
  Device: IDirect3DDevice9;
  pSrcFile: PWideChar;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateVolumeTextureFromFileW';
{$EXTERNALSYM D3DXCreateVolumeTextureFromFileW}

function D3DXCreateVolumeTextureFromFile(
  Device: IDirect3DDevice9;
  pSrcFile: PChar;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateVolumeTextureFromFileA';
{$EXTERNALSYM D3DXCreateVolumeTextureFromFile}


// FromResource

function D3DXCreateTextureFromResourceA(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateTextureFromResourceA';
{$EXTERNALSYM D3DXCreateTextureFromResourceA}

function D3DXCreateTextureFromResourceW(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateTextureFromResourceW';
{$EXTERNALSYM D3DXCreateTextureFromResourceW}

function D3DXCreateTextureFromResource(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PChar;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateTextureFromResourceA';
{$EXTERNALSYM D3DXCreateTextureFromResource}


function D3DXCreateCubeTextureFromResourceA(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateCubeTextureFromResourceA';
{$EXTERNALSYM D3DXCreateCubeTextureFromResourceA}

function D3DXCreateCubeTextureFromResourceW(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateCubeTextureFromResourceW';
{$EXTERNALSYM D3DXCreateCubeTextureFromResourceW}

function D3DXCreateCubeTextureFromResource(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PChar;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateCubeTextureFromResourceA';
{$EXTERNALSYM D3DXCreateCubeTextureFromResource}


function D3DXCreateVolumeTextureFromResourceA(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateVolumeTextureFromResourceA';
{$EXTERNALSYM D3DXCreateVolumeTextureFromResourceA}

function D3DXCreateVolumeTextureFromResourceW(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateVolumeTextureFromResourceW';
{$EXTERNALSYM D3DXCreateVolumeTextureFromResourceW}

function D3DXCreateVolumeTextureFromResource(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PChar;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateVolumeTextureFromResourceA';
{$EXTERNALSYM D3DXCreateVolumeTextureFromResource}


// FromFileEx

function D3DXCreateTextureFromFileExA(
  Device: IDirect3DDevice9;
  pSrcFile: PAnsiChar;
  Width: LongWord;
  Height: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateTextureFromFileExA';
{$EXTERNALSYM D3DXCreateTextureFromFileExA}

function D3DXCreateTextureFromFileExW(
  Device: IDirect3DDevice9;
  pSrcFile: PWideChar;
  Width: LongWord;
  Height: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateTextureFromFileExW';
{$EXTERNALSYM D3DXCreateTextureFromFileExW}

function D3DXCreateTextureFromFileEx(
  Device: IDirect3DDevice9;
  pSrcFile: PChar;
  Width: LongWord;
  Height: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateTextureFromFileExA';
{$EXTERNALSYM D3DXCreateTextureFromFileEx}


function D3DXCreateCubeTextureFromFileExA(
  Device: IDirect3DDevice9;
  pSrcFile: PAnsiChar;
  Size: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateCubeTextureFromFileExA';
{$EXTERNALSYM D3DXCreateCubeTextureFromFileExA}

function D3DXCreateCubeTextureFromFileExW(
  Device: IDirect3DDevice9;
  pSrcFile: PWideChar;
  Size: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateCubeTextureFromFileExW';
{$EXTERNALSYM D3DXCreateCubeTextureFromFileExW}

function D3DXCreateCubeTextureFromFileEx(
  Device: IDirect3DDevice9;
  pSrcFile: PChar;
  Size: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateCubeTextureFromFileExA';
{$EXTERNALSYM D3DXCreateCubeTextureFromFileEx}


function D3DXCreateVolumeTextureFromFileExA(
  Device: IDirect3DDevice9;
  pSrcFile: PAnsiChar;
  Width: LongWord;
  Height: LongWord;
  Depth: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateVolumeTextureFromFileExA';
{$EXTERNALSYM D3DXCreateVolumeTextureFromFileExA}

function D3DXCreateVolumeTextureFromFileExW(
  Device: IDirect3DDevice9;
  pSrcFile: PWideChar;
  Width: LongWord;
  Height: LongWord;
  Depth: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateVolumeTextureFromFileExW';
{$EXTERNALSYM D3DXCreateVolumeTextureFromFileExW}

function D3DXCreateVolumeTextureFromFileEx(
  Device: IDirect3DDevice9;
  pSrcFile: PChar;
  Width: LongWord;
  Height: LongWord;
  Depth: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateVolumeTextureFromFileExA';
{$EXTERNALSYM D3DXCreateVolumeTextureFromFileEx}


// FromResourceEx

function D3DXCreateTextureFromResourceExA(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  Width: LongWord;
  Height: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateTextureFromResourceExA';
{$EXTERNALSYM D3DXCreateTextureFromResourceExA}

function D3DXCreateTextureFromResourceExW(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  Width: LongWord;
  Height: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateTextureFromResourceExW';
{$EXTERNALSYM D3DXCreateTextureFromResourceExW}

function D3DXCreateTextureFromResourceEx(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PChar;
  Width: LongWord;
  Height: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateTextureFromResourceExA';
{$EXTERNALSYM D3DXCreateTextureFromResourceEx}


function D3DXCreateCubeTextureFromResourceExA(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  Size: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateCubeTextureFromResourceExA';
{$EXTERNALSYM D3DXCreateCubeTextureFromResourceExA}

function D3DXCreateCubeTextureFromResourceExW(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  Size: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateCubeTextureFromResourceExW';
{$EXTERNALSYM D3DXCreateCubeTextureFromResourceExW}

function D3DXCreateCubeTextureFromResourceEx(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PChar;
  Size: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateCubeTextureFromResourceExA';
{$EXTERNALSYM D3DXCreateCubeTextureFromResourceEx}


function D3DXCreateVolumeTextureFromResourceExA(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PAnsiChar;
  Width: LongWord;
  Height: LongWord;
  Depth: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateVolumeTextureFromResourceExA';
{$EXTERNALSYM D3DXCreateVolumeTextureFromResourceExA}

function D3DXCreateVolumeTextureFromResourceExW(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PWideChar;
  Width: LongWord;
  Height: LongWord;
  Depth: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateVolumeTextureFromResourceExW';
{$EXTERNALSYM D3DXCreateVolumeTextureFromResourceExW}

function D3DXCreateVolumeTextureFromResourceEx(
  Device: IDirect3DDevice9;
  hSrcModule: HModule;
  pSrcResource: PChar;
  Width: LongWord;
  Height: LongWord;
  Depth: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL name 'D3DXCreateVolumeTextureFromResourceExA';
{$EXTERNALSYM D3DXCreateVolumeTextureFromResourceEx}


// FromFileInMemory

function D3DXCreateTextureFromFileInMemory(
  Device: IDirect3DDevice9;
  const pSrcData: Pointer;
  SrcDataSize: LongWord;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXCreateTextureFromFileInMemory}

function D3DXCreateCubeTextureFromFileInMemory(
  Device: IDirect3DDevice9;
  const pSrcData: Pointer;
  SrcDataSize: LongWord;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXCreateCubeTextureFromFileInMemory}

function D3DXCreateVolumeTextureFromFileInMemory(
  Device: IDirect3DDevice9;
  const pSrcData: Pointer;
  SrcDataSize: LongWord;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXCreateVolumeTextureFromFileInMemory}


// FromFileInMemoryEx

function D3DXCreateTextureFromFileInMemoryEx(
  Device: IDirect3DDevice9;
  const pSrcData: Pointer;
  SrcDataSize: LongWord;
  Width: LongWord;
  Height: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppTexture: IDirect3DTexture9): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXCreateTextureFromFileInMemoryEx}

function D3DXCreateCubeTextureFromFileInMemoryEx(
  Device: IDirect3DDevice9;
  const pSrcData: Pointer;
  SrcDataSize: LongWord;
  Size: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppCubeTexture: IDirect3DCubeTexture9): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXCreateCubeTextureFromFileInMemoryEx}

function D3DXCreateVolumeTextureFromFileInMemoryEx(
  Device: IDirect3DDevice9;
  const pSrcData: Pointer;
  SrcDataSize: LongWord;
  Width: LongWord;
  Height: LongWord;
  Depth: LongWord;
  MipLevels: LongWord;
  Usage: DWord;
  Format: TD3DFormat;
  Pool: TD3DPool;
  Filter: DWord;
  MipFilter: DWord;
  ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo;
  pPalette: PPaletteEntry;
  out ppVolumeTexture: IDirect3DVolumeTexture9): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXCreateVolumeTextureFromFileInMemoryEx}



//----------------------------------------------------------------------------
// D3DXSaveTextureToFile:
// ----------------------
// Save a texture to a file.
//
// Parameters:
//  pDestFile
//      File name of the destination file
//  DestFormat
//      D3DXIMAGE_FILEFORMAT specifying file format to use when saving.
//  pSrcTexture
//      Source texture, containing the image to be saved
//  pSrcPalette
//      Source palette of 256 colors, or NULL
//
//----------------------------------------------------------------------------


function D3DXSaveTextureToFileA(
  pDestFile: PAnsiChar;
  DestFormat: TD3DXImageFileFormat;
  pSrcTexture: IDirect3DBaseTexture9;
  pSrcPalette: PPaletteEntry): HResult; stdcall; external d3dx9texDLL name 'D3DXSaveTextureToFileA';
{$EXTERNALSYM D3DXSaveTextureToFileA}

function D3DXSaveTextureToFileW(
  pDestFile: PWideChar;
  DestFormat: TD3DXImageFileFormat;
  pSrcTexture: IDirect3DBaseTexture9;
  pSrcPalette: PPaletteEntry): HResult; stdcall; external d3dx9texDLL name 'D3DXSaveTextureToFileW';
{$EXTERNALSYM D3DXSaveTextureToFileW}

function D3DXSaveTextureToFile(
  pDestFile: PChar;
  DestFormat: TD3DXImageFileFormat;
  pSrcTexture: IDirect3DBaseTexture9;
  pSrcPalette: PPaletteEntry): HResult; stdcall; external d3dx9texDLL name 'D3DXSaveTextureToFileA';
{$EXTERNALSYM D3DXSaveTextureToFile}



//----------------------------------------------------------------------------
// D3DXSaveTextureToFileInMemory:
// ----------------------
// Save a texture to a file.
//
// Parameters:
//  ppDestBuf
//      address of a d3dxbuffer pointer to return the image data
//  DestFormat
//      D3DXIMAGE_FILEFORMAT specifying file format to use when saving.
//  pSrcTexture
//      Source texture, containing the image to be saved
//  pSrcPalette
//      Source palette of 256 colors, or NULL
//
//----------------------------------------------------------------------------

function D3DXSaveTextureToFileInMemory(
  out ppDestBuf: ID3DXBuffer;
  DestFormat: TD3DXImageFileFormat;
  pSrcTexture: IDirect3DBaseTexture9;
  pSrcPalette: PPaletteEntry): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXSaveTextureToFileInMemory}




//////////////////////////////////////////////////////////////////////////////
// Misc Texture APIs /////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// D3DXFilterTexture:
// ------------------
// Filters mipmaps levels of a texture.
//
// Parameters:
//  pBaseTexture
//      The texture object to be filtered
//  pPalette
//      256 color palette to be used, or NULL for non-palettized formats
//  SrcLevel
//      The level whose image is used to generate the subsequent levels.
//  Filter
//      D3DX_FILTER flags controlling how each miplevel is filtered.
//      Or D3DX_DEFAULT for D3DX_FILTER_BOX,
//
//-------------------------------------------------------------------------

function D3DXFilterTexture(
  pTexture: IDirect3DTexture9;
  pPalette: PPaletteEntry;
  SrcLevel: LongWord;
  Filter: DWord): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXFilterTexture}

// #define D3DXFilterCubeTexture D3DXFilterTexture
// In Pascal this mapped to DLL-exported "D3DXFilterTexture" function
function D3DXFilterCubeTexture(
  pTexture: IDirect3DCubeTexture9;
  pPalette: PPaletteEntry;
  SrcLevel: LongWord;
  Filter: DWord): HResult; stdcall; external d3dx9texDLL name 'D3DXFilterTexture';
{$EXTERNALSYM D3DXFilterCubeTexture}

// #define D3DXFilterVolumeTexture D3DXFilterTexture
// In Pascal this mapped to DLL-exported "D3DXFilterTexture" function
function D3DXFilterVolumeTexture(
  pTexture: IDirect3DVolumeTexture9;
  pPalette: PPaletteEntry;
  SrcLevel: LongWord;
  Filter: DWord): HResult; stdcall; external d3dx9texDLL name 'D3DXFilterTexture';
{$EXTERNALSYM D3DXFilterVolumeTexture}



//----------------------------------------------------------------------------
// D3DXFillTexture:
// ----------------
// Uses a user provided function to fill each texel of each mip level of a
// given texture.
//
// Paramters:
//  pTexture, pCubeTexture, pVolumeTexture
//      Pointer to the texture to be filled.
//  pFunction
//      Pointer to user provided evalutor function which will be used to
//      compute the value of each texel.
//  pData
//      Pointer to an arbitrary block of user defined data.  This pointer
//      will be passed to the function provided in pFunction
//-----------------------------------------------------------------------------

function D3DXFillTexture(
  pTexture: IDirect3DTexture9;
  pFunction: TD3DXFill2D;
  pData: Pointer): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXFillTexture}

function D3DXFillCubeTexture(
  pCubeTexture: IDirect3DCubeTexture9;
  pFunction: TD3DXFill3D;
  pData: Pointer): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXFillCubeTexture}

function D3DXFillVolumeTexture(
  pVolumeTexture: IDirect3DVolumeTexture9;
  pFunction: TD3DXFill3D;
  pData: Pointer): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXFillVolumeTexture}

//---------------------------------------------------------------------------
// D3DXFillTextureTX:
// ------------------
// Uses a TX Shader target to function to fill each texel of each mip level
// of a given texture. The TX Shader target should be a compiled function
// taking 2 paramters and returning a float4 color.
//
// Paramters:
//  pTexture, pCubeTexture, pVolumeTexture
//      Pointer to the texture to be filled.
//  pTextureShader
//      Pointer to the texture shader to be used to fill in the texture
//----------------------------------------------------------------------------

function D3DXFillTextureTX(
  pTexture: IDirect3DTexture9;
  pTextureShader: ID3DXTextureShader): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXFillTextureTX}


function D3DXFillCubeTextureTX(
  pCubeTexture: IDirect3DCubeTexture9;
  pTextureShader: ID3DXTextureShader): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXFillCubeTextureTX}


function D3DXFillVolumeTextureTX(
  pVolumeTexture: IDirect3DVolumeTexture9;
  pTextureShader: ID3DXTextureShader): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXFillVolumeTextureTX}


//----------------------------------------------------------------------------
// D3DXComputeNormalMap:
// ---------------------
// Converts a height map into a normal map.  The (x,y,z) components of each
// normal are mapped to the (r,g,b) channels of the output texture.
//
// Parameters
//  pTexture
//      Pointer to the destination texture
//  pSrcTexture
//      Pointer to the source heightmap texture
//  pSrcPalette
//      Source palette of 256 colors, or NULL
//  Flags
//      D3DX_NORMALMAP flags
//  Channel
//      D3DX_CHANNEL specifying source of height information
//  Amplitude
//      The constant value which the height information is multiplied by.
//---------------------------------------------------------------------------

function D3DXComputeNormalMap(
  pTexture: IDirect3DTexture9;
  pSrcTexture: IDirect3DTexture9;
  pSrcPalette: PPaletteEntry;
  Flags: DWord;
  Channel: DWord;
  Amplitude: Single): HResult; stdcall; external d3dx9texDLL;
{$EXTERNALSYM D3DXComputeNormalMap}





//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9anim.h
//  Content:    D3DX mesh types and functions
//
//////////////////////////////////////////////////////////////////////////////

type
  //----------------------------------------------------------------------------
  // D3DXMESHDATATYPE:
  // -----------------
  // This enum defines the type of mesh data present in a MeshData structure.
  //----------------------------------------------------------------------------
  _D3DXMESHDATATYPE = (
    D3DXMESHTYPE_MESH      = $001,      // Normal ID3DXMesh data
    D3DXMESHTYPE_PMESH     = $002,      // Progressive Mesh - ID3DXPMesh
    D3DXMESHTYPE_PATCHMESH = $003       // Patch Mesh - ID3DXPatchMesh
  );
  {$EXTERNALSYM _D3DXMESHDATATYPE}
  D3DXMESHDATATYPE = _D3DXMESHDATATYPE;
  {$EXTERNALSYM D3DXMESHDATATYPE}
  TD3DXMeshDataType = _D3DXMESHDATATYPE;

  //----------------------------------------------------------------------------
  // D3DXMESHDATA:
  // -------------
  // This struct encapsulates a the mesh data that can be present in a mesh
  // container.  The supported mesh types are pMesh, pPMesh, pPatchMesh.
  // The valid way to access this is determined by the Type enum.
  //----------------------------------------------------------------------------
  PD3DXMeshData = ^TD3DXMeshData;
  _D3DXMESHDATA = record
    _Type: TD3DXMeshDataType;

    // current mesh data interface
    // *** Translator ***: Delphi doesn't allow interfaces in variant records
    // so I declare only one field that can be casted in code, for examples, as:
    // either  "mesh := ID3DXPatchMesh(pPatchMesh)"
    // or      "mesh := pPatchMesh as ID3DXPatchMesh"
    pMesh: IUnknown;
{   case Byte of // In Delphi use pMesh record item as defined above
      0: (pMesh:              ID3DXMesh);
      1: (pPMesh:             ID3DXPMesh);
      2: (pPatchMesh:         ID3DXPatchMesh); }
  end;
  {$EXTERNALSYM _D3DXMESHDATA}
  D3DXMESHDATA = _D3DXMESHDATA;
  {$EXTERNALSYM D3DXMESHDATA}
  TD3DXMeshData = _D3DXMESHDATA;

  //----------------------------------------------------------------------------
  // D3DXMESHCONTAINER:
  // ------------------
  // This struct encapsulates a mesh object in a transformation frame
  // hierarchy. The app can derive from this structure to add other app specific
  // data to this.
  //----------------------------------------------------------------------------
  PD3DXMeshContainer = ^TD3DXMeshContainer;
  _D3DXMESHCONTAINER = record
    Name:               PAnsiChar;

    MeshData:           TD3DXMeshData;

    pMaterials:         PD3DXMaterial;
    pEffects:           PD3DXEffectInstance;
    NumMaterials:       DWORD;
    pAdjacency:         PDWORD;

    pSkinInfo:          ID3DXSkinInfo;

    pNextMeshContainer: PD3DXMeshContainer;
  end;
  {$EXTERNALSYM _D3DXMESHCONTAINER}
  D3DXMESHCONTAINER = _D3DXMESHCONTAINER;
  {$EXTERNALSYM D3DXMESHCONTAINER}
  TD3DXMeshContainer = _D3DXMESHCONTAINER;

  //----------------------------------------------------------------------------
  // D3DXFRAME:
  // ----------
  // This struct is the encapsulates a transform frame in a transformation frame
  // hierarchy. The app can derive from this structure to add other app specific
  // data to this
  //----------------------------------------------------------------------------
  PD3DXFrame = ^TD3DXFrame;
  _D3DXFRAME = record
    Name:               PAnsiChar;
    TransformationMatrix: TD3DXMatrix;

    pMeshContainer:     PD3DXMeshContainer;

    pFrameSibling:      PD3DXFrame;
    pFrameFirstChild:   PD3DXFrame;
  end;
  {$EXTERNALSYM _D3DXFRAME}
  D3DXFRAME = _D3DXFRAME;
  {$EXTERNALSYM D3DXFRAME}
  TD3DXFrame = _D3DXFRAME;


  //----------------------------------------------------------------------------
  // ID3DXAllocateHierarchy:
  // -----------------------
  // This interface is implemented by the application to allocate/free frame and
  // mesh container objects. Methods on this are called during loading and
  // destroying frame hierarchies
  //----------------------------------------------------------------------------
  {$EXTERNALSYM ID3DXAllocateHierarchy}
  ID3DXAllocateHierarchy = class
    // ID3DXAllocateHierarchy

    //------------------------------------------------------------------------
    // CreateFrame:
    // ------------
    // Requests allocation of a frame object.
    //
    // Parameters:
    //  Name
    //      Name of the frame to be created
    //  ppNewFrame
    //      Returns the created frame object
    //
    //------------------------------------------------------------------------
    function CreateFrame(Name: PAnsiChar; out ppNewFrame: PD3DXFrame): HResult; virtual; stdcall; abstract;

    //------------------------------------------------------------------------
    // CreateMeshContainer:
    // --------------------
    // Requests allocation of a mesh container object.
    //
    // Parameters:
    //  Name
    //    Name of the mesh
    //  pMesh
    //    Pointer to the mesh object if basic polygon data found
    //  pPMesh
    //    Pointer to the progressive mesh object if progressive mesh data found
    //  pPatchMesh
    //    Pointer to the patch mesh object if patch data found
    //  pMaterials
    //    Array of materials used in the mesh
    //  pEffectInstances
    //    Array of effect instances used in the mesh
    //  NumMaterials
    //    Num elements in the pMaterials array
    //  pAdjacency
    //    Adjacency array for the mesh
    //  pSkinInfo
    //    Pointer to the skininfo object if the mesh is skinned
    //  pBoneNames
    //    Array of names, one for each bone in the skinned mesh.
    //    The numberof bones can be found from the pSkinMesh object
    //  pBoneOffsetMatrices
    //    Array of matrices, one for each bone in the skinned mesh.
    //
    //------------------------------------------------------------------------
    function CreateMeshContainer(Name: PAnsiChar; const pMeshData: TD3DXMeshData;
        pMaterials: PD3DXMaterial; pEffectInstances: PD3DXEffectInstance;
        NumMaterials: DWORD; pAdjacency: PDWORD; pSkinInfo: ID3DXSkinInfo;
        out ppNewMeshContainer: PD3DXMeshContainer): HResult; virtual; stdcall; abstract;

    //------------------------------------------------------------------------
    // DestroyFrame:
    // -------------
    // Requests de-allocation of a frame object.
    //
    // Parameters:
    //  pFrameToFree
    //    Pointer to the frame to be de-allocated
    //
    //------------------------------------------------------------------------
    function DestroyFrame(pFrameToFree: PD3DXFrame): HResult; virtual; stdcall; abstract;

    //------------------------------------------------------------------------
    // DestroyMeshContainer:
    // ---------------------
    // Requests de-allocation of a mesh container object.
    //
    // Parameters:
    //  pMeshContainerToFree
    //    Pointer to the mesh container object to be de-allocated
    //
    //------------------------------------------------------------------------
    function DestroyMeshContainer(pMeshContainerToFree: PD3DXMeshContainer): HResult; virtual; stdcall; abstract;
  end;

  //----------------------------------------------------------------------------
  // ID3DXLoadUserData:
  // ------------------
  // This interface is implemented by the application to load user data in a .X file
  // When user data is found, these callbacks will be used to allow the application
  // to load the data.
  //----------------------------------------------------------------------------
  {$EXTERNALSYM ID3DXLoadUserData}
  ID3DXLoadUserData = class
    function LoadTopLevelData(pXofChildData: ID3DXFileData): HResult; virtual; stdcall; abstract;

    function LoadFrameChildData(pFrame: PD3DXFrame;
        pXofChildData: ID3DXFileData): HResult; virtual; stdcall; abstract;

    function LoadMeshChildData(pMeshContainer: PD3DXMeshContainer;
        pXofChildData: ID3DXFileData): HResult; virtual; stdcall; abstract;
  end;

  //----------------------------------------------------------------------------
  // ID3DXSaveUserData:
  // ------------------
  // This interface is implemented by the application to save user data in a .X file
  // The callbacks are called for all data saved.  The user can then add any
  // child data objects to the object provided to the callback.
  //----------------------------------------------------------------------------
  {$EXTERNALSYM ID3DXSaveUserData}
  ID3DXSaveUserData = class
    function AddFrameChildData(pFrame: PD3DXFrame;
        pXofSave: ID3DXFileSaveObject;
        pXofFrameData: ID3DXFileData): HResult; virtual; stdcall; abstract;

    function AddMeshChildData(pMeshContainer: PD3DXMeshContainer;
        pXofSave: ID3DXFileSaveObject; pXofMeshData: ID3DXFileData): HResult; virtual; stdcall; abstract;

    // NOTE: this is called once per Save.  All top level objects should be added using the
    //    provided interface.  One call adds objects before the frame hierarchy, the other after
    function AddTopLevelDataObjectsPre(pXofSave: ID3DXFileSaveObject): HResult; virtual; stdcall; abstract;
    function AddTopLevelDataObjectsPost(pXofSave: ID3DXFileSaveObject): HResult; virtual; stdcall; abstract;

    // callbacks for the user to register and then save templates to the XFile
    function RegisterTemplates(pXFileApi: ID3DXFile): HResult; virtual; stdcall; abstract;
    function SaveTemplates(pXofSave: ID3DXFileSaveObject): HResult; virtual; stdcall; abstract;
  end;


  //----------------------------------------------------------------------------
  // D3DXCALLBACK_SEARCH_FLAGS:
  // --------------------------
  // Flags that can be passed into ID3DXAnimationSet::GetCallback.
  //----------------------------------------------------------------------------
  PD3DXCallbackSearchFlags = ^TD3DXCallbackSearchFlags;
  _D3DXCALLBACK_SEARCH_FLAGS = (
    D3DXCALLBACK_SEARCH_EXCLUDING_INITIAL_POSITION = $01,  // exclude callbacks at the initial position from the search
    D3DXCALLBACK_SEARCH_BEHIND_INITIAL_POSITION    = $02   // reverse the callback search direction
  );
  {$EXTERNALSYM _D3DXCALLBACK_SEARCH_FLAGS}
  D3DXCALLBACK_SEARCH_FLAGS = _D3DXCALLBACK_SEARCH_FLAGS;
  {$EXTERNALSYM D3DXCALLBACK_SEARCH_FLAGS}
  TD3DXCallbackSearchFlags = _D3DXCALLBACK_SEARCH_FLAGS;

  //----------------------------------------------------------------------------
  // ID3DXAnimationSet:
  // ------------------
  // This interface implements an animation set.
  //----------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXAnimationSet);'}
  {$EXTERNALSYM ID3DXAnimationSet}
  ID3DXAnimationSet = interface(IUnknown)
    ['{698CFB3F-9289-4d95-9A57-33A94B5A65F9}']
    // Name
    function GetName: PAnsiChar; stdcall;

    // Period
    function GetPeriod: Double; stdcall;
    function GetPeriodicPosition(Position: Double): Double; stdcall;    // Maps position into animation period

    // Animation names
    function GetNumAnimations: LongWord; stdcall;
    function GetAnimationNameByIndex(Index: LongWord; out ppName: PAnsiChar): HResult; stdcall;
    function GetAnimationIndexByName(pName: LPCSTR; out pIndex: LongWord): HResult; stdcall;

    // SRT
    //todo: Check for NULL
    function GetSRT(
        PeriodicPosition: Double;            // Position mapped to period (use GetPeriodicPosition)
        Animation: LongWord;                 // Animation index
        pScale: PD3DXVector3;                // Returns the scale
        pRotation: PD3DXQuaternion;          // Returns the rotation as a quaternion
        pTranslation: PD3DXVector3           // Returns the translation
      ): HResult; stdcall;

    // Callbacks
    //todo: Check for NULL
    function GetCallback(
        Position: Double;                    // Position from which to find callbacks
        Flags: DWORD;                        // Callback search flags
        pCallbackPosition: PDouble;          // Returns the position of the callback
        ppCallbackData: Pointer              // Returns the callback data pointer
      ): HResult; stdcall;
  end;


  //----------------------------------------------------------------------------
  // D3DXPLAYBACK_TYPE:
  // ------------------
  // This enum defines the type of animation set loop modes.
  //----------------------------------------------------------------------------
  PD3DXPlaybackType = ^TD3DXPlaybackType;
  _D3DXPLAYBACK_TYPE = (
    D3DXPLAY_LOOP          {= 0},
    D3DXPLAY_ONCE          {= 1},
    D3DXPLAY_PINGPONG      {= 2}
  );
  {$EXTERNALSYM _D3DXPLAYBACK_TYPE}
  D3DXPLAYBACK_TYPE = _D3DXPLAYBACK_TYPE;
  {$EXTERNALSYM D3DXPLAYBACK_TYPE}
  TD3DXPlaybackType = _D3DXPLAYBACK_TYPE;


  //----------------------------------------------------------------------------
  // D3DXKEY_VECTOR3:
  // ----------------
  // This structure describes a vector key for use in keyframe animation.
  // It specifies a vector Value at a given Time. This is used for scale and
  // translation keys.
  //----------------------------------------------------------------------------
  PD3DXKeyVector3 = ^TD3DXKeyVector3;
  _D3DXKEY_VECTOR3 = record
    Time: Single;
    Value: TD3DXVector3;
  end;
  {$EXTERNALSYM _D3DXKEY_VECTOR3}
  D3DXKEY_VECTOR3 = _D3DXKEY_VECTOR3;
  {$EXTERNALSYM D3DXKEY_VECTOR3}
  TD3DXKeyVector3 = _D3DXKEY_VECTOR3;


  //----------------------------------------------------------------------------
  // D3DXKEY_QUATERNION:
  // -------------------
  // This structure describes a quaternion key for use in keyframe animation.
  // It specifies a quaternion Value at a given Time. This is used for rotation
  // keys.
  //----------------------------------------------------------------------------
  PD3DXKeyQuaternion = ^TD3DXKeyQuaternion;
  _D3DXKEY_QUATERNION = record
    Time: Single;
    Value: TD3DXQuaternion;
  end;
  {$EXTERNALSYM _D3DXKEY_QUATERNION}
  D3DXKEY_QUATERNION = _D3DXKEY_QUATERNION;
  {$EXTERNALSYM D3DXKEY_QUATERNION}
  TD3DXKeyQuaternion = _D3DXKEY_QUATERNION;


  //----------------------------------------------------------------------------
  // D3DXKEY_CALLBACK:
  // -----------------
  // This structure describes an callback key for use in keyframe animation.
  // It specifies a pointer to user data at a given Time.
  //----------------------------------------------------------------------------
  PD3DXKeyCallback = ^TD3DXKeyCallback;
  _D3DXKEY_CALLBACK = record
    Time: Single;
    pCallbackData: Pointer;
  end;
  {$EXTERNALSYM _D3DXKEY_CALLBACK}
  D3DXKEY_CALLBACK = _D3DXKEY_CALLBACK;
  {$EXTERNALSYM D3DXKEY_CALLBACK}
  TD3DXKeyCallback = _D3DXKEY_CALLBACK;


  //----------------------------------------------------------------------------
  // D3DXCOMPRESSION_FLAGS:
  // ----------------------
  // Flags that can be passed into ID3DXKeyframedAnimationSet::Compress. 
  //----------------------------------------------------------------------------
  PD3DXCompressionFlags = ^TD3DXCompressionFlags;
  _D3DXCOMPRESSION_FLAGS = (
    D3DXCOMPRESS_DEFAULT     {= 0x00}
//Clootie: Seems it is really removed...
(*    D3DXCOMPRESS_DEFAULT     {= 0x00},  // fast compression
    D3DXCOMPRESS_STRONG      {= 0x01}   // slower compression with better results *)
  );
  {$EXTERNALSYM _D3DXCOMPRESSION_FLAGS}
  D3DXCOMPRESSION_FLAGS = _D3DXCOMPRESSION_FLAGS;
  {$EXTERNALSYM D3DXCOMPRESSION_FLAGS}
  TD3DXCompressionFlags = _D3DXCOMPRESSION_FLAGS;


  //----------------------------------------------------------------------------
  // ID3DXKeyframedAnimationSet:
  // ---------------------------
  // This interface implements a compressable keyframed animation set.
  //----------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXKeyframedAnimationSet);'}
  {$EXTERNALSYM ID3DXKeyframedAnimationSet}
  ID3DXKeyframedAnimationSet = interface(ID3DXAnimationSet)
    ['{FA4E8E3A-9786-407d-8B4C-5995893764AF}']
    // Playback
    function GetPlaybackType: TD3DXPlaybackType; stdcall;
    function GetSourceTicksPerSecond: Double; stdcall;

    // Scale keys
    function GetNumScaleKeys(Animation: LongWord): LongWord; stdcall;
    function GetScaleKeys(Animation: LongWord; pScaleKeys: PD3DXKeyVector3): HResult; stdcall;
    function GetScaleKey(Animation, Key: LongWord; pScaleKey: PD3DXKeyVector3): HResult; stdcall;
    function SetScaleKey(Animation, Key: LongWord; pScaleKey: PD3DXKeyVector3): HResult; stdcall;

    // Rotation keys
    function GetNumRotationKeys(Animation: LongWord): LongWord; stdcall;
    function GetRotationKeys(Animation: LongWord; pRotationKeys: PD3DXKeyQuaternion): HResult; stdcall;
    function GetRotationKey(Animation, Key: LongWord; pRotationKey: PD3DXKeyQuaternion): HResult; stdcall;
    function SetRotationKey(Animation, Key: LongWord; pRotationKey: PD3DXKeyQuaternion): HResult; stdcall;

    // Translation keys
    function GetNumTranslationKeys(Animation: LongWord): LongWord; stdcall;
    function GetTranslationKeys(Animation: LongWord; pTranslationKeys: PD3DXKeyVector3): HResult; stdcall;
    function GetTranslationKey(Animation, Key: LongWord; pTranslationKey: PD3DXKeyVector3): HResult; stdcall;
    function SetTranslationKey(Animation, Key: LongWord; pTranslationKey: PD3DXKeyVector3): HResult; stdcall;

    // Callback keys
    function GetNumCallbackKeys: LongWord; stdcall;
    function GetCallbackKeys(pCallbackKeys: PD3DXKeyCallback): HResult; stdcall;
    function GetCallbackKey(Key: LongWord; pCallbackKey: PD3DXKeyCallback): HResult; stdcall;
    function SetCallbackKey(Key: LongWord; pCallbackKey: PD3DXKeyCallback): HResult; stdcall;

    // Key removal methods. These are slow, and should not be used once the animation starts playing
    function UnregisterScaleKey(Animation: LongWord; Key: LongWord): HResult; stdcall;
    function UnregisterRotationKey(Animation: LongWord; Key: LongWord): HResult; stdcall;
    function UnregisterTranslationKey(Animation: LongWord; Key: LongWord): HResult; stdcall;

    // One-time animaton SRT keyframe registration
    function RegisterAnimationSRTKeys(
        pName: PAnsiChar;                      // Animation name
        NumScaleKeys: LongWord;                // Number of scale keys
        NumRotationKeys: LongWord;             // Number of rotation keys
        NumTranslationKeys: LongWord;          // Number of translation keys
        pScaleKeys: PD3DXKeyVector3;           // Array of scale keys
        pRotationKeys: PD3DXKeyQuaternion;     // Array of rotation keys
        pTranslationKeys: PD3DXKeyVector3;     // Array of translation keys
        pAnimationIndex: PDWORD                // Returns the animation index
      ): HResult; stdcall;

    // Compression
    function Compress(
        Flags: DWORD;                          // Compression flags (use D3DXCOMPRESS_STRONG for better results)
        Lossiness: Single;                     // Compression loss ratio in the [0, 1] range
        pHierarchy: PD3DXFrame;                // Frame hierarchy (optional)
        out ppCompressedData: ID3DXBuffer      // Returns the compressed animation set
      ): HResult; stdcall;

    function UnregisterAnimation(Index: LongWord): HResult; stdcall;
  end;


  //----------------------------------------------------------------------------
  // ID3DXCompressedAnimationSet:
  // ----------------------------
  // This interface implements a compressed keyframed animation set.
  //----------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXCompressedAnimationSet);'}
  {$EXTERNALSYM ID3DXCompressedAnimationSet}
  ID3DXCompressedAnimationSet = interface(ID3DXAnimationSet)
    ['{6CC2480D-3808-4739-9F88-DE49FACD8D4C}']
    // Playback
    function GetPlaybackType: TD3DXPlaybackType; stdcall;
    function GetSourceTicksPerSecond: Double; stdcall;

    // Scale keys
    function GetCompressedData(out ppCompressedData: ID3DXBuffer): HResult; stdcall;

    // Callback keys
    function GetNumCallbackKeys: LongWord; stdcall;
    function GetCallbackKeys(pCallbackKeys: PD3DXKeyCallback): HResult; stdcall;
  end;


  //----------------------------------------------------------------------------
  // D3DXPRIORITY_TYPE:
  // ------------------
  // This enum defines the type of priority group that a track can be assigned to.
  //----------------------------------------------------------------------------
  PD3DXPriorityType = ^TD3DXPriorityType;
  _D3DXPRIORITY_TYPE = (
    D3DXPRIORITY_LOW         {= 0},           // This track should be blended with all low priority tracks before mixed with the high priority result
    D3DXPRIORITY_HIGH        {= 1}            // This track should be blended with all high priority tracks before mixed with the low priority result
  );
  {$EXTERNALSYM _D3DXPRIORITY_TYPE}
  D3DXPRIORITY_TYPE = _D3DXPRIORITY_TYPE;
  {$EXTERNALSYM D3DXPRIORITY_TYPE}
  TD3DXPriorityType = _D3DXPRIORITY_TYPE;

  //----------------------------------------------------------------------------
  // D3DXTRACK_DESC:
  // ---------------
  // This structure describes the mixing information of an animation track.
  // The mixing information consists of the current position, speed, and blending
  // weight for the track.  The Flags field also specifies whether the track is
  // low or high priority.  Tracks with the same priority are blended together
  // and then the two resulting values are blended using the priority blend factor.
  // A track also has an animation set (stored separately) associated with it.
  //----------------------------------------------------------------------------
  PD3DXTrackDesc = ^TD3DXTrackDesc;
  _D3DXTRACK_DESC = record
    Priority: TD3DXPriorityType;
    Weight: Single;
    Speed: Single;
    Position: Double;
    Enable: BOOL;
  end;
  {$EXTERNALSYM _D3DXTRACK_DESC}
  D3DXTRACK_DESC = _D3DXTRACK_DESC;
  {$EXTERNALSYM D3DXTRACK_DESC}
  TD3DXTrackDesc = _D3DXTRACK_DESC;

  //----------------------------------------------------------------------------
  // D3DXEVENT_TYPE:
  // ---------------
  // This enum defines the type of events keyable via the animation controller.
  //----------------------------------------------------------------------------
  PD3DXEventType = ^TD3DXEventType;
  _D3DXEVENT_TYPE = (
    D3DXEVENT_TRACKSPEED    {= 0},
    D3DXEVENT_TRACKWEIGHT   {= 1},
    D3DXEVENT_TRACKPOSITION {= 2},
    D3DXEVENT_TRACKENABLE   {= 3},
    D3DXEVENT_PRIORITYBLEND {= 4}
  );
  {$EXTERNALSYM _D3DXEVENT_TYPE}
  D3DXEVENT_TYPE = _D3DXEVENT_TYPE;
  {$EXTERNALSYM D3DXEVENT_TYPE}
  TD3DXEventType = _D3DXEVENT_TYPE;

  //----------------------------------------------------------------------------
  // D3DXTRANSITION_TYPE:
  // --------------------
  // This enum defines the type of transtion performed on a event that 
  // transitions from one value to another.
  //----------------------------------------------------------------------------
  PD3DXTransitionType = ^TD3DXTransitionType;
  _D3DXTRANSITION_TYPE = (
    D3DXTRANSITION_LINEAR        {= 0x000},     // Linear transition from one value to the next
    D3DXTRANSITION_EASEINEASEOUT {= 0x001}      // Ease-In Ease-Out spline transtion from one value to the next
  );
  {$EXTERNALSYM _D3DXTRANSITION_TYPE}
  D3DXTRANSITION_TYPE = _D3DXTRANSITION_TYPE;
  {$EXTERNALSYM D3DXTRANSITION_TYPE}
  TD3DXTransitionType = _D3DXTRANSITION_TYPE;

  //----------------------------------------------------------------------------
  // D3DXEVENT_DESC:
  // ---------------
  // This structure describes a animation controller event.
  // It gives the event's type, track (if the event is a track event), global 
  // start time, duration, transition method, and target value.
  //----------------------------------------------------------------------------
  PD3DXEventDesc = ^TD3DXEventDesc;
  _D3DXEVENT_DESC = record
    _Type: TD3DXEventType;
    Track: LongWord;
    StartTime: Double;
    Duration: Double;
    Transition: TD3DXTransitionType;
    case Byte of
      0: (Weight: Single);
      1: (Speed: Single);
      2: (Position: Double);
      3: (Enable: BOOL);
  end;
  {$EXTERNALSYM _D3DXEVENT_DESC}
  D3DXEVENT_DESC = _D3DXEVENT_DESC;
  {$EXTERNALSYM D3DXEVENT_DESC}
  TD3DXEventDesc = _D3DXEVENT_DESC;

  //----------------------------------------------------------------------------
  // D3DXEVENTHANDLE:
  // ----------------
  // Handle values used to efficiently reference animation controller events.
  //----------------------------------------------------------------------------
  D3DXEVENTHANDLE = DWORD;
  {$EXTERNALSYM D3DXEVENTHANDLE}
  TD3DXEventHandle = D3DXEVENTHANDLE;
  PD3DXEventHandle = ^TD3DXEventHandle;


  //----------------------------------------------------------------------------
  // ID3DXAnimationCallbackHandler:
  // ------------------------------
  // This interface is intended to be implemented by the application, and can
  // be used to handle callbacks in animation sets generated when
  // ID3DXAnimationController::AdvanceTime() is called.
  //----------------------------------------------------------------------------
  {$EXTERNALSYM ID3DXAnimationCallbackHandler}
  ID3DXAnimationCallbackHandler = class
    //----------------------------------------------------------------------------
    // ID3DXAnimationCallbackHandler::HandleCallback:
    // ----------------------------------------------
    // This method gets called when a callback occurs for an animation set in one
    // of the tracks during the ID3DXAnimationController::AdvanceTime() call.
    //
    // Parameters:
    //  Track
    //      Index of the track on which the callback occured.
    //  pCallbackData
    //      Pointer to user owned callback data.
    //
    //----------------------------------------------------------------------------
    function HandleCallback(Track: LongWord; pCallbackData: Pointer): HResult; virtual; stdcall; abstract;
  end;


  //----------------------------------------------------------------------------
  // ID3DXAnimationController:
  // -------------------------
  // This interface implements the main animation functionality. It connects
  // animation sets with the transform frames that are being animated. Allows
  // mixing multiple animations for blended animations or for transistions
  // It adds also has methods to modify blending parameters over time to
  // enable smooth transistions and other effects.
  //----------------------------------------------------------------------------
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXAnimationController);'}
  {$EXTERNALSYM ID3DXAnimationController}
  ID3DXAnimationController = interface(IUnknown)
    ['{AC8948EC-F86D-43e2-96DE-31FC35F96D9E}']
    // Max sizes
    function GetMaxNumAnimationOutputs: LongWord; stdcall;
    function GetMaxNumAnimationSets: LongWord; stdcall;
    function GetMaxNumTracks: LongWord; stdcall;
    function GetMaxNumEvents: LongWord; stdcall;

    // Animation output registration
    function RegisterAnimationOutput(
        pName: PAnsiChar;
        pMatrix: PD3DXMatrix;
        pScale: PD3DXVector3;
        pRotation: PD3DXQuaternion;
        pTranslation: PD3DXVector3): HResult; stdcall;

    // Animation set registration
    function RegisterAnimationSet(pAnimSet: ID3DXAnimationSet): HResult; stdcall;
    function UnregisterAnimationSet(pAnimSet: ID3DXAnimationSet): HResult; stdcall;

    function GetNumAnimationSets: LongWord; stdcall;
    function GetAnimationSet(Index: LongWord; out ppAnimationSet: ID3DXAnimationSet): HResult; stdcall;
    function GetAnimationSetByName(szName: PAnsiChar; out ppAnimationSet: ID3DXAnimationSet): HResult; stdcall;

    // Global time
    function AdvanceTime(TimeDelta: Double; pCallbackHandler: ID3DXAnimationCallbackHandler): HResult; stdcall;
    function ResetTime: HResult; stdcall;
    function GetTime: Double; stdcall;

    // Tracks
    function SetTrackAnimationSet(Track: LongWord; pAnimSet: ID3DXAnimationSet): HResult; stdcall;
    function GetTrackAnimationSet(Track: LongWord; out ppAnimSet: ID3DXAnimationSet): HResult; stdcall;

    function SetTrackPriority(Track: LongWord; Priority: TD3DXPriorityType): HResult; stdcall;

    function SetTrackSpeed(Track: LongWord; Speed: Single): HResult; stdcall;
    function SetTrackWeight(Track: LongWord; Weight: Single): HResult; stdcall;
    function SetTrackPosition(Track: LongWord; Position: Double): HResult; stdcall;
    function SetTrackEnable(Track: LongWord; Enable: BOOL): HResult; stdcall;

    function SetTrackDesc(Track: LongWord; pDesc: PD3DXTrackDesc): HResult; stdcall;
    function GetTrackDesc(Track: LongWord; pDesc: PD3DXTrackDesc): HResult; stdcall; //todo: Check for NULL

    // Priority blending
    function SetPriorityBlend(BlendWeight: Single): HResult; stdcall;
    function GetPriorityBlend: Single; stdcall;

    // Event keying
    function KeyTrackSpeed(Track: LongWord; NewSpeed: Single; StartTime: Double; Duration: Double; Transition: TD3DXTransitionType): TD3DXEventHandle; stdcall;
    function KeyTrackWeight(Track: LongWord; NewWeight: Single; StartTime: Double; Duration: Double; Transition: TD3DXTransitionType): TD3DXEventHandle; stdcall;
    function KeyTrackPosition(Track: LongWord; NewPosition: Double; StartTime: Double): TD3DXEventHandle; stdcall;
    function KeyTrackEnable(Track: LongWord; NewEnable: BOOL; StartTime: Double): TD3DXEventHandle; stdcall;

    function KeyPriorityBlend(NewBlendWeight: Single; StartTime: Double; Duration: Double; Transition: TD3DXTransitionType): TD3DXEventHandle; stdcall;

    // Event unkeying
    function UnkeyEvent(hEvent: TD3DXEventHandle): HResult; stdcall;

    function UnkeyAllTrackEvents(Track: LongWord): HResult; stdcall;
    function UnkeyAllPriorityBlends: HResult; stdcall;

    // Event enumeration
    function GetCurrentTrackEvent(Track: LongWord; EventType: TD3DXEventType): TD3DXEventHandle; stdcall;
    function GetCurrentPriorityBlend: TD3DXEventHandle; stdcall;

    function GetUpcomingTrackEvent(Track: LongWord; hEvent: TD3DXEventHandle): TD3DXEventHandle; stdcall;
    function GetUpcomingPriorityBlend(hEvent: TD3DXEventHandle): TD3DXEventHandle; stdcall;

    function ValidateEvent(hEvent: TD3DXEventHandle): HResult; stdcall;

    function GetEventDesc(hEvent: TD3DXEventHandle; pDesc: PD3DXEventDesc): HResult; stdcall; //todo: Check for NULL

    // Cloning
    function CloneAnimationController(
        MaxNumAnimationOutputs: LongWord;
        MaxNumAnimationSets: LongWord;
        MaxNumTracks: LongWord;
        MaxNumEvents: LongWord;
        out ppAnimController: ID3DXAnimationController): HResult; stdcall;
  end;


type
  IID_ID3DXAnimationSet = ID3DXAnimationSet;
  {$EXTERNALSYM IID_ID3DXAnimationSet}
  IID_ID3DXKeyframedAnimationSet = ID3DXKeyframedAnimationSet;
  {$EXTERNALSYM IID_ID3DXKeyframedAnimationSet}
  IID_ID3DXCompressedAnimationSet = ID3DXCompressedAnimationSet;
  {$EXTERNALSYM IID_ID3DXCompressedAnimationSet}
  IID_ID3DXAnimationController = ID3DXAnimationController;
  {$EXTERNALSYM IID_ID3DXAnimationController}


//----------------------------------------------------------------------------
// D3DXLoadMeshHierarchyFromX:
// ---------------------------
// Loads the first frame hierarchy in a .X file.
//
// Parameters:
//  Filename
//      Name of the .X file
//  MeshOptions
//      Mesh creation options for meshes in the file (see d3dx9mesh.h)
//  pD3DDevice
//      D3D9 device on which meshes in the file are created in
//  pAlloc
//      Allocation interface used to allocate nodes of the frame hierarchy
//  pUserDataLoader
//      Application provided interface to allow loading of user data
//  ppFrameHierarchy
//      Returns root node pointer of the loaded frame hierarchy
//  ppAnimController
//      Returns pointer to an animation controller corresponding to animation
//      in the .X file. This is created with default max tracks and events
//
//----------------------------------------------------------------------------
function D3DXLoadMeshHierarchyFromXA(
  Filename: PAnsiChar;
  MeshOptions: DWORD;
  pD3DDevice: IDirect3DDevice9;
  pAlloc: ID3DXAllocateHierarchy;
  pUserDataLoader: ID3DXLoadUserData;
  out ppFrameHierarchy: PD3DXFrame;
  out ppAnimController: ID3DXAnimationController): HResult; stdcall; external d3dx9animDLL name 'D3DXLoadMeshHierarchyFromXA';
{$EXTERNALSYM D3DXLoadMeshHierarchyFromXA}

function D3DXLoadMeshHierarchyFromXW(
  Filename: PWideChar;
  MeshOptions: DWORD;
  pD3DDevice: IDirect3DDevice9;
  pAlloc: ID3DXAllocateHierarchy;
  pUserDataLoader: ID3DXLoadUserData;
  out ppFrameHierarchy: PD3DXFrame;
  out ppAnimController: ID3DXAnimationController): HResult; stdcall; external d3dx9animDLL name 'D3DXLoadMeshHierarchyFromXW';
{$EXTERNALSYM D3DXLoadMeshHierarchyFromXW}

function D3DXLoadMeshHierarchyFromX(
  Filename: PChar;
  MeshOptions: DWORD;
  pD3DDevice: IDirect3DDevice9;
  pAlloc: ID3DXAllocateHierarchy;
  pUserDataLoader: ID3DXLoadUserData;
  out ppFrameHierarchy: PD3DXFrame;
  out ppAnimController: ID3DXAnimationController): HResult; stdcall; external d3dx9animDLL name 'D3DXLoadMeshHierarchyFromXA';
{$EXTERNALSYM D3DXLoadMeshHierarchyFromX}


function D3DXLoadMeshHierarchyFromXInMemory(
  Memory: Pointer;
  SizeOfMemory: DWORD;
  MeshOptions: DWORD;
  pD3DDevice: IDirect3DDevice9;
  pAlloc: ID3DXAllocateHierarchy;
  pUserDataLoader: ID3DXLoadUserData;
  out ppFrameHierarchy: PD3DXFrame;
  out ppAnimController: ID3DXAnimationController): HResult; stdcall; external d3dx9animDLL;
{$EXTERNALSYM D3DXLoadMeshHierarchyFromXInMemory}

//----------------------------------------------------------------------------
// D3DXSaveMeshHierarchyToFile:
// ----------------------------
// Creates a .X file and saves the mesh hierarchy and corresponding animations
// in it
//
// Parameters:
//  Filename
//      Name of the .X file
//  XFormat
//      Format of the .X file (text or binary, compressed or not, etc)
//  pFrameRoot
//      Root node of the hierarchy to be saved
//  pAnimController
//      The animation controller whose animation sets are to be stored
//  pUserDataSaver
//      Application provided interface to allow adding of user data to
//        data objects saved to .X file
//
//----------------------------------------------------------------------------
function D3DXSaveMeshHierarchyToFileA(
  Filename: PAnsiChar;
  XFormat: TD3DXFFileFormat;
  pFrameRoot: PD3DXFrame;
  pAnimcontroller: ID3DXAnimationController;
  pUserDataSaver: ID3DXSaveUserData): HResult; stdcall; external d3dx9animDLL name 'D3DXSaveMeshHierarchyToFileA';
{$EXTERNALSYM D3DXSaveMeshHierarchyToFileA}

function D3DXSaveMeshHierarchyToFileW(
  Filename: PWideChar;
  XFormat: TD3DXFFileFormat;
  pFrameRoot: PD3DXFrame;
  pAnimcontroller: ID3DXAnimationController;
  pUserDataSaver: ID3DXSaveUserData): HResult; stdcall; external d3dx9animDLL name 'D3DXSaveMeshHierarchyToFileW';
{$EXTERNALSYM D3DXSaveMeshHierarchyToFileW}

function D3DXSaveMeshHierarchyToFile(
  Filename: PChar;
  XFormat: TD3DXFFileFormat;
  pFrameRoot: PD3DXFrame;
  pAnimcontroller: ID3DXAnimationController;
  pUserDataSaver: ID3DXSaveUserData): HResult; stdcall; external d3dx9animDLL name 'D3DXSaveMeshHierarchyToFileA';
{$EXTERNALSYM D3DXSaveMeshHierarchyToFile}


//----------------------------------------------------------------------------
// D3DXFrameDestroy:
// -----------------
// Destroys the subtree of frames under the root, including the root
//
// Parameters:
//  pFrameRoot
//      Pointer to the root node
//  pAlloc
//      Allocation interface used to de-allocate nodes of the frame hierarchy
//
//----------------------------------------------------------------------------
function D3DXFrameDestroy(
  pFrameRoot: PD3DXFrame;
  pAlloc: ID3DXAllocateHierarchy): HResult; stdcall; external d3dx9animDLL;
{$EXTERNALSYM D3DXFrameDestroy}

//----------------------------------------------------------------------------
// D3DXFrameAppendChild:
// ---------------------
// Add a child frame to a frame
//
// Parameters:
//  pFrameParent
//      Pointer to the parent node
//  pFrameChild
//      Pointer to the child node
//
//----------------------------------------------------------------------------
function D3DXFrameAppendChild(
  pFrameParent: PD3DXFrame;
  pFrameChild: PD3DXFrame): HResult; stdcall; external d3dx9animDLL;
{$EXTERNALSYM D3DXFrameAppendChild}

//----------------------------------------------------------------------------
// D3DXFrameFind:
// --------------
// Finds a frame with the given name.  Returns NULL if no frame found.
//
// Parameters:
//  pFrameRoot
//      Pointer to the root node
//  Name
//      Name of frame to find
//
//----------------------------------------------------------------------------
function D3DXFrameFind(
  pFrameRoot: PD3DXFrame;
  Name: PAnsiChar): PD3DXFrame; stdcall; external d3dx9animDLL;
{$EXTERNALSYM D3DXFrameFind}

//----------------------------------------------------------------------------
// D3DXFrameRegisterNamedMatrices:
// -------------------------------
// Finds all frames that have non-null names and registers each of those frame
// matrices to the given animation controller
//
// Parameters:
//  pFrameRoot
//      Pointer to the root node
//  pAnimController
//      Pointer to the animation controller where the matrices are registered
//
//----------------------------------------------------------------------------
function D3DXFrameRegisterNamedMatrices(
  pFrameRoot: PD3DXFrame;
  pAnimController: ID3DXAnimationController): HResult; stdcall; external d3dx9animDLL;
{$EXTERNALSYM D3DXFrameRegisterNamedMatrices}

//----------------------------------------------------------------------------
// D3DXFrameNumNamedMatrices:
// --------------------------
// Counts number of frames in a subtree that have non-null names
//
// Parameters:
//  pFrameRoot
//      Pointer to the root node of the subtree
// Return Value:
//      Count of frames
//
//----------------------------------------------------------------------------
function D3DXFrameNumNamedMatrices(
  pFrameRoot: PD3DXFrame): HResult; stdcall; external d3dx9animDLL;
{$EXTERNALSYM D3DXFrameNumNamedMatrices}

//----------------------------------------------------------------------------
// D3DXFrameCalculateBoundingSphere:
// ---------------------------------
// Computes the bounding sphere of all the meshes in the frame hierarchy.
//
// Parameters:
//  pFrameRoot
//      Pointer to the root node
//  pObjectCenter
//      Returns the center of the bounding sphere
//  pObjectRadius
//      Returns the radius of the bounding sphere
//
//----------------------------------------------------------------------------
function D3DXFrameCalculateBoundingSphere(
  pFrameRoot: PD3DXFrame;
  out pObjectCenter: TD3DXVector3;
  out pObjectRadius: Single): HResult; stdcall; external d3dx9animDLL;
{$EXTERNALSYM D3DXFrameCalculateBoundingSphere}


//----------------------------------------------------------------------------
// D3DXCreateKeyframedAnimationSet:
// --------------------------------
// This function creates a compressable keyframed animations set interface.
// 
// Parameters:
//  pName
//      Name of the animation set
//  TicksPerSecond
//      Number of keyframe ticks that elapse per second
//  Playback
//      Playback mode of keyframe looping
//  NumAnimations
//      Number of SRT animations
//  NumCallbackKeys
//      Number of callback keys
//  pCallbackKeys
//      Array of callback keys
//  ppAnimationSet
//      Returns the animation set interface
//
//-----------------------------------------------------------------------------
function D3DXCreateKeyframedAnimationSet(
  pName: PAnsiChar;
  TicksPerSecond: Double;
  Playback: TD3DXPlaybackType;
  NumAnimations: LongWord;
  NumCallbackKeys: LongWord;
  pCallbackKeys: PD3DXKeyCallback;
  out ppAnimationSet: ID3DXKeyframedAnimationSet): HResult; stdcall; external d3dx9animDLL;
{$EXTERNALSYM D3DXCreateKeyframedAnimationSet}


//----------------------------------------------------------------------------
// D3DXCreateCompressedAnimationSet:
// --------------------------------
// This function creates a compressed animations set interface from
// compressed data.
//
// Parameters:
//  pName
//      Name of the animation set
//  TicksPerSecond
//      Number of keyframe ticks that elapse per second
//  Playback
//      Playback mode of keyframe looping
//  pCompressedData
//      Compressed animation SRT data
//  NumCallbackKeys
//      Number of callback keys
//  pCallbackKeys
//      Array of callback keys
//  ppAnimationSet
//      Returns the animation set interface
//
//-----------------------------------------------------------------------------
function D3DXCreateCompressedAnimationSet(
  pName: PAnsiChar;
  TicksPerSecond: Double;
  Playback: TD3DXPlaybackType;
  pCompressedData: ID3DXBuffer;
  NumCallbackKeys: LongWord;
  pCallbackKeys: PD3DXKeyCallback;
  out ppAnimationSet: ID3DXCompressedAnimationSet): HResult; stdcall; external d3dx9animDLL;
{$EXTERNALSYM D3DXCreateCompressedAnimationSet}


//----------------------------------------------------------------------------
// D3DXCreateAnimationController:
// ------------------------------
// This function creates an animation controller object.
//
// Parameters:
//  MaxNumMatrices
//      Maximum number of matrices that can be animated
//  MaxNumAnimationSets
//      Maximum number of animation sets that can be played
//  MaxNumTracks
//      Maximum number of animation sets that can be blended
//  MaxNumEvents
//      Maximum number of outstanding events that can be scheduled at any given time
//  ppAnimController
//      Returns the animation controller interface
//
//-----------------------------------------------------------------------------
function D3DXCreateAnimationController(
  MaxNumMatrices: LongWord;
  MaxNumAnimationSets: LongWord;
  MaxNumTracks: LongWord;
  MaxNumEvents: LongWord;
  out ppAnimController: ID3DXAnimationController): HResult; stdcall; external d3dx9animDLL;
{$EXTERNALSYM D3DXCreateAnimationController}





(*$HPPEMIT '}  /* namespace D3dx9 */' *)

//***************************************************************************//
//***************************************************************************//
//***************************************************************************//
implementation
//***************************************************************************//
//***************************************************************************//
//***************************************************************************//






//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx8math.h
//  Content:    D3DX math types and functions
//
//////////////////////////////////////////////////////////////////////////////



//===========================================================================
//
// General purpose utilities
//
//===========================================================================

function D3DXToRadian(Degree: Single): Single;
begin
  Result:= Degree * (D3DX_PI / 180.0);
end;

function D3DXToDegree(Radian: Single): Single;
begin
  Result:= Radian * (180.0 / D3DX_PI);
end;



//===========================================================================
//
// 16 bit floating point numbers
//
//===========================================================================

function D3DXFloat16(value: Single): TD3DXFloat16; inline;
begin
  D3DXFloat32To16Array(@Result, @value, 1);
end;

function D3DXFloat16Equal(const v1, v2: TD3DXFloat16): Boolean; inline;
begin
  Result:= (v1.value = v2.value);
end;

function D3DXFloat16ToFloat(value: TD3DXFloat16): Single; inline;
begin
  D3DXFloat16To32Array(@Result, @value, 1);
end;



//===========================================================================
//
// Vectors
//
//===========================================================================

//--------------------------
// 2D Vector
//--------------------------

function D3DXVector2(_x, _y: Single): TD3DXVector2; inline;
begin
  Result.x:= _x; Result.y:= _y;
end;

function D3DXVector2Equal(const v1, v2: TD3DXVector2): Boolean; inline;
begin
  Result:= (v1.x = v2.x) and (v1.y = v2.y);
end;


//--------------------------
// 2D Vector (16 bit)
//--------------------------
function D3DXVector2_16F(_x, _y: TD3DXFloat16): TD3DXVector2_16F; inline;
begin
  with Result do
  begin
    x:= _x;
    y:= _y;
  end;
end;

function D3DXVector2_16fEqual(const v1, v2: TD3DXVector2_16F): Boolean; inline;
begin
  Result:= (DWORD(v1) = DWORD(v2));
end;

function D3DXVector2_16fFromVector2(const v: TD3DXVector2): TD3DXVector2_16f; inline;
begin
  D3DXFloat32To16Array(@Result.x, @v.x, 2);
end;

function D3DXVector2FromVector2_16f(const v: TD3DXVector2_16f): TD3DXVector2; inline;
begin
  D3DXFloat16To32Array(@Result.x, @v.x, 2);
end;


//--------------------------
// 3D Vector
//--------------------------

function D3DXVector3(_x, _y, _z: Single): TD3DXVector3; inline;
begin
  with Result do
  begin
    x:= _x; y:= _y; z:=_z;
  end;
end;

function D3DXVector3Equal(const v1, v2: TD3DXVector3): Boolean;
begin
  Result:= (v1.x = v2.x) and (v1.y = v2.y) and (v1.z = v2.z);
end;


//--------------------------
// 3D Vector (16 bit)
//--------------------------

function D3DXVector3_16F(_x, _y, _z: TD3DXFloat16): TD3DXVector3_16F; inline;
begin
  with Result do
  begin
    x:= _x; y:= _y; z:= _z;
  end;
end;

function D3DXVector3_16fEqual(const v1, v2: TD3DXVector3_16F): Boolean;
begin
  Result:= (PDWORD(@v1.x)^ = PDWORD(@v2.x)^) and
           (Word  (v1.z)   = Word (v2.z));
end;

function D3DXVector3_16fFromVector3(const v: TD3DXVector3): TD3DXVector3_16f; inline;
begin
  D3DXFloat32To16Array(@Result.x, @v.x, 3);
end;

function D3DXVector3FromVector3_16f(const v: TD3DXVector3_16f): TD3DXVector3; inline;
begin
  D3DXFloat16To32Array(@Result.x, @v.x, 3);
end;


//--------------------------
// 4D Vector
//--------------------------

function D3DXVector4(_x, _y, _z, _w: Single): TD3DXVector4; inline;
begin
  with Result do
  begin
    x:= _x; y:= _y; z:= _z; w:= _w;
  end;
end;

function D3DXVector4(xyz: TD3DXVector3; _w: Single): TD3DXVector4; inline;
begin
  with Result do
  begin
    x:= xyz.x; y:= xyz.y; z:= xyz.z; w:= _w;
  end;
end;

function D3DXVector4Equal(const v1, v2: TD3DXVector4): Boolean; inline;
begin
  Result:= (v1.x = v2.x) and (v1.y = v2.y) and
    (v1.z = v2.z) and (v1.w = v2.w);
end;


//--------------------------
// 4D Vector (16 bit)
//--------------------------
function D3DXVector4_16F(_x, _y, _z, _w: TD3DXFloat16): TD3DXVector4_16F; inline;
begin
  with Result do
  begin
    x:= _x; y:= _y; z:= _z; w:= _w;
  end;
end;

function D3DXVector4_16F(xyz: TD3DXVector3_16f; _w: TD3DXFloat16): TD3DXVector4_16F; inline;
begin
  with Result do
  begin
    x:= xyz.x; y:= xyz.y; z:= xyz.z; w:= _w;
  end;
end;

function D3DXVector4_16fEqual(const v1, v2: TD3DXVector4_16F): Boolean; inline;
begin
  Result:= (PDWORD(@v1.x)^ = PDWORD(@v2.x)^) and
           (PDWORD(@v1.z)^ = PDWORD(@v2.z)^);
end;

function D3DXVector4_16fFromVector4(const v: TD3DXVector4): TD3DXVector4_16f; inline;
begin
  D3DXFloat32To16Array(@Result.x, @v.x, 4);
end;

function D3DXVector4FromVector4_16f(const v: TD3DXVector4_16f): TD3DXVector4; inline;
begin
  D3DXFloat16To32Array(@Result.x, @v.x, 4);
end;


//--------------------------
// 4D Matrix
//--------------------------
function D3DXMatrix(
  _m00, _m01, _m02, _m03,
  _m10, _m11, _m12, _m13,
  _m20, _m21, _m22, _m23,
  _m30, _m31, _m32, _m33: Single): TD3DXMatrix; inline;
begin
  with Result do
  begin
    m[0,0]:= _m00; m[0,1]:= _m01; m[0,2]:= _m02; m[0,3]:= _m03;
    m[1,0]:= _m10; m[1,1]:= _m11; m[1,2]:= _m12; m[1,3]:= _m13;
    m[2,0]:= _m20; m[2,1]:= _m21; m[2,2]:= _m22; m[2,3]:= _m23;
    m[3,0]:= _m30; m[3,1]:= _m31; m[3,2]:= _m32; m[3,3]:= _m33;
  end;
end;

function D3DXMatrixAdd(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix;
var
  pOut, p1, p2: PSingle; x: Integer;
begin
  pOut:= @mOut._11; p1:= @m1._11; p2:= @m2._11;
  for x:= 0 to 15 do
  begin
    pOut^:= p1^+p2^;
    Inc(pOut); Inc(p1); Inc(p2);
  end;
  Result:= @mOut;
end;

function D3DXMatrixSubtract(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix;
var
  pOut, p1, p2: PSingle; x: Integer;
begin
  pOut:= @mOut._11; p1:= @m1._11; p2:= @m2._11;
  for x:= 0 to 15 do
  begin
    pOut^:= p1^-p2^;
    Inc(pOut); Inc(p1); Inc(p2);
  end;
  Result:= @mOut;
end;

function D3DXMatrixMul(out mOut: TD3DXMatrix; const m: TD3DXMatrix; MulBy: Single): PD3DXMatrix;
var
  pOut, p: PSingle; x: Integer;
begin
  pOut:= @mOut._11; p:= @m._11;
  for x:= 0 to 15 do
  begin
    pOut^:= p^* MulBy;
    Inc(pOut); Inc(p);
  end;
  Result:= @mOut;
end;

function D3DXMatrixEqual(const m1, m2: TD3DXMatrix): Boolean;
begin
  Result:= CompareMem(@m1, @m2, SizeOf(TD3DXMatrix));
end;

//--------------------------
// Quaternion
//--------------------------
function D3DXQuaternion(_x, _y, _z, _w: Single): TD3DXQuaternion; inline;
begin
  with Result do
  begin
    x:= _x; y:= _y; z:= _z; w:= _w;
  end;
end;

function D3DXQuaternionAdd(const q1, q2: TD3DXQuaternion): TD3DXQuaternion; inline;
begin
  with Result do
  begin
    x:= q1.x+q2.x; y:= q1.y+q2.y; z:= q1.z+q2.z; w:= q1.w+q2.w;
  end;
end;

function D3DXQuaternionSubtract(const q1, q2: TD3DXQuaternion): TD3DXQuaternion; inline;
begin
  with Result do
  begin
    x:= q1.x-q2.x; y:= q1.y-q2.y; z:= q1.z-q2.z; w:= q1.w-q2.w;
  end;
end;

function D3DXQuaternionEqual(const q1, q2: TD3DXQuaternion): Boolean;
begin
  Result:= (q1.x = q2.x) and (q1.y = q2.y) and
    (q1.z = q2.z) and (q1.w = q2.w);
end;

function D3DXQuaternionScale(out qOut: TD3DXQuaternion; const q: TD3DXQuaternion;
  s: Single): PD3DXQuaternion;
begin
  with qOut do
  begin
    x:= q.x*s; y:= q.y*s; z:= q.z*s; w:= q.w*s;
  end;
  Result:= @qOut;
end;


//--------------------------
// Plane
//--------------------------

function D3DXPlane(_a, _b, _c, _d: Single): TD3DXPlane; inline;
begin
  with Result do
  begin
    a:= _a; b:= _b; c:= _c; d:= _d;
  end;
end;

function D3DXPlaneEqual(const p1, p2: TD3DXPlane): Boolean;
begin
  Result:=
    (p1.a = p2.a) and (p1.b = p2.b) and
    (p1.c = p2.c) and (p1.d = p2.d);
end;


//--------------------------
// Color
//--------------------------

function D3DXColor(_r, _g, _b, _a: Single): TD3DXColor; inline;
begin
  with Result do
  begin
    r:= _r; g:= _g; b:= _b; a:= _a;
  end;
end;

function D3DXColorToDWord(c: TD3DXColor): DWord; inline;
var
  dwR, dwG, dwB, dwA: DWORD;
begin
  if c.r > 1.0 then dwR:= 255 else if c.r < 0 then dwR:= 0 else dwR:= DWORD(Trunc(c.r * 255.0 + 0.5));
  if c.g > 1.0 then dwG:= 255 else if c.g < 0 then dwG:= 0 else dwG:= DWORD(Trunc(c.g * 255.0 + 0.5));
  if c.b > 1.0 then dwB:= 255 else if c.b < 0 then dwB:= 0 else dwB:= DWORD(Trunc(c.b * 255.0 + 0.5));
  if c.a > 1.0 then dwA:= 255 else if c.a < 0 then dwA:= 0 else dwA:= DWORD(Trunc(c.a * 255.0 + 0.5));

  Result:= (dwA shl 24) or (dwR shl 16) or (dwG shl 8) or dwB;
end;

function D3DXColorFromDWord(c: DWord): TD3DXColor; inline;
var
  f: Single; // = 1/255; //Clootie: Changed from CONST due to Delphi9 inline bug
begin
  f:= (1/255);
  with Result do
  begin
    r:= f * Byte(c shr 16);
    g:= f * Byte(c shr  8);
    b:= f * Byte(c{shr 0});
    a:= f * Byte(c shr 24);
  end;
end;

function D3DXColorEqual(const c1, c2: TD3DXColor): Boolean;
begin
  Result:= (c1.r = c2.r) and (c1.g = c2.g) and (c1.b = c2.b) and (c1.a = c2.a);
end;


//===========================================================================
//
// D3DX math functions:
//
// NOTE:
//  * All these functions can take the same object as in and out parameters.
//
//  * Out parameters are typically also returned as return values, so that
//    the output of one function may be used as a parameter to another.
//
//===========================================================================

//--------------------------
// 2D Vector
//--------------------------

// "inline"
function D3DXVec2Length(const v: TD3DXVector2): Single;
begin
  with v do Result:= Sqrt(x*x + y*y);
end;

function D3DXVec2LengthSq(const v: TD3DXVector2): Single;
begin
  with v do Result:= x*x + y*y;
end;

function D3DXVec2Dot(const v1, v2: TD3DXVector2): Single;
begin
  Result:= v1.x*v2.x + v1.y*v2.y;
end;

// Z component of ((x1,y1,0) cross (x2,y2,0))
function D3DXVec2CCW(const v1, v2: TD3DXVector2): Single;
begin
  Result:= v1.x*v2.y - v1.y*v2.x;
end;

function D3DXVec2Add(const v1, v2: TD3DXVector2): TD3DXVector2; inline;
begin
  Result.x:= v1.x + v2.x;
  Result.y:= v1.y + v2.y;
end;

function D3DXVec2Subtract(const v1, v2: TD3DXVector2): TD3DXVector2; inline;
begin
  Result.x:= v1.x - v2.x;
  Result.y:= v1.y - v2.y;
end;

// Minimize each component.  x = min(x1, x2), y = min(y1, y2)
function D3DXVec2Minimize(out vOut: TD3DXVector2; const v1, v2: TD3DXVEctor2): PD3DXVector2;
begin
  if v1.x < v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y < v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  Result:= @vOut;
end;

// Maximize each component.  x = max(x1, x2), y = max(y1, y2)
function D3DXVec2Maximize(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2): PD3DXVector2;
begin
  if v1.x > v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y > v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  Result:= @vOut;
end;

function D3DXVec2Scale(out vOut: TD3DXVector2; const v: TD3DXVector2; s: Single): PD3DXVector2;
begin
  vOut.x:= v.x*s; vOut.y:= v.y*s;
  Result:= @vOut;
end;

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec2Lerp(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2; s: Single): PD3DXVector2;
begin
  vOut.x:= v1.x + s * (v2.x-v1.x);
  vOut.y:= v1.y + s * (v2.y-v1.y);
  Result:= @vOut;
end;


//--------------------------
// 3D Vector
//--------------------------
function D3DXVec3Length(const v: TD3DXVector3): Single;
begin
  with v do Result:= Sqrt(x*x + y*y + z*z);
end;

function D3DXVec3LengthSq(const v: TD3DXVector3): Single;
begin
  with v do Result:= x*x + y*y + z*z;
end;

function D3DXVec3Dot(const v1, v2: TD3DXVector3): Single;
begin
  Result:= v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
end;

function D3DXVec3Cross(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  vOut.x:= v1.y * v2.z - v1.z * v2.y;
  vOut.y:= v1.z * v2.x - v1.x * v2.z;
  vOut.z:= v1.x * v2.y - v1.y * v2.x;
  Result:= @vOut;
end;

function D3DXVec3Add(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  with vOut do
  begin
    x:= v1.x + v2.x;
    y:= v1.y + v2.y;
    z:= v1.z + v2.z;
  end;
  Result:= @vOut;
end;

function D3DXVec3Subtract(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  with vOut do
  begin
    x:= v1.x - v2.x;
    y:= v1.y - v2.y;
    z:= v1.z - v2.z;
  end;
  Result:= @vOut;
end;

// Minimize each component.  x = min(x1, x2), y = min(y1, y2)
function D3DXVec3Minimize(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  if v1.x < v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y < v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  if v1.z < v2.z then vOut.z:= v1.z else vOut.z:= v2.z;
  Result:= @vOut;
end;

// Maximize each component.  x = max(x1, x2), y = max(y1, y2)
function D3DXVec3Maximize(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  if v1.x > v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y > v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  if v1.z > v2.z then vOut.z:= v1.z else vOut.z:= v2.z;
  Result:= @vOut;
end;

function D3DXVec3Scale(out vOut: TD3DXVector3; const v: TD3DXVector3; s: Single): PD3DXVector3;
begin
  with vOut do
  begin
    x:= v.x * s; y:= v.y * s; z:= v.z * s;
  end;
  Result:= @vOut;
end;

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec3Lerp(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3; s: Single): PD3DXVector3;
begin
  vOut.x:= v1.x + s * (v2.x-v1.x);
  vOut.y:= v1.y + s * (v2.y-v1.y);
  vOut.z:= v1.z + s * (v2.z-v1.z);
  Result:= @vOut;
end;


//--------------------------
// 4D Vector
//--------------------------

function D3DXVec4Length(const v: TD3DXVector4): Single;
begin
  with v do Result:= Sqrt(x*x + y*y + z*z + w*w);
end;

function D3DXVec4LengthSq(const v: TD3DXVector4): Single;
begin
  with v do Result:= x*x + y*y + z*z + w*w
end;

function D3DXVec4Dot(const v1, v2: TD3DXVector4): Single;
begin
  Result:= v1.x * v2.x + v1.y * v2.y + v1.z * v2.z + v1.w * v2.w;
end;

function D3DXVec4Add(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;
begin
  with vOut do
  begin
    x:= v1.x + v2.x;
    y:= v1.y + v2.y;
    z:= v1.z + v2.z;
    w:= v1.w + v2.w;
  end;
  Result:= @vOut;
end;

function D3DXVec4Subtract(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;
begin
  with vOut do
  begin
    x:= v1.x - v2.x;
    y:= v1.y - v2.y;
    z:= v1.z - v2.z;
    w:= v1.w - v2.w;
  end;
  Result:= @vOut;
end;


// Minimize each component.  x = min(x1, x2), y = min(y1, y2)
function D3DXVec4Minimize(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;
begin
  if v1.x < v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y < v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  if v1.z < v2.z then vOut.z:= v1.z else vOut.z:= v2.z;
  if v1.w < v2.w then vOut.w:= v1.w else vOut.w:= v2.w;
  Result:= @vOut;
end;

// Maximize each component.  x = max(x1, x2), y = max(y1, y2)
function D3DXVec4Maximize(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;
begin
  if v1.x > v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y > v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  if v1.z > v2.z then vOut.z:= v1.z else vOut.z:= v2.z;
  if v1.w > v2.w then vOut.w:= v1.w else vOut.w:= v2.w;
  Result:= @vOut;
end;

function D3DXVec4Scale(out vOut: TD3DXVector4; const v: TD3DXVector4; s: Single): PD3DXVector4;
begin
  with vOut do
  begin
    x:= v.x * s; y:= v.y * s; z:= v.z * s; w:= v.w * s;
  end;
  Result:= @vOut;
end;

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec4Lerp(out vOut: TD3DXVector4;
  const v1, v2: TD3DXVector4; s: Single): PD3DXVector4;
begin
  with vOut do
  begin
    x:= v1.x + s * (v2.x - v1.x);
    y:= v1.y + s * (v2.y - v1.y);
    z:= v1.z + s * (v2.z - v1.z);
    w:= v1.w + s * (v2.w - v1.w);
  end;
  Result:= @vOut;
end;

//--------------------------
// 4D Matrix
//--------------------------

// inline
function D3DXMatrixIdentity(out mOut: TD3DXMatrix): PD3DXMatrix;
begin
  FillChar(mOut, SizeOf(mOut), 0);
  mOut._11:= 1; mOut._22:= 1; mOut._33:= 1; mOut._44:= 1;
  Result:= @mOut;
end;

function D3DXMatrixIsIdentity(const m: TD3DXMatrix): BOOL;
begin
  with m do Result:=
    (_11 = 1) and (_12 = 0) and (_13 = 0) and (_14 = 0) and
    (_21 = 0) and (_22 = 1) and (_23 = 0) and (_24 = 0) and
    (_31 = 0) and (_32 = 0) and (_33 = 1) and (_34 = 0) and
    (_41 = 0) and (_42 = 0) and (_43 = 0) and (_44 = 1);
end;


//--------------------------
// Quaternion
//--------------------------

// inline

function D3DXQuaternionLength(const q: TD3DXQuaternion): Single;
begin
  with q do Result:= Sqrt(x*x + y*y + z*z + w*w);
end;

// Length squared, or "norm"
function D3DXQuaternionLengthSq(const q: TD3DXQuaternion): Single;
begin
  with q do Result:= x*x + y*y + z*z + w*w;
end;

function D3DXQuaternionDot(const q1, q2: TD3DXQuaternion): Single;
begin
  Result:= q1.x * q2.x + q1.y * q2.y + q1.z * q2.z + q1.w * q2.w;
end;

function D3DXQuaternionIdentity(out qOut: TD3DXQuaternion): PD3DXQuaternion;
begin
  with qOut do
  begin
    x:= 0; y:= 0; z:= 0; w:= 1.0;
  end;
  Result:= @qOut;
end;

function D3DXQuaternionIsIdentity(const q: TD3DXQuaternion): BOOL;
begin
  with q do Result:= (x = 0) and (y = 0) and (z = 0) and (w = 1);
end;

// (-x, -y, -z, w)
function D3DXQuaternionConjugate(out qOut: TD3DXQuaternion;
  const q: TD3DXQuaternion): PD3DXQuaternion;
begin
  with qOut do
  begin
    x:= -q.x; y:= -q.y; z:= -q.z; w:= q.w;
  end;
  Result:= @qOut;
end;


//--------------------------
// Plane
//--------------------------

// ax + by + cz + dw
function D3DXPlaneDot(const p: TD3DXPlane; const v: TD3DXVector4): Single;
begin
  with p,v do Result:= a*x + b*y + c*z + d*w;
end;

// ax + by + cz + d
function D3DXPlaneDotCoord(const p: TD3DXPlane; const v: TD3DXVector3): Single;
begin
  with p,v do Result:= a*x + b*y + c*z + d;
end;

// ax + by + cz
function D3DXPlaneDotNormal(const p: TD3DXPlane; const v: TD3DXVector3): Single;
begin
  with p,v do Result:= a*x + b*y + c*z;
end;

function D3DXPlaneScale(out pOut: TD3DXPlane; const pP: TD3DXPlane; s: Single): PD3DXPlane;
begin
  pOut.a := pP.a * s;
  pOut.b := pP.b * s;
  pOut.c := pP.c * s;
  pOut.d := pP.d * s;
  Result := @pOut;
end;


//--------------------------
// Color
//--------------------------

// inline

function D3DXColorNegative(out cOut: TD3DXColor; const c: TD3DXColor): PD3DXColor;
begin
 with cOut do
 begin
   r:= 1.0 - c.r; g:= 1.0 - c.g; b:= 1.0 - c.b;
   a:= c.a;
 end;
 Result:= @cOut;
end;

function D3DXColorAdd(out cOut: TD3DXColor; const c1,c2: TD3DXColor): PD3DXColor;
begin
  with cOut do
  begin
    r:= c1.r + c2.r; g:= c1.g + c2.g; b:= c1.b + c2.b;
    a:= c1.a + c2.a;
  end;
  Result:= @cOut;
end;

function D3DXColorSubtract(out cOut: TD3DXColor; const c1,c2: TD3DXColor): PD3DXColor;
begin
  with cOut do
  begin
    r:= c1.r - c2.r; g:= c1.g - c2.g; b:= c1.b - c2.b;
    a:= c1.a - c2.a;
  end;
  Result:= @cOut;
end;

function D3DXColorScale(out cOut: TD3DXColor; const c: TD3DXColor; s: Single): PD3DXColor;
begin
  with cOut do
  begin
    r:= c.r * s; g:= c.g * s;
    b:= c.b * s; a:= c.a * s;
  end;
  Result:= @cOut;
end;

// (r1*r2, g1*g2, b1*b2, a1*a2)
function D3DXColorModulate(out cOut: TD3DXColor; const c1,c2: TD3DXColor): PD3DXColor;
begin
  with cOut do
  begin
    r:= c1.r * c2.r; g:= c1.g * c2.g;
    b:= c1.b * c2.b; a:= c1.a * c2.a;
  end;
  Result:= @cOut;
end;

// Linear interpolation of r,g,b, and a. C1 + s(C2-C1)
function D3DXColorLerp(out cOut: TD3DXColor; const c1,c2: TD3DXColor; s: Single): PD3DXColor;
begin
  with cOut do
  begin
    r:= c1.r + s * (c2.r - c1.r);
    g:= c1.g + s * (c2.g - c1.g);
    b:= c1.b + s * (c2.b - c1.b);
    a:= c1.a + s * (c2.a - c1.a);
  end;
  Result:= @cOut;
end;




//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx9tex.h
//  Content:    D3DX texturing APIs
//
//////////////////////////////////////////////////////////////////////////////

// #define D3DX_SKIP_DDS_MIP_LEVELS(levels, filter) ((((levels) & D3DX_SKIP_DDS_MIP_LEVELS_MASK) << D3DX_SKIP_DDS_MIP_LEVELS_SHIFT) | ((filter) == D3DX_DEFAULT ? D3DX_FILTER_BOX : (filter)))
function D3DX_SKIP_DDS_MIP_LEVELS(levels, filter: DWORD): DWORD; inline;
begin
  if (filter = D3DX_DEFAULT) then filter :=  D3DX_FILTER_BOX;
  Result := ((levels and D3DX_SKIP_DDS_MIP_LEVELS_MASK) shl D3DX_SKIP_DDS_MIP_LEVELS_SHIFT) or filter;
end;




//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//
//  File:       d3dx9shader.h
//  Content:    D3DX Shader APIs
//
//////////////////////////////////////////////////////////////////////////////


//---------------------------------------------------------------------------
// D3DXTX_VERSION:
// --------------
// Version token used to create a procedural texture filler in effects
// Used by D3DXFill[]TX functions
//---------------------------------------------------------------------------
// #define D3DXTX_VERSION(_Major,_Minor) (('T' << 24) | ('X' << 16) | ((_Major) << 8) | (_Minor))
function D3DXTX_VERSION(_Major, _Minor: Byte): DWORD;
begin
  Result := (Ord('T') shl 24) or (Ord('X') shl 16) or (_Major shl 8) or (_Minor);
end;


end.
