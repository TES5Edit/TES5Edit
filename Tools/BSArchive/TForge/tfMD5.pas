{ *********************************************************** }
{ *                     TForge Library                      * }
{ *       Copyright (c) Sergey Kasandrov 1997, 2016         * }
{ *********************************************************** }

unit tfMD5;

{$I TFL.inc}

{$IFDEF TFL_CPUX86_WIN32}
  {$DEFINE CPUX86_WIN32}
{$ENDIF}

{$IFDEF TFL_CPUX64_WIN64}
  {$DEFINE CPUX64_WIN64}
{$ENDIF}

interface

uses tfTypes;

type
  PMD5Alg = ^TMD5Alg;
  TMD5Alg = record
  private type
    TData = record
      Digest: TMD5Digest;
      Block: array[0..63] of Byte;    // 512-bit message block
      Count: UInt64;                  // number of bytes processed
    end;
  private
    FVTable: Pointer;
    FRefCount: Integer;
    FData: TData;

    procedure Compress;
  public
    class procedure Init(Inst: PMD5Alg);
         {$IFDEF TFL_STDCALL}stdcall;{$ENDIF} static;
    class procedure Update(Inst: PMD5Alg; Data: PByte; DataSize: Cardinal);
         {$IFDEF TFL_STDCALL}stdcall;{$ENDIF} static;
    class procedure Done(Inst: PMD5Alg; PDigest: PMD5Digest);
         {$IFDEF TFL_STDCALL}stdcall;{$ENDIF} static;
    class function GetDigestSize(Inst: PMD5Alg): Integer;
         {$IFDEF TFL_STDCALL}stdcall;{$ENDIF} static;
    class function GetBlockSize(Inst: PMD5Alg): Integer;
         {$IFDEF TFL_STDCALL}stdcall;{$ENDIF} static;
    class function Duplicate(Inst: PMD5Alg; var DupInst: PMD5Alg): TF_RESULT;
         {$IFDEF TFL_STDCALL}stdcall;{$ENDIF} static;
  end;

function GetMD5Algorithm(var Inst: PMD5Alg): TF_RESULT;

implementation

uses tfRecords;

const
  MD5VTable: array[0..9] of Pointer = (
    @TForgeInstance.QueryIntf,
    @TForgeInstance.Addref,
    @HashAlgRelease,

    @TMD5Alg.Init,
    @TMD5Alg.Update,
    @TMD5Alg.Done,
    @TMD5Alg.Init,
    @TMD5Alg.GetDigestSize,
    @TMD5Alg.GetBlockSize,
    @TMD5Alg.Duplicate
  );

function GetMD5Algorithm(var Inst: PMD5Alg): TF_RESULT;
var
  P: PMD5Alg;

begin
  try
    New(P);
    P^.FVTable:= @MD5VTable;
    P^.FRefCount:= 1;
    TMD5Alg.Init(P);
    if Inst <> nil then HashAlgRelease(Inst);
    Inst:= P;
    Result:= TF_S_OK;
  except
    Result:= TF_E_OUTOFMEMORY;
  end;
end;

{$IFDEF CPUX86_WIN32}
procedure TMD5Alg.Compress;
asm
        PUSH    ESI
        PUSH    EDI
        PUSH    EBX

        LEA     EDI,[EAX].TMD5Alg.FData.Block

        MOV     EAX,[EDI - 16]      // A:= FData.Digest[0];
        MOV     EBX,[EDI - 12]      // B:= FData.Digest[1];
        MOV     ECX,[EDI - 8]       // C:= FData.Digest[2];
        MOV     EDX,[EDI - 4]       // D:= FData.Digest[3];

// function FF(A, B, C, D, X, S: UInt32): UInt32; inline;
// begin
//  Result:= A + ((B and (C xor D)) xor D) + X;
//  Result:= Rol32(Result, S) + B;
// end;

//  A:= FF(A, B, C, D, Block[ 0] + $D76AA478,  7);  { 1 }

        MOV     ESI,ECX
        ADD     EAX,[EDI]
        XOR     ESI,EDX
        AND     ESI,EBX
        XOR     ESI,EDX
        LEA     EAX,[EAX + ESI + $D76AA478]
        ROL     EAX,7
        ADD     EAX,EBX

//  D:= FF(D, A, B, C, Block[ 1] + $E8C7B756, 12);  { 2 }

        MOV     ESI,EBX
        ADD     EDX,[EDI + 4]
        XOR     ESI,ECX
        AND     ESI,EAX
        XOR     ESI,ECX
        LEA     EDX,[EDX + ESI + $E8C7B756]
        ROL     EDX,12
        ADD     EDX,EAX

//  C:= FF(C, D, A, B, Block[ 2] + $242070DB, 17);  { 3 }

        MOV     ESI,EAX
        ADD     ECX,[EDI + 8]
        XOR     ESI,EBX
        AND     ESI,EDX
        XOR     ESI,EBX
        LEA     ECX,[ECX + ESI + $242070DB]
        ROL     ECX,17
        ADD     ECX,EDX

//  B:= FF(B, C, D, A, Block[ 3] + $C1BDCEEE, 22);  { 4 }

        MOV     ESI,EDX
        ADD     EBX,[EDI + 12]
        XOR     ESI,EAX
        AND     ESI,ECX
        XOR     ESI,EAX
        LEA     EBX,[EBX + ESI + $C1BDCEEE]
        ROL     EBX,22
        ADD     EBX,ECX

//  A:= FF(A, B, C, D, Block[ 4] + $F57C0FAF,  7);  { 5 }

        MOV     ESI,ECX
        ADD     EAX,[EDI + 16]
        XOR     ESI,EDX
        AND     ESI,EBX
        XOR     ESI,EDX
        LEA     EAX,[EAX + ESI + $F57C0FAF]
        ROL     EAX,7
        ADD     EAX,EBX

//  D:= FF(D, A, B, C, Block[ 5] + $4787C62A, 12);  { 6 }

        MOV     ESI,EBX
        ADD     EDX,[EDI + 20]
        XOR     ESI,ECX
        AND     ESI,EAX
        XOR     ESI,ECX
        LEA     EDX,[EDX + ESI + $4787C62A]
        ROL     EDX,12
        ADD     EDX,EAX

//  C:= FF(C, D, A, B, Block[ 6] + $A8304613, 17);  { 7 }

        MOV     ESI,EAX
        ADD     ECX,[EDI + 24]
        XOR     ESI,EBX
        AND     ESI,EDX
        XOR     ESI,EBX
        LEA     ECX,[ECX + ESI + $A8304613]
        ROL     ECX,17
        ADD     ECX,EDX

//  B:= FF(B, C, D, A, Block[ 7] + $FD469501, 22);  { 8 }

        MOV     ESI,EDX
        ADD     EBX,[EDI + 28]
        XOR     ESI,EAX
        AND     ESI,ECX
        XOR     ESI,EAX
        LEA     EBX,[EBX + ESI + $FD469501]
        ROL     EBX,22
        ADD     EBX,ECX

//  A:= FF(A, B, C, D, Block[ 8] + $698098D8,  7);  { 9 }

        MOV     ESI,ECX
        ADD     EAX,[EDI + 32]
        XOR     ESI,EDX
        AND     ESI,EBX
        XOR     ESI,EDX
        LEA     EAX,[EAX + ESI + $698098D8]
        ROL     EAX,7
        ADD     EAX,EBX

//  D:= FF(D, A, B, C, Block[ 9] + $8B44F7AF, 12);  { 10 }

        MOV     ESI,EBX
        ADD     EDX,[EDI + 36]
        XOR     ESI,ECX
        AND     ESI,EAX
        XOR     ESI,ECX
        LEA     EDX,[EDX + ESI + $8B44F7AF]
        ROL     EDX,12
        ADD     EDX,EAX

//  C:= FF(C, D, A, B, Block[10] + $FFFF5BB1, 17);  { 11 }

        MOV     ESI,EAX
        ADD     ECX,[EDI + 40]
        XOR     ESI,EBX
        AND     ESI,EDX
        XOR     ESI,EBX
        LEA     ECX,[ECX + ESI + $FFFF5BB1]
        ROL     ECX,17
        ADD     ECX,EDX

//  B:= FF(B, C, D, A, Block[11] + $895CD7BE, 22);  { 12 }

        MOV     ESI,EDX
        ADD     EBX,[EDI + 44]
        XOR     ESI,EAX
        AND     ESI,ECX
        XOR     ESI,EAX
        LEA     EBX,[EBX + ESI + $895CD7BE]
        ROL     EBX,22
        ADD     EBX,ECX

