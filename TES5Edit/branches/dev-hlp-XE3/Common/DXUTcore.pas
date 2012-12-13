(*----------------------------------------------------------------------------*
 *  DirectX 9 SDK December 2006 C++ common framework adaptation for Delphi    *
 *  by Alexey Barkovoy (e-mail: directx@clootie.ru)                           *
 *                                                                            *
 *  Desc: Direct3D part of framework.                                         *
 *  Supported compilers: Delphi 5,6,7,9 FreePascal 2.0                        *
 *                                                                            *
 *  Latest version can be downloaded from:                                    *
 *     http://www.clootie.ru                                                  *
 *     http://sourceforge.net/projects/delphi-dx9sdk                          *
 *----------------------------------------------------------------------------*
 *  $Id: DXUTcore.pas,v 1.17 2007/02/05 22:21:00 clootie Exp $
 *----------------------------------------------------------------------------*)
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

{$I DirectX.inc}

unit DXUTcore;

interface

uses
  Windows, Direct3D9, DXErr9, DXTypes;

type
{$IFDEF BORLAND}{$IFNDEF COMPILER6_UP}
  PBoolean = ^Boolean;
{$ENDIF}{$ENDIF}

{$IFDEF WIN64}
function PtrToUlong(p:Pointer): LongWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$ELSE}
  PtrToUlong = LongWord;
{$ENDIF}

function WideFormatBuf(var Buffer; BufLen: Cardinal; const Format: WideString; const Args: array of const): Cardinal; overload;

//-----------------------------------------------------------------------------
// Miscellaneous helper functions
//-----------------------------------------------------------------------------
//#define SAFE_DELETE(p)       { if(p) { delete (p);     (p)=NULL; } }
//#define SAFE_DELETE_ARRAY(p) { if(p) { delete[] (p);   (p)=NULL; } }
//#define SAFE_RELEASE(p)      { if(p) { (p)->Release(); (p)=NULL; } }

procedure FreeAndNil(var Obj);{$IFNDEF DELPHI10}{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}{$ENDIF}
procedure SAFE_RELEASE(var i);{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
procedure SAFE_DELETE(var Obj);{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
procedure SAFE_FREEMEM(var p);{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}

//--------------------------------------------------------------------------------------
// Debug printing support
// See dxerr9.h for more debug printing support
//--------------------------------------------------------------------------------------
procedure DXUTOutputDebugString(strMsg: PWideChar; const args: array of const); //Clootie: By default we aim for UNICODE 
procedure DXUTOutputDebugStringA(strMsg: PAnsiChar; const args: array of const);
var DXUTOutputDebugStringW: procedure (strMsg: PWideChar; const args: array of const) = DXUTOutputDebugString;

function DXUTTrace(const strFile: PChar; dwLine: DWORD; hr: HRESULT; const strMsg: PWideChar; bPopMsgBox: Boolean): HRESULT; stdcall;

// These macros are very similar to dxerr9's but it special cases the HRESULT defined
// by the sample framework pop better message boxes.
function DXUT_ERR(str: PWideChar; hr: HRESULT; FileName: PChar = nil; Line: DWORD = $FFFFFFFF): HRESULT;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
function DXUT_ERR_MSGBOX(str: PWideChar; hr: HRESULT; FileName: PChar = nil; Line: DWORD = $FFFFFFFF): HRESULT;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
procedure DXUT_TRACE(strMsg: PWideChar; args: array of const);


(*
#if defined(DEBUG) | defined(_DEBUG)
    #define V(x)           { hr = x; if( FAILED(hr) ) { DXUTTrace( __FILE__, (DWORD)__LINE__, hr, L#x, true ); } }
    #define V_RETURN(x)    { hr = x; if( FAILED(hr) ) { return DXUTTrace( __FILE__, (DWORD)__LINE__, hr, L#x, true ); } }
#else
    #define V(x)           { hr = x; }
    #define V_RETURN(x)    { hr = x; if( FAILED(hr) ) { return hr; } }
#endif
*)

function V_Failed(Status: HRESULT): BOOL;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF} //Clootie: instead of "V_RETURN"
function V_(Status: HRESULT): HRESULT;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
function V(Status: HRESULT): HRESULT;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$IFDEF FPC}
  {$DEFINE D5_OR_FPC}
{$ENDIF}
{$IFDEF BORLAND}{$IFNDEF COMPILER6_UP}
    {$DEFINE D5_OR_FPC}
{$ENDIF}{$ENDIF}
{$IFDEF D5_OR_FPC}
function WideFormat(const FormatS: WideString; const Args: array of const): WideString;
function WideFormatBuf(var Buffer; BufLen: Cardinal; const FormatBuf; iFormatLength: Integer; const Args: array of const): Cardinal; overload;
{$ENDIF}

