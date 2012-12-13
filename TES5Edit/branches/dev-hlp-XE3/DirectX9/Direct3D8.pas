{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      d3d8types.h d3d8caps.h d3d8.h                                 *}
{*  Content:    Direct3D8 include files                                       *}
{*                                                                            *}
{*  DirectX 8.1 Delphi adaptation by Alexey Barkovoy                          *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Modified: 19-Jan-2004                                                     *}
{*                                                                            *}
{*  Partly based upon :                                                       *}
{*    DirectX 7.0 Object Pascal adaptation by                                 *}
{*      Erik Unger, e-Mail: DelphiDirectX@next-reality.com                    *}
{*    DirectXGraphics 8.0 ObjectPascal adaptation by                          *}
{*      Tim Baumgarten, e-Mail: ampaze@gmx.net                                *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://clootie.ru                                                       *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
{*  This File contains only Direct3D 8.x definitions.                         *}
{*  If you want to use older versions of D3D use Direct3D.pas from Erik Unger *}
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

unit Direct3D8;

interface

// Global level dynamic loading support    

// Remove "dots" below to force some kind of dynamic linking
{.$DEFINE DIRECT3D8_DYNAMIC_LINK}
{.$DEFINE DIRECT3D8_DYNAMIC_LINK_EXPLICIT}

(*$HPPEMIT '#include <d3d8types.h>' *)
(*$HPPEMIT '#include <d3d8caps.h>' *)
(*$HPPEMIT '#include <d3d8.h>' *)

uses Windows, DXTypes;

///// Helper constants (for use in SetRenderState) /////
const
  iTrue  = DWORD(True);
  iFalse = DWORD(False);

(*==========================================================================;
 *
 *  Copyright (C) 1995-2000 Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       d3d8types.h
 *  Content:    Direct3D capabilities include file
 *
 ***************************************************************************)

type
  // D3DCOLOR is equivalent to D3DFMT_A8R8G8B8
  D3DCOLOR = DXTypes.D3DCOLOR;
  {$EXTERNALSYM D3DCOLOR}
  TD3DColor = DXTypes.TD3DColor;

// maps unsigned 8 bits/channel to D3DCOLOR
// #define D3DCOLOR_ARGB(a,r,g,b) \
//     ((D3DCOLOR)((((a)&0xff)<<24)|(((r)&0xff)<<16)|(((g)&0xff)<<8)|((b)&0xff)))
function D3DCOLOR_ARGB(a,r,g,b: DWord): TD3DColor;
{$EXTERNALSYM D3DCOLOR_ARGB}
// #define D3DCOLOR_RGBA(r,g,b,a) D3DCOLOR_ARGB(a,r,g,b)
function D3DCOLOR_RGBA(r,g,b,a: DWord): TD3DColor;
{$EXTERNALSYM D3DCOLOR_RGBA}
// #define D3DCOLOR_XRGB(r,g,b)   D3DCOLOR_ARGB(0xff,r,g,b)
function D3DCOLOR_XRGB(r,g,b: DWord): TD3DColor;
{$EXTERNALSYM D3DCOLOR_XRGB}

// maps floating point channels (0.f to 1.f range) to D3DCOLOR
// #define D3DCOLOR_COLORVALUE(r,g,b,a) \
//     D3DCOLOR_RGBA((DWORD)((r)*255.f),(DWORD)((g)*255.f),(DWORD)((b)*255.f),(DWORD)((a)*255.f))
function D3DCOLOR_COLORVALUE(r,g,b,a: Single): TD3DColor;
{$EXTERNALSYM D3DCOLOR_COLORVALUE}

type
  _D3DVECTOR = DXTypes._D3DVECTOR;
  {$EXTERNALSYM _D3DVECTOR}
  D3DVECTOR = DXTypes.D3DVECTOR;
  {$EXTERNALSYM D3DVECTOR}
  TD3DVector = DXTypes.TD3DVector;
  PD3DVector = DXTypes.PD3DVector;

  PD3DColorValue = ^TD3DColorValue;
  _D3DCOLORVALUE = packed record
    r: Single;
    g: Single;
    b: Single;
    a: Single;
  end {_D3DCOLORVALUE};
  {$EXTERNALSYM _D3DCOLORVALUE}
  D3DCOLORVALUE = _D3DCOLORVALUE;
  {$EXTERNALSYM D3DCOLORVALUE}
  TD3DColorValue = _D3DCOLORVALUE;

  PD3DRect = ^TD3DRect;
  _D3DRECT = packed record
    x1: LongInt;
    y1: LongInt;
    x2: LongInt;
    y2: LongInt;
  end {_D3DRECT};
  {$EXTERNALSYM _D3DRECT}
  D3DRECT = _D3DRECT;
  {$EXTERNALSYM D3DRECT}
  TD3DRect = _D3DRECT;

  PD3DMatrix = ^TD3DMatrix;
  _D3DMATRIX = packed record
    case integer of
      0 : (_11, _12, _13, _14: Single;
           _21, _22, _23, _24: Single;
           _31, _32, _33, _34: Single;
           _41, _42, _43, _44: Single);
      1 : (m : array [0..3, 0..3] of Single);
  end {_D3DMATRIX};
  {$EXTERNALSYM _D3DMATRIX}
  D3DMATRIX = _D3DMATRIX;
  {$EXTERNALSYM D3DMATRIX}
  TD3DMatrix = _D3DMATRIX;

  PD3DViewport8 = ^TD3DViewport8;
  _D3DVIEWPORT8 = packed record
    X: DWord;
    Y: DWord;         { Viewport Top left }
    Width: DWord;
    Height: DWord;    { Viewport Dimensions }
    MinZ: Single;       { Min/max of clip Volume }
    MaxZ: Single;
  end {_D3DVIEWPORT8};
  {$EXTERNALSYM _D3DVIEWPORT8}
  D3DVIEWPORT8 = _D3DVIEWPORT8;
  {$EXTERNALSYM D3DVIEWPORT8}
  TD3DViewport8 = _D3DVIEWPORT8;

(*
 * Values for clip fields.
 *)

const
  // Max number of user clipping planes, supported in D3D.
  D3DMAXUSERCLIPPLANES = 32;
  {$EXTERNALSYM D3DMAXUSERCLIPPLANES}

  // These bits could be ORed together to use with D3DRS_CLIPPLANEENABLE
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

  // The following bits are used in the ClipUnion and ClipIntersection
  // members of the D3DCLIPSTATUS8
  //
  D3DCS_LEFT    = $00000001;
  {$EXTERNALSYM D3DCS_LEFT}
  D3DCS_RIGHT   = $00000002;
  {$EXTERNALSYM D3DCS_RIGHT}
  D3DCS_TOP     = $00000004;
  {$EXTERNALSYM D3DCS_TOP}
  D3DCS_BOTTOM  = $00000008;
  {$EXTERNALSYM D3DCS_BOTTOM}
  D3DCS_FRONT   = $00000010;
  {$EXTERNALSYM D3DCS_FRONT}
  D3DCS_BACK    = $00000020;
  {$EXTERNALSYM D3DCS_BACK}
  D3DCS_PLANE0  = $00000040;
  {$EXTERNALSYM D3DCS_PLANE0}
  D3DCS_PLANE1  = $00000080;
  {$EXTERNALSYM D3DCS_PLANE1}
  D3DCS_PLANE2  = $00000100;
  {$EXTERNALSYM D3DCS_PLANE2}
  D3DCS_PLANE3  = $00000200;
  {$EXTERNALSYM D3DCS_PLANE3}
  D3DCS_PLANE4  = $00000400;
  {$EXTERNALSYM D3DCS_PLANE4}
  D3DCS_PLANE5  = $00000800;
  {$EXTERNALSYM D3DCS_PLANE5}

  D3DCS_ALL     = D3DCS_LEFT   or
                  D3DCS_RIGHT  or
                  D3DCS_TOP    or
                  D3DCS_BOTTOM or
                  D3DCS_FRONT  or
                  D3DCS_BACK   or
                  D3DCS_PLANE0 or
                  D3DCS_PLANE1 or
                  D3DCS_PLANE2 or
                  D3DCS_PLANE3 or
                  D3DCS_PLANE4 or
                  D3DCS_PLANE5;
  {$EXTERNALSYM D3DCS_ALL}

type
  PD3DClipStatus8 = ^TD3DClipStatus8;
  _D3DCLIPSTATUS8 = packed record
    ClipUnion: DWord;
    ClipIntersection: DWord;
  end {_D3DCLIPSTATUS8};
  {$EXTERNALSYM _D3DCLIPSTATUS8}
  D3DCLIPSTATUS8 = _D3DCLIPSTATUS8;
  {$EXTERNALSYM D3DCLIPSTATUS8}
  TD3DClipStatus8 = _D3DCLIPSTATUS8;

  PD3DMaterial8 = ^TD3DMaterial8;
  _D3DMATERIAL8 = packed record
    Diffuse: TD3DColorValue;   { Diffuse color RGBA }
    Ambient: TD3DColorValue;   { Ambient color RGB }
    Specular: TD3DColorValue;  { Specular 'shininess' }
    Emissive: TD3DColorValue;  { Emissive color RGB }
    Power: Single;             { Sharpness if specular highlight }
  end {_D3DMATERIAL8};
  {$EXTERNALSYM _D3DMATERIAL8}
  D3DMATERIAL8 = _D3DMATERIAL8;
  {$EXTERNALSYM D3DMATERIAL8}
  TD3DMaterial8 = _D3DMATERIAL8;

  _D3DLIGHTTYPE = (
    D3DLIGHT_POINT       = 1,
    D3DLIGHT_SPOT        = 2,
    D3DLIGHT_DIRECTIONAL = 3
  );
  {$EXTERNALSYM _D3DLIGHTTYPE}
  D3DLIGHTTYPE = _D3DLIGHTTYPE;
  {$EXTERNALSYM D3DLIGHTTYPE}
  TD3DLightType = _D3DLIGHTTYPE;

  PD3DLight8 = ^TD3DLight8;
  _D3DLIGHT8 = packed record
    _Type: TD3DLightType;       { Type of light source }
    Diffuse: TD3DColorValue;    { Diffuse color of light }
    Specular: TD3DColorValue;   { Specular color of light }
    Ambient: TD3DColorValue;    { Ambient color of light }
    Position: TD3DVector;       { Position in world space }
    Direction: TD3DVector;      { Direction in world space }
    Range: Single;              { Cutoff range }
    Falloff: Single;            { Falloff }
    Attenuation0: Single;       { Constant attenuation }
    Attenuation1: Single;       { Linear attenuation }
    Attenuation2: Single;       { Quadratic attenuation }
    Theta: Single;              { Inner angle of spotlight cone }
    Phi: Single;                { Outer angle of spotlight cone }
  end {_D3DLIGHT8};
  {$EXTERNALSYM _D3DLIGHT8}
  D3DLIGHT8 = _D3DLIGHT8;
  {$EXTERNALSYM D3DLIGHT8}
  TD3DLight8 = _D3DLIGHT8;

(*
 * Options for clearing
 *)
const
  D3DCLEAR_TARGET       = $00000001; { Clear target surface }
  {$EXTERNALSYM D3DCLEAR_TARGET}
  D3DCLEAR_ZBUFFER      = $00000002; { Clear target z buffer }
  {$EXTERNALSYM D3DCLEAR_ZBUFFER}
  D3DCLEAR_STENCIL      = $00000004; { Clear stencil planes }
  {$EXTERNALSYM D3DCLEAR_STENCIL}

(*
 * The following defines the rendering states
 *)
type
  _D3DSHADEMODE = type DWord;
  {$EXTERNALSYM _D3DSHADEMODE}
  D3DSHADEMODE = _D3DSHADEMODE;
  {$EXTERNALSYM D3DSHADEMODE}
  TD3DShadeMode = _D3DSHADEMODE;

const
  D3DSHADE_FLAT      = 1;
  {$EXTERNALSYM D3DSHADE_FLAT}
  D3DSHADE_GOURAUD   = 2;
  {$EXTERNALSYM D3DSHADE_GOURAUD}
  D3DSHADE_PHONG     = 3;
  {$EXTERNALSYM D3DSHADE_PHONG}

type
  _D3DFILLMODE = type DWord;
  {$EXTERNALSYM _D3DFILLMODE}
  D3DFILLMODE = _D3DFILLMODE;
  {$EXTERNALSYM D3DFILLMODE}
  TD3DFillMode = _D3DFILLMODE;

const
  D3DFILL_POINT      = 1;
  {$EXTERNALSYM D3DFILL_POINT}
  D3DFILL_WIREFRAME  = 2;
  {$EXTERNALSYM D3DFILL_WIREFRAME}
  D3DFILL_SOLID      = 3;
  {$EXTERNALSYM D3DFILL_SOLID}

type
  PD3DLinePattern = ^TD3DLinePattern;
  _D3DLINEPATTERN = packed record
    wRepeatFactor: Word;
    wLinePattern: Word;
  end {_D3DLINEPATTERN};
  {$EXTERNALSYM _D3DLINEPATTERN}
  D3DLINEPATTERN = _D3DLINEPATTERN;
  {$EXTERNALSYM D3DLINEPATTERN}
  TD3DLinePattern = _D3DLINEPATTERN;

type
  _D3DBLEND = type DWord;
  {$EXTERNALSYM _D3DBLEND}
  D3DBLEND = _D3DBLEND;
  {$EXTERNALSYM D3DBLEND}
  TD3DBlend = _D3DBLEND;

const
  D3DBLEND_ZERO              = 1;
  {$EXTERNALSYM D3DBLEND_ZERO}
  D3DBLEND_ONE               = 2;
  {$EXTERNALSYM D3DBLEND_ONE}
  D3DBLEND_SRCCOLOR          = 3;
  {$EXTERNALSYM D3DBLEND_SRCCOLOR}
  D3DBLEND_INVSRCCOLOR       = 4;
  {$EXTERNALSYM D3DBLEND_INVSRCCOLOR}
  D3DBLEND_SRCALPHA          = 5;
  {$EXTERNALSYM D3DBLEND_SRCALPHA}
  D3DBLEND_INVSRCALPHA       = 6;
  {$EXTERNALSYM D3DBLEND_INVSRCALPHA}
  D3DBLEND_DESTALPHA         = 7;
  {$EXTERNALSYM D3DBLEND_DESTALPHA}
  D3DBLEND_INVDESTALPHA      = 8;
  {$EXTERNALSYM D3DBLEND_INVDESTALPHA}
  D3DBLEND_DESTCOLOR         = 9;
  {$EXTERNALSYM D3DBLEND_DESTCOLOR}
  D3DBLEND_INVDESTCOLOR      = 10;
  {$EXTERNALSYM D3DBLEND_INVDESTCOLOR}
  D3DBLEND_SRCALPHASAT       = 11;
  {$EXTERNALSYM D3DBLEND_SRCALPHASAT}
  D3DBLEND_BOTHSRCALPHA      = 12;
  {$EXTERNALSYM D3DBLEND_BOTHSRCALPHA}
  D3DBLEND_BOTHINVSRCALPHA   = 13;
  {$EXTERNALSYM D3DBLEND_BOTHINVSRCALPHA}

type
  _D3DBLENDOP = type DWord;
  {$EXTERNALSYM _D3DBLENDOP}
  D3DBLENDOP = _D3DBLENDOP;
  {$EXTERNALSYM D3DBLENDOP}
  TD3DBlendOp = _D3DBLENDOP;

const
  D3DBLENDOP_ADD             = 1;
  {$EXTERNALSYM D3DBLENDOP_ADD}
  D3DBLENDOP_SUBTRACT        = 2;
  {$EXTERNALSYM D3DBLENDOP_SUBTRACT}
  D3DBLENDOP_REVSUBTRACT     = 3;
  {$EXTERNALSYM D3DBLENDOP_REVSUBTRACT}
  D3DBLENDOP_MIN             = 4;
  {$EXTERNALSYM D3DBLENDOP_MIN}
  D3DBLENDOP_MAX             = 5;
  {$EXTERNALSYM D3DBLENDOP_MAX}

type
  _D3DTEXTUREADDRESS = type DWord;
  {$EXTERNALSYM _D3DTEXTUREADDRESS}
  D3DTEXTUREADDRESS = _D3DTEXTUREADDRESS;
  {$EXTERNALSYM D3DTEXTUREADDRESS}
  TD3DTextureAddress = _D3DTEXTUREADDRESS;

const
  D3DTADDRESS_WRAP           = 1;
  {$EXTERNALSYM D3DTADDRESS_WRAP}
  D3DTADDRESS_MIRROR         = 2;
  {$EXTERNALSYM D3DTADDRESS_MIRROR}
  D3DTADDRESS_CLAMP          = 3;
  {$EXTERNALSYM D3DTADDRESS_CLAMP}
  D3DTADDRESS_BORDER         = 4;
  {$EXTERNALSYM D3DTADDRESS_BORDER}
  D3DTADDRESS_MIRRORONCE     = 5;
  {$EXTERNALSYM D3DTADDRESS_MIRRORONCE}

type
  _D3DCULL = type DWord;
  {$EXTERNALSYM _D3DCULL}
  D3DCULL = _D3DCULL;
  {$EXTERNALSYM D3DCULL}
  TD3DCull = _D3DCULL;

const
  D3DCULL_NONE       = 1;
  {$EXTERNALSYM D3DCULL_NONE}
  D3DCULL_CW         = 2;
  {$EXTERNALSYM D3DCULL_CW}
  D3DCULL_CCW        = 3;
  {$EXTERNALSYM D3DCULL_CCW}

type
  _D3DCMPFUNC = type DWord;
  {$EXTERNALSYM _D3DCMPFUNC}
  D3DCMPFUNC = _D3DCMPFUNC;
  {$EXTERNALSYM D3DCMPFUNC}
  TD3DCmpFunc = _D3DCMPFUNC;

const
  D3DCMP_NEVER          = 1;
  {$EXTERNALSYM D3DCMP_NEVER}
  D3DCMP_LESS           = 2;
  {$EXTERNALSYM D3DCMP_LESS}
  D3DCMP_EQUAL          = 3;
  {$EXTERNALSYM D3DCMP_EQUAL}
  D3DCMP_LESSEQUAL      = 4;
  {$EXTERNALSYM D3DCMP_LESSEQUAL}
  D3DCMP_GREATER        = 5;
  {$EXTERNALSYM D3DCMP_GREATER}
  D3DCMP_NOTEQUAL       = 6;
  {$EXTERNALSYM D3DCMP_NOTEQUAL}
  D3DCMP_GREATEREQUAL   = 7;
  {$EXTERNALSYM D3DCMP_GREATEREQUAL}
  D3DCMP_ALWAYS         = 8;
  {$EXTERNALSYM D3DCMP_ALWAYS}

type
  _D3DSTENCILOP = type DWord;
  {$EXTERNALSYM _D3DSTENCILOP}
  D3DSTENCILOP = _D3DSTENCILOP;
  {$EXTERNALSYM D3DSTENCILOP}
  TD3DStencilOp = _D3DSTENCILOP;

const
  D3DSTENCILOP_KEEP     = 1;
  {$EXTERNALSYM D3DSTENCILOP_KEEP}
  D3DSTENCILOP_ZERO     = 2;
  {$EXTERNALSYM D3DSTENCILOP_ZERO}
  D3DSTENCILOP_REPLACE  = 3;
  {$EXTERNALSYM D3DSTENCILOP_REPLACE}
  D3DSTENCILOP_INCRSAT  = 4;
  {$EXTERNALSYM D3DSTENCILOP_INCRSAT}
  D3DSTENCILOP_DECRSAT  = 5;
  {$EXTERNALSYM D3DSTENCILOP_DECRSAT}
  D3DSTENCILOP_INVERT   = 6;
  {$EXTERNALSYM D3DSTENCILOP_INVERT}
  D3DSTENCILOP_INCR     = 7;
  {$EXTERNALSYM D3DSTENCILOP_INCR}
  D3DSTENCILOP_DECR     = 8;
  {$EXTERNALSYM D3DSTENCILOP_DECR}

type
  _D3DFOGMODE = type DWord;
  {$EXTERNALSYM _D3DFOGMODE}
  D3DFOGMODE = _D3DFOGMODE;
  {$EXTERNALSYM D3DFOGMODE}
  TD3DFogMode = _D3DFOGMODE;

const
  D3DFOG_NONE   = 0;
  {$EXTERNALSYM D3DFOG_NONE}
  D3DFOG_EXP    = 1;
  {$EXTERNALSYM D3DFOG_EXP}
  D3DFOG_EXP2   = 2;
  {$EXTERNALSYM D3DFOG_EXP2}
  D3DFOG_LINEAR = 3;
  {$EXTERNALSYM D3DFOG_LINEAR}

type
  _D3DZBUFFERTYPE = type DWord;
  {$EXTERNALSYM _D3DZBUFFERTYPE}
  D3DZBUFFERTYPE = _D3DZBUFFERTYPE;
  {$EXTERNALSYM D3DZBUFFERTYPE}
  TD3DZBufferType = _D3DZBUFFERTYPE;

const
  D3DZB_FALSE   = 0;
  {$EXTERNALSYM D3DZB_FALSE}
  D3DZB_TRUE    = 1;
  {$EXTERNALSYM D3DZB_TRUE}
  D3DZB_USEW    = 2;
  {$EXTERNALSYM D3DZB_USEW}

type
  // Primitives supported by draw-primitive API
  _D3DPRIMITIVETYPE = (
    D3DPT_POINTLIST     = 1,
    D3DPT_LINELIST      = 2,
    D3DPT_LINESTRIP     = 3,
    D3DPT_TRIANGLELIST  = 4,
    D3DPT_TRIANGLESTRIP = 5,
    D3DPT_TRIANGLEFAN   = 6
  );
  {$EXTERNALSYM _D3DPRIMITIVETYPE}
  D3DPRIMITIVETYPE = _D3DPRIMITIVETYPE;
  {$EXTERNALSYM D3DPRIMITIVETYPE}
  TD3DPrimitiveType = _D3DPRIMITIVETYPE;

type
  _D3DTRANSFORMSTATETYPE = (
    D3DTS_VIEW          = 2,
    D3DTS_PROJECTION    = 3,
    D3DTS_TEXTURE0      = 16,
    D3DTS_TEXTURE1      = 17,
    D3DTS_TEXTURE2      = 18,
    D3DTS_TEXTURE3      = 19,
    D3DTS_TEXTURE4      = 20,
    D3DTS_TEXTURE5      = 21,
    D3DTS_TEXTURE6      = 22,
    D3DTS_TEXTURE7      = 23,
    D3DTS_FORCE_DWORD   = $7fffffff (* force 32-bit size enum *)
  );
  {$EXTERNALSYM _D3DTRANSFORMSTATETYPE}
  D3DTRANSFORMSTATETYPE = _D3DTRANSFORMSTATETYPE;
  {$EXTERNALSYM D3DTRANSFORMSTATETYPE}
  TD3DTransformStateType = _D3DTRANSFORMSTATETYPE;

// #define D3DTS_WORLDMATRIX(index) (D3DTRANSFORMSTATETYPE)(index + 256)
function D3DTS_WORLDMATRIX(index: Byte): TD3DTransformStateType;
{$EXTERNALSYM D3DTS_WORLDMATRIX}

const
  D3DTS_WORLD   =  TD3DTransformStateType(0 + 256); // #define D3DTS_WORLD  D3DTS_WORLDMATRIX(0)
  {$EXTERNALSYM D3DTS_WORLD}
  D3DTS_WORLD1  =  TD3DTransformStateType(1 + 256); // #define D3DTS_WORLD1 D3DTS_WORLDMATRIX(1)
  {$EXTERNALSYM D3DTS_WORLD1}
  D3DTS_WORLD2  =  TD3DTransformStateType(2 + 256); // #define D3DTS_WORLD2 D3DTS_WORLDMATRIX(2)
  {$EXTERNALSYM D3DTS_WORLD2}
  D3DTS_WORLD3  =  TD3DTransformStateType(3 + 256); // #define D3DTS_WORLD3 D3DTS_WORLDMATRIX(3)
  {$EXTERNALSYM D3DTS_WORLD3}

type
  _D3DRENDERSTATETYPE = (
    D3DRS_ZENABLE                   = 7,    (* D3DZBUFFERTYPE (or TRUE/FALSE for legacy) *)
    D3DRS_FILLMODE                  = 8,    (* D3DFILLMODE *)
    D3DRS_SHADEMODE                 = 9,    (* D3DSHADEMODE *)
    D3DRS_LINEPATTERN               = 10,   (* D3DLINEPATTERN *)
    D3DRS_ZWRITEENABLE              = 14,   (* TRUE to enable z writes *)
    D3DRS_ALPHATESTENABLE           = 15,   (* TRUE to enable alpha tests *)
    D3DRS_LASTPIXEL                 = 16,   (* TRUE for last-pixel on lines *)
    D3DRS_SRCBLEND                  = 19,   (* D3DBLEND *)
    D3DRS_DESTBLEND                 = 20,   (* D3DBLEND *)
    D3DRS_CULLMODE                  = 22,   (* D3DCULL *)
    D3DRS_ZFUNC                     = 23,   (* D3DCMPFUNC *)
    D3DRS_ALPHAREF                  = 24,   (* D3DFIXED *)
    D3DRS_ALPHAFUNC                 = 25,   (* D3DCMPFUNC *)
    D3DRS_DITHERENABLE              = 26,   (* TRUE to enable dithering *)
    D3DRS_ALPHABLENDENABLE          = 27,   (* TRUE to enable alpha blending *)
    D3DRS_FOGENABLE                 = 28,   (* TRUE to enable fog blending *)
    D3DRS_SPECULARENABLE            = 29,   (* TRUE to enable specular *)
    D3DRS_ZVISIBLE                  = 30,   (* TRUE to enable z checking *)
    D3DRS_FOGCOLOR                  = 34,   (* D3DCOLOR *)
    D3DRS_FOGTABLEMODE              = 35,   (* D3DFOGMODE *)
    D3DRS_FOGSTART                  = 36,   (* Fog start (for both vertex and pixel fog) *)
    D3DRS_FOGEND                    = 37,   (* Fog end      *)
    D3DRS_FOGDENSITY                = 38,   (* Fog density  *)
    D3DRS_EDGEANTIALIAS             = 40,   (* TRUE to enable edge antialiasing *)
    D3DRS_ZBIAS                     = 47,   (* LONG Z bias *)
    D3DRS_RANGEFOGENABLE            = 48,   (* Enables range-based fog *)
    D3DRS_STENCILENABLE             = 52,   (* BOOL enable/disable stenciling *)
    D3DRS_STENCILFAIL               = 53,   (* D3DSTENCILOP to do if stencil test fails *)
    D3DRS_STENCILZFAIL              = 54,   (* D3DSTENCILOP to do if stencil test passes and Z test fails *)
    D3DRS_STENCILPASS               = 55,   (* D3DSTENCILOP to do if both stencil and Z tests pass *)
    D3DRS_STENCILFUNC               = 56,   (* D3DCMPFUNC fn.  Stencil Test passes if ((ref & mask) stencilfn (stencil & mask)) is true *)
    D3DRS_STENCILREF                = 57,   (* Reference value used in stencil test *)
    D3DRS_STENCILMASK               = 58,   (* Mask value used in stencil test *)
    D3DRS_STENCILWRITEMASK          = 59,   (* Write mask applied to values written to stencil buffer *)
    D3DRS_TEXTUREFACTOR             = 60,   (* D3DCOLOR used for multi-texture blend *)
    D3DRS_WRAP0                     = 128,  (* wrap for 1st texture coord. set *)
    D3DRS_WRAP1                     = 129,  (* wrap for 2nd texture coord. set *)
    D3DRS_WRAP2                     = 130,  (* wrap for 3rd texture coord. set *)
    D3DRS_WRAP3                     = 131,  (* wrap for 4th texture coord. set *)
    D3DRS_WRAP4                     = 132,  (* wrap for 5th texture coord. set *)
    D3DRS_WRAP5                     = 133,  (* wrap for 6th texture coord. set *)
    D3DRS_WRAP6                     = 134,  (* wrap for 7th texture coord. set *)
    D3DRS_WRAP7                     = 135,  (* wrap for 8th texture coord. set *)
    D3DRS_CLIPPING                  = 136,
    D3DRS_LIGHTING                  = 137,
    D3DRS_AMBIENT                   = 139,
    D3DRS_FOGVERTEXMODE             = 140,
    D3DRS_COLORVERTEX               = 141,
    D3DRS_LOCALVIEWER               = 142,
    D3DRS_NORMALIZENORMALS          = 143,
    D3DRS_DIFFUSEMATERIALSOURCE     = 145,
    D3DRS_SPECULARMATERIALSOURCE    = 146,
    D3DRS_AMBIENTMATERIALSOURCE     = 147,
    D3DRS_EMISSIVEMATERIALSOURCE    = 148,
    D3DRS_VERTEXBLEND               = 151,
    D3DRS_CLIPPLANEENABLE           = 152,
    D3DRS_SOFTWAREVERTEXPROCESSING  = 153,
    D3DRS_POINTSIZE                 = 154,   (* float point size *)
    D3DRS_POINTSIZE_MIN             = 155,   (* float point size min threshold *)
    D3DRS_POINTSPRITEENABLE         = 156,   (* BOOL point texture coord control *)
    D3DRS_POINTSCALEENABLE          = 157,   (* BOOL point size scale enable *)
    D3DRS_POINTSCALE_A              = 158,   (* float point attenuation A value *)
    D3DRS_POINTSCALE_B              = 159,   (* float point attenuation B value *)
    D3DRS_POINTSCALE_C              = 160,   (* float point attenuation C value *)
    D3DRS_MULTISAMPLEANTIALIAS      = 161,  // BOOL - set to do FSAA with multisample buffer
    D3DRS_MULTISAMPLEMASK           = 162,  // DWORD - per-sample enable/disable
    D3DRS_PATCHEDGESTYLE            = 163,  // Sets whether patch edges will use float style tessellation
    D3DRS_PATCHSEGMENTS             = 164,  // Number of segments per edge when drawing patches
    D3DRS_DEBUGMONITORTOKEN         = 165,  // DEBUG ONLY - token to debug monitor
    D3DRS_POINTSIZE_MAX             = 166,   (* float point size max threshold *)
    D3DRS_INDEXEDVERTEXBLENDENABLE  = 167,
    D3DRS_COLORWRITEENABLE          = 168,  // per-channel write enable
    D3DRS_TWEENFACTOR               = 170,   // float tween factor
    D3DRS_BLENDOP                   = 171,   // D3DBLENDOP setting
    D3DRS_POSITIONORDER             = 172,   // NPatch position interpolation order. D3DORDER_LINEAR or D3DORDER_CUBIC (default)
    D3DRS_NORMALORDER               = 173,   // NPatch normal interpolation order. D3DORDER_LINEAR (default) or D3DORDER_QUADRATIC

    D3DRS_FORCE_DWORD               = $7fffffff (* force 32-bit size enum *)
  );
  {$EXTERNALSYM _D3DRENDERSTATETYPE}
  D3DRENDERSTATETYPE = _D3DRENDERSTATETYPE;
  {$EXTERNALSYM D3DRENDERSTATETYPE}
  TD3DRenderStateType = _D3DRENDERSTATETYPE;

type
  // Values for material source
  _D3DMATERIALCOLORSOURCE = type DWord;
  {$EXTERNALSYM _D3DMATERIALCOLORSOURCE}
  D3DMATERIALCOLORSOURCE = _D3DMATERIALCOLORSOURCE;
  {$EXTERNALSYM D3DMATERIALCOLORSOURCE}
  TD3DMaterialSource = _D3DMATERIALCOLORSOURCE;

const
  D3DMCS_MATERIAL       = TD3DMaterialSource(0);         // Color from material is used
  {$EXTERNALSYM D3DMCS_MATERIAL}
  D3DMCS_COLOR1         = TD3DMaterialSource(1);         // Diffuse vertex color is used
  {$EXTERNALSYM D3DMCS_COLOR1}
  D3DMCS_COLOR2         = TD3DMaterialSource(2);         // Specular vertex color is used
  {$EXTERNALSYM D3DMCS_COLOR2}
  D3DMCS_FORCE_DWORD    = TD3DMaterialSource($7fffffff); // force 32-bit size enum
  {$EXTERNALSYM D3DMCS_FORCE_DWORD}

  // Bias to apply to the texture coordinate set to apply a wrap to.
  D3DRENDERSTATE_WRAPBIAS                = DWORD(128);
  {$EXTERNALSYM D3DRENDERSTATE_WRAPBIAS}

  { Flags to construct the WRAP render states }
  D3DWRAP_U             = $00000001;
  {$EXTERNALSYM D3DWRAP_U}
  D3DWRAP_V             = $00000002;
  {$EXTERNALSYM D3DWRAP_V}
  D3DWRAP_W             = $00000004;
  {$EXTERNALSYM D3DWRAP_W}

  { Flags to construct the WRAP render states for 1D thru 4D texture coordinates }
  D3DWRAPCOORD_0        = $00000001;    // same as D3DWRAP_U
  {$EXTERNALSYM D3DWRAPCOORD_0}
  D3DWRAPCOORD_1        = $00000002;    // same as D3DWRAP_V
  {$EXTERNALSYM D3DWRAPCOORD_1}
  D3DWRAPCOORD_2        = $00000004;    // same as D3DWRAP_W
  {$EXTERNALSYM D3DWRAPCOORD_2}
  D3DWRAPCOORD_3        = $00000008;
  {$EXTERNALSYM D3DWRAPCOORD_3}

  { Flags to construct D3DRS_COLORWRITEENABLE }
  D3DCOLORWRITEENABLE_RED       = (1 shl 0);
  {$EXTERNALSYM D3DCOLORWRITEENABLE_RED}
  D3DCOLORWRITEENABLE_GREEN     = (1 shl 1);
  {$EXTERNALSYM D3DCOLORWRITEENABLE_GREEN}
  D3DCOLORWRITEENABLE_BLUE      = (1 shl 2);
  {$EXTERNALSYM D3DCOLORWRITEENABLE_BLUE}
  D3DCOLORWRITEENABLE_ALPHA     = (1 shl 3);
  {$EXTERNALSYM D3DCOLORWRITEENABLE_ALPHA}

(*
 * State enumerants for per-stage texture processing.
 *)
type
  _D3DTEXTURESTAGESTATETYPE = (
    D3DTSS_COLOROP        =  1, { D3DTEXTUREOP - per-stage blending controls for color channels }
    D3DTSS_COLORARG1      =  2, { D3DTA_* (texture arg) }
    D3DTSS_COLORARG2      =  3, { D3DTA_* (texture arg) }
    D3DTSS_ALPHAOP        =  4, { D3DTEXTUREOP - per-stage blending controls for alpha channel }
    D3DTSS_ALPHAARG1      =  5, { D3DTA_* (texture arg) }
    D3DTSS_ALPHAARG2      =  6, { D3DTA_* (texture arg) }
    D3DTSS_BUMPENVMAT00   =  7, { float (bump mapping matrix) }
    D3DTSS_BUMPENVMAT01   =  8, { float (bump mapping matrix) }
    D3DTSS_BUMPENVMAT10   =  9, { float (bump mapping matrix) }
    D3DTSS_BUMPENVMAT11   = 10, { float (bump mapping matrix) }
    D3DTSS_TEXCOORDINDEX  = 11, { identifies which set of texture coordinates index this texture }
    D3DTSS_ADDRESSU       = 13, { D3DTEXTUREADDRESS for U coordinate }
    D3DTSS_ADDRESSV       = 14, { D3DTEXTUREADDRESS for V coordinate }
    D3DTSS_BORDERCOLOR    = 15, { D3DCOLOR }
    D3DTSS_MAGFILTER      = 16, { D3DTEXTUREFILTER filter to use for magnification }
    D3DTSS_MINFILTER      = 17, { D3DTEXTUREFILTER filter to use for minification }
    D3DTSS_MIPFILTER      = 18, { D3DTEXTUREFILTER filter to use between mipmaps during minification }
    D3DTSS_MIPMAPLODBIAS  = 19, { float Mipmap LOD bias }
    D3DTSS_MAXMIPLEVEL    = 20, { DWORD 0..(n-1) LOD index of largest map to use (0 == largest) }
    D3DTSS_MAXANISOTROPY  = 21, { DWORD maximum anisotropy }
    D3DTSS_BUMPENVLSCALE  = 22, { float scale for bump map luminance }
    D3DTSS_BUMPENVLOFFSET = 23, { float offset for bump map luminance }
    D3DTSS_TEXTURETRANSFORMFLAGS = 24, { D3DTEXTURETRANSFORMFLAGS controls texture transform }
    D3DTSS_ADDRESSW       = 25, { D3DTEXTUREADDRESS for W coordinate }
    D3DTSS_COLORARG0      = 26, { D3DTA_* third arg for triadic ops }
    D3DTSS_ALPHAARG0      = 27, { D3DTA_* third arg for triadic ops }
    D3DTSS_RESULTARG      = 28  { D3DTA_* arg for result (CURRENT or TEMP) }
  );
  {$EXTERNALSYM _D3DTEXTURESTAGESTATETYPE}
  D3DTEXTURESTAGESTATETYPE = _D3DTEXTURESTAGESTATETYPE;
  {$EXTERNALSYM D3DTEXTURESTAGESTATETYPE}
  TD3DTextureStageStateType = _D3DTEXTURESTAGESTATETYPE;

const
  // Values, used with D3DTSS_TEXCOORDINDEX, to specify that the vertex data(position
  // and normal in the camera space) should be taken as texture coordinates
  // Low 16 bits are used to specify texture coordinate index, to take the WRAP mode from
  //
  D3DTSS_TCI_PASSTHRU                           = $00000000;
  {$EXTERNALSYM D3DTSS_TCI_PASSTHRU}
  D3DTSS_TCI_CAMERASPACENORMAL                  = $00010000;
  {$EXTERNALSYM D3DTSS_TCI_CAMERASPACENORMAL}
  D3DTSS_TCI_CAMERASPACEPOSITION                = $00020000;
  {$EXTERNALSYM D3DTSS_TCI_CAMERASPACEPOSITION}
  D3DTSS_TCI_CAMERASPACEREFLECTIONVECTOR        = $00030000;
  {$EXTERNALSYM D3DTSS_TCI_CAMERASPACEREFLECTIONVECTOR}

(*
 * Enumerations for COLOROP and ALPHAOP texture blending operations set in
 * texture processing stage controls in D3DTSS.
 *)
type
  _D3DTEXTUREOP = type DWord;
  {$EXTERNALSYM _D3DTEXTUREOP}
  D3DTEXTUREOP = _D3DTEXTUREOP;
  {$EXTERNALSYM D3DTEXTUREOP}
  TD3DTextureOp = _D3DTEXTUREOP;

const
  // Control
  D3DTOP_DISABLE              = 1;      // disables stage
  {$EXTERNALSYM D3DTOP_DISABLE}
  D3DTOP_SELECTARG1           = 2;      // the default
  {$EXTERNALSYM D3DTOP_SELECTARG1}
  D3DTOP_SELECTARG2           = 3;
  {$EXTERNALSYM D3DTOP_SELECTARG2}

  // Modulate
  D3DTOP_MODULATE             = 4;      // multiply args together
  {$EXTERNALSYM D3DTOP_MODULATE}
  D3DTOP_MODULATE2X           = 5;      // multiply and  1 bit
  {$EXTERNALSYM D3DTOP_MODULATE2X}
  D3DTOP_MODULATE4X           = 6;      // multiply and  2 bits
  {$EXTERNALSYM D3DTOP_MODULATE4X}

  // Add
  D3DTOP_ADD                  =  7;   // add arguments together
  {$EXTERNALSYM D3DTOP_ADD}
  D3DTOP_ADDSIGNED            =  8;   // add with -0.5 bias
  {$EXTERNALSYM D3DTOP_ADDSIGNED}
  D3DTOP_ADDSIGNED2X          =  9;   // as above but left  1 bit
  {$EXTERNALSYM D3DTOP_ADDSIGNED2X}
  D3DTOP_SUBTRACT             = 10;   // Arg1 - Arg2, with no saturation
  {$EXTERNALSYM D3DTOP_SUBTRACT}
  D3DTOP_ADDSMOOTH            = 11;   // add 2 args, subtract product
                                      // Arg1 + Arg2 - Arg1*Arg2
                                      // = Arg1 + (1-Arg1)*Arg2
  {$EXTERNALSYM D3DTOP_ADDSMOOTH}

  // Linear alpha blend: Arg1*(Alpha) + Arg2*(1-Alpha)
  D3DTOP_BLENDDIFFUSEALPHA    = 12; // iterated alpha
  {$EXTERNALSYM D3DTOP_BLENDDIFFUSEALPHA}
  D3DTOP_BLENDTEXTUREALPHA    = 13; // texture alpha
  {$EXTERNALSYM D3DTOP_BLENDTEXTUREALPHA}
  D3DTOP_BLENDFACTORALPHA     = 14; // alpha from D3DRS_TEXTUREFACTOR
  {$EXTERNALSYM D3DTOP_BLENDFACTORALPHA}

  // Linear alpha blend with pre-multiplied arg1 input: Arg1 + Arg2*(1-Alpha)
  D3DTOP_BLENDTEXTUREALPHAPM  = 15; // texture alpha
  {$EXTERNALSYM D3DTOP_BLENDTEXTUREALPHAPM}
  D3DTOP_BLENDCURRENTALPHA    = 16; // by alpha of current color
  {$EXTERNALSYM D3DTOP_BLENDCURRENTALPHA}

  // Specular mapping
  D3DTOP_PREMODULATE            = 17;     // modulate with next texture before use
  {$EXTERNALSYM D3DTOP_PREMODULATE}
  D3DTOP_MODULATEALPHA_ADDCOLOR = 18;     // Arg1.RGB + Arg1.A*Arg2.RGB
                                          // COLOROP only
  {$EXTERNALSYM D3DTOP_MODULATEALPHA_ADDCOLOR}
  D3DTOP_MODULATECOLOR_ADDALPHA = 19;     // Arg1.RGB*Arg2.RGB + Arg1.A
                                          // COLOROP only
  {$EXTERNALSYM D3DTOP_MODULATECOLOR_ADDALPHA}
  D3DTOP_MODULATEINVALPHA_ADDCOLOR = 20;  // (1-Arg1.A)*Arg2.RGB + Arg1.RGB
                                          // COLOROP only
  {$EXTERNALSYM D3DTOP_MODULATEINVALPHA_ADDCOLOR}
  D3DTOP_MODULATEINVCOLOR_ADDALPHA = 21;  // (1-Arg1.RGB)*Arg2.RGB + Arg1.A
                                          // COLOROP only
  {$EXTERNALSYM D3DTOP_MODULATEINVCOLOR_ADDALPHA}

  // Bump mapping
  D3DTOP_BUMPENVMAP           = 22; // per pixel env map perturbation
  {$EXTERNALSYM D3DTOP_BUMPENVMAP}
  D3DTOP_BUMPENVMAPLUMINANCE  = 23; // with luminance channel
  {$EXTERNALSYM D3DTOP_BUMPENVMAPLUMINANCE}

  // This can do either diffuse or specular bump mapping with correct input.
  // Performs the function (Arg1.R*Arg2.R + Arg1.G*Arg2.G + Arg1.B*Arg2.B)
  // where each component has been scaled and offset to make it signed.
  // The result is replicated into all four (including alpha) channels.
  // This is a valid COLOROP only.
  D3DTOP_DOTPRODUCT3          = 24;
  {$EXTERNALSYM D3DTOP_DOTPRODUCT3}

  // Triadic ops
  D3DTOP_MULTIPLYADD          = 25; // Arg0 + Arg1*Arg2
  {$EXTERNALSYM D3DTOP_MULTIPLYADD}
  D3DTOP_LERP                 = 26; // (Arg0)*Arg1 + (1-Arg0)*Arg2
  {$EXTERNALSYM D3DTOP_LERP}

(*
 * Values for COLORARG0,1,2, ALPHAARG0,1,2, and RESULTARG texture blending
 * operations set in texture processing stage controls in D3DRENDERSTATE.
 *)
const
  D3DTA_SELECTMASK        = $0000000f;  // mask for arg selector
  {$EXTERNALSYM D3DTA_SELECTMASK}
  D3DTA_DIFFUSE           = $00000000;  // select diffuse color (read only)
  {$EXTERNALSYM D3DTA_DIFFUSE}
  D3DTA_CURRENT           = $00000001;  // select stage destination register (read/write)
  {$EXTERNALSYM D3DTA_CURRENT}
  D3DTA_TEXTURE           = $00000002;  // select texture color (read only)
  {$EXTERNALSYM D3DTA_TEXTURE}
  D3DTA_TFACTOR           = $00000003;  // select D3DRS_TEXTUREFACTOR (read only)
  {$EXTERNALSYM D3DTA_TFACTOR}
  D3DTA_SPECULAR          = $00000004;  // select specular color (read only)
  {$EXTERNALSYM D3DTA_SPECULAR}
  D3DTA_TEMP              = $00000005;  // select temporary register color (read/write)
  {$EXTERNALSYM D3DTA_TEMP}
  D3DTA_COMPLEMENT        = $00000010;  // take 1.0 - x (read modifier)
  {$EXTERNALSYM D3DTA_COMPLEMENT}
  D3DTA_ALPHAREPLICATE    = $00000020;  // replicate alpha to color components (read modifier)
  {$EXTERNALSYM D3DTA_ALPHAREPLICATE}

type
  //
  // Values for D3DTSS_***FILTER texture stage states
  //
  _D3DTEXTUREFILTERTYPE = type DWord;
  {$EXTERNALSYM _D3DTEXTUREFILTERTYPE}
  D3DTEXTUREFILTERTYPE = _D3DTEXTUREFILTERTYPE;
  {$EXTERNALSYM D3DTEXTUREFILTERTYPE}
  TD3DTextureFilterType = _D3DTEXTUREFILTERTYPE;

const
  D3DTEXF_NONE            = 0;    // filtering disabled (valid for mip filter only)
  {$EXTERNALSYM D3DTEXF_NONE}
  D3DTEXF_POINT           = 1;    // nearest
  {$EXTERNALSYM D3DTEXF_POINT}
  D3DTEXF_LINEAR          = 2;    // linear interpolation
  {$EXTERNALSYM D3DTEXF_LINEAR}
  D3DTEXF_ANISOTROPIC     = 3;    // anisotropic
  {$EXTERNALSYM D3DTEXF_ANISOTROPIC}
  D3DTEXF_FLATCUBIC       = 4;    // cubic
  {$EXTERNALSYM D3DTEXF_FLATCUBIC}
  D3DTEXF_GAUSSIANCUBIC   = 5;    // different cubic kernel
  {$EXTERNALSYM D3DTEXF_GAUSSIANCUBIC}

const
  { Bits for Flags in ProcessVertices call }
  D3DPV_DONOTCOPYDATA        = (1 shl 0);
  {$EXTERNALSYM D3DPV_DONOTCOPYDATA}

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

  D3DFVF_NORMAL           = $010;
  {$EXTERNALSYM D3DFVF_NORMAL}
  D3DFVF_PSIZE            = $020;
  {$EXTERNALSYM D3DFVF_PSIZE}
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

  D3DFVF_LASTBETA_UBYTE4  = $1000;
  {$EXTERNALSYM D3DFVF_LASTBETA_UBYTE4}

  D3DFVF_RESERVED2        = $E000;  // 4 reserved bits
  {$EXTERNALSYM D3DFVF_RESERVED2}

  //---------------------------------------------------------------------
  // Vertex Shaders
  //

{

Vertex Shader Declaration

The declaration portion of a vertex shader defines the static external
interface of the shader.  The information in the declaration includes:

- Assignments of vertex shader input registers to data streams.  These
assignments bind a specific vertex register to a single component within a
vertex stream.  A vertex stream element is identified by a byte offset
within the stream and a type.  The type specifies the arithmetic data type
plus the dimensionality (1, 2, 3, or 4 values).  Stream data which is
less than 4 values are always expanded out to 4 values with zero or more
0.F values and one 1.F value.

- Assignment of vertex shader input registers to implicit data from the
primitive tessellator.  This controls the loading of vertex data which is
not loaded from a stream, but rather is generated during primitive
tessellation prior to the vertex shader.

- Loading data into the constant memory at the time a shader is set as the
current shader.  Each token specifies values for one or more contiguous 4
DWORD constant registers.  This allows the shader to update an arbitrary
subset of the constant memory, overwriting the device state (which
contains the current values of the constant memory).  Note that these
values can be subsequently overwritten (between DrawPrimitive calls)
during the time a shader is bound to a device via the
SetVertexShaderConstant method.


Declaration arrays are single-dimensional arrays of DWORDs composed of
multiple tokens each of which is one or more DWORDs.  The single-DWORD
token value 0xFFFFFFFF is a special token used to indicate the end of the
declaration array.  The single DWORD token value 0x00000000 is a NOP token
with is ignored during the declaration parsing.  Note that 0x00000000 is a
valid value for DWORDs following the first DWORD for multiple word tokens.

[31:29] TokenType
    0x0 - NOP (requires all DWORD bits to be zero)
    0x1 - stream selector
    0x2 - stream data definition (map to vertex input memory)
    0x3 - vertex input memory from tessellator
    0x4 - constant memory from shader
    0x5 - extension
    0x6 - reserved
    0x7 - end-of-array (requires all DWORD bits to be 1)

NOP Token (single DWORD token)
    [31:29] 0x0
    [28:00] 0x0

Stream Selector (single DWORD token)
    [31:29] 0x1
    [28]    indicates whether this is a tessellator stream
    [27:04] 0x0
    [03:00] stream selector (0..15)

Stream Data Definition (single DWORD token)
    Vertex Input Register Load
      [31:29] 0x2
      [28]    0x0
      [27:20] 0x0
      [19:16] type (dimensionality and data type)
      [15:04] 0x0
      [03:00] vertex register address (0..15)
    Data Skip (no register load)
      [31:29] 0x2
      [28]    0x1
      [27:20] 0x0
      [19:16] count of DWORDS to skip over (0..15)
      [15:00] 0x0
    Vertex Input Memory from Tessellator Data (single DWORD token)
      [31:29] 0x3
      [28]    indicates whether data is normals or u/v
      [27:24] 0x0
      [23:20] vertex register address (0..15)
      [19:16] type (dimensionality)
      [15:04] 0x0
      [03:00] vertex register address (0..15)

Constant Memory from Shader (multiple DWORD token)
    [31:29] 0x4
    [28:25] count of 4*DWORD constants to load (0..15)
    [24:07] 0x0
    [06:00] constant memory address (0..95)

Extension Token (single or multiple DWORD token)
    [31:29] 0x5
    [28:24] count of additional DWORDs in token (0..31)
    [23:00] extension-specific information

End-of-array token (single DWORD token)
    [31:29] 0x7
    [28:00] 0x1fffffff

The stream selector token must be immediately followed by a contiguous set of stream data definition tokens.  This token sequence fully defines that stream, including the set of elements within the stream, the order in which the elements appear, the type of each element, and the vertex register into which to load an element.
Streams are allowed to include data which is not loaded into a vertex register, thus allowing data which is not used for this shader to exist in the vertex stream.  This skipped data is defined only by a count of DWORDs to skip over, since the type information is irrelevant.
The token sequence:
Stream Select: stream=0
Stream Data Definition (Load): type=FLOAT3; register=3
Stream Data Definition (Load): type=FLOAT3; register=4
Stream Data Definition (Skip): count=2
Stream Data Definition (Load): type=FLOAT2; register=7

defines stream zero to consist of 4 elements, 3 of which are loaded into registers and the fourth skipped over.  Register 3 is loaded with the first three DWORDs in each vertex interpreted as FLOAT data.  Register 4 is loaded with the 4th, 5th, and 6th DWORDs interpreted as FLOAT data.  The next two DWORDs (7th and 8th) are skipped over and not loaded into any vertex input register.   Register 7 is loaded with the 9th and 10th DWORDS interpreted as FLOAT data.
Placing of tokens other than NOPs between the Stream Selector and Stream Data Definition tokens is disallowed.

}

type
  _D3DVSD_TOKENTYPE = (
    D3DVSD_TOKEN_NOP        = 0,    // NOP or extension
    D3DVSD_TOKEN_STREAM,            // stream selector
    D3DVSD_TOKEN_STREAMDATA,        // stream data definition (map to vertex input memory)
    D3DVSD_TOKEN_TESSELLATOR,       // vertex input memory from tessellator
    D3DVSD_TOKEN_CONSTMEM,          // constant memory from shader
    D3DVSD_TOKEN_EXT,               // extension
    D3DVSD_TOKEN_END        = 7     // end-of-array (requires all DWORD bits to be 1)
  );
  {$EXTERNALSYM _D3DVSD_TOKENTYPE}
  D3DVSD_TOKENTYPE = _D3DVSD_TOKENTYPE;
  {$EXTERNALSYM D3DVSD_TOKENTYPE}
  TD3DVSDTokenType = _D3DVSD_TOKENTYPE;

const
  D3DVSD_TOKENTYPESHIFT         = 29;
  {$EXTERNALSYM D3DVSD_TOKENTYPESHIFT}
  D3DVSD_TOKENTYPEMASK          = (7 shl D3DVSD_TOKENTYPESHIFT);
  {$EXTERNALSYM D3DVSD_TOKENTYPEMASK}

  D3DVSD_STREAMNUMBERSHIFT      = 0;
  {$EXTERNALSYM D3DVSD_STREAMNUMBERSHIFT}
  D3DVSD_STREAMNUMBERMASK       = ($F shl D3DVSD_STREAMNUMBERSHIFT);
  {$EXTERNALSYM D3DVSD_STREAMNUMBERMASK}

  D3DVSD_DATALOADTYPESHIFT      = 28;
  {$EXTERNALSYM D3DVSD_DATALOADTYPESHIFT}
  D3DVSD_DATALOADTYPEMASK       = ($1 shl D3DVSD_DATALOADTYPESHIFT);
  {$EXTERNALSYM D3DVSD_DATALOADTYPEMASK}

  D3DVSD_DATATYPESHIFT          = 16;
  {$EXTERNALSYM D3DVSD_DATATYPESHIFT}
  D3DVSD_DATATYPEMASK           = ($F shl D3DVSD_DATATYPESHIFT);
  {$EXTERNALSYM D3DVSD_DATATYPEMASK}

  D3DVSD_SKIPCOUNTSHIFT         = 16;
  {$EXTERNALSYM D3DVSD_SKIPCOUNTSHIFT}
  D3DVSD_SKIPCOUNTMASK          = ($F shl D3DVSD_SKIPCOUNTSHIFT);
  {$EXTERNALSYM D3DVSD_SKIPCOUNTMASK}

  D3DVSD_VERTEXREGSHIFT         = 0;
  {$EXTERNALSYM D3DVSD_VERTEXREGSHIFT}
  D3DVSD_VERTEXREGMASK          = ($1F shl D3DVSD_VERTEXREGSHIFT);
  {$EXTERNALSYM D3DVSD_VERTEXREGMASK}

  {$EXTERNALSYM D3DVSD_VERTEXREGMASK}
  D3DVSD_VERTEXREGINSHIFT       = 20;
  {$EXTERNALSYM D3DVSD_VERTEXREGINSHIFT}
  D3DVSD_VERTEXREGINMASK        = ($F shl D3DVSD_VERTEXREGINSHIFT);
  {$EXTERNALSYM D3DVSD_VERTEXREGINMASK}

  D3DVSD_CONSTCOUNTSHIFT        = 25;
  {$EXTERNALSYM D3DVSD_CONSTCOUNTSHIFT}
  D3DVSD_CONSTCOUNTMASK         = ($F shl D3DVSD_CONSTCOUNTSHIFT);
  {$EXTERNALSYM D3DVSD_CONSTCOUNTMASK}

  D3DVSD_CONSTADDRESSSHIFT      = 0;
  {$EXTERNALSYM D3DVSD_CONSTADDRESSSHIFT}
  D3DVSD_CONSTADDRESSMASK       = ($7F shl D3DVSD_CONSTADDRESSSHIFT);
  {$EXTERNALSYM D3DVSD_CONSTADDRESSMASK}

  D3DVSD_CONSTRSSHIFT           = 16;
  {$EXTERNALSYM D3DVSD_CONSTRSSHIFT}
  D3DVSD_CONSTRSMASK            = ($1FFF shl D3DVSD_CONSTRSSHIFT);
  {$EXTERNALSYM D3DVSD_CONSTRSMASK}

  D3DVSD_EXTCOUNTSHIFT          = 24;
  {$EXTERNALSYM D3DVSD_EXTCOUNTSHIFT}
  D3DVSD_EXTCOUNTMASK           = ($1F shl D3DVSD_EXTCOUNTSHIFT);
  {$EXTERNALSYM D3DVSD_EXTCOUNTMASK}

  D3DVSD_EXTINFOSHIFT           = 0;
  {$EXTERNALSYM D3DVSD_EXTINFOSHIFT}
  D3DVSD_EXTINFOMASK            = ($FFFFFF shl D3DVSD_EXTINFOSHIFT);
  {$EXTERNALSYM D3DVSD_EXTINFOMASK}

// D3DVSD_MAKETOKENTYPE(tokenType) ((tokenType << D3DVSD_TOKENTYPESHIFT) & D3DVSD_TOKENTYPEMASK)
function D3DVSD_MAKETOKENTYPE(tokenType: TD3DVSDTokenType): DWord;
{$EXTERNALSYM D3DVSD_MAKETOKENTYPE}

// macros for generation of CreateVertexShader Declaration token array

// Set current stream
// _StreamNumber [0..(MaxStreams-1)] stream to get data from
//
//#define D3DVSD_STREAM( _StreamNumber ) \
//    (D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_STREAM) | (_StreamNumber))
function D3DVSD_STREAM(_StreamNumber: DWord): DWord;
{$EXTERNALSYM D3DVSD_STREAM}

const
  // Set tessellator stream
  //
  D3DVSD_STREAMTESSSHIFT        = 28;
  {$EXTERNALSYM D3DVSD_STREAMTESSSHIFT}
  D3DVSD_STREAMTESSMASK         = (1 shl D3DVSD_STREAMTESSSHIFT);
  {$EXTERNALSYM D3DVSD_STREAMTESSMASK}

  // #define D3DVSD_STREAM_TESS( ) \
  //    (D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_STREAM) | (D3DVSD_STREAMTESSMASK))
  // !!! - macro just rolled out in pascal (not converted to function)
  D3DVSD_STREAM_TESS = ((DWord(D3DVSD_TOKEN_STREAM) shl D3DVSD_TOKENTYPESHIFT) and
                        D3DVSD_TOKENTYPEMASK) or D3DVSD_STREAMTESSMASK;
  {$EXTERNALSYM D3DVSD_STREAM_TESS}

// bind single vertex register to vertex element from vertex stream
//
// _VertexRegister [0..15] address of the vertex register
// _Type [D3DVSDT_*] dimensionality and arithmetic data type

//#define D3DVSD_REG( _VertexRegister, _Type ) \
//    (D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_STREAMDATA) |            \
//     ((_Type) << D3DVSD_DATATYPESHIFT) | (_VertexRegister))
function D3DVSD_REG(_VertexRegister, _Type: DWord): DWord;
{$EXTERNALSYM D3DVSD_REG}

// Skip _DWORDCount DWORDs in vertex
//
//#define D3DVSD_SKIP( _DWORDCount ) \
//    (D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_STREAMDATA) | 0x10000000 | \
//     ((_DWORDCount) << D3DVSD_SKIPCOUNTSHIFT))
function D3DVSD_SKIP(_DWORDCount: DWord): DWord;
{$EXTERNALSYM D3DVSD_SKIP}

// load data into vertex shader constant memory
//
// _ConstantAddress [0..95] - address of constant array to begin filling data
// _Count [0..15] - number of constant vectors to load (4 DWORDs each)
// followed by 4*_Count DWORDS of data
//
//#define D3DVSD_CONST( _ConstantAddress, _Count ) \
//    (D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_CONSTMEM) | \
//     ((_Count) << D3DVSD_CONSTCOUNTSHIFT) | (_ConstantAddress))
function D3DVSD_CONST(_ConstantAddress, _Count: DWord): DWord;
{$EXTERNALSYM D3DVSD_CONST}

// enable tessellator generated normals
//
// _VertexRegisterIn  [0..15] address of vertex register whose input stream
//                            will be used in normal computation
// _VertexRegisterOut [0..15] address of vertex register to output the normal to
//
//#define D3DVSD_TESSNORMAL( _VertexRegisterIn, _VertexRegisterOut ) \
//    (D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_TESSELLATOR) | \
//     ((_VertexRegisterIn) << D3DVSD_VERTEXREGINSHIFT) | \
//     ((0x02) << D3DVSD_DATATYPESHIFT) | (_VertexRegisterOut))
function D3DVSD_TESSNORMAL(_VertexRegisterIn, _VertexRegisterOut: DWord): DWord;
{$EXTERNALSYM D3DVSD_TESSNORMAL}

// enable tessellator generated surface parameters
//
// _VertexRegister [0..15] address of vertex register to output parameters
//
//#define D3DVSD_TESSUV( _VertexRegister ) \
//    (D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_TESSELLATOR) | 0x10000000 | \
//     ((0x01) << D3DVSD_DATATYPESHIFT) | (_VertexRegister))
function D3DVSD_TESSUV(_VertexRegister: DWord): DWord;
{$EXTERNALSYM D3DVSD_TESSUV}

const
  // Generates END token
  //
  D3DVSD_END    = $FFFFFFFF;
  {$EXTERNALSYM D3DVSD_END}

  // Generates NOP token
  D3DVSD_NOP    = $00000000;
  {$EXTERNALSYM D3DVSD_NOP}

  // bit declarations for _Type fields
  D3DVSDT_FLOAT1      = $00;    // 1D float expanded to (value; 0.; 0.; 1.)
  {$EXTERNALSYM D3DVSDT_FLOAT1}
  D3DVSDT_FLOAT2      = $01;    // 2D float expanded to (value; value; 0.; 1.)
  {$EXTERNALSYM D3DVSDT_FLOAT2}
  D3DVSDT_FLOAT3      = $02;    // 3D float expanded to (value; value; value; 1.)
  {$EXTERNALSYM D3DVSDT_FLOAT3}
  D3DVSDT_FLOAT4      = $03;    // 4D float
  {$EXTERNALSYM D3DVSDT_FLOAT4}
  D3DVSDT_D3DCOLOR    = $04;    // 4D packed unsigned bytes mapped to 0. to 1. range
  {$EXTERNALSYM D3DVSDT_D3DCOLOR}
                                // Input is in D3DCOLOR format (ARGB) expanded to (R; G; B; A)
  D3DVSDT_UBYTE4      = $05;    // 4D unsigned byte
  {$EXTERNALSYM D3DVSDT_UBYTE4}
  D3DVSDT_SHORT2      = $06;    // 2D signed short expanded to (value; value; 0.; 1.)
  {$EXTERNALSYM D3DVSDT_SHORT2}
  D3DVSDT_SHORT4      = $07;    // 4D signed short
  {$EXTERNALSYM D3DVSDT_SHORT4}

  // assignments of vertex input registers for fixed function vertex shader
  //
  D3DVSDE_POSITION      = 0;
  {$EXTERNALSYM D3DVSDE_POSITION}
  D3DVSDE_BLENDWEIGHT   = 1;
  {$EXTERNALSYM D3DVSDE_BLENDWEIGHT}
  D3DVSDE_BLENDINDICES  = 2;
  {$EXTERNALSYM D3DVSDE_BLENDINDICES}
  D3DVSDE_NORMAL        = 3;
  {$EXTERNALSYM D3DVSDE_NORMAL}
  D3DVSDE_PSIZE         = 4;
  {$EXTERNALSYM D3DVSDE_PSIZE}
  D3DVSDE_DIFFUSE       = 5;
  {$EXTERNALSYM D3DVSDE_DIFFUSE}
  D3DVSDE_SPECULAR      = 6;
  {$EXTERNALSYM D3DVSDE_SPECULAR}
  D3DVSDE_TEXCOORD0     = 7;
  {$EXTERNALSYM D3DVSDE_TEXCOORD0}
  D3DVSDE_TEXCOORD1     = 8;
  {$EXTERNALSYM D3DVSDE_TEXCOORD1}
  D3DVSDE_TEXCOORD2     = 9;
  {$EXTERNALSYM D3DVSDE_TEXCOORD2}
  D3DVSDE_TEXCOORD3     = 10;
  {$EXTERNALSYM D3DVSDE_TEXCOORD3}
  D3DVSDE_TEXCOORD4     = 11;
  {$EXTERNALSYM D3DVSDE_TEXCOORD4}
  D3DVSDE_TEXCOORD5     = 12;
  {$EXTERNALSYM D3DVSDE_TEXCOORD5}
  D3DVSDE_TEXCOORD6     = 13;
  {$EXTERNALSYM D3DVSDE_TEXCOORD6}
  D3DVSDE_TEXCOORD7     = 14;
  {$EXTERNALSYM D3DVSDE_TEXCOORD7}
  D3DVSDE_POSITION2     = 15;
  {$EXTERNALSYM D3DVSDE_POSITION2}
  D3DVSDE_NORMAL2       = 16;
  {$EXTERNALSYM D3DVSDE_NORMAL2}

  // Maximum supported number of texture coordinate sets
  D3DDP_MAXTEXCOORD = 8;
  {$EXTERNALSYM D3DDP_MAXTEXCOORD}

  //
  // Instruction Token Bit Definitions
  //
  D3DSI_OPCODE_MASK       = $0000FFFF;
  {$EXTERNALSYM D3DSI_OPCODE_MASK}

type
  _D3DSHADER_INSTRUCTION_OPCODE_TYPE = type DWord;
  {$EXTERNALSYM _D3DSHADER_INSTRUCTION_OPCODE_TYPE}
  D3DSHADER_INSTRUCTION_OPCODE_TYPE = _D3DSHADER_INSTRUCTION_OPCODE_TYPE;
  {$EXTERNALSYM D3DSHADER_INSTRUCTION_OPCODE_TYPE}
  TD3DShaderInstructionOpcodeType = _D3DSHADER_INSTRUCTION_OPCODE_TYPE;

const
  D3DSIO_NOP          = 0;      // PS/VS
  {$EXTERNALSYM D3DSIO_NOP}
  D3DSIO_MOV          = 1;      // PS/VS
  {$EXTERNALSYM D3DSIO_MOV}
  D3DSIO_ADD          = 2;      // PS/VS
  {$EXTERNALSYM D3DSIO_ADD}
  D3DSIO_SUB          = 3;      // PS
  {$EXTERNALSYM D3DSIO_SUB}
  D3DSIO_MAD          = 4;      // PS/VS
  {$EXTERNALSYM D3DSIO_MAD}
  D3DSIO_MUL          = 5;      // PS/VS
  {$EXTERNALSYM D3DSIO_MUL}
  D3DSIO_RCP          = 6;      // VS
  {$EXTERNALSYM D3DSIO_RCP}
  D3DSIO_RSQ          = 7;      // VS
  {$EXTERNALSYM D3DSIO_RSQ}
  D3DSIO_DP3          = 8;      // PS/VS
  {$EXTERNALSYM D3DSIO_DP3}
  D3DSIO_DP4          = 9;      // PS/VS
  {$EXTERNALSYM D3DSIO_DP4}
  D3DSIO_MIN          = 10;     // VS
  {$EXTERNALSYM D3DSIO_MIN}
  D3DSIO_MAX          = 11;     // VS
  {$EXTERNALSYM D3DSIO_MAX}
  D3DSIO_SLT          = 12;     // VS
  {$EXTERNALSYM D3DSIO_SLT}
  D3DSIO_SGE          = 13;     // VS
  {$EXTERNALSYM D3DSIO_SGE}
  D3DSIO_EXP          = 14;     // VS
  {$EXTERNALSYM D3DSIO_EXP}
  D3DSIO_LOG          = 15;     // VS
  {$EXTERNALSYM D3DSIO_LOG}
  D3DSIO_LIT          = 16;     // VS
  {$EXTERNALSYM D3DSIO_LIT}
  D3DSIO_DST          = 17;     // VS
  {$EXTERNALSYM D3DSIO_DST}
  D3DSIO_LRP          = 18;     // PS
  {$EXTERNALSYM D3DSIO_LRP}
  D3DSIO_FRC          = 19;     // VS
  {$EXTERNALSYM D3DSIO_FRC}
  D3DSIO_M4x4         = 20;     // VS
  {$EXTERNALSYM D3DSIO_M4x4}
  D3DSIO_M4x3         = 21;     // VS
  {$EXTERNALSYM D3DSIO_M4x3}
  D3DSIO_M3x4         = 22;     // VS
  {$EXTERNALSYM D3DSIO_M3x4}
  D3DSIO_M3x3         = 23;     // VS
  {$EXTERNALSYM D3DSIO_M3x3}
  D3DSIO_M3x2         = 24;     // VS
  {$EXTERNALSYM D3DSIO_M3x2}

  D3DSIO_TEXCOORD     = 64;     // PS
  {$EXTERNALSYM D3DSIO_TEXCOORD}
  D3DSIO_TEXKILL      = 65;     // PS
  {$EXTERNALSYM D3DSIO_TEXKILL}
  D3DSIO_TEX          = 66;     // PS
  {$EXTERNALSYM D3DSIO_TEX}
  D3DSIO_TEXBEM       = 67;     // PS
  {$EXTERNALSYM D3DSIO_TEXBEM}
  D3DSIO_TEXBEML      = 68;     // PS
  {$EXTERNALSYM D3DSIO_TEXBEML}
  D3DSIO_TEXREG2AR    = 69;     // PS
  {$EXTERNALSYM D3DSIO_TEXREG2AR}
  D3DSIO_TEXREG2GB    = 70;     // PS
  {$EXTERNALSYM D3DSIO_TEXREG2GB}
  D3DSIO_TEXM3x2PAD   = 71;     // PS
  {$EXTERNALSYM D3DSIO_TEXM3x2PAD}
  D3DSIO_TEXM3x2TEX   = 72;     // PS
  {$EXTERNALSYM D3DSIO_TEXM3x2TEX}
  D3DSIO_TEXM3x3PAD   = 73;     // PS
  {$EXTERNALSYM D3DSIO_TEXM3x3PAD}
  D3DSIO_TEXM3x3TEX   = 74;     // PS
  {$EXTERNALSYM D3DSIO_TEXM3x3TEX}
  D3DSIO_TEXM3x3DIFF  = 75;     // PS
  {$EXTERNALSYM D3DSIO_TEXM3x3DIFF}
  D3DSIO_TEXM3x3SPEC  = 76;     // PS
  {$EXTERNALSYM D3DSIO_TEXM3x3SPEC}
  D3DSIO_TEXM3x3VSPEC = 77;     // PS
  {$EXTERNALSYM D3DSIO_TEXM3x3VSPEC}
  D3DSIO_EXPP         = 78;     // VS
  {$EXTERNALSYM D3DSIO_EXPP}
  D3DSIO_LOGP         = 79;     // VS
  {$EXTERNALSYM D3DSIO_LOGP}
  D3DSIO_CND          = 80;     // PS
  {$EXTERNALSYM D3DSIO_CND}
  D3DSIO_DEF          = 81;     // PS
  {$EXTERNALSYM D3DSIO_DEF}
  D3DSIO_TEXREG2RGB   = 82;     // PS
  {$EXTERNALSYM D3DSIO_TEXREG2RGB}
  D3DSIO_TEXDP3TEX    = 83;     // PS
  {$EXTERNALSYM D3DSIO_TEXDP3TEX}
  D3DSIO_TEXM3x2DEPTH = 84;     // PS
  {$EXTERNALSYM D3DSIO_TEXM3x2DEPTH}
  D3DSIO_TEXDP3       = 85;     // PS
  {$EXTERNALSYM D3DSIO_TEXDP3}
  D3DSIO_TEXM3x3      = 86;     // PS
  {$EXTERNALSYM D3DSIO_TEXM3x3}
  D3DSIO_TEXDEPTH     = 87;     // PS
  {$EXTERNALSYM D3DSIO_TEXDEPTH}
  D3DSIO_CMP          = 88;     // PS
  {$EXTERNALSYM D3DSIO_CMP}
  D3DSIO_BEM          = 89;     // PS
  {$EXTERNALSYM D3DSIO_BEM}

  D3DSIO_PHASE        = $FFFD;
  {$EXTERNALSYM D3DSIO_PHASE}
  D3DSIO_COMMENT      = $FFFE;
  {$EXTERNALSYM D3DSIO_COMMENT}
  D3DSIO_END          = $FFFF;
  {$EXTERNALSYM D3DSIO_END}

  //
  // Co-Issue Instruction Modifier - if set then this instruction is to be
  // issued in parallel with the previous instruction(s) for which this bit
  // is not set.
  //
  D3DSI_COISSUE           = $40000000;
  {$EXTERNALSYM D3DSI_COISSUE}

  //
  // Parameter Token Bit Definitions
  //
  D3DSP_REGNUM_MASK       = $00001FFF;
  {$EXTERNALSYM D3DSP_REGNUM_MASK}

  // destination parameter write mask
  D3DSP_WRITEMASK_0       = $00010000;  // Component 0 (X;Red)
  {$EXTERNALSYM D3DSP_WRITEMASK_0}
  D3DSP_WRITEMASK_1       = $00020000;  // Component 1 (Y;Green)
  {$EXTERNALSYM D3DSP_WRITEMASK_1}
  D3DSP_WRITEMASK_2       = $00040000;  // Component 2 (Z;Blue)
  {$EXTERNALSYM D3DSP_WRITEMASK_2}
  D3DSP_WRITEMASK_3       = $00080000;  // Component 3 (W;Alpha)
  {$EXTERNALSYM D3DSP_WRITEMASK_3}
  D3DSP_WRITEMASK_ALL     = $000F0000;  // All Components
  {$EXTERNALSYM D3DSP_WRITEMASK_ALL}

  // destination parameter modifiers
  D3DSP_DSTMOD_SHIFT      = 20;
  {$EXTERNALSYM D3DSP_DSTMOD_SHIFT}
  D3DSP_DSTMOD_MASK       = $00F00000;
  {$EXTERNALSYM D3DSP_DSTMOD_MASK}

type
  _D3DSHADER_PARAM_DSTMOD_TYPE = type DWord;
  {$EXTERNALSYM _D3DSHADER_PARAM_DSTMOD_TYPE}
  D3DSHADER_PARAM_DSTMOD_TYPE = _D3DSHADER_PARAM_DSTMOD_TYPE;
  {$EXTERNALSYM D3DSHADER_PARAM_DSTMOD_TYPE}
  TD3DShaderParamDSTModType = _D3DSHADER_PARAM_DSTMOD_TYPE;

const
  D3DSPDM_NONE        = 0 shl D3DSP_DSTMOD_SHIFT; // nop
  {$EXTERNALSYM D3DSPDM_NONE}
  D3DSPDM_SATURATE    = 1 shl D3DSP_DSTMOD_SHIFT; // clamp to 0. to 1. range
  {$EXTERNALSYM D3DSPDM_SATURATE}
  D3DSPDM_FORCE_DWORD = $7fffffff;                // force 32-bit size enum
  {$EXTERNALSYM D3DSPDM_FORCE_DWORD}

  // destination parameter
  D3DSP_DSTSHIFT_SHIFT    = 24;
  {$EXTERNALSYM D3DSP_DSTSHIFT_SHIFT}
  D3DSP_DSTSHIFT_MASK     = $0F000000;
  {$EXTERNALSYM D3DSP_DSTSHIFT_MASK}

  // destination/source parameter register type
  D3DSP_REGTYPE_SHIFT     = 28;
  {$EXTERNALSYM D3DSP_REGTYPE_SHIFT}
  D3DSP_REGTYPE_MASK      = $70000000;
  {$EXTERNALSYM D3DSP_REGTYPE_MASK}

type
  _D3DSHADER_PARAM_REGISTER_TYPE = type DWord;
  {$EXTERNALSYM _D3DSHADER_PARAM_REGISTER_TYPE}
  D3DSHADER_PARAM_REGISTER_TYPE = _D3DSHADER_PARAM_REGISTER_TYPE;
  {$EXTERNALSYM D3DSHADER_PARAM_REGISTER_TYPE}
  TD3DShaderParamRegisterType = _D3DSHADER_PARAM_REGISTER_TYPE;

const
  D3DSPR_TEMP        = 0 shl D3DSP_REGTYPE_SHIFT; // Temporary Register File
  {$EXTERNALSYM D3DSPR_TEMP}
  D3DSPR_INPUT       = 1 shl D3DSP_REGTYPE_SHIFT; // Input Register File
  {$EXTERNALSYM D3DSPR_INPUT}
  D3DSPR_CONST       = 2 shl D3DSP_REGTYPE_SHIFT; // Constant Register File
  {$EXTERNALSYM D3DSPR_CONST}
  D3DSPR_ADDR        = 3 shl D3DSP_REGTYPE_SHIFT; // Address Register (VS)
  {$EXTERNALSYM D3DSPR_ADDR}
  D3DSPR_TEXTURE     = 3 shl D3DSP_REGTYPE_SHIFT; // Texture Register File (PS)
  {$EXTERNALSYM D3DSPR_TEXTURE}
  D3DSPR_RASTOUT     = 4 shl D3DSP_REGTYPE_SHIFT; // Rasterizer Register File
  {$EXTERNALSYM D3DSPR_RASTOUT}
  D3DSPR_ATTROUT     = 5 shl D3DSP_REGTYPE_SHIFT; // Attribute Output Register File
  {$EXTERNALSYM D3DSPR_ATTROUT}
  D3DSPR_TEXCRDOUT   = 6 shl D3DSP_REGTYPE_SHIFT; // Texture Coordinate Output Register File
  {$EXTERNALSYM D3DSPR_TEXCRDOUT}
  D3DSPR_FORCE_DWORD = $7fffffff;                 // force 32-bit size enum
  {$EXTERNALSYM D3DSPR_FORCE_DWORD}


type
  // Register offsets in the Rasterizer Register File
  //
  _D3DVS_RASTOUT_OFFSETS = (
    D3DSRO_POSITION {= 0},
    D3DSRO_FOG,
    D3DSRO_POINT_SIZE
  );
  {$EXTERNALSYM _D3DVS_RASTOUT_OFFSETS}
  D3DVS_RASTOUT_OFFSETS = _D3DVS_RASTOUT_OFFSETS;
  {$EXTERNALSYM D3DVS_RASTOUT_OFFSETS}
  TD3DVSRastOutOffsets = _D3DVS_RASTOUT_OFFSETS;

// Source operand addressing modes

const
  D3DVS_ADDRESSMODE_SHIFT = 13;
  {$EXTERNALSYM D3DVS_ADDRESSMODE_SHIFT}
  D3DVS_ADDRESSMODE_MASK  = 1 shl D3DVS_ADDRESSMODE_SHIFT;
  {$EXTERNALSYM D3DVS_ADDRESSMODE_MASK}

type
  _D3DVS_ADDRESSMODE_TYPE = type DWord;
  {$EXTERNALSYM _D3DVS_ADDRESSMODE_TYPE}
  D3DVS_ADDRESSMODE_TYPE = _D3DVS_ADDRESSMODE_TYPE;
  {$EXTERNALSYM D3DVS_ADDRESSMODE_TYPE}
  TD3DVSAddressModeType = _D3DVS_ADDRESSMODE_TYPE;

const
  D3DVS_ADDRMODE_ABSOLUTE    = 0 shl D3DVS_ADDRESSMODE_SHIFT;
  {$EXTERNALSYM D3DVS_ADDRMODE_ABSOLUTE}
  D3DVS_ADDRMODE_RELATIVE    = 1 shl D3DVS_ADDRESSMODE_SHIFT;  // Relative to register A0
  {$EXTERNALSYM D3DVS_ADDRMODE_RELATIVE}
  D3DVS_ADDRMODE_FORCE_DWORD = $7fffffff;                      // force 32-bit size enum
  {$EXTERNALSYM D3DVS_ADDRMODE_FORCE_DWORD}

  // Source operand swizzle definitions
  //
  D3DVS_SWIZZLE_SHIFT     = 16;
  {$EXTERNALSYM D3DVS_SWIZZLE_SHIFT}
  D3DVS_SWIZZLE_MASK      = $00FF0000;
  {$EXTERNALSYM D3DVS_SWIZZLE_MASK}

  // The following bits define where to take component X from:

  D3DVS_X_X = 0 shl D3DVS_SWIZZLE_SHIFT;
  {$EXTERNALSYM D3DVS_X_X}
  D3DVS_X_Y = 1 shl D3DVS_SWIZZLE_SHIFT;
  {$EXTERNALSYM D3DVS_X_Y}
  D3DVS_X_Z = 2 shl D3DVS_SWIZZLE_SHIFT;
  {$EXTERNALSYM D3DVS_X_Z}
  D3DVS_X_W = 3 shl D3DVS_SWIZZLE_SHIFT;
  {$EXTERNALSYM D3DVS_X_W}

  // The following bits define where to take component Y from:

  D3DVS_Y_X = 0 shl (D3DVS_SWIZZLE_SHIFT + 2);
  {$EXTERNALSYM D3DVS_Y_X}
  D3DVS_Y_Y = 1 shl (D3DVS_SWIZZLE_SHIFT + 2);
  {$EXTERNALSYM D3DVS_Y_Y}
  D3DVS_Y_Z = 2 shl (D3DVS_SWIZZLE_SHIFT + 2);
  {$EXTERNALSYM D3DVS_Y_Z}
  D3DVS_Y_W = 3 shl (D3DVS_SWIZZLE_SHIFT + 2);
  {$EXTERNALSYM D3DVS_Y_W}

  // The following bits define where to take component Z from:

  D3DVS_Z_X = 0 shl (D3DVS_SWIZZLE_SHIFT + 4);
  {$EXTERNALSYM D3DVS_Z_X}
  D3DVS_Z_Y = 1 shl (D3DVS_SWIZZLE_SHIFT + 4);
  {$EXTERNALSYM D3DVS_Z_Y}
  D3DVS_Z_Z = 2 shl (D3DVS_SWIZZLE_SHIFT + 4);
  {$EXTERNALSYM D3DVS_Z_Z}
  D3DVS_Z_W = 3 shl (D3DVS_SWIZZLE_SHIFT + 4);
  {$EXTERNALSYM D3DVS_Z_W}

  // The following bits define where to take component W from:

  D3DVS_W_X = 0 shl (D3DVS_SWIZZLE_SHIFT + 6);
  {$EXTERNALSYM D3DVS_W_X}
  D3DVS_W_Y = 1 shl (D3DVS_SWIZZLE_SHIFT + 6);
  {$EXTERNALSYM D3DVS_W_Y}
  D3DVS_W_Z = 2 shl (D3DVS_SWIZZLE_SHIFT + 6);
  {$EXTERNALSYM D3DVS_W_Z}
  D3DVS_W_W = 3 shl (D3DVS_SWIZZLE_SHIFT + 6);
  {$EXTERNALSYM D3DVS_W_W}

  // Value when there is no swizzle (X is taken from X, Y is taken from Y,
  // Z is taken from Z, W is taken from W
  //
  D3DVS_NOSWIZZLE = D3DVS_X_X or D3DVS_Y_Y or D3DVS_Z_Z or D3DVS_W_W;
  {$EXTERNALSYM D3DVS_NOSWIZZLE}

  // source parameter swizzle
  D3DSP_SWIZZLE_SHIFT = 16;
  {$EXTERNALSYM D3DSP_SWIZZLE_SHIFT}
  D3DSP_SWIZZLE_MASK  = $00FF0000;
  {$EXTERNALSYM D3DSP_SWIZZLE_MASK}

  D3DSP_NOSWIZZLE =
    (0 shl (D3DSP_SWIZZLE_SHIFT + 0)) or
    (1 shl (D3DSP_SWIZZLE_SHIFT + 2)) or
    (2 shl (D3DSP_SWIZZLE_SHIFT + 4)) or
    (3 shl (D3DSP_SWIZZLE_SHIFT + 6));
  {$EXTERNALSYM D3DSP_NOSWIZZLE}

  // pixel-shader swizzle ops
  D3DSP_REPLICATERED =
    (0 shl (D3DSP_SWIZZLE_SHIFT + 0)) or
    (0 shl (D3DSP_SWIZZLE_SHIFT + 2)) or
    (0 shl (D3DSP_SWIZZLE_SHIFT + 4)) or
    (0 shl (D3DSP_SWIZZLE_SHIFT + 6));
  {$EXTERNALSYM D3DSP_REPLICATERED}

  D3DSP_REPLICATEGREEN =
    (1 shl (D3DSP_SWIZZLE_SHIFT + 0)) or
    (1 shl (D3DSP_SWIZZLE_SHIFT + 2)) or
    (1 shl (D3DSP_SWIZZLE_SHIFT + 4)) or
    (1 shl (D3DSP_SWIZZLE_SHIFT + 6));
  {$EXTERNALSYM D3DSP_REPLICATEGREEN}

  D3DSP_REPLICATEBLUE =
    (2 shl (D3DSP_SWIZZLE_SHIFT + 0)) or
    (2 shl (D3DSP_SWIZZLE_SHIFT + 2)) or
    (2 shl (D3DSP_SWIZZLE_SHIFT + 4)) or
    (2 shl (D3DSP_SWIZZLE_SHIFT + 6));
  {$EXTERNALSYM D3DSP_REPLICATEBLUE}

  D3DSP_REPLICATEALPHA =
    (3 shl (D3DSP_SWIZZLE_SHIFT + 0)) or
    (3 shl (D3DSP_SWIZZLE_SHIFT + 2)) or
    (3 shl (D3DSP_SWIZZLE_SHIFT + 4)) or
    (3 shl (D3DSP_SWIZZLE_SHIFT + 6));
  {$EXTERNALSYM D3DSP_REPLICATEALPHA}

  // source parameter modifiers
  D3DSP_SRCMOD_SHIFT      = 24;
  {$EXTERNALSYM D3DSP_SRCMOD_SHIFT}
  D3DSP_SRCMOD_MASK       = $0F000000;
  {$EXTERNALSYM D3DSP_SRCMOD_MASK}

type
  _D3DSHADER_PARAM_SRCMOD_TYPE = type DWord;
  {$EXTERNALSYM _D3DSHADER_PARAM_SRCMOD_TYPE}
  D3DSHADER_PARAM_SRCMOD_TYPE = _D3DSHADER_PARAM_SRCMOD_TYPE;
  {$EXTERNALSYM D3DSHADER_PARAM_SRCMOD_TYPE}
  TD3DShaderParamSRCModType = _D3DSHADER_PARAM_SRCMOD_TYPE;

const
  D3DSPSM_NONE        = 0 shl D3DSP_SRCMOD_SHIFT; // nop
  {$EXTERNALSYM D3DSPSM_NONE}
  D3DSPSM_NEG         = 1 shl D3DSP_SRCMOD_SHIFT; // negate
  {$EXTERNALSYM D3DSPSM_NEG}
  D3DSPSM_BIAS        = 2 shl D3DSP_SRCMOD_SHIFT; // bias
  {$EXTERNALSYM D3DSPSM_BIAS}
  D3DSPSM_BIASNEG     = 3 shl D3DSP_SRCMOD_SHIFT; // bias and negate
  {$EXTERNALSYM D3DSPSM_BIASNEG}
  D3DSPSM_SIGN        = 4 shl D3DSP_SRCMOD_SHIFT; // sign
  {$EXTERNALSYM D3DSPSM_SIGN}
  D3DSPSM_SIGNNEG     = 5 shl D3DSP_SRCMOD_SHIFT; // sign and negate
  {$EXTERNALSYM D3DSPSM_SIGNNEG}
  D3DSPSM_COMP        = 6 shl D3DSP_SRCMOD_SHIFT; // complement
  {$EXTERNALSYM D3DSPSM_COMP}
  D3DSPSM_X2          = 7 shl D3DSP_SRCMOD_SHIFT; // *2
  {$EXTERNALSYM D3DSPSM_X2}
  D3DSPSM_X2NEG       = 8 shl D3DSP_SRCMOD_SHIFT; // *2 and negate
  {$EXTERNALSYM D3DSPSM_X2NEG}
  D3DSPSM_DZ          = 9 shl D3DSP_SRCMOD_SHIFT; // divide through by z component
  {$EXTERNALSYM D3DSPSM_DZ}
  D3DSPSM_DW          = 10 shl D3DSP_SRCMOD_SHIFT; // divide through by w component
  {$EXTERNALSYM D3DSPSM_DW}
  D3DSPSM_FORCE_DWORD = $7fffffff;                // force 32-bit size enum
  {$EXTERNALSYM D3DSPSM_FORCE_DWORD}

// pixel shader version token
//#define D3DPS_VERSION(_Major,_Minor) (0xFFFF0000|((_Major)<<8)|(_Minor))
function D3DPS_VERSION(_Major, _Minor: DWord): DWord;
{$EXTERNALSYM D3DPS_VERSION}

// vertex shader version token
//#define D3DVS_VERSION(_Major,_Minor) (0xFFFE0000|((_Major)<<8)|(_Minor))
function D3DVS_VERSION(_Major, _Minor: DWord): DWord;
{$EXTERNALSYM D3DVS_VERSION}

// extract major/minor from version cap
//#define D3DSHADER_VERSION_MAJOR(_Version) (((_Version)>>8)&0xFF)
function D3DSHADER_VERSION_MAJOR(_Version: DWord): DWord;
{$EXTERNALSYM D3DSHADER_VERSION_MAJOR}
//#define D3DSHADER_VERSION_MINOR(_Version) (((_Version)>>0)&0xFF)
function D3DSHADER_VERSION_MINOR(_Version: DWord): DWord;
{$EXTERNALSYM D3DSHADER_VERSION_MINOR}

const
  // destination/source parameter register type
  D3DSI_COMMENTSIZE_SHIFT = 16;
  {$EXTERNALSYM D3DSI_COMMENTSIZE_SHIFT}
  D3DSI_COMMENTSIZE_MASK  = $7FFF0000;
  {$EXTERNALSYM D3DSI_COMMENTSIZE_MASK}

//#define D3DSHADER_COMMENT(_DWordSize) \
//    ((((_DWordSize)<<D3DSI_COMMENTSIZE_SHIFT)&D3DSI_COMMENTSIZE_MASK)|D3DSIO_COMMENT)
function D3DSHADER_COMMENT(_DWordSize: DWord) : DWord;
{$EXTERNALSYM D3DSHADER_COMMENT}

const
  // pixel/vertex shader end token
  D3DPS_END  = $0000FFFF;
  {$EXTERNALSYM D3DPS_END}
  D3DVS_END  = $0000FFFF;
  {$EXTERNALSYM D3DVS_END}

//---------------------------------------------------------------------

type
  // High order surfaces
  //
  _D3DBASISTYPE = (
    D3DBASIS_BEZIER      {= 0},
    D3DBASIS_BSPLINE     {= 1},
    D3DBASIS_INTERPOLATE {= 2}
  );
  {$EXTERNALSYM _D3DBASISTYPE}
  D3DBASISTYPE = _D3DBASISTYPE;
  {$EXTERNALSYM D3DBASISTYPE}
  TD3DBasisType = _D3DBASISTYPE;

  _D3DORDERTYPE = (
    D3DORDER_LINEAR      = 1,
    D3DORDER_QUADRATIC   = 2,
    D3DORDER_CUBIC       = 3,
    D3DORDER_QUINTIC     = 5
  );
  {$EXTERNALSYM _D3DORDERTYPE}
  D3DORDERTYPE = _D3DORDERTYPE;
  {$EXTERNALSYM D3DORDERTYPE}
  TD3DOrderType = _D3DORDERTYPE;

  _D3DPATCHEDGESTYLE = (
    D3DPATCHEDGE_DISCRETE   {= 0},
    D3DPATCHEDGE_CONTINUOUS {= 1}
  );
  {$EXTERNALSYM _D3DPATCHEDGESTYLE}
  D3DPATCHEDGESTYLE = _D3DPATCHEDGESTYLE;
  {$EXTERNALSYM D3DPATCHEDGESTYLE}
  TD3DPatchEdgeStyle = _D3DPATCHEDGESTYLE;

  _D3DSTATEBLOCKTYPE = (
    D3DSBT_ALL          = 1, // capture all state
    D3DSBT_PIXELSTATE   = 2, // capture pixel state
    D3DSBT_VERTEXSTATE  = 3  // capture vertex state
  );
  {$EXTERNALSYM _D3DSTATEBLOCKTYPE}
  D3DSTATEBLOCKTYPE = _D3DSTATEBLOCKTYPE;
  {$EXTERNALSYM D3DSTATEBLOCKTYPE}
  TD3DStateBlockType = _D3DSTATEBLOCKTYPE;

type
  // The D3DVERTEXBLENDFLAGS type is used with D3DRS_VERTEXBLEND state.
  //
  _D3DVERTEXBLENDFLAGS = type DWord;
  {$EXTERNALSYM _D3DVERTEXBLENDFLAGS}
  D3DVERTEXBLENDFLAGS = _D3DVERTEXBLENDFLAGS;
  {$EXTERNALSYM D3DVERTEXBLENDFLAGS}
  TD3DVertexBlendFlags = _D3DVERTEXBLENDFLAGS;

const
  D3DVBF_DISABLE  = 0;            // Disable vertex blending
  {$EXTERNALSYM D3DVBF_DISABLE}
  D3DVBF_1WEIGHTS = 1;            // 2 matrix blending
  {$EXTERNALSYM D3DVBF_1WEIGHTS}
  D3DVBF_2WEIGHTS = 2;            // 3 matrix blending
  {$EXTERNALSYM D3DVBF_2WEIGHTS}
  D3DVBF_3WEIGHTS = 3;            // 4 matrix blending
  {$EXTERNALSYM D3DVBF_3WEIGHTS}
  D3DVBF_TWEENING = 255;          // blending using D3DRS_TWEENFACTOR
  {$EXTERNALSYM D3DVBF_TWEENING}
  D3DVBF_0WEIGHTS = 256;          // one matrix is used with weight 1.0
  {$EXTERNALSYM D3DVBF_0WEIGHTS}
  D3DVBF_FORCE_DWORD = $7fffffff; // force 32-bit size enum
  {$EXTERNALSYM D3DVBF_FORCE_DWORD}

type
  _D3DTEXTURETRANSFORMFLAGS = type DWord;
  {$EXTERNALSYM _D3DTEXTURETRANSFORMFLAGS}
  D3DTEXTURETRANSFORMFLAGS = _D3DTEXTURETRANSFORMFLAGS;
  {$EXTERNALSYM D3DTEXTURETRANSFORMFLAGS}
  TD3DTextureTransformFlags = _D3DTEXTURETRANSFORMFLAGS;

const
  D3DTTFF_DISABLE         = 0;    // texture coordinates are passed directly
  {$EXTERNALSYM D3DTTFF_DISABLE}
  D3DTTFF_COUNT1          = 1;    // rasterizer should expect 1-D texture coords
  {$EXTERNALSYM D3DTTFF_COUNT1}
  D3DTTFF_COUNT2          = 2;    // rasterizer should expect 2-D texture coords
  {$EXTERNALSYM D3DTTFF_COUNT2}
  D3DTTFF_COUNT3          = 3;    // rasterizer should expect 3-D texture coords
  {$EXTERNALSYM D3DTTFF_COUNT3}
  D3DTTFF_COUNT4          = 4;    // rasterizer should expect 4-D texture coords
  {$EXTERNALSYM D3DTTFF_COUNT4}
  D3DTTFF_PROJECTED       = 256;  // texcoords to be divided by COUNTth element
  {$EXTERNALSYM D3DTTFF_PROJECTED}
  D3DTTFF_FORCE_DWORD     = $7fffffff;
  {$EXTERNALSYM D3DTTFF_FORCE_DWORD}

const
  // Macros to set texture coordinate format bits in the FVF id

  D3DFVF_TEXTUREFORMAT2 = 0;         // Two floating point values
  {$EXTERNALSYM D3DFVF_TEXTUREFORMAT2}
  D3DFVF_TEXTUREFORMAT1 = 3;         // One floating point value
  {$EXTERNALSYM D3DFVF_TEXTUREFORMAT1}
  D3DFVF_TEXTUREFORMAT3 = 1;         // Three floating point values
  {$EXTERNALSYM D3DFVF_TEXTUREFORMAT3}
  D3DFVF_TEXTUREFORMAT4 = 2;         // Four floating point values
  {$EXTERNALSYM D3DFVF_TEXTUREFORMAT4}

//#define D3DFVF_TEXCOORDSIZE3(CoordIndex) (D3DFVF_TEXTUREFORMAT3 << (CoordIndex*2 + 16))
function D3DFVF_TEXCOORDSIZE3(CoordIndex: DWord): DWord;
{$EXTERNALSYM D3DFVF_TEXCOORDSIZE3}
//#define D3DFVF_TEXCOORDSIZE2(CoordIndex) (D3DFVF_TEXTUREFORMAT2)
function D3DFVF_TEXCOORDSIZE2(CoordIndex: DWord): DWord;
{$EXTERNALSYM D3DFVF_TEXCOORDSIZE2}
//#define D3DFVF_TEXCOORDSIZE4(CoordIndex) (D3DFVF_TEXTUREFORMAT4 << (CoordIndex*2 + 16))
function D3DFVF_TEXCOORDSIZE4(CoordIndex: DWord): DWord;
{$EXTERNALSYM D3DFVF_TEXCOORDSIZE4}
//#define D3DFVF_TEXCOORDSIZE1(CoordIndex) (D3DFVF_TEXTUREFORMAT1 << (CoordIndex*2 + 16))
function D3DFVF_TEXCOORDSIZE1(CoordIndex: DWord): DWord;
{$EXTERNALSYM D3DFVF_TEXCOORDSIZE1}


//---------------------------------------------------------------------

type
  { Direct3D8 Device types }
  _D3DDEVTYPE = (
    D3DDEVTYPE_HAL         = 1,
    D3DDEVTYPE_REF         = 2,
    D3DDEVTYPE_SW          = 3
  );
  {$EXTERNALSYM _D3DDEVTYPE}
  D3DDEVTYPE = _D3DDEVTYPE;
  {$EXTERNALSYM D3DDEVTYPE}
  TD3DDevType = _D3DDEVTYPE;

  { Multi-Sample buffer types }
  _D3DMULTISAMPLE_TYPE = (
    D3DMULTISAMPLE_NONE            =  0,
    D3DMULTISAMPLE_2_SAMPLES       =  2,
    D3DMULTISAMPLE_3_SAMPLES       =  3,
    D3DMULTISAMPLE_4_SAMPLES       =  4,
    D3DMULTISAMPLE_5_SAMPLES       =  5,
    D3DMULTISAMPLE_6_SAMPLES       =  6,
    D3DMULTISAMPLE_7_SAMPLES       =  7,
    D3DMULTISAMPLE_8_SAMPLES       =  8,
    D3DMULTISAMPLE_9_SAMPLES       =  9,
    D3DMULTISAMPLE_10_SAMPLES      = 10,
    D3DMULTISAMPLE_11_SAMPLES      = 11,
    D3DMULTISAMPLE_12_SAMPLES      = 12,
    D3DMULTISAMPLE_13_SAMPLES      = 13,
    D3DMULTISAMPLE_14_SAMPLES      = 14,
    D3DMULTISAMPLE_15_SAMPLES      = 15,
    D3DMULTISAMPLE_16_SAMPLES      = 16
  );
  {$EXTERNALSYM _D3DMULTISAMPLE_TYPE}
  D3DMULTISAMPLE_TYPE = _D3DMULTISAMPLE_TYPE;
  {$EXTERNALSYM D3DMULTISAMPLE_TYPE}
  TD3DMultiSampleType = _D3DMULTISAMPLE_TYPE;

(* Formats
 * Most of these names have the following convention:
 *      A = Alpha
 *      R = Red
 *      G = Green
 *      B = Blue
 *      X = Unused Bits
 *      P = Palette
 *      L = Luminance
 *      U = dU coordinate for BumpMap
 *      V = dV coordinate for BumpMap
 *      S = Stencil
 *      D = Depth (e.g. Z or W buffer)
 *
 *      Further, the order of the pieces are from MSB first; hence
 *      D3DFMT_A8L8 indicates that the high byte of this two byte
 *      format is alpha.
 *
 *      D16 indicates:
 *           - An integer 16-bit value.
 *           - An app-lockable surface.
 *
 *      All Depth/Stencil formats except D3DFMT_D16_LOCKABLE indicate:
 *          - no particular bit ordering per pixel, and
 *          - are not app lockable, and
 *          - the driver is allowed to consume more than the indicated
 *            number of bits per Depth channel (but not Stencil channel).
 *)
//    #define MAKEFOURCC(ch0, ch1, ch2, ch3)                              \
//                ((DWORD)(BYTE)(ch0) | ((DWORD)(BYTE)(ch1) << 8) |       \
//                ((DWORD)(BYTE)(ch2) << 16) | ((DWORD)(BYTE)(ch3) << 24 ))
function MAKEFOURCC(ch0, ch1, ch2, ch3: Char): DWord;
{$EXTERNALSYM MAKEFOURCC}


type
  _D3DFORMAT = (
    D3DFMT_UNKNOWN              =  0,

    D3DFMT_R8G8B8               = 20,
    D3DFMT_A8R8G8B8             = 21,
    D3DFMT_X8R8G8B8             = 22,
    D3DFMT_R5G6B5               = 23,
    D3DFMT_X1R5G5B5             = 24,
    D3DFMT_A1R5G5B5             = 25,
    D3DFMT_A4R4G4B4             = 26,
    D3DFMT_R3G3B2               = 27,
    D3DFMT_A8                   = 28,
    D3DFMT_A8R3G3B2             = 29,
    D3DFMT_X4R4G4B4             = 30,
    D3DFMT_A2B10G10R10          = 31,
    D3DFMT_G16R16               = 34,

    D3DFMT_A8P8                 = 40,
    D3DFMT_P8                   = 41,

    D3DFMT_L8                   = 50,
    D3DFMT_A8L8                 = 51,
    D3DFMT_A4L4                 = 52,

    D3DFMT_V8U8                 = 60,
    D3DFMT_L6V5U5               = 61,
    D3DFMT_X8L8V8U8             = 62,
    D3DFMT_Q8W8V8U8             = 63,
    D3DFMT_V16U16               = 64,
    D3DFMT_W11V11U10            = 65,
    D3DFMT_A2W10V10U10          = 67,

    // D3DFMT_UYVY                 = MAKEFOURCC('U', 'Y', 'V', 'Y'),
    D3DFMT_UYVY                 = Byte('U') or (Byte('Y') shl 8) or (Byte('V') shl 16) or (Byte('Y') shl 24),
    // D3DFMT_YUY2                 = MAKEFOURCC('Y', 'U', 'Y', '2'),
    D3DFMT_YUY2                 = Byte('Y') or (Byte('U') shl 8) or (Byte('Y') shl 16) or (Byte('2') shl 24),
    // D3DFMT_DXT1                 = MAKEFOURCC('D', 'X', 'T', '1'),
    D3DFMT_DXT1                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('1') shl 24),
    // D3DFMT_DXT2                 = MAKEFOURCC('D', 'X', 'T', '2'),
    D3DFMT_DXT2                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('2') shl 24),
    // D3DFMT_DXT3                 = MAKEFOURCC('D', 'X', 'T', '3'),
    D3DFMT_DXT3                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('3') shl 24),
    // D3DFMT_DXT4                 = MAKEFOURCC('D', 'X', 'T', '4'),
    D3DFMT_DXT4                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('4') shl 24),
    // D3DFMT_DXT5                 = MAKEFOURCC('D', 'X', 'T', '5'),
    D3DFMT_DXT5                 = Byte('D') or (Byte('X') shl 8) or (Byte('T') shl 16) or (Byte('5') shl 24),

    D3DFMT_D16_LOCKABLE         = 70,
    D3DFMT_D32                  = 71,
    D3DFMT_D15S1                = 73,
    D3DFMT_D24S8                = 75,
    D3DFMT_D16                  = 80,
    D3DFMT_D24X8                = 77,
    D3DFMT_D24X4S4              = 79,


    D3DFMT_VERTEXDATA           =100,
    D3DFMT_INDEX16              =101,
    D3DFMT_INDEX32              =102,

    D3DFMT_FORCE_DWORD          = $7fffffff
  );
  {$EXTERNALSYM _D3DFORMAT}
  D3DFORMAT = _D3DFORMAT;
  {$EXTERNALSYM D3DFORMAT}
  PD3DFormat = ^TD3DFormat;
  TD3DFormat = _D3DFORMAT;

  { Display Modes }
  PD3DDisplayMode = ^TD3DDisplayMode;
  _D3DDISPLAYMODE = packed record
    Width: LongWord;
    Height: LongWord;
    RefreshRate: LongWord;
    Format: TD3DFormat;
  end {_D3DDISPLAYMODE};
  {$EXTERNALSYM _D3DDISPLAYMODE}
  D3DDISPLAYMODE = _D3DDISPLAYMODE;
  {$EXTERNALSYM D3DDISPLAYMODE}
  TD3DDisplayMode = _D3DDISPLAYMODE;

  { Creation Parameters }
  PD3DDeviceCreationParameters = ^TD3DDeviceCreationParameters;
  _D3DDEVICE_CREATION_PARAMETERS = packed record
    AdapterOrdinal: LongWord;
    DeviceType: TD3DDevType;
    hFocusWindow: HWND;
    BehaviorFlags: LongInt;
  end {_D3DDEVICE_CREATION_PARAMETERS};
  {$EXTERNALSYM _D3DDEVICE_CREATION_PARAMETERS}
  D3DDEVICE_CREATION_PARAMETERS = _D3DDEVICE_CREATION_PARAMETERS;
  {$EXTERNALSYM D3DDEVICE_CREATION_PARAMETERS}
  TD3DDeviceCreationParameters = _D3DDEVICE_CREATION_PARAMETERS;


  { SwapEffects }
  _D3DSWAPEFFECT = (
    D3DSWAPEFFECT_DISCARD       = 1,
    D3DSWAPEFFECT_FLIP          = 2,
    D3DSWAPEFFECT_COPY          = 3,
    D3DSWAPEFFECT_COPY_VSYNC    = 4
  );
  {$EXTERNALSYM _D3DSWAPEFFECT}
  D3DSWAPEFFECT = _D3DSWAPEFFECT;
  {$EXTERNALSYM D3DSWAPEFFECT}
  TD3DSwapEffect = _D3DSWAPEFFECT;

  { Pool types }
  _D3DPOOL = (
    D3DPOOL_DEFAULT     {= 0},
    D3DPOOL_MANAGED     {= 1},
    D3DPOOL_SYSTEMMEM   {= 2},
    D3DPOOL_SCRATCH     {= 3}
  );
  {$EXTERNALSYM _D3DPOOL}
  D3DPOOL = _D3DPOOL;
  {$EXTERNALSYM D3DPOOL}
  TD3DPool = _D3DPOOL;


