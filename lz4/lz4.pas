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
unit lz4;
{$HINTS OFF}
{$POINTERMATH ON}
{$Q-}
{$R-}


interface

uses Windows, lz4Common;

const
    LZ4_VERSION_MAJOR = 1;
    LZ4_VERSION_MINOR = 5;
    LZ4_VERSION_RELEASE = 0;
    LZ4_MEMORY_USAGE = 14;
    LZ4_STREAMSIZE_U64 = (1 shl (LZ4_MEMORY_USAGE - 3)) + 4;
    LZ4_STREAMSIZE = LZ4_STREAMSIZE_U64 * sizeof(int64);
    LZ4_MAX_INPUT_SIZE = $7E000000;
    LZ4_UNALIGNED_ACCESS = 1;
    LZ4_STREAMDECODESIZE_U64 = 4;

type
    PLZ4_stream_t = ^LZ4_stream_t;

    LZ4_stream_t = record
        table: array [0 .. LZ4_STREAMSIZE_U64 - 1] of int64;
    end;

    PLZ4_streamDecode_t = ^LZ4_streamDecode_t;

    LZ4_streamDecode_t = record
        table: array [0 .. LZ4_STREAMDECODESIZE_U64 - 1] of int64;
    end;

function LZ4_versionNumber: integer;
function LZ4_compressBound(iSize: cardinal): cardinal;
function LZ4_create(inputBuffer: pAnsiChar): pointer;
function LZ4_createStream: PLZ4_stream_t;
procedure LZ4_freeStream(LZ4_streamPtr: PLZ4_stream_t);
function LZ4_createStreamDecode: PLZ4_streamDecode_t;
procedure LZ4_freeStreamDecode(LZ4_stream: PLZ4_streamDecode_t);
function LZ4_compress(source: pAnsiChar; dest: pAnsiChar; sourceSize: integer): integer;
function LZ4_decompress_safe(source: pAnsiChar; dest: pAnsiChar; compressedSize: integer; maxDecompressedSize: integer): integer;
function LZ4_compress_continue(LZ4_stream: pointer; const ASource: pointer; ADestination: pointer; AInputSize: integer): integer;
function LZ4_saveDict(LZ4_streamPtr: PLZ4_stream_t; safeBuffer: pointer; dictSize: integer): integer;
function LZ4_decompress_safe_continue(LZ4_streamDecode: PLZ4_streamDecode_t; source: pointer; dest: pointer; compressedSize: integer;
  maxDecompressedSize: integer): integer;
function LZ4_compress_limitedOutput(const source: pAnsiChar; dest: pAnsiChar; inputSize: integer; maxOutputSize: integer): integer;
function LZ4_compress_withState(state: pointer; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer): integer;
function LZ4_compress_limitedOutput_withState(state: pointer; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer;
  maxOutputSize: integer): integer;
function LZ4_compress_limitedOutput_continue(LZ4_stream: PLZ4_stream_t; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer;
  maxOutputSize: integer): integer;
procedure LZ4_resetStream(LZ4_stream: PLZ4_stream_t);
function LZ4_loadDict(LZ4_dict: PLZ4_stream_t; dictionary: pAnsiChar; dictSize: integer): integer;
// debug function
function LZ4_compress_forceExtDict(LZ4_dict: PLZ4_stream_t; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer): integer;
function LZ4_decompress_fast(source: pAnsiChar; dest: pAnsiChar; originalSize: integer): integer;
function LZ4_decompress_fast_withPrefix64k(source: pAnsiChar; dest: pAnsiChar; originalSize: integer): integer;
function LZ4_decompress_fast_usingDict(source: pAnsiChar; dest: pAnsiChar; originalSize: integer; const dictStart: pAnsiChar;
  dictSize: integer): integer;
function LZ4_decompress_safe_withPrefix64k(source: pAnsiChar; dest: pAnsiChar; compressedSize: integer; maxOutputSize: integer): integer;
function LZ4_decompress_safe_usingDict(const source: pAnsiChar; dest: pAnsiChar; compressedSize: integer; maxOutputSize: integer;
  const dictStart: pAnsiChar; dictSize: integer): integer;
function LZ4_decompress_safe_partial(const source: pAnsiChar; dest: pAnsiChar; compressedSize: integer; targetOutputSize: integer;
  maxDecompressedSize: integer): integer;
function LZ4_decompress_safe_forceExtDict(source: pAnsiChar; dest: pAnsiChar; compressedSize: integer; maxOutputSize: integer;
  const dictStart: pAnsiChar; dictSize: integer): integer;

// replaced with move(source^, dest^, count)
// procedure memmove(dest, source: pointer; count: integer); cdecl; external 'msvcrt.dll' name 'memmove';

implementation

const
    LZ4_HASHLOG = LZ4_MEMORY_USAGE - 2;
    HASHTABLESIZE = 1 shl LZ4_MEMORY_USAGE;
    HASH_SIZE_U32 = 1 shl LZ4_HASHLOG;