//  A:= FF(A, B, C, D, Block[12] + $6B901122,  7);  { 13 }

        MOV     ESI,ECX
        ADD     EAX,[EDI + 48]
        XOR     ESI,EDX
        AND     ESI,EBX
        XOR     ESI,EDX
        LEA     EAX,[EAX + ESI + $6B901122]
        ROL     EAX,7
        ADD     EAX,EBX

//  D:= FF(D, A, B, C, Block[13] + $FD987193, 12);  { 14 }

        MOV     ESI,EBX
        ADD     EDX,[EDI + 52]
        XOR     ESI,ECX
        AND     ESI,EAX
        XOR     ESI,ECX
        LEA     EDX,[EDX + ESI + $FD987193]
        ROL     EDX,12
        ADD     EDX,EAX

//  C:= FF(C, D, A, B, Block[14] + $A679438E, 17);  { 15 }

        MOV     ESI,EAX
        ADD     ECX,[EDI + 56]
        XOR     ESI,EBX
        AND     ESI,EDX
        XOR     ESI,EBX
        LEA     ECX,[ECX + ESI + $A679438E]
        ROL     ECX,17
        ADD     ECX,EDX

//  B:= FF(B, C, D, A, Block[15] + $49B40821, 22);  { 16 }

        MOV     ESI,EDX
        ADD     EBX,[EDI + 60]
        XOR     ESI,EAX
        AND     ESI,ECX
        XOR     ESI,EAX
        LEA     EBX,[EBX + ESI + $49B40821]
        ROL     EBX,22
        ADD     EBX,ECX

//function GG(A, B, C, D, X, S: UInt32): UInt32; inline;
//begin
//  Result:= A + ((D and (B xor C)) xor C) + X;
//  Result:= Rol32(Result, S) + B;
//end;

//  A:= GG(A, B, C, D, Block[ 1] + $F61E2562,  5);  { 17 }

        MOV     ESI,EBX
        ADD     EAX,[EDI + 4]
        XOR     ESI,ECX
        AND     ESI,EDX
        XOR     ESI,ECX
        LEA     EAX,[EAX + ESI + $F61E2562]
        ROL     EAX,5
        ADD     EAX,EBX

//  D:= GG(D, A, B, C, Block[ 6] + $C040B340,  9);  { 18 }

        MOV     ESI,EAX
        ADD     EDX,[EDI + 24]
        XOR     ESI,EBX
        AND     ESI,ECX
        XOR     ESI,EBX
        LEA     EDX,[EDX + ESI + $C040B340]
        ROL     EDX,9
        ADD     EDX,EAX

//  C:= GG(C, D, A, B, Block[11] + $265E5A51, 14);  { 19 }

        MOV     ESI,EDX
        ADD     ECX,[EDI + 44]
        XOR     ESI,EAX
        AND     ESI,EBX
        XOR     ESI,EAX
        LEA     ECX,[ECX + ESI + $265E5A51]
        ROL     ECX,14
        ADD     ECX,EDX

//  B:= GG(B, C, D, A, Block[ 0] + $E9B6C7AA, 20);  { 20 }

        MOV     ESI,ECX
        ADD     EBX,[EDI]
        XOR     ESI,EDX
        AND     ESI,EAX
        XOR     ESI,EDX
        LEA     EBX,[EBX + ESI + $E9B6C7AA]
        ROL     EBX,20
        ADD     EBX,ECX

//  A:= GG(A, B, C, D, Block[ 5] + $D62F105D,  5);  { 21 }

        MOV     ESI,EBX
        ADD     EAX,[EDI + 20]
        XOR     ESI,ECX
        AND     ESI,EDX
        XOR     ESI,ECX
        LEA     EAX,[EAX + ESI + $D62F105D]
        ROL     EAX,5
        ADD     EAX,EBX

//  D:= GG(D, A, B, C, Block[10] + $02441453,  9);  { 22 }

        MOV     ESI,EAX
        ADD     EDX,[EDI + 40]
        XOR     ESI,EBX
        AND     ESI,ECX
        XOR     ESI,EBX
        LEA     EDX,[EDX + ESI + $02441453]
        ROL     EDX,9
        ADD     EDX,EAX

//  C:= GG(C, D, A, B, Block[15] + $D8A1E681, 14);  { 23 }

        MOV     ESI,EDX
        ADD     ECX,[EDI + 60]
        XOR     ESI,EAX
        AND     ESI,EBX
        XOR     ESI,EAX
        LEA     ECX,[ECX + ESI + $D8A1E681]
        ROL     ECX,14
        ADD     ECX,EDX

//  B:= GG(B, C, D, A, Block[ 4] + $E7D3FBC8, 20);  { 24 }

        MOV     ESI,ECX
        ADD     EBX,[EDI + 16]
        XOR     ESI,EDX
        AND     ESI,EAX
        XOR     ESI,EDX
        LEA     EBX,[EBX + ESI + $E7D3FBC8]
        ROL     EBX,20
        ADD     EBX,ECX

//  A:= GG(A, B, C, D, Block[ 9] + $21E1CDE6,  5);  { 25 }

        MOV     ESI,EBX
        ADD     EAX,[EDI + 36]
        XOR     ESI,ECX
        AND     ESI,EDX
        XOR     ESI,ECX
        LEA     EAX,[EAX + ESI + $21E1CDE6]
        ROL     EAX,5
        ADD     EAX,EBX

//  D:= GG(D, A, B, C, Block[14] + $C33707D6,  9);  { 26 }

        MOV     ESI,EAX
        ADD     EDX,[EDI + 56]
        XOR     ESI,EBX
        AND     ESI,ECX
        XOR     ESI,EBX
        LEA     EDX,[EDX + ESI + $C33707D6]
        ROL     EDX,9
        ADD     EDX,EAX

//  C:= GG(C, D, A, B, Block[ 3] + $F4D50D87, 14);  { 27 }

        MOV     ESI,EDX
        ADD     ECX,[EDI + 12]
        XOR     ESI,EAX
        AND     ESI,EBX
        XOR     ESI,EAX
        LEA     ECX,[ECX + ESI + $F4D50D87]
        ROL     ECX,14
        ADD     ECX,EDX

//  B:= GG(B, C, D, A, Block[ 8] + $455A14ED, 20);  { 28 }

        MOV     ESI,ECX
        ADD     EBX,[EDI + 32]
        XOR     ESI,EDX
        AND     ESI,EAX
        XOR     ESI,EDX
        LEA     EBX,[EBX + ESI + $455A14ED]
        ROL     EBX,20
        ADD     EBX,ECX

//  A:= GG(A, B, C, D, Block[13] + $A9E3E905,  5);  { 29 }

        MOV     ESI,EBX
        ADD     EAX,[EDI + 52]
        XOR     ESI,ECX
        AND     ESI,EDX
        XOR     ESI,ECX
        LEA     EAX,[EAX + ESI + $A9E3E905]
        ROL     EAX,5
        ADD     EAX,EBX

//  D:= GG(D, A, B, C, Block[ 2] + $FCEFA3F8,  9);  { 30 }

        MOV     ESI,EAX
        ADD     EDX,[EDI + 8]
        XOR     ESI,EBX
        AND     ESI,ECX
        XOR     ESI,EBX
        LEA     EDX,[EDX + ESI + $FCEFA3F8]
        ROL     EDX,9
        ADD     EDX,EAX

//  C:= GG(C, D, A, B, Block[ 7] + $676F02D9, 14);  { 31 }

        MOV     ESI,EDX
        ADD     ECX,[EDI + 28]
        XOR     ESI,EAX
        AND     ESI,EBX
        XOR     ESI,EAX
        LEA     ECX,[ECX + ESI + $676F02D9]
        ROL     ECX,14
        ADD     ECX,EDX

//  B:= GG(B, C, D, A, Block[12] + $8D2A4C8A, 20);  { 32 }

        MOV     ESI,ECX
        ADD     EBX,[EDI + 48]
        XOR     ESI,EDX
        AND     ESI,EAX
        XOR     ESI,EDX
        LEA     EBX,[EBX + ESI + $8D2A4C8A]
        ROL     EBX,20
        ADD     EBX,ECX

//function HH(A, B, C, D, X, S: UInt32): UInt32; inline;
//begin
//  Result:= A + (B xor C xor D) + X;
//  Result:= Rol32(Result, S) + B;
//end;

//  A:= HH(A, B, C, D, Block[ 5] + $FFFA3942,  4);  { 33 }

        MOV     ESI,ECX
        ADD     EAX,[EDI + 20]
        XOR     ESI,EDX
        XOR     ESI,EBX
        LEA     EAX,[EAX + ESI + $FFFA3942]
        ROL     EAX,4
        ADD     EAX,EBX

