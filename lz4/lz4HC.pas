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

unit lz4HC;
{$POINTERMATH ON}
{$Q-} // doesn't work with overflow checking

interface

uses Windows, lz4Common;

const
    LZ4_STREAMHCSIZE_U64 = 32774;

type
    PLZ4_streamHC_t = ^LZ4_streamHC_t;

    LZ4_streamHC_t = record
        table: array [0 .. LZ4_STREAMHCSIZE_U64 - 1] of uint64;
    end;

function LZ4_createStreamHC: PLZ4_streamHC_t;
procedure LZ4_freeStreamHC(LZ4_streamHCPtr: PLZ4_streamHC_t);
function LZ4_compressHC2(const source: pAnsiChar; dest: pAnsiChar; inputSize: integer; compressionLevel: integer): integer;
function LZ4_compressHC(source: pAnsiChar; dest: pAnsiChar; inputSize: integer): integer;
function LZ4_compressHC_limitedOutput(const source: pAnsiChar; dest: pAnsiChar; inputSize: integer; maxOutputSize: integer): integer;
function LZ4_compressHC2_limitedOutput(const source: pAnsiChar; dest: pAnsiChar; inputSize: integer; maxOutputSize: integer;
  compressionLevel: integer): integer;
function LZ4_compressHC_withStateHC(state: pointer; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer): integer;
function LZ4_compressHC2_withStateHC(state: pointer; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer;
  compressionLevel: integer): integer;
function LZ4_compressHC_limitedOutput_withStateHC(state: pointer; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer;
  maxOutputSize: integer): integer;
function LZ4_compressHC2_limitedOutput_withStateHC(state: pointer; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer;
  maxOutputSize: integer; compressionLevel: integer): integer;
function LZ4_createHC(inputBuffer: pAnsiChar): pointer;
function LZ4_compressHC_continue(LZ4_streamHCPtr: PLZ4_streamHC_t; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer): integer;
function LZ4_loadDictHC(LZ4_streamHCPtr: PLZ4_streamHC_t; dictionary: pAnsiChar; dictSize: integer): integer;
function LZ4_compressHC_limitedOutput_continue(LZ4_streamHCPtr: PLZ4_streamHC_t; const source: pAnsiChar; dest: pAnsiChar;
  inputSize: integer; maxOutputSize: integer): integer;
procedure LZ4_resetStreamHC(LZ4_streamHCPtr: PLZ4_streamHC_t; compressionLevel: integer);
function LZ4_saveDictHC(LZ4_streamHCPtr: PLZ4_streamHC_t; safeBuffer: pAnsiChar; dictSize: integer): integer;

implementation

const
    DICTIONARY_LOGSIZE = 16;
    MAXD = (1 shl DICTIONARY_LOGSIZE);
    HASH_LOG = (DICTIONARY_LOGSIZE - 1);
    HASHTABLESIZE = (1 shl HASH_LOG);
    OPTIMAL_ML = integer((ML_MASK - 1) + MINMATCH);

    g_maxCompressionLevel: integer = 16;
    LZ4HC_compressionLevel_default: integer = 8;

type
    PLZ4HC_Data_Structure = ^LZ4HC_Data_Structure;

    LZ4HC_Data_Structure = record
        hashTable: array [0 .. HASHTABLESIZE - 1] of cardinal;
        chainTable: array [0 .. MAXD - 1] of word;
        _end: pByte;
        base: pByte;
        dictBase: pByte;
        inputBuffer: pByte;
        dictLimit: cardinal;
        lowLimit: cardinal;
        nextToUpdate: cardinal;
        compressionLevel: cardinal;
    end;

    limitedOutput_directive = (noLimit = 0, limitedOutput = 1);

function LZ4_createStreamHC: PLZ4_streamHC_t;
begin
    result := allocmem(sizeof(LZ4_streamHC_t));
end;

procedure LZ4_freeStreamHC(LZ4_streamHCPtr: PLZ4_streamHC_t);
begin
    freemem(LZ4_streamHCPtr);
end;

