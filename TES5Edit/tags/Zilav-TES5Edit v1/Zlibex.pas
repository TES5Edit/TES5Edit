{*****************************************************************************
*  ZLibEx.pas (zlib 1.2.3)                                                   *
*                                                                            *
*  copyright (c) 2002-2005 Roberto Della Pasqua (www.dellapasqua.com)        *
*  copyright (c) 2000-2002 base2 technologies (www.base2ti.com)              *
*  copyright (c) 1997 Borland International (www.borland.com)                *
*                                                                            *
*  revision history                                                          *
*    2006.04.21  updated with latest Borland C++ 2006 SP2                    *
*    2005.02.03  updated with latest zlib 1.2.2, thanks to Fabio Dell'Aria   *
*                (www.eurekalog.com) for provide me the compiled objects     *
*                zlib is compiled without crc32-compressBound                *
*    2003.12.18  updated with latest zlib 1.2.1 (see www.zlib.org)           *
*                obj's compiled with fastest speed optimizations (bcc 5.6.4) *
*                (hint:see basm newsgroup about a Move RTL fast replacement) *
*                Thanks to Cosmin Truta for the pascal zlib reference        *
*                                                                            *
*    2002.11.02  ZSendToBrowser: deflate algorithm for HTTP1.1 compression   *
*    2002.10.24  ZFastCompressString and ZFastDecompressString:300% faster   *
*    2002.10.15  recompiled zlib 1.1.4 c sources with speed optimizations    *
*                (and targeting 686+ cpu) and changes to accomodate Borland  *
*                standards  (C++ v5.6 compiler)                              *
*    2002.10.15  optimized move mem for not aligned structures  (strings,etc)*
*    2002.10.15  little changes to avoid system unique string calls          *
*                                                                            *
*    2002.03.15  updated to zlib version 1.1.4                               *
*    2001.11.27  enhanced TZDecompressionStream.Read to adjust source        *
*                  stream position upon end of compression data              *
*                fixed endless loop in TZDecompressionStream.Read when       *
*                  destination count was greater than uncompressed data      *
*    2001.10.26  renamed unit to integrate "nicely" with delphi 6            *
*    2000.11.24  added soFromEnd condition to TZDecompressionStream.Seek     *
*                added ZCompressStream and ZDecompressStream                 *
*    2000.06.13  optimized, fixed, rewrote, and enhanced the zlib.pas unit   *
*                  included on the delphi cd (zlib version 1.1.3)            *
*                                                                            *
*  acknowledgements                                                          *
*    erik turner    Z*Stream routines                                        *
*    david bennion  finding the nastly little endless loop quirk with the    *
*                     TZDecompressionStream.Read method                      *
*    burak kalayci  informing me about the zlib 1.1.4 update                 *
*****************************************************************************}

unit Zlibex;

interface

uses
  Windows,
  Sysutils,
  Classes,
  ZLibConst;

const
  ZLIB_VERSION = '1.2.3';

type
  EZlibError = class(Exception);
  ECompressionError = class(EZlibError);
  EDecompressionError = class(EZlibError);

type
  TZAlloc = function(opaque: Pointer; items, size: Integer): Pointer;
  TZFree = procedure(opaque, block: Pointer);
  TZCompressionLevel = (zcNone, zcFastest, zcDefault, zcMax);

  {** TZStreamRec ***********************************************************}

  TZStreamRec = packed record
    next_in: PChar; // next input byte
    avail_in: Longint; // number of bytes available at next_in
    total_in: Longint; // total nb of input bytes read so far
    next_out: PChar; // next output byte should be put here
    avail_out: Longint; // remaining free space at next_out
    total_out: Longint; // total nb of bytes output so far
    msg: PChar; // last error message, NULL if no error
    state: Pointer; // not visible by applications
    zalloc: TZAlloc; // used to allocate the internal state
    zfree: TZFree; // used to free the internal state
    opaque: Pointer; // private data object passed to zalloc and zfree
    data_type: Integer; // best guess about the data type: ascii or binary
    adler: Longint; // adler32 value of the uncompressed data
    reserved: Longint; // reserved for future use
  end;

  {** TCustomZStream ********************************************************}

  TCustomZStream = class(TStream)
  private
    FStream: TStream;
    FStreamPos: Integer;
    FOnProgress: TNotifyEvent;
    FZStream: TZStreamRec;
    FBuffer: array[Word] of Char;
  protected
    constructor Create(stream: TStream);
    procedure DoProgress; dynamic;
    property OnProgress: TNotifyEvent read FOnProgress write FOnProgress;
    property TotalIn: Integer read FZStream.total_in;
    property TotalOut: Integer read FZStream.total_Out;
  end;

  {** TZCompressionStream ***************************************************}

  TZCompressionStream = class(TCustomZStream)
  private
    function GetCompressionRate: Single;
  public
    constructor Create(dest: TStream; compressionLevel: TZCompressionLevel = zcDefault);
    destructor Destroy; override;
    function Read(var buffer; count: Longint): Longint; override;
    function Write(const buffer; count: Longint): Longint; override;
    function Seek(offset: Longint; origin: Word): Longint; override;
    property CompressionRate: Single read GetCompressionRate;
    property OnProgress;
  end;

  {** TZDecompressionStream *************************************************}

  TZDecompressionStream = class(TCustomZStream)
  public
    constructor Create(source: TStream);
    destructor Destroy; override;
    function Read(var buffer; count: Longint): Longint; override;
    function Write(const buffer; count: Longint): Longint; override;
    function Seek(offset: Longint; origin: Word): Longint; override;
    property OnProgress;
  end;

