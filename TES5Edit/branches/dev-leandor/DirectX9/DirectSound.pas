{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      dsound.h                                                      *}
{*  Content:    DirectSound include file                                      *}
{*                                                                            *}
{*  DirectX 9.0 Delphi / FreePascal adaptation by Alexey Barkovoy             *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Modified: 14-Apr-2007                                                     *}
{*                                                                            *}
{*  Compatible with :                                                         *}
{*    DirectX 7.0 Object Pascal adaptation by                                 *}
{*      Erik Unger, e-Mail: DelphiDirectX@next-reality.com                    *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://www.clootie.ru                                                   *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
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

{$MINENUMSIZE 4}
{$ALIGN ON}

unit DirectSound;

interface

uses
  Windows, MMSystem, DXTypes;

(*==========================================================================;
 *
 *  Copyright (c) Microsoft Corporation.  All rights reserved.
 *
 *  File:       dsound.h
 *  Content:    DirectSound include file
 *
 **************************************************************************)

////////////////////////////////////////////////////////////////////////
// Global level dynamic loading support

// Remove "dots" below to force some kind of dynamic linking
{.$DEFINE DIRECTSOUND_DYNAMIC_LINK}
{.$DEFINE DIRECTSOUND_DYNAMIC_LINK_EXPLICIT}

////////////////////////////////////////////////////////////////////////
// Assume for what DirectSound version we will compile headers

// Compiling for DirectSound9 by default

////////////////////////////////////////////////////////////////////////
// Emit conditionals to C++Builder compiler
  {$HPPEMIT '#define DIRECTSOUND_VERSION         0x0900'}

(*$HPPEMIT '#include "dsound.h"' *)


////////////////////////////////////////////////////////////////////////
// Define symbols for '<=' comparision


{ Type definitions shared with Direct3D }

type
  D3DVALUE = DXTypes.D3DVALUE;
  {$EXTERNALSYM D3DVALUE}
  TD3DValue = DXTypes.TD3DValue;
  PD3DValue = DXTypes.PD3DValue;

  D3DCOLOR = DXTypes.D3DCOLOR;
  {$EXTERNALSYM D3DCOLOR}
  TD3DColor = DXTypes.TD3DColor;

  _D3DVECTOR = DXTypes._D3DVECTOR;
  {$EXTERNALSYM _D3DVECTOR}
  D3DVECTOR = DXTypes.D3DVECTOR;
  {$EXTERNALSYM D3DVECTOR}
  TD3DVector = DXTypes.TD3DVector;
  PD3DVector = DXTypes.PD3DVector;

const
  _FACDS = $878;                { DirectSound's facility code }
  {$EXTERNALSYM _FACDS}

// #define MAKE_DSHRESULT(code)  MAKE_HRESULT(1, _FACDS, code)
function MAKE_DSHRESULT(Code: DWord): DWord;
{$EXTERNALSYM MAKE_DSHRESULT}

const
  MAKE_DSHRESULT_R     = (1 shl 31) or (_FACDS shl 16);

const
  // DirectSound Component GUID {47D4D946-62E8-11CF-93BC-444553540000}
  CLSID_DirectSound: TGUID = '{47d4d946-62e8-11cf-93bc-444553540000}';
  {$EXTERNALSYM CLSID_DirectSound}

  // DirectSound 8.0 Component GUID {3901CC3F-84B5-4FA4-BA35-AA8172B8A09B}
  CLSID_DirectSound8: TGUID = '{3901cc3f-84b5-4fa4-ba35-aa8172b8a09b}';
  {$EXTERNALSYM CLSID_DirectSound8}

  // DirectSound Capture Component GUID {B0210780-89CD-11D0-AF08-00A0C925CD16}
  CLSID_DirectSoundCapture: TGUID = '{b0210780-89cd-11d0-af08-00a0c925cd16}';
  {$EXTERNALSYM CLSID_DirectSoundCapture}

  // DirectSound 8.0 Capture Component GUID {E4BCAC13-7F99-4908-9A8E-74E3BF24B6E1}
  CLSID_DirectSoundCapture8: TGUID = '{e4bcac13-7f99-4908-9a8e-74e3bf24b6e1}';
  {$EXTERNALSYM CLSID_DirectSoundCapture8}

  // DirectSound Full Duplex Component GUID {FEA4300C-7959-4147-B26A-2377B9E7A91D}
  CLSID_DirectSoundFullDuplex: TGUID = '{fea4300c-7959-4147-b26a-2377b9e7a91d}';
  {$EXTERNALSYM CLSID_DirectSoundFullDuplex}


  // DirectSound default playback device GUID {DEF00000-9C6D-47ED-AAF1-4DDA8F2B5C03}
  DSDEVID_DefaultPlayback: TGUID = '{def00000-9c6d-47ed-aaf1-4dda8f2b5c03}';
  {$EXTERNALSYM DSDEVID_DefaultPlayback}

  // DirectSound default capture device GUID {DEF00001-9C6D-47ED-AAF1-4DDA8F2B5C03}
  DSDEVID_DefaultCapture: TGUID = '{def00001-9c6d-47ed-aaf1-4dda8f2b5c03}';
  {$EXTERNALSYM DSDEVID_DefaultCapture}

  // DirectSound default device for voice playback {DEF00002-9C6D-47ED-AAF1-4DDA8F2B5C03}
  DSDEVID_DefaultVoicePlayback: TGUID = '{def00002-9c6d-47ed-aaf1-4dda8f2b5c03}';
  {$EXTERNALSYM DSDEVID_DefaultVoicePlayback}

  // DirectSound default device for voice capture {DEF00003-9C6D-47ED-AAF1-4DDA8F2B5C03}
  DSDEVID_DefaultVoiceCapture: TGUID = '{def00003-9c6d-47ed-aaf1-4dda8f2b5c03}';
  {$EXTERNALSYM DSDEVID_DefaultVoiceCapture}


//
// Structures
//

type
  PDSCaps = ^TDSCaps;
  _DSCAPS = packed record
    dwSize                         : DWORD;
    dwFlags                        : DWORD;
    dwMinSecondarySampleRate       : DWORD;
    dwMaxSecondarySampleRate       : DWORD;
    dwPrimaryBuffers               : DWORD;
    dwMaxHwMixingAllBuffers        : DWORD;
    dwMaxHwMixingStaticBuffers     : DWORD;
    dwMaxHwMixingStreamingBuffers  : DWORD;
    dwFreeHwMixingAllBuffers       : DWORD;
    dwFreeHwMixingStaticBuffers    : DWORD;
    dwFreeHwMixingStreamingBuffers : DWORD;
    dwMaxHw3DAllBuffers            : DWORD;
    dwMaxHw3DStaticBuffers         : DWORD;
    dwMaxHw3DStreamingBuffers      : DWORD;
    dwFreeHw3DAllBuffers           : DWORD;
    dwFreeHw3DStaticBuffers        : DWORD;
    dwFreeHw3DStreamingBuffers     : DWORD;
    dwTotalHwMemBytes              : DWORD;
    dwFreeHwMemBytes               : DWORD;
    dwMaxContigFreeHwMemBytes      : DWORD;
    dwUnlockTransferRateHwBuffers  : DWORD;
    dwPlayCpuOverheadSwBuffers     : DWORD;
    dwReserved1                    : DWORD;
    dwReserved2                    : DWORD;
  end;
  {$EXTERNALSYM _DSCAPS}
  DSCAPS = _DSCAPS;
  {$EXTERNALSYM DSCAPS}
  TDSCaps = _DSCAPS;

  PDSBcaps = ^TDSBcaps;
  _DSBCAPS = packed record
    dwSize                : DWORD;
    dwFlags               : DWORD;
    dwBufferBytes         : DWORD;
    dwUnlockTransferRate  : DWORD;
    dwPlayCpuOverhead     : DWORD;
  end;
  {$EXTERNALSYM _DSBCAPS}
  DSBCAPS = _DSBCAPS;
  {$EXTERNALSYM DSBCAPS}
  TDSBcaps = _DSBCAPS;

 // #if DIRECTSOUND_VERSION >= 0x0800
  PDSEffectDesc = ^TDSEffectDesc;
  _DSEFFECTDESC = packed record
    dwSize        : DWORD;
    dwFlags       : DWORD;
    guidDSFXClass : TGUID;
    dwReserved1   : DWORD_PTR;
    dwReserved2   : DWORD_PTR;
  end;
  {$EXTERNALSYM _DSEFFECTDESC}
  DSEFFECTDESC = _DSEFFECTDESC;
  {$EXTERNALSYM DSEFFECTDESC}
  TDSEffectDesc = _DSEFFECTDESC;

const
  DSFX_LOCHARDWARE    = $00000001;
  {$EXTERNALSYM DSFX_LOCHARDWARE}
  DSFX_LOCSOFTWARE    = $00000002;
  {$EXTERNALSYM DSFX_LOCSOFTWARE}

  DSFXR_PRESENT          = 0;
  {$EXTERNALSYM DSFXR_PRESENT}
  DSFXR_LOCHARDWARE      = 1;
  {$EXTERNALSYM DSFXR_LOCHARDWARE}
  DSFXR_LOCSOFTWARE      = 2;
  {$EXTERNALSYM DSFXR_LOCSOFTWARE}
  DSFXR_UNALLOCATED      = 3;
  {$EXTERNALSYM DSFXR_UNALLOCATED}
  DSFXR_FAILED           = 4;
  {$EXTERNALSYM DSFXR_FAILED}
  DSFXR_UNKNOWN          = 5;
  {$EXTERNALSYM DSFXR_UNKNOWN}
  DSFXR_SENDLOOP         = 6;
  {$EXTERNALSYM DSFXR_SENDLOOP}

type
  PDSCEffectDesc = ^TDSCEffectDesc;
  _DSCEFFECTDESC = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    guidDSCFXClass: TGUID;
    guidDSCFXInstance: TGUID;
    dwReserved1: DWORD;
    dwReserved2: DWORD;
  end;
  {$EXTERNALSYM _DSCEFFECTDESC}
  DSCEFFECTDESC = _DSCEFFECTDESC;
  {$EXTERNALSYM DSCEFFECTDESC}
  TDSCEffectDesc = _DSCEFFECTDESC;

const
  DSCFX_LOCHARDWARE   = $00000001;
  {$EXTERNALSYM DSCFX_LOCHARDWARE}
  DSCFX_LOCSOFTWARE   = $00000002;
  {$EXTERNALSYM DSCFX_LOCSOFTWARE}

  DSCFXR_LOCHARDWARE  = $00000010;
  {$EXTERNALSYM DSCFXR_LOCHARDWARE}
  DSCFXR_LOCSOFTWARE  = $00000020;
  {$EXTERNALSYM DSCFXR_LOCSOFTWARE}

 // DIRECTSOUND_VERSION >= 0x0800

type
  PDSBufferDesc = ^TDSBufferDesc;
  _DSBUFFERDESC = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    dwBufferBytes: DWORD;
    dwReserved: DWORD;
    lpwfxFormat: PWaveFormatEx;
 // #if DIRECTSOUND_VERSION >= 0x0700
    guid3DAlgorithm: TGUID;
 // DIRECTSOUND_VERSION >= 0x0700
  end;
  {$EXTERNALSYM _DSBUFFERDESC}
  DSBUFFERDESC = _DSBUFFERDESC;
  {$EXTERNALSYM DSBUFFERDESC}
  TDSBufferDesc = _DSBUFFERDESC;

// Older version of this structure:

  PDSBufferDesc1 = ^TDSBufferDesc1;
  _DSBUFFERDESC1 = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    dwBufferBytes: DWORD;
    dwReserved: DWORD;
    lpwfxFormat: PWaveFormatEx;
  end;
  {$EXTERNALSYM _DSBUFFERDESC1}
  DSBUFFERDESC1 = _DSBUFFERDESC1;
  {$EXTERNALSYM DSBUFFERDESC1}
  TDSBufferDesc1 = _DSBUFFERDESC1;

  PDS3DBuffer = ^TDS3DBuffer;
  _DS3DBUFFER = packed record
    dwSize: DWORD;
    vPosition: TD3DVector;
    vVelocity: TD3DVector;
    dwInsideConeAngle: DWORD;
    dwOutsideConeAngle: DWORD;
    vConeOrientation: TD3DVector;
    lConeOutsideVolume: Longint;
    flMinDistance: TD3DValue;
    flMaxDistance: TD3DValue;
    dwMode: DWORD;
  end;
  {$EXTERNALSYM _DS3DBUFFER}
  DS3DBUFFER = _DS3DBUFFER;
  {$EXTERNALSYM DS3DBUFFER}
  TDS3DBuffer = _DS3DBUFFER;

  PDS3DListener = ^TDS3DListener;
  _DS3DLISTENER = packed record
    dwSize: DWORD;
    vPosition: TD3DVector;
    vVelocity: TD3DVector;
    vOrientFront: TD3DVector;
    vOrientTop: TD3DVector;
    flDistanceFactor: TD3DValue;
    flRolloffFactor: TD3DValue;
    flDopplerFactor: TD3DValue;
  end;
  {$EXTERNALSYM _DS3DLISTENER}
  DS3DLISTENER = _DS3DLISTENER;
  {$EXTERNALSYM DS3DLISTENER}
  TDS3DListener = _DS3DLISTENER;

  PDSCcaps = ^TDSCcaps;
  _DSCCAPS = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    dwFormats: DWORD;
    dwChannels: DWORD;
  end;
  {$EXTERNALSYM _DSCCAPS}
  DSCCAPS = _DSCCAPS;
  {$EXTERNALSYM DSCCAPS}
  TDSCcaps = _DSCCAPS;

  PDSCBufferDesc1 = ^TDSCBufferDesc1;
  _DSCBUFFERDESC1 = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    dwBufferBytes: DWORD;
    dwReserved: DWORD;
    lpwfxFormat: PWaveFormatEx;
  end;
  {$EXTERNALSYM _DSCBUFFERDESC1}
  DSCBUFFERDESC1 = _DSCBUFFERDESC1;
  {$EXTERNALSYM DSCBUFFERDESC1}
  TDSCBufferDesc1 = _DSCBUFFERDESC1;

  PDSCBufferDesc = ^TDSCBufferDesc;
  _DSCBUFFERDESC = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    dwBufferBytes: DWORD;
    dwReserved: DWORD;
    lpwfxFormat: PWaveFormatEx;
 // #if DIRECTSOUND_VERSION >= 0x0800
    dwFXCount: DWORD;
    lpDSCFXDesc: PDSCEffectDesc;
 // DIRECTSOUND_VERSION >= 0x0800
  end;
  {$EXTERNALSYM _DSCBUFFERDESC}
  DSCBUFFERDESC = _DSCBUFFERDESC;
  {$EXTERNALSYM DSCBUFFERDESC}
  TDSCBufferDesc = _DSCBUFFERDESC;

  PDSCBCaps = ^TDSCBCaps;
  _DSCBCAPS = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    dwBufferBytes: DWORD;
    dwReserved: DWORD;
  end;
  {$EXTERNALSYM _DSCBCAPS}
  DSCBCAPS = _DSCBCAPS;
  {$EXTERNALSYM DSCBCAPS}
  TDSCBCaps = _DSCBCAPS;

  PDSBPositionNotify = ^TDSBPositionNotify;
  _DSBPOSITIONNOTIFY = packed record
    dwOffset: DWORD;
    hEventNotify: THandle;
  end;
  {$EXTERNALSYM _DSBPOSITIONNOTIFY}
  DSBPOSITIONNOTIFY = _DSBPOSITIONNOTIFY;
  {$EXTERNALSYM DSBPOSITIONNOTIFY}
  TDSBPositionNotify = _DSBPOSITIONNOTIFY;


type
  REFERENCE_TIME = DXTypes.REFERENCE_TIME;
  {$EXTERNALSYM REFERENCE_TIME}
  TReferenceTime = DXTypes.TReferenceTime;
  PReferenceTime = DXTypes.PReferenceTime;

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IReferenceClock);'}
  {$EXTERNALSYM IReferenceClock}
  IReferenceClock = interface(IUnknown)
    ['{56a86897-0ad4-11ce-b03a-0020af0ba770}']
    // IReferenceClock methods
    function GetTime(out pTime: TReferenceTime): HResult; stdcall;
    function AdviseTime(rtBaseTime, rtStreamTime: TReferenceTime; hEvent: THandle; out pdwAdviseCookie: DWORD): HResult; stdcall;
    function AdvisePeriodic(const rtStartTime, rtPeriodTime: TReferenceTime; hSemaphore: THandle; out pdwAdviseCookie: DWORD): HResult; stdcall;
    function Unadvise(dwAdviseCookie: DWORD): HResult; stdcall;
  end;

  IID_IReferenceClock = IReferenceClock;
  {$EXTERNALSYM IID_IReferenceClock}


  IDirectSoundBuffer = interface;

  //
  // IDirectSound
  //

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSound);'}
  {$EXTERNALSYM IDirectSound}
  IDirectSound = interface(IUnknown)
    ['{279AFA83-4981-11CE-A521-0020AF0BE560}']
    // IDirectSound methods
    function CreateSoundBuffer(const pcDSBufferDesc: TDSBufferDesc; out ppDSBuffer: IDirectSoundBuffer; pUnkOuter: IUnknown): HResult; stdcall;
    function GetCaps(out pDSCaps: TDSCaps): HResult; stdcall;
    function DuplicateSoundBuffer(pDSBufferOriginal: IDirectSoundBuffer; out ppDSBufferDuplicate: IDirectSoundBuffer): HResult; stdcall;
    function SetCooperativeLevel(hwnd: HWND; dwLevel: DWORD): HResult; stdcall;
    function Compact: HResult; stdcall;
    function GetSpeakerConfig(out pdwSpeakerConfig: DWORD): HResult; stdcall;
    function SetSpeakerConfig(dwSpeakerConfig: DWORD): HResult; stdcall;
    function Initialize(pcGuidDevice: PGUID): HResult; stdcall;
  end;

  IID_IDirectSound = IDirectSound;
  {$EXTERNALSYM IID_IDirectSound}


 // #if DIRECTSOUND_VERSION >= 0x0800

  //
  // IDirectSound8
  //

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSound8);'}
  {$EXTERNALSYM IDirectSound8}
  IDirectSound8 = interface(IDirectSound)
    ['{C50A7E93-F395-4834-9EF6-7FA99DE50966}']
    // IDirectSound8 methods
    function VerifyCertification(pdwCertified: PDWORD): HResult; stdcall;
  end;

  IID_IDirectSound8 = IDirectSound8;
  {$EXTERNALSYM IID_IDirectSound8}


 // DIRECTSOUND_VERSION >= 0x0800

  //
  // IDirectSoundBuffer
  //

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundBuffer);'}
  {$EXTERNALSYM IDirectSoundBuffer}
  IDirectSoundBuffer = interface(IUnknown)
    ['{279AFA85-4981-11CE-A521-0020AF0BE560}']
    // IDirectSoundBuffer methods
    function GetCaps(var pDSBufferCaps: TDSBcaps): HResult; stdcall;
    function GetCurrentPosition(pdwCurrentPlayCursor, pdwCurrentWriteCursor: PDWORD): HResult; stdcall;
    function GetFormat(pwfxFormat: PWaveFormatEx; dwSizeAllocated: DWORD; pdwSizeWritten: PDWORD): HResult; stdcall;
    function GetVolume(out plVolume: Longint): HResult; stdcall;
    function GetPan(out plPan: Longint): HResult; stdcall;
    function GetFrequency(out pdwFrequency: DWORD): HResult; stdcall;
    function GetStatus(out pdwStatus: DWORD): HResult; stdcall;
    function Initialize(pDirectSound: IDirectSound; const pcDSBufferDesc: TDSBufferDesc): HResult; stdcall;
    function Lock(dwOffset, dwBytes: DWORD; ppvAudioPtr1: PPointer; pdwAudioBytes1: PDWORD;
      ppvAudioPtr2: PPointer; pdwAudioBytes2: PDWORD; dwFlags: DWORD): HResult; stdcall;
    function Play(dwReserved1, dwPriority, dwFlags: DWORD): HResult; stdcall;
    function SetCurrentPosition(dwNewPosition: DWORD): HResult; stdcall;
    function SetFormat(pcfxFormat: PWaveFormatEx): HResult; stdcall;
    function SetVolume(lVolume: Longint): HResult; stdcall;
    function SetPan(lPan: Longint): HResult; stdcall;
    function SetFrequency(dwFrequency: DWORD): HResult; stdcall;
    function Stop: HResult; stdcall;
    function Unlock(pvAudioPtr1: Pointer; dwAudioBytes1: DWORD; pvAudioPtr2: Pointer; dwAudioBytes2: DWORD): HResult; stdcall;
    function Restore: HResult; stdcall;
  end;

  IID_IDirectSoundBuffer = IDirectSoundBuffer;
  {$EXTERNALSYM IID_IDirectSoundBuffer}


 // #if DIRECTSOUND_VERSION >= 0x0800

  //
  // IDirectSoundBuffer8
  //

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundBuffer8);'}
  {$EXTERNALSYM IDirectSoundBuffer8}
  IDirectSoundBuffer8 = interface(IDirectSoundBuffer)
    ['{6825a449-7524-4d82-920f-50e36ab3ab1e}']
    // IDirectSoundBuffer8 methods
    function SetFX(dwEffectsCount: DWORD; pDSFXDesc: PDSEffectDesc; pdwResultCodes: PDWORD): HResult; stdcall;
    function AcquireResources(dwFlags, dwEffectsCount: DWORD; pdwResultCodes: PDWORD): HResult; stdcall;
    function GetObjectInPath(const rguidObject: TGUID; dwIndex: DWORD; const rguidInterface: TGUID; out ppObject{IUnknown}): HResult; stdcall;
  end;

  IID_IDirectSoundBuffer8 = IDirectSoundBuffer8;
  {$EXTERNALSYM IID_IDirectSoundBuffer8}

