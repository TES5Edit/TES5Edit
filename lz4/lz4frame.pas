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
unit lz4frame;
{$POINTERMATH ON}
{$Q-}
{$R-}

interface

uses Windows, xxHash, lz4frame_static, lz4, lz4HC, lz4common;

const
    LZ4F_VERSION = 100;
    LZ4F_MAGICNUMBER = $184D2204;
    _1BIT = $01;
    _2BITS = $03;
    _3BITS = $07;
    _4BITS = $0F;
    _8BITS = $FF;
    LZ4F_BLOCKUNCOMPRESSED_FLAG: cardinal = $80000000;

type
    LZ4F_errorCode_t = size_t;
    PLZ4F_decompressionContext_t = pointer;
    PLZ4F_compressionContext_t = pointer;
    blockSizeID_t = (LZ4F_default = 0, max64KB = 4, max256KB = 5, max1MB = 6, max4MB = 7);
    blockMode_t = (blockLinked = 0, blockIndependent);
    contentChecksum_t = (noContentChecksum = 0, contentChecksumEnabled);
    LZ4F_lastBlockStatus = (notDone, fromTmpBuffer, fromSrcBuffer);

    PLZ4F_frameInfo_t = ^LZ4F_frameInfo_t;

    LZ4F_frameInfo_t = record
        blockSizeID: blockSizeID_t;
        blockMode: blockMode_t;
        contentChecksumFlag: contentChecksum_t;
        reserved: array [0 .. 4] of cardinal;
    end;

    PLZ4F_preferences_t = ^LZ4F_preferences_t;

    LZ4F_preferences_t = record
        frameInfo: LZ4F_frameInfo_t;
        compressionLevel: cardinal;
        autoFlush: cardinal;
        reserved: array [0 .. 3] of cardinal;
    end;

    PLZ4F_compressOptions_t = ^LZ4F_compressOptions_t;

    LZ4F_compressOptions_t = record
        stableSrc: cardinal;
        reserved: array [0 .. 2] of cardinal;
    end;

    PLZ4F_cctx_internal_t = ^LZ4F_cctx_internal_t;

    LZ4F_cctx_internal_t = record
        prefs: LZ4F_preferences_t;
        version: cardinal;
        cStage: cardinal;
        maxBlockSize: size_t;
        maxBufferSize: size_t;
        tmpBuff: pByte;
        tmpIn: pByte;
        tmpInSize: size_t;
        xxh: XXH32_state_t;
        lz4CtxPtr: pointer;
        lz4CtxLevel: cardinal;
    end;

    PLZ4F_dctx_internal_t = ^LZ4F_dctx_internal_t;

    LZ4F_dctx_internal_t = record
        frameInfo: LZ4F_frameInfo_t;
        version: cardinal;
        dStage: cardinal;
        maxBlockSize: size_t;
        maxBufferSize: size_t;
        srcExpect: pByte;
        tmpIn: pByte;
        tmpInSize: size_t;
        tmpInTarget: size_t;
        tmpOutBuffer: pByte;
        dict: pByte;
        dictSize: size_t;
        tmpOut: pByte;
        tmpOutSize: size_t;
        tmpOutStart: size_t;
        xxh: XXH32_state_t;
        header: array [0 .. 7] of byte;
    end;

    PLZ4F_decompressOptions_t = ^LZ4F_decompressOptions_t;

    LZ4F_decompressOptions_t = record
        stableDst: cardinal;
        reserved: array [0 .. 2] of cardinal;
    end;

const
    LZ4F_BLOCKSIZEID_DEFAULT = max64KB;
    LZ4F_MAXHEADERFRAME_SIZE = 7;

function LZ4F_createDecompressionContext(var LZ4F_decompressionContextPtr: PLZ4F_compressionContext_t; versionNumber: cardinal)
  : LZ4F_errorCode_t;
function LZ4F_isError(code: LZ4F_errorCode_t): boolean;
function LZ4F_compressFrame(dstBuffer: pointer; dstMaxSize: size_t; const srcBuffer: pointer; srcSize: size_t;
  const preferencesPtr: PLZ4F_preferences_t): size_t;
function LZ4F_compressBound(srcSize: size_t; const preferencesPtr: PLZ4F_preferences_t): size_t;
function LZ4F_compressFrameBound(srcSize: size_t; const preferencesPtr: PLZ4F_preferences_t): size_t;
function LZ4F_compressBegin(compressionContext: PLZ4F_compressionContext_t; dstBuffer: pointer; dstMaxSize: size_t;
  preferencesPtr: PLZ4F_preferences_t): size_t;
function LZ4F_compressUpdate(compressionContext: PLZ4F_compressionContext_t; dstBuffer: pointer; dstMaxSize: size_t;
  const srcBuffer: pointer; srcSize: size_t; compressOptionsPtr: PLZ4F_compressOptions_t): size_t;
function LZ4F_compressEnd(compressionContext: PLZ4F_compressionContext_t; dstBuffer: pointer; dstMaxSize: size_t;
  const compressOptionsPtr: PLZ4F_compressOptions_t): size_t;
function LZ4F_flush(compressionContext: PLZ4F_compressionContext_t; dstBuffer: pointer; dstMaxSize: size_t;
  compressOptionsPtr: PLZ4F_compressOptions_t): size_t;
function LZ4F_decompress(decompressionContext: PLZ4F_decompressionContext_t;
  dstBuffer: pointer; dstSizePtr: psize_t; const srcBuffer: pointer; srcSizePtr: psize_t;
  decompressOptionsPtr: PLZ4F_decompressOptions_t): size_t;
function LZ4F_createCompressionContext(var LZ4F_compressionContextPtr: PLZ4F_compressionContext_t; version: cardinal): LZ4F_errorCode_t;
function LZ4F_freeCompressionContext(LZ4F_compressionContext: PLZ4F_compressionContext_t): LZ4F_errorCode_t;
function LZ4F_getFrameInfo(decompressionContext: PLZ4F_decompressionContext_t; frameInfoPtr: PLZ4F_frameInfo_t; const srcBuffer: pointer;
  srcSizePtr: psize_t): LZ4F_errorCode_t;
function LZ4F_freeDecompressionContext(LZ4F_decompressionContext: PLZ4F_decompressionContext_t): LZ4F_errorCode_t;
function LZ4F_getErrorName(code : LZ4F_errorCode_t ): pAnsiChar;

implementation

var
    minHClevel: cardinal = 3;

type
    dStage_t = (dstage_getHeader = 0, dstage_storeHeader, dstage_decodeHeader,
      dstage_getCBlockSize, dstage_storeCBlockSize, dstage_decodeCBlockSize,
      dstage_copyDirect,
      dstage_getCBlock, dstage_storeCBlock, dstage_decodeCBlock,
      dstage_decodeCBlock_intoDst, dstage_decodeCBlock_intoTmp, dstage_flushOut,
      dstage_getSuffix, dstage_storeSuffix, dstage_checkSuffix);

function LZ4F_getBlockSize(blockSizeID: cardinal): size_t; forward;

function LZ4F_createDecompressionContext(var LZ4F_decompressionContextPtr: PLZ4F_compressionContext_t; versionNumber: cardinal)
  : LZ4F_errorCode_t;
var
    dctxPtr: PLZ4F_dctx_internal_t;
begin
    dctxPtr := allocmem(sizeof(LZ4F_dctx_internal_t));
    if dctxPtr = nil then
        exit(LZ4F_errorCode_t(-integer(ERROR_GENERIC)));
    dctxPtr.version := versionNumber;
    LZ4F_decompressionContextPtr := dctxPtr;
    result := LZ4F_errorCode_t(OK_NoError);