{** zlib public routines ****************************************************}

{*****************************************************************************
*  ZCompress                                                                 *
*                                                                            *
*  pre-conditions                                                            *
*    inBuffer  = pointer to uncompressed data                                *
*    inSize    = size of inBuffer (bytes)                                    *
*    outBuffer = pointer (unallocated)                                       *
*    level     = compression level                                           *
*                                                                            *
*  post-conditions                                                           *
*    outBuffer = pointer to compressed data (allocated)                      *
*    outSize   = size of outBuffer (bytes)                                   *
*****************************************************************************}

procedure ZCompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer;
  level: TZCompressionLevel = zcDefault);

{*****************************************************************************
*  ZDecompress                                                               *
*                                                                            *
*  pre-conditions                                                            *
*    inBuffer    = pointer to compressed data                                *
*    inSize      = size of inBuffer (bytes)                                  *
*    outBuffer   = pointer (unallocated)                                     *
*    outEstimate = estimated size of uncompressed data (bytes)               *
*                                                                            *
*  post-conditions                                                           *
*    outBuffer = pointer to decompressed data (allocated)                    *
*    outSize   = size of outBuffer (bytes)                                   *
*****************************************************************************}

procedure ZDecompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer; outEstimate: Integer = 0);

{** string routines *********************************************************}

function ZCompressStr(const s: string; level: TZCompressionLevel = zcDefault): string;

function ZDecompressStr(const s: string): string;

{** stream routines *********************************************************}

procedure ZCompressStream(inStream, outStream: TStream;
  level: TZCompressionLevel = zcDefault);

procedure ZDecompressStream(inStream, outStream: TStream);

{** export routines ********************************************************}

function adler32(adler: LongInt; const buf: PChar; len: Integer): LongInt;
procedure MoveI32(const Source; var Dest; Count: Integer);
procedure ZFastCompressString(var s: string; level: TZCompressionLevel);
procedure ZFastDecompressString(var s: string);
procedure ZSendToBrowser(var s: string);
function deflateInit_(var strm: TZStreamRec; level: Integer; version: PChar; recsize: Integer): Integer;
function DeflateInit2_(var strm: TZStreamRec; level: integer; method: integer; windowBits: integer; memLevel: integer; strategy: integer; version: PChar; recsize: integer): integer;
function deflate(var strm: TZStreamRec; flush: Integer): Integer;
function deflateEnd(var strm: TZStreamRec): Integer;
function inflateInit_(var strm: TZStreamRec; version: PChar; recsize: Integer): Integer;
function inflateInit2_(var strm: TZStreamRec; windowBits: integer;  version: PChar; recsize: integer): integer;
function inflate(var strm: TZStreamRec; flush: Integer): Integer;
function inflateEnd(var strm: TZStreamRec): Integer;
function inflateReset(var strm: TZStreamRec): Integer;

type
  EZCompressionError = class(EZLibError);
  EZDecompressionError = class(EZLibError);

{ DecompressToUserBuf decompresses data, buffer to buffer, in one call.
   In: InBuf = ptr to compressed data
       InBytes = number of bytes in InBuf
  Out: OutBuf = ptr to user-allocated buffer to contain decompressed data
       BufSize = number of bytes in OutBuf   }