//  D:= HH(D, A, B, C, Block[ 8] + $8771F681, 11);  { 34 }

        MOV     ESI,EBX
        ADD     EDX,[EDI + 32]
        XOR     ESI,ECX
        XOR     ESI,EAX
        LEA     EDX,[EDX + ESI + $8771F681]
        ROL     EDX,11
        ADD     EDX,EAX

//  C:= HH(C, D, A, B, Block[11] + $6D9D6122, 16);  { 35 }

        MOV     ESI,EAX
        ADD     ECX,[EDI + 44]
        XOR     ESI,EBX
        XOR     ESI,EDX
        LEA     ECX,[ECX + ESI + $6D9D6122]
        ROL     ECX,16
        ADD     ECX,EDX

//  B:= HH(B, C, D, A, Block[14] + $FDE5380C, 23);  { 36 }

        MOV     ESI,EDX
        ADD     EBX,[EDI + 56]
        XOR     ESI,EAX
        XOR     ESI,ECX
        LEA     EBX,[EBX + ESI + $FDE5380C]
        ROL     EBX,23
        ADD     EBX,ECX

//  A:= HH(A, B, C, D, Block[ 1] + $A4BEEA44,  4);  { 37 }

        MOV     ESI,ECX
        ADD     EAX,[EDI + 4]
        XOR     ESI,EDX
        XOR     ESI,EBX
        LEA     EAX,[EAX + ESI + $A4BEEA44]
        ROL     EAX,4
        ADD     EAX,EBX

//  D:= HH(D, A, B, C, Block[ 4] + $4BDECFA9, 11);  { 38 }

        MOV     ESI,EBX
        ADD     EDX,[EDI + 16]
        XOR     ESI,ECX
        XOR     ESI,EAX
        LEA     EDX,[EDX + ESI + $4BDECFA9]
        ROL     EDX,11
        ADD     EDX,EAX

//  C:= HH(C, D, A, B, Block[ 7] + $F6BB4B60, 16);  { 39 }

        MOV     ESI,EAX
        ADD     ECX,[EDI + 28]
        XOR     ESI,EBX
        XOR     ESI,EDX
        LEA     ECX,[ECX + ESI + $F6BB4B60]
        ROL     ECX,16
        ADD     ECX,EDX

//  B:= HH(B, C, D, A, Block[10] + $BEBFBC70, 23);  { 40 }

        MOV     ESI,EDX
        ADD     EBX,[EDI + 40]
        XOR     ESI,EAX
        XOR     ESI,ECX
        LEA     EBX,[EBX + ESI + $BEBFBC70]
        ROL     EBX,23
        ADD     EBX,ECX

//  A:= HH(A, B, C, D, Block[13] + $289B7EC6,  4);  { 41 }

        MOV     ESI,ECX
        ADD     EAX,[EDI + 52]
        XOR     ESI,EDX
        XOR     ESI,EBX
        LEA     EAX,[EAX + ESI + $289B7EC6]
        ROL     EAX,4
        ADD     EAX,EBX

//  D:= HH(D, A, B, C, Block[ 0] + $EAA127FA, 11);  { 42 }

        MOV     ESI,EBX
        ADD     EDX,[EDI]
        XOR     ESI,ECX
        XOR     ESI,EAX
        LEA     EDX,[EDX + ESI + $EAA127FA]
        ROL     EDX,11
        ADD     EDX,EAX

//  C:= HH(C, D, A, B, Block[ 3] + $D4EF3085, 16);  { 43 }

        MOV     ESI,EAX
        ADD     ECX,[EDI + 12]
        XOR     ESI,EBX
        XOR     ESI,EDX
        LEA     ECX,[ECX + ESI + $D4EF3085]
        ROL     ECX,16
        ADD     ECX,EDX

//  B:= HH(B, C, D, A, Block[ 6] + $04881D05, 23);  { 44 }

        MOV     ESI,EDX
        ADD     EBX,[EDI + 24]
        XOR     ESI,EAX
        XOR     ESI,ECX
        LEA     EBX,[EBX + ESI + $04881D05]
        ROL     EBX,23
        ADD     EBX,ECX

//  A:= HH(A, B, C, D, Block[ 9] + $D9D4D039,  4);  { 45 }

        MOV     ESI,ECX
        ADD     EAX,[EDI + 36]
        XOR     ESI,EDX
        XOR     ESI,EBX
        LEA     EAX,[EAX + ESI + $D9D4D039]
        ROL     EAX,4
        ADD     EAX,EBX

//  D:= HH(D, A, B, C, Block[12] + $E6DB99E5, 11);  { 46 }

        MOV     ESI,EBX
        ADD     EDX,[EDI + 48]
        XOR     ESI,ECX
        XOR     ESI,EAX
        LEA     EDX,[EDX + ESI + $E6DB99E5]
        ROL     EDX,11
        ADD     EDX,EAX

//  C:= HH(C, D, A, B, Block[15] + $1FA27CF8, 16);  { 47 }

        MOV     ESI,EAX
        ADD     ECX,[EDI + 60]
        XOR     ESI,EBX
        XOR     ESI,EDX
        LEA     ECX,[ECX + ESI + $1FA27CF8]
        ROL     ECX,16
        ADD     ECX,EDX

//  B:= HH(B, C, D, A, Block[ 2] + $C4AC5665, 23);  { 48 }

        MOV     ESI,EDX
        ADD     EBX,[EDI + 8]
        XOR     ESI,EAX
        XOR     ESI,ECX
        LEA     EBX,[EBX + ESI + $C4AC5665]
        ROL     EBX,23
        ADD     EBX,ECX

//function II(A, B, C, D, X, S: UInt32): UInt32; inline;
//begin
//  Result:= A + (C xor (B or not D)) + X;
//  Result:= Rol32(Result, S) + B;
//end;

//  A:= II(A, B, C, D, Block[ 0] + $F4292244,  6);  { 49 }

        MOV     ESI,EDX
        NOT     ESI
        ADD     EAX,[EDI]
        OR      ESI,EBX
        XOR     ESI,ECX
        LEA     EAX,[EAX + ESI + $F4292244]
        ROL     EAX,6
        ADD     EAX,EBX

//  D:= II(D, A, B, C, Block[ 7] + $432AFF97, 10);  { 50 }

        MOV     ESI,ECX
        NOT     ESI
        ADD     EDX,[EDI + 28]
        OR      ESI,EAX
        XOR     ESI,EBX
        LEA     EDX,[EDX + ESI + $432AFF97]
        ROL     EDX,10
        ADD     EDX,EAX

//  C:= II(C, D, A, B, Block[14] + $AB9423A7, 15);  { 51 }

        MOV     ESI,EBX
        NOT     ESI
        ADD     ECX,[EDI + 56]
        OR      ESI,EDX
        XOR     ESI,EAX
        LEA     ECX,[ECX + ESI + $AB9423A7]
        ROL     ECX,15
        ADD     ECX,EDX

//  B:= II(B, C, D, A, Block[ 5] + $FC93A039, 21);  { 52 }

        MOV     ESI,EAX
        NOT     ESI
        ADD     EBX,[EDI + 20]
        OR      ESI,ECX
        XOR     ESI,EDX
        LEA     EBX,[EBX + ESI + $FC93A039]
        ROL     EBX,21
        ADD     EBX,ECX

//  A:= II(A, B, C, D, Block[12] + $655B59C3,  6);  { 53 }

        MOV     ESI,EDX
        NOT     ESI
        ADD     EAX,[EDI + 48]
        OR      ESI,EBX
        XOR     ESI,ECX
        LEA     EAX,[EAX + ESI + $655B59C3]
        ROL     EAX,6
        ADD     EAX,EBX

//  D:= II(D, A, B, C, Block[ 3] + $8F0CCC92, 10);  { 54 }

        MOV     ESI,ECX
        NOT     ESI
        ADD     EDX,[EDI + 12]
        OR      ESI,EAX
        XOR     ESI,EBX
        LEA     EDX,[EDX + ESI + $8F0CCC92]
        ROL     EDX,10
        ADD     EDX,EAX

//  C:= II(C, D, A, B, Block[10] + $FFEFF47D, 15);  { 55 }

        MOV     ESI,EBX
        NOT     ESI
        ADD     ECX,[EDI + 40]
        OR      ESI,EDX
        XOR     ESI,EAX
        LEA     ECX,[ECX + ESI + $FFEFF47D]
        ROL     ECX,15
        ADD     ECX,EDX