procedure LZ4HC_init(hc4: PLZ4HC_Data_Structure; const start: pByte);
begin
    fillchar(hc4.hashTable, sizeof(hc4.hashTable), 0);
    fillchar(hc4.chainTable, sizeof(hc4.chainTable), 255);
    hc4.nextToUpdate := 65536;
    hc4.base := start - 65536;
    hc4.inputBuffer := start;
    hc4._end := start;
    hc4.dictBase := start - 65536;
    hc4.dictLimit := 65536;
    hc4.lowLimit := 65536;
end;

function HASH_FUNCTION(i: cardinal): cardinal; inline;
begin
    result := (i * 2654435761) shr ((MINMATCH * 8) - HASH_LOG);
end;

function LZ4HC_hashPtr(const ptr: pointer): cardinal; inline;
begin
    result := HASH_FUNCTION(pCardinal(ptr)^);
end;

procedure LZ4HC_Insert(hc4: PLZ4HC_Data_Structure; const ip: pByte); inline;
var
    chainTable: pWord;
    hashTable: pCardinal;
    base: pByte;
    target: cardinal;
    idx: cardinal;
    h: cardinal;
    delta: size_t;
begin
    chainTable := @hc4.chainTable;
    hashTable := @hc4.hashTable;
    base := hc4.base;
    target := cardinal(ip - base);
    idx := hc4.nextToUpdate;

    while idx < target do
    begin
        h := LZ4HC_hashPtr(base + idx);
        delta := idx - hashTable[h];
        if (delta > MAX_DISTANCE) then
            delta := MAX_DISTANCE;
        chainTable[idx and $FFFF] := word(delta);
        hashTable[h] := idx;
        inc(idx);
    end;
    hc4.nextToUpdate := target;
end;

function LZ4HC_InsertAndFindBestMatch(hc4: PLZ4HC_Data_Structure; const ip: pByte; const iLimit: pByte;
  const matchpos: ppByte; const maxNbAttempts: integer): integer; inline;
var
    chainTable: pWord;
    hashTable: pCardinal;
    base: pByte;
    dictBase: pByte;
    dictLimit: cardinal;
    lowLimit: cardinal;
    matchIndex: cardinal;
    match: pByte;
    nbAttempts: integer;
    ml: size_t;
    mlt: size_t;
    vLimit: pByte;
begin
    chainTable := @hc4.chainTable;
    hashTable := @hc4.hashTable;
    base := hc4.base;
    dictBase := hc4.dictBase;
    dictLimit := hc4.dictLimit;
    if hc4.lowLimit + 65536 > cardinal(ip - base) then
        lowLimit := hc4.lowLimit
    else
        lowLimit := cardinal(ip - base) - 65535;
    nbAttempts := maxNbAttempts;
    ml := 0;
    LZ4HC_Insert(hc4, ip);
    matchIndex := hashTable[LZ4HC_hashPtr(ip)];
    while (matchIndex >= lowLimit) and (nbAttempts > 0) do
    begin
        dec(nbAttempts);
        if matchIndex >= dictLimit then
        begin
            match := base + matchIndex;
            if ((match + ml)^ = (ip + ml)^) and (pCardinal(match)^ = pCardinal(ip)^) then
            begin
                mlt := LZ4_count(ip + MINMATCH, match + MINMATCH, iLimit) + MINMATCH;
                if mlt > ml then
                begin
                    ml := mlt;
                    matchpos^ := match;
                end;
            end;
        end
        else
        begin
            match := dictBase + matchIndex;
            if pCardinal(match)^ = pCardinal(ip)^ then
            begin
                vLimit := ip + (dictLimit - matchIndex);
                if (vLimit > iLimit) then
                    vLimit := iLimit;
                mlt := LZ4_count(ip + MINMATCH, match + MINMATCH, vLimit) + MINMATCH;
                if ((ip + mlt = vLimit) and (vLimit < iLimit)) then
                    inc(mlt, LZ4_count(ip + mlt, base + dictLimit, iLimit));
                if (mlt > ml) then
                begin
                    ml := mlt;
                    matchpos^ := base + matchIndex;
                end; // virtual matchpos
            end;
        end;
        dec(matchIndex, chainTable[matchIndex and $FFFF]);
    end;
    result := integer(ml);
end;

function LZ4HC_InsertAndGetWiderMatch(hc4: PLZ4HC_Data_Structure; const ip: pByte; const iLowLimit: pByte;
  const iHighLimit: pByte; longest: integer; const matchpos: ppByte; const startpos: ppByte; const maxNbAttempts: integer): integer; inline;