const
  { RefreshRate pre-defines }
  D3DPRESENT_RATE_DEFAULT         = $00000000;
  {$EXTERNALSYM D3DPRESENT_RATE_DEFAULT}
  D3DPRESENT_RATE_UNLIMITED       = $7fffffff;
  {$EXTERNALSYM D3DPRESENT_RATE_UNLIMITED}

type
  { Resize Optional Parameters }
  PD3DPresentParameters = ^TD3DPresentParameters;
  _D3DPRESENT_PARAMETERS_ = packed record
    BackBufferWidth:                    LongWord;
    BackBufferHeight:                   LongWord;
    BackBufferFormat:                   TD3DFormat;
    BackBufferCount:                    LongWord;

    MultiSampleType:                    TD3DMultiSampleType;

    SwapEffect:                         TD3DSwapEffect;
    hDeviceWindow:                      HWND;
    Windowed:                           Bool;
    EnableAutoDepthStencil:             Bool;
    AutoDepthStencilFormat:             TD3DFormat;
    Flags: LongInt;

    { Following elements must be zero for Windowed mode }
    FullScreen_RefreshRateInHz:         LongWord;
    FullScreen_PresentationInterval:    LongWord;
  end {_D3DPRESENT_PARAMETERS_};
  {$EXTERNALSYM _D3DPRESENT_PARAMETERS_}
  D3DPRESENT_PARAMETERS = _D3DPRESENT_PARAMETERS_;
  {$EXTERNALSYM D3DPRESENT_PARAMETERS}
  TD3DPresentParameters = _D3DPRESENT_PARAMETERS_;

  // Values for D3DPRESENT_PARAMETERS.Flags

