{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      X3DAudio.h                                                    *}
{*  Content:    Cross-platform stand-alone 3D audio math library              *}
{*                                                                            *}
{*  DirectX 9.0 Delphi / FreePascal adaptation by Alexey Barkovoy             *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://www.clootie.ru                                                   *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
{*----------------------------------------------------------------------------*}
{*  $Id: X3DAudio.pas,v 1.7 2007/04/14 20:57:43 clootie Exp $ }
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

(*-========================================================================-_
 |                               - X3DAUDIO -                               |
 |        Copyright (c) Microsoft Corporation.  All rights reserved.        |
 |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
 |VERSION:  0.1                         MODEL:   Unmanaged User-mode        |
 |CONTRACT: N / A                       EXCEPT:  No Exceptions              |
 |PARENT:   N / A                       MINREQ:  Win2000, Xenon             |
 |PROJECT:  X3DAudio                    DIALECT: MS Visual C++ 7.0          |
 |>------------------------------------------------------------------------<|
 | DUTY: Cross-platform stand-alone 3D audio math library                   |
 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
  NOTES:
    1.  USE THE DEBUG X3DAUDIO DLL TO ENABLE PARAMETER VALIDATION VIA ASSERTS!
        Here's how:
        Copy X3DAudioD1_X.dll to where your application exists.
        The dll can be found in the DXSDK under Utilities\Bin\x86\ (or x64).
        Rename X3DAudioD1_X.dll to X3DAudio1_X.dll to use the debug version.

        Only parameters required by DSP settings being calculated as
        stipulated by the calculation control flags are validated.

    2.  Definition of terms:
            LFE: Low Frequency Effect -- always omnidirectional.
            LPF: Low Pass Filter, divided into two classifications:
                 Direct -- Applied to the direct signal path,
                           used for obstruction/occlusion effect.
                 Reverb -- Applied to the reverb signal path,
                           used for occlusion effect only.

    3.  Volume level is expressed as a linear amplitude scaler:
        1.0f represents no attenuation applied to the original signal,
        0.5f denotes an attenuation of 6dB, and 0.0f results in silence.
        Amplification (volume > 1.0f) is also allowed, and is not clamped.

    4.  X3DAudio uses a left-handed Cartesian coordinate system with values
        on the x-axis increasing from left to right, on the y-axis from
        bottom to top, and on the z-axis from near to far.
        Azimuths are measured clockwise from a given reference direction.

        Distance measurement is with respect to user-defined world units.
        Applications may provide coordinates using any system of measure
        as all non-normalized calculations are scale invariant, with such
        operations natively occurring in the user-defined world unit space.
        Metric constants are supplied only as a convenience.
        Distance is calculated using the Euclidean norm formula.

    5.  Only real values are permissible with functions using 32-bit
        float parameters -- NAN and infinite values are not accepted.
        All computation occurs in 32-bit precision mode.                    *)

{$MINENUMSIZE 4}
{$ALIGN ON}

unit X3DAudio;

interface

(*$HPPEMIT '#include "X3DAudio.h"' *)

//--------------<D-E-F-I-N-I-T-I-O-N-S>-------------------------------------//
uses
  Windows,
  DXTypes, Direct3D9;

const
  X3DAudioDLL = 'X3DAudio.dll';

  // speaker geometry configuration flags, specifies assignment of channels to speaker positions, defined as per WAVEFORMATEXTENSIBLE.dwChannelMask
  SPEAKER_FRONT_LEFT            = $00000001;
  {$EXTERNALSYM SPEAKER_FRONT_LEFT}
  SPEAKER_FRONT_RIGHT           = $00000002;
  {$EXTERNALSYM SPEAKER_FRONT_RIGHT}
  SPEAKER_FRONT_CENTER          = $00000004;
  {$EXTERNALSYM SPEAKER_FRONT_CENTER}
  SPEAKER_LOW_FREQUENCY         = $00000008;
  {$EXTERNALSYM SPEAKER_LOW_FREQUENCY}
  SPEAKER_BACK_LEFT             = $00000010;
  {$EXTERNALSYM SPEAKER_BACK_LEFT}
  SPEAKER_BACK_RIGHT            = $00000020;
  {$EXTERNALSYM SPEAKER_BACK_RIGHT}
  SPEAKER_FRONT_LEFT_OF_CENTER  = $00000040;
  {$EXTERNALSYM SPEAKER_FRONT_LEFT_OF_CENTER}
  SPEAKER_FRONT_RIGHT_OF_CENTER = $00000080;
  {$EXTERNALSYM SPEAKER_FRONT_RIGHT_OF_CENTER}
  SPEAKER_BACK_CENTER           = $00000100;
  {$EXTERNALSYM SPEAKER_BACK_CENTER}
  SPEAKER_SIDE_LEFT             = $00000200;
  {$EXTERNALSYM SPEAKER_SIDE_LEFT}
  SPEAKER_SIDE_RIGHT            = $00000400;
  {$EXTERNALSYM SPEAKER_SIDE_RIGHT}
  SPEAKER_TOP_CENTER            = $00000800;
  {$EXTERNALSYM SPEAKER_TOP_CENTER}
  SPEAKER_TOP_FRONT_LEFT        = $00001000;
  {$EXTERNALSYM SPEAKER_TOP_FRONT_LEFT}
  SPEAKER_TOP_FRONT_CENTER      = $00002000;
  {$EXTERNALSYM SPEAKER_TOP_FRONT_CENTER}
  SPEAKER_TOP_FRONT_RIGHT       = $00004000;
  {$EXTERNALSYM SPEAKER_TOP_FRONT_RIGHT}
  SPEAKER_TOP_BACK_LEFT         = $00008000;
  {$EXTERNALSYM SPEAKER_TOP_BACK_LEFT}
  SPEAKER_TOP_BACK_CENTER       = $00010000;
  {$EXTERNALSYM SPEAKER_TOP_BACK_CENTER}
  SPEAKER_TOP_BACK_RIGHT        = $00020000;
  {$EXTERNALSYM SPEAKER_TOP_BACK_RIGHT}
  SPEAKER_RESERVED              = $7FFC0000; // bit mask locations reserved for future use
  {$EXTERNALSYM SPEAKER_RESERVED}
  SPEAKER_ALL                   = $80000000; // used to specify that any possible permutation of speaker configurations
  {$EXTERNALSYM SPEAKER_ALL}

  // standard speaker geometry configurations, used with X3DAudioInitialize
  SPEAKER_STEREO  = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT);
  {$EXTERNALSYM SPEAKER_STEREO}
  SPEAKER_2POINT1          = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_LOW_FREQUENCY);
  {$EXTERNALSYM SPEAKER_2POINT1}
  SPEAKER_SURROUND         = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_FRONT_CENTER or SPEAKER_BACK_CENTER);
  {$EXTERNALSYM SPEAKER_SURROUND}
  SPEAKER_QUAD             = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_BACK_LEFT or SPEAKER_BACK_RIGHT);
  {$EXTERNALSYM SPEAKER_QUAD}
  SPEAKER_4POINT1          = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_LOW_FREQUENCY or SPEAKER_BACK_LEFT or SPEAKER_BACK_RIGHT);
  {$EXTERNALSYM SPEAKER_4POINT1}
  SPEAKER_5POINT1          = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_FRONT_CENTER or SPEAKER_LOW_FREQUENCY or SPEAKER_BACK_LEFT or SPEAKER_BACK_RIGHT);
  {$EXTERNALSYM SPEAKER_5POINT1}
  SPEAKER_7POINT1          = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_FRONT_CENTER or SPEAKER_LOW_FREQUENCY or SPEAKER_BACK_LEFT or SPEAKER_BACK_RIGHT or SPEAKER_FRONT_LEFT_OF_CENTER or SPEAKER_FRONT_RIGHT_OF_CENTER);
  {$EXTERNALSYM SPEAKER_7POINT1}
  SPEAKER_5POINT1_SURROUND = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_FRONT_CENTER or SPEAKER_LOW_FREQUENCY or SPEAKER_SIDE_LEFT  or SPEAKER_SIDE_RIGHT);
  {$EXTERNALSYM SPEAKER_5POINT1_SURROUND}
  SPEAKER_7POINT1_SURROUND = (SPEAKER_FRONT_LEFT or SPEAKER_FRONT_RIGHT or SPEAKER_FRONT_CENTER or SPEAKER_LOW_FREQUENCY or SPEAKER_BACK_LEFT or SPEAKER_BACK_RIGHT or SPEAKER_SIDE_LEFT  or SPEAKER_SIDE_RIGHT);
  {$EXTERNALSYM SPEAKER_7POINT1_SURROUND}

  // xenon speaker geometry configuration, used with X3DAudioInitialize


  X3DAUDIO_HANDLE_BYTESIZE = 20; // size of instance handle in bytes
  {$EXTERNALSYM X3DAUDIO_HANDLE_BYTESIZE}

  // float math constants
  X3DAUDIO_PI  = 3.141592654;
  {$EXTERNALSYM X3DAUDIO_PI}
  X3DAUDIO_2PI = 6.283185307;
  {$EXTERNALSYM X3DAUDIO_2PI}

  // speed of sound in meters per second for dry air at approximately 20C, used with X3DAudioInitialize
  X3DAUDIO_SPEED_OF_SOUND = 343.5;
  {$EXTERNALSYM X3DAUDIO_SPEED_OF_SOUND}

  // calculation control flags, used with X3DAudioCalculate
  X3DAUDIO_CALCULATE_MATRIX        = $00000001; // enable matrix coefficient table calculation
  {$EXTERNALSYM X3DAUDIO_CALCULATE_MATRIX}
  X3DAUDIO_CALCULATE_DELAY         = $00000002; // enable delay time array calculation (stereo final mix only)
  {$EXTERNALSYM X3DAUDIO_CALCULATE_DELAY}
  X3DAUDIO_CALCULATE_LPF_DIRECT    = $00000004; // enable LPF direct-path coefficient calculation
  {$EXTERNALSYM X3DAUDIO_CALCULATE_LPF_DIRECT}
  X3DAUDIO_CALCULATE_LPF_REVERB    = $00000008; // enable LPF reverb-path coefficient calculation
  {$EXTERNALSYM X3DAUDIO_CALCULATE_LPF_REVERB}
  X3DAUDIO_CALCULATE_REVERB        = $00000010; // enable reverb send level calculation
  {$EXTERNALSYM X3DAUDIO_CALCULATE_REVERB}
  X3DAUDIO_CALCULATE_DOPPLER       = $00000020; // enable doppler shift factor calculation
  {$EXTERNALSYM X3DAUDIO_CALCULATE_DOPPLER}
  X3DAUDIO_CALCULATE_EMITTER_ANGLE = $00000040; // enable emitter-to-listener interior angle calculation
  {$EXTERNALSYM X3DAUDIO_CALCULATE_EMITTER_ANGLE}

  X3DAUDIO_CALCULATE_ZEROCENTER    = $00010000; // do not position to front center speaker, center destination channel will be zero in returned matrix coefficient table, used only for matrix calculations and only for final mix formats that have a front center channel
  {$EXTERNALSYM X3DAUDIO_CALCULATE_ZEROCENTER}