const
  // Special GUID meaning "select all objects" for use in GetObjectInPath()
  GUID_All_Objects: TGUID = '{aa114de5-c262-4169-a1c8-23d698cc73b5}';
  {$EXTERNALSYM GUID_All_Objects}


type
 // DIRECTSOUND_VERSION >= 0x0800

  //
  // IDirectSound3DListener
  //

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSound3DListener);'}
  {$EXTERNALSYM IDirectSound3DListener}
  IDirectSound3DListener = interface(IUnknown)
    ['{279AFA84-4981-11CE-A521-0020AF0BE560}']
    // IDirectSound3DListener methods
    function GetAllParameters(var pListener: TDS3DListener): HResult; stdcall;
    function GetDistanceFactor(out pflDistanceFactor: TD3DValue): HResult; stdcall;
    function GetDopplerFactor(out pflDopplerFactor: TD3DValue): HResult; stdcall;
    function GetOrientation(out pvOrientFront, pvOrientTop: TD3DVector): HResult; stdcall;
    function GetPosition(out pvPosition: TD3DVector): HResult; stdcall;
    function GetRolloffFactor(out pflRolloffFactor: TD3DValue): HResult; stdcall;
    function GetVelocity(out pvVelocity: TD3DVector): HResult; stdcall;
    function SetAllParameters(const pcListener: TDS3DListener; dwApply: DWORD): HResult; stdcall;
    function SetDistanceFactor(flDistanceFactor: TD3DValue; dwApply: DWORD): HResult; stdcall;
    function SetDopplerFactor(flDopplerFactor: TD3DValue; dwApply: DWORD): HResult; stdcall;
    function SetOrientation(xFront, yFront, zFront: TD3DValue; xTop, yTop, zTop: TD3DValue; dwApply: DWORD): HResult; stdcall;
    function SetPosition(x, y, z: TD3DValue; dwApply: DWORD): HResult; stdcall;
    function SetRolloffFactor(flRolloffFactor: TD3DValue; dwApply: DWORD): HResult; stdcall;
    function SetVelocity(x, y, z: TD3DValue; dwApply: DWORD): HResult; stdcall;
    function CommitDeferredSettings: HResult; stdcall;
  end;

  IID_IDirectSound3DListener = IDirectSound3DListener;
  {$EXTERNALSYM IID_IDirectSound3DListener}


  //
  // IDirectSound3DBuffer
  //

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSound3DBuffer);'}
  {$EXTERNALSYM IDirectSound3DBuffer}
  IDirectSound3DBuffer = interface(IUnknown)
    ['{279AFA86-4981-11CE-A521-0020AF0BE560}']
    // IDirectSound3DBuffer methods
    function GetAllParameters(var pDs3dBuffer: TDS3DBuffer): HResult; stdcall;
    function GetConeAngles(var pdwInsideConeAngle, pdwOutsideConeAngle: DWORD): HResult; stdcall;
    function GetConeOrientation(out pvOrientation: TD3DVector): HResult; stdcall;
    function GetConeOutsideVolume(out plConeOutsideVolume: Longint): HResult; stdcall;
    function GetMaxDistance(out pflMaxDistance: TD3DValue): HResult; stdcall;
    function GetMinDistance(out pflMinDistance: TD3DValue): HResult; stdcall;
    function GetMode(out pdwMode: DWORD): HResult; stdcall;
    function GetPosition(out pvPosition: TD3DVector): HResult; stdcall;
    function GetVelocity(out pvVelocity: TD3DVector): HResult; stdcall;
    function SetAllParameters(const pcDs3dBuffer: TDS3DBuffer; dwApply: DWORD): HResult; stdcall;
    function SetConeAngles(dwInsideConeAngle, dwOutsideConeAngle: DWORD; dwApply: DWORD): HResult; stdcall;
    function SetConeOrientation(x, y, z: TD3DValue; dwApply: DWORD): HResult; stdcall;
    function SetConeOutsideVolume(lConeOutsideVolume: Longint; dwApply: DWORD): HResult; stdcall;
    function SetMaxDistance(flMaxDistance: TD3DValue; dwApply: DWORD): HResult; stdcall;
    function SetMinDistance(flMinDistance: TD3DValue; dwApply: DWORD): HResult; stdcall;
    function SetMode(dwMode: DWORD; dwApply: DWORD): HResult; stdcall;
    function SetPosition(x, y, z: TD3DValue; dwApply: DWORD): HResult; stdcall;
    function SetVelocity(x, y, z: TD3DValue; dwApply: DWORD): HResult; stdcall;
  end;

  IID_IDirectSound3DBuffer = IDirectSound3DBuffer;
  {$EXTERNALSYM IID_IDirectSound3DBuffer}


  IDirectSoundCaptureBuffer = interface;

  //
  // IDirectSoundCapture
  //

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundCapture);'}
  {$EXTERNALSYM IDirectSoundCapture}
  IDirectSoundCapture = interface(IUnknown)
    ['{b0210781-89cd-11d0-af08-00a0c925cd16}']
    // IDirectSoundCapture methods
    function CreateCaptureBuffer(const pcDSCBufferDesc: TDSCBufferDesc; out ppDSCBuffer: IDirectSoundCaptureBuffer; pUnkOuter: IUnknown): HResult; stdcall;
    function GetCaps(var pDSCCaps: TDSCcaps): HResult; stdcall;
    function Initialize(pcGuidDevice: PGUID): HResult; stdcall;
  end;

  IID_IDirectSoundCapture = IDirectSoundCapture;
  {$EXTERNALSYM IID_IDirectSoundCapture}


  //
  // IDirectSoundCaptureBuffer
  //

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundCaptureBuffer);'}
  {$EXTERNALSYM IDirectSoundCaptureBuffer}
  IDirectSoundCaptureBuffer = interface(IUnknown)
    ['{b0210782-89cd-11d0-af08-00a0c925cd16}']
    // IDirectSoundCaptureBuffer methods
    function GetCaps(var pDSCBCaps: TDSCBCaps): HResult; stdcall;
    function GetCurrentPosition(pdwCapturePosition, pdwReadPosition: PDWORD): HResult; stdcall;
    function GetFormat(pwfxFormat: PWaveFormatEx; dwSizeAllocated: DWORD; pdwSizeWritten: PDWORD): HResult; stdcall;
    function GetStatus(pdwStatus: PDWORD): HResult; stdcall;
    function Initialize(pDirectSoundCapture: IDirectSoundCapture; const pcDSCBufferDesc: TDSCBufferDesc): HResult; stdcall;
    function Lock(dwOffset, dwBytes: DWORD; ppvAudioPtr1: PPointer; pdwAudioBytes1: PDWORD; ppvAudioPtr2: PPointer; pdwAudioBytes2: PDWORD; dwFlags: DWORD): HResult; stdcall;
    function Start(dwFlags: DWORD): HResult; stdcall;
    function Stop: HResult; stdcall;
    function Unlock(pvAudioPtr1: Pointer; dwAudioBytes1: DWORD; pvAudioPtr2: Pointer; dwAudioBytes2: DWORD): HResult; stdcall;
  end;

  IID_IDirectSoundCaptureBuffer = IDirectSoundCaptureBuffer;
  {$EXTERNALSYM IID_IDirectSoundCaptureBuffer}


 // #if DIRECTSOUND_VERSION >= 0x0800

  //
  // IDirectSoundCaptureBuffer8
  //

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundCaptureBuffer8);'}
  {$EXTERNALSYM IDirectSoundCaptureBuffer8}
  IDirectSoundCaptureBuffer8 = interface(IDirectSoundCaptureBuffer)
    ['{00990df4-0dbb-4872-833e-6d303e80aeb6}']
    // IDirectSoundCaptureBuffer8 methods
    function GetObjectInPath(const rguidObject: TGUID; dwIndex: DWORD; const rguidInterface: TGUID; out ppObject{IUnknown}): HResult; stdcall;
    function GetFXStatus(dwFXCount: DWORD; pdwFXStatus: PDWORD): HResult; stdcall;
  end;

  IID_IDirectSoundCaptureBuffer8 = IDirectSoundCaptureBuffer8;
  {$EXTERNALSYM IID_IDirectSoundCaptureBuffer8}

 // DIRECTSOUND_VERSION >= 0x0800

  //
  // IDirectSoundNotify
  //

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundNotify);'}
  {$EXTERNALSYM IDirectSoundNotify}
  IDirectSoundNotify = interface(IUnknown)
    ['{b0210783-89cd-11d0-af08-00a0c925cd16}']
    // IDirectSoundNotify methods
    function SetNotificationPositions(dwPositionNotifies: DWORD; pcPositionNotifies: PDSBPositionNotify): HResult; stdcall;
  end;

  IID_IDirectSoundNotify = IDirectSoundNotify;
  {$EXTERNALSYM IID_IDirectSoundNotify}


  //
  // IKsPropertySet
  //

const
  KSPROPERTY_SUPPORT_GET  = $00000001;
  {$EXTERNALSYM KSPROPERTY_SUPPORT_GET}
  KSPROPERTY_SUPPORT_SET  = $00000002;
  {$EXTERNALSYM KSPROPERTY_SUPPORT_SET}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IKsPropertySet);'}
  {$EXTERNALSYM IKsPropertySet}
  IKsPropertySet = interface(IUnknown)
    ['{31efac30-515c-11d0-a9aa-00aa0061be93}']
    // IKsPropertySet methods
    function Get(const rguidPropSet: TGUID; ulId: ULONG; pInstanceData: Pointer; ulInstanceLength: ULONG; pPropertyData: Pointer; ulDataLength: ULONG; out pulBytesReturned: ULONG): HResult; stdcall;
    function _Set(const rguidPropSet: TGUID; ulId: ULONG; pInstanceData: Pointer; ulInstanceLength: ULONG; pPropertyData: Pointer; ulDataLength: ULONG): HResult; stdcall;
    function QuerySupport(const rguidPropSet: TGUID; ulId: ULONG; out pulTypeSupport: ULONG): HResult; stdcall;
  end;

  IID_IKsPropertySet = IKsPropertySet;
  {$EXTERNALSYM IID_IKsPropertySet}

 // #if DIRECTSOUND_VERSION >= 0x0800

  //
  // IDirectSoundFXGargle
  //

  PDSFXGargle = ^TDSFXGargle;
  _DSFXGargle = packed record
    dwRateHz: DWORD;               // Rate of modulation in hz
    dwWaveShape: DWORD;            // DSFXGARGLE_WAVE_xxx
  end;
  {$EXTERNALSYM _DSFXGargle}
  DSFXGargle = _DSFXGargle;
  {$EXTERNALSYM DSFXGargle}
  TDSFXGargle = _DSFXGargle;

