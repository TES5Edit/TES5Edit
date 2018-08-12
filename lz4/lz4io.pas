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


unit lz4io;
{$POINTERMATH ON}

interface

uses Windows, Classes, SysUtils, Math, lz4frame_static, xxHash, lz4, lz4common, lz4frame, lz4HC;


const
    LZ4_BLOCKSIZEID_DEFAULT = 7;
    ENDOFSTREAM = uint64(-1);
    LZ4S_MAGICNUMBER = $184D2204;
    LZ4S_SKIPPABLE0 = $184D2A50;
    LZ4S_SKIPPABLEMASK = $FFFFFFF0;
    LEGACY_MAGICNUMBER = $184C2102;
    MAGICNUMBER_SIZE = 4;
    LEGACY_BLOCKSIZE = 8388608;
    MIN_STREAM_BUFSIZE = 196608;

var
    lz4_overwrite_file: boolean = true;
    globalblockSizeID: integer = LZ4_BLOCKSIZEID_DEFAULT;
    blockIndependence: integer = 1;
    streamChecksum: integer = 1;

function LZ4IO_compressFilename_Legacy(input_filename: string; output_filename: string; compressionLevel: integer): integer;
function LZ4IO_compressFilename(input_filename: string; output_filename: string; compressionLevel: integer): integer;
function LZ4IO_decompressFilename(input_filename: string; output_filename: string): integer;
procedure lz4DecompressToUserBuf(const InBuf: Pointer; InBytes: Integer;
  const OutBuf: Pointer; BufSize: Integer);

function lz4CompressStream(aSource, aCompressed: TStream; aCompressionLevel: Integer = 8): Integer;
function lz4DeCompressStream(aCompressed, aTarget: TStream): Integer;

implementation

const
    minBlockSizeID: integer = 4;
    maxBlockSizeID: integer = 7;

function reportError(err: string): integer;
begin
    //LZ4Client.Memo.Lines.Add(err);
    result := 0;
end;

procedure LZ4IO_writeLE32(p: pointer; value32: cardinal);
var
    dstPtr: pByte;
begin
    dstPtr := p;
    dstPtr[0] := byte(value32);
    dstPtr[1] := byte(value32 shr 8);
    dstPtr[2] := byte(value32 shr 16);
    dstPtr[3] := byte(value32 shr 24);
end;

function LZ4IO_compressFilename_Legacy(input_filename: string; output_filename: string; compressionLevel: integer): integer;
type
    TCompressionFunction =
      function(c1: pAnsiChar; c2: pAnsiChar; c3: integer): integer;
var
    compressionFunction: TCompressionFunction;
    filesize: uint64;
    compressedfilesize: uint64;
    in_buff: pAnsiChar;
    out_buff: pAnsiChar;
    fileIn: TFileSTream;
    fileOut: TFileSTream;
    sizeCheck: size_t;
    outSize, inSize: cardinal;
begin
    filesize := 0;
    compressedfilesize := MAGICNUMBER_SIZE;

    if (compressionLevel < 3) then
        compressionFunction := LZ4_compress
    else
        compressionFunction := LZ4_compressHC;
    fileIn := TFileSTream.Create(input_filename, fmOpenRead);
    fileOut := TFileSTream.Create(output_filename, fmCreate);

    in_buff := allocmem(LEGACY_BLOCKSIZE);
    out_buff := allocmem(LZ4_compressBound(LEGACY_BLOCKSIZE));
    try
        if (in_buff = nil) or (out_buff = nil) then
            exit(reportError('Allocation error : not enough memory'));
        LZ4IO_writeLE32(out_buff, LEGACY_MAGICNUMBER);
        sizeCheck := fileOut.Write(out_buff^, MAGICNUMBER_SIZE);
        if sizeCheck <> MAGICNUMBER_SIZE then
            exit(reportError('Write error : cannot write header'));
        while true do
        begin
            inSize := fileIn.Read(in_buff^, LEGACY_BLOCKSIZE);
            if inSize <= 0 then
                break;
            inc(filesize, inSize);
            outSize := compressionFunction(in_buff, out_buff + 4, inSize);
            inc(compressedfilesize, outSize + 4);
            LZ4IO_writeLE32(out_buff, outSize);
            sizeCheck := fileOut.Write(out_buff^, outSize + 4);
            if sizeCheck <> size_t(outSize + 4) then
                exit(reportError('Write error : cannot write compressed block'));
        end;
    finally
        if in_buff <> nil then
            freemem(in_buff);
        if out_buff <> nil then
            freemem(out_buff);
        fileIn.Free;
        fileOut.Free;
        result := 0;
    end;