procedure DecompressToUserBuf(const InBuf: Pointer; InBytes: Integer;
  const OutBuf: Pointer; BufSize: Integer);

implementation

function DCheck(code: Integer): Integer;
begin
  Result := code;
  if code < 0 then
    raise EDecompressionError.Create(sError);  //!!
end;

{** link zlib 1.2.3 **************************************************************}
{** bcc32 -c -6 -O2 -Ve -X -pr -a8 -b -d -k- -vi -tWM -r -RT- -ff *.c **}

{$L Zlib/adler32.obj}
{$L Zlib/deflate.obj}
{$L Zlib/infback.obj}
{$L Zlib/inffast.obj}
{$L Zlib/inflate.obj}
{$L Zlib/inftrees.obj}
{$L Zlib/trees.obj}
{$L Zlib/compress.obj}
{$L Zlib/crc32.obj}

{*****************************************************************************
*  note: do not reorder the above -- doing so will result in external        *
*  functions being undefined                                                 *
*****************************************************************************}

const
  {** flush constants *******************************************************}

  Z_NO_FLUSH = 0;
  Z_PARTIAL_FLUSH = 1;
  Z_SYNC_FLUSH = 2;
  Z_FULL_FLUSH = 3;
  Z_FINISH = 4;

  {** return codes **********************************************************}

  Z_OK = 0;
  Z_STREAM_END = 1;
  Z_NEED_DICT = 2;
  Z_ERRNO = (-1);
  Z_STREAM_ERROR = (-2);
  Z_DATA_ERROR = (-3);
  Z_MEM_ERROR = (-4);
  Z_BUF_ERROR = (-5);
  Z_VERSION_ERROR = (-6);

  {** compression levels ****************************************************}

  Z_NO_COMPRESSION = 0;
  Z_BEST_SPEED = 1;
  Z_BEST_COMPRESSION = 9;
  Z_DEFAULT_COMPRESSION = (-1);

  {** compression strategies ************************************************}

  Z_FILTERED = 1;
  Z_HUFFMAN_ONLY = 2;
  Z_DEFAULT_STRATEGY = 0;

  {** data types ************************************************************}

  Z_BINARY = 0;
  Z_ASCII = 1;
  Z_UNKNOWN = 2;

  {** compression methods ***************************************************}

  Z_DEFLATED = 8;

  {** return code messages **************************************************}

  _z_errmsg: array[0..9] of PChar = (
    'need dictionary', // Z_NEED_DICT      (2)
    'stream end', // Z_STREAM_END     (1)
    '', // Z_OK             (0)
    'file error', // Z_ERRNO          (-1)
    'stream error', // Z_STREAM_ERROR   (-2)
    'data error', // Z_DATA_ERROR     (-3)
    'insufficient memory', // Z_MEM_ERROR      (-4)
    'buffer error', // Z_BUF_ERROR      (-5)
    'incompatible version', // Z_VERSION_ERROR  (-6)
    ''
    );

  ZLevels: array[TZCompressionLevel] of Shortint = (
    Z_NO_COMPRESSION,
    Z_BEST_SPEED,
    Z_DEFAULT_COMPRESSION,
    Z_BEST_COMPRESSION
    );

  SZInvalid = 'Invalid ZStream operation!';

{*********************** Peter Morris not aligned move **********************}

procedure MoveI32(const Source; var Dest; Count: Integer); register;
asm
        cmp   ECX,0
        Je    @JustQuit
        push  ESI
        push  EDI
        mov   ESI, EAX
        mov   EDI, EDX
    @Loop:
	Mov   AL, [ESI]
        Inc   ESI
        mov   [EDI], AL
        Inc   EDI
        Dec   ECX
        Jnz   @Loop
        pop   EDI
        pop   ESI
    @JustQuit:
end;
{****************************************************************************}

{** deflate routines ********************************************************}

function deflateInit_(var strm: TZStreamRec; level: Integer; version: PChar;
  recsize: Integer): Integer; external;

function DeflateInit2_(var strm: TZStreamRec; level: integer; method: integer; windowBits: integer;
  memLevel: integer; strategy: integer; version: PChar; recsize: integer): integer; external;

function deflate(var strm: TZStreamRec; flush: Integer): Integer;
  external;