const
  DSFXGARGLE_WAVE_TRIANGLE        = 0;
  {$EXTERNALSYM DSFXGARGLE_WAVE_TRIANGLE}
  DSFXGARGLE_WAVE_SQUARE          = 1;
  {$EXTERNALSYM DSFXGARGLE_WAVE_SQUARE}

  DSFXGARGLE_RATEHZ_MIN           = 1;
  {$EXTERNALSYM DSFXGARGLE_RATEHZ_MIN}
  DSFXGARGLE_RATEHZ_MAX           = 1000;
  {$EXTERNALSYM DSFXGARGLE_RATEHZ_MAX}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundFXGargle);'}
  {$EXTERNALSYM IDirectSoundFXGargle}
  IDirectSoundFXGargle = interface(IUnknown)
    ['{d616f352-d622-11ce-aac5-0020af0b99a3}']
    // IDirectSoundFXGargle methods
    function SetAllParameters(const pcDsFxGargle: TDSFXGargle): HResult; stdcall;
    function GetAllParameters(out pDsFxGargle: TDSFXGargle): HResult; stdcall;
  end;

  IID_IDirectSoundFXGargle = IDirectSoundFXGargle;
  {$EXTERNALSYM IID_IDirectSoundFXGargle}


  //
  // IDirectSoundFXChorus
  //

  PDSFXChorus = ^TDSFXChorus;
  _DSFXChorus = packed record
    fWetDryMix: Single;
    fDepth: Single;
    fFeedback: Single;
    fFrequency: Single;
    lWaveform: Longint;          // LFO shape; DSFXCHORUS_WAVE_xxx
    fDelay: Single;
    lPhase: Longint;
  end;
  {$EXTERNALSYM _DSFXChorus}
  DSFXChorus = _DSFXChorus;
  {$EXTERNALSYM DSFXChorus}
  TDSFXChorus = _DSFXChorus;

const
  DSFXCHORUS_WAVE_TRIANGLE        = 0;
  {$EXTERNALSYM DSFXCHORUS_WAVE_TRIANGLE}
  DSFXCHORUS_WAVE_SIN             = 1;
  {$EXTERNALSYM DSFXCHORUS_WAVE_SIN}

  DSFXCHORUS_WETDRYMIX_MIN        = 0.0;
  {$EXTERNALSYM DSFXCHORUS_WETDRYMIX_MIN}
  DSFXCHORUS_WETDRYMIX_MAX        = 100.0;
  {$EXTERNALSYM DSFXCHORUS_WETDRYMIX_MAX}
  DSFXCHORUS_DEPTH_MIN            = 0.0;
  {$EXTERNALSYM DSFXCHORUS_DEPTH_MIN}
  DSFXCHORUS_DEPTH_MAX            = 100.0;
  {$EXTERNALSYM DSFXCHORUS_DEPTH_MAX}
  DSFXCHORUS_FEEDBACK_MIN         = -99.0;
  {$EXTERNALSYM DSFXCHORUS_FEEDBACK_MIN}
  DSFXCHORUS_FEEDBACK_MAX         = 99.0;
  {$EXTERNALSYM DSFXCHORUS_FEEDBACK_MAX}
  DSFXCHORUS_FREQUENCY_MIN        = 0.0;
  {$EXTERNALSYM DSFXCHORUS_FREQUENCY_MIN}
  DSFXCHORUS_FREQUENCY_MAX        = 10.0;
  {$EXTERNALSYM DSFXCHORUS_FREQUENCY_MAX}
  DSFXCHORUS_DELAY_MIN            = 0.0;
  {$EXTERNALSYM DSFXCHORUS_DELAY_MIN}
  DSFXCHORUS_DELAY_MAX            = 20.0;
  {$EXTERNALSYM DSFXCHORUS_DELAY_MAX}
  DSFXCHORUS_PHASE_MIN            = 0;
  {$EXTERNALSYM DSFXCHORUS_PHASE_MIN}
  DSFXCHORUS_PHASE_MAX            = 4;
  {$EXTERNALSYM DSFXCHORUS_PHASE_MAX}

  DSFXCHORUS_PHASE_NEG_180        = 0;
  {$EXTERNALSYM DSFXCHORUS_PHASE_NEG_180}
  DSFXCHORUS_PHASE_NEG_90         = 1;
  {$EXTERNALSYM DSFXCHORUS_PHASE_NEG_90}
  DSFXCHORUS_PHASE_ZERO           = 2;
  {$EXTERNALSYM DSFXCHORUS_PHASE_ZERO}
  DSFXCHORUS_PHASE_90             = 3;
  {$EXTERNALSYM DSFXCHORUS_PHASE_90}
  DSFXCHORUS_PHASE_180            = 4;
  {$EXTERNALSYM DSFXCHORUS_PHASE_180}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundFXChorus);'}
  {$EXTERNALSYM IDirectSoundFXChorus}
  IDirectSoundFXChorus = interface(IUnknown)
    ['{880842e3-145f-43e6-a934-a71806e50547}']
    // IDirectSoundFXChorus methods
    function SetAllParameters(const pcDsFxChorus: TDSFXChorus): HResult; stdcall;
    function GetAllParameters(out pDsFxChorus: TDSFXChorus): HResult; stdcall;
  end;

  IID_IDirectSoundFXChorus = IDirectSoundFXChorus;
  {$EXTERNALSYM IID_IDirectSoundFXChorus}


  //
  // IDirectSoundFXFlanger
  //

  PDSFXFlanger = ^TDSFXFlanger;
  _DSFXFlanger = packed record
    fWetDryMix: Single;
    fDepth: Single;
    fFeedback: Single;
    fFrequency: Single;
    lWaveform: Longint;
    fDelay: Single;
    lPhase: Longint;
  end;
  {$EXTERNALSYM _DSFXFlanger}
  DSFXFlanger = _DSFXFlanger;
  {$EXTERNALSYM DSFXFlanger}
  TDSFXFlanger = _DSFXFlanger;

const
  DSFXFLANGER_WAVE_TRIANGLE       = 0;
  {$EXTERNALSYM DSFXFLANGER_WAVE_TRIANGLE}
  DSFXFLANGER_WAVE_SIN            = 1;
  {$EXTERNALSYM DSFXFLANGER_WAVE_SIN}

  DSFXFLANGER_WETDRYMIX_MIN       = 0.0;
  {$EXTERNALSYM DSFXFLANGER_WETDRYMIX_MIN}
  DSFXFLANGER_WETDRYMIX_MAX       = 100.0;
  {$EXTERNALSYM DSFXFLANGER_WETDRYMIX_MAX}
  DSFXFLANGER_FREQUENCY_MIN       = 0.0;
  {$EXTERNALSYM DSFXFLANGER_FREQUENCY_MIN}
  DSFXFLANGER_FREQUENCY_MAX       = 10.0;
  {$EXTERNALSYM DSFXFLANGER_FREQUENCY_MAX}
  DSFXFLANGER_DEPTH_MIN           = 0.0;
  {$EXTERNALSYM DSFXFLANGER_DEPTH_MIN}
  DSFXFLANGER_DEPTH_MAX           = 100.0;
  {$EXTERNALSYM DSFXFLANGER_DEPTH_MAX}
  DSFXFLANGER_PHASE_MIN           = 0;
  {$EXTERNALSYM DSFXFLANGER_PHASE_MIN}
  DSFXFLANGER_PHASE_MAX           = 4;
  {$EXTERNALSYM DSFXFLANGER_PHASE_MAX}
  DSFXFLANGER_FEEDBACK_MIN        = -99.0;
  {$EXTERNALSYM DSFXFLANGER_FEEDBACK_MIN}
  DSFXFLANGER_FEEDBACK_MAX        = 99.0;
  {$EXTERNALSYM DSFXFLANGER_FEEDBACK_MAX}
  DSFXFLANGER_DELAY_MIN           = 0.0;
  {$EXTERNALSYM DSFXFLANGER_DELAY_MIN}
  DSFXFLANGER_DELAY_MAX           = 4.0;
  {$EXTERNALSYM DSFXFLANGER_DELAY_MAX}

  DSFXFLANGER_PHASE_NEG_180       = 0;
  {$EXTERNALSYM DSFXFLANGER_PHASE_NEG_180}
  DSFXFLANGER_PHASE_NEG_90        = 1;
  {$EXTERNALSYM DSFXFLANGER_PHASE_NEG_90}
  DSFXFLANGER_PHASE_ZERO          = 2;
  {$EXTERNALSYM DSFXFLANGER_PHASE_ZERO}
  DSFXFLANGER_PHASE_90            = 3;
  {$EXTERNALSYM DSFXFLANGER_PHASE_90}
  DSFXFLANGER_PHASE_180           = 4;
  {$EXTERNALSYM DSFXFLANGER_PHASE_180}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundFXFlanger);'}
  {$EXTERNALSYM IDirectSoundFXFlanger}
  IDirectSoundFXFlanger = interface(IUnknown)
    ['{903e9878-2c92-4072-9b2c-ea68f5396783}']
    // IDirectSoundFXFlanger methods
    function SetAllParameters(const pcDsFxFlanger: TDSFXFlanger): HResult; stdcall;
    function GetAllParameters(out pDsFxFlanger: TDSFXFlanger): HResult; stdcall;
  end;

  IID_IDirectSoundFXFlanger = IDirectSoundFXFlanger;
  {$EXTERNALSYM IID_IDirectSoundFXFlanger}


  //
  // IDirectSoundFXEcho
  //

  PDSFXEcho = ^TDSFXEcho;
  _DSFXEcho = packed record
    fWetDryMix: Single;
    fFeedback: Single;
    fLeftDelay: Single;
    fRightDelay: Single;
    lPanDelay: Longint;
  end;
  {$EXTERNALSYM _DSFXEcho}
  DSFXEcho = _DSFXEcho;
  {$EXTERNALSYM DSFXEcho}
  TDSFXEcho = _DSFXEcho;

const
  DSFXECHO_WETDRYMIX_MIN      = 0.0;
  {$EXTERNALSYM DSFXECHO_WETDRYMIX_MIN}
  DSFXECHO_WETDRYMIX_MAX      = 100.0;
  {$EXTERNALSYM DSFXECHO_WETDRYMIX_MAX}
  DSFXECHO_FEEDBACK_MIN       = 0.0;
  {$EXTERNALSYM DSFXECHO_FEEDBACK_MIN}
  DSFXECHO_FEEDBACK_MAX       = 100.0;
  {$EXTERNALSYM DSFXECHO_FEEDBACK_MAX}
  DSFXECHO_LEFTDELAY_MIN      = 1.0;
  {$EXTERNALSYM DSFXECHO_LEFTDELAY_MIN}
  DSFXECHO_LEFTDELAY_MAX      = 2000.0;
  {$EXTERNALSYM DSFXECHO_LEFTDELAY_MAX}
  DSFXECHO_RIGHTDELAY_MIN     = 1.0;
  {$EXTERNALSYM DSFXECHO_RIGHTDELAY_MIN}
  DSFXECHO_RIGHTDELAY_MAX     = 2000.0;
  {$EXTERNALSYM DSFXECHO_RIGHTDELAY_MAX}
  DSFXECHO_PANDELAY_MIN       = 0;
  {$EXTERNALSYM DSFXECHO_PANDELAY_MIN}
  DSFXECHO_PANDELAY_MAX       = 1;
  {$EXTERNALSYM DSFXECHO_PANDELAY_MAX}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundFXEcho);'}
  {$EXTERNALSYM IDirectSoundFXEcho}
  IDirectSoundFXEcho = interface(IUnknown)
    ['{8bd28edf-50db-4e92-a2bd-445488d1ed42}']
    // IDirectSoundFXEcho methods
    function SetAllParameters(const pcDsFxEcho: TDSFXEcho): HResult; stdcall;
    function GetAllParameters(out pDsFxEcho: TDSFXEcho): HResult; stdcall;
  end;

  IID_IDirectSoundFXEcho = IDirectSoundFXEcho;
  {$EXTERNALSYM IID_IDirectSoundFXEcho}


  //
  // IDirectSoundFXDistortion
  //

  PDSFXDistortion = ^TDSFXDistortion;
  _DSFXDistortion = packed record
    fGain: Single;
    fEdge: Single;
    fPostEQCenterFrequency: Single;
    fPostEQBandwidth: Single;
    fPreLowpassCutoff: Single;
  end;
  {$EXTERNALSYM _DSFXDistortion}
  DSFXDistortion = _DSFXDistortion;
  {$EXTERNALSYM DSFXDistortion}
  TDSFXDistortion = _DSFXDistortion;

const
  DSFXDISTORTION_GAIN_MIN                     = -60.0;
  {$EXTERNALSYM DSFXDISTORTION_GAIN_MIN}
  DSFXDISTORTION_GAIN_MAX                     = 0.0;
  {$EXTERNALSYM DSFXDISTORTION_GAIN_MAX}
  DSFXDISTORTION_EDGE_MIN                     = 0.0;
  {$EXTERNALSYM DSFXDISTORTION_EDGE_MIN}
  DSFXDISTORTION_EDGE_MAX                     = 100.0;
  {$EXTERNALSYM DSFXDISTORTION_EDGE_MAX}
  DSFXDISTORTION_POSTEQCENTERFREQUENCY_MIN    = 100.0;
  {$EXTERNALSYM DSFXDISTORTION_POSTEQCENTERFREQUENCY_MIN}
  DSFXDISTORTION_POSTEQCENTERFREQUENCY_MAX    = 8000.0;
  {$EXTERNALSYM DSFXDISTORTION_POSTEQCENTERFREQUENCY_MAX}
  DSFXDISTORTION_POSTEQBANDWIDTH_MIN          = 100.0;
  {$EXTERNALSYM DSFXDISTORTION_POSTEQBANDWIDTH_MIN}
  DSFXDISTORTION_POSTEQBANDWIDTH_MAX          = 8000.0;
  {$EXTERNALSYM DSFXDISTORTION_POSTEQBANDWIDTH_MAX}
  DSFXDISTORTION_PRELOWPASSCUTOFF_MIN         = 100.0;
  {$EXTERNALSYM DSFXDISTORTION_PRELOWPASSCUTOFF_MIN}
  DSFXDISTORTION_PRELOWPASSCUTOFF_MAX         = 8000.0;
  {$EXTERNALSYM DSFXDISTORTION_PRELOWPASSCUTOFF_MAX}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundFXDistortion);'}
  {$EXTERNALSYM IDirectSoundFXDistortion}
  IDirectSoundFXDistortion = interface(IUnknown)
    ['{8ecf4326-455f-4d8b-bda9-8d5d3e9e3e0b}']
    // IDirectSoundFXDistortion methods
    function SetAllParameters(const pcDsFxDistortion: TDSFXDistortion): HResult; stdcall;
    function GetAllParameters(out pDsFxDistortion: TDSFXDistortion): HResult; stdcall;
  end;

  IID_IDirectSoundFXDistortion = IDirectSoundFXDistortion;
  {$EXTERNALSYM IID_IDirectSoundFXDistortion}


  //
  // IDirectSoundFXCompressor
  //

  PDSFXCompressor = ^TDSFXCompressor;
  _DSFXCompressor = packed record
    fGain: Single;
    fAttack: Single;
    fRelease: Single;
    fThreshold: Single;
    fRatio: Single;
    fPredelay: Single;
  end;
  {$EXTERNALSYM _DSFXCompressor}
  DSFXCompressor = _DSFXCompressor;
  {$EXTERNALSYM DSFXCompressor}
  TDSFXCompressor = _DSFXCompressor;