var
    chainTable: pWord;
    hashTable: pCardinal;
    base: pByte;
    dictLimit: cardinal;
    lowLimit: cardinal;
    dictBase: pByte;
    match: pByte;
    matchIndex: cardinal;
    nbAttempts: integer;
    delta: integer;
    startt: pByte;
    tmpMatch: pByte;
    matchEnd: pByte;
    mlt: size_t;
    back: integer;
    vLimit: pByte;
begin
    chainTable := @hc4.chainTable;
    hashTable := @hc4.hashTable;
    base := hc4.base;
    dictLimit := hc4.dictLimit;
    if (hc4.lowLimit + 65536 > cardinal(ip - base)) then
        lowLimit := hc4.lowLimit
    else
        lowLimit := cardinal(ip - base) - 65535;
    dictBase := hc4.dictBase;
    nbAttempts := maxNbAttempts;
    delta := integer(ip - iLowLimit);
    LZ4HC_Insert(hc4, ip);
    matchIndex := hashTable[LZ4HC_hashPtr(ip)];
    while (matchIndex >= lowLimit) and (nbAttempts > 0) do
    begin
        dec(nbAttempts);
        if matchIndex >= dictLimit then
        begin
            match := base + matchIndex;
            if ((iLowLimit + longest)^ = (match - delta + longest)^) then
                if pCardinal(match)^ = pCardinal(ip)^ then
                begin
                    startt := ip;
                    tmpMatch := match;
                    matchEnd := ip + MINMATCH + LZ4_count(ip + MINMATCH, match + MINMATCH, iHighLimit);
                    while (startt > iLowLimit) and (tmpMatch > iLowLimit) and (startt[-1] = tmpMatch[-1]) do
                    begin
                        dec(startt);
                        dec(tmpMatch);
                    end;
                    if (matchEnd - startt) > longest then
                    begin
                        longest := integer(matchEnd - startt);
                        matchpos^ := tmpMatch;
                        startpos^ := startt;
                    end;
                end;
        end
        else
        begin
            match := dictBase + matchIndex;
            if pCardinal(match)^ = pCardinal(ip)^ then
            begin
                back := 0;
                vLimit := ip + (dictLimit - matchIndex);
                if vLimit > iHighLimit then
                    vLimit := iHighLimit;
                mlt := LZ4_count(ip + MINMATCH, match + MINMATCH, vLimit) + MINMATCH;
                if (ip + mlt = vLimit) and (vLimit < iHighLimit) then
                    inc(mlt, LZ4_count(ip + mlt, base + dictLimit, iHighLimit));
                while ((ip + back > iLowLimit) and (matchIndex + cardinal(back) > lowLimit) and (ip[back - 1] = match[back - 1])) do
                    dec(back);
                dec(mlt, back);
                if integer(mlt) > longest then
                begin
                    longest := integer(mlt);
                    matchpos^ := base + matchIndex + back;
                    startpos^ := ip + back;
                end;
            end;
        end;
        dec(matchIndex, chainTable[matchIndex and $FFFF]);
    end;
    result := longest;
end;

function LZ4HC_encodeSequence(const ip: ppByte; op: ppByte; const anchor: ppByte; matchLength: integer;
  const match: pByte; limitedOutputBuffer: limitedOutput_directive; oend: pByte): integer; inline;
var
    length: integer;
    token: pByte;
    len: integer;
begin
    length := integer(ip^ - anchor^);
    token := op^;
    inc(op^);
    if (limitedOutputBuffer <> noLimit) and ((op^ + (length shr 8) + length + (2 + 1 + LASTLITERALS)) > oend) then
        exit(1);

    if length >= integer(RUN_MASK) then
    begin
        token^ := (RUN_MASK shl ML_BITS);
        len := length - RUN_MASK;
        while len > 254 do
        begin
            op^^ := 255;
            inc(op^);
            dec(len, 255)
        end;
        op^^ := byte(len);
        inc(op^);
    end
    else
        token^ := byte(length shl ML_BITS);

    LZ4_wildCopy(op^, anchor^, op^ + length);

    inc(op^, length);
    pWord(op^)^ := word(ip^ - match); // ?
    inc(op^, 2);

    length := integer(matchLength - MINMATCH);
    if (limitedOutputBuffer <> noLimit) and (op^ + (length shr 8) + (1 + LASTLITERALS) > oend) then
        exit(1);
    if length >= integer(ML_MASK) then
    begin
        inc(token^, ML_MASK);
        dec(length, ML_MASK);
        while length > 509 do
        begin
            op^^ := 255;
            inc(op^);
            op^^ := 255;
            inc(op^);
            dec(length, 510);
        end;
        if (length > 254) then
        begin
            dec(length, 255);
            op^^ := 255;
            inc(op^);
        end;
        op^^ := byte(length);
        inc(op^);
    end
    else
        inc(token^, byte(length));
    inc(ip^, matchLength);
    anchor^ := ip^;
    result := 0;