type
    limitedOutput_directive = (notLimited = 0, limitedOutput = 1);
    tableType_t = (byPtr, byU32, byU16);
    dict_directive = (noDict = 0, withPrefix64k, usingExtDict);
    dictIssue_directive = (noDictIssue = 0, dictSmall);
    endCondition_directive = (endOnOutputSize = 0, endOnInputSize = 1);
    earlyEnd_directive = (full = 0, partial = 1);

    PLZ4_stream_t_internal = ^LZ4_stream_t_internal;

    LZ4_stream_t_internal = record
        hashTable: array [0 .. HASH_SIZE_U32 - 1] of cardinal;
        currentOffset: cardinal;
        initCheck: cardinal;
        dictionary: pByte;
        bufferStart: pByte;
        dictSize: cardinal;
    end;

    PLZ4_streamDecode_t_internal = ^LZ4_streamDecode_t_internal;

    LZ4_streamDecode_t_internal = record
        externalDict: pByte;
        extDictSize: size_t;
        prefixEnd: pByte;
        prefixSize: size_t;
    end;

var
    LZ4_64Klimit: integer = 65536 + _MFLIMIT - 1;
    LZ4_skipTrigger: cardinal = 6;
    LZ4_minLength: integer = (_MFLIMIT + 1);

function LZ4_versionNumber: integer;
begin
    result := LZ4_VERSION_MAJOR * 100 * 100 + LZ4_VERSION_MINOR * 100 + LZ4_VERSION_RELEASE;
end;

function LZ4_compressBound(iSize: cardinal): cardinal;
begin
    if (iSize) > cardinal(LZ4_MAX_INPUT_SIZE) then
        result := 0
    else
        result := iSize + (iSize div 255 + 16)
end;

procedure LZ4_copy8(const dstPtr: pointer; const srcPtr: pointer); inline;
begin
{$IFDEF WIN64}
    pUint64(dstPtr)^ := pUint64(srcPtr)^;
{$ELSE}
    pCardinal(dstPtr)[0] := pCardinal(srcPtr)[0];
    pCardinal(dstPtr)[1] := pCardinal(srcPtr)[1];
{$ENDIF}
end;

function LZ4_hashSequence(sequence: cardinal; tableType: tableType_t): cardinal; inline;
const
    SHL1 = (MINMATCH * 8) - (LZ4_HASHLOG + 1);
    SHL2 = ((MINMATCH * 8) - LZ4_HASHLOG);
begin
    if (tableType = byU16) then
        result := (sequence * 2654435761) shr SHL1
    else
        result := (sequence * 2654435761) shr SHL2;
end;

function LZ4_hashPosition(const p: pByte; tableType: tableType_t): cardinal; inline;
begin
    result := LZ4_hashSequence(pCardinal(p)^, tableType);
end;

procedure LZ4_putPositionOnHash(const p: pByte; h: cardinal; tableBase: pointer; tableType: tableType_t; const srcBase: pByte); inline;
begin
    case tableType of
        byPtr: ppByte(tableBase)[h] := p;
        byU32: pCardinal(tableBase)[h] := cardinal(p - srcBase);
        byU16: pWord(tableBase)[h] := word(p - srcBase);
    end;
end;

function LZ4_getPositionOnHash(h: cardinal; tableBase: pointer; tableType: tableType_t; const srcBase: pByte): pByte; inline;
begin
    if (tableType = byPtr) then
        result := ppByte(tableBase)[h]
    else if (tableType = byU32) then
        result := pCardinal(tableBase)[h] + srcBase
    else
        result := pWord(tableBase)[h] + srcBase;
end;

function LZ4_getPosition(const p: pByte; tableBase: pointer; tableType: tableType_t; const srcBase: pByte): pByte; inline;
var
    h: cardinal;
begin
    h := LZ4_hashPosition(p, tableType);
    result := LZ4_getPositionOnHash(h, tableBase, tableType, srcBase);
end;

procedure LZ4_putPosition(const p: pByte; tableBase: pointer; tableType: tableType_t; const srcBase: pByte); inline;
var
    h: cardinal;
begin
    h := LZ4_hashPosition(p, tableType);
    LZ4_putPositionOnHash(p, h, tableBase, tableType, srcBase);
end;

function LZ4_compress_generic(ctx: pointer; const source: pointer; dest: pointer; inputSize: integer; maxOutputSize: integer;
  outputLimited: limitedOutput_directive; tableType: tableType_t; dict: dict_directive; dictIssue: dictIssue_directive): integer; inline;
var
    lowRefLimit: pByte;
    match: pByte;
    refDelta: size_t;
    ip: pByte;

    dictPtr: PLZ4_stream_t_internal;
    base: pByte;
    lowLimit: pByte;
    dictionary: pByte;
    dictEnd: pByte;
    dictDelta: size_t;
    anchor: pByte;
    iend: pByte;
    mflimit: pByte;
    matchlimit: pByte;
    op: pByte;
    olimit: pByte;
    forwardH: cardinal;
    lastRun: integer;
    token: pByte;
    forwardIp: pByte;
    step: cardinal;
    searchMatchNb: cardinal;
    h: cardinal;
    litLength: cardinal;
    len: integer;
    matchLength: cardinal;
    limit: pByte;
    more: cardinal;
    booleanValue: boolean;