const
  DSFXCOMPRESSOR_GAIN_MIN             = -60.0;
  {$EXTERNALSYM DSFXCOMPRESSOR_GAIN_MIN}
  DSFXCOMPRESSOR_GAIN_MAX             = 60.0;
  {$EXTERNALSYM DSFXCOMPRESSOR_GAIN_MAX}
  DSFXCOMPRESSOR_ATTACK_MIN           = 0.01;
  {$EXTERNALSYM DSFXCOMPRESSOR_ATTACK_MIN}
  DSFXCOMPRESSOR_ATTACK_MAX           = 500.0;
  {$EXTERNALSYM DSFXCOMPRESSOR_ATTACK_MAX}
  DSFXCOMPRESSOR_RELEASE_MIN          = 50.0;
  {$EXTERNALSYM DSFXCOMPRESSOR_RELEASE_MIN}
  DSFXCOMPRESSOR_RELEASE_MAX          = 3000.0;
  {$EXTERNALSYM DSFXCOMPRESSOR_RELEASE_MAX}
  DSFXCOMPRESSOR_THRESHOLD_MIN        = -60.0;
  {$EXTERNALSYM DSFXCOMPRESSOR_THRESHOLD_MIN}
  DSFXCOMPRESSOR_THRESHOLD_MAX        = 0.0;
  {$EXTERNALSYM DSFXCOMPRESSOR_THRESHOLD_MAX}
  DSFXCOMPRESSOR_RATIO_MIN            = 1.0;
  {$EXTERNALSYM DSFXCOMPRESSOR_RATIO_MIN}
  DSFXCOMPRESSOR_RATIO_MAX            = 100.0;
  {$EXTERNALSYM DSFXCOMPRESSOR_RATIO_MAX}
  DSFXCOMPRESSOR_PREDELAY_MIN         = 0.0;
  {$EXTERNALSYM DSFXCOMPRESSOR_PREDELAY_MIN}
  DSFXCOMPRESSOR_PREDELAY_MAX         = 4.0;
  {$EXTERNALSYM DSFXCOMPRESSOR_PREDELAY_MAX}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundFXCompressor);'}
  {$EXTERNALSYM IDirectSoundFXCompressor}
  IDirectSoundFXCompressor = interface(IUnknown)
    ['{4bbd1154-62f6-4e2c-a15c-d3b6c417f7a0}']
    // IDirectSoundFXCompressor methods
    function SetAllParameters(const pcDsFxCompressor: TDSFXCompressor): HResult; stdcall;
    function GetAllParameters(out pDsFxCompressor: TDSFXCompressor): HResult; stdcall;
  end;

  IID_IDirectSoundFXCompressor = IDirectSoundFXCompressor;
  {$EXTERNALSYM IID_IDirectSoundFXCompressor}


  //
  // IDirectSoundFXParamEq
  //

  PDSFXParamEq = ^TDSFXParamEq;
  _DSFXParamEq = packed record
    fCenter: Single;
    fBandwidth: Single;
    fGain: Single;
  end;
  {$EXTERNALSYM _DSFXParamEq}
  DSFXParamEq = _DSFXParamEq;
  {$EXTERNALSYM DSFXParamEq}
  TDSFXParamEq = _DSFXParamEq;

const
  DSFXPARAMEQ_CENTER_MIN      = 80.0;
  {$EXTERNALSYM DSFXPARAMEQ_CENTER_MIN}
  DSFXPARAMEQ_CENTER_MAX      = 16000.0;
  {$EXTERNALSYM DSFXPARAMEQ_CENTER_MAX}
  DSFXPARAMEQ_BANDWIDTH_MIN   = 1.0;
  {$EXTERNALSYM DSFXPARAMEQ_BANDWIDTH_MIN}
  DSFXPARAMEQ_BANDWIDTH_MAX   = 36.0;
  {$EXTERNALSYM DSFXPARAMEQ_BANDWIDTH_MAX}
  DSFXPARAMEQ_GAIN_MIN        = -15.0;
  {$EXTERNALSYM DSFXPARAMEQ_GAIN_MIN}
  DSFXPARAMEQ_GAIN_MAX        = 15.0;
  {$EXTERNALSYM DSFXPARAMEQ_GAIN_MAX}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundFXParamEq);'}
  {$EXTERNALSYM IDirectSoundFXParamEq}
  IDirectSoundFXParamEq = interface(IUnknown)
    ['{c03ca9fe-fe90-4204-8078-82334cd177da}']
    // IDirectSoundFXParamEq methods
    function SetAllParameters(const pcDsFxParamEq: TDSFXParamEq): HResult; stdcall;
    function GetAllParameters(out pDsFxParamEq: TDSFXParamEq): HResult; stdcall;
  end;

  IID_IDirectSoundFXParamEq = IDirectSoundFXParamEq;
  {$EXTERNALSYM IID_IDirectSoundFXParamEq}


  //
  // IDirectSoundFXI3DL2Reverb
  //

  PDSFXI3DL2Reverb = ^TDSFXI3DL2Reverb;
  _DSFXI3DL2Reverb = packed record
    lRoom: Longint;                  // [-10000, 0]      default: -1000 mB
    lRoomHF: Longint;                // [-10000, 0]      default: 0 mB
    flRoomRolloffFactor: Single;     // [0.0, 10.0]      default: 0.0
    flDecayTime: Single;             // [0.1, 20.0]      default: 1.49s
    flDecayHFRatio: Single;          // [0.1, 2.0]       default: 0.83
    lReflections: Longint;           // [-10000, 1000]   default: -2602 mB
    flReflectionsDelay: Single;      // [0.0, 0.3]       default: 0.007 s
    lReverb: Longint;                // [-10000, 2000]   default: 200 mB
    flReverbDelay: Single;           // [0.0, 0.1]       default: 0.011 s
    flDiffusion: Single;             // [0.0, 100.0]     default: 100.0 %
    flDensity: Single;               // [0.0, 100.0]     default: 100.0 %
    flHFReference: Single;           // [20.0, 20000.0]  default: 5000.0 Hz
  end;
  {$EXTERNALSYM _DSFXI3DL2Reverb}
  DSFXI3DL2Reverb = _DSFXI3DL2Reverb;
  {$EXTERNALSYM DSFXI3DL2Reverb}
  TDSFXI3DL2Reverb = _DSFXI3DL2Reverb;

const
  DSFX_I3DL2REVERB_ROOM_MIN                   = (-10000);
  {$EXTERNALSYM DSFX_I3DL2REVERB_ROOM_MIN}
  DSFX_I3DL2REVERB_ROOM_MAX                   = 0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_ROOM_MAX}
  DSFX_I3DL2REVERB_ROOM_DEFAULT               = (-1000);
  {$EXTERNALSYM DSFX_I3DL2REVERB_ROOM_DEFAULT}

  DSFX_I3DL2REVERB_ROOMHF_MIN                 = (-10000);
  {$EXTERNALSYM DSFX_I3DL2REVERB_ROOMHF_MIN}
  DSFX_I3DL2REVERB_ROOMHF_MAX                 = 0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_ROOMHF_MAX}
  DSFX_I3DL2REVERB_ROOMHF_DEFAULT             = (-100);
  {$EXTERNALSYM DSFX_I3DL2REVERB_ROOMHF_DEFAULT}

  DSFX_I3DL2REVERB_ROOMROLLOFFFACTOR_MIN      = 0.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_ROOMROLLOFFFACTOR_MIN}
  DSFX_I3DL2REVERB_ROOMROLLOFFFACTOR_MAX      = 10.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_ROOMROLLOFFFACTOR_MAX}
  DSFX_I3DL2REVERB_ROOMROLLOFFFACTOR_DEFAULT  = 0.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_ROOMROLLOFFFACTOR_DEFAULT}

  DSFX_I3DL2REVERB_DECAYTIME_MIN              = 0.1;
  {$EXTERNALSYM DSFX_I3DL2REVERB_DECAYTIME_MIN}
  DSFX_I3DL2REVERB_DECAYTIME_MAX              = 20.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_DECAYTIME_MAX}
  DSFX_I3DL2REVERB_DECAYTIME_DEFAULT          = 1.49;
  {$EXTERNALSYM DSFX_I3DL2REVERB_DECAYTIME_DEFAULT}

  DSFX_I3DL2REVERB_DECAYHFRATIO_MIN           = 0.1;
  {$EXTERNALSYM DSFX_I3DL2REVERB_DECAYHFRATIO_MIN}
  DSFX_I3DL2REVERB_DECAYHFRATIO_MAX           = 2.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_DECAYHFRATIO_MAX}
  DSFX_I3DL2REVERB_DECAYHFRATIO_DEFAULT       = 0.83;
  {$EXTERNALSYM DSFX_I3DL2REVERB_DECAYHFRATIO_DEFAULT}

  DSFX_I3DL2REVERB_REFLECTIONS_MIN            = (-10000);
  {$EXTERNALSYM DSFX_I3DL2REVERB_REFLECTIONS_MIN}
  DSFX_I3DL2REVERB_REFLECTIONS_MAX            = 1000;
  {$EXTERNALSYM DSFX_I3DL2REVERB_REFLECTIONS_MAX}
  DSFX_I3DL2REVERB_REFLECTIONS_DEFAULT        = (-2602);
  {$EXTERNALSYM DSFX_I3DL2REVERB_REFLECTIONS_DEFAULT}

  DSFX_I3DL2REVERB_REFLECTIONSDELAY_MIN       = 0.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_REFLECTIONSDELAY_MIN}
  DSFX_I3DL2REVERB_REFLECTIONSDELAY_MAX       = 0.3;
  {$EXTERNALSYM DSFX_I3DL2REVERB_REFLECTIONSDELAY_MAX}
  DSFX_I3DL2REVERB_REFLECTIONSDELAY_DEFAULT   = 0.007;
  {$EXTERNALSYM DSFX_I3DL2REVERB_REFLECTIONSDELAY_DEFAULT}

  DSFX_I3DL2REVERB_REVERB_MIN                 = (-10000);
  {$EXTERNALSYM DSFX_I3DL2REVERB_REVERB_MIN}
  DSFX_I3DL2REVERB_REVERB_MAX                 = 2000;
  {$EXTERNALSYM DSFX_I3DL2REVERB_REVERB_MAX}
  DSFX_I3DL2REVERB_REVERB_DEFAULT             = (200);
  {$EXTERNALSYM DSFX_I3DL2REVERB_REVERB_DEFAULT}

  DSFX_I3DL2REVERB_REVERBDELAY_MIN            = 0.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_REVERBDELAY_MIN}
  DSFX_I3DL2REVERB_REVERBDELAY_MAX            = 0.1;
  {$EXTERNALSYM DSFX_I3DL2REVERB_REVERBDELAY_MAX}
  DSFX_I3DL2REVERB_REVERBDELAY_DEFAULT        = 0.011;
  {$EXTERNALSYM DSFX_I3DL2REVERB_REVERBDELAY_DEFAULT}

  DSFX_I3DL2REVERB_DIFFUSION_MIN              = 0.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_DIFFUSION_MIN}
  DSFX_I3DL2REVERB_DIFFUSION_MAX              = 100.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_DIFFUSION_MAX}
  DSFX_I3DL2REVERB_DIFFUSION_DEFAULT          = 100.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_DIFFUSION_DEFAULT}

  DSFX_I3DL2REVERB_DENSITY_MIN                = 0.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_DENSITY_MIN}
  DSFX_I3DL2REVERB_DENSITY_MAX                = 100.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_DENSITY_MAX}
  DSFX_I3DL2REVERB_DENSITY_DEFAULT            = 100.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_DENSITY_DEFAULT}

  DSFX_I3DL2REVERB_HFREFERENCE_MIN            = 20.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_HFREFERENCE_MIN}
  DSFX_I3DL2REVERB_HFREFERENCE_MAX            = 20000.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_HFREFERENCE_MAX}
  DSFX_I3DL2REVERB_HFREFERENCE_DEFAULT        = 5000.0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_HFREFERENCE_DEFAULT}

  DSFX_I3DL2REVERB_QUALITY_MIN                = 0;
  {$EXTERNALSYM DSFX_I3DL2REVERB_QUALITY_MIN}
  DSFX_I3DL2REVERB_QUALITY_MAX                = 3;
  {$EXTERNALSYM DSFX_I3DL2REVERB_QUALITY_MAX}
  DSFX_I3DL2REVERB_QUALITY_DEFAULT            = 2;
  {$EXTERNALSYM DSFX_I3DL2REVERB_QUALITY_DEFAULT}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundFXI3DL2Reverb);'}
  {$EXTERNALSYM IDirectSoundFXI3DL2Reverb}
  IDirectSoundFXI3DL2Reverb = interface(IUnknown)
    ['{4b166a6a-0d66-43f3-80e3-ee6280dee1a4}']
    // IDirectSoundFXI3DL2Reverb methods
    function SetAllParameters(const pcDsFxI3DL2Reverb: TDSFXI3DL2Reverb): HResult; stdcall;
    function GetAllParameters(out pDsFxI3DL2Reverb: TDSFXI3DL2Reverb): HResult; stdcall;
    function SetPreset(dwPreset: DWORD): HResult; stdcall;
    function GetPreset(out pdwPreset: DWORD): HResult; stdcall;
    function SetQuality(lQuality: Longint): HResult; stdcall;
    function GetQuality(out plQuality: Longint): HResult; stdcall;
  end;

  IID_IDirectSoundFXI3DL2Reverb = IDirectSoundFXI3DL2Reverb;
  {$EXTERNALSYM IID_IDirectSoundFXI3DL2Reverb}


  //
  // IDirectSoundFXWavesReverb
  //

  PDSFXWavesReverb = ^TDSFXWavesReverb;
  _DSFXWavesReverb = packed record
    fInGain: Single;                // [-96.0,0.0]            default: 0.0 dB
    fReverbMix: Single;             // [-96.0,0.0]            default: 0.0 db
    fReverbTime: Single;            // [0.001,3000.0]         default: 1000.0 ms
    fHighFreqRTRatio: Single;       // [0.001,0.999]          default: 0.001
  end;
  {$EXTERNALSYM _DSFXWavesReverb}
  DSFXWavesReverb = _DSFXWavesReverb;
  {$EXTERNALSYM DSFXWavesReverb}
  TDSFXWavesReverb = _DSFXWavesReverb;

const
  DSFX_WAVESREVERB_INGAIN_MIN                 = -96.0;
  {$EXTERNALSYM DSFX_WAVESREVERB_INGAIN_MIN}
  DSFX_WAVESREVERB_INGAIN_MAX                 = 0.0;
  {$EXTERNALSYM DSFX_WAVESREVERB_INGAIN_MAX}
  DSFX_WAVESREVERB_INGAIN_DEFAULT             = 0.0;
  {$EXTERNALSYM DSFX_WAVESREVERB_INGAIN_DEFAULT}
  DSFX_WAVESREVERB_REVERBMIX_MIN              = -96.0;
  {$EXTERNALSYM DSFX_WAVESREVERB_REVERBMIX_MIN}
  DSFX_WAVESREVERB_REVERBMIX_MAX              = 0.0;
  {$EXTERNALSYM DSFX_WAVESREVERB_REVERBMIX_MAX}
  DSFX_WAVESREVERB_REVERBMIX_DEFAULT          = 0.0;
  {$EXTERNALSYM DSFX_WAVESREVERB_REVERBMIX_DEFAULT}
  DSFX_WAVESREVERB_REVERBTIME_MIN             = 0.001;
  {$EXTERNALSYM DSFX_WAVESREVERB_REVERBTIME_MIN}
  DSFX_WAVESREVERB_REVERBTIME_MAX             = 3000.0;
  {$EXTERNALSYM DSFX_WAVESREVERB_REVERBTIME_MAX}
  DSFX_WAVESREVERB_REVERBTIME_DEFAULT         = 1000.0;
  {$EXTERNALSYM DSFX_WAVESREVERB_REVERBTIME_DEFAULT}
  DSFX_WAVESREVERB_HIGHFREQRTRATIO_MIN        = 0.001;
  {$EXTERNALSYM DSFX_WAVESREVERB_HIGHFREQRTRATIO_MIN}
  DSFX_WAVESREVERB_HIGHFREQRTRATIO_MAX        = 0.999;
  {$EXTERNALSYM DSFX_WAVESREVERB_HIGHFREQRTRATIO_MAX}
  DSFX_WAVESREVERB_HIGHFREQRTRATIO_DEFAULT    = 0.001;
  {$EXTERNALSYM DSFX_WAVESREVERB_HIGHFREQRTRATIO_DEFAULT}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundFXWavesReverb);'}
  {$EXTERNALSYM IDirectSoundFXWavesReverb}
  IDirectSoundFXWavesReverb = interface(IUnknown)
    ['{46858c3a-0dc6-45e3-b760-d4eef16cb325}']
    // IDirectSoundFXWavesReverb methods
    function SetAllParameters(const pcDsFxWavesReverb: TDSFXWavesReverb): HResult; stdcall;
    function GetAllParameters(out pDsFxWavesReverb: TDSFXWavesReverb): HResult; stdcall;
  end;

  IID_IDirectSoundFXWavesReverb = IDirectSoundFXWavesReverb;
  {$EXTERNALSYM IID_IDirectSoundFXWavesReverb}

  
  //
  // IDirectSoundCaptureFXAec
  //

  PDSCFXAec = ^TDSCFXAec;
  _DSCFXAec = packed record
    fEnable: BOOL;
    fNoiseFill: BOOL;
    dwMode: DWORD;
  end;
  {$EXTERNALSYM _DSCFXAec}
  DSCFXAec = _DSCFXAec;
  {$EXTERNALSYM DSCFXAec}
  TDSCFXAec = _DSCFXAec;

