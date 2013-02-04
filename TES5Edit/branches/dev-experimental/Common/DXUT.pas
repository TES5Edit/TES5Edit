(*----------------------------------------------------------------------------*
 *  DirectX 9 SDK April 2007 C++ common framework adaptation for Delphi    *
 *  by Alexey Barkovoy (e-mail: directx@clootie.ru)                           *
 *                                                                            *
 *  Desc: Direct3D part of framework.                                         *
 *  Supported compilers: Delphi 5,6,7,9 FreePascal 2.0                        *
 *                                                                            *
 *  Latest version can be downloaded from:                                    *
 *     http://www.clootie.ru                                                  *
 *     http://sourceforge.net/projects/delphi-dx9sdk                          *
 *----------------------------------------------------------------------------*
 *  $Id: DXUT.pas,v 1.30 2007/04/14 21:34:52 clootie Exp $
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

//--------------------------------------------------------------------------------------
// Files: DXUT.h, DXUT.cpp
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//--------------------------------------------------------------------------------------

{$I DirectX.inc}

unit DXUT;

{
#ifndef UNICODE
#error "DXUT requires a Unicode build. See the nearby comments for details"
//
// If you are using Microsoft Visual C++ .NET, under the General tab of the project
// properties change the Character Set to 'Use Unicode Character Set'.
//
// Windows XP and later are native Unicode so Unicode applications will perform better.
// For Windows 98 and Windows Me support, consider using the Microsoft Layer for Unicode (MSLU).
//
// To use MSLU, link against a set of libraries similar to this
//      /nod:kernel32.lib /nod:advapi32.lib /nod:user32.lib /nod:gdi32.lib /nod:shell32.lib /nod:comdlg32.lib /nod:version.lib /nod:mpr.lib /nod:rasapi32.lib /nod:winmm.lib /nod:winspool.lib /nod:vfw32.lib /nod:secur32.lib /nod:oleacc.lib /nod:oledlg.lib /nod:sensapi.lib UnicoWS.lib kernel32.lib advapi32.lib user32.lib gdi32.lib shell32.lib comdlg32.lib version.lib mpr.lib rasapi32.lib winmm.lib winspool.lib vfw32.lib secur32.lib oleacc.lib oledlg.lib sensapi.lib dxerr.lib dxguid.lib d3dx9d.lib d3d9.lib comctl32.lib
// and put the unicows.dll (available for download from msdn.microsoft.com) in the exe's folder.
//
// For more details see the MSDN article titled:
// "MSLU: Develop Unicode Applications for Windows 9x Platforms with the Microsoft Layer for Unicode"
// at http://msdn.microsoft.com/msdnmag/issues/01/10/MSLU/default.aspx
//
#endif
}

interface

uses
  Windows, Messages,
  Direct3D9, DXTypes, DXUTSettingsDlg, DXUTenum;

const
  VK_XBUTTON1       = $05;    {* NOT contiguous with L & RBUTTON *}
  VK_XBUTTON2       = $06;    {* NOT contiguous with L & RBUTTON *}

  GCLP_HCURSOR        = (-12);
  GWLP_HINSTANCE      = (-6);

const
  //--------------------------------------------------------------------------------------
  // Error codes
  //--------------------------------------------------------------------------------------
  DXUTERR_NODIRECT3D              = HRESULT((1 shl 31) or (FACILITY_ITF shl 16)) or $0901; // MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, 0x0901)
  DXUTERR_NOCOMPATIBLEDEVICES     = HRESULT((1 shl 31) or (FACILITY_ITF shl 16)) or $0902; // MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, 0x0902)
  DXUTERR_MEDIANOTFOUND           = HRESULT((1 shl 31) or (FACILITY_ITF shl 16)) or $0903; // MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, 0x0903)
  DXUTERR_NONZEROREFCOUNT         = HRESULT((1 shl 31) or (FACILITY_ITF shl 16)) or $0904; // MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, 0x0904)
  DXUTERR_CREATINGDEVICE          = HRESULT((1 shl 31) or (FACILITY_ITF shl 16)) or $0905; // MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, 0x0905)
  DXUTERR_RESETTINGDEVICE         = HRESULT((1 shl 31) or (FACILITY_ITF shl 16)) or $0906; // MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, 0x0906)
  DXUTERR_CREATINGDEVICEOBJECTS   = HRESULT((1 shl 31) or (FACILITY_ITF shl 16)) or $0907; // MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, 0x0907)
  DXUTERR_RESETTINGDEVICEOBJECTS  = HRESULT((1 shl 31) or (FACILITY_ITF shl 16)) or $0908; // MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, 0x0908)
  DXUTERR_INCORRECTVERSION        = HRESULT((1 shl 31) or (FACILITY_ITF shl 16)) or $0909; // MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, 0x0909)

type
  //--------------------------------------------------------------------------------------
  // Callback registration
  //--------------------------------------------------------------------------------------
  PDXUTCallbackModifyDeviceSettings = function (var pDeviceSettings: TDXUTDeviceSettings; const pCaps: TD3DCaps9; pUserContext: Pointer): Boolean; stdcall;
  PDXUTCallbackDeviceCreated = function (const pd3dDevice: IDirect3DDevice9; const pBackBufferSurfaceDesc: TD3DSurfaceDesc; pUserContext: Pointer): HRESULT; stdcall;
  PDXUTCallbackDeviceReset = function (const pd3dDevice: IDirect3DDevice9; const pBackBufferSurfaceDesc: TD3DSurfaceDesc; pUserContext: Pointer): HRESULT; stdcall;
  PDXUTCallbackDeviceDestroyed = procedure (pUserContext: Pointer); stdcall;
  PDXUTCallbackDeviceLost = procedure (pUserContext: Pointer); stdcall;
  PDXUTCallbackFrameMove = procedure (const pd3dDevice:IDirect3DDevice9; fTime: Double; fElapsedTime: Single; pUserContext: Pointer); stdcall;
  PDXUTCallbackFrameRender = procedure (const pd3dDevice:IDirect3DDevice9; fTime: Double; fElapsedTime: Single; pUserContext: Pointer); stdcall;
  PDXUTCallbackKeyboard = procedure (nChar: LongWord; bKeyDown, bAltDown: Boolean; pUserContext: Pointer); stdcall;
  PDXUTCallbackMouse = procedure (bLeftButtonDown, bRightButtonDown, bMiddleButtonDown, bSideButton1Down, bSideButton2Down: Boolean; nMouseWheelDelta: Integer; xPos, yPos: Integer; pUserContext: Pointer); stdcall;
  PDXUTCallbackMsgProc = function (hWnd: HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM; out pbNoFurtherProcessing: Boolean; pUserContext: Pointer): LRESULT; stdcall;
  PDXUTCallbackTimer = procedure (idEvent: LongWord; pUserContext: Pointer);



// Device callbacks
procedure DXUTSetCallbackDeviceCreated(pCallbackDeviceCreated: PDXUTCallbackDeviceCreated; pUserContext: Pointer = nil);
procedure DXUTSetCallbackDeviceReset(pCallbackDeviceReset: PDXUTCallbackDeviceReset; pUserContext: Pointer = nil);
procedure DXUTSetCallbackDeviceLost(pCallbackDeviceLost: PDXUTCallbackDeviceLost; pUserContext: Pointer = nil);
procedure DXUTSetCallbackDeviceDestroyed(pCallbackDeviceDestroyed: PDXUTCallbackDeviceDestroyed; pUserContext: Pointer = nil);
procedure DXUTSetCallbackDeviceChanging(pCallbackModifyDeviceSettings: PDXUTCallbackModifyDeviceSettings; pUserContext: Pointer = nil);

// Frame callbacks
procedure DXUTSetCallbackFrameMove(pCallbackFrameMove: PDXUTCallbackFrameMove; pUserContext: Pointer = nil);
procedure DXUTSetCallbackFrameRender(pCallbackFrameRender: PDXUTCallbackFrameRender; pUserContext: Pointer = nil);

// Message callbacks
procedure DXUTSetCallbackKeyboard(pCallbackKeyboard: PDXUTCallbackKeyboard; pUserContext: Pointer = nil);
procedure DXUTSetCallbackMouse(pCallbackMouse: PDXUTCallbackMouse; bIncludeMouseMove: Boolean = False; pUserContext: Pointer = nil);
procedure DXUTSetCallbackMsgProc(pCallbackMsgProc: PDXUTCallbackMsgProc; pUserContext: Pointer = nil);


//--------------------------------------------------------------------------------------
// Initialization
//--------------------------------------------------------------------------------------
function DXUTInit(bParseCommandLine: Boolean = True; bHandleDefaultHotkeys: Boolean = True; bShowMsgBoxOnError: Boolean = True; bHandleAltEnter: Boolean = True): HRESULT;

// Choose either DXUTCreateWindow or DXUTSetWindow.  If using DXUTSetWindow, consider using DXUTStaticWndProc
function DXUTCreateWindow(const strWindowTitle: PWideChar = nil{'Direct3D Window'}; 
                          hInstance: LongWord = 0; hIcon: HICON = 0; hMenu: HMENU = 0;
                          x: Integer = Integer(CW_USEDEFAULT); y: Integer = Integer(CW_USEDEFAULT)): HRESULT;
function DXUTSetWindow(hWndFocus, hWndDeviceFullScreen, hWndDeviceWindowed: HWND; bHandleMessages: Boolean = True): HRESULT;
function DXUTStaticWndProc(hWnd: Windows.HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;

// Choose either DXUTCreateDevice or DXUTSetDevice or DXUTCreateDeviceFromSettings
function DXUTCreateDevice(AdapterOrdinal: LongWord = D3DADAPTER_DEFAULT; bWindowed: Boolean = True;
                          nSuggestedWidth: Integer = 0; nSuggestedHeight: Integer = 0;
                          pCallbackIsDeviceAcceptable: PDXUTCallbackIsDeviceAcceptable = nil;
                          pCallbackModifyDeviceSettings: PDXUTCallbackModifyDeviceSettings = nil;
                          pUserContext: Pointer = nil): HRESULT;
function DXUTCreateDeviceFromSettings(pDeviceSettings: PDXUTDeviceSettings; bPreserveInput: Boolean = False; bClipWindowToSingleAdapter: Boolean = True): HRESULT;
function DXUTSetDevice(pd3dDevice: IDirect3DDevice9): HRESULT;

// Choose either DXUTMainLoop or implement your own main loop
function DXUTMainLoop(hAccel: HACCEL = 0): HRESULT;

// If not using DXUTMainLoop consider using DXUTRender3DEnvironment
procedure DXUTRender3DEnvironment;


type
  //--------------------------------------------------------------------------------------
  // Finding valid device settings
  //--------------------------------------------------------------------------------------
  TDXUTMatchType = (
    DXUTMT_IGNORE_INPUT{$IFDEF SUPPORTS_EXPL_ENUMS} = 0{$ENDIF},  // Use the closest valid value to a default
    DXUTMT_PRESERVE_INPUT,    // Use input without change, but may cause no valid device to be found
    DXUTMT_CLOSEST_TO_INPUT   // Use the closest valid value to the input
  );

  PDXUTMatchOptions = ^TDXUTMatchOptions;
  TDXUTMatchOptions = record
    eAdapterOrdinal:     TDXUTMatchType;
    eDeviceType:         TDXUTMatchType;
    eWindowed:           TDXUTMatchType;
    eAdapterFormat:      TDXUTMatchType;
    eVertexProcessing:   TDXUTMatchType;
    eResolution:         TDXUTMatchType;
    eBackBufferFormat:   TDXUTMatchType;
    eBackBufferCount:    TDXUTMatchType;
    eMultiSample:        TDXUTMatchType;
    eSwapEffect:         TDXUTMatchType;
    eDepthFormat:        TDXUTMatchType;
    eStencilFormat:      TDXUTMatchType;
    ePresentFlags:       TDXUTMatchType;
    eRefreshRate:        TDXUTMatchType;
    ePresentInterval:    TDXUTMatchType;
  end;

function DXUTFindValidDeviceSettings(out pOut: TDXUTDeviceSettings; pIn: PDXUTDeviceSettings = nil; pMatchOptions: PDXUTMatchOptions = nil): HRESULT;


//--------------------------------------------------------------------------------------
// Common Tasks
//--------------------------------------------------------------------------------------
procedure DXUTSetCursorSettings(bShowCursorWhenFullScreen, bClipCursorWhenFullScreen: Boolean);
procedure DXUTSetMultimonSettings(bAutoChangeAdapter: Boolean);
procedure DXUTSetShortcutKeySettings(bAllowWhenFullscreen: Boolean = False; bAllowWhenWindowed: Boolean = True); // Controls the Windows key, and accessibility shortcut keys
procedure DXUTSetWindowSettings(bCallDefWindowProc: Boolean = True);
procedure DXUTSetConstantFrameTime(bConstantFrameTime: Boolean; fTimePerFrame: Single = 0.0333);
function DXUTSetTimer(pCallbackTimer: PDXUTCallbackTimer; fTimeoutInSecs: Single = 1.0; pnIDEvent: PLongWord = nil; pCallbackUserContext: Pointer = nil): HRESULT;
function DXUTKillTimer(nIDEvent: LongWord): HRESULT;
function DXUTToggleFullScreen: HRESULT;
function DXUTToggleREF: HRESULT;
procedure DXUTPause(bPauseTime, bPauseRendering: Boolean);
procedure DXUTResetFrameworkState;
procedure DXUTShutdown(nExitCode: Integer = 0);



type
  //--------------------------------------------------------------------------------------
  // Stores timer callback info
  //--------------------------------------------------------------------------------------
  TDXUTTimer = record
    pCallbackTimer: PDXUTCallbackTimer;
    pCallbackUserContext: Pointer;
    fTimeoutInSecs: Single;
    fCountdown: Single;
    bEnabled: Boolean;
  end;
  TDXUTTimerArray = array of TDXUTTimer;


//--------------------------------------------------------------------------------------
type
  TDXUTKeysArray = array[0..255] of Boolean;        // array of key state
  TXUTMouseButtonsArray = array[0..4] of Boolean;   // array of mouse states
  PDXUTKeysArray = ^TDXUTKeysArray;
  PXUTMouseButtonsArray = ^TXUTMouseButtonsArray;


//Clootie: State access functions can be inlined in Delphi9 with by moving state
//         implementation declarations to interface section, but I'm not sure
//         is it worth it.
//{$IFDEF SUPPORTS_INLINE}
//  {$DEFINE STATE_ACCESS_INLINE}
//{$ENDIF}

type
  //--------------------------------------------------------------------------------------
  // Stores DXUT state and data access is done with thread safety (if g_bThreadSafe==true)
  //--------------------------------------------------------------------------------------
  TDXUTState = class
  protected
    // m_state: TDXUTState_STATE; //Clootie: This is moved to be static variable....
  private
    function GetActive: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetAdapterMonitor: Direct3D9.HMONITOR;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetAllowShortcutKeys: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetAllowShortcutKeysWhenFullscreen: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetAllowShortcutKeysWhenWindowed: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetAutoChangeAdapter: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetBackBufferSurfaceDesc: PD3DSurfaceDesc;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetCaps: PD3DCaps9;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetClipCursorWhenFullScreen: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetConstantFrameTime: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetCurrentDeviceSettings: PDXUTDeviceSettings;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetCurrentFrameNumber: Integer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetD3D: IDirect3D9;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetD3DDevice: IDirect3DDevice9;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetD3DEnumeration: CD3DEnumeration;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceCreateCalled: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceCreated: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceCreatedFunc: PDXUTCallbackDeviceCreated;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceDestroyedFunc: PDXUTCallbackDeviceDestroyed;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceLost: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceLostFunc: PDXUTCallbackDeviceLost;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceObjectsCreated: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceObjectsReset: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceResetFunc: PDXUTCallbackDeviceReset;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceStats: PWideChar;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDXUTInitCalled: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDXUTInited: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetElapsedTime: Single;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetExitCode: Integer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetFPS: Single;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetFrameMoveFunc: PDXUTCallbackFrameMove;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetFrameRenderFunc: PDXUTCallbackFrameRender;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetFrameStats: PWideChar;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetHandleDefaultHotkeys: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetHWNDFocus: HWND;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetHWNDDeviceFullScreen: HWND;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetHWNDDeviceWindowed: HWND;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetIgnoreSizeChange: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetNotifyOnMouseMove: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetInsideDeviceCallback: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetInsideMainloop: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetIsDeviceAcceptableFunc: PDXUTCallbackIsDeviceAcceptable;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetKeyboardFunc: PDXUTCallbackKeyboard;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetKeyboardHook: HHOOK;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetLastStatsUpdateFrames: DWORD;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetLastStatsUpdateTime: Double;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetMaximized: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetMenu: HMENU;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetMinimized: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetModifyDeviceSettingsFunc: PDXUTCallbackModifyDeviceSettings;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetMouseFunc: PDXUTCallbackMouse;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideAdapterOrdinal: Integer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideConstantFrameTime: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideConstantTimePerFrame: Single;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideForceHAL: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideForceHWVP: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideForcePureHWVP: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideForceREF: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideForceSWVP: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideFullScreen: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideHeight: Integer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideQuitAfterFrame: Integer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideForceVsync: Integer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideRelaunchMCE: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

    function GetOverrideStartX: Integer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideStartY: Integer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideWidth: Integer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetOverrideWindowed: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetPauseRenderingCount: Integer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetPauseTimeCount: Integer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetRenderingPaused: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetShowCursorWhenFullScreen: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetShowMsgBoxOnError: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetNoStats: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetStartupFilterKeys: TFilterKeys;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetStartupStickyKeys: TStickyKeys;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetStartupToggleKeys: TToggleKeys;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetStaticFrameStats: PWideChar;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetFPSStats: PWideChar;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetTime: Double;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetAbsoluteTime: Double;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetTimePaused: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetTimePerFrame: Single;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetTimerList: TDXUTTimerArray;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetKeys: PDXUTKeysArray;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetMouseButtons: PXUTMouseButtonsArray;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetWindowCreateCalled: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetWindowCreated: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetWindowCreatedWithDefaultPositions: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetWindowMsgFunc: PDXUTCallbackMsgProc;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetWindowTitle: PWideChar;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetWireframeMode: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

    function GetFullScreenBackBufferWidthAtModeChange: LongWord;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetFullScreenBackBufferHeightAtModeChange: LongWord;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetWindowBackBufferWidthAtModeChange: LongWord;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetWindowBackBufferHeightAtModeChange: LongWord;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetWindowedPlacement: PWindowPlacement;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetWindowedStyleAtModeChange: DWORD;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetTopmostWhileWindowed: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetMinimizedWhileFullscreen: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetHInstance: HINST;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

    function GetAutomation: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetInSizeMove: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

    function GetIsDeviceAcceptableFuncUserContext: Pointer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetModifyDeviceSettingsFuncUserContext: Pointer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceCreatedFuncUserContext: Pointer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceResetFuncUserContext: Pointer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceLostFuncUserContext: Pointer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetDeviceDestroyedFuncUserContext: Pointer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetFrameMoveFuncUserContext: Pointer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetFrameRenderFuncUserContext: Pointer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetKeyboardFuncUserContext: Pointer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetMouseFuncUserContext: Pointer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetWindowMsgFuncUserContext: Pointer;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

    function GetCallDefWindowProc: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    function GetHandleAltEnter: Boolean;{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

    procedure SetActive(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetAdapterMonitor(const Value: Direct3D9.HMONITOR);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetAllowShortcutKeys(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetAllowShortcutKeysWhenFullscreen(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetAllowShortcutKeysWhenWindowed(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetAutoChangeAdapter(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetBackBufferSurfaceDesc(const Value: PD3DSurfaceDesc);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetCaps(const Value: PD3DCaps9);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetClipCursorWhenFullScreen(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetConstantFrameTime(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetCurrentDeviceSettings(const Value: PDXUTDeviceSettings);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetCurrentFrameNumber(const Value: Integer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetD3D(const Value: IDirect3D9);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetD3DDevice(const Value: IDirect3DDevice9);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetD3DEnumeration(const Value: CD3DEnumeration);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDeviceCreateCalled(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDeviceCreated(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDeviceCreatedFunc(
      const Value: PDXUTCallbackDeviceCreated);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDeviceDestroyedFunc(
      const Value: PDXUTCallbackDeviceDestroyed);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDeviceLost(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDeviceLostFunc(const Value: PDXUTCallbackDeviceLost);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDeviceObjectsCreated(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDeviceObjectsReset(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDeviceResetFunc(const Value: PDXUTCallbackDeviceReset);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDXUTInitCalled(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDXUTInited(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetElapsedTime(const Value: Single);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetExitCode(const Value: Integer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetFPS(const Value: Single);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetFrameMoveFunc(const Value: PDXUTCallbackFrameMove);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetFrameRenderFunc(const Value: PDXUTCallbackFrameRender);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetHandleDefaultHotkeys(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetHWNDFocus(const Value: HWND);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetHWNDDeviceFullScreen(const Value: HWND);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetHWNDDeviceWindowed(const Value: HWND);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetIgnoreSizeChange(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetNotifyOnMouseMove(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetInsideDeviceCallback(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetInsideMainloop(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetIsDeviceAcceptableFunc(
      const Value: PDXUTCallbackIsDeviceAcceptable);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetKeyboardFunc(const Value: PDXUTCallbackKeyboard);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetKeyboardHook(const Value: HHOOK);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetLastStatsUpdateFrames(const Value: DWORD);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetLastStatsUpdateTime(const Value: Double);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetMaximized(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetMenu(const Value: HMENU);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetMinimized(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetModifyDeviceSettingsFunc(
      const Value: PDXUTCallbackModifyDeviceSettings);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetMouseFunc(const Value: PDXUTCallbackMouse);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideAdapterOrdinal(const Value: Integer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideConstantFrameTime(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideConstantTimePerFrame(const Value: Single);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideForceHAL(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideForceHWVP(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideForcePureHWVP(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideForceREF(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideForceSWVP(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideFullScreen(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideHeight(const Value: Integer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideQuitAfterFrame(const Value: Integer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideForceVsync(const Value: Integer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideRelaunchMCE(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

    procedure SetOverrideStartX(const Value: Integer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideStartY(const Value: Integer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideWidth(const Value: Integer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetOverrideWindowed(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetPauseRenderingCount(const Value: Integer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetPauseTimeCount(const Value: Integer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetRenderingPaused(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetShowCursorWhenFullScreen(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetShowMsgBoxOnError(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetNoStats(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetStartupFilterKeys(const Value: TFilterKeys);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetStartupStickyKeys(const Value: TStickyKeys);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetStartupToggleKeys(const Value: TToggleKeys);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetTime(const Value: Double);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetAbsoluteTime(const Value: Double);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetTimePaused(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetTimePerFrame(const Value: Single);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetTimerList(const Value: TDXUTTimerArray);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetWindowCreateCalled(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetWindowCreated(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetWindowCreatedWithDefaultPositions(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetWindowMsgFunc(const Value: PDXUTCallbackMsgProc);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetWireframeMode(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

    procedure SetFullScreenBackBufferWidthAtModeChange(const Value: LongWord);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetFullScreenBackBufferHeightAtModeChange(const Value: LongWord);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetWindowBackBufferWidthAtModeChange(const Value: LongWord);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetWindowBackBufferHeightAtModeChange(const Value: LongWord);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetWindowedPlacement(const Value: PWindowPlacement);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetWindowedStyleAtModeChange(const Value: DWORD);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetTopmostWhileWindowed(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetMinimizedWhileFullscreen(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetHInstance(const Value: HINST);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

    procedure SetAutomation(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetInSizeMove(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

    procedure SetIsDeviceAcceptableFuncUserContext(const Value: Pointer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetModifyDeviceSettingsFuncUserContext(const Value: Pointer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDeviceCreatedFuncUserContext(const Value: Pointer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDeviceResetFuncUserContext(const Value: Pointer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

    procedure SetDeviceLostFuncUserContext(const Value: Pointer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetDeviceDestroyedFuncUserContext(const Value: Pointer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetFrameMoveFuncUserContext(const Value: Pointer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetFrameRenderFuncUserContext(const Value: Pointer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

    procedure SetKeyboardFuncUserContext(const Value: Pointer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetMouseFuncUserContext(const Value: Pointer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetWindowMsgFuncUserContext(const Value: Pointer);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

    procedure SetCallDefWindowProc(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}
    procedure SetHandleAltEnter(const Value: Boolean);{$IFDEF STATE_ACCESS_INLINE} inline;{$ENDIF}

  public
    constructor Create;
    destructor Destroy; override;

    procedure CreateState;
    procedure DestroyState;

    // Macros to define access functions for thread safe access into m_state
    property D3D: IDirect3D9 read GetD3D write SetD3D;

    property D3DDevice: IDirect3DDevice9 read GetD3DDevice write SetD3DDevice;
    property D3DEnumeration: CD3DEnumeration read GetD3DEnumeration write SetD3DEnumeration;
    property CurrentDeviceSettings: PDXUTDeviceSettings read GetCurrentDeviceSettings write SetCurrentDeviceSettings;
    property BackBufferSurfaceDesc: PD3DSurfaceDesc read GetBackBufferSurfaceDesc write SetBackBufferSurfaceDesc;
    property Caps: PD3DCaps9 read GetCaps write SetCaps;

    property HWNDFocus: HWND read GetHWNDFocus write SetHWNDFocus;
    property HWNDDeviceFullScreen: HWND read GetHWNDDeviceFullScreen write SetHWNDDeviceFullScreen;
    property HWNDDeviceWindowed: HWND read GetHWNDDeviceWindowed write SetHWNDDeviceWindowed;
    property AdapterMonitor: HMONITOR read GetAdapterMonitor write SetAdapterMonitor;
    property Menu: HMENU read GetMenu write SetMenu;

    property FullScreenBackBufferWidthAtModeChange: LongWord read GetFullScreenBackBufferWidthAtModeChange write SetFullScreenBackBufferWidthAtModeChange;
    property FullScreenBackBufferHeightAtModeChange: LongWord read GetFullScreenBackBufferHeightAtModeChange write SetFullScreenBackBufferHeightAtModeChange;
    property WindowBackBufferWidthAtModeChange: LongWord read GetWindowBackBufferWidthAtModeChange write SetWindowBackBufferWidthAtModeChange;
    property WindowBackBufferHeightAtModeChange: LongWord read GetWindowBackBufferHeightAtModeChange write SetWindowBackBufferHeightAtModeChange;
    property WindowedPlacement: PWindowPlacement read GetWindowedPlacement write SetWindowedPlacement;
    property WindowedStyleAtModeChange: DWORD read GetWindowedStyleAtModeChange write SetWindowedStyleAtModeChange;
    property TopmostWhileWindowed: Boolean read GetTopmostWhileWindowed write SetTopmostWhileWindowed;
    property Minimized: Boolean read GetMinimized write SetMinimized;
    property Maximized: Boolean read GetMaximized write SetMaximized;
    property MinimizedWhileFullscreen: Boolean read GetMinimizedWhileFullscreen write SetMinimizedWhileFullscreen;
    property IgnoreSizeChange: Boolean read GetIgnoreSizeChange write SetIgnoreSizeChange;

    property Time: Double read GetTime write SetTime;
    property AbsoluteTime: Double read GetAbsoluteTime write SetAbsoluteTime;
    property ElapsedTime: Single read GetElapsedTime write SetElapsedTime;

    property HInstance: HINST read GetHInstance write SetHInstance;
    property LastStatsUpdateTime: Double read GetLastStatsUpdateTime write SetLastStatsUpdateTime;
    property LastStatsUpdateFrames: DWORD read GetLastStatsUpdateFrames write SetLastStatsUpdateFrames;
    property FPS: Single read GetFPS write SetFPS;
    property CurrentFrameNumber: Integer read GetCurrentFrameNumber write SetCurrentFrameNumber;
    property KeyboardHook: HHOOK read GetKeyboardHook write SetKeyboardHook;
    property AllowShortcutKeysWhenFullscreen: Boolean read GetAllowShortcutKeysWhenFullscreen write SetAllowShortcutKeysWhenFullscreen;
    property AllowShortcutKeysWhenWindowed: Boolean read GetAllowShortcutKeysWhenWindowed write SetAllowShortcutKeysWhenWindowed;
    property AllowShortcutKeys: Boolean read GetAllowShortcutKeys write SetAllowShortcutKeys;
    property CallDefWindowProc: Boolean read GetCallDefWindowProc write SetCallDefWindowProc;
    property StartupStickyKeys: TStickyKeys read GetStartupStickyKeys write SetStartupStickyKeys;
    property StartupToggleKeys: TToggleKeys read GetStartupToggleKeys write SetStartupToggleKeys;
    property StartupFilterKeys: TFilterKeys read GetStartupFilterKeys write SetStartupFilterKeys;

    property HandleDefaultHotkeys: Boolean read GetHandleDefaultHotkeys write SetHandleDefaultHotkeys;
    property HandleAltEnter: Boolean read GetHandleAltEnter write SetHandleAltEnter;
    property ShowMsgBoxOnError: Boolean read GetShowMsgBoxOnError write SetShowMsgBoxOnError;
    property NoStats: Boolean read GetNoStats write SetNoStats;
    property ClipCursorWhenFullScreen: Boolean read GetClipCursorWhenFullScreen write SetClipCursorWhenFullScreen;
    property ShowCursorWhenFullScreen: Boolean read GetShowCursorWhenFullScreen write SetShowCursorWhenFullScreen;
    property ConstantFrameTime: Boolean read GetConstantFrameTime write SetConstantFrameTime;
    property TimePerFrame: Single read GetTimePerFrame write SetTimePerFrame;
    property WireframeMode: Boolean read GetWireframeMode write SetWireframeMode;
    property AutoChangeAdapter: Boolean read GetAutoChangeAdapter write SetAutoChangeAdapter;
    property WindowCreatedWithDefaultPositions: Boolean read GetWindowCreatedWithDefaultPositions write SetWindowCreatedWithDefaultPositions;
    property ExitCode: Integer read GetExitCode write SetExitCode;

    property DXUTInited: Boolean read GetDXUTInited write SetDXUTInited;
    property WindowCreated: Boolean read GetWindowCreated write SetWindowCreated;
    property DeviceCreated: Boolean read GetDeviceCreated write SetDeviceCreated;
    property DXUTInitCalled: Boolean read GetDXUTInitCalled write SetDXUTInitCalled;
    property WindowCreateCalled: Boolean read GetWindowCreateCalled write SetWindowCreateCalled;
    property DeviceCreateCalled: Boolean read GetDeviceCreateCalled write SetDeviceCreateCalled;
    property InsideDeviceCallback: Boolean read GetInsideDeviceCallback write SetInsideDeviceCallback;
    property InsideMainloop: Boolean read GetInsideMainloop write SetInsideMainloop;
    property DeviceObjectsCreated: Boolean read GetDeviceObjectsCreated write SetDeviceObjectsCreated;
    property DeviceObjectsReset: Boolean read GetDeviceObjectsReset write SetDeviceObjectsReset;
    property Active: Boolean read GetActive write SetActive;
    property RenderingPaused: Boolean read GetRenderingPaused write SetRenderingPaused;
    property TimePaused: Boolean read GetTimePaused write SetTimePaused;
    property PauseRenderingCount: Integer read GetPauseRenderingCount write SetPauseRenderingCount;
    property PauseTimeCount: Integer read GetPauseTimeCount write SetPauseTimeCount;
    property DeviceLost: Boolean read GetDeviceLost write SetDeviceLost;
    property NotifyOnMouseMove: Boolean read GetNotifyOnMouseMove write SetNotifyOnMouseMove;

    property OverrideAdapterOrdinal: Integer read GetOverrideAdapterOrdinal write SetOverrideAdapterOrdinal;
    property OverrideWindowed: Boolean read GetOverrideWindowed write SetOverrideWindowed;
    property OverrideFullScreen: Boolean read GetOverrideFullScreen write SetOverrideFullScreen;
    property OverrideStartX: Integer read GetOverrideStartX write SetOverrideStartX;
    property OverrideStartY: Integer read GetOverrideStartY write SetOverrideStartY;
    property OverrideWidth: Integer read GetOverrideWidth write SetOverrideWidth;
    property OverrideHeight: Integer read GetOverrideHeight write SetOverrideHeight;
    property OverrideForceHAL: Boolean read GetOverrideForceHAL write SetOverrideForceHAL;
    property OverrideForceREF: Boolean read GetOverrideForceREF write SetOverrideForceREF;
    property OverrideForcePureHWVP: Boolean read GetOverrideForcePureHWVP write SetOverrideForcePureHWVP;
    property OverrideForceHWVP: Boolean read GetOverrideForceHWVP write SetOverrideForceHWVP;
    property OverrideForceSWVP: Boolean read GetOverrideForceSWVP write SetOverrideForceSWVP;
    property OverrideConstantFrameTime: Boolean read GetOverrideConstantFrameTime write SetOverrideConstantFrameTime;
    property OverrideConstantTimePerFrame: Single read GetOverrideConstantTimePerFrame write SetOverrideConstantTimePerFrame;
    property OverrideQuitAfterFrame: Integer read GetOverrideQuitAfterFrame write SetOverrideQuitAfterFrame;
    property OverrideForceVsync: Integer read GetOverrideForceVsync write SetOverrideForceVsync;
    property OverrideRelaunchMCE: Boolean read GetOverrideRelaunchMCE write SetOverrideRelaunchMCE;

    property IsDeviceAcceptableFunc: PDXUTCallbackIsDeviceAcceptable read GetIsDeviceAcceptableFunc write SetIsDeviceAcceptableFunc;
    property ModifyDeviceSettingsFunc: PDXUTCallbackModifyDeviceSettings read GetModifyDeviceSettingsFunc write SetModifyDeviceSettingsFunc;
    property DeviceCreatedFunc: PDXUTCallbackDeviceCreated read GetDeviceCreatedFunc write SetDeviceCreatedFunc;
    property DeviceResetFunc: PDXUTCallbackDeviceReset read GetDeviceResetFunc write SetDeviceResetFunc;
    property DeviceLostFunc: PDXUTCallbackDeviceLost read GetDeviceLostFunc write SetDeviceLostFunc;
    property DeviceDestroyedFunc: PDXUTCallbackDeviceDestroyed read GetDeviceDestroyedFunc write SetDeviceDestroyedFunc;
    property FrameMoveFunc: PDXUTCallbackFrameMove read GetFrameMoveFunc write SetFrameMoveFunc;
    property FrameRenderFunc: PDXUTCallbackFrameRender read GetFrameRenderFunc write SetFrameRenderFunc;
    property KeyboardFunc: PDXUTCallbackKeyboard read GetKeyboardFunc write SetKeyboardFunc;
    property MouseFunc: PDXUTCallbackMouse read GetMouseFunc write SetMouseFunc;
    property WindowMsgFunc: PDXUTCallbackMsgProc read GetWindowMsgFunc write SetWindowMsgFunc;

    property Automation: Boolean read GetAutomation write SetAutomation;
    property InSizeMove: Boolean read GetInSizeMove write SetInSizeMove;

    property IsDeviceAcceptableFuncUserContext: Pointer read GetIsDeviceAcceptableFuncUserContext write SetIsDeviceAcceptableFuncUserContext;
    property ModifyDeviceSettingsFuncUserContext: Pointer read GetModifyDeviceSettingsFuncUserContext write SetModifyDeviceSettingsFuncUserContext;
    property DeviceCreatedFuncUserContext: Pointer read GetDeviceCreatedFuncUserContext write SetDeviceCreatedFuncUserContext;
    property DeviceResetFuncUserContext: Pointer read GetDeviceResetFuncUserContext write SetDeviceResetFuncUserContext;
    property DeviceLostFuncUserContext: Pointer read GetDeviceLostFuncUserContext write SetDeviceLostFuncUserContext;
    property DeviceDestroyedFuncUserContext: Pointer read GetDeviceDestroyedFuncUserContext write SetDeviceDestroyedFuncUserContext;
    property FrameMoveFuncUserContext: Pointer read GetFrameMoveFuncUserContext write SetFrameMoveFuncUserContext;
    property FrameRenderFuncUserContext: Pointer read GetFrameRenderFuncUserContext write SetFrameRenderFuncUserContext;
    property KeyboardFuncUserContext: Pointer read GetKeyboardFuncUserContext write SetKeyboardFuncUserContext;
    property MouseFuncUserContext: Pointer read GetMouseFuncUserContext write SetMouseFuncUserContext;
    property WindowMsgFuncUserContext: Pointer read GetWindowMsgFuncUserContext write SetWindowMsgFuncUserContext;

    property TimerList: TDXUTTimerArray read GetTimerList write SetTimerList;
    property Keys: PDXUTKeysArray read GetKeys;
    property MouseButtons: PXUTMouseButtonsArray read GetMouseButtons;
    property StaticFrameStats: PWideChar read GetStaticFrameStats;
    property FPSStats: PWideChar read GetFPSStats;
    property FrameStats: PWideChar read GetFrameStats;
    property DeviceStats: PWideChar read GetDeviceStats;
    property WindowTitle: PWideChar read GetWindowTitle;
  end;


//--------------------------------------------------------------------------------------
// State Retrieval
//--------------------------------------------------------------------------------------
function GetDXUTState: TDXUTState;
procedure DXUTFreeState;

function DXUTGetD3DObject:                IDirect3D9;             //Clootie: Later is FALSE for Delphi -> // Does not addref unlike typical Get* APIs
function DXUTGetD3DDevice:                IDirect3DDevice9;       //Clootie: Later is FALSE for Delphi -> // Does not addref unlike typical Get* APIs
function DXUTGetDeviceSettings:           TDXUTDeviceSettings;
function DXUTGetPresentParameters:        TD3DPresentParameters;
function DXUTGetBackBufferSurfaceDesc:    {const} PD3DSurfaceDesc;
function DXUTGetDeviceCaps:               {const} PD3DCaps9;
function DXUTGetHINSTANCE:                HINST;
function DXUTGetHWND:                     HWND;
function DXUTGetHWNDFocus:                HWND;
function DXUTGetHWNDDeviceFullScreen:     HWND;
function DXUTGetHWNDDeviceWindowed:       HWND;
function DXUTGetWindowClientRect:         TRect;
function DXUTGetWindowClientRectAtModeChange:    TRect; // Useful for returning to windowed mode with the same resolution as before toggle to full screen mode
function DXUTGetFullsceenClientRectAtModeChange: TRect; // Useful for returning to full screen mode with the same resolution as before toggle to windowed mode
function DXUTGetTime:                     Double;
function DXUTGetElapsedTime:              Single;
function DXUTIsWindowed:                  Boolean;
function DXUTGetFPS:                      Single;
function DXUTGetWindowTitle:              PWideChar;
function DXUTGetFrameStats(bIncludeFPS: Boolean = False): PWideChar;
function DXUTGetDeviceStats:              PWideChar;
function DXUTIsRenderingPaused:           Boolean;
function DXUTIsTimePaused:                Boolean;
function DXUTIsActive:                    Boolean;
function DXUTGetExitCode:                 Integer;
function DXUTGetShowMsgBoxOnError:        Boolean;
function DXUTGetHandleDefaultHotkeys:     Boolean;
function DXUTIsKeyDown(vKey: Byte): Boolean; // Pass a virtual-key code, ex. VK_F1, 'A', VK_RETURN, VK_LSHIFT, etc
function DXUTIsMouseButtonDown(vButton: Byte): Boolean; // Pass a virtual-key code: VK_LBUTTON, VK_RBUTTON, VK_MBUTTON, VK_XBUTTON1, VK_XBUTTON2
function DXUTGetAutomation: Boolean; // Returns true if -automation parameter is used to launch the app


//--------------------------------------------------------------------------------------
// UNDEFINED in Delphi
//--------------------------------------------------------------------------------------

(*
 * Structure used by WH_KEYBOARD_LL
 *)
type 
  PKBDLLHookStruct = ^TKBDLLHookStruct;
  tagKBDLLHOOKSTRUCT = packed record
    vkCode: DWORD;
    scanCode: DWORD;
    flags: DWORD;
    time: DWORD;
    dwExtraInfo: ULONG_PTR;
  end;
  {$EXTERNALSYM tagKBDLLHOOKSTRUCT}
  KBDLLHOOKSTRUCT = tagKBDLLHOOKSTRUCT;
  {$EXTERNALSYM KBDLLHOOKSTRUCT}
  TKBDLLHookStruct = KBDLLHOOKSTRUCT;

const
  WH_KEYBOARD_LL     = 13;
  WH_MOUSE_LL        = 14;

{$IFDEF FPC}
  VK_LWIN = 91;
  VK_RWIN = 92;

  E_FAIL = HRESULT($80004005);
  E_INVALIDARG = HRESULT($80070057);
  E_OUTOFMEMORY = HRESULT($8007000E);
  E_NOTIMPL = HRESULT($80004001);

{$ENDIF}

implementation

uses
  Classes, SysUtils, {$IFNDEF FPC}CommCtrl, ShellAPI, {$ENDIF}MMSystem, Math, StrSafe,
  D3DX9, DXUTCore, DXUTmisc, DXUTgui;

const
  DXUT_MIN_WINDOW_SIZE_X = 200;
  DXUT_MIN_WINDOW_SIZE_Y = 200;

var
  //--------------------------------------------------------------------------------------
  // Thread safety
  //--------------------------------------------------------------------------------------
  g_cs: TRTLCriticalSection;
  g_bThreadSafe: Boolean = True;


//--------------------------------------------------------------------------------------
// Automatically enters & leaves the CS upon object creation/deletion
//--------------------------------------------------------------------------------------
//Clootie: This can be implemented with interfaces (like in DirectShow.pas)
// ...but just too much pain for simple procedures, so implement it with real procedures
(*  TDXUTLock = class
  public
    inline DXUTLock()  { if( g_bThreadSafe ) EnterCriticalSection( &g_cs ); }
    inline ~DXUTLock() { if( g_bThreadSafe ) LeaveCriticalSection( &g_cs ); }
  end; *)
procedure DXUTLock;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  if (g_bThreadSafe) then EnterCriticalSection(g_cs);
end;

procedure DXUTUnlock;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  if (g_bThreadSafe) then LeaveCriticalSection(g_cs);
end;


//--------------------------------------------------------------------------------------
// Helper macros to build member functions that access member variables with thread safety
//--------------------------------------------------------------------------------------
//#define SET_ACCESSOR( x, y )       inline void Set##y( x t )  { DXUTLock l; m_state.m_##y = t; };
//#define GET_ACCESSOR( x, y )       inline x Get##y() { DXUTLock l; return m_state.m_##y; };
//#define GET_SET_ACCESSOR( x, y )   SET_ACCESSOR( x, y ) GET_ACCESSOR( x, y )

//#define SETP_ACCESSOR( x, y )      inline void Set##y( x* t )  { DXUTLock l; m_state.m_##y = *t; };
//#define GETP_ACCESSOR( x, y )      inline x* Get##y() { DXUTLock l; return &m_state.m_##y; };
//#define GETP_SETP_ACCESSOR( x, y ) SETP_ACCESSOR( x, y ) GETP_ACCESSOR( x, y )



type
  TDXUTState_STATE = record
    m_D3D: IDirect3D9;                   // the main D3D object

    m_D3DDevice: IDirect3DDevice9;       // the D3D rendering device
    m_D3DEnumeration: CD3DEnumeration;   // CD3DEnumeration object

    m_CurrentDeviceSettings: PDXUTDeviceSettings;   // current device settings
    m_BackBufferSurfaceDesc: TD3DSurfaceDesc;   // back buffer surface description
    m_Caps: TD3DCaps9;                   // D3D caps for current device

    m_HWNDFocus: HWND;                   // the main app focus window
    m_HWNDDeviceFullScreen: HWND;        // the main app device window in fullscreen mode
    m_HWNDDeviceWindowed: HWND;          // the main app device window in windowed mode
    m_AdapterMonitor: HMONITOR;          // the monitor of the adapter
    m_Menu: HMENU;                       // handle to menu

    m_FullScreenBackBufferWidthAtModeChange: LongWord;  // back buffer size of fullscreen mode right before switching to windowed mode.  Used to restore to same resolution when toggling back to fullscreen
    m_FullScreenBackBufferHeightAtModeChange: LongWord; // back buffer size of fullscreen mode right before switching to windowed mode.  Used to restore to same resolution when toggling back to fullscreen
    m_WindowBackBufferWidthAtModeChange: LongWord;      // back buffer size of windowed mode right before switching to fullscreen mode.  Used to restore to same resolution when toggling back to windowed mode
    m_WindowBackBufferHeightAtModeChange: LongWord;     // back buffer size of windowed mode right before switching to fullscreen mode.  Used to restore to same resolution when toggling back to windowed mode
    m_WindowedStyleAtModeChange: DWORD;  // window style
    m_WindowedPlacement: TWindowPlacement; // record of windowed HWND position/show state/etc
    m_TopmostWhileWindowed: Boolean;     // if true, the windowed HWND is topmost 
    m_Minimized: Boolean;                // if true, the HWND is minimized
    m_Maximized: Boolean;                // if true, the HWND is maximized
    m_MinimizedWhileFullscreen: Boolean; // if true, the HWND is minimized due to a focus switch away when fullscreen mode
    m_IgnoreSizeChange: Boolean;         // if true, DXUT won't reset the device upon HWND size change

    m_Time: Double;                      // current time in seconds
    m_AbsoluteTime: Double;              // absolute time in seconds
    m_ElapsedTime: Single;               // time elapsed since last frame

    m_HInstance: HINST;                  // handle to the app instance
    m_LastStatsUpdateTime: Double;       // last time the stats were updated
    m_LastStatsUpdateFrames: DWORD;      // frames count since last time the stats were updated
    m_FPS: Single;                       // frames per second
    m_CurrentFrameNumber: Integer;       // the current frame number
    m_KeyboardHook: HHOOK;               // handle to keyboard hook
    m_AllowShortcutKeysWhenFullscreen: Boolean; // if true, when fullscreen enable shortcut keys (Windows keys, StickyKeys shortcut, ToggleKeys shortcut, FilterKeys shortcut)
    m_AllowShortcutKeysWhenWindowed: Boolean;   // if true, when windowed enable shortcut keys (Windows keys, StickyKeys shortcut, ToggleKeys shortcut, FilterKeys shortcut)
    m_AllowShortcutKeys: Boolean;        // if true, then shortcut keys are currently disabled (Windows key, etc)
    m_CallDefWindowProc: Boolean;        // if true, DXUTStaticWndProc will call DefWindowProc for unhandled messages. Applications rendering to a dialog may need to set this to false.
    m_StartupStickyKeys: TStickyKeys;    // StickyKey settings upon startup so they can be restored later
    m_StartupToggleKeys: TToggleKeys;    // ToggleKey settings upon startup so they can be restored later
    m_StartupFilterKeys: TFilterKeys;    // FilterKey settings upon startup so they can be restored later

    m_HandleDefaultHotkeys: Boolean;     // if true, then DXUT will handle some default hotkeys
    m_HandleAltEnter: Boolean;           // if true, then DXUT will handle Alt-Enter
    m_ShowMsgBoxOnError: Boolean;        // if true, then msgboxes are displayed upon errors
    m_NoStats: Boolean;                  // if true, then DXUTGetFrameStats() and DXUTGetDeviceStats() will return blank strings
    m_ClipCursorWhenFullScreen: Boolean; // if true, then DXUT will keep the cursor from going outside the window when full screen
    m_ShowCursorWhenFullScreen: Boolean; // if true, then DXUT will show a cursor when full screen
    m_ConstantFrameTime: Boolean;        // if true, then elapsed frame time will always be 0.05f seconds which is good for debugging or automated capture
    m_TimePerFrame: Single;              // the constant time per frame in seconds, only valid if m_ConstantFrameTime==true
    m_WireframeMode: Boolean;            // if true, then D3DRS_FILLMODE==D3DFILL_WIREFRAME else D3DRS_FILLMODE==D3DFILL_SOLID
    m_AutoChangeAdapter: Boolean;        // if true, then the adapter will automatically change if the window is different monitor
    m_WindowCreatedWithDefaultPositions: Boolean; // if true, then CW_USEDEFAULT was used and the window should be moved to the right adapter
    m_ExitCode: Integer;                 // the exit code to be returned to the command line

    m_DXUTInited: Boolean;               // if true, then DXUTInit() has succeeded
    m_WindowCreated: Boolean;            // if true, then DXUTCreateWindow() or DXUTSetWindow() has succeeded
    m_DeviceCreated: Boolean;            // if true, then DXUTCreateDevice*() or DXUTSetDevice() has succeeded

    m_DXUTInitCalled: Boolean;           // if true, then DXUTInit() was called
    m_WindowCreateCalled: Boolean;       // if true, then DXUTCreateWindow() or DXUTSetWindow() was called
    m_DeviceCreateCalled: Boolean;       // if true, then DXUTCreateDevice*() or DXUTSetDevice() was called

    m_DeviceObjectsCreated: Boolean;     // if true, then DeviceCreated callback has been called (if non-NULL)
    m_DeviceObjectsReset: Boolean;       // if true, then DeviceReset callback has been called (if non-NULL)
    m_InsideDeviceCallback: Boolean;     // if true, then the framework is inside an app device callback
    m_InsideMainloop: Boolean;           // if true, then the framework is inside the main loop
    m_Active: Boolean;                   // if true, then the app is the active top level window
    m_TimePaused: Boolean;               // if true, then time is paused
    m_RenderingPaused: Boolean;          // if true, then rendering is paused
    m_PauseRenderingCount: Integer;      // pause rendering ref count
    m_PauseTimeCount: Integer;           // pause time ref count
    m_DeviceLost: Boolean;               // if true, then the device is lost and needs to be reset
    m_NotifyOnMouseMove: Boolean;        // if true, include WM_MOUSEMOVE in mousecallback
    m_Automation: Boolean;               // if true, automation is enabled
    m_InSizeMove: Boolean;               // if true, app is inside a WM_ENTERSIZEMOVE

    m_OverrideAdapterOrdinal: Integer;   // if != -1, then override to use this adapter ordinal
    m_OverrideWindowed: Boolean;         // if true, then force to start windowed
    m_OverrideFullScreen: Boolean;       // if true, then force to start full screen
    m_OverrideStartX: Integer;           // if != -1, then override to this X position of the window
    m_OverrideStartY: Integer;           // if != -1, then override to this Y position of the window
    m_OverrideWidth: Integer;            // if != 0, then override to this width
    m_OverrideHeight: Integer;           // if != 0, then override to this height
    m_OverrideForceHAL: Boolean;         // if true, then force to HAL device (failing if one doesn't exist)
    m_OverrideForceREF: Boolean;         // if true, then force to REF device (failing if one doesn't exist)
    m_OverrideForcePureHWVP: Boolean;    // if true, then force to use pure HWVP (failing if device doesn't support it)
    m_OverrideForceHWVP: Boolean;        // if true, then force to use HWVP (failing if device doesn't support it)
    m_OverrideForceSWVP: Boolean;        // if true, then force to use SWVP
    m_OverrideConstantFrameTime: Boolean;// if true, then force to constant frame time
    m_OverrideConstantTimePerFrame: Single; // the constant time per frame in seconds if m_OverrideConstantFrameTime==true
    m_OverrideQuitAfterFrame: Integer;   // if != 0, then it will force the app to quit after that frame
    m_OverrideForceVsync: Integer;       // if == 0, then it will force the app to use D3DPRESENT_INTERVAL_IMMEDIATE, if == 1 force use of D3DPRESENT_INTERVAL_DEFAULT
    m_OverrideRelaunchMCE: Boolean;      // if true, then force relaunch of MCE at exit

    m_IsDeviceAcceptableFunc:    PDXUTCallbackIsDeviceAcceptable;   // is device acceptable callback
    m_ModifyDeviceSettingsFunc:  PDXUTCallbackModifyDeviceSettings; // modify device settings callback
    m_DeviceCreatedFunc:         PDXUTCallbackDeviceCreated;        // device created callback
    m_DeviceResetFunc:           PDXUTCallbackDeviceReset;          // device reset callback
    m_DeviceLostFunc:            PDXUTCallbackDeviceLost;           // device lost callback
    m_DeviceDestroyedFunc:       PDXUTCallbackDeviceDestroyed;      // device destroyed callback
    m_FrameMoveFunc:             PDXUTCallbackFrameMove;            // frame move callback
    m_FrameRenderFunc:           PDXUTCallbackFrameRender;          // frame render callback
    m_KeyboardFunc:              PDXUTCallbackKeyboard;             // keyboard callback
    m_MouseFunc:                 PDXUTCallbackMouse;                // mouse callback
    m_WindowMsgFunc:             PDXUTCallbackMsgProc;              // window messages callback

    m_IsDeviceAcceptableFuncUserContext:   Pointer; // user context for is device acceptable callback
    m_ModifyDeviceSettingsFuncUserContext: Pointer; // user context for modify device settings callback
    m_DeviceCreatedUserContext:            Pointer; // user context for device created callback
    m_DeviceCreatedFuncUserContext:        Pointer; // user context for device created callback
    m_DeviceResetFuncUserContext:          Pointer; // user context for device reset callback
    m_DeviceLostFuncUserContext:           Pointer; // user context for device lost callback
    m_DeviceDestroyedFuncUserContext:      Pointer; // user context for device destroyed callback
    m_FrameMoveFuncUserContext:            Pointer; // user context for frame move callback
    m_FrameRenderFuncUserContext:          Pointer; // user context for frame render callback
    m_KeyboardFuncUserContext:             Pointer; // user context for keyboard callback
    m_MouseFuncUserContext:                Pointer; // user context for mouse callback
    m_WindowMsgFuncUserContext:            Pointer; // user context for window messages callback

    m_Keys:                      TDXUTKeysArray;                    // array of key state
    m_MouseButtons:              TXUTMouseButtonsArray;             // array of mouse states

    m_TimerList: TDXUTTimerArray;                                   // list of DXUT_TIMER structs
    m_StaticFrameStats: array[0..255] of WideChar;                  // static part of frames stats
    m_FPSStats: array[0..63] of WideChar;                           // fps stats
    m_FrameStats: array[0..255] of WideChar;                        // frame stats (fps, width, etc)
    m_DeviceStats: array[0..255] of WideChar;                       // device stats (description, device type, etc)
    m_WindowTitle: array[0..255] of WideChar;                       // window title
  end;


var
  //Clootie: This is moved to be static variable from "TDXUTState" class
  // as it is instanced only once per application...
  m_state: TDXUTState_STATE;


constructor TDXUTState.Create;
begin
  inherited;
  CreateState;
end;

destructor TDXUTState.Destroy;
begin
  DestroyState;
  inherited;
end;

procedure TDXUTState.CreateState;
begin
  // Make sure these are created before DXUTState so they
  // destroyed last because DXUTState cleanup needs them
  DXUTGetGlobalResourceCache;

  ZeroMemory(@m_state, SizeOf(m_state));
  g_bThreadSafe := True;
  InitializeCriticalSection(g_cs);
  m_state.m_OverrideStartX := -1;
  m_state.m_OverrideStartY := -1;
  m_state.m_OverrideAdapterOrdinal := -1;
  m_state.m_OverrideForceVsync := -1;
  m_state.m_AutoChangeAdapter := True;
  m_state.m_ShowMsgBoxOnError := True;
  m_state.m_AllowShortcutKeysWhenWindowed := True;
  m_state.m_Active := True;
  m_state.m_CallDefWindowProc := True;
end;

procedure TDXUTState.DestroyState;
begin
  DXUTShutdown;
  DeleteCriticalSection(g_cs);
end;

function TDXUTState.GetActive: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_Active;
  DXUTUnlock;
end;

function TDXUTState.GetAdapterMonitor: Direct3D9.HMONITOR;
begin
  DXUTLock;
  Result:= m_state.m_AdapterMonitor;
  DXUTUnlock;
end;

function TDXUTState.GetAutoChangeAdapter: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_AutoChangeAdapter;
  DXUTUnlock;
end;

function TDXUTState.GetBackBufferSurfaceDesc: PD3DSurfaceDesc;
begin
  DXUTLock;
  Result:= @m_state.m_BackBufferSurfaceDesc;
  DXUTUnlock;
end;

function TDXUTState.GetCaps: PD3DCaps9;
begin
  DXUTLock;
  Result:= @m_state.m_Caps;
  DXUTUnlock;
end;

function TDXUTState.GetClipCursorWhenFullScreen: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_ClipCursorWhenFullScreen;
  DXUTUnlock;
end;

function TDXUTState.GetConstantFrameTime: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_ConstantFrameTime;
  DXUTUnlock;
end;

function TDXUTState.GetCurrentDeviceSettings: PDXUTDeviceSettings;
begin
  DXUTLock;
  Result:= m_state.m_CurrentDeviceSettings;
  DXUTUnlock;
end;

function TDXUTState.GetCurrentFrameNumber: Integer;
begin
  DXUTLock;
  Result:= m_state.m_CurrentFrameNumber;
  DXUTUnlock;
end;

function TDXUTState.GetD3D: IDirect3D9;
begin
  DXUTLock;
  Result:= m_state.m_D3D;
  DXUTUnlock;
end;

function TDXUTState.GetD3DDevice: IDirect3DDevice9;
begin
  DXUTLock;
  Result:= m_state.m_D3DDevice;
  DXUTUnlock;
end;

function TDXUTState.GetD3DEnumeration: CD3DEnumeration;
begin
  DXUTLock;
  Result:= m_state.m_D3DEnumeration;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceCreateCalled: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_DeviceCreateCalled;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceCreated: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_DeviceCreated;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceCreatedFunc: PDXUTCallbackDeviceCreated;
begin
  DXUTLock;
  Result:= m_state.m_DeviceCreatedFunc;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceDestroyedFunc: PDXUTCallbackDeviceDestroyed;
begin
  DXUTLock;
  Result:= m_state.m_DeviceDestroyedFunc;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceLost: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_DeviceLost;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceLostFunc: PDXUTCallbackDeviceLost;
begin
  DXUTLock;
  Result:= m_state.m_DeviceLostFunc;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceObjectsCreated: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_DeviceObjectsCreated;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceObjectsReset: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_DeviceObjectsReset;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceResetFunc: PDXUTCallbackDeviceReset;
begin
  DXUTLock;
  Result:= m_state.m_DeviceResetFunc;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceStats: PWideChar;
begin
  DXUTLock;
  Result:= m_state.m_DeviceStats;
  DXUTUnlock;
end;

function TDXUTState.GetDXUTInitCalled: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_DXUTInitCalled;
  DXUTUnlock;
end;

function TDXUTState.GetDXUTInited: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_DXUTInited;
  DXUTUnlock;
end;

function TDXUTState.GetElapsedTime: Single;
begin
  DXUTLock;
  Result:= m_state.m_ElapsedTime;
  DXUTUnlock;
end;

function TDXUTState.GetExitCode: Integer;
begin
  DXUTLock;
  Result:= m_state.m_ExitCode;
  DXUTUnlock;
end;

function TDXUTState.GetFPS: Single;
begin
  DXUTLock;
  Result:= m_state.m_FPS;
  DXUTUnlock;
end;

function TDXUTState.GetFrameMoveFunc: PDXUTCallbackFrameMove;
begin
  DXUTLock;
  Result:= m_state.m_FrameMoveFunc;
  DXUTUnlock;
end;

function TDXUTState.GetFrameRenderFunc: PDXUTCallbackFrameRender;
begin
  DXUTLock;
  Result:= m_state.m_FrameRenderFunc;
  DXUTUnlock;
end;

function TDXUTState.GetFrameStats: PWideChar;
begin
  DXUTLock;
  Result:= m_state.m_FrameStats;
  DXUTUnlock;
end;

function TDXUTState.GetHandleDefaultHotkeys: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_HandleDefaultHotkeys;
  DXUTUnlock;
end;

function TDXUTState.GetHWNDFocus: HWND;
begin
  DXUTLock;
  Result:= m_state.m_HWNDFocus;
  DXUTUnlock;
end;

function TDXUTState.GetHWNDDeviceFullScreen: HWND;
begin
  DXUTLock;
  Result:= m_state.m_HWNDDeviceFullScreen;
  DXUTUnlock;
end;

function TDXUTState.GetHWNDDeviceWindowed: HWND;
begin
  DXUTLock;
  Result:= m_state.m_HWNDDeviceWindowed;
  DXUTUnlock;
end;

function TDXUTState.GetIgnoreSizeChange: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_IgnoreSizeChange;
  DXUTUnlock;
end;

function TDXUTState.GetNotifyOnMouseMove: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_NotifyOnMouseMove;
  DXUTUnlock;
end;

function TDXUTState.GetInsideDeviceCallback: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_InsideDeviceCallback;
  DXUTUnlock;
end;

function TDXUTState.GetInsideMainloop: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_InsideMainloop;
  DXUTUnlock;
end;

function TDXUTState.GetIsDeviceAcceptableFunc: PDXUTCallbackIsDeviceAcceptable;
begin
  DXUTLock;
  Result:= m_state.m_IsDeviceAcceptableFunc;
  DXUTUnlock;
end;

function TDXUTState.GetKeyboardFunc: PDXUTCallbackKeyboard;
begin
  DXUTLock;
  Result:= m_state.m_KeyboardFunc;
  DXUTUnlock;
end;

function TDXUTState.GetLastStatsUpdateFrames: DWORD;
begin
  DXUTLock;
  Result:= m_state.m_LastStatsUpdateFrames;
  DXUTUnlock;
end;

function TDXUTState.GetLastStatsUpdateTime: Double;
begin
  DXUTLock;
  Result:= m_state.m_LastStatsUpdateTime;
  DXUTUnlock;
end;

function TDXUTState.GetMaximized: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_Maximized;
  DXUTUnlock;
end;

function TDXUTState.GetMenu: HMENU;
begin
  DXUTLock;
  Result:= m_state.m_Menu;
  DXUTUnlock;
end;

function TDXUTState.GetMinimized: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_Minimized;
  DXUTUnlock;
end;

function TDXUTState.GetModifyDeviceSettingsFunc: PDXUTCallbackModifyDeviceSettings;
begin
  DXUTLock;
  Result:= m_state.m_ModifyDeviceSettingsFunc;
  DXUTUnlock;
end;

function TDXUTState.GetMouseFunc: PDXUTCallbackMouse;
begin
  DXUTLock;
  Result:= m_state.m_MouseFunc;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideAdapterOrdinal: Integer;
begin
  DXUTLock;
  Result:= m_state.m_OverrideAdapterOrdinal;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideConstantFrameTime: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_OverrideConstantFrameTime;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideConstantTimePerFrame: Single;
begin
  DXUTLock;
  Result:= m_state.m_OverrideConstantTimePerFrame;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideForceHAL: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_OverrideForceHAL;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideForceHWVP: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_OverrideForceHWVP;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideForcePureHWVP: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_OverrideForcePureHWVP;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideForceREF: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_OverrideForceREF;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideForceSWVP: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_OverrideForceSWVP;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideFullScreen: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_OverrideFullScreen;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideHeight: Integer;
begin
  DXUTLock;
  Result:= m_state.m_OverrideHeight;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideQuitAfterFrame: Integer;
begin
  DXUTLock;
  Result:= m_state.m_OverrideQuitAfterFrame;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideForceVsync: Integer;
begin
  DXUTLock;
  Result:= m_state.m_OverrideForceVsync;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideRelaunchMCE: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_OverrideRelaunchMCE;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideStartX: Integer;
begin
  DXUTLock;
  Result:= m_state.m_OverrideStartX;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideStartY: Integer;
begin
  DXUTLock;
  Result:= m_state.m_OverrideStartY;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideWidth: Integer;
begin
  DXUTLock;
  Result:= m_state.m_OverrideWidth;
  DXUTUnlock;
end;

function TDXUTState.GetOverrideWindowed: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_OverrideWindowed;
  DXUTUnlock;
end;

function TDXUTState.GetPauseRenderingCount: Integer;
begin
  DXUTLock;
  Result:= m_state.m_PauseRenderingCount;
  DXUTUnlock;
end;

function TDXUTState.GetPauseTimeCount: Integer;
begin
  DXUTLock;
  Result:= m_state.m_PauseTimeCount;
  DXUTUnlock;
end;

function TDXUTState.GetRenderingPaused: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_RenderingPaused;
  DXUTUnlock;
end;

function TDXUTState.GetShowCursorWhenFullScreen: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_ShowCursorWhenFullScreen;
  DXUTUnlock;
end;

function TDXUTState.GetShowMsgBoxOnError: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_ShowMsgBoxOnError;
  DXUTUnlock;
end;

function TDXUTState.GetNoStats : Boolean;
begin
  DXUTLock;
  Result:= m_state.m_NoStats;
  DXUTUnlock;
end;

function TDXUTState.GetStaticFrameStats: PWideChar;
begin
  DXUTLock;
  Result:= m_state.m_StaticFrameStats;
  DXUTUnlock;
end;

function TDXUTState.GetFPSStats: PWideChar;
begin
  DXUTLock;
  Result:= m_state.m_FPSStats;
  DXUTUnlock;
end;

function TDXUTState.GetTime: Double;
begin
  DXUTLock;
  Result:= m_state.m_Time;
  DXUTUnlock;
end;

function TDXUTState.GetAbsoluteTime: Double;
begin
  DXUTLock;
  Result:= m_state.m_AbsoluteTime;
  DXUTUnlock;
end;

function TDXUTState.GetTimePaused: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_TimePaused;
  DXUTUnlock;
end;

function TDXUTState.GetTimePerFrame: Single;
begin
  DXUTLock;
  Result:= m_state.m_TimePerFrame;
  DXUTUnlock;
end;

function TDXUTState.GetTimerList: TDXUTTimerArray;
begin
  DXUTLock;
  Result:= m_state.m_TimerList;
  DXUTUnlock;
end;

function TDXUTState.GetKeys: PDXUTKeysArray;
begin
  DXUTLock;
  Result:= @m_state.m_Keys;
  DXUTUnlock;
end;

function TDXUTState.GetMouseButtons: PXUTMouseButtonsArray;
begin
  DXUTLock;
  Result:= @m_state.m_MouseButtons;
  DXUTUnlock;
end;

function TDXUTState.GetWindowCreateCalled: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_WindowCreateCalled;
  DXUTUnlock;
end;

function TDXUTState.GetWindowCreated: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_WindowCreated;
  DXUTUnlock;
end;

function TDXUTState.GetWindowCreatedWithDefaultPositions: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_WindowCreatedWithDefaultPositions;
  DXUTUnlock;
end;

function TDXUTState.GetWindowMsgFunc: PDXUTCallbackMsgProc;
begin
  DXUTLock;
  Result:= m_state.m_WindowMsgFunc;
  DXUTUnlock;
end;

function TDXUTState.GetWindowTitle: PWideChar;
begin
  DXUTLock;
  Result:= m_state.m_WindowTitle;
  DXUTUnlock;
end;

function TDXUTState.GetWireframeMode: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_WireframeMode;
  DXUTUnlock;
end;


function TDXUTState.GetAllowShortcutKeys: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_AllowShortcutKeys;
  DXUTUnlock;
end;

function TDXUTState.GetAllowShortcutKeysWhenFullscreen: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_AllowShortcutKeysWhenFullscreen;
  DXUTUnlock;
end;

function TDXUTState.GetAllowShortcutKeysWhenWindowed: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_AllowShortcutKeysWhenWindowed;
  DXUTUnlock;
end;

function TDXUTState.GetKeyboardHook: HHOOK;
begin
  DXUTLock;
  Result:= m_state.m_KeyboardHook;
  DXUTUnlock;
end;

function TDXUTState.GetStartupFilterKeys: TFilterKeys;
begin
  DXUTLock;
  Result:= m_state.m_StartupFilterKeys;
  DXUTUnlock;
end;

function TDXUTState.GetStartupStickyKeys: TStickyKeys;
begin
  DXUTLock;
  Result:= m_state.m_StartupStickyKeys;
  DXUTUnlock;
end;

function TDXUTState.GetStartupToggleKeys: TToggleKeys;
begin
  DXUTLock;
  Result:= m_state.m_StartupToggleKeys;
  DXUTUnlock;
end;

function TDXUTState.GetAutomation: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_Automation;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceCreatedFuncUserContext: Pointer;
begin
  DXUTLock;
  Result:= m_state.m_DeviceCreatedFuncUserContext;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceDestroyedFuncUserContext: Pointer;
begin
  DXUTLock;
  Result:= m_state.m_DeviceDestroyedFuncUserContext;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceLostFuncUserContext: Pointer;
begin
  DXUTLock;
  Result:= m_state.m_DeviceLostFuncUserContext;
  DXUTUnlock;
end;

function TDXUTState.GetDeviceResetFuncUserContext: Pointer;
begin
  DXUTLock;
  Result:= m_state.m_DeviceResetFuncUserContext;
  DXUTUnlock;
end;

function TDXUTState.GetFrameMoveFuncUserContext: Pointer;
begin
  DXUTLock;
  Result:= m_state.m_FrameMoveFuncUserContext;
  DXUTUnlock;
end;

function TDXUTState.GetFrameRenderFuncUserContext: Pointer;
begin
  DXUTLock;
  Result:= m_state.m_FrameRenderFuncUserContext;
  DXUTUnlock;
end;

function TDXUTState.GetFullScreenBackBufferHeightAtModeChange: LongWord;
begin
  DXUTLock;
  Result:= m_state.m_FullScreenBackBufferHeightAtModeChange;
  DXUTUnlock;
end;

function TDXUTState.GetFullScreenBackBufferWidthAtModeChange: LongWord;
begin
  DXUTLock;
  Result:= m_state.m_FullScreenBackBufferWidthAtModeChange;
  DXUTUnlock;
end;

function TDXUTState.GetHInstance: HINST;
begin
  DXUTLock;
  Result:= m_state.m_HInstance;
  DXUTUnlock;
end;

function TDXUTState.GetInSizeMove: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_InSizeMove;
  DXUTUnlock;
end;

function TDXUTState.GetIsDeviceAcceptableFuncUserContext: Pointer;
begin
  DXUTLock;
  Result:= m_state.m_IsDeviceAcceptableFuncUserContext;
  DXUTUnlock;
end;

function TDXUTState.GetKeyboardFuncUserContext: Pointer;
begin
  DXUTLock;
  Result:= m_state.m_KeyboardFuncUserContext;
  DXUTUnlock;
end;

function TDXUTState.GetMinimizedWhileFullscreen: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_MinimizedWhileFullscreen;
  DXUTUnlock;
end;

function TDXUTState.GetModifyDeviceSettingsFuncUserContext: Pointer;
begin
  DXUTLock;
  Result:= m_state.m_ModifyDeviceSettingsFuncUserContext;
  DXUTUnlock;
end;

function TDXUTState.GetMouseFuncUserContext: Pointer;
begin
  DXUTLock;
  Result:= m_state.m_MouseFuncUserContext;
  DXUTUnlock;
end;

function TDXUTState.GetWindowBackBufferHeightAtModeChange: LongWord;
begin
  DXUTLock;
  Result:= m_state.m_WindowBackBufferHeightAtModeChange;
  DXUTUnlock;
end;

function TDXUTState.GetWindowBackBufferWidthAtModeChange: LongWord;
begin
  DXUTLock;
  Result:= m_state.m_WindowBackBufferWidthAtModeChange;
  DXUTUnlock;
end;

function TDXUTState.GetWindowedPlacement: PWindowPlacement;
begin
  DXUTLock;
  Result:= @m_state.m_WindowedPlacement;
  DXUTUnlock;
end;

function TDXUTState.GetWindowedStyleAtModeChange: DWORD;
begin
  DXUTLock;
  Result:= m_state.m_WindowedStyleAtModeChange;
  DXUTUnlock;
end;

function TDXUTState.GetTopmostWhileWindowed: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_TopmostWhileWindowed;
  DXUTUnlock;
end;

function TDXUTState.GetWindowMsgFuncUserContext: Pointer;
begin
  DXUTLock;
  Result:= m_state.m_WindowMsgFuncUserContext;
  DXUTUnlock;
end;

function TDXUTState.GetCallDefWindowProc: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_CallDefWindowProc;
  DXUTUnlock;
end;

function TDXUTState.GetHandleAltEnter: Boolean;
begin
  DXUTLock;
  Result:= m_state.m_HandleAltEnter;
  DXUTUnlock;
end;

procedure TDXUTState.SetActive(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_Active:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetAdapterMonitor(const Value: Direct3D9.HMONITOR);
begin
  DXUTLock;
  m_state.m_AdapterMonitor:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetAutoChangeAdapter(const Value: Boolean);
begin
  DXUTLock;                 
  m_state.m_AutoChangeAdapter:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetBackBufferSurfaceDesc(
  const Value: PD3DSurfaceDesc);
begin
  DXUTLock;
  m_state.m_BackBufferSurfaceDesc:= Value^;
  DXUTUnlock;
end;

procedure TDXUTState.SetCaps(const Value: PD3DCaps9);
begin
  DXUTLock;
  m_state.m_Caps:= Value^;
  DXUTUnlock;
end;

procedure TDXUTState.SetClipCursorWhenFullScreen(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_ClipCursorWhenFullScreen:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetConstantFrameTime(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_ConstantFrameTime:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetCurrentDeviceSettings(
  const Value: PDXUTDeviceSettings);
begin
  DXUTLock;
  m_state.m_CurrentDeviceSettings:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetCurrentFrameNumber(const Value: Integer);
begin
  DXUTLock;
  m_state.m_CurrentFrameNumber:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetD3D(const Value: IDirect3D9);
begin
  DXUTLock;
  m_state.m_D3D:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetD3DDevice(const Value: IDirect3DDevice9);
begin
  DXUTLock;
  m_state.m_D3DDevice:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetD3DEnumeration(const Value: CD3DEnumeration);
begin
  DXUTLock;
  m_state.m_D3DEnumeration:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDeviceCreateCalled(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_DeviceCreateCalled:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDeviceCreated(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_DeviceCreated:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDeviceCreatedFunc(
  const Value: PDXUTCallbackDeviceCreated);
begin
  DXUTLock;
  m_state.m_DeviceCreatedFunc:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDeviceDestroyedFunc(
  const Value: PDXUTCallbackDeviceDestroyed);
begin
  DXUTLock;
  m_state.m_DeviceDestroyedFunc:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDeviceLost(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_DeviceLost:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDeviceLostFunc(
  const Value: PDXUTCallbackDeviceLost);
begin
  DXUTLock;
  m_state.m_DeviceLostFunc:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDeviceObjectsCreated(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_DeviceObjectsCreated:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDeviceObjectsReset(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_DeviceObjectsReset:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDeviceResetFunc(
  const Value: PDXUTCallbackDeviceReset);
begin
  DXUTLock;
  m_state.m_DeviceResetFunc:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDXUTInitCalled(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_DXUTInitCalled:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDXUTInited(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_DXUTInited:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetElapsedTime(const Value: Single);
begin
  DXUTLock;
  m_state.m_ElapsedTime:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetExitCode(const Value: Integer);
begin
  DXUTLock;
  m_state.m_ExitCode:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetFPS(const Value: Single);
begin
  DXUTLock;
  m_state.m_FPS:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetFrameMoveFunc(const Value: PDXUTCallbackFrameMove);
begin
  DXUTLock;
  m_state.m_FrameMoveFunc:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetFrameRenderFunc(
  const Value: PDXUTCallbackFrameRender);
begin
  DXUTLock;
  m_state.m_FrameRenderFunc:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetHandleDefaultHotkeys(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_HandleDefaultHotkeys:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetHWNDFocus(const Value: HWND);
begin
  DXUTLock;
  m_state.m_HWNDFocus:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetHWNDDeviceFullScreen(const Value: HWND);
begin
  DXUTLock;
  m_state.m_HWNDDeviceFullScreen:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetHWNDDeviceWindowed(const Value: HWND);
begin
  DXUTLock;
  m_state.m_HWNDDeviceWindowed:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetIgnoreSizeChange(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_IgnoreSizeChange:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetNotifyOnMouseMove(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_NotifyOnMouseMove:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetInsideDeviceCallback(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_InsideDeviceCallback:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetInsideMainloop(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_InsideMainloop:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetIsDeviceAcceptableFunc(
  const Value: PDXUTCallbackIsDeviceAcceptable);
begin
  DXUTLock;
  m_state.m_IsDeviceAcceptableFunc:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetKeyboardFunc(const Value: PDXUTCallbackKeyboard);
begin
  DXUTLock;
  m_state.m_KeyboardFunc:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetLastStatsUpdateFrames(const Value: DWORD);
begin
  DXUTLock;
  m_state.m_LastStatsUpdateFrames:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetLastStatsUpdateTime(const Value: Double);
begin
  DXUTLock;
  m_state.m_LastStatsUpdateTime:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetMaximized(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_Maximized:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetMenu(const Value: HMENU);
begin
  DXUTLock;
  m_state.m_Menu:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetMinimized(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_Minimized:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetModifyDeviceSettingsFunc(
  const Value: PDXUTCallbackModifyDeviceSettings);
begin
  DXUTLock;
  m_state.m_ModifyDeviceSettingsFunc:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetMouseFunc(const Value: PDXUTCallbackMouse);
begin
  DXUTLock;
  m_state.m_MouseFunc:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideAdapterOrdinal(const Value: Integer);
begin
  DXUTLock;
  m_state.m_OverrideAdapterOrdinal:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideConstantFrameTime(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_OverrideConstantFrameTime:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideConstantTimePerFrame(const Value: Single);
begin
  DXUTLock;
  m_state.m_OverrideConstantTimePerFrame:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideForceHAL(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_OverrideForceHAL:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideForceHWVP(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_OverrideForceHWVP:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideForcePureHWVP(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_OverrideForcePureHWVP:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideForceREF(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_OverrideForceREF:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideForceSWVP(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_OverrideForceSWVP:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideFullScreen(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_OverrideFullScreen:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideHeight(const Value: Integer);
begin
  DXUTLock;
  m_state.m_OverrideHeight:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideQuitAfterFrame(const Value: Integer);
begin
  DXUTLock;
  m_state.m_OverrideQuitAfterFrame:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideForceVsync(const Value: Integer);
begin
  DXUTLock;
  m_state.m_OverrideForceVsync:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideRelaunchMCE(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_OverrideRelaunchMCE:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideStartX(const Value: Integer);
begin
  DXUTLock;
  m_state.m_OverrideStartX:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideStartY(const Value: Integer);
begin
  DXUTLock;
  m_state.m_OverrideStartY:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideWidth(const Value: Integer);
begin
  DXUTLock;
  m_state.m_OverrideWidth:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetOverrideWindowed(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_OverrideWindowed:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetPauseRenderingCount(const Value: Integer);
begin
  DXUTLock;
  m_state.m_PauseRenderingCount:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetPauseTimeCount(const Value: Integer);
begin
  DXUTLock;
  m_state.m_PauseTimeCount:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetRenderingPaused(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_RenderingPaused:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetShowCursorWhenFullScreen(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_ShowCursorWhenFullScreen:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetShowMsgBoxOnError(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_ShowMsgBoxOnError:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetNoStats(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_NoStats:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetTime(const Value: Double);
begin
  DXUTLock;
  m_state.m_Time:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetAbsoluteTime(const Value: Double);
begin
  DXUTLock;
  m_state.m_AbsoluteTime:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetTimePaused(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_TimePaused:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetTimePerFrame(const Value: Single);
begin
  DXUTLock;
  m_state.m_TimePerFrame:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetTimerList(const Value: TDXUTTimerArray);
begin
  DXUTLock;
  m_state.m_TimerList:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetWindowCreateCalled(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_WindowCreateCalled:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetWindowCreated(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_WindowCreated:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetWindowCreatedWithDefaultPositions(
  const Value: Boolean);
begin
  DXUTLock;
  m_state.m_WindowCreatedWithDefaultPositions:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetWindowMsgFunc(const Value: PDXUTCallbackMsgProc);
begin
  DXUTLock;
  m_state.m_WindowMsgFunc:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetWireframeMode(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_WireframeMode:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetAllowShortcutKeys(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_AllowShortcutKeys:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetAllowShortcutKeysWhenFullscreen(
  const Value: Boolean);
begin
  DXUTLock;
  m_state.m_AllowShortcutKeysWhenFullscreen:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetAllowShortcutKeysWhenWindowed(
  const Value: Boolean);
begin
  DXUTLock;
  m_state.m_AllowShortcutKeysWhenWindowed:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetKeyboardHook(const Value: HHOOK);
begin
  DXUTLock;
  m_state.m_KeyboardHook:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetStartupFilterKeys(const Value: TFilterKeys);
begin
  DXUTLock;
  m_state.m_StartupFilterKeys:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetStartupStickyKeys(const Value: TStickyKeys);
begin
  DXUTLock;
  m_state.m_StartupStickyKeys:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetStartupToggleKeys(const Value: TToggleKeys);
begin
  DXUTLock;
  m_state.m_StartupToggleKeys:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetAutomation(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_Automation:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDeviceCreatedFuncUserContext(const Value: Pointer);
begin
  DXUTLock;
  m_state.m_DeviceCreatedFuncUserContext:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDeviceDestroyedFuncUserContext(
  const Value: Pointer);
begin
  DXUTLock;
  m_state.m_DeviceDestroyedFuncUserContext:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDeviceLostFuncUserContext(const Value: Pointer);
begin
  DXUTLock;
  m_state.m_DeviceLostFuncUserContext:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetDeviceResetFuncUserContext(const Value: Pointer);
begin
  DXUTLock;
  m_state.m_DeviceResetFuncUserContext:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetFrameMoveFuncUserContext(const Value: Pointer);
begin
  DXUTLock;
  m_state.m_FrameMoveFuncUserContext:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetFrameRenderFuncUserContext(const Value: Pointer);
begin
  DXUTLock;
  m_state.m_FrameRenderFuncUserContext:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetFullScreenBackBufferHeightAtModeChange(
  const Value: LongWord);
begin
  DXUTLock;
  m_state.m_FullScreenBackBufferHeightAtModeChange:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetFullScreenBackBufferWidthAtModeChange(
  const Value: LongWord);
begin
  DXUTLock;
  m_state.m_FullScreenBackBufferWidthAtModeChange:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetHInstance(const Value: HINST);
begin
  DXUTLock;
  m_state.m_HInstance:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetInSizeMove(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_InSizeMove:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetIsDeviceAcceptableFuncUserContext(
  const Value: Pointer);
begin
  DXUTLock;
  m_state.m_IsDeviceAcceptableFuncUserContext:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetKeyboardFuncUserContext(const Value: Pointer);
begin
  DXUTLock;
  m_state.m_KeyboardFuncUserContext:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetMinimizedWhileFullscreen(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_MinimizedWhileFullscreen:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetModifyDeviceSettingsFuncUserContext(
  const Value: Pointer);
begin
  DXUTLock;
  m_state.m_ModifyDeviceSettingsFuncUserContext:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetMouseFuncUserContext(const Value: Pointer);
begin
  DXUTLock;
  m_state.m_MouseFuncUserContext:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetWindowBackBufferHeightAtModeChange(
  const Value: LongWord);
begin
  DXUTLock;
  m_state.m_WindowBackBufferHeightAtModeChange:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetWindowBackBufferWidthAtModeChange(
  const Value: LongWord);
begin
  DXUTLock;
  m_state.m_WindowBackBufferWidthAtModeChange:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetWindowedPlacement(const Value: PWindowPlacement);
begin
  DXUTLock;
  m_state.m_WindowedPlacement:= Value^;
  DXUTUnlock;
end;

procedure TDXUTState.SetWindowedStyleAtModeChange(const Value: DWORD);
begin
  DXUTLock;
  m_state.m_WindowedStyleAtModeChange:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetTopmostWhileWindowed(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_TopmostWhileWindowed:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetWindowMsgFuncUserContext(const Value: Pointer);
begin
  DXUTLock;
  m_state.m_WindowMsgFuncUserContext:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetCallDefWindowProc(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_CallDefWindowProc:= Value;
  DXUTUnlock;
end;

procedure TDXUTState.SetHandleAltEnter(const Value: Boolean);
begin
  DXUTLock;
  m_state.m_HandleAltEnter:= Value;
  DXUTUnlock;
end;


//--------------------------------------------------------------------------------------
// Global state class
//--------------------------------------------------------------------------------------
var g_state: TDXUTState = nil;

function GetDXUTState: TDXUTState;
begin
  // Using an accessor function gives control of the construction order
  //Clootie: This is C++ issue - in pascal we just create it here
  if (g_state = nil) then g_state:= TDXUTState.Create;
  Result:= g_state;
end;

procedure DXUTFreeState;
begin
  //Clootie: Can't use FreeAndNil here...
  if (g_state <> nil) then g_state.Free;
  g_state:= nil;
end;


//--------------------------------------------------------------------------------------
// Internal functions forward declarations
//--------------------------------------------------------------------------------------
//type
//  TDirect3DCreate9 = function (SDKVersion: LongWord): Pointer; stdcall;
// typedef DECLSPEC_IMPORT UINT (WINAPI* LPTIMEBEGINPERIOD)( UINT uPeriod ); //Clootie: Just "USE MMSystem"

function DXUTMapButtonToArrayIndex(vButton: Byte): Integer; forward;
procedure DXUTSetProcessorAffinity; forward;
procedure DXUTParseCommandLine; forward;
function DXUTPrepareEnumerationObject(bEnumerate: Boolean = False): CD3DEnumeration; forward;
procedure DXUTBuildOptimalDeviceSettings(pOptimalDeviceSettings: PDXUTDeviceSettings; pDeviceSettingsIn: PDXUTDeviceSettings; pMatchOptions: PDXUTMatchOptions); forward;
function DXUTDoesDeviceComboMatchPreserveOptions(pDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo; pDeviceSettingsIn: PDXUTDeviceSettings; pMatchOptions: PDXUTMatchOptions): Boolean; forward;
function DXUTRankDeviceCombo(pDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo; pOptimalDeviceSettings: PDXUTDeviceSettings; pAdapterDesktopDisplayMode: PD3DDisplayMode): Single; forward;
procedure DXUTBuildValidDeviceSettings(out pValidDeviceSettings: TDXUTDeviceSettings; const pBestDeviceSettingsCombo: TD3DEnumDeviceSettingsCombo; pDeviceSettingsIn: PDXUTDeviceSettings; pMatchOptions: PDXUTMatchOptions); forward;

function DXUTFindValidResolution(const pBestDeviceSettingsCombo: TD3DEnumDeviceSettingsCombo; displayModeIn: TD3DDisplayMode; out pBestDisplayMode: TD3DDisplayMode): HRESULT; forward;
function DXUTFindAdapterFormat(AdapterOrdinal: LongWord; DeviceType: TD3DDevType; BackBufferFormat: TD3DFormat; Windowed: Boolean; out pAdapterFormat: TD3DFormat): HRESULT; forward;
function DXUTChangeDevice(pNewDeviceSettings: PDXUTDeviceSettings; pd3dDeviceFromApp: IDirect3DDevice9; bForceRecreate: Boolean; bClipWindowToSingleAdapter: Boolean): HRESULT; forward;
procedure DXUTUpdateDeviceSettingsWithOverrides(out pDeviceSettings: TDXUTDeviceSettings); forward;
function DXUTCreate3DEnvironment(const pd3dDeviceFromApp: IDirect3DDevice9): HRESULT; forward;
function DXUTReset3DEnvironment: HRESULT; forward;
procedure DXUTCleanup3DEnvironment(bReleaseSettings: Boolean = True); forward;
procedure DXUTUpdateFrameStats; forward;
procedure DXUTUpdateDeviceStats(DeviceType: TD3DDevType; BehaviorFlags: DWORD; const pAdapterIdentifier: TD3DAdapterIdentifier9); forward;
procedure DXUTUpdateStaticFrameStats; forward;
procedure DXUTCheckForWindowSizeChange; forward;
procedure DXUTCheckForWindowChangingMonitors; forward;
procedure DXUTHandleTimers; forward;
function DXUTIsNextArg(var strCmdLine: PAnsiChar; strArg: PAnsiChar): Boolean; forward;
function DXUTGetCmdParam(var strCmdLine: PAnsiChar; out strFlag: String): Boolean; forward;
procedure DXUTDisplayErrorMessage(hr: HRESULT); forward;
function DXUTGetAdapterOrdinalFromMonitor(hMonitor: HMONITOR; out pAdapterOrdinal: LongWord): HRESULT; forward;
procedure DXUTAllowShortcutKeys(bAllowKeys: Boolean); forward;
procedure DXUTUpdateBackBufferDesc; forward;
procedure DXUTSetupCursor; forward;
function DXUTSetDeviceCursor(const pd3dDevice: IDirect3DDevice9; hCursor: HCURSOR; bAddWatermark: Boolean): HRESULT; forward;


//--------------------------------------------------------------------------------------
// External callback setup functions
//--------------------------------------------------------------------------------------

procedure DXUTSetCallbackDeviceCreated(pCallbackDeviceCreated: PDXUTCallbackDeviceCreated; pUserContext: Pointer);
begin
  GetDXUTState.SetDeviceCreatedFunc(pCallbackDeviceCreated);
  GetDXUTState.SetDeviceCreatedFuncUserContext(pUserContext);
end;

procedure DXUTSetCallbackDeviceReset(pCallbackDeviceReset: PDXUTCallbackDeviceReset; pUserContext: Pointer);
begin
  GetDXUTState.SetDeviceResetFunc(pCallbackDeviceReset);
  GetDXUTState.SetDeviceResetFuncUserContext(pUserContext);
end;

procedure DXUTSetCallbackDeviceLost(pCallbackDeviceLost: PDXUTCallbackDeviceLost; pUserContext: Pointer);
begin
  GetDXUTState.SetDeviceLostFunc(pCallbackDeviceLost);
  GetDXUTState.SetDeviceLostFuncUserContext(pUserContext);
end;

procedure DXUTSetCallbackDeviceDestroyed(pCallbackDeviceDestroyed: PDXUTCallbackDeviceDestroyed; pUserContext: Pointer);
begin
  GetDXUTState.SetDeviceDestroyedFunc(pCallbackDeviceDestroyed);
  GetDXUTState.SetDeviceDestroyedFuncUserContext(pUserContext);
end;

procedure DXUTSetCallbackDeviceChanging(pCallbackModifyDeviceSettings: PDXUTCallbackModifyDeviceSettings; pUserContext: Pointer);
begin
  GetDXUTState.SetModifyDeviceSettingsFunc(pCallbackModifyDeviceSettings);
  GetDXUTState.SetModifyDeviceSettingsFuncUserContext(pUserContext);
end;

procedure DXUTSetCallbackFrameMove(pCallbackFrameMove: PDXUTCallbackFrameMove; pUserContext: Pointer);
begin
  GetDXUTState.SetFrameMoveFunc(pCallbackFrameMove);
  GetDXUTState.SetFrameMoveFuncUserContext(pUserContext);
end;

procedure DXUTSetCallbackFrameRender(pCallbackFrameRender: PDXUTCallbackFrameRender; pUserContext: Pointer);
begin
  GetDXUTState.SetFrameRenderFunc(pCallbackFrameRender);
  GetDXUTState.SetFrameRenderFuncUserContext(pUserContext);
end;

procedure DXUTSetCallbackKeyboard(pCallbackKeyboard: PDXUTCallbackKeyboard; pUserContext: Pointer);
begin
  GetDXUTState.SetKeyboardFunc(pCallbackKeyboard);
  GetDXUTState.SetKeyboardFuncUserContext(pUserContext);
end;

procedure DXUTSetCallbackMouse(pCallbackMouse: PDXUTCallbackMouse; bIncludeMouseMove: Boolean; pUserContext: Pointer);
begin
  with GetDXUTState do
  begin
    SetMouseFunc(pCallbackMouse);
    SetNotifyOnMouseMove(bIncludeMouseMove);
  end;
end;

procedure DXUTSetCallbackMsgProc(pCallbackMsgProc: PDXUTCallbackMsgProc; pUserContext: Pointer);
begin
  GetDXUTState.SetWindowMsgFunc(pCallbackMsgProc);
  GetDXUTState.SetWindowMsgFuncUserContext(pUserContext);
end;


//--------------------------------------------------------------------------------------
// Optionally parses the command line and sets if default hotkeys are handled
//
//       Possible command line parameters are:
//          -adapter:#              forces app to use this adapter # (fails if the adapter doesn't exist)
//          -windowed               forces app to start windowed
//          -fullscreen             forces app to start full screen
//          -forcehal               forces app to use HAL (fails if HAL doesn't exist)
//          -forceref               forces app to use REF (fails if REF doesn't exist)
//          -forcepurehwvp          forces app to use pure HWVP (fails if device doesn't support it)
//          -forcehwvp              forces app to use HWVP (fails if device doesn't support it)
//          -forceswvp              forces app to use SWVP 
//          -forcevsync:#           if # is 0, forces app to use D3DPRESENT_INTERVAL_IMMEDIATE otherwise force use of D3DPRESENT_INTERVAL_DEFAULT
//          -width:#                forces app to use # for width. for full screen, it will pick the closest possible supported mode
//          -height:#               forces app to use # for height. for full screen, it will pick the closest possible supported mode
//          -startx:#               forces app to use # for the x coord of the window position for windowed mode
//          -starty:#               forces app to use # for the y coord of the window position for windowed mode
//          -constantframetime:#    forces app to use constant frame time, where # is the time/frame in seconds
//          -quitafterframe:x       forces app to quit after # frames
//          -noerrormsgboxes        prevents the display of message boxes generated by the framework so the application can be run without user interaction
//          -nostats                prevents the display of the stats
//          -relaunchmce            re-launches the MCE UI after the app exits
//          -automation             every CDXUTDialog created will have EnableKeyboardInput(true) called, enabling UI navigation with keyboard
//                                  This is useful when automating application testing.
//
//      Hotkeys handled by default are:
//          Alt-Enter           toggle between full screen & windowed (hotkey always enabled)
//          ESC                 exit app 
//          F3                  toggle HAL/REF
//          F8                  toggle wire-frame mode
//          Pause               pause time
//--------------------------------------------------------------------------------------
function DXUTInit(bParseCommandLine: Boolean = True; bHandleDefaultHotkeys: Boolean = True;
  bShowMsgBoxOnError: Boolean = True; bHandleAltEnter: Boolean = True): HRESULT;
var
  sk: TStickyKeys;
  tk: TToggleKeys;
  fk: TFilterKeys;
  pD3D: IDirect3D9;
begin
  GetDXUTState.SetDXUTInitCalled(True);

  // Not always needed, but lets the app create GDI dialogs
  InitCommonControls;

  // Save the current sticky/toggle/filter key settings so DXUT can restore them later
  FillChar(sk, SizeOf(sk), 0); sk.cbSize:= SizeOf(sk);
  SystemParametersInfo(SPI_GETSTICKYKEYS, SizeOf(sk), @sk, 0);
  GetDXUTState.SetStartupStickyKeys(sk);

  FillChar(tk, SizeOf(tk), 0); tk.cbSize:= SizeOf(tk);
  SystemParametersInfo(SPI_GETTOGGLEKEYS, SizeOf(tk), @tk, 0);
  GetDXUTState.SetStartupToggleKeys(tk);

  FillChar(fk, SizeOf(fk), 0); fk.cbSize:= SizeOf(fk);
  SystemParametersInfo(SPI_GETFILTERKEYS, SizeOf(fk), @fk, 0);
  GetDXUTState.SetStartupFilterKeys(fk);

  // Increase the accuracy of Sleep()
  timeBeginPeriod(1);

  GetDXUTState.SetShowMsgBoxOnError(bShowMsgBoxOnError);
  GetDXUTState.SetHandleDefaultHotkeys(bHandleDefaultHotkeys);
  GetDXUTState.SetHandleAltEnter(bHandleAltEnter);

  if (bParseCommandLine) then DXUTParseCommandLine;

  // Verify D3DX version
  if not D3DXCheckVersion(D3D_SDK_VERSION, D3DX_SDK_VERSION) then
  begin
    DXUTDisplayErrorMessage(DXUTERR_INCORRECTVERSION);
    Result:= DXUT_ERR('D3DXCheckVersion', DXUTERR_INCORRECTVERSION);
    Exit;
  end;

  // Create a Direct3D object if one has not already been created
  pD3D := DXUTGetD3DObject;
  if (pD3D = nil) then
  begin
    // This may fail if the DirectX headers are out of sync with the installed DirectX DLLs
    pD3D := DXUT_Dynamic_Direct3DCreate9(D3D_SDK_VERSION);
    GetDXUTState.D3D := pD3D;
  end;

  if (pD3D = nil) then
  begin
    // If still NULL, then something went wrong
    DXUTDisplayErrorMessage(DXUTERR_NODIRECT3D);
    Result:= DXUT_ERR('Direct3DCreate9', DXUTERR_NODIRECT3D);
    Exit;
  end;

  // Reset the timer
  DXUTGetGlobalTimer.Reset;

  GetDXUTState.DXUTInited := True;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Assign the current thread to one processor. This ensures that timing code runs 
// on only one processor, and will not suffer any ill effects from power management.
//--------------------------------------------------------------------------------------
procedure DXUTSetProcessorAffinity;
var
  hCurrentProcess: THandle;
  dwProcessAffinityMask: DWORD_PTR;
  dwSystemAffinityMask: DWORD_PTR;
  dwAffinityMask: DWORD_PTR;
  hCurrentThread: THandle;
begin
  hCurrentProcess := GetCurrentProcess;

  // Get the processor affinity mask for this process
  dwProcessAffinityMask := 0;
  dwSystemAffinityMask := 0;

  if GetProcessAffinityMask(hCurrentProcess, dwProcessAffinityMask, dwSystemAffinityMask) and
     (dwProcessAffinityMask <> 0) then
  begin
    // Find the lowest processor that our process is allows to run against
    dwAffinityMask := (dwProcessAffinityMask and ((not dwProcessAffinityMask) + 1 ));

    // Set this as the processor that our thread must always run against
    // This must be a subset of the process affinity mask
    hCurrentThread := GetCurrentThread;
    if (INVALID_HANDLE_VALUE <> hCurrentThread) then
    begin
      SetThreadAffinityMask(hCurrentThread, dwAffinityMask);
      CloseHandle(hCurrentThread);
    end;
  end;

  CloseHandle(hCurrentProcess);
end;


//--------------------------------------------------------------------------------------
// Parses the command line for parameters.  See DXUTInit() for list
//--------------------------------------------------------------------------------------
//Clootie: It was UNICODE procedure in C++, but due to lack of functions converted to ansi in Delphi
procedure DXUTParseCommandLine;
var
  S: String;
  strCmdLine: PAnsiChar;
  strFlag: String; // array[0..MAX_PATH-1] of AnsiChar;
  nNumArgs: Integer;
  iArg: Integer;
  nAdapter: Integer;
  nOn: Integer;
  nWidth, nHeight: Integer;
  nX, nY: Integer; 
  fTimePerFrame: Single;
  nFrame: Integer;
  strSpace: PAnsiChar;
begin
  nNumArgs:= ParamCount;
  // pstrArgList := CommandLineToArgvW( GetCommandLine, @nNumArgs);
  for iArg:= 1 to nNumArgs do
  begin
    S := ParamStr(iArg);
    strCmdLine := PAnsiChar(S);

    // Handle flag args
    if (strCmdLine^ = '/') or (strCmdLine^ = '-') then
    begin
      Inc(strCmdLine);

      if DXUTIsNextArg(strCmdLine, 'adapter') then
      begin
        if DXUTGetCmdParam(strCmdLine, strFlag) then
        begin
          nAdapter := StrToInt(strFlag);
          GetDXUTState.OverrideAdapterOrdinal := nAdapter;
          Continue;
        end;
      end;

      if DXUTIsNextArg(strCmdLine, 'windowed') then
      begin
        GetDXUTState.OverrideWindowed := True;
        Continue;
      end;

      if DXUTIsNextArg(strCmdLine, 'fullscreen') then
      begin
        GetDXUTState.OverrideFullScreen := True;
        Continue;
      end;

      if DXUTIsNextArg(strCmdLine, 'forcehal') then
      begin
        GetDXUTState.OverrideForceHAL := True;
        Continue;
      end;

      if DXUTIsNextArg(strCmdLine,'forceref') then
      begin
        GetDXUTState.OverrideForceREF := True;
        Continue;
      end;

      if DXUTIsNextArg(strCmdLine, 'forcepurehwvp') then
      begin
        GetDXUTState.OverrideForcePureHWVP := True;
        Continue;
      end;

      if DXUTIsNextArg(strCmdLine, 'forcehwvp') then
      begin
        GetDXUTState.OverrideForceHWVP := True;
        Continue;
      end;

      if DXUTIsNextArg(strCmdLine, 'forceswvp') then
      begin
        GetDXUTState.OverrideForceSWVP := True;
        Continue;
      end;

      if DXUTIsNextArg(strCmdLine, 'forcevsync') then
      begin
        if DXUTGetCmdParam(strCmdLine, strFlag) then
        begin
          nOn := StrToInt(strFlag);
          GetDXUTState.OverrideForceVsync := nOn;
          Continue;
        end;
      end;

      if DXUTIsNextArg(strCmdLine, 'width') then
      begin
        if DXUTGetCmdParam(strCmdLine, strFlag) then
        begin
          nWidth := StrToInt(strFlag);
          GetDXUTState.OverrideWidth := nWidth;
          Continue;
        end;
      end;

      if DXUTIsNextArg(strCmdLine, 'height') then
      begin
        if DXUTGetCmdParam(strCmdLine, strFlag) then
        begin
          nHeight := StrToInt(strFlag);
          GetDXUTState.OverrideHeight := nHeight;
          Continue;
        end;
      end;

      if DXUTIsNextArg(strCmdLine, 'startx') then
      begin
        if DXUTGetCmdParam(strCmdLine, strFlag) then
        begin
          nX := StrToInt(strFlag);
          GetDXUTState.OverrideStartX := nX;
          Continue;
        end;
      end;

      if DXUTIsNextArg(strCmdLine, 'starty') then
      begin
        if DXUTGetCmdParam(strCmdLine, strFlag) then
        begin
          nY := StrToInt(strFlag);
          GetDXUTState.OverrideStartY := nY;
          Continue;
        end;
      end;

      if DXUTIsNextArg(strCmdLine, 'constantframetime') then
      begin
        if DXUTGetCmdParam(strCmdLine, strFlag)
        then fTimePerFrame := StrToFloat(strFlag)
        else fTimePerFrame := 0.0333;
        GetDXUTState.OverrideConstantFrameTime := True;
        GetDXUTState.OverrideConstantTimePerFrame := fTimePerFrame;
        DXUTSetConstantFrameTime(True, fTimePerFrame);
        Continue;
      end;

      if DXUTIsNextArg(strCmdLine, 'quitafterframe') then
      begin
        if DXUTGetCmdParam(strCmdLine, strFlag) then
        begin
          nFrame := StrToInt(strFlag);
          GetDXUTState.OverrideQuitAfterFrame := nFrame;
          Continue;
        end;
      end;

      if DXUTIsNextArg(strCmdLine, 'noerrormsgboxes') then
      begin
        GetDXUTState.ShowMsgBoxOnError := False;
        Continue;
      end;

      if DXUTIsNextArg(strCmdLine, 'nostats') then
      begin
        GetDXUTState.NoStats := True;
        Continue;
      end;

      if DXUTIsNextArg(strCmdLine, 'relaunchmce') then
      begin
        GetDXUTState.OverrideRelaunchMCE := True;
        Continue;
      end;

      if DXUTIsNextArg(strCmdLine, 'automation') then
      begin
        GetDXUTState.Automation := True;
        Continue;
      end;
    end;

    // Unrecognized flag
    /// StringCchCopy(strFlag, 256, PAnsiChar(strCmdLine));
    strFlag := strCmdLine;
    strSpace := PAnsiChar(strFlag);
    while (strSpace^ <> #0) and (strSpace^ > ' ') do Inc(strSpace);
    strSpace^ := #0;

    DXUTOutputDebugString('Unrecognized flag: %s', [strFlag]);
  end;
end;


//--------------------------------------------------------------------------------------
// Helper function for DXUTParseCommandLine
//--------------------------------------------------------------------------------------
function DXUTIsNextArg(var strCmdLine: PAnsiChar; strArg: PAnsiChar): Boolean; 
var
  nArgLen: Integer;
  nCmdLen: Integer;
begin
  nArgLen := StrLen(strArg);
  nCmdLen := StrLen(strCmdLine);

  if (nCmdLen >= nArgLen) and
     (StrLIComp(strCmdLine, strArg, nArgLen) = 0) and
     ((strCmdLine[nArgLen] = #0) or (strCmdLine[nArgLen] = ':')) then
  begin
    Inc(strCmdLine, nArgLen);
    Result:= True;
    Exit;
  end;

  Result:= False;
end;


//--------------------------------------------------------------------------------------
// Helper function for DXUTParseCommandLine.  Updates strCmdLine and strFlag
//      Example: if strCmdLine=="-width:1024 -forceref"
// then after: strCmdLine==" -forceref" and strFlag=="1024"
//--------------------------------------------------------------------------------------
function DXUTGetCmdParam(var strCmdLine: PAnsiChar; out strFlag: String): Boolean;
// function DXUTGetCmdParam(var strCmdLine: PChar{PWideChar}; strFlag: PChar{PWideChar}; nFlagLen: Integer): Boolean;
var
  strFlagBuf: array[0..255] of AnsiChar;
  strSpace: PChar;
begin
  if (strCmdLine^ = ':') then
  begin
    Inc(strCmdLine); // Skip ':'

    // Place NULL terminator in strFlag after current token
    StringCchCopy(strFlagBuf, 256, strCmdLine);
    strSpace := strFlagBuf;
    while (strSpace^ <> #0) and (strSpace^ > ' ') do Inc(strSpace);
    strSpace^ := #0;

    // Update strCmdLine
    strFlag := strFlagBuf;
    Inc(strCmdLine, Length(strFlag));
    Result:= True;
  end else
  begin
    strFlag := '';
    Result:= False;
  end;
end;


//--------------------------------------------------------------------------------------
// Creates a window with the specified window title, icon, menu, and
// starting position.  If DXUTInit() has not already been called, it will
// call it with the default parameters.  Instead of calling this, you can
// call DXUTSetWindow() to use an existing window.
//--------------------------------------------------------------------------------------
function DXUTCreateWindow(const strWindowTitle: PWideChar = nil{'Direct3D Window'};
                          hInstance: LongWord = 0; hIcon: HICON = 0; hMenu: HMENU = 0;
                          x: Integer = Integer(CW_USEDEFAULT); y: Integer = Integer(CW_USEDEFAULT)): HRESULT;
var
  szExePath: array[0..MAX_PATH-1] of WideChar;
  dwError: DWORD;
  rc: TRect;
  nDefaultWidth: Integer;
  nDefaultHeight: Integer;
  strCachedWindowTitle: PWideChar;
  hWnd: Windows.HWND;
  wndClass: TWndClassW;
begin
  // Not allowed to call this from inside the device callbacks
  if GetDXUTState.InsideDeviceCallback then
  begin
    Result:= DXUT_ERR_MSGBOX('DXUTCreateWindow', E_FAIL);
    Exit;
  end;

  GetDXUTState.WindowCreateCalled:= True;

  if not GetDXUTState.DXUTInited then
  begin
    // If DXUTInit() was already called and failed, then fail.
    // DXUTInit() must first succeed for this function to succeed
    if GetDXUTState.DXUTInitCalled then
    begin
      Result:= E_FAIL;
      Exit;
    end;

    // If DXUTInit() hasn't been called, then automatically call it
    // with default params
    Result := DXUTInit;
    if FAILED(Result) then Exit;
  end;

  if (DXUTGetHWNDFocus = 0) then
  begin
    if (hInstance = 0) then hInstance := GetModuleHandle(nil);
    GetDXUTState.SetHInstance(hInstance);

    GetModuleFileNameW(0, szExePath, MAX_PATH);
    if (hIcon = 0) then // If the icon is NULL, then use the first one found in the exe
      hIcon := ExtractIconW(hInstance, szExePath, 0);

    // Register the windows class
    FillChar(wndClass, SizeOf(wndClass), 0);
    wndClass.style := CS_DBLCLKS;
    wndClass.lpfnWndProc := @DXUTStaticWndProc;
    wndClass.cbClsExtra := 0;
    wndClass.cbWndExtra := 0;
    wndClass.hInstance := hInstance;
    wndClass.hIcon := hIcon;
    wndClass.hCursor := LoadCursor(0, IDC_ARROW);
    wndClass.hbrBackground := GetStockObject(BLACK_BRUSH);
    wndClass.lpszMenuName := nil;
    wndClass.lpszClassName := 'Direct3DWindowClass';

    if (Windows.RegisterClassW(wndClass) = 0) then
    begin
      dwError := GetLastError;
      if (dwError <> ERROR_CLASS_ALREADY_EXISTS) then
      begin
        Result:= DXUT_ERR_MSGBOX('RegisterClass', HRESULT((dwError and $0000FFFF) or (FACILITY_WIN32 shl 16))); // HRESULT_FROM_WIN32(dwError));
        Exit;
      end;
    end;

    // Override the window's initial & size position if there were cmd line args
    if (GetDXUTState.OverrideStartX <> -1) then
      x := GetDXUTState.OverrideStartX;
    if (GetDXUTState.OverrideStartY <> -1) then
      y := GetDXUTState.OverrideStartY;

    GetDXUTState.WindowCreatedWithDefaultPositions:= False;
    if (DWORD(x) = CW_USEDEFAULT) and (DWORD(y) = CW_USEDEFAULT) then
      GetDXUTState.WindowCreatedWithDefaultPositions:= True;

    // Find the window's initial size, but it might be changed later
    nDefaultWidth := 640;
    nDefaultHeight := 480;
    if (GetDXUTState.OverrideWidth <> 0) then
      nDefaultWidth := GetDXUTState.OverrideWidth;
    if (GetDXUTState.OverrideHeight <> 0) then
      nDefaultHeight := GetDXUTState.OverrideHeight;
    SetRect(rc, 0, 0, nDefaultWidth, nDefaultHeight);
    AdjustWindowRect(rc, WS_OVERLAPPEDWINDOW, (hMenu <> 0));

    strCachedWindowTitle := GetDXUTState.WindowTitle;
    StringCchCopy(strCachedWindowTitle, 256, strWindowTitle);

    // Create the render window
    hWnd := CreateWindowW('Direct3DWindowClass', strCachedWindowTitle, WS_OVERLAPPEDWINDOW,
                         x, y, (rc.right-rc.left), (rc.bottom-rc.top), 0,
                         hMenu, hInstance, nil); 
    if (hWnd = 0) then
    begin
      dwError := GetLastError;
      Result:= DXUT_ERR_MSGBOX('CreateWindow', HRESULT((dwError and $0000FFFF) or (FACILITY_WIN32 shl 16))); // HRESULT_FROM_WIN32(dwError));
      Exit;
    end;

    GetDXUTState.WindowCreated := True;
    GetDXUTState.SetHWNDFocus(hWnd);
    GetDXUTState.SetHWNDDeviceFullScreen(hWnd);
    GetDXUTState.SetHWNDDeviceWindowed(hWnd);
  end;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Sets a previously created window for the framework to use.  If DXUTInit()
// has not already been called, it will call it with the default parameters.
// Instead of calling this, you can call DXUTCreateWindow() to create a new window.
//--------------------------------------------------------------------------------------
function DXUTSetWindow(hWndFocus, hWndDeviceFullScreen, hWndDeviceWindowed: HWND;
  bHandleMessages: Boolean = True): HRESULT;
var
  nResult: LONG_PTR;
  strCachedWindowTitle: PWideChar;
  dwError: DWORD;
  hInstance: HINST;
begin
  // Not allowed to call this from inside the device callbacks
  if (GetDXUTState.GetInsideDeviceCallback) then
  begin
    Result:= DXUT_ERR_MSGBOX('DXUTCreateWindow', E_FAIL);
    Exit;
  end;

  GetDXUTState.SetWindowCreateCalled(True);

  // To avoid confusion, we do not allow any HWND to be NULL here.  The
  // caller must pass in valid HWND for all three parameters.  The same
  // HWND may be used for more than one parameter.
  if (hWndFocus = 0) or (hWndDeviceFullScreen = 0) or (hWndDeviceWindowed = 0) then
  begin
    Result:= DXUT_ERR_MSGBOX('DXUTSetWindow', E_INVALIDARG);
    Exit;
  end;

  // If subclassing the window, set the pointer to the local window procedure
  if (bHandleMessages) then
  begin
    // Switch window procedures
  {$IFDEF WIN64}
    LONG_PTR nResult = SetWindowLongPtr(hWndFocus, GWLP_WNDPROC, (LONG_PTR)DXUTStaticWndProc );
  {$ELSE}
    //nResult := SetWindowLongPtr(hWndFocus, GWLP_WNDPROC, DXUTStaticWndProc);
    nResult := SetWindowLong(hWndFocus, GWL_WNDPROC, Integer(@DXUTStaticWndProc));
  {$ENDIF}

    dwError := GetLastError;
    if (nResult = 0) then
    begin
      Result:= DXUT_ERR_MSGBOX('SetWindowLongPtr', HRESULT((dwError and $0000FFFF) or (FACILITY_WIN32 shl 16))); // HRESULT_FROM_WIN32(dwError));
      Exit;
    end;
  end;

  if (not GetDXUTState.GetDXUTInited) then
  begin
    // If DXUTInit() was already called and failed, then fail.
    // DXUTInit() must first succeed for this function to succeed
    if (GetDXUTState.GetDXUTInitCalled) then
    begin
      Result:= E_FAIL;
      Exit;
    end;

    // If DXUTInit() hasn't been called, then automatically call it
    // with default params
    Result := DXUTInit;
    if FAILED(Result) then Exit;
  end;

  strCachedWindowTitle := GetDXUTState.WindowTitle;
  GetWindowTextW(hWndFocus, strCachedWindowTitle, 255);
  strCachedWindowTitle[255] := #0;

  // Get the window's initial style
  {$IFDEF WIN64}
  hInstance := HINST(LONG_PTR(GetWindowLongPtr(hWndFocus, GWLP_HINSTANCE)));
  {$ELSE}
  hInstance := HINST(LONG_PTR(GetWindowLong(hWndFocus, GWLP_HINSTANCE)));
  {$ENDIF}
  GetDXUTState.HInstance := hInstance;
  GetDXUTState.WindowCreatedWithDefaultPositions := False;
  GetDXUTState.WindowCreated := True;
  GetDXUTState.SetHWNDFocus(hWndFocus);
  GetDXUTState.SetHWNDDeviceFullScreen(hWndDeviceFullScreen);
  GetDXUTState.SetHWNDDeviceWindowed(hWndDeviceWindowed);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Creates a Direct3D device. If DXUTCreateWindow() or DXUTSetWindow() has not already
// been called, it will call DXUTCreateWindow() with the default parameters.
// Instead of calling this, you can call DXUTSetDevice() or DXUTCreateDeviceFromSettings()
//--------------------------------------------------------------------------------------
function DXUTCreateDevice(AdapterOrdinal: LongWord = D3DADAPTER_DEFAULT; bWindowed: Boolean = True;
                          nSuggestedWidth: Integer = 0; nSuggestedHeight: Integer = 0;
                          pCallbackIsDeviceAcceptable: PDXUTCallbackIsDeviceAcceptable = nil;
                          pCallbackModifyDeviceSettings: PDXUTCallbackModifyDeviceSettings = nil;
                          pUserContext: Pointer = nil): HRESULT;
var
  matchOptions: TDXUTMatchOptions;
  deviceSettings: TDXUTDeviceSettings;
begin
  // Not allowed to call this from inside the device callbacks
  if GetDXUTState.InsideDeviceCallback then
  begin
    Result:= DXUT_ERR_MSGBOX('DXUTCreateWindow', E_FAIL);
    Exit;
  end;

  // Record the function arguments in the global state
  GetDXUTState.SetIsDeviceAcceptableFunc(pCallbackIsDeviceAcceptable);
  GetDXUTState.SetModifyDeviceSettingsFunc(pCallbackModifyDeviceSettings);
  GetDXUTState.SetIsDeviceAcceptableFuncUserContext(pUserContext);
  GetDXUTState.SetModifyDeviceSettingsFuncUserContext(pUserContext);

  GetDXUTState.DeviceCreateCalled:= True;

  // If DXUTCreateWindow() or DXUTSetWindow() has not already been called,
  // then call DXUTCreateWindow() with the default parameters.
  if (not GetDXUTState.WindowCreated) then
  begin
    // If DXUTCreateWindow() or DXUTSetWindow() was already called and failed, then fail.
    // DXUTCreateWindow() or DXUTSetWindow() must first succeed for this function to succeed
    if GetDXUTState.WindowCreateCalled then
    begin
      Result:= E_FAIL;
      Exit;
    end;

    // If DXUTCreateWindow() or DXUTSetWindow() hasn't been called, then
    // automatically call DXUTCreateWindow() with default params
    Result := DXUTCreateWindow;
    if FAILED(Result) then Exit;
  end;

  // Force an enumeration with the new IsDeviceAcceptable callback
  DXUTPrepareEnumerationObject(True);

  matchOptions.eAdapterOrdinal     := DXUTMT_PRESERVE_INPUT;
  matchOptions.eDeviceType         := DXUTMT_IGNORE_INPUT;
  matchOptions.eWindowed           := DXUTMT_PRESERVE_INPUT;
  matchOptions.eAdapterFormat      := DXUTMT_IGNORE_INPUT;
  matchOptions.eVertexProcessing   := DXUTMT_IGNORE_INPUT;
  if bWindowed or ((nSuggestedWidth <> 0) and (nSuggestedHeight <> 0))
    then matchOptions.eResolution  := DXUTMT_CLOSEST_TO_INPUT
    else matchOptions.eResolution  := DXUTMT_IGNORE_INPUT;
  matchOptions.eBackBufferFormat   := DXUTMT_IGNORE_INPUT;
  matchOptions.eBackBufferCount    := DXUTMT_IGNORE_INPUT;
  matchOptions.eMultiSample        := DXUTMT_IGNORE_INPUT;
  matchOptions.eSwapEffect         := DXUTMT_IGNORE_INPUT;
  matchOptions.eDepthFormat        := DXUTMT_IGNORE_INPUT;
  matchOptions.eStencilFormat      := DXUTMT_IGNORE_INPUT;
  matchOptions.ePresentFlags       := DXUTMT_IGNORE_INPUT;
  matchOptions.eRefreshRate        := DXUTMT_IGNORE_INPUT;
  matchOptions.ePresentInterval    := DXUTMT_IGNORE_INPUT;

  ZeroMemory(@deviceSettings, SizeOf(TDXUTDeviceSettings));
  deviceSettings.AdapterOrdinal      := AdapterOrdinal;
  deviceSettings.pp.Windowed         := bWindowed;
  deviceSettings.pp.BackBufferWidth  := nSuggestedWidth;
  deviceSettings.pp.BackBufferHeight := nSuggestedHeight;

  // Override with settings from the command line
  if (GetDXUTState.OverrideWidth <> 0)
  then deviceSettings.pp.BackBufferWidth := GetDXUTState.OverrideWidth;
  if (GetDXUTState.OverrideHeight <> 0)
  then deviceSettings.pp.BackBufferHeight := GetDXUTState.OverrideHeight;

  if (GetDXUTState.OverrideAdapterOrdinal <> -1)
  then deviceSettings.AdapterOrdinal := GetDXUTState.OverrideAdapterOrdinal;

  if (GetDXUTState.OverrideFullScreen) then
  begin
    deviceSettings.pp.Windowed := False;
    if (GetDXUTState.OverrideWidth = 0) and (GetDXUTState.OverrideHeight = 0)
    then matchOptions.eResolution := DXUTMT_IGNORE_INPUT;
  end;
  if (GetDXUTState.OverrideWindowed) then
    deviceSettings.pp.Windowed := True;

  if (GetDXUTState.OverrideForceHAL) then
  begin
    deviceSettings.DeviceType := D3DDEVTYPE_HAL;
    matchOptions.eDeviceType := DXUTMT_PRESERVE_INPUT;
  end;
  if (GetDXUTState.OverrideForceREF) then
  begin
    deviceSettings.DeviceType := D3DDEVTYPE_REF;
    matchOptions.eDeviceType := DXUTMT_PRESERVE_INPUT;
  end;

  if (GetDXUTState.OverrideForcePureHWVP) then
  begin
    deviceSettings.BehaviorFlags := D3DCREATE_HARDWARE_VERTEXPROCESSING or D3DCREATE_PUREDEVICE;
    matchOptions.eVertexProcessing := DXUTMT_PRESERVE_INPUT;
  end
  else if (GetDXUTState.OverrideForceHWVP) then
  begin
    deviceSettings.BehaviorFlags := D3DCREATE_HARDWARE_VERTEXPROCESSING;
    matchOptions.eVertexProcessing := DXUTMT_PRESERVE_INPUT;
  end
  else if (GetDXUTState.OverrideForceSWVP) then
  begin
    deviceSettings.BehaviorFlags := D3DCREATE_SOFTWARE_VERTEXPROCESSING;
    matchOptions.eVertexProcessing := DXUTMT_PRESERVE_INPUT;
  end;

  if (GetDXUTState.OverrideForceVsync = 0) then
  begin
    deviceSettings.pp.PresentationInterval := D3DPRESENT_INTERVAL_IMMEDIATE;
    matchOptions.ePresentInterval := DXUTMT_PRESERVE_INPUT;
  end
  else if (GetDXUTState.OverrideForceVsync = 1) then
  begin
    deviceSettings.pp.PresentationInterval := D3DPRESENT_INTERVAL_DEFAULT;
    matchOptions.ePresentInterval := DXUTMT_PRESERVE_INPUT;
  end;

  Result := DXUTFindValidDeviceSettings(deviceSettings, @deviceSettings, @matchOptions);
  if FAILED(Result) then // the call will fail if no valid devices were found
  begin
    DXUTDisplayErrorMessage(Result);
    Result:= DXUT_ERR('DXUTFindValidDeviceSettings', Result);
    Exit;
  end;

  // Change to a Direct3D device created from the new device settings.
  // If there is an existing device, then either reset or recreated the scene
  Result := DXUTChangeDevice(@deviceSettings, nil, False, True);
  if FAILED(Result) then Exit;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Passes a previously created Direct3D device for use by the framework.
// If DXUTCreateWindow() has not already been called, it will call it with the
// default parameters.  Instead of calling this, you can call DXUTCreateDevice() or
// DXUTCreateDeviceFromSettings()
//--------------------------------------------------------------------------------------
function DXUTSetDevice(pd3dDevice: IDirect3DDevice9): HRESULT;
var
  pBackBuffer: IDirect3DSurface9;
  pSwapChain: IDirect3DSwapChain9;
  d3dCreationParams: TD3DDeviceCreationParameters;
  pDeviceSettings: PDXUTDeviceSettings;
begin
  if (pd3dDevice = nil) then
  begin
    Result:= DXUT_ERR_MSGBOX('DXUTSetDevice', E_INVALIDARG);
    Exit;
  end;

  // Not allowed to call this from inside the device callbacks
  if (GetDXUTState.GetInsideDeviceCallback) then
  begin
    Result:= DXUT_ERR_MSGBOX('DXUTCreateWindow', E_FAIL);
    Exit;
  end;

  GetDXUTState.DeviceCreateCalled:= True;

  // If DXUTCreateWindow() or DXUTSetWindow() has not already been called,
  // then call DXUTCreateWindow() with the default parameters.
  if (not GetDXUTState.WindowCreated) then 
  begin
    // If DXUTCreateWindow() or DXUTSetWindow() was already called and failed, then fail.
    // DXUTCreateWindow() or DXUTSetWindow() must first succeed for this function to succeed
    if (GetDXUTState.WindowCreateCalled) then
    begin
      Result:= E_FAIL;
      Exit;
    end;

    // If DXUTCreateWindow() or DXUTSetWindow() hasn't been called, then
    // automatically call DXUTCreateWindow() with default params
    Result := DXUTCreateWindow;
    if FAILED(Result) then Exit;
  end;

  try
    New(pDeviceSettings);
  except
    Result:= E_OUTOFMEMORY;
    Exit;
  end;
  ZeroMemory(pDeviceSettings, SizeOf(TDXUTDeviceSettings));

  // Get the present params from the swap chain
  Result := pd3dDevice.GetBackBuffer(0, 0, D3DBACKBUFFER_TYPE_MONO, pBackBuffer);
  if SUCCEEDED(Result) then
  begin
    Result := pBackBuffer.GetContainer(IID_IDirect3DSwapChain9, Pointer(pSwapChain)); 
    if SUCCEEDED(Result) then
    begin
      pSwapChain.GetPresentParameters(pDeviceSettings.pp);
      SAFE_RELEASE(pSwapChain);
    end;

    SAFE_RELEASE(pBackBuffer);
  end;

  pd3dDevice.GetCreationParameters(d3dCreationParams);

  // Fill out the rest of the device settings struct
  pDeviceSettings.AdapterOrdinal := d3dCreationParams.AdapterOrdinal;
  pDeviceSettings.DeviceType     := d3dCreationParams.DeviceType;
  DXUTFindAdapterFormat(pDeviceSettings.AdapterOrdinal, pDeviceSettings.DeviceType,
                        pDeviceSettings.pp.BackBufferFormat, pDeviceSettings.pp.Windowed,
                        pDeviceSettings.AdapterFormat);
  pDeviceSettings.BehaviorFlags  := d3dCreationParams.BehaviorFlags;

  // Change to the Direct3D device passed in
  Result := DXUTChangeDevice(pDeviceSettings, pd3dDevice, False, False);
  Dispose(pDeviceSettings);
  if FAILED(Result) then Exit;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Tells the framework to change to a device created from the passed in device settings
// If DXUTCreateWindow() has not already been called, it will call it with the
// default parameters.  Instead of calling this, you can call DXUTCreateDevice()
// or DXUTSetDevice()
//--------------------------------------------------------------------------------------
function DXUTCreateDeviceFromSettings(pDeviceSettings: PDXUTDeviceSettings; bPreserveInput: Boolean = False; bClipWindowToSingleAdapter: Boolean = True): HRESULT;
var
  matchOptions: TDXUTMatchOptions;
begin
  GetDXUTState.SetDeviceCreateCalled(True);

  // If DXUTCreateWindow() or DXUTSetWindow() has not already been called,
  // then call DXUTCreateWindow() with the default parameters.
  if not GetDXUTState.GetWindowCreated then
  begin
    // If DXUTCreateWindow() or DXUTSetWindow() was already called and failed, then fail.
    // DXUTCreateWindow() or DXUTSetWindow() must first succeed for this function to succeed
    if (GetDXUTState.GetWindowCreateCalled) then
    begin
      Result:= E_FAIL;
      Exit;
    end;

    // If DXUTCreateWindow() or DXUTSetWindow() hasn't been called, then
    // automatically call DXUTCreateWindow() with default params
    Result := DXUTCreateWindow;
    if FAILED(Result) then Exit;
  end;

  if not bPreserveInput then
  begin
    // If not preserving the input, then find the closest valid to it
    matchOptions.eAdapterOrdinal     := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.eDeviceType         := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.eWindowed           := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.eAdapterFormat      := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.eVertexProcessing   := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.eResolution         := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.eBackBufferFormat   := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.eBackBufferCount    := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.eMultiSample        := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.eSwapEffect         := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.eDepthFormat        := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.eStencilFormat      := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.ePresentFlags       := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.eRefreshRate        := DXUTMT_CLOSEST_TO_INPUT;
    matchOptions.ePresentInterval    := DXUTMT_CLOSEST_TO_INPUT;

    Result := DXUTFindValidDeviceSettings(pDeviceSettings^, pDeviceSettings, @matchOptions);
    if FAILED(Result) then // the call will fail if no valid devices were found
    begin
      DXUTDisplayErrorMessage(Result);
      Result:= DXUT_ERR('DXUTFindValidDeviceSettings', Result);
      Exit;
    end;
  end;

  // Change to a Direct3D device created from the new device settings.
  // If there is an existing device, then either reset or recreate the scene
  Result := DXUTChangeDevice(pDeviceSettings, nil, False, bClipWindowToSingleAdapter);
  if FAILED(Result) then Exit;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Toggle between full screen and windowed
//--------------------------------------------------------------------------------------
function DXUTToggleFullScreen: HRESULT;
var
  deviceSettings: TDXUTDeviceSettings;
  matchOptions: TDXUTMatchOptions;
  nWidth: Integer;
  nHeight: Integer;
  hr2: HRESULT;
begin
  // Get the current device settings and flip the windowed state then
  // find the closest valid device settings with this change
  deviceSettings := DXUTGetDeviceSettings;
  deviceSettings.pp.Windowed := not deviceSettings.pp.Windowed;

  matchOptions.eAdapterOrdinal     := DXUTMT_PRESERVE_INPUT;
  matchOptions.eDeviceType         := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eWindowed           := DXUTMT_PRESERVE_INPUT;
  matchOptions.eAdapterFormat      := DXUTMT_IGNORE_INPUT;
  matchOptions.eVertexProcessing   := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eBackBufferFormat   := DXUTMT_IGNORE_INPUT;
  matchOptions.eBackBufferCount    := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eMultiSample        := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eSwapEffect         := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eDepthFormat        := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eStencilFormat      := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.ePresentFlags       := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eRefreshRate        := DXUTMT_IGNORE_INPUT;
  matchOptions.ePresentInterval    := DXUTMT_CLOSEST_TO_INPUT;

  // Go back to previous state
  if deviceSettings.pp.Windowed then
  begin
    nWidth  := GetDXUTState.GetWindowBackBufferWidthAtModeChange;
    nHeight := GetDXUTState.GetWindowBackBufferHeightAtModeChange;
  end else
  begin
    nWidth  := GetDXUTState.GetFullScreenBackBufferWidthAtModeChange;
    nHeight := GetDXUTState.GetFullScreenBackBufferHeightAtModeChange;
  end;

  if (nWidth > 0) and (nHeight > 0) then
  begin
    matchOptions.eResolution := DXUTMT_CLOSEST_TO_INPUT;
    deviceSettings.pp.BackBufferWidth := nWidth;
    deviceSettings.pp.BackBufferHeight := nHeight;
  end else
  begin
    matchOptions.eResolution := DXUTMT_IGNORE_INPUT;
  end;

  Result := DXUTFindValidDeviceSettings(deviceSettings, @deviceSettings, @matchOptions);
  if SUCCEEDED(Result) then
  begin
    // Create a Direct3D device using the new device settings.
    // If there is an existing device, then it will either reset or recreate the scene.
    Result := DXUTChangeDevice(@deviceSettings, nil, False, False);
    // If hr == E_ABORT, this means the app rejected the device settings in the ModifySettingsCallback so nothing changed
    if FAILED(Result) and (Result <> E_ABORT) then
    begin
      // Failed creating device, try to switch back.
      deviceSettings.pp.Windowed := not deviceSettings.pp.Windowed;

      if deviceSettings.pp.Windowed then
      begin
        nWidth  := GetDXUTState.GetWindowBackBufferWidthAtModeChange;
        nHeight := GetDXUTState.GetWindowBackBufferHeightAtModeChange;
      end else
      begin
        nWidth  := GetDXUTState.GetFullScreenBackBufferWidthAtModeChange;
        nHeight := GetDXUTState.GetFullScreenBackBufferHeightAtModeChange;
      end;

      if (nWidth > 0) and (nHeight > 0) then
      begin
        matchOptions.eResolution := DXUTMT_CLOSEST_TO_INPUT;
        deviceSettings.pp.BackBufferWidth := nWidth;
        deviceSettings.pp.BackBufferHeight := nHeight;
      end else
        matchOptions.eResolution := DXUTMT_IGNORE_INPUT;

      DXUTFindValidDeviceSettings(deviceSettings, @deviceSettings, @matchOptions);

      hr2 := DXUTChangeDevice(@deviceSettings, nil, False, False);
      //todo: Fill BUG report - if SUCCEDED(hr2) then hr(==Result) will still carry error code
      if FAILED(hr2) then
      begin
        // If this failed, then shutdown
        DXUTShutdown;
      end;
    end;
  end;
end;


//--------------------------------------------------------------------------------------
// Toggle between HAL and REF
//--------------------------------------------------------------------------------------
function DXUTToggleREF: HRESULT;
var
  deviceSettings: TDXUTDeviceSettings;
  matchOptions: TDXUTMatchOptions;
  hr2: HRESULT;
begin
  deviceSettings := DXUTGetDeviceSettings;
  if (deviceSettings.DeviceType = D3DDEVTYPE_HAL)
  then deviceSettings.DeviceType := D3DDEVTYPE_REF
  else if (deviceSettings.DeviceType = D3DDEVTYPE_REF)
  then deviceSettings.DeviceType := D3DDEVTYPE_HAL;

  matchOptions.eAdapterOrdinal     := DXUTMT_PRESERVE_INPUT;
  matchOptions.eDeviceType         := DXUTMT_PRESERVE_INPUT;
  matchOptions.eWindowed           := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eAdapterFormat      := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eVertexProcessing   := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eResolution         := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eBackBufferFormat   := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eBackBufferCount    := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eMultiSample        := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eSwapEffect         := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eDepthFormat        := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eStencilFormat      := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.ePresentFlags       := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.eRefreshRate        := DXUTMT_CLOSEST_TO_INPUT;
  matchOptions.ePresentInterval    := DXUTMT_CLOSEST_TO_INPUT;

  Result := DXUTFindValidDeviceSettings(deviceSettings, @deviceSettings, @matchOptions);
  if SUCCEEDED(Result) then
  begin
    // Create a Direct3D device using the new device settings.
    // If there is an existing device, then it will either reset or recreate the scene.
    Result := DXUTChangeDevice(@deviceSettings, nil, False, False);
    // If hr == E_ABORT, this means the app rejected the device settings in the ModifySettingsCallback so nothing changed
    if FAILED(Result) and (Result <> E_ABORT) then
    begin
      // Failed creating device, try to switch back.
      if (deviceSettings.DeviceType = D3DDEVTYPE_HAL) then deviceSettings.DeviceType := D3DDEVTYPE_REF
      else if (deviceSettings.DeviceType = D3DDEVTYPE_REF) then deviceSettings.DeviceType := D3DDEVTYPE_HAL;

      DXUTFindValidDeviceSettings(deviceSettings, @deviceSettings, @matchOptions);

      //todo: Fill BUG report 2 - if SUCCEDED(hr2) then hr(==Result) will still carry error code
      hr2 := DXUTChangeDevice(@deviceSettings, nil, False, False);
      if FAILED(hr2) then
      begin
        // If this failed, then shutdown
        DXUTShutdown;
      end;
    end;
  end;
end;


//--------------------------------------------------------------------------------------
// Internal helper function to prepare the enumeration object by creating it if it 
// didn't already exist and enumerating if desired.
//--------------------------------------------------------------------------------------
function DXUTPrepareEnumerationObject(bEnumerate: Boolean = False): CD3DEnumeration; 
var
  pd3dEnum: CD3DEnumeration;
  pD3D: IDirect3D9;
begin
  // Create a new CD3DEnumeration object and enumerate all devices unless its already been done
  pd3dEnum := GetDXUTState.D3DEnumeration;
  if (pd3dEnum = nil) then
  begin
    pd3dEnum := DXUTGetEnumeration;
    GetDXUTState.SetD3DEnumeration(pd3dEnum);

    bEnumerate := True;
  end;

  if (bEnumerate) then
  begin
    // Enumerate for each adapter all of the supported display modes,
    // device types, adapter formats, back buffer formats, window/full screen support,
    // depth stencil formats, multisampling types/qualities, and presentations intervals.
    //
    // For each combination of device type (HAL/REF), adapter format, back buffer format, and
    // IsWindowed it will call the app's ConfirmDevice callback.  This allows the app
    // to reject or allow that combination based on its caps/etc.  It also allows the
    // app to change the BehaviorFlags.  The BehaviorFlags defaults non-pure HWVP
    // if supported otherwise it will default to SWVP, however the app can change this
    // through the ConfirmDevice callback.
    pD3D := DXUTGetD3DObject;
    pd3dEnum.Enumerate(pD3D, GetDXUTState.IsDeviceAcceptableFunc, GetDXUTState.IsDeviceAcceptableFuncUserContext);
  end;

  Result:= pd3dEnum;
end;


//--------------------------------------------------------------------------------------
// This function tries to find valid device settings based upon the input device settings 
// struct and the match options.  For each device setting a match option in the 
// DXUTMatchOptions struct specifies how the function makes decisions.  For example, if 
// the caller wants a HAL device with a back buffer format of D3DFMT_A2B10G10R10 but the 
// HAL device on the system does not support D3DFMT_A2B10G10R10 however a REF device is 
// installed that does, then the function has a choice to either use REF or to change to 
// a back buffer format to compatible with the HAL device.  The match options lets the 
// caller control how these choices are made.
//
// Each match option must be one of the following types: 
//      DXUTMT_IGNORE_INPUT: Uses the closest valid value to a default 
//      DXUTMT_PRESERVE_INPUT: Uses the input without change, but may cause no valid device to be found
//      DXUTMT_CLOSEST_TO_INPUT: Uses the closest valid value to the input
//
// If pMatchOptions is NULL then, all of the match options are assumed to be DXUTMT_IGNORE_INPUT.  
// The function returns failure if no valid device settings can be found otherwise 
// the function returns success and the valid device settings are written to pOut.
//--------------------------------------------------------------------------------------
function DXUTFindValidDeviceSettings(out pOut: TDXUTDeviceSettings;
  pIn: PDXUTDeviceSettings = nil; pMatchOptions: PDXUTMatchOptions = nil): HRESULT;
var
  pd3dEnum: CD3DEnumeration;
  pD3D: IDirect3D9;
  defaultMatchOptions: TDXUTMatchOptions;
  optimalDeviceSettings: TDXUTDeviceSettings;
  fBestRanking: Single;
  pBestDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;
  adapterDesktopDisplayMode: TD3DDisplayMode;
  pAdapterList: TD3DEnumAdapterInfoArray;
  iAdapter: Integer;
  pAdapterInfo: CD3DEnumAdapterInfo;
  iDeviceInfo: Integer;
  pDeviceInfo: CD3DEnumDeviceInfo;
  iDeviceCombo: Integer;
  pDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;
  fCurRanking: Single;
  validDeviceSettings: TDXUTDeviceSettings;
begin
  pd3dEnum := DXUTPrepareEnumerationObject(False);
  pD3D     := DXUTGetD3DObject;

  // Default to DXUTMT_IGNORE_INPUT for everything unless pMatchOptions isn't NULL
  if (nil = pMatchOptions) then
  begin
    ZeroMemory(@defaultMatchOptions, SizeOf(TDXUTMatchOptions));
    pMatchOptions := @defaultMatchOptions;
  end;

  // Build an optimal device settings structure based upon the match
  // options.  If the match option is set to ignore, then a optimal default value is used.
  // The default value may not exist on the system, but later this will be taken
  // into account.
  DXUTBuildOptimalDeviceSettings(@optimalDeviceSettings, pIn, pMatchOptions);

  // Find the best combination of:
  //      Adapter Ordinal
  //      Device Type
  //      Adapter Format
  //      Back Buffer Format
  //      Windowed
  // given what's available on the system and the match options combined with the device settings input.
  // This combination of settings is encapsulated by the CD3DEnumDeviceSettingsCombo class.
  fBestRanking := -1.0;
  pBestDeviceSettingsCombo := nil;

  pAdapterList := pd3dEnum.GetAdapterInfoList;
  for iAdapter:= 0 to Length(pAdapterList) - 1 do
  begin
    pAdapterInfo := pAdapterList[iAdapter];

    // Get the desktop display mode of adapter 
    pD3D.GetAdapterDisplayMode(pAdapterInfo.AdapterOrdinal, adapterDesktopDisplayMode);

    // Enum all the device types supported by this adapter to find the best device settings
    for iDeviceInfo:= 0 to Length(pAdapterInfo.deviceInfoList) - 1 do
    begin
      pDeviceInfo := pAdapterInfo.deviceInfoList[iDeviceInfo];

      // Enum all the device settings combinations.  A device settings combination is 
      // a unique set of an adapter format, back buffer format, and IsWindowed.
      for iDeviceCombo:= 0 to Length(pDeviceInfo.deviceSettingsComboList) - 1 do 
      begin
        pDeviceSettingsCombo := pDeviceInfo.deviceSettingsComboList[iDeviceCombo];

        // If windowed mode the adapter format has to be the same as the desktop 
        // display mode format so skip any that don't match
        if pDeviceSettingsCombo.Windowed and (pDeviceSettingsCombo.AdapterFormat <> adapterDesktopDisplayMode.Format)
        then Continue;

        // Skip any combo that doesn't meet the preserve match options
        if not DXUTDoesDeviceComboMatchPreserveOptions(pDeviceSettingsCombo, pIn, pMatchOptions)
        then Continue;           

        // Get a ranking number that describes how closely this device combo matches the optimal combo
        fCurRanking := DXUTRankDeviceCombo(pDeviceSettingsCombo, @optimalDeviceSettings, @adapterDesktopDisplayMode);

        // If this combo better matches the input device settings then save it
        if (fCurRanking > fBestRanking) then
        begin
          pBestDeviceSettingsCombo := pDeviceSettingsCombo;
          fBestRanking := fCurRanking;
        end;
      end;
    end;
  end;

  // If no best device combination was found then fail
  if (pBestDeviceSettingsCombo = nil) then
  begin
    Result:= DXUTERR_NOCOMPATIBLEDEVICES;
    Exit;
  end;

  // Using the best device settings combo found, build valid device settings taking heed of 
  // the match options and the input device settings
  DXUTBuildValidDeviceSettings(validDeviceSettings, pBestDeviceSettingsCombo^, pIn, pMatchOptions);
  pOut := validDeviceSettings;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Internal helper function to build a device settings structure based upon the match 
// options.  If the match option is set to ignore, then a optimal default value is used.
// The default value may not exist on the system, but later this will be taken 
// into account.
//--------------------------------------------------------------------------------------
procedure DXUTBuildOptimalDeviceSettings(pOptimalDeviceSettings: PDXUTDeviceSettings;
  pDeviceSettingsIn: PDXUTDeviceSettings; pMatchOptions: PDXUTMatchOptions);
var
  pD3D: IDirect3D9;
  adapterDesktopDisplayMode: TD3DDisplayMode;
  nBackBufferBits: LongWord;
begin
  pD3D := DXUTGetD3DObject;

  ZeroMemory(pOptimalDeviceSettings, SizeOf(TDXUTDeviceSettings));

  //---------------------
  // Adapter ordinal
  //---------------------
  if (pMatchOptions.eAdapterOrdinal = DXUTMT_IGNORE_INPUT)
  then pOptimalDeviceSettings.AdapterOrdinal := D3DADAPTER_DEFAULT
  else pOptimalDeviceSettings.AdapterOrdinal := pDeviceSettingsIn.AdapterOrdinal;

  //---------------------
  // Device type
  //---------------------
  if (pMatchOptions.eDeviceType = DXUTMT_IGNORE_INPUT)
  then pOptimalDeviceSettings.DeviceType := D3DDEVTYPE_HAL
  else pOptimalDeviceSettings.DeviceType := pDeviceSettingsIn.DeviceType;

  //---------------------
  // Windowed
  //---------------------
  if (pMatchOptions.eWindowed = DXUTMT_IGNORE_INPUT)
  then pOptimalDeviceSettings.pp.Windowed := True
  else pOptimalDeviceSettings.pp.Windowed := pDeviceSettingsIn.pp.Windowed;

  //---------------------
  // Adapter format
  //---------------------
  if (pMatchOptions.eAdapterFormat = DXUTMT_IGNORE_INPUT) then
  begin
    // If windowed, default to the desktop display mode
    // If fullscreen, default to the desktop display mode for quick mode change or
    // default to D3DFMT_X8R8G8B8 if the desktop display mode is < 32bit
    pD3D.GetAdapterDisplayMode(pOptimalDeviceSettings.AdapterOrdinal, adapterDesktopDisplayMode);
    if pOptimalDeviceSettings.pp.Windowed or (DXUTColorChannelBits(adapterDesktopDisplayMode.Format) >= 8)
    then pOptimalDeviceSettings.AdapterFormat := adapterDesktopDisplayMode.Format
    else pOptimalDeviceSettings.AdapterFormat := D3DFMT_X8R8G8B8;
  end else
  begin
    pOptimalDeviceSettings.AdapterFormat := pDeviceSettingsIn.AdapterFormat;
  end;

  //---------------------
  // Vertex processing
  //---------------------
  if (pMatchOptions.eVertexProcessing = DXUTMT_IGNORE_INPUT)
  then pOptimalDeviceSettings.BehaviorFlags := D3DCREATE_HARDWARE_VERTEXPROCESSING
  else pOptimalDeviceSettings.BehaviorFlags := pDeviceSettingsIn.BehaviorFlags;

  //---------------------
  // Resolution
  //---------------------
  if (pMatchOptions.eResolution = DXUTMT_IGNORE_INPUT) then
  begin
    // If windowed, default to 640x480
    // If fullscreen, default to the desktop res for quick mode change
    if pOptimalDeviceSettings.pp.Windowed then
    begin
      pOptimalDeviceSettings.pp.BackBufferWidth := 640;
      pOptimalDeviceSettings.pp.BackBufferHeight := 480;
    end else
    begin
      pD3D.GetAdapterDisplayMode( pOptimalDeviceSettings.AdapterOrdinal, adapterDesktopDisplayMode);
      pOptimalDeviceSettings.pp.BackBufferWidth := adapterDesktopDisplayMode.Width;
      pOptimalDeviceSettings.pp.BackBufferHeight := adapterDesktopDisplayMode.Height;
    end;
  end else
  begin
    pOptimalDeviceSettings.pp.BackBufferWidth := pDeviceSettingsIn.pp.BackBufferWidth;
    pOptimalDeviceSettings.pp.BackBufferHeight := pDeviceSettingsIn.pp.BackBufferHeight;
  end;

  //---------------------
  // Back buffer format
  //---------------------
  if (pMatchOptions.eBackBufferFormat = DXUTMT_IGNORE_INPUT)
  then pOptimalDeviceSettings.pp.BackBufferFormat := pOptimalDeviceSettings.AdapterFormat // Default to match the adapter format
  else pOptimalDeviceSettings.pp.BackBufferFormat := pDeviceSettingsIn.pp.BackBufferFormat;

  //---------------------
  // Back buffer count
  //---------------------
  if (pMatchOptions.eBackBufferCount = DXUTMT_IGNORE_INPUT)
  then pOptimalDeviceSettings.pp.BackBufferCount := 2 // Default to triple buffering for perf gain
  else pOptimalDeviceSettings.pp.BackBufferCount := pDeviceSettingsIn.pp.BackBufferCount;

  //---------------------
  // Multisample
  //---------------------
  if (pMatchOptions.eMultiSample = DXUTMT_IGNORE_INPUT) then
  begin
    // Default to no multisampling
    pOptimalDeviceSettings.pp.MultiSampleType := D3DMULTISAMPLE_NONE;
    pOptimalDeviceSettings.pp.MultiSampleQuality := 0;
  end else
  begin
    pOptimalDeviceSettings.pp.MultiSampleType := pDeviceSettingsIn.pp.MultiSampleType;
    pOptimalDeviceSettings.pp.MultiSampleQuality := pDeviceSettingsIn.pp.MultiSampleQuality;
  end;

  //---------------------
  // Swap effect
  //---------------------
  if (pMatchOptions.eSwapEffect = DXUTMT_IGNORE_INPUT)
  then pOptimalDeviceSettings.pp.SwapEffect := D3DSWAPEFFECT_DISCARD
  else pOptimalDeviceSettings.pp.SwapEffect := pDeviceSettingsIn.pp.SwapEffect;

  //---------------------
  // Depth stencil 
  //---------------------
  if (pMatchOptions.eDepthFormat = DXUTMT_IGNORE_INPUT) and
     (pMatchOptions.eStencilFormat = DXUTMT_IGNORE_INPUT) then
  begin
    nBackBufferBits := DXUTColorChannelBits(pOptimalDeviceSettings.pp.BackBufferFormat);
    if (nBackBufferBits >= 8)
    then pOptimalDeviceSettings.pp.AutoDepthStencilFormat := D3DFMT_D32
    else pOptimalDeviceSettings.pp.AutoDepthStencilFormat := D3DFMT_D16;
  end else
  begin
    pOptimalDeviceSettings.pp.AutoDepthStencilFormat := pDeviceSettingsIn.pp.AutoDepthStencilFormat;
  end;

  //---------------------
  // Present flags
  //---------------------
  if (pMatchOptions.ePresentFlags = DXUTMT_IGNORE_INPUT)
  then pOptimalDeviceSettings.pp.Flags := D3DPRESENTFLAG_DISCARD_DEPTHSTENCIL
  else pOptimalDeviceSettings.pp.Flags := pDeviceSettingsIn.pp.Flags;

  //---------------------
  // Refresh rate
  //---------------------
  if (pMatchOptions.eRefreshRate = DXUTMT_IGNORE_INPUT)
  then pOptimalDeviceSettings.pp.FullScreen_RefreshRateInHz := 0
  else pOptimalDeviceSettings.pp.FullScreen_RefreshRateInHz := pDeviceSettingsIn.pp.FullScreen_RefreshRateInHz;

  //---------------------
  // Present interval
  //---------------------
  if (pMatchOptions.ePresentInterval = DXUTMT_IGNORE_INPUT) then
  begin
    // For windowed and fullscreen, default to D3DPRESENT_INTERVAL_DEFAULT
    // which will wait for the vertical retrace period to prevent tearing.
    // For benchmarking, use D3DPRESENT_INTERVAL_DEFAULT  which will
    // will wait not for the vertical retrace period but may introduce tearing.
    pOptimalDeviceSettings.pp.PresentationInterval := D3DPRESENT_INTERVAL_DEFAULT;
  end else
  begin
    pOptimalDeviceSettings.pp.PresentationInterval := pDeviceSettingsIn.pp.PresentationInterval;
  end;
end;


//--------------------------------------------------------------------------------------
// Returns false for any CD3DEnumDeviceSettingsCombo that doesn't meet the preserve
// match options against the input pDeviceSettingsIn.
//--------------------------------------------------------------------------------------
function DXUTDoesDeviceComboMatchPreserveOptions(pDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;
  pDeviceSettingsIn: PDXUTDeviceSettings; pMatchOptions: PDXUTMatchOptions): Boolean;
var
  bFound: Boolean;
  i: Integer;
  displayMode: TD3DDisplayMode;
  msType: TD3DMultiSampleType;
  msQuality: DWORD;
  dwDepthBits: LongWord;
  depthStencilFmt: TD3DFormat;
  dwCurDepthBits: LongWord;
  dwStencilBits: LongWord;
  dwCurStencilBits: LongWord;
begin
  Result:= False;
  
  //---------------------
  // Adapter ordinal
  //---------------------
  if (pMatchOptions.eAdapterOrdinal = DXUTMT_PRESERVE_INPUT) and
     (pDeviceSettingsCombo.AdapterOrdinal <> pDeviceSettingsIn.AdapterOrdinal)
  then Exit;

  //---------------------
  // Device type
  //---------------------
  if (pMatchOptions.eDeviceType = DXUTMT_PRESERVE_INPUT) and
     (pDeviceSettingsCombo.DeviceType <> pDeviceSettingsIn.DeviceType)
  then Exit;

  //---------------------
  // Windowed
  //---------------------
  if (pMatchOptions.eWindowed = DXUTMT_PRESERVE_INPUT) and
     (pDeviceSettingsCombo.Windowed <> pDeviceSettingsIn.pp.Windowed)
  then Exit;

  //---------------------
  // Adapter format
  //---------------------
  if (pMatchOptions.eAdapterFormat = DXUTMT_PRESERVE_INPUT) and
     (pDeviceSettingsCombo.AdapterFormat <> pDeviceSettingsIn.AdapterFormat)
  then Exit;

  //---------------------
  // Vertex processing
  //---------------------
  // If keep VP and input has HWVP, then skip if this combo doesn't have HWTL
  if (pMatchOptions.eVertexProcessing = DXUTMT_PRESERVE_INPUT) and
     ((pDeviceSettingsIn.BehaviorFlags and D3DCREATE_HARDWARE_VERTEXPROCESSING) <> 0) and
     ((pDeviceSettingsCombo.pDeviceInfo.Caps.DevCaps and D3DDEVCAPS_HWTRANSFORMANDLIGHT) = 0)
  then Exit;

  //---------------------
  // Resolution
  //---------------------
  // If keep resolution then check that width and height supported by this combo
  if (pMatchOptions.eResolution = DXUTMT_PRESERVE_INPUT) then 
  begin
    bFound := False;
    for i:= 0 to Length(pDeviceSettingsCombo.pAdapterInfo.displayModeList) - 1 do
    begin
      displayMode := pDeviceSettingsCombo.pAdapterInfo.displayModeList[i];
      if (displayMode.Format <> pDeviceSettingsCombo.AdapterFormat)
      then Continue; // Skip this display mode if it doesn't match the combo's adapter format

      if (displayMode.Width = pDeviceSettingsIn.pp.BackBufferWidth) and
         (displayMode.Height = pDeviceSettingsIn.pp.BackBufferHeight) then
      begin
        bFound := True;
        Break;
      end;
    end;

    // If the width and height are not supported by this combo, return false
    if (not bFound) then Exit;
  end;

  //---------------------
  // Back buffer format
  //---------------------
  if (pMatchOptions.eBackBufferFormat = DXUTMT_PRESERVE_INPUT) and
     (pDeviceSettingsCombo.BackBufferFormat <> pDeviceSettingsIn.pp.BackBufferFormat)
  then Exit;

  //---------------------
  // Back buffer count
  //---------------------
  // No caps for the back buffer count

  //---------------------
  // Multisample
  //---------------------
  if (pMatchOptions.eMultiSample = DXUTMT_PRESERVE_INPUT) then
  begin
    bFound := false;
    for i:= 0 to Length(pDeviceSettingsCombo.multiSampleTypeList) - 1 do
    begin
      msType := pDeviceSettingsCombo.multiSampleTypeList[i];
      msQuality  := pDeviceSettingsCombo.multiSampleQualityList[i];

      if (msType = pDeviceSettingsIn.pp.MultiSampleType) and
         (msQuality >= pDeviceSettingsIn.pp.MultiSampleQuality) then
      begin
        bFound := True;
        Break;
      end;
    end;

    // If multisample type/quality not supported by this combo, then return false
    if not bFound then Exit;
  end;

  //---------------------
  // Swap effect
  //---------------------
  // No caps for swap effects

  //---------------------
  // Depth stencil 
  //---------------------
  // If keep depth stencil format then check that the depth stencil format is supported by this combo
  if (pMatchOptions.eDepthFormat = DXUTMT_PRESERVE_INPUT) and
     (pMatchOptions.eStencilFormat = DXUTMT_PRESERVE_INPUT) then
  begin
    if (pDeviceSettingsIn.pp.AutoDepthStencilFormat <> D3DFMT_UNKNOWN) and
       // not pDeviceSettingsCombo.depthStencilFormatList.Contains(pDeviceSettingsIn.pp.AutoDepthStencilFormat
       not DynArrayContains(pDeviceSettingsCombo.depthStencilFormatList,
                            pDeviceSettingsIn.pp.AutoDepthStencilFormat,
                            SizeOf(pDeviceSettingsIn.pp.AutoDepthStencilFormat))
    then Exit;
  end;

  // If keep depth format then check that the depth format is supported by this combo
  if (pMatchOptions.eDepthFormat = DXUTMT_PRESERVE_INPUT) and
     (pDeviceSettingsIn.pp.AutoDepthStencilFormat <> D3DFMT_UNKNOWN) then
  begin
    bFound := False;
    dwDepthBits := DXUTDepthBits(pDeviceSettingsIn.pp.AutoDepthStencilFormat);
    for i:= 0 to Length(pDeviceSettingsCombo.depthStencilFormatList) - 1 do
    begin
      depthStencilFmt := pDeviceSettingsCombo.depthStencilFormatList[i];
      dwCurDepthBits := DXUTDepthBits(depthStencilFmt);
      if (dwCurDepthBits - dwDepthBits = 0) then bFound := True;
    end;

    if not bFound then Exit;
  end;

  // If keep depth format then check that the depth format is supported by this combo
  if (pMatchOptions.eStencilFormat = DXUTMT_PRESERVE_INPUT) and
     (pDeviceSettingsIn.pp.AutoDepthStencilFormat <> D3DFMT_UNKNOWN) then
  begin
    bFound := False;
    dwStencilBits := DXUTStencilBits(pDeviceSettingsIn.pp.AutoDepthStencilFormat);
    for i:= 0 to Length(pDeviceSettingsCombo.depthStencilFormatList) - 1 do
    begin
      depthStencilFmt := pDeviceSettingsCombo.depthStencilFormatList[i];
      dwCurStencilBits := DXUTStencilBits(depthStencilFmt);
      if (dwCurStencilBits - dwStencilBits = 0) then bFound := True;
    end;

    if not bFound then Exit;
  end;

  //---------------------
  // Present flags
  //---------------------
  // No caps for the present flags

  //---------------------
  // Refresh rate
  //---------------------
  // If keep refresh rate then check that the resolution is supported by this combo
  if (pMatchOptions.eRefreshRate = DXUTMT_PRESERVE_INPUT) then
  begin
    bFound := false;
    for i:= 0 to Length(pDeviceSettingsCombo.pAdapterInfo.displayModeList) - 1 do
    begin
      displayMode := pDeviceSettingsCombo.pAdapterInfo.displayModeList[i];
      if (displayMode.Format <> pDeviceSettingsCombo.AdapterFormat) then Continue;
      if (displayMode.RefreshRate = pDeviceSettingsIn.pp.FullScreen_RefreshRateInHz) then
      begin
        bFound := True;
        Break;
      end;
    end;

    // If refresh rate not supported by this combo, then return false
    if not bFound then Exit;
  end;

  //---------------------
  // Present interval
  //---------------------
  // If keep present interval then check that the present interval is supported by this combo
  if (pMatchOptions.ePresentInterval = DXUTMT_PRESERVE_INPUT) and
     // not pDeviceSettingsCombo.presentIntervalList.Contains(pDeviceSettingsIn.pp.PresentationInterval)}
     not DynArrayContains(pDeviceSettingsCombo.presentIntervalList,
                          pDeviceSettingsIn.pp.PresentationInterval,
                          SizeOf(pDeviceSettingsIn.pp.PresentationInterval))
  then Exit;

  Result:= True;
end;


//--------------------------------------------------------------------------------------
// Returns a ranking number that describes how closely this device
// combo matches the optimal combo based on the match options and the optimal device settings
//--------------------------------------------------------------------------------------
function DXUTRankDeviceCombo(pDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;
  pOptimalDeviceSettings: PDXUTDeviceSettings; pAdapterDesktopDisplayMode: PD3DDisplayMode): Single;
const
  // Arbitrary weights.  Gives preference to the ordinal, device type, and windowed
  fAdapterOrdinalWeight   = 1000.0;
  fDeviceTypeWeight       = 100.0;
  fWindowWeight           = 10.0;
  fAdapterFormatWeight    = 1.0;
  fVertexProcessingWeight = 1.0;
  fResolutionWeight       = 1.0;
  fBackBufferFormatWeight = 1.0;
  fMultiSampleWeight      = 1.0;
  fDepthStencilWeight     = 1.0;
  fRefreshRateWeight      = 1.0;
  fPresentIntervalWeight  = 1.0;
var
  fCurRanking: Single;
  nBitDepthDelta: Integer;
  fScale: Single;
  bAdapterOptimalMatch: Boolean;
  bResolutionFound: Boolean;
  idm: Integer;
  displayMode: TD3DDisplayMode;
  bAdapterMatchesBB: Boolean;
  bMultiSampleFound: Boolean;
  i: Integer;
  msType: TD3DMultiSampleType;
  msQuality: DWORD;
  bRefreshFound: Boolean;
begin
  fCurRanking := 0.0;

  //---------------------
  // Adapter ordinal
  //---------------------
  if (pDeviceSettingsCombo.AdapterOrdinal = pOptimalDeviceSettings.AdapterOrdinal)
  then fCurRanking := fCurRanking + fAdapterOrdinalWeight;

  //---------------------
  // Device type
  //---------------------
  if (pDeviceSettingsCombo.DeviceType = pOptimalDeviceSettings.DeviceType)
  then fCurRanking := fCurRanking + fDeviceTypeWeight;
  // Slightly prefer HAL
  if (pDeviceSettingsCombo.DeviceType = D3DDEVTYPE_HAL)
  then fCurRanking := fCurRanking + 0.1;

  //---------------------
  // Windowed
  //---------------------
  if (pDeviceSettingsCombo.Windowed = pOptimalDeviceSettings.pp.Windowed )
  then fCurRanking := fCurRanking + fWindowWeight;

  //---------------------
  // Adapter format
  //---------------------
  if (pDeviceSettingsCombo.AdapterFormat = pOptimalDeviceSettings.AdapterFormat) then
  begin
    fCurRanking := fCurRanking + fAdapterFormatWeight;
  end else
  begin
    nBitDepthDelta := Abs(DXUTColorChannelBits(pDeviceSettingsCombo.AdapterFormat) -
                          DXUTColorChannelBits(pOptimalDeviceSettings.AdapterFormat));
    fScale := Max(0.9 - nBitDepthDelta*0.2, 0);
    fCurRanking := fCurRanking + fScale * fAdapterFormatWeight;
  end;

  if (not pDeviceSettingsCombo.Windowed) then
  begin
    // Slightly prefer when it matches the desktop format or is D3DFMT_X8R8G8B8
    if (DXUTColorChannelBits(pAdapterDesktopDisplayMode.Format) >= 8)
    then bAdapterOptimalMatch := (pDeviceSettingsCombo.AdapterFormat = pAdapterDesktopDisplayMode.Format)
    else bAdapterOptimalMatch := (pDeviceSettingsCombo.AdapterFormat = D3DFMT_X8R8G8B8);

    if (bAdapterOptimalMatch) then fCurRanking := fCurRanking + 0.1;
  end;

  //---------------------
  // Vertex processing
  //---------------------
  if ((pOptimalDeviceSettings.BehaviorFlags and D3DCREATE_HARDWARE_VERTEXPROCESSING) <> 0) or
     ((pOptimalDeviceSettings.BehaviorFlags and D3DCREATE_MIXED_VERTEXPROCESSING) <> 0) then
  begin
    if ((pDeviceSettingsCombo.pDeviceInfo.Caps.DevCaps and D3DDEVCAPS_HWTRANSFORMANDLIGHT) <> 0)
    then fCurRanking := fCurRanking + fVertexProcessingWeight;
  end;
  // Slightly prefer HW T&L
  if ((pDeviceSettingsCombo.pDeviceInfo.Caps.DevCaps and D3DDEVCAPS_HWTRANSFORMANDLIGHT) <> 0)
  then fCurRanking := fCurRanking + 0.1;

  //---------------------
  // Resolution
  //---------------------
  bResolutionFound := False;
  for idm := 0 to Length(pDeviceSettingsCombo.pAdapterInfo.displayModeList) - 1 do
  begin
    displayMode := pDeviceSettingsCombo.pAdapterInfo.displayModeList[idm];
    if (displayMode.Format <> pDeviceSettingsCombo.AdapterFormat) then Continue;

    if (displayMode.Width = pOptimalDeviceSettings.pp.BackBufferWidth) and
       (displayMode.Height = pOptimalDeviceSettings.pp.BackBufferHeight)
    then bResolutionFound := True;
  end;
  if (bResolutionFound) then fCurRanking := fCurRanking + fResolutionWeight;

  //---------------------
  // Back buffer format
  //---------------------
  if (pDeviceSettingsCombo.BackBufferFormat = pOptimalDeviceSettings.pp.BackBufferFormat) then
  begin
    fCurRanking := fCurRanking + fBackBufferFormatWeight;
  end else
  begin
    nBitDepthDelta := Abs(DXUTColorChannelBits(pDeviceSettingsCombo.BackBufferFormat) -
                          DXUTColorChannelBits(pOptimalDeviceSettings.pp.BackBufferFormat));
    fScale := Max(0.9 - nBitDepthDelta*0.2, 0);
    fCurRanking := fCurRanking + fScale * fBackBufferFormatWeight;
  end;

  // Check if this back buffer format is the same as
  // the adapter format since this is preferred.
  bAdapterMatchesBB := (pDeviceSettingsCombo.BackBufferFormat = pDeviceSettingsCombo.AdapterFormat);
  if bAdapterMatchesBB then fCurRanking := fCurRanking + 0.1;

  //---------------------
  // Back buffer count
  //---------------------
  // No caps for the back buffer count

  //---------------------
  // Multisample
  //---------------------
  bMultiSampleFound := False;
  for i:= 0 to Length(pDeviceSettingsCombo.multiSampleTypeList) - 1 do
  begin
    msType := pDeviceSettingsCombo.multiSampleTypeList[i];
    msQuality  := pDeviceSettingsCombo.multiSampleQualityList[i];

    if (msType = pOptimalDeviceSettings.pp.MultiSampleType) and
       (msQuality >= pOptimalDeviceSettings.pp.MultiSampleQuality) then
    begin
      bMultiSampleFound := True;
      Break;
    end;
  end;
  if bMultiSampleFound then fCurRanking := fCurRanking + fMultiSampleWeight;

  //---------------------
  // Swap effect
  //---------------------
  // No caps for swap effects

  //---------------------
  // Depth stencil
  //---------------------
  // if (pDeviceSettingsCombo.depthStencilFormatList.Contains(pOptimalDeviceSettings.pp.AutoDepthStencilFormat)
  if DynArrayContains(pDeviceSettingsCombo.depthStencilFormatList,
                      pOptimalDeviceSettings.pp.AutoDepthStencilFormat,
                      SizeOf(pOptimalDeviceSettings.pp.AutoDepthStencilFormat))
  then fCurRanking := fCurRanking + fDepthStencilWeight;

  //---------------------
  // Present flags
  //---------------------
  // No caps for the present flags

  //---------------------
  // Refresh rate
  //---------------------
  bRefreshFound := False;
  for idm := 0 to Length(pDeviceSettingsCombo.pAdapterInfo.displayModeList) - 1 do
  begin
    displayMode := pDeviceSettingsCombo.pAdapterInfo.displayModeList[idm];
    if (displayMode.Format <> pDeviceSettingsCombo.AdapterFormat) then Continue;

    if (displayMode.RefreshRate = pOptimalDeviceSettings.pp.FullScreen_RefreshRateInHz)
    then bRefreshFound := True;
  end;
  if bRefreshFound then fCurRanking := fCurRanking + fRefreshRateWeight;

  //---------------------
  // Present interval
  //---------------------
  // If keep present interval then check that the present interval is supported by this combo
  // if (pDeviceSettingsCombo.presentIntervalList.Contains(pOptimalDeviceSettings.pp.PresentationInterval)
  if DynArrayContains(pDeviceSettingsCombo.presentIntervalList,
                      pOptimalDeviceSettings.pp.PresentationInterval,
                      SizeOf(pOptimalDeviceSettings.pp.PresentationInterval))
  then fCurRanking := fCurRanking + fPresentIntervalWeight;

  Result:= fCurRanking;
end;


//--------------------------------------------------------------------------------------
// Builds valid device settings using the match options, the input device settings, and the 
// best device settings combo found.
//--------------------------------------------------------------------------------------
procedure DXUTBuildValidDeviceSettings(out pValidDeviceSettings: TDXUTDeviceSettings;
  const pBestDeviceSettingsCombo: TD3DEnumDeviceSettingsCombo; pDeviceSettingsIn: PDXUTDeviceSettings;
  pMatchOptions: PDXUTMatchOptions);
var
  pD3D: IDirect3D9;
  adapterDesktopDisplayMode: TD3DDisplayMode;
  dwBestBehaviorFlags: DWORD;
  bestDisplayMode: TD3DDisplayMode;
  displayModeIn: TD3DDisplayMode;
  bestBackBufferCount: LongWord;
  bestMultiSampleType: TD3DMultiSampleType;
  bestMultiSampleQuality: DWORD;
  i: Integer;
  bestSwapEffect: TD3DSwapEffect;
  bestDepthStencilFormat: TD3DFormat;
  bestEnableAutoDepthStencil: Boolean;
  depthStencilRanking: array of Integer;
  dwBackBufferBitDepth: LongWord;
  dwInputDepthBitDepth: LongWord;
  curDepthStencilFmt: TD3DFormat;
  dwCurDepthBitDepth: DWORD;
  nRanking: Integer;
  l: Integer;
  dwInputStencilBitDepth: LongWord;
  dwCurStencilBitDepth: DWORD;
  nBestRanking: Integer;
  nBestIndex: Integer;
  dwBestFlags: DWORD;
  refreshRateMatch: LongWord;
  nBestRefreshRanking: Integer;
  pDisplayModeList: TD3DDisplayModeArray;
  iDisplayMode: Integer;
  displayMode: TD3DDisplayMode;
  nCurRanking: Integer;
  bestPresentInterval: LongWord;
  type_: TD3DMultiSampleType;
  qualityLevels: DWORD;
begin
  pDisplayModeList := nil;
  pD3D := DXUTGetD3DObject;
  pD3D.GetAdapterDisplayMode(pBestDeviceSettingsCombo.AdapterOrdinal, adapterDesktopDisplayMode);

  // For each setting pick the best, taking into account the match options and
  // what's supported by the device

  //---------------------
  // Adapter Ordinal
  //---------------------
  // Just using pBestDeviceSettingsCombo->AdapterOrdinal

  //---------------------
  // Device Type
  //---------------------
  // Just using pBestDeviceSettingsCombo->DeviceType

  //---------------------
  // Windowed 
  //---------------------
  // Just using pBestDeviceSettingsCombo->Windowed

  //---------------------
  // Adapter Format
  //---------------------
  // Just using pBestDeviceSettingsCombo->AdapterFormat

  //---------------------
  // Vertex processing
  //---------------------
  dwBestBehaviorFlags := 0;
  if (pMatchOptions.eVertexProcessing = DXUTMT_PRESERVE_INPUT) then
  begin
    dwBestBehaviorFlags := pDeviceSettingsIn.BehaviorFlags;
  end
  else if (pMatchOptions.eVertexProcessing = DXUTMT_IGNORE_INPUT) then
  begin
    // The framework defaults to HWVP if available otherwise use SWVP
    if ((pBestDeviceSettingsCombo.pDeviceInfo.Caps.DevCaps and D3DDEVCAPS_HWTRANSFORMANDLIGHT) <> 0)
    then dwBestBehaviorFlags := dwBestBehaviorFlags or D3DCREATE_HARDWARE_VERTEXPROCESSING
    else dwBestBehaviorFlags := dwBestBehaviorFlags or D3DCREATE_SOFTWARE_VERTEXPROCESSING;
  end
  else // if( pMatchOptions->eVertexProcessing == DXUTMT_CLOSEST_TO_INPUT )
  begin
    // Default to input, and fallback to SWVP if HWVP not available
    dwBestBehaviorFlags := pDeviceSettingsIn.BehaviorFlags;
    if ((pBestDeviceSettingsCombo.pDeviceInfo.Caps.DevCaps and D3DDEVCAPS_HWTRANSFORMANDLIGHT) = 0) and
       (((dwBestBehaviorFlags and D3DCREATE_HARDWARE_VERTEXPROCESSING) <> 0) or
        ((dwBestBehaviorFlags and D3DCREATE_MIXED_VERTEXPROCESSING) <> 0)) then
    begin
      dwBestBehaviorFlags := dwBestBehaviorFlags and not D3DCREATE_HARDWARE_VERTEXPROCESSING;
      dwBestBehaviorFlags := dwBestBehaviorFlags and not D3DCREATE_MIXED_VERTEXPROCESSING;
      dwBestBehaviorFlags := dwBestBehaviorFlags or D3DCREATE_SOFTWARE_VERTEXPROCESSING;
    end;

    // One of these must be selected
    if ((dwBestBehaviorFlags and D3DCREATE_HARDWARE_VERTEXPROCESSING) = 0) and
       ((dwBestBehaviorFlags and D3DCREATE_MIXED_VERTEXPROCESSING) = 0) and
       ((dwBestBehaviorFlags and D3DCREATE_SOFTWARE_VERTEXPROCESSING) = 0) then
    begin
      if ((pBestDeviceSettingsCombo.pDeviceInfo.Caps.DevCaps and D3DDEVCAPS_HWTRANSFORMANDLIGHT) <> 0)
      then dwBestBehaviorFlags := dwBestBehaviorFlags or D3DCREATE_HARDWARE_VERTEXPROCESSING
      else dwBestBehaviorFlags := dwBestBehaviorFlags or D3DCREATE_SOFTWARE_VERTEXPROCESSING;
    end;
  end;

  //---------------------
  // Resolution
  //---------------------
  if (pMatchOptions.eResolution = DXUTMT_PRESERVE_INPUT) then
  begin
    bestDisplayMode.Width := pDeviceSettingsIn.pp.BackBufferWidth;
    bestDisplayMode.Height := pDeviceSettingsIn.pp.BackBufferHeight;
  end else
  begin
    if (pMatchOptions.eResolution = DXUTMT_CLOSEST_TO_INPUT) and
       (pDeviceSettingsIn <> nil) then
    begin
      displayModeIn.Width := pDeviceSettingsIn.pp.BackBufferWidth;
      displayModeIn.Height := pDeviceSettingsIn.pp.BackBufferHeight;
    end
    else // if( pMatchOptions->eResolution == DXUTMT_IGNORE_INPUT )
    begin
      if pBestDeviceSettingsCombo.Windowed then
      begin
        // The framework defaults to 640x480 for windowed
        displayModeIn.Width := 640;
        displayModeIn.Height := 480;
      end else
      begin
        // The framework defaults to desktop resolution for fullscreen to try to avoid slow mode change
        displayModeIn.Width := adapterDesktopDisplayMode.Width;
        displayModeIn.Height := adapterDesktopDisplayMode.Height;
      end;
    end;

    // Call a helper function to find the closest valid display mode to the optimal
    DXUTFindValidResolution(pBestDeviceSettingsCombo, displayModeIn, bestDisplayMode);
  end;

  //---------------------
  // Back Buffer Format
  //---------------------
  // Just using pBestDeviceSettingsCombo->BackBufferFormat

  //---------------------
  // Back buffer count
  //---------------------
  if (pMatchOptions.eBackBufferCount = DXUTMT_PRESERVE_INPUT) then
  begin
    bestBackBufferCount := pDeviceSettingsIn.pp.BackBufferCount;
  end
  else if (pMatchOptions.eBackBufferCount = DXUTMT_IGNORE_INPUT) then
  begin
    // The framework defaults to triple buffering
    bestBackBufferCount := 2;
  end
  else // if( pMatchOptions->eBackBufferCount == DXUTMT_CLOSEST_TO_INPUT )
  begin
    bestBackBufferCount := pDeviceSettingsIn.pp.BackBufferCount;
    if (bestBackBufferCount > 3) then bestBackBufferCount := 3;
    if (bestBackBufferCount < 1) then bestBackBufferCount := 1;
  end;

  //---------------------
  // Multisample
  //---------------------
  if (pDeviceSettingsIn <> nil) and (pDeviceSettingsIn.pp.SwapEffect <> D3DSWAPEFFECT_DISCARD) then
  begin
    // Swap effect is not set to discard so multisampling has to off
    bestMultiSampleType := D3DMULTISAMPLE_NONE;
    bestMultiSampleQuality := 0;
  end else
  begin
    if (pMatchOptions.eMultiSample = DXUTMT_PRESERVE_INPUT) then
    begin
      bestMultiSampleType    := pDeviceSettingsIn.pp.MultiSampleType;
      bestMultiSampleQuality := pDeviceSettingsIn.pp.MultiSampleQuality;
    end
    else if (pMatchOptions.eMultiSample = DXUTMT_IGNORE_INPUT) then
    begin
      // Default to no multisampling (always supported)
      bestMultiSampleType := D3DMULTISAMPLE_NONE;
      bestMultiSampleQuality := 0;
    end
    else if (pMatchOptions.eMultiSample = DXUTMT_CLOSEST_TO_INPUT) then
    begin
      // Default to no multisampling (always supported)
      bestMultiSampleType := D3DMULTISAMPLE_NONE;
      bestMultiSampleQuality := 0;

      for i := 0 to Length(pBestDeviceSettingsCombo.multiSampleTypeList) - 1 do
      begin
        type_ := pBestDeviceSettingsCombo.multiSampleTypeList[i];
        qualityLevels := pBestDeviceSettingsCombo.multiSampleQualityList[i];

        // Check whether supported type is closer to the input than our current best
        if (Abs(Ord(type_) - Ord(pDeviceSettingsIn.pp.MultiSampleType)) <
              Abs(Ord(bestMultiSampleType) - Ord(pDeviceSettingsIn.pp.MultiSampleType))) then
        begin
          bestMultiSampleType := type_;
          bestMultiSampleQuality := Min(qualityLevels-1, pDeviceSettingsIn.pp.MultiSampleQuality);
        end;
      end;
    end else
    begin
      // Error case
      bestMultiSampleType := D3DMULTISAMPLE_NONE;
      bestMultiSampleQuality := 0;
    end;
  end;

  //---------------------
  // Swap effect
  //---------------------
  if (pMatchOptions.eSwapEffect = DXUTMT_PRESERVE_INPUT) then
  begin
    bestSwapEffect := pDeviceSettingsIn.pp.SwapEffect;
  end
  else if (pMatchOptions.eSwapEffect = DXUTMT_IGNORE_INPUT) then
  begin
    bestSwapEffect := D3DSWAPEFFECT_DISCARD;
  end
  else // if( pMatchOptions->eSwapEffect == DXUTMT_CLOSEST_TO_INPUT )
  begin
    bestSwapEffect := pDeviceSettingsIn.pp.SwapEffect;

    // Swap effect has to be one of these 3
    //Clootie: This can be avoided in Delphi (as in strong typed language)...
    if (bestSwapEffect <> D3DSWAPEFFECT_DISCARD) and
       (bestSwapEffect <> D3DSWAPEFFECT_FLIP) and
       (bestSwapEffect <> D3DSWAPEFFECT_COPY) then
    begin
      bestSwapEffect := D3DSWAPEFFECT_DISCARD;
    end;
  end;

  //---------------------
  // Depth stencil
  //---------------------
  dwBackBufferBitDepth := DXUTColorChannelBits(pBestDeviceSettingsCombo.BackBufferFormat);
  dwInputDepthBitDepth := 0;
  if (pDeviceSettingsIn <> nil) then
    dwInputDepthBitDepth := DXUTDepthBits(pDeviceSettingsIn.pp.AutoDepthStencilFormat);

  for i:= 0 to Length(pBestDeviceSettingsCombo.depthStencilFormatList) - 1 do
  begin
    curDepthStencilFmt := pBestDeviceSettingsCombo.depthStencilFormatList[i];
    dwCurDepthBitDepth := DXUTDepthBits(curDepthStencilFmt);

    if (pMatchOptions.eDepthFormat = DXUTMT_PRESERVE_INPUT) then
    begin
      // Need to match bit depth of input
      if (dwCurDepthBitDepth = dwInputDepthBitDepth)
      then nRanking := 0
      else nRanking := 10000;
    end
    else if (pMatchOptions.eDepthFormat = DXUTMT_IGNORE_INPUT) then
    begin
      // Prefer match of backbuffer bit depth
      nRanking := Abs(Integer(dwCurDepthBitDepth) - Integer(dwBackBufferBitDepth*4));
    end
    else // if( pMatchOptions->eDepthFormat == DXUTMT_CLOSEST_TO_INPUT )
    begin
      // Prefer match of input depth format bit depth
      nRanking := Abs(Integer(dwCurDepthBitDepth) - Integer(dwInputDepthBitDepth));
    end;

    // depthStencilRanking.Add(nRanking);
    l:= Length(depthStencilRanking);
    SetLength(depthStencilRanking, l+1);
    depthStencilRanking[l]:= nRanking;
  end;

  dwInputStencilBitDepth := 0;
  if (pDeviceSettingsIn <> nil) then
    dwInputStencilBitDepth := DXUTStencilBits(pDeviceSettingsIn.pp.AutoDepthStencilFormat);

  for i:= 0 to Length(pBestDeviceSettingsCombo.depthStencilFormatList) - 1 do
  begin
    curDepthStencilFmt := pBestDeviceSettingsCombo.depthStencilFormatList[i];
    nRanking := depthStencilRanking[i];
    dwCurStencilBitDepth := DXUTStencilBits(curDepthStencilFmt);

    if (pMatchOptions.eStencilFormat = DXUTMT_PRESERVE_INPUT) then
    begin
      // Need to match bit depth of input
      if (dwCurStencilBitDepth = dwInputStencilBitDepth)
      then Inc(nRanking, 0)
      else Inc(nRanking, 10000);
    end
    else if (pMatchOptions.eStencilFormat = DXUTMT_IGNORE_INPUT) then
    begin
      // Prefer 0 stencil bit depth
      Inc(nRanking, dwCurStencilBitDepth);
    end
    else // if( pMatchOptions->eStencilFormat == DXUTMT_CLOSEST_TO_INPUT )
    begin
      // Prefer match of input stencil format bit depth
      Inc(nRanking, Abs(Integer(dwCurStencilBitDepth) - Integer(dwInputStencilBitDepth)));
    end;

    depthStencilRanking[i]:= nRanking;
  end;

  nBestRanking := 100000;
  nBestIndex := -1;
  for i:= 0 to Length(pBestDeviceSettingsCombo.depthStencilFormatList) - 1 do
  begin
    nRanking := depthStencilRanking[i];
    if (nRanking < nBestRanking) then
    begin
      nBestRanking := nRanking;
      nBestIndex := i;
    end;
  end;

  if (nBestIndex >= 0) then
  begin
    bestDepthStencilFormat := pBestDeviceSettingsCombo.depthStencilFormatList[nBestIndex];
    bestEnableAutoDepthStencil := True;
  end else
  begin
    bestDepthStencilFormat := D3DFMT_UNKNOWN;
    bestEnableAutoDepthStencil := False;
  end;


  //---------------------
  // Present flags
  //---------------------
  if (pMatchOptions.ePresentFlags = DXUTMT_PRESERVE_INPUT) then
  begin
    dwBestFlags := pDeviceSettingsIn.pp.Flags;
  end
  else if (pMatchOptions.ePresentFlags = DXUTMT_IGNORE_INPUT) then
  begin
    dwBestFlags := 0;
    if bestEnableAutoDepthStencil then
      dwBestFlags := D3DPRESENTFLAG_DISCARD_DEPTHSTENCIL;
  end
  else // if( pMatchOptions->ePresentFlags == DXUTMT_CLOSEST_TO_INPUT )
  begin
    dwBestFlags := pDeviceSettingsIn.pp.Flags;
    if bestEnableAutoDepthStencil then
      dwBestFlags := dwBestFlags or D3DPRESENTFLAG_DISCARD_DEPTHSTENCIL;
  end;

  //---------------------
  // Refresh rate
  //---------------------
  if pBestDeviceSettingsCombo.Windowed then
  begin
    // Must be 0 for windowed
    bestDisplayMode.RefreshRate := 0;
  end else
  begin
    if (pMatchOptions.eRefreshRate = DXUTMT_PRESERVE_INPUT) then
    begin
      bestDisplayMode.RefreshRate := pDeviceSettingsIn.pp.FullScreen_RefreshRateInHz;
    end else
    begin
      if (pMatchOptions.eRefreshRate = DXUTMT_CLOSEST_TO_INPUT) then
      begin
        refreshRateMatch := pDeviceSettingsIn.pp.FullScreen_RefreshRateInHz;
      end
      else // if( pMatchOptions->eRefreshRate == DXUTMT_IGNORE_INPUT )
      begin
        refreshRateMatch := adapterDesktopDisplayMode.RefreshRate;
      end;

      bestDisplayMode.RefreshRate := 0;

      if (refreshRateMatch <> 0) then 
      begin
        nBestRefreshRanking := 100000;
        pDisplayModeList := pBestDeviceSettingsCombo.pAdapterInfo.displayModeList;
        for iDisplayMode:= 0 to Length(pDisplayModeList) - 1 do
        begin
          displayMode := pDisplayModeList[iDisplayMode];
          if (displayMode.Format <> pBestDeviceSettingsCombo.AdapterFormat) or
             (displayMode.Height <> bestDisplayMode.Height) or
             (displayMode.Width <> bestDisplayMode.Width)
          then Continue; // Skip display modes that don't match

          // Find the delta between the current refresh rate and the optimal refresh rate
          nCurRanking := Abs(Integer(displayMode.RefreshRate) - Integer(refreshRateMatch));

          if (nCurRanking < nBestRefreshRanking) then
          begin
            bestDisplayMode.RefreshRate := displayMode.RefreshRate;
            nBestRefreshRanking := nCurRanking;

            // Stop if perfect match found
            if (nBestRefreshRanking = 0) then Break;
          end;
        end;
      end;
    end;
  end;

  //---------------------
  // Present interval
  //---------------------
  if (pMatchOptions.ePresentInterval = DXUTMT_PRESERVE_INPUT) then
  begin
    bestPresentInterval := pDeviceSettingsIn.pp.PresentationInterval;
  end
  else if (pMatchOptions.ePresentInterval = DXUTMT_IGNORE_INPUT) then
  begin
    // For windowed and fullscreen, default to D3DPRESENT_INTERVAL_DEFAULT
    // which will wait for the vertical retrace period to prevent tearing.
    // For benchmarking, use D3DPRESENT_INTERVAL_DEFAULT  which will
    // will wait not for the vertical retrace period but may introduce tearing.
    bestPresentInterval := D3DPRESENT_INTERVAL_DEFAULT;
  end
  else // if( pMatchOptions->ePresentInterval == DXUTMT_CLOSEST_TO_INPUT )
  begin
    // if (pBestDeviceSettingsCombo.presentIntervalList.Contains( pDeviceSettingsIn.pp.PresentationInterval ) )
    if DynArrayContains(pBestDeviceSettingsCombo.presentIntervalList,
                        pDeviceSettingsIn.pp.PresentationInterval,
                        SizeOf(pDeviceSettingsIn.pp.PresentationInterval))
    then bestPresentInterval := pDeviceSettingsIn.pp.PresentationInterval
    else bestPresentInterval := D3DPRESENT_INTERVAL_DEFAULT;
  end;

  // Fill the device settings struct
  ZeroMemory(@pValidDeviceSettings, SizeOf(TDXUTDeviceSettings));
  pValidDeviceSettings.AdapterOrdinal                 := pBestDeviceSettingsCombo.AdapterOrdinal;
  pValidDeviceSettings.DeviceType                     := pBestDeviceSettingsCombo.DeviceType;
  pValidDeviceSettings.AdapterFormat                  := pBestDeviceSettingsCombo.AdapterFormat;
  pValidDeviceSettings.BehaviorFlags                  := dwBestBehaviorFlags;
  pValidDeviceSettings.pp.BackBufferWidth             := bestDisplayMode.Width;
  pValidDeviceSettings.pp.BackBufferHeight            := bestDisplayMode.Height;
  pValidDeviceSettings.pp.BackBufferFormat            := pBestDeviceSettingsCombo.BackBufferFormat;
  pValidDeviceSettings.pp.BackBufferCount             := bestBackBufferCount;
  pValidDeviceSettings.pp.MultiSampleType             := bestMultiSampleType;
  pValidDeviceSettings.pp.MultiSampleQuality          := bestMultiSampleQuality;
  pValidDeviceSettings.pp.SwapEffect                  := bestSwapEffect;
  pValidDeviceSettings.pp.hDeviceWindow               := HWND(IfThen(pBestDeviceSettingsCombo.Windowed, DXUTGetHWNDDeviceWindowed, DXUTGetHWNDDeviceFullScreen));
  pValidDeviceSettings.pp.Windowed                    := pBestDeviceSettingsCombo.Windowed;
  pValidDeviceSettings.pp.EnableAutoDepthStencil      := bestEnableAutoDepthStencil;  
  pValidDeviceSettings.pp.AutoDepthStencilFormat      := bestDepthStencilFormat;
  pValidDeviceSettings.pp.Flags                       := dwBestFlags;                   
  pValidDeviceSettings.pp.FullScreen_RefreshRateInHz  := bestDisplayMode.RefreshRate;
  pValidDeviceSettings.pp.PresentationInterval        := bestPresentInterval;
end;


//--------------------------------------------------------------------------------------
// Internal helper function to find the closest allowed display mode to the optimal 
//--------------------------------------------------------------------------------------
function DXUTFindValidResolution(const pBestDeviceSettingsCombo: TD3DEnumDeviceSettingsCombo; displayModeIn: TD3DDisplayMode; out pBestDisplayMode: TD3DDisplayMode): HRESULT;
var
  bestDisplayMode: TD3DDisplayMode;
  iDisplayMode: Integer;
  nBestRanking: Integer;
  nCurRanking: Integer;
  pDisplayModeList: TD3DDisplayModeArray;
  displayMode: TD3DDisplayMode;
begin
  pDisplayModeList:= nil;
  ZeroMemory(@bestDisplayMode, SizeOf(TD3DDisplayMode));

  if pBestDeviceSettingsCombo.Windowed then
  begin
    // In windowed mode, all resolutions are valid but restritions still apply
    // on the size of the window.  See DXUTChangeDevice() for details
    pBestDisplayMode := displayModeIn;
  end else
  begin
    nBestRanking := 100000;
    pDisplayModeList := pBestDeviceSettingsCombo.pAdapterInfo.displayModeList;
    for iDisplayMode:= 0 to Length(pDisplayModeList) - 1 do
    begin
      displayMode := pDisplayModeList[iDisplayMode];

      // Skip display modes that don't match the combo's adapter format
      if (displayMode.Format <> pBestDeviceSettingsCombo.AdapterFormat)
      then Continue;

      // Find the delta between the current width/height and the optimal width/height
      nCurRanking := Abs(Integer(displayMode.Width) - Integer(displayModeIn.Width)) +
                     Abs(Integer(displayMode.Height)- Integer(displayModeIn.Height));

      if (nCurRanking < nBestRanking) then
      begin
        bestDisplayMode := displayMode;
        nBestRanking := nCurRanking;

        // Stop if perfect match found
        if (nBestRanking = 0) then Break;
      end;
    end;

    if (bestDisplayMode.Width = 0) then
    begin
      pBestDisplayMode := displayModeIn;
      Result:= E_FAIL; // No valid display modes found
      Exit;
    end;

    pBestDisplayMode := bestDisplayMode;
  end;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Internal helper function to return the adapter format from the first device settings 
// combo that matches the passed adapter ordinal, device type, backbuffer format, and windowed.  
//--------------------------------------------------------------------------------------
function DXUTFindAdapterFormat(AdapterOrdinal: LongWord; DeviceType: TD3DDevType; BackBufferFormat: TD3DFormat; Windowed: Boolean; out pAdapterFormat: TD3DFormat): HRESULT; 
var
  pd3dEnum: CD3DEnumeration;
  pDeviceInfo: CD3DEnumDeviceInfo;
  iDeviceCombo: Integer;
  pDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;
begin
  pd3dEnum := DXUTPrepareEnumerationObject;
  pDeviceInfo := pd3dEnum.GetDeviceInfo(AdapterOrdinal, DeviceType);
  if (pDeviceInfo <> nil) then
  begin
    for iDeviceCombo:= 0 to Length(pDeviceInfo.deviceSettingsComboList) - 1 do
    begin
      pDeviceSettingsCombo := pDeviceInfo.deviceSettingsComboList[iDeviceCombo];
      if (pDeviceSettingsCombo.BackBufferFormat = BackBufferFormat) and
         (pDeviceSettingsCombo.Windowed = Windowed) then
      begin
        // Return the adapter format from the first match
        pAdapterFormat := pDeviceSettingsCombo.AdapterFormat;
        Result:= S_OK;
        Exit;
      end;
    end;
  end;

  pAdapterFormat := BackBufferFormat;
  Result:= E_FAIL;
end;

{$IFDEF FPC}

type
  tagMONITORINFOW = record
    cbSize: DWORD;
    rcMonitor: TRect;
    rcWork: TRect;
    dwFlags: DWORD;
  end;
  PMonitorInfoW = ^tagMONITORINFOW;
  TMonitorInfoW = tagMONITORINFOW;

const
  MONITOR_DEFAULTTONULL = $0;

{$ENDIF}

type
  EXECUTION_STATE = DWORD;
const
  ES_SYSTEM_REQUIRED  = DWORD($00000001);
  ES_DISPLAY_REQUIRED = DWORD($00000002);
  ES_USER_PRESENT     = DWORD($00000004);
  ES_CONTINUOUS       = DWORD($80000000);

function SetThreadExecutionState(esFlags: EXECUTION_STATE): EXECUTION_STATE; stdcall; external kernel32;


//--------------------------------------------------------------------------------------
// Change to a Direct3D device created from the device settings or passed in.
// The framework will only reset if the device is similar to the previous device
// otherwise it will cleanup the previous device (if there is one) and recreate the
// scene using the app's device callbacks.
//--------------------------------------------------------------------------------------
function DXUTChangeDevice(pNewDeviceSettings: PDXUTDeviceSettings; pd3dDeviceFromApp: IDirect3DDevice9; bForceRecreate: Boolean; bClipWindowToSingleAdapter: Boolean): HRESULT;
var
  pOldDeviceSettings, pNewDeviceSettingsOnHeap: PDXUTDeviceSettings;
  pCallbackModifyDeviceSettings: PDXUTCallbackModifyDeviceSettings;
  caps: TD3DCaps9;
  pD3D: IDirect3D9;
  bContinue: Boolean;
  rcWindowClient, rcWindowBounds: TRect;
  pd3dDevice: IDirect3DDevice9;
  pd3dEnum: CD3DEnumeration;
  pAdapterInfo: CD3DEnumAdapterInfo;
  hAdapterMonitor: HMONITOR;
  ptClient: TPoint;
  wp: TWindowPlacement;
  bKeepCurrentWindowSize: Boolean;
  pwp: PWindowPlacement;
  wpFullscreen: TWindowPlacement;
  dwStyle: DWORD;
  hMenu: Windows.HMENU;
  pd3dCaps: PD3DCaps9;
  bNeedToResize: Boolean;
  nClientWidth, nClientHeight: LongWord;
  rcClient: TRect;
  rcFrame: TRect;
  nFrameWidth, nFrameHeight: Longint;
  miAdapter: TMonitorInfo;
  nMonitorWidth, nMonitorHeight: Integer;
  hWindowMonitor: HMONITOR;
  miWindow: TMonitorInfo;
  nAdapterMonitorWidth, nAdapterMonitorHeight: Integer;
  rcWindow, rcResizedWindow: TRect;
  nWindowOffsetX, nWindowOffsetY, nWindowWidth, nWindowHeight: Integer;
  cx, cy: Integer;
  deviceSettings: TDXUTDeviceSettings;
  bMonitorChanged: Boolean;
  bIsTopmost: Boolean;
  hWndInsertAfter: HWND;
begin
  pOldDeviceSettings := GetDXUTState.CurrentDeviceSettings;

  if (DXUTGetD3DObject = nil) then
  begin
    Result:= S_FALSE;
    Exit;
  end;

  // Make a copy of the pNewDeviceSettings on the heap
  try
    New(pNewDeviceSettingsOnHeap);
  except
    Result:= E_OUTOFMEMORY;
    Exit;
  end;
  Move(pNewDeviceSettings^, pNewDeviceSettingsOnHeap^, SizeOf(TDXUTDeviceSettings));
  pNewDeviceSettings := pNewDeviceSettingsOnHeap;

  // If the ModifyDeviceSettings callback is non-NULL, then call it to let the app 
  // change the settings or reject the device change by returning false.
  pCallbackModifyDeviceSettings := GetDXUTState.ModifyDeviceSettingsFunc;
  if Assigned(pCallbackModifyDeviceSettings) then 
  begin
    pD3D := DXUTGetD3DObject;
    pD3D.GetDeviceCaps(pNewDeviceSettings.AdapterOrdinal, pNewDeviceSettings.DeviceType, caps);

    bContinue := pCallbackModifyDeviceSettings(pNewDeviceSettings^, caps, GetDXUTState.ModifyDeviceSettingsFuncUserContext);
    if not bContinue then
    begin
      // The app rejected the device change by returning false, so just use the current device if there is one.
      if (pOldDeviceSettings = nil) then DXUTDisplayErrorMessage(DXUTERR_NOCOMPATIBLEDEVICES);
      Dispose(pNewDeviceSettings);
      Result:= E_ABORT;
      Exit;
    end;
    if (GetDXUTState.D3D = nil) then 
    begin
      Dispose(pNewDeviceSettings);
      Result:= S_False;
      Exit;
    end;
  end;

  GetDXUTState.CurrentDeviceSettings := pNewDeviceSettings;

  DXUTPause(True, True);

  // When a WM_SIZE message is received, it calls DXUTCheckForWindowSizeChange().
  // A WM_SIZE message might be sent when adjusting the window, so tell
  // DXUTCheckForWindowSizeChange() to ignore size changes temporarily
  GetDXUTState.IgnoreSizeChange := True;

  // Update thread safety on/off depending on Direct3D device's thread safety
  g_bThreadSafe := ((pNewDeviceSettings.BehaviorFlags and D3DCREATE_MULTITHREADED) <> 0);

  // Only apply the cmd line overrides if this is the first device created
  // and DXUTSetDevice() isn't used
  if (pd3dDeviceFromApp = nil) and (pOldDeviceSettings = nil) then
  begin
    // Updates the device settings struct based on the cmd line args.
    // Warning: if the device doesn't support these new settings then CreateDevice() will fail.
    DXUTUpdateDeviceSettingsWithOverrides(pNewDeviceSettings^);
  end;

  // Take note if the backbuffer width & height are 0 now as they will change after pd3dDevice->Reset()
  bKeepCurrentWindowSize := False;
  if (pNewDeviceSettings.pp.BackBufferWidth = 0) and (pNewDeviceSettings.pp.BackBufferHeight = 0)
  then bKeepCurrentWindowSize := True;

  //////////////////////////
  // Before reset
  /////////////////////////
  if pNewDeviceSettings.pp.Windowed then
  begin
    // Going to windowed mode

    if Assigned(pOldDeviceSettings) and not pOldDeviceSettings.pp.Windowed then
    begin
      // Going from fullscreen -> windowed
      GetDXUTState.SetFullScreenBackBufferWidthAtModeChange(pOldDeviceSettings.pp.BackBufferWidth);
      GetDXUTState.SetFullScreenBackBufferHeightAtModeChange(pOldDeviceSettings.pp.BackBufferHeight);

      // Restore windowed mode style
      SetWindowLong(DXUTGetHWNDDeviceWindowed, GWL_STYLE, GetDXUTState.GetWindowedStyleAtModeChange);
    end;

    // If different device windows are used for windowed mode and fullscreen mode,
    // hide the fullscreen window so that it doesn't obscure the screen.
    if (DXUTGetHWNDDeviceFullScreen <> DXUTGetHWNDDeviceWindowed)
    then ShowWindow(DXUTGetHWNDDeviceFullScreen, SW_HIDE);

    // If using the same window for windowed and fullscreen mode, reattach menu if one exists
    if (DXUTGetHWNDDeviceFullScreen = DXUTGetHWNDDeviceWindowed) then
    begin
      if (GetDXUTState.Menu <> 0)
      then SetMenu(DXUTGetHWNDDeviceWindowed, GetDXUTState.GetMenu);
    end;
  end else
  begin
    // Going to fullscreen mode

    if (pOldDeviceSettings = nil) or (Assigned(pOldDeviceSettings) and pOldDeviceSettings.pp.Windowed) then
    begin
      // Transistioning to full screen mode from a standard window so
      // save current window position/size/style now in case the user toggles to windowed mode later
      pwp := GetDXUTState.GetWindowedPlacement;
      ZeroMemory(pwp, SizeOf(TWindowPlacement));
      pwp.length := SizeOf(TWindowPlacement);
      {$IFDEF FPC}
      GetWindowPlacement(DXUTGetHWNDDeviceWindowed, pwp^);
      {$ELSE}
      GetWindowPlacement(DXUTGetHWNDDeviceWindowed, pwp);
      {$ENDIF}
      bIsTopmost := GetWindowLong(DXUTGetHWNDDeviceWindowed, GWL_EXSTYLE) and WS_EX_TOPMOST <> 0;
      GetDXUTState.SetTopmostWhileWindowed(bIsTopmost);
      dwStyle := GetWindowLong(DXUTGetHWNDDeviceWindowed, GWL_STYLE);
      dwStyle := dwStyle and not WS_MAXIMIZE and not WS_MINIMIZE; // remove minimize/maximize style
      GetDXUTState.SetWindowedStyleAtModeChange(dwStyle);
      if Assigned(pOldDeviceSettings) then
      begin
        GetDXUTState.SetWindowBackBufferWidthAtModeChange(pOldDeviceSettings.pp.BackBufferWidth);
        GetDXUTState.SetWindowBackBufferHeightAtModeChange(pOldDeviceSettings.pp.BackBufferHeight);
      end;
    end;

    // Hide the window to avoid animation of blank windows
    ShowWindow(DXUTGetHWNDDeviceFullScreen, SW_HIDE);

    // Set FS window style
    SetWindowLong(DXUTGetHWNDDeviceFullScreen, GWL_STYLE, Integer(WS_POPUP or WS_SYSMENU));

    // If using the same window for windowed and fullscreen mode, save and remove menu
    if (DXUTGetHWNDDeviceFullScreen = DXUTGetHWNDDeviceWindowed) then
    begin
      hMenu := GetMenu(DXUTGetHWNDDeviceFullScreen);
      GetDXUTState.SetMenu(hMenu);
      SetMenu(DXUTGetHWNDDeviceFullScreen, 0);
    end;

    ZeroMemory(@wpFullscreen, SizeOf(TWindowPlacement));
    wpFullscreen.length := SizeOf(TWindowPlacement);
    {$IFDEF FPC}
    GetWindowPlacement(DXUTGetHWNDDeviceFullScreen, wpFullscreen);
    {$ELSE}
    GetWindowPlacement(DXUTGetHWNDDeviceFullScreen, @wpFullscreen);
    {$ENDIF}
    if ((wpFullscreen.flags and WPF_RESTORETOMAXIMIZED) <> 0) then
    begin
      // Restore the window to normal if the window was maximized then minimized.  This causes the
      // WPF_RESTORETOMAXIMIZED flag to be set which will cause SW_RESTORE to restore the
      // window from minimized to maxmized which isn't what we want
      with wpFullscreen do flags := flags and not WPF_RESTORETOMAXIMIZED;
      wpFullscreen.showCmd := SW_RESTORE;
      {$IFDEF FPC}
      SetWindowPlacement(DXUTGetHWNDDeviceFullScreen, wpFullscreen);
      {$ELSE}
      SetWindowPlacement(DXUTGetHWNDDeviceFullScreen, @wpFullscreen);
      {$ENDIF}
    end;
  end;

  // If AdapterOrdinal and DeviceType are the same, we can just do a Reset().
  // If they've changed, we need to do a complete device tear down/rebuild.
  // Also only allow a reset if pd3dDevice is the same as the current device
  if not bForceRecreate and
     ((pd3dDeviceFromApp = nil) or (pd3dDeviceFromApp = DXUTGetD3DDevice)) and
     (DXUTGetD3DDevice <> nil) and
     (pOldDeviceSettings <> nil) and
     (pOldDeviceSettings.AdapterOrdinal = pNewDeviceSettings.AdapterOrdinal) and
     (pOldDeviceSettings.DeviceType = pNewDeviceSettings.DeviceType) and
     (pOldDeviceSettings.BehaviorFlags = pNewDeviceSettings.BehaviorFlags) then
  begin
    // Reset the Direct3D device and call the app's device callbacks
    Result := DXUTReset3DEnvironment;
    if FAILED(Result) then
    begin
      if (Result = D3DERR_DEVICELOST) then
      begin
        // The device is lost, just mark it as so and continue on with
        // capturing the state and resizing the window/etc.
        GetDXUTState.DeviceLost:= True;
      end
      else if (Result = DXUTERR_RESETTINGDEVICEOBJECTS) or
              (Result = DXUTERR_MEDIANOTFOUND) then
      begin
        // Something bad happened in the app callbacks
        Dispose(pOldDeviceSettings);
        DXUTDisplayErrorMessage(Result);
        DXUTShutdown;
        Exit; // Result:= hr;
      end
      else // DXUTERR_RESETTINGDEVICE
      begin
        // Reset failed and the device wasn't lost and it wasn't the apps fault,
        // so recreate the device to try to recover
        //todo: Fill bug report: should SAFE_DELETE( pNewDeviceSettings ); and Pause (False)
        GetDXUTState.CurrentDeviceSettings := pOldDeviceSettings;
        if FAILED(DXUTChangeDevice(pNewDeviceSettings, pd3dDeviceFromApp, True, bClipWindowToSingleAdapter)) then
        begin
          // If that fails, then shutdown
          DXUTShutdown;
          Result:= DXUTERR_CREATINGDEVICE;
        end else
        begin
          DXUTPause(False, False);
          Result:= S_OK;
        end;
          
        Dispose(pNewDeviceSettings);
        Exit;
      end;
    end;
  end else
  begin
    // Cleanup if not first device created
    if (pOldDeviceSettings <> nil) then DXUTCleanup3DEnvironment(False);

    // Create the D3D device and call the app's device callbacks
    Result := DXUTCreate3DEnvironment(pd3dDeviceFromApp);
    if FAILED(Result) then
    begin
      Dispose(pOldDeviceSettings);
      DXUTCleanup3DEnvironment;
      DXUTDisplayErrorMessage(Result);
      DXUTPause(False, False);
      GetDXUTState.SetIgnoreSizeChange(False);
      Exit;
    end;
  end;

  // Enable/disable StickKeys shortcut, ToggleKeys shortcut, FilterKeys shortcut, and Windows key
  // to prevent accidental task switching
  if pNewDeviceSettings.pp.Windowed
  then DXUTAllowShortcutKeys(GetDXUTState.GetAllowShortcutKeysWhenWindowed)
  else DXUTAllowShortcutKeys(GetDXUTState.GetAllowShortcutKeysWhenFullscreen);

  pD3D := DXUTGetD3DObject;
  hAdapterMonitor := pD3D.GetAdapterMonitor(pNewDeviceSettings.AdapterOrdinal);
  GetDXUTState.SetAdapterMonitor(hAdapterMonitor);

  // Update the device stats text
  DXUTUpdateStaticFrameStats;

  if (pOldDeviceSettings <> nil) and not pOldDeviceSettings.pp.Windowed and pNewDeviceSettings.pp.Windowed then
  begin
    // Going from fullscreen -> windowed

    // Restore the show state, and positions/size of the window to what it was
    // It is important to adjust the window size
    // after resetting the device rather than beforehand to ensure
    // that the monitor resolution is correct and does not limit the size of the new window.
    pwp := GetDXUTState.GetWindowedPlacement;
    {$IFDEF FPC}
    SetWindowPlacement(DXUTGetHWNDDeviceWindowed, pwp^);
    {$ELSE}
    SetWindowPlacement(DXUTGetHWNDDeviceWindowed, pwp);
    {$ENDIF}

    // Also restore the z-order of window to previous state
    if GetDXUTState.GetTopmostWhileWindowed then hWndInsertAfter := HWND_TOPMOST else hWndInsertAfter := HWND_NOTOPMOST;
    SetWindowPos(DXUTGetHWNDDeviceWindowed, hWndInsertAfter, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOREDRAW or SWP_NOSIZE);
  end;

  // Check to see if the window needs to be resized.  
  // Handle cases where the window is minimized and maxmimized as well.
  bNeedToResize := False;
  if pNewDeviceSettings.pp.Windowed and // only resize if in windowed mode
     not bKeepCurrentWindowSize then    // only resize if pp.BackbufferWidth/Height were not 0
  begin
    if IsIconic(DXUTGetHWNDDeviceWindowed) then
    begin
      // Window is currently minimized. To tell if it needs to resize,
      // get the client rect of window when its restored the
      // hard way using GetWindowPlacement()
      ZeroMemory(@wp, SizeOf(TWindowPlacement));
      wp.length := SizeOf(TWindowPlacement);
      {$IFDEF FPC}
      GetWindowPlacement(DXUTGetHWNDDeviceWindowed, wp);
      {$ELSE}
      GetWindowPlacement(DXUTGetHWNDDeviceWindowed, @wp);
      {$ENDIF}

      if (wp.flags and WPF_RESTORETOMAXIMIZED <> 0) and (wp.showCmd = SW_SHOWMINIMIZED) then
      begin
        // WPF_RESTORETOMAXIMIZED means that when the window is restored it will
        // be maximized.  So maximize the window temporarily to get the client rect
        // when the window is maximized.  GetSystemMetrics( SM_CXMAXIMIZED ) will give this
        // information if the window is on the primary but this will work on multimon.
        ShowWindow(DXUTGetHWNDDeviceWindowed, SW_RESTORE);
        GetClientRect(DXUTGetHWNDDeviceWindowed, rcClient);
        nClientWidth  := (rcClient.right - rcClient.left);
        nClientHeight := (rcClient.bottom - rcClient.top);
        ShowWindow(DXUTGetHWNDDeviceWindowed, SW_MINIMIZE);
      end else
      begin
        // Use wp.rcNormalPosition to get the client rect, but wp.rcNormalPosition
        // includes the window frame so subtract it
        rcFrame := Rect(0, 0, 0, 0);
        AdjustWindowRect(rcFrame, GetDXUTState.GetWindowedStyleAtModeChange, GetDXUTState.Menu <> 0);
        nFrameWidth := rcFrame.right - rcFrame.left;
        nFrameHeight := rcFrame.bottom - rcFrame.top;
        nClientWidth  := (wp.rcNormalPosition.right - wp.rcNormalPosition.left - nFrameWidth);
        nClientHeight := (wp.rcNormalPosition.bottom - wp.rcNormalPosition.top - nFrameHeight);
      end;
    end else
    begin
      // Window is restored or maximized so just get its client rect
      GetClientRect(DXUTGetHWNDDeviceWindowed, rcClient);
      nClientWidth  := (rcClient.right - rcClient.left);
      nClientHeight := (rcClient.bottom - rcClient.top);
    end;

    // Now that we know the client rect, compare it against the back buffer size
    // to see if the client rect is already the right size
    if (nClientWidth  <> pNewDeviceSettings.pp.BackBufferWidth) or
       (nClientHeight <> pNewDeviceSettings.pp.BackBufferHeight) then
    begin
      bNeedToResize := True;
    end;

    if bClipWindowToSingleAdapter and not IsIconic(DXUTGetHWNDDeviceWindowed) then
    begin
      // Get the rect of the monitor attached to the adapter
      miAdapter.cbSize := SizeOf(TMonitorInfo);
      hAdapterMonitor := DXUTGetD3DObject.GetAdapterMonitor(pNewDeviceSettings.AdapterOrdinal);
      DXUTGetMonitorInfo(hAdapterMonitor, @miAdapter);
      hWindowMonitor := DXUTMonitorFromWindow(DXUTGetHWND, MONITOR_DEFAULTTOPRIMARY);

      // Get the rect of the window
      GetWindowRect(DXUTGetHWNDDeviceWindowed, rcWindow);

      // Check if the window rect is fully inside the adapter's vitural screen rect
      if (rcWindow.left   < miAdapter.rcWork.left)   or
         (rcWindow.right  > miAdapter.rcWork.right)  or
         (rcWindow.top    < miAdapter.rcWork.top)    or
         (rcWindow.bottom > miAdapter.rcWork.bottom) then
      begin
        if (hWindowMonitor = hAdapterMonitor) and IsZoomed(DXUTGetHWNDDeviceWindowed) then
        begin
          // If the window is maximized and on the same monitor as the adapter, then
          // no need to clip to single adapter as the window is already clipped
          // even though the rcWindow rect is outside of the miAdapter.rcWork
        end else
        begin
          bNeedToResize := True;
        end;
      end;
    end;
  end;

  // Only resize window if needed
  if bNeedToResize then
  begin
    // Need to resize, so if window is maximized or minimized then restore the window
    if IsIconic(DXUTGetHWNDDeviceWindowed) then ShowWindow(DXUTGetHWNDDeviceWindowed, SW_RESTORE);
    if IsZoomed(DXUTGetHWNDDeviceWindowed) then // doing the IsIconic() check first also handles the WPF_RESTORETOMAXIMIZED case
      ShowWindow(DXUTGetHWNDDeviceWindowed, SW_RESTORE);

    if bClipWindowToSingleAdapter then
    begin
      // Get the rect of the monitor attached to the adapter
      miAdapter.cbSize := SizeOf(TMonitorInfo);
      DXUTGetMonitorInfo(DXUTGetD3DObject.GetAdapterMonitor(pNewDeviceSettings.AdapterOrdinal), @miAdapter);

      // Get the rect of the monitor attached to the window
      miWindow.cbSize := SizeOf(TMonitorInfo);
      DXUTGetMonitorInfo(DXUTMonitorFromWindow(DXUTGetHWND, MONITOR_DEFAULTTOPRIMARY), @miWindow);

      // Do something reasonable if the BackBuffer size is greater than the monitor size
      nAdapterMonitorWidth := miAdapter.rcWork.right - miAdapter.rcWork.left;
      nAdapterMonitorHeight := miAdapter.rcWork.bottom - miAdapter.rcWork.top;

      nClientWidth := pNewDeviceSettings.pp.BackBufferWidth;
      nClientHeight := pNewDeviceSettings.pp.BackBufferHeight;

      // Get the rect of the window
      GetWindowRect(DXUTGetHWNDDeviceWindowed, rcWindow);

      // Make a window rect with a client rect that is the same size as the backbuffer
      rcResizedWindow.left := 0;
      rcResizedWindow.right := nClientWidth;
      rcResizedWindow.top := 0;
      rcResizedWindow.bottom := nClientHeight;
      AdjustWindowRect(rcResizedWindow, GetWindowLong(DXUTGetHWNDDeviceWindowed, GWL_STYLE), GetDXUTState.Menu <> 0);

      nWindowWidth := rcResizedWindow.right - rcResizedWindow.left;
      nWindowHeight := rcResizedWindow.bottom - rcResizedWindow.top;

      if (nWindowWidth > nAdapterMonitorWidth) then nWindowWidth := (nAdapterMonitorWidth - 0);
      if (nWindowHeight > nAdapterMonitorHeight) then nWindowHeight := (nAdapterMonitorHeight - 0);

      if (rcResizedWindow.left < miAdapter.rcWork.left) or
         (rcResizedWindow.top < miAdapter.rcWork.top) or
         (rcResizedWindow.right > miAdapter.rcWork.right) or
         (rcResizedWindow.bottom > miAdapter.rcWork.bottom) then
      begin
        nWindowOffsetX := (nAdapterMonitorWidth - nWindowWidth) div 2;
        nWindowOffsetY := (nAdapterMonitorHeight - nWindowHeight) div 2;

        rcResizedWindow.left := miAdapter.rcWork.left + nWindowOffsetX;
        rcResizedWindow.top := miAdapter.rcWork.top + nWindowOffsetY;
        rcResizedWindow.right := miAdapter.rcWork.left + nWindowOffsetX + nWindowWidth;
        rcResizedWindow.bottom := miAdapter.rcWork.top + nWindowOffsetY + nWindowHeight;
      end;

      // Resize the window.  It is important to adjust the window size
      // after resetting the device rather than beforehand to ensure
      // that the monitor resolution is correct and does not limit the size of the new window.
      SetWindowPos(DXUTGetHWNDDeviceWindowed, 0, rcResizedWindow.left, rcResizedWindow.top, nWindowWidth, nWindowHeight, SWP_NOZORDER);
    end else
    begin
      // Make a window rect with a client rect that is the same size as the backbuffer
      rcWindow := Rect(0, 0, 0, 0);
      rcWindow.right := (pNewDeviceSettings.pp.BackBufferWidth);
      rcWindow.bottom := (pNewDeviceSettings.pp.BackBufferHeight);
      AdjustWindowRect(rcWindow, GetWindowLong(DXUTGetHWNDDeviceWindowed, GWL_STYLE), GetDXUTState.Menu <> 0);

      // Resize the window.  It is important to adjust the window size
      // after resetting the device rather than beforehand to ensure
      // that the monitor resolution is correct and does not limit the size of the new window.
      cx := (rcWindow.right - rcWindow.left);
      cy := (rcWindow.bottom - rcWindow.top);
      SetWindowPos(DXUTGetHWNDDeviceWindowed, 0, 0, 0, cx, cy, SWP_NOZORDER or SWP_NOMOVE);
    end;

    // Its possible that the new window size is not what we asked for.
    // No window can be sized larger than the desktop, so see if the Windows OS resized the
    // window to something smaller to fit on the desktop.  Also if WM_GETMINMAXINFO
    // will put a limit on the smallest/largest window size.
    GetClientRect(DXUTGetHWNDDeviceWindowed, rcClient);
    nClientWidth  := (rcClient.right - rcClient.left);
    nClientHeight := (rcClient.bottom - rcClient.top);
    if (nClientWidth  <> pNewDeviceSettings.pp.BackBufferWidth) or
       (nClientHeight <> pNewDeviceSettings.pp.BackBufferHeight) then
    begin
      // If its different, then resize the backbuffer again.  This time create a backbuffer that matches the
      // client rect of the current window w/o resizing the window.
      deviceSettings := DXUTGetDeviceSettings;
      deviceSettings.pp.BackBufferWidth  := 0;
      deviceSettings.pp.BackBufferHeight := 0;
      Result := DXUTChangeDevice(@deviceSettings, nil, False, bClipWindowToSingleAdapter);
      if FAILED(Result) then
      begin
        Dispose(pOldDeviceSettings);
        DXUTCleanup3DEnvironment;
        DXUTPause(False, False);
        GetDXUTState.SetIgnoreSizeChange(False);
        Exit;
      end;
    end;
  end;

  // Make the window visible
  if not IsWindowVisible(DXUTGetHWND) then ShowWindow(DXUTGetHWND, SW_SHOW);

  // Ensure that the display doesn't power down when fullscreen but does when windowed
  if not DXUTIsWindowed
  then SetThreadExecutionState(ES_DISPLAY_REQUIRED or ES_CONTINUOUS)
  else SetThreadExecutionState(ES_CONTINUOUS);

  Dispose(pOldDeviceSettings);
  GetDXUTState.IgnoreSizeChange:= False;
  DXUTPause(False, False);
  GetDXUTState.DeviceCreated:= True;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Low level keyboard hook to disable Windows key to prevent accidental task switching.
//--------------------------------------------------------------------------------------
function LowLevelKeyboardProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  bEatKeystroke: Boolean;
  p: PKBDLLHookStruct;
begin
  if (nCode < 0) or (nCode <> HC_ACTION) then // do not process message
  begin
    Result:= CallNextHookEx(GetDXUTState.GetKeyboardHook, nCode, wParam, lParam);
    Exit;
  end;

  bEatKeystroke := False;
  p := PKBDLLHookStruct(lParam);
  case wParam of
    WM_KEYDOWN, WM_KEYUP:
    begin
      bEatKeystroke := not GetDXUTState.GetAllowShortcutKeys and
                      ((p.vkCode = VK_LWIN) or (p.vkCode = VK_RWIN));
    end;
  end;

  if bEatKeystroke then Result:= 1
  else Result:= CallNextHookEx(GetDXUTState.GetKeyboardHook, nCode, wParam, lParam);
end;



//--------------------------------------------------------------------------------------
// Controls how DXUT behaves when fullscreen and windowed mode with regard to
// shortcut keys (Windows keys, StickyKeys shortcut, ToggleKeys shortcut, FilterKeys shortcut)
//--------------------------------------------------------------------------------------
procedure DXUTSetShortcutKeySettings(bAllowWhenFullscreen, bAllowWhenWindowed: Boolean);
begin
  GetDXUTState.SetAllowShortcutKeysWhenWindowed(bAllowWhenWindowed);
  GetDXUTState.SetAllowShortcutKeysWhenFullscreen(bAllowWhenFullscreen);

  // DXUTInit() records initial accessibility states so don't change them until then
  if GetDXUTState.DXUTInited then
  begin
    if DXUTIsWindowed
    then DXUTAllowShortcutKeys(GetDXUTState.GetAllowShortcutKeysWhenWindowed)
    else DXUTAllowShortcutKeys(GetDXUTState.GetAllowShortcutKeysWhenFullscreen);
  end;
end;


//--------------------------------------------------------------------------------------
// Enables/disables Windows keys, and disables or restores the StickyKeys/ToggleKeys/FilterKeys
// shortcut to help prevent accidental task switching
//--------------------------------------------------------------------------------------
procedure DXUTAllowShortcutKeys(bAllowKeys: Boolean);
var
  sk: TStickyKeys;
  tk: TToggleKeys;
  fk: TFilterKeys;
  OSVersionInfo: TOSVersionInfo;
  hKeyboardHook: HHOOK;
  skOff: TStickyKeys;
  tkOff: TToggleKeys;
  fkOff: TFilterKeys;
begin
  GetDXUTState.AllowShortcutKeys := bAllowKeys;

  if bAllowKeys then
  begin
    // Restore StickyKeys/etc to original state and enable Windows key
    sk := GetDXUTState.StartupStickyKeys;
    tk := GetDXUTState.StartupToggleKeys;
    fk := GetDXUTState.StartupFilterKeys;

    SystemParametersInfo(SPI_SETSTICKYKEYS, SizeOf(sk), @sk, 0);
    SystemParametersInfo(SPI_SETTOGGLEKEYS, SizeOf(tk), @tk, 0);
    SystemParametersInfo(SPI_SETFILTERKEYS, SizeOf(fk), @fk, 0);

    // Remove the keyboard hoook when it isn't needed to prevent any slow down of other apps
    if (GetDXUTState.KeyboardHook <> 0) then
    begin
      UnhookWindowsHookEx(GetDXUTState.KeyboardHook);
      GetDXUTState.KeyboardHook := 0;
    end;
  end else
  begin
    // Set low level keyboard hook if haven't already
    if (GetDXUTState.KeyboardHook = 0) then
    begin
      // Set the low-level hook procedure.  Only works on Windows 2000 and above
      OSVersionInfo.dwOSVersionInfoSize := SizeOf(OSVersionInfo);
      GetVersionEx(OSVersionInfo);
      if (OSVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT) and (OSVersionInfo.dwMajorVersion > 4) then
      begin
        hKeyboardHook := SetWindowsHookEx(WH_KEYBOARD_LL, @LowLevelKeyboardProc, GetModuleHandle(nil), 0);
        GetDXUTState.SetKeyboardHook(hKeyboardHook);
      end;
    end;

    // Disable StickyKeys/etc shortcuts but if the accessibility feature is on,
    // then leave the settings alone as its probably being usefully used

    skOff := GetDXUTState.StartupStickyKeys;
    if (skOff.dwFlags and SKF_STICKYKEYSON = 0) then
    begin
      // Disable the hotkey and the confirmation
      skOff.dwFlags := skOff.dwFlags and not SKF_HOTKEYACTIVE;
      skOff.dwFlags := skOff.dwFlags and not SKF_CONFIRMHOTKEY;

      SystemParametersInfo(SPI_SETSTICKYKEYS, SizeOf(skOff), @skOff, 0);
    end;

    tkOff := GetDXUTState.StartupToggleKeys;
    if (tkOff.dwFlags and TKF_TOGGLEKEYSON = 0) then 
    begin
      // Disable the hotkey and the confirmation
      tkOff.dwFlags := tkOff.dwFlags and not TKF_HOTKEYACTIVE;
      tkOff.dwFlags := tkOff.dwFlags and not TKF_CONFIRMHOTKEY;

      SystemParametersInfo(SPI_SETTOGGLEKEYS, SizeOf(tkOff), @tkOff, 0);
    end;

    fkOff := GetDXUTState.StartupFilterKeys;
    if (fkOff.dwFlags and FKF_FILTERKEYSON = 0) then
    begin
      // Disable the hotkey and the confirmation
      fkOff.dwFlags := fkOff.dwFlags and not FKF_HOTKEYACTIVE;
      fkOff.dwFlags := fkOff.dwFlags and not FKF_CONFIRMHOTKEY;

      SystemParametersInfo(SPI_SETFILTERKEYS, SizeOf(fkOff), @fkOff, 0);
    end;
  end;
end;


//--------------------------------------------------------------------------------------
// Updates the device settings struct based on the cmd line args.
//--------------------------------------------------------------------------------------
procedure DXUTUpdateDeviceSettingsWithOverrides(out pDeviceSettings: TDXUTDeviceSettings);
begin
  if (GetDXUTState.GetOverrideAdapterOrdinal <> -1) then
      pDeviceSettings.AdapterOrdinal := GetDXUTState.GetOverrideAdapterOrdinal;

  if GetDXUTState.OverrideFullScreen then pDeviceSettings.pp.Windowed := False;
  if GetDXUTState.OverrideWindowed then pDeviceSettings.pp.Windowed := True;

  if GetDXUTState.OverrideForceREF then
    pDeviceSettings.DeviceType := D3DDEVTYPE_REF
  else if GetDXUTState.OverrideForceHAL then
    pDeviceSettings.DeviceType := D3DDEVTYPE_HAL;

  if (GetDXUTState.OverrideWidth <> 0) then
      pDeviceSettings.pp.BackBufferWidth := GetDXUTState.OverrideWidth;
  if (GetDXUTState.OverrideHeight <> 0) then
      pDeviceSettings.pp.BackBufferHeight := GetDXUTState.OverrideHeight;

  if GetDXUTState.OverrideForcePureHWVP then
  begin
    pDeviceSettings.BehaviorFlags := pDeviceSettings.BehaviorFlags and not D3DCREATE_SOFTWARE_VERTEXPROCESSING;
    pDeviceSettings.BehaviorFlags := pDeviceSettings.BehaviorFlags or D3DCREATE_HARDWARE_VERTEXPROCESSING;
    pDeviceSettings.BehaviorFlags := pDeviceSettings.BehaviorFlags or D3DCREATE_PUREDEVICE;
  end
  else if GetDXUTState.OverrideForceHWVP then
  begin
    pDeviceSettings.BehaviorFlags := pDeviceSettings.BehaviorFlags and not D3DCREATE_SOFTWARE_VERTEXPROCESSING;
    pDeviceSettings.BehaviorFlags := pDeviceSettings.BehaviorFlags and not D3DCREATE_PUREDEVICE;
    pDeviceSettings.BehaviorFlags := pDeviceSettings.BehaviorFlags or D3DCREATE_HARDWARE_VERTEXPROCESSING;
  end
  else if GetDXUTState.OverrideForceSWVP then
  begin
    pDeviceSettings.BehaviorFlags := pDeviceSettings.BehaviorFlags and not D3DCREATE_HARDWARE_VERTEXPROCESSING;
    pDeviceSettings.BehaviorFlags := pDeviceSettings.BehaviorFlags and not D3DCREATE_PUREDEVICE;
    pDeviceSettings.BehaviorFlags := pDeviceSettings.BehaviorFlags or D3DCREATE_SOFTWARE_VERTEXPROCESSING;
  end;
end;


//--------------------------------------------------------------------------------------
// Creates the 3D environment
//--------------------------------------------------------------------------------------
function DXUTCreate3DEnvironment(const pd3dDeviceFromApp: IDirect3DDevice9): HRESULT;
var
  pd3dDevice: IDirect3DDevice9;
  pNewDeviceSettings: PDXUTDeviceSettings;
  pD3D: IDirect3D9;
  pd3dEnum: CD3DEnumeration;
  pAdapterInfo: CD3DEnumAdapterInfo;
  pbackBufferSurfaceDesc: PD3DSurfaceDesc;
  pCallbackDeviceCreated: PDXUTCallbackDeviceCreated;
  pCallbackDeviceReset: PDXUTCallbackDeviceReset;
  pd3dCaps: PD3DCaps9;
begin
  pNewDeviceSettings := GetDXUTState.GetCurrentDeviceSettings;

  // Only create a Direct3D device if one hasn't been supplied by the app
  if (pd3dDeviceFromApp = nil) then
  begin
    // Try to create the device with the chosen settings
    pD3D := DXUTGetD3DObject;
    Result := pD3D.CreateDevice(pNewDeviceSettings.AdapterOrdinal, pNewDeviceSettings.DeviceType,
                                DXUTGetHWNDFocus, pNewDeviceSettings.BehaviorFlags,
                                @pNewDeviceSettings.pp, pd3dDevice);
    if (Result = D3DERR_DEVICELOST) then
    begin
      GetDXUTState.DeviceLost := True;
      Result:= S_OK;
      Exit;
    end
    else if FAILED(Result) then
    begin
      DXUT_ERR('CreateDevice', Result);
      Result:= DXUTERR_CREATINGDEVICE;
      Exit;
    end;
  end else
  begin
    // pd3dDeviceFromApp.AddRef; // - done automagically in Delphi
    pd3dDevice := pd3dDeviceFromApp;
  end;

  GetDXUTState.SetD3DDevice(pd3dDevice);

  // If switching to REF, set the exit code to 11.  If switching to HAL and exit code was 11, then set it back to 0.
  if (pNewDeviceSettings.DeviceType = D3DDEVTYPE_REF) and (GetDXUTState.GetExitCode = 0)
  then GetDXUTState.SetExitCode(11)
  else if (pNewDeviceSettings.DeviceType = D3DDEVTYPE_HAL) and (GetDXUTState.GetExitCode = 11)
  then GetDXUTState.SetExitCode(0);

  // Update back buffer desc before calling app's device callbacks
  DXUTUpdateBackBufferDesc;

  // Setup cursor based on current settings (window/fullscreen mode, show cursor state, clip cursor state)
  DXUTSetupCursor;

  // Update GetDXUTState()'s copy of D3D caps
  pd3dCaps := GetDXUTState.Caps;
  DXUTGetD3DDevice.GetDeviceCaps(pd3dCaps^);

  // Update the device stats text
  pd3dEnum := DXUTPrepareEnumerationObject;
  pAdapterInfo := pd3dEnum.GetAdapterInfo(pNewDeviceSettings.AdapterOrdinal);
  DXUTUpdateDeviceStats(pNewDeviceSettings.DeviceType,
                        pNewDeviceSettings.BehaviorFlags,
                        pAdapterInfo.AdapterIdentifier);

  // Call the resource cache created function
  Result := DXUTGetGlobalResourceCache.OnCreateDevice(pd3dDevice);
  if FAILED(Result) then
  begin
    if (Result <> DXUTERR_MEDIANOTFOUND) then Result:= DXUTERR_CREATINGDEVICEOBJECTS;
    Result:= DXUT_ERR('OnCreateDevice', Result);
    Exit;
  end;

  // Call the app's device created callback if non-NULL
  pbackBufferSurfaceDesc := DXUTGetBackBufferSurfaceDesc;
  GetDXUTState.InsideDeviceCallback := True;
  pCallbackDeviceCreated := GetDXUTState.DeviceCreatedFunc;
  Result := S_OK;
  if (@pCallbackDeviceCreated <> nil) then
    Result := pCallbackDeviceCreated(DXUTGetD3DDevice, pbackBufferSurfaceDesc^, GetDXUTState.DeviceCreatedFuncUserContext);
  GetDXUTState.InsideDeviceCallback := False;
  if (DXUTGetD3DDevice = nil) then // Handle DXUTShutdown from inside callback
  begin
    Result:= E_FAIL;
    Exit;
  end;

  if FAILED(Result) then
  begin
    DXUT_ERR('DeviceCreated callback', Result);
    if (Result <> DXUTERR_MEDIANOTFOUND) then Result := DXUTERR_CREATINGDEVICEOBJECTS;
    Exit;
  end;
  GetDXUTState.DeviceObjectsCreated := True;

  // Call the resource cache device reset function
  Result := DXUTGetGlobalResourceCache.OnResetDevice(pd3dDevice);
  if FAILED(Result) then
  begin
    Result:= DXUT_ERR('OnResetDevice', DXUTERR_RESETTINGDEVICEOBJECTS);
    Exit;
  end;

  // Call the app's device reset callback if non-NULL
  GetDXUTState.InsideDeviceCallback := True;
  pCallbackDeviceReset := GetDXUTState.DeviceResetFunc;
  Result := S_OK;
  if (@pCallbackDeviceReset <> nil) then
    Result := pCallbackDeviceReset(DXUTGetD3DDevice, pbackBufferSurfaceDesc^, GetDXUTState.GetDeviceResetFuncUserContext);
  GetDXUTState.InsideDeviceCallback := False;
  if (DXUTGetD3DDevice = nil) then // Handle DXUTShutdown from inside callback
  begin
    Result:= E_FAIL;
    Exit;
  end;

  if FAILED(Result) then
  begin
    DXUT_ERR('DeviceReset callback', Result);
    if (Result <> DXUTERR_MEDIANOTFOUND) then Result := DXUTERR_RESETTINGDEVICEOBJECTS;
    Exit;
  end;
  GetDXUTState.DeviceObjectsReset := True;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Resets the 3D environment by:
//      - Calls the device lost callback 
//      - Resets the device
//      - Stores the back buffer description
//      - Sets up the full screen Direct3D cursor if requested
//      - Calls the device reset callback 
//--------------------------------------------------------------------------------------
function DXUTReset3DEnvironment: HRESULT;
var
  pd3dDevice: IDirect3DDevice9;
  pCallbackDeviceLost: PDXUTCallbackDeviceLost;
  pDeviceSettings: PDXUTDeviceSettings;
  pbackBufferSurfaceDesc: PD3DSurfaceDesc;
  pCallbackDeviceReset: PDXUTCallbackDeviceReset;
begin
  pd3dDevice := DXUTGetD3DDevice;     
  Assert(pd3dDevice <> nil);

  // Call the app's device lost callback
  if GetDXUTState.DeviceObjectsReset then
  begin
    GetDXUTState.InsideDeviceCallback:= True;

    pCallbackDeviceLost := GetDXUTState.DeviceLostFunc;
    if (@pCallbackDeviceLost <> nil) then pCallbackDeviceLost(GetDXUTState.DeviceLostFuncUserContext);
    GetDXUTState.DeviceObjectsReset:= False;
    GetDXUTState.InsideDeviceCallback:= False;

    // Call the resource cache device lost function
    DXUTGetGlobalResourceCache.OnLostDevice;
  end;

  // Reset the device
  pDeviceSettings := GetDXUTState.CurrentDeviceSettings;
  Result := pd3dDevice.Reset(pDeviceSettings.pp);
  if FAILED(Result) then
  begin
    if (Result = D3DERR_DEVICELOST)
    then Result := D3DERR_DEVICELOST // Reset could legitimately fail if the device is lost
    else Result := DXUT_ERR('Reset', DXUTERR_RESETTINGDEVICE);
    Exit;
  end;

  // Update back buffer desc before calling app's device callbacks
  DXUTUpdateBackBufferDesc;

  // Setup cursor based on current settings (window/fullscreen mode, show cursor state, clip cursor state)
  DXUTSetupCursor;

  Result := DXUTGetGlobalResourceCache.OnResetDevice(pd3dDevice);
  if FAILED(Result) then
  begin
    Result:= DXUT_ERR('OnResetDevice', DXUTERR_RESETTINGDEVICEOBJECTS);
    Exit;
  end;

  // Call the app's OnDeviceReset callback
  GetDXUTState.SetInsideDeviceCallback(True);
  pbackBufferSurfaceDesc := DXUTGetBackBufferSurfaceDesc;
  pCallbackDeviceReset := GetDXUTState.DeviceResetFunc;
  Result := S_OK;
  if (@pCallbackDeviceReset <> nil) then
    Result := pCallbackDeviceReset(pd3dDevice, pbackBufferSurfaceDesc^, GetDXUTState.GetDeviceResetFuncUserContext);
  GetDXUTState.SetInsideDeviceCallback(False);
  if FAILED(Result) then
  begin
    // If callback failed, cleanup
    DXUT_ERR('DeviceResetCallback', Result);
    if (Result <> DXUTERR_MEDIANOTFOUND) then Result:= DXUTERR_RESETTINGDEVICEOBJECTS;

    GetDXUTState.InsideDeviceCallback := True;

    pCallbackDeviceLost := GetDXUTState.DeviceLostFunc;
    if (@pCallbackDeviceLost <> nil) then pCallbackDeviceLost(GetDXUTState.DeviceLostFuncUserContext);

    GetDXUTState.InsideDeviceCallback := False;

    DXUTGetGlobalResourceCache.OnLostDevice;
    Exit;
  end;

  // Success
  GetDXUTState.DeviceObjectsReset := True;
  
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Pauses time or rendering.  Keeps a ref count so pausing can be layered
//--------------------------------------------------------------------------------------
procedure DXUTPause(bPauseTime, bPauseRendering: Boolean);
var
  nPauseTimeCount: Integer;
  nPauseRenderingCount: Integer;
begin
  nPauseTimeCount := GetDXUTState.PauseTimeCount;
  Inc(nPauseTimeCount, IfThen(bPauseTime, +1, -1));
  if (nPauseTimeCount < 0) then nPauseTimeCount := 0;
  GetDXUTState.SetPauseTimeCount(nPauseTimeCount);

  nPauseRenderingCount := GetDXUTState.GetPauseRenderingCount;
  Inc(nPauseRenderingCount, IfThen(bPauseRendering, +1, -1));
  if (nPauseRenderingCount < 0) then nPauseRenderingCount := 0;
  GetDXUTState.SetPauseRenderingCount(nPauseRenderingCount);

  if (nPauseTimeCount > 0) then 
  begin
    // Stop the scene from animating
    DXUTGetGlobalTimer.Stop;
  end else
  begin
    // Restart the timer
    DXUTGetGlobalTimer.Start;
  end;

  GetDXUTState.SetRenderingPaused(nPauseRenderingCount > 0);
  GetDXUTState.SetTimePaused(nPauseTimeCount > 0);
end;


//--------------------------------------------------------------------------------------
// Checks if the window client rect has changed and if it has, then reset the device
//--------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------
// Checks if the window client rect has changed and if it has, then reset the device
//--------------------------------------------------------------------------------------
procedure DXUTCheckForWindowSizeChange;
var
  rcCurrentClient: TRect;
  deviceSettings: TDXUTDeviceSettings;
begin
  // Skip the check for various reasons
  if GetDXUTState.IgnoreSizeChange or
     not GetDXUTState.DeviceCreated or
     not GetDXUTState.CurrentDeviceSettings.pp.Windowed
  then Exit;

  GetClientRect(DXUTGetHWND, rcCurrentClient);

  if (rcCurrentClient.right <> Integer(GetDXUTState.GetCurrentDeviceSettings.pp.BackBufferWidth)) or
     (rcCurrentClient.bottom <> Integer(GetDXUTState.GetCurrentDeviceSettings.pp.BackBufferHeight)) then
  begin
    // A new window size will require a new backbuffer size
    // size, so the device must be reset and the D3D structures updated accordingly.

    // Tell DXUTChangeDevice and D3D to size according to the HWND's client rect
    deviceSettings := DXUTGetDeviceSettings;
    deviceSettings.pp.BackBufferWidth  := 0;
    deviceSettings.pp.BackBufferHeight := 0;
    DXUTChangeDevice(@deviceSettings, nil, False, False);
  end;
end;


//--------------------------------------------------------------------------------------
// Handles app's message loop and rendering when idle.  If DXUTCreateDevice*() or DXUTSetDevice()
// has not already been called, it will call DXUTCreateWindow() with the default parameters.
//--------------------------------------------------------------------------------------
function DXUTMainLoop(hAccel: HACCEL = 0): HRESULT;
var
  hWnd: Windows.HWND;
  bGotMsg: LongBool;
  msg: TMsg;
begin
  // Not allowed to call this from inside the device callbacks or reenter
  if (GetDXUTState.InsideDeviceCallback or GetDXUTState.InsideMainloop) then
  begin
    if (GetDXUTState.ExitCode = 0) or (GetDXUTState.GetExitCode = 11) then GetDXUTState.ExitCode:= 1;
    Result:= DXUT_ERR_MSGBOX('DXUTMainLoop', E_FAIL);
    Exit;
  end;

  GetDXUTState.InsideMainloop:= True;

  // If DXUTCreateDevice*() or DXUTSetDevice() has not already been called,
  // then call DXUTCreateDevice() with the default parameters.
  if not GetDXUTState.DeviceCreated then
  begin
    if GetDXUTState.DeviceCreateCalled then
    begin
      if (GetDXUTState.ExitCode = 0) or (GetDXUTState.GetExitCode = 11) then GetDXUTState.ExitCode:= 1;
      Result:= E_FAIL; // DXUTCreateDevice() must first succeed for this function to succeed
      Exit;
    end;

    Result := DXUTCreateDevice;
    if FAILED(Result) then
    begin
      if (GetDXUTState.ExitCode = 0) or (GetDXUTState.GetExitCode = 11) then GetDXUTState.ExitCode:= 1;
      Exit;
    end;
  end;

  hWnd := DXUTGetHWND;

  // DXUTInit() must have been called and succeeded for this function to proceed
  // DXUTCreateWindow() or DXUTSetWindow() must have been called and succeeded for this function to proceed
  // DXUTCreateDevice() or DXUTCreateDeviceFromSettings() or DXUTSetDevice() must have been called and succeeded for this function to proceed
  if not GetDXUTState.DXUTInited or not GetDXUTState.WindowCreated or not GetDXUTState.DeviceCreated then
  begin
    if (GetDXUTState.ExitCode = 0) or (GetDXUTState.GetExitCode = 11) then GetDXUTState.ExitCode:= 1;
    Result:= DXUT_ERR_MSGBOX('DXUTMainLoop', E_FAIL);
    Exit;
  end;

  // Now we're ready to receive and process Windows messages.
  msg.message := WM_NULL;
  PeekMessage(msg, 0, 0, 0, PM_NOREMOVE);

  while (WM_QUIT <> msg.message) do
  begin
    // Use PeekMessage() so we can use idle time to render the scene.
    bGotMsg := PeekMessage(msg, 0, 0, 0, PM_REMOVE);

    if bGotMsg then
    begin
      // Translate and dispatch the message
      if (hAccel = 0) or (hWnd = 0) or
         (0 = TranslateAccelerator(hWnd, hAccel, msg)) then
      begin
        TranslateMessage(msg);
        DispatchMessage(msg);
      end;
    end else
    begin
      // Render a frame during idle time (no messages are waiting)
      DXUTRender3DEnvironment;
    end;
  end;

  // Cleanup the accelerator table
  if (hAccel <> 0) then
    DestroyAcceleratorTable(hAccel);

  GetDXUTState.InsideMainloop:= False;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Render the 3D environment by:
//      - Checking if the device is lost and trying to reset it if it is
//      - Get the elapsed time since the last frame
//      - Calling the app's framemove and render callback
//      - Calling Present()
//--------------------------------------------------------------------------------------
procedure DXUTRender3DEnvironment;
var
  pd3dDevice: IDirect3DDevice9;
  hr: HRESULT;
  adapterDesktopDisplayMode: TD3DDisplayMode;
  pD3D: IDirect3D9;
  pDeviceSettings: PDXUTDeviceSettings;
  matchOptions: TDXUTMatchOptions;
  deviceSettings: TDXUTDeviceSettings;
  fTime, fAbsTime: Double;
  fElapsedTime: Single;
  pCallbackFrameMove: PDXUTCallbackFrameMove;
  pCallbackFrameRender: PDXUTCallbackFrameRender;
  nFrame: Integer;
{$IFDEF DEBUG}
  rcClient: TRect;
{$ENDIF}
begin
  if GetDXUTState.DeviceLost or DXUTIsRenderingPaused or not DXUTIsActive then
  begin
    // Window is minimized or paused so yield CPU time to other processes
    Sleep(20);
  end;

  pd3dDevice := DXUTGetD3DDevice;
  if (pd3dDevice = nil) then
  begin
    if GetDXUTState.DeviceLost then
    begin
      deviceSettings := DXUTGetDeviceSettings;
      DXUTChangeDevice(@deviceSettings, nil, False, True);
    end;
    Exit;
  end;

  if GetDXUTState.DeviceLost and not GetDXUTState.RenderingPaused then
  begin
    // Test the cooperative level to see if it's okay to render
    hr:= pd3dDevice.TestCooperativeLevel;
    if FAILED(hr) then
    begin
      if (hr = D3DERR_DEVICELOST) then
      begin
        // The device has been lost but cannot be reset at this time.
        // So wait until it can be reset.
        Exit;
      end;

      // If we are windowed, read the desktop format and
      // ensure that the Direct3D device is using the same format
      // since the user could have changed the desktop bitdepth
      if DXUTIsWindowed then
      begin
        pD3D := DXUTGetD3DObject;
        pDeviceSettings := GetDXUTState.CurrentDeviceSettings;
        pD3D.GetAdapterDisplayMode(pDeviceSettings.AdapterOrdinal, adapterDesktopDisplayMode);
        if (pDeviceSettings.AdapterFormat <> adapterDesktopDisplayMode.Format) then
        begin
          matchOptions.eAdapterOrdinal     := DXUTMT_PRESERVE_INPUT;
          matchOptions.eDeviceType         := DXUTMT_PRESERVE_INPUT;
          matchOptions.eWindowed           := DXUTMT_PRESERVE_INPUT;
          matchOptions.eAdapterFormat      := DXUTMT_PRESERVE_INPUT;
          matchOptions.eVertexProcessing   := DXUTMT_CLOSEST_TO_INPUT;
          matchOptions.eResolution         := DXUTMT_CLOSEST_TO_INPUT;
          matchOptions.eBackBufferFormat   := DXUTMT_CLOSEST_TO_INPUT;
          matchOptions.eBackBufferCount    := DXUTMT_CLOSEST_TO_INPUT;
          matchOptions.eMultiSample        := DXUTMT_CLOSEST_TO_INPUT;
          matchOptions.eSwapEffect         := DXUTMT_CLOSEST_TO_INPUT;
          matchOptions.eDepthFormat        := DXUTMT_CLOSEST_TO_INPUT;
          matchOptions.eStencilFormat      := DXUTMT_CLOSEST_TO_INPUT;
          matchOptions.ePresentFlags       := DXUTMT_CLOSEST_TO_INPUT;
          matchOptions.eRefreshRate        := DXUTMT_CLOSEST_TO_INPUT;
          matchOptions.ePresentInterval    := DXUTMT_CLOSEST_TO_INPUT;

          deviceSettings := DXUTGetDeviceSettings;
          deviceSettings.AdapterFormat := adapterDesktopDisplayMode.Format;

          hr := DXUTFindValidDeviceSettings(deviceSettings, @deviceSettings, @matchOptions);
          if FAILED(hr) then // the call will fail if no valid devices were found
          begin
            DXUTDisplayErrorMessage(DXUTERR_NOCOMPATIBLEDEVICES);
            DXUTShutdown;
          end;

          // Change to a Direct3D device created from the new device settings.
          // If there is an existing device, then either reset or recreate the scene
          hr := DXUTChangeDevice(@deviceSettings, nil, False, False);
          if FAILED(hr) then
          begin
            // If this fails, try to go fullscreen and if this fails also shutdown.
            if FAILED(DXUTToggleFullScreen) then DXUTShutdown;
          end;

          Exit;
        end;
      end;

      // Try to reset the device
      hr := DXUTReset3DEnvironment;
      if FAILED(hr) then 
      begin
        if (D3DERR_DEVICELOST = hr) then
        begin
          // The device was lost again, so continue waiting until it can be reset.
          Exit;
        end
        else if (hr = DXUTERR_RESETTINGDEVICEOBJECTS) or
                (hr = DXUTERR_MEDIANOTFOUND) then
        begin
          DXUTDisplayErrorMessage(hr);
          DXUTShutdown;
          Exit;
        end else
        begin
          // Reset failed, but the device wasn't lost so something bad happened,
          // so recreate the device to try to recover
          pDeviceSettings := GetDXUTState.GetCurrentDeviceSettings;
          if FAILED(DXUTChangeDevice(pDeviceSettings, nil, True, False)) then
          begin
            DXUTShutdown;
            Exit;
          end;
        end;
      end;
    end;

    GetDXUTState.DeviceLost:= False;
  end;

  // Get the app's time, in seconds. Skip rendering if no time elapsed
  DXUTGetGlobalTimer.GetTimeValues(fTime, fAbsTime, fElapsedTime);

  // Store the time for the app
  if GetDXUTState.ConstantFrameTime then
  begin
    fElapsedTime := GetDXUTState.TimePerFrame;
    fTime        := DXUTGetTime + fElapsedTime;
  end;

  GetDXUTState.SetTime(fTime);
  GetDXUTState.SetAbsoluteTime(fAbsTime);
  GetDXUTState.SetElapsedTime(fElapsedTime);

  // Update the FPS stats
  DXUTUpdateFrameStats;

  DXUTHandleTimers;

  // Animate the scene by calling the app's frame move callback
  pCallbackFrameMove := GetDXUTState.FrameMoveFunc;
  if (@pCallbackFrameMove <> nil) then
  begin
    pCallbackFrameMove(pd3dDevice, fTime, fElapsedTime, GetDXUTState.FrameMoveFuncUserContext);
    pd3dDevice := DXUTGetD3DDevice;
    if (pd3dDevice = nil) then Exit; // Handle DXUTShutdown from inside callback
  end;

  if not GetDXUTState.RenderingPaused then
  begin
    // Render the scene by calling the app's render callback
    pCallbackFrameRender := GetDXUTState.FrameRenderFunc;
    if (@pCallbackFrameRender <> nil) then
    begin
      pCallbackFrameRender(pd3dDevice, fTime, fElapsedTime, GetDXUTState.FrameRenderFuncUserContext);
      pd3dDevice := DXUTGetD3DDevice;
      if (pd3dDevice = nil) then Exit; // Handle DXUTShutdown from inside callback
    end;

{$IFDEF DEBUG}
    // The back buffer should always match the client rect
    // if the Direct3D backbuffer covers the entire window
    GetClientRect(DXUTGetHWND, rcClient);
    if not IsIconic(DXUTGetHWND) then
    begin
      GetClientRect(DXUTGetHWND, rcClient);
      Assert(DXUTGetBackBufferSurfaceDesc.Width = LongWord(rcClient.right));
      Assert(DXUTGetBackBufferSurfaceDesc.Height = LongWord(rcClient.bottom));
    end;
{$ENDIF}

    // Show the frame on the primary surface.
    hr := pd3dDevice.Present(nil, nil, 0, nil);
    if FAILED(hr) then
    begin
      if (D3DERR_DEVICELOST = hr) then
      begin
        GetDXUTState.SetDeviceLost(True);
      end
      else if (D3DERR_DRIVERINTERNALERROR = hr) then 
      begin
        // When D3DERR_DRIVERINTERNALERROR is returned from Present(),
        // the application can do one of the following:
        //
        // - End, with the pop-up window saying that the application cannot continue
        //   because of problems in the display adapter and that the user should
        //   contact the adapter manufacturer.
        //
        // - Attempt to restart by calling IDirect3DDevice9::Reset, which is essentially the same
        //   path as recovering from a lost device. If IDirect3DDevice9::Reset fails with
        //   D3DERR_DRIVERINTERNALERROR, the application should end immediately with the message
        //   that the user should contact the adapter manufacturer.
        //
        // The framework attempts the path of resetting the device
        //
        GetDXUTState.SetDeviceLost(True);
      end;
    end;
  end;

  // Update current frame #
  nFrame := GetDXUTState.CurrentFrameNumber;
  Inc(nFrame);
  GetDXUTState.CurrentFrameNumber:= nFrame;

  // Check to see if the app should shutdown due to cmdline
  if (GetDXUTState.OverrideQuitAfterFrame <> 0) then
    if (nFrame > GetDXUTState.OverrideQuitAfterFrame) then DXUTShutdown;
end;


//--------------------------------------------------------------------------------------
// Updates the string which describes the device 
//--------------------------------------------------------------------------------------
procedure DXUTUpdateDeviceStats(DeviceType: TD3DDevType; BehaviorFlags: DWORD; const pAdapterIdentifier: TD3DAdapterIdentifier9);
const
  cchDesc = SizeOf(pAdapterIdentifier.Description);
var
  pstrDeviceStats: PWideChar;
  szDescription: array[0..cchDesc-1] of WideChar;
  pDeviceSettings: PDXUTDeviceSettings;
  pd3dEnum: CD3DEnumeration;
  pDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;
begin
  if GetDXUTState.NoStats then Exit;

  // Store device description
  pstrDeviceStats := GetDXUTState.GetDeviceStats;
  if (DeviceType = D3DDEVTYPE_REF) then StringCchCopy(pstrDeviceStats, 256, 'REF')
  else if (DeviceType = D3DDEVTYPE_HAL) then StringCchCopy(pstrDeviceStats, 256, 'HAL')
  else if (DeviceType = D3DDEVTYPE_SW)  then StringCchCopy(pstrDeviceStats, 256, 'SW');

  if (BehaviorFlags and D3DCREATE_HARDWARE_VERTEXPROCESSING <> 0) and
     (BehaviorFlags and D3DCREATE_PUREDEVICE <> 0) then
  begin
    if (DeviceType = D3DDEVTYPE_HAL)
    then StringCchCat(pstrDeviceStats, 256, ' (pure hw vp)')
    else StringCchCat(pstrDeviceStats, 256, ' (simulated pure hw vp)');
  end
  else if (BehaviorFlags and D3DCREATE_HARDWARE_VERTEXPROCESSING <> 0) then
  begin
    if (DeviceType = D3DDEVTYPE_HAL) 
    then StringCchCat(pstrDeviceStats, 256, ' (hw vp)')
    else StringCchCat(pstrDeviceStats, 256, ' (simulated hw vp)');
  end
  else if (BehaviorFlags and D3DCREATE_MIXED_VERTEXPROCESSING <> 0) then
  begin
    if (DeviceType = D3DDEVTYPE_HAL) 
    then StringCchCat(pstrDeviceStats, 256, ' (mixed vp)')
    else StringCchCat(pstrDeviceStats, 256, ' (simulated mixed vp)');
  end
  else if (BehaviorFlags and D3DCREATE_SOFTWARE_VERTEXPROCESSING <> 0) then
  begin
    StringCchCat(pstrDeviceStats, 256, ' (sw vp)');
  end;

  if (DeviceType = D3DDEVTYPE_HAL) then
  begin
    // Be sure not to overflow m_strDeviceStats when appending the adapter
    // description, since it can be long.
    StringCchCat(pstrDeviceStats, 256, ': ');

    // Try to get a unique description from the CD3DEnumDeviceSettingsCombo
    pDeviceSettings := GetDXUTState.GetCurrentDeviceSettings;
    pd3dEnum := DXUTPrepareEnumerationObject;
    pDeviceSettingsCombo := pd3dEnum.GetDeviceSettingsCombo(pDeviceSettings.AdapterOrdinal, pDeviceSettings.DeviceType, pDeviceSettings.AdapterFormat, pDeviceSettings.pp.BackBufferFormat, pDeviceSettings.pp.Windowed);
    if (pDeviceSettingsCombo <> nil) then
    begin
      StringCchCat(pstrDeviceStats, 256, pDeviceSettingsCombo.pAdapterInfo.szUniqueDescription);
    end else
    begin
      MultiByteToWideChar(CP_ACP, 0, pAdapterIdentifier.Description, -1, szDescription, cchDesc);
      szDescription[cchDesc-1] := #0;
      StringCchCat(pstrDeviceStats, 256, szDescription);
    end;
  end;
end;


//--------------------------------------------------------------------------------------
// Updates the frames/sec stat once per second
//--------------------------------------------------------------------------------------
procedure DXUTUpdateFrameStats;
var
  fLastTime: Double;
  dwFrames: DWORD;
  fAbsTime: Double;
  fFPS: Single;
  pstrFPS: PWideChar;
begin
  if GetDXUTState.NoStats then Exit;

  // Keep track of the frame count
  fLastTime := GetDXUTState.LastStatsUpdateTime;
  dwFrames  := GetDXUTState.LastStatsUpdateFrames;
  fAbsTime  := GetDXUTState.AbsoluteTime;
  Inc(dwFrames);
  GetDXUTState.LastStatsUpdateFrames:= dwFrames;

  // Update the scene stats once per second
  if (fAbsTime - fLastTime > 1.0) then
  begin
    fFPS := (dwFrames / (fAbsTime - fLastTime));
    GetDXUTState.FPS:= fFPS;
    GetDXUTState.LastStatsUpdateTime:= fAbsTime;
    GetDXUTState.LastStatsUpdateFrames:= 0;

    pstrFPS := GetDXUTState.FPSStats;
    //Clootie: Borland till Delphi9 has bugs on '%.02f' formatting with "WideFormatBuf"
    // StringCchFormat(pstrFPS, 64, '%0.2f fps ', [fFPS]);
    StringCchFormat(pstrFPS, 64, '%f fps ', [fFPS]);
  end;
end;


//--------------------------------------------------------------------------------------
// Updates the static part of the frame stats so it doesn't have be generated every frame
//--------------------------------------------------------------------------------------
procedure DXUTUpdateStaticFrameStats;
const
  VSyncDesc: array[False..True] of PWideChar = ('off', 'on');
var
  pDeviceSettings: PDXUTDeviceSettings;
  pd3dEnum: CD3DEnumeration;
  pDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;
  pPP: PD3DPresentParameters;
  strFmt, strDepthFmt, strMultiSample: array[0..99] of WideChar;
  pstrStaticFrameStats: PWideChar;
begin
  if GetDXUTState.NoStats then Exit;

  pDeviceSettings := GetDXUTState.GetCurrentDeviceSettings;
  if (pDeviceSettings = nil) then Exit;

  pd3dEnum := DXUTPrepareEnumerationObject;
  if (pd3dEnum = nil) then Exit;

  pDeviceSettingsCombo := pd3dEnum.GetDeviceSettingsCombo(pDeviceSettings.AdapterOrdinal,
                            pDeviceSettings.DeviceType, pDeviceSettings.AdapterFormat,
                            pDeviceSettings.pp.BackBufferFormat, pDeviceSettings.pp.Windowed);
  if (pDeviceSettingsCombo = nil) then Exit;

  pPP := @pDeviceSettings.pp;

  if (pDeviceSettingsCombo.AdapterFormat = pDeviceSettingsCombo.BackBufferFormat) then
  begin
    StringCchCopy(strFmt, 100, DXUTD3DFormatToString(pDeviceSettingsCombo.AdapterFormat, False));
  end else
  begin
    StringCchFormat(strFmt, 100, 'backbuf %s, adapter %s',
      [DXUTD3DFormatToString(pDeviceSettingsCombo.BackBufferFormat, False),
       DXUTD3DFormatToString(pDeviceSettingsCombo.AdapterFormat, False)]);
  end;

  if pPP.EnableAutoDepthStencil then
  begin
    StringCchFormat(strDepthFmt, 100, ' (%s)', [DXUTD3DFormatToString(pPP.AutoDepthStencilFormat, False)]);
  end else
  begin
    // No depth buffer
    strDepthFmt[0] := #0;
  end;

  case pPP.MultiSampleType of
    D3DMULTISAMPLE_NONMASKABLE: StringCchCopy(strMultiSample, 100, ' (Nonmaskable Multisample)');
    D3DMULTISAMPLE_NONE:        StringCchCopy(strMultiSample, 100, '');
    else                        StringCchFormat(strMultiSample, 100, ' (%dx Multisample)', [Ord(pPP.MultiSampleType)]);
  end;
  strMultiSample[99] := #0;

  //Clootie: Borland till Delphi9 has bugs on '%.02f' formatting with "WideFormatBuf"
  pstrStaticFrameStats := GetDXUTState.StaticFrameStats;

  StringCchFormat(pstrStaticFrameStats, 256, '%%sVsync %s (%dx%d), %s%s%s',
              [VSyncDesc[pPP.PresentationInterval <> D3DPRESENT_INTERVAL_IMMEDIATE],
              pPP.BackBufferWidth, pPP.BackBufferHeight,
              strFmt, strDepthFmt, strMultiSample]);
end;


//--------------------------------------------------------------------------------------
function DXUTGetFrameStats(bIncludeFPS: Boolean = False): PWideChar;
var
  pstrFrameStats: PWideChar;
  pstrFPS: PWideChar;
begin
  pstrFrameStats := GetDXUTState.GetFrameStats;
  if bIncludeFPS then pstrFPS := GetDXUTState.GetFPSStats else pstrFPS := '';
  StringCchFormat(pstrFrameStats, 256, GetDXUTState.GetStaticFrameStats, [pstrFPS]);
  Result:= pstrFrameStats;
end;


//--------------------------------------------------------------------------------------
// Handles window messages
//--------------------------------------------------------------------------------------
function DXUTStaticWndProc(hWnd: Windows.HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  pCallbackKeyboard: PDXUTCallbackKeyboard;
  bKeyDown, bAltDown: Boolean;
  dwMask: DWORD;
  pCallbackMouse: PDXUTCallbackMouse;
  xPos, yPos: Integer;
  pt: TPoint;
  nMouseWheelDelta: Integer;
  nMouseButtonState: Integer;
  bLeftButton, bRightButton, bMiddleButton, bSideButton1, bSideButton2: Boolean;
  pCallbackMsgProc: PDXUTCallbackMsgProc;
  bNoFurtherProcessing: Boolean;
  nResult: LRESULT;
  pd3dDevice: IDirect3DDevice9;
  hr: HRESULT;
  fTime: Double;
  fElapsedTime: Single;
  pCallbackFrameRender: PDXUTCallbackFrameRender;
  ptCursor: TPoint;
  bWireFrame: Boolean;
  bTimePaused: Boolean;
  hMenu: Windows.HMENU;
  bKeys: PDXUTKeysArray;
  bMouseButtons: PXUTMouseButtonsArray;
  rcCurrentClient: TRect;
begin
  // Consolidate the keyboard messages and pass them to the app's keyboard callback
  if (uMsg = WM_KEYDOWN) or
     (uMsg = WM_SYSKEYDOWN) or
     (uMsg = WM_KEYUP) or
     (uMsg = WM_SYSKEYUP) then
  begin
    bKeyDown := (uMsg = WM_KEYDOWN) or (uMsg = WM_SYSKEYDOWN);
    dwMask := (1 shl 29);
    bAltDown := ((lParam and dwMask) <> 0);

    bKeys := GetDXUTState.Keys;
    bKeys[Byte(wParam and $FF)] := bKeyDown;

    pCallbackKeyboard := GetDXUTState.KeyboardFunc;
    if (@pCallbackKeyboard <> nil) then
      pCallbackKeyboard(wParam, bKeyDown, bAltDown, GetDXUTState.KeyboardFuncUserContext);
  end;

  // Consolidate the mouse button messages and pass them to the app's mouse callback
  if (uMsg = WM_LBUTTONDOWN) or
     (uMsg = WM_LBUTTONUP) or
     (uMsg = WM_LBUTTONDBLCLK) or
     (uMsg = WM_MBUTTONDOWN) or
     (uMsg = WM_MBUTTONUP) or
     (uMsg = WM_MBUTTONDBLCLK) or
     (uMsg = WM_RBUTTONDOWN) or
     (uMsg = WM_RBUTTONUP) or
     (uMsg = WM_RBUTTONDBLCLK) or
     (uMsg = WM_XBUTTONDOWN) or
     (uMsg = WM_XBUTTONUP) or
     (uMsg = WM_XBUTTONDBLCLK) or
     (uMsg = WM_MOUSEWHEEL) or
     (GetDXUTState.NotifyOnMouseMove and (uMsg = WM_MOUSEMOVE)) then
  begin
    xPos := LOWORD(DWORD(lParam));
    yPos := HIWORD(DWORD(lParam));

    if (uMsg = WM_MOUSEWHEEL) then
    begin
      // WM_MOUSEWHEEL passes screen mouse coords
      // so convert them to client coords
      pt.x := xPos; pt.y := yPos;
      ScreenToClient(hWnd, pt);
      xPos := pt.x; yPos := pt.y;
    end;

    nMouseWheelDelta := 0;
    if (uMsg = WM_MOUSEWHEEL)
    then nMouseWheelDelta := HIWORD(DWORD(wParam));

    nMouseButtonState := LOWORD(DWORD(wParam));
    bLeftButton  := ((nMouseButtonState and MK_LBUTTON) <> 0);
    bRightButton := ((nMouseButtonState and MK_RBUTTON) <> 0);
    bMiddleButton := ((nMouseButtonState and MK_MBUTTON) <> 0);
    bSideButton1 := ((nMouseButtonState and MK_XBUTTON1) <> 0);
    bSideButton2 := ((nMouseButtonState and MK_XBUTTON2) <> 0);

    bMouseButtons := GetDXUTState.MouseButtons;
    bMouseButtons[0] := bLeftButton;
    bMouseButtons[1] := bMiddleButton;
    bMouseButtons[2] := bRightButton;
    bMouseButtons[3] := bSideButton1;
    bMouseButtons[4] := bSideButton2;

    pCallbackMouse := GetDXUTState.MouseFunc;
    if (@pCallbackMouse <> nil) then
      pCallbackMouse(bLeftButton, bRightButton, bMiddleButton,
                     bSideButton1, bSideButton2, nMouseWheelDelta,
                     xPos, yPos, GetDXUTState.MouseFuncUserContext);
  end;

  // Pass all messages to the app's MsgProc callback, and don't
  // process further messages if the apps says not to.
  pCallbackMsgProc := GetDXUTState.WindowMsgFunc;
  if (@pCallbackMsgProc <> nil) then
  begin
    bNoFurtherProcessing := False;
    nResult := pCallbackMsgProc(hWnd, uMsg, wParam, lParam, bNoFurtherProcessing, GetDXUTState.WindowMsgFuncUserContext);
    if bNoFurtherProcessing then
    begin
      Result:= nResult;
      Exit;
    end;
  end;

  case uMsg of
    WM_PAINT:
    begin
      pd3dDevice := DXUTGetD3DDevice;

      // Handle paint messages when the app is paused
      if (pd3dDevice <> nil) and DXUTIsRenderingPaused and
         GetDXUTState.DeviceObjectsCreated and GetDXUTState.DeviceObjectsReset then
      begin
        fTime := DXUTGetTime;
        fElapsedTime := DXUTGetElapsedTime;

        pCallbackFrameRender := GetDXUTState.FrameRenderFunc;
        if (@pCallbackFrameRender <> nil) then
          pCallbackFrameRender(pd3dDevice, fTime, fElapsedTime, GetDXUTState.FrameRenderFuncUserContext);

        hr := pd3dDevice.Present(nil, nil, 0, nil);
        if (D3DERR_DEVICELOST = hr) then
        begin
          GetDXUTState.SetDeviceLost(True);
        end
        else if (D3DERR_DRIVERINTERNALERROR = hr) then
        begin
          // When D3DERR_DRIVERINTERNALERROR is returned from Present(),
          // the application can do one of the following:
          //
          // - End, with the pop-up window saying that the application cannot continue
          //   because of problems in the display adapter and that the user should
          //   contact the adapter manufacturer.
          //
          // - Attempt to restart by calling IDirect3DDevice9::Reset, which is essentially the same
          //   path as recovering from a lost device. If IDirect3DDevice9::Reset fails with
          //   D3DERR_DRIVERINTERNALERROR, the application should end immediately with the message
          //   that the user should contact the adapter manufacturer.
          //
          // The framework attempts the path of resetting the device
          //
          GetDXUTState.SetDeviceLost(True);
        end;
      end;
    end;

    WM_SIZE:
    begin
      if (SIZE_MINIMIZED = wParam) then
      begin
        DXUTPause(True, True); // Pause while we're minimized
        GetDXUTState.SetMinimized(True);
        GetDXUTState.SetMaximized(False);
      end else
      begin
        GetClientRect(DXUTGetHWND, rcCurrentClient);
        if (rcCurrentClient.top = 0) and (rcCurrentClient.bottom = 0) then
        begin
          // Rapidly clicking the task bar to minimize and restore a window
          // can cause a WM_SIZE message with SIZE_RESTORED when
          // the window has actually become minimized due to rapid change
          // so just ignore this message
         end
        else if (SIZE_MAXIMIZED = wParam) then
        begin
          if GetDXUTState.Minimized then
            DXUTPause(False, False); // Unpause since we're no longer minimized

          GetDXUTState.Minimized := False;
          GetDXUTState.Maximized := True;
          DXUTCheckForWindowSizeChange;
          DXUTCheckForWindowChangingMonitors;
        end
        else if (SIZE_RESTORED = wParam) then
        begin
          if GetDXUTState.Maximized then
          begin
            GetDXUTState.Maximized := False;
            DXUTCheckForWindowSizeChange;
            DXUTCheckForWindowChangingMonitors;
          end
          else if GetDXUTState.Minimized then
          begin
            DXUTPause(False, False); // Unpause since we're no longer minimized
            GetDXUTState.Minimized := False;
            DXUTCheckForWindowSizeChange;
            DXUTCheckForWindowChangingMonitors;
          end else
          if GetDXUTState.InSizeMove then
          begin
            // If we're neither maximized nor minimized, the window size
            // is changing by the user dragging the window edges.  In this
            // case, we don't reset the device yet -- we wait until the
            // user stops dragging, and a WM_EXITSIZEMOVE message comes.
          end else
          begin
            // This WM_SIZE come from resizing the window via an API like SetWindowPos() so
            // resize and reset the device now.
            DXUTCheckForWindowSizeChange;
            DXUTCheckForWindowChangingMonitors;
          end;
        end
      end;
    end;

    WM_GETMINMAXINFO:
    begin
      PMinMaxInfo(lParam).ptMinTrackSize.x := DXUT_MIN_WINDOW_SIZE_X;
      PMinMaxInfo(lParam).ptMinTrackSize.y := DXUT_MIN_WINDOW_SIZE_Y;
    end;

    WM_ENTERSIZEMOVE:
    begin
      // Halt frame movement while the app is sizing or moving
      DXUTPause(True, True);
      GetDXUTState.InSizeMove := True;
    end;

    WM_EXITSIZEMOVE:
    begin
      DXUTPause(False, False);
      DXUTCheckForWindowSizeChange;
      DXUTCheckForWindowChangingMonitors;
      GetDXUTState.InSizeMove := False;
    end;

    WM_MOUSEMOVE:
    begin
      if not DXUTIsActive and not DXUTIsWindowed then
      begin
        pd3dDevice := DXUTGetD3DDevice;
        if (pd3dDevice <> nil) then
        begin
          GetCursorPos(ptCursor);
          pd3dDevice.SetCursorPosition(ptCursor.x, ptCursor.y, 0);
        end;
      end;
    end;

    WM_SETCURSOR:
    begin
      if DXUTIsActive and not DXUTIsWindowed then
      begin
        pd3dDevice := DXUTGetD3DDevice;
        if Assigned(pd3dDevice) and GetDXUTState.ShowCursorWhenFullScreen then pd3dDevice.ShowCursor(True);
        Result:= iTrue; // prevent Windows from setting cursor to window class cursor
        Exit;
      end;
    end;

    WM_ACTIVATEAPP:
    begin
      if (wParam = Integer(iTrue)) and not DXUTIsActive then // Handle only if previously not active
      begin
        GetDXUTState.Active := True;

        // Disable any controller rumble & input when de-activating app
        DXUTEnableXInput(True);

        // The GetMinimizedWhileFullscreen() varible is used instead of !DXUTIsWindowed()
        // to handle the rare case toggling to windowed mode while the fullscreen application
        // is minimized and thus making the pause count wrong
        if GetDXUTState.MinimizedWhileFullscreen then
        begin
          DXUTPause(False, False); // Unpause since we're no longer minimized
          GetDXUTState.MinimizedWhileFullscreen := False;
        end;

        // Upon returning to this app, potentially disable shortcut keys
        // (Windows key, accessibility shortcuts)
        if DXUTIsWindowed
        then DXUTAllowShortcutKeys(GetDXUTState.AllowShortcutKeysWhenWindowed)
        else DXUTAllowShortcutKeys(GetDXUTState.AllowShortcutKeysWhenFullscreen);

      end
      else if (wParam = Integer(iFalse)) and DXUTIsActive then // Handle only if previously active
      begin
        GetDXUTState.Active := False;

        // Disable any controller rumble & input when de-activating app
        DXUTEnableXInput(False);

        if not DXUTIsWindowed then
        begin
          // Going from full screen to a minimized state
          ClipCursor(nil);      // don't limit the cursor anymore
          DXUTPause(True, True); // Pause while we're minimized (take care not to pause twice by handling Self message twice)
          GetDXUTState.MinimizedWhileFullscreen := True;
        end;

        // Restore shortcut keys (Windows key, accessibility shortcuts) to original state
        //
        // This is important to call here if the shortcuts are disabled,
        // because if this is not done then the Windows key will continue to
        // be disabled while this app is running which is very bad.
        // If the app crashes, the Windows key will return to normal.
        DXUTAllowShortcutKeys(True);
      end;
    end;

    WM_ENTERMENULOOP:
      // Pause the app when menus are displayed
      DXUTPause(True, True);

    WM_EXITMENULOOP:
      DXUTPause(False, False);

    WM_MENUCHAR:
    begin
      // A menu is active and the user presses a key that does not correspond to any mnemonic or accelerator key
      // So just ignore and don't beep
      {$IFNDEF FPC}
      Result:= MAKELRESULT(0, MNC_CLOSE);
      {$ELSE}
      Result:= MAKELRESULT(0, {MNC_CLOSE}1);
      {$ENDIF}
      Exit;
    end;

    WM_NCHITTEST:
      // Prevent the user from selecting the menu in full screen mode
      if not DXUTIsWindowed then
      begin
        Result:= HTCLIENT;
        Exit;
      end;

    WM_POWERBROADCAST:
      case wParam of
        (*{$IFNDEF PBT_APMQUERYSUSPEND}
            const PBT_APMQUERYSUSPEND 0x0000
        {$ENDIF}*)
        0: {PBT_APMQUERYSUSPEND}
        begin
          // At this point, the app should save any data for open
          // network connections, files, etc., and prepare to go into
          // a suspended mode.  The app can use the MsgProc callback
          // to handle this if desired.
          Result:= iTrue;
          Exit;
        end;

        (*#ifndef PBT_APMRESUMESUSPEND
            #define PBT_APMRESUMESUSPEND 0x0007
        #endif*)
        7: {PBT_APMRESUMESUSPEND}
        begin
          // At this point, the app should recover any data, network
          // connections, files, etc., and resume running from when
          // the app was suspended. The app can use the MsgProc callback
          // to handle this if desired.

          // QPC may lose consistency when suspending, so reset the timer
          // upon resume.
          DXUTGetGlobalTimer.Reset;
          GetDXUTState.SetLastStatsUpdateTime(0);
          Result:= iTrue;
          Exit;
        end;
      end;

    WM_SYSCOMMAND:
      // Prevent moving/sizing in full screen mode
      case (wParam and $FFF0) of
        SC_MOVE,
        SC_SIZE,
        SC_MAXIMIZE,
        SC_KEYMENU:
          if not DXUTIsWindowed then
          begin
            Result:= 0;
            Exit;
          end;
      end;

    WM_SYSKEYDOWN:
    begin
      case wParam of
        VK_RETURN:
        begin
          if GetDXUTState.HandleAltEnter then
          begin
            // Toggle full screen upon alt-enter
            dwMask := (1 shl 29);
            if ((lParam and dwMask) <> 0) then // Alt is down also
            begin
              // Toggle the full screen/window mode
              DXUTPause(True, True);
              DXUTToggleFullScreen;
              DXUTPause(False, False);
              Result:= 0;
              Exit;
            end;
          end;
        end;
      end;
    end;

    WM_KEYDOWN:
    begin
      if GetDXUTState.HandleDefaultHotkeys then
      begin
        case wParam of
          VK_F3:
          begin
            DXUTPause(True, True);
            DXUTToggleREF;
            DXUTPause(False, False);
          end;

          VK_F8:
          begin
            bWireFrame := GetDXUTState.GetWireframeMode;
            bWireFrame := not bWireFrame;
            GetDXUTState.SetWireframeMode(bWireFrame);

            pd3dDevice := DXUTGetD3DDevice;
            if (pd3dDevice <> nil)
            then pd3dDevice.SetRenderState(D3DRS_FILLMODE, IfThen(bWireFrame, D3DFILL_WIREFRAME, D3DFILL_SOLID));
          end;

          VK_ESCAPE:
          begin
            // Received key to exit app
            SendMessage(hWnd, WM_CLOSE, 0, 0);
          end;

          VK_PAUSE:
          begin
            bTimePaused := DXUTIsTimePaused;
            bTimePaused := not bTimePaused;
            if bTimePaused
            then DXUTPause(True,  False)
            else DXUTPause(False, False);
          end;
        end;
      end;
    end;

    WM_CLOSE:
    begin
      hMenu := GetMenu(hWnd);
      if (hMenu <> 0) then DestroyMenu(hMenu);
      DestroyWindow(hWnd);
      Windows.UnregisterClass('Direct3DWindowClass', GetDXUTState.GetHInstance);
      GetDXUTState.SetHWNDFocus(0);
      GetDXUTState.SetHWNDDeviceFullScreen(0);
      GetDXUTState.SetHWNDDeviceWindowed(0);
      Result:= 0;
      Exit;
    end;

    WM_DESTROY: PostQuitMessage(0);
  end;

  // Don't allow the F10 key to act as a shortcut to the menu bar
  // by not passing these messages to the DefWindowProc only when
  // there's no menu present
  if not GetDXUTState.CallDefWindowProc or (GetDXUTState.Menu = 0) and ((uMsg = WM_SYSKEYDOWN) or (uMsg = WM_SYSKEYUP)) and (wParam = VK_F10)
  then Result:= 0
  else Result:= DefWindowProcW(hWnd, uMsg, wParam, lParam);
end;


//--------------------------------------------------------------------------------------
// Resets the state associated with DXUT
//--------------------------------------------------------------------------------------
procedure DXUTResetFrameworkState;
begin
  GetDXUTState.DestroyState;
  GetDXUTState.CreateState;
end;


//--------------------------------------------------------------------------------------
// Closes down the window.  When the window closes, it will cleanup everything
//--------------------------------------------------------------------------------------
procedure DXUTShutdown(nExitCode: Integer = 0);
var
  hWnd: Windows.HWND;
begin
  hWnd := DXUTGetHWND;
  if (hWnd <> 0) then SendMessage(hWnd, WM_CLOSE, 0, 0);

  GetDXUTState.SetExitCode(nExitCode);

  DXUTCleanup3DEnvironment(True);

  // Restore shortcut keys (Windows key, accessibility shortcuts) to original state
  // This is important to call here if the shortcuts are disabled,
  // because accessibility setting changes are permanent.
  // This means that if this is not done then the accessibility settings
  // might not be the same as when the app was started.
  // If the app crashes without restoring the settings, this is also true so it
  // would be wise to backup/restore the settings from a file so they can be
  // restored when the crashed app is run again.
  DXUTAllowShortcutKeys(True);

  with GetDXUTState do
  begin
    if Assigned(D3DEnumeration) then D3DEnumeration.CleanupDirect3DInterfaces;
    D3DEnumeration:= nil;
    D3D:= nil;
  end;

  if GetDXUTState.OverrideRelaunchMCE
  then DXUTReLaunchMediaCenter;
end;


//--------------------------------------------------------------------------------------
// Cleans up the 3D environment by:
//      - Calls the device lost callback 
//      - Calls the device destroyed callback 
//      - Releases the D3D device
//--------------------------------------------------------------------------------------
procedure DXUTCleanup3DEnvironment(bReleaseSettings: Boolean = True);
var
  pd3dDevice: IDirect3DDevice9;
  pCallbackDeviceLost: PDXUTCallbackDeviceLost;
  pCallbackDeviceDestroyed: PDXUTCallbackDeviceDestroyed;
  pOldDeviceSettings: PDXUTDeviceSettings;
  pbackBufferSurfaceDesc: PD3DSurfaceDesc;
  pd3dCaps: PD3DCaps9;
begin
  pd3dDevice := DXUTGetD3DDevice;
  if (pd3dDevice <> nil) then 
  begin
    GetDXUTState.InsideDeviceCallback := True;

    // Call the app's device lost callback
    if GetDXUTState.DeviceObjectsReset then
    begin
      pCallbackDeviceLost := GetDXUTState.DeviceLostFunc;
      if (@pCallbackDeviceLost <> nil) then pCallbackDeviceLost(GetDXUTState.DeviceLostFuncUserContext);
      GetDXUTState.DeviceObjectsReset := False;

      // Call the resource cache device lost function
      DXUTGetGlobalResourceCache.OnLostDevice;
    end;

    // Call the app's device destroyed callback
    if GetDXUTState.DeviceObjectsCreated then
    begin
      pCallbackDeviceDestroyed := GetDXUTState.DeviceDestroyedFunc;
      if (@pCallbackDeviceDestroyed <> nil) then
        pCallbackDeviceDestroyed(GetDXUTState.DeviceDestroyedFuncUserContext);
      GetDXUTState.DeviceObjectsCreated := False;

      // Call the resource cache device destory function
      DXUTGetGlobalResourceCache.OnDestroyDevice;
    end;

    GetDXUTState.InsideDeviceCallback:= False;

    // Release the D3D device and in debug configs, displays a message box if there
    // are unrelease objects.
    GetDXUTState.D3DDevice:= nil;
    if (pd3dDevice <> nil) then
    begin
      if (pd3dDevice._Release > 0) then
      begin
      {$IFNDEF FPC} //todo: Remove this HACK after succesfull debugging of FPC port
        DXUTDisplayErrorMessage(DXUTERR_NONZEROREFCOUNT);
        DXUT_ERR('DXUTCleanup3DEnvironment', DXUTERR_NONZEROREFCOUNT);
        {$IFDEF DEBUG}
        // Forced clearing of D3DDevice references, so D3D debug level will show additional messages
        OutputDebugString('DXUT.pas: releasing D3DDevice refcount until ZERO');
        while (pd3dDevice._Release > 0) do;
        {$ENDIF}
      {$ENDIF}
      end;
      Pointer(pd3dDevice) := nil;
    end;

    if bReleaseSettings then
    begin
      pOldDeviceSettings := GetDXUTState.CurrentDeviceSettings;
      Dispose(pOldDeviceSettings);
      GetDXUTState.CurrentDeviceSettings:= nil;
    end;

    pbackBufferSurfaceDesc := GetDXUTState.BackBufferSurfaceDesc;
    ZeroMemory(pbackBufferSurfaceDesc, SizeOf(TD3DSurfaceDesc));

    pd3dCaps := GetDXUTState.Caps;
    ZeroMemory(pd3dCaps, SizeOf(TD3DCaps9));

    GetDXUTState.DeviceCreated := False;
  end;
end;


//--------------------------------------------------------------------------------------
// Stores back buffer surface desc in GetDXUTState().GetBackBufferSurfaceDesc()
//--------------------------------------------------------------------------------------
procedure DXUTUpdateBackBufferDesc;
var
  pBackBuffer: IDirect3DSurface9;
  hr: HRESULT;
  pBBufferSurfaceDesc: PD3DSurfaceDesc;
begin
  hr := GetDXUTState.D3DDevice.GetBackBuffer(0, 0, D3DBACKBUFFER_TYPE_MONO, pBackBuffer);
  pBBufferSurfaceDesc := GetDXUTState.GetBackBufferSurfaceDesc;
  ZeroMemory(pBBufferSurfaceDesc, SizeOf(TD3DSurfaceDesc));
  if SUCCEEDED(hr) then 
  begin
    pBackBuffer.GetDesc(pBBufferSurfaceDesc^);
    pBackBuffer := nil;
  end;
end;


//--------------------------------------------------------------------------------------
// Starts a user defined timer callback
//--------------------------------------------------------------------------------------
function DXUTSetTimer(pCallbackTimer: PDXUTCallbackTimer; fTimeoutInSecs: Single = 1.0; pnIDEvent: PLongWord = nil; pCallbackUserContext: Pointer = nil): HRESULT;
var
  DXUTTimer: TDXUTTimer;
  pTimerList: TDXUTTimerArray;
  l: Integer;
begin
  if (@pCallbackTimer = nil) then
  begin
    Result:= DXUT_ERR_MSGBOX('DXUTSetTimer', E_INVALIDARG);
    Exit;
  end;

  DXUTTimer.pCallbackTimer := pCallbackTimer;
  DXUTTimer.pCallbackUserContext := pCallbackUserContext;
  DXUTTimer.fTimeoutInSecs := fTimeoutInSecs;
  DXUTTimer.fCountdown := fTimeoutInSecs;
  DXUTTimer.bEnabled := True;

  pTimerList := GetDXUTState.TimerList;
  //Clootie: Not needed in Delphi...
(*  if (pTimerList = nil) then
  begin
    pTimerList := new CGrowableArray<DXUT_TIMER>;
    if (pTimerList = nil )
        Result:= E_OUTOFMEMORY;
    GetDXUTState.SetTimerList( pTimerList);
  end; *)

  // Result:= pTimerList.Add(DXUTTimer);
  l:= Length(pTimerList);
  SetLength(pTimerList, l+1);
  pTimerList[l]:= DXUTTimer;
  //todo: Check do we need to assign "pTimerList" back to "GetDXUTState.TimerList"

  if (pnIDEvent <> nil) then pnIDEvent^ := Length(pTimerList);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Stops a user defined timer callback
//--------------------------------------------------------------------------------------
function DXUTKillTimer(nIDEvent: LongWord): HRESULT;
var
  pTimerList: TDXUTTimerArray;
begin
  pTimerList := GetDXUTState.GetTimerList;
  if (pTimerList = nil) then
  begin
    Result:= S_FALSE;
    Exit;
  end;

  if (nIDEvent < LongWord(Length(pTimerList))) then
  begin
    pTimerList[nIDEvent].bEnabled := False;
  end else
  begin
    Result:= DXUT_ERR_MSGBOX('DXUTKillTimer', E_INVALIDARG);
    Exit;
  end;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Internal helper function to handle calling the user defined timer callbacks
//--------------------------------------------------------------------------------------
procedure DXUTHandleTimers;
var
  fElapsedTime: Single;
  pTimerList: TDXUTTimerArray;
  i: Integer;
  DXUTTimer: TDXUTTimer;
begin
  fElapsedTime := DXUTGetElapsedTime;

  pTimerList := GetDXUTState.GetTimerList;
  if (pTimerList = nil) then Exit;

  // Walk through the list of timer callbacks
  for i:= 0 to Length(pTimerList) - 1 do
  begin
    DXUTTimer := pTimerList[i];
    if DXUTTimer.bEnabled then
    begin
      DXUTTimer.fCountdown := DXUTTimer.fCountdown - fElapsedTime;

      // Call the callback if count down expired
      if (DXUTTimer.fCountdown < 0) then
      begin
        DXUTTimer.pCallbackTimer(i, DXUTTimer.pCallbackUserContext);
        DXUTTimer.fCountdown := DXUTTimer.fTimeoutInSecs;
      end;
      pTimerList[i]:= DXUTTimer;
    end;
  end;
end;


//--------------------------------------------------------------------------------------
// External state access functions
//--------------------------------------------------------------------------------------
function DXUTGetD3DObject: IDirect3D9;
begin Result:= GetDXUTState.D3D; end;

function DXUTGetD3DDevice: IDirect3DDevice9;
begin Result:= GetDXUTState.D3DDevice; end;

function DXUTGetBackBufferSurfaceDesc: {const} PD3DSurfaceDesc;
begin Result:= GetDXUTState.BackBufferSurfaceDesc; end;

function DXUTGetDeviceCaps: {const} PD3DCaps9;
begin Result:= GetDXUTState.Caps; end;

function DXUTGetHINSTANCE: HINST;
begin Result:= GetDXUTState.HInstance; end;

function DXUTGetHWND: HWND;
begin
  if DXUTIsWindowed
  then Result:= GetDXUTState.HWNDDeviceWindowed
  else Result:= GetDXUTState.HWNDDeviceFullScreen;
end;

function DXUTGetHWNDFocus: HWND;
begin Result:= GetDXUTState.HWNDFocus; end;

function DXUTGetHWNDDeviceFullScreen: HWND;
begin Result:= GetDXUTState.HWNDDeviceFullScreen; end;

function DXUTGetHWNDDeviceWindowed: HWND;
begin Result:= GetDXUTState.HWNDDeviceWindowed; end;

function DXUTGetWindowClientRect: TRect;
begin
  GetClientRect(DXUTGetHWND, Result);
end;

function DXUTGetWindowClientRectAtModeChange: TRect;
begin
  Result := Rect(0, 0, GetDXUTState.WindowBackBufferWidthAtModeChange,
                       GetDXUTState.WindowBackBufferHeightAtModeChange);
end;

function DXUTGetFullsceenClientRectAtModeChange: TRect;
begin
  Result := Rect(0, 0, GetDXUTState.FullScreenBackBufferWidthAtModeChange,
                       GetDXUTState.GetFullScreenBackBufferHeightAtModeChange);
end;

function DXUTGetTime: Double;
begin Result:= GetDXUTState.Time; end;

function DXUTGetElapsedTime: Single;
begin Result:= GetDXUTState.ElapsedTime; end;

function DXUTGetFPS: Single;
begin Result:= GetDXUTState.FPS; end;

function DXUTGetWindowTitle: PWideChar;
begin Result:= GetDXUTState.WindowTitle; end;

function DXUTGetDeviceStats: PWideChar;
begin Result:= GetDXUTState.DeviceStats; end;

function DXUTIsRenderingPaused: Boolean;
begin Result:= GetDXUTState.PauseRenderingCount > 0; end;

function DXUTIsTimePaused: Boolean;
begin Result:= GetDXUTState.PauseTimeCount > 0; end;

function DXUTIsActive: Boolean;
begin Result:= GetDXUTState.GetActive; end;

function DXUTGetExitCode:Integer;
begin Result:= GetDXUTState.ExitCode; end;

function DXUTGetShowMsgBoxOnError: Boolean;
begin
  Result:= GetDXUTState.ShowMsgBoxOnError;
end;

function DXUTGetAutomation: Boolean;
begin
  Result:= GetDXUTState.Automation;
end;

function DXUTGetHandleDefaultHotkeys: Boolean;
begin Result:= GetDXUTState.GetHandleDefaultHotkeys; end;

function DXUTIsKeyDown(vKey: Byte): Boolean; // Pass a virtual-key code, ex. VK_F1, 'A', VK_RETURN, VK_LSHIFT, etc
var
  bKeys: PDXUTKeysArray;
begin
  bKeys := GetDXUTState.Keys;
  if (vKey >= $A0) and (vKey <= $A5) then // VK_LSHIFT, VK_RSHIFT, VK_LCONTROL, VK_RCONTROL, VK_LMENU, VK_RMENU
    Result:= GetAsyncKeyState(vKey) <> 0 // these keys only are tracked via GetAsyncKeyState()
  else if( vKey >= $01) and (vKey <= $06) and (vKey <> $03) then // mouse buttons (VK_*BUTTON)
    Result:= DXUTIsMouseButtonDown(vKey)
  else
    Result:= bKeys[vKey];
end;

function DXUTIsMouseButtonDown(vButton: Byte): Boolean; // Pass a virtual-key code: VK_LBUTTON, VK_RBUTTON, VK_MBUTTON, VK_XBUTTON1, VK_XBUTTON2
var
  bMouseButtons: PXUTMouseButtonsArray;
  nIndex: Integer;
begin
  bMouseButtons := GetDXUTState.GetMouseButtons;
  nIndex := DXUTMapButtonToArrayIndex(vButton);
  Result:= bMouseButtons[nIndex];
end;

procedure DXUTSetMultimonSettings(bAutoChangeAdapter: Boolean);
begin
  GetDXUTState.AutoChangeAdapter:= bAutoChangeAdapter;
end;

procedure DXUTSetCursorSettings(bShowCursorWhenFullScreen, bClipCursorWhenFullScreen: Boolean);
begin
  GetDXUTState.SetClipCursorWhenFullScreen(bClipCursorWhenFullScreen);
  GetDXUTState.SetShowCursorWhenFullScreen(bShowCursorWhenFullScreen);
  DXUTSetupCursor;
end;

procedure DXUTSetWindowSettings(bCallDefWindowProc: Boolean);
begin
  GetDXUTState.SetCallDefWindowProc(bCallDefWindowProc);
end;

procedure DXUTSetConstantFrameTime(bConstantFrameTime: Boolean; fTimePerFrame: Single = 0.0333);
begin
  if (GetDXUTState.OverrideConstantFrameTime) then
  begin
    bConstantFrameTime := GetDXUTState.OverrideConstantFrameTime;
    fTimePerFrame := GetDXUTState.OverrideConstantTimePerFrame;
  end;
  GetDXUTState.SetConstantFrameTime(bConstantFrameTime);
  GetDXUTState.SetTimePerFrame(fTimePerFrame);
end;


//--------------------------------------------------------------------------------------
// Return if windowed in the current device.  If no device exists yet, then returns false
//--------------------------------------------------------------------------------------
function DXUTIsWindowed: Boolean;
var
  pDeviceSettings: PDXUTDeviceSettings;
begin
  pDeviceSettings := GetDXUTState.CurrentDeviceSettings;
  if (pDeviceSettings <> nil)
  then Result:= pDeviceSettings.pp.Windowed
  else Result:= False;
end;


//--------------------------------------------------------------------------------------
// Return the present params of the current device.  If no device exists yet, then
// return blank present params
//--------------------------------------------------------------------------------------
function DXUTGetPresentParameters: TD3DPresentParameters;
var
  pDS: PDXUTDeviceSettings;
  pp: TD3DPresentParameters;
begin
  pDS := GetDXUTState.CurrentDeviceSettings;
  if (pDS <> nil) then
  begin
    Result:= pDS.pp;
  end else
  begin
    ZeroMemory(@pp, SizeOf(TD3DPresentParameters));
    Result:= pp;
  end;
end;


//--------------------------------------------------------------------------------------
// Return the device settings of the current device.  If no device exists yet, then
// return blank device settings 
//--------------------------------------------------------------------------------------
function DXUTGetDeviceSettings: TDXUTDeviceSettings;
var
  pDS: PDXUTDeviceSettings;
  ds: TDXUTDeviceSettings;
begin
  pDS := GetDXUTState.CurrentDeviceSettings;
  if (pDS <> nil) then
  begin
    Result:= pDS^;
  end else
  begin
    ZeroMemory(@ds, SizeOf(TDXUTDeviceSettings));
    Result:= ds;
  end;
end;


//--------------------------------------------------------------------------------------
// Display an custom error msg box 
//--------------------------------------------------------------------------------------
const
  SM_REMOTESESSION        = $1000;
  
procedure DXUTDisplayErrorMessage(hr: HRESULT);
var
  strBuffer: array[0..511] of WideChar;
  nExitCode: Integer;
  bFound: Boolean;
  bShowMsgBoxOnError: Boolean;
begin
  bFound := true;
  case hr of
    DXUTERR_NODIRECT3D:             begin nExitCode := 2; StringCchCopy(strBuffer, 512, 'Could not initialize Direct3D. You may want to check that the latest version of DirectX is correctly installed on your system.  '+
                                                                               'Also make sure that this program was compiled with header files that match the installed DirectX DLLs.'); end;
    DXUTERR_INCORRECTVERSION:       begin nExitCode := 10;StringCchCopy(strBuffer, 512, 'Incorrect version of Direct3D and/or D3DX.'); end;
    DXUTERR_MEDIANOTFOUND:          begin nExitCode := 4; StringCchCopy(strBuffer, 512, 'Could not find required media. Ensure that the DirectX SDK is correctly installed.'); end;
    DXUTERR_NONZEROREFCOUNT:        begin nExitCode := 5; StringCchCopy(strBuffer, 512, 'The D3D device has a non-zero reference count, meaning some objects were not released.'); end;
    DXUTERR_CREATINGDEVICE:         begin nExitCode := 6; StringCchCopy(strBuffer, 512, 'Failed creating the Direct3D device.'); end;
    DXUTERR_RESETTINGDEVICE:        begin nExitCode := 7; StringCchCopy(strBuffer, 512, 'Failed resetting the Direct3D device.'); end;
    DXUTERR_CREATINGDEVICEOBJECTS:  begin nExitCode := 8; StringCchCopy(strBuffer, 512, 'Failed creating Direct3D device objects.'); end;
    DXUTERR_RESETTINGDEVICEOBJECTS: begin nExitCode := 9; StringCchCopy(strBuffer, 512, 'Failed resetting Direct3D device objects.'); end;
    DXUTERR_NOCOMPATIBLEDEVICES:
    begin
      nExitCode := 3;
      if (GetSystemMetrics(SM_REMOTESESSION) <> 0)
      then StringCchCopy(strBuffer, 512, 'Direct3D does not work over a remote session.')
      else StringCchCopy(strBuffer, 512, 'Could not find any compatible Direct3D devices.');
    end;
  else
    bFound := False;
    nExitCode := 1;
  end;

  GetDXUTState.ExitCode:= nExitCode;

  bShowMsgBoxOnError := GetDXUTState.ShowMsgBoxOnError;
  if (bFound and bShowMsgBoxOnError) then
  begin
    if (DXUTGetWindowTitle[0] = #0)
    then MessageBoxW(DXUTGetHWND, @strBuffer, 'DirectX Application', MB_ICONERROR or MB_OK)
    else MessageBoxW(DXUTGetHWND, @strBuffer, DXUTGetWindowTitle, MB_ICONERROR or MB_OK);
  end;
end;


//--------------------------------------------------------------------------------------
// Checks to see if the HWND changed monitors, and if it did it creates a device
// from the monitor's adapter and recreates the scene.
//--------------------------------------------------------------------------------------
procedure DXUTCheckForWindowChangingMonitors;
{$IFDEF FPC}
  //Warning: FPC: not implemented due to runtime limitations
begin
  // Don't do this if the user doesn't want it
  if not GetDXUTState.AutoChangeAdapter then Exit;

{$ELSE}
var
  hr: HRESULT;
  hWindowMonitor: HMONITOR;
  hAdapterMonitor: HMONITOR;
  newOrdinal: LongWord;
  deviceSettings: TDXUTDeviceSettings;
  matchOptions: TDXUTMatchOptions;
begin
  // Skip this check for various reasons
  if not GetDXUTState.AutoChangeAdapter or
         GetDXUTState.IgnoreSizeChange or
     not GetDXUTState.DeviceCreated or
     not GetDXUTState.CurrentDeviceSettings.pp.Windowed
  then Exit;

  hWindowMonitor := DXUTMonitorFromWindow(DXUTGetHWND, MONITOR_DEFAULTTOPRIMARY);
  hAdapterMonitor := GetDXUTState.AdapterMonitor;
  if (hWindowMonitor <> hAdapterMonitor) then
  begin
    if SUCCEEDED(DXUTGetAdapterOrdinalFromMonitor(hWindowMonitor, newOrdinal)) then
    begin
      // Find the closest valid device settings with the new ordinal
      deviceSettings := DXUTGetDeviceSettings;
      deviceSettings.AdapterOrdinal := newOrdinal;

      matchOptions.eAdapterOrdinal     := DXUTMT_PRESERVE_INPUT;
      matchOptions.eDeviceType         := DXUTMT_CLOSEST_TO_INPUT;
      matchOptions.eWindowed           := DXUTMT_CLOSEST_TO_INPUT;
      matchOptions.eAdapterFormat      := DXUTMT_CLOSEST_TO_INPUT;
      matchOptions.eVertexProcessing   := DXUTMT_CLOSEST_TO_INPUT;
      matchOptions.eResolution         := DXUTMT_CLOSEST_TO_INPUT;
      matchOptions.eBackBufferFormat   := DXUTMT_CLOSEST_TO_INPUT;
      matchOptions.eBackBufferCount    := DXUTMT_CLOSEST_TO_INPUT;
      matchOptions.eMultiSample        := DXUTMT_CLOSEST_TO_INPUT;
      matchOptions.eSwapEffect         := DXUTMT_CLOSEST_TO_INPUT;
      matchOptions.eDepthFormat        := DXUTMT_CLOSEST_TO_INPUT;
      matchOptions.eStencilFormat      := DXUTMT_CLOSEST_TO_INPUT;
      matchOptions.ePresentFlags       := DXUTMT_CLOSEST_TO_INPUT;
      matchOptions.eRefreshRate        := DXUTMT_CLOSEST_TO_INPUT;
      matchOptions.ePresentInterval    := DXUTMT_CLOSEST_TO_INPUT;

      hr := DXUTFindValidDeviceSettings(deviceSettings, @deviceSettings, @matchOptions);
      if SUCCEEDED(hr) then
      begin
        // Create a Direct3D device using the new device settings.
        // If there is an existing device, then it will either reset or recreate the scene.
        hr := DXUTChangeDevice(@deviceSettings, nil, False, False);
        // If hr == E_ABORT, this means the app rejected the device settings in the ModifySettingsCallback
        if (hr = E_ABORT) then
        begin
          // so nothing changed and keep from attempting to switch adapters next time
          GetDXUTState.AutoChangeAdapter := False;
        end else
        if FAILED(hr) then
        begin
          DXUTShutdown;
          DXUTPause(False, False);
          Exit;
        end;
      end;
    end;
  end;
{$ENDIF}
end;


//--------------------------------------------------------------------------------------
// Look for an adapter ordinal that is tied to a HMONITOR
//--------------------------------------------------------------------------------------
function DXUTGetAdapterOrdinalFromMonitor(hMonitor: HMONITOR; out pAdapterOrdinal: LongWord): HRESULT;
var
  pd3dEnum: CD3DEnumeration;
  pD3D: IDirect3D9;
  pAdapterList: TD3DEnumAdapterInfoArray;
  iAdapter: Integer;
  pAdapterInfo: CD3DEnumAdapterInfo;
  hAdapterMonitor: {$IFDEF FPC}HANDLE{$ELSE}Direct3D9.HMONITOR{$ENDIF};
begin
  pAdapterOrdinal := 0;

  pd3dEnum := DXUTPrepareEnumerationObject;
  pD3D     := DXUTGetD3DObject;

  pAdapterList := pd3dEnum.GetAdapterInfoList;
  for iAdapter:= 0 to Length(pAdapterList) - 1 do
  begin
    pAdapterInfo := pAdapterList[iAdapter];
    hAdapterMonitor := pD3D.GetAdapterMonitor(pAdapterInfo.AdapterOrdinal);
    if (hAdapterMonitor = hMonitor) then
    begin
      pAdapterOrdinal := pAdapterInfo.AdapterOrdinal;
      Result:= S_OK;
      Exit;
    end;
  end;

  Result:= E_FAIL;
end;

//--------------------------------------------------------------------------------------
// Internal function to map MK_* to an array index
//--------------------------------------------------------------------------------------
function DXUTMapButtonToArrayIndex(vButton: Byte): Integer;
begin
  case vButton of
    MK_LBUTTON: Result:= 0;
    VK_MBUTTON,
    MK_MBUTTON: Result:= 1;
    MK_RBUTTON: Result:= 2;
    VK_XBUTTON1,
    MK_XBUTTON1: Result:= 3;
    VK_XBUTTON2,
    MK_XBUTTON2: Result:= 4;
  else
    Result:= 0;
  end;
end;


//--------------------------------------------------------------------------------------
// Setup cursor based on current settings (window/fullscreen mode, show cursor state, clip cursor state)
//--------------------------------------------------------------------------------------
procedure DXUTSetupCursor;
var
  pd3dDevice: IDirect3DDevice9;
  hCursor: Windows.HCURSOR;
  rcWindow: TRect;
begin
  // Show the cursor again if returning to fullscreen
  pd3dDevice := DXUTGetD3DDevice;
  if not DXUTIsWindowed and Assigned(pd3dDevice) then
  begin
    if GetDXUTState.ShowCursorWhenFullScreen then
    begin
      SetCursor(0); // Turn off Windows cursor in full screen mode
      hCursor := ULONG_PTR(GetClassLong{Ptr}(DXUTGetHWNDDeviceFullScreen, GCLP_HCURSOR));
      DXUTSetDeviceCursor(pd3dDevice, hCursor, False);
      DXUTGetD3DDevice.ShowCursor(True);
    end else
    begin
      SetCursor(0); // Turn off Windows cursor in full screen mode
      DXUTGetD3DDevice.ShowCursor(False);
    end;
  end;

  // Clip cursor if requested
  if not DXUTIsWindowed and GetDXUTState.ClipCursorWhenFullScreen then
  begin
    // Confine cursor to full screen window
    GetWindowRect(DXUTGetHWNDDeviceFullScreen, rcWindow);
    ClipCursor(@rcWindow);
  end else
  begin
    ClipCursor(nil);
  end;
end;


//--------------------------------------------------------------------------------------
// Gives the D3D device a cursor with image and hotspot from hCursor.
//--------------------------------------------------------------------------------------
function DXUTSetDeviceCursor(const pd3dDevice: IDirect3DDevice9; hCursor: HCURSOR; bAddWatermark: Boolean): HRESULT; 
const
  wMask: array [0..4] of Word = ($ccc0, $a2a0, $a4a0, $a2a0, $ccc0);
label
  End_;
type
  PACOLORREF = ^ACOLORREF;
  ACOLORREF = array[0..0] of COLORREF;
  pImg = ^img;
  img = array[0..16000] of DWORD;
var
  hr: HRESULT;
  iconinfo_: TIconInfo;
  bBWCursor: BOOL;
  pCursorSurface: IDirect3DSurface9;
  hdcColor: HDC;
  hdcMask: HDC;
  hdcScreen: HDC;
  bm: TBitmap;
  dwWidth: DWORD;
  dwHeightSrc: DWORD;
  dwHeightDest: DWORD;
  crColor: COLORREF;
  crMask: COLORREF;
  x, y: Cardinal;
  bmi: TBitmapInfo;
  pcrArrayColor: PACOLORREF;
  pcrArrayMask: PACOLORREF;
  pBitmap: pImg;
  hgdiobjOld: HGDIOBJ;
  lr: TD3DLockedRect;
begin
  hr := E_FAIL;
  pCursorSurface := nil;
  hdcColor := 0;
  hdcMask := 0;
  hdcScreen := 0;
  pcrArrayColor := nil;
  pcrArrayMask := nil;

  ZeroMemory(@iconinfo_, SizeOf(TIconInfo));
  if not GetIconInfo(hCursor, iconinfo_) then
    goto End_;

  if (0 = GetObject(iconinfo_.hbmMask, SizeOf(TBitmap), @bm)) then
    goto End_;
  dwWidth := bm.bmWidth;
  dwHeightSrc := bm.bmHeight;

  if (iconinfo_.hbmColor = 0) then
  begin
    bBWCursor := True;
    dwHeightDest := dwHeightSrc div 2;
  end else
  begin
    bBWCursor := False;
    dwHeightDest := dwHeightSrc;
  end;

  // Create a surface for the fullscreen cursor
  hr:= pd3dDevice.CreateOffscreenPlainSurface(dwWidth, dwHeightDest,
          D3DFMT_A8R8G8B8, D3DPOOL_SCRATCH, pCursorSurface, nil);
  if FAILED(hr) then
    goto End_;

  // pcrArrayMask = new DWORD[dwWidth * dwHeightSrc];
  GetMem(pcrArrayMask, SizeOf(DWORD)*(dwWidth * dwHeightSrc));

  ZeroMemory(@bmi, sizeof(bmi));
  bmi.bmiHeader.biSize := sizeof(bmi.bmiHeader);
  bmi.bmiHeader.biWidth := dwWidth;
  bmi.bmiHeader.biHeight := dwHeightSrc;
  bmi.bmiHeader.biPlanes := 1;
  bmi.bmiHeader.biBitCount := 32;
  bmi.bmiHeader.biCompression := BI_RGB;

  hdcScreen := GetDC(0);
  hdcMask := CreateCompatibleDC(hdcScreen);
  if (hdcMask = 0) then
  begin
    hr := E_FAIL;
    goto End_;
  end;
  hgdiobjOld := SelectObject(hdcMask, iconinfo_.hbmMask);
  GetDIBits(hdcMask, iconinfo_.hbmMask, 0, dwHeightSrc, pcrArrayMask, bmi,
    DIB_RGB_COLORS);
  SelectObject(hdcMask, hgdiobjOld);

  if (not bBWCursor) then
  begin
    // pcrArrayColor = new DWORD[dwWidth * dwHeightDest];
    GetMem(pcrArrayColor, SizeOf(DWORD)*(dwWidth * dwHeightDest));
    hdcColor := CreateCompatibleDC(hdcScreen);
    if (hdcColor = 0) then
    begin
      hr := E_FAIL;
      goto End_;
    end;
    SelectObject(hdcColor, iconinfo_.hbmColor);
    GetDIBits(hdcColor, iconinfo_.hbmColor, 0, dwHeightDest, pcrArrayColor, bmi,
      DIB_RGB_COLORS);
  end;

  // Transfer cursor image into the surface
  pCursorSurface.LockRect(lr, nil, 0);
  pBitmap:= lr.pBits;
  for y:= 0 to dwHeightDest - 1 do
  begin
    for x:= 0 to dwWidth - 1 do
    begin
      if bBWCursor then
      begin
        crColor:= pcrArrayMask^[dwWidth*(dwHeightDest-1-y) + x];
        crMask:= pcrArrayMask^[dwWidth*(dwHeightSrc-1-y) + x];
      end else
      begin
        crColor:= pcrArrayColor^[dwWidth*(dwHeightDest-1-y) + x];
        crMask:= pcrArrayMask^[dwWidth*(dwHeightDest-1-y) + x];
      end;
      if (crMask = 0) then
        pBitmap^[dwWidth*y + x]:= $ff000000 or crColor
      else
        pBitmap^[dwWidth*y + x]:= $00000000;

      // It may be helpful to make the D3D cursor look slightly
      // different from the Windows cursor so you can distinguish
      // between the two when developing/testing code.  When
      // bAddWatermark is TRUE, the following code adds some
      // small grey "D3D" characters to the upper-left corner of
      // the D3D cursor image.

      //if( bAddWatermark && x < 12 && y < 5 )
      if bAddWatermark and (x < 12) and (y < 5) then
      begin
        // 11.. 11.. 11.. .... CCC0
        // 1.1. ..1. 1.1. .... A2A0
        // 1.1. .1.. 1.1. .... A4A0
        // 1.1. ..1. 1.1. .... A2A0
        // 11.. 11.. 11.. .... CCC0

        // if( wMask[y] & (1 << (15 - x)) )
        if (wMask[y] and (1 shl (15 - x)) <> 0) then
        begin
          pBitmap^[dwWidth*y + x]:= pBitmap^[dwWidth*y + x] or $ff808080;
        end;
      end;
    end;
  end;
  pCursorSurface.UnlockRect;

  // Set the device cursor
  hr := pd3dDevice.SetCursorProperties(iconinfo_.xHotspot,
      iconinfo_.yHotspot, pCursorSurface);
  if FAILED(hr) then
    goto End_;

  hr := S_OK;

End_:
  if (iconinfo_.hbmMask <> 0)  then DeleteObject(iconinfo_.hbmMask);
  if (iconinfo_.hbmColor <> 0) then DeleteObject(iconinfo_.hbmColor);
  if (hdcScreen <> 0)          then ReleaseDC(0, hdcScreen);
  if (hdcColor <> 0)           then DeleteDC(hdcColor);
  if (hdcMask <> 0)            then DeleteDC(hdcMask);
  // SAFE_DELETE_ARRAY(pcrArrayColor);
  FreeMem(pcrArrayColor);
  // SAFE_DELETE_ARRAY(pcrArrayMask);
  FreeMem(pcrArrayMask);
  SAFE_RELEASE(pCursorSurface);
  Result:= hr;
end;


initialization
finalization
  DXUTFreeState;
end.