label
    _last_literals, _next_match;
begin
    match := nil;
    dictPtr := ctx;
    ip := pByte(source);
    lowRefLimit := ip - dictPtr.dictSize;
    dictionary := dictPtr.dictionary;
    dictEnd := dictionary + dictPtr.dictSize;
    dictDelta := dictEnd - pByte(source);
    anchor := pByte(source);
    iend := ip + inputSize;
    mflimit := iend - _MFLIMIT;
    matchlimit := iend - LASTLITERALS;

    op := pByte(dest);
    olimit := op + maxOutputSize;
    refDelta := 0;

    if cardinal(inputSize) > cardinal(LZ4_MAX_INPUT_SIZE) then
        exit(0);

    case dict of
        withPrefix64k:
            begin
                base := pByte(source) - dictPtr.currentOffset;
                lowLimit := pByte(source) - dictPtr.dictSize;
            end;
        usingExtDict:
            begin
                base := pByte(source) - dictPtr.currentOffset;
                lowLimit := pByte(source);
            end;
    else
        begin
            base := pByte(source);
            lowLimit := pByte(source);
        end;
    end;

    if ((tableType = byU16) and (inputSize >= LZ4_64Klimit)) then
        exit(0);
    if (inputSize < LZ4_minLength) then
        goto _last_literals;

    LZ4_putPosition(ip, ctx, tableType, base);
    inc(ip);
    forwardH := LZ4_hashPosition(ip, tableType);

    while true do
    begin
        forwardIp := ip;
        step := 1;
        searchMatchNb := (1 shl LZ4_skipTrigger);
        while true do
        begin
            h := forwardH;
            ip := forwardIp;
            inc(forwardIp, step);
            step := searchMatchNb shr LZ4_skipTrigger;
            inc(searchMatchNb);

            if forwardIp > mflimit then
                goto _last_literals;

            match := LZ4_getPositionOnHash(h, ctx, tableType, base);
            if (dict = usingExtDict) then
            begin
                if match < pByte(source) then
                begin
                    refDelta := dictDelta;
                    lowLimit := dictionary;
                end
                else
                begin
                    refDelta := 0;
                    lowLimit := pByte(source);
                end;
            end;
            forwardH := LZ4_hashPosition(forwardIp, tableType);
            LZ4_putPositionOnHash(ip, h, ctx, tableType, base);
            if (dictIssue = dictSmall) and (match < lowRefLimit) then
                continue;
            if not(tableType = byU16) and (match + MAX_DISTANCE < ip) then
                continue;
            if (pCardinal(match + refDelta)^ <> pCardinal(ip)^) then
                continue;
            break;
        end;

        while (ip > anchor) and (match + refDelta > lowLimit) and (ip[-1] = match[refDelta - 1]) do
        begin
            dec(ip);
            dec(match);
        end;
        litLength := cardinal(ip - anchor);
        token := op;
        inc(op);
        if (outputLimited <> notLimited) and (op + litLength + (2 + 1 + LASTLITERALS) + (litLength div 255) > olimit) then
            exit(0);
        if (litLength >= RUN_MASK) then
        begin
            len := integer(litLength - RUN_MASK);
            token^ := (RUN_MASK shl ML_BITS);
            while len >= 255 do
            begin
                op^ := 255;
                inc(op);
                dec(len, 255);
            end;
            op^ := BYTE(len);
            inc(op);
        end
        else
            token^ := BYTE(litLength shl ML_BITS);
        LZ4_wildCopy(op, anchor, op + litLength);
        inc(op, litLength);
    _next_match:
        pWord(op)^ := word(ip - match);
        inc(op, 2);

        if (dict = usingExtDict) and (lowLimit = dictionary) then
        begin
            inc(match, refDelta);
            limit := ip + (dictEnd - match);
            if (limit > matchlimit) then
                limit := matchlimit;
            matchLength := LZ4_count(ip + MINMATCH, match + MINMATCH, limit);
            inc(ip, MINMATCH + matchLength);
            if (ip = limit) then
            begin
                more := LZ4_count(ip, pByte(source), matchlimit);
                inc(matchLength, more);
                inc(ip, more);
            end;
        end
        else
        begin
            matchLength := LZ4_count(ip + MINMATCH, match + MINMATCH, matchlimit);
            inc(ip, MINMATCH + matchLength);
        end;
        if (outputLimited <> notLimited) and (op + (1 + LASTLITERALS) + (matchLength shr 8) > olimit) then
            exit(0);
        if (matchLength >= ML_MASK) then
        begin
            inc(token^, ML_MASK);
            dec(matchLength, ML_MASK);
            while matchLength >= 510 do
            begin
                pWord(op)^ := $FFFF;
                inc(op, 2);
                // op^ := 255;
                // inc(op);
                // op^ := 255;
                // inc(op);
                dec(matchLength, 510);
            end;
            if (matchLength >= 255) then
            begin
                dec(matchLength, 255);
                op^ := 255;
                inc(op);
            end;
            op^ := BYTE(matchLength);
            inc(op);
        end
        else
            inc(token^, BYTE(matchLength));

        anchor := ip;
        if (ip > mflimit) then
            break;
        LZ4_putPosition(ip - 2, ctx, tableType, base);
        match := LZ4_getPosition(ip, ctx, tableType, base);
        if (dict = usingExtDict) then
        begin
            if match < pByte(source) then
            begin
                refDelta := dictDelta;
                lowLimit := dictionary;
            end
            else
            begin
                refDelta := 0;
                lowLimit := pByte(source);
            end;
        end;
        LZ4_putPosition(ip, ctx, tableType, base);

        if dictIssue = dictSmall then
            booleanValue := match >= lowRefLimit
        else
            booleanValue := true;
        if (booleanValue and (match + MAX_DISTANCE >= ip)
          and (pCardinal(match + refDelta)^ = pCardinal(ip)^)) then
        begin
            token := op;
            inc(op);
            token^ := 0;
            goto _next_match;
        end;
        inc(ip);
        forwardH := LZ4_hashPosition(ip, tableType);
    end;