end;

function LZ4HC_compress_generic(ctxvoid: pointer; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer;
  maxOutputSize: integer; compressionLevel: integer; limit: limitedOutput_directive): integer;
var
    ctx: PLZ4HC_Data_Structure;
    ip: pByte;
    anchor: pByte;
    iend: pByte;
    mflimit: pByte;
    matchlimit: pByte;
    op: pByte;
    oend: pByte;
    maxNbAttempts: cardinal;
    ml, ml2, ml3, ml0: integer;
    ref: pByte;
    start2: pByte;
    ref2: pByte;
    start3: pByte;
    ref3: pByte;
    start0: pByte;
    ref0: pByte;
    correction: integer;
    new_ml: integer;
    lastRun: integer;
label
    _Search2, _Search3;
begin
    ctx := ctxvoid;
    ip := pByte(source);
    anchor := ip;
    iend := ip + inputSize;
    mflimit := iend - _MFLIMIT;
    matchlimit := (iend - LASTLITERALS);
    op := pByte(dest);
    oend := op + maxOutputSize;
    ref := nil;
    start2 := nil;
    ref2 := nil;
    start3 := nil;
    ref3 := nil;

    // init
    if compressionLevel > g_maxCompressionLevel then
        compressionLevel := g_maxCompressionLevel;
    if (compressionLevel < 1) then
        compressionLevel := LZ4HC_compressionLevel_default;
    maxNbAttempts := 1 shl (compressionLevel - 1);
    inc(ctx._end, inputSize);
    inc(ip);

    // Main Loop
    while ip < mflimit do
    begin
        ml := LZ4HC_InsertAndFindBestMatch(ctx, ip, matchlimit, (@ref), maxNbAttempts);
        if (ml = 0) then
        begin
            inc(ip);
            continue;
        end;

        // saved, in case we would skip too much
        start0 := ip;
        ref0 := ref;
        ml0 := ml;
    _Search2:

        if ip + ml < mflimit then
            ml2 := LZ4HC_InsertAndGetWiderMatch(ctx, ip + ml - 2, ip + 1, matchlimit, ml, @ref2, @start2, maxNbAttempts)
        else
            ml2 := ml;

        if (ml2 = ml) then // No better match
        begin
            if LZ4HC_encodeSequence(@ip, @op, @anchor, ml, ref, limit, oend) > 0 then
                exit(0);
            continue;
        end;

        if start0 < ip then
        begin
            if start2 < ip + ml0 then // empirical
            begin
                ip := start0;
                ref := ref0;
                ml := ml0;
            end;
        end;

        // Here, start0==ip
        if ((start2 - ip) < 3) then // First Match too small : removed
        begin
            ml := ml2;
            ip := start2;
            ref := ref2;
            goto _Search2;
        end;

    _Search3:

        if (start2 - ip) < OPTIMAL_ML then
        begin
            new_ml := ml;
            if new_ml > OPTIMAL_ML then
                new_ml := OPTIMAL_ML;
            if ip + new_ml > start2 + ml2 - MINMATCH then
                new_ml := integer(start2 - ip) + ml2 - MINMATCH;
            correction := new_ml - integer(start2 - ip);
            if (correction > 0) then
            begin
                inc(start2, correction);
                inc(ref2, correction);
                dec(ml2, correction);
            end;
        end;
        // Now, we have start2 = ip+new_ml, with new_ml = min(ml, OPTIMAL_ML=18)

        if start2 + ml2 < mflimit then
            ml3 := LZ4HC_InsertAndGetWiderMatch(ctx, start2 + ml2 - 3, start2, matchlimit, ml2, @ref3, @start3, maxNbAttempts)
        else
            ml3 := ml2;

        if (ml3 = ml2) then // No better match : 2 sequences to encode
        begin
            // ip & ref are known; Now for ml
            if start2 < ip + ml then
                ml := integer(start2 - ip);
            // Now, encode 2 sequences
            if LZ4HC_encodeSequence(@ip, @op, @anchor, ml, ref, limit, oend) <> 0 then
                exit(0);
            ip := start2;
            if LZ4HC_encodeSequence(@ip, @op, @anchor, ml2, ref2, limit, oend) <> 0 then
                exit(0);
            continue;
        end;

        if start3 < ip + ml + 3 then // Not enough space for match 2 : remove it
        begin
            if start3 >= (ip + ml) then // can write Seq1 immediately ==> Seq2 is removed, so Seq3 becomes Seq1
            begin
                if start2 < ip + ml then
                begin
                    correction := integer(ip + ml - start2);
                    inc(start2, correction);
                    inc(ref2, correction);
                    dec(ml2, correction);
                    if ml2 < MINMATCH then
                    begin
                        start2 := start3;
                        ref2 := ref3;
                        ml2 := ml3;
                    end;
                end;
                if LZ4HC_encodeSequence(@ip, @op, @anchor, ml, ref, limit, oend) <> 0 then
                    exit(0);
                ip := start3;
                ref := ref3;
                ml := ml3;

                start0 := start2;
                ref0 := ref2;
                ml0 := ml2;
                goto _Search2;
            end;
            start2 := start3;
            ref2 := ref3;
            ml2 := ml3;
            goto _Search3;
        end;

        (*
          * OK, now we have 3 ascending matches; let's write at least the first one
          * ip & ref are known; Now for ml
        *)
        if start2 < ip + ml then
        begin
            if (start2 - ip) < integer(ML_MASK) then
            begin
                if ml > OPTIMAL_ML then
                    ml := OPTIMAL_ML;
                if ip + ml > start2 + ml2 - MINMATCH then
                    ml := integer(start2 - ip) + ml2 - MINMATCH;
                correction := ml - integer(start2 - ip);
                if correction > 0 then
                begin
                    inc(start2, correction);
                    inc(ref2, correction);
                    dec(ml2, correction);
                end;
            end
            else
                ml := integer(start2 - ip);
        end;
        if LZ4HC_encodeSequence(@ip, @op, @anchor, ml, ref, limit, oend) <> 0 then
            exit(0);

        ip := start2;
        ref := ref2;
        ml := ml2;

        start2 := start3;
        ref2 := ref3;
        ml2 := ml3;

        goto _Search3;
    end;

    lastRun := integer(iend - anchor);
    if (limit <> noLimit) and ((op - pByte(dest)) + lastRun + 1 + ((lastRun + 255 - RUN_MASK) div 255) > maxOutputSize) then
        exit(0);
    if lastRun >= integer(RUN_MASK) then
    begin
        op^ := RUN_MASK shl ML_BITS;
        inc(op);
        dec(lastRun, RUN_MASK);
        while lastRun > 254 do
        begin
            op^ := 255;
            inc(op);
            dec(lastRun, 255);
        end;
        op^ := byte(lastRun);
        inc(op);
    end
    else
    begin
        op^ := byte(lastRun shl ML_BITS);
        inc(op);
    end;
    move(anchor^, op^, iend - anchor);
    inc(op, iend - anchor);
    result := integer(op - pByte(dest));