const
  // These match the AEC_MODE_* constants in the DDK's ksmedia.h file
  DSCFX_AEC_MODE_PASS_THROUGH                     = $0;
  {$EXTERNALSYM DSCFX_AEC_MODE_PASS_THROUGH}
  DSCFX_AEC_MODE_HALF_DUPLEX                      = $1;
  {$EXTERNALSYM DSCFX_AEC_MODE_HALF_DUPLEX}
  DSCFX_AEC_MODE_FULL_DUPLEX                      = $2;
  {$EXTERNALSYM DSCFX_AEC_MODE_FULL_DUPLEX}

  // These match the AEC_STATUS_* constants in ksmedia.h
  DSCFX_AEC_STATUS_HISTORY_UNINITIALIZED          = $0;
  {$EXTERNALSYM DSCFX_AEC_STATUS_HISTORY_UNINITIALIZED}
  DSCFX_AEC_STATUS_HISTORY_CONTINUOUSLY_CONVERGED = $1;
  {$EXTERNALSYM DSCFX_AEC_STATUS_HISTORY_CONTINUOUSLY_CONVERGED}
  DSCFX_AEC_STATUS_HISTORY_PREVIOUSLY_DIVERGED    = $2;
  {$EXTERNALSYM DSCFX_AEC_STATUS_HISTORY_PREVIOUSLY_DIVERGED}
  DSCFX_AEC_STATUS_CURRENTLY_CONVERGED            = $8;
  {$EXTERNALSYM DSCFX_AEC_STATUS_CURRENTLY_CONVERGED}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundCaptureFXAec);'}
  {$EXTERNALSYM IDirectSoundCaptureFXAec}
  IDirectSoundCaptureFXAec = interface(IUnknown)
    ['{ad74143d-903d-4ab7-8066-28d363036d65}']
    // IDirectSoundCaptureFXAec methods
    function SetAllParameters(const pDscFxAec: TDSCFXAec): HResult; stdcall;
    function GetAllParameters(out pDscFxAec: TDSCFXAec): HResult; stdcall;
    function GetStatus(out pdwStatus: DWORD): HResult; stdcall;
    function Reset: HResult; stdcall;
  end;

  IID_IDirectSoundCaptureFXAec = IDirectSoundCaptureFXAec;
  {$EXTERNALSYM IID_IDirectSoundCaptureFXAec}


  //
  // IDirectSoundCaptureFXNoiseSuppress
  //

  PDSCFXNoiseSuppress = ^TDSCFXNoiseSuppress;
  _DSCFXNoiseSuppress = packed record
    fEnable:    BOOL;
  end;
  {$EXTERNALSYM _DSCFXNoiseSuppress}
  DSCFXNoiseSuppress = _DSCFXNoiseSuppress;
  {$EXTERNALSYM DSCFXNoiseSuppress}
  TDSCFXNoiseSuppress = _DSCFXNoiseSuppress;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundCaptureFXNoiseSuppress);'}
  {$EXTERNALSYM IDirectSoundCaptureFXNoiseSuppress}
  IDirectSoundCaptureFXNoiseSuppress = interface(IUnknown)
    ['{ed311e41-fbae-4175-9625-cd0854f693ca}']
    // IDirectSoundCaptureFXNoiseSuppress methods
    function SetAllParameters(const pcDscFxNoiseSuppress: TDSCFXNoiseSuppress): HResult; stdcall;
    function GetAllParameters(out pDscFxNoiseSuppress: TDSCFXNoiseSuppress): HResult; stdcall;
    function Reset: HResult; stdcall;
  end;

  IID_IDirectSoundCaptureFXNoiseSuppress = IDirectSoundCaptureFXNoiseSuppress;
  {$EXTERNALSYM IID_IDirectSoundCaptureFXNoiseSuppress}


  //
  // IDirectSoundFullDuplex
  //

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectSoundFullDuplex);'}
  {$EXTERNALSYM IDirectSoundFullDuplex}
  IDirectSoundFullDuplex = interface(IUnknown)
    ['{edcb4c7a-daab-4216-a42e-6c50596ddc1d}']
    // IDirectSoundFullDuplex methods
    function Initialize(pCaptureGuid, pRenderGuid: PGUID;
      const lpDscBufferDesc: TDSCBufferDesc; const lpDsBufferDesc: TDSBufferDesc;
      hWnd: HWND; dwLevel: DWORD;
      out lplpDirectSoundCaptureBuffer8: IDirectSoundCaptureBuffer8;
      out lplpDirectSoundBuffer8: IDirectSoundBuffer8): HResult; stdcall;
  end;

  IID_IDirectSoundFullDuplex = IDirectSoundFullDuplex;
  {$EXTERNALSYM IID_IDirectSoundFullDuplex}


 // DIRECTSOUND_VERSION >= 0x0800

//
// DirectSound 8.0 interfaces.
//

 // #if DIRECTSOUND_VERSION >= 0x0800
// IDirectSound8, IDirectSoundBuffer8 and IDirectSoundCaptureBuffer8 are the
// only DirectSound 7.0 interfaces with changed functionality in version 8.0.
// The other level 8 interfaces as equivalent to their level 7 counterparts:
type
  IDirectSoundCapture8            = IDirectSoundCapture;
  {$EXTERNALSYM IDirectSoundCapture8}
  IDirectSound3DListener8         = IDirectSound3DListener;
  {$EXTERNALSYM IDirectSound3DListener8}
  IDirectSound3DBuffer8           = IDirectSound3DBuffer;
  {$EXTERNALSYM IDirectSound3DBuffer8}
  IDirectSoundNotify8             = IDirectSoundNotify;
  {$EXTERNALSYM IDirectSoundNotify8}
  IDirectSoundFXGargle8           = IDirectSoundFXGargle;
  {$EXTERNALSYM IDirectSoundFXGargle8}
  IDirectSoundFXChorus8           = IDirectSoundFXChorus;
  {$EXTERNALSYM IDirectSoundFXChorus8}
  IDirectSoundFXFlanger8          = IDirectSoundFXFlanger;
  {$EXTERNALSYM IDirectSoundFXFlanger8}
  IDirectSoundFXEcho8             = IDirectSoundFXEcho;
  {$EXTERNALSYM IDirectSoundFXEcho8}
  IDirectSoundFXDistortion8       = IDirectSoundFXDistortion;
  {$EXTERNALSYM IDirectSoundFXDistortion8}
  IDirectSoundFXCompressor8       = IDirectSoundFXCompressor;
  {$EXTERNALSYM IDirectSoundFXCompressor8}
  IDirectSoundFXParamEq8          = IDirectSoundFXParamEq;
  {$EXTERNALSYM IDirectSoundFXParamEq8}
  IDirectSoundFXWavesReverb8      = IDirectSoundFXWavesReverb;
  {$EXTERNALSYM IDirectSoundFXWavesReverb8}
  IDirectSoundFXI3DL2Reverb8      = IDirectSoundFXI3DL2Reverb;
  {$EXTERNALSYM IDirectSoundFXI3DL2Reverb8}
  IDirectSoundCaptureFXAec8       = IDirectSoundCaptureFXAec;
  {$EXTERNALSYM IDirectSoundCaptureFXAec8}
  IDirectSoundCaptureFXNoiseSuppress8 = IDirectSoundCaptureFXNoiseSuppress;
  {$EXTERNALSYM IDirectSoundCaptureFXNoiseSuppress8}
  IDirectSoundFullDuplex8         = IDirectSoundFullDuplex;
  {$EXTERNALSYM IDirectSoundFullDuplex8}

  //
  // IID definitions for the unchanged DirectSound 8.0 interfaces
  //

  IID_IDirectSoundCapture8            = IID_IDirectSoundCapture;
  {$EXTERNALSYM IID_IDirectSoundCapture8}
  IID_IDirectSound3DListener8         = IID_IDirectSound3DListener;
  {$EXTERNALSYM IID_IDirectSound3DListener8}
  IID_IDirectSound3DBuffer8           = IID_IDirectSound3DBuffer;
  {$EXTERNALSYM IID_IDirectSound3DBuffer8}
  IID_IDirectSoundNotify8             = IID_IDirectSoundNotify;
  {$EXTERNALSYM IID_IDirectSoundNotify8}
  IID_IDirectSoundFXGargle8           = IID_IDirectSoundFXGargle;
  {$EXTERNALSYM IID_IDirectSoundFXGargle8}
  IID_IDirectSoundFXChorus8           = IID_IDirectSoundFXChorus;
  {$EXTERNALSYM IID_IDirectSoundFXChorus8}
  IID_IDirectSoundFXFlanger8          = IID_IDirectSoundFXFlanger;
  {$EXTERNALSYM IID_IDirectSoundFXFlanger8}
  IID_IDirectSoundFXEcho8             = IID_IDirectSoundFXEcho;
  {$EXTERNALSYM IID_IDirectSoundFXEcho8}
  IID_IDirectSoundFXDistortion8       = IID_IDirectSoundFXDistortion;
  {$EXTERNALSYM IID_IDirectSoundFXDistortion8}
  IID_IDirectSoundFXCompressor8       = IID_IDirectSoundFXCompressor;
  {$EXTERNALSYM IID_IDirectSoundFXCompressor8}
  IID_IDirectSoundFXParamEq8          = IID_IDirectSoundFXParamEq;
  {$EXTERNALSYM IID_IDirectSoundFXParamEq8}
  IID_IDirectSoundFXWavesReverb8      = IID_IDirectSoundFXWavesReverb;
  {$EXTERNALSYM IID_IDirectSoundFXWavesReverb8}
  IID_IDirectSoundFXI3DL2Reverb8      = IID_IDirectSoundFXI3DL2Reverb;
  {$EXTERNALSYM IID_IDirectSoundFXI3DL2Reverb8}
  IID_IDirectSoundCaptureFXAec8       = IID_IDirectSoundCaptureFXAec;
  {$EXTERNALSYM IID_IDirectSoundCaptureFXAec8}
  IID_IDirectSoundCaptureFXNoiseSuppress8 = IID_IDirectSoundCaptureFXNoiseSuppress;
  {$EXTERNALSYM IID_IDirectSoundCaptureFXNoiseSuppress8}
  IID_IDirectSoundFullDuplex8         = IID_IDirectSoundFullDuplex;
  {$EXTERNALSYM IID_IDirectSoundFullDuplex8}
 // DIRECTSOUND_VERSION >= 0x0800