//--------------<M-A-C-R-O-S>-----------------------------------------------//
  // function storage-class attribute and calltype
{ #if defined(_XBOX) || defined(X3DAUDIOSTATIC)
  #define X3DAUDIO_API_(type) EXTERN_C type STDAPICALLTYPE
  $ELSE
      #if defined(X3DEXPORT)
          #define X3DAUDIO_API_(type) EXTERN_C __declspec(dllexport) type STDAPICALLTYPE
      #else
          #define X3DAUDIO_API_(type) EXTERN_C __declspec(dllimport) type STDAPICALLTYPE
      #endif
  $ENDIF
  #define X3DAUDIO_IMP_(type) type STDMETHODCALLTYPE
}


//--------------<D-A-T-A---T-Y-P-E-S>---------------------------------------//
type
  // primitive types
  //typedef INT_PTR
  NWORD = INT_PTR;    // natural machine word, bytesize platform specific
  {$EXTERNALSYM NWORD}
  UNWORD = UINT_PTR;  // unsigned natural machine word, bytesize platform specific
  {$EXTERNALSYM UNWORD}
  FLOAT32 = Single;   // 32-bit IEEE float
  {$EXTERNALSYM FLOAT32}
  X3DAUDIO_VECTOR = TD3DVector; // float 3D vector
  {$EXTERNALSYM X3DAUDIO_VECTOR}
  TX3DAudioVector = TD3DVector; // float 3D vector

  // instance handle to precalculated constants
  X3DAUDIO_HANDLE = array[0..X3DAUDIO_HANDLE_BYTESIZE-1] of Byte;
  {$EXTERNALSYM X3DAUDIO_HANDLE}
  TX3DAudioHandle = X3DAUDIO_HANDLE;
  {$NODEFINE TX3DAudioHandle}
  {$HPPEMIT 'typedef X3DAUDIO_HANDLE TX3DAudioHandle'}


  // Distance curve point:
  // Defines a DSP setting at a given normalized distance.
  PX3DAudioDistanceCurvePoint = ^TX3DAudioDistanceCurvePoint;
  X3DAUDIO_DISTANCE_CURVE_POINT = record
    Distance: FLOAT32;   // normalized distance, must be within [0.0f, 1.0f]
    DSPSetting: FLOAT32; // DSP control setting
  end;
  {$EXTERNALSYM X3DAUDIO_DISTANCE_CURVE_POINT}
  TX3DAudioDistanceCurvePoint = X3DAUDIO_DISTANCE_CURVE_POINT;

  // Distance curve:
  // A piecewise curve made up of linear segments used to
  // define DSP behaviour with respect to normalized distance.
  //
  // Note that curve point distances are normalized within [0.0f, 1.0f].
  // X3DAUDIO_EMITTER.CurveDistanceScaler must be used to scale the
  // normalized distances to user-defined world units.
  // For distances beyond CurveDistanceScaler * 1.0f,
  // pPoints[PointCount-1].DSPSetting is used as the DSP setting.
  //
  // All distance curve spans must be such that:
  //      pPoints[k-1].DSPSetting + ((pPoints[k].DSPSetting-pPoints[k-1].DSPSetting) / (pPoints[k].Distance-pPoints[k-1].Distance)) * (pPoints[k].Distance-pPoints[k-1].Distance) != NAN or infinite values
  // For all points in the distance curve where 1 <= k < PointCount.
  PX3DAudioDistanceCurve = ^TX3DAudioDistanceCurve;
  X3DAUDIO_DISTANCE_CURVE = record
    pPoints: PX3DAudioDistanceCurvePoint;    // distance curve point array, must have at least PointCount elements with no duplicates and be sorted in ascending order with respect to Distance
    PointCount: LongWord;                    // number of distance curve points, must be >= 2 as all distance curves must have at least two endpoints, defining DSP settings at 0.0f and 1.0f normalized distance
  end;
  {$EXTERNALSYM X3DAUDIO_DISTANCE_CURVE}
  TX3DAudioDistanceCurve = X3DAUDIO_DISTANCE_CURVE;

