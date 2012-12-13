{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      dpaddr.h dplobby8.h dplay8.h dvoice.h                         *}
{*  Content:    DirectPlay8 include files                                     *}
{*                                                                            *}
{*  DirectX 9.0 Delphi / FreePascal adaptation by Alexey Barkovoy             *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Modified: 22-Aug-2004                                                     *}
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

{$MINENUMSIZE 4}
{$ALIGN ON}

unit DirectPlay8;

interface

(*$HPPEMIT '#include "dplay8.h"' *)
(*$HPPEMIT '#include "dplobby8.h"' *)
(*$HPPEMIT '#include "dvoice.h"' *)

uses
  Windows, WinSock, DirectSound;

(*==========================================================================;
 *
 *  Copyright (C) 2000-2002 Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       dpaddr.h
 *  Content:   DirectPlayAddress include file
 ***************************************************************************)


const
(****************************************************************************
 *
 * DirectPlay8Address CLSIDs
 *
 ****************************************************************************)

  // {934A9523-A3CA-4bc5-ADA0-D6D95D979421}
  CLSID_DirectPlay8Address: TGUID = '{934a9523-a3ca-4bc5-ada0-d6d95d979421}';
  {$EXTERNALSYM CLSID_DirectPlay8Address}

  
(****************************************************************************
 *
 * DirectPlay8Address Interface IIDs
 *
 ****************************************************************************)
type
  DPNAREFIID = TGUID;
  {$EXTERNALSYM DPNAREFIID}
  TDPNARefIID = DPNAREFIID;


(****************************************************************************
 *
 * DirectPlay8Address Constants
 *
 ****************************************************************************)
const
  //
  // Asynchronous operation flags
  //
  DPNA_DATATYPE_STRING        = $00000001;
  {$EXTERNALSYM DPNA_DATATYPE_STRING}
  DPNA_DATATYPE_DWORD         = $00000002;
  {$EXTERNALSYM DPNA_DATATYPE_DWORD}
  DPNA_DATATYPE_GUID          = $00000003;
  {$EXTERNALSYM DPNA_DATATYPE_GUID}
  DPNA_DATATYPE_BINARY        = $00000004;
  {$EXTERNALSYM DPNA_DATATYPE_BINARY}
  DPNA_DATATYPE_STRING_ANSI   = $00000005;
  {$EXTERNALSYM DPNA_DATATYPE_STRING_ANSI}

  DPNA_DPNSVR_PORT            = 6073;
  {$EXTERNALSYM DPNA_DPNSVR_PORT}

  DPNA_INDEX_INVALID          = $FFFFFFFF;
  {$EXTERNALSYM DPNA_INDEX_INVALID}

(****************************************************************************
 *
 * DirectPlay8Address Address Elements
 *
 ****************************************************************************)

  DPNA_SEPARATOR_KEYVALUE       = WideChar('=');
  {$EXTERNALSYM DPNA_SEPARATOR_KEYVALUE}
  DPNA_SEPARATOR_USERDATA       = WideChar('#');
  {$EXTERNALSYM DPNA_SEPARATOR_USERDATA}
  DPNA_SEPARATOR_COMPONENT      = WideChar(';');
  {$EXTERNALSYM DPNA_SEPARATOR_COMPONENT}
  DPNA_ESCAPECHAR               = WideChar('%');
  {$EXTERNALSYM DPNA_ESCAPECHAR}

  // Header
  DPNA_HEADER		                    = 'x-directplay:/';
  {$EXTERNALSYM DPNA_HEADER}

  // key names for address components
  DPNA_KEY_NAT_RESOLVER     = 'natresolver';
  {$EXTERNALSYM DPNA_KEY_NAT_RESOLVER}
  DPNA_KEY_NAT_RESOLVER_USER_STRING = 'natresolveruserstring';
  {$EXTERNALSYM DPNA_KEY_NAT_RESOLVER_USER_STRING}
  DPNA_KEY_APPLICATION_INSTANCE = 'applicationinstance';
  {$EXTERNALSYM DPNA_KEY_APPLICATION_INSTANCE}
  DPNA_KEY_DEVICE           = 'device';
  {$EXTERNALSYM DPNA_KEY_DEVICE}
  DPNA_KEY_HOSTNAME         = 'hostname';
  {$EXTERNALSYM DPNA_KEY_HOSTNAME}
  DPNA_KEY_PORT             = 'port';
  {$EXTERNALSYM DPNA_KEY_PORT}
  DPNA_KEY_NAMEINFO         = 'nameinfo';
  {$EXTERNALSYM DPNA_KEY_NAMEINFO}
  DPNA_KEY_PROCESSOR        = 'processor';
  {$EXTERNALSYM DPNA_KEY_PROCESSOR}
  DPNA_KEY_PROGRAM          = 'program';
  {$EXTERNALSYM DPNA_KEY_PROGRAM}
  DPNA_KEY_PROVIDER         = 'provider';
  {$EXTERNALSYM DPNA_KEY_PROVIDER}
  DPNA_KEY_SCOPE            = 'scope';
  {$EXTERNALSYM DPNA_KEY_SCOPE}
  DPNA_KEY_TRAVERSALMODE    = 'traversalmode';
  {$EXTERNALSYM DPNA_KEY_TRAVERSALMODE}
  DPNA_KEY_BAUD             = 'baud';
  {$EXTERNALSYM DPNA_KEY_BAUD}
  DPNA_KEY_FLOWCONTROL      = 'flowcontrol';
  {$EXTERNALSYM DPNA_KEY_FLOWCONTROL}
  DPNA_KEY_PARITY           = 'parity';
  {$EXTERNALSYM DPNA_KEY_PARITY}
  DPNA_KEY_PHONENUMBER      = 'phonenumber';
  {$EXTERNALSYM DPNA_KEY_PHONENUMBER}
  DPNA_KEY_STOPBITS         = 'stopbits';
  {$EXTERNALSYM DPNA_KEY_STOPBITS}

  // values for baud rate
  DPNA_BAUD_RATE_9600         = 9600;
  {$EXTERNALSYM DPNA_BAUD_RATE_9600}
  DPNA_BAUD_RATE_14400        = 14400;
  {$EXTERNALSYM DPNA_BAUD_RATE_14400}
  DPNA_BAUD_RATE_19200        = 19200;
  {$EXTERNALSYM DPNA_BAUD_RATE_19200}
  DPNA_BAUD_RATE_38400        = 38400;
  {$EXTERNALSYM DPNA_BAUD_RATE_38400}
  DPNA_BAUD_RATE_56000        = 56000;
  {$EXTERNALSYM DPNA_BAUD_RATE_56000}
  DPNA_BAUD_RATE_57600        = 57600;
  {$EXTERNALSYM DPNA_BAUD_RATE_57600}
  DPNA_BAUD_RATE_115200       = 115200;
  {$EXTERNALSYM DPNA_BAUD_RATE_115200}

  // values for stop bits
  DPNA_STOP_BITS_ONE          = '1';
  {$EXTERNALSYM DPNA_STOP_BITS_ONE}
  DPNA_STOP_BITS_ONE_FIVE     = '1.5';
  {$EXTERNALSYM DPNA_STOP_BITS_ONE_FIVE}
  DPNA_STOP_BITS_TWO          = '2';
  {$EXTERNALSYM DPNA_STOP_BITS_TWO}

  // values for parity
  DPNA_PARITY_NONE					= 'NONE';
  {$EXTERNALSYM DPNA_PARITY_NONE}
  DPNA_PARITY_EVEN					= 'EVEN';
  {$EXTERNALSYM DPNA_PARITY_EVEN}
  DPNA_PARITY_ODD						= 'ODD';
  {$EXTERNALSYM DPNA_PARITY_ODD}
  DPNA_PARITY_MARK					= 'MARK';
  {$EXTERNALSYM DPNA_PARITY_MARK}
  DPNA_PARITY_SPACE					= 'SPACE';
  {$EXTERNALSYM DPNA_PARITY_SPACE}

  // values for flow control
  DPNA_FLOW_CONTROL_NONE			= 'NONE';
  {$EXTERNALSYM DPNA_FLOW_CONTROL_NONE}
  DPNA_FLOW_CONTROL_XONXOFF		= 'XONXOFF';
  {$EXTERNALSYM DPNA_FLOW_CONTROL_XONXOFF}
  DPNA_FLOW_CONTROL_RTS				= 'RTS';
  {$EXTERNALSYM DPNA_FLOW_CONTROL_RTS}
  DPNA_FLOW_CONTROL_DTR				= 'DTR';
  {$EXTERNALSYM DPNA_FLOW_CONTROL_DTR}
  DPNA_FLOW_CONTROL_RTSDTR		= 'RTSDTR';
  {$EXTERNALSYM DPNA_FLOW_CONTROL_RTSDTR}
  // values for traversal mode
  DPNA_TRAVERSALMODE_NONE             = 0;
  {$EXTERNALSYM DPNA_TRAVERSALMODE_NONE}
  DPNA_TRAVERSALMODE_PORTREQUIRED     = 1;
  {$EXTERNALSYM DPNA_TRAVERSALMODE_PORTREQUIRED}
  DPNA_TRAVERSALMODE_PORTRECOMMENDED  = 2;
  {$EXTERNALSYM DPNA_TRAVERSALMODE_PORTRECOMMENDED}
  // Shortcut values
  //
  // These can be used instead of the corresponding CLSID_DP8SP_XXXX guids
  //
  DPNA_VALUE_TCPIPPROVIDER            = 'IP';
  {$EXTERNALSYM DPNA_VALUE_TCPIPPROVIDER}
  DPNA_VALUE_IPXPROVIDER              = 'IPX';
  {$EXTERNALSYM DPNA_VALUE_IPXPROVIDER}
  DPNA_VALUE_MODEMPROVIDER            = 'MODEM';
  {$EXTERNALSYM DPNA_VALUE_MODEMPROVIDER}
  DPNA_VALUE_SERIALPROVIDER           = 'SERIAL';
  {$EXTERNALSYM DPNA_VALUE_SERIALPROVIDER}

//// ANSI DEFINITIONS

  // Header
  DPNA_HEADER_A						      = 'x-directplay:/';
  {$EXTERNALSYM DPNA_HEADER_A}
  DPNA_SEPARATOR_KEYVALUE_A			= '=';
  {$EXTERNALSYM DPNA_SEPARATOR_KEYVALUE_A}
  DPNA_SEPARATOR_USERDATA_A			= '#';
  {$EXTERNALSYM DPNA_SEPARATOR_USERDATA_A}
  DPNA_SEPARATOR_COMPONENT_A		= ';';
  {$EXTERNALSYM DPNA_SEPARATOR_COMPONENT_A}
  DPNA_ESCAPECHAR_A					    = '%';
  {$EXTERNALSYM DPNA_ESCAPECHAR_A}

  // key names for address components
  DPNA_KEY_NAT_RESOLVER_A					= 'natresolver';
  {$EXTERNALSYM DPNA_KEY_NAT_RESOLVER_A}
  DPNA_KEY_NAT_RESOLVER_USER_STRING_A		= 'natresolveruserstring';
  {$EXTERNALSYM DPNA_KEY_NAT_RESOLVER_USER_STRING_A}
  DPNA_KEY_APPLICATION_INSTANCE_A		= 'applicationinstance';
  {$EXTERNALSYM DPNA_KEY_APPLICATION_INSTANCE_A}
  DPNA_KEY_DEVICE_A					= 'device';
  {$EXTERNALSYM DPNA_KEY_DEVICE_A}
  DPNA_KEY_HOSTNAME_A					= 'hostname';
  {$EXTERNALSYM DPNA_KEY_HOSTNAME_A}
  DPNA_KEY_PORT_A						= 'port';
  {$EXTERNALSYM DPNA_KEY_PORT_A}
  DPNA_KEY_NAMEINFO_A					= 'nameinfo';
  {$EXTERNALSYM DPNA_KEY_NAMEINFO_A}
  DPNA_KEY_PROCESSOR_A				= 'processor';
  {$EXTERNALSYM DPNA_KEY_PROCESSOR_A}
  DPNA_KEY_PROGRAM_A					= 'program';
  {$EXTERNALSYM DPNA_KEY_PROGRAM_A}
  DPNA_KEY_PROVIDER_A					= 'provider';
  {$EXTERNALSYM DPNA_KEY_PROVIDER_A}
  DPNA_KEY_SCOPE_A					= 'scope';
  {$EXTERNALSYM DPNA_KEY_SCOPE_A}
  DPNA_KEY_TRAVERSALMODE_A			= 'traversalmode';
  {$EXTERNALSYM DPNA_KEY_TRAVERSALMODE_A}
  DPNA_KEY_BAUD_A						= 'baud';
  {$EXTERNALSYM DPNA_KEY_BAUD_A}
  DPNA_KEY_FLOWCONTROL_A				= 'flowcontrol';
  {$EXTERNALSYM DPNA_KEY_FLOWCONTROL_A}
  DPNA_KEY_PARITY_A					= 'parity';
  {$EXTERNALSYM DPNA_KEY_PARITY_A}
  DPNA_KEY_PHONENUMBER_A				= 'phonenumber';
  {$EXTERNALSYM DPNA_KEY_PHONENUMBER_A}
  DPNA_KEY_STOPBITS_A					= 'stopbits';
  {$EXTERNALSYM DPNA_KEY_STOPBITS_A}

  // values for stop bits
  DPNA_STOP_BITS_ONE_A				= '1';
  {$EXTERNALSYM DPNA_STOP_BITS_ONE_A}
  DPNA_STOP_BITS_ONE_FIVE_A			= '1.5';
  {$EXTERNALSYM DPNA_STOP_BITS_ONE_FIVE_A}
  DPNA_STOP_BITS_TWO_A				= '2';
  {$EXTERNALSYM DPNA_STOP_BITS_TWO_A}

  // values for parity
  DPNA_PARITY_NONE_A					= 'NONE';
  {$EXTERNALSYM DPNA_PARITY_NONE_A}
  DPNA_PARITY_EVEN_A					= 'EVEN';
  {$EXTERNALSYM DPNA_PARITY_EVEN_A}
  DPNA_PARITY_ODD_A	          = 'ODD';
  {$EXTERNALSYM DPNA_PARITY_ODD_A}
  DPNA_PARITY_MARK_A					= 'MARK';
  {$EXTERNALSYM DPNA_PARITY_MARK_A}
  DPNA_PARITY_SPACE_A					= 'SPACE';
  {$EXTERNALSYM DPNA_PARITY_SPACE_A}

  // values for flow control
  DPNA_FLOW_CONTROL_NONE_A			= 'NONE';
  {$EXTERNALSYM DPNA_FLOW_CONTROL_NONE_A}
  DPNA_FLOW_CONTROL_XONXOFF_A   = 'XONXOFF';
  {$EXTERNALSYM DPNA_FLOW_CONTROL_XONXOFF_A}
  DPNA_FLOW_CONTROL_RTS_A				= 'RTS';
  {$EXTERNALSYM DPNA_FLOW_CONTROL_RTS_A}
  DPNA_FLOW_CONTROL_DTR_A				= 'DTR';
  {$EXTERNALSYM DPNA_FLOW_CONTROL_DTR_A}
  DPNA_FLOW_CONTROL_RTSDTR_A		= 'RTSDTR';
  {$EXTERNALSYM DPNA_FLOW_CONTROL_RTSDTR_A}
  // Shortcut values
  //
  // These can be used instead of the corresponding CLSID_DP8SP_XXXX guids
  //
  DPNA_VALUE_TCPIPPROVIDER_A          = 'IP';
  {$EXTERNALSYM DPNA_VALUE_TCPIPPROVIDER_A}
  DPNA_VALUE_IPXPROVIDER_A            = 'IPX';
  {$EXTERNALSYM DPNA_VALUE_IPXPROVIDER_A}
  DPNA_VALUE_MODEMPROVIDER_A          = 'MODEM';
  {$EXTERNALSYM DPNA_VALUE_MODEMPROVIDER_A}
  DPNA_VALUE_SERIALPROVIDER_A         = 'SERIAL';
  {$EXTERNALSYM DPNA_VALUE_SERIALPROVIDER_A}

type
(****************************************************************************
 *
 * DirectPlay8Address Forward Declarations For External Types
 *
 ****************************************************************************)

  SOCKADDR = TSockAddr;
  {$EXTERNALSYM SOCKADDR}

(****************************************************************************
 *
 * DirectPlay8Address Functions
 *
 ****************************************************************************)


(*
 *
 * This function is no longer supported.  It is recommended that CoCreateInstance be used to create
 * DirectPlay8 address objects.
 *
 * HRESULT WINAPI DirectPlay8AddressCreate( const GUID * pcIID, void **ppvInterface, IUnknown *pUnknown);
 *
 *)

(****************************************************************************
 *
 * DirectPlay8Address Application Interfaces
 *
 ****************************************************************************)

  //
  // COM definition for IDirectPlay8Address Generic Interface
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectPlay8Address);'}
  {$EXTERNALSYM IDirectPlay8Address}
  IDirectPlay8Address = interface(IUnknown)
    ['{83783300-4063-4c8a-9db3-82830a7feb31}']
    (*** IDirectPlay8Address methods ***)
    function BuildFromURLW(pwszSourceURL: PWideChar): HResult; stdcall;
    function BuildFromURLA(pszSourceURL: PAnsiChar): HResult; stdcall;
    function Duplicate(out ppdpaNewAddress: IDirectPlay8Address): HResult; stdcall;
    function SetEqual(pdpaAddress: IDirectPlay8Address): HResult; stdcall;
    function IsEqual(pdpaAddress: IDirectPlay8Address): HResult; stdcall;
    function Clear: HResult; stdcall;
    function GetURLW(pwszURL: PWideChar; var pdwNumChars: DWORD): HResult; stdcall;
    function GetURLA(pszURL: PAnsiChar; var pdwNumChars: DWORD): HResult; stdcall;
    function GetSP(out pguidSP: TGUID): HResult; stdcall;
    function GetUserData(pvUserData: Pointer; var pdwBufferSize: DWORD): HResult; stdcall;
    function SetSP(const pguidSP: TGUID): HResult; stdcall;
    function SetUserData(pvUserData: Pointer; dwDataSize: DWORD): HResult; stdcall;
    function GetNumComponents(out pdwNumComponents: DWORD): HResult; stdcall;
    function GetComponentByName(pwszName: PWideChar; pvBuffer: Pointer; var pdwBufferSize: DWORD; out pdwDataType: DWORD): HResult; stdcall;
    function GetComponentByIndex(dwComponentID: DWORD; pwszName: PWideChar; var pdwNameLen: DWORD; pvBuffer: Pointer; var pdwBufferSize: DWORD; out pdwDataType: DWORD): HResult; stdcall;
    function AddComponent(pwszName: PWideChar; lpvData: Pointer; dwDataSize, dwDataType: DWORD): HResult; stdcall;
    function GetDevice(out pguidDevice: TGUID): HResult; stdcall;
    function SetDevice(const pguidDevice: TGUID): HResult; stdcall;
    function BuildFromDPADDRESS(pvAddress: Pointer; dwDataSize: DWORD): HResult; stdcall;
  end;
  {$NODEFINE PIDirectPlay8Address}
  {$HPPEMIT 'typedef _di_IDirectPlay8Address *PIDirectPlay8Address;'}
  PIDirectPlay8Address = ^IDirectPlay8Address;

  //
  // COM definition for IDirectPlay8AddressIP Generic Interface
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectPlay8AddressIP);'}
  {$EXTERNALSYM IDirectPlay8AddressIP}
  IDirectPlay8AddressIP = interface(IUnknown)
    ['{e5a0e990-2bad-430b-87da-a142cf75de58}']
    (*** IDirectPlay8AddressIP methods ***)
    // Constructs a IDirectPlay8 TCP Address from a SOCKADDR structure
    function BuildFromSockAddr(const pSockAddr: TSockAddr): HResult; stdcall;

    // Constructs a TCP Address from a string (hostname) and port
    function BuildAddress(wszAddress: PWideChar; usPort: Word): HResult; stdcall;

    // Builds a local TCP Address
    function BuildLocalAddress(const pguidAdapter: TGUID; usPort: Word): HResult; stdcall;

    // Gets the address from the structure in SOCKADR format
    function GetSockAddress(psockAddress: PSockAddr; var pdwAddressBufferSize: DWORD): HResult; stdcall;

    // Gets the local afddress
    function GetLocalAddress(out pguidAdapter: TGUID; out pusPort: Word): HResult; stdcall;

    // Gets the remote address
    function GetAddress(wszAddress: PWideChar; var pdwAddressLength: DWORD; out psPort: Word): HResult; stdcall;
  end;


(****************************************************************************
 *
 * DirectPlay8Address Interface IIDs
 *
 ****************************************************************************)

type
  // {83783300-4063-4c8a-9DB3-82830A7FEB31}
  IID_IDirectPlay8Address = IDirectPlay8Address;
  {$EXTERNALSYM IID_IDirectPlay8Address}
  // {E5A0E990-2BAD-430b-87DA-A142CF75DE58}
  IID_IDirectPlay8AddressIP = IDirectPlay8AddressIP; 
  {$EXTERNALSYM IID_IDirectPlay8AddressIP}



(*==========================================================================;
 *
 *  Copyright (C) 1998-2002 Microsoft Corporation.  All Rights Reserved.
 *
 *  File:   DPlay8.h
 *  Content: DirectPlay8 include file
 *
 ***************************************************************************)

const
(****************************************************************************
 *
 * DirectPlay8 CLSIDs
 *
 ****************************************************************************)

  // {743F1DC6-5ABA-429f-8BDF-C54D03253DC2}
  CLSID_DirectPlay8Client: TGUID = '{743f1dc6-5aba-429f-8bdf-c54d03253dc2}';
  {$EXTERNALSYM CLSID_DirectPlay8Client}

  // {DA825E1B-6830-43d7-835D-0B5AD82956A2}
  CLSID_DirectPlay8Server: TGUID = '{da825e1b-6830-43d7-835d-0b5ad82956a2}';
  {$EXTERNALSYM CLSID_DirectPlay8Server}

  // {286F484D-375E-4458-A272-B138E2F80A6A}
  CLSID_DirectPlay8Peer: TGUID = '{286f484d-375e-4458-a272-b138e2f80a6a}';
  {$EXTERNALSYM CLSID_DirectPlay8Peer}

  // CLSIDs added for DirectX 9

  // {FC47060E-6153-4b34-B975-8E4121EB7F3C}
  CLSID_DirectPlay8ThreadPool: TGUID = '{fc47060e-6153-4b34-b975-8e4121eb7f3c}';
  {$EXTERNALSYM CLSID_DirectPlay8ThreadPool}

  // {E4C1D9A2-CBF7-48bd-9A69-34A55E0D8941}
  CLSID_DirectPlay8NATResolver: TGUID = '{e4c1d9a2-cbf7-48bd-9a69-34a55e0d8941}';
  {$EXTERNALSYM CLSID_DirectPlay8NATResolver}