end;

function LZ4IO_setBlockSizeID(bsid: integer): integer;
const
    blockSizeTable: array [0 .. 3] of integer = (65536, 262144, 1048576, 4194304);
begin
    if (bsid < minBlockSizeID) or (bsid > maxBlockSizeID) then
        exit(-1);
    globalblockSizeID := bsid;
    result := blockSizeTable[globalblockSizeID - minBlockSizeID];
end;

function LZ4IO_compressFilename(input_filename: string; output_filename: string; compressionLevel: integer): integer;
var
    filesize: uint64;
    errorCode: LZ4F_errorCode_t;
    ctx: PLZ4F_compressionContext_t;
    blockSize: integer;
    fileIn: TFileSTream;
    fileOut: TFileSTream;
    prefs: LZ4F_preferences_t;
    in_buff: pAnsiChar;
    out_buff: pAnsiChar;
    outBuffSize: size_t;
    headerSize: size_t;
    sizeCheck: size_t;
    readSize: size_t;
    outSize: size_t;
begin
    result := 0;
    filesize := 0;
    errorCode := LZ4F_createCompressionContext(ctx, LZ4F_VERSION);
    if (LZ4F_isError(errorCode)) then
        exit(reportError(format('Allocation error : can''t create LZ4F context: %s', [LZ4F_getErrorName(errorCode)])));
    fileIn := TFileSTream.Create(input_filename, fmOpenRead);
    fileOut := TFileSTream.Create(output_filename, fmCreate);
    blockSize := 1 shl (8 + 2 * globalblockSizeID);
    fillchar(prefs, sizeof(LZ4F_preferences_t), 0);

    prefs.autoFlush := 1;
    prefs.compressionLevel := compressionLevel;
    prefs.frameInfo.blockMode := blockMode_t(blockIndependence);
    prefs.frameInfo.blockSizeID := blockSizeID_t(globalblockSizeID);
    prefs.frameInfo.contentChecksumFlag := contentChecksum_t(streamChecksum);

    // Allocate Memory
    in_buff := allocmem(blockSize);
    outBuffSize := LZ4F_compressBound(blockSize, @prefs);
    out_buff := allocmem(outBuffSize);
    try
        if (in_buff = nil) or (out_buff = nil) then
            exit(reportError('Allocation error : not enough memory'));
        // Write Archive Header
        headerSize := LZ4F_compressBegin(ctx, out_buff, outBuffSize, @prefs);
        if (LZ4F_isError(headerSize)) then
            exit(reportError(format('File header generation failed: %s', [LZ4F_getErrorName(errorCode)])));
        sizeCheck := fileOut.Write(out_buff^, headerSize);
        if sizeCheck <> headerSize then
            exit(reportError('Write error : cannot write header'));

        readSize := fileIn.Read(in_buff^, blockSize);
        inc(filesize, readSize);
        while readSize > 0 do
        begin
            outSize := LZ4F_compressUpdate(ctx, out_buff, outBuffSize, in_buff, readSize, Nil);
            if (LZ4F_isError(outSize)) then
                exit(reportError(format('Compression failed: %s', [LZ4F_getErrorName(errorCode)])));
            sizeCheck := fileOut.Write(out_buff^, outSize);
            if sizeCheck <> outSize then
                exit(reportError('Write error : cannot write compressed block'));
            readSize := fileIn.Read(in_buff^, blockSize);
            inc(filesize, readSize);
        end;
        // End of Stream mark
        headerSize := LZ4F_compressEnd(ctx, out_buff, outBuffSize, Nil);
        if LZ4F_isError(headerSize) then
            exit(reportError(format('End of file generation failed: %s', [LZ4F_getErrorName(errorCode)])));
        sizeCheck := fileOut.Write(out_buff^, headerSize);
        if sizeCheck <> headerSize then
            exit(reportError('Write error : cannot write end of stream'));
        errorCode := LZ4F_freeCompressionContext(ctx);
        if LZ4F_isError(errorCode) then
            exit(reportError(format('Error : can''t free LZ4F context resource: %s', [LZ4F_getErrorName(errorCode)])));
    finally
        if in_buff <> nil then
            freemem(in_buff);
        if out_buff <> nil then
            freemem(out_buff);
        fileIn.Free;;
        fileOut.Free;
    end;
end;

function LZ4IO_readLE32(s: pointer): cardinal;
var
    srcPtr: pByte;
    value32: cardinal;
begin
    srcPtr := s;
    value32 := srcPtr[0];
    inc(value32, (srcPtr[1] shl 8));
    inc(value32, (srcPtr[2] shl 16));
    inc(value32, (srcPtr[3] shl 24));
    result := value32;