const
  D3DPRESENTFLAG_LOCKABLE_BACKBUFFER  = $00000001;
  {$EXTERNALSYM D3DPRESENTFLAG_LOCKABLE_BACKBUFFER}


  { Gamma Ramp: Same as DX7 }

type
  PD3DGammaRamp = ^TD3DGammaRamp;
  _D3DGAMMARAMP = packed record
    red   : array [0..255] of Word;
    green : array [0..255] of Word;
    blue  : array [0..255] of Word;
  end;
  {$EXTERNALSYM _D3DGAMMARAMP}
  D3DGAMMARAMP = _D3DGAMMARAMP;
  {$EXTERNALSYM D3DGAMMARAMP}
  TD3DGammaRamp = _D3DGAMMARAMP;

  { Back buffer types }
  _D3DBACKBUFFER_TYPE = (
    D3DBACKBUFFER_TYPE_MONO         {= 0},
    D3DBACKBUFFER_TYPE_LEFT         {= 1},
    D3DBACKBUFFER_TYPE_RIGHT        {= 2}
  );
  {$EXTERNALSYM _D3DBACKBUFFER_TYPE}
  D3DBACKBUFFER_TYPE = _D3DBACKBUFFER_TYPE;
  {$EXTERNALSYM D3DBACKBUFFER_TYPE}
  TD3DBackbufferType = _D3DBACKBUFFER_TYPE;


  { Types }
  _D3DRESOURCETYPE = (
    D3DRTYPE_SURFACE                =  1,
    D3DRTYPE_VOLUME                 =  2,
    D3DRTYPE_TEXTURE                =  3,
    D3DRTYPE_VOLUMETEXTURE          =  4,
    D3DRTYPE_CUBETEXTURE            =  5,
    D3DRTYPE_VERTEXBUFFER           =  6,
    D3DRTYPE_INDEXBUFFER            =  7
  );
  {$EXTERNALSYM _D3DRESOURCETYPE}
  D3DRESOURCETYPE = _D3DRESOURCETYPE;
  {$EXTERNALSYM D3DRESOURCETYPE}
  TD3DResourceType = _D3DRESOURCETYPE;