const
  //
  // Return Codes
  //

  // The function completed successfully
  DS_OK                           = S_OK;
  {$EXTERNALSYM DS_OK}

  // The call succeeded, but we had to substitute the 3D algorithm
  DS_NO_VIRTUALIZATION            = (0 shl 31) or (_FACDS shl 16) or 10; // MAKE_HRESULT(0, _FACDS, 10)
  {$EXTERNALSYM DS_NO_VIRTUALIZATION}

  // The call failed because resources (such as a priority level)
  // were already being used by another caller
  DSERR_ALLOCATED                 = MAKE_DSHRESULT_R or 10; // MAKE_DSHRESULT(10)
  {$EXTERNALSYM DSERR_ALLOCATED}

  // The control (vol, pan, etc.) requested by the caller is not available
  DSERR_CONTROLUNAVAIL            = MAKE_DSHRESULT_R or 30; // MAKE_DSHRESULT(30)
  {$EXTERNALSYM DSERR_CONTROLUNAVAIL}

  // An invalid parameter was passed to the returning function
  DSERR_INVALIDPARAM              = E_INVALIDARG;
  {$EXTERNALSYM DSERR_INVALIDPARAM}

  // This call is not valid for the current state of this object
  DSERR_INVALIDCALL               = MAKE_DSHRESULT_R or 50; // MAKE_DSHRESULT(50)
  {$EXTERNALSYM DSERR_INVALIDCALL}

  // An undetermined error occurred inside the DirectSound subsystem
  DSERR_GENERIC                   = E_FAIL;
  {$EXTERNALSYM DSERR_GENERIC}

  // The caller does not have the priority level required for the function to
  // succeed
  DSERR_PRIOLEVELNEEDED           = MAKE_DSHRESULT_R or 70; // MAKE_DSHRESULT(70)
  {$EXTERNALSYM DSERR_PRIOLEVELNEEDED}

  // Not enough free memory is available to complete the operation
  DSERR_OUTOFMEMORY               = E_OUTOFMEMORY;
  {$EXTERNALSYM DSERR_OUTOFMEMORY}

  // The specified WAVE format is not supported
  DSERR_BADFORMAT                 = MAKE_DSHRESULT_R or 100; // MAKE_DSHRESULT(100)
  {$EXTERNALSYM DSERR_BADFORMAT}

  // The function called is not supported at this time
  DSERR_UNSUPPORTED               = E_NOTIMPL;
  {$EXTERNALSYM DSERR_UNSUPPORTED}

  // No sound driver is available for use
  DSERR_NODRIVER                  = MAKE_DSHRESULT_R or 120; // MAKE_DSHRESULT(120)
  {$EXTERNALSYM DSERR_NODRIVER}

  // This object is already initialized
  DSERR_ALREADYINITIALIZED        = MAKE_DSHRESULT_R or 130; // MAKE_DSHRESULT(130)
  {$EXTERNALSYM DSERR_ALREADYINITIALIZED}

  // This object does not support aggregation
  DSERR_NOAGGREGATION             = CLASS_E_NOAGGREGATION;
  {$EXTERNALSYM DSERR_NOAGGREGATION}

  // The buffer memory has been lost, and must be restored
  DSERR_BUFFERLOST                = MAKE_DSHRESULT_R or 150; // MAKE_DSHRESULT(150)
  {$EXTERNALSYM DSERR_BUFFERLOST}

  // Another app has a higher priority level, preventing this call from
  // succeeding
  DSERR_OTHERAPPHASPRIO           = MAKE_DSHRESULT_R or 160; // MAKE_DSHRESULT(160)
  {$EXTERNALSYM DSERR_OTHERAPPHASPRIO}

  // This object has not been initialized
  DSERR_UNINITIALIZED             = MAKE_DSHRESULT_R or 170; // MAKE_DSHRESULT(170)
  {$EXTERNALSYM DSERR_UNINITIALIZED}

  // The requested COM interface is not available
  DSERR_NOINTERFACE               = E_NOINTERFACE;
  {$EXTERNALSYM DSERR_NOINTERFACE}

  // Access is denied
  DSERR_ACCESSDENIED              = E_ACCESSDENIED;
  {$EXTERNALSYM DSERR_ACCESSDENIED}

  // Tried to create a DSBCAPS_CTRLFX buffer shorter than DSBSIZE_FX_MIN milliseconds
  DSERR_BUFFERTOOSMALL            = MAKE_DSHRESULT_R or 180; // MAKE_DSHRESULT(180)
  {$EXTERNALSYM DSERR_BUFFERTOOSMALL}

  // Attempt to use DirectSound 8 functionality on an older DirectSound object
  DSERR_DS8_REQUIRED              = MAKE_DSHRESULT_R or 190; // MAKE_DSHRESULT(190)
  {$EXTERNALSYM DSERR_DS8_REQUIRED}

  // A circular loop of send effects was detected
  DSERR_SENDLOOP                  = MAKE_DSHRESULT_R or 200; // MAKE_DSHRESULT(200)
  {$EXTERNALSYM DSERR_SENDLOOP}

  // The GUID specified in an audiopath file does not match a valid MIXIN buffer
  DSERR_BADSENDBUFFERGUID         = MAKE_DSHRESULT_R or 210; // MAKE_DSHRESULT(210)
  {$EXTERNALSYM DSERR_BADSENDBUFFERGUID}

  // The object requested was not found (numerically equal to DMUS_E_NOT_FOUND)
  DSERR_OBJECTNOTFOUND            = MAKE_DSHRESULT_R or 4449; // MAKE_DSHRESULT(4449)
  {$EXTERNALSYM DSERR_OBJECTNOTFOUND}

  // The effects requested could not be found on the system, or they were found
  // but in the wrong order, or in the wrong hardware/software locations.
  DSERR_FXUNAVAILABLE             = MAKE_DSHRESULT_R or 220; // MAKE_DSHRESULT(220)
  {$EXTERNALSYM DSERR_FXUNAVAILABLE}

  //
  // Flags
  //

  DSCAPS_PRIMARYMONO          = $00000001;
  {$EXTERNALSYM DSCAPS_PRIMARYMONO}
  DSCAPS_PRIMARYSTEREO        = $00000002;
  {$EXTERNALSYM DSCAPS_PRIMARYSTEREO}
  DSCAPS_PRIMARY8BIT          = $00000004;
  {$EXTERNALSYM DSCAPS_PRIMARY8BIT}
  DSCAPS_PRIMARY16BIT         = $00000008;
  {$EXTERNALSYM DSCAPS_PRIMARY16BIT}
  DSCAPS_CONTINUOUSRATE       = $00000010;
  {$EXTERNALSYM DSCAPS_CONTINUOUSRATE}
  DSCAPS_EMULDRIVER           = $00000020;
  {$EXTERNALSYM DSCAPS_EMULDRIVER}
  DSCAPS_CERTIFIED            = $00000040;
  {$EXTERNALSYM DSCAPS_CERTIFIED}
  DSCAPS_SECONDARYMONO        = $00000100;
  {$EXTERNALSYM DSCAPS_SECONDARYMONO}
  DSCAPS_SECONDARYSTEREO      = $00000200;
  {$EXTERNALSYM DSCAPS_SECONDARYSTEREO}
  DSCAPS_SECONDARY8BIT        = $00000400;
  {$EXTERNALSYM DSCAPS_SECONDARY8BIT}
  DSCAPS_SECONDARY16BIT       = $00000800;
  {$EXTERNALSYM DSCAPS_SECONDARY16BIT}

  DSSCL_NORMAL                = $00000001;
  {$EXTERNALSYM DSSCL_NORMAL}
  DSSCL_PRIORITY              = $00000002;
  {$EXTERNALSYM DSSCL_PRIORITY}
  DSSCL_EXCLUSIVE             = $00000003;
  {$EXTERNALSYM DSSCL_EXCLUSIVE}
  DSSCL_WRITEPRIMARY          = $00000004;
  {$EXTERNALSYM DSSCL_WRITEPRIMARY}

  DSSPEAKER_DIRECTOUT         = $00000000;
  {$EXTERNALSYM DSSPEAKER_DIRECTOUT}
  DSSPEAKER_HEADPHONE         = $00000001;
  {$EXTERNALSYM DSSPEAKER_HEADPHONE}
  DSSPEAKER_MONO              = $00000002;
  {$EXTERNALSYM DSSPEAKER_MONO}
  DSSPEAKER_QUAD              = $00000003;
  {$EXTERNALSYM DSSPEAKER_QUAD}
  DSSPEAKER_STEREO            = $00000004;
  {$EXTERNALSYM DSSPEAKER_STEREO}
  DSSPEAKER_SURROUND          = $00000005;
  {$EXTERNALSYM DSSPEAKER_SURROUND}
  DSSPEAKER_5POINT1           = $00000006;  // obsolete 5.1 setting
  {$EXTERNALSYM DSSPEAKER_5POINT1}
  DSSPEAKER_7POINT1           = $00000007;  // obsolete 7.1 setting
  {$EXTERNALSYM DSSPEAKER_7POINT1}
  DSSPEAKER_7POINT1_SURROUND  = $00000008;  // correct 7.1 Home Theater setting
  {$EXTERNALSYM DSSPEAKER_7POINT1_SURROUND}
  DSSPEAKER_7POINT1_WIDE      = DSSPEAKER_7POINT1;
  {$EXTERNALSYM DSSPEAKER_7POINT1_WIDE}
//#if (DIRECTSOUND_VERSION >= 0x1000)
  DSSPEAKER_5POINT1_SURROUND  = $00000009;  // correct 5.1 setting
  {$EXTERNALSYM DSSPEAKER_5POINT1_SURROUND}
  DSSPEAKER_5POINT1_BACK      = DSSPEAKER_5POINT1;
  {$EXTERNALSYM DSSPEAKER_5POINT1_BACK}
//#endif

  DSSPEAKER_GEOMETRY_MIN      = $00000005;  //   5 degrees
  {$EXTERNALSYM DSSPEAKER_GEOMETRY_MIN}
  DSSPEAKER_GEOMETRY_NARROW   = $0000000A;  //  10 degrees
  {$EXTERNALSYM DSSPEAKER_GEOMETRY_NARROW}
  DSSPEAKER_GEOMETRY_WIDE     = $00000014;  //  20 degrees
  {$EXTERNALSYM DSSPEAKER_GEOMETRY_WIDE}
  DSSPEAKER_GEOMETRY_MAX      = $000000B4;  // 180 degrees
  {$EXTERNALSYM DSSPEAKER_GEOMETRY_MAX}

// #define DSSPEAKER_COMBINED(c, g)    ((DWORD)(((BYTE)(c)) | ((DWORD)((BYTE)(g))) << 16))
function DSSPEAKER_COMBINED(c, g: DWORD): DWORD;
{$EXTERNALSYM DSSPEAKER_COMBINED}
// #define DSSPEAKER_CONFIG(a)         ((BYTE)(a))
function DSSPEAKER_CONFIG(a: Cardinal): Byte;
{$EXTERNALSYM DSSPEAKER_CONFIG}
// #define DSSPEAKER_GEOMETRY(a)       ((BYTE)(((DWORD)(a) >> 16) & 0x00FF))
function DSSPEAKER_GEOMETRY(a: Cardinal): Byte;
{$EXTERNALSYM DSSPEAKER_GEOMETRY}

const
  DSBCAPS_PRIMARYBUFFER       = $00000001;
  {$EXTERNALSYM DSBCAPS_PRIMARYBUFFER}
  DSBCAPS_STATIC              = $00000002;
  {$EXTERNALSYM DSBCAPS_STATIC}
  DSBCAPS_LOCHARDWARE         = $00000004;
  {$EXTERNALSYM DSBCAPS_LOCHARDWARE}
  DSBCAPS_LOCSOFTWARE         = $00000008;
  {$EXTERNALSYM DSBCAPS_LOCSOFTWARE}
  DSBCAPS_CTRL3D              = $00000010;
  {$EXTERNALSYM DSBCAPS_CTRL3D}
  DSBCAPS_CTRLFREQUENCY       = $00000020;
  {$EXTERNALSYM DSBCAPS_CTRLFREQUENCY}
  DSBCAPS_CTRLPAN             = $00000040;
  {$EXTERNALSYM DSBCAPS_CTRLPAN}
  DSBCAPS_CTRLVOLUME          = $00000080;
  {$EXTERNALSYM DSBCAPS_CTRLVOLUME}
  DSBCAPS_CTRLPOSITIONNOTIFY  = $00000100;
  {$EXTERNALSYM DSBCAPS_CTRLPOSITIONNOTIFY}
  DSBCAPS_CTRLFX              = $00000200;
  {$EXTERNALSYM DSBCAPS_CTRLFX}
  DSBCAPS_STICKYFOCUS         = $00004000;
  {$EXTERNALSYM DSBCAPS_STICKYFOCUS}
  DSBCAPS_GLOBALFOCUS         = $00008000;
  {$EXTERNALSYM DSBCAPS_GLOBALFOCUS}
  DSBCAPS_GETCURRENTPOSITION2 = $00010000;
  {$EXTERNALSYM DSBCAPS_GETCURRENTPOSITION2}
  DSBCAPS_MUTE3DATMAXDISTANCE = $00020000;
  {$EXTERNALSYM DSBCAPS_MUTE3DATMAXDISTANCE}
  DSBCAPS_LOCDEFER            = $00040000;
  {$EXTERNALSYM DSBCAPS_LOCDEFER}
//#if (DIRECTSOUND_VERSION >= 0x1000)
    // Force GetCurrentPosition() to return a buffer's true play position;
    // unmodified by aids to enhance backward compatibility.
    DSBCAPS_TRUEPLAYPOSITION    = $00080000;
    {$EXTERNALSYM DSBCAPS_TRUEPLAYPOSITION}
//#endif

  DSBPLAY_LOOPING             = $00000001;
  {$EXTERNALSYM DSBPLAY_LOOPING}
  DSBPLAY_LOCHARDWARE         = $00000002;
  {$EXTERNALSYM DSBPLAY_LOCHARDWARE}
  DSBPLAY_LOCSOFTWARE         = $00000004;
  {$EXTERNALSYM DSBPLAY_LOCSOFTWARE}
  DSBPLAY_TERMINATEBY_TIME    = $00000008;
  {$EXTERNALSYM DSBPLAY_TERMINATEBY_TIME}
  DSBPLAY_TERMINATEBY_DISTANCE    = $000000010;
  {$EXTERNALSYM DSBPLAY_TERMINATEBY_DISTANCE}
  DSBPLAY_TERMINATEBY_PRIORITY    = $000000020;
  {$EXTERNALSYM DSBPLAY_TERMINATEBY_PRIORITY}

  DSBSTATUS_PLAYING           = $00000001;
  {$EXTERNALSYM DSBSTATUS_PLAYING}
  DSBSTATUS_BUFFERLOST        = $00000002;
  {$EXTERNALSYM DSBSTATUS_BUFFERLOST}
  DSBSTATUS_LOOPING           = $00000004;
  {$EXTERNALSYM DSBSTATUS_LOOPING}
  DSBSTATUS_LOCHARDWARE       = $00000008;
  {$EXTERNALSYM DSBSTATUS_LOCHARDWARE}
  DSBSTATUS_LOCSOFTWARE       = $00000010;
  {$EXTERNALSYM DSBSTATUS_LOCSOFTWARE}
  DSBSTATUS_TERMINATED        = $00000020;
  {$EXTERNALSYM DSBSTATUS_TERMINATED}

  DSBLOCK_FROMWRITECURSOR     = $00000001;
  {$EXTERNALSYM DSBLOCK_FROMWRITECURSOR}
  DSBLOCK_ENTIREBUFFER        = $00000002;
  {$EXTERNALSYM DSBLOCK_ENTIREBUFFER}

  DSBFREQUENCY_ORIGINAL       = 0;
  {$EXTERNALSYM DSBFREQUENCY_ORIGINAL}
  DSBFREQUENCY_MIN            = 100;
  {$EXTERNALSYM DSBFREQUENCY_MIN}
 // #if DIRECTSOUND_VERSION >= 0x0900
  DSBFREQUENCY_MAX            = 200000;
  {$EXTERNALSYM DSBFREQUENCY_MAX}

  DSBPAN_LEFT                 = -10000;
  {$EXTERNALSYM DSBPAN_LEFT}
  DSBPAN_CENTER               = 0;
  {$EXTERNALSYM DSBPAN_CENTER}
  DSBPAN_RIGHT                = 10000;
  {$EXTERNALSYM DSBPAN_RIGHT}

  DSBVOLUME_MIN               = -10000;
  {$EXTERNALSYM DSBVOLUME_MIN}
  DSBVOLUME_MAX               = 0;
  {$EXTERNALSYM DSBVOLUME_MAX}

  DSBSIZE_MIN                 = 4;
  {$EXTERNALSYM DSBSIZE_MIN}
  DSBSIZE_MAX                 = $0FFFFFFF;
  {$EXTERNALSYM DSBSIZE_MAX}
  DSBSIZE_FX_MIN              = 150;  // NOTE: Milliseconds, not bytes
  {$EXTERNALSYM DSBSIZE_FX_MIN}

  DSBNOTIFICATIONS_MAX        = 100000;
  {$EXTERNALSYM DSBNOTIFICATIONS_MAX}

  DS3DMODE_NORMAL             = $00000000;
  {$EXTERNALSYM DS3DMODE_NORMAL}
  DS3DMODE_HEADRELATIVE       = $00000001;
  {$EXTERNALSYM DS3DMODE_HEADRELATIVE}
  DS3DMODE_DISABLE            = $00000002;
  {$EXTERNALSYM DS3DMODE_DISABLE}

  DS3D_IMMEDIATE              = $00000000;
  {$EXTERNALSYM DS3D_IMMEDIATE}
  DS3D_DEFERRED               = $00000001;
  {$EXTERNALSYM DS3D_DEFERRED}
var
  // Forced to define as 'var' cos pascal compiler treats all consts as Double
  DS3D_MINDISTANCEFACTOR: Single = 1.175494351e-38; // FLT_MIN;
  {$EXTERNALSYM DS3D_MINDISTANCEFACTOR}
  DS3D_MAXDISTANCEFACTOR: Single = 3.402823466e+38; // FLT_MAX;
  {$EXTERNALSYM DS3D_MAXDISTANCEFACTOR}