const
  X3DAudioDefault_LinearCurvePoints: array[0..1] of TX3DAudioDistanceCurvePoint = (
    (Distance: 0.0; DSPSetting: 1.0),
    (Distance: 1.0; DSPSetting: 0.0) );
  {$EXTERNALSYM X3DAudioDefault_LinearCurvePoints}
  X3DAudioDefault_LinearCurve: TX3DAudioDistanceCurve = ( pPoints: @X3DAudioDefault_LinearCurvePoints[0]; PointCount: 2 );
  {$EXTERNALSYM X3DAudioDefault_LinearCurve}

type
  // Cone:
  // Specifies directionality for a single-channel emitter by
  // scaling DSP behaviour with respect to the emitter's front orientation.
  // This is modeled using two sound cones: an inner cone and an outer cone.
  // On/within the inner cone, DSP settings are scaled by the inner values.
  // On/beyond the outer cone, DSP settings are scaled by the outer values.
  // If on both the cones, DSP settings are scaled by the inner values only.
  // Between the two cones, the scaler is linearly interpolated between the
  // inner and outer values.  Set both cone angles to 0 or X3DAUDIO_2PI for
  // omnidirectionality using only the outer or inner values respectively.
  PX3DAudioCone = ^TX3DAudioCone;
  X3DAUDIO_CONE = record
    InnerAngle: FLOAT32; // inner cone angle in radians, must be within [0.0f, X3DAUDIO_2PI]
    OuterAngle: FLOAT32; // outer cone angle in radians, must be within [InnerAngle, X3DAUDIO_2PI]

    InnerVolume: FLOAT32; // volume level scaler on/within inner cone, used only for matrix calculations, must be within [0.0f, 2.0f] when used
    OuterVolume: FLOAT32; // volume level scaler on/beyond outer cone, used only for matrix calculations, must be within [0.0f, 2.0f] when used
    InnerLPF: FLOAT32;    // LPF (both direct and reverb paths) coefficient scaler on/within inner cone, used only for LPF (both direct and reverb paths) calculations, must be within [0.0f, 1.0f] when used
    OuterLPF: FLOAT32;    // LPF (both direct and reverb paths) coefficient scaler on/beyond outer cone, used only for LPF (both direct and reverb paths) calculations, must be within [0.0f, 1.0f] when used
    InnerReverb: FLOAT32; // reverb send level scaler on/within inner cone, used only for reverb calculations, must be within [0.0f, 2.0f] when used
    OuterReverb: FLOAT32; // reverb send level scaler on/beyond outer cone, used only for reverb calculations, must be within [0.0f, 2.0f] when used
  end;
  {$EXTERNALSYM X3DAUDIO_CONE}
  TX3DAudioCone = X3DAUDIO_CONE;

