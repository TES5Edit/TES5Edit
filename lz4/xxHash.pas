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

unit xxHash;
{$POINTERMATH ON}
{$Q-} // doesn't work with overflow checking

interface

uses Windows, lz4common;

const
    PRIME32_1: cardinal = 2654435761;
    PRIME32_2: cardinal = 2246822519;
    PRIME32_3: cardinal = 3266489917;
    PRIME32_4: cardinal = 668265263;
    PRIME32_5: cardinal = 374761393;
    PRIME64_1: uint64 = 11400714785074694791;
    PRIME64_2: uint64 = 14029467366897019727;
    PRIME64_3: uint64 = 1609587929392839161;
    PRIME64_4: uint64 = 9650029242287828579;
    PRIME64_5: uint64 = 2870177450012600261;

type
    XXH_errorcode = (XXH_OK = 0, XXH_ERROR);
    XXH_endianess = (XXH_bigEndian = 0, XXH_littleEndian = 1);
    XXH_alignment = (XXH_aligned, XXH_unaligned);

    PXXH32_state_t = ^XXH32_state_t;

    XXH32_state_t = record
        ll: array [0 .. 5] of int64;
    end;

    PXXH_istate32_t = ^XXH_istate32_t;

    XXH_istate32_t = record
        total_len: uint64;
        seed: cardinal;
        v1: cardinal;
        v2: cardinal;
        v3: cardinal;
        v4: cardinal;
        mem32: array [0 .. 3] of cardinal;
        memsize: cardinal;
    end;

    PXXH64_state_t = ^XXH64_state_t;

    XXH64_state_t = record
        ll: array [0 .. 10] of int64;
    end;

    PXXH_istate64_t = ^XXH_istate64_t;

    XXH_istate64_t = record
        total_len: uint64;
        seed: uint64;
        v1: uint64;
        v2: uint64;
        v3: uint64;
        v4: uint64;
        mem64: array [0 .. 3] of uint64;
        memsize: cardinal;
    end;

function XXH32(input: pointer; len: size_t; seed: cardinal): cardinal;

function XXH32_reset(statePtr: PXXH32_state_t; seed: cardinal): XXH_errorcode;
function XXH32_update(statePtr: PXXH32_state_t; Ainput: pointer; ALength: size_t): XXH_errorcode;
function XXH32_digest(statePtr: PXXH32_state_t): cardinal;
function XXH32_createState: PXXH32_state_t;
procedure XXH32_freeState(statePtr: PXXH32_state_t);
// Obsolet in recent release
function XXH32_init(seed: cardinal): PXXH32_state_t;

function XXH64_reset(statePtr: PXXH64_state_t; seed: uint64): XXH_errorcode;
function XXH64_update(statePtr: PXXH64_state_t; Ainput: pointer; ALength: size_t): XXH_errorcode;
function XXH64_digest(statePtr: PXXH64_state_t): uint64;
function XXH64_createState: PXXH64_state_t;
procedure XXH64_freeState(statePtr: PXXH64_state_t);
// Obsolet in recent release
function XXH64_init(seed: uint64): PXXH64_state_t;

implementation

type
    PU32_S = ^U32_S;

    U32_S = packed record
        v: cardinal;
    end;

    PU64_S = ^U64_S;

    U64_S = packed record
        v: uint64;
    end;

function XXH_rotl32(x, r: cardinal): cardinal;
asm
    mov eax, x
    mov ecx, r
    rol eax, cl
end;

(*  Alternative
function XXH_rotl32(x, r: cardinal): cardinal; inline;
var
    temp: cardinal;
begin
    temp := x;
    result := (x shl r) or (temp shr (32 - r));
end;
*)
{$IFDEF CPUX64}

function XXH_rotl64(x: uint64; r: cardinal): uint64;
asm
    mov rax, x
    mov ecx, r
    rol rax, cl
end;
{$ELSE}

function XXH_rotl64(x: uint64; r: cardinal): uint64; inline
var
    temp: uint64;
begin
    temp := x;
    result := (x shl r) or (temp shr (64 - r));