end;

function LZ4_compressHC2(const source: pAnsiChar; dest: pAnsiChar; inputSize: integer; compressionLevel: integer): integer;
var
    ctx: LZ4HC_Data_Structure;
begin
    fillchar(ctx, sizeof(LZ4HC_Data_Structure), 0);
    LZ4HC_init(@ctx, pByte(source));
    result := LZ4HC_compress_generic(@ctx, source, dest, inputSize, 0, compressionLevel, noLimit);
end;

function LZ4_compressHC(source: pAnsiChar; dest: pAnsiChar; inputSize: integer): integer;
begin
    result := LZ4_compressHC2(source, dest, inputSize, 0);
end;

function LZ4_compressHC_limitedOutput(const source: pAnsiChar; dest: pAnsiChar; inputSize: integer; maxOutputSize: integer): integer;
begin
    result := LZ4_compressHC2_limitedOutput(source, dest, inputSize, maxOutputSize, 0);
end;

function LZ4_compressHC2_limitedOutput(const source: pAnsiChar; dest: pAnsiChar; inputSize: integer; maxOutputSize: integer;
  compressionLevel: integer): integer;
var
    ctx: LZ4HC_Data_Structure;
begin
    fillchar(ctx, sizeof(LZ4HC_Data_Structure), 0);
    LZ4HC_init(@ctx, pByte(source));
    result := LZ4HC_compress_generic(@ctx, source, dest, inputSize, maxOutputSize, compressionLevel, limitedOutput);
