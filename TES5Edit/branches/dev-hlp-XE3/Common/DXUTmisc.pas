(*----------------------------------------------------------------------------*
 *  DirectX 9 SDK December 2006 C++ common framework adaptation for Delphi    *
 *  by Alexey Barkovoy (e-mail: directx@clootie.ru)                           *
 *                                                                            *
 *  Desc: Direct3D part of framework.                                         *
 *  Supported compilers: Delphi 5,6,7,9 FreePascal 2.0                        *
 *                                                                            *
 *  Latest version can be downloaded from:                                    *
 *     http://www.clootie.ru                                                  *
 *     http://sourceforge.net/projects/delphi-dx9sdk                          *
 *----------------------------------------------------------------------------*
 *  $Id: DXUTmisc.pas,v 1.26 2007/02/05 22:21:00 clootie Exp $
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
// File: DXUTMisc.h
//
// Helper functions for Direct3D programming.
//
// Copyright (c) Microsoft Corporation. All rights reserved
//--------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------
// File: DXUTMisc.cpp
//
// Shortcut macros and functions for using DX objects
//
// Copyright (c) Microsoft Corporation. All rights reserved
//--------------------------------------------------------------------------------------

unit DXUTmisc;

{$I DirectX.inc}

interface

uses
  Windows, Messages, ShellAPI,
  DXTypes, Direct3D9, D3DX9, DXErr9, XInput, DXUTcore, DXUTEnum;

const
  INT_MAX       = 2147483647;    // maximum (signed) int value
  UINT_MAX      = $ffffffff;     // maximum unsigned int value

type
  ULongToPtr = Pointer;

//--------------------------------------------------------------------------------------
// XInput helper state/function
// This performs extra processing on XInput gamepad data to make it slightly more convenient to use
//
// Example usage:
//
//      DXUT_GAMEPAD gamepad[4];
//      for( DWORD iPort=0; iPort<DXUT_MAX_CONTROLLERS; iPort++ )
//          DXUTGetGamepadState( iPort, gamepad[iPort] );
//
//--------------------------------------------------------------------------------------
const
  DXUT_MAX_CONTROLLERS = 4;  // XInput handles up to 4 controllers

type
  PDXUTGamePad = ^TDXUTGamePad;
  TDXUTGamePad = record
    // From XINPUT_GAMEPAD
    wButtons: Word;
    bLeftTrigger: Byte;
    bRightTrigger: Byte;
    sThumbLX: Smallint;
    sThumbLY: Smallint;
    sThumbRX: Smallint;
    sThumbRY: Smallint;

    // Device properties
    caps: XINPUT_CAPABILITIES;
    bConnected: Boolean; // If the controller is currently connected
    bInserted: Boolean;  // If the controller was inserted this frame
    bRemoved: Boolean;   // If the controller was removed this frame

    // Thumb stick values converted to range [-1,+1]
    fThumbRX: Single;
    fThumbRY: Single;
    fThumbLX: Single;
    fThumbLY: Single;

    // Records which buttons were pressed this frame.
    // These are only set on the first frame that the button is pressed
    wPressedButtons: Word;
    bPressedLeftTrigger: Boolean;
    bPressedRightTrigger: Boolean;

    // Last state of the buttons
    wLastButtons: Word;
    bLastLeftTrigger: Boolean;
    bLastRightTrigger: Boolean;
  end;

function DXUTGetGamepadState(dwPort: DWORD; out pGamePad: TDXUTGamePad;
  bThumbstickDeadZone: Boolean = True; bSnapThumbstickToCardinals: Boolean = True): HRESULT;
function DXUTStopRumbleOnAllControllers: HRESULT;
procedure DXUTEnableXInput(bEnable: Boolean);

//--------------------------------------------------------------------------------------
// A growable array
//--------------------------------------------------------------------------------------
// Clootie: Instead of CGrowableArray in Delphi/FreePascal we will use dynamic
// arrays. The only thing we still need to provide is "Contains" function ->
function DynArrayContains(const DynArray: Pointer; var Element; ElementSize: Integer): Boolean;

type
  //--------------------------------------------------------------------------------------
  // Performs timer operations
  // Use DXUTGetGlobalTimer() to get the global instance
  //--------------------------------------------------------------------------------------
  CDXUTTimer = class
  protected
    m_bTimerStopped: Boolean;
    m_llQPFTicksPerSec: LONGLONG;

    m_llStopTime: LONGLONG;
    m_llLastElapsedTime: LONGLONG;
    m_llBaseTime: LONGLONG;

    function GetAdjustedCurrentTime: TLargeInteger;

  public
    constructor Create;

    procedure Reset; // resets the timer
    procedure Start; // starts the timer
    procedure Stop;  // stop (or pause) the timer
    procedure Advance; // advance the timer by 0.1 seconds
    function GetAbsoluteTime: Double; // get the absolute system time
    function GetTime: Double;         // get the current time
    function GetElapsedTime: Double;  // get the time that elapsed between GetElapsedTime() calls
    procedure GetTimeValues(out pfTime, pfAbsoluteTime: Double; out pfElapsedTime: Single); // get all time values at once
  public
    property AbsoluteTime: Double read GetAbsoluteTime; // get the absolute system time
    property Time: Double read GetTime;                 // get the current time
    property ElapsedTime: Double read GetElapsedTime;   // get the time that elapsed between GetElapsedTime() calls
    property IsStopped: Boolean read m_bTimerStopped;   // returns true if timer stopped
  end;

function DXUTGetGlobalTimer: CDXUTTimer;


//-----------------------------------------------------------------------------
// Resource cache for textures, fonts, meshs, and effects.
// Use DXUTGetGlobalResourceCache() to access the global cache
//-----------------------------------------------------------------------------

type
  TDXUTCacheSourceLocation = (DXUTCACHE_LOCATION_FILE, DXUTCACHE_LOCATION_RESOURCE);

  PDXUTCacheTexture = ^TDXUTCacheTexture;
  TDXUTCacheTexture = record
    Location: TDXUTCacheSourceLocation;
    wszSource: array[0..MAX_PATH-1] of WideChar;
    hSrcModule: HMODULE;
    Width: LongWord;
    Height: LongWord;
    Depth: LongWord;
    MipLevels: LongWord;
    Usage: DWORD;
    Format: TD3DFormat;
    Pool: TD3DPool;
    _Type: D3DRESOURCETYPE;
    pTexture: IDirect3DBaseTexture9;
  end;

  TDXUTCacheTextureArray = array of TDXUTCacheTexture;

  TDXUTCacheFont = record // : public D3DXFONT_DESC
  // _D3DXFONT_DESCW start
    Height: Longint;
    Width: Longint;
    Weight: LongWord;
    MipLevels: LongWord;
    Italic: BOOL;
    CharSet: Byte;
    OutputPrecision: Byte;
    Quality: Byte;
    PitchAndFamily: Byte;
    FaceName: array[0..LF_FACESIZE-1] of WideChar;
  // _D3DXFONT_DESCW end
    pFont: ID3DXFont;
  end;

  TDXUTCacheEffect = record
    Location: TDXUTCacheSourceLocation;
    wszSource: array [0..MAX_PATH-1] of WideChar;
    hSrcModule: HMODULE;
    dwFlags: DWORD;
    pEffect: ID3DXEffect;
  end;


  CDXUTResourceCache = class
  protected
    // friend CDXUTResourceCache& DXUTGetGlobalResourceCache();
    // friend HRESULT DXUTInitialize3DEnvironment();
    // friend HRESULT DXUTReset3DEnvironment();
    // friend void DXUTCleanup3DEnvironment( bool bReleaseSettings );

    m_TextureCache: TDXUTCacheTextureArray; // array of TDXUTCacheTexture;
    m_EffectCache: array of TDXUTCacheEffect;
    m_FontCache: array of TDXUTCacheFont;

    constructor Create;
  public
    destructor Destroy; override;

    function CreateTextureFromFile(pDevice: IDirect3DDevice9; pSrcFile: PWideChar; out ppTexture: IDirect3DTexture9): HRESULT;
    function CreateTextureFromFileEx(pDevice: IDirect3DDEVICE9; pSrcFile: PWideChar;
      Width, Height, MipLevels: LongWord; Usage: DWORD; Format: TD3DFormat;
      Pool: TD3DPool; Filter, MipFilter: DWORD; ColorKey: TD3DColor;
      pSrcInfo: PD3DXImageInfo; pPalette: PPaletteEntry; out ppTexture: IDirect3DTexture9): HRESULT;
    function CreateTextureFromResource(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar; ppTexture: IDirect3DTexture9): HRESULT;
    function CreateTextureFromResourceEx(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar;
      Width, Height, MipLevels: LongWord; Usage: DWORD; Format: TD3DFormat;
      Pool: TD3DPool; Filter, MipFilter: DWORD; ColorKey: TD3DColor;
      pSrcInfo: PD3DXImageInfo; pPalette: PPaletteEntry; out ppTexture: IDirect3DTexture9): HRESULT;
    function CreateCubeTextureFromFile(pDevice: IDirect3DDevice9; pSrcFile: PWideChar; out ppCubeTexture: IDirect3DCubeTexture9): HRESULT;
    function CreateCubeTextureFromFileEx(pDevice: IDirect3DDevice9; pSrcFile: PWideChar;
      Size, MipLevels: LongWord; Usage: DWORD; Format: TD3DFormat;
      Pool: TD3DPool; Filter, MipFilter: DWORD; ColorKey: TD3DColor;
      pSrcInfo: PD3DXImageInfo; pPalette: PPaletteEntry; out ppCubeTexture: IDirect3DCubeTexture9): HRESULT;
    function CreateCubeTextureFromResource(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar; out ppCubeTexture: IDirect3DCubeTexture9): HRESULT;
    function CreateCubeTextureFromResourceEx(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar;
      Size, MipLevels: LongWord; Usage: DWORD; Format: TD3DFormat;
      Pool: TD3DPool; Filter, MipFilter: DWORD; ColorKey: TD3DColor;
      pSrcInfo: PD3DXImageInfo; pPalette: PPaletteEntry; out ppCubeTexture: IDirect3DCubeTexture9): HRESULT;
    function CreateVolumeTextureFromFile(pDevice: IDirect3DDevice9; pSrcFile: PWideChar; out ppVolumeTexture: IDirect3DVolumeTexture9): HRESULT;
    function CreateVolumeTextureFromFileEx(pDevice: IDirect3DDevice9; pSrcFile: PWideChar;
      Width, Height, Depth, MipLevels: LongWord; Usage: DWORD; Format: TD3DFormat;
      Pool: TD3DPool; Filter, MipFilter: DWORD; ColorKey: TD3DColor;
      pSrcInfo: PD3DXImageInfo; pPalette: PPaletteEntry; out ppTexture: IDirect3DVolumeTexture9): HRESULT;
    function CreateVolumeTextureFromResource(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar; out ppVolumeTexture: IDirect3DVolumeTexture9): HRESULT;
    function CreateVolumeTextureFromResourceEx(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar;
      Width, Height, Depth, MipLevels: LongWord; Usage: DWORD; Format: TD3DFormat;
      Pool: TD3DPool; Filter, MipFilter: DWORD; ColorKey: TD3DColor;
      pSrcInfo: PD3DXImageInfo; pPalette: PPaletteEntry; out ppVolumeTexture: IDirect3DVolumeTexture9): HRESULT;
    function CreateFont(pDevice: IDirect3DDevice9;
      Height, Width, Weight, MipLevels: LongWord; Italic: BOOL;
      CharSet, OutputPrecision, Quality, PitchAndFamily: Byte;
      pFacename: PWideChar; out ppFont: ID3DXFont): HRESULT;
    function CreateFontIndirect(pDevice: IDirect3DDevice9; const pDesc: TD3DXFontDescW; out ppFont: ID3DXFont): HRESULT;
    function CreateEffectFromFile(pDevice: IDirect3DDevice9; pSrcFile: PWideChar;
      const pDefines: PD3DXMacro; pInclude: ID3DXInclude; Flags: DWORD;
      pPool: ID3DXEffectPool; out ppEffect: ID3DXEffect; ppCompilationErrors: PID3DXBuffer): HRESULT;
    function CreateEffectFromResource(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar;
      const pDefines: PD3DXMacro; pInclude: ID3DXInclude; Flags: DWORD;
      pPool: ID3DXEffectPool; out ppEffect: ID3DXEffect; ppCompilationErrors: PID3DXBuffer): HRESULT;

  public
    function OnCreateDevice(pd3dDevice: IDirect3DDevice9): HResult;
    function OnResetDevice(pd3dDevice: IDirect3DDevice9): HResult;
    function OnLostDevice: HResult;
    function OnDestroyDevice: HResult;
  end;

function DXUTGetGlobalResourceCache: CDXUTResourceCache;

type
  //-----------------------------------------------------------------------------
  // Name: class CD3DArcBall
  // Desc:
  //-----------------------------------------------------------------------------
  CD3DArcBall = class
  protected
    m_mRotation: TD3DXMatrixA16;         // Matrix for arc ball's orientation
    m_mTranslation: TD3DXMatrixA16;      // Matrix for arc ball's position
    m_mTranslationDelta: TD3DXMatrixA16; // Matrix for arc ball's position

    m_Offset: TPoint;                    // window offset, or upper-left corner of window
    m_nWidth: Integer;                   // arc ball's window width
    m_nHeight: Integer;                  // arc ball's window height
    m_vCenter: TD3DXVector2;             // center of arc ball
    m_fRadius: Single;                   // arc ball's radius in screen coords
    m_fRadiusTranslation: Single;        // arc ball's radius for translating the target

    m_qDown: TD3DXQuaternion;            // Quaternion before button down
    m_qNow: TD3DXQuaternion;             // Composite quaternion for current drag
    m_bDrag: Boolean;                    // Whether user is dragging arc ball

    m_ptLastMouse: TPoint;               // position of last mouse point
    m_vDownPt: TD3DXVector3;             // starting point of rotation arc
    m_vCurrentPt: TD3DXVector3;          // current point of rotation arc

    function ScreenToVector(fScreenPtX, fScreenPtY: Single): TD3DXVector3;

  public
    constructor Create;

    // Functions to change behavior
    procedure Reset;
    procedure SetTranslationRadius(fRadiusTranslation: Single); { m_fRadiusTranslation = fRadiusTranslation; }
    procedure SetWindow(nWidth: Integer; nHeight: Integer; fRadius: Single = 0.9); { m_nWidth = nWidth; m_nHeight = nHeight; m_fRadius = fRadius; m_vCenter = D3DXVECTOR2(m_nWidth/2.0f,m_nHeight/2.0f); }
    procedure SetOffset(nX, nY: Integer); { m_Offset.x = nX; m_Offset.y = nY; }

    // Call these from client and use GetRotationMatrix() to read new rotation matrix
    procedure OnBegin(nX, nY: Integer);  // start the rotation (pass current mouse position)
    procedure OnMove(nX, nY: Integer);   // continue the rotation (pass current mouse position)
    procedure OnEnd;                     // end the rotation

    // Or call this to automatically handle left, middle, right buttons
    function HandleMessages(hWnd: HWND; uMsg: Cardinal; wParam: WPARAM; lParam: LPARAM): LRESULT; overload;
    procedure HandleMessages(var Msg: TMsg; var Handled: Boolean); overload;

    // Functions to get/set state
    {const} function GetRotationMatrix: PD3DXMatrix; { return D3DXMatrixRotationQuaternion(&m_mRotation, &m_qNow); }
    {const} function GetTranslationMatrix: PD3DXMatrix;      { return &m_mTranslation; }
    {const} function GetTranslationDeltaMatrix: PD3DXMatrix; { return &m_mTranslationDelta; }
    {const} function IsBeingDragged: Boolean;                { return m_bDrag; }
    {const} function GetQuatNow: TD3DXQuaternion;            { return m_qNow; }
    procedure SetQuatNow(q: TD3DXQuaternion);        { m_qNow = q; }

    class function QuatFromBallPoints(const vFrom, vTo: TD3DXVector3): TD3DXQuaternion;
  end;


  //--------------------------------------------------------------------------------------
  // used by CCamera to map WM_KEYDOWN keys
  //--------------------------------------------------------------------------------------
  TD3DUtil_CameraKeys = (
    CAM_STRAFE_LEFT{ = 0},
    CAM_STRAFE_RIGHT,
    CAM_MOVE_FORWARD,
    CAM_MOVE_BACKWARD,
    CAM_MOVE_UP,
    CAM_MOVE_DOWN,
    CAM_RESET,
    CAM_CONTROLDOWN,
    CAM_MAX_KEYS,
    CAM_UNKNOWN{$IFDEF COMPILER6_UP} = $FF{$ENDIF} 
  );

const
  KEY_WAS_DOWN_MASK = $80;
  KEY_IS_DOWN_MASK  = $01;

  MOUSE_LEFT_BUTTON   = $01;
  MOUSE_MIDDLE_BUTTON = $02;
  MOUSE_RIGHT_BUTTON  = $04;
  MOUSE_WHEEL         = $08;

type
  //--------------------------------------------------------------------------------------
  // Simple base camera class that moves and rotates.  The base class
  //       records mouse and keyboard input for use by a derived class, and
  //       keeps common state.
  //--------------------------------------------------------------------------------------
  CBaseCamera = class
  protected
    m_mView: TD3DXMatrix;                 // View matrix
    m_mProj: TD3DXMatrix;                 // Projection matrix

    m_GamePad: array[0..DXUT_MAX_CONTROLLERS-1] of TDXUTGamePad; // XInput controller state
    m_vGamePadLeftThumb: TD3DXVector3;
    m_vGamePadRightThumb: TD3DXVector3;
    m_GamePadLastActive: array[0..DXUT_MAX_CONTROLLERS-1] of Double;

    m_cKeysDown: Integer;                 // Number of camera keys that are down.
    m_aKeys: array[CAM_STRAFE_LEFT..Pred(CAM_MAX_KEYS)] of Byte; // State of input - KEY_WAS_DOWN_MASK|KEY_IS_DOWN_MASK
    m_vKeyboardDirection: TD3DXVector3;   // Direction vector of keyboard input
    m_ptLastMousePosition: TPoint;        // Last absolute position of mouse cursor
    m_bMouseLButtonDown: Boolean;         // True if left button is down
    m_bMouseMButtonDown: Boolean;         // True if middle button is down
    m_bMouseRButtonDown: Boolean;         // True if right button is down
    m_nCurrentButtonMask: Integer;        // mask of which buttons are down
    m_nMouseWheelDelta: Integer;          // Amount of middle wheel scroll (+/-)
    m_vMouseDelta: TD3DXVector2;          // Mouse relative delta smoothed over a few frames
    m_fFramesToSmoothMouseData: Single;   // Number of frames to smooth mouse data over

    m_vDefaultEye: TD3DXVector3;          // Default camera eye position
    m_vDefaultLookAt: TD3DXVector3;       // Default LookAt position
    m_vEye: TD3DXVector3;                 // Camera eye position
    m_vLookAt: TD3DXVector3;              // LookAt position
    m_fCameraYawAngle: Single;            // Yaw angle of camera
    m_fCameraPitchAngle: Single;          // Pitch angle of camera

    m_rcDrag: TRect;                      // Rectangle within which a drag can be initiated.
    m_vVelocity: TD3DXVector3;            // Velocity of camera
    m_bMovementDrag: Boolean;             // If true, then camera movement will slow to a stop otherwise movement is instant
    m_vVelocityDrag: TD3DXVector3;        // Velocity drag force
    m_fDragTimer: Single;                 // Countdown timer to apply drag
    m_fTotalDragTimeToZero: Single;       // Time it takes for velocity to go from full to 0
    m_vRotVelocity: TD3DXVector2;         // Velocity of camera

    m_fFOV: Single;                       // Field of view
    m_fAspect: Single;                    // Aspect ratio
    m_fNearPlane: Single;                 // Near plane
    m_fFarPlane: Single;                  // Far plane

    m_fRotationScaler: Single;            // Scaler for rotation
    m_fMoveScaler: Single;                // Scaler for movement

    m_bInvertPitch: Boolean;              // Invert the pitch axis
    m_bEnablePositionMovement: Boolean;   // If true, then the user can translate the camera/model
    m_bEnableYAxisMovement: Boolean;      // If true, then camera can move in the y-axis

    m_bClipToBoundary: Boolean;           // If true, then the camera will be clipped to the boundary
    m_vMinBoundary: TD3DXVector3;         // Min point in clip boundary
    m_vMaxBoundary: TD3DXVector3;         // Max point in clip boundary

    // Functions to map a WM_KEYDOWN key to a D3DUtil_CameraKeys enum
    function MapKey(nKey: LongWord): TD3DUtil_CameraKeys; virtual;
    {const} function IsKeyDown(key: Byte): Boolean;  { return( (key & KEY_IS_DOWN_MASK) == KEY_IS_DOWN_MASK ); }
    {const} function WasKeyDown(key: Byte): Boolean; { return( (key & KEY_WAS_DOWN_MASK) == KEY_WAS_DOWN_MASK ); }

    procedure ConstrainToBoundary(var pV: TD3DXVector3);
    procedure UpdateVelocity(fElapsedTime: Single);
    procedure GetInput(bGetKeyboardInput, bGetMouseInput, bGetGamepadInput, bResetCursorAfterMove: Boolean);

  public
    constructor Create;

    // Call these from client and use Get*Matrix() to read new matrices
    function HandleMessages(hWnd: HWND; uMsg: Cardinal; wParam: WPARAM; lParam: LPARAM): LRESULT; virtual;
    procedure FrameMove(fElapsedTime: Single); virtual; abstract;

    // Functions to change camera matrices
    procedure Reset; virtual;
    procedure SetViewParams(const pvEyePt, pvLookatPt: TD3DXVector3); virtual;
    procedure SetProjParams(fFOV, fAspect, fNearPlane, fFarPlane: Single); virtual;

    // Functions to change behavior
    procedure SetDragRect(const rc: TRect); virtual; { m_rcDrag = rc; }
    procedure SetInvertPitch(bInvertPitch: Boolean); { m_bInvertPitch = bInvertPitch; }
    procedure SetDrag(bMovementDrag: Boolean; fTotalDragTimeToZero: Single = 0.25); { m_bMovementDrag = bMovementDrag; m_fTotalDragTimeToZero = fTotalDragTimeToZero; }
    procedure SetEnableYAxisMovement(bEnableYAxisMovement: Boolean); { m_bEnableYAxisMovement = bEnableYAxisMovement; }
    procedure SetEnablePositionMovement(bEnablePositionMovement: Boolean); { m_bEnablePositionMovement = bEnablePositionMovement; }
    procedure SetClipToBoundary(bClipToBoundary: Boolean; const pvMinBoundary, pvMaxBoundary: TD3DXVector3); { m_bClipToBoundary = bClipToBoundary; if( pvMinBoundary ) m_vMinBoundary = *pvMinBoundary; if( pvMaxBoundary ) m_vMaxBoundary = *pvMaxBoundary; }
    procedure SetScalers(fRotationScaler: Single = 0.01; fMoveScaler: Single = 5.0);  { m_fRotationScaler = fRotationScaler; m_fMoveScaler = fMoveScaler; }
    procedure SetNumberOfFramesToSmoothMouseData(nFrames: Integer); { if( nFrames > 0 ) m_fFramesToSmoothMouseData = (float)nFrames; }

    // Functions to get state
    function GetViewMatrix: PD3DXMatrix;      { return &m_mView; }
    function GetProjMatrix: PD3DXMatrix;      { return &m_mProj; }
    function GetEyePt: PD3DXVector3;          { return &m_vEye; }
    function GetLookAtPt: PD3DXVector3;       { return &m_vLookAt; }
    // function GetNearClip: Single; {const}  { return m_fNearPlane; }
    // function GetFarClip: Single; {const}   { return m_fFarPlane; }

    {const} function IsBeingDragged: Boolean;         { return (m_bMouseLButtonDown || m_bMouseMButtonDown || m_bMouseRButtonDown); }
    {const} property IsMouseLButtonDown: Boolean      read m_bMouseLButtonDown;
    {const} property IsMouseMButtonDown: Boolean      read m_bMouseMButtonDown;
    {const} property IsMouseRButtonDown: Boolean      read m_bMouseRButtonDown;
    {const} property NearClip: Single                 read m_fNearPlane;
    {const} property FarClip: Single                  read m_fFarPlane;
  end;


  //--------------------------------------------------------------------------------------
  // Simple first person camera class that moves and rotates.
  //       It allows yaw and pitch but not roll.  It uses WM_KEYDOWN and
  //       GetCursorPos() to respond to keyboard and mouse input and updates the
  //       view matrix based on input.
  //--------------------------------------------------------------------------------------
  CFirstPersonCamera = class(CBaseCamera)
  protected
    m_mCameraWorld: TD3DXMatrix; // World matrix of the camera (inverse of the view matrix)
    
    m_nActiveButtonMask: Integer; // Mask to determine which button to enable for rotation
    m_bRotateWithoutButtonDown: Boolean;

    m_bResetCursorAfterMove: Boolean; // If true, the class will reset the cursor position so that the cursor always has space to move 
  public
    constructor Create;

    // Call these from client and use Get*Matrix() to read new matrices
    procedure FrameMove(fElapsedTime: Single); override;

    // Functions to change behavior
    procedure SetRotateButtons(bLeft, bMiddle, bRight: Boolean; bRotateWithoutButtonDown: Boolean = False);

    procedure SetResetCursorAfterMove(bResetCursorAfterMove: Boolean); { m_bResetCursorAfterMove = bResetCursorAfterMove; }

    // Functions to get state
    function GetWorldMatrix: PD3DXMatrix; { return &m_mCameraWorld; }

    // Functions to get state
    {const} function GetWorldRight: PD3DXVector3; { return (D3DXVECTOR3*)&m_mCameraWorld._11; }
    {const} function GetWorldUp: PD3DXVector3;    { return (D3DXVECTOR3*)&m_mCameraWorld._21; }
    {const} function GetWorldAhead: PD3DXVector3; { return (D3DXVECTOR3*)&m_mCameraWorld._31; }
    {const} function GetEyePt: PD3DXVector3;      { return (D3DXVECTOR3*)&m_mCameraWorld._41; }
  end;


  //-----------------------------------------------------------------------------
  // Simple model viewing camera class that rotates around the object.
  //-----------------------------------------------------------------------------
  CModelViewerCamera = class(CBaseCamera)
  protected
    m_WorldArcBall: CD3DArcBall;
    m_ViewArcBall: CD3DArcBall;
    m_vModelCenter: TD3DXVector3;
    m_mModelLastRot: TD3DXMatrix;        // Last arcball rotation matrix for model
    m_mModelRot: TD3DXMatrix;            // Rotation matrix of model
    m_mWorld: TD3DXMatrix;               // World matrix of model

    m_nRotateModelButtonMask: Integer;
    m_nZoomButtonMask: Integer;
    m_nRotateCameraButtonMask: Integer;

    m_bAttachCameraToModel: Boolean;
    m_bLimitPitch: Boolean;
    m_fRadius: Single;              // Distance from the camera to model
    m_fDefaultRadius: Single;       // Distance from the camera to model
    m_fMinRadius: Single;           // Min radius
    m_fMaxRadius: Single;           // Max radius
    m_bDragSinceLastUpdate: Boolean;// True if mouse drag has happened since last time FrameMove is called.

    m_mCameraRotLast: TD3DXMatrix;

  public
    constructor Create;
    destructor Destroy; override;

    // Call these from client and use Get*Matrix() to read new matrices
    function HandleMessages(hWnd: HWND; uMsg: Cardinal; wParam: WPARAM; lParam: LPARAM): LRESULT; override;
    procedure FrameMove(fElapsedTime: Single); override;

    // Functions to change behavior
    procedure SetDragRect(const rc: TRect); override;
    procedure Reset; override;
    procedure SetViewParams(const pvEyePt, pvLookatPt: TD3DXVector3); override;
    procedure SetButtonMasks(nRotateModelButtonMask: Integer = MOUSE_LEFT_BUTTON; nZoomButtonMask: Integer = MOUSE_WHEEL; nRotateCameraButtonMask: Integer = MOUSE_RIGHT_BUTTON); { m_nRotateModelButtonMask = nRotateModelButtonMask, m_nZoomButtonMask = nZoomButtonMask; m_nRotateCameraButtonMask = nRotateCameraButtonMask; }

    procedure SetAttachCameraToModel(bEnable: Boolean = False); { m_bAttachCameraToModel = bEnable; }
    procedure SetWindow(nWidth, nHeight: Integer; fArcballRadius: Single = 0.9); { m_WorldArcBall.SetWindow( nWidth, nHeight, fArcballRadius ); m_ViewArcBall.SetWindow( nWidth, nHeight, fArcballRadius ); }
    procedure SetRadius(fDefaultRadius: Single = 5.0; fMinRadius: Single = 1.0; fMaxRadius: Single = 3.402823466e+38{FLT_MAX}); { m_fDefaultRadius = m_fRadius = fDefaultRadius; m_fMinRadius = fMinRadius; m_fMaxRadius = fMaxRadius; m_bDragSinceLastUpdate = true; }
    procedure SetModelCenter(vModelCenter: TD3DXVector3); { m_vModelCenter = vModelCenter; }
    procedure SetLimitPitch(bLimitPitch: Boolean); { m_bLimitPitch = bLimitPitch; }
    procedure SetViewQuat(q: TD3DXQuaternion);
    procedure SetWorldQuat(q: TD3DXQuaternion);

    // Functions to get state
    {const} function GetWorldMatrix: PD3DXMatrix; { return &m_mWorld; }
    procedure SetWorldMatrix(const mWorld: TD3DXMatrix); { m_mWorld = mWorld; m_bDragSinceLastUpdate = true; }
  end;


  //--------------------------------------------------------------------------------------
  // Manages the intertion point when drawing text
  //--------------------------------------------------------------------------------------
  CDXUTTextHelper = class
  public
    constructor Create(pFont: ID3DXFont; pSprite: ID3DXSprite; nLineHeight: Integer);
    destructor Destroy; override;

    procedure SetInsertionPos(x, y: Integer); { m_pt.x = x; m_pt.y = y; }
    procedure SetForegroundColor(clr: TD3DXColor); { m_clr = clr; }

    procedure _Begin;
    function DrawFormattedTextLine(const strMsg: PWideChar; args: array of const): HRESULT; overload;
    {$IFNDEF FPC}
    function DrawFormattedTextLine(const strMsg: WideString; args: array of const): HRESULT; overload;
    {$ENDIF}
    {$IFNDEF FPC}
    function DrawTextLine(const strMsg: PAnsiChar): HRESULT; overload;
    {$ENDIF}
    function DrawTextLine(const strMsg: PWideChar): HRESULT; overload;
    {$IFDEF BORLAND}{$IFNDEF COMPILER6_UP}
    function DrawTextLine(const strMsg: String): HRESULT; overload;
    {$ENDIF}{$ENDIF}
    function DrawFormattedTextLine(const rc: TRect; dwFlags: DWORD; const strMsg: PWideChar; args: array of const): HRESULT; overload;
    function DrawTextLine(const rc: TRect; dwFlags: DWORD; const strMsg: PWideChar): HRESULT; overload;
    procedure _End;

  protected
    m_pFont: ID3DXFont;
    m_pSprite: ID3DXSprite;
    m_clr: TD3DXColor;
    m_pt: TPoint;
    m_nLineHeight: Integer;
  end;


  PD3DXVector2Array = ^TD3DXVector2Array;
  TD3DXVector2Array = array[0..MaxInt div SizeOf(TD3DXVector2)-1] of TD3DXVector2;
  
  //--------------------------------------------------------------------------------------
  PLineNode = ^TLineNode;
  TLineNode = record
    nLineID: Integer;
    Color: TD3DColor;
    fWidth: Single;
    bAntiAlias: Boolean;
    fScaleRatio: Single;
    pVertexList: PD3DXVector2Array;
    dwVertexListCount: DWORD;
  end;

  //--------------------------------------------------------------------------------------
  // Manages a persistent list of lines and draws them using ID3DXLine
  //--------------------------------------------------------------------------------------
  CDXUTLineManager = class
  protected
    m_LinesList: array of PLineNode; // CGrowableArray<LINE_NODE*>
    m_pd3dDevice: IDirect3DDevice9;
    m_pD3DXLine: ID3DXLine;
    
  public
    constructor Create;
    destructor Destroy; override;

    function OnCreatedDevice(pd3dDevice: IDirect3DDevice9): HRESULT;
    function OnResetDevice: HRESULT;
    function OnRender: HRESULT;
    function OnLostDevice: HRESULT;
    function OnDeletedDevice: HRESULT;

    function AddLine(pnLineID: PInteger; pVertexList: PD3DXVector2; dwVertexListCount: DWORD; Color: TD3DColor; fWidth: Single; fScaleRatio: Single; bAntiAlias: Boolean): HRESULT;
    function AddRect(out pnLineID: Integer; const rc: TRect; Color: TD3DColor; fWidth: Single; fScaleRatio: Single; bAntiAlias: Boolean): HRESULT;
    function RemoveLine(nLineID: Integer): HRESULT;
    function RemoveAllLines: HRESULT;
  end;

//--------------------------------------------------------------------------------------
var
  s_pd3dDevice: IDirect3DDevice9 = nil;
  s_pEffect: ID3DXEffect = nil;
  s_pMesh: ID3DXMesh = nil;

type
  //--------------------------------------------------------------------------------------
  // Manages the mesh, direction, mouse events of a directional arrow that
  // rotates around a radius controlled by an arcball
  //--------------------------------------------------------------------------------------
  CDXUTDirectionWidget = class
  protected
    m_mRot: TD3DXMatrixA16;
    m_mRotSnapshot: TD3DXMatrixA16;
    m_fRadius: Single;
    m_nRotateMask: Integer;
    m_ArcBall: CD3DArcBall;
    m_vDefaultDir: TD3DXVector3;
    m_vCurrentDir: TD3DXVector3;
    m_mView: TD3DXMatrix;

    function UpdateLightDir: HRESULT;
  public
    constructor Create;
    destructor Destroy; override;

    class function StaticOnCreateDevice(pd3dDevice: IDirect3DDevice9): HRESULT;
    function OnResetDevice(const pBackBufferSurfaceDesc: TD3DSurfaceDesc): HRESULT;
    function OnRender(color: TD3DXColor; const pmView, pmProj: TD3DXMatrix; const pEyePt: TD3DXVector3): HRESULT;
    function HandleMessages(hWnd: HWND; uMsg: Cardinal; wParam: WPARAM; lParam: LPARAM): LRESULT;
    class procedure StaticOnLostDevice;
    class procedure StaticOnDestroyDevice;

    // function GetLightDirection: TD3DXVector3;        { return m_vCurrentDir; }
    procedure SetLightDirection(vDir: TD3DXVector3); { m_vDefaultDir = m_vCurrentDir = vDir; }
    procedure SetButtonMask(nRotate: Integer = MOUSE_RIGHT_BUTTON); { m_nRotateMask = nRotate; }

    // float GetRadius()                 { return m_fRadius; };
    // void  SetRadius( float fRadius )  { m_fRadius = fRadius; };

    function IsBeingDragged: Boolean; { return m_ArcBall.IsBeingDragged(); }

    property Radius: Single read m_fRadius write m_fRadius;
    property LightDirection: TD3DXVector3 read m_vCurrentDir write SetLightDirection;
  end;


//--------------------------------------------------------------------------------------
// Shared code for samples to ask user if they want to use a REF device or quit
//--------------------------------------------------------------------------------------
procedure DXUTDisplaySwitchingToREFWarning;

//--------------------------------------------------------------------------------------
// Tries to finds a media file by searching in common locations
//--------------------------------------------------------------------------------------
function DXUTFindDXSDKMediaFile(strDestPath: PWideChar; cchDest: Integer; const strFilename: PWideChar): HRESULT; overload;
{$IFNDEF FPC}
function DXUTFindDXSDKMediaFile(strDestPath: PWideChar; cchDest: Integer; const strFilename: WideString): HRESULT; overload;
{$ENDIF}
function DXUTFindDXSDKMediaFile(out strDestPath: WideString; const strFilename: PWideChar): HRESULT; overload;
{$IFNDEF FPC}
function DXUTFindDXSDKMediaFile(out strDestPath: WideString; const strFilename: WideString): HRESULT; overload;
{$ENDIF}
function DXUTSetMediaSearchPath(strPath: PWideChar): HRESULT;
function DXUTGetMediaSearchPath: PWideChar;

//--------------------------------------------------------------------------------------
// Returns the string for the given D3DFORMAT.
//       bWithPrefix determines whether the string should include the "D3DFMT_"
//--------------------------------------------------------------------------------------
function DXUTD3DFormatToString(format: TD3DFormat; bWithPrefix: Boolean): PWideChar;


//-----------------------------------------------------------------------------
// Returns a view matrix for rendering to a face of a cubemap.
//-----------------------------------------------------------------------------
function DXUTGetCubeMapViewMatrix(dwFace: TD3DCubemapFaces): TD3DXMatrix;

//--------------------------------------------------------------------------------------
// Helper function to launch the Media Center UI after the program terminates
//--------------------------------------------------------------------------------------
function DXUTReLaunchMediaCenter: Boolean;

//--------------------------------------------------------------------------------------
// Debug printing support
// See dxerr.h for more debug printing support
//--------------------------------------------------------------------------------------
procedure DXUTTraceDecl(const decl: TFVFDeclaration);
function DXUTTraceD3DDECLUSAGEtoString(u: TD3DDeclUsage): PWideChar;
function DXUTTraceD3DDECLMETHODtoString(m: TD3DDeclMethod): PWideChar;
function DXUTTraceD3DDECLTYPEtoString(t: TD3DDeclType): PWideChar;


//--------------------------------------------------------------------------------------
// Direct3D9 dynamic linking support -- calls top-level D3D9 APIs with graceful
// failure if APIs are not present.
//--------------------------------------------------------------------------------------

function DXUT_Dynamic_Direct3DCreate9(SDKVersion: LongWord): IDirect3D9; stdcall;
function DXUT_Dynamic_D3DPERF_BeginEvent(col: TD3DColor; wszName: PWideChar): Integer; stdcall;
function DXUT_Dynamic_D3DPERF_EndEvent: Integer; stdcall;
procedure DXUT_Dynamic_D3DPERF_SetMarker(col: TD3DColor; wszName: PWideChar); stdcall;
procedure DXUT_Dynamic_D3DPERF_SetRegion(col: TD3DColor; wszName: PWideChar); stdcall;
function DXUT_Dynamic_D3DPERF_QueryRepeatFrame: BOOL; stdcall;
procedure DXUT_Dynamic_D3DPERF_SetOptions(dwOptions: DWORD); stdcall;
function DXUT_Dynamic_D3DPERF_GetStatus: DWORD; stdcall;


//--------------------------------------------------------------------------------------
// Profiling/instrumentation support
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// Some D3DPERF APIs take a color that can be used when displaying user events in
// performance analysis tools.  The following constants are provided for your
// convenience, but you can use any colors you like.
//--------------------------------------------------------------------------------------
const DXUT_PERFEVENTCOLOR : TD3DColor = DWORD($FF shl 24) or (200 shl 16) or (100 shl 8) or 100; // D3DCOLOR_XRGB(200,100,100);
const DXUT_PERFEVENTCOLOR2: TD3DColor = DWORD($FF shl 24) or (100 shl 16) or (200 shl 8) or 100; // D3DCOLOR_XRGB(100,200,100);
const DXUT_PERFEVENTCOLOR3: TD3DColor = DWORD($FF shl 24) or (100 shl 16) or (100 shl 8) or 200; // D3DCOLOR_XRGB(100,100,200);

//--------------------------------------------------------------------------------------
// The following macros provide a convenient way for your code to call the D3DPERF 
// functions only when PROFILE is defined.  If PROFILE is not defined (as for the final 
// release version of a program), these macros evaluate to nothing, so no detailed event
// information is embedded in your shipping program.  It is recommended that you create
// and use three build configurations for your projects:
//     Debug (nonoptimized code, asserts active, PROFILE defined to assist debugging)
//     Profile (optimized code, asserts disabled, PROFILE defined to assist optimization)
//     Release (optimized code, asserts disabled, PROFILE not defined)
//--------------------------------------------------------------------------------------
function DXUT_BeginPerfEvent(col: TD3DColor; wszName: PWideChar): Integer;
function DXUT_EndPerfEvent: Integer;
procedure DXUT_SetPerfMarker(col: TD3DColor; wszName: PWideChar);

//type
  //--------------------------------------------------------------------------------------
  // CDXUTPerfEventGenerator is a helper class that makes it easy to attach begin and end
  // events to a block of code.  Simply define a CDXUTPerfEventGenerator variable anywhere
  // in a block of code, and the class's constructor will call DXUT_BeginPerfEvent when
  // the block of code begins, and the class's destructor will call DXUT_EndPerfEvent when
  // the block ends.
  //--------------------------------------------------------------------------------------

  ///////////////////////////////////
  // Clootie: CDXUTPerfEventGenerator can be implemented as Delphi interface,
  // but it will be cleared only ar function exit - not at block exit level, so...
  ///////////////////////////////////

(*  CDXUTPerfEventGenerator = class
  public
    CDXUTPerfEventGenerator( D3DCOLOR color, WCHAR* pstrMessage ) { DXUT_BeginPerfEvent( color, pstrMessage ); }
    ~CDXUTPerfEventGenerator( void ) { DXUT_EndPerfEvent(); }
  end; *)


//--------------------------------------------------------------------------------------
// Multimon handling to support OSes with or without multimon API support.
// Purposely avoiding the use of multimon.h so DXUT.lib doesn't require
// COMPILE_MULTIMON_STUBS and cause complication with MFC or other users of multimon.h
//--------------------------------------------------------------------------------------
{$IFNDEF MONITOR_DEFAULTTOPRIMARY}
const
  MONITORINFOF_PRIMARY        = $00000001;
  MONITOR_DEFAULTTONULL       = $00000000;
  MONITOR_DEFAULTTOPRIMARY    = $00000001;
  MONITOR_DEFAULTTONEAREST    = $00000002;

type
  PMonitorInfo = ^TMonitorInfo;
  TMonitorInfo = record
    cbSize:    DWORD;
    rcMonitor: TRect;
    rcWork:    TRect;
    dwFlags:   DWORD;
  end;

  PMonitorInfoExW = ^TMonitorInfoExW;
  TMonitorInfoExW = record
    cbSize:    DWORD;
    rcMonitor: TRect;
    rcWork:    TRect;
    dwFlags:   DWORD;
    szDevice: array[0..CCHDEVICENAME-1] of WideChar;
  end;
{$ENDIF}

function DXUTMonitorFromWindow(hWnd: HWND; dwFlags: DWORD): HMONITOR;
function DXUTGetMonitorInfo(hMonitor: HMONITOR; lpMonitorInfo: PMonitorInfo): Boolean;
procedure DXUTGetDesktopResolution(AdapterOrdinal: LongWord; out pWidth, pHeight: LongWord);


const
  // ENUM_CURRENT_SETTINGS       = DWORD(-1);
  ENUM_REGISTRY_SETTINGS      = DWORD(-2);

  

//--------------------------------------------------------------------------------------
// Creates a REF or NULLREF device and returns that device.  The caller should call
// Release() when done with the device.
//--------------------------------------------------------------------------------------
function DXUTCreateRefDevice(hWnd: HWND; bNullRef: Boolean = True): IDirect3DDevice9;



{ Easy to use conditional functions }
function IfThen(AValue: Boolean; const ATrue, AFalse: Boolean): Boolean; overload;
function IfThen(AValue: Boolean; const ATrue, AFalse: WideString): WideString; overload;
{$IFDEF FPC}
  {$DEFINE D5_OR_FPC}
{$ENDIF}
{$IFDEF BORLAND}
  {$IFNDEF COMPILER6_UP}
    {$DEFINE D5_OR_FPC}
  {$ENDIF}
{$ENDIF}
{$IFDEF D5_OR_FPC}
function IfThen(AValue: Boolean; const ATrue: Integer; const AFalse: Integer = 0): Integer; overload;
function IfThen(AValue: Boolean; const ATrue: Int64; const AFalse: Int64 = 0): Int64; overload;
function IfThen(AValue: Boolean; const ATrue: Single; const AFalse: Single = 0.0): Single; overload;
{$ENDIF}

const
  // Nor Delphi till 7, nor FPC has this variable defined
  CSTR_EQUAL               = 2;             { string 1 equal to string 2 }

function lstrcatnW(lpString1, lpString2: PWideChar; count: Integer): PWideChar;
function WideStrRScan(const Str: PWideChar; Chr: WideChar): PWideChar;


implementation

uses
  SysUtils, Classes, Math, DXUT, DXUTRes, StrSafe;

const
  DXUT_GAMEPAD_TRIGGER_THRESHOLD      = 30;
  DXUT_INPUT_DEADZONE {: Single}      = (0.24 * $7FFF);  // Default to 24% of the +/- 32767 range.   This is a reasonable default value but can be altered if needed.

function lstrcatnW(lpString1, lpString2: PWideChar; count: Integer): PWideChar;
begin
  Result:= lpString1;
  Inc(lpString1, lstrlenW(lpString1));
  lstrcpynW(lpString1, lpString2, count);
end;

function WideStrRScan(const Str: PWideChar; Chr: WideChar): PWideChar;
var
  MostRecentFound: PWideChar;
begin
{ // let's forget about this case for now...
  if Chr = #0 then
    Result := WideStrEnd(Str)
  else }
  begin
    Result := nil;

    MostRecentFound := Str;
    while True do
    begin
      while MostRecentFound^ <> Chr do
      begin
        if MostRecentFound^ = #0 then
          Exit;
        Inc(MostRecentFound);
      end;
      Result := MostRecentFound;
      Inc(MostRecentFound);
    end;
  end;
end;

function IfThen(AValue: Boolean; const ATrue, AFalse: Boolean): Boolean; overload;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue, AFalse: WideString): WideString; overload;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