(****************************************************************************
 *
 * DirectPlay8 Service Provider GUIDs
 *
 ****************************************************************************)

  // {53934290-628D-11D2-AE0F-006097B01411}
  CLSID_DP8SP_IPX: TGUID = '{53934290-628d-11d2-ae0f-006097b01411}';
  {$EXTERNALSYM CLSID_DP8SP_IPX}

  // {6D4A3650-628D-11D2-AE0F-006097B01411}
  CLSID_DP8SP_MODEM: TGUID = '{6d4a3650-628d-11d2-ae0f-006097b01411}';
  {$EXTERNALSYM CLSID_DP8SP_MODEM}

  // {743B5D60-628D-11D2-AE0F-006097B01411}
  CLSID_DP8SP_SERIAL: TGUID = '{743b5d60-628d-11d2-ae0f-006097b01411}';
  {$EXTERNALSYM CLSID_DP8SP_SERIAL}

  // {EBFE7BA0-628D-11D2-AE0F-006097B01411}
  CLSID_DP8SP_TCPIP: TGUID = '{ebfe7ba0-628d-11d2-ae0f-006097b01411}';
  {$EXTERNALSYM CLSID_DP8SP_TCPIP}


  // Service providers added for DirectX 9


  // {995513AF-3027-4b9a-956E-C772B3F78006}
  CLSID_DP8SP_BLUETOOTH: TGUID = '{995513af-3027-4b9a-956e-c772b3f78006}';
  {$EXTERNALSYM CLSID_DP8SP_BLUETOOTH}


type
(****************************************************************************
 *
 * DirectPlay8 Callback Functions
 *
 ****************************************************************************)

  //
  // Callback Function Type Definition
  //
  TFNDPNMessageHandler = function (pvUserContext: Pointer; dwMessageType: DWORD; pMessage: Pointer): HRESULT; stdcall;
  {$NODEFINE TFNDPNMessageHandler}
  {$HPPEMIT 'typedef PFNDPNMESSAGEHANDLER TFNDPNMessageHandler;'}

(****************************************************************************
 *
 * DirectPlay8 Datatypes (Non-Structure / Non-Message)
 *
 ****************************************************************************)

  //
  // Player IDs.  Used to uniquely identify a player in a session
  //
  PDPNID = ^DPNID;
  {$EXTERNALSYM PDPNID}
  DPNID = type DWORD;
  {$EXTERNALSYM DPNID}
  TDPNID = DPNID;

  //
  // Used as identifiers for operations
  //
  PDPNHandle = ^TDPNHandle;
  DPNHANDLE = type DWORD;
  {$EXTERNALSYM DPNHANDLE}
  TDPNHandle = DPNHANDLE;

(****************************************************************************
 *
 * DirectPlay8 Message Identifiers
 *
 ****************************************************************************)

const
  DPN_MSGID_OFFSET                    = $FFFF0000;
  {$EXTERNALSYM DPN_MSGID_OFFSET}
  DPN_MSGID_ADD_PLAYER_TO_GROUP       = (DPN_MSGID_OFFSET or $0001);
  {$EXTERNALSYM DPN_MSGID_ADD_PLAYER_TO_GROUP}
  DPN_MSGID_APPLICATION_DESC          = (DPN_MSGID_OFFSET or $0002);
  {$EXTERNALSYM DPN_MSGID_APPLICATION_DESC}
  DPN_MSGID_ASYNC_OP_COMPLETE         = (DPN_MSGID_OFFSET or $0003);
  {$EXTERNALSYM DPN_MSGID_ASYNC_OP_COMPLETE}
  DPN_MSGID_CLIENT_INFO               = (DPN_MSGID_OFFSET or $0004);
  {$EXTERNALSYM DPN_MSGID_CLIENT_INFO}
  DPN_MSGID_CONNECT_COMPLETE          = (DPN_MSGID_OFFSET or $0005);
  {$EXTERNALSYM DPN_MSGID_CONNECT_COMPLETE}
  DPN_MSGID_CREATE_GROUP              = (DPN_MSGID_OFFSET or $0006);
  {$EXTERNALSYM DPN_MSGID_CREATE_GROUP}
  DPN_MSGID_CREATE_PLAYER             = (DPN_MSGID_OFFSET or $0007);
  {$EXTERNALSYM DPN_MSGID_CREATE_PLAYER}
  DPN_MSGID_DESTROY_GROUP             = (DPN_MSGID_OFFSET or $0008);
  {$EXTERNALSYM DPN_MSGID_DESTROY_GROUP}
  DPN_MSGID_DESTROY_PLAYER            = (DPN_MSGID_OFFSET or $0009);
  {$EXTERNALSYM DPN_MSGID_DESTROY_PLAYER}
  DPN_MSGID_ENUM_HOSTS_QUERY          = (DPN_MSGID_OFFSET or $000a);
  {$EXTERNALSYM DPN_MSGID_ENUM_HOSTS_QUERY}
  DPN_MSGID_ENUM_HOSTS_RESPONSE       = (DPN_MSGID_OFFSET or $000b);
  {$EXTERNALSYM DPN_MSGID_ENUM_HOSTS_RESPONSE}
  DPN_MSGID_GROUP_INFO                = (DPN_MSGID_OFFSET or $000c);
  {$EXTERNALSYM DPN_MSGID_GROUP_INFO}
  DPN_MSGID_HOST_MIGRATE              = (DPN_MSGID_OFFSET or $000d);
  {$EXTERNALSYM DPN_MSGID_HOST_MIGRATE}
  DPN_MSGID_INDICATE_CONNECT          = (DPN_MSGID_OFFSET or $000e);
  {$EXTERNALSYM DPN_MSGID_INDICATE_CONNECT}
  DPN_MSGID_INDICATED_CONNECT_ABORTED = (DPN_MSGID_OFFSET or $000f);
  {$EXTERNALSYM DPN_MSGID_INDICATED_CONNECT_ABORTED}
  DPN_MSGID_PEER_INFO                 = (DPN_MSGID_OFFSET or $0010);
  {$EXTERNALSYM DPN_MSGID_PEER_INFO}
  DPN_MSGID_RECEIVE                   = (DPN_MSGID_OFFSET or $0011);
  {$EXTERNALSYM DPN_MSGID_RECEIVE}
  DPN_MSGID_REMOVE_PLAYER_FROM_GROUP  = (DPN_MSGID_OFFSET or $0012);
  {$EXTERNALSYM DPN_MSGID_REMOVE_PLAYER_FROM_GROUP}
  DPN_MSGID_RETURN_BUFFER             = (DPN_MSGID_OFFSET or $0013);
  {$EXTERNALSYM DPN_MSGID_RETURN_BUFFER}
  DPN_MSGID_SEND_COMPLETE             = (DPN_MSGID_OFFSET or $0014);
  {$EXTERNALSYM DPN_MSGID_SEND_COMPLETE}
  DPN_MSGID_SERVER_INFO               = (DPN_MSGID_OFFSET or $0015);
  {$EXTERNALSYM DPN_MSGID_SERVER_INFO}
  DPN_MSGID_TERMINATE_SESSION         = (DPN_MSGID_OFFSET or $0016);
  {$EXTERNALSYM DPN_MSGID_TERMINATE_SESSION}

  // Messages added for DirectX 9
  DPN_MSGID_CREATE_THREAD             = (DPN_MSGID_OFFSET or $0017);
  {$EXTERNALSYM DPN_MSGID_CREATE_THREAD}
  DPN_MSGID_DESTROY_THREAD            = (DPN_MSGID_OFFSET or $0018);
  {$EXTERNALSYM DPN_MSGID_DESTROY_THREAD}
  DPN_MSGID_NAT_RESOLVER_QUERY        = (DPN_MSGID_OFFSET or $0101);
  {$EXTERNALSYM DPN_MSGID_NAT_RESOLVER_QUERY}

(****************************************************************************
 *
 * DirectPlay8 Constants
 *
 ****************************************************************************)

  DPNID_ALL_PLAYERS_GROUP                 = 0;
  {$EXTERNALSYM DPNID_ALL_PLAYERS_GROUP}

  //
  // DESTROY_GROUP reasons
  //
  DPNDESTROYGROUPREASON_NORMAL            = $0001;
  {$EXTERNALSYM DPNDESTROYGROUPREASON_NORMAL}
  DPNDESTROYGROUPREASON_AUTODESTRUCTED    = $0002;
  {$EXTERNALSYM DPNDESTROYGROUPREASON_AUTODESTRUCTED}
  DPNDESTROYGROUPREASON_SESSIONTERMINATED = $0003;
  {$EXTERNALSYM DPNDESTROYGROUPREASON_SESSIONTERMINATED}

  //
  // DESTROY_PLAYER reasons
  //
  DPNDESTROYPLAYERREASON_NORMAL              = $0001;
  {$EXTERNALSYM DPNDESTROYPLAYERREASON_NORMAL}
  DPNDESTROYPLAYERREASON_CONNECTIONLOST      = $0002;
  {$EXTERNALSYM DPNDESTROYPLAYERREASON_CONNECTIONLOST}
  DPNDESTROYPLAYERREASON_SESSIONTERMINATED   = $0003;
  {$EXTERNALSYM DPNDESTROYPLAYERREASON_SESSIONTERMINATED}
  DPNDESTROYPLAYERREASON_HOSTDESTROYEDPLAYER = $0004;
  {$EXTERNALSYM DPNDESTROYPLAYERREASON_HOSTDESTROYEDPLAYER}


  DPN_MAX_APPDESC_RESERVEDDATA_SIZE          = 64;
  {$EXTERNALSYM DPN_MAX_APPDESC_RESERVEDDATA_SIZE}


(****************************************************************************
 *
 * DirectPlay8 Flags
 *
 ****************************************************************************)

  //
  // Asynchronous operation flags (For Async Ops)
  //
  DPNOP_SYNC                   = $80000000;
  {$EXTERNALSYM DPNOP_SYNC}

  //
  // Add player to group flags (For AddPlayerToGroup)
  //
  DPNADDPLAYERTOGROUP_SYNC     = DPNOP_SYNC;
  {$EXTERNALSYM DPNADDPLAYERTOGROUP_SYNC}

  //
  // Cancel flags
  //
  DPNCANCEL_CONNECT           = $0001;
  {$EXTERNALSYM DPNCANCEL_CONNECT}
  DPNCANCEL_ENUM              = $0002;
  {$EXTERNALSYM DPNCANCEL_ENUM}
  DPNCANCEL_SEND              = $0004;
  {$EXTERNALSYM DPNCANCEL_SEND}
  DPNCANCEL_ALL_OPERATIONS    = $8000;
  {$EXTERNALSYM DPNCANCEL_ALL_OPERATIONS}

  // Flags added for DirectX 9
  DPNCANCEL_PLAYER_SENDS					= $80000000;
  {$EXTERNALSYM DPNCANCEL_PLAYER_SENDS}
  DPNCANCEL_PLAYER_SENDS_PRIORITY_HIGH	= (DPNCANCEL_PLAYER_SENDS or $00010000);
  {$EXTERNALSYM DPNCANCEL_PLAYER_SENDS_PRIORITY_HIGH}
  DPNCANCEL_PLAYER_SENDS_PRIORITY_NORMAL	= (DPNCANCEL_PLAYER_SENDS or $00020000);
  {$EXTERNALSYM DPNCANCEL_PLAYER_SENDS_PRIORITY_NORMAL}
  DPNCANCEL_PLAYER_SENDS_PRIORITY_LOW		= (DPNCANCEL_PLAYER_SENDS or $00040000);
  {$EXTERNALSYM DPNCANCEL_PLAYER_SENDS_PRIORITY_LOW}

  //
  // Close flags (for Close, added for DirectX 9)
  //
  DPNCLOSE_IMMEDIATE						= $00000001;
  {$EXTERNALSYM DPNCLOSE_IMMEDIATE}

  //
  // Connect flags (For Connect)
  //
  DPNCONNECT_SYNC              = DPNOP_SYNC;
  {$EXTERNALSYM DPNCONNECT_SYNC}
  DPNCONNECT_OKTOQUERYFORADDRESSING = $0001;
  {$EXTERNALSYM DPNCONNECT_OKTOQUERYFORADDRESSING}

  //
  // Create group flags (For CreateGroup)
  //
  DPNCREATEGROUP_SYNC          = DPNOP_SYNC;
  {$EXTERNALSYM DPNCREATEGROUP_SYNC}

  //
  // Destroy group flags (For DestroyGroup)
  //
  DPNDESTROYGROUP_SYNC         = DPNOP_SYNC;
  {$EXTERNALSYM DPNDESTROYGROUP_SYNC}

  //
  // Enumerate clients and groups flags (For EnumPlayersAndGroups)
  //
  DPNENUM_PLAYERS              = $0001;
  {$EXTERNALSYM DPNENUM_PLAYERS}
  DPNENUM_GROUPS               = $0010;
  {$EXTERNALSYM DPNENUM_GROUPS}

  //
  // Enum hosts flags (For EnumHosts)
  //
  DPNENUMHOSTS_SYNC                   = DPNOP_SYNC;
  {$EXTERNALSYM DPNENUMHOSTS_SYNC}
  DPNENUMHOSTS_OKTOQUERYFORADDRESSING = $0001;
  {$EXTERNALSYM DPNENUMHOSTS_OKTOQUERYFORADDRESSING}
  DPNENUMHOSTS_NOBROADCASTFALLBACK    = $0002;
  {$EXTERNALSYM DPNENUMHOSTS_NOBROADCASTFALLBACK}

  //
  // Enum service provider flags (For EnumSP)
  //
  DPNENUMSERVICEPROVIDERS_ALL         = $0001;
  {$EXTERNALSYM DPNENUMSERVICEPROVIDERS_ALL}

  //
  // GetLocalHostAddresses flags (added for DirectX 9)
  //
  DPNGETLOCALHOSTADDRESSES_COMBINED   = $0001;
  {$EXTERNALSYM DPNGETLOCALHOSTADDRESSES_COMBINED}

  //
  // Get send queue info flags (For GetSendQueueInfo)
  //
  DPNGETSENDQUEUEINFO_PRIORITY_NORMAL = $0001;
  {$EXTERNALSYM DPNGETSENDQUEUEINFO_PRIORITY_NORMAL}
  DPNGETSENDQUEUEINFO_PRIORITY_HIGH   = $0002;
  {$EXTERNALSYM DPNGETSENDQUEUEINFO_PRIORITY_HIGH}
  DPNGETSENDQUEUEINFO_PRIORITY_LOW    = $0004;
  {$EXTERNALSYM DPNGETSENDQUEUEINFO_PRIORITY_LOW}

  //
  // Group information flags (For Group Info)
  //
  DPNGROUP_AUTODESTRUCT               = $0001;
  {$EXTERNALSYM DPNGROUP_AUTODESTRUCT}

  //
  // Host flags (For Host)
  //
  DPNHOST_OKTOQUERYFORADDRESSING      = $0001;
  {$EXTERNALSYM DPNHOST_OKTOQUERYFORADDRESSING}

  //
  // Set info
  //
  DPNINFO_NAME                        = $0001;
  {$EXTERNALSYM DPNINFO_NAME}
  DPNINFO_DATA                        = $0002;
  {$EXTERNALSYM DPNINFO_DATA}

  //
  // Initialize flags (For Initialize)
  //
  DPNINITIALIZE_DISABLEPARAMVAL       = $0001;
  {$EXTERNALSYM DPNINITIALIZE_DISABLEPARAMVAL}
  // Flags added for DirectX 9
  DPNINITIALIZE_HINT_LANSESSION       = $0002;
  {$EXTERNALSYM DPNINITIALIZE_HINT_LANSESSION}
  DPNINITIALIZE_DISABLELINKTUNING     = $0004;
  {$EXTERNALSYM DPNINITIALIZE_DISABLELINKTUNING}


  //
  // Register Lobby flags
  //
  DPNLOBBY_REGISTER                   = $0001;
  {$EXTERNALSYM DPNLOBBY_REGISTER}
  DPNLOBBY_UNREGISTER                 = $0002;
  {$EXTERNALSYM DPNLOBBY_UNREGISTER}

  //
  // Player information flags (For Player Info / Player Messages)
  //
  DPNPLAYER_LOCAL       = $0002;
  {$EXTERNALSYM DPNPLAYER_LOCAL}
  DPNPLAYER_HOST        = $0004;
  {$EXTERNALSYM DPNPLAYER_HOST}

  //
  // Receive indication flags (added for DirectX 9)
  //
  DPNRECEIVE_GUARANTEED       = $0001;
  {$EXTERNALSYM DPNRECEIVE_GUARANTEED}
  DPNRECEIVE_COALESCED        = $0002;
  {$EXTERNALSYM DPNRECEIVE_COALESCED}

  //
  // Remove player from group flags (For RemovePlayerFromGroup)
  //
  DPNREMOVEPLAYERFROMGROUP_SYN = DPNOP_SYNC;
  {$EXTERNALSYM DPNREMOVEPLAYERFROMGROUP_SYN}

  //
  // Send flags (For Send/SendTo)
  //
  DPNSEND_SYNC                = DPNOP_SYNC;
  {$EXTERNALSYM DPNSEND_SYNC}
  DPNSEND_NOCOPY              = $0001;
  {$EXTERNALSYM DPNSEND_NOCOPY}
  DPNSEND_NOCOMPLETE          = $0002;
  {$EXTERNALSYM DPNSEND_NOCOMPLETE}
  DPNSEND_COMPLETEONPROCESS   = $0004;
  {$EXTERNALSYM DPNSEND_COMPLETEONPROCESS}
  DPNSEND_GUARANTEED          = $0008;
  {$EXTERNALSYM DPNSEND_GUARANTEED}
  DPNSEND_NONSEQUENTIAL       = $0010;
  {$EXTERNALSYM DPNSEND_NONSEQUENTIAL}
  DPNSEND_NOLOOPBACK          = $0020;
  {$EXTERNALSYM DPNSEND_NOLOOPBACK}
  DPNSEND_PRIORITY_LOW        = $0040;
  {$EXTERNALSYM DPNSEND_PRIORITY_LOW}
  DPNSEND_PRIORITY_HIGH       = $0080;
  {$EXTERNALSYM DPNSEND_PRIORITY_HIGH}
  // Flag added for DirectX 9
  DPNSEND_COALESCE						= $0100;
  {$EXTERNALSYM DPNSEND_COALESCE}

  //
  // Send complete indication flags (added for DirectX 9)
  //
  DPNSENDCOMPLETE_GUARANTEED				= $0001;
  {$EXTERNALSYM DPNSENDCOMPLETE_GUARANTEED}
  DPNSENDCOMPLETE_COALESCED				= $0002;
  {$EXTERNALSYM DPNSENDCOMPLETE_COALESCED}

  //
  // Session Flags (for DPN_APPLICATION_DESC)
  //
  DPNSESSION_CLIENT_SERVER    = $0001;
  {$EXTERNALSYM DPNSESSION_CLIENT_SERVER}
  DPNSESSION_MIGRATE_HOST     = $0004;
  {$EXTERNALSYM DPNSESSION_MIGRATE_HOST}
  DPNSESSION_NODPNSVR         = $0040;
  {$EXTERNALSYM DPNSESSION_NODPNSVR}
  DPNSESSION_REQUIREPASSWORD  = $0080;
  {$EXTERNALSYM DPNSESSION_REQUIREPASSWORD}
  // Flag added for DirectX 9
  DPNSESSION_NOENUMS						= $0100;
  {$EXTERNALSYM DPNSESSION_NOENUMS}
  DPNSESSION_FAST_SIGNED					= $0200;
  {$EXTERNALSYM DPNSESSION_FAST_SIGNED}
  DPNSESSION_FULL_SIGNED					= $0400;
  {$EXTERNALSYM DPNSESSION_FULL_SIGNED}

  //
  // Set client info flags (For SetClientInfo)
  //
  DPNSETCLIENTINFO_SYNC       = DPNOP_SYNC;
  {$EXTERNALSYM DPNSETCLIENTINFO_SYNC}

  //
  // Set group info flags (For SetGroupInfo)
  //
  DPNSETGROUPINFO_SYNC        = DPNOP_SYNC;
  {$EXTERNALSYM DPNSETGROUPINFO_SYNC}

  //
  // Set peer info flags (For SetPeerInfo)
  //
  DPNSETPEERINFO_SYNC         = DPNOP_SYNC;
  {$EXTERNALSYM DPNSETPEERINFO_SYNC}

  //
  // Set server info flags (For SetServerInfo)
  //
  DPNSETSERVERINFO_SYNC       = DPNOP_SYNC;
  {$EXTERNALSYM DPNSETSERVERINFO_SYNC}

  //
  // SP capabilities flags
  //
  DPNSPCAPS_SUPPORTSDPNSVR      = $0001;
  {$EXTERNALSYM DPNSPCAPS_SUPPORTSDPNSVR}
  DPNSPCAPS_SUPPORTSDPNSRV      = DPNSPCAPS_SUPPORTSDPNSVR;
  {$EXTERNALSYM DPNSPCAPS_SUPPORTSDPNSRV}
  DPNSPCAPS_SUPPORTSBROADCAST   = $0002;
  {$EXTERNALSYM DPNSPCAPS_SUPPORTSBROADCAST}
  DPNSPCAPS_SUPPORTSALLADAPTERS = $0004;
  {$EXTERNALSYM DPNSPCAPS_SUPPORTSALLADAPTERS}
  // Flags added for DirectX 9
  DPNSPCAPS_SUPPORTSTHREADPOOL			= $0008;
  {$EXTERNALSYM DPNSPCAPS_SUPPORTSTHREADPOOL}
  DPNSPCAPS_NETWORKSIMULATOR				= $0010;
  {$EXTERNALSYM DPNSPCAPS_NETWORKSIMULATOR}

  //
  // SP information flags (added for DirectX 9)
  //
  DPNSPINFO_NETWORKSIMULATORDEVICE		= $0001;
  {$EXTERNALSYM DPNSPINFO_NETWORKSIMULATORDEVICE}

(****************************************************************************
 *
 * DirectPlay8 Structures (Non-Message)
 *
 ****************************************************************************)