end;

function LZ4S_isSkippableMagicNumber(magic: cardinal): boolean;
begin
    result := (magic and LZ4S_SKIPPABLEMASK) = LZ4S_SKIPPABLE0;
end;

function decodeLZ4S(finput, foutput: TSTream): uint64;
const
    HEADERMAX = 20;
var
    filesize: uint64;
    inBuff: pAnsiChar;
    outBuff: pAnsiChar;
    headerBuff: array [0 .. HEADERMAX - 1] of ansiChar;
    sizeCheck, nextToRead, outBuffSize, inBuffSize: size_t;
    ctx: PLZ4F_decompressionContext_t;
    errorCode: LZ4F_errorCode_t;
    frameInfo: LZ4F_frameInfo_t;
    decodedBytes: size_t;
begin
    filesize := 0;
    errorCode := LZ4F_createDecompressionContext(ctx, LZ4F_VERSION);
    if LZ4F_isError(errorCode) then
        exit(reportError(format('Allocation error : can''t create context: %s', [LZ4F_getErrorName(errorCode)])));
    LZ4IO_writeLE32(@headerBuff, LZ4S_MAGICNUMBER);
    outBuffSize := 0;
    inBuffSize := 0;
    sizeCheck := MAGICNUMBER_SIZE;
    nextToRead := LZ4F_decompress(ctx, Nil, @outBuffSize, @headerBuff, @sizeCheck, Nil);
    if LZ4F_isError(nextToRead) then
        exit(reportError(format('Decompression error: %s', [LZ4F_getErrorName(errorCode)])));
    if nextToRead > HEADERMAX then
        exit(reportError(format('Header too large (%d>%d)', [integer(nextToRead), HEADERMAX])));
    sizeCheck := finput.Read(headerBuff, nextToRead);
    if sizeCheck <> nextToRead then
        exit(reportError('Read error'));
    nextToRead := LZ4F_decompress(ctx, Nil, @outBuffSize, @headerBuff, @sizeCheck, Nil);
    errorCode := LZ4F_getFrameInfo(ctx, @frameInfo, Nil, @inBuffSize);
    if LZ4F_isError(errorCode) then
        exit(reportError(format('can''t decode frame header: %s', [LZ4F_getErrorName(errorCode)])));
    outBuffSize := LZ4IO_setBlockSizeID(integer(frameInfo.blockSizeID));
    inBuffSize := outBuffSize + 4;
    inBuff := allocmem(inBuffSize);
    outBuff := allocmem(outBuffSize);
    try
        if (inBuff = nil) or (outBuff = nil) then
            exit(reportError('Allocation error : not enough memory'));
        while (nextToRead <> 0) do
        begin
            decodedBytes := outBuffSize;
            sizeCheck := finput.Read(inBuff^, nextToRead);
            if sizeCheck <> nextToRead then
                exit(reportError('Read error'));
            errorCode := LZ4F_decompress(ctx, outBuff, @decodedBytes, inBuff, @sizeCheck, Nil);
            if LZ4F_isError(errorCode) then
                exit(reportError(format('Decompression error: %s', [LZ4F_getErrorName(errorCode)])));
            if sizeCheck <> nextToRead then
                exit(reportError('Synchronization error'));
            nextToRead := errorCode;
            inc(filesize, decodedBytes);
            sizeCheck := foutput.Write(outBuff^, decodedBytes);
            if sizeCheck <> decodedBytes then
                exit(reportError('Write error : cannot write decoded block'));
        end;
        errorCode := LZ4F_freeDecompressionContext(ctx);
        if LZ4F_isError(errorCode) then
            exit(reportError(format('Error : can''t free LZ4F context resource: %s', [LZ4F_getErrorName(errorCode)])));
    finally
        if inBuff <> nil then
            freemem(inBuff);
        if outBuff <> nil then
            freemem(outBuff);
        result := filesize;
    end;
end;

function decodeLegacyStream(finput, foutput: TSTream): uint64;
var
    filesize: uint64;
    in_buff: pAnsiChar;
    out_buff: pAnsiChar;
    decodeSize: integer;
    sizeCheck: size_t;
    blockSize: cardinal;