const
  { Usages }
  D3DUSAGE_RENDERTARGET       = $00000001;
  {$EXTERNALSYM D3DUSAGE_RENDERTARGET}
  D3DUSAGE_DEPTHSTENCIL       = $00000002;
  {$EXTERNALSYM D3DUSAGE_DEPTHSTENCIL}

  { Usages for Vertex/Index buffers }
  D3DUSAGE_WRITEONLY          = $00000008;
  {$EXTERNALSYM D3DUSAGE_WRITEONLY}
  D3DUSAGE_SOFTWAREPROCESSING = $00000010;
  {$EXTERNALSYM D3DUSAGE_SOFTWAREPROCESSING}
  D3DUSAGE_DONOTCLIP          = $00000020;
  {$EXTERNALSYM D3DUSAGE_DONOTCLIP}
  D3DUSAGE_POINTS             = $00000040;
  {$EXTERNALSYM D3DUSAGE_POINTS}
  D3DUSAGE_RTPATCHES          = $00000080;
  {$EXTERNALSYM D3DUSAGE_RTPATCHES}
  D3DUSAGE_NPATCHES           = $00000100;
  {$EXTERNALSYM D3DUSAGE_NPATCHES}
  D3DUSAGE_DYNAMIC            = $00000200;
  {$EXTERNALSYM D3DUSAGE_DYNAMIC}