end;

{$ENDIF}

function A32(x: pointer): cardinal; inline;
begin
    result := PU32_S(x).v;
end;

function A64(x: pointer): uint64; inline;
begin
    result := PU64_S(x).v;
end;

function XXH_readLE32_align(ptr: pointer; endian: XXH_endianess; align: XXH_alignment): cardinal; inline;
begin
    if align = XXH_unaligned then
        result := A32(ptr)
    else
        result := pcardinal(ptr)^;
end;

function XXH_readLE32(ptr: pointer): cardinal; inline;
begin
    result := XXH_readLE32_align(ptr, XXH_littleEndian, XXH_unaligned);
end;

function XXH_readLE64_align(ptr: pointer; endian: XXH_endianess; align: XXH_alignment): uint64; inline;
begin
    if align = XXH_unaligned then
        result := A64(ptr)
    else
        result := puint64(ptr)^;
end;

function XXH_readLE64(ptr: pointer): uint64; inline;
begin
    result := XXH_readLE64_align(ptr, XXH_littleEndian, XXH_unaligned);
end;

function XXH32_reset(statePtr: PXXH32_state_t; seed: cardinal): XXH_errorcode;
var
    state: PXXH_istate32_t;
begin
    state := PXXH_istate32_t(statePtr);
    state.seed := seed;
    state.v1 := seed + PRIME32_1 + PRIME32_2;
    state.v2 := seed + PRIME32_2;
    state.v3 := seed + 0;
    state.v4 := seed - PRIME32_1;
    state.total_len := 0;
    state.memsize := 0;
    result := XXH_OK;
end;

function XXH64_reset(statePtr: PXXH64_state_t; seed: uint64): XXH_errorcode;
var
    state: PXXH_istate64_t;
begin
    state := PXXH_istate64_t(statePtr);
    state.seed := seed;
    state.v1 := seed + PRIME64_1 + PRIME64_2;
    state.v2 := seed + PRIME64_2;
    state.v3 := seed + 0;
    state.v4 := seed - PRIME64_1;
    state.total_len := 0;
    state.memsize := 0;
    result := XXH_OK;
end;

function XXH32_update(statePtr: PXXH32_state_t; Ainput: pointer; ALength: size_t): XXH_errorcode;
var
    state: PXXH_istate32_t;
    p: pByte;
    bEnd: pByte;
    p32: pcardinal;
    limit: pByte;
    v1, v2, v3, v4: cardinal;
begin
    state := PXXH_istate32_t(statePtr);
    p := Ainput;
    bEnd := p + ALength;
    inc(state.total_len, ALength);

    if (state.memsize + ALength < 16) then
    begin
        move(Ainput^, (pByte(@state.mem32) + state.memsize)^, ALength);
        inc(state.memsize, cardinal(ALength));
        exit(XXH_OK);
    end;
    if state.memsize > 0 then
    begin
        move(Ainput^, (pByte(@state.mem32) + state.memsize)^, 16 - state.memsize);
        p32 := @state.mem32;
        inc(state.v1, XXH_readLE32(p32) * PRIME32_2);
        state.v1 := XXH_rotl32(state.v1, 13);
        state.v1 := state.v1 * PRIME32_1;
        inc(p32);
        inc(state.v2, XXH_readLE32(p32) * PRIME32_2);
        state.v2 := XXH_rotl32(state.v2, 13);
        state.v2 := state.v2 * PRIME32_1;
        inc(p32);
        inc(state.v3, XXH_readLE32(p32) * PRIME32_2);
        state.v3 := XXH_rotl32(state.v3, 13);
        state.v3 := state.v3 * PRIME32_1;
        inc(p32);
        inc(state.v4, XXH_readLE32(p32) * PRIME32_2);
        state.v4 := XXH_rotl32(state.v4, 13);
        state.v4 := state.v4 * PRIME32_1;
