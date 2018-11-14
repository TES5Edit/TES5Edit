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

unit lz4frame_static;
{$POINTERMATH ON}
{$Q-}
{$R-}

interface

uses Windows;

type
    LZ4F_LIST_ERRORS = (
      OK_NoError = 0,
      ERROR_GENERIC,
      ERROR_maxBlockSize_invalid,
      ERROR_blockMode_invalid,
      ERROR_contentChecksumFlag_invalid,
      ERROR_compressionLevel_invalid,
      ERROR_allocation_failed,
      ERROR_srcSize_tooLarge,
      ERROR_dstMaxSize_tooSmall,
      ERROR_decompressionFailed,
      ERROR_checksum_invalid,
      ERROR_maxCode);

const
     LZ4F_errorStrings : array[0..11] of AnsiString =
     (
       'OK_NoError',
       'ERROR_GENERIC',
       'ERROR_maxBlockSize_invalid',
       'ERROR_blockMode_invalid',
       'ERROR_contentChecksumFlag_invalid',
       'ERROR_compressionLevel_invalid',
       'ERROR_allocation_failed',
       'ERROR_srcSize_tooLarge',
       'ERROR_dstMaxSize_tooSmall',
       'ERROR_decompressionFailed',
        'ERROR_checksum_invalid',
       'ERROR_maxCode'
     );

implementation

end.