//  B:= II(B, C, D, A, Block[ 1] + $85845DD1, 21);  { 56 }

        MOV     ESI,EAX
        NOT     ESI
        ADD     EBX,[EDI + 4]
        OR      ESI,ECX
        XOR     ESI,EDX
        LEA     EBX,[EBX + ESI + $85845DD1]
        ROL     EBX,21
        ADD     EBX,ECX

//  A:= II(A, B, C, D, Block[ 8] + $6FA87E4F,  6);  { 57 }

        MOV     ESI,EDX
        NOT     ESI
        ADD     EAX,[EDI + 32]
        OR      ESI,EBX
        XOR     ESI,ECX
        LEA     EAX,[EAX + ESI + $6FA87E4F]
        ROL     EAX,6
        ADD     EAX,EBX

//  D:= II(D, A, B, C, Block[15] + $FE2CE6E0, 10);  { 58 }

        MOV     ESI,ECX
        NOT     ESI
        ADD     EDX,[EDI + 60]
        OR      ESI,EAX
        XOR     ESI,EBX
        LEA     EDX,[EDX + ESI + $FE2CE6E0]
        ROL     EDX,10
        ADD     EDX,EAX

//  C:= II(C, D, A, B, Block[ 6] + $A3014314, 15);  { 59 }

        MOV     ESI,EBX
        NOT     ESI
        ADD     ECX,[EDI + 24]
        OR      ESI,EDX
        XOR     ESI,EAX
        LEA     ECX,[ECX + ESI + $A3014314]
        ROL     ECX,15
        ADD     ECX,EDX

//  B:= II(B, C, D, A, Block[13] + $4E0811A1, 21);  { 60 }

        MOV     ESI,EAX
        NOT     ESI
        ADD     EBX,[EDI + 52]
        OR      ESI,ECX
        XOR     ESI,EDX
        LEA     EBX,[EBX + ESI + $4E0811A1]
        ROL     EBX,21
        ADD     EBX,ECX

//  A:= II(A, B, C, D, Block[ 4] + $F7537E82,  6);  { 61 }

        MOV     ESI,EDX
        NOT     ESI
        ADD     EAX,[EDI + 16]
        OR      ESI,EBX
        XOR     ESI,ECX
        LEA     EAX,[EAX + ESI + $F7537E82]
        ROL     EAX,6
        ADD     EAX,EBX

//  D:= II(D, A, B, C, Block[11] + $BD3AF235, 10);  { 62 }

        MOV     ESI,ECX
        NOT     ESI
        ADD     EDX,[EDI + 44]
        OR      ESI,EAX
        XOR     ESI,EBX
        LEA     EDX,[EDX + ESI + $BD3AF235]
        ROL     EDX,10
        ADD     EDX,EAX

//  C:= II(C, D, A, B, Block[ 2] + $2AD7D2BB, 15);  { 63 }

        MOV     ESI,EBX
        NOT     ESI
        ADD     ECX,[EDI + 8]
        OR      ESI,EDX
        XOR     ESI,EAX
        LEA     ECX,[ECX]
        LEA     ECX,[ECX + ESI + $2AD7D2BB]
        ROL     ECX,15
        ADD     ECX,EDX

//  B:= II(B, C, D, A, Block[ 9] + $EB86D391, 21);  { 64 }

        MOV     ESI,EAX
        NOT     ESI
        ADD     EBX,[EDI + 36]
        OR      ESI,ECX
        XOR     ESI,EDX
        LEA     EBX,[EBX + ESI + $EB86D391]
        ROL     EBX,21
        ADD     EBX,ECX


        ADD     [EDI - 16],EAX      // Inc(FData.Digest[0], A);
        ADD     [EDI - 12],EBX      // Inc(FData.Digest[1], B);
        ADD     [EDI - 8],ECX       // Inc(FData.Digest[2], C);
        ADD     [EDI - 4],EDX       // Inc(FData.Digest[3], D);

                                  //  FillChar(Block, SizeOf(Block), 0);
        XOR     EAX,EAX
        MOV     [EDI],EAX
        MOV     [EDI + 4],EAX
        MOV     [EDI + 8],EAX
        MOV     [EDI + 12],EAX
        MOV     [EDI + 16],EAX
        MOV     [EDI + 20],EAX
        MOV     [EDI + 24],EAX
        MOV     [EDI + 28],EAX
        MOV     [EDI + 32],EAX
        MOV     [EDI + 36],EAX
        MOV     [EDI + 40],EAX
        MOV     [EDI + 44],EAX
        MOV     [EDI + 48],EAX
        MOV     [EDI + 52],EAX
        MOV     [EDI + 56],EAX
        MOV     [EDI + 60],EAX

        POP     EBX
        POP     EDI
        POP     ESI
end;
{$ELSE}
{$IFDEF CPUX64_WIN64}
procedure TMD5Alg.Compress;{$IFDEF FPC}assembler; nostackframe;{$ENDIF}
asm
{$IFNDEF FPC}
        .NOFRAME
{$ENDIF}
        PUSH    RSI
        PUSH    RDI
        PUSH    RBX

        LEA     RDI,[RCX].TMD5Alg.FData.Block

        MOV     RAX,[RDI - 16]      // A:= FData.Digest[0];
        MOV     RBX,[RDI - 12]      // B:= FData.Digest[1];
        MOV     RCX,[RDI - 8]       // C:= FData.Digest[2];
        MOV     RDX,[RDI - 4]       // D:= FData.Digest[3];

// function FF(A, B, C, D, X, S: UInt32): UInt32; inline;
// begin
//  Result:= A + ((B and (C xor D)) xor D) + X;
//  Result:= Rol32(Result, S) + B;
// end;

//  A:= FF(A, B, C, D, Block[ 0] + $D76AA478,  7);  { 1 }

        MOV     ESI,ECX
        ADD     EAX,[RDI]
        XOR     ESI,EDX
        AND     ESI,EBX
        XOR     ESI,EDX
        LEA     EAX,[RAX + RSI + $D76AA478]
        ROL     EAX,7
        ADD     EAX,EBX

//  D:= FF(D, A, B, C, Block[ 1] + $E8C7B756, 12);  { 2 }

        MOV     ESI,EBX
        ADD     EDX,[RDI + 4]
        XOR     ESI,ECX
        AND     ESI,EAX
        XOR     ESI,ECX
        LEA     EDX,[RDX + RSI + $E8C7B756]
        ROL     EDX,12
        ADD     EDX,EAX

//  C:= FF(C, D, A, B, Block[ 2] + $242070DB, 17);  { 3 }

        MOV     ESI,EAX
        ADD     ECX,[RDI + 8]
        XOR     ESI,EBX
        AND     ESI,EDX
        XOR     ESI,EBX
        LEA     ECX,[RCX + RSI + $242070DB]
        ROL     ECX,17
        ADD     ECX,EDX

//  B:= FF(B, C, D, A, Block[ 3] + $C1BDCEEE, 22);  { 4 }

        MOV     ESI,EDX
        ADD     EBX,[RDI + 12]
        XOR     ESI,EAX
        AND     ESI,ECX
        XOR     ESI,EAX
        LEA     EBX,[RBX + RSI + $C1BDCEEE]
        ROL     EBX,22
        ADD     EBX,ECX

//  A:= FF(A, B, C, D, Block[ 4] + $F57C0FAF,  7);  { 5 }

        MOV     ESI,ECX
        ADD     EAX,[RDI + 16]
        XOR     ESI,EDX
        AND     ESI,EBX
        XOR     ESI,EDX
        LEA     EAX,[RAX + RSI + $F57C0FAF]
        ROL     EAX,7
        ADD     EAX,EBX

//  D:= FF(D, A, B, C, Block[ 5] + $4787C62A, 12);  { 6 }

        MOV     ESI,EBX
        ADD     EDX,[RDI + 20]
        XOR     ESI,ECX
        AND     ESI,EAX
        XOR     ESI,ECX
        LEA     EDX,[RDX + RSI + $4787C62A]
        ROL     EDX,12
        ADD     EDX,EAX

//  C:= FF(C, D, A, B, Block[ 6] + $A8304613, 17);  { 7 }

        MOV     ESI,EAX
        ADD     ECX,[RDI + 24]
        XOR     ESI,EBX
        AND     ESI,EDX
        XOR     ESI,EBX
        LEA     ECX,[RCX + RSI + $A8304613]
        ROL     ECX,17
        ADD     ECX,EDX