//        inc(p32);
        inc(p, 16 - state.memsize);
        state.memsize := 0;
    end;

    if p <= (bEnd - 16) then
    begin
        limit := bEnd - 16;
        v1 := state.v1;
        v2 := state.v2;
        v3 := state.v3;
        v4 := state.v4;
        repeat
            inc(v1, XXH_readLE32(p) * PRIME32_2);
            v1 := XXH_rotl32(v1, 13);
            v1 := v1 * PRIME32_1;
            inc(p, 4);
            inc(v2, XXH_readLE32(p) * PRIME32_2);
            v2 := XXH_rotl32(v2, 13);
            v2 := v2 * PRIME32_1;
            inc(p, 4);
            inc(v3, XXH_readLE32(p) * PRIME32_2);
            v3 := XXH_rotl32(v3, 13);
            v3 := v3 * PRIME32_1;
            inc(p, 4);
            inc(v4, XXH_readLE32(p) * PRIME32_2);
            v4 := XXH_rotl32(v4, 13);
            v4 := v4 * PRIME32_1;
            inc(p, 4);
        until p > limit;
        state.v1 := v1;
        state.v2 := v2;
        state.v3 := v3;
        state.v4 := v4;
    end;

    if p < bEnd then
    begin
        move(p^, state.mem32, bEnd - p);
        state.memsize := integer(bEnd - p);
    end;
    result := XXH_OK;
end;

function XXH64_update(statePtr: PXXH64_state_t; Ainput: pointer; ALength: size_t): XXH_errorcode;
var
    state: PXXH_istate64_t;
    p: pByte;
    bEnd: pByte;
    p64: puint64;
    limit: pByte;
    v1, v2, v3, v4: uint64;
begin
    state := PXXH_istate64_t(statePtr);
    p := Ainput;
    bEnd := p + ALength;
    inc(state.total_len, ALength);

    if (state.memsize + ALength < 32) then
    begin
        move(Ainput^, (pByte(@state.mem64) + state.memsize)^, ALength);
        inc(state.memsize, cardinal(ALength));
        exit(XXH_OK);
    end;

    if state.memsize > 0 then
    begin
        move(Ainput^, (pByte(@state.mem64) + state.memsize)^, 32 - state.memsize);
        p64 := @state.mem64;
        inc(state.v1, XXH_readLE64(p64) * PRIME64_2);
        state.v1 := XXH_rotl64(state.v1, 31);
        state.v1 := state.v1 * PRIME64_1;
        inc(p64);
        inc(state.v2, XXH_readLE64(p64) * PRIME64_2);
        state.v2 := XXH_rotl64(state.v2, 31);
        state.v2 := state.v2 * PRIME64_1;
        inc(p64);
        inc(state.v3, XXH_readLE64(p64) * PRIME64_2);
        state.v3 := XXH_rotl64(state.v3, 31);
        state.v3 := state.v3 * PRIME64_1;
        inc(p64);
        inc(state.v4, XXH_readLE64(p64) * PRIME64_2);
        state.v4 := XXH_rotl64(state.v4, 31);
        state.v4 := state.v4 * PRIME64_1;
        inc(p, 32 - state.memsize);
        state.memsize := 0;
    end;

    if (p + 32) <= bEnd then
    begin
        limit := bEnd - 32;
        v1 := state.v1;
        v2 := state.v2;
        v3 := state.v3;
        v4 := state.v4;
        repeat
            inc(v1, XXH_readLE64(p) * PRIME64_2);
            v1 := XXH_rotl64(v1, 31);
            v1 := v1 * PRIME64_1;
            inc(p, 8);
            inc(v2, XXH_readLE64(p) * PRIME64_2);
            v2 := XXH_rotl64(v2, 31);
            v2 := v2 * PRIME64_1;
            inc(p, 8);
            inc(v3, XXH_readLE64(p) * PRIME64_2);
            v3 := XXH_rotl64(v3, 31);
            v3 := v3 * PRIME64_1;
            inc(p, 8);
            inc(v4, XXH_readLE64(p) * PRIME64_2);
            v4 := XXH_rotl64(v4, 31);
            v4 := v4 * PRIME64_1;
            inc(p, 8);
        until p > limit;
        state.v1 := v1;
        state.v2 := v2;
        state.v3 := v3;
        state.v4 := v4;
    end;

    if p < bEnd then
    begin
        move(p^, state.mem64, bEnd - p);
        state.memsize := integer(bEnd - p);
    end;
    result := XXH_OK;