function deflateEnd(var strm: TZStreamRec): Integer; external;

{** inflate routines ********************************************************}

function inflateInit_(var strm: TZStreamRec; version: PChar;
  recsize: Integer): Integer; external;

function inflateInit2_(var strm: TZStreamRec; windowBits: integer;
  version: PChar; recsize: integer): integer; external;

function inflate(var strm: TZStreamRec; flush: Integer): Integer;
  external;

function inflateEnd(var strm: TZStreamRec): Integer; external;

function inflateReset(var strm: TZStreamRec): Integer; external;

{** utility routines  *******************************************************}

function adler32; external;
//function crc32; external;
//function compressBound; external;

{** zlib function implementations *******************************************}

function zcalloc(opaque: Pointer; items, size: Integer): Pointer;
begin
  GetMem(result, items * size);
end;

procedure zcfree(opaque, block: Pointer);
begin
  FreeMem(block);
end;

{** c function implementations **********************************************}

procedure _memset(p: Pointer; b: Byte; count: Integer); cdecl;
begin
  FillChar(p^, count, b);
end;

procedure _memcpy(dest, source: Pointer; count: Integer); cdecl;
begin
  Move(source^, dest^, count);
end;

function _malloc(Size: Integer): Pointer; cdecl;
begin
  GetMem(Result, Size);
end;

procedure _free(Block: Pointer); cdecl;
begin
  FreeMem(Block);
end;

{** custom zlib routines ****************************************************}

function DeflateInit(var stream: TZStreamRec; level: Integer): Integer;
begin
  result := DeflateInit_(stream, level, ZLIB_VERSION, SizeOf(TZStreamRec));
end;

function DeflateInit2(var stream: TZStreamRec; level, method, windowBits,
  memLevel, strategy: Integer): Integer;
begin
  result := DeflateInit2_(stream, level, method, windowBits, memLevel, strategy, ZLIB_VERSION, SizeOf(TZStreamRec));
end;

function InflateInit(var stream: TZStreamRec): Integer;
begin
  result := InflateInit_(stream, ZLIB_VERSION, SizeOf(TZStreamRec));
end;

function InflateInit2(var stream: TZStreamRec; windowBits: Integer): Integer;
begin
  result := InflateInit2_(stream, windowBits, ZLIB_VERSION, SizeOf(TZStreamRec));
end;

{****************************************************************************}

function ZCompressCheck(code: Integer): Integer;
begin
  result := code;

  if code < 0 then
  begin
    raise EZCompressionError.Create(_z_errmsg[2 - code]);
  end;
end;

function ZDecompressCheck(code: Integer): Integer;
begin
  Result := code;

  if code < 0 then
  begin
    raise EZDecompressionError.Create(_z_errmsg[2 - code]);
  end;
end;

procedure ZCompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer;
  level: TZCompressionLevel);
const
  delta = 256;
var
  zstream: TZStreamRec;
begin
  FillChar(zstream, SizeOf(TZStreamRec), 0);

  outSize := ((inSize + (inSize div 10) + 12) + 255) and not 255;
  GetMem(outBuffer, outSize);

  try
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;
    zstream.next_out := outBuffer;
    zstream.avail_out := outSize;

    ZCompressCheck(DeflateInit(zstream, ZLevels[level]));

    try
      while ZCompressCheck(deflate(zstream, Z_FINISH)) <> Z_STREAM_END do
      begin
        Inc(outSize, delta);
        ReallocMem(outBuffer, outSize);

        zstream.next_out := PChar(Integer(outBuffer) + zstream.total_out);
        zstream.avail_out := delta;
      end;
    finally
      ZCompressCheck(deflateEnd(zstream));
    end;

    ReallocMem(outBuffer, zstream.total_out);
    outSize := zstream.total_out;
  except
    FreeMem(outBuffer);
    raise;
  end;
end;

procedure ZCompress2(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer);
const
  delta = 256;
var
  zstream: TZStreamRec;