//  B:= FF(B, C, D, A, Block[ 7] + $FD469501, 22);  { 8 }

        MOV     ESI,EDX
        ADD     EBX,[RDI + 28]
        XOR     ESI,EAX
        AND     ESI,ECX
        XOR     ESI,EAX
        LEA     EBX,[RBX + RSI + $FD469501]
        ROL     EBX,22
        ADD     EBX,ECX

//  A:= FF(A, B, C, D, Block[ 8] + $698098D8,  7);  { 9 }

        MOV     ESI,ECX
        ADD     EAX,[RDI + 32]
        XOR     ESI,EDX
        AND     ESI,EBX
        XOR     ESI,EDX
        LEA     EAX,[RAX + RSI + $698098D8]
        ROL     EAX,7
        ADD     EAX,EBX

//  D:= FF(D, A, B, C, Block[ 9] + $8B44F7AF, 12);  { 10 }

        MOV     ESI,EBX
        ADD     EDX,[RDI + 36]
        XOR     ESI,ECX
        AND     ESI,EAX
        XOR     ESI,ECX
        LEA     EDX,[RDX + RSI + $8B44F7AF]
        ROL     EDX,12
        ADD     EDX,EAX

//  C:= FF(C, D, A, B, Block[10] + $FFFF5BB1, 17);  { 11 }

        MOV     ESI,EAX
        ADD     ECX,[RDI + 40]
        XOR     ESI,EBX
        AND     ESI,EDX
        XOR     ESI,EBX
        LEA     ECX,[RCX + RSI + $FFFF5BB1]
        ROL     ECX,17
        ADD     ECX,EDX

//  B:= FF(B, C, D, A, Block[11] + $895CD7BE, 22);  { 12 }

        MOV     ESI,EDX
        ADD     EBX,[RDI + 44]
        XOR     ESI,EAX
        AND     ESI,ECX
        XOR     ESI,EAX
        LEA     EBX,[RBX + RSI + $895CD7BE]
        ROL     EBX,22
        ADD     EBX,ECX

//  A:= FF(A, B, C, D, Block[12] + $6B901122,  7);  { 13 }

        MOV     ESI,ECX
        ADD     EAX,[RDI + 48]
        XOR     ESI,EDX
        AND     ESI,EBX
        XOR     ESI,EDX
        LEA     EAX,[RAX + RSI + $6B901122]
        ROL     EAX,7
        ADD     EAX,EBX

//  D:= FF(D, A, B, C, Block[13] + $FD987193, 12);  { 14 }

        MOV     ESI,EBX
        ADD     EDX,[RDI + 52]
        XOR     ESI,ECX
        AND     ESI,EAX
        XOR     ESI,ECX
        LEA     EDX,[RDX + RSI + $FD987193]
        ROL     EDX,12
        ADD     EDX,EAX

//  C:= FF(C, D, A, B, Block[14] + $A679438E, 17);  { 15 }

        MOV     ESI,EAX
        ADD     ECX,[RDI + 56]
        XOR     ESI,EBX
        AND     ESI,EDX
        XOR     ESI,EBX
        LEA     ECX,[RCX + RSI + $A679438E]
        ROL     ECX,17
        ADD     ECX,EDX

//  B:= FF(B, C, D, A, Block[15] + $49B40821, 22);  { 16 }

        MOV     ESI,EDX
        ADD     EBX,[RDI + 60]
        XOR     ESI,EAX
        AND     ESI,ECX
        XOR     ESI,EAX
        LEA     EBX,[RBX + RSI + $49B40821]
        ROL     EBX,22
        ADD     EBX,ECX

//function GG(A, B, C, D, X, S: UInt32): UInt32; inline;
//begin
//  Result:= A + ((D and (B xor C)) xor C) + X;
//  Result:= Rol32(Result, S) + B;
//end;

//  A:= GG(A, B, C, D, Block[ 1] + $F61E2562,  5);  { 17 }

        MOV     ESI,EBX
        ADD     EAX,[RDI + 4]
        XOR     ESI,ECX
        AND     ESI,EDX
        XOR     ESI,ECX
        LEA     EAX,[RAX + RSI + $F61E2562]
        ROL     EAX,5
        ADD     EAX,EBX

//  D:= GG(D, A, B, C, Block[ 6] + $C040B340,  9);  { 18 }

        MOV     ESI,EAX
        ADD     EDX,[RDI + 24]
        XOR     ESI,EBX
        AND     ESI,ECX
        XOR     ESI,EBX
        LEA     EDX,[RDX + RSI + $C040B340]
        ROL     EDX,9
        ADD     EDX,EAX

//  C:= GG(C, D, A, B, Block[11] + $265E5A51, 14);  { 19 }

        MOV     ESI,EDX
        ADD     ECX,[RDI + 44]
        XOR     ESI,EAX
        AND     ESI,EBX
        XOR     ESI,EAX
        LEA     ECX,[RCX + RSI + $265E5A51]
        ROL     ECX,14
        ADD     ECX,EDX

//  B:= GG(B, C, D, A, Block[ 0] + $E9B6C7AA, 20);  { 20 }

        MOV   ESI,ECX
        ADD   EBX,[RDI]
        XOR   ESI,EDX
        AND   ESI,EAX
        XOR   ESI,EDX
        LEA   EBX,[RBX + RSI + $E9B6C7AA]
        ROL   EBX,20
        ADD   EBX,ECX

//  A:= GG(A, B, C, D, Block[ 5] + $D62F105D,  5);  { 21 }

        MOV   ESI,EBX
        ADD   EAX,[RDI + 20]
        XOR   ESI,ECX
        AND   ESI,EDX
        XOR   ESI,ECX
        LEA   EAX,[RAX + RSI + $D62F105D]
        ROL   EAX,5
        ADD   EAX,EBX

//  D:= GG(D, A, B, C, Block[10] + $02441453,  9);  { 22 }

        MOV   ESI,EAX
        ADD   EDX,[RDI + 40]
        XOR   ESI,EBX
        AND   ESI,ECX
        XOR   ESI,EBX
        LEA   EDX,[RDX + RSI + $02441453]
        ROL   EDX,9
        ADD   EDX,EAX

//  C:= GG(C, D, A, B, Block[15] + $D8A1E681, 14);  { 23 }

        MOV   ESI,EDX
        ADD   ECX,[RDI + 60]
        XOR   ESI,EAX
        AND   ESI,EBX
        XOR   ESI,EAX
        LEA   ECX,[RCX + RSI + $D8A1E681]
        ROL   ECX,14
        ADD   ECX,EDX

//  B:= GG(B, C, D, A, Block[ 4] + $E7D3FBC8, 20);  { 24 }

        MOV   ESI,ECX
        ADD   EBX,[RDI + 16]
        XOR   ESI,EDX
        AND   ESI,EAX
        XOR   ESI,EDX
        LEA   EBX,[RBX + RSI + $E7D3FBC8]
        ROL   EBX,20
        ADD   EBX,ECX

//  A:= GG(A, B, C, D, Block[ 9] + $21E1CDE6,  5);  { 25 }

        MOV   ESI,EBX
        ADD   EAX,[RDI + 36]
        XOR   ESI,ECX
        AND   ESI,EDX
        XOR   ESI,ECX
        LEA   EAX,[RAX + RSI + $21E1CDE6]
        ROL   EAX,5
        ADD   EAX,EBX

//  D:= GG(D, A, B, C, Block[14] + $C33707D6,  9);  { 26 }

        MOV   ESI,EAX
        ADD   EDX,[RDI + 56]
        XOR   ESI,EBX
        AND   ESI,ECX
        XOR   ESI,EBX
        LEA   EDX,[RDX + RSI + $C33707D6]
        ROL   EDX,9
        ADD   EDX,EAX

//  C:= GG(C, D, A, B, Block[ 3] + $F4D50D87, 14);  { 27 }

        MOV   ESI,EDX
        ADD   ECX,[RDI + 12]
        XOR   ESI,EAX
        AND   ESI,EBX
        XOR   ESI,EAX
        LEA   ECX,[RCX + RSI + $F4D50D87]
        ROL   ECX,14
        ADD   ECX,EDX

//  B:= GG(B, C, D, A, Block[ 8] + $455A14ED, 20);  { 28 }

        MOV   ESI,ECX
        ADD   EBX,[RDI + 32]
        XOR   ESI,EDX
        AND   ESI,EAX
        XOR   ESI,EDX
        LEA   EBX,[RBX + RSI + $455A14ED]
        ROL   EBX,20
        ADD   EBX,ECX

//  A:= GG(A, B, C, D, Block[13] + $A9E3E905,  5);  { 29 }

        MOV   ESI,EBX
        ADD   EAX,[RDI + 52]
        XOR   ESI,ECX
        AND   ESI,EDX
        XOR   ESI,ECX
        LEA   EAX,[RAX + RSI + $A9E3E905]
        ROL   EAX,5
        ADD   EAX,EBX

