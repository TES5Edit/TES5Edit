(*----------------------------------------------------------------------------*
 *  DirectX 9 SDK April 2006 C++ common framework adaptation for Delphi       *
 *  by Alexey Barkovoy (e-mail: directx@clootie.ru)                           *
 *                                                                            *
 *  Desc: Direct3D part of framework.                                         *
 *  Supported compilers: Delphi 5,6,7,9 FreePascal 2.0                        *
 *                                                                            *
 *  Latest version can be downloaded from:                                    *
 *     http://www.clootie.ru                                                  *
 *     http://sourceforge.net/projects/delphi-dx9sdk                          * 
 *----------------------------------------------------------------------------*
 *  $Id: DXUTEnum.pas,v 1.13 2006/04/23 19:38:09 clootie Exp $
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
// Files: DXUTEnum.h, DXUTEnum.cpp
//
// Enumerates D3D adapters, devices, modes, etc.
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//--------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------
// File: DXUTEnum.cpp
//
// Enumerates D3D adapters, devices, modes, etc.
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//--------------------------------------------------------------------------------------

{$I DirectX.inc}

unit DXUTenum;

interface

uses
  Windows, DXTypes, Direct3D9;

type
  //--------------------------------------------------------------------------------------
  // Structs
  //--------------------------------------------------------------------------------------
  PDXUTDeviceSettings = ^TDXUTDeviceSettings;
  TDXUTDeviceSettings = record
    AdapterOrdinal: LongWord;
    DeviceType: TD3DDevType;
    AdapterFormat: TD3DFormat;
    BehaviorFlags: DWORD;
    pp: TD3DPresentParameters;
  end;

  //--------------------------------------------------------------------------------------
  // Callback registration
  //--------------------------------------------------------------------------------------
  PDXUTCallbackIsDeviceAcceptable = function (const pCaps: TD3DCaps9; AdapterFormat, BackBufferFormat: TD3DFormat; bWindowed: Boolean; pUserContext: Pointer): Boolean; stdcall;
  
  //--------------------------------------------------------------------------------------
  // Forward declarations
  //--------------------------------------------------------------------------------------
  CD3DEnumAdapterInfo = class;
  CD3DEnumDeviceInfo = class;

  //--------------------------------------------------------------------------------------
  // A depth/stencil buffer format that is incompatible with a
  // multisample type.
  //--------------------------------------------------------------------------------------
  PD3DEnumDSMSConflict = ^TD3DEnumDSMSConflict;
  TD3DEnumDSMSConflict = record
    DSFormat: TD3DFormat;
    MSType: TD3DMultiSampleType;
  end;


  //--------------------------------------------------------------------------------------
  // A struct describing device settings that contains a unique combination of
  // adapter format, back buffer format, and windowed that is compatible with a
  // particular Direct3D device and the app.
  //--------------------------------------------------------------------------------------
  PD3DEnumDeviceSettingsCombo = ^TD3DEnumDeviceSettingsCombo;
  TD3DEnumDeviceSettingsCombo = record
    AdapterOrdinal: LongWord;
    DeviceType: TD3DDevType;
    AdapterFormat: TD3DFormat;
    BackBufferFormat: TD3DFormat;
    Windowed: Boolean;

    depthStencilFormatList: array of TD3DFormat; // List of D3DFORMATs
    multiSampleTypeList: array of TD3DMultiSampleType; // List of D3DMULTISAMPLE_TYPEs
    multiSampleQualityList: array of DWORD; // List of number of quality levels for each multisample type
    presentIntervalList: array of LongWord; // List of D3DPRESENT flags
    DSMSConflictList: array of TD3DEnumDSMSConflict; // List of CD3DEnumDSMSConflict

    pAdapterInfo: CD3DEnumAdapterInfo;
    pDeviceInfo: CD3DEnumDeviceInfo;
  end;


  TD3DEnumAdapterInfoArray = array of CD3DEnumAdapterInfo;
  TD3DFormatArray = array of TD3DFormat;
  TD3DMultiSampleTypeArray = array of TD3DMultiSampleType;
  TLongWordArray = array of LongWord;

  //--------------------------------------------------------------------------------------
  // Enumerates available Direct3D adapters, devices, modes, etc.
  // Use DXUTGetEnumeration() to access global instance
  //--------------------------------------------------------------------------------------
  CD3DEnumeration = class
  public
    destructor Destroy; override;

    // These should be called before Enumerate().
    //
    // Use these calls and the IsDeviceAcceptable to control the contents of
    // the enumeration object, which affects the device selection and the device settings dialog.
    procedure SetRequirePostPixelShaderBlending(bRequire: Boolean); { m_bRequirePostPixelShaderBlending = bRequire; }
    procedure SetResolutionMinMax(nMinWidth, nMinHeight, nMaxWidth, nMaxHeight: LongWord);
    procedure SetRefreshMinMax(nMin, nMax: LongWord);
    procedure SetMultisampleQualityMax(nMax: LongWord);
    procedure GetPossibleVertexProcessingList(out pbSoftwareVP, pbHardwareVP, pbPureHarewareVP, pbMixedVP: Boolean);
    procedure SetPossibleVertexProcessingList(bSoftwareVP, bHardwareVP, bPureHarewareVP, bMixedVP: Boolean);
    function GetPossibleDepthStencilFormatList: TD3DFormatArray;
    function GetPossibleMultisampleTypeList: TD3DMultiSampleTypeArray;
    function GetPossiblePresentIntervalList: TLongWordArray;
    procedure ResetPossibleDepthStencilFormats;
    procedure ResetPossibleMultisampleTypeList;
    procedure ResetPossiblePresentIntervalList;
    procedure SetPossibleDepthStencilFormatList(a: TD3DFormatArray);
    procedure SetPossibleMultisampleTypeList(a: TD3DMultiSampleTypeArray);
    procedure SetPossiblePresentIntervalList(a: TLongWordArray);

    // Call Enumerate() to enumerate available D3D adapters, devices, modes, etc.
    function Enumerate(pD3D: IDirect3D9 = nil;
                       IsDeviceAcceptableFunc: PDXUTCallbackIsDeviceAcceptable = nil;
                       pIsDeviceAcceptableFuncUserContext: Pointer = nil): HRESULT;

    // These should be called after Enumerate() is called
    function GetAdapterInfoList: TD3DEnumAdapterInfoArray;
    function GetAdapterInfo(AdapterOrdinal: LongWord): CD3DEnumAdapterInfo;
    function GetDeviceInfo(AdapterOrdinal: LongWord; DeviceType: TD3DDevType): CD3DEnumDeviceInfo;
    function GetDeviceSettingsCombo(const pDeviceSettings: TDXUTDeviceSettings): PD3DEnumDeviceSettingsCombo; overload;
    function GetDeviceSettingsCombo(AdapterOrdinal: LongWord; DeviceType: TD3DDevType; AdapterFormat, BackBufferFormat: TD3DFormat; Windowed: Boolean): PD3DEnumDeviceSettingsCombo; overload;

    procedure CleanupDirect3DInterfaces; //Clootie: this is special Delphi function to clear SmartPointers

    property PossibleDepthStencilFormatList: TD3DFormatArray read GetPossibleDepthStencilFormatList write SetPossibleDepthStencilFormatList;
    property PossibleMultisampleTypeList: TD3DMultiSampleTypeArray read GetPossibleMultisampleTypeList write SetPossibleMultisampleTypeList;
    property PossiblePresentIntervalList: TLongWordArray read GetPossiblePresentIntervalList write SetPossiblePresentIntervalList;

  private
    // friend CD3DEnumeration* DXUTGetEnumeration();

    m_pD3D: IDirect3D9;
    m_IsDeviceAcceptableFunc: PDXUTCallbackIsDeviceAcceptable;
    m_pIsDeviceAcceptableFuncUserContext: Pointer;
    m_bRequirePostPixelShaderBlending: Boolean;
    m_DepthStecilPossibleList: TD3DFormatArray;
    m_MultiSampleTypeList: TD3DMultiSampleTypeArray;
    m_PresentIntervalList: TLongWordArray;

    m_bSoftwareVP: Boolean;
    m_bHardwareVP: Boolean;
    m_bPureHarewareVP: Boolean;
    m_bMixedVP: Boolean;

    m_nMinWidth: LongWord;
    m_nMaxWidth: LongWord;
    m_nMinHeight: LongWord;
    m_nMaxHeight: LongWord;
    m_nRefreshMin: LongWord;
    m_nRefreshMax: LongWord;
    m_nMultisampleQualityMax: LongWord;

    // Array of CD3DEnumAdapterInfo* with unique AdapterOrdinals
    m_AdapterInfoList: TD3DEnumAdapterInfoArray;

    // Use DXUTGetEnumeration() to access global instance
    constructor Create;

    function EnumerateDevices(pAdapterInfo: CD3DEnumAdapterInfo; pAdapterFormatList: TD3DFormatArray): HRESULT;
    function EnumerateDeviceCombos(pAdapterInfo: CD3DEnumAdapterInfo; pDeviceInfo: CD3DEnumDeviceInfo; pAdapterFormatList: TD3DFormatArray): HRESULT;
    procedure BuildDepthStencilFormatList(pDeviceCombo: PD3DEnumDeviceSettingsCombo);
    procedure BuildMultiSampleTypeList(pDeviceCombo: PD3DEnumDeviceSettingsCombo);
    procedure BuildDSMSConflictList(pDeviceCombo: PD3DEnumDeviceSettingsCombo);
    procedure BuildPresentIntervalList(pDeviceInfo: CD3DEnumDeviceInfo; pDeviceCombo: PD3DEnumDeviceSettingsCombo);
    procedure ClearAdapterInfoList;
  end;

  TD3DDisplayModeArray = array of TD3DDisplayMode;

  //--------------------------------------------------------------------------------------
  // A class describing an adapter which contains a unique adapter ordinal
  // that is installed on the system
  //--------------------------------------------------------------------------------------
  CD3DEnumAdapterInfo = class
  public
    AdapterOrdinal: LongWord;
    AdapterIdentifier: TD3DAdapterIdentifier9;
    szUniqueDescription: array[0..255] of WideChar;
    
    displayModeList: TD3DDisplayModeArray; // Array of supported D3DDISPLAYMODEs
    deviceInfoList: array of CD3DEnumDeviceInfo; // Array of CD3DEnumDeviceInfo* with unique supported DeviceTypes

    destructor Destroy; override;
  end;


  //--------------------------------------------------------------------------------------
  // A class describing a Direct3D device that contains a
  //       unique supported device type
  //--------------------------------------------------------------------------------------
  CD3DEnumDeviceInfo = class
  public
    AdapterOrdinal: LongWord;
    DeviceType: TD3DDevType;
    Caps: TD3DCaps9;

    // List of CD3DEnumDeviceSettingsCombo* with a unique set
    // of AdapterFormat, BackBufferFormat, and Windowed
    deviceSettingsComboList: array of PD3DEnumDeviceSettingsCombo;

    destructor Destroy; override;
  end;

function DXUTGetEnumeration: CD3DEnumeration;

function DXUTStencilBits(fmt: TD3DFormat): LongWord;
function DXUTDepthBits(fmt: TD3DFormat): LongWord;
function DXUTAlphaChannelBits(fmt: TD3DFormat): LongWord;
function DXUTColorChannelBits(fmt: TD3DFormat): Integer;

type
  QSortCB = function (const arg1, arg2: Pointer): Integer;

procedure QSort(base: Pointer; num: Size_t; width: Size_t; compare: QSortCB);

implementation

uses
  SysUtils, StrSafe, DXUT, DXUTmisc, DXUTCore;

//--------------------------------------------------------------------------------------
// File: DXUTEnum.cpp
//
// Enumerates D3D adapters, devices, modes, etc.
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//--------------------------------------------------------------------------------------


//--------------------------------------------------------------------------------------
// Forward declarations
//--------------------------------------------------------------------------------------
function SortModesCallback(const arg1, arg2: Pointer): Integer; forward;

var {static} d3denum: CD3DEnumeration = nil;
function DXUTGetEnumeration: CD3DEnumeration;
begin
  // Using an accessor function gives control of the construction order
  //Clootie: This is C++ issue - in pascal we just create it here
  if (d3denum = nil) then d3denum:= CD3DEnumeration.Create;
  Result:= d3denum;
end;


// Implementation of QSort C++ function
procedure qsort_int(base: Pointer; width: Integer; compare: QSortCB;
  Left, Right: Integer; TempBuffer, TempBuffer2: Pointer);
var
  Lo, Hi: Integer;
  P: Pointer;
begin
  Lo := Left;
  Hi := Right;
  P := Pointer(Integer(base) + ((Lo + Hi) div 2)*width);
  Move(P^, TempBuffer2^, width);
  repeat
    while compare(Pointer(Integer(base) + Lo*width), TempBuffer2) < 0 do Inc(Lo);
    while compare(Pointer(Integer(base) + Hi*width), TempBuffer2) > 0 do Dec(Hi);
    if Lo <= Hi then
    begin
      Move(Pointer(Integer(base) + Lo*width)^, TempBuffer^,                        width);
      Move(Pointer(Integer(base) + Hi*width)^, Pointer(Integer(base) + Lo*width)^, width);
      Move(TempBuffer^,                        Pointer(Integer(base) + Hi*width)^, width);
      Inc(Lo);
      Dec(Hi);
    end;
  until Lo > Hi;

  if Hi > Left  then qsort_int(base, width, compare, Left, Hi,  TempBuffer, TempBuffer2);
  if Lo < Right then qsort_int(base, width, compare, Lo, Right, TempBuffer, TempBuffer2);
end;

procedure QSort(base: Pointer; num: Size_t; width: Size_t; compare: QSortCB);
var
  p, p1: Pointer;
begin
  GetMem(p, width);
  GetMem(p1, width);
  try
    qsort_int(base, width, compare, 0, num - 1, p, p1);
  finally
    FreeMem(p1, width);
    FreeMem(p, width);
  end;
end;

{ CD3DEnumeration }

//--------------------------------------------------------------------------------------
constructor CD3DEnumeration.Create;
begin
  inherited;
  m_pD3D := nil;
  m_IsDeviceAcceptableFunc := nil;
  m_pIsDeviceAcceptableFuncUserContext := nil;
  m_bRequirePostPixelShaderBlending := True;

  m_nMinWidth := 640;
  m_nMinHeight := 480;
  m_nMaxWidth := $FFFFFFFF;
  m_nMaxHeight := $FFFFFFFF;

  m_nRefreshMin := 0;
  m_nRefreshMax := $FFFFFFFF; // UINT_MAX;

  m_nMultisampleQualityMax := $FFFF;

  ResetPossibleDepthStencilFormats;
  ResetPossibleMultisampleTypeList;
  ResetPossiblePresentIntervalList;
  SetPossibleVertexProcessingList(True, True, True, False);
end;


//--------------------------------------------------------------------------------------
destructor CD3DEnumeration.Destroy;
begin
  ClearAdapterInfoList;
  inherited;
end;



//--------------------------------------------------------------------------------------
// Enumerates available D3D adapters, devices, modes, etc.
//--------------------------------------------------------------------------------------
function CD3DEnumeration.Enumerate(pD3D: IDirect3D9 = nil;
  IsDeviceAcceptableFunc: PDXUTCallbackIsDeviceAcceptable = nil;
  pIsDeviceAcceptableFuncUserContext: Pointer = nil): HRESULT;
const
  allowedAdapterFormatArray: array[0..3] of TD3DFormat  = (
    D3DFMT_X8R8G8B8,
    D3DFMT_X1R5G5B5,
    D3DFMT_R5G6B5,
    D3DFMT_A2R10G10B10
  );
var
  adapterFormatList: TD3DFormatArray;
  numAdapters: LongWord;
  adapterOrdinal: Integer;
  pAdapterInfo: CD3DEnumAdapterInfo;
  iFormatList: Integer;
  allowedAdapterFormat: TD3DFormat;
  numAdapterModes: Integer;
  mode: Integer;
  displayMode: TD3DDisplayMode;
  l: Integer;
  bUniqueDesc: Boolean;
  i, j: Integer;
  pAdapterInfo1: CD3DEnumAdapterInfo;
  pAdapterInfo2: CD3DEnumAdapterInfo;
  sz: array[0..99] of WideChar;
begin
try
  if (pD3D = nil) then
  begin
    pD3D := DXUTGetD3DObject;
    if (pD3D = nil) then
    begin
      Result:= DXUTERR_NODIRECT3D;
      Exit;
    end;
  end;

  m_pD3D := pD3D;
  m_IsDeviceAcceptableFunc := IsDeviceAcceptableFunc;
  m_pIsDeviceAcceptableFuncUserContext := pIsDeviceAcceptableFuncUserContext;

  ClearAdapterInfoList;

  numAdapters := pD3D.GetAdapterCount;
  for adapterOrdinal := 0 to numAdapters - 1 do
  begin
    pAdapterInfo:= CD3DEnumAdapterInfo.Create;
    pAdapterInfo.AdapterOrdinal := adapterOrdinal;
    pD3D.GetAdapterIdentifier(adapterOrdinal, 0, pAdapterInfo.AdapterIdentifier);

    // Get list of all display modes on this adapter.
    // Also build a temporary list of all display adapter formats.
    adapterFormatList:= nil; // RemoveAll();

    for iFormatList := 0 to High(allowedAdapterFormatArray) do
    begin
      allowedAdapterFormat := allowedAdapterFormatArray[iFormatList];
      numAdapterModes := pD3D.GetAdapterModeCount(adapterOrdinal, allowedAdapterFormat);
      for mode := 0 to numAdapterModes - 1 do
      begin
        pD3D.EnumAdapterModes(adapterOrdinal, allowedAdapterFormat, mode, displayMode);

        if (displayMode.Width < m_nMinWidth) or
           (displayMode.Height < m_nMinHeight) or
           (displayMode.Width > m_nMaxWidth) or
           (displayMode.Height > m_nMaxHeight) or
           (displayMode.RefreshRate < m_nRefreshMin) or
           (displayMode.RefreshRate > m_nRefreshMax)
        then Continue;

        // pAdapterInfo.displayModeList.Add(displayMode);
        l:= Length(pAdapterInfo.displayModeList);
        SetLength(pAdapterInfo.displayModeList, l+1);
        pAdapterInfo.displayModeList[l]:= displayMode;

        // if (not adapterFormatList.Contains(displayMode.Format))
        if not DynArrayContains(adapterFormatList, displayMode.Format, SizeOf(displayMode.Format)) then
        begin
          // adapterFormatList.Add(displayMode.Format);
          l:= Length(adapterFormatList);
          SetLength(adapterFormatList, l+1);
          adapterFormatList[l]:= displayMode.Format;
        end;
      end;
    end;

    pD3D.GetAdapterDisplayMode(adapterOrdinal, displayMode);
    // if (not adapterFormatList.Contains(displayMode.Format)) then
    if not DynArrayContains(adapterFormatList, displayMode.Format, SizeOf(displayMode.Format)) then
    begin
      // adapterFormatList.Add(displayMode.Format);
      l:= Length(adapterFormatList);
      SetLength(adapterFormatList, l+1);
      adapterFormatList[l]:= displayMode.Format;
    end;

    // Sort displaymode list
    QSort(pAdapterInfo.displayModeList, Length(pAdapterInfo.displayModeList),
          SizeOf(TD3DDisplayMode), SortModesCallback);

    // Get info for each device on this adapter
    if FAILED(EnumerateDevices(pAdapterInfo, adapterFormatList)) then
    begin
      pAdapterInfo.Free;
      Continue;
    end;

    // If at least one device on this adapter is available and compatible
    // with the app, add the adapterInfo to the list
    if (Length(pAdapterInfo.deviceInfoList) > 0) then
    begin
      // Result := m_AdapterInfoList.Add(pAdapterInfo);
      l:= Length(m_AdapterInfoList);
      SetLength(m_AdapterInfoList, l+1);
      m_AdapterInfoList[l]:= pAdapterInfo;
    end else
      pAdapterInfo.Free;
  end;

  bUniqueDesc := true;
  for i:= 0 to Length(m_AdapterInfoList) - 1 do
  begin
    pAdapterInfo1 := m_AdapterInfoList[i];

    for j:= i+1 to Length(m_AdapterInfoList) - 1 do 
    begin
      pAdapterInfo2 := m_AdapterInfoList[j];
      if (AnsiCompareText(pAdapterInfo1.AdapterIdentifier.Description,
                   pAdapterInfo2.AdapterIdentifier.Description) = 0) then 
      begin
        bUniqueDesc := False;
        Break;
      end;
    end;

    if not bUniqueDesc then Break;
  end;

  for i:= 0 to Length(m_AdapterInfoList) - 1 do
  begin
    pAdapterInfo := m_AdapterInfoList[i];

    MultiByteToWideChar(CP_ACP, 0,
                        pAdapterInfo.AdapterIdentifier.Description, -1,
                        pAdapterInfo.szUniqueDescription, 100);
    pAdapterInfo.szUniqueDescription[100] := #0;

    if not bUniqueDesc then
    begin
      StringCchFormat(sz, 100, ' (#%d)', [pAdapterInfo.AdapterOrdinal]);
      StringCchCat(pAdapterInfo.szUniqueDescription, 256, sz);
    end;
  end;

  Result:= S_OK;
except
  on EOutOfMemory do 
  begin
    Result:= E_OUTOFMEMORY;
    Exit;
  end;
end;
end;


//--------------------------------------------------------------------------------------
// Enumerates D3D devices for a particular adapter.
//--------------------------------------------------------------------------------------
function CD3DEnumeration.EnumerateDevices(pAdapterInfo: CD3DEnumAdapterInfo;
  pAdapterFormatList: TD3DFormatArray): HRESULT;
const
  devTypeArray: array[0..2] of TD3DDevType = (
    D3DDEVTYPE_HAL,
    D3DDEVTYPE_SW,
    D3DDEVTYPE_REF
  );
var
  iDeviceType: Integer;
  pDeviceInfo: CD3DEnumDeviceInfo;
  l: Integer;
  Mode: TD3DDisplayMode;
  pp: TD3DPresentParameters;
  pDevice: IDirect3DDevice9;
begin
  // Enumerate each Direct3D device type
  for iDeviceType := 0 to High(devTypeArray) do
  begin
    try
      pDeviceInfo := CD3DEnumDeviceInfo.Create;
    except
      Result:= E_OUTOFMEMORY;
      Exit;
    end;

    // Fill struct w/ AdapterOrdinal and D3DDEVTYPE
    pDeviceInfo.DeviceType := devTypeArray[iDeviceType];

    // Store device caps
    Result:= m_pD3D.GetDeviceCaps(pAdapterInfo.AdapterOrdinal, pDeviceInfo.DeviceType,
                                  pDeviceInfo.Caps);
    if FAILED(Result) then
    begin
      pDeviceInfo.Free;
      Continue;
    end;

    // Create a dummy device to verify that we really can create of this type.
    m_pD3D.GetAdapterDisplayMode(0, Mode);
    ZeroMemory(@pp, SizeOf(pp));
    pp.BackBufferWidth  := 1;
    pp.BackBufferHeight := 1;
    pp.BackBufferFormat := Mode.Format;
    pp.BackBufferCount  := 1;
    pp.SwapEffect       := D3DSWAPEFFECT_COPY;
    pp.Windowed         := True;
    pp.hDeviceWindow    := DXUTGetHWNDFocus;
    Result := m_pD3D.CreateDevice(pAdapterInfo.AdapterOrdinal, pDeviceInfo.DeviceType, DXUTGetHWNDFocus,
                              D3DCREATE_HARDWARE_VERTEXPROCESSING, @pp, pDevice);
    if FAILED(Result) then
    begin
      if (Result = D3DERR_NOTAVAILABLE) then
      begin
        pDeviceInfo.Free;
        Continue;
      end;
    end;
    pDevice := nil;

    // Get info for each devicecombo on this device
    Result := EnumerateDeviceCombos(pAdapterInfo, pDeviceInfo, pAdapterFormatList);
    if FAILED(Result) then
    begin
      pDeviceInfo.Free;
      Continue;
    end;

    // If at least one devicecombo for this device is found,
    // add the deviceInfo to the list
    if (Length(pDeviceInfo.deviceSettingsComboList) > 0) then
    begin
      // pAdapterInfo.deviceInfoList.Add(pDeviceInfo);
      l:= Length(pAdapterInfo.deviceInfoList);
      SetLength(pAdapterInfo.deviceInfoList, l+1);
      pAdapterInfo.deviceInfoList[l]:= pDeviceInfo;
    end else
      pDeviceInfo.Free;
  end;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Enumerates DeviceCombos for a particular device.
//--------------------------------------------------------------------------------------
function CD3DEnumeration.EnumerateDeviceCombos(pAdapterInfo: CD3DEnumAdapterInfo;
  pDeviceInfo: CD3DEnumDeviceInfo; pAdapterFormatList: TD3DFormatArray): HRESULT;
const
  backBufferFormatArray: array[0..5] of TD3DFormat = (
    D3DFMT_A8R8G8B8,
    D3DFMT_X8R8G8B8,
    D3DFMT_A2R10G10B10,
    D3DFMT_R5G6B5,
    D3DFMT_A1R5G5B5,
    D3DFMT_X1R5G5B5
  );
var
  iFormat: Integer;
  adapterFormat: TD3DFormat;
  iBackBufferFormat: Integer;  
  backBufferFormat: TD3DFormat;
  nWindowed: Integer;
  pDeviceCombo: PD3DEnumDeviceSettingsCombo;
  l: Integer;
begin
try
  // See which adapter formats are supported by this device
  for iFormat:= 0 to Length(pAdapterFormatList) - 1 do
  begin
    adapterFormat := pAdapterFormatList[iFormat];

    for iBackBufferFormat := 0 to High(backBufferFormatArray) do
    begin
      backBufferFormat := backBufferFormatArray[iBackBufferFormat];

      for nWindowed := 0 to 1 do
      begin
        if (nWindowed = 0) and (Length(pAdapterInfo.displayModeList) = 0)
        then Continue;

        if FAILED(m_pD3D.CheckDeviceType(pAdapterInfo.AdapterOrdinal, pDeviceInfo.DeviceType,
                                         adapterFormat, backBufferFormat, nWindowed <> 0))
        then Continue;

        if (m_bRequirePostPixelShaderBlending) then 
        begin
          // If the backbuffer format doesn't support D3DUSAGE_QUERY_POSTPIXELSHADER_BLENDING
          // then alpha test, pixel fog, render-target blending, color write enable, and dithering. 
          // are not supported.
          if FAILED(m_pD3D.CheckDeviceFormat(pAdapterInfo.AdapterOrdinal, pDeviceInfo.DeviceType,
                                             adapterFormat, D3DUSAGE_QUERY_POSTPIXELSHADER_BLENDING,
                                             D3DRTYPE_TEXTURE, backBufferFormat))
          then Continue;
        end;

        // If an application callback function has been provided, make sure this device
        // is acceptable to the app.
        if (@m_IsDeviceAcceptableFunc <> nil) then
        begin
          if (not m_IsDeviceAcceptableFunc(pDeviceInfo.Caps, adapterFormat, backBufferFormat, nWindowed <> 0, m_pIsDeviceAcceptableFuncUserContext))
          then Continue;
        end;
                
        // At this point, we have an adapter/device/adapterformat/backbufferformat/iswindowed
        // DeviceCombo that is supported by the system and acceptable to the app. We still 
        // need to find one or more suitable depth/stencil buffer format,
        // multisample type, and present interval.
        New(pDeviceCombo);

        pDeviceCombo.AdapterOrdinal := pAdapterInfo.AdapterOrdinal;
        pDeviceCombo.DeviceType := pDeviceInfo.DeviceType;
        pDeviceCombo.AdapterFormat := adapterFormat;
        pDeviceCombo.BackBufferFormat := backBufferFormat;
        pDeviceCombo.Windowed := (nWindowed <> 0);

        BuildDepthStencilFormatList(pDeviceCombo);
        BuildMultiSampleTypeList(pDeviceCombo);
        if Length(pDeviceCombo.multiSampleTypeList) = 0 then
        begin
          Dispose(pDeviceCombo);
          Continue;
        end;
        BuildDSMSConflictList(pDeviceCombo);
        BuildPresentIntervalList(pDeviceInfo, pDeviceCombo);
        pDeviceCombo.pAdapterInfo := pAdapterInfo;
        pDeviceCombo.pDeviceInfo := pDeviceInfo;

        // pDeviceInfo.deviceSettingsComboList.Add(pDeviceCombo);
        l:= Length(pDeviceInfo.deviceSettingsComboList);
        SetLength(pDeviceInfo.deviceSettingsComboList, l+1);
        pDeviceInfo.deviceSettingsComboList[l]:= pDeviceCombo;
      end;
    end;
  end;

  Result:= S_OK;
except
  on EOutOfMemory do 
  begin
    Result:= E_OUTOFMEMORY;
    Exit;
  end;
end;
end;


//--------------------------------------------------------------------------------------
// Adds all depth/stencil formats that are compatible with the device
//       and app to the given D3DDeviceCombo.
//--------------------------------------------------------------------------------------
procedure CD3DEnumeration.BuildDepthStencilFormatList(pDeviceCombo: PD3DEnumDeviceSettingsCombo);
var
  depthStencilFmt: TD3DFormat;
  idsf, l: Integer;
begin
  for idsf := 0 to Length(m_DepthStecilPossibleList) - 1 do
  begin
    depthStencilFmt := m_DepthStecilPossibleList[idsf];
    if SUCCEEDED(m_pD3D.CheckDeviceFormat(pDeviceCombo.AdapterOrdinal,
         pDeviceCombo.DeviceType, pDeviceCombo.AdapterFormat,
         D3DUSAGE_DEPTHSTENCIL, D3DRTYPE_SURFACE, depthStencilFmt)) then
    begin
      if SUCCEEDED(m_pD3D.CheckDepthStencilMatch(pDeviceCombo.AdapterOrdinal,
           pDeviceCombo.DeviceType, pDeviceCombo.AdapterFormat,
           pDeviceCombo.BackBufferFormat, depthStencilFmt)) then
      begin
        // pDeviceCombo.depthStencilFormatList.Add(depthStencilFmt);
        l:= Length(pDeviceCombo.depthStencilFormatList);
        SetLength(pDeviceCombo.depthStencilFormatList, l+1);
        pDeviceCombo.depthStencilFormatList[l]:= depthStencilFmt;
      end;
    end;
  end;
end;


//--------------------------------------------------------------------------------------
// Adds all multisample types that are compatible with the device and app to
//       the given D3DDeviceCombo.
//--------------------------------------------------------------------------------------
procedure CD3DEnumeration.BuildMultiSampleTypeList(pDeviceCombo: PD3DEnumDeviceSettingsCombo);
var
  msType: TD3DMultiSampleType;
  msQuality: DWORD;
  imst, l: Integer;
begin
  for imst := 0 to Length(m_MultiSampleTypeList) - 1 do
  begin
    msType := m_MultiSampleTypeList[imst];
    if SUCCEEDED(m_pD3D.CheckDeviceMultiSampleType(pDeviceCombo.AdapterOrdinal,
         pDeviceCombo.DeviceType, pDeviceCombo.BackBufferFormat,
         pDeviceCombo.Windowed, msType, @msQuality)) then
    begin
      // pDeviceCombo.multiSampleTypeList.Add(msType);
      l:= Length(pDeviceCombo.multiSampleTypeList);
      SetLength(pDeviceCombo.multiSampleTypeList, l+1);
      pDeviceCombo.multiSampleTypeList[l]:= msType;

      if (msQuality > m_nMultisampleQualityMax+1) then msQuality := m_nMultisampleQualityMax+1;

      // pDeviceCombo.multiSampleQualityList.Add(msQuality);
      l:= Length(pDeviceCombo.multiSampleQualityList);
      SetLength(pDeviceCombo.multiSampleQualityList, l+1);
      pDeviceCombo.multiSampleQualityList[l]:= msQuality;
    end;
  end;
end;


//--------------------------------------------------------------------------------------
// Find any conflicts between the available depth/stencil formats and
//       multisample types.
//--------------------------------------------------------------------------------------
procedure CD3DEnumeration.BuildDSMSConflictList(pDeviceCombo: PD3DEnumDeviceSettingsCombo);
var
  DSMSConflict: TD3DEnumDSMSConflict;
  iDS, iMS, l: Integer;
  dsFmt: TD3DFormat;
  msType: TD3DMultiSampleType;
begin
  for iDS:=0 to Length(pDeviceCombo.depthStencilFormatList) - 1 do
  begin
    dsFmt := pDeviceCombo.depthStencilFormatList[iDS];

    for iMS:= 0 to Length(pDeviceCombo.multiSampleTypeList) - 1 do
    begin
      msType := pDeviceCombo.multiSampleTypeList[iMS];

      if FAILED(m_pD3D.CheckDeviceMultiSampleType(pDeviceCombo.AdapterOrdinal, pDeviceCombo.DeviceType,
                                                  dsFmt, pDeviceCombo.Windowed, msType, nil)) then 
      begin
        DSMSConflict.DSFormat := dsFmt;
        DSMSConflict.MSType := msType;
        // pDeviceCombo.DSMSConflictList.Add(DSMSConflict);
        l:= Length(pDeviceCombo.DSMSConflictList);
        SetLength(pDeviceCombo.DSMSConflictList, l+1);
        pDeviceCombo.DSMSConflictList[l]:= DSMSConflict;
      end;
    end;
  end;
end;



//--------------------------------------------------------------------------------------
// Adds all present intervals that are compatible with the device and app
//       to the given D3DDeviceCombo.
//--------------------------------------------------------------------------------------
procedure CD3DEnumeration.BuildPresentIntervalList(pDeviceInfo: CD3DEnumDeviceInfo;
  pDeviceCombo: PD3DEnumDeviceSettingsCombo);
var
  pi: LongWord;
  ipi, l: Integer;
begin
  for ipi := 0 to Length(m_PresentIntervalList) - 1 do
  begin
    pi := m_PresentIntervalList[ipi];
    if pDeviceCombo.Windowed then
    begin
      if (pi = D3DPRESENT_INTERVAL_TWO) or
         (pi = D3DPRESENT_INTERVAL_THREE) or
         (pi = D3DPRESENT_INTERVAL_FOUR) then
      begin
        // These intervals are not supported in windowed mode.
        Continue;
      end;
    end;
    // Note that D3DPRESENT_INTERVAL_DEFAULT is zero, so you
    // can't do a caps check for it -- it is always available.
    if (pi = D3DPRESENT_INTERVAL_DEFAULT) or
       (pDeviceInfo.Caps.PresentationIntervals and pi <> 0) then 
    begin
      // pDeviceCombo.presentIntervalList.Add(pi);
      l:= Length(pDeviceCombo.presentIntervalList);
      SetLength(pDeviceCombo.presentIntervalList, l+1);
      pDeviceCombo.presentIntervalList[l]:= pi;
    end;
  end;
end;



//--------------------------------------------------------------------------------------
// Release all the allocated CD3DEnumAdapterInfo objects and empty the list
//--------------------------------------------------------------------------------------
procedure CD3DEnumeration.ClearAdapterInfoList;
var
  i: Integer;
begin
  for i:= 0 to Length(m_AdapterInfoList) - 1 do
  begin
    m_AdapterInfoList[i].Free;
  end;
  m_AdapterInfoList:= nil; // RemoveAll;
end;



//--------------------------------------------------------------------------------------
// Call GetAdapterInfoList() after Enumerate() to get a STL vector of 
//       CD3DEnumAdapterInfo*
//--------------------------------------------------------------------------------------
function CD3DEnumeration.GetAdapterInfoList: TD3DEnumAdapterInfoArray;
begin
  Result:= m_AdapterInfoList;
end;



//--------------------------------------------------------------------------------------
function CD3DEnumeration.GetAdapterInfo(AdapterOrdinal: LongWord): CD3DEnumAdapterInfo;
var
  iAdapter: Integer;
begin
  for iAdapter:= 0 to Length(m_AdapterInfoList) - 1 do
  begin
    if (m_AdapterInfoList[iAdapter].AdapterOrdinal = AdapterOrdinal) then
    begin
      Result:= m_AdapterInfoList[iAdapter];
      Exit;
    end;
  end;

  Result:= nil;
end;


//--------------------------------------------------------------------------------------
function CD3DEnumeration.GetDeviceInfo(AdapterOrdinal: LongWord;
  DeviceType: TD3DDevType): CD3DEnumDeviceInfo;
var
  pAdapterInfo: CD3DEnumAdapterInfo;
  iDeviceInfo: Integer;   
begin
  pAdapterInfo := GetAdapterInfo(AdapterOrdinal);
  if (pAdapterInfo <> nil) then
  begin
    for iDeviceInfo:= 0 to Length(pAdapterInfo.deviceInfoList) - 1 do
    begin
      if (pAdapterInfo.deviceInfoList[iDeviceInfo].DeviceType = DeviceType) then
      begin
        Result:= pAdapterInfo.deviceInfoList[iDeviceInfo];
        Exit;
      end;
    end;
  end;

  Result:= nil;
end;


//--------------------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------------------
function CD3DEnumeration.GetDeviceSettingsCombo(const pDeviceSettings: TDXUTDeviceSettings): PD3DEnumDeviceSettingsCombo;
begin
  with pDeviceSettings do
    Result:= GetDeviceSettingsCombo(AdapterOrdinal, DeviceType, AdapterFormat,
                                    pp.BackBufferFormat, pp.Windowed);
end;

function CD3DEnumeration.GetDeviceSettingsCombo(AdapterOrdinal: LongWord;
  DeviceType: TD3DDevType; AdapterFormat, BackBufferFormat: TD3DFormat;
  Windowed: Boolean): PD3DEnumDeviceSettingsCombo;
var
  pDeviceInfo: CD3DEnumDeviceInfo;
  iDeviceCombo: Integer;
  pDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;
begin
  pDeviceInfo := GetDeviceInfo(AdapterOrdinal, DeviceType);
  if (pDeviceInfo <> nil) then
  begin
    for iDeviceCombo:= 0 to Length(pDeviceInfo.deviceSettingsComboList) - 1 do
    begin
      pDeviceSettingsCombo := pDeviceInfo.deviceSettingsComboList[iDeviceCombo];
      if (pDeviceSettingsCombo.AdapterFormat = AdapterFormat) and
         (pDeviceSettingsCombo.BackBufferFormat = BackBufferFormat) and
         (pDeviceSettingsCombo.Windowed = Windowed) then
      begin
        Result:= pDeviceSettingsCombo;
        Exit;
      end;
    end;
  end;

  Result:= nil;
end;


//Clootie: this is special Delphi function to clear SmartPointers
procedure CD3DEnumeration.CleanupDirect3DInterfaces;
begin
  m_pD3D:= nil; // Yeah!!!
end;


//--------------------------------------------------------------------------------------
// Used to sort D3DDISPLAYMODEs
//--------------------------------------------------------------------------------------
function SortModesCallback(const arg1, arg2: Pointer): Integer;
var
  pdm1, pdm2: PD3DDisplayMode;
begin
  pdm1 := PD3DDisplayMode(arg1);
  pdm2 := PD3DDisplayMode(arg2);

  if (pdm1.Width > pdm2.Width) then Result:= 1
  else if (pdm1.Width < pdm2.Width) then Result:= -1
  else if (pdm1.Height > pdm2.Height) then Result:= 1
  else if (pdm1.Height < pdm2.Height) then Result:= -1
  else if (pdm1.Format > pdm2.Format) then Result:= 1
  else if (pdm1.Format < pdm2.Format) then Result:= -1
  else if (pdm1.RefreshRate > pdm2.RefreshRate) then Result:= 1
  else if (pdm1.RefreshRate < pdm2.RefreshRate) then Result:= -1
  else Result:= 0;
end;



{ CD3DEnumAdapterInfo }

//--------------------------------------------------------------------------------------
destructor CD3DEnumAdapterInfo.Destroy;
var
  i: Integer;
begin
  for i:= 0 to Length(deviceInfoList) - 1 do deviceInfoList[i].Free;
  deviceInfoList:= nil; // RemoveAll;
  inherited;
end;




{ CD3DEnumDeviceInfo }

//--------------------------------------------------------------------------------------
destructor CD3DEnumDeviceInfo.Destroy;
var
  i: Integer;
begin
  for i:= 0 to Length(deviceSettingsComboList) - 1 do Dispose(deviceSettingsComboList[i]);
  deviceSettingsComboList:= nil; // RemoveAll;
  inherited;
end;


//--------------------------------------------------------------------------------------
function CD3DEnumeration.GetPossibleDepthStencilFormatList: TD3DFormatArray;
begin
  Result:= m_DepthStecilPossibleList;
end;


//--------------------------------------------------------------------------------------
function CD3DEnumeration.GetPossibleMultisampleTypeList: TD3DMultiSampleTypeArray;
begin
  Result:= m_MultiSampleTypeList;
end;


//--------------------------------------------------------------------------------------
function CD3DEnumeration.GetPossiblePresentIntervalList: TLongWordArray;
begin
  Result:= m_PresentIntervalList;
end;


procedure CD3DEnumeration.SetPossibleDepthStencilFormatList(a: TD3DFormatArray);
begin
  m_DepthStecilPossibleList:= a;
end;

procedure CD3DEnumeration.SetPossibleMultisampleTypeList(a: TD3DMultiSampleTypeArray);
begin
  m_MultiSampleTypeList:= a;
end;

procedure CD3DEnumeration.SetPossiblePresentIntervalList(a: TLongWordArray);
begin
  m_PresentIntervalList:= a;
end;


//--------------------------------------------------------------------------------------
procedure CD3DEnumeration.ResetPossibleDepthStencilFormats;
begin
  m_DepthStecilPossibleList:= nil; // RemoveAll;
  SetLength(m_DepthStecilPossibleList, 6);
  m_DepthStecilPossibleList[0]:= D3DFMT_D16;
  m_DepthStecilPossibleList[1]:= D3DFMT_D15S1;
  m_DepthStecilPossibleList[2]:= D3DFMT_D24X8;
  m_DepthStecilPossibleList[3]:= D3DFMT_D24S8;
  m_DepthStecilPossibleList[4]:= D3DFMT_D24X4S4;
  m_DepthStecilPossibleList[5]:= D3DFMT_D32;
end;


//--------------------------------------------------------------------------------------
procedure CD3DEnumeration.ResetPossibleMultisampleTypeList;
begin
  m_MultiSampleTypeList:= nil; // RemoveAll;
  SetLength(m_MultiSampleTypeList, 17);
  m_MultiSampleTypeList[00]:= D3DMULTISAMPLE_NONE;
  m_MultiSampleTypeList[01]:= D3DMULTISAMPLE_NONMASKABLE;
  m_MultiSampleTypeList[02]:= D3DMULTISAMPLE_2_SAMPLES;
  m_MultiSampleTypeList[03]:= D3DMULTISAMPLE_3_SAMPLES;
  m_MultiSampleTypeList[04]:= D3DMULTISAMPLE_4_SAMPLES;
  m_MultiSampleTypeList[05]:= D3DMULTISAMPLE_5_SAMPLES;
  m_MultiSampleTypeList[06]:= D3DMULTISAMPLE_6_SAMPLES;
  m_MultiSampleTypeList[07]:= D3DMULTISAMPLE_7_SAMPLES;
  m_MultiSampleTypeList[08]:= D3DMULTISAMPLE_8_SAMPLES;
  m_MultiSampleTypeList[09]:= D3DMULTISAMPLE_9_SAMPLES;
  m_MultiSampleTypeList[10]:= D3DMULTISAMPLE_10_SAMPLES;
  m_MultiSampleTypeList[11]:= D3DMULTISAMPLE_11_SAMPLES;
  m_MultiSampleTypeList[12]:= D3DMULTISAMPLE_12_SAMPLES;
  m_MultiSampleTypeList[13]:= D3DMULTISAMPLE_13_SAMPLES;
  m_MultiSampleTypeList[14]:= D3DMULTISAMPLE_14_SAMPLES;
  m_MultiSampleTypeList[15]:= D3DMULTISAMPLE_15_SAMPLES;
  m_MultiSampleTypeList[16]:= D3DMULTISAMPLE_16_SAMPLES;
end;


//--------------------------------------------------------------------------------------
procedure CD3DEnumeration.ResetPossiblePresentIntervalList;
begin
  m_PresentIntervalList:= nil; // RemoveAll;
  SetLength(m_PresentIntervalList, 6);
  m_PresentIntervalList[0]:= D3DPRESENT_INTERVAL_IMMEDIATE;
  m_PresentIntervalList[1]:= D3DPRESENT_INTERVAL_DEFAULT;
  m_PresentIntervalList[2]:= D3DPRESENT_INTERVAL_ONE;
  m_PresentIntervalList[3]:= D3DPRESENT_INTERVAL_TWO;
  m_PresentIntervalList[4]:= D3DPRESENT_INTERVAL_THREE;
  m_PresentIntervalList[5]:= D3DPRESENT_INTERVAL_FOUR;
end;


//--------------------------------------------------------------------------------------
procedure CD3DEnumeration.GetPossibleVertexProcessingList(out pbSoftwareVP,
  pbHardwareVP, pbPureHarewareVP, pbMixedVP: Boolean);
begin
  pbSoftwareVP := m_bSoftwareVP;
  pbHardwareVP := m_bHardwareVP;
  pbPureHarewareVP := m_bPureHarewareVP;
  pbMixedVP := m_bMixedVP;
end;


//--------------------------------------------------------------------------------------
procedure CD3DEnumeration.SetPossibleVertexProcessingList(bSoftwareVP,
  bHardwareVP, bPureHarewareVP, bMixedVP: Boolean);
begin
  m_bSoftwareVP := bSoftwareVP;
  m_bHardwareVP := bHardwareVP;
  m_bPureHarewareVP := bPureHarewareVP;
  m_bMixedVP := bMixedVP;
end;


//--------------------------------------------------------------------------------------
procedure CD3DEnumeration.SetResolutionMinMax(nMinWidth, nMinHeight,
  nMaxWidth, nMaxHeight: LongWord);
begin
  m_nMinWidth := nMinWidth;
  m_nMinHeight := nMinHeight;
  m_nMaxWidth := nMaxWidth;
  m_nMaxHeight := nMaxHeight;
end;


//--------------------------------------------------------------------------------------
procedure CD3DEnumeration.SetRefreshMinMax(nMin, nMax: LongWord);
begin
  m_nRefreshMin := nMin;
  m_nRefreshMax := nMax;
end;


//--------------------------------------------------------------------------------------
procedure CD3DEnumeration.SetMultisampleQualityMax(nMax: LongWord);
begin
  if (nMax > $FFFF) then nMax := $FFFF;
  m_nMultisampleQualityMax := nMax;
end;


procedure CD3DEnumeration.SetRequirePostPixelShaderBlending(bRequire: Boolean);
begin
  m_bRequirePostPixelShaderBlending := bRequire;
end;


//--------------------------------------------------------------------------------------
// Returns the number of stencil bits in the specified D3DFORMAT
//--------------------------------------------------------------------------------------
function DXUTStencilBits(fmt: TD3DFormat): LongWord;
begin
  case fmt of
    D3DFMT_D16_LOCKABLE,
    D3DFMT_D16,
    D3DFMT_D32F_LOCKABLE,
    D3DFMT_D32,
    D3DFMT_D24X8:
      Result:= 0;

    D3DFMT_D15S1:
      Result:= 1;

    D3DFMT_D24X4S4:
      Result:= 4;

    D3DFMT_D24S8,
    D3DFMT_D24FS8:
      Result:= 8;

  else
    Result:= 0;
  end;
end;

//--------------------------------------------------------------------------------------
// Returns the number of depth bits in the specified D3DFORMAT
//--------------------------------------------------------------------------------------
function DXUTDepthBits(fmt: TD3DFormat): LongWord;
begin
  case fmt of
    D3DFMT_D32F_LOCKABLE,
    D3DFMT_D32:
      Result:= 32;

    D3DFMT_D24X8,
    D3DFMT_D24S8,
    D3DFMT_D24X4S4,
    D3DFMT_D24FS8:
      Result:= 24;

    D3DFMT_D16_LOCKABLE,
    D3DFMT_D16:
      Result:= 16;

    D3DFMT_D15S1:
      Result:= 15;

  else
    Result:= 0;
  end;
end;


//--------------------------------------------------------------------------------------
// Returns the number of alpha channel bits in the specified D3DFORMAT
//--------------------------------------------------------------------------------------
function DXUTAlphaChannelBits(fmt: TD3DFormat): LongWord;
begin
  case fmt of
    D3DFMT_R8G8B8:        Result:= 0;
    D3DFMT_A8R8G8B8:      Result:= 8;
    D3DFMT_X8R8G8B8:      Result:= 0;
    D3DFMT_R5G6B5:        Result:= 0;
    D3DFMT_X1R5G5B5:      Result:= 0;
    D3DFMT_A1R5G5B5:      Result:= 1;
    D3DFMT_A4R4G4B4:      Result:= 4;
    D3DFMT_R3G3B2:        Result:= 0;
    D3DFMT_A8R3G3B2:      Result:= 8;
    D3DFMT_X4R4G4B4:      Result:= 0;
    D3DFMT_A2B10G10R10:   Result:= 2;
    D3DFMT_A8B8G8R8:      Result:= 8;
    D3DFMT_A2R10G10B10:   Result:= 2;
    D3DFMT_A16B16G16R16:  Result:= 16;
   else Result:= 0;
  end;
end;


//--------------------------------------------------------------------------------------
// Returns the number of color channel bits in the specified D3DFORMAT
//--------------------------------------------------------------------------------------
function DXUTColorChannelBits(fmt: TD3DFormat): Integer;
begin
  case fmt of
    D3DFMT_R8G8B8:        Result:= 8;
    D3DFMT_A8R8G8B8:      Result:= 8;
    D3DFMT_X8R8G8B8:      Result:= 8;
    D3DFMT_R5G6B5:        Result:= 5;
    D3DFMT_X1R5G5B5:      Result:= 5;
    D3DFMT_A1R5G5B5:      Result:= 5;
    D3DFMT_A4R4G4B4:      Result:= 4;
    D3DFMT_R3G3B2:        Result:= 2;
    D3DFMT_A8R3G3B2:      Result:= 2;
    D3DFMT_X4R4G4B4:      Result:= 4;
    D3DFMT_A2B10G10R10:   Result:= 10;
    D3DFMT_A8B8G8R8:      Result:= 8;
    D3DFMT_A2R10G10B10:   Result:= 10;
    D3DFMT_A16B16G16R16:  Result:= 16;
   else Result:= 0;
  end;
end;

initialization
finalization
  FreeAndNil(d3denum);
end.