type
  //
  // Application description
  //

  PDPNApplicationDesc = ^TDPNApplicationDesc;
  _DPN_APPLICATION_DESC = packed record
    dwSize: DWORD;                    // Size of this structure
    dwFlags: DWORD;                   // Flags (DPNSESSION_...)
    guidInstance: TGUID;              // Instance GUID
    guidApplication: TGUID;           // Application GUID
    dwMaxPlayers: DWORD;              // Maximum # of players allowed (0=no limit)
    dwCurrentPlayers: DWORD;          // Current # of players allowed
    pwszSessionName: PWideChar;       // Name of the session
    pwszPassword: PWideChar;          // Password for the session
    pvReservedData: Pointer;
    dwReservedDataSize: DWORD;
    pvApplicationReservedData: Pointer;
    dwApplicationReservedDataSize: DWORD;
  end;
  {$EXTERNALSYM _DPN_APPLICATION_DESC}
  DPN_APPLICATION_DESC = _DPN_APPLICATION_DESC;
  {$EXTERNALSYM DPN_APPLICATION_DESC}
  TDPNApplicationDesc = _DPN_APPLICATION_DESC;

  //
  // Generic Buffer Description
  //
  PBufferDesc = ^TBufferDesc;
  _BUFFERDESC = packed record
    wBufferSize:DWORD;
    pBufferData: PByte;
  end;
  {$EXTERNALSYM _BUFFERDESC}
  BUFFERDESC = _BUFFERDESC;
  {$EXTERNALSYM BUFFERDESC}
  TBufferDesc = _BUFFERDESC;

  PDPNBufferDesc = ^TDPNBufferDesc;
  DPN_BUFFER_DESC = _BUFFERDESC;
  {$EXTERNALSYM DPN_BUFFER_DESC}
  TDPNBufferDesc = DPN_BUFFER_DESC;

  //
  // DirectPlay8 capabilities
  //
  PDPNCaps = ^TDPNCaps;
  _DPN_CAPS = packed record
    dwSize: DWORD;							// Size of this structure
    dwFlags: DWORD;						// Flags
    dwConnectTimeout: DWORD;				// ms before a connect request times out
    dwConnectRetries: DWORD;				// # of times to attempt the connection
    dwTimeoutUntilKeepAlive: DWORD;		// ms of inactivity before a keep alive is sent
  end;
  {$EXTERNALSYM _DPN_CAPS}
  DPN_CAPS = _DPN_CAPS;
  {$EXTERNALSYM DPN_CAPS}
  TDPNCaps = _DPN_CAPS;

  //
  // Extended capabilities structures (added for DirectX 9)
  //
  PDPNCapsEx = ^TDPNCapsEx;
  _DPN_CAPS_EX = packed record
    dwSize: DWORD;						// Size of this structure
    dwFlags: DWORD;						// Flags
    dwConnectTimeout: DWORD;			// ms before a connect request times out
    dwConnectRetries: DWORD;				// # of times to attempt the connection
    dwTimeoutUntilKeepAlive: DWORD;		// ms of inactivity before a keep alive is sent
    dwMaxRecvMsgSize: DWORD;			// maximum size in bytes of message that can be received
    dwNumSendRetries: DWORD;			// maximum number of send retries before link is considered dead
    dwMaxSendRetryInterval: DWORD;		// maximum period in msec between send retries
    dwDropThresholdRate: DWORD;			// percentage of dropped packets before throttling
    dwThrottleRate: DWORD;				// percentage amount to reduce send window when throttling
    dwNumHardDisconnectSends: DWORD;	// number of hard disconnect frames to send when close immediate flag is specified
    dwMaxHardDisconnectPeriod: DWORD;	// maximum period between hard disconnect sends
  end;
  {$EXTERNALSYM _DPN_CAPS_EX}
  DPN_CAPS_EX = _DPN_CAPS_EX;
  {$EXTERNALSYM DPN_CAPS_EX}
  TDPNCapsEx = _DPN_CAPS_EX;

  // Connection Statistics information

  PDPNConnectionInfo = ^TDPNConnectionInfo;
  _DPN_CONNECTION_INFO = packed record
    dwSize: DWORD;
    dwRoundTripLatencyMS: DWORD;
    dwThroughputBPS: DWORD;
    dwPeakThroughputBPS: DWORD;

    dwBytesSentGuaranteed: DWORD;
    dwPacketsSentGuaranteed: DWORD;
    dwBytesSentNonGuaranteed: DWORD;
    dwPacketsSentNonGuaranteed: DWORD;

    dwBytesRetried: DWORD;    // Guaranteed only
    dwPacketsRetried: DWORD;  // Guaranteed only
    dwBytesDropped: DWORD;    // Non Guaranteed only
    dwPacketsDropped: DWORD;  // Non Guaranteed only

    dwMessagesTransmittedHighPriority: DWORD;
    dwMessagesTimedOutHighPriority: DWORD;
    dwMessagesTransmittedNormalPriority: DWORD;
    dwMessagesTimedOutNormalPriority: DWORD;
    dwMessagesTransmittedLowPriority: DWORD;
    dwMessagesTimedOutLowPriority: DWORD;

    dwBytesReceivedGuaranteed: DWORD;
    dwPacketsReceivedGuaranteed: DWORD;
    dwBytesReceivedNonGuaranteed: DWORD;
    dwPacketsReceivedNonGuaranteed: DWORD;
    dwMessagesReceived: DWORD;
  end;
  {$EXTERNALSYM _DPN_CONNECTION_INFO}
  DPN_CONNECTION_INFO = _DPN_CONNECTION_INFO;
  {$EXTERNALSYM DPN_CONNECTION_INFO}
  TDPNConnectionInfo = _DPN_CONNECTION_INFO;


  //
  // Group information strucutre
  //
  PDPNGroupInfo = ^TDPNGroupInfo;
  _DPN_GROUP_INFO = packed record
    dwSize: DWORD;          // size of this structure
    dwInfoFlags: DWORD;     // information contained
    pwszName: PWideChar;    // Unicode Name
    pvData: Pointer;        // data block
    dwDataSize: DWORD;      // size in BYTES of data block
    dwGroupFlags: DWORD;    // group flags (DPNGROUP_...)
  end;
  {$EXTERNALSYM _DPN_GROUP_INFO}
  DPN_GROUP_INFO = _DPN_GROUP_INFO;
  {$EXTERNALSYM DPN_GROUP_INFO}
  TDPNGroupInfo = _DPN_GROUP_INFO;

  //
  // Player information structure
  //
  PDPNPlayerInfo = ^TDPNPlayerInfo;
  _DPN_PLAYER_INFO = packed record
    dwSize: DWORD;          // size of this structure
    dwInfoFlags: DWORD;     // information contained
    pwszName: PWideChar;    // Unicode Name
    pvData: Pointer;        // data block
    dwDataSize: DWORD;      // size in BYTES of data block
    dwPlayerFlags: DWORD;   // player flags (DPNPLAYER_...)
  end;
  {$EXTERNALSYM _DPN_PLAYER_INFO}
  DPN_PLAYER_INFO = _DPN_PLAYER_INFO;
  {$EXTERNALSYM DPN_PLAYER_INFO}
  TDPNPlayerInfo = _DPN_PLAYER_INFO;

  PDPNSecurityCredentials = ^TDPNSecurityCredentials;
  _DPN_SECURITY_CREDENTIALS = record
  end;
  {$EXTERNALSYM _DPN_SECURITY_CREDENTIALS}
  DPN_SECURITY_CREDENTIALS = _DPN_SECURITY_CREDENTIALS;
  {$EXTERNALSYM DPN_SECURITY_CREDENTIALS}
  TDPNSecurityCredentials = _DPN_SECURITY_CREDENTIALS;

  PDPNSecurityDesc = ^TDPNSecurityDesc;
  _DPN_SECURITY_DESC = record
  end;
  {$EXTERNALSYM _DPN_SECURITY_DESC}
  DPN_SECURITY_DESC = _DPN_SECURITY_DESC;
  {$EXTERNALSYM DPN_SECURITY_DESC}
  TDPNSecurityDesc = _DPN_SECURITY_DESC;

  //
  // Service provider & adapter enumeration structure
  //
  PDPNServiceProviderInfo = ^TDPNServiceProviderInfo;
  _DPN_SERVICE_PROVIDER_INFO = packed record
     dwFlags: DWORD;
     guid: TGUID;            // SP Guid
     pwszName: PWideChar;    // Friendly Name
     pvReserved: Pointer;
     dwReserved: DWORD;
  end;
  {$EXTERNALSYM _DPN_SERVICE_PROVIDER_INFO}
  DPN_SERVICE_PROVIDER_INFO = _DPN_SERVICE_PROVIDER_INFO;
  {$EXTERNALSYM DPN_SERVICE_PROVIDER_INFO}
  TDPNServiceProviderInfo = _DPN_SERVICE_PROVIDER_INFO;

  //
  // Service provider caps structure
  //
  PDPNSpCaps = ^TDPNSpCaps;
  _DPN_SP_CAPS = packed record
    dwSize: DWORD;                   // Size of this structure
    dwFlags: DWORD;                  // Flags ((DPNSPCAPS_...)
    dwNumThreads: DWORD;             // # of worker threads to use
    dwDefaultEnumCount: DWORD;       // default # of enum requests
    dwDefaultEnumRetryInterval: DWORD; // default ms between enum requests
    dwDefaultEnumTimeout: DWORD;     // default enum timeout
    dwMaxEnumPayloadSize: DWORD;     // maximum size in bytes for enum payload data
    dwBuffersPerThread: DWORD;       // number of receive buffers per thread
    dwSystemBufferSize: DWORD;       // amount of buffering to do in addition to posted receive buffers
  end;
  {$EXTERNALSYM _DPN_SP_CAPS}
  DPN_SP_CAPS = _DPN_SP_CAPS;
  {$EXTERNALSYM DPN_SP_CAPS}
  TDPNSpCaps = _DPN_SP_CAPS;


(****************************************************************************
 *
 * IDirectPlay8 message handler call back structures
 *
 ****************************************************************************)

  //
  // Add player to group strucutre for message handler
  // (DPN_MSGID_ADD_PLAYER_TO_GROUP)
  //
  PDPNMsgAddPlayerToGroup = ^TDPNMsgAddPlayerToGroup;
  _DPNMSG_ADD_PLAYER_TO_GROUP = packed record
    dwSize: DWORD;            // Size of this structure
    dpnidGroup: TDPNID;       // DPNID of group
    pvGroupContext: Pointer;  // Group context value
    dpnidPlayer: TDPNID;      // DPNID of added player
    pvPlayerContext: Pointer; // Player context value
  end;
  {$EXTERNALSYM _DPNMSG_ADD_PLAYER_TO_GROUP}
  DPNMSG_ADD_PLAYER_TO_GROUP = _DPNMSG_ADD_PLAYER_TO_GROUP;
  {$EXTERNALSYM DPNMSG_ADD_PLAYER_TO_GROUP}
  TDPNMsgAddPlayerToGroup = _DPNMSG_ADD_PLAYER_TO_GROUP;

  //
  // Async operation completion structure for message handler
  // (DPN_MSGID_ASYNC_OP_COMPLETE)
  //
  PDPNMsgAsyncOpComplete = ^TDPNMsgAsyncOpComplete;
  _DPNMSG_ASYNC_OP_COMPLETE = packed record
    dwSize: DWORD;          // Size of this structure
    hAsyncOp: TDPNHandle;   // DirectPlay8 async operation handle
    pvUserContext: Pointer; // User context supplied
    hResultCode: HRESULT;   // HRESULT of operation
  end;
  {$EXTERNALSYM _DPNMSG_ASYNC_OP_COMPLETE}
  DPNMSG_ASYNC_OP_COMPLETE = _DPNMSG_ASYNC_OP_COMPLETE;
  {$EXTERNALSYM DPNMSG_ASYNC_OP_COMPLETE}
  TDPNMsgAsyncOpComplete = _DPNMSG_ASYNC_OP_COMPLETE;

  //
  // Client info structure for message handler
  // (DPN_MSGID_CLIENT_INFO)
  //
  PDPNMsgClientInfo = ^TDPNMsgClientInfo;
  _DPNMSG_CLIENT_INFO = packed record
    dwSize: DWORD;            // Size of this structure
    dpnidClient: TDPNID;      // DPNID of client
    pvPlayerContext: Pointer; // Player context value
  end;
  {$EXTERNALSYM _DPNMSG_CLIENT_INFO}
  DPNMSG_CLIENT_INFO = _DPNMSG_CLIENT_INFO;
  {$EXTERNALSYM DPNMSG_CLIENT_INFO}
  TDPNMsgClientInfo = _DPNMSG_CLIENT_INFO;

  //
  // Connect complete structure for message handler
  // (DPN_MSGID_CONNECT_COMPLETE)
  //
  PDPNMsgConnectComplete = ^TDPNMsgConnectComplete;
  _DPNMSG_CONNECT_COMPLETE = packed record
    dwSize: DWORD;                     // Size of this structure
    hAsyncOp: TDPNHandle;              // DirectPlay8 Async operation handle
    pvUserContext: Pointer;            // User context supplied at Connect
    hResultCode: HRESULT;              // HRESULT of connection attempt
    pvApplicationReplyData: Pointer;   // Connection reply data from Host/Server
    dwApplicationReplyDataSize: DWORD; // Size (in bytes) of pvApplicationReplyData

    // Fields added for DirectX 9
    dpnidLocal: TDPNID;                // DPNID of local player
  end;
  {$EXTERNALSYM _DPNMSG_CONNECT_COMPLETE}
  DPNMSG_CONNECT_COMPLETE = _DPNMSG_CONNECT_COMPLETE;
  {$EXTERNALSYM DPNMSG_CONNECT_COMPLETE}
  TDPNMsgConnectComplete = _DPNMSG_CONNECT_COMPLETE;

  //
  // Create group structure for message handler
  // (DPN_MSGID_CREATE_GROUP)
  //
  PDPNMsgCreateGroup = ^TDPNMsgCreateGroup;
  _DPNMSG_CREATE_GROUP = packed record
    dwSize: DWORD;           // Size of this structure
    dpnidGroup: TDPNID;      // DPNID of new group
    dpnidOwner: TDPNID;      // Owner of newgroup
    pvGroupContext: Pointer; // Group context value

    // Fields added for DirectX 9
    pvOwnerContext: Pointer; // Owner context value
  end;
  {$EXTERNALSYM _DPNMSG_CREATE_GROUP}
  DPNMSG_CREATE_GROUP = _DPNMSG_CREATE_GROUP;
  {$EXTERNALSYM DPNMSG_CREATE_GROUP}
  TDPNMsgCreateGroup = _DPNMSG_CREATE_GROUP;

  //
  // Create player structure for message handler
  // (DPN_MSGID_CREATE_PLAYER)
  //
  PDPNMsgCreatePlayer = ^TDPNMsgCreatePlayer;
  _DPNMSG_CREATE_PLAYER = packed record
    dwSize: DWORD;            // Size of this structure
    dpnidPlayer: DPNID;       // DPNID of new player
    pvPlayerContext: Pointer; // Player context value
  end;
  {$EXTERNALSYM _DPNMSG_CREATE_PLAYER}
  DPNMSG_CREATE_PLAYER = _DPNMSG_CREATE_PLAYER;
  {$EXTERNALSYM DPNMSG_CREATE_PLAYER}
  TDPNMsgCreatePlayer = _DPNMSG_CREATE_PLAYER;

  //
  // Destroy group structure for message handler
  // (DPN_MSGID_DESTROY_GROUP)
  //
  PDPNMsgDestroyGroup = ^TDPNMsgDestroyGroup;
  _DPNMSG_DESTROY_GROUP = packed record
    dwSize: DWORD;           // Size of this structure
    dpnidGroup: TDPNID;      // DPNID of destroyed group
    pvGroupContext: Pointer; // Group context value
    dwReason: DWORD;         // Information only
  end;
  {$EXTERNALSYM _DPNMSG_DESTROY_GROUP}
  DPNMSG_DESTROY_GROUP = _DPNMSG_DESTROY_GROUP;
  {$EXTERNALSYM DPNMSG_DESTROY_GROUP}
  TDPNMsgDestroyGroup = _DPNMSG_DESTROY_GROUP;

  //
  // Destroy player structure for message handler
  // (DPN_MSGID_DESTROY_PLAYER)
  //
  PDPNMsgDestroyPlayer = ^TDPNMsgDestroyPlayer;
  _DPNMSG_DESTROY_PLAYER = packed record
    dwSize: DWORD;            // Size of this structure
    dpnidPlayer: TDPNID;      // DPNID of leaving player
    pvPlayerContext: Pointer; // Player context value
    dwReason: DWORD;          // Information only
  end;
  {$EXTERNALSYM _DPNMSG_DESTROY_PLAYER}
  DPNMSG_DESTROY_PLAYER = _DPNMSG_DESTROY_PLAYER;
  {$EXTERNALSYM DPNMSG_DESTROY_PLAYER}
  TDPNMsgDestroyPlayer = _DPNMSG_DESTROY_PLAYER;

  //
  // Enumeration request received structure for message handler
  // (DPN_MSGID_ENUM_HOSTS_QUERY)
  //
  PDPNMsgEnumHostsQuery = ^TDPNMsgEnumHostsQuery;
  _DPNMSG_ENUM_HOSTS_QUERY = packed record
    dwSize: DWORD;                        // Size of this structure.
    pAddressSender: IDirectPlay8Address;  // Address of client who sent the request
    pAddressDevice: IDirectPlay8Address;  // Address of device request was received on
    pvReceivedData: Pointer;              // Request data (set on client)
    dwReceivedDataSize: DWORD;            // Request data size (set on client)
    dwMaxResponseDataSize: DWORD;         // Max allowable size of enum response
    pvResponseData: Pointer;              // Optional query repsonse (user set)
    dwResponseDataSize: DWORD;            // Optional query response size (user set)
    pvResponseContext: Pointer;           // Optional query response context (user set)
  end;
  {$EXTERNALSYM _DPNMSG_ENUM_HOSTS_QUERY}
  DPNMSG_ENUM_HOSTS_QUERY = _DPNMSG_ENUM_HOSTS_QUERY;
  {$EXTERNALSYM DPNMSG_ENUM_HOSTS_QUERY}
  TDPNMsgEnumHostsQuery = _DPNMSG_ENUM_HOSTS_QUERY;

  //
  // Enumeration response received structure for message handler
  // (DPN_MSGID_ENUM_HOSTS_RESPONSE)
  //
  PDPNMsgEnumHostsResponse = ^TDPNMsgEnumHostsResponse;
  _DPNMSG_ENUM_HOSTS_RESPONSE = packed record
    dwSize: DWORD;                                // Size of this structure
    pAddressSender: IDirectPlay8Address;          // Address of host who responded
    pAddressDevice: IDirectPlay8Address;          // Device response was received on
    pApplicationDescription: PDPNApplicationDesc; // Application description for the session
    pvResponseData: Pointer;                      // Optional response data (set on host)
    dwResponseDataSize: DWORD;                    // Optional response data size (set on host)
    pvUserContext: Pointer;                       // Context value supplied for enumeration
    dwRoundTripLatencyMS: DWORD;                  // Round trip latency in MS
  end;
  {$EXTERNALSYM _DPNMSG_ENUM_HOSTS_RESPONSE}
  DPNMSG_ENUM_HOSTS_RESPONSE = _DPNMSG_ENUM_HOSTS_RESPONSE;
  {$EXTERNALSYM DPNMSG_ENUM_HOSTS_RESPONSE}
  TDPNMsgEnumHostsResponse = _DPNMSG_ENUM_HOSTS_RESPONSE;

  //
  // Group info structure for message handler
  // (DPN_MSGID_GROUP_INFO)
  //
  PDPNMsgGroupInfo = ^TDPNMsgGroupInfo;
  _DPNMSG_GROUP_INFO = packed record
    dwSize: DWORD;              // Size of this structure
    dpnidGroup: TDPNID;         // DPNID of group
    pvGroupContext: Pointer;    // Group context value
  end;
  {$EXTERNALSYM _DPNMSG_GROUP_INFO}
  DPNMSG_GROUP_INFO = _DPNMSG_GROUP_INFO;
  {$EXTERNALSYM DPNMSG_GROUP_INFO}
  TDPNMsgGroupInfo = _DPNMSG_GROUP_INFO;

  //
  // Migrate host structure for message handler
  // (DPN_MSGID_HOST_MIGRATE)
  //
  PDPNMsgHostMigrate = ^TDPNMsgHostMigrate;
  _DPNMSG_HOST_MIGRATE = packed record
    dwSize: DWORD;             // Size of this structure
    dpnidNewHost: TDPNID;      // DPNID of new Host player
    pvPlayerContext: Pointer;  // Player context value
  end;
  {$EXTERNALSYM _DPNMSG_HOST_MIGRATE}
  DPNMSG_HOST_MIGRATE = _DPNMSG_HOST_MIGRATE;
  {$EXTERNALSYM DPNMSG_HOST_MIGRATE}
  TDPNMsgHostMigrate = _DPNMSG_HOST_MIGRATE;

  //
  // Indicate connect structure for message handler
  // (DPN_MSGID_INDICATE_CONNECT)
  //
  PDPNMsgIndicateConnect = ^TDPNMsgIndicateConnect;
  _DPNMSG_INDICATE_CONNECT = packed record
    dwSize: DWORD;                        // Size of this structure
    pvUserConnectData: Pointer;           // Connecting player data
    dwUserConnectDataSize: DWORD;         // Size (in bytes) of pvUserConnectData
    pvReplyData: Pointer;                 // Connection reply data
    dwReplyDataSize: DWORD;               // Size (in bytes) of pvReplyData
    pvReplyContext: Pointer;              // Buffer context for pvReplyData
    pvPlayerContext: Pointer;             // Player context preset
    pAddressPlayer: IDirectPlay8Address;  // Address of connecting player
    pAddressDevice: IDirectPlay8Address;  // Address of device receiving connect attempt
  end;
  {$EXTERNALSYM _DPNMSG_INDICATE_CONNECT}
  DPNMSG_INDICATE_CONNECT = _DPNMSG_INDICATE_CONNECT;
  {$EXTERNALSYM DPNMSG_INDICATE_CONNECT}
  TDPNMsgIndicateConnect = _DPNMSG_INDICATE_CONNECT;

  //
  // Indicated connect aborted structure for message handler
  // (DPN_MSGID_INDICATED_CONNECT_ABORTED)
  //
  PDPNMsgIndicatedConnectAborted = ^TDPNMsgIndicatedConnectAborted;
  _DPNMSG_INDICATED_CONNECT_ABORTED = packed record
    dwSize: DWORD;            // Size of this structure
    pvPlayerContext: Pointer; // Player context preset from DPNMSG_INDICATE_CONNECT
  end;
  {$EXTERNALSYM _DPNMSG_INDICATED_CONNECT_ABORTED}
  DPNMSG_INDICATED_CONNECT_ABORTED = _DPNMSG_INDICATED_CONNECT_ABORTED;
  {$EXTERNALSYM DPNMSG_INDICATED_CONNECT_ABORTED}
  TDPNMsgIndicatedConnectAborted = _DPNMSG_INDICATED_CONNECT_ABORTED;

  //
  // Peer info structure for message handler
  // (DPN_MSGID_PEER_INFO)
  //
  PDPNMsgPeerInfo = ^TDPNMsgPeerInfo;
  _DPNMSG_PEER_INFO = packed record
    dwSize: DWORD;              // Size of this structure
    dpnidPeer: TDPNID;          // DPNID of peer
    pvPlayerContext: Pointer;   // Player context value
  end;
  {$EXTERNALSYM _DPNMSG_PEER_INFO}
  DPNMSG_PEER_INFO = _DPNMSG_PEER_INFO;
  {$EXTERNALSYM DPNMSG_PEER_INFO}
  TDPNMsgPeerInfo = _DPNMSG_PEER_INFO;

  //
  // Receive structure for message handler
  // (DPN_MSGID_RECEIVE)
  //
  PDPNMsgReceive = ^TDPNMsgReceive;
  _DPNMSG_RECEIVE = packed record
    dwSize: DWORD;             // Size of this structure
    dpnidSender: TDPNID;       // DPNID of sending player
    pvPlayerContext: Pointer;  // Player context value of sending player
    pReceiveData: PByte;       // Received data
    dwReceiveDataSize: DWORD;  // Size (in bytes) of pReceiveData
    hBufferHandle: TDPNHandle; // Buffer handle for pReceiveData

    // Fields added for DirectX 9
    dwReceiveFlags: DWORD;     // Flags describing how message was received
  end;
  {$EXTERNALSYM _DPNMSG_RECEIVE}
  DPNMSG_RECEIVE = _DPNMSG_RECEIVE;
  {$EXTERNALSYM DPNMSG_RECEIVE}
  TDPNMsgReceive = _DPNMSG_RECEIVE;

  //
  // Remove player from group structure for message handler
  // (DPN_MSGID_REMOVE_PLAYER_FROM_GROUP)
  //
  PDPNMsgRemovePlayerFromGroup = ^TDPNMsgRemovePlayerFromGroup;
  _DPNMSG_REMOVE_PLAYER_FROM_GROUP = packed record
    dwSize: DWORD;               // Size of this structure
    dpnidGroup: TDPNID;          // DPNID of group
    pvGroupContext: Pointer;     // Group context value
    dpnidPlayer: TDPNID;         // DPNID of deleted player
    pvPlayerContext: Pointer;    // Player context value
  end;
  {$EXTERNALSYM _DPNMSG_REMOVE_PLAYER_FROM_GROUP}
  DPNMSG_REMOVE_PLAYER_FROM_GROUP = _DPNMSG_REMOVE_PLAYER_FROM_GROUP;
  {$EXTERNALSYM DPNMSG_REMOVE_PLAYER_FROM_GROUP}
  TDPNMsgRemovePlayerFromGroup = _DPNMSG_REMOVE_PLAYER_FROM_GROUP;

  //
  // Returned buffer structure for message handler
  // (DPN_MSGID_RETURN_BUFFER)
  //
  PDPNMsgReturnBuffer = ^TDPNMsgReturnBuffer;
  _DPNMSG_RETURN_BUFFER = packed record
    dwSize: DWORD;          // Size of this structure
    hResultCode: HRESULT;   // Return value of operation
    pvBuffer: Pointer;      // Buffer being returned
    pvUserContext: Pointer; // Context associated with buffer
  end;
  {$EXTERNALSYM _DPNMSG_RETURN_BUFFER}
  DPNMSG_RETURN_BUFFER = _DPNMSG_RETURN_BUFFER;
  {$EXTERNALSYM DPNMSG_RETURN_BUFFER}
  TDPNMsgReturnBuffer = _DPNMSG_RETURN_BUFFER;

  //
  // Send complete structure for message handler
  // (DPN_MSGID_SEND_COMPLETE)
  //
  PDPNMsgSendComplete = ^TDPNMsgSendComplete;
  _DPNMSG_SEND_COMPLETE = packed record
    dwSize: DWORD;          // Size of this structure
    hAsyncOp: TDPNHandle;   // DirectPlay8 Async operation handle
    pvUserContext: Pointer; // User context supplied at Send/SendTo
    hResultCode: HRESULT;   // HRESULT of send
    dwSendTime: DWORD;      // Send time in ms

    // Fields added for DirectX 9
    dwFirstFrameRTT: DWORD;		// RTT of the first frame in the message
    dwFirstFrameRetryCount: DWORD;	// Retry count of the first frame
    dwSendCompleteFlags: DWORD;	// Flags describing how message was sent
    pBuffers: PDPNBufferDesc;				// Pointer to array of buffers sent, if DirectPlay did not make a copy
    dwNumBuffers: DWORD;			// Number of buffers in previous array
  end;
  {$EXTERNALSYM _DPNMSG_SEND_COMPLETE}
  DPNMSG_SEND_COMPLETE = _DPNMSG_SEND_COMPLETE;
  {$EXTERNALSYM DPNMSG_SEND_COMPLETE}
  TDPNMsgSendComplete = _DPNMSG_SEND_COMPLETE;

  //
  // Server info structure for message handler
  // (DPN_MSGID_SERVER_INFO)
  //
  PDPNMsgServerInfo = ^TDPNMsgServerInfo;
  _DPNMSG_SERVER_INFO = packed record
    dwSize: DWORD;              // Size of this structure
    dpnidServer: TDPNID;        // DPNID of server
    pvPlayerContext: Pointer;   // Player context value
  end;
  {$EXTERNALSYM _DPNMSG_SERVER_INFO}
  DPNMSG_SERVER_INFO = _DPNMSG_SERVER_INFO;
  {$EXTERNALSYM DPNMSG_SERVER_INFO}
  TDPNMsgServerInfo = _DPNMSG_SERVER_INFO;

  //
  // Terminated session structure for message handler
  // (DPN_MSGID_TERMINATE_SESSION)
  //
  PDPNMsgTerminateSession = ^TDPNMsgTerminateSession;
  _DPNMSG_TERMINATE_SESSION = packed record
    dwSize: DWORD;              // Size of this structure
    hResultCode: HRESULT;       // Reason
    pvTerminateData: Pointer;   // Data passed from Host/Server
    dwTerminateDataSize: DWORD; // Size (in bytes) of pvTerminateData
  end;
  {$EXTERNALSYM _DPNMSG_TERMINATE_SESSION}
  DPNMSG_TERMINATE_SESSION = _DPNMSG_TERMINATE_SESSION;
  {$EXTERNALSYM DPNMSG_TERMINATE_SESSION}
  TDPNMsgTerminateSession = _DPNMSG_TERMINATE_SESSION;

  //
  // Message structures added for DirectX 9
  //

  //
  // Create thread info structure for message handler
  // (DPN_MSGID_CREATE_THREAD)
  //
  PDPNMsgCreateThread = ^TDPNMsgCreateThread;
  _DPNMSG_CREATE_THREAD = packed record
    dwSize: DWORD;				// Size of this structure
    dwFlags: DWORD;			// Flags describing this thread
    dwProcessorNum: DWORD;		// Index of processor to which thread is bound
    pvUserContext: Pointer;		// Thread context value
  end;
  {$EXTERNALSYM _DPNMSG_CREATE_THREAD}
  DPNMSG_CREATE_THREAD = _DPNMSG_CREATE_THREAD;
  {$EXTERNALSYM DPNMSG_CREATE_THREAD}
  TDPNMsgCreateThread = _DPNMSG_CREATE_THREAD;

  //
  // Destroy thread info structure for message handler
  // (DPN_MSGID_DESTROY_THREAD)
  //
  PDPNMsgDestroyThread = ^TDPNMsgDestroyThread;
  _DPNMSG_DESTROY_THREAD = packed record
    dwSize:	DWORD;				// Size of this structure
    dwProcessorNum:	DWORD;		// Index of processor to which thread was bound
    pvUserContext:	Pointer;		// Thread context value
  end;
  {$EXTERNALSYM _DPNMSG_DESTROY_THREAD}
  DPNMSG_DESTROY_THREAD = _DPNMSG_DESTROY_THREAD;
  {$EXTERNALSYM DPNMSG_DESTROY_THREAD}
  TDPNMsgDestroyThread = _DPNMSG_DESTROY_THREAD;


  //
  // Query-to-resolve-NAT-address structure for message handler
  // (DPN_MSGID_NAT_RESOLVER_QUERY)
  //
  PDPNMsgNatResolverQuery = ^TDPNMsgNatResolverQuery;
  _DPNMSG_NAT_RESOLVER_QUERY = packed record
    dwSize: DWORD;				// Size of this structure.
    pAddressSender: IDirectPlay8Address;	// Address of client that sent the query
    pAddressDevice: IDirectPlay8Address;	// Address of device on which query was received
    pwszUserString: PWideChar;	// User specified string, or NULL if none
  end;
  {$EXTERNALSYM _DPNMSG_NAT_RESOLVER_QUERY}
  DPNMSG_NAT_RESOLVER_QUERY = _DPNMSG_NAT_RESOLVER_QUERY;
  {$EXTERNALSYM DPNMSG_NAT_RESOLVER_QUERY}
  TDPNMsgNatResolverQuery = _DPNMSG_NAT_RESOLVER_QUERY;


