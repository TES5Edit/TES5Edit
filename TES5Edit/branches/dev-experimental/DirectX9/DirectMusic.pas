{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      dls1.h dls2.h dmdls.h dmerror.h dmksctrl.h dmplugin.h         *}
{*              dmusicc.h dmusici.h dmusicf.h dmusbuff.h                      *}
{*  Content:    DirectMusic include files                                     *}
{*                                                                            *}
{*  DirectX 9.0 Delphi / FreePascal adaptation by Alexey Barkovoy             *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Based upon :                                                              *}
{*    DirectX 7.0 Delphi adaptation by Erik Unger                             *}
{*    DirectX 8.0 Delphi adaptation by Ivo Steinmann                          *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://clootie.ru                                                       *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
{*----------------------------------------------------------------------------*}
{*  $Id: DirectMusic.pas,v 1.5 2006/10/24 19:58:49 clootie Exp $ }
{******************************************************************************}
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
{$MINENUMSIZE 1}
{$ALIGN ON}

unit DirectMusic;

interface

(*$HPPEMIT '#include "ks.h"' *)
(*$HPPEMIT '#include "dls1.h"' *)
(*$HPPEMIT '#include "dls2.h"' *)
(*$HPPEMIT '#include "dmdls.h"' *)
(*$HPPEMIT '#include "dmerror.h"' *)
(*$HPPEMIT '#include "dmplugin.h"' *)
(*$HPPEMIT '#include "dmusicc.h"' *)
(*$HPPEMIT '#include "dmusici.h"' *)
(*$HPPEMIT '#include "dmusicf.h"' *)
(*$HPPEMIT '#include "dmusbuff.h"' *)

{$NOINCLUDE ActiveX}

uses
  Windows, MMSystem, ActiveX, DXTypes, DirectSound;

(*==========================================================================;
//
//  dls1.h
//
//
//  Description:
//
//  Interface defines and structures for the Instrument Collection Form
//  RIFF DLS.
//
//
//  Written by Sonic Foundry 1996.  Released for public use.
//
//=========================================================================*)

(*)/////////////////////////////////////////////////////////////////////////
//
//
// Layout of an instrument collection:
//
//
// RIFF [] 'DLS ' [dlid,colh,INSTLIST,WAVEPOOL,INFOLIST]
//
// INSTLIST
// LIST [] 'lins'
//               LIST [] 'ins ' [dlid,insh,RGNLIST,ARTLIST,INFOLIST]
//               LIST [] 'ins ' [dlid,insh,RGNLIST,ARTLIST,INFOLIST]
//               LIST [] 'ins ' [dlid,insh,RGNLIST,ARTLIST,INFOLIST]
//
// RGNLIST
// LIST [] 'lrgn'
//               LIST [] 'rgn '  [rgnh,wsmp,wlnk,ARTLIST]
//               LIST [] 'rgn '  [rgnh,wsmp,wlnk,ARTLIST]
//               LIST [] 'rgn '  [rgnh,wsmp,wlnk,ARTLIST]
//
// ARTLIST
// LIST [] 'lart'
//         'art1' level 1 Articulation connection graph
//         'art2' level 2 Articulation connection graph
//         '3rd1' Possible 3rd party articulation structure 1
//         '3rd2' Possible 3rd party articulation structure 2 .... and so on
//
// WAVEPOOL
// ptbl [] [pool table]
// LIST [] 'wvpl'
//               [path],
//               [path],
//               LIST [] 'wave' [dlid,RIFFWAVE]
//               LIST [] 'wave' [dlid,RIFFWAVE]
//               LIST [] 'wave' [dlid,RIFFWAVE]
//               LIST [] 'wave' [dlid,RIFFWAVE]
//               LIST [] 'wave' [dlid,RIFFWAVE]
//
// INFOLIST
// LIST [] 'INFO'
//               'icmt' 'One of those crazy comments.'
//               'icop' 'Copyright (C) 1996 Sonic Foundry'
//
////////////////////////////////////////////////////////////////////////(*)


(*)////////////////////////////////////////////////////////////////////////
// FOURCC's used in the DLS file
////////////////////////////////////////////////////////////////////////(*)

const
  FOURCC_DLS  = DWORD(Byte('D') or (Byte('L') shl 8) or (Byte('S') shl 16) or (Byte(' ') shl 24));
  {$EXTERNALSYM FOURCC_DLS}
  FOURCC_DLID = DWORD(Byte('d') or (Byte('l') shl 8) or (Byte('i') shl 16) or (Byte('d') shl 24));
  {$EXTERNALSYM FOURCC_DLID}
  FOURCC_COLH = DWORD(Byte('c') or (Byte('o') shl 8) or (Byte('l') shl 16) or (Byte('h') shl 24));
  {$EXTERNALSYM FOURCC_COLH}
  FOURCC_WVPL = DWORD(Byte('w') or (Byte('v') shl 8) or (Byte('p') shl 16) or (Byte('l') shl 24));
  {$EXTERNALSYM FOURCC_WVPL}
  FOURCC_PTBL = DWORD(Byte('p') or (Byte('t') shl 8) or (Byte('b') shl 16) or (Byte('l') shl 24));
  {$EXTERNALSYM FOURCC_PTBL}
  FOURCC_PATH = DWORD(Byte('p') or (Byte('a') shl 8) or (Byte('t') shl 16) or (Byte('h') shl 24));
  {$EXTERNALSYM FOURCC_PATH}
  FOURCC_wave = DWORD(Byte('w') or (Byte('a') shl 8) or (Byte('v') shl 16) or (Byte('e') shl 24));
  {$EXTERNALSYM FOURCC_wave}
  FOURCC_LINS = DWORD(Byte('l') or (Byte('i') shl 8) or (Byte('n') shl 16) or (Byte('s') shl 24));
  {$EXTERNALSYM FOURCC_LINS}
  FOURCC_INS  = DWORD(Byte('i') or (Byte('n') shl 8) or (Byte('s') shl 16) or (Byte(' ') shl 24));
  {$EXTERNALSYM FOURCC_INS}
  FOURCC_INSH = DWORD(Byte('i') or (Byte('n') shl 8) or (Byte('s') shl 16) or (Byte('h') shl 24));
  {$EXTERNALSYM FOURCC_INSH}
  FOURCC_LRGN = DWORD(Byte('l') or (Byte('r') shl 8) or (Byte('g') shl 16) or (Byte('n') shl 24));
  {$EXTERNALSYM FOURCC_LRGN}
  FOURCC_RGN  = DWORD(Byte('r') or (Byte('g') shl 8) or (Byte('n') shl 16) or (Byte(' ') shl 24));
  {$EXTERNALSYM FOURCC_RGN}
  FOURCC_RGNH = DWORD(Byte('r') or (Byte('g') shl 8) or (Byte('n') shl 16) or (Byte('h') shl 24));
  {$EXTERNALSYM FOURCC_RGNH}
  FOURCC_LART = DWORD(Byte('l') or (Byte('a') shl 8) or (Byte('r') shl 16) or (Byte('t') shl 24));
  {$EXTERNALSYM FOURCC_LART}
  FOURCC_ART1 = DWORD(Byte('a') or (Byte('r') shl 8) or (Byte('t') shl 16) or (Byte('1') shl 24));
  {$EXTERNALSYM FOURCC_ART1}
  FOURCC_WLNK = DWORD(Byte('w') or (Byte('l') shl 8) or (Byte('n') shl 16) or (Byte('k') shl 24));
  {$EXTERNALSYM FOURCC_WLNK}
  FOURCC_WSMP = DWORD(Byte('w') or (Byte('s') shl 8) or (Byte('m') shl 16) or (Byte('p') shl 24));
  {$EXTERNALSYM FOURCC_WSMP}
  FOURCC_VERS = DWORD(Byte('v') or (Byte('e') shl 8) or (Byte('r') shl 16) or (Byte('s') shl 24));
  {$EXTERNALSYM FOURCC_VERS}

(*)////////////////////////////////////////////////////////////////////////
// Articulation connection graph definitions
////////////////////////////////////////////////////////////////////////(*)

  // Generic Sources
  CONN_SRC_NONE              = $0000;
  {$EXTERNALSYM CONN_SRC_NONE}
  CONN_SRC_LFO               = $0001;
  {$EXTERNALSYM CONN_SRC_LFO}
  CONN_SRC_KEYONVELOCITY     = $0002;
  {$EXTERNALSYM CONN_SRC_KEYONVELOCITY}
  CONN_SRC_KEYNUMBER         = $0003;
  {$EXTERNALSYM CONN_SRC_KEYNUMBER}
  CONN_SRC_EG1               = $0004;
  {$EXTERNALSYM CONN_SRC_EG1}
  CONN_SRC_EG2               = $0005;
  {$EXTERNALSYM CONN_SRC_EG2}
  CONN_SRC_PITCHWHEEL        = $0006;
  {$EXTERNALSYM CONN_SRC_PITCHWHEEL}

  // Midi Controllers 0-127
  CONN_SRC_CC1               = $0081;
  {$EXTERNALSYM CONN_SRC_CC1}
  CONN_SRC_CC7               = $0087;
  {$EXTERNALSYM CONN_SRC_CC7}
  CONN_SRC_CC10              = $008a;
  {$EXTERNALSYM CONN_SRC_CC10}
  CONN_SRC_CC11              = $008b;
  {$EXTERNALSYM CONN_SRC_CC11}

  // Generic Destinations
  CONN_DST_NONE              = $0000;
  {$EXTERNALSYM CONN_DST_NONE}
  CONN_DST_ATTENUATION       = $0001;
  {$EXTERNALSYM CONN_DST_ATTENUATION}
  CONN_DST_PITCH             = $0003;
  {$EXTERNALSYM CONN_DST_PITCH}
  CONN_DST_PAN               = $0004;
  {$EXTERNALSYM CONN_DST_PAN}

  // LFO Destinations
  CONN_DST_LFO_FREQUENCY     = $0104;
  {$EXTERNALSYM CONN_DST_LFO_FREQUENCY}
  CONN_DST_LFO_STARTDELAY    = $0105;
  {$EXTERNALSYM CONN_DST_LFO_STARTDELAY}

  // EG1 Destinations
  CONN_DST_EG1_ATTACKTIME    = $0206;
  {$EXTERNALSYM CONN_DST_EG1_ATTACKTIME}
  CONN_DST_EG1_DECAYTIME     = $0207;
  {$EXTERNALSYM CONN_DST_EG1_DECAYTIME}
  CONN_DST_EG1_RELEASETIME   = $0209;
  {$EXTERNALSYM CONN_DST_EG1_RELEASETIME}
  CONN_DST_EG1_SUSTAINLEVEL  = $020a;
  {$EXTERNALSYM CONN_DST_EG1_SUSTAINLEVEL}

  // EG2 Destinations
  CONN_DST_EG2_ATTACKTIME    = $030a;
  {$EXTERNALSYM CONN_DST_EG2_ATTACKTIME}
  CONN_DST_EG2_DECAYTIME     = $030b;
  {$EXTERNALSYM CONN_DST_EG2_DECAYTIME}
  CONN_DST_EG2_RELEASETIME   = $030d;
  {$EXTERNALSYM CONN_DST_EG2_RELEASETIME}
  CONN_DST_EG2_SUSTAINLEVEL  = $030e;
  {$EXTERNALSYM CONN_DST_EG2_SUSTAINLEVEL}

  CONN_TRN_NONE              = $0000;
  {$EXTERNALSYM CONN_TRN_NONE}
  CONN_TRN_CONCAVE           = $0001;
  {$EXTERNALSYM CONN_TRN_CONCAVE}

type
  PDLSID = ^TDLSID;
  _DLSID = record
    ulData1: Cardinal;
    usData2: Word;
    usData3: Word;
    abData4: array[0..7] of Byte;
  end;
  {$EXTERNALSYM _DLSID}
  DLSID = _DLSID;
  {$EXTERNALSYM DLSID}
  TDLSID= _DLSID;

  PDLSVersion = ^TDLSVersion;
  _DLSVERSION = record
    dwVersionMS: DWORD;
    dwVersionLS: DWORD;
  end;
  {$EXTERNALSYM _DLSVERSION}
  DLSVERSION = _DLSVERSION;
  {$EXTERNALSYM DLSVERSION}
  TDLSVersion = _DLSVERSION;

  PConnection = ^TConnection;
  _CONNECTION = record
    usSource: Word;
    usControl: Word;
    usDestination: Word;
    usTransform: Word;
    lScale: Longint;
  end;
  {$EXTERNALSYM _CONNECTION}
  CONNECTION = _CONNECTION;
  {$EXTERNALSYM CONNECTION}
  TConnection = _CONNECTION;

  // Level 1 Articulation Data

  PConnectionList = ^TConnectionList;
  _CONNECTIONLIST = record
    cbSize: Cardinal;            // size of the connection list structure
    cConnections: Cardinal;      // count of connections in the list
  end;
  {$EXTERNALSYM _CONNECTIONLIST}
  CONNECTIONLIST = _CONNECTIONLIST;
  {$EXTERNALSYM CONNECTIONLIST}
  TConnectionList = _CONNECTIONLIST;


(*)////////////////////////////////////////////////////////////////////////
// Generic type defines for regions and instruments
////////////////////////////////////////////////////////////////////////(*)

  PRGNRange = ^TRGNRange;
  _RGNRANGE = record
    usLow: Word;
    usHigh: Word;
  end;
  {$EXTERNALSYM _RGNRANGE}
  RGNRANGE = _RGNRANGE;
  {$EXTERNALSYM RGNRANGE}
  TRGNRange = _RGNRANGE;

const
  F_INSTRUMENT_DRUMS      = $80000000;
  {$EXTERNALSYM F_INSTRUMENT_DRUMS}

type
  PMIDILocale = ^TMIDILocale;
  _MIDILOCALE = record
    ulBank: Cardinal;
    ulInstrument: Cardinal;
  end;
  {$EXTERNALSYM _MIDILOCALE}
  MIDILOCALE = _MIDILOCALE;
  {$EXTERNALSYM MIDILOCALE}
  TMIDILocale = _MIDILOCALE;

(*)////////////////////////////////////////////////////////////////////////
// Header structures found in an DLS file for collection, instruments, and
// regions.
////////////////////////////////////////////////////////////////////////(*)

const
  F_RGN_OPTION_SELFNONEXCLUSIVE  = $0001;
  {$EXTERNALSYM F_RGN_OPTION_SELFNONEXCLUSIVE}

type
  PRGNHeader = ^TRGNHeader;
  _RGNHEADER = record
    RangeKey: TRGNRange;          // Key range
    RangeVelocity: TRGNRange;     // Velocity Range
    fusOptions: Word;             // Synthesis options for this range
    usKeyGroup: Word;             // Key grouping for non simultaneous play
                                  // 0 = no group, 1 up is group
                                  // for Level 1 only groups 1-15 are allowed
  end;
  {$EXTERNALSYM _RGNHEADER}
  RGNHEADER = _RGNHEADER;
  {$EXTERNALSYM RGNHEADER}
  TRGNHeader = _RGNHEADER;

  PInstHeader = ^TInstHeader;
  _INSTHEADER = record
    cRegions: Cardinal;          // Count of regions in this instrument
    Locale: TMIDILocale;         // Intended MIDI locale of this instrument
  end;
  {$EXTERNALSYM _INSTHEADER}
  INSTHEADER = _INSTHEADER;
  {$EXTERNALSYM INSTHEADER}
  TInstHeader = _INSTHEADER;

  PDLSHeader = ^TDLSHeader;
  _DLSHEADER = record
    cInstruments: Cardinal;      // Count of instruments in the collection
  end;
  {$EXTERNALSYM _DLSHEADER}
  DLSHEADER = _DLSHEADER;
  {$EXTERNALSYM DLSHEADER}
  TDLSHeader = _DLSHEADER;

(*)///////////////////////////////////////////////////////////////////////////
// definitions for the Wave link structure
///////////////////////////////////////////////////////////////////////////(*)

// ****  For level 1 only WAVELINK_CHANNEL_MONO is valid  ****
// ulChannel allows for up to 32 channels of audio with each bit position
// specifiying a channel of playback

const
  WAVELINK_CHANNEL_LEFT    = $0001;
  {$EXTERNALSYM WAVELINK_CHANNEL_LEFT}
  WAVELINK_CHANNEL_RIGHT   = $0002;
  {$EXTERNALSYM WAVELINK_CHANNEL_RIGHT}

  F_WAVELINK_PHASE_MASTER  = $0001;
  {$EXTERNALSYM F_WAVELINK_PHASE_MASTER}

type
  PWaveLink = ^TWaveLink;
  _WAVELINK = record // any paths or links are stored right after struct
    fusOptions: Word;       // options flags for this wave
    usPhaseGroup: Word;     // Phase grouping for locking channels
    ulChannel: Cardinal;    // channel placement
    ulTableIndex: Cardinal; // index into the wave pool table, 0 based
  end;
  {$EXTERNALSYM _WAVELINK}
  WAVELINK = _WAVELINK;
  {$EXTERNALSYM WAVELINK}
  TWaveLink = _WAVELINK;

const
  POOL_CUE_NULL  = $ffffffff;
  {$EXTERNALSYM POOL_CUE_NULL}

type
  PPoolCUE = ^TPoolCUE;
  _POOLCUE = record
    ulOffset:    Cardinal;       // Offset to the entry in the list
  end;
  {$EXTERNALSYM _POOLCUE}
  POOLCUE = _POOLCUE;
  {$EXTERNALSYM POOLCUE}
  TPoolCUE = _POOLCUE;

  PPoolTable = ^TPoolTable;
  _POOLTABLE = record
    cbSize: Cardinal;            // size of the pool table structure
    cCues: Cardinal;             // count of cues in the list
  end;
  {$EXTERNALSYM _POOLTABLE}
  POOLTABLE = _POOLTABLE;
  {$EXTERNALSYM POOLTABLE}
  TPoolTable = _POOLTABLE;

(*)///////////////////////////////////////////////////////////////////////////
// Structures for the "wsmp" chunk
///////////////////////////////////////////////////////////////////////////(*)

const
  F_WSMP_NO_TRUNCATION     = $0001;
  {$EXTERNALSYM F_WSMP_NO_TRUNCATION}
  F_WSMP_NO_COMPRESSION    = $0002;
  {$EXTERNALSYM F_WSMP_NO_COMPRESSION}


type
  PWSMPL = ^TWSMPL;
  _rwsmp = record
    cbSize: Cardinal;
    usUnityNote: Word;            // MIDI Unity Playback Note
    sFineTune: SmallInt;          // Fine Tune in log tuning
    lAttenuation: Longint;        // Overall Attenuation to be applied to data
    fulOptions: Cardinal;         // Flag options
    cSampleLoops: Cardinal;       // Count of Sample loops, 0 loops is one shot
  end;
  {$EXTERNALSYM _rwsmp}
  WSMPL = _rwsmp;
  {$EXTERNALSYM WSMPL}
  TWSMPL = _rwsmp;


// This loop type is a normal forward playing loop which is continually
// played until the envelope reaches an off threshold in the release
// portion of the volume envelope

const
  WLOOP_TYPE_FORWARD   = 0;
  {$EXTERNALSYM WLOOP_TYPE_FORWARD}

type
  PWLoop = ^TWLoop;
  _rloop = record
    cbSize: Cardinal;
    ulType: Cardinal;              // Loop Type
    ulStart: Cardinal;             // Start of loop in samples
    ulLength: Cardinal;            // Length of loop in samples
  end;
  {$EXTERNALSYM _rloop}
  WLOOP = _rloop;
  {$EXTERNALSYM WLOOP}
  TWLoop = _rloop;




(*

 	dls2.h

 	Description:

 	Interface defines and structures for the DLS2 extensions of DLS.


     Written by Microsoft 1998.  Released for public use.

*)


(*
     FOURCC's used in the DLS2 file, in addition to DLS1 chunks
*)

const
  FOURCC_RGN2 = DWORD(Byte('r') or (Byte('g') shl 8) or (Byte('n') shl 16) or (Byte('2') shl 24));
  {$EXTERNALSYM FOURCC_RGN2}
  FOURCC_LAR2 = DWORD(Byte('l') or (Byte('a') shl 8) or (Byte('r') shl 16) or (Byte('2') shl 24));
  {$EXTERNALSYM FOURCC_LAR2}
  FOURCC_ART2 = DWORD(Byte('a') or (Byte('r') shl 8) or (Byte('t') shl 16) or (Byte('2') shl 24));
  {$EXTERNALSYM FOURCC_ART2}
  FOURCC_CDL  = DWORD(Byte('c') or (Byte('d') shl 8) or (Byte('l') shl 16) or (Byte(' ') shl 24));
  {$EXTERNALSYM FOURCC_CDL}
//  FOURCC_DLID = DWORD(Byte('d') or (Byte('l') shl 8) or (Byte('i') shl 16) or (Byte('d') shl 24)); //Already defined above

(*
     Articulation connection graph definitions. These are in addition to
     the definitions in the DLS1 header.
*)

  // Generic Sources (in addition to DLS1 sources.
  CONN_SRC_POLYPRESSURE           = $0007; // Polyphonic Pressure
  {$EXTERNALSYM CONN_SRC_POLYPRESSURE}
  CONN_SRC_CHANNELPRESSURE        = $0008; // Channel Pressure
  {$EXTERNALSYM CONN_SRC_CHANNELPRESSURE}
  CONN_SRC_VIBRATO                = $0009; // Vibrato LFO
  {$EXTERNALSYM CONN_SRC_VIBRATO}
  CONN_SRC_MONOPRESSURE           = $000a; // MIDI Mono pressure
  {$EXTERNALSYM CONN_SRC_MONOPRESSURE}


  // Midi Controllers
  CONN_SRC_CC91                   = $00db; // Reverb Send
  {$EXTERNALSYM CONN_SRC_CC91}
  CONN_SRC_CC93                   = $00dd; // Chorus Send
  {$EXTERNALSYM CONN_SRC_CC93}


  (* Generic Destinations *)
  CONN_DST_GAIN           = $0001; // Same as CONN_DST_ ATTENUATION, but more appropriate terminology.
  {$EXTERNALSYM CONN_DST_GAIN}
  CONN_DST_KEYNUMBER      = $0005; // Key Number Generator
  {$EXTERNALSYM CONN_DST_KEYNUMBER}

  // Audio Channel Output Destinations
  CONN_DST_LEFT           = $0010; // Left Channel Send
  {$EXTERNALSYM CONN_DST_LEFT}
  CONN_DST_RIGHT          = $0011; // Right Channel Send
  {$EXTERNALSYM CONN_DST_RIGHT}
  CONN_DST_CENTER         = $0012; // Center Channel Send
  {$EXTERNALSYM CONN_DST_CENTER}
  CONN_DST_LEFTREAR       = $0013; // Left Rear Channel Send
  {$EXTERNALSYM CONN_DST_LEFTREAR}
  CONN_DST_RIGHTREAR      = $0014; // Right Rear Channel Send
  {$EXTERNALSYM CONN_DST_RIGHTREAR}
  CONN_DST_LFE_CHANNEL    = $0015; // LFE Channel Send
  {$EXTERNALSYM CONN_DST_LFE_CHANNEL}
  CONN_DST_CHORUS         = $0080; // Chorus Send
  {$EXTERNALSYM CONN_DST_CHORUS}
  CONN_DST_REVERB         = $0081; // Reverb Send
  {$EXTERNALSYM CONN_DST_REVERB}

  // Vibrato LFO Destinations
  CONN_DST_VIB_FREQUENCY  = $0114; // Vibrato Frequency
  {$EXTERNALSYM CONN_DST_VIB_FREQUENCY}
  CONN_DST_VIB_STARTDELAY = $0115; // Vibrato Start Delay
  {$EXTERNALSYM CONN_DST_VIB_STARTDELAY}

  // EG1 Destinations
  CONN_DST_EG1_DELAYTIME    = $020B; // EG1 Delay Time
  {$EXTERNALSYM CONN_DST_EG1_DELAYTIME}
  CONN_DST_EG1_HOLDTIME     = $020C; // EG1 Hold Time
  {$EXTERNALSYM CONN_DST_EG1_HOLDTIME}
  CONN_DST_EG1_SHUTDOWNTIME = $020D; // EG1 Shutdown Time
  {$EXTERNALSYM CONN_DST_EG1_SHUTDOWNTIME}


  //	EG2 Destinations
  CONN_DST_EG2_DELAYTIME  = $030F; // EG2 Delay Time
  {$EXTERNALSYM CONN_DST_EG2_DELAYTIME}
  CONN_DST_EG2_HOLDTIME   = $0310; // EG2 Hold Time
  {$EXTERNALSYM CONN_DST_EG2_HOLDTIME}


  // Filter Destinations
  CONN_DST_FILTER_CUTOFF  = $0500; // Filter Cutoff Frequency
  {$EXTERNALSYM CONN_DST_FILTER_CUTOFF}
  CONN_DST_FILTER_Q       = $0501; // Filter Resonance
  {$EXTERNALSYM CONN_DST_FILTER_Q}


  // Transforms
  CONN_TRN_CONVEX         = $0002; // Convex Transform
  {$EXTERNALSYM CONN_TRN_CONVEX}
  CONN_TRN_SWITCH         = $0003; // Switch Transform
  {$EXTERNALSYM CONN_TRN_SWITCH}


  // Conditional chunk operators
  DLS_CDL_AND             = $0001;// X = X & Y
  {$EXTERNALSYM DLS_CDL_AND}
  DLS_CDL_OR              = $0002;// X = X | Y
  {$EXTERNALSYM DLS_CDL_OR}
  DLS_CDL_XOR             = $0003;// X = X ^ Y
  {$EXTERNALSYM DLS_CDL_XOR}
  DLS_CDL_ADD             = $0004;// X = X + Y
  {$EXTERNALSYM DLS_CDL_ADD}
  DLS_CDL_SUBTRACT        = $0005;// X = X - Y
  {$EXTERNALSYM DLS_CDL_SUBTRACT}
  DLS_CDL_MULTIPLY        = $0006;// X = X * Y
  {$EXTERNALSYM DLS_CDL_MULTIPLY}
  DLS_CDL_DIVIDE          = $0007;// X = X / Y
  {$EXTERNALSYM DLS_CDL_DIVIDE}
  DLS_CDL_LOGICAL_AND     = $0008;// X = X && Y
  {$EXTERNALSYM DLS_CDL_LOGICAL_AND}
  DLS_CDL_LOGICAL_OR      = $0009;// X = X || Y
  {$EXTERNALSYM DLS_CDL_LOGICAL_OR}
  DLS_CDL_LT              = $000A;// X = (X < Y)
  {$EXTERNALSYM DLS_CDL_LT}
  DLS_CDL_LE              = $000B;// X = (X <= Y)
  {$EXTERNALSYM DLS_CDL_LE}
  DLS_CDL_GT              = $000C;// X = (X > Y)
  {$EXTERNALSYM DLS_CDL_GT}
  DLS_CDL_GE              = $000D;// X = (X >= Y)
  {$EXTERNALSYM DLS_CDL_GE}
  DLS_CDL_EQ              = $000E;// X = (X == Y)
  {$EXTERNALSYM DLS_CDL_EQ}
  DLS_CDL_NOT             = $000F;// X = !X
  {$EXTERNALSYM DLS_CDL_NOT}
  DLS_CDL_CONST           = $0010;// 32-bit constant
  {$EXTERNALSYM DLS_CDL_CONST}
  DLS_CDL_QUERY           = $0011;// 32-bit value returned from query
  {$EXTERNALSYM DLS_CDL_QUERY}
  DLS_CDL_QUERYSUPPORTED  = $0012;// Test to see if query is supported by synth
  {$EXTERNALSYM DLS_CDL_QUERYSUPPORTED}

  (*
    Loop and release
  *)

  WLOOP_TYPE_RELEASE = 1;
  {$EXTERNALSYM WLOOP_TYPE_RELEASE}

  (*
    WaveLink chunk <wlnk-ck>
  *)

  F_WAVELINK_MULTICHANNEL = $0002;
  {$EXTERNALSYM F_WAVELINK_MULTICHANNEL}


const
  (*
    DLSID queries for <cdl-ck>
  *)

  DLSID_GMInHardware: TGUID = '{178f2f24-c364-11d1-a760-0000f875ac12}';
  {$EXTERNALSYM DLSID_GMInHardware}
  DLSID_GSInHardware: TGUID = '{178f2f25-c364-11d1-a760-0000f875ac12}';
  {$EXTERNALSYM DLSID_GSInHardware}
  DLSID_XGInHardware: TGUID = '{178f2f26-c364-11d1-a760-0000f875ac12}';
  {$EXTERNALSYM DLSID_XGInHardware}
  DLSID_SupportsDLS1: TGUID = '{178f2f27-c364-11d1-a760-0000f875ac12}';
  {$EXTERNALSYM DLSID_SupportsDLS1}
  DLSID_SupportsDLS2: TGUID = '{f14599e5-4689-11d2-afa6-00aa0024d8b6}';
  {$EXTERNALSYM DLSID_SupportsDLS2}
  DLSID_SampleMemorySize: TGUID = '{178f2f28-c364-11d1-a760-0000f875ac12}';
  {$EXTERNALSYM DLSID_SampleMemorySize}
  DLSID_ManufacturersID: TGUID = '{b03e1181-8095-11d2-a1ef-00600833dbd8}';
  {$EXTERNALSYM DLSID_ManufacturersID}
  DLSID_ProductID: TGUID = '{b03e1182-8095-11d2-a1ef-00600833dbd8}';
  {$EXTERNALSYM DLSID_ProductID}
  DLSID_SamplePlaybackRate: TGUID = '{2a91f713-a4bf-11d2-bbdf-00600833dbd8}';
  {$EXTERNALSYM DLSID_SamplePlaybackRate}



(************************************************************************
*                                                                       *
*   dmdls.h -- DLS download definitions for DirectMusic API's           *
*                                                                       *
*   Copyright (c) Microsoft Corporation.  All rights reserved.          *
*                                                                       *
************************************************************************)

type
  PCENT = Longint;     (* Pitch cents *)
  {$EXTERNALSYM PCENT}
  GCENT = Longint;     (* Gain cents *)
  {$EXTERNALSYM GCENT}
  TCENT = Longint;     (* Time cents *)
  {$EXTERNALSYM TCENT}
  PERCENT = Longint;   (* Per.. cent! *)
  {$EXTERNALSYM PERCENT}


  REFERENCE_TIME = DXTypes.REFERENCE_TIME;
  {$EXTERNALSYM REFERENCE_TIME}
  TReferenceTime = DXTypes.TReferenceTime;
  PReferenceTime = DXTypes.PReferenceTime;
  PReference_Time = PReferenceTime;
  TReference_Time = TReferenceTime;

  PDMusDownloadInfo = ^TDMusDownloadInfo;
  _DMUS_DOWNLOADINFO = record
    dwDLType: DWORD;                     // Instrument or Wave
    dwDLId: DWORD;                       // Unique identifier to tag this download.
    dwNumOffsetTableEntries: DWORD;      // Number of index in the offset address table.
    cbSize: DWORD;                       // Total size of this memory chunk.
  end;
  {$EXTERNALSYM _DMUS_DOWNLOADINFO}
  DMUS_DOWNLOADINFO = _DMUS_DOWNLOADINFO;
  {$EXTERNALSYM DMUS_DOWNLOADINFO}
  TDMusDownloadInfo = _DMUS_DOWNLOADINFO;

const
  DMUS_DOWNLOADINFO_INSTRUMENT        = 1;
  {$EXTERNALSYM DMUS_DOWNLOADINFO_INSTRUMENT}
  DMUS_DOWNLOADINFO_WAVE              = 2;
  {$EXTERNALSYM DMUS_DOWNLOADINFO_WAVE}
  DMUS_DOWNLOADINFO_INSTRUMENT2       = 3;   (* New version for better DLS2 support. *)
  {$EXTERNALSYM DMUS_DOWNLOADINFO_INSTRUMENT2}

(* Support for oneshot and streaming wave data 
 *)
  DMUS_DOWNLOADINFO_WAVEARTICULATION  = 4;   (* Wave articulation data *)
  {$EXTERNALSYM DMUS_DOWNLOADINFO_WAVEARTICULATION}
  DMUS_DOWNLOADINFO_STREAMINGWAVE     = 5;   (* One chunk of a streaming *)
  {$EXTERNALSYM DMUS_DOWNLOADINFO_STREAMINGWAVE}
  DMUS_DOWNLOADINFO_ONESHOTWAVE       = 6;
  {$EXTERNALSYM DMUS_DOWNLOADINFO_ONESHOTWAVE}

  DMUS_DEFAULT_SIZE_OFFSETTABLE   = 1;
  {$EXTERNALSYM DMUS_DEFAULT_SIZE_OFFSETTABLE}

(* Flags for DMUS_INSTRUMENT's ulFlags member *)

  DMUS_INSTRUMENT_GM_INSTRUMENT   = (1 shr 0);
  {$EXTERNALSYM DMUS_INSTRUMENT_GM_INSTRUMENT}

type
  PDMusOffsetTable = ^TDMusOffsetTable;
  _DMUS_OFFSETTABLE = record
    ulOffsetTable: array[0..DMUS_DEFAULT_SIZE_OFFSETTABLE - 1] of Cardinal;
  end;
  {$EXTERNALSYM _DMUS_OFFSETTABLE}
  DMUS_OFFSETTABLE = _DMUS_OFFSETTABLE;
  {$EXTERNALSYM DMUS_OFFSETTABLE}
  TDMusOffsetTable = _DMUS_OFFSETTABLE;

  PDMusInstrument = ^TDMusInstrument;
  _DMUS_INSTRUMENT = record
    ulPatch: Cardinal;
    ulFirstRegionIdx: Cardinal;
    ulGlobalArtIdx: Cardinal;         // If zero the instrument does not have an articulation
    ulFirstExtCkIdx: Cardinal;        // If zero no 3rd party entenstion chunks associated with the instrument
    ulCopyrightIdx: Cardinal;         // If zero no Copyright information associated with the instrument
    ulFlags: Cardinal;
  end;
  {$EXTERNALSYM _DMUS_INSTRUMENT}
  DMUS_INSTRUMENT = _DMUS_INSTRUMENT;
  {$EXTERNALSYM DMUS_INSTRUMENT}
  TDMusInstrument = _DMUS_INSTRUMENT;

  PDMusRegion = ^TDMusRegion;
  _DMUS_REGION = record
    RangeKey: TRGNRange;
    RangeVelocity: TRGNRange;
    fusOptions: Word;
    usKeyGroup: Word;
    ulRegionArtIdx: Cardinal;         // If zero the region does not have an articulation
    ulNextRegionIdx: Cardinal;        // If zero no more regions
    ulFirstExtCkIdx: Cardinal;        // If zero no 3rd party entenstion chunks associated with the region
    WaveLink: TWaveLink;
    WSMP: TWSMPL;                     //  If WSMP.cSampleLoops > 1 then a WLOOP is included
    WLOOP: array [0..0] of TWLoop;
  end;
  {$EXTERNALSYM _DMUS_REGION}
  DMUS_REGION = _DMUS_REGION;
  {$EXTERNALSYM DMUS_REGION}
  TDMusRegion = _DMUS_REGION;

  PDMusLFOParams = ^TDMusLFOParams;
  _DMUS_LFOPARAMS = record
    pcFrequency: PCENT;
    tcDelay: TCENT;
    gcVolumeScale: GCENT;
    pcPitchScale: PCENT;
    gcMWToVolume: GCENT;
    pcMWToPitch: PCENT;
  end;
  {$EXTERNALSYM _DMUS_LFOPARAMS}
  DMUS_LFOPARAMS = _DMUS_LFOPARAMS;
  {$EXTERNALSYM DMUS_LFOPARAMS}
  TDMusLFOParams = _DMUS_LFOPARAMS;

  PDMusVEGParams = ^TDMusVEGParams;
  _DMUS_VEGPARAMS = record
    tcAttack: TCENT;
    tcDecay: TCENT;
    ptSustain: PERCENT;
    tcRelease: TCENT;
    tcVel2Attack: TCENT;
    tcKey2Decay: TCENT;
  end;
  {$EXTERNALSYM _DMUS_VEGPARAMS}
  DMUS_VEGPARAMS = _DMUS_VEGPARAMS;
  {$EXTERNALSYM DMUS_VEGPARAMS}
  TDMusVEGParams = _DMUS_VEGPARAMS;

  PDMusPEGParams = ^TDMusPEGParams;
  _DMUS_PEGPARAMS = record
    tcAttack: TCENT;
    tcDecay: TCENT;
    ptSustain: PERCENT;
    tcRelease: TCENT;
    tcVel2Attack: TCENT;
    tcKey2Decay: TCENT;
    pcRange: PCENT;
  end;
  {$EXTERNALSYM _DMUS_PEGPARAMS}
  DMUS_PEGPARAMS = _DMUS_PEGPARAMS;
  {$EXTERNALSYM DMUS_PEGPARAMS}
  TDMusPEGParams = _DMUS_PEGPARAMS;

  PDMusMSCParams = ^TDMusMSCParams;
  _DMUS_MSCPARAMS = record
    ptDefaultPan: PERCENT;
  end;
  {$EXTERNALSYM _DMUS_MSCPARAMS}
  DMUS_MSCPARAMS = _DMUS_MSCPARAMS;
  {$EXTERNALSYM DMUS_MSCPARAMS}
  TDMusMSCParams = _DMUS_MSCPARAMS;

  PDMusArticParams = ^TDMusArticParams;
  _DMUS_ARTICPARAMS = record
    LFO: TDMusLFOParams;
    VolEG: TDMusVEGParams;
    PitchEG: TDMusPEGParams;
    Misc: TDMusMSCParams;
  end;
  {$EXTERNALSYM _DMUS_ARTICPARAMS}
  DMUS_ARTICPARAMS = _DMUS_ARTICPARAMS;
  {$EXTERNALSYM DMUS_ARTICPARAMS}
  TDMusArticParams = _DMUS_ARTICPARAMS;

  PDMusArticulation = ^TDMusArticulation;
  _DMUS_ARTICULATION = record (* Articulation chunk for DMUS_DOWNLOADINFO_INSTRUMENT format. *)
    ulArt1Idx: Cardinal;              // DLS Level 1 articulation chunk
    ulFirstExtCkIdx: Cardinal;        // 3rd party extenstion chunks associated with the articulation
  end;
  {$EXTERNALSYM _DMUS_ARTICULATION}
  DMUS_ARTICULATION = _DMUS_ARTICULATION;
  {$EXTERNALSYM DMUS_ARTICULATION}
  TDMusArticulation = _DMUS_ARTICULATION;

  PDMusArticulation2 = ^TDMusArticulation2;
  _DMUS_ARTICULATION2 = record (* Articulation chunk for DMUS_DOWNLOADINFO_INSTRUMENT2 format. *)
    ulArtIdx: Cardinal;               (* DLS Level 1/2 articulation chunk *)
    ulFirstExtCkIdx: Cardinal;        (* 3rd party extenstion chunks associated with the articulation *)
    ulNextArtIdx: Cardinal;           (* Additional articulation chunks *)
  end;
  {$EXTERNALSYM _DMUS_ARTICULATION2}
  DMUS_ARTICULATION2 = _DMUS_ARTICULATION2;
  {$EXTERNALSYM DMUS_ARTICULATION2}
  TDMusArticulation2 = _DMUS_ARTICULATION2;

const
  DMUS_MIN_DATA_SIZE = 4;
  {$EXTERNALSYM DMUS_MIN_DATA_SIZE}

type
  (*  The actual number is determined by cbSize of struct _DMUS_EXTENSIONCHUNK *)

  PDMusExtensionChunk = ^TDMusExtensionChunk;
  _DMUS_EXTENSIONCHUNK = record
    cbSize: Cardinal;                      (*  Size of extension chunk  *)
    ulNextExtCkIdx: Cardinal;              (*  If zero no more 3rd party entenstion chunks *)
    ExtCkID: FOURCC;
    byExtCk: array[0..DMUS_MIN_DATA_SIZE-1] of Byte; (*  The actual number that follows is determined by cbSize *)
  end;
  {$EXTERNALSYM _DMUS_EXTENSIONCHUNK}
  DMUS_EXTENSIONCHUNK = _DMUS_EXTENSIONCHUNK;
  {$EXTERNALSYM DMUS_EXTENSIONCHUNK}
  TDMusExtensionChunk = _DMUS_EXTENSIONCHUNK;

  (*  The actual number is determined by cbSize of struct _DMUS_COPYRIGHT *)

  PDMusCopyright = ^TDMusCopyright;
  _DMUS_COPYRIGHT = record
    cbSize: Cardinal;                             (*  Size of copyright information *)
    byCopyright: array[0..DMUS_MIN_DATA_SIZE-1] of Byte;    (*  The actual number that follows is determined by cbSize *)
  end;
  {$EXTERNALSYM _DMUS_COPYRIGHT}
  DMUS_COPYRIGHT = _DMUS_COPYRIGHT;
  {$EXTERNALSYM DMUS_COPYRIGHT}
  TDMusCopyright = _DMUS_COPYRIGHT;

  PDMusWaveData = ^TDMusWaveData;
  _DMUS_WAVEDATA = record
    cbSize:           Cardinal;
    byData: array[0..DMUS_MIN_DATA_SIZE-1] of Byte;
  end;
  {$EXTERNALSYM _DMUS_WAVEDATA}
  DMUS_WAVEDATA = _DMUS_WAVEDATA;
  {$EXTERNALSYM DMUS_WAVEDATA}
  TDMusWaveData = _DMUS_WAVEDATA;

  PDMusWave = ^TDMusWave;
  _DMUS_WAVE = record
    ulFirstExtCkIdx: Cardinal;    (* If zero no 3rd party entenstion chunks associated with the wave *)
    ulCopyrightIdx: Cardinal;     (* If zero no Copyright information associated with the wave *)
    ulWaveDataIdx: Cardinal;      (* Location of actual wave data. *)
    WaveformatEx: tWAVEFORMATEX;
  end;
  {$EXTERNALSYM _DMUS_WAVE}
  DMUS_WAVE = _DMUS_WAVE;
  {$EXTERNALSYM DMUS_WAVE}
  TDMusWave = _DMUS_WAVE;

  PDMusNoteRange = ^TDMusNoteRange;
  _DMUS_NOTERANGE = record
    dwLowNote: DWORD;  (* Sets the low note for the range of MIDI note events to which the instrument responds.*)
    dwHighNote: DWORD; (* Sets the high note for the range of MIDI note events to which the instrument responds.*)
  end;
  {$EXTERNALSYM _DMUS_NOTERANGE}
  DMUS_NOTERANGE = _DMUS_NOTERANGE;
  {$EXTERNALSYM DMUS_NOTERANGE}
  TDMusNoteRange = _DMUS_NOTERANGE;

  PDMusWaveArtDL = ^TDMusWaveArtDL;
  _DMUS_WAVEARTDL = record
    ulDownloadIdIdx: Cardinal;    (* Download ID's of each buffer *)
    ulBus: Cardinal;              (* Playback bus *)
    ulBuffers: Cardinal;          (* Buffers *)
    ulMasterDLId: Cardinal;       (* Download ID of master voice of slave group *)
    usOptions: Word;              (* Same as DLS2 region options *)
  end;
  {$EXTERNALSYM _DMUS_WAVEARTDL}
  DMUS_WAVEARTDL = _DMUS_WAVEARTDL;
  {$EXTERNALSYM DMUS_WAVEARTDL}
  TDMusWaveArtDL = _DMUS_WAVEARTDL;

  PDMusWaveDL = ^TDMusWaveDL;
  _DMUS_WAVEDL = record
    cbWaveData: Cardinal;         (* Bytes of wave data *)
  end;
  {$EXTERNALSYM _DMUS_WAVEDL}
  DMUS_WAVEDL = _DMUS_WAVEDL;
  {$EXTERNALSYM DMUS_WAVEDL}
  TDMusWaveDL = _DMUS_WAVEDL;





(************************************************************************
*                                                                       *
*   dmerror.h -- Error codes returned by DirectMusic API's              *
*                                                                       *
*   Copyright (c) Microsoft Corporation.  All rights reserved.          *
*                                                                       *
************************************************************************)

const
  FACILITY_DIRECTMUSIC      = $878;       (* Shared with DirectSound *)
  {$EXTERNALSYM FACILITY_DIRECTMUSIC}
  DMUS_ERRBASE              = $1000;      (* Make error codes human readable in hex *)
  {$EXTERNALSYM DMUS_ERRBASE}

// #define MAKE_DMHRESULTSUCCESS(code)     MAKE_HRESULT(0, FACILITY_DIRECTMUSIC, (DMUS_ERRBASE + (code)))
function MAKE_DMHRESULTSUCCESS(Code: DWord): DWord; inline;
{$EXTERNALSYM MAKE_DMHRESULTSUCCESS}
// #define MAKE_DMHRESULTERROR(code)       MAKE_HRESULT(1, FACILITY_DIRECTMUSIC, (DMUS_ERRBASE + (code)))
function MAKE_DMHRESULTERROR(Code: DWord): DWord; inline;
{$EXTERNALSYM MAKE_DMHRESULTERROR}


const
  MAKE_DMHRESULTSUCCESS_R = (0 shl 31) or (FACILITY_DIRECTMUSIC shl 16) or DMUS_ERRBASE;
  MAKE_DMHRESULTERROR_R =   (1 shl 31) or (FACILITY_DIRECTMUSIC shl 16) or DMUS_ERRBASE;

(* DMUS_S_PARTIALLOAD
 *
 * The object could only load partially. This can happen if some components are
 * not registered properly, such as embedded tracks and tools. This can also happen
 * if some content is missing. For example, if a segment uses a DLS collection that
 * is not in the loader's current search directory.
 *)
  DMUS_S_PARTIALLOAD               = (MAKE_DMHRESULTSUCCESS_R + $091);
  {$EXTERNALSYM DMUS_S_PARTIALLOAD}

(* DMUS_S_PARTIALDOWNLOAD
 *
 * Return value from IDirectMusicBand::Download() which indicates that
 * some of the instruments safely downloaded, but others failed. This usually
 * occurs when some instruments are on PChannels not supported by the performance
 * or port.
 *)
  DMUS_S_PARTIALDOWNLOAD           = (MAKE_DMHRESULTSUCCESS_R + $092);
  {$EXTERNALSYM DMUS_S_PARTIALDOWNLOAD}

(* DMUS_S_REQUEUE
 *
 * Return value from IDirectMusicTool::ProcessPMsg() which indicates to the
 * performance that it should cue the PMsg again automatically.
 *)
  DMUS_S_REQUEUE                   = (MAKE_DMHRESULTSUCCESS_R + $200);
  {$EXTERNALSYM DMUS_S_REQUEUE}

(* DMUS_S_FREE
 *
 * Return value from IDirectMusicTool::ProcessPMsg() which indicates to the
 * performance that it should free the PMsg automatically.
 *)
  DMUS_S_FREE                      = (MAKE_DMHRESULTSUCCESS_R + $201);
  {$EXTERNALSYM DMUS_S_FREE}

(* DMUS_S_END
 *
 * Return value from IDirectMusicTrack::Play() which indicates to the
 * segment that the track has no more data after mtEnd.
 *)
  DMUS_S_END                       = (MAKE_DMHRESULTSUCCESS_R + $202);
  {$EXTERNALSYM DMUS_S_END}

(* DMUS_S_STRING_TRUNCATED
 *
 * Returned string has been truncated to fit the buffer size.
 *)
  DMUS_S_STRING_TRUNCATED          = (MAKE_DMHRESULTSUCCESS_R + $210);
  {$EXTERNALSYM DMUS_S_STRING_TRUNCATED}

(* DMUS_S_LAST_TOOL
 *
 * Returned from IDirectMusicGraph::StampPMsg(), this indicates that the PMsg
 * is already stamped with the last tool in the graph. The returned PMsg's
 * tool pointer is now NULL.
 *)
  DMUS_S_LAST_TOOL                 = (MAKE_DMHRESULTSUCCESS_R + $211);
  {$EXTERNALSYM DMUS_S_LAST_TOOL}

(* DMUS_S_OVER_CHORD
 *
 * Returned from IDirectMusicPerformance::MusicToMIDI(), this indicates
 * that no note has been calculated because the music value has the note
 * at a position higher than the top note of the chord. This applies only
 * to DMUS_PLAYMODE_NORMALCHORD play mode. This success code indicates
 * that the caller should not do anything with the note. It is not meant
 * to be played against this chord.
 *)
  DMUS_S_OVER_CHORD                = (MAKE_DMHRESULTSUCCESS_R + $212);
  {$EXTERNALSYM DMUS_S_OVER_CHORD}

(* DMUS_S_UP_OCTAVE
 *
 * Returned from IDirectMusicPerformance::MIDIToMusic(),  and
 * IDirectMusicPerformance::MusicToMIDI(), this indicates
 * that the note conversion generated a note value that is below 0,
 * so it has been bumped up one or more octaves to be in the proper
 * MIDI range of 0 through 127.
 * Note that this is valid for MIDIToMusic() when using play modes
 * DMUS_PLAYMODE_FIXEDTOCHORD and DMUS_PLAYMODE_FIXEDTOKEY, both of
 * which store MIDI values in wMusicValue. With MusicToMIDI(), it is
 * valid for all play modes.
 * Ofcourse, DMUS_PLAYMODE_FIXED will never return this success code.
 *)
  DMUS_S_UP_OCTAVE                 = (MAKE_DMHRESULTSUCCESS_R + $213);
  {$EXTERNALSYM DMUS_S_UP_OCTAVE}

(* DMUS_S_DOWN_OCTAVE
 *
 * Returned from IDirectMusicPerformance::MIDIToMusic(),  and
 * IDirectMusicPerformance::MusicToMIDI(), this indicates
 * that the note conversion generated a note value that is above 127,
 * so it has been bumped down one or more octaves to be in the proper
 * MIDI range of 0 through 127.
 * Note that this is valid for MIDIToMusic() when using play modes
 * DMUS_PLAYMODE_FIXEDTOCHORD and DMUS_PLAYMODE_FIXEDTOKEY, both of
 * which store MIDI values in wMusicValue. With MusicToMIDI(), it is
 * valid for all play modes.
 * Ofcourse, DMUS_PLAYMODE_FIXED will never return this success code.
 *)
  DMUS_S_DOWN_OCTAVE               = (MAKE_DMHRESULTSUCCESS_R + $214);
  {$EXTERNALSYM DMUS_S_DOWN_OCTAVE}

(* DMUS_S_NOBUFFERCONTROL
 *
 * Although the audio output from the port will be routed to the
 * same device as the given DirectSound buffer, buffer controls
 * such as pan and volume will not affect the output.
 *
 *)
  DMUS_S_NOBUFFERCONTROL           = (MAKE_DMHRESULTSUCCESS_R + $215);
  {$EXTERNALSYM DMUS_S_NOBUFFERCONTROL}

(* DMUS_S_GARBAGE_COLLECTED
 *
 * The requested operation was not performed because during CollectGarbage
 * the loader determined that the object had been released.
 *)
  DMUS_S_GARBAGE_COLLECTED         = (MAKE_DMHRESULTSUCCESS_R + $216);
  {$EXTERNALSYM DMUS_S_GARBAGE_COLLECTED}

(* DMUS_E_DRIVER_FAILED
 *
 * An unexpected error was returned from a device driver, indicating
 * possible failure of the driver or hardware.
 *)
  DMUS_E_DRIVER_FAILED            = (MAKE_DMHRESULTERROR_R + $0101);
  {$EXTERNALSYM DMUS_E_DRIVER_FAILED}

(* DMUS_E_PORTS_OPEN
 *
 * The requested operation cannot be performed while there are
 * instantiated ports in any process in the system.
 *)
  DMUS_E_PORTS_OPEN               = (MAKE_DMHRESULTERROR_R + $0102);
  {$EXTERNALSYM DMUS_E_PORTS_OPEN}

(* DMUS_E_DEVICE_IN_USE
 *
 * The requested device is already in use (possibly by a non-DirectMusic
 * client) and cannot be opened again.
 *)
  DMUS_E_DEVICE_IN_USE            = (MAKE_DMHRESULTERROR_R + $0103);
  {$EXTERNALSYM DMUS_E_DEVICE_IN_USE}

(* DMUS_E_INSUFFICIENTBUFFER
 *
 * Buffer is not large enough for requested operation.
 *)
  DMUS_E_INSUFFICIENTBUFFER       = (MAKE_DMHRESULTERROR_R + $0104);
  {$EXTERNALSYM DMUS_E_INSUFFICIENTBUFFER}

(* DMUS_E_BUFFERNOTSET
 *
 * No buffer was prepared for the download data.
 *)
  DMUS_E_BUFFERNOTSET             = (MAKE_DMHRESULTERROR_R + $0105);
  {$EXTERNALSYM DMUS_E_BUFFERNOTSET}

(* DMUS_E_BUFFERNOTAVAILABLE
 *
 * Download failed due to inability to access or create download buffer.
 *)
  DMUS_E_BUFFERNOTAVAILABLE       = (MAKE_DMHRESULTERROR_R + $0106);
  {$EXTERNALSYM DMUS_E_BUFFERNOTAVAILABLE}

(* DMUS_E_NOTADLSCOL
 *
 * Error parsing DLS collection. File is corrupt.
 *)
  DMUS_E_NOTADLSCOL               = (MAKE_DMHRESULTERROR_R + $0108);
  {$EXTERNALSYM DMUS_E_NOTADLSCOL}

(* DMUS_E_INVALIDOFFSET
 *
 * Wave chunks in DLS collection file are at incorrect offsets.
 *)
  DMUS_E_INVALIDOFFSET            = (MAKE_DMHRESULTERROR_R + $0109);
  {$EXTERNALSYM DMUS_E_INVALIDOFFSET}

(* DMUS_E_ALREADY_LOADED
 *
 * Second attempt to load a DLS collection that is currently open.
 *)
  DMUS_E_ALREADY_LOADED           = (MAKE_DMHRESULTERROR_R + $0111);
  {$EXTERNALSYM DMUS_E_ALREADY_LOADED}

(* DMUS_E_INVALIDPOS
 *
 * Error reading wave data from DLS collection. Indicates bad file.
 *)
  DMUS_E_INVALIDPOS               = (MAKE_DMHRESULTERROR_R + $0113);
  {$EXTERNALSYM DMUS_E_INVALIDPOS}

(* DMUS_E_INVALIDPATCH
 *
 * There is no instrument in the collection that matches patch number.
 *)
  DMUS_E_INVALIDPATCH             = (MAKE_DMHRESULTERROR_R + $0114);
  {$EXTERNALSYM DMUS_E_INVALIDPATCH}

(* DMUS_E_CANNOTSEEK
 *
 * The IStream* doesn't support Seek().
 *)
  DMUS_E_CANNOTSEEK               = (MAKE_DMHRESULTERROR_R + $0115);
  {$EXTERNALSYM DMUS_E_CANNOTSEEK}

(* DMUS_E_CANNOTWRITE
 *
 * The IStream* doesn't support Write().
 *)
  DMUS_E_CANNOTWRITE              = (MAKE_DMHRESULTERROR_R + $0116);
  {$EXTERNALSYM DMUS_E_CANNOTWRITE}

(* DMUS_E_CHUNKNOTFOUND
 *
 * The RIFF parser doesn't contain a required chunk while parsing file.
 *)
  DMUS_E_CHUNKNOTFOUND            = (MAKE_DMHRESULTERROR_R + $0117);
  {$EXTERNALSYM DMUS_E_CHUNKNOTFOUND}

(* DMUS_E_INVALID_DOWNLOADID
 *
 * Invalid download id was used in the process of creating a download buffer.
 *)
  DMUS_E_INVALID_DOWNLOADID       = (MAKE_DMHRESULTERROR_R + $0119);
  {$EXTERNALSYM DMUS_E_INVALID_DOWNLOADID}

(* DMUS_E_NOT_DOWNLOADED_TO_PORT
 *
 * Tried to unload an object that was not downloaded or previously unloaded.
 *)
  DMUS_E_NOT_DOWNLOADED_TO_PORT   = (MAKE_DMHRESULTERROR_R + $0120);
  {$EXTERNALSYM DMUS_E_NOT_DOWNLOADED_TO_PORT}

(* DMUS_E_ALREADY_DOWNLOADED
 *
 * Buffer was already downloaded to synth.
 *)
  DMUS_E_ALREADY_DOWNLOADED       = (MAKE_DMHRESULTERROR_R + $0121);
  {$EXTERNALSYM DMUS_E_ALREADY_DOWNLOADED}

(* DMUS_E_UNKNOWN_PROPERTY
 *
 * The specified property item was not recognized by the target object.
 *)
  DMUS_E_UNKNOWN_PROPERTY         = (MAKE_DMHRESULTERROR_R + $0122);
  {$EXTERNALSYM DMUS_E_UNKNOWN_PROPERTY}

(* DMUS_E_SET_UNSUPPORTED
 *
 * The specified property item may not be set on the target object.
 *)
  DMUS_E_SET_UNSUPPORTED          = (MAKE_DMHRESULTERROR_R + $0123);
  {$EXTERNALSYM DMUS_E_SET_UNSUPPORTED}

(* DMUS_E_GET_UNSUPPORTED
 *
 * The specified property item may not be retrieved from the target object.
 *)
  DMUS_E_GET_UNSUPPORTED          = (MAKE_DMHRESULTERROR_R + $0124);
  {$EXTERNALSYM DMUS_E_GET_UNSUPPORTED}

(* DMUS_E_NOTMONO
 *
 * Wave chunk has more than one interleaved channel. DLS format requires MONO.
 *)
  DMUS_E_NOTMONO                  = (MAKE_DMHRESULTERROR_R + $0125);
  {$EXTERNALSYM DMUS_E_NOTMONO}

(* DMUS_E_BADARTICULATION
 *
 * Invalid articulation chunk in DLS collection.
 *)
  DMUS_E_BADARTICULATION          = (MAKE_DMHRESULTERROR_R + $0126);
  {$EXTERNALSYM DMUS_E_BADARTICULATION}

(* DMUS_E_BADINSTRUMENT
 *
 * Invalid instrument chunk in DLS collection.
 *)
  DMUS_E_BADINSTRUMENT            = (MAKE_DMHRESULTERROR_R + $0127);
  {$EXTERNALSYM DMUS_E_BADINSTRUMENT}

(* DMUS_E_BADWAVELINK
 *
 * Wavelink chunk in DLS collection points to invalid wave.
 *)
  DMUS_E_BADWAVELINK              = (MAKE_DMHRESULTERROR_R + $0128);
  {$EXTERNALSYM DMUS_E_BADWAVELINK}

(* DMUS_E_NOARTICULATION
 *
 * Articulation missing from instrument in DLS collection.
 *)
  DMUS_E_NOARTICULATION           = (MAKE_DMHRESULTERROR_R + $0129);
  {$EXTERNALSYM DMUS_E_NOARTICULATION}

(* DMUS_E_NOTPCM
 *
 * Downoaded DLS wave is not in PCM format.
*)
  DMUS_E_NOTPCM                   = (MAKE_DMHRESULTERROR_R + $012A);
  {$EXTERNALSYM DMUS_E_NOTPCM}

(* DMUS_E_BADWAVE
 *
 * Bad wave chunk in DLS collection
 *)
  DMUS_E_BADWAVE                  = (MAKE_DMHRESULTERROR_R + $012B);
  {$EXTERNALSYM DMUS_E_BADWAVE}

(* DMUS_E_BADOFFSETTABLE
 *
 * Offset Table for download buffer has errors.
 *)
  DMUS_E_BADOFFSETTABLE           = (MAKE_DMHRESULTERROR_R + $012C);
  {$EXTERNALSYM DMUS_E_BADOFFSETTABLE}

(* DMUS_E_UNKNOWNDOWNLOAD
 *
 * Attempted to download unknown data type.
 *)
  DMUS_E_UNKNOWNDOWNLOAD          = (MAKE_DMHRESULTERROR_R + $012D);
  {$EXTERNALSYM DMUS_E_UNKNOWNDOWNLOAD}

(* DMUS_E_NOSYNTHSINK
 *
 * The operation could not be completed because no sink was connected to
 * the synthesizer.
 *)
  DMUS_E_NOSYNTHSINK              = (MAKE_DMHRESULTERROR_R + $012E);
  {$EXTERNALSYM DMUS_E_NOSYNTHSINK}

(* DMUS_E_ALREADYOPEN
 *
 * An attempt was made to open the software synthesizer while it was already
 * open.
 * ASSERT?
 *)
  DMUS_E_ALREADYOPEN              = (MAKE_DMHRESULTERROR_R + $012F);
  {$EXTERNALSYM DMUS_E_ALREADYOPEN}

(* DMUS_E_ALREADYCLOSE
 *
 * An attempt was made to close the software synthesizer while it was already
 * open.
 * ASSERT?
 *)
  DMUS_E_ALREADYCLOSED            = (MAKE_DMHRESULTERROR_R + $0130);
  {$EXTERNALSYM DMUS_E_ALREADYCLOSED}

(* DMUS_E_SYNTHNOTCONFIGURED
 *
 * The operation could not be completed because the software synth has not
 * yet been fully configured.
 * ASSERT?
 *)
  DMUS_E_SYNTHNOTCONFIGURED       = (MAKE_DMHRESULTERROR_R + $0131);
  {$EXTERNALSYM DMUS_E_SYNTHNOTCONFIGURED}

(* DMUS_E_SYNTHACTIVE
 *
 * The operation cannot be carried out while the synthesizer is active.
 *)
  DMUS_E_SYNTHACTIVE              = (MAKE_DMHRESULTERROR_R + $0132);
  {$EXTERNALSYM DMUS_E_SYNTHACTIVE}

(* DMUS_E_CANNOTREAD
 *
 * An error occurred while attempting to read from the IStream* object.
 *)
  DMUS_E_CANNOTREAD               = (MAKE_DMHRESULTERROR_R + $0133);
  {$EXTERNALSYM DMUS_E_CANNOTREAD}

(* DMUS_E_DMUSIC_RELEASED
 *
 * The operation cannot be performed because the final instance of the
 * DirectMusic object was released. Ports cannot be used after final
 * release of the DirectMusic object.
 *)
  DMUS_E_DMUSIC_RELEASED          = (MAKE_DMHRESULTERROR_R + $0134);
  {$EXTERNALSYM DMUS_E_DMUSIC_RELEASED}

(* DMUS_E_BUFFER_EMPTY
 *
 * There was no data in the referenced buffer.
 *)
  DMUS_E_BUFFER_EMPTY             = (MAKE_DMHRESULTERROR_R + $0135);
  {$EXTERNALSYM DMUS_E_BUFFER_EMPTY}

(* DMUS_E_BUFFER_FULL
 *
 * There is insufficient space to insert the given event into the buffer.
 *)
  DMUS_E_BUFFER_FULL              = (MAKE_DMHRESULTERROR_R + $0136);
  {$EXTERNALSYM DMUS_E_BUFFER_FULL}

(* DMUS_E_PORT_NOT_CAPTURE
 *
 * The given operation could not be carried out because the port is a
 * capture port.
 *)
  DMUS_E_PORT_NOT_CAPTURE         = (MAKE_DMHRESULTERROR_R + $0137);
  {$EXTERNALSYM DMUS_E_PORT_NOT_CAPTURE}

(* DMUS_E_PORT_NOT_RENDER
 *
 * The given operation could not be carried out because the port is a
 * render port.
 *)
  DMUS_E_PORT_NOT_RENDER          = (MAKE_DMHRESULTERROR_R + $0138);
  {$EXTERNALSYM DMUS_E_PORT_NOT_RENDER}

(* DMUS_E_DSOUND_NOT_SET
 *
 * The port could not be created because no DirectSound has been specified.
 * Specify a DirectSound interface via the IDirectMusic::SetDirectSound
 * method; pass NULL to have DirectMusic manage usage of DirectSound.
 *)
  DMUS_E_DSOUND_NOT_SET           = (MAKE_DMHRESULTERROR_R + $0139);
  {$EXTERNALSYM DMUS_E_DSOUND_NOT_SET}

(* DMUS_E_ALREADY_ACTIVATED
 *
 * The operation cannot be carried out while the port is active.
 *)
  DMUS_E_ALREADY_ACTIVATED        = (MAKE_DMHRESULTERROR_R + $013A);
  {$EXTERNALSYM DMUS_E_ALREADY_ACTIVATED}

(* DMUS_E_INVALIDBUFFER
 *
 * Invalid DirectSound buffer was handed to port.
 *)
  DMUS_E_INVALIDBUFFER            = (MAKE_DMHRESULTERROR_R + $013B);
  {$EXTERNALSYM DMUS_E_INVALIDBUFFER}

(* DMUS_E_WAVEFORMATNOTSUPPORTED
 *
 * Invalid buffer format was handed to the synth sink.
 *)
  DMUS_E_WAVEFORMATNOTSUPPORTED   = (MAKE_DMHRESULTERROR_R + $013C);
  {$EXTERNALSYM DMUS_E_WAVEFORMATNOTSUPPORTED}

(* DMUS_E_SYNTHINACTIVE
 *
 * The operation cannot be carried out while the synthesizer is inactive.
 *)
  DMUS_E_SYNTHINACTIVE            = (MAKE_DMHRESULTERROR_R + $013D);
  {$EXTERNALSYM DMUS_E_SYNTHINACTIVE}

(* DMUS_E_DSOUND_ALREADY_SET
 *
 * IDirectMusic::SetDirectSound has already been called. It may not be
 * changed while in use.
 *)
  DMUS_E_DSOUND_ALREADY_SET       = (MAKE_DMHRESULTERROR_R + $013E);
  {$EXTERNALSYM DMUS_E_DSOUND_ALREADY_SET}

(* DMUS_E_INVALID_EVENT
 *
 * The given event is invalid (either it is not a valid MIDI message
 * or it makes use of running status). The event cannot be packed
 * into the buffer.
 *)
  DMUS_E_INVALID_EVENT            = (MAKE_DMHRESULTERROR_R + $013F);
  {$EXTERNALSYM DMUS_E_INVALID_EVENT}

(* DMUS_E_UNSUPPORTED_STREAM
 *
 * The IStream* object does not contain data supported by the loading object.
 *)
  DMUS_E_UNSUPPORTED_STREAM       = (MAKE_DMHRESULTERROR_R + $0150);
  {$EXTERNALSYM DMUS_E_UNSUPPORTED_STREAM}

(* DMUS_E_ALREADY_INITED
 *
 * The object has already been initialized.
 *)
  DMUS_E_ALREADY_INITED           = (MAKE_DMHRESULTERROR_R + $0151);
  {$EXTERNALSYM DMUS_E_ALREADY_INITED}

(* DMUS_E_INVALID_BAND
 *
 * The file does not contain a valid band.
 *)
  DMUS_E_INVALID_BAND             = (MAKE_DMHRESULTERROR_R + $0152);
  {$EXTERNALSYM DMUS_E_INVALID_BAND}

(* DMUS_E_TRACK_HDR_NOT_FIRST_CK
 *
 * The IStream* object's data does not have a track header as the first chunk,
 * and therefore can not be read by the segment object.
 *)
  DMUS_E_TRACK_HDR_NOT_FIRST_CK   = (MAKE_DMHRESULTERROR_R + $0155);
  {$EXTERNALSYM DMUS_E_TRACK_HDR_NOT_FIRST_CK}

(* DMUS_E_TOOL_HDR_NOT_FIRST_CK
 *
 * The IStream* object's data does not have a tool header as the first chunk,
 * and therefore can not be read by the graph object.
 *)
  DMUS_E_TOOL_HDR_NOT_FIRST_CK    = (MAKE_DMHRESULTERROR_R + $0156);
  {$EXTERNALSYM DMUS_E_TOOL_HDR_NOT_FIRST_CK}

(* DMUS_E_INVALID_TRACK_HDR
 *
 * The IStream* object's data contains an invalid track header (ckid is 0 and
 * fccType is NULL,) and therefore can not be read by the segment object.
 *)
  DMUS_E_INVALID_TRACK_HDR        = (MAKE_DMHRESULTERROR_R + $0157);
  {$EXTERNALSYM DMUS_E_INVALID_TRACK_HDR}

(* DMUS_E_INVALID_TOOL_HDR
 *
 * The IStream* object's data contains an invalid tool header (ckid is 0 and
 * fccType is NULL,) and therefore can not be read by the graph object.
 *)
  DMUS_E_INVALID_TOOL_HDR         = (MAKE_DMHRESULTERROR_R + $0158);
  {$EXTERNALSYM DMUS_E_INVALID_TOOL_HDR}

(* DMUS_E_ALL_TOOLS_FAILED
 *
 * The graph object was unable to load all tools from the IStream* object data.
 * This may be due to errors in the stream, or the tools being incorrectly
 * registered on the client.
 *)
  DMUS_E_ALL_TOOLS_FAILED         = (MAKE_DMHRESULTERROR_R + $0159);
  {$EXTERNALSYM DMUS_E_ALL_TOOLS_FAILED}

(* DMUS_E_ALL_TRACKS_FAILED
 *
 * The segment object was unable to load all tracks from the IStream* object data.
 * This may be due to errors in the stream, or the tracks being incorrectly
 * registered on the client.
 *)
  DMUS_E_ALL_TRACKS_FAILED        = (MAKE_DMHRESULTERROR_R + $0160);
  {$EXTERNALSYM DMUS_E_ALL_TRACKS_FAILED}

(* DMUS_E_NOT_FOUND
 *
 * The requested item was not contained by the object.
 *)
  DMUS_E_NOT_FOUND                = (MAKE_DMHRESULTERROR_R + $0161);
  {$EXTERNALSYM DMUS_E_NOT_FOUND}

(* DMUS_E_NOT_INIT
 *
 * A required object is not initialized or failed to initialize.
 *)
  DMUS_E_NOT_INIT                 = (MAKE_DMHRESULTERROR_R + $0162);
  {$EXTERNALSYM DMUS_E_NOT_INIT}

(* DMUS_E_TYPE_DISABLED
 *
 * The requested parameter type is currently disabled. Parameter types may
 * be enabled and disabled by certain calls to SetParam().
 *)
  DMUS_E_TYPE_DISABLED            = (MAKE_DMHRESULTERROR_R + $0163);
  {$EXTERNALSYM DMUS_E_TYPE_DISABLED}

(* DMUS_E_TYPE_UNSUPPORTED
 *
 * The requested parameter type is not supported on the object.
 *)
  DMUS_E_TYPE_UNSUPPORTED         = (MAKE_DMHRESULTERROR_R + $0164);
  {$EXTERNALSYM DMUS_E_TYPE_UNSUPPORTED}

(* DMUS_E_TIME_PAST
 *
 * The time is in the past, and the operation can not succeed.
 *)
  DMUS_E_TIME_PAST                = (MAKE_DMHRESULTERROR_R + $0165);
  {$EXTERNALSYM DMUS_E_TIME_PAST}

(* DMUS_E_TRACK_NOT_FOUND
 *
 * The requested track is not contained by the segment.
 *)
  DMUS_E_TRACK_NOT_FOUND			= (MAKE_DMHRESULTERROR_R + $0166);
  {$EXTERNALSYM DMUS_E_TRACK_NOT_FOUND}

(* DMUS_E_TRACK_NO_CLOCKTIME_SUPPORT
 *
 * The track does not support clock time playback or getparam.
 *)
  DMUS_E_TRACK_NO_CLOCKTIME_SUPPORT   = (MAKE_DMHRESULTERROR_R + $0167);
  {$EXTERNALSYM DMUS_E_TRACK_NO_CLOCKTIME_SUPPORT}

(* DMUS_E_NO_MASTER_CLOCK
 *
 * There is no master clock in the performance. Be sure to call
 * IDirectMusicPerformance::Init().
 *)
  DMUS_E_NO_MASTER_CLOCK          = (MAKE_DMHRESULTERROR_R + $0170);
  {$EXTERNALSYM DMUS_E_NO_MASTER_CLOCK}

(* DMUS_E_LOADER_NOCLASSID
 *
 * The class id field is required and missing in the DMUS_OBJECTDESC.
 *)
  DMUS_E_LOADER_NOCLASSID         = (MAKE_DMHRESULTERROR_R + $0180);
  {$EXTERNALSYM DMUS_E_LOADER_NOCLASSID}

(* DMUS_E_LOADER_BADPATH
 *
 * The requested file path is invalid.
 *)
  DMUS_E_LOADER_BADPATH           = (MAKE_DMHRESULTERROR_R + $0181);
  {$EXTERNALSYM DMUS_E_LOADER_BADPATH}

(* DMUS_E_LOADER_FAILEDOPEN
 *
 * File open failed - either file doesn't exist or is locked.
 *)
  DMUS_E_LOADER_FAILEDOPEN        = (MAKE_DMHRESULTERROR_R + $0182);
  {$EXTERNALSYM DMUS_E_LOADER_FAILEDOPEN}

(* DMUS_E_LOADER_FORMATNOTSUPPORTED
 *
 * Search data type is not supported.
 *)
  DMUS_E_LOADER_FORMATNOTSUPPORTED    = (MAKE_DMHRESULTERROR_R + $0183);
  {$EXTERNALSYM DMUS_E_LOADER_FORMATNOTSUPPORTED}

(* DMUS_E_LOADER_FAILEDCREATE
 *
 * Unable to find or create object.
 *)
  DMUS_E_LOADER_FAILEDCREATE      = (MAKE_DMHRESULTERROR_R + $0184);
  {$EXTERNALSYM DMUS_E_LOADER_FAILEDCREATE}

(* DMUS_E_LOADER_OBJECTNOTFOUND
 *
 * Object was not found.
 *)
  DMUS_E_LOADER_OBJECTNOTFOUND    = (MAKE_DMHRESULTERROR_R + $0185);
  {$EXTERNALSYM DMUS_E_LOADER_OBJECTNOTFOUND}

(* DMUS_E_LOADER_NOFILENAME
 *
 * The file name is missing from the DMUS_OBJECTDESC.
 *)
  DMUS_E_LOADER_NOFILENAME	    = (MAKE_DMHRESULTERROR_R + $0186);
  {$EXTERNALSYM DMUS_E_LOADER_NOFILENAME}

(* DMUS_E_INVALIDFILE
 *
 * The file requested is not a valid file.
 *)
  DMUS_E_INVALIDFILE              = (MAKE_DMHRESULTERROR_R + $0200);
  {$EXTERNALSYM DMUS_E_INVALIDFILE}

(* DMUS_E_ALREADY_EXISTS
 *
 * The tool is already contained in the graph. Create a new instance.
 *)
  DMUS_E_ALREADY_EXISTS           = (MAKE_DMHRESULTERROR_R + $0201);
  {$EXTERNALSYM DMUS_E_ALREADY_EXISTS}

(* DMUS_E_OUT_OF_RANGE
 *
 * Value is out of range, for instance the requested length is longer than
 * the segment.
 *)
  DMUS_E_OUT_OF_RANGE             = (MAKE_DMHRESULTERROR_R + $0202);
  {$EXTERNALSYM DMUS_E_OUT_OF_RANGE}

(* DMUS_E_SEGMENT_INIT_FAILED
 *
 * Segment initialization failed, most likely due to a critical memory situation.
 *)
  DMUS_E_SEGMENT_INIT_FAILED      = (MAKE_DMHRESULTERROR_R + $0203);
  {$EXTERNALSYM DMUS_E_SEGMENT_INIT_FAILED}

(* DMUS_E_ALREADY_SENT
 *
 * The DMUS_PMSG has already been sent to the performance object via
 * IDirectMusicPerformance::SendPMsg().
 *)
  DMUS_E_ALREADY_SENT             = (MAKE_DMHRESULTERROR_R + $0204);
  {$EXTERNALSYM DMUS_E_ALREADY_SENT}

(* DMUS_E_CANNOT_FREE
 *
 * The DMUS_PMSG was either not allocated by the performance via
 * IDirectMusicPerformance::AllocPMsg(), or it was already freed via
 * IDirectMusicPerformance::FreePMsg().
 *)
  DMUS_E_CANNOT_FREE              = (MAKE_DMHRESULTERROR_R + $0205);
  {$EXTERNALSYM DMUS_E_CANNOT_FREE}

(* DMUS_E_CANNOT_OPEN_PORT
 *
 * The default system port could not be opened.
 *)
  DMUS_E_CANNOT_OPEN_PORT         = (MAKE_DMHRESULTERROR_R + $0206);
  {$EXTERNALSYM DMUS_E_CANNOT_OPEN_PORT}

(* DMUS_E_CANNOT_CONVERT
 *
 * A call to MIDIToMusic() or MusicToMIDI() resulted in an error because
 * the requested conversion could not happen. This usually occurs when the
 * provided DMUS_CHORD_KEY structure has an invalid chord or scale pattern.
 *)
  DMUS_E_CANNOT_CONVERT           = (MAKE_DMHRESULTERROR_R + $0207);
  {$EXTERNALSYM DMUS_E_CANNOT_CONVERT}
(* misspelling in previous versions of DirectX preserved for backward compatibility *)
  DMUS_E_CONNOT_CONVERT           = DMUS_E_CANNOT_CONVERT;
  {$EXTERNALSYM DMUS_E_CONNOT_CONVERT}

(* DMUS_E_DESCEND_CHUNK_FAIL
 *
 * DMUS_E_DESCEND_CHUNK_FAIL is returned when the end of the file
 * was reached before the desired chunk was found.
 *)
  DMUS_E_DESCEND_CHUNK_FAIL       = (MAKE_DMHRESULTERROR_R + $0210);
  {$EXTERNALSYM DMUS_E_DESCEND_CHUNK_FAIL}

(* DMUS_E_NOT_LOADED
 *
 * An attempt to use this object failed because it first needs to
 * be loaded.
 *)
  DMUS_E_NOT_LOADED               = (MAKE_DMHRESULTERROR_R + $0211);
  {$EXTERNALSYM DMUS_E_NOT_LOADED}

(* DMUS_E_SCRIPT_LANGUAGE_INCOMPATIBLE
 *
 * The activeX scripting engine for the script's language is not compatible with
 * DirectMusic.
 *
 *)
  DMUS_E_SCRIPT_LANGUAGE_INCOMPATIBLE  = (MAKE_DMHRESULTERROR_R + $0213);
  {$EXTERNALSYM DMUS_E_SCRIPT_LANGUAGE_INCOMPATIBLE}

(* DMUS_E_SCRIPT_UNSUPPORTED_VARTYPE
 *
 * A varient was used that had a type that is not supported by DirectMusic.
 *
 *)
  DMUS_E_SCRIPT_UNSUPPORTED_VARTYPE    = (MAKE_DMHRESULTERROR_R + $0214);
  {$EXTERNALSYM DMUS_E_SCRIPT_UNSUPPORTED_VARTYPE}

(* DMUS_E_SCRIPT_ERROR_IN_SCRIPT
 *
 * An error was encountered while parsing or executing the script.
 * The pErrorInfo parameter (if supplied) was filled with information about the error.
 *)
  DMUS_E_SCRIPT_ERROR_IN_SCRIPT        = (MAKE_DMHRESULTERROR_R + $0215);
  {$EXTERNALSYM DMUS_E_SCRIPT_ERROR_IN_SCRIPT}

(* DMUS_E_SCRIPT_CANTLOAD_OLEAUT32
 *
 * Loading of oleaut32.dll failed.  VBScript and other activeX scripting languages
 * require use of oleaut32.dll.  On platforms where oleaut32.dll is not present, only
 * the DirectMusicScript language, which doesn't require oleaut32.dll can be used.
 *)
  DMUS_E_SCRIPT_CANTLOAD_OLEAUT32      = (MAKE_DMHRESULTERROR_R + $0216);
  {$EXTERNALSYM DMUS_E_SCRIPT_CANTLOAD_OLEAUT32}

(* DMUS_E_SCRIPT_LOADSCRIPT_ERROR
 *
 * An error occured while parsing a script loaded using LoadScript.  The script that
 * was loaded contains an error.
 *)
  DMUS_E_SCRIPT_LOADSCRIPT_ERROR       = (MAKE_DMHRESULTERROR_R + $0217);
  {$EXTERNALSYM DMUS_E_SCRIPT_LOADSCRIPT_ERROR}

(* DMUS_E_SCRIPT_INVALID_FILE
 *
 * The script file is invalid.
 *)
  DMUS_E_SCRIPT_INVALID_FILE           = (MAKE_DMHRESULTERROR_R + $0218);
  {$EXTERNALSYM DMUS_E_SCRIPT_INVALID_FILE}

(* DMUS_E_INVALID_SCRIPTTRACK
 *
 * The file contains an invalid script track.
 *)
  DMUS_E_INVALID_SCRIPTTRACK           = (MAKE_DMHRESULTERROR_R + $0219);
  {$EXTERNALSYM DMUS_E_INVALID_SCRIPTTRACK}

(* DMUS_E_SCRIPT_VARIABLE_NOT_FOUND
 *
 * The script does not contain a variable with the specified name.
 *)
  DMUS_E_SCRIPT_VARIABLE_NOT_FOUND     = (MAKE_DMHRESULTERROR_R + $021A);
  {$EXTERNALSYM DMUS_E_SCRIPT_VARIABLE_NOT_FOUND}

(* DMUS_E_SCRIPT_ROUTINE_NOT_FOUND
 *
 * The script does not contain a routine with the specified name.
 *)
  DMUS_E_SCRIPT_ROUTINE_NOT_FOUND      = (MAKE_DMHRESULTERROR_R + $021B);
  {$EXTERNALSYM DMUS_E_SCRIPT_ROUTINE_NOT_FOUND}

(* DMUS_E_SCRIPT_CONTENT_READONLY
 *
 * Scripts variables for content referenced or embedded in a script cannot be set.
 *)
  DMUS_E_SCRIPT_CONTENT_READONLY       = (MAKE_DMHRESULTERROR_R + $021C);
  {$EXTERNALSYM DMUS_E_SCRIPT_CONTENT_READONLY}

(* DMUS_E_SCRIPT_NOT_A_REFERENCE
 *
 * Attempt was made to set a script's variable by reference to a value that was
 * not an object type.
 *)
  DMUS_E_SCRIPT_NOT_A_REFERENCE        = (MAKE_DMHRESULTERROR_R + $021D);
  {$EXTERNALSYM DMUS_E_SCRIPT_NOT_A_REFERENCE}

(* DMUS_E_SCRIPT_VALUE_NOT_SUPPORTED
 *
 * Attempt was made to set a script's variable by value to an object that does
 * not support a default value property.
 *)
  DMUS_E_SCRIPT_VALUE_NOT_SUPPORTED    = (MAKE_DMHRESULTERROR_R + $021E);
  {$EXTERNALSYM DMUS_E_SCRIPT_VALUE_NOT_SUPPORTED}

(* DMUS_E_INVALID_SEGMENTTRIGGERTRACK
 *
 * The file contains an invalid segment trigger track.
 *)
  DMUS_E_INVALID_SEGMENTTRIGGERTRACK   = (MAKE_DMHRESULTERROR_R + $0220);
  {$EXTERNALSYM DMUS_E_INVALID_SEGMENTTRIGGERTRACK}

(* DMUS_E_INVALID_LYRICSTRACK
 *
 * The file contains an invalid lyrics track.
 *)
  DMUS_E_INVALID_LYRICSTRACK           = (MAKE_DMHRESULTERROR_R + $0221);
  {$EXTERNALSYM DMUS_E_INVALID_LYRICSTRACK}

(* DMUS_E_INVALID_PARAMCONTROLTRACK
 *
 * The file contains an invalid parameter control track.
 *)
  DMUS_E_INVALID_PARAMCONTROLTRACK     = (MAKE_DMHRESULTERROR_R + $0222);
  {$EXTERNALSYM DMUS_E_INVALID_PARAMCONTROLTRACK}

(* DMUS_E_AUDIOVBSCRIPT_SYNTAXERROR
 *
 * A script written in AudioVBScript could not be read because it contained a statement that
 * is not allowed by the AudioVBScript language.
 *)
  DMUS_E_AUDIOVBSCRIPT_SYNTAXERROR     = (MAKE_DMHRESULTERROR_R + $0223);
  {$EXTERNALSYM DMUS_E_AUDIOVBSCRIPT_SYNTAXERROR}

(* DMUS_E_AUDIOVBSCRIPT_RUNTIMEERROR
 *
 * A script routine written in AudioVBScript failed because an invalid operation occurred.  For example,
 * adding the number 3 to a segment object would produce this error.  So would attempting to call a routine
 * that doesn't exist.
 *)
  DMUS_E_AUDIOVBSCRIPT_RUNTIMEERROR     = (MAKE_DMHRESULTERROR_R + $0224);
  {$EXTERNALSYM DMUS_E_AUDIOVBSCRIPT_RUNTIMEERROR}

(* DMUS_E_AUDIOVBSCRIPT_OPERATIONFAILURE
 *
 * A script routine written in AudioVBScript failed because a function outside of a script failed to complete.
 * For example, a call to PlaySegment that fails to play because of low memory would return this error.
 *)
  DMUS_E_AUDIOVBSCRIPT_OPERATIONFAILURE     = (MAKE_DMHRESULTERROR_R + $0225);
  {$EXTERNALSYM DMUS_E_AUDIOVBSCRIPT_OPERATIONFAILURE}

(* DMUS_E_AUDIOPATHS_NOT_VALID
 *
 * The Performance has set up some PChannels using the AssignPChannel command, which
 * makes it not capable of supporting audio paths.
 *)
  DMUS_E_AUDIOPATHS_NOT_VALID     = (MAKE_DMHRESULTERROR_R + $0226);
  {$EXTERNALSYM DMUS_E_AUDIOPATHS_NOT_VALID}

(* DMUS_E_AUDIOPATHS_IN_USE
 *
 * This is the inverse of the previous error.
 * The Performance has set up some audio paths, which makes is incompatible
 * with the calls to allocate pchannels, etc.
 *)
  DMUS_E_AUDIOPATHS_IN_USE     = (MAKE_DMHRESULTERROR_R + $0227);
  {$EXTERNALSYM DMUS_E_AUDIOPATHS_IN_USE}

(* DMUS_E_NO_AUDIOPATH_CONFIG
 *
 * A segment was asked for its embedded audio path configuration,
 * but there isn't any.
 *)
  DMUS_E_NO_AUDIOPATH_CONFIG     = (MAKE_DMHRESULTERROR_R + $0228);
  {$EXTERNALSYM DMUS_E_NO_AUDIOPATH_CONFIG}

(* DMUS_E_AUDIOPATH_INACTIVE
 *
 * An audiopath is inactive, perhaps because closedown was called.
 *)
  DMUS_E_AUDIOPATH_INACTIVE     = (MAKE_DMHRESULTERROR_R + $0229);
  {$EXTERNALSYM DMUS_E_AUDIOPATH_INACTIVE}

(* DMUS_E_AUDIOPATH_NOBUFFER
 *
 * An audiopath failed to create because a requested buffer could not be created.
 *)
  DMUS_E_AUDIOPATH_NOBUFFER     = (MAKE_DMHRESULTERROR_R + $022A);
  {$EXTERNALSYM DMUS_E_AUDIOPATH_NOBUFFER}

(* DMUS_E_AUDIOPATH_NOPORT
 *
 * An audiopath could not be used for playback because it lacked port assignments.
 *)
  DMUS_E_AUDIOPATH_NOPORT     = (MAKE_DMHRESULTERROR_R + $022B);
  {$EXTERNALSYM DMUS_E_AUDIOPATH_NOPORT}

(* DMUS_E_NO_AUDIOPATH
 *
 * Attempt was made to play segment in audiopath mode and there was no audiopath.
 *)
  DMUS_E_NO_AUDIOPATH     = (MAKE_DMHRESULTERROR_R + $022C);
  {$EXTERNALSYM DMUS_E_NO_AUDIOPATH}

(* DMUS_E_INVALIDCHUNK
 *
 * Invalid data was found in a RIFF file chunk.
 *)
  DMUS_E_INVALIDCHUNK     = (MAKE_DMHRESULTERROR_R + $022D);
  {$EXTERNALSYM DMUS_E_INVALIDCHUNK}

(* DMUS_E_AUDIOPATH_NOGLOBALFXBUFFER
 *
 * Attempt was made to create an audiopath that sends to a global effects buffer which did not exist.
 *)
  DMUS_E_AUDIOPATH_NOGLOBALFXBUFFER     = (MAKE_DMHRESULTERROR_R + $022E);
  {$EXTERNALSYM DMUS_E_AUDIOPATH_NOGLOBALFXBUFFER}

(* DMUS_E_INVALID_CONTAINER_OBJECT
 *
 * The file does not contain a valid container object.
 *)
  DMUS_E_INVALID_CONTAINER_OBJECT    = (MAKE_DMHRESULTERROR_R + $022F);
  {$EXTERNALSYM DMUS_E_INVALID_CONTAINER_OBJECT}





(************************************************************************
*                                                                       *
*   dmusicc.h -- This module defines the DirectMusic core API's         *
*                                                                       *
*   Copyright (c) Microsoft Corporation.  All rights reserved.          *
*                                                                       *
************************************************************************)

type
  SAMPLE_TIME = Int64;
  {$EXTERNALSYM SAMPLE_TIME}
  TSampleTime = SAMPLE_TIME;
  PSampleTime = ^TSampleTime;

  SAMPLE_POSITION = Int64;
  {$EXTERNALSYM SAMPLE_POSITION}
  TSamplePosition = SAMPLE_POSITION;
  PSamplePosition = ^TSamplePosition;

const
  DMUS_MAX_DESCRIPTION  = 128;
  {$EXTERNALSYM DMUS_MAX_DESCRIPTION}
  DMUS_MAX_DRIVER       = 128;
  {$EXTERNALSYM DMUS_MAX_DRIVER}

type
  PDMusBufferDesc = ^TDMusBufferDesc;
  _DMUS_BUFFERDESC = record
    dwSize: DWORD;
    dwFlags: DWORD;
    guidBufferFormat: TGUID;
    cbBuffer: DWORD;
  end;
  {$EXTERNALSYM _DMUS_BUFFERDESC}
  DMUS_BUFFERDESC = _DMUS_BUFFERDESC;
  {$EXTERNALSYM DMUS_BUFFERDESC}
  TDMusBufferDesc = _DMUS_BUFFERDESC;

const  
(* DMUS_EFFECT_ flags are used in the dwEffectFlags fields of both DMUS_PORTCAPS
 * and DMUS_PORTPARAMS.
 *)
  DMUS_EFFECT_NONE             = $00000000;
  {$EXTERNALSYM DMUS_EFFECT_NONE}
  DMUS_EFFECT_REVERB           = $00000001;
  {$EXTERNALSYM DMUS_EFFECT_REVERB}
  DMUS_EFFECT_CHORUS           = $00000002;
  {$EXTERNALSYM DMUS_EFFECT_CHORUS}
  DMUS_EFFECT_DELAY            = $00000004;
  {$EXTERNALSYM DMUS_EFFECT_DELAY}

(* For DMUS_PORTCAPS dwClass
 *)
  DMUS_PC_INPUTCLASS       = (0);
  {$EXTERNALSYM DMUS_PC_INPUTCLASS}
  DMUS_PC_OUTPUTCLASS      = (1);
  {$EXTERNALSYM DMUS_PC_OUTPUTCLASS}

(* For DMUS_PORTCAPS dwFlags
 *)
  DMUS_PC_DLS              = ($00000001);   // Supports DLS downloading and DLS level 1.
  {$EXTERNALSYM DMUS_PC_DLS}
  DMUS_PC_EXTERNAL         = ($00000002);   // External MIDI module.
  {$EXTERNALSYM DMUS_PC_EXTERNAL}
  DMUS_PC_SOFTWARESYNTH    = ($00000004);   // Software synthesizer.
  {$EXTERNALSYM DMUS_PC_SOFTWARESYNTH}
  DMUS_PC_MEMORYSIZEFIXED  = ($00000008);   // Memory size is fixed.
  {$EXTERNALSYM DMUS_PC_MEMORYSIZEFIXED}
  DMUS_PC_GMINHARDWARE     = ($00000010);   // GM sound set is built in, no need to download.
  {$EXTERNALSYM DMUS_PC_GMINHARDWARE}
  DMUS_PC_GSINHARDWARE     = ($00000020);   // GS sound set is built in.
  {$EXTERNALSYM DMUS_PC_GSINHARDWARE}
  DMUS_PC_XGINHARDWARE     = ($00000040);   // XG sound set is built in.
  {$EXTERNALSYM DMUS_PC_XGINHARDWARE}
  DMUS_PC_DIRECTSOUND      = ($00000080);   // Connects to DirectSound via a DirectSound buffer.
  {$EXTERNALSYM DMUS_PC_DIRECTSOUND}
  DMUS_PC_SHAREABLE        = ($00000100);   // Synth can be actively shared by multiple apps at once.
  {$EXTERNALSYM DMUS_PC_SHAREABLE}
  DMUS_PC_DLS2             = ($00000200);   // Supports DLS2 instruments.
  {$EXTERNALSYM DMUS_PC_DLS2}
  DMUS_PC_AUDIOPATH        = ($00000400);   // Multiple outputs can be connected to DirectSound for audiopaths.
  {$EXTERNALSYM DMUS_PC_AUDIOPATH}
  DMUS_PC_WAVE             = ($00000800);   // Supports streaming and one shot waves.
  {$EXTERNALSYM DMUS_PC_WAVE}

  DMUS_PC_SYSTEMMEMORY     = ($7FFFFFFF);   // Sample memory is system memory.
  {$EXTERNALSYM DMUS_PC_SYSTEMMEMORY}


type
  PDMusPortCaps = ^TDMusPortCaps;
  _DMUS_PORTCAPS = record
    dwSize: DWORD;
    dwFlags: DWORD;
    guidPort: TGUID;
    dwClass: DWORD;
    dwType: DWORD;
    dwMemorySize: DWORD;
    dwMaxChannelGroups: DWORD;
    dwMaxVoices: DWORD;
    dwMaxAudioChannels: DWORD;
    dwEffectFlags: DWORD;
    wszDescription: array[0..DMUS_MAX_DESCRIPTION-1] of WideChar;
  end;
  {$EXTERNALSYM _DMUS_PORTCAPS}
  DMUS_PORTCAPS = _DMUS_PORTCAPS;
  {$EXTERNALSYM DMUS_PORTCAPS}
  TDMusPortCaps = _DMUS_PORTCAPS;

const
(* Values for DMUS_PORTCAPS dwType. This field indicates the underlying
 * driver type of the port.
 *)
  DMUS_PORT_WINMM_DRIVER      = (0);
  {$EXTERNALSYM DMUS_PORT_WINMM_DRIVER}
  DMUS_PORT_USER_MODE_SYNTH   = (1);
  {$EXTERNALSYM DMUS_PORT_USER_MODE_SYNTH}
  DMUS_PORT_KERNEL_MODE       = (2);
  {$EXTERNALSYM DMUS_PORT_KERNEL_MODE}

// These flags (set in dwValidParams) indicate which other members of the
// DMUS_PORTPARAMS are valid.
//
  DMUS_PORTPARAMS_VOICES           = $00000001;
  {$EXTERNALSYM DMUS_PORTPARAMS_VOICES}
  DMUS_PORTPARAMS_CHANNELGROUPS    = $00000002;
  {$EXTERNALSYM DMUS_PORTPARAMS_CHANNELGROUPS}
  DMUS_PORTPARAMS_AUDIOCHANNELS    = $00000004;
  {$EXTERNALSYM DMUS_PORTPARAMS_AUDIOCHANNELS}
  DMUS_PORTPARAMS_SAMPLERATE       = $00000008;
  {$EXTERNALSYM DMUS_PORTPARAMS_SAMPLERATE}
  DMUS_PORTPARAMS_EFFECTS          = $00000020;
  {$EXTERNALSYM DMUS_PORTPARAMS_EFFECTS}
  DMUS_PORTPARAMS_SHARE            = $00000040;
  {$EXTERNALSYM DMUS_PORTPARAMS_SHARE}
  DMUS_PORTPARAMS_FEATURES         = $00000080;     // DirectX 8.0 and above
  {$EXTERNALSYM DMUS_PORTPARAMS_FEATURES}

type
  PDMusPortParams7 = ^TDMusPortParams7;
  _DMUS_PORTPARAMS = record
    dwSize: DWORD;
    dwValidParams: DWORD;
    dwVoices: DWORD;
    dwChannelGroups: DWORD;
    dwAudioChannels: DWORD;
    dwSampleRate: DWORD;
    dwEffectFlags: DWORD;
    fShare: BOOL;
  end;
  {$EXTERNALSYM _DMUS_PORTPARAMS}
  DMUS_PORTPARAMS7 = _DMUS_PORTPARAMS;
  {$EXTERNALSYM DMUS_PORTPARAMS7}
  TDMusPortParams7 = _DMUS_PORTPARAMS;

  PDMusPortParams8 = ^TDMusPortParams8;
  _DMUS_PORTPARAMS8 = record
    dwSize: DWORD;
    dwValidParams: DWORD;
    dwVoices: DWORD;
    dwChannelGroups: DWORD;
    dwAudioChannels: DWORD;
    dwSampleRate: DWORD;
    dwEffectFlags: DWORD;
    fShare: BOOL;
    dwFeatures: DWORD;
  end;
  {$EXTERNALSYM _DMUS_PORTPARAMS8}
  DMUS_PORTPARAMS8 = _DMUS_PORTPARAMS8;
  {$EXTERNALSYM DMUS_PORTPARAMS8}
  TDMusPortParams8 = _DMUS_PORTPARAMS8;

const
  DMUS_PORT_FEATURE_AUDIOPATH     = $00000001; // Supports audiopath connection to DirectSound buffers.
  {$EXTERNALSYM DMUS_PORT_FEATURE_AUDIOPATH}
  DMUS_PORT_FEATURE_STREAMING     = $00000002; // Supports streaming waves through the synth.
  {$EXTERNALSYM DMUS_PORT_FEATURE_STREAMING}


type
  DMUS_PORTPARAMS = DMUS_PORTPARAMS8;
  {$EXTERNALSYM DMUS_PORTPARAMS}
  TDMusPortParams = DMUS_PORTPARAMS;
  PDMusPortParams = PDMusPortParams8;

  PDMusSynthStats = ^TDMusSynthStats;
  _DMUS_SYNTHSTATS = record
    dwSize: DWORD;             (* Size in bytes of the structure *)
    dwValidStats: DWORD;       (* Flags indicating which fields below are valid. *)
    dwVoices: DWORD;           (* Average number of voices playing. *)
    dwTotalCPU: DWORD;         (* Total CPU usage as percent * 100. *)
    dwCPUPerVoice: DWORD;      (* CPU per voice as percent * 100. *)
    dwLostNotes: DWORD;        (* Number of notes lost in 1 second. *)
    dwFreeMemory: DWORD;       (* Free memory in bytes *)
    lPeakVolume: Longint;      (* Decibel level * 100. *)
  end;
  {$EXTERNALSYM _DMUS_SYNTHSTATS}
  DMUS_SYNTHSTATS = _DMUS_SYNTHSTATS;
  {$EXTERNALSYM DMUS_SYNTHSTATS}
  TDMusSynthStats = _DMUS_SYNTHSTATS;

  PDMusSynthStats8 = ^TDMusSynthStats8;
  _DMUS_SYNTHSTATS8 = record
    dwSize: DWORD;             (* Size in bytes of the structure *)
    dwValidStats: DWORD;       (* Flags indicating which fields below are valid. *)
    dwVoices: DWORD;           (* Average number of voices playing. *)
    dwTotalCPU: DWORD;         (* Total CPU usage as percent * 100. *)
    dwCPUPerVoice: DWORD;      (* CPU per voice as percent * 100. *)
    dwLostNotes: DWORD;        (* Number of notes lost in 1 second. *)
    dwFreeMemory: DWORD;       (* Free memory in bytes *)
    lPeakVolume: Longint;      (* Decibel level * 100. *)
    dwSynthMemUse: DWORD;      (* Memory used by synth wave data *)
  end;
  {$EXTERNALSYM _DMUS_SYNTHSTATS8}
  DMUS_SYNTHSTATS8 = _DMUS_SYNTHSTATS8;
  {$EXTERNALSYM DMUS_SYNTHSTATS8}
  TDMusSynthStats8 = _DMUS_SYNTHSTATS8;

const
  DMUS_SYNTHSTATS_VOICES          = (1 shl 0);
  {$EXTERNALSYM DMUS_SYNTHSTATS_VOICES}
  DMUS_SYNTHSTATS_TOTAL_CPU       = (1 shl 1);
  {$EXTERNALSYM DMUS_SYNTHSTATS_TOTAL_CPU}
  DMUS_SYNTHSTATS_CPU_PER_VOICE   = (1 shl 2);
  {$EXTERNALSYM DMUS_SYNTHSTATS_CPU_PER_VOICE}
  DMUS_SYNTHSTATS_LOST_NOTES      = (1 shl 3);
  {$EXTERNALSYM DMUS_SYNTHSTATS_LOST_NOTES}
  DMUS_SYNTHSTATS_PEAK_VOLUME     = (1 shl 4);
  {$EXTERNALSYM DMUS_SYNTHSTATS_PEAK_VOLUME}
  DMUS_SYNTHSTATS_FREE_MEMORY     = (1 shl 5);
  {$EXTERNALSYM DMUS_SYNTHSTATS_FREE_MEMORY}

  DMUS_SYNTHSTATS_SYSTEMMEMORY    = DMUS_PC_SYSTEMMEMORY;
  {$EXTERNALSYM DMUS_SYNTHSTATS_SYSTEMMEMORY}

type
  PDMusWavesReverbParams = ^TDMusWavesReverbParams;
  _DMUS_WAVES_REVERB_PARAMS = record
    fInGain: Single;     (* Input gain in dB (to avoid output overflows) *)
    fReverbMix: Single;  (* Reverb mix in dB. 0dB means 100% wet reverb (no direct signal)
                            Negative values gives less wet signal.
                            The coeficients are calculated so that the overall output level stays
                            (approximately) constant regardless of the ammount of reverb mix. *)
    fReverbTime: Single;    (* The reverb decay time, in milliseconds. *)
    fHighFreqRTRatio: Single; (* The ratio of the high frequencies to the global reverb time.
                            Unless very 'splashy-bright' reverbs are wanted, this should be set to
                            a value < 1.0.
                            For example if dRevTime==1000ms and dHighFreqRTRatio=0.1 than the
                            decay time for high frequencies will be 100ms.*)
  end;
  {$EXTERNALSYM _DMUS_WAVES_REVERB_PARAMS}
  DMUS_WAVES_REVERB_PARAMS = _DMUS_WAVES_REVERB_PARAMS;
  {$EXTERNALSYM DMUS_WAVES_REVERB_PARAMS}
  TDMusWavesReverbParams = _DMUS_WAVES_REVERB_PARAMS;

(*  Note: Default values for Reverb are:
    fInGain             = 0.0dB   (no change in level)
    fReverbMix          = -10.0dB   (a reasonable reverb mix)
    fReverbTime         = 1000.0ms (one second global reverb time)
    fHighFreqRTRatio    = 0.001    (the ratio of the high frequencies to the global reverb time)
*)

  DMUS_CLOCKTYPE = (
    DMUS_CLOCK_SYSTEM {= 0},
    DMUS_CLOCK_WAVE {= 1}
  );
  {$EXTERNALSYM DMUS_CLOCKTYPE}
  TDMusClockType = DMUS_CLOCKTYPE;

const
  DMUS_CLOCKF_GLOBAL              = $00000001;
  {$EXTERNALSYM DMUS_CLOCKF_GLOBAL}

type
  PDMusClockInfo7 = ^TDMusClockInfo7;
  _DMUS_CLOCKINFO7 = record
    dwSize: DWORD;
    ctType: TDMusClockType;
    guidClock: TGUID;          // Identifies this time source
    wszDescription: array[0..DMUS_MAX_DESCRIPTION-1] of WideChar;
  end;
  {$EXTERNALSYM _DMUS_CLOCKINFO7}
  DMUS_CLOCKINFO7 = _DMUS_CLOCKINFO7;
  {$EXTERNALSYM DMUS_CLOCKINFO7}
  TDMusClockInfo7 = _DMUS_CLOCKINFO7;

  PDMusClockInfo8 = ^TDMusClockInfo8;
  _DMUS_CLOCKINFO8 = record
    dwSize: DWORD;
    ctType: TDMusClockType;
    guidClock: TGUID;          // Identifies this time source
    wszDescription: array[0..DMUS_MAX_DESCRIPTION-1] of WideChar;
    dwFlags: DWORD;
  end;
  {$EXTERNALSYM _DMUS_CLOCKINFO8}
  DMUS_CLOCKINFO8 = _DMUS_CLOCKINFO8;
  {$EXTERNALSYM DMUS_CLOCKINFO8}
  TDMusClockInfo8 = _DMUS_CLOCKINFO8;


  DMUS_CLOCKINFO = DMUS_CLOCKINFO8;
  {$EXTERNALSYM DMUS_CLOCKINFO}
  TDMusClockInfo = DMUS_CLOCKINFO;
  PDMusClockInfo = PDMusClockInfo8;

const
(* Default bus identifiers
 *
 * The first 17 are direct mappings to the destinations defined in both
 * the MMA DLS Level 2 specification and the Microsoft Multi-Channel audio
 * specification.
 *)
  DSBUSID_FIRST_SPKR_LOC              = 0;
  {$EXTERNALSYM DSBUSID_FIRST_SPKR_LOC}
  DSBUSID_FRONT_LEFT                  = 0;
  {$EXTERNALSYM DSBUSID_FRONT_LEFT}
  DSBUSID_LEFT                        = 0;   // Front left is also just left
  {$EXTERNALSYM DSBUSID_LEFT}
  DSBUSID_FRONT_RIGHT                 = 1;
  {$EXTERNALSYM DSBUSID_FRONT_RIGHT}
  DSBUSID_RIGHT                       = 1;   // Ditto front right
  {$EXTERNALSYM DSBUSID_RIGHT}
  DSBUSID_FRONT_CENTER                = 2;
  {$EXTERNALSYM DSBUSID_FRONT_CENTER}
  DSBUSID_LOW_FREQUENCY               = 3;
  {$EXTERNALSYM DSBUSID_LOW_FREQUENCY}
  DSBUSID_BACK_LEFT                   = 4;
  {$EXTERNALSYM DSBUSID_BACK_LEFT}
  DSBUSID_BACK_RIGHT                  = 5;
  {$EXTERNALSYM DSBUSID_BACK_RIGHT}
  DSBUSID_FRONT_LEFT_OF_CENTER        = 6;
  {$EXTERNALSYM DSBUSID_FRONT_LEFT_OF_CENTER}
  DSBUSID_FRONT_RIGHT_OF_CENTER       = 7;
  {$EXTERNALSYM DSBUSID_FRONT_RIGHT_OF_CENTER}
  DSBUSID_BACK_CENTER                 = 8;
  {$EXTERNALSYM DSBUSID_BACK_CENTER}
  DSBUSID_SIDE_LEFT                   = 9;
  {$EXTERNALSYM DSBUSID_SIDE_LEFT}
  DSBUSID_SIDE_RIGHT                 = 10;
  {$EXTERNALSYM DSBUSID_SIDE_RIGHT}
  DSBUSID_TOP_CENTER                 = 11;
  {$EXTERNALSYM DSBUSID_TOP_CENTER}
  DSBUSID_TOP_FRONT_LEFT             = 12;
  {$EXTERNALSYM DSBUSID_TOP_FRONT_LEFT}
  DSBUSID_TOP_FRONT_CENTER           = 13;
  {$EXTERNALSYM DSBUSID_TOP_FRONT_CENTER}
  DSBUSID_TOP_FRONT_RIGHT            = 14;
  {$EXTERNALSYM DSBUSID_TOP_FRONT_RIGHT}
  DSBUSID_TOP_BACK_LEFT              = 15;
  {$EXTERNALSYM DSBUSID_TOP_BACK_LEFT}
  DSBUSID_TOP_BACK_CENTER            = 16;
  {$EXTERNALSYM DSBUSID_TOP_BACK_CENTER}
  DSBUSID_TOP_BACK_RIGHT             = 17;
  {$EXTERNALSYM DSBUSID_TOP_BACK_RIGHT}
  DSBUSID_LAST_SPKR_LOC              = 17;
  {$EXTERNALSYM DSBUSID_LAST_SPKR_LOC}

// #define DSBUSID_IS_SPKR_LOC(id) ( ((id) >= DSBUSID_FIRST_SPKR_LOC) && ((id) <= DSBUSID_LAST_SPKR_LOC) )
function DSBUSID_IS_SPKR_LOC(id: Integer): Boolean; inline;
{$EXTERNALSYM DSBUSID_IS_SPKR_LOC}

const
(* These bus identifiers are for the standard DLS effect sends
 *)
  DSBUSID_REVERB_SEND                = 64;
  {$EXTERNALSYM DSBUSID_REVERB_SEND}
  DSBUSID_CHORUS_SEND                = 65;
  {$EXTERNALSYM DSBUSID_CHORUS_SEND}

(* Dynamic bus identifiers start here. See the documentation for how
 * synthesizers map the output of voices to static and dynamic
 * bus identifiers.
 *)
  DSBUSID_DYNAMIC_0                  = 512;
  {$EXTERNALSYM DSBUSID_DYNAMIC_0}

(* Null bus, used to identify busses that have no function mapping.
*)
  DSBUSID_NULL                       = $FFFFFFFF;
  {$EXTERNALSYM DSBUSID_NULL}


(* Standard values for voice priorities. Numerically higher priorities are higher in priority.
 * These priorities are used to set the voice priority for all voices on a channel. They are
 * used in the dwPriority parameter of IDirectMusicPort::GetPriority and returned in the
 * lpwPriority parameter of pdwPriority.
 *
 * These priorities are shared with DirectSound.
 *)

const
  DAUD_CRITICAL_VOICE_PRIORITY    = ($F0000000);
  {$EXTERNALSYM DAUD_CRITICAL_VOICE_PRIORITY}
  DAUD_HIGH_VOICE_PRIORITY        = ($C0000000);
  {$EXTERNALSYM DAUD_HIGH_VOICE_PRIORITY}
  DAUD_STANDARD_VOICE_PRIORITY    = ($80000000);
  {$EXTERNALSYM DAUD_STANDARD_VOICE_PRIORITY}
  DAUD_LOW_VOICE_PRIORITY         = ($40000000);
  {$EXTERNALSYM DAUD_LOW_VOICE_PRIORITY}
  DAUD_PERSIST_VOICE_PRIORITY     = ($10000000);
  {$EXTERNALSYM DAUD_PERSIST_VOICE_PRIORITY}

(* These are the default priorities assigned if not overridden. By default priorities are
 * equal across channel groups (e.g. channel 5 on channel group 1 has the same priority as
 * channel 5 on channel group 2).
 *
 * In accordance with DLS level 1, channel 10 has the highest priority, followed by 1 through 16
 * except for 10.
 *)
  DAUD_CHAN1_VOICE_PRIORITY_OFFSET    = ($0000000E);
  {$EXTERNALSYM DAUD_CHAN1_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN2_VOICE_PRIORITY_OFFSET    = ($0000000D);
  {$EXTERNALSYM DAUD_CHAN2_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN3_VOICE_PRIORITY_OFFSET    = ($0000000C);
  {$EXTERNALSYM DAUD_CHAN3_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN4_VOICE_PRIORITY_OFFSET    = ($0000000B);
  {$EXTERNALSYM DAUD_CHAN4_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN5_VOICE_PRIORITY_OFFSET    = ($0000000A);
  {$EXTERNALSYM DAUD_CHAN5_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN6_VOICE_PRIORITY_OFFSET    = ($00000009);
  {$EXTERNALSYM DAUD_CHAN6_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN7_VOICE_PRIORITY_OFFSET    = ($00000008);
  {$EXTERNALSYM DAUD_CHAN7_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN8_VOICE_PRIORITY_OFFSET    = ($00000007);
  {$EXTERNALSYM DAUD_CHAN8_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN9_VOICE_PRIORITY_OFFSET    = ($00000006);
  {$EXTERNALSYM DAUD_CHAN9_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN10_VOICE_PRIORITY_OFFSET   = ($0000000F);
  {$EXTERNALSYM DAUD_CHAN10_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN11_VOICE_PRIORITY_OFFSET   = ($00000005);
  {$EXTERNALSYM DAUD_CHAN11_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN12_VOICE_PRIORITY_OFFSET   = ($00000004);
  {$EXTERNALSYM DAUD_CHAN12_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN13_VOICE_PRIORITY_OFFSET   = ($00000003);
  {$EXTERNALSYM DAUD_CHAN13_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN14_VOICE_PRIORITY_OFFSET   = ($00000002);
  {$EXTERNALSYM DAUD_CHAN14_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN15_VOICE_PRIORITY_OFFSET   = ($00000001);
  {$EXTERNALSYM DAUD_CHAN15_VOICE_PRIORITY_OFFSET}
  DAUD_CHAN16_VOICE_PRIORITY_OFFSET   = ($00000000);
  {$EXTERNALSYM DAUD_CHAN16_VOICE_PRIORITY_OFFSET}


  DAUD_CHAN1_DEF_VOICE_PRIORITY   = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN1_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN1_DEF_VOICE_PRIORITY}
  DAUD_CHAN2_DEF_VOICE_PRIORITY   = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN2_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN2_DEF_VOICE_PRIORITY}
  DAUD_CHAN3_DEF_VOICE_PRIORITY   = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN3_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN3_DEF_VOICE_PRIORITY}
  DAUD_CHAN4_DEF_VOICE_PRIORITY   = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN4_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN4_DEF_VOICE_PRIORITY}
  DAUD_CHAN5_DEF_VOICE_PRIORITY   = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN5_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN5_DEF_VOICE_PRIORITY}
  DAUD_CHAN6_DEF_VOICE_PRIORITY   = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN6_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN6_DEF_VOICE_PRIORITY}
  DAUD_CHAN7_DEF_VOICE_PRIORITY   = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN7_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN7_DEF_VOICE_PRIORITY}
  DAUD_CHAN8_DEF_VOICE_PRIORITY   = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN8_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN8_DEF_VOICE_PRIORITY}
  DAUD_CHAN9_DEF_VOICE_PRIORITY   = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN9_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN9_DEF_VOICE_PRIORITY}
  DAUD_CHAN10_DEF_VOICE_PRIORITY  = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN10_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN10_DEF_VOICE_PRIORITY}
  DAUD_CHAN11_DEF_VOICE_PRIORITY  = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN11_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN11_DEF_VOICE_PRIORITY}
  DAUD_CHAN12_DEF_VOICE_PRIORITY  = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN12_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN12_DEF_VOICE_PRIORITY}
  DAUD_CHAN13_DEF_VOICE_PRIORITY  = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN13_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN13_DEF_VOICE_PRIORITY}
  DAUD_CHAN14_DEF_VOICE_PRIORITY  = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN14_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN14_DEF_VOICE_PRIORITY}
  DAUD_CHAN15_DEF_VOICE_PRIORITY  = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN15_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN15_DEF_VOICE_PRIORITY}
  DAUD_CHAN16_DEF_VOICE_PRIORITY  = (DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN16_VOICE_PRIORITY_OFFSET);
  {$EXTERNALSYM DAUD_CHAN16_DEF_VOICE_PRIORITY}

type
  IDirectMusicBuffer = interface;
  IDirectMusicPort = interface;

  PIReferenceClock = ^IReferenceClock;
  PIDirectSound = ^IDirectSound;

  PIDirectMusic = ^IDirectMusic;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusic);'}
  {$EXTERNALSYM IDirectMusic}
  IDirectMusic = interface(IUnknown)
    ['{6536115a-7b2d-11d2-ba18-0000f875ac12}']
    (*  IDirectMusic *)
    function EnumPort(dwIndex: DWORD; var pPortCaps: TDMusPortCaps): HResult; stdcall;
    function CreateMusicBuffer(var pBufferDesc: TDMusBufferDesc;
      out ppBuffer: IDirectMusicBuffer; pUnkOuter: IUnknown): HResult; stdcall;
    function CreatePort(const rclsidPort: TGUID; const pPortParams: TDMusPortParams;
      out ppPort: IDirectMusicPort; pUnkOuter: IUnknown): HResult; stdcall;
    function EnumMasterClock(dwIndex: DWORD; var lpClockInfo: TDMusClockInfo): HResult; stdcall;
    function GetMasterClock(pguidClock: PGUID; ppReferenceClock: PIReferenceClock): HResult; stdcall;
    function SetMasterClock(const rguidClock: TGUID): HResult; stdcall;
    function Activate(fEnable: BOOL): HResult; stdcall;
    function GetDefaultPort(out pguidPort: TGUID): HResult; stdcall;
    function SetDirectSound(pDirectSound: IDirectSound; hWnd: HWND): HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusic8);'}
  {$EXTERNALSYM IDirectMusic8}
  IDirectMusic8 = interface(IDirectMusic)
    ['{2d3629f7-813d-4939-8508-f05c6b75fd97}']
    (*  IDirectMusic8 *)
    function SetExternalMasterClock(pClock: IReferenceClock): HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicBuffer);'}
  {$EXTERNALSYM IDirectMusicBuffer}
  IDirectMusicBuffer = interface(IUnknown)
    ['{d2ac2878-b39b-11d1-8704-00600893b1bd}']
    (*  IDirectMusicBuffer *)
    function Flush: HResult; stdcall;
    function TotalTime(out prtTime: TReferenceTime): HResult; stdcall;
    function PackStructured(const rt: TReferenceTime; dwChannelGroup: DWORD;
        dwChannelMessage: DWORD): HResult; stdcall;
    function PackUnstructured(const rt: TReferenceTime; dwChannelGroup: DWORD;
        cb: DWORD; const lpb): HResult; stdcall;
    function ResetReadPtr : HResult; stdcall;
    function GetNextEvent(out prt: TReferenceTime; out pdwChannelGroup: DWORD;
        out pdwLength: DWORD; out ppData: Pointer): HResult; stdcall;
    function GetRawBufferPtr(out ppData: Pointer): HResult; stdcall;
    function GetStartTime(out prt: TReferenceTime): HResult; stdcall;
    function GetUsedBytes(out pcb: DWORD): HResult; stdcall;
    function GetMaxBytes(out pcb: DWORD): HResult; stdcall;
    function GetBufferFormat(out pGuidFormat: TGUID): HResult; stdcall;
    function SetStartTime(const rt: TReferenceTime): HResult; stdcall;
    function SetUsedBytes(cb: DWORD): HResult; stdcall;
  end;

  IDirectMusicBuffer8 = IDirectMusicBuffer;
  {$NODEFINE IDirectMusicBuffer8}
  {$HPPEMIT 'typedef _di_IDirectMusicBuffer _di_IDirectMusicBuffer8;'}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicInstrument);'}
  {$EXTERNALSYM IDirectMusicInstrument}
  IDirectMusicInstrument = interface(IUnknown)
    ['{d2ac287d-b39b-11d1-8704-00600893b1bd}']
    (* IDirectMusicInstrument *)
    function GetPatch(out pdwPatch: DWORD): HResult; stdcall;
    function SetPatch(dwPatch: DWORD): HResult; stdcall;
  end;

  IDirectMusicInstrument8 = IDirectMusicInstrument;
  {$NODEFINE IDirectMusicInstrument8}
  {$HPPEMIT 'typedef _di_IDirectMusicInstrument _di_IDirectMusicInstrument8;'}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicDownloadedInstrument);'}
  {$EXTERNALSYM IDirectMusicDownloadedInstrument}
  IDirectMusicDownloadedInstrument = interface(IUnknown)
    ['{d2ac287e-b39b-11d1-8704-00600893b1bd}']
    (* IDirectMusicDownloadedInstrument *)
    (* None at this time *)
  end;

  IDirectMusicDownloadedInstrument8 = IDirectMusicDownloadedInstrument;
  {$NODEFINE IDirectMusicDownloadedInstrument8}
  {$HPPEMIT 'typedef _di_IDirectMusicDownloadedInstrument _di_IDirectMusicDownloadedInstrument8;'}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicCollection);'}
  {$EXTERNALSYM IDirectMusicCollection}
  IDirectMusicCollection = interface(IUnknown)
    ['{d2ac287c-b39b-11d1-8704-00600893b1bd}']
    (* IDirectMusicCollection *)
    function GetInstrument(dwPatch: DWORD; out ppInstrument: IDirectMusicInstrument): HResult; stdcall;
    function EnumInstrument(dwIndex: DWORD; out pdwPatch: DWORD;
      pwszName: PWideChar; dwNameLen: DWORD): HResult; stdcall;
  end;

  IDirectMusicCollection8 = IDirectMusicCollection;
  {$NODEFINE IDirectMusicCollection8}
  {$HPPEMIT 'typedef _di_IDirectMusicCollection _di_IDirectMusicCollection8;'}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicDownload);'}
  {$EXTERNALSYM IDirectMusicDownload}
  IDirectMusicDownload = interface(IUnknown)
    ['{d2ac287b-b39b-11d1-8704-00600893b1bd}']
    (* IDirectMusicDownload *)
    function GetBuffer(out ppvBuffer: Pointer; out pdwSize: DWORD): HResult; stdcall;
  end;

  IDirectMusicDownload8 = IDirectMusicDownload;
  {$NODEFINE IDirectMusicDownload8}
  {$HPPEMIT 'typedef _di_IDirectMusicDownload _di_IDirectMusicDownload8;'}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicPortDownload);'}
  {$EXTERNALSYM IDirectMusicPortDownload}
  IDirectMusicPortDownload = interface(IUnknown)
    ['{d2ac287a-b39b-11d1-8704-00600893b1bd}']
    (* IDirectMusicPortDownload *)
    function GetBuffer(dwDLId: DWORD; out ppIDMDownload: IDirectMusicDownload): HResult; stdcall;
    function AllocateBuffer(dwSize: DWORD; out ppIDMDownload: IDirectMusicDownload): HResult; stdcall;
    function GetDLId(out pdwStartDLId: DWORD; dwCount: DWORD): HResult; stdcall;
    function GetAppend(out pdwAppend: DWORD): HResult; stdcall;
    function Download(pIDMDownload: IDirectMusicDownload): HResult; stdcall;
    function Unload(pIDMDownload: IDirectMusicDownload): HResult; stdcall;
  end;

  IDirectMusicPortDownload8 = IDirectMusicPortDownload;
  {$NODEFINE IDirectMusicPortDownload8}
  {$HPPEMIT 'typedef _di_IDirectMusicPortDownload _di_IDirectMusicPortDownload8;'}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicPort);'}
  {$EXTERNALSYM IDirectMusicPort}
  IDirectMusicPort = interface(IUnknown)
    ['{08f2d8c9-37c2-11d2-b9f9-0000f875ac12}']
    (*  IDirectMusicPort *)
    function PlayBuffer(pBuffer: IDirectMusicBuffer): HResult; stdcall;
    function SetReadNotificationHandle(hEvent: THANDLE): HResult; stdcall;
    function Read(pBuffer: IDirectMusicBuffer): HResult; stdcall;
    function DownloadInstrument(pInstrument: IDirectMusicInstrument;
      out ppDownloadedInstrument: IDirectMusicDownloadedInstrument;
      pNoteRanges: PDMusNoteRange; dwNumNoteRanges: DWORD): HResult; stdcall;
    function UnloadInstrument(pDownloadedInstrument: IDirectMusicDownloadedInstrument): HResult; stdcall;
    function GetLatencyClock(out ppClock: IReferenceClock): HResult; stdcall;
    function GetRunningStats(var pStats: TDMusSynthStats): HResult; stdcall;
    function Compact: HResult; stdcall;
    function GetCaps(var pPortCaps: TDMusPortCaps): HResult; stdcall;
    function DeviceIoControl(dwIoControlCode: DWORD; const lpInBuffer: Pointer; nInBufferSize: DWORD;
      lpOutBuffer: Pointer; nOutBufferSize: DWORD; out lpBytesReturned: DWORD;
      var lpOverlapped: TOverlapped): HResult; stdcall;
    function SetNumChannelGroups(dwChannelGroups: DWORD): HResult; stdcall;
    function GetNumChannelGroups(out pdwChannelGroups: DWORD): HResult; stdcall;
    function Activate(fActive: BOOL): HResult; stdcall;
    function SetChannelPriority(dwChannelGroup, dwChannel, dwPriority: DWORD): HResult; stdcall;
    function GetChannelPriority(dwChannelGroup, dwChannel: DWORD; out pdwPriority: DWORD): HResult; stdcall;
    function SetDirectSound(pDirectSound: IDirectSound; pDirectSoundBuffer: IDirectSoundBuffer): HResult; stdcall;
    function GetFormat(pWaveFormatEx: PWaveFormatEx; var pdwWaveFormatExSize: DWORD;
      out pdwBufferSize: DWORD): HResult; stdcall;
  end;

  IDirectMusicPort8 = IDirectMusicPort;
  {$NODEFINE IDirectMusicPort8}
  {$HPPEMIT 'typedef _di_IDirectMusicPort _di_IDirectMusicPort8;'}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicThru);'}
  {$EXTERNALSYM IDirectMusicThru}
  IDirectMusicThru = interface(IUnknown)
    ['{ced153e7-3606-11d2-b9f9-0000f875ac12}']
    (* IDirectMusicThru *)
    function ThruChannel(dwSourceChannelGroup, dwSourceChannel, dwDestinationChannelGroup,
      dwDestinationChannel: DWORD; pDestinationPort: IDirectMusicPort): HResult; stdcall;
  end;

  IDirectMusicThru8 = IDirectMusicThru;
  {$NODEFINE IDirectMusicThru8}
  {$HPPEMIT 'typedef _di_IDirectMusicThru _di_IDirectMusicThru8;'}

//Translator: IReferenceClock is already defined in DirectSound.pas
  IReferenceClock = DirectSound.IReferenceClock;
  {$NODEFINE IReferenceClock}
(*
  IReferenceClock = interface(IUnknown)
    ['{56a86897-0ad4-11ce-b03a-0020af0ba770}'] *) {
    (*  IReferenceClock *)

    (*  get the time now *)
    function GetTime(out pTime: TReferenceTime): HResult; stdcall;

    (*  ask for an async notification that a time has elapsed *)
    function AdviseTime(const baseTime,                  (*  base time *)
                        streamTime: TReferenceTime;      (*  stream offset time *)
                        hEvent: THANDLE;                 (*  advise via this event *)
                        var pdwAdviseCookie: DWORD): HResult; stdcall;   (*  where your cookie goes *)

    (*  ask for an async periodic notification that a time has elapsed *)
    function AdvisePeriodic(const startTime,                  (*  starting at this time *)
                            periodTime: TReferenceTime;       (*  time between notifications *)
                            hSemaphore: THANDLE;              (*  advise via a semaphore *)
                            var pdwAdviseCookie: DWORD): HResult; stdcall;   (*  where your cookie goes *)

    (*  cancel a request for notification *)
    function Unadvise(dwAdviseCookie: DWORD): HResult; stdcall;
  end;
}

  IID_IReferenceClock = IReferenceClock;
  {$EXTERNALSYM IID_IReferenceClock}

const
  CLSID_DirectMusic: TGUID = '{636b9f10-0c7d-11d1-95b2-0020afdc7421}';
  {$EXTERNALSYM CLSID_DirectMusic}
  CLSID_DirectMusicCollection: TGUID = '{480ff4b0-28b2-11d1-bef7-00c04fbf8fef}';
  {$EXTERNALSYM CLSID_DirectMusicCollection}
  CLSID_DirectMusicSynth: TGUID = '{58C2B4D0-46E7-11D1-89AC-00A0C9054129}';
  {$EXTERNALSYM CLSID_DirectMusicSynth}

  // Alternate interface ID for IID_IDirectMusic, available in DX7 release and after.
  IID_IDirectMusic2: TGUID = '{6fc2cae1-bc78-11d2-afa6-00aa0024d8b6}';
  {$EXTERNALSYM IID_IDirectMusic2}

type
  IID_IDirectMusic = IDirectMusic;
  {$EXTERNALSYM IID_IDirectMusic}
  IID_IDirectMusicBuffer = IDirectMusicBuffer;
  {$EXTERNALSYM IID_IDirectMusicBuffer}
  IID_IDirectMusicPort = IDirectMusicPort;
  {$EXTERNALSYM IID_IDirectMusicPort}
  IID_IDirectMusicThru = IDirectMusicThru;
  {$EXTERNALSYM IID_IDirectMusicThru}
  IID_IDirectMusicPortDownload = IDirectMusicPortDownload;
  {$EXTERNALSYM IID_IDirectMusicPortDownload}
  IID_IDirectMusicDownload = IDirectMusicDownload;
  {$EXTERNALSYM IID_IDirectMusicDownload}
  IID_IDirectMusicCollection = IDirectMusicCollection;
  {$EXTERNALSYM IID_IDirectMusicCollection}
  IID_IDirectMusicInstrument = IDirectMusicInstrument;
  {$EXTERNALSYM IID_IDirectMusicInstrument}
  IID_IDirectMusicDownloadedInstrument = IDirectMusicDownloadedInstrument;
  {$EXTERNALSYM IID_IDirectMusicDownloadedInstrument}

  IID_IDirectMusic8 = IDirectMusic8;
  {$EXTERNALSYM IID_IDirectMusic8}

  IID_IDirectMusicThru8 = IID_IDirectMusicThru;
  {$EXTERNALSYM IID_IDirectMusicThru8}
  IID_IDirectMusicPortDownload8 = IID_IDirectMusicPortDownload;
  {$EXTERNALSYM IID_IDirectMusicPortDownload8}
  IID_IDirectMusicDownload8 = IID_IDirectMusicDownload;
  {$EXTERNALSYM IID_IDirectMusicDownload8}
  IID_IDirectMusicCollection8 = IID_IDirectMusicCollection;
  {$EXTERNALSYM IID_IDirectMusicCollection8}
  IID_IDirectMusicInstrument8 = IID_IDirectMusicInstrument;
  {$EXTERNALSYM IID_IDirectMusicInstrument8}
  IID_IDirectMusicDownloadedInstrument8 = IID_IDirectMusicDownloadedInstrument;
  {$EXTERNALSYM IID_IDirectMusicDownloadedInstrument8}
  IID_IDirectMusicPort8 = IID_IDirectMusicPort;
  {$EXTERNALSYM IID_IDirectMusicPort8}


const   
(* Property Query GUID_DMUS_PROP_GM_Hardware - Local GM set, no need to download
 * Property Query GUID_DMUS_PROP_GS_Hardware - Local GS set, no need to download
 * Property Query GUID_DMUS_PROP_XG_Hardware - Local XG set, no need to download
 * Property Query GUID_DMUS_PROP_DLS1        - Support DLS level 1
 * Property Query GUID_DMUS_PROP_INSTRUMENT2 - Support new INSTRUMENT2 download format
 * Property Query GUID_DMUS_PROP_XG_Capable  - Support minimum requirements of XG
 * Property Query GUID_DMUS_PROP_GS_Capable  - Support minimum requirements of GS
 * Property Query GUID_DMUS_PROP_SynthSink_DSOUND - Synthsink talks to DirectSound
 * Property Query GUID_DMUS_PROP_SynthSink_WAVE - Synthsink talks to Wave device
 *
 * Item 0: Supported
 * Returns a DWORD which is non-zero if the feature is supported
 *)
  GUID_DMUS_PROP_GM_Hardware: TGUID = '{178f2f24-c364-11d1-a760-0000f875ac12}';
  {$EXTERNALSYM GUID_DMUS_PROP_GM_Hardware}
  GUID_DMUS_PROP_GS_Hardware: TGUID = '{178f2f25-c364-11d1-a760-0000f875ac12}';
  {$EXTERNALSYM GUID_DMUS_PROP_GS_Hardware}
  GUID_DMUS_PROP_XG_Hardware: TGUID = '{178f2f26-c364-11d1-a760-0000f875ac12}';
  {$EXTERNALSYM GUID_DMUS_PROP_XG_Hardware}
  GUID_DMUS_PROP_XG_Capable: TGUID = '{6496aba1-61b0-11d2-afa6-00aa0024d8b6}';
  {$EXTERNALSYM GUID_DMUS_PROP_XG_Capable}
  GUID_DMUS_PROP_GS_Capable: TGUID = '{6496aba2-61b0-11d2-afa6-00aa0024d8b6}';
  {$EXTERNALSYM GUID_DMUS_PROP_GS_Capable}
  GUID_DMUS_PROP_DLS1: TGUID = '{178f2f27-c364-11d1-a760-0000f875ac12}';
  {$EXTERNALSYM GUID_DMUS_PROP_DLS1}
  GUID_DMUS_PROP_DLS2: TGUID = '{f14599e5-4689-11d2-afa6-00aa0024d8b6}';
  {$EXTERNALSYM GUID_DMUS_PROP_DLS2}
  GUID_DMUS_PROP_INSTRUMENT2: TGUID = '{865fd372-9f67-11d2-872a-00600893b1bd}';
  {$EXTERNALSYM GUID_DMUS_PROP_INSTRUMENT2}
  GUID_DMUS_PROP_SynthSink_DSOUND: TGUID = '{0aa97844-c877-11d1-870c-00600893b1bd}';
  {$EXTERNALSYM GUID_DMUS_PROP_SynthSink_DSOUND}
  GUID_DMUS_PROP_SynthSink_WAVE: TGUID = '{0aa97845-c877-11d1-870c-00600893b1bd}';
  {$EXTERNALSYM GUID_DMUS_PROP_SynthSink_WAVE}
  GUID_DMUS_PROP_SampleMemorySize: TGUID = '{178f2f28-c364-11d1-a760-0000f875ac12}';
  {$EXTERNALSYM GUID_DMUS_PROP_SampleMemorySize}
  GUID_DMUS_PROP_SamplePlaybackRate: TGUID = '{2a91f713-a4bf-11d2-bbdf-00600833dbd8}';
  {$EXTERNALSYM GUID_DMUS_PROP_SamplePlaybackRate}

(* Property Get/Set GUID_DMUS_PROP_WriteLatency
 *
 * Item 0: Synth buffer write latency, in milliseconds
 * Get/Set SynthSink latency, the average time after the play head that the next buffer gets written.
 *)
  GUID_DMUS_PROP_WriteLatency: TGUID = '{268a0fa0-60f2-11d2-afa6-00aa0024d8b6}';
  {$EXTERNALSYM GUID_DMUS_PROP_WriteLatency}

(* Property Get/Set GUID_DMUS_PROP_WritePeriod
 *
 * Item 0: Synth buffer write period, in milliseconds
 * Get/Set SynthSink buffer write period, time span between successive writes.
 *)
  GUID_DMUS_PROP_WritePeriod: TGUID = '{268a0fa1-60f2-11d2-afa6-00aa0024d8b6}';
  {$EXTERNALSYM GUID_DMUS_PROP_WritePeriod}

(* Property Get GUID_DMUS_PROP_MemorySize
 *
 * Item 0: Memory size
 * Returns a DWORD containing the total number of bytes of sample RAM
 *)
  GUID_DMUS_PROP_MemorySize: TGUID = '{178f2f28-c364-11d1-a760-0000f875ac12}';
  {$EXTERNALSYM GUID_DMUS_PROP_MemorySize}

(* Property Set GUID_DMUS_PROP_WavesReverb
 *
 * Item 0: DMUS_WAVES_REVERB structure
 * Sets reverb parameters
 *)
  GUID_DMUS_PROP_WavesReverb: TGUID = '{04cb5622-32e5-11d2-afa6-00aa0024d8b6}';
  {$EXTERNALSYM GUID_DMUS_PROP_WavesReverb}

(* Property Set GUID_DMUS_PROP_Effects
 *
 * Item 0: DWORD with effects flags.
 * Get/Set effects bits, same as dwEffectFlags in DMUS_PORTPARAMS and DMUS_PORTCAPS:
 * DMUS_EFFECT_NONE
 * DMUS_EFFECT_REVERB
 * DMUS_EFFECT_CHORUS
 *)
  GUID_DMUS_PROP_Effects: TGUID = '{cda8d611-684a-11d2-871e-00600893b1bd}';
  {$EXTERNALSYM GUID_DMUS_PROP_Effects}

(* Property Set GUID_DMUS_PROP_LegacyCaps
 *
 * Item 0: The MIDINCAPS or MIDIOUTCAPS which describes the port's underlying WinMM device. This property is only supported
 * by ports which wrap WinMM devices.
 *)

  GUID_DMUS_PROP_LegacyCaps: TGUID = '{cfa7cdc2-00a1-11d2-aad5-0000f875ac12}';
  {$EXTERNALSYM GUID_DMUS_PROP_LegacyCaps}

(* Property Set GUID_DMUS_PROP_Volume
 *
 * Item 0: A long which contains an offset, in 1/100 dB, to be added to the final volume
 *
 *)
  GUID_DMUS_PROP_Volume: TGUID = '{fedfae25-e46e-11d1-aace-0000f875ac12}';
  {$EXTERNALSYM GUID_DMUS_PROP_Volume}

  // Min and Max values for setting volume with GUID_DMUS_PROP_Volume

  DMUS_VOLUME_MAX     = 2000;        (* +20 dB *)
  {$EXTERNALSYM DMUS_VOLUME_MAX}
  DMUS_VOLUME_MIN   = -20000;        (* -200 dB *)
  {$EXTERNALSYM DMUS_VOLUME_MIN}



(************************************************************************
*                                                                       *
*   dmusici.h -- This module contains the API for the                   *
*                DirectMusic performance layer                          *
*                                                                       *
*   Copyright (c) Microsoft Corporation.  All rights reserved.          *
*                                                                       *
************************************************************************)

type
  TRANSITION_TYPE = Word;
  {$EXTERNALSYM TRANSITION_TYPE}

  PMusicTime = ^TMusicTime;
  MUSIC_TIME = Longint;
  {$EXTERNALSYM MUSIC_TIME}
  TMusicTime = MUSIC_TIME;


const
  MT_MIN          = $80000000;  // Minimum music time value.
  {$EXTERNALSYM MT_MIN}
  MT_MAX          = $7FFFFFFF;  // Maximum music time value.
  {$EXTERNALSYM MT_MAX}

  DMUS_PPQ        = 768;     // parts per quarter note
  {$EXTERNALSYM DMUS_PPQ}


type
  PDMusStyletTypes = ^TDMusStyletTypes;
  enumDMUS_STYLET_TYPES = (
    DMUS_STYLET_PATTERN         {= 0},
    DMUS_STYLET_MOTIF           {= 1}
  );
  {$EXTERNALSYM enumDMUS_STYLET_TYPES}
  DMUS_STYLET_TYPES = enumDMUS_STYLET_TYPES;
  {$EXTERNALSYM DMUS_STYLET_TYPES}
  TDMusStyletTypes = DMUS_STYLET_TYPES;


  enumDMUS_COMMANDT_TYPES = (
    DMUS_COMMANDT_GROOVE            {= 0},
    DMUS_COMMANDT_FILL              {= 1},
    DMUS_COMMANDT_INTRO             {= 2},
    DMUS_COMMANDT_BREAK             {= 3},
    DMUS_COMMANDT_END               {= 4},
    DMUS_COMMANDT_ENDANDINTRO       {= 5}
  );
  {$EXTERNALSYM enumDMUS_COMMANDT_TYPES}
  DMUS_COMMANDT_TYPES = enumDMUS_COMMANDT_TYPES;
  {$EXTERNALSYM DMUS_COMMANDT_TYPES}
  TDMusCommandtTypes = DMUS_COMMANDT_TYPES;
  PDMusCommandtTypes = ^TDMusCommandtTypes;

  PDMusShapetTypes = ^TDMusShapetTypes;
  enumDMUS_SHAPET_TYPES = (
    DMUS_SHAPET_FALLING             {= 0},
    DMUS_SHAPET_LEVEL               {= 1},
    DMUS_SHAPET_LOOPABLE            {= 2},
    DMUS_SHAPET_LOUD                {= 3},
    DMUS_SHAPET_QUIET               {= 4},
    DMUS_SHAPET_PEAKING             {= 5},
    DMUS_SHAPET_RANDOM              {= 6},
    DMUS_SHAPET_RISING              {= 7},
    DMUS_SHAPET_SONG                {= 8}
  );
  {$EXTERNALSYM enumDMUS_SHAPET_TYPES}
  DMUS_SHAPET_TYPES = enumDMUS_SHAPET_TYPES;
  {$EXTERNALSYM DMUS_SHAPET_TYPES}
  TDMusShapetTypes = DMUS_SHAPET_TYPES;

  enumDMUS_COMPOSEF_FLAGS = DWORD;
  {$EXTERNALSYM enumDMUS_COMPOSEF_FLAGS}
  DMUS_COMPOSEF_FLAGS = enumDMUS_COMPOSEF_FLAGS;
  {$EXTERNALSYM DMUS_COMPOSEF_FLAGS}
  TDMusComposefFlags = DMUS_COMPOSEF_FLAGS;
  PDMusComposefFlags = ^TDMusComposefFlags;

const
  DMUS_COMPOSEF_NONE              = 0;
  {$EXTERNALSYM DMUS_COMPOSEF_NONE}
  DMUS_COMPOSEF_ALIGN             = $1;
  {$EXTERNALSYM DMUS_COMPOSEF_ALIGN}
  DMUS_COMPOSEF_OVERLAP           = $2;
  {$EXTERNALSYM DMUS_COMPOSEF_OVERLAP}
  DMUS_COMPOSEF_IMMEDIATE         = $4;
  {$EXTERNALSYM DMUS_COMPOSEF_IMMEDIATE}
  DMUS_COMPOSEF_GRID              = $8;
  {$EXTERNALSYM DMUS_COMPOSEF_GRID}
  DMUS_COMPOSEF_BEAT              = $10;
  {$EXTERNALSYM DMUS_COMPOSEF_BEAT}
  DMUS_COMPOSEF_MEASURE           = $20;
  {$EXTERNALSYM DMUS_COMPOSEF_MEASURE}
  DMUS_COMPOSEF_AFTERPREPARETIME  = $40;
  {$EXTERNALSYM DMUS_COMPOSEF_AFTERPREPARETIME}
  DMUS_COMPOSEF_VALID_START_BEAT  = $80;   (* In conjunction with DMUS_COMPOSEF_ALIGN, allows the switch to occur on any beat. *)
  {$EXTERNALSYM DMUS_COMPOSEF_VALID_START_BEAT}
  DMUS_COMPOSEF_VALID_START_GRID  = $100;  (* In conjunction with DMUS_COMPOSEF_ALIGN, allows the switch to occur on any grid. *)
  {$EXTERNALSYM DMUS_COMPOSEF_VALID_START_GRID}
  DMUS_COMPOSEF_VALID_START_TICK  = $200;  (* In conjunction with DMUS_COMPOSEF_ALIGN, allows the switch to occur any time. *)
  {$EXTERNALSYM DMUS_COMPOSEF_VALID_START_TICK}
  DMUS_COMPOSEF_SEGMENTEND        = $400;  (* Play the transition at the end of the current segment. *)
  {$EXTERNALSYM DMUS_COMPOSEF_SEGMENTEND}
  DMUS_COMPOSEF_MARKER            = $800;  (* Play the transition at the next marker in the current segment. *)
  {$EXTERNALSYM DMUS_COMPOSEF_MARKER}
  DMUS_COMPOSEF_MODULATE          = $1000;
  {$EXTERNALSYM DMUS_COMPOSEF_MODULATE}
  DMUS_COMPOSEF_LONG              = $2000;
  {$EXTERNALSYM DMUS_COMPOSEF_LONG}
  DMUS_COMPOSEF_ENTIRE_TRANSITION = $4000;    (* play the entire transition pattern *)
  {$EXTERNALSYM DMUS_COMPOSEF_ENTIRE_TRANSITION}
  DMUS_COMPOSEF_1BAR_TRANSITION   = $8000;    (* play one bar of the transition pattern *)
  {$EXTERNALSYM DMUS_COMPOSEF_1BAR_TRANSITION}
  DMUS_COMPOSEF_ENTIRE_ADDITION   = $10000;   (* play the additional pattern in its entirety *)
  {$EXTERNALSYM DMUS_COMPOSEF_ENTIRE_ADDITION}
  DMUS_COMPOSEF_1BAR_ADDITION     = $20000;   (* play one bar of the additional pattern *)
  {$EXTERNALSYM DMUS_COMPOSEF_1BAR_ADDITION}
  DMUS_COMPOSEF_VALID_START_MEASURE = $40000; (* In conjunction with DMUS_COMPOSEF_ALIGN, allows the switch to occur on any bar. *)
  {$EXTERNALSYM DMUS_COMPOSEF_VALID_START_MEASURE}
  DMUS_COMPOSEF_DEFAULT           = $80000;   (* Use segment's default boundary *)
  {$EXTERNALSYM DMUS_COMPOSEF_DEFAULT}
  DMUS_COMPOSEF_NOINVALIDATE      = $100000;  (* Play without invalidating the currently playing segment(s) *)
  {$EXTERNALSYM DMUS_COMPOSEF_NOINVALIDATE}
  DMUS_COMPOSEF_USE_AUDIOPATH     = $200000;  (* Uses the audio paths that are embedded in the segments *)
  {$EXTERNALSYM DMUS_COMPOSEF_USE_AUDIOPATH}
  DMUS_COMPOSEF_INVALIDATE_PRI    = $400000;  (* Invalidate only the current primary seg state *)
  {$EXTERNALSYM DMUS_COMPOSEF_INVALIDATE_PRI}



const
  DMUS_PCHANNEL_BROADCAST_PERFORMANCE = $FFFFFFFF;  // PMsg is sent on all PChannels of the performance.
  {$EXTERNALSYM DMUS_PCHANNEL_BROADCAST_PERFORMANCE}
  DMUS_PCHANNEL_BROADCAST_AUDIOPATH   = $FFFFFFFE;  // PMsg is sent on all PChannels of the audio path.
  {$EXTERNALSYM DMUS_PCHANNEL_BROADCAST_AUDIOPATH}
  DMUS_PCHANNEL_BROADCAST_SEGMENT     = $FFFFFFFD;  // PMsg is sent on all PChannels of the segment.
  {$EXTERNALSYM DMUS_PCHANNEL_BROADCAST_SEGMENT}
  DMUS_PCHANNEL_BROADCAST_GROUPS      = $FFFFFFFC;  // A duplicate PMsg is for each Channels Groups in the performance.
  {$EXTERNALSYM DMUS_PCHANNEL_BROADCAST_GROUPS}

(*  The DMUS_PATH constants are used in conjunction with GetObjectInPath to find a requested
    interface at a particular stage in the audio path.
*)
  DMUS_PATH_SEGMENT          = $1000;      // Get the segment itself (from a segment state.)
  {$EXTERNALSYM DMUS_PATH_SEGMENT}
  DMUS_PATH_SEGMENT_TRACK    = $1100;      // Look in Track List of Segment.
  {$EXTERNALSYM DMUS_PATH_SEGMENT_TRACK}
  DMUS_PATH_SEGMENT_GRAPH    = $1200;      // Get the segment's tool graph.
  {$EXTERNALSYM DMUS_PATH_SEGMENT_GRAPH}
  DMUS_PATH_SEGMENT_TOOL     = $1300;      // Look in Tool Graph of Segment.
  {$EXTERNALSYM DMUS_PATH_SEGMENT_TOOL}
  DMUS_PATH_AUDIOPATH        = $2000;      // Get the audiopath itself (from a segment state.)
  {$EXTERNALSYM DMUS_PATH_AUDIOPATH}
  DMUS_PATH_AUDIOPATH_GRAPH  = $2200;      // Get the audiopath's tool graph.
  {$EXTERNALSYM DMUS_PATH_AUDIOPATH_GRAPH}
  DMUS_PATH_AUDIOPATH_TOOL   = $2300;      // Look in Tool Graph of Audio Path.
  {$EXTERNALSYM DMUS_PATH_AUDIOPATH_TOOL}
  DMUS_PATH_PERFORMANCE      = $3000;      // Access the performance.
  {$EXTERNALSYM DMUS_PATH_PERFORMANCE}
  DMUS_PATH_PERFORMANCE_GRAPH = $3200;     // Get the performance's tool graph.
  {$EXTERNALSYM DMUS_PATH_PERFORMANCE_GRAPH}
  DMUS_PATH_PERFORMANCE_TOOL = $3300;      // Look in Tool Graph of Performance.
  {$EXTERNALSYM DMUS_PATH_PERFORMANCE_TOOL}
  DMUS_PATH_PORT             = $4000;      // Access the synth.
  {$EXTERNALSYM DMUS_PATH_PORT}
  DMUS_PATH_BUFFER           = $6000;      // Look in DirectSoundBuffer.
  {$EXTERNALSYM DMUS_PATH_BUFFER}
  DMUS_PATH_BUFFER_DMO       = $6100;      // Access a DMO in the buffer.
  {$EXTERNALSYM DMUS_PATH_BUFFER_DMO}
  DMUS_PATH_MIXIN_BUFFER     = $7000;      // Look in a global mixin buffer.
  {$EXTERNALSYM DMUS_PATH_MIXIN_BUFFER}
  DMUS_PATH_MIXIN_BUFFER_DMO = $7100;      // Access a DMO in a global mixin buffer.
  {$EXTERNALSYM DMUS_PATH_MIXIN_BUFFER_DMO}
  DMUS_PATH_PRIMARY_BUFFER   = $8000;      // Access the primary buffer.
  {$EXTERNALSYM DMUS_PATH_PRIMARY_BUFFER}

(*  To ignore PChannels when calling GetObjectInPath(), use the DMUS_PCHANNEL_ALL constant. *)
  DMUS_PCHANNEL_ALL           = $FFFFFFFB;
  {$EXTERNALSYM DMUS_PCHANNEL_ALL}

(*  The DMUS_APATH types are used in conjunction with CreateStandardAudioPath to
    build default path types. _SHARED_ means the same buffer is shared across multiple
    instantiations of the audiopath type. _DYNAMIC_ means a unique buffer is created
    every time.
*)

  DMUS_APATH_SHARED_STEREOPLUSREVERB   = 1;       // A standard music set up with stereo outs and reverb.
  {$EXTERNALSYM DMUS_APATH_SHARED_STEREOPLUSREVERB}
  DMUS_APATH_DYNAMIC_3D                = 6;       // An audio path with one dynamic bus from the synth feeding to a dynamic 3d buffer. Does not send to env reverb.
  {$EXTERNALSYM DMUS_APATH_DYNAMIC_3D}
  DMUS_APATH_DYNAMIC_MONO              = 7;       // An audio path with one dynamic bus from the synth feeding to a dynamic mono buffer.
  {$EXTERNALSYM DMUS_APATH_DYNAMIC_MONO}
  DMUS_APATH_DYNAMIC_STEREO            = 8;       // An audio path with two dynamic buses from the synth feeding to a dynamic stereo buffer.
  {$EXTERNALSYM DMUS_APATH_DYNAMIC_STEREO}

type
  PDMusAudioParams = ^TDMusAudioParams;
  _DMUS_AUDIOPARAMS = record
    dwSize: DWORD;             // Size of this structure.
    fInitNow: BOOL;            // If true, the sink and synth are created immediately and results returned in this structure.
    dwValidData: DWORD;        // Flags indicating which fields below are valid.
    dwFeatures: DWORD;         // Required DMUS_AUDIOF features.
    dwVoices: DWORD;           // Required number of voices.
    dwSampleRate: DWORD;       // Sample rate of synths and sink.
    clsidDefaultSynth: TGUID; // Class ID of default synthesizer.
  end;
  {$EXTERNALSYM _DMUS_AUDIOPARAMS}
  DMUS_AUDIOPARAMS = _DMUS_AUDIOPARAMS;
  {$EXTERNALSYM DMUS_AUDIOPARAMS}
  TDMusAudioParams = _DMUS_AUDIOPARAMS;

const
  (* dwFeatures flags. These indicate which features are required for the audio environment. *)
  DMUS_AUDIOF_3D          = $1;   // Require 3D buffers.
  {$EXTERNALSYM DMUS_AUDIOF_3D}
  DMUS_AUDIOF_ENVIRON     = $2;   // Require environmental modeling.
  {$EXTERNALSYM DMUS_AUDIOF_ENVIRON}
  DMUS_AUDIOF_EAX         = $4;   // Require use of EAX effects.
  {$EXTERNALSYM DMUS_AUDIOF_EAX}
  DMUS_AUDIOF_DMOS        = $8;   // Require use of additional DMOs.
  {$EXTERNALSYM DMUS_AUDIOF_DMOS}
  DMUS_AUDIOF_STREAMING   = $10;  // Require support for streaming waves.
  {$EXTERNALSYM DMUS_AUDIOF_STREAMING}
  DMUS_AUDIOF_BUFFERS     = $20;  // Require support for multiple buffers (all above cases need this.)
  {$EXTERNALSYM DMUS_AUDIOF_BUFFERS}
  DMUS_AUDIOF_ALL         = $3F;  // Requires everything.
  {$EXTERNALSYM DMUS_AUDIOF_ALL}

  (* dwValidData flags. These indicate which fields in DMUS_AUDIOPARAMS have been filled in. If fInitNow is set, these also return what was allocated. *)
  DMUS_AUDIOPARAMS_FEATURES       = $00000001;
  {$EXTERNALSYM DMUS_AUDIOPARAMS_FEATURES}
  DMUS_AUDIOPARAMS_VOICES         = $00000002;
  {$EXTERNALSYM DMUS_AUDIOPARAMS_VOICES}
  DMUS_AUDIOPARAMS_SAMPLERATE     = $00000004;
  {$EXTERNALSYM DMUS_AUDIOPARAMS_SAMPLERATE}
  DMUS_AUDIOPARAMS_DEFAULTSYNTH   = $00000008;
  {$EXTERNALSYM DMUS_AUDIOPARAMS_DEFAULTSYNTH}

(* DMUS_PMSGF_FLAGS fill the DMUS_PMSG's dwFlags member *)
type
  enumDMUS_PMSGF_FLAGS = DWORD;
  {$EXTERNALSYM enumDMUS_PMSGF_FLAGS}
  DMUS_PMSGF_FLAGS = enumDMUS_PMSGF_FLAGS;
  {$EXTERNALSYM DMUS_PMSGF_FLAGS}
  TDMusPmsgfFlags = DMUS_PMSGF_FLAGS;
  PDMusPmsgfFlags = ^TDMusPmsgfFlags;

const
  DMUS_PMSGF_REFTIME          = 1;      // if rtTime is valid
  {$EXTERNALSYM DMUS_PMSGF_REFTIME}
  DMUS_PMSGF_MUSICTIME        = 2;      // if mtTime is valid
  {$EXTERNALSYM DMUS_PMSGF_MUSICTIME}
  DMUS_PMSGF_TOOL_IMMEDIATE   = 4;      // if PMSG should be processed immediately
  {$EXTERNALSYM DMUS_PMSGF_TOOL_IMMEDIATE}
  DMUS_PMSGF_TOOL_QUEUE       = 8;      // if PMSG should be processed a little early, at Queue time
  {$EXTERNALSYM DMUS_PMSGF_TOOL_QUEUE}
  DMUS_PMSGF_TOOL_ATTIME      = $10;    // if PMSG should be processed at the time stamp
  {$EXTERNALSYM DMUS_PMSGF_TOOL_ATTIME}
  DMUS_PMSGF_TOOL_FLUSH       = $20;    // if PMSG is being flushed
  {$EXTERNALSYM DMUS_PMSGF_TOOL_FLUSH}
  DMUS_PMSGF_LOCKTOREFTIME    = $40;    // if rtTime can not be overriden by a tempo change.
  {$EXTERNALSYM DMUS_PMSGF_LOCKTOREFTIME}
  DMUS_PMSGF_DX8              = $80;    // if the message has DX8 or later extensions.
  {$EXTERNALSYM DMUS_PMSGF_DX8}
  // The values of DMUS_TIME_RESOLVE_FLAGS may also be used inside the
  // DMUS_PMSG's dwFlags member.

(* DMUS_PMSGT_TYPES fill the DMUS_PMSG's dwType member *)
type
  enumDMUS_PMSGT_TYPES = DWORD;
  {$EXTERNALSYM enumDMUS_PMSGT_TYPES}
  DMUS_PMSGT_TYPES = enumDMUS_PMSGT_TYPES;
  {$EXTERNALSYM DMUS_PMSGT_TYPES}
  TDMusPmsgtTypes = DMUS_PMSGT_TYPES;
  PDMusPmsgtTypes = ^TDMusPmsgtTypes;

const
  DMUS_PMSGT_MIDI             = 0;      // MIDI short message
  {$EXTERNALSYM DMUS_PMSGT_MIDI}
  DMUS_PMSGT_NOTE             = 1;      // Interactive Music Note
  {$EXTERNALSYM DMUS_PMSGT_NOTE}
  DMUS_PMSGT_SYSEX            = 2;      // MIDI long message (system exclusive message)
  {$EXTERNALSYM DMUS_PMSGT_SYSEX}
  DMUS_PMSGT_NOTIFICATION     = 3;      // Notification message
  {$EXTERNALSYM DMUS_PMSGT_NOTIFICATION}
  DMUS_PMSGT_TEMPO            = 4;      // Tempo message
  {$EXTERNALSYM DMUS_PMSGT_TEMPO}
  DMUS_PMSGT_CURVE            = 5;      // Control change / pitch bend, etc. curve
  {$EXTERNALSYM DMUS_PMSGT_CURVE}
  DMUS_PMSGT_TIMESIG          = 6;      // Time signature
  {$EXTERNALSYM DMUS_PMSGT_TIMESIG}
  DMUS_PMSGT_PATCH            = 7;      // Patch changes
  {$EXTERNALSYM DMUS_PMSGT_PATCH}
  DMUS_PMSGT_TRANSPOSE        = 8;      // Transposition messages
  {$EXTERNALSYM DMUS_PMSGT_TRANSPOSE}
  DMUS_PMSGT_CHANNEL_PRIORITY = 9;      // Channel priority
  {$EXTERNALSYM DMUS_PMSGT_CHANNEL_PRIORITY}
  DMUS_PMSGT_STOP             = 10;     // Stop message
  {$EXTERNALSYM DMUS_PMSGT_STOP}
  DMUS_PMSGT_DIRTY            = 11;     // Tells Tools that cache GetParam() info to refresh
  {$EXTERNALSYM DMUS_PMSGT_DIRTY}
  DMUS_PMSGT_WAVE             = 12;     // Carries control information for playing a wave.
  {$EXTERNALSYM DMUS_PMSGT_WAVE}
  DMUS_PMSGT_LYRIC            = 13;     // Lyric message from lyric track.
  {$EXTERNALSYM DMUS_PMSGT_LYRIC}
  DMUS_PMSGT_SCRIPTLYRIC      = 14;     // Lyric message sent by a script with the Trace function.
  {$EXTERNALSYM DMUS_PMSGT_SCRIPTLYRIC}
  DMUS_PMSGT_USER             = 255;    // User message
  {$EXTERNALSYM DMUS_PMSGT_USER}

type
  (* DMUS_SEGF_FLAGS correspond to IDirectMusicPerformance::PlaySegment, and other API *)
  enumDMUS_SEGF_FLAGS = DWORD;
  DMUS_SEGF_FLAGS = enumDMUS_SEGF_FLAGS;
  {$EXTERNALSYM DMUS_SEGF_FLAGS}
  TDMusSegfFlags = DMUS_SEGF_FLAGS;
  PDMusSegfFlags = ^TDMusSegfFlags;

const
  DMUS_SEGF_REFTIME           = 1 shl 6;   // 0x40 Time parameter is in reference time
  {$EXTERNALSYM DMUS_SEGF_REFTIME}
  DMUS_SEGF_SECONDARY         = 1 shl 7;   // 0x80 Secondary segment
  {$EXTERNALSYM DMUS_SEGF_SECONDARY}
  DMUS_SEGF_QUEUE             = 1 shl 8;   // 0x100 Queue at the end of the primary segment queue (primary only)
  {$EXTERNALSYM DMUS_SEGF_QUEUE}
  DMUS_SEGF_CONTROL           = 1 shl 9;   // 0x200 Play as a control track (secondary segments only)
  {$EXTERNALSYM DMUS_SEGF_CONTROL}
  DMUS_SEGF_AFTERPREPARETIME  = 1 shl 10;  // 0x400 Play after the prepare time (See IDirectMusicPerformance::GetPrepareTime)
  {$EXTERNALSYM DMUS_SEGF_AFTERPREPARETIME}
  DMUS_SEGF_GRID              = 1 shl 11;  // 0x800 Play on grid boundary
  {$EXTERNALSYM DMUS_SEGF_GRID}
  DMUS_SEGF_BEAT              = 1 shl 12;  // 0x1000 Play on beat boundary
  {$EXTERNALSYM DMUS_SEGF_BEAT}
  DMUS_SEGF_MEASURE           = 1 shl 13;  // 0x2000 Play on measure boundary
  {$EXTERNALSYM DMUS_SEGF_MEASURE}
  DMUS_SEGF_DEFAULT           = 1 shl 14;  // 0x4000 Use segment's default boundary
  {$EXTERNALSYM DMUS_SEGF_DEFAULT}
  DMUS_SEGF_NOINVALIDATE      = 1 shl 15;  // 0x8000 Play without invalidating the currently playing segment(s)
  {$EXTERNALSYM DMUS_SEGF_NOINVALIDATE}
  DMUS_SEGF_ALIGN             = 1 shl 16;  // 0x10000 Align segment with requested boundary, but switch at first valid point
  {$EXTERNALSYM DMUS_SEGF_ALIGN}
  DMUS_SEGF_VALID_START_BEAT  = 1 shl 17;  // 0x20000 In conjunction with DMUS_SEGF_ALIGN, allows the switch to occur on any beat.
  {$EXTERNALSYM DMUS_SEGF_VALID_START_BEAT}
  DMUS_SEGF_VALID_START_GRID  = 1 shl 18;  // 0x40000 In conjunction with DMUS_SEGF_ALIGN, allows the switch to occur on any grid.
  {$EXTERNALSYM DMUS_SEGF_VALID_START_GRID}
  DMUS_SEGF_VALID_START_TICK  = 1 shl 19;  // 0x80000 In conjunction with DMUS_SEGF_ALIGN, allows the switch to occur any time.
  {$EXTERNALSYM DMUS_SEGF_VALID_START_TICK}
  DMUS_SEGF_AUTOTRANSITION    = 1 shl 20;  // 0x100000 Compose and play a transition segment, using the transition template.
  {$EXTERNALSYM DMUS_SEGF_AUTOTRANSITION}
  DMUS_SEGF_AFTERQUEUETIME    = 1 shl 21;  // 0x200000 Make sure to play after the queue time. This is default for primary segments
  {$EXTERNALSYM DMUS_SEGF_AFTERQUEUETIME}
  DMUS_SEGF_AFTERLATENCYTIME  = 1 shl 22;  // 0x400000 Make sure to play after the latency time. This is true for all segments, so this is a nop
  {$EXTERNALSYM DMUS_SEGF_AFTERLATENCYTIME}
  DMUS_SEGF_SEGMENTEND        = 1 shl 23;  // 0x800000 Play at the next end of segment.
  {$EXTERNALSYM DMUS_SEGF_SEGMENTEND}
  DMUS_SEGF_MARKER            = 1 shl 24;  // 0x1000000 Play at next marker in the primary segment. If there are no markers, default to any other resolution requests.
  {$EXTERNALSYM DMUS_SEGF_MARKER}
  DMUS_SEGF_TIMESIG_ALWAYS    = 1 shl 25;  // 0x2000000 Even if there is no primary segment, align start time with current time signature.
  {$EXTERNALSYM DMUS_SEGF_TIMESIG_ALWAYS}
  DMUS_SEGF_USE_AUDIOPATH     = 1 shl 26;  // 0x4000000 Uses the audio path that is embedded in the segment.
  {$EXTERNALSYM DMUS_SEGF_USE_AUDIOPATH}
  DMUS_SEGF_VALID_START_MEASURE = 1 shl 27; // 0x8000000 In conjunction with DMUS_SEGF_ALIGN, allows the switch to occur on any bar.
  {$EXTERNALSYM DMUS_SEGF_VALID_START_MEASURE}
  DMUS_SEGF_INVALIDATE_PRI    = 1 shl 28;  // 0x10000000 invalidate only the current primary seg state
  {$EXTERNALSYM DMUS_SEGF_INVALIDATE_PRI}

  DMUS_SEG_REPEAT_INFINITE    = $FFFFFFFF;  // For IDirectMusicSegment::SetRepeat
  {$EXTERNALSYM DMUS_SEG_REPEAT_INFINITE}
  DMUS_SEG_ALLTRACKS          = $80000000;  // For IDirectMusicSegment::SetParam() and SetTrackConfig() - selects all tracks instead on nth index.
  {$EXTERNALSYM DMUS_SEG_ALLTRACKS}
  DMUS_SEG_ANYTRACK           = $80000000;  // For IDirectMusicSegment::GetParam() - checks each track until it finds one that returns data (not DMUS_E_NOT_FOUND.)
  {$EXTERNALSYM DMUS_SEG_ANYTRACK}


// DMUS_TIME_RESOLVE_FLAGS correspond to IDirectMusicPerformance::GetResolvedTime, and can
// also be used interchangeably with the corresponding DMUS_SEGF_FLAGS, since their values
// are intentionally the same
type
  enumDMUS_TIME_RESOLVE_FLAGS = DWORD;
  {$EXTERNALSYM enumDMUS_TIME_RESOLVE_FLAGS}
  DMUS_TIME_RESOLVE_FLAGS = enumDMUS_TIME_RESOLVE_FLAGS;
  {$EXTERNALSYM DMUS_TIME_RESOLVE_FLAGS}
  TDMusTimeResolveFlags = DMUS_TIME_RESOLVE_FLAGS;
  PDMusTimeResolveFlags = ^TDMusTimeResolveFlags;

const
  DMUS_TIME_RESOLVE_AFTERPREPARETIME  = DMUS_SEGF_AFTERPREPARETIME;
  {$EXTERNALSYM DMUS_TIME_RESOLVE_AFTERPREPARETIME}
  DMUS_TIME_RESOLVE_AFTERQUEUETIME    = DMUS_SEGF_AFTERQUEUETIME;
  {$EXTERNALSYM DMUS_TIME_RESOLVE_AFTERQUEUETIME}
  DMUS_TIME_RESOLVE_AFTERLATENCYTIME  = DMUS_SEGF_AFTERLATENCYTIME;
  {$EXTERNALSYM DMUS_TIME_RESOLVE_AFTERLATENCYTIME}
  DMUS_TIME_RESOLVE_GRID              = DMUS_SEGF_GRID;
  {$EXTERNALSYM DMUS_TIME_RESOLVE_GRID}
  DMUS_TIME_RESOLVE_BEAT              = DMUS_SEGF_BEAT;
  {$EXTERNALSYM DMUS_TIME_RESOLVE_BEAT}
  DMUS_TIME_RESOLVE_MEASURE           = DMUS_SEGF_MEASURE;
  {$EXTERNALSYM DMUS_TIME_RESOLVE_MEASURE}
  DMUS_TIME_RESOLVE_MARKER            = DMUS_SEGF_MARKER;
  {$EXTERNALSYM DMUS_TIME_RESOLVE_MARKER}
  DMUS_TIME_RESOLVE_SEGMENTEND        = DMUS_SEGF_SEGMENTEND;
  {$EXTERNALSYM DMUS_TIME_RESOLVE_SEGMENTEND}

type
  (* The following flags are sent inside the DMUS_CHORD_KEY.dwFlags parameter *)
  enumDMUS_CHORDKEYF_FLAGS = DWORD;
  {$EXTERNALSYM enumDMUS_CHORDKEYF_FLAGS}
  DMUS_CHORDKEYF_FLAGS = enumDMUS_CHORDKEYF_FLAGS;
  {$EXTERNALSYM DMUS_CHORDKEYF_FLAGS}
  TDMusChordkeyfFlags = DMUS_CHORDKEYF_FLAGS;
  PDMusChordkeyfFlags = ^TDMusChordkeyfFlags;

const
  DMUS_CHORDKEYF_SILENT            = 1;      // is the chord silent?
  {$EXTERNALSYM DMUS_CHORDKEYF_SILENT}

  DMUS_MAXSUBCHORD = 8;
  {$EXTERNALSYM DMUS_MAXSUBCHORD}

type
  PDMusSubChord = ^TDMusSubChord;
  _DMUS_SUBCHORD = record
    dwChordPattern: DWORD;     // Notes in the subchord
    dwScalePattern: DWORD;     // Notes in the scale
    dwInversionPoints: DWORD;  // Where inversions can occur
    dwLevels: DWORD;           // Which levels are supported by this subchord
    bChordRoot: Byte;          // Root of the subchord
    bScaleRoot: Byte;          // Root of the scale
  end;
  {$EXTERNALSYM _DMUS_SUBCHORD}
  DMUS_SUBCHORD = _DMUS_SUBCHORD;
  {$EXTERNALSYM DMUS_SUBCHORD}
  TDMusSubChord = _DMUS_SUBCHORD;

  PDMusChordKey = ^TDMusChordKey;
  _DMUS_CHORD_KEY = record
    wszName: array [0..15] of WideChar;   // Name of the chord
    wMeasure: Word;           // Measure this falls on
    bBeat: Byte;              // Beat this falls on
    bSubChordCount: Byte;     // Number of chords in the list of subchords
    SubChordList: array[0..DMUS_MAXSUBCHORD-1] of TDMUSSUBCHORD; // List of sub chords
    dwScale: DWORD;            // Scale underlying the entire chord
    bKey: Byte;               // Key underlying the entire chord
    bFlags: Byte;             // Miscelaneous flags
  end;
  {$EXTERNALSYM _DMUS_CHORD_KEY}
  DMUS_CHORD_KEY = _DMUS_CHORD_KEY;
  {$EXTERNALSYM DMUS_CHORD_KEY}
  TDMusChordKey = _DMUS_CHORD_KEY;

  enumDMUS_NOTEF_FLAGS = DWORD;
  {$EXTERNALSYM enumDMUS_NOTEF_FLAGS}
  DMUS_NOTEF_FLAGS = enumDMUS_NOTEF_FLAGS;
  {$EXTERNALSYM DMUS_NOTEF_FLAGS}
  TDMusNotefFlags = DMUS_NOTEF_FLAGS;
  PDMusNotefFlags = ^TDMusNotefFlags;

const
  DMUS_NOTEF_NOTEON = 1;              // Set if this is a MIDI Note On. Otherwise, it is MIDI Note Off
  {$EXTERNALSYM DMUS_NOTEF_NOTEON}
  // DX8 flags: 
  DMUS_NOTEF_NOINVALIDATE = 2;        // Don't invalidate this note off.
  {$EXTERNALSYM DMUS_NOTEF_NOINVALIDATE}
  DMUS_NOTEF_NOINVALIDATE_INSCALE = 4;// Don't invalidate if still within the scale.
  {$EXTERNALSYM DMUS_NOTEF_NOINVALIDATE_INSCALE}
  DMUS_NOTEF_NOINVALIDATE_INCHORD = 8;// Don't invalidate if still within the chord.
  {$EXTERNALSYM DMUS_NOTEF_NOINVALIDATE_INCHORD}
  DMUS_NOTEF_REGENERATE = #10;        // Regenerate the note on an invalidate.
  {$EXTERNALSYM DMUS_NOTEF_REGENERATE}

type
(* The DMUS_PLAYMODE_FLAGS are used to determine how to convert wMusicValue
   into the appropriate bMidiValue.
*)
  enumDMUS_PLAYMODE_FLAGS = Byte;
  DMUS_PLAYMODE_FLAGS = enumDMUS_PLAYMODE_FLAGS;

const
  DMUS_PLAYMODE_KEY_ROOT          = 1;  // Transpose on top of the key root.
  {$EXTERNALSYM DMUS_PLAYMODE_KEY_ROOT}
  DMUS_PLAYMODE_CHORD_ROOT        = 2;  // Transpose on top of the chord root.
  {$EXTERNALSYM DMUS_PLAYMODE_CHORD_ROOT}
  DMUS_PLAYMODE_SCALE_INTERVALS   = 4;  // Use scale intervals from scale pattern.
  {$EXTERNALSYM DMUS_PLAYMODE_SCALE_INTERVALS}
  DMUS_PLAYMODE_CHORD_INTERVALS   = 8;  // Use chord intervals from chord pattern.
  {$EXTERNALSYM DMUS_PLAYMODE_CHORD_INTERVALS}
  DMUS_PLAYMODE_NONE              = 16; // No mode. Indicates the parent part's mode should be used.
  {$EXTERNALSYM DMUS_PLAYMODE_NONE}

(* The following are playback modes that can be created by combining the DMUS_PLAYMODE_FLAGS
   in various ways:
*)

(* Fixed. wMusicValue holds final MIDI note value. This is used for drums, sound effects, and sequenced
   notes that should not be transposed by the chord or scale.
*)
  DMUS_PLAYMODE_FIXED             = 0;
  {$EXTERNALSYM DMUS_PLAYMODE_FIXED}
(* In fixed to key, the musicvalue is again a fixed MIDI value, but it
   is transposed on top of the key root.
*)
  DMUS_PLAYMODE_FIXEDTOKEY        = DMUS_PLAYMODE_KEY_ROOT;
  {$EXTERNALSYM DMUS_PLAYMODE_FIXEDTOKEY}
(* In fixed to chord, the musicvalue is also a fixed MIDI value, but it
   is transposed on top of the chord root.
*)
  DMUS_PLAYMODE_FIXEDTOCHORD      = DMUS_PLAYMODE_CHORD_ROOT;
  {$EXTERNALSYM DMUS_PLAYMODE_FIXEDTOCHORD}
(* In Pedalpoint, the key root is used and the notes only track the intervals in
   the scale. The chord root and intervals are completely ignored. This is useful
   for melodic lines that play relative to the key root.
*)
  DMUS_PLAYMODE_PEDALPOINT        = (DMUS_PLAYMODE_KEY_ROOT or DMUS_PLAYMODE_SCALE_INTERVALS);
  {$EXTERNALSYM DMUS_PLAYMODE_PEDALPOINT}
(* In the Melodic mode, the chord root is used but the notes only track the intervals in
   the scale. The key root and chord intervals are completely ignored. This is useful
   for melodic lines that play relative to the chord root.
*)
  DMUS_PLAYMODE_MELODIC           = (DMUS_PLAYMODE_CHORD_ROOT or DMUS_PLAYMODE_SCALE_INTERVALS);
  {$EXTERNALSYM DMUS_PLAYMODE_MELODIC}
(* Normal chord mode is the prevalent playback mode.
   The notes track the intervals in the chord, which is based on the chord root.
   If there is a scale component to the MusicValue, the additional intervals
   are pulled from the scale and added.
   If the chord does not have an interval to match the chord component of
   the MusicValue, the note is silent.
*)
  DMUS_PLAYMODE_NORMALCHORD       = (DMUS_PLAYMODE_CHORD_ROOT or DMUS_PLAYMODE_CHORD_INTERVALS);
  {$EXTERNALSYM DMUS_PLAYMODE_NORMALCHORD}
(* If it is desirable to play a note that is above the top of the chord, the
   always play mode (known as "purpleized" in a former life) finds a position
   for the note by using intervals from the scale. Essentially, this mode is
   a combination of the Normal and Melodic playback modes, where a failure
   in Normal causes a second try in Melodic mode.
*)
  DMUS_PLAYMODE_ALWAYSPLAY        = (DMUS_PLAYMODE_MELODIC or DMUS_PLAYMODE_NORMALCHORD);
  {$EXTERNALSYM DMUS_PLAYMODE_ALWAYSPLAY}

(* These playmodes are new for dx8. *)
(* In PedalpointChord, the key root is used and the notes only track the intervals in
   the chord. The chord root and scale intervals are completely ignored. This is useful
   for chordal lines that play relative to the key root.
*)
  DMUS_PLAYMODE_PEDALPOINTCHORD   = (DMUS_PLAYMODE_KEY_ROOT or DMUS_PLAYMODE_CHORD_INTERVALS);
  {$EXTERNALSYM DMUS_PLAYMODE_PEDALPOINTCHORD}

(* For completeness, here's a mode that tries for pedalpointchord, but if it fails
   uses scale intervals
*)
  DMUS_PLAYMODE_PEDALPOINTALWAYS  = (DMUS_PLAYMODE_PEDALPOINT or DMUS_PLAYMODE_PEDALPOINTCHORD);
  {$EXTERNALSYM DMUS_PLAYMODE_PEDALPOINTALWAYS}


  (*  Legacy names for modes... *)
  DMUS_PLAYMODE_PURPLEIZED        = DMUS_PLAYMODE_ALWAYSPLAY;
  {$EXTERNALSYM DMUS_PLAYMODE_PURPLEIZED}
  DMUS_PLAYMODE_SCALE_ROOT        = DMUS_PLAYMODE_KEY_ROOT;
  {$EXTERNALSYM DMUS_PLAYMODE_SCALE_ROOT}
  DMUS_PLAYMODE_FIXEDTOSCALE      = DMUS_PLAYMODE_FIXEDTOKEY;
  {$EXTERNALSYM DMUS_PLAYMODE_FIXEDTOSCALE}

const
  DMUS_TEMPO_MAX          = 1000;
  {$EXTERNALSYM DMUS_TEMPO_MAX}
  DMUS_TEMPO_MIN          = 1;
  {$EXTERNALSYM DMUS_TEMPO_MIN}

  DMUS_MASTERTEMPO_MAX    = 100.0;
  {$EXTERNALSYM DMUS_MASTERTEMPO_MAX}
  DMUS_MASTERTEMPO_MIN    = 0.01;
  {$EXTERNALSYM DMUS_MASTERTEMPO_MIN}

const
  DMUS_CURVE_RESET = 1;              (* When set, the nResetValue must be sent when the
                                        time is reached or an invalidate occurs because
                                        of a transition. If not set, the curve stays
                                        permanently stuck at the new value. *)
  {$EXTERNALSYM DMUS_CURVE_RESET}
  DMUS_CURVE_START_FROM_CURRENT = 2; (* Ignore Start, start the curve at the current value.
                                        This only works for volume, expression, and pitchbend. *)
  {$EXTERNALSYM DMUS_CURVE_START_FROM_CURRENT}


  (* Curve shapes *)
  DMUS_CURVES_LINEAR  = 0;
  {$EXTERNALSYM DMUS_CURVES_LINEAR}
  DMUS_CURVES_INSTANT = 1;
  {$EXTERNALSYM DMUS_CURVES_INSTANT}
  DMUS_CURVES_EXP     = 2;
  {$EXTERNALSYM DMUS_CURVES_EXP}
  DMUS_CURVES_LOG     = 3;
  {$EXTERNALSYM DMUS_CURVES_LOG}
  DMUS_CURVES_SINE    = 4;
  {$EXTERNALSYM DMUS_CURVES_SINE}

  (* curve types *)
  DMUS_CURVET_PBCURVE      = $03;   // Pitch bend curve.
  {$EXTERNALSYM DMUS_CURVET_PBCURVE}
  DMUS_CURVET_CCCURVE      = $04;   // Control change curve.
  {$EXTERNALSYM DMUS_CURVET_CCCURVE}
  DMUS_CURVET_MATCURVE     = $05;   // Mono aftertouch curve.
  {$EXTERNALSYM DMUS_CURVET_MATCURVE}
  DMUS_CURVET_PATCURVE     = $06;   // Poly aftertouch curve.
  {$EXTERNALSYM DMUS_CURVET_PATCURVE}
  DMUS_CURVET_RPNCURVE     = $07;   // RPN curve with curve type in wParamType.
  {$EXTERNALSYM DMUS_CURVET_RPNCURVE}
  DMUS_CURVET_NRPNCURVE    = $08;   // NRPN curve with curve type in wParamType.
  {$EXTERNALSYM DMUS_CURVET_NRPNCURVE}

const
(* notification type values *)
  (* The following correspond to GUID_NOTIFICATION_SEGMENT *)
  DMUS_NOTIFICATION_SEGSTART       = 0;
  {$EXTERNALSYM DMUS_NOTIFICATION_SEGSTART}
  DMUS_NOTIFICATION_SEGEND         = 1;
  {$EXTERNALSYM DMUS_NOTIFICATION_SEGEND}
  DMUS_NOTIFICATION_SEGALMOSTEND   = 2;
  {$EXTERNALSYM DMUS_NOTIFICATION_SEGALMOSTEND}
  DMUS_NOTIFICATION_SEGLOOP        = 3;
  {$EXTERNALSYM DMUS_NOTIFICATION_SEGLOOP}
  DMUS_NOTIFICATION_SEGABORT       = 4;
  {$EXTERNALSYM DMUS_NOTIFICATION_SEGABORT}
  (* The following correspond to GUID_NOTIFICATION_PERFORMANCE *)
  DMUS_NOTIFICATION_MUSICSTARTED   = 0;
  {$EXTERNALSYM DMUS_NOTIFICATION_MUSICSTARTED}
  DMUS_NOTIFICATION_MUSICSTOPPED   = 1;
  {$EXTERNALSYM DMUS_NOTIFICATION_MUSICSTOPPED}
  DMUS_NOTIFICATION_MUSICALMOSTEND = 2;
  {$EXTERNALSYM DMUS_NOTIFICATION_MUSICALMOSTEND}
  (* The following corresponds to GUID_NOTIFICATION_MEASUREANDBEAT *)
  DMUS_NOTIFICATION_MEASUREBEAT    = 0;
  {$EXTERNALSYM DMUS_NOTIFICATION_MEASUREBEAT}
  (* The following corresponds to GUID_NOTIFICATION_CHORD *)
  DMUS_NOTIFICATION_CHORD          = 0;
  {$EXTERNALSYM DMUS_NOTIFICATION_CHORD}
  (* The following correspond to GUID_NOTIFICATION_COMMAND *)
  DMUS_NOTIFICATION_GROOVE         = 0;
  {$EXTERNALSYM DMUS_NOTIFICATION_GROOVE}
  DMUS_NOTIFICATION_EMBELLISHMENT  = 1;
  {$EXTERNALSYM DMUS_NOTIFICATION_EMBELLISHMENT}
  (* The following corresponds to GUID_NOTIFICATION_RECOMPOSE *)
  DMUS_NOTIFICATION_RECOMPOSE          = 0;
  {$EXTERNALSYM DMUS_NOTIFICATION_RECOMPOSE}

const
  DMUS_WAVEF_OFF           = 1;       // If wave is playing and this is the off message.
  {$EXTERNALSYM DMUS_WAVEF_OFF}
  DMUS_WAVEF_STREAMING     = 2;       // If wave is streaming.
  {$EXTERNALSYM DMUS_WAVEF_STREAMING}
  DMUS_WAVEF_NOINVALIDATE  = 4;       // Don't invalidate this wave.
  {$EXTERNALSYM DMUS_WAVEF_NOINVALIDATE}
  DMUS_WAVEF_NOPREROLL     = 8;       // Don't preroll any wave data.
  {$EXTERNALSYM DMUS_WAVEF_NOPREROLL}
  DMUS_WAVEF_IGNORELOOPS   = $20;     // Ignore segment looping.
  {$EXTERNALSYM DMUS_WAVEF_IGNORELOOPS}

const
  DMUS_MAX_NAME           = 64;         (* Maximum object name length. *)
  {$EXTERNALSYM DMUS_MAX_NAME}
  DMUS_MAX_CATEGORY       = 64;         (* Maximum object category name length. *)
  {$EXTERNALSYM DMUS_MAX_CATEGORY}
  DMUS_MAX_FILENAME       = MAX_PATH;
  {$EXTERNALSYM DMUS_MAX_FILENAME}

type
  PDMusVersion = ^TDMusVersion;
  _DMUS_VERSION = record
    dwVersionMS: DWORD;
    dwVersionLS: DWORD;
  end;
  {$EXTERNALSYM _DMUS_VERSION}
  DMUS_VERSION = _DMUS_VERSION;
  {$EXTERNALSYM DMUS_VERSION}
  TDMusVersion = _DMUS_VERSION;

  // Time Signature structure, used by IDirectMusicStyle
  // Also used as a parameter for GetParam() and SetParam
  PDMusTimeSignature = ^TDMusTimeSignature;
  _DMUS_TIMESIGNATURE = record
    mtTime: TMusicTime;
    bBeatsPerMeasure: Byte;       (* beats per measure (top of time sig) *)
    bBeat: Byte;                  (* what note receives the beat (bottom of time sig.) *)
                                  (* we can assume that 0 means 256th note *)
    wGridsPerBeat: Word;          (* grids per beat *)
  end;
  {$EXTERNALSYM _DMUS_TIMESIGNATURE}
  DMUS_TIMESIGNATURE = _DMUS_TIMESIGNATURE;
  {$EXTERNALSYM DMUS_TIMESIGNATURE}
  TDMusTimeSignature = _DMUS_TIMESIGNATURE;

  PDMusValidStartParam = ^TDMusValidStartParam;
  _DMUS_VALID_START_PARAM = record
    mtTime: TMUSICTIME;                     (* Time of the first legal start
                                               point after (or including) the requested time.
                                               This is a returned value.
                                               Time format is the relative offset from requested time. *)
  end;
  {$EXTERNALSYM _DMUS_VALID_START_PARAM}
  DMUS_VALID_START_PARAM = _DMUS_VALID_START_PARAM;
  {$EXTERNALSYM DMUS_VALID_START_PARAM}
  TDMusValidStartParam = _DMUS_VALID_START_PARAM;

  PDMusPlayMarkerParam = ^TDMusPlayMarkerParam;
  _DMUS_PLAY_MARKER_PARAM = record
    mtTime: TMusicTime;                     (* Time of the first legal segment play
                                               marker before (or including) the requested time.
                                               This is a returned value.
                                               Time format is the relative offset from requested time. *)
  end;
  {$EXTERNALSYM _DMUS_PLAY_MARKER_PARAM}
  DMUS_PLAY_MARKER_PARAM = _DMUS_PLAY_MARKER_PARAM;
  {$EXTERNALSYM DMUS_PLAY_MARKER_PARAM}
  TDMusPlayMarkerParam = _DMUS_PLAY_MARKER_PARAM;

//      The DMUSOBJECTDESC structure is used to communicate everything you could
//      possibly use to describe a DirectMusic object.

  PDMusObjectDesc = ^TDMusObjectDesc;
  _DMUS_OBJECTDESC = record
    dwSize: DWORD;                 (* Size of this structure. *)
    dwValidData: DWORD;            (* Flags indicating which fields below are valid. *)
    guidObject: TGUID;             (* Unique ID for this object. *)
    guidClass: TGUID;              (* GUID for the class of object. *)
    ftDate: TFileTime;             (* Last edited date of object. *)
    vVersion: TDMusVersion;        (* Version. *)
    wszName: array[0..DMUS_MAX_NAME-1] of WideChar; (* Name of object. *)
    wszCategory: array[0..DMUS_MAX_CATEGORY-1] of WideChar; (* Category for object (optional). *)
    wszFileName: array[0..DMUS_MAX_FILENAME-1] of WideChar; (* File path. *)
    llMemLength: LONGLONG;         (* Size of Memory data. *)
    pbMemData: PByte;              (* Memory pointer for data. *)
    pStream: IStream;              (* Stream with data. *)
  end;
  {$EXTERNALSYM _DMUS_OBJECTDESC}
  DMUS_OBJECTDESC = _DMUS_OBJECTDESC;
  {$EXTERNALSYM DMUS_OBJECTDESC}
  TDMusObjectDesc = _DMUS_OBJECTDESC;

//      Flags for dwValidData. When set, a flag indicates that the
//      corresponding field in DMUSOBJECTDESC holds valid data.

const
  DMUS_OBJ_OBJECT         = (1 shl 0);     (* Object GUID is valid. *)
  {$EXTERNALSYM DMUS_OBJ_OBJECT}
  DMUS_OBJ_CLASS          = (1 shl 1);     (* Class GUID is valid. *)
  {$EXTERNALSYM DMUS_OBJ_CLASS}
  DMUS_OBJ_NAME           = (1 shl 2);     (* Name is valid. *)
  {$EXTERNALSYM DMUS_OBJ_NAME}
  DMUS_OBJ_CATEGORY       = (1 shl 3);     (* Category is valid. *)
  {$EXTERNALSYM DMUS_OBJ_CATEGORY}
  DMUS_OBJ_FILENAME       = (1 shl 4);     (* File path is valid. *)
  {$EXTERNALSYM DMUS_OBJ_FILENAME}
  DMUS_OBJ_FULLPATH       = (1 shl 5);     (* Path is full path. *)
  {$EXTERNALSYM DMUS_OBJ_FULLPATH}
  DMUS_OBJ_URL            = (1 shl 6);     (* Path is URL. *)
  {$EXTERNALSYM DMUS_OBJ_URL}
  DMUS_OBJ_VERSION        = (1 shl 7);     (* Version is valid. *)
  {$EXTERNALSYM DMUS_OBJ_VERSION}
  DMUS_OBJ_DATE           = (1 shl 8);     (* Date is valid. *)
  {$EXTERNALSYM DMUS_OBJ_DATE}
  DMUS_OBJ_LOADED         = (1 shl 9);     (* Object is currently loaded in memory. *)
  {$EXTERNALSYM DMUS_OBJ_LOADED}
  DMUS_OBJ_MEMORY         = (1 shl 10);    (* Object is pointed to by pbMemData. *)
  {$EXTERNALSYM DMUS_OBJ_MEMORY}
  DMUS_OBJ_STREAM         = (1 shl 11);    (* Object is stored in pStream. *)
  {$EXTERNALSYM DMUS_OBJ_STREAM}

type
(*      The DMUS_SCRIPT_ERRORINFO structure describes an error that occurred in a script.
        It is returned by methods in IDirectMusicScript. *)
  PDMusScriptErrorInfo = ^TDMusScriptErrorInfo;
  _DMUS_SCRIPT_ERRORINFO = record
    dwSize: DWORD; (* Size of this structure. *)
    hr: HRESULT;
    ulLineNumber: Cardinal;
    ichCharPosition: Longint;
    wszSourceFile: array[0..DMUS_MAX_FILENAME-1] of WideChar;
    wszSourceComponent: array[0..DMUS_MAX_FILENAME-1] of WideChar;
    wszDescription: array[0..DMUS_MAX_FILENAME-1] of WideChar;
    wszSourceLineText: array[0..DMUS_MAX_FILENAME-1] of WideChar;
  end;
  {$EXTERNALSYM _DMUS_SCRIPT_ERRORINFO}
  DMUS_SCRIPT_ERRORINFO = _DMUS_SCRIPT_ERRORINFO;
  {$EXTERNALSYM DMUS_SCRIPT_ERRORINFO}
  TDMusScriptErrorInfo = _DMUS_SCRIPT_ERRORINFO;

(*  Track configuration flags, used with IDirectMusicSegment8::SetTrackConfig() *)

const
  DMUS_TRACKCONFIG_OVERRIDE_ALL           = 1;	  (* This track should get parameters from this segment before controlling and primary tracks. *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_OVERRIDE_ALL}
  DMUS_TRACKCONFIG_OVERRIDE_PRIMARY       = 2;	  (* This track should get parameters from this segment before the primary segment tracks. *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_OVERRIDE_PRIMARY}
  DMUS_TRACKCONFIG_FALLBACK               = 4;  	  (* This track should get parameters from this segment if the primary and controlling segments don't succeed. *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_FALLBACK}
  DMUS_TRACKCONFIG_CONTROL_ENABLED        = 8;     (* GetParam() enabled for this track. *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_CONTROL_ENABLED}
  DMUS_TRACKCONFIG_PLAY_ENABLED           = $10;  (* Play() enabled for this track. *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_PLAY_ENABLED}
  DMUS_TRACKCONFIG_NOTIFICATION_ENABLED   = $20;  (* Notifications enabled for this track. *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_NOTIFICATION_ENABLED}
  DMUS_TRACKCONFIG_PLAY_CLOCKTIME         = $40;  (* This track plays in clock time, not music time. *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_PLAY_CLOCKTIME}
  DMUS_TRACKCONFIG_PLAY_COMPOSE 	        = $80;  (* This track should regenerate data each time it starts playing. *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_PLAY_COMPOSE}
  DMUS_TRACKCONFIG_LOOP_COMPOSE           = $100; (* This track should regenerate data each time it repeats. *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_LOOP_COMPOSE}
  DMUS_TRACKCONFIG_COMPOSING              = $200; (* This track is used to compose other tracks. *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_COMPOSING}
  DMUS_TRACKCONFIG_CONTROL_PLAY           = $10000; (* This track, when played in a controlling segment, overrides playback of primary segment tracks. *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_CONTROL_PLAY}
  DMUS_TRACKCONFIG_CONTROL_NOTIFICATION   = $20000; (* This track, when played in a controlling segment, overrides notification of primary segment tracks. *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_CONTROL_NOTIFICATION}
(* Additional track config flags for composing transitions *)
  DMUS_TRACKCONFIG_TRANS1_FROMSEGSTART    = $400;  (* Get track info from start of From segment *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_TRANS1_FROMSEGSTART}
  DMUS_TRACKCONFIG_TRANS1_FROMSEGCURRENT  = $800;  (* Get track info from current place in From segment *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_TRANS1_FROMSEGCURRENT}
  DMUS_TRACKCONFIG_TRANS1_TOSEGSTART      = $1000; (* Get track info from start of To segment *)
  {$EXTERNALSYM DMUS_TRACKCONFIG_TRANS1_TOSEGSTART}
  DMUS_TRACKCONFIG_DEFAULT    = (DMUS_TRACKCONFIG_CONTROL_ENABLED or DMUS_TRACKCONFIG_PLAY_ENABLED or DMUS_TRACKCONFIG_NOTIFICATION_ENABLED);
  {$EXTERNALSYM DMUS_TRACKCONFIG_DEFAULT}

type
  // Get/SetParam structs for commands
  // PARAM structures, used by GetParam() and SetParam()
  PDMusCommandParam = ^TDMusCommandParam;
  _DMUS_COMMAND_PARAM = record
    bCommand: Byte;
    bGrooveLevel: Byte;
    bGrooveRange: Byte;
    bRepeatMode: Byte;
  end;
  {$EXTERNALSYM _DMUS_COMMAND_PARAM}
  DMUS_COMMAND_PARAM = _DMUS_COMMAND_PARAM;
  {$EXTERNALSYM DMUS_COMMAND_PARAM}
  TDMusCommandParam = _DMUS_COMMAND_PARAM;

  PDMusCommandParam2 = ^TDMusCommandParam2;
  _DMUS_COMMAND_PARAM_2 = record
    mtTime: TMusicTime;
    bCommand: Byte;
    bGrooveLevel: Byte;
    bGrooveRange: Byte;
    bRepeatMode: Byte;
  end;
  {$EXTERNALSYM _DMUS_COMMAND_PARAM_2}
  DMUS_COMMAND_PARAM_2 = _DMUS_COMMAND_PARAM_2;
  {$EXTERNALSYM DMUS_COMMAND_PARAM_2}
  TDMusCommandParam2 = _DMUS_COMMAND_PARAM_2;

const
  DMUSB_LOADED    = (1 shl 0);        (* Set when band has been loaded *)
  {$EXTERNALSYM DMUSB_LOADED}
  DMUSB_DEFAULT   = (1 shl 1);        (* Set when band is default band for a style *)
  {$EXTERNALSYM DMUSB_DEFAULT}

  
type
  IDirectMusicTrack = interface;
  IDirectMusicSegment = interface;
  IDirectMusicSegmentState = interface;
  IDirectMusicGraph = interface;
  IDirectMusicPerformance = interface;
  IDirectMusicTool = interface;
  IDirectMusicChordMap = interface;

  PIDirectMusicSegmentState = ^IDirectMusicSegmentState;


// Translator: Structure declarations below (until interface declaration) were
// moved here from above of header due to refereces to IDirectMusicTool and
// IDirectMusicGraph interfaces

{
//Translator: this '#define' will be used later is several places
//#define DMUS_PMSG_PART
    dwSize: DWORD;
    rtTime: TReferenceTime;    (* real time (in 100 nanosecond increments) *)
    mtTime: TMusicTime;        (* music time *)
    dwFlags: DWORD;            (* various bits (see DMUS_PMSGF_FLAGS enumeration) *)
    dwPChannel: DWORD;         (* Performance Channel. The Performance can *)
                               (* use this to determine the port/channel. *)
    dwVirtualTrackID: DWORD;   (* virtual track ID *)
    pTool: IDirectMusicTool;   (* tool interface pointer *)
    pGraph: IDirectMusicGraph; (* tool graph interface pointer *)
    dwType: DWORD;             (* PMSG type (see DMUS_PMSGT_TYPES defines) *)
    dwVoiceID: DWORD;          (* unique voice id which allows synthesizers to *)
                               (* identify a specific event. For DirectX 6.0, *)
                               (* this field should always be 0. *)
    dwGroupID: DWORD;          (* Track group id *)
    punkUser: IUnknown;        (* user com pointer, auto released upon PMSG free *)
}

(* every DMUS_PMSG is based off of this structure. The Performance needs
   to access these members consistently in every PMSG that goes through it. *)
  PDMusPMsg = ^TDMusPMsg;
  _DMUS_PMSG = record
    (* begin DMUS_PMSG_PART *)
    dwSize: DWORD;
    rtTime: TReferenceTime;    (* real time (in 100 nanosecond increments) *)
    mtTime: TMusicTime;        (* music time *)
    dwFlags: DWORD;            (* various bits (see DMUS_PMSGF_FLAGS enumeration) *)
    dwPChannel: DWORD;         (* Performance Channel. The Performance can *)
                               (* use this to determine the port/channel. *)
    dwVirtualTrackID: DWORD;   (* virtual track ID *)
    pTool: IDirectMusicTool;   (* tool interface pointer *)
    pGraph: IDirectMusicGraph; (* tool graph interface pointer *)
    dwType: DWORD;             (* PMSG type (see DMUS_PMSGT_TYPES defines) *)
    dwVoiceID: DWORD;          (* unique voice id which allows synthesizers to *)
                               (* identify a specific event. For DirectX 6.0, *)
                               (* this field should always be 0. *)
    dwGroupID: DWORD;          (* Track group id *)
    punkUser: IUnknown;        (* user com pointer, auto released upon PMSG free *)
    (* end DMUS_PMSG_PART *)
  end;
  {$EXTERNALSYM _DMUS_PMSG}
  DMUS_PMSG = _DMUS_PMSG;
  {$EXTERNALSYM DMUS_PMSG}
  TDMusPMsg = _DMUS_PMSG;

  (* DMUS_NOTE_PMSG *)
  PDMusNotePMsg = ^TDMusNotePMsg;
  _DMUS_NOTE_PMSG = record
    (* begin DMUS_PMSG_PART *)
    dwSize: DWORD;
    rtTime: TReferenceTime;    // real time (in 100 nanosecond increments)
    mtTime: TMusicTime;        // music time
    dwFlags: DWORD;            // various bits (see DMUS_PMSGF_FLAGS enumeration)
    dwPChannel: DWORD;         // Performance Channel. The Performance can
                               // use this to determine the port/channel.
    dwVirtualTrackID: DWORD;   // virtual track ID
    pTool: IDirectMusicTool;   // tool interface pointer
    pGraph: IDirectMusicGraph; // tool graph interface pointer
    dwType: DWORD;             // PMSG type (see DMUS_PMSGT_TYPES defines)
    dwVoiceID: DWORD;          // unique voice id which allows synthesizers to
                               // identify a specific event. For DirectX 6.0,
                               // this field should always be 0.
    dwGroupID: DWORD;          // Track group id
    punkUser: IUnknown;        // user com pointer, auto released upon PMSG free
    (* end DMUS_PMSG_PART *)

    mtDuration: TMusicTime;     // duration
    wMusicValue: Word;          // Description of note in chord and key.
    wMeasure: Word;             // Measure in which this note occurs
    nOffset: Smallint;              // Offset from grid at which this note occurs
    bBeat: Byte;                // Beat (in measure) at which this note occurs
    bGrid: Byte;                // Grid offset from beat at which this note occurs
    bVelocity: Byte;            // Note velocity
    bFlags: Byte;               // see DMUS_NOTEF_FLAGS
    bTimeRange: Byte;           // Range to randomize time.
    bDurRange: Byte;            // Range to randomize duration.
    bVelRange: Byte;            // Range to randomize velocity.
    bPlayModeFlags: Byte;       // Play mode
    bSubChordLevel: Byte;       // Which subchord level this note uses.
    bMidiValue: Byte;           // The MIDI note value, converted from wMusicValue
    cTranspose: Char;           // Transposition to add to midi note value after converted from wMusicValue.
  end;
  {$EXTERNALSYM _DMUS_NOTE_PMSG}
  DMUS_NOTE_PMSG = _DMUS_NOTE_PMSG;
  {$EXTERNALSYM DMUS_NOTE_PMSG}
  TDMusNotePMsg = _DMUS_NOTE_PMSG;

  (* DMUS_MIDI_PMSG *)
  PDMusMidiPMsg = ^TDMusMidiPMsg;
  _DMUS_MIDI_PMSG = record
    (* begin DMUS_PMSG_PART *)
    dwSize: DWORD;
    rtTime: TReferenceTime;    (* real time (in 100 nanosecond increments) *)
    mtTime: TMusicTime;        (* music time *)
    dwFlags: DWORD;            (* various bits (see DMUS_PMSGF_FLAGS enumeration) *)
    dwPChannel: DWORD;         (* Performance Channel. The Performance can *)
                               (* use this to determine the port/channel. *)
    dwVirtualTrackID: DWORD;   (* virtual track ID *)
    pTool: IDirectMusicTool;   (* tool interface pointer *)
    pGraph: IDirectMusicGraph; (* tool graph interface pointer *)
    dwType: DWORD;             (* PMSG type (see DMUS_PMSGT_TYPES defines) *)
    dwVoiceID: DWORD;          (* unique voice id which allows synthesizers to *)
                               (* identify a specific event. For DirectX 6.0, *)
                               (* this field should always be 0. *)
    dwGroupID: DWORD;          (* Track group id *)
    punkUser: IUnknown;        (* user com pointer, auto released upon PMSG free *)
    (* end DMUS_PMSG_PART *)

    bStatus: Byte;
    bByte1: Byte;
    bByte2: Byte;
    bPad: array[0..0] of Byte;
  end;
  {$EXTERNALSYM _DMUS_MIDI_PMSG}
  DMUS_MIDI_PMSG = _DMUS_MIDI_PMSG;
  {$EXTERNALSYM DMUS_MIDI_PMSG}
  TDMusMidiPMsg = _DMUS_MIDI_PMSG;

  (* DMUS_PATCH_PMSG *)
  PDMusPatchPMsg = ^TDMusPatchPMsg;
  _DMUS_PATCH_PMSG = record
    (* begin DMUS_PMSG_PART *)
    dwSize: DWORD;
    rtTime: TReferenceTime;    (* real time (in 100 nanosecond increments) *)
    mtTime: TMusicTime;        (* music time *)
    dwFlags: DWORD;            (* various bits (see DMUS_PMSGF_FLAGS enumeration) *)
    dwPChannel: DWORD;         (* Performance Channel. The Performance can *)
                               (* use this to determine the port/channel. *)
    dwVirtualTrackID: DWORD;   (* virtual track ID *)
    pTool: IDirectMusicTool;   (* tool interface pointer *)
    pGraph: IDirectMusicGraph; (* tool graph interface pointer *)
    dwType: DWORD;             (* PMSG type (see DMUS_PMSGT_TYPES defines) *)
    dwVoiceID: DWORD;          (* unique voice id which allows synthesizers to *)
                               (* identify a specific event. For DirectX 6.0, *)
                               (* this field should always be 0. *)
    dwGroupID: DWORD;          (* Track group id *)
    punkUser: IUnknown;        (* user com pointer, auto released upon PMSG free *)
    (* end DMUS_PMSG_PART *)

    byInstrument: Byte;
    byMSB: Byte;
    byLSB: Byte;
    byPad: array[0..0] of Byte;
  end;
  {$EXTERNALSYM _DMUS_PATCH_PMSG}
  DMUS_PATCH_PMSG = _DMUS_PATCH_PMSG;
  {$EXTERNALSYM DMUS_PATCH_PMSG}
  TDMusPatchPMsg = _DMUS_PATCH_PMSG;

  (* DMUS_TRANSPOSE_PMSG *)
  PDMusTransposePMsg = ^TDMusTransposePMsg;
  _DMUS_TRANSPOSE_PMSG = record
    (* begin DMUS_PMSG_PART *)
    dwSize: DWORD;
    rtTime: TReferenceTime;    (* real time (in 100 nanosecond increments) *)
    mtTime: TMusicTime;        (* music time *)
    dwFlags: DWORD;            (* various bits (see DMUS_PMSGF_FLAGS enumeration) *)
    dwPChannel: DWORD;         (* Performance Channel. The Performance can *)
                               (* use this to determine the port/channel. *)
    dwVirtualTrackID: DWORD;   (* virtual track ID *)
    pTool: IDirectMusicTool;   (* tool interface pointer *)
    pGraph: IDirectMusicGraph; (* tool graph interface pointer *) 
    dwType: DWORD;             (* PMSG type (see DMUS_PMSGT_TYPES defines) *)
    dwVoiceID: DWORD;          (* unique voice id which allows synthesizers to *)
                               (* identify a specific event. For DirectX 6.0, *)
                               (* this field should always be 0. *)
    dwGroupID: DWORD;          (* Track group id *)
    punkUser: IUnknown;        (* user com pointer, auto released upon PMSG free *)
    (* end DMUS_PMSG_PART *)

    nTranspose: Smallint;
    (* Following exists only under DX8 and on (check dwFlags for DMUS_PMSGF_DX8) *)
    wMergeIndex: Word;     (* Allows multiple parameters to be merged (pitchbend, volume, and expression.)*)
  end;
  {$EXTERNALSYM _DMUS_TRANSPOSE_PMSG}
  DMUS_TRANSPOSE_PMSG = _DMUS_TRANSPOSE_PMSG;
  {$EXTERNALSYM DMUS_TRANSPOSE_PMSG}
  TDMusTransposePMsg = _DMUS_TRANSPOSE_PMSG;

  (* DMUS_CHANNEL_PRIORITY_PMSG *)
  PDMusChannelPriorityPMsg = ^TDMusChannelPriorityPMsg;
  _DMUS_CHANNEL_PRIORITY_PMSG = record
    (* begin DMUS_PMSG_PART *)
    dwSize: DWORD;
    rtTime: TReferenceTime;    (* real time (in 100 nanosecond increments) *)
    mtTime: TMusicTime;        (* music time *)
    dwFlags: DWORD;            (* various bits (see DMUS_PMSGF_FLAGS enumeration) *)
    dwPChannel: DWORD;         (* Performance Channel. The Performance can *)
                               (* use this to determine the port/channel. *)
    dwVirtualTrackID: DWORD;   (* virtual track ID *)
    pTool: IDirectMusicTool;   (* tool interface pointer *)
    pGraph: IDirectMusicGraph; (* tool graph interface pointer *)
    dwType: DWORD;             (* PMSG type (see DMUS_PMSGT_TYPES defines) *)
    dwVoiceID: DWORD;          (* unique voice id which allows synthesizers to *)
                               (* identify a specific event. For DirectX 6.0, *)
                               (* this field should always be 0. *)
    dwGroupID: DWORD;          (* Track group id *)
    punkUser: IUnknown;        (* user com pointer, auto released upon PMSG free *)
    (* end DMUS_PMSG_PART *)

    dwChannelPriority:   DWORD;
  end;
  {$EXTERNALSYM _DMUS_CHANNEL_PRIORITY_PMSG}
  DMUS_CHANNEL_PRIORITY_PMSG = _DMUS_CHANNEL_PRIORITY_PMSG;
  {$EXTERNALSYM DMUS_CHANNEL_PRIORITY_PMSG}
  TDMusChannelPriorityPMsg = _DMUS_CHANNEL_PRIORITY_PMSG;

  (* DMUS_TEMPO_PMSG *)
  PDMusTempoPMsg = ^TDMusTempoPMsg;
  _DMUS_TEMPO_PMSG = record
    (* begin DMUS_PMSG_PART *)
    dwSize: DWORD;
    rtTime: TReferenceTime;    (* real time (in 100 nanosecond increments) *)
    mtTime: TMusicTime;        (* music time *)
    dwFlags: DWORD;            (* various bits (see DMUS_PMSGF_FLAGS enumeration) *)
    dwPChannel: DWORD;         (* Performance Channel. The Performance can *)
                               (* use this to determine the port/channel. *)
    dwVirtualTrackID: DWORD;   (* virtual track ID *)
    pTool: IDirectMusicTool;   (* tool interface pointer *)
    pGraph: IDirectMusicGraph; (* tool graph interface pointer *)
    dwType: DWORD;             (* PMSG type (see DMUS_PMSGT_TYPES defines) *)
    dwVoiceID: DWORD;          (* unique voice id which allows synthesizers to *)
                               (* identify a specific event. For DirectX 6.0, *)
                               (* this field should always be 0. *)
    dwGroupID: DWORD;          (* Track group id *)
    punkUser: IUnknown;        (* user com pointer, auto released upon PMSG free *)
    (* end DMUS_PMSG_PART *)

    dblTempo: Double;                       (* the tempo *)
  end;
  {$EXTERNALSYM _DMUS_TEMPO_PMSG}
  DMUS_TEMPO_PMSG = _DMUS_TEMPO_PMSG;
  {$EXTERNALSYM DMUS_TEMPO_PMSG}
  TDMusTempoPMsg = _DMUS_TEMPO_PMSG;

  (* DMUS_SYSEX_PMSG *)
  PDMusSysexPMsg = ^TDMusSysexPMsg;
  _DMUS_SYSEX_PMSG = record
    (* begin DMUS_PMSG_PART *)
    dwSize: DWORD;
    rtTime: TReferenceTime;    (* real time (in 100 nanosecond increments) *)
    mtTime: TMusicTime;        (* music time *)
    dwFlags: DWORD;            (* various bits (see DMUS_PMSGF_FLAGS enumeration) *)
    dwPChannel: DWORD;         (* Performance Channel. The Performance can *)
                               (* use this to determine the port/channel. *)
    dwVirtualTrackID: DWORD;   (* virtual track ID *)
    pTool: IDirectMusicTool;   (* tool interface pointer *)
    pGraph: IDirectMusicGraph; (* tool graph interface pointer *) 
    dwType: DWORD;             (* PMSG type (see DMUS_PMSGT_TYPES defines) *)
    dwVoiceID: DWORD;          (* unique voice id which allows synthesizers to *)
                               (* identify a specific event. For DirectX 6.0, *)
                               (* this field should always be 0. *)
    dwGroupID: DWORD;          (* Track group id *)
    punkUser: IUnknown;        (* user com pointer, auto released upon PMSG free *)
    (* end DMUS_PMSG_PART *)

    dwLen: DWORD;                 // length of the data
    abData: array[0..0] of Byte;  // array of data, length equal to dwLen
  end;
  {$EXTERNALSYM _DMUS_SYSEX_PMSG}
  DMUS_SYSEX_PMSG = _DMUS_SYSEX_PMSG;
  {$EXTERNALSYM DMUS_SYSEX_PMSG}
  TDMusSysexPMsg = _DMUS_SYSEX_PMSG;

  (* DMUS_CURVE_PMSG *)
  PDMusCurvePMsg = ^TDMusCurvePMsg;
  _DMUS_CURVE_PMSG = record
    (* begin DMUS_PMSG_PART *)
    dwSize: DWORD;
    rtTime: TReferenceTime;    (* real time (in 100 nanosecond increments) *)
    mtTime: TMusicTime;        (* music time *)
    dwFlags: DWORD;            (* various bits (see DMUS_PMSGF_FLAGS enumeration) *)
    dwPChannel: DWORD;         (* Performance Channel. The Performance can *)
                               (* use this to determine the port/channel. *)
    dwVirtualTrackID: DWORD;   (* virtual track ID *)
    pTool: IDirectMusicTool;   (* tool interface pointer *)
    pGraph: IDirectMusicGraph; (* tool graph interface pointer *) 
    dwType: DWORD;             (* PMSG type (see DMUS_PMSGT_TYPES defines) *)
    dwVoiceID: DWORD;          (* unique voice id which allows synthesizers to *)
                               (* identify a specific event. For DirectX 6.0, *)
                               (* this field should always be 0. *)
    dwGroupID: DWORD;          (* Track group id *)
    punkUser: IUnknown;        (* user com pointer, auto released upon PMSG free *)
    (* end DMUS_PMSG_PART *)

    mtDuration: TMusicTime;      // how long this curve lasts
    mtOriginalStart: TMusicTime; // must be set to either zero when this PMSG is created or to the original mtTime of the curve
    mtResetDuration: TMusicTime; (* how long after the curve is finished to allow a flush or
                                        invalidation to reset to the reset value, nResetValue *)
    nStartValue: Smallint;       // curve's start value
    nEndValue: Smallint;         // curve's end value
    nResetValue: Smallint;       (* curve's reset value, set when a flush or invalidation
                                        occurs within mtDuration + mtResetDuration *)
    wMeasure: Word;              // Measure in which this curve occurs
    nOffset: Smallint;           // Offset from grid at which this curve occurs
    bBeat: Byte;                 // Beat (in measure) at which this curve occurs
    bGrid: Byte;                 // Grid offset from beat at which this curve occurs
    bType: Byte;                 // type of curve
    bCurveShape: Byte;           // shape of curve
    bCCData: Byte;               // CC# if this is a control change type
    bFlags: Byte;                // Curve reset and start from current value flags.
    // Following exists only under DX8 and on (check dwFlags for DMUS_PMSGF_DX8)
    wParamType: Word;            // RPN or NRPN parameter number.
    wMergeIndex: Word;           // Allows multiple parameters to be merged (pitchbend, volume, and expression.)*/
  end;
  {$EXTERNALSYM _DMUS_CURVE_PMSG}
  DMUS_CURVE_PMSG = _DMUS_CURVE_PMSG;
  {$EXTERNALSYM DMUS_CURVE_PMSG}
  TDMusCurvePMsg = _DMUS_CURVE_PMSG;

  enumDMUS_CURVE_FLAGS = DWORD;
  DMUS_CURVE_FLAGS = enumDMUS_CURVE_FLAGS;
  {$EXTERNALSYM DMUS_CURVE_FLAGS}
  TDMusCurveFlags = DMUS_CURVE_FLAGS;
  PDMusCurveFlags = ^TDMusCurveFlags;

  (* DMUS_TIMESIG_PMSG *)
  PDMusTimeSigPMsg = ^TDMusTimesigPMsg;
  _DMUS_TIMESIG_PMSG = record
    (* begin DMUS_PMSG_PART *)
    dwSize: DWORD;
    rtTime: TReferenceTime;    (* real time (in 100 nanosecond increments) *)
    mtTime: TMusicTime;        (* music time *)
    dwFlags: DWORD;            (* various bits (see DMUS_PMSGF_FLAGS enumeration) *)
    dwPChannel: DWORD;         (* Performance Channel. The Performance can *)
                               (* use this to determine the port/channel. *)
    dwVirtualTrackID: DWORD;   (* virtual track ID *)
    pTool: IDirectMusicTool;   (* tool interface pointer *)
    pGraph: IDirectMusicGraph; (* tool graph interface pointer *)
    dwType: DWORD;             (* PMSG type (see DMUS_PMSGT_TYPES defines) *)
    dwVoiceID: DWORD;          (* unique voice id which allows synthesizers to *)
                               (* identify a specific event. For DirectX 6.0, *)
                               (* this field should always be 0. *)
    dwGroupID: DWORD;          (* Track group id *)
    punkUser: IUnknown;        (* user com pointer, auto released upon PMSG free *)
    (* end DMUS_PMSG_PART *)

    // Time signatures define how many beats per measure, which note receives
    // the beat, and the grid resolution.
    bBeatsPerMeasure: Byte;       // beats per measure (top of time sig)
    bBeat: Byte;                  // what note receives the beat (bottom of time sig.)
                                  // we can assume that 0 means 256th note
    wGridsPerBeat: Word;          // grids per beat
  end;
  {$EXTERNALSYM _DMUS_TIMESIG_PMSG}
  DMUS_TIMESIG_PMSG = _DMUS_TIMESIG_PMSG;
  {$EXTERNALSYM DMUS_TIMESIG_PMSG}
  TDMusTimeSigPMsg = _DMUS_TIMESIG_PMSG;

  (* DMUS_NOTIFICATION_PMSG *)
  PDMusNotificationPMsg = ^TDMusNotificationPMsg;
  _DMUS_NOTIFICATION_PMSG = record
    (* begin DMUS_PMSG_PART *)
    dwSize: DWORD;
    rtTime: TReferenceTime;    (* real time (in 100 nanosecond increments) *)
    mtTime: TMusicTime;        (* music time *)
    dwFlags: DWORD;            (* various bits (see DMUS_PMSGF_FLAGS enumeration) *)
    dwPChannel: DWORD;         (* Performance Channel. The Performance can *)
                               (* use this to determine the port/channel. *)
    dwVirtualTrackID: DWORD;   (* virtual track ID *)
    pTool: IDirectMusicTool;   (* tool interface pointer *)
    pGraph: IDirectMusicGraph; (* tool graph interface pointer *)
    dwType: DWORD;             (* PMSG type (see DMUS_PMSGT_TYPES defines) *)
    dwVoiceID: DWORD;          (* unique voice id which allows synthesizers to *)
                               (* identify a specific event. For DirectX 6.0, *)
                               (* this field should always be 0. *)
    dwGroupID: DWORD;          (* Track group id *)
    punkUser: IUnknown;        (* user com pointer, auto released upon PMSG free *)
    (* end DMUS_PMSG_PART *)

    guidNotificationType: TGUID;
    dwNotificationOption: DWORD;
    dwField1: DWORD;
    dwField2: DWORD;
  end;
  {$EXTERNALSYM _DMUS_NOTIFICATION_PMSG}
  DMUS_NOTIFICATION_PMSG = _DMUS_NOTIFICATION_PMSG;
  {$EXTERNALSYM DMUS_NOTIFICATION_PMSG}
  TDMusNotificationPMsg = _DMUS_NOTIFICATION_PMSG;

  (* DMUS_WAVE_PMSG *)
  PDMusWavePMsg = ^TDMusWavePMsg;
  _DMUS_WAVE_PMSG = record
    (* begin DMUS_PMSG_PART *)
    dwSize: DWORD;
    rtTime: TReferenceTime;    (* real time (in 100 nanosecond increments) *)
    mtTime: TMusicTime;        (* music time *)
    dwFlags: DWORD;            (* various bits (see DMUS_PMSGF_FLAGS enumeration) *)
    dwPChannel: DWORD;         (* Performance Channel. The Performance can *)
                               (* use this to determine the port/channel. *)
    dwVirtualTrackID: DWORD;   (* virtual track ID *)
    pTool: IDirectMusicTool;   (* tool interface pointer *)
    pGraph: IDirectMusicGraph; (* tool graph interface pointer *)
    dwType: DWORD;             (* PMSG type (see DMUS_PMSGT_TYPES defines) *)
    dwVoiceID: DWORD;          (* unique voice id which allows synthesizers to *)
                               (* identify a specific event. For DirectX 6.0, *)
                               (* this field should always be 0. *)
    dwGroupID: DWORD;          (* Track group id *)
    punkUser: IUnknown;        (* user com pointer, auto released upon PMSG free *)
    (* end DMUS_PMSG_PART *)

    rtStartOffset: TReferenceTime;   (* How far into the wave to start, in reference time units only. *)
    rtDuration: TReferenceTime;      (* Duration of the wave, in either reference time or music time. *)
    lOffset: Longint;                (* Offset from actual time to logical time, in music or ref time. *)
    lVolume: Longint;                (* Initial volume, in 100ths of a dB. *)
    lPitch: Longint;                 (* Initial pitch, in 100ths of a semitone. *)
    bFlags: Byte;                    (* Flags, including DMUS_WAVEF_OFF... *)
  end;
  {$EXTERNALSYM _DMUS_WAVE_PMSG}
  DMUS_WAVE_PMSG = _DMUS_WAVE_PMSG;
  {$EXTERNALSYM DMUS_WAVE_PMSG}
  TDMusWavePMsg = _DMUS_WAVE_PMSG;

  (* DMUS_LYRIC_PMSG *)
  PDMusLyricPMsg = ^TDMusLyricPMsg;
  _DMUS_LYRIC_PMSG = record
    (* begin DMUS_PMSG_PART *)
    dwSize: DWORD;
    rtTime: TReferenceTime;    (* real time (in 100 nanosecond increments) *)
    mtTime: TMusicTime;        (* music time *)
    dwFlags: DWORD;            (* various bits (see DMUS_PMSGF_FLAGS enumeration) *)
    dwPChannel: DWORD;         (* Performance Channel. The Performance can *)
                               (* use this to determine the port/channel. *)
    dwVirtualTrackID: DWORD;   (* virtual track ID *)
    pTool: IDirectMusicTool;   (* tool interface pointer *)
    pGraph: IDirectMusicGraph; (* tool graph interface pointer *)
    dwType: DWORD;             (* PMSG type (see DMUS_PMSGT_TYPES defines) *)
    dwVoiceID: DWORD;          (* unique voice id which allows synthesizers to *)
                               (* identify a specific event. For DirectX 6.0, *)
                               (* this field should always be 0. *)
    dwGroupID: DWORD;          (* Track group id *)
    punkUser: IUnknown;        (* user com pointer, auto released upon PMSG free *)
    (* end DMUS_PMSG_PART *)

    wszString: array[0..0] of WideChar;      (* null-terminated Unicode lyric string (structure is actually larger than size 1) *)
  end;
  {$EXTERNALSYM _DMUS_LYRIC_PMSG}
  DMUS_LYRIC_PMSG = _DMUS_LYRIC_PMSG;
  {$EXTERNALSYM DMUS_LYRIC_PMSG}
  TDMusLyricPMsg = _DMUS_LYRIC_PMSG;



(*)///////////////////////////////////////////////////////////////////
// IDirectMusicBand *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicBand);'}
  {$EXTERNALSYM IDirectMusicBand}
  IDirectMusicBand = interface(IUnknown)
    ['{d2ac28c0-b39b-11d1-8704-00600893b1bd}']
    (* IDirectMusicBand *)
    function CreateSegment(out ppSegment: IDirectMusicSegment): HResult; stdcall;
    function Download(pPerformance: IDirectMusicPerformance): HResult; stdcall;
    function Unload(pPerformance: IDirectMusicPerformance): HResult; stdcall;
  end;

  IDirectMusicBand8 = IDirectMusicBand;
  {$NODEFINE IDirectMusicBand8}
  {$HPPEMIT 'typedef _di_IDirectMusicBand _di_IDirectMusicBand8;'}

(*////////////////////////////////////////////////////////////////////
// IDirectMusicObject *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicObject);'}
  {$EXTERNALSYM IDirectMusicObject}
  IDirectMusicObject = interface(IUnknown)
    ['{d2ac28b5-b39b-11d1-8704-00600893b1bd}']
    (* IDirectMusicObject *)
    function GetDescriptor(out pDesc: TDMusObjectDesc): HResult; stdcall;
    function SetDescriptor(const pDesc: TDMusObjectDesc): HResult; stdcall;
    function ParseDescriptor(const pStream: Pointer; out pDesc: TDMusObjectDesc): HResult; stdcall;
  end;

  IDirectMusicObject8 = IDirectMusicObject;
  {$NODEFINE IDirectMusicObject8}
  {$HPPEMIT 'typedef _di_IDirectMusicObject _di_IDirectMusicObject8;'}

(*////////////////////////////////////////////////////////////////////
// IDirectMusicLoader *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicLoader);'}
  {$EXTERNALSYM IDirectMusicLoader}
  IDirectMusicLoader = interface(IUnknown)
    ['{2ffaaca2-5dca-11d2-afa6-00aa0024d8b6}']
    (* IDirectMusicLoader *)
    function GetObject(const pDesc: TDMusObjectDesc; const riid : TGUID;
      out ppv): HResult; stdcall;
    function SetObject(const pDesc: TDMusObjectDesc): HResult; stdcall;
    function SetSearchDirectory(const rguidClass: TGUID; pwzPath: PWideChar;
      fClear: BOOL): HResult; stdcall;
    function ScanDirectory(const rguidClass: TGUID; pwzFileExtension,
      pwzScanFileName: PWideChar): HResult; stdcall;
    function CacheObject(pObject: IDirectMusicObject): HResult; stdcall;
    function ReleaseObject(pObject: IDirectMusicObject): HResult; stdcall;
    function ClearCache(const rguidClass: TGUID): HResult; stdcall;
    function EnableCache(const rguidClass: TGUID; fEnable: BOOL): HResult; stdcall;
    function EnumObject(const rguidClass: TGUID; dwIndex: DWORD;
      const pDesc: TDMusObjectDesc): HResult; stdcall;
  end;

(*////////////////////////////////////////////////////////////////////
// IDirectMusicLoader8 *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicLoader8);'}
  {$EXTERNALSYM IDirectMusicLoader8}
  IDirectMusicLoader8 = interface(IDirectMusicLoader)
    ['{19e7c08c-0a44-4e6a-a116-595a7cd5de8c}']
    (* IDirectMusicLoader8 *)
    function CollectGarbage: HResult; stdcall;
    function ReleaseObjectByUnknown(pObject: IUnknown): HResult; stdcall;
    function LoadObjectFromFile(const rguidClassID: TGUID; const iidInterfaceID: TGUID;
      pwzFilePath: PWideChar; out ppObject): HResult; stdcall;
  end;

(*  Stream object supports IDirectMusicGetLoader interface to access loader while file parsing. *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicGetLoader);'}
  {$EXTERNALSYM IDirectMusicGetLoader}
  IDirectMusicGetLoader = interface(IUnknown)
    ['{68a04844-d13d-11d1-afa6-00aa0024d8b6}']
    (* IDirectMusicGetLoader *)
    function GetLoader(out ppLoader: IDirectMusicLoader): HResult; stdcall;
  end;

  IDirectMusicGetLoader8 = IDirectMusicGetLoader;
  {$NODEFINE IDirectMusicGetLoader8}
  {$HPPEMIT 'typedef _di_IDirectMusicGetLoader _di_IDirectMusicGetLoader8;'}

(*////////////////////////////////////////////////////////////////////
// IDirectMusicSegment *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicSegment);'}
  {$EXTERNALSYM IDirectMusicSegment}
  IDirectMusicSegment = interface(IUnknown)
    ['{f96029a2-4282-11d2-8717-00600893b1bd}']
    (*  IDirectMusicSegment *)
    function GetLength(out pmtLength: TMusicTime): HResult; stdcall;
    function SetLength(mtLength: TMusicTime): HResult; stdcall;
    function GetRepeats(out pdwRepeats: DWORD): HResult; stdcall;
    function SetRepeats(dwRepeats: DWORD): HResult; stdcall;
    function GetDefaultResolution(out pdwResolution: DWORD): HResult; stdcall;
    function SetDefaultResolution(dwResolution: DWORD): HResult; stdcall;
    function GetTrack(const rguidType: TGUID; dwGroupBits, dwIndex: DWORD;
      out ppTrack: IDirectMusicTrack): HResult; stdcall;
    function GetTrackGroup(pTrack: IDirectMusicTrack; out pdwGroupBits: DWORD): HResult; stdcall;
    function InsertTrack(pTrack: IDirectMusicTrack; dwGroupBits: DWORD): HResult; stdcall;
    function RemoveTrack(pTrack: IDirectMusicTrack): HResult; stdcall;
    function InitPlay(out ppSegState: IDirectMusicSegmentState;
      pPerformance: IDirectMusicPerformance; dwFlags: DWORD): HResult; stdcall;
    function GetGraph(out ppGraph: IDirectMusicGraph): HResult; stdcall;
    function SetGraph(pGraph: IDirectMusicGraph): HResult; stdcall;
    function AddNotificationType(const rguidNotificationType: TGUID): HResult; stdcall;
    function RemoveNotificationType(const rguidNotificationType: TGUID): HResult; stdcall;
    function GetParam(const rguidType: TGUID; dwGroupBits, dwIndex: DWORD;
      mtTime: TMusicTime; out pmtNext: TMusicTime; pParam: Pointer): HResult; stdcall;
    function SetParam(const rguidType: TGUID; dwGroupBits, dwIndex: DWORD;
      mtTime: TMusicTime; pParam: Pointer): HResult; stdcall;
    function Clone(mtStart: TMusicTime; mtEnd: TMusicTime;
      out ppSegment: IDirectMusicSegment): HResult; stdcall;
    function SetStartPoint(mtStart: TMusicTime): HResult; stdcall;
    function GetStartPoint(out pmtStart: TMusicTime): HResult; stdcall;
    function SetLoopPoints(mtStart: TMusicTime; mtEnd: TMusicTime): HResult; stdcall;
    function GetLoopPoints(out pmtStart, pmtEnd: TMusicTime): HResult; stdcall;
    function SetPChannelsUsed(dwNumPChannels: DWORD; var paPChannels: DWORD): HResult; stdcall;
  end;

(*////////////////////////////////////////////////////////////////////
// IDirectMusicSegment8 *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicSegment8);'}
  {$EXTERNALSYM IDirectMusicSegment8}
  IDirectMusicSegment8 = interface(IDirectMusicSegment)
    ['{c6784488-41a3-418f-aa15-b35093ba42d4}']
    (*  IDirectMusicSegment8 *)
    function SetTrackConfig(const rguidTrackClassID: TGUID;
      dwGroupBits, dwIndex, dwFlagsOn, dwFlagsOff: DWORD): HResult; stdcall;
    function GetAudioPathConfig(out ppAudioPathConfig: IUnknown): HResult; stdcall;
    function Compose(mtTime: TMusicTime; pFromSegment, pToSegment: IDirectMusicSegment;
      out ppComposedSegment: IDirectMusicSegment): HResult; stdcall;
    function Download(pAudioPath: IUnknown): HResult; stdcall;
    function Unload(pAudioPath: IUnknown): HResult; stdcall;
  end;

(*/////////////////////////////////////////////////////////////////////
// IDirectMusicSegmentState *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicSegmentState);'}
  {$EXTERNALSYM IDirectMusicSegmentState}
  IDirectMusicSegmentState = interface(IUnknown)
    ['{a3afdcc7-d3ee-11d1-bc8d-00a0c922e6eb}']
    (*  IDirectMusicSegmentState *)
    function GetRepeats(out pdwRepeats: DWORD): HResult; stdcall;
    function GetSegment(out ppSegment: IDirectMusicSegment): HResult; stdcall;
    function GetStartTime(out pmtStart: TMusicTime): HResult; stdcall;
    function GetSeek(out pmtSeek: TMusicTime): HResult; stdcall;
    function GetStartPoint(out pmtStart: TMusicTime): HResult; stdcall;
  end;

(*/////////////////////////////////////////////////////////////////////
// IDirectMusicSegmentState8 *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicSegmentState8);'}
  {$EXTERNALSYM IDirectMusicSegmentState8}
  IDirectMusicSegmentState8 = interface(IDirectMusicSegmentState)
    ['{a50e4730-0ae4-48a7-9839-bc04bfe07772}']
    (* IDirectMusicSegmentState8 *)
    function SetTrackConfig(
      const rguidTrackClassID: TGUID;        // Class ID of the type of track on which to set the configuration flags.
      dwGroupBits,                           // Group bits.
      dwIndex,                               // Nth track (or DMUS_SEG_ALLTRACKS) that matches class id and group id.
      dwFlagsOn,                             // DMUS_TRACKCONFIG_ flags to enable.
      dwFlagsOff: DWORD): HResult; stdcall;  // DMUS_TRACKCONFIG_ flags to disable.
    function GetObjectInPath(
      dwPChannel,                            // PChannel to search.
      dwStage,                               // Which stage in the path.
      dwBuffer: DWORD;                       // Which buffer to address, if more than one.
      const guidObject: TGUID;               // ClassID of object.
      dwIndex: DWORD;                        // Which object of that class.
      const iidInterface: TGUID;             // Requested COM interface.
      out ppObject): HResult; stdcall;       // Pointer to interface.
  end;

(*////////////////////////////////////////////////////////////////////
// IDirectMusicAudioPath *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicAudioPath);'}
  {$EXTERNALSYM IDirectMusicAudioPath}
  IDirectMusicAudioPath = interface(IUnknown)
    ['{c87631f5-23be-4986-8836-05832fcc48f9}']
    (*  IDirectMusicAudioPath *)
    function GetObjectInPath(
      dwPChannel,                         // PChannel to search.
      dwStage,                            // Which stage in the path.
      dwBuffer: DWORD;                    // Which buffer to address, if more than one.
      const guidObject: TGUID;            // ClassID of object.
      dwIndex: DWORD;                     // Which object of that class.
      const iidInterface: TGUID;          // Requested COM interface.
      out ppObject): HResult; stdcall;    // Pointer to interface.
    function Activate(fActivate: BOOL): HResult; stdcall; // True to activate, False to deactivate.
    function SetVolume(lVolume: Longint;    // Gain, in 100ths of a dB. This must be negative (0 represents full volume.)
      dwDuration: DWORD): HResult; stdcall; // Duration of volume ramp in  milliseconds. Note that 0 is more efficient.
    function ConvertPChannel (dwPChannelIn: DWORD;   // Pchannel of source.
      var pdwPChannelOut: DWORD): HResult; stdcall;  // Equivalent pchannel on performance.
  end;

  IDirectMusicAudioPath8 = IDirectMusicAudioPath;
  {$NODEFINE IDirectMusicAudioPath8}
  {$HPPEMIT 'typedef _di_IDirectMusicAudioPath _di_IDirectMusicAudioPath8;'}

(*////////////////////////////////////////////////////////////////////
// IDirectMusicPerformance *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicPerformance);'}
  {$EXTERNALSYM IDirectMusicPerformance}
  IDirectMusicPerformance = interface(IUnknown)
    ['{07d43d03-6523-11d2-871d-00600893b1bd}']
    (*  IDirectMusicPerformance *)
    function Init(var ppDirectMusic: IDirectMusic;
      pDirectSound: IDirectSound; hWnd: HWND): HResult; stdcall;
    function PlaySegment(pSegment: IDirectMusicSegment; dwFlags: DWORD;
      i64StartTime: LongLong; ppSegmentState: PIDirectMusicSegmentState): HResult; stdcall;
    function Stop(pSegment: IDirectMusicSegment; pSegmentState: IDirectMusicSegmentState;
      mtTime: TMusicTime; dwFlags: DWORD): HResult; stdcall;
    function GetSegmentState(out ppSegmentState: IDirectMusicSegmentState;
      mtTime: TMusicTime): HResult; stdcall;
    function SetPrepareTime(dwMilliSeconds: DWORD): HResult; stdcall;
    function GetPrepareTime(out pdwMilliSeconds: DWORD): HResult; stdcall;
    function SetBumperLength(dwMilliSeconds: DWORD): HResult; stdcall;
    function GetBumperLength(out pdwMilliSeconds: DWORD): HResult; stdcall;
    function SendPMsg(pPMSG: PDMusPMsg): HResult; stdcall;
    function MusicToReferenceTime(mtTime: TMusicTime; out prtTime: TReferenceTime): HResult; stdcall;
    function ReferenceToMusicTime(rtTime: TReferenceTime; out pmtTime: TMusicTime): HResult; stdcall;
    function IsPlaying(pSegment: IDirectMusicSegment; pSegState: IDirectMusicSegmentState): HResult; stdcall;
    function GetTime(prtNow: PReference_Time; pmtNow: PMusicTime): HResult; stdcall;
    function AllocPMsg(cb: ULONG; out ppPMSG: PDMusPMsg): HResult; stdcall;
    function FreePMsg(pPMSG: PDMusPMsg): HResult; stdcall;
    function GetGraph(out ppGraph: IDirectMusicGraph): HResult; stdcall;
    function SetGraph(pGraph: IDirectMusicGraph): HResult; stdcall;
    function SetNotificationHandle(hNotification: THANDLE; rtMinimum: TReferenceTime): HResult; stdcall;
    function GetNotificationPMsg(out ppNotificationPMsg: PDMusNotificationPMsg): HResult; stdcall;
    function AddNotificationType(const rguidNotificationType: TGUID): HResult; stdcall;
    function RemoveNotificationType(const rguidNotificationType: TGUID): HResult; stdcall;
    function AddPort(pPort: IDirectMusicPort): HResult; stdcall; 
    function RemovePort(pPort: IDirectMusicPort): HResult; stdcall;
    function AssignPChannelBlock(dwBlockNum: DWORD; pPort: IDirectMusicPort;
      dwGroup: DWORD): HResult; stdcall;
    function AssignPChannel(dwPChannel: DWORD; pPort: IDirectMusicPort;
      dwGroup, dwMChannel: DWORD): HResult; stdcall;
    function PChannelInfo(dwPChannel: DWORD; out ppPort: IDirectMusicPort;
      out pdwGroup, pdwMChannel: DWORD ): HResult; stdcall;
    function DownloadInstrument(pInst: IDirectMusicInstrument; dwPChannel: DWORD;
      out ppDownInst: IDirectMusicDownloadedInstrument; var pNoteRanges: TDMusNoteRange;
      dwNumNoteRanges: DWORD; out ppPort: IDirectMusicPort;
      out pdwGroup, pdwMChannel: DWORD): HResult; stdcall;
    function Invalidate(mtTime: TMusicTime; dwFlags: DWORD): HResult; stdcall;
    function GetParam(const rguidType: TGUID; dwGroupBits, dwIndex: DWORD;
      mtTime: TMusicTime; out pmtNext: TMusicTime; pParam: Pointer): HResult; stdcall;
    function SetParam(const rguidType: TGUID; dwGroupBits, dwIndex: DWORD;
      mtTime: TMusicTime; pParam: Pointer): HResult; stdcall;
    function GetGlobalParam(const rguidType: TGUID; pParam: Pointer;
      dwSize: DWORD): HResult; stdcall;
    function SetGlobalParam(const rguidType: TGUID; pParam: Pointer;
      dwSize: DWORD): HResult; stdcall;
    function GetLatencyTime(out prtTime: TReferenceTime): HResult; stdcall;
    function GetQueueTime(out prtTime: TReferenceTime): HResult; stdcall;
    function AdjustTime(rtAmount: TReferenceTime): HResult; stdcall;
    function CloseDown : HResult; stdcall;
    function GetResolvedTime(rtTime: TReferenceTime; out prtResolved: TReferenceTime;
      dwTimeResolveFlags: DWORD): HResult; stdcall;
    function MIDIToMusic(bMIDIValue: Byte; const pChord: TDMusChordKey;
      bPlayMode, bChordLevel: Byte; out pwMusicValue: Word): HResult; stdcall;
    function MusicToMIDI(wMusicValue: Word; const pChord: TDMusChordKey;
      bPlayMode, bChordLevel: Byte; out pbMIDIValue: Byte): HResult; stdcall;
    function TimeToRhythm(mtTime: TMusicTime; const pTimeSig: TDMusTimeSignature;
      out pwMeasure: Word; out pbBeat, pbGrid: Byte;
      out pnOffset: SmallInt): HResult; stdcall;
    function RhythmToTime(wMeasure: Word; bBeat, bGrid: Byte; nOffset: Smallint;
      const pTimeSig: TDMusTimeSignature; out pmtTime: TMusicTime): HResult; stdcall;
  end;

(*////////////////////////////////////////////////////////////////////
// IDirectMusicPerformance8 *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicPerformance8);'}
  {$EXTERNALSYM IDirectMusicPerformance8}
  IDirectMusicPerformance8 = interface(IDirectMusicPerformance)
    ['{679c4137-c62e-4147-b2b4-9d569acb254c}']
    (*  IDirectMusicPerformance8 *)
    function InitAudio(
      ppDirectMusic: PIDirectMusic;                  // Optional DirectMusic pointer.
      ppDirectSound: PIDirectSound;                  // Optional DirectSound pointer.
      hWnd: hWnd;                                    // HWND for DirectSound.
      dwDefaultPathType,                             // Requested default audio path type, also optional.
      dwPChannelCount,                               // Number of PChannels, if default audio path to be created.
      dwFlags: DWORD;                                // DMUS_AUDIOF flags, if no pParams structure.
      pParams: PDMUSAudioParams): HResult; stdcall;  // Optional initialization structure, defining required voices, buffers, etc. 
    function PlaySegmentEx(
      pSource: IUnknown;                             // Segment to play.
      pwzSegmentName: PWideChar;                     // Not supported in DX8.
      pTransition: IUnknown;                         // Optional template segment to compose transition with.
      dwFlags: DWORD;                                // DMUS_SEGF_ flags.
      i64StartTime: Int64;                           // Time to start playback.
      ppSegmentState: PIDirectMusicSegmentState;     // Returned Segment State.
      pFrom,                                         // Optional segmentstate or audiopath to replace.
      pAudioPath: IUnknown): HResult; stdcall;       // Optional audioPath to play on.
    function StopEx(pObjectToStop: IUnknown;         // Segstate, AudioPath, or Segment.
      i64StopTime: int64; dwFlags: DWORD): HResult; stdcall;
    function ClonePMsg(pSourcePMSG: TDMusPMsg;
      var ppCopyPMSG: TDMusPMsg): HResult; stdcall;
    function CreateAudioPath(
      pSourceConfig: IUnknown;                       // Source configuration, from AudioPathConfig file. 
      fActivate: BOOL;                               // TRUE to activate on creation. 
      out ppNewPath: IDirectMusicAudioPath): HResult; stdcall; // Returns created audiopath. 
    function CreateStandardAudioPath(
      dwType,                                        // Type of path to create. 
      dwPChannelCount: DWORD;                        // How many PChannels to allocate for it. 
      fActivate: BOOL;                               // TRUE to activate on creation. 
      out ppNewPath: IDirectMusicAudioPath): HResult; stdcall; // Returns created audiopath. 
    function SetDefaultAudioPath(pAudioPath: IDirectMusicAudioPath): HResult; stdcall;
    function GetDefaultAudioPath(out ppAudioPath: IDirectMusicAudioPath): HResult; stdcall;
    function GetParamEx(
      const rguidType: TGUID;                        // GetParam command ID. 
      dwTrackID,                                     // Virtual track ID of caller. 
      dwGroupBits,                                   // Group bits of caller. 
      dwIndex: DWORD;                                // Index to Nth parameter. 
      mtTime,                                        // Time of requested parameter. 
      pmtNext: TMusicTime;                           // Returned delta to next parameter. 
      pParam: Pointer): HResult; stdcall;            // Data structure to fill with parameter. 
  end;

(*////////////////////////////////////////////////////////////////////
// IDirectMusicGraph *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicGraph);'}
  {$EXTERNALSYM IDirectMusicGraph}
  IDirectMusicGraph = interface(IUnknown)
    ['{2befc277-5497-11d2-bccb-00a0c922e6eb}']
    (*  IDirectMusicGraph *)
    function StampPMsg(var pPMSG: TDMusPMsg): HResult; stdcall;
    function InsertTool(pTool: IDirectMusicTool; var pdwPChannels: DWORD;
      cPChannels: DWORD; lIndex: LongInt): HResult; stdcall;
    function GetTool(dwIndex: DWORD; out ppTool: IDirectMusicTool): HResult; stdcall;
    function RemoveTool(pTool: IDirectMusicTool): HResult; stdcall;
  end;

  IDirectMusicGraph8 = IDirectMusicGraph;
  {$NODEFINE IDirectMusicGraph8}
  {$HPPEMIT 'typedef _di_IDirectMusicGraph _di_IDirectMusicGraph8;'}

(*////////////////////////////////////////////////////////////////////
// IDirectMusicTool *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicTool);'}
  {$EXTERNALSYM IDirectMusicTool}
  IDirectMusicTool = interface(IUnknown)
    ['{d2ac28ba-b39b-11d1-8704-00600893b1bd}']
    (*  IDirectMusicTool *)
    function Init(pGraph: IDirectMusicGraph): HResult; stdcall;
    function GetMsgDeliveryType(out pdwDeliveryType: DWORD): HResult; stdcall;
    function GetMediaTypeArraySize(out pdwNumElements: DWORD): HResult; stdcall;
    function GetMediaTypes(out padwMediaTypes: PDWORD; dwNumElements: DWORD): HResult; stdcall;
    function ProcessPMsg(pPerf: IDirectMusicPerformance; pPMSG: PDMusPMsg): HResult; stdcall;
    function Flush(pPerf: IDirectMusicPerformance; const pPMSG: TDMusPMsg;
      rtTime: TReferenceTime): HResult; stdcall;
  end;

(*/////////////////////////////////////////////////////////////////////
// IDirectMusicStyle *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicStyle);'}
  {$EXTERNALSYM IDirectMusicStyle}
  IDirectMusicStyle = interface(IUnknown)
    ['{d2ac28bd-b39b-11d1-8704-00600893b1bd}']
    (*  IDirectMusicStyle *)
    function GetBand(pwszName: PWideChar; out ppBand: IDirectMusicBand): HResult; stdcall;
    function EnumBand(dwIndex: DWORD; pwszName: PWideChar): HResult; stdcall;
    function GetDefaultBand(out ppBand: IDirectMusicBand): HResult; stdcall;
    function EnumMotif(dwIndex: DWORD; pwszName: PWideChar): HResult; stdcall;
    function GetMotif(pwszName: PWideChar; out ppSegment: IDirectMusicSegment): HResult; stdcall;
    function GetDefaultChordMap(out ppChordMap: IDirectMusicChordMap): HResult; stdcall;
    function EnumChordMap(dwIndex: DWORD; pwszName: PWideChar): HResult; stdcall;
    function GetChordMap(pwszName: PWideChar; out ppChordMap: IDirectMusicChordMap): HResult; stdcall;
    function GetTimeSignature(out pTimeSig: TDMusTimeSignature): HResult; stdcall;
    function GetEmbellishmentLength(dwType, dwLevel: DWORD; out pdwMin, pdwMax: DWORD): HResult; stdcall;
    function GetTempo(out pTempo: Double): HResult; stdcall;
  end;

(*/////////////////////////////////////////////////////////////////////
// IDirectMusicStyle8 *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicStyle8);'}
  {$EXTERNALSYM IDirectMusicStyle8}
  IDirectMusicStyle8 = interface(IDirectMusicStyle)
    ['{fd24ad8a-a260-453d-bf50-6f9384f70985}']
    (*  IDirectMusicStyle8 *)
    function EnumPattern(dwIndex, dwPatternType: DWORD; pwszName: PWideChar): HResult; stdcall;
  end;

(*/////////////////////////////////////////////////////////////////////
// IDirectMusicChordMap *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicChordMap);'}
  {$EXTERNALSYM IDirectMusicChordMap}
  IDirectMusicChordMap = interface(IUnknown)
    ['{d2ac28be-b39b-11d1-8704-00600893b1bd}']
    (*  IDirectMusicChordMap *)
    function GetScale(out pdwScale: DWORD): HResult; stdcall;
  end;

  IDirectMusicChordMap8 = IDirectMusicChordMap;
  {$NODEFINE IDirectMusicChordMap8}
  {$HPPEMIT 'typedef _di_IDirectMusicChordMap _di_IDirectMusicChordMap8;'}

(*/////////////////////////////////////////////////////////////////////
// IDirectMusicComposer *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicComposer);'}
  {$EXTERNALSYM IDirectMusicComposer}
  IDirectMusicComposer = interface(IUnknown)
    ['{d2ac28bf-b39b-11d1-8704-00600893b1bd}']
    (*  IDirectMusicComposer *)
    function ComposeSegmentFromTemplate(pStyle: IDirectMusicStyle;
      pTempSeg: IDirectMusicSegment; wActivity: Word;
      pChordMap: IDirectMusicChordMap; out ppSectionSeg: IDirectMusicSegment): HResult; stdcall;
    function ComposeSegmentFromShape(pStyle: IDirectMusicStyle; wNumMeasures,
      wShape, wActivity: Word; fIntro: BOOL; fEnd: BOOL;
      pChordMap: IDirectMusicChordMap; out ppSectionSeg: IDirectMusicSegment): HResult; stdcall;
    function ComposeTransition(pFromSeg: IDirectMusicSegment; pToSeg: IDirectMusicSegment;
      mtTime: TMusicTime; wCommand: Word; dwFlags: DWORD; pChordMap: IDirectMusicChordMap;
      out ppSectionSeg: IDirectMusicSegment): HResult; stdcall;
    function AutoTransition(pPerformance: IDirectMusicPerformance;
      pToSeg: IDirectMusicSegment; wCommand: Word; dwFlags: DWORD;
      pChordMap: IDirectMusicChordMap; out ppTransSeg: IDirectMusicSegment;
      out ppToSegState: IDirectMusicSegmentState; out ppTransSegState: IDirectMusicSegmentState): HResult; stdcall;
    function ComposeTemplateFromShape(wNumMeasures: Word; wShape: Word; fIntro: BOOL;
      fEnd: BOOL; wEndLength: Word; out ppTempSeg:IDirectMusicSegment): HResult; stdcall;
    function ChangeChordMap(pSectionSeg: IDirectMusicSegment;
      fTrackScale: BOOL; pChordMap: IDirectMusicChordMap): HResult; stdcall;
  end;

  IDirectMusicComposer8 = IDirectMusicComposer;
  {$NODEFINE IDirectMusicComposer8}
  {$HPPEMIT 'typedef _di_IDirectMusicComposer _di_IDirectMusicComposer8;'}

(*/////////////////////////////////////////////////////////////////////
// IDirectMusicPatternTrack *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicPatternTrack);'}
  {$EXTERNALSYM IDirectMusicPatternTrack}
  IDirectMusicPatternTrack = interface(IUnknown)
    ['{51c22e10-b49f-46fc-bec2-e6288fb9ede6}']
    (*  IDirectMusicPatternTrack *)
    function CreateSegment(pStyle: IDirectMusicStyle;
      out ppSegment: IDirectMusicSegment): HResult; stdcall;
    function SetVariation(pSegState: IDirectMusicSegmentState;
      dwVariationFlags, dwPart: DWORD): HResult; stdcall;
    function SetPatternByName(pSegState: IDirectMusicSegmentState;
      wszName: PWideChar; pStyle: IDirectMusicStyle; dwPatternType: DWORD;
      var pdwLength: DWORD): HResult; stdcall;
  end;

  IDirectMusicPatternTrack8 = IDirectMusicPatternTrack;
  {$NODEFINE IDirectMusicPatternTrack8}
  {$HPPEMIT 'typedef _di_IDirectMusicPatternTrack _di_IDirectMusicPatternTrack8;'}

(*/////////////////////////////////////////////////////////////////////
// IDirectMusicScript *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicScript);'}
  {$EXTERNALSYM IDirectMusicScript}
  IDirectMusicScript = interface(IUnknown)
    ['{2252373a-5814-489b-8209-31fedebaf137}']
    (*  IDirectMusicScript *)
    function Init(pPerformance: IDirectMusicPerformance;
      pErrorInfo: PDMusScriptErrorInfo): HResult; stdcall;
    function CallRoutine(pwszRoutineName: PWideChar;
      pErrorInfo: PDMusScriptErrorInfo): HResult; stdcall;
    function SetVariableVariant(pwszVariableName: PWideChar; varValue: Variant;
      fSetRef: BOOL; pErrorInfo: PDMusScriptErrorInfo): HResult; stdcall;
    function GetVariableVariant(pwszVariableName: PWideChar; var pvarValue: Variant;
      pErrorInfo: PDMusScriptErrorInfo): HResult; stdcall;
    function SetVariableNumber(pwszVariableName: PWideChar; lValue: Longint;
      pErrorInfo: PDMusScriptErrorInfo): HResult; stdcall;
    function GetVariableNumber(pwszVariableName: PWideChar; var plValue: Longint;
      pErrorInfo: PDMusScriptErrorInfo): HResult; stdcall;
    function SetVariableObject(pwszVariableName: PWideChar; punkValue: IUnknown;
      pErrorInfo: PDMusScriptErrorInfo): HResult; stdcall;
    function GetVariableObject(pwszVariableName: PWideChar; const riid: TGUID;
      out ppv; pErrorInfo: PDMusScriptErrorInfo): HResult; stdcall;
    function EnumRoutine(dwIndex: DWORD; pwszName: PWideChar): HResult; stdcall;
    function EnumVariable(dwIndex: DWORD; pwszName: PWideChar): HResult; stdcall;
  end;

  IDirectMusicScript8 = IDirectMusicScript;
  {$NODEFINE IDirectMusicScript8}
  {$HPPEMIT 'typedef _di_IDirectMusicScript _di_IDirectMusicScript8;'}

(*/////////////////////////////////////////////////////////////////////
// IDirectMusicContainer *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicContainer);'}
  {$EXTERNALSYM IDirectMusicContainer}
  IDirectMusicContainer = interface(IUnknown)
    ['{9301e386-1f22-11d3-8226-d2fa76255d47}']
    (*  IDirectMusicContainer *)
    function EnumObject(const rguidClass: TGUID; dwIndex: DWORD;
      pDesc: PDMusObjectDesc; pwszAlias: PWideChar): HResult; stdcall;
  end;

  IDirectMusicContainer8 = IDirectMusicContainer;
  {$NODEFINE IDirectMusicContainer8}
  {$HPPEMIT 'typedef _di_IDirectMusicContainer _di_IDirectMusicContainer8;'}

(*////////////////////////////////////////////////////////////////////
// IDirectMusicTrack *)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicTrack);'}
  {$EXTERNALSYM IDirectMusicTrack}
  IDirectMusicTrack = interface(IUnknown)
    ['{f96029a1-4282-11d2-8717-00600893b1bd}']
    (*  IDirectMusicTrack *)
    function Init(pSegment: IDirectMusicSegment): HResult; stdcall;
    function InitPlay(pSegmentState: IDirectMusicSegmentState;
      pPerformance: IDirectMusicPerformance; out ppStateData: Pointer;
      dwVirtualTrackID, dwFlags: DWORD): HResult; stdcall;
    function EndPlay(pStateData: Pointer): HResult; stdcall;
    function Play(pStateData: Pointer; mtStart, mtEnd, mtOffset: TMusicTime;
      dwFlags: DWORD; pPerf: IDirectMusicPerformance;
      pSegSt: IDirectMusicSegmentState; dwVirtualID: DWORD): HResult; stdcall;
    function GetParam (const rguidType: TGUID; mtTime: TMusicTime; out pmtNext: TMusicTime;
      pParam: Pointer): HResult; stdcall;
    function SetParam(const rguidType: TGUID; mtTime: TMusicTime; pParam: Pointer): HResult; stdcall;
    function IsParamSupported(const rguidType: TGUID): HResult; stdcall;
    function AddNotificationType(const rguidNotificationType: TGUID): HResult; stdcall;
    function RemoveNotificationType(const rguidNotificationType: TGUID): HResult; stdcall;
    function Clone(mtStart: TMusicTime; mtEnd: TMusicTime; out ppTrack: IDirectMusicTrack): HResult; stdcall;
  end;


const
  (* CLSID's *)
  CLSID_DirectMusicPerformance: TGUID = '{d2ac2881-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicPerformance}
  CLSID_DirectMusicSegment: TGUID = '{d2ac2882-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicSegment}
  CLSID_DirectMusicSegmentState: TGUID = '{d2ac2883-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicSegmentState}
  CLSID_DirectMusicGraph: TGUID = '{d2ac2884-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicGraph}
  CLSID_DirectMusicStyle: TGUID = '{d2ac288a-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicStyle}
  CLSID_DirectMusicChordMap: TGUID = '{d2ac288f-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicChordMap}
  CLSID_DirectMusicComposer: TGUID = '{d2ac2890-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicComposer}
  CLSID_DirectMusicLoader: TGUID = '{d2ac2892-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicLoader}
  CLSID_DirectMusicBand: TGUID = '{79ba9e00-b6ee-11d1-86be-00c04fbf8fef}';
  {$EXTERNALSYM CLSID_DirectMusicBand}

  (* New CLSID's for DX8 *)
  CLSID_DirectMusicPatternTrack: TGUID = '{d2ac2897-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicPatternTrack}
  CLSID_DirectMusicScript: TGUID = '{810b5013-e88d-11d2-8bc1-00600893b1b6}'; (* {810B5013-E88D-11d2-8BC1-00600893B1B6} *)
  {$EXTERNALSYM CLSID_DirectMusicScript}
  CLSID_DirectMusicContainer: TGUID = '{9301e380-1f22-11d3-8226-d2fa76255d47}';
  {$EXTERNALSYM CLSID_DirectMusicContainer}
  CLSID_DirectSoundWave: TGUID = '{8a667154-f9cb-11d2-ad8a-0060b0575abc}';
  {$EXTERNALSYM CLSID_DirectSoundWave}
  CLSID_DirectMusicAudioPathConfig: TGUID = '{ee0b9ca0-a81e-11d3-9bd1-0080c7150a74}';
  {$EXTERNALSYM CLSID_DirectMusicAudioPathConfig}

  (* Special GUID for all object types. This is used by the loader. *)
  GUID_DirectMusicAllTypes: TGUID = '{d2ac2893-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_DirectMusicAllTypes}

  (* Notification guids *)
  GUID_NOTIFICATION_SEGMENT: TGUID = '{d2ac2899-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_NOTIFICATION_SEGMENT}
  GUID_NOTIFICATION_PERFORMANCE: TGUID = '{81f75bc5-4e5d-11d2-bcc7-00a0c922e6eb}';
  {$EXTERNALSYM GUID_NOTIFICATION_PERFORMANCE}
  GUID_NOTIFICATION_MEASUREANDBEAT: TGUID = '{d2ac289a-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_NOTIFICATION_MEASUREANDBEAT}
  GUID_NOTIFICATION_CHORD: TGUID = '{d2ac289b-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_NOTIFICATION_CHORD}
  GUID_NOTIFICATION_COMMAND: TGUID = '{d2ac289c-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_NOTIFICATION_COMMAND}
  GUID_NOTIFICATION_RECOMPOSE: TGUID = '{d348372b-945b-45ae-a522-450f125b84a5}';
  {$EXTERNALSYM GUID_NOTIFICATION_RECOMPOSE}

  (* Track param type guids *)
  (* Use to get/set a DMUS_COMMAND_PARAM param in the Command track *)
  GUID_CommandParam: TGUID = '{d2ac289d-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_CommandParam}

  (* Use to get a DMUS_COMMAND_PARAM_2 param in the Command track *)
  GUID_CommandParam2: TGUID = '{28f97ef7-9538-11d2-97a9-00c04fa36e58}';
  {$EXTERNALSYM GUID_CommandParam2}

  (* Use to get/set a DMUS_COMMAND_PARAM_2 param to be used as the command following all commands in
  the Command track (this information can't be saved) *)
  GUID_CommandParamNext: TGUID = '{472afe7a-281b-11d3-817d-00c04fa36e58}';
  {$EXTERNALSYM GUID_CommandParamNext}

  (* Use to get/set a DMUS_CHORD_PARAM param in the Chord track *)
  GUID_ChordParam: TGUID = '{d2ac289e-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_ChordParam}

  (* Use to get a DMUS_RHYTHM_PARAM param in the Chord track *)
  GUID_RhythmParam: TGUID = '{d2ac289f-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_RhythmParam}

  (* Use to get/set an IDirectMusicStyle param in the Style track *)
  GUID_IDirectMusicStyle: TGUID = '{d2ac28a1-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_IDirectMusicStyle}

  (* Use to get a DMUS_TIMESIGNATURE param in the Style and TimeSig tracks *)
  GUID_TimeSignature: TGUID = '{d2ac28a4-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_TimeSignature}

  (* Use to get/set a DMUS_TEMPO_PARAM param in the Tempo track *)
  GUID_TempoParam: TGUID = '{d2ac28a5-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_TempoParam}

  (* Use to get the next valid point in a segment at which it may start *)
  GUID_Valid_Start_Time: TGUID = '{7f6b1760-1fdb-11d3-8226-444553540000}';
  {$EXTERNALSYM GUID_Valid_Start_Time}

  (* Use to get the next point in the currently playing primary segment at which a new segment may start *)
  GUID_Play_Marker: TGUID = '{d8761a41-801a-11d3-9bd1-daf7e1c3d834}';
  {$EXTERNALSYM GUID_Play_Marker}

  (* Use to get (GetParam) or add (SetParam) bands in the Band track *)
  GUID_BandParam: TGUID = '{02bb1938-cb8b-11d2-8bb9-00600893b1b6}';
  {$EXTERNALSYM GUID_BandParam}

type
  _DMUS_BAND_PARAM = record
    mtTimePhysical:  MUSIC_TIME; // Note: If this is a clock-time track, then this field is interpreted in the track's internal time format, which is the number of milliseconds after the beginning of playback.
    pBand: IDirectMusicBand;
  end;
  {$EXTERNALSYM _DMUS_BAND_PARAM}
  DMUS_BAND_PARAM = _DMUS_BAND_PARAM;
  {$EXTERNALSYM DMUS_BAND_PARAM}
  TDMusBandParam = _DMUS_BAND_PARAM;
  PDMusBandParam = ^TDMusBandParam;

const
  (* Obsolete -- doesn't distinguish physical and logical time.  Use GUID_BandParam instead. *)
  GUID_IDirectMusicBand: TGUID = '{d2ac28ac-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_IDirectMusicBand}

  (* Use to get/set an IDirectMusicChordMap param in the ChordMap track *)
  GUID_IDirectMusicChordMap: TGUID = '{d2ac28ad-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_IDirectMusicChordMap}

  (* Use to get/set a DMUS_MUTE_PARAM param in the Mute track *)
  GUID_MuteParam: TGUID = '{d2ac28af-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_MuteParam}

  (* These guids are used in IDirectMusicSegment::SetParam to tell the band track to perform various actions.
     Some of these guids (where noted) also apply to wave tracks.
   *)
  (* Download bands/waves for the IDirectMusicSegment *)
  GUID_Download: TGUID = '{d2ac28a7-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_Download}

  (* Unload bands/waves for the IDirectMusicSegment *)
  GUID_Unload: TGUID = '{d2ac28a8-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_Unload}

  (* Connect segment's bands to an IDirectMusicCollection *)
  GUID_ConnectToDLSCollection: TGUID = '{1db1ae6b-e92e-11d1-a8c5-00c04fa3726e}';
  {$EXTERNALSYM GUID_ConnectToDLSCollection}

  (* Enable/disable autodownloading of bands/waves *)
  GUID_Enable_Auto_Download: TGUID = '{d2ac28a9-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_Enable_Auto_Download}
  GUID_Disable_Auto_Download: TGUID = '{d2ac28aa-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_Disable_Auto_Download}

  (* Clear all bands *)
  GUID_Clear_All_Bands: TGUID = '{d2ac28ab-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_Clear_All_Bands}

  (* Set segment to manage all program changes, bank selects, etc. for simple playback of a standard MIDI file *)
  GUID_StandardMIDIFile: TGUID = '{06621075-e92e-11d1-a8c5-00c04fa3726e}';
  {$EXTERNALSYM GUID_StandardMIDIFile}
  (* For compatibility with beta releases... *)
  GUID_IgnoreBankSelectForGM: TGUID = '{06621075-e92e-11d1-a8c5-00c04fa3726e}'; // = GUID_StandardMIDIFile;
  {$EXTERNALSYM GUID_IgnoreBankSelectForGM}

  (* Disable/enable param guids. Use these in SetParam calls to disable or enable sending
   * specific PMsg types.
   *)
  GUID_DisableTimeSig: TGUID = '{45fc707b-1db4-11d2-bcac-00a0c922e6eb}';
  {$EXTERNALSYM GUID_DisableTimeSig}
  GUID_EnableTimeSig: TGUID = '{45fc707c-1db4-11d2-bcac-00a0c922e6eb}';
  {$EXTERNALSYM GUID_EnableTimeSig}
  GUID_DisableTempo: TGUID = '{45fc707d-1db4-11d2-bcac-00a0c922e6eb}';
  {$EXTERNALSYM GUID_DisableTempo}
  GUID_EnableTempo: TGUID = '{45fc707e-1db4-11d2-bcac-00a0c922e6eb}';
  {$EXTERNALSYM GUID_EnableTempo}

  (* Used in SetParam calls for pattern-based tracks.  A nonzero value seeds the random number
  generator for variation selection; a value of zero reverts to the default behavior of
  getting the seed from the system clock.
  *)
  GUID_SeedVariations: TGUID = '{65b76fa5-ff37-11d2-814e-00c04fa36e58}';
  {$EXTERNALSYM GUID_SeedVariations}

  (* Used to get the variations currently in effect across PChannels *)
  GUID_Variations: TGUID = '{11f72cce-26e6-4ecd-af2e-d668e66707d8}';
  {$EXTERNALSYM GUID_Variations}

type
  PDMusVariationsParam = ^TDMusVariationsParam;
  _DMUS_VARIATIONS_PARAM = record
    dwPChannelsUsed: DWORD;  // number of PChannels in use
    padwPChannels: PDWORD;   // array of PChannels in use
    padwVariations: PDWORD;  // array of variations in effect for each PChannel
  end;
  {$EXTERNALSYM _DMUS_VARIATIONS_PARAM}
  DMUS_VARIATIONS_PARAM = _DMUS_VARIATIONS_PARAM;
  {$EXTERNALSYM DMUS_VARIATIONS_PARAM}
  TDMusVariationsParam = _DMUS_VARIATIONS_PARAM;

const  
  (* Download bands/waves for the IDirectMusicSegment, passed an IDirectMusicAudioPath instead of an IDirectMusicPerformance *)
  GUID_DownloadToAudioPath: TGUID = '{9f2c0341-c5c4-11d3-9bd1-444553540000}';
  {$EXTERNALSYM GUID_DownloadToAudioPath}

  (* Unload bands/waves for the IDirectMusicSegment, passed an IDirectMusicAudioPath instead of an IDirectMusicPerformance *)
  GUID_UnloadFromAudioPath: TGUID = '{9f2c0342-c5c4-11d3-9bd1-444553540000}';
  {$EXTERNALSYM GUID_UnloadFromAudioPath}


  (* Global data guids *)
  GUID_PerfMasterTempo: TGUID = '{d2ac28b0-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_PerfMasterTempo}
  GUID_PerfMasterVolume: TGUID = '{d2ac28b1-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_PerfMasterVolume}
  GUID_PerfMasterGrooveLevel: TGUID = '{d2ac28b2-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM GUID_PerfMasterGrooveLevel}
  GUID_PerfAutoDownload: TGUID = '{fb09565b-3631-11d2-bcb8-00a0c922e6eb}';
  {$EXTERNALSYM GUID_PerfAutoDownload}

  (* GUID for default GM/GS dls collection. *)
  GUID_DefaultGMCollection: TGUID = '{f17e8673-c3b4-11d1-870b-00600893b1bd}';
  {$EXTERNALSYM GUID_DefaultGMCollection}

  (* GUID to define default synth, placed in AudioPath configuration file. *)
  GUID_Synth_Default: TGUID = '{26bb9432-45fe-48d3-a375-2472c5e3e786}';
  {$EXTERNALSYM GUID_Synth_Default}

  (* GUIDs to define default buffer configurations to place in AudioPath configuration file. *)
  GUID_Buffer_Reverb: TGUID = '{186cc541-db29-11d3-9bd1-0080c7150a74}';
  {$EXTERNALSYM GUID_Buffer_Reverb}
  GUID_Buffer_EnvReverb: TGUID = '{186cc542-db29-11d3-9bd1-0080c7150a74}';
  {$EXTERNALSYM GUID_Buffer_EnvReverb}
  GUID_Buffer_Stereo: TGUID = '{186cc545-db29-11d3-9bd1-0080c7150a74}';
  {$EXTERNALSYM GUID_Buffer_Stereo}
  GUID_Buffer_3D_Dry: TGUID = '{186cc546-db29-11d3-9bd1-0080c7150a74}';
  {$EXTERNALSYM GUID_Buffer_3D_Dry}
  GUID_Buffer_Mono: TGUID = '{186cc547-db29-11d3-9bd1-0080c7150a74}';
  {$EXTERNALSYM GUID_Buffer_Mono}

type
  (* IID's *)
  IID_IDirectMusicLoader = IDirectMusicLoader;
  {$EXTERNALSYM IID_IDirectMusicLoader}
  IID_IDirectMusicGetLoader = IDirectMusicGetLoader;
  {$EXTERNALSYM IID_IDirectMusicGetLoader}
  IID_IDirectMusicObject = IDirectMusicObject;
  {$EXTERNALSYM IID_IDirectMusicObject}
  IID_IDirectMusicSegment = IDirectMusicSegment;
  {$EXTERNALSYM IID_IDirectMusicSegment}
  IID_IDirectMusicSegmentState = IDirectMusicSegmentState;
  {$EXTERNALSYM IID_IDirectMusicSegmentState}
  IID_IDirectMusicPerformance = IDirectMusicPerformance;
  {$EXTERNALSYM IID_IDirectMusicPerformance}
  IID_IDirectMusicGraph = IDirectMusicGraph;
  {$EXTERNALSYM IID_IDirectMusicGraph}
  IID_IDirectMusicStyle = IDirectMusicStyle;
  {$EXTERNALSYM IID_IDirectMusicStyle}
  IID_IDirectMusicChordMap = IDirectMusicChordMap;
  {$EXTERNALSYM IID_IDirectMusicChordMap}
  IID_IDirectMusicComposer = IDirectMusicComposer;
  {$EXTERNALSYM IID_IDirectMusicComposer}
  IID_IDirectMusicBand = IDirectMusicBand;
  {$EXTERNALSYM IID_IDirectMusicBand}

const
  (* Alternate interface IDs, available in DX7 release and after. *)
  IID_IDirectMusicPerformance2: TGUID = '{6fc2cae0-bc78-11d2-afa6-00aa0024d8b6}';
  {$EXTERNALSYM IID_IDirectMusicPerformance2}
  IID_IDirectMusicSegment2: TGUID = '{d38894d1-c052-11d2-872f-00600893b1bd}';
  {$EXTERNALSYM IID_IDirectMusicSegment2}

type
  (* Interface IDs for DX8 *)
  (* changed interfaces (GUID only) *)
  IID_IDirectMusicLoader8 = IDirectMusicLoader8;
  {$EXTERNALSYM IID_IDirectMusicLoader8}
  IID_IDirectMusicPerformance8 = IDirectMusicPerformance8;
  {$EXTERNALSYM IID_IDirectMusicPerformance8}
  IID_IDirectMusicSegment8 = IDirectMusicSegment8;
  {$EXTERNALSYM IID_IDirectMusicSegment8}
  IID_IDirectMusicSegmentState8 = IDirectMusicSegmentState8;
  {$EXTERNALSYM IID_IDirectMusicSegmentState8}
  IID_IDirectMusicStyle8 = IDirectMusicStyle8;
  {$EXTERNALSYM IID_IDirectMusicStyle8}

  (* new interfaces (GUID + alias) *)
  IID_IDirectMusicPatternTrack = IDirectMusicPatternTrack;
  {$EXTERNALSYM IID_IDirectMusicPatternTrack}
  IID_IDirectMusicScript = IDirectMusicScript; (* {2252373A-5814-489b-8209-31FEDEBAF137} *)
  {$EXTERNALSYM IID_IDirectMusicScript}
  IID_IDirectMusicContainer = IDirectMusicContainer;
  {$EXTERNALSYM IID_IDirectMusicContainer}
  IID_IDirectMusicAudioPath = IDirectMusicAudioPath;
  {$EXTERNALSYM IID_IDirectMusicAudioPath}

  IID_IDirectMusicPatternTrack8 = IID_IDirectMusicPatternTrack;
  {$EXTERNALSYM IID_IDirectMusicPatternTrack8}
  IID_IDirectMusicScript8 = IID_IDirectMusicScript;
  {$EXTERNALSYM IID_IDirectMusicScript8}
  IID_IDirectMusicContainer8 = IID_IDirectMusicContainer;
  {$EXTERNALSYM IID_IDirectMusicContainer8}
  IID_IDirectMusicAudioPath8 = IID_IDirectMusicAudioPath;
  {$EXTERNALSYM IID_IDirectMusicAudioPath8}
  (* unchanged interfaces (alias only) *)
  IID_IDirectMusicGetLoader8 = IID_IDirectMusicGetLoader;
  {$EXTERNALSYM IID_IDirectMusicGetLoader8}
  IID_IDirectMusicChordMap8 = IID_IDirectMusicChordMap;
  {$EXTERNALSYM IID_IDirectMusicChordMap8}
  IID_IDirectMusicGraph8 = IID_IDirectMusicGraph;
  {$EXTERNALSYM IID_IDirectMusicGraph8}
  IID_IDirectMusicBand8 = IID_IDirectMusicBand;
  {$EXTERNALSYM IID_IDirectMusicBand8}
  IID_IDirectMusicObject8 = IID_IDirectMusicObject;
  {$EXTERNALSYM IID_IDirectMusicObject8}
  IID_IDirectMusicComposer8 = IID_IDirectMusicComposer;
  {$EXTERNALSYM IID_IDirectMusicComposer8}





(************************************************************************
*                                                                       *
*   dmusicf.h -- This module defines the DirectMusic file formats       *
*                                                                       *
*   Copyright (c) Microsoft Corporation.  All rights reserved.          *
*                                                                       *
************************************************************************)

const
  // Common chunks

  DMUS_FOURCC_GUID_CHUNK = DWORD(Byte('g') or (Byte('u') shl 8) or (Byte('i') shl 16) or (Byte('d') shl 24)); // mmioFOURCC('g','u','i','d')
  {$EXTERNALSYM DMUS_FOURCC_GUID_CHUNK}
  DMUS_FOURCC_INFO_LIST  = DWORD(Byte('I') or (Byte('N') shl 8) or (Byte('F') shl 16) or (Byte('O') shl 24)); // mmioFOURCC('I','N','F','O')
  {$EXTERNALSYM DMUS_FOURCC_INFO_LIST}
  DMUS_FOURCC_UNFO_LIST  = DWORD(Byte('U') or (Byte('N') shl 8) or (Byte('F') shl 16) or (Byte('O') shl 24)); // mmioFOURCC('U','N','F','O')
  {$EXTERNALSYM DMUS_FOURCC_UNFO_LIST}
  DMUS_FOURCC_UNAM_CHUNK = DWORD(Byte('U') or (Byte('N') shl 8) or (Byte('A') shl 16) or (Byte('M') shl 24)); // mmioFOURCC('U','N','A','M')
  {$EXTERNALSYM DMUS_FOURCC_UNAM_CHUNK}
  DMUS_FOURCC_UART_CHUNK = DWORD(Byte('U') or (Byte('A') shl 8) or (Byte('R') shl 16) or (Byte('T') shl 24)); // mmioFOURCC('U','A','R','T')
  {$EXTERNALSYM DMUS_FOURCC_UART_CHUNK}
  DMUS_FOURCC_UCOP_CHUNK = DWORD(Byte('U') or (Byte('C') shl 8) or (Byte('O') shl 16) or (Byte('P') shl 24)); // mmioFOURCC('U','C','O','P')
  {$EXTERNALSYM DMUS_FOURCC_UCOP_CHUNK}
  DMUS_FOURCC_USBJ_CHUNK = DWORD(Byte('U') or (Byte('S') shl 8) or (Byte('B') shl 16) or (Byte('J') shl 24)); // mmioFOURCC('U','S','B','J')
  {$EXTERNALSYM DMUS_FOURCC_USBJ_CHUNK}
  DMUS_FOURCC_UCMT_CHUNK = DWORD(Byte('U') or (Byte('C') shl 8) or (Byte('M') shl 16) or (Byte('T') shl 24)); // mmioFOURCC('U','C','M','T')
  {$EXTERNALSYM DMUS_FOURCC_UCMT_CHUNK}
  DMUS_FOURCC_CATEGORY_CHUNK = DWORD(Byte('c') or (Byte('a') shl 8) or (Byte('t') shl 16) or (Byte('g') shl 24)); // mmioFOURCC('c','a','t','g')
  {$EXTERNALSYM DMUS_FOURCC_CATEGORY_CHUNK}
  DMUS_FOURCC_VERSION_CHUNK  = DWORD(Byte('v') or (Byte('e') shl 8) or (Byte('r') shl 16) or (Byte('s') shl 24)); // mmioFOURCC('v','e','r','s')
  {$EXTERNALSYM DMUS_FOURCC_VERSION_CHUNK}

type
  // The following structures are used by the Tracks, and are the packed structures
  // that are passed to the Tracks inside the IStream.


  PDMusIoSeqItem = ^TDMusIoSeqItem;
  _DMUS_IO_SEQ_ITEM = record
    mtTime: TMusicTime;
    mtDuration: TMusicTime;
    dwPChannel: DWORD;
    nOffset: Smallint;
    bStatus: Byte;
    bByte1: Byte;
    bByte2: Byte;
  end;
  {$EXTERNALSYM _DMUS_IO_SEQ_ITEM}
  DMUS_IO_SEQ_ITEM = _DMUS_IO_SEQ_ITEM;
  {$EXTERNALSYM DMUS_IO_SEQ_ITEM}
  TDMusIoSeqItem = _DMUS_IO_SEQ_ITEM;


  PDMusIoCurveItem = ^TDMusIoCurveItem;
  _DMUS_IO_CURVE_ITEM = record
    mtStart: TMusicTime;
    mtDuration: TMusicTime;
    mtResetDuration: TMusicTime;
    dwPChannel: DWORD;
    nOffset: Smallint;
    nStartValue: Smallint;
    nEndValue: Smallint;
    nResetValue: Smallint;
    bType: Byte;
    bCurveShape: Byte;
    bCCData: Byte;
    bFlags: Byte;
    // Following was added for DirectX8.
    wParamType: Word;      // RPN or NRPN parameter number.
    wMergeIndex: Word;     // Allows multiple parameters to be merged (pitchbend, volume, and expression.)
  end;
  {$EXTERNALSYM _DMUS_IO_CURVE_ITEM}
  DMUS_IO_CURVE_ITEM = _DMUS_IO_CURVE_ITEM;
  {$EXTERNALSYM DMUS_IO_CURVE_ITEM}
  TDMusIoCurveItem = _DMUS_IO_CURVE_ITEM;


  PDMusIoTempoItem = ^TDMusIoTempoItem;
  _DMUS_IO_TEMPO_ITEM = record
    lTime: TMusicTime;
    dblTempo: Double;
  end;
  {$EXTERNALSYM _DMUS_IO_TEMPO_ITEM}
  DMUS_IO_TEMPO_ITEM = _DMUS_IO_TEMPO_ITEM;
  {$EXTERNALSYM DMUS_IO_TEMPO_ITEM}
  TDMusIoTempoItem = _DMUS_IO_TEMPO_ITEM;


  PDMusIoSysExItem = ^TDMusIoSysExItem;
  _DMUS_IO_SYSEX_ITEM = record
    mtTime: TMusicTime;
    dwPChannel: DWORD;
    dwSysExLength: DWORD;
  end;
  {$EXTERNALSYM _DMUS_IO_SYSEX_ITEM}
  DMUS_IO_SYSEX_ITEM = _DMUS_IO_SYSEX_ITEM;
  {$EXTERNALSYM DMUS_IO_SYSEX_ITEM}
  TDMusIoSysExItem = _DMUS_IO_SYSEX_ITEM;

  DMUS_CHORD_PARAM = DMUS_CHORD_KEY; (* DMUS_CHORD_KEY defined in dmusici.h *)
  {$EXTERNALSYM DMUS_CHORD_PARAM}
  TDMusChordParam = DMUS_CHORD_PARAM;
  PDMusChordParam = ^TDMusChordParam;

  _DMUS_RHYTHM_PARAM = record
    TimeSig:  TDMusTimeSignature;
    dwRhythmPattern: DWORD;
  end;
  {$EXTERNALSYM _DMUS_RHYTHM_PARAM}
  DMUS_RHYTHM_PARAM = _DMUS_RHYTHM_PARAM;
  {$EXTERNALSYM DMUS_RHYTHM_PARAM}
  TDMusRhythmParam = _DMUS_RHYTHM_PARAM;
  PDMusRhythmParam = ^TDMusRhythmParam;

  PDMusTempoParam = ^TDMusTempoParam;
  _DMUS_TEMPO_PARAM = record
    mtTime:  TMusicTime;
    dblTempo: Double;
  end;
  {$EXTERNALSYM _DMUS_TEMPO_PARAM}
  DMUS_TEMPO_PARAM = _DMUS_TEMPO_PARAM;
  {$EXTERNALSYM DMUS_TEMPO_PARAM}
  TDMusTempoParam = _DMUS_TEMPO_PARAM;

  PDMusMuteParam = ^TDMusMuteParam;
  _DMUS_MUTE_PARAM = record
    dwPChannel: DWORD;
    dwPChannelMap: DWORD;
    fMute: BOOL;
  end;
  {$EXTERNALSYM _DMUS_MUTE_PARAM}
  DMUS_MUTE_PARAM = _DMUS_MUTE_PARAM;
  {$EXTERNALSYM DMUS_MUTE_PARAM}
  TDMusMuteParam = _DMUS_MUTE_PARAM;

const
  (* Style chunks *)

  DMUS_FOURCC_STYLE_FORM          = DWORD(Byte('D') or (Byte('M') shl 8) or (Byte('S') shl 16) or (Byte('T') shl 24)); // mmioFOURCC('D','M','S','T')
  {$EXTERNALSYM DMUS_FOURCC_STYLE_FORM}
  DMUS_FOURCC_STYLE_CHUNK         = DWORD(Byte('s') or (Byte('t') shl 8) or (Byte('y') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('s','t','y','h')
  {$EXTERNALSYM DMUS_FOURCC_STYLE_CHUNK}
  DMUS_FOURCC_PART_LIST           = DWORD(Byte('p') or (Byte('a') shl 8) or (Byte('r') shl 16) or (Byte('t') shl 24)); // mmioFOURCC('p','a','r','t')
  {$EXTERNALSYM DMUS_FOURCC_PART_LIST}
  DMUS_FOURCC_PART_CHUNK          = DWORD(Byte('p') or (Byte('r') shl 8) or (Byte('t') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('p','r','t','h')
  {$EXTERNALSYM DMUS_FOURCC_PART_CHUNK}
  DMUS_FOURCC_NOTE_CHUNK          = DWORD(Byte('n') or (Byte('o') shl 8) or (Byte('t') shl 16) or (Byte('e') shl 24)); // mmioFOURCC('n','o','t','e')
  {$EXTERNALSYM DMUS_FOURCC_NOTE_CHUNK}
  DMUS_FOURCC_CURVE_CHUNK         = DWORD(Byte('c') or (Byte('r') shl 8) or (Byte('v') shl 16) or (Byte('e') shl 24)); // mmioFOURCC('c','r','v','e')
  {$EXTERNALSYM DMUS_FOURCC_CURVE_CHUNK}
  DMUS_FOURCC_MARKER_CHUNK        = DWORD(Byte('m') or (Byte('r') shl 8) or (Byte('k') shl 16) or (Byte('r') shl 24)); // mmioFOURCC('m','r','k','r')
  {$EXTERNALSYM DMUS_FOURCC_MARKER_CHUNK}
  DMUS_FOURCC_RESOLUTION_CHUNK    = DWORD(Byte('r') or (Byte('s') shl 8) or (Byte('l') shl 16) or (Byte('n') shl 24)); // mmioFOURCC('r','s','l','n')
  {$EXTERNALSYM DMUS_FOURCC_RESOLUTION_CHUNK}
  DMUS_FOURCC_ANTICIPATION_CHUNK  = DWORD(Byte('a') or (Byte('n') shl 8) or (Byte('p') shl 16) or (Byte('n') shl 24)); // mmioFOURCC('a','n','p','n')
  {$EXTERNALSYM DMUS_FOURCC_ANTICIPATION_CHUNK}
  DMUS_FOURCC_PATTERN_LIST        = DWORD(Byte('p') or (Byte('t') shl 8) or (Byte('t') shl 16) or (Byte('n') shl 24)); // mmioFOURCC('p','t','t','n')
  {$EXTERNALSYM DMUS_FOURCC_PATTERN_LIST}
  DMUS_FOURCC_PATTERN_CHUNK       = DWORD(Byte('p') or (Byte('t') shl 8) or (Byte('n') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('p','t','n','h')
  {$EXTERNALSYM DMUS_FOURCC_PATTERN_CHUNK}
  DMUS_FOURCC_RHYTHM_CHUNK        = DWORD(Byte('r') or (Byte('h') shl 8) or (Byte('t') shl 16) or (Byte('m') shl 24)); // mmioFOURCC('r','h','t','m')
  {$EXTERNALSYM DMUS_FOURCC_RHYTHM_CHUNK}
  DMUS_FOURCC_PARTREF_LIST        = DWORD(Byte('p') or (Byte('r') shl 8) or (Byte('e') shl 16) or (Byte('f') shl 24)); // mmioFOURCC('p','r','e','f')
  {$EXTERNALSYM DMUS_FOURCC_PARTREF_LIST}
  DMUS_FOURCC_PARTREF_CHUNK       = DWORD(Byte('p') or (Byte('r') shl 8) or (Byte('f') shl 16) or (Byte('c') shl 24)); // mmioFOURCC('p','r','f','c')
  {$EXTERNALSYM DMUS_FOURCC_PARTREF_CHUNK}
  DMUS_FOURCC_STYLE_PERS_REF_LIST = DWORD(Byte('p') or (Byte('r') shl 8) or (Byte('r') shl 16) or (Byte('f') shl 24)); // mmioFOURCC('p','r','r','f')
  {$EXTERNALSYM DMUS_FOURCC_STYLE_PERS_REF_LIST}
  DMUS_FOURCC_MOTIFSETTINGS_CHUNK = DWORD(Byte('m') or (Byte('t') shl 8) or (Byte('f') shl 16) or (Byte('s') shl 24)); // mmioFOURCC('m','t','f','s')
  {$EXTERNALSYM DMUS_FOURCC_MOTIFSETTINGS_CHUNK}

  (* Flags used by variations: these make up the DWORDs in dwVariationChoices.               *)

  (* These flags determine the types of chords supported by a given variation in DirectMusic *)
  (* mode.  The first seven flags (bits 1-7) are set if the variation supports major chords  *)
  (* rooted in scale positions, so, e.g., if bits 1, 2, and 4 are set, the variation         *)
  (* supports major chords rooted in the tonic, second, and fourth scale positions.  The     *)
  (* next seven flags serve the same purpose, but for minor chords, and the following seven  *)
  (* flags serve the same purpose for chords that are not major or minor (e.g., SUS 4        *)
  (* chords).  Bits 22, 23, and 24 are set if the variation supports chords rooted in the    *)
  (* scale, chords rooted sharp of scale tones, and chords rooted flat of scale tones,       *)
  (* respectively.  For example, to support a C# minor chord in the scale of C Major,        *)
  (* bits 8 (for tonic minor) and 24 (for sharp) need to be set.  Bits 25, 26, an 27 handle  *)
  (* chords that are triads, 6th or 7th chords, and chords with extensions, respectively.    *)
  (* bits 28 and 29 handle chords that are followed by tonic and dominant chords,            *)
  (* respectively.                                                                           *)
  DMUS_VARIATIONF_MAJOR        = $0000007F; (* Seven positions in the scale - major chords. *)
  {$EXTERNALSYM DMUS_VARIATIONF_MAJOR}
  DMUS_VARIATIONF_MINOR        = $00003F80; (* Seven positions in the scale - minor chords. *)
  {$EXTERNALSYM DMUS_VARIATIONF_MINOR}
  DMUS_VARIATIONF_OTHER        = $001FC000; (* Seven positions in the scale - other chords. *)
  {$EXTERNALSYM DMUS_VARIATIONF_OTHER}
  DMUS_VARIATIONF_ROOT_SCALE   = $00200000; (* Handles chord roots in the scale. *)
  {$EXTERNALSYM DMUS_VARIATIONF_ROOT_SCALE}
  DMUS_VARIATIONF_ROOT_FLAT    = $00400000; (* Handles flat chord roots (based on scale notes). *)
  {$EXTERNALSYM DMUS_VARIATIONF_ROOT_FLAT}
  DMUS_VARIATIONF_ROOT_SHARP   = $00800000; (* Handles sharp chord roots (based on scale notes). *)
  {$EXTERNALSYM DMUS_VARIATIONF_ROOT_SHARP}
  DMUS_VARIATIONF_TYPE_TRIAD   = $01000000; (* Handles simple chords - triads. *)
  {$EXTERNALSYM DMUS_VARIATIONF_TYPE_TRIAD}
  DMUS_VARIATIONF_TYPE_6AND7   = $02000000; (* Handles simple chords - 6 and 7. *)
  {$EXTERNALSYM DMUS_VARIATIONF_TYPE_6AND7}
  DMUS_VARIATIONF_TYPE_COMPLEX = $04000000; (* Handles complex chords. *)
  {$EXTERNALSYM DMUS_VARIATIONF_TYPE_COMPLEX}
  DMUS_VARIATIONF_DEST_TO1     = $08000000; (* Handles transitions to 1 chord. *)
  {$EXTERNALSYM DMUS_VARIATIONF_DEST_TO1}
  DMUS_VARIATIONF_DEST_TO5     = $10000000; (* Handles transitions to 5 chord. *)
  {$EXTERNALSYM DMUS_VARIATIONF_DEST_TO5}
  DMUS_VARIATIONF_DEST_OTHER   = $40000000; (* Handles transitions to chords other than 1 . *)
  {$EXTERNALSYM DMUS_VARIATIONF_DEST_OTHER}

  (* legacy mask for variation modes *)
  DMUS_VARIATIONF_MODES        = $E0000000;
  {$EXTERNALSYM DMUS_VARIATIONF_MODES}
  (* Bits 29 and 31 of the variation flags are the Mode bits.  If both are 0, it's IMA. *)
  (* If bit 29 is 1, it's Direct Music. *)
  DMUS_VARIATIONF_MODES_EX     = ($20000000 or $80000000);
  {$EXTERNALSYM DMUS_VARIATIONF_MODES_EX}
  DMUS_VARIATIONF_IMA25_MODE   = $00000000;
  {$EXTERNALSYM DMUS_VARIATIONF_IMA25_MODE}
  DMUS_VARIATIONF_DMUS_MODE    = $20000000;
  {$EXTERNALSYM DMUS_VARIATIONF_DMUS_MODE}

  (* Set this if the part uses marker events *)
  DMUS_PARTF_USE_MARKERS       = $1;
  {$EXTERNALSYM DMUS_PARTF_USE_MARKERS}
  (* Set this if the part is allowed to switch only on chord-aligned markers *)
  DMUS_PARTF_ALIGN_CHORDS      = $2;
  {$EXTERNALSYM DMUS_PARTF_ALIGN_CHORDS}

  (* These specify if the marker event signals whether to stop a variation or start a
  pattern/variation (or both), and whether new variations must align with a chord *)
  DMUS_MARKERF_START            = $1;
  {$EXTERNALSYM DMUS_MARKERF_START}
  DMUS_MARKERF_STOP             = $2;
  {$EXTERNALSYM DMUS_MARKERF_STOP}
  DMUS_MARKERF_CHORD_ALIGN      = $4;
  {$EXTERNALSYM DMUS_MARKERF_CHORD_ALIGN}

  (* if this flag is set, variation settings in a playing pattern-based track's state data will
  persist in the track after it stops playing *)
  DMUS_PATTERNF_PERSIST_CONTROL = $1;
  {$EXTERNALSYM DMUS_PATTERNF_PERSIST_CONTROL}


  (* These specify possible values for DMUS_IO_PATTERN.wEmbellishment (DirectX8) *)
  DMUS_EMBELLISHT_NORMAL          = 0;
  {$EXTERNALSYM DMUS_EMBELLISHT_NORMAL}
  DMUS_EMBELLISHT_FILL            = 1;
  {$EXTERNALSYM DMUS_EMBELLISHT_FILL}
  DMUS_EMBELLISHT_BREAK           = 2;
  {$EXTERNALSYM DMUS_EMBELLISHT_BREAK}
  DMUS_EMBELLISHT_INTRO           = 4;
  {$EXTERNALSYM DMUS_EMBELLISHT_INTRO}
  DMUS_EMBELLISHT_END             = 8;
  {$EXTERNALSYM DMUS_EMBELLISHT_END}
  DMUS_EMBELLISHT_MOTIF           = 16;
  {$EXTERNALSYM DMUS_EMBELLISHT_MOTIF}
  DMUS_EMBELLISHT_ALL             = $FFFF;
  {$EXTERNALSYM DMUS_EMBELLISHT_ALL}
type
  (* These specify possible values for DMUS_IO_PATTERN.wEmbellishment (DirectX8) *)
  enumDMUS_EMBELLISHT_TYPES = Word; 
  DMUS_EMBELLISHT_TYPES = enumDMUS_EMBELLISHT_TYPES;
  {$EXTERNALSYM DMUS_EMBELLISHT_TYPES}
  TDMusEmbellishtTypes = DMUS_EMBELLISHT_TYPES;

  {$ALIGN 2}

  (* These specify possible values for DMUS_IO_PARTREF.bRandomVariation
   all but DMUS_VARIATIONT_SEQUENTIAL and DMUS_VARIATIONT_RANDOM are DirectX8. *)
  enumDMUS_VARIATIONT_TYPES = (
    DMUS_VARIATIONT_SEQUENTIAL       {= 0}, (* Play sequential starting with variation 1. *)
    DMUS_VARIATIONT_RANDOM           {= 1}, (* Play randomly. *)
    DMUS_VARIATIONT_RANDOM_START     {= 2}, (* Play sequential starting with a random variation. *)
    DMUS_VARIATIONT_NO_REPEAT        {= 3}, (* Play randomly, but don't play the same variation twice. *)
    DMUS_VARIATIONT_RANDOM_ROW       {= 4}  (* Play randomly as a row: don't repeat any variation until all have played. *)
  );
  {$EXTERNALSYM enumDMUS_VARIATIONT_TYPES}
  DMUS_VARIATIONT_TYPES = enumDMUS_VARIATIONT_TYPES;
  {$EXTERNALSYM DMUS_VARIATIONT_TYPES}
  TDMusVariationtTypes = DMUS_VARIATIONT_TYPES;
  PDMusVariationtTypes = ^TDMusVariationtTypes;


  PDMusIoTimesig = ^TDMusIoTimesig;
  _DMUS_IO_TIMESIG = record
    (* Time signatures define how many beats per measure, which note receives *)
    (* the beat, and the grid resolution. *)
    bBeatsPerMeasure: Byte;   // beats per measure (top of time sig)
    bBeat: Byte;              // what note receives the beat (bottom of time sig.)
                              // we can assume that 0 means 256th note
    wGridsPerBeat: Word;      // grids per beat
  end;
  {$EXTERNALSYM _DMUS_IO_TIMESIG}
  DMUS_IO_TIMESIG = _DMUS_IO_TIMESIG;
  {$EXTERNALSYM DMUS_IO_TIMESIG}
  TDMusIoTimesig = _DMUS_IO_TIMESIG;

  PDMusIoStyle = ^TDMusIoStyle;
  _DMUS_IO_STYLE = record
    timeSig: TDMusIoTimesig;        // Styles have a default Time Signature
    dblTempo: Double;
  end;
  {$EXTERNALSYM _DMUS_IO_STYLE}
  DMUS_IO_STYLE = _DMUS_IO_STYLE;
  {$EXTERNALSYM DMUS_IO_STYLE}
  TDMusIoStyle = _DMUS_IO_STYLE;

  PDMusIoVersion = ^TDMusIoVersion;
  _DMUS_IO_VERSION = record
    dwVersionMS: DWORD;        // Version # high-order 32 bits
    dwVersionLS: DWORD;        // Version # low-order 32 bits
  end;
  {$EXTERNALSYM _DMUS_IO_VERSION}
  DMUS_IO_VERSION = _DMUS_IO_VERSION;
  {$EXTERNALSYM DMUS_IO_VERSION}
  TDMusIoVersion = _DMUS_IO_VERSION;

  PDMusIoPattern = ^TDMusIoPattern;
  _DMUS_IO_PATTERN = record
    timeSig: TDMusIoTimesig; // Patterns can override the Style's Time sig.
    bGrooveBottom: Byte;     // bottom of groove range
    bGrooveTop: Byte;        // top of groove range
    wEmbellishment: TDMusEmbellishtTypes; // Fill, Break, Intro, End, Normal, Motif
    wNbrMeasures: Word;      // length in measures
    bDestGrooveBottom: Byte; // bottom of groove range for next pattern
    bDestGrooveTop: Byte;    // top of groove range for next pattern
    dwFlags: DWORD;          // various flags
  end;
  {$EXTERNALSYM _DMUS_IO_PATTERN}
  DMUS_IO_PATTERN = _DMUS_IO_PATTERN;
  {$EXTERNALSYM DMUS_IO_PATTERN}
  TDMusIoPattern = _DMUS_IO_PATTERN;

  PDMusIoStylePart = ^TDMusIoStylePart;
  _DMUS_IO_STYLEPART = record
    timeSig: TDMusIoTimesig;        // can override pattern's
    dwVariationChoices: array[0..31] of DWORD; // MOAW choice bitfield
    guidPartID: TGUID;              // identifies the part
    wNbrMeasures: Word;             // length of the Part
    bPlayModeFlags: Byte;           // see PLAYMODE flags
    bInvertUpper: Byte;             // inversion upper limit
    bInvertLower: Byte;             // inversion lower limit
    bPad: array[0..2] of Byte;      // for DWORD alignment
    dwFlags: DWORD;                 // various flags
  end;
  {$EXTERNALSYM _DMUS_IO_STYLEPART}
  DMUS_IO_STYLEPART = _DMUS_IO_STYLEPART;
  {$EXTERNALSYM DMUS_IO_STYLEPART}
  TDMusIoStylePart = _DMUS_IO_STYLEPART;

  PDMusIoPartRef = ^TDMusIoPartRef;
  _DMUS_IO_PARTREF = record
    guidPartID: TGUID;        (* unique ID for matching up with parts *)
    wLogicalPartID: Word;     (* corresponds to port/device/midi channel OBSOLETE *)
    bVariationLockID: Byte;   (* parts with the same ID lock variations. *)
                              (* high bit is used to identify master Part *)
    bSubChordLevel: Byte;     (* tells which sub chord level this part wants *)
    bPriority: Byte;          (* 256 priority levels. Parts with lower priority *)
                              (* aren't played first when a device runs out of *)
                              (* notes *)
    bRandomVariation: TDMusVariationtTypes; (* when set, matching variations play in random order *)
                              (* when clear, matching variations play sequentially *)
    wPad: Word;               (* not used *)
    dwPChannel: DWORD;        (* replaces wLogicalPartID *)
  end;
  {$EXTERNALSYM _DMUS_IO_PARTREF}
  DMUS_IO_PARTREF = _DMUS_IO_PARTREF;
  {$EXTERNALSYM DMUS_IO_PARTREF}
  TDMusIoPartRef = _DMUS_IO_PARTREF;

  PDMusIoStyleNote = ^TDMusIoStyleNote;
  _DMUS_IO_STYLENOTE = record
    mtGridStart: TMusicTime; (* when this note occurs *)
    dwVariation: DWORD;      (* variation bits *)
    mtDuration: TMusicTime;  (* how long this note lasts *)
    nTimeOffset: Smallint;   (* offset from mtGridStart *)
    wMusicValue: Word;       (* Position in scale. *)
    bVelocity: Byte;         (* Note velocity. *)
    bTimeRange: Byte;        (* Range to randomize start time. *)
    bDurRange: Byte;         (* Range to randomize duration. *)
    bVelRange: Byte;         (* Range to randomize velocity. *)
    bInversionID: Byte;      (* Identifies inversion group to which this note belongs *)
    bPlayModeFlags: Byte;    (* Can override part *)
    (* Following exists only under DirectX8 and on *)
    bNoteFlags: Byte;        (* values from DMUS_NOTEF_FLAGS *)
  end;
  {$EXTERNALSYM _DMUS_IO_STYLENOTE}
  DMUS_IO_STYLENOTE = _DMUS_IO_STYLENOTE;
  {$EXTERNALSYM DMUS_IO_STYLENOTE}
  TDMusIoStyleNote = _DMUS_IO_STYLENOTE;

  PDMusIoStyleCurve = ^TDMusIoStyleCurve;
  _DMUS_IO_STYLECURVE = record
    mtGridStart: TMusicTime;     (* when this curve occurs *)
    dwVariation: DWORD;          (* variation bits *)
    mtDuration: TMusicTime;      (* how long this curve lasts *)
    mtResetDuration: TMusicTime; (* how long after the end of the curve to reset the curve *)
    nTimeOffset: Smallint;       (* offset from mtGridStart *)
    nStartValue: Smallint;       (* curve's start value *)
    nEndValue: Smallint;         (* curve's end value *)
    nResetValue: Smallint;       (* the value to which to reset the curve *)
    bEventType: Byte;            (* type of curve *)
    bCurveShape: Byte;           (* shape of curve *)
    bCCData: Byte;               (* CC# *)
    bFlags: Byte;                (* Bit 1=TRUE means to send nResetValue. Otherwise, don't.
                                    Other bits are reserved. *)
    (*  Following was added for DirectX8. *)
    wParamType: Word;            (* RPN or NRPN parameter number. *)
    wMergeIndex: Word;           (* Allows multiple parameters to be merged (pitchbend, volume, and expression.) *)
  end;
  {$EXTERNALSYM _DMUS_IO_STYLECURVE}
  DMUS_IO_STYLECURVE = _DMUS_IO_STYLECURVE;
  {$EXTERNALSYM DMUS_IO_STYLECURVE}
  TDMusIoStyleCurve = _DMUS_IO_STYLECURVE;

  PDMusIoStyleMarker = ^TDMusIoStyleMarker;
  _DMUS_IO_STYLEMARKER = record
    mtGridStart: TMusicTime; (* when this marker occurs *)
    dwVariation: DWORD;      (* variation bits *)
    wMarkerFlags: Word;      (* how the marker is used *)
  end;
  {$EXTERNALSYM _DMUS_IO_STYLEMARKER}
  DMUS_IO_STYLEMARKER = _DMUS_IO_STYLEMARKER;
  {$EXTERNALSYM DMUS_IO_STYLEMARKER}
  TDMusIoStyleMarker = _DMUS_IO_STYLEMARKER;

  PDMusIoStyleResolution = ^TDMusIoStyleResolution;
  _DMUS_IO_STYLERESOLUTION = record
    dwVariation: DWORD;      (* variation bits *)
    wMusicValue: Word;       (* Position in scale. *)
    bInversionID: Byte;      (* Identifies inversion group to which this note belongs *)
    bPlayModeFlags: Byte;    (* Can override part *)
  end;
  {$EXTERNALSYM _DMUS_IO_STYLERESOLUTION}
  DMUS_IO_STYLERESOLUTION = _DMUS_IO_STYLERESOLUTION;
  {$EXTERNALSYM DMUS_IO_STYLERESOLUTION}
  TDMusIoStyleResolution = _DMUS_IO_STYLERESOLUTION;

  PDMusIoStyleAnticipation = ^TDMusIoStyleAnticipation;
  _DMUS_IO_STYLE_ANTICIPATION = record
    mtGridStart: TMusicTime; (* when this anticipation occurs *)
    dwVariation: DWORD;      (* variation bits *)
    nTimeOffset: Smallint;   (* offset from mtGridStart *)
    bTimeRange: Byte;        (* Range to randomize start time. *)
  end;
  {$EXTERNALSYM _DMUS_IO_STYLE_ANTICIPATION}
  DMUS_IO_STYLE_ANTICIPATION = _DMUS_IO_STYLE_ANTICIPATION;
  {$EXTERNALSYM DMUS_IO_STYLE_ANTICIPATION}
  TDMusIoStyleAnticipation = _DMUS_IO_STYLE_ANTICIPATION;

  PDMusIoMotifSettings = ^TDMusIoMotifSettings;
  _DMUS_IO_MOTIFSETTINGS = record
    dwRepeats: DWORD;           (* Number of repeats. By default, 0. *)
    mtPlayStart: TMusicTime;    (* Start of playback. By default, 0. *)
    mtLoopStart: TMusicTime;    (* Start of looping portion. By default, 0. *)
    mtLoopEnd: TMusicTime;      (* End of loop. Must be greater than mtLoopStart. Or, 0, indicating loop full motif.  *)
    dwResolution: DWORD;        (* Default resolution. *)
  end;
  {$EXTERNALSYM _DMUS_IO_MOTIFSETTINGS}
  DMUS_IO_MOTIFSETTINGS = _DMUS_IO_MOTIFSETTINGS;
  {$EXTERNALSYM DMUS_IO_MOTIFSETTINGS}
  TDMusIoMotifSettings = _DMUS_IO_MOTIFSETTINGS;

  {$ALIGN ON}


(*
RIFF
(
    'DMST'          // Style
    <styh-ck>       // Style header chunk
    <guid-ck>       // Every Style has a GUID
    [<UNFO-list>]   // Name, author, copyright info., comments
    [<vers-ck>]     // version chunk
    <part-list>...  // Array of parts in the Style, used by patterns
    <pttn-list>...  // Array of patterns in the Style
    <DMBD-form>...  // Array of bands in the Style
    [<prrf-list>]...// Optional array of chord map references in the Style
)

    // <styh-ck>
    styh
    (
        <DMUS_IO_STYLE>
    )

    // <guid-ck>
    guid
    (
        <GUID>
    )

    // <vers-ck>
    vers
    (
        <DMUS_IO_VERSION>
    )

    // <part-list>
    LIST
    (
        'part'
        <prth-ck>       // Part header chunk
        [<UNFO-list>]   // Name, author, copyright info., comments
        [<note-ck>]     // Optional chunk containing an array of notes in Part
        [<crve-ck>]     // Optional chunk containing an array of curves in Part
        [<mrkr-ck>]     // Optional chunk containing an array of markers in Part
        [<rsln-ck>]     // Optional chunk containing an array of variation resolutions in Part
        [<anpn-ck>]     // Optional chunk containing an array of resolution anticipations in Part
    )

        // <orth-ck>
        prth
        (
            <DMUS_IO_STYLEPART>
        )

        // <note-ck>
        'note'
        (
            // sizeof DMUS_IO_STYLENOTE:DWORD
            <DMUS_IO_STYLENOTE>...
        )

        // <crve-ck>
        'crve'
        (
            // sizeof DMUS_IO_STYLECURVE:DWORD
            <DMUS_IO_STYLECURVE>...
        )

        // <mrkr-ck>
        'mrkr'
        (
            // sizeof DMUS_IO_STYLEMARKER:DWORD
            <DMUS_IO_STYLEMARKER>...
        )

        // <rsln-ck>
        'rsln'
        (
            // sizeof DMUS_IO_STYLERESOLUTION:DWORD
            <DMUS_IO_STYLERESOLUTION>...
        )

        // <anpn-ck>
        'anpn'
        (
            // sizeof DMUS_IO_STYLE_ANTICIPATION:DWORD
            <DMUS_IO_STYLE_ANTICIPATION>...
        )

    // <pttn-list>
    LIST
    (
        'pttn'
        <ptnh-ck>       // Pattern header chunk
        <rhtm-ck>       // Chunk containing an array of rhythms for chord matching
        [<UNFO-list>]   // Name, author, copyright info., comments
        [<mtfs-ck>]     // Motif settings chunk
        [<DMBD-form>]   // Optional band to be associated with the pattern (for motifs)
        <pref-list>...  // Array of part reference id's
    )

        // <ptnh-ck>
        ptnh
        (
            <DMUS_IO_PATTERN>
        )

        // <rhtm-ck>
        'rhtm'
        (
            // DWORD's representing rhythms for chord matching based on number
            // of measures in the pattern
        )


        // pref-list
        LIST
        (
            'pref'
            <prfc-ck>   // part ref chunk
        )

        // <prfc-ck>
        prfc
        (
            <DMUS_IO_PARTREF>
        )

        // <mtfs-ck>
        mtfs
        (
            <DMUS_IO_MOTIFSETTINGS>
        )

    // <prrf-list>
    LIST
    (
        'prrf'
        <DMRF-list>... // Array of Chordmap references
    )
*)

const
  (* Pattern chunk, for use in Pattern tracks *)
  DMUS_FOURCC_PATTERN_FORM = DWORD(Byte('D') or (Byte('M') shl 8) or (Byte('P') shl 16) or (Byte('T') shl 24)); // mmioFOURCC('D','M','P','T')
  {$EXTERNALSYM DMUS_FOURCC_PATTERN_FORM}

(*
RIFF
(
    'DMPT'          // Pattern
    <styh-ck>       // Style header chunk
    <pttn-list>     // The pattern, in single pattern format (includes DMUS_FOURCC_PART_LIST chunks)
)
*)


(* Chord and command file formats *)

type
  (* These specify possible values for DMUS_IO_COMMAND.bRepeatMode (DirectX8) *)
  enumDMUS_PATTERNT_TYPES = (
    DMUS_PATTERNT_RANDOM           {= 0}, (* Play randomly. (DirectX7 behavior) *)
    DMUS_PATTERNT_REPEAT           {= 1}, (* Repeat last pattern. *)
    DMUS_PATTERNT_SEQUENTIAL       {= 2}, (* Play sequential starting with first matching pattern. *)
    DMUS_PATTERNT_RANDOM_START     {= 3}, (* Play sequential starting with a random pattern. *)
    DMUS_PATTERNT_NO_REPEAT        {= 4}, (* Play randomly, but don't play the same pattern twice. *)
    DMUS_PATTERNT_RANDOM_ROW       {= 5}  (* Play randomly as a row: don't repeat any pattern until all have played. *)
  );
  {$EXTERNALSYM enumDMUS_PATTERNT_TYPES}
  DMUS_PATTERNT_TYPES = enumDMUS_PATTERNT_TYPES;
  {$EXTERNALSYM DMUS_PATTERNT_TYPES}
  TDMusPatterntTypes = DMUS_PATTERNT_TYPES;

const
  DMUS_FOURCC_CHORDTRACK_LIST        = DWORD(Byte('c') or (Byte('o') shl 8) or (Byte('r') shl 16) or (Byte('d') shl 24)); // mmioFOURCC('c','o','r','d')
  {$EXTERNALSYM DMUS_FOURCC_CHORDTRACK_LIST}
  DMUS_FOURCC_CHORDTRACKHEADER_CHUNK = DWORD(Byte('c') or (Byte('r') shl 8) or (Byte('d') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('c','r','d','h')
  {$EXTERNALSYM DMUS_FOURCC_CHORDTRACKHEADER_CHUNK}
  DMUS_FOURCC_CHORDTRACKBODY_CHUNK   = DWORD(Byte('c') or (Byte('r') shl 8) or (Byte('d') shl 16) or (Byte('b') shl 24)); // mmioFOURCC('c','r','d','b')
  {$EXTERNALSYM DMUS_FOURCC_CHORDTRACKBODY_CHUNK}

  DMUS_FOURCC_COMMANDTRACK_CHUNK     = DWORD(Byte('c') or (Byte('m') shl 8) or (Byte('n') shl 16) or (Byte('d') shl 24)); // mmioFOURCC('c','m','n','d')
  {$EXTERNALSYM DMUS_FOURCC_COMMANDTRACK_CHUNK}

type
  PDMusIoChord = ^TDMusIoChord;
  _DMUS_IO_CHORD = record
    wszName: array[0..15] of WideChar; (* Name of the chord *)
    mtTime: TMusicTime;   (* Time of this chord *)
    wMeasure: Word;       (* Measure this falls on *)
    bBeat: Byte;          (* Beat this falls on *)
    bFlags: Byte;         (* Various flags *)
  end;
  {$EXTERNALSYM _DMUS_IO_CHORD}
  DMUS_IO_CHORD = _DMUS_IO_CHORD;
  {$EXTERNALSYM DMUS_IO_CHORD}
  TDMusIoChord = _DMUS_IO_CHORD;

  PDMusIoSubChord = ^TDMusIoSubChord;
  _DMUS_IO_SUBCHORD = record
    dwChordPattern: DWORD;     (* Notes in the subchord *)
    dwScalePattern: DWORD;     (* Notes in the scale *)
    dwInversionPoints: DWORD;  (* Where inversions can occur *)
    dwLevels: DWORD;           (* Which levels are supported by this subchord *)
    bChordRoot: Byte;          (* Root of the subchord *)
    bScaleRoot: Byte;          (* Root of the scale *)
  end;
  {$EXTERNALSYM _DMUS_IO_SUBCHORD}
  DMUS_IO_SUBCHORD = _DMUS_IO_SUBCHORD;
  {$EXTERNALSYM DMUS_IO_SUBCHORD}
  TDMusIoSubChord = _DMUS_IO_SUBCHORD;

  PDMusIoCommand = ^TDMusIoCommand;
  _DMUS_IO_COMMAND = record
    mtTime: TMusicTime;   (* Time of this command *)
    wMeasure: Word;       (* Measure this falls on *)
    bBeat: Byte;          (* Beat this falls on *)
    bCommand: Byte;       (* Command type (see #defines below) *)
    bGrooveLevel: Byte;   (* Groove level (0 if command is not a groove) *)
    bGrooveRange: Byte;   (* Groove range  *)
    bRepeatMode: Byte;    (* Used to control selection of patterns with same groove level  *)
  end;
  {$EXTERNALSYM _DMUS_IO_COMMAND}
  DMUS_IO_COMMAND = _DMUS_IO_COMMAND;
  {$EXTERNALSYM DMUS_IO_COMMAND}
  TDMusIoCommand = _DMUS_IO_COMMAND;


(*

    // <cord-list>
    LIST
    (
        'cord'
        <crdh-ck>
        <crdb-ck>...    // Chord body chunks
    )

        // <crdh-ck>
        crdh
        (
            // Scale: dword (upper 8 bits for root, lower 24 for scale)
        )

        // <crdb-ck>
        crdb
        (
            // sizeof DMUS_IO_CHORD:dword
            <DMUS_IO_CHORD>
            // # of DMUS_IO_SUBCHORDS:dword
            // sizeof DMUS_IO_SUBCHORDS:dword
            // a number of <DMUS_IO_SUBCHORD>
        )


    // <cmnd-list>
    'cmnd'
    (
        //sizeof DMUS_IO_COMMAND: DWORD
        <DMUS_IO_COMMAND>...
    )

*)

(*  File io for DirectMusic Tool and ToolGraph objects
*)

const
  (* RIFF ids: *)

  DMUS_FOURCC_TOOLGRAPH_FORM = DWORD(Byte('D') or (Byte('M') shl 8) or (Byte('T') shl 16) or (Byte('G') shl 24)); // mmioFOURCC('D','M','T','G')
  {$EXTERNALSYM DMUS_FOURCC_TOOLGRAPH_FORM}
  DMUS_FOURCC_TOOL_LIST      = DWORD(Byte('t') or (Byte('o') shl 8) or (Byte('l') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('t','o','l','l')
  {$EXTERNALSYM DMUS_FOURCC_TOOL_LIST}
  DMUS_FOURCC_TOOL_FORM      = DWORD(Byte('D') or (Byte('M') shl 8) or (Byte('T') shl 16) or (Byte('L') shl 24)); // mmioFOURCC('D','M','T','L')
  {$EXTERNALSYM DMUS_FOURCC_TOOL_FORM}
  DMUS_FOURCC_TOOL_CHUNK     = DWORD(Byte('t') or (Byte('o') shl 8) or (Byte('l') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('t','o','l','h')
  {$EXTERNALSYM DMUS_FOURCC_TOOL_CHUNK}

type
  (* io type = recordures: *)
  PDMusIoToolHeader = ^TDMusIoToolHeader;
  _DMUS_IO_TOOL_HEADER = record
    guidClassID: TGUID;     (* Class id of tool. *)
    lIndex: Longint;        (* Position in graph. *)
    cPChannels: DWORD;      (* Number of items in channels array. *)
    ckid: FOURCC;           (* chunk ID of tool's data chunk if 0 fccType valid. *)
    fccType: FOURCC;        (* list type if NULL ckid valid. *)
    dwPChannels: array[0..0] of DWORD; (* Array of PChannels, size determined by cPChannels. *)
  end;
  {$EXTERNALSYM _DMUS_IO_TOOL_HEADER}
  DMUS_IO_TOOL_HEADER = _DMUS_IO_TOOL_HEADER;
  {$EXTERNALSYM DMUS_IO_TOOL_HEADER}
  TDMusIoToolHeader = _DMUS_IO_TOOL_HEADER;

(*
RIFF
(
    'DMTG'          // DirectMusic ToolGraph chunk
    [<guid-ck>]     // GUID for ToolGraph
    [<vers-ck>]     // Optional version info
    [<UNFO-list>]   // Name, author, copyright info., comments
    <toll-list>     // List of Tools
)

    // <guid-ck>
    'guid'
    (
        <GUID>
    )

    // <vers-ck>
    vers
    (
        <DMUS_IO_VERSION>
    )

    // <toll-list>
    LIST
    (
        'toll'          // Array of tools
        <DMTL-form>...  // Each tool is encapsulated in a RIFF chunk
    )

// <DMTL-form>      Tools are embedded in a graph. Theoretically, they can be saved as individual files too.
RIFF
(
    'DMTL'
    <tolh-ck>
    [<data>]        // Tool data. Must be a RIFF readable chunk.
)

    // <tolh-ck>            // Tool header chunk
    (
        'tolh'
        <DMUS_IO_TOOL_HEADER>   // Tool header
    )
*)

(*  The AudioPath file carries everything for describing a specific audio path,
    including Tool Graph and Buffer Descriptor.
    This can even be used for configuring a complete performance.
*)

const
  DMUS_FOURCC_AUDIOPATH_FORM = DWORD(Byte('D') or (Byte('M') shl 8) or (Byte('A') shl 16) or (Byte('P') shl 24)); // mmioFOURCC('D','M','A','P')
  {$EXTERNALSYM DMUS_FOURCC_AUDIOPATH_FORM}

(*
RIFF
(
    'DMAP'          // DirectMusic AudioPath chunk
    [<guid-ck>]     // GUID for this Audio Path configuration
    [<vers-ck>]     // Optional version info
    [<UNFO-list>]   // Name, author, copyright info., comments
    [<DMTG-form>]   // Optional ToolGraph
    [<pcsl-list>]   // Optional list of port configurations
    [<dbfl-list>]...// Optional array of DirectSound buffer descriptors
)
*)

  DMUS_FOURCC_PORTCONFIGS_LIST = DWORD(Byte('p') or (Byte('c') shl 8) or (Byte('s') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('p','c','s','l')
  {$EXTERNALSYM DMUS_FOURCC_PORTCONFIGS_LIST}
  DMUS_FOURCC_PORTCONFIG_LIST  = DWORD(Byte('p') or (Byte('c') shl 8) or (Byte('f') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('p','c','f','l')
  {$EXTERNALSYM DMUS_FOURCC_PORTCONFIG_LIST}
  DMUS_FOURCC_PORTCONFIG_ITEM  = DWORD(Byte('p') or (Byte('c') shl 8) or (Byte('f') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('p','c','f','h')
  {$EXTERNALSYM DMUS_FOURCC_PORTCONFIG_ITEM}
  DMUS_FOURCC_PORTPARAMS_ITEM  = DWORD(Byte('p') or (Byte('p') shl 8) or (Byte('r') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('p','p','r','h')
  {$EXTERNALSYM DMUS_FOURCC_PORTPARAMS_ITEM}
  DMUS_FOURCC_DSBUFFER_LIST    = DWORD(Byte('d') or (Byte('b') shl 8) or (Byte('f') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('d','b','f','l')
  {$EXTERNALSYM DMUS_FOURCC_DSBUFFER_LIST}
  DMUS_FOURCC_DSBUFFATTR_ITEM  = DWORD(Byte('d') or (Byte('d') shl 8) or (Byte('a') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('d','d','a','h')
  {$EXTERNALSYM DMUS_FOURCC_DSBUFFATTR_ITEM}
  DMUS_FOURCC_PCHANNELS_LIST   = DWORD(Byte('p') or (Byte('c') shl 8) or (Byte('h') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('p','c','h','l')
  {$EXTERNALSYM DMUS_FOURCC_PCHANNELS_LIST}
  DMUS_FOURCC_PCHANNELS_ITEM   = DWORD(Byte('p') or (Byte('c') shl 8) or (Byte('h') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('p','c','h','h')
  {$EXTERNALSYM DMUS_FOURCC_PCHANNELS_ITEM}

type
  PDMusIoPortConfigHeader = ^TDMusIoPortConfigHeader;
  _DMUS_IO_PORTCONFIG_HEADER = record
    guidPort: TGUID;           (* GUID of requested port. *)
    dwPChannelBase: DWORD;     (* PChannel that this should start on. *)
    dwPChannelCount: DWORD;    (* How many channels. *)
    dwFlags: DWORD;            (* Various flags. *)
  end;
  {$EXTERNALSYM _DMUS_IO_PORTCONFIG_HEADER}
  DMUS_IO_PORTCONFIG_HEADER = _DMUS_IO_PORTCONFIG_HEADER;
  {$EXTERNALSYM DMUS_IO_PORTCONFIG_HEADER}
  TDMusIoPortConfigHeader = _DMUS_IO_PORTCONFIG_HEADER;

const
  DMUS_PORTCONFIGF_DRUMSON10  = 1;   (* This port configured for drums on channel 10. *)
  {$EXTERNALSYM DMUS_PORTCONFIGF_DRUMSON10}
  DMUS_PORTCONFIGF_USEDEFAULT = 2;   (* Use the default port. *)
  {$EXTERNALSYM DMUS_PORTCONFIGF_USEDEFAULT}

(* Each portconfig has one or more pchannel to buffer mappings. Each buffer
   is identified by a guid. Each pchannel can map to one or more buffers.
   This is defined with one or more DMUS_IO_PCHANNELTOBUFFER_HEADER
   structures. Each defines a range of PChannels and the set of buffers
   that they connect to.
*)

type
  PDMusIoPChannelToBufferHeader = ^TDMusIoPChannelToBufferHeader;
  _DMUS_IO_PCHANNELTOBUFFER_HEADER = record
    dwPChannelBase:   DWORD;     (* PChannel that this should start on. *)
    dwPChannelCount:   DWORD;    (* How many PChannels. *)
    dwBufferCount:   DWORD;      (* How many buffers do these connect to. *)
    dwFlags:   DWORD;            (* Various flags. Currently reserved for future use. Must be 0. *)
  end;
  {$EXTERNALSYM _DMUS_IO_PCHANNELTOBUFFER_HEADER}
  DMUS_IO_PCHANNELTOBUFFER_HEADER = _DMUS_IO_PCHANNELTOBUFFER_HEADER;
  {$EXTERNALSYM DMUS_IO_PCHANNELTOBUFFER_HEADER}
  TDMusIoPChannelToBufferHeader = _DMUS_IO_PCHANNELTOBUFFER_HEADER;

(* Each buffer is represented by an DSBC form. This is wrapped by the
   DMUS_IO_BUFFER_ATTRIBUTES_HEADER which identifies how to use the
   buffer. In particular, it indicates whether this gets dynamically duplicated
   or all references to this should share the same instance.
   To resolve references, the unique GUID of the buffer is also stored
   in this structure.
*)

  PDMusIoBufferAttributesHeader = ^TDMusIoBufferAttributesHeader;
  _DMUS_IO_BUFFER_ATTRIBUTES_HEADER = record
    guidBufferID: TGUID;       (* Each buffer config has a unique ID. *)
    dwFlags: DWORD;            (* Various flags. *)
  end;
  {$EXTERNALSYM _DMUS_IO_BUFFER_ATTRIBUTES_HEADER}
  DMUS_IO_BUFFER_ATTRIBUTES_HEADER = _DMUS_IO_BUFFER_ATTRIBUTES_HEADER;
  {$EXTERNALSYM DMUS_IO_BUFFER_ATTRIBUTES_HEADER}
  TDMusIoBufferAttributesHeader = _DMUS_IO_BUFFER_ATTRIBUTES_HEADER;

const
  (* DMUS_IO_BUFFER_ATTRIBUTES_HEADER.dwFlags: *)
  DMUS_BUFFERF_SHARED     = 1;   (* Share this with other audio paths, instead of creating unique copies. *)
  {$EXTERNALSYM DMUS_BUFFERF_SHARED}
  DMUS_BUFFERF_DEFINED    = 2;   (* Use one of the standard predefined buffers (see GUID_Buffer... in dmusici.h.) *)
  {$EXTERNALSYM DMUS_BUFFERF_DEFINED}
  DMUS_BUFFERF_MIXIN      = 8;   (* This is a mixin buffer. *)
  {$EXTERNALSYM DMUS_BUFFERF_MIXIN}

(*

LIST
(
    'pcsl'          // Array of port configurations
    <pcfl-list>...  // One or more port configurations, each in a list chunk
)

LIST
(
    'pcfl'          // List container for one port configuration.
    <pcfh-ck>       // Portconfig header chunk.
    <pprh-ck>       // Port params, to be used to create the port.
    [<dbfl-list>]...// Optional array of DirectSound buffer descriptors
    [<pchl-list>]   // Optional list of pchannel to buffer assignments

)

    // <pcfh-ck>            // Port config header chunk
    (
        'pcfh'
        <DMUS_IO_PORTCONFIG_HEADER>   // Port config header
    )

    // <pprh-ck>            // Port params header chunk
    (
        'pprh'
        <DMUS_PORTPARAMS8>   // Port params header
    )

LIST
(
    'pchl'          // List container for one or more pchannel to buffer assignments.
    <pchh-ck>...    // One or more pchannel to buffer assignment headers and data.

    // <pchh-ck>
    (
        'pchh'
        <DMUS_IO_PCHANNELTOBUFFER_HEADER>   // Description of PChannels
        <GUID>...                           // Array of GUIDs defining the buffers they all connect to.
    )
)

LIST
(
    'dbfl'          // List container for one buffer and buffer attributes header.
    <ddah-ck>       // Buffer attributes header. 
    [<DSBC-form>]   // Buffer configuration. Not required when header uses a predefined buffer type.

    // <ddah-ck>
    (
        'ddah'
        <DMUS_IO_BUFFER_ATTRIBUTES_HEADER>   // Buffer attributes.
    )
)
*)

(*  File io for DirectMusic Band Track object *)


const
  (* RIFF ids: *)
  DMUS_FOURCC_BANDTRACK_FORM  = DWORD(Byte('D') or (Byte('M') shl 8) or (Byte('B') shl 16) or (Byte('T') shl 24)); // mmioFOURCC('D','M','B','T')
  {$EXTERNALSYM DMUS_FOURCC_BANDTRACK_FORM}
  DMUS_FOURCC_BANDTRACK_CHUNK = DWORD(Byte('b') or (Byte('d') shl 8) or (Byte('t') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('b','d','t','h')
  {$EXTERNALSYM DMUS_FOURCC_BANDTRACK_CHUNK}
  DMUS_FOURCC_BANDS_LIST      = DWORD(Byte('l') or (Byte('b') shl 8) or (Byte('d') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('l','b','d','l')
  {$EXTERNALSYM DMUS_FOURCC_BANDS_LIST}
  DMUS_FOURCC_BAND_LIST       = DWORD(Byte('l') or (Byte('b') shl 8) or (Byte('n') shl 16) or (Byte('d') shl 24)); // mmioFOURCC('l','b','n','d')
  {$EXTERNALSYM DMUS_FOURCC_BAND_LIST}
  DMUS_FOURCC_BANDITEM_CHUNK  = DWORD(Byte('b') or (Byte('d') shl 8) or (Byte('i') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('b','d','i','h')
  {$EXTERNALSYM DMUS_FOURCC_BANDITEM_CHUNK}
  DMUS_FOURCC_BANDITEM_CHUNK2 = DWORD(Byte('b') or (Byte('d') shl 8) or (Byte('2') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('b','d','2','h')
  {$EXTERNALSYM DMUS_FOURCC_BANDITEM_CHUNK2}

type
  (* io structures *)
  PDMusIoBandTrackHeader = ^TDMusIoBandTrackHeader;
  _DMUS_IO_BAND_TRACK_HEADER = record
    bAutoDownload: BOOL;     (* Determines if Auto-Download is enabled. *)
  end;
  {$EXTERNALSYM _DMUS_IO_BAND_TRACK_HEADER}
  DMUS_IO_BAND_TRACK_HEADER = _DMUS_IO_BAND_TRACK_HEADER;
  {$EXTERNALSYM DMUS_IO_BAND_TRACK_HEADER}
  TDMusIoBandTrackHeader = _DMUS_IO_BAND_TRACK_HEADER;

  PDMusIoBandItemHeader = ^TDMusIoBandItemHeader;
  _DMUS_IO_BAND_ITEM_HEADER = record
    lBandTime: TMusicTime;   (* Position in track list. *)
  end;
  {$EXTERNALSYM _DMUS_IO_BAND_ITEM_HEADER}
  DMUS_IO_BAND_ITEM_HEADER = _DMUS_IO_BAND_ITEM_HEADER;
  {$EXTERNALSYM DMUS_IO_BAND_ITEM_HEADER}
  TDMusIoBandItemHeader = _DMUS_IO_BAND_ITEM_HEADER;

  PDMusIoBandItemHeader2 = ^TDMusIoBandItemHeader2;
  _DMUS_IO_BAND_ITEM_HEADER2 = record
    lBandTimeLogical: TMusicTime;   (* Position in track list. Time in the music with which band change is associated. *)
    lBandTimePhysical: TMusicTime;  (* Precise time band change will take effect. Should be close to logical time. *)
  end;
  {$EXTERNALSYM _DMUS_IO_BAND_ITEM_HEADER2}
  DMUS_IO_BAND_ITEM_HEADER2 = _DMUS_IO_BAND_ITEM_HEADER2;
  {$EXTERNALSYM DMUS_IO_BAND_ITEM_HEADER2}
  TDMusIoBandItemHeader2 = _DMUS_IO_BAND_ITEM_HEADER2;

(*
RIFF
(
    'DMBT'          // DirectMusic Band Track form-type
    [<bdth-ck>]     // Band track header
    [<guid-ck>]     // GUID for band track
    [<vers-ck>]     // Optional version info
    [<UNFO-list>]   // Name, author, copyright info., comments
    <lbdl-list>     // List of Band items
)

    // <bnth-ck>
    'bdth'
    (
        <DMUS_IO_BAND_TRACK_HEADER>
    )

    // <guid-ck>
    'guid'
    (
        <GUID>
    )

    // <vers-ck>
    vers
    (
        <DMUS_IO_VERSION>
    )

    // <lbdl-list>
    LIST
    (
        'lbdl'
        <lbnd-list>...  // Array of bands, each encapsulated in a list chunk
    )

        // <lbnd-list>
        LIST
        (
            'lbnd'
            <bdih-ck> or <bd2h-ck>  // bdih is a legacy format.  bd2h is preferred for new content.
            <DMBD-form> // Band
        )

            // <bdih-ck> or <bd2h-ck>       // band item header
            (
                <DMUS_IO_BAND_ITEM_HEADER> or <DMUS_IO_BAND_ITEM_HEADER2> // Band item header
            )
*)


(*  File io for DirectMusic Band object
*)

const
  (* RIFF ids: *)

  DMUS_FOURCC_BAND_FORM        = DWORD(Byte('D') or (Byte('M') shl 8) or (Byte('B') shl 16) or (Byte('D') shl 24)); // mmioFOURCC('D','M','B','D')
  {$EXTERNALSYM DMUS_FOURCC_BAND_FORM}
  DMUS_FOURCC_INSTRUMENTS_LIST = DWORD(Byte('l') or (Byte('b') shl 8) or (Byte('i') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('l','b','i','l')
  {$EXTERNALSYM DMUS_FOURCC_INSTRUMENTS_LIST}
  DMUS_FOURCC_INSTRUMENT_LIST  = DWORD(Byte('l') or (Byte('b') shl 8) or (Byte('i') shl 16) or (Byte('n') shl 24)); // mmioFOURCC('l','b','i','n')
  {$EXTERNALSYM DMUS_FOURCC_INSTRUMENT_LIST}
  DMUS_FOURCC_INSTRUMENT_CHUNK = DWORD(Byte('b') or (Byte('i') shl 8) or (Byte('n') shl 16) or (Byte('s') shl 24)); // mmioFOURCC('b','i','n','s')
  {$EXTERNALSYM DMUS_FOURCC_INSTRUMENT_CHUNK}

(* Flags for DMUS_IO_INSTRUMENT
 *)
  DMUS_IO_INST_PATCH          = (1 shl 0);        (* dwPatch is valid. *)
  {$EXTERNALSYM DMUS_IO_INST_PATCH}
  DMUS_IO_INST_BANKSELECT     = (1 shl 1);        (* dwPatch contains a valid Bank Select MSB and LSB part *)
  {$EXTERNALSYM DMUS_IO_INST_BANKSELECT}
  DMUS_IO_INST_ASSIGN_PATCH   = (1 shl 3);        (* dwAssignPatch is valid *)
  {$EXTERNALSYM DMUS_IO_INST_ASSIGN_PATCH}
  DMUS_IO_INST_NOTERANGES     = (1 shl 4);        (* dwNoteRanges is valid *)
  {$EXTERNALSYM DMUS_IO_INST_NOTERANGES}
  DMUS_IO_INST_PAN            = (1 shl 5);        (* bPan is valid *)
  {$EXTERNALSYM DMUS_IO_INST_PAN}
  DMUS_IO_INST_VOLUME         = (1 shl 6);        (* bVolume is valid *)
  {$EXTERNALSYM DMUS_IO_INST_VOLUME}
  DMUS_IO_INST_TRANSPOSE      = (1 shl 7);        (* nTranspose is valid *)
  {$EXTERNALSYM DMUS_IO_INST_TRANSPOSE}
  DMUS_IO_INST_GM             = (1 shl 8);        (* Instrument is from GM collection *)
  {$EXTERNALSYM DMUS_IO_INST_GM}
  DMUS_IO_INST_GS             = (1 shl 9);        (* Instrument is from GS collection *)
  {$EXTERNALSYM DMUS_IO_INST_GS}
  DMUS_IO_INST_XG             = (1 shl 10);       (* Instrument is from XG collection *)
  {$EXTERNALSYM DMUS_IO_INST_XG}
  DMUS_IO_INST_CHANNEL_PRIORITY = (1 shl 11);     (* dwChannelPriority is valid *)
  {$EXTERNALSYM DMUS_IO_INST_CHANNEL_PRIORITY}
  DMUS_IO_INST_USE_DEFAULT_GM_SET = (1 shl 12);   (* Always use the default GM set for this patch,  *)
  {$EXTERNALSYM DMUS_IO_INST_USE_DEFAULT_GM_SET}
                                                  (* don't rely on the synth caps stating GM or GS in hardware. *)
  DMUS_IO_INST_PITCHBENDRANGE = (1 shl 13);       (* nPitchBendRange is valid *)
  {$EXTERNALSYM DMUS_IO_INST_PITCHBENDRANGE}

type
  (* io structures *)
  PDMusIoInstrument = ^TDMusIoInstrument;
  _DMUS_IO_INSTRUMENT = record
    dwPatch: DWORD;            (* MSB, LSB and Program change to define instrument *)
    dwAssignPatch: DWORD;      (* MSB, LSB and Program change to assign to instrument when downloading *)
    dwNoteRanges: array[0..3] of DWORD; (* 128 bits; one for each MIDI note instrument needs to able to play *)
    dwPChannel: DWORD;         (* PChannel instrument plays on *)
    dwFlags: DWORD;            (* DMUS_IO_INST_ flags *)
    bPan: Byte;                (* Pan for instrument *)
    bVolume: Byte;             (* Volume for instrument *)
    nTranspose: Smallint;      (* Number of semitones to transpose notes *)
    dwChannelPriority: DWORD;  (* Channel priority *)
    nPitchBendRange: Smallint; (* Number of semitones shifted by pitch bend *)
  end;
  {$EXTERNALSYM _DMUS_IO_INSTRUMENT}
  DMUS_IO_INSTRUMENT = _DMUS_IO_INSTRUMENT;
  {$EXTERNALSYM DMUS_IO_INSTRUMENT}
  TDMusIoInstrument = _DMUS_IO_INSTRUMENT;

(*
// <DMBD-form> bands can be embedded in other forms
RIFF
(
    'DMBD'          // DirectMusic Band chunk
    [<guid-ck>]     // GUID for band
    [<vers-ck>]     // Optional version info
    [<UNFO-list>]   // Name, author, copyright info., comments
    <lbil-list>     // List of Instruments
)

    // <guid-ck>
    'guid'
    (
        <GUID>
    )

    // <vers-ck>
    vers
    (
        <DMUS_IO_VERSION>
    )

    // <lbil-list>
    LIST
    (
        'lbil'          // Array of instruments
        <lbin-list>...  // Each instrument is encapsulated in a list
    )

        // <lbin-list>
        LIST
        (
            'lbin'
            <bins-ck>
            [<DMRF-list>]       // Optional reference to DLS Collection file.
        )

            // <bins-ck>            // Instrument chunk
            (
                'bins'
                <DMUS_IO_INSTRUMENT>    // Instrument header
            )
*)

(* This RIFF id and io struct have been added to allow wave files (and the wave object) to
   differentiate between streaming and one-shot waves, and to give a prefetch for streaming
   waves  *)

const
  DMUS_FOURCC_WAVEHEADER_CHUNK = DWORD(Byte('w') or (Byte('a') shl 8) or (Byte('v') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('w','a','v','h')
  {$EXTERNALSYM DMUS_FOURCC_WAVEHEADER_CHUNK}

type
  PDMusIoWaveHeader = ^TDMusIoWaveHeader;
  _DMUS_IO_WAVE_HEADER = record
    rtReadAhead: TReferenceTime; (* How far ahead in the stream wave data will be read (in REFERENCE_TIME).  Ignored for one-shot waves. *)
    dwFlags: DWORD;              (* Various flags, including whether this is a streaming wave and whether it can be invalidated. *)
  end;
  {$EXTERNALSYM _DMUS_IO_WAVE_HEADER}
  DMUS_IO_WAVE_HEADER = _DMUS_IO_WAVE_HEADER;
  {$EXTERNALSYM DMUS_IO_WAVE_HEADER}
  TDMusIoWaveHeader = _DMUS_IO_WAVE_HEADER;


(*  File io for Wave track *)

const
(* RIFF ids: *)

  DMUS_FOURCC_WAVETRACK_LIST  = DWORD(Byte('w') or (Byte('a') shl 8) or (Byte('v') shl 16) or (Byte('t') shl 24)); // mmioFOURCC('w','a','v','t')
  {$EXTERNALSYM DMUS_FOURCC_WAVETRACK_LIST}
  DMUS_FOURCC_WAVETRACK_CHUNK = DWORD(Byte('w') or (Byte('a') shl 8) or (Byte('t') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('w','a','t','h')
  {$EXTERNALSYM DMUS_FOURCC_WAVETRACK_CHUNK}
  DMUS_FOURCC_WAVEPART_LIST   = DWORD(Byte('w') or (Byte('a') shl 8) or (Byte('v') shl 16) or (Byte('p') shl 24)); // mmioFOURCC('w','a','v','p')
  {$EXTERNALSYM DMUS_FOURCC_WAVEPART_LIST}
  DMUS_FOURCC_WAVEPART_CHUNK  = DWORD(Byte('w') or (Byte('a') shl 8) or (Byte('p') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('w','a','p','h')
  {$EXTERNALSYM DMUS_FOURCC_WAVEPART_CHUNK}
  DMUS_FOURCC_WAVEITEM_LIST   = DWORD(Byte('w') or (Byte('a') shl 8) or (Byte('v') shl 16) or (Byte('i') shl 24)); // mmioFOURCC('w','a','v','i')
  {$EXTERNALSYM DMUS_FOURCC_WAVEITEM_LIST}
  DMUS_FOURCC_WAVE_LIST       = DWORD(Byte('w') or (Byte('a') shl 8) or (Byte('v') shl 16) or (Byte('e') shl 24)); // mmioFOURCC('w','a','v','e')
  {$EXTERNALSYM DMUS_FOURCC_WAVE_LIST}
  DMUS_FOURCC_WAVEITEM_CHUNK  = DWORD(Byte('w') or (Byte('a') shl 8) or (Byte('i') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('w','a','i','h')
  {$EXTERNALSYM DMUS_FOURCC_WAVEITEM_CHUNK}

(* This flag is included in DMUS_IO_WAVE_TRACK_HEADER.dwFlags.  If set, the track will get its
   variations from a pattern track, via GetParam(GUID_Variations). *)
  DMUS_WAVETRACKF_SYNC_VAR   = $1;
  {$EXTERNALSYM DMUS_WAVETRACKF_SYNC_VAR}
(* This is also included in DMUS_IO_WAVE_TRACK_HEADER.dwFlags.  If set, variation control
   information will persist from one playback instance to the next.*)
  DMUS_WAVETRACKF_PERSIST_CONTROL = $2;
  {$EXTERNALSYM DMUS_WAVETRACKF_PERSIST_CONTROL}

type
  PDMusIoWaveTrackHeader = ^TDMusIoWaveTrackHeader;
  _DMUS_IO_WAVE_TRACK_HEADER = record
    lVolume: Longint;      (* Gain, in 1/100th of dB, to be applied to all waves.  Note:  All gain values should be negative. *)
    dwFlags: DWORD;        (* Flags, including whether this track syncs to a pattern track for its variations. *)
  end;
  {$EXTERNALSYM _DMUS_IO_WAVE_TRACK_HEADER}
  DMUS_IO_WAVE_TRACK_HEADER = _DMUS_IO_WAVE_TRACK_HEADER;
  {$EXTERNALSYM DMUS_IO_WAVE_TRACK_HEADER}
  TDMusIoWaveTrackHeader = _DMUS_IO_WAVE_TRACK_HEADER;

  PDMusIoWavePartHeader = ^TDMusIoWavePartHeader;
  _DMUS_IO_WAVE_PART_HEADER = record
    lVolume: Longint;      (* Gain, in 1/100th of dB, to be applied to all waves in wave part.  Note:  All gain values should be negative. *)
    dwVariations: DWORD;   (* Variation mask for which of 32 variations *)
    dwPChannel: DWORD;     (* PChannel *)
    dwLockToPart: DWORD;   (* Part ID to lock to. *)
    dwFlags: DWORD;        (* Flags, including stuff for managing how variations are chosen (in low-order nibble) *)
    dwIndex: DWORD;        (* Index for distinguishing multiple parts on the same PChannel*)
  end;
  {$EXTERNALSYM _DMUS_IO_WAVE_PART_HEADER}
  DMUS_IO_WAVE_PART_HEADER = _DMUS_IO_WAVE_PART_HEADER;
  {$EXTERNALSYM DMUS_IO_WAVE_PART_HEADER}
  TDMusIoWavePartHeader = _DMUS_IO_WAVE_PART_HEADER;

  PDMusIoWaveItemHeader = ^TDMusIoWaveItemHeader;
  _DMUS_IO_WAVE_ITEM_HEADER = record
    lVolume: Longint;               (* Gain, in 1/100th of dB.  Note:  All gain values should be negative. *)
    lPitch: Longint;                (* Pitch offset in 1/100th of a semitone. *)
    dwVariations: DWORD;            (* Variation flags for which of 32 variations this wave belongs to. *)
    rtTime: TReferenceTime;         (* Start time, in REFERENCE_TIME, if clock time track, or MUSIC_TIME for music time track. *)
    rtStartOffset: TReferenceTime;  (* Distance into wave to start playback, in reference time units. *)
    rtReserved: TReferenceTime;     (* Reserved field. *)
    rtDuration: TReferenceTime;     (* Duration, in REFERENCE_TIME or MUSIC_TIME, depending on track timing format. *)
    mtLogicalTime: TMusicTime;      (* If in music track format, this indicates the musical boundary where this belongs. Otherwise, ignored. *)
    dwLoopStart: DWORD;             (* Start point for a looping wave. *)
    dwLoopEnd: DWORD;               (* End point for a looping wave. *)
    dwFlags: DWORD;                 (* Various flags, including whether this is a streaming wave and whether it can be invalidated. *)
    wVolumeRange: Word;             (* Random range for volume. *)
    wPitchRange: Word;              (* Random range for pitch. *)
  end;
  {$EXTERNALSYM _DMUS_IO_WAVE_ITEM_HEADER}
  DMUS_IO_WAVE_ITEM_HEADER = _DMUS_IO_WAVE_ITEM_HEADER;
  {$EXTERNALSYM DMUS_IO_WAVE_ITEM_HEADER}
  TDMusIoWaveItemHeader = _DMUS_IO_WAVE_ITEM_HEADER;

(*
LIST
{
    'wavt'          // Wave track chunk
    <wath-ck>       // Wave track header
    <wavp-list>...  // Array of Wave Parts
}
    // <wath-ck>
    'wath'
    {
        <DMUS_IO_WAVE_TRACK_HEADER>
    }

    //  <wavp-list>
    LIST
    {
        'wavp'
        <waph-ck>       //  Wave Part Header
        <wavi-list>     //  List of wave items
    }

        //  <waph-ck>
        'waph'
        {
            <DMUS_IO_WAVE_PART_HEADER>
        }

        //  <wavi-list>
        LIST
        {
            'wavi'
            <wave-list>...  //  Array of waves; each wave is encapsulated in a list
        }

            //  <wave-list>
            LIST
            {
                'wave'
                <waih-ck>       //  Wave item header
                <DMRF-list>     //  Reference to wave object
            }

                //  <waih-ck>
                'waih'
                {
                    <DMUS_IO_WAVE_ITEM_HEADER>
                }

*)

(*  File io for DirectMusic Container file. This embeds a set of related files. And,
    in turn, it can be embedded within a segment or script file.
*)

const
  DMUS_FOURCC_CONTAINER_FORM         = DWORD(Byte('D') or (Byte('M') shl 8) or (Byte('C') shl 16) or (Byte('N') shl 24)); // mmioFOURCC('D','M','C','N')
  {$EXTERNALSYM DMUS_FOURCC_CONTAINER_FORM}
  DMUS_FOURCC_CONTAINER_CHUNK        = DWORD(Byte('c') or (Byte('o') shl 8) or (Byte('n') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('c','o','n','h')
  {$EXTERNALSYM DMUS_FOURCC_CONTAINER_CHUNK}
  DMUS_FOURCC_CONTAINED_ALIAS_CHUNK  = DWORD(Byte('c') or (Byte('o') shl 8) or (Byte('b') shl 16) or (Byte('a') shl 24)); // mmioFOURCC('c','o','b','a')
  {$EXTERNALSYM DMUS_FOURCC_CONTAINED_ALIAS_CHUNK}
  DMUS_FOURCC_CONTAINED_OBJECT_CHUNK = DWORD(Byte('c') or (Byte('o') shl 8) or (Byte('b') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('c','o','b','h')
  {$EXTERNALSYM DMUS_FOURCC_CONTAINED_OBJECT_CHUNK}
  DMUS_FOURCC_CONTAINED_OBJECTS_LIST = DWORD(Byte('c') or (Byte('o') shl 8) or (Byte('s') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('c','o','s','l')
  {$EXTERNALSYM DMUS_FOURCC_CONTAINED_OBJECTS_LIST}
  DMUS_FOURCC_CONTAINED_OBJECT_LIST  = DWORD(Byte('c') or (Byte('o') shl 8) or (Byte('b') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('c','o','b','l')
  {$EXTERNALSYM DMUS_FOURCC_CONTAINED_OBJECT_LIST}

type
  PDMusIoContainerHeader = ^TDMusIoContainerHeader;
  _DMUS_IO_CONTAINER_HEADER = record
    dwFlags: DWORD;        (* Flags. *)
  end;
  {$EXTERNALSYM _DMUS_IO_CONTAINER_HEADER}
  DMUS_IO_CONTAINER_HEADER = _DMUS_IO_CONTAINER_HEADER;
  {$EXTERNALSYM DMUS_IO_CONTAINER_HEADER}
  TDMusIoContainerHeader = _DMUS_IO_CONTAINER_HEADER;


const
  DMUS_CONTAINER_NOLOADS  = (1 shl 1);  (* Contained items are not loaded when the container is loaded.
                                           Entries will be created in the loader (via SetObject) but
                                           the actual objects will not be created until they are
                                           specifically loaded at a later time. *)
  {$EXTERNALSYM DMUS_CONTAINER_NOLOADS}

type
  PDMusIoContainedObjectHeader = ^TDMusIoContainedObjectHeader;
  _DMUS_IO_CONTAINED_OBJECT_HEADER = record
    guidClassID: TGUID;    (* Class id of object. *)
    dwFlags: DWORD;        (* Flags, for example DMUS_CONTAINED_OBJF_KEEP. *)
    ckid: FOURCC;          (* chunk ID of track's data chunk if 0 fccType valid. *)
    fccType: FOURCC;       (* list type if NULL ckid valid */
        (* Note that LIST:DMRF may be used for ckid and fccType in order to reference an
           object instead of embedding it within the container. *)
  end;
  {$EXTERNALSYM _DMUS_IO_CONTAINED_OBJECT_HEADER}
  DMUS_IO_CONTAINED_OBJECT_HEADER = _DMUS_IO_CONTAINED_OBJECT_HEADER;
  {$EXTERNALSYM DMUS_IO_CONTAINED_OBJECT_HEADER}
  TDMusIoContainedObjectHeader = _DMUS_IO_CONTAINED_OBJECT_HEADER;

const
  DMUS_CONTAINED_OBJF_KEEP    = 1;   (* Keep the object cached in the loader after the container is released. *)
  {$EXTERNALSYM DMUS_CONTAINED_OBJF_KEEP}

(*
RIFF
(
    'DMCN'          // DirectMusic Container chunk
    <conh-ck>       // Container header chunk
    [<guid-ck>]     // GUID for container
    [<vers-ck>]     // Optional version info
    [<UNFO-list>]   // Name, author, copyright info., comments
    <cosl-list>     // List of objects.
)

    // <conh-ck>
    'conh'
    (
        <DMUS_IO_CONTAINER_HEADER>
    )

    // <guid-ck>
    'guid'
    (
        <GUID>
    )

    // <vers-ck>
    vers
    (
        <DMUS_IO_VERSION>
    )

    LIST
    (
        'cosl'          // Array of embedded objects.
        <cobl-list>...  // Each object is encapsulated in a LIST chunk
    )

    // <cobl-list>      // Encapsulates one object
    LIST
    (
        'cobl'
        [<coba-ck>]         // Alias.  An alternative name by which this object is known
                            // within the container.
        <cobh-ck>           // Required header, includes CLASS ID for object.
        [<data>] or <DMRF>  // Object data of the type specified in <cobh-ck>.
                            // If DMRF, it is a reference of where to find the object.
                            // Otherwise, it could be any RIFF readable chunk in the
                            //    exact same format as a file.  The object will load
                            //    itself from this data.
    )

    // <coba-ck>
    'coba'
    (
        // Alias, stored as NULL terminated string of WCHARs
    )

    // <cobh-ck>
    'cobh'
    (
        <DMUS_IO_CONTAINED_OBJECT_HEADER>
    )
*)

(*  File io for DirectMusic Segment object *)

(* RIFF ids: *)

const
  DMUS_FOURCC_SEGMENT_FORM  = DWORD(Byte('D') or (Byte('M') shl 8) or (Byte('S') shl 16) or (Byte('G') shl 24)); // mmioFOURCC('D','M','S','G')
  {$EXTERNALSYM DMUS_FOURCC_SEGMENT_FORM}
  DMUS_FOURCC_SEGMENT_CHUNK = DWORD(Byte('s') or (Byte('e') shl 8) or (Byte('g') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('s','e','g','h')
  {$EXTERNALSYM DMUS_FOURCC_SEGMENT_CHUNK}
  DMUS_FOURCC_TRACK_LIST    = DWORD(Byte('t') or (Byte('r') shl 8) or (Byte('k') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('t','r','k','l')
  {$EXTERNALSYM DMUS_FOURCC_TRACK_LIST}
  DMUS_FOURCC_TRACK_FORM    = DWORD(Byte('D') or (Byte('M') shl 8) or (Byte('T') shl 16) or (Byte('K') shl 24)); // mmioFOURCC('D','M','T','K')
  {$EXTERNALSYM DMUS_FOURCC_TRACK_FORM}
  DMUS_FOURCC_TRACK_CHUNK   = DWORD(Byte('t') or (Byte('r') shl 8) or (Byte('k') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('t','r','k','h')
  {$EXTERNALSYM DMUS_FOURCC_TRACK_CHUNK}
  DMUS_FOURCC_TRACK_EXTRAS_CHUNK = DWORD(Byte('t') or (Byte('r') shl 8) or (Byte('k') shl 16) or (Byte('x') shl 24)); // mmioFOURCC('t','r','k','x')
  {$EXTERNALSYM DMUS_FOURCC_TRACK_EXTRAS_CHUNK}

  (* io structures:*)

type
  PDMusIoSegmentHeader = ^TDMusIoSegmentHeader;
  _DMUS_IO_SEGMENT_HEADER = record
    dwRepeats: DWORD;           (* Number of repeats. By default, 0. *)
    mtLength: TMusicTime;       (* Length, in music time. *)
    mtPlayStart: TMusicTime;    (* Start of playback. By default, 0. *)
    mtLoopStart: TMusicTime;    (* Start of looping portion. By default, 0. *)
    mtLoopEnd: TMusicTime;      (* End of loop. Must be greater than dwPlayStart. Or, 0, indicating loop full segment. *)
    dwResolution: DWORD;        (* Default resolution. *)
    // Following added for DirectX8:
    rtLength: TReferenceTime;   (* Length, in reference time (overrides music time length.) *)
    dwFlags: DWORD;
    dwReserved: DWORD;          (* Reserved. *)
    // Added for DirectX9:
    rtLoopStart: TReferenceTime; (* Clock time loop start. *)
    rtLoopEnd: TReferenceTime;   (* Clock time loop end. *)
    rtPlayStart: TReferenceTime; (* Start of playback in clock time. *) 
  end;
  {$EXTERNALSYM _DMUS_IO_SEGMENT_HEADER}
  DMUS_IO_SEGMENT_HEADER = _DMUS_IO_SEGMENT_HEADER;
  {$EXTERNALSYM DMUS_IO_SEGMENT_HEADER}
  TDMusIoSegmentHeader = _DMUS_IO_SEGMENT_HEADER;

const
  DMUS_SEGIOF_REFLENGTH = 1;  // Use the time in rtLength for the segment length.
  {$EXTERNALSYM DMUS_SEGIOF_REFLENGTH}
  DMUS_SEGIOF_CLOCKTIME = 2;  // This is a clock time segment.
  {$EXTERNALSYM DMUS_SEGIOF_CLOCKTIME}

type
  PDMusIoTrackHeader = ^TDMusIoTrackHeader;
  _DMUS_IO_TRACK_HEADER = record
    guidClassID: TGUID;    (* Class id of track. *)
    dwPosition: DWORD;     (* Position in track list. *)
    dwGroup: DWORD;        (* Group bits for track. *)
    ckid: FOURCC;          (* chunk ID of track's data chunk. *)
    fccType: FOURCC;       (* list type if ckid is RIFF or LIST *)
  end;
  {$EXTERNALSYM _DMUS_IO_TRACK_HEADER}
  DMUS_IO_TRACK_HEADER = _DMUS_IO_TRACK_HEADER;
  {$EXTERNALSYM DMUS_IO_TRACK_HEADER}
  TDMusIoTrackHeader = _DMUS_IO_TRACK_HEADER;

(*  Additional parameters for the track header chunk, introduced in DirectX8 and
    on, are stored in a separate chunk. *)

  PDMusIoTrackExtrasHeader = ^TDMusIoTrackExtrasHeader;
  _DMUS_IO_TRACK_EXTRAS_HEADER = record
    dwFlags: DWORD;        (* DirectX8 Added flags for control tracks. *)
    dwPriority: DWORD;     (* Priority for composition. *)
  end;
  {$EXTERNALSYM _DMUS_IO_TRACK_EXTRAS_HEADER}
  DMUS_IO_TRACK_EXTRAS_HEADER = _DMUS_IO_TRACK_EXTRAS_HEADER;
  {$EXTERNALSYM DMUS_IO_TRACK_EXTRAS_HEADER}
  TDMusIoTrackExtrasHeader = _DMUS_IO_TRACK_EXTRAS_HEADER;

(*
RIFF
(
    'DMSG'          // DirectMusic Segment chunk
    <segh-ck>       // Segment header chunk
    [<guid-ck>]     // GUID for segment
    [<vers-ck>]     // Optional version info
    [<UNFO-list>]   // Name, author, copyright info., comments
    [<DMCN-form>]   // Optional container of objects embedded in file. Must precede tracklist.
    <trkl-list>     // List of Tracks
    [<DMTG-form>]   // Optional ToolGraph
    [<DMAP-form>]   // Optional Audio Path
)

    // <segh-ck>        
    'segh'
    (
        <DMUS_IO_SEGMENT_HEADER>
    )
    
    // <guid-ck>
    'guid'
    (
        <GUID>
    )

    // <vers-ck>
    vers
    (
        <DMUS_IO_VERSION>
    )

    // <trkl-list>
    LIST
    (
        'trkl'          // Array of tracks
        <DMTK-form>...  // Each track is encapsulated in a RIFF chunk
    )

    // <DMTK-form>      // Tracks can be embedded in a segment or stored as separate files.
    RIFF
    (
        'DMTK'
        <trkh-ck>
        [<trkx-ck>]     // Optional track flags.
        [<guid-ck>]     // Optional GUID for track object instance (not to be confused with Class id in track header)
        [<vers-ck>]     // Optional version info
        [<UNFO-list>]   // Optional name, author, copyright info., comments
        [<data>]        // Track data. Must be a RIFF readable chunk.
    )

    // <trkh-ck>            // Track header chunk
    (
        'trkh'
        <DMUS_IO_TRACK_HEADER>  // Track header
    )

    // <trkx-ck>            // Track flags chunk
    (
        'trkx'
        <DMUS_IO_TRACK_EXTRAS_HEADER>  // DirectX8 Track flags header
    )
*)

(*  File io for DirectMusic reference chunk.
    This is used to embed a reference to an object.
*)

const
  (*  RIFF ids: *)

  DMUS_FOURCC_REF_LIST   = DWORD(Byte('D') or (Byte('M') shl 8) or (Byte('R') shl 16) or (Byte('F') shl 24)); // mmioFOURCC('D','M','R','F')
  {$EXTERNALSYM DMUS_FOURCC_REF_LIST}
  DMUS_FOURCC_REF_CHUNK  = DWORD(Byte('r') or (Byte('e') shl 8) or (Byte('f') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('r','e','f','h')
  {$EXTERNALSYM DMUS_FOURCC_REF_CHUNK}
  DMUS_FOURCC_DATE_CHUNK = DWORD(Byte('d') or (Byte('a') shl 8) or (Byte('t') shl 16) or (Byte('e') shl 24)); // mmioFOURCC('d','a','t','e')
  {$EXTERNALSYM DMUS_FOURCC_DATE_CHUNK}
  DMUS_FOURCC_NAME_CHUNK = DWORD(Byte('n') or (Byte('a') shl 8) or (Byte('m') shl 16) or (Byte('e') shl 24)); // mmioFOURCC('n','a','m','e')
  {$EXTERNALSYM DMUS_FOURCC_NAME_CHUNK}
  DMUS_FOURCC_FILE_CHUNK = DWORD(Byte('f') or (Byte('i') shl 8) or (Byte('l') shl 16) or (Byte('e') shl 24)); // mmioFOURCC('f','i','l','e')
  {$EXTERNALSYM DMUS_FOURCC_FILE_CHUNK}

type
  PDMusIoReference = ^TDMusIoReference;
  _DMUS_IO_REFERENCE = record
    guidClassID: TGUID;    (* Class id is always required. *)
    dwValidData: DWORD;    (* Flags. *)
  end;
  {$EXTERNALSYM _DMUS_IO_REFERENCE}
  DMUS_IO_REFERENCE = _DMUS_IO_REFERENCE;
  {$EXTERNALSYM DMUS_IO_REFERENCE}
  TDMusIoReference = _DMUS_IO_REFERENCE;

(*
LIST
(
    'DMRF'          // DirectMusic Reference chunk
    <refh-ck>       // Reference header chunk
    [<guid-ck>]     // Optional object GUID.
    [<date-ck>]     // Optional file date.
    [<name-ck>]     // Optional name.
    [<file-ck>]     // Optional file name.
    [<catg-ck>]     // Optional category name.
    [<vers-ck>]     // Optional version info.
)

    // <refh-ck>
    'refh'
    (
        <DMUS_IO_REFERENCE>
    )

    // <guid-ck>
    'guid'
    (
        <GUID>
    )

    // <date-ck>
    date
    (
        <FILETIME>
    )

    // <name-ck>
    name
    (
        // Name, stored as NULL terminated string of WCHARs
    )

    // <file-ck>
    file
    (
        // File name, stored as NULL terminated string of WCHARs
    )

    // <catg-ck>
    catg
    (
        // Category name, stored as NULL terminated string of WCHARs
    )

    // <vers-ck>
    vers
    (
        <DMUS_IO_VERSION>
    )
*)

const
  (* Chord Maps *)

  (* runtime chunks *)
  DMUS_FOURCC_CHORDMAP_FORM      = DWORD(Byte('D') or (Byte('M') shl 8) or (Byte('P') shl 16) or (Byte('R') shl 24)); // mmioFOURCC('D','M','P','R')
  {$EXTERNALSYM DMUS_FOURCC_CHORDMAP_FORM}
  DMUS_FOURCC_IOCHORDMAP_CHUNK   = DWORD(Byte('p') or (Byte('e') shl 8) or (Byte('r') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('p','e','r','h')
  {$EXTERNALSYM DMUS_FOURCC_IOCHORDMAP_CHUNK}
  DMUS_FOURCC_SUBCHORD_CHUNK     = DWORD(Byte('c') or (Byte('h') shl 8) or (Byte('d') shl 16) or (Byte('t') shl 24)); // mmioFOURCC('c','h','d','t')
  {$EXTERNALSYM DMUS_FOURCC_SUBCHORD_CHUNK}
  DMUS_FOURCC_CHORDENTRY_CHUNK   = DWORD(Byte('c') or (Byte('h') shl 8) or (Byte('e') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('c','h','e','h')
  {$EXTERNALSYM DMUS_FOURCC_CHORDENTRY_CHUNK}
  DMUS_FOURCC_SUBCHORDID_CHUNK   = DWORD(Byte('s') or (Byte('b') shl 8) or (Byte('c') shl 16) or (Byte('n') shl 24)); // mmioFOURCC('s','b','c','n')
  {$EXTERNALSYM DMUS_FOURCC_SUBCHORDID_CHUNK}
  DMUS_FOURCC_IONEXTCHORD_CHUNK  = DWORD(Byte('n') or (Byte('c') shl 8) or (Byte('r') shl 16) or (Byte('d') shl 24)); // mmioFOURCC('n','c','r','d')
  {$EXTERNALSYM DMUS_FOURCC_IONEXTCHORD_CHUNK}
  DMUS_FOURCC_NEXTCHORDSEQ_CHUNK = DWORD(Byte('n') or (Byte('c') shl 8) or (Byte('s') shl 16) or (Byte('q') shl 24)); // mmioFOURCC('n','c','s','q')
  {$EXTERNALSYM DMUS_FOURCC_NEXTCHORDSEQ_CHUNK}
  DMUS_FOURCC_IOSIGNPOST_CHUNK   = DWORD(Byte('s') or (Byte('p') shl 8) or (Byte('s') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('s','p','s','h')
  {$EXTERNALSYM DMUS_FOURCC_IOSIGNPOST_CHUNK}
  DMUS_FOURCC_CHORDNAME_CHUNK    = DWORD(Byte('I') or (Byte('N') shl 8) or (Byte('A') shl 16) or (Byte('M') shl 24)); // mmioFOURCC('I','N','A','M')
  {$EXTERNALSYM DMUS_FOURCC_CHORDNAME_CHUNK}

  (* runtime list chunks *)
  DMUS_FOURCC_CHORDENTRY_LIST    = DWORD(Byte('c') or (Byte('h') shl 8) or (Byte('o') shl 16) or (Byte('e') shl 24)); // mmioFOURCC('c','h','o','e')
  {$EXTERNALSYM DMUS_FOURCC_CHORDENTRY_LIST}
  DMUS_FOURCC_CHORDMAP_LIST      = DWORD(Byte('c') or (Byte('m') shl 8) or (Byte('a') shl 16) or (Byte('p') shl 24)); // mmioFOURCC('c','m','a','p')
  {$EXTERNALSYM DMUS_FOURCC_CHORDMAP_LIST}
  DMUS_FOURCC_CHORD_LIST         = DWORD(Byte('c') or (Byte('h') shl 8) or (Byte('r') shl 16) or (Byte('d') shl 24)); // mmioFOURCC('c','h','r','d')
  {$EXTERNALSYM DMUS_FOURCC_CHORD_LIST}
  DMUS_FOURCC_CHORDPALETTE_LIST  = DWORD(Byte('c') or (Byte('h') shl 8) or (Byte('p') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('c','h','p','l')
  {$EXTERNALSYM DMUS_FOURCC_CHORDPALETTE_LIST}
  DMUS_FOURCC_CADENCE_LIST       = DWORD(Byte('c') or (Byte('a') shl 8) or (Byte('d') shl 16) or (Byte('e') shl 24)); // mmioFOURCC('c','a','d','e')
  {$EXTERNALSYM DMUS_FOURCC_CADENCE_LIST}
  DMUS_FOURCC_SIGNPOSTITEM_LIST  = DWORD(Byte('s') or (Byte('p') shl 8) or (Byte('s') shl 16) or (Byte('t') shl 24)); // mmioFOURCC('s','p','s','t')
  {$EXTERNALSYM DMUS_FOURCC_SIGNPOSTITEM_LIST}

  DMUS_FOURCC_SIGNPOST_LIST      = DWORD(Byte('s') or (Byte('p') shl 8) or (Byte('s') shl 16) or (Byte('q') shl 24)); // mmioFOURCC('s','p','s','q')
  {$EXTERNALSYM DMUS_FOURCC_SIGNPOST_LIST}

  (* values for dwChord field of DMUS_IO_PERS_SIGNPOST *)
  (* DMUS_SIGNPOSTF_ flags are also used in templates (DMUS_IO_SIGNPOST) *)
  DMUS_SIGNPOSTF_A        = 1;
  {$EXTERNALSYM DMUS_SIGNPOSTF_A}
  DMUS_SIGNPOSTF_B        = 2;
  {$EXTERNALSYM DMUS_SIGNPOSTF_B}
  DMUS_SIGNPOSTF_C        = 4;
  {$EXTERNALSYM DMUS_SIGNPOSTF_C}
  DMUS_SIGNPOSTF_D        = 8;
  {$EXTERNALSYM DMUS_SIGNPOSTF_D}
  DMUS_SIGNPOSTF_E        = $10;
  {$EXTERNALSYM DMUS_SIGNPOSTF_E}
  DMUS_SIGNPOSTF_F        = $20;
  {$EXTERNALSYM DMUS_SIGNPOSTF_F}
  DMUS_SIGNPOSTF_LETTER   = (DMUS_SIGNPOSTF_A or DMUS_SIGNPOSTF_B or DMUS_SIGNPOSTF_C or DMUS_SIGNPOSTF_D or DMUS_SIGNPOSTF_E or DMUS_SIGNPOSTF_F);
  {$EXTERNALSYM DMUS_SIGNPOSTF_LETTER}
  DMUS_SIGNPOSTF_1        = $100;
  {$EXTERNALSYM DMUS_SIGNPOSTF_1}
  DMUS_SIGNPOSTF_2        = $200;
  {$EXTERNALSYM DMUS_SIGNPOSTF_2}
  DMUS_SIGNPOSTF_3        = $400;
  {$EXTERNALSYM DMUS_SIGNPOSTF_3}
  DMUS_SIGNPOSTF_4        = $800;
  {$EXTERNALSYM DMUS_SIGNPOSTF_4}
  DMUS_SIGNPOSTF_5        = $1000;
  {$EXTERNALSYM DMUS_SIGNPOSTF_5}
  DMUS_SIGNPOSTF_6        = $2000;
  {$EXTERNALSYM DMUS_SIGNPOSTF_6}
  DMUS_SIGNPOSTF_7        = $4000;
  {$EXTERNALSYM DMUS_SIGNPOSTF_7}
  DMUS_SIGNPOSTF_ROOT     = (DMUS_SIGNPOSTF_1 or DMUS_SIGNPOSTF_2 or DMUS_SIGNPOSTF_3 or DMUS_SIGNPOSTF_4 or DMUS_SIGNPOSTF_5 or DMUS_SIGNPOSTF_6 or DMUS_SIGNPOSTF_7);
  {$EXTERNALSYM DMUS_SIGNPOSTF_ROOT}
  DMUS_SIGNPOSTF_CADENCE  = $8000;
  {$EXTERNALSYM DMUS_SIGNPOSTF_CADENCE}

  // values for dwFlags field of DMUS_IO_CHORDMAP
  DMUS_CHORDMAPF_VERSION8  = 1;   // Chordmap is version 8 or above.
  {$EXTERNALSYM DMUS_CHORDMAPF_VERSION8}

  // values for dwChord field of DMUS_IO_PERS_SIGNPOST
  DMUS_SPOSTCADENCEF_1  = 2;   // Use the first cadence chord.
  {$EXTERNALSYM DMUS_SPOSTCADENCEF_1}
  DMUS_SPOSTCADENCEF_2  = 4;   // Use the second cadence chord.
  {$EXTERNALSYM DMUS_SPOSTCADENCEF_2}

type  
  // run time data structs
  PDMusIoChordMap = ^TDMusIoChordMap;
  _DMUS_IO_CHORDMAP = record
    wszLoadName: array[0..19] of WideChar;
    dwScalePattern: DWORD;
    dwFlags: DWORD;           // Various flags. Only lower 16 bits are significant.
  end;
  {$EXTERNALSYM _DMUS_IO_CHORDMAP}
  DMUS_IO_CHORDMAP = _DMUS_IO_CHORDMAP;
  {$EXTERNALSYM DMUS_IO_CHORDMAP}
  TDMusIoChordMap = _DMUS_IO_CHORDMAP;

  PDMusIoChordmapSubChord = ^TDMusIoChordmapSubChord;
  _DMUS_IO_CHORDMAP_SUBCHORD = record
    dwChordPattern: DWORD;
    dwScalePattern: DWORD;
    dwInvertPattern: DWORD;
    bChordRoot: Byte;
    bScaleRoot: Byte;
    wCFlags: Word;
    dwLevels: DWORD;   // parts or which subchord levels this chord supports 
  end;
  {$EXTERNALSYM _DMUS_IO_CHORDMAP_SUBCHORD}
  DMUS_IO_CHORDMAP_SUBCHORD = _DMUS_IO_CHORDMAP_SUBCHORD;
  {$EXTERNALSYM DMUS_IO_CHORDMAP_SUBCHORD}
  TDMusIoChordmapSubChord = _DMUS_IO_CHORDMAP_SUBCHORD;

  // Legacy name...
  DMUS_IO_PERS_SUBCHORD = DMUS_IO_CHORDMAP_SUBCHORD;
  {$EXTERNALSYM DMUS_IO_PERS_SUBCHORD}

  PDMusIoChordEntry = ^TDMusIoChordEntry;
  _DMUS_IO_CHORDENTRY = record
    dwFlags: DWORD;
    wConnectionID: Word;  // replaces runtime "pointer to this"
  end;
  {$EXTERNALSYM _DMUS_IO_CHORDENTRY}
  DMUS_IO_CHORDENTRY = _DMUS_IO_CHORDENTRY;
  {$EXTERNALSYM DMUS_IO_CHORDENTRY}
  TDMusIoChordEntry = _DMUS_IO_CHORDENTRY;

  PDMusIoNextChord = ^TDMusIoNextChord;
  _DMUS_IO_NEXTCHORD = record
    dwFlags: DWORD;
    nWeight: Word;
    wMinBeats: Word;
    wMaxBeats: Word;
    wConnectionID: Word;  // points to an ioChordEntry
  end;
  {$EXTERNALSYM _DMUS_IO_NEXTCHORD}
  DMUS_IO_NEXTCHORD = _DMUS_IO_NEXTCHORD;
  {$EXTERNALSYM DMUS_IO_NEXTCHORD}
  TDMusIoNextChord = _DMUS_IO_NEXTCHORD;

  PDMusIoChordMapSignPost = ^TDMusIoChordMapSignPost;
  _DMUS_IO_CHORDMAP_SIGNPOST = record
    dwChords: DWORD;   // 1bit per group
    dwFlags: DWORD;
  end;
  {$EXTERNALSYM _DMUS_IO_CHORDMAP_SIGNPOST}
  DMUS_IO_CHORDMAP_SIGNPOST = _DMUS_IO_CHORDMAP_SIGNPOST;
  {$EXTERNALSYM DMUS_IO_CHORDMAP_SIGNPOST}
  TDMusIoChordMapSignPost = _DMUS_IO_CHORDMAP_SIGNPOST;

  // Legacy name...
  DMUS_IO_PERS_SIGNPOST = DMUS_IO_CHORDMAP_SIGNPOST;
  {$EXTERNALSYM DMUS_IO_PERS_SIGNPOST}

(*
RIFF
(
    'DMPR'
    <perh-ck>           // Chord map header chunk
    [<guid-ck>]         // guid chunk
    [<vers-ck>]         // version chunk (two DWORDS)
    [<UNFO-list>]       // Unfo chunk
    <chdt-ck>           // subchord database
    <chpl-list>         // chord palette
    <cmap-list>         // chord map
    <spsq-list>         // signpost list
 )

<cmap-list> ::= LIST('cmap' <choe-list> )

<choe-list> ::= LIST('choe'
                                <cheh-ck>   // chord entry data
                                <chrd-list> // chord definition
                                <ncsq-ck>   // connecting(next) chords
                     )

<chrd-list> ::= LIST('chrd' 
                                <INAM-ck>   // name of chord in wide char format
                                <sbcn-ck>   // list of subchords composing chord
                    )

<chpl-list> ::= LIST('chpl' 
                                <chrd-list> ... // chord definition
                    )

<spsq-list> ::== LIST('spsq' <spst-list> ... )

<spst-list> ::= LIST('spst'
                             <spsh-ck>
                             <chrd-list>
                             [<cade-list>]
                    )

<cade-list> ::= LIST('cade' <chrd-list> ...)

<perh-ck> ::= perh(<DMUS_IO_CHORDMAP>)

<chdt-ck> ::= chdt(<cbChordSize::WORD>
                   <DMUS_IO_PERS_SUBCHORD> ... )

<cheh-ck> ::= cheh(<DMUS_IO_CHORDENTRY>)

<sbcn-ck> ::= sbcn(<cSubChordID:WORD> ...)

<ncsq-ck> ::= ncsq(<wNextChordSize:WORD>
                   <DMUS_IO_NEXTCHORD>...)

<spsh-ck> ::= spsh(<DMUS_IO_PERS_SIGNPOST>)

*)

(*  File io for DirectMusic Script object *)

const
  (* RIFF ids: *)

  DMUS_FOURCC_SCRIPT_FORM          = DWORD(Byte('D') or (Byte('M') shl 8) or (Byte('S') shl 16) or (Byte('C') shl 24)); // mmioFOURCC('D','M','S','C')
  {$EXTERNALSYM DMUS_FOURCC_SCRIPT_FORM}
  DMUS_FOURCC_SCRIPT_CHUNK         = DWORD(Byte('s') or (Byte('c') shl 8) or (Byte('h') shl 16) or (Byte('d') shl 24)); // mmioFOURCC('s','c','h','d')
  {$EXTERNALSYM DMUS_FOURCC_SCRIPT_CHUNK}
  DMUS_FOURCC_SCRIPTVERSION_CHUNK  = DWORD(Byte('s') or (Byte('c') shl 8) or (Byte('v') shl 16) or (Byte('e') shl 24)); // mmioFOURCC('s','c','v','e')
  {$EXTERNALSYM DMUS_FOURCC_SCRIPTVERSION_CHUNK}
  DMUS_FOURCC_SCRIPTLANGUAGE_CHUNK = DWORD(Byte('s') or (Byte('c') shl 8) or (Byte('l') shl 16) or (Byte('a') shl 24)); // mmioFOURCC('s','c','l','a')
  {$EXTERNALSYM DMUS_FOURCC_SCRIPTLANGUAGE_CHUNK}
  DMUS_FOURCC_SCRIPTSOURCE_CHUNK   = DWORD(Byte('s') or (Byte('c') shl 8) or (Byte('s') shl 16) or (Byte('r') shl 24)); // mmioFOURCC('s','c','s','r')
  {$EXTERNALSYM DMUS_FOURCC_SCRIPTSOURCE_CHUNK}

type
  (* io structures: *)

  PDMusIoScriptHeader = ^TDMusIoScriptHeader;
  _DMUS_IO_SCRIPT_HEADER = record
    dwFlags: DWORD; // DMUS_SCRIPTIOF_ flags
  end;
  {$EXTERNALSYM _DMUS_IO_SCRIPT_HEADER}
  DMUS_IO_SCRIPT_HEADER = _DMUS_IO_SCRIPT_HEADER;
  {$EXTERNALSYM DMUS_IO_SCRIPT_HEADER}
  TDMusIoScriptHeader = _DMUS_IO_SCRIPT_HEADER;

const
  DMUS_SCRIPTIOF_LOAD_ALL_CONTENT       = (1 shl 0);
  {$EXTERNALSYM DMUS_SCRIPTIOF_LOAD_ALL_CONTENT}
    // If set, when the script loads it will also load all the content in its container.
  DMUS_SCRIPTIOF_DOWNLOAD_ALL_SEGMENTS  = (1 shl 1);
  {$EXTERNALSYM DMUS_SCRIPTIOF_DOWNLOAD_ALL_SEGMENTS}
    (* If set and LOAD_ALL_CONTENT is also set, when the script initializes it will also download all the segments in its container.
       If set and LOAD_ALL_CONTENT is not set, when the script calls segment.Load on a segment then the segment will also be downloaded.
       If not set, the script must manually download and unload by calling segment.DownloadSoundData and segment.UnloadSoundData. *)

(*
RIFF
(
    'DMSC'              // DirectMusic Script chunk
    <schd-ck>           // Script header chunk
    [<guid-ck>]         // GUID for script
    [<vers-ck>]         // Optional version info
    [<UNFO-list>]       // Name, author, copyright info., comments
    <scve-ck>           // Version of DirectMusic this script was authored to run against
    <DMCN-form>         // Container of content referenced by the script.
    <scla-ck>           // ActiveX scripting language in which the script is written
    <scsr-ck> or <DMRF> // The script's source code.
                        // If scsr-ck, the source is embedding in the chunk.
                        // If DMRF, it is a reference of where to find a text file with the source.
                        //    Class id (guidClassID in DMUS_IO_REFERENCE) must be GUID_NULL because
                        //    this text file is not a DirectMusic object in its own right.
)

    // <schd-ck>
    'schd'
    (
        <DMUS_FOURCC_SCRIPT_CHUNK>
    )

    // <guid-ck>
    'guid'
    (
        <GUID>
    )

    // <vers-ck>
    vers
    (
        <DMUS_IO_VERSION>
    )

    // <scve-ck>
    scve
    (
        <DMUS_IO_VERSION>
    )

    'scla'
    (
        // Language name, stored as NULL terminated string of WCHARs
    )

    'scsr'
    (
        // Source code, stored as NULL terminated string of WCHARs
    )
*)

const
  (* Signpost tracks *)

  DMUS_FOURCC_SIGNPOST_TRACK_CHUNK = DWORD(Byte('s') or (Byte('g') shl 8) or (Byte('n') shl 16) or (Byte('p') shl 24)); // mmioFOURCC('s','g','n','p')
  {$EXTERNALSYM DMUS_FOURCC_SIGNPOST_TRACK_CHUNK}


type
  PDMusIoSignPost = ^TDMusIoSignPost;
  _DMUS_IO_SIGNPOST = record
    mtTime: TMusicTime;
    dwChords: DWORD;
    wMeasure: Word;
  end;
  {$EXTERNALSYM _DMUS_IO_SIGNPOST}
  DMUS_IO_SIGNPOST = _DMUS_IO_SIGNPOST;
  {$EXTERNALSYM DMUS_IO_SIGNPOST}
  TDMusIoSignPost = _DMUS_IO_SIGNPOST;

(*

    // <sgnp-list>
    'sgnp'
    (
        //sizeof DMUS_IO_SIGNPOST: DWORD
        <DMUS_IO_SIGNPOST>...
    )

*)

const
  DMUS_FOURCC_MUTE_CHUNK = DWORD(Byte('m') or (Byte('u') shl 8) or (Byte('t') shl 16) or (Byte('e') shl 24)); // mmioFOURCC('m','u','t','e')
  {$EXTERNALSYM DMUS_FOURCC_MUTE_CHUNK}

type
  PDMusIoMute = ^TDMusIoMute;
  _DMUS_IO_MUTE = record
    mtTime: TMusicTime;
    dwPChannel: DWORD;
    dwPChannelMap: DWORD;
  end;
  {$EXTERNALSYM _DMUS_IO_MUTE}
  DMUS_IO_MUTE = _DMUS_IO_MUTE;
  {$EXTERNALSYM DMUS_IO_MUTE}
  TDMusIoMute = _DMUS_IO_MUTE;

(*

    // <mute-list>
    'mute'
    (
        //sizeof DMUS_IO_MUTE:DWORD
        <DMUS_IO_MUTE>...
    )


*)

const
  (* Used for both style and chord map tracks *)

  DMUS_FOURCC_TIME_STAMP_CHUNK = DWORD(Byte('s') or (Byte('t') shl 8) or (Byte('m') shl 16) or (Byte('p') shl 24)); // mmioFOURCC('s','t','m','p')
  {$EXTERNALSYM DMUS_FOURCC_TIME_STAMP_CHUNK}

  (* Style tracks *)

  DMUS_FOURCC_STYLE_TRACK_LIST = DWORD(Byte('s') or (Byte('t') shl 8) or (Byte('t') shl 16) or (Byte('r') shl 24)); // mmioFOURCC('s','t','t','r')
  {$EXTERNALSYM DMUS_FOURCC_STYLE_TRACK_LIST}
  DMUS_FOURCC_STYLE_REF_LIST = DWORD(Byte('s') or (Byte('t') shl 8) or (Byte('r') shl 16) or (Byte('f') shl 24)); // mmioFOURCC('s','t','r','f')
  {$EXTERNALSYM DMUS_FOURCC_STYLE_REF_LIST}

(*

    // <sttr-list>
    LIST('sttr'
    (
        <strf-list>...  // Array of Style references
    )

    // <strf-list>
    LIST('strf'
    (
        <stmp-ck>
        <DMRF>
    )

  // <stmp-ck>
  'stmp'
  (
    // time:DWORD
  )

*)

const
  (* Chord map tracks *)

  DMUS_FOURCC_PERS_TRACK_LIST = DWORD(Byte('p') or (Byte('f') shl 8) or (Byte('t') shl 16) or (Byte('r') shl 24)); // mmioFOURCC('p','f','t','r')
  {$EXTERNALSYM DMUS_FOURCC_PERS_TRACK_LIST}
  DMUS_FOURCC_PERS_REF_LIST   = DWORD(Byte('p') or (Byte('f') shl 8) or (Byte('r') shl 16) or (Byte('f') shl 24)); // mmioFOURCC('p','f','r','f')
  {$EXTERNALSYM DMUS_FOURCC_PERS_REF_LIST}

(*

    // <pftr-list>
    LIST('pftr'
    (
        <pfrf-list>...  // Array of Chord map references
    )

    // <pfrf-list>
    LIST('pfrf'
    (
        <stmp-ck>
        <DMRF>
    )

  // <stmp-ck>
  'stmp'
  (
    // time:DWORD
  )

*)

  DMUS_FOURCC_TEMPO_TRACK = DWORD(Byte('t') or (Byte('e') shl 8) or (Byte('t') shl 16) or (Byte('r') shl 24)); // mmioFOURCC('t','e','t','r')
  {$EXTERNALSYM DMUS_FOURCC_TEMPO_TRACK}

(*
    // tempo array
    'tetr'
    (
        // sizeof DMUS_IO_TEMPO_ITEM: DWORD
        <DMUS_IO_TEMPO_ITEM>...
    )
 *)

  DMUS_FOURCC_SEQ_TRACK  = DWORD(Byte('s') or (Byte('e') shl 8) or (Byte('q') shl 16) or (Byte('t') shl 24)); // mmioFOURCC('s','e','q','t')
  {$EXTERNALSYM DMUS_FOURCC_SEQ_TRACK}
  DMUS_FOURCC_SEQ_LIST   = DWORD(Byte('e') or (Byte('v') shl 8) or (Byte('t') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('e','v','t','l')
  {$EXTERNALSYM DMUS_FOURCC_SEQ_LIST}
  DMUS_FOURCC_CURVE_LIST = DWORD(Byte('c') or (Byte('u') shl 8) or (Byte('r') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('c','u','r','l')
  {$EXTERNALSYM DMUS_FOURCC_CURVE_LIST}

(*
    // sequence track
    'seqt'
    (
        // sequence array
        'evtl'
        (
            // sizeof DMUS_IO_SEQ_ITEM: DWORD
            <DMUS_IO_SEQ_ITEM>...
        )
        // curve array
        'curl'
        (
            // sizeof DMUS_IO_CURVE_ITEM: DWORD
            <DMUS_IO_CURVE_ITEM>...
        )
    )
*)

  DMUS_FOURCC_SYSEX_TRACK = DWORD(Byte('s') or (Byte('y') shl 8) or (Byte('e') shl 16) or (Byte('x') shl 24)); // mmioFOURCC('s','y','e','x')
  {$EXTERNALSYM DMUS_FOURCC_SYSEX_TRACK}

(*
    // sysex track
    'syex'
    (
        {
            <DMUS_IO_SYSEX_ITEM>
            <BYTE>...    // Array of bytes, length defined in the DMUS_IO_SYSEXITEM structure
        }...
    )
*)

  DMUS_FOURCC_TIMESIGNATURE_TRACK = DWORD(Byte('t') or (Byte('i') shl 8) or (Byte('m') shl 16) or (Byte('s') shl 24)); // mmioFOURCC('t','i','m','s')
  {$EXTERNALSYM DMUS_FOURCC_TIMESIGNATURE_TRACK}

type
  PDMusIoTimeSignatureItem = ^TDMusIoTimeSignatureItem;
  _DMUS_IO_TIMESIGNATURE_ITEM = record
    lTime: TMusicTime;
    bBeatsPerMeasure: Byte;   // beats per measure (top of time sig)
    bBeat: Byte;              // what note receives the beat (bottom of time sig.)
                              // we can assume that 0 means 256th note
    wGridsPerBeat: Word;      // grids per beat
  end;
  {$EXTERNALSYM _DMUS_IO_TIMESIGNATURE_ITEM}
  DMUS_IO_TIMESIGNATURE_ITEM = _DMUS_IO_TIMESIGNATURE_ITEM;
  {$EXTERNALSYM DMUS_IO_TIMESIGNATURE_ITEM}
  TDMusIoTimeSignatureItem = _DMUS_IO_TIMESIGNATURE_ITEM;

(*  DirectX6 time signature track

    'tims'
    (
        // size of DMUS_IO_TIMESIGNATURE_ITEM : DWORD
        <DMUS_IO_TIMESIGNATURE_ITEM>...
    )
*)

(*  DirectX8 Time signature track. The track has been updated from DirectX7 to support a list of
    RIFF chunks. This will allow the time signature track to expand in the future.
*)

const
  DMUS_FOURCC_TIMESIGTRACK_LIST = DWORD(Byte('T') or (Byte('I') shl 8) or (Byte('M') shl 16) or (Byte('S') shl 24)); // mmioFOURCC('T','I','M','S')
  {$EXTERNALSYM DMUS_FOURCC_TIMESIGTRACK_LIST}
  DMUS_FOURCC_TIMESIG_CHUNK     = DMUS_FOURCC_TIMESIGNATURE_TRACK;
  {$EXTERNALSYM DMUS_FOURCC_TIMESIG_CHUNK}

(*
LIST
(
    'TIMS'          // Time Signature Track list-type
    <tims-ck>       // Chunk containing an array of time signatures
)

    'tims'
    (
        // size of DMUS_IO_TIMESIGNATURE_ITEM : DWORD
        <DMUS_IO_TIMESIGNATURE_ITEM>...
    )

*)

(*  DirectX8 Marker track. This is used to store valid start points and other
    flow control parameters that may come later. For example, if we want
    to implement more sophisticated looping and branching constructs, they
    would live in this track.
*)

const
  DMUS_FOURCC_MARKERTRACK_LIST = DWORD(Byte('M') or (Byte('A') shl 8) or (Byte('R') shl 16) or (Byte('K') shl 24)); // mmioFOURCC('M','A','R','K')
  {$EXTERNALSYM DMUS_FOURCC_MARKERTRACK_LIST}
  DMUS_FOURCC_VALIDSTART_CHUNK = DWORD(Byte('v') or (Byte('a') shl 8) or (Byte('l') shl 16) or (Byte('s') shl 24)); // mmioFOURCC('v','a','l','s')
  {$EXTERNALSYM DMUS_FOURCC_VALIDSTART_CHUNK}
  DMUS_FOURCC_PLAYMARKER_CHUNK = DWORD(Byte('p') or (Byte('l') shl 8) or (Byte('a') shl 16) or (Byte('y') shl 24)); // mmioFOURCC('p','l','a','y')
  {$EXTERNALSYM DMUS_FOURCC_PLAYMARKER_CHUNK}

type
  (* io structures *)
  PDMusIoValidStart = ^TDMusIoValidStart;
  _DMUS_IO_VALID_START = record
    mtTime: TMusicTime;      // Time of a legal start.
  end;
  {$EXTERNALSYM _DMUS_IO_VALID_START}
  DMUS_IO_VALID_START = _DMUS_IO_VALID_START;
  {$EXTERNALSYM DMUS_IO_VALID_START}
  TDMusIoValidStart = _DMUS_IO_VALID_START;

  PDMusIoPlayMarker = ^TDMusIoPlayMarker;
  _DMUS_IO_PLAY_MARKER = record
    mtTime: TMusicTime;      // Time of a next legal play point marker.
  end;
  {$EXTERNALSYM _DMUS_IO_PLAY_MARKER}
  DMUS_IO_PLAY_MARKER = _DMUS_IO_PLAY_MARKER;
  {$EXTERNALSYM DMUS_IO_PLAY_MARKER}
  TDMusIoPlayMarker = _DMUS_IO_PLAY_MARKER;

(*
LIST
(
    'MARK'          // Marker Track list-type
    [<vals-ck>]     // Chunk containing an array of start points
    [<play-ck>]     // Chunk containing an array of play start markers
)

    'vals'
    (
        // size of DMUS_IO_VALID_START : DWORD
        <DMUS_IO_VALID_START>...
    )

    'play'
    (
        // size of DMUS_IO_PLAY_MARKER : DWORD
        <DMUS_IO_PLAY_MARKER>...
    )

*)

(* segment trigger tracks *)

const
  (* RIFF ids: *)
  DMUS_FOURCC_SEGTRACK_LIST = DWORD(Byte('s') or (Byte('e') shl 8) or (Byte('g') shl 16) or (Byte('t') shl 24)); // mmioFOURCC('s','e','g','t')
  {$EXTERNALSYM DMUS_FOURCC_SEGTRACK_LIST}
  DMUS_FOURCC_SEGTRACK_CHUNK = DWORD(Byte('s') or (Byte('g') shl 8) or (Byte('t') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('s','g','t','h')
  {$EXTERNALSYM DMUS_FOURCC_SEGTRACK_CHUNK}
  DMUS_FOURCC_SEGMENTS_LIST = DWORD(Byte('l') or (Byte('s') shl 8) or (Byte('g') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('l','s','g','l')
  {$EXTERNALSYM DMUS_FOURCC_SEGMENTS_LIST}
  DMUS_FOURCC_SEGMENT_LIST = DWORD(Byte('l') or (Byte('s') shl 8) or (Byte('e') shl 16) or (Byte('g') shl 24)); // mmioFOURCC('l','s','e','g')
  {$EXTERNALSYM DMUS_FOURCC_SEGMENT_LIST}
  DMUS_FOURCC_SEGMENTITEM_CHUNK = DWORD(Byte('s') or (Byte('g') shl 8) or (Byte('i') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('s','g','i','h')
  {$EXTERNALSYM DMUS_FOURCC_SEGMENTITEM_CHUNK}
  DMUS_FOURCC_SEGMENTITEMNAME_CHUNK = DWORD(Byte('s') or (Byte('n') shl 8) or (Byte('a') shl 16) or (Byte('m') shl 24)); // mmioFOURCC('s','n','a','m')
  {$EXTERNALSYM DMUS_FOURCC_SEGMENTITEMNAME_CHUNK}

type
  (* io structures *)
  PDMusIoSegmentTrackHeader = ^TDMusIoSegmentTrackHeader;
  _DMUS_IO_SEGMENT_TRACK_HEADER = record
    dwFlags: DWORD; // Reserved leave as 0.
  end;
  {$EXTERNALSYM _DMUS_IO_SEGMENT_TRACK_HEADER}
  DMUS_IO_SEGMENT_TRACK_HEADER = _DMUS_IO_SEGMENT_TRACK_HEADER;
  {$EXTERNALSYM DMUS_IO_SEGMENT_TRACK_HEADER}
  TDMusIoSegmentTrackHeader = _DMUS_IO_SEGMENT_TRACK_HEADER;

  PDMusIoSegmentItemHeader = ^TDMusIoSegmentItemHeader;
  _DMUS_IO_SEGMENT_ITEM_HEADER = record
    lTimeLogical: TMusicTime;    // Position in track list. Time in the music with which the event is associated.
    lTimePhysical: TMusicTime;   // Precise time event will be triggered. Should be close to logical time.
    dwPlayFlags: DWORD;           // Flags for PlaySegment().
    dwFlags: DWORD;               // Flags.
  end;
  {$EXTERNALSYM _DMUS_IO_SEGMENT_ITEM_HEADER}
  DMUS_IO_SEGMENT_ITEM_HEADER = _DMUS_IO_SEGMENT_ITEM_HEADER;
  {$EXTERNALSYM DMUS_IO_SEGMENT_ITEM_HEADER}
  TDMusIoSegmentItemHeader = _DMUS_IO_SEGMENT_ITEM_HEADER;

const
  (* values for dwflags field of DMUS_IO_SEGMENT_ITEM_HEADER *)
  DMUS_SEGMENTTRACKF_MOTIF = 1; // interpret DMRF as link to style, and use snam as the name of a motif within the style
  {$EXTERNALSYM DMUS_SEGMENTTRACKF_MOTIF}

(*
LIST
(
    'segt'          // DirectMusic Segment Trigger Track form-type
    [<sgth-ck>]     // Segment track header
    <lsgl-list>     // List of Segment Lists
)

    // <sgth-ck>
    'sgth'
    (
        <DMUS_IO_SEGMENT_TRACK_HEADER>
    )

    // <lsgl-list>
    LIST
    (
        'lsgl'          // Array of segments
        <lseg-list>...  // Each segment is encapsulated in a list (that way it can still be riff parsed.)
    )

        // <lseg-list>
        LIST
        (
            'lseg'
            <sgih-ck>
            <DMRF-list>    // Link to a segment or style file.
            [<snam-ck>]    // Name field.  Used with DMUS_SEGMENTTRACKF_MOTIF flag.
        )

            // <sgih-ck>            // segment item header
            (
                <DMUS_IO_SEGMENT_ITEM_HEADER>  // Segment item header
            )

            // <snam-ck>
            (
                // Name, stored as NULL terminated string of WCHARs
            )
*)

(* Script track. *)

const
  (* RIFF ids: *)
  DMUS_FOURCC_SCRIPTTRACK_LIST = DWORD(Byte('s') or (Byte('c') shl 8) or (Byte('r') shl 16) or (Byte('t') shl 24)); // mmioFOURCC('s','c','r','t')
  {$EXTERNALSYM DMUS_FOURCC_SCRIPTTRACK_LIST}
  DMUS_FOURCC_SCRIPTTRACKEVENTS_LIST = DWORD(Byte('s') or (Byte('c') shl 8) or (Byte('r') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('s','c','r','l')
  {$EXTERNALSYM DMUS_FOURCC_SCRIPTTRACKEVENTS_LIST}
  DMUS_FOURCC_SCRIPTTRACKEVENT_LIST = DWORD(Byte('s') or (Byte('c') shl 8) or (Byte('r') shl 16) or (Byte('e') shl 24)); // mmioFOURCC('s','c','r','e')
  {$EXTERNALSYM DMUS_FOURCC_SCRIPTTRACKEVENT_LIST}
  DMUS_FOURCC_SCRIPTTRACKEVENTHEADER_CHUNK = DWORD(Byte('s') or (Byte('c') shl 8) or (Byte('r') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('s','c','r','h')
  {$EXTERNALSYM DMUS_FOURCC_SCRIPTTRACKEVENTHEADER_CHUNK}
  DMUS_FOURCC_SCRIPTTRACKEVENTNAME_CHUNK = DWORD(Byte('s') or (Byte('c') shl 8) or (Byte('r') shl 16) or (Byte('n') shl 24)); // mmioFOURCC('s','c','r','n')
  {$EXTERNALSYM DMUS_FOURCC_SCRIPTTRACKEVENTNAME_CHUNK}

(* Flags for DMUS_IO_SCRIPTTRACK_TIMING
 *)
  DMUS_IO_SCRIPTTRACKF_PREPARE = (1 shl 0);  (* Fire event in advance of time stamp, at Prepare time.  This is the default because it leaves the script time to change the music happening at the target time. *)
  {$EXTERNALSYM DMUS_IO_SCRIPTTRACKF_PREPARE}
  DMUS_IO_SCRIPTTRACKF_QUEUE   = (1 shl 1);  (* Fire event just before time stamp, at Queue time. *)
  {$EXTERNALSYM DMUS_IO_SCRIPTTRACKF_QUEUE}
  DMUS_IO_SCRIPTTRACKF_ATTIME  = (1 shl 2);  (* Fire event right at the time stamp. *)
  {$EXTERNALSYM DMUS_IO_SCRIPTTRACKF_ATTIME}

type
  PDMusIoScriptTrackEventHeader = ^TDMusIoScriptTrackEventHeader;
  _DMUS_IO_SCRIPTTRACK_EVENTHEADER = record
    dwFlags: DWORD;              (* various bits ( see DMUS_IO_SCRIPTTRACKF_* ) *)
    lTimeLogical: TMusicTime;    (* Position in track list. Time in the music with which the event is associated. *)
    lTimePhysical: TMusicTime;   (* Precise time event will be triggered. Should be close to logical time. *)
  end;
  {$EXTERNALSYM _DMUS_IO_SCRIPTTRACK_EVENTHEADER}
  DMUS_IO_SCRIPTTRACK_EVENTHEADER = _DMUS_IO_SCRIPTTRACK_EVENTHEADER;
  {$EXTERNALSYM DMUS_IO_SCRIPTTRACK_EVENTHEADER}
  TDMusIoScriptTrackEventHeader = _DMUS_IO_SCRIPTTRACK_EVENTHEADER;

(*
    // Script Track

    // <scrt-list>
    LIST
    (
        <scrl-list>       // List of script events
    )

        // <scrl-list>
        LIST
        (
            <scre-list>...    // Array of event descriptions
        )

            // <scre-list>
            LIST
            (
                <scrh-ck>         // Event header chunk
                <DMRF>
                <scrn-ck>         // Routine name
            )

                'scrh'
                (
                    <DMUS_IO_SCRIPTTRACK_EVENTHEADER>
                )

                'scrn'
                (
                    // Name, stored as NULL terminated string of WCHARs
                )
*)

(* Lyrics/Notification track. *)

const
  (* RIFF ids: *)
  DMUS_FOURCC_LYRICSTRACK_LIST             = DWORD(Byte('l') or (Byte('y') shl 8) or (Byte('r') shl 16) or (Byte('t') shl 24)); // mmioFOURCC('l','y','r','t')
  {$EXTERNALSYM DMUS_FOURCC_LYRICSTRACK_LIST}
  DMUS_FOURCC_LYRICSTRACKEVENTS_LIST       = DWORD(Byte('l') or (Byte('y') shl 8) or (Byte('r') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('l','y','r','l')
  {$EXTERNALSYM DMUS_FOURCC_LYRICSTRACKEVENTS_LIST}
  DMUS_FOURCC_LYRICSTRACKEVENT_LIST        = DWORD(Byte('l') or (Byte('y') shl 8) or (Byte('r') shl 16) or (Byte('e') shl 24)); // mmioFOURCC('l','y','r','e')
  {$EXTERNALSYM DMUS_FOURCC_LYRICSTRACKEVENT_LIST}
  DMUS_FOURCC_LYRICSTRACKEVENTHEADER_CHUNK = DWORD(Byte('l') or (Byte('y') shl 8) or (Byte('r') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('l','y','r','h')
  {$EXTERNALSYM DMUS_FOURCC_LYRICSTRACKEVENTHEADER_CHUNK}
  DMUS_FOURCC_LYRICSTRACKEVENTTEXT_CHUNK   = DWORD(Byte('l') or (Byte('y') shl 8) or (Byte('r') shl 16) or (Byte('n') shl 24)); // mmioFOURCC('l','y','r','n')
  {$EXTERNALSYM DMUS_FOURCC_LYRICSTRACKEVENTTEXT_CHUNK}

type
  PDMusIoLyricsTrackEventHeader = ^TDMusIoLyricStrackEventHeader;
  _DMUS_IO_LYRICSTRACK_EVENTHEADER = record
    dwFlags: DWORD;              (* Reserved leave as 0. *)
    dwTimingFlags: DWORD;        (* Combination DMUS_PMSGF_TOOL_* flags.  Determines the precise timing of when the notification happens. Invalid with the flag DMUS_PMSGF_REFTIME, DMUS_PMSGF_MUSICTIME, DMUS_PMSGF_TOOL_FLUSH, or DMUS_PMSGF_LOCKTOREFTIME. *)
    lTimeLogical: TMusicTime;    (* Position in track list. Time in the music with which the event is associated. *)
    lTimePhysical: TMusicTime;   (* Precise time event will be triggered. Should be close to logical time. *)
  end;
  {$EXTERNALSYM _DMUS_IO_LYRICSTRACK_EVENTHEADER}
  DMUS_IO_LYRICSTRACK_EVENTHEADER = _DMUS_IO_LYRICSTRACK_EVENTHEADER;
  {$EXTERNALSYM DMUS_IO_LYRICSTRACK_EVENTHEADER}
  TDMusIoLyricsTrackEventHeader = _DMUS_IO_LYRICSTRACK_EVENTHEADER;

(*
    // Lyrics/Notification Track

    // <lyrt-list>
    LIST
    (
        <lyrl-list>       // List of notification events
    )

        // <lyrl-list>
        LIST
        (
            <lyre-list>...    // Array of event descriptions
        )

            // <lyre-list>
            LIST
            (
                <lyrh-ck>         // Event header chunk
                <lyrn-ck>         // Notification text
            )

                'lyrh'
                (
                    <DMUS_IO_LYRICSTRACK_EVENTHEADER>
                )

                'lyrn'
                (
                    // Name, stored as NULL terminated string of WCHARs
                )
*)

(* Parameter control track *)

const
  (* RIFF ids: *)
  DMUS_FOURCC_PARAMCONTROLTRACK_TRACK_LIST = DWORD(Byte('p') or (Byte('r') shl 8) or (Byte('m') shl 16) or (Byte('t') shl 24)); // mmioFOURCC('p','r','m','t')
  {$EXTERNALSYM DMUS_FOURCC_PARAMCONTROLTRACK_TRACK_LIST}
  DMUS_FOURCC_PARAMCONTROLTRACK_OBJECT_LIST = DWORD(Byte('p') or (Byte('r') shl 8) or (Byte('o') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('p','r','o','l')
  {$EXTERNALSYM DMUS_FOURCC_PARAMCONTROLTRACK_OBJECT_LIST}
  DMUS_FOURCC_PARAMCONTROLTRACK_OBJECT_CHUNK = DWORD(Byte('p') or (Byte('r') shl 8) or (Byte('o') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('p','r','o','h')
  {$EXTERNALSYM DMUS_FOURCC_PARAMCONTROLTRACK_OBJECT_CHUNK}
  DMUS_FOURCC_PARAMCONTROLTRACK_PARAM_LIST = DWORD(Byte('p') or (Byte('r') shl 8) or (Byte('p') shl 16) or (Byte('l') shl 24)); // mmioFOURCC('p','r','p','l')
  {$EXTERNALSYM DMUS_FOURCC_PARAMCONTROLTRACK_PARAM_LIST}
  DMUS_FOURCC_PARAMCONTROLTRACK_PARAM_CHUNK = DWORD(Byte('p') or (Byte('r') shl 8) or (Byte('p') shl 16) or (Byte('h') shl 24)); // mmioFOURCC('p','r','p','h')
  {$EXTERNALSYM DMUS_FOURCC_PARAMCONTROLTRACK_PARAM_CHUNK}
  DMUS_FOURCC_PARAMCONTROLTRACK_CURVES_CHUNK = DWORD(Byte('p') or (Byte('r') shl 8) or (Byte('c') shl 16) or (Byte('c') shl 24)); // mmioFOURCC('p','r','c','c')
  {$EXTERNALSYM DMUS_FOURCC_PARAMCONTROLTRACK_CURVES_CHUNK}

type
  PDMusIoParamControlTrackObjectHeader = ^TDMusIoParamControlTrackObjectHeader;
  _DMUS_IO_PARAMCONTROLTRACK_OBJECTHEADER = record
    dwFlags: DWORD;              (* Reserved.  Must be zero. *)
    guidTimeFormat: TGUID;        (* Time format to set the object to.  Must be GUID_TIME_REFERNCE or GUID_TIME_MUSIC from medparam.h. *)
    (* Path for finding the object. These fields correspond to the first five parameters of IDirectMusicSegmentState::GetObjectInPath. *)
    dwPChannel: DWORD;
    dwStage: DWORD;
    dwBuffer: DWORD;
    guidObject: TGUID;
    dwIndex: DWORD;
  end;
  {$EXTERNALSYM _DMUS_IO_PARAMCONTROLTRACK_OBJECTHEADER}
  DMUS_IO_PARAMCONTROLTRACK_OBJECTHEADER = _DMUS_IO_PARAMCONTROLTRACK_OBJECTHEADER;
  {$EXTERNALSYM DMUS_IO_PARAMCONTROLTRACK_OBJECTHEADER}
  TDMusIoParamControlTrackObjectHeader = _DMUS_IO_PARAMCONTROLTRACK_OBJECTHEADER;

  PDMusIoParamControlTrackParamHeader = ^TDMusIoParamControlTrackParamHeader;
  _DMUS_IO_PARAMCONTROLTRACK_PARAMHEADER = record
    dwFlags: DWORD;              (* Reserved.  Must be zero. *)
    dwIndex: DWORD;              (* Index number of the parameter on the object *)
  end;
  {$EXTERNALSYM _DMUS_IO_PARAMCONTROLTRACK_PARAMHEADER}
  DMUS_IO_PARAMCONTROLTRACK_PARAMHEADER = _DMUS_IO_PARAMCONTROLTRACK_PARAMHEADER;
  {$EXTERNALSYM DMUS_IO_PARAMCONTROLTRACK_PARAMHEADER}
  TDMusIoParamControlTrackParamHeader = _DMUS_IO_PARAMCONTROLTRACK_PARAMHEADER;

  PDMusIoParamControlTrackCurveInfo = ^TDMusIoParamControlTrackCurveInfo;
  _DMUS_IO_PARAMCONTROLTRACK_CURVEINFO = record
    mtStartTime: TMusicTime;
    mtEndTime: TMusicTime;
    fltStartValue: Single;
    fltEndValue: Single;
    dwCurveType: DWORD;   (* One of the items from the MP_CURVE_TYPE enum in medparam.h *)
    dwFlags: DWORD;       (* A combination of the MPF_ENVLP_* constants in medparam.h *)
  end;
  {$EXTERNALSYM _DMUS_IO_PARAMCONTROLTRACK_CURVEINFO}
  DMUS_IO_PARAMCONTROLTRACK_CURVEINFO = _DMUS_IO_PARAMCONTROLTRACK_CURVEINFO;
  {$EXTERNALSYM DMUS_IO_PARAMCONTROLTRACK_CURVEINFO}
  TDMusIoParamControlTrackCurveInfo = _DMUS_IO_PARAMCONTROLTRACK_CURVEINFO;

(*
    // <prmt-list>
    LIST
    (
        <prol-list>...   // one for each object
    )

        // <prol-list>
        LIST
        (
            <proh-ck>       // object header chunk
            <prpl-list>...  // one for each parameter
        )

            // <proh-ck>
            proh
            (
                <DMUS_IO_PARAMCONTROLTRACK_OBJECTHEADER>
            )

            // <prpl-list>
            LIST
            (
                <prph-ck>       // parameter header chunk
                <prcc-ck>       // chunk containing an array of curves
            )

                // <prph-ck>
                prph
                (
                    <DMUS_IO_PARAMCONTROLTRACK_PARAMHEADER>
                )

                // <prcc-ck>
                prcc
                (
                    // sizeof DMUS_IO_PARAMCONTROLTRACK_CURVEINFO:DWORD
                    <DMUS_IO_PARAMCONTROLTRACK_CURVEINFO>... // curves, sorted in order of mtTime
                )
*)

(* DirectSoundBufferConfig FX Map *)

const
  (* RIFF ids: *)
  DMUS_FOURCC_DSBC_FORM  = DWORD(Byte('D') or (Byte('S') shl 8) or (Byte('B') shl 16) or (Byte('C') shl 24)); // mmioFOURCC('D','S','B','C')
  {$EXTERNALSYM DMUS_FOURCC_DSBC_FORM}
  DMUS_FOURCC_DSBD_CHUNK = DWORD(Byte('d') or (Byte('s') shl 8) or (Byte('b') shl 16) or (Byte('d') shl 24)); // mmioFOURCC('d','s','b','d')
  {$EXTERNALSYM DMUS_FOURCC_DSBD_CHUNK}
  DMUS_FOURCC_BSID_CHUNK = DWORD(Byte('b') or (Byte('s') shl 8) or (Byte('i') shl 16) or (Byte('d') shl 24)); // mmioFOURCC('b','s','i','d')
  {$EXTERNALSYM DMUS_FOURCC_BSID_CHUNK}
  DMUS_FOURCC_DS3D_CHUNK = DWORD(Byte('d') or (Byte('s') shl 8) or (Byte('3') shl 16) or (Byte('d') shl 24)); // mmioFOURCC('d','s','3','d')
  {$EXTERNALSYM DMUS_FOURCC_DS3D_CHUNK}
  DMUS_FOURCC_DSBC_LIST  = DWORD(Byte('f') or (Byte('x') shl 8) or (Byte('l') shl 16) or (Byte('s') shl 24)); // mmioFOURCC('f','x','l','s')
  {$EXTERNALSYM DMUS_FOURCC_DSBC_LIST}
  DMUS_FOURCC_DSFX_FORM  = DWORD(Byte('D') or (Byte('S') shl 8) or (Byte('F') shl 16) or (Byte('X') shl 24)); // mmioFOURCC('D','S','F','X')
  {$EXTERNALSYM DMUS_FOURCC_DSFX_FORM}
  DMUS_FOURCC_DSFX_CHUNK = DWORD(Byte('f') or (Byte('x') shl 8) or (Byte('h') shl 16) or (Byte('r') shl 24)); // mmioFOURCC('f','x','h','r')
  {$EXTERNALSYM DMUS_FOURCC_DSFX_CHUNK}
  DMUS_FOURCC_DSFX_DATA  = DWORD(Byte('d') or (Byte('a') shl 8) or (Byte('t') shl 16) or (Byte('a') shl 24)); // mmioFOURCC('d','a','t','a')
  {$EXTERNALSYM DMUS_FOURCC_DSFX_DATA}

(* io structures *)

type
  PDSoundIoDSBufferDesc = ^TDSoundIoDSBufferDesc;
  _DSOUND_IO_DSBUFFERDESC = record
    dwFlags: DWORD;        (* DirectSound buffer creation flags *)
    nChannels: Word;       (* No. of channels (rest of buffer format is determined by owning sink) *)
    lVolume: Longint;      (* Initial pan; only used if CTRLVOLUME is specified *)
    lPan: Longint;         (* Initial pan; only used if CTRLPAN is specified *)
    dwReserved: DWORD;     (* Reserved - must be 0 *)
  end;
  {$EXTERNALSYM _DSOUND_IO_DSBUFFERDESC}
  DSOUND_IO_DSBUFFERDESC = _DSOUND_IO_DSBUFFERDESC;
  {$EXTERNALSYM DSOUND_IO_DSBUFFERDESC}
  TDSoundIoDSBufferDesc = _DSOUND_IO_DSBUFFERDESC;

  PDSoundIoDSBusID = ^TDSoundIoDSBusID;
  _DSOUND_IO_DSBUSID = record
    busid: array[0..0] of DWORD;       (* Array size determined from chunk size *)
  end;
  {$EXTERNALSYM _DSOUND_IO_DSBUSID}
  DSOUND_IO_DSBUSID = _DSOUND_IO_DSBUSID;
  {$EXTERNALSYM DSOUND_IO_DSBUSID}
  TDSoundIoDSBusID = _DSOUND_IO_DSBUSID;

  PDSoundIo3D = ^TDSoundIo3D;
  _DSOUND_IO_3D = record
    guid3DAlgorithm: TGUID; (* GUID identifying the 3D algorithm to use (defined in dsound.h) *)
    ds3d: DS3DBUFFER;       (* Initial 3D parameters *)
  end;
  {$EXTERNALSYM _DSOUND_IO_3D}
  DSOUND_IO_3D = _DSOUND_IO_3D;
  {$EXTERNALSYM DSOUND_IO_3D}
  TDSoundIo3D = _DSOUND_IO_3D;

  PDSoundIoDXDMOHeader = ^TDSoundIoDXDMOHeader;
  _DSOUND_IO_DXDMO_HEADER = record
    dwEffectFlags: DWORD;  (* Effect creation flags - equivalent to DSEFFECTDESC::dwFlags *)
    guidDSFXClass: TGUID;   (* GUID identifying the effect to use - corresponds to a COM CLSID *)
    guidReserved: TGUID;    (* Reserved - must be the null GUID *)
    guidSendBuffer: TGUID;  (* GUID identifying the buffer to send to if this is a send effect *)
    dwReserved: DWORD;     (* Reserved - must be 0 *)
  end;
  {$EXTERNALSYM _DSOUND_IO_DXDMO_HEADER}
  DSOUND_IO_DXDMO_HEADER = _DSOUND_IO_DXDMO_HEADER;
  {$EXTERNALSYM DSOUND_IO_DXDMO_HEADER}
  TDSoundIoDXDMOHeader = _DSOUND_IO_DXDMO_HEADER;

  PDSoundIoDXDMOData = ^TDSoundIoDXDMOData;
  _DSOUND_IO_DXDMO_DATA= record
    data: array[0..0] of DWORD;      (* Array size determined by the DMO involved *)
  end;
  {$EXTERNALSYM _DSOUND_IO_DXDMO_DATA}
  DSOUND_IO_DXDMO_DATA = _DSOUND_IO_DXDMO_DATA;
  {$EXTERNALSYM DSOUND_IO_DXDMO_DATA}
  TDSoundIoDXDMOData = _DSOUND_IO_DXDMO_DATA;

(*
RIFF
(
    'DSBC'          // DirectSoundBufferConfig chunk
    [<guid-ck>]     // GUID identifier for this DirectSoundBufferConfig
    [<vers-ck>]     // Optional version info
    [<UNFO-list>]   // Name, author, copyright info., comments
    <dsbd-ck>       // DirectSound Buffer descriptor chunk
    [<bsid-ck>]     // Optional bus id array
    [<ds3d-ck>]     // Optional 3d Parameters
    [<fxls-list>]   // Optional list of FX descriptors
)

    // <guid-ck>
    'guid'
    (
        <GUID>
    )

    // <vers-ck>
    'vers'
    (
        <DMUS_IO_VERSION>
    )

    // <dsbd-ck>
    'dsbd'
    (
        <DSOUND_IO_DSBUFFERDESC>  // Creation parameters and initial settings for the buffer
    )

    // <bsid-ck>
    'bsid'
    (
        <DSOUND_IO_DSBUSID>  // The size of DSOUND_IO_DSBUSID is determined by the chunk size
    )

    // <ds3d-ck>
    'ds3d'
    (
        <DSOUND_IO_3D>  // Initial 3D buffer parameters: position, etc.
    )

    // <fx-list>
    LIST
    (
        'fxls'          // Array of DMO creation parameter blocks
        <DSFX-form>...  // Each DMO is encapsulated in a RIFF chunk
    )

// <DSFX-form>          // DMOs can be embedded in a buffer configuration or stored as separate files
RIFF
(
    'DSFX'
    <fxhr-ck>           // FX header chunk
    [<data-ck>]         // FX initial settings chunk
)

    // <fxhr-ck>
    'fxhr'
    (
        <DSOUND_IO_DXDMO_HEADER>
    )

    // <data-ck>
    'data'
    (
        <DSOUND_IO_DXDMO_DATA>  // Opaque data block used by the DMO to load itself.
        // For our standard included DMOs, this is simply the structure accepted by
        // the DMO's SetAllParameters() method - e.g. struct DSFXChorus for Chorus.
    )
*)



(***************************************************************************
*                                                                          *
*   DMusBuff.h -- This module defines the buffer format for DirectMusic    *
*                 Shared file between user mode and kernel mode components *
*                                                                          *
*   Copyright (c) 1998, Microsoft Corp. All rights reserved.               *
*                                                                          *
***************************************************************************)

(* Format of DirectMusic events in a buffer
 *
 * A buffer contains 1 or more events, each with the following header.
 * Immediately following the header is the event data. The header+data
 * size is rounded to the nearest quadword (8 bytes).
 *)

type
  PDMusEventHeader = ^TDMusEventHeader;
  _DMUS_EVENTHEADER = record
    cbEvent: DWORD;                (* Unrounded bytes in event *)
    dwChannelGroup: DWORD;         (* Channel group of event *)
    rtDelta: TReferenceTime;       (* Delta from start time of entire buffer *)
    dwFlags: DWORD;                (* Flags DMUS_EVENT_xxx *)
  end;
  {$EXTERNALSYM _DMUS_EVENTHEADER}
  DMUS_EVENTHEADER = _DMUS_EVENTHEADER;
  {$EXTERNALSYM DMUS_EVENTHEADER}
  TDMusEventHeader = _DMUS_EVENTHEADER;

const
  DMUS_EVENT_STRUCTURED   = $00000001;  (* Unstructured data (SysEx, etc.) *)
  {$EXTERNALSYM DMUS_EVENT_STRUCTURED}

(* The number of bytes to allocate for an event with 'cb' data bytes.
 *)
// #define QWORD_ALIGN(x) (((x) + 7) & ~7)
function QWORD_ALIGN(x: DWORD): DWORD; inline;
{$EXTERNALSYM QWORD_ALIGN}
// #define DMUS_EVENT_SIZE(cb) QWORD_ALIGN(sizeof(DMUS_EVENTHEADER) + cb)
function DMUS_EVENT_SIZE(cb: DWORD): DWORD; inline;
{$EXTERNALSYM DMUS_EVENT_SIZE}


(************************************************************************
*                                                                       *
*   dmplugin.h -- This module contains the API for plugins for the      *
*                 DirectMusic performance layer                         *
*                                                                       *
*   Copyright (c) Microsoft Corporation.  All rights reserved.          *
*                                                                       *
************************************************************************)
// Translator: only part of this header located below, other definitions
// can be found above

const
  // Registry location for tools
  DMUS_REGSTR_PATH_TOOLS  = 'Software\Microsoft\DirectMusic\Tools';
  {$EXTERNALSYM DMUS_REGSTR_PATH_TOOLS}

(*////////////////////////////////////////////////////////////////////
// IDirectMusicTool8 *)

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicTool8);'}
  {$EXTERNALSYM IDirectMusicTool8}
  IDirectMusicTool8 = interface(IDirectMusicTool)
    (*  IDirectMusicTool8 *)
    ['{0e674303-3b05-11d3-9bd1-f9e7f0a01536}']
    function Clone(out ppTool: IDirectMusicTool): HResult; stdcall;
  end;


(* The following flags are sent in the IDirectMusicTrack.Play() method *)
(* inside the dwFlags parameter *)
type
  enumDMUS_TRACKF_FLAGS = DWORD;
  DMUS_TRACKF_FLAGS = enumDMUS_TRACKF_FLAGS;
  {$EXTERNALSYM DMUS_TRACKF_FLAGS}
  TDMusTrackfFlags = DMUS_TRACKF_FLAGS;
  PDMusTrackfFlags = ^TDMusTrackfFlags;
const
  DMUS_TRACKF_SEEK            = 1;      (* set on a seek *)
  {$EXTERNALSYM DMUS_TRACKF_SEEK}
  DMUS_TRACKF_LOOP            = 2;      (* set on a loop (repeat) *)
  {$EXTERNALSYM DMUS_TRACKF_LOOP}
  DMUS_TRACKF_START           = 4;      (* set on first call to Play *)
  {$EXTERNALSYM DMUS_TRACKF_START}
  DMUS_TRACKF_FLUSH           = 8;      (* set when this call is in response to a flush on the perfomance *)
  {$EXTERNALSYM DMUS_TRACKF_FLUSH}
  DMUS_TRACKF_DIRTY           = $10;   (* set when the track should consider any cached values from a previous call to GetParam to be invalidated *)
  {$EXTERNALSYM DMUS_TRACKF_DIRTY}
  // The following flags are DX8 only.
  DMUS_TRACKF_NOTIFY_OFF      = $20;   (* tells track not to send notifications. *)
  {$EXTERNALSYM DMUS_TRACKF_NOTIFY_OFF}
  DMUS_TRACKF_PLAY_OFF        = $40;   (* tells track not to play anything (but can still send notifications.) *)
  {$EXTERNALSYM DMUS_TRACKF_PLAY_OFF}
  DMUS_TRACKF_LOOPEND         = $80;   (* set when the end of range is also a loop end. *)
  {$EXTERNALSYM DMUS_TRACKF_LOOPEND}
  DMUS_TRACKF_STOP            = $100;  (* set when the end of range is also end of playing this segment. *)
  {$EXTERNALSYM DMUS_TRACKF_STOP}
  DMUS_TRACKF_RECOMPOSE       = $200;  (* set to indicate the track should compose. *)
  {$EXTERNALSYM DMUS_TRACKF_RECOMPOSE}
  DMUS_TRACKF_CLOCK           = $400;  (* set when time parameters are in reference (clock) time. Only valid for PlayEx(). *)
  {$EXTERNALSYM DMUS_TRACKF_CLOCK}

  (* The following flags are sent in the IDirectMusicTrack8::GetParamEx() and SetParamEx() methods *)
  (* inside the dwFlags parameter *)
  DMUS_TRACK_PARAMF_CLOCK  = $01;       (* set when the time is measured is in reference (clock) time *)
  {$EXTERNALSYM DMUS_TRACK_PARAMF_CLOCK}


(*)///////////////////////////////////////////////////////////////////
// IDirectMusicTrack8 *)

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectMusicTrack8);'}
  {$EXTERNALSYM IDirectMusicTrack8}
  IDirectMusicTrack8 = interface(IDirectMusicTrack)
    (* IDirectMusicTrack8 *)
    ['{0e674304-3b05-11d3-9bd1-f9e7f0a01536}']
    function PlayEx(pStateData: Pointer; rtStart, rtEnd, rtOffset: TReferenceTime;
      dwFlags: DWORD; pPerf: IDirectMusicPerformance;
      pSegSt: IDirectMusicSegmentState; dwVirtualID: DWORD): HResult; stdcall;
    function GetParamEx(const rguidType: TGUID; rtTime: TReferenceTime;
      out prtNext: TReferenceTime; pParam, pStateData: pointer; dwFlags: DWORD): HResult; stdcall;
    function SetParamEx(const rguidType: TGUID; rtTime: TReferenceTime;
      pParam, pStateData: pointer; dwFlags: DWORD): HResult; stdcall;
    function Compose(pContext: IUnknown; dwTrackGroup: DWORD;
      out ppResultTrack: IDirectMusicTrack): HResult; stdcall;
    function Join(pNewTrack: IDirectMusicTrack; mtJoin: TMusicTime;
      pContext: IUnknown; dwTrackGroup: DWORD;
      out ppResultTrack: IDirectMusicTrack): HResult; stdcall;
  end;

const
  (* CLSID's *)
  CLSID_DirectMusicTempoTrack    : TGUID = '{d2ac2885-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicTempoTrack}
  CLSID_DirectMusicSeqTrack      : TGUID = '{d2ac2886-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicSeqTrack}
  CLSID_DirectMusicSysExTrack    : TGUID = '{d2ac2887-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicSysExTrack}
  CLSID_DirectMusicTimeSigTrack  : TGUID = '{d2ac2888-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicTimeSigTrack}
  CLSID_DirectMusicChordTrack    : TGUID = '{d2ac288b-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicChordTrack}
  CLSID_DirectMusicCommandTrack  : TGUID = '{d2ac288c-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicCommandTrack}
  CLSID_DirectMusicStyleTrack    : TGUID = '{d2ac288d-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicStyleTrack}
  CLSID_DirectMusicMotifTrack    : TGUID = '{d2ac288e-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicMotifTrack}
  CLSID_DirectMusicSignPostTrack : TGUID = '{f17e8672-c3b4-11d1-870b-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicSignPostTrack}
  CLSID_DirectMusicBandTrack     : TGUID = '{d2ac2894-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicBandTrack}
  CLSID_DirectMusicChordMapTrack : TGUID = '{d2ac2896-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicChordMapTrack}
  CLSID_DirectMusicMuteTrack     : TGUID = '{d2ac2898-b39b-11d1-8704-00600893b1bd}';
  {$EXTERNALSYM CLSID_DirectMusicMuteTrack}

  (* New CLSID's for DX8 *)
  CLSID_DirectMusicScriptTrack: TGUID = '{4108fa85-3586-11d3-8bd7-00600893b1b6}'; (* {4108FA85-3586-11d3-8BD7-00600893B1B6} *)
  {$EXTERNALSYM CLSID_DirectMusicScriptTrack}
  CLSID_DirectMusicMarkerTrack: TGUID = '{55a8fd00-4288-11d3-9bd1-8a0d61c88835}';
  {$EXTERNALSYM CLSID_DirectMusicMarkerTrack}
  CLSID_DirectMusicSegmentTriggerTrack: TGUID = '{bae4d665-4ea1-11d3-8bda-00600893b1b6}'; (* {BAE4D665-4EA1-11d3-8BDA-00600893B1B6} *)
  {$EXTERNALSYM CLSID_DirectMusicSegmentTriggerTrack}
  CLSID_DirectMusicLyricsTrack: TGUID = '{995c1cf5-54ff-11d3-8bda-00600893b1b6}'; (* {995C1CF5-54FF-11d3-8BDA-00600893B1B6} *)
  {$EXTERNALSYM CLSID_DirectMusicLyricsTrack}
  CLSID_DirectMusicParamControlTrack: TGUID = '{4be0537b-5c19-11d3-8bdc-00600893b1b6}'; (* {4BE0537B-5C19-11d3-8BDC-00600893B1B6} *)
  {$EXTERNALSYM CLSID_DirectMusicParamControlTrack}
  CLSID_DirectMusicWaveTrack: TGUID = '{eed36461-9ea5-11d3-9bd1-0080c7150a74}';
  {$EXTERNALSYM CLSID_DirectMusicWaveTrack}

type
  (* IID's *)
  IID_IDirectMusicTrack = IDirectMusicTrack;
  {$EXTERNALSYM IID_IDirectMusicTrack}
  IID_IDirectMusicTool = IDirectMusicTool;
  {$EXTERNALSYM IID_IDirectMusicTool}

  // Interface IDs for DX8
  // changed interfaces (GUID only)
  IID_IDirectMusicTool8 = IDirectMusicTool8;
  {$EXTERNALSYM IID_IDirectMusicTool8}
  IID_IDirectMusicTrack8 = IDirectMusicTrack8;
  {$EXTERNALSYM IID_IDirectMusicTrack8}


// Translator: Types below are declared to compatibility with previous -
// non borland compliant - conversions of DirectMusic.
type
  PDMus_Downloadinfo = PDMusDownloadInfo;
  TDMus_Downloadinfo = TDMusDownloadInfo;
  PDMus_Offsettable = PDMusOffsetTable;
  TDMus_Offsettable = TDMusOffsetTable;
  PDMus_Instrument = PDMusInstrument;
  TDMus_Instrument = TDMusInstrument;
  PDMus_Region = PDMusRegion;
  TDMus_Region = TDMusRegion;
  PDMus_Lfoparams = PDMusLFOParams;
  TDMus_Lfoparams = TDMusLFOParams;
  PDMus_Vegparams = PDMusVEGParams;
  TDMus_Vegparams = TDMusVEGParams;
  PDMus_Pegparams = PDMusPEGParams;
  TDMus_Pegparams = TDMusPEGParams;
  PDMus_Mscparams = PDMusMSCParams;
  TDMus_Mscparams = TDMusMSCParams;
  PDMus_Articparams = PDMusArticParams;
  TDMus_Articparams = TDMusArticParams;
  PDMus_Articulation = PDMusArticulation;
  TDMus_Articulation = TDMusArticulation;
  PDMus_Articulation2 = PDMusArticulation2;
  TDMus_Articulation2 = TDMusArticulation2;
  PDMus_Extensionchunk = PDMusExtensionChunk;
  TDMus_Extensionchunk = TDMusExtensionChunk;
  PDMus_Copyright = PDMusCopyright;
  TDMus_Copyright = TDMusCopyright;
  PDMus_Wavedata = PDMusWaveData;
  TDMus_Wavedata = TDMusWaveData;
  PDMus_Wave = PDMusWave;
  TDMus_Wave = TDMusWave;
  PDMus_Noterange = PDMusNoteRange;
  TDMus_Noterange = TDMusNoteRange;
  PDMus_Waveartdl = PDMusWaveArtDL;
  TDMus_Waveartdl = TDMusWaveArtDL;
  PDMus_Wavedl = PDMusWaveDL;
  TDMus_Wavedl = TDMusWaveDL;
  PDMus_Bufferdesc = PDMusBufferDesc;
  TDMus_Bufferdesc = TDMusBufferDesc;
  PDMus_Portcaps = PDMusPortCaps;
  TDMus_Portcaps = TDMusPortCaps;
  PDMus_Portparams = PDMusPortParams;
  TDMus_Portparams = TDMusPortParams;
  PDMus_Portparams8 = PDMusPortParams8;
  TDMus_Portparams8 = TDMusPortParams8;
  PDMus_Synthstats = PDMusSynthStats;
  TDMus_Synthstats = TDMusSynthStats;
  PDMus_Synthstats8 = PDMusSynthStats8;
  TDMus_Synthstats8 = TDMusSynthStats8;
  PDMus_Waves_Reverb_Params = PDMusWavesReverbParams;
  TDMus_Waves_Reverb_Params = TDMusWavesReverbParams;
  PDMus_Clockinfo7 = PDMusClockInfo7;
  TDMus_Clockinfo7 = TDMusClockInfo7;
  PDMus_Clockinfo8 = PDMusClockInfo8;
  TDMus_Clockinfo8 = TDMusClockInfo8;
  PDMus_Audioparams = PDMusAudioParams;
  TDMus_Audioparams = TDMusAudioParams;
  PDMus_Subchord = PDMusSubChord;
  TDMus_Subchord = TDMusSubChord;
  PDMus_Chord_Key = PDMusChordKey;
  TDMus_Chord_Key = TDMusChordKey;
  PDMus_Version = PDMusVersion;
  TDMus_Version = TDMusVersion;
  PDMus_Timesignature = PDMusTimeSignature;
  TDMus_Timesignature = TDMusTimeSignature;
  PDMus_Valid_Start_Param = PDMusValidStartParam;
  TDMus_Valid_Start_Param = TDMusValidStartParam;
  PDMus_Play_Marker_Param = PDMusPlayMarkerParam;
  TDMus_Play_Marker_Param = TDMusPlayMarkerParam;
  PDMus_Objectdesc = PDMusObjectDesc;
  TDMus_Objectdesc = TDMusObjectDesc;
  PDMus_Script_Errorinfo = PDMusScriptErrorInfo;
  TDMus_Script_Errorinfo = TDMusScriptErrorInfo;
  PDMus_Command_Param = PDMusCommandParam;
  TDMus_Command_Param = TDMusCommandParam;
  PDMus_Command_Param_2 = PDMusCommandParam2;
  TDMus_Command_Param_2 = TDMusCommandParam2;
  PDMus_Pmsg = PDMusPMsg;
  TDMus_Pmsg = TDMusPMsg;
  PDMus_Note_Pmsg = PDMusNotePMsg;
  TDMus_Note_Pmsg = TDMusNotePMsg;
  PDMus_Midi_Pmsg = PDMusMidiPMsg;
  TDMus_Midi_Pmsg = TDMusMidiPMsg;
  PDMus_Patch_Pmsg = PDMusPatchPMsg;
  TDMus_Patch_Pmsg = TDMusPatchPMsg;
  PDMus_Transpose_Pmsg = PDMusTransposePMsg;
  TDMus_Transpose_Pmsg = TDMusTransposePMsg;
  PDMus_Channel_Priority_Pmsg = PDMusChannelPriorityPMsg;
  TDMus_Channel_Priority_Pmsg = TDMusChannelPriorityPMsg;
  PDMus_Tempo_Pmsg = PDMusTempoPMsg;
  TDMus_Tempo_Pmsg = TDMusTempoPMsg;
  PDMus_Sysex_Pmsg = PDMusSysexPMsg;
  TDMus_Sysex_Pmsg = TDMusSysexPMsg;
  PDMus_Curve_Pmsg = PDMusCurvePMsg;
  TDMus_Curve_Pmsg = TDMusCurvePMsg;
  PDMus_Timesig_Pmsg = PDMusTimeSigPMsg;
  TDMus_Timesig_Pmsg = TDMusTimeSigPMsg;
  PDMus_Notification_Pmsg = PDMusNotificationPMsg;
  TDMus_Notification_Pmsg = TDMusNotificationPMsg;
  PDMus_Wave_Pmsg = PDMusWavePMsg;
  TDMus_Wave_Pmsg = TDMusWavePMsg;
  PDMus_Lyric_Pmsg = PDMusLyricPMsg;
  TDMus_Lyric_Pmsg = TDMusLyricPMsg;
  PDMus_Band_Param = PDMusBandParam;
  TDMus_Band_Param = TDMusBandParam;
  PDMus_Variations_Param = PDMusVariationsParam;
  TDMus_Variations_Param = TDMusVariationsParam;
  PDMus_Io_Seq_Item = PDMusIoSeqItem;
  TDMus_Io_Seq_Item = TDMusIoSeqItem;
  PDMus_Io_Curve_Item = PDMusIoCurveItem;
  TDMus_Io_Curve_Item = TDMusIoCurveItem;
  PDMus_Io_Tempo_Item = PDMusIoTempoItem;
  TDMus_Io_Tempo_Item = TDMusIoTempoItem;
  PDMus_Io_Sysex_Item = PDMusIoSysexItem;
  TDMus_Io_Sysex_Item = TDMusIoSysexItem;
  PDMus_Rhythm_Param = PDMusRhythmParam;
  TDMus_Rhythm_Param = TDMusRhythmParam;
  PDMus_Tempo_Param = PDMusTempoParam;
  TDMus_Tempo_Param = TDMusTempoParam;
  PDMus_Mute_Param = PDMusMuteParam;
  TDMus_Mute_Param = TDMusMuteParam;
  PDMus_Io_Timesig = PDMusIoTimesig;
  TDMus_Io_Timesig = TDMusIoTimesig;
  PDMus_Io_Style = PDMusIoStyle;
  TDMus_Io_Style = TDMusIoStyle;
  PDMus_Io_Version = PDMusIoVersion;
  TDMus_Io_Version = TDMusIoVersion;
  PDMus_Io_Pattern = PDMusIoPattern;
  TDMus_Io_Pattern = TDMusIoPattern;
  PDMus_Io_Stylepart = PDMusIoStylepart;
  TDMus_Io_Stylepart = TDMusIoStylepart;
  PDMus_Io_Partref = PDMusIoPartref;
  TDMus_Io_Partref = TDMusIoPartref;
  PDMus_Io_Stylenote = PDMusIoStyleNote;
  TDMus_Io_Stylenote = TDMusIoStyleNote;
  PDMus_Io_Stylecurve = PDMusIoStyleCurve;
  TDMus_Io_Stylecurve = TDMusIoStyleCurve;
  PDMus_Io_Stylemarker = PDMusIoStyleMarker;
  TDMus_Io_Stylemarker = TDMusIoStyleMarker;
  PDMus_Io_Styleresolution = PDMusIoStyleResolution;
  TDMus_Io_Styleresolution = TDMusIoStyleResolution;
  PDMus_Io_Style_Anticipation = PDMusIoStyleAnticipation;
  TDMus_Io_Style_Anticipation = TDMusIoStyleAnticipation;
  PDMus_Io_Motifsettings = PDMusIoMotifSettings;
  TDMus_Io_Motifsettings = TDMusIoMotifSettings;
  PDMus_Io_Chord = PDMusIoChord;
  TDMus_Io_Chord = TDMusIoChord;
  PDMus_Io_Subchord = PDMusIoSubChord;
  TDMus_Io_Subchord = TDMusIoSubChord;
  PDMus_Io_Command = PDMusIoCommand;
  TDMus_Io_Command = TDMusIoCommand;
  PDMus_Io_Tool_Header = PDMusIoToolHeader;
  TDMus_Io_Tool_Header = TDMusIoToolHeader;
  PDMus_Io_Portconfig_Header = PDMusIoPortconfigHeader;
  TDMus_Io_Portconfig_Header = TDMusIoPortconfigHeader;
  PDMus_Io_Pchanneltobuffer_Header = PDMusIoPchanneltobufferHeader;
  TDMus_Io_Pchanneltobuffer_Header = TDMusIoPchanneltobufferHeader;
  PDMus_Io_Buffer_Attributes_Header = PDMusIoBufferAttributesHeader;
  TDMus_Io_Buffer_Attributes_Header = TDMusIoBufferAttributesHeader;
  PDMus_Io_Band_Track_Header = PDMusIoBandTrackHeader;
  TDMus_Io_Band_Track_Header = TDMusIoBandTrackHeader;
  PDMus_Io_Band_Item_Header = PDMusIoBandItemHeader;
  TDMus_Io_Band_Item_Header = TDMusIoBandItemHeader;
  PDMus_Io_Band_Item_Header2 = PDMusIoBandItemHeader2;
  TDMus_Io_Band_Item_Header2 = TDMusIoBandItemHeader2;
  PDMus_Io_Instrument = PDMusIoInstrument;
  TDMus_Io_Instrument = TDMusIoInstrument;
  PDMus_Io_Wave_Header = PDMusIoWaveHeader;
  TDMus_Io_Wave_Header = TDMusIoWaveHeader;
  PDMus_Io_Wave_Track_Header = PDMusIoWaveTrackHeader;
  TDMus_Io_Wave_Track_Header = TDMusIoWaveTrackHeader;
  PDMus_Io_Wave_Part_Header = PDMusIoWavePartHeader;
  TDMus_Io_Wave_Part_Header = TDMusIoWavePartHeader;
  PDMus_Io_Wave_Item_Header = PDMusIoWaveItemHeader;
  TDMus_Io_Wave_Item_Header = TDMusIoWaveItemHeader;
  PDMus_Io_Container_Header = PDMusIoContainerHeader;
  TDMus_Io_Container_Header = TDMusIoContainerHeader;
  PDMus_Io_Contained_Object_Header = PDMusIoContainedObjectHeader;
  TDMus_Io_Contained_Object_Header = TDMusIoContainedObjectHeader;
  PDMus_Io_Segment_Header = PDMusIoSegmentHeader;
  TDMus_Io_Segment_Header = TDMusIoSegmentHeader;
  PDMus_Io_Track_Header = PDMusIoTrackHeader;
  TDMus_Io_Track_Header = TDMusIoTrackHeader;
  PDMus_Io_Track_Extras_Header = PDMusIoTrackExtrasHeader;
  TDMus_Io_Track_Extras_Header = TDMusIoTrackExtrasHeader;
  PDMus_Io_Reference = PDMusIoReference;
  TDMus_Io_Reference = TDMusIoReference;
  PDMus_Io_Chordmap = PDMusIoChordmap;
  TDMus_Io_Chordmap = TDMusIoChordmap;
  PDMus_Io_Chordmap_Subchord = PDMusIoChordmapSubChord;
  TDMus_Io_Chordmap_Subchord = TDMusIoChordmapSubChord;
  PDMus_Io_Chordentry = PDMusIoChordEntry;
  TDMus_Io_Chordentry = TDMusIoChordEntry;
  PDMus_Io_Nextchord = PDMusIoNextChord;
  TDMus_Io_Nextchord = TDMusIoNextChord;
  PDMus_Io_Chordmap_Signpost = PDMusIoChordMapSignPost;
  TDMus_Io_Chordmap_Signpost = TDMusIoChordMapSignPost;
  PDMus_Io_Script_Header = PDMusIoScriptHeader;
  TDMus_Io_Script_Header = TDMusIoScriptHeader;
  PDMus_Io_Signpost = PDMusIoSignPost;
  TDMus_Io_Signpost = TDMusIoSignPost;
  PDMus_Io_Mute = PDMusIoMute;
  TDMus_Io_Mute = TDMusIoMute;
  PDMus_Io_Timesignature_Item = PDMusIoTimesignatureItem;
  TDMus_Io_Timesignature_Item = TDMusIoTimesignatureItem;
  PDMus_Io_Valid_Start = PDMusIoValidStart;
  TDMus_Io_Valid_Start = TDMusIoValidStart;
  PDMus_Io_Play_Marker = PDMusIoPlayMarker;
  TDMus_Io_Play_Marker = TDMusIoPlayMarker;
  PDMus_Io_Segment_Track_Header = PDMusIoSegmentTrackHeader;
  TDMus_Io_Segment_Track_Header = TDMusIoSegmentTrackHeader;
  PDMus_Io_Segment_Item_Header = PDMusIoSegmentItemHeader;
  TDMus_Io_Segment_Item_Header = TDMusIoSegmentItemHeader;
  PDMus_Io_Scripttrack_Eventheader = PDMusIoScriptTrackEventHeader;
  TDMus_Io_Scripttrack_Eventheader = TDMusIoScriptTrackEventHeader;
  PDMus_Io_Lyricstrack_Eventheader = PDMusIoLyricsTrackEventHeader;
  TDMus_Io_Lyricstrack_Eventheader = TDMusIoLyricsTrackEventHeader;
  PDMus_Io_Paramcontroltrack_Objectheader = PDMusIoParamControlTrackObjectHeader;
  TDMus_Io_Paramcontroltrack_Objectheader = TDMusIoParamControlTrackObjectHeader;
  PDMus_Io_Paramcontroltrack_Paramheader = PDMusIoParamControlTrackParamHeader;
  TDMus_Io_Paramcontroltrack_Paramheader = TDMusIoParamControlTrackParamHeader;
  PDMus_Io_Paramcontroltrack_Curveinfo = PDMusIoParamControlTrackCurveInfo;
  TDMus_Io_Paramcontroltrack_Curveinfo = TDMusIoParamControlTrackCurveInfo;
  PDMus_Eventheader = PDMusEventHeader;
  TDMus_Eventheader = TDMusEventHeader;
  PDSound_Io_Dsbufferdesc = PDSoundIoDSBufferDesc;
  TDSound_Io_Dsbufferdesc = TDSoundIoDSBufferDesc;
  PDSound_Io_Dsbusid = PDSoundIoDSBusID;
  TDSound_Io_Dsbusid = TDSoundIoDSBusID;
  PDSound_Io_3d = PDSoundIo3D;
  TDSound_Io_3d = TDSoundIo3D;
  PDSound_Io_Dxdmo_Header = PDSoundIoDXDMOHeader;
  TDSound_Io_Dxdmo_Header = TDSoundIoDXDMOHeader;
  PDSound_Io_Dxdmo_Data = PDSoundIoDXDMOData;
  TDSound_Io_Dxdmo_Data = TDSoundIoDXDMOData;



implementation

// #define MAKE_DMHRESULTSUCCESS(code)     MAKE_HRESULT(0, FACILITY_DIRECTMUSIC, (DMUS_ERRBASE + (code)))
function MAKE_DMHRESULTSUCCESS(Code: DWord): DWord;
begin
  Result:= (0 shl 31) or (FACILITY_DIRECTMUSIC shl 16) or (DMUS_ERRBASE + Code);
end;

// #define MAKE_DMHRESULTERROR(code)       MAKE_HRESULT(1, FACILITY_DIRECTMUSIC, (DMUS_ERRBASE + (code)))
function MAKE_DMHRESULTERROR(Code: DWord): DWord;
begin
  Result:= DWORD((1 shl 31) or (FACILITY_DIRECTMUSIC shl 16)) or (DMUS_ERRBASE + Code);
end;

// #define DSBUSID_IS_SPKR_LOC(id) ( ((id) >= DSBUSID_FIRST_SPKR_LOC) && ((id) <= DSBUSID_LAST_SPKR_LOC) )
function DSBUSID_IS_SPKR_LOC(id: Integer): Boolean;
begin
  Result := (id >= DSBUSID_FIRST_SPKR_LOC) and (id <= DSBUSID_LAST_SPKR_LOC);
end;

function QWORD_ALIGN(x: DWORD): DWORD;
begin
  Result := (x + 7) and (not 7); //  (((x) + 7) & ~7)
end;

function DMUS_EVENT_SIZE(cb: DWORD): DWORD;
begin
  Result := QWORD_ALIGN(SizeOf(TDMusEventHeader) + cb); // QWORD_ALIGN(sizeof(DMUS_EVENTHEADER) + cb)
end;

end.
