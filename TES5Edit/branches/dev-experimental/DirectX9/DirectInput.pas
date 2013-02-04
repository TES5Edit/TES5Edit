{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      dinput.h                                                      *}
{*  Content:    DirectInput include file                                      *}
{*                                                                            *}
{*  DirectX 9.0 Delphi / FreePascal adaptation by Alexey Barkovoy             *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Modified: 30-Nov-2004                                                     *}
{*                                                                            *}
{*  Compatible with :                                                         *}
{*    DirectX 7.0 Object Pascal adaptation by                                 *}
{*      Erik Unger, e-Mail: DelphiDirectX@next-reality.com                    *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://clootie.ru                                                       *}
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

// Original source contained in "DirectInput.par"

///////////////////////////////////////////////////////////////////////////////
// Notes:
//----------------------------------------------------------------------------
// Possible input defines for this file, mapped to original C values:
//   DIRECTINPUT_VERSION_8 : DIRECTINPUT_VERSION = 0x0800,
//   DIRECTINPUT_VERSION_7 : DIRECTINPUT_VERSION = 0x0700,
//   DIRECTINPUT_VERSION_6 : DIRECTINPUT_VERSION = 0x0600,
//   DIRECTINPUT_VERSION_5b : DIRECTINPUT_VERSION = 0x05b2,
//     - in this translation we don't support DirectInput 5.0a (0x050a) version
//       - just straight 5.0b (0x05b2) one.
//   DIRECTINPUT_VERSION_5 : DIRECTINPUT_VERSION = 0x0500,
//   DIRECTINPUT_VERSION_3 : DIRECTINPUT_VERSION = 0x0300,
//
// By default DIRECTINPUT_VERSION_8 (DIRECTINPUT_VERSION = 0x0800) is assumed
//
// Also you can use generic DIRECTXx defines, so:
//   DIRECTX9 equal to DIRECTINPUT_VERSION_8;
//   DIRECTX8 equal to DIRECTINPUT_VERSION_8;
//   DIRECTX7 equal to DIRECTINPUT_VERSION_7;
//   DIRECTX6 equal to DIRECTINPUT_VERSION_6;
//   DIRECTX5 equal to DIRECTINPUT_VERSION_5;
//   DIRECTX3 equal to DIRECTINPUT_VERSION_3
///////////////////////////////////////////////////////////////////////////////

{$MINENUMSIZE 4}
{$ALIGN ON}

unit DirectInput;

interface

uses
  Windows, MMSystem, DXTypes;

////////////////////////////////////////////////////////////////////////
// Global level dynamic loading support

// Remove "dots" below to force some kind of dynamic linking
{.$DEFINE DIRECTINPUT_DYNAMIC_LINK}
{.$DEFINE DIRECTINPUT_DYNAMIC_LINK_EXPLICIT}

////////////////////////////////////////////////////////////////////////
// Assume for what DirectInput version we will compile headers

// Compiling for DirectInput8 by default

////////////////////////////////////////////////////////////////////////
// Define DirectInputVerrsion constant
const
  DIRECTINPUT_VERSION = $0800;
  {$EXTERNALSYM DIRECTINPUT_VERSION}

////////////////////////////////////////////////////////////////////////
// Emit conditionals to C++Builder compiler
  {$HPPEMIT '#define DIRECTINPUT_VERSION         0x0800'}

(*$HPPEMIT '#include "dinput.h"' *)
(*$HPPEMIT '' *)

////////////////////////////////////////////////////////////////////////
// Define symbols for '<=' comparision

(****************************************************************************
 *
 *  Copyright (C) 1996-2000 Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       dinput.h
 *  Content:    DirectInput include file
 *
 ****************************************************************************)


{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInputEffect);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInputDeviceA);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInputDeviceW);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInputA);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInputW);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInput2A);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInput2W);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInput7A);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInput7W);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInput8A);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInput8W);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInputDeviceA);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInputDeviceW);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInputDevice2A);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInputDevice2W);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInputDevice7A);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInputDevice7W);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInputDevice8A);'}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectInputDevice8W);'}
{$HPPEMIT '#ifdef UNICODE'}
{$HPPEMIT 'typedef _di_IDirectInputW _di_IDirectInput;'}
{$HPPEMIT 'typedef _di_IDirectInput2W _di_IDirectInput2;'}
{$HPPEMIT 'typedef _di_IDirectInput7W _di_IDirectInput7;'}
{$HPPEMIT 'typedef _di_IDirectInput8W _di_IDirectInput8;'}
{$HPPEMIT 'typedef _di_IDirectInputDeviceW _di_IDirectInputDevice;'}
{$HPPEMIT 'typedef _di_IDirectInputDevice2W _di_IDirectInputDevice2;'}
{$HPPEMIT 'typedef _di_IDirectInputDevice7W _di_IDirectInputDevice7;'}
{$HPPEMIT 'typedef _di_IDirectInputDevice8W _di_IDirectInputDevice8;'}
{$HPPEMIT '#else'}
{$HPPEMIT 'typedef _di_IDirectInputA _di_IDirectInput;'}
{$HPPEMIT 'typedef _di_IDirectInput2A _di_IDirectInput2;'}
{$HPPEMIT 'typedef _di_IDirectInput7A _di_IDirectInput7;'}
{$HPPEMIT 'typedef _di_IDirectInput8A _di_IDirectInput8;'}
{$HPPEMIT 'typedef _di_IDirectInputDeviceA _di_IDirectInputDevice;'}
{$HPPEMIT 'typedef _di_IDirectInputDevice2A _di_IDirectInputDevice2;'}
{$HPPEMIT 'typedef _di_IDirectInputDevice7A _di_IDirectInputDevice7;'}
{$HPPEMIT 'typedef _di_IDirectInputDevice8A _di_IDirectInputDevice8;'}
{$HPPEMIT '#endif'}


(****************************************************************************
 *
 *      Class IDs
 *
 ****************************************************************************)

const
  CLSID_DirectInput        : TGUID = '{25E609E0-B259-11CF-BFC7-444553540000}';
  {$EXTERNALSYM CLSID_DirectInput}
  CLSID_DirectInputDevice  : TGUID = '{25E609E1-B259-11CF-BFC7-444553540000}';
  {$EXTERNALSYM CLSID_DirectInputDevice}

  CLSID_DirectInput8       : TGUID = '{25E609E4-B259-11CF-BFC7-444553540000}';
  {$EXTERNALSYM CLSID_DirectInput8}
  CLSID_DirectInputDevice8 : TGUID = '{25E609E5-B259-11CF-BFC7-444553540000}';
  {$EXTERNALSYM CLSID_DirectInputDevice8}

(****************************************************************************
 *
 *      Interfaces
 *
 ****************************************************************************)

const
  IID_IDirectInputA        : TGUID = '{89521360-AA8A-11CF-BFC7-444553540000}';
  {$EXTERNALSYM IID_IDirectInputA}
  IID_IDirectInputW        : TGUID = '{89521361-AA8A-11CF-BFC7-444553540000}';
  {$EXTERNALSYM IID_IDirectInputW}
  IID_IDirectInput2A       : TGUID = '{5944E662-AA8A-11CF-BFC7-444553540000}';
  {$EXTERNALSYM IID_IDirectInput2A}
  IID_IDirectInput2W       : TGUID = '{5944E663-AA8A-11CF-BFC7-444553540000}';
  {$EXTERNALSYM IID_IDirectInput2W}
  IID_IDirectInput7A       : TGUID = '{9A4CB684-236D-11D3-8E9D-00C04F6844AE}';
  {$EXTERNALSYM IID_IDirectInput7A}
  IID_IDirectInput7W       : TGUID = '{9A4CB685-236D-11D3-8E9D-00C04F6844AE}';
  {$EXTERNALSYM IID_IDirectInput7W}
  IID_IDirectInput8A       : TGUID = '{BF798030-483A-4DA2-AA99-5D64ED369700}';
  {$EXTERNALSYM IID_IDirectInput8A}
  IID_IDirectInput8W       : TGUID = '{BF798031-483A-4DA2-AA99-5D64ED369700}';
  {$EXTERNALSYM IID_IDirectInput8W}
  IID_IDirectInputDeviceA  : TGUID = '{5944E680-C92E-11CF-BFC7-444553540000}';
  {$EXTERNALSYM IID_IDirectInputDeviceA}
  IID_IDirectInputDeviceW  : TGUID = '{5944E681-C92E-11CF-BFC7-444553540000}';
  {$EXTERNALSYM IID_IDirectInputDeviceW}
  IID_IDirectInputDevice2A : TGUID = '{5944E682-C92E-11CF-BFC7-444553540000}';
  {$EXTERNALSYM IID_IDirectInputDevice2A}
  IID_IDirectInputDevice2W : TGUID = '{5944E683-C92E-11CF-BFC7-444553540000}';
  {$EXTERNALSYM IID_IDirectInputDevice2W}
  IID_IDirectInputDevice7A : TGUID = '{57D7C6BC-2356-11D3-8E9D-00C04F6844AE}';
  {$EXTERNALSYM IID_IDirectInputDevice7A}
  IID_IDirectInputDevice7W : TGUID = '{57D7C6BD-2356-11D3-8E9D-00C04F6844AE}';
  {$EXTERNALSYM IID_IDirectInputDevice7W}
  IID_IDirectInputDevice8A : TGUID = '{54D41080-DC15-4833-A41B-748F73A38179}';
  {$EXTERNALSYM IID_IDirectInputDevice8A}
  IID_IDirectInputDevice8W : TGUID = '{54D41081-DC15-4833-A41B-748F73A38179}';
  {$EXTERNALSYM IID_IDirectInputDevice8W}
  IID_IDirectInputEffect   : TGUID = '{E7E1F7C0-88D2-11D0-9AD0-00A0C9A06E35}';
  {$EXTERNALSYM IID_IDirectInputEffect}

  // String constants for Interface IDs
  SID_IDirectInputA        = '{89521360-AA8A-11CF-BFC7-444553540000}';
  SID_IDirectInputW        = '{89521361-AA8A-11CF-BFC7-444553540000}';
  SID_IDirectInput2A       = '{5944E662-AA8A-11CF-BFC7-444553540000}';
  SID_IDirectInput2W       = '{5944E663-AA8A-11CF-BFC7-444553540000}';
  SID_IDirectInput7A       = '{9A4CB684-236D-11D3-8E9D-00C04F6844AE}';
  SID_IDirectInput7W       = '{9A4CB685-236D-11D3-8E9D-00C04F6844AE}';
  SID_IDirectInput8A       = '{BF798030-483A-4DA2-AA99-5D64ED369700}';
  SID_IDirectInput8W       = '{BF798031-483A-4DA2-AA99-5D64ED369700}';
  SID_IDirectInputDeviceA  = '{5944E680-C92E-11CF-BFC7-444553540000}';
  SID_IDirectInputDeviceW  = '{5944E681-C92E-11CF-BFC7-444553540000}';
  SID_IDirectInputDevice2A = '{5944E682-C92E-11CF-BFC7-444553540000}';
  SID_IDirectInputDevice2W = '{5944E683-C92E-11CF-BFC7-444553540000}';
  SID_IDirectInputDevice7A = '{57D7C6BC-2356-11D3-8E9D-00C04F6844AE}';
  SID_IDirectInputDevice7W = '{57D7C6BD-2356-11D3-8E9D-00C04F6844AE}';
  SID_IDirectInputDevice8A = '{54D41080-DC15-4833-A41B-748F73A38179}';
  SID_IDirectInputDevice8W = '{54D41081-DC15-4833-A41B-748F73A38179}';
  SID_IDirectInputEffect   = '{E7E1F7C0-88D2-11D0-9AD0-00A0C9A06E35}';
  
(****************************************************************************
 *
 *      Predefined object types
 *
 ****************************************************************************)

const
  GUID_XAxis   : TGUID = '{A36D02E0-C9F3-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_XAxis}
  GUID_YAxis   : TGUID = '{A36D02E1-C9F3-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_YAxis}
  GUID_ZAxis   : TGUID = '{A36D02E2-C9F3-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_ZAxis}
  GUID_RxAxis  : TGUID = '{A36D02F4-C9F3-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_RxAxis}
  GUID_RyAxis  : TGUID = '{A36D02F5-C9F3-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_RyAxis}
  GUID_RzAxis  : TGUID = '{A36D02E3-C9F3-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_RzAxis}
  GUID_Slider  : TGUID = '{A36D02E4-C9F3-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_Slider}

  GUID_Button  : TGUID = '{A36D02F0-C9F3-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_Button}
  GUID_Key     : TGUID = '{55728220-D33C-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_Key}

  GUID_POV     : TGUID = '{A36D02F2-C9F3-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_POV}

  GUID_Unknown : TGUID = '{A36D02F3-C9F3-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_Unknown}

(****************************************************************************
 *
 *      Predefined product GUIDs
 *
 ****************************************************************************)

const
  GUID_SysMouse       : TGUID = '{6F1D2B60-D5A0-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_SysMouse}
  GUID_SysKeyboard    : TGUID = '{6F1D2B61-D5A0-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_SysKeyboard}
  GUID_Joystick       : TGUID = '{6F1D2B70-D5A0-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_Joystick}
  GUID_SysMouseEm     : TGUID = '{6F1D2B80-D5A0-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_SysMouseEm}
  GUID_SysMouseEm2    : TGUID = '{6F1D2B81-D5A0-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_SysMouseEm2}
  GUID_SysKeyboardEm  : TGUID = '{6F1D2B82-D5A0-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_SysKeyboardEm}
  GUID_SysKeyboardEm2 : TGUID = '{6F1D2B83-D5A0-11CF-BFC7-444553540000}';
  {$EXTERNALSYM GUID_SysKeyboardEm2}

(****************************************************************************
 *
 *      Predefined force feedback effects
 *
 ****************************************************************************)

const
  GUID_ConstantForce : TGUID = '{13541C20-8E33-11D0-9AD0-00A0C9A06E35}';
  {$EXTERNALSYM GUID_ConstantForce}
  GUID_RampForce     : TGUID = '{13541C21-8E33-11D0-9AD0-00A0C9A06E35}';
  {$EXTERNALSYM GUID_RampForce}
  GUID_Square        : TGUID = '{13541C22-8E33-11D0-9AD0-00A0C9A06E35}';
  {$EXTERNALSYM GUID_Square}
  GUID_Sine          : TGUID = '{13541C23-8E33-11D0-9AD0-00A0C9A06E35}';
  {$EXTERNALSYM GUID_Sine}
  GUID_Triangle      : TGUID = '{13541C24-8E33-11D0-9AD0-00A0C9A06E35}';
  {$EXTERNALSYM GUID_Triangle}
  GUID_SawtoothUp    : TGUID = '{13541C25-8E33-11D0-9AD0-00A0C9A06E35}';
  {$EXTERNALSYM GUID_SawtoothUp}
  GUID_SawtoothDown  : TGUID = '{13541C26-8E33-11D0-9AD0-00A0C9A06E35}';
  {$EXTERNALSYM GUID_SawtoothDown}
  GUID_Spring        : TGUID = '{13541C27-8E33-11D0-9AD0-00A0C9A06E35}';
  {$EXTERNALSYM GUID_Spring}
  GUID_Damper        : TGUID = '{13541C28-8E33-11D0-9AD0-00A0C9A06E35}';
  {$EXTERNALSYM GUID_Damper}
  GUID_Inertia       : TGUID = '{13541C29-8E33-11D0-9AD0-00A0C9A06E35}';
  {$EXTERNALSYM GUID_Inertia}
  GUID_Friction      : TGUID = '{13541C2A-8E33-11D0-9AD0-00A0C9A06E35}';
  {$EXTERNALSYM GUID_Friction}
  GUID_CustomForce   : TGUID = '{13541C2B-8E33-11D0-9AD0-00A0C9A06E35}';
  {$EXTERNALSYM GUID_CustomForce}

  
(****************************************************************************
 *
 *      Interfaces and Structures...
 *
 ****************************************************************************)


(****************************************************************************
 *
 *      IDirectInputEffect
 *
 ****************************************************************************)

const
  DIEFT_ALL                   = $00000000;
  {$EXTERNALSYM DIEFT_ALL}

  DIEFT_CONSTANTFORCE         = $00000001;
  {$EXTERNALSYM DIEFT_CONSTANTFORCE}
  DIEFT_RAMPFORCE             = $00000002;
  {$EXTERNALSYM DIEFT_RAMPFORCE}
  DIEFT_PERIODIC              = $00000003;
  {$EXTERNALSYM DIEFT_PERIODIC}
  DIEFT_CONDITION             = $00000004;
  {$EXTERNALSYM DIEFT_CONDITION}
  DIEFT_CUSTOMFORCE           = $00000005;
  {$EXTERNALSYM DIEFT_CUSTOMFORCE}
  DIEFT_HARDWARE              = $000000FF;
  {$EXTERNALSYM DIEFT_HARDWARE}
  DIEFT_FFATTACK              = $00000200;
  {$EXTERNALSYM DIEFT_FFATTACK}
  DIEFT_FFFADE                = $00000400;
  {$EXTERNALSYM DIEFT_FFFADE}
  DIEFT_SATURATION            = $00000800;
  {$EXTERNALSYM DIEFT_SATURATION}
  DIEFT_POSNEGCOEFFICIENTS    = $00001000;
  {$EXTERNALSYM DIEFT_POSNEGCOEFFICIENTS}
  DIEFT_POSNEGSATURATION      = $00002000;
  {$EXTERNALSYM DIEFT_POSNEGSATURATION}
  DIEFT_DEADBAND              = $00004000;
  {$EXTERNALSYM DIEFT_DEADBAND}
  DIEFT_STARTDELAY            = $00008000;
  {$EXTERNALSYM DIEFT_STARTDELAY}

//#define DIEFT_GETTYPE(n)            LOBYTE(n)
function DIEFT_GETTYPE(n: Cardinal): Byte;
{$EXTERNALSYM DIEFT_GETTYPE}

const
  DI_DEGREES                  = 100;
  {$EXTERNALSYM DI_DEGREES}
  DI_FFNOMINALMAX             = 10000;
  {$EXTERNALSYM DI_FFNOMINALMAX}
  DI_SECONDS                  = 1000000;
  {$EXTERNALSYM DI_SECONDS}

type
  PDIConstantForce = ^TDIConstantForce;
  DICONSTANTFORCE = packed record
    lMagnitude: Longint;
  end;
  {$EXTERNALSYM DICONSTANTFORCE}
  TDIConstantForce = DICONSTANTFORCE;

  PDIRampForce = ^TDIRampForce;
  DIRAMPFORCE = packed record
    lStart: Longint;
    lEnd: Longint;
  end;
  {$EXTERNALSYM DIRAMPFORCE}
  TDIRampForce = DIRAMPFORCE;

  PDIPeriodic = ^TDIPeriodic;
  DIPERIODIC = packed record
    dwMagnitude: DWORD;
    lOffset: Longint;
    dwPhase: DWORD;
    dwPeriod: DWORD;
  end;
  {$EXTERNALSYM DIPERIODIC}
  TDIPeriodic = DIPERIODIC;

  PDICondition = ^TDICondition;
  DICONDITION = packed record
    lOffset: Longint;
    lPositiveCoefficient: Longint;
    lNegativeCoefficient: Longint;
    dwPositiveSaturation: DWORD;
    dwNegativeSaturation: DWORD;
    lDeadBand: Longint;
  end;
  {$EXTERNALSYM DICONDITION}
  TDICondition = DICONDITION;

  PDICustomForce = ^TDICustomForce;
  DICUSTOMFORCE = packed record
    cChannels: DWORD;
    dwSamplePeriod: DWORD;
    cSamples: DWORD;
    rglForceData: PLongint;
  end;
  {$EXTERNALSYM DICUSTOMFORCE}
  TDICustomForce = DICUSTOMFORCE;

  PDIEnvelope = ^TDIEnvelope;
  DIENVELOPE = packed record
    dwSize: DWORD;                   (* sizeof(DIENVELOPE)   *)
    dwAttackLevel: DWORD;
    dwAttackTime: DWORD;             (* Microseconds         *)
    dwFadeLevel: DWORD;
    dwFadeTime: DWORD;               (* Microseconds         *)
  end;
  {$EXTERNALSYM DIENVELOPE}
  TDIEnvelope = DIENVELOPE;


(* This structure is defined for DirectX 5.0 compatibility *)
  PDIEffectDX5 = ^TDIEffectDX5;
  DIEFFECT_DX5 = packed record
    dwSize: DWORD;                   (* sizeof(DIEFFECT_DX5) *)
    dwFlags: DWORD;                  (* DIEFF_*              *)
    dwDuration: DWORD;               (* Microseconds         *)
    dwSamplePeriod: DWORD;           (* Microseconds         *)
    dwGain: DWORD;
    dwTriggerButton: DWORD;          (* or DIEB_NOTRIGGER    *)
    dwTriggerRepeatInterval: DWORD;  (* Microseconds         *)
    cAxes: DWORD;                    (* Number of axes       *)
    rgdwAxes: PDWORD;                (* Array of axes        *)
    rglDirection: PLongint;          (* Array of directions  *)
    lpEnvelope: PDIEnvelope;         (* Optional             *)
    cbTypeSpecificParams: DWORD;     (* Size of params       *)
    lpvTypeSpecificParams: Pointer;  (* Pointer to params    *)
  end;
  {$EXTERNALSYM DIEFFECT_DX5}
  TDIEffectDX5 = DIEFFECT_DX5;

  PDIEffect = ^TDIEffect;
  DIEFFECT = packed record
    dwSize: DWORD;                   (* sizeof(DIEFFECT)     *)
    dwFlags: DWORD;                  (* DIEFF_*              *)
    dwDuration: DWORD;               (* Microseconds         *)
    dwSamplePeriod: DWORD;           (* Microseconds         *)
    dwGain: DWORD;
    dwTriggerButton: DWORD;          (* or DIEB_NOTRIGGER    *)
    dwTriggerRepeatInterval: DWORD;  (* Microseconds         *)
    cAxes: DWORD;                    (* Number of axes       *)
    rgdwAxes: PDWORD;                (* Array of axes        *)
    rglDirection: PLongint;          (* Array of directions  *)
    lpEnvelope: PDIEnvelope;         (* Optional             *)
    cbTypeSpecificParams: DWORD;     (* Size of params       *)
    lpvTypeSpecificParams: Pointer;  (* Pointer to params    *)
    dwStartDelay:  DWORD;            (* Microseconds         *)
 (* DIRECTINPUT_VERSION >= 0x0600 *)
  end;
  {$EXTERNALSYM DIEFFECT}
  TDIEffect = DIEFFECT;

  DIEFFECT_DX6 = DIEFFECT;
  {$EXTERNALSYM DIEFFECT_DX6}
  TDIEffectDX6 = DIEFFECT_DX6;
  PDIEffectDX6 = ^TDIEffectDX6;

  PDIFileEffect = ^TDIFileEffect;
  DIFILEEFFECT = packed record
    dwSize: DWORD;
    GuidEffect: TGUID;
    lpDiEffect: PDIEffect;
    szFriendlyName: array [0..MAX_PATH-1] of Char;
  end;
  {$EXTERNALSYM DIFILEEFFECT}
  TDIFileEffect = DIFILEEFFECT;

  TDIEnumEffectsInFileCallback = function (const Effect: TDIFileEffect; Data: Pointer): BOOL; stdcall;
  {$NODEFINE TDIEnumEffectsInFileCallback}
  {$HPPEMIT 'typedef LPDIENUMEFFECTSINFILECALLBACK TDIEnumEffectsInFileCallback;'}
 (* DIRECTINPUT_VERSION >= 0x0700 *)

const
  DIEFF_OBJECTIDS             = $00000001;
  {$EXTERNALSYM DIEFF_OBJECTIDS}
  DIEFF_OBJECTOFFSETS         = $00000002;
  {$EXTERNALSYM DIEFF_OBJECTOFFSETS}
  DIEFF_CARTESIAN             = $00000010;
  {$EXTERNALSYM DIEFF_CARTESIAN}
  DIEFF_POLAR                 = $00000020;
  {$EXTERNALSYM DIEFF_POLAR}
  DIEFF_SPHERICAL             = $00000040;
  {$EXTERNALSYM DIEFF_SPHERICAL}

  DIEP_DURATION               = $00000001;
  {$EXTERNALSYM DIEP_DURATION}
  DIEP_SAMPLEPERIOD           = $00000002;
  {$EXTERNALSYM DIEP_SAMPLEPERIOD}
  DIEP_GAIN                   = $00000004;
  {$EXTERNALSYM DIEP_GAIN}
  DIEP_TRIGGERBUTTON          = $00000008;
  {$EXTERNALSYM DIEP_TRIGGERBUTTON}
  DIEP_TRIGGERREPEATINTERVAL  = $00000010;
  {$EXTERNALSYM DIEP_TRIGGERREPEATINTERVAL}
  DIEP_AXES                   = $00000020;
  {$EXTERNALSYM DIEP_AXES}
  DIEP_DIRECTION              = $00000040;
  {$EXTERNALSYM DIEP_DIRECTION}
  DIEP_ENVELOPE               = $00000080;
  {$EXTERNALSYM DIEP_ENVELOPE}
  DIEP_TYPESPECIFICPARAMS     = $00000100;
  {$EXTERNALSYM DIEP_TYPESPECIFICPARAMS}
  DIEP_STARTDELAY             = $00000200;
  {$EXTERNALSYM DIEP_STARTDELAY}
  DIEP_ALLPARAMS_DX5          = $000001FF;
  {$EXTERNALSYM DIEP_ALLPARAMS_DX5}
  DIEP_ALLPARAMS              = $000003FF;
  {$EXTERNALSYM DIEP_ALLPARAMS}
 (* DIRECTINPUT_VERSION ? 0x0600 *)
  DIEP_START                  = $20000000;
  {$EXTERNALSYM DIEP_START}
  DIEP_NORESTART              = $40000000;
  {$EXTERNALSYM DIEP_NORESTART}
  DIEP_NODOWNLOAD             = $80000000;
  {$EXTERNALSYM DIEP_NODOWNLOAD}
  DIEB_NOTRIGGER              = $FFFFFFFF;
  {$EXTERNALSYM DIEB_NOTRIGGER}

  DIES_SOLO                   = $00000001;
  {$EXTERNALSYM DIES_SOLO}
  DIES_NODOWNLOAD             = $80000000;
  {$EXTERNALSYM DIES_NODOWNLOAD}

  DIEGES_PLAYING              = $00000001;
  {$EXTERNALSYM DIEGES_PLAYING}
  DIEGES_EMULATED             = $00000002;
  {$EXTERNALSYM DIEGES_EMULATED}

type
  PDIEffEscape = ^TDIEffEscape;
  DIEFFESCAPE = packed record
    dwSize: DWORD;
    dwCommand: DWORD;
    lpvInBuffer: Pointer;
    cbInBuffer: DWORD;
    lpvOutBuffer: Pointer;
    cbOutBuffer: DWORD;
  end;
  {$EXTERNALSYM DIEFFESCAPE}
  TDIEffEscape = DIEFFESCAPE;


type
  {$EXTERNALSYM IDirectInputEffect}
  IDirectInputEffect = interface(IUnknown)
    [SID_IDirectInputEffect]
    (*** IDirectInputEffect methods ***)
    function Initialize(hinst: THandle; dwVersion: DWORD; const rguid: TGUID): HResult; stdcall;
    function GetEffectGuid(out pguid: TGUID): HResult; stdcall;
    function GetParameters(var peff: TDIEffect; dwFlags: DWORD): HResult; stdcall;
    function SetParameters(const peff: TDIEffect; dwFlags: DWORD): HResult; stdcall;
    function Start(dwIterations, dwFlags: DWORD): HResult; stdcall;
    function Stop: HResult; stdcall;
    function GetEffectStatus(out pdwFlags: DWORD): HResult; stdcall;
    function Download: HResult; stdcall;
    function Unload: HResult; stdcall;
    function Escape(var pesc: PDIEffEscape): HResult; stdcall;
  end;

 (* DIRECTINPUT_VERSION >= 0x0500 *)

(****************************************************************************
 *
 *      IDirectInputDevice
 *
 ****************************************************************************)

const
  DI8DEVCLASS_ALL             = 0;
  {$EXTERNALSYM DI8DEVCLASS_ALL}
  DI8DEVCLASS_DEVICE          = 1;
  {$EXTERNALSYM DI8DEVCLASS_DEVICE}
  DI8DEVCLASS_POINTER         = 2;
  {$EXTERNALSYM DI8DEVCLASS_POINTER}
  DI8DEVCLASS_KEYBOARD        = 3;
  {$EXTERNALSYM DI8DEVCLASS_KEYBOARD}
  DI8DEVCLASS_GAMECTRL        = 4;
  {$EXTERNALSYM DI8DEVCLASS_GAMECTRL}

  DI8DEVTYPE_DEVICE           = $11;
  {$EXTERNALSYM DI8DEVTYPE_DEVICE}
  DI8DEVTYPE_MOUSE            = $12;
  {$EXTERNALSYM DI8DEVTYPE_MOUSE}
  DI8DEVTYPE_KEYBOARD         = $13;
  {$EXTERNALSYM DI8DEVTYPE_KEYBOARD}
  DI8DEVTYPE_JOYSTICK         = $14;
  {$EXTERNALSYM DI8DEVTYPE_JOYSTICK}
  DI8DEVTYPE_GAMEPAD          = $15;
  {$EXTERNALSYM DI8DEVTYPE_GAMEPAD}
  DI8DEVTYPE_DRIVING          = $16;
  {$EXTERNALSYM DI8DEVTYPE_DRIVING}
  DI8DEVTYPE_FLIGHT           = $17;
  {$EXTERNALSYM DI8DEVTYPE_FLIGHT}
  DI8DEVTYPE_1STPERSON        = $18;
  {$EXTERNALSYM DI8DEVTYPE_1STPERSON}
  DI8DEVTYPE_DEVICECTRL       = $19;
  {$EXTERNALSYM DI8DEVTYPE_DEVICECTRL}
  DI8DEVTYPE_SCREENPOINTER    = $1A;
  {$EXTERNALSYM DI8DEVTYPE_SCREENPOINTER}
  DI8DEVTYPE_REMOTE           = $1B;
  {$EXTERNALSYM DI8DEVTYPE_REMOTE}
  DI8DEVTYPE_SUPPLEMENTAL     = $1C;
  {$EXTERNALSYM DI8DEVTYPE_SUPPLEMENTAL}
 (* DIRECTINPUT_VERSION <= 0x700 *)

  DIDEVTYPE_HID           = $00010000;
  {$EXTERNALSYM DIDEVTYPE_HID}

  DI8DEVTYPEMOUSE_UNKNOWN                     = 1;
  {$EXTERNALSYM DI8DEVTYPEMOUSE_UNKNOWN}
  DI8DEVTYPEMOUSE_TRADITIONAL                 = 2;
  {$EXTERNALSYM DI8DEVTYPEMOUSE_TRADITIONAL}
  DI8DEVTYPEMOUSE_FINGERSTICK                 = 3;
  {$EXTERNALSYM DI8DEVTYPEMOUSE_FINGERSTICK}
  DI8DEVTYPEMOUSE_TOUCHPAD                    = 4;
  {$EXTERNALSYM DI8DEVTYPEMOUSE_TOUCHPAD}
  DI8DEVTYPEMOUSE_TRACKBALL                   = 5;
  {$EXTERNALSYM DI8DEVTYPEMOUSE_TRACKBALL}
  DI8DEVTYPEMOUSE_ABSOLUTE                    = 6;
  {$EXTERNALSYM DI8DEVTYPEMOUSE_ABSOLUTE}

  DI8DEVTYPEKEYBOARD_UNKNOWN                  = 0;
  {$EXTERNALSYM DI8DEVTYPEKEYBOARD_UNKNOWN}
  DI8DEVTYPEKEYBOARD_PCXT                     = 1;
  {$EXTERNALSYM DI8DEVTYPEKEYBOARD_PCXT}
  DI8DEVTYPEKEYBOARD_OLIVETTI                 = 2;
  {$EXTERNALSYM DI8DEVTYPEKEYBOARD_OLIVETTI}
  DI8DEVTYPEKEYBOARD_PCAT                     = 3;
  {$EXTERNALSYM DI8DEVTYPEKEYBOARD_PCAT}
  DI8DEVTYPEKEYBOARD_PCENH                    = 4;
  {$EXTERNALSYM DI8DEVTYPEKEYBOARD_PCENH}
  DI8DEVTYPEKEYBOARD_NOKIA1050                = 5;
  {$EXTERNALSYM DI8DEVTYPEKEYBOARD_NOKIA1050}
  DI8DEVTYPEKEYBOARD_NOKIA9140                = 6;
  {$EXTERNALSYM DI8DEVTYPEKEYBOARD_NOKIA9140}
  DI8DEVTYPEKEYBOARD_NEC98                    = 7;
  {$EXTERNALSYM DI8DEVTYPEKEYBOARD_NEC98}
  DI8DEVTYPEKEYBOARD_NEC98LAPTOP              = 8;
  {$EXTERNALSYM DI8DEVTYPEKEYBOARD_NEC98LAPTOP}
  DI8DEVTYPEKEYBOARD_NEC98106                 = 9;
  {$EXTERNALSYM DI8DEVTYPEKEYBOARD_NEC98106}
  DI8DEVTYPEKEYBOARD_JAPAN106                 = 10;
  {$EXTERNALSYM DI8DEVTYPEKEYBOARD_JAPAN106}
  DI8DEVTYPEKEYBOARD_JAPANAX                  = 11;
  {$EXTERNALSYM DI8DEVTYPEKEYBOARD_JAPANAX}
  DI8DEVTYPEKEYBOARD_J3100                    = 12;
  {$EXTERNALSYM DI8DEVTYPEKEYBOARD_J3100}

  DI8DEVTYPE_LIMITEDGAMESUBTYPE               = 1;
  {$EXTERNALSYM DI8DEVTYPE_LIMITEDGAMESUBTYPE}

  DI8DEVTYPEJOYSTICK_LIMITED                  = DI8DEVTYPE_LIMITEDGAMESUBTYPE;
  {$EXTERNALSYM DI8DEVTYPEJOYSTICK_LIMITED}
  DI8DEVTYPEJOYSTICK_STANDARD                 = 2;
  {$EXTERNALSYM DI8DEVTYPEJOYSTICK_STANDARD}

  DI8DEVTYPEGAMEPAD_LIMITED                   = DI8DEVTYPE_LIMITEDGAMESUBTYPE;
  {$EXTERNALSYM DI8DEVTYPEGAMEPAD_LIMITED}
  DI8DEVTYPEGAMEPAD_STANDARD                  = 2;
  {$EXTERNALSYM DI8DEVTYPEGAMEPAD_STANDARD}
  DI8DEVTYPEGAMEPAD_TILT                      = 3;
  {$EXTERNALSYM DI8DEVTYPEGAMEPAD_TILT}

  DI8DEVTYPEDRIVING_LIMITED                   = DI8DEVTYPE_LIMITEDGAMESUBTYPE;
  {$EXTERNALSYM DI8DEVTYPEDRIVING_LIMITED}
  DI8DEVTYPEDRIVING_COMBINEDPEDALS            = 2;
  {$EXTERNALSYM DI8DEVTYPEDRIVING_COMBINEDPEDALS}
  DI8DEVTYPEDRIVING_DUALPEDALS                = 3;
  {$EXTERNALSYM DI8DEVTYPEDRIVING_DUALPEDALS}
  DI8DEVTYPEDRIVING_THREEPEDALS               = 4;
  {$EXTERNALSYM DI8DEVTYPEDRIVING_THREEPEDALS}
  DI8DEVTYPEDRIVING_HANDHELD                  = 5;
  {$EXTERNALSYM DI8DEVTYPEDRIVING_HANDHELD}

  DI8DEVTYPEFLIGHT_LIMITED                    = DI8DEVTYPE_LIMITEDGAMESUBTYPE;
  {$EXTERNALSYM DI8DEVTYPEFLIGHT_LIMITED}
  DI8DEVTYPEFLIGHT_STICK                      = 2;
  {$EXTERNALSYM DI8DEVTYPEFLIGHT_STICK}
  DI8DEVTYPEFLIGHT_YOKE                       = 3;
  {$EXTERNALSYM DI8DEVTYPEFLIGHT_YOKE}
  DI8DEVTYPEFLIGHT_RC                         = 4;
  {$EXTERNALSYM DI8DEVTYPEFLIGHT_RC}

  DI8DEVTYPE1STPERSON_LIMITED                 = DI8DEVTYPE_LIMITEDGAMESUBTYPE;
  {$EXTERNALSYM DI8DEVTYPE1STPERSON_LIMITED}
  DI8DEVTYPE1STPERSON_UNKNOWN                 = 2;
  {$EXTERNALSYM DI8DEVTYPE1STPERSON_UNKNOWN}
  DI8DEVTYPE1STPERSON_SIXDOF                  = 3;
  {$EXTERNALSYM DI8DEVTYPE1STPERSON_SIXDOF}
  DI8DEVTYPE1STPERSON_SHOOTER                 = 4;
  {$EXTERNALSYM DI8DEVTYPE1STPERSON_SHOOTER}

  DI8DEVTYPESCREENPTR_UNKNOWN                 = 2;
  {$EXTERNALSYM DI8DEVTYPESCREENPTR_UNKNOWN}
  DI8DEVTYPESCREENPTR_LIGHTGUN                = 3;
  {$EXTERNALSYM DI8DEVTYPESCREENPTR_LIGHTGUN}
  DI8DEVTYPESCREENPTR_LIGHTPEN                = 4;
  {$EXTERNALSYM DI8DEVTYPESCREENPTR_LIGHTPEN}
  DI8DEVTYPESCREENPTR_TOUCH                   = 5;
  {$EXTERNALSYM DI8DEVTYPESCREENPTR_TOUCH}

  DI8DEVTYPEREMOTE_UNKNOWN                    = 2;
  {$EXTERNALSYM DI8DEVTYPEREMOTE_UNKNOWN}

  DI8DEVTYPEDEVICECTRL_UNKNOWN                = 2;
  {$EXTERNALSYM DI8DEVTYPEDEVICECTRL_UNKNOWN}
  DI8DEVTYPEDEVICECTRL_COMMSSELECTION         = 3;
  {$EXTERNALSYM DI8DEVTYPEDEVICECTRL_COMMSSELECTION}
  DI8DEVTYPEDEVICECTRL_COMMSSELECTION_HARDWIRED = 4;
  {$EXTERNALSYM DI8DEVTYPEDEVICECTRL_COMMSSELECTION_HARDWIRED}

  DI8DEVTYPESUPPLEMENTAL_UNKNOWN              = 2;
  {$EXTERNALSYM DI8DEVTYPESUPPLEMENTAL_UNKNOWN}
  DI8DEVTYPESUPPLEMENTAL_2NDHANDCONTROLLER    = 3;
  {$EXTERNALSYM DI8DEVTYPESUPPLEMENTAL_2NDHANDCONTROLLER}
  DI8DEVTYPESUPPLEMENTAL_HEADTRACKER          = 4;
  {$EXTERNALSYM DI8DEVTYPESUPPLEMENTAL_HEADTRACKER}
  DI8DEVTYPESUPPLEMENTAL_HANDTRACKER          = 5;
  {$EXTERNALSYM DI8DEVTYPESUPPLEMENTAL_HANDTRACKER}
  DI8DEVTYPESUPPLEMENTAL_SHIFTSTICKGATE       = 6;
  {$EXTERNALSYM DI8DEVTYPESUPPLEMENTAL_SHIFTSTICKGATE}
  DI8DEVTYPESUPPLEMENTAL_SHIFTER              = 7;
  {$EXTERNALSYM DI8DEVTYPESUPPLEMENTAL_SHIFTER}
  DI8DEVTYPESUPPLEMENTAL_THROTTLE             = 8;
  {$EXTERNALSYM DI8DEVTYPESUPPLEMENTAL_THROTTLE}
  DI8DEVTYPESUPPLEMENTAL_SPLITTHROTTLE        = 9;
  {$EXTERNALSYM DI8DEVTYPESUPPLEMENTAL_SPLITTHROTTLE}
  DI8DEVTYPESUPPLEMENTAL_COMBINEDPEDALS       = 10;
  {$EXTERNALSYM DI8DEVTYPESUPPLEMENTAL_COMBINEDPEDALS}
  DI8DEVTYPESUPPLEMENTAL_DUALPEDALS           = 11;
  {$EXTERNALSYM DI8DEVTYPESUPPLEMENTAL_DUALPEDALS}
  DI8DEVTYPESUPPLEMENTAL_THREEPEDALS          = 12;
  {$EXTERNALSYM DI8DEVTYPESUPPLEMENTAL_THREEPEDALS}
  DI8DEVTYPESUPPLEMENTAL_RUDDERPEDALS         = 13;
  {$EXTERNALSYM DI8DEVTYPESUPPLEMENTAL_RUDDERPEDALS}
 (* DIRECTINPUT_VERSION <= 0x700 *)

// #define GET_DIDEVICE_TYPE(dwDevType)    LOBYTE(dwDevType)
function GET_DIDEVICE_TYPE(dwDevType: DWORD): Byte;
{$EXTERNALSYM GET_DIDEVICE_TYPE}
// #define GET_DIDEVICE_SUBTYPE(dwDevType) HIBYTE(dwDevType)
function GET_DIDEVICE_SUBTYPE(dwDevType: DWORD): Byte;
{$EXTERNALSYM GET_DIDEVICE_SUBTYPE}

 (* #if(DIRECTINPUT_VERSION >= 0x0500) *)
(* This structure is defined for DirectX 3.0 compatibility *)
type
  PDIDevCapsDX3 = ^TDIDevCapsDX3;
  DIDEVCAPS_DX3 = packed record
    dwSize:    DWORD;
    dwFlags:   DWORD;
    dwDevType: DWORD;
    dwAxes:    DWORD;
    dwButtons: DWORD;
    dwPOVs:    DWORD;
  end;
  {$EXTERNALSYM DIDEVCAPS_DX3}
  TDIDevCapsDX3 = DIDEVCAPS_DX3;
 (* DIRECTINPUT_VERSION >= 0x0500 *)

  PDIDevCaps = ^TDIDevCaps;
  DIDEVCAPS = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    dwDevType: DWORD;
    dwAxes: DWORD;
    dwButtons: DWORD;
    dwPOVs: DWORD;
 (* #if(DIRECTINPUT_VERSION >= 0x0500) *)
    dwFFSamplePeriod: DWORD;
    dwFFMinTimeResolution: DWORD;
    dwFirmwareRevision: DWORD;
    dwHardwareRevision: DWORD;
    dwFFDriverVersion: DWORD;
 (* DIRECTINPUT_VERSION >= 0x0500 *)
  end;
  {$EXTERNALSYM DIDEVCAPS}
  TDIDevCaps = DIDEVCAPS;

const
  DIDC_ATTACHED           = $00000001;
  {$EXTERNALSYM DIDC_ATTACHED}
  DIDC_POLLEDDEVICE       = $00000002;
  {$EXTERNALSYM DIDC_POLLEDDEVICE}
  DIDC_EMULATED           = $00000004;
  {$EXTERNALSYM DIDC_EMULATED}
  DIDC_POLLEDDATAFORMAT   = $00000008;
  {$EXTERNALSYM DIDC_POLLEDDATAFORMAT}
 (* #if(DIRECTINPUT_VERSION >= 0x0500) *)
  DIDC_FORCEFEEDBACK      = $00000100;
  {$EXTERNALSYM DIDC_FORCEFEEDBACK}
  DIDC_FFATTACK           = $00000200;
  {$EXTERNALSYM DIDC_FFATTACK}
  DIDC_FFFADE             = $00000400;
  {$EXTERNALSYM DIDC_FFFADE}
  DIDC_SATURATION         = $00000800;
  {$EXTERNALSYM DIDC_SATURATION}
  DIDC_POSNEGCOEFFICIENTS = $00001000;
  {$EXTERNALSYM DIDC_POSNEGCOEFFICIENTS}
  DIDC_POSNEGSATURATION   = $00002000;
  {$EXTERNALSYM DIDC_POSNEGSATURATION}
  DIDC_DEADBAND           = $00004000;
  {$EXTERNALSYM DIDC_DEADBAND}
 (* DIRECTINPUT_VERSION >= 0x0500 *)
  DIDC_STARTDELAY         = $00008000;
  {$EXTERNALSYM DIDC_STARTDELAY}
 (* #if(DIRECTINPUT_VERSION >= 0x050a) *)
  DIDC_ALIAS              = $00010000;
  {$EXTERNALSYM DIDC_ALIAS}
  DIDC_PHANTOM            = $00020000;
  {$EXTERNALSYM DIDC_PHANTOM}
 (* DIRECTINPUT_VERSION >= 0x050a *)
 (* #if(DIRECTINPUT_VERSION >= 0x0800) *)
  DIDC_HIDDEN             = $00040000;
  {$EXTERNALSYM DIDC_HIDDEN}
 (* DIRECTINPUT_VERSION >= 0x0800 *)

  DIDFT_ALL           = $00000000;
  {$EXTERNALSYM DIDFT_ALL}

  DIDFT_RELAXIS       = $00000001;
  {$EXTERNALSYM DIDFT_RELAXIS}
  DIDFT_ABSAXIS       = $00000002;
  {$EXTERNALSYM DIDFT_ABSAXIS}
  DIDFT_AXIS          = $00000003;
  {$EXTERNALSYM DIDFT_AXIS}

  DIDFT_PSHBUTTON     = $00000004;
  {$EXTERNALSYM DIDFT_PSHBUTTON}
  DIDFT_TGLBUTTON     = $00000008;
  {$EXTERNALSYM DIDFT_TGLBUTTON}
  DIDFT_BUTTON        = $0000000C;
  {$EXTERNALSYM DIDFT_BUTTON}

  DIDFT_POV           = $00000010;
  {$EXTERNALSYM DIDFT_POV}
  DIDFT_COLLECTION    = $00000040;
  {$EXTERNALSYM DIDFT_COLLECTION}
  DIDFT_NODATA        = $00000080;
  {$EXTERNALSYM DIDFT_NODATA}

  DIDFT_ANYINSTANCE   = $00FFFF00;
  {$EXTERNALSYM DIDFT_ANYINSTANCE}
  DIDFT_INSTANCEMASK  = DIDFT_ANYINSTANCE;
  {$EXTERNALSYM DIDFT_INSTANCEMASK}

// #define DIDFT_MAKEINSTANCE(n) ((WORD)(n) << 8)
function DIDFT_MAKEINSTANCE(n: Cardinal): Cardinal;
{$EXTERNALSYM DIDFT_MAKEINSTANCE}
// #define DIDFT_GETTYPE(n)     LOBYTE(n)
function DIDFT_GETTYPE(n: Cardinal): Byte;
{$EXTERNALSYM DIDFT_GETTYPE}
// #define DIDFT_GETINSTANCE(n) LOWORD((n) >> 8)
function DIDFT_GETINSTANCE(n: Cardinal): Cardinal;
{$EXTERNALSYM DIDFT_GETINSTANCE}

const
  DIDFT_FFACTUATOR        = $01000000;
  {$EXTERNALSYM DIDFT_FFACTUATOR}
  DIDFT_FFEFFECTTRIGGER   = $02000000;
  {$EXTERNALSYM DIDFT_FFEFFECTTRIGGER}
 (* #if(DIRECTINPUT_VERSION >= 0x050a) *)
  DIDFT_OUTPUT            = $10000000;
  {$EXTERNALSYM DIDFT_OUTPUT}
  DIDFT_VENDORDEFINED     = $04000000;
  {$EXTERNALSYM DIDFT_VENDORDEFINED}
  DIDFT_ALIAS             = $08000000;
  {$EXTERNALSYM DIDFT_ALIAS}
 (* DIRECTINPUT_VERSION >= 0x050a *)
  DIDFT_OPTIONAL          = $80000000;
  {$EXTERNALSYM DIDFT_OPTIONAL}

// #define DIDFT_ENUMCOLLECTION(n) ((WORD)(n) << 8)
function DIDFT_ENUMCOLLECTION(n: Cardinal): Cardinal;
{$EXTERNALSYM DIDFT_ENUMCOLLECTION}

const
  DIDFT_NOCOLLECTION      = $00FFFF00;
  {$EXTERNALSYM DIDFT_NOCOLLECTION}

type
  PDIObjectDataFormat = ^TDIObjectDataFormat;
  _DIOBJECTDATAFORMAT = packed record
    pguid: PGUID;
    dwOfs: DWORD;
    dwType: DWORD;
    dwFlags: DWORD;
  end;
  {$EXTERNALSYM _DIOBJECTDATAFORMAT}
  DIOBJECTDATAFORMAT = _DIOBJECTDATAFORMAT;
  {$EXTERNALSYM DIOBJECTDATAFORMAT}
  TDIObjectDataFormat = _DIOBJECTDATAFORMAT;

  PDIDataFormat = ^TDIDataFormat;
  _DIDATAFORMAT = packed record
    dwSize: DWORD;
    dwObjSize: DWORD;
    dwFlags: DWORD;
    dwDataSize: DWORD;
    dwNumObjs: DWORD;
    rgodf: PDIObjectDataFormat;
  end;
  {$EXTERNALSYM _DIDATAFORMAT}
  DIDATAFORMAT = _DIDATAFORMAT;
  {$EXTERNALSYM DIDATAFORMAT}
  TDIDataFormat = _DIDATAFORMAT;

const
  DIDF_ABSAXIS            = $00000001;
  {$EXTERNALSYM DIDF_ABSAXIS}
  DIDF_RELAXIS            = $00000002;
  {$EXTERNALSYM DIDF_RELAXIS}


 (* #if(DIRECTINPUT_VERSION > 0x0700) *)

type
  PDIActionA = ^TDIActionA;
  PDIActionW = ^TDIActionW;
  PDIAction = PDIActionA;
  _DIACTIONA = packed record
    uAppData: Pointer;
    dwSemantic: DWORD;
    dwFlags: DWORD;
    case Byte of
      0: (
        lptszActionName: PAnsiChar;
        guidInstance: TGUID;
        dwObjID: DWORD;
        dwHow: DWORD;
       );
      1: (
        uResIdString: LongWord;
      );
  end;
  {$EXTERNALSYM _DIACTIONA}
  _DIACTIONW = packed record
    uAppData: Pointer;
    dwSemantic: DWORD;
    dwFlags: DWORD;
    case Byte of
      0: (
        lptszActionName: PWideChar;
        guidInstance: TGUID;
        dwObjID: DWORD;
        dwHow: DWORD;
       );
      1: (
        uResIdString: LongWord;
      );
  end;
  {$EXTERNALSYM _DIACTIONW}
  _DIACTION = _DIACTIONA;
  {$EXTERNALSYM _DIACTION}
  DIACTIONA = _DIACTIONA;
  {$EXTERNALSYM DIACTIONA}
  DIACTIONW = _DIACTIONW;
  {$EXTERNALSYM DIACTIONW}
  DIACTION = DIACTIONA;
  {$EXTERNALSYM DIACTION}
  TDIActionA = _DIACTIONA;
  TDIActionW = _DIACTIONW;
  TDIAction = TDIActionA;

const
  DIA_FORCEFEEDBACK       = $00000001;
  {$EXTERNALSYM DIA_FORCEFEEDBACK}
  DIA_APPMAPPED           = $00000002;
  {$EXTERNALSYM DIA_APPMAPPED}
  DIA_APPNOMAP            = $00000004;
  {$EXTERNALSYM DIA_APPNOMAP}
  DIA_NORANGE             = $00000008;
  {$EXTERNALSYM DIA_NORANGE}
  DIA_APPFIXED            = $00000010;
  {$EXTERNALSYM DIA_APPFIXED}

  DIAH_UNMAPPED           = $00000000;
  {$EXTERNALSYM DIAH_UNMAPPED}
  DIAH_USERCONFIG         = $00000001;
  {$EXTERNALSYM DIAH_USERCONFIG}
  DIAH_APPREQUESTED       = $00000002;
  {$EXTERNALSYM DIAH_APPREQUESTED}
  DIAH_HWAPP              = $00000004;
  {$EXTERNALSYM DIAH_HWAPP}
  DIAH_HWDEFAULT          = $00000008;
  {$EXTERNALSYM DIAH_HWDEFAULT}
  DIAH_DEFAULT            = $00000020;
  {$EXTERNALSYM DIAH_DEFAULT}
  DIAH_ERROR              = $80000000;
  {$EXTERNALSYM DIAH_ERROR}

type
  PDIActionFormatA = ^TDIActionFormatA;
  PDIActionFormatW = ^TDIActionFormatW;
  PDIActionFormat = PDIActionFormatA;
  _DIACTIONFORMATA = packed record
    dwSize        : DWORD;
    dwActionSize  : DWORD;
    dwDataSize    : DWORD;
    dwNumActions  : DWORD;
    rgoAction     : PDIActionA;
    guidActionMap : TGUID;
    dwGenre       : DWORD;
    dwBufferSize  : DWORD;
    lAxisMin      : Longint;
    lAxisMax      : Longint;
    hInstString   : THandle;
    ftTimeStamp   : TFileTime;
    dwCRC         : DWORD;
    tszActionMap  : array [0..MAX_PATH-1] of AnsiChar;
  end;
  {$EXTERNALSYM _DIACTIONFORMATA}
  _DIACTIONFORMATW = packed record
    dwSize        : DWORD;
    dwActionSize  : DWORD;
    dwDataSize    : DWORD;
    dwNumActions  : DWORD;
    rgoAction     : PDIActionW;
    guidActionMap : TGUID;
    dwGenre       : DWORD;
    dwBufferSize  : DWORD;
    lAxisMin      : Longint;
    lAxisMax      : Longint;
    hInstString   : THandle;
    ftTimeStamp   : TFileTime;
    dwCRC         : DWORD;
    tszActionMap  : array [0..MAX_PATH-1] of WideChar;
  end;
  {$EXTERNALSYM _DIACTIONFORMATW}
  _DIACTIONFORMAT = _DIACTIONFORMATA;
  {$EXTERNALSYM _DIACTIONFORMAT}
  DIACTIONFORMATA = _DIACTIONFORMATA;
  {$EXTERNALSYM DIACTIONFORMATA}
  DIACTIONFORMATW = _DIACTIONFORMATW;
  {$EXTERNALSYM DIACTIONFORMATW}
  DIACTIONFORMAT = DIACTIONFORMATA;
  {$EXTERNALSYM DIACTIONFORMAT}
  TDIActionFormatA = _DIACTIONFORMATA;
  TDIActionFormatW = _DIACTIONFORMATW;
  TDIActionFormat = TDIActionFormatA;

const
  DIAFTS_NEWDEVICELOW     = $FFFFFFFF;
  {$EXTERNALSYM DIAFTS_NEWDEVICELOW}
  DIAFTS_NEWDEVICEHIGH    = $FFFFFFFF;
  {$EXTERNALSYM DIAFTS_NEWDEVICEHIGH}
  DIAFTS_UNUSEDDEVICELOW  = $00000000;
  {$EXTERNALSYM DIAFTS_UNUSEDDEVICELOW}
  DIAFTS_UNUSEDDEVICEHIGH = $00000000;
  {$EXTERNALSYM DIAFTS_UNUSEDDEVICEHIGH}

  DIDBAM_DEFAULT          = $00000000;
  {$EXTERNALSYM DIDBAM_DEFAULT}
  DIDBAM_PRESERVE         = $00000001;
  {$EXTERNALSYM DIDBAM_PRESERVE}
  DIDBAM_INITIALIZE       = $00000002;
  {$EXTERNALSYM DIDBAM_INITIALIZE}
  DIDBAM_HWDEFAULTS       = $00000004;
  {$EXTERNALSYM DIDBAM_HWDEFAULTS}

  DIDSAM_DEFAULT          = $00000000;
  {$EXTERNALSYM DIDSAM_DEFAULT}
  DIDSAM_NOUSER           = $00000001;
  {$EXTERNALSYM DIDSAM_NOUSER}
  DIDSAM_FORCESAVE        = $00000002;
  {$EXTERNALSYM DIDSAM_FORCESAVE}

  DICD_DEFAULT            = $00000000;
  {$EXTERNALSYM DICD_DEFAULT}
  DICD_EDIT               = $00000001;
  {$EXTERNALSYM DICD_EDIT}

(*
 * The following definition is normally defined in d3dtypes.h
 *)
type
  D3DCOLOR = DXTypes.D3DCOLOR;
  {$EXTERNALSYM D3DCOLOR}
  TD3DColor = DXTypes.TD3DColor;
  PD3DColor = DXTypes.PD3DColor;

  PDIColorSet = ^TDIColorSet;
  _DICOLORSET = packed record
    dwSize: DWORD;
    cTextFore: TD3DColor;
    cTextHighlight: TD3DColor;
    cCalloutLine: TD3DColor;
    cCalloutHighlight: TD3DColor;
    cBorder: TD3DColor;
    cControlFill: TD3DColor;
    cHighlightFill: TD3DColor;
    cAreaFill: TD3DColor;
  end;
  {$EXTERNALSYM _DICOLORSET}
  DICOLORSET = _DICOLORSET;
  {$EXTERNALSYM DICOLORSET}
  TDIColorSet = _DICOLORSET;

  PDIConfigureDevicesParamsA = ^TDIConfigureDevicesParamsA;
  PDIConfigureDevicesParamsW = ^TDIConfigureDevicesParamsW;
  PDIConfigureDevicesParams = PDIConfigureDevicesParamsA;
  _DICONFIGUREDEVICESPARAMSA = packed record
     dwSize:         DWORD;
     dwcUsers:       DWORD;
     lptszUserNames: PAnsiChar;
     dwcFormats:     DWORD;
     lprgFormats:    PDIActionFormatA;
     hwnd:           HWND;
     dics:           TDIColorSet;
     lpUnkDDSTarget: IUnknown;
  end;
  {$EXTERNALSYM _DICONFIGUREDEVICESPARAMSA}
  _DICONFIGUREDEVICESPARAMSW = packed record
     dwSize:         DWORD;
     dwcUsers:       DWORD;
     lptszUserNames: PWideChar;
     dwcFormats:     DWORD;
     lprgFormats:    PDIActionFormatW;
     hwnd:           HWND;
     dics:           TDIColorSet;
     lpUnkDDSTarget: IUnknown;
  end;
  {$EXTERNALSYM _DICONFIGUREDEVICESPARAMSW}
  _DICONFIGUREDEVICESPARAMS = _DICONFIGUREDEVICESPARAMSA;
  {$EXTERNALSYM _DICONFIGUREDEVICESPARAMS}
  DICONFIGUREDEVICESPARAMSA = _DICONFIGUREDEVICESPARAMSA;
  {$EXTERNALSYM DICONFIGUREDEVICESPARAMSA}
  DICONFIGUREDEVICESPARAMSW = _DICONFIGUREDEVICESPARAMSW;
  {$EXTERNALSYM DICONFIGUREDEVICESPARAMSW}
  DICONFIGUREDEVICESPARAMS = DICONFIGUREDEVICESPARAMSA;
  {$EXTERNALSYM DICONFIGUREDEVICESPARAMS}
  TDIConfigureDevicesParamsA = _DICONFIGUREDEVICESPARAMSA;
  TDIConfigureDevicesParamsW = _DICONFIGUREDEVICESPARAMSW;
  TDIConfigureDevicesParams = TDIConfigureDevicesParamsA;

const
  DIDIFT_CONFIGURATION    = $00000001;
  {$EXTERNALSYM DIDIFT_CONFIGURATION}
  DIDIFT_OVERLAY          = $00000002;
  {$EXTERNALSYM DIDIFT_OVERLAY}

  DIDAL_CENTERED      = $00000000;
  {$EXTERNALSYM DIDAL_CENTERED}
  DIDAL_LEFTALIGNED   = $00000001;
  {$EXTERNALSYM DIDAL_LEFTALIGNED}
  DIDAL_RIGHTALIGNED  = $00000002;
  {$EXTERNALSYM DIDAL_RIGHTALIGNED}
  DIDAL_MIDDLE        = $00000000;
  {$EXTERNALSYM DIDAL_MIDDLE}
  DIDAL_TOPALIGNED    = $00000004;
  {$EXTERNALSYM DIDAL_TOPALIGNED}
  DIDAL_BOTTOMALIGNED = $00000008;
  {$EXTERNALSYM DIDAL_BOTTOMALIGNED}

type
  PDIDeviceImageInfoA = ^TDIDeviceImageInfoA;
  PDIDeviceImageInfoW = ^TDIDeviceImageInfoW;
  PDIDeviceImageInfo = PDIDeviceImageInfoA;
  _DIDEVICEIMAGEINFOA = packed record
    tszImagePath: array [0..MAX_PATH-1] of AnsiChar;
    dwFlags:         DWORD;
    // These are valid if DIDIFT_OVERLAY is present in dwFlags.
    dwViewID:        DWORD;
    rcOverlay:       TRect;
    dwObjID:         DWORD;
    dwcValidPts:     DWORD;
    rgptCalloutLine: array [0..4] of TPoint;
    rcCalloutRect:   TRect;
    dwTextAlign:     DWORD;
  end;
  {$EXTERNALSYM _DIDEVICEIMAGEINFOA}
  _DIDEVICEIMAGEINFOW = packed record
    tszImagePath: array [0..MAX_PATH-1] of WideChar;
    dwFlags:         DWORD;
    // These are valid if DIDIFT_OVERLAY is present in dwFlags.
    dwViewID:        DWORD;
    rcOverlay:       TRect;
    dwObjID:         DWORD;
    dwcValidPts:     DWORD;
    rgptCalloutLine: array [0..4] of TPoint;
    rcCalloutRect:   TRect;
    dwTextAlign:     DWORD;
  end;
  {$EXTERNALSYM _DIDEVICEIMAGEINFOW}
  _DIDEVICEIMAGEINFO = _DIDEVICEIMAGEINFOA;
  {$EXTERNALSYM _DIDEVICEIMAGEINFO}
  DIDEVICEIMAGEINFOA = _DIDEVICEIMAGEINFOA;
  {$EXTERNALSYM DIDEVICEIMAGEINFOA}
  DIDEVICEIMAGEINFOW = _DIDEVICEIMAGEINFOW;
  {$EXTERNALSYM DIDEVICEIMAGEINFOW}
  DIDEVICEIMAGEINFO = DIDEVICEIMAGEINFOA;
  {$EXTERNALSYM DIDEVICEIMAGEINFO}
  TDIDeviceImageInfoA = _DIDEVICEIMAGEINFOA;
  TDIDeviceImageInfoW = _DIDEVICEIMAGEINFOW;
  TDIDeviceImageInfo = TDIDeviceImageInfoA;

  PDIDeviceImageInfoHeaderA = ^TDIDeviceImageInfoHeaderA;
  PDIDeviceImageInfoHeaderW = ^TDIDeviceImageInfoHeaderW;
  PDIDeviceImageInfoHeader = PDIDeviceImageInfoHeaderA;
  _DIDEVICEIMAGEINFOHEADERA = packed record
    dwSize:             DWORD;
    dwSizeImageInfo:    DWORD;
    dwcViews:           DWORD;
    dwcButtons:         DWORD;
    dwcAxes:            DWORD;
    dwcPOVs:            DWORD;
    dwBufferSize:       DWORD;
    dwBufferUsed:       DWORD;
    lprgImageInfoArray: PDIDeviceImageInfoA;
  end;
  {$EXTERNALSYM _DIDEVICEIMAGEINFOHEADERA}
  _DIDEVICEIMAGEINFOHEADERW = packed record
    dwSize:             DWORD;
    dwSizeImageInfo:    DWORD;
    dwcViews:           DWORD;
    dwcButtons:         DWORD;
    dwcAxes:            DWORD;
    dwcPOVs:            DWORD;
    dwBufferSize:       DWORD;
    dwBufferUsed:       DWORD;
    lprgImageInfoArray: PDIDeviceImageInfoW;
  end;
  {$EXTERNALSYM _DIDEVICEIMAGEINFOHEADERW}
  _DIDEVICEIMAGEINFOHEADER = _DIDEVICEIMAGEINFOHEADERA;
  {$EXTERNALSYM _DIDEVICEIMAGEINFOHEADER}
  DIDEVICEIMAGEINFOHEADERA = _DIDEVICEIMAGEINFOHEADERA;
  {$EXTERNALSYM _DIDEVICEIMAGEINFOHEADERA}
  DIDEVICEIMAGEINFOHEADERW = _DIDEVICEIMAGEINFOHEADERW;
  {$EXTERNALSYM _DIDEVICEIMAGEINFOHEADERW}
  DIDEVICEIMAGEINFOHEADER = DIDEVICEIMAGEINFOHEADERA;
  {$EXTERNALSYM _DIDEVICEIMAGEINFOHEADER}
  TDIDeviceImageInfoHeaderA = _DIDEVICEIMAGEINFOHEADERA;
  TDIDeviceImageInfoHeaderW = _DIDEVICEIMAGEINFOHEADERW;
  TDIDeviceImageInfoHeader = TDIDeviceImageInfoHeaderA;

 (* DIRECTINPUT_VERSION > 0x0700 *)

 (* #if(DIRECTINPUT_VERSION >= 0x0500) *)
(* These structures are defined for DirectX 3.0 compatibility *)

type
  PDIDeviceObjectInstanceDX3A = ^TDIDeviceObjectInstanceDX3A;
  PDIDeviceObjectInstanceDX3W = ^TDIDeviceObjectInstanceDX3W;
  PDIDeviceObjectInstanceDX3 = PDIDeviceObjectInstanceDX3A;
  DIDEVICEOBJECTINSTANCE_DX3A = packed record
    dwSize:   DWORD;
    guidType: TGUID;
    dwOfs:    DWORD;
    dwType:   DWORD;
    dwFlags:  DWORD;
    tszName: array [0..MAX_PATH-1] of AnsiChar;
  end;
  {$EXTERNALSYM DIDEVICEOBJECTINSTANCE_DX3A}
  DIDEVICEOBJECTINSTANCE_DX3W = packed record
    dwSize:   DWORD;
    guidType: TGUID;
    dwOfs:    DWORD;
    dwType:   DWORD;
    dwFlags:  DWORD;
    tszName: array [0..MAX_PATH-1] of WideChar;
  end;
  {$EXTERNALSYM DIDEVICEOBJECTINSTANCE_DX3W}
  DIDEVICEOBJECTINSTANCE_DX3 = DIDEVICEOBJECTINSTANCE_DX3A;
  {$EXTERNALSYM DIDEVICEOBJECTINSTANCE_DX3}
  TDIDeviceObjectInstanceDX3A = DIDEVICEOBJECTINSTANCE_DX3A;
  TDIDeviceObjectInstanceDX3W = DIDEVICEOBJECTINSTANCE_DX3W;
  TDIDeviceObjectInstanceDX3 = TDIDeviceObjectInstanceDX3A;

 (* DIRECTINPUT_VERSION >= 0x0500 *)

type
  PDIDeviceObjectInstanceA = ^TDIDeviceObjectInstanceA;
  PDIDeviceObjectInstanceW = ^TDIDeviceObjectInstanceW;
  PDIDeviceObjectInstance = PDIDeviceObjectInstanceA;
  DIDEVICEOBJECTINSTANCEA = packed record
    dwSize:              DWORD;
    guidType:            TGUID;
    dwOfs:               DWORD;
    dwType:              DWORD;
    dwFlags:             DWORD;
    tszName: array[0..MAX_PATH-1] of AnsiChar;
 (* #if(DIRECTINPUT_VERSION >= 0x0500) *)
    dwFFMaxForce:        DWORD;
    dwFFForceResolution: DWORD;
    wCollectionNumber:   Word;
    wDesignatorIndex:    Word;
    wUsagePage:          Word;
    wUsage:              Word;
    dwDimension:         DWORD;
    wExponent:           Word;
    wReportId:           Word;
 (* DIRECTINPUT_VERSION >= 0x0500 *)
  end;
  {$EXTERNALSYM DIDEVICEOBJECTINSTANCEA}
  DIDEVICEOBJECTINSTANCEW = packed record
    dwSize:              DWORD;
    guidType:            TGUID;
    dwOfs:               DWORD;
    dwType:              DWORD;
    dwFlags:             DWORD;
    tszName: array[0..MAX_PATH-1] of WideChar;
 (* #if(DIRECTINPUT_VERSION >= 0x0500) *)
    dwFFMaxForce:        DWORD;
    dwFFForceResolution: DWORD;
    wCollectionNumber:   Word;
    wDesignatorIndex:    Word;
    wUsagePage:          Word;
    wUsage:              Word;
    dwDimension:         DWORD;
    wExponent:           Word;
    wReportId:           Word;
 (* DIRECTINPUT_VERSION >= 0x0500 *)
  end;
  {$EXTERNALSYM DIDEVICEOBJECTINSTANCEW}
  DIDEVICEOBJECTINSTANCE = DIDEVICEOBJECTINSTANCEA;
  {$EXTERNALSYM DIDEVICEOBJECTINSTANCE}
  TDIDeviceObjectInstanceA = DIDEVICEOBJECTINSTANCEA;
  TDIDeviceObjectInstanceW = DIDEVICEOBJECTINSTANCEW;
  TDIDeviceObjectInstance = TDIDeviceObjectInstanceA;


type
  TDIEnumDeviceObjectsCallbackA = function (var lpddoi: TDIDeviceObjectInstanceA; pvRef : Pointer): BOOL; stdcall;
  {$EXTERNALSYM TDIEnumDeviceObjectsCallbackA}
  TDIEnumDeviceObjectsCallbackW = function (var lpddoi: TDIDeviceObjectInstanceW; pvRef : Pointer): BOOL; stdcall;
  {$EXTERNALSYM TDIEnumDeviceObjectsCallbackW}
  TDIEnumDeviceObjectsCallback = TDIEnumDeviceObjectsCallbackA;
  {$EXTERNALSYM TDIEnumDeviceObjectsCallback}


 (* #if(DIRECTINPUT_VERSION >= 0x0500) *)
const
  DIDOI_FFACTUATOR        = $00000001;
  {$EXTERNALSYM DIDOI_FFACTUATOR}
  DIDOI_FFEFFECTTRIGGER   = $00000002;
  {$EXTERNALSYM DIDOI_FFEFFECTTRIGGER}
  DIDOI_POLLED            = $00008000;
  {$EXTERNALSYM DIDOI_POLLED}
  DIDOI_ASPECTPOSITION    = $00000100;
  {$EXTERNALSYM DIDOI_ASPECTPOSITION}
  DIDOI_ASPECTVELOCITY    = $00000200;
  {$EXTERNALSYM DIDOI_ASPECTVELOCITY}
  DIDOI_ASPECTACCEL       = $00000300;
  {$EXTERNALSYM DIDOI_ASPECTACCEL}
  DIDOI_ASPECTFORCE       = $00000400;
  {$EXTERNALSYM DIDOI_ASPECTFORCE}
  DIDOI_ASPECTMASK        = $00000F00;
  {$EXTERNALSYM DIDOI_ASPECTMASK}
 (* DIRECTINPUT_VERSION >= 0x0500 *)
 (* #if(DIRECTINPUT_VERSION >= 0x050a) *)
  DIDOI_GUIDISUSAGE       = $00010000;
  {$EXTERNALSYM DIDOI_GUIDISUSAGE}
 (* DIRECTINPUT_VERSION >= 0x050a *)

type
  PDIPropHeader = ^TDIPropHeader;
  DIPROPHEADER = packed record
    dwSize: DWORD;
    dwHeaderSize: DWORD;
    dwObj: DWORD;
    dwHow: DWORD;
  end;
  {$EXTERNALSYM DIPROPHEADER}
  TDIPropHeader = DIPROPHEADER;

const
  DIPH_DEVICE             = 0;
  {$EXTERNALSYM DIPH_DEVICE}
  DIPH_BYOFFSET           = 1;
  {$EXTERNALSYM DIPH_BYOFFSET}
  DIPH_BYID               = 2;
  {$EXTERNALSYM DIPH_BYID}
 (* #if(DIRECTINPUT_VERSION >= 0x050a) *)
  DIPH_BYUSAGE            = 3;
  {$EXTERNALSYM DIPH_BYUSAGE}
 (* DIRECTINPUT_VERSION >= 0x050a *)

 (* #if(DIRECTINPUT_VERSION >= 0x050a) *)
// #define DIMAKEUSAGEDWORD(UsagePage, Usage) \
//                                 (DWORD)MAKELONG(Usage, UsagePage)
function DIMAKEUSAGEDWORD(UsagePage, Usage: Word): DWORD;
{$EXTERNALSYM DIMAKEUSAGEDWORD}
 (* DIRECTINPUT_VERSION >= 0x050a *)

type
  PDIPropDWord = ^TDIPropDWord;
  DIPROPDWORD = packed record
    diph: TDIPropHeader;
    dwData: DWORD;
  end;
  {$EXTERNALSYM DIPROPDWORD}
  TDIPropDWord = DIPROPDWORD;

 (* #if(DIRECTINPUT_VERSION >= 0x0800) *)
  PDIPropPointer = ^TDIPropPointer;
  DIPROPPOINTER = packed record
    diph: TDIPropHeader;
    uData: Pointer;
  end;
  {$EXTERNALSYM DIPROPPOINTER}
  TDIPropPointer = DIPROPPOINTER;
 (* DIRECTINPUT_VERSION >= 0x0800 *)

  PDIPropRange = ^TDIPropRange;
  DIPROPRANGE = packed record
    diph: TDIPropHeader;
    lMin: Longint;
    lMax: Longint;
  end;
  {$EXTERNALSYM DIPROPRANGE}
  TDIPropRange = DIPROPRANGE;

const
  DIPROPRANGE_NOMIN       = $80000000;
  {$EXTERNALSYM DIPROPRANGE_NOMIN}
  DIPROPRANGE_NOMAX       = $7FFFFFFF;
  {$EXTERNALSYM DIPROPRANGE_NOMAX}

 (* #if(DIRECTINPUT_VERSION >= 0x050a) *)
type
  PDIPropCal = ^TDIPropCal;
  DIPROPCAL = packed record
    diph: TDIPropHeader;
    lMin: Longint;
    lCenter: Longint;
    lMax: Longint;
  end;
  {$EXTERNALSYM DIPROPCAL}
  TDIPropCal = DIPROPCAL;

  PDIPropCalPov = ^TDIPropCalPov;
  DIPROPCALPOV = packed record
    diph: TDIPropHeader;
    lMin: array[0..4] of Longint;
    lMax: array[0..4] of Longint;
  end;
  {$EXTERNALSYM DIPROPCALPOV}
  TDIPropCalPov = DIPROPCALPOV;

  PDIPropGuidAndPath = ^TDIPropGuidAndPath;
  DIPROPGUIDANDPATH = packed record
    diph: TDIPropHeader;
    guidClass: TGUID;
    wszPath: array[0..MAX_PATH-1] of WideChar;
  end;
  {$EXTERNALSYM DIPROPGUIDANDPATH}
  TDIPropGuidAndPath = DIPROPGUIDANDPATH;

  PDIPropString = ^TDIPropString;
  DIPROPSTRING = packed record
    diph: TDIPropHeader;
    wsz: array[0..MAX_PATH-1] of WideChar;
  end;
  {$EXTERNALSYM DIPROPSTRING}
  TDIPropString = DIPROPSTRING;

 (* DIRECTINPUT_VERSION >= 0x050a *)

 (* #if(DIRECTINPUT_VERSION >= 0x0800) *)
const
  MAXCPOINTSNUM          = 8;
  {$EXTERNALSYM MAXCPOINTSNUM}

type
  PCPoint = ^TCPoint;
  _CPOINT = packed record
    lP: Longint;   // raw value
    dwLog: DWORD;  // logical_value / max_logical_value * 10000
  end;
  {$EXTERNALSYM _CPOINT}
  CPOINT = _CPOINT;
  {$EXTERNALSYM CPOINT}
  TCPoint = _CPOINT;

  PDIPropCPoints = ^TDIPropCPoints;
  DIPROPCPOINTS = packed record
    diph: TDIPropHeader;
    dwCPointsNum: DWORD;
    cp: array[0..MAXCPOINTSNUM-1] of TCPoint;
  end;
  {$EXTERNALSYM DIPROPCPOINTS}
  TDIPropCPoints = DIPROPCPOINTS;
 (* DIRECTINPUT_VERSION >= 0x0800 *)


// #define MAKEDIPROP(prop)    (*(const GUID *)(prop))

type
  MAKEDIPROP = PGUID;
  {$EXTERNALSYM MAKEDIPROP}

const
  DIPROP_BUFFERSIZE       = MAKEDIPROP(1);
  {$EXTERNALSYM DIPROP_BUFFERSIZE}

  DIPROP_AXISMODE         = MAKEDIPROP(2);
  {$EXTERNALSYM DIPROP_AXISMODE}

  DIPROPAXISMODE_ABS      = 0;
  {$EXTERNALSYM DIPROPAXISMODE_ABS}
  DIPROPAXISMODE_REL      = 1;
  {$EXTERNALSYM DIPROPAXISMODE_REL}

  DIPROP_GRANULARITY      = MAKEDIPROP(3);
  {$EXTERNALSYM DIPROP_GRANULARITY}

  DIPROP_RANGE            = MAKEDIPROP(4);
  {$EXTERNALSYM DIPROP_RANGE}

  DIPROP_DEADZONE         = MAKEDIPROP(5);
  {$EXTERNALSYM DIPROP_DEADZONE}

  DIPROP_SATURATION       = MAKEDIPROP(6);
  {$EXTERNALSYM DIPROP_SATURATION}

  DIPROP_FFGAIN           = MAKEDIPROP(7);
  {$EXTERNALSYM DIPROP_FFGAIN}

  DIPROP_FFLOAD           = MAKEDIPROP(8);
  {$EXTERNALSYM DIPROP_FFLOAD}

  DIPROP_AUTOCENTER       = MAKEDIPROP(9);
  {$EXTERNALSYM DIPROP_AUTOCENTER}

  DIPROPAUTOCENTER_OFF    = 0;
  {$EXTERNALSYM DIPROPAUTOCENTER_OFF}
  DIPROPAUTOCENTER_ON     = 1;
  {$EXTERNALSYM DIPROPAUTOCENTER_ON}

  DIPROP_CALIBRATIONMODE  = MAKEDIPROP(10);
  {$EXTERNALSYM DIPROP_CALIBRATIONMODE}

  DIPROPCALIBRATIONMODE_COOKED    = 0;
  {$EXTERNALSYM DIPROPCALIBRATIONMODE_COOKED}
  DIPROPCALIBRATIONMODE_RAW       = 1;
  {$EXTERNALSYM DIPROPCALIBRATIONMODE_RAW}

 (* #if(DIRECTINPUT_VERSION >= 0x050a) *)
  DIPROP_CALIBRATION      = MAKEDIPROP(11);
  {$EXTERNALSYM DIPROP_CALIBRATION}

  DIPROP_GUIDANDPATH      = MAKEDIPROP(12);
  {$EXTERNALSYM DIPROP_GUIDANDPATH}

  DIPROP_INSTANCENAME     = MAKEDIPROP(13);
  {$EXTERNALSYM DIPROP_INSTANCENAME}

  DIPROP_PRODUCTNAME      = MAKEDIPROP(14);
  {$EXTERNALSYM DIPROP_PRODUCTNAME}
 (* DIRECTINPUT_VERSION >= 0x050a *)

 (* #if(DIRECTINPUT_VERSION >= 0x05b2) *)
  DIPROP_JOYSTICKID       = MAKEDIPROP(15);
  {$EXTERNALSYM DIPROP_JOYSTICKID}

  DIPROP_GETPORTDISPLAYNAME = MAKEDIPROP(16);
  {$EXTERNALSYM DIPROP_GETPORTDISPLAYNAME}

 (* DIRECTINPUT_VERSION >= 0x05b2 *)

 (* #if(DIRECTINPUT_VERSION >= 0x0700) *)
  DIPROP_PHYSICALRANGE    = MAKEDIPROP(18);
  {$EXTERNALSYM DIPROP_PHYSICALRANGE}

  DIPROP_LOGICALRANGE     = MAKEDIPROP(19);
  {$EXTERNALSYM DIPROP_LOGICALRANGE}
 (* DIRECTINPUT_VERSION >= 0x0700 *)

 (* #if(DIRECTINPUT_VERSION >= 0x0800) *)
  DIPROP_KEYNAME          = MAKEDIPROP(20);
  {$EXTERNALSYM DIPROP_KEYNAME}

  DIPROP_CPOINTS          = MAKEDIPROP(21);
  {$EXTERNALSYM DIPROP_CPOINTS}

  DIPROP_APPDATA          = MAKEDIPROP(22);
  {$EXTERNALSYM DIPROP_APPDATA}

  DIPROP_SCANCODE         = MAKEDIPROP(23);
  {$EXTERNALSYM DIPROP_SCANCODE}

  DIPROP_VIDPID           = MAKEDIPROP(24);
  {$EXTERNALSYM DIPROP_VIDPID}

  DIPROP_USERNAME         = MAKEDIPROP(25);
  {$EXTERNALSYM DIPROP_USERNAME}

  DIPROP_TYPENAME         = MAKEDIPROP(26);
  {$EXTERNALSYM DIPROP_TYPENAME}
 (* DIRECTINPUT_VERSION >= 0x0800 *)


type
  PDIDeviceObjectDataDX3 = ^TDIDeviceObjectDataDX3;
  DIDEVICEOBJECTDATA_DX3 = packed record
    dwOfs: DWORD;
    dwData: DWORD;
    dwTimeStamp: DWORD;
    dwSequence: DWORD;
  end;
  {$EXTERNALSYM DIDEVICEOBJECTDATA_DX3}
  TDIDeviceObjectDataDX3 = DIDEVICEOBJECTDATA_DX3;

  PDIDeviceObjectData = ^TDIDeviceObjectData;
  DIDEVICEOBJECTDATA = packed record
    dwOfs: DWORD;
    dwData: DWORD;
    dwTimeStamp: DWORD;
    dwSequence: DWORD;
 (* #if(DIRECTINPUT_VERSION >= 0x0800) *)
    uAppData: Pointer;
 (* DIRECTINPUT_VERSION >= 0x0800 *)
  end;
  {$EXTERNALSYM DIDEVICEOBJECTDATA}
  TDIDeviceObjectData = DIDEVICEOBJECTDATA;

const
  DIGDD_PEEK          = $00000001;
  {$EXTERNALSYM DIGDD_PEEK}

// #define DISEQUENCE_COMPARE(dwSequence1, cmp, dwSequence2) \
//                         ((int)((dwSequence1) - (dwSequence2)) cmp 0)
// Translator: This is not convertable to pascal   

const
  DISCL_EXCLUSIVE     = $00000001;
  {$EXTERNALSYM DISCL_EXCLUSIVE}
  DISCL_NONEXCLUSIVE  = $00000002;
  {$EXTERNALSYM DISCL_NONEXCLUSIVE}
  DISCL_FOREGROUND    = $00000004;
  {$EXTERNALSYM DISCL_FOREGROUND}
  DISCL_BACKGROUND    = $00000008;
  {$EXTERNALSYM DISCL_BACKGROUND}
  DISCL_NOWINKEY      = $00000010;
  {$EXTERNALSYM DISCL_NOWINKEY}

 (* #if(DIRECTINPUT_VERSION >= 0x0500) *)
(* These structures are defined for DirectX 3.0 compatibility *)

type
  PDIDeviceInstanceDX3A = ^TDIDeviceInstanceDX3A;
  PDIDeviceInstanceDX3W = ^TDIDeviceInstanceDX3W;
  PDIDeviceInstanceDX3 = PDIDeviceInstanceDX3A;
  DIDEVICEINSTANCE_DX3A = packed record
    dwSize: DWORD;
    guidInstance: TGUID;
    guidProduct: TGUID;
    dwDevType: DWORD;
    tszInstanceName: array[0..MAX_PATH-1] of AnsiChar;
    tszProductName: array[0..MAX_PATH-1] of AnsiChar;
  end;
  {$EXTERNALSYM DIDEVICEINSTANCE_DX3A}
  DIDEVICEINSTANCE_DX3W = packed record
    dwSize: DWORD;
    guidInstance: TGUID;
    guidProduct: TGUID;
    dwDevType: DWORD;
    tszInstanceName: array[0..MAX_PATH-1] of WideChar;
    tszProductName: array[0..MAX_PATH-1] of WideChar;
  end;
  {$EXTERNALSYM DIDEVICEINSTANCE_DX3W}
  DIDEVICEINSTANCE_DX3 = DIDEVICEINSTANCE_DX3A;
  {$EXTERNALSYM DIDEVICEINSTANCE_DX3}
  TDIDeviceInstanceDX3A = DIDEVICEINSTANCE_DX3A;
  TDIDeviceInstanceDX3W = DIDEVICEINSTANCE_DX3W;
  TDIDeviceInstanceDX3 = TDIDeviceInstanceDX3A;
 (* DIRECTINPUT_VERSION >= 0x0500 *)

type
  PDIDeviceInstanceA = ^TDIDeviceInstanceA;
  PDIDeviceInstanceW = ^TDIDeviceInstanceW;
  PDIDeviceInstance = PDIDeviceInstanceA;
  DIDEVICEINSTANCEA = packed record
    dwSize: DWORD;
    guidInstance: TGUID;
    guidProduct: TGUID;
    dwDevType: DWORD;
    tszInstanceName: array[0..MAX_PATH-1] of AnsiChar;
    tszProductName: array[0..MAX_PATH-1] of AnsiChar;
 (* #if(DIRECTINPUT_VERSION >= 0x0500) *)
    guidFFDriver: TGUID;
    wUsagePage: Word;
    wUsage: Word;
 (* DIRECTINPUT_VERSION >= 0x0500 *)
  end;
  {$EXTERNALSYM DIDEVICEINSTANCEA}
  DIDEVICEINSTANCEW = packed record
    dwSize: DWORD;
    guidInstance: TGUID;
    guidProduct: TGUID;
    dwDevType: DWORD;
    tszInstanceName: array[0..MAX_PATH-1] of WideChar;
    tszProductName: array[0..MAX_PATH-1] of WideChar;
 (* #if(DIRECTINPUT_VERSION >= 0x0500) *)
    guidFFDriver: TGUID;
    wUsagePage: Word;
    wUsage: Word;
 (* DIRECTINPUT_VERSION >= 0x0500 *)
  end;
  {$EXTERNALSYM DIDEVICEINSTANCEW}
  DIDEVICEINSTANCE = DIDEVICEINSTANCEA;
  {$EXTERNALSYM DIDEVICEINSTANCE}
  TDIDeviceInstanceA = DIDEVICEINSTANCEA;
  TDIDeviceInstanceW = DIDEVICEINSTANCEW;
  TDIDeviceInstance = TDIDeviceInstanceA;


type
  {$EXTERNALSYM IDirectInputDeviceA}
  IDirectInputDeviceA = interface(IUnknown)
    [SID_IDirectInputDeviceA]
    (*** IDirectInputDeviceA methods ***)
    function GetCapabilities(var lpDIDevCaps: TDIDevCaps): HResult; stdcall;
    function EnumObjects(lpCallback: TDIEnumDeviceObjectsCallbackA; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
    function GetProperty(rguidProp: PGUID; var pdiph: TDIPropHeader): HResult; stdcall;
    function SetProperty(rguidProp: PGUID; const pdiph: TDIPropHeader): HResult; stdcall;
    function Acquire: HResult; stdcall;
    function Unacquire: HResult; stdcall;
    function GetDeviceState(cbData: DWORD; lpvData: Pointer): HResult; stdcall;
    function GetDeviceData(cbObjectData: DWORD; rgdod: PDIDeviceObjectData; out pdwInOut: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetDataFormat(const lpdf: TDIDataFormat): HResult; stdcall;
    function SetEventNotification(hEvent: THandle): HResult; stdcall;
    function SetCooperativeLevel(hwnd: HWND; dwFlags: DWORD): HResult; stdcall;
    function GetObjectInfo(var pdidoi: TDIDeviceObjectInstanceA; dwObj, dwHow: DWORD): HResult; stdcall;
    function GetDeviceInfo(var pdidi: TDIDeviceInstanceA): HResult; stdcall;
    function RunControlPanel(hwndOwner: HWND; dwFlags: DWORD): HResult; stdcall;
    function Initialize(hinst: THandle; dwVersion: DWORD; const rguid: TGUID): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInputDeviceW}
  IDirectInputDeviceW = interface(IUnknown)
    [SID_IDirectInputDeviceW]
    (*** IDirectInputDeviceW methods ***)
    function GetCapabilities(var lpDIDevCaps: TDIDevCaps): HResult; stdcall;
    function EnumObjects(lpCallback: TDIEnumDeviceObjectsCallbackW; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
    function GetProperty(rguidProp: PGUID; var pdiph: TDIPropHeader): HResult; stdcall;
    function SetProperty(rguidProp: PGUID; const pdiph: TDIPropHeader): HResult; stdcall;
    function Acquire: HResult; stdcall;
    function Unacquire: HResult; stdcall;
    function GetDeviceState(cbData: DWORD; lpvData: Pointer): HResult; stdcall;
    function GetDeviceData(cbObjectData: DWORD; rgdod: PDIDeviceObjectData; out pdwInOut: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetDataFormat(const lpdf: TDIDataFormat): HResult; stdcall;
    function SetEventNotification(hEvent: THandle): HResult; stdcall;
    function SetCooperativeLevel(hwnd: HWND; dwFlags: DWORD): HResult; stdcall;
    function GetObjectInfo(var pdidoi: TDIDeviceObjectInstanceW; dwObj, dwHow: DWORD): HResult; stdcall;
    function GetDeviceInfo(var pdidi: TDIDeviceInstanceW): HResult; stdcall;
    function RunControlPanel(hwndOwner: HWND; dwFlags: DWORD): HResult; stdcall;
    function Initialize(hinst: THandle; dwVersion: DWORD; const rguid: TGUID): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInputDevice}
  IDirectInputDevice = IDirectInputDeviceA;
type
  IID_IDirectInputDevice = IDirectInputDevice;
  {$EXTERNALSYM IID_IDirectInputDevice}

 (* #if(DIRECTINPUT_VERSION >= 0x0500) *)

const
  DISFFC_RESET            = $00000001;
  {$EXTERNALSYM DISFFC_RESET}
  DISFFC_STOPALL          = $00000002;
  {$EXTERNALSYM DISFFC_STOPALL}
  DISFFC_PAUSE            = $00000004;
  {$EXTERNALSYM DISFFC_PAUSE}
  DISFFC_CONTINUE         = $00000008;
  {$EXTERNALSYM DISFFC_CONTINUE}
  DISFFC_SETACTUATORSON   = $00000010;
  {$EXTERNALSYM DISFFC_SETACTUATORSON}
  DISFFC_SETACTUATORSOFF  = $00000020;
  {$EXTERNALSYM DISFFC_SETACTUATORSOFF}

  DIGFFS_EMPTY            = $00000001;
  {$EXTERNALSYM DIGFFS_EMPTY}
  DIGFFS_STOPPED          = $00000002;
  {$EXTERNALSYM DIGFFS_STOPPED}
  DIGFFS_PAUSED           = $00000004;
  {$EXTERNALSYM DIGFFS_PAUSED}
  DIGFFS_ACTUATORSON      = $00000010;
  {$EXTERNALSYM DIGFFS_ACTUATORSON}
  DIGFFS_ACTUATORSOFF     = $00000020;
  {$EXTERNALSYM DIGFFS_ACTUATORSOFF}
  DIGFFS_POWERON          = $00000040;
  {$EXTERNALSYM DIGFFS_POWERON}
  DIGFFS_POWEROFF         = $00000080;
  {$EXTERNALSYM DIGFFS_POWEROFF}
  DIGFFS_SAFETYSWITCHON   = $00000100;
  {$EXTERNALSYM DIGFFS_SAFETYSWITCHON}
  DIGFFS_SAFETYSWITCHOFF  = $00000200;
  {$EXTERNALSYM DIGFFS_SAFETYSWITCHOFF}
  DIGFFS_USERFFSWITCHON   = $00000400;
  {$EXTERNALSYM DIGFFS_USERFFSWITCHON}
  DIGFFS_USERFFSWITCHOFF  = $00000800;
  {$EXTERNALSYM DIGFFS_USERFFSWITCHOFF}
  DIGFFS_DEVICELOST       = $80000000;
  {$EXTERNALSYM DIGFFS_DEVICELOST}

type
  PDIEffectInfoA = ^TDIEffectInfoA;
  PDIEffectInfoW = ^TDIEffectInfoW;
  PDIEffectInfo = PDIEffectInfoA;
  DIEFFECTINFOA = packed record
    dwSize: DWORD;
    guid: TGUID;
    dwEffType: DWORD;
    dwStaticParams: DWORD;
    dwDynamicParams: DWORD;
    tszName: array[0..MAX_PATH-1] of AnsiChar;
  end;
  {$EXTERNALSYM DIEFFECTINFOA}
  DIEFFECTINFOW = packed record
    dwSize: DWORD;
    guid: TGUID;
    dwEffType: DWORD;
    dwStaticParams: DWORD;
    dwDynamicParams: DWORD;
    tszName: array[0..MAX_PATH-1] of WideChar;
  end;
  {$EXTERNALSYM DIEFFECTINFOW}
  DIEFFECTINFO = DIEFFECTINFOA;
  {$EXTERNALSYM DIEFFECTINFO}
  TDIEffectInfoA = DIEFFECTINFOA;
  TDIEffectInfoW = DIEFFECTINFOW;
  TDIEffectInfo = TDIEffectInfoA;

const
  DISDD_CONTINUE          = $00000001;
  {$EXTERNALSYM DISDD_CONTINUE}

type
  TDIEnumEffectsCallbackA = function (var pdei: TDIEffectInfoA; pvRef: Pointer): BOOL; stdcall;
  {$NODEFINE TDIEnumEffectsCallbackA}
  (*$HPPEMIT 'typedef LPDIENUMEFFECTSCALLBACKA TDIEnumEffectsCallbackA;'*)
  TDIEnumEffectsCallbackW = function (var pdei: TDIEffectInfoW; pvRef: Pointer): BOOL; stdcall;
  {$NODEFINE TDIEnumEffectsCallbackW}
  (*$HPPEMIT 'typedef LPDIENUMEFFECTSCALLBACKW TDIEnumEffectsCallbackW;'*)
  TDIEnumEffectsCallback = TDIEnumEffectsCallbackA;
  {$NODEFINE TDIEnumEffectsCallback}
  {$HPPEMIT 'typedef LPDIENUMEFFECTSINFILECALLBACK TDIEnumEffectsInFileCallback;'}
  TDIEnumCreatedEffectObjectsCallback = function (peff : IDirectInputEffect; pvRev: Pointer): BOOL; stdcall;
  {$NODEFINE TDIEnumCreatedEffectObjectsCallback}
  {$HPPEMIT 'typedef LPDIENUMCREATEDEFFECTOBJECTSCALLBACK TDIEnumCreatedEffectObjectsCallback;'}

  {$EXTERNALSYM IDirectInputDevice2A}
  IDirectInputDevice2A = interface(IDirectInputDeviceA)
    [SID_IDirectInputDevice2A]
    (*** IDirectInputDevice2A methods ***)
    function CreateEffect(const rguid: TGUID; lpeff: PDIEffect; out ppdeff: IDirectInputEffect; punkOuter: IUnknown): HResult; stdcall;
    function EnumEffects(lpCallback: TDIEnumEffectsCallbackA; pvRef: Pointer; dwEffType: DWORD): HResult; stdcall;
    function GetEffectInfo(var pdei: TDIEffectInfoA; const rguid: TGUID): HResult; stdcall;
    function GetForceFeedbackState(out pdwOut: DWORD): HResult; stdcall;
    function SendForceFeedbackCommand(dwFlags: DWORD): HResult; stdcall;
    function EnumCreatedEffectObjects(lpCallback: TDIEnumCreatedEffectObjectsCallback; pvRef: Pointer; fl: DWORD): HResult; stdcall;
    function Escape(var pesc: TDIEffEscape): HResult; stdcall;
    function Poll: HResult; stdcall;
    function SendDeviceData(cbObjectData: DWORD; rgdod: PDIDeviceObjectData; var pdwInOut: DWORD; fl: DWORD): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInputDevice2W}
  IDirectInputDevice2W = interface(IDirectInputDeviceW)
    [SID_IDirectInputDevice2W]
    (*** IDirectInputDevice2W methods ***)
    function CreateEffect(const rguid: TGUID; lpeff: PDIEffect; out ppdeff: IDirectInputEffect; punkOuter: IUnknown): HResult; stdcall;
    function EnumEffects(lpCallback: TDIEnumEffectsCallbackW; pvRef: Pointer; dwEffType: DWORD): HResult; stdcall;
    function GetEffectInfo(var pdei: TDIEffectInfoW; const rguid: TGUID): HResult; stdcall;
    function GetForceFeedbackState(out pdwOut: DWORD): HResult; stdcall;
    function SendForceFeedbackCommand(dwFlags: DWORD): HResult; stdcall;
    function EnumCreatedEffectObjects(lpCallback: TDIEnumCreatedEffectObjectsCallback; pvRef: Pointer; fl: DWORD): HResult; stdcall;
    function Escape(var pesc: TDIEffEscape): HResult; stdcall;
    function Poll: HResult; stdcall;
    function SendDeviceData(cbObjectData: DWORD; rgdod: PDIDeviceObjectData; var pdwInOut: DWORD; fl: DWORD): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInputDevice2}
  IDirectInputDevice2 = IDirectInputDevice2A;
type
  IID_IDirectInputDevice2 = IDirectInputDevice2;
  {$EXTERNALSYM IID_IDirectInputDevice2}

 (* DIRECTINPUT_VERSION >= 0x0500 *)

 (* #if(DIRECTINPUT_VERSION >= 0x0700) *)
const
  DIFEF_DEFAULT               = $00000000;
  {$EXTERNALSYM DIFEF_DEFAULT}
  DIFEF_INCLUDENONSTANDARD    = $00000001;
  {$EXTERNALSYM DIFEF_INCLUDENONSTANDARD}
  DIFEF_MODIFYIFNEEDED        = $00000010;
  {$EXTERNALSYM DIFEF_MODIFYIFNEEDED}

type
  {$EXTERNALSYM IDirectInputDevice7A}
  IDirectInputDevice7A = interface(IDirectInputDevice2A)
    [SID_IDirectInputDevice7A]
    (*** IDirectInputDevice7A methods ***)
    function EnumEffectsInFile(lpszFileName: PAnsiChar; pec: TDIEnumEffectsInFileCallback; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
    function WriteEffectToFile(lpszFileName: PAnsiChar; dwEntries: DWORD; rgDiFileEft: PDIFileEffect; dwFlags: DWORD): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInputDevice7W}
  IDirectInputDevice7W = interface(IDirectInputDevice2W)
    [SID_IDirectInputDevice7W]
    (*** IDirectInputDevice7W methods ***)
    function EnumEffectsInFile(lpszFileName: PWideChar; pec: TDIEnumEffectsInFileCallback; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
    function WriteEffectToFile(lpszFileName: PWideChar; dwEntries: DWORD; rgDiFileEft: PDIFileEffect; dwFlags: DWORD): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInputDevice7}
  IDirectInputDevice7 = IDirectInputDevice7A;
type
  IID_IDirectInputDevice7 = IDirectInputDevice7;
  {$EXTERNALSYM IID_IDirectInputDevice7}

 (* DIRECTINPUT_VERSION >= 0x0700 *)

 (* #if(DIRECTINPUT_VERSION >= 0x0800) *)
type
  {$EXTERNALSYM IDirectInputDevice8A}
  IDirectInputDevice8A = interface(IDirectInputDevice7A)
    [SID_IDirectInputDevice8A]
    (*** IDirectInputDevice8A methods ***)
    function BuildActionMap(out lpdiaf: TDIActionFormatA; lpszUserName: PAnsiChar; dwFlags: DWORD): HResult; stdcall;
    function SetActionMap(var lpdiActionFormat: TDIActionFormatA; lptszUserName: PAnsiChar; dwFlags: DWORD): HResult; stdcall;
    function GetImageInfo(var lpdiDevImageInfoHeader: TDIDeviceImageInfoHeaderA): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInputDevice8W}
  IDirectInputDevice8W = interface(IDirectInputDevice7W)
    [SID_IDirectInputDevice8W]
    (*** IDirectInputDevice8W methods ***)
    function BuildActionMap(out lpdiaf: TDIActionFormatW; lpszUserName: PWideChar; dwFlags: DWORD): HResult; stdcall;
    function SetActionMap(var lpdiActionFormat: TDIActionFormatW; lptszUserName: PWideChar; dwFlags: DWORD): HResult; stdcall;
    function GetImageInfo(var lpdiDevImageInfoHeader: TDIDeviceImageInfoHeaderW): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInputDevice8}
  IDirectInputDevice8 = IDirectInputDevice8A;
type
  IID_IDirectInputDevice8 = IDirectInputDevice8;
  {$EXTERNALSYM IID_IDirectInputDevice8}

 (* DIRECTINPUT_VERSION >= 0x0800 *)

(****************************************************************************
 *
 *      Mouse
 *
 ****************************************************************************)

type
  PDIMouseState = ^TDIMouseState;
  _DIMOUSESTATE = packed record
    lX: Longint;
    lY: Longint;
    lZ: Longint;
    rgbButtons: array[0..3] of Byte;
  end;
  {$EXTERNALSYM _DIMOUSESTATE}
  DIMOUSESTATE = _DIMOUSESTATE;
  {$EXTERNALSYM DIMOUSESTATE}
  TDIMouseState = _DIMOUSESTATE;

 (* #if(DIRECTINPUT_VERSION >= 0x0700) *)
  PDIMouseState2 = ^TDIMouseState2;
  _DIMOUSESTATE2 = packed record
    lX: Longint;
    lY: Longint;
    lZ: Longint;
    rgbButtons: array[0..7] of Byte;
  end;
  {$EXTERNALSYM _DIMOUSESTATE2}
  DIMOUSESTATE2 = _DIMOUSESTATE2;
  {$EXTERNALSYM DIMOUSESTATE2}
  TDIMouseState2 = _DIMOUSESTATE2;

 (* DIRECTINPUT_VERSION >= 0x0700 *)

const
  DIMOFS_X        = 0; // FIELD_OFFSET(DIMOUSESTATE, lX)
  {$EXTERNALSYM DIMOFS_X}
  DIMOFS_Y        = 4; // FIELD_OFFSET(DIMOUSESTATE, lY)
  {$EXTERNALSYM DIMOFS_Y}
  DIMOFS_Z        = 8; // FIELD_OFFSET(DIMOUSESTATE, lZ)
  {$EXTERNALSYM DIMOFS_Z}
  DIMOFS_BUTTON0  = 12;                 // (FIELD_OFFSET(DIMOUSESTATE, rgbButtons) + 0)
  {$EXTERNALSYM DIMOFS_BUTTON0}
  DIMOFS_BUTTON1  = DIMOFS_BUTTON0 + 1; // (FIELD_OFFSET(DIMOUSESTATE, rgbButtons) + 1)
  {$EXTERNALSYM DIMOFS_BUTTON1}
  DIMOFS_BUTTON2  = DIMOFS_BUTTON0 + 2; // (FIELD_OFFSET(DIMOUSESTATE, rgbButtons) + 2)
  {$EXTERNALSYM DIMOFS_BUTTON2}
  DIMOFS_BUTTON3  = DIMOFS_BUTTON0 + 3; // (FIELD_OFFSET(DIMOUSESTATE, rgbButtons) + 3)
  {$EXTERNALSYM DIMOFS_BUTTON3}
 (* #if(DIRECTINPUT_VERSION >= 0x0700) *)
  DIMOFS_BUTTON4  = DIMOFS_BUTTON0 + 4; // (FIELD_OFFSET(DIMOUSESTATE2, rgbButtons) + 4)
  {$EXTERNALSYM DIMOFS_BUTTON4}
  DIMOFS_BUTTON5  = DIMOFS_BUTTON0 + 5; // (FIELD_OFFSET(DIMOUSESTATE2, rgbButtons) + 5)
  {$EXTERNALSYM DIMOFS_BUTTON5}
  DIMOFS_BUTTON6  = DIMOFS_BUTTON0 + 6; // (FIELD_OFFSET(DIMOUSESTATE2, rgbButtons) + 6)
  {$EXTERNALSYM DIMOFS_BUTTON6}
  DIMOFS_BUTTON7  = DIMOFS_BUTTON0 + 7; // (FIELD_OFFSET(DIMOUSESTATE2, rgbButtons) + 7)
  {$EXTERNALSYM DIMOFS_BUTTON7}
 (* DIRECTINPUT_VERSION >= 0x0700 *)

(****************************************************************************
 *
 *      Keyboard
 *
 ****************************************************************************)

(****************************************************************************
 *
 *      DirectInput keyboard scan codes
 *
 ****************************************************************************)
const
  DIK_ESCAPE          = $01;
  {$EXTERNALSYM DIK_ESCAPE}
  DIK_1               = $02;
  {$EXTERNALSYM DIK_1}
  DIK_2               = $03;
  {$EXTERNALSYM DIK_2}
  DIK_3               = $04;
  {$EXTERNALSYM DIK_3}
  DIK_4               = $05;
  {$EXTERNALSYM DIK_4}
  DIK_5               = $06;
  {$EXTERNALSYM DIK_5}
  DIK_6               = $07;
  {$EXTERNALSYM DIK_6}
  DIK_7               = $08;
  {$EXTERNALSYM DIK_7}
  DIK_8               = $09;
  {$EXTERNALSYM DIK_8}
  DIK_9               = $0A;
  {$EXTERNALSYM DIK_9}
  DIK_0               = $0B;
  {$EXTERNALSYM DIK_0}
  DIK_MINUS           = $0C;    (* - on main keyboard *)
  {$EXTERNALSYM DIK_MINUS}
  DIK_EQUALS          = $0D;
  {$EXTERNALSYM DIK_EQUALS}
  DIK_BACK            = $0E;    (* backspace *)
  {$EXTERNALSYM DIK_BACK}
  DIK_TAB             = $0F;
  {$EXTERNALSYM DIK_TAB}
  DIK_Q               = $10;
  {$EXTERNALSYM DIK_Q}
  DIK_W               = $11;
  {$EXTERNALSYM DIK_W}
  DIK_E               = $12;
  {$EXTERNALSYM DIK_E}
  DIK_R               = $13;
  {$EXTERNALSYM DIK_R}
  DIK_T               = $14;
  {$EXTERNALSYM DIK_T}
  DIK_Y               = $15;
  {$EXTERNALSYM DIK_Y}
  DIK_U               = $16;
  {$EXTERNALSYM DIK_U}
  DIK_I               = $17;
  {$EXTERNALSYM DIK_I}
  DIK_O               = $18;
  {$EXTERNALSYM DIK_O}
  DIK_P               = $19;
  {$EXTERNALSYM DIK_P}
  DIK_LBRACKET        = $1A;
  {$EXTERNALSYM DIK_LBRACKET}
  DIK_RBRACKET        = $1B;
  {$EXTERNALSYM DIK_RBRACKET}
  DIK_RETURN          = $1C;    (* Enter on main keyboard *)
  {$EXTERNALSYM DIK_RETURN}
  DIK_LCONTROL        = $1D;
  {$EXTERNALSYM DIK_LCONTROL}
  DIK_A               = $1E;
  {$EXTERNALSYM DIK_A}
  DIK_S               = $1F;
  {$EXTERNALSYM DIK_S}
  DIK_D               = $20;
  {$EXTERNALSYM DIK_D}
  DIK_F               = $21;
  {$EXTERNALSYM DIK_F}
  DIK_G               = $22;
  {$EXTERNALSYM DIK_G}
  DIK_H               = $23;
  {$EXTERNALSYM DIK_H}
  DIK_J               = $24;
  {$EXTERNALSYM DIK_J}
  DIK_K               = $25;
  {$EXTERNALSYM DIK_K}
  DIK_L               = $26;
  {$EXTERNALSYM DIK_L}
  DIK_SEMICOLON       = $27;
  {$EXTERNALSYM DIK_SEMICOLON}
  DIK_APOSTROPHE      = $28;
  {$EXTERNALSYM DIK_APOSTROPHE}
  DIK_GRAVE           = $29;    (* accent grave *)
  {$EXTERNALSYM DIK_GRAVE}
  DIK_LSHIFT          = $2A;
  {$EXTERNALSYM DIK_LSHIFT}
  DIK_BACKSLASH       = $2B;
  {$EXTERNALSYM DIK_BACKSLASH}
  DIK_Z               = $2C;
  {$EXTERNALSYM DIK_Z}
  DIK_X               = $2D;
  {$EXTERNALSYM DIK_X}
  DIK_C               = $2E;
  {$EXTERNALSYM DIK_C}
  DIK_V               = $2F;
  {$EXTERNALSYM DIK_V}
  DIK_B               = $30;
  {$EXTERNALSYM DIK_B}
  DIK_N               = $31;
  {$EXTERNALSYM DIK_N}
  DIK_M               = $32;
  {$EXTERNALSYM DIK_M}
  DIK_COMMA           = $33;
  {$EXTERNALSYM DIK_COMMA}
  DIK_PERIOD          = $34;    (* . on main keyboard *)
  {$EXTERNALSYM DIK_PERIOD}
  DIK_SLASH           = $35;    (* / on main keyboard *)
  {$EXTERNALSYM DIK_SLASH}
  DIK_RSHIFT          = $36;
  {$EXTERNALSYM DIK_RSHIFT}
  DIK_MULTIPLY        = $37;    (* * on numeric keypad *)
  {$EXTERNALSYM DIK_MULTIPLY}
  DIK_LMENU           = $38;    (* left Alt *)
  {$EXTERNALSYM DIK_LMENU}
  DIK_SPACE           = $39;
  {$EXTERNALSYM DIK_SPACE}
  DIK_CAPITAL         = $3A;
  {$EXTERNALSYM DIK_CAPITAL}
  DIK_F1              = $3B;
  {$EXTERNALSYM DIK_F1}
  DIK_F2              = $3C;
  {$EXTERNALSYM DIK_F2}
  DIK_F3              = $3D;
  {$EXTERNALSYM DIK_F3}
  DIK_F4              = $3E;
  {$EXTERNALSYM DIK_F4}
  DIK_F5              = $3F;
  {$EXTERNALSYM DIK_F5}
  DIK_F6              = $40;
  {$EXTERNALSYM DIK_F6}
  DIK_F7              = $41;
  {$EXTERNALSYM DIK_F7}
  DIK_F8              = $42;
  {$EXTERNALSYM DIK_F8}
  DIK_F9              = $43;
  {$EXTERNALSYM DIK_F9}
  DIK_F10             = $44;
  {$EXTERNALSYM DIK_F10}
  DIK_NUMLOCK         = $45;
  {$EXTERNALSYM DIK_NUMLOCK}
  DIK_SCROLL          = $46;    (* Scroll Lock *)
  {$EXTERNALSYM DIK_SCROLL}
  DIK_NUMPAD7         = $47;
  {$EXTERNALSYM DIK_NUMPAD7}
  DIK_NUMPAD8         = $48;
  {$EXTERNALSYM DIK_NUMPAD8}
  DIK_NUMPAD9         = $49;
  {$EXTERNALSYM DIK_NUMPAD9}
  DIK_SUBTRACT        = $4A;    (* - on numeric keypad *)
  {$EXTERNALSYM DIK_SUBTRACT}
  DIK_NUMPAD4         = $4B;
  {$EXTERNALSYM DIK_NUMPAD4}
  DIK_NUMPAD5         = $4C;
  {$EXTERNALSYM DIK_NUMPAD5}
  DIK_NUMPAD6         = $4D;
  {$EXTERNALSYM DIK_NUMPAD6}
  DIK_ADD             = $4E;    (* + on numeric keypad *)
  {$EXTERNALSYM DIK_ADD}
  DIK_NUMPAD1         = $4F;
  {$EXTERNALSYM DIK_NUMPAD1}
  DIK_NUMPAD2         = $50;
  {$EXTERNALSYM DIK_NUMPAD2}
  DIK_NUMPAD3         = $51;
  {$EXTERNALSYM DIK_NUMPAD3}
  DIK_NUMPAD0         = $52;
  {$EXTERNALSYM DIK_NUMPAD0}
  DIK_DECIMAL         = $53;    (* . on numeric keypad *)
  {$EXTERNALSYM DIK_DECIMAL}
  DIK_OEM_102         = $56;    (* <> or \| on RT 102-key keyboard (Non-U.S.) *)
  {$EXTERNALSYM DIK_OEM_102}
  DIK_F11             = $57;
  {$EXTERNALSYM DIK_F11}
  DIK_F12             = $58;
  {$EXTERNALSYM DIK_F12}
  DIK_F13             = $64;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIK_F13}
  DIK_F14             = $65;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIK_F14}
  DIK_F15             = $66;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIK_F15}
  DIK_KANA            = $70;    (* (Japanese keyboard)            *)
  {$EXTERNALSYM DIK_KANA}
  DIK_ABNT_C1         = $73;    (* /? on Brazilian keyboard *)
  {$EXTERNALSYM DIK_ABNT_C1}
  DIK_CONVERT         = $79;    (* (Japanese keyboard)            *)
  {$EXTERNALSYM DIK_CONVERT}
  DIK_NOCONVERT       = $7B;    (* (Japanese keyboard)            *)
  {$EXTERNALSYM DIK_NOCONVERT}
  DIK_YEN             = $7D;    (* (Japanese keyboard)            *)
  {$EXTERNALSYM DIK_YEN}
  DIK_ABNT_C2         = $7E;    (* Numpad . on Brazilian keyboard *)
  {$EXTERNALSYM DIK_ABNT_C2}
  DIK_NUMPADEQUALS    = $8D;    (* = on numeric keypad (NEC PC98) *)
  {$EXTERNALSYM DIK_NUMPADEQUALS}
  DIK_PREVTRACK       = $90;    (* Previous Track (DIK_CIRCUMFLEX on Japanese keyboard) *)
  {$EXTERNALSYM DIK_PREVTRACK}
  DIK_AT              = $91;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIK_AT}
  DIK_COLON           = $92;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIK_COLON}
  DIK_UNDERLINE       = $93;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIK_UNDERLINE}
  DIK_KANJI           = $94;    (* (Japanese keyboard)            *)
  {$EXTERNALSYM DIK_KANJI}
  DIK_STOP            = $95;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIK_STOP}
  DIK_AX              = $96;    (*                     (Japan AX) *)
  {$EXTERNALSYM DIK_AX}
  DIK_UNLABELED       = $97;    (*                        (J3100) *)
  {$EXTERNALSYM DIK_UNLABELED}
  DIK_NEXTTRACK       = $99;    (* Next Track *)
  {$EXTERNALSYM DIK_NEXTTRACK}
  DIK_NUMPADENTER     = $9C;    (* Enter on numeric keypad *)
  {$EXTERNALSYM DIK_NUMPADENTER}
  DIK_RCONTROL        = $9D;
  {$EXTERNALSYM DIK_RCONTROL}
  DIK_MUTE            = $A0;    (* Mute *)
  {$EXTERNALSYM DIK_MUTE}
  DIK_CALCULATOR      = $A1;    (* Calculator *)
  {$EXTERNALSYM DIK_CALCULATOR}
  DIK_PLAYPAUSE       = $A2;    (* Play / Pause *)
  {$EXTERNALSYM DIK_PLAYPAUSE}
  DIK_MEDIASTOP       = $A4;    (* Media Stop *)
  {$EXTERNALSYM DIK_MEDIASTOP}
  DIK_VOLUMEDOWN      = $AE;    (* Volume - *)
  {$EXTERNALSYM DIK_VOLUMEDOWN}
  DIK_VOLUMEUP        = $B0;    (* Volume + *)
  {$EXTERNALSYM DIK_VOLUMEUP}
  DIK_WEBHOME         = $B2;    (* Web home *)
  {$EXTERNALSYM DIK_WEBHOME}
  DIK_NUMPADCOMMA     = $B3;    (* , on numeric keypad (NEC PC98) *)
  {$EXTERNALSYM DIK_NUMPADCOMMA}
  DIK_DIVIDE          = $B5;    (* / on numeric keypad *)
  {$EXTERNALSYM DIK_DIVIDE}
  DIK_SYSRQ           = $B7;
  {$EXTERNALSYM DIK_SYSRQ}
  DIK_RMENU           = $B8;    (* right Alt *)
  {$EXTERNALSYM DIK_RMENU}
  DIK_PAUSE           = $C5;    (* Pause *)
  {$EXTERNALSYM DIK_PAUSE}
  DIK_HOME            = $C7;    (* Home on arrow keypad *)
  {$EXTERNALSYM DIK_HOME}
  DIK_UP              = $C8;    (* UpArrow on arrow keypad *)
  {$EXTERNALSYM DIK_UP}
  DIK_PRIOR           = $C9;    (* PgUp on arrow keypad *)
  {$EXTERNALSYM DIK_PRIOR}
  DIK_LEFT            = $CB;    (* LeftArrow on arrow keypad *)
  {$EXTERNALSYM DIK_LEFT}
  DIK_RIGHT           = $CD;    (* RightArrow on arrow keypad *)
  {$EXTERNALSYM DIK_RIGHT}
  DIK_END             = $CF;    (* End on arrow keypad *)
  {$EXTERNALSYM DIK_END}
  DIK_DOWN            = $D0;    (* DownArrow on arrow keypad *)
  {$EXTERNALSYM DIK_DOWN}
  DIK_NEXT            = $D1;    (* PgDn on arrow keypad *)
  {$EXTERNALSYM DIK_NEXT}
  DIK_INSERT          = $D2;    (* Insert on arrow keypad *)
  {$EXTERNALSYM DIK_INSERT}
  DIK_DELETE          = $D3;    (* Delete on arrow keypad *)
  {$EXTERNALSYM DIK_DELETE}
  DIK_LWIN            = $DB;    (* Left Windows key *)
  {$EXTERNALSYM DIK_LWIN}
  DIK_RWIN            = $DC;    (* Right Windows key *)
  {$EXTERNALSYM DIK_RWIN}
  DIK_APPS            = $DD;    (* AppMenu key *)
  {$EXTERNALSYM DIK_APPS}
  DIK_POWER           = $DE;    (* System Power *)
  {$EXTERNALSYM DIK_POWER}
  DIK_SLEEP           = $DF;    (* System Sleep *)
  {$EXTERNALSYM DIK_SLEEP}
  DIK_WAKE            = $E3;    (* System Wake *)
  {$EXTERNALSYM DIK_WAKE}
  DIK_WEBSEARCH       = $E5;    (* Web Search *)
  {$EXTERNALSYM DIK_WEBSEARCH}
  DIK_WEBFAVORITES    = $E6;    (* Web Favorites *)
  {$EXTERNALSYM DIK_WEBFAVORITES}
  DIK_WEBREFRESH      = $E7;    (* Web Refresh *)
  {$EXTERNALSYM DIK_WEBREFRESH}
  DIK_WEBSTOP         = $E8;    (* Web Stop *)
  {$EXTERNALSYM DIK_WEBSTOP}
  DIK_WEBFORWARD      = $E9;    (* Web Forward *)
  {$EXTERNALSYM DIK_WEBFORWARD}
  DIK_WEBBACK         = $EA;    (* Web Back *)
  {$EXTERNALSYM DIK_WEBBACK}
  DIK_MYCOMPUTER      = $EB;    (* My Computer *)
  {$EXTERNALSYM DIK_MYCOMPUTER}
  DIK_MAIL            = $EC;    (* Mail *)
  {$EXTERNALSYM DIK_MAIL}
  DIK_MEDIASELECT     = $ED;    (* Media Select *)
  {$EXTERNALSYM DIK_MEDIASELECT}

(*
 *  Alternate names for keys, to facilitate transition from DOS.
 *)
  DIK_BACKSPACE       = DIK_BACK;            (* backspace *)
  {$EXTERNALSYM DIK_BACKSPACE}
  DIK_NUMPADSTAR      = DIK_MULTIPLY;        (* * on numeric keypad *)
  {$EXTERNALSYM DIK_NUMPADSTAR}
  DIK_LALT            = DIK_LMENU;           (* left Alt *)
  {$EXTERNALSYM DIK_LALT}
  DIK_CAPSLOCK        = DIK_CAPITAL;         (* CapsLock *)
  {$EXTERNALSYM DIK_CAPSLOCK}
  DIK_NUMPADMINUS     = DIK_SUBTRACT;        (* - on numeric keypad *)
  {$EXTERNALSYM DIK_NUMPADMINUS}
  DIK_NUMPADPLUS      = DIK_ADD;             (* + on numeric keypad *)
  {$EXTERNALSYM DIK_NUMPADPLUS}
  DIK_NUMPADPERIOD    = DIK_DECIMAL;         (* . on numeric keypad *)
  {$EXTERNALSYM DIK_NUMPADPERIOD}
  DIK_NUMPADSLASH     = DIK_DIVIDE;          (* / on numeric keypad *)
  {$EXTERNALSYM DIK_NUMPADSLASH}
  DIK_RALT            = DIK_RMENU;           (* right Alt *)
  {$EXTERNALSYM DIK_RALT}
  DIK_UPARROW         = DIK_UP;              (* UpArrow on arrow keypad *)
  {$EXTERNALSYM DIK_UPARROW}
  DIK_PGUP            = DIK_PRIOR;           (* PgUp on arrow keypad *)
  {$EXTERNALSYM DIK_PGUP}
  DIK_LEFTARROW       = DIK_LEFT;            (* LeftArrow on arrow keypad *)
  {$EXTERNALSYM DIK_LEFTARROW}
  DIK_RIGHTARROW      = DIK_RIGHT;           (* RightArrow on arrow keypad *)
  {$EXTERNALSYM DIK_RIGHTARROW}
  DIK_DOWNARROW       = DIK_DOWN;            (* DownArrow on arrow keypad *)
  {$EXTERNALSYM DIK_DOWNARROW}
  DIK_PGDN            = DIK_NEXT;            (* PgDn on arrow keypad *)
  {$EXTERNALSYM DIK_PGDN}

(*
 *  Alternate names for keys originally not used on US keyboards.
 *)
  DIK_CIRCUMFLEX      = DIK_PREVTRACK;       (* Japanese keyboard *)
  {$EXTERNALSYM DIK_CIRCUMFLEX}

(****************************************************************************
 *
 *      Joystick
 *
 ****************************************************************************)

type
  PDIJoyState = ^TDIJoyState;
  DIJOYSTATE = packed record
    lX: Longint;                        (* x-axis position              *)
    lY: Longint;                        (* y-axis position              *)
    lZ: Longint;                        (* z-axis position              *)
    lRx: Longint;                       (* x-axis rotation              *)
    lRy: Longint;                       (* y-axis rotation              *)
    lRz: Longint;                       (* z-axis rotation              *)
    rglSlider: array[0..1] of Longint;  (* extra axes positions         *)
    rgdwPOV: array[0..3] of DWORD;      (* POV directions               *)
    rgbButtons: array[0..31] of Byte;   (* 32 buttons                   *)
  end;
  {$EXTERNALSYM DIJOYSTATE}
  TDIJoyState = DIJOYSTATE;

  PDIJoyState2 = ^TDIJoyState2;
  DIJOYSTATE2 = packed record
    lX: Longint;                        (* x-axis position              *)
    lY: Longint;                        (* y-axis position              *)
    lZ: Longint;                        (* z-axis position              *)
    lRx: Longint;                       (* x-axis rotation              *)
    lRy: Longint;                       (* y-axis rotation              *)
    lRz: Longint;                       (* z-axis rotation              *)
    rglSlider: array[0..1] of Longint;  (* extra axes positions         *)
    rgdwPOV: array[0..3] of DWORD;      (* POV directions               *)
    rgbButtons: array[0..127] of Byte;  (* 128 buttons                  *)
    lVX: Longint;                       (* x-axis velocity              *)
    lVY: Longint;                       (* y-axis velocity              *)
    lVZ: Longint;                       (* z-axis velocity              *)
    lVRx: Longint;                      (* x-axis angular velocity      *)
    lVRy: Longint;                      (* y-axis angular velocity      *)
    lVRz: Longint;                      (* z-axis angular velocity      *)
    rglVSlider: array[0..1] of Longint; (* extra axes velocities        *)
    lAX: Longint;                       (* x-axis acceleration          *)
    lAY: Longint;                       (* y-axis acceleration          *)
    lAZ: Longint;                       (* z-axis acceleration          *)
    lARx: Longint;                      (* x-axis angular acceleration  *)
    lARy: Longint;                      (* y-axis angular acceleration  *)
    lARz: Longint;                      (* z-axis angular acceleration  *)
    rglASlider: array[0..1] of Longint; (* extra axes accelerations     *)
    lFX: Longint;                       (* x-axis force                 *)
    lFY: Longint;                       (* y-axis force                 *)
    lFZ: Longint;                       (* z-axis force                 *)
    lFRx: Longint;                      (* x-axis torque                *)
    lFRy: Longint;                      (* y-axis torque                *)
    lFRz: Longint;                      (* z-axis torque                *)
    rglFSlider: array[0..1] of Longint; (* extra axes forces            *)
  end;
  {$EXTERNALSYM DIJOYSTATE2}
  TDIJoyState2 = DIJOYSTATE2;

const
  DIJOFS_X            = 0;  // FIELD_OFFSET(DIJOYSTATE, lX)
  {$EXTERNALSYM DIJOFS_X}
  DIJOFS_Y            = 4;  // FIELD_OFFSET(DIJOYSTATE, lY)
  {$EXTERNALSYM DIJOFS_Y}
  DIJOFS_Z            = 8;  // FIELD_OFFSET(DIJOYSTATE, lZ)
  {$EXTERNALSYM DIJOFS_Z}
  DIJOFS_RX           = 12; // FIELD_OFFSET(DIJOYSTATE, lRx)
  {$EXTERNALSYM DIJOFS_RX}
  DIJOFS_RY           = 16; // FIELD_OFFSET(DIJOYSTATE, lRy)
  {$EXTERNALSYM DIJOFS_RY}
  DIJOFS_RZ           = 20; // FIELD_OFFSET(DIJOYSTATE, lRz)
  {$EXTERNALSYM DIJOFS_RZ}

//  #define DIJOFS_SLIDER(n)   (FIELD_OFFSET(DIJOYSTATE, rglSlider) + \
//                              (n) * sizeof(LONG))
function DIJOFS_SLIDER(n: Cardinal): Cardinal;
{$EXTERNALSYM DIJOFS_SLIDER}

// #define DIJOFS_POV(n)      (FIELD_OFFSET(DIJOYSTATE, rgdwPOV) + \
//                              (n) * sizeof(DWORD))
function DIJOFS_POV(n: Cardinal): Cardinal;
{$EXTERNALSYM DIJOFS_POV}

// #define DIJOFS_BUTTON(n)   (FIELD_OFFSET(DIJOYSTATE, rgbButtons) + (n))
function DIJOFS_BUTTON(n: Cardinal): Cardinal;
{$EXTERNALSYM DIJOFS_BUTTON}

const
  DIJOFS_BUTTON_      = 48; // Helper const

  DIJOFS_BUTTON0      = DIJOFS_BUTTON_ +  0; // DIJOFS_BUTTON(0)
  {$EXTERNALSYM DIJOFS_BUTTON0}
  DIJOFS_BUTTON1      = DIJOFS_BUTTON_ +  1; // DIJOFS_BUTTON(1)
  {$EXTERNALSYM DIJOFS_BUTTON1}
  DIJOFS_BUTTON2      = DIJOFS_BUTTON_ +  2; // DIJOFS_BUTTON(2)
  {$EXTERNALSYM DIJOFS_BUTTON2}
  DIJOFS_BUTTON3      = DIJOFS_BUTTON_ +  3; // DIJOFS_BUTTON(3)
  {$EXTERNALSYM DIJOFS_BUTTON3}
  DIJOFS_BUTTON4      = DIJOFS_BUTTON_ +  4; // DIJOFS_BUTTON(4)
  {$EXTERNALSYM DIJOFS_BUTTON4}
  DIJOFS_BUTTON5      = DIJOFS_BUTTON_ +  5; // DIJOFS_BUTTON(5)
  {$EXTERNALSYM DIJOFS_BUTTON5}
  DIJOFS_BUTTON6      = DIJOFS_BUTTON_ +  6; // DIJOFS_BUTTON(6)
  {$EXTERNALSYM DIJOFS_BUTTON6}
  DIJOFS_BUTTON7      = DIJOFS_BUTTON_ +  7; // DIJOFS_BUTTON(7)
  {$EXTERNALSYM DIJOFS_BUTTON7}
  DIJOFS_BUTTON8      = DIJOFS_BUTTON_ +  8; // DIJOFS_BUTTON(8)
  {$EXTERNALSYM DIJOFS_BUTTON8}
  DIJOFS_BUTTON9      = DIJOFS_BUTTON_ +  9; // DIJOFS_BUTTON(9)
  {$EXTERNALSYM DIJOFS_BUTTON9}
  DIJOFS_BUTTON10     = DIJOFS_BUTTON_ + 10; // DIJOFS_BUTTON(10)
  {$EXTERNALSYM DIJOFS_BUTTON10}
  DIJOFS_BUTTON11     = DIJOFS_BUTTON_ + 11; // DIJOFS_BUTTON(11)
  {$EXTERNALSYM DIJOFS_BUTTON11}
  DIJOFS_BUTTON12     = DIJOFS_BUTTON_ + 12; // DIJOFS_BUTTON(12)
  {$EXTERNALSYM DIJOFS_BUTTON12}
  DIJOFS_BUTTON13     = DIJOFS_BUTTON_ + 13; // DIJOFS_BUTTON(13)
  {$EXTERNALSYM DIJOFS_BUTTON13}
  DIJOFS_BUTTON14     = DIJOFS_BUTTON_ + 14; // DIJOFS_BUTTON(14)
  {$EXTERNALSYM DIJOFS_BUTTON14}
  DIJOFS_BUTTON15     = DIJOFS_BUTTON_ + 15; // DIJOFS_BUTTON(15)
  {$EXTERNALSYM DIJOFS_BUTTON15}
  DIJOFS_BUTTON16     = DIJOFS_BUTTON_ + 16; // DIJOFS_BUTTON(16)
  {$EXTERNALSYM DIJOFS_BUTTON16}
  DIJOFS_BUTTON17     = DIJOFS_BUTTON_ + 17; // DIJOFS_BUTTON(17)
  {$EXTERNALSYM DIJOFS_BUTTON17}
  DIJOFS_BUTTON18     = DIJOFS_BUTTON_ + 18; // DIJOFS_BUTTON(18)
  {$EXTERNALSYM DIJOFS_BUTTON18}
  DIJOFS_BUTTON19     = DIJOFS_BUTTON_ + 19; // DIJOFS_BUTTON(19)
  {$EXTERNALSYM DIJOFS_BUTTON19}
  DIJOFS_BUTTON20     = DIJOFS_BUTTON_ + 20; // DIJOFS_BUTTON(20)
  {$EXTERNALSYM DIJOFS_BUTTON20}
  DIJOFS_BUTTON21     = DIJOFS_BUTTON_ + 21; // DIJOFS_BUTTON(21)
  {$EXTERNALSYM DIJOFS_BUTTON21}
  DIJOFS_BUTTON22     = DIJOFS_BUTTON_ + 22; // DIJOFS_BUTTON(22)
  {$EXTERNALSYM DIJOFS_BUTTON22}
  DIJOFS_BUTTON23     = DIJOFS_BUTTON_ + 23; // DIJOFS_BUTTON(23)
  {$EXTERNALSYM DIJOFS_BUTTON23}
  DIJOFS_BUTTON24     = DIJOFS_BUTTON_ + 24; // DIJOFS_BUTTON(24)
  {$EXTERNALSYM DIJOFS_BUTTON24}
  DIJOFS_BUTTON25     = DIJOFS_BUTTON_ + 25; // DIJOFS_BUTTON(25)
  {$EXTERNALSYM DIJOFS_BUTTON25}
  DIJOFS_BUTTON26     = DIJOFS_BUTTON_ + 26; // DIJOFS_BUTTON(26)
  {$EXTERNALSYM DIJOFS_BUTTON26}
  DIJOFS_BUTTON27     = DIJOFS_BUTTON_ + 27; // DIJOFS_BUTTON(27)
  {$EXTERNALSYM DIJOFS_BUTTON27}
  DIJOFS_BUTTON28     = DIJOFS_BUTTON_ + 28; // DIJOFS_BUTTON(28)
  {$EXTERNALSYM DIJOFS_BUTTON28}
  DIJOFS_BUTTON29     = DIJOFS_BUTTON_ + 29; // DIJOFS_BUTTON(29)
  {$EXTERNALSYM DIJOFS_BUTTON29}
  DIJOFS_BUTTON30     = DIJOFS_BUTTON_ + 30; // DIJOFS_BUTTON(30)
  {$EXTERNALSYM DIJOFS_BUTTON30}
  DIJOFS_BUTTON31     = DIJOFS_BUTTON_ + 31; // DIJOFS_BUTTON(31)
  {$EXTERNALSYM DIJOFS_BUTTON31}

const
  rgodfDIMouse: array[0..6] of TDIObjectDataFormat = (
    (pguid: @GUID_XAxis; dwOfs: DIMOFS_X; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE; dwFlags: 0),
    (pguid: @GUID_YAxis; dwOfs: DIMOFS_Y; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE; dwFlags: 0),
    (pguid: @GUID_ZAxis; dwOfs: DIMOFS_Z; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIMOFS_BUTTON0;   dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE; dwFlags: 0),
    (pguid: nil; dwOfs: DIMOFS_BUTTON1;   dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE; dwFlags: 0),
    (pguid: nil; dwOfs: DIMOFS_BUTTON2;   dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIMOFS_BUTTON3;   dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0)
  );
  {$EXTERNALSYM rgodfDIMouse}

  c_dfDIMouse: TDIDataFormat = (
    dwSize: Sizeof(c_dfDIMouse);              // $18
    dwObjSize: Sizeof(TDIObjectDataFormat);   // $10
    dwFlags: DIDF_RELAXIS;                    // $2
    dwDataSize: Sizeof(TDIMouseState);        // $10
    dwNumObjs: High(rgodfDIMouse) + 1;
    rgodf: @rgodfDIMouse
  );
  {$EXTERNALSYM c_dfDIMouse}


 (* #if(DIRECTINPUT_VERSION >= 0x0700) *)
  rgodfDIMouse2: array[0..10] of TDIObjectDataFormat = (
    (pguid: @GUID_XAxis; dwOfs: DIMOFS_X; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE; dwFlags: 0),
    (pguid: @GUID_YAxis; dwOfs: DIMOFS_Y; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE; dwFlags: 0),
    (pguid: @GUID_ZAxis; dwOfs: DIMOFS_Z; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0), // DIDFT_ENUMCOLLECTION(DIDFT_ALIAS) == $80000000
    (pguid: nil; dwOfs: DIMOFS_BUTTON0;   dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE; dwFlags: 0),
    (pguid: nil; dwOfs: DIMOFS_BUTTON1;   dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE; dwFlags: 0),
    (pguid: nil; dwOfs: DIMOFS_BUTTON2;   dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIMOFS_BUTTON3;   dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIMOFS_BUTTON4;   dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIMOFS_BUTTON5;   dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIMOFS_BUTTON6;   dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIMOFS_BUTTON7;   dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0)
  );
  {$EXTERNALSYM rgodfDIMouse2}

  c_dfDIMouse2: TDIDataFormat = (
    dwSize     : Sizeof(c_dfDIMouse2);              // $18
    dwObjSize  : Sizeof(TDIObjectDataFormat);   // $10
    dwFlags    : DIDF_RELAXIS;                    // $2
    dwDataSize : Sizeof(TDIMouseState2);        // $10
    dwNumObjs  : High(rgodfDIMouse2) + 1;
    rgodf      : @rgodfDIMouse2
  );
  {$EXTERNALSYM c_dfDIMouse2}
 (* DIRECTINPUT_VERSION >= 0x0700 *)


const
  rgodfKeyboard: array[0..255] of TDIObjectDataFormat = (
    (pguid: @GUID_Key; dwOfs:   0; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (  0 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:   1; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (  1 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:   2; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (  2 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:   3; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (  3 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:   4; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (  4 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:   5; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (  5 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:   6; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (  6 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:   7; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (  7 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:   8; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (  8 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:   9; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (  9 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  10; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 10 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  11; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 11 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  12; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 12 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  13; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 13 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  14; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 14 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  15; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 15 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  16; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 16 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  17; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 17 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  18; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 18 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  19; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 19 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  20; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 20 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  21; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 21 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  22; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 22 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  23; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 23 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  24; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 24 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  25; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 25 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  26; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 26 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  27; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 27 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  28; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 28 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  29; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 29 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  30; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 30 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  31; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 31 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  32; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 32 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  33; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 33 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  34; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 34 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  35; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 35 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  36; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 36 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  37; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 37 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  38; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 38 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  39; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 39 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  40; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 40 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  41; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 41 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  42; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 42 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  43; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 43 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  44; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 44 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  45; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 45 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  46; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 46 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  47; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 47 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  48; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 48 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  49; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 49 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  50; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 50 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  51; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 51 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  52; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 52 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  53; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 53 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  54; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 54 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  55; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 55 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  56; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 56 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  57; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 57 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  58; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 58 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  59; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 59 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  60; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 60 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  61; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 61 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  62; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 62 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  63; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 63 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  64; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 64 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  65; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 65 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  66; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 66 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  67; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 67 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  68; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 68 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  69; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 69 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  70; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 70 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  71; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 71 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  72; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 72 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  73; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 73 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  74; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 74 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  75; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 75 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  76; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 76 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  77; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 77 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  78; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 78 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  79; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 79 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  80; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 80 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  81; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 81 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  82; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 82 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  83; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 83 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  84; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 84 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  85; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 85 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  86; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 86 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  87; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 87 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  88; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 88 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  89; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 89 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  90; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 90 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  91; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 91 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  92; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 92 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  93; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 93 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  94; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 94 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  95; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 95 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  96; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 96 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  97; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 97 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  98; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 98 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs:  99; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or ( 99 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 100; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (100 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 101; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (101 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 102; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (102 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 103; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (103 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 104; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (104 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 105; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (105 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 106; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (106 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 107; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (107 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 108; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (108 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 109; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (109 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 110; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (110 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 111; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (111 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 112; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (112 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 113; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (113 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 114; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (114 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 115; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (115 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 116; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (116 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 117; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (117 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 118; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (118 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 119; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (119 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 120; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (120 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 121; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (121 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 122; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (122 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 123; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (123 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 124; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (124 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 125; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (125 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 126; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (126 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 127; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (127 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 128; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (128 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 129; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (129 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 130; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (130 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 131; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (131 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 132; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (132 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 133; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (133 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 134; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (134 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 135; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (135 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 136; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (136 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 137; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (137 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 138; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (138 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 139; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (139 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 140; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (140 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 141; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (141 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 142; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (142 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 143; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (143 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 144; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (144 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 145; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (145 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 146; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (146 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 147; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (147 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 148; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (148 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 149; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (149 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 150; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (150 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 151; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (151 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 152; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (152 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 153; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (153 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 154; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (154 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 155; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (155 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 156; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (156 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 157; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (157 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 158; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (158 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 159; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (159 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 160; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (160 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 161; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (161 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 162; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (162 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 163; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (163 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 164; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (164 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 165; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (165 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 166; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (166 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 167; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (167 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 168; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (168 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 169; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (169 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 170; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (170 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 171; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (171 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 172; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (172 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 173; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (173 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 174; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (174 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 175; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (175 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 176; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (176 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 177; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (177 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 178; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (178 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 179; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (179 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 180; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (180 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 181; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (181 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 182; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (182 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 183; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (183 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 184; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (184 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 185; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (185 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 186; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (186 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 187; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (187 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 188; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (188 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 189; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (189 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 190; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (190 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 191; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (191 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 192; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (192 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 193; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (193 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 194; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (194 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 195; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (195 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 196; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (196 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 197; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (197 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 198; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (198 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 199; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (199 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 200; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (200 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 201; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (201 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 202; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (202 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 203; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (203 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 204; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (204 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 205; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (205 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 206; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (206 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 207; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (207 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 208; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (208 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 209; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (209 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 210; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (210 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 211; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (211 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 212; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (212 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 213; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (213 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 214; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (214 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 215; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (215 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 216; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (216 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 217; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (217 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 218; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (218 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 219; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (219 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 220; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (220 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 221; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (221 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 222; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (222 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 223; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (223 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 224; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (224 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 225; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (225 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 226; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (226 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 227; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (227 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 228; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (228 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 229; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (229 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 230; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (230 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 231; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (231 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 232; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (232 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 233; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (233 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 234; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (234 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 235; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (235 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 236; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (236 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 237; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (237 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 238; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (238 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 239; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (239 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 240; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (240 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 241; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (241 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 242; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (242 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 243; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (243 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 244; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (244 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 245; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (245 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 246; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (246 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 247; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (247 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 248; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (248 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 249; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (249 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 250; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (250 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 251; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (251 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 252; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (252 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 253; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (253 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 254; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (254 shl 8); dwFlags: 0),
    (pguid: @GUID_Key; dwOfs: 255; dwType: DIDFT_BUTTON or DIPROPRANGE_NOMIN or (255 shl 8); dwFlags: 0)
  );
  {$EXTERNALSYM rgodfKeyboard}

const
  c_dfDIKeyboard: TDIDataFormat = (
    dwSize     : Sizeof(c_dfDIKeyboard);
    dwObjSize  : Sizeof(TDIObjectDataFormat);
    dwFlags    : DIDF_RELAXIS;
    dwDataSize : 256;
    dwNumObjs  : High(rgodfKeyboard) + 1;
    rgodf      : @rgodfKeyboard
  );
  {$EXTERNALSYM c_dfDIKeyboard}


 (* #if(DIRECTINPUT_VERSION >= 0x0500) *)
  rgodfJoystick: array[0..43] of TDIObjectDataFormat = (
    (pguid: @GUID_XAxis;  dwOfs: DIJOFS_X;  dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    (pguid: @GUID_YAxis;  dwOfs: DIJOFS_Y;  dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    (pguid: @GUID_ZAxis;  dwOfs: DIJOFS_Z;  dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    (pguid: @GUID_RxAxis; dwOfs: DIJOFS_RX; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    (pguid: @GUID_RyAxis; dwOfs: DIJOFS_RY; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    (pguid: @GUID_RzAxis; dwOfs: DIJOFS_RZ; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    // 2 Sliders
    (pguid: @GUID_Slider; dwOfs: 24; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    (pguid: @GUID_Slider; dwOfs: 28; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    // 4 POVs (yes, really)
    (pguid: @GUID_POV; dwOfs: 32; dwType: DIDFT_POV or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: @GUID_POV; dwOfs: 36; dwType: DIDFT_POV or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: @GUID_POV; dwOfs: 40; dwType: DIDFT_POV or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: @GUID_POV; dwOfs: 44; dwType: DIDFT_POV or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    // Buttons
    (pguid: nil; dwOfs: DIJOFS_BUTTON0;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON1;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON2;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON3;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON4;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON5;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON6;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON7;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON8;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON9;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON10; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON11; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON12; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON13; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON14; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON15; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON16; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON17; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON18; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON19; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON20; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON21; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON22; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON23; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON24; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON25; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON26; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON27; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON28; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON29; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON30; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON31; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0)
  );
  {$EXTERNALSYM rgodfJoystick}

  c_dfDIJoystick: TDIDataFormat = (
    dwSize     : Sizeof(c_dfDIJoystick);
    dwObjSize  : Sizeof(TDIObjectDataFormat);  // $10
    dwFlags    : DIDF_ABSAXIS;
    dwDataSize : SizeOf(TDIJoyState);         // $10
    dwNumObjs  : High(rgodfJoystick) + 1;  // $2C
    rgodf      : @rgodfJoystick
  );
  {$EXTERNALSYM c_dfDIJoystick}


  rgodfJoystick2: array[0..163] of TDIObjectDataFormat = (
    (pguid: @GUID_XAxis;  dwOfs: DIJOFS_X;  dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    (pguid: @GUID_YAxis;  dwOfs: DIJOFS_Y;  dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    (pguid: @GUID_ZAxis;  dwOfs: DIJOFS_Z;  dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    (pguid: @GUID_RxAxis; dwOfs: DIJOFS_RX; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    (pguid: @GUID_RyAxis; dwOfs: DIJOFS_RY; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    (pguid: @GUID_RzAxis; dwOfs: DIJOFS_RZ; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    // 2 Sliders
    (pguid: @GUID_Slider; dwOfs: 24; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    (pguid: @GUID_Slider; dwOfs: 28; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTPOSITION),
    // 4 POVs (yes, really)
    (pguid: @GUID_POV; dwOfs: 32; dwType: DIDFT_POV or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: @GUID_POV; dwOfs: 36; dwType: DIDFT_POV or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: @GUID_POV; dwOfs: 40; dwType: DIDFT_POV or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: @GUID_POV; dwOfs: 44; dwType: DIDFT_POV or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    // Buttons
    (pguid: nil; dwOfs: DIJOFS_BUTTON0;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON1;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON2;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON3;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON4;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON5;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON6;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON7;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON8;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON9;  dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON10; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON11; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON12; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON13; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON14; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON15; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON16; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON17; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON18; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON19; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON20; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON21; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON22; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON23; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON24; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON25; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON26; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON27; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON28; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON29; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON30; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs: DIJOFS_BUTTON31; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: 0),
    (pguid: nil; dwOfs:  80; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  81; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  82; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  83; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  84; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  85; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  86; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  87; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  88; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  89; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  90; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  91; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  92; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  93; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  94; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  95; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  96; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  97; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  98; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs:  99; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 100; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 101; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 102; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 103; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 104; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 105; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 106; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 107; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 108; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 109; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 110; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 111; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 112; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 113; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 114; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 115; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 116; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 117; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 118; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 119; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 120; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 121; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 122; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 123; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 124; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 125; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 126; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 127; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 128; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 129; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 130; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 131; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 132; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 133; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 134; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 135; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 136; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 137; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 138; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 139; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 140; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 141; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 142; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 143; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 144; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 145; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 146; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 147; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 148; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 149; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 150; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 151; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 152; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 153; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 154; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 155; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 156; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 157; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 158; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 159; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 160; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 161; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 162; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 163; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 164; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 165; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 166; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 167; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 168; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 169; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 170; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 171; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 172; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 173; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 174; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: nil; dwOfs: 175; dwType: DIDFT_BUTTON or DIDFT_ANYINSTANCE or $80000000; dwFlags: $0),
    (pguid: @GUID_XAxis;  dwOfs: 176; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTVELOCITY),
    (pguid: @GUID_YAxis;  dwOfs: 180; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTVELOCITY),
    (pguid: @GUID_ZAxis;  dwOfs: 184; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTVELOCITY),
    (pguid: @GUID_RxAxis; dwOfs: 188; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTVELOCITY),
    (pguid: @GUID_RyAxis; dwOfs: 192; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTVELOCITY),
    (pguid: @GUID_RzAxis; dwOfs: 196; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTVELOCITY),
    (pguid: @GUID_Slider; dwOfs:  24; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTVELOCITY),
    (pguid: @GUID_Slider; dwOfs:  28; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTVELOCITY),
    (pguid: @GUID_XAxis;  dwOfs: 208; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTACCEL),
    (pguid: @GUID_YAxis;  dwOfs: 212; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTACCEL),
    (pguid: @GUID_ZAxis;  dwOfs: 216; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTACCEL),
    (pguid: @GUID_RxAxis; dwOfs: 220; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTACCEL),
    (pguid: @GUID_RyAxis; dwOfs: 224; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTACCEL),
    (pguid: @GUID_RzAxis; dwOfs: 228; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTACCEL),
    (pguid: @GUID_Slider; dwOfs:  24; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTACCEL),
    (pguid: @GUID_Slider; dwOfs:  28; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTACCEL),
    (pguid: @GUID_XAxis;  dwOfs: 240; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTFORCE),
    (pguid: @GUID_YAxis;  dwOfs: 244; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTFORCE),
    (pguid: @GUID_ZAxis;  dwOfs: 248; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTFORCE),
    (pguid: @GUID_RxAxis; dwOfs: 252; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTFORCE),
    (pguid: @GUID_RyAxis; dwOfs: 256; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTFORCE),
    (pguid: @GUID_RzAxis; dwOfs: 260; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTFORCE),
    (pguid: @GUID_Slider; dwOfs:  24; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTFORCE),
    (pguid: @GUID_Slider; dwOfs:  28; dwType: DIDFT_AXIS or DIDFT_ANYINSTANCE or $80000000; dwFlags: DIDOI_ASPECTFORCE)
  );
  {$EXTERNALSYM rgodfJoystick2}

  c_dfDIJoystick2: TDIDataFormat = (
    dwSize     : Sizeof(c_dfDIJoystick2);
    dwObjSize  : Sizeof(TDIObjectDataFormat);
    dwFlags    : DIDF_ABSAXIS;
    dwDataSize : SizeOf(TDIJoyState2);
    dwNumObjs  : High(rgodfJoystick2) + 1;
    rgodf      : @rgodfJoystick2
  );
  {$EXTERNALSYM c_dfDIJoystick2}
 (* DIRECTINPUT_VERSION >= 0x0500 *)



(****************************************************************************
 *
 *  IDirectInput
 *
 ****************************************************************************)

const
  DIENUM_STOP             = BOOL(0);
  {$EXTERNALSYM DIENUM_STOP}
  DIENUM_CONTINUE         = BOOL(1);
  {$EXTERNALSYM DIENUM_CONTINUE}

type
  TDIEnumDevicesCallbackA = function (var lpddi: TDIDeviceInstanceA; pvRef: Pointer): BOOL; stdcall;
  {$EXTERNALSYM TDIEnumDevicesCallbackA}
  TDIEnumDevicesCallbackW = function (var lpddi: TDIDeviceInstanceW; pvRef: Pointer): BOOL; stdcall;
  {$EXTERNALSYM TDIEnumDevicesCallbackW}
  TDIEnumDevicesCallback = TDIEnumDevicesCallbackA;
  {$EXTERNALSYM TDIEnumDevicesCallback}
  TDIConfigureDevicesCallback = function (lpDDSTarget: IUnknown; pvRef: Pointer): BOOL; stdcall;

const
  DIEDFL_ALLDEVICES       = $00000000;
  {$EXTERNALSYM DIEDFL_ALLDEVICES}
  DIEDFL_ATTACHEDONLY     = $00000001;
  {$EXTERNALSYM DIEDFL_ATTACHEDONLY}
 (* #if(DIRECTINPUT_VERSION >= 0x0500) *)
  DIEDFL_FORCEFEEDBACK    = $00000100;
  {$EXTERNALSYM DIEDFL_FORCEFEEDBACK}
 (* DIRECTINPUT_VERSION >= 0x0500 *)
 (* #if(DIRECTINPUT_VERSION >= 0x050a) *)
  DIEDFL_INCLUDEALIASES   = $00010000;
  {$EXTERNALSYM DIEDFL_INCLUDEALIASES}
  DIEDFL_INCLUDEPHANTOMS  = $00020000;
  {$EXTERNALSYM DIEDFL_INCLUDEPHANTOMS}
 (* DIRECTINPUT_VERSION >= 0x050a *)
 (* #if(DIRECTINPUT_VERSION >= 0x0800) *)
  DIEDFL_INCLUDEHIDDEN    = $00040000;
  {$EXTERNALSYM DIEDFL_INCLUDEHIDDEN}
 (* DIRECTINPUT_VERSION >= 0x0800 *)


 (* #if(DIRECTINPUT_VERSION >= 0x0800) *)
type
  TDIEnumDevicesBySemanticsCallbackA = function (var lpddi: TDIDeviceInstanceA; lpdid: IDirectInputDevice8A; dwFlags, dwRemaining: DWORD; pvRef: Pointer): BOOL; stdcall;
  {$EXTERNALSYM TDIEnumDevicesBySemanticsCallbackA}
  TDIEnumDevicesBySemanticsCallbackW = function (var lpddi: TDIDeviceInstanceW; lpdid: IDirectInputDevice8W; dwFlags, dwRemaining: DWORD; pvRef: Pointer): BOOL; stdcall;
  {$EXTERNALSYM TDIEnumDevicesBySemanticsCallbackW}
  TDIEnumDevicesBySemanticsCallback = TDIEnumDevicesBySemanticsCallbackA;
  {$EXTERNALSYM TDIEnumDevicesBySemanticsCallback}
 (* DIRECTINPUT_VERSION >= 0x0800 *)

 (* #if(DIRECTINPUT_VERSION >= 0x0800) *)
const
  DIEDBS_MAPPEDPRI1         = $00000001;
  {$EXTERNALSYM DIEDBS_MAPPEDPRI1}
  DIEDBS_MAPPEDPRI2         = $00000002;
  {$EXTERNALSYM DIEDBS_MAPPEDPRI2}
  DIEDBS_RECENTDEVICE       = $00000010;
  {$EXTERNALSYM DIEDBS_RECENTDEVICE}
  DIEDBS_NEWDEVICE          = $00000020;
  {$EXTERNALSYM DIEDBS_NEWDEVICE}

  DIEDBSFL_ATTACHEDONLY       = $00000000;
  {$EXTERNALSYM DIEDBSFL_ATTACHEDONLY}
  DIEDBSFL_THISUSER           = $00000010;
  {$EXTERNALSYM DIEDBSFL_THISUSER}
  DIEDBSFL_FORCEFEEDBACK      = DIEDFL_FORCEFEEDBACK;
  {$EXTERNALSYM DIEDBSFL_FORCEFEEDBACK}
  DIEDBSFL_AVAILABLEDEVICES   = $00001000;
  {$EXTERNALSYM DIEDBSFL_AVAILABLEDEVICES}
  DIEDBSFL_MULTIMICEKEYBOARDS = $00002000;
  {$EXTERNALSYM DIEDBSFL_MULTIMICEKEYBOARDS}
  DIEDBSFL_NONGAMINGDEVICES   = $00004000;
  {$EXTERNALSYM DIEDBSFL_NONGAMINGDEVICES}
  DIEDBSFL_VALID              = $00007110;
  {$EXTERNALSYM DIEDBSFL_VALID}
 (* DIRECTINPUT_VERSION >= 0x0800 *)

type
  {$EXTERNALSYM IDirectInputA}
  IDirectInputA = interface(IUnknown)
    [SID_IDirectInputA]
    (*** IDirectInputA methods ***)
    function CreateDevice(const rguid: TGUID; out lplpDirectInputDevice: IDirectInputDeviceA; pUnkOuter: IUnknown): HResult; stdcall;
    function EnumDevices(dwDevType: DWORD; lpCallback: TDIEnumDevicesCallbackA; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
    function GetDeviceStatus(const rguidInstance: TGUID): HResult; stdcall;
    function RunControlPanel(hwndOwner: HWND; dwFlags: DWORD): HResult; stdcall;
    function Initialize(hinst: THandle; dwVersion: DWORD): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInputW}
  IDirectInputW = interface(IUnknown)
    [SID_IDirectInputW]
    (*** IDirectInputW methods ***)
    function CreateDevice(const rguid: TGUID; out lplpDirectInputDevice: IDirectInputDeviceW; pUnkOuter: IUnknown): HResult; stdcall;
    function EnumDevices(dwDevType: DWORD; lpCallback: TDIEnumDevicesCallbackW; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
    function GetDeviceStatus(const rguidInstance: TGUID): HResult; stdcall;
    function RunControlPanel(hwndOwner: HWND; dwFlags: DWORD): HResult; stdcall;
    function Initialize(hinst: THandle; dwVersion: DWORD): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInput}
  IDirectInput = IDirectInputA;
type
  IID_IDirectInput = IDirectInput;
  {$EXTERNALSYM IID_IDirectInput}

type
  {$EXTERNALSYM IDirectInput2A}
  IDirectInput2A = interface(IDirectInputA)
    [SID_IDirectInput2A]
    (*** IDirectInput2A methods ***)
    function FindDevice(const rguidClass: TGUID; ptszName: PAnsiChar; out pguidInstance: TGUID): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInput2W}
  IDirectInput2W = interface(IDirectInputW)
    [SID_IDirectInput2W]
    (*** IDirectInput2W methods ***)
    function FindDevice(const rguidClass: TGUID; ptszName: PWideChar; out pguidInstance: TGUID): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInput2}
  IDirectInput2 = IDirectInput2A;
type
  IID_IDirectInput2 = IDirectInput2;
  {$EXTERNALSYM IID_IDirectInput2}

type
  {$EXTERNALSYM IDirectInput7A}
  IDirectInput7A = interface(IDirectInput2A)
    [SID_IDirectInput7A]
    (*** IDirectInput7A methods ***)
    function CreateDeviceEx(const rguid, riid: TGUID; out pvOut: Pointer; pUnkOuter: IUnknown) : HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInput7W}
  IDirectInput7W = interface(IDirectInput2W)
    [SID_IDirectInput7W]
    (*** IDirectInput7W methods ***)
    function CreateDeviceEx(const rguid, riid: TGUID; out pvOut: Pointer; pUnkOuter: IUnknown) : HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInput7}
  IDirectInput7 = IDirectInput7A;
type
  IID_IDirectInput7 = IDirectInput7;
  {$EXTERNALSYM IID_IDirectInput7}

 (* #if(DIRECTINPUT_VERSION >= 0x0800) *)
type
  {$EXTERNALSYM IDirectInput8A}
  IDirectInput8A = interface(IUnknown)
    [SID_IDirectInput8A]
    (*** IDirectInput8A methods ***)
    function CreateDevice(const rguid: TGUID; out lplpDirectInputDevice: IDirectInputDevice8A; pUnkOuter: IUnknown): HResult; stdcall;
    function EnumDevices(dwDevType: DWORD; lpCallback: TDIEnumDevicesCallbackA; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
    function GetDeviceStatus(const rguidInstance: TGUID): HResult; stdcall;
    function RunControlPanel(hwndOwner: HWND; dwFlags: DWORD): HResult; stdcall;
    function Initialize(hinst: THandle; dwVersion: DWORD): HResult; stdcall;
    function FindDevice(const rguidClass: TGUID; ptszName: PAnsiChar; out pguidInstance: TGUID): HResult; stdcall;
    function EnumDevicesBySemantics(ptszUserName: PAnsiChar; const lpdiActionFormat: TDIActionFormatA; lpCallback: TDIEnumDevicesBySemanticsCallbackA; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
    function ConfigureDevices(lpdiCallback: TDIConfigureDevicesCallback; const lpdiCDParams: TDIConfigureDevicesParamsA; dwFlags: DWORD; pvRefData: Pointer): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInput8W}
  IDirectInput8W = interface(IUnknown)
    [SID_IDirectInput8W]
    (*** IDirectInput8W methods ***)
    function CreateDevice(const rguid: TGUID; out lplpDirectInputDevice: IDirectInputDevice8W; pUnkOuter: IUnknown): HResult; stdcall;
    function EnumDevices(dwDevType: DWORD; lpCallback: TDIEnumDevicesCallbackW; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
    function GetDeviceStatus(const rguidInstance: TGUID): HResult; stdcall;
    function RunControlPanel(hwndOwner: HWND; dwFlags: DWORD): HResult; stdcall;
    function Initialize(hinst: THandle; dwVersion: DWORD): HResult; stdcall;
    function FindDevice(const rguidClass: TGUID; ptszName: PWideChar; out pguidInstance: TGUID): HResult; stdcall;
    function EnumDevicesBySemantics(ptszUserName: PWideChar; const lpdiActionFormat: TDIActionFormatW; lpCallback: TDIEnumDevicesBySemanticsCallbackW; pvRef: Pointer; dwFlags: DWORD): HResult; stdcall;
    function ConfigureDevices(lpdiCallback: TDIConfigureDevicesCallback; const lpdiCDParams: TDIConfigureDevicesParamsW; dwFlags: DWORD; pvRefData: Pointer): HResult; stdcall;
  end;

  {$EXTERNALSYM IDirectInput8}
  IDirectInput8 = IDirectInput8A;
type
  IID_IDirectInput8 = IDirectInput8;
  {$EXTERNALSYM IID_IDirectInput8}
 (* DIRECTINPUT_VERSION >= 0x0800 *)


const
  DirectInputDll = 'dinput.dll';
  DirectInput8Dll = 'dinput8.dll';

function DirectInputLoaded: Boolean;
function UnLoadDirectInput: Boolean;
function LoadDirectInput: Boolean;

//{$IFDEF DIRECTINPUT_VERSION_8} (* #if(DIRECTINPUT_VERSION > 0x0700) *)
function DirectInput8Create(hinst: THandle; dwVersion: DWORD; const riidltf: TGUID; out ppvOut{: Pointer}; punkOuter: IUnknown): HResult; stdcall; external DirectInput8Dll;
{$EXTERNALSYM DirectInput8Create}

//{$ELSE}
function DirectInputCreateA(hinst: THandle; dwVersion: DWORD; out ppDI: IDirectInputA; punkOuter: IUnknown): HResult; stdcall; external DirectInputDll name 'DirectInputCreateA';
{$EXTERNALSYM DirectInputCreateA}
function DirectInputCreateW(hinst: THandle; dwVersion: DWORD; out ppDI: IDirectInputW; punkOuter: IUnknown): HResult; stdcall; external DirectInputDll name 'DirectInputCreateW';
{$EXTERNALSYM DirectInputCreateW}
function DirectInputCreate(hinst: THandle; dwVersion: DWORD; out ppDI: IDirectInput; punkOuter: IUnknown): HResult; stdcall; external DirectInputDll name 'DirectInputCreateA';
{$EXTERNALSYM DirectInputCreate}

function DirectInputCreateEx(hinst: THandle; dwVersion: DWORD; const riidltf: TGUID; out ppvOut{: Pointer}; punkOuter: IUnknown): HResult; stdcall; external DirectInputDll;
{$EXTERNALSYM DirectInputCreateEx}

//{$ENDIF} (* DIRECTINPUT_VERSION >= 0x0700 *)


(****************************************************************************
 *
 *  Return Codes
 *
 ****************************************************************************)

const
(*
 *  The operation completed successfully.
 *)
  DI_OK                           = S_OK;
  {$EXTERNALSYM DI_OK}

(*
 *  The device exists but is not currently attached.
 *)
  DI_NOTATTACHED                  = S_FALSE;
  {$EXTERNALSYM DI_NOTATTACHED}

(*
 *  The device buffer overflowed.  Some input was lost.
 *)
  DI_BUFFEROVERFLOW               = S_FALSE;
  {$EXTERNALSYM DI_BUFFEROVERFLOW}

(*
 *  The change in device properties had no effect.
 *)
  DI_PROPNOEFFECT                 = S_FALSE;
  {$EXTERNALSYM DI_PROPNOEFFECT}

(*
 *  The operation had no effect.
 *)
  DI_NOEFFECT                     = S_FALSE;
  {$EXTERNALSYM DI_NOEFFECT}

(*
 *  The device is a polled device.  As a result, device buffering
 *  will not collect any data and event notifications will not be
 *  signalled until GetDeviceState is called.
 *)
  DI_POLLEDDEVICE                 = HRESULT($00000002);
  {$EXTERNALSYM DI_POLLEDDEVICE}

(*
 *  The parameters of the effect were successfully updated by
 *  IDirectInputEffect::SetParameters, but the effect was not
 *  downloaded because the device is not exclusively acquired
 *  or because the DIEP_NODOWNLOAD flag was passed.
 *)
  DI_DOWNLOADSKIPPED              = HRESULT($00000003);
  {$EXTERNALSYM DI_DOWNLOADSKIPPED}

(*
 *  The parameters of the effect were successfully updated by
 *  IDirectInputEffect::SetParameters, but in order to change
 *  the parameters, the effect needed to be restarted.
 *)
  DI_EFFECTRESTARTED              = HRESULT($00000004);
  {$EXTERNALSYM DI_EFFECTRESTARTED}

(*
 *  The parameters of the effect were successfully updated by
 *  IDirectInputEffect::SetParameters, but some of them were
 *  beyond the capabilities of the device and were truncated.
 *)
  DI_TRUNCATED                    = HRESULT($00000008);
  {$EXTERNALSYM DI_TRUNCATED}

(*
 *  The settings have been successfully applied but could not be
 *  persisted.
 *)
  DI_SETTINGSNOTSAVED             = HRESULT($0000000B);
  {$EXTERNALSYM DI_SETTINGSNOTSAVED}

(*
 *  Equal to DI_EFFECTRESTARTED | DI_TRUNCATED.
 *)
  DI_TRUNCATEDANDRESTARTED        = HRESULT($0000000C);
  {$EXTERNALSYM DI_TRUNCATEDANDRESTARTED}

(*
 *  A SUCCESS code indicating that settings cannot be modified.
 *)
  DI_WRITEPROTECT                 = HRESULT($00000013);
  {$EXTERNALSYM DI_WRITEPROTECT}


  SEVERITY_ERROR_FACILITY_WIN32   =
      HResult(SEVERITY_ERROR shl 31) or HResult(FACILITY_WIN32 shl 16);
  {$EXTERNALSYM SEVERITY_ERROR_FACILITY_WIN32}

(*
 *  The application requires a newer version of DirectInput.
 *)
  DIERR_OLDDIRECTINPUTVERSION     = HRESULT(SEVERITY_ERROR_FACILITY_WIN32 or
                                            ERROR_OLD_WIN_VERSION);
  {$EXTERNALSYM DIERR_OLDDIRECTINPUTVERSION}

(*
 *  The application was written for an unsupported prerelease version
 *  of DirectInput.
 *)
  DIERR_BETADIRECTINPUTVERSION    = HRESULT(SEVERITY_ERROR_FACILITY_WIN32 or
                                            ERROR_RMODE_APP);
  {$EXTERNALSYM DIERR_BETADIRECTINPUTVERSION}

(*
 *  The object could not be created due to an incompatible driver version
 *  or mismatched or incomplete driver components.
 *)
  DIERR_BADDRIVERVER              = HRESULT(SEVERITY_ERROR_FACILITY_WIN32 or
                                            ERROR_BAD_DRIVER_LEVEL);
  {$EXTERNALSYM DIERR_BADDRIVERVER}

(*
 * The device or device instance or effect is not registered with DirectInput.
 *)
  DIERR_DEVICENOTREG              = REGDB_E_CLASSNOTREG;
  {$EXTERNALSYM DIERR_DEVICENOTREG}

(*
 * The requested object does not exist.
 *)
  DIERR_NOTFOUND                  = HRESULT(SEVERITY_ERROR_FACILITY_WIN32 or
                                            ERROR_FILE_NOT_FOUND);
  {$EXTERNALSYM DIERR_NOTFOUND}

(*
 * The requested object does not exist.
 *)
  DIERR_OBJECTNOTFOUND            = HRESULT(SEVERITY_ERROR_FACILITY_WIN32 or
                                            ERROR_FILE_NOT_FOUND);
  {$EXTERNALSYM DIERR_OBJECTNOTFOUND}

(*
 * An invalid parameter was passed to the returning function,
 * or the object was not in a state that admitted the function
 * to be called.
 *)
  DIERR_INVALIDPARAM              = E_INVALIDARG;
  {$EXTERNALSYM DIERR_INVALIDPARAM}

(*
 * The specified interface is not supported by the object
 *)
  DIERR_NOINTERFACE               = E_NOINTERFACE;
  {$EXTERNALSYM DIERR_NOINTERFACE}

(*
 * An undetermined error occured inside the DInput subsystem
 *)
  DIERR_GENERIC                   = E_FAIL;
  {$EXTERNALSYM DIERR_GENERIC}

(*
 * The DInput subsystem couldn't allocate sufficient memory to complete the
 * caller's request.
 *)
  DIERR_OUTOFMEMORY               = E_OUTOFMEMORY;
  {$EXTERNALSYM DIERR_OUTOFMEMORY}

(*
 * The function called is not supported at this time
 *)
  DIERR_UNSUPPORTED               = E_NOTIMPL;
  {$EXTERNALSYM DIERR_UNSUPPORTED}

(*
 * This object has not been initialized
 *)
  DIERR_NOTINITIALIZED            = HRESULT(SEVERITY_ERROR_FACILITY_WIN32 or
                                            ERROR_NOT_READY);
  {$EXTERNALSYM DIERR_NOTINITIALIZED}

(*
 * This object is already initialized
 *)
  DIERR_ALREADYINITIALIZED        = HRESULT(SEVERITY_ERROR_FACILITY_WIN32 or
                                            ERROR_ALREADY_INITIALIZED);
  {$EXTERNALSYM DIERR_ALREADYINITIALIZED}

(*
 * This object does not support aggregation
 *)
  DIERR_NOAGGREGATION             = CLASS_E_NOAGGREGATION;
  {$EXTERNALSYM DIERR_NOAGGREGATION}

(*
 * Another app has a higher priority level, preventing this call from
 * succeeding.
 *)
  DIERR_OTHERAPPHASPRIO           = E_ACCESSDENIED;
  {$EXTERNALSYM DIERR_OTHERAPPHASPRIO}

(*
 * Access to the device has been lost.  It must be re-acquired.
 *)
  DIERR_INPUTLOST                 = HRESULT(SEVERITY_ERROR_FACILITY_WIN32 or
                                            ERROR_READ_FAULT);
  {$EXTERNALSYM DIERR_INPUTLOST}

(*
 * The operation cannot be performed while the device is acquired.
 *)
  DIERR_ACQUIRED                  = HRESULT(SEVERITY_ERROR_FACILITY_WIN32 or
                                            ERROR_BUSY);
  {$EXTERNALSYM DIERR_ACQUIRED}

(*
 * The operation cannot be performed unless the device is acquired.
 *)
  DIERR_NOTACQUIRED               = HRESULT(SEVERITY_ERROR_FACILITY_WIN32 or
                                            ERROR_INVALID_ACCESS);
  {$EXTERNALSYM DIERR_NOTACQUIRED}

(*
 * The specified property cannot be changed.
 *)
  DIERR_READONLY                  = E_ACCESSDENIED;
  {$EXTERNALSYM DIERR_READONLY}

(*
 * The device already has an event notification associated with it.
 *)
  DIERR_HANDLEEXISTS              = E_ACCESSDENIED;
  {$EXTERNALSYM DIERR_HANDLEEXISTS}

(*
 * Data is not yet available.
 *)
  E_PENDING                       = $8000000A;
  {$EXTERNALSYM E_PENDING}

(*
 * Unable to IDirectInputJoyConfig_Acquire because the user
 * does not have sufficient privileges to change the joystick
 * configuration.
 *)
  DIERR_INSUFFICIENTPRIVS         = $80040200;
  {$EXTERNALSYM DIERR_INSUFFICIENTPRIVS}

(*
 * The device is full.
 *)
  DIERR_DEVICEFULL                = $80040201;
  {$EXTERNALSYM DIERR_DEVICEFULL}

(*
 * Not all the requested information fit into the buffer.
 *)
  DIERR_MOREDATA                  = $80040202;
  {$EXTERNALSYM DIERR_MOREDATA}

(*
 * The effect is not downloaded.
 *)
  DIERR_NOTDOWNLOADED             = $80040203;
  {$EXTERNALSYM DIERR_NOTDOWNLOADED}

(*
 *  The device cannot be reinitialized because there are still effects
 *  attached to it.
 *)
  DIERR_HASEFFECTS                = $80040204;
  {$EXTERNALSYM DIERR_HASEFFECTS}

(*
 *  The operation cannot be performed unless the device is acquired
 *  in DISCL_EXCLUSIVE mode.
 *)
  DIERR_NOTEXCLUSIVEACQUIRED      = $80040205;
  {$EXTERNALSYM DIERR_NOTEXCLUSIVEACQUIRED}

(*
 *  The effect could not be downloaded because essential information
 *  is missing.  For example, no axes have been associated with the
 *  effect, or no type-specific information has been created.
 *)
  DIERR_INCOMPLETEEFFECT          = $80040206;
  {$EXTERNALSYM DIERR_INCOMPLETEEFFECT}

(*
 *  Attempted to read buffered device data from a device that is
 *  not buffered.
 *)
  DIERR_NOTBUFFERED               = $80040207;
  {$EXTERNALSYM DIERR_NOTBUFFERED}

(*
 *  An attempt was made to modify parameters of an effect while it is
 *  playing.  Not all hardware devices support altering the parameters
 *  of an effect while it is playing.
 *)
  DIERR_EFFECTPLAYING             = $80040208;
  {$EXTERNALSYM DIERR_EFFECTPLAYING}

(*
 *  The operation could not be completed because the device is not
 *  plugged in.
 *)
  DIERR_UNPLUGGED                 = $80040209;
  {$EXTERNALSYM DIERR_UNPLUGGED}

(*
 *  SendDeviceData failed because more information was requested
 *  to be sent than can be sent to the device.  Some devices have
 *  restrictions on how much data can be sent to them.  (For example,
 *  there might be a limit on the number of buttons that can be
 *  pressed at once.)
 *)
  DIERR_REPORTFULL                = $8004020A;
  {$EXTERNALSYM DIERR_REPORTFULL}


(*
 *  A mapper file function failed because reading or writing the user or IHV
 *  settings file failed.
 *)
  DIERR_MAPFILEFAIL               = $8004020B;
  {$EXTERNALSYM DIERR_MAPFILEFAIL}


(*--- DINPUT Mapper Definitions: New for Dx8         ---*)


(*--- Keyboard
      Physical Keyboard Device       ---*)

  DIKEYBOARD_ESCAPE                       = $81000401;
  {$EXTERNALSYM DIKEYBOARD_ESCAPE}
  DIKEYBOARD_1                            = $81000402;
  {$EXTERNALSYM DIKEYBOARD_1}
  DIKEYBOARD_2                            = $81000403;
  {$EXTERNALSYM DIKEYBOARD_2}
  DIKEYBOARD_3                            = $81000404;
  {$EXTERNALSYM DIKEYBOARD_3}
  DIKEYBOARD_4                            = $81000405;
  {$EXTERNALSYM DIKEYBOARD_4}
  DIKEYBOARD_5                            = $81000406;
  {$EXTERNALSYM DIKEYBOARD_5}
  DIKEYBOARD_6                            = $81000407;
  {$EXTERNALSYM DIKEYBOARD_6}
  DIKEYBOARD_7                            = $81000408;
  {$EXTERNALSYM DIKEYBOARD_7}
  DIKEYBOARD_8                            = $81000409;
  {$EXTERNALSYM DIKEYBOARD_8}
  DIKEYBOARD_9                            = $8100040A;
  {$EXTERNALSYM DIKEYBOARD_9}
  DIKEYBOARD_0                            = $8100040B;
  {$EXTERNALSYM DIKEYBOARD_0}
  DIKEYBOARD_MINUS                        = $8100040C;    (* - on main keyboard *)
  {$EXTERNALSYM DIKEYBOARD_MINUS}
  DIKEYBOARD_EQUALS                       = $8100040D;
  {$EXTERNALSYM DIKEYBOARD_EQUALS}
  DIKEYBOARD_BACK                         = $8100040E;    (* backspace *)
  {$EXTERNALSYM DIKEYBOARD_BACK}
  DIKEYBOARD_TAB                          = $8100040F;
  {$EXTERNALSYM DIKEYBOARD_TAB}
  DIKEYBOARD_Q                            = $81000410;
  {$EXTERNALSYM DIKEYBOARD_Q}
  DIKEYBOARD_W                            = $81000411;
  {$EXTERNALSYM DIKEYBOARD_W}
  DIKEYBOARD_E                            = $81000412;
  {$EXTERNALSYM DIKEYBOARD_E}
  DIKEYBOARD_R                            = $81000413;
  {$EXTERNALSYM DIKEYBOARD_R}
  DIKEYBOARD_T                            = $81000414;
  {$EXTERNALSYM DIKEYBOARD_T}
  DIKEYBOARD_Y                            = $81000415;
  {$EXTERNALSYM DIKEYBOARD_Y}
  DIKEYBOARD_U                            = $81000416;
  {$EXTERNALSYM DIKEYBOARD_U}
  DIKEYBOARD_I                            = $81000417;
  {$EXTERNALSYM DIKEYBOARD_I}
  DIKEYBOARD_O                            = $81000418;
  {$EXTERNALSYM DIKEYBOARD_O}
  DIKEYBOARD_P                            = $81000419;
  {$EXTERNALSYM DIKEYBOARD_P}
  DIKEYBOARD_LBRACKET                     = $8100041A;
  {$EXTERNALSYM DIKEYBOARD_LBRACKET}
  DIKEYBOARD_RBRACKET                     = $8100041B;
  {$EXTERNALSYM DIKEYBOARD_RBRACKET}
  DIKEYBOARD_RETURN                       = $8100041C;    (* Enter on main keyboard *)
  {$EXTERNALSYM DIKEYBOARD_RETURN}
  DIKEYBOARD_LCONTROL                     = $8100041D;
  {$EXTERNALSYM DIKEYBOARD_LCONTROL}
  DIKEYBOARD_A                            = $8100041E;
  {$EXTERNALSYM DIKEYBOARD_A}
  DIKEYBOARD_S                            = $8100041F;
  {$EXTERNALSYM DIKEYBOARD_S}
  DIKEYBOARD_D                            = $81000420;
  {$EXTERNALSYM DIKEYBOARD_D}
  DIKEYBOARD_F                            = $81000421;
  {$EXTERNALSYM DIKEYBOARD_F}
  DIKEYBOARD_G                            = $81000422;
  {$EXTERNALSYM DIKEYBOARD_G}
  DIKEYBOARD_H                            = $81000423;
  {$EXTERNALSYM DIKEYBOARD_H}
  DIKEYBOARD_J                            = $81000424;
  {$EXTERNALSYM DIKEYBOARD_J}
  DIKEYBOARD_K                            = $81000425;
  {$EXTERNALSYM DIKEYBOARD_K}
  DIKEYBOARD_L                            = $81000426;
  {$EXTERNALSYM DIKEYBOARD_L}
  DIKEYBOARD_SEMICOLON                    = $81000427;
  {$EXTERNALSYM DIKEYBOARD_SEMICOLON}
  DIKEYBOARD_APOSTROPHE                   = $81000428;
  {$EXTERNALSYM DIKEYBOARD_APOSTROPHE}
  DIKEYBOARD_GRAVE                        = $81000429;    (* accent grave *)
  {$EXTERNALSYM DIKEYBOARD_GRAVE}
  DIKEYBOARD_LSHIFT                       = $8100042A;
  {$EXTERNALSYM DIKEYBOARD_LSHIFT}
  DIKEYBOARD_BACKSLASH                    = $8100042B;
  {$EXTERNALSYM DIKEYBOARD_BACKSLASH}
  DIKEYBOARD_Z                            = $8100042C;
  {$EXTERNALSYM DIKEYBOARD_Z}
  DIKEYBOARD_X                            = $8100042D;
  {$EXTERNALSYM DIKEYBOARD_X}
  DIKEYBOARD_C                            = $8100042E;
  {$EXTERNALSYM DIKEYBOARD_C}
  DIKEYBOARD_V                            = $8100042F;
  {$EXTERNALSYM DIKEYBOARD_V}
  DIKEYBOARD_B                            = $81000430;
  {$EXTERNALSYM DIKEYBOARD_B}
  DIKEYBOARD_N                            = $81000431;
  {$EXTERNALSYM DIKEYBOARD_N}
  DIKEYBOARD_M                            = $81000432;
  {$EXTERNALSYM DIKEYBOARD_M}
  DIKEYBOARD_COMMA                        = $81000433;
  {$EXTERNALSYM DIKEYBOARD_COMMA}
  DIKEYBOARD_PERIOD                       = $81000434;    (* . on main keyboard *)
  {$EXTERNALSYM DIKEYBOARD_PERIOD}
  DIKEYBOARD_SLASH                        = $81000435;    (* / on main keyboard *)
  {$EXTERNALSYM DIKEYBOARD_SLASH}
  DIKEYBOARD_RSHIFT                       = $81000436;
  {$EXTERNALSYM DIKEYBOARD_RSHIFT}
  DIKEYBOARD_MULTIPLY                     = $81000437;    (* * on numeric keypad *)
  {$EXTERNALSYM DIKEYBOARD_MULTIPLY}
  DIKEYBOARD_LMENU                        = $81000438;    (* left Alt *)
  {$EXTERNALSYM DIKEYBOARD_LMENU}
  DIKEYBOARD_SPACE                        = $81000439;
  {$EXTERNALSYM DIKEYBOARD_SPACE}
  DIKEYBOARD_CAPITAL                      = $8100043A;
  {$EXTERNALSYM DIKEYBOARD_CAPITAL}
  DIKEYBOARD_F1                           = $8100043B;
  {$EXTERNALSYM DIKEYBOARD_F1}
  DIKEYBOARD_F2                           = $8100043C;
  {$EXTERNALSYM DIKEYBOARD_F2}
  DIKEYBOARD_F3                           = $8100043D;
  {$EXTERNALSYM DIKEYBOARD_F3}
  DIKEYBOARD_F4                           = $8100043E;
  {$EXTERNALSYM DIKEYBOARD_F4}
  DIKEYBOARD_F5                           = $8100043F;
  {$EXTERNALSYM DIKEYBOARD_F5}
  DIKEYBOARD_F6                           = $81000440;
  {$EXTERNALSYM DIKEYBOARD_F6}
  DIKEYBOARD_F7                           = $81000441;
  {$EXTERNALSYM DIKEYBOARD_F7}
  DIKEYBOARD_F8                           = $81000442;
  {$EXTERNALSYM DIKEYBOARD_F8}
  DIKEYBOARD_F9                           = $81000443;
  {$EXTERNALSYM DIKEYBOARD_F9}
  DIKEYBOARD_F10                          = $81000444;
  {$EXTERNALSYM DIKEYBOARD_F10}
  DIKEYBOARD_NUMLOCK                      = $81000445;
  {$EXTERNALSYM DIKEYBOARD_NUMLOCK}
  DIKEYBOARD_SCROLL                       = $81000446;    (* Scroll Lock *)
  {$EXTERNALSYM DIKEYBOARD_SCROLL}
  DIKEYBOARD_NUMPAD7                      = $81000447;
  {$EXTERNALSYM DIKEYBOARD_NUMPAD7}
  DIKEYBOARD_NUMPAD8                      = $81000448;
  {$EXTERNALSYM DIKEYBOARD_NUMPAD8}
  DIKEYBOARD_NUMPAD9                      = $81000449;
  {$EXTERNALSYM DIKEYBOARD_NUMPAD9}
  DIKEYBOARD_SUBTRACT                     = $8100044A;    (* - on numeric keypad *)
  {$EXTERNALSYM DIKEYBOARD_SUBTRACT}
  DIKEYBOARD_NUMPAD4                      = $8100044B;
  {$EXTERNALSYM DIKEYBOARD_NUMPAD4}
  DIKEYBOARD_NUMPAD5                      = $8100044C;
  {$EXTERNALSYM DIKEYBOARD_NUMPAD5}
  DIKEYBOARD_NUMPAD6                      = $8100044D;
  {$EXTERNALSYM DIKEYBOARD_NUMPAD6}
  DIKEYBOARD_ADD                          = $8100044E;    (* + on numeric keypad *)
  {$EXTERNALSYM DIKEYBOARD_ADD}
  DIKEYBOARD_NUMPAD1                      = $8100044F;
  {$EXTERNALSYM DIKEYBOARD_NUMPAD1}
  DIKEYBOARD_NUMPAD2                      = $81000450;
  {$EXTERNALSYM DIKEYBOARD_NUMPAD2}
  DIKEYBOARD_NUMPAD3                      = $81000451;
  {$EXTERNALSYM DIKEYBOARD_NUMPAD3}
  DIKEYBOARD_NUMPAD0                      = $81000452;
  {$EXTERNALSYM DIKEYBOARD_NUMPAD0}
  DIKEYBOARD_DECIMAL                      = $81000453;    (* . on numeric keypad *)
  {$EXTERNALSYM DIKEYBOARD_DECIMAL}
  DIKEYBOARD_OEM_102                      = $81000456;    (* <> or \| on RT 102-key keyboard (Non-U.S.) *)
  {$EXTERNALSYM DIKEYBOARD_OEM_102}
  DIKEYBOARD_F11                          = $81000457;
  {$EXTERNALSYM DIKEYBOARD_F11}
  DIKEYBOARD_F12                          = $81000458;
  {$EXTERNALSYM DIKEYBOARD_F12}
  DIKEYBOARD_F13                          = $81000464;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIKEYBOARD_F13}
  DIKEYBOARD_F14                          = $81000465;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIKEYBOARD_F14}
  DIKEYBOARD_F15                          = $81000466;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIKEYBOARD_F15}
  DIKEYBOARD_KANA                         = $81000470;    (* (Japanese keyboard)            *)
  {$EXTERNALSYM DIKEYBOARD_KANA}
  DIKEYBOARD_ABNT_C1                      = $81000473;    (* /? on Brazilian keyboard *)
  {$EXTERNALSYM DIKEYBOARD_ABNT_C1}
  DIKEYBOARD_CONVERT                      = $81000479;    (* (Japanese keyboard)            *)
  {$EXTERNALSYM DIKEYBOARD_CONVERT}
  DIKEYBOARD_NOCONVERT                    = $8100047B;    (* (Japanese keyboard)            *)
  {$EXTERNALSYM DIKEYBOARD_NOCONVERT}
  DIKEYBOARD_YEN                          = $8100047D;    (* (Japanese keyboard)            *)
  {$EXTERNALSYM DIKEYBOARD_YEN}
  DIKEYBOARD_ABNT_C2                      = $8100047E;    (* Numpad . on Brazilian keyboard *)
  {$EXTERNALSYM DIKEYBOARD_ABNT_C2}
  DIKEYBOARD_NUMPADEQUALS                 = $8100048D;    (* = on numeric keypad (NEC PC98) *)
  {$EXTERNALSYM DIKEYBOARD_NUMPADEQUALS}
  DIKEYBOARD_PREVTRACK                    = $81000490;    (* Previous Track (DIK_CIRCUMFLEX on Japanese keyboard) *)
  {$EXTERNALSYM DIKEYBOARD_PREVTRACK}
  DIKEYBOARD_AT                           = $81000491;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIKEYBOARD_AT}
  DIKEYBOARD_COLON                        = $81000492;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIKEYBOARD_COLON}
  DIKEYBOARD_UNDERLINE                    = $81000493;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIKEYBOARD_UNDERLINE}
  DIKEYBOARD_KANJI                        = $81000494;    (* (Japanese keyboard)            *)
  {$EXTERNALSYM DIKEYBOARD_KANJI}
  DIKEYBOARD_STOP                         = $81000495;    (*                     (NEC PC98) *)
  {$EXTERNALSYM DIKEYBOARD_STOP}
  DIKEYBOARD_AX                           = $81000496;    (*                     (Japan AX) *)
  {$EXTERNALSYM DIKEYBOARD_AX}
  DIKEYBOARD_UNLABELED                    = $81000497;    (*                        (J3100) *)
  {$EXTERNALSYM DIKEYBOARD_UNLABELED}
  DIKEYBOARD_NEXTTRACK                    = $81000499;    (* Next Track *)
  {$EXTERNALSYM DIKEYBOARD_NEXTTRACK}
  DIKEYBOARD_NUMPADENTER                  = $8100049C;    (* Enter on numeric keypad *)
  {$EXTERNALSYM DIKEYBOARD_NUMPADENTER}
  DIKEYBOARD_RCONTROL                     = $8100049D;
  {$EXTERNALSYM DIKEYBOARD_RCONTROL}
  DIKEYBOARD_MUTE                         = $810004A0;    (* Mute *)
  {$EXTERNALSYM DIKEYBOARD_MUTE}
  DIKEYBOARD_CALCULATOR                   = $810004A1;    (* Calculator *)
  {$EXTERNALSYM DIKEYBOARD_CALCULATOR}
  DIKEYBOARD_PLAYPAUSE                    = $810004A2;    (* Play / Pause *)
  {$EXTERNALSYM DIKEYBOARD_PLAYPAUSE}
  DIKEYBOARD_MEDIASTOP                    = $810004A4;    (* Media Stop *)
  {$EXTERNALSYM DIKEYBOARD_MEDIASTOP}
  DIKEYBOARD_VOLUMEDOWN                   = $810004AE;    (* Volume - *)
  {$EXTERNALSYM DIKEYBOARD_VOLUMEDOWN}
  DIKEYBOARD_VOLUMEUP                     = $810004B0;    (* Volume + *)
  {$EXTERNALSYM DIKEYBOARD_VOLUMEUP}
  DIKEYBOARD_WEBHOME                      = $810004B2;    (* Web home *)
  {$EXTERNALSYM DIKEYBOARD_WEBHOME}
  DIKEYBOARD_NUMPADCOMMA                  = $810004B3;    (* , on numeric keypad (NEC PC98) *)
  {$EXTERNALSYM DIKEYBOARD_NUMPADCOMMA}
  DIKEYBOARD_DIVIDE                       = $810004B5;    (* / on numeric keypad *)
  {$EXTERNALSYM DIKEYBOARD_DIVIDE}
  DIKEYBOARD_SYSRQ                        = $810004B7;
  {$EXTERNALSYM DIKEYBOARD_SYSRQ}
  DIKEYBOARD_RMENU                        = $810004B8;    (* right Alt *)
  {$EXTERNALSYM DIKEYBOARD_RMENU}
  DIKEYBOARD_PAUSE                        = $810004C5;    (* Pause *)
  {$EXTERNALSYM DIKEYBOARD_PAUSE}
  DIKEYBOARD_HOME                         = $810004C7;    (* Home on arrow keypad *)
  {$EXTERNALSYM DIKEYBOARD_HOME}
  DIKEYBOARD_UP                           = $810004C8;    (* UpArrow on arrow keypad *)
  {$EXTERNALSYM DIKEYBOARD_UP}
  DIKEYBOARD_PRIOR                        = $810004C9;    (* PgUp on arrow keypad *)
  {$EXTERNALSYM DIKEYBOARD_PRIOR}
  DIKEYBOARD_LEFT                         = $810004CB;    (* LeftArrow on arrow keypad *)
  {$EXTERNALSYM DIKEYBOARD_LEFT}
  DIKEYBOARD_RIGHT                        = $810004CD;    (* RightArrow on arrow keypad *)
  {$EXTERNALSYM DIKEYBOARD_RIGHT}
  DIKEYBOARD_END                          = $810004CF;    (* End on arrow keypad *)
  {$EXTERNALSYM DIKEYBOARD_END}
  DIKEYBOARD_DOWN                         = $810004D0;    (* DownArrow on arrow keypad *)
  {$EXTERNALSYM DIKEYBOARD_DOWN}
  DIKEYBOARD_NEXT                         = $810004D1;    (* PgDn on arrow keypad *)
  {$EXTERNALSYM DIKEYBOARD_NEXT}
  DIKEYBOARD_INSERT                       = $810004D2;    (* Insert on arrow keypad *)
  {$EXTERNALSYM DIKEYBOARD_INSERT}
  DIKEYBOARD_DELETE                       = $810004D3;    (* Delete on arrow keypad *)
  {$EXTERNALSYM DIKEYBOARD_DELETE}
  DIKEYBOARD_LWIN                         = $810004DB;    (* Left Windows key *)
  {$EXTERNALSYM DIKEYBOARD_LWIN}
  DIKEYBOARD_RWIN                         = $810004DC;    (* Right Windows key *)
  {$EXTERNALSYM DIKEYBOARD_RWIN}
  DIKEYBOARD_APPS                         = $810004DD;    (* AppMenu key *)
  {$EXTERNALSYM DIKEYBOARD_APPS}
  DIKEYBOARD_POWER                        = $810004DE;    (* System Power *)
  {$EXTERNALSYM DIKEYBOARD_POWER}
  DIKEYBOARD_SLEEP                        = $810004DF;    (* System Sleep *)
  {$EXTERNALSYM DIKEYBOARD_SLEEP}
  DIKEYBOARD_WAKE                         = $810004E3;    (* System Wake *)
  {$EXTERNALSYM DIKEYBOARD_WAKE}
  DIKEYBOARD_WEBSEARCH                    = $810004E5;    (* Web Search *)
  {$EXTERNALSYM DIKEYBOARD_WEBSEARCH}
  DIKEYBOARD_WEBFAVORITES                 = $810004E6;    (* Web Favorites *)
  {$EXTERNALSYM DIKEYBOARD_WEBFAVORITES}
  DIKEYBOARD_WEBREFRESH                   = $810004E7;    (* Web Refresh *)
  {$EXTERNALSYM DIKEYBOARD_WEBREFRESH}
  DIKEYBOARD_WEBSTOP                      = $810004E8;    (* Web Stop *)
  {$EXTERNALSYM DIKEYBOARD_WEBSTOP}
  DIKEYBOARD_WEBFORWARD                   = $810004E9;    (* Web Forward *)
  {$EXTERNALSYM DIKEYBOARD_WEBFORWARD}
  DIKEYBOARD_WEBBACK                      = $810004EA;    (* Web Back *)
  {$EXTERNALSYM DIKEYBOARD_WEBBACK}
  DIKEYBOARD_MYCOMPUTER                   = $810004EB;    (* My Computer *)
  {$EXTERNALSYM DIKEYBOARD_MYCOMPUTER}
  DIKEYBOARD_MAIL                         = $810004EC;    (* Mail *)
  {$EXTERNALSYM DIKEYBOARD_MAIL}
  DIKEYBOARD_MEDIASELECT                  = $810004ED;    (* Media Select *)
  {$EXTERNALSYM DIKEYBOARD_MEDIASELECT}


(*--- MOUSE
      Physical Mouse Device             ---*)

  DIMOUSE_XAXISAB                         = ($82000200 or DIMOFS_X); (* X Axis-absolute: Some mice natively report absolute coordinates  *)
  {$EXTERNALSYM DIMOUSE_XAXISAB}
  DIMOUSE_YAXISAB                         = ($82000200 or DIMOFS_Y); (* Y Axis-absolute: Some mice natively report absolute coordinates *)
  {$EXTERNALSYM DIMOUSE_YAXISAB}
  DIMOUSE_XAXIS                           = ($82000300 or DIMOFS_X); (* X Axis *)
  {$EXTERNALSYM DIMOUSE_XAXIS}
  DIMOUSE_YAXIS                           = ($82000300 or DIMOFS_Y); (* Y Axis *)
  {$EXTERNALSYM DIMOUSE_YAXIS}
  DIMOUSE_WHEEL                           = ($82000300 or DIMOFS_Z); (* Z Axis *)
  {$EXTERNALSYM DIMOUSE_WHEEL}
  DIMOUSE_BUTTON0                         = ($82000400 or DIMOFS_BUTTON0); (* Button 0 *)
  {$EXTERNALSYM DIMOUSE_BUTTON0}
  DIMOUSE_BUTTON1                         = ($82000400 or DIMOFS_BUTTON1); (* Button 1 *)
  {$EXTERNALSYM DIMOUSE_BUTTON1}
  DIMOUSE_BUTTON2                         = ($82000400 or DIMOFS_BUTTON2); (* Button 2 *)
  {$EXTERNALSYM DIMOUSE_BUTTON2}
  DIMOUSE_BUTTON3                         = ($82000400 or DIMOFS_BUTTON3); (* Button 3 *)
  {$EXTERNALSYM DIMOUSE_BUTTON3}
  DIMOUSE_BUTTON4                         = ($82000400 or DIMOFS_BUTTON4); (* Button 4 *)
  {$EXTERNALSYM DIMOUSE_BUTTON4}
  DIMOUSE_BUTTON5                         = ($82000400 or DIMOFS_BUTTON5); (* Button 5 *)
  {$EXTERNALSYM DIMOUSE_BUTTON5}
  DIMOUSE_BUTTON6                         = ($82000400 or DIMOFS_BUTTON6); (* Button 6 *)
  {$EXTERNALSYM DIMOUSE_BUTTON6}
  DIMOUSE_BUTTON7                         = ($82000400 or DIMOFS_BUTTON7); (* Button 7 *)
  {$EXTERNALSYM DIMOUSE_BUTTON7}


(*--- VOICE
      Physical Dplay Voice Device       ---*)

  DIVOICE_CHANNEL1                        = $83000401;
  {$EXTERNALSYM DIVOICE_CHANNEL1}
  DIVOICE_CHANNEL2                        = $83000402;
  {$EXTERNALSYM DIVOICE_CHANNEL2}
  DIVOICE_CHANNEL3                        = $83000403;
  {$EXTERNALSYM DIVOICE_CHANNEL3}
  DIVOICE_CHANNEL4                        = $83000404;
  {$EXTERNALSYM DIVOICE_CHANNEL4}
  DIVOICE_CHANNEL5                        = $83000405;
  {$EXTERNALSYM DIVOICE_CHANNEL5}
  DIVOICE_CHANNEL6                        = $83000406;
  {$EXTERNALSYM DIVOICE_CHANNEL6}
  DIVOICE_CHANNEL7                        = $83000407;
  {$EXTERNALSYM DIVOICE_CHANNEL7}
  DIVOICE_CHANNEL8                        = $83000408;
  {$EXTERNALSYM DIVOICE_CHANNEL8}
  DIVOICE_TEAM                            = $83000409;
  {$EXTERNALSYM DIVOICE_TEAM}
  DIVOICE_ALL                             = $8300040A;
  {$EXTERNALSYM DIVOICE_ALL}
  DIVOICE_RECORDMUTE                      = $8300040B;
  {$EXTERNALSYM DIVOICE_RECORDMUTE}
  DIVOICE_PLAYBACKMUTE                    = $8300040C;
  {$EXTERNALSYM DIVOICE_PLAYBACKMUTE}
  DIVOICE_TRANSMIT                        = $8300040D;
  {$EXTERNALSYM DIVOICE_TRANSMIT}

  DIVOICE_VOICECOMMAND                    = $83000410;
  {$EXTERNALSYM DIVOICE_VOICECOMMAND}


(*--- Driving Simulator - Racing
      Vehicle control is primary objective  ---*)
  DIVIRTUAL_DRIVING_RACE                  = $01000000;
  {$EXTERNALSYM DIVIRTUAL_DRIVING_RACE}
  DIAXIS_DRIVINGR_STEER                   = $01008A01; (* Steering *)
  {$EXTERNALSYM DIAXIS_DRIVINGR_STEER}
  DIAXIS_DRIVINGR_ACCELERATE              = $01039202; (* Accelerate *)
  {$EXTERNALSYM DIAXIS_DRIVINGR_ACCELERATE}
  DIAXIS_DRIVINGR_BRAKE                   = $01041203; (* Brake-Axis *)
  {$EXTERNALSYM DIAXIS_DRIVINGR_BRAKE}
  DIBUTTON_DRIVINGR_SHIFTUP               = $01000C01; (* Shift to next higher gear *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_SHIFTUP}
  DIBUTTON_DRIVINGR_SHIFTDOWN             = $01000C02; (* Shift to next lower gear *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_SHIFTDOWN}
  DIBUTTON_DRIVINGR_VIEW                  = $01001C03; (* Cycle through view options *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_VIEW}
  DIBUTTON_DRIVINGR_MENU                  = $010004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_MENU}
(*--- Priority 2 controls                            ---*)

  DIAXIS_DRIVINGR_ACCEL_AND_BRAKE         = $01014A04; (* Some devices combine accelerate and brake in a single axis *)
  {$EXTERNALSYM DIAXIS_DRIVINGR_ACCEL_AND_BRAKE}
  DIHATSWITCH_DRIVINGR_GLANCE             = $01004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_DRIVINGR_GLANCE}
  DIBUTTON_DRIVINGR_BRAKE                 = $01004C04; (* Brake-button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_BRAKE}
  DIBUTTON_DRIVINGR_DASHBOARD             = $01004405; (* Select next dashboard option *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_DASHBOARD}
  DIBUTTON_DRIVINGR_AIDS                  = $01004406; (* Driver correction aids *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_AIDS}
  DIBUTTON_DRIVINGR_MAP                   = $01004407; (* Display Driving Map *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_MAP}
  DIBUTTON_DRIVINGR_BOOST                 = $01004408; (* Turbo Boost *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_BOOST}
  DIBUTTON_DRIVINGR_PIT                   = $01004409; (* Pit stop notification *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_PIT}
  DIBUTTON_DRIVINGR_ACCELERATE_LINK       = $0103D4E0; (* Fallback Accelerate button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_ACCELERATE_LINK}
  DIBUTTON_DRIVINGR_STEER_LEFT_LINK       = $0100CCE4; (* Fallback Steer Left button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_STEER_LEFT_LINK}
  DIBUTTON_DRIVINGR_STEER_RIGHT_LINK      = $0100CCEC; (* Fallback Steer Right button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_STEER_RIGHT_LINK}
  DIBUTTON_DRIVINGR_GLANCE_LEFT_LINK      = $0107C4E4; (* Fallback Glance Left button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_GLANCE_LEFT_LINK}
  DIBUTTON_DRIVINGR_GLANCE_RIGHT_LINK     = $0107C4EC; (* Fallback Glance Right button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_GLANCE_RIGHT_LINK}
  DIBUTTON_DRIVINGR_DEVICE                = $010044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_DEVICE}
  DIBUTTON_DRIVINGR_PAUSE                 = $010044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_DRIVINGR_PAUSE}

(*--- Driving Simulator - Combat
      Combat from within a vehicle is primary objective  ---*)
  DIVIRTUAL_DRIVING_COMBAT                = $02000000;
  {$EXTERNALSYM DIVIRTUAL_DRIVING_COMBAT}
  DIAXIS_DRIVINGC_STEER                   = $02008A01; (* Steering  *)
  {$EXTERNALSYM DIAXIS_DRIVINGC_STEER}
  DIAXIS_DRIVINGC_ACCELERATE              = $02039202; (* Accelerate *)
  {$EXTERNALSYM DIAXIS_DRIVINGC_ACCELERATE}
  DIAXIS_DRIVINGC_BRAKE                   = $02041203; (* Brake-axis *)
  {$EXTERNALSYM DIAXIS_DRIVINGC_BRAKE}
  DIBUTTON_DRIVINGC_FIRE                  = $02000C01; (* Fire *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_FIRE}
  DIBUTTON_DRIVINGC_WEAPONS               = $02000C02; (* Select next weapon *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_WEAPONS}
  DIBUTTON_DRIVINGC_TARGET                = $02000C03; (* Select next available target *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_TARGET}
  DIBUTTON_DRIVINGC_MENU                  = $020004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_MENU}
(*--- Priority 2 controls                            ---*)

  DIAXIS_DRIVINGC_ACCEL_AND_BRAKE         = $02014A04; (* Some devices combine accelerate and brake in a single axis *)
  {$EXTERNALSYM DIAXIS_DRIVINGC_ACCEL_AND_BRAKE}
  DIHATSWITCH_DRIVINGC_GLANCE             = $02004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_DRIVINGC_GLANCE}
  DIBUTTON_DRIVINGC_SHIFTUP               = $02004C04; (* Shift to next higher gear *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_SHIFTUP}
  DIBUTTON_DRIVINGC_SHIFTDOWN             = $02004C05; (* Shift to next lower gear *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_SHIFTDOWN}
  DIBUTTON_DRIVINGC_DASHBOARD             = $02004406; (* Select next dashboard option *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_DASHBOARD}
  DIBUTTON_DRIVINGC_AIDS                  = $02004407; (* Driver correction aids *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_AIDS}
  DIBUTTON_DRIVINGC_BRAKE                 = $02004C08; (* Brake-button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_BRAKE}
  DIBUTTON_DRIVINGC_FIRESECONDARY         = $02004C09; (* Alternative fire button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_FIRESECONDARY}
  DIBUTTON_DRIVINGC_ACCELERATE_LINK       = $0203D4E0; (* Fallback Accelerate button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_ACCELERATE_LINK}
  DIBUTTON_DRIVINGC_STEER_LEFT_LINK       = $0200CCE4; (* Fallback Steer Left button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_STEER_LEFT_LINK}
  DIBUTTON_DRIVINGC_STEER_RIGHT_LINK      = $0200CCEC; (* Fallback Steer Right button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_STEER_RIGHT_LINK}
  DIBUTTON_DRIVINGC_GLANCE_LEFT_LINK      = $0207C4E4; (* Fallback Glance Left button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_GLANCE_LEFT_LINK}
  DIBUTTON_DRIVINGC_GLANCE_RIGHT_LINK     = $0207C4EC; (* Fallback Glance Right button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_GLANCE_RIGHT_LINK}
  DIBUTTON_DRIVINGC_DEVICE                = $020044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_DEVICE}
  DIBUTTON_DRIVINGC_PAUSE                 = $020044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_DRIVINGC_PAUSE}

(*--- Driving Simulator - Tank
      Combat from withing a tank is primary objective  ---*)
  DIVIRTUAL_DRIVING_TANK                  = $03000000;
  {$EXTERNALSYM DIVIRTUAL_DRIVING_TANK}
  DIAXIS_DRIVINGT_STEER                   = $03008A01; (* Turn tank left / right *)
  {$EXTERNALSYM DIAXIS_DRIVINGT_STEER}
  DIAXIS_DRIVINGT_BARREL                  = $03010202; (* Raise / lower barrel *)
  {$EXTERNALSYM DIAXIS_DRIVINGT_BARREL}
  DIAXIS_DRIVINGT_ACCELERATE              = $03039203; (* Accelerate *)
  {$EXTERNALSYM DIAXIS_DRIVINGT_ACCELERATE}
  DIAXIS_DRIVINGT_ROTATE                  = $03020204; (* Turn barrel left / right *)
  {$EXTERNALSYM DIAXIS_DRIVINGT_ROTATE}
  DIBUTTON_DRIVINGT_FIRE                  = $03000C01; (* Fire *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_FIRE}
  DIBUTTON_DRIVINGT_WEAPONS               = $03000C02; (* Select next weapon *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_WEAPONS}
  DIBUTTON_DRIVINGT_TARGET                = $03000C03; (* Selects next available target *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_TARGET}
  DIBUTTON_DRIVINGT_MENU                  = $030004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_DRIVINGT_GLANCE             = $03004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_DRIVINGT_GLANCE}
  DIAXIS_DRIVINGT_BRAKE                   = $03045205; (* Brake-axis *)
  {$EXTERNALSYM DIAXIS_DRIVINGT_BRAKE}
  DIAXIS_DRIVINGT_ACCEL_AND_BRAKE         = $03014A06; (* Some devices combine accelerate and brake in a single axis *)
  {$EXTERNALSYM DIAXIS_DRIVINGT_ACCEL_AND_BRAKE}
  DIBUTTON_DRIVINGT_VIEW                  = $03005C04; (* Cycle through view options *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_VIEW}
  DIBUTTON_DRIVINGT_DASHBOARD             = $03005C05; (* Select next dashboard option *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_DASHBOARD}
  DIBUTTON_DRIVINGT_BRAKE                 = $03004C06; (* Brake-button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_BRAKE}
  DIBUTTON_DRIVINGT_FIRESECONDARY         = $03004C07; (* Alternative fire button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_FIRESECONDARY}
  DIBUTTON_DRIVINGT_ACCELERATE_LINK       = $0303D4E0; (* Fallback Accelerate button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_ACCELERATE_LINK}
  DIBUTTON_DRIVINGT_STEER_LEFT_LINK       = $0300CCE4; (* Fallback Steer Left button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_STEER_LEFT_LINK}
  DIBUTTON_DRIVINGT_STEER_RIGHT_LINK      = $0300CCEC; (* Fallback Steer Right button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_STEER_RIGHT_LINK}
  DIBUTTON_DRIVINGT_BARREL_UP_LINK        = $030144E0; (* Fallback Barrel up button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_BARREL_UP_LINK}
  DIBUTTON_DRIVINGT_BARREL_DOWN_LINK      = $030144E8; (* Fallback Barrel down button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_BARREL_DOWN_LINK}
  DIBUTTON_DRIVINGT_ROTATE_LEFT_LINK      = $030244E4; (* Fallback Rotate left button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_ROTATE_LEFT_LINK}
  DIBUTTON_DRIVINGT_ROTATE_RIGHT_LINK     = $030244EC; (* Fallback Rotate right button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_ROTATE_RIGHT_LINK}
  DIBUTTON_DRIVINGT_GLANCE_LEFT_LINK      = $0307C4E4; (* Fallback Glance Left button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_GLANCE_LEFT_LINK}
  DIBUTTON_DRIVINGT_GLANCE_RIGHT_LINK     = $0307C4EC; (* Fallback Glance Right button *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_GLANCE_RIGHT_LINK}
  DIBUTTON_DRIVINGT_DEVICE                = $030044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_DEVICE}
  DIBUTTON_DRIVINGT_PAUSE                 = $030044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_DRIVINGT_PAUSE}

(*--- Flight Simulator - Civilian
      Plane control is the primary objective  ---*)
  DIVIRTUAL_FLYING_CIVILIAN               = $04000000;
  {$EXTERNALSYM DIVIRTUAL_FLYING_CIVILIAN}
  DIAXIS_FLYINGC_BANK                     = $04008A01; (* Roll ship left / right *)
  {$EXTERNALSYM DIAXIS_FLYINGC_BANK}
  DIAXIS_FLYINGC_PITCH                    = $04010A02; (* Nose up / down *)
  {$EXTERNALSYM DIAXIS_FLYINGC_PITCH}
  DIAXIS_FLYINGC_THROTTLE                 = $04039203; (* Throttle *)
  {$EXTERNALSYM DIAXIS_FLYINGC_THROTTLE}
  DIBUTTON_FLYINGC_VIEW                   = $04002401; (* Cycle through view options *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_VIEW}
  DIBUTTON_FLYINGC_DISPLAY                = $04002402; (* Select next dashboard / heads up display option *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_DISPLAY}
  DIBUTTON_FLYINGC_GEAR                   = $04002C03; (* Gear up / down *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_GEAR}
  DIBUTTON_FLYINGC_MENU                   = $040004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_FLYINGC_GLANCE              = $04004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_FLYINGC_GLANCE}
  DIAXIS_FLYINGC_BRAKE                    = $04046A04; (* Apply Brake *)
  {$EXTERNALSYM DIAXIS_FLYINGC_BRAKE}
  DIAXIS_FLYINGC_RUDDER                   = $04025205; (* Yaw ship left/right *)
  {$EXTERNALSYM DIAXIS_FLYINGC_RUDDER}
  DIAXIS_FLYINGC_FLAPS                    = $04055A06; (* Flaps *)
  {$EXTERNALSYM DIAXIS_FLYINGC_FLAPS}
  DIBUTTON_FLYINGC_FLAPSUP                = $04006404; (* Increment stepping up until fully retracted *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_FLAPSUP}
  DIBUTTON_FLYINGC_FLAPSDOWN              = $04006405; (* Decrement stepping down until fully extended *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_FLAPSDOWN}
  DIBUTTON_FLYINGC_BRAKE_LINK             = $04046CE0; (* Fallback brake button *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_BRAKE_LINK}
  DIBUTTON_FLYINGC_FASTER_LINK            = $0403D4E0; (* Fallback throttle up button *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_FASTER_LINK}
  DIBUTTON_FLYINGC_SLOWER_LINK            = $0403D4E8; (* Fallback throttle down button *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_SLOWER_LINK}
  DIBUTTON_FLYINGC_GLANCE_LEFT_LINK       = $0407C4E4; (* Fallback Glance Left button *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_GLANCE_LEFT_LINK}
  DIBUTTON_FLYINGC_GLANCE_RIGHT_LINK      = $0407C4EC; (* Fallback Glance Right button *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_GLANCE_RIGHT_LINK}
  DIBUTTON_FLYINGC_GLANCE_UP_LINK         = $0407C4E0; (* Fallback Glance Up button *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_GLANCE_UP_LINK}
  DIBUTTON_FLYINGC_GLANCE_DOWN_LINK       = $0407C4E8; (* Fallback Glance Down button *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_GLANCE_DOWN_LINK}
  DIBUTTON_FLYINGC_DEVICE                 = $040044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_DEVICE}
  DIBUTTON_FLYINGC_PAUSE                  = $040044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_FLYINGC_PAUSE}

(*--- Flight Simulator - Military
      Aerial combat is the primary objective  ---*)
  DIVIRTUAL_FLYING_MILITARY               = $05000000;
  {$EXTERNALSYM DIVIRTUAL_FLYING_MILITARY}
  DIAXIS_FLYINGM_BANK                     = $05008A01; (* Bank - Roll ship left / right *)
  {$EXTERNALSYM DIAXIS_FLYINGM_BANK}
  DIAXIS_FLYINGM_PITCH                    = $05010A02; (* Pitch - Nose up / down *)
  {$EXTERNALSYM DIAXIS_FLYINGM_PITCH}
  DIAXIS_FLYINGM_THROTTLE                 = $05039203; (* Throttle - faster / slower *)
  {$EXTERNALSYM DIAXIS_FLYINGM_THROTTLE}
  DIBUTTON_FLYINGM_FIRE                   = $05000C01; (* Fire *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_FIRE}
  DIBUTTON_FLYINGM_WEAPONS                = $05000C02; (* Select next weapon *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_WEAPONS}
  DIBUTTON_FLYINGM_TARGET                 = $05000C03; (* Selects next available target *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_TARGET}
  DIBUTTON_FLYINGM_MENU                   = $050004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_FLYINGM_GLANCE              = $05004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_FLYINGM_GLANCE}
  DIBUTTON_FLYINGM_COUNTER                = $05005C04; (* Activate counter measures *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_COUNTER}
  DIAXIS_FLYINGM_RUDDER                   = $05024A04; (* Rudder - Yaw ship left/right *)
  {$EXTERNALSYM DIAXIS_FLYINGM_RUDDER}
  DIAXIS_FLYINGM_BRAKE                    = $05046205; (* Brake-axis *)
  {$EXTERNALSYM DIAXIS_FLYINGM_BRAKE}
  DIBUTTON_FLYINGM_VIEW                   = $05006405; (* Cycle through view options *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_VIEW}
  DIBUTTON_FLYINGM_DISPLAY                = $05006406; (* Select next dashboard option *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_DISPLAY}
  DIAXIS_FLYINGM_FLAPS                    = $05055206; (* Flaps *)
  {$EXTERNALSYM DIAXIS_FLYINGM_FLAPS}
  DIBUTTON_FLYINGM_FLAPSUP                = $05005407; (* Increment stepping up until fully retracted *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_FLAPSUP}
  DIBUTTON_FLYINGM_FLAPSDOWN              = $05005408; (* Decrement stepping down until fully extended *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_FLAPSDOWN}
  DIBUTTON_FLYINGM_FIRESECONDARY          = $05004C09; (* Alternative fire button *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_FIRESECONDARY}
  DIBUTTON_FLYINGM_GEAR                   = $0500640A; (* Gear up / down *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_GEAR}
  DIBUTTON_FLYINGM_BRAKE_LINK             = $050464E0; (* Fallback brake button *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_BRAKE_LINK}
  DIBUTTON_FLYINGM_FASTER_LINK            = $0503D4E0; (* Fallback throttle up button *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_FASTER_LINK}
  DIBUTTON_FLYINGM_SLOWER_LINK            = $0503D4E8; (* Fallback throttle down button *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_SLOWER_LINK}
  DIBUTTON_FLYINGM_GLANCE_LEFT_LINK       = $0507C4E4; (* Fallback Glance Left button *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_GLANCE_LEFT_LINK}
  DIBUTTON_FLYINGM_GLANCE_RIGHT_LINK      = $0507C4EC; (* Fallback Glance Right button *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_GLANCE_RIGHT_LINK}
  DIBUTTON_FLYINGM_GLANCE_UP_LINK         = $0507C4E0; (* Fallback Glance Up button *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_GLANCE_UP_LINK}
  DIBUTTON_FLYINGM_GLANCE_DOWN_LINK       = $0507C4E8; (* Fallback Glance Down button *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_GLANCE_DOWN_LINK}
  DIBUTTON_FLYINGM_DEVICE                 = $050044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_DEVICE}
  DIBUTTON_FLYINGM_PAUSE                  = $050044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_FLYINGM_PAUSE}

(*--- Flight Simulator - Combat Helicopter
      Combat from helicopter is primary objective  ---*)
  DIVIRTUAL_FLYING_HELICOPTER             = $06000000;
  {$EXTERNALSYM DIVIRTUAL_FLYING_HELICOPTER}
  DIAXIS_FLYINGH_BANK                     = $06008A01; (* Bank - Roll ship left / right *)
  {$EXTERNALSYM DIAXIS_FLYINGH_BANK}
  DIAXIS_FLYINGH_PITCH                    = $06010A02; (* Pitch - Nose up / down *)
  {$EXTERNALSYM DIAXIS_FLYINGH_PITCH}
  DIAXIS_FLYINGH_COLLECTIVE               = $06018A03; (* Collective - Blade pitch/power *)
  {$EXTERNALSYM DIAXIS_FLYINGH_COLLECTIVE}
  DIBUTTON_FLYINGH_FIRE                   = $06001401; (* Fire *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_FIRE}
  DIBUTTON_FLYINGH_WEAPONS                = $06001402; (* Select next weapon *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_WEAPONS}
  DIBUTTON_FLYINGH_TARGET                 = $06001403; (* Selects next available target *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_TARGET}
  DIBUTTON_FLYINGH_MENU                   = $060004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_FLYINGH_GLANCE              = $06004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_FLYINGH_GLANCE}
  DIAXIS_FLYINGH_TORQUE                   = $06025A04; (* Torque - Rotate ship around left / right axis *)
  {$EXTERNALSYM DIAXIS_FLYINGH_TORQUE}
  DIAXIS_FLYINGH_THROTTLE                 = $0603DA05; (* Throttle *)
  {$EXTERNALSYM DIAXIS_FLYINGH_THROTTLE}
  DIBUTTON_FLYINGH_COUNTER                = $06005404; (* Activate counter measures *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_COUNTER}
  DIBUTTON_FLYINGH_VIEW                   = $06006405; (* Cycle through view options *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_VIEW}
  DIBUTTON_FLYINGH_GEAR                   = $06006406; (* Gear up / down *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_GEAR}
  DIBUTTON_FLYINGH_FIRESECONDARY          = $06004C07; (* Alternative fire button *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_FIRESECONDARY}
  DIBUTTON_FLYINGH_FASTER_LINK            = $0603DCE0; (* Fallback throttle up button *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_FASTER_LINK}
  DIBUTTON_FLYINGH_SLOWER_LINK            = $0603DCE8; (* Fallback throttle down button *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_SLOWER_LINK}
  DIBUTTON_FLYINGH_GLANCE_LEFT_LINK       = $0607C4E4; (* Fallback Glance Left button *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_GLANCE_LEFT_LINK}
  DIBUTTON_FLYINGH_GLANCE_RIGHT_LINK      = $0607C4EC; (* Fallback Glance Right button *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_GLANCE_RIGHT_LINK}
  DIBUTTON_FLYINGH_GLANCE_UP_LINK         = $0607C4E0; (* Fallback Glance Up button *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_GLANCE_UP_LINK}
  DIBUTTON_FLYINGH_GLANCE_DOWN_LINK       = $0607C4E8; (* Fallback Glance Down button *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_GLANCE_DOWN_LINK}
  DIBUTTON_FLYINGH_DEVICE                 = $060044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_DEVICE}
  DIBUTTON_FLYINGH_PAUSE                  = $060044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_FLYINGH_PAUSE}

(*--- Space Simulator - Combat
      Space Simulator with weapons  ---*)
  DIVIRTUAL_SPACESIM                      = $07000000;
  {$EXTERNALSYM DIVIRTUAL_SPACESIM}
  DIAXIS_SPACESIM_LATERAL                 = $07008201; (* Move ship left / right *)
  {$EXTERNALSYM DIAXIS_SPACESIM_LATERAL}
  DIAXIS_SPACESIM_MOVE                    = $07010202; (* Move ship forward/backward *)
  {$EXTERNALSYM DIAXIS_SPACESIM_MOVE}
  DIAXIS_SPACESIM_THROTTLE                = $07038203; (* Throttle - Engine speed *)
  {$EXTERNALSYM DIAXIS_SPACESIM_THROTTLE}
  DIBUTTON_SPACESIM_FIRE                  = $07000401; (* Fire *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_FIRE}
  DIBUTTON_SPACESIM_WEAPONS               = $07000402; (* Select next weapon *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_WEAPONS}
  DIBUTTON_SPACESIM_TARGET                = $07000403; (* Selects next available target *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_TARGET}
  DIBUTTON_SPACESIM_MENU                  = $070004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_SPACESIM_GLANCE             = $07004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_SPACESIM_GLANCE}
  DIAXIS_SPACESIM_CLIMB                   = $0701C204; (* Climb - Pitch ship up/down *)
  {$EXTERNALSYM DIAXIS_SPACESIM_CLIMB}
  DIAXIS_SPACESIM_ROTATE                  = $07024205; (* Rotate - Turn ship left/right *)
  {$EXTERNALSYM DIAXIS_SPACESIM_ROTATE}
  DIBUTTON_SPACESIM_VIEW                  = $07004404; (* Cycle through view options *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_VIEW}
  DIBUTTON_SPACESIM_DISPLAY               = $07004405; (* Select next dashboard / heads up display option *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_DISPLAY}
  DIBUTTON_SPACESIM_RAISE                 = $07004406; (* Raise ship while maintaining current pitch *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_RAISE}
  DIBUTTON_SPACESIM_LOWER                 = $07004407; (* Lower ship while maintaining current pitch *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_LOWER}
  DIBUTTON_SPACESIM_GEAR                  = $07004408; (* Gear up / down *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_GEAR}
  DIBUTTON_SPACESIM_FIRESECONDARY         = $07004409; (* Alternative fire button *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_FIRESECONDARY}
  DIBUTTON_SPACESIM_LEFT_LINK             = $0700C4E4; (* Fallback move left button *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_LEFT_LINK}
  DIBUTTON_SPACESIM_RIGHT_LINK            = $0700C4EC; (* Fallback move right button *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_RIGHT_LINK}
  DIBUTTON_SPACESIM_FORWARD_LINK          = $070144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_FORWARD_LINK}
  DIBUTTON_SPACESIM_BACKWARD_LINK         = $070144E8; (* Fallback move backwards button *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_BACKWARD_LINK}
  DIBUTTON_SPACESIM_FASTER_LINK           = $0703C4E0; (* Fallback throttle up button *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_FASTER_LINK}
  DIBUTTON_SPACESIM_SLOWER_LINK           = $0703C4E8; (* Fallback throttle down button *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_SLOWER_LINK}
  DIBUTTON_SPACESIM_TURN_LEFT_LINK        = $070244E4; (* Fallback turn left button *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_TURN_LEFT_LINK}
  DIBUTTON_SPACESIM_TURN_RIGHT_LINK       = $070244EC; (* Fallback turn right button *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_TURN_RIGHT_LINK}
  DIBUTTON_SPACESIM_GLANCE_LEFT_LINK      = $0707C4E4; (* Fallback Glance Left button *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_GLANCE_LEFT_LINK}
  DIBUTTON_SPACESIM_GLANCE_RIGHT_LINK     = $0707C4EC; (* Fallback Glance Right button *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_GLANCE_RIGHT_LINK}
  DIBUTTON_SPACESIM_GLANCE_UP_LINK        = $0707C4E0; (* Fallback Glance Up button *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_GLANCE_UP_LINK}
  DIBUTTON_SPACESIM_GLANCE_DOWN_LINK      = $0707C4E8; (* Fallback Glance Down button *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_GLANCE_DOWN_LINK}
  DIBUTTON_SPACESIM_DEVICE                = $070044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_DEVICE}
  DIBUTTON_SPACESIM_PAUSE                 = $070044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_SPACESIM_PAUSE}

(*--- Fighting - First Person
      Hand to Hand combat is primary objective  ---*)
  DIVIRTUAL_FIGHTING_HAND2HAND            = $08000000;
  {$EXTERNALSYM DIVIRTUAL_FIGHTING_HAND2HAND}
  DIAXIS_FIGHTINGH_LATERAL                = $08008201; (* Sidestep left/right *)
  {$EXTERNALSYM DIAXIS_FIGHTINGH_LATERAL}
  DIAXIS_FIGHTINGH_MOVE                   = $08010202; (* Move forward/backward *)
  {$EXTERNALSYM DIAXIS_FIGHTINGH_MOVE}
  DIBUTTON_FIGHTINGH_PUNCH                = $08000401; (* Punch *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_PUNCH}
  DIBUTTON_FIGHTINGH_KICK                 = $08000402; (* Kick *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_KICK}
  DIBUTTON_FIGHTINGH_BLOCK                = $08000403; (* Block *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_BLOCK}
  DIBUTTON_FIGHTINGH_CROUCH               = $08000404; (* Crouch *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_CROUCH}
  DIBUTTON_FIGHTINGH_JUMP                 = $08000405; (* Jump *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_JUMP}
  DIBUTTON_FIGHTINGH_SPECIAL1             = $08000406; (* Apply first special move *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_SPECIAL1}
  DIBUTTON_FIGHTINGH_SPECIAL2             = $08000407; (* Apply second special move *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_SPECIAL2}
  DIBUTTON_FIGHTINGH_MENU                 = $080004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_MENU}
(*--- Priority 2 controls                            ---*)

  DIBUTTON_FIGHTINGH_SELECT               = $08004408; (* Select special move *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_SELECT}
  DIHATSWITCH_FIGHTINGH_SLIDE             = $08004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_FIGHTINGH_SLIDE}
  DIBUTTON_FIGHTINGH_DISPLAY              = $08004409; (* Shows next on-screen display option *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_DISPLAY}
  DIAXIS_FIGHTINGH_ROTATE                 = $08024203; (* Rotate - Turn body left/right *)
  {$EXTERNALSYM DIAXIS_FIGHTINGH_ROTATE}
  DIBUTTON_FIGHTINGH_DODGE                = $0800440A; (* Dodge *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_DODGE}
  DIBUTTON_FIGHTINGH_LEFT_LINK            = $0800C4E4; (* Fallback left sidestep button *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_LEFT_LINK}
  DIBUTTON_FIGHTINGH_RIGHT_LINK           = $0800C4EC; (* Fallback right sidestep button *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_RIGHT_LINK}
  DIBUTTON_FIGHTINGH_FORWARD_LINK         = $080144E0; (* Fallback forward button *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_FORWARD_LINK}
  DIBUTTON_FIGHTINGH_BACKWARD_LINK        = $080144E8; (* Fallback backward button *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_BACKWARD_LINK}
  DIBUTTON_FIGHTINGH_DEVICE               = $080044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_DEVICE}
  DIBUTTON_FIGHTINGH_PAUSE                = $080044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_FIGHTINGH_PAUSE}

(*--- Fighting - First Person Shooting
      Navigation and combat are primary objectives  ---*)
  DIVIRTUAL_FIGHTING_FPS                  = $09000000;
  {$EXTERNALSYM DIVIRTUAL_FIGHTING_FPS}
  DIAXIS_FPS_ROTATE                       = $09008201; (* Rotate character left/right *)
  {$EXTERNALSYM DIAXIS_FPS_ROTATE}
  DIAXIS_FPS_MOVE                         = $09010202; (* Move forward/backward *)
  {$EXTERNALSYM DIAXIS_FPS_MOVE}
  DIBUTTON_FPS_FIRE                       = $09000401; (* Fire *)
  {$EXTERNALSYM DIBUTTON_FPS_FIRE}
  DIBUTTON_FPS_WEAPONS                    = $09000402; (* Select next weapon *)
  {$EXTERNALSYM DIBUTTON_FPS_WEAPONS}
  DIBUTTON_FPS_APPLY                      = $09000403; (* Use item *)
  {$EXTERNALSYM DIBUTTON_FPS_APPLY}
  DIBUTTON_FPS_SELECT                     = $09000404; (* Select next inventory item *)
  {$EXTERNALSYM DIBUTTON_FPS_SELECT}
  DIBUTTON_FPS_CROUCH                     = $09000405; (* Crouch/ climb down/ swim down *)
  {$EXTERNALSYM DIBUTTON_FPS_CROUCH}
  DIBUTTON_FPS_JUMP                       = $09000406; (* Jump/ climb up/ swim up *)
  {$EXTERNALSYM DIBUTTON_FPS_JUMP}
  DIAXIS_FPS_LOOKUPDOWN                   = $09018203; (* Look up / down  *)
  {$EXTERNALSYM DIAXIS_FPS_LOOKUPDOWN}
  DIBUTTON_FPS_STRAFE                     = $09000407; (* Enable strafing while active *)
  {$EXTERNALSYM DIBUTTON_FPS_STRAFE}
  DIBUTTON_FPS_MENU                       = $090004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_FPS_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_FPS_GLANCE                  = $09004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_FPS_GLANCE}
  DIBUTTON_FPS_DISPLAY                    = $09004408; (* Shows next on-screen display option/ map *)
  {$EXTERNALSYM DIBUTTON_FPS_DISPLAY}
  DIAXIS_FPS_SIDESTEP                     = $09024204; (* Sidestep *)
  {$EXTERNALSYM DIAXIS_FPS_SIDESTEP}
  DIBUTTON_FPS_DODGE                      = $09004409; (* Dodge *)
  {$EXTERNALSYM DIBUTTON_FPS_DODGE}
  DIBUTTON_FPS_GLANCEL                    = $0900440A; (* Glance Left *)
  {$EXTERNALSYM DIBUTTON_FPS_GLANCEL}
  DIBUTTON_FPS_GLANCER                    = $0900440B; (* Glance Right *)
  {$EXTERNALSYM DIBUTTON_FPS_GLANCER}
  DIBUTTON_FPS_FIRESECONDARY              = $0900440C; (* Alternative fire button *)
  {$EXTERNALSYM DIBUTTON_FPS_FIRESECONDARY}
  DIBUTTON_FPS_ROTATE_LEFT_LINK           = $0900C4E4; (* Fallback rotate left button *)
  {$EXTERNALSYM DIBUTTON_FPS_ROTATE_LEFT_LINK}
  DIBUTTON_FPS_ROTATE_RIGHT_LINK          = $0900C4EC; (* Fallback rotate right button *)
  {$EXTERNALSYM DIBUTTON_FPS_ROTATE_RIGHT_LINK}
  DIBUTTON_FPS_FORWARD_LINK               = $090144E0; (* Fallback forward button *)
  {$EXTERNALSYM DIBUTTON_FPS_FORWARD_LINK}
  DIBUTTON_FPS_BACKWARD_LINK              = $090144E8; (* Fallback backward button *)
  {$EXTERNALSYM DIBUTTON_FPS_BACKWARD_LINK}
  DIBUTTON_FPS_GLANCE_UP_LINK             = $0901C4E0; (* Fallback look up button *)
  {$EXTERNALSYM DIBUTTON_FPS_GLANCE_UP_LINK}
  DIBUTTON_FPS_GLANCE_DOWN_LINK           = $0901C4E8; (* Fallback look down button *)
  {$EXTERNALSYM DIBUTTON_FPS_GLANCE_DOWN_LINK}
  DIBUTTON_FPS_STEP_LEFT_LINK             = $090244E4; (* Fallback step left button *)
  {$EXTERNALSYM DIBUTTON_FPS_STEP_LEFT_LINK}
  DIBUTTON_FPS_STEP_RIGHT_LINK            = $090244EC; (* Fallback step right button *)
  {$EXTERNALSYM DIBUTTON_FPS_STEP_RIGHT_LINK}
  DIBUTTON_FPS_DEVICE                     = $090044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_FPS_DEVICE}
  DIBUTTON_FPS_PAUSE                      = $090044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_FPS_PAUSE}

(*--- Fighting - Third Person action
      Perspective of camera is behind the main character  ---*)
  DIVIRTUAL_FIGHTING_THIRDPERSON          = $0A000000;
  {$EXTERNALSYM DIVIRTUAL_FIGHTING_THIRDPERSON}
  DIAXIS_TPS_TURN                         = $0A020201; (* Turn left/right *)
  {$EXTERNALSYM DIAXIS_TPS_TURN}
  DIAXIS_TPS_MOVE                         = $0A010202; (* Move forward/backward *)
  {$EXTERNALSYM DIAXIS_TPS_MOVE}
  DIBUTTON_TPS_RUN                        = $0A000401; (* Run or walk toggle switch *)
  {$EXTERNALSYM DIBUTTON_TPS_RUN}
  DIBUTTON_TPS_ACTION                     = $0A000402; (* Action Button *)
  {$EXTERNALSYM DIBUTTON_TPS_ACTION}
  DIBUTTON_TPS_SELECT                     = $0A000403; (* Select next weapon *)
  {$EXTERNALSYM DIBUTTON_TPS_SELECT}
  DIBUTTON_TPS_USE                        = $0A000404; (* Use inventory item currently selected *)
  {$EXTERNALSYM DIBUTTON_TPS_USE}
  DIBUTTON_TPS_JUMP                       = $0A000405; (* Character Jumps *)
  {$EXTERNALSYM DIBUTTON_TPS_JUMP}
  DIBUTTON_TPS_MENU                       = $0A0004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_TPS_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_TPS_GLANCE                  = $0A004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_TPS_GLANCE}
  DIBUTTON_TPS_VIEW                       = $0A004406; (* Select camera view *)
  {$EXTERNALSYM DIBUTTON_TPS_VIEW}
  DIBUTTON_TPS_STEPLEFT                   = $0A004407; (* Character takes a left step *)
  {$EXTERNALSYM DIBUTTON_TPS_STEPLEFT}
  DIBUTTON_TPS_STEPRIGHT                  = $0A004408; (* Character takes a right step *)
  {$EXTERNALSYM DIBUTTON_TPS_STEPRIGHT}
  DIAXIS_TPS_STEP                         = $0A00C203; (* Character steps left/right *)
  {$EXTERNALSYM DIAXIS_TPS_STEP}
  DIBUTTON_TPS_DODGE                      = $0A004409; (* Character dodges or ducks *)
  {$EXTERNALSYM DIBUTTON_TPS_DODGE}
  DIBUTTON_TPS_INVENTORY                  = $0A00440A; (* Cycle through inventory *)
  {$EXTERNALSYM DIBUTTON_TPS_INVENTORY}
  DIBUTTON_TPS_TURN_LEFT_LINK             = $0A0244E4; (* Fallback turn left button *)
  {$EXTERNALSYM DIBUTTON_TPS_TURN_LEFT_LINK}
  DIBUTTON_TPS_TURN_RIGHT_LINK            = $0A0244EC; (* Fallback turn right button *)
  {$EXTERNALSYM DIBUTTON_TPS_TURN_RIGHT_LINK}
  DIBUTTON_TPS_FORWARD_LINK               = $0A0144E0; (* Fallback forward button *)
  {$EXTERNALSYM DIBUTTON_TPS_FORWARD_LINK}
  DIBUTTON_TPS_BACKWARD_LINK              = $0A0144E8; (* Fallback backward button *)
  {$EXTERNALSYM DIBUTTON_TPS_BACKWARD_LINK}
  DIBUTTON_TPS_GLANCE_UP_LINK             = $0A07C4E0; (* Fallback look up button *)
  {$EXTERNALSYM DIBUTTON_TPS_GLANCE_UP_LINK}
  DIBUTTON_TPS_GLANCE_DOWN_LINK           = $0A07C4E8; (* Fallback look down button *)
  {$EXTERNALSYM DIBUTTON_TPS_GLANCE_DOWN_LINK}
  DIBUTTON_TPS_GLANCE_LEFT_LINK           = $0A07C4E4; (* Fallback glance up button *)
  {$EXTERNALSYM DIBUTTON_TPS_GLANCE_LEFT_LINK}
  DIBUTTON_TPS_GLANCE_RIGHT_LINK          = $0A07C4EC; (* Fallback glance right button *)
  {$EXTERNALSYM DIBUTTON_TPS_GLANCE_RIGHT_LINK}
  DIBUTTON_TPS_DEVICE                     = $0A0044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_TPS_DEVICE}
  DIBUTTON_TPS_PAUSE                      = $0A0044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_TPS_PAUSE}

(*--- Strategy - Role Playing
      Navigation and problem solving are primary actions  ---*)
  DIVIRTUAL_STRATEGY_ROLEPLAYING          = $0B000000;
  {$EXTERNALSYM DIVIRTUAL_STRATEGY_ROLEPLAYING}
  DIAXIS_STRATEGYR_LATERAL                = $0B008201; (* sidestep - left/right *)
  {$EXTERNALSYM DIAXIS_STRATEGYR_LATERAL}
  DIAXIS_STRATEGYR_MOVE                   = $0B010202; (* move forward/backward *)
  {$EXTERNALSYM DIAXIS_STRATEGYR_MOVE}
  DIBUTTON_STRATEGYR_GET                  = $0B000401; (* Acquire item *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_GET}
  DIBUTTON_STRATEGYR_APPLY                = $0B000402; (* Use selected item *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_APPLY}
  DIBUTTON_STRATEGYR_SELECT               = $0B000403; (* Select nextitem *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_SELECT}
  DIBUTTON_STRATEGYR_ATTACK               = $0B000404; (* Attack *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_ATTACK}
  DIBUTTON_STRATEGYR_CAST                 = $0B000405; (* Cast Spell *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_CAST}
  DIBUTTON_STRATEGYR_CROUCH               = $0B000406; (* Crouch *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_CROUCH}
  DIBUTTON_STRATEGYR_JUMP                 = $0B000407; (* Jump *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_JUMP}
  DIBUTTON_STRATEGYR_MENU                 = $0B0004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_STRATEGYR_GLANCE            = $0B004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_STRATEGYR_GLANCE}
  DIBUTTON_STRATEGYR_MAP                  = $0B004408; (* Cycle through map options *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_MAP}
  DIBUTTON_STRATEGYR_DISPLAY              = $0B004409; (* Shows next on-screen display option *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_DISPLAY}
  DIAXIS_STRATEGYR_ROTATE                 = $0B024203; (* Turn body left/right *)
  {$EXTERNALSYM DIAXIS_STRATEGYR_ROTATE}
  DIBUTTON_STRATEGYR_LEFT_LINK            = $0B00C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_LEFT_LINK}
  DIBUTTON_STRATEGYR_RIGHT_LINK           = $0B00C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_RIGHT_LINK}
  DIBUTTON_STRATEGYR_FORWARD_LINK         = $0B0144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_FORWARD_LINK}
  DIBUTTON_STRATEGYR_BACK_LINK            = $0B0144E8; (* Fallback move backward button *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_BACK_LINK}
  DIBUTTON_STRATEGYR_ROTATE_LEFT_LINK     = $0B0244E4; (* Fallback turn body left button *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_ROTATE_LEFT_LINK}
  DIBUTTON_STRATEGYR_ROTATE_RIGHT_LINK    = $0B0244EC; (* Fallback turn body right button *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_ROTATE_RIGHT_LINK}
  DIBUTTON_STRATEGYR_DEVICE               = $0B0044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_DEVICE}
  DIBUTTON_STRATEGYR_PAUSE                = $0B0044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_STRATEGYR_PAUSE}

(*--- Strategy - Turn based
      Navigation and problem solving are primary actions  ---*)
  DIVIRTUAL_STRATEGY_TURN                 = $0C000000;
  {$EXTERNALSYM DIVIRTUAL_STRATEGY_TURN}
  DIAXIS_STRATEGYT_LATERAL                = $0C008201; (* Sidestep left/right *)
  {$EXTERNALSYM DIAXIS_STRATEGYT_LATERAL}
  DIAXIS_STRATEGYT_MOVE                   = $0C010202; (* Move forward/backwards *)
  {$EXTERNALSYM DIAXIS_STRATEGYT_MOVE}
  DIBUTTON_STRATEGYT_SELECT               = $0C000401; (* Select unit or object *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_SELECT}
  DIBUTTON_STRATEGYT_INSTRUCT             = $0C000402; (* Cycle through instructions *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_INSTRUCT}
  DIBUTTON_STRATEGYT_APPLY                = $0C000403; (* Apply selected instruction *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_APPLY}
  DIBUTTON_STRATEGYT_TEAM                 = $0C000404; (* Select next team / cycle through all *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_TEAM}
  DIBUTTON_STRATEGYT_TURN                 = $0C000405; (* Indicate turn over *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_TURN}
  DIBUTTON_STRATEGYT_MENU                 = $0C0004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_MENU}
(*--- Priority 2 controls                            ---*)

  DIBUTTON_STRATEGYT_ZOOM                 = $0C004406; (* Zoom - in / out *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_ZOOM}
  DIBUTTON_STRATEGYT_MAP                  = $0C004407; (* cycle through map options *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_MAP}
  DIBUTTON_STRATEGYT_DISPLAY              = $0C004408; (* shows next on-screen display options *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_DISPLAY}
  DIBUTTON_STRATEGYT_LEFT_LINK            = $0C00C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_LEFT_LINK}
  DIBUTTON_STRATEGYT_RIGHT_LINK           = $0C00C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_RIGHT_LINK}
  DIBUTTON_STRATEGYT_FORWARD_LINK         = $0C0144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_FORWARD_LINK}
  DIBUTTON_STRATEGYT_BACK_LINK            = $0C0144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_BACK_LINK}
  DIBUTTON_STRATEGYT_DEVICE               = $0C0044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_DEVICE}
  DIBUTTON_STRATEGYT_PAUSE                = $0C0044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_STRATEGYT_PAUSE}

(*--- Sports - Hunting
      Hunting                ---*)
  DIVIRTUAL_SPORTS_HUNTING                = $0D000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_HUNTING}
  DIAXIS_HUNTING_LATERAL                  = $0D008201; (* sidestep left/right *)
  {$EXTERNALSYM DIAXIS_HUNTING_LATERAL}
  DIAXIS_HUNTING_MOVE                     = $0D010202; (* move forward/backwards *)
  {$EXTERNALSYM DIAXIS_HUNTING_MOVE}
  DIBUTTON_HUNTING_FIRE                   = $0D000401; (* Fire selected weapon *)
  {$EXTERNALSYM DIBUTTON_HUNTING_FIRE}
  DIBUTTON_HUNTING_AIM                    = $0D000402; (* Select aim/move *)
  {$EXTERNALSYM DIBUTTON_HUNTING_AIM}
  DIBUTTON_HUNTING_WEAPON                 = $0D000403; (* Select next weapon *)
  {$EXTERNALSYM DIBUTTON_HUNTING_WEAPON}
  DIBUTTON_HUNTING_BINOCULAR              = $0D000404; (* Look through Binoculars *)
  {$EXTERNALSYM DIBUTTON_HUNTING_BINOCULAR}
  DIBUTTON_HUNTING_CALL                   = $0D000405; (* Make animal call *)
  {$EXTERNALSYM DIBUTTON_HUNTING_CALL}
  DIBUTTON_HUNTING_MAP                    = $0D000406; (* View Map *)
  {$EXTERNALSYM DIBUTTON_HUNTING_MAP}
  DIBUTTON_HUNTING_SPECIAL                = $0D000407; (* Special game operation *)
  {$EXTERNALSYM DIBUTTON_HUNTING_SPECIAL}
  DIBUTTON_HUNTING_MENU                   = $0D0004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_HUNTING_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_HUNTING_GLANCE              = $0D004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_HUNTING_GLANCE}
  DIBUTTON_HUNTING_DISPLAY                = $0D004408; (* show next on-screen display option *)
  {$EXTERNALSYM DIBUTTON_HUNTING_DISPLAY}
  DIAXIS_HUNTING_ROTATE                   = $0D024203; (* Turn body left/right *)
  {$EXTERNALSYM DIAXIS_HUNTING_ROTATE}
  DIBUTTON_HUNTING_CROUCH                 = $0D004409; (* Crouch/ Climb / Swim down *)
  {$EXTERNALSYM DIBUTTON_HUNTING_CROUCH}
  DIBUTTON_HUNTING_JUMP                   = $0D00440A; (* Jump/ Climb up / Swim up *)
  {$EXTERNALSYM DIBUTTON_HUNTING_JUMP}
  DIBUTTON_HUNTING_FIRESECONDARY          = $0D00440B; (* Alternative fire button *)
  {$EXTERNALSYM DIBUTTON_HUNTING_FIRESECONDARY}
  DIBUTTON_HUNTING_LEFT_LINK              = $0D00C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_HUNTING_LEFT_LINK}
  DIBUTTON_HUNTING_RIGHT_LINK             = $0D00C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_HUNTING_RIGHT_LINK}
  DIBUTTON_HUNTING_FORWARD_LINK           = $0D0144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_HUNTING_FORWARD_LINK}
  DIBUTTON_HUNTING_BACK_LINK              = $0D0144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_HUNTING_BACK_LINK}
  DIBUTTON_HUNTING_ROTATE_LEFT_LINK       = $0D0244E4; (* Fallback turn body left button *)
  {$EXTERNALSYM DIBUTTON_HUNTING_ROTATE_LEFT_LINK}
  DIBUTTON_HUNTING_ROTATE_RIGHT_LINK      = $0D0244EC; (* Fallback turn body right button *)
  {$EXTERNALSYM DIBUTTON_HUNTING_ROTATE_RIGHT_LINK}
  DIBUTTON_HUNTING_DEVICE                 = $0D0044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_HUNTING_DEVICE}
  DIBUTTON_HUNTING_PAUSE                  = $0D0044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_HUNTING_PAUSE}

(*--- Sports - Fishing
      Catching Fish is primary objective   ---*)
  DIVIRTUAL_SPORTS_FISHING                = $0E000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_FISHING}
  DIAXIS_FISHING_LATERAL                  = $0E008201; (* sidestep left/right *)
  {$EXTERNALSYM DIAXIS_FISHING_LATERAL}
  DIAXIS_FISHING_MOVE                     = $0E010202; (* move forward/backwards *)
  {$EXTERNALSYM DIAXIS_FISHING_MOVE}
  DIBUTTON_FISHING_CAST                   = $0E000401; (* Cast line *)
  {$EXTERNALSYM DIBUTTON_FISHING_CAST}
  DIBUTTON_FISHING_TYPE                   = $0E000402; (* Select cast type *)
  {$EXTERNALSYM DIBUTTON_FISHING_TYPE}
  DIBUTTON_FISHING_BINOCULAR              = $0E000403; (* Look through Binocular *)
  {$EXTERNALSYM DIBUTTON_FISHING_BINOCULAR}
  DIBUTTON_FISHING_BAIT                   = $0E000404; (* Select type of Bait *)
  {$EXTERNALSYM DIBUTTON_FISHING_BAIT}
  DIBUTTON_FISHING_MAP                    = $0E000405; (* View Map *)
  {$EXTERNALSYM DIBUTTON_FISHING_MAP}
  DIBUTTON_FISHING_MENU                   = $0E0004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_FISHING_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_FISHING_GLANCE              = $0E004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_FISHING_GLANCE}
  DIBUTTON_FISHING_DISPLAY                = $0E004406; (* Show next on-screen display option *)
  {$EXTERNALSYM DIBUTTON_FISHING_DISPLAY}
  DIAXIS_FISHING_ROTATE                   = $0E024203; (* Turn character left / right *)
  {$EXTERNALSYM DIAXIS_FISHING_ROTATE}
  DIBUTTON_FISHING_CROUCH                 = $0E004407; (* Crouch/ Climb / Swim down *)
  {$EXTERNALSYM DIBUTTON_FISHING_CROUCH}
  DIBUTTON_FISHING_JUMP                   = $0E004408; (* Jump/ Climb up / Swim up *)
  {$EXTERNALSYM DIBUTTON_FISHING_JUMP}
  DIBUTTON_FISHING_LEFT_LINK              = $0E00C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_FISHING_LEFT_LINK}
  DIBUTTON_FISHING_RIGHT_LINK             = $0E00C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_FISHING_RIGHT_LINK}
  DIBUTTON_FISHING_FORWARD_LINK           = $0E0144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_FISHING_FORWARD_LINK}
  DIBUTTON_FISHING_BACK_LINK              = $0E0144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_FISHING_BACK_LINK}
  DIBUTTON_FISHING_ROTATE_LEFT_LINK       = $0E0244E4; (* Fallback turn body left button *)
  {$EXTERNALSYM DIBUTTON_FISHING_ROTATE_LEFT_LINK}
  DIBUTTON_FISHING_ROTATE_RIGHT_LINK      = $0E0244EC; (* Fallback turn body right button *)
  {$EXTERNALSYM DIBUTTON_FISHING_ROTATE_RIGHT_LINK}
  DIBUTTON_FISHING_DEVICE                 = $0E0044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_FISHING_DEVICE}
  DIBUTTON_FISHING_PAUSE                  = $0E0044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_FISHING_PAUSE}

(*--- Sports - Baseball - Batting
      Batter control is primary objective  ---*)
  DIVIRTUAL_SPORTS_BASEBALL_BAT           = $0F000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_BASEBALL_BAT}
  DIAXIS_BASEBALLB_LATERAL                = $0F008201; (* Aim left / right *)
  {$EXTERNALSYM DIAXIS_BASEBALLB_LATERAL}
  DIAXIS_BASEBALLB_MOVE                   = $0F010202; (* Aim up / down *)
  {$EXTERNALSYM DIAXIS_BASEBALLB_MOVE}
  DIBUTTON_BASEBALLB_SELECT               = $0F000401; (* cycle through swing options *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_SELECT}
  DIBUTTON_BASEBALLB_NORMAL               = $0F000402; (* normal swing *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_NORMAL}
  DIBUTTON_BASEBALLB_POWER                = $0F000403; (* swing for the fence *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_POWER}
  DIBUTTON_BASEBALLB_BUNT                 = $0F000404; (* bunt *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_BUNT}
  DIBUTTON_BASEBALLB_STEAL                = $0F000405; (* Base runner attempts to steal a base *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_STEAL}
  DIBUTTON_BASEBALLB_BURST                = $0F000406; (* Base runner invokes burst of speed *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_BURST}
  DIBUTTON_BASEBALLB_SLIDE                = $0F000407; (* Base runner slides into base *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_SLIDE}
  DIBUTTON_BASEBALLB_CONTACT              = $0F000408; (* Contact swing *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_CONTACT}
  DIBUTTON_BASEBALLB_MENU                 = $0F0004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_MENU}
(*--- Priority 2 controls                            ---*)

  DIBUTTON_BASEBALLB_NOSTEAL              = $0F004409; (* Base runner goes back to a base *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_NOSTEAL}
  DIBUTTON_BASEBALLB_BOX                  = $0F00440A; (* Enter or exit batting box *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_BOX}
  DIBUTTON_BASEBALLB_LEFT_LINK            = $0F00C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_LEFT_LINK}
  DIBUTTON_BASEBALLB_RIGHT_LINK           = $0F00C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_RIGHT_LINK}
  DIBUTTON_BASEBALLB_FORWARD_LINK         = $0F0144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_FORWARD_LINK}
  DIBUTTON_BASEBALLB_BACK_LINK            = $0F0144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_BACK_LINK}
  DIBUTTON_BASEBALLB_DEVICE               = $0F0044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_DEVICE}
  DIBUTTON_BASEBALLB_PAUSE                = $0F0044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_BASEBALLB_PAUSE}

(*--- Sports - Baseball - Pitching
      Pitcher control is primary objective   ---*)
  DIVIRTUAL_SPORTS_BASEBALL_PITCH         = $10000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_BASEBALL_PITCH}
  DIAXIS_BASEBALLP_LATERAL                = $10008201; (* Aim left / right *)
  {$EXTERNALSYM DIAXIS_BASEBALLP_LATERAL}
  DIAXIS_BASEBALLP_MOVE                   = $10010202; (* Aim up / down *)
  {$EXTERNALSYM DIAXIS_BASEBALLP_MOVE}
  DIBUTTON_BASEBALLP_SELECT               = $10000401; (* cycle through pitch selections *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_SELECT}
  DIBUTTON_BASEBALLP_PITCH                = $10000402; (* throw pitch *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_PITCH}
  DIBUTTON_BASEBALLP_BASE                 = $10000403; (* select base to throw to *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_BASE}
  DIBUTTON_BASEBALLP_THROW                = $10000404; (* throw to base *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_THROW}
  DIBUTTON_BASEBALLP_FAKE                 = $10000405; (* Fake a throw to a base *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_FAKE}
  DIBUTTON_BASEBALLP_MENU                 = $100004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_MENU}
(*--- Priority 2 controls                            ---*)

  DIBUTTON_BASEBALLP_WALK                 = $10004406; (* Throw intentional walk / pitch out *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_WALK}
  DIBUTTON_BASEBALLP_LOOK                 = $10004407; (* Look at runners on bases *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_LOOK}
  DIBUTTON_BASEBALLP_LEFT_LINK            = $1000C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_LEFT_LINK}
  DIBUTTON_BASEBALLP_RIGHT_LINK           = $1000C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_RIGHT_LINK}
  DIBUTTON_BASEBALLP_FORWARD_LINK         = $100144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_FORWARD_LINK}
  DIBUTTON_BASEBALLP_BACK_LINK            = $100144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_BACK_LINK}
  DIBUTTON_BASEBALLP_DEVICE               = $100044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_DEVICE}
  DIBUTTON_BASEBALLP_PAUSE                = $100044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_BASEBALLP_PAUSE}

(*--- Sports - Baseball - Fielding
      Fielder control is primary objective  ---*)
  DIVIRTUAL_SPORTS_BASEBALL_FIELD         = $11000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_BASEBALL_FIELD}
  DIAXIS_BASEBALLF_LATERAL                = $11008201; (* Aim left / right *)
  {$EXTERNALSYM DIAXIS_BASEBALLF_LATERAL}
  DIAXIS_BASEBALLF_MOVE                   = $11010202; (* Aim up / down *)
  {$EXTERNALSYM DIAXIS_BASEBALLF_MOVE}
  DIBUTTON_BASEBALLF_NEAREST              = $11000401; (* Switch to fielder nearest to the ball *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_NEAREST}
  DIBUTTON_BASEBALLF_THROW1               = $11000402; (* Make conservative throw *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_THROW1}
  DIBUTTON_BASEBALLF_THROW2               = $11000403; (* Make aggressive throw *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_THROW2}
  DIBUTTON_BASEBALLF_BURST                = $11000404; (* Invoke burst of speed *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_BURST}
  DIBUTTON_BASEBALLF_JUMP                 = $11000405; (* Jump to catch ball *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_JUMP}
  DIBUTTON_BASEBALLF_DIVE                 = $11000406; (* Dive to catch ball *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_DIVE}
  DIBUTTON_BASEBALLF_MENU                 = $110004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_MENU}
(*--- Priority 2 controls                            ---*)

  DIBUTTON_BASEBALLF_SHIFTIN              = $11004407; (* Shift the infield positioning *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_SHIFTIN}
  DIBUTTON_BASEBALLF_SHIFTOUT             = $11004408; (* Shift the outfield positioning *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_SHIFTOUT}
  DIBUTTON_BASEBALLF_AIM_LEFT_LINK        = $1100C4E4; (* Fallback aim left button *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_AIM_LEFT_LINK}
  DIBUTTON_BASEBALLF_AIM_RIGHT_LINK       = $1100C4EC; (* Fallback aim right button *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_AIM_RIGHT_LINK}
  DIBUTTON_BASEBALLF_FORWARD_LINK         = $110144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_FORWARD_LINK}
  DIBUTTON_BASEBALLF_BACK_LINK            = $110144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_BACK_LINK}
  DIBUTTON_BASEBALLF_DEVICE               = $110044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_DEVICE}
  DIBUTTON_BASEBALLF_PAUSE                = $110044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_BASEBALLF_PAUSE}

(*--- Sports - Basketball - Offense
      Offense  ---*)
  DIVIRTUAL_SPORTS_BASKETBALL_OFFENSE     = $12000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_BASKETBALL_OFFENSE}
  DIAXIS_BBALLO_LATERAL                   = $12008201; (* left / right *)
  {$EXTERNALSYM DIAXIS_BBALLO_LATERAL}
  DIAXIS_BBALLO_MOVE                      = $12010202; (* up / down *)
  {$EXTERNALSYM DIAXIS_BBALLO_MOVE}
  DIBUTTON_BBALLO_SHOOT                   = $12000401; (* shoot basket *)
  {$EXTERNALSYM DIBUTTON_BBALLO_SHOOT}
  DIBUTTON_BBALLO_DUNK                    = $12000402; (* dunk basket *)
  {$EXTERNALSYM DIBUTTON_BBALLO_DUNK}
  DIBUTTON_BBALLO_PASS                    = $12000403; (* throw pass *)
  {$EXTERNALSYM DIBUTTON_BBALLO_PASS}
  DIBUTTON_BBALLO_FAKE                    = $12000404; (* fake shot or pass *)
  {$EXTERNALSYM DIBUTTON_BBALLO_FAKE}
  DIBUTTON_BBALLO_SPECIAL                 = $12000405; (* apply special move *)
  {$EXTERNALSYM DIBUTTON_BBALLO_SPECIAL}
  DIBUTTON_BBALLO_PLAYER                  = $12000406; (* select next player *)
  {$EXTERNALSYM DIBUTTON_BBALLO_PLAYER}
  DIBUTTON_BBALLO_BURST                   = $12000407; (* invoke burst *)
  {$EXTERNALSYM DIBUTTON_BBALLO_BURST}
  DIBUTTON_BBALLO_CALL                    = $12000408; (* call for ball / pass to me *)
  {$EXTERNALSYM DIBUTTON_BBALLO_CALL}
  DIBUTTON_BBALLO_MENU                    = $120004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_BBALLO_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_BBALLO_GLANCE               = $12004601; (* scroll view *)
  {$EXTERNALSYM DIHATSWITCH_BBALLO_GLANCE}
  DIBUTTON_BBALLO_SCREEN                  = $12004409; (* Call for screen *)
  {$EXTERNALSYM DIBUTTON_BBALLO_SCREEN}
  DIBUTTON_BBALLO_PLAY                    = $1200440A; (* Call for specific offensive play *)
  {$EXTERNALSYM DIBUTTON_BBALLO_PLAY}
  DIBUTTON_BBALLO_JAB                     = $1200440B; (* Initiate fake drive to basket *)
  {$EXTERNALSYM DIBUTTON_BBALLO_JAB}
  DIBUTTON_BBALLO_POST                    = $1200440C; (* Perform post move *)
  {$EXTERNALSYM DIBUTTON_BBALLO_POST}
  DIBUTTON_BBALLO_TIMEOUT                 = $1200440D; (* Time Out *)
  {$EXTERNALSYM DIBUTTON_BBALLO_TIMEOUT}
  DIBUTTON_BBALLO_SUBSTITUTE              = $1200440E; (* substitute one player for another *)
  {$EXTERNALSYM DIBUTTON_BBALLO_SUBSTITUTE}
  DIBUTTON_BBALLO_LEFT_LINK               = $1200C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_BBALLO_LEFT_LINK}
  DIBUTTON_BBALLO_RIGHT_LINK              = $1200C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_BBALLO_RIGHT_LINK}
  DIBUTTON_BBALLO_FORWARD_LINK            = $120144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_BBALLO_FORWARD_LINK}
  DIBUTTON_BBALLO_BACK_LINK               = $120144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_BBALLO_BACK_LINK}
  DIBUTTON_BBALLO_DEVICE                  = $120044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_BBALLO_DEVICE}
  DIBUTTON_BBALLO_PAUSE                   = $120044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_BBALLO_PAUSE}

(*--- Sports - Basketball - Defense
      Defense  ---*)
  DIVIRTUAL_SPORTS_BASKETBALL_DEFENSE     = $13000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_BASKETBALL_DEFENSE}
  DIAXIS_BBALLD_LATERAL                   = $13008201; (* left / right *)
  {$EXTERNALSYM DIAXIS_BBALLD_LATERAL}
  DIAXIS_BBALLD_MOVE                      = $13010202; (* up / down *)
  {$EXTERNALSYM DIAXIS_BBALLD_MOVE}
  DIBUTTON_BBALLD_JUMP                    = $13000401; (* jump to block shot *)
  {$EXTERNALSYM DIBUTTON_BBALLD_JUMP}
  DIBUTTON_BBALLD_STEAL                   = $13000402; (* attempt to steal ball *)
  {$EXTERNALSYM DIBUTTON_BBALLD_STEAL}
  DIBUTTON_BBALLD_FAKE                    = $13000403; (* fake block or steal *)
  {$EXTERNALSYM DIBUTTON_BBALLD_FAKE}
  DIBUTTON_BBALLD_SPECIAL                 = $13000404; (* apply special move *)
  {$EXTERNALSYM DIBUTTON_BBALLD_SPECIAL}
  DIBUTTON_BBALLD_PLAYER                  = $13000405; (* select next player *)
  {$EXTERNALSYM DIBUTTON_BBALLD_PLAYER}
  DIBUTTON_BBALLD_BURST                   = $13000406; (* invoke burst *)
  {$EXTERNALSYM DIBUTTON_BBALLD_BURST}
  DIBUTTON_BBALLD_PLAY                    = $13000407; (* call for specific defensive play *)
  {$EXTERNALSYM DIBUTTON_BBALLD_PLAY}
  DIBUTTON_BBALLD_MENU                    = $130004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_BBALLD_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_BBALLD_GLANCE               = $13004601; (* scroll view *)
  {$EXTERNALSYM DIHATSWITCH_BBALLD_GLANCE}
  DIBUTTON_BBALLD_TIMEOUT                 = $13004408; (* Time Out *)
  {$EXTERNALSYM DIBUTTON_BBALLD_TIMEOUT}
  DIBUTTON_BBALLD_SUBSTITUTE              = $13004409; (* substitute one player for another *)
  {$EXTERNALSYM DIBUTTON_BBALLD_SUBSTITUTE}
  DIBUTTON_BBALLD_LEFT_LINK               = $1300C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_BBALLD_LEFT_LINK}
  DIBUTTON_BBALLD_RIGHT_LINK              = $1300C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_BBALLD_RIGHT_LINK}
  DIBUTTON_BBALLD_FORWARD_LINK            = $130144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_BBALLD_FORWARD_LINK}
  DIBUTTON_BBALLD_BACK_LINK               = $130144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_BBALLD_BACK_LINK}
  DIBUTTON_BBALLD_DEVICE                  = $130044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_BBALLD_DEVICE}
  DIBUTTON_BBALLD_PAUSE                   = $130044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_BBALLD_PAUSE}

(*--- Sports - Football - Play
      Play selection  ---*)
  DIVIRTUAL_SPORTS_FOOTBALL_FIELD         = $14000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_FOOTBALL_FIELD}
  DIBUTTON_FOOTBALLP_PLAY                 = $14000401; (* cycle through available plays *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLP_PLAY}
  DIBUTTON_FOOTBALLP_SELECT               = $14000402; (* select play *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLP_SELECT}
  DIBUTTON_FOOTBALLP_HELP                 = $14000403; (* Bring up pop-up help *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLP_HELP}
  DIBUTTON_FOOTBALLP_MENU                 = $140004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLP_MENU}
(*--- Priority 2 controls                            ---*)

  DIBUTTON_FOOTBALLP_DEVICE               = $140044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLP_DEVICE}
  DIBUTTON_FOOTBALLP_PAUSE                = $140044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLP_PAUSE}

(*--- Sports - Football - QB
      Offense: Quarterback / Kicker  ---*)
  DIVIRTUAL_SPORTS_FOOTBALL_QBCK          = $15000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_FOOTBALL_QBCK}
  DIAXIS_FOOTBALLQ_LATERAL                = $15008201; (* Move / Aim: left / right *)
  {$EXTERNALSYM DIAXIS_FOOTBALLQ_LATERAL}
  DIAXIS_FOOTBALLQ_MOVE                   = $15010202; (* Move / Aim: up / down *)
  {$EXTERNALSYM DIAXIS_FOOTBALLQ_MOVE}
  DIBUTTON_FOOTBALLQ_SELECT               = $15000401; (* Select *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_SELECT}
  DIBUTTON_FOOTBALLQ_SNAP                 = $15000402; (* snap ball - start play *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_SNAP}
  DIBUTTON_FOOTBALLQ_JUMP                 = $15000403; (* jump over defender *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_JUMP}
  DIBUTTON_FOOTBALLQ_SLIDE                = $15000404; (* Dive/Slide *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_SLIDE}
  DIBUTTON_FOOTBALLQ_PASS                 = $15000405; (* throws pass to receiver *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_PASS}
  DIBUTTON_FOOTBALLQ_FAKE                 = $15000406; (* pump fake pass or fake kick *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_FAKE}
  DIBUTTON_FOOTBALLQ_MENU                 = $150004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_MENU}
(*--- Priority 2 controls                            ---*)

  DIBUTTON_FOOTBALLQ_FAKESNAP             = $15004407; (* Fake snap  *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_FAKESNAP}
  DIBUTTON_FOOTBALLQ_MOTION               = $15004408; (* Send receivers in motion *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_MOTION}
  DIBUTTON_FOOTBALLQ_AUDIBLE              = $15004409; (* Change offensive play at line of scrimmage *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_AUDIBLE}
  DIBUTTON_FOOTBALLQ_LEFT_LINK            = $1500C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_LEFT_LINK}
  DIBUTTON_FOOTBALLQ_RIGHT_LINK           = $1500C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_RIGHT_LINK}
  DIBUTTON_FOOTBALLQ_FORWARD_LINK         = $150144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_FORWARD_LINK}
  DIBUTTON_FOOTBALLQ_BACK_LINK            = $150144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_BACK_LINK}
  DIBUTTON_FOOTBALLQ_DEVICE               = $150044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_DEVICE}
  DIBUTTON_FOOTBALLQ_PAUSE                = $150044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLQ_PAUSE}

(*--- Sports - Football - Offense
      Offense - Runner  ---*)
  DIVIRTUAL_SPORTS_FOOTBALL_OFFENSE       = $16000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_FOOTBALL_OFFENSE}
  DIAXIS_FOOTBALLO_LATERAL                = $16008201; (* Move / Aim: left / right *)
  {$EXTERNALSYM DIAXIS_FOOTBALLO_LATERAL}
  DIAXIS_FOOTBALLO_MOVE                   = $16010202; (* Move / Aim: up / down *)
  {$EXTERNALSYM DIAXIS_FOOTBALLO_MOVE}
  DIBUTTON_FOOTBALLO_JUMP                 = $16000401; (* jump or hurdle over defender *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_JUMP}
  DIBUTTON_FOOTBALLO_LEFTARM              = $16000402; (* holds out left arm *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_LEFTARM}
  DIBUTTON_FOOTBALLO_RIGHTARM             = $16000403; (* holds out right arm *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_RIGHTARM}
  DIBUTTON_FOOTBALLO_THROW                = $16000404; (* throw pass or lateral ball to another runner *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_THROW}
  DIBUTTON_FOOTBALLO_SPIN                 = $16000405; (* Spin to avoid defenders *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_SPIN}
  DIBUTTON_FOOTBALLO_MENU                 = $160004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_MENU}
(*--- Priority 2 controls                            ---*)

  DIBUTTON_FOOTBALLO_JUKE                 = $16004406; (* Use special move to avoid defenders *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_JUKE}
  DIBUTTON_FOOTBALLO_SHOULDER             = $16004407; (* Lower shoulder to run over defenders *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_SHOULDER}
  DIBUTTON_FOOTBALLO_TURBO                = $16004408; (* Speed burst past defenders *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_TURBO}
  DIBUTTON_FOOTBALLO_DIVE                 = $16004409; (* Dive over defenders *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_DIVE}
  DIBUTTON_FOOTBALLO_ZOOM                 = $1600440A; (* Zoom view in / out *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_ZOOM}
  DIBUTTON_FOOTBALLO_SUBSTITUTE           = $1600440B; (* substitute one player for another *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_SUBSTITUTE}
  DIBUTTON_FOOTBALLO_LEFT_LINK            = $1600C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_LEFT_LINK}
  DIBUTTON_FOOTBALLO_RIGHT_LINK           = $1600C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_RIGHT_LINK}
  DIBUTTON_FOOTBALLO_FORWARD_LINK         = $160144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_FORWARD_LINK}
  DIBUTTON_FOOTBALLO_BACK_LINK            = $160144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_BACK_LINK}
  DIBUTTON_FOOTBALLO_DEVICE               = $160044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_DEVICE}
  DIBUTTON_FOOTBALLO_PAUSE                = $160044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLO_PAUSE}

(*--- Sports - Football - Defense
      Defense     ---*)
  DIVIRTUAL_SPORTS_FOOTBALL_DEFENSE       = $17000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_FOOTBALL_DEFENSE}
  DIAXIS_FOOTBALLD_LATERAL                = $17008201; (* Move / Aim: left / right *)
  {$EXTERNALSYM DIAXIS_FOOTBALLD_LATERAL}
  DIAXIS_FOOTBALLD_MOVE                   = $17010202; (* Move / Aim: up / down *)
  {$EXTERNALSYM DIAXIS_FOOTBALLD_MOVE}
  DIBUTTON_FOOTBALLD_PLAY                 = $17000401; (* cycle through available plays *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_PLAY}
  DIBUTTON_FOOTBALLD_SELECT               = $17000402; (* select player closest to the ball *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_SELECT}
  DIBUTTON_FOOTBALLD_JUMP                 = $17000403; (* jump to intercept or block *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_JUMP}
  DIBUTTON_FOOTBALLD_TACKLE               = $17000404; (* tackler runner *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_TACKLE}
  DIBUTTON_FOOTBALLD_FAKE                 = $17000405; (* hold down to fake tackle or intercept *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_FAKE}
  DIBUTTON_FOOTBALLD_SUPERTACKLE          = $17000406; (* Initiate special tackle *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_SUPERTACKLE}
  DIBUTTON_FOOTBALLD_MENU                 = $170004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_MENU}
(*--- Priority 2 controls                            ---*)

  DIBUTTON_FOOTBALLD_SPIN                 = $17004407; (* Spin to beat offensive line *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_SPIN}
  DIBUTTON_FOOTBALLD_SWIM                 = $17004408; (* Swim to beat the offensive line *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_SWIM}
  DIBUTTON_FOOTBALLD_BULLRUSH             = $17004409; (* Bull rush the offensive line *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_BULLRUSH}
  DIBUTTON_FOOTBALLD_RIP                  = $1700440A; (* Rip the offensive line *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_RIP}
  DIBUTTON_FOOTBALLD_AUDIBLE              = $1700440B; (* Change defensive play at the line of scrimmage *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_AUDIBLE}
  DIBUTTON_FOOTBALLD_ZOOM                 = $1700440C; (* Zoom view in / out *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_ZOOM}
  DIBUTTON_FOOTBALLD_SUBSTITUTE           = $1700440D; (* substitute one player for another *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_SUBSTITUTE}
  DIBUTTON_FOOTBALLD_LEFT_LINK            = $1700C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_LEFT_LINK}
  DIBUTTON_FOOTBALLD_RIGHT_LINK           = $1700C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_RIGHT_LINK}
  DIBUTTON_FOOTBALLD_FORWARD_LINK         = $170144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_FORWARD_LINK}
  DIBUTTON_FOOTBALLD_BACK_LINK            = $170144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_BACK_LINK}
  DIBUTTON_FOOTBALLD_DEVICE               = $170044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_DEVICE}
  DIBUTTON_FOOTBALLD_PAUSE                = $170044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_FOOTBALLD_PAUSE}

(*--- Sports - Golf
                                ---*)
  DIVIRTUAL_SPORTS_GOLF                   = $18000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_GOLF}
  DIAXIS_GOLF_LATERAL                     = $18008201; (* Move / Aim: left / right *)
  {$EXTERNALSYM DIAXIS_GOLF_LATERAL}
  DIAXIS_GOLF_MOVE                        = $18010202; (* Move / Aim: up / down *)
  {$EXTERNALSYM DIAXIS_GOLF_MOVE}
  DIBUTTON_GOLF_SWING                     = $18000401; (* swing club *)
  {$EXTERNALSYM DIBUTTON_GOLF_SWING}
  DIBUTTON_GOLF_SELECT                    = $18000402; (* cycle between: club / swing strength / ball arc / ball spin *)
  {$EXTERNALSYM DIBUTTON_GOLF_SELECT}
  DIBUTTON_GOLF_UP                        = $18000403; (* increase selection *)
  {$EXTERNALSYM DIBUTTON_GOLF_UP}
  DIBUTTON_GOLF_DOWN                      = $18000404; (* decrease selection *)
  {$EXTERNALSYM DIBUTTON_GOLF_DOWN}
  DIBUTTON_GOLF_TERRAIN                   = $18000405; (* shows terrain detail *)
  {$EXTERNALSYM DIBUTTON_GOLF_TERRAIN}
  DIBUTTON_GOLF_FLYBY                     = $18000406; (* view the hole via a flyby *)
  {$EXTERNALSYM DIBUTTON_GOLF_FLYBY}
  DIBUTTON_GOLF_MENU                      = $180004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_GOLF_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_GOLF_SCROLL                 = $18004601; (* scroll view *)
  {$EXTERNALSYM DIHATSWITCH_GOLF_SCROLL}
  DIBUTTON_GOLF_ZOOM                      = $18004407; (* Zoom view in / out *)
  {$EXTERNALSYM DIBUTTON_GOLF_ZOOM}
  DIBUTTON_GOLF_TIMEOUT                   = $18004408; (* Call for time out *)
  {$EXTERNALSYM DIBUTTON_GOLF_TIMEOUT}
  DIBUTTON_GOLF_SUBSTITUTE                = $18004409; (* substitute one player for another *)
  {$EXTERNALSYM DIBUTTON_GOLF_SUBSTITUTE}
  DIBUTTON_GOLF_LEFT_LINK                 = $1800C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_GOLF_LEFT_LINK}
  DIBUTTON_GOLF_RIGHT_LINK                = $1800C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_GOLF_RIGHT_LINK}
  DIBUTTON_GOLF_FORWARD_LINK              = $180144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_GOLF_FORWARD_LINK}
  DIBUTTON_GOLF_BACK_LINK                 = $180144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_GOLF_BACK_LINK}
  DIBUTTON_GOLF_DEVICE                    = $180044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_GOLF_DEVICE}
  DIBUTTON_GOLF_PAUSE                     = $180044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_GOLF_PAUSE}

(*--- Sports - Hockey - Offense
      Offense       ---*)
  DIVIRTUAL_SPORTS_HOCKEY_OFFENSE         = $19000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_HOCKEY_OFFENSE}
  DIAXIS_HOCKEYO_LATERAL                  = $19008201; (* Move / Aim: left / right *)
  {$EXTERNALSYM DIAXIS_HOCKEYO_LATERAL}
  DIAXIS_HOCKEYO_MOVE                     = $19010202; (* Move / Aim: up / down *)
  {$EXTERNALSYM DIAXIS_HOCKEYO_MOVE}
  DIBUTTON_HOCKEYO_SHOOT                  = $19000401; (* Shoot *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_SHOOT}
  DIBUTTON_HOCKEYO_PASS                   = $19000402; (* pass the puck *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_PASS}
  DIBUTTON_HOCKEYO_BURST                  = $19000403; (* invoke speed burst *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_BURST}
  DIBUTTON_HOCKEYO_SPECIAL                = $19000404; (* invoke special move *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_SPECIAL}
  DIBUTTON_HOCKEYO_FAKE                   = $19000405; (* hold down to fake pass or kick *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_FAKE}
  DIBUTTON_HOCKEYO_MENU                   = $190004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_HOCKEYO_SCROLL              = $19004601; (* scroll view *)
  {$EXTERNALSYM DIHATSWITCH_HOCKEYO_SCROLL}
  DIBUTTON_HOCKEYO_ZOOM                   = $19004406; (* Zoom view in / out *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_ZOOM}
  DIBUTTON_HOCKEYO_STRATEGY               = $19004407; (* Invoke coaching menu for strategy help *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_STRATEGY}
  DIBUTTON_HOCKEYO_TIMEOUT                = $19004408; (* Call for time out *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_TIMEOUT}
  DIBUTTON_HOCKEYO_SUBSTITUTE             = $19004409; (* substitute one player for another *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_SUBSTITUTE}
  DIBUTTON_HOCKEYO_LEFT_LINK              = $1900C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_LEFT_LINK}
  DIBUTTON_HOCKEYO_RIGHT_LINK             = $1900C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_RIGHT_LINK}
  DIBUTTON_HOCKEYO_FORWARD_LINK           = $190144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_FORWARD_LINK}
  DIBUTTON_HOCKEYO_BACK_LINK              = $190144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_BACK_LINK}
  DIBUTTON_HOCKEYO_DEVICE                 = $190044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_DEVICE}
  DIBUTTON_HOCKEYO_PAUSE                  = $190044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_HOCKEYO_PAUSE}

(*--- Sports - Hockey - Defense
      Defense       ---*)
  DIVIRTUAL_SPORTS_HOCKEY_DEFENSE         = $1A000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_HOCKEY_DEFENSE}
  DIAXIS_HOCKEYD_LATERAL                  = $1A008201; (* Move / Aim: left / right *)
  {$EXTERNALSYM DIAXIS_HOCKEYD_LATERAL}
  DIAXIS_HOCKEYD_MOVE                     = $1A010202; (* Move / Aim: up / down *)
  {$EXTERNALSYM DIAXIS_HOCKEYD_MOVE}
  DIBUTTON_HOCKEYD_PLAYER                 = $1A000401; (* control player closest to the puck *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_PLAYER}
  DIBUTTON_HOCKEYD_STEAL                  = $1A000402; (* attempt steal *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_STEAL}
  DIBUTTON_HOCKEYD_BURST                  = $1A000403; (* speed burst or body check *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_BURST}
  DIBUTTON_HOCKEYD_BLOCK                  = $1A000404; (* block puck *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_BLOCK}
  DIBUTTON_HOCKEYD_FAKE                   = $1A000405; (* hold down to fake tackle or intercept *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_FAKE}
  DIBUTTON_HOCKEYD_MENU                   = $1A0004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_HOCKEYD_SCROLL              = $1A004601; (* scroll view *)
  {$EXTERNALSYM DIHATSWITCH_HOCKEYD_SCROLL}
  DIBUTTON_HOCKEYD_ZOOM                   = $1A004406; (* Zoom view in / out *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_ZOOM}
  DIBUTTON_HOCKEYD_STRATEGY               = $1A004407; (* Invoke coaching menu for strategy help *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_STRATEGY}
  DIBUTTON_HOCKEYD_TIMEOUT                = $1A004408; (* Call for time out *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_TIMEOUT}
  DIBUTTON_HOCKEYD_SUBSTITUTE             = $1A004409; (* substitute one player for another *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_SUBSTITUTE}
  DIBUTTON_HOCKEYD_LEFT_LINK              = $1A00C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_LEFT_LINK}
  DIBUTTON_HOCKEYD_RIGHT_LINK             = $1A00C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_RIGHT_LINK}
  DIBUTTON_HOCKEYD_FORWARD_LINK           = $1A0144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_FORWARD_LINK}
  DIBUTTON_HOCKEYD_BACK_LINK              = $1A0144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_BACK_LINK}
  DIBUTTON_HOCKEYD_DEVICE                 = $1A0044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_DEVICE}
  DIBUTTON_HOCKEYD_PAUSE                  = $1A0044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_HOCKEYD_PAUSE}

(*--- Sports - Hockey - Goalie
      Goal tending  ---*)
  DIVIRTUAL_SPORTS_HOCKEY_GOALIE          = $1B000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_HOCKEY_GOALIE}
  DIAXIS_HOCKEYG_LATERAL                  = $1B008201; (* Move / Aim: left / right *)
  {$EXTERNALSYM DIAXIS_HOCKEYG_LATERAL}
  DIAXIS_HOCKEYG_MOVE                     = $1B010202; (* Move / Aim: up / down *)
  {$EXTERNALSYM DIAXIS_HOCKEYG_MOVE}
  DIBUTTON_HOCKEYG_PASS                   = $1B000401; (* pass puck *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_PASS}
  DIBUTTON_HOCKEYG_POKE                   = $1B000402; (* poke / check / hack *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_POKE}
  DIBUTTON_HOCKEYG_STEAL                  = $1B000403; (* attempt steal *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_STEAL}
  DIBUTTON_HOCKEYG_BLOCK                  = $1B000404; (* block puck *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_BLOCK}
  DIBUTTON_HOCKEYG_MENU                   = $1B0004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_HOCKEYG_SCROLL              = $1B004601; (* scroll view *)
  {$EXTERNALSYM DIHATSWITCH_HOCKEYG_SCROLL}
  DIBUTTON_HOCKEYG_ZOOM                   = $1B004405; (* Zoom view in / out *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_ZOOM}
  DIBUTTON_HOCKEYG_STRATEGY               = $1B004406; (* Invoke coaching menu for strategy help *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_STRATEGY}
  DIBUTTON_HOCKEYG_TIMEOUT                = $1B004407; (* Call for time out *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_TIMEOUT}
  DIBUTTON_HOCKEYG_SUBSTITUTE             = $1B004408; (* substitute one player for another *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_SUBSTITUTE}
  DIBUTTON_HOCKEYG_LEFT_LINK              = $1B00C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_LEFT_LINK}
  DIBUTTON_HOCKEYG_RIGHT_LINK             = $1B00C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_RIGHT_LINK}
  DIBUTTON_HOCKEYG_FORWARD_LINK           = $1B0144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_FORWARD_LINK}
  DIBUTTON_HOCKEYG_BACK_LINK              = $1B0144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_BACK_LINK}
  DIBUTTON_HOCKEYG_DEVICE                 = $1B0044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_DEVICE}
  DIBUTTON_HOCKEYG_PAUSE                  = $1B0044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_HOCKEYG_PAUSE}

(*--- Sports - Mountain Biking
                     ---*)
  DIVIRTUAL_SPORTS_BIKING_MOUNTAIN        = $1C000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_BIKING_MOUNTAIN}
  DIAXIS_BIKINGM_TURN                     = $1C008201; (* left / right *)
  {$EXTERNALSYM DIAXIS_BIKINGM_TURN}
  DIAXIS_BIKINGM_PEDAL                    = $1C010202; (* Pedal faster / slower / brake *)
  {$EXTERNALSYM DIAXIS_BIKINGM_PEDAL}
  DIBUTTON_BIKINGM_JUMP                   = $1C000401; (* jump over obstacle *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_JUMP}
  DIBUTTON_BIKINGM_CAMERA                 = $1C000402; (* switch camera view *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_CAMERA}
  DIBUTTON_BIKINGM_SPECIAL1               = $1C000403; (* perform first special move *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_SPECIAL1}
  DIBUTTON_BIKINGM_SELECT                 = $1C000404; (* Select *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_SELECT}
  DIBUTTON_BIKINGM_SPECIAL2               = $1C000405; (* perform second special move *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_SPECIAL2}
  DIBUTTON_BIKINGM_MENU                   = $1C0004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_BIKINGM_SCROLL              = $1C004601; (* scroll view *)
  {$EXTERNALSYM DIHATSWITCH_BIKINGM_SCROLL}
  DIBUTTON_BIKINGM_ZOOM                   = $1C004406; (* Zoom view in / out *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_ZOOM}
  DIAXIS_BIKINGM_BRAKE                    = $1C044203; (* Brake axis  *)
  {$EXTERNALSYM DIAXIS_BIKINGM_BRAKE}
  DIBUTTON_BIKINGM_LEFT_LINK              = $1C00C4E4; (* Fallback turn left button *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_LEFT_LINK}
  DIBUTTON_BIKINGM_RIGHT_LINK             = $1C00C4EC; (* Fallback turn right button *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_RIGHT_LINK}
  DIBUTTON_BIKINGM_FASTER_LINK            = $1C0144E0; (* Fallback pedal faster button *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_FASTER_LINK}
  DIBUTTON_BIKINGM_SLOWER_LINK            = $1C0144E8; (* Fallback pedal slower button *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_SLOWER_LINK}
  DIBUTTON_BIKINGM_BRAKE_BUTTON_LINK      = $1C0444E8; (* Fallback brake button *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_BRAKE_BUTTON_LINK}
  DIBUTTON_BIKINGM_DEVICE                 = $1C0044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_DEVICE}
  DIBUTTON_BIKINGM_PAUSE                  = $1C0044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_BIKINGM_PAUSE}

(*--- Sports: Skiing / Snowboarding / Skateboarding
        ---*)
  DIVIRTUAL_SPORTS_SKIING                 = $1D000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_SKIING}
  DIAXIS_SKIING_TURN                      = $1D008201; (* left / right *)
  {$EXTERNALSYM DIAXIS_SKIING_TURN}
  DIAXIS_SKIING_SPEED                     = $1D010202; (* faster / slower *)
  {$EXTERNALSYM DIAXIS_SKIING_SPEED}
  DIBUTTON_SKIING_JUMP                    = $1D000401; (* Jump *)
  {$EXTERNALSYM DIBUTTON_SKIING_JUMP}
  DIBUTTON_SKIING_CROUCH                  = $1D000402; (* crouch down *)
  {$EXTERNALSYM DIBUTTON_SKIING_CROUCH}
  DIBUTTON_SKIING_CAMERA                  = $1D000403; (* switch camera view *)
  {$EXTERNALSYM DIBUTTON_SKIING_CAMERA}
  DIBUTTON_SKIING_SPECIAL1                = $1D000404; (* perform first special move *)
  {$EXTERNALSYM DIBUTTON_SKIING_SPECIAL1}
  DIBUTTON_SKIING_SELECT                  = $1D000405; (* Select *)
  {$EXTERNALSYM DIBUTTON_SKIING_SELECT}
  DIBUTTON_SKIING_SPECIAL2                = $1D000406; (* perform second special move *)
  {$EXTERNALSYM DIBUTTON_SKIING_SPECIAL2}
  DIBUTTON_SKIING_MENU                    = $1D0004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_SKIING_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_SKIING_GLANCE               = $1D004601; (* scroll view *)
  {$EXTERNALSYM DIHATSWITCH_SKIING_GLANCE}
  DIBUTTON_SKIING_ZOOM                    = $1D004407; (* Zoom view in / out *)
  {$EXTERNALSYM DIBUTTON_SKIING_ZOOM}
  DIBUTTON_SKIING_LEFT_LINK               = $1D00C4E4; (* Fallback turn left button *)
  {$EXTERNALSYM DIBUTTON_SKIING_LEFT_LINK}
  DIBUTTON_SKIING_RIGHT_LINK              = $1D00C4EC; (* Fallback turn right button *)
  {$EXTERNALSYM DIBUTTON_SKIING_RIGHT_LINK}
  DIBUTTON_SKIING_FASTER_LINK             = $1D0144E0; (* Fallback increase speed button *)
  {$EXTERNALSYM DIBUTTON_SKIING_FASTER_LINK}
  DIBUTTON_SKIING_SLOWER_LINK             = $1D0144E8; (* Fallback decrease speed button *)
  {$EXTERNALSYM DIBUTTON_SKIING_SLOWER_LINK}
  DIBUTTON_SKIING_DEVICE                  = $1D0044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_SKIING_DEVICE}
  DIBUTTON_SKIING_PAUSE                   = $1D0044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_SKIING_PAUSE}

(*--- Sports - Soccer - Offense
      Offense       ---*)
  DIVIRTUAL_SPORTS_SOCCER_OFFENSE         = $1E000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_SOCCER_OFFENSE}
  DIAXIS_SOCCERO_LATERAL                  = $1E008201; (* Move / Aim: left / right *)
  {$EXTERNALSYM DIAXIS_SOCCERO_LATERAL}
  DIAXIS_SOCCERO_MOVE                     = $1E010202; (* Move / Aim: up / down *)
  {$EXTERNALSYM DIAXIS_SOCCERO_MOVE}
  DIAXIS_SOCCERO_BEND                     = $1E018203; (* Bend to soccer shot/pass *)
  {$EXTERNALSYM DIAXIS_SOCCERO_BEND}
  DIBUTTON_SOCCERO_SHOOT                  = $1E000401; (* Shoot the ball *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_SHOOT}
  DIBUTTON_SOCCERO_PASS                   = $1E000402; (* Pass  *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_PASS}
  DIBUTTON_SOCCERO_FAKE                   = $1E000403; (* Fake *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_FAKE}
  DIBUTTON_SOCCERO_PLAYER                 = $1E000404; (* Select next player *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_PLAYER}
  DIBUTTON_SOCCERO_SPECIAL1               = $1E000405; (* Apply special move *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_SPECIAL1}
  DIBUTTON_SOCCERO_SELECT                 = $1E000406; (* Select special move *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_SELECT}
  DIBUTTON_SOCCERO_MENU                   = $1E0004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_SOCCERO_GLANCE              = $1E004601; (* scroll view *)
  {$EXTERNALSYM DIHATSWITCH_SOCCERO_GLANCE}
  DIBUTTON_SOCCERO_SUBSTITUTE             = $1E004407; (* Substitute one player for another *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_SUBSTITUTE}
  DIBUTTON_SOCCERO_SHOOTLOW               = $1E004408; (* Shoot the ball low *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_SHOOTLOW}
  DIBUTTON_SOCCERO_SHOOTHIGH              = $1E004409; (* Shoot the ball high *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_SHOOTHIGH}
  DIBUTTON_SOCCERO_PASSTHRU               = $1E00440A; (* Make a thru pass *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_PASSTHRU}
  DIBUTTON_SOCCERO_SPRINT                 = $1E00440B; (* Sprint / turbo boost *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_SPRINT}
  DIBUTTON_SOCCERO_CONTROL                = $1E00440C; (* Obtain control of the ball *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_CONTROL}
  DIBUTTON_SOCCERO_HEAD                   = $1E00440D; (* Attempt to head the ball *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_HEAD}
  DIBUTTON_SOCCERO_LEFT_LINK              = $1E00C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_LEFT_LINK}
  DIBUTTON_SOCCERO_RIGHT_LINK             = $1E00C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_RIGHT_LINK}
  DIBUTTON_SOCCERO_FORWARD_LINK           = $1E0144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_FORWARD_LINK}
  DIBUTTON_SOCCERO_BACK_LINK              = $1E0144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_BACK_LINK}
  DIBUTTON_SOCCERO_DEVICE                 = $1E0044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_DEVICE}
  DIBUTTON_SOCCERO_PAUSE                  = $1E0044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_SOCCERO_PAUSE}

(*--- Sports - Soccer - Defense
      Defense       ---*)
  DIVIRTUAL_SPORTS_SOCCER_DEFENSE         = $1F000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_SOCCER_DEFENSE}
  DIAXIS_SOCCERD_LATERAL                  = $1F008201; (* Move / Aim: left / right *)
  {$EXTERNALSYM DIAXIS_SOCCERD_LATERAL}
  DIAXIS_SOCCERD_MOVE                     = $1F010202; (* Move / Aim: up / down *)
  {$EXTERNALSYM DIAXIS_SOCCERD_MOVE}
  DIBUTTON_SOCCERD_BLOCK                  = $1F000401; (* Attempt to block shot *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_BLOCK}
  DIBUTTON_SOCCERD_STEAL                  = $1F000402; (* Attempt to steal ball *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_STEAL}
  DIBUTTON_SOCCERD_FAKE                   = $1F000403; (* Fake a block or a steal *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_FAKE}
  DIBUTTON_SOCCERD_PLAYER                 = $1F000404; (* Select next player *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_PLAYER}
  DIBUTTON_SOCCERD_SPECIAL                = $1F000405; (* Apply special move *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_SPECIAL}
  DIBUTTON_SOCCERD_SELECT                 = $1F000406; (* Select special move *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_SELECT}
  DIBUTTON_SOCCERD_SLIDE                  = $1F000407; (* Attempt a slide tackle *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_SLIDE}
  DIBUTTON_SOCCERD_MENU                   = $1F0004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_SOCCERD_GLANCE              = $1F004601; (* scroll view *)
  {$EXTERNALSYM DIHATSWITCH_SOCCERD_GLANCE}
  DIBUTTON_SOCCERD_FOUL                   = $1F004408; (* Initiate a foul / hard-foul *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_FOUL}
  DIBUTTON_SOCCERD_HEAD                   = $1F004409; (* Attempt a Header *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_HEAD}
  DIBUTTON_SOCCERD_CLEAR                  = $1F00440A; (* Attempt to clear the ball down the field *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_CLEAR}
  DIBUTTON_SOCCERD_GOALIECHARGE           = $1F00440B; (* Make the goalie charge out of the box *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_GOALIECHARGE}
  DIBUTTON_SOCCERD_SUBSTITUTE             = $1F00440C; (* Substitute one player for another *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_SUBSTITUTE}
  DIBUTTON_SOCCERD_LEFT_LINK              = $1F00C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_LEFT_LINK}
  DIBUTTON_SOCCERD_RIGHT_LINK             = $1F00C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_RIGHT_LINK}
  DIBUTTON_SOCCERD_FORWARD_LINK           = $1F0144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_FORWARD_LINK}
  DIBUTTON_SOCCERD_BACK_LINK              = $1F0144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_BACK_LINK}
  DIBUTTON_SOCCERD_DEVICE                 = $1F0044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_DEVICE}
  DIBUTTON_SOCCERD_PAUSE                  = $1F0044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_SOCCERD_PAUSE}

(*--- Sports - Racquet
      Tennis - Table-Tennis - Squash   ---*)
  DIVIRTUAL_SPORTS_RACQUET                = $20000000;
  {$EXTERNALSYM DIVIRTUAL_SPORTS_RACQUET}
  DIAXIS_RACQUET_LATERAL                  = $20008201; (* Move / Aim: left / right *)
  {$EXTERNALSYM DIAXIS_RACQUET_LATERAL}
  DIAXIS_RACQUET_MOVE                     = $20010202; (* Move / Aim: up / down *)
  {$EXTERNALSYM DIAXIS_RACQUET_MOVE}
  DIBUTTON_RACQUET_SWING                  = $20000401; (* Swing racquet *)
  {$EXTERNALSYM DIBUTTON_RACQUET_SWING}
  DIBUTTON_RACQUET_BACKSWING              = $20000402; (* Swing backhand *)
  {$EXTERNALSYM DIBUTTON_RACQUET_BACKSWING}
  DIBUTTON_RACQUET_SMASH                  = $20000403; (* Smash shot *)
  {$EXTERNALSYM DIBUTTON_RACQUET_SMASH}
  DIBUTTON_RACQUET_SPECIAL                = $20000404; (* Special shot *)
  {$EXTERNALSYM DIBUTTON_RACQUET_SPECIAL}
  DIBUTTON_RACQUET_SELECT                 = $20000405; (* Select special shot *)
  {$EXTERNALSYM DIBUTTON_RACQUET_SELECT}
  DIBUTTON_RACQUET_MENU                   = $200004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_RACQUET_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_RACQUET_GLANCE              = $20004601; (* scroll view *)
  {$EXTERNALSYM DIHATSWITCH_RACQUET_GLANCE}
  DIBUTTON_RACQUET_TIMEOUT                = $20004406; (* Call for time out *)
  {$EXTERNALSYM DIBUTTON_RACQUET_TIMEOUT}
  DIBUTTON_RACQUET_SUBSTITUTE             = $20004407; (* Substitute one player for another *)
  {$EXTERNALSYM DIBUTTON_RACQUET_SUBSTITUTE}
  DIBUTTON_RACQUET_LEFT_LINK              = $2000C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_RACQUET_LEFT_LINK}
  DIBUTTON_RACQUET_RIGHT_LINK             = $2000C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_RACQUET_RIGHT_LINK}
  DIBUTTON_RACQUET_FORWARD_LINK           = $200144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_RACQUET_FORWARD_LINK}
  DIBUTTON_RACQUET_BACK_LINK              = $200144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_RACQUET_BACK_LINK}
  DIBUTTON_RACQUET_DEVICE                 = $200044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_RACQUET_DEVICE}
  DIBUTTON_RACQUET_PAUSE                  = $200044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_RACQUET_PAUSE}

(*--- Arcade- 2D
      Side to Side movement        ---*)
  DIVIRTUAL_ARCADE_SIDE2SIDE              = $21000000;
  {$EXTERNALSYM DIVIRTUAL_ARCADE_SIDE2SIDE}
  DIAXIS_ARCADES_LATERAL                  = $21008201; (* left / right *)
  {$EXTERNALSYM DIAXIS_ARCADES_LATERAL}
  DIAXIS_ARCADES_MOVE                     = $21010202; (* up / down *)
  {$EXTERNALSYM DIAXIS_ARCADES_MOVE}
  DIBUTTON_ARCADES_THROW                  = $21000401; (* throw object *)
  {$EXTERNALSYM DIBUTTON_ARCADES_THROW}
  DIBUTTON_ARCADES_CARRY                  = $21000402; (* carry object *)
  {$EXTERNALSYM DIBUTTON_ARCADES_CARRY}
  DIBUTTON_ARCADES_ATTACK                 = $21000403; (* attack *)
  {$EXTERNALSYM DIBUTTON_ARCADES_ATTACK}
  DIBUTTON_ARCADES_SPECIAL                = $21000404; (* apply special move *)
  {$EXTERNALSYM DIBUTTON_ARCADES_SPECIAL}
  DIBUTTON_ARCADES_SELECT                 = $21000405; (* select special move *)
  {$EXTERNALSYM DIBUTTON_ARCADES_SELECT}
  DIBUTTON_ARCADES_MENU                   = $210004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_ARCADES_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_ARCADES_VIEW                = $21004601; (* scroll view left / right / up / down *)
  {$EXTERNALSYM DIHATSWITCH_ARCADES_VIEW}
  DIBUTTON_ARCADES_LEFT_LINK              = $2100C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_ARCADES_LEFT_LINK}
  DIBUTTON_ARCADES_RIGHT_LINK             = $2100C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_ARCADES_RIGHT_LINK}
  DIBUTTON_ARCADES_FORWARD_LINK           = $210144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_ARCADES_FORWARD_LINK}
  DIBUTTON_ARCADES_BACK_LINK              = $210144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_ARCADES_BACK_LINK}
  DIBUTTON_ARCADES_VIEW_UP_LINK           = $2107C4E0; (* Fallback scroll view up button *)
  {$EXTERNALSYM DIBUTTON_ARCADES_VIEW_UP_LINK}
  DIBUTTON_ARCADES_VIEW_DOWN_LINK         = $2107C4E8; (* Fallback scroll view down button *)
  {$EXTERNALSYM DIBUTTON_ARCADES_VIEW_DOWN_LINK}
  DIBUTTON_ARCADES_VIEW_LEFT_LINK         = $2107C4E4; (* Fallback scroll view left button *)
  {$EXTERNALSYM DIBUTTON_ARCADES_VIEW_LEFT_LINK}
  DIBUTTON_ARCADES_VIEW_RIGHT_LINK        = $2107C4EC; (* Fallback scroll view right button *)
  {$EXTERNALSYM DIBUTTON_ARCADES_VIEW_RIGHT_LINK}
  DIBUTTON_ARCADES_DEVICE                 = $210044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_ARCADES_DEVICE}
  DIBUTTON_ARCADES_PAUSE                  = $210044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_ARCADES_PAUSE}

(*--- Arcade - Platform Game
      Character moves around on screen  ---*)
  DIVIRTUAL_ARCADE_PLATFORM               = $22000000;
  {$EXTERNALSYM DIVIRTUAL_ARCADE_PLATFORM}
  DIAXIS_ARCADEP_LATERAL                  = $22008201; (* Left / right *)
  {$EXTERNALSYM DIAXIS_ARCADEP_LATERAL}
  DIAXIS_ARCADEP_MOVE                     = $22010202; (* Up / down *)
  {$EXTERNALSYM DIAXIS_ARCADEP_MOVE}
  DIBUTTON_ARCADEP_JUMP                   = $22000401; (* Jump *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_JUMP}
  DIBUTTON_ARCADEP_FIRE                   = $22000402; (* Fire *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_FIRE}
  DIBUTTON_ARCADEP_CROUCH                 = $22000403; (* Crouch *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_CROUCH}
  DIBUTTON_ARCADEP_SPECIAL                = $22000404; (* Apply special move *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_SPECIAL}
  DIBUTTON_ARCADEP_SELECT                 = $22000405; (* Select special move *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_SELECT}
  DIBUTTON_ARCADEP_MENU                   = $220004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_ARCADEP_VIEW                = $22004601; (* Scroll view *)
  {$EXTERNALSYM DIHATSWITCH_ARCADEP_VIEW}
  DIBUTTON_ARCADEP_FIRESECONDARY          = $22004406; (* Alternative fire button *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_FIRESECONDARY}
  DIBUTTON_ARCADEP_LEFT_LINK              = $2200C4E4; (* Fallback sidestep left button *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_LEFT_LINK}
  DIBUTTON_ARCADEP_RIGHT_LINK             = $2200C4EC; (* Fallback sidestep right button *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_RIGHT_LINK}
  DIBUTTON_ARCADEP_FORWARD_LINK           = $220144E0; (* Fallback move forward button *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_FORWARD_LINK}
  DIBUTTON_ARCADEP_BACK_LINK              = $220144E8; (* Fallback move back button *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_BACK_LINK}
  DIBUTTON_ARCADEP_VIEW_UP_LINK           = $2207C4E0; (* Fallback scroll view up button *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_VIEW_UP_LINK}
  DIBUTTON_ARCADEP_VIEW_DOWN_LINK         = $2207C4E8; (* Fallback scroll view down button *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_VIEW_DOWN_LINK}
  DIBUTTON_ARCADEP_VIEW_LEFT_LINK         = $2207C4E4; (* Fallback scroll view left button *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_VIEW_LEFT_LINK}
  DIBUTTON_ARCADEP_VIEW_RIGHT_LINK        = $2207C4EC; (* Fallback scroll view right button *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_VIEW_RIGHT_LINK}
  DIBUTTON_ARCADEP_DEVICE                 = $220044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_DEVICE}
  DIBUTTON_ARCADEP_PAUSE                  = $220044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_ARCADEP_PAUSE}

(*--- CAD - 2D Object Control
      Controls to select and move objects in 2D  ---*)
  DIVIRTUAL_CAD_2DCONTROL                 = $23000000;
  {$EXTERNALSYM DIVIRTUAL_CAD_2DCONTROL}
  DIAXIS_2DCONTROL_LATERAL                = $23008201; (* Move view left / right *)
  {$EXTERNALSYM DIAXIS_2DCONTROL_LATERAL}
  DIAXIS_2DCONTROL_MOVE                   = $23010202; (* Move view up / down *)
  {$EXTERNALSYM DIAXIS_2DCONTROL_MOVE}
  DIAXIS_2DCONTROL_INOUT                  = $23018203; (* Zoom - in / out *)
  {$EXTERNALSYM DIAXIS_2DCONTROL_INOUT}
  DIBUTTON_2DCONTROL_SELECT               = $23000401; (* Select Object *)
  {$EXTERNALSYM DIBUTTON_2DCONTROL_SELECT}
  DIBUTTON_2DCONTROL_SPECIAL1             = $23000402; (* Do first special operation *)
  {$EXTERNALSYM DIBUTTON_2DCONTROL_SPECIAL1}
  DIBUTTON_2DCONTROL_SPECIAL              = $23000403; (* Select special operation *)
  {$EXTERNALSYM DIBUTTON_2DCONTROL_SPECIAL}
  DIBUTTON_2DCONTROL_SPECIAL2             = $23000404; (* Do second special operation *)
  {$EXTERNALSYM DIBUTTON_2DCONTROL_SPECIAL2}
  DIBUTTON_2DCONTROL_MENU                 = $230004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_2DCONTROL_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_2DCONTROL_HATSWITCH         = $23004601; (* Hat switch *)
  {$EXTERNALSYM DIHATSWITCH_2DCONTROL_HATSWITCH}
  DIAXIS_2DCONTROL_ROTATEZ                = $23024204; (* Rotate view clockwise / counterclockwise *)
  {$EXTERNALSYM DIAXIS_2DCONTROL_ROTATEZ}
  DIBUTTON_2DCONTROL_DISPLAY              = $23004405; (* Shows next on-screen display options *)
  {$EXTERNALSYM DIBUTTON_2DCONTROL_DISPLAY}
  DIBUTTON_2DCONTROL_DEVICE               = $230044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_2DCONTROL_DEVICE}
  DIBUTTON_2DCONTROL_PAUSE                = $230044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_2DCONTROL_PAUSE}

(*--- CAD - 3D object control
      Controls to select and move objects within a 3D environment  ---*)
  DIVIRTUAL_CAD_3DCONTROL                 = $24000000;
  {$EXTERNALSYM DIVIRTUAL_CAD_3DCONTROL}
  DIAXIS_3DCONTROL_LATERAL                = $24008201; (* Move view left / right *)
  {$EXTERNALSYM DIAXIS_3DCONTROL_LATERAL}
  DIAXIS_3DCONTROL_MOVE                   = $24010202; (* Move view up / down *)
  {$EXTERNALSYM DIAXIS_3DCONTROL_MOVE}
  DIAXIS_3DCONTROL_INOUT                  = $24018203; (* Zoom - in / out *)
  {$EXTERNALSYM DIAXIS_3DCONTROL_INOUT}
  DIBUTTON_3DCONTROL_SELECT               = $24000401; (* Select Object *)
  {$EXTERNALSYM DIBUTTON_3DCONTROL_SELECT}
  DIBUTTON_3DCONTROL_SPECIAL1             = $24000402; (* Do first special operation *)
  {$EXTERNALSYM DIBUTTON_3DCONTROL_SPECIAL1}
  DIBUTTON_3DCONTROL_SPECIAL              = $24000403; (* Select special operation *)
  {$EXTERNALSYM DIBUTTON_3DCONTROL_SPECIAL}
  DIBUTTON_3DCONTROL_SPECIAL2             = $24000404; (* Do second special operation *)
  {$EXTERNALSYM DIBUTTON_3DCONTROL_SPECIAL2}
  DIBUTTON_3DCONTROL_MENU                 = $240004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_3DCONTROL_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_3DCONTROL_HATSWITCH         = $24004601; (* Hat switch *)
  {$EXTERNALSYM DIHATSWITCH_3DCONTROL_HATSWITCH}
  DIAXIS_3DCONTROL_ROTATEX                = $24034204; (* Rotate view forward or up / backward or down *)
  {$EXTERNALSYM DIAXIS_3DCONTROL_ROTATEX}
  DIAXIS_3DCONTROL_ROTATEY                = $2402C205; (* Rotate view clockwise / counterclockwise *)
  {$EXTERNALSYM DIAXIS_3DCONTROL_ROTATEY}
  DIAXIS_3DCONTROL_ROTATEZ                = $24024206; (* Rotate view left / right *)
  {$EXTERNALSYM DIAXIS_3DCONTROL_ROTATEZ}
  DIBUTTON_3DCONTROL_DISPLAY              = $24004405; (* Show next on-screen display options *)
  {$EXTERNALSYM DIBUTTON_3DCONTROL_DISPLAY}
  DIBUTTON_3DCONTROL_DEVICE               = $240044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_3DCONTROL_DEVICE}
  DIBUTTON_3DCONTROL_PAUSE                = $240044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_3DCONTROL_PAUSE}

(*--- CAD - 3D Navigation - Fly through
      Controls for 3D modeling  ---*)
  DIVIRTUAL_CAD_FLYBY                     = $25000000;
  {$EXTERNALSYM DIVIRTUAL_CAD_FLYBY}
  DIAXIS_CADF_LATERAL                     = $25008201; (* move view left / right *)
  {$EXTERNALSYM DIAXIS_CADF_LATERAL}
  DIAXIS_CADF_MOVE                        = $25010202; (* move view up / down *)
  {$EXTERNALSYM DIAXIS_CADF_MOVE}
  DIAXIS_CADF_INOUT                       = $25018203; (* in / out *)
  {$EXTERNALSYM DIAXIS_CADF_INOUT}
  DIBUTTON_CADF_SELECT                    = $25000401; (* Select Object *)
  {$EXTERNALSYM DIBUTTON_CADF_SELECT}
  DIBUTTON_CADF_SPECIAL1                  = $25000402; (* do first special operation *)
  {$EXTERNALSYM DIBUTTON_CADF_SPECIAL1}
  DIBUTTON_CADF_SPECIAL                   = $25000403; (* Select special operation *)
  {$EXTERNALSYM DIBUTTON_CADF_SPECIAL}
  DIBUTTON_CADF_SPECIAL2                  = $25000404; (* do second special operation *)
  {$EXTERNALSYM DIBUTTON_CADF_SPECIAL2}
  DIBUTTON_CADF_MENU                      = $250004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_CADF_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_CADF_HATSWITCH              = $25004601; (* Hat switch *)
  {$EXTERNALSYM DIHATSWITCH_CADF_HATSWITCH}
  DIAXIS_CADF_ROTATEX                     = $25034204; (* Rotate view forward or up / backward or down *)
  {$EXTERNALSYM DIAXIS_CADF_ROTATEX}
  DIAXIS_CADF_ROTATEY                     = $2502C205; (* Rotate view clockwise / counterclockwise *)
  {$EXTERNALSYM DIAXIS_CADF_ROTATEY}
  DIAXIS_CADF_ROTATEZ                     = $25024206; (* Rotate view left / right *)
  {$EXTERNALSYM DIAXIS_CADF_ROTATEZ}
  DIBUTTON_CADF_DISPLAY                   = $25004405; (* shows next on-screen display options *)
  {$EXTERNALSYM DIBUTTON_CADF_DISPLAY}
  DIBUTTON_CADF_DEVICE                    = $250044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_CADF_DEVICE}
  DIBUTTON_CADF_PAUSE                     = $250044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_CADF_PAUSE}

(*--- CAD - 3D Model Control
      Controls for 3D modeling  ---*)
  DIVIRTUAL_CAD_MODEL                     = $26000000;
  {$EXTERNALSYM DIVIRTUAL_CAD_MODEL}
  DIAXIS_CADM_LATERAL                     = $26008201; (* move view left / right *)
  {$EXTERNALSYM DIAXIS_CADM_LATERAL}
  DIAXIS_CADM_MOVE                        = $26010202; (* move view up / down *)
  {$EXTERNALSYM DIAXIS_CADM_MOVE}
  DIAXIS_CADM_INOUT                       = $26018203; (* in / out *)
  {$EXTERNALSYM DIAXIS_CADM_INOUT}
  DIBUTTON_CADM_SELECT                    = $26000401; (* Select Object *)
  {$EXTERNALSYM DIBUTTON_CADM_SELECT}
  DIBUTTON_CADM_SPECIAL1                  = $26000402; (* do first special operation *)
  {$EXTERNALSYM DIBUTTON_CADM_SPECIAL1}
  DIBUTTON_CADM_SPECIAL                   = $26000403; (* Select special operation *)
  {$EXTERNALSYM DIBUTTON_CADM_SPECIAL}
  DIBUTTON_CADM_SPECIAL2                  = $26000404; (* do second special operation *)
  {$EXTERNALSYM DIBUTTON_CADM_SPECIAL2}
  DIBUTTON_CADM_MENU                      = $260004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_CADM_MENU}
(*--- Priority 2 controls                            ---*)

  DIHATSWITCH_CADM_HATSWITCH              = $26004601; (* Hat switch *)
  {$EXTERNALSYM DIHATSWITCH_CADM_HATSWITCH}
  DIAXIS_CADM_ROTATEX                     = $26034204; (* Rotate view forward or up / backward or down *)
  {$EXTERNALSYM DIAXIS_CADM_ROTATEX}
  DIAXIS_CADM_ROTATEY                     = $2602C205; (* Rotate view clockwise / counterclockwise *)
  {$EXTERNALSYM DIAXIS_CADM_ROTATEY}
  DIAXIS_CADM_ROTATEZ                     = $26024206; (* Rotate view left / right *)
  {$EXTERNALSYM DIAXIS_CADM_ROTATEZ}
  DIBUTTON_CADM_DISPLAY                   = $26004405; (* shows next on-screen display options *)
  {$EXTERNALSYM DIBUTTON_CADM_DISPLAY}
  DIBUTTON_CADM_DEVICE                    = $260044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_CADM_DEVICE}
  DIBUTTON_CADM_PAUSE                     = $260044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_CADM_PAUSE}

(*--- Control - Media Equipment
      Remote        ---*)
  DIVIRTUAL_REMOTE_CONTROL                = $27000000;
  {$EXTERNALSYM DIVIRTUAL_REMOTE_CONTROL}
  DIAXIS_REMOTE_SLIDER                    = $27050201; (* Slider for adjustment: volume / color / bass / etc *)
  {$EXTERNALSYM DIAXIS_REMOTE_SLIDER}
  DIBUTTON_REMOTE_MUTE                    = $27000401; (* Set volume on current device to zero *)
  {$EXTERNALSYM DIBUTTON_REMOTE_MUTE}
  DIBUTTON_REMOTE_SELECT                  = $27000402; (* Next/previous: channel/ track / chapter / picture / station *)
  {$EXTERNALSYM DIBUTTON_REMOTE_SELECT}
  DIBUTTON_REMOTE_PLAY                    = $27002403; (* Start or pause entertainment on current device *)
  {$EXTERNALSYM DIBUTTON_REMOTE_PLAY}
  DIBUTTON_REMOTE_CUE                     = $27002404; (* Move through current media *)
  {$EXTERNALSYM DIBUTTON_REMOTE_CUE}
  DIBUTTON_REMOTE_REVIEW                  = $27002405; (* Move through current media *)
  {$EXTERNALSYM DIBUTTON_REMOTE_REVIEW}
  DIBUTTON_REMOTE_CHANGE                  = $27002406; (* Select next device *)
  {$EXTERNALSYM DIBUTTON_REMOTE_CHANGE}
  DIBUTTON_REMOTE_RECORD                  = $27002407; (* Start recording the current media *)
  {$EXTERNALSYM DIBUTTON_REMOTE_RECORD}
  DIBUTTON_REMOTE_MENU                    = $270004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_REMOTE_MENU}
(*--- Priority 2 controls                            ---*)

  DIAXIS_REMOTE_SLIDER2                   = $27054202; (* Slider for adjustment: volume *)
  {$EXTERNALSYM DIAXIS_REMOTE_SLIDER2}
  DIBUTTON_REMOTE_TV                      = $27005C08; (* Select TV *)
  {$EXTERNALSYM DIBUTTON_REMOTE_TV}
  DIBUTTON_REMOTE_CABLE                   = $27005C09; (* Select cable box *)
  {$EXTERNALSYM DIBUTTON_REMOTE_CABLE}
  DIBUTTON_REMOTE_CD                      = $27005C0A; (* Select CD player *)
  {$EXTERNALSYM DIBUTTON_REMOTE_CD}
  DIBUTTON_REMOTE_VCR                     = $27005C0B; (* Select VCR *)
  {$EXTERNALSYM DIBUTTON_REMOTE_VCR}
  DIBUTTON_REMOTE_TUNER                   = $27005C0C; (* Select tuner *)
  {$EXTERNALSYM DIBUTTON_REMOTE_TUNER}
  DIBUTTON_REMOTE_DVD                     = $27005C0D; (* Select DVD player *)
  {$EXTERNALSYM DIBUTTON_REMOTE_DVD}
  DIBUTTON_REMOTE_ADJUST                  = $27005C0E; (* Enter device adjustment menu *)
  {$EXTERNALSYM DIBUTTON_REMOTE_ADJUST}
  DIBUTTON_REMOTE_DIGIT0                  = $2700540F; (* Digit 0 *)
  {$EXTERNALSYM DIBUTTON_REMOTE_DIGIT0}
  DIBUTTON_REMOTE_DIGIT1                  = $27005410; (* Digit 1 *)
  {$EXTERNALSYM DIBUTTON_REMOTE_DIGIT1}
  DIBUTTON_REMOTE_DIGIT2                  = $27005411; (* Digit 2 *)
  {$EXTERNALSYM DIBUTTON_REMOTE_DIGIT2}
  DIBUTTON_REMOTE_DIGIT3                  = $27005412; (* Digit 3 *)
  {$EXTERNALSYM DIBUTTON_REMOTE_DIGIT3}
  DIBUTTON_REMOTE_DIGIT4                  = $27005413; (* Digit 4 *)
  {$EXTERNALSYM DIBUTTON_REMOTE_DIGIT4}
  DIBUTTON_REMOTE_DIGIT5                  = $27005414; (* Digit 5 *)
  {$EXTERNALSYM DIBUTTON_REMOTE_DIGIT5}
  DIBUTTON_REMOTE_DIGIT6                  = $27005415; (* Digit 6 *)
  {$EXTERNALSYM DIBUTTON_REMOTE_DIGIT6}
  DIBUTTON_REMOTE_DIGIT7                  = $27005416; (* Digit 7 *)
  {$EXTERNALSYM DIBUTTON_REMOTE_DIGIT7}
  DIBUTTON_REMOTE_DIGIT8                  = $27005417; (* Digit 8 *)
  {$EXTERNALSYM DIBUTTON_REMOTE_DIGIT8}
  DIBUTTON_REMOTE_DIGIT9                  = $27005418; (* Digit 9 *)
  {$EXTERNALSYM DIBUTTON_REMOTE_DIGIT9}
  DIBUTTON_REMOTE_DEVICE                  = $270044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_REMOTE_DEVICE}
  DIBUTTON_REMOTE_PAUSE                   = $270044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_REMOTE_PAUSE}

(*--- Control- Web
      Help or Browser            ---*)
  DIVIRTUAL_BROWSER_CONTROL               = $28000000;
  {$EXTERNALSYM DIVIRTUAL_BROWSER_CONTROL}
  DIAXIS_BROWSER_LATERAL                  = $28008201; (* Move on screen pointer *)
  {$EXTERNALSYM DIAXIS_BROWSER_LATERAL}
  DIAXIS_BROWSER_MOVE                     = $28010202; (* Move on screen pointer *)
  {$EXTERNALSYM DIAXIS_BROWSER_MOVE}
  DIBUTTON_BROWSER_SELECT                 = $28000401; (* Select current item *)
  {$EXTERNALSYM DIBUTTON_BROWSER_SELECT}
  DIAXIS_BROWSER_VIEW                     = $28018203; (* Move view up/down *)
  {$EXTERNALSYM DIAXIS_BROWSER_VIEW}
  DIBUTTON_BROWSER_REFRESH                = $28000402; (* Refresh *)
  {$EXTERNALSYM DIBUTTON_BROWSER_REFRESH}
  DIBUTTON_BROWSER_MENU                   = $280004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_BROWSER_MENU}
(*--- Priority 2 controls                            ---*)

  DIBUTTON_BROWSER_SEARCH                 = $28004403; (* Use search tool *)
  {$EXTERNALSYM DIBUTTON_BROWSER_SEARCH}
  DIBUTTON_BROWSER_STOP                   = $28004404; (* Cease current update *)
  {$EXTERNALSYM DIBUTTON_BROWSER_STOP}
  DIBUTTON_BROWSER_HOME                   = $28004405; (* Go directly to "home" location *)
  {$EXTERNALSYM DIBUTTON_BROWSER_HOME}
  DIBUTTON_BROWSER_FAVORITES              = $28004406; (* Mark current site as favorite *)
  {$EXTERNALSYM DIBUTTON_BROWSER_FAVORITES}
  DIBUTTON_BROWSER_NEXT                   = $28004407; (* Select Next page *)
  {$EXTERNALSYM DIBUTTON_BROWSER_NEXT}
  DIBUTTON_BROWSER_PREVIOUS               = $28004408; (* Select Previous page *)
  {$EXTERNALSYM DIBUTTON_BROWSER_PREVIOUS}
  DIBUTTON_BROWSER_HISTORY                = $28004409; (* Show/Hide History *)
  {$EXTERNALSYM DIBUTTON_BROWSER_HISTORY}
  DIBUTTON_BROWSER_PRINT                  = $2800440A; (* Print current page *)
  {$EXTERNALSYM DIBUTTON_BROWSER_PRINT}
  DIBUTTON_BROWSER_DEVICE                 = $280044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_BROWSER_DEVICE}
  DIBUTTON_BROWSER_PAUSE                  = $280044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_BROWSER_PAUSE}

(*--- Driving Simulator - Giant Walking Robot
      Walking tank with weapons  ---*)
  DIVIRTUAL_DRIVING_MECHA                 = $29000000;
  {$EXTERNALSYM DIVIRTUAL_DRIVING_MECHA}
  DIAXIS_MECHA_STEER                      = $29008201; (* Turns mecha left/right *)
  {$EXTERNALSYM DIAXIS_MECHA_STEER}
  DIAXIS_MECHA_TORSO                      = $29010202; (* Tilts torso forward/backward *)
  {$EXTERNALSYM DIAXIS_MECHA_TORSO}
  DIAXIS_MECHA_ROTATE                     = $29020203; (* Turns torso left/right *)
  {$EXTERNALSYM DIAXIS_MECHA_ROTATE}
  DIAXIS_MECHA_THROTTLE                   = $29038204; (* Engine Speed *)
  {$EXTERNALSYM DIAXIS_MECHA_THROTTLE}
  DIBUTTON_MECHA_FIRE                     = $29000401; (* Fire *)
  {$EXTERNALSYM DIBUTTON_MECHA_FIRE}
  DIBUTTON_MECHA_WEAPONS                  = $29000402; (* Select next weapon group *)
  {$EXTERNALSYM DIBUTTON_MECHA_WEAPONS}
  DIBUTTON_MECHA_TARGET                   = $29000403; (* Select closest enemy available target *)
  {$EXTERNALSYM DIBUTTON_MECHA_TARGET}
  DIBUTTON_MECHA_REVERSE                  = $29000404; (* Toggles throttle in/out of reverse *)
  {$EXTERNALSYM DIBUTTON_MECHA_REVERSE}
  DIBUTTON_MECHA_ZOOM                     = $29000405; (* Zoom in/out targeting reticule *)
  {$EXTERNALSYM DIBUTTON_MECHA_ZOOM}
  DIBUTTON_MECHA_JUMP                     = $29000406; (* Fires jump jets *)
  {$EXTERNALSYM DIBUTTON_MECHA_JUMP}
  DIBUTTON_MECHA_MENU                     = $290004FD; (* Show menu options *)
  {$EXTERNALSYM DIBUTTON_MECHA_MENU}
(*--- Priority 2 controls                            ---*)

  DIBUTTON_MECHA_CENTER                   = $29004407; (* Center torso to legs *)
  {$EXTERNALSYM DIBUTTON_MECHA_CENTER}
  DIHATSWITCH_MECHA_GLANCE                = $29004601; (* Look around *)
  {$EXTERNALSYM DIHATSWITCH_MECHA_GLANCE}
  DIBUTTON_MECHA_VIEW                     = $29004408; (* Cycle through view options *)
  {$EXTERNALSYM DIBUTTON_MECHA_VIEW}
  DIBUTTON_MECHA_FIRESECONDARY            = $29004409; (* Alternative fire button *)
  {$EXTERNALSYM DIBUTTON_MECHA_FIRESECONDARY}
  DIBUTTON_MECHA_LEFT_LINK                = $2900C4E4; (* Fallback steer left button *)
  {$EXTERNALSYM DIBUTTON_MECHA_LEFT_LINK}
  DIBUTTON_MECHA_RIGHT_LINK               = $2900C4EC; (* Fallback steer right button *)
  {$EXTERNALSYM DIBUTTON_MECHA_RIGHT_LINK}
  DIBUTTON_MECHA_FORWARD_LINK             = $290144E0; (* Fallback tilt torso forward button *)
  {$EXTERNALSYM DIBUTTON_MECHA_FORWARD_LINK}
  DIBUTTON_MECHA_BACK_LINK                = $290144E8; (* Fallback tilt toroso backward button *)
  {$EXTERNALSYM DIBUTTON_MECHA_BACK_LINK}
  DIBUTTON_MECHA_ROTATE_LEFT_LINK         = $290244E4; (* Fallback rotate toroso right button *)
  {$EXTERNALSYM DIBUTTON_MECHA_ROTATE_LEFT_LINK}
  DIBUTTON_MECHA_ROTATE_RIGHT_LINK        = $290244EC; (* Fallback rotate torso left button *)
  {$EXTERNALSYM DIBUTTON_MECHA_ROTATE_RIGHT_LINK}
  DIBUTTON_MECHA_FASTER_LINK              = $2903C4E0; (* Fallback increase engine speed *)
  {$EXTERNALSYM DIBUTTON_MECHA_FASTER_LINK}
  DIBUTTON_MECHA_SLOWER_LINK              = $2903C4E8; (* Fallback decrease engine speed *)
  {$EXTERNALSYM DIBUTTON_MECHA_SLOWER_LINK}
  DIBUTTON_MECHA_DEVICE                   = $290044FE; (* Show input device and controls *)
  {$EXTERNALSYM DIBUTTON_MECHA_DEVICE}
  DIBUTTON_MECHA_PAUSE                    = $290044FC; (* Start / Pause / Restart game *)
  {$EXTERNALSYM DIBUTTON_MECHA_PAUSE}

(*
 *  "ANY" semantics can be used as a last resort to get mappings for actions
 *  that match nothing in the chosen virtual genre.  These semantics will be
 *  mapped at a lower priority that virtual genre semantics.  Also, hardware
 *  vendors will not be able to provide sensible mappings for these unless
 *  they provide application specific mappings.
 *)
  DIAXIS_ANY_X_1                          = $FF00C201;
  {$EXTERNALSYM DIAXIS_ANY_X_1}
  DIAXIS_ANY_X_2                          = $FF00C202;
  {$EXTERNALSYM DIAXIS_ANY_X_2}
  DIAXIS_ANY_Y_1                          = $FF014201;
  {$EXTERNALSYM DIAXIS_ANY_Y_1}
  DIAXIS_ANY_Y_2                          = $FF014202;
  {$EXTERNALSYM DIAXIS_ANY_Y_2}
  DIAXIS_ANY_Z_1                          = $FF01C201;
  {$EXTERNALSYM DIAXIS_ANY_Z_1}
  DIAXIS_ANY_Z_2                          = $FF01C202;
  {$EXTERNALSYM DIAXIS_ANY_Z_2}
  DIAXIS_ANY_R_1                          = $FF024201;
  {$EXTERNALSYM DIAXIS_ANY_R_1}
  DIAXIS_ANY_R_2                          = $FF024202;
  {$EXTERNALSYM DIAXIS_ANY_R_2}
  DIAXIS_ANY_U_1                          = $FF02C201;
  {$EXTERNALSYM DIAXIS_ANY_U_1}
  DIAXIS_ANY_U_2                          = $FF02C202;
  {$EXTERNALSYM DIAXIS_ANY_U_2}
  DIAXIS_ANY_V_1                          = $FF034201;
  {$EXTERNALSYM DIAXIS_ANY_V_1}
  DIAXIS_ANY_V_2                          = $FF034202;
  {$EXTERNALSYM DIAXIS_ANY_V_2}
  DIAXIS_ANY_A_1                          = $FF03C201;
  {$EXTERNALSYM DIAXIS_ANY_A_1}
  DIAXIS_ANY_A_2                          = $FF03C202;
  {$EXTERNALSYM DIAXIS_ANY_A_2}
  DIAXIS_ANY_B_1                          = $FF044201;
  {$EXTERNALSYM DIAXIS_ANY_B_1}
  DIAXIS_ANY_B_2                          = $FF044202;
  {$EXTERNALSYM DIAXIS_ANY_B_2}
  DIAXIS_ANY_C_1                          = $FF04C201;
  {$EXTERNALSYM DIAXIS_ANY_C_1}
  DIAXIS_ANY_C_2                          = $FF04C202;
  {$EXTERNALSYM DIAXIS_ANY_C_2}
  DIAXIS_ANY_S_1                          = $FF054201;
  {$EXTERNALSYM DIAXIS_ANY_S_1}
  DIAXIS_ANY_S_2                          = $FF054202;
  {$EXTERNALSYM DIAXIS_ANY_S_2}

  DIAXIS_ANY_1                            = $FF004201;
  {$EXTERNALSYM DIAXIS_ANY_1}
  DIAXIS_ANY_2                            = $FF004202;
  {$EXTERNALSYM DIAXIS_ANY_2}
  DIAXIS_ANY_3                            = $FF004203;
  {$EXTERNALSYM DIAXIS_ANY_3}
  DIAXIS_ANY_4                            = $FF004204;
  {$EXTERNALSYM DIAXIS_ANY_4}

  DIPOV_ANY_1                             = $FF004601;
  {$EXTERNALSYM DIPOV_ANY_1}
  DIPOV_ANY_2                             = $FF004602;
  {$EXTERNALSYM DIPOV_ANY_2}
  DIPOV_ANY_3                             = $FF004603;
  {$EXTERNALSYM DIPOV_ANY_3}
  DIPOV_ANY_4                             = $FF004604;
  {$EXTERNALSYM DIPOV_ANY_4}

// #define DIBUTTON_ANY(instance)                  ( 0xFF004400 | instance )
function DIBUTTON_ANY(instance: Cardinal): Cardinal;
{$EXTERNALSYM DIBUTTON_ANY}



(****************************************************************************
 *
 *  Definitions for non-IDirectInput (VJoyD) features defined more recently
 *  than the current sdk files
 *
 ****************************************************************************)

//#ifdef _INC_MMSYSTEM
//#ifndef MMNOJOY

//#ifndef __VJOYDX_INCLUDED__
//#define __VJOYDX_INCLUDED__

const
(*
 * Flag to indicate that the dwReserved2 field of the JOYINFOEX structure
 * contains mini-driver specific data to be passed by VJoyD to the mini-
 * driver instead of doing a poll.
 *)
  JOY_PASSDRIVERDATA          = $10000000;
  {$EXTERNALSYM JOY_PASSDRIVERDATA}

(*
 * Informs the joystick driver that the configuration has been changed
 * and should be reloaded from the registery.
 * dwFlags is reserved and should be set to zero
 *)
const
  WinMMDll = 'WinMM.dll';
function joyConfigChanged(dwFlags: DWORD): MMRESULT; stdcall; external WinMMDll;
{$EXTERNALSYM joyConfigChanged}

(*
 * Invoke the joystick control panel directly, using the passed window handle
 * as the parent of the dialog.  This API is only supported for compatibility
 * purposes; new applications should use the RunControlPanel method of a
 * device interface for a game controller.
 * The API is called by using the function pointer returned by
 * GetProcAddress( hCPL, TEXT("ShowJoyCPL") ) where hCPL is a HMODULE returned
 * by LoadLibrary( TEXT("joy.cpl") ).  The typedef is provided to allow
 * declaration and casting of an appropriately typed variable.
 *)
const
  JoyCPL = 'joy.cpl';
type
  TShowJoyCPL =  procedure(hWnd: HWND); stdcall;
procedure ShowJoyCPL(hWnd: HWND); stdcall; external JoyCPL;
{$EXTERNALSYM ShowJoyCPL}

const
(*
 * Hardware Setting indicating that the device is a headtracker
 *)
  JOY_HWS_ISHEADTRACKER       = $02000000;
  {$EXTERNALSYM JOY_HWS_ISHEADTRACKER}

(*
 * Hardware Setting indicating that the VxD is used to replace
 * the standard analog polling
 *)
  JOY_HWS_ISGAMEPORTDRIVER    = $04000000;
  {$EXTERNALSYM JOY_HWS_ISGAMEPORTDRIVER}

(*
 * Hardware Setting indicating that the driver needs a standard
 * gameport in order to communicate with the device.
 *)
  JOY_HWS_ISANALOGPORTDRIVER  = $08000000;
  {$EXTERNALSYM JOY_HWS_ISANALOGPORTDRIVER}

(*
 * Hardware Setting indicating that VJoyD should not load this
 * driver, it will be loaded externally and will register with
 * VJoyD of it's own accord.
 *)
  JOY_HWS_AUTOLOAD            = $10000000;
  {$EXTERNALSYM JOY_HWS_AUTOLOAD}

(*
 * Hardware Setting indicating that the driver acquires any
 * resources needed without needing a devnode through VJoyD.
 *)
  JOY_HWS_NODEVNODE           = $20000000;
  {$EXTERNALSYM JOY_HWS_NODEVNODE}


(*
 * Hardware Setting indicating that the device is a gameport bus
 *)
  JOY_HWS_ISGAMEPORTBUS       = $80000000;
  {$EXTERNALSYM JOY_HWS_ISGAMEPORTBUS}
  JOY_HWS_GAMEPORTBUSBUSY     = $00000001;
  {$EXTERNALSYM JOY_HWS_GAMEPORTBUSBUSY}

(*
 * Usage Setting indicating that the settings are volatile and
 * should be removed if still present on a reboot.
 *)
  JOY_US_VOLATILE             = $00000008;
  {$EXTERNALSYM JOY_US_VOLATILE}

//#endif  (* __VJOYDX_INCLUDED__ *)

//#endif  (* not MMNOJOY *)
//#endif  (* _INC_MMSYSTEM *)

(****************************************************************************
 *
 *  Definitions for non-IDirectInput (VJoyD) features defined more recently
 *  than the current ddk files
 *
 ****************************************************************************)

//#ifdef _INC_MMDDK
//#ifndef MMNOJOYDEV

//#ifndef __VJOYDXD_INCLUDED__
//#define __VJOYDXD_INCLUDED__

const
(*
 * Poll type in which the do_other field of the JOYOEMPOLLDATA
 * structure contains mini-driver specific data passed from an app.
 *)
  JOY_OEMPOLL_PASSDRIVERDATA  = 7;
  {$EXTERNALSYM JOY_OEMPOLL_PASSDRIVERDATA}

//#endif  (* __VJOYDXD_INCLUDED__ *)

//#endif  (* not MMNOJOYDEV *)
//#endif  (* _INC_MMDDK *)

implementation

//#define DIEFT_GETTYPE(n)            LOBYTE(n)
function DIEFT_GETTYPE(n: Cardinal): Byte;
begin
  Result := LOBYTE(n);
end;

// #define GET_DIDEVICE_TYPE(dwDevType)    LOBYTE(dwDevType)
function GET_DIDEVICE_TYPE(dwDevType: DWORD): Byte;
begin
  Result := LOBYTE(dwDevType);
end;

// #define GET_DIDEVICE_SUBTYPE(dwDevType) HIBYTE(dwDevType)
function GET_DIDEVICE_SUBTYPE(dwDevType: DWORD): Byte;
begin
  Result := HiByte(Word(dwDevType));
end;

// #define DIDFT_MAKEINSTANCE(n) ((WORD)(n) << 8)
function DIDFT_MAKEINSTANCE(n: Cardinal): Cardinal;
begin
  Result := Word(n) shl 8;
end;

// #define DIDFT_GETTYPE(n)     LOBYTE(n)
function DIDFT_GETTYPE(n: Cardinal): Byte;
begin
  Result := LOBYTE(n);
end;

// #define DIDFT_GETINSTANCE(n) LOWORD((n) >> 8)
function DIDFT_GETINSTANCE(n: Cardinal): Cardinal;
begin
  Result := LOWORD(n) shr 8;
end;

// #define DIDFT_ENUMCOLLECTION(n) ((WORD)(n) << 8)
function DIDFT_ENUMCOLLECTION(n: Cardinal): Cardinal;
begin
  Result := Word(n) shl 8;
end;

 (* #if(DIRECTINPUT_VERSION >= 0x050a) *)
// #define DIMAKEUSAGEDWORD(UsagePage, Usage) \
//                                 (DWORD)MAKELONG(Usage, UsagePage)
function DIMAKEUSAGEDWORD(UsagePage, Usage: Word): DWORD;
begin
  Result:= DWORD(MakeLong(UsagePage, Usage));
end;
 (* DIRECTINPUT_VERSION >= 0x050a *)

//  #define DIJOFS_SLIDER(n)   (FIELD_OFFSET(DIJOYSTATE, rglSlider) + \
//                              (n) * sizeof(LONG))
function DIJOFS_SLIDER(n: Cardinal): Cardinal;
begin
  Result := Cardinal(@PDIJoyState(nil)^.rglSlider) + n*SizeOf(DWORD); //  + 24;
end;

// #define DIJOFS_POV(n)      (FIELD_OFFSET(DIJOYSTATE, rgdwPOV) + \
//                              (n) * sizeof(DWORD))
function DIJOFS_POV(n: Cardinal): Cardinal;
begin
  Result := Cardinal(@PDIJoyState(nil).rgdwPOV) + n*SizeOf(DWORD); //  + 32;
end;

// #define DIJOFS_BUTTON(n)   (FIELD_OFFSET(DIJOYSTATE, rgbButtons) + (n))
function DIJOFS_BUTTON(n: Cardinal): Cardinal;
begin
  Result := Cardinal(@PDIJoyState(nil).rgbButtons) + n*SizeOf(DWORD); //  + 48;
end;

// #define DIBUTTON_ANY(instance)                  ( 0xFF004400 | instance )
function DIBUTTON_ANY(instance: Cardinal): Cardinal;
begin
  Result := $FF004400 or instance;
end;


function DirectInputLoaded: Boolean;
begin // Stub function for static linking
  Result:= True;
end;

function UnLoadDirectInput: Boolean;
begin // Stub function for static linking
  Result:= True; // should emulate "normal" behaviour
end;

function LoadDirectInput: Boolean;
begin // Stub function for static linking
  Result:= True;
end;


end.