//  D:= GG(D, A, B, C, Block[ 2] + $FCEFA3F8,  9);  { 30 }

        MOV   ESI,EAX
        ADD   EDX,[RDI + 8]
        XOR   ESI,EBX
        AND   ESI,ECX
        XOR   ESI,EBX
        LEA   EDX,[RDX + RSI + $FCEFA3F8]
        ROL   EDX,9
        ADD   EDX,EAX

//  C:= GG(C, D, A, B, Block[ 7] + $676F02D9, 14);  { 31 }

        MOV   ESI,EDX
        ADD   ECX,[RDI + 28]
        XOR   ESI,EAX
        AND   ESI,EBX
        XOR   ESI,EAX
        LEA   ECX,[RCX + RSI + $676F02D9]
        ROL   ECX,14
        ADD   ECX,EDX

//  B:= GG(B, C, D, A, Block[12] + $8D2A4C8A, 20);  { 32 }

        MOV   ESI,ECX
        ADD   EBX,[RDI + 48]
        XOR   ESI,EDX
        AND   ESI,EAX
        XOR   ESI,EDX
        LEA   EBX,[RBX + RSI + $8D2A4C8A]
        ROL   EBX,20
        ADD   EBX,ECX

//function HH(A, B, C, D, X, S: UInt32): UInt32; inline;
//begin
//  Result:= A + (B xor C xor D) + X;
//  Result:= Rol32(Result, S) + B;
//end;

//  A:= HH(A, B, C, D, Block[ 5] + $FFFA3942,  4);  { 33 }

        MOV   ESI,ECX
        ADD   EAX,[RDI + 20]
        XOR   ESI,EDX
        XOR   ESI,EBX
        LEA   EAX,[RAX + RSI + $FFFA3942]
        ROL   EAX,4
        ADD   EAX,EBX

//  D:= HH(D, A, B, C, Block[ 8] + $8771F681, 11);  { 34 }

        MOV   ESI,EBX
        ADD   EDX,[RDI + 32]
        XOR   ESI,ECX
        XOR   ESI,EAX
        LEA   EDX,[RDX + RSI + $8771F681]
        ROL   EDX,11
        ADD   EDX,EAX

//  C:= HH(C, D, A, B, Block[11] + $6D9D6122, 16);  { 35 }

        MOV   ESI,EAX
        ADD   ECX,[RDI + 44]
        XOR   ESI,EBX
        XOR   ESI,EDX
        LEA   ECX,[RCX + RSI + $6D9D6122]
        ROL   ECX,16
        ADD   ECX,EDX

//  B:= HH(B, C, D, A, Block[14] + $FDE5380C, 23);  { 36 }

        MOV   ESI,EDX
        ADD   EBX,[RDI + 56]
        XOR   ESI,EAX
        XOR   ESI,ECX
        LEA   EBX,[RBX + RSI + $FDE5380C]
        ROL   EBX,23
        ADD   EBX,ECX

//  A:= HH(A, B, C, D, Block[ 1] + $A4BEEA44,  4);  { 37 }

        MOV   ESI,ECX
        ADD   EAX,[RDI + 4]
        XOR   ESI,EDX
        XOR   ESI,EBX
        LEA   EAX,[RAX + RSI + $A4BEEA44]
        ROL   EAX,4
        ADD   EAX,EBX

//  D:= HH(D, A, B, C, Block[ 4] + $4BDECFA9, 11);  { 38 }

        MOV   ESI,EBX
        ADD   EDX,[RDI + 16]
        XOR   ESI,ECX
        XOR   ESI,EAX
        LEA   EDX,[RDX + RSI + $4BDECFA9]
        ROL   EDX,11
        ADD   EDX,EAX

//  C:= HH(C, D, A, B, Block[ 7] + $F6BB4B60, 16);  { 39 }

        MOV   ESI,EAX
        ADD   ECX,[RDI + 28]
        XOR   ESI,EBX
        XOR   ESI,EDX
        LEA   ECX,[RCX + RSI + $F6BB4B60]
        ROL   ECX,16
        ADD   ECX,EDX

//  B:= HH(B, C, D, A, Block[10] + $BEBFBC70, 23);  { 40 }

        MOV   ESI,EDX
        ADD   EBX,[RDI + 40]
        XOR   ESI,EAX
        XOR   ESI,ECX
        LEA   EBX,[RBX + RSI + $BEBFBC70]
        ROL   EBX,23
        ADD   EBX,ECX

//  A:= HH(A, B, C, D, Block[13] + $289B7EC6,  4);  { 41 }

        MOV   ESI,ECX
        ADD   EAX,[RDI + 52]
        XOR   ESI,EDX
        XOR   ESI,EBX
        LEA   EAX,[RAX + RSI + $289B7EC6]
        ROL   EAX,4
        ADD   EAX,EBX

//  D:= HH(D, A, B, C, Block[ 0] + $EAA127FA, 11);  { 42 }

        MOV   ESI,EBX
        ADD   EDX,[RDI]
        XOR   ESI,ECX
        XOR   ESI,EAX
        LEA   EDX,[RDX + RSI + $EAA127FA]
        ROL   EDX,11
        ADD   EDX,EAX

//  C:= HH(C, D, A, B, Block[ 3] + $D4EF3085, 16);  { 43 }

        MOV   ESI,EAX
        ADD   ECX,[RDI + 12]
        XOR   ESI,EBX
        XOR   ESI,EDX
        LEA   ECX,[RCX + RSI + $D4EF3085]
        ROL   ECX,16
        ADD   ECX,EDX

//  B:= HH(B, C, D, A, Block[ 6] + $04881D05, 23);  { 44 }

        MOV   ESI,EDX
        ADD   EBX,[RDI + 24]
        XOR   ESI,EAX
        XOR   ESI,ECX
        LEA   EBX,[RBX + RSI + $04881D05]
        ROL   EBX,23
        ADD   EBX,ECX

//  A:= HH(A, B, C, D, Block[ 9] + $D9D4D039,  4);  { 45 }

        MOV   ESI,ECX
        ADD   EAX,[RDI + 36]
        XOR   ESI,EDX
        XOR   ESI,EBX
        LEA   EAX,[RAX + RSI + $D9D4D039]
        ROL   EAX,4
        ADD   EAX,EBX

//  D:= HH(D, A, B, C, Block[12] + $E6DB99E5, 11);  { 46 }

        MOV   ESI,EBX
        ADD   EDX,[RDI + 48]
        XOR   ESI,ECX
        XOR   ESI,EAX
        LEA   EDX,[RDX + RSI + $E6DB99E5]
        ROL   EDX,11
        ADD   EDX,EAX

//  C:= HH(C, D, A, B, Block[15] + $1FA27CF8, 16);  { 47 }

        MOV   ESI,EAX
        ADD   ECX,[RDI + 60]
        XOR   ESI,EBX
        XOR   ESI,EDX
        LEA   ECX,[RCX + RSI + $1FA27CF8]
        ROL   ECX,16
        ADD   ECX,EDX

//  B:= HH(B, C, D, A, Block[ 2] + $C4AC5665, 23);  { 48 }

        MOV   ESI,EDX
        ADD   EBX,[RDI + 8]
        XOR   ESI,EAX
        XOR   ESI,ECX
        LEA   EBX,[RBX + RSI + $C4AC5665]
        ROL   EBX,23
        ADD   EBX,ECX

//function II(A, B, C, D, X, S: UInt32): UInt32; inline;
//begin
//  Result:= A + (C xor (B or not D)) + X;
//  Result:= Rol32(Result, S) + B;
//end;

//  A:= II(A, B, C, D, Block[ 0] + $F4292244,  6);  { 49 }

        MOV   ESI,EDX
        NOT   ESI
        ADD   EAX,[RDI]
        OR    ESI,EBX
        XOR   ESI,ECX
        LEA   EAX,[RAX + RSI + $F4292244]
        ROL   EAX,6
        ADD   EAX,EBX

//  D:= II(D, A, B, C, Block[ 7] + $432AFF97, 10);  { 50 }

        MOV   ESI,ECX
        NOT   ESI
        ADD   EDX,[RDI + 28]
        OR    ESI,EAX
        XOR   ESI,EBX
        LEA   EDX,[RDX + RSI + $432AFF97]
        ROL   EDX,10
        ADD   EDX,EAX