{$IFDEF D5_OR_FPC}
function IfThen(AValue: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Int64; const AFalse: Int64): Int64;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Single; const AFalse: Single): Single; overload;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;
{$ENDIF}

function DynArrayContains(const DynArray: Pointer; var Element; ElementSize: Integer): Boolean;
var
  i: Integer;
  p, pp: Pointer;
begin
  Result:= False;
  if DynArray = nil then Exit;
  p:= DynArray; Dec(PLongint(p));
  for i:= 0 to PLongint(p)^ - 1 do
  begin
    pp:= Pointer(Longint(DynArray) + ElementSize*i);
    if CompareMem(@Element, pp, ElementSize) then
    begin
      Result:= True;
      Break;
    end;
  end;
end;


//--------------------------------------------------------------------------------------
// Global/Static Members
//--------------------------------------------------------------------------------------
var {static} cache: CDXUTResourceCache = nil;
var {static} timer: CDXUTTimer = nil;

function DXUTGetGlobalResourceCache: CDXUTResourceCache;
begin
  // Using an accessor function gives control of the construction order
  if (cache = nil) then cache:= CDXUTResourceCache.Create;
  Result:= cache;
end;

function DXUTGetGlobalTimer: CDXUTTimer;
begin
  // Using an accessor function gives control of the construction order
  if (timer = nil) then timer:= CDXUTTimer.Create;
  Result:= timer;
end;

//--------------------------------------------------------------------------------------
// Internal functions forward declarations
//--------------------------------------------------------------------------------------
function DXUTFindMediaSearchTypicalDirs(out strSearchPath: WideString; strLeaf, strExePath, strExeName: WideString): Boolean; forward;
function DXUTFindMediaSearchParentDirs(out strSearchPath: WideString; strStartAt, strLeafName: WideString): Boolean; forward;
function DisplaySwitchToREFWarningProc(hDlg: HWND; message: LongWord; wParam: WPARAM; lParam: LPARAM): INT_PTR; stdcall; forward;


//--------------------------------------------------------------------------------------
// Shared code for samples to ask user if they want to use a REF device or quit
//--------------------------------------------------------------------------------------
procedure DXUTDisplaySwitchingToREFWarning;
var
  dwSkipWarning: DWORD;
  hKey: Windows.HKEY;
  lResult: Longint;
  dwType, dwSize: DWORD;
  nResult: Integer;
type
  TDXUT_DLG_Item = packed record
    a: TDlgItemTemplate; b, c, d, e, f: Word;
  end;
  TDXUT_DLG_Data = packed record
    a: TDlgTemplate; b: Word; c: Word;
    d: array[0..1] of WideChar; e: Word; f: array[0..13] of WideChar;
    i1, i2, i3, i4, i5: TDXUT_DLG_Item;
  end;