type
  { CubeMap Face identifiers }
  _D3DCUBEMAP_FACES = (
    D3DCUBEMAP_FACE_POSITIVE_X     {= 0},
    D3DCUBEMAP_FACE_NEGATIVE_X     {= 1},
    D3DCUBEMAP_FACE_POSITIVE_Y     {= 2},
    D3DCUBEMAP_FACE_NEGATIVE_Y     {= 3},
    D3DCUBEMAP_FACE_POSITIVE_Z     {= 4},
    D3DCUBEMAP_FACE_NEGATIVE_Z     {= 5}
  );
  {$EXTERNALSYM _D3DCUBEMAP_FACES}
  D3DCUBEMAP_FACES = _D3DCUBEMAP_FACES;
  {$EXTERNALSYM D3DCUBEMAP_FACES}
  TD3DCubemapFaces = _D3DCUBEMAP_FACES;


const
  { Lock flags }
  D3DLOCK_READONLY         = $00000010;
  {$EXTERNALSYM D3DLOCK_READONLY}
  D3DLOCK_DISCARD          = $00002000;
  {$EXTERNALSYM D3DLOCK_DISCARD}
  D3DLOCK_NOOVERWRITE      = $00001000;
  {$EXTERNALSYM D3DLOCK_NOOVERWRITE}
  D3DLOCK_NOSYSLOCK        = $00000800;
  {$EXTERNALSYM D3DLOCK_NOSYSLOCK}

  D3DLOCK_NO_DIRTY_UPDATE  = $00008000;
  {$EXTERNALSYM D3DLOCK_NO_DIRTY_UPDATE}






type
  { Vertex Buffer Description }
  PD3DVertexBufferDesc = ^TD3DVertexBufferDesc;
  _D3DVERTEXBUFFER_DESC = packed record
    Format : TD3DFormat;
    _Type  : TD3DResourceType;
    Usage  : DWord;
    Pool   : TD3DPool;
    Size   : LongWord;

    FVF    : DWord;
  end;
  {$EXTERNALSYM _D3DVERTEXBUFFER_DESC}
  D3DVERTEXBUFFER_DESC = _D3DVERTEXBUFFER_DESC;
  {$EXTERNALSYM D3DVERTEXBUFFER_DESC}
  TD3DVertexBufferDesc = _D3DVERTEXBUFFER_DESC;

  { Index Buffer Description }
  PD3DIndexBufferDesc = ^TD3DIndexBufferDesc;
  _D3DINDEXBUFFER_DESC = packed record
    Format : TD3DFormat;
    _Type  : TD3DResourceType;
    Usage  : DWord;
    Pool   : TD3DPool;
    Size   : LongWord;
  end {_D3DINDEXBUFFER_DESC};
  {$EXTERNALSYM _D3DINDEXBUFFER_DESC}
  D3DINDEXBUFFER_DESC = _D3DINDEXBUFFER_DESC;
  {$EXTERNALSYM D3DINDEXBUFFER_DESC}
  TD3DIndexBufferDesc = _D3DINDEXBUFFER_DESC;


 { Surface Description }
  PD3DSurfaceDesc = ^TD3DSurfaceDesc;
  _D3DSURFACE_DESC = packed record
    Format : TD3DFormat;
    _Type  : TD3DResourceType;
    Usage  : DWord;
    Pool   : TD3DPool;
    Size   : LongWord;

    MultiSampleType: TD3DMultiSampleType;
    Width  : LongWord;
    Height : LongWord;
  end {_D3DSURFACE_DESC};
  {$EXTERNALSYM _D3DSURFACE_DESC}
  D3DSURFACE_DESC = _D3DSURFACE_DESC;
  {$EXTERNALSYM D3DSURFACE_DESC}
  TD3DSurfaceDesc = _D3DSURFACE_DESC;

  PD3DVolumeDesc = ^TD3DVolumeDesc;
  _D3DVOLUME_DESC = packed record
    Format : TD3DFormat;
    _Type  : TD3DResourceType;
    Usage  : DWord;
    Pool   : TD3DPool;
    Size   : LongWord;

    Width  : LongWord;
    Height : LongWord;
    Depth  : LongWord;
  end {_D3DVOLUME_DESC};
  {$EXTERNALSYM _D3DVOLUME_DESC}
  D3DVOLUME_DESC = _D3DVOLUME_DESC;
  {$EXTERNALSYM D3DVOLUME_DESC}
  TD3DVolumeDesc = _D3DVOLUME_DESC;

  { Structure for LockRect }
  PD3DLockedRect = ^TD3DLockedRect;
  _D3DLOCKED_RECT = packed record
    Pitch: Integer;
    pBits: Pointer; // void*
  end {_D3DLOCKED_RECT};
  {$EXTERNALSYM _D3DLOCKED_RECT}
  D3DLOCKED_RECT = _D3DLOCKED_RECT;
  {$EXTERNALSYM D3DLOCKED_RECT}
  TD3DLockedRect = _D3DLOCKED_RECT;

  { Structures for LockBox }
  PD3DBox = ^TD3DBox;
  _D3DBOX = packed record
    Left        : LongWord;
    Top         : LongWord;
    Right       : LongWord;
    Bottom      : LongWord;
    Front       : LongWord;
    Back        : LongWord;
  end {_D3DBOX};
  {$EXTERNALSYM _D3DBOX}
  D3DBOX = _D3DBOX;
  {$EXTERNALSYM D3DBOX}
  TD3DBox = _D3DBOX;

  PD3DLockedBox = ^TD3DLockedBox;
  _D3DLOCKED_BOX = packed record
    RowPitch    : Integer;
    SlicePitch  : Integer;
    pBits       : Pointer; // void*
  end {_D3DLOCKED_BOX};
  {$EXTERNALSYM _D3DLOCKED_BOX}
  D3DLOCKED_BOX = _D3DLOCKED_BOX;
  {$EXTERNALSYM D3DLOCKED_BOX}
  TD3DLockedBox = _D3DLOCKED_BOX;

  { Structures for LockRange }
  PD3DRange = ^TD3DRange;
  _D3DRANGE = packed record
    Offset      : LongWord;
    Size        : LongWord;
  end {_D3DRANGE};
  {$EXTERNALSYM _D3DRANGE}
  D3DRANGE = _D3DRANGE;
  {$EXTERNALSYM D3DRANGE}
  TD3DRange = _D3DRANGE;

  { Structures for high order primitives }
  PD3DRectPatchInfo = ^TD3DRectPatchInfo;
  _D3DRECTPATCH_INFO = packed record
    StartVertexOffsetWidth  : LongWord;
    StartVertexOffsetHeight : LongWord;
    Width                   : LongWord;
    Height                  : LongWord;
    Stride                  : LongWord;
    Basis                   : TD3DBasisType;
    Order                   : TD3DOrderType;
  end;
  {$EXTERNALSYM _D3DRECTPATCH_INFO}
  D3DRECTPATCH_INFO = _D3DRECTPATCH_INFO;
  {$EXTERNALSYM D3DRECTPATCH_INFO}
  TD3DRectPatchInfo = _D3DRECTPATCH_INFO;

  PD3DTriPatchInfo = ^TD3DTriPatchInfo;
  _D3DTRIPATCH_INFO = packed record
    StartVertexOffset : LongWord;
    NumVertices       : LongWord;
    Basis             : TD3DBasisType;
    Order             : TD3DOrderType;
  end;
  {$EXTERNALSYM _D3DTRIPATCH_INFO}
  D3DTRIPATCH_INFO = _D3DTRIPATCH_INFO;
  {$EXTERNALSYM D3DTRIPATCH_INFO}
  TD3DTriPatchInfo = _D3DTRIPATCH_INFO;

const
  { Adapter Identifier }
  MAX_DEVICE_IDENTIFIER_STRING  = 512;
  {$EXTERNALSYM MAX_DEVICE_IDENTIFIER_STRING}
type
  PD3DAdapterIdentifier8 = ^TD3DAdapterIdentifier8;
  _D3DADAPTER_IDENTIFIER8 = packed record
    Driver      : array [0..MAX_DEVICE_IDENTIFIER_STRING-1] of Char;
    Description : array [0..MAX_DEVICE_IDENTIFIER_STRING-1] of Char;

    DriverVersionLowPart        : DWord;     { Defined for 16 bit driver components }
    DriverVersionHighPart       : DWord;

    VendorId    : DWord;
    DeviceId    : DWord;
    SubSysId    : DWord;
    Revision    : DWord;

    DeviceIdentifier : TGUID;

    WHQLLevel   : DWord;

  end;
  {$EXTERNALSYM _D3DADAPTER_IDENTIFIER8}
  D3DADAPTER_IDENTIFIER8 = _D3DADAPTER_IDENTIFIER8;
  {$EXTERNALSYM D3DADAPTER_IDENTIFIER8}
  TD3DAdapterIdentifier8 = _D3DADAPTER_IDENTIFIER8;


  { Raster Status structure returned by GetRasterStatus }
  PD3DRasterStatus = ^TD3DRasterStatus;
  _D3DRASTER_STATUS = packed record
    InVBlank : Bool;
    ScanLine : LongWord;
  end;
  {$EXTERNALSYM _D3DRASTER_STATUS}
  D3DRASTER_STATUS = _D3DRASTER_STATUS;
  {$EXTERNALSYM D3DRASTER_STATUS}
  TD3DRasterStatus = _D3DRASTER_STATUS;



{ Debug monitor tokens (DEBUG only)

   Note that if D3DRS_DEBUGMONITORTOKEN is set, the call is treated as
   passing a token to the debug monitor.  For example, if, after passing
   D3DDMT_ENABLE/DISABLE to D3DRS_DEBUGMONITORTOKEN other token values
   are passed in, the enabled/disabled state of the debug
   monitor will still persist.

   The debug monitor defaults to enabled.

   Calling GetRenderState on D3DRS_DEBUGMONITORTOKEN is not of any use.
}
  _D3DDEBUGMONITORTOKENS = DWord;
  {$EXTERNALSYM _D3DDEBUGMONITORTOKENS}
  D3DDEBUGMONITORTOKENS = _D3DDEBUGMONITORTOKENS;
  {$EXTERNALSYM D3DDEBUGMONITORTOKENS}
  TD3DDebugMonitorTokens = _D3DDEBUGMONITORTOKENS;

const
  D3DDMT_ENABLE            = 0;    // enable debug monitor
  {$EXTERNALSYM D3DDMT_ENABLE}
  D3DDMT_DISABLE           = 1;    // disable debug monitor
  {$EXTERNALSYM D3DDMT_DISABLE}

const
  // GetInfo IDs
  D3DDEVINFOID_RESOURCEMANAGER  = 5; (* Used with D3DDEVINFO_RESOURCEMANAGER *)
  {$EXTERNALSYM D3DDEVINFOID_RESOURCEMANAGER}
  D3DDEVINFOID_VERTEXSTATS      = 6; (* Used with D3DDEVINFO_D3DVERTEXSTATS *)
  {$EXTERNALSYM D3DDEVINFOID_VERTEXSTATS}

type
  PD3DResourceStats = ^TD3DResourceStats;
  _D3DRESOURCESTATS = packed record
  // Data collected since last Present()
    bThrashing                  : BOOL;  (* indicates if thrashing *)
    ApproxBytesDownloaded       : DWORD; (* Approximate number of bytes downloaded by resource manager *)
    NumEvicts                   : DWORD; (* number of objects evicted *)
    NumVidCreates               : DWORD; (* number of objects created in video memory *)
    LastPri                     : DWORD; (* priority of last object evicted *)
    NumUsed                     : DWORD; (* number of objects set to the device *)
    NumUsedInVidMem             : DWORD; (* number of objects set to the device, which are already in video memory *)
  // Persistent data
    WorkingSet                  : DWORD; (* number of objects in video memory *)
    WorkingSetBytes             : DWORD; (* number of bytes in video memory *)
    TotalManaged                : DWORD; (* total number of managed objects *)
    TotalBytes                  : DWORD; (* total number of bytes of managed objects *)
  end;
  {$EXTERNALSYM _D3DRESOURCESTATS}
  D3DRESOURCESTATS = _D3DRESOURCESTATS;
  {$EXTERNALSYM D3DRESOURCESTATS}
  TD3DResourceStats = _D3DRESOURCESTATS;

const
  D3DRTYPECOUNT = (DWORD(D3DRTYPE_INDEXBUFFER) + 1);
  {$EXTERNALSYM D3DRTYPECOUNT}

type
  PD3DDevInfoResourceManager = ^TD3DDevInfoResourceManager;
  _D3DDEVINFO_RESOURCEMANAGER = packed record
    stats: array [0..D3DRTYPECOUNT-1] of TD3DResourceStats;
  end;
  {$EXTERNALSYM _D3DDEVINFO_RESOURCEMANAGER}
  D3DDEVINFO_RESOURCEMANAGER = _D3DDEVINFO_RESOURCEMANAGER;
  {$EXTERNALSYM D3DDEVINFO_RESOURCEMANAGER}
  TD3DDevInfoResourceManager = _D3DDEVINFO_RESOURCEMANAGER;

  PD3DDevInfoD3DVertexStats = ^TD3DDevInfoD3DVertexStats;
  _D3DDEVINFO_D3DVERTEXSTATS = packed record
    NumRenderedTriangles        : DWORD; (* total number of triangles that are not clipped in this frame *)
    NumExtraClippingTriangles   : DWORD; (* Number of new triangles generated by clipping *)
  end;
  {$EXTERNALSYM _D3DDEVINFO_D3DVERTEXSTATS}
  D3DDEVINFO_D3DVERTEXSTATS = _D3DDEVINFO_D3DVERTEXSTATS;
  {$EXTERNALSYM D3DDEVINFO_D3DVERTEXSTATS}
  TD3DDevInfoD3DVertexStats = _D3DDEVINFO_D3DVERTEXSTATS;


(*==========================================================================;
 *
 *  Copyright (C) Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       d3d8caps.h
 *  Content:    Direct3D capabilities include file
 *
 ***************************************************************************)

type
  PD3DCaps8 = ^TD3DCaps8;
  _D3DCAPS8 = record
    (* Device Info *)
    DeviceType: TD3DDevType;
    AdapterOrdinal: DWord;

    (* Caps from DX7 Draw *)
    Caps: DWord;
    Caps2: DWord;
    Caps3: DWord;
    PresentationIntervals: DWord;

    (* Cursor Caps *)
    CursorCaps: DWORD;

    (* 3D Device Caps *)
    DevCaps: DWord;
    PrimitiveMiscCaps: DWord;
    RasterCaps: DWord;
    ZCmpCaps: DWord;
    SrcBlendCaps: DWord;
    DestBlendCaps: DWord;
    AlphaCmpCaps: DWord;
    ShadeCaps: DWord;
    TextureCaps: DWord;
    TextureFilterCaps: DWord;           // D3DPTFILTERCAPS for IDirect3DTexture8's
    CubeTextureFilterCaps: DWord;       // D3DPTFILTERCAPS for IDirect3DCubeTexture8's
    VolumeTextureFilterCaps: DWord;     // D3DPTFILTERCAPS for IDirect3DVolumeTexture8's
    TextureAddressCaps: DWord;          // D3DPTADDRESSCAPS for IDirect3DTexture8's
    VolumeTextureAddressCaps: DWord;    // D3DPTADDRESSCAPS for IDirect3DVolumeTexture8's

    LineCaps: DWord;                    // D3DLINECAPS

    MaxTextureWidth, MaxTextureHeight: DWord;
    MaxVolumeExtent: DWord;

    MaxTextureRepeat: DWord;
    MaxTextureAspectRatio: DWord;
    MaxAnisotropy: DWord;
    MaxVertexW: Single;

    GuardBandLeft: Single;
    GuardBandTop: Single;
    GuardBandRight: Single;
    GuardBandBottom: Single;

    ExtentsAdjust: Single;
    StencilCaps: DWord;

    FVFCaps: DWord;
    TextureOpCaps: DWord;
    MaxTextureBlendStages: DWord;
    MaxSimultaneousTextures: DWord;

    VertexProcessingCaps: DWord;
    MaxActiveLights: DWord;
    MaxUserClipPlanes: DWord;
    MaxVertexBlendMatrices: DWord;
    MaxVertexBlendMatrixIndex: DWord;

    MaxPointSize: Single;

    MaxPrimitiveCount: DWord;           // max number of primitives per DrawPrimitive call
    MaxVertexIndex: DWord;
    MaxStreams: DWord;
    MaxStreamStride: DWord;             // max stride for SetStreamSource

    VertexShaderVersion: DWord;
    MaxVertexShaderConst: DWord;        // number of vertex shader constant registers

    PixelShaderVersion: DWord;
    MaxPixelShaderValue: Single;        // max value of pixel shader arithmetic component
  end {D3DCAPS8};
  {$EXTERNALSYM _D3DCAPS8}
  D3DCAPS8 = _D3DCAPS8;
  {$EXTERNALSYM D3DCAPS8}
  TD3DCaps8 = _D3DCAPS8;

  //
  // BIT DEFINES FOR D3DCAPS8 DWORD MEMBERS
  //