_last_literals:
    lastRun := integer(iend - anchor);
    if (outputLimited <> notLimited) and ((op - pByte(dest)) + lastRun + 1 + ((lastRun + 255 - RUN_MASK) div 255) >
      maxOutputSize)
    then
        exit(0);
    if lastRun >= integer(RUN_MASK) then
    begin
        op^ := (RUN_MASK shl ML_BITS);
        inc(op);
        dec(lastRun, RUN_MASK);
        while lastRun >= 255 do
        begin
            op^ := 255;
            inc(op);
            dec(lastRun, 255);
        end;
        op^ := BYTE(lastRun);
        inc(op);
    end
    else
    begin
        op^ := BYTE(lastRun shl ML_BITS);
        inc(op);
    end;
    move(anchor^, op^, iend - anchor);
    inc(op, iend - anchor);

    result := integer(op - pByte(dest));
end;

function LZ4_compress(source: pAnsiChar; dest: pAnsiChar; sourceSize: integer): integer;
var
    ctx: array [0 .. LZ4_STREAMSIZE_U64 - 1] of uint64;
begin
    fillchar(ctx, sizeof(ctx), 0);
    if sourceSize < LZ4_64Klimit then
        result := LZ4_compress_generic(@ctx, source, dest, sourceSize, 0, notLimited, byU16, noDict, noDictIssue)
    else
    begin
{$IFDEF WIN64}
        result := LZ4_compress_generic(@ctx, source, dest, sourceSize, 0, notLimited, byU32, noDict,
          noDictIssue)
{$ELSE}
        result := LZ4_compress_generic(@ctx, source, dest, sourceSize, 0, notLimited, byPtr, noDict, noDictIssue);
{$ENDIF}
    end;
end;

function LZ4_decompress_generic(const source: pointer; const dest: pointer; inputSize: integer; outputSize: integer;
  endOnInput: integer; partialDecoding: integer; targetOutputSize: integer; dict: integer;
  const lowPrefix: pByte; const dictStart: pByte; const dictSize: size_t): integer; inline;
var
    ip: pByte;
    iend: pByte;
    op: pByte;
    oend: pByte;
    cpy: pByte;
    oexit: pByte;
    lowLimit: pByte;
    dictEnd: pByte;
    safeDecode: boolean;
    checkOffset: boolean;
    token: cardinal;
    length: size_t;
    match: pByte;
    s: cardinal;
    booleantest: boolean;
    copySize: size_t;
    endOfMatch: pByte;
    copyFrom: pByte;
    dec64: size_t;
const
    dec32table: array [0 .. 7] of size_t = (4, 1, 2, 1, 4, 4, 4, 4);
    dec64table: array [0 .. 7] of size_t = (0, 0, 0, size_t(-1), 0, 1, 2, 3);
label
    _output_error;