end;

function LZ4F_isError(code: LZ4F_errorCode_t): boolean;
begin
    result := code > LZ4F_errorCode_t(-integer(ERROR_maxCode));
end;

function LZ4F_getErrorName(code : LZ4F_errorCode_t ): pAnsiChar;
begin
      result:=  'Unspecified error code';
      if LZ4F_isError(code) then exit (pAnsiChar(LZ4F_errorStrings[-integer(code)]));
end;

function LZ4F_compressFrameBound(srcSize: size_t; const preferencesPtr: PLZ4F_preferences_t): size_t;
var
    prefs: LZ4F_preferences_t;
    headerSize: size_t;
    streamSize: size_t;
    proposedBSID: blockSizeID_t;
    maxBlockSize: size_t;
begin
    fillchar(prefs, sizeof(LZ4F_preferences_t), 0);
    if (preferencesPtr <> Nil) then
        prefs := preferencesPtr^;
    proposedBSID := max64KB;
    maxBlockSize := 65536;
    while (prefs.frameInfo.blockSizeID > proposedBSID) do
    begin
        if srcSize <= maxBlockSize then
        begin
            prefs.frameInfo.blockSizeID := proposedBSID;
            break;
        end;
        inc(proposedBSID);
        maxBlockSize := maxBlockSize shl 2;
    end;
    prefs.autoFlush := 1;
    headerSize := 7; // basic header size (no option) including magic number
    streamSize := LZ4F_compressBound(srcSize, @prefs);
    result := headerSize + streamSize;
end;

function LZ4F_compressFrame(dstBuffer: pointer; dstMaxSize: size_t; const srcBuffer: pointer; srcSize: size_t;
  const preferencesPtr: PLZ4F_preferences_t): size_t;
var
    cctxI: LZ4F_cctx_internal_t;
    prefs: LZ4F_preferences_t;
    options: LZ4F_compressOptions_t;
    errorCode: LZ4F_errorCode_t;
    dstStart: pByte;
    dstPtr: pByte;
    dstEnd: pByte;
    proposedBSID: blockSizeID_t;
    maxBlockSize: size_t;
begin
    fillchar(cctxI, sizeof(LZ4F_cctx_internal_t), 0);
    fillchar(prefs, sizeof(LZ4F_preferences_t), 0);
    fillchar(options, sizeof(LZ4F_compressOptions_t), 0);
    dstStart := pByte(dstBuffer);
    dstPtr := dstStart;
    dstEnd := dstStart + dstMaxSize;
    cctxI.version := LZ4F_VERSION;
    cctxI.maxBufferSize := 5 * 1048576;
    if (preferencesPtr <> Nil) then
        prefs := preferencesPtr^;
    proposedBSID := max64KB;
    maxBlockSize := 65536;
    while (prefs.frameInfo.blockSizeID > proposedBSID) do
    begin
        if (srcSize <= maxBlockSize) then
        begin
            prefs.frameInfo.blockSizeID := proposedBSID;
            break;
        end;
        inc(proposedBSID);
        maxBlockSize := maxBlockSize shl 2;
    end;
    prefs.autoFlush := 1;
    if (srcSize <= LZ4F_getBlockSize(cardinal(prefs.frameInfo.blockSizeID))) then
        prefs.frameInfo.blockMode := blockIndependent; // no need for linked blocks

    options.stableSrc := 1;

    if (dstMaxSize < LZ4F_compressFrameBound(srcSize, @prefs)) then
        exit(size_t(-integer(ERROR_dstMaxSize_tooSmall)));

    errorCode := LZ4F_compressBegin(@cctxI, dstBuffer, dstMaxSize, @prefs); // write header
    if (LZ4F_isError(errorCode)) then
        exit(errorCode);
    inc(dstPtr, errorCode); // header size

    dec(dstMaxSize, errorCode);
    errorCode := LZ4F_compressUpdate(@cctxI, dstPtr, dstMaxSize, srcBuffer, srcSize, @options);
    if (LZ4F_isError(errorCode)) then
        exit(errorCode);
    inc(dstPtr, errorCode);
    errorCode := LZ4F_compressEnd(@cctxI, dstPtr, dstEnd - dstPtr, @options); // flush last block, and generate suffix
    if LZ4F_isError(errorCode) then
        exit(errorCode);
    inc(dstPtr, errorCode);

    freemem(cctxI.lz4CtxPtr);

    result := dstPtr - dstStart;
end;

function LZ4F_getBlockSize(blockSizeID: cardinal): size_t;
const
    blockSizes: array [0 .. 3] of size_t = (65536, 4 * 65536, 16 * 65536, 64 * 65536);
begin
    if (blockSizeID = 0) then
        blockSizeID := cardinal(LZ4F_BLOCKSIZEID_DEFAULT);
    dec(blockSizeID, 4);
    if (blockSizeID > 3) then
        exit(size_t(-integer(ERROR_maxBlockSize_invalid)));
    result := blockSizes[blockSizeID];
end;

function LZ4F_compressBound(srcSize: size_t; const preferencesPtr: PLZ4F_preferences_t): size_t;
var
    prefsNull: LZ4F_preferences_t;
    prefsPtr: PLZ4F_preferences_t;
    bid: blockSizeID_t;
    blockSize: size_t;
    nbBlocks: cardinal;
    lastBlockSize: size_t;
    blockInfo: size_t;
    frameEnd: size_t;
begin
    fillchar(prefsNull, sizeof(LZ4F_preferences_t), 0);
    if preferencesPtr = Nil then
        prefsPtr := @prefsNull
    else
        prefsPtr := preferencesPtr;
    bid := prefsPtr.frameInfo.blockSizeID;
    blockSize := LZ4F_getBlockSize(cardinal(bid));
    nbBlocks := cardinal(srcSize div blockSize) + 1;
    if prefsPtr.autoFlush <> 0 then
        lastBlockSize := srcSize mod blockSize
    else
        lastBlockSize := blockSize;
    blockInfo := 4; // default, without block CRC option
    frameEnd := 4 + (cardinal(prefsPtr.frameInfo.contentChecksumFlag) * 4);
    result := (blockInfo * nbBlocks) + (blockSize * (nbBlocks - 1)) + lastBlockSize + frameEnd;
end;

procedure LZ4F_writeLE32(dstPtr: pByte; value32: cardinal);
begin
    dstPtr[0] := byte(value32);
    dstPtr[1] := byte(value32 shr 8);
    dstPtr[2] := byte(value32 shr 16);
    dstPtr[3] := byte(value32 shr 24);
end;

function LZ4F_headerChecksum(const header: pByte; length: size_t): byte;
var
    xxh: cardinal;
begin
    xxh := XXH32(header, cardinal(length), 0);
    result := byte(xxh shr 8);
end;

function LZ4F_compressBegin(compressionContext: PLZ4F_compressionContext_t; dstBuffer: pointer; dstMaxSize: size_t;
  preferencesPtr: PLZ4F_preferences_t): size_t;
var
    prefNull: LZ4F_preferences_t;
    cctxPtr: PLZ4F_cctx_internal_t;
    dstStart: pByte;
    dstPtr: pByte;
    headerStart: pByte;
    requiredBuffSize: size_t;
    targetCtxLevel: cardinal;