const
  X3DAudioDefault_DirectionalCone: TX3DAudioCone = (
    InnerAngle: X3DAUDIO_PI/2; OuterAngle: X3DAUDIO_PI;
    InnerVolume: 1.0; OuterVolume: 0.708;
    InnerLPF: 1.0; OuterLPF: 0.75;
    InnerReverb: 0.708; OuterReverb: 1.0 );
  {$EXTERNALSYM X3DAudioDefault_DirectionalCone}

type
  // Listener:
  // Defines a point of 3D audio reception.
  PX3DAudioListener = ^TX3DAudioListener;
  X3DAUDIO_LISTENER = record
    OrientFront: TX3DAudioVector; // orientation of front direction, used only for matrix and delay calculations, must be orthonormal with OrientTop when used
    OrientTop: TX3DAudioVector;   // orientation of top direction, used only for matrix and delay calculations, must be orthonormal with OrientFront when used

    Position: TX3DAudioVector; // position in user-defined world units, does not affect Velocity
    Velocity: TX3DAudioVector; // velocity vector in user-defined world units/second, used only for doppler calculations, does not affect Position
  end;
  {$EXTERNALSYM X3DAUDIO_LISTENER}
  TX3DAudioListener = X3DAUDIO_LISTENER;

  // Emitter:
  // Defines a 3D audio source, divided into two classifications:
  //
  // Single-point -- For use with single-channel sounds.
  //                 Positioned at the emitter base, i.e. the channel radius
  //                 and azimuth are ignored if the number of channels == 1.
  //
  //                 May be omnidirectional or directional using a cone.
  //                 The cone originates from the emitter base position,
  //                 and is directed by the emitter's front orientation.
  //
  // Multi-point  -- For use with multi-channel sounds.
  //                 Each non-LFE channel is positioned using an
  //                 azimuth along the channel radius with respect to the
  //                 front orientation vector in the plane orthogonal to the
  //                 top orientation vector.  An azimuth of X3DAUDIO_2PI
  //                 specifies a channel is a LFE.  Such channels are
  //                 positioned at the emitter base and are calculated
  //                 with respect to pLFECurve only, never pVolumeCurve.
  //
  //                 Multi-point emitters are always omnidirectional,
  //                 i.e. the cone is ignored if the number of channels > 1.
  //
  // Note that many properties are shared among all channel points,
  // locking certain behaviour with respect to the emitter base position.
  // For example, doppler shift is always calculated with respect to the
  // emitter base position and so is constant for all its channel points.
  // Distance curve calculations are also with respect to the emitter base
  // position, with the curves being calculated independently of each other.
  // For instance, volume and LFE calculations do not affect one another.
  PX3DAudioEmitter = ^TX3DAudioEmitter;
  X3DAUDIO_EMITTER = record
    pCone: PX3DAudioCone; // sound cone, used only with single-channel emitters for matrix, LPF (both direct and reverb paths), and reverb calculations, NULL specifies omnidirectionality
    OrientFront: TX3DAudioVector; // orientation of front direction, used only for emitter angle calculations or with multi-channel emitters for matrix calculations or single-channel emitters with cones for matrix, LPF (both direct and reverb paths), and reverb calculations, must be normalized when used
    OrientTop: TX3DAudioVector;   // orientation of top direction, used only with multi-channel emitters for matrix calculations, must be orthonormal with OrientFront when used

    Position: TX3DAudioVector; // position in user-defined world units, does not affect Velocity
    Velocity: TX3DAudioVector; // velocity vector in user-defined world units/second, used only for doppler calculations, does not affect Position

    ChannelCount: LongWord;    // number of sound channels, must be > 0
    ChannelRadius: FLOAT32;    // channel radius, used only with multi-channel emitters for matrix calculations, must be >= 0.0f when used
    pChannelAzimuths: PSingle; // channel azimuth array, used only with multi-channel emitters for matrix calculations, contains positions of each channel expressed in radians along the channel radius with respect to the front orientation vector in the plane orthogonal to the top orientation vector, or X3DAUDIO_2PI to specify a LFE channel, must have at least ChannelCount elements, all within [0.0f, X3DAUDIO_2PI] when used

    pVolumeCurve: PX3DAudioDistanceCurve;    // volume level distance curve, used only for matrix calculations, NULL specifies a default curve that conforms to the inverse square law with distances <= 1.0f clamped to no attenuation, CurveDistanceScaler is ignored when this parameter is NULL
    pLFECurve: PX3DAudioDistanceCurve;       // LFE level distance curve, used only for matrix calculations, NULL specifies a default curve that conforms to the inverse square law with distances <= 1.0f clamped to no attenuation, CurveDistanceScaler is ignored when this parameters is NULL
    pLPFDirectCurve: PX3DAudioDistanceCurve; // LPF direct-path coefficient distance curve, used only for LPF direct-path calculations, NULL specifies the default curve: [0.0f,1.0f], [1.0f,0.75f]
    pLPFReverbCurve: PX3DAudioDistanceCurve; // LPF reverb-path coefficient distance curve, used only for LPF reverb-path calculations, NULL specifies the default curve: [0.0f,0.75f], [1.0f,0.75f]
    pReverbCurve: PX3DAudioDistanceCurve;    // reverb send level distance curve, used only for reverb calculations, NULL specifies the default curve: [0.0f,1.0f], [1.0f,0.0f]

    CurveDistanceScaler: FLOAT32; // curve distance scaler, used to scale normalized distance curves to user-defined world units and/or exaggerate their effect, does not affect any other calculations, must be within [FLT_MIN, FLT_MAX] when used
    DopplerScaler: FLOAT32;       // doppler shift scaler, used to exaggerate doppler shift effect, does not affect any other calculations, must be within [0.0f, FLT_MAX] when used
  end;
  {$EXTERNALSYM X3DAUDIO_EMITTER}
  TX3DAudioEmitter = X3DAUDIO_EMITTER;


  // DSP settings:
  // Receives results from a call to X3DAudioCalculate() to be sent
  // to the low-level audio rendering API for 3D signal processing.
  //
  // The user is responsible for allocating the matrix coefficient table,
  // delay time array, and initializing the channel counts when used.
  PX3DAudioDspSettings = ^TX3DAudioDspSettings;
  X3DAUDIO_DSP_SETTINGS = record
    pMatrixCoefficients: PSingle;  // [in]  matrix coefficient table, receives an array representing the volume level used to send from source channel S to destination channel D, stored as pMatrixCoefficients[SrcChannelCount * D + S], must have at least SrcChannelCount*DstChannelCount elements
    pDelayTimes: PSingle;          // [in] delay time array, receives delays for each destination channel in milliseconds, must have at least DstChannelCount elements (stereo final mix only)
    SrcChannelCount: LongWord;     // [in] number of source channels, must equal number of channels on respective emitter
    DstChannelCount: LongWord;     // [in] number of destination channels, must equal number of channels on the final mix

    LPFDirectCoefficient: FLOAT32; // [out] LPF direct-path coefficient
    LPFReverbCoefficient: FLOAT32; // [out] LPF reverb-path coefficient
    ReverbLevel: FLOAT32;          // [out] reverb send level
    DopplerFactor: FLOAT32;        // [out] doppler shift factor, scales resampler ratio for doppler shift effect, where the effective frequency = DopplerFactor * original frequency
    EmitterToListenerAngle: FLOAT32; // [out] emitter-to-listener interior angle, expressed in radians with respect to the emitter's front orientation

    EmitterToListenerDistance: FLOAT32; // [out] distance in user-defined world units from the emitter base to listener position, always calculated
    EmitterVelocityComponent: FLOAT32; // [out] component of emitter velocity vector projected onto emitter->listener vector in user-defined world units/second, calculated only for doppler
    ListenerVelocityComponent: FLOAT32; // [out] component of listener velocity vector projected onto emitter->listener vector in user-defined world units/second, calculated only for doppler
  end;
  {$EXTERNALSYM X3DAUDIO_DSP_SETTINGS}
  TX3DAudioDspSettings = X3DAUDIO_DSP_SETTINGS;


//--------------<F-U-N-C-T-I-O-N-S>-----------------------------------------//
// sets all global 3D audio constants
procedure X3DAudioInitialize(SpeakerChannelMask: LongWord; SpeedOfSound: FLOAT32;
  out Instance: TX3DAudioHandle); stdcall; external X3DAudioDLL;
{$EXTERNALSYM X3DAudioInitialize}

// calculates DSP settings with respect to 3D parameters
procedure X3DAudioCalculate(const Instance: TX3DAudioHandle;
  const pListener: TX3DAudioListener; const pEmitter: TX3DAudioEmitter;
  Flags: LongWord; var pDSPSettings: TX3DAudioDspSettings); stdcall; external X3DAudioDLL;
{$EXTERNALSYM X3DAudioCalculate}

implementation

end.
//---------------------------------<-EOF->----------------------------------//