//  C:= II(C, D, A, B, Block[14] + $AB9423A7, 15);  { 51 }

        MOV   ESI,EBX
        NOT   ESI
        ADD   ECX,[RDI + 56]
        OR    ESI,EDX
        XOR   ESI,EAX
        LEA   ECX,[RCX + RSI + $AB9423A7]
        ROL   ECX,15
        ADD   ECX,EDX

//  B:= II(B, C, D, A, Block[ 5] + $FC93A039, 21);  { 52 }

        MOV   ESI,EAX
        NOT   ESI
        ADD   EBX,[RDI + 20]
        OR    ESI,ECX
        XOR   ESI,EDX
        LEA   EBX,[RBX + RSI + $FC93A039]
        ROL   EBX,21
        ADD   EBX,ECX

//  A:= II(A, B, C, D, Block[12] + $655B59C3,  6);  { 53 }

        MOV   ESI,EDX
        NOT   ESI
        ADD   EAX,[RDI + 48]
        OR    ESI,EBX
        XOR   ESI,ECX
        LEA   EAX,[RAX + RSI + $655B59C3]
        ROL   EAX,6
        ADD   EAX,EBX

//  D:= II(D, A, B, C, Block[ 3] + $8F0CCC92, 10);  { 54 }

        MOV   ESI,ECX
        NOT   ESI
        ADD   EDX,[RDI + 12]
        OR    ESI,EAX
        XOR   ESI,EBX
        LEA   EDX,[RDX + RSI + $8F0CCC92]
        ROL   EDX,10
        ADD   EDX,EAX

//  C:= II(C, D, A, B, Block[10] + $FFEFF47D, 15);  { 55 }

        MOV   ESI,EBX
        NOT   ESI
        ADD   ECX,[RDI + 40]
        OR    ESI,EDX
        XOR   ESI,EAX
        LEA   ECX,[RCX + RSI + $FFEFF47D]
        ROL   ECX,15
        ADD   ECX,EDX

//  B:= II(B, C, D, A, Block[ 1] + $85845DD1, 21);  { 56 }

        MOV   ESI,EAX
        NOT   ESI
        ADD   EBX,[RDI + 4]
        OR    ESI,ECX
        XOR   ESI,EDX
        LEA   EBX,[RBX + RSI + $85845DD1]
        ROL   EBX,21
        ADD   EBX,ECX

//  A:= II(A, B, C, D, Block[ 8] + $6FA87E4F,  6);  { 57 }

        MOV   ESI,EDX
        NOT   ESI
        ADD   EAX,[RDI + 32]
        OR    ESI,EBX
        XOR   ESI,ECX
        LEA   EAX,[RAX + RSI + $6FA87E4F]
        ROL   EAX,6
        ADD   EAX,EBX

//  D:= II(D, A, B, C, Block[15] + $FE2CE6E0, 10);  { 58 }

        MOV   ESI,ECX
        NOT   ESI
        ADD   EDX,[RDI + 60]
        OR    ESI,EAX
        XOR   ESI,EBX
        LEA   EDX,[RDX + RSI + $FE2CE6E0]
        ROL   EDX,10
        ADD   EDX,EAX

//  C:= II(C, D, A, B, Block[ 6] + $A3014314, 15);  { 59 }

        MOV     ESI,EBX
        NOT     ESI
        ADD     ECX,[RDI + 24]
        OR      ESI,EDX
        XOR     ESI,EAX
        LEA     ECX,[RCX + RSI + $A3014314]
        ROL     ECX,15
        ADD     ECX,EDX

//  B:= II(B, C, D, A, Block[13] + $4E0811A1, 21);  { 60 }

        MOV     ESI,EAX
        NOT     ESI
        ADD     EBX,[RDI + 52]
        OR      ESI,ECX
        XOR     ESI,EDX
        LEA     EBX,[RBX + RSI + $4E0811A1]
        ROL     EBX,21
        ADD     EBX,ECX

//  A:= II(A, B, C, D, Block[ 4] + $F7537E82,  6);  { 61 }

        MOV     ESI,EDX
        NOT     ESI
        ADD     EAX,[RDI + 16]
        OR      ESI,EBX
        XOR     ESI,ECX
        LEA     EAX,[RAX + RSI + $F7537E82]
        ROL     EAX,6
        ADD     EAX,EBX

//  D:= II(D, A, B, C, Block[11] + $BD3AF235, 10);  { 62 }

        MOV     ESI,ECX
        NOT     ESI
        ADD     EDX,[RDI + 44]
        OR      ESI,EAX
        XOR     ESI,EBX
        LEA     EDX,[RDX + RSI + $BD3AF235]
        ROL     EDX,10
        ADD     EDX,EAX

//  C:= II(C, D, A, B, Block[ 2] + $2AD7D2BB, 15);  { 63 }

        MOV     ESI,EBX
        NOT     ESI
        ADD     ECX,[RDI + 8]
        OR      ESI,EDX
        XOR     ESI,EAX
        LEA     ECX,[RCX + RSI + $2AD7D2BB]
        ROL     ECX,15
        ADD     ECX,EDX

//  B:= II(B, C, D, A, Block[ 9] + $EB86D391, 21);  { 64 }

        MOV     ESI,EAX
        NOT     ESI
        ADD     EBX,[RDI + 36]
        OR      ESI,ECX
        XOR     ESI,EDX
        LEA     EBX,[RBX + RSI + $EB86D391]
        ROL     EBX,21
        ADD     EBX,ECX


        ADD     [RDI - 16],EAX      // Inc(FData.Digest[0], A);
        ADD     [RDI - 12],EBX      // Inc(FData.Digest[1], B);
        ADD     [RDI - 8],ECX       // Inc(FData.Digest[2], C);
        ADD     [RDI - 4],EDX       // Inc(FData.Digest[3], D);

                                  //  FillChar(Block, SizeOf(Block), 0);
        XOR     RAX,RAX
        MOV     [RDI],RAX
        MOV     [RDI + 8],RAX
        MOV     [RDI + 16],RAX
        MOV     [RDI + 24],RAX
        MOV     [RDI + 32],RAX
        MOV     [RDI + 40],RAX
        MOV     [RDI + 48],RAX
        MOV     [RDI + 56],RAX

        POP     RBX
        POP     RDI
        POP     RSI
end;
{$ELSE}
function Rol32(Value, Shift: UInt32): UInt32; inline;
begin
  Result:= (Value shr (32 - Shift)) or (Value shl Shift);
end;

function FF(A, B, C, D, X, S: UInt32): UInt32; inline;
begin
//  Result:= Rol32(A + ((B and C) or (not B and D)) + X, S) + B;
//  Result:= Rol32(A + ((B and (C xor D)) xor D) + X, S) + B;
  Result:= A + ((B and (C xor D)) xor D) + X;
  Result:= Rol32(Result, S) + B;
end;

function GG(A, B, C, D, X, S: UInt32): UInt32; inline;
begin
//  Result:= Rol32(A + ((B and D) or (C and not D)) + X, S) + B;
//  Result:= Rol32(A + ((D and (B xor C)) xor C) + X, S) + B;
  Result:= A + ((D and (B xor C)) xor C) + X;
  Result:= Rol32(Result, S) + B;
end;

function HH(A, B, C, D, X, S: UInt32): UInt32; inline;
begin
//  Result:= Rol32(A + (B xor C xor D) + X, S) + B;
  Result:= A + (B xor C xor D) + X;
  Result:= Rol32(Result, S) + B;
end;

function II(A, B, C, D, X, S: UInt32): UInt32; inline;
begin
//  Result:= Rol32(A + (C xor (B or not D)) + X, S) + B;
  Result:= A + (C xor (B or not D)) + X;
  Result:= Rol32(Result, S) + B;
end;

procedure TMD5Alg.Compress;
var
  A, B, C, D: UInt32;
  Block: array[0..15] of UInt32;