const
  //
  // Caps
  //
  D3DCAPS_READ_SCANLINE         = $00020000;
  {$EXTERNALSYM D3DCAPS_READ_SCANLINE}

  //
  // Caps2
  //
  D3DCAPS2_NO2DDURING3DSCENE    = $00000002;
  {$EXTERNALSYM D3DCAPS2_NO2DDURING3DSCENE}
  D3DCAPS2_FULLSCREENGAMMA      = $00020000;
  {$EXTERNALSYM D3DCAPS2_FULLSCREENGAMMA}
  D3DCAPS2_CANRENDERWINDOWED    = $00080000;
  {$EXTERNALSYM D3DCAPS2_CANRENDERWINDOWED}
  D3DCAPS2_CANCALIBRATEGAMMA    = $00100000;
  {$EXTERNALSYM D3DCAPS2_CANCALIBRATEGAMMA}
  D3DCAPS2_RESERVED             = $02000000;
  {$EXTERNALSYM D3DCAPS2_RESERVED}
  D3DCAPS2_CANMANAGERESOURCE    = $10000000;
  {$EXTERNALSYM D3DCAPS2_CANMANAGERESOURCE}
  D3DCAPS2_DYNAMICTEXTURES      = $20000000;
  {$EXTERNALSYM D3DCAPS2_DYNAMICTEXTURES}

  //
  // Caps3
  //
  D3DCAPS3_RESERVED             = $8000001F;
  {$EXTERNALSYM D3DCAPS3_RESERVED}

  // Indicates that the device can respect the ALPHABLENDENABLE render state
  // when fullscreen while using the FLIP or DISCARD swap effect.
  // COPY and COPYVSYNC swap effects work whether or not this flag is set.
  D3DCAPS3_ALPHA_FULLSCREEN_FLIP_OR_DISCARD     = $00000020;
  {$EXTERNALSYM D3DCAPS3_ALPHA_FULLSCREEN_FLIP_OR_DISCARD}

  //
  // PresentationIntervals
  //
  D3DPRESENT_INTERVAL_DEFAULT   = $00000000;
  {$EXTERNALSYM D3DPRESENT_INTERVAL_DEFAULT}
  D3DPRESENT_INTERVAL_ONE       = $00000001;
  {$EXTERNALSYM D3DPRESENT_INTERVAL_ONE}
  D3DPRESENT_INTERVAL_TWO       = $00000002;
  {$EXTERNALSYM D3DPRESENT_INTERVAL_TWO}
  D3DPRESENT_INTERVAL_THREE     = $00000004;
  {$EXTERNALSYM D3DPRESENT_INTERVAL_THREE}
  D3DPRESENT_INTERVAL_FOUR      = $00000008;
  {$EXTERNALSYM D3DPRESENT_INTERVAL_FOUR}
  D3DPRESENT_INTERVAL_IMMEDIATE = $80000000;
  {$EXTERNALSYM D3DPRESENT_INTERVAL_IMMEDIATE}

  //
  // CursorCaps
  //
  // Driver supports HW color cursor in at least hi-res modes(height >=400)
  D3DCURSORCAPS_COLOR           = $00000001;
  {$EXTERNALSYM D3DCURSORCAPS_COLOR}
  // Driver supports HW cursor also in low-res modes(height < 400)
  D3DCURSORCAPS_LOWRES          = $00000002;
  {$EXTERNALSYM D3DCURSORCAPS_LOWRES}

  //
  // DevCaps
  //
  D3DDEVCAPS_EXECUTESYSTEMMEMORY        = $00000010; { Device can use execute buffers from system memory }
  {$EXTERNALSYM D3DDEVCAPS_EXECUTESYSTEMMEMORY}
  D3DDEVCAPS_EXECUTEVIDEOMEMORY         = $00000020; { Device can use execute buffers from video memory }
  {$EXTERNALSYM D3DDEVCAPS_EXECUTEVIDEOMEMORY}
  D3DDEVCAPS_TLVERTEXSYSTEMMEMORY       = $00000040; { Device can use TL buffers from system memory }
  {$EXTERNALSYM D3DDEVCAPS_TLVERTEXSYSTEMMEMORY}
  D3DDEVCAPS_TLVERTEXVIDEOMEMORY        = $00000080; { Device can use TL buffers from video memory }
  {$EXTERNALSYM D3DDEVCAPS_TLVERTEXVIDEOMEMORY}
  D3DDEVCAPS_TEXTURESYSTEMMEMORY        = $00000100; { Device can texture from system memory }
  {$EXTERNALSYM D3DDEVCAPS_TEXTURESYSTEMMEMORY}
  D3DDEVCAPS_TEXTUREVIDEOMEMORY         = $00000200; { Device can texture from device memory }
  {$EXTERNALSYM D3DDEVCAPS_TEXTUREVIDEOMEMORY}
  D3DDEVCAPS_DRAWPRIMTLVERTEX           = $00000400; { Device can draw TLVERTEX primitives }
  {$EXTERNALSYM D3DDEVCAPS_DRAWPRIMTLVERTEX}
  D3DDEVCAPS_CANRENDERAFTERFLIP         = $00000800; { Device can render without waiting for flip to complete }
  {$EXTERNALSYM D3DDEVCAPS_CANRENDERAFTERFLIP}
  D3DDEVCAPS_TEXTURENONLOCALVIDMEM      = $00001000; { Device can texture from nonlocal video memory }
  {$EXTERNALSYM D3DDEVCAPS_TEXTURENONLOCALVIDMEM}
  D3DDEVCAPS_DRAWPRIMITIVES2            = $00002000; { Device can support DrawPrimitives2 }
  {$EXTERNALSYM D3DDEVCAPS_DRAWPRIMITIVES2}
  D3DDEVCAPS_SEPARATETEXTUREMEMORIES    = $00004000; { Device is texturing from separate memory pools }
  {$EXTERNALSYM D3DDEVCAPS_SEPARATETEXTUREMEMORIES}
  D3DDEVCAPS_DRAWPRIMITIVES2EX          = $00008000; { Device can support Extended DrawPrimitives2 i.e. DX7 compliant driver }
  {$EXTERNALSYM D3DDEVCAPS_DRAWPRIMITIVES2EX}
  D3DDEVCAPS_HWTRANSFORMANDLIGHT        = $00010000; { Device can support transformation and lighting in hardware and DRAWPRIMITIVES2EX must be also }
  {$EXTERNALSYM D3DDEVCAPS_HWTRANSFORMANDLIGHT}
  D3DDEVCAPS_CANBLTSYSTONONLOCAL        = $00020000; { Device supports a Tex Blt from system memory to non-local vidmem }
  {$EXTERNALSYM D3DDEVCAPS_CANBLTSYSTONONLOCAL}
  D3DDEVCAPS_HWRASTERIZATION            = $00080000; { Device has HW acceleration for rasterization }
  {$EXTERNALSYM D3DDEVCAPS_HWRASTERIZATION}
  D3DDEVCAPS_PUREDEVICE                 = $00100000; { Device supports D3DCREATE_PUREDEVICE }
  {$EXTERNALSYM D3DDEVCAPS_PUREDEVICE}
  D3DDEVCAPS_QUINTICRTPATCHES           = $00200000; { Device supports quintic Beziers and BSplines }
  {$EXTERNALSYM D3DDEVCAPS_QUINTICRTPATCHES}
  D3DDEVCAPS_RTPATCHES                  = $00400000; { Device supports Rect and Tri patches }
  {$EXTERNALSYM D3DDEVCAPS_RTPATCHES}
  D3DDEVCAPS_RTPATCHHANDLEZERO          = $00800000; { Indicates that RT Patches may be drawn efficiently using handle 0 }
  {$EXTERNALSYM D3DDEVCAPS_RTPATCHHANDLEZERO}
  D3DDEVCAPS_NPATCHES                   = $01000000; { Device supports N-Patches }
  {$EXTERNALSYM D3DDEVCAPS_NPATCHES}

  //
  // PrimitiveMiscCaps
  //
  D3DPMISCCAPS_MASKZ                    = $00000002;
  {$EXTERNALSYM D3DPMISCCAPS_MASKZ}
  D3DPMISCCAPS_LINEPATTERNREP           = $00000004;
  {$EXTERNALSYM D3DPMISCCAPS_LINEPATTERNREP}
  D3DPMISCCAPS_CULLNONE                 = $00000010;
  {$EXTERNALSYM D3DPMISCCAPS_CULLNONE}
  D3DPMISCCAPS_CULLCW                   = $00000020;
  {$EXTERNALSYM D3DPMISCCAPS_CULLCW}
  D3DPMISCCAPS_CULLCCW                  = $00000040;
  {$EXTERNALSYM D3DPMISCCAPS_CULLCCW}
  D3DPMISCCAPS_COLORWRITEENABLE         = $00000080;
  {$EXTERNALSYM D3DPMISCCAPS_COLORWRITEENABLE}
  D3DPMISCCAPS_CLIPPLANESCALEDPOINTS    = $00000100; { Device correctly clips scaled points to clip planes }
  {$EXTERNALSYM D3DPMISCCAPS_CLIPPLANESCALEDPOINTS}
  D3DPMISCCAPS_CLIPTLVERTS              = $00000200; { device will clip post-transformed vertex primitives }
  {$EXTERNALSYM D3DPMISCCAPS_CLIPTLVERTS}
  D3DPMISCCAPS_TSSARGTEMP               = $00000400; { device supports D3DTA_TEMP for temporary register }
  {$EXTERNALSYM D3DPMISCCAPS_TSSARGTEMP}
  D3DPMISCCAPS_BLENDOP                  = $00000800; { device supports D3DRS_BLENDOP }
  {$EXTERNALSYM D3DPMISCCAPS_BLENDOP}
  D3DPMISCCAPS_NULLREFERENCE            = $00001000; { Reference Device that doesnt render }
  {$EXTERNALSYM D3DPMISCCAPS_NULLREFERENCE}

  //
  // LineCaps
  //
  D3DLINECAPS_TEXTURE                   = $00000001;
  {$EXTERNALSYM D3DLINECAPS_TEXTURE}
  D3DLINECAPS_ZTEST                     = $00000002;
  {$EXTERNALSYM D3DLINECAPS_ZTEST}
  D3DLINECAPS_BLEND                     = $00000004;
  {$EXTERNALSYM D3DLINECAPS_BLEND}
  D3DLINECAPS_ALPHACMP                  = $00000008;
  {$EXTERNALSYM D3DLINECAPS_ALPHACMP}
  D3DLINECAPS_FOG                       = $00000010;
  {$EXTERNALSYM D3DLINECAPS_FOG}

  //
  // RasterCaps
  //
  D3DPRASTERCAPS_DITHER                 = $00000001;
  {$EXTERNALSYM D3DPRASTERCAPS_DITHER}
  D3DPRASTERCAPS_PAT                    = $00000008;
  {$EXTERNALSYM D3DPRASTERCAPS_PAT}
  D3DPRASTERCAPS_ZTEST                  = $00000010;
  {$EXTERNALSYM D3DPRASTERCAPS_ZTEST}
  D3DPRASTERCAPS_FOGVERTEX              = $00000080;
  {$EXTERNALSYM D3DPRASTERCAPS_FOGVERTEX}
  D3DPRASTERCAPS_FOGTABLE               = $00000100;
  {$EXTERNALSYM D3DPRASTERCAPS_FOGTABLE}
  D3DPRASTERCAPS_ANTIALIASEDGES         = $00001000;
  {$EXTERNALSYM D3DPRASTERCAPS_ANTIALIASEDGES}
  D3DPRASTERCAPS_MIPMAPLODBIAS          = $00002000;
  {$EXTERNALSYM D3DPRASTERCAPS_MIPMAPLODBIAS}
  D3DPRASTERCAPS_ZBIAS                  = $00004000;
  {$EXTERNALSYM D3DPRASTERCAPS_ZBIAS}
  D3DPRASTERCAPS_ZBUFFERLESSHSR         = $00008000;
  {$EXTERNALSYM D3DPRASTERCAPS_ZBUFFERLESSHSR}
  D3DPRASTERCAPS_FOGRANGE               = $00010000;
  {$EXTERNALSYM D3DPRASTERCAPS_FOGRANGE}
  D3DPRASTERCAPS_ANISOTROPY             = $00020000;
  {$EXTERNALSYM D3DPRASTERCAPS_ANISOTROPY}
  D3DPRASTERCAPS_WBUFFER                = $00040000;
  {$EXTERNALSYM D3DPRASTERCAPS_WBUFFER}
  D3DPRASTERCAPS_WFOG                   = $00100000;
  {$EXTERNALSYM D3DPRASTERCAPS_WFOG}
  D3DPRASTERCAPS_ZFOG                   = $00200000;
  {$EXTERNALSYM D3DPRASTERCAPS_ZFOG}
  D3DPRASTERCAPS_COLORPERSPECTIVE       = $00400000; { Device iterates colors perspective correct }
  {$EXTERNALSYM D3DPRASTERCAPS_COLORPERSPECTIVE}
  D3DPRASTERCAPS_STRETCHBLTMULTISAMPLE  = $00800000;
  {$EXTERNALSYM D3DPRASTERCAPS_STRETCHBLTMULTISAMPLE}

  //
  // ZCmpCaps, AlphaCmpCaps
  //
  D3DPCMPCAPS_NEVER                     = $00000001;
  {$EXTERNALSYM D3DPCMPCAPS_NEVER}
  D3DPCMPCAPS_LESS                      = $00000002;
  {$EXTERNALSYM D3DPCMPCAPS_LESS}
  D3DPCMPCAPS_EQUAL                     = $00000004;
  {$EXTERNALSYM D3DPCMPCAPS_EQUAL}
  D3DPCMPCAPS_LESSEQUAL                 = $00000008;
  {$EXTERNALSYM D3DPCMPCAPS_LESSEQUAL}
  D3DPCMPCAPS_GREATER                   = $00000010;
  {$EXTERNALSYM D3DPCMPCAPS_GREATER}
  D3DPCMPCAPS_NOTEQUAL                  = $00000020;
  {$EXTERNALSYM D3DPCMPCAPS_NOTEQUAL}
  D3DPCMPCAPS_GREATEREQUAL              = $00000040;
  {$EXTERNALSYM D3DPCMPCAPS_GREATEREQUAL}
  D3DPCMPCAPS_ALWAYS                    = $00000080;
  {$EXTERNALSYM D3DPCMPCAPS_ALWAYS}

  //
  // SourceBlendCaps, DestBlendCaps
  //
  D3DPBLENDCAPS_ZERO                    = $00000001;
  {$EXTERNALSYM D3DPBLENDCAPS_ZERO}
  D3DPBLENDCAPS_ONE                     = $00000002;
  {$EXTERNALSYM D3DPBLENDCAPS_ONE}
  D3DPBLENDCAPS_SRCCOLOR                = $00000004;
  {$EXTERNALSYM D3DPBLENDCAPS_SRCCOLOR}
  D3DPBLENDCAPS_INVSRCCOLOR             = $00000008;
  {$EXTERNALSYM D3DPBLENDCAPS_INVSRCCOLOR}
  D3DPBLENDCAPS_SRCALPHA                = $00000010;
  {$EXTERNALSYM D3DPBLENDCAPS_SRCALPHA}
  D3DPBLENDCAPS_INVSRCALPHA             = $00000020;
  {$EXTERNALSYM D3DPBLENDCAPS_INVSRCALPHA}
  D3DPBLENDCAPS_DESTALPHA               = $00000040;
  {$EXTERNALSYM D3DPBLENDCAPS_DESTALPHA}
  D3DPBLENDCAPS_INVDESTALPHA            = $00000080;
  {$EXTERNALSYM D3DPBLENDCAPS_INVDESTALPHA}
  D3DPBLENDCAPS_DESTCOLOR               = $00000100;
  {$EXTERNALSYM D3DPBLENDCAPS_DESTCOLOR}
  D3DPBLENDCAPS_INVDESTCOLOR            = $00000200;
  {$EXTERNALSYM D3DPBLENDCAPS_INVDESTCOLOR}
  D3DPBLENDCAPS_SRCALPHASAT             = $00000400;
  {$EXTERNALSYM D3DPBLENDCAPS_SRCALPHASAT}
  D3DPBLENDCAPS_BOTHSRCALPHA            = $00000800;
  {$EXTERNALSYM D3DPBLENDCAPS_BOTHSRCALPHA}
  D3DPBLENDCAPS_BOTHINVSRCALPHA         = $00001000;
  {$EXTERNALSYM D3DPBLENDCAPS_BOTHINVSRCALPHA}

  //
  // ShadeCaps
  //
  D3DPSHADECAPS_COLORGOURAUDRGB         = $00000008;
  {$EXTERNALSYM D3DPSHADECAPS_COLORGOURAUDRGB}
  D3DPSHADECAPS_SPECULARGOURAUDRGB      = $00000200;
  {$EXTERNALSYM D3DPSHADECAPS_SPECULARGOURAUDRGB}
  D3DPSHADECAPS_ALPHAGOURAUDBLEND       = $00004000;
  {$EXTERNALSYM D3DPSHADECAPS_ALPHAGOURAUDBLEND}
  D3DPSHADECAPS_FOGGOURAUD              = $00080000;
  {$EXTERNALSYM D3DPSHADECAPS_FOGGOURAUD}

  //
  // TextureCaps
  //
  D3DPTEXTURECAPS_PERSPECTIVE           = $00000001; { Perspective-correct texturing is supported }
  {$EXTERNALSYM D3DPTEXTURECAPS_PERSPECTIVE}
  D3DPTEXTURECAPS_POW2                  = $00000002; { Power-of-2 texture dimensions are required - applies to non-Cube/Volume textures only. }
  {$EXTERNALSYM D3DPTEXTURECAPS_POW2}
  D3DPTEXTURECAPS_ALPHA                 = $00000004; { Alpha in texture pixels is supported }
  {$EXTERNALSYM D3DPTEXTURECAPS_ALPHA}
  D3DPTEXTURECAPS_SQUAREONLY            = $00000020; { Only square textures are supported }
  {$EXTERNALSYM D3DPTEXTURECAPS_SQUAREONLY}
  D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE = $00000040; { Texture indices are not scaled by the texture size prior to interpolation }
  {$EXTERNALSYM D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE}
  D3DPTEXTURECAPS_ALPHAPALETTE          = $00000080; { Device can draw alpha from texture palettes }
  {$EXTERNALSYM D3DPTEXTURECAPS_ALPHAPALETTE}
  // Device can use non-POW2 textures if:
  //  1) D3DTEXTURE_ADDRESS is set to CLAMP for this texture's stage
  //  2) D3DRS_WRAP(N) is zero for this texture's coordinates
  //  3) mip mapping is not enabled (use magnification filter only)
  D3DPTEXTURECAPS_NONPOW2CONDITIONAL    = $00000100;
  {$EXTERNALSYM D3DPTEXTURECAPS_NONPOW2CONDITIONAL}
  D3DPTEXTURECAPS_PROJECTED             = $00000400; { Device can do D3DTTFF_PROJECTED }
  {$EXTERNALSYM D3DPTEXTURECAPS_PROJECTED}
  D3DPTEXTURECAPS_CUBEMAP               = $00000800; { Device can do cubemap textures }
  {$EXTERNALSYM D3DPTEXTURECAPS_CUBEMAP}
  D3DPTEXTURECAPS_VOLUMEMAP             = $00002000; { Device can do volume textures }
  {$EXTERNALSYM D3DPTEXTURECAPS_VOLUMEMAP}
  D3DPTEXTURECAPS_MIPMAP                = $00004000; { Device can do mipmapped textures }
  {$EXTERNALSYM D3DPTEXTURECAPS_MIPMAP}
  D3DPTEXTURECAPS_MIPVOLUMEMAP          = $00008000; { Device can do mipmapped volume textures }
  {$EXTERNALSYM D3DPTEXTURECAPS_MIPVOLUMEMAP}
  D3DPTEXTURECAPS_MIPCUBEMAP            = $00010000; { Device can do mipmapped cube maps }
  {$EXTERNALSYM D3DPTEXTURECAPS_MIPCUBEMAP}
  D3DPTEXTURECAPS_CUBEMAP_POW2          = $00020000; { Device requires that cubemaps be power-of-2 dimension }
  {$EXTERNALSYM D3DPTEXTURECAPS_CUBEMAP_POW2}
  D3DPTEXTURECAPS_VOLUMEMAP_POW2        = $00040000; { Device requires that volume maps be power-of-2 dimension }
  {$EXTERNALSYM D3DPTEXTURECAPS_VOLUMEMAP_POW2}

  //
  // TextureFilterCaps
  //
  D3DPTFILTERCAPS_MINFPOINT             = $00000100; { Min Filter }
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFPOINT}
  D3DPTFILTERCAPS_MINFLINEAR            = $00000200;
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFLINEAR}
  D3DPTFILTERCAPS_MINFANISOTROPIC       = $00000400;
  {$EXTERNALSYM D3DPTFILTERCAPS_MINFANISOTROPIC}
  D3DPTFILTERCAPS_MIPFPOINT             = $00010000; { Mip Filter }
  {$EXTERNALSYM D3DPTFILTERCAPS_MIPFPOINT}
  D3DPTFILTERCAPS_MIPFLINEAR            = $00020000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MIPFLINEAR}
  D3DPTFILTERCAPS_MAGFPOINT             = $01000000; { Mag Filter }
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFPOINT}
  D3DPTFILTERCAPS_MAGFLINEAR            = $02000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFLINEAR}
  D3DPTFILTERCAPS_MAGFANISOTROPIC       = $04000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFANISOTROPIC}
  D3DPTFILTERCAPS_MAGFAFLATCUBIC        = $08000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFAFLATCUBIC}
  D3DPTFILTERCAPS_MAGFGAUSSIANCUBIC     = $10000000;
  {$EXTERNALSYM D3DPTFILTERCAPS_MAGFGAUSSIANCUBIC}

  //
  // TextureAddressCaps
  //
  D3DPTADDRESSCAPS_WRAP                 = $00000001;
  {$EXTERNALSYM D3DPTADDRESSCAPS_WRAP}
  D3DPTADDRESSCAPS_MIRROR               = $00000002;
  {$EXTERNALSYM D3DPTADDRESSCAPS_MIRROR}
  D3DPTADDRESSCAPS_CLAMP                = $00000004;
  {$EXTERNALSYM D3DPTADDRESSCAPS_CLAMP}
  D3DPTADDRESSCAPS_BORDER               = $00000008;
  {$EXTERNALSYM D3DPTADDRESSCAPS_BORDER}
  D3DPTADDRESSCAPS_INDEPENDENTUV        = $00000010;
  {$EXTERNALSYM D3DPTADDRESSCAPS_INDEPENDENTUV}
  D3DPTADDRESSCAPS_MIRRORONCE           = $00000020;
  {$EXTERNALSYM D3DPTADDRESSCAPS_MIRRORONCE}

  //
  // StencilCaps
  //
  D3DSTENCILCAPS_KEEP                   = $00000001;
  {$EXTERNALSYM D3DSTENCILCAPS_KEEP}
  D3DSTENCILCAPS_ZERO                   = $00000002;
  {$EXTERNALSYM D3DSTENCILCAPS_ZERO}
  D3DSTENCILCAPS_REPLACE                = $00000004;
  {$EXTERNALSYM D3DSTENCILCAPS_REPLACE}
  D3DSTENCILCAPS_INCRSAT                = $00000008;
  {$EXTERNALSYM D3DSTENCILCAPS_INCRSAT}
  D3DSTENCILCAPS_DECRSAT                = $00000010;
  {$EXTERNALSYM D3DSTENCILCAPS_DECRSAT}
  D3DSTENCILCAPS_INVERT                 = $00000020;
  {$EXTERNALSYM D3DSTENCILCAPS_INVERT}
  D3DSTENCILCAPS_INCR                   = $00000040;
  {$EXTERNALSYM D3DSTENCILCAPS_INCR}
  D3DSTENCILCAPS_DECR                   = $00000080;
  {$EXTERNALSYM D3DSTENCILCAPS_DECR}

  //
  // TextureOpCaps
  //
  D3DTEXOPCAPS_DISABLE                          = $00000001;
  {$EXTERNALSYM D3DTEXOPCAPS_DISABLE}
  D3DTEXOPCAPS_SELECTARG1                       = $00000002;
  {$EXTERNALSYM D3DTEXOPCAPS_SELECTARG1}
  D3DTEXOPCAPS_SELECTARG2                       = $00000004;
  {$EXTERNALSYM D3DTEXOPCAPS_SELECTARG2}
  D3DTEXOPCAPS_MODULATE                         = $00000008;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATE}
  D3DTEXOPCAPS_MODULATE2X                       = $00000010;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATE2X}
  D3DTEXOPCAPS_MODULATE4X                       = $00000020;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATE4X}
  D3DTEXOPCAPS_ADD                              = $00000040;
  {$EXTERNALSYM D3DTEXOPCAPS_ADD}
  D3DTEXOPCAPS_ADDSIGNED                        = $00000080;
  {$EXTERNALSYM D3DTEXOPCAPS_ADDSIGNED}
  D3DTEXOPCAPS_ADDSIGNED2X                      = $00000100;
  {$EXTERNALSYM D3DTEXOPCAPS_ADDSIGNED2X}
  D3DTEXOPCAPS_SUBTRACT                         = $00000200;
  {$EXTERNALSYM D3DTEXOPCAPS_SUBTRACT}
  D3DTEXOPCAPS_ADDSMOOTH                        = $00000400;
  {$EXTERNALSYM D3DTEXOPCAPS_ADDSMOOTH}
  D3DTEXOPCAPS_BLENDDIFFUSEALPHA                = $00000800;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDDIFFUSEALPHA}
  D3DTEXOPCAPS_BLENDTEXTUREALPHA                = $00001000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDTEXTUREALPHA}
  D3DTEXOPCAPS_BLENDFACTORALPHA                 = $00002000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDFACTORALPHA}
  D3DTEXOPCAPS_BLENDTEXTUREALPHAPM              = $00004000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDTEXTUREALPHAPM}
  D3DTEXOPCAPS_BLENDCURRENTALPHA                = $00008000;
  {$EXTERNALSYM D3DTEXOPCAPS_BLENDCURRENTALPHA}
  D3DTEXOPCAPS_PREMODULATE                      = $00010000;
  {$EXTERNALSYM D3DTEXOPCAPS_PREMODULATE}
  D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR           = $00020000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR}
  D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA           = $00040000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA}
  D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR        = $00080000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR}
  D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA        = $00100000;
  {$EXTERNALSYM D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA}
  D3DTEXOPCAPS_BUMPENVMAP                       = $00200000;
  {$EXTERNALSYM D3DTEXOPCAPS_BUMPENVMAP}
  D3DTEXOPCAPS_BUMPENVMAPLUMINANCE              = $00400000;
  {$EXTERNALSYM D3DTEXOPCAPS_BUMPENVMAPLUMINANCE}
  D3DTEXOPCAPS_DOTPRODUCT3                      = $00800000;
  {$EXTERNALSYM D3DTEXOPCAPS_DOTPRODUCT3}
  D3DTEXOPCAPS_MULTIPLYADD                      = $01000000;
  {$EXTERNALSYM D3DTEXOPCAPS_MULTIPLYADD}
  D3DTEXOPCAPS_LERP                             = $02000000;
  {$EXTERNALSYM D3DTEXOPCAPS_LERP}

  //
  // FVFCaps
  //
  D3DFVFCAPS_TEXCOORDCOUNTMASK  = $0000ffff; { mask for texture coordinate count field }
  {$EXTERNALSYM D3DFVFCAPS_TEXCOORDCOUNTMASK}
  D3DFVFCAPS_DONOTSTRIPELEMENTS = $00080000; { Device prefers that vertex elements not be stripped }
  {$EXTERNALSYM D3DFVFCAPS_DONOTSTRIPELEMENTS}
  D3DFVFCAPS_PSIZE              = $00100000; { Device can receive point size }
  {$EXTERNALSYM D3DFVFCAPS_PSIZE}

  //
  // VertexProcessingCaps
  //
  D3DVTXPCAPS_TEXGEN            = $00000001; { device can do texgen }
  {$EXTERNALSYM D3DVTXPCAPS_TEXGEN}
  D3DVTXPCAPS_MATERIALSOURCE7   = $00000002; { device can do DX7-level colormaterialsource ops }
  {$EXTERNALSYM D3DVTXPCAPS_MATERIALSOURCE7}
  D3DVTXPCAPS_DIRECTIONALLIGHTS = $00000008; { device can do directional lights }
  {$EXTERNALSYM D3DVTXPCAPS_DIRECTIONALLIGHTS}
  D3DVTXPCAPS_POSITIONALLIGHTS  = $00000010; { device can do positional lights (includes point and spot) }
  {$EXTERNALSYM D3DVTXPCAPS_POSITIONALLIGHTS}
  D3DVTXPCAPS_LOCALVIEWER       = $00000020; { device can do local viewer }
  {$EXTERNALSYM D3DVTXPCAPS_LOCALVIEWER}
  D3DVTXPCAPS_TWEENING          = $00000040; { device can do vertex tweening }
  {$EXTERNALSYM D3DVTXPCAPS_TWEENING}
  D3DVTXPCAPS_NO_VSDT_UBYTE4    = $00000080; { device does not support D3DVSDT_UBYTE4 }
  {$EXTERNALSYM D3DVTXPCAPS_NO_VSDT_UBYTE4}