const
  DS3D_DEFAULTDISTANCEFACTOR  = 1.0;
  {$EXTERNALSYM DS3D_DEFAULTDISTANCEFACTOR}

  DS3D_MINROLLOFFFACTOR       = 0.0;
  {$EXTERNALSYM DS3D_MINROLLOFFFACTOR}
  DS3D_MAXROLLOFFFACTOR       = 10.0;
  {$EXTERNALSYM DS3D_MAXROLLOFFFACTOR}
  DS3D_DEFAULTROLLOFFFACTOR   = 1.0;
  {$EXTERNALSYM DS3D_DEFAULTROLLOFFFACTOR}

  DS3D_MINDOPPLERFACTOR       = 0.0;
  {$EXTERNALSYM DS3D_MINDOPPLERFACTOR}
  DS3D_MAXDOPPLERFACTOR       = 10.0;
  {$EXTERNALSYM DS3D_MAXDOPPLERFACTOR}
  DS3D_DEFAULTDOPPLERFACTOR   = 1.0;
  {$EXTERNALSYM DS3D_DEFAULTDOPPLERFACTOR}

  DS3D_DEFAULTMINDISTANCE     = 1.0;
  {$EXTERNALSYM DS3D_DEFAULTMINDISTANCE}
  DS3D_DEFAULTMAXDISTANCE     = 1000000000.0;
  {$EXTERNALSYM DS3D_DEFAULTMAXDISTANCE}

  DS3D_MINCONEANGLE           = 0;
  {$EXTERNALSYM DS3D_MINCONEANGLE}
  DS3D_MAXCONEANGLE           = 360;
  {$EXTERNALSYM DS3D_MAXCONEANGLE}
  DS3D_DEFAULTCONEANGLE       = 360;
  {$EXTERNALSYM DS3D_DEFAULTCONEANGLE}

  DS3D_DEFAULTCONEOUTSIDEVOLUME = DSBVOLUME_MAX;
  {$EXTERNALSYM DS3D_DEFAULTCONEOUTSIDEVOLUME}

  // IDirectSoundCapture attributes

  DSCCAPS_EMULDRIVER          = DSCAPS_EMULDRIVER;
  {$EXTERNALSYM DSCCAPS_EMULDRIVER}
  DSCCAPS_CERTIFIED           = DSCAPS_CERTIFIED;
  {$EXTERNALSYM DSCCAPS_CERTIFIED}
  DSCCAPS_MULTIPLECAPTURE     = $00000001;
  {$EXTERNALSYM DSCCAPS_MULTIPLECAPTURE}

  // IDirectSoundCaptureBuffer attributes

  DSCBCAPS_WAVEMAPPED         = $80000000;
  {$EXTERNALSYM DSCBCAPS_WAVEMAPPED}

 // #if DIRECTSOUND_VERSION >= 0x0800
  DSCBCAPS_CTRLFX             = $00000200;
  {$EXTERNALSYM DSCBCAPS_CTRLFX}
 // DIRECTSOUND_VERSION >= 0x0800


  DSCBLOCK_ENTIREBUFFER       = $00000001;
  {$EXTERNALSYM DSCBLOCK_ENTIREBUFFER}

  DSCBSTATUS_CAPTURING        = $00000001;
  {$EXTERNALSYM DSCBSTATUS_CAPTURING}
  DSCBSTATUS_LOOPING          = $00000002;
  {$EXTERNALSYM DSCBSTATUS_LOOPING}

  DSCBSTART_LOOPING           = $00000001;
  {$EXTERNALSYM DSCBSTART_LOOPING}

  DSBPN_OFFSETSTOP            = $FFFFFFFF;
  {$EXTERNALSYM DSBPN_OFFSETSTOP}

  DS_CERTIFIED                = $00000000;
  {$EXTERNALSYM DS_CERTIFIED}
  DS_UNCERTIFIED              = $00000001;
  {$EXTERNALSYM DS_UNCERTIFIED}


  //
  // Flags for the I3DL2 effects
  //

  //
  // I3DL2 Material Presets
  //

  DSFX_I3DL2_MATERIAL_PRESET_SINGLEWINDOW = 0;
  {$EXTERNALSYM DSFX_I3DL2_MATERIAL_PRESET_SINGLEWINDOW}
  DSFX_I3DL2_MATERIAL_PRESET_DOUBLEWINDOW = 1;
  {$EXTERNALSYM DSFX_I3DL2_MATERIAL_PRESET_DOUBLEWINDOW}
  DSFX_I3DL2_MATERIAL_PRESET_THINDOOR     = 2;
  {$EXTERNALSYM DSFX_I3DL2_MATERIAL_PRESET_THINDOOR}
  DSFX_I3DL2_MATERIAL_PRESET_THICKDOOR    = 3;
  {$EXTERNALSYM DSFX_I3DL2_MATERIAL_PRESET_THICKDOOR}
  DSFX_I3DL2_MATERIAL_PRESET_WOODWALL     = 4;
  {$EXTERNALSYM DSFX_I3DL2_MATERIAL_PRESET_WOODWALL}
  DSFX_I3DL2_MATERIAL_PRESET_BRICKWALL    = 5;
  {$EXTERNALSYM DSFX_I3DL2_MATERIAL_PRESET_BRICKWALL}
  DSFX_I3DL2_MATERIAL_PRESET_STONEWALL    = 6;
  {$EXTERNALSYM DSFX_I3DL2_MATERIAL_PRESET_STONEWALL}
  DSFX_I3DL2_MATERIAL_PRESET_CURTAIN      = 7;
  {$EXTERNALSYM DSFX_I3DL2_MATERIAL_PRESET_CURTAIN}

//Translator: have not found where these defines are used
{
#define I3DL2_MATERIAL_PRESET_SINGLEWINDOW    -2800,0.71f
#define I3DL2_MATERIAL_PRESET_DOUBLEWINDOW    -5000,0.40f
#define I3DL2_MATERIAL_PRESET_THINDOOR        -1800,0.66f
#define I3DL2_MATERIAL_PRESET_THICKDOOR       -4400,0.64f
#define I3DL2_MATERIAL_PRESET_WOODWALL        -4000,0.50f
#define I3DL2_MATERIAL_PRESET_BRICKWALL       -5000,0.60f
#define I3DL2_MATERIAL_PRESET_STONEWALL       -6000,0.68f
#define I3DL2_MATERIAL_PRESET_CURTAIN         -1200,0.15f
}

  DSFX_I3DL2_ENVIRONMENT_PRESET_DEFAULT         = 0;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_DEFAULT}
  DSFX_I3DL2_ENVIRONMENT_PRESET_GENERIC         = 1;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_GENERIC}
  DSFX_I3DL2_ENVIRONMENT_PRESET_PADDEDCELL      = 2;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_PADDEDCELL}
  DSFX_I3DL2_ENVIRONMENT_PRESET_ROOM            = 3;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_ROOM}
  DSFX_I3DL2_ENVIRONMENT_PRESET_BATHROOM        = 4;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_BATHROOM}
  DSFX_I3DL2_ENVIRONMENT_PRESET_LIVINGROOM      = 5;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_LIVINGROOM}
  DSFX_I3DL2_ENVIRONMENT_PRESET_STONEROOM       = 6;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_STONEROOM}
  DSFX_I3DL2_ENVIRONMENT_PRESET_AUDITORIUM      = 7;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_AUDITORIUM}
  DSFX_I3DL2_ENVIRONMENT_PRESET_CONCERTHALL     = 8;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_CONCERTHALL}
  DSFX_I3DL2_ENVIRONMENT_PRESET_CAVE            = 9;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_CAVE}
  DSFX_I3DL2_ENVIRONMENT_PRESET_ARENA           = 10;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_ARENA}
  DSFX_I3DL2_ENVIRONMENT_PRESET_HANGAR          = 11;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_HANGAR}
  DSFX_I3DL2_ENVIRONMENT_PRESET_CARPETEDHALLWAY = 12;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_CARPETEDHALLWAY}
  DSFX_I3DL2_ENVIRONMENT_PRESET_HALLWAY         = 13;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_HALLWAY}
  DSFX_I3DL2_ENVIRONMENT_PRESET_STONECORRIDOR   = 14;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_STONECORRIDOR}
  DSFX_I3DL2_ENVIRONMENT_PRESET_ALLEY           = 15;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_ALLEY}
  DSFX_I3DL2_ENVIRONMENT_PRESET_FOREST          = 16;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_FOREST}
  DSFX_I3DL2_ENVIRONMENT_PRESET_CITY            = 17;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_CITY}
  DSFX_I3DL2_ENVIRONMENT_PRESET_MOUNTAINS       = 18;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_MOUNTAINS}
  DSFX_I3DL2_ENVIRONMENT_PRESET_QUARRY          = 19;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_QUARRY}
  DSFX_I3DL2_ENVIRONMENT_PRESET_PLAIN           = 20;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_PLAIN}
  DSFX_I3DL2_ENVIRONMENT_PRESET_PARKINGLOT      = 21;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_PARKINGLOT}
  DSFX_I3DL2_ENVIRONMENT_PRESET_SEWERPIPE       = 22;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_SEWERPIPE}
  DSFX_I3DL2_ENVIRONMENT_PRESET_UNDERWATER      = 23;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_UNDERWATER}
  DSFX_I3DL2_ENVIRONMENT_PRESET_SMALLROOM       = 24;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_SMALLROOM}
  DSFX_I3DL2_ENVIRONMENT_PRESET_MEDIUMROOM      = 25;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_MEDIUMROOM}
  DSFX_I3DL2_ENVIRONMENT_PRESET_LARGEROOM       = 26;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_LARGEROOM}
  DSFX_I3DL2_ENVIRONMENT_PRESET_MEDIUMHALL      = 27;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_MEDIUMHALL}
  DSFX_I3DL2_ENVIRONMENT_PRESET_LARGEHALL       = 28;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_LARGEHALL}
  DSFX_I3DL2_ENVIRONMENT_PRESET_PLATE           = 29;
  {$EXTERNALSYM DSFX_I3DL2_ENVIRONMENT_PRESET_PLATE}

  //
  // I3DL2 Reverberation Presets Values
  //

  I3DL2_ENVIRONMENT_PRESET_DEFAULT         : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -100; flRoomRolloffFactor: 0.0; flDecayTime: 1.49; flDecayHFRatio: 0.83; lReflections: -2602; flReflectionsDelay: 0.007; lReverb:   200; flReverbDelay: 0.011; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_DEFAULT}
  I3DL2_ENVIRONMENT_PRESET_GENERIC         : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -100; flRoomRolloffFactor: 0.0; flDecayTime: 1.49; flDecayHFRatio: 0.83; lReflections: -2602; flReflectionsDelay: 0.007; lReverb:   200; flReverbDelay: 0.011; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_GENERIC}
  I3DL2_ENVIRONMENT_PRESET_PADDEDCELL      : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF: -6000; flRoomRolloffFactor: 0.0; flDecayTime: 0.17; flDecayHFRatio: 0.10; lReflections: -1204; flReflectionsDelay: 0.001; lReverb:   207; flReverbDelay: 0.002; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_PADDEDCELL}
  I3DL2_ENVIRONMENT_PRESET_ROOM            : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -454; flRoomRolloffFactor: 0.0; flDecayTime: 0.40; flDecayHFRatio: 0.83; lReflections: -1646; flReflectionsDelay: 0.002; lReverb:    53; flReverbDelay: 0.003; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_ROOM}
  I3DL2_ENVIRONMENT_PRESET_BATHROOM        : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF: -1200; flRoomRolloffFactor: 0.0; flDecayTime: 1.49; flDecayHFRatio: 0.54; lReflections:  -370; flReflectionsDelay: 0.007; lReverb:  1030; flReverbDelay: 0.011; flDiffusion: 100.0; flDensity:  60.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_BATHROOM}
  I3DL2_ENVIRONMENT_PRESET_LIVINGROOM      : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF: -6000; flRoomRolloffFactor: 0.0; flDecayTime: 0.50; flDecayHFRatio: 0.10; lReflections: -1376; flReflectionsDelay: 0.003; lReverb: -1104; flReverbDelay: 0.004; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_LIVINGROOM}
  I3DL2_ENVIRONMENT_PRESET_STONEROOM       : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -300; flRoomRolloffFactor: 0.0; flDecayTime: 2.31; flDecayHFRatio: 0.64; lReflections:  -711; flReflectionsDelay: 0.012; lReverb:    83; flReverbDelay: 0.017; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_STONEROOM}
  I3DL2_ENVIRONMENT_PRESET_AUDITORIUM      : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -476; flRoomRolloffFactor: 0.0; flDecayTime: 4.32; flDecayHFRatio: 0.59; lReflections:  -789; flReflectionsDelay: 0.020; lReverb:  -289; flReverbDelay: 0.030; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_AUDITORIUM}
  I3DL2_ENVIRONMENT_PRESET_CONCERTHALL     : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -500; flRoomRolloffFactor: 0.0; flDecayTime: 3.92; flDecayHFRatio: 0.70; lReflections: -1230; flReflectionsDelay: 0.020; lReverb:    -2; flReverbDelay: 0.029; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_CONCERTHALL}
  I3DL2_ENVIRONMENT_PRESET_CAVE            : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:     0; flRoomRolloffFactor: 0.0; flDecayTime: 2.91; flDecayHFRatio: 1.30; lReflections:  -602; flReflectionsDelay: 0.015; lReverb:  -302; flReverbDelay: 0.022; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_CAVE}
  I3DL2_ENVIRONMENT_PRESET_ARENA           : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -698; flRoomRolloffFactor: 0.0; flDecayTime: 7.24; flDecayHFRatio: 0.33; lReflections: -1166; flReflectionsDelay: 0.020; lReverb:    16; flReverbDelay: 0.030; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_ARENA}
  I3DL2_ENVIRONMENT_PRESET_HANGAR          : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF: -1000; flRoomRolloffFactor: 0.0; flDecayTime:10.05; flDecayHFRatio: 0.23; lReflections:  -602; flReflectionsDelay: 0.020; lReverb:   198; flReverbDelay: 0.030; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_HANGAR}
  I3DL2_ENVIRONMENT_PRESET_CARPETEDHALLWAY : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF: -4000; flRoomRolloffFactor: 0.0; flDecayTime: 0.30; flDecayHFRatio: 0.10; lReflections: -1831; flReflectionsDelay: 0.002; lReverb: -1630; flReverbDelay: 0.030; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_CARPETEDHALLWAY}
  I3DL2_ENVIRONMENT_PRESET_HALLWAY         : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -300; flRoomRolloffFactor: 0.0; flDecayTime: 1.49; flDecayHFRatio: 0.59; lReflections: -1219; flReflectionsDelay: 0.007; lReverb:   441; flReverbDelay: 0.011; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_HALLWAY}
  I3DL2_ENVIRONMENT_PRESET_STONECORRIDOR   : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -237; flRoomRolloffFactor: 0.0; flDecayTime: 2.70; flDecayHFRatio: 0.79; lReflections: -1214; flReflectionsDelay: 0.013; lReverb:   395; flReverbDelay: 0.020; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_STONECORRIDOR}
  I3DL2_ENVIRONMENT_PRESET_ALLEY           : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -270; flRoomRolloffFactor: 0.0; flDecayTime: 1.49; flDecayHFRatio: 0.86; lReflections: -1204; flReflectionsDelay: 0.007; lReverb:    -4; flReverbDelay: 0.011; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_ALLEY}
  I3DL2_ENVIRONMENT_PRESET_FOREST          : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF: -3300; flRoomRolloffFactor: 0.0; flDecayTime: 1.49; flDecayHFRatio: 0.54; lReflections: -2560; flReflectionsDelay: 0.162; lReverb:  -613; flReverbDelay: 0.088; flDiffusion:  79.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_FOREST}
  I3DL2_ENVIRONMENT_PRESET_CITY            : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -800; flRoomRolloffFactor: 0.0; flDecayTime: 1.49; flDecayHFRatio: 0.67; lReflections: -2273; flReflectionsDelay: 0.007; lReverb: -2217; flReverbDelay: 0.011; flDiffusion:  50.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_CITY}
  I3DL2_ENVIRONMENT_PRESET_MOUNTAINS       : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF: -2500; flRoomRolloffFactor: 0.0; flDecayTime: 1.49; flDecayHFRatio: 0.21; lReflections: -2780; flReflectionsDelay: 0.300; lReverb: -2014; flReverbDelay: 0.100; flDiffusion:  27.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_MOUNTAINS}
  I3DL2_ENVIRONMENT_PRESET_QUARRY          : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF: -1000; flRoomRolloffFactor: 0.0; flDecayTime: 1.49; flDecayHFRatio: 0.83; lReflections:-10000; flReflectionsDelay: 0.061; lReverb:   500; flReverbDelay: 0.025; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_QUARRY}
  I3DL2_ENVIRONMENT_PRESET_PLAIN           : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF: -2000; flRoomRolloffFactor: 0.0; flDecayTime: 1.49; flDecayHFRatio: 0.50; lReflections: -2466; flReflectionsDelay: 0.179; lReverb: -2514; flReverbDelay: 0.100; flDiffusion:  21.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_PLAIN}
  I3DL2_ENVIRONMENT_PRESET_PARKINGLOT      : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:     0; flRoomRolloffFactor: 0.0; flDecayTime: 1.65; flDecayHFRatio: 1.50; lReflections: -1363; flReflectionsDelay: 0.008; lReverb: -1153; flReverbDelay: 0.012; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_PARKINGLOT}
  I3DL2_ENVIRONMENT_PRESET_SEWERPIPE       : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF: -1000; flRoomRolloffFactor: 0.0; flDecayTime: 2.81; flDecayHFRatio: 0.14; lReflections:   429; flReflectionsDelay: 0.014; lReverb:   648; flReverbDelay: 0.021; flDiffusion:  80.0; flDensity:  60.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_SEWERPIPE}
  I3DL2_ENVIRONMENT_PRESET_UNDERWATER      : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF: -4000; flRoomRolloffFactor: 0.0; flDecayTime: 1.49; flDecayHFRatio: 0.10; lReflections:  -449; flReflectionsDelay: 0.007; lReverb:  1700; flReverbDelay: 0.011; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_UNDERWATER}

  //
  // Examples simulating 'musical' reverb presets
  //
  // Name       Decay time   Description
  // Small Room    1.1s      A small size room with a length of 5m or so.
  // Medium Room   1.3s      A medium size room with a length of 10m or so.
  // Large Room    1.5s      A large size room suitable for live performances.
  // Medium Hall   1.8s      A medium size concert hall.
  // Large Hall    1.8s      A large size concert hall suitable for a full orchestra.
  // Plate         1.3s      A plate reverb simulation.
  //

  I3DL2_ENVIRONMENT_PRESET_SMALLROOM       : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -600; flRoomRolloffFactor: 0.0; flDecayTime: 1.10; flDecayHFRatio: 0.83; lReflections:  -400; flReflectionsDelay: 0.005; lReverb:   500; flReverbDelay: 0.010; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_SMALLROOM}
  I3DL2_ENVIRONMENT_PRESET_MEDIUMROOM      : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -600; flRoomRolloffFactor: 0.0; flDecayTime: 1.30; flDecayHFRatio: 0.83; lReflections: -1000; flReflectionsDelay: 0.010; lReverb:  -200; flReverbDelay: 0.020; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_MEDIUMROOM}
  I3DL2_ENVIRONMENT_PRESET_LARGEROOM       : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -600; flRoomRolloffFactor: 0.0; flDecayTime: 1.50; flDecayHFRatio: 0.83; lReflections: -1600; flReflectionsDelay: 0.020; lReverb: -1000; flReverbDelay: 0.040; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_LARGEROOM}
  I3DL2_ENVIRONMENT_PRESET_MEDIUMHALL      : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -600; flRoomRolloffFactor: 0.0; flDecayTime: 1.80; flDecayHFRatio: 0.70; lReflections: -1300; flReflectionsDelay: 0.015; lReverb:  -800; flReverbDelay: 0.030; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_MEDIUMHALL}
  I3DL2_ENVIRONMENT_PRESET_LARGEHALL       : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -600; flRoomRolloffFactor: 0.0; flDecayTime: 1.80; flDecayHFRatio: 0.70; lReflections: -2000; flReflectionsDelay: 0.030; lReverb: -1400; flReverbDelay: 0.060; flDiffusion: 100.0; flDensity: 100.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_LARGEHALL}
  I3DL2_ENVIRONMENT_PRESET_PLATE           : TDSFXI3DL2Reverb = (lRoom: -1000; lRoomHF:  -200; flRoomRolloffFactor: 0.0; flDecayTime: 1.30; flDecayHFRatio: 0.90; lReflections:     0; flReflectionsDelay: 0.002; lReverb:     0; flReverbDelay: 0.010; flDiffusion: 100.0; flDensity:  75.0; flHFReference: 5000.0);
  {$EXTERNALSYM I3DL2_ENVIRONMENT_PRESET_PLATE}

  //
  // DirectSound3D Algorithms
  //

  // Default DirectSound3D algorithm {00000000-0000-0000-0000-000000000000}
  DS3DALG_DEFAULT : TGUID = '{00000000-0000-0000-0000-000000000000}'; // GUID_NULL;
  {$EXTERNALSYM DS3DALG_DEFAULT}

  // No virtualization (Pan3D) {C241333F-1C1B-11d2-94F5-00C04FC28ACA}
  DS3DALG_NO_VIRTUALIZATION: TGUID = '{c241333f-1c1b-11d2-94f5-00c04fc28aca}';
  {$EXTERNALSYM DS3DALG_NO_VIRTUALIZATION}

  // High-quality HRTF algorithm {C2413340-1C1B-11d2-94F5-00C04FC28ACA}
  DS3DALG_HRTF_FULL: TGUID = '{c2413340-1c1b-11d2-94f5-00c04fc28aca}';
  {$EXTERNALSYM DS3DALG_HRTF_FULL}

  // Lower-quality HRTF algorithm {C2413342-1C1B-11d2-94F5-00C04FC28ACA}
  DS3DALG_HRTF_LIGHT: TGUID = '{c2413342-1c1b-11d2-94f5-00c04fc28aca}';
  {$EXTERNALSYM DS3DALG_HRTF_LIGHT}


 // #if DIRECTSOUND_VERSION >= 0x0800

  //
  // DirectSound Internal Effect Algorithms
  //


  // Gargle {DAFD8210-5711-4B91-9FE3-F75B7AE279BF}
  GUID_DSFX_STANDARD_GARGLE: TGUID = '{dafd8210-5711-4b91-9fe3-f75b7ae279bf}';
  {$EXTERNALSYM GUID_DSFX_STANDARD_GARGLE}

  // Chorus {EFE6629C-81F7-4281-BD91-C9D604A95AF6}
  GUID_DSFX_STANDARD_CHORUS: TGUID = '{efe6629c-81f7-4281-bd91-c9d604a95af6}';
  {$EXTERNALSYM GUID_DSFX_STANDARD_CHORUS}

  // Flanger {EFCA3D92-DFD8-4672-A603-7420894BAD98}
  GUID_DSFX_STANDARD_FLANGER: TGUID = '{efca3d92-dfd8-4672-a603-7420894bad98}';
  {$EXTERNALSYM GUID_DSFX_STANDARD_FLANGER}

  // Echo/Delay {EF3E932C-D40B-4F51-8CCF-3F98F1B29D5D}
  GUID_DSFX_STANDARD_ECHO: TGUID = '{ef3e932c-d40b-4f51-8ccf-3f98f1b29d5d}';
  {$EXTERNALSYM GUID_DSFX_STANDARD_ECHO}

  // Distortion {EF114C90-CD1D-484E-96E5-09CFAF912A21}
  GUID_DSFX_STANDARD_DISTORTION: TGUID = '{ef114c90-cd1d-484e-96e5-09cfaf912a21}';
  {$EXTERNALSYM GUID_DSFX_STANDARD_DISTORTION}

  // Compressor/Limiter {EF011F79-4000-406D-87AF-BFFB3FC39D57}
  GUID_DSFX_STANDARD_COMPRESSOR: TGUID = '{ef011f79-4000-406d-87af-bffb3fc39d57}';
  {$EXTERNALSYM GUID_DSFX_STANDARD_COMPRESSOR}

  // Parametric Equalization {120CED89-3BF4-4173-A132-3CB406CF3231}
  GUID_DSFX_STANDARD_PARAMEQ: TGUID = '{120ced89-3bf4-4173-a132-3cb406cf3231}';
  {$EXTERNALSYM GUID_DSFX_STANDARD_PARAMEQ}

  // I3DL2 Environmental Reverberation: Reverb (Listener) Effect {EF985E71-D5C7-42D4-BA4D-2D073E2E96F4}
  GUID_DSFX_STANDARD_I3DL2REVERB: TGUID = '{ef985e71-d5c7-42d4-ba4d-2d073e2e96f4}';
  {$EXTERNALSYM GUID_DSFX_STANDARD_I3DL2REVERB}

  // Waves Reverberation {87FC0268-9A55-4360-95AA-004A1D9DE26C}
  GUID_DSFX_WAVES_REVERB: TGUID = '{87fc0268-9a55-4360-95aa-004a1d9de26c}';
  {$EXTERNALSYM GUID_DSFX_WAVES_REVERB}

  //
  // DirectSound Capture Effect Algorithms
  //


  // Acoustic Echo Canceller {BF963D80-C559-11D0-8A2B-00A0C9255AC1}
  // Matches KSNODETYPE_ACOUSTIC_ECHO_CANCEL in ksmedia.h
  GUID_DSCFX_CLASS_AEC: TGUID = '{BF963D80-C559-11D0-8A2B-00A0C9255AC1}';
  {$EXTERNALSYM GUID_DSCFX_CLASS_AEC}

  // Microsoft AEC {CDEBB919-379A-488a-8765-F53CFD36DE40}
  GUID_DSCFX_MS_AEC: TGUID = '{cdebb919-379a-488a-8765-f53cfd36de40}';
  {$EXTERNALSYM GUID_DSCFX_MS_AEC}

  // System AEC {1C22C56D-9879-4f5b-A389-27996DDC2810}
  GUID_DSCFX_SYSTEM_AEC: TGUID = '{1c22c56d-9879-4f5b-a389-27996ddc2810}';
  {$EXTERNALSYM GUID_DSCFX_SYSTEM_AEC}

  // Noise Supression {E07F903F-62FD-4e60-8CDD-DEA7236665B5}
  // Matches KSNODETYPE_NOISE_SUPPRESS in post Windows ME DDK's ksmedia.h
  GUID_DSCFX_CLASS_NS: TGUID = '{e07f903f-62fd-4e60-8cdd-dea7236665b5}';
  {$EXTERNALSYM GUID_DSCFX_CLASS_NS}

  // Microsoft Noise Suppresion {11C5C73B-66E9-4ba1-A0BA-E814C6EED92D}
  GUID_DSCFX_MS_NS: TGUID = '{11c5c73b-66e9-4ba1-a0ba-e814c6eed92d}';
  {$EXTERNALSYM GUID_DSCFX_MS_NS}

  // System Noise Suppresion {5AB0882E-7274-4516-877D-4EEE99BA4FD0}
  GUID_DSCFX_SYSTEM_NS: TGUID = '{5ab0882e-7274-4516-877d-4eee99ba4fd0}';
  {$EXTERNALSYM GUID_DSCFX_SYSTEM_NS}

 // DIRECTSOUND_VERSION >= 0x0800



