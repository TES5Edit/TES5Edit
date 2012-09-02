{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  File:       dxerr9.h                                                      *}
{*  Content:    DirectX Error Library Include File                            *}
{*                                                                            *}
{*  DirectX 9.0 Delphi / FreePascal adaptation by Alexey Barkovoy             *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://clootie.ru                                                       *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
{*----------------------------------------------------------------------------*}
{*  $Id: DXErr9.pas,v 1.8 2006/01/15 21:09:29 clootie Exp $ }
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

unit DXErr9;

interface

{$HPPEMIT '#include "dxerr9.h"'}

uses
  Windows;

(*==========================================================================;
 *
 *
 *  File:   dxerr9.h
 *  Content:    DirectX Error Library Include File
 *
 ****************************************************************************)

const
  //////////// DLL export definitions ///////////////////////////////////////
  dxerr9dll = 'dxerr9ab.dll';


type
  TDXGetError9A = function (hr: HRESULT): PAnsiChar; stdcall;
  TDXGetError9W = function (hr: HRESULT): PWideChar; stdcall;
  TDXGetError9 = TDXGetError9A;

function Dummy_DXGetError9A(hr: HRESULT): PAnsiChar; stdcall;
function Dummy_DXGetError9W(hr: HRESULT): PWideChar; stdcall;


//
//  DXGetErrorString9
//
//  Desc:  Converts a DirectX 9 or earlier HRESULT to a string
//
//  Args:  HRESULT hr   Can be any error code from
//                      D3D9 D3DX9 D3D8 D3DX8 DDRAW DPLAY8 DMUSIC DSOUND DINPUT DSHOW
//
//  Return: Converted string
//
var
  DXGetErrorString9A: TDXGetError9A = Dummy_DXGetError9A;
  DXGetErrorString9W: TDXGetError9W = Dummy_DXGetError9W;
  DXGetErrorString9: TDXGetError9 = Dummy_DXGetError9A;


//
//  DXGetErrorDescription9
//
//  Desc:  Returns a string description of a DirectX 9 or earlier HRESULT
//
//  Args:  HRESULT hr   Can be any error code from
//                      D3D9 D3DX9 D3D8 D3DX8 DDRAW DPLAY8 DMUSIC DSOUND DINPUT DSHOW
//
//  Return: String description
//
var
  DXGetErrorDescription9A: TDXGetError9A = Dummy_DXGetError9A;
  DXGetErrorDescription9W: TDXGetError9W = Dummy_DXGetError9W;
  DXGetErrorDescription9: TDXGetError9 = Dummy_DXGetError9A;


//
//  DXTrace
//
//  Desc:  Outputs a formatted error message to the debug stream
//
//  Args:  CHAR* strFile   The current file, typically passed in using the
//                         __FILE__ macro.
//         DWORD dwLine    The current line number, typically passed in using the
//                         __LINE__ macro.
//         HRESULT hr      An HRESULT that will be traced to the debug stream.
//         CHAR* strMsg    A string that will be traced to the debug stream (may be NULL)
//         BOOL bPopMsgBox If TRUE, then a message box will popup also containing the passed info.
//
//  Return: The hr that was passed in.
//
type
  TDXTraceA = function (strFile: PAnsiChar; dwLine: DWORD; hr: HRESULT; strMsg: PAnsiChar; bPopMsgBox: BOOL = FALSE): HRESULT; stdcall;
  TDXTraceW = function (strFile: PAnsiChar; dwLine: DWORD; hr: HRESULT; strMsg: PWideChar; bPopMsgBox: BOOL = FALSE): HRESULT; stdcall;
  TDXTrace = TDXTraceA;

function Dummy_DXTraceA(strFile: PAnsiChar; dwLine: DWORD; hr: HRESULT; strMsg: PAnsiChar; bPopMsgBox: BOOL = FALSE): HRESULT; stdcall;
function Dummy_DXTraceW(strFile: PAnsiChar; dwLine: DWORD; hr: HRESULT; strMsg: PWideChar; bPopMsgBox: BOOL = FALSE): HRESULT; stdcall;

var
  DXTraceA: TDXTraceA = Dummy_DXTraceA;
  DXTraceW: TDXTraceW = Dummy_DXTraceW;
  DXTrace: TDXTrace = Dummy_DXTraceA;


//
// Helper macros
//
function DXTRACE_MSG(str: PChar; FileName: PChar = nil; Line: DWORD = $FFFFFFFF): HRESULT; inline;
{$EXTERNALSYM DXTRACE_MSG}
function DXTRACE_ERR(str: PChar; hr: HRESULT; FileName: PChar = nil; Line: DWORD = $FFFFFFFF): HRESULT; inline;
{$EXTERNALSYM DXTRACE_ERR}
function DXTRACE_ERR_MSGBOX(str: PChar; hr: HRESULT; FileName: PChar = nil; Line: DWORD = $FFFFFFFF): HRESULT; inline;
{$EXTERNALSYM DXTRACE_ERR_MSGBOX}


implementation

uses SysUtils;

resourcestring
  SDXGetErrorString9 = dxerr9dll + ' library is not found. Description for 0x%x is not available.';

var
  TempStringA: AnsiString;
  TempStringW: WideString;

function Dummy_DXGetError9A(hr: HRESULT): PAnsiChar; stdcall;
begin
  TempStringA:= Format(SDXGetErrorString9, [hr]);
  Result:= PAnsiChar(TempStringA);
end;

function Dummy_DXGetError9W(hr: HRESULT): PWideChar; stdcall;
begin
  TempStringW:= WideFormat(SDXGetErrorString9, [hr]);
  Result:= PWideChar(TempStringW);
end;

function Dummy_DXTraceA(strFile: PAnsiChar; dwLine: DWORD; hr: HRESULT; strMsg: PAnsiChar; bPopMsgBox: BOOL = FALSE): HRESULT; stdcall;
begin
  Result:= hr;
end;

function Dummy_DXTraceW(strFile: PAnsiChar; dwLine: DWORD; hr: HRESULT; strMsg: PWideChar; bPopMsgBox: BOOL = FALSE): HRESULT; stdcall;
begin
  Result:= hr;
end;


function DXTRACE_MSG(str: PChar; FileName: PChar = nil; Line: DWORD = $FFFFFFFF): HRESULT;
begin Result:= 0; end;

function DXTRACE_ERR(str: PChar; hr: HRESULT; FileName: PChar = nil; Line: DWORD = $FFFFFFFF): HRESULT;
begin Result:= hr; end;

function DXTRACE_ERR_MSGBOX(str: PChar; hr: HRESULT; FileName: PChar = nil; Line: DWORD = $FFFFFFFF): HRESULT;
begin Result:= hr; end;

var
  dxerr9DllInstance: THandle = 0;
  temp: Pointer;

initialization
  dxerr9DllInstance := LoadLibrary(dxerr9dll);
  if (dxerr9DllInstance <> 0) then
  begin
    temp:= GetProcAddress(dxerr9DllInstance, 'DXGetErrorString9A'); if (temp<>nil) then DXGetErrorString9A:= temp;
    temp:= GetProcAddress(dxerr9DllInstance, 'DXGetErrorString9W'); if (temp<>nil) then DXGetErrorString9W:= temp;
    temp:= GetProcAddress(dxerr9DllInstance, 'DXGetErrorDescription9A'); if (temp<>nil) then DXGetErrorDescription9A:= temp;
    temp:= GetProcAddress(dxerr9DllInstance, 'DXGetErrorDescription9W'); if (temp<>nil) then DXGetErrorDescription9W:= temp;
    temp:= GetProcAddress(dxerr9DllInstance, 'DXTraceA'); if (temp<>nil) then DXTraceA:= temp;
    temp:= GetProcAddress(dxerr9DllInstance, 'DXTraceW'); if (temp<>nil) then DXTraceW:= temp;

    DXGetErrorString9 := DXGetErrorString9A;
    DXGetErrorDescription9 := DXGetErrorDescription9A;
    DXTrace := DXTraceA;
  end;
finalization
  if (dxerr9DllInstance <> 0) then
  begin
    FreeLibrary(dxerr9DllInstance);
    dxerr9DllInstance := 0;
  end;
end.