begin
    fillchar(prefNull, sizeof(LZ4F_preferences_t), 0);
    cctxPtr := PLZ4F_cctx_internal_t(compressionContext);
    dstStart := pByte(dstBuffer);
    dstPtr := dstStart;
    if (dstMaxSize < LZ4F_MAXHEADERFRAME_SIZE) then
        exit(size_t(-integer(ERROR_dstMaxSize_tooSmall)));
    if (cctxPtr.cStage <> 0) then
        exit(size_t(-integer(ERROR_GENERIC)));
    if (preferencesPtr = Nil) then
        preferencesPtr := @prefNull;
    cctxPtr.prefs := preferencesPtr^;
    // ctx Management
    if cctxPtr.prefs.compressionLevel < minHClevel then
        targetCtxLevel := 1
    else
        targetCtxLevel := 2;
    if cctxPtr.lz4CtxLevel < targetCtxLevel then
    begin
        freemem(cctxPtr.lz4CtxPtr);
        if (cctxPtr.prefs.compressionLevel < minHClevel) then
            cctxPtr.lz4CtxPtr := LZ4_createStream()
        else
            cctxPtr.lz4CtxPtr := LZ4_createStreamHC();
        cctxPtr.lz4CtxLevel := targetCtxLevel;
    end;
    // Buffer Management
    if cardinal(cctxPtr.prefs.frameInfo.blockSizeID) = 0 then
        cctxPtr.prefs.frameInfo.blockSizeID := LZ4F_BLOCKSIZEID_DEFAULT;
    cctxPtr.maxBlockSize := LZ4F_getBlockSize(cardinal(cctxPtr.prefs.frameInfo.blockSizeID));

    requiredBuffSize := cctxPtr.maxBlockSize + (cardinal(cctxPtr.prefs.frameInfo.blockMode = blockLinked) * 131072);
    if preferencesPtr.autoFlush <> 0 then
        requiredBuffSize := cardinal(cctxPtr.prefs.frameInfo.blockMode = blockLinked) * 65536; // just needs dict

    if (cctxPtr.maxBufferSize < requiredBuffSize) then
    begin
        cctxPtr.maxBufferSize := requiredBuffSize;
        freemem(cctxPtr.tmpBuff);
        cctxPtr.tmpBuff := allocmem(requiredBuffSize);
        if (cctxPtr.tmpBuff = Nil) then
            exit(size_t(-integer(ERROR_allocation_failed)));
    end;
    cctxPtr.tmpIn := cctxPtr.tmpBuff;
    cctxPtr.tmpInSize := 0;
    XXH32_reset(@cctxPtr.xxh, 0);
    if cctxPtr.prefs.compressionLevel < minHClevel then
        LZ4_resetStream(PLZ4_stream_t(cctxPtr.lz4CtxPtr))
    else
        LZ4_resetStreamHC(cctxPtr.lz4CtxPtr, cctxPtr.prefs.compressionLevel);

    // Magic Number
    LZ4F_writeLE32(dstPtr, LZ4F_MAGICNUMBER);
    inc(dstPtr, 4);
    headerStart := dstPtr;
    // FLG Byte
    dstPtr^ := ((1 and _2BITS) shl 6) // Version('01')
      + ((cardinal(cctxPtr.prefs.frameInfo.blockMode) and _1BIT) shl 5) // Block mode
      + byte((cardinal(cctxPtr.prefs.frameInfo.contentChecksumFlag) and _1BIT) shl 2); // Stream checksum

    inc(dstPtr);

    // BD Byte
    dstPtr^ := byte((cardinal(cctxPtr.prefs.frameInfo.blockSizeID) and _3BITS) shl 4);
    inc(dstPtr);

    // *CRC Byte
    dstPtr^ := LZ4F_headerChecksum(headerStart, 2);
    inc(dstPtr);
    cctxPtr.cStage := 1; // header written, wait for data block
    result := dstPtr - dstStart;
end;

type
    compressFunc_t = function(ctx: pointer; const src: pAnsiChar; dst: pAnsiChar; srcSize: integer; dstSize: integer;
      level: integer): integer;

function LZ4F_localLZ4_compress_limitedOutput_withState(ctx: pointer; const src: pAnsiChar; dst: pAnsiChar; srcSize: integer;
  dstSize: integer; level: integer): integer;
begin
    result := LZ4_compress_limitedOutput_withState(ctx, src, dst, srcSize, dstSize);
end;

function LZ4F_localLZ4_compress_limitedOutput_continue(ctx: pointer; const src: pAnsiChar; dst: pAnsiChar; srcSize: integer;
  dstSize: integer; level: integer): integer;
begin
    result := LZ4_compress_limitedOutput_continue(PLZ4_stream_t(ctx), src, dst, srcSize, dstSize);
end;

function LZ4F_localLZ4_compressHC_limitedOutput_continue(ctx: pointer; const src: pAnsiChar; dst: pAnsiChar; srcSize: integer;
  dstSize: integer; level: integer): integer;
begin
    result := LZ4_compressHC_limitedOutput_continue(PLZ4_streamHC_t(ctx), src, dst, srcSize, dstSize);
end;

function LZ4F_localSaveDict(cctxPtr: PLZ4F_cctx_internal_t): integer;
begin
    if cctxPtr.prefs.compressionLevel < minHClevel then
        result := LZ4_saveDict(PLZ4_stream_t(cctxPtr.lz4CtxPtr), pAnsiChar(cctxPtr.tmpBuff), 65536)
    else
        result := LZ4_saveDictHC(PLZ4_streamHC_t(cctxPtr.lz4CtxPtr), pAnsiChar(cctxPtr.tmpBuff), 65536);
end;

function LZ4F_selectCompression(blockMode: blockMode_t; level: cardinal): compressFunc_t;
begin
    if level < minHClevel then
    begin
        if (blockMode = blockIndependent) then
            exit(@LZ4F_localLZ4_compress_limitedOutput_withState);
        exit(@LZ4F_localLZ4_compress_limitedOutput_continue);
    end;
    if (blockMode = blockIndependent) then
        exit(@LZ4_compressHC2_limitedOutput_withStateHC);
    exit(@LZ4F_localLZ4_compressHC_limitedOutput_continue);
end;

function LZ4F_compressBlock(dst: pointer; const src: pointer; srcSize: size_t; compress: compressFunc_t; lz4ctx: pointer;
  level: integer): integer;
var
    cSizePtr: pByte;
    cSize: cardinal;
begin
    cSizePtr := dst;
    cSize := cardinal(compress(lz4ctx, src, pAnsiChar(cSizePtr + 4), integer(srcSize), integer(srcSize - 1), level));
    LZ4F_writeLE32(cSizePtr, cSize);
    if (cSize = 0) then // compression failed
    begin
        cSize := srcSize;
        LZ4F_writeLE32(cSizePtr, cSize + LZ4F_BLOCKUNCOMPRESSED_FLAG);
        move(src^, (cSizePtr + 4)^, srcSize);
    end;
    result := cSize + 4;
end;

function LZ4F_compressUpdate(compressionContext: PLZ4F_compressionContext_t; dstBuffer: pointer; dstMaxSize: size_t;
  const srcBuffer: pointer; srcSize: size_t; compressOptionsPtr: PLZ4F_compressOptions_t): size_t;
var
    cOptionsNull: LZ4F_compressOptions_t;
    cctxPtr: PLZ4F_cctx_internal_t;
    blockSize: size_t;
    srcPtr: pByte;
    srcEnd: pByte;
    dstStart: pByte;
    dstPtr: pByte;
    lastBlockCompressed: LZ4F_lastBlockStatus;
    compress: compressFunc_t;
    sizeToCopy: size_t;
    realDictSize: integer;