begin
    filesize := 0;
    in_buff := allocmem(LZ4_compressBound(LEGACY_BLOCKSIZE));
    out_buff := allocmem(LEGACY_BLOCKSIZE);
    try
        if (in_buff = nil) or (out_buff = nil) then
            exit(reportError('Allocation error : not enough memory'));
        while true do
        begin
            sizeCheck := finput.Read(in_buff^, 4);
            if sizeCheck = 0 then
                break;
            blockSize := LZ4IO_readLE32(in_buff);
            if blockSize > LZ4_compressBound(LEGACY_BLOCKSIZE) then
            begin
                finput.Seek(-4, soFromCurrent);
                break;
            end;
            sizeCheck := finput.Read(in_buff^, blockSize);
            if sizeCheck <> blockSize then
                exit(reportError('Error reading input file'));
            decodeSize := LZ4_decompress_safe(in_buff, out_buff, blockSize, LEGACY_BLOCKSIZE);
            if (decodeSize < 0) then
                exit(reportError('Decoding Failed ! Corrupted input detected'));
            inc(filesize, decodeSize);
            sizeCheck := foutput.Write(out_buff^, decodeSize);
            if sizeCheck <> size_t(decodeSize) then
                exit(reportError('Write error : cannot write decoded block into output'));
        end;
    finally
        if in_buff <> nil then
            freemem(in_buff);
        if out_buff <> nil then
            freemem(out_buff);
        result := filesize;
    end;
end;

function selectDecoder(finput, foutput: TSTream): uint64;
var
    nbReadBytes: size_t;
    U32Store: array [0 .. MAGICNUMBER_SIZE - 1] of byte;
    magicNumber, Size: cardinal;
    newPos: uint64;
begin
    nbReadBytes := finput.Read(U32Store, MAGICNUMBER_SIZE);
    if nbReadBytes = 0 then
        exit(ENDOFSTREAM);
    if nbReadBytes <> MAGICNUMBER_SIZE then
        exit(reportError('Unrecognized header : Magic Number unreadable'));
    magicNumber := LZ4IO_readLE32(@U32Store);
    if LZ4S_isSkippableMagicNumber(magicNumber) then
        magicNumber := LZ4S_SKIPPABLE0;

    case magicNumber of
        LZ4S_MAGICNUMBER: result := decodeLZ4S(finput, foutput);
        LEGACY_MAGICNUMBER:
            begin
                result := decodeLegacyStream(finput, foutput);
            end;
        LZ4S_SKIPPABLE0:
            begin
                nbReadBytes := finput.Read(U32Store, 4);
                if (nbReadBytes <> 4) then
                    exit(reportError('Stream error : skippable size unreadable'));
                Size := LZ4IO_readLE32(@U32Store);
                newPos := finput.Seek(Size, soFromCurrent);
                if newPos <> finput.Position then
                    exit(reportError('Stream error : cannot skip skippable area'));
                result := selectDecoder(finput, foutput);
            end;
    else
        begin
            if finput.Position = MAGICNUMBER_SIZE then
                exit(reportError('Unrecognized header : file cannot be decoded'));
            reportError('Stream followed by unrecognized data');
            result := ENDOFSTREAM;
        end;
    end;
end;

function LZ4IO_decompressFilename(input_filename: string; output_filename: string): integer;
var
  fileIn: TFileSTream;
  fileOut: TFileSTream;
  decodedSize: int64;
  filesize: int64;
begin
  result := 0;
  filesize := 0;
  fileIn := TFileSTream.Create(input_filename, fmOpenRead);
  fileOut := TFileSTream.Create(output_filename, fmCreate);
  repeat
      decodedSize := selectDecoder(fileIn, fileOut);
      if decodedSize <> ENDOFSTREAM then
          inc(filesize, decodedSize);
  until decodedSize = ENDOFSTREAM;
  fileIn.Free;;
  fileOut.Free;
end;

type
  TPreallocatedMemoryStream = class(TCustomMemoryStream)
  public
    constructor Create(Ptr: Pointer; Size: Int64);
    function Write(const Buffer; Count: Longint): Longint; override;
  end;

constructor TPreallocatedMemoryStream.Create(Ptr: Pointer; Size: Int64);
begin
  inherited Create;
  SetPointer(Ptr, Size);
end;

function TPreallocatedMemoryStream.Write(const Buffer; Count: Integer): Longint;
begin
  Result := Min(Count, Size-Position);
  System.Move(Buffer, Pointer(PByte(Memory) + Position)^, Result);
  Seek(Result, soCurrent);
end;

procedure lz4DecompressToUserBuf(const InBuf: Pointer; InBytes: Integer;
  const OutBuf: Pointer; BufSize: Integer);
var
  stin, stout: TPreallocatedMemoryStream;
  decodedSize: uint64;
  decompressedSize: uint64;