begin
  FillChar(zstream, SizeOf(TZStreamRec), 0);

  outSize := ((inSize + (inSize div 10) + 12) + 255) and not 255;
  GetMem(outBuffer, outSize);

  try
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;
    zstream.next_out := outBuffer;
    zstream.avail_out := outSize;

    ZCompressCheck(DeflateInit2(zstream, 1, 8, -15, 9, 0));

    try
      while ZCompressCheck(deflate(zstream, Z_FINISH)) <> Z_STREAM_END do
      begin
        Inc(outSize, delta);
        ReallocMem(outBuffer, outSize);

        zstream.next_out := PChar(Integer(outBuffer) + zstream.total_out);
        zstream.avail_out := delta;
      end;
    finally
      ZCompressCheck(deflateEnd(zstream));
    end;

    ReallocMem(outBuffer, zstream.total_out);
    outSize := zstream.total_out;
  except
    FreeMem(outBuffer);
    raise;
  end;
end;

procedure ZDecompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer; outEstimate: Integer);
var
  zstream: TZStreamRec;
  delta: Integer;
begin
  FillChar(zstream, SizeOf(TZStreamRec), 0);

  delta := (inSize + 255) and not 255;

  if outEstimate = 0 then outSize := delta
  else outSize := outEstimate;

  GetMem(outBuffer, outSize);

  try
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;
    zstream.next_out := outBuffer;
    zstream.avail_out := outSize;

    ZDecompressCheck(InflateInit(zstream));

    try
      while ZDecompressCheck(inflate(zstream, Z_NO_FLUSH)) <> Z_STREAM_END do
      begin
        Inc(outSize, delta);
        ReallocMem(outBuffer, outSize);

        zstream.next_out := PChar(Integer(outBuffer) + zstream.total_out);
        zstream.avail_out := delta;
      end;
    finally
      ZDecompressCheck(inflateEnd(zstream));
    end;

    ReallocMem(outBuffer, zstream.total_out);
    outSize := zstream.total_out;
  except
    FreeMem(outBuffer);
    raise;
  end;
end;

{** string routines *********************************************************}

function ZCompressStr(const s: string; level: TZCompressionLevel): string;
var
  buffer: Pointer;
  size: Integer;
begin
  ZCompress(PChar(s), Length(s), buffer, size, level);
  SetLength(result, size);
  Move(buffer^, pointer(result)^, size);
  FreeMem(buffer);
end;

procedure ZFastCompressString(var s: string; level: TZCompressionLevel);
var
  outBuf: Pointer;
  outBytes: Integer;
begin
  ZCompress(pointer(s), length(s), outBuf, outBytes, level);
  SetLength(s, outBytes);
  MoveI32(pointer(outBuf)^, pointer(s)^, outBytes);
  FreeMem(outBuf);
end;

procedure ZFastDecompressString(var s: string);
var
  outBuf: Pointer;
  outBytes: Integer;
begin
  ZDecompress(pointer(s), Length(s), outBuf, outBytes);
  SetLength(s, outBytes);
  MoveI32(pointer(outBuf)^, pointer(s)^, outBytes);
  FreeMem(outBuf);
end;

procedure ZSendToBrowser(var s: string);
var
  outBuf: Pointer;
  outBytes: Integer;
begin
  ZCompress2(pointer(s), length(s), outBuf, outBytes);
  SetLength(s, outBytes);
  Move(pointer(outBuf)^, pointer(s)^, outBytes);
  FreeMem(outBuf);
end;

function ZDecompressStr(const s: string): string;
var
  buffer: Pointer;
  size: Integer;
begin
  ZDecompress(PChar(s), Length(s), buffer, size);
  SetLength(result, size);
  Move(buffer^, pointer(result)^, size);
  FreeMem(buffer);
end;

{** stream routines *********************************************************}

procedure ZCompressStream(inStream, outStream: TStream;
  level: TZCompressionLevel);
const
  bufferSize = 32768;
var
  zstream: TZStreamRec;
  zresult: Integer;
  inBuffer: array[0..bufferSize - 1] of Char;
  outBuffer: array[0..bufferSize - 1] of Char;
  inSize: Integer;
  outSize: Integer;
begin
  FillChar(zstream, SizeOf(TZStreamRec), 0);

  ZCompressCheck(DeflateInit(zstream, ZLevels[level]));

  inSize := inStream.Read(inBuffer, bufferSize);

  while inSize > 0 do
  begin
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;

    repeat
      zstream.next_out := outBuffer;
      zstream.avail_out := bufferSize;

      ZCompressCheck(deflate(zstream, Z_NO_FLUSH));

      // outSize := zstream.next_out - outBuffer;
      outSize := bufferSize - zstream.avail_out;

      outStream.Write(outBuffer, outSize);
    until (zstream.avail_in = 0) and (zstream.avail_out > 0);

    inSize := inStream.Read(inBuffer, bufferSize);
  end;

  repeat
    zstream.next_out := outBuffer;
    zstream.avail_out := bufferSize;

    zresult := ZCompressCheck(deflate(zstream, Z_FINISH));

    // outSize := zstream.next_out - outBuffer;
    outSize := bufferSize - zstream.avail_out;

    outStream.Write(outBuffer, outSize);
  until (zresult = Z_STREAM_END) and (zstream.avail_out > 0);

  ZCompressCheck(deflateEnd(zstream));
