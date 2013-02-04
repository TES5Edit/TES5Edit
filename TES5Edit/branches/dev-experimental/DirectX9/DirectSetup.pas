{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) 1995-1997 Microsoft Corporation.  All Rights Reserved.      *}
{*                                                                            *}
{*  Files:      dsetup.h                                                      *}
{*  Content:    DirectXSetup, error codes and flags                           *}
{*                                                                            *}
{*  DirectX 9.0 Delphi / FreePascal adaptation by Alexey Barkovoy             *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://www.clootie.ru                                                   *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
{*----------------------------------------------------------------------------*}
{*  $Id: DirectSetup.pas,v 1.1 2005/10/10 21:11:07 clootie Exp $ }
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

unit DirectSetup;

interface

(*$HPPEMIT '#include "dsetup.h"' *)

uses
  Windows;

////////////////////////////////////////////////////////////////////////
// Global level dynamic loading support

// Remove "dots" below to force some kind of dynamic linking
{.$DEFINE DIRECTSETUP_DYNAMIC_LINK}
{.$DEFINE DIRECTSETUP_DYNAMIC_LINK_EXPLICIT}


const
  // FOURCC_VERS                 = mmioFOURCC('v','e','r','s')
  FOURCC_VERS                 = Byte('v') or (Byte('e') shl 8) or (Byte('r') shl 16) or (Byte('s') shl 24);
  {$EXTERNALSYM FOURCC_VERS}

  // DSETUP Error Codes, must remain compatible with previous setup.
  DSETUPERR_SUCCESS_RESTART        = 1;
  {$EXTERNALSYM DSETUPERR_SUCCESS_RESTART}
  DSETUPERR_SUCCESS                = 0;
  {$EXTERNALSYM DSETUPERR_SUCCESS}
  DSETUPERR_BADWINDOWSVERSION     = -1;
  {$EXTERNALSYM DSETUPERR_BADWINDOWSVERSION}
  DSETUPERR_SOURCEFILENOTFOUND    = -2;
  {$EXTERNALSYM DSETUPERR_SOURCEFILENOTFOUND}
  DSETUPERR_NOCOPY                = -5;
  {$EXTERNALSYM DSETUPERR_NOCOPY}
  DSETUPERR_OUTOFDISKSPACE        = -6;
  {$EXTERNALSYM DSETUPERR_OUTOFDISKSPACE}
  DSETUPERR_CANTFINDINF           = -7;
  {$EXTERNALSYM DSETUPERR_CANTFINDINF}
  DSETUPERR_CANTFINDDIR           = -8;
  {$EXTERNALSYM DSETUPERR_CANTFINDDIR}
  DSETUPERR_INTERNAL              = -9;
  {$EXTERNALSYM DSETUPERR_INTERNAL}
  DSETUPERR_UNKNOWNOS             = -11;
  {$EXTERNALSYM DSETUPERR_UNKNOWNOS}
  DSETUPERR_NEWERVERSION          = -14;
  {$EXTERNALSYM DSETUPERR_NEWERVERSION}
  DSETUPERR_NOTADMIN              = -15;
  {$EXTERNALSYM DSETUPERR_NOTADMIN}
  DSETUPERR_UNSUPPORTEDPROCESSOR  = -16;
  {$EXTERNALSYM DSETUPERR_UNSUPPORTEDPROCESSOR}
  DSETUPERR_MISSINGCAB_MANAGEDDX  = -17;
  {$EXTERNALSYM DSETUPERR_MISSINGCAB_MANAGEDDX}
  DSETUPERR_NODOTNETFRAMEWORKINSTALLED = -18;
  {$EXTERNALSYM DSETUPERR_NODOTNETFRAMEWORKINSTALLED}
  DSETUPERR_CABDOWNLOADFAIL       = -19;
  {$EXTERNALSYM DSETUPERR_CABDOWNLOADFAIL}
  DSETUPERR_DXCOMPONENTFILEINUSE  = -20;
  {$EXTERNALSYM DSETUPERR_DXCOMPONENTFILEINUSE}
  DSETUPERR_UNTRUSTEDCABINETFILE  = -21;
  {$EXTERNALSYM DSETUPERR_UNTRUSTEDCABINETFILE}

  // DSETUP flags. DirectX 5.0 apps should use these flags only.
  DSETUP_DDRAWDRV         = $00000008;      (* install DirectDraw Drivers           *)
  {$EXTERNALSYM DSETUP_DDRAWDRV}
  DSETUP_DSOUNDDRV        = $00000010;      (* install DirectSound Drivers          *)
  {$EXTERNALSYM DSETUP_DSOUNDDRV}
  DSETUP_DXCORE           = $00010000;      (* install DirectX runtime              *)
  {$EXTERNALSYM DSETUP_DXCORE}
  DSETUP_DIRECTX  = (DSETUP_DXCORE or DSETUP_DDRAWDRV or DSETUP_DSOUNDDRV);
  {$EXTERNALSYM DSETUP_DIRECTX}
  DSETUP_MANAGEDDX        = $00004000;      (* OBSOLETE. install managed DirectX    *)
  {$EXTERNALSYM DSETUP_MANAGEDDX}
  DSETUP_TESTINSTALL      = $00020000;      (* just test install, don't do anything *)
  {$EXTERNALSYM DSETUP_TESTINSTALL}

  // These OBSOLETE flags are here for compatibility with pre-DX5 apps only.
  // They are present to allow DX3 apps to be recompiled with DX5 and still work.
  // DO NOT USE THEM for DX5. They will go away in future DX releases.
  DSETUP_DDRAW            = $00000001;      (* OBSOLETE. install DirectDraw           *)
  {$EXTERNALSYM DSETUP_DDRAW}
  DSETUP_DSOUND           = $00000002;      (* OBSOLETE. install DirectSound          *)
  {$EXTERNALSYM DSETUP_DSOUND}
  DSETUP_DPLAY            = $00000004;      (* OBSOLETE. install DirectPlay           *)
  {$EXTERNALSYM DSETUP_DPLAY}
  DSETUP_DPLAYSP          = $00000020;      (* OBSOLETE. install DirectPlay Providers *)
  {$EXTERNALSYM DSETUP_DPLAYSP}
  DSETUP_DVIDEO           = $00000040;      (* OBSOLETE. install DirectVideo          *)
  {$EXTERNALSYM DSETUP_DVIDEO}
  DSETUP_D3D              = $00000200;      (* OBSOLETE. install Direct3D             *)
  {$EXTERNALSYM DSETUP_D3D}
  DSETUP_DINPUT           = $00000800;      (* OBSOLETE. install DirectInput          *)
  {$EXTERNALSYM DSETUP_DINPUT}
  DSETUP_DIRECTXSETUP     = $00001000;      (* OBSOLETE. install DirectXSetup DLL's   *)
  {$EXTERNALSYM DSETUP_DIRECTXSETUP}
  DSETUP_NOUI             = $00002000;      (* OBSOLETE. install DirectX with NO UI   *)
  {$EXTERNALSYM DSETUP_NOUI}
  DSETUP_PROMPTFORDRIVERS = $10000000;      (* OBSOLETE. prompt when replacing display/audio drivers *)
  {$EXTERNALSYM DSETUP_PROMPTFORDRIVERS}
  DSETUP_RESTOREDRIVERS   = $20000000;      (* OBSOLETE. restore display/audio drivers *)
  {$EXTERNALSYM DSETUP_RESTOREDRIVERS}


  //******************************************************************
  // DirectX Setup Callback mechanism
  //******************************************************************

  // DSETUP Message Info Codes, passed to callback as Reason parameter.
  DSETUP_CB_MSG_NOMESSAGE                     = 0;
  {$EXTERNALSYM DSETUP_CB_MSG_NOMESSAGE}
  DSETUP_CB_MSG_INTERNAL_ERROR                = 10;
  {$EXTERNALSYM DSETUP_CB_MSG_INTERNAL_ERROR}
  DSETUP_CB_MSG_BEGIN_INSTALL                 = 13;
  {$EXTERNALSYM DSETUP_CB_MSG_BEGIN_INSTALL}
  DSETUP_CB_MSG_BEGIN_INSTALL_RUNTIME         = 14;
  {$EXTERNALSYM DSETUP_CB_MSG_BEGIN_INSTALL_RUNTIME}
  DSETUP_CB_MSG_PROGRESS                      = 18;
  {$EXTERNALSYM DSETUP_CB_MSG_PROGRESS}
  DSETUP_CB_MSG_WARNING_DISABLED_COMPONENT    = 19;
  {$EXTERNALSYM DSETUP_CB_MSG_WARNING_DISABLED_COMPONENT}


type
  PDSetupCBProgress = ^TDSetupCBProgress;
  _DSETUP_CB_PROGRESS = record
    dwPhase: DWORD;
    dwInPhaseMaximum: DWORD;
    dwInPhaseProgress: DWORD;
    dwOverallMaximum: DWORD;
    dwOverallProgress: DWORD;
  end;
  {$EXTERNALSYM _DSETUP_CB_PROGRESS}
  DSETUP_CB_PROGRESS = _DSETUP_CB_PROGRESS;
  {$EXTERNALSYM DSETUP_CB_PROGRESS}
  TDSetupCBProgress = _DSETUP_CB_PROGRESS;


  _DSETUP_CB_PROGRESS_PHASE = (
    DSETUP_INITIALIZING,
    DSETUP_EXTRACTING,
    DSETUP_COPYING,
    DSETUP_FINALIZING
  );
  {$EXTERNALSYM _DSETUP_CB_PROGRESS_PHASE}
  TDSetupCBProgressPhase = _DSETUP_CB_PROGRESS_PHASE;


  //
  // Data Structures
  //

  PDirectXRegisterAppA = ^TDirectXRegisterAppA;
  _DIRECTXREGISTERAPPA = record
    dwSize:               DWORD;
    dwFlags:              DWORD;
    lpszApplicationName:  PAnsiChar;
    lpGUID:               PGUID;
    lpszFilename:         PAnsiChar;
    lpszCommandLine:      PAnsiChar;
    lpszPath:             PAnsiChar;
    lpszCurrentDirectory: PAnsiChar;
  end;
  {$EXTERNALSYM _DIRECTXREGISTERAPPA}
  DIRECTXREGISTERAPPA = _DIRECTXREGISTERAPPA;
  {$EXTERNALSYM DIRECTXREGISTERAPPA}
  TDirectXRegisterAppA = _DIRECTXREGISTERAPPA;

  PDirectXRegisterApp2A = ^TDirectXRegisterApp2A;
  _DIRECTXREGISTERAPP2A = record
    dwSize:               DWORD;
    dwFlags:              DWORD;
    lpszApplicationName:  PAnsiChar;
    lpGUID:               PGUID;
    lpszFilename:         PAnsiChar;
    lpszCommandLine:      PAnsiChar;
    lpszPath:             PAnsiChar;
    lpszCurrentDirectory: PAnsiChar;
    lpszLauncherName:     PAnsiChar;
  end;
  {$EXTERNALSYM _DIRECTXREGISTERAPP2A}
  DIRECTXREGISTERAPP2A = _DIRECTXREGISTERAPP2A;
  {$EXTERNALSYM DIRECTXREGISTERAPP2A}
  TDirectXRegisterApp2A = _DIRECTXREGISTERAPP2A;

  PDirectXRegisterAppW = ^TDirectXRegisterAppW;
  _DIRECTXREGISTERAPPW = record
    dwSize:               DWORD;
    dwFlags:              DWORD;
    lpszApplicationName:  PWideChar;
    lpGUID:               PGUID;
    lpszFilename:         PWideChar;
    lpszCommandLine:      PWideChar;
    lpszPath:             PWideChar;
    lpszCurrentDirectory: PWideChar;
  end;
  {$EXTERNALSYM _DIRECTXREGISTERAPPW}
  DIRECTXREGISTERAPPW = _DIRECTXREGISTERAPPW;
  {$EXTERNALSYM DIRECTXREGISTERAPPW}
  TDirectXRegisterAppW = _DIRECTXREGISTERAPPW;

  PDirectXRegisterApp2W = ^TDirectXRegisterApp2W;
  _DIRECTXREGISTERAPP2W = record
    dwSize:               DWORD;
    dwFlags:              DWORD;
    lpszApplicationName:  PWideChar;
    lpGUID:               PGUID;
    lpszFilename:         PWideChar;
    lpszCommandLine:      PWideChar;
    lpszPath:             PWideChar;
    lpszCurrentDirectory: PWideChar;
    lpszLauncherName:     PWideChar;
  end;
  {$EXTERNALSYM _DIRECTXREGISTERAPP2W}
  DIRECTXREGISTERAPP2W = _DIRECTXREGISTERAPP2W;
  {$EXTERNALSYM DIRECTXREGISTERAPP2W}
  TDirectXRegisterApp2W = _DIRECTXREGISTERAPP2W;

  
  PDirectXRegisterApp = ^TDirectXRegisterApp;
  PDirectXRegisterApp2 = ^TDirectXRegisterApp2;
  TDirectXRegisterApp = TDirectXRegisterAppA;
  TDirectXRegisterApp2 = TDirectXRegisterApp2A;


//
// API
//

var
  DirectXSetupW: function (hWnd: HWND; lpszRootPath: PWideChar; dwFlags: DWORD): Integer; stdcall;
  {$EXTERNALSYM DirectXSetupW}
  DirectXSetupA: function (hWnd: HWND; lpszRootPath: PAnsiChar; dwFlags: DWORD): Integer; stdcall;
  {$EXTERNALSYM DirectXSetupA}
  DirectXSetup: function (hWnd: HWND; lpszRootPath: PChar; dwFlags: DWORD): Integer; stdcall;
  {$EXTERNALSYM DirectXSetup}

  DirectXRegisterApplicationW: function (hWnd: HWND; const lpDXRegApp: TDirectXRegisterAppW): Integer; stdcall;
  {$EXTERNALSYM DirectXRegisterApplicationW}
  DirectXRegisterApplicationA: function (hWnd: HWND; const lpDXRegApp: TDirectXRegisterAppA): Integer; stdcall;
  {$EXTERNALSYM DirectXRegisterApplicationA}
  DirectXRegisterApplication: function (hWnd: HWND; const lpDXRegApp: TDirectXRegisterApp): Integer; stdcall;
  {$EXTERNALSYM DirectXRegisterApplication}

  DirectXUnRegisterApplication: function (hWnd: HWND; const lpGUID: TGUID): Integer; stdcall;
  {$EXTERNALSYM DirectXUnRegisterApplication}

type
  TDSetupCallback = function (Reason: DWORD; MsgType: DWORD; (* Same as flags to MessageBox *)
      szMessage: PChar; szName: PChar; pInfo: Pointer): DWORD; stdcall;
  {$EXTERNALSYM TDSetupCallback}

var
  DirectXSetupSetCallback: function (Callback: TDSetupCallback): Integer; stdcall;
  {$EXTERNALSYM DirectXSetupSetCallback}
  DirectXSetupGetVersion: function (out lpdwVersion, lpdwMinorVersion: DWORD): Integer; stdcall;
  {$EXTERNALSYM DirectXSetupGetVersion}
  DirectXSetupShowEULA: function(hWndParent: HWND): Integer; stdcall;
  {$EXTERNALSYM DirectXSetupShowEULA}

  DirectXSetupGetEULAA: function(lpszEULA: PAnsiChar; cchEULA: LongWord; LangID: Word): LongWord; stdcall;
  {$EXTERNALSYM DirectXSetupGetEULAA}
  DirectXSetupGetEULAW: function(lpszEULA: PWideChar; cchEULA: LongWord; LangID: Word): LongWord; stdcall;
  {$EXTERNALSYM DirectXSetupGetEULAW}
  DirectXSetupGetEULA: function(lpszEULA: PChar; cchEULA: LongWord; LangID: Word): LongWord; stdcall;
  {$EXTERNALSYM DirectXSetupGetEULA}

function DirectSetupLoaded: Boolean;
function UnLoadDirectSetup: Boolean;
function LoadDirectSetup: Boolean;


implementation

const
  DirectSetupDll = 'dsetup.dll';

var
  DirectSetupLib: THandle = 0;

function DirectSetupLoaded: Boolean;
begin
  Result:= (DirectSetupLib <> 0);
end;

function UnLoadDirectSetup: Boolean;
begin
  Result:= True;
  if (DirectSetupLib <> 0) then
  begin
    Result:= Result and FreeLibrary(DirectSetupLib);

    DirectXSetupA := nil;
    DirectXSetupW := nil;
    DirectXSetup := nil;

    DirectXRegisterApplicationA := nil;
    DirectXRegisterApplicationW := nil;
    DirectXRegisterApplication := nil;

    DirectXUnRegisterApplication := nil;

    DirectXSetupSetCallback := nil;
    DirectXSetupGetVersion := nil;
    DirectXSetupShowEULA := nil;

    DirectXSetupGetEULAA := nil;
    DirectXSetupGetEULAW := nil;
    DirectXSetupGetEULA := nil;

    DirectSetupLib:= 0;
  end;
end;

function LoadDirectSetup: Boolean;
begin
  Result:= DirectSetupLoaded;
  if (not Result) then
  begin
    DirectSetupLib:= LoadLibrary(DirectSetupDll);
    if (DirectSetupLib <> 0) then
    begin
      DirectXSetupA := GetProcAddress(DirectSetupLib, 'DirectXSetupA');
      DirectXSetupW := GetProcAddress(DirectSetupLib, 'DirectXSetupW');
      DirectXSetup := DirectXSetupA;

      DirectXRegisterApplicationA := GetProcAddress(DirectSetupLib, 'DirectXRegisterApplicationA');
      DirectXRegisterApplicationW := GetProcAddress(DirectSetupLib, 'DirectXRegisterApplicationW');
      DirectXRegisterApplication := DirectXRegisterApplicationA;

      DirectXUnRegisterApplication := GetProcAddress(DirectSetupLib, 'DirectXUnRegisterApplication');

      DirectXSetupSetCallback := GetProcAddress(DirectSetupLib, 'DirectXSetupSetCallback');
      DirectXSetupGetVersion := GetProcAddress(DirectSetupLib, 'DirectXSetupGetVersion');
      DirectXSetupShowEULA := GetProcAddress(DirectSetupLib, 'DirectXSetupShowEULA');;


      DirectXSetupGetEULAA := GetProcAddress(DirectSetupLib, 'DirectXSetupGetEULAA');;
      DirectXSetupGetEULAW := GetProcAddress(DirectSetupLib, 'DirectXSetupGetEULAW');;
      DirectXSetupGetEULA := DirectXSetupGetEULAA;
    end;

    // At least basic procedure is found!
    Result:= Assigned(DirectXSetup);
    if not Result then UnLoadDirectSetup;
  end;
end;

initialization
  LoadDirectSetup;
finalization
  UnLoadDirectSetup;
end.