end;

function XXH32_digest(statePtr: PXXH32_state_t): cardinal;
var
    state: PXXH_istate32_t;
    p: pByte;
    bEnd: pByte;
    h32: cardinal;
begin
    state := PXXH_istate32_t(statePtr);
    p := @state.mem32;
    bEnd := pByte(@state.mem32) + state.memsize;

    if (state.total_len >= 16) then
        h32 := XXH_rotl32(state.v1, 1) + XXH_rotl32(state.v2, 7) + XXH_rotl32(state.v3, 12) + XXH_rotl32(state.v4, 18)
    else
        h32 := state.seed + PRIME32_5;

    inc(h32, state.total_len);

    while (p + 4) <= bEnd do
    begin
        inc(h32, XXH_readLE32(p) * PRIME32_3);
        h32 := XXH_rotl32(h32, 17) * PRIME32_4;
        inc(p, 4);
    end;

    while p < bEnd do
    begin
        inc(h32, p^ * PRIME32_5);
        h32 := XXH_rotl32(h32, 11) * PRIME32_1;
        inc(p);
    end;
    h32 := h32 xor (h32 shr 15);
    h32 := h32 * PRIME32_2;
    h32 := h32 xor (h32 shr 13);
    h32 := h32 * PRIME32_3;
    h32 := h32 xor (h32 shr 16);
    result := h32;
end;

function XXH64_digest(statePtr: PXXH64_state_t): uint64;
var
    state: PXXH_istate64_t;
    p: pByte;
    bEnd: pByte;
    h64: uint64;
    v1, v2, v3, v4: uint64;
    k1: uint64;
begin
    state := PXXH_istate64_t(statePtr);
    p := @state.mem64;
    bEnd := pByte(@state.mem64) + state.memsize;

    if state.total_len >= 32 then
    begin
        v1 := state.v1;
        v2 := state.v2;
        v3 := state.v3;
        v4 := state.v4;
        h64 := XXH_rotl64(v1, 1) + XXH_rotl64(v2, 7) + XXH_rotl64(v3, 12) + XXH_rotl64(v4, 18);
        v1 := v1 * PRIME64_2;
        v1 := XXH_rotl64(v1, 31);
        v1 := v1 * PRIME64_1;
        h64 := h64 xor v1;
        h64 := h64 * PRIME64_1 + PRIME64_4;

        v2 := v2 * PRIME64_2;
        v2 := XXH_rotl64(v2, 31);
        v2 := v2 * PRIME64_1;
        h64 := h64 xor v2;
        h64 := h64 * PRIME64_1 + PRIME64_4;

        v3 := v3 * PRIME64_2;
        v3 := XXH_rotl64(v3, 31);
        v3 := v3 * PRIME64_1;
        h64 := h64 xor v3;
        h64 := h64 * PRIME64_1 + PRIME64_4;

        v4 := v4 * PRIME64_2;
        v4 := XXH_rotl64(v4, 31);
        v4 := v4 * PRIME64_1;
        h64 := h64 xor v4;
        h64 := h64 * PRIME64_1 + PRIME64_4;
    end
    else
        h64 := state.seed + PRIME64_5;
    inc(h64, state.total_len);

    while (p + 8) <= bEnd do
    begin
        k1 := XXH_readLE64(p);
        k1 := k1 * PRIME64_2;
        k1 := XXH_rotl64(k1, 31);
        k1 := k1 * PRIME64_1;
        h64 := h64 xor k1;
        h64 := XXH_rotl64(h64, 27) * PRIME64_1 + PRIME64_4;
        inc(p, 8);
    end;
    if (p + 4) <= bEnd then
    begin
        h64 := h64 xor (uint64(XXH_readLE32(p)) * PRIME64_1);
        h64 := XXH_rotl64(h64, 23) * PRIME64_2 + PRIME64_3;
        inc(p, 4);
    end;

    while (p < bEnd) do
    begin
        h64 := h64 xor (p^ * PRIME64_5);
        h64 := XXH_rotl64(h64, 11) * PRIME64_1;
        inc(p);
    end;

    h64 := h64 xor (h64 shr 33);
    h64 := h64 * PRIME64_2;
    h64 := h64 xor (h64 shr 29);
    h64 := h64 * PRIME64_3;
    h64 := h64 xor (h64 shr 32);

    result := h64;
