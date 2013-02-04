{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      XInput.h                                                      *}
{*  Content:    This module defines XBOX controller APIs                      *}
{*              and constansts for the Windows platform.                      *}
{*                                                                            *}
{*  DirectX 9.0 Delphi / FreePascal adaptation by Alexey Barkovoy             *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://www.clootie.ru                                                   *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
{*----------------------------------------------------------------------------*}
{*  $Id: XInput.pas,v 1.3 2006/10/21 21:30:10 clootie Exp $ }
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

unit XInput;

interface

(*$HPPEMIT '#include "XInput.h"' *)

uses
  Windows;

const
  // Current name of the DLL shipped in the same SDK as this header.
  // The name reflects the current version
  XINPUT_DLL_A  = 'xinput1_3.dll';
  {$EXTERNALSYM XINPUT_DLL_A}
  XINPUT_DLL_W  = 'xinput1_3.dll';
  {$EXTERNALSYM XINPUT_DLL_W}
  XINPUT_DLL = XINPUT_DLL_A;
  {$EXTERNALSYM XINPUT_DLL}

  //
  // Device types available in XINPUT_CAPABILITIES
  //
  XINPUT_DEVTYPE_GAMEPAD          = $01;
  {$EXTERNALSYM XINPUT_DEVTYPE_GAMEPAD}
  XINPUT_DEVSUBTYPE_WHEEL         = $02;
  {$EXTERNALSYM XINPUT_DEVSUBTYPE_WHEEL}
  XINPUT_DEVSUBTYPE_ARCADE_STICK  = $03;
  {$EXTERNALSYM XINPUT_DEVSUBTYPE_ARCADE_STICK}
  XINPUT_DEVSUBTYPE_FLIGHT_SICK   = $04;
  {$EXTERNALSYM XINPUT_DEVSUBTYPE_FLIGHT_SICK}
  XINPUT_DEVSUBTYPE_DANCE_PAD     = $05;
  {$EXTERNALSYM XINPUT_DEVSUBTYPE_DANCE_PAD}

  //
  // Device subtypes available in XINPUT_CAPABILITIES
  //
  XINPUT_DEVSUBTYPE_GAMEPAD       = $01;
  {$EXTERNALSYM XINPUT_DEVSUBTYPE_GAMEPAD}

  //
  // Flags for XINPUT_CAPABILITIES
  //
  XINPUT_CAPS_VOICE_SUPPORTED     = $0004;
  {$EXTERNALSYM XINPUT_CAPS_VOICE_SUPPORTED}

  //
  // Constants for gamepad buttons
  //
  XINPUT_GAMEPAD_DPAD_UP          = $0001;
  {$EXTERNALSYM XINPUT_GAMEPAD_DPAD_UP}
  XINPUT_GAMEPAD_DPAD_DOWN        = $0002;
  {$EXTERNALSYM XINPUT_GAMEPAD_DPAD_DOWN}
  XINPUT_GAMEPAD_DPAD_LEFT        = $0004;
  {$EXTERNALSYM XINPUT_GAMEPAD_DPAD_LEFT}
  XINPUT_GAMEPAD_DPAD_RIGHT       = $0008;
  {$EXTERNALSYM XINPUT_GAMEPAD_DPAD_RIGHT}
  XINPUT_GAMEPAD_START            = $0010;
  {$EXTERNALSYM XINPUT_GAMEPAD_START}
  XINPUT_GAMEPAD_BACK             = $0020;
  {$EXTERNALSYM XINPUT_GAMEPAD_BACK}
  XINPUT_GAMEPAD_LEFT_THUMB       = $0040;
  {$EXTERNALSYM XINPUT_GAMEPAD_LEFT_THUMB}
  XINPUT_GAMEPAD_RIGHT_THUMB      = $0080;
  {$EXTERNALSYM XINPUT_GAMEPAD_RIGHT_THUMB}
  XINPUT_GAMEPAD_LEFT_SHOULDER    = $0100;
  {$EXTERNALSYM XINPUT_GAMEPAD_LEFT_SHOULDER}
  XINPUT_GAMEPAD_RIGHT_SHOULDER   = $0200;
  {$EXTERNALSYM XINPUT_GAMEPAD_RIGHT_SHOULDER}
  XINPUT_GAMEPAD_A                = $1000;
  {$EXTERNALSYM XINPUT_GAMEPAD_A}
  XINPUT_GAMEPAD_B                = $2000;
  {$EXTERNALSYM XINPUT_GAMEPAD_B}
  XINPUT_GAMEPAD_X                = $4000;
  {$EXTERNALSYM XINPUT_GAMEPAD_X}
  XINPUT_GAMEPAD_Y                = $8000;
  {$EXTERNALSYM XINPUT_GAMEPAD_Y}


  //
  // Gamepad thresholds
  //
  XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE  = 7849;
  {$EXTERNALSYM XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE}
  XINPUT_GAMEPAD_RIGHT_THUMB_DEADZONE = 8689;
  {$EXTERNALSYM XINPUT_GAMEPAD_RIGHT_THUMB_DEADZONE}
  XINPUT_GAMEPAD_TRIGGER_THRESHOLD    = 30;
  {$EXTERNALSYM XINPUT_GAMEPAD_TRIGGER_THRESHOLD}

  //
  // Flags to pass to XInputGetCapabilities
  //
  XINPUT_FLAG_GAMEPAD             = $00000001;
  {$EXTERNALSYM XINPUT_FLAG_GAMEPAD}

  //
  // Devices that support batteries
  //
  BATTERY_DEVTYPE_GAMEPAD         = $00;
  {$EXTERNALSYM BATTERY_DEVTYPE_GAMEPAD}
  BATTERY_DEVTYPE_HEADSET         = $01;
  {$EXTERNALSYM BATTERY_DEVTYPE_HEADSET}

  //
  // Flags for battery status level
  //
  BATTERY_TYPE_DISCONNECTED       = $00;    // This device is not connected
  {$EXTERNALSYM BATTERY_TYPE_DISCONNECTED}
  BATTERY_TYPE_WIRED              = $01;    // Wired device, no battery
  {$EXTERNALSYM BATTERY_TYPE_WIRED}
  BATTERY_TYPE_ALKALINE           = $02;    // Alkaline battery source
  {$EXTERNALSYM BATTERY_TYPE_ALKALINE}
  BATTERY_TYPE_NIMH               = $03;    // Nickel Metal Hydride battery source
  {$EXTERNALSYM BATTERY_TYPE_NIMH}
  BATTERY_TYPE_UNKNOWN            = $FF;    // Cannot determine the battery type
  {$EXTERNALSYM BATTERY_TYPE_UNKNOWN}

  // These are only valid for wireless, connected devices, with known battery types
  // The amount of use time remaining depends on the type of device.
  BATTERY_LEVEL_EMPTY             = $00;
  {$EXTERNALSYM BATTERY_LEVEL_EMPTY}
  BATTERY_LEVEL_LOW               = $01;
  {$EXTERNALSYM BATTERY_LEVEL_LOW}
  BATTERY_LEVEL_MEDIUM            = $02;
  {$EXTERNALSYM BATTERY_LEVEL_MEDIUM}
  BATTERY_LEVEL_FULL              = $03;
  {$EXTERNALSYM BATTERY_LEVEL_FULL}

  // User index definitions
  XUSER_MAX_COUNT                 = 4;
  {$EXTERNALSYM XUSER_MAX_COUNT}

  XUSER_INDEX_ANY                 = $000000FF;
  {$EXTERNALSYM XUSER_INDEX_ANY}


  //
  // Codes returned for the gamepad keystroke
  //

  VK_PAD_A                        = $5800;
  {$EXTERNALSYM VK_PAD_A}
  VK_PAD_B                        = $5801;
  {$EXTERNALSYM VK_PAD_B}
  VK_PAD_X                        = $5802;
  {$EXTERNALSYM VK_PAD_X}
  VK_PAD_Y                        = $5803;
  {$EXTERNALSYM VK_PAD_Y}
  VK_PAD_RSHOULDER                = $5804;
  {$EXTERNALSYM VK_PAD_RSHOULDER}
  VK_PAD_LSHOULDER                = $5805;
  {$EXTERNALSYM VK_PAD_LSHOULDER}
  VK_PAD_LTRIGGER                 = $5806;
  {$EXTERNALSYM VK_PAD_LTRIGGER}
  VK_PAD_RTRIGGER                 = $5807;
  {$EXTERNALSYM VK_PAD_RTRIGGER}

  VK_PAD_DPAD_UP                  = $5810;
  {$EXTERNALSYM VK_PAD_DPAD_UP}
  VK_PAD_DPAD_DOWN                = $5811;
  {$EXTERNALSYM VK_PAD_DPAD_DOWN}
  VK_PAD_DPAD_LEFT                = $5812;
  {$EXTERNALSYM VK_PAD_DPAD_LEFT}
  VK_PAD_DPAD_RIGHT               = $5813;
  {$EXTERNALSYM VK_PAD_DPAD_RIGHT}
  VK_PAD_START                    = $5814;
  {$EXTERNALSYM VK_PAD_START}
  VK_PAD_BACK                     = $5815;
  {$EXTERNALSYM VK_PAD_BACK}
  VK_PAD_LTHUMB_PRESS             = $5816;
  {$EXTERNALSYM VK_PAD_LTHUMB_PRESS}
  VK_PAD_RTHUMB_PRESS             = $5817;
  {$EXTERNALSYM VK_PAD_RTHUMB_PRESS}

  VK_PAD_LTHUMB_UP                = $5820;
  {$EXTERNALSYM VK_PAD_LTHUMB_UP}
  VK_PAD_LTHUMB_DOWN              = $5821;
  {$EXTERNALSYM VK_PAD_LTHUMB_DOWN}
  VK_PAD_LTHUMB_RIGHT             = $5822;
  {$EXTERNALSYM VK_PAD_LTHUMB_RIGHT}
  VK_PAD_LTHUMB_LEFT              = $5823;
  {$EXTERNALSYM VK_PAD_LTHUMB_LEFT}
  VK_PAD_LTHUMB_UPLEFT            = $5824;
  {$EXTERNALSYM VK_PAD_LTHUMB_UPLEFT}
  VK_PAD_LTHUMB_UPRIGHT           = $5825;
  {$EXTERNALSYM VK_PAD_LTHUMB_UPRIGHT}
  VK_PAD_LTHUMB_DOWNRIGHT         = $5826;
  {$EXTERNALSYM VK_PAD_LTHUMB_DOWNRIGHT}
  VK_PAD_LTHUMB_DOWNLEFT          = $5827;
  {$EXTERNALSYM VK_PAD_LTHUMB_DOWNLEFT}

  VK_PAD_RTHUMB_UP                = $5830;
  {$EXTERNALSYM VK_PAD_RTHUMB_UP}
  VK_PAD_RTHUMB_DOWN              = $5831;
  {$EXTERNALSYM VK_PAD_RTHUMB_DOWN}
  VK_PAD_RTHUMB_RIGHT             = $5832;
  {$EXTERNALSYM VK_PAD_RTHUMB_RIGHT}
  VK_PAD_RTHUMB_LEFT              = $5833;
  {$EXTERNALSYM VK_PAD_RTHUMB_LEFT}
  VK_PAD_RTHUMB_UPLEFT            = $5834;
  {$EXTERNALSYM VK_PAD_RTHUMB_UPLEFT}
  VK_PAD_RTHUMB_UPRIGHT           = $5835;
  {$EXTERNALSYM VK_PAD_RTHUMB_UPRIGHT}
  VK_PAD_RTHUMB_DOWNRIGHT         = $5836;
  {$EXTERNALSYM VK_PAD_RTHUMB_DOWNRIGHT}
  VK_PAD_RTHUMB_DOWNLEFT          = $5837;
  {$EXTERNALSYM VK_PAD_RTHUMB_DOWNLEFT}

  //
  // Flags used in XINPUT_KEYSTROKE
  //
  XINPUT_KEYSTROKE_KEYDOWN        = $0001;
  {$EXTERNALSYM XINPUT_KEYSTROKE_KEYDOWN}
  XINPUT_KEYSTROKE_KEYUP          = $0002;
  {$EXTERNALSYM XINPUT_KEYSTROKE_KEYUP}
  XINPUT_KEYSTROKE_REPEAT         = $0004;
  {$EXTERNALSYM XINPUT_KEYSTROKE_REPEAT}

type

  //
  // Structures used by XInput APIs
  //
  PXInputGamepad = ^TXInputGamepad;
  _XINPUT_GAMEPAD = record
    wButtons:         Word;
    bLeftTrigger:     Byte;
    bRightTrigger:    Byte;
    sThumbLX:         Smallint;
    sThumbLY:         Smallint;
    sThumbRX:         Smallint;
    sThumbRY:         Smallint;
  end;
  {$EXTERNALSYM _XINPUT_GAMEPAD}
  XINPUT_GAMEPAD = _XINPUT_GAMEPAD;
  {$EXTERNALSYM XINPUT_GAMEPAD}
  TXInputGamepad = XINPUT_GAMEPAD;

  PXInputState = ^TXInputState;
  _XINPUT_STATE = record
    dwPacketNumber:   DWORD;
    Gamepad:          TXInputGamepad;
  end;
  {$EXTERNALSYM _XINPUT_STATE}
  XINPUT_STATE = _XINPUT_STATE;
  {$EXTERNALSYM XINPUT_STATE}
  TXInputState = XINPUT_STATE;

  PXInputVibration = ^TXInputVibration;
  _XINPUT_VIBRATION = record
    wLeftMotorSpeed:  Word;
    wRightMotorSpeed: Word;
  end;
  {$EXTERNALSYM _XINPUT_VIBRATION}
  XINPUT_VIBRATION = _XINPUT_VIBRATION;
  {$EXTERNALSYM XINPUT_VIBRATION}
  TXInputVibration = _XINPUT_VIBRATION;

  PXInputCapabilities = ^TXInputCapabilities;
  _XINPUT_CAPABILITIES = record
    _Type:            Byte;
    SubType:          Byte;
    Flags:            Word;
    Gamepad:          TXInputGamepad;
    Vibration:        TXInputVibration;
  end;
  {$EXTERNALSYM _XINPUT_CAPABILITIES}
  XINPUT_CAPABILITIES = _XINPUT_CAPABILITIES;
  {$EXTERNALSYM XINPUT_CAPABILITIES}
  TXInputCapabilities = _XINPUT_CAPABILITIES;

  PXInputBatteryInformation = ^TXInputBatteryInformation;
  _XINPUT_BATTERY_INFORMATION = record
    BatteryType: Byte;
    BatteryLevel: Byte;
  end;
  {$EXTERNALSYM _XINPUT_BATTERY_INFORMATION}
  XINPUT_BATTERY_INFORMATION = _XINPUT_BATTERY_INFORMATION;
  {$EXTERNALSYM XINPUT_BATTERY_INFORMATION}
  TXInputBatteryInformation = _XINPUT_BATTERY_INFORMATION;

  PXInputKeystroke = ^TXInputKeystroke;
  _XINPUT_KEYSTROKE = record
    VirtualKey: Word;
    Unicode: WideChar;
    Flags: Word;
    UserIndex: Byte;
    HidCode: Byte;
  end;
  {$EXTERNALSYM _XINPUT_KEYSTROKE}
  XINPUT_KEYSTROKE = _XINPUT_KEYSTROKE;
  {$EXTERNALSYM XINPUT_KEYSTROKE}
  TXInputKeystroke = _XINPUT_KEYSTROKE;


//
// XInput APIs
//

function XInputGetState(
    dwUserIndex: DWORD;      // [in] Index of the gamer associated with the device
    out pState: TXInputState // [out] Receives the current state
 ): DWORD; stdcall; external XINPUT_DLL;
{$EXTERNALSYM XInputGetState}

function XInputSetState(
    dwUserIndex: DWORD;                 // [in] Index of the gamer associated with the device
    const pVibration: TXInputVibration  // [in, out] The vibration information to send to the controller
 ): DWORD; stdcall; external XINPUT_DLL;
{$EXTERNALSYM XInputSetState}

function XInputGetCapabilities(
    dwUserIndex: DWORD;                     // [in] Index of the gamer associated with the device
    dwFlags: DWORD;                         // [in] Input flags that identify the device type
    out pCapabilities: TXInputCapabilities  // [out] Receives the capabilities
 ): DWORD; stdcall; external XINPUT_DLL;
{$EXTERNALSYM XInputGetCapabilities}

procedure XInputEnable(
    enable: BOOL     // [in] Indicates whether xinput is enabled or disabled.
); stdcall; external XINPUT_DLL;
{$EXTERNALSYM XInputEnable}

function XInputGetDSoundAudioDeviceGuids(
    dwUserIndex: DWORD;           // [in] Index of the gamer associated with the device
    out pDSoundRenderGuid: TGUID; // [out] DSound device ID for render
    out pDSoundCaptureGuid: TGUID // [out] DSound device ID for capture
 ): DWORD; stdcall; external XINPUT_DLL;
{$EXTERNALSYM XInputGetDSoundAudioDeviceGuids}

function XInputGetBatteryInformation(
    dwUserIndex: DWORD;          // [in]  Index of the gamer associated with the device
    devType: Byte;               // [in]  Which device on this user index
    out pBatteryInformation: TXInputBatteryInformation // [out] Contains the level and types of batteries
 ): DWORD; stdcall; external XINPUT_DLL;
{$EXTERNALSYM XInputGetBatteryInformation}

function XInputGetKeystroke(
    dwUserIndex: DWORD;               // [in]  Index of the gamer associated with the device
    dwReserved: DWORD;                // [in]  Reserved for future use
    var pKeystroke: TXInputKeystroke  // [out] Pointer to an XINPUT_KEYSTROKE structure that receives an input event.
 ): DWORD; stdcall; external XINPUT_DLL;
{$EXTERNALSYM XInputGetKeystroke}


implementation

end.