begin
    fillchar(cOptionsNull, sizeof(LZ4F_compressOptions_t), 0);
    cctxPtr := PLZ4F_cctx_internal_t(compressionContext);
    blockSize := cctxPtr.maxBlockSize;
    srcPtr := srcBuffer;
    srcEnd := srcPtr + srcSize;
    dstStart := dstBuffer;
    dstPtr := dstStart;
    lastBlockCompressed := notDone;
    if cctxPtr.cStage <> 1 then
        exit(size_t(-integer(ERROR_GENERIC)));
    if dstMaxSize < LZ4F_compressBound(srcSize, @(cctxPtr.prefs)) then
        exit(size_t(-integer(ERROR_dstMaxSize_tooSmall)));
    if compressOptionsPtr = Nil then
        compressOptionsPtr := @cOptionsNull;
    // select compression function
    compress := LZ4F_selectCompression(cctxPtr.prefs.frameInfo.blockMode, cctxPtr.prefs.compressionLevel);
    // complete tmp buffer
    if cctxPtr.tmpInSize > 0 then // some data already within tmp buffer
    begin
        sizeToCopy := blockSize - cctxPtr.tmpInSize;
        if sizeToCopy > srcSize then
        begin
            // add src to tmpIn buffer
            move(srcBuffer^, (cctxPtr.tmpIn + cctxPtr.tmpInSize)^, srcSize);
            srcPtr := srcEnd;
            inc(cctxPtr.tmpInSize, srcSize);
            // still needs some CRC
        end
        else
        begin
            // complete tmpIn block and then compress it
            lastBlockCompressed := fromTmpBuffer;
            move(srcBuffer^, (cctxPtr.tmpIn + cctxPtr.tmpInSize)^, sizeToCopy);
            inc(srcPtr, sizeToCopy);
            inc(dstPtr, LZ4F_compressBlock(dstPtr, cctxPtr.tmpIn, blockSize, compress, cctxPtr.lz4CtxPtr, cctxPtr.prefs.compressionLevel));

            if (cctxPtr.prefs.frameInfo.blockMode = blockLinked) then
                inc(cctxPtr.tmpIn, blockSize);
            cctxPtr.tmpInSize := 0;
        end;
    end;
    while size_t(srcEnd - srcPtr) >= blockSize do
    begin
        // compress full block
        lastBlockCompressed := fromSrcBuffer;
        inc(dstPtr, LZ4F_compressBlock(dstPtr, srcPtr, blockSize, compress, cctxPtr.lz4CtxPtr, cctxPtr.prefs.compressionLevel));
        inc(srcPtr, blockSize);
    end;
    if ((cctxPtr.prefs.autoFlush <> 0) and (srcPtr < srcEnd)) then
    begin
        // compress remaining input < blockSize
        lastBlockCompressed := fromSrcBuffer;
        inc(dstPtr, LZ4F_compressBlock(dstPtr, srcPtr, srcEnd - srcPtr, compress, cctxPtr.lz4CtxPtr, cctxPtr.prefs.compressionLevel));
        srcPtr := srcEnd;
    end;

    // preserve dictionary if necessary
    if ((cctxPtr.prefs.frameInfo.blockMode = blockLinked) and (lastBlockCompressed = fromSrcBuffer)) then
    begin
        if compressOptionsPtr.stableSrc <> 0 then
            cctxPtr.tmpIn := cctxPtr.tmpBuff
        else
        begin
            realDictSize := LZ4F_localSaveDict(cctxPtr);
            if (realDictSize = 0) then
                exit(size_t(-integer(ERROR_GENERIC)));
            cctxPtr.tmpIn := cctxPtr.tmpBuff + realDictSize;
        end;
    end;
    // keep tmpIn within limits
    if ((cctxPtr.tmpIn + blockSize) > (cctxPtr.tmpBuff + cctxPtr.maxBufferSize))
    // necessarily blockLinked && lastBlockCompressed==fromTmpBuffer
      and (cctxPtr.prefs.autoFlush = 0) then
    begin
        LZ4F_localSaveDict(cctxPtr);
        cctxPtr.tmpIn := cctxPtr.tmpBuff + 65536;
    end;
    // some input data left, necessarily < blockSize
    if srcPtr < srcEnd then
    begin
        // fill tmp buffer
        sizeToCopy := srcEnd - srcPtr;
        move(srcPtr^, (cctxPtr.tmpIn)^, sizeToCopy);
        cctxPtr.tmpInSize := sizeToCopy;
    end;
    if (cctxPtr.prefs.frameInfo.contentChecksumFlag = contentChecksumEnabled) then
        XXH32_update(@(cctxPtr.xxh), srcBuffer, cardinal(srcSize));
    result := dstPtr - dstStart;
end;

function LZ4F_flush(compressionContext: PLZ4F_compressionContext_t; dstBuffer: pointer; dstMaxSize: size_t;
  compressOptionsPtr: PLZ4F_compressOptions_t): size_t;
var
    cOptionsNull: LZ4F_compressOptions_t;
    cctxPtr: PLZ4F_cctx_internal_t;
    dstStart: pByte;
    dstPtr: pByte;
    compress: compressFunc_t;
begin
    fillchar(cOptionsNull, sizeof(LZ4F_compressOptions_t), 0);
    cctxPtr := PLZ4F_cctx_internal_t(compressionContext);
    dstStart := pByte(dstBuffer);
    dstPtr := dstStart;
    if cctxPtr.tmpInSize = 0 then
        exit(0); // nothing to flush
    if cctxPtr.cStage <> 1 then
        exit(size_t(-integer(ERROR_GENERIC)));
    if (dstMaxSize < (cctxPtr.tmpInSize + 16)) then
        exit(size_t(-integer(ERROR_dstMaxSize_tooSmall)));
        (* Not used
    if (compressOptionsPtr = Nil) then
        compressOptionsPtr := @cOptionsNull;
        *)
    // select compression function
    compress := LZ4F_selectCompression(cctxPtr.prefs.frameInfo.blockMode, cctxPtr.prefs.compressionLevel);
    // compress tmp buffer
    inc(dstPtr, LZ4F_compressBlock(dstPtr, cctxPtr.tmpIn, cctxPtr.tmpInSize, compress, cctxPtr.lz4CtxPtr, cctxPtr.prefs.compressionLevel));
    if (cctxPtr.prefs.frameInfo.blockMode = blockLinked) then
        inc(cctxPtr.tmpIn, cctxPtr.tmpInSize);
    cctxPtr.tmpInSize := 0;
    // keep tmpIn within limits
    if ((cctxPtr.tmpIn + cctxPtr.maxBlockSize) > (cctxPtr.tmpBuff + cctxPtr.maxBufferSize)) then // necessarily blockLinked
    begin
        LZ4F_localSaveDict(cctxPtr);
        cctxPtr.tmpIn := cctxPtr.tmpBuff + 65536;
    end;
    result := dstPtr - dstStart;
end;

function LZ4F_compressEnd(compressionContext: PLZ4F_compressionContext_t; dstBuffer: pointer; dstMaxSize: size_t;
  const compressOptionsPtr: PLZ4F_compressOptions_t): size_t;
var
    cctxPtr: PLZ4F_cctx_internal_t;
    dstStart: pByte;
    dstPtr: pByte;
    errorCode: size_t;
    xxh: cardinal;