(*==========================================================================;
 *
 *  Copyright (C) Microsoft Corporation.  All Rights Reserved.
 *
 *  File:   d3d8.h
 *  Content:    Direct3D include file
 *
 ****************************************************************************)

(* This identifier is passed to Direct3DCreate8 in order to ensure that an
 * application was built against the correct header files. This number is
 * incremented whenever a header (or other) change would require applications
 * to be rebuilt. If the version doesn't match, Direct3DCreate8 will fail.
 * (The number itself has no meaning.)*)

const
  D3D_SDK_VERSION = DWord(220);
  {$EXTERNALSYM D3D_SDK_VERSION}

type
  HMONITOR = THandle;
  {$EXTERNALSYM HMONITOR}



(*
 * Direct3D interfaces
 *)


  // forward interfaces declaration
  IDirect3D8 = interface;
  IDirect3DDevice8 = interface;
  IDirect3DResource8 = interface;
  IDirect3DBaseTexture8 = interface;
  IDirect3DTexture8 = interface;
  IDirect3DVolumeTexture8 = interface;
  IDirect3DCubeTexture8 = interface;
  IDirect3DVertexBuffer8 = interface;
  IDirect3DIndexBuffer8 = interface;
  IDirect3DSurface8 = interface;
  IDirect3DVolume8 = interface;
  IDirect3DSwapChain8 = interface;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3D8);'}
  {$EXTERNALSYM IDirect3D8}
  IDirect3D8 = interface(IUnknown)
    ['{1DD9E8DA-1C77-4d40-B0CF-98FEFDFF9512}']
    (*** IDirect3D8 methods ***)
    function RegisterSoftwareDevice(pInitializeFunction: Pointer): HResult; stdcall;
    function GetAdapterCount: LongWord; stdcall;
    function GetAdapterIdentifier(Adapter: LongWord; Flags: DWord; out pIdentifier: TD3DAdapterIdentifier8): HResult; stdcall;
    function GetAdapterModeCount (Adapter: LongWord): LongWord; stdcall;
    function EnumAdapterModes(Adapter, Mode: LongWord; out pMode: TD3DDisplayMode): HResult; stdcall;
    function GetAdapterDisplayMode(Adapter: LongWord; out pMode: TD3DDisplayMode): HResult; stdcall;
    function CheckDeviceType(Adapter: LongWord; CheckType: TD3DDevType; DisplayFormat, BackBufferFormat: TD3DFormat; Windowed: BOOL): HResult; stdcall;
    function CheckDeviceFormat(Adapter: LongWord; DeviceType: TD3DDevType; AdapterFormat: TD3DFormat; Usage: DWord; RType: TD3DResourceType; CheckFormat: TD3DFormat): HResult; stdcall;
    function CheckDeviceMultiSampleType(Adapter: LongWord; DeviceType: TD3DDevType; SurfaceFormat: TD3DFormat; Windowed: BOOL; MultiSampleType: TD3DMultiSampleType): HResult; stdcall;
    function CheckDepthStencilMatch(Adapter: LongWord; DeviceType: TD3DDevType; AdapterFormat, RenderTargetFormat, DepthStencilFormat: TD3DFormat): HResult; stdcall;
    function GetDeviceCaps(Adapter: LongWord; DeviceType: TD3DDevType; out pCaps: TD3DCaps8): HResult; stdcall;
    function GetAdapterMonitor(Adapter: LongWord): HMONITOR; stdcall;
    function CreateDevice(Adapter: LongWord; DeviceType: TD3DDevType; hFocusWindow: HWND; BehaviorFlags: DWord; var pPresentationParameters: TD3DPresentParameters; out ppReturnedDeviceInterface: IDirect3DDevice8): HResult; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DDevice8);'}
  {$EXTERNALSYM IDirect3DDevice8}
  IDirect3DDevice8 = interface(IUnknown)
    ['{7385E5DF-8FE8-41D5-86B6-D7B48547B6CF}']
     (*** IDirect3DDevice8 methods ***)
    function TestCooperativeLevel: HResult; stdcall;
    function GetAvailableTextureMem: LongWord; stdcall;
    function ResourceManagerDiscardBytes(Bytes: DWord): HResult; stdcall;
    function GetDirect3D(out ppD3D8: IDirect3D8): HResult; stdcall;
    function GetDeviceCaps(out pCaps: TD3DCaps8): HResult; stdcall;
    function GetDisplayMode(out pMode: TD3DDisplayMode): HResult; stdcall;
    function GetCreationParameters(out pParameters: TD3DDeviceCreationParameters): HResult; stdcall;
    function SetCursorProperties(XHotSpot, YHotSpot: LongWord; pCursorBitmap: IDirect3DSurface8): HResult; stdcall;
    procedure SetCursorPosition(XScreenSpace, YScreenSpace: Integer; Flags: DWord); stdcall;
    function ShowCursor(bShow: BOOL): BOOL; stdcall;
    function CreateAdditionalSwapChain(const pPresentationParameters: TD3DPresentParameters; out pSwapChain: IDirect3DSwapChain8): HResult; stdcall;
    function Reset(const pPresentationParameters: TD3DPresentParameters): HResult; stdcall;
    function Present(pSourceRect, pDestRect: PRect; hDestWindowOverride: HWND; pDirtyRegion: PRgnData): HResult; stdcall;
    function GetBackBuffer(BackBuffer: LongWord; _Type: TD3DBackBufferType; out ppBackBuffer: IDirect3DSurface8): HResult; stdcall;
    function GetRasterStatus(out pRasterStatus: TD3DRasterStatus): HResult; stdcall;
    procedure SetGammaRamp(Flags: DWord; const pRamp: TD3DGammaRamp); stdcall;
    procedure GetGammaRamp(out pRamp: TD3DGammaRamp); stdcall;
    function CreateTexture(Width, Height, Levels: LongWord; Usage: DWord; Format: TD3DFormat; Pool: TD3DPool; out ppTexture: IDirect3DTexture8): HResult; stdcall;
    function CreateVolumeTexture(Width, Height, Depth, Levels: LongWord; Usage: DWord; Format: TD3DFormat; Pool: TD3DPool; out ppVolumeTexture: IDirect3DVolumeTexture8): HResult; stdcall;
    function CreateCubeTexture(EdgeLength, Levels: LongWord; Usage: DWord; Format: TD3DFormat; Pool: TD3DPool; out ppCubeTexture: IDirect3DCubeTexture8): HResult; stdcall;
    function CreateVertexBuffer(Length: LongWord; Usage, FVF: DWord; Pool: TD3DPool; out ppVertexBuffer: IDirect3DVertexBuffer8): HResult; stdcall;
    function CreateIndexBuffer(Length: LongWord; Usage: DWord; Format: TD3DFormat; Pool: TD3DPool; out ppIndexBuffer: IDirect3DIndexBuffer8): HResult; stdcall;
    function CreateRenderTarget(Width, Height: LongWord; Format: TD3DFormat; MultiSample: TD3DMultiSampleType; Lockable: BOOL; out ppSurface: IDirect3DSurface8): HResult; stdcall;
    function CreateDepthStencilSurface(Width, Height: LongWord; Format: TD3DFormat; MultiSample: TD3DMultiSampleType; out ppSurface: IDirect3DSurface8): HResult; stdcall;
    function CreateImageSurface(Width, Height: LongWord; Format: TD3DFormat; out ppSurface: IDirect3DSurface8): HResult; stdcall;
    function CopyRects(pSourceSurface: IDirect3DSurface8; pSourceRectsArray: PRect; cRects: LongWord; pDestinationSurface: IDirect3DSurface8; pDestPointsArray: PPoint): HResult; stdcall;
    function UpdateTexture(pSourceTexture, pDestinationTexture: IDirect3DBaseTexture8): HResult; stdcall;
    function GetFrontBuffer(pDestSurface: IDirect3DSurface8): HResult; stdcall;
    function SetRenderTarget(pRenderTarget, pNewZStencil: IDirect3DSurface8): HResult; stdcall;
    function GetRenderTarget(out ppRenderTarget: IDirect3DSurface8): HResult; stdcall;
    function GetDepthStencilSurface(out ppZStencilSurface: IDirect3DSurface8): HResult; stdcall;
    function BeginScene: HResult; stdcall;
    function EndScene: HResult; stdcall;
    function Clear(Count: DWord; pRects: PD3DRect; Flags: DWord; Color: TD3DColor; Z: Single; Stencil: DWord): HResult; stdcall;
    function SetTransform(State: TD3DTransformStateType; const pMatrix: TD3DMatrix): HResult; stdcall;
    function GetTransform(State: TD3DTransformStateType; out pMatrix: TD3DMatrix): HResult; stdcall;
    function MultiplyTransform(State: TD3DTransformStateType; const pMatrix: TD3DMatrix): HResult; stdcall;
    function SetViewport(const pViewport: TD3DViewport8): HResult; stdcall;
    function GetViewport(out pViewport: TD3DViewport8): HResult; stdcall;
    function SetMaterial(const pMaterial: TD3DMaterial8): HResult; stdcall;
    function GetMaterial(out pMaterial: TD3DMaterial8): HResult; stdcall;
    function SetLight(Index: DWord; const pLight: TD3DLight8): HResult; stdcall;
    function GetLight(Index: DWord; out pLight: TD3DLight8): HResult; stdcall;
    function LightEnable(Index: DWord; Enable: BOOL): HResult; stdcall;
    function GetLightEnable(Index: DWord; out pEnable: BOOL): HResult; stdcall;
    function SetClipPlane(Index: DWord; pPlane: PSingle): HResult; stdcall;
    function GetClipPlane(Index: DWord; pPlane: PSingle): HResult; stdcall;
    function SetRenderState(State: TD3DRenderStateType; Value: DWord): HResult; stdcall;
    function GetRenderState(State: TD3DRenderStateType; out pValue: DWord): HResult; stdcall;
    function BeginStateBlock: HResult; stdcall;
    function EndStateBlock(out pToken: DWord): HResult; stdcall;
    function ApplyStateBlock(Token: DWord): HResult; stdcall;
    function CaptureStateBlock(Token: DWord): HResult; stdcall;
    function DeleteStateBlock(Token: DWord): HResult; stdcall;
    function CreateStateBlock(_Type: TD3DStateBlockType; out Token: DWord): HResult; stdcall;
    function SetClipStatus(const pClipStatus: TD3DClipStatus8): HResult; stdcall;
    function GetClipStatus(out pClipStatus: TD3DClipStatus8): HResult; stdcall;
    function GetTexture(Stage: DWord; out ppTexture: IDirect3DBaseTexture8): HResult; stdcall;
    function SetTexture(Stage: DWord; pTexture: IDirect3DBaseTexture8): HResult; stdcall;
    function GetTextureStageState(Stage: DWord; _Type: TD3DTextureStageStateType; out pValue: DWord): HResult; stdcall;
    function SetTextureStageState(Stage: DWord; _Type: TD3DTextureStageStateType; Value: DWord): HResult; stdcall;
    function ValidateDevice(out pNumPasses: DWord): HResult; stdcall;
    function GetInfo(DevInfoID: DWord; out pDevInfoStruct; DevInfoStructSize: DWord): HResult; stdcall;
    function SetPaletteEntries(PaletteNumber: LongWord; pEntries: pPaletteEntry): HResult; stdcall;
    function GetPaletteEntries(PaletteNumber: LongWord; pEntries: pPaletteEntry): HResult; stdcall;
    function SetCurrentTexturePalette(PaletteNumber: LongWord): HResult; stdcall;
    function GetCurrentTexturePalette(out PaletteNumber: LongWord): HResult; stdcall;
    function DrawPrimitive(PrimitiveType: TD3DPrimitiveType; StartVertex, PrimitiveCount: LongWord): HResult; stdcall;
    function DrawIndexedPrimitive(_Type: TD3DPrimitiveType; minIndex, NumVertices, startIndex, primCount: LongWord): HResult; stdcall;
    function DrawPrimitiveUP(PrimitiveType: TD3DPrimitiveType; PrimitiveCount: LongWord; const pVertexStreamZeroData; VertexStreamZeroStride: LongWord): HResult; stdcall;
    function DrawIndexedPrimitiveUP(PrimitiveType: TD3DPrimitiveType; MinVertexIndex, NumVertexIndices, PrimitiveCount: LongWord; const pIndexData; IndexDataFormat: TD3DFormat; const pVertexStreamZeroData; VertexStreamZeroStride: LongWord): HResult; stdcall;
    function ProcessVertices(SrcStartIndex, DestIndex, VertexCount: LongWord; pDestBuffer: IDirect3DVertexBuffer8; Flags: DWord): HResult; stdcall;
    function CreateVertexShader(pDeclaration, pFunction: PDWord; out pHandle: DWord; Usage: DWord): HResult; stdcall;
    function SetVertexShader(Handle: DWord): HResult; stdcall;
    function GetVertexShader(out pHandle: DWord): HResult; stdcall;
    function DeleteVertexShader(Handle: DWord): HResult; stdcall;
    function SetVertexShaderConstant(_Register: DWord; const pConstantData; ConstantCount: DWord): HResult; stdcall;
    function GetVertexShaderConstant(_Register: DWord; out pConstantData; ConstantCount: DWord): HResult; stdcall;
    function GetVertexShaderDeclaration(Handle: DWord; pData: Pointer; out pSizeOfData: DWord): HResult; stdcall;
    function GetVertexShaderFunction(Handle: DWord; pData: Pointer; out pSizeOfData: DWord): HResult; stdcall;
    function SetStreamSource(StreamNumber: LongWord; pStreamData: IDirect3DVertexBuffer8; Stride: LongWord): HResult; stdcall;
    function GetStreamSource(StreamNumber: LongWord; out ppStreamData: IDirect3DVertexBuffer8; out pStride: LongWord): HResult; stdcall;
    function SetIndices(pIndexData: IDirect3DIndexBuffer8; BaseVertexIndex: LongWord): HResult; stdcall;
    function GetIndices(out ppIndexData: IDirect3DIndexBuffer8; out pBaseVertexIndex: LongWord): HResult; stdcall;
    function CreatePixelShader(pFunction: PDWord; out pHandle: DWord): HResult; stdcall;
    function SetPixelShader(Handle: DWord): HResult; stdcall;
    function GetPixelShader(out Handle: DWord): HResult; stdcall;
    function DeletePixelShader(Handle: DWord): HResult; stdcall;
    function SetPixelShaderConstant(_Register: DWord; const pConstantData; ConstantCount: DWord): HResult; stdcall;
    function GetPixelShaderConstant(_Register: DWord; out pConstantData; ConstantCount: DWord): HResult; stdcall;
    function GetPixelShaderFunction(Handle: DWord; pData: Pointer; var pSizeOfData: DWord): HResult; stdcall;
    function DrawRectPatch(Handle: LongWord; pNumSegs: PSingle; pTriPatchInfo: PD3DRectPatchInfo): HResult; stdcall;
    function DrawTriPatch(Handle: LongWord; pNumSegs: PSingle; pTriPatchInfo: PD3DTriPatchInfo): HResult; stdcall;
    function DeletePatch(Handle: LongWord): HResult; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DSwapChain8);'}
  {$EXTERNALSYM IDirect3DSwapChain8}
  IDirect3DSwapChain8 = interface(IUnknown)
    ['{928C088B-76B9-4C6B-A536-A590853876CD}']
    (*** IDirect3DSwapChain8 methods ***)
    function Present(pSourceRect, pDestRect: PRect; hDestWindowOverride: HWND; pDirtyRegion: PRgnData): HResult; stdcall;
    function GetBackBuffer(BackBuffer: LongWord; _Type: TD3DBackBufferType; out ppBackBuffer: IDirect3DSurface8): HResult; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DResource8);'}
  {$EXTERNALSYM IDirect3DResource8}
  IDirect3DResource8 = interface(IUnknown)
    ['{1B36BB7B-09B7-410a-B445-7D1430D7B33F}']
    (*** IDirect3DResource8 methods ***)
    function GetDevice(out ppDevice: IDirect3DDevice8): HResult; stdcall;
    function SetPrivateData(const refguid: TGUID; const pData; SizeOfData, Flags: DWord): HResult; stdcall;
    function GetPrivateData(const refguid: TGUID; pData: Pointer; out pSizeOfData: DWord): HResult; stdcall;
    function FreePrivateData(const refguid: TGUID): HResult; stdcall;
    function SetPriority(PriorityNew: DWord): DWord; stdcall;
    function GetPriority: DWord; stdcall;
    procedure PreLoad; stdcall;
    function GetType: TD3DResourceType; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DBaseTexture8);'}
  {$EXTERNALSYM IDirect3DBaseTexture8}
  IDirect3DBaseTexture8 = interface(IDirect3DResource8)
    ['{B4211CFA-51B9-4a9f-AB78-DB99B2BB678E}']
    (*** IDirect3DBaseTexture8 methods ***)
    function SetLOD(LODNew: DWord): DWord; stdcall;
    function GetLOD: DWord; stdcall;
    function GetLevelCount: DWord; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DTexture8);'}
  {$EXTERNALSYM IDirect3DTexture8}
  IDirect3DTexture8 = interface(IDirect3DBaseTexture8)
    ['{E4CDD575-2866-4f01-B12E-7EECE1EC9358}']
    (*** IDirect3DTexture8 methods ***)
    function GetLevelDesc(Level: LongWord; out pDesc: TD3DSurfaceDesc): HResult; stdcall;
    function GetSurfaceLevel(Level: LongWord; out ppSurfaceLevel: IDirect3DSurface8): HResult; stdcall;
    function LockRect(Level: LongWord; out pLockedRect: TD3DLockedRect; pRect: PRect; Flags: DWord): HResult; stdcall;
    function UnlockRect(Level: LongWord): HResult; stdcall;
    function AddDirtyRect(pDirtyRect: PRect): HResult; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVolumeTexture8);'}
  {$EXTERNALSYM IDirect3DVolumeTexture8}
  IDirect3DVolumeTexture8 = interface(IDirect3DBaseTexture8)
    ['{E4CDD575-2866-4f01-B12E-7EECE1EC9358}']
    (*** IDirect3DVolumeTexture8 methods ***)
    function GetLevelDesc(Level: LongWord; out pDesc: TD3DVolumeDesc): HResult; stdcall;
    function GetVolumeLevel(Level: LongWord; out ppVolumeLevel: IDirect3DVolume8): HResult; stdcall;
    function LockBox(Level: LongWord; out pLockedVolume: TD3DLockedBox; pBox: PD3DBox; Flags: DWord): HResult; stdcall;
    function UnlockBox(Level: LongWord): HResult; stdcall;
    function AddDirtyBox(pDirtyBox: PD3DBox): HResult; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DCubeTexture8);'}
  {$EXTERNALSYM IDirect3DCubeTexture8}
  IDirect3DCubeTexture8 = interface(IDirect3DBaseTexture8)
    ['{3EE5B968-2ACA-4c34-8BB5-7E0C3D19B750}']
    (*** IDirect3DCubeTexture8 methods ***)
    function GetLevelDesc(Level: LongWord; out pDesc: TD3DSurfaceDesc): HResult; stdcall;
    function GetCubeMapSurface(FaceType: TD3DCubeMapFaces; Level: LongWord; out ppCubeMapSurface: IDirect3DSurface8): HResult; stdcall;
    function LockRect(FaceType: TD3DCubeMapFaces; Level: LongWord; out pLockedRect: TD3DLockedRect; pRect: PRect; Flags: DWord): HResult; stdcall;
    function UnlockRect(FaceType: TD3DCubeMapFaces; Level: LongWord): HResult; stdcall;
    function AddDirtyRect(FaceType: TD3DCubeMapFaces; pDirtyRect: PRect): HResult; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVertexBuffer8);'}
  {$EXTERNALSYM IDirect3DVertexBuffer8}
  IDirect3DVertexBuffer8 = interface(IDirect3DResource8)
    ['{8AEEEAC7-05F9-44d4-B591-000B0DF1CB95}']
    (*** IDirect3DVertexBuffer8 methods ***)
    function Lock(OffsetToLock, SizeToLock: LongWord; out ppbData: PByte; Flags: DWord): HResult; stdcall;
    function Unlock: HResult; stdcall;
    function GetDesc(out pDesc: TD3DVertexBufferDesc): HResult; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DIndexBuffer8);'}
  {$EXTERNALSYM IDirect3DIndexBuffer8}
  IDirect3DIndexBuffer8 = interface(IDirect3DResource8)
    ['{0E689C9A-053D-44a0-9D92-DB0E3D750F86}']
    (*** IDirect3DIndexBuffer8 methods ***)
    function Lock(OffsetToLock, SizeToLock: DWord; out ppbData: PByte; Flags: DWord): HResult; stdcall;
    function Unlock: HResult; stdcall;
    function GetDesc(out pDesc: TD3DIndexBufferDesc): HResult; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DSurface8);'}
  {$EXTERNALSYM IDirect3DSurface8}
  IDirect3DSurface8 = interface(IUnknown)
    ['{B96EEBCA-B326-4ea5-882F-2FF5BAE021DD}']
    (*** IDirect3DSurface8 methods ***)
    function GetDevice(out ppDevice: IDirect3DDevice8): HResult; stdcall;
    function SetPrivateData(const refguid: TGUID; const pData; SizeOfData, Flags: DWord): HResult; stdcall;
    function GetPrivateData(const refguid: TGUID; pData: Pointer; out pSizeOfData: DWord): HResult; stdcall;
    function FreePrivateData(const refguid: TGUID): HResult; stdcall;
    function GetContainer(const riid: TGUID; out ppContainer: Pointer): HResult; stdcall;
    function GetDesc(out pDesc: TD3DSurfaceDesc): HResult; stdcall;
    function LockRect(out pLockedRect: TD3DLockedRect; pRect: PRect; Flags: DWord): HResult; stdcall;
    function UnlockRect: HResult; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVolume8);'}
  {$EXTERNALSYM IDirect3DVolume8}
  IDirect3DVolume8 = interface(IUnknown)
    ['{BD7349F5-14F1-42e4-9C79-972380DB40C0}']
    (*** IDirect3DVolume8 methods ***)
    function GetDevice(out ppDevice: IDirect3DDevice8): HResult; stdcall;
    function SetPrivateData(const refguid: TGUID; const pData; SizeOfData, Flags: DWord): HResult; stdcall;
    function GetPrivateData(const refguid: TGUID; pData: Pointer; out pSizeOfData: DWord): HResult; stdcall;
    function FreePrivateData(const refguid: TGUID): HResult; stdcall;
    function GetContainer(const riid: TGUID; var ppContainer: Pointer): HResult; stdcall;
    function GetDesc(out pDesc: TD3DVolumeDesc): HResult; stdcall;
    function LockBox(out pLockedVolume: TD3DLockedBox; pBox: PD3DBox; Flags: DWord): HResult; stdcall;
    function UnlockBox: HResult; stdcall;
  end;