end;

procedure ZDecompressStream(inStream, outStream: TStream);
const
  bufferSize = 32768;
var
  zstream: TZStreamRec;
  zresult: Integer;
  inBuffer: array[0..bufferSize - 1] of Char;
  outBuffer: array[0..bufferSize - 1] of Char;
  inSize: Integer;
  outSize: Integer;
begin
  FillChar(zstream, SizeOf(TZStreamRec), 0);

  ZCompressCheck(InflateInit(zstream));

  inSize := inStream.Read(inBuffer, bufferSize);

  while inSize > 0 do
  begin
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;

    repeat
      zstream.next_out := outBuffer;
      zstream.avail_out := bufferSize;

      ZCompressCheck(inflate(zstream, Z_NO_FLUSH));

      // outSize := zstream.next_out - outBuffer;
      outSize := bufferSize - zstream.avail_out;

      outStream.Write(outBuffer, outSize);
    until (zstream.avail_in = 0) and (zstream.avail_out > 0);

    inSize := inStream.Read(inBuffer, bufferSize);
  end;

  repeat
    zstream.next_out := outBuffer;
    zstream.avail_out := bufferSize;

    zresult := ZCompressCheck(inflate(zstream, Z_FINISH));

    // outSize := zstream.next_out - outBuffer;
    outSize := bufferSize - zstream.avail_out;

    outStream.Write(outBuffer, outSize);
  until (zresult = Z_STREAM_END) and (zstream.avail_out > 0);

  ZCompressCheck(inflateEnd(zstream));
end;

{** TCustomZStream **********************************************************}

constructor TCustomZStream.Create(stream: TStream);
begin
  inherited Create;
  FStream := stream;
  FStreamPos := stream.Position;
end;

procedure TCustomZStream.DoProgress;
begin
  if Assigned(FOnProgress) then FOnProgress(Self);
end;

{** TZCompressionStream *****************************************************}

constructor TZCompressionStream.Create(dest: TStream;
  compressionLevel: TZCompressionLevel);
begin
  inherited Create(dest);

  FZStream.next_out := FBuffer;
  FZStream.avail_out := SizeOf(FBuffer);

  ZCompressCheck(DeflateInit(FZStream, ZLevels[compressionLevel]));
end;

destructor TZCompressionStream.Destroy;
begin
  FZStream.next_in := nil;
  FZStream.avail_in := 0;

  try
    if FStream.Position <> FStreamPos then FStream.Position := FStreamPos;

    while ZCompressCheck(deflate(FZStream, Z_FINISH)) <> Z_STREAM_END do
    begin
      FStream.WriteBuffer(FBuffer, SizeOf(FBuffer) - FZStream.avail_out);

      FZStream.next_out := FBuffer;
      FZStream.avail_out := SizeOf(FBuffer);
    end;

    if FZStream.avail_out < SizeOf(FBuffer) then
    begin
      FStream.WriteBuffer(FBuffer, SizeOf(FBuffer) - FZStream.avail_out);
    end;
  finally
    deflateEnd(FZStream);
  end;

  inherited Destroy;
end;

function TZCompressionStream.Read(var buffer; count: Longint): Longint;
begin
  raise EZCompressionError.Create(SZInvalid);
end;

function TZCompressionStream.Write(const buffer; count: Longint): Longint;
begin
  FZStream.next_in := @buffer;
  FZStream.avail_in := count;

  if FStream.Position <> FStreamPos then FStream.Position := FStreamPos;

  while FZStream.avail_in > 0 do
  begin
    ZCompressCheck(deflate(FZStream, Z_NO_FLUSH));

    if FZStream.avail_out = 0 then
    begin
      FStream.WriteBuffer(FBuffer, SizeOf(FBuffer));

      FZStream.next_out := FBuffer;
      FZStream.avail_out := SizeOf(FBuffer);

      FStreamPos := FStream.Position;

      DoProgress;
    end;
  end;

  result := Count;
