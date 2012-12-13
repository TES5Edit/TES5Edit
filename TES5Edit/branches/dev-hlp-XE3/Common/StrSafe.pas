(*----------------------------------------------------------------------------*
 *  DirectX 9 SDK August 2005 C++ common framework adaptation for Delphi      *
 *  by Alexey Barkovoy (e-mail: directx@clootie.ru)                           *
 *                                                                            *
 *  Desc: Helper routines to simulate MS defined module strsafe (safer C      *
 *        library string routine replacements                                 *
 *  Supported compilers: Delphi 5,6,7,9 FreePascal 2.0                        *
 *                                                                            *
 *  Latest version can be downloaded from:                                    *
 *     http://www.clootie.ru                                                  *
 *     http://sourceforge.net/projects/delphi-dx9sdk                          *
 *----------------------------------------------------------------------------*
 *  $Id: StrSafe.pas,v 1.10 2005/12/30 21:36:03 clootie Exp $
 *----------------------------------------------------------------------------*)

unit StrSafe;

{$I JEDI.inc}

interface

{$IFDEF COMPILER7_UP}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
{$ENDIF}

uses Windows;

(******************************************************************
*                                                                 *
*  strsafe.h -- This module defines safer C library string        *
*               routine replacements. These are meant to make C   *
*               a bit more safe in reference to security and      *
*               robustness                                        *
*                                                                 *
*  Copyright (c) Microsoft Corp.  All rights reserved.            *
*                                                                 *
******************************************************************)

const
  STRSAFE_MAX_CCH  = 2147483647; // max # of characters we support (same as INT_MAX)

  // STRSAFE error return codes
  //
  STRSAFE_E_INSUFFICIENT_BUFFER       = HRESULT($8007007A);  // 0x7A = 122L = ERROR_INSUFFICIENT_BUFFER
  STRSAFE_E_INVALID_PARAMETER         = HRESULT($80070057);  // 0x57 =  87L = ERROR_INVALID_PARAMETER
  STRSAFE_E_END_OF_FILE               = HRESULT($80070026);  // 0x26 =  38L = ERROR_HANDLE_EOF

type
{$IFDEF WIN64}
  size_t = Int64; // should be: UInt64
{$ELSE}
  size_t = Cardinal;
{$ENDIF}

{$IFNDEF STRSAFE_NO_CCH_FUNCTIONS}
(*++

STDAPI
StringCchCopy(
    OUT LPTSTR  pszDest,
    IN  size_t  cchDest,
    IN  LPCTSTR pszSrc
    );

Routine Description:

    This routine is a safer version of the C built-in function 'strcpy'.
    The size of the destination buffer (in characters) is a parameter and
    this function will not write past the end of this buffer and it will
    ALWAYS null terminate the destination buffer (unless it is zero length).

    This routine is not a replacement for strncpy.  That function will pad the
    destination string with extra null termination characters if the count is
    greater than the length of the source string, and it will fail to null
    terminate the destination string if the source string length is greater
    than or equal to the count. You can not blindly use this instead of strncpy:
    it is common for code to use it to "patch" strings and you would introduce
    errors if the code started null terminating in the middle of the string.

    This function returns a hresult, and not a pointer.  It returns
    S_OK if the string was copied without truncation and null terminated,
    otherwise it will return a failure code. In failure cases as much of
    pszSrc will be copied to pszDest as possible, and pszDest will be null
    terminated.

Arguments:

    pszDest        -   destination string

    cchDest        -   size of destination buffer in characters.
                       length must be = (_tcslen(src) + 1) to hold all of the
                       source including the null terminator

    pszSrc         -   source string which must be null terminated

Notes:
    Behavior is undefined if source and destination strings overlap.

    pszDest and pszSrc should not be NULL. See StringCchCopyEx if you require
    the handling of NULL values.

Return Value:

    S_OK           -   if there was source data and it was all copied and the
                       resultant dest string was null terminated

    failure        -   you can use the macro HRESULT_CODE() to get a win32
                       error code for all hresult failure cases

      STRSAFE_E_INSUFFICIENT_BUFFER /
      HRESULT_CODE(hr) == ERROR_INSUFFICIENT_BUFFER
                   -   this return value is an indication that the copy
                       operation failed due to insufficient space. When this
                       error occurs, the destination buffer is modified to
                       contain a truncated version of the ideal result and is
                       null terminated. This is useful for situations where
                       truncation is ok

    It is strongly recommended to use the SUCCEEDED() / FAILED() macros to test the
    return value of this function.

--*)

function StringCchCopy(pszDest: PAnsiChar; cchDest: size_t; const pszSrc: PAnsiChar): HRESULT; overload;
{$IFDEF COMPILER5}
function StringCchCopy(pszDest: PAnsiChar; cchDest: size_t; const pszSrc: AnsiString): HRESULT; overload;
{$ENDIF}
function StringCchCopy(pszDest: PWideChar; cchDest: size_t; const pszSrc: PWideChar): HRESULT; overload;
{$IFNDEF FPC}
function StringCchCopy(pszDest: PWideChar; cchDest: size_t; const pszSrc: WideString): HRESULT; overload;
{$ENDIF}

{$ENDIF}  // !STRSAFE_NO_CCH_FUNCTIONS


{$IFNDEF STRSAFE_NO_CCH_FUNCTIONS}
(*++

STDAPI
StringCchCat(
    IN OUT LPTSTR  pszDest,
    IN     size_t  cchDest,
    IN     LPCTSTR pszSrc
    );

Routine Description:

    This routine is a safer version of the C built-in function 'strcat'.
    The size of the destination buffer (in characters) is a parameter and this
    function will not write past the end of this buffer and it will ALWAYS
    null terminate the destination buffer (unless it is zero length).

    This function returns a hresult, and not a pointer.  It returns
    S_OK if the string was concatenated without truncation and null terminated,
    otherwise it will return a failure code. In failure cases as much of pszSrc
    will be appended to pszDest as possible, and pszDest will be null
    terminated.

Arguments:

    pszDest     -  destination string which must be null terminated

    cchDest     -  size of destination buffer in characters.
                   length must be = (_tcslen(pszDest) + _tcslen(pszSrc) + 1)
                   to hold all of the combine string plus the null
                   terminator

    pszSrc      -  source string which must be null terminated

Notes:
    Behavior is undefined if source and destination strings overlap.

    pszDest and pszSrc should not be NULL.  See StringCchCatEx if you require
    the handling of NULL values.

Return Value:

    S_OK           -   if there was source data and it was all concatenated and
                       the resultant dest string was null terminated

    failure        -   you can use the macro HRESULT_CODE() to get a win32
                       error code for all hresult failure cases

      STRSAFE_E_INSUFFICIENT_BUFFER /
      HRESULT_CODE(hr) == ERROR_INSUFFICIENT_BUFFER
                   -   this return value is an indication that the operation
                       failed due to insufficient space. When this error occurs,
                       the destination buffer is modified to contain a truncated
                       version of the ideal result and is null terminated. This
                       is useful for situations where truncation is ok.

    It is strongly recommended to use the SUCCEEDED() / FAILED() macros to test the
    return value of this function

--*)

{$IFDEF COMPILER5}
function StringCchCat(pszDest: PAnsiChar; cchDest: size_t; const pszSrc: String): HRESULT; overload;
{$ENDIF}
function StringCchCat(pszDest: PAnsiChar; cchDest: size_t; const pszSrc: PAnsiChar): HRESULT; overload;
function StringCchCat(pszDest: PWideChar; cchDest: size_t; const pszSrc: PWideChar): HRESULT; overload;
{$IFNDEF FPC}
function StringCchCat(pszDest: PWideChar; cchDest: size_t; const pszSrc: WideString): HRESULT; overload;
{$ENDIF}
{$ENDIF}  // !STRSAFE_NO_CCH_FUNCTIONS

{$IFNDEF STRSAFE_NO_CCH_FUNCTIONS}
(*++

STDAPI
StringCchVPrintf(
    OUT LPTSTR  pszDest,
    IN  size_t  cchDest,
    IN  LPCTSTR pszFormat,
    IN  va_list argList
    );

Routine Description:

    This routine is a safer version of the C built-in function 'vsprintf'.
    The size of the destination buffer (in characters) is a parameter and
    this function will not write past the end of this buffer and it will
    ALWAYS null terminate the destination buffer (unless it is zero length).

    This function returns a hresult, and not a pointer.  It returns
    S_OK if the string was printed without truncation and null terminated,
    otherwise it will return a failure code. In failure cases it will return
    a truncated version of the ideal result.

Arguments:

    pszDest     -  destination string

    cchDest     -  size of destination buffer in characters
                   length must be sufficient to hold the resulting formatted
                   string, including the null terminator.

    pszFormat   -  format string which must be null terminated

    argList     -  va_list from the variable arguments according to the
                   stdarg.h convention

Notes:
    Behavior is undefined if destination, format strings or any arguments
    strings overlap.

    pszDest and pszFormat should not be NULL.  See StringCchVPrintfEx if you
    require the handling of NULL values.

Return Value:

    S_OK           -   if there was sufficient space in the dest buffer for
                       the resultant string and it was null terminated.

    failure        -   you can use the macro HRESULT_CODE() to get a win32
                       error code for all hresult failure cases

      STRSAFE_E_INSUFFICIENT_BUFFER /
      HRESULT_CODE(hr) == ERROR_INSUFFICIENT_BUFFER
                   -   this return value is an indication that the print
                       operation failed due to insufficient space. When this
                       error occurs, the destination buffer is modified to
                       contain a truncated version of the ideal result and is
                       null terminated. This is useful for situations where
                       truncation is ok.

    It is strongly recommended to use the SUCCEEDED() / FAILED() macros to test the
    return value of this function

--*)

function StringCchFormat(pszDest: PAnsiChar; cchDest: size_t; const pszFormat: PAnsiChar; Args: array of const): HRESULT; overload;
function StringCchFormat(pszDest: PWideChar; cchDest: size_t; const pszFormat: PWideChar; Args: array of const): HRESULT; overload;
{$IFNDEF FPC}
function StringCchFormat(pszDest: PWideChar; cchDest: size_t; const pszFormat: WideString; Args: array of const): HRESULT; overload;
{$ENDIF}

{$ENDIF}  // !STRSAFE_NO_CCH_FUNCTIONS

{$IFNDEF STRSAFE_NO_CCH_FUNCTIONS}
(*++

STDAPI
StringCchLength(
    IN  LPCTSTR psz,
    IN  size_t  cchMax,
    OUT size_t* pcch    OPTIONAL
    );

Routine Description:

    This routine is a safer version of the C built-in function 'strlen'.
    It is used to make sure a string is not larger than a given length, and
    it optionally returns the current length in characters not including
    the null terminator.

    This function returns a hresult, and not a pointer.  It returns
    S_OK if the string is non-null and the length including the null
    terminator is less than or equal to cchMax characters.

Arguments:

    psz         -   string to check the length of

    cchMax      -   maximum number of characters including the null terminator
                    that psz is allowed to contain

    pcch        -   if the function succeeds and pcch is non-null, the current length
                    in characters of psz excluding the null terminator will be returned.
                    This out parameter is equivalent to the return value of strlen(psz)

Notes:
    psz can be null but the function will fail

    cchMax should be greater than zero or the function will fail

Return Value:

    S_OK           -   psz is non-null and the length including the null
                       terminator is less than or equal to cchMax characters

    failure        -   you can use the macro HRESULT_CODE() to get a win32
                       error code for all hresult failure cases

    It is strongly recommended to use the SUCCEEDED() / FAILED() macros to test the
    return value of this function.

--*)

function StringCchLength(const psz: PAnsiChar; cchMax: size_t; out pcch: size_t): HRESULT; overload;
function StringCchLength(const psz: PWideChar; cchMax: size_t; out pcch: size_t): HRESULT; overload;

{$ENDIF}  // !STRSAFE_NO_CCH_FUNCTIONS

{$IFNDEF STRSAFE_NO_CB_FUNCTIONS}
(*++

STDAPI
StringCbLength(
    IN  LPCTSTR psz,
    IN  size_t  cbMax,
    OUT size_t* pcb     OPTIONAL
    );

Routine Description:

    This routine is a safer version of the C built-in function 'strlen'.
    It is used to make sure a string is not larger than a given length, and
    it optionally returns the current length in bytes not including
    the null terminator.

    This function returns a hresult, and not a pointer.  It returns
    S_OK if the string is non-null and the length including the null
    terminator is less than or equal to cbMax bytes.

Arguments:

    psz         -   string to check the length of

    cbMax       -   maximum number of bytes including the null terminator
                    that psz is allowed to contain

    pcb         -   if the function succeeds and pcb is non-null, the current length
                    in bytes of psz excluding the null terminator will be returned.
                    This out parameter is equivalent to the return value of strlen(psz) * sizeof(TCHAR)

Notes:
    psz can be null but the function will fail

    cbMax should be greater than or equal to sizeof(TCHAR) or the function will fail

Return Value:

    S_OK           -   psz is non-null and the length including the null
                       terminator is less than or equal to cbMax bytes

    failure        -   you can use the macro HRESULT_CODE() to get a win32
                       error code for all hresult failure cases

    It is strongly recommended to use the SUCCEEDED() / FAILED() macros to test the
    return value of this function.

--*)
function StringCbLength(const psz: PAnsiChar; cbMax: size_t; out pcb: size_t): HRESULT; overload;
function StringCbLength(const psz: PWideChar; cbMax: size_t; out pcb: size_t): HRESULT; overload;

{$ENDIF}  // !STRSAFE_NO_CB_FUNCTIONS


implementation


uses
  SysUtils{$IFDEF FPC}, DXUTcore{$ENDIF}{$IFDEF COMPILER5}, DXUTcore{$ENDIF};



// these are the worker functions that actually do the work
function StringCopyWorkerA(pszDest: PAnsiChar; cchDest: size_t; {pointer to const} pszSrc: PAnsiChar): HRESULT;
begin
  Assert(Assigned(pszSrc));
  Result := S_OK;

  if (cchDest = 0) then
  begin
    // can not null terminate a zero-byte dest buffer
    Result := STRSAFE_E_INVALID_PARAMETER;
  end else
  begin
    while (cchDest <> 0) and (pszSrc^ <> #0) do
    begin
      pszDest^ := pszSrc^;
      Inc(pszDest); Inc(pszSrc);
      Dec(cchDest);
    end;

    if (cchDest = 0) then
    begin
      // we are going to truncate pszDest
      Dec(pszDest);
      Result := STRSAFE_E_INSUFFICIENT_BUFFER;
    end;

    pszDest^ := #0;
  end;
end;

function StringCopyWorkerW(pszDest: PWideChar; cchDest: size_t; {pointer to const} pszSrc: PWideChar): HRESULT;
begin
  Assert(Assigned(pszSrc));
  Result := S_OK;

  if (cchDest = 0) then
  begin
    // can not null terminate a zero-byte dest buffer
    Result := STRSAFE_E_INVALID_PARAMETER;
  end else
  begin
    while (cchDest <> 0) and (pszSrc^ <> #0) do
    begin
      pszDest^ := pszSrc^;
      Inc(pszDest); Inc(pszSrc);
      Dec(cchDest);
    end;

    if (cchDest = 0) then
    begin
      // we are going to truncate pszDest
      Dec(pszDest);
      Result := STRSAFE_E_INSUFFICIENT_BUFFER;
    end;

    pszDest^ := #0;
  end;
end;


{$IFNDEF STRSAFE_NO_CCH_FUNCTIONS}
function StringCchCopy(pszDest: PAnsiChar; cchDest: size_t; const pszSrc: PAnsiChar): HRESULT;
begin
  if (cchDest > STRSAFE_MAX_CCH) then
  begin
    Result := STRSAFE_E_INVALID_PARAMETER;
    Exit;
  end;

  Result := StringCopyWorkerA(pszDest, cchDest, pszSrc);
end;

{$IFDEF COMPILER5}
function StringCchCopy(pszDest: PAnsiChar; cchDest: size_t; const pszSrc: AnsiString): HRESULT; overload;
begin
  if (cchDest > STRSAFE_MAX_CCH) then
  begin
    Result := STRSAFE_E_INVALID_PARAMETER;
    Exit;
  end;

  Result := StringCopyWorkerA(pszDest, cchDest, PAnsiChar(pszSrc));
end;
{$ENDIF}

function StringCchCopy(pszDest: PWideChar; cchDest: size_t; const pszSrc: PWideChar): HRESULT;
begin
  if (cchDest > STRSAFE_MAX_CCH) then
  begin
    Result := STRSAFE_E_INVALID_PARAMETER;
    Exit;
  end;

  Result := StringCopyWorkerW(pszDest, cchDest, pszSrc);
end;

{$IFNDEF FPC}
function StringCchCopy(pszDest: PWideChar; cchDest: size_t; const pszSrc: WideString): HRESULT;
begin
  Result := StringCchCopy(pszDest, cchDest, PWideChar(pszSrc));
end;
{$ENDIF}
{$ENDIF}  // !STRSAFE_NO_CCH_FUNCTIONS


function StringLengthWorker({pointer to const} psz: PAnsiChar; cchMax: size_t; out pcch: size_t): HRESULT; overload;
var
  cchMaxPrev: size_t;
begin
  Result := S_OK;
  cchMaxPrev := cchMax;

  while (cchMax <> 0) and (psz^ <> #0) do
  begin
    Inc(psz);
    Dec(cchMax);
  end;

  if (cchMax = 0) then
  begin
    // the string is longer than cchMax
    Result := STRSAFE_E_INVALID_PARAMETER;
  end;

  if SUCCEEDED(Result) then
  begin
    pcch := cchMaxPrev - cchMax;
  end;
end;

function StringLengthWorker({pointer to const} psz: PWideChar; cchMax: size_t; out pcch: size_t): HRESULT; overload;
var
  cchMaxPrev: size_t;
begin
  Result := S_OK;
  cchMaxPrev := cchMax;

  while (cchMax <> 0) and (psz^ <> #0) do
  begin
    Inc(psz);
    Dec(cchMax);
  end;

  if (cchMax = 0) then
  begin
    // the string is longer than cchMax
    Result := STRSAFE_E_INVALID_PARAMETER;
  end;

  if SUCCEEDED(Result) then
  begin
    pcch := cchMaxPrev - cchMax;
  end;
end;

function StringCopyWorker(pszDest: PAnsiChar; cchDest: size_t; {pointer to const} pszSrc: PAnsiChar): HRESULT; overload;
begin
  Result := S_OK;

  if (cchDest = 0) then
  begin
    // can not null terminate a zero-byte dest buffer
    Result := STRSAFE_E_INVALID_PARAMETER;
  end else
  begin
    while (cchDest <> 0) and (pszSrc^ <> #0) do
    begin
      pszDest^ := pszSrc^;
      Inc(pszDest); Inc(pszSrc);
      Dec(cchDest);
    end;

    if (cchDest = 0) then
    begin
      // we are going to truncate pszDest
      Dec(pszDest);
      Result := STRSAFE_E_INSUFFICIENT_BUFFER;
    end;

    pszDest^:= #0;
  end;
end;
function StringCopyWorker(pszDest: PWideChar; cchDest: size_t; {pointer to const} pszSrc: PWideChar): HRESULT; overload;
begin
  Result := S_OK;

  if (cchDest = 0) then
  begin
    // can not null terminate a zero-byte dest buffer
    Result := STRSAFE_E_INVALID_PARAMETER;
  end else
  begin
    while (cchDest <> 0) and (pszSrc^ <> #0) do
    begin
      pszDest^ := pszSrc^;
      Inc(pszDest); Inc(pszSrc);
      Dec(cchDest);
    end;

    if (cchDest = 0) then
    begin
      // we are going to truncate pszDest
      Dec(pszDest);
      Result := STRSAFE_E_INSUFFICIENT_BUFFER;
    end;

    pszDest^:= #0;
  end;
end;

{$IFNDEF STRSAFE_NO_CCH_FUNCTIONS}
function StringCchCatWorker(pszDest: PAnsiChar; cchDest: size_t; const pszSrc: PAnsiChar): HRESULT; overload;
var
  cchDestCurrent: size_t;
begin
  Result := StringLengthWorker(pszDest, cchDest, cchDestCurrent);

  if SUCCEEDED(Result) then
  begin
    Result := StringCopyWorker(pszDest + cchDestCurrent,
                               cchDest - cchDestCurrent,
                               pszSrc);
  end;
end;

function StringCchCatWorker(pszDest: PWideChar; cchDest: size_t; const pszSrc: PWideChar): HRESULT; overload;
var
  cchDestCurrent: size_t;
begin
  Result := StringLengthWorker(pszDest, cchDest, cchDestCurrent);

  if SUCCEEDED(Result) then
  begin
    Result := StringCopyWorker(pszDest + cchDestCurrent,
                               cchDest - cchDestCurrent,
                               pszSrc);
  end;
end;
{$ENDIF}  // !STRSAFE_NO_CCH_FUNCTIONS

{$IFNDEF STRSAFE_NO_CCH_FUNCTIONS}
{$IFDEF COMPILER5}
function StringCchCat(pszDest: PAnsiChar; cchDest: size_t; const pszSrc: String): HRESULT; overload;
begin
  if (cchDest > STRSAFE_MAX_CCH)
  then Result := STRSAFE_E_INVALID_PARAMETER
  else Result := StringCchCatWorker(pszDest, cchDest, PAnsiChar(pszSrc));
end;
{$ENDIF}

function StringCchCat(pszDest: PAnsiChar; cchDest: size_t; const pszSrc: PAnsiChar): HRESULT; overload;
begin
  if (cchDest > STRSAFE_MAX_CCH)
  then Result := STRSAFE_E_INVALID_PARAMETER
  else Result := StringCchCatWorker(pszDest, cchDest, pszSrc);
end;

function StringCchCat(pszDest: PWideChar; cchDest: size_t; const pszSrc: PWideChar): HRESULT; overload;
begin
  if (cchDest > STRSAFE_MAX_CCH)
  then Result := STRSAFE_E_INVALID_PARAMETER
  else Result := StringCchCatWorker(pszDest, cchDest, pszSrc);
end;

{$IFNDEF FPC}
function StringCchCat(pszDest: PWideChar; cchDest: size_t; const pszSrc: WideString): HRESULT;
begin
  Result := StringCchCat(pszDest, cchDest, PWideChar(pszSrc));
end;
{$ENDIF}
{$ENDIF}  // !STRSAFE_NO_CCH_FUNCTIONS



{$IFNDEF STRSAFE_NO_CCH_FUNCTIONS}
function StringCchFormatWorker(pszDest: PAnsiChar; cchDest: size_t; const pszFormat: PAnsiChar; Args: array of const): HRESULT; overload;
var
  iRet: Integer;
  cchMax: size_t;
begin
  Result := S_OK;

  if (cchDest = 0) then
  begin
    // can not null terminate a zero-byte dest buffer
    Result := STRSAFE_E_INVALID_PARAMETER;
  end else
  begin
    // leave the last space for the null terminator
    cchMax := cchDest - 1;

    iRet := FormatBuf(pszDest^, cchDest, pszFormat^, StrLen(pszFormat)+1, Args);
    // ASSERT((iRet < 0) || (((size_t)iRet) <= cchMax));

    if (iRet < 0) or (size_t(iRet) > cchMax) then
    begin
      // need to null terminate the string
      Inc(pszDest, cchMax);
      pszDest^ := #0;

      // we have truncated pszDest
      Result := STRSAFE_E_INSUFFICIENT_BUFFER;
    end
    else if (size_t(iRet) = cchMax) then
    begin
      // need to null terminate the string
      Inc(pszDest, cchMax);
      pszDest^ := #0;
    end;
  end;
end;

function StringCchFormatWorker(pszDest: PWideChar; cchDest: size_t; const pszFormat: PWideChar; Args: array of const): HRESULT; overload;
var
  iRet: Integer;
  cchMax: size_t;
begin
  Result := S_OK;

  if (cchDest = 0) then
  begin
    // can not null terminate a zero-byte dest buffer
    Result := STRSAFE_E_INVALID_PARAMETER;
  end else
  begin
    // leave the last space for the null terminator
    cchMax := cchDest - 1;

    iRet := WideFormatBuf(pszDest^, cchDest, pszFormat^, lstrlenW(pszFormat)+1, Args);
    // ASSERT((iRet < 0) || (((size_t)iRet) <= cchMax));

    if (iRet < 0) or (size_t(iRet) > cchMax) then
    begin
      // need to null terminate the string
      Inc(pszDest, cchMax);
      pszDest^ := #0;

      // we have truncated pszDest
      Result := STRSAFE_E_INSUFFICIENT_BUFFER;
    end
    else if (size_t(iRet) = cchMax) then
    begin
      // need to null terminate the string
      Inc(pszDest, cchMax);
      pszDest^ := #0;
    end;
  end;
end;

function StringCchFormatWorker(pszDest: PWideChar; cchDest: size_t; const pszFormat: WideString; Args: array of const): HRESULT; overload;
var
  iRet: Integer;
  cchMax: size_t;
begin
  Result := S_OK;

  if (cchDest = 0) then
  begin
    // can not null terminate a zero-byte dest buffer
    Result := STRSAFE_E_INVALID_PARAMETER;
  end else
  begin
    // leave the last space for the null terminator
    cchMax := cchDest - 1;

    iRet := WideFormatBuf(pszDest^, cchDest, pszFormat[1], Length(pszFormat)+1, Args);
    // ASSERT((iRet < 0) || (((size_t)iRet) <= cchMax));

    if (iRet < 0) or (size_t(iRet) > cchMax) then
    begin
      // need to null terminate the string
      Inc(pszDest, cchMax);
      pszDest^ := #0;

      // we have truncated pszDest
      Result := STRSAFE_E_INSUFFICIENT_BUFFER;
    end
    else if (size_t(iRet) = cchMax) then
    begin
      // need to null terminate the string
      Inc(pszDest, cchMax);
      pszDest^ := #0;
    end;
  end;
end;
{$ENDIF}  // !STRSAFE_NO_CCH_FUNCTIONS

{$IFNDEF STRSAFE_NO_CCH_FUNCTIONS}
function StringCchFormat(pszDest: PAnsiChar; cchDest: size_t; const pszFormat: PAnsiChar; Args: array of const): HRESULT; overload;
begin
  if (cchDest > STRSAFE_MAX_CCH)
  then Result := STRSAFE_E_INVALID_PARAMETER
  else Result := StringCchFormatWorker(pszDest, cchDest, pszFormat, Args);
end;

function StringCchFormat(pszDest: PWideChar; cchDest: size_t; const pszFormat: PWideChar; Args: array of const): HRESULT; overload;
begin
  if (cchDest > STRSAFE_MAX_CCH)
  then Result := STRSAFE_E_INVALID_PARAMETER
  else Result := StringCchFormatWorker(pszDest, cchDest, pszFormat, Args);
end;

{$IFNDEF FPC}
function StringCchFormat(pszDest: PWideChar; cchDest: size_t; const pszFormat: WideString; Args: array of const): HRESULT; overload;
begin
  if (cchDest > STRSAFE_MAX_CCH)
  then Result := STRSAFE_E_INVALID_PARAMETER
  else Result := StringCchFormatWorker(pszDest, cchDest, pszFormat, Args);
end;
{$ENDIF}
{$ENDIF}  // !STRSAFE_NO_CCH_FUNCTIONS

{$IFNDEF STRSAFE_NO_CCH_FUNCTIONS}
function StringCchLength(const psz: PAnsiChar; cchMax: size_t; out pcch: size_t): HRESULT; overload;
begin
  if ((psz = nil) or (cchMax > STRSAFE_MAX_CCH)) then
  begin
    Result := STRSAFE_E_INVALID_PARAMETER;
  end else
  begin
    Result := StringLengthWorker(psz, cchMax, pcch);
  end;
end;

function StringCchLength(const psz: PWideChar; cchMax: size_t; out pcch: size_t): HRESULT; overload;
begin
  if ((psz = nil) or (cchMax > STRSAFE_MAX_CCH)) then
  begin
    Result := STRSAFE_E_INVALID_PARAMETER;
  end else
  begin
    Result := StringLengthWorker(psz, cchMax, pcch);
  end;
end;
{$ENDIF}  // !STRSAFE_NO_CCH_FUNCTIONS

{$IFNDEF STRSAFE_NO_CB_FUNCTIONS}

function StringCbLength(const psz: PAnsiChar; cbMax: size_t; out pcb: size_t): HRESULT; overload;
var
  cchMax: size_t;
  cch: size_t;
begin
  cch := 0;

  cchMax := cbMax div SizeOf(AnsiChar);

  if (psz = nil) or (cchMax > STRSAFE_MAX_CCH)
  then Result := STRSAFE_E_INVALID_PARAMETER
  else Result := StringLengthWorker(psz, cchMax, cch);

  if SUCCEEDED(Result) {and Assigned(pcb)} then
  begin
    // safe to multiply cch * sizeof(char) since cch < STRSAFE_MAX_CCH and sizeof(char) is 1
    pcb := cch * SizeOf(AnsiChar);
  end;
end;

function StringCbLength(const psz: PWideChar; cbMax: size_t; out pcb: size_t): HRESULT; overload;
var
  cchMax: size_t;
  cch: size_t;
begin
  cch := 0;

  cchMax := cbMax div SizeOf(WideChar);

  if (psz = nil) or (cchMax > STRSAFE_MAX_CCH)
  then Result := STRSAFE_E_INVALID_PARAMETER
  else Result := StringLengthWorker(psz, cchMax, cch);

  if SUCCEEDED(Result) {and Assigned(pcb)} then
  begin
    // safe to multiply cch * sizeof(char) since cch < STRSAFE_MAX_CCH and sizeof(char) is 1
    pcb := cch * SizeOf(WideChar);
  end;
end;

{$ENDIF}  // !STRSAFE_NO_CB_FUNCTIONS

end.