(*
 * Interface IID's
 *)
type
  IID_IDirect3D8              = IDirect3D8;
  {$EXTERNALSYM IID_IDirect3D8}
  IID_IDirect3DDevice8        = IDirect3DDevice8;
  {$EXTERNALSYM IID_IDirect3DDevice8}
  IID_IDirect3DResource8      = IDirect3DResource8;
  {$EXTERNALSYM IID_IDirect3DResource8}
  IID_IDirect3DBaseTexture8   = IDirect3DBaseTexture8;
  {$EXTERNALSYM IID_IDirect3DBaseTexture8}
  IID_IDirect3DTexture8       = IDirect3DTexture8;
  {$EXTERNALSYM IID_IDirect3DTexture8}
  IID_IDirect3DCubeTexture8   = IDirect3DCubeTexture8;
  {$EXTERNALSYM IID_IDirect3DCubeTexture8}
  IID_IDirect3DVolumeTexture8 = IDirect3DVolumeTexture8;
  {$EXTERNALSYM IID_IDirect3DVolumeTexture8}
  IID_IDirect3DVertexBuffer8  = IDirect3DVertexBuffer8;
  {$EXTERNALSYM IID_IDirect3DVertexBuffer8}
  IID_IDirect3DIndexBuffer8   = IDirect3DIndexBuffer8;
  {$EXTERNALSYM IID_IDirect3DIndexBuffer8}
  IID_IDirect3DSurface8       = IDirect3DSurface8;
  {$EXTERNALSYM IID_IDirect3DSurface8}
  IID_IDirect3DVolume8        = IDirect3DVolume8;
  {$EXTERNALSYM IID_IDirect3DVolume8}
  IID_IDirect3DSwapChain8     = IDirect3DSwapChain8;
  {$EXTERNALSYM IID_IDirect3DSwapChain8}


const
{****************************************************************************
 * Flags for SetPrivateData method on all D3D8 interfaces
 *
 * The passed pointer is an IUnknown ptr. The SizeOfData argument to SetPrivateData
 * must be set to sizeof(IUnknown*). Direct3D will call AddRef through this
 * pointer and Release when the private data is destroyed. The data will be
 * destroyed when another SetPrivateData with the same GUID is set, when
 * FreePrivateData is called, or when the D3D8 object is freed.
 ****************************************************************************}
  D3DSPD_IUNKNOWN                         = $00000001;
  {$EXTERNALSYM D3DSPD_IUNKNOWN}

(****************************************************************************
 *
 * Parameter for IDirect3D8 Enum and GetCaps8 functions to get the info for
 * the current mode only.
 *
 ****************************************************************************)

  D3DCURRENT_DISPLAY_MODE                 = $00EFFFFF;
  {$EXTERNALSYM D3DCURRENT_DISPLAY_MODE}

(****************************************************************************
 *
 * Flags for IDirect3D8::CreateDevice's BehaviorFlags
 *
 ****************************************************************************)

  D3DCREATE_FPU_PRESERVE                  = $00000002;
  {$EXTERNALSYM D3DCREATE_FPU_PRESERVE}
  D3DCREATE_MULTITHREADED                 = $00000004;
  {$EXTERNALSYM D3DCREATE_MULTITHREADED}

  D3DCREATE_PUREDEVICE                    = $00000010;
  {$EXTERNALSYM D3DCREATE_PUREDEVICE}
  D3DCREATE_SOFTWARE_VERTEXPROCESSING     = $00000020;
  {$EXTERNALSYM D3DCREATE_SOFTWARE_VERTEXPROCESSING}
  D3DCREATE_HARDWARE_VERTEXPROCESSING     = $00000040;
  {$EXTERNALSYM D3DCREATE_HARDWARE_VERTEXPROCESSING}
  D3DCREATE_MIXED_VERTEXPROCESSING        = $00000080;
  {$EXTERNALSYM D3DCREATE_MIXED_VERTEXPROCESSING}

  D3DCREATE_DISABLE_DRIVER_MANAGEMENT     = $00000100;
  {$EXTERNALSYM D3DCREATE_DISABLE_DRIVER_MANAGEMENT}


(****************************************************************************
 *
 * Parameter for IDirect3D8::CreateDevice's iAdapter
 *
 ****************************************************************************)

  D3DADAPTER_DEFAULT                      = 0;
  {$EXTERNALSYM D3DADAPTER_DEFAULT}

(****************************************************************************
 *
 * Flags for IDirect3D8::EnumAdapters
 *
 ****************************************************************************)

  D3DENUM_NO_WHQL_LEVEL                   = $00000002;
  {$EXTERNALSYM D3DENUM_NO_WHQL_LEVEL}

(****************************************************************************
 *
 * Maximum number of back-buffers supported in DX8
 *
 ****************************************************************************)

  D3DPRESENT_BACK_BUFFERS_MAX             = 3;
  {$EXTERNALSYM D3DPRESENT_BACK_BUFFERS_MAX}

(****************************************************************************
 *
 * Flags for IDirect3DDevice8::SetGammaRamp
 *
 ****************************************************************************)

  D3DSGR_NO_CALIBRATION                  = $00000000;
  {$EXTERNALSYM D3DSGR_NO_CALIBRATION}
  D3DSGR_CALIBRATE                       = $00000001;
  {$EXTERNALSYM D3DSGR_CALIBRATE}

(****************************************************************************
 *
 * Flags for IDirect3DDevice8::SetCursorPosition
 *
 ****************************************************************************)

  D3DCURSOR_IMMEDIATE_UPDATE             = $00000001;
  {$EXTERNALSYM D3DCURSOR_IMMEDIATE_UPDATE}

(****************************************************************************
 *
 * Flags for DrawPrimitive/DrawIndexedPrimitive
 *   Also valid for Begin/BeginIndexed
 *   Also valid for VertexBuffer::CreateVertexBuffer
 ****************************************************************************)


(*
 *  DirectDraw error codes
 *)
  _FACD3D = $876;
  {$EXTERNALSYM _FACD3D}

//#define MAKE_D3DHRESULT( code )  MAKE_HRESULT( 1, _FACD3D, code )
function MAKE_D3DHRESULT(Code: DWord): DWord;
{$EXTERNALSYM MAKE_D3DHRESULT}

const
  MAKE_D3DHRESULT_R     = (1 shl 31) or (_FACD3D shl 16);

(*
 * Direct3D Errors
 *)
  D3D_OK                                  = S_OK;
  {$EXTERNALSYM D3D_OK}

  D3DERR_WRONGTEXTUREFORMAT               = HResult(MAKE_D3DHRESULT_R or 2072);
  {$EXTERNALSYM D3DERR_WRONGTEXTUREFORMAT}
  D3DERR_UNSUPPORTEDCOLOROPERATION        = HResult(MAKE_D3DHRESULT_R or 2073);
  {$EXTERNALSYM D3DERR_UNSUPPORTEDCOLOROPERATION}
  D3DERR_UNSUPPORTEDCOLORARG              = HResult(MAKE_D3DHRESULT_R or 2074);
  {$EXTERNALSYM D3DERR_UNSUPPORTEDCOLORARG}
  D3DERR_UNSUPPORTEDALPHAOPERATION        = HResult(MAKE_D3DHRESULT_R or 2075);
  {$EXTERNALSYM D3DERR_UNSUPPORTEDALPHAOPERATION}
  D3DERR_UNSUPPORTEDALPHAARG              = HResult(MAKE_D3DHRESULT_R or 2076);
  {$EXTERNALSYM D3DERR_UNSUPPORTEDALPHAARG}
  D3DERR_TOOMANYOPERATIONS                = HResult(MAKE_D3DHRESULT_R or 2077);
  {$EXTERNALSYM D3DERR_TOOMANYOPERATIONS}
  D3DERR_CONFLICTINGTEXTUREFILTER         = HResult(MAKE_D3DHRESULT_R or 2078);
  {$EXTERNALSYM D3DERR_CONFLICTINGTEXTUREFILTER}
  D3DERR_UNSUPPORTEDFACTORVALUE           = HResult(MAKE_D3DHRESULT_R or 2079);
  {$EXTERNALSYM D3DERR_UNSUPPORTEDFACTORVALUE}
  D3DERR_CONFLICTINGRENDERSTATE           = HResult(MAKE_D3DHRESULT_R or 2081);
  {$EXTERNALSYM D3DERR_CONFLICTINGRENDERSTATE}
  D3DERR_UNSUPPORTEDTEXTUREFILTER         = HResult(MAKE_D3DHRESULT_R or 2082);
  {$EXTERNALSYM D3DERR_UNSUPPORTEDTEXTUREFILTER}
  D3DERR_CONFLICTINGTEXTUREPALETTE        = HResult(MAKE_D3DHRESULT_R or 2086);
  {$EXTERNALSYM D3DERR_CONFLICTINGTEXTUREPALETTE}
  D3DERR_DRIVERINTERNALERROR              = HResult(MAKE_D3DHRESULT_R or 2087);
  {$EXTERNALSYM D3DERR_DRIVERINTERNALERROR}

  D3DERR_NOTFOUND                         = HResult(MAKE_D3DHRESULT_R or 2150);
  {$EXTERNALSYM D3DERR_NOTFOUND}
  D3DERR_MOREDATA                         = HResult(MAKE_D3DHRESULT_R or 2151);
  {$EXTERNALSYM D3DERR_MOREDATA}
  D3DERR_DEVICELOST                       = HResult(MAKE_D3DHRESULT_R or 2152);
  {$EXTERNALSYM D3DERR_DEVICELOST}
  D3DERR_DEVICENOTRESET                   = HResult(MAKE_D3DHRESULT_R or 2153);
  {$EXTERNALSYM D3DERR_DEVICENOTRESET}
  D3DERR_NOTAVAILABLE                     = HResult(MAKE_D3DHRESULT_R or 2154);
  {$EXTERNALSYM D3DERR_NOTAVAILABLE}
  D3DERR_OUTOFVIDEOMEMORY                 = HResult(MAKE_D3DHRESULT_R or 380);
  {$EXTERNALSYM D3DERR_OUTOFVIDEOMEMORY}
  D3DERR_INVALIDDEVICE                    = HResult(MAKE_D3DHRESULT_R or 2155);
  {$EXTERNALSYM D3DERR_INVALIDDEVICE}
  D3DERR_INVALIDCALL                      = HResult(MAKE_D3DHRESULT_R or 2156);
  {$EXTERNALSYM D3DERR_INVALIDCALL}
  D3DERR_DRIVERINVALIDCALL                = HResult(MAKE_D3DHRESULT_R or 2157);
  {$EXTERNALSYM D3DERR_DRIVERINVALIDCALL}



(*
 * DLL Function for creating a Direct3D8 object. This object supports
 * enumeration and allows the creation of Direct3DDevice8 objects.
 * Pass the value of the constant D3D_SDK_VERSION to this function, so
 * that the run-time can validate that your application was compiled
 * against the right headers.
 *)

function Direct3D8Loaded: Boolean;
function LoadDirect3D8: Boolean;
function UnLoadDirect3D8: Boolean;

// Due to the way Object Pascal handles functions resulting in 'native' interface
// pointer we should declare result not as interface but as usial pointer

function _Direct3DCreate8(SDKVersion: LongWord): Pointer; stdcall;

function Direct3DCreate8(SDKVersion: LongWord): IDirect3D8; stdcall;
{$EXTERNALSYM Direct3DCreate8}


//********************************************************************
// Introduced types for compatibility with DirectXGraphics.pas translation
// by Ampaze (Tim Baumgarten) from http://www.crazyentertainment.net
type
  PD3DAdapter_Identifier8               = PD3DAdapterIdentifier8;
  PD3DDevice_Creation_Parameters        = PD3DDeviceCreationParameters;
  PD3DIndexBuffer_Desc                  = PD3DIndexBufferDesc;
  PD3DLocked_Box                        = PD3DLockedBox;
  PD3DLocked_Rect                       = PD3DLockedRect;
  PD3DPresent_Parameters                = PD3DPresentParameters;
  PD3DRaster_Status                     = PD3DRasterStatus;
  PD3DRectPatch_Info                    = PD3DRectPatchInfo;
  PD3DSurface_Desc                      = PD3DSurfaceDesc;
  PD3DTriPatch_Info                     = PD3DTriPatchInfo;
  PD3DVertexBuffer_Desc                 = PD3DVertexBufferDesc;
  PD3DVolume_Desc                       = PD3DVolumeDesc;

  TD3DAdapter_Identifier8               = TD3DAdapterIdentifier8;
  TD3DBackBuffer_Type                   = TD3DBackBufferType;
  TD3DCubeMap_Faces                     = TD3DCubeMapFaces;
  TD3DDevice_Creation_Parameters        = TD3DDeviceCreationParameters;
  TD3DIndexBuffer_Desc                  = TD3DIndexBufferDesc;
  TD3DLocked_Box                        = TD3DLockedBox;
  TD3DLocked_Rect                       = TD3DLockedRect;
  TD3DMultiSample_Type                  = TD3DMultiSampleType;
  TD3DPresent_Parameters                = TD3DPresentParameters;
  TD3DRaster_Status                     = TD3DRasterStatus;
  TD3DRectPatch_Info                    = TD3DRectPatchInfo;
  TD3DShader_Instruction_Opcode_Type    = TD3DShaderInstructionOpcodeType;
  TD3DShader_Param_DSTMod_Type          = TD3DShaderParamDSTModType;
  TD3DShader_Param_Register_Type        = TD3DShaderParamRegisterType;
  TD3DShader_Param_SRCMod_Type          = TD3DShaderParamSRCModType;
  TD3DSurface_Desc                      = TD3DSurfaceDesc;
  TD3DTriPatch_Info                     = TD3DTriPatchInfo;
  TD3DVertexBuffer_Desc                 = TD3DVertexBufferDesc;
  TD3DVolume_Desc                       = TD3DVolumeDesc;
  TD3DVSD_TokenType                     = TD3DVSDTokenType;
  TD3DVS_AddressMode_Type               = TD3DVSAddressModeType;
  TD3DVS_RastOut_Offsets                = TD3DVSRastOutOffsets;

  TD3DDevInfo_ResourceManager           = TD3DDevInfoResourceManager;
  TD3DDevInfo_D3DVertexStats            = TD3DDevInfoD3DVertexStats;

  PD3DDevInfo_ResourceManager           = PD3DDevInfoResourceManager;
  PD3DDevInfo_D3DVertexStats            = PD3DDevInfoD3DVertexStats;


implementation


(*==========================================================================;
 *  File:       d3d8types.h
 *  Content:    Direct3D capabilities include file
 ***************************************************************************)

// #define D3DCOLOR_ARGB(a,r,g,b) \
//     ((D3DCOLOR)((((a)&0xff)<<24)|(((r)&0xff)<<16)|(((g)&0xff)<<8)|((b)&0xff)))
function D3DCOLOR_ARGB(a,r,g,b: DWord): TD3DColor;
begin
  Result := (a shl 24) or (r shl 16) or (g shl 8) or b;
end;

// #define D3DCOLOR_RGBA(r,g,b,a) D3DCOLOR_ARGB(a,r,g,b)
function D3DCOLOR_RGBA(r,g,b,a: DWord): TD3DColor;
begin
  Result := (a shl 24) or (r shl 16) or (g shl 8) or b;
end;

// #define D3DCOLOR_XRGB(r,g,b)   D3DCOLOR_ARGB(0xff,r,g,b)
function D3DCOLOR_XRGB(r,g,b: DWord): TD3DColor;
begin
  Result := DWORD($FF shl 24) or (r shl 16) or (g shl 8) or b;
end;

// #define D3DCOLOR_COLORVALUE(r,g,b,a) \
//     D3DCOLOR_RGBA((DWORD)((r)*255.f),(DWORD)((g)*255.f),(DWORD)((b)*255.f),(DWORD)((a)*255.f))
function D3DCOLOR_COLORVALUE(r,g,b,a: Single): TD3DColor;
begin
  Result :=
    (round(a * 255) shl 24) or
    (round(r * 255) shl 16) or
    (round(g * 255) shl 8) or
    (round(b * 255));
end;

// #define D3DTS_WORLDMATRIX(index) (D3DTRANSFORMSTATETYPE)(index + 256)
function D3DTS_WORLDMATRIX(index: Byte): TD3DTransformStateType;
begin
  Result:= TD3DTransformStateType(index + 256);
end;

// D3DVSD_MAKETOKENTYPE(tokenType) ((tokenType << D3DVSD_TOKENTYPESHIFT) & D3DVSD_TOKENTYPEMASK)
function D3DVSD_MAKETOKENTYPE(tokenType: TD3DVSDTokenType): DWord;
begin
  Result:= ((DWord(tokenType) shl D3DVSD_TOKENTYPESHIFT) and D3DVSD_TOKENTYPEMASK);
end;

//#define D3DVSD_STREAM( _StreamNumber ) \
//    (D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_STREAM) | (_StreamNumber))
function D3DVSD_STREAM(_StreamNumber: DWord): DWord;
begin
  Result:= D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_STREAM) or _StreamNumber;
end;

//#define D3DVSD_REG( _VertexRegister, _Type ) \
//    (D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_STREAMDATA) |            \
//     ((_Type) << D3DVSD_DATATYPESHIFT) | (_VertexRegister))
function D3DVSD_REG( _VertexRegister, _Type: DWord): DWord;
begin
  Result:= D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_STREAMDATA) or ((_Type shl D3DVSD_DATATYPESHIFT) or _VertexRegister);
end;

//#define D3DVSD_SKIP( _DWORDCount ) \
//    (D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_STREAMDATA) | 0x10000000 | \
//     ((_DWORDCount) << D3DVSD_SKIPCOUNTSHIFT))
function D3DVSD_SKIP(_DWORDCount: DWord): DWord;
begin
  Result:= D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_STREAMDATA) or $10000000 or (_DWORDCount shl D3DVSD_SKIPCOUNTSHIFT);
end;

//#define D3DVSD_CONST( _ConstantAddress, _Count ) \
//    (D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_CONSTMEM) | \
//     ((_Count) << D3DVSD_CONSTCOUNTSHIFT) | (_ConstantAddress))
function D3DVSD_CONST(_ConstantAddress, _Count: DWord): DWord;
begin
  Result:= D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_CONSTMEM) or (_Count shl D3DVSD_CONSTCOUNTSHIFT) or _ConstantAddress;
end;

//#define D3DVSD_TESSNORMAL( _VertexRegisterIn, _VertexRegisterOut ) \
//    (D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_TESSELLATOR) | \
//     ((_VertexRegisterIn) << D3DVSD_VERTEXREGINSHIFT) | \
//     ((0x02) << D3DVSD_DATATYPESHIFT) | (_VertexRegisterOut))
function D3DVSD_TESSNORMAL(_VertexRegisterIn, _VertexRegisterOut: DWord): DWord;
begin
  Result:= D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_TESSELLATOR) or
           (_VertexRegisterIn shl D3DVSD_VERTEXREGINSHIFT) or
           ($02 shl D3DVSD_DATATYPESHIFT) or _VertexRegisterOut;
end;

//#define D3DVSD_TESSUV( _VertexRegister ) \
//    (D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_TESSELLATOR) | 0x10000000 | \
//     ((0x01) << D3DVSD_DATATYPESHIFT) | (_VertexRegister))
function D3DVSD_TESSUV(_VertexRegister: DWord): DWord;
begin
  Result:= D3DVSD_MAKETOKENTYPE(D3DVSD_TOKEN_TESSELLATOR) or $10000000 or
           ($01 shl D3DVSD_DATATYPESHIFT) or _VertexRegister;
end;

//#define D3DPS_VERSION(_Major,_Minor) (0xFFFF0000|((_Major)<<8)|(_Minor))
function D3DPS_VERSION(_Major, _Minor : Cardinal) : Cardinal;
begin
  Result:= $FFFF0000 or (_Major shl 8 ) or _Minor;
end;

//#define D3DVS_VERSION(_Major,_Minor) (0xFFFE0000|((_Major)<<8)|(_Minor))
function D3DVS_VERSION(_Major, _Minor : Cardinal) : Cardinal;
begin
  Result:= $FFFE0000 or (_Major shl 8 ) or _Minor;
end;

//#define D3DSHADER_VERSION_MAJOR(_Version) (((_Version)>>8)&0xFF)
function D3DSHADER_VERSION_MAJOR(_Version : Cardinal) : Cardinal;
begin
  Result:= (_Version shr 8 ) and $FF;
end;

//#define D3DSHADER_VERSION_MINOR(_Version) (((_Version)>>0)&0xFF)
function D3DSHADER_VERSION_MINOR(_Version : Cardinal) : Cardinal;
begin
  Result:= (_Version shr 0) and $FF;
end;

//#define D3DSHADER_COMMENT(_DWordSize) \
//    ((((_DWordSize)<<D3DSI_COMMENTSIZE_SHIFT)&D3DSI_COMMENTSIZE_MASK)|D3DSIO_COMMENT)
function D3DSHADER_COMMENT(_DWordSize: DWord) : DWord;
begin
  Result:= ((_DWordSize shl D3DSI_COMMENTSIZE_SHIFT) and D3DSI_COMMENTSIZE_MASK) or D3DSIO_COMMENT;
end;

//#define D3DFVF_TEXCOORDSIZE3(CoordIndex) (D3DFVF_TEXTUREFORMAT3 << (CoordIndex*2 + 16))
function D3DFVF_TEXCOORDSIZE3(CoordIndex: DWord): DWord;
begin
  Result:= D3DFVF_TEXTUREFORMAT3 shl (CoordIndex * 2 + 16)
end;

//#define D3DFVF_TEXCOORDSIZE2(CoordIndex) (D3DFVF_TEXTUREFORMAT2)
function D3DFVF_TEXCOORDSIZE2(CoordIndex: DWord): DWord;
begin
  Result:= D3DFVF_TEXTUREFORMAT2;
end;

//#define D3DFVF_TEXCOORDSIZE4(CoordIndex) (D3DFVF_TEXTUREFORMAT4 << (CoordIndex*2 + 16))
function D3DFVF_TEXCOORDSIZE4(CoordIndex: DWord): DWord;
begin
  Result:= D3DFVF_TEXTUREFORMAT4 shl (CoordIndex * 2 + 16)
end;

//#define D3DFVF_TEXCOORDSIZE1(CoordIndex) (D3DFVF_TEXTUREFORMAT1 << (CoordIndex*2 + 16))
function D3DFVF_TEXCOORDSIZE1(CoordIndex: DWord): DWord;
begin
  Result:= D3DFVF_TEXTUREFORMAT1 shl (CoordIndex * 2 + 16)
end;

//    #define MAKEFOURCC(ch0, ch1, ch2, ch3)                              \
//                ((DWORD)(BYTE)(ch0) | ((DWORD)(BYTE)(ch1) << 8) |       \
//                ((DWORD)(BYTE)(ch2) << 16) | ((DWORD)(BYTE)(ch3) << 24 ))
function MAKEFOURCC(ch0, ch1, ch2, ch3: Char): DWord;
begin
  Result:= Byte(ch0) or (Byte(ch1) shl 8) or (Byte(ch2) shl 16) or (Byte(ch3) shl 24 );
end;


(*==========================================================================;
 *  File:   d3d8.h
 *  Content:    Direct3D include file
 ****************************************************************************)

//#define MAKE_D3DHRESULT( code )  MAKE_HRESULT( 1, _FACD3D, code )
function MAKE_D3DHRESULT(Code: DWord): DWord;
begin
  Result:= DWord((1 shl 31) or (_FACD3D shl 16)) or Code;
end;

const
  Direct3D8dll = 'd3d8.dll';

function Direct3D8Loaded: Boolean;
begin // Stub function for static linking
  Result:= True;
end;

function UnLoadDirect3D8: Boolean;
begin // Stub function for static linking
  Result:= True; // should emulate "normal" behaviour
end;

function LoadDirect3D8: Boolean;
begin // Stub function for static linking
  Result:= True;
end;

function _Direct3DCreate8(SDKVersion: LongWord): Pointer; external Direct3D8dll name 'Direct3DCreate8';

function Direct3DCreate8(SDKVersion: LongWord): IDirect3D8;
begin
  Result:= IDirect3D8(_Direct3DCreate8(SDKVersion));
  if Assigned(Result) then Result._Release; // Delphi autoincrement reference count
end;

end.