begin
    ip := pByte(source);
    iend := ip + inputSize;
    op := pByte(dest);
    oend := op + outputSize;
    oexit := op + targetOutputSize;
    lowLimit := lowPrefix - dictSize;
    dictEnd := pByte(dictStart) + dictSize;
    safeDecode := (endOnInput = integer(endOnInputSize));
    checkOffset := ((safeDecode) and (dictSize < 65536));

    if (partialDecoding <> 0) and (oexit > oend - _MFLIMIT) then
        oexit := oend - _MFLIMIT;
    if (endOnInput <> 0) and (outputSize = 0) then
    begin
        if (inputSize = 1) and (ip^ = 0) then
            exit(0)
        else
            exit(-1);
    end;
    if (endOnInput = 0) and (outputSize = 0) then
    begin
        if ip^ = 0 then
            exit(1)
        else
            exit(-1);
    end;

    while true do
    begin
        token := ip^;
        inc(ip);
        length := token shr ML_BITS;
        if length = RUN_MASK then
        begin
            while true do
            begin
                s := ip^;
                inc(ip);
                inc(length, s);
                if endOnInput <> 0 then
                begin
                    if not(ip < iend - RUN_MASK) then
                        break;
                end;
                if s <> 255 then
                    break;
            end;
            if safeDecode and (size_t(op + length) < size_t(op)) then
                goto _output_error;
            if safeDecode and (size_t(ip + length) < size_t(ip)) then
                goto _output_error;
        end;
        cpy := op + length;
        if partialDecoding <> 0 then
            booleantest := cpy > oexit
        else
            booleantest := cpy > oend - _MFLIMIT;

        if ((endOnInput <> 0) and ((booleantest) or (ip + length > iend - (2 + 1 + LASTLITERALS))))
          or ((endOnInput = 0) and (cpy > oend - COPYLENGTH)) then
        begin
            if partialDecoding <> 0 then
            begin
                if (cpy > oend) then
                    goto _output_error;
                if ((endOnInput <> 0) and (ip + length > iend)) then
                    goto _output_error;
            end
            else
            begin
                if ((endOnInput = 0) and (cpy <> oend)) then
                    goto _output_error;
                if ((endOnInput <> 0) and ((ip + length <> iend) or (cpy > oend))) then
                    goto _output_error;
            end;
            move(ip^, op^, length);
            inc(ip, length);
            inc(op, length);
            break;
        end;
        LZ4_wildCopy(op, ip, cpy);
        inc(ip, length);
        op := cpy;
        match := cpy - LZ4_read16(ip); // LZ4_readLE16 = LZ4_read16 for unaligned
        inc(ip, 2);

        if checkOffset and (match < lowLimit) then
            goto _output_error;

        length := token and ML_MASK;
        if length = ML_MASK then
        begin
            while true do
            begin
                if ((endOnInput <> 0) and (ip > iend - LASTLITERALS)) then
                    goto _output_error;
                s := ip^;
                inc(ip);
                inc(length, s);
                if s <> 255 then
                    break;
            end;
            if safeDecode and (size_t(op + length) < size_t(op)) then
                goto _output_error;
        end;
        inc(length, MINMATCH);
        if (dict = integer(usingExtDict)) and (match < lowPrefix) then
        begin
            if op + length > oend - LASTLITERALS then
                goto _output_error;
            if (length <= size_t(lowPrefix - match)) then
            begin
                match := dictEnd - (lowPrefix - match);
                move(match^, op^, length);
                inc(op, length);
            end
            else
            begin
                copySize := size_t(lowPrefix - match);
                move((dictEnd - copySize)^, op^, copySize);
                inc(op, copySize);
                copySize := length - copySize;
                if copySize > size_t(op - lowPrefix) then
                begin
                    endOfMatch := op + copySize;
                    copyFrom := lowPrefix;
                    while (op < endOfMatch) do
                    begin
                        op^ := copyFrom^;
                        inc(op);
                        inc(copyFrom);
                    end;
                end
                else
                begin
                    move(lowPrefix^, op^, copySize);
                    inc(op, copySize);
                end;
            end;
            continue;
        end;
        cpy := op + length;
        if (op - match) < 8 then
        begin
            dec64 := dec64table[op - match];
            op[0] := match[0];
            op[1] := match[1];
            op[2] := match[2];
            op[3] := match[3];
            inc(match, dec32table[op - match]);
            pCardinal(op + 4)^ := pCardinal(match)^;
            inc(op, 8);
            dec(match, dec64);
        end
        else
        begin
{$IFDEF WIN64}
            pUint64(op)^ := pUint64(match)^;
{$ELSE}
            pCardinal(op)[0] := pCardinal(match)[0];
            pCardinal(op)[1] := pCardinal(match)[1];
{$ENDIF}
            inc(op, 8);
            inc(match, 8);
        end;

        if cpy > oend - 12 then
        begin
            if (cpy > oend - LASTLITERALS) then
                goto _output_error;
            if (op < oend - 8) then
            begin
                LZ4_wildCopy(op, match, oend - 8);
                inc(match, (oend - 8) - op);
                op := oend - 8;
            end;
            while (op < cpy) do
            begin
                op^ := match^;
                inc(op);
                inc(match);
            end;
        end
        else
            LZ4_wildCopy(op, match, cpy);
        op := cpy;
    end;
    if (endOnInput <> 0) then
        result := integer(op - pByte(dest))
    else
        result := integer(ip - pByte(source));
    exit;
_output_error:
    result := -(ip - pByte(source)) - 1;
end;

function LZ4_decompress_safe(source: pAnsiChar; dest: pAnsiChar; compressedSize: integer; maxDecompressedSize: integer): integer;
begin
    result := LZ4_decompress_generic(source, dest, compressedSize, maxDecompressedSize, integer(endOnInputSize), integer(full), 0,
      integer(noDict), pByte(dest), nil, 0);
end;

function LZ4_createStream: PLZ4_stream_t;
begin
    result := allocmem(8 * LZ4_STREAMSIZE_U64);
end;

procedure LZ4_freeStream(LZ4_streamPtr: PLZ4_stream_t);
begin
    freemem(LZ4_streamPtr);
end;

function LZ4_createStreamDecode: PLZ4_streamDecode_t;
begin
    result := allocmem(sizeof(uint64) * LZ4_STREAMDECODESIZE_U64);
end;