const
  dtp: TDXUT_DLG_Data = (
    a: (style: WS_CAPTION or WS_POPUP or WS_VISIBLE or WS_SYSMENU or DS_ABSALIGN or DS_3DLOOK or DS_SETFONT or DS_MODALFRAME or DS_CENTER;
        dwExtendedStyle: 0; cdit: 5; x: 0; y:0; cx: 269; cy: 82);
    b: 0; c: 0; d: (' ', #0); e: 9; f: ('M','S',' ','S','a','n','s',' ','S','e','r','i','f',#0 {'MS Sans Serif'});
    i1: (a: (style: WS_CHILD or WS_VISIBLE or SS_ICON or SS_CENTERIMAGE;
             dwExtendedStyle: 0; x: 7; y: 7; cx: 24; cy: 24; id: $100);
         b: $FFFF; c: $0082; d: 0; e: 0; f: 0); // icon
    i2: (a: (style: WS_CHILD or WS_VISIBLE;
             dwExtendedStyle: 0; x: 40; y: 7; cx: 230; cy: 25; id: $101);
         b: $FFFF; c: $0082; d: 0; e: 0; f: 0); // static text
    i3: (a: (style: WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON;
             dwExtendedStyle: 0; x: 80; y: 39; cx: 50; cy: 14; id: IDYES);
         b: $FFFF; c: $0080; d: 0; e: 0; f: 0); // Yes button
    i4: (a: (style: WS_CHILD or WS_VISIBLE;
             dwExtendedStyle: 0; x: 133; y: 39; cx: 50; cy: 14; id: IDNO);
         b: $FFFF; c: $0080; d: 0; e: 0; f: 0); // No button
    i5: (a: (style: WS_CHILD or WS_VISIBLE or BS_CHECKBOX;
             dwExtendedStyle: 0; x: 7; y: 59; cx: 70; cy: 16; id: IDIGNORE);
         b: $FFFF; c: $0080; d: 0; e: 0; f: 0); // checkbox
  );
begin
  if DXUTGetShowMsgBoxOnError then
  begin
    // Open the appropriate registry key
    dwSkipWarning := 0;
    lResult := RegOpenKeyEx(HKEY_CURRENT_USER, 'Software\Microsoft\DirectX 9.0 SDK', 0, KEY_READ, hKey);
    if (ERROR_SUCCESS = lResult) then
    begin
      dwSize := SizeOf(DWORD);
      {lResult :=} RegQueryValueEx(hKey, 'Skip Warning On REF', nil, @dwType, PByte(@dwSkipWarning), @dwSize);
      RegCloseKey(hKey);
    end;

    if (dwSkipWarning = 0) then
    begin
      // Compact code to create a custom dialog box without using a template in a resource file.
      // If this dialog were in a .rc file, this would be a lot simpler but every sample calling this function would
      // need a copy of the dialog in its own .rc file. Also MessageBox API could be used here instead, but
      // the MessageBox API is simpler to call but it can't provide a "Don't show again" checkbox

      {$IFDEF FPC}
      nResult := DialogBoxIndirectA(DXUTGetHINSTANCE, @dtp, DXUTGetHWND, @DisplaySwitchToREFWarningProc);
      {$ELSE}
      nResult := DialogBoxIndirectA(DXUTGetHINSTANCE, PDlgTemplate(@dtp)^, DXUTGetHWND, @DisplaySwitchToREFWarningProc);
      {$ENDIF}

      if ((nResult and $80) = $80) then  // "Don't show again" checkbox was checked
      begin
        lResult := RegOpenKeyEx(HKEY_CURRENT_USER, 'Software\Microsoft\DirectX 9.0 SDK', 0, KEY_WRITE, hKey);
        if (ERROR_SUCCESS = lResult) then
        begin
          dwSkipWarning := 1;
          RegSetValueEx(hKey, 'Skip Warning On REF', 0, REG_DWORD, PByte(@dwSkipWarning), SizeOf(DWORD));
          RegCloseKey(hKey);
        end;
      end;

      // User choose not to continue
      if ((nResult and $0F) = IDNO) then DXUTShutdown(1);
    end;
  end;
end;


//--------------------------------------------------------------------------------------
// MsgProc for DXUTDisplaySwitchingToREFWarning() dialog box
//--------------------------------------------------------------------------------------
function DisplaySwitchToREFWarningProc(hDlg: HWND; message: LongWord; wParam: WPARAM; lParam: LPARAM): INT_PTR; stdcall;
begin
  case message of
    WM_INITDIALOG:
    begin
      // Easier to set text here than in the DLGITEMTEMPLATE
      SetWindowTextW(hDlg, DXUTGetWindowTitle);
      SendMessage(GetDlgItem(hDlg, $100), STM_SETIMAGE, IMAGE_ICON, LoadIcon(0, IDI_QUESTION));
      SetDlgItemText(hDlg, $101, 'Switching to the Direct3D reference rasterizer, a software device'#10'that implements the entire Direct3D feature set, but runs very slowly.'#10'Do you wish to continue?');
      SetDlgItemText(hDlg, IDYES, '&Yes');
      SetDlgItemText(hDlg, IDNO, '&No');
      SetDlgItemText(hDlg, IDIGNORE, '&Don''t show again');
    end;

    WM_COMMAND:
    begin
      case LOWORD(wParam) of
        IDIGNORE:
        begin
          if (IsDlgButtonChecked(hDlg, IDIGNORE) = BST_CHECKED)
            then CheckDlgButton(hDlg, IDIGNORE, BST_UNCHECKED)
            else CheckDlgButton(hDlg, IDIGNORE, BST_CHECKED);
          EnableWindow(GetDlgItem(hDlg, IDNO), (IsDlgButtonChecked(hDlg, IDIGNORE ) <> BST_CHECKED));
        end;
        IDNO:
        begin
          if (IsDlgButtonChecked(hDlg, IDIGNORE) = BST_CHECKED)
            then EndDialog(hDlg, IDNO or $80)
            else EndDialog(hDlg, IDNO or $00);
          Result:= iTrue;
          Exit;
        end;

        IDCANCEL, IDYES:
        begin
          if (IsDlgButtonChecked(hDlg, IDIGNORE) = BST_CHECKED)
            then EndDialog(hDlg, IDYES or $80)
            else EndDialog(hDlg, IDYES or $00);
          Result:= iTrue;
          Exit;
        end;
      end;
    end;
  end;
  Result:= iFalse;
end;


{ CDXUTTimer }

constructor CDXUTTimer.Create;
var
  qwTicksPerSec: LARGE_INTEGER;
begin
  m_bTimerStopped     := True;
  m_llQPFTicksPerSec  := 0;

  m_llStopTime        := 0;
  m_llLastElapsedTime := 0;
  m_llBaseTime        := 0;

  // Use QueryPerformanceFrequency to get the frequency of the counter
  QueryPerformanceFrequency(qwTicksPerSec.QuadPart);
  m_llQPFTicksPerSec := qwTicksPerSec.QuadPart;
end;

//--------------------------------------------------------------------------------------
procedure CDXUTTimer.Reset;
var
  qwTime: TLargeInteger;
begin
  qwTime := GetAdjustedCurrentTime;

  m_llBaseTime        := qwTime;
  m_llLastElapsedTime := qwTime;
  m_llStopTime        := 0;
  m_bTimerStopped     := False;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTTimer.Start;
var
  qwTime: TLargeInteger;
begin
  // Get the current time
  QueryPerformanceCounter(qwTime);

  if (m_bTimerStopped) then Inc(m_llBaseTime, qwTime - m_llStopTime);
  m_llStopTime := 0;
  m_llLastElapsedTime := qwTime;
  m_bTimerStopped := FALSE;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTTimer.Stop;
var
  qwTime: TLargeInteger;
begin
  if (not m_bTimerStopped) then
  begin
    QueryPerformanceCounter(qwTime);
    m_llStopTime := qwTime;
    m_llLastElapsedTime := qwTime;
    m_bTimerStopped := True;
  end;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTTimer.Advance;
begin
  Inc(m_llStopTime, m_llQPFTicksPerSec div 10);
end;


//--------------------------------------------------------------------------------------
function CDXUTTimer.GetAbsoluteTime: Double;
var
  qwTime: TLargeInteger;
  fTime: Double;
begin
  QueryPerformanceCounter(qwTime);

  fTime := qwTime / m_llQPFTicksPerSec;

  Result:= fTime;
end;


//--------------------------------------------------------------------------------------
function CDXUTTimer.GetTime: Double;
var
  qwTime: TLargeInteger;
  fAppTime: Double;
begin
  qwTime := GetAdjustedCurrentTime;

  fAppTime := (qwTime - m_llBaseTime) / m_llQPFTicksPerSec;

  Result:= fAppTime;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTTimer.GetTimeValues(out pfTime, pfAbsoluteTime: Double; out pfElapsedTime: Single);
var
  qwTime: TLargeInteger;
  fElapsedTime: Single;
begin
  qwTime := GetAdjustedCurrentTime;

  fElapsedTime := (qwTime - m_llLastElapsedTime) / m_llQPFTicksPerSec;
  m_llLastElapsedTime := qwTime;

  // Clamp the timer to non-negative values to ensure the timer is accurate.
  // fElapsedTime can be outside this range if processor goes into a
  // power save mode or we somehow get shuffled to another processor.
  // However, the main thread should call SetThreadAffinityMask to ensure that
  // we don't get shuffled to another processor.  Other worker threads should NOT call
  // SetThreadAffinityMask, but use a shared copy of the timer data gathered from
  // the main thread.
  if (fElapsedTime < 0.0) then fElapsedTime := 0.0;

  pfAbsoluteTime := qwTime / m_llQPFTicksPerSec;
  pfTime := (qwTime - m_llBaseTime) / m_llQPFTicksPerSec;
  pfElapsedTime := fElapsedTime;
end;


//--------------------------------------------------------------------------------------
function CDXUTTimer.GetElapsedTime: Double;
var
  qwTime: TLargeInteger;
  fElapsedTime: Double;
begin
  qwTime := GetAdjustedCurrentTime;

  fElapsedTime := (qwTime - m_llLastElapsedTime) / m_llQPFTicksPerSec;
  m_llLastElapsedTime := qwTime;

  // See the explanation about clamping in CDXUTTimer::GetTimeValues()
  if (fElapsedTime < 0.0) then fElapsedTime := 0.0;

  Result:= fElapsedTime;
end;


//--------------------------------------------------------------------------------------
// If stopped, returns time when stopped otherwise returns current time
//--------------------------------------------------------------------------------------
function CDXUTTimer.GetAdjustedCurrentTime: TLargeInteger;
var
  qwTime: TLargeInteger;
begin
  if (m_llStopTime <> 0)
  then qwTime := m_llStopTime
  else QueryPerformanceCounter(qwTime);

  Result:= qwTime;
end;


//--------------------------------------------------------------------------------------
//Clootie: Changed to property
{function CDXUTTimer.IsStopped: Boolean;
begin
  Result:= m_bTimerStopped;
end;}



var {static} s_strMediaSearchPath: array[0..MAX_PATH-1] of WideChar;

//--------------------------------------------------------------------------------------
// Returns pointer to static media search buffer
//--------------------------------------------------------------------------------------
function DXUTMediaSearchPath: PWideChar;
begin
  Result:= s_strMediaSearchPath;
end;


//--------------------------------------------------------------------------------------
function DXUTGetMediaSearchPath: PWideChar;
begin
  Result:= DXUTMediaSearchPath;
end;


//--------------------------------------------------------------------------------------
function DXUTSetMediaSearchPath(strPath: PWideChar): HRESULT;
var
  s_strSearchPath: PWideChar;
  ch: size_t;
begin
  s_strSearchPath := DXUTMediaSearchPath;

  Result := StringCchCopy(s_strSearchPath, MAX_PATH, strPath);
  if SUCCEEDED(Result) then
  begin
    // append slash if needed
    Result := StringCchLength(s_strSearchPath, MAX_PATH, ch);
    if SUCCEEDED(Result) and (s_strSearchPath[ch-1] <> '\') then
    begin
      Result := StringCchCat(s_strSearchPath, MAX_PATH, '\'#0); //Clootie: FPC compatibility
    end;
  end;
end;



//--------------------------------------------------------------------------------------
// Tries to find the location of a SDK media file
//       cchDest is the size in WCHARs of strDestPath.  Be careful not to
//       pass in sizeof(strDest) on UNICODE builds.
//--------------------------------------------------------------------------------------

{$IFNDEF FPC}
function DXUTFindDXSDKMediaFile(strDestPath: PWideChar; cchDest: Integer; const strFilename: WideString): HRESULT;
begin
  Result:= DXUTFindDXSDKMediaFile(strDestPath, cchDest, PWideChar(strFilename));
end;

{$ENDIF}
function DXUTFindDXSDKMediaFile(strDestPath: PWideChar; cchDest: Integer; const strFilename: PWideChar): HRESULT;
var
  W: WideString;
begin
  Result:= DXUTFindDXSDKMediaFile(W, strFilename);
  lstrcpynW(strDestPath, PWideChar(W), cchDest);
  strDestPath[cchDest-1] := #0;
end;

{$IFNDEF FPC}
function DXUTFindDXSDKMediaFile(out strDestPath: WideString; const strFilename: WideString): HRESULT;
begin
  Result:= DXUTFindDXSDKMediaFile(strDestPath, PWideChar(strFilename));
end;

{$ENDIF}
function DXUTFindDXSDKMediaFile(out strDestPath: WideString; const strFilename: PWideChar): HRESULT;
var
  bFound: Boolean;
  strSearchFor, strExePath, strExeName: WideString;
  strLastSlash: PWideChar;
  strLeafName: WideString;
begin
  Result:= S_OK;

  if (strFilename = nil) or (strFilename[0] = #0) then
  begin
    Result:= E_INVALIDARG;
    Exit;
  end;

  // Get the exe name, and exe path
  SetLength(strExePath, MAX_PATH);
  GetModuleFileNameW(0, PWideChar(strExePath), MAX_PATH);
  strExePath[MAX_PATH] := #0;
  strLastSlash:= WideStrRScan(PWideChar(strExePath), '\');
  if (strLastSlash <> nil) then
  begin
    strExeName := Copy(WideString(strLastSlash), 2, MAX_PATH);

    // Chop the exe name from the exe path
    strLastSlash^ := #0;

    // Chop the .exe from the exe name
    strLastSlash:= WideStrRScan(PWideChar(strExeName), '.');
    if (strLastSlash <> nil) then
    begin
      SetLength(strExeName, Integer(strLastSlash - Pointer(strExeName))); // strLastSlash^ := #0;
    end;
  end;
  SetLength(strExePath, lstrlenW(PWideChar(strExePath)));

  // Typical directories:
  //      .\
  //      ..\
  //      ..\..\
  //      %EXE_DIR%\
  //      %EXE_DIR%\..\
  //      %EXE_DIR%\..\..\
  //      %EXE_DIR%\..\%EXE_NAME%
  //      %EXE_DIR%\..\..\%EXE_NAME%

  // Typical directory search
  bFound := DXUTFindMediaSearchTypicalDirs(strDestPath, strFilename, strExePath, strExeName);
  if bFound then Exit;

  // Typical directory search again, but also look in a subdir called "\media\"
  strSearchFor:= WideFormat('media\%s', [strFilename]);
  bFound := DXUTFindMediaSearchTypicalDirs(strDestPath, strSearchFor, strExePath, strExeName);
  if bFound then Exit;

  // Search all parent directories starting at .\ and using strFilename as the leaf name
  strLeafName:= strFilename;
  bFound := DXUTFindMediaSearchParentDirs(strDestPath, '.', strLeafName);
  if bFound then Exit;

  // Search all parent directories starting at the exe's dir and using strFilename as the leaf name
  bFound := DXUTFindMediaSearchParentDirs(strDestPath, strExePath, strLeafName);
  if bFound then Exit;

  // Search all parent directories starting at .\ and using "media\strFilename" as the leaf name
  strLeafName := Format('media\%s', [strFilename]);
  bFound := DXUTFindMediaSearchParentDirs(strDestPath, '.', strLeafName);
  if bFound then Exit;

  // Search all parent directories starting at the exe's dir and using "media\strFilename" as the leaf name
  bFound := DXUTFindMediaSearchParentDirs(strDestPath, strExePath, strLeafName);
  if bFound then Exit;

  // On failure, return the file as the path but also return an error code
  strDestPath:= strFilename;
  Result:= DXUTERR_MEDIANOTFOUND;
end;



//--------------------------------------------------------------------------------------
// Search a set of typical directories
//--------------------------------------------------------------------------------------
function DXUTFindMediaSearchTypicalDirs(out strSearchPath: WideString;
  strLeaf, strExePath, strExeName: WideString): Boolean;
var
  s_strSearchPath: PWideChar;  
begin
  Result:= True;

  // Typical directories:
  //      .\
  //      ..\
  //      ..\..\
  //      %EXE_DIR%\
  //      %EXE_DIR%\..\
  //      %EXE_DIR%\..\..\
  //      %EXE_DIR%\..\%EXE_NAME%
  //      %EXE_DIR%\..\..\%EXE_NAME%
  //      DXSDK media path

  // Search in .\
  strSearchPath:= strLeaf;
  if GetFileAttributesW(PWideChar(strSearchPath)) <> $FFFFFFFF then Exit;

  // Search in ..\
  strSearchPath:= WideFormat('..\%s', [strLeaf]);
  if GetFileAttributesW(PWideChar(strSearchPath)) <> $FFFFFFFF then Exit;

  // Search in ..\..\
  strSearchPath:= WideFormat('..\..\%s', [strLeaf]);
  if GetFileAttributesW(PWideChar(strSearchPath)) <> $FFFFFFFF then Exit;

  // Search in ..\..\
  strSearchPath:= WideFormat('..\..\%s', [strLeaf]);
  if GetFileAttributesW(PWideChar(strSearchPath)) <> $FFFFFFFF then Exit;

  // Search in the %EXE_DIR%\
  strSearchPath:= WideFormat('%s\%s', [strExePath, strLeaf]);
  if GetFileAttributesW(PWideChar(strSearchPath)) <> $FFFFFFFF then Exit;

  // Search in the %EXE_DIR%\..\
  strSearchPath:= WideFormat('%s\..\%s', [strExePath, strLeaf]);
  if GetFileAttributesW(PWideChar(strSearchPath)) <> $FFFFFFFF then Exit;

  // Search in the %EXE_DIR%\..\..\
  strSearchPath:= WideFormat('%s\..\..\%s', [strExePath, strLeaf]);
  if GetFileAttributesW(PWideChar(strSearchPath)) <> $FFFFFFFF then Exit;

  // Search in "%EXE_DIR%\..\%EXE_NAME%\".  This matches the DirectX SDK layout
  strSearchPath:= WideFormat('%s\..\%s\%s', [strExePath, strExeName, strLeaf]);
  if GetFileAttributesW(PWideChar(strSearchPath)) <> $FFFFFFFF then Exit;

  // Search in "%EXE_DIR%\..\..\%EXE_NAME%\".  This matches the DirectX SDK layout
  strSearchPath:= WideFormat('%s\..\..\%s\%s', [strExePath, strExeName, strLeaf]);
  if GetFileAttributesW(PWideChar(strSearchPath)) <> $FFFFFFFF then Exit;

  // Search in media search dir
  s_strSearchPath := DXUTMediaSearchPath;
  if (s_strSearchPath[0] <> #0) then
  begin
    strSearchPath:= WideFormat('%s%s', [s_strSearchPath, strLeaf]);
    if GetFileAttributesW(PWideChar(strSearchPath)) <> $FFFFFFFF then Exit;
  end;

  Result:= False;
end;



//--------------------------------------------------------------------------------------
// Search parent directories starting at strStartAt, and appending strLeafName
// at each parent directory.  It stops at the root directory.
//--------------------------------------------------------------------------------------
function DXUTFindMediaSearchParentDirs(out strSearchPath: WideString; strStartAt, strLeafName: WideString): Boolean;
var
  strFullPath, strFullFileName, strSearch: WideString;
  strFilePart: PWideChar;
begin
  Result:= False;
  strFilePart:= nil;
  SetLength(strFullPath, MAX_PATH);
  GetFullPathNameW(PWideChar(strStartAt), MAX_PATH, PWideChar(strFullPath), strFilePart);
  SetLength(strFullPath, lstrlenW(PWideChar(strFullPath)));
  if (strFilePart = nil) then Exit;

  while (strFilePart <> nil) and (strFilePart^ <> #0) do
  begin
    strFullFileName:= WideFormat('%s\%s', [strFullPath, strLeafName]);
    if (GetFileAttributesW(PWideChar(strFullFileName)) <> $FFFFFFFF) then
    begin
      strSearchPath:= strFullFileName;
      Result:= True;
      Exit;
    end;

    strSearch:= WideFormat('%s\..', [strFullPath]);
    SetLength(strFullPath, MAX_PATH);
    GetFullPathNameW(PWideChar(strSearch), MAX_PATH, PWideChar(strFullPath), strFilePart);
    SetLength(strFullPath, lstrlenW(PWideChar(strFullPath)));
  end;
end;


//--------------------------------------------------------------------------------------
// CDXUTResourceCache
//--------------------------------------------------------------------------------------

{ CDXUTResourceCache }

constructor CDXUTResourceCache.Create;
begin
  { do nothing }
end;

destructor CDXUTResourceCache.Destroy;
begin
  OnDestroyDevice;

  m_TextureCache:= nil; // RemoveAll;
  m_EffectCache:= nil; // RemoveAll;
  m_FontCache:= nil; // RemoveAll;
  inherited;
end;

//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateTextureFromFile(pDevice: IDirect3DDevice9; pSrcFile: PWideChar; out ppTexture: IDirect3DTexture9): HRESULT;
begin
  Result:= CreateTextureFromFileEx(pDevice, pSrcFile, D3DX_DEFAULT, D3DX_DEFAULT, D3DX_DEFAULT,
                                   0, D3DFMT_UNKNOWN, D3DPOOL_MANAGED, D3DX_DEFAULT, D3DX_DEFAULT,
                                   0, nil, nil, ppTexture);
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateTextureFromFileEx(pDevice: IDirect3DDEVICE9; pSrcFile: PWideChar;
      Width, Height, MipLevels: LongWord; Usage: DWORD; Format: TD3DFormat;
      Pool: TD3DPool; Filter, MipFilter: DWORD; ColorKey: TD3DColor;
      pSrcInfo: PD3DXImageInfo; pPalette: PPaletteEntry; out ppTexture: IDirect3DTexture9): HRESULT;
var
  i: Integer;
  Entry: PDXUTCacheTexture;
  NewEntry: TDXUTCacheTexture;
begin
  // Search the cache for a matching entry.
  for i := 0 to Length(m_TextureCache) - 1 do
  begin
    Entry := @m_TextureCache[i];
    if (Entry.Location = DXUTCACHE_LOCATION_FILE) and
       (lstrcmpW(Entry.wszSource, pSrcFile) = 0) and
       (Entry.Width = Width) and
       (Entry.Height = Height) and
       (Entry.MipLevels = MipLevels) and
       (Entry.Usage = Usage) and
       (Entry.Format = Format) and
       (Entry.Pool = Pool) and
       (Entry._Type = D3DRTYPE_TEXTURE) then
    begin
      // A match is found. Obtain the IDirect3DTexture9 interface and return that.
      Result:= Entry.pTexture.QueryInterface(IID_IDirect3DTexture9, ppTexture);
      Exit;
    end;
  end;

  // No matching entry.  Load the resource and create a new entry.

  Result := D3DXCreateTextureFromFileExW(pDevice, pSrcFile,
              Width, Height, MipLevels, Usage, Format,
              Pool, Filter, MipFilter, ColorKey, pSrcInfo, pPalette, ppTexture);
  if FAILED(Result) then Exit;

  NewEntry.Location := DXUTCACHE_LOCATION_FILE;
  StringCchCopy(NewEntry.wszSource, MAX_PATH, pSrcFile);
  NewEntry.Width := Width;
  NewEntry.Height := Height;
  NewEntry.MipLevels := MipLevels;
  NewEntry.Usage := Usage;
  NewEntry.Format := Format;
  NewEntry.Pool := Pool;
  NewEntry._Type := D3DRTYPE_TEXTURE;
  ppTexture.QueryInterface(IID_IDirect3DBaseTexture9, NewEntry.pTexture);

  // m_TextureCache.Add(NewEntry);
  i:= Length(m_TextureCache);
  SetLength(m_TextureCache, i+1);
  m_TextureCache[i]:= NewEntry;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateTextureFromResource(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar; ppTexture: IDirect3DTexture9): HRESULT;
begin
  Result:= CreateTextureFromResourceEx(pDevice, hSrcModule, pSrcResource, D3DX_DEFAULT, D3DX_DEFAULT,
                                       D3DX_DEFAULT, 0, D3DFMT_UNKNOWN, D3DPOOL_MANAGED, D3DX_DEFAULT,
                                       D3DX_DEFAULT, 0, nil, nil, ppTexture);
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateTextureFromResourceEx(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar;
  Width, Height, MipLevels: LongWord; Usage: DWORD; Format: TD3DFormat;
  Pool: TD3DPool; Filter, MipFilter: DWORD; ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo; pPalette: PPaletteEntry; out ppTexture: IDirect3DTexture9): HRESULT;
var
  i: Integer;
  Entry: PDXUTCacheTexture;
  NewEntry: TDXUTCacheTexture;
begin
  // Search the cache for a matching entry.
  for i := 0 to Length(m_TextureCache) - 1 do
  begin
    Entry := @m_TextureCache[i];
    if (Entry.Location = DXUTCACHE_LOCATION_RESOURCE) and
       (Entry.hSrcModule = hSrcModule) and
       (lstrcmpW(Entry.wszSource, pSrcResource) = 0) and
       (Entry.Width = Width) and
       (Entry.Height = Height) and
       (Entry.MipLevels = MipLevels) and
       (Entry.Usage = Usage) and
       (Entry.Format = Format) and
       (Entry.Pool = Pool) and
       (Entry._Type = D3DRTYPE_TEXTURE) then
    begin
      // A match is found. Obtain the IDirect3DTexture9 interface and return that.
      Result:= Entry.pTexture.QueryInterface(IID_IDirect3DTexture9, ppTexture);
      Exit;
    end;
  end;

  // No matching entry.  Load the resource and create a new entry.
  Result := D3DXCreateTextureFromResourceExW(pDevice, hSrcModule, pSrcResource,
              Width, Height, MipLevels, Usage, Format,
              Pool, Filter, MipFilter, ColorKey, pSrcInfo, pPalette, ppTexture);
  if FAILED(Result) then Exit;

  NewEntry.Location := DXUTCACHE_LOCATION_RESOURCE;
  NewEntry.hSrcModule := hSrcModule;
  StringCchCopy(NewEntry.wszSource, MAX_PATH, pSrcResource);
  NewEntry.Width := Width;
  NewEntry.Height := Height;
  NewEntry.MipLevels := MipLevels;
  NewEntry.Usage := Usage;
  NewEntry.Format := Format;
  NewEntry.Pool := Pool;
  NewEntry._Type := D3DRTYPE_TEXTURE;
  ppTexture.QueryInterface(IID_IDirect3DBaseTexture9, NewEntry.pTexture);

  // m_TextureCache.Add(NewEntry);
  i:= Length(m_TextureCache);
  SetLength(m_TextureCache, i+1);
  m_TextureCache[i]:= NewEntry;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateCubeTextureFromFile(pDevice: IDirect3DDevice9; pSrcFile: PWideChar; out ppCubeTexture: IDirect3DCubeTexture9): HRESULT;
begin
  Result:= CreateCubeTextureFromFileEx(pDevice, pSrcFile, D3DX_DEFAULT, D3DX_DEFAULT, 0,
                                       D3DFMT_UNKNOWN, D3DPOOL_MANAGED, D3DX_DEFAULT, D3DX_DEFAULT,
                                       0, nil, nil, ppCubeTexture);
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateCubeTextureFromFileEx(pDevice: IDirect3DDevice9; pSrcFile: PWideChar;
  Size, MipLevels: LongWord; Usage: DWORD; Format: TD3DFormat;
  Pool: TD3DPool; Filter, MipFilter: DWORD; ColorKey: TD3DColor;
  pSrcInfo: PD3DXImageInfo; pPalette: PPaletteEntry; out ppCubeTexture: IDirect3DCubeTexture9): HRESULT;
var
  i: Integer;
  Entry: PDXUTCacheTexture;
  NewEntry: TDXUTCacheTexture;
begin
  // Search the cache for a matching entry.
  for i := 0 to Length(m_TextureCache) - 1 do
  begin
    Entry := @m_TextureCache[i];
    if (Entry.Location = DXUTCACHE_LOCATION_FILE) and
       (lstrcmpW(Entry.wszSource, pSrcFile) = 0) and
       (Entry.Width = Size) and
       (Entry.MipLevels = MipLevels) and
       (Entry.Usage = Usage) and
       (Entry.Format = Format) and
       (Entry.Pool = Pool) and
       (Entry._Type = D3DRTYPE_TEXTURE) then
    begin
      // A match is found. Obtain the IDirect3DCubeTexture9 interface and return that.
      Result:= Entry.pTexture.QueryInterface(IID_IDirect3DCubeTexture9, ppCubeTexture);
      Exit;
    end;
  end;

  // No matching entry.  Load the resource and create a new entry.
  Result := D3DXCreateCubeTextureFromFileExW(pDevice, pSrcFile, Size, MipLevels, Usage, Format, Pool, Filter,
                                             MipFilter, ColorKey, pSrcInfo, pPalette, ppCubeTexture);
  if FAILED(Result) then Exit;

  NewEntry.Location := DXUTCACHE_LOCATION_FILE;
  StringCchCopy(NewEntry.wszSource, MAX_PATH, pSrcFile);
  NewEntry.Width := Size;
  NewEntry.MipLevels := MipLevels;
  NewEntry.Usage := Usage;
  NewEntry.Format := Format;
  NewEntry.Pool := Pool;
  NewEntry._Type := D3DRTYPE_CUBETEXTURE;
  ppCubeTexture.QueryInterface(IID_IDirect3DBaseTexture9, NewEntry.pTexture);

  // m_TextureCache.Add(NewEntry);
  i:= Length(m_TextureCache);
  SetLength(m_TextureCache, i+1);
  m_TextureCache[i]:= NewEntry;
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateCubeTextureFromResource(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar; out ppCubeTexture: IDirect3DCubeTexture9): HRESULT;
begin
  Result:= CreateCubeTextureFromResourceEx(pDevice, hSrcModule, pSrcResource, D3DX_DEFAULT, D3DX_DEFAULT,
                                           0, D3DFMT_UNKNOWN, D3DPOOL_MANAGED, D3DX_DEFAULT, D3DX_DEFAULT,
                                           0, nil, nil, ppCubeTexture);
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateCubeTextureFromResourceEx(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar;
      Size, MipLevels: LongWord; Usage: DWORD; Format: TD3DFormat;
      Pool: TD3DPool; Filter, MipFilter: DWORD; ColorKey: TD3DColor;
      pSrcInfo: PD3DXImageInfo; pPalette: PPaletteEntry; out ppCubeTexture: IDirect3DCubeTexture9): HRESULT;
var
  i: Integer;
  Entry: PDXUTCacheTexture;
  NewEntry: TDXUTCacheTexture;
begin
  // Search the cache for a matching entry.
  for i := 0 to Length(m_TextureCache) - 1 do
  begin
    Entry := @m_TextureCache[i];
    if (Entry.Location = DXUTCACHE_LOCATION_RESOURCE) and
       (Entry.hSrcModule = hSrcModule) and
       (lstrcmpW(Entry.wszSource, pSrcResource) = 0) and
       (Entry.Width = Size) and
       (Entry.MipLevels = MipLevels) and
       (Entry.Usage = Usage) and
       (Entry.Format = Format) and
       (Entry.Pool = Pool) and
       (Entry._Type = D3DRTYPE_TEXTURE) then
    begin
      // A match is found. Obtain the IDirect3DCubeTexture9 interface and return that.
      Result:= Entry.pTexture.QueryInterface(IID_IDirect3DCubeTexture9, ppCubeTexture);
      Exit;
    end;
  end;

  // No matching entry.  Load the resource and create a new entry.
  Result := D3DXCreateCubeTextureFromResourceExW(pDevice, hSrcModule, pSrcResource, Size, MipLevels, Usage, Format,
                                                 Pool, Filter, MipFilter, ColorKey, pSrcInfo, pPalette, ppCubeTexture);
  if FAILED(Result) then Exit;

  NewEntry.Location := DXUTCACHE_LOCATION_RESOURCE;
  NewEntry.hSrcModule := hSrcModule;
  StringCchCopy(NewEntry.wszSource, MAX_PATH, pSrcResource);
  NewEntry.Width := Size;
  NewEntry.MipLevels := MipLevels;
  NewEntry.Usage := Usage;
  NewEntry.Format := Format;
  NewEntry.Pool := Pool;
  NewEntry._Type := D3DRTYPE_CUBETEXTURE;
  ppCubeTexture.QueryInterface(IID_IDirect3DBaseTexture9, NewEntry.pTexture);

  // m_TextureCache.Add(NewEntry);
  i:= Length(m_TextureCache);
  SetLength(m_TextureCache, i+1);
  m_TextureCache[i]:= NewEntry;
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateVolumeTextureFromFile(pDevice: IDirect3DDevice9; pSrcFile: PWideChar; out ppVolumeTexture: IDirect3DVolumeTexture9): HRESULT;
begin
  Result:= CreateVolumeTextureFromFileEx(pDevice, pSrcFile, D3DX_DEFAULT, D3DX_DEFAULT, D3DX_DEFAULT, D3DX_DEFAULT,
                                         0, D3DFMT_UNKNOWN, D3DPOOL_MANAGED, D3DX_DEFAULT, D3DX_DEFAULT,
                                         0, nil, nil, ppVolumeTexture);
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateVolumeTextureFromFileEx(pDevice: IDirect3DDevice9; pSrcFile: PWideChar;
      Width, Height, Depth, MipLevels: LongWord; Usage: DWORD; Format: TD3DFormat;
      Pool: TD3DPool; Filter, MipFilter: DWORD; ColorKey: TD3DColor;
      pSrcInfo: PD3DXImageInfo; pPalette: PPaletteEntry; out ppTexture: IDirect3DVolumeTexture9): HRESULT;
var
  i: Integer;
  Entry: PDXUTCacheTexture;
  NewEntry: TDXUTCacheTexture;
begin
  // Search the cache for a matching entry.
  for i := 0 to Length(m_TextureCache) - 1 do
  begin
    Entry := @m_TextureCache[i];
    if (Entry.Location = DXUTCACHE_LOCATION_FILE) and
       (lstrcmpW(Entry.wszSource, pSrcFile) = 0) and
       (Entry.Width = Width) and
       (Entry.Height = Height) and
       (Entry.Depth = Depth) and
       (Entry.MipLevels = MipLevels) and
       (Entry.Usage = Usage) and
       (Entry.Format = Format) and
       (Entry.Pool = Pool) and
       (Entry._Type = D3DRTYPE_TEXTURE) then
    begin
      // A match is found. Obtain the IDirect3DVolumeTexture9 interface and return that.
      Result:= Entry.pTexture.QueryInterface(IID_IDirect3DVolumeTexture9, ppTexture);
      Exit;
    end;
  end;

  // No matching entry.  Load the resource and create a new entry.
  Result := D3DXCreateVolumeTextureFromFileExW(pDevice, pSrcFile, Width, Height, Depth, MipLevels, Usage, Format,
                                               Pool, Filter, MipFilter, ColorKey, pSrcInfo, pPalette, ppTexture);
  if FAILED(Result) then Exit;

  NewEntry.Location := DXUTCACHE_LOCATION_FILE;
  StringCchCopy(NewEntry.wszSource, MAX_PATH, pSrcFile);
  NewEntry.Width := Width;
  NewEntry.Height := Height;
  NewEntry.Depth := Depth;
  NewEntry.MipLevels := MipLevels;
  NewEntry.Usage := Usage;
  NewEntry.Format := Format;
  NewEntry.Pool := Pool;
  NewEntry._Type := D3DRTYPE_VOLUMETEXTURE;
  ppTexture.QueryInterface(IID_IDirect3DBaseTexture9, NewEntry.pTexture);

  // m_TextureCache.Add(NewEntry);
  i:= Length(m_TextureCache);
  SetLength(m_TextureCache, i+1);
  m_TextureCache[i]:= NewEntry;
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateVolumeTextureFromResource(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar; out ppVolumeTexture: IDirect3DVolumeTexture9): HRESULT;
begin
  Result:= CreateVolumeTextureFromResourceEx(pDevice, hSrcModule, pSrcResource, D3DX_DEFAULT, D3DX_DEFAULT,
                                             D3DX_DEFAULT, D3DX_DEFAULT, 0, D3DFMT_UNKNOWN, D3DPOOL_MANAGED,
                                             D3DX_DEFAULT, D3DX_DEFAULT, 0, nil, nil, ppVolumeTexture);
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateVolumeTextureFromResourceEx(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar;
      Width, Height, Depth, MipLevels: LongWord; Usage: DWORD; Format: TD3DFormat;
      Pool: TD3DPool; Filter, MipFilter: DWORD; ColorKey: TD3DColor;
      pSrcInfo: PD3DXImageInfo; pPalette: PPaletteEntry; out ppVolumeTexture: IDirect3DVolumeTexture9): HRESULT;
var
  i: Integer;
  Entry: PDXUTCacheTexture;
  NewEntry: TDXUTCacheTexture;
begin
  // Search the cache for a matching entry.
  for i := 0 to Length(m_TextureCache) - 1 do
  begin
    Entry := @m_TextureCache[i];
    if (Entry.Location = DXUTCACHE_LOCATION_RESOURCE) and
       (Entry.hSrcModule = hSrcModule) and
       (lstrcmpW(Entry.wszSource, pSrcResource) = 0) and
       (Entry.Width = Width) and
       (Entry.Height = Height) and
       (Entry.Depth = Depth) and
       (Entry.MipLevels = MipLevels) and
       (Entry.Usage = Usage) and
       (Entry.Format = Format) and
       (Entry.Pool = Pool) and
       (Entry._Type = D3DRTYPE_VOLUMETEXTURE) then
    begin
      // A match is found. Obtain the IDirect3DVolumeTexture9 interface and return that.
      Result:= Entry.pTexture.QueryInterface(IID_IDirect3DVolumeTexture9, ppVolumeTexture);
      Exit;
    end;
  end;

  // No matching entry.  Load the resource and create a new entry.
  Result := D3DXCreateVolumeTextureFromResourceExW(pDevice, hSrcModule, pSrcResource, Width, Height, Depth, MipLevels, Usage,
                                                   Format, Pool, Filter, MipFilter, ColorKey, pSrcInfo, pPalette, ppVolumeTexture);
  if FAILED(Result) then Exit;

  NewEntry.Location := DXUTCACHE_LOCATION_RESOURCE;
  NewEntry.hSrcModule := hSrcModule;
  StringCchCopy(NewEntry.wszSource, MAX_PATH, pSrcResource);
  NewEntry.Width := Width;
  NewEntry.Height := Height;
  NewEntry.Depth := Depth;
  NewEntry.MipLevels := MipLevels;
  NewEntry.Usage := Usage;
  NewEntry.Format := Format;
  NewEntry.Pool := Pool;
  NewEntry._Type := D3DRTYPE_VOLUMETEXTURE;
  ppVolumeTexture.QueryInterface(IID_IDirect3DBaseTexture9, NewEntry.pTexture);

  // m_TextureCache.Add(NewEntry);
  i:= Length(m_TextureCache);
  SetLength(m_TextureCache, i+1);
  m_TextureCache[i]:= NewEntry;
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateFont(pDevice: IDirect3DDevice9;
      Height, Width, Weight, MipLevels: LongWord; Italic: BOOL;
      CharSet, OutputPrecision, Quality, PitchAndFamily: Byte;
      pFacename: PWideChar; out ppFont: ID3DXFont): HRESULT;
var
  Desc: TD3DXFontDescW;
begin
  Desc.Height := Height;
  Desc.Width := Width;
  Desc.Weight := Weight;
  Desc.MipLevels := MipLevels;
  Desc.Italic := Italic;
  Desc.CharSet := CharSet;
  Desc.OutputPrecision := OutputPrecision;
  Desc.Quality := Quality;
  Desc.PitchAndFamily := PitchAndFamily;
  StringCchCopy(Desc.FaceName, LF_FACESIZE, pFacename);

  Result:= CreateFontIndirect(pDevice, Desc, ppFont);
end;



//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateFontIndirect(pDevice: IDirect3DDevice9; const pDesc: TD3DXFontDescW; out ppFont: ID3DXFont): HRESULT;
var
  i: Integer;
  Entry: TDXUTCacheFont;
  NewEntry: TDXUTCacheFont;
begin
  // Search the cache for a matching entry.
  for i := 0 to Length(m_FontCache) - 1 do
  begin
    Entry := m_FontCache[i];

    if (Entry.Width = pDesc.Width) and
       (Entry.Height = pDesc.Height) and
       (Entry.Weight = pDesc.Weight) and
       (Entry.MipLevels = pDesc.MipLevels) and
       (Entry.Italic = pDesc.Italic) and
       (Entry.CharSet = pDesc.CharSet) and
       (Entry.OutputPrecision = pDesc.OutputPrecision) and
       (Entry.Quality = pDesc.Quality) and
       (Entry.PitchAndFamily = pDesc.PitchAndFamily) and
       (CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                       Entry.FaceName, -1,
                       pDesc.FaceName, -1) = CSTR_EQUAL) then
    begin
      // A match is found.  Increment the reference and return the ID3DXFont object.
      // Entry.pFont->AddRef();
      ppFont := Entry.pFont;
      Result:= S_OK;
      Exit;
    end;
  end;

  // No matching entry.  Load the resource and create a new entry.
  Result := D3DXCreateFontIndirectW(pDevice, pDesc, ppFont);
  if FAILED(Result) then Exit;

  PD3DXFontDescW(@NewEntry)^ := pDesc;
  NewEntry.pFont := ppFont;
  // NewEntry.pFont.AddRef;

  // m_FontCache.Add(NewEntry);
  i:= Length(m_FontCache);
  SetLength(m_FontCache, i+1);
  m_FontCache[i]:= NewEntry;
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateEffectFromFile(pDevice: IDirect3DDevice9; pSrcFile: PWideChar;
      const pDefines: PD3DXMacro; pInclude: ID3DXInclude; Flags: DWORD;
      pPool: ID3DXEffectPool; out ppEffect: ID3DXEffect; ppCompilationErrors: PID3DXBuffer): HRESULT;
var
  i: Integer;
  Entry: TDXUTCacheEffect;
  NewEntry: TDXUTCacheEffect;
begin
  // Search the cache for a matching entry.
  for i := 0 to Length(m_EffectCache) - 1 do
  begin
   Entry := m_EffectCache[i];

   if (Entry.Location = DXUTCACHE_LOCATION_FILE) and
      (lstrcmpW(Entry.wszSource, pSrcFile) = 0) and
      (Entry.dwFlags = Flags) then
   begin
     // A match is found.  Increment the ref coutn and return the ID3DXEffect object.
     ppEffect := Entry.pEffect;
     // ppEffect.AddRef;
     Result:= S_OK;
     Exit;
   end;
  end;

  // No matching entry.  Load the resource and create a new entry.
  Result := D3DXCreateEffectFromFileW(pDevice, pSrcFile, pDefines, pInclude, Flags, pPool, ppEffect, ppCompilationErrors);
  if FAILED(Result) then Exit;

  NewEntry.Location := DXUTCACHE_LOCATION_FILE;
  StringCchCopy(NewEntry.wszSource, MAX_PATH, pSrcFile);
  NewEntry.dwFlags := Flags;
  NewEntry.pEffect := ppEffect;
  // NewEntry.pEffect.AddRef;

  // m_EffectCache.Add(NewEntry);
  i:= Length(m_EffectCache);
  SetLength(m_EffectCache, i+1);
  m_EffectCache[i]:= NewEntry;
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.CreateEffectFromResource(pDevice: IDirect3DDevice9; hSrcModule: HMODULE; pSrcResource: PWideChar;
      const pDefines: PD3DXMacro; pInclude: ID3DXInclude; Flags: DWORD;
      pPool: ID3DXEffectPool; out ppEffect: ID3DXEffect; ppCompilationErrors: PID3DXBuffer): HRESULT;
var
  i: Integer;
  Entry: TDXUTCacheEffect;
  NewEntry: TDXUTCacheEffect;
begin
  // Search the cache for a matching entry.
  for i := 0 to Length(m_EffectCache) - 1 do
  begin
   Entry := m_EffectCache[i];

   if (Entry.Location = DXUTCACHE_LOCATION_RESOURCE) and
      (Entry.hSrcModule = hSrcModule) and
      (lstrcmpW(Entry.wszSource, pSrcResource) = 0) and
      (Entry.dwFlags = Flags) then
   begin
     // A match is found.  Increment the ref coutn and return the ID3DXEffect object.
     ppEffect := Entry.pEffect;
     // (*ppEffect).AddRef;
     Result:= S_OK;
     Exit;
   end;
  end;

  // No matching entry.  Load the resource and create a new entry.
  Result := D3DXCreateEffectFromResourceW(pDevice, hSrcModule, pSrcResource, pDefines, pInclude, Flags,
                                          pPool, ppEffect, ppCompilationErrors);
  if FAILED(Result) then Exit;

  NewEntry.Location := DXUTCACHE_LOCATION_RESOURCE;
  NewEntry.hSrcModule := hSrcModule;
  StringCchCopy(NewEntry.wszSource, MAX_PATH, pSrcResource);
  NewEntry.dwFlags := Flags;
  NewEntry.pEffect := ppEffect;
  // NewEntry.pEffect.AddRef;

  //m_EffectCache.Add(NewEntry);
  i:= Length(m_EffectCache);
  SetLength(m_EffectCache, i+1);
  m_EffectCache[i]:= NewEntry;
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Device event callbacks
//--------------------------------------------------------------------------------------


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.OnCreateDevice(pd3dDevice: IDirect3DDevice9): HResult;
begin
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.OnResetDevice(pd3dDevice: IDirect3DDevice9): HResult;
var
  i: Integer;
begin
  // Call OnResetDevice on all effect and font objects
  for i := 0 to Length(m_EffectCache) - 1 do
    m_EffectCache[i].pEffect.OnResetDevice;
  for i := 0 to Length(m_FontCache) - 1 do
    m_FontCache[i].pFont.OnResetDevice;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.OnLostDevice: HResult;
var
  i, l: Integer;
  m_TextureCacheCopy: TDXUTCacheTextureArray; // array of TDXUTCacheTexture;
begin
  // Call OnLostDevice on all effect and font objects
  for i := 0 to Length(m_EffectCache) - 1 do
    m_EffectCache[i].pEffect.OnLostDevice;
  for i := 0 to Length(m_FontCache) - 1 do
    m_FontCache[i].pFont.OnLostDevice;

  // Release all the default pool textures
  {//Clootie: This was direct C++ conversion...
  for i := Length(m_TextureCache) - 1 downto 0 do
    if (m_TextureCache[i].Pool = D3DPOOL_DEFAULT) then
    begin
      SAFE_RELEASE(m_TextureCache[i].pTexture);
      m_TextureCache.Remove(i);  // Remove the entry
      m_TextureCache.
    end;}
  for i := 0 to Length(m_TextureCache) - 1 do
    if (m_TextureCache[i].Pool <> D3DPOOL_DEFAULT) then
    begin // copy non D3DPOOL_DEFAULT texture
      l:= Length(m_TextureCacheCopy);
      SetLength(m_TextureCacheCopy, l+1);
      m_TextureCacheCopy[l]:= m_TextureCache[i];
    end;
  m_TextureCache:= nil; // Free D3DPOOL_DEFAULT textures
  m_TextureCache:= m_TextureCacheCopy;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTResourceCache.OnDestroyDevice: HResult;
begin
  // Release all resources
  m_EffectCache:= nil;
  m_FontCache:= nil;
  m_TextureCache:= nil;

  {//Clootie: This was direct C++ conversion...
  for i := m_EffectCache.GetSize - 1; i >:= 0; --i )
  begin
    SAFE_RELEASE( m_EffectCache[i].pEffect);
    m_EffectCache.Remove( i);
  end;
  for int i := m_FontCache.GetSize - 1; i >:= 0; --i )
  begin
    SAFE_RELEASE( m_FontCache[i].pFont);
    m_FontCache.Remove( i);
  end;
  for int i := m_TextureCache.GetSize - 1; i >:= 0; --i )
  begin
    SAFE_RELEASE( m_TextureCache[i].pTexture);
    m_TextureCache.Remove( i);
  end;}

  Result:= S_OK;
end;




//-----------------------------------------------------------------------------
// Name:
// Desc:
//-----------------------------------------------------------------------------
constructor CD3DArcBall.Create;
var
  rc: TRect;
begin
  Reset;
  m_vDownPt := D3DXVector3Zero;
  m_vCurrentPt := D3DXVector3Zero;
  m_Offset.x := 0;
  m_Offset.y := 0;

  GetClientRect(GetForegroundWindow, rc);
  SetWindow(rc.right, rc.bottom);
end;


//-----------------------------------------------------------------------------
procedure CD3DArcBall.Reset;
begin
  D3DXQuaternionIdentity(m_qDown);
  D3DXQuaternionIdentity(m_qNow);
  D3DXMatrixIdentity(m_mRotation);
  D3DXMatrixIdentity(m_mTranslation);
  D3DXMatrixIdentity(m_mTranslationDelta);
  m_bDrag := False;
  m_fRadiusTranslation := 1.0;
  m_fRadius := 1.0;
end;


//-----------------------------------------------------------------------------
procedure CD3DArcBall.SetTranslationRadius(fRadiusTranslation: Single);
begin
  m_fRadiusTranslation := fRadiusTranslation;
end;


//-----------------------------------------------------------------------------
procedure CD3DArcBall.SetWindow(nWidth: Integer; nHeight: Integer; fRadius: Single{$IFDEF SUPPORTS_DEFAULTPARAMS} = 0.9{$ENDIF});
begin
  m_nWidth := nWidth;
  m_nHeight := nHeight;
  m_fRadius := fRadius;
  m_vCenter := D3DXVector2(m_nWidth/2.0, m_nHeight/2.0);
end;


//-----------------------------------------------------------------------------
procedure CD3DArcBall.SetOffset(nX, nY: Integer);
begin
  m_Offset.x := nX;
  m_Offset.y := nY;
end;


//-----------------------------------------------------------------------------
function CD3DArcBall.ScreenToVector(fScreenPtX, fScreenPtY: Single): TD3DXVector3;
var
  x, y, z, mag, scale: Single;
begin
  // Scale to screen
  x   := -(fScreenPtX - m_Offset.x - m_nWidth/2)  / (m_fRadius*m_nWidth/2);
  y   :=  (fScreenPtY - m_Offset.y - m_nHeight/2) / (m_fRadius*m_nHeight/2);

  z   := 0.0;
  mag := x*x + y*y;

  if (mag > 1.0) then
  begin
    scale := 1.0 / Sqrt(mag);
    x := x*scale;
    y := y*scale;
  end
  else
    z := Sqrt(1.0 - mag);

  // Return vector
  Result:= D3DXVector3(x, y, z);
end;


//-----------------------------------------------------------------------------
class function CD3DArcBall.QuatFromBallPoints(const vFrom, vTo: TD3DXVector3): TD3DXQuaternion;
var
  vPart: TD3DXVector3;
  fDot: Single;
begin
  fDot := D3DXVec3Dot(vFrom, vTo);
  D3DXVec3Cross(vPart, vFrom, vTo);

  Result:= D3DXQuaternion(vPart.x, vPart.y, vPart.z, fDot);
end;


//-----------------------------------------------------------------------------
procedure CD3DArcBall.OnBegin(nX, nY: Integer);
begin
  // Only enter the drag state if the click falls
  // inside the click rectangle.
  if (nX >= m_Offset.x) and
     (nX < m_Offset.x + m_nWidth) and
     (nY >= m_Offset.y) and
     (nY < m_Offset.y + m_nHeight) then
  begin
    m_bDrag := True;
    m_qDown := m_qNow;
    m_vDownPt := ScreenToVector(nX, nY);
  end;
end;


//-----------------------------------------------------------------------------
procedure CD3DArcBall.OnMove(nX, nY: Integer);
begin
  if (m_bDrag) then
  begin
    m_vCurrentPt := ScreenToVector(nX, nY);
    D3DXQuaternionMultiply(m_qNow, m_qDown, QuatFromBallPoints(m_vDownPt, m_vCurrentPt));
  end;
end;


//-----------------------------------------------------------------------------
procedure CD3DArcBall.OnEnd;
begin
  m_bDrag := False;
  m_qDown := m_qNow;
end;


//-----------------------------------------------------------------------------
function CD3DArcBall.HandleMessages(hWnd: HWND; uMsg: Cardinal; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  iMouseX: Integer;
  iMouseY: Integer;
  fDeltaX: Single;
  fDeltaY: Single;
begin
  // Current mouse position
  iMouseX := LOWORD(DWORD(lParam));
  iMouseY := HIWORD(DWORD(lParam));

  Result:= iTrue;
  case uMsg of
    WM_LBUTTONDOWN,
    WM_LBUTTONDBLCLK:
    begin
      SetCapture(hWnd);
      OnBegin(iMouseX, iMouseY);
      Exit;
    end;

    WM_LBUTTONUP:
    begin
      ReleaseCapture;
      OnEnd;
      Exit;
    end;

    WM_CAPTURECHANGED:
    begin
      if (THandle(lParam) <> hWnd) then
      begin
        ReleaseCapture;
        OnEnd;
      end;
      Exit;
    end;

    WM_RBUTTONDOWN,
    WM_RBUTTONDBLCLK,
    WM_MBUTTONDOWN,
    WM_MBUTTONDBLCLK:
    begin
      SetCapture(hWnd);
      // Store off the position of the cursor when the button is pressed
      m_ptLastMouse.x := iMouseX;
      m_ptLastMouse.y := iMouseY;
      Exit;
    end;

    WM_RBUTTONUP,
    WM_MBUTTONUP:
    begin
      ReleaseCapture;
      Exit;
    end;

    WM_MOUSEMOVE:
    begin
      if (MK_LBUTTON and wParam <> 0) then
      begin
        OnMove(iMouseX, iMouseY);
      end
      else if (MK_RBUTTON and wParam <> 0) or (MK_MBUTTON and wParam <> 0) then
      begin
        // Normalize based on size of window and bounding sphere radius
        fDeltaX := (m_ptLastMouse.x-iMouseX) * m_fRadiusTranslation / m_nWidth;
        fDeltaY := (m_ptLastMouse.y-iMouseY) * m_fRadiusTranslation / m_nHeight;

        if (wParam and MK_RBUTTON <> 0) then
        begin
          D3DXMatrixTranslation(m_mTranslationDelta, -2*fDeltaX, 2*fDeltaY, 0.0);
          D3DXMatrixMultiply(m_mTranslation, m_mTranslation, m_mTranslationDelta);
        end
        else  // wParam & MK_MBUTTON
        begin
          D3DXMatrixTranslation(m_mTranslationDelta, 0.0, 0.0, 5*fDeltaY);
          D3DXMatrixMultiply(m_mTranslation, m_mTranslation, m_mTranslationDelta);
        end;

        // Store mouse coordinate
        m_ptLastMouse.x := iMouseX;
        m_ptLastMouse.y := iMouseY;
      end;
      Exit;
    end;
  end;

  Result:= iFalse;
end;

//-----------------------------------------------------------------------------
// Name:
// Desc:
//-----------------------------------------------------------------------------
procedure CD3DArcBall.HandleMessages(var Msg: TMsg; var Handled: Boolean);
begin
  Handled := HandleMessages(Msg.hwnd, Msg.message, Msg.wParam, Msg.lParam) <> 0;
end;

function CD3DArcBall.GetRotationMatrix: PD3DXMatrix;
begin
  Result:= D3DXMatrixRotationQuaternion(m_mRotation, m_qNow);
end;

function CD3DArcBall.GetTranslationMatrix: PD3DXMatrix;      { return &m_matTranslation; }
begin
  Result:= @m_mTranslation;
end;

function CD3DArcBall.GetTranslationDeltaMatrix: PD3DXMatrix; { return &m_matTranslationDelta; }
begin
  Result:= @m_mTranslationDelta;
end;

function CD3DArcBall.IsBeingDragged: Boolean;                { return m_bDrag; }
begin
  Result:= m_bDrag;
end;


function CD3DArcBall.GetQuatNow: TD3DXQuaternion;            { return m_qNow; }
begin
  Result:= m_qNow;
end;


procedure CD3DArcBall.SetQuatNow(q: TD3DXQuaternion);        { m_qNow = q; }
begin
  m_qNow := q;
end;


//-----------------------------------------------------------------------------
// Constructor
//-----------------------------------------------------------------------------
constructor CBaseCamera.Create;
var
  vEyePt: TD3DXVector3;
  vLookatPt: TD3DXVector3;
const
  LONG_MIN      = (-2147483647-1);  // minimum signed   long value
  LONG_MAX      = 2147483647;     // maximum signed   long value
begin
  inherited;
  m_cKeysDown := 0;
  ZeroMemory(@m_aKeys, SizeOf(Byte)*DWORD(CAM_MAX_KEYS));
  ZeroMemory(@m_GamePad, SizeOf(TDXUTGamePad)*DXUT_MAX_CONTROLLERS);

  // Set attributes for the view matrix
  vEyePt    := D3DXVector3(0.0,0.0,0.0);
  vLookatPt := D3DXVector3(0.0,0.0,1.0);

  // Setup the view matrix
  SetViewParams(vEyePt, vLookatPt);

  // Setup the projection matrix
  SetProjParams(D3DX_PI/4, 1.0, 1.0, 1000.0);

  GetCursorPos(m_ptLastMousePosition);
  m_bMouseLButtonDown := False;
  m_bMouseMButtonDown := False;
  m_bMouseRButtonDown := False;
  m_nCurrentButtonMask := 0;
  m_nMouseWheelDelta := 0;

  m_fCameraYawAngle := 0.0;
  m_fCameraPitchAngle := 0.0;

  SetRect(m_rcDrag, LONG_MIN, LONG_MIN, LONG_MAX, LONG_MAX);
  m_vVelocity     := D3DXVector3(0,0,0);
  m_bMovementDrag := False;
  m_vVelocityDrag := D3DXVector3(0,0,0);
  m_fDragTimer    := 0.0;
  m_fTotalDragTimeToZero := 0.25;
  m_vRotVelocity := D3DXVector2(0,0);

  m_fRotationScaler := 0.01;
  m_fMoveScaler := 5.0;

  m_bInvertPitch := False;
  m_bEnableYAxisMovement := True;
  m_bEnablePositionMovement := True;

  m_vMouseDelta   := D3DXVector2Zero;
  m_fFramesToSmoothMouseData := 2.0;

  m_bClipToBoundary := False;
  m_vMinBoundary := D3DXVector3(-1,-1,-1);
  m_vMaxBoundary := D3DXVector3(1,1,1);
end;


//-----------------------------------------------------------------------------
// Client can call this to change the position and direction of camera
//-----------------------------------------------------------------------------
procedure CBaseCamera.SetViewParams(const pvEyePt, pvLookatPt: TD3DXVector3);
var
  vUp: TD3DXVector3;
  mInvView: TD3DXMatrix;
  pZBasis: PD3DXVector3;
  fLen: Single;
begin
  m_vEye := pvEyePt;        m_vDefaultEye := pvEyePt;
  m_vLookAt := pvLookatPt;  m_vDefaultLookAt := pvLookatPt;

  // Calc the view matrix
  vUp := D3DXVector3(0,1,0);
  D3DXMatrixLookAtLH(m_mView, pvEyePt, pvLookatPt, vUp);

  D3DXMatrixInverse(mInvView, nil, m_mView);

  // The axis basis vectors and camera position are stored inside the
  // position matrix in the 4 rows of the camera's world matrix.
  // To figure out the yaw/pitch of the camera, we just need the Z basis vector
  pZBasis := PD3DXVector3(@mInvView._31);

  m_fCameraYawAngle   := ArcTan2(pZBasis^.x, pZBasis^.z);
  fLen := Sqrt(pZBasis^.z*pZBasis^.z + pZBasis^.x*pZBasis^.x);
  m_fCameraPitchAngle := -ArcTan2(pZBasis^.y, fLen);
end;




//-----------------------------------------------------------------------------
// Calculates the projection matrix based on input params
//-----------------------------------------------------------------------------
procedure CBaseCamera.SetProjParams(fFOV, fAspect, fNearPlane, fFarPlane: Single);
begin
  // Set attributes for the projection matrix
  m_fFOV        := fFOV;
  m_fAspect     := fAspect;
  m_fNearPlane  := fNearPlane;
  m_fFarPlane   := fFarPlane;

  D3DXMatrixPerspectiveFovLH(m_mProj, fFOV, fAspect, fNearPlane, fFarPlane);
end;

function CBaseCamera.GetLookAtPt: PD3DXVector3;
begin
  Result:= @m_vLookAt;
end;

procedure CBaseCamera.SetDragRect(const rc: TRect);
begin
  m_rcDrag := rc;
end;

procedure CBaseCamera.SetInvertPitch(bInvertPitch: Boolean);
begin
  m_bInvertPitch := bInvertPitch;
end;

procedure CBaseCamera.SetDrag(bMovementDrag: Boolean; fTotalDragTimeToZero: Single{$IFDEF SUPPORTS_DEFAULTPARAMS} = 0.25{$ENDIF});
begin
  m_bMovementDrag := bMovementDrag;
  m_fTotalDragTimeToZero := fTotalDragTimeToZero;
end;

procedure CBaseCamera.SetEnableYAxisMovement(bEnableYAxisMovement: Boolean);
begin
  m_bEnableYAxisMovement := bEnableYAxisMovement;
end;

procedure CBaseCamera.SetEnablePositionMovement(bEnablePositionMovement: Boolean);
begin
  m_bEnablePositionMovement := bEnablePositionMovement;
end;

procedure CBaseCamera.SetClipToBoundary(bClipToBoundary: Boolean; const pvMinBoundary, pvMaxBoundary: TD3DXVector3);
begin
  m_bClipToBoundary := bClipToBoundary;
  {if (pvMinBoundary<>nil) then} m_vMinBoundary := pvMinBoundary;
  {if (pvMaxBoundary<>nil) then} m_vMaxBoundary := pvMaxBoundary;
end;

procedure CBaseCamera.SetScalers(fRotationScaler: Single{$IFDEF SUPPORTS_DEFAULTPARAMS} = 0.01{$ENDIF}; fMoveScaler: Single{$IFDEF SUPPORTS_DEFAULTPARAMS} = 5.0{$ENDIF});
begin
  m_fRotationScaler := fRotationScaler;
  m_fMoveScaler := fMoveScaler;
end;

procedure CBaseCamera.SetNumberOfFramesToSmoothMouseData(nFrames: Integer);
begin
  if (nFrames > 0) then m_fFramesToSmoothMouseData := nFrames;
end;

function CBaseCamera.GetViewMatrix: PD3DXMatrix;
begin
  Result:= @m_mView;
end;

function CBaseCamera.GetProjMatrix: PD3DXMatrix;
begin
  Result:= @m_mProj;
end;

function CBaseCamera.GetEyePt: PD3DXVector3;
begin
  Result:= @m_vEye;
end;

function CBaseCamera.IsBeingDragged: Boolean;
begin
  Result:= (m_bMouseLButtonDown or m_bMouseMButtonDown or m_bMouseRButtonDown);
end;


//-----------------------------------------------------------------------------
// Call this from your message proc so this class can handle window messages
//-----------------------------------------------------------------------------
function CBaseCamera.HandleMessages(hWnd: HWND; uMsg: Cardinal; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  mappedKey: TD3DUtil_CameraKeys;
  // ptCursor: TPoint;
begin
  case uMsg of
    WM_KEYDOWN:
    begin
      // Map this key to a D3DUtil_CameraKeys enum and update the
      // state of m_aKeys[] by adding the KEY_WAS_DOWN_MASK|KEY_IS_DOWN_MASK mask
      // only if the key is not down
      mappedKey := MapKey(wParam);
      if (mappedKey <> CAM_UNKNOWN) then
      begin
        if (not IsKeyDown(m_aKeys[mappedKey])) then
        begin
          m_aKeys[mappedKey] := KEY_WAS_DOWN_MASK or KEY_IS_DOWN_MASK;
          Inc(m_cKeysDown);
        end;
      end;
    end;

    WM_KEYUP:
    begin
      // Map this key to a D3DUtil_CameraKeys enum and update the
      // state of m_aKeys[] by removing the KEY_IS_DOWN_MASK mask.
      mappedKey := MapKey(wParam);
      if (mappedKey <> CAM_UNKNOWN) and (DWORD(mappedKey) < 8) then
      begin
        m_aKeys[mappedKey] := m_aKeys[mappedKey] and not KEY_IS_DOWN_MASK;
        Dec(m_cKeysDown);
      end;
    end;

    WM_RBUTTONDOWN,
    WM_MBUTTONDOWN,
    WM_LBUTTONDOWN,
    WM_RBUTTONDBLCLK,
    WM_MBUTTONDBLCLK,
    WM_LBUTTONDBLCLK:
    begin
      // Compute the drag rectangle in screen coord.
      // ptCursor := Point(LOWORD(lParam), HIWORD(lParam));

      // Update member var state
      if (uMsg = WM_LBUTTONDOWN) or (uMsg = WM_RBUTTONDBLCLK) then begin m_bMouseLButtonDown := True; m_nCurrentButtonMask := m_nCurrentButtonMask or MOUSE_LEFT_BUTTON; end;
      if (uMsg = WM_MBUTTONDOWN) or (uMsg = WM_MBUTTONDBLCLK) then begin m_bMouseMButtonDown := True; m_nCurrentButtonMask := m_nCurrentButtonMask or MOUSE_MIDDLE_BUTTON; end;
      if (uMsg = WM_RBUTTONDOWN) or (uMsg = WM_RBUTTONDBLCLK) then begin m_bMouseRButtonDown := True; m_nCurrentButtonMask := m_nCurrentButtonMask or MOUSE_RIGHT_BUTTON; end;

      // Capture the mouse, so if the mouse button is
      // released outside the window, we'll get the WM_LBUTTONUP message
      SetCapture(hWnd);
      GetCursorPos(m_ptLastMousePosition); 
      Result:= iTrue;
      Exit;
    end;

    WM_RBUTTONUP,
    WM_MBUTTONUP,
    WM_LBUTTONUP:
    begin
      // Update member var state
      if (uMsg = WM_LBUTTONUP) then begin m_bMouseLButtonDown := False; m_nCurrentButtonMask := m_nCurrentButtonMask and not MOUSE_LEFT_BUTTON; end;
      if (uMsg = WM_MBUTTONUP) then begin m_bMouseMButtonDown := False; m_nCurrentButtonMask := m_nCurrentButtonMask and not MOUSE_MIDDLE_BUTTON; end;
      if (uMsg = WM_RBUTTONUP) then begin m_bMouseRButtonDown := False; m_nCurrentButtonMask := m_nCurrentButtonMask and not MOUSE_RIGHT_BUTTON; end;

      // Release the capture if no mouse buttons down
      if (not m_bMouseLButtonDown  and
          not m_bMouseRButtonDown and
          not m_bMouseMButtonDown) then
      begin
        ReleaseCapture;
      end;
    end;

    WM_CAPTURECHANGED:
    begin
      if (THandle(lParam) <> hWnd) then
      begin
        if (m_nCurrentButtonMask and MOUSE_LEFT_BUTTON <> 0) or
           (m_nCurrentButtonMask and MOUSE_MIDDLE_BUTTON <> 0) or
           (m_nCurrentButtonMask and MOUSE_RIGHT_BUTTON <> 0) then
        begin
          m_bMouseLButtonDown := False;
          m_bMouseMButtonDown := False;
          m_bMouseRButtonDown := False;
          m_nCurrentButtonMask := m_nCurrentButtonMask and not MOUSE_LEFT_BUTTON;
          m_nCurrentButtonMask := m_nCurrentButtonMask and not MOUSE_MIDDLE_BUTTON;
          m_nCurrentButtonMask := m_nCurrentButtonMask and not MOUSE_RIGHT_BUTTON;
          ReleaseCapture;
        end;
      end;
    end;

    WM_MOUSEWHEEL:
      // Update member var state
      m_nMouseWheelDelta := Smallint(HIWORD(DWORD(wParam))) div 120;
  end;

  Result:= iFalse;
end;


//-----------------------------------------------------------------------------
// Figure out the velocity based on keyboard input & drag if any
//-----------------------------------------------------------------------------
procedure CBaseCamera.GetInput(bGetKeyboardInput, bGetMouseInput, bGetGamepadInput, bResetCursorAfterMove: Boolean);
var
  ptCurMouseDelta: TPoint;
  ptCurMousePos: TPoint;
  ptCenter: TPoint;
  mi: TMonitorInfo;
  fPercentOfNew: Single;
  fPercentOfOld: Single;
  iUserIndex: DWORD;
  iMostRecentlyActive: Integer;
  fMostRecentlyActiveTime: Double;
begin
  m_vKeyboardDirection := D3DXVECTOR3(0,0,0);
  if bGetKeyboardInput then
  begin
    // Update acceleration vector based on keyboard state
    if IsKeyDown(m_aKeys[CAM_MOVE_FORWARD]) then m_vKeyboardDirection.z := m_vKeyboardDirection.z + 1.0;
    if IsKeyDown(m_aKeys[CAM_MOVE_BACKWARD]) then m_vKeyboardDirection.z := m_vKeyboardDirection.z - 1.0;

    if m_bEnableYAxisMovement then
    begin
      if IsKeyDown(m_aKeys[CAM_MOVE_UP]) then m_vKeyboardDirection.y := m_vKeyboardDirection.y + 1.0;
      if IsKeyDown(m_aKeys[CAM_MOVE_DOWN]) then m_vKeyboardDirection.y := m_vKeyboardDirection.y - 1.0;
    end;

    if IsKeyDown(m_aKeys[CAM_STRAFE_RIGHT]) then m_vKeyboardDirection.x := m_vKeyboardDirection.x + 1.0;
    if IsKeyDown(m_aKeys[CAM_STRAFE_LEFT]) then m_vKeyboardDirection.x := m_vKeyboardDirection.x - 1.0;
  end;

  if bGetMouseInput then
  begin
    // Get current position of mouse
    if GetCursorPos(ptCurMousePos) then
    begin
      // Calc how far it's moved since last frame
      ptCurMouseDelta.x := ptCurMousePos.x - m_ptLastMousePosition.x;
      ptCurMouseDelta.y := ptCurMousePos.y - m_ptLastMousePosition.y;

      // Record current position for next time
      m_ptLastMousePosition := ptCurMousePos;
    end else
    begin
      // If GetCursorPos() returns false, just set delta to zero
      ptCurMouseDelta.x := 0;
      ptCurMouseDelta.y := 0;
    end;

    if (bResetCursorAfterMove and DXUTIsActive) then
    begin
      // Set position of camera to center of desktop,
      // so it always has room to move.  This is very useful
      // if the cursor is hidden.  If this isn't done and cursor is hidden,
      // then invisible cursor will hit the edge of the screen
      // and the user can't tell what happened

      // Get the center of the current monitor
      mi.cbSize := SizeOf(TMonitorInfo);
      DXUTGetMonitorInfo(DXUTMonitorFromWindow(DXUTGetHWND, MONITOR_DEFAULTTONEAREST), @mi);
      ptCenter.x := (mi.rcMonitor.left + mi.rcMonitor.right) div 2;
      ptCenter.y := (mi.rcMonitor.top + mi.rcMonitor.bottom) div 2;
      SetCursorPos(ptCenter.x, ptCenter.y);
      m_ptLastMousePosition := ptCenter;
    end;

    // Smooth the relative mouse data over a few frames so it isn't 
    // jerky when moving slowly at low frame rates.
    fPercentOfNew :=  1.0 / m_fFramesToSmoothMouseData;
    fPercentOfOld :=  1.0 - fPercentOfNew;
    m_vMouseDelta.x := m_vMouseDelta.x*fPercentOfOld + ptCurMouseDelta.x*fPercentOfNew;
    m_vMouseDelta.y := m_vMouseDelta.y*fPercentOfOld + ptCurMouseDelta.y*fPercentOfNew;
  end;

  if bGetGamepadInput then
  begin
    m_vGamePadLeftThumb := D3DXVector3Zero;
    m_vGamePadRightThumb := D3DXVector3Zero;

    // Get controller state
    for iUserIndex := 0 to DXUT_MAX_CONTROLLERS - 1 do
    begin
      DXUTGetGamepadState(iUserIndex, m_GamePad[iUserIndex], True, True);

      // Mark time if the controller is in a non-zero state
      if ((m_GamePad[iUserIndex].wButtons <> 0) or
          (m_GamePad[iUserIndex].sThumbLX <> 0) or (m_GamePad[iUserIndex].sThumbLX <> 0) or
          (m_GamePad[iUserIndex].sThumbRX <> 0) or (m_GamePad[iUserIndex].sThumbRY <> 0) or
          (m_GamePad[iUserIndex].bLeftTrigger <> 0) or (m_GamePad[iUserIndex].bRightTrigger <> 0)) then
      begin
        m_GamePadLastActive[iUserIndex] := DXUTGetTime;
      end;
    end;

    // Find out which controller was non-zero last
    iMostRecentlyActive := -1;
    fMostRecentlyActiveTime := 0.0;
    for iUserIndex := 0 to DXUT_MAX_CONTROLLERS - 1 do
    begin
      if (m_GamePadLastActive[iUserIndex] > fMostRecentlyActiveTime) then
      begin
        fMostRecentlyActiveTime := m_GamePadLastActive[iUserIndex];
        iMostRecentlyActive := iUserIndex;
      end;
    end;

    // Use the most recent non-zero controller if its connected
    if (iMostRecentlyActive >= 0) and (m_GamePad[iMostRecentlyActive].bConnected) then
    begin
      m_vGamePadLeftThumb.x := m_GamePad[iMostRecentlyActive].fThumbLX;
      m_vGamePadLeftThumb.y := 0.0;
      m_vGamePadLeftThumb.z := m_GamePad[iMostRecentlyActive].fThumbLY;

      m_vGamePadRightThumb.x := m_GamePad[iMostRecentlyActive].fThumbRX;
      m_vGamePadRightThumb.y := 0.0;
      m_vGamePadRightThumb.z := m_GamePad[iMostRecentlyActive].fThumbRY;
    end;
  end;
end;


//-----------------------------------------------------------------------------
// Figure out the velocity based on keyboard input & drag if any
//-----------------------------------------------------------------------------
procedure CBaseCamera.UpdateVelocity(fElapsedTime: Single);
var
//  mRotDelta: TD3DXMatrix; //BAA: It's never used anyway
  vGamePadRightThumb: TD3DXVector2;
  vAccel: TD3DXVector3;
  p1, p2: TD3DXVector2;
  v: TD3DXVector3;
begin
  vGamePadRightThumb := D3DXVector2(m_vGamePadRightThumb.x, -m_vGamePadRightThumb.z);
  // m_vRotVelocity := m_vMouseDelta * m_fRotationScaler + vGamePadRightThumb * 0.02;
  D3DXVec2Scale(p2, vGamePadRightThumb, 0.02);
  D3DXVec2Scale(p1, m_vMouseDelta, m_fRotationScaler);
  m_vRotVelocity := D3DXVec2Add(p1, p2);

  // vAccel := m_vKeyboardDirection + m_vGamePadLeftThumb;
  D3DXVec3Add(vAccel, m_vKeyboardDirection, m_vGamePadLeftThumb);

  // Normalize vector so if moving 2 dirs (left & forward),
  // the camera doesn't move faster than if moving in 1 dir
  D3DXVec3Normalize(vAccel, vAccel);

  // Scale the acceleration vector
  D3DXVec3Scale(vAccel, vAccel, m_fMoveScaler);

  if m_bMovementDrag then
  begin
    // Is there any acceleration this frame?
    if (D3DXVec3LengthSq(vAccel ) > 0) then
    begin
      // If so, then this means the user has pressed a movement key\
      // so change the velocity immediately to acceleration
      // upon keyboard input.  This isn't normal physics
      // but it will give a quick response to keyboard input
      m_vVelocity := vAccel;
      m_fDragTimer := m_fTotalDragTimeToZero;
      D3DXVec3Scale(m_vVelocityDrag, vAccel, 1 / m_fDragTimer);
    end else
    begin
      // If no key being pressed, then slowly decrease velocity to 0
      if (m_fDragTimer > 0) then
      begin
        // Drag until timer is <= 0
        // m_vVelocity := m_vVelocity - m_vVelocityDrag * fElapsedTime;
        D3DXVec3Subtract(m_vVelocity, m_vVelocity, D3DXVec3Scale(v, m_vVelocityDrag, fElapsedTime)^);
        m_fDragTimer := m_fDragTimer - fElapsedTime;
      end else
      begin
        // Zero velocity
        m_vVelocity := D3DXVector3Zero;
      end;
    end;
  end else
  begin
    // No drag, so immediately change the velocity
    m_vVelocity := vAccel;
  end;
end;


function CBaseCamera.IsKeyDown(key: Byte): Boolean;
begin
  Result:= ((key and KEY_IS_DOWN_MASK) = KEY_IS_DOWN_MASK);
end;


function CBaseCamera.WasKeyDown(key: Byte): Boolean;
begin
  Result:= ((key and KEY_WAS_DOWN_MASK) = KEY_WAS_DOWN_MASK);
end;


//-----------------------------------------------------------------------------
// Clamps pV to lie inside m_vMinBoundary & m_vMaxBoundary
//-----------------------------------------------------------------------------
procedure CBaseCamera.ConstrainToBoundary(var pV: TD3DXVector3);
begin
  // Constrain vector to a bounding box
  pV.x := Max(pV.x, m_vMinBoundary.x);
  pV.y := Max(pV.y, m_vMinBoundary.y);
  pV.z := Max(pV.z, m_vMinBoundary.z);

  pV.x := Min(pV.x, m_vMaxBoundary.x);
  pV.y := Min(pV.y, m_vMaxBoundary.y);
  pV.z := Min(pV.z, m_vMaxBoundary.z);
end;




//-----------------------------------------------------------------------------
// Maps a windows virtual key to an enum
//-----------------------------------------------------------------------------
function CBaseCamera.MapKey(nKey: LongWord): TD3DUtil_CameraKeys;
begin
  // This could be upgraded to a method that's user-definable but for
  // simplicity, we'll use a hardcoded mapping.
  case nKey of
    VK_CONTROL: Result:= CAM_CONTROLDOWN;
    VK_LEFT:    Result:= CAM_STRAFE_LEFT;
    VK_RIGHT:   Result:= CAM_STRAFE_RIGHT;
    VK_UP:      Result:= CAM_MOVE_FORWARD;
    VK_DOWN:    Result:= CAM_MOVE_BACKWARD;
    VK_PRIOR:   Result:= CAM_MOVE_UP;        // pgup
    VK_NEXT:    Result:= CAM_MOVE_DOWN;      // pgdn

    Ord('A'):   Result:= CAM_STRAFE_LEFT;
    Ord('D'):   Result:= CAM_STRAFE_RIGHT;
    Ord('W'):   Result:= CAM_MOVE_FORWARD;
    Ord('S'):   Result:= CAM_MOVE_BACKWARD;
    Ord('Q'):   Result:= CAM_MOVE_DOWN;
    Ord('E'):   Result:= CAM_MOVE_UP;

    VK_NUMPAD4: Result:= CAM_STRAFE_LEFT;
    VK_NUMPAD6: Result:= CAM_STRAFE_RIGHT;
    VK_NUMPAD8: Result:= CAM_MOVE_FORWARD;
    VK_NUMPAD2: Result:= CAM_MOVE_BACKWARD;
    VK_NUMPAD9: Result:= CAM_MOVE_UP;
    VK_NUMPAD3: Result:= CAM_MOVE_DOWN;

    VK_HOME:   Result:= CAM_RESET;
  else
    Result:= CAM_UNKNOWN;
  end;
end;




//-----------------------------------------------------------------------------
// Reset the camera's position back to the default
//-----------------------------------------------------------------------------
procedure CBaseCamera.Reset;
begin
  SetViewParams(m_vDefaultEye, m_vDefaultLookAt);
end;




//-----------------------------------------------------------------------------
// Name: CFirstPersonCamera
// Desc: Constructor
//-----------------------------------------------------------------------------
constructor CFirstPersonCamera.Create;
begin
  inherited Create;
  m_nActiveButtonMask:= $07;
  m_bRotateWithoutButtonDown:= False;
end;

//-----------------------------------------------------------------------------
// Update the view matrix based on user input & elapsed time
//-----------------------------------------------------------------------------
procedure CFirstPersonCamera.FrameMove(fElapsedTime: Single);
var
  vPosDelta: TD3DXVector3;
  fYawDelta: Single;
  fPitchDelta: Single;
  mCameraRot: TD3DXMatrix;
  vWorldUp, vWorldAhead: TD3DXVector3;
  vLocalUp: TD3DXVector3;
  vLocalAhead: TD3DXVector3;
  vPosDeltaWorld: TD3DXVector3;
begin
  if DXUTGetGlobalTimer.IsStopped then fElapsedTime := 1.0 / DXUTGetFPS;

  if IsKeyDown(m_aKeys[CAM_RESET]) then Reset;

  // Get keyboard/mouse/gamepad input
  GetInput(m_bEnablePositionMovement,
           (m_nActiveButtonMask and m_nCurrentButtonMask <> 0) or m_bRotateWithoutButtonDown,
           True, m_bResetCursorAfterMove);

  // Get amount of velocity based on the keyboard input and drag (if any)
  UpdateVelocity(fElapsedTime);

  // Simple euler method to calculate position delta
  D3DXVec3Scale(vPosDelta, m_vVelocity, fElapsedTime);

  // If rotating the camera
  if (m_nActiveButtonMask and m_nCurrentButtonMask <> 0) or
     (m_bRotateWithoutButtonDown) or
     (m_vGamePadRightThumb.x <> 0) or
     (m_vGamePadRightThumb.z <> 0) then
  begin
    // Update the pitch & yaw angle based on mouse movement
    fYawDelta   := m_vRotVelocity.x;
    fPitchDelta := m_vRotVelocity.y;

    // Invert pitch if requested
    if (m_bInvertPitch) then fPitchDelta := - fPitchDelta;

    m_fCameraPitchAngle := m_fCameraPitchAngle + fPitchDelta;
    m_fCameraYawAngle   := m_fCameraYawAngle + fYawDelta;

    // Limit pitch to straight up or straight down
    m_fCameraPitchAngle := Max(-D3DX_PI/2.0, m_fCameraPitchAngle);
    m_fCameraPitchAngle := Min(+D3DX_PI/2.0, m_fCameraPitchAngle);
  end;

  // Make a rotation matrix based on the camera's yaw & pitch
  D3DXMatrixRotationYawPitchRoll(mCameraRot, m_fCameraYawAngle, m_fCameraPitchAngle, 0);

  // Transform vectors based on camera's rotation matrix
  vLocalUp    := D3DXVector3(0,1,0);
  vLocalAhead := D3DXVector3(0,0,1);
  D3DXVec3TransformCoord(vWorldUp, vLocalUp, mCameraRot);
  D3DXVec3TransformCoord(vWorldAhead, vLocalAhead, mCameraRot);

  // Transform the position delta by the camera's rotation
  if (not m_bEnableYAxisMovement) then
  begin
    // If restricting Y movement, do not include pitch
    // when transforming position delta vector.
    D3DXMatrixRotationYawPitchRoll(mCameraRot, m_fCameraYawAngle, 0.0, 0.0);
  end;
  D3DXVec3TransformCoord(vPosDeltaWorld, vPosDelta, mCameraRot);

  // Move the eye position
  D3DXVec3Add(m_vEye, m_vEye, vPosDeltaWorld);
  if m_bClipToBoundary then ConstrainToBoundary(m_vEye);

  // Update the lookAt position based on the eye position 
  D3DXVec3Add(m_vLookAt, m_vEye, vWorldAhead);

  // Update the view matrix
  D3DXMatrixLookAtLH(m_mView, m_vEye, m_vLookAt, vWorldUp);

  D3DXMatrixInverse(m_mCameraWorld, nil, m_mView);
end;


//--------------------------------------------------------------------------------------
// Enable or disable each of the mouse buttons for rotation drag.
//--------------------------------------------------------------------------------------
procedure CFirstPersonCamera.SetRotateButtons(bLeft, bMiddle, bRight: Boolean;
  bRotateWithoutButtonDown: Boolean = False);
begin
  m_nActiveButtonMask := IfThen(bLeft, MOUSE_LEFT_BUTTON, 0) or
                         IfThen(bMiddle, MOUSE_MIDDLE_BUTTON, 0) or
                         IfThen(bRight, MOUSE_RIGHT_BUTTON, 0);
  m_bRotateWithoutButtonDown := bRotateWithoutButtonDown;
end;

procedure CFirstPersonCamera.SetResetCursorAfterMove(bResetCursorAfterMove: Boolean);
begin
  m_bResetCursorAfterMove := bResetCursorAfterMove;
end;

function CFirstPersonCamera.GetWorldMatrix: PD3DXMatrix; { return &m_mCameraWorld; }
begin
  Result:= @m_mCameraWorld;
end;

{const} function CFirstPersonCamera.GetWorldRight: PD3DXVector3;
begin
  Result:= PD3DXVector3(@m_mCameraWorld._11);
end;

function CFirstPersonCamera.GetWorldUp: PD3DXVector3;
begin
  Result:= PD3DXVector3(@m_mCameraWorld._21);
end;

function CFirstPersonCamera.GetWorldAhead: PD3DXVector3;
begin
  Result:= PD3DXVector3(@m_mCameraWorld._31);
end;

function CFirstPersonCamera.GetEyePt: PD3DXVector3;
begin
  Result:= PD3DXVector3(@m_mCameraWorld._41);
end;


//-----------------------------------------------------------------------------
// Constructor
//-----------------------------------------------------------------------------
constructor CModelViewerCamera.Create;
begin
  m_WorldArcBall:= CD3DArcBall.Create;
  m_ViewArcBall:= CD3DArcBall.Create;
  
  inherited Create;

  D3DXMatrixIdentity(m_mWorld);
  D3DXMatrixIdentity(m_mModelRot);
  D3DXMatrixIdentity(m_mModelLastRot);
  D3DXMatrixIdentity(m_mCameraRotLast);
  m_vModelCenter := D3DXVector3Zero;
  m_fRadius    := 5.0;
  m_fDefaultRadius := 5.0;
  m_fMinRadius := 1.0;
  m_fMaxRadius := 3.402823466e+38{FLT_MAX};
  m_bLimitPitch := False;
  m_bEnablePositionMovement := False;
  m_bAttachCameraToModel := False;

  m_nRotateModelButtonMask  := MOUSE_LEFT_BUTTON;
  m_nZoomButtonMask         := MOUSE_WHEEL;
  m_nRotateCameraButtonMask := MOUSE_RIGHT_BUTTON;
  m_bDragSinceLastUpdate    := True;
end;

destructor CModelViewerCamera.Destroy;
begin
  m_WorldArcBall.Free;
  m_ViewArcBall.Free;
  inherited Destroy;
end;



//-----------------------------------------------------------------------------
// Update the view matrix & the model's world matrix based 
//       on user input & elapsed time
//-----------------------------------------------------------------------------
procedure CModelViewerCamera.FrameMove(fElapsedTime: Single);
var
  vPosDelta: TD3DXVector3;
  mCameraRot: TD3DXMatrix;
  vWorldUp, vWorldAhead: TD3DXVector3;
  vLocalUp: TD3DXVector3;
  vLocalAhead: TD3DXVector3;
  vPosDeltaWorld: TD3DXVector3;
  v: TD3DXVector3;
  mInvView: TD3DXMatrix;
  mModelLastRotInv: TD3DXMatrix;
  mModelRot: TD3DXMatrix;
  m: TD3DXMatrix;
  pXBasis: PD3DXVector3;
  pYBasis: PD3DXVector3;
  pZBasis: PD3DXVector3;
  mTrans: TD3DXMatrix;
  mCameraLastRotInv: TD3DXMatrix;
  mCameraRotDelta: TD3DXMatrix;
begin
  if IsKeyDown(m_aKeys[CAM_RESET]) then Reset;

  // If no dragged has happend since last time FrameMove is called,
  // and no camera key is held down, then no need to handle again.
  if (not m_bDragSinceLastUpdate) and (m_cKeysDown = 0) then Exit;
  m_bDragSinceLastUpdate := False;

  // Get keyboard/mouse/gamepad input
  GetInput(m_bEnablePositionMovement, m_nCurrentButtonMask <> 0, True, False);

  // Get amount of velocity based on the keyboard input and drag (if any)
  UpdateVelocity(fElapsedTime);

  // Simple euler method to calculate position delta
  D3DXVec3Scale(vPosDelta, m_vVelocity, fElapsedTime);

  // Change the radius from the camera to the model based on wheel scrolling
  if (m_nMouseWheelDelta <> 0) and (m_nZoomButtonMask = MOUSE_WHEEL) then
    m_fRadius := m_fRadius - m_nMouseWheelDelta * m_fRadius * 0.1;
  m_fRadius := Min(m_fMaxRadius, m_fRadius);
  m_fRadius := Max(m_fMinRadius, m_fRadius);
  m_nMouseWheelDelta := 0;

  // Get the inverse of the arcball's rotation matrix
  D3DXMatrixInverse(mCameraRot, nil, m_ViewArcBall.GetRotationMatrix^);

  // Transform vectors based on camera's rotation matrix
  vLocalUp    := D3DXVector3(0,1,0);
  vLocalAhead := D3DXVector3(0,0,1);
  D3DXVec3TransformCoord(vWorldUp, vLocalUp, mCameraRot);
  D3DXVec3TransformCoord(vWorldAhead, vLocalAhead, mCameraRot);

  // Transform the position delta by the camera's rotation
  D3DXVec3TransformCoord(vPosDeltaWorld, vPosDelta, mCameraRot);

  // Move the lookAt position
  D3DXVec3Add(m_vLookAt, m_vLookAt, vPosDeltaWorld);
  if m_bClipToBoundary then ConstrainToBoundary(m_vLookAt);

  // Update the eye point based on a radius away from the lookAt position
  // m_vEye = m_vLookAt - vWorldAhead * m_fRadius;
  D3DXVec3Subtract(m_vEye, m_vLookAt, D3DXVec3Scale(v, vWorldAhead, m_fRadius)^);

  // Update the view matrix
  D3DXMatrixLookAtLH(m_mView, m_vEye, m_vLookAt, vWorldUp);

  D3DXMatrixInverse(mInvView, nil, m_mView);
  mInvView._41 := 0; mInvView._42 := 0; mInvView._43 := 0;

  D3DXMatrixInverse(mModelLastRotInv, nil, m_mModelLastRot);

  // Accumulate the delta of the arcball's rotation in view space.
  // Note that per-frame delta rotations could be problematic over long periods of time.
  mModelRot := m_WorldArcBall.GetRotationMatrix^;
  // m_mModelRot *= m_mView * mModelLastRotInv * mModelRot * mInvView;
  D3DXMatrixMultiply(m, mModelRot, mInvView);
  D3DXMatrixMultiply(m, mModelLastRotInv, m);
  D3DXMatrixMultiply(m, m_mView, m);
  D3DXMatrixMultiply(m_mModelRot, m_mModelRot, m);

  if (m_ViewArcBall.IsBeingDragged and m_bAttachCameraToModel and not IsKeyDown(m_aKeys[CAM_CONTROLDOWN]) ) then
  begin
    // Attach camera to model by inverse of the model rotation
    D3DXMatrixInverse(mCameraLastRotInv, nil, m_mCameraRotLast);
    D3DXMatrixMultiply(mCameraRotDelta, mCameraLastRotInv, mCameraRot); // local to world matrix
    D3DXMatrixMultiply(m_mModelRot, m_mModelRot, mCameraRotDelta);
  end;
  m_mCameraRotLast := mCameraRot;

  m_mModelLastRot := mModelRot;

  // Since we're accumulating delta rotations, we need to orthonormalize
  // the matrix to prevent eventual matrix skew
  pXBasis := PD3DXVector3(@m_mModelRot._11);
  pYBasis := PD3DXVector3(@m_mModelRot._21);
  pZBasis := PD3DXVector3(@m_mModelRot._31);
  D3DXVec3Normalize(pXBasis^, pXBasis^);
  D3DXVec3Cross(pYBasis^, pZBasis^, pXBasis^);
  D3DXVec3Normalize(pYBasis^, pYBasis^);
  D3DXVec3Cross(pZBasis^, pXBasis^, pYBasis^);

  // Translate the rotation matrix to the same position as the lookAt position
  m_mModelRot._41 := m_vLookAt.x;
  m_mModelRot._42 := m_vLookAt.y;
  m_mModelRot._43 := m_vLookAt.z;

  // Translate world matrix so its at the center of the model
  D3DXMatrixTranslation(mTrans, -m_vModelCenter.x, -m_vModelCenter.y, -m_vModelCenter.z);
  D3DXMatrixMultiply(m_mWorld, mTrans, m_mModelRot);
end;


//-----------------------------------------------------------------------------
procedure CModelViewerCamera.SetDragRect(const rc: TRect);
begin
  inherited {CBaseCamera.}SetDragRect(rc);

  m_WorldArcBall.SetOffset(rc.left, rc.top);
  m_ViewArcBall.SetOffset(rc.left, rc.top);
  SetWindow(rc.right - rc.left, rc.bottom - rc.top);
end;


//-----------------------------------------------------------------------------
// Reset the camera's position back to the default
//-----------------------------------------------------------------------------
procedure CModelViewerCamera.Reset;
begin
  inherited Reset;

  D3DXMatrixIdentity(m_mWorld);
  m_fRadius := m_fDefaultRadius;
  m_WorldArcBall.Reset;
  m_ViewArcBall.Reset;
end;


//--------------------------------------------------------------------------------------
// Override for setting the view parameters
//--------------------------------------------------------------------------------------
procedure CModelViewerCamera.SetViewParams(const pvEyePt, pvLookatPt: TD3DXVector3); 
var
  vUp: TD3DXVector3;
  quat: TD3DXQuaternion;
  mRotation: TD3DXMatrixA16;
  vEyeToPoint: TD3DXVector3;
begin
  inherited SetViewParams(pvEyePt, pvLookatPt);

  // Propogate changes to the member arcball
  vUp:= D3DXVector3(0,1,0);
  D3DXMatrixLookAtLH(mRotation, pvEyePt, pvLookatPt, vUp);
  D3DXQuaternionRotationMatrix(quat, mRotation);
  m_ViewArcBall.SetQuatNow(quat);

  // Set the radius according to the distance
  D3DXVec3Subtract(vEyeToPoint, pvLookatPt, pvEyePt);
  SetRadius(D3DXVec3Length(vEyeToPoint));

  // View information changed. FrameMove should be called.
  m_bDragSinceLastUpdate := True;
end;


//-----------------------------------------------------------------------------
// Call this from your message proc so this class can handle window messages
//-----------------------------------------------------------------------------
function CModelViewerCamera.HandleMessages(hWnd: HWND; uMsg: Cardinal; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  iMouseX: Integer;
  iMouseY: Integer;
begin
  inherited HandleMessages(hWnd, uMsg, wParam, lParam);

  if (((uMsg = WM_LBUTTONDOWN) or (uMsg = WM_LBUTTONDBLCLK)) and (m_nRotateModelButtonMask and MOUSE_LEFT_BUTTON <> 0)) or
     (((uMsg = WM_MBUTTONDOWN) or (uMsg = WM_MBUTTONDBLCLK)) and (m_nRotateModelButtonMask and MOUSE_MIDDLE_BUTTON <> 0)) or
     (((uMsg = WM_RBUTTONDOWN) or (uMsg = WM_RBUTTONDBLCLK)) and (m_nRotateModelButtonMask and MOUSE_RIGHT_BUTTON <> 0)) then
  begin
    iMouseX := LOWORD(DWORD(lParam)); // GET_X_LPARAM(lParam);
    iMouseY := HIWORD(DWORD(lParam)); // GET_Y_LPARAM(lParam);
    m_WorldArcBall.OnBegin(iMouseX, iMouseY);
  end;

  if (((uMsg = WM_LBUTTONDOWN) or (uMsg = WM_LBUTTONDBLCLK)) and (m_nRotateCameraButtonMask and MOUSE_LEFT_BUTTON <> 0)) or
     (((uMsg = WM_MBUTTONDOWN) or (uMsg = WM_MBUTTONDBLCLK)) and (m_nRotateCameraButtonMask and MOUSE_MIDDLE_BUTTON <> 0)) or
     (((uMsg = WM_RBUTTONDOWN) or (uMsg = WM_RBUTTONDBLCLK)) and (m_nRotateCameraButtonMask and MOUSE_RIGHT_BUTTON <> 0)) then
  begin
    iMouseX := LOWORD(DWORD(lParam)); // GET_X_LPARAM(lParam);
    iMouseY := HIWORD(DWORD(lParam)); // GET_Y_LPARAM(lParam);
    m_ViewArcBall.OnBegin(iMouseX, iMouseY);
  end;

  if (uMsg = WM_MOUSEMOVE) then
  begin
    iMouseX := LOWORD(DWORD(lParam)); // GET_X_LPARAM(lParam);
    iMouseY := HIWORD(DWORD(lParam)); // GET_Y_LPARAM(lParam);
    m_WorldArcBall.OnMove(iMouseX, iMouseY);
    m_ViewArcBall.OnMove(iMouseX, iMouseY);
  end;

  if ((uMsg = WM_LBUTTONUP) and (m_nRotateModelButtonMask and MOUSE_LEFT_BUTTON <> 0)) or
     ((uMsg = WM_MBUTTONUP) and (m_nRotateModelButtonMask and MOUSE_MIDDLE_BUTTON <> 0)) or
     ((uMsg = WM_RBUTTONUP) and (m_nRotateModelButtonMask and MOUSE_RIGHT_BUTTON <> 0)) then
  begin
    m_WorldArcBall.OnEnd;
  end;

  if ((uMsg = WM_LBUTTONUP) and (m_nRotateCameraButtonMask and MOUSE_LEFT_BUTTON <> 0)) or
     ((uMsg = WM_MBUTTONUP) and (m_nRotateCameraButtonMask and MOUSE_MIDDLE_BUTTON <> 0)) or
     ((uMsg = WM_RBUTTONUP) and (m_nRotateCameraButtonMask and MOUSE_RIGHT_BUTTON <> 0)) then
  begin
    m_ViewArcBall.OnEnd;
  end;

  if (uMsg = WM_CAPTURECHANGED) then
  begin
    if (THandle(lParam) <> hWnd) then
    begin
      if (m_nRotateModelButtonMask and MOUSE_LEFT_BUTTON <> 0) or
         (m_nRotateModelButtonMask and MOUSE_MIDDLE_BUTTON <> 0) or
         (m_nRotateModelButtonMask and MOUSE_RIGHT_BUTTON <> 0) then
      begin
        m_WorldArcBall.OnEnd;
      end;

      if (m_nRotateCameraButtonMask and MOUSE_LEFT_BUTTON <> 0) or
         (m_nRotateCameraButtonMask and MOUSE_MIDDLE_BUTTON <> 0) or
         (m_nRotateCameraButtonMask and MOUSE_RIGHT_BUTTON <> 0) then
      begin
          m_ViewArcBall.OnEnd;
      end;
    end;
  end;

  if (uMsg = WM_LBUTTONDOWN) or
     (uMsg = WM_LBUTTONDBLCLK) or
     (uMsg = WM_MBUTTONDOWN) or
     (uMsg = WM_MBUTTONDBLCLK) or
     (uMsg = WM_RBUTTONDOWN) or
     (uMsg = WM_RBUTTONDBLCLK) or
     (uMsg = WM_LBUTTONUP) or
     (uMsg = WM_MBUTTONUP) or
     (uMsg = WM_RBUTTONUP) or
     (uMsg = WM_MOUSEWHEEL) or
     (uMsg = WM_MOUSEMOVE) then
  begin
    m_bDragSinceLastUpdate := True;
  end;
  
  Result:= iFalse;
end;

procedure CModelViewerCamera.SetButtonMasks(nRotateModelButtonMask: Integer{$IFDEF SUPPORTS_DEFAULTPARAMS} = MOUSE_LEFT_BUTTON{$ENDIF}; nZoomButtonMask: Integer{$IFDEF SUPPORTS_DEFAULTPARAMS} = MOUSE_WHEEL{$ENDIF}; nRotateCameraButtonMask: Integer{$IFDEF SUPPORTS_DEFAULTPARAMS} = MOUSE_RIGHT_BUTTON{$ENDIF}); { m_nRotateModelButtonMask = nRotateModelButtonMask, m_nZoomButtonMask = nZoomButtonMask; m_nRotateCameraButtonMask = nRotateCameraButtonMask; }
begin
  m_nRotateModelButtonMask := nRotateModelButtonMask;
  m_nZoomButtonMask := nZoomButtonMask;
  m_nRotateCameraButtonMask := nRotateCameraButtonMask;
end;

procedure CModelViewerCamera.SetAttachCameraToModel(bEnable: Boolean = False);
begin
  m_bAttachCameraToModel := bEnable;
end;

procedure CModelViewerCamera.SetWindow(nWidth, nHeight: Integer; fArcballRadius: Single{$IFDEF SUPPORTS_DEFAULTPARAMS} = 0.9{$ENDIF}); { m_WorldArcBall.SetWindow( nWidth, nHeight, fArcballRadius ); m_ViewArcBall.SetWindow( nWidth, nHeight, fArcballRadius ); }
begin
  m_WorldArcBall.SetWindow(nWidth, nHeight, fArcballRadius);
  m_ViewArcBall.SetWindow (nWidth, nHeight, fArcballRadius);
end;

procedure CModelViewerCamera.SetRadius(fDefaultRadius: Single{$IFDEF SUPPORTS_DEFAULTPARAMS} = 5.0{$ENDIF}; fMinRadius: Single{$IFDEF SUPPORTS_DEFAULTPARAMS} = 1.0{$ENDIF}; fMaxRadius: Single{$IFDEF SUPPORTS_DEFAULTPARAMS} = 3.402823466e+38{FLT_MAX}{$ENDIF}); { m_fDefaultRadius = m_fRadius = fDefaultRadius; m_fMinRadius = fMinRadius; m_fMaxRadius = fMaxRadius; }
begin
  m_fDefaultRadius := fDefaultRadius; m_fRadius := fDefaultRadius;
  m_fMinRadius := fMinRadius;
  m_fMaxRadius := fMaxRadius;
  m_bDragSinceLastUpdate := True;
end;

procedure CModelViewerCamera.SetModelCenter(vModelCenter: TD3DXVector3);
begin
  m_vModelCenter := vModelCenter;
end;

procedure CModelViewerCamera.SetLimitPitch(bLimitPitch: Boolean);
begin
  m_bLimitPitch := bLimitPitch;
end;

procedure CModelViewerCamera.SetViewQuat(q: TD3DXQuaternion);
begin
  m_ViewArcBall.SetQuatNow(q);
  m_bDragSinceLastUpdate := True;
end;

procedure CModelViewerCamera.SetWorldQuat(q: TD3DXQuaternion);
begin
  m_WorldArcBall.SetQuatNow(q);
  m_bDragSinceLastUpdate := True;
end;

function CModelViewerCamera.GetWorldMatrix: PD3DXMatrix;
begin
  Result:= @m_mWorld;
end;

procedure CModelViewerCamera.SetWorldMatrix(const mWorld: TD3DXMatrix);
begin
  m_mWorld := mWorld;
  m_bDragSinceLastUpdate := True;
end;


//--------------------------------------------------------------------------------------
// Desc: Returns a view matrix for rendering to a face of a cubemap.
//--------------------------------------------------------------------------------------
function DXUTGetCubeMapViewMatrix(dwFace: TD3DCubemapFaces): TD3DXMatrix;
var
  vEyePt: TD3DXVector3;
  vLookDir: TD3DXVector3;
  vUpDir: TD3DXVector3;
  mView: TD3DXMatrixA16;
begin
  vEyePt:= D3DXVector3(0.0, 0.0, 0.0);

  case dwFace of
    D3DCUBEMAP_FACE_POSITIVE_X:
    begin
      vLookDir := D3DXVector3( 1.0, 0.0, 0.0 );
      vUpDir   := D3DXVector3( 0.0, 1.0, 0.0 );
    end;
    D3DCUBEMAP_FACE_NEGATIVE_X:
    begin
      vLookDir := D3DXVector3(-1.0, 0.0, 0.0 );
      vUpDir   := D3DXVector3( 0.0, 1.0, 0.0 );
    end;
    D3DCUBEMAP_FACE_POSITIVE_Y:
    begin
      vLookDir := D3DXVector3( 0.0, 1.0, 0.0 );
      vUpDir   := D3DXVector3( 0.0, 0.0,-1.0 );
    end;
    D3DCUBEMAP_FACE_NEGATIVE_Y:
    begin
      vLookDir := D3DXVector3( 0.0,-1.0, 0.0 );
      vUpDir   := D3DXVector3( 0.0, 0.0, 1.0 );
    end;
    D3DCUBEMAP_FACE_POSITIVE_Z:
    begin
      vLookDir := D3DXVector3( 0.0, 0.0, 1.0 );
      vUpDir   := D3DXVector3( 0.0, 1.0, 0.0 );
    end;
    D3DCUBEMAP_FACE_NEGATIVE_Z:
    begin
      vLookDir := D3DXVector3( 0.0, 0.0,-1.0 );
      vUpDir   := D3DXVector3( 0.0, 1.0, 0.0 );
    end;
  end;

  // Set the view transform for this cubemap surface
  D3DXMatrixLookAtLH(mView, vEyePt, vLookDir, vUpDir);
  Result:= mView;
end;


//--------------------------------------------------------------------------------------
// Returns the string for the given D3DFORMAT.
//--------------------------------------------------------------------------------------
function DXUTD3DFormatToString(format: TD3DFormat; bWithPrefix: Boolean): PWideChar;
begin
  case format of
    D3DFMT_UNKNOWN:         Result:= 'D3DFMT_UNKNOWN';
    D3DFMT_R8G8B8:          Result:= 'D3DFMT_R8G8B8';
    D3DFMT_A8R8G8B8:        Result:= 'D3DFMT_A8R8G8B8';
    D3DFMT_X8R8G8B8:        Result:= 'D3DFMT_X8R8G8B8';
    D3DFMT_R5G6B5:          Result:= 'D3DFMT_R5G6B5';
    D3DFMT_X1R5G5B5:        Result:= 'D3DFMT_X1R5G5B5';
    D3DFMT_A1R5G5B5:        Result:= 'D3DFMT_A1R5G5B5';
    D3DFMT_A4R4G4B4:        Result:= 'D3DFMT_A4R4G4B4';
    D3DFMT_R3G3B2:          Result:= 'D3DFMT_R3G3B2';
    D3DFMT_A8:              Result:= 'D3DFMT_A8';
    D3DFMT_A8R3G3B2:        Result:= 'D3DFMT_A8R3G3B2';
    D3DFMT_X4R4G4B4:        Result:= 'D3DFMT_X4R4G4B4';
    D3DFMT_A2B10G10R10:     Result:= 'D3DFMT_A2B10G10R10';
    D3DFMT_A8B8G8R8:        Result:= 'D3DFMT_A8B8G8R8';
    D3DFMT_X8B8G8R8:        Result:= 'D3DFMT_X8B8G8R8';
    D3DFMT_G16R16:          Result:= 'D3DFMT_G16R16';
    D3DFMT_A2R10G10B10:     Result:= 'D3DFMT_A2R10G10B10';
    D3DFMT_A16B16G16R16:    Result:= 'D3DFMT_A16B16G16R16';
    D3DFMT_A8P8:            Result:= 'D3DFMT_A8P8';
    D3DFMT_P8:              Result:= 'D3DFMT_P8';
    D3DFMT_L8:              Result:= 'D3DFMT_L8';
    D3DFMT_A8L8:            Result:= 'D3DFMT_A8L8';
    D3DFMT_A4L4:            Result:= 'D3DFMT_A4L4';
    D3DFMT_V8U8:            Result:= 'D3DFMT_V8U8';
    D3DFMT_L6V5U5:          Result:= 'D3DFMT_L6V5U5';
    D3DFMT_X8L8V8U8:        Result:= 'D3DFMT_X8L8V8U8';
    D3DFMT_Q8W8V8U8:        Result:= 'D3DFMT_Q8W8V8U8';
    D3DFMT_V16U16:          Result:= 'D3DFMT_V16U16';
    D3DFMT_A2W10V10U10:     Result:= 'D3DFMT_A2W10V10U10';
    D3DFMT_UYVY:            Result:= 'D3DFMT_UYVY';
    D3DFMT_YUY2:            Result:= 'D3DFMT_YUY2';
    D3DFMT_DXT1:            Result:= 'D3DFMT_DXT1';
    D3DFMT_DXT2:            Result:= 'D3DFMT_DXT2';
    D3DFMT_DXT3:            Result:= 'D3DFMT_DXT3';
    D3DFMT_DXT4:            Result:= 'D3DFMT_DXT4';
    D3DFMT_DXT5:            Result:= 'D3DFMT_DXT5';
    D3DFMT_D16_LOCKABLE:    Result:= 'D3DFMT_D16_LOCKABLE';
    D3DFMT_D32:             Result:= 'D3DFMT_D32';
    D3DFMT_D15S1:           Result:= 'D3DFMT_D15S1';
    D3DFMT_D24S8:           Result:= 'D3DFMT_D24S8';
    D3DFMT_D24X8:           Result:= 'D3DFMT_D24X8';
    D3DFMT_D24X4S4:         Result:= 'D3DFMT_D24X4S4';
    D3DFMT_D16:             Result:= 'D3DFMT_D16';
    D3DFMT_L16:             Result:= 'D3DFMT_L16';
    D3DFMT_VERTEXDATA:      Result:= 'D3DFMT_VERTEXDATA';
    D3DFMT_INDEX16:         Result:= 'D3DFMT_INDEX16';
    D3DFMT_INDEX32:         Result:= 'D3DFMT_INDEX32';
    D3DFMT_Q16W16V16U16:    Result:= 'D3DFMT_Q16W16V16U16';
    D3DFMT_MULTI2_ARGB8:    Result:= 'D3DFMT_MULTI2_ARGB8';
    D3DFMT_R16F:            Result:= 'D3DFMT_R16F';
    D3DFMT_G16R16F:         Result:= 'D3DFMT_G16R16F';
    D3DFMT_A16B16G16R16F:   Result:= 'D3DFMT_A16B16G16R16F';
    D3DFMT_R32F:            Result:= 'D3DFMT_R32F';
    D3DFMT_G32R32F:         Result:= 'D3DFMT_G32R32F';
    D3DFMT_A32B32G32R32F:   Result:= 'D3DFMT_A32B32G32R32F';
    D3DFMT_CxV8U8:          Result:= 'D3DFMT_CxV8U8';
  else
    Result:= 'Unknown format';
  end;
  if (bWithPrefix or (Pos('D3DFMT_', Result) = 0)) then {nothing}
  else Result:= Result + Length('D3DFMT_'); 
end;



//--------------------------------------------------------------------------------------
constructor CDXUTLineManager.Create;
begin
  m_pd3dDevice := nil;
  m_pD3DXLine := nil;
end;


//--------------------------------------------------------------------------------------
destructor CDXUTLineManager.Destroy;
begin
  OnDeletedDevice;
end;


//--------------------------------------------------------------------------------------
function CDXUTLineManager.OnCreatedDevice(pd3dDevice: IDirect3DDevice9): HRESULT;
begin
  m_pd3dDevice := pd3dDevice;

  Result := D3DXCreateLine(m_pd3dDevice, m_pD3DXLine);
  if FAILED(Result) then Exit;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTLineManager.OnResetDevice: HRESULT;
begin
  if (m_pD3DXLine <> nil) then
    m_pD3DXLine.OnResetDevice;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTLineManager.OnRender: HRESULT;
var
  bDrawingHasBegun: Boolean;
  fLastWidth: Single;
  bLastAntiAlias: Boolean;
  i: Integer;
  LineNode: PLineNode;
begin
  if (nil = m_pD3DXLine) then
  begin
    Result:= E_INVALIDARG;
    Exit;
  end;

  bDrawingHasBegun := False;
  fLastWidth := 0.0;
  bLastAntiAlias := False;

  for i:= 0 to Length(m_LinesList) - 1 do 
  begin
    LineNode:= m_LinesList[i];
    if (LineNode <> nil) then
    begin
      if not bDrawingHasBegun or
         (fLastWidth <> LineNode.fWidth) or
         (bLastAntiAlias <> LineNode.bAntiAlias) then
      begin
        if (bDrawingHasBegun) then
        begin
          Result := m_pD3DXLine._End;
          if FAILED(Result) then Exit;
        end;

        m_pD3DXLine.SetWidth(LineNode.fWidth);
        m_pD3DXLine.SetAntialias(LineNode.bAntiAlias);

        fLastWidth := LineNode.fWidth;
        bLastAntiAlias := LineNode.bAntiAlias;

        Result := m_pD3DXLine._Begin;
        if FAILED(Result) then Exit;
        bDrawingHasBegun := True;
      end;

      Result := m_pD3DXLine.Draw(@LineNode.pVertexList[0], LineNode.dwVertexListCount, LineNode.Color);
      if FAILED(Result) then Exit;
    end;
  end;

  if (bDrawingHasBegun) then
  begin
    Result := m_pD3DXLine._End;
    if FAILED(Result) then Exit;
  end;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTLineManager.OnLostDevice: HRESULT;
begin
  if (m_pD3DXLine <> nil) then m_pD3DXLine.OnLostDevice;
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTLineManager.OnDeletedDevice: HRESULT;
begin
  RemoveAllLines;
  SAFE_RELEASE(m_pD3DXLine);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTLineManager.AddLine(pnLineID: PInteger; pVertexList: PD3DXVector2; dwVertexListCount: DWORD; Color: TD3DColor; fWidth: Single; fScaleRatio: Single; bAntiAlias: Boolean): HRESULT;
var
  LineNode: PLineNode;
  i: Integer;
begin
  if (pVertexList = nil) or (dwVertexListCount = 0) then
  begin
    Result:= E_INVALIDARG;
    Exit;
  end;

  LineNode:= nil;
try
  New(LineNode);
  ZeroMemory(LineNode, SizeOf(TLineNode));

  LineNode.nLineID := Length(m_LinesList);
  LineNode.Color := Color;
  LineNode.fWidth := fWidth;
  LineNode.bAntiAlias := bAntiAlias;
  LineNode.dwVertexListCount := dwVertexListCount;

  if (pnLineID <> nil) then pnLineID^ := LineNode.nLineID;

  GetMem(LineNode.pVertexList, dwVertexListCount*SizeOf(TD3DXVector2));
except
  if (LineNode <> nil) then Dispose(LineNode); 
  Result:= E_OUTOFMEMORY;
  Exit;
end;

  for i:= 0 to dwVertexListCount-1 do
  begin
    D3DXVec2Scale(LineNode.pVertexList[i], PD3DXVector2Array(pVertexList)[i], fScaleRatio);
  end;

  SetLength(m_LinesList, Length(m_LinesList)+1);
  m_LinesList[Length(m_LinesList)-1]:= LineNode;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTLineManager.AddRect(out pnLineID: Integer; const rc: TRect; Color: TD3DColor; fWidth: Single; fScaleRatio: Single; bAntiAlias: Boolean): HRESULT;
var
  vertexList: array[0..7] of TD3DXVector2;
begin
  if (fWidth > 2.0) then
  begin
    vertexList[0].x := rc.left;
    vertexList[0].y := rc.top - (fWidth/2.0);

    vertexList[1].x := rc.left;
    vertexList[1].y := rc.bottom + (fWidth/2.0);

    vertexList[2].x := rc.left;
    vertexList[2].y := rc.bottom - 0.5;

    vertexList[3].x := rc.right;
    vertexList[3].y := rc.bottom - 0.5;

    vertexList[4].x := rc.right;
    vertexList[4].y := rc.bottom + (fWidth/2.0);

    vertexList[5].x := rc.right;
    vertexList[5].y := rc.top - (fWidth/2.0);

    vertexList[6].x := rc.right;
    vertexList[6].y := rc.top;

    vertexList[7].x := rc.left;
    vertexList[7].y := rc.top;

    Result:= AddLine(@pnLineID, @vertexList[0], 8, Color, fWidth, fScaleRatio, bAntiAlias);
  end else
  begin
    vertexList[0].x := rc.left;
    vertexList[0].y := rc.top;

    vertexList[1].x := rc.left;
    vertexList[1].y := rc.bottom;

    vertexList[2].x := rc.right;
    vertexList[2].y := rc.bottom;

    vertexList[3].x := rc.right;
    vertexList[3].y := rc.top;

    vertexList[4].x := rc.left;
    vertexList[4].y := rc.top;

    Result:= AddLine(@pnLineID, @vertexList[0], 5, Color, fWidth, fScaleRatio, bAntiAlias);
  end;
end;



//--------------------------------------------------------------------------------------
function CDXUTLineManager.RemoveLine(nLineID: Integer): HRESULT;
var
  LineNode: PLineNode;
  i: Integer;
begin
  for i:= 0 to Length(m_LinesList)-1 do
  begin
    LineNode := m_LinesList[i];
    if (LineNode <> nil) and (LineNode.nLineID = nLineID) then
    begin
      FreeMem(LineNode.pVertexList);
      Dispose(LineNode);
      m_LinesList[i]:= nil;
    end;
  end;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTLineManager.RemoveAllLines: HRESULT;
var
  LineNode: PLineNode;
  i: Integer;
begin
  for i:= 0 to Length(m_LinesList) - 1 do
  begin
    LineNode := m_LinesList[i];
    if (LineNode <> nil) then
    begin
      FreeMem(LineNode.pVertexList);
      Dispose(LineNode);
    end;
  end;
  SetLength(m_LinesList, 0);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
{$IFDEF DEBUG}
var
  CDXUTTextHelper_InstanceCount: Integer = 0;

{$ENDIF}
constructor CDXUTTextHelper.Create(pFont: ID3DXFont; pSprite: ID3DXSprite; nLineHeight: Integer);
begin
  m_pFont := pFont;
  m_pSprite := pSprite;
  m_clr := D3DXColor(1,1,1,1);
  m_pt.x := 0;
  m_pt.y := 0;
  m_nLineHeight := nLineHeight;
{$IFDEF DEBUG}
  Inc(CDXUTTextHelper_InstanceCount);
  if CDXUTTextHelper_InstanceCount > 25 then
    OutputDebugString('HINT: Are you sure more than 25 instances of CDXUTTextHelper is really needed? ...bug...bug...');
{$ENDIF}
end;

destructor CDXUTTextHelper.Destroy;
begin
{$IFDEF DEBUG}
  Dec(CDXUTTextHelper_InstanceCount);
{$ENDIF}
  inherited;
end;

procedure CDXUTTextHelper.SetInsertionPos(x, y: Integer);
begin
  m_pt.x := x; m_pt.y := y;
end;

procedure CDXUTTextHelper.SetForegroundColor(clr: TD3DXColor);
begin
  m_clr := clr;
end;

//--------------------------------------------------------------------------------------
function CDXUTTextHelper.DrawFormattedTextLine(const strMsg: PWideChar; args: array of const): HRESULT;
var
  strBuffer: array[0..511] of WideChar;
begin
  // WideFormatBuf(strBuffer, 512, strMsg, Length(strMsg), args);
  StringCchFormat(strBuffer, 512, strMsg, args);
  strBuffer[511] := #0;
  Result:= DrawTextLine(strBuffer);
end;

{$IFNDEF FPC}
//--------------------------------------------------------------------------------------
function CDXUTTextHelper.DrawFormattedTextLine(const strMsg: WideString; args: array of const): HRESULT;
begin
  Result := DrawFormattedTextLine(PWideChar(strMsg), args);
end;

{$ENDIF}
//--------------------------------------------------------------------------------------
function CDXUTTextHelper.DrawTextLine(const strMsg: PWideChar): HRESULT;
var
  rc: TRect;
begin
  if (nil = m_pFont) then
  begin
    Result:= DXUT_ERR_MSGBOX('DrawTextLine', E_INVALIDARG);
    Exit;
  end;

  SetRect(rc, m_pt.x, m_pt.y, 0, 0 );
  Result := m_pFont.DrawTextW(m_pSprite, strMsg, -1, @rc, DT_NOCLIP, D3DXColorToDWord(m_clr));
  if FAILED(Result) then
  begin
    Result:= DXTRACE_ERR_MSGBOX('DrawText', Result);
    Exit;
  end;

  Inc(m_pt.y, m_nLineHeight);

  Result:= S_OK;
end;


{$IFNDEF FPC}
//--------------------------------------------------------------------------------------
function CDXUTTextHelper.DrawTextLine(const strMsg: PAnsiChar): HRESULT;
var
  rc: TRect;
begin
  if (nil = m_pFont) then
  begin
    Result:= DXUT_ERR_MSGBOX('DrawTextLine', E_INVALIDARG);
    Exit;
  end;

  SetRect(rc, m_pt.x, m_pt.y, 0, 0 );
  Result := m_pFont.DrawTextA(m_pSprite, strMsg, -1, @rc, DT_NOCLIP, D3DXColorToDWord(m_clr));
  if FAILED(Result) then
  begin
    Result:= DXTRACE_ERR_MSGBOX('DrawText', Result);
    Exit;
  end;

  Inc(m_pt.y, m_nLineHeight);

  Result:= S_OK;
end;
{$ENDIF}

{$IFDEF BORLAND}{$IFNDEF COMPILER6_UP}
function CDXUTTextHelper.DrawTextLine(const strMsg: String): HRESULT;
begin
  Result:= DrawTextLine(PAnsiChar(strMsg));
end;

{$ENDIF}{$ENDIF}

function CDXUTTextHelper.DrawFormattedTextLine(const rc: TRect; dwFlags: DWORD; const strMsg: PWideChar; args: array of const): HRESULT;
var
  strBuffer: array[0..511] of WideChar;
begin
  StringCchFormat(strBuffer, 512, strMsg, args);
  Result:= DrawTextLine(rc, dwFlags, strBuffer);
end;


function CDXUTTextHelper.DrawTextLine(const rc: TRect; dwFlags: DWORD; const strMsg: PWideChar): HRESULT; 
begin
  if (nil = m_pFont) then
  begin
    Result:= DXUT_ERR_MSGBOX('DrawTextLine', E_INVALIDARG);
    Exit;
  end;

  Result := m_pFont.DrawTextW(m_pSprite, strMsg, -1, @rc, dwFlags, D3DXColorToDWord(m_clr));
  if FAILED(Result) then
  begin
    Result:= DXTRACE_ERR_MSGBOX('DrawText', Result);
    Exit;
  end;

  Inc(m_pt.y, m_nLineHeight);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
procedure CDXUTTextHelper._Begin;
begin
  if (m_pSprite <> nil) then
    m_pSprite._Begin(D3DXSPRITE_ALPHABLEND or D3DXSPRITE_SORT_TEXTURE);
end;

procedure CDXUTTextHelper._End;
begin
  if (m_pSprite <> nil) then
    m_pSprite._End;
end;



//--------------------------------------------------------------------------------------
constructor CDXUTDirectionWidget.Create;
begin
  m_fRadius := 1.0;
  m_vDefaultDir := D3DXVector3(0,1,0);
  m_vCurrentDir := m_vDefaultDir;
  m_nRotateMask := MOUSE_RIGHT_BUTTON;

  m_ArcBall:= CD3DArcBall.Create;

  D3DXMatrixIdentity(m_mView);
  D3DXMatrixIdentity(m_mRot);
  D3DXMatrixIdentity(m_mRotSnapshot);
end;

destructor CDXUTDirectionWidget.Destroy;
begin
  FreeAndNil(m_ArcBall);
  inherited;
end;


const
  g_strBuffer: PAnsiChar =
    'float4 g_MaterialDiffuseColor;      // Material''s diffuse color'#10#13 +
    'float3 g_LightDir;                  // Light''s direction in world space'#10#13 +
    'float4x4 g_mWorld;                  // World matrix for object'#10#13 +
    'float4x4 g_mWorldViewProjection;    // World * View * Projection matrix'#10#13 +
    ''#10#13 +
    'struct VS_OUTPUT'#10#13 +
    '{'#10#13 +
    '    float4 Position   : POSITION;   // vertex position'#10#13 +
    '    float4 Diffuse    : COLOR0;     // vertex diffuse color'#10#13 +
    '};'#10#13 +
    ''#10#13 +
    'VS_OUTPUT RenderWith1LightNoTextureVS( float4 vPos : POSITION,'#10#13 +
    '                                       float3 vNormal : NORMAL )'#10#13 +
    '{'#10#13 +
    '    VS_OUTPUT Output;'#10#13 +
    ''#10#13 +
    '    // Transform the position from object space to homogeneous projection space'#10#13 +
    '    Output.Position = mul(vPos, g_mWorldViewProjection);'#10#13 +
    ''#10#13 +
    '    // Transform the normal from object space to world space'#10#13 +
    '    float3 vNormalWorldSpace;'#10#13 +
    '    vNormalWorldSpace = normalize(mul(vNormal, (float3x3)g_mWorld)); // normal (world space)'#10#13 +
    ''#10#13 +
    '    // Compute simple directional lighting equation'#10#13 +
    '    Output.Diffuse.rgb = g_MaterialDiffuseColor * max(0,dot(vNormalWorldSpace, g_LightDir));'#10#13 +
    '    Output.Diffuse.a = 1.0f;'#10#13 +
    ''#10#13 +
    '    return Output;'#10#13 +
    '}'#10#13 +
    ''#10#13 +
    'float4 RenderWith1LightNoTexturePS( float4 Diffuse : COLOR0 ) : COLOR0'#10#13 +
    '{'#10#13 +
    '    return Diffuse;'#10#13 +
    '}'#10#13 +
    ''#10#13 +
    'technique RenderWith1LightNoTexture'#10#13 +
    '{'#10#13 +
    '    pass P0'#10#13 +
    '    {'#10#13 +
    '        VertexShader = compile vs_2_0 RenderWith1LightNoTextureVS();'#10#13 +
    '        PixelShader  = compile ps_2_0 RenderWith1LightNoTexturePS();'#10#13 +
    '    }'#10#13 +
    '}'#10#13 +
    '';

//--------------------------------------------------------------------------------------
class function CDXUTDirectionWidget.StaticOnCreateDevice(
  pd3dDevice: IDirect3DDevice9): HRESULT;
var
  rgdwAdjacency: PDWORD;
  dwBufferSize: LongWord;
begin
  s_pd3dDevice := pd3dDevice;

  dwBufferSize := StrLen(g_strBuffer) + 1;

  Result:= D3DXCreateEffect(s_pd3dDevice, g_strBuffer, dwBufferSize, nil, nil, D3DXFX_NOT_CLONEABLE, nil, s_pEffect, nil);
  if V_Failed(Result) then Exit;

  // Load the mesh with D3DX and get back a ID3DXMesh*.  For this
  // sample we'll ignore the X file's embedded materials since we know
  // exactly the model we're loading.  See the mesh samples such as
  // "OptimizedMesh" for a more generic mesh loading example.
  Result:= DXUTCreateArrowMeshFromInternalArray(s_pd3dDevice, s_pMesh);
  if V_Failed(Result) then Exit;

  // Optimize the mesh for this graphics card's vertex cache
  // so when rendering the mesh's triangle list the vertices will
  // cache hit more often so it won't have to re-execute the vertex shader
  // on those vertices so it will improve perf.
  try
    GetMem(rgdwAdjacency, SizeOf(DWORD)*s_pMesh.GetNumFaces*3);
  except
    Result:= E_OUTOFMEMORY;
    Exit;
  end;
  V(s_pMesh.GenerateAdjacency(1e-6, rgdwAdjacency));
  V(s_pMesh.OptimizeInplace(D3DXMESHOPT_VERTEXCACHE, rgdwAdjacency, nil, nil, nil));
  FreeMem(rgdwAdjacency);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDirectionWidget.OnResetDevice(const pBackBufferSurfaceDesc: TD3DSurfaceDesc): HRESULT;
begin
  m_ArcBall.SetWindow(pBackBufferSurfaceDesc.Width, pBackBufferSurfaceDesc.Height);
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
class procedure CDXUTDirectionWidget.StaticOnLostDevice;
begin
  if (s_pEffect <> nil) then s_pEffect.OnLostDevice;
end;


//--------------------------------------------------------------------------------------
class procedure CDXUTDirectionWidget.StaticOnDestroyDevice;
begin
  SAFE_RELEASE(s_pd3dDevice);
  SAFE_RELEASE(s_pEffect);
  SAFE_RELEASE(s_pMesh);
end;

procedure CDXUTDirectionWidget.SetLightDirection(vDir: TD3DXVector3);
begin
  m_vCurrentDir := vDir;
  m_vDefaultDir := vDir;
end;

procedure CDXUTDirectionWidget.SetButtonMask(nRotate: Integer = MOUSE_RIGHT_BUTTON);
begin
  m_nRotateMask := nRotate;
end;

function CDXUTDirectionWidget.IsBeingDragged: Boolean;
begin
  Result:= m_ArcBall.IsBeingDragged;
end;

//--------------------------------------------------------------------------------------
function CDXUTDirectionWidget.HandleMessages(hWnd: HWND; uMsg: Cardinal;
  wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  iMouseX, iMouseY: Integer;
begin
  Result:= iTrue;
  case uMsg of
    WM_LBUTTONDOWN,
    WM_MBUTTONDOWN,
     WM_RBUTTONDOWN:
    begin
      if (((m_nRotateMask and MOUSE_LEFT_BUTTON <> 0) and (uMsg = WM_LBUTTONDOWN)) or
          ((m_nRotateMask and MOUSE_MIDDLE_BUTTON <> 0) and (uMsg = WM_MBUTTONDOWN)) or
          ((m_nRotateMask and MOUSE_RIGHT_BUTTON <> 0) and (uMsg = WM_RBUTTONDOWN)) ) then
      begin
        iMouseX := LOWORD(DWORD(lParam));
        iMouseY := HIWORD(DWORD(lParam));
        m_ArcBall.OnBegin(iMouseX, iMouseY);
        SetCapture(hWnd);
      end;
      Exit;
    end;

    WM_MOUSEMOVE:
    begin
      if m_ArcBall.IsBeingDragged then 
      begin
        iMouseX := LOWORD(DWORD(lParam));
        iMouseY := HIWORD(DWORD(lParam));
        m_ArcBall.OnMove(iMouseX, iMouseY);
        UpdateLightDir;
      end;
      Exit;
    end;

    WM_LBUTTONUP,
    WM_MBUTTONUP,
    WM_RBUTTONUP:
    begin
      if (((m_nRotateMask and MOUSE_LEFT_BUTTON <> 0) and (uMsg = WM_LBUTTONUP))  or
          ((m_nRotateMask and MOUSE_MIDDLE_BUTTON <> 0) and (uMsg = WM_MBUTTONUP))  or
          ((m_nRotateMask and MOUSE_RIGHT_BUTTON <> 0) and (uMsg = WM_RBUTTONUP))) then
      begin
        m_ArcBall.OnEnd;
        ReleaseCapture;
      end;

      UpdateLightDir;
      Exit;
    end;

    WM_CAPTURECHANGED:
    begin
      if (THandle(lParam) <> hWnd) then
      begin
        if (m_nRotateMask and MOUSE_LEFT_BUTTON <> 0) or
           (m_nRotateMask and MOUSE_MIDDLE_BUTTON <> 0) or
           (m_nRotateMask and MOUSE_RIGHT_BUTTON <> 0) then
        begin
          m_ArcBall.OnEnd;
          ReleaseCapture;
        end;
      end;
      Exit;
    end;
  end;

  Result:= iFalse;
end;


//--------------------------------------------------------------------------------------
function CDXUTDirectionWidget.OnRender(color: TD3DXColor;
  const pmView, pmProj: TD3DXMatrix; const pEyePt: TD3DXVector3): HRESULT;
var
  iPass, cPasses: LongWord;
  mRotate: TD3DXMatrix;
  mScale: TD3DXMatrix;
  mTrans: TD3DXMatrix;
  mWorldViewProj: TD3DXMatrixA16;
  vEyePt: TD3DXVector3;
  mRotateA, mRotateB: TD3DXMatrix;
  vAt: TD3DXVector3;
  vUp: TD3DXVector3;
  vL: TD3DXVector3;
  mWorld: TD3DXMatrix;
  m: TD3DXMatrix;
  iSubset: Integer;
begin
  m_mView := pmView;

  // Render the light spheres so the user can visually see the light dir
  V(s_pEffect.SetTechnique('RenderWith1LightNoTexture'));
  V(s_pEffect.SetVector('g_MaterialDiffuseColor', PD3DXVector4(@color)^));

  D3DXVec3Normalize(vEyePt, pEyePt);
  V(s_pEffect.SetValue('g_LightDir', @vEyePt, SizeOf(TD3DXVector3)));

  // Rotate arrow model to point towards origin
  vAt := D3DXVector3(0,0,0);
  vUp := D3DXVector3(0,1,0);
  D3DXMatrixRotationX(mRotateB, D3DX_PI);
  D3DXMatrixLookAtLH(mRotateA, m_vCurrentDir, vAt, vUp);
  D3DXMatrixInverse(mRotateA, nil, mRotateA);
  // mRotate = mRotateB * mRotateA;
  D3DXMatrixMultiply(mRotate, mRotateB, mRotateA);

  D3DXVec3Scale(vL, m_vCurrentDir, m_fRadius * 1.0);
  D3DXMatrixTranslation(mTrans, vL.x, vL.y, vL.z);
  D3DXMatrixScaling(mScale, m_fRadius*0.2, m_fRadius*0.2, m_fRadius*0.2);

  // mWorld = mRotate * mScale * mTrans;
  D3DXMatrixMultiply(m, mScale, mTrans);
  D3DXMatrixMultiply(mWorld, mRotate, m);

  // mWorldViewProj = mWorld * (m_mView) * (*pmProj);
  D3DXMatrixMultiply(m, m_mView, pmProj);
  D3DXMatrixMultiply(mWorldViewProj, mWorld, m);

  V(s_pEffect.SetMatrix('g_mWorldViewProjection', mWorldViewProj));
  V(s_pEffect.SetMatrix('g_mWorld', mWorld));

  for iSubset:= 0 to 1 do
  begin
    V(s_pEffect._Begin(@cPasses, 0));
    for iPass := 0 to cPasses - 1 do
    begin
      V(s_pEffect.BeginPass(iPass));
      V(s_pMesh.DrawSubset(iSubset));
      V(s_pEffect.EndPass);
    end;
    V(s_pEffect._End);
  end;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CDXUTDirectionWidget.UpdateLightDir: HRESULT;
var
  mInvView: TD3DXMatrix;
  mLastRotInv: TD3DXMatrix;
  mRot: TD3DXMatrix;
  m: TD3DXMatrix;
  pXBasis, pYBasis, pZBasis: PD3DXVector3;
begin
  D3DXMatrixInverse(mInvView, nil, m_mView);
  mInvView._41 := 0;
  mInvView._42 := 0;
  mInvView._43 := 0;

  D3DXMatrixInverse(mLastRotInv, nil, m_mRotSnapshot);

  mRot := m_ArcBall.GetRotationMatrix^;
  m_mRotSnapshot := mRot;

  // Accumulate the delta of the arcball's rotation in view space.
  // Note that per-frame delta rotations could be problematic over long periods of time.
  // m_mRot *= m_mView * mLastRotInv * mRot * mInvView;
  D3DXMatrixMultiply(m, mRot, mInvView);
  D3DXMatrixMultiply(m, mLastRotInv, m);
  D3DXMatrixMultiply(m, m_mView, m);
  D3DXMatrixMultiply(m_mRot, m_mRot, m);

  // Since we're accumulating delta rotations, we need to orthonormalize
  // the matrix to prevent eventual matrix skew
  pXBasis := PD3DXVector3(@m_mRot._11);
  pYBasis := PD3DXVector3(@m_mRot._21);
  pZBasis := PD3DXVector3(@m_mRot._31);
  D3DXVec3Normalize(pXBasis^, pXBasis^);
  D3DXVec3Cross(pYBasis^, pZBasis^, pXBasis^);
  D3DXVec3Normalize(pYBasis^, pYBasis^);
  D3DXVec3Cross(pZBasis^, pXBasis^, pYBasis^);

  // Transform the default direction vector by the light's rotation matrix
  D3DXVec3TransformNormal(m_vCurrentDir, m_vDefaultDir, m_mRot);

  Result:= S_OK;
end;



//--------------------------------------------------------------------------------------
// Direct3D9 dynamic linking support -- calls top-level D3D9 APIs with graceful
// failure if APIs are not present.
//--------------------------------------------------------------------------------------

type
  // Function prototypes
  TDirect3DCreate9 = function (SDKVersion: LongWord): Pointer; stdcall;
  TD3DPerf_BeginEvent = function (col: TD3DColor; wszName: PWideChar): Integer; stdcall;
  TD3DPerf_EndEvent = function: Integer; stdcall;
  TD3DPerf_SetMarker = procedure (col: TD3DColor; wszName: PWideChar); stdcall;
  TD3DPerf_SetRegion = procedure (col: TD3DColor; wszName: PWideChar); stdcall;
  TD3DPerf_QueryRepeatFrame = function: BOOL; stdcall;
  TD3DPerf_SetOptions = procedure (dwOptions: DWORD); stdcall;
  TD3DPerf_GetStatus = function: DWORD; stdcall;

var
  // Module and function pointers
  s_hModD3D9: HMODULE = 0;
  s_DynamicDirect3DCreate9: TDirect3DCreate9 = nil;
  s_DynamicD3DPERF_BeginEvent: TD3DPerf_BeginEvent = nil;
  s_DynamicD3DPERF_EndEvent: TD3DPerf_EndEvent = nil;
  s_DynamicD3DPERF_SetMarker: TD3DPerf_SetMarker = nil;
  s_DynamicD3DPERF_SetRegion: TD3DPerf_SetRegion = nil;
  s_DynamicD3DPERF_QueryRepeatFrame: TD3DPerf_QueryRepeatFrame = nil;
  s_DynamicD3DPERF_SetOptions: TD3DPerf_SetOptions = nil;
  s_DynamicD3DPERF_GetStatus: TD3DPerf_GetStatus = nil;

// Ensure function pointers are initialized
function DXUT_EnsureD3DAPIs: Boolean;
begin
  // If module is non-NULL, this function has already been called.  Note
  // that this doesn't guarantee that all D3D9 procaddresses were found.
  if (s_hModD3D9 <> 0) then
  begin
    Result:= True;
    Exit;
  end;

  Result:= False;

  // This may fail if DirectX 9 isn't installed
  s_hModD3D9 := LoadLibrary('d3d9.dll');
  if (s_hModD3D9 = 0) then Exit;

  s_DynamicDirect3DCreate9 :=          GetProcAddress(s_hModD3D9, 'Direct3DCreate9');
  s_DynamicD3DPERF_BeginEvent :=       GetProcAddress(s_hModD3D9, 'D3DPERF_BeginEvent');
  s_DynamicD3DPERF_EndEvent :=         GetProcAddress(s_hModD3D9, 'D3DPERF_EndEvent');
  s_DynamicD3DPERF_SetMarker :=        GetProcAddress(s_hModD3D9, 'D3DPERF_SetMarker');
  s_DynamicD3DPERF_SetRegion :=        GetProcAddress(s_hModD3D9, 'D3DPERF_SetRegion');
  s_DynamicD3DPERF_QueryRepeatFrame := GetProcAddress(s_hModD3D9, 'D3DPERF_QueryRepeatFrame');
  s_DynamicD3DPERF_SetOptions :=       GetProcAddress(s_hModD3D9, 'D3DPERF_SetOptions');
  s_DynamicD3DPERF_GetStatus :=        GetProcAddress(s_hModD3D9, 'D3DPERF_GetStatus');
  Result:= True;
end;

function DXUT_Dynamic_Direct3DCreate9(SDKVersion: LongWord): IDirect3D9; stdcall;
begin
  if DXUT_EnsureD3DAPIs and (@s_DynamicDirect3DCreate9 <> nil) then
  begin
    Result:= IDirect3D9(s_DynamicDirect3DCreate9(SDKVersion));
    if Assigned(Result) then Result._Release; // Delphi autoincrement reference count
  end else
    Result:= nil;
end;

function DXUT_Dynamic_D3DPERF_BeginEvent(col: TD3DColor; wszName: PWideChar): Integer; stdcall;
begin
  if DXUT_EnsureD3DAPIs and (@s_DynamicD3DPERF_BeginEvent <> nil)
  then Result:= s_DynamicD3DPERF_BeginEvent(col, wszName)
  else Result:= -1;
end;

function DXUT_Dynamic_D3DPERF_EndEvent: Integer; stdcall;
begin
  if DXUT_EnsureD3DAPIs and (@s_DynamicD3DPERF_EndEvent <> nil)
  then Result:= s_DynamicD3DPERF_EndEvent
  else Result:= -1;
end;

procedure DXUT_Dynamic_D3DPERF_SetMarker(col: TD3DColor; wszName: PWideChar); stdcall;
begin
  if DXUT_EnsureD3DAPIs and (@s_DynamicD3DPERF_SetMarker <> nil)
  then s_DynamicD3DPERF_SetMarker(col, wszName);
end;

procedure DXUT_Dynamic_D3DPERF_SetRegion(col: TD3DColor; wszName: PWideChar); stdcall;
begin
  if DXUT_EnsureD3DAPIs and (@s_DynamicD3DPERF_SetRegion <> nil)
  then s_DynamicD3DPERF_SetRegion(col, wszName);
end;

function DXUT_Dynamic_D3DPERF_QueryRepeatFrame: BOOL; stdcall;
begin
  if DXUT_EnsureD3DAPIs and (@s_DynamicD3DPERF_QueryRepeatFrame <> nil)
  then Result:= s_DynamicD3DPERF_QueryRepeatFrame
  else Result:= False;
end;

procedure DXUT_Dynamic_D3DPERF_SetOptions(dwOptions: DWORD); stdcall;
begin
  if DXUT_EnsureD3DAPIs and (@s_DynamicD3DPERF_SetOptions <> nil)
  then s_DynamicD3DPERF_SetOptions(dwOptions);
end;

function DXUT_Dynamic_D3DPERF_GetStatus: DWORD; stdcall;
begin
  if DXUT_EnsureD3DAPIs and (@s_DynamicD3DPERF_GetStatus <> nil)
  then Result:= s_DynamicD3DPERF_GetStatus
  else Result:= 0;
end;


//--------------------------------------------------------------------------------------
// Trace a string description of a decl
//--------------------------------------------------------------------------------------
procedure DXUTTraceDecl(const decl: TFVFDeclaration);
var
  iDecl: Integer;
begin
  for iDecl:= 0 to MAX_FVF_DECL_SIZE - 1 do
  begin
    if (decl[iDecl].Stream = $ff) then Break;

    DXUTOutputDebugString('decl[%d]=Stream:%d, Offset:%d, %s, %s, %s, UsageIndex:%d'#10,
                          [iDecl,
                           decl[iDecl].Stream,
                           decl[iDecl].Offset,
                           DXUTTraceD3DDECLTYPEtoString(decl[iDecl]._Type),
                           DXUTTraceD3DDECLMETHODtoString(decl[iDecl].Method),
                           DXUTTraceD3DDECLUSAGEtoString(decl[iDecl].Usage),
                           decl[iDecl].UsageIndex]);
  end;

  DXUTOutputDebugString('decl[%d]=D3DDECL_END'#10, [iDecl]);
end;


//--------------------------------------------------------------------------------------
function DXUTTraceD3DDECLTYPEtoString(t: TD3DDeclType): PWideChar;
begin
  case t of
    D3DDECLTYPE_FLOAT1: Result := 'D3DDECLTYPE_FLOAT1';
    D3DDECLTYPE_FLOAT2: Result := 'D3DDECLTYPE_FLOAT2';
    D3DDECLTYPE_FLOAT3: Result := 'D3DDECLTYPE_FLOAT3';
    D3DDECLTYPE_FLOAT4: Result := 'D3DDECLTYPE_FLOAT4';
    D3DDECLTYPE_D3DCOLOR: Result := 'D3DDECLTYPE_D3DCOLOR';
    D3DDECLTYPE_UBYTE4: Result := 'D3DDECLTYPE_UBYTE4';
    D3DDECLTYPE_SHORT2: Result := 'D3DDECLTYPE_SHORT2';
    D3DDECLTYPE_SHORT4: Result := 'D3DDECLTYPE_SHORT4';
    D3DDECLTYPE_UBYTE4N: Result := 'D3DDECLTYPE_UBYTE4N';
    D3DDECLTYPE_SHORT2N: Result := 'D3DDECLTYPE_SHORT2N';
    D3DDECLTYPE_SHORT4N: Result := 'D3DDECLTYPE_SHORT4N';
    D3DDECLTYPE_USHORT2N: Result := 'D3DDECLTYPE_USHORT2N';
    D3DDECLTYPE_USHORT4N: Result := 'D3DDECLTYPE_USHORT4N';
    D3DDECLTYPE_UDEC3: Result := 'D3DDECLTYPE_UDEC3';
    D3DDECLTYPE_DEC3N: Result := 'D3DDECLTYPE_DEC3N';
    D3DDECLTYPE_FLOAT16_2: Result := 'D3DDECLTYPE_FLOAT16_2';
    D3DDECLTYPE_FLOAT16_4: Result := 'D3DDECLTYPE_FLOAT16_4';
    D3DDECLTYPE_UNUSED: Result := 'D3DDECLTYPE_UNUSED';
  else
    Result:= 'D3DDECLTYPE Unknown';
  end;
end;

function DXUTTraceD3DDECLMETHODtoString(m: TD3DDeclMethod): PWideChar;
begin
  case m of
    D3DDECLMETHOD_DEFAULT: Result := 'D3DDECLMETHOD_DEFAULT';
    D3DDECLMETHOD_PARTIALU: Result := 'D3DDECLMETHOD_PARTIALU';
    D3DDECLMETHOD_PARTIALV: Result := 'D3DDECLMETHOD_PARTIALV';
    D3DDECLMETHOD_CROSSUV: Result := 'D3DDECLMETHOD_CROSSUV';
    D3DDECLMETHOD_UV: Result := 'D3DDECLMETHOD_UV';
    D3DDECLMETHOD_LOOKUP: Result := 'D3DDECLMETHOD_LOOKUP';
    D3DDECLMETHOD_LOOKUPPRESAMPLED: Result := 'D3DDECLMETHOD_LOOKUPPRESAMPLED';
  else
    Result := 'D3DDECLMETHOD Unknown';
  end;
end;

function DXUTTraceD3DDECLUSAGEtoString(u: TD3DDeclUsage): PWideChar;
begin
  case u of
    D3DDECLUSAGE_POSITION: Result := 'D3DDECLUSAGE_POSITION';
    D3DDECLUSAGE_BLENDWEIGHT: Result := 'D3DDECLUSAGE_BLENDWEIGHT';
    D3DDECLUSAGE_BLENDINDICES: Result := 'D3DDECLUSAGE_BLENDINDICES';
    D3DDECLUSAGE_NORMAL: Result := 'D3DDECLUSAGE_NORMAL';
    D3DDECLUSAGE_PSIZE: Result := 'D3DDECLUSAGE_PSIZE';
    D3DDECLUSAGE_TEXCOORD: Result := 'D3DDECLUSAGE_TEXCOORD';
    D3DDECLUSAGE_TANGENT: Result := 'D3DDECLUSAGE_TANGENT';
    D3DDECLUSAGE_BINORMAL: Result := 'D3DDECLUSAGE_BINORMAL';
    D3DDECLUSAGE_TESSFACTOR: Result := 'D3DDECLUSAGE_TESSFACTOR';
    D3DDECLUSAGE_POSITIONT: Result := 'D3DDECLUSAGE_POSITIONT';
    D3DDECLUSAGE_COLOR: Result := 'D3DDECLUSAGE_COLOR';
    D3DDECLUSAGE_FOG: Result := 'D3DDECLUSAGE_FOG';
    D3DDECLUSAGE_DEPTH: Result := 'D3DDECLUSAGE_DEPTH';
    D3DDECLUSAGE_SAMPLE: Result := 'D3DDECLUSAGE_SAMPLE';
  else
    Result := 'D3DDECLUSAGE Unknown';
  end;
end;



//--------------------------------------------------------------------------------------
// Multimon API handling for OSes with or without multimon API support
//--------------------------------------------------------------------------------------
const
  DXUT_PRIMARY_MONITOR = HMONITOR($12340042);
type
  TMonitorFromWindow = function(hWnd: HWND; dwFlags: DWORD): HMONITOR; stdcall;
  TGetMonitorInfo = function(hMonitor: HMONITOR; lpMonitorInfo: PMonitorInfo): Boolean; stdcall;

var
  {static} s_bInited_DXUTGetMonitorInfo: Boolean = False;
  {static} s_pFnGetMonitorInfo: TGetMonitorInfo = nil;
function DXUTGetMonitorInfo(hMonitor: HMONITOR; lpMonitorInfo: PMonitorInfo): Boolean;
var
  hUser32: HMODULE;
  osvi: TOSVersionInfo;
  bNT: Boolean;
  rcWork: TRect;
begin
  if not s_bInited_DXUTGetMonitorInfo then
  begin
    s_bInited_DXUTGetMonitorInfo := True;
    hUser32 := GetModuleHandle('USER32');
    if (hUser32 <> 0) then
    begin
      ZeroMemory(@osvi, SizeOf(osvi));
      osvi.dwOSVersionInfoSize := SizeOf(osvi);
      GetVersionEx(osvi);
      bNT := (VER_PLATFORM_WIN32_NT = osvi.dwPlatformId);
      if bNT
      then s_pFnGetMonitorInfo := GetProcAddress(hUser32, 'GetMonitorInfoW')
      else s_pFnGetMonitorInfo := GetProcAddress(hUser32, 'GetMonitorInfoA');
    end;
  end;

  if (@s_pFnGetMonitorInfo <> nil) then
  begin
    Result:= s_pFnGetMonitorInfo(hMonitor, lpMonitorInfo);
    Exit;
  end;

  if (hMonitor = DXUT_PRIMARY_MONITOR) and
     (lpMonitorInfo <> nil) and
     (lpMonitorInfo.cbSize >= SizeOf(TMonitorInfo)) and
     SystemParametersInfoA(SPI_GETWORKAREA, 0, @rcWork, 0) then
  begin
    lpMonitorInfo.rcMonitor.left := 0;
    lpMonitorInfo.rcMonitor.top  := 0;
    lpMonitorInfo.rcMonitor.right  := GetSystemMetrics(SM_CXSCREEN);
    lpMonitorInfo.rcMonitor.bottom := GetSystemMetrics(SM_CYSCREEN);
    lpMonitorInfo.rcWork := rcWork;
    lpMonitorInfo.dwFlags := MONITORINFOF_PRIMARY;
    Result:= True;
    Exit;
  end;
  Result:= False;
end;


var
  {static} s_bInited_DXUTMonitorFromWindow: Boolean = False;
  {static} s_pFnGetMonitorFronWindow: TMonitorFromWindow = nil;

function DXUTMonitorFromWindow(hWnd: HWND; dwFlags: DWORD): HMONITOR;
var
  hUser32: HMODULE;
begin
  if not s_bInited_DXUTMonitorFromWindow then
  begin
    s_bInited_DXUTMonitorFromWindow := True;
    hUser32 := GetModuleHandle('USER32');
    if (hUser32 <> 0) then
      s_pFnGetMonitorFronWindow := GetProcAddress(hUser32, 'MonitorFromWindow');
  end;

  if (@s_pFnGetMonitorFronWindow <> nil) then
  begin
    Result:= s_pFnGetMonitorFronWindow(hWnd, dwFlags);
    Exit;
  end;
  if (dwFlags and (MONITOR_DEFAULTTOPRIMARY or MONITOR_DEFAULTTONEAREST) <> 0) then
  begin
    Result:= DXUT_PRIMARY_MONITOR;
    Exit;
  end;
  Result:= 0;
end;


//--------------------------------------------------------------------------------------
// Get the desktop resolution of an adapter. This isn't the same as the current resolution 
// from GetAdapterDisplayMode since the device might be fullscreen 
//--------------------------------------------------------------------------------------
procedure DXUTGetDesktopResolution(AdapterOrdinal: LongWord; out pWidth, pHeight: LongWord);
var
  pd3dEnum: CD3DEnumeration;
  pAdapterInfo: CD3DEnumAdapterInfo;
  devMode: TDeviceModeW;
  strDeviceName: array[0..255] of WideChar; 
begin
  pd3dEnum := DXUTGetEnumeration;
  pAdapterInfo := pd3dEnum.GetAdapterInfo(AdapterOrdinal);
  ZeroMemory(@devMode, SizeOf(devMode));
  devMode.dmSize := SizeOf(devMode);
  MultiByteToWideChar(CP_ACP, 0, pAdapterInfo.AdapterIdentifier.DeviceName, -1, strDeviceName, 256);
  strDeviceName[255] := #0;
  EnumDisplaySettingsW(strDeviceName, ENUM_REGISTRY_SETTINGS, devMode);

  pWidth := devMode.dmPelsWidth;
  pHeight := devMode.dmPelsHeight;
end;


//--------------------------------------------------------------------------------------
function DXUTCreateRefDevice(hWnd: HWND; bNullRef: Boolean = True): IDirect3DDevice9;
var
  pD3D: IDirect3D9;
  Mode: TD3DDisplayMode;
  pp: TD3DPresentParameters;
  devType: TD3DDevType;
begin
  Result:= nil;

  pD3D := DXUT_Dynamic_Direct3DCreate9(D3D_SDK_VERSION);
  if (pD3D = nil) then Exit;

  pD3D.GetAdapterDisplayMode(0, Mode);

  ZeroMemory(@pp, SizeOf(pp));
  pp.BackBufferWidth  := 1;
  pp.BackBufferHeight := 1;
  pp.BackBufferFormat := Mode.Format;
  pp.BackBufferCount  := 1;
  pp.SwapEffect       := D3DSWAPEFFECT_COPY;
  pp.Windowed         := True;
  pp.hDeviceWindow    := hWnd;

  if bNullRef then devType:= D3DDEVTYPE_NULLREF else devType:= D3DDEVTYPE_REF;
  pD3D.CreateDevice(D3DADAPTER_DEFAULT, devType, hWnd,
                    D3DCREATE_HARDWARE_VERTEXPROCESSING, @pp, Result);
  // pD3D:= nil;
end;

{$IFDEF PROFILE}

// PROFILE is defined, so these macros call the D3DPERF functions
function DXUT_BeginPerfEvent(col: TD3DColor; wszName: PWideChar): Integer; 
begin
  Result:= DXUT_Dynamic_D3DPERF_BeginEvent(color, pstrMessage);
end;

function DXUT_EndPerfEvent: Integer;
begin
  Result:= DXUT_Dynamic_D3DPERF_EndEvent;
end;

procedure DXUT_SetPerfMarker(col: TD3DColor; wszName: PWideChar);
begin
  DXUT_Dynamic_D3DPERF_SetMarker(color, pstrMessage);
end;

{$ELSE}

// PROFILE is not defined, so these macros do nothing
function DXUT_BeginPerfEvent(col: TD3DColor; wszName: PWideChar): Integer;
begin Result:= -1; end;

function DXUT_EndPerfEvent: Integer;
begin Result:= -1; end;

procedure DXUT_SetPerfMarker(col: TD3DColor; wszName: PWideChar);
begin {(__noop)} end;

{$ENDIF}


type
  TXInputGetState = function (dwUserIndex: DWORD; out pState: TXInputState): DWORD; stdcall;
  TXInputSetState = function (dwUserIndex: DWORD; const pVibration: TXInputVibration): DWORD; stdcall;
  TXInputGetCapabilities = function (dwUserIndex: DWORD; dwFlags: DWORD; out pCapabilities: TXInputCapabilities): DWORD; stdcall;
  TXInputEnable = procedure (bEnable: BOOL); stdcall;



//--------------------------------------------------------------------------------------
// Does extra processing on XInput data to make it slightly more convenient to use
//--------------------------------------------------------------------------------------
const
  {static} s_pXInputGetState: TXInputGetState = nil;
  {static} s_pXInputGetCapabilities: TXInputGetCapabilities = nil;

function DXUTGetGamepadState(dwPort: DWORD; out pGamePad: TDXUTGamePad;
  bThumbstickDeadZone: Boolean = True; bSnapThumbstickToCardinals: Boolean = True): HRESULT;
var
  hInst: Windows.HINST;
  InputState: TXInputState;
  dwResult: DWORD;
  bWasConnected: Boolean;
  bPressed: Boolean;
begin
  if (dwPort >= DXUT_MAX_CONTROLLERS) {or (pGamePad = nil)} then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  if (@s_pXInputGetState = nil) or (@s_pXInputGetCapabilities = nil) then
  begin
    hInst := LoadLibrary( XINPUT_DLL);
    if (hInst <> 0) then
    begin
      s_pXInputGetState := GetProcAddress(hInst, 'XInputGetState');
      s_pXInputGetCapabilities := GetProcAddress(hInst, 'XInputGetCapabilities');
    end;
  end;
  if (@s_pXInputGetState = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  dwResult := s_pXInputGetState(dwPort, InputState);

  // Track insertion and removals
  bWasConnected := pGamePad.bConnected;
  pGamePad.bConnected := (dwResult = ERROR_SUCCESS);
  pGamePad.bRemoved   := (    bWasConnected and not pGamePad.bConnected);
  pGamePad.bInserted  := (not bWasConnected and     pGamePad.bConnected);

  // Don't update rest of the state if not connected
  if (not pGamePad.bConnected) then
  begin
    Result:= S_OK;
    Exit;
  end;

  // Store the capabilities of the device
  if (pGamePad.bInserted) then 
  begin
    ZeroMemory(@pGamePad, SizeOf(TDXUTGamePad));
    pGamePad.bConnected := True;
    pGamePad.bInserted  := True;
    if (@s_pXInputGetCapabilities <> nil)
    then s_pXInputGetCapabilities( dwPort, XINPUT_DEVTYPE_GAMEPAD, pGamePad.caps);
  end;

  // Copy gamepad to local structure (assumes that XINPUT_GAMEPAD at the front in CONTROLER_STATE)
  CopyMemory(@pGamePad, @InputState.Gamepad, SizeOf(TDXUTGamePad));

  if bSnapThumbstickToCardinals then
  begin
    // Apply deadzone to each axis independantly to slightly snap to up/down/left/right
    if (pGamePad.sThumbLX < DXUT_INPUT_DEADZONE) and (pGamePad.sThumbLX > -DXUT_INPUT_DEADZONE) then pGamePad.sThumbLX := 0;
    if (pGamePad.sThumbLY < DXUT_INPUT_DEADZONE) and (pGamePad.sThumbLY > -DXUT_INPUT_DEADZONE) then pGamePad.sThumbLY := 0;
    if (pGamePad.sThumbRX < DXUT_INPUT_DEADZONE) and (pGamePad.sThumbRX > -DXUT_INPUT_DEADZONE) then pGamePad.sThumbRX := 0;
    if (pGamePad.sThumbRY < DXUT_INPUT_DEADZONE) and (pGamePad.sThumbRY > -DXUT_INPUT_DEADZONE) then pGamePad.sThumbRY := 0;
  end
  else if (bThumbstickDeadZone) then
  begin
    // Apply deadzone if centered
    if (pGamePad.sThumbLX < DXUT_INPUT_DEADZONE) and (pGamePad.sThumbLX > -DXUT_INPUT_DEADZONE) and
       (pGamePad.sThumbLY < DXUT_INPUT_DEADZONE) and (pGamePad.sThumbLY > -DXUT_INPUT_DEADZONE) then
    begin
      pGamePad.sThumbLX := 0;
      pGamePad.sThumbLY := 0;
    end;
    if (pGamePad.sThumbRX < DXUT_INPUT_DEADZONE) and (pGamePad.sThumbRX > -DXUT_INPUT_DEADZONE) and
       (pGamePad.sThumbRY < DXUT_INPUT_DEADZONE) and (pGamePad.sThumbRY > -DXUT_INPUT_DEADZONE) then
    begin
      pGamePad.sThumbRX := 0;
      pGamePad.sThumbRY := 0;
    end;
  end;

  // Convert [-1,+1] range
  pGamePad.fThumbLX := pGamePad.sThumbLX / 32767.0;
  pGamePad.fThumbLY := pGamePad.sThumbLY / 32767.0;
  pGamePad.fThumbRX := pGamePad.sThumbRX / 32767.0;
  pGamePad.fThumbRY := pGamePad.sThumbRY / 32767.0;

  // Get the boolean buttons that have been pressed since the last call. 
  // Each button is represented by one bit.
  pGamePad.wPressedButtons := (pGamePad.wLastButtons xor pGamePad.wButtons) and pGamePad.wButtons;
  pGamePad.wLastButtons    := pGamePad.wButtons;

  // Figure out if the left trigger has been pressed or released
  bPressed := (pGamePad.bLeftTrigger > DXUT_GAMEPAD_TRIGGER_THRESHOLD);
  if bPressed then pGamePad.bPressedLeftTrigger := not pGamePad.bLastLeftTrigger
  else pGamePad.bPressedLeftTrigger := False;
  pGamePad.bLastLeftTrigger := bPressed;

  // Figure out if the right trigger has been pressed or released
  bPressed := (pGamePad.bRightTrigger > DXUT_GAMEPAD_TRIGGER_THRESHOLD);
  if bPressed then pGamePad.bPressedRightTrigger := not pGamePad.bLastRightTrigger
  else pGamePad.bPressedRightTrigger := False;
  pGamePad.bLastRightTrigger := bPressed;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Don't pause the game or deactive the window without first stopping rumble otherwise 
// the controller will continue to rumble
//--------------------------------------------------------------------------------------
const {static} s_pXInputEnable: TXInputEnable = nil;

procedure DXUTEnableXInput(bEnable: Boolean);
var
  hInst: THandle{HINSTANCE};
begin
  if (nil = @s_pXInputEnable) then
  begin
    hInst := LoadLibrary(XINPUT_DLL);
    if (hInst <> 0) then
      s_pXInputEnable := TXInputEnable(GetProcAddress(hInst, 'XInputEnable'));
  end;

  if (@s_pXInputEnable <> nil) then
    s_pXInputEnable(bEnable);
end;


//--------------------------------------------------------------------------------------
// Don't pause the game or deactive the window without first stopping rumble otherwise
// the controller will continue to rumble
//--------------------------------------------------------------------------------------
const
  {static} s_pXInputSetState: TXInputSetState = nil;

function DXUTStopRumbleOnAllControllers: HRESULT;
var
  vibration: TXInputVibration;
  iUserIndex: Integer;
  hInst: Windows.HINST;
begin
  if (@s_pXInputSetState = nil) then
  begin
    hInst := LoadLibrary(XINPUT_DLL);
    if (hInst <> 0) then
      s_pXInputSetState := GetProcAddress(hInst, 'XInputSetState');
  end;
  if (@s_pXInputSetState = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  vibration.wLeftMotorSpeed  := 0;
  vibration.wRightMotorSpeed := 0;
  for iUserIndex := 0 to DXUT_MAX_CONTROLLERS - 1 do
    s_pXInputSetState(iUserIndex, vibration);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Helper function to launch the Media Center UI after the program terminates
//--------------------------------------------------------------------------------------
function DXUTReLaunchMediaCenter: Boolean;
var
  szExpandedPath: array[0..MAX_PATH-1] of WideChar;
  resultX: PtrInt;
begin
  Result := False;

  // Skip if not running on a Media Center
  if (GetSystemMetrics(87) = 0) //  SM_MEDIACENTER == 87, but is only defined if _WIN32_WINNT >= 0x0501
  then Exit;

  // Get the path to Media Center
  if (ExpandEnvironmentStringsW('%SystemRoot%\ehome\ehshell.exe', szExpandedPath, MAX_PATH) = 0)
  then Exit;

  // Skip if ehshell.exe doesn't exist
  if (GetFileAttributesW(szExpandedPath) = $ffFFFFFF)
  then Exit;

  // Launch ehshell.exe
  resultX := PtrInt(ShellExecuteW(0, 'open', szExpandedPath, nil, nil, SW_SHOWNORMAL));
  Result:= (resultX > 32);
end;

initialization
  s_strMediaSearchPath[0] := #0;
end.