end;

function LZ4_compressHC_withStateHC(state: pointer; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer): integer;
begin
    result := LZ4_compressHC2_withStateHC(state, source, dest, inputSize, 0);
end;

function LZ4_compressHC2_withStateHC(state: pointer; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer;
  compressionLevel: integer): integer;
begin
    if (size_t(state) and (sizeof(pointer) - 1)) <> 0 then
        exit(0); // Error : : state is not aligned for pointers (32 or 64 bits) */
    LZ4HC_init(PLZ4HC_Data_Structure(state), pByte(source));
    result := LZ4HC_compress_generic(state, source, dest, inputSize, 0, compressionLevel, noLimit);
end;

function LZ4_compressHC_limitedOutput_withStateHC(state: pointer; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer;
  maxOutputSize: integer): integer;
begin
    result := LZ4_compressHC2_limitedOutput_withStateHC(state, source, dest, inputSize, maxOutputSize, 0);
end;

function LZ4_compressHC2_limitedOutput_withStateHC(state: pointer; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer;
  maxOutputSize: integer; compressionLevel: integer): integer;
begin
    if (size_t(state) and (sizeof(pointer) - 1)) <> 0 then
        exit(0); // Error : : state is not aligned for pointers (32 or 64 bits) */
    LZ4HC_init(PLZ4HC_Data_Structure(state), pByte(source));
    result := LZ4HC_compress_generic(state, source, dest, inputSize, maxOutputSize, compressionLevel, limitedOutput);
end;

function LZ4_createHC(inputBuffer: pAnsiChar): pointer;
var
    hc4: pointer;
begin
    hc4 := allocmem(sizeof(LZ4HC_Data_Structure));
    LZ4HC_init(PLZ4HC_Data_Structure(hc4), pByte(inputBuffer));
    result := hc4;
end;

procedure LZ4HC_setExternalDict(ctxPtr: PLZ4HC_Data_Structure; const newBlock: pByte);
begin
    if ctxPtr._end >= ctxPtr.base + 4 then
        LZ4HC_Insert(ctxPtr, ctxPtr._end - 3); // Referencing remaining dictionary content
    // Only one memory segment for extDict, so any previous extDict is lost at this stage
    ctxPtr.lowLimit := ctxPtr.dictLimit;
    ctxPtr.dictLimit := cardinal(ctxPtr._end - ctxPtr.base);
    ctxPtr.dictBase := ctxPtr.base;
    ctxPtr.base := newBlock - ctxPtr.dictLimit;
    ctxPtr._end := newBlock;
    ctxPtr.nextToUpdate := ctxPtr.dictLimit; // match referencing will resume from there
end;

function LZ4_compressHC_continue_generic(ctxPtr: PLZ4HC_Data_Structure;
  const source: pAnsiChar; dest: pAnsiChar;
  inputSize: integer; maxOutputSize: integer; limit: limitedOutput_directive): integer;
var
    dictSize: size_t;
    sourceEnd: pByte;
    dictBegin: pByte;
    dictEnd: pByte;
