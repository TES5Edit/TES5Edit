{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbHash;

// {$DEFINE CRYPTOAPI}

interface

uses
  System.SysUtils;

type
  TwbXXH32 = type Cardinal;
  PwbXXH32 = ^TwbXXH32;
  TwbXXH32s = array of TwbXXH32;

  TwbXXH64 = type UInt64;
  PwbXXH64 = ^TwbXXH64;
  TwbXXH64s = array of TwbXXH64;

  //TwbXXH3 = type TGUID;
  //PwbXXH3 = ^TwbXXH3;
  //TwbXXH3s = array of TwbXXH3;

  TwbCRC32 = type Cardinal;
  PwbCRC32 = ^TwbCRC32;
  TwbCRC32s = array of TwbCRC32;

  TwbLookupHash = type TwbXXH64;

  TwbHash = class abstract
  public
    class function LookupHash(aData: Pointer; aLen: NativeInt): TwbLookupHash; overload; inline;
    class function LookupHash(const aText: string; aIgnoreCase: Boolean = False): TwbLookupHash; overload;
    class function SameLookupHash(aHash1, aHash2: TwbLookupHash): Boolean; inline;
    class function TES3(const aText: string): UInt64;
    class function _TES4(const aText: string; aHasExtension: Boolean = False; aSigned: Boolean = False): UInt64;
    class function TES4(const aText: string; aHasExtension: Boolean = False): UInt64;
    class function TES5(const aText: string; aHasExtension: Boolean = False): UInt64;
    class function FNV132(const aText: string; aIgnoreCase: Boolean = False): UInt32; overload;
    class function FNV132(const aText: AnsiString; aIgnoreCase: Boolean = False): UInt32; overload;
    class function FNV132(aData: PByte; aSize: UInt64): UInt32; overload;
    class function FNV132(const aBytes: TBytes): UInt32; overload;
    class function FO4(const aText: string): Cardinal;
    class function BSCRC32(const aText: string): Cardinal;
    class function XXH32(aData: Pointer; aLen: NativeInt; aSeed: TwbXXH32 = 0): TwbXXH32;
    class function XXH64(aData: Pointer; aLen: NativeInt; aSeed: TwbXXH64 = 0): TwbXXH64;
    //class function XXH3(aData: Pointer; aLen: NativeInt): TwbXXH3;
    class function CRC32(aData: Pointer; aSize: Integer): TwbCRC32; overload;
    class function CRC32(const aData: TBytes): TwbCRC32; overload;
    class function CRC32(const aFileName: string): TwbCRC32; overload;
    class function CRC32Chunked(const aFileName: string): TwbCRC32;
    {$IFDEF CRYPTOAPI}
    class function SHA1(const aData: TBytes): TBytes; overload;
    class function SHA1(const aFileName: string): TBytes; overload;
    class function MD5(const aData: TBytes): TBytes; overload;
    class function MD5(const aFileName: string): TBytes; overload;
    {$ENDIF}

    const
      cCRC32Table : array [0..255] of Cardinal = (
        $00000000, $77073096, $EE0E612C, $990951BA, $076DC419, $706AF48F, $E963A535, $9E6495A3,
        $0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988, $09B64C2B, $7EB17CBD, $E7B82D07, $90BF1D91,
        $1DB71064, $6AB020F2, $F3B97148, $84BE41DE, $1ADAD47D, $6DDDE4EB, $F4D4B551, $83D385C7,
        $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC, $14015C4F, $63066CD9, $FA0F3D63, $8D080DF5,
        $3B6E20C8, $4C69105E, $D56041E4, $A2677172, $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B,
        $35B5A8FA, $42B2986C, $DBBBC9D6, $ACBCF940, $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59,
        $26D930AC, $51DE003A, $C8D75180, $BFD06116, $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F,
        $2802B89E, $5F058808, $C60CD9B2, $B10BE924, $2F6F7C87, $58684C11, $C1611DAB, $B6662D3D,
        $76DC4190, $01DB7106, $98D220BC, $EFD5102A, $71B18589, $06B6B51F, $9FBFE4A5, $E8B8D433,
        $7807C9A2, $0F00F934, $9609A88E, $E10E9818, $7F6A0DBB, $086D3D2D, $91646C97, $E6635C01,
        $6B6B51F4, $1C6C6162, $856530D8, $F262004E, $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457,
        $65B0D9C6, $12B7E950, $8BBEB8EA, $FCB9887C, $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65,
        $4DB26158, $3AB551CE, $A3BC0074, $D4BB30E2, $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB,
        $4369E96A, $346ED9FC, $AD678846, $DA60B8D0, $44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9,
        $5005713C, $270241AA, $BE0B1010, $C90C2086, $5768B525, $206F85B3, $B966D409, $CE61E49F,
        $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4, $59B33D17, $2EB40D81, $B7BD5C3B, $C0BA6CAD,
        $EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A, $EAD54739, $9DD277AF, $04DB2615, $73DC1683,
        $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8, $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1,
        $F00F9344, $8708A3D2, $1E01F268, $6906C2FE, $F762575D, $806567CB, $196C3671, $6E6B06E7,
        $FED41B76, $89D32BE0, $10DA7A5A, $67DD4ACC, $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5,
        $D6D6A3E8, $A1D1937E, $38D8C2C4, $4FDFF252, $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B,
        $D80D2BDA, $AF0A1B4C, $36034AF6, $41047A60, $DF60EFC3, $A867DF55, $316E8EEF, $4669BE79,
        $CB61B38C, $BC66831A, $256FD2A0, $5268E236, $CC0C7795, $BB0B4703, $220216B9, $5505262F,
        $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04, $C2D7FFA7, $B5D0CF31, $2CD99E8B, $5BDEAE1D,
        $9B64C2B0, $EC63F226, $756AA39C, $026D930A, $9C0906A9, $EB0E363F, $72076785, $05005713,
        $95BF4A82, $E2B87A14, $7BB12BAE, $0CB61B38, $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21,
        $86D3D2D4, $F1D4E242, $68DDB3F8, $1FDA836E, $81BE16CD, $F6B9265B, $6FB077E1, $18B74777,
        $88085AE6, $FF0F6A70, $66063BCA, $11010B5C, $8F659EFF, $F862AE69, $616BFFD3, $166CCF45,
        $A00AE278, $D70DD2EE, $4E048354, $3903B3C2, $A7672661, $D06016F7, $4969474D, $3E6E77DB,
        $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0, $A9BCAE53, $DEBB9EC5, $47B2CF7F, $30B5FFE9,
        $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6, $BAD03605, $CDD70693, $54DE5729, $23D967BF,
        $B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94, $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D
     );
  end;


implementation

uses
  System.Classes,
  System.AnsiStrings,

  WinApi.Windows,

  xxHash;

function LastCharPos(const s: string; const Chr: char): Integer;
begin
  for Result := Length(s) downto 1 do
    if s[Result] = Chr then
      Exit;
  Result := 0;
end;

function SplitDirName(const aFileName: string; var Dir, Name: string): Integer;
begin
  Result := LastCharPos(aFileName, '\');
  if Result = 0 then
    Result := LastCharPos(aFileName, '/');
  if Result <> 0 then begin
    Dir := Copy(aFileName, 1, Pred(Result));
    Name := Copy(aFileName, Succ(Result), Length(aFileName) - Result);
  end
  else begin
    Dir := '';
    Name := aFileName;
  end;
end;

function SplitNameExt(const aFileName: string; var Name, Ext: string; aNoExtDot: Boolean = False): Integer;
begin
  Result := LastCharPos(aFileName, '.');
  if Result <> 0 then begin
    Name := Copy(aFileName, 1, Pred(Result));
    if aNoExtDot then
      Inc(Result);
    Ext := Copy(aFileName, Result, Length(aFileName) - Result + 1);
  end
  else begin
    Name := aFileName;
    Ext := '';
  end;
end;

class function TwbHash.LookupHash(aData: Pointer; aLen: NativeInt): TwbLookupHash;
begin
  Result := XXH64(aData, aLen);
end;

class function TwbHash.LookupHash(const aText: string; aIgnoreCase: Boolean = False): TwbLookupHash;
begin
  if aText = '' then
    Result := 0
  else
    if aIgnoreCase then begin
      var s := LowerCase(aText);
      Result := LookupHash(@s[1], ByteLength(s));
    end else
      Result := LookupHash(@aText[1], ByteLength(aText));
end;

class function TwbHash.SameLookupHash(aHash1, aHash2: TwbLookupHash): Boolean;
begin
  Result :=
    {$if SizeOf(TwbLookupHash) <= SizeOf(Int64)}(aHash1 = aHash2){$else}CompareMem(@aHash1, aHash2, SizeOf(aHash)){$endif};
end;

class function TwbHash.TES3(const aText: string): UInt64;
var
  s: AnsiString;
  i, l: integer;
  sum, off, temp, n: Cardinal;
begin
  s := AnsiString((StringReplace(LowerCase(aText), '/', '\', [rfReplaceAll])));
  l := Length(s) shr 1;

  sum := 0; off := 0;
  for i := 1 to l do begin
    temp := Cardinal(Byte(s[i])) shl (off and $1F);
    sum := sum xor temp;
    off := off + 8;
  end;
  Result := sum;

  sum := 0; off := 0;
  for i := l + 1 to Length(s) do begin
    temp := Cardinal(Byte(s[i])) shl (off and $1F);
    sum := sum xor temp;
    n := temp and $1F;
    sum := (sum shr n) or (sum shl (32 - n));
    off := off + 8;
  end;
  Result := Result or UInt64(sum) shl 32;
end;

{$IFOPT Q+}
  {$DEFINE HasOverflowChecks}
{$ENDIF}
{$OVERFLOWCHECKS OFF}
class function TwbHash._TES4(const aText: string; aHasExtension: Boolean = False; aSigned: Boolean = False): UInt64;
var
  hash1: array [0..3] of AnsiChar absolute Result;
  s, e: AnsiString;
begin
  Result := 0;
  var i := LastCharPos(aText, '.');
  if aHasExtension and (i <> 0) then begin
    s := AnsiString(LowerCase(Copy(aText, 1, Pred(i))));
    e := AnsiString(LowerCase(Copy(aText, i, Length(aText))));
  end
  else begin
    s := AnsiString(LowerCase(aText));
    e := '';
  end;

  var l := Length(s);
  if l > 0 then hash1[0] := s[l];
  if l > 2 then hash1[1] := s[l-1];
                hash1[2] := AnsiChar(l);
  if l > 0 then hash1[3] := s[1];

  if e = '.kf'  then Result := Result or $80 else
  if e = '.nif' then Result := Result or $8000 else
  if e = '.dds' then Result := Result or $8080 else
  if e = '.wav' then Result := Result or $80000000;

  var hash : Cardinal := 0;
  for i := 2 to l-2 do begin
    hash := Byte(s[i]) + (hash shl 6) + (hash shl 16) - hash;
    if aSigned and (Byte(s[i]) > 127) then hash := hash - 256;
  end;
  Result := Result + UInt64(hash) shl 32;

  hash := 0;
  for i := 1 to Length(e) do begin
    hash := Byte(e[i]) + (hash shl 6) + (hash shl 16) - hash;
    if aSigned and (Byte(e[i]) > 127) then hash := hash - 256;
  end;
  Result := Result + UInt64(hash) shl 32;
end;
{$IFDEF HasOverflowChecks}
  {$OVERFLOWCHECKS ON}
{$ENDIF}

class function TwbHash.TES4(const aText: string; aHasExtension: Boolean = False): UInt64;
begin
  Result := _TES4(aText, aHasExtension, True);
end;

class function TwbHash.TES5(const aText: string; aHasExtension: Boolean = False): UInt64;
begin
  Result := _TES4(aText, aHasExtension);
end;

class function TwbHash.FO4(const aText: string): Cardinal;
begin
  Result := BSCRC32(StringReplace(LowerCase(aText), '/', '\', [rfReplaceAll]));
end;

class function TwbHash.BSCRC32(const aText: string): Cardinal;
begin
  Result := 0;
  var s := AnsiString(aText);
  for var i := Low(s) to High(s) do
    Result := (Result shr 8) xor cCRC32Table[(Result xor Byte(s[i])) and $FF];
end;

class function TwbHash.XXH32(aData: Pointer; aLen: NativeInt; aSeed: TwbXXH32 = 0): TwbXXH32;
begin
  Result := xxHash.{$IFDEF WIN64}XXH32{$ELSE}_XXH32{$ENDIF}(aData, aLen, aSeed);
end;

class function TwbHash.XXH64(aData: Pointer; aLen: NativeInt; aSeed: TwbXXH64 = 0): TwbXXH64;
begin
  Result := xxHash.{$IFDEF WIN64}XXH64{$ELSE}_XXH64{$ENDIF}(aData, aLen, aSeed);
end;

{class function TwbHash.XXH3(aData: Pointer; aLen: NativeInt): TwbXXH3;
begin
  XXH128_hash_t(Result) := XXHashLib.XXH3_128bits(aData, aLen);
end;}

{$IFDEF WIN64}
function crc32_update(inbuffer: pointer; buffersize, crc: DWord): DWord;
// crc-32.  Processes 4 bytes at a time.
type
  PDWord = ^DWord;
  PByte = ^Byte;
var
  currptr: Pointer;
  i: Byte;
begin
  currptr := inbuffer;
  Result := crc;
  while buffersize > 4 do
    begin
      Result := Result xor PDWord(currptr)^;
      Inc(PByte(currptr), 4);
      Result := (Result shr 8) xor TwbHash.cCRC32Table[Byte(Result)];
      Result := (Result shr 8) xor TwbHash.cCRC32Table[Byte(Result)];
      Result := (Result shr 8) xor TwbHash.cCRC32Table[Byte(Result)];
      Result := (Result shr 8) xor TwbHash.cCRC32Table[Byte(Result)];
      Dec(buffersize, 4);
    end;
  for i := 1 to buffersize do
    begin
      Result := TwbHash.cCRC32Table[Byte(Result xor DWord(PByte(currptr)^))] xor (Result shr 8);
      inc(PByte(currptr), 1);
    end;
end;
{$ENDIF}

var
  crctbl: array[0..7] of array[0..255] of cardinal;

function ShaCrcRefresh(OldCRC: cardinal; BufPtr: Pointer; BufLen: Integer): Cardinal;
// Fast CRC32 calculator
// (c) Aleksandr Sharahov 2009
// Free for any use
{$IFDEF WIN64}
begin
  Result := crc32_update(BufPtr, BufLen, OldCRC);
{$ENDIF WIN64}
{$IFDEF WIN32}
asm
  test edx, edx
  jz   @ret
  neg  ecx
  jz   @ret
  push ebx
@head:
  test dl, 3
  jz   @bodyinit
  movzx ebx, byte [edx]
  inc  edx
  xor  bl, al
  shr  eax, 8
  xor  eax, [ebx*4 + crctbl]
  inc  ecx
  jnz  @head
  pop  ebx
@ret:
  ret
@bodyinit:
  sub  edx, ecx
  add  ecx, 8
  jg   @bodydone
  push esi
  push edi
  mov  edi, edx
  mov  edx, eax
@bodyloop:
  mov ebx, [edi + ecx - 4]
  xor edx, [edi + ecx - 8]
  movzx esi, bl
  mov eax, [esi*4 + crctbl + 1024*3]
  movzx esi, bh
  xor eax, [esi*4 + crctbl + 1024*2]
  shr ebx, 16
  movzx esi, bl
  xor eax, [esi*4 + crctbl + 1024*1]
  movzx esi, bh
  xor eax, [esi*4 + crctbl + 1024*0]

  movzx esi, dl
  xor eax, [esi*4 + crctbl + 1024*7]
  movzx esi, dh
  xor eax, [esi*4 + crctbl + 1024*6]
  shr edx, 16
  movzx esi, dl
  xor eax, [esi*4 + crctbl + 1024*5]
  movzx esi, dh
  xor eax, [esi*4 + crctbl + 1024*4]

  add ecx, 8
  jg  @done

  mov ebx, [edi + ecx - 4]
  xor eax, [edi + ecx - 8]
  movzx esi, bl
  mov edx, [esi*4 + crctbl + 1024*3]
  movzx esi, bh
  xor edx, [esi*4 + crctbl + 1024*2]
  shr ebx, 16
  movzx esi, bl
  xor edx, [esi*4 + crctbl + 1024*1]
  movzx esi, bh
  xor edx, [esi*4 + crctbl + 1024*0]

  movzx esi, al
  xor edx, [esi*4 + crctbl + 1024*7]
  movzx esi, ah
  xor edx, [esi*4 + crctbl + 1024*6]
  shr eax, 16
  movzx esi, al
  xor edx, [esi*4 + crctbl + 1024*5]
  movzx esi, ah
  xor edx, [esi*4 + crctbl + 1024*4]

  add ecx, 8
  jle @bodyloop
  mov eax, edx
@done:
  mov edx, edi
  pop edi
  pop esi
@bodydone:
  sub ecx, 8
  jl @tail
  pop ebx
  ret
@tail:
  movzx ebx, byte [edx + ecx];
  xor bl,al;
  shr eax,8;
  xor eax, [ebx*4 + crctbl];
  inc ecx;
  jnz @tail;
  pop ebx
  ret
{$ENDIF WIN32}
end;

class function TwbHash.CRC32(aData: Pointer; aSize: Integer): TwbCRC32;
begin
  // our crc32 is ~10% faster in x86 and ~2% faster in x64
  //Result := libdeflate_crc32(0, aData, aSize);
  Result := not ShaCrcRefresh($FFFFFFFF, aData, aSize);
end;

class function TwbHash.CRC32(const aData: TBytes): TwbCRC32;
begin
  Result := CRC32(aData, Length(aData));
end;

class function TwbHash.CRC32(const aFileName: string): TwbCRC32;
var
  Data: TBytes;
begin
  Result := 0;
  if FileExists(aFileName) then
    with TFileStream.Create(aFileName, fmOpenRead + fmShareDenyNone) do try
      SetLength(Data, Size);
      ReadBuffer(Data[0], Length(Data));
      Result := TwbHash.CRC32(Data);
    finally
      Free;
    end;
end;

class function TwbHash.CRC32Chunked(const aFileName: string): TwbCRC32;
const
  cChunkSize = 1 shl 20;
var
  lBuffer : TBytes;
  lCRC    : Cardinal;
begin
  SetLength(lBuffer, cChunkSize);
  lCRC := $FFFFFFFF;
  var lStream := TFileStream.Create(aFileName, fmOpenRead or fmShareDenyNone);
  try
    var lLeft := lStream.Size;
    while lLeft > 0 do begin
      var lChunk: Integer := cChunkSize;
      if lLeft < lChunk then
        lChunk := lLeft;
      lStream.ReadBuffer(lBuffer[0], lChunk);
      lCRC := ShaCrcRefresh(lCRC, @lBuffer[0], lChunk);
      Dec(lLeft, lChunk);
    end;
  finally
    lStream.Free;
  end;
  Result := not lCRC;
end;

procedure CRCInit;
var
  c: cardinal;
  i, j: integer;
begin;
  for i := 0 to 255 do begin
    c := i;
    for j := 1 to 8 do
     if odd(c)
       then c:=(c shr 1) xor $EDB88320
       else c:=(c shr 1);
    crctbl[0][i] := c;
  end;

  for i := 0 to 255 do begin
    c := crctbl[0][i];
    for j := 1 to 7 do begin
      c := (c shr 8) xor crctbl[0][byte(c)];
      crctbl[j][i] := c;
    end;
  end;
end;

{$IFDEF CRYPTOAPI}
function CryptAcquireContext(var phProv: DWORD;
  pszContainer, pszProvider: LPCSTR; dwProvType, dwFlags: DWORD): BOOL;
  stdcall; external advapi32 name 'CryptAcquireContextA';
function CryptCreateHash(hProv,Algid,hKey,dwFlags: DWORD;
  var phHash: DWORD): BOOL; stdcall; external advapi32;
function CryptHashData(hHash: DWORD; pbData: PBYTE; dwDataLen,
  dwFlags: DWORD): BOOL; stdcall; external advapi32;
function CryptGetHashParam(hHash, dwParam: DWORD; pbData: PBYTE;
  var pdwDataLen: DWORD; dwFlags: DWORD): BOOL; stdcall; external advapi32;
function CryptDestroyHash(hHash: DWORD): BOOL; stdcall; external advapi32;
function CryptReleaseContext(hProv: DWORD; dwFlags: DWORD): BOOL; stdcall; external advapi32;

// https://learn.microsoft.com/en-us/windows/win32/seccrypto/alg-id
const
  ALG_MD5 = $8003;
  ALG_SHA = $8004;

function CryptoAPIGetHash(Data: Pointer; nSize: Cardinal; HashType: Cardinal): TBytes;
const
  HP_HASHVAL           = $0002; {hash value}
  PROV_RSA_FULL        = 1;
  CRYPT_VERIFYCONTEXT  = $F0000000;
var
  hProv, hHash: Cardinal;
begin
  if CryptAcquireContext(hProv, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT) then try
    if CryptCreateHash(hProv, HashType, 0, 0, hHash) then try
      if CryptHashData(hHash, Data, nSize, 0) then begin
        if CryptGetHashParam(hHash, HP_HASHVAL, nil, nSize, 0) then begin
          SetLength(Result, nSize);
          if not CryptGetHashParam(hHash, HP_HASHVAL, @Result[0], nSize, 0) then
            SetLength(Result, 0);
        end;
      end;
    finally
      CryptDestroyHash(hHash);
    end;
  finally
    CryptReleaseContext(hProv, 0);
  end;
end;

function wbCryptoApiHashData(const aData: TBytes; aALG: Cardinal): TBytes;
begin
  Result := CryptoAPIGetHash(aData, Length(aData), aALG);
end;

class function TwbHash.SHA1(const aData: TBytes): TBytes;
begin
  Result := wbCryptoApiHashData(aData, ALG_SHA);
end;

class function TwbHash.SHA1(const aFileName: string): TBytes;
var
  Data: TBytes;
begin
  if FileExists(aFileName) then
    with TFileStream.Create(aFileName, fmOpenRead + fmShareDenyNone) do try
      SetLength(Data, Size);
      ReadBuffer(Pointer(Data)^, Length(Data));
      Result := SHA1(Data);
    finally
      Free;
    end;
end;

class function TwbHash.MD5(const aData: TBytes): TBytes;
begin
  Result := wbCryptoApiHashData(aData, ALG_MD5);
end;

class function TwbHash.MD5(const aFileName: string): TBytes;
var
  Data: TBytes;
begin
  if FileExists(aFileName) then
    with TFileStream.Create(aFileName, fmOpenRead + fmShareDenyNone) do try
      SetLength(Data, Size);
      ReadBuffer(Pointer(Data)^, Length(Data));
      Result := MD5(Data);
    finally
      Free;
    end;
end;
{$ENDIF}

{https://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function}

class function TwbHash.FNV132(aData: PByte; aSize: UInt64): UInt32;
const
  FNV_Offset_Basis = 2166136261;
  FNV_Prime        = 16777619;
var
  i: NativeUInt;
begin
  Result := FNV_Offset_Basis;
  for i := 1 to aSize do
  begin
    Result := Result * FNV_Prime;
    Result := Result xor aData^;
    Inc(aData);
  end;
end;

class function TwbHash.FNV132(const aBytes: TBytes): UInt32;
begin
  if Length(aBytes) > 0 then
    Result := FNV132(@aBytes[0], Length(aBytes))
  else
    Result := FNV132(nil, 0);
end;

class function TwbHash.FNV132(const aText: AnsiString; aIgnoreCase: Boolean = False): UInt32;
var
  s : AnsiString;
begin
  if aIgnoreCase then
    s := System.AnsiStrings.AnsiLowerCase(aText)
  else
    s := aText;

  Result := FNV132(PByte(PAnsiChar(s)), Length(s));
end;

class function TwbHash.FNV132(const aText: string; aIgnoreCase: Boolean = False): UInt32;
begin
  Result := FNV132(AnsiString(aText), aIgnoreCase);
end;

initialization
  CRCInit;

end.