begin
    cctxPtr := PLZ4F_cctx_internal_t(compressionContext);
    dstStart := pByte(dstBuffer);
    dstPtr := dstStart;
    errorCode := LZ4F_flush(compressionContext, dstBuffer, dstMaxSize, compressOptionsPtr);
    if LZ4F_isError(errorCode) then
        exit(errorCode);
    inc(dstPtr, errorCode);
    LZ4F_writeLE32(dstPtr, 0);
    inc(dstPtr, 4); // endMark
    if cctxPtr.prefs.frameInfo.contentChecksumFlag = contentChecksumEnabled then
    begin
        xxh := XXH32_digest(@(cctxPtr.xxh));
        LZ4F_writeLE32(dstPtr, xxh);
        inc(dstPtr, 4); // content Checksum
    end;
    cctxPtr.cStage := 0; // state is now re-usable (with identical preferences)

    result := dstPtr - dstStart;
end;

function LZ4F_readLE32(const srcPtr: pByte): cardinal;
var
    value32: cardinal;
begin
    value32 := srcPtr[0];
    inc(value32, (srcPtr[1] shl 8));
    inc(value32, (srcPtr[2] shl 16));
    inc(value32, (srcPtr[3] shl 24));
    result := value32;
end;

function LZ4F_decodeHeader(dctxPtr: PLZ4F_dctx_internal_t; srcPtr: pByte; srcSize: size_t): size_t;
var
    FLG, BD, HC: byte;
    version, blockMode, blockChecksumFlag, contentSizeFlag, contentChecksumFlag, dictFlag, blockSizeID: cardinal;
    bufferNeeded: size_t;
begin
    // need to decode header to get frameInfo
    if srcSize < 7 then
        exit(size_t(-integer(ERROR_GENERIC))); // minimal header size
    // control magic number
    if (LZ4F_readLE32(srcPtr) <> LZ4F_MAGICNUMBER) then
        exit(size_t(-integer(ERROR_GENERIC)));
    inc(srcPtr, 4);
    // Flags
    FLG := srcPtr[0];
    version := (FLG shr 6) and _2BITS;
    blockMode := (FLG shr 5) and _1BIT;
    blockChecksumFlag := (FLG shr 4) and _1BIT;
    contentSizeFlag := (FLG shr 3) and _1BIT;
    contentChecksumFlag := (FLG shr 2) and _1BIT;
    dictFlag := (FLG shr 0) and _1BIT;
    BD := srcPtr[1];
    blockSizeID := (BD shr 4) and _3BITS;
    // check
    HC := LZ4F_headerChecksum(srcPtr, 2);
    if (HC <> srcPtr[2]) then
        exit(size_t(-integer(ERROR_GENERIC))); // Bad header checksum error

    // validate
    if version <> 1 then
        exit(size_t(-integer(ERROR_GENERIC))); // Version Number, only supported value
    if blockChecksumFlag <> 0 then
        exit(size_t(-integer(ERROR_GENERIC))); // Only supported value for the time being
    if contentSizeFlag <> 0 then
        exit(size_t(-integer(ERROR_GENERIC))); // Only supported value for the time being
    if ((FLG shr 1) and _1BIT) <> 0 then
        exit(size_t(-integer(ERROR_GENERIC)));
    /// Reserved bit
    if dictFlag <> 0 then
        exit(size_t(-integer(ERROR_GENERIC))); // Only supported value for the time being
    if (BD shr 7) and _1BIT <> 0 then
        exit(size_t(-integer(ERROR_GENERIC)));
    /// Reserved bit
    if blockSizeID < 4 then
        exit(size_t(-integer(ERROR_GENERIC))); // Only supported values for the time being
    if (((BD shr 0) and _4BITS) <> 0) then
        exit(size_t(-integer(ERROR_GENERIC))); // Reserved bits
    // save
    dctxPtr.frameInfo.blockMode := blockMode_t(blockMode);
    dctxPtr.frameInfo.contentChecksumFlag := contentChecksum_t(contentChecksumFlag);
    dctxPtr.frameInfo.blockSizeID := blockSizeID_t(blockSizeID);
    dctxPtr.maxBlockSize := LZ4F_getBlockSize(blockSizeID);

    // init
    if (contentChecksumFlag <> 0) then
        XXH32_reset(@(dctxPtr.xxh), 0);

    // alloc
    bufferNeeded := dctxPtr.maxBlockSize + size_t (integer(dctxPtr.frameInfo.blockMode = blockLinked) * 131072);

    if bufferNeeded > dctxPtr.maxBufferSize then // tmp buffers too small
    begin
        freemem(dctxPtr.tmpIn);
        freemem(dctxPtr.tmpOutBuffer);
        dctxPtr.maxBufferSize := bufferNeeded;
        dctxPtr.tmpIn := allocmem(dctxPtr.maxBlockSize);
        if dctxPtr.tmpIn = Nil then
            exit(size_t(-integer(ERROR_GENERIC)));
        dctxPtr.tmpOutBuffer := allocmem(dctxPtr.maxBufferSize);
        if dctxPtr.tmpOutBuffer = Nil then
            exit(size_t(-integer(ERROR_GENERIC)));
    end;
    dctxPtr.tmpInSize := 0;
    dctxPtr.tmpInTarget := 0;
    dctxPtr.dict := dctxPtr.tmpOutBuffer;
    dctxPtr.dictSize := 0;
    dctxPtr.tmpOut := dctxPtr.tmpOutBuffer;
    dctxPtr.tmpOutStart := 0;
    dctxPtr.tmpOutSize := 0;

    result := 7;
end;

procedure LZ4F_updateDict(dctxPtr: PLZ4F_dctx_internal_t; const dstPtr: pByte; dstSize: size_t; const dstPtr0: pByte; withinTmp: cardinal);
var
    preserveSize: size_t;
    copySize: size_t;
    oldDictEnd: pByte;
begin
    if dctxPtr.dictSize = 0 then
        dctxPtr.dict := pByte(dstPtr); // priority to dictionary continuity

    if dctxPtr.dict + dctxPtr.dictSize = dstPtr then // dictionary continuity
    begin
        inc(dctxPtr.dictSize, dstSize);
        exit;
    end;

    if size_t(dstPtr - dstPtr0) + dstSize >= 65536 then // dstBuffer large enough to become dictionary
    begin
        dctxPtr.dict := pByte(dstPtr0);
        dctxPtr.dictSize := size_t(dstPtr - dstPtr0) + dstSize;
        exit;
    end;

    if ((withinTmp <> 0) and (dctxPtr.dict = dctxPtr.tmpOutBuffer)) then
    begin
        // assumption : dctxPtr->dict + dctxPtr->dictSize == dctxPtr->tmpOut + dctxPtr->tmpOutStart
        inc(dctxPtr.dictSize, dstSize);
        exit;
    end;

    if withinTmp <> 0 then // copy relevant dict portion in front of tmpOut within tmpOutBuffer
    begin
        preserveSize := dctxPtr.tmpOut - dctxPtr.tmpOutBuffer;
        copySize := 65536 - dctxPtr.tmpOutSize;
        oldDictEnd := dctxPtr.dict + dctxPtr.dictSize - dctxPtr.tmpOutStart;
        if dctxPtr.tmpOutSize > 65536 then
            copySize := 0;
        if copySize > preserveSize then
            copySize := preserveSize;

        move((oldDictEnd - copySize)^, (dctxPtr.tmpOutBuffer + preserveSize - copySize)^, copySize);

        dctxPtr.dict := dctxPtr.tmpOutBuffer;
        dctxPtr.dictSize := preserveSize + dctxPtr.tmpOutStart + dstSize;
        exit;
    end;

    if dctxPtr.dict = dctxPtr.tmpOutBuffer then // copy dst into tmp to complete dict
    begin
        if dctxPtr.dictSize + dstSize > dctxPtr.maxBufferSize then // tmp buffer not large enough
        begin
            preserveSize := 65536 - dstSize; // note : dstSize < 64 KB
            move((dctxPtr.dict + dctxPtr.dictSize - preserveSize)^, (dctxPtr.dict)^, preserveSize);
            dctxPtr.dictSize := preserveSize;
        end;
        move(dstPtr^, (dctxPtr.dict + dctxPtr.dictSize)^, dstSize);
        inc(dctxPtr.dictSize, dstSize);
        exit;
    end;
    // join dict & dest into tmp

    preserveSize := 65536 - dstSize; // note : dstSize < 64 KB
    if preserveSize > dctxPtr.dictSize then
        preserveSize := dctxPtr.dictSize;
    move((dctxPtr.dict + dctxPtr.dictSize - preserveSize)^, dctxPtr.tmpOutBuffer^, preserveSize);
    move(dstPtr^, (dctxPtr.tmpOutBuffer + preserveSize)^, dstSize);
    dctxPtr.dict := dctxPtr.tmpOutBuffer;
    dctxPtr.dictSize := preserveSize + dstSize;