begin
  Move(FData.Block, Block, SizeOf(Block));

  A:= FData.Digest[0];
  B:= FData.Digest[1];
  C:= FData.Digest[2];
  D:= FData.Digest[3];
                                                     {round 1}
  A:= FF(A, B, C, D, Block[ 0] + $D76AA478,  7);  { 1 }
  D:= FF(D, A, B, C, Block[ 1] + $E8C7B756, 12);  { 2 }
  C:= FF(C, D, A, B, Block[ 2] + $242070DB, 17);  { 3 }
  B:= FF(B, C, D, A, Block[ 3] + $C1BDCEEE, 22);  { 4 }
  A:= FF(A, B, C, D, Block[ 4] + $F57C0FAF,  7);  { 5 }
  D:= FF(D, A, B, C, Block[ 5] + $4787C62A, 12);  { 6 }
  C:= FF(C, D, A, B, Block[ 6] + $A8304613, 17);  { 7 }
  B:= FF(B, C, D, A, Block[ 7] + $FD469501, 22);  { 8 }
  A:= FF(A, B, C, D, Block[ 8] + $698098D8,  7);  { 9 }
  D:= FF(D, A, B, C, Block[ 9] + $8B44F7AF, 12);  { 10 }
  C:= FF(C, D, A, B, Block[10] + $FFFF5BB1, 17);  { 11 }
  B:= FF(B, C, D, A, Block[11] + $895CD7BE, 22);  { 12 }
  A:= FF(A, B, C, D, Block[12] + $6B901122,  7);  { 13 }
  D:= FF(D, A, B, C, Block[13] + $FD987193, 12);  { 14 }
  C:= FF(C, D, A, B, Block[14] + $A679438E, 17);  { 15 }
  B:= FF(B, C, D, A, Block[15] + $49B40821, 22);  { 16 }
                                                     {round 2}
  A:= GG(A, B, C, D, Block[ 1] + $F61E2562,  5);  { 17 }
  D:= GG(D, A, B, C, Block[ 6] + $C040B340,  9);  { 18 }
  C:= GG(C, D, A, B, Block[11] + $265E5A51, 14);  { 19 }
  B:= GG(B, C, D, A, Block[ 0] + $E9B6C7AA, 20);  { 20 }
  A:= GG(A, B, C, D, Block[ 5] + $D62F105D,  5);  { 21 }
  D:= GG(D, A, B, C, Block[10] + $02441453,  9);  { 22 }
  C:= GG(C, D, A, B, Block[15] + $D8A1E681, 14);  { 23 }
  B:= GG(B, C, D, A, Block[ 4] + $E7D3FBC8, 20);  { 24 }
  A:= GG(A, B, C, D, Block[ 9] + $21E1CDE6,  5);  { 25 }
  D:= GG(D, A, B, C, Block[14] + $C33707D6,  9);  { 26 }
  C:= GG(C, D, A, B, Block[ 3] + $F4D50D87, 14);  { 27 }
  B:= GG(B, C, D, A, Block[ 8] + $455A14ED, 20);  { 28 }
  A:= GG(A, B, C, D, Block[13] + $A9E3E905,  5);  { 29 }
  D:= GG(D, A, B, C, Block[ 2] + $FCEFA3F8,  9);  { 30 }
  C:= GG(C, D, A, B, Block[ 7] + $676F02D9, 14);  { 31 }
  B:= GG(B, C, D, A, Block[12] + $8D2A4C8A, 20);  { 32 }
                                                     {round 3}
  A:= HH(A, B, C, D, Block[ 5] + $FFFA3942,  4);  { 33 }
  D:= HH(D, A, B, C, Block[ 8] + $8771F681, 11);  { 34 }
  C:= HH(C, D, A, B, Block[11] + $6D9D6122, 16);  { 35 }
  B:= HH(B, C, D, A, Block[14] + $FDE5380C, 23);  { 36 }
  A:= HH(A, B, C, D, Block[ 1] + $A4BEEA44,  4);  { 37 }
  D:= HH(D, A, B, C, Block[ 4] + $4BDECFA9, 11);  { 38 }
  C:= HH(C, D, A, B, Block[ 7] + $F6BB4B60, 16);  { 39 }
  B:= HH(B, C, D, A, Block[10] + $BEBFBC70, 23);  { 40 }
  A:= HH(A, B, C, D, Block[13] + $289B7EC6,  4);  { 41 }
  D:= HH(D, A, B, C, Block[ 0] + $EAA127FA, 11);  { 42 }
  C:= HH(C, D, A, B, Block[ 3] + $D4EF3085, 16);  { 43 }
  B:= HH(B, C, D, A, Block[ 6] + $04881D05, 23);  { 44 }
  A:= HH(A, B, C, D, Block[ 9] + $D9D4D039,  4);  { 45 }
  D:= HH(D, A, B, C, Block[12] + $E6DB99E5, 11);  { 46 }
  C:= HH(C, D, A, B, Block[15] + $1FA27CF8, 16);  { 47 }
  B:= HH(B, C, D, A, Block[ 2] + $C4AC5665, 23);  { 48 }
                                                     {round 4}
  A:= II(A, B, C, D, Block[ 0] + $F4292244,  6);  { 49 }
  D:= II(D, A, B, C, Block[ 7] + $432AFF97, 10);  { 50 }
  C:= II(C, D, A, B, Block[14] + $AB9423A7, 15);  { 51 }
  B:= II(B, C, D, A, Block[ 5] + $FC93A039, 21);  { 52 }
  A:= II(A, B, C, D, Block[12] + $655B59C3,  6);  { 53 }
  D:= II(D, A, B, C, Block[ 3] + $8F0CCC92, 10);  { 54 }
  C:= II(C, D, A, B, Block[10] + $FFEFF47D, 15);  { 55 }
  B:= II(B, C, D, A, Block[ 1] + $85845DD1, 21);  { 56 }
  A:= II(A, B, C, D, Block[ 8] + $6FA87E4F,  6);  { 57 }
  D:= II(D, A, B, C, Block[15] + $FE2CE6E0, 10);  { 58 }
  C:= II(C, D, A, B, Block[ 6] + $A3014314, 15);  { 59 }
  B:= II(B, C, D, A, Block[13] + $4E0811A1, 21);  { 60 }
  A:= II(A, B, C, D, Block[ 4] + $F7537E82,  6);  { 61 }
  D:= II(D, A, B, C, Block[11] + $BD3AF235, 10);  { 62 }
  C:= II(C, D, A, B, Block[ 2] + $2AD7D2BB, 15);  { 63 }
  B:= II(B, C, D, A, Block[ 9] + $EB86D391, 21);  { 64 }

  Inc(FData.Digest[0], A);
  Inc(FData.Digest[1], B);
  Inc(FData.Digest[2], C);
  Inc(FData.Digest[3], D);

  FillChar(FData.Block, SizeOf(FData.Block), 0);
  FillChar(Block, SizeOf(Block), 0);
end;

{$ENDIF}
{$ENDIF}

class procedure TMD5Alg.Init(Inst: PMD5Alg);
begin
  Inst.FData.Digest[0]:= $67452301;   // load magic initialization constants
  Inst.FData.Digest[1]:= $EFCDAB89;
  Inst.FData.Digest[2]:= $98BADCFE;
  Inst.FData.Digest[3]:= $10325476;

  FillChar(Inst.FData.Block, SizeOf(Inst.FData.Block), 0);
  Inst.FData.Count:= 0;
end;

class procedure TMD5Alg.Update(Inst: PMD5Alg; Data: PByte; DataSize: Cardinal);
var
  Cnt, Ofs: Cardinal;

begin
  while DataSize > 0 do begin
    Ofs:= Cardinal(Inst.FData.Count) and $3F;
    Cnt:= $40 - Ofs;
    if Cnt > DataSize then Cnt:= DataSize;
    Move(Data^, PByte(@Inst.FData.Block)[Ofs], Cnt);
    if (Cnt + Ofs = $40) then Inst.Compress;
    Inc(Inst.FData.Count, Cnt);
    Dec(DataSize, Cnt);
    Inc(Data, Cnt);
  end;
end;

class procedure TMD5Alg.Done(Inst: PMD5Alg; PDigest: PMD5Digest);
var
  Ofs: Cardinal;

begin
  Ofs:= Cardinal(Inst.FData.Count) and $3F;
  Inst.FData.Block[Ofs]:= $80;
  if Ofs >= 56 then
    Inst.Compress;

  Inst.FData.Count:= Inst.FData.Count shl 3;
  PUInt32(@Inst.FData.Block[56])^:= UInt32(Inst.FData.Count);
  PUInt32(@Inst.FData.Block[60])^:= UInt32(Inst.FData.Count shr 32);
  Inst.Compress;

  Move(Inst.FData.Digest, PDigest^, SizeOf(TMD5Digest));

  Init(Inst);
end;

class function TMD5Alg.GetDigestSize(Inst: PMD5Alg): Integer;
begin
  Result:= SizeOf(TMD5Digest);
end;

class function TMD5Alg.GetBlockSize(Inst: PMD5Alg): Integer;
begin
  Result:= 64;
end;

class function TMD5Alg.Duplicate(Inst: PMD5Alg; var DupInst: PMD5Alg): TF_RESULT;
begin
  Result:= GetMD5Algorithm(DupInst);
  if Result = TF_S_OK then
    DupInst.FData:= Inst.FData;
end;

end.