procedure LZ4_freeStreamDecode(LZ4_stream: PLZ4_streamDecode_t);
begin
    freemem(LZ4_stream);
end;

procedure LZ4_renormDictT(LZ4_dict: PLZ4_stream_t_internal; src: pByte);
var
    delta: cardinal;
    dictEnd: pByte;
    i: integer;
begin
    if (LZ4_dict.currentOffset > $80000000) or
      (size_t(LZ4_dict.currentOffset) > size_t(src)) then
    begin
        delta := LZ4_dict.currentOffset - 65536;
        dictEnd := LZ4_dict.dictionary + LZ4_dict.dictSize;
        for i := 0 to HASH_SIZE_U32 - 1 do
        begin
            if (LZ4_dict.hashTable[i] < delta) then
                LZ4_dict.hashTable[i] := 0
            else
                dec(LZ4_dict.hashTable[i], delta);
        end;
        LZ4_dict.currentOffset := 65536;
        if (LZ4_dict.dictSize > 65536) then
            LZ4_dict.dictSize := 65536;
        LZ4_dict.dictionary := dictEnd - LZ4_dict.dictSize;
    end;
end;

function LZ4_compress_continue_generic(LZ4_stream: pointer; source: pointer; dest: pointer; inputSize: integer; maxOutputSize: integer;
  limit: limitedOutput_directive): integer; inline;
var
    streamPtr: PLZ4_stream_t_internal;
    dictEnd: pByte;
    smallest: pByte;
    sourceEnd: pByte;
    res: integer;
begin
    streamPtr := PLZ4_stream_t_internal(LZ4_stream);
    dictEnd := streamPtr.dictionary + streamPtr.dictSize;
    smallest := pByte(source);
    if (streamPtr.initCheck <> 0) then
        exit(0);
    if (streamPtr.dictSize > 0) and (smallest > dictEnd) then
        smallest := dictEnd;
    LZ4_renormDictT(streamPtr, smallest);
    sourceEnd := pByte(source) + inputSize;
    if (sourceEnd > streamPtr.dictionary) and (sourceEnd < dictEnd) then
    begin
        streamPtr.dictSize := cardinal(dictEnd - sourceEnd);
        if (streamPtr.dictSize > 65536) then
            streamPtr.dictSize := 65536;
        if (streamPtr.dictSize < 4) then
            streamPtr.dictSize := 0;
        streamPtr.dictionary := dictEnd - streamPtr.dictSize;
    end;
    if dictEnd = pByte(source) then
    begin
        if (streamPtr.dictSize < 65536) and (streamPtr.dictSize < streamPtr.currentOffset) then
            res := LZ4_compress_generic(LZ4_stream, source, dest, inputSize, maxOutputSize, limit, byU32, withPrefix64k, dictSmall)
        else
            res := LZ4_compress_generic(LZ4_stream, source, dest, inputSize, maxOutputSize, limit, byU32, withPrefix64k, noDictIssue);
        inc(streamPtr.dictSize, cardinal(inputSize));
        inc(streamPtr.currentOffset, cardinal(inputSize));
        exit(res);
    end;
    if (streamPtr.dictSize < 65536) and (streamPtr.dictSize < streamPtr.currentOffset) then
        res := LZ4_compress_generic(LZ4_stream, source, dest, inputSize, maxOutputSize, limit, byU32, usingExtDict, dictSmall)
    else
        res := LZ4_compress_generic(LZ4_stream, source, dest, inputSize, maxOutputSize, limit, byU32, usingExtDict, noDictIssue);
    streamPtr.dictionary := pByte(source);
    streamPtr.dictSize := cardinal(inputSize);
    inc(streamPtr.currentOffset, cardinal(inputSize));
    result := res;
end;

function LZ4_compress_continue(LZ4_stream: pointer; const ASource: pointer; ADestination: pointer; AInputSize: integer): integer;
begin
    result := LZ4_compress_continue_generic(LZ4_stream, ASource, ADestination, AInputSize, 0, notLimited);
end;

function LZ4_saveDict(LZ4_streamPtr: PLZ4_stream_t; safeBuffer: pointer; dictSize: integer): integer;
var
    dict: PLZ4_stream_t_internal;
    previousDictEnd: pByte;
begin
    dict := PLZ4_stream_t_internal(LZ4_streamPtr);
    previousDictEnd := dict.dictionary + dict.dictSize;
    if cardinal(dictSize) > 65536 then
        dictSize := 65536;
    if cardinal(dictSize) > dict.dictSize then
        dictSize := dict.dictSize;
    move((previousDictEnd - dictSize)^, safeBuffer^, dictSize);
    // memmove(safeBuffer, (previousDictEnd - dictSize), dictSize);
    dict.dictionary := pByte(safeBuffer);
    dict.dictSize := cardinal(dictSize);
    result := dictSize;
end;

function LZ4_decompress_safe_continue(LZ4_streamDecode: PLZ4_streamDecode_t; source: pointer; dest: pointer; compressedSize: integer;
  maxDecompressedSize: integer): integer;
var
    lz4sd: PLZ4_streamDecode_t_internal;
    res: integer;