end;

function LZ4F_decompress_safe(const source: pAnsiChar; dest: pAnsiChar; compressedSize: integer; maxDecompressedSize: integer;
  const dictStart: pAnsiChar; dictSize: integer): integer;
begin
    result := LZ4_decompress_safe(source, dest, compressedSize, maxDecompressedSize);
end;

function LZ4F_decompress(decompressionContext: PLZ4F_decompressionContext_t;
  dstBuffer: pointer; dstSizePtr: psize_t;
  const srcBuffer: pointer; srcSizePtr: psize_t;
  decompressOptionsPtr: PLZ4F_decompressOptions_t): size_t;
type
    Tdecoder = function(const c1: pAnsiChar; c2: pAnsiChar; c3: integer; c4: integer; const c5: pAnsiChar; c6: integer): integer;
var
    dctxPtr: PLZ4F_dctx_internal_t;
    optionsNull: LZ4F_decompressOptions_t;
    srcStart: pByte;
    srcEnd: pByte;
    srcPtr: pByte;
    dstStart: pByte;
    dstEnd: pByte;
    dstPtr: pByte;
    selectedIn: pByte;
    doAnotherStage: cardinal;
    nextSrcSizeHint: size_t;
    sizeToCopy: size_t;
    errorCode: LZ4F_errorCode_t;
    nextCBlockSize: size_t;
    decodedSize: integer;
    decoder: Tdecoder;
    reservedDictSpace: size_t;
    suffixSize: size_t;
    readCRC: cardinal;
    resultCRC: cardinal;
    preserveSize: size_t;
    copySize: size_t;
    oldDictEnd: pByte;
    newDictSize: size_t;
