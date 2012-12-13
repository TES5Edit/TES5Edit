{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  File:       DxDiag.h                                                      *}
{*  Content:    DirectX Diagnostic Tool include file                          *}
{*                                                                            *}
{*  DirectX 9.0 Delphi / FreePascal adaptation by Alexey Barkovoy             *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Release: 11-Sep-2004                                                      *}
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

unit DxDiag;

interface

uses
  Windows;

(*$HPPEMIT '#include "DxDiag.h"' *)

(*==========================================================================;
 *
 *  Copyright (C) Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       dxdiag.h
 *  Content:    DirectX Diagnostic Tool include file
 *
 ****************************************************************************)

const
  // This identifier is passed to IDxDiagProvider::Initialize in order to ensure that an
  // application was built against the correct header files. This number is
  // incremented whenever a header (or other) change would require applications
  // to be rebuilt. If the version doesn't match, IDxDiagProvider::Initialize will fail.
  // (The number itself has no meaning.)
  DXDIAG_DX9_SDK_VERSION = 111;
  {$EXTERNALSYM DXDIAG_DX9_SDK_VERSION}


  (****************************************************************************
   *
   * DxDiag Errors
   *
   ****************************************************************************)
  DXDIAG_E_INSUFFICIENT_BUFFER       = HResult($8007007A);  // HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)
  {$EXTERNALSYM DXDIAG_E_INSUFFICIENT_BUFFER}


  (****************************************************************************
   *
   * DxDiag CLSIDs
   *
   ****************************************************************************)

  // {A65B8071-3BFE-4213-9A5B-491DA4461CA7}
  CLSID_DxDiagProvider: TGUID = '{A65B8071-3BFE-4213-9A5B-491DA4461CA7}';
  {$EXTERNALSYM CLSID_DxDiagProvider}


type
  (****************************************************************************
   *
   * DxDiag Structures
   *
   ****************************************************************************)

  PDxDiagInitParams = ^TDxDiagInitParams;
  _DXDIAG_INIT_PARAMS = record
    dwSize: DWORD;                 // Size of this structure.
    dwDxDiagHeaderVersion: DWORD;  // Pass in DXDIAG_DX9_SDK_VERSION.  This verifies
                                   // the header and dll are correctly matched.
    bAllowWHQLChecks: BOOL;        // If true, allow dxdiag to check if drivers are
                                   // digital signed as logo'd by WHQL which may
                                   // connect via internet to update WHQL certificates.
    pReserved: Pointer;            // Reserved. Must be NULL.
  end;
  {$EXTERNALSYM _DXDIAG_INIT_PARAMS}
  DXDIAG_INIT_PARAMS = _DXDIAG_INIT_PARAMS;
  {$EXTERNALSYM DXDIAG_INIT_PARAMS}
  TDxDiagInitParams = _DXDIAG_INIT_PARAMS;


  (****************************************************************************
   *
   * DxDiag Application Interfaces
   *
   ****************************************************************************)

  IDxDiagContainer = interface;

  //
  // COM definition for IDxDiagProvider
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDxDiagProvider);'}
  {$EXTERNALSYM IDxDiagProvider}
  IDxDiagProvider = interface(IUnknown)
    ['{9C6B4CB0-23F8-49CC-A3ED-45A55000A6D2}']
    (*** IDxDiagProvider methods ***)
    function Initialize(const Params: TDxDiagInitParams): HResult; stdcall;
    function GetRootContainer(out ppInstance: IDxDiagContainer): HResult; stdcall;
  end;


  //
  // COM definition for IDxDiagContainer
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDxDiagContainer);'}
  {$EXTERNALSYM IDxDiagContainer}
  IDxDiagContainer = interface(IUnknown)
    ['{7D0F462F-4064-4862-BC7F-933E5058C10F}']
    (*** IDxDiagContainer methods ***)
    function GetNumberOfChildContainers(out dwCount: DWORD): HResult; stdcall;
    function EnumChildContainerNames(dwIndex: DWORD; pwszContainer: PWideChar; cchContainer: DWORD): HResult; stdcall;
    function GetChildContainer(pwszContainer: PWideChar; out ppInstance: IDxDiagContainer): HResult; stdcall;
    function GetNumberOfProps(out pdwCount: DWORD): HResult; stdcall;
    function EnumPropNames(dwIndex: DWORD; pwszPropName: PWideChar; cchPropName: DWORD): HResult; stdcall;
    function GetProp(pwszPropName: PWideChar; out varProp: OleVariant): HResult; stdcall;
  end;


  (****************************************************************************
   *
   * DxDiag Interface IIDs
   *
   ****************************************************************************)

  IID_IDxDiagProvider         = IDxDiagProvider;
  {$EXTERNALSYM IID_IDxDiagProvider}
  IID_IDxDiagContainer        = IDxDiagContainer;
  {$EXTERNALSYM IID_IDxDiagContainer}

implementation

end.
