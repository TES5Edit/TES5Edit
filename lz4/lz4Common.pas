(*
  LZ4Delphi
  Copyright (C) 2015, Jose Pascoa (atelierwebgm@gmail.com)
  BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)

  *************************************************************************
  LZ4 - Fast LZ compression algorithm
  xxHash - Fast Hash algorithm
  LZ4 source repository : http://code.google.com/p/lz4/
  xxHash source repository : http://code.google.com/p/xxhash/
  Copyright (c) 2011-2014, Yann Collet
  BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above
  copyright notice, this list of conditions and the following disclaimer
  in the documentation and/or other materials provided with the
  distribution.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 ******************************************************************************
*)

unit lz4common;
{$POINTERMATH ON}
{$Q-}
{$R-}


interface

uses Windows;

type
    ppByte = ^pByte;
    {$IFDEF WIN32}
    size_t = Cardinal;
    {$ENDIF WIN32}
    {$IFDEF WIN64}
    size_t = UInt64;
    {$ENDIF WIN64}
    psize_t = ^size_t;

const
    MINMATCH = 4;
    COPYLENGTH = 8;
    LASTLITERALS = 5;
    _MFLIMIT = COPYLENGTH + MINMATCH;
    MAXD_LOG = 16;
    MAX_DISTANCE = (1 shl MAXD_LOG) - 1;
    STEPSIZE = sizeof(size_t);
    ML_BITS = 4;
    ML_MASK = (1 shl ML_BITS) - 1;
    RUN_BITS = 8 - ML_BITS;
    RUN_MASK = (1 shl RUN_BITS) - 1;

function LZ4_read32(const memPtr: pointer): cardinal;
function LZ4_read64(const memPtr: pointer): uint64; inline;
function LZ4_count(pIn: pByte; pMatch: pByte; const pInLimit: pByte): cardinal;
function LZ4_read_ARCH(const p: pointer): size_t; inline;
function LZ4_read16(const memPtr: pointer): word; inline;
procedure LZ4_writeLE16(memPtr: pointer; value: word); inline;
procedure LZ4_wildCopy(dstPtr: pointer; const srcPtr: pointer; dstEnd: pointer);

implementation

function LZ4_read32(const memPtr: pointer): cardinal;
begin
    result := pCardinal(memPtr)^;
end;

{$IFDEF WIN64}


function LZ4_NbCommonBytesx64(value: size_t): cardinal;
asm
    bsf rax, rcx // value comes in rcx register
    shr eax, 3
end;
{$ENDIF}


function LZ4_count(pIn: pByte; pMatch: pByte; const pInLimit: pByte): cardinal;
var
    pStart: pByte;
    diff: size_t;
    incValue: cardinal;

    calcedPByte: pByte;
begin
    pStart := pIn;
    calcedPByte := pInLimit - (STEPSIZE - 1);

    while pIn < calcedPByte do
    begin
        diff := LZ4_read_ARCH(pMatch) xor LZ4_read_ARCH(pIn);
        if (diff = 0) then
        begin
            inc(pIn, STEPSIZE);
            inc(pMatch, STEPSIZE);
            continue;
        end;
{$IFDEF WIN32}
        asm
            bsf eax, diff
            shr eax, 3
            mov incValue, eax
        end;
{$ELSE}
        incValue := LZ4_NbCommonBytesx64(diff); // x64 mode does not allow asm inline
{$ENDIF}
        inc(pIn, incValue);
        exit(cardinal(pIn - pStart));
    end;
{$IFDEF WIN64}
    if (pIn < (pInLimit - 3)) and (pCardinal(pMatch)^ = pCardinal(pIn)^) then
    begin
        inc(pIn, 4);
        inc(pMatch, 4);
    end;
{$ENDIF}
    if ((pIn < (pInLimit - 1)) and (pWord(pMatch)^ = pWord(pIn)^)) then
    begin
        inc(pIn, 2);
        inc(pMatch, 2);
    end;
    if ((pIn < pInLimit) and (pMatch^ = pIn^)) then
        inc(pIn);
    result := cardinal(pIn - pStart);
end;

function LZ4_read_ARCH(const p: pointer): size_t; inline;
begin
{$IFDEF WIN64}
    result := size_t(pUint64(p)^)
{$ELSE}
    result := size_t(pCardinal(p)^);
{$ENDIF}
end;

function LZ4_read16(const memPtr: pointer): word; inline;
begin
    result := pWord(memPtr)^;
end;

function LZ4_read64(const memPtr: pointer): uint64; inline;
begin
    result := pUint64(memPtr)^;
end;

{$IFDEF WILDCOPY_ASM}
{$IFDEF WIN32}


procedure LZ4_wildCopy; // (dstPtr: pointer; const srcPtr: pointer; dstEnd: pointer);
asm
    push edi
    push esi
    mov edi, eax
    mov esi, edx
    // copyCount := (((e - d) - 1) div 8) * 8 + 8;
    sub ecx, eax // (e - d)
    dec ecx		 // e - d) - 1)
    shr ecx, 3   // ((e - d) - 1) div 8)
    shl ecx, 3	 // ((e - d) - 1) div 8) * 8
    add ecx, 8   // ((e - d) - 1) div 8) * 8 + 8

    // if copyCount <= 0 then
    // copyCount := 8;
    mov eax, 8
    cmp ecx, 0
    cmovbe ecx, eax
    shr ecx, 2
    rep movsd
    pop esi
    pop edi
end;

{$ELSE}


procedure LZ4_wildCopy; // (dstPtr: pointer; const srcPtr: pointer; dstEnd: pointer);
asm
    mov r10, rdi
    mov r11, rsi
    mov rdi, rcx
    mov rsi, rdx
    // copyCount := (((e - d) - 1) div 8) * 8 + 8;
    sub r8, rcx  // (dstEnd - dest)
    mov rax, 8
    dec r8		 // e - d) - 1)
    shr r8, 3	 // ((e - d) - 1) div 8)
    shl r8, 3	 // ((e - d) - 1) div 8) * 8
    add r8, rax	 // ((e - d) - 1) div 8) * 8 + 8
    cmp r8, 0
    cmovbe r8, rax
    mov rcx, r8
    shr rcx, 3
    rep movsq
    mov rdi, r10
    mov rsi, r11
end;
{$ENDIF}
{$ELSE}


procedure LZ4_wildCopy(dstPtr: pointer; const srcPtr: pointer; dstEnd: pointer); inline;
var
    d: pByte;
    s: pByte;
    e: pByte;
begin
    d := dstPtr;
    s := srcPtr;
    e := dstEnd;
    repeat
{$IFDEF WIN32}
        pCardinal(d)[0] := pCardinal(s)[0];
        pCardinal(d)[1] := pCardinal(s)[1];
{$ELSE}
        pUint64(d)^ := pUint64(s)^;
{$ENDIF}
        inc(d, 8);
        inc(s, 8);
    until not(d < e);
end;

{$ENDIF}


procedure LZ4_writeLE16(memPtr: pointer; value: word); inline;
begin
    pWord(memPtr)^ := value;

end;

end.