begin
    dctxPtr := PLZ4F_dctx_internal_t(decompressionContext);
    fillchar(optionsNull, sizeof(LZ4F_decompressOptions_t), 0);
    srcStart := pByte(srcBuffer);
    srcEnd := srcStart + srcSizePtr^;
    srcPtr := srcStart;
    dstStart := pByte(dstBuffer);
    dstEnd := dstStart + dstSizePtr^;
    dstPtr := dstStart;
    selectedIn := Nil;
    doAnotherStage := 1;
    nextSrcSizeHint := 1;

    if decompressOptionsPtr = Nil then
        decompressOptionsPtr := @optionsNull;

    srcSizePtr^ := 0;
    dstSizePtr^ := 0;

    // expect to continue decoding src buffer where it left previously
    if dctxPtr.srcExpect <> Nil then
    begin
        if (srcStart <> dctxPtr.srcExpect) then
            exit(size_t(-integer(ERROR_GENERIC)));
    end;

    // programmed as a state machine

    while (doAnotherStage <> 0) do
    begin
        case dctxPtr.dStage of
            cardinal(dstage_getHeader):
                begin
                    if srcEnd - srcPtr >= 7 then
                    begin
                        selectedIn := srcPtr;
                        inc(srcPtr, 7);
                        dctxPtr.dStage := cardinal(dstage_decodeHeader);
                    end
                    else
                    begin
                        dctxPtr.tmpInSize := 0;
                        dctxPtr.dStage := cardinal(dstage_storeHeader);
                    end;
                end;
            cardinal(dstage_storeHeader):
                begin
                    sizeToCopy := 7 - dctxPtr.tmpInSize;
                    if sizeToCopy > size_t(srcEnd - srcPtr) then
                        sizeToCopy := srcEnd - srcPtr;
                    move(srcPtr^, (pByte(@dctxPtr.header) + dctxPtr.tmpInSize)^, sizeToCopy);
                    inc(dctxPtr.tmpInSize, sizeToCopy);
                    inc(srcPtr, sizeToCopy);
                    if (dctxPtr.tmpInSize < 7) then
                    begin
                        nextSrcSizeHint := (7 - dctxPtr.tmpInSize) + 4;
                        doAnotherStage := 0; // no enough src, wait to get some more
                    end
                    else
                    begin
                        selectedIn := @dctxPtr.header;
                        dctxPtr.dStage := cardinal(dstage_decodeHeader);
                    end;
                end;
            cardinal(dstage_decodeHeader):
                begin
                    errorCode := LZ4F_decodeHeader(dctxPtr, selectedIn, 7);
                    if LZ4F_isError(errorCode) then
                        exit(errorCode);
                    dctxPtr.dStage := cardinal(dstage_getCBlockSize);
                end;
            cardinal(dstage_getCBlockSize):
                begin
                    if (srcEnd - srcPtr) >= 4 then
                    begin
                        selectedIn := srcPtr;
                        inc(srcPtr, 4);
                        dctxPtr.dStage := cardinal(dstage_decodeCBlockSize);
                    end
                    else
                    begin
                        // not enough input to read cBlockSize field
                        dctxPtr.tmpInSize := 0;
                        dctxPtr.dStage := cardinal(dstage_storeCBlockSize);
                    end;
                end;
            cardinal(dstage_storeCBlockSize):
                begin
                    sizeToCopy := 4 - dctxPtr.tmpInSize;
                    if sizeToCopy > size_t(srcEnd - srcPtr) then
                        sizeToCopy := srcEnd - srcPtr;
                    move(srcPtr^, (dctxPtr.tmpIn + dctxPtr.tmpInSize)^, sizeToCopy);
                    inc(srcPtr, sizeToCopy);
                    inc(dctxPtr.tmpInSize, sizeToCopy);
                    if dctxPtr.tmpInSize < 4 then // not enough input to get full cBlockSize; wait for more
                    begin
                        nextSrcSizeHint := 4 - dctxPtr.tmpInSize;
                        doAnotherStage := 0;
                    end
                    else
                    begin
                        selectedIn := dctxPtr.tmpIn;
                        dctxPtr.dStage := cardinal(dstage_decodeCBlockSize);
                    end;
                end;
            cardinal(dstage_decodeCBlockSize):
                begin
                    nextCBlockSize := LZ4F_readLE32(selectedIn) and $7FFFFFFF;
                    if (nextCBlockSize = 0) then
                        dctxPtr.dStage := cardinal(dstage_getSuffix)
                    else
                    begin
                        if (nextCBlockSize > dctxPtr.maxBlockSize) then
                            exit(size_t(-integer(ERROR_GENERIC))); // invalid cBlockSize
                        dctxPtr.tmpInTarget := nextCBlockSize;
                        if (LZ4F_readLE32(selectedIn) and LZ4F_BLOCKUNCOMPRESSED_FLAG) <> 0 then
                            dctxPtr.dStage := cardinal(dstage_copyDirect)
                        else
                        begin
                            dctxPtr.dStage := cardinal(dstage_getCBlock);
                            if dstPtr = dstEnd then
                            begin
                                nextSrcSizeHint := nextCBlockSize + 4;
                                doAnotherStage := 0;
                            end;
                        end;
                    end;
                end;
            cardinal(dstage_copyDirect): // uncompressed block
                begin
                    sizeToCopy := dctxPtr.tmpInTarget;
                    if size_t(srcEnd - srcPtr) < sizeToCopy then
                        sizeToCopy := srcEnd - srcPtr; // not enough input to read full block
                    if size_t(dstEnd - dstPtr) < sizeToCopy then
                        sizeToCopy := dstEnd - dstPtr;
                    move(srcPtr^, dstPtr^, sizeToCopy);
                    if (dctxPtr.frameInfo.contentChecksumFlag <> noContentChecksum) then
                        XXH32_update(@(dctxPtr.xxh), srcPtr, cardinal(sizeToCopy));
                    // dictionary management
                    if (dctxPtr.frameInfo.blockMode = blockLinked) then
                        LZ4F_updateDict(dctxPtr, dstPtr, sizeToCopy, dstStart, 0);
                    inc(srcPtr, sizeToCopy);
                    inc(dstPtr, sizeToCopy);
                    if sizeToCopy = dctxPtr.tmpInTarget then // all copied
                        dctxPtr.dStage := cardinal(dstage_getCBlockSize)
                    else
                    begin
                        dec(dctxPtr.tmpInTarget, sizeToCopy); // still need to copy more
                        nextSrcSizeHint := dctxPtr.tmpInTarget + 4;
                        doAnotherStage := 0;
                    end;
                end;
            cardinal(dstage_getCBlock):
                begin
                    if size_t(srcEnd - srcPtr) < dctxPtr.tmpInTarget then
                    begin
                        dctxPtr.tmpInSize := 0;
                        dctxPtr.dStage := cardinal(dstage_storeCBlock);
                    end
                    else
                    begin
                        selectedIn := srcPtr;
                        inc(srcPtr, dctxPtr.tmpInTarget);
                        dctxPtr.dStage := cardinal(dstage_decodeCBlock);
                    end;
                end;
            cardinal(dstage_storeCBlock):
                begin
                    sizeToCopy := dctxPtr.tmpInTarget - dctxPtr.tmpInSize;
                    if sizeToCopy > size_t(srcEnd - srcPtr) then
                        sizeToCopy := srcEnd - srcPtr;

                    move(srcPtr^, (dctxPtr.tmpIn + dctxPtr.tmpInSize)^, sizeToCopy);
                    inc(dctxPtr.tmpInSize, sizeToCopy);
                    inc(srcPtr, sizeToCopy);
                    if (dctxPtr.tmpInSize < dctxPtr.tmpInTarget) then // need more input
                    begin
                        nextSrcSizeHint := (dctxPtr.tmpInTarget - dctxPtr.tmpInSize) + 4;
                        doAnotherStage := 0;
                    end
                    else
                    begin
                        selectedIn := dctxPtr.tmpIn;
                        dctxPtr.dStage := cardinal(dstage_decodeCBlock);
                    end;
                end;
            cardinal(dstage_decodeCBlock):
                begin
                    if (size_t(dstEnd - dstPtr) < dctxPtr.maxBlockSize) then // not enough place into dst : decode into tmpOut
                        dctxPtr.dStage := cardinal(dstage_decodeCBlock_intoTmp)
                    else
                        dctxPtr.dStage := cardinal(dstage_decodeCBlock_intoDst);
                end;

            cardinal(dstage_decodeCBlock_intoDst):
                begin
                    if (dctxPtr.frameInfo.blockMode = blockLinked) then
                        decoder := LZ4_decompress_safe_usingDict
                    else
                        decoder := LZ4F_decompress_safe;

                    decodedSize := decoder(pAnsiChar(selectedIn), pAnsiChar(dstPtr), integer(dctxPtr.tmpInTarget),
                      integer(dctxPtr.maxBlockSize), pAnsiChar(dctxPtr.dict), integer(dctxPtr.dictSize));
                    if (decodedSize < 0) then
                        exit(size_t(-integer(ERROR_GENERIC))); // decompression failed
                    if (dctxPtr.frameInfo.contentChecksumFlag <> noContentChecksum) then
                        XXH32_update(@(dctxPtr.xxh), dstPtr, decodedSize);
                    // dictionary management
                    if (dctxPtr.frameInfo.blockMode = blockLinked) then
                        LZ4F_updateDict(dctxPtr, dstPtr, decodedSize, dstStart, 0);

                    inc(dstPtr, decodedSize);
                    dctxPtr.dStage := cardinal(dstage_getCBlockSize);
                end;
            cardinal(dstage_decodeCBlock_intoTmp):
                begin
                    if (dctxPtr.frameInfo.blockMode = blockLinked) then
                        decoder := LZ4_decompress_safe_usingDict
                    else
                        decoder := LZ4F_decompress_safe;
                    // ensure enough place for tmpOut
                    if dctxPtr.frameInfo.blockMode = blockLinked then
                    begin
                        if (dctxPtr.dict = dctxPtr.tmpOutBuffer) then
                        begin
                            if (dctxPtr.dictSize > 131072) then
                            begin
                                move((dctxPtr.dict + dctxPtr.dictSize - 65536)^, dctxPtr.dict^, 65536);
                                dctxPtr.dictSize := 65536;
                            end;
                            dctxPtr.tmpOut := dctxPtr.dict + dctxPtr.dictSize;
                        end
                        else // dict not within tmp
                        begin
                            reservedDictSpace := dctxPtr.dictSize;
                            if (reservedDictSpace > 65536) then
                                reservedDictSpace := 65536;
                            dctxPtr.tmpOut := dctxPtr.tmpOutBuffer + reservedDictSpace;
                        end;
                    end;
                    // Decode
                    decodedSize := decoder(pAnsiChar(selectedIn), pAnsiChar(dctxPtr.tmpOut), integer(dctxPtr.tmpInTarget),
                      integer(dctxPtr.maxBlockSize), pAnsiChar(dctxPtr.dict), integer(dctxPtr.dictSize));
                    if decodedSize < 0 then
                        exit(size_t(-integer(ERROR_decompressionFailed))); // decompression failed
                    if (dctxPtr.frameInfo.contentChecksumFlag <> noContentChecksum) then
                        XXH32_update(@(dctxPtr.xxh), dctxPtr.tmpOut, decodedSize);
                    dctxPtr.tmpOutSize := decodedSize;
                    dctxPtr.tmpOutStart := 0;
                    dctxPtr.dStage := cardinal(dstage_flushOut);
                end;
            cardinal(dstage_flushOut): // flush decoded data from tmpOut to dstBuffer
                begin
                    sizeToCopy := dctxPtr.tmpOutSize - dctxPtr.tmpOutStart;
                    if (sizeToCopy > size_t(dstEnd - dstPtr)) then
                        sizeToCopy := dstEnd - dstPtr;
                    move((dctxPtr.tmpOut + dctxPtr.tmpOutStart)^, dstPtr^, sizeToCopy);
                    // dictionary management
                    if (dctxPtr.frameInfo.blockMode = blockLinked) then
                        LZ4F_updateDict(dctxPtr, dstPtr, sizeToCopy, dstStart, 1);

                    inc(dctxPtr.tmpOutStart, sizeToCopy);
                    inc(dstPtr, sizeToCopy);
                    // end of flush ?
                    if (dctxPtr.tmpOutStart = dctxPtr.tmpOutSize) then
                        dctxPtr.dStage := cardinal(dstage_getCBlockSize)
                    else
                    begin
                        nextSrcSizeHint := 4;
                        doAnotherStage := 0; // still some data to flush
                    end;
                end;
            cardinal(dstage_getSuffix):
                begin
                    suffixSize := cardinal(dctxPtr.frameInfo.contentChecksumFlag) * 4;
                    if (suffixSize = 0) then // frame completed
                    begin
                        nextSrcSizeHint := 0;
                        dctxPtr.dStage := cardinal(dstage_getHeader);
                        doAnotherStage := 0;
                    end
                    else
                    begin
                        if ((srcEnd - srcPtr) >= 4) then // CRC present
                        begin
                            selectedIn := srcPtr;
                            inc(srcPtr, 4);
                            dctxPtr.dStage := cardinal(dstage_checkSuffix);
                        end
                        else
                        begin
                            dctxPtr.tmpInSize := 0;
                            dctxPtr.dStage := cardinal(dstage_storeSuffix);
                        end;
                    end;
                end;
            cardinal(dstage_storeSuffix):
                begin
                    sizeToCopy := 4 - dctxPtr.tmpInSize;
                    if (sizeToCopy > size_t(srcEnd - srcPtr)) then
                        sizeToCopy := srcEnd - srcPtr;
                    move(srcPtr^, (dctxPtr.tmpIn + dctxPtr.tmpInSize)^, sizeToCopy);
                    inc(srcPtr, sizeToCopy);
                    inc(dctxPtr.tmpInSize, sizeToCopy);
                    if (dctxPtr.tmpInSize < 4) then // not enough input to read complete suffix
                    begin
                        nextSrcSizeHint := 4 - dctxPtr.tmpInSize;
                        doAnotherStage := 0;
                    end
                    else
                    begin
                        selectedIn := dctxPtr.tmpIn;
                        dctxPtr.dStage := cardinal(dstage_checkSuffix);
                    end;
                end;
            cardinal(dstage_checkSuffix):
                begin
                    readCRC := LZ4F_readLE32(selectedIn);
                    resultCRC := XXH32_digest(@(dctxPtr.xxh));
                    if (readCRC <> resultCRC) then
                        exit(size_t(-integer(ERROR_checksum_invalid)));
                    nextSrcSizeHint := 0;
                    dctxPtr.dStage := cardinal(dstage_getHeader);
                    doAnotherStage := 0;
                end;
        end;
    end;
    // preserve dictionary within tmp if necessary
    if (dctxPtr.frameInfo.blockMode = blockLinked)
      and (dctxPtr.dict <> dctxPtr.tmpOutBuffer)
      and (decompressOptionsPtr.stableDst = 0)
      and (cardinal(dctxPtr.dStage - 1) < cardinal(cardinal(dstage_getSuffix) - 1)) then
    begin
        if dctxPtr.dStage = cardinal(dstage_flushOut) then
        begin
            preserveSize := dctxPtr.tmpOut - dctxPtr.tmpOutBuffer;
            copySize := 65536 - dctxPtr.tmpOutSize;
            oldDictEnd := dctxPtr.dict + dctxPtr.dictSize - dctxPtr.tmpOutStart;
            if dctxPtr.tmpOutSize > 65536 then
                copySize := 0;
            if copySize > preserveSize then
                copySize := preserveSize;
            move((oldDictEnd - copySize)^, (dctxPtr.tmpOutBuffer + preserveSize - copySize)^, copySize);

            dctxPtr.dict := dctxPtr.tmpOutBuffer;
            dctxPtr.dictSize := preserveSize + dctxPtr.tmpOutStart;
        end
        else
        begin
            newDictSize := dctxPtr.dictSize;
            oldDictEnd := dctxPtr.dict + dctxPtr.dictSize;
            if newDictSize > 65536 then
                newDictSize := 65536;

            move((oldDictEnd - newDictSize)^, (dctxPtr.tmpOutBuffer)^, newDictSize);

            dctxPtr.dict := dctxPtr.tmpOutBuffer;
            dctxPtr.dictSize := newDictSize;
            dctxPtr.tmpOut := dctxPtr.tmpOutBuffer + newDictSize;
        end;
    end;
    if (srcPtr < srcEnd) then // function must be called again with following source data
        dctxPtr.srcExpect := srcPtr
    else
        dctxPtr.srcExpect := Nil;
    srcSizePtr^ := (srcPtr - srcStart);
    dstSizePtr^ := (dstPtr - dstStart);
    result := nextSrcSizeHint;