end;

function TZCompressionStream.Seek(offset: Longint; origin: Word): Longint;
begin
  if (offset = 0) and (origin = soFromCurrent) then
  begin
    result := FZStream.total_in;
  end
  else raise EZCompressionError.Create(SZInvalid);
end;

function TZCompressionStream.GetCompressionRate: Single;
begin
  if FZStream.total_in = 0 then result := 0
  else result := (1.0 - (FZStream.total_out / FZStream.total_in)) * 100.0;
end;

{** TZDecompressionStream ***************************************************}

constructor TZDecompressionStream.Create(source: TStream);
begin
  inherited Create(source);
  FZStream.next_in := FBuffer;
  FZStream.avail_in := 0;
  ZDecompressCheck(InflateInit(FZStream));
end;

destructor TZDecompressionStream.Destroy;
begin
  inflateEnd(FZStream);
  inherited Destroy;
end;

function TZDecompressionStream.Read(var buffer; count: Longint): Longint;
var
  zresult: Integer;
begin
  FZStream.next_out := @buffer;
  FZStream.avail_out := count;

  if FStream.Position <> FStreamPos then FStream.Position := FStreamPos;

  zresult := Z_OK;

  while (FZStream.avail_out > 0) and (zresult <> Z_STREAM_END) do
  begin
    if FZStream.avail_in = 0 then
    begin
      FZStream.avail_in := FStream.Read(FBuffer, SizeOf(FBuffer));

      if FZStream.avail_in = 0 then
      begin
        result := count - FZStream.avail_out;

        Exit;
      end;

      FZStream.next_in := FBuffer;
      FStreamPos := FStream.Position;

      DoProgress;
    end;

    zresult := ZDecompressCheck(inflate(FZStream, Z_NO_FLUSH));
  end;

  if (zresult = Z_STREAM_END) and (FZStream.avail_in > 0) then
  begin
    FStream.Position := FStream.Position - FZStream.avail_in;
    FStreamPos := FStream.Position;

    FZStream.avail_in := 0;
  end;

  result := count - FZStream.avail_out;
end;

function TZDecompressionStream.Write(const Buffer; Count: Longint): Longint;
begin
  raise EZDecompressionError.Create(SZInvalid);
end;

function TZDecompressionStream.Seek(Offset: Longint; Origin: Word): Longint;
var
  buf: array[0..8191] of Char;
  i: Integer;
begin
  if (offset = 0) and (origin = soFromBeginning) then
  begin
    ZDecompressCheck(inflateReset(FZStream));

    FZStream.next_in := FBuffer;
    FZStream.avail_in := 0;

    FStream.Position := 0;
    FStreamPos := 0;
  end
  else if ((offset >= 0) and (origin = soFromCurrent)) or
    (((offset - FZStream.total_out) > 0) and (origin = soFromBeginning)) then
  begin
    if origin = soFromBeginning then Dec(offset, FZStream.total_out);

    if offset > 0 then
    begin
      for i := 1 to offset div SizeOf(buf) do ReadBuffer(buf, SizeOf(buf));
      ReadBuffer(buf, offset mod SizeOf(buf));
    end;
  end
  else if (offset = 0) and (origin = soFromEnd) then
  begin
    while Read(buf, SizeOf(buf)) > 0 do ;
  end
  else raise EZDecompressionError.Create(SZInvalid);

  result := FZStream.total_out;
end;

procedure DecompressToUserBuf(const InBuf: Pointer; InBytes: Integer;
  const OutBuf: Pointer; BufSize: Integer);
var
  strm: TZStreamRec;
begin
  FillChar(strm, sizeof(strm), 0);
//  strm.zalloc := zlibAllocMem;
//  strm.zfree := zlibFreeMem;
  strm.next_in := InBuf;
  strm.avail_in := InBytes;
  strm.next_out := OutBuf;
  strm.avail_out := BufSize;
  DCheck(inflateInit_(strm, zlib_version, sizeof(strm)));
  try
    if DCheck(inflate(strm, Z_FINISH)) <> Z_STREAM_END then
      raise EZlibError.CreateRes(@sTargetBufferTooSmall);
  finally
    DCheck(inflateEnd(strm));
  end;
end;

end.
