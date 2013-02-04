(*----------------------------------------------------------------------------*
 *  DirectX 9 SDK April 2006 C++ common framework adaptation for Delphi       *
 *  by Alexey Barkovoy (e-mail: directx@clootie.ru)                           *
 *                                                                            *
 *  Desc: DirectSound part of framework.                                      *
 *  Supported compilers: Delphi 5,6,7,9 FreePascal 2.0                        *
 *                                                                            *
 *  Latest version can be downloaded from:                                    *
 *     http://www.clootie.ru                                                  *
 *     http://sourceforge.net/projects/delphi-dx9sdk                          *
 *----------------------------------------------------------------------------*
 *  $Id: DXUTsound.pas,v 1.7 2006/04/23 19:38:09 clootie Exp $
 *----------------------------------------------------------------------------*)
{******************************************************************************}
{                                                                              }
{ Obtained through: Joint Endeavour of Delphi Innovators (Project JEDI)        }
{                                                                              }
{ The contents of this file are used with permission, subject to the Mozilla   }
{ Public License Version 1.1 (the "License"); you may not use this file except }
{ in compliance with the License. You may obtain a copy of the License at      }
{ http://www.mozilla.org/MPL/MPL-1.1.html                                      }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ Alternatively, the contents of this file may be used under the terms of the  }
{ GNU Lesser General Public License (the  "LGPL License"), in which case the   }
{ provisions of the LGPL License are applicable instead of those above.        }
{ If you wish to allow use of your version of this file only under the terms   }
{ of the LGPL License and not to allow others to use your version of this file }
{ under the MPL, indicate your decision by deleting  the provisions above and  }
{ replace  them with the notice and other provisions required by the LGPL      }
{ License.  If you do not delete the provisions above, a recipient may use     }
{ your version of this file under either the MPL or the LGPL License.          }
{                                                                              }
{ For more information about the LGPL: http://www.gnu.org/copyleft/lesser.html }
{                                                                              }
{******************************************************************************}

//-----------------------------------------------------------------------------
// File: DXUTsound.h, DXUTsound.cpp
//
// Desc: DirectSound framework classes for reading and writing wav files and
//       playing them in DirectSound buffers. Feel free to use this class
//       as a starting point for adding extra functionality.
//
// Copyright (c) Microsoft Corp. All rights reserved.
//-----------------------------------------------------------------------------

{$I DirectX.inc}

unit DXUTsound;

interface

uses
  Windows, MMSystem, DirectSound;


//-----------------------------------------------------------------------------
// Typing macros
//-----------------------------------------------------------------------------
const
  WAVEFILE_READ   = 1;
  WAVEFILE_WRITE  = 2;
{$IFDEF FPC}
//todo: FPC_1.9.2 bug!!!
type
  TMMIOInfo = _MMIOINFO;
  TMMCKInfo = _MMCKINFO;
  pcmwaveformat_tag = PCMWAVEFORMAT;
  TPCMWaveFormat = pcmwaveformat_tag;
{$ENDIF}



type
  PIDirectSoundBuffer = ^IDirectSoundBuffer;

  PAIDirectSoundBuffer = ^AIDirectSoundBuffer;
  AIDirectSoundBuffer = array[0..MaxInt div SizeOf(IDirectSoundBuffer) - 1] of IDirectSoundBuffer;

  PADSBPositionNotify = ^ADSBPositionNotify;
  ADSBPositionNotify =  array[0..MaxInt div SizeOf(TDSBPositionNotify) - 1] of TDSBPositionNotify;

type
  //-----------------------------------------------------------------------------
  // Classes used by this header
  //-----------------------------------------------------------------------------
  CSoundManager = class; 
  CSound = class;
  CStreamingSound = class;
  CWaveFile = class;

  //-----------------------------------------------------------------------------
  // Name: class CSoundManager
  // Desc:
  //-----------------------------------------------------------------------------
  CSoundManager = class
  protected
    m_pDS: IDirectSound8;

  public
    constructor Create; overload;
    destructor Destroy; override;

    function Initialize(hWnd: HWND; dwCoopLevel: DWORD): HRESULT;
    function SetPrimaryBufferFormat(dwPrimaryChannels, dwPrimaryFreq, dwPrimaryBitRate: DWORD): HRESULT;
    function Get3DListenerInterface(out ppDSListener: IDirectSound3DListener): HRESULT;

    function Create(out ppSound: CSound; strWaveFileName: PWideChar;
      dwCreationFlags: DWORD{ = 0}; const guid3DAlgorithm: TGUID{ = GUID_NULL};
      dwNumBuffers: DWORD = 1): HRESULT; overload;
    function CreateFromMemory(out ppSound: CSound; pbData: PByte;
      ulDataSize: Cardinal; pwfx: PWaveFormatEx; dwCreationFlags: DWORD {= 0};
      guid3DAlgorithm: TGUID {= GUID_NULL}; dwNumBuffers: DWORD {= 1}): HRESULT;
    function CreateStreaming(out ppStreamingSound: CStreamingSound;
      strWaveFileName: PWideChar; dwCreationFlags: DWORD; guid3DAlgorithm: TGUID;
      dwNotifyCount: DWORD; dwNotifySize: DWORD; hNotifyEvent: THandle): HRESULT;
  public
    //inline  LPDIRECTSOUND8 GetDirectSound() { return m_pDS; }
    property GetDirectSound: IDirectSound8 read m_pDS;
  end;




  //-----------------------------------------------------------------------------
  // Name: class CSound
  // Desc: Encapsulates functionality of a DirectSound buffer.
  //-----------------------------------------------------------------------------
  CSound = class
  public
    m_pWaveFile: CWaveFile;
  protected
    m_apDSBuffer: PAIDirectSoundBuffer;
    m_dwDSBufferSize: DWORD;
//    m_pWaveFile: CWaveFile;
    m_dwNumBuffers: DWORD;
    m_dwCreationFlags: DWORD;

    function RestoreBuffer(pDSB: IDirectSoundBuffer; pbWasRestored: PBOOL): HRESULT;

  public
    constructor Create(apDSBuffer: PAIDirectSoundBuffer; dwDSBufferSize: DWORD; dwNumBuffers: DWORD; pWaveFile: CWaveFile; dwCreationFlags: DWORD);
    destructor Destroy; override;

    function Get3DBufferInterface(dwIndex: DWORD; out ppDS3DBuffer: IDirectSound3DBuffer): HRESULT;
    function FillBufferWithSound(pDSB: IDirectSoundBuffer; bRepeatWavIfBufferLarger: BOOL): HRESULT;
    function GetFreeBuffer: IDirectSoundBuffer;
    function GetBuffer(dwIndex: DWORD): IDirectSoundBuffer;

    function Play(dwPriority: DWORD = 0; dwFlags: DWORD = 0; lVolume: Longint = 0;
      lFrequency: Longint = -1; lPan: Longint = 0): HRESULT;
    function Play3D(const p3DBuffer: TDS3DBuffer; dwPriority: DWORD = 0; dwFlags: DWORD = 0; lFrequency: Longint = 0): HRESULT;
    function Stop: HRESULT;
    function Reset: HRESULT;
    function IsSoundPlaying: BOOL;
  end;




  //-----------------------------------------------------------------------------
  // Name: class CStreamingSound
  // Desc: Encapsulates functionality to play a wave file with DirectSound.
  //       The Create() method loads a chunk of wave file into the buffer,
  //       and as sound plays more is written to the buffer by calling
  //       HandleWaveStreamNotification() whenever hNotifyEvent is signaled.
  //-----------------------------------------------------------------------------
  CStreamingSound = class(CSound)
  protected
    m_dwLastPlayPos: DWORD;
    m_dwPlayProgress: DWORD;
    m_dwNotifySize: DWORD;
    m_dwNextWriteOffset: DWORD;
    m_bFillNextNotificationWithSilence:  BOOL;

  public
    constructor Create(pDSBuffer: IDirectSoundBuffer; dwDSBufferSize: DWORD;
      pWaveFile: CWaveFile; dwNotifySize: DWORD);
    destructor Destroy; override;

    function HandleWaveStreamNotification(bLoopedPlay: BOOL): HRESULT;
    function Reset: HRESULT;
  end;




  //-----------------------------------------------------------------------------
  // Name: class CWaveFile
  // Desc: Encapsulates reading or writing sound data to or from a wave file
  //-----------------------------------------------------------------------------
  CWaveFile = class
  public
    m_pwfx:         PWaveFormatEx;  // Pointer to WAVEFORMATEX structure
    m_hmmio:        HMMIO;          // MM I/O handle for the WAVE
    m_ck:           MMCKINFO;       // Multimedia RIFF chunk
    m_ckRiff:       MMCKINFO;       // Use in opening a WAVE file
    m_dwSize:       DWORD;          // The size of the wave file
    m_mmioinfoOut:  MMIOINFO;
    m_dwFlags:      DWORD;
    m_bIsReadingFromMemory: BOOL;
    m_pbData: PByte;
    m_pbDataCur: PByte;
    m_ulDataSize: Cardinal;
    m_pResourceBuffer: PChar;

  protected
    function ReadMMIO: HRESULT;
    function WriteMMIO(pwfxDest: PWaveFormatEx): HRESULT;

  public
    constructor Create;
    destructor Destroy; override;

    function Open(strFileName: PWideChar; pwfx: PWaveFormatEx; dwFlags: DWORD): HRESULT;
    function OpenFromMemory(pbData: PByte; ulDataSize: Cardinal; pwfx: PWaveFormatEx; dwFlags: DWORD): HRESULT;
    function Close: HRESULT;

    function Read(pBuffer: PByte; dwSizeToRead: DWORD; pdwSizeRead: PDWORD): HRESULT;
    function Write(nSizeToWrite: LongWord; pbSrcData: PByte; out pnSizeWrote: LongWord): HRESULT;

    function GetSize: DWORD;
    function ResetFile: HRESULT;
    property GetFormat: PWaveFormatEx read m_pwfx;
  end;


procedure DXUT_StopSound(s: CSound);
procedure DXUT_PlaySound(s: CSound);
procedure DXUT_PlaySoundLooping(s: CSound);

implementation

uses
  SysUtils, DXErr9, DXUTcore;

const
  UnitName = 'DSUtil.pas';

{$IFNDEF FPC}
function mmioOpenW(szFileName: PWideChar; lpmmioinfo: PMMIOInfo;
  dwOpenFlags: DWORD): HMMIO; stdcall; external mmsyst{ name 'mmioOpenW'};
{$ENDIF}


const
  FillValuesStaticA: array[False..True] of Byte = (0, 128);

//-----------------------------------------------------------------------------
// File: DSUtil.cpp
//
// Desc: DirectSound framework classes for reading and writing wav files and
//       playing them in DirectSound buffers. Feel free to use this class
//       as a starting point for adding extra functionality.
//
// Copyright (c) Microsoft Corp. All rights reserved.
//-----------------------------------------------------------------------------



{ CSoundManager }

//-----------------------------------------------------------------------------
// Name: CSoundManager::CSoundManager()
// Desc: Constructs the class
//-----------------------------------------------------------------------------
constructor CSoundManager.Create;
begin
  m_pDS := nil;
end;


//-----------------------------------------------------------------------------
// Name: CSoundManager::~CSoundManager()
// Desc: Destroys the class
//-----------------------------------------------------------------------------
destructor CSoundManager.Destroy;
begin
  SAFE_RELEASE(m_pDS);
  inherited;
end;

//-----------------------------------------------------------------------------
// Name: CSoundManager::Initialize()
// Desc: Initializes the IDirectSound object and also sets the primary buffer
//       format.  This function must be called before any others.
//-----------------------------------------------------------------------------
function CSoundManager.Initialize(hWnd: HWND; dwCoopLevel: DWORD): HRESULT;
begin
  SAFE_RELEASE(m_pDS);

  // Create IDirectSound using the primary sound device
  Result := DirectSoundCreate8(nil, m_pDS, nil);
  if FAILED(Result) then
  begin
    DXUT_ERR('DirectSoundCreate8', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Set DirectSound coop level
  Result := m_pDS.SetCooperativeLevel(hWnd, dwCoopLevel);
  if FAILED(Result) then
  begin
    DXUT_ERR('SetCooperativeLevel', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
// Name: CSoundManager::SetPrimaryBufferFormat()
// Desc: Set primary buffer to a specified format
//       !WARNING! - Setting the primary buffer format and then using this
//                   same dsound object for DirectMusic messes up DirectMusic!
//       For example, to set the primary buffer format to 22kHz stereo, 16-bit
//       then:   dwPrimaryChannels = 2
//               dwPrimaryFreq     = 22050,
//               dwPrimaryBitRate  = 16
//-----------------------------------------------------------------------------
function CSoundManager.SetPrimaryBufferFormat(dwPrimaryChannels,
  dwPrimaryFreq, dwPrimaryBitRate: DWORD): HRESULT;
var
  pDSBPrimary: IDirectSoundBuffer;
  dsbd: TDSBufferDesc;
  wfx: TWaveFormatEx;
begin
  pDSBPrimary := nil;

  if (m_pDS = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  // Get the primary buffer
  ZeroMemory(@dsbd, SizeOf(TDSBufferDesc));
  dsbd.dwSize        := SizeOf(TDSBufferDesc);
  dsbd.dwFlags       := DSBCAPS_PRIMARYBUFFER;
  dsbd.dwBufferBytes := 0;
  dsbd.lpwfxFormat   := nil;

  Result := m_pDS.CreateSoundBuffer(dsbd, pDSBPrimary, nil);
  if FAILED(Result) then
  begin
    DXUT_ERR('CreateSoundBuffer', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  ZeroMemory(@wfx, SizeOf(TWaveFormatEx));
  wfx.wFormatTag      := WAVE_FORMAT_PCM;
  wfx.nChannels       := dwPrimaryChannels;
  wfx.nSamplesPerSec  := dwPrimaryFreq;
  wfx.wBitsPerSample  := dwPrimaryBitRate;
  wfx.nBlockAlign     := (wfx.wBitsPerSample div 8 * wfx.nChannels);
  wfx.nAvgBytesPerSec := (wfx.nSamplesPerSec * wfx.nBlockAlign);

  Result := pDSBPrimary.SetFormat(@wfx);
  if FAILED(Result) then
  begin
    DXUT_ERR('SetFormat', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  SAFE_RELEASE(pDSBPrimary);

  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
// Name: CSoundManager::Get3DListenerInterface()
// Desc: Returns the 3D listener interface associated with primary buffer.
//-----------------------------------------------------------------------------
function CSoundManager.Get3DListenerInterface(out ppDSListener: IDirectSound3DListener): HRESULT;
var
  dsbdesc:     TDSBufferDesc;
  pDSBPrimary: IDirectSoundBuffer;
begin
  if (m_pDS = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  ppDSListener := nil;

  // Obtain primary buffer, asking it for 3D control
  ZeroMemory(@dsbdesc, Sizeof(TDSBufferDesc));
  dsbdesc.dwSize :=  Sizeof(TDSBufferDesc);
  dsbdesc.dwFlags := DSBCAPS_CTRL3D or DSBCAPS_PRIMARYBUFFER;

  Result := m_pDS.CreateSoundBuffer(dsbdesc, pDSBPrimary, nil);
  if FAILED(Result) then
  begin
    DXUT_ERR('CreateSoundBuffer', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  Result := pDSBPrimary.QueryInterface(IID_IDirectSound3DListener, ppDSListener);
  if FAILED(Result) then
  begin
    // SAFE_RELEASE(pDSBPrimary); // not needed in Delphi
    DXUT_ERR('QueryInterface', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Release the primary buffer, since it is not need anymore
  // SAFE_RELEASE(pDSBPrimary); // not needed in Delphi

  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
// Name: CSoundManager::Create()
// Desc:
//-----------------------------------------------------------------------------
function CSoundManager.Create(out ppSound: CSound; strWaveFileName: PWideChar;
  dwCreationFlags: DWORD; const guid3DAlgorithm: TGUID;
  dwNumBuffers: DWORD): HRESULT;
var
  hrRet: HRESULT;
  i: Integer;
  apDSBuffer: PAIDirectSoundBuffer;
  dwDSBufferSize: DWORD;
  pWaveFile: CWaveFile;
  dsbd: TDSBufferDesc;
label
  LFail;
begin
  hrRet := S_OK;
  apDSBuffer := nil;
  pWaveFile := nil;
  //Result:= S_OK;

  if (m_pDS = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  if (strWaveFileName = nil) or (@ppSound = nil) or (dwNumBuffers < 1) then
  begin
    Result:= E_INVALIDARG;
    Exit;
  end;

try try
  GetMem(apDSBuffer, SizeOf(IDirectSoundBuffer)*dwNumBuffers);
  ZeroMemory(apDSBuffer, SizeOf(IDirectSoundBuffer)*dwNumBuffers);
  pWaveFile := CWaveFile.Create;

  pWaveFile.Open(strWaveFileName, nil, WAVEFILE_READ);

  if (pWaveFile.GetSize = 0) then
  begin
    // Wave is blank, so don't create it.
    Result := E_FAIL;
    goto LFail;
  end;

  // Make the DirectSound buffer the same size as the wav file
  dwDSBufferSize := pWaveFile.GetSize;

  // Create the direct sound buffer, and only request the flags needed
  // since each requires some overhead and limits if the buffer can
  // be hardware accelerated
  ZeroMemory(@dsbd, SizeOf(TDSBufferDesc));
  dsbd.dwSize          := SizeOf(TDSBufferDesc);
  dsbd.dwFlags         := dwCreationFlags;
  dsbd.dwBufferBytes   := dwDSBufferSize;
  dsbd.guid3DAlgorithm := guid3DAlgorithm;
  dsbd.lpwfxFormat     := pWaveFile.m_pwfx;

  // DirectSound is only guarenteed to play PCM data.  Other
  // formats may or may not work depending the sound card driver.
  Result := m_pDS.CreateSoundBuffer(dsbd, apDSBuffer^[0], nil);

  // Be sure to return this error code if it occurs so the
  // callers knows this happened.
  if (Result = DS_NO_VIRTUALIZATION) then hrRet := DS_NO_VIRTUALIZATION;

  if FAILED(Result) then
  begin
    // DSERR_BUFFERTOOSMALL will be returned if the buffer is
    // less than DSBSIZE_FX_MIN and the buffer is created
    // with DSBCAPS_CTRLFX.

    // It might also fail if hardware buffer mixing was requested
    // on a device that doesn't support it.
    DXUT_ERR('CreateSoundBuffer', Result, UnitName, $FFFFFFFF);

    goto LFail;
  end;

  // Default to use DuplicateSoundBuffer() when created extra buffers since always
  // create a buffer that uses the same memory however DuplicateSoundBuffer() will fail if
  // DSBCAPS_CTRLFX is used, so use CreateSoundBuffer() instead in this case.
  if ((dwCreationFlags and DSBCAPS_CTRLFX) = 0) then
  begin
    for i:= 1 to dwNumBuffers - 1 do
    begin
      Result := m_pDS.DuplicateSoundBuffer(apDSBuffer^[0], apDSBuffer^[i]);
      if FAILED(Result) then
      begin
        DXUT_ERR('DuplicateSoundBuffer', Result, UnitName, $FFFFFFFF);
        goto LFail;
      end;
    end;
  end else
  begin
    for i:= 1 to dwNumBuffers - 1 do
    begin
      Result := m_pDS.CreateSoundBuffer(dsbd, apDSBuffer^[i], nil);
      if FAILED(Result) then
      begin
        DXUT_ERR('CreateSoundBuffer', Result, UnitName, $FFFFFFFF);
        goto LFail;
      end;
    end;
  end;

  // Create the sound
  ppSound := CSound.Create(apDSBuffer, dwDSBufferSize, dwNumBuffers, pWaveFile, dwCreationFlags);

  Result:= hrRet;
  Exit;

LFail: // Cleanup
{$IFDEF FPC}
  //todo: FPC1.9.2 BUG workaround !!!
  dwNumBuffers := dwNumBuffers;
{$ENDIF}
except
  on EOutOfMemory do Result:= E_OUTOFMEMORY;
  else Result:= E_FAIL;
end;

  // Cleanup
  FreeAndNil(pWaveFile);

finally
  if Assigned(apDSBuffer) then
    for i:= 0 to dwNumBuffers - 1 do apDSBuffer[i] := nil;
  FreeMem(apDSBuffer);
end;
end;


//-----------------------------------------------------------------------------
// Name: CSoundManager::CreateFromMemory()
// Desc:
//-----------------------------------------------------------------------------
function CSoundManager.CreateFromMemory(out ppSound: CSound; pbData: PByte;
  ulDataSize: Cardinal; pwfx: PWaveFormatEx; dwCreationFlags: DWORD;
  guid3DAlgorithm: TGUID; dwNumBuffers: DWORD): HRESULT;
var
  i: DWORD;
  apDSBuffer: PAIDirectSoundBuffer;
  dwDSBufferSize: DWORD;
  pWaveFile: CWaveFile;
  dsbd: TDSBufferDesc;
begin
  apDSBuffer := nil;

  if (m_pDS = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  if (pbData = nil) or (@ppSound = nil) or (dwNumBuffers < 1) then
  begin
    Result:= E_INVALIDARG;
    Exit;
  end;

try

  try
    GetMem(apDSBuffer, SizeOf(IDirectSoundBuffer)*dwNumBuffers);
    pWaveFile := CWaveFile.Create;
  except
    on EOutOfMemory do
    begin
      Result:= E_OUTOFMEMORY;
      Exit;
    end;
  end;

  pWaveFile.OpenFromMemory(pbData, ulDataSize, pwfx, WAVEFILE_READ);


  // Make the DirectSound buffer the same size as the wav file
  dwDSBufferSize := ulDataSize;

  // Create the direct sound buffer, and only request the flags needed
  // since each requires some overhead and limits if the buffer can
  // be hardware accelerated
  ZeroMemory(@dsbd, SizeOf(TDSBufferDesc));
  dsbd.dwSize          := SizeOf(TDSBufferDesc);
  dsbd.dwFlags         := dwCreationFlags;
  dsbd.dwBufferBytes   := dwDSBufferSize;
  dsbd.guid3DAlgorithm := guid3DAlgorithm;
  dsbd.lpwfxFormat     := pwfx;

  Result := m_pDS.CreateSoundBuffer(dsbd, apDSBuffer[0], nil);
  if FAILED(Result) then
  begin
    DXUT_ERR('CreateSoundBuffer', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Default to use DuplicateSoundBuffer() when created extra buffers since always
  // create a buffer that uses the same memory however DuplicateSoundBuffer() will fail if
  // DSBCAPS_CTRLFX is used, so use CreateSoundBuffer() instead in this case.
  if ((dwCreationFlags and DSBCAPS_CTRLFX) = 0) then
  begin
    for i:= 1 to dwNumBuffers - 1 do
    begin
      Result := m_pDS.DuplicateSoundBuffer(apDSBuffer[0], apDSBuffer[i]);
      if FAILED(Result) then
      begin
        DXUT_ERR('DuplicateSoundBuffer', Result, UnitName, $FFFFFFFF);
        Exit;
      end;
    end;
  end else
  begin
    for i:= 1 to dwNumBuffers - 1 do
    begin
      Result := m_pDS.CreateSoundBuffer(dsbd, apDSBuffer[i], nil);
      if FAILED(Result) then
      begin
        DXUT_ERR('CreateSoundBuffer', Result, UnitName, $FFFFFFFF);
        Exit;
      end;
    end;
  end;

  // Create the sound
  ppSound := CSound.Create(apDSBuffer, dwDSBufferSize, dwNumBuffers, pWaveFile, dwCreationFlags);

  Result:= S_OK;

finally
  // Cleanup
  if Assigned(apDSBuffer) then
    for i:= 0 to dwNumBuffers - 1 do apDSBuffer[i] := nil;
  FreeMem(apDSBuffer);
end;
end;


//-----------------------------------------------------------------------------
// Name: CSoundManager::CreateStreaming()
// Desc:
//-----------------------------------------------------------------------------
function CSoundManager.CreateStreaming(
  out ppStreamingSound: CStreamingSound; strWaveFileName: PWideChar;
  dwCreationFlags: DWORD; guid3DAlgorithm: TGUID; dwNotifyCount,
  dwNotifySize: DWORD; hNotifyEvent: THandle): HRESULT;
var
  pDSBuffer: IDirectSoundBuffer;
  dwDSBufferSize: DWORD;
  pWaveFile: CWaveFile;
  aPosNotify: PADSBPositionNotify;
  pDSNotify: IDirectSoundNotify;
  dsbd: TDSBufferDesc;
  i: Integer;
begin
  if (m_pDS = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  if (strWaveFileName = nil) or (ppStreamingSound = nil) or (hNotifyEvent = 0) then
  begin
    Result:= E_INVALIDARG;
    Exit;
  end;

  try
    pWaveFile := CWaveFile.Create;
    pWaveFile.Open(strWaveFileName, nil, WAVEFILE_READ);

    // Figure out how big the DirectSound buffer should be
    dwDSBufferSize := dwNotifySize * dwNotifyCount;

    // Set up the direct sound buffer.  Request the NOTIFY flag, so
    // that we are notified as the sound buffer plays.  Note, that using this flag
    // may limit the amount of hardware acceleration that can occur.
    ZeroMemory(@dsbd, SizeOf(TDSBufferDesc));
    dsbd.dwSize          := SizeOf(TDSBufferDesc);
    dsbd.dwFlags         := dwCreationFlags or
                            DSBCAPS_CTRLPOSITIONNOTIFY or
                            DSBCAPS_GETCURRENTPOSITION2;
    dsbd.dwBufferBytes   := dwDSBufferSize;
    dsbd.guid3DAlgorithm := guid3DAlgorithm;
    dsbd.lpwfxFormat     := pWaveFile.m_pwfx;

    Result := m_pDS.CreateSoundBuffer(dsbd, pDSBuffer, nil);
    if FAILED(Result) then
    begin
      // If wave format isn't then it will return
      // either DSERR_BADFORMAT or E_INVALIDARG
      if (Result = DSERR_BADFORMAT) or (Result = E_INVALIDARG) then
      begin
        DXUT_ERR('CreateSoundBuffer', Result, UnitName, $FFFFFFFF);
        Exit;
      end;

      DXUT_ERR('CreateSoundBuffer', Result, UnitName, $FFFFFFFF);
      Exit;
      //todo: really strange code above
    end;

    // Create the notification events, so that we know when to fill
    // the buffer as the sound plays.
    Result := pDSBuffer.QueryInterface(IID_IDirectSoundNotify, pDSNotify);
    if FAILED(Result) then
    begin
      DXUT_ERR('QueryInterface', Result, UnitName, $FFFFFFFF);
      Exit;
    end;

    GetMem(aPosNotify, SizeOf(TDSBPositionNotify)*dwNotifyCount);
    try
      for i := 0 to dwNotifyCount - 1 do
      begin
        aPosNotify[i].dwOffset     := (dwNotifySize * DWORD(i)) + dwNotifySize - 1;
        aPosNotify[i].hEventNotify := hNotifyEvent;
      end;

      // Tell DirectSound when to notify us. The notification will come in the from
      // of signaled events that are handled in WinMain()
      Result := pDSNotify.SetNotificationPositions(dwNotifyCount, @aPosNotify[0]);
      if FAILED(Result) then
      begin
        DXUT_ERR('SetNotificationPositions', Result, UnitName, $FFFFFFFF);
        Exit;
      end;
    finally
      pDSNotify := nil;
      FreeMem(aPosNotify);
    end;

    // Create the sound
    ppStreamingSound := CStreamingSound.Create(pDSBuffer, dwDSBufferSize, pWaveFile, dwNotifySize);

    Result:= S_OK;
  except
    on EOutOfMemory do
    begin
      Result:= E_OUTOFMEMORY;
      Exit;
    end;
  end;
end;



{ CSound }

//-----------------------------------------------------------------------------
// Name: CSound::CSound()
// Desc: Constructs the class
//-----------------------------------------------------------------------------
constructor CSound.Create(apDSBuffer: PAIDirectSoundBuffer; dwDSBufferSize,
  dwNumBuffers: DWORD; pWaveFile: CWaveFile; dwCreationFlags: DWORD);
var
  i: Integer;
begin
  GetMem(m_apDSBuffer, SizeOf(IDirectSoundBuffer)*dwNumBuffers);
  // if (nil <> m_apDSBuffer) then
  // memory is always received or exception is raised
  begin
    ZeroMemory(m_apDSBuffer, SizeOf(IDirectSoundBuffer)*dwNumBuffers);
    for i:= 0 to dwNumBuffers - 1 do
      m_apDSBuffer[i] := apDSBuffer[i];

    m_dwDSBufferSize  := dwDSBufferSize;
    m_dwNumBuffers    := dwNumBuffers;
    m_pWaveFile       := pWaveFile;
    m_dwCreationFlags := dwCreationFlags;

    FillBufferWithSound(m_apDSBuffer[0], False);
  end;
end;


//-----------------------------------------------------------------------------
// Name: CSound::~CSound()
// Desc: Destroys the class
//-----------------------------------------------------------------------------
destructor CSound.Destroy;
var
  i: Integer;
begin
  for i:= 0 to m_dwNumBuffers - 1 do SAFE_RELEASE(m_apDSBuffer[i]);
  FreeMem(m_apDSBuffer);
  SAFE_DELETE(m_pWaveFile);

  inherited;
end;


//-----------------------------------------------------------------------------
// Name: CSound::FillBufferWithSound()
// Desc: Fills a DirectSound buffer with a sound file
//-----------------------------------------------------------------------------
function CSound.FillBufferWithSound(pDSB: IDirectSoundBuffer;
  bRepeatWavIfBufferLarger: BOOL): HRESULT;
var
  pDSLockedBuffer: Pointer;     // Pointer to locked buffer memory
  dwDSLockedBufferSize: DWORD;  // Size of the locked DirectSound buffer
  dwWavDataRead: DWORD;         // Amount of data read from the wav file
  dwReadSoFar: DWORD;
begin
  pDSLockedBuffer      := nil;
  dwDSLockedBufferSize := 0;
  dwWavDataRead        := 0;

  if (pDSB = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  // Make sure we have focus, and we didn't just switch in from
  // an app which had a DirectSound device
  Result := RestoreBuffer(pDSB, nil);
  if FAILED(Result) then
  begin
    DXUT_ERR('RestoreBuffer', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Lock the buffer down
  Result := pDSB.Lock(0, m_dwDSBufferSize,
                      @pDSLockedBuffer, @dwDSLockedBufferSize, nil, nil, 0);
  if FAILED(Result) then
  begin
    DXUT_ERR('Lock', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Reset the wave file to the beginning
  m_pWaveFile.ResetFile;

  Result := m_pWaveFile.Read(pDSLockedBuffer,
                             dwDSLockedBufferSize,
                             @dwWavDataRead);
  if FAILED(Result) then
  begin
    DXUT_ERR('Read', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  if (dwWavDataRead = 0) then
  begin
    // Wav is blank, so just fill with silence
    FillMemory(pDSLockedBuffer, dwDSLockedBufferSize, FillValuesStaticA[(m_pWaveFile.m_pwfx.wBitsPerSample = 8)]);
  end
  else if (dwWavDataRead < dwDSLockedBufferSize) then
  begin
    // If the wav file was smaller than the DirectSound buffer,
    // we need to fill the remainder of the buffer with data
    if (bRepeatWavIfBufferLarger) then
    begin
      // Reset the file and fill the buffer with wav data
      dwReadSoFar := dwWavDataRead;    // From previous call above.
      while (dwReadSoFar < dwDSLockedBufferSize) do
      begin
        // This will keep reading in until the buffer is full
        // for very short files
        Result := m_pWaveFile.ResetFile;
        if FAILED(Result) then
        begin
          DXUT_ERR('ResetFile', Result, UnitName, $FFFFFFFF);
          Exit;
        end;

        Result := m_pWaveFile.Read(Pointer(DWORD(pDSLockedBuffer) + dwReadSoFar),
                                   dwDSLockedBufferSize - dwReadSoFar,
                                   @dwWavDataRead);
        if FAILED(Result) then
        begin
          DXUT_ERR('Read', Result, UnitName, $FFFFFFFF);
          Exit;
        end;

        dwReadSoFar := dwReadSoFar + dwWavDataRead;
      end;
    end else
    begin
      // Don't repeat the wav file, just fill in silence
      FillMemory(Pointer(DWORD(pDSLockedBuffer) + dwWavDataRead),
                 dwDSLockedBufferSize - dwWavDataRead,
                 FillValuesStaticA[m_pWaveFile.m_pwfx.wBitsPerSample = 8]);
    end;
  end;

  // Unlock the buffer, we don't need it anymore.
  pDSB.Unlock(pDSLockedBuffer, dwDSLockedBufferSize, nil, 0);

  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
// Name: CSound::RestoreBuffer()
// Desc: Restores the lost buffer. *pbWasRestored returns TRUE if the buffer was
//       restored.  It can also NULL if the information is not needed.
//-----------------------------------------------------------------------------
function CSound.RestoreBuffer(pDSB: IDirectSoundBuffer; pbWasRestored: PBOOL): HRESULT;
var
  dwStatus: DWORD;
begin
  if (pDSB = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  if Assigned(pbWasRestored) then pbWasRestored^ := False;

  Result := pDSB.GetStatus(dwStatus);
  if FAILED(Result) then
  begin
    DXUT_ERR('GetStatus', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  if (dwStatus and DSBSTATUS_BUFFERLOST <> 0) then
  begin
    // Since the app could have just been activated, then
    // DirectSound may not be giving us control yet, so
    // the restoring the buffer may fail.
    // If it does, sleep until DirectSound gives us control.
    Result := pDSB.Restore;
    while (Result = DSERR_BUFFERLOST) do
    begin
      Sleep(10);
      Result := pDSB.Restore;
    end;

    if Assigned(pbWasRestored) then pbWasRestored^ := True;

    Result:= S_OK;
  end else
  begin
    Result:= S_FALSE;
  end;
end;


//-----------------------------------------------------------------------------
// Name: CSound::GetFreeBuffer()
// Desc: Finding the first buffer that is not playing and return a pointer to
//       it, or if all are playing return a pointer to a randomly selected buffer.
//-----------------------------------------------------------------------------
function CSound.GetFreeBuffer: IDirectSoundBuffer;
const
  RAND_MAX = $7FFF;
var
  i: Integer;
  dwStatus: DWORD;
begin
  Result:= nil;
  if (m_apDSBuffer = nil) then Exit;

  for i:= 0 to m_dwNumBuffers - 1 do
  begin
    if (m_apDSBuffer[i] <> nil) then
    begin
      dwStatus := 0;
      m_apDSBuffer[i].GetStatus(dwStatus);
      if ((dwStatus and DSBSTATUS_PLAYING ) = 0) then Break;
    end;
  end;

  if (i <> Integer(m_dwNumBuffers)) then  Result:= m_apDSBuffer[i]
  else Result:= m_apDSBuffer[Random(RAND_MAX) mod Integer(m_dwNumBuffers)];
end;


//-----------------------------------------------------------------------------
// Name: CSound::GetBuffer()
// Desc:
//-----------------------------------------------------------------------------
function CSound.GetBuffer(dwIndex: DWORD): IDirectSoundBuffer;
begin
  Result:= nil;
  if (m_apDSBuffer = nil) then Exit;
  if (dwIndex >= m_dwNumBuffers) then Exit;

  Result:= m_apDSBuffer^[dwIndex];
end;


//-----------------------------------------------------------------------------
// Name: CSound::Get3DBufferInterface()
// Desc:
//-----------------------------------------------------------------------------
function CSound.Get3DBufferInterface(dwIndex: DWORD;
  out ppDS3DBuffer: IDirectSound3DBuffer): HRESULT;
begin
  if (m_apDSBuffer = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  if (dwIndex >= m_dwNumBuffers) then
  begin
    Result:= E_INVALIDARG;
    Exit;
  end;

  ppDS3DBuffer := nil;

  Result:= m_apDSBuffer[dwIndex].QueryInterface(IID_IDirectSound3DBuffer, ppDS3DBuffer);
end;


//-----------------------------------------------------------------------------
// Name: CSound::Play()
// Desc: Plays the sound using voice management flags.  Pass in DSBPLAY_LOOPING
//       in the dwFlags to loop the sound
//-----------------------------------------------------------------------------
function CSound.Play(dwPriority, dwFlags: DWORD; lVolume, lFrequency,
  lPan: Integer): HRESULT;
var
  bRestored: BOOL;
  pDSB: IDirectSoundBuffer;
begin
  if (m_apDSBuffer = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  pDSB := GetFreeBuffer;
  if (pDSB = nil) then
  begin
    Result:= DXUT_ERR('GetFreeBuffer', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Restore the buffer if it was lost
  Result := RestoreBuffer(pDSB, @bRestored);
  if FAILED(Result) then
  begin
    DXUT_ERR('RestoreBuffer', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  if (bRestored) then
  begin
    // The buffer was restored, so we need to fill it with new data
    Result := FillBufferWithSound(pDSB, False);
    if FAILED(Result) then
    begin
      DXUT_ERR('FillBufferWithSound', Result, UnitName, $FFFFFFFF);
      Exit;
    end;
  end;

  if (m_dwCreationFlags and DSBCAPS_CTRLVOLUME <> 0) then
  begin
    pDSB.SetVolume(lVolume);
  end;

  if (lFrequency <> -1) and
     (m_dwCreationFlags and DSBCAPS_CTRLFREQUENCY <> 0) then
  begin
    pDSB.SetFrequency(lFrequency);
  end;

  if (m_dwCreationFlags and DSBCAPS_CTRLPAN <> 0) then
  begin
    pDSB.SetPan(lPan);
  end;

  Result:= pDSB.Play(0, dwPriority, dwFlags);
end;


//-----------------------------------------------------------------------------
// Name: CSound::Play3D()
// Desc: Plays the sound using voice management flags.  Pass in DSBPLAY_LOOPING
//       in the dwFlags to loop the sound
//-----------------------------------------------------------------------------
function CSound.Play3D(const p3DBuffer: TDS3DBuffer; dwPriority, dwFlags: DWORD;
  lFrequency: Integer): HRESULT;
var
  bRestored: BOOL;
  dwBaseFrequency: DWORD;
  pDSB: IDirectSoundBuffer;
  pDS3DBuffer: IDirectSound3DBuffer;
begin
  if (m_apDSBuffer = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  pDSB := GetFreeBuffer;
  if (pDSB = nil) then
  begin
    Result:= DXUT_ERR('GetFreeBuffer', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Restore the buffer if it was lost
  Result := RestoreBuffer(pDSB, @bRestored);
  if FAILED(Result) then
  begin
    DXUT_ERR('RestoreBuffer', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  if (bRestored) then
  begin
    // The buffer was restored, so we need to fill it with new data
    Result := FillBufferWithSound(pDSB, False);
    if FAILED(Result) then
    begin
      DXUT_ERR('FillBufferWithSound', Result, UnitName, $FFFFFFFF);
      Exit;
    end;
  end;

  if (m_dwCreationFlags and DSBCAPS_CTRLFREQUENCY <> 0) then
  begin
    pDSB.GetFrequency(dwBaseFrequency);
    pDSB.SetFrequency(dwBaseFrequency + DWORD(lFrequency));
  end;

  // QI for the 3D buffer
  Result := pDSB.QueryInterface(IID_IDirectSound3DBuffer, pDS3DBuffer);
  if SUCCEEDED(Result) then
  begin
    Result := pDS3DBuffer.SetAllParameters(p3DBuffer, DS3D_IMMEDIATE);
    if SUCCEEDED(Result) then
    begin
      Result := pDSB.Play(0, dwPriority, dwFlags);
    end;

    pDS3DBuffer := nil;
  end;
end;


//-----------------------------------------------------------------------------
// Name: CSound::Stop()
// Desc: Stops the sound from playing
//-----------------------------------------------------------------------------
function CSound.Stop: HRESULT;
var
  i: Integer;
begin
  if (m_apDSBuffer = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  Result := 0;

  for i:= 0 to m_dwNumBuffers - 1 do
    Result:= Result or m_apDSBuffer[i].Stop;
end;


//-----------------------------------------------------------------------------
// Name: CSound::Reset()
// Desc: Reset all of the sound buffers
//-----------------------------------------------------------------------------
function CSound.Reset: HRESULT;
var
  i: Integer;
begin
  if (m_apDSBuffer = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  Result := 0;
  
  for i:= 0 to m_dwNumBuffers - 1 do
    Result:= Result or m_apDSBuffer[i].SetCurrentPosition(0);
end;


//-----------------------------------------------------------------------------
// Name: CSound::IsSoundPlaying()
// Desc: Checks to see if a buffer is playing and returns TRUE if it is.
//-----------------------------------------------------------------------------
function CSound.IsSoundPlaying: BOOL;
var
  i: Integer;
  bIsPlaying: BOOL;
  dwStatus: DWORD;
begin
  bIsPlaying := False;

  if (m_apDSBuffer = nil) then
  begin
    Result:= False;
    Exit;
  end;

  for i:= 0 to m_dwNumBuffers - 1 do
  begin
    if Assigned(m_apDSBuffer[i]) then
    begin
      dwStatus := 0;
      m_apDSBuffer[i].GetStatus(dwStatus);
      bIsPlaying := bIsPlaying or (dwStatus and DSBSTATUS_PLAYING <> 0);
    end;
  end;

  Result:= bIsPlaying;
end;




{ CStreamingSound }

//-----------------------------------------------------------------------------
// Name: CStreamingSound::CStreamingSound()
// Desc: Setups up a buffer so data can be streamed from the wave file into
//       a buffer.  This is very useful for large wav files that would take a
//       while to load.  The buffer is initially filled with data, then
//       as sound is played the notification events are signaled and more data
//       is written into the buffer by calling HandleWaveStreamNotification()
//-----------------------------------------------------------------------------
constructor CStreamingSound.Create(pDSBuffer: IDirectSoundBuffer;
  dwDSBufferSize: DWORD; pWaveFile: CWaveFile; dwNotifySize: DWORD);
begin
  inherited Create(@pDSBuffer, dwDSBufferSize, 1, pWaveFile, 0);

  m_dwLastPlayPos     := 0;
  m_dwPlayProgress    := 0;
  m_dwNotifySize      := dwNotifySize;
  m_dwNextWriteOffset := 0;
  m_bFillNextNotificationWithSilence := False;
end;


//-----------------------------------------------------------------------------
// Name: CStreamingSound::~CStreamingSound()
// Desc: Destroys the class
//-----------------------------------------------------------------------------
destructor CStreamingSound.Destroy;
begin
  inherited;
end;


//-----------------------------------------------------------------------------
// Name: CStreamingSound::HandleWaveStreamNotification()
// Desc: Handle the notification that tells us to put more wav data in the 
//       circular buffer
//-----------------------------------------------------------------------------
function CStreamingSound.HandleWaveStreamNotification(bLoopedPlay: BOOL): HRESULT;
var
  dwCurrentPlayPos: DWORD;
  dwPlayDelta: DWORD;
  dwBytesWrittenToBuffer: DWORD;
  pDSLockedBuffer: Pointer;
  pDSLockedBuffer2: Pointer;
  dwDSLockedBufferSize: DWORD;
  dwDSLockedBufferSize2: DWORD;
  bRestored: BOOL;
  dwReadSoFar: DWORD;
begin
  pDSLockedBuffer := nil;
  pDSLockedBuffer2 := nil;

  if (m_apDSBuffer = nil) or (m_pWaveFile = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  // Restore the buffer if it was lost
  Result := RestoreBuffer(m_apDSBuffer[0], @bRestored);
  if FAILED(Result) then
  begin
    DXUT_ERR('RestoreBuffer', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  if (bRestored) then
  begin
    // The buffer was restored, so we need to fill it with new data
    Result := FillBufferWithSound(m_apDSBuffer[0], False);
    if FAILED(Result) then
    begin
      DXUT_ERR('FillBufferWithSound', Result, UnitName, $FFFFFFFF);
    end else Result:= S_OK;
    Exit;
  end;

  // Lock the DirectSound buffer
  Result := m_apDSBuffer[0].Lock(m_dwNextWriteOffset, m_dwNotifySize,
                                 @pDSLockedBuffer, @dwDSLockedBufferSize,
                                 @pDSLockedBuffer2, @dwDSLockedBufferSize2, 0);
  if FAILED(Result) then
  begin
    DXUT_ERR('Lock', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  // m_dwDSBufferSize and m_dwNextWriteOffset are both multiples of m_dwNotifySize,
  // it should the second buffer, so it should never be valid
  if (pDSLockedBuffer2 <> nil) then
  begin
    Result:= E_UNEXPECTED;
    Exit;
  end;

  if (not m_bFillNextNotificationWithSilence) then
  begin
    // Fill the DirectSound buffer with wav data
    Result := m_pWaveFile.Read(pDSLockedBuffer,
                               dwDSLockedBufferSize,
                               @dwBytesWrittenToBuffer);
    if FAILED(Result) then
    begin
      DXUT_ERR('Read', Result, UnitName, $FFFFFFFF);
      Exit;
    end;
  end else
  begin
    // Fill the DirectSound buffer with silence
    FillMemory(pDSLockedBuffer, dwDSLockedBufferSize,
               FillValuesStaticA[m_pWaveFile.m_pwfx.wBitsPerSample = 8]);
    dwBytesWrittenToBuffer := dwDSLockedBufferSize;
  end;

  // If the number of bytes written is less than the
  // amount we requested, we have a short file.
  if (dwBytesWrittenToBuffer < dwDSLockedBufferSize) then
  begin
    if (not bLoopedPlay) then
    begin
      // Fill in silence for the rest of the buffer.
      FillMemory(Pointer(DWORD(pDSLockedBuffer) + dwBytesWrittenToBuffer),
                 dwDSLockedBufferSize - dwBytesWrittenToBuffer,
                 FillValuesStaticA[m_pWaveFile.m_pwfx.wBitsPerSample = 8]);

      // Any future notifications should just fill the buffer with silence
      m_bFillNextNotificationWithSilence := True;
    end else
    begin
      // We are looping, so reset the file and fill the buffer with wav data
      dwReadSoFar := dwBytesWrittenToBuffer;    // From previous call above.
      while (dwReadSoFar < dwDSLockedBufferSize) do
      begin
        // This will keep reading in until the buffer is full (for very short files).
        Result := m_pWaveFile.ResetFile;
        if FAILED(Result) then
        begin
          DXUT_ERR('ResetFile', Result, UnitName, $FFFFFFFF);
          Exit;
        end;

        Result := m_pWaveFile.Read(Pointer(DWORD(pDSLockedBuffer) + dwReadSoFar),
                                   dwDSLockedBufferSize - dwReadSoFar,
                                   @dwBytesWrittenToBuffer);
        if FAILED(Result) then
        begin
          DXUT_ERR('Read', Result, UnitName, $FFFFFFFF);
          Exit;
        end;

        dwReadSoFar := dwReadSoFar + dwBytesWrittenToBuffer;
      end;
    end;
  end;

  // Unlock the DirectSound buffer
  m_apDSBuffer[0].Unlock(pDSLockedBuffer, dwDSLockedBufferSize, nil, 0);

  // Figure out how much data has been played so far.  When we have played
  // past the end of the file, we will either need to start filling the
  // buffer with silence or starting reading from the beginning of the file,
  // depending if the user wants to loop the sound
  Result := m_apDSBuffer[0].GetCurrentPosition(@dwCurrentPlayPos, nil);
  if FAILED(Result) then
  begin
    DXUT_ERR('GetCurrentPosition', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Check to see if the position counter looped
  if (dwCurrentPlayPos < m_dwLastPlayPos)
  then dwPlayDelta := (m_dwDSBufferSize - m_dwLastPlayPos) + dwCurrentPlayPos
  else dwPlayDelta := dwCurrentPlayPos - m_dwLastPlayPos;

  m_dwPlayProgress := m_dwPlayProgress + dwPlayDelta;
  m_dwLastPlayPos := dwCurrentPlayPos;

  // If we are now filling the buffer with silence, then we have found the end so 
  // check to see if the entire sound has played, if it has then stop the buffer.
  if (m_bFillNextNotificationWithSilence) then
  begin
    // We don't want to cut off the sound before it's done playing.
    if (m_dwPlayProgress >= m_pWaveFile.GetSize) then
    begin
      m_apDSBuffer[0].Stop;
    end;
  end;

  // Update where the buffer will lock (for next time)
  m_dwNextWriteOffset := m_dwNextWriteOffset + dwDSLockedBufferSize;
  m_dwNextWriteOffset := m_dwNextWriteOffset mod m_dwDSBufferSize; // Circular buffer

  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
// Name: CStreamingSound::Reset()
// Desc: Resets the sound so it will begin playing at the beginning
//-----------------------------------------------------------------------------
function CStreamingSound.Reset: HRESULT;
var
  bRestored: BOOL;
begin
  if (m_apDSBuffer[0] = nil) or (m_pWaveFile = nil) then
  begin
    Result:= CO_E_NOTINITIALIZED;
    Exit;
  end;

  m_dwLastPlayPos     := 0;
  m_dwPlayProgress    := 0;
  m_dwNextWriteOffset := 0;
  m_bFillNextNotificationWithSilence := False;

  // Restore the buffer if it was lost
  Result := RestoreBuffer(m_apDSBuffer[0], @bRestored);
  if FAILED(Result) then
  begin
    DXUT_ERR('RestoreBuffer', Result, UnitName, $FFFFFFFF);
    Exit;
  end;

  if (bRestored) then
  begin
    // The buffer was restored, so we need to fill it with new data
    Result := FillBufferWithSound(m_apDSBuffer[0], False);
    if FAILED(Result) then
    begin
      DXUT_ERR('FillBufferWithSound', Result, UnitName, $FFFFFFFF);
    end else Result:= S_OK;
    Exit;
  end;

  m_pWaveFile.ResetFile;

  Result:= m_apDSBuffer[0].SetCurrentPosition(0);
end;


function mmioFOURCC(ch0, ch1, ch2, ch3: Char): DWord;
begin
  Result:= Byte(ch0) or (Byte(ch1) shl 8) or (Byte(ch2) shl 16) or (Byte(ch3) shl 24 );
end;


{ CWaveFile }

//-----------------------------------------------------------------------------
// Name: CWaveFile::CWaveFile()
// Desc: Constructs the class.  Call Open() to open a wave file for reading.
//       Then call Read() as needed.  Calling the destructor or Close()
//       will close the file.
//-----------------------------------------------------------------------------
constructor CWaveFile.Create;
begin
  m_pwfx    := nil;
  m_hmmio   := 0;
  m_pResourceBuffer := nil;
  m_dwSize  := 0;
  m_bIsReadingFromMemory := False;
end;


//-----------------------------------------------------------------------------
// Name: CWaveFile::~CWaveFile()
// Desc: Destructs the class
//-----------------------------------------------------------------------------
destructor CWaveFile.Destroy;
begin
  Close;

  if (not m_bIsReadingFromMemory) then FreeMem(m_pwfx);

  inherited;
end;


//-----------------------------------------------------------------------------
// Name: CWaveFile::Open()
// Desc: Opens a wave file for reading
//-----------------------------------------------------------------------------
function CWaveFile.Open(strFileName: PWideChar; pwfx: PWaveFormatEx;
  dwFlags: DWORD): HRESULT;
var
  hResInfo: HRSRC;
  hResData: HGLOBAL;
  dwSize:   DWORD;
  pvRes:    Pointer;
  mmioInfo: TMMIOInfo;
begin
  m_dwFlags := dwFlags;
  m_bIsReadingFromMemory := False;

  if (m_dwFlags = WAVEFILE_READ) then
  begin
    if (strFileName = nil) then
    begin
      Result:= E_INVALIDARG;
      Exit;
    end;
    FreeMem(m_pwfx);

    m_hmmio := mmioOpenW(strFileName, nil, MMIO_ALLOCBUF or MMIO_READ);

    if (0 = m_hmmio) then
    begin
      // Loading it as a file failed, so try it as a resource
      hResInfo := FindResourceW(0, strFileName, 'WAVE');
      if (hResInfo = 0) then
      begin
        hResInfo := FindResourceW(0, strFileName, 'WAV');
        if (hResInfo = 0) then
        begin
          Result:= DXUT_ERR('FindResource', E_FAIL, UnitName, $FFFFFFFF);
          Exit;
        end;
      end;

      hResData := LoadResource(0, hResInfo);
      if (hResData = 0) then
      begin
        Result:= DXUT_ERR('LoadResource', E_FAIL, UnitName, $FFFFFFFF);
        Exit;
      end;

      dwSize := SizeofResource(0, hResInfo);
      if (dwSize = 0) then
      begin
        Result:= DXUT_ERR('SizeofResource', E_FAIL, UnitName, $FFFFFFFF);
        Exit;
      end;

      pvRes := LockResource(hResData);
      if (pvRes = nil) then
      begin
        Result:= DXUT_ERR('LockResource', E_FAIL, UnitName, $FFFFFFFF);
        Exit;
      end;

      try
        GetMem(m_pResourceBuffer, SizeOf(Char)*dwSize);
      except
        on EOutOfMemory do
        begin
          Result:= DXUT_ERR('GetMem', E_OUTOFMEMORY, UnitName, $FFFFFFFF);
          Exit;
        end;
      end;
      Move(pvRes^, m_pResourceBuffer^, dwSize);

      ZeroMemory(@mmioInfo, SizeOf(mmioInfo));
      mmioInfo.fccIOProc := FOURCC_MEM;
      mmioInfo.cchBuffer := dwSize;
      mmioInfo.pchBuffer := m_pResourceBuffer;

      m_hmmio := mmioOpen(nil, @mmioInfo, MMIO_ALLOCBUF or MMIO_READ);
    end;

    Result := ReadMMIO;
    if FAILED(Result) then
    begin
      // ReadMMIO will fail if its an not a wave file
      mmioClose(m_hmmio, 0);
      DXUT_ERR('ReadMMIO', Result, UnitName, $FFFFFFFF);
      Exit;
    end;

    Result := ResetFile;
    if FAILED(Result) then
    begin
      DXUT_ERR('ResetFile', Result, UnitName, $FFFFFFFF);
      Exit;
    end;

    // After the reset, the size of the wav file is m_ck.cksize so store it now
    m_dwSize := m_ck.cksize;
  end else
  begin
    m_hmmio := mmioOpenW(strFileName, nil, MMIO_ALLOCBUF or
                                           MMIO_READWRITE or
                                           MMIO_CREATE);
    if (0 = m_hmmio) then
    begin
      Result:= DXUT_ERR('mmioOpen', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;

    Result := WriteMMIO(pwfx);
    if FAILED(Result) then
    begin
      DXUT_ERR('WriteMMIO', Result, UnitName, $FFFFFFFF);
      Exit;
    end;

    Result := ResetFile;
    if FAILED(Result) then
    begin
      DXUT_ERR('ResetFile', Result, UnitName, $FFFFFFFF);
      Exit;
    end;
  end;
end;


//-----------------------------------------------------------------------------
// Name: CWaveFile::OpenFromMemory()
// Desc: copy data to CWaveFile member variable from memory
//-----------------------------------------------------------------------------
function CWaveFile.OpenFromMemory(pbData: PByte; ulDataSize: Cardinal;
  pwfx: PWaveFormatEx; dwFlags: DWORD): HRESULT;
begin
  m_pwfx       := pwfx;
  m_ulDataSize := ulDataSize;
  m_pbData     := pbData;
  m_pbDataCur  := m_pbData;
  m_bIsReadingFromMemory := True;

  if (dwFlags <> WAVEFILE_READ) then Result:= E_NOTIMPL
  else Result:= S_OK;
end;


//-----------------------------------------------------------------------------
// Name: CWaveFile::ReadMMIO()
// Desc: Support function for reading from a multimedia I/O stream.
//       m_hmmio must be valid before calling.  This function uses it to
//       update m_ckRiff, and m_pwfx.
//-----------------------------------------------------------------------------
function CWaveFile.ReadMMIO: HRESULT;
var
  ckIn:          TMMCKInfo;      // chunk info. for general use.
  pcmWaveFormat: TPCMWaveFormat; // Temp PCM structure to load in.
  cbExtraBytes:  Word;
begin
  m_pwfx := nil;

  if (0 <> mmioDescend(m_hmmio, @m_ckRiff, nil, 0)) then
  begin
    Result:= DXUT_ERR('mmioDescend', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Check to make sure this is a valid wave file
  if (m_ckRiff.ckid <> FOURCC_RIFF) or
     (m_ckRiff.fccType <>  DWORD(Byte('W') or (Byte('A') shl 8) or (Byte('V') shl 16) or (Byte('E') shl 24))) // mmioFOURCC('W', 'A', 'V', 'E'))
   then
  begin
    Result:= DXUT_ERR('mmioFOURCC', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Search the input file for for the 'fmt ' chunk.
  ckIn.ckid := DWORD(Byte('f') or (Byte('m') shl 8) or (Byte('t') shl 16) or (Byte(' ') shl 24)); // mmioFOURCC('f', 'm', 't', ' ');
  if (0 <> mmioDescend(m_hmmio, @ckIn, @m_ckRiff, MMIO_FINDCHUNK)) then
  begin
    Result:= DXUT_ERR('mmioDescend', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Expect the 'fmt' chunk to be at least as large as <PCMWAVEFORMAT>;
  // if there are extra parameters at the end, we'll ignore them
  if (ckIn.cksize < SizeOf(TPCMWaveFormat)) then
  begin
    Result:= DXUT_ERR('sizeof(PCMWAVEFORMAT)', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Read the 'fmt ' chunk into <pcmWaveFormat>.
  if (mmioRead(m_hmmio, @pcmWaveFormat, SizeOf(pcmWaveFormat)) <> SizeOf(pcmWaveFormat)) then
  begin
    Result:= DXUT_ERR('mmioRead', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Allocate the waveformatex, but if its not pcm format, read the next
  // word, and thats how many extra bytes to allocate.
  if (pcmWaveFormat.wf.wFormatTag = WAVE_FORMAT_PCM) then
  begin
{$IFDEF SUPPORTS_EXCEPTIONS}
    try
      GetMem(m_pwfx, SizeOf(TWaveFormatEx));
    except
      on EOutOfMemory do
      begin
        Result:= DXUT_ERR('m_pwfx', E_FAIL, UnitName, $FFFFFFFF);
        Exit;
      end;
      else raise;
    end;
{$ELSE}
    GetMem(m_pwfx, SizeOf(TWaveFormatEx));
    if (m_pwfx = nil) then 
    begin
      Result:= DXUT_ERR('m_pwfx', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;
{$ENDIF}

    // Copy the bytes from the pcm structure to the waveformatex structure
    Move(pcmWaveFormat, m_pwfx^, SizeOf(pcmWaveFormat));
    m_pwfx.cbSize := 0;
  end else
  begin
    // Read in length of extra bytes.
    cbExtraBytes := 0;
    if (mmioRead(m_hmmio, PChar(@cbExtraBytes), SizeOf(Word)) <> SizeOf(Word)) then
    begin
      Result:= DXUT_ERR('mmioRead', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;

{$IFDEF SUPPORTS_EXCEPTIONS}
    try
      GetMem(m_pwfx, SizeOf(TWaveFormatEx) + cbExtraBytes);
    except
      on EOutOfMemory do
      begin
        Result:= DXUT_ERR('new', E_FAIL, UnitName, $FFFFFFFF);
        Exit;
      end;
      else raise;
    end;
{$ELSE}
    GetMem(m_pwfx, SizeOf(TWaveFormatEx) + cbExtraBytes);
    if (m_pwfx = nil) then
    begin
      Result:= DXUT_ERR('new', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;
{$ENDIF}

    // Copy the bytes from the pcm structure to the waveformatex structure
    Move(pcmWaveFormat, m_pwfx^, SizeOf(pcmWaveFormat));
    m_pwfx.cbSize := cbExtraBytes;

    // Now, read those extra bytes into the structure, if cbExtraAlloc != 0.
    if (mmioRead(m_hmmio, PChar(Pointer(Integer(@(m_pwfx.cbSize))+SizeOf(Word))), 
          cbExtraBytes ) <> cbExtraBytes) then
    begin
      FreeMem(m_pwfx);
      Result:= DXUT_ERR('mmioRead', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;
  end;

  // Ascend the input file out of the 'fmt ' chunk.
  if (0 <> mmioAscend(m_hmmio, @ckIn, 0)) then
  begin
    SAFE_DELETE(m_pwfx);
    Result:= DXUT_ERR('mmioAscend', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
// Name: CWaveFile::GetSize()
// Desc: Retuns the size of the read access wave file
//-----------------------------------------------------------------------------
function CWaveFile.GetSize: DWORD;
begin
  Result:= m_dwSize;
end;


//-----------------------------------------------------------------------------
// Name: CWaveFile::ResetFile()
// Desc: Resets the internal m_ck pointer so reading starts from the
//       beginning of the file again
//-----------------------------------------------------------------------------
function CWaveFile.ResetFile: HRESULT;
begin
  if (m_bIsReadingFromMemory) then
  begin
    m_pbDataCur := m_pbData;
  end else
  begin
    if (m_hmmio = 0) then
    begin
      Result:= CO_E_NOTINITIALIZED;
      Exit;
    end;

    if (m_dwFlags = WAVEFILE_READ) then
    begin
      // Seek to the data
      if (-1 = mmioSeek(m_hmmio, m_ckRiff.dwDataOffset + SizeOf(FOURCC), SEEK_SET)) then
      begin
        Result:= DXUT_ERR('mmioSeek', E_FAIL, UnitName, $FFFFFFFF);
        Exit;
      end;

      // Search the input file for the 'data' chunk.
      m_ck.ckid := mmioFOURCC('d', 'a', 't', 'a');
      if (0 <> mmioDescend(m_hmmio, @m_ck, @m_ckRiff, MMIO_FINDCHUNK)) then
      begin
        Result:= DXUT_ERR('mmioDescend', E_FAIL, UnitName, $FFFFFFFF);
        Exit;
      end;
    end else
    begin
      // Create the 'data' chunk that holds the waveform samples.
      m_ck.ckid := mmioFOURCC('d', 'a', 't', 'a');
      m_ck.cksize := 0;

      if (0 <> mmioCreateChunk(m_hmmio, @m_ck, 0)) then
      begin
        Result:= DXUT_ERR('mmioCreateChunk', E_FAIL, UnitName, $FFFFFFFF);
        Exit;
      end;

      if (0 <> mmioGetInfo(m_hmmio, @m_mmioinfoOut, 0)) then
      begin
        Result:= DXUT_ERR('mmioGetInfo', E_FAIL, UnitName, $FFFFFFFF);
        Exit;
      end;
    end;
  end;

  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
// Name: CWaveFile::Read()
// Desc: Reads section of data from a wave file into pBuffer and returns 
//       how much read in pdwSizeRead, reading not more than dwSizeToRead.
//       This uses m_ck to determine where to start reading from.  So 
//       subsequent calls will be continue where the last left off unless 
//       Reset() is called.
//-----------------------------------------------------------------------------
function CWaveFile.Read(pBuffer: PByte; dwSizeToRead: DWORD;
  pdwSizeRead: PDWORD): HRESULT;
var
  mmioinfoIn: TMMIOInfo; // current status of m_hmmio
  cbDataIn: LongWord;
  cT: Integer;
begin
  if (m_bIsReadingFromMemory) then
  begin
    if (m_pbDataCur = nil) then
    begin
      Result:= CO_E_NOTINITIALIZED;
      Exit;
    end;
    if (pdwSizeRead <> nil) then pdwSizeRead^ := 0;

    if (DWORD(m_pbDataCur) + dwSizeToRead) >
       (DWORD(m_pbData) + m_ulDataSize) then
    begin
      dwSizeToRead := m_ulDataSize - (DWORD(m_pbDataCur) - DWORD(m_pbData));
    end;

    CopyMemory(pBuffer, m_pbDataCur, dwSizeToRead);

    if (pdwSizeRead <> nil) then pdwSizeRead^ := dwSizeToRead;
  end else
  begin
    if (m_hmmio = 0) then
    begin
      Result:= CO_E_NOTINITIALIZED;
      Exit;
    end;
    if (pBuffer = nil) or (pdwSizeRead = nil) then
    begin
      Result:= E_INVALIDARG;
      Exit;
    end;

    if (pdwSizeRead <> nil) then pdwSizeRead^ := 0;

    if (0 <> mmioGetInfo(m_hmmio, @mmioinfoIn, 0)) then
    begin
      Result:= DXUT_ERR('mmioGetInfo', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;

    cbDataIn := dwSizeToRead;
    if (cbDataIn > m_ck.cksize) then cbDataIn := m_ck.cksize;

    m_ck.cksize := m_ck.cksize - cbDataIn;

    for cT := 0 to cbDataIn - 1 do
    begin
      // Copy the bytes from the io to the buffer.
      if (mmioinfoIn.pchNext = mmioinfoIn.pchEndRead) then
      begin
        if (0 <> mmioAdvance(m_hmmio, @mmioinfoIn, MMIO_READ)) then
        begin
          Result:= DXUT_ERR('mmioAdvance', E_FAIL, UnitName, $FFFFFFFF);
          Exit;
        end;

        if (mmioinfoIn.pchNext = mmioinfoIn.pchEndRead) then 
        begin
          Result:= DXUT_ERR('mmioinfoIn.pchNext', E_FAIL, UnitName, $FFFFFFFF);
          Exit;
        end;
      end;

      // Actual copy.
      //*((BYTE*)pBuffer+cT) = *((BYTE*)mmioinfoIn.pchNext);
      PByte(Integer(pBuffer)+cT)^ := PByte(mmioinfoIn.pchNext)^;
      Inc(mmioinfoIn.pchNext);
    end;

    if (0 <> mmioSetInfo(m_hmmio, @mmioinfoIn, 0)) then
    begin
      Result:= DXUT_ERR('mmioSetInfo', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;

    if (pdwSizeRead <> nil) then pdwSizeRead^ := cbDataIn;
  end;
  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
// Name: CWaveFile::Close()
// Desc: Closes the wave file
//-----------------------------------------------------------------------------
function CWaveFile.Close: HRESULT;
var
  dwSamples: DWORD;
begin
  if (m_dwFlags = WAVEFILE_READ) then
  begin
    mmioClose(m_hmmio, 0);
    m_hmmio := 0;
    FreeMem(m_pResourceBuffer);
  end else
  begin
    m_mmioinfoOut.dwFlags := m_mmioinfoOut.dwFlags or MMIO_DIRTY;

    if (m_hmmio = 0) then
    begin
      Result:= CO_E_NOTINITIALIZED;
      Exit;
    end;

    if (0 <> mmioSetInfo( m_hmmio, @m_mmioinfoOut, 0)) then
    begin
      Result:= DXUT_ERR('mmioSetInfo', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;

    // Ascend the output file out of the 'data' chunk -- this will cause
    // the chunk size of the 'data' chunk to be written.
    if (0 <> mmioAscend(m_hmmio, @m_ck, 0)) then 
    begin
      Result:= DXUT_ERR('mmioAscend', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;

    // Do this here instead...
    if (0 <> mmioAscend(m_hmmio, @m_ckRiff, 0)) then
    begin
      Result:= DXUT_ERR('mmioAscend', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;

    mmioSeek(m_hmmio, 0, SEEK_SET);

    if (0 <> mmioDescend(m_hmmio, @m_ckRiff, nil, 0)) then
    begin
      Result:= DXUT_ERR('mmioDescend', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;

    m_ck.ckid := mmioFOURCC('f', 'a', 'c', 't');

    if (0 = mmioDescend(m_hmmio, @m_ck, @m_ckRiff, MMIO_FINDCHUNK)) then
    begin
      dwSamples := 0;
      mmioWrite(m_hmmio, PChar(@dwSamples), SizeOf(DWORD));
      mmioAscend(m_hmmio, @m_ck, 0);
    end;

    // Ascend the output file out of the 'RIFF' chunk -- this will cause
    // the chunk size of the 'RIFF' chunk to be written.
    if (0 <> mmioAscend( m_hmmio, @m_ckRiff, 0)) then
    begin
      Result:= DXUT_ERR('mmioAscend', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;

    mmioClose(m_hmmio, 0);
    m_hmmio := 0;
  end;

  Result:= S_OK;
end;



//-----------------------------------------------------------------------------
// Name: CWaveFile::WriteMMIO()
// Desc: Support function for reading from a multimedia I/O stream
//       pwfxDest is the WAVEFORMATEX for this new wave file.
//       m_hmmio must be valid before calling.  This function uses it to
//       update m_ckRiff, and m_ck.
//-----------------------------------------------------------------------------
function CWaveFile.WriteMMIO(pwfxDest: PWaveFormatEx): HRESULT;
var
  dwFactChunk: DWORD; // Contains the actual fact chunk. Garbage until WaveCloseWriteFile.
  ckOut1: MMCKINFO;
begin
  dwFactChunk := DWORD(-1);

  // Create the output file RIFF chunk of form type 'WAVE'.
  m_ckRiff.fccType := mmioFOURCC('W', 'A', 'V', 'E');
  m_ckRiff.cksize := 0;

  if (0 <> mmioCreateChunk(m_hmmio, @m_ckRiff, MMIO_CREATERIFF)) then 
  begin
    Result:= DXUT_ERR('mmioCreateChunk', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  // We are now descended into the 'RIFF' chunk we just created.
  // Now create the 'fmt ' chunk. Since we know the size of this chunk,
  // specify it in the MMCKINFO structure so MMIO doesn't have to seek
  // back and set the chunk size after ascending from the chunk.
  m_ck.ckid := mmioFOURCC('f', 'm', 't', ' ');
  m_ck.cksize := SizeOf(TPCMWaveFormat);

  if (0 <> mmioCreateChunk(m_hmmio, @m_ck, 0)) then
  begin
    Result:= DXUT_ERR('mmioCreateChunk', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Write the PCMWAVEFORMAT structure to the 'fmt ' chunk if its that type.
  if (pwfxDest.wFormatTag = WAVE_FORMAT_PCM) then
  begin
    if (mmioWrite(m_hmmio, PChar(pwfxDest), SizeOf(TPCMWaveFormat)) <> SizeOf(TPCMWaveFormat)) then
    begin
      Result:= DXUT_ERR('mmioWrite', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;
  end else
  begin
    // Write the variable length size.
    if mmioWrite(m_hmmio, PChar(pwfxDest), SizeOf(pwfxDest^) + pwfxDest.cbSize) <>
       (SizeOf(pwfxDest^) + pwfxDest.cbSize) then
    begin
      Result:= DXUT_ERR('mmioWrite', E_FAIL, UnitName, $FFFFFFFF);
      Exit;
    end;
  end;  
    
  // Ascend out of the 'fmt ' chunk, back into the 'RIFF' chunk.
  if (0 <> mmioAscend(m_hmmio, @m_ck, 0)) then
  begin
    Result:= DXUT_ERR('mmioAscend', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Now create the fact chunk, not required for PCM but nice to have.  This is filled
  // in when the close routine is called.
  ckOut1.ckid := mmioFOURCC('f', 'a', 'c', 't');
  ckOut1.cksize := 0;

  if (0 <> mmioCreateChunk(m_hmmio, @ckOut1, 0)) then
  begin
    Result:= DXUT_ERR('mmioCreateChunk', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  if (mmioWrite(m_hmmio, PChar(@dwFactChunk), SizeOf(dwFactChunk)) <> SizeOf(dwFactChunk)) then
  begin
    Result:= DXUT_ERR('mmioWrite', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  // Now ascend out of the fact chunk...
  if (0 <> mmioAscend( m_hmmio, @ckOut1, 0)) then
  begin
    Result:= DXUT_ERR('mmioAscend', E_FAIL, UnitName, $FFFFFFFF);
    Exit;
  end;

  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
// Name: CWaveFile::Write()
// Desc: Writes data to the open wave file
//-----------------------------------------------------------------------------
function CWaveFile.Write(nSizeToWrite: LongWord; pbSrcData: PByte;
  out pnSizeWrote: LongWord): HRESULT;
var
  cT: Integer;
begin
  Result:= S_OK;
  if (m_bIsReadingFromMemory)                  then Result:= E_NOTIMPL;
  if (m_hmmio = 0)                             then Result:= CO_E_NOTINITIALIZED;
  if (@pnSizeWrote = nil) or (pbSrcData = nil) then Result:= E_INVALIDARG;
  if (Result <> S_OK) then Exit;

  pnSizeWrote := 0;

  for cT := 0 to nSizeToWrite - 1 do
  begin
    if (m_mmioinfoOut.pchNext = m_mmioinfoOut.pchEndWrite) then
    begin
      m_mmioinfoOut.dwFlags := m_mmioinfoOut.dwFlags or MMIO_DIRTY;
      if (0 <> mmioAdvance(m_hmmio, @m_mmioinfoOut, MMIO_WRITE)) then
      begin
        Result:= DXUT_ERR('mmioAdvance', E_FAIL, UnitName, $FFFFFFFF);
        Exit;
      end;
    end;

    //*((BYTE*)m_mmioinfoOut.pchNext) = *((BYTE*)pbSrcData+cT);
    PByte(m_mmioinfoOut.pchNext)^ := PByte(Integer(pbSrcData)+cT)^;
    Inc(PByte(m_mmioinfoOut.pchNext));

    Inc(pnSizeWrote);
  end;

  Result:= S_OK;
end;


procedure DXUT_StopSound(s: CSound);
begin
  if Assigned(S) then S.Stop;
end;

procedure DXUT_PlaySound(s: CSound);
begin
  if Assigned(S) then S.Play(0, 0);
end;

procedure DXUT_PlaySoundLooping(s: CSound);
begin
  if Assigned(S) then S.Play(0, DSBPLAY_LOOPING);
end;

end.