end;

function XXH32_createState: PXXH32_state_t;
begin
    result := allocmem(sizeof(XXH32_state_t));
end;

function XXH64_createState: PXXH64_state_t;
begin
    result := allocmem(sizeof(XXH64_state_t));
end;

procedure XXH32_freeState(statePtr: PXXH32_state_t);
begin
    freemem(statePtr);
end;

procedure XXH64_freeState(statePtr: PXXH64_state_t);
begin
    freemem(statePtr);
end;

function XXH32_init(seed: cardinal): PXXH32_state_t;
begin
    result := XXH32_createState;
    XXH32_reset(result, seed);
end;

function XXH64_init(seed: uint64): PXXH64_state_t;
begin
    result := XXH64_createState;
    XXH64_reset(result, seed);
end;

function XXH32_endian_align(input: pointer; len: size_t; seed: cardinal; endian: XXH_endianess; align: XXH_alignment): cardinal;
    function XXH_get32bits(p: pByte): cardinal;
    begin
        result := XXH_readLE32_align(p, endian, align);
    end;

var
    p: pByte;
    bEnd: pByte;
    h32: cardinal;
    limit: pByte;
    v1, v2, v3, v4: cardinal;
begin
    p := input;
    bEnd := p + len;
    if (len >= 16) then
    begin
        limit := bEnd - 16;
        v1 := seed + PRIME32_1 + PRIME32_2;
        v2 := seed + PRIME32_2;
        v3 := seed + 0;
        v4 := seed - PRIME32_1;
        while true do
        begin
            inc(v1, XXH_get32bits(p) * PRIME32_2);
            v1 := XXH_rotl32(v1, 13);
            v1 := v1 * PRIME32_1;
            inc(p, 4);

            inc(v2, XXH_get32bits(p) * PRIME32_2);
            v2 := XXH_rotl32(v2, 13);
            v2 := v2 * PRIME32_1;
            inc(p, 4);

            inc(v3, XXH_get32bits(p) * PRIME32_2);
            v3 := XXH_rotl32(v3, 13);
            v3 := v3 * PRIME32_1;
            inc(p, 4);

            inc(v4, XXH_get32bits(p) * PRIME32_2);
            v4 := XXH_rotl32(v4, 13);
            v4 := v4 * PRIME32_1;
            inc(p, 4);
            if p > limit then
                break;
        end;
        h32 := XXH_rotl32(v1, 1) + XXH_rotl32(v2, 7) + XXH_rotl32(v3, 12) + XXH_rotl32(v4, 18);
    end
    else
        h32 := seed + PRIME32_5;

    inc(h32, cardinal(len));
    while (p + 4 <= bEnd) do
    begin
        inc(h32, XXH_get32bits(p) * PRIME32_3);
        h32 := XXH_rotl32(h32, 17) * PRIME32_4;
        inc(p, 4);
    end;

    while (p < bEnd) do
    begin
        inc(h32, p^ * PRIME32_5);
        h32 := XXH_rotl32(h32, 11) * PRIME32_1;
        inc(p);
    end;

    h32 := h32 xor (h32 shr 15);
    h32 := h32 * PRIME32_2;
    h32 := h32 xor (h32 shr 13);
    h32 := h32 * PRIME32_3;
    h32 := h32 xor (h32 shr 16);

    result := h32;
end;

function XXH32(input: pointer; len: size_t; seed: cardinal): cardinal;
begin
    result := XXH32_endian_align(input, len, seed, XXH_littleEndian, XXH_unaligned);
end;

end.