implementation

uses SysUtils, Math, DXUT, StrSafe;

{$IFDEF WIN64}
function PtrToUlong(p:Pointer): LongWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  Result:= LongWord(ULONG_PTR(p));
end;
{$ENDIF}

{$IFDEF D5_OR_FPC}
function WideFormat(const FormatS: WideString; const Args: array of const): WideString;
var
  S: String;
begin
  S:= Format(FormatS, Args);
  //this is to hack bugged FPC WideString implementation...
  Result:= S + '_';
  Result[Length(S)+1]:= #0;
  SetLength(Result, Length(S));
end;

function WideFormatBuf(var Buffer; BufLen: Cardinal; const FormatBuf; iFormatLength: Integer; const Args: array of const): Cardinal; overload;
var
  l: Integer;
  S: WideString;
{$IFDEF FPC}
  S1: String;
  i: Integer;
{$ENDIF}
begin
{$IFDEF FPC}
//This is FPC debug code snippet
  for i:= 0 to High(Args) do
  begin
    if (Args[i].Vtype = vtPointer) or
       (Args[i].Vtype = vtObject) or
       (Args[i].Vtype = vtClass) or
       (Args[i].Vtype = vtVariant)
      then // == 5
    begin
      S1:= PWideChar(@FormatBuf);
      MessageBox(0, PChar('Pointer passed to WideFormatBuf with format:'#10'"' + S1 + '"'), 'Warning', mb_ok or mb_iconerror);
      Break;
    {if (Args[i].Vtype = vtPWideChar) or
       (Args[i].Vtype = vtWideChar) or
       (Args[i].Vtype = vtWidestring) then }
    end;
  end;

// MessageBoxW(0, PWideChar(WideString(PWideChar(@FormatBuf)) + ' >> '#10+ S + #10'Number is:' + IntToStr(Length(Args))), '-- Point 8.3 --', 0);
{$ENDIF}

  S:= WideFormat(PWideChar(@FormatBuf), Args);
  l:= Min(Length(S)*2, Integer(BufLen)-2);
  Move(S[1], Buffer, l+2);
  Result:= l div 2;
end;

{$ENDIF}

function WideFormatBuf(var Buffer; BufLen: Cardinal; const Format: WideString; const Args: array of const): Cardinal; overload;
begin
  Result:= {$IFNDEF D5_OR_FPC}SysUtils.{$ENDIF}WideFormatBuf(Buffer, BufLen, Format[1], Length(Format), Args);
end;

procedure FreeAndNil(var Obj);{$IFNDEF DELPHI10}{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}{$ENDIF}
var
  Temp: TObject;
begin
  Temp := TObject(Obj);
  Pointer(Obj) := nil;
  Temp.Free;
end;

procedure SAFE_RELEASE(var i);{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  if IUnknown(i) <> nil then IUnknown(i):= nil;
end;

procedure SAFE_DELETE(var Obj);{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
var
  Temp: TObject;
begin
  Temp:= TObject(Obj);
  Pointer(Obj):= nil;
  Temp.Free;
end;

procedure SAFE_FREEMEM(var p);{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  if (Pointer(p) <> nil) then
  begin
    FreeMem(Pointer(p));
    Pointer(p):= nil;
  end;
end;


//--------------------------------------------------------------------------------------
// Outputs to the debug stream a formatted Unicode string with a variable-argument list.
//--------------------------------------------------------------------------------------
procedure DXUTOutputDebugString(strMsg: PWideChar; const args: array of const);
{$IFDEF DEBUG}
var
  strBuffer: array[0..511] of WideChar;
{$ENDIF}
begin
{$IFDEF DEBUG}
  StringCchFormat(strBuffer, 512, strMsg, args);

  OutputDebugStringW(strBuffer);
{$ELSE}
   // Do nothing
{$ENDIF}
end;

//--------------------------------------------------------------------------------------
// Outputs to the debug stream a formatted MBCS string with a variable-argument list.
//--------------------------------------------------------------------------------------
procedure DXUTOutputDebugStringA(strMsg: PAnsiChar; const args: array of const);
{$IFDEF DEBUG}
var
  strBuffer: array[0..511] of AnsiChar;
{$ENDIF}
begin
{$IFDEF DEBUG}
  StringCchFormat(strBuffer, 512, strMsg, args);

  OutputDebugStringA(strBuffer);
{$ELSE}
   // Do nothing
{$ENDIF} 
end;


//--------------------------------------------------------------------------------------
// Display error msg box to help debug
//--------------------------------------------------------------------------------------
function DXUTTrace(const strFile: PChar; dwLine: DWORD; hr: HRESULT; const strMsg: PWideChar; bPopMsgBox: Boolean): HRESULT; stdcall;
var
  bShowMsgBoxOnError: Boolean;
begin
  bShowMsgBoxOnError := GetDXUTState.ShowMsgBoxOnError; 
  if not (bPopMsgBox and bShowMsgBoxOnError) then bPopMsgBox := False;

  Result:= DXTraceW(strFile, dwLine, hr, strMsg, bPopMsgBox);
end;


{$IFDEF DEBUG}
function DXUT_ERR(str: PWideChar; hr: HRESULT; FileName: PChar = nil; Line: DWORD = $FFFFFFFF): HRESULT;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  Result:= DXUTTrace(FileName, Line, hr, str, False);
end;

function DXUT_ERR_MSGBOX(str: PWideChar; hr: HRESULT; FileName: PChar = nil; Line: DWORD = $FFFFFFFF): HRESULT;
begin
  Result:= DXUTTrace(FileName, Line, hr, str, True);
end;

procedure DXUT_TRACE(strMsg: PWideChar; args: array of const);
begin
  DXUTOutputDebugString(strMsg, args);
end;
{$ELSE}
function DXUT_ERR(str: PWideChar; hr: HRESULT; FileName: PChar = nil; Line: DWORD = $FFFFFFFF): HRESULT;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin Result:= hr; end;

function DXUT_ERR_MSGBOX(str: PWideChar; hr: HRESULT; FileName: PChar = nil; Line: DWORD = $FFFFFFFF): HRESULT;
begin Result:= hr; end;

procedure DXUT_TRACE(strMsg: PWideChar; args: array of const);
begin end;
{$ENDIF}


{$IFDEF DEBUG}
function V_Failed(Status: HRESULT): BOOL;
begin
  Result := Status and HRESULT($80000000) <> 0;

  if Result then DXUTTrace('DXUTxxx', DWORD(-1), Status, PWideChar(WideString(IntToHex(Status, 8))), True);
end;

function V_(Status: HRESULT): HRESULT;
begin
  Result:= Status;
  if FAILED(Result) then DXUTTrace('DXUTxxx', DWORD(-1), Status, PWideChar(WideString(IntToHex(Status, 8))), True);
end;

function V(Status: HRESULT): HRESULT;
begin
  Result:= Status;
  if FAILED(Result) then DXUTTrace('DXUTxxx', DWORD(-1), Status, PWideChar(WideString(IntToHex(Status, 8))), True);
end;
{$ELSE}
function V_Failed(Status: HRESULT): BOOL;
begin
  Result := Failed(Status);
end;

function V_(Status: HRESULT): HRESULT;
begin
  Result:= Status;
end;

function V(Status: HRESULT): HRESULT;
begin
  Result:= Status;
end;
{$ENDIF}

end.