begin
  stin := TPreallocatedMemoryStream.Create(InBuf, InBytes);
  stout := TPreallocatedMemoryStream.Create(OutBuf, BufSize);
  try
    decompressedSize := 0;
    repeat
      decodedSize := selectDecoder(stin, stout);
      if decodedSize <> ENDOFSTREAM then
        Inc(decompressedSize, decodedSize);
    until decodedSize = ENDOFSTREAM;

    if decompressedSize <> BufSize then
      Exception.Create('lz4 decompression size mismatch');

    //Move(stout.Memory^, OutBuf^, BufSize);
  finally
    stin.Free;
    stout.Free;
  end;
end;

function lz4DeCompressStream(aCompressed, aTarget: TStream): Integer;
var
  decodedSize: uint64;
  decompressedSize: uint64;
begin
  decompressedSize := 0;
  repeat
    decodedSize := selectDecoder(aCompressed, aTarget);
    if decodedSize <> ENDOFSTREAM then
      Inc(decompressedSize, decodedSize);
  until decodedSize = ENDOFSTREAM;
  Result := decompressedSize;
end;


function lz4CompressStream(aSource, aCompressed: TStream; aCompressionLevel: Integer = 8): Integer;
var
  filesize: uint64;
  errorCode: LZ4F_errorCode_t;
  ctx: PLZ4F_compressionContext_t;
  blockSize: integer;
  prefs: LZ4F_preferences_t;
  in_buff: pAnsiChar;
  out_buff: pAnsiChar;
  outBuffSize: size_t;
  headerSize: size_t;
  sizeCheck: size_t;
  readSize: size_t;
  outSize: size_t;
begin
  result := 0;
  filesize := 0;
  errorCode := LZ4F_createCompressionContext(ctx, LZ4F_VERSION);
  if (LZ4F_isError(errorCode)) then
    exit(reportError(format('Allocation error : can''t create LZ4F context: %s', [LZ4F_getErrorName(errorCode)])));
  blockSize := 1 shl (8 + 2 * globalblockSizeID);
  fillchar(prefs, sizeof(LZ4F_preferences_t), 0);

  prefs.autoFlush := 1;
  prefs.compressionLevel := aCompressionLevel;
  prefs.frameInfo.blockMode := blockMode_t(blockIndependence);
  prefs.frameInfo.blockSizeID := blockSizeID_t(globalblockSizeID);
  prefs.frameInfo.contentChecksumFlag := contentChecksum_t(streamChecksum);

  // Allocate Memory
  in_buff := allocmem(blockSize);
  outBuffSize := LZ4F_compressBound(blockSize, @prefs);
  out_buff := allocmem(outBuffSize);
  try
    if (in_buff = nil) or (out_buff = nil) then
      exit(reportError('Allocation error : not enough memory'));
    // Write Archive Header
    headerSize := LZ4F_compressBegin(ctx, out_buff, outBuffSize, @prefs);
    if (LZ4F_isError(headerSize)) then
      exit(reportError(format('File header generation failed: %s', [LZ4F_getErrorName(errorCode)])));
    sizeCheck := aCompressed.Write(out_buff^, headerSize);
    if sizeCheck <> headerSize then
      exit(reportError('Write error : cannot write header'));

    readSize := aSource.Read(in_buff^, blockSize);
    inc(filesize, readSize);
    while readSize > 0 do begin
      outSize := LZ4F_compressUpdate(ctx, out_buff, outBuffSize, in_buff, readSize, Nil);
      if (LZ4F_isError(outSize)) then
        exit(reportError(format('Compression failed: %s', [LZ4F_getErrorName(errorCode)])));
      sizeCheck := aCompressed.Write(out_buff^, outSize);
      if sizeCheck <> outSize then
        exit(reportError('Write error : cannot write compressed block'));
      readSize := aSource.Read(in_buff^, blockSize);
      inc(filesize, readSize);
    end;
    // End of Stream mark
    headerSize := LZ4F_compressEnd(ctx, out_buff, outBuffSize, Nil);
    if LZ4F_isError(headerSize) then
      exit(reportError(format('End of file generation failed: %s', [LZ4F_getErrorName(errorCode)])));
    sizeCheck := aCompressed.Write(out_buff^, headerSize);
    if sizeCheck <> headerSize then
      exit(reportError('Write error : cannot write end of stream'));
    errorCode := LZ4F_freeCompressionContext(ctx);
    if LZ4F_isError(errorCode) then
      exit(reportError(format('Error : can''t free LZ4F context resource: %s', [LZ4F_getErrorName(errorCode)])));
  finally
    if in_buff <> nil then
      freemem(in_buff);
    if out_buff <> nil then
      freemem(out_buff);
  end;
end;


end.