//
// DirectSound API
//

type
  TDSEnumCallbackA = function(lpGuid: PGUID; lpcstrDescription, lpcstrModule: PAnsiChar;
    lpContext: Pointer): BOOL; stdcall;
  {$NODEFINE TDSEnumCallbackA}
  TDSEnumCallbackW = function(lpGuid: PGUID; lpcstrDescription, lpcstrModule: PWideChar;
    lpContext: Pointer): BOOL; stdcall;
  {$NODEFINE TDSEnumCallbackW}
  TDSEnumCallback = TDSEnumCallbackA;
  {$NODEFINE TDSEnumCallback}
  {$HPPEMIT 'typedef LPDSENUMCALLBACKA TDSEnumCallbackA;'}
  {$HPPEMIT 'typedef LPDSENUMCALLBACKW TDSEnumCallbackW;'}
  {$HPPEMIT 'typedef LPDSENUMCALLBACK TDSEnumCallback;'}

const
  DirectSoundDll = 'dsound.dll';

function DirectSoundLoaded: Boolean;
function UnLoadDirectSound: Boolean;
function LoadDirectSound: Boolean;

function DirectSoundCreate(lpGuid: PGUID; out ppDS: IDirectSound; pUnkOuter: IUnknown): HResult; stdcall; external DirectSoundDLL;
{$EXTERNALSYM DirectSoundCreate}
function DirectSoundEnumerateW(lpDSEnumCallback: TDSEnumCallbackW; lpContext: Pointer): HResult; stdcall; external DirectSoundDLL name 'DirectSoundEnumerateW';
{$EXTERNALSYM DirectSoundEnumerateW}
function DirectSoundEnumerateA(lpDSEnumCallback: TDSEnumCallbackA; lpContext: Pointer): HResult; stdcall; external DirectSoundDLL name 'DirectSoundEnumerateA';
{$EXTERNALSYM DirectSoundEnumerateA}
function DirectSoundEnumerate(lpDSEnumCallback: TDSEnumCallback; lpContext: Pointer): HResult; stdcall; external DirectSoundDLL name 'DirectSoundEnumerateA';
{$EXTERNALSYM DirectSoundEnumerate}

function DirectSoundCaptureCreate(lpGUID: PGUID; out lplpDSC: IDirectSoundCapture; pUnkOuter: IUnknown): HResult; stdcall; external DirectSoundDLL;
{$EXTERNALSYM DirectSoundCaptureCreate}
function DirectSoundCaptureEnumerateW(lpDSEnumCallback: TDSEnumCallbackW; lpContext: Pointer): HResult; stdcall; external DirectSoundDLL name 'DirectSoundCaptureEnumerateW';
{$EXTERNALSYM DirectSoundCaptureEnumerateW}
function DirectSoundCaptureEnumerateA(lpDSEnumCallback: TDSEnumCallbackA; lpContext: Pointer): HResult; stdcall; external DirectSoundDLL name 'DirectSoundCaptureEnumerateA';
{$EXTERNALSYM DirectSoundCaptureEnumerateA}
function DirectSoundCaptureEnumerate(lpDSEnumCallback: TDSEnumCallback; lpContext: Pointer): HResult; stdcall; external DirectSoundDLL name 'DirectSoundCaptureEnumerateA';
{$EXTERNALSYM DirectSoundCaptureEnumerate}

//#if DIRECTSOUND_VERSION >= 0x0800
function DirectSoundCreate8(pcGuidDevice: PGUID; out ppDS8: IDirectSound8; pUnkOuter: IUnknown): HResult; stdcall; external DirectSoundDLL;
{$EXTERNALSYM DirectSoundCreate8}
function DirectSoundCaptureCreate8(pcGuidDevice: PGUID; out ppDSC8: IDirectSoundCapture8; pUnkOuter: IUnknown): HResult; stdcall; external DirectSoundDLL;
{$EXTERNALSYM DirectSoundCaptureCreate8}
function DirectSoundFullDuplexCreate(pcGuidCaptureDevice, pcGuidRenderDevice: PGUID;
  const pcDSCBufferDesc: TDSCBufferDesc; const pcDSBufferDesc: TDSBufferDesc;
  hWnd: hWnd; dwLevel: DWORD; out ppDSFD: IDirectSoundFullDuplex8;
  out ppDSCBuffer8: IDirectSoundCaptureBuffer8; out ppDSBuffer8: IDirectSoundBuffer8;
  pUnkOuter: IUnknown): HResult; stdcall; external DirectSoundDLL;
{$EXTERNALSYM DirectSoundFullDuplexCreate}
function DirectSoundFullDuplexCreate8(pcGuidCaptureDevice, pcGuidRenderDevice: PGUID;
  const pcDSCBufferDesc: TDSCBufferDesc; const pcDSBufferDesc: TDSBufferDesc;
  hWnd: hWnd; dwLevel: DWORD; out ppDSFD: IDirectSoundFullDuplex8;
  out ppDSCBuffer8: IDirectSoundCaptureBuffer8; out ppDSBuffer8: IDirectSoundBuffer8;
  pUnkOuter: IUnknown): HResult; stdcall; external DirectSoundDLL name 'DirectSoundFullDuplexCreate';
{$EXTERNALSYM DirectSoundFullDuplexCreate8}

function GetDeviceID(pGuidSrc, pGuidDest: PGUID): HResult; stdcall; external DirectSoundDLL;
{$EXTERNALSYM GetDeviceID}
//#endif // DIRECTSOUND_VERSION >= 0x0800



implementation

// #define MAKE_DSHRESULT(code)  MAKE_HRESULT(1, _FACDS, code)
function MAKE_DSHRESULT(Code: DWord): DWord;
begin
  Result:= DWord((1 shl 31) or (_FACDS shl 16)) or Code;
end;

// #define DSSPEAKER_COMBINED(c, g)    ((DWORD)(((BYTE)(c)) | ((DWORD)((BYTE)(g))) << 16))
function DSSPEAKER_COMBINED(c, g: DWORD): DWORD;
begin
  Result:= Byte(c) or (DWORD(Byte(g)) shl 16);
end;

// #define DSSPEAKER_CONFIG(a)         ((BYTE)(a))
function DSSPEAKER_CONFIG(a: Cardinal): Byte;
begin
  Result:= Byte(a);
end;

// #define DSSPEAKER_GEOMETRY(a)       ((BYTE)(((DWORD)(a) >> 16) & 0x00FF))
function DSSPEAKER_GEOMETRY(a: Cardinal): Byte;
begin
  Result:= Byte((DWORD(a) shr 16) and $00FF);
end;


function DirectSoundLoaded: Boolean;
begin // Stub function for static linking
  Result:= True;
end;

function UnLoadDirectSound: Boolean;
begin // Stub function for static linking
  Result:= True; // should emulate "normal" behaviour
end;

function LoadDirectSound: Boolean;
begin // Stub function for static linking
  Result:= True;
end;


end.