begin
    lz4sd := PLZ4_streamDecode_t_internal(LZ4_streamDecode);
    if lz4sd.prefixEnd = pByte(dest) then
    begin
        res := LZ4_decompress_generic(source, dest, compressedSize, maxDecompressedSize,
          integer(endOnInputSize), integer(full), 0,
          integer(usingExtDict), lz4sd.prefixEnd - lz4sd.prefixSize, lz4sd.externalDict, lz4sd.extDictSize);
        if (res <= 0) then
            exit(res);
        inc(lz4sd.prefixSize, res);
        inc(lz4sd.prefixEnd, res);
    end
    else
    begin
        lz4sd.extDictSize := lz4sd.prefixSize;
        lz4sd.externalDict := lz4sd.prefixEnd - lz4sd.extDictSize;
        res := LZ4_decompress_generic(source, dest, compressedSize, maxDecompressedSize,
          integer(endOnInputSize), integer(full), 0,
          integer(usingExtDict), pByte(dest), lz4sd.externalDict, lz4sd.extDictSize);
        if (res <= 0) then
            exit(res);
        lz4sd.prefixSize := res;
        lz4sd.prefixEnd := pByte(dest) + res;
    end;
    result := res;
end;

procedure LZ4_init(lz4ds: PLZ4_stream_t_internal; base: pByte);
begin
    fillchar(lz4ds^, LZ4_STREAMSIZE, 0);
    lz4ds.bufferStart := base;
end;

function LZ4_create(inputBuffer: pAnsiChar): pointer;
var
    lz4ds: pointer;
begin
    lz4ds := allocmem(8 * LZ4_STREAMSIZE_U64);
    LZ4_init(PLZ4_stream_t_internal(lz4ds), pByte(inputBuffer));
    result := lz4ds;
end;

function LZ4_compress_limitedOutput(const source: pAnsiChar; dest: pAnsiChar; inputSize: integer; maxOutputSize: integer): integer;
var
    ctx: array [0 .. LZ4_STREAMSIZE_U64 - 1] of uint64;
begin
    fillchar(ctx, sizeof(ctx), 0);
    if inputSize < LZ4_64Klimit then
        result := LZ4_compress_generic(@ctx, source, dest, inputSize, maxOutputSize, limitedOutput, byU16, noDict, noDictIssue)
    else
    begin
{$IFDEF WIN64}
        result := LZ4_compress_generic(@ctx, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, noDict, noDictIssue);
{$ELSE}
        result := LZ4_compress_generic(@ctx, source, dest, inputSize, maxOutputSize, limitedOutput, byPtr, noDict, noDictIssue);
{$ENDIF}
    end;
end;

function LZ4_compress_withState(state: pointer; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer): integer;
begin
    if ((size_t(state) and 3) <> 0) then
        exit(0); // Error : state is not aligned on 4-bytes boundary
    fillchar(state^, LZ4_STREAMSIZE, 0);
    if inputSize < LZ4_64Klimit then
        result := LZ4_compress_generic(state, source, dest, inputSize, 0, notLimited, byU16, noDict, noDictIssue)
    else
    begin
{$IFDEF WIN64}
        result := LZ4_compress_generic(state, source, dest, inputSize, 0, notLimited, byU32, noDict, noDictIssue);
{$ELSE}
        result := LZ4_compress_generic(state, source, dest, inputSize, 0, notLimited, byPtr, noDict, noDictIssue);
{$ENDIF}
    end;
end;

function LZ4_compress_limitedOutput_withState(state: pointer; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer;
  maxOutputSize: integer): integer;
begin
    if ((size_t(state) and 3) <> 0) then
        exit(0); // Error : state is not aligned on 4-bytes boundary
    fillchar(state^, LZ4_STREAMSIZE, 0);
    if inputSize < LZ4_64Klimit then
        result := LZ4_compress_generic(state, source, dest, inputSize, maxOutputSize, limitedOutput, byU16, noDict, noDictIssue)
    else
    begin
{$IFDEF WIN64}
        result := LZ4_compress_generic(state, source, dest, inputSize, maxOutputSize, limitedOutput, byU32, noDict, noDictIssue);
{$ELSE}
        result := LZ4_compress_generic(state, source, dest, inputSize, maxOutputSize, limitedOutput, byPtr, noDict, noDictIssue);
{$ENDIF}
    end;
end;

function LZ4_compress_limitedOutput_continue(LZ4_stream: PLZ4_stream_t; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer;
  maxOutputSize: integer): integer;
begin
    result := LZ4_compress_continue_generic(LZ4_stream, source, dest, inputSize, maxOutputSize, limitedOutput);
end;

function LZ4_compress_forceExtDict(LZ4_dict: PLZ4_stream_t; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer): integer;
var
    streamPtr: PLZ4_stream_t_internal;
    dictEnd: pByte;
    smallest: pByte;