(****************************************************************************
 *
 * DirectPlay8 Functions
 *
 ****************************************************************************)

(*
 * This function is no longer supported.  It is recommended that CoCreateInstance be used to create
 * DirectPlay8 objects.
 *
 * extern HRESULT WINAPI DirectPlay8Create( const GUID * pcIID, void **ppvInterface, IUnknown *pUnknown);
 *
 *)
 

(****************************************************************************
 *
 * DirectPlay8Lobby Interface Pointer
 *
 ****************************************************************************)

  IDirectPlay8LobbiedApplication = interface;

(****************************************************************************
 *
 * DirectPlay8 Application Interfaces
 *
 ****************************************************************************)

  //
  // COM definition for DirectPlay8 Client interface
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectPlay8Client);'}
  {$EXTERNALSYM IDirectPlay8Client}
  IDirectPlay8Client = interface(IUnknown)
    ['{5102dacd-241b-11d3-aea7-006097b01411}']
    (*** IDirectPlay8Client methods ***)
    function Initialize(pvUserContext: Pointer; pfn: TFNDPNMessageHandler; dwFlags: DWORD): HResult; stdcall;
    function EnumServiceProviders(pguidServiceProvider, pguidApplication: PGUID;
      pSPInfoBuffer: PDPNServiceProviderInfo; out pcbEnumData, pcReturned: DWORD;
      dwFlags: DWORD): HResult; stdcall;
    function EnumHosts(const pApplicationDesc: TDPNApplicationDesc;
      pAddrHost, pDeviceInfo: IDirectPlay8Address; pUserEnumData: Pointer;
      dwUserEnumDataSize, dwEnumCount, dwRetryInterval, dwTimeOut: DWORD;
      pvUserContext: Pointer; pAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function CancelAsyncOperation(hAsyncHandle: TDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function Connect(const pdnAppDesc: TDPNApplicationDesc;
      pHostAddr: IDirectPlay8Address; pDeviceInfo: IDirectPlay8Address;
      pdnSecurity: PDPNSecurityDesc; pdnCredentials: PDPNSecurityCredentials;
      pvUserConnectData: Pointer; dwUserConnectDataSize: DWORD; pvAsyncContext: Pointer;
      phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function Send(const prgBufferDesc: TDPNBufferDesc; cBufferDesc, dwTimeOut: DWORD;
      pvAsyncContext: Pointer; phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function GetSendQueueInfo(pdwNumMsgs, pdwNumBytes: PDWORD; dwFlags: DWORD): HResult; stdcall;
    function GetApplicationDesc(pAppDescBuffer: PDPNApplicationDesc; var pcbDataSize: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetClientInfo(const pdpnPlayerInfo: TDPNPlayerInfo; pvAsyncContext: Pointer;
      phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function GetServerInfo(pdpnPlayerInfo: PDPNPlayerInfo; var pdwSize: DWORD; dwFlags: DWORD): HResult; stdcall;
    function GetServerAddress(out pAddress: IDirectPlay8Address; dwFlags: DWORD): HResult; stdcall;
    function Close(dwFlags: DWORD): HResult; stdcall;
    function ReturnBuffer(hBufferHandle: TDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function GetCaps(pdpCaps: PDPNCaps; dwFlags: DWORD): HResult; stdcall; //Translator: pdpCaps can be either PDPNCaps or PDPNCapsEx
    function SetCaps(pdpCaps: PDPNCaps; dwFlags: DWORD): HResult; stdcall; //Translator: pdpCaps can be either PDPNCaps or PDPNCapsEx
    function SetSPCaps(const pguidSP: TGUID; const pdpspCaps: TDPNSpCaps; dwFlags: DWORD): HResult; stdcall;
    function GetSPCaps(const pguidSP: TGUID; var pdpspCaps: TDPNSpCaps; dwFlags: DWORD): HResult; stdcall;
    function GetConnectionInfo(var pdpConnectionInfo: TDPNConnectionInfo; dwFlags: DWORD): HResult; stdcall;
    function RegisterLobby(dpnHandle: TDPNHandle; pIDP8LobbiedApplication: IDirectPlay8LobbiedApplication; dwFlags: DWORD): HResult; stdcall;
  end;

  //
  // COM definition for DirectPlay8 Server interface
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectPlay8Server);'}
  {$EXTERNALSYM IDirectPlay8Server}
  IDirectPlay8Server = interface(IUnknown)
    ['{5102dace-241b-11d3-aea7-006097b01411}']
    (*** IDirectPlay8Server methods ***)
    function Initialize(pvUserContext: Pointer; pfn: TFNDPNMessageHandler; dwFlags: DWORD): HResult; stdcall;
    function EnumServiceProviders(pguidServiceProvider, pguidApplication: PGUID;
      pSPInfoBuffer: PDPNServiceProviderInfo; out pcbEnumData, pcReturned: DWORD;
      dwFlags: DWORD): HResult; stdcall;
    function CancelAsyncOperation(hAsyncHandle: TDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function GetSendQueueInfo(dpnid: TDPNID; pdwNumMsgs, pdwNumBytes: PDWORD; dwFlags: DWORD): HResult; stdcall;
    function GetApplicationDesc(pAppDescBuffer: PDPNApplicationDesc; var pcbDataSize: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetServerInfo(pdpnPlayerInfo: PDPNPlayerInfo; pvAsyncContext: Pointer; phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function GetClientInfo(dpnid: TDPNID; pdpnPlayerInfo: PDPNPlayerInfo; pdwSize: PDWORD; dwFlags: DWORD): HResult; stdcall;
    function GetClientAddress(dpnid: TDPNID; out pAddress: IDirectPlay8Address; dwFlags: DWORD): HResult; stdcall;
    function GetLocalHostAddresses(out prgpAddress: IDirectPlay8Address; var pcAddress: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetApplicationDesc(const pad: TDPNApplicationDesc; dwFlags: DWORD): HResult; stdcall;
    function Host(const pdnAppDesc: TDPNApplicationDesc; prgpDeviceInfo: PIDirectPlay8Address;
      cDeviceInfo: DWORD; pdnSecurity: PDPNSecurityDesc; pdnCredentials: PDPNSecurityCredentials;
      pvPlayerContext: Pointer; dwFlags: DWORD): HResult; stdcall;
    function SendTo(dpnid: TDPNID; const prgBufferDesc: TDPNBufferDesc; cBufferDesc, dwTimeOut: DWORD;
      pvAsyncContext: Pointer; phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function CreateGroup(const pdpnGroupInfo: TDPNGroupInfo; pvGroupContext, pvAsyncContext: Pointer;
      phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function DestroyGroup(idGroup: TDPNID; pvAsyncContext: Pointer;
      phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function AddPlayerToGroup(idGroup, idClient: TDPNID; pvAsyncContext: Pointer;
      phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function RemovePlayerFromGroup(idGroup, idClient: TDPNID; pvAsyncContext: Pointer;
      phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function SetGroupInfo(dpnid: TDPNID; const pdpnGroupInfo: TDPNGroupInfo; pvAsyncContext: Pointer; phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function GetGroupInfo(dpnid: TDPNID; pdpnGroupInfo: PDPNGroupInfo; pdwSize: PDWORD; dwFlags: DWORD): HResult; stdcall; //todo: Changed
    function EnumPlayersAndGroups(prgdpnid: PDPNID; var pcdpnid: DWORD; dwFlags: DWORD): HResult; stdcall;
    function EnumGroupMembers(dpnid: TDPNID; prgdpnid: PDPNID; var pcdpnid: DWORD; dwFlags: DWORD): HResult; stdcall;
    function Close(dwFlags: DWORD): HResult; stdcall;
    function DestroyClient(dpnidClient: TDPNID; pvDestroyData: Pointer; dwDestroyDataSize: DWORD; dwFlags: DWORD): HResult; stdcall;
    function ReturnBuffer(hBufferHandle: TDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function GetPlayerContext(dpnid: TDPNID; out ppvPlayerContext: Pointer; dwFlags: DWORD): HResult; stdcall;
    function GetGroupContext(dpnid: TDPNID; out ppvGroupContext: Pointer; dwFlags: DWORD): HResult; stdcall;
    function GetCaps(pdpCaps: PDPNCaps; dwFlags: DWORD): HResult; stdcall; //Translator: pdpCaps can be either PDPNCaps or PDPNCapsEx
    function SetCaps(pdpCaps: PDPNCaps; dwFlags: DWORD): HResult; stdcall; //Translator: pdpCaps can be either PDPNCaps or PDPNCapsEx
    function SetSPCaps(const pguidSP: TGUID; const pdpspCaps: TDPNSpCaps; dwFlags: DWORD): HResult; stdcall;
    function GetSPCaps(const pguidSP: TGUID; var pdpspCaps: TDPNSpCaps; dwFlags: DWORD): HResult; stdcall;
    function GetConnectionInfo(dpnid: TDPNID; var pdpConnectionInfo: TDPNConnectionInfo; dwFlags: DWORD): HResult; stdcall;
    function RegisterLobby(dpnHandle: TDPNHandle; pIDP8LobbiedApplication: IDirectPlay8LobbiedApplication; dwFlags: DWORD): HResult; stdcall;
  end;

  //
  // COM definition for DirectPlay8 Peer interface
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectPlay8Peer);'}
  {$EXTERNALSYM IDirectPlay8Peer}
  IDirectPlay8Peer = interface(IUnknown)
    ['{5102dacf-241b-11d3-aea7-006097b01411}']
    (*** IDirectPlay8Peer methods ***)
    function Initialize(pvUserContext: Pointer; pfn: TFNDPNMessageHandler; dwFlags: DWORD): HResult; stdcall;
    function EnumServiceProviders(pguidServiceProvider, pguidApplication: PGUID;
      pSPInfoBuffer: PDPNServiceProviderInfo; out pcbEnumData, pcReturned: DWORD;
      dwFlags: DWORD): HResult; stdcall;
    function CancelAsyncOperation(hAsyncHandle: TDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function Connect(const pdnAppDesc: TDPNApplicationDesc;
      pHostAddr: IDirectPlay8Address; pDeviceInfo: IDirectPlay8Address;
      pdnSecurity: PDPNSecurityDesc; pdnCredentials: PDPNSecurityCredentials;
      pvUserConnectData: Pointer; dwUserConnectDataSize: DWORD;
      pvPlayerContext, pvAsyncContext: Pointer;
      phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function SendTo(dpnid: TDPNID; const prgBufferDesc: TDPNBufferDesc; cBufferDesc, dwTimeOut: DWORD;
      pvAsyncContext: Pointer; phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function GetSendQueueInfo(dpnid: TDPNID; pdwNumMsgs, pdwNumBytes: PDWORD; dwFlags: DWORD): HResult; stdcall;
    function Host(const pdnAppDesc: TDPNApplicationDesc; prgpDeviceInfo: PIDirectPlay8Address;
      cDeviceInfo: DWORD; pdnSecurity: PDPNSecurityDesc; pdnCredentials: PDPNSecurityCredentials;
      pvPlayerContext: Pointer; dwFlags: DWORD): HResult; stdcall;
    function GetApplicationDesc(pAppDescBuffer: PDPNApplicationDesc; var pcbDataSize: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetApplicationDesc(const pad: TDPNApplicationDesc; dwFlags: DWORD): HResult; stdcall;
    function CreateGroup(const pdpnGroupInfo: TDPNGroupInfo; pvGroupContext, pvAsyncContext: Pointer;
      phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function DestroyGroup(idGroup: TDPNID; pvAsyncContext: Pointer;
      phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function AddPlayerToGroup(idGroup, idClient: TDPNID; pvAsyncContext: Pointer;
      phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function RemovePlayerFromGroup(idGroup, idClient: TDPNID; pvAsyncContext: Pointer;
      phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function SetGroupInfo(dpnid: TDPNID; const pdpnGroupInfo: TDPNGroupInfo; pvAsyncContext: Pointer; phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function GetGroupInfo(dpnid: TDPNID; pdpnGroupInfo: PDPNGroupInfo; pdwSize: PDWORD; dwFlags: DWORD): HResult; stdcall; //todo: Changed
    function EnumPlayersAndGroups(prgdpnid: PDPNID; var pcdpnid: DWORD; dwFlags: DWORD): HResult; stdcall;
    function EnumGroupMembers(dpnid: TDPNID; prgdpnid: PDPNID; var pcdpnid: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetPeerInfo(const pdpnPlayerInfo: TDPNPlayerInfo; pvAsyncContext: Pointer;
      phAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function GetPeerInfo(dpnid: TDPNID; var pdpnPlayerInfo: TDPNPlayerInfo; pdwSize: PDWORD; dwFlags: DWORD): HResult; stdcall; //todo: Changed
    function GetPeerAddress(dpnid: TDPNID; out pAddress: IDirectPlay8Address; dwFlags: DWORD): HResult; stdcall;
    function GetLocalHostAddresses(prgpAddress: PIDirectPlay8Address; var pcAddress: DWORD; dwFlags: DWORD): HResult; stdcall;
    function Close(dwFlags: DWORD): HResult; stdcall;
    function EnumHosts(const pApplicationDesc: TDPNApplicationDesc;
      pAddrHost, pDeviceInfo: IDirectPlay8Address; pUserEnumData: Pointer;
      dwUserEnumDataSize, dwEnumCount, dwRetryInterval, dwTimeOut: DWORD;
      pvUserContext: Pointer; pAsyncHandle: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function DestroyPeer(dpnidClient: TDPNID; pvDestroyData: Pointer; dwDestroyDataSize, dwFlags: DWORD): HResult; stdcall;
    function ReturnBuffer(hBufferHandle: TDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function GetPlayerContext(dpnid: TDPNID; out ppvPlayerContext: Pointer; dwFlags: DWORD): HResult; stdcall;
    function GetGroupContext(dpnid: TDPNID; out ppvGroupContext: Pointer; dwFlags: DWORD): HResult; stdcall;
    function GetCaps(pdpCaps: PDPNCaps; dwFlags: DWORD): HResult; stdcall; //Translator: pdpCaps can be either PDPNCaps or PDPNCapsEx
    function SetCaps(pdpCaps: PDPNCaps; dwFlags: DWORD): HResult; stdcall; //Translator: pdpCaps can be either PDPNCaps or PDPNCapsEx
    function SetSPCaps(const pguidSP: TGUID; const pdpspCaps: TDPNSpCaps; dwFlags: DWORD): HResult; stdcall;
    function GetSPCaps(const pguidSP: TGUID; var pdpspCaps: TDPNSpCaps; dwFlags: DWORD): HResult; stdcall;
    function GetConnectionInfo(dpnid: TDPNID; var pdpConnectionInfo: TDPNConnectionInfo; dwFlags: DWORD): HResult; stdcall;
    function RegisterLobby(dpnHandle: TDPNHandle; pIDP8LobbiedApplication: IDirectPlay8LobbiedApplication; dwFlags: DWORD): HResult; stdcall; 
    function TerminateSession(pvTerminateData: Pointer; dwTerminateDataSize, dwFlags: DWORD): HResult; stdcall;
  end;


  //
  // COM definition for DirectPlay8 Thread Pool interface
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectPlay8ThreadPool);'}
  {$EXTERNALSYM IDirectPlay8ThreadPool}
  IDirectPlay8ThreadPool = interface(IUnknown)
    ['{0d22ee73-4a46-4a0d-89b2-045b4d666425}']
    (*** IDirectPlay8ThreadPool methods ***)
    function Initialize(pvUserContext: Pointer; pfn: TFNDPNMessageHandler; dwFlags: DWORD): HResult; stdcall;
    function Close(dwFlags: DWORD): HResult; stdcall;
    function GetThreadCount(dwProcessorNum: DWORD; out pdwNumThreads: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetThreadCount(dwProcessorNum: DWORD; dwNumThreads: DWORD; dwFlags: DWORD): HResult; stdcall;
    function DoWork(dwAllowedTimeSlice: DWORD; dwFlags: DWORD): HResult; stdcall;
  end;


  //
  // COM definition for DirectPlay8 NAT Resolver interface
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectPlay8NATResolver);'}
  {$EXTERNALSYM IDirectPlay8NATResolver}
  IDirectPlay8NATResolver = interface(IUnknown)
    ['{a9e213f2-9a60-486f-bf3b-53408b6d1cbb}']
    (*** IDirectPlay8NATResolver methods ***)
    function Initialize(pvUserContext: Pointer; pfn: TFNDPNMessageHandler; dwFlags: DWORD): HResult; stdcall;
    function Start(ppDevices: PIDirectPlay8Address; dwNumDevices: DWORD; dwFlags: DWORD): HResult; stdcall;
    function Close(dwFlags: DWORD): HResult; stdcall;
    function EnumDevices(pSPInfoBuffer: PDPNServiceProviderInfo; var pdwBufferSize: DWORD; out pdwNumDevices: DWORD; dwFlags: DWORD): HResult; stdcall;
    function GetAddresses(ppAddresses: PIDirectPlay8Address; out pdwNumAddresses: DWORD; dwFlags: DWORD): HResult; stdcall;
  end;


(****************************************************************************
 *
 * DirectPlay8 Interface IIDs
 *
 ****************************************************************************)

  // {5102DACD-241B-11d3-AEA7-006097B01411}
  IID_IDirectPlay8Client = IDirectPlay8Client;
  {$EXTERNALSYM IID_IDirectPlay8Client}

  // {5102DACE-241B-11d3-AEA7-006097B01411}
  IID_IDirectPlay8Server = IDirectPlay8Server;
  {$EXTERNALSYM IID_IDirectPlay8Server}

  // {5102DACF-241B-11d3-AEA7-006097B01411}
  IID_IDirectPlay8Peer = IDirectPlay8Peer;
  {$EXTERNALSYM IID_IDirectPlay8Peer}


  // IIDs added for DirectX 9

  // {0D22EE73-4A46-4a0d-89B2-045B4D666425}
  IID_IDirectPlay8ThreadPool = IDirectPlay8ThreadPool;
  {$EXTERNALSYM IID_IDirectPlay8ThreadPool}

  // {A9E213F2-9A60-486f-BF3B-53408B6D1CBB}
  IID_IDirectPlay8NATResolver = IDirectPlay8NATResolver;
  {$EXTERNALSYM IID_IDirectPlay8NATResolver}



(*==========================================================================
 *
 *  Copyright (C) 2000 Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       DPLobby.h
 *  Content:    DirectPlay8 Lobby Include File
 *
 ***************************************************************************)


(****************************************************************************
 *
 * DirectPlay8Lobby Structures (Non-Message)
 *
 ****************************************************************************)

  //
  // Information on a registered game
  //
  PDPLApplicationInfo = ^TDPLApplicationInfo;
  _DPL_APPLICATION_INFO = packed record
    guidApplication: TGUID;            // GUID of the application
    pwszApplicationName: PWideChar;    // Name of the application
    dwNumRunning: DWORD;               // # of instances of this application running
    dwNumWaiting: DWORD;               // # of instances of this application waiting
    dwFlags: DWORD;                    // Flags
  end;
  {$EXTERNALSYM _DPL_APPLICATION_INFO}
  DPL_APPLICATION_INFO = _DPL_APPLICATION_INFO;
  {$EXTERNALSYM DPL_APPLICATION_INFO}
  TDPLApplicationInfo = _DPL_APPLICATION_INFO;

  //
  // Settings to be used for connecting / hosting a game session
  //
  PDPLConnectionSettings = ^TDPLConnectionSettings;
  _DPL_CONNECTION_SETTINGS = packed record
    dwSize: DWORD;                    // Size of this structure
    dwFlags: DWORD;                // Connection settings flags (DPLCONNECTSETTINGS_...)
    dpnAppDesc: TDPNApplicationDesc;             // Application desc for the associated DirectPlay session
    pdp8HostAddress: IDirectPlay8Address;       // Address of host to connect to
    ppdp8DeviceAddresses: IDirectPlay8Address; // Address of device to connect from / host on
    cNumDeviceAddresses: DWORD;    // # of addresses specified in ppdp8DeviceAddresses
    pwszPlayerName: PWideChar;         // Name to give the player
  end;
  {$EXTERNALSYM _DPL_CONNECTION_SETTINGS}
  DPL_CONNECTION_SETTINGS = _DPL_CONNECTION_SETTINGS;
  {$EXTERNALSYM DPL_CONNECTION_SETTINGS}
  TDPLConnectionSettings = _DPL_CONNECTION_SETTINGS;

  //
  // Information for performing a lobby connect
  // (ConnectApplication)
  //
  PDPLConnectInfo = ^TDPLConnectInfo;
  _DPL_CONNECT_INFO = packed record
    dwSize: DWORD;                                  // Size of this structure
    dwFlags: DWORD;                                 // Flags (DPLCONNECT_...)
    guidApplication: TGUID;                         // GUID of application to launch
    pdplConnectionSettings: PDPLConnectionSettings; // Settings application should use
    pvLobbyConnectData: Pointer;                    // User defined data block
    dwLobbyConnectDataSize: DWORD;                  // Size of user defined data block
  end;
  {$EXTERNALSYM _DPL_CONNECT_INFO}
  DPL_CONNECT_INFO = _DPL_CONNECT_INFO;
  {$EXTERNALSYM DPL_CONNECT_INFO}
  TDPLConnectInfo = _DPL_CONNECT_INFO;

  //
  // Information for registering an application
  // (RegisterApplication)
  //
  PDPLProgramDesc = ^TDPLProgramDesc;
  _DPL_PROGRAM_DESC = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    guidApplication: TGUID;               // Application GUID
    pwszApplicationName: PWideChar;       // Unicode application name
    pwszCommandLine: PWideChar;           // Unicode command line arguments
    pwszCurrentDirectory: PWideChar;      // Unicode current directory
    pwszDescription: PWideChar;           // Unicode application description
    pwszExecutableFilename: PWideChar;    // Unicode filename of application executable
    pwszExecutablePath: PWideChar;        // Unicode path of application executable
    pwszLauncherFilename: PWideChar;      // Unicode filename of launcher executable
    pwszLauncherPath: PWideChar;          // Unicode path of launcher executable
  end;
  {$EXTERNALSYM _DPL_PROGRAM_DESC}
  DPL_PROGRAM_DESC = _DPL_PROGRAM_DESC;
  {$EXTERNALSYM DPL_PROGRAM_DESC}
  TDPLProgramDesc = _DPL_PROGRAM_DESC;

(****************************************************************************
 *
 * DirectPlay8 Lobby Message Structures
 *
 ****************************************************************************)

  //
  // A connection was established
  // (DPL_MSGID_CONNECT)
  //
  PDPLMessageConnect = ^TDPLMessageConnect;
  _DPL_MESSAGE_CONNECT = packed record
    dwSize: DWORD;                 // Size of this structure
    hConnectId: TDPNHandle;        // Handle of new connection
    pdplConnectionSettings: PDPLConnectionSettings; // Connection settings for this connection
    pvLobbyConnectData: Pointer;   // User defined lobby data block
    dwLobbyConnectDataSize: DWORD; // Size of user defined lobby data block
    pvConnectionContext: Pointer;  // Context value for this connection (user set)
  end;
  {$EXTERNALSYM _DPL_MESSAGE_CONNECT}
  DPL_MESSAGE_CONNECT = _DPL_MESSAGE_CONNECT;
  {$EXTERNALSYM DPL_MESSAGE_CONNECT}
  TDPLMessageConnect = _DPL_MESSAGE_CONNECT;

  //
  // Connection settings have been updated
  // (DPL_MSGID_CONNECTION_SETTINGS)
  //
  PDPLMessageConnectionSettings = ^TDPLMessageConnectionSettings;
  _DPL_MESSAGE_CONNECTION_SETTINGS = packed record
    dwSize: DWORD;                // Size of this structure
    hSender: TDPNHandle;          // Handle of the connection for these settings
    pdplConnectionSettings: PDPLConnectionSettings;     // Connection settings
    pvConnectionContext: Pointer; // Context value for this connection
  end;
  {$EXTERNALSYM _DPL_MESSAGE_CONNECTION_SETTINGS}
  DPL_MESSAGE_CONNECTION_SETTINGS = _DPL_MESSAGE_CONNECTION_SETTINGS;
  {$EXTERNALSYM DPL_MESSAGE_CONNECTION_SETTINGS}
  TDPLMessageConnectionSettings = _DPL_MESSAGE_CONNECTION_SETTINGS;

  //
  // A connection has been disconnected
  // (DPL_MSGID_DISCONNECT)
  //
  PDPLMessageDisconnect = ^TDPLMessageDisconnect;
  _DPL_MESSAGE_DISCONNECT = packed record
    dwSize: DWORD;                // Size of this structure
    hDisconnectId: TDPNHandle;    // Handle of the connection that was terminated
    hrReason: HRESULT;            // Reason the connection was broken
    pvConnectionContext: Pointer; // Context value for this connection
  end;
  {$EXTERNALSYM _DPL_MESSAGE_DISCONNECT}
  DPL_MESSAGE_DISCONNECT = _DPL_MESSAGE_DISCONNECT;
  {$EXTERNALSYM DPL_MESSAGE_DISCONNECT}
  TDPLMessageDisconnect = _DPL_MESSAGE_DISCONNECT;

  //
  // Data was received through a connection
  // (DPL_MSGID_RECEIVE)
  //
  PDPLMessageReceive = ^TDPLMessageReceive;
  _DPL_MESSAGE_RECEIVE = packed record
    dwSize: DWORD;                  // Size of this structure
    hSender: TDPNHandle;            // Handle of the connection that is from
    pBuffer: PByte;                 // Contents of the message
    dwBufferSize: DWORD;            // Size of the message context
    pvConnectionContext: Pointer;   // Context value for this connection
  end;
  {$EXTERNALSYM _DPL_MESSAGE_RECEIVE}
  DPL_MESSAGE_RECEIVE = _DPL_MESSAGE_RECEIVE;
  {$EXTERNALSYM DPL_MESSAGE_RECEIVE}
  TDPLMessageReceive = _DPL_MESSAGE_RECEIVE;

  //
  // Current status of the associated connection
  // (DPL_MSGID_SESSION_STATUS)
  //
  PDPLMessageSessionStatus = ^TDPLMessageSessionStatus;
  _DPL_MESSAGE_SESSION_STATUS = packed record
    dwSize: DWORD;                // Size of this structure
    hSender: TDPNHandle;          // Handle of the connection that this is from
    dwStatus: DWORD;              // Status (DPLSESSION_...)
    pvConnectionContext: Pointer; // Context value for this connection
  end;
  {$EXTERNALSYM _DPL_MESSAGE_SESSION_STATUS}
  DPL_MESSAGE_SESSION_STATUS = _DPL_MESSAGE_SESSION_STATUS;
  {$EXTERNALSYM DPL_MESSAGE_SESSION_STATUS}
  TDPLMessageSessionStatus = _DPL_MESSAGE_SESSION_STATUS;

(****************************************************************************
 *
 * DirectPlay8Lobby Create
 *
 ****************************************************************************)
 
(*
 * This function is no longer supported.  It is recommended that CoCreateInstance be used to create
 * DirectPlay8 lobby objects.
 *
 * extern HRESULT WINAPI DirectPlay8LobbyCreate( const GUID * pcIID, void **ppvInterface, IUnknown *pUnknown);
 *
 *)

(****************************************************************************
 *
 * DirectPlay8 Functions
 *
 ****************************************************************************)

  //
  // COM definition for DirectPlayLobbyClient
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectPlay8LobbyClient);'}
  {$EXTERNALSYM IDirectPlay8LobbyClient}
  IDirectPlay8LobbyClient = interface(IUnknown)
    ['{819074a2-016c-11d3-ae14-006097b01411}']
    // IDirectPlayLobbyClient methods
    function Initialize(pvUserContext: Pointer; pfn: TFNDPNMessageHandler; dwFlags: DWORD): HResult; stdcall;
    function EnumLocalPrograms(pGuidApplication: PGUID; pEnumData: PByte; var pdwEnumData: DWORD; out pdwItems: DWORD; dwFlags: DWORD): HResult; stdcall;
    function ConnectApplication(const pdplConnectionInfo: PDPLConnectInfo;
      pvConnectionContext: Pointer; hApplication: PDPNHandle; dwTimeOut, dwFlags: DWORD): HResult; stdcall;
    function Send(hConnection: TDPNHandle; pBuffer: PByte; pBufferSize, dwFlags: DWORD): HResult; stdcall;
    function ReleaseApplication(hConnection: TDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function Close(dwFlags: DWORD): HResult; stdcall;
    function GetConnectionSettings(hConnection: TDPNHandle; pdplSessionInfo: PDPLConnectionSettings; var pdwInfoSize: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetConnectionSettings(hConnection: TDPNHandle; const pdplSessionInfo: TDPLConnectionSettings; dwFlags: DWORD): HResult; stdcall;
  end;


  //
  // COM definition for DirectPlayLobbiedApplication
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectPlay8LobbiedApplication);'}
  {$EXTERNALSYM IDirectPlay8LobbiedApplication}
  IDirectPlay8LobbiedApplication = interface(IUnknown)
    ['{819074a3-016c-11d3-ae14-006097b01411}']
    // IDirectPlayLobbiedApplication methods
    function Initialize(pvUserContext: Pointer; pfn: TFNDPNMessageHandler; pdpnhConnection: PDPNHandle; dwFlags: DWORD): HResult; stdcall;
    function RegisterProgram(const pdplProgramDesc: TDPLProgramDesc; dwFlags: DWORD): HResult; stdcall;
    function UnRegisterProgram(const pguidApplication: TGUID; dwFlags: DWORD): HResult; stdcall;
    function Send(hConnection: TDPNHandle; pBuffer: PByte; pBufferSize: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetAppAvailable(fAvailable: BOOL;  dwFlags: DWORD): HResult; stdcall;
    function UpdateStatus(hConnection: TDPNHandle; dwStatus, dwFlags: DWORD): HResult; stdcall;
    function Close(dwFlags: DWORD): HResult; stdcall;
    function GetConnectionSettings(hConnection: TDPNHandle; pdplSessionInfo: PDPLConnectionSettings; var pdwInfoSize: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetConnectionSettings(hConnection: TDPNHandle; const pdplSessionInfo: TDPLConnectionSettings; dwFlags: DWORD): HResult; stdcall;
  end;


const
(****************************************************************************
 *
 * DirectPlay8Lobby CLSIDs
 *
 ****************************************************************************)

  // {667955AD-6B3B-43ca-B949-BC69B5BAFF7F}
  CLSID_DirectPlay8LobbiedApplication: TGUID = '{667955ad-6b3b-43ca-b949-bc69b5baff7f}';
  {$EXTERNALSYM CLSID_DirectPlay8LobbiedApplication}

  // {3B2B6775-70B6-45af-8DEA-A209C69559F3}
  CLSID_DirectPlay8LobbyClient: TGUID = '{3b2b6775-70b6-45af-8dea-a209c69559f3}';
  {$EXTERNALSYM CLSID_DirectPlay8LobbyClient}

(****************************************************************************
 *
 * DirectPlay8Lobby Interface IIDs
 *
 ****************************************************************************)

type
  // {819074A3-016C-11d3-AE14-006097B01411}
  IID_IDirectPlay8LobbiedApplication = IDirectPlay8LobbiedApplication;
  {$EXTERNALSYM IID_IDirectPlay8LobbiedApplication}

  // {819074A2-016C-11d3-AE14-006097B01411}
  IID_IDirectPlay8LobbyClient = IDirectPlay8LobbyClient;
  {$EXTERNALSYM IID_IDirectPlay8LobbyClient}

(****************************************************************************
 *
 * DirectPlay8 Lobby Message IDs
 *
 ****************************************************************************)

const
  DPL_MSGID_LOBBY                     = $8000;
  {$EXTERNALSYM DPL_MSGID_LOBBY}
  DPL_MSGID_RECEIVE                   = ($0001 or DPL_MSGID_LOBBY);
  {$EXTERNALSYM DPL_MSGID_RECEIVE}
  DPL_MSGID_CONNECT                   = ($0002 or DPL_MSGID_LOBBY);
  {$EXTERNALSYM DPL_MSGID_CONNECT}
  DPL_MSGID_DISCONNECT                = ($0003 or DPL_MSGID_LOBBY);
  {$EXTERNALSYM DPL_MSGID_DISCONNECT}
  DPL_MSGID_SESSION_STATUS            = ($0004 or DPL_MSGID_LOBBY);
  {$EXTERNALSYM DPL_MSGID_SESSION_STATUS}
  DPL_MSGID_CONNECTION_SETTINGS       = ($0005 or DPL_MSGID_LOBBY);
  {$EXTERNALSYM DPL_MSGID_CONNECTION_SETTINGS}

(****************************************************************************
 *
 * DirectPlay8Lobby Constants
 *
 ****************************************************************************)

  //
  // Specifies that operation should be performed on all open connections
  //
  DPLHANDLE_ALLCONNECTIONS     = $FFFFFFFF;
  {$EXTERNALSYM DPLHANDLE_ALLCONNECTIONS}

  //
  // The associated game session has suceeded in connecting / hosting
  //
  DPLSESSION_CONNECTED         = $0001;
  {$EXTERNALSYM DPLSESSION_CONNECTED}

  // The associated game session failed connecting / hosting
  //
  DPLSESSION_COULDNOTCONNECT   = $0002;
  {$EXTERNALSYM DPLSESSION_COULDNOTCONNECT}

  //
  // The associated game session has disconnected
  //
  DPLSESSION_DISCONNECTED      = $0003;
  {$EXTERNALSYM DPLSESSION_DISCONNECTED}

  //
  // The associated game session has terminated
  //
  DPLSESSION_TERMINATED        = $0004;
  {$EXTERNALSYM DPLSESSION_TERMINATED}

  //
  // The associated game session's host has migrated
  //
  DPLSESSION_HOSTMIGRATED      = $0005;
  {$EXTERNALSYM DPLSESSION_HOSTMIGRATED}

  //
  // The associated game session's host has migrated to the local client
  //
  DPLSESSION_HOSTMIGRATEDHERE  = $0006;
  {$EXTERNALSYM DPLSESSION_HOSTMIGRATEDHERE}


(****************************************************************************
 *
 * DirectPlay8 Lobby Flags
 *
 ****************************************************************************)

  //
  // Do not automatically make the lobby app unavailable when a connection is established
  //
  DPLAVAILABLE_ALLOWMULTIPLECONNECT   = $0001;
  {$EXTERNALSYM DPLAVAILABLE_ALLOWMULTIPLECONNECT}

  //
  // Launch a new instance of the application to connect to
  //
  DPLCONNECT_LAUNCHNEW                = $0001;
  {$EXTERNALSYM DPLCONNECT_LAUNCHNEW}

  //
  // Launch a new instance of the application if one is not waiting
  //
  DPLCONNECT_LAUNCHNOTFOUND           = $0002;
  {$EXTERNALSYM DPLCONNECT_LAUNCHNOTFOUND}

  //
  // When starting the associated game session, start it as a host
  //
  DPLCONNECTSETTINGS_HOST             = $0001;
  {$EXTERNALSYM DPLCONNECTSETTINGS_HOST}

  //
  // Disable parameter validation
  //
  DPLINITIALIZE_DISABLEPARAMVAL       = $0001;
  {$EXTERNALSYM DPLINITIALIZE_DISABLEPARAMVAL}





///// Part 2 of dplay8.h /////
(*==========================================================================;
 *
 *  Copyright (C) 1998-2000 Microsoft Corporation.  All Rights Reserved.
 *
 *  File:		DPlay8.h
 *  Content:	DirectPlay8 include file
 *
 ***************************************************************************)

(****************************************************************************
 *
 * DIRECTPLAY8 ERRORS
 *
 * Errors are represented by negative values and cannot be combined.
 *
 ****************************************************************************)

const
  _DPN_FACILITY_CODE = $015;
  {$EXTERNALSYM _DPN_FACILITY_CODE}
  _DPNHRESULT_BASE   = $8000;
  {$EXTERNALSYM _DPNHRESULT_BASE}

  MAKE_DPNHRESULT_R  = (1 shl 31) or (_DPN_FACILITY_CODE shl 16) + _DPNHRESULT_BASE;

// #define MAKE_DPNHRESULT( code )  MAKE_HRESULT( 1, _DPN_FACILITY_CODE, ( code + _DPNHRESULT_BASE ) )
function MAKE_DPNHRESULT(Code: DWORD): DWORD;
{$EXTERNALSYM MAKE_DPNHRESULT}

const
  DPN_OK                    = S_OK;
  {$EXTERNALSYM DPN_OK}

  DPNSUCCESS_EQUAL          = HRESULT((0 shl 31) or (_DPN_FACILITY_CODE shl 16) or ($5 + _DPNHRESULT_BASE)); // MAKE_HRESULT( 0, _DPN_FACILITY_CODE, ( 0x5 + _DPNHRESULT_BASE ) )
  {$EXTERNALSYM DPNSUCCESS_EQUAL}
  DPNSUCCESS_NOPLAYERSINGROUP = HRESULT((0 shl 31) or (_DPN_FACILITY_CODE shl 16) or ($8 + _DPNHRESULT_BASE)); // MAKE_HRESULT( 0, _DPN_FACILITY_CODE, ( 0x8 + _DPNHRESULT_BASE ) )	// added for DirectX 9
  {$EXTERNALSYM DPNSUCCESS_NOPLAYERSINGROUP}
  DPNSUCCESS_NOTEQUAL       = HRESULT((0 shl 31) or (_DPN_FACILITY_CODE shl 16) or ($A + _DPNHRESULT_BASE)); // MAKE_HRESULT( 0, _DPN_FACILITY_CODE, (0x0A + _DPNHRESULT_BASE ) )
  {$EXTERNALSYM DPNSUCCESS_NOTEQUAL}
  DPNSUCCESS_PENDING        = HRESULT((0 shl 31) or (_DPN_FACILITY_CODE shl 16) or ($e + _DPNHRESULT_BASE)); // MAKE_HRESULT( 0, _DPN_FACILITY_CODE, (0x0e + _DPNHRESULT_BASE ) )
  {$EXTERNALSYM DPNSUCCESS_PENDING}

  DPNERR_ABORTED                 = HRESULT(MAKE_DPNHRESULT_R + $30); // MAKE_DPNHRESULT( 0x30 )
  {$EXTERNALSYM DPNERR_ABORTED}
  DPNERR_ADDRESSING              = HRESULT(MAKE_DPNHRESULT_R + $40); // MAKE_DPNHRESULT( 0x40 )
  {$EXTERNALSYM DPNERR_ADDRESSING}
  DPNERR_ALREADYCLOSING          = HRESULT(MAKE_DPNHRESULT_R + $50); // MAKE_DPNHRESULT( 0x50 )
  {$EXTERNALSYM DPNERR_ALREADYCLOSING}
  DPNERR_ALREADYCONNECTED        = HRESULT(MAKE_DPNHRESULT_R + $60); // MAKE_DPNHRESULT( 0x60 )
  {$EXTERNALSYM DPNERR_ALREADYCONNECTED}
  DPNERR_ALREADYDISCONNECTING    = HRESULT(MAKE_DPNHRESULT_R + $70); // MAKE_DPNHRESULT( 0x70 )
  {$EXTERNALSYM DPNERR_ALREADYDISCONNECTING}
  DPNERR_ALREADYINITIALIZED      = HRESULT(MAKE_DPNHRESULT_R + $80); // MAKE_DPNHRESULT(  0x80 )
  {$EXTERNALSYM DPNERR_ALREADYINITIALIZED}
  DPNERR_ALREADYREGISTERED       = HRESULT(MAKE_DPNHRESULT_R + $90); // MAKE_DPNHRESULT(  0x90 )
  {$EXTERNALSYM DPNERR_ALREADYREGISTERED}
  DPNERR_BUFFERTOOSMALL          = HRESULT(MAKE_DPNHRESULT_R + $100); // MAKE_DPNHRESULT( 0x100 )
  {$EXTERNALSYM DPNERR_BUFFERTOOSMALL}
  DPNERR_CANNOTCANCEL            = HRESULT(MAKE_DPNHRESULT_R + $110); // MAKE_DPNHRESULT( 0x110 )
  {$EXTERNALSYM DPNERR_CANNOTCANCEL}
  DPNERR_CANTCREATEGROUP         = HRESULT(MAKE_DPNHRESULT_R + $120); // MAKE_DPNHRESULT( 0x120 )
  {$EXTERNALSYM DPNERR_CANTCREATEGROUP}
  DPNERR_CANTCREATEPLAYER        = HRESULT(MAKE_DPNHRESULT_R + $130); // MAKE_DPNHRESULT( 0x130 )
  {$EXTERNALSYM DPNERR_CANTCREATEPLAYER}
  DPNERR_CANTLAUNCHAPPLICATION   = HRESULT(MAKE_DPNHRESULT_R + $140); // MAKE_DPNHRESULT( 0x140 )
  {$EXTERNALSYM DPNERR_CANTLAUNCHAPPLICATION}
  DPNERR_CONNECTING              = HRESULT(MAKE_DPNHRESULT_R + $150); // MAKE_DPNHRESULT( 0x150 )
  {$EXTERNALSYM DPNERR_CONNECTING}
  DPNERR_CONNECTIONLOST          = HRESULT(MAKE_DPNHRESULT_R + $160); // MAKE_DPNHRESULT( 0x160 )
  {$EXTERNALSYM DPNERR_CONNECTIONLOST}
  DPNERR_CONVERSION              = HRESULT(MAKE_DPNHRESULT_R + $170); // MAKE_DPNHRESULT( 0x170 )
  {$EXTERNALSYM DPNERR_CONVERSION}
  DPNERR_DATATOOLARGE            = HRESULT(MAKE_DPNHRESULT_R + $175); // MAKE_DPNHRESULT( 0x175 )
  {$EXTERNALSYM DPNERR_DATATOOLARGE}
  DPNERR_DOESNOTEXIST            = HRESULT(MAKE_DPNHRESULT_R + $180); // MAKE_DPNHRESULT( 0x180 )
  {$EXTERNALSYM DPNERR_DOESNOTEXIST}
  DPNERR_DPNSVRNOTAVAILABLE      = HRESULT(MAKE_DPNHRESULT_R + $185); // MAKE_DPNHRESULT( 0x185 )
  {$EXTERNALSYM DPNERR_DPNSVRNOTAVAILABLE}
  DPNERR_DUPLICATECOMMAND        = HRESULT(MAKE_DPNHRESULT_R + $190); // MAKE_DPNHRESULT( 0x190 )
  {$EXTERNALSYM DPNERR_DUPLICATECOMMAND}
  DPNERR_ENDPOINTNOTRECEIVING    = HRESULT(MAKE_DPNHRESULT_R + $200); // MAKE_DPNHRESULT( 0x200 )
  {$EXTERNALSYM DPNERR_ENDPOINTNOTRECEIVING}
  DPNERR_ENUMQUERYTOOLARGE       = HRESULT(MAKE_DPNHRESULT_R + $210); // MAKE_DPNHRESULT( 0x210 )
  {$EXTERNALSYM DPNERR_ENUMQUERYTOOLARGE}
  DPNERR_ENUMRESPONSETOOLARGE    = HRESULT(MAKE_DPNHRESULT_R + $220); // MAKE_DPNHRESULT( 0x220 )
  {$EXTERNALSYM DPNERR_ENUMRESPONSETOOLARGE}
  DPNERR_EXCEPTION               = HRESULT(MAKE_DPNHRESULT_R + $230); // MAKE_DPNHRESULT( 0x230 )
  {$EXTERNALSYM DPNERR_EXCEPTION}
  DPNERR_GENERIC                 = E_FAIL;
  {$EXTERNALSYM DPNERR_GENERIC}
  DPNERR_GROUPNOTEMPTY           = HRESULT(MAKE_DPNHRESULT_R + $240); // MAKE_DPNHRESULT( 0x240 )
  {$EXTERNALSYM DPNERR_GROUPNOTEMPTY}
  DPNERR_HOSTING                 = HRESULT(MAKE_DPNHRESULT_R + $250); // MAKE_DPNHRESULT( 0x250 )
  {$EXTERNALSYM DPNERR_HOSTING}
  DPNERR_HOSTREJECTEDCONNECTION  = HRESULT(MAKE_DPNHRESULT_R + $260); // MAKE_DPNHRESULT( 0x260 )
  {$EXTERNALSYM DPNERR_HOSTREJECTEDCONNECTION}
  DPNERR_HOSTTERMINATEDSESSION   = HRESULT(MAKE_DPNHRESULT_R + $270); // MAKE_DPNHRESULT( 0x270 )
  {$EXTERNALSYM DPNERR_HOSTTERMINATEDSESSION}
  DPNERR_INCOMPLETEADDRESS       = HRESULT(MAKE_DPNHRESULT_R + $280); // MAKE_DPNHRESULT( 0x280 )
  {$EXTERNALSYM DPNERR_INCOMPLETEADDRESS}
  DPNERR_INVALIDADDRESSFORMAT    = HRESULT(MAKE_DPNHRESULT_R + $290); // MAKE_DPNHRESULT( 0x290 )
  {$EXTERNALSYM DPNERR_INVALIDADDRESSFORMAT}
  DPNERR_INVALIDAPPLICATION      = HRESULT(MAKE_DPNHRESULT_R + $300); // MAKE_DPNHRESULT( 0x300 )
  {$EXTERNALSYM DPNERR_INVALIDAPPLICATION}
  DPNERR_INVALIDCOMMAND          = HRESULT(MAKE_DPNHRESULT_R + $310); // MAKE_DPNHRESULT( 0x310 )
  {$EXTERNALSYM DPNERR_INVALIDCOMMAND}
  DPNERR_INVALIDDEVICEADDRESS    = HRESULT(MAKE_DPNHRESULT_R + $320); // MAKE_DPNHRESULT( 0x320 )
  {$EXTERNALSYM DPNERR_INVALIDDEVICEADDRESS}
  DPNERR_INVALIDENDPOINT         = HRESULT(MAKE_DPNHRESULT_R + $330); // MAKE_DPNHRESULT( 0x330 )
  {$EXTERNALSYM DPNERR_INVALIDENDPOINT}
  DPNERR_INVALIDFLAGS            = HRESULT(MAKE_DPNHRESULT_R + $340); // MAKE_DPNHRESULT( 0x340 )
  {$EXTERNALSYM DPNERR_INVALIDFLAGS}
  DPNERR_INVALIDGROUP            = HRESULT(MAKE_DPNHRESULT_R + $350); // MAKE_DPNHRESULT( 0x350 )
  {$EXTERNALSYM DPNERR_INVALIDGROUP}
  DPNERR_INVALIDHANDLE           = HRESULT(MAKE_DPNHRESULT_R + $360); // MAKE_DPNHRESULT( 0x360 )
  {$EXTERNALSYM DPNERR_INVALIDHANDLE}
  DPNERR_INVALIDHOSTADDRESS      = HRESULT(MAKE_DPNHRESULT_R + $370); // MAKE_DPNHRESULT( 0x370 )
  {$EXTERNALSYM DPNERR_INVALIDHOSTADDRESS}
  DPNERR_INVALIDINSTANCE         = HRESULT(MAKE_DPNHRESULT_R + $380); // MAKE_DPNHRESULT( 0x380 )
  {$EXTERNALSYM DPNERR_INVALIDINSTANCE}
  DPNERR_INVALIDINTERFACE        = HRESULT(MAKE_DPNHRESULT_R + $390); // MAKE_DPNHRESULT( 0x390 )
  {$EXTERNALSYM DPNERR_INVALIDINTERFACE}
  DPNERR_INVALIDOBJECT           = HRESULT(MAKE_DPNHRESULT_R + $400); // MAKE_DPNHRESULT( 0x400 )
  {$EXTERNALSYM DPNERR_INVALIDOBJECT}
  DPNERR_INVALIDPARAM            = E_INVALIDARG;
  {$EXTERNALSYM DPNERR_INVALIDPARAM}
  DPNERR_INVALIDPASSWORD         = HRESULT(MAKE_DPNHRESULT_R + $410); // MAKE_DPNHRESULT( 0x410 )
  {$EXTERNALSYM DPNERR_INVALIDPASSWORD}
  DPNERR_INVALIDPLAYER           = HRESULT(MAKE_DPNHRESULT_R + $420); // MAKE_DPNHRESULT( 0x420 )
  {$EXTERNALSYM DPNERR_INVALIDPLAYER}
  DPNERR_INVALIDPOINTER          = E_POINTER;
  {$EXTERNALSYM DPNERR_INVALIDPOINTER}
  DPNERR_INVALIDPRIORITY         = HRESULT(MAKE_DPNHRESULT_R + $430); // MAKE_DPNHRESULT( 0x430 )
  {$EXTERNALSYM DPNERR_INVALIDPRIORITY}
  DPNERR_INVALIDSTRING           = HRESULT(MAKE_DPNHRESULT_R + $440); // MAKE_DPNHRESULT( 0x440 )
  {$EXTERNALSYM DPNERR_INVALIDSTRING}
  DPNERR_INVALIDURL              = HRESULT(MAKE_DPNHRESULT_R + $450); // MAKE_DPNHRESULT( 0x450 )
  {$EXTERNALSYM DPNERR_INVALIDURL}
  DPNERR_INVALIDVERSION          = HRESULT(MAKE_DPNHRESULT_R + $460); // MAKE_DPNHRESULT( 0x460 )
  {$EXTERNALSYM DPNERR_INVALIDVERSION}
  DPNERR_NOCAPS                  = HRESULT(MAKE_DPNHRESULT_R + $470); // MAKE_DPNHRESULT( 0x470 )
  {$EXTERNALSYM DPNERR_NOCAPS}
  DPNERR_NOCONNECTION            = HRESULT(MAKE_DPNHRESULT_R + $480); // MAKE_DPNHRESULT( 0x480 )
  {$EXTERNALSYM DPNERR_NOCONNECTION}
  DPNERR_NOHOSTPLAYER            = HRESULT(MAKE_DPNHRESULT_R + $490); // MAKE_DPNHRESULT( 0x490 )
  {$EXTERNALSYM DPNERR_NOHOSTPLAYER}
  DPNERR_NOINTERFACE             = E_NOINTERFACE;
  {$EXTERNALSYM DPNERR_NOINTERFACE}
  DPNERR_NOMOREADDRESSCOMPONENTS = HRESULT(MAKE_DPNHRESULT_R + $500); // MAKE_DPNHRESULT( 0x500 )
  {$EXTERNALSYM DPNERR_NOMOREADDRESSCOMPONENTS}
  DPNERR_NORESPONSE              = HRESULT(MAKE_DPNHRESULT_R + $510); // MAKE_DPNHRESULT( 0x510 )
  {$EXTERNALSYM DPNERR_NORESPONSE}
  DPNERR_NOTALLOWED              = HRESULT(MAKE_DPNHRESULT_R + $520); // MAKE_DPNHRESULT( 0x520 )
  {$EXTERNALSYM DPNERR_NOTALLOWED}
  DPNERR_NOTHOST                 = HRESULT(MAKE_DPNHRESULT_R + $530); // MAKE_DPNHRESULT( 0x530 )
  {$EXTERNALSYM DPNERR_NOTHOST}
  DPNERR_NOTREADY                = HRESULT(MAKE_DPNHRESULT_R + $540); // MAKE_DPNHRESULT( 0x540 )
  {$EXTERNALSYM DPNERR_NOTREADY}
  DPNERR_NOTREGISTERED           = HRESULT(MAKE_DPNHRESULT_R + $550); // MAKE_DPNHRESULT( 0x550 )
  {$EXTERNALSYM DPNERR_NOTREGISTERED}
  DPNERR_OUTOFMEMORY             = E_OUTOFMEMORY;
  {$EXTERNALSYM DPNERR_OUTOFMEMORY}
  DPNERR_PENDING                 = DPNSUCCESS_PENDING;
  {$EXTERNALSYM DPNERR_PENDING}
  DPNERR_PLAYERALREADYINGROUP    = HRESULT(MAKE_DPNHRESULT_R + $560); // MAKE_DPNHRESULT( 0x560 )
  {$EXTERNALSYM DPNERR_PLAYERALREADYINGROUP}
  DPNERR_PLAYERLOST              = HRESULT(MAKE_DPNHRESULT_R + $570); // MAKE_DPNHRESULT( 0x570 )
  {$EXTERNALSYM DPNERR_PLAYERLOST}
  DPNERR_PLAYERNOTINGROUP        = HRESULT(MAKE_DPNHRESULT_R + $580); // MAKE_DPNHRESULT( 0x580 )
  {$EXTERNALSYM DPNERR_PLAYERNOTINGROUP}
  DPNERR_PLAYERNOTREACHABLE      = HRESULT(MAKE_DPNHRESULT_R + $590); // MAKE_DPNHRESULT( 0x590 )
  {$EXTERNALSYM DPNERR_PLAYERNOTREACHABLE}
  DPNERR_SENDTOOLARGE            = HRESULT(MAKE_DPNHRESULT_R + $600); // MAKE_DPNHRESULT( 0x600 )
  {$EXTERNALSYM DPNERR_SENDTOOLARGE}
  DPNERR_SESSIONFULL             = HRESULT(MAKE_DPNHRESULT_R + $610); // MAKE_DPNHRESULT( 0x610 )
  {$EXTERNALSYM DPNERR_SESSIONFULL}
  DPNERR_TABLEFULL               = HRESULT(MAKE_DPNHRESULT_R + $620); // MAKE_DPNHRESULT( 0x620 )
  {$EXTERNALSYM DPNERR_TABLEFULL}
  DPNERR_TIMEDOUT                = HRESULT(MAKE_DPNHRESULT_R + $630); // MAKE_DPNHRESULT( 0x630 )
  {$EXTERNALSYM DPNERR_TIMEDOUT}
  DPNERR_UNINITIALIZED           = HRESULT(MAKE_DPNHRESULT_R + $640); // MAKE_DPNHRESULT( 0x640 )
  {$EXTERNALSYM DPNERR_UNINITIALIZED}
  DPNERR_UNSUPPORTED             = E_NOTIMPL;
  {$EXTERNALSYM DPNERR_UNSUPPORTED}
  DPNERR_USERCANCEL              = HRESULT(MAKE_DPNHRESULT_R + $650); // MAKE_DPNHRESULT( 0x650 )
  {$EXTERNALSYM DPNERR_USERCANCEL}




(*==========================================================================;
 *
 *  Copyright (C) 1999 Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       dpvoice.h
 *  Content:    DirectPlayVoice include file
 ***************************************************************************)


const
(****************************************************************************
 *
 * DirectPlayVoice CLSIDs
 *
 ****************************************************************************)


  // {B9F3EB85-B781-4ac1-8D90-93A05EE37D7D}
  CLSID_DirectPlayVoiceClient: TGUID = '{b9f3eb85-b781-4ac1-8d90-93a05ee37d7d}';
  {$EXTERNALSYM CLSID_DirectPlayVoiceClient}

  // {D3F5B8E6-9B78-4a4c-94EA-CA2397B663D3}
  CLSID_DirectPlayVoiceServer: TGUID = '{d3f5b8e6-9b78-4a4c-94ea-ca2397b663d3}';
  {$EXTERNALSYM CLSID_DirectPlayVoiceServer}

  // {0F0F094B-B01C-4091-A14D-DD0CD807711A}
  CLSID_DirectPlayVoiceTest: TGUID = '{0f0f094b-b01c-4091-a14d-dd0cd807711a}';
  {$EXTERNALSYM CLSID_DirectPlayVoiceTest}

(****************************************************************************
 *
 * DirectPlayVoice Compression Type GUIDs
 *
 ****************************************************************************)

  // MS-ADPCM 32.8 kbit/s
  //
  // {699B52C1-A885-46a8-A308-97172419ADC7}
  DPVCTGUID_ADPCM: TGUID = '{699b52c1-a885-46a8-a308-97172419adc7}';
  {$EXTERNALSYM DPVCTGUID_ADPCM}

  // Microsoft GSM 6.10 13 kbit/s
  //
  // {24768C60-5A0D-11d3-9BE4-525400D985E7}
  DPVCTGUID_GSM: TGUID = '{24768c60-5a0d-11d3-9be4-525400d985e7}';
  {$EXTERNALSYM DPVCTGUID_GSM}

  // MS-PCM 64 kbit/s
  //
  // {8DE12FD4-7CB3-48ce-A7E8-9C47A22E8AC5}
  DPVCTGUID_NONE: TGUID = '{8de12fd4-7cb3-48ce-a7e8-9c47a22e8ac5}';
  {$EXTERNALSYM DPVCTGUID_NONE}

  // Voxware SC03 3.2kbit/s
  //
  // {7D82A29B-2242-4f82-8F39-5D1153DF3E41}
  DPVCTGUID_SC03: TGUID = '{7d82a29b-2242-4f82-8f39-5d1153df3e41}';
  {$EXTERNALSYM DPVCTGUID_SC03}

  // Voxware SC06 6.4kbit/s
  //
  // {53DEF900-7168-4633-B47F-D143916A13C7}
  DPVCTGUID_SC06: TGUID = '{53def900-7168-4633-b47f-d143916a13c7}';
  {$EXTERNALSYM DPVCTGUID_SC06}

  // TrueSpeech(TM) 8.6 kbit/s
  //
  // {D7954361-5A0B-11d3-9BE4-525400D985E7}
  DPVCTGUID_TRUESPEECH: TGUID = '{d7954361-5a0b-11d3-9be4-525400d985e7}';
  {$EXTERNALSYM DPVCTGUID_TRUESPEECH}

  // Voxware VR12 1.4kbit/s
  //
  // {FE44A9FE-8ED4-48bf-9D66-1B1ADFF9FF6D}
  DPVCTGUID_VR12: TGUID = '{fe44a9fe-8ed4-48bf-9d66-1b1adff9ff6d}';
  {$EXTERNALSYM DPVCTGUID_VR12}

  // Define the default compression type
  DPVCTGUID_DEFAULT: TGUID = '{7d82a29b-2242-4f82-8f39-5d1153df3e41}'; // DPVCTGUID_SC03;
  {$EXTERNALSYM DPVCTGUID_DEFAULT}

(****************************************************************************
 *
 * DirectPlayVoice Callback Functions
 *
 ****************************************************************************)

type
  TDVMessageHandler = function(pvUserContext: Pointer; dwMessageType: DWORD; lpMessage: Pointer): HResult; stdcall;
  {$NODEFINE TDVMessageHandler}
  {$HPPEMIT 'typedef PDVMESSAGEHANDLER TDVMessageHandler;'}

(****************************************************************************
 *
 * DirectPlayVoice Datatypes (Non-Structure / Non-Message)
 *
 ****************************************************************************)

  PDVID = ^DVID;
  DVID = DWORD;
  {$EXTERNALSYM DVID}
  TDVID = DVID;

(****************************************************************************
 *
 * DirectPlayVoice Message Types
 *
 ****************************************************************************)

const
  DVMSGID_BASE                        = $0000;
  {$EXTERNALSYM DVMSGID_BASE}

  DVMSGID_CREATEVOICEPLAYER           = (DVMSGID_BASE+$0001);
  {$EXTERNALSYM DVMSGID_CREATEVOICEPLAYER}
  DVMSGID_DELETEVOICEPLAYER           = (DVMSGID_BASE+$0002);
  {$EXTERNALSYM DVMSGID_DELETEVOICEPLAYER}
  DVMSGID_SESSIONLOST                 = (DVMSGID_BASE+$0003);
  {$EXTERNALSYM DVMSGID_SESSIONLOST}
  DVMSGID_PLAYERVOICESTART            = (DVMSGID_BASE+$0004);
  {$EXTERNALSYM DVMSGID_PLAYERVOICESTART}
  DVMSGID_PLAYERVOICESTOP             = (DVMSGID_BASE+$0005);
  {$EXTERNALSYM DVMSGID_PLAYERVOICESTOP}
  DVMSGID_RECORDSTART                 = (DVMSGID_BASE+$0006);
  {$EXTERNALSYM DVMSGID_RECORDSTART}
  DVMSGID_RECORDSTOP                  = (DVMSGID_BASE+$0007);
  {$EXTERNALSYM DVMSGID_RECORDSTOP}
  DVMSGID_CONNECTRESULT               = (DVMSGID_BASE+$0008);
  {$EXTERNALSYM DVMSGID_CONNECTRESULT}
  DVMSGID_DISCONNECTRESULT            = (DVMSGID_BASE+$0009);
  {$EXTERNALSYM DVMSGID_DISCONNECTRESULT}
  DVMSGID_INPUTLEVEL                  = (DVMSGID_BASE+$000A);
  {$EXTERNALSYM DVMSGID_INPUTLEVEL}
  DVMSGID_OUTPUTLEVEL                 = (DVMSGID_BASE+$000B);
  {$EXTERNALSYM DVMSGID_OUTPUTLEVEL}
  DVMSGID_HOSTMIGRATED                = (DVMSGID_BASE+$000C);
  {$EXTERNALSYM DVMSGID_HOSTMIGRATED}
  DVMSGID_SETTARGETS                  = (DVMSGID_BASE+$000D);
  {$EXTERNALSYM DVMSGID_SETTARGETS}
  DVMSGID_PLAYEROUTPUTLEVEL           = (DVMSGID_BASE+$000E);
  {$EXTERNALSYM DVMSGID_PLAYEROUTPUTLEVEL}
  DVMSGID_LOSTFOCUS                   = (DVMSGID_BASE+$0010);
  {$EXTERNALSYM DVMSGID_LOSTFOCUS}
  DVMSGID_GAINFOCUS                   = (DVMSGID_BASE+$0011);
  {$EXTERNALSYM DVMSGID_GAINFOCUS}
  DVMSGID_LOCALHOSTSETUP              = (DVMSGID_BASE+$0012);
  {$EXTERNALSYM DVMSGID_LOCALHOSTSETUP}
  DVMSGID_MAXBASE                     = (DVMSGID_LOCALHOSTSETUP);
  {$EXTERNALSYM DVMSGID_MAXBASE}
  DVMSGID_MINBASE                     = (DVMSGID_CREATEVOICEPLAYER);
  {$EXTERNALSYM DVMSGID_MINBASE}

(****************************************************************************
 *
 * DirectPlayVoice Constants
 *
 ****************************************************************************)

  //
  // Buffer Aggresiveness Value Ranges
  //
  DVBUFFERAGGRESSIVENESS_MIN          = $00000001;
  {$EXTERNALSYM DVBUFFERAGGRESSIVENESS_MIN}
  DVBUFFERAGGRESSIVENESS_MAX          = $00000064;
  {$EXTERNALSYM DVBUFFERAGGRESSIVENESS_MAX}
  DVBUFFERAGGRESSIVENESS_DEFAULT      = $00000000;
  {$EXTERNALSYM DVBUFFERAGGRESSIVENESS_DEFAULT}

  //
  // Buffer Quality Value Ranges
  //
  DVBUFFERQUALITY_MIN                 = $00000001;
  {$EXTERNALSYM DVBUFFERQUALITY_MIN}
  DVBUFFERQUALITY_MAX                 = $00000064;
  {$EXTERNALSYM DVBUFFERQUALITY_MAX}
  DVBUFFERQUALITY_DEFAULT             = $00000000;
  {$EXTERNALSYM DVBUFFERQUALITY_DEFAULT}

  DVID_SYS                = 0;
  {$EXTERNALSYM DVID_SYS}

  //
  // Used to identify the session host in client/server
  //
  DVID_SERVERPLAYER       = 1;
  {$EXTERNALSYM DVID_SERVERPLAYER}

  //
  // Used to target all players
  //
  DVID_ALLPLAYERS         = 0;
  {$EXTERNALSYM DVID_ALLPLAYERS}

  //
  // Used to identify the main buffer
  //
  DVID_REMAINING          = $FFFFFFFF;
  {$EXTERNALSYM DVID_REMAINING}

  //
  // Input level range
  //
  DVINPUTLEVEL_MIN                    = $00000000;
  {$EXTERNALSYM DVINPUTLEVEL_MIN}
  DVINPUTLEVEL_MAX                    = $00000063; // 99 decimal
  {$EXTERNALSYM DVINPUTLEVEL_MAX}

  DVNOTIFYPERIOD_MINPERIOD            = 20;
  {$EXTERNALSYM DVNOTIFYPERIOD_MINPERIOD}


  DVPLAYBACKVOLUME_DEFAULT            = DSBVOLUME_MAX;
  {$EXTERNALSYM DVPLAYBACKVOLUME_DEFAULT}

  DVRECORDVOLUME_LAST                 = $00000001;
  {$EXTERNALSYM DVRECORDVOLUME_LAST}


  //
  // Use the default value
  //
  DVTHRESHOLD_DEFAULT               = $FFFFFFFF;
  {$EXTERNALSYM DVTHRESHOLD_DEFAULT}

  //
  // Threshold Ranges
  //
  DVTHRESHOLD_MIN                   = $00000000;
  {$EXTERNALSYM DVTHRESHOLD_MIN}
  DVTHRESHOLD_MAX                   = $00000063;	// 99 decimal
  {$EXTERNALSYM DVTHRESHOLD_MAX}

  //
  // Threshold field is not used
  //
  DVTHRESHOLD_UNUSED                = $FFFFFFFE;
  {$EXTERNALSYM DVTHRESHOLD_UNUSED}

  //
  // Session Types
  //
  DVSESSIONTYPE_PEER                  = $00000001;
  {$EXTERNALSYM DVSESSIONTYPE_PEER}
  DVSESSIONTYPE_MIXING                = $00000002;
  {$EXTERNALSYM DVSESSIONTYPE_MIXING}
  DVSESSIONTYPE_FORWARDING            = $00000003;
  {$EXTERNALSYM DVSESSIONTYPE_FORWARDING}
  DVSESSIONTYPE_ECHO                  = $00000004;
  {$EXTERNALSYM DVSESSIONTYPE_ECHO}

(****************************************************************************
 *
 * DirectPlayVoice Flags
 *
 ****************************************************************************)


  //
  // Enable automatic adjustment of the recording volume
  //
  DVCLIENTCONFIG_AUTORECORDVOLUME     = $00000008;
  {$EXTERNALSYM DVCLIENTCONFIG_AUTORECORDVOLUME}

  //
  // Enable automatic voice activation
  //
  DVCLIENTCONFIG_AUTOVOICEACTIVATED   = $00000020;
  {$EXTERNALSYM DVCLIENTCONFIG_AUTOVOICEACTIVATED}

  //
  // Enable echo suppression
  //
  DVCLIENTCONFIG_ECHOSUPPRESSION      = $08000000;
  {$EXTERNALSYM DVCLIENTCONFIG_ECHOSUPPRESSION}

  //
  // Voice Activation manual mode
  //
  DVCLIENTCONFIG_MANUALVOICEACTIVATED = $00000004;
  {$EXTERNALSYM DVCLIENTCONFIG_MANUALVOICEACTIVATED}

  //
  // Only playback voices that have buffers created for them
  //
  DVCLIENTCONFIG_MUTEGLOBAL           = $00000010;
  {$EXTERNALSYM DVCLIENTCONFIG_MUTEGLOBAL}

  //
  // Mute the playback
  //
  DVCLIENTCONFIG_PLAYBACKMUTE         = $00000002;
  {$EXTERNALSYM DVCLIENTCONFIG_PLAYBACKMUTE}

  //
  // Mute the recording
  //
  DVCLIENTCONFIG_RECORDMUTE           = $00000001;
  {$EXTERNALSYM DVCLIENTCONFIG_RECORDMUTE}

  //
  // Complete the operation before returning
  //
  DVFLAGS_SYNC                        = $00000001;
  {$EXTERNALSYM DVFLAGS_SYNC}

  //
  // Just check to see if wizard has been run, and if so what it's results were
  //
  DVFLAGS_QUERYONLY                   = $00000002;
  {$EXTERNALSYM DVFLAGS_QUERYONLY}

  //
  // Shutdown the voice session without migrating the host
  //
  DVFLAGS_NOHOSTMIGRATE               = $00000008;
  {$EXTERNALSYM DVFLAGS_NOHOSTMIGRATE}

  //
  // Allow the back button to be enabled in the wizard
  //
  DVFLAGS_ALLOWBACK                   = $00000010;
  {$EXTERNALSYM DVFLAGS_ALLOWBACK}

  //
  // Disable host migration in the voice session
  //
  DVSESSION_NOHOSTMIGRATION           = $00000001;
  {$EXTERNALSYM DVSESSION_NOHOSTMIGRATION}

  //
  // Server controlled targetting
  //
  DVSESSION_SERVERCONTROLTARGET       = $00000002;
  {$EXTERNALSYM DVSESSION_SERVERCONTROLTARGET}

  //
  // Use DirectSound Normal Mode instead of priority
  //
  DVSOUNDCONFIG_NORMALMODE            = $00000001;
  {$EXTERNALSYM DVSOUNDCONFIG_NORMALMODE}

  //
  // Automatically select the microphone
  //
  DVSOUNDCONFIG_AUTOSELECT            = $00000002;
  {$EXTERNALSYM DVSOUNDCONFIG_AUTOSELECT}

  //
  // Run in half duplex mode
  //
  DVSOUNDCONFIG_HALFDUPLEX            = $00000004;
  {$EXTERNALSYM DVSOUNDCONFIG_HALFDUPLEX}

  //
  // No volume controls are available for the recording device
  //
  DVSOUNDCONFIG_NORECVOLAVAILABLE     = $00000010;
  {$EXTERNALSYM DVSOUNDCONFIG_NORECVOLAVAILABLE}

  //
  // Disable capture sharing
  //
  DVSOUNDCONFIG_NOFOCUS               = $20000000;
  {$EXTERNALSYM DVSOUNDCONFIG_NOFOCUS}

  //
  // Set system conversion quality to high
  //
  DVSOUNDCONFIG_SETCONVERSIONQUALITY	= $00000008;
  {$EXTERNALSYM DVSOUNDCONFIG_SETCONVERSIONQUALITY}

  //
  // Enable strict focus mode
  //
  DVSOUNDCONFIG_STRICTFOCUS           = $40000000;
  {$EXTERNALSYM DVSOUNDCONFIG_STRICTFOCUS}

  //
  // Player is in half duplex mode
  //
  DVPLAYERCAPS_HALFDUPLEX             = $00000001;
  {$EXTERNALSYM DVPLAYERCAPS_HALFDUPLEX}

  //
  // Specifies that player is the local player
  //
  DVPLAYERCAPS_LOCAL                  = $00000002;
  {$EXTERNALSYM DVPLAYERCAPS_LOCAL}


type
(****************************************************************************
 *
 * DirectPlayVoice Interface Pointer definitions
 *
 ****************************************************************************)

  IDirectPlayVoiceServer = interface;

(****************************************************************************
 *
 * DirectPlayVoice Structures (Non-Message)
 *
 ****************************************************************************)


  //
  // DirectPlayVoice Caps
  // (GetCaps / SetCaps)
  //
  PDVCaps = ^TDVCaps;
  DVCAPS = packed record
    dwSize:   DWORD;                 // Size of this structure
    dwFlags:   DWORD;                // Caps flags
  end;
  {$EXTERNALSYM DVCAPS}
  TDVCaps = DVCAPS;

  //
  // DirectPlayVoice Client Configuration
  // (Connect / GetClientConfig)
  //
  PDVClientConfig = ^TDVClientConfig;
  DVCLIENTCONFIG = packed record
    dwSize: DWORD;                 // Size of this structure
    dwFlags: DWORD;                // Flags for client config (DVCLIENTCONFIG_...)
    lRecordVolume: Longint;        // Recording volume
    lPlaybackVolume: Longint;      // Playback volume
    dwThreshold: DWORD;            // Voice Activation Threshold
    dwBufferQuality: DWORD;        // Buffer quality
    dwBufferAggressiveness: DWORD; // Buffer aggressiveness
    dwNotifyPeriod: DWORD;         // Period of notification messages (ms)
  end;
  {$EXTERNALSYM DVCLIENTCONFIG}
  TDVClientConfig = DVCLIENTCONFIG;

  //
  // DirectPlayVoice Compression Type Information
  // (GetCompressionTypes)
  //
  PDVCompressionInfo = ^TDVCompressionInfo;
  DVCOMPRESSIONINFO = packed record
    dwSize: DWORD;                 // Size of this structure
    guidType: TGUID;               // GUID that identifies this compression type
    lpszName: PWideChar;           // String name of this compression type
    lpszDescription: PWideChar;    // Description for this compression type
    dwFlags: DWORD;                // Flags for this compression type
    dwMaxBitsPerSecond: DWORD;     // Maximum # of bit/s this compression type uses
  end;
  {$EXTERNALSYM DVCOMPRESSIONINFO}
  TDVCompressionInfo = DVCOMPRESSIONINFO;

  //
  // DirectPlayVoice Session Description
  // (Host / GetSessionDesc)
  //
  PDVSessionDesc = ^TDVSessionDesc;
  DVSESSIONDESC = packed record
    dwSize: DWORD;                 // Size of this structure
    dwFlags: DWORD;                // Session flags (DVSESSION_...)
    dwSessionType: DWORD;          // Session type (DVSESSIONTYPE_...)
    guidCT: TGUID;                 // Compression Type to use
    dwBufferQuality: DWORD;        // Buffer quality
    dwBufferAggressiveness: DWORD; // Buffer aggresiveness
  end;
  {$EXTERNALSYM DVSESSIONDESC}
  TDVSessionDesc = DVSESSIONDESC;

  //
  // DirectPlayVoice Client Sound Device Configuration
  // (Connect / GetSoundDeviceConfig)
  //
  PDVSoundDeviceConfig = ^TDVSoundDeviceConfig;
  DVSOUNDDEVICECONFIG = packed record
    dwSize: DWORD;                 // Size of this structure
    dwFlags: DWORD;                // Flags for sound config (DVSOUNDCONFIG_...)
    guidPlaybackDevice: TGUID;     // GUID of the playback device to use
    lpdsPlaybackDevice: IDirectSound; // DirectSound Object to use (optional)
    guidCaptureDevice: TGUID;      // GUID of the capture device to use
    lpdsCaptureDevice: IDirectSoundCapture; // DirectSoundCapture Object to use (optional)
    hwndAppWindow: HWND;           // HWND of your application's top-level window
    lpdsMainBuffer: IDirectSoundBuffer; // DirectSoundBuffer to use for playback (optional)
    dwMainBufferFlags: DWORD;      // Flags to pass to Play() on the main buffer
    dwMainBufferPriority: DWORD;   // Priority to set when calling Play() on the main buffer
  end;
  {$EXTERNALSYM DVSOUNDDEVICECONFIG}
  TDVSoundDeviceConfig = DVSOUNDDEVICECONFIG;

(****************************************************************************
 *
 * DirectPlayVoice message handler call back structures
 *
 ****************************************************************************)

  //
  // Result of the Connect() call.  (If it wasn't called Async)
  // (DVMSGID_CONNECTRESULT)
  //
  PDVMsgConnectResult = ^TDVMsgConnectResult;
  DVMSG_CONNECTRESULT = packed record
    dwSize: DWORD;                         // Size of this structure
    hrResult: HRESULT;                     // Result of the Connect() call
  end;
  {$EXTERNALSYM DVMSG_CONNECTRESULT}
  TDVMsgConnectResult = DVMSG_CONNECTRESULT;

  //
  // A new player has entered the voice session
  // (DVMSGID_CREATEVOICEPLAYER)
  //
  PDVMsgCreateVoicePlayer = ^TDVMsgCreateVoicePlayer;
  DVMSG_CREATEVOICEPLAYER = packed record
    dwSize: DWORD;                         // Size of this structure
    dvidPlayer: TDVID;                     // DVID of the player who joined
    dwFlags: DWORD;                        // Player flags (DVPLAYERCAPS_...)
    pvPlayerContext: Pointer;              // Context value for this player (user set)
  end;
  {$EXTERNALSYM DVMSG_CREATEVOICEPLAYER}
  TDVMsgCreateVoicePlayer = DVMSG_CREATEVOICEPLAYER;

  //
  // A player has left the voice session
  // (DVMSGID_DELETEVOICEPLAYER)
  //
  PDVMsgDeleteVoicePlayer = ^TDVMsgDeleteVoicePlayer;
  DVMSG_DELETEVOICEPLAYER = packed record
    dwSize: DWORD;                         // Size of this structure
    dvidPlayer: TDVID;                     // DVID of the player who left
    pvPlayerContext: Pointer;              // Context value for the player
  end;
  {$EXTERNALSYM DVMSG_DELETEVOICEPLAYER}
  TDVMsgDeleteVoicePlayer = DVMSG_DELETEVOICEPLAYER;

  //
  // Result of the Disconnect() call.  (If it wasn't called Async)
  // (DVMSGID_DISCONNECTRESULT)
  //
  PDVMsgDisconnectResult = ^TDVMsgDisconnectResult;
  DVMSG_DISCONNECTRESULT = packed record
    dwSize: DWORD;                         // Size of this structure
    hrResult: HRESULT;                     // Result of the Disconnect() call
  end;
  {$EXTERNALSYM DVMSG_DISCONNECTRESULT}
  TDVMsgDisconnectResult = DVMSG_DISCONNECTRESULT;

  //
  // The voice session host has migrated.
  // (DVMSGID_HOSTMIGRATED)
  //
  PDVMsgHostMigrated = ^TDVMsgHostMigrated;
  DVMSG_HOSTMIGRATED = packed record
    dwSize: DWORD;         // Size of this structure
    dvidNewHostID: TDVID;  // DVID of the player who is now the host
    pdvServerInterface: IDirectPlayVoiceServer; // Pointer to the new host object (if local player is now host)
  end;
  {$EXTERNALSYM DVMSG_HOSTMIGRATED}
  TDVMsgHostMigrated = DVMSG_HOSTMIGRATED;

  //
  // The current input level / recording volume on the local machine
  // (DVMSGID_INPUTLEVEL)
  //
  PDVMsgInputlevel = ^TDVMsgInputlevel;
  DVMSG_INPUTLEVEL = packed record
    dwSize: DWORD;                         // Size of this structure
    dwPeakLevel: DWORD;                    // Current peak level of the audio
    lRecordVolume: Longint;                // Current recording volume
    pvLocalPlayerContext: Pointer;         // Context value for the local player
  end;
  {$EXTERNALSYM DVMSG_INPUTLEVEL}
  TDVMsgInputlevel = DVMSG_INPUTLEVEL;

  //
  // The local client is about to become the new host
  // (DVMSGID_LOCALHOSTSETUP)
  //
  PDVMsgLocalHostSetup = ^TDVMsgLocalHostSetup;
  DVMSG_LOCALHOSTSETUP = packed record
    dwSize: DWORD;             // Size of this structure
    pvContext: Pointer;        // Context value to be passed to Initialize() of new host object
    pMessageHandler: TDVMessageHandler; // Message handler to be used by new host object
  end;
  {$EXTERNALSYM DVMSG_LOCALHOSTSETUP}
  TDVMsgLocalHostSetup = DVMSG_LOCALHOSTSETUP;

  //
  // The current output level for the combined output of all incoming streams.
  // (DVMSGID_OUTPUTLEVEL)
  //
  PDVMsgOutputLevel = ^TDVMsgOutputLevel;
  DVMSG_OUTPUTLEVEL = packed record
    dwSize: DWORD;                         // Size of this structure
    dwPeakLevel: DWORD;                    // Current peak level of the output
    lOutputVolume: Longint;                // Current playback volume
    pvLocalPlayerContext: Pointer;         // Context value for the local player
  end;
  {$EXTERNALSYM DVMSG_OUTPUTLEVEL}
  TDVMsgOutputLevel = DVMSG_OUTPUTLEVEL;

  //
  // The current peak level of an individual player's incoming audio stream as it is
  // being played back.
  // (DVMSGID_PLAYEROUTPUTLEVEL)
  //
  PDVMsgPlayerOutputLevel = ^TDVMsgPlayerOutputLevel;
  DVMSG_PLAYEROUTPUTLEVEL = packed record
    dwSize: DWORD;                         // Size of this structure
    dvidSourcePlayerID: TDVID;             // DVID of the player
    dwPeakLevel: DWORD;                    // Peak level of the player's stream
    pvPlayerContext: Pointer;              // Context value for the player
  end;
  {$EXTERNALSYM DVMSG_PLAYEROUTPUTLEVEL}
  TDVMsgPlayerOutputLevel = DVMSG_PLAYEROUTPUTLEVEL;

  //
  // An audio stream from the specified player has started playing back on the local client.
  // (DVMSGID_PLAYERVOICESTART).
  //
  PDVMsgPlayerVoiceStart = ^TDVMsgPlayerVoiceStart;
  DVMSG_PLAYERVOICESTART = packed record
    dwSize: DWORD;                         // Size of this structure
    dvidSourcePlayerID: TDVID;             // DVID of the Player
    pvPlayerContext: Pointer;              // Context value for this player
  end;
  {$EXTERNALSYM DVMSG_PLAYERVOICESTART}
  TDVMsgPlayerVoiceStart = DVMSG_PLAYERVOICESTART;

  //
  // The audio stream from the specified player has stopped playing back on the local client.
  // (DVMSGID_PLAYERVOICESTOP)
  //
  PDVMsgPlayerVoiceStop = ^TDVMsgPlayerVoiceStop;
  DVMSG_PLAYERVOICESTOP = packed record
    dwSize:   DWORD;                         // Size of this structure
    dvidSourcePlayerID:    DVID;             // DVID of the player
    pvPlayerContext:	Pointer;                // Context value for this player
  end;
  {$EXTERNALSYM DVMSG_PLAYERVOICESTOP}
  TDVMsgPlayerVoiceStop = DVMSG_PLAYERVOICESTOP;

  //
  // Transmission has started on the local machine
  // (DVMSGID_RECORDSTART)
  //
  PDVMsgRecordStart = ^TDVMsgRecordStart;
  DVMSG_RECORDSTART = packed record
    dwSize:   DWORD;                         // Size of this structure
    dwPeakLevel:   DWORD;                    // Peak level that caused transmission to start
    pvLocalPlayerContext:	Pointer;           // Context value for the local player
  end;
  {$EXTERNALSYM DVMSG_RECORDSTART}
  TDVMsgRecordStart = DVMSG_RECORDSTART;

  //
  // Transmission has stopped on the local machine
  // (DVMSGID_RECORDSTOP)
  //
  PDVMsgRecordStop = ^TDVMsgRecordStop;
  DVMSG_RECORDSTOP = packed record
    dwSize: DWORD;                         // Size of this structure
    dwPeakLevel: DWORD;                    // Peak level that caused transmission to stop
    pvLocalPlayerContext: Pointer;         // Context value for the local player
  end;
  {$EXTERNALSYM DVMSG_RECORDSTOP}
  TDVMsgRecordStop = DVMSG_RECORDSTOP;

  //
  // The voice session has been lost
  // (DVMSGID_SESSIONLOST)
  //
  PDVMsgSessionLost = ^TDVMsgSessionLost;
  DVMSG_SESSIONLOST = packed record
    dwSize: DWORD;                         // Size of this structure
    hrResult: HRESULT;                     // Reason the session was disconnected
  end;
  {$EXTERNALSYM DVMSG_SESSIONLOST}
  TDVMsgSessionLost = DVMSG_SESSIONLOST;

  //
  // The target list has been updated for the local client
  // (DVMSGID_SETTARGETS)
  //
  PDVMsgSetTargets = ^TDVMsgSetTargets;
  DVMSG_SETTARGETS = packed record
    dwSize: DWORD;                         // Size of this structure
    dwNumTargets: DWORD;                   // # of targets
    pdvidTargets: PDVID;                   // An array of DVIDs specifying the current targets
  end;
  {$EXTERNALSYM DVMSG_SETTARGETS}
  TDVMsgSetTargets = DVMSG_SETTARGETS;


(****************************************************************************
 *
 * DirectPlayVoice Functions
 *
 ****************************************************************************)

(*
 *
 * This function is no longer supported.  It is recommended that CoCreateInstance be used to create
 * DirectPlay voice objects.
 *
 * extern HRESULT WINAPI DirectPlayVoiceCreate( const GUID * pcIID, void **ppvInterface, IUnknown *pUnknown);
 *
 *)

(****************************************************************************
 *
 * DirectPlay8 Application Interfaces
 *
 ****************************************************************************)

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectPlayVoiceClient);'}
  {$EXTERNALSYM IDirectPlayVoiceClient}
  IDirectPlayVoiceClient = interface(IUnknown)
    ['{1dfdc8ea-bcf7-41d6-b295-ab64b3b23306}']
    (*** IDirectPlayVoiceClient methods ***)
    function Initialize(pVoid: IUnknown; pMessageHandler: TDVMessageHandler;
      pUserContext: Pointer; pdwMessageMask: PDWORD; dwMessageMaskElements: DWORD): HResult; stdcall;
    function Connect(const pSoundDeviceConfig: TDVSoundDeviceConfig;
      const pdvClientConfig: TDVClientConfig; dwFlags: DWORD): HResult; stdcall;
    function Disconnect(dwFlags: DWORD): HResult; stdcall;
    function GetSessionDesc(out pvSessionDesc: TDVSessionDesc): HResult; stdcall;
    function GetClientConfig(out pClientConfig: TDVClientConfig): HResult; stdcall;
    function SetClientConfig(const pClientConfig: TDVClientConfig): HResult; stdcall;
    function GetCaps(out pDVCaps: TDVCaps): HResult; stdcall;
    function GetCompressionTypes(pData: Pointer; var pdwDataSize: DWORD;
      out pdwNumElements: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetTransmitTargets(pdvIDTargets: PDVID; dwNumTargets, dwFlags: DWORD): HResult; stdcall;
    function GetTransmitTargets(pdvIDTargets: PDVID; var dwNumTargets: DWORD; dwFlags: DWORD): HResult; stdcall;
    function Create3DSoundBuffer(dvID: TDVID; lpdsSourceBuffer: IDirectSoundBuffer;
      dwPriority, dwFlags: DWORD; out lpUserBuffer: IDirectSound3DBuffer): HResult; stdcall;
    function Delete3DSoundBuffer(dvID: TDVID; lpUserBuffer: IDirectSound3DBuffer): HResult; stdcall;
    function SetNotifyMask(pdwMessageMask: PDWORD; dwMessageMaskElements: DWORD): HResult; stdcall;
    function GetSoundDeviceConfig(pSoundDeviceConfig: PDVSoundDeviceConfig; var pdwSize: DWORD): HResult; stdcall;
  end;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectPlayVoiceServer);'}
  {$EXTERNALSYM IDirectPlayVoiceServer}
  IDirectPlayVoiceServer = interface(IUnknown)
    ['{faa1c173-0468-43b6-8a2a-ea8a4f2076c9}']
    (*** IDirectPlayVoiceServer methods ***)
    function Initialize(pVoid: IUnknown; pMessageHandler: TDVMessageHandler;
      pUserContext: Pointer; pdwMessageMask: PDWORD; dwMessageMaskElements: DWORD): HResult; stdcall;
    function StartSession(const pSessionDesc: TDVSessionDesc; dwFlags: DWORD): HResult; stdcall;
    function StopSession(dwFlags: DWORD): HResult; stdcall;
    function GetSessionDesc(out pvSessionDesc: TDVSessionDesc): HResult; stdcall;
    function SetSessionDesc(const pvSessionDesc: TDVSessionDesc): HResult; stdcall;
    function GetCaps(out pDVCaps: TDVCaps): HResult; stdcall;
    function GetCompressionTypes(pData: Pointer; var pdwDataSize: DWORD;
      out pdwNumElements: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetTransmitTargets(dvSource: TDVID; pdvIDTargets: PDVID;
      dwNumTargets, dwFlags: DWORD): HResult; stdcall;
    function GetTransmitTargets(dvSource: TDVID; pdvIDTargets: PDVID;
      var dwNumTargets: DWORD; dwFlags: DWORD): HResult; stdcall;
    function SetNotifyMask(pdwMessageMask: PDWORD; dwMessageMaskElements: DWORD): HResult; stdcall;
  end;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirectPlayVoiceTest);'}
  {$EXTERNALSYM IDirectPlayVoiceTest}
  IDirectPlayVoiceTest = interface(IUnknown)
    ['{d26af734-208b-41da-8224-e0ce79810be1}']
    (*** IDirectPlayVoiceTest methods ***)
    function CheckAudioSetup(pguidPlaybackDevice, pguidCaptureDevice: PGUID;
      hwndParent: hWND; dwFlags: DWORD): HResult; stdcall;
  end;

(****************************************************************************
 *
 * DirectPlayVoice Interface IIDs
 *
 ****************************************************************************)

  // {1DFDC8EA-BCF7-41d6-B295-AB64B3B23306}
  IID_IDirectPlayVoiceClient = IDirectPlayVoiceClient;
  {$EXTERNALSYM IID_IDirectPlayVoiceClient}

  // {FAA1C173-0468-43b6-8A2A-EA8A4F2076C9}
  IID_IDirectPlayVoiceServer = IDirectPlayVoiceServer;
  {$EXTERNALSYM IID_IDirectPlayVoiceServer}

  // {D26AF734-208B-41da-8224-E0CE79810BE1}
  IID_IDirectPlayVoiceTest = IDirectPlayVoiceTest;
  {$EXTERNALSYM IID_IDirectPlayVoiceTest}


(****************************************************************************
 *
 * DIRECTPLAYVOICE ERRORS
 *
 * Errors are represented by negative values and cannot be combined.
 *
 ****************************************************************************)

const
  _FACDPV  = $15;
  {$EXTERNALSYM _FACDPV}

//#define MAKE_DVHRESULT( code )          MAKE_HRESULT( 1, _FACDPV, code )

(*
#define DV_FULLDUPLEX                   MAKE_HRESULT( 0, _FACDPV,  0x0005 )
#define DV_HALFDUPLEX                   MAKE_HRESULT( 0, _FACDPV,  0x000A )
#define DV_PENDING						MAKE_HRESULT( 0, _FACDPV,  0x0010 )

#define DVERR_BUFFERTOOSMALL            MAKE_DVHRESULT(  0x001E )
#define DVERR_EXCEPTION                 MAKE_DVHRESULT(  0x004A )
#define DVERR_GENERIC                   E_FAIL
#define DVERR_INVALIDFLAGS              MAKE_DVHRESULT( 0x0078 )
#define DVERR_INVALIDOBJECT             MAKE_DVHRESULT( 0x0082 )
#define DVERR_INVALIDPARAM              E_INVALIDARG
#define DVERR_INVALIDPLAYER             MAKE_DVHRESULT( 0x0087 )
#define DVERR_INVALIDGROUP              MAKE_DVHRESULT( 0x0091 )
#define DVERR_INVALIDHANDLE             MAKE_DVHRESULT( 0x0096 )
#define DVERR_OUTOFMEMORY               E_OUTOFMEMORY
#define DVERR_PENDING                   DV_PENDING
#define DVERR_NOTSUPPORTED              E_NOTIMPL
#define DVERR_NOINTERFACE               E_NOINTERFACE
#define DVERR_SESSIONLOST               MAKE_DVHRESULT( 0x012C )
#define DVERR_NOVOICESESSION            MAKE_DVHRESULT( 0x012E )
#define DVERR_CONNECTIONLOST            MAKE_DVHRESULT( 0x0168 )
#define DVERR_NOTINITIALIZED            MAKE_DVHRESULT( 0x0169 )
#define DVERR_CONNECTED                 MAKE_DVHRESULT( 0x016A )
#define DVERR_NOTCONNECTED              MAKE_DVHRESULT( 0x016B )
#define DVERR_CONNECTABORTING           MAKE_DVHRESULT( 0x016E )
#define DVERR_NOTALLOWED                MAKE_DVHRESULT( 0x016F )
#define DVERR_INVALIDTARGET             MAKE_DVHRESULT( 0x0170 )
#define DVERR_TRANSPORTNOTHOST          MAKE_DVHRESULT( 0x0171 )
#define DVERR_COMPRESSIONNOTSUPPORTED   MAKE_DVHRESULT( 0x0172 )
#define DVERR_ALREADYPENDING            MAKE_DVHRESULT( 0x0173 )
#define DVERR_SOUNDINITFAILURE          MAKE_DVHRESULT( 0x0174 )
#define DVERR_TIMEOUT                   MAKE_DVHRESULT( 0x0175 )
#define DVERR_CONNECTABORTED            MAKE_DVHRESULT( 0x0176 )
#define DVERR_NO3DSOUND                 MAKE_DVHRESULT( 0x0177 )
#define DVERR_ALREADYBUFFERED	        MAKE_DVHRESULT( 0x0178 )
#define DVERR_NOTBUFFERED               MAKE_DVHRESULT( 0x0179 )
#define DVERR_HOSTING                   MAKE_DVHRESULT( 0x017A )
#define DVERR_NOTHOSTING                MAKE_DVHRESULT( 0x017B )
#define DVERR_INVALIDDEVICE             MAKE_DVHRESULT( 0x017C )
#define DVERR_RECORDSYSTEMERROR         MAKE_DVHRESULT( 0x017D )
#define DVERR_PLAYBACKSYSTEMERROR       MAKE_DVHRESULT( 0x017E )
#define DVERR_SENDERROR                 MAKE_DVHRESULT( 0x017F )
#define DVERR_USERCANCEL                MAKE_DVHRESULT( 0x0180 )
#define DVERR_RUNSETUP                  MAKE_DVHRESULT( 0x0183 )
#define DVERR_INCOMPATIBLEVERSION       MAKE_DVHRESULT( 0x0184 )
#define DVERR_INITIALIZED               MAKE_DVHRESULT( 0x0187 )
#define DVERR_INVALIDPOINTER            E_POINTER
#define DVERR_NOTRANSPORT               MAKE_DVHRESULT( 0x0188 )
#define DVERR_NOCALLBACK                MAKE_DVHRESULT( 0x0189 )
#define DVERR_TRANSPORTNOTINIT          MAKE_DVHRESULT( 0x018A )
#define DVERR_TRANSPORTNOSESSION        MAKE_DVHRESULT( 0x018B )
#define DVERR_TRANSPORTNOPLAYER         MAKE_DVHRESULT( 0x018C )
#define DVERR_USERBACK                  MAKE_DVHRESULT( 0x018D )
#define DVERR_NORECVOLAVAILABLE         MAKE_DVHRESULT( 0x018E )
#define DVERR_INVALIDBUFFER				MAKE_DVHRESULT( 0x018F )
#define DVERR_LOCKEDBUFFER				MAKE_DVHRESULT( 0x0190 )
*)

  MAKE_DVHRESULT_R                = (1 shl 31) or (_FACDPV shl 16);

  DV_OK                           = S_OK;
  {$EXTERNALSYM DV_OK}
  DV_FULLDUPLEX                   = (0 shl 31) or (_FACDPV shl 16) or $0005;
  {$EXTERNALSYM DV_FULLDUPLEX}
  DV_HALFDUPLEX                   = (0 shl 31) or (_FACDPV shl 16) or $000A;
  {$EXTERNALSYM DV_HALFDUPLEX}
  DV_PENDING		      	  = (0 shl 31) or (_FACDPV shl 16) or $0010;
  {$EXTERNALSYM DV_PENDING}

  DVERR_BUFFERTOOSMALL            = MAKE_DVHRESULT_R + $001E ;
  {$EXTERNALSYM DVERR_BUFFERTOOSMALL}
  DVERR_EXCEPTION                 = MAKE_DVHRESULT_R + $004A ;
  {$EXTERNALSYM DVERR_EXCEPTION}
  DVERR_GENERIC                   = E_FAIL;
  {$EXTERNALSYM DVERR_GENERIC}
  DVERR_INVALIDFLAGS              = MAKE_DVHRESULT_R + $0078 ;
  {$EXTERNALSYM DVERR_INVALIDFLAGS}
  DVERR_INVALIDOBJECT             = MAKE_DVHRESULT_R + $0082 ;
  {$EXTERNALSYM DVERR_INVALIDOBJECT}
  DVERR_INVALIDPARAM              = E_INVALIDARG;
  {$EXTERNALSYM DVERR_INVALIDPARAM}
  DVERR_INVALIDPLAYER             = MAKE_DVHRESULT_R + $0087 ;
  {$EXTERNALSYM DVERR_INVALIDPLAYER}
  DVERR_INVALIDGROUP              = MAKE_DVHRESULT_R + $0091 ;
  {$EXTERNALSYM DVERR_INVALIDGROUP}
  DVERR_INVALIDHANDLE             = MAKE_DVHRESULT_R + $0096 ;
  {$EXTERNALSYM DVERR_INVALIDHANDLE}
  DVERR_OUTOFMEMORY               = E_OUTOFMEMORY;
  {$EXTERNALSYM DVERR_OUTOFMEMORY}
  DVERR_PENDING                   = DV_PENDING;
  {$EXTERNALSYM DVERR_PENDING}
  DVERR_NOTSUPPORTED              = E_NOTIMPL;
  {$EXTERNALSYM DVERR_NOTSUPPORTED}
  DVERR_NOINTERFACE               = E_NOINTERFACE;
  {$EXTERNALSYM DVERR_NOINTERFACE}
  DVERR_SESSIONLOST               = MAKE_DVHRESULT_R + $012C ;
  {$EXTERNALSYM DVERR_SESSIONLOST}
  DVERR_NOVOICESESSION            = MAKE_DVHRESULT_R + $012E ;
  {$EXTERNALSYM DVERR_NOVOICESESSION}
  DVERR_CONNECTIONLOST            = MAKE_DVHRESULT_R + $0168 ;
  {$EXTERNALSYM DVERR_CONNECTIONLOST}
  DVERR_NOTINITIALIZED            = MAKE_DVHRESULT_R + $0169 ;
  {$EXTERNALSYM DVERR_NOTINITIALIZED}
  DVERR_CONNECTED                 = MAKE_DVHRESULT_R + $016A ;
  {$EXTERNALSYM DVERR_CONNECTED}
  DVERR_NOTCONNECTED              = MAKE_DVHRESULT_R + $016B ;
  {$EXTERNALSYM DVERR_NOTCONNECTED}
  DVERR_CONNECTABORTING           = MAKE_DVHRESULT_R + $016E ;
  {$EXTERNALSYM DVERR_CONNECTABORTING}
  DVERR_NOTALLOWED                = MAKE_DVHRESULT_R + $016F ;
  {$EXTERNALSYM DVERR_NOTALLOWED}
  DVERR_INVALIDTARGET             = MAKE_DVHRESULT_R + $0170 ;
  {$EXTERNALSYM DVERR_INVALIDTARGET}
  DVERR_TRANSPORTNOTHOST          = MAKE_DVHRESULT_R + $0171 ;
  {$EXTERNALSYM DVERR_TRANSPORTNOTHOST}
  DVERR_COMPRESSIONNOTSUPPORTED   = MAKE_DVHRESULT_R + $0172 ;
  {$EXTERNALSYM DVERR_COMPRESSIONNOTSUPPORTED}
  DVERR_ALREADYPENDING            = MAKE_DVHRESULT_R + $0173 ;
  {$EXTERNALSYM DVERR_ALREADYPENDING}
  DVERR_SOUNDINITFAILURE          = MAKE_DVHRESULT_R + $0174 ;
  {$EXTERNALSYM DVERR_SOUNDINITFAILURE}
  DVERR_TIMEOUT                   = MAKE_DVHRESULT_R + $0175 ;
  {$EXTERNALSYM DVERR_TIMEOUT}
  DVERR_CONNECTABORTED            = MAKE_DVHRESULT_R + $0176 ;
  {$EXTERNALSYM DVERR_CONNECTABORTED}
  DVERR_NO3DSOUND                 = MAKE_DVHRESULT_R + $0177 ;
  {$EXTERNALSYM DVERR_NO3DSOUND}
  DVERR_ALREADYBUFFERED	          = MAKE_DVHRESULT_R + $0178 ;
  {$EXTERNALSYM DVERR_ALREADYBUFFERED}
  DVERR_NOTBUFFERED               = MAKE_DVHRESULT_R + $0179 ;
  {$EXTERNALSYM DVERR_NOTBUFFERED}
  DVERR_HOSTING                   = MAKE_DVHRESULT_R + $017A ;
  {$EXTERNALSYM DVERR_HOSTING}
  DVERR_NOTHOSTING                = MAKE_DVHRESULT_R + $017B ;
  {$EXTERNALSYM DVERR_NOTHOSTING}
  DVERR_INVALIDDEVICE             = MAKE_DVHRESULT_R + $017C ;
  {$EXTERNALSYM DVERR_INVALIDDEVICE}
  DVERR_RECORDSYSTEMERROR         = MAKE_DVHRESULT_R + $017D ;
  {$EXTERNALSYM DVERR_RECORDSYSTEMERROR}
  DVERR_PLAYBACKSYSTEMERROR       = MAKE_DVHRESULT_R + $017E ;
  {$EXTERNALSYM DVERR_PLAYBACKSYSTEMERROR}
  DVERR_SENDERROR                 = MAKE_DVHRESULT_R + $017F ;
  {$EXTERNALSYM DVERR_SENDERROR}
  DVERR_USERCANCEL                = MAKE_DVHRESULT_R + $0180 ;
  {$EXTERNALSYM DVERR_USERCANCEL}
  DVERR_RUNSETUP                  = MAKE_DVHRESULT_R + $0183 ;
  {$EXTERNALSYM DVERR_RUNSETUP}
  DVERR_INCOMPATIBLEVERSION       = MAKE_DVHRESULT_R + $0184 ;
  {$EXTERNALSYM DVERR_INCOMPATIBLEVERSION}
  DVERR_INITIALIZED               = MAKE_DVHRESULT_R + $0187 ;
  {$EXTERNALSYM DVERR_INITIALIZED}
  DVERR_INVALIDPOINTER            = E_POINTER;
  {$EXTERNALSYM DVERR_INVALIDPOINTER}
  DVERR_NOTRANSPORT               = MAKE_DVHRESULT_R + $0188 ;
  {$EXTERNALSYM DVERR_NOTRANSPORT}
  DVERR_NOCALLBACK                = MAKE_DVHRESULT_R + $0189 ;
  {$EXTERNALSYM DVERR_NOCALLBACK}
  DVERR_TRANSPORTNOTINIT          = MAKE_DVHRESULT_R + $018A ;
  {$EXTERNALSYM DVERR_TRANSPORTNOTINIT}
  DVERR_TRANSPORTNOSESSION        = MAKE_DVHRESULT_R + $018B ;
  {$EXTERNALSYM DVERR_TRANSPORTNOSESSION}
  DVERR_TRANSPORTNOPLAYER         = MAKE_DVHRESULT_R + $018C ;
  {$EXTERNALSYM DVERR_TRANSPORTNOPLAYER}
  DVERR_USERBACK                  = MAKE_DVHRESULT_R + $018D ;
  {$EXTERNALSYM DVERR_USERBACK}
  DVERR_NORECVOLAVAILABLE         = MAKE_DVHRESULT_R + $018E ;
  {$EXTERNALSYM DVERR_NORECVOLAVAILABLE}
  DVERR_INVALIDBUFFER             = MAKE_DVHRESULT_R + $018F ;
  {$EXTERNALSYM DVERR_INVALIDBUFFER}
  DVERR_LOCKEDBUFFER              = MAKE_DVHRESULT_R + $0190 ;
  {$EXTERNALSYM DVERR_LOCKEDBUFFER}



///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// Compatibility types for non-Borland compliant translations of DirectPlay8 //
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

type
  PDvmsg_Connectresult = PDVMsgConnectResult;
  TDvmsg_Connectresult = TDVMsgConnectResult;
  PDvmsg_Createvoiceplayer = PDVMsgCreateVoicePlayer;
  TDvmsg_Createvoiceplayer = TDVMsgCreateVoicePlayer;
  PDvmsg_Deletevoiceplayer = PDVMsgDeleteVoicePlayer;
  TDvmsg_Deletevoiceplayer = TDVMsgDeleteVoicePlayer;
  PDvmsg_Disconnectresult = PDVMsgDisconnectResult;
  TDvmsg_Disconnectresult = TDVMsgDisconnectResult;
  PDvmsg_Hostmigrated = PDVMsgHostMigrated;
  TDvmsg_Hostmigrated = TDVMsgHostMigrated;
  PDvmsg_Inputlevel = PDVMsgInputlevel;
  TDvmsg_Inputlevel = TDVMsgInputlevel;
  PDvmsg_Localhostsetup = PDVMsgLocalHostSetup;
  TDvmsg_Localhostsetup = TDVMsgLocalHostSetup;
  PDvmsg_Outputlevel = PDVMsgOutputLevel;
  TDvmsg_Outputlevel = TDVMsgOutputLevel;
  PDvmsg_Playeroutputlevel = PDVMsgPlayerOutputLevel;
  TDvmsg_Playeroutputlevel = TDVMsgPlayerOutputLevel;
  PDvmsg_Playervoicestart = PDVMsgPlayerVoiceStart;
  TDvmsg_Playervoicestart = TDVMsgPlayerVoiceStart;
  PDvmsg_Playervoicestop = PDVMsgPlayerVoiceStop;
  TDvmsg_Playervoicestop = TDVMsgPlayerVoiceStop;
  PDvmsg_Recordstart = PDVMsgRecordStart;
  TDvmsg_Recordstart = TDVMsgRecordStart;
  PDvmsg_Recordstop = PDVMsgRecordStop;
  TDvmsg_Recordstop = TDVMsgRecordStop;
  PDvmsg_Sessionlost = PDVMsgSessionLost;
  TDvmsg_Sessionlost = TDVMsgSessionLost;
  PDvmsg_Settargets = PDVMsgSetTargets;
  TDvmsg_Settargets = TDVMsgSetTargets;

  PDPN_Application_Desc = PDPNApplicationDesc;
  TDPN_Application_Desc = TDPNApplicationDesc;
  PDPN_Caps = PDPNCaps;
  TDPN_Caps = TDPNCaps;
  PDPN_Caps_Ex = PDPNCapsEx;
  TDPN_Caps_Ex = TDPNCapsEx;
  PDPN_Connection_Info = PDPNConnectionInfo;
  TDPN_Connection_Info = TDPNConnectionInfo;
  PDPN_Group_Info = PDPNGroupInfo;
  TDPN_Group_Info = TDPNGroupInfo;
  PDPN_Player_Info = PDPNPlayerInfo;
  TDPN_Player_Info = TDPNPlayerInfo;
  PDPN_Security_Credentials = PDPNSecurityCredentials;
  TDPN_Security_Credentials = TDPNSecurityCredentials;
  PDPN_Security_Desc = PDPNSecurityDesc;
  TDPN_Security_Desc = TDPNSecurityDesc;
  PDPN_Service_Provider_Info = PDPNServiceProviderInfo;
  TDPN_Service_Provider_Info = TDPNServiceProviderInfo;
  PDPN_Sp_Caps = PDPNSpCaps;
  TDPN_Sp_Caps = TDPNSpCaps;
  PDPNMsg_Add_Player_To_Group = PDPNMsgAddPlayerToGroup;
  TDPNMsg_Add_Player_To_Group = TDPNMsgAddPlayerToGroup;
  PDPNMsg_Async_Op_Complete = PDPNMsgAsyncOpComplete;
  TDPNMsg_Async_Op_Complete = TDPNMsgAsyncOpComplete;
  PDPNMsg_Client_Info = PDPNMsgClientInfo;
  TDPNMsg_Client_Info = TDPNMsgClientInfo;
  PDPNMsg_Connect_Complete = PDPNMsgConnectComplete;
  TDPNMsg_Connect_Complete = TDPNMsgConnectComplete;
  PDPNMsg_Create_Group = PDPNMsgCreateGroup;
  TDPNMsg_Create_Group = TDPNMsgCreateGroup;
  PDPNMsg_Create_Player = PDPNMsgCreatePlayer;
  TDPNMsg_Create_Player = TDPNMsgCreatePlayer;
  PDPNMsg_Destroy_Group = PDPNMsgDestroyGroup;
  TDPNMsg_Destroy_Group = TDPNMsgDestroyGroup;
  PDPNMsg_Destroy_Player = PDPNMsgDestroyPlayer;
  TDPNMsg_Destroy_Player = TDPNMsgDestroyPlayer;
  PDPNMsg_Enum_Hosts_Query = PDPNMsgEnumHostsQuery;
  TDPNMsg_Enum_Hosts_Query = TDPNMsgEnumHostsQuery;
  PDPNMsg_Enum_Hosts_Response = PDPNMsgEnumHostsResponse;
  TDPNMsg_Enum_Hosts_Response = TDPNMsgEnumHostsResponse;
  PDPNMsg_Group_Info = PDPNMsgGroupInfo;
  TDPNMsg_Group_Info = TDPNMsgGroupInfo;
  PDPNMsg_Host_Migrate = PDPNMsgHostMigrate;
  TDPNMsg_Host_Migrate = TDPNMsgHostMigrate;
  PDPNMsg_Indicate_Connect = PDPNMsgIndicateConnect;
  TDPNMsg_Indicate_Connect = TDPNMsgIndicateConnect;
  PDPNMsg_Indicated_Connect_Aborted = PDPNMsgIndicatedConnectAborted;
  TDPNMsg_Indicated_Connect_Aborted = TDPNMsgIndicatedConnectAborted;
  PDPNMsg_Peer_Info = PDPNMsgPeerInfo;
  TDPNMsg_Peer_Info = TDPNMsgPeerInfo;
  PDPNMsg_Receive = PDPNMsgReceive;
  TDPNMsg_Receive = TDPNMsgReceive;
  PDPNMsg_Remove_Player_From_Group = PDPNMsgRemovePlayerFromGroup;
  TDPNMsg_Remove_Player_From_Group = TDPNMsgRemovePlayerFromGroup;
  PDPNMsg_Return_Buffer = PDPNMsgReturnBuffer;
  TDPNMsg_Return_Buffer = TDPNMsgReturnBuffer;
  PDPNMsg_Send_Complete = PDPNMsgSendComplete;
  TDPNMsg_Send_Complete = TDPNMsgSendComplete;
  PDPNMsg_Server_Info = PDPNMsgServerInfo;
  TDPNMsg_Server_Info = TDPNMsgServerInfo;
  PDPNMsg_Terminate_Session = PDPNMsgTerminateSession;
  TDPNMsg_Terminate_Session = TDPNMsgTerminateSession;
  PDPNMsg_Create_Thread = PDPNMsgCreateThread;
  TDPNMsg_Create_Thread = TDPNMsgCreateThread;
  PDPNMsg_Destroy_Thread = PDPNMsgDestroyThread;
  TDPNMsg_Destroy_Thread = TDPNMsgDestroyThread;
  PDPNMsg_Nat_Resolver_Query = PDPNMsgNatResolverQuery;
  TDPNMsg_Nat_Resolver_Query = TDPNMsgNatResolverQuery;


implementation

// #define MAKE_DPNHRESULT( code )  MAKE_HRESULT( 1, _DPN_FACILITY_CODE, ( code + _DPNHRESULT_BASE ) )
function MAKE_DPNHRESULT(Code: DWORD): DWORD;
begin
  Result:= DWord((1 shl 31) or (_DPN_FACILITY_CODE shl 16)) or (Code + _DPNHRESULT_BASE);
end;

end.