begin
    // auto-init if forgotten
    if (ctxPtr.base = Nil) then
        LZ4HC_init(ctxPtr, pByte(source));

    // Check overflow
    if size_t(ctxPtr._end - ctxPtr.base) > 2147483648 then
    begin
        dictSize := size_t(ctxPtr._end - ctxPtr.base) - ctxPtr.dictLimit;
        if (dictSize > 65536) then
            dictSize := 65536;
        LZ4_loadDictHC(PLZ4_streamHC_t(ctxPtr), pAnsiChar(ctxPtr._end) - dictSize, integer(dictSize));
    end;

    // Check if blocks follow each other
    if (pByte(source) <> ctxPtr._end) then
        LZ4HC_setExternalDict(ctxPtr, pByte(source));

    // Check overlapping input/dictionary space
    sourceEnd := pByte(source) + inputSize;
    dictBegin := ctxPtr.dictBase + ctxPtr.lowLimit;
    dictEnd := ctxPtr.dictBase + ctxPtr.dictLimit;
    if (sourceEnd > dictBegin) and (pByte(source) < dictEnd) then
    begin
        if sourceEnd > dictEnd then
            sourceEnd := dictEnd;
        ctxPtr.lowLimit := cardinal(sourceEnd - ctxPtr.dictBase);
        if ctxPtr.dictLimit - ctxPtr.lowLimit < 4 then
            ctxPtr.lowLimit := ctxPtr.dictLimit;
    end;
    result := LZ4HC_compress_generic(ctxPtr, source, dest, inputSize, maxOutputSize, ctxPtr.compressionLevel, limit);
end;

function LZ4_compressHC_continue(LZ4_streamHCPtr: PLZ4_streamHC_t; const source: pAnsiChar; dest: pAnsiChar; inputSize: integer): integer;
begin
    result := LZ4_compressHC_continue_generic(PLZ4HC_Data_Structure(LZ4_streamHCPtr), source, dest, inputSize, 0, noLimit);
end;

function LZ4_loadDictHC(LZ4_streamHCPtr: PLZ4_streamHC_t; dictionary: pAnsiChar; dictSize: integer): integer;
var
    ctxPtr: PLZ4HC_Data_Structure;
begin
    ctxPtr := PLZ4HC_Data_Structure(LZ4_streamHCPtr);
    if dictSize > 65536 then
    begin
        inc(dictionary, dictSize - 65536);
        dictSize := 65536;
    end;
    LZ4HC_init(ctxPtr, pByte(dictionary));
    if (dictSize >= 4) then
        LZ4HC_Insert(ctxPtr, pByte(dictionary) + (dictSize - 3));
    ctxPtr._end := pByte(dictionary) + dictSize;
    result := dictSize;
end;

function LZ4_compressHC_limitedOutput_continue(LZ4_streamHCPtr: PLZ4_streamHC_t; const source: pAnsiChar; dest: pAnsiChar;
  inputSize: integer; maxOutputSize: integer): integer;
begin
    result := LZ4_compressHC_continue_generic(PLZ4HC_Data_Structure(LZ4_streamHCPtr), source, dest, inputSize, maxOutputSize,
      limitedOutput);
end;

procedure LZ4_resetStreamHC(LZ4_streamHCPtr: PLZ4_streamHC_t; compressionLevel: integer);
begin
    PLZ4HC_Data_Structure(LZ4_streamHCPtr).base := Nil;
    PLZ4HC_Data_Structure(LZ4_streamHCPtr).compressionLevel := cardinal(compressionLevel);
end;

function LZ4_saveDictHC(LZ4_streamHCPtr: PLZ4_streamHC_t; safeBuffer: pAnsiChar; dictSize: integer): integer;
var
    streamPtr: PLZ4HC_Data_Structure;
    prefixSize: integer;
    endIndex: cardinal;
begin
    streamPtr := PLZ4HC_Data_Structure(LZ4_streamHCPtr);
    prefixSize := integer((streamPtr._end - (streamPtr.base + streamPtr.dictLimit)));
    if dictSize > 65536 then
        dictSize := 65536;
    if dictSize < 4 then
        dictSize := 0;
    if (dictSize > prefixSize) then
        dictSize := prefixSize;
    move((streamPtr._end - dictSize)^, safeBuffer^, dictSize);
    endIndex := cardinal(streamPtr._end - streamPtr.base);
    streamPtr._end := pByte(safeBuffer) + dictSize;
    streamPtr.base := streamPtr._end - endIndex;
    streamPtr.dictLimit := endIndex - cardinal(dictSize);
    streamPtr.lowLimit := endIndex - cardinal(dictSize);
    if streamPtr.nextToUpdate < streamPtr.dictLimit then
        streamPtr.nextToUpdate := streamPtr.dictLimit;
    result:=dictSize;
end;

end.