begin
    streamPtr := PLZ4_stream_t_internal(LZ4_dict);
    dictEnd := streamPtr.dictionary + streamPtr.dictSize;
    smallest := dictEnd;
    if smallest > pByte(source) then
        smallest := pByte(source);
    LZ4_renormDictT(PLZ4_stream_t_internal(LZ4_dict), smallest);
    result := LZ4_compress_generic(LZ4_dict, source, dest, inputSize, 0, notLimited, byU32, usingExtDict, noDictIssue);
    streamPtr.dictionary := pByte(source);
    streamPtr.dictSize := cardinal(inputSize);
    inc(streamPtr.currentOffset, cardinal(inputSize));
end;

procedure LZ4_resetStream(LZ4_stream: PLZ4_stream_t);
begin
    fillchar(LZ4_stream^, sizeof(LZ4_stream_t), 0);
end;

function LZ4_loadDict(LZ4_dict: PLZ4_stream_t; dictionary: pAnsiChar; dictSize: integer): integer;
var
    dict: PLZ4_stream_t_internal;
    p: pByte;
    dictEnd: pByte;
    base: pByte;
begin
    dict := PLZ4_stream_t_internal(LZ4_dict);
    p := pByte(dictionary);
    dictEnd := p + dictSize;
    if (dict.initCheck <> 0) then
        LZ4_resetStream(LZ4_dict); // Uninitialized structure detected
    if dictSize < MINMATCH then
    begin
        dict.dictionary := Nil;
        dict.dictSize := 0;
        exit(0);
    end;
    if (p <= dictEnd - 65536) then
        p := dictEnd - 65536;
    base := p - dict.currentOffset;
    dict.dictionary := p;
    dict.dictSize := cardinal(dictEnd - p);
    inc(dict.currentOffset, dict.dictSize);
    while (p <= dictEnd - MINMATCH) do
    begin
        LZ4_putPosition(p, dict, byU32, base);
        inc(p, 3);
    end;

    result := dict.dictSize;
end;

function LZ4_decompress_fast(source: pAnsiChar; dest: pAnsiChar; originalSize: integer): integer;
begin
    result := LZ4_decompress_generic(source, dest, 0, originalSize, integer(endOnOutputSize), integer(full), 0, integer(withPrefix64k),
      pByte(dest - 65536), Nil, 65536);
end;

function LZ4_decompress_fast_withPrefix64k(source: pAnsiChar; dest: pAnsiChar; originalSize: integer): integer;
begin
    result := LZ4_decompress_generic(source, dest, 0, originalSize, integer(endOnOutputSize), integer(full), 0, integer(withPrefix64k),
      pByte(dest) - 65536, Nil, 65536);
end;

function LZ4_decompress_usingDict_generic(source: pAnsiChar; dest: pAnsiChar; compressedSize: integer; maxOutputSize: integer;
  safe: integer; dictStart: pAnsiChar; dictSize: integer): integer; inline;
begin
    if dictSize = 0 then
        exit(LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, integer(full), 0, integer(noDict),
          pByte(dest), Nil, 0));
    if (dictStart + dictSize = dest) then
    begin
        if dictSize >= integer(65536 - 1) then
            exit(LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, integer(full), 0, integer(withPrefix64k),
              pByte(dest) - 65536, Nil, 0));
        exit(LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, integer(full), 0, integer(noDict),
          pByte(dest) - dictSize, Nil, 0));
    end;
    result := LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, safe, integer(full), 0, integer(usingExtDict),
      pByte(dest), pByte(dictStart), dictSize);
end;

function LZ4_decompress_fast_usingDict(source: pAnsiChar; dest: pAnsiChar; originalSize: integer; const dictStart: pAnsiChar;
  dictSize: integer): integer;
begin
    result := LZ4_decompress_usingDict_generic(source, dest, 0, originalSize, 0, dictStart, dictSize);
end;

function LZ4_decompress_safe_withPrefix64k(source: pAnsiChar; dest: pAnsiChar; compressedSize: integer; maxOutputSize: integer): integer;
begin
    result := LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, integer(endOnInputSize), integer(full), 0,
      integer(withPrefix64k), pByte(dest) - 65536, Nil, 65536);
end;

function LZ4_decompress_safe_usingDict(const source: pAnsiChar; dest: pAnsiChar; compressedSize: integer; maxOutputSize: integer;
  const dictStart: pAnsiChar; dictSize: integer): integer;
begin
    result := LZ4_decompress_usingDict_generic(source, dest, compressedSize, maxOutputSize, 1, dictStart, dictSize);
end;

function LZ4_decompress_safe_partial(const source: pAnsiChar; dest: pAnsiChar; compressedSize: integer; targetOutputSize: integer;
  maxDecompressedSize: integer): integer;
begin
    result := LZ4_decompress_generic(source, dest, compressedSize, maxDecompressedSize, integer(endOnInputSize), integer(partial),
      targetOutputSize, integer(noDict), pByte(dest), Nil, 0);
end;

function LZ4_decompress_safe_forceExtDict(source: pAnsiChar; dest: pAnsiChar; compressedSize: integer; maxOutputSize: integer;
  const dictStart: pAnsiChar; dictSize: integer): integer;
begin
    result := LZ4_decompress_generic(source, dest, compressedSize, maxOutputSize, integer(endOnInputSize), integer(full), 0,
      integer(usingExtDict), pByte(dest), pByte(dictStart), dictSize);
end;

end.
