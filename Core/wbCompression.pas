{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbCompression;

interface

uses
  System.Classes,
  System.SysUtils,
  System.ZLib,

  lz4d.lz4hc;

type
  TwbCompressionType = (ctNone, ctZLib, ctLZ4, ctLZ4F);
  TwbCompressionTypes = array of TwbCompressionType;

  TwbCompression = class abstract
  public
    class function Name(aCType: TwbCompressionType): string; inline;
    class function TypeByName(const aName: string): TwbCompressionType;
    // this method doesn't resize Result to the actual compressed data length
    // to avoid extra reallocation and possible copying of data
    // caller must use returned aDstSize instead of Length(Result) for the actual compressed size
    class function Compress(aType: TwbCompressionType; const aSrc: Pointer; aSrcSize: Integer; out aDstSize: Integer;
      aCompressionLevel: Integer = -1): TBytes; overload;
    class procedure Compress(aType: TwbCompressionType; const aSrc: Pointer; aSrcSize: Integer; const aDst: TStream;
      aCompressionLevel: Integer = -1); overload;
    class procedure Compress(aType: TwbCompressionType; const aSrc, aDst: TStream; aBuffered: Boolean = False;
      aCompressionLevel: Integer = -1); overload;
    class procedure Decompress(aType: TwbCompressionType; const aSrc: Pointer; aSrcSize: Integer; const aDst: Pointer; aDstSize: Integer); overload;
    class procedure Decompress(aType: TwbCompressionType; const aSrc, aDst: TStream); overload;

    const
      // use LibDeflate for compression instead of ZLib if data size <= this value
      // it's roughly up to 5% better compression but gets gradually slower than ZLib on bigger data
      LIBDEFLATE_MAX_DATASIZE: Integer = 8 * 1024 * 1024;

      // default compression levels for aCompressionLevel = -1
      LIBDEFLATE_COMPRESSION_LEVEL = 12; // max in LibDeflate
      ZLIB_COMPRESSION_LEVEL = Z_BEST_COMPRESSION; // 9
      LZ4_COMPRESSION_LEVEL = LZ4HC_CLEVEL_MAX; // 12

      cCompressionTypeName: array [TwbCompressionType] of string = (
        'None', 'ZLib', 'LZ4', 'LZ4F'
      );
  end;


implementation

uses
  libdeflate,

  lz4d,
  lz4d.lz4,
  lz4d.lz4frame;

{ ZLib }

function ZCheck(aCode: Integer; aIgnoreCode: Integer = 0): Integer; overload;
begin
  if aCode = aIgnoreCode then aCode := 0;
  Result := aCode;
  if aCode < 0 then
    raise Exception.Create('ZLib error: ' + string(_z_errmsg[2 - aCode])) at ReturnAddress;
end;

procedure ZLibDecompress(const InBuf: Pointer; InSize: Integer;
  const OutBuf: Pointer; OutSize: Integer);
var
  zstream: TZStreamRec;
begin
  zstream := Default(TZStreamRec);
  zstream.next_in := InBuf;
  zstream.avail_in := InSize;
  zstream.next_out := OutBuf;
  zstream.avail_out := OutSize;
  ZCheck(inflateInit(zstream));
  try
    if ZCheck(inflate(zstream, Z_FINISH), Z_BUF_ERROR) <> Z_STREAM_END then
      ZCheck(Z_DATA_ERROR);
  finally
    ZCheck(inflateEnd(zstream));
  end;
end;

function ZLibCompress(const InBuf: Pointer; InSize: Integer; var OutSize: Integer;
  aCompressionLevel: Integer = TwbCompression.ZLIB_COMPRESSION_LEVEL): TBytes;
var
  DestLen: LongWord;
begin
  DestLen := System.ZLib.compressBound(InSize);
  SetLength(Result, DestLen);
  ZCheck( System.ZLib.compress2(Pointer(Result), DestLen, InBuf, InSize, aCompressionLevel) );
  OutSize := DestLen;
end;


{ LibDeflate }

procedure LibDeflateCheck(aCode: libdeflate_result);
begin
  case aCode of
    LIBDEFLATE_SUCCESS: ;
    LIBDEFLATE_BAD_DATA:
      raise Exception.Create('LibDeflate error: Bad data') at ReturnAddress;
    LIBDEFLATE_SHORT_OUTPUT:
      raise Exception.Create('LibDeflate error: Short output') at ReturnAddress;
    LIBDEFLATE_INSUFFICIENT_SPACE:
      raise Exception.Create('LibDeflate error: Insufficient space') at ReturnAddress;
  end;
end;

procedure LibDeflateDecompress(const InBuf: Pointer; InSize: Integer;
  const OutBuf: Pointer; OutSize: Integer);
var
  VZlib: libdeflate_decompressor;
begin
  VZlib := libdeflate_alloc_decompressor;
  if not Assigned(VZlib) then
    raise Exception.Create('LibDeflate error: Can''t create decompressor');

  try
    LibDeflateCheck( libdeflate_zlib_decompress(VZlib, InBuf, InSize, OutBuf, OutSize) );
  finally
    libdeflate_free_decompressor(VZlib);
  end;
end;

function LibDeflateCompress(const InBuf: Pointer; InSize: Integer; var OutSize: Integer;
  aCompressionLevel: Integer = TwbCompression.LIBDEFLATE_COMPRESSION_LEVEL): TBytes;
var
  VZlib: libdeflate_compressor;
begin
  VZlib := libdeflate_alloc_compressor(aCompressionLevel);
  if not Assigned(VZlib) then
    raise Exception.Create('LibDeflate error: Can''t create compressor');

  try
    SetLength(Result, libdeflate_zlib_compress_bound(VZlib, InSize));
    OutSize := libdeflate_zlib_compress(VZlib, InBuf, InSize, Result, Length(Result));
    if OutSize = 0 then
      raise Exception.Create('LibDeflate error: Compression failed');
  finally
    libdeflate_free_compressor(VZlib);
  end;
end;


{ LZ4 }

procedure LZ4Decompress(const InBuf: Pointer; InSize: Integer;
  const OutBuf: Pointer; OutSize: Integer);
begin
  var DecompressedSize := {$IFDEF WIN64}LZ4_decompress_safe{$ELSE}_LZ4_decompress_safe{$ENDIF}(InBuf, OutBuf, InSize, OutSize);
  if DecompressedSize <> OutSize then
    raise Exception.Create('LZ4 error: Decompression failed');
end;

function LZ4Compress(const InBuf: Pointer; InSize: Integer; var OutSize: Integer;
  aCompressionLevel: Integer = TwbCompression.LZ4_COMPRESSION_LEVEL): TBytes; overload;
begin
  SetLength(Result, {$IFDEF WIN64}LZ4_compressBound{$ELSE}_LZ4_compressBound{$ENDIF}(inSize));
  // crashing bug in LZ4_compress_HC() if InBuf = 0 and InSize = 0, need to point to something allocated
  var p: Pointer; if InSize = 0 then p := Pointer(Result) else p := InBuf;
  OutSize := {$IFDEF WIN64}LZ4_compress_HC{$ELSE}_LZ4_compress_HC{$ENDIF}(p, Result, InSize, Length(Result), aCompressionLevel);
  if OutSize = 0 then
    raise Exception.Create('LZ4 error: Compression failed');
end;


{ LZ4F }

procedure LZ4FCheck(const aMsg: string; aCode: NativeUInt);
begin
  if {$IFDEF WIN64}LZ4F_isError{$ELSE}_LZ4F_isError{$ENDIF}(aCode) <> 0 then
    raise Exception.CreateFmt(aMsg, [{$IFDEF WIN64}LZ4F_getErrorName{$ELSE}_LZ4F_getErrorName{$ENDIF}(aCode)]) at ReturnAddress;
end;

procedure LZ4FDecompress(const InBuf: Pointer; InSize: NativeUInt;
  const OutBuf: Pointer; OutSize: NativeUInt);
var
  ctx: PLZ4F_dctx;
  Options: LZ4F_decompressOptions_t;
  Compressed, Decompressed, CompressedTotal, DecompressedTotal, r: NativeUInt;
begin
  LZ4FCheck('LZ4F decompression context error: %s',
    {$IFDEF WIN64}LZ4F_createDecompressionContext{$ELSE}_LZ4F_createDecompressionContext{$ENDIF}(@ctx, LZ4F_VERSION)
  );
  Options := Default(LZ4F_decompressOptions_t);
  // Pledges that last 64KB decompressed data is present right before @dstBuffer pointer.
  // This optimization skips internal storage operations.
  Options.stableDst := 1;

  CompressedTotal := 0;
  DecompressedTotal := 0;
  try
    repeat
      Compressed := InSize - CompressedTotal;
      Decompressed := OutSize - DecompressedTotal;
      r := {$IFDEF WIN64}LZ4F_decompress{$ELSE}_LZ4F_decompress{$ENDIF}(
        ctx,
        PByte(OutBuf) + DecompressedTotal,
        @Decompressed,
        PByte(InBuf) + CompressedTotal,
        @Compressed,
        @Options
      );
      LZ4FCheck('LZ4F decompression error: %s', r);
      Inc(CompressedTotal, Compressed);
      Inc(DecompressedTotal, Decompressed);
    until r = 0;
  finally
    {$IFDEF WIN64}LZ4F_freeDecompressionContext{$ELSE}_LZ4F_freeDecompressionContext{$ENDIF}(ctx);
  end;
  if (InSize <> CompressedTotal) or (OutSize <> DecompressedTotal) then
    raise Exception.Create('LZ4F decompression error: processed bytes don''t match');
end;

function LZ4FCompress(const InBuf: Pointer; InSize: NativeUInt; var OutSize: Integer;
  aCompressionLevel: Integer = TwbCompression.LZ4_COMPRESSION_LEVEL): TBytes; overload;
var
  prefs: LZ4F_preferences_t;
begin
  prefs := Default(LZ4F_preferences_t);
  prefs.compressionLevel := aCompressionLevel;
  prefs.autoFlush := 1;
  prefs.frameInfo.blockMode := LZ4F_blockIndependent;
  prefs.frameInfo.blockSizeID := LZ4F_max4MB;

  SetLength(Result, {$IFDEF WIN64}LZ4F_compressFrameBound{$ELSE}_LZ4F_compressFrameBound{$ENDIF}(InSize, @prefs));
  OutSize := {$IFDEF WIN64}LZ4F_compressFrame{$ELSE}_LZ4F_compressFrame{$ENDIF}(Result, Length(Result), InBuf, InSize, @prefs);
  LZ4FCheck('LZ4F compression error: %s', OutSize);
end;

procedure LZ4FCompressStream(const aSource, aCompressed: TStream;
  aCompressionLevel: Integer = TwbCompression.LZ4_COMPRESSION_LEVEL);
var
  ctx: PLZ4F_cctx;
  blockSize: Integer;
  prefs: LZ4F_preferences_t;
  in_buff, out_buff: TBytes;
  outBuffSize, headerSize, readSize, outSize: NativeUInt;
begin
  ctx := nil;
  headerSize := {$IFDEF WIN64}LZ4F_createCompressionContext{$ELSE}_LZ4F_createCompressionContext{$ENDIF}(@ctx, LZ4F_VERSION);
  LZ4FCheck('LZ4F compression context error: %s', headerSize);

  prefs := Default(LZ4F_preferences_t);
  prefs.autoFlush := 1;
  prefs.compressionLevel := aCompressionLevel;
  prefs.frameInfo.blockMode := LZ4F_blockIndependent;
  prefs.frameInfo.blockSizeID := LZ4F_max4MB;
  //prefs.frameInfo.contentChecksumFlag := LZ4F_contentChecksumEnabled;

  blockSize := 1 shl (8 + 2 * Integer(LZ4F_max4MB));
  SetLength(in_buff, blockSize);
  outBuffSize := {$IFDEF WIN64}LZ4F_compressBound{$ELSE}_LZ4F_compressBound{$ENDIF}(blockSize, @prefs);
  SetLength(out_buff, outBuffSize);
  try
    // Write Archive Header
    headerSize := {$IFDEF WIN64}LZ4F_compressBegin{$ELSE}_LZ4F_compressBegin{$ENDIF}(ctx, out_buff, outBuffSize, @prefs);
    LZ4FCheck('LZ4F file header generation failed: %s', headerSize);
    aCompressed.WriteBuffer(out_buff, headerSize);
    readSize := aSource.Read(in_buff, blockSize);
    while readSize > 0 do begin
      outSize := {$IFDEF WIN64}LZ4F_compressUpdate{$ELSE}_LZ4F_compressUpdate{$ENDIF}(ctx, out_buff, outBuffSize, in_buff, readSize, nil);
      LZ4FCheck('LZ4F compression error: %s', outSize);
      aCompressed.WriteBuffer(out_buff, outSize);
      readSize := aSource.Read(in_buff, blockSize);
    end;
    // End of Stream mark
    headerSize := {$IFDEF WIN64}LZ4F_compressEnd{$ELSE}_LZ4F_compressEnd{$ENDIF}(ctx, out_buff, outBuffSize, nil);
    LZ4FCheck('LZ4F end of file generation failed: %s', headerSize);
    aCompressed.WriteBuffer(out_buff, headerSize);
  finally
    if ctx <> nil then
      {$IFDEF WIN64}LZ4F_freeCompressionContext{$ELSE}_LZ4F_freeCompressionContext{$ENDIF}(ctx);
  end;
end;


{ TwbCompression }

class function TwbCompression.Name(aCType: TwbCompressionType): string;
begin
  Result := cCompressionTypeName[aCType];
end;

class function TwbCompression.TypeByName(const aName: string): TwbCompressionType;
begin
  for Result := High(TwbCompressionType) downto Low(TwbCompressionType) do
    if SameText(aName, Name(Result)) then Break;
end;

class procedure TwbCompression.Decompress(aType: TwbCompressionType; const aSrc: Pointer; aSrcSize: Integer;
  const aDst: Pointer; aDstSize: Integer);
begin
  case aType of
    ctZLib: LibDeflateDecompress(aSrc, aSrcSize, aDst, aDstSize);
    ctLZ4:  LZ4Decompress(aSrc, aSrcSize, aDst, aDstSize);
    ctLZ4F: LZ4FDecompress(aSrc, aSrcSize, aDst, aDstSize);
    {ctNone: begin
      Assert(aSrcSize = aDstSize);
      System.Move(aSrc^, aDst^, aSrcSize);
    end;}
  else
    raise Exception.Create('Undefined decompression type');
  end;
end;

class procedure TwbCompression.Decompress(aType: TwbCompressionType; const aSrc, aDst: TStream);
begin
  case aType of
    ctLZ4F: TLZ4.Stream_Decode(aSrc, aDst);
  else
    raise Exception.Create('Not implemented');
  end;
end;

class function TwbCompression.Compress(aType: TwbCompressionType; const aSrc: Pointer; aSrcSize: Integer; out aDstSize: Integer;
  aCompressionLevel: Integer = -1): TBytes;
begin
  case aType of
    ctZLib: begin
      if aSrcSize <= LIBDEFLATE_MAX_DATASIZE then begin
        if aCompressionLevel = -1 then aCompressionLevel := LIBDEFLATE_COMPRESSION_LEVEL;
        Result := LibDeflateCompress(aSrc, aSrcSize, aDstSize, aCompressionLevel);
      end
      else begin
        if aCompressionLevel = -1 then aCompressionLevel := ZLIB_COMPRESSION_LEVEL;
        Result := ZLibCompress(aSrc, aSrcSize, aDstSize, aCompressionLevel);
      end;
    end;
    ctLZ4: begin
      if aCompressionLevel = -1 then aCompressionLevel := LZ4_COMPRESSION_LEVEL;
      Result := LZ4Compress(aSrc, aSrcSize, aDstSize, aCompressionLevel);
    end;
    ctLZ4F: begin
      if aCompressionLevel = -1 then aCompressionLevel := LZ4_COMPRESSION_LEVEL;
      Result := LZ4FCompress(aSrc, aSrcSize, aDstSize, aCompressionLevel);
    end;
  else
    raise Exception.Create('Undefined compression type');
  end;
end;

class procedure TwbCompression.Compress(aType: TwbCompressionType; const aSrc: Pointer; aSrcSize: Integer; const aDst: TStream;
  aCompressionLevel: Integer = -1);
var
  DstBuf: TBytes;
  DstSize: Integer;
begin
  DstBuf := Compress(aType, aSrc, aSrcSize, DstSize, aCompressionLevel);
  aDst.WriteBuffer(DstBuf, DstSize);
end;

class procedure TwbCompression.Compress(aType: TwbCompressionType; const aSrc, aDst: TStream; aBuffered: Boolean = False;
  aCompressionLevel: Integer = -1);
var
  SrcBuf: TBytes;
  Src: Pointer;
  SrcSize: Integer;
begin
  // direct stream to stream buffered compression without loading entire data into memory
  // todo: not implemented for LZ4
  if aBuffered and not (aType in [ctNone, ctLZ4]) then begin
    case aType of
      ctZLib: begin
        if aCompressionLevel = -1 then aCompressionLevel := ZLIB_COMPRESSION_LEVEL;
        System.ZLib.ZCompressStream(aSrc, aDst, TZCompressionLevel(aCompressionLevel));
      end;
      ctLZ4F: begin
        if aCompressionLevel = -1 then aCompressionLevel := LZ4_COMPRESSION_LEVEL;
        LZ4FCompressStream(aSrc, aDst, aCompressionLevel);
      end;
    end;
    Exit;
  end;

  // no buffering with full loading into memory
  SrcSize := aSrc.Size;
  // memory stream is already loaded
  if aSrc is TCustomMemoryStream then
    Src := TCustomMemoryStream(aSrc).Memory
  else begin
    SetLength(SrcBuf, SrcSize);
    aSrc.Read(SrcBuf, SrcSize);
    Src := SrcBuf;
  end;
  Compress(aType, Src, SrcSize, aDst, aCompressionLevel);
end;


end.