end;

function LZ4F_createCompressionContext(var LZ4F_compressionContextPtr: PLZ4F_compressionContext_t; version: cardinal): LZ4F_errorCode_t;
var
    cctxPtr: PLZ4F_cctx_internal_t;
begin
    cctxPtr := allocmem(sizeof(LZ4F_cctx_internal_t));
    if cctxPtr = Nil then
        exit(LZ4F_errorCode_t(-integer(ERROR_allocation_failed)));

    cctxPtr.version := version;
    cctxPtr.cStage := 0; // Next stage : write header

    LZ4F_compressionContextPtr := PLZ4F_compressionContext_t(cctxPtr);
    result := cardinal(OK_NoError);
end;

function LZ4F_freeCompressionContext(LZ4F_compressionContext: PLZ4F_compressionContext_t): LZ4F_errorCode_t;
var
    cctxPtr: PLZ4F_cctx_internal_t;
begin
    cctxPtr := PLZ4F_cctx_internal_t(LZ4F_compressionContext);
    freemem(cctxPtr.lz4CtxPtr);
    freemem(cctxPtr.tmpBuff);
    freemem(LZ4F_compressionContext);
    result := cardinal(OK_NoError);
end;

function LZ4F_getFrameInfo(decompressionContext: PLZ4F_decompressionContext_t; frameInfoPtr: PLZ4F_frameInfo_t; const srcBuffer: pointer;
  srcSizePtr: psize_t): LZ4F_errorCode_t;
var
    dctxPtr: PLZ4F_dctx_internal_t;
    errorCode: LZ4F_errorCode_t;
begin
    dctxPtr := PLZ4F_dctx_internal_t(decompressionContext);
    if dctxPtr.dStage = cardinal(dstage_getHeader) then
    begin
        errorCode := LZ4F_decodeHeader(dctxPtr, srcBuffer, srcSizePtr^);
        if LZ4F_isError(errorCode) then
            exit(errorCode);
        srcSizePtr^ := errorCode;
        frameInfoPtr^ := dctxPtr.frameInfo;
        dctxPtr.srcExpect := Nil;
        dctxPtr.dStage := cardinal(dstage_getCBlockSize);
        exit(4);
    end;
    srcSizePtr^ := 0;
    frameInfoPtr^ := dctxPtr.frameInfo;
    result := 0;
end;

function LZ4F_freeDecompressionContext(LZ4F_decompressionContext: PLZ4F_decompressionContext_t): LZ4F_errorCode_t;
var
    dctxPtr: PLZ4F_dctx_internal_t;
begin
    dctxPtr := PLZ4F_dctx_internal_t(LZ4F_decompressionContext);
    freemem(dctxPtr.tmpIn);
    freemem(dctxPtr.tmpOutBuffer);
    freemem(dctxPtr);
    result := cardinal(OK_NoError);
end;

end.
