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
 *  $Id: DXUTSettingsDlg.pas,v 1.17 2006/04/23 19:38:09 clootie Exp $
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
// File: DXUTSettingsDlg.cpp
//
// Dialog for selection of device settings
//
// Copyright (c) Microsoft Corporation. All rights reserved
//--------------------------------------------------------------------------------------

{$I DirectX.inc}

unit DXUTSettingsDlg;

interface

uses
  Windows, Messages, SysUtils,
  DXTypes, Direct3D9, DXerr9,
  DXUTgui, DXUTEnum;

const
  //--------------------------------------------------------------------------------------
  // Control IDs
  //--------------------------------------------------------------------------------------
  DXUTSETTINGSDLG_STATIC                  = -1;
  DXUTSETTINGSDLG_OK                      = 1;
  DXUTSETTINGSDLG_CANCEL                  = 2;
  DXUTSETTINGSDLG_ADAPTER                 = 3;
  DXUTSETTINGSDLG_DEVICE_TYPE             = 4;
  DXUTSETTINGSDLG_WINDOWED                = 5;
  DXUTSETTINGSDLG_FULLSCREEN              = 6;
  DXUTSETTINGSDLG_ADAPTER_FORMAT          = 7;
  DXUTSETTINGSDLG_ADAPTER_FORMAT_LABEL    = 8;
  DXUTSETTINGSDLG_RESOLUTION              = 9;
  DXUTSETTINGSDLG_RESOLUTION_LABEL        = 10;
  DXUTSETTINGSDLG_REFRESH_RATE            = 11;
  DXUTSETTINGSDLG_REFRESH_RATE_LABEL      = 12;
  DXUTSETTINGSDLG_BACK_BUFFER_FORMAT      = 13;
  DXUTSETTINGSDLG_DEPTH_STENCIL           = 14;
  DXUTSETTINGSDLG_MULTISAMPLE_TYPE        = 15;
  DXUTSETTINGSDLG_MULTISAMPLE_QUALITY     = 16;
  DXUTSETTINGSDLG_VERTEX_PROCESSING       = 17;
  DXUTSETTINGSDLG_PRESENT_INTERVAL        = 18;
  DXUTSETTINGSDLG_DEVICECLIP              = 19;
  DXUTSETTINGSDLG_RESOLUTION_SHOW_ALL     = 20;
  DXUTSETTINGSDLG_WINDOWED_GROUP          = $0100;


type
  //--------------------------------------------------------------------------------------
  // Dialog for selection of device settings
  // Use DXUTGetSettingsDialog() to access global instance
  // To control the contents of the dialog, use the CD3DEnumeration class.
  //--------------------------------------------------------------------------------------
  CD3DSettingsDlg = class
  protected
    m_pStateBlock: IDirect3DStateBlock9;
    m_Dialog: CDXUTDialog;
    m_bActive: Boolean;

    procedure SetActive(bActive: Boolean); { m_bActive = bActive; if( bActive ) Refresh(); }
    // function GetDialogControl: CDXUTDialog; { return &m_Dialog; } //Clootie: -> property

    procedure CreateControls;
    function SetDeviceSettingsFromUI: HRESULT;

    procedure OnEvent(nEvent: LongWord; nControlID: Integer; pControl: CDXUTControl);
    //static void WINAPI StaticOnEvent( UINT nEvent, int nControlID, CDXUTControl* pControl, void* pUserData );

    function GetCurrentAdapterInfo: CD3DEnumAdapterInfo;
    function GetCurrentDeviceInfo: CD3DEnumDeviceInfo;
    function GetCurrentDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;

    procedure AddAdapter(const strDescription: PWideChar; iAdapter: LongWord);
    function GetSelectedAdapter: LongWord;

    procedure AddDeviceType(devType: TD3DDevType);
    function GetSelectedDeviceType: TD3DDevType;

    procedure SetWindowed(bWindowed: Boolean);
    function IsWindowed: Boolean;

    procedure AddAdapterFormat(format: TD3DFormat);
    function GetSelectedAdapterFormat: TD3DFormat;

    procedure AddResolution(dwWidth, dwHeight: DWORD);
    procedure GetSelectedResolution(out pdwWidth, pdwHeight: DWORD);

    procedure AddRefreshRate(dwRate: DWORD);
    function GetSelectedRefreshRate: DWORD;

    procedure AddBackBufferFormat(format: TD3DFormat);
    function GetSelectedBackBufferFormat: TD3DFormat;

    procedure AddDepthStencilBufferFormat(format: TD3DFormat);
    function GetSelectedDepthStencilBufferFormat: TD3DFormat;

    procedure AddMultisampleType(_type: TD3DMultiSampleType);
    function GetSelectedMultisampleType: TD3DMultiSampleType;

    procedure AddMultisampleQuality(dwQuality: DWORD);
    function GetSelectedMultisampleQuality: DWORD;

    procedure AddVertexProcessingType(dwType: DWORD);
    function GetSelectedVertexProcessingType: DWORD;

    function GetSelectedPresentInterval: DWORD;

    procedure SetDeviceClip(bDeviceClip: Boolean);
    function IsDeviceClip: Boolean;

    function OnAdapterChanged: HRESULT;
    function OnDeviceTypeChanged: HRESULT;
    function OnWindowedFullScreenChanged: HRESULT;
    function OnAdapterFormatChanged: HRESULT;
    function OnResolutionChanged: HRESULT;
    function OnRefreshRateChanged: HRESULT;
    function OnBackBufferFormatChanged: HRESULT;
    function OnDepthStencilBufferFormatChanged: HRESULT;
    function OnMultisampleTypeChanged: HRESULT;
    function OnMultisampleQualityChanged: HRESULT;
    function OnVertexProcessingChanged: HRESULT;
    function OnPresentIntervalChanged: HRESULT;
    function OnDeviceClipChanged: HRESULT;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Init(pManager: CDXUTDialogResourceManager); overload;
    procedure Init(pManager: CDXUTDialogResourceManager; szControlTextureFileName: PWideChar); overload;
    procedure Init(pManager: CDXUTDialogResourceManager; szControlTextureResourceName: PWideChar; hModule: HMODULE); overload;

    function OnCreateDevice(pd3dDevice: IDirect3DDevice9): HRESULT;
    function Refresh: HRESULT;
    function OnResetDevice: HRESULT;
    function OnLostDevice: HRESULT;
    function OnRender(fElapsedTime: Single): HRESULT;
    function OnDestroyDevice: HRESULT;

    function MsgProc(hWnd: HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM): LRESULT;

    property IsActive: Boolean read m_bActive; //Clootie: to simplify C++ samples conversion
    property Active: Boolean read m_bActive write SetActive;
    property DialogControl: CDXUTDialog read m_Dialog;
  end;


function DXUTGetSettingsDialog: CD3DSettingsDlg;

//--------------------------------------------------------------------------------------
// Helper functions declarations
//--------------------------------------------------------------------------------------
function DXUTPresentIntervalToString(pi: LongWord): PWideChar;
function DXUTMultisampleTypeToString(MultiSampleType: TD3DMultiSampleType): PWideChar;
function DXUTD3DDeviceTypeToString(devType: TD3DDevType): PWideChar;
function DXUTVertexProcessingTypeToString(vpt: DWORD): PWideChar;

implementation

uses
  StrSafe, DXUT, DXUTmisc, DXUTcore;

//--------------------------------------------------------------------------------------
// File: DXUTSettingsDlg.cpp
//
// Dialog for selection of device settings
//
// Copyright (c) Microsoft Corporation. All rights reserved
//--------------------------------------------------------------------------------------


//--------------------------------------------------------------------------------------
// Global state
//--------------------------------------------------------------------------------------
var
  g_DeviceSettings: TDXUTDeviceSettings;
  dlg: CD3DSettingsDlg = nil;

function DXUTGetSettingsDialog: CD3DSettingsDlg;
begin
  // Using an accessor function gives control of the construction order
  //Clootie: This is C++ issue - in pascal we just create it here
  if (dlg = nil) then dlg:= CD3DSettingsDlg.Create;
  Result:= dlg;
end;


{ CD3DSettingsDlg }

//--------------------------------------------------------------------------------------
constructor CD3DSettingsDlg.Create;
begin
  m_Dialog:= CDXUTDialog.Create;
  m_pStateBlock := nil;
  m_bActive := False;
end;


//--------------------------------------------------------------------------------------
destructor CD3DSettingsDlg.Destroy;
begin
  OnDestroyDevice;
  m_Dialog.Free;
  inherited;
end;


//--------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.Init(pManager: CDXUTDialogResourceManager);
begin
  Assert(Assigned(pManager));
  m_Dialog.Init(pManager, False);  // Don't register this dialog.
  CreateControls;
end;


//--------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.Init(pManager: CDXUTDialogResourceManager; szControlTextureFileName: PWideChar);
begin
  Assert(Assigned(pManager));
  m_Dialog.Init(pManager, False, szControlTextureFileName);  // Don't register this dialog.
  CreateControls;
end;


//--------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.Init(pManager: CDXUTDialogResourceManager; szControlTextureResourceName: PWideChar; hModule: HMODULE);
begin
  Assert(Assigned(pManager));
  m_Dialog.Init(pManager, False, szControlTextureResourceName, hModule);  // Don't register this dialog.
  CreateControls;
end;


//--------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.SetActive(bActive: Boolean);
begin
  m_bActive := bActive;
  if bActive then Refresh;
end;


//--------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.CreateControls;
var
  pElement: CDXUTElement;
  pStatic: CDXUTStatic;
begin
  m_Dialog.EnableKeyboardInput(True);
  m_Dialog.SetFont(0, 'Arial', 15, FW_NORMAL);
  m_Dialog.SetFont(1, 'Arial', 28, FW_BOLD);

  // Right-justify static controls
  pElement := m_Dialog.GetDefaultElement(DXUT_CONTROL_STATIC, 0);
  if Assigned(pElement) then
  begin
    pElement.dwTextFormat := DT_VCENTER or DT_RIGHT;

    // Title
    m_Dialog.AddStatic(DXUTSETTINGSDLG_STATIC, 'Direct3D Settings', 10, 5, 400, 50, False, @pStatic);
    pElement := pStatic.Element[0];
    pElement.iFont := 1;
    pElement.dwTextFormat := DT_TOP or DT_LEFT;
  end;

  // DXUTSETTINGSDLG_ADAPTER
  m_Dialog.AddStatic(DXUTSETTINGSDLG_STATIC, 'Display Adapter', 10, 50, 180, 23);
  m_Dialog.AddComboBox(DXUTSETTINGSDLG_ADAPTER, 200, 50, 300, 23);

  // DXUTSETTINGSDLG_DEVICE_TYPE
  m_Dialog.AddStatic(DXUTSETTINGSDLG_STATIC, 'Render Device', 10, 75, 180, 23);
  m_Dialog.AddComboBox(DXUTSETTINGSDLG_DEVICE_TYPE, 200, 75, 300, 23);

  // DXUTSETTINGSDLG_WINDOWED, DXUTSETTINGSDLG_FULLSCREEN
  m_Dialog.AddRadioButton(DXUTSETTINGSDLG_WINDOWED, DXUTSETTINGSDLG_WINDOWED_GROUP, 'Windowed', 240, 105, 300, 16);
  m_Dialog.AddCheckBox(DXUTSETTINGSDLG_DEVICECLIP, 'Clip to device when window spans across multiple monitors', 250, 126, 400, 16);
  m_Dialog.AddRadioButton(DXUTSETTINGSDLG_FULLSCREEN, DXUTSETTINGSDLG_WINDOWED_GROUP, 'Full Screen', 240, 147, 300, 16);

  // DXUTSETTINGSDLG_ADAPTER_FORMAT
  m_Dialog.AddStatic(DXUTSETTINGSDLG_ADAPTER_FORMAT_LABEL, 'Adapter Format', 10, 180, 180, 23);
  m_Dialog.AddComboBox(DXUTSETTINGSDLG_ADAPTER_FORMAT, 200, 180, 300, 23);

  // DXUTSETTINGSDLG_RESOLUTION
  m_Dialog.AddStatic(DXUTSETTINGSDLG_RESOLUTION_LABEL, 'Resolution', 10, 205, 180, 23);
  m_Dialog.AddComboBox(DXUTSETTINGSDLG_RESOLUTION, 200, 205, 200, 23);
  m_Dialog.GetComboBox(DXUTSETTINGSDLG_RESOLUTION).SetDropHeight(106);

  // DXUTSETTINGSDLG_RES_SHOW_ALL
  m_Dialog.AddCheckBox(DXUTSETTINGSDLG_RESOLUTION_SHOW_ALL, 'Show All Aspect Ratios', 420, 205, 200, 23, False);

  // DXUTSETTINGSDLG_REFRESH_RATE
  m_Dialog.AddStatic(DXUTSETTINGSDLG_REFRESH_RATE_LABEL, 'Refresh Rate', 10, 230, 180, 23);
  m_Dialog.AddComboBox(DXUTSETTINGSDLG_REFRESH_RATE, 200, 230, 300, 23);

  // DXUTSETTINGSDLG_BACK_BUFFER_FORMAT
  m_Dialog.AddStatic(DXUTSETTINGSDLG_STATIC, 'Back Buffer Format', 10, 265, 180, 23);
  m_Dialog.AddComboBox(DXUTSETTINGSDLG_BACK_BUFFER_FORMAT, 200, 265, 300, 23);

  // DXUTSETTINGSDLG_DEPTH_STENCIL
  m_Dialog.AddStatic(DXUTSETTINGSDLG_STATIC, 'Depth/Stencil Format', 10, 290, 180, 23);
  m_Dialog.AddComboBox(DXUTSETTINGSDLG_DEPTH_STENCIL, 200, 290, 300, 23);

  // DXUTSETTINGSDLG_MULTISAMPLE_TYPE
  m_Dialog.AddStatic(DXUTSETTINGSDLG_STATIC, 'Multisample Type', 10, 315, 180, 23);
  m_Dialog.AddComboBox(DXUTSETTINGSDLG_MULTISAMPLE_TYPE, 200, 315, 300, 23);

  // DXUTSETTINGSDLG_MULTISAMPLE_QUALITY
  m_Dialog.AddStatic(DXUTSETTINGSDLG_STATIC, 'Multisample Quality', 10, 340, 180, 23);
  m_Dialog.AddComboBox(DXUTSETTINGSDLG_MULTISAMPLE_QUALITY, 200, 340, 300, 23);

   // DXUTSETTINGSDLG_VERTEX_PROCESSING
  m_Dialog.AddStatic(DXUTSETTINGSDLG_STATIC, 'Vertex Processing', 10, 365, 180, 23);
  m_Dialog.AddComboBox(DXUTSETTINGSDLG_VERTEX_PROCESSING, 200, 365, 300, 23);

   // DXUTSETTINGSDLG_PRESENT_INTERVAL
  m_Dialog.AddStatic(DXUTSETTINGSDLG_STATIC, 'Vertical Sync', 10, 390, 180, 23);
  m_Dialog.AddComboBox(DXUTSETTINGSDLG_PRESENT_INTERVAL, 200, 390, 300, 23);

  // DXUTSETTINGSDLG_OK, DXUTSETTINGSDLG_CANCEL
  m_Dialog.AddButton(DXUTSETTINGSDLG_OK, 'OK', 230, 435, 73, 31);
  m_Dialog.AddButton(DXUTSETTINGSDLG_CANCEL, 'Cancel', 315, 435, 73, 31, 0, True);
end;


//--------------------------------------------------------------------------------------
procedure StaticOnEvent(nEvent: LongWord; nControlID: Integer; pControl: CDXUTControl; pUserData: Pointer); stdcall;
var
  pD3DSettings: CD3DSettingsDlg;
begin
  pD3DSettings := CD3DSettingsDlg(pUserData);
  if (pD3DSettings <> nil) 
  then pD3DSettings.OnEvent(nEvent, nControlID, pControl);
end;


//--------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnCreateDevice(pd3dDevice: IDirect3DDevice9): HRESULT;
begin
  if (pd3dDevice = nil) then
  begin
    Result:= DXUT_ERR_MSGBOX('CD3DSettingsDlg.OnCreatedDevice', E_INVALIDARG);
    Exit;
  end;

  // Create the fonts/textures
  m_Dialog.SetCallback(StaticOnEvent, Self);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Changes the UI defaults to the current device settings
//--------------------------------------------------------------------------------------
function CD3DSettingsDlg.Refresh: HRESULT;
var
  pD3DEnum: CD3DEnumeration;
  pBestDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;
  pAdapterInfoList: TD3DEnumAdapterInfoArray;
  pAdapterCombo: CDXUTComboBox;
  iAdapter: Integer;
  pAdapterInfo: CD3DEnumAdapterInfo;
begin
  pAdapterInfoList:= nil;
  pD3DEnum := DXUTGetEnumeration;
  g_DeviceSettings := DXUTGetDeviceSettings;

  // Fill the UI with the current settings
  AddDeviceType(g_DeviceSettings.DeviceType);
  SetWindowed(g_DeviceSettings.pp.Windowed);
  SetDeviceClip(0 <> (g_DeviceSettings.pp.Flags and D3DPRESENTFLAG_DEVICECLIP));
  AddAdapterFormat(g_DeviceSettings.AdapterFormat);
  AddResolution(g_DeviceSettings.pp.BackBufferWidth, g_DeviceSettings.pp.BackBufferHeight);
  AddRefreshRate(g_DeviceSettings.pp.FullScreen_RefreshRateInHz);
  AddBackBufferFormat(g_DeviceSettings.pp.BackBufferFormat);
  AddDepthStencilBufferFormat(g_DeviceSettings.pp.AutoDepthStencilFormat);
  AddMultisampleType(g_DeviceSettings.pp.MultiSampleType);
  AddMultisampleQuality(g_DeviceSettings.pp.MultiSampleQuality);

  if (g_DeviceSettings.BehaviorFlags and D3DCREATE_PUREDEVICE <> 0) then
    AddVertexProcessingType(D3DCREATE_PUREDEVICE)
  else if (g_DeviceSettings.BehaviorFlags and D3DCREATE_HARDWARE_VERTEXPROCESSING <> 0) then
    AddVertexProcessingType(D3DCREATE_HARDWARE_VERTEXPROCESSING)
  else if (g_DeviceSettings.BehaviorFlags and D3DCREATE_SOFTWARE_VERTEXPROCESSING <> 0) then
    AddVertexProcessingType(D3DCREATE_SOFTWARE_VERTEXPROCESSING)
  else if (g_DeviceSettings.BehaviorFlags and D3DCREATE_MIXED_VERTEXPROCESSING <> 0) then
    AddVertexProcessingType(D3DCREATE_MIXED_VERTEXPROCESSING);

  pBestDeviceSettingsCombo := pD3DEnum.GetDeviceSettingsCombo(
      g_DeviceSettings.AdapterOrdinal, g_DeviceSettings.DeviceType,
      g_DeviceSettings.AdapterFormat, g_DeviceSettings.pp.BackBufferFormat,
      g_DeviceSettings.pp.Windowed);
  if (nil = pBestDeviceSettingsCombo) then
  begin
    Result:= DXUT_ERR_MSGBOX('GetDeviceSettingsCombo', E_INVALIDARG);
    Exit;
  end;

  // Get the adapters list from CD3DEnumeration object
  pAdapterInfoList := pD3DEnum.GetAdapterInfoList;

  if (Length(pAdapterInfoList) = 0) then
  begin
    Result:= DXUT_ERR_MSGBOX('CD3DSettingsDlg.OnCreatedDevice', DXUTERR_NOCOMPATIBLEDEVICES);
    Exit;
  end;

  pAdapterCombo := m_Dialog.GetComboBox(DXUTSETTINGSDLG_ADAPTER);
  pAdapterCombo.RemoveAllItems;

  // Add adapters
  for iAdapter:= 0 to Length(pAdapterInfoList) - 1 do
  begin
    pAdapterInfo := pAdapterInfoList[iAdapter];
    AddAdapter(pAdapterInfo.szUniqueDescription, pAdapterInfo.AdapterOrdinal);
  end;

  pAdapterCombo.SetSelectedByData(ULongToPtr(g_DeviceSettings.AdapterOrdinal));

  Result := OnAdapterChanged;
  if FAILED(Result) then Exit;

  //m_Dialog.Refresh();
  CDXUTDialog.SetRefreshTime(DXUTGetTime);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnResetDevice: HRESULT;
var
  pDesc: PD3DSurfaceDesc;
  pd3dDevice: IDirect3DDevice9;
begin
  pDesc := DXUTGetBackBufferSurfaceDesc;
  m_Dialog.SetLocation(0, 0);
  m_Dialog.SetSize(pDesc.Width, pDesc.Height);
  m_Dialog.SetBackgroundColors(D3DCOLOR_ARGB(255, 98, 138, 206),
                               D3DCOLOR_ARGB(255, 54, 105, 192),
                               D3DCOLOR_ARGB(255, 54, 105, 192),
                               D3DCOLOR_ARGB(255, 10,  73, 179));


  pd3dDevice := DXUTGetD3DDevice;
  pd3dDevice.BeginStateBlock;
  pd3dDevice.SetRenderState(D3DRS_FILLMODE, D3DFILL_SOLID);
  pd3dDevice.EndStateBlock(m_pStateBlock);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnRender(fElapsedTime: Single): HRESULT;
var
  pd3dDevice: IDirect3DDevice9;
begin
  pd3dDevice := DXUTGetD3DDevice;

  // Clear the render target and the zbuffer
  pd3dDevice.Clear(0, nil, D3DCLEAR_TARGET, $00003F3F, 1.0, 0);

  // Render the scene
  if SUCCEEDED(pd3dDevice.BeginScene) then
  begin
    m_pStateBlock.Capture;
    pd3dDevice.SetRenderState(D3DRS_FILLMODE, D3DFILL_SOLID);
    m_Dialog.OnRender(fElapsedTime);
    m_pStateBlock.Apply;
    pd3dDevice.EndScene;
  end;

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CD3DSettingsDlg.MsgProc(hWnd: HWND; uMsg: LongWord;
  wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  m_Dialog.MsgProc(hWnd, uMsg, wParam, lParam);
  if (uMsg = WM_KEYDOWN) and (wParam = VK_F2) then SetActive(False);
  Result:= 0;
end;


//--------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnLostDevice: HRESULT;
begin
  m_pStateBlock := nil;
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnDestroyDevice: HRESULT;
begin
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.OnEvent(nEvent: LongWord; nControlID: Integer;
  pControl: CDXUTControl);
var
  rcClient: TRect;
  dwWindowWidth, dwWindowHeight: DWORD;
begin
  case nControlID of
    DXUTSETTINGSDLG_ADAPTER:               OnAdapterChanged;
    DXUTSETTINGSDLG_DEVICE_TYPE:           OnDeviceTypeChanged;
    DXUTSETTINGSDLG_WINDOWED:              OnWindowedFullScreenChanged;
    DXUTSETTINGSDLG_FULLSCREEN:            OnWindowedFullScreenChanged;
    DXUTSETTINGSDLG_ADAPTER_FORMAT:        OnAdapterFormatChanged;
    DXUTSETTINGSDLG_RESOLUTION_SHOW_ALL:   OnAdapterFormatChanged;
    DXUTSETTINGSDLG_RESOLUTION:            OnResolutionChanged;
    DXUTSETTINGSDLG_REFRESH_RATE:          OnRefreshRateChanged;
    DXUTSETTINGSDLG_BACK_BUFFER_FORMAT:    OnBackBufferFormatChanged;
    DXUTSETTINGSDLG_DEPTH_STENCIL:         OnDepthStencilBufferFormatChanged;
    DXUTSETTINGSDLG_MULTISAMPLE_TYPE:      OnMultisampleTypeChanged;
    DXUTSETTINGSDLG_MULTISAMPLE_QUALITY:   OnMultisampleQualityChanged;
    DXUTSETTINGSDLG_VERTEX_PROCESSING:     OnVertexProcessingChanged;
    DXUTSETTINGSDLG_PRESENT_INTERVAL:      OnPresentIntervalChanged;
    DXUTSETTINGSDLG_DEVICECLIP:            OnDeviceClipChanged;

    DXUTSETTINGSDLG_OK:
    begin
      if g_DeviceSettings.pp.Windowed then
      begin
        g_DeviceSettings.pp.FullScreen_RefreshRateInHz := 0;

        if DXUTIsWindowed then GetClientRect(DXUTGetHWND, rcClient)
        else rcClient := DXUTGetWindowClientRectAtModeChange;

        dwWindowWidth  := rcClient.right - rcClient.left;
        dwWindowHeight := rcClient.bottom - rcClient.top;

        g_DeviceSettings.pp.BackBufferWidth := dwWindowWidth;
        g_DeviceSettings.pp.BackBufferHeight := dwWindowHeight;
      end;

      if (g_DeviceSettings.pp.MultiSampleType <> D3DMULTISAMPLE_NONE) then
      begin
        g_DeviceSettings.pp.Flags := g_DeviceSettings.pp.Flags and not D3DPRESENTFLAG_LOCKABLE_BACKBUFFER;
      end;

      DXUTCreateDeviceFromSettings(@g_DeviceSettings);
      Active:= False;
    end;

    DXUTSETTINGSDLG_CANCEL:
      Active:= False;
  end;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.SetDeviceSettingsFromUI: HRESULT;
var
  pComboBox: CDXUTComboBox;
  pRadioButton: CDXUTRadioButton;
  dwResolution: DWORD;
begin
  // DXUTSETTINGSDLG_DEVICE_TYPE
  pComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_DEVICE_TYPE);
  g_DeviceSettings.DeviceType := TD3DDevType(PtrToUlong(pComboBox.GetSelectedData));

  // DXUTSETTINGSDLG_WINDOWED
  pRadioButton := m_Dialog.GetRadioButton(DXUTSETTINGSDLG_WINDOWED);
  g_DeviceSettings.pp.Windowed := pRadioButton.Checked;

  // DXUTSETTINGSDLG_ADAPTER_FORMAT
  pComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_ADAPTER_FORMAT);
  g_DeviceSettings.AdapterFormat := TD3DFormat(PtrToUlong(pComboBox.GetSelectedData));


  if g_DeviceSettings.pp.Windowed then
  begin
    g_DeviceSettings.pp.BackBufferFormat := D3DFMT_UNKNOWN;
    g_DeviceSettings.pp.FullScreen_RefreshRateInHz := 0;
  end else
  begin
    // DXUTSETTINGSDLG_BACK_BUFFER_FORMAT
    pComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_BACK_BUFFER_FORMAT);
    g_DeviceSettings.pp.BackBufferFormat := TD3DFormat(PtrToUlong(pComboBox.GetSelectedData));

    // DXUTSETTINGSDLG_RESOLUTION
    pComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_RESOLUTION);
    dwResolution := PtrToUlong(pComboBox.GetSelectedData);
    g_DeviceSettings.pp.BackBufferWidth := HIWORD(dwResolution);
    g_DeviceSettings.pp.BackBufferHeight := LOWORD(dwResolution);

    // DXUTSETTINGSDLG_REFRESH_RATE
    pComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_REFRESH_RATE);
    g_DeviceSettings.pp.FullScreen_RefreshRateInHz := PtrToUlong(pComboBox.GetSelectedData);
  end;

  // DXUTSETTINGSDLG_DEPTH_STENCIL
  pComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_DEPTH_STENCIL);
  g_DeviceSettings.pp.AutoDepthStencilFormat := TD3DFormat(PtrToUlong(pComboBox.GetSelectedData));
    
  Result:= S_OK;
end;

//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.GetCurrentAdapterInfo: CD3DEnumAdapterInfo;
begin
  Result:= DXUTGetEnumeration.GetAdapterInfo(g_DeviceSettings.AdapterOrdinal);
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.GetCurrentDeviceInfo: CD3DEnumDeviceInfo;
begin
  Result:= DXUTGetEnumeration.GetDeviceInfo(g_DeviceSettings.AdapterOrdinal,
                                            g_DeviceSettings.DeviceType);
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.GetCurrentDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;
begin
  Result:= DXUTGetEnumeration.GetDeviceSettingsCombo(
               g_DeviceSettings.AdapterOrdinal,
               g_DeviceSettings.DeviceType,
               g_DeviceSettings.AdapterFormat,
               g_DeviceSettings.pp.BackBufferFormat,
               g_DeviceSettings.pp.Windowed);
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnAdapterChanged: HRESULT;
var
  pDeviceTypeComboBox: CDXUTComboBox;
  pAdapterInfo: CD3DEnumAdapterInfo;
  iDeviceInfo: Integer;
  pDeviceInfo: CD3DEnumDeviceInfo;
begin
  // Store the adapter index
  g_DeviceSettings.AdapterOrdinal := GetSelectedAdapter;

  // DXUTSETTINGSDLG_DEVICE_TYPE
  pDeviceTypeComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_DEVICE_TYPE);
  pDeviceTypeComboBox.RemoveAllItems;

  pAdapterInfo := GetCurrentAdapterInfo;
  if (pAdapterInfo = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  for iDeviceInfo:= 0 to Length(pAdapterInfo.deviceInfoList) - 1 do
  begin
    pDeviceInfo := pAdapterInfo.deviceInfoList[iDeviceInfo];
    AddDeviceType(pDeviceInfo.DeviceType);
  end;

  pDeviceTypeComboBox.SetSelectedByData(ULongToPtr(g_DeviceSettings.DeviceType));

  Result := OnDeviceTypeChanged;
  if FAILED(Result) then Exit;

  Result:= S_OK;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnDeviceTypeChanged: HRESULT;
var
  bHasWindowedDeviceCombo, bHasFullScreenDeviceCombo: Boolean;
  pDeviceInfo: CD3DEnumDeviceInfo;
  idc: Integer;
  pDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;
begin
  g_DeviceSettings.DeviceType := GetSelectedDeviceType;

  // Update windowed/full screen radio buttons
  bHasWindowedDeviceCombo := False;
  bHasFullScreenDeviceCombo := False;

  pDeviceInfo := GetCurrentDeviceInfo;
  if (pDeviceInfo = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  for idc := 0 to Length(pDeviceInfo.deviceSettingsComboList) - 1 do
  begin
    pDeviceSettingsCombo := pDeviceInfo.deviceSettingsComboList[idc];

    if pDeviceSettingsCombo.Windowed
    then bHasWindowedDeviceCombo := True
    else bHasFullScreenDeviceCombo := True;
  end;

  // DXUTSETTINGSDLG_WINDOWED, DXUTSETTINGSDLG_FULLSCREEN
  m_Dialog.SetControlEnabled(DXUTSETTINGSDLG_WINDOWED, bHasWindowedDeviceCombo);
  m_Dialog.SetControlEnabled(DXUTSETTINGSDLG_FULLSCREEN, bHasFullScreenDeviceCombo);

  SetWindowed(g_DeviceSettings.pp.Windowed and bHasWindowedDeviceCombo);

  Result := OnWindowedFullScreenChanged;
  if FAILED(Result) then Exit;

  Result:= S_OK;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnWindowedFullScreenChanged: HRESULT;
var
  bWindowed: Boolean;
  bDeviceClip: Boolean;
  pD3D: IDirect3D9;
  mode: TD3DDisplayMode;
  adapterFormat: TD3DFormat;
  dwWidth: DWORD;
  dwHeight: DWORD;
  dwRefreshRate: DWORD;
  pAdapterFormatComboBox, pResolutionComboBox, pRefreshRateComboBox: CDXUTComboBox;
  pDeviceInfo: CD3DEnumDeviceInfo;
  pSettingsCombo: PD3DEnumDeviceSettingsCombo;
  iSettingsCombo: Integer;
  rc: TRect;
begin
  bWindowed := IsWindowed;
  g_DeviceSettings.pp.Windowed := bWindowed;

  m_Dialog.SetControlEnabled(DXUTSETTINGSDLG_ADAPTER_FORMAT_LABEL, not bWindowed);
  m_Dialog.SetControlEnabled(DXUTSETTINGSDLG_RESOLUTION_LABEL, not bWindowed);
  m_Dialog.SetControlEnabled(DXUTSETTINGSDLG_REFRESH_RATE_LABEL, not bWindowed);

  m_Dialog.SetControlEnabled(DXUTSETTINGSDLG_ADAPTER_FORMAT, not bWindowed);
  m_Dialog.SetControlEnabled(DXUTSETTINGSDLG_RESOLUTION, not bWindowed);
  m_Dialog.SetControlEnabled(DXUTSETTINGSDLG_RESOLUTION_SHOW_ALL, not bWindowed);
  m_Dialog.SetControlEnabled(DXUTSETTINGSDLG_REFRESH_RATE, not bWindowed);
  m_Dialog.SetControlEnabled(DXUTSETTINGSDLG_DEVICECLIP, bWindowed);

  bDeviceClip := (g_DeviceSettings.pp.Flags and D3DPRESENTFLAG_DEVICECLIP <> 0);

  // If windowed, get the appropriate adapter format from Direct3D
  if g_DeviceSettings.pp.Windowed then
  begin
    pD3D := DXUTGetD3DObject;
    if (pD3D = nil) then
    begin
      Result:= DXTRACE_ERR('DXUTGetD3DObject', E_FAIL);
      Exit;
    end;

    Result := pD3D.GetAdapterDisplayMode(g_DeviceSettings.AdapterOrdinal, mode);
    if FAILED(Result) then
    begin
      Result:= DXTRACE_ERR('GetAdapterDisplayMode', Result);
      Exit;
    end;

    // Default resolution to the fullscreen res that was last used
    rc := DXUTGetFullsceenClientRectAtModeChange;
    if (rc.right = 0) or (rc.bottom = 0) then
    begin
      // If nothing last used, then default to the adapter desktop res
      g_DeviceSettings.pp.BackBufferWidth := mode.Width;
      g_DeviceSettings.pp.BackBufferHeight := mode.Height;
    end else
    begin
      g_DeviceSettings.pp.BackBufferWidth := rc.right;
      g_DeviceSettings.pp.BackBufferHeight := rc.bottom;
    end;

    g_DeviceSettings.AdapterFormat := mode.Format;
    g_DeviceSettings.pp.FullScreen_RefreshRateInHz := mode.RefreshRate;
  end;

  adapterFormat := g_DeviceSettings.AdapterFormat;
  dwWidth := g_DeviceSettings.pp.BackBufferWidth;
  dwHeight := g_DeviceSettings.pp.BackBufferHeight;
  dwRefreshRate := g_DeviceSettings.pp.FullScreen_RefreshRateInHz;

  // DXUTSETTINGSDLG_DEVICECLIP
  SetDeviceClip(bDeviceClip);
    
  // DXUTSETTINGSDLG_ADAPTER_FORMAT
  pAdapterFormatComboBox := m_Dialog.GetComboBox( DXUTSETTINGSDLG_ADAPTER_FORMAT);
  if (pAdapterFormatComboBox = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;
  pAdapterFormatComboBox.RemoveAllItems;

  pDeviceInfo := GetCurrentDeviceInfo;
  if (pDeviceInfo = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  if bWindowed then
  begin
    AddAdapterFormat(adapterFormat);
  end else
  begin
    for iSettingsCombo:= 0 to Length(pDeviceInfo.deviceSettingsComboList) - 1 do
    begin
      pSettingsCombo := pDeviceInfo.deviceSettingsComboList[iSettingsCombo];
      AddAdapterFormat(pSettingsCombo.AdapterFormat);
    end;
  end;

  pAdapterFormatComboBox.SetSelectedByData(ULongToPtr(adapterFormat));

  Result := OnAdapterFormatChanged;
  if FAILED(Result) then Exit;

  // DXUTSETTINGSDLG_RESOLUTION
  pResolutionComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_RESOLUTION);

  if bWindowed then
  begin
    pResolutionComboBox.RemoveAllItems;
    AddResolution(dwWidth, dwHeight);
  end;

  pResolutionComboBox.SetSelectedByData(ULongToPtr(MAKELONG(dwWidth, dwHeight)));

  Result := OnResolutionChanged;
  if FAILED(Result) then Exit;

  // DXUTSETTINGSDLG_REFRESH_RATE
  pRefreshRateComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_REFRESH_RATE);

  if bWindowed then
  begin
    pRefreshRateComboBox.RemoveAllItems;
    AddRefreshRate(dwRefreshRate);
  end;

  pRefreshRateComboBox.SetSelectedByData( ULongToPtr(dwRefreshRate));

  Result := OnRefreshRateChanged;
  if FAILED(Result) then Exit;

  Result:= S_OK;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnAdapterFormatChanged: HRESULT;
var
  adapterFormat: TD3DFormat;
  pResolutionComboBox, pBackBufferFormatComboBox: CDXUTComboBox;
  pAdapterInfo: CD3DEnumAdapterInfo;
  idm: Integer;
  DisplayMode: TD3DDisplayMode;
  dwCurResolution: DWORD;
  pDeviceInfo: CD3DEnumDeviceInfo;
  bWindowed: Boolean;
  bHasWindowedBackBuffer: Boolean;
  idc: Integer;
  pDeviceCombo: PD3DEnumDeviceSettingsCombo;
  bShowAll: Boolean;
  dmDesktop: TD3DDisplayMode;
  fDesktopAspectRatio: Single;
  fAspect: Single;
begin
  // DXUTSETTINGSDLG_ADAPTER_FORMAT
  adapterFormat := GetSelectedAdapterFormat;
  g_DeviceSettings.AdapterFormat := adapterFormat;

  // DXUTSETTINGSDLG_RESOLUTION
  pResolutionComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_RESOLUTION);
  pResolutionComboBox.RemoveAllItems;

  pAdapterInfo := GetCurrentAdapterInfo;
  if (pAdapterInfo = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  bShowAll := m_Dialog.GetCheckBox(DXUTSETTINGSDLG_RESOLUTION_SHOW_ALL).Checked;

  // Get the desktop aspect ratio
  DXUTGetDesktopResolution(g_DeviceSettings.AdapterOrdinal, dmDesktop.Width, dmDesktop.Height);
  fDesktopAspectRatio := dmDesktop.Width / dmDesktop.Height;

  for idm := 0 to Length(pAdapterInfo.displayModeList) - 1 do
  begin
    DisplayMode := pAdapterInfo.displayModeList[idm];
    fAspect := DisplayMode.Width / DisplayMode.Height;

    if (DisplayMode.Format = adapterFormat) then
    begin
      // If "Show All" is not checked, then hide all resolutions
      // that don't match the aspect ratio of the desktop resolution
      if bShowAll or (not bShowAll and (Abs(fDesktopAspectRatio - fAspect) < 0.05))
      then AddResolution(DisplayMode.Width, DisplayMode.Height);
    end;
  end;

  dwCurResolution := MAKELONG(g_DeviceSettings.pp.BackBufferWidth,
                              g_DeviceSettings.pp.BackBufferHeight);

  pResolutionComboBox.SetSelectedByData(ULongToPtr(dwCurResolution));

  Result := OnResolutionChanged;
  if FAILED(Result) then Exit;

  // DXUTSETTINGSDLG_BACK_BUFFER_FORMAT
  pBackBufferFormatComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_BACK_BUFFER_FORMAT);
  pBackBufferFormatComboBox.RemoveAllItems;

  pDeviceInfo := GetCurrentDeviceInfo;
  if (pDeviceInfo = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  bWindowed := IsWindowed;
  bHasWindowedBackBuffer := False;

  for idc := 0 to Length(pDeviceInfo.deviceSettingsComboList) - 1 do
  begin
    pDeviceCombo := pDeviceInfo.deviceSettingsComboList[idc];
    if (pDeviceCombo.Windowed = bWindowed) and
       (pDeviceCombo.AdapterFormat = g_DeviceSettings.AdapterFormat) then
    begin
      AddBackBufferFormat(pDeviceCombo.BackBufferFormat);
      bHasWindowedBackBuffer := True;
    end;
  end;

  pBackBufferFormatComboBox.SetSelectedByData(ULongToPtr(g_DeviceSettings.pp.BackBufferFormat));

  Result := OnBackBufferFormatChanged;
  if FAILED(Result) then Exit;

  if not bHasWindowedBackBuffer then
  begin
    m_Dialog.SetControlEnabled(DXUTSETTINGSDLG_WINDOWED, False);

    if g_DeviceSettings.pp.Windowed then
    begin
      SetWindowed(False);

      Result := OnWindowedFullScreenChanged;
      if FAILED(Result) then Exit;
    end;
  end;

  Result:= S_OK;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnResolutionChanged: HRESULT;
var
  pAdapterInfo: CD3DEnumAdapterInfo;
  dwWidth, dwHeight: DWORD;
  dwRefreshRate: DWORD;
  pRefreshRateComboBox: CDXUTComboBox;
  adapterFormat: TD3DFormat;
  idm: Integer;
  displayMode: TD3DDisplayMode;
begin
  pAdapterInfo := GetCurrentAdapterInfo;
  if (pAdapterInfo = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  // Set resolution
  GetSelectedResolution(dwWidth, dwHeight);
  g_DeviceSettings.pp.BackBufferWidth := dwWidth;
  g_DeviceSettings.pp.BackBufferHeight := dwHeight;

  dwRefreshRate := g_DeviceSettings.pp.FullScreen_RefreshRateInHz;

  // Update the refresh rate list
  pRefreshRateComboBox := m_Dialog.GetComboBox( DXUTSETTINGSDLG_REFRESH_RATE);
  pRefreshRateComboBox.RemoveAllItems;

  adapterFormat := g_DeviceSettings.AdapterFormat;
  for idm := 0 to Length(pAdapterInfo.displayModeList) - 1 do
  begin
    displayMode := pAdapterInfo.displayModeList[idm];

    if (displayMode.Format = adapterFormat) and
       (displayMode.Width = dwWidth) and
       (displayMode.Height = dwHeight) then
    begin
      AddRefreshRate(displayMode.RefreshRate);
    end;
  end;

  pRefreshRateComboBox.SetSelectedByData(ULongToPtr(dwRefreshRate));

  Result := OnRefreshRateChanged;
  if FAILED(Result) then Exit;

  Result:= S_OK;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnRefreshRateChanged: HRESULT;
begin
  // Set refresh rate
  g_DeviceSettings.pp.FullScreen_RefreshRateInHz := GetSelectedRefreshRate;

  Result:= S_OK;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnBackBufferFormatChanged: HRESULT;
var
  adapterFormat, backBufferFormat: TD3DFormat;
  pDeviceInfo: CD3DEnumDeviceInfo;
  bAllowSoftwareVP, bAllowHardwareVP, bAllowPureHardwareVP, bAllowMixedVP: Boolean;
  idc, ifmt: Integer;
  pDeviceCombo: PD3DEnumDeviceSettingsCombo;
  pDepthStencilComboBox: CDXUTComboBox;
  fmt: TD3DFormat;
  pVertexProcessingComboBox: CDXUTComboBox;
  pPresentIntervalComboBox: CDXUTComboBox;
begin
  g_DeviceSettings.pp.BackBufferFormat := GetSelectedBackBufferFormat;

  adapterFormat := g_DeviceSettings.AdapterFormat;
  backBufferFormat := g_DeviceSettings.pp.BackBufferFormat;

  pDeviceInfo := GetCurrentDeviceInfo;
  if (pDeviceInfo = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  DXUTGetEnumeration.GetPossibleVertexProcessingList(bAllowSoftwareVP, bAllowHardwareVP,
                                                     bAllowPureHardwareVP, bAllowMixedVP);

  for idc:= 0 to Length(pDeviceInfo.deviceSettingsComboList) - 1 do
  begin
    pDeviceCombo := pDeviceInfo.deviceSettingsComboList[idc];

    if (pDeviceCombo.Windowed = g_DeviceSettings.pp.Windowed) and
       (pDeviceCombo.AdapterFormat = adapterFormat) and
       (pDeviceCombo.BackBufferFormat = backBufferFormat) then
    begin
      pDepthStencilComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_DEPTH_STENCIL);
      pDepthStencilComboBox.RemoveAllItems;
      pDepthStencilComboBox.Enabled:= g_DeviceSettings.pp.EnableAutoDepthStencil;

      if g_DeviceSettings.pp.EnableAutoDepthStencil then
      begin
        for ifmt:= 0 to Length(pDeviceCombo.depthStencilFormatList) - 1 do
        begin
          fmt := pDeviceCombo.depthStencilFormatList[ifmt];

          AddDepthStencilBufferFormat(fmt);
        end;

        pDepthStencilComboBox.SetSelectedByData(ULongToPtr(g_DeviceSettings.pp.AutoDepthStencilFormat));
      end else
      begin
        if not pDepthStencilComboBox.ContainsItem('(not used)') then
          pDepthStencilComboBox.AddItem('(not used)', nil);
      end;

      Result := OnDepthStencilBufferFormatChanged;
      if FAILED(Result) then Exit;

      pVertexProcessingComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_VERTEX_PROCESSING);
      pVertexProcessingComboBox.RemoveAllItems;

      // Add valid vertex processing types
      if bAllowSoftwareVP then
        AddVertexProcessingType(D3DCREATE_SOFTWARE_VERTEXPROCESSING);

      if bAllowHardwareVP and (pDeviceInfo.Caps.DevCaps and D3DDEVCAPS_HWTRANSFORMANDLIGHT <> 0) then
        AddVertexProcessingType(D3DCREATE_HARDWARE_VERTEXPROCESSING);

      if bAllowPureHardwareVP and (pDeviceInfo.Caps.DevCaps and D3DDEVCAPS_PUREDEVICE <> 0) then
        AddVertexProcessingType(D3DCREATE_PUREDEVICE);

      if bAllowMixedVP and (pDeviceInfo.Caps.DevCaps and D3DDEVCAPS_HWTRANSFORMANDLIGHT <> 0) then
        AddVertexProcessingType(D3DCREATE_MIXED_VERTEXPROCESSING);

      if (g_DeviceSettings.BehaviorFlags and D3DCREATE_PUREDEVICE <> 0) then
        pVertexProcessingComboBox.SetSelectedByData(ULongToPtr(D3DCREATE_PUREDEVICE))
      else if (g_DeviceSettings.BehaviorFlags and D3DCREATE_SOFTWARE_VERTEXPROCESSING <> 0) then
        pVertexProcessingComboBox.SetSelectedByData(ULongToPtr(D3DCREATE_SOFTWARE_VERTEXPROCESSING))
      else if (g_DeviceSettings.BehaviorFlags and D3DCREATE_HARDWARE_VERTEXPROCESSING <> 0) then
        pVertexProcessingComboBox.SetSelectedByData(ULongToPtr(D3DCREATE_HARDWARE_VERTEXPROCESSING))
      else if (g_DeviceSettings.BehaviorFlags and D3DCREATE_MIXED_VERTEXPROCESSING <> 0) then
        pVertexProcessingComboBox.SetSelectedByData(ULongToPtr(D3DCREATE_MIXED_VERTEXPROCESSING));

      Result := OnVertexProcessingChanged;
      if FAILED(Result) then Exit;

      pPresentIntervalComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_PRESENT_INTERVAL);
      pPresentIntervalComboBox.RemoveAllItems;
      pPresentIntervalComboBox.AddItem('On', ULongToPtr(D3DPRESENT_INTERVAL_DEFAULT));
      pPresentIntervalComboBox.AddItem('Off', ULongToPtr(D3DPRESENT_INTERVAL_IMMEDIATE));

      pPresentIntervalComboBox.SetSelectedByData(ULongToPtr(g_DeviceSettings.pp.PresentationInterval));

      Result := OnPresentIntervalChanged;
      if FAILED(Result) then Exit;
    end;
  end;

  Result:= S_OK;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnDepthStencilBufferFormatChanged: HRESULT;
var
  depthStencilBufferFormat: TD3DFormat;
  pDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;
  pMultisampleTypeCombo: CDXUTComboBox;
  ims: Integer;
  msType: TD3DMultiSampleType;
  bConflictFound: Boolean;
  iConf: Integer;
  DSMSConf: TD3DEnumDSMSConflict;
  pMultisampleQualityCombo: CDXUTComboBox;
begin
  depthStencilBufferFormat := GetSelectedDepthStencilBufferFormat;

  if g_DeviceSettings.pp.EnableAutoDepthStencil then
    g_DeviceSettings.pp.AutoDepthStencilFormat := depthStencilBufferFormat;

  pDeviceSettingsCombo := GetCurrentDeviceSettingsCombo;
  if (pDeviceSettingsCombo = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  pMultisampleTypeCombo := m_Dialog.GetComboBox( DXUTSETTINGSDLG_MULTISAMPLE_TYPE);
  pMultisampleTypeCombo.RemoveAllItems;

  for ims:= 0 to Length(pDeviceSettingsCombo.multiSampleTypeList) - 1 do
  begin
    msType := pDeviceSettingsCombo.multiSampleTypeList[ims];

    bConflictFound := False;
    for iConf := 0 to Length(pDeviceSettingsCombo.DSMSConflictList) - 1 do
    begin
      DSMSConf := pDeviceSettingsCombo.DSMSConflictList[iConf];
      if (DSMSConf.DSFormat = depthStencilBufferFormat) and
         (DSMSConf.MSType = msType) then
      begin
        bConflictFound := True;
        Break;
      end;
    end;

    if not bConflictFound then AddMultisampleType(msType);
  end;

  pMultisampleQualityCombo := m_Dialog.GetComboBox(DXUTSETTINGSDLG_MULTISAMPLE_TYPE);
  pMultisampleQualityCombo.SetSelectedByData(ULongToPtr(g_DeviceSettings.pp.MultiSampleType));

  Result := OnMultisampleTypeChanged;
  if FAILED(Result) then Exit;

  Result:= S_OK;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnMultisampleTypeChanged: HRESULT;
var
  multisampleType: TD3DMultiSampleType;
  pDeviceSettingsCombo: PD3DEnumDeviceSettingsCombo;
  dwMaxQuality: DWORD;
  iType: Integer;
  msType: TD3DMultiSampleType;
  pMultisampleQualityCombo: CDXUTComboBox;
  iQuality: Integer;
begin
  multisampleType := GetSelectedMultisampleType;
  g_DeviceSettings.pp.MultiSampleType := multisampleType;

  pDeviceSettingsCombo := GetCurrentDeviceSettingsCombo;
  if (pDeviceSettingsCombo = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  dwMaxQuality := 0;
  for iType := 0 to Length(pDeviceSettingsCombo.multiSampleTypeList) - 1 do
  begin
    msType := pDeviceSettingsCombo.multiSampleTypeList[iType];
    if (msType = multisampleType) then
    begin
      dwMaxQuality := pDeviceSettingsCombo.multiSampleQualityList[iType];
      Break;
    end;
  end;

  // DXUTSETTINGSDLG_MULTISAMPLE_QUALITY
  pMultisampleQualityCombo := m_Dialog.GetComboBox( DXUTSETTINGSDLG_MULTISAMPLE_QUALITY);
  pMultisampleQualityCombo.RemoveAllItems;

  for iQuality := 0 to dwMaxQuality - 1 do AddMultisampleQuality(iQuality);

  pMultisampleQualityCombo.SetSelectedByData(ULongToPtr(g_DeviceSettings.pp.MultiSampleQuality));

  Result := OnMultisampleQualityChanged;
  if FAILED(Result) then Exit;

  Result:= S_OK;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnMultisampleQualityChanged: HRESULT;
begin
  g_DeviceSettings.pp.MultiSampleQuality := GetSelectedMultisampleQuality;
  Result:= S_OK;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnVertexProcessingChanged: HRESULT;
var
  dwBehavior: DWORD;
  dwNewFlags: DWORD;
begin
  dwBehavior := g_DeviceSettings.BehaviorFlags;

  // Clear vertex processing flags
  dwBehavior := dwBehavior and not D3DCREATE_HARDWARE_VERTEXPROCESSING;
  dwBehavior := dwBehavior and not D3DCREATE_SOFTWARE_VERTEXPROCESSING;
  dwBehavior := dwBehavior and not D3DCREATE_MIXED_VERTEXPROCESSING;
  dwBehavior := dwBehavior and not D3DCREATE_PUREDEVICE;

  // Determine new flags
  dwNewFlags := GetSelectedVertexProcessingType;
  if (dwNewFlags and D3DCREATE_PUREDEVICE <> 0)
  then dwNewFlags := dwNewFlags or D3DCREATE_HARDWARE_VERTEXPROCESSING;

  // Make changes
  g_DeviceSettings.BehaviorFlags := dwBehavior or dwNewFlags;

  Result:= S_OK;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnPresentIntervalChanged: HRESULT;
begin
  g_DeviceSettings.pp.PresentationInterval := GetSelectedPresentInterval;
  Result:= S_OK;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.OnDeviceClipChanged: HRESULT;
begin
  if IsDeviceClip
  then g_DeviceSettings.pp.Flags := g_DeviceSettings.pp.Flags or D3DPRESENTFLAG_DEVICECLIP
  else g_DeviceSettings.pp.Flags := g_DeviceSettings.pp.Flags and not D3DPRESENTFLAG_DEVICECLIP;

  Result:= S_OK;
end;


//-------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.AddAdapter(const strDescription: PWideChar; iAdapter: LongWord);
var
  pComboBox: CDXUTComboBox;
begin
  pComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_ADAPTER);

  if not pComboBox.ContainsItem(strDescription) then
    pComboBox.AddItem(strDescription, ULongToPtr(iAdapter));
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.GetSelectedAdapter: LongWord;
begin
  Result:= PtrToUlong(m_Dialog.GetComboBox(DXUTSETTINGSDLG_ADAPTER).GetSelectedData);
end;


//-------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.AddDeviceType(devType: TD3DDevType);
begin
  with m_Dialog.GetComboBox(DXUTSETTINGSDLG_DEVICE_TYPE) do
  begin
    if not ContainsItem(DXUTD3DDeviceTypeToString(devType)) then
      AddItem(DXUTD3DDeviceTypeToString(devType), ULongToPtr(devType));
  end;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.GetSelectedDeviceType: TD3DDevType;
begin
  Result:= TD3DDevType(PtrToUlong(m_Dialog.GetComboBox(DXUTSETTINGSDLG_DEVICE_TYPE).GetSelectedData));
end;


//-------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.SetWindowed(bWindowed: Boolean);
begin
  m_Dialog.GetRadioButton(DXUTSETTINGSDLG_WINDOWED).Checked:= bWindowed;
  m_Dialog.GetRadioButton(DXUTSETTINGSDLG_FULLSCREEN).Checked:= not bWindowed;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.IsWindowed: Boolean;
begin
  Result:= m_Dialog.GetRadioButton(DXUTSETTINGSDLG_WINDOWED).Checked;
end;


//-------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.AddAdapterFormat(format: TD3DFormat);
begin
  with m_Dialog.GetComboBox(DXUTSETTINGSDLG_ADAPTER_FORMAT) do
    if not ContainsItem(DXUTD3DFormatToString(format, True)) then
      AddItem(DXUTD3DFormatToString(format, True), ULongToPtr(format));
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.GetSelectedAdapterFormat: TD3DFormat;
begin
  Result:= TD3DFormat(PtrToUlong(m_Dialog.GetComboBox(DXUTSETTINGSDLG_ADAPTER_FORMAT).GetSelectedData));
end;


//-------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.AddResolution(dwWidth, dwHeight: DWORD);
var
  pComboBox: CDXUTComboBox;
  dwResolutionData: DWORD;
  strResolution: array[0..49] of WideChar;
begin
  pComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_RESOLUTION);

  dwResolutionData := MAKELONG(dwWidth, dwHeight);
  StringCchFormat(strResolution, 50, '%d by %d'#0, [dwWidth, dwHeight]);

  if not pComboBox.ContainsItem(strResolution) then
    pComboBox.AddItem(strResolution, ULongToPtr(dwResolutionData));
end;


//-------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.GetSelectedResolution(out pdwWidth, pdwHeight: DWORD);
var
  pComboBox: CDXUTComboBox;
  dwResolution: DWORD;
begin
  pComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_RESOLUTION);

  dwResolution := PtrToUlong(pComboBox.GetSelectedData);

  pdwWidth := LOWORD(dwResolution);
  pdwHeight := HIWORD(dwResolution);
end;


//-------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.AddRefreshRate(dwRate: DWORD);
var
  pComboBox: CDXUTComboBox;
  strRefreshRate: array[0..49] of WideChar;
begin
  pComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_REFRESH_RATE);

  if (dwRate = 0)
  then StringCchCopy(strRefreshRate, 50, 'Default Rate')
  else StringCchFormat(strRefreshRate, 50, '%d Hz'#0, [dwRate]);

  strRefreshRate[49] := #0;

  if not pComboBox.ContainsItem(strRefreshRate) then
    pComboBox.AddItem(strRefreshRate, ULongToPtr(dwRate));
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.GetSelectedRefreshRate: DWORD;
begin
  Result:= PtrToUlong(m_Dialog.GetComboBox(DXUTSETTINGSDLG_REFRESH_RATE).GetSelectedData);
end;


//-------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.AddBackBufferFormat(format: TD3DFormat);
begin
  with m_Dialog.GetComboBox(DXUTSETTINGSDLG_BACK_BUFFER_FORMAT) do
    if not ContainsItem(DXUTD3DFormatToString(format, True)) then 
      AddItem(DXUTD3DFormatToString(format, True), ULongToPtr(format ));
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.GetSelectedBackBufferFormat: TD3DFormat;
begin
  Result:= TD3DFormat(PtrToUlong(m_Dialog.GetComboBox(DXUTSETTINGSDLG_BACK_BUFFER_FORMAT).GetSelectedData));
end;


//-------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.AddDepthStencilBufferFormat(format: TD3DFormat);
begin
  with m_Dialog.GetComboBox(DXUTSETTINGSDLG_DEPTH_STENCIL) do
    if not ContainsItem(DXUTD3DFormatToString(format, True)) then
      AddItem(DXUTD3DFormatToString(format, True), ULongToPtr(format));
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.GetSelectedDepthStencilBufferFormat: TD3DFormat;
begin
  Result:= TD3DFormat(PtrToUlong(m_Dialog.GetComboBox(DXUTSETTINGSDLG_DEPTH_STENCIL).GetSelectedData));
end;


//-------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.AddMultisampleType(_type: TD3DMultiSampleType);
begin
  with m_Dialog.GetComboBox(DXUTSETTINGSDLG_MULTISAMPLE_TYPE) do
    if not ContainsItem(DXUTMultisampleTypeToString(_type)) then
    AddItem(DXUTMultisampleTypeToString(_type), ULongToPtr(_type));
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.GetSelectedMultisampleType: TD3DMultiSampleType;
begin
  Result:= TD3DMultiSampleType(PtrToUlong(m_Dialog.GetComboBox(DXUTSETTINGSDLG_MULTISAMPLE_TYPE).GetSelectedData));
end;


//-------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.AddMultisampleQuality(dwQuality: DWORD);
var
  pComboBox: CDXUTComboBox;
  strQuality: array[0..49] of WideChar;
begin
  pComboBox := m_Dialog.GetComboBox(DXUTSETTINGSDLG_MULTISAMPLE_QUALITY);

  StringCchFormat(strQuality, 50, '%d', [dwQuality]);

  if not pComboBox.ContainsItem(strQuality) then
    pComboBox.AddItem(strQuality, ULongToPtr(dwQuality));
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.GetSelectedMultisampleQuality: DWORD;
begin
  Result:= PtrToUlong(m_Dialog.GetComboBox(DXUTSETTINGSDLG_MULTISAMPLE_QUALITY).GetSelectedData);
end;


//-------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.AddVertexProcessingType(dwType: DWORD);
begin
  with m_Dialog.GetComboBox(DXUTSETTINGSDLG_VERTEX_PROCESSING) do
    if not ContainsItem(DXUTVertexProcessingTypeToString(dwType)) then
      AddItem(DXUTVertexProcessingTypeToString(dwType), ULongToPtr(dwType));
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.GetSelectedVertexProcessingType: DWORD;
begin
  Result:= PtrToUlong(m_Dialog.GetComboBox(DXUTSETTINGSDLG_VERTEX_PROCESSING).GetSelectedData);
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.GetSelectedPresentInterval: DWORD;
begin
  Result:= PtrToUlong(m_Dialog.GetComboBox(DXUTSETTINGSDLG_PRESENT_INTERVAL).GetSelectedData);
end;


//-------------------------------------------------------------------------------------
procedure CD3DSettingsDlg.SetDeviceClip(bDeviceClip: Boolean);
begin
  m_Dialog.GetCheckBox(DXUTSETTINGSDLG_DEVICECLIP).Checked:= bDeviceClip;
end;


//-------------------------------------------------------------------------------------
function CD3DSettingsDlg.IsDeviceClip: Boolean;
begin
  Result:= m_Dialog.GetCheckBox(DXUTSETTINGSDLG_DEVICECLIP).Checked;
end;


//--------------------------------------------------------------------------------------
// Returns the string for the given D3DDEVTYPE.
//--------------------------------------------------------------------------------------
function DXUTD3DDeviceTypeToString(devType: TD3DDevType): PWideChar;
begin
  case devType of
    D3DDEVTYPE_HAL: Result:= 'D3DDEVTYPE_HAL';
    D3DDEVTYPE_SW:  Result:= 'D3DDEVTYPE_SW';
    D3DDEVTYPE_REF: Result:= 'D3DDEVTYPE_REF';
    else            Result:= 'Unknown devType';
  end;
end;


//--------------------------------------------------------------------------------------
// Returns the string for the given D3DMULTISAMPLE_TYPE.
//--------------------------------------------------------------------------------------
function DXUTMultisampleTypeToString(MultiSampleType: TD3DMultiSampleType): PWideChar;
begin
  case MultiSampleType of
    D3DMULTISAMPLE_NONE:       Result:= 'D3DMULTISAMPLE_NONE';
    D3DMULTISAMPLE_NONMASKABLE: Result:= 'D3DMULTISAMPLE_NONMASKABLE';
    D3DMULTISAMPLE_2_SAMPLES:  Result:= 'D3DMULTISAMPLE_2_SAMPLES';
    D3DMULTISAMPLE_3_SAMPLES:  Result:= 'D3DMULTISAMPLE_3_SAMPLES';
    D3DMULTISAMPLE_4_SAMPLES:  Result:= 'D3DMULTISAMPLE_4_SAMPLES';
    D3DMULTISAMPLE_5_SAMPLES:  Result:= 'D3DMULTISAMPLE_5_SAMPLES';
    D3DMULTISAMPLE_6_SAMPLES:  Result:= 'D3DMULTISAMPLE_6_SAMPLES';
    D3DMULTISAMPLE_7_SAMPLES:  Result:= 'D3DMULTISAMPLE_7_SAMPLES';
    D3DMULTISAMPLE_8_SAMPLES:  Result:= 'D3DMULTISAMPLE_8_SAMPLES';
    D3DMULTISAMPLE_9_SAMPLES:  Result:= 'D3DMULTISAMPLE_9_SAMPLES';
    D3DMULTISAMPLE_10_SAMPLES: Result:= 'D3DMULTISAMPLE_10_SAMPLES';
    D3DMULTISAMPLE_11_SAMPLES: Result:= 'D3DMULTISAMPLE_11_SAMPLES';
    D3DMULTISAMPLE_12_SAMPLES: Result:= 'D3DMULTISAMPLE_12_SAMPLES';
    D3DMULTISAMPLE_13_SAMPLES: Result:= 'D3DMULTISAMPLE_13_SAMPLES';
    D3DMULTISAMPLE_14_SAMPLES: Result:= 'D3DMULTISAMPLE_14_SAMPLES';
    D3DMULTISAMPLE_15_SAMPLES: Result:= 'D3DMULTISAMPLE_15_SAMPLES';
    D3DMULTISAMPLE_16_SAMPLES: Result:= 'D3DMULTISAMPLE_16_SAMPLES';
   else                        Result:= 'Unknown Multisample Type';
  end;
end;


//--------------------------------------------------------------------------------------
// Returns the string for the given vertex processing type
//--------------------------------------------------------------------------------------
function DXUTVertexProcessingTypeToString(vpt: DWORD): PWideChar;
begin
  case vpt of
    D3DCREATE_SOFTWARE_VERTEXPROCESSING: Result:= 'Software vertex processing';
    D3DCREATE_MIXED_VERTEXPROCESSING:    Result:= 'Mixed vertex processing';
    D3DCREATE_HARDWARE_VERTEXPROCESSING: Result:= 'Hardware vertex processing';
    D3DCREATE_PUREDEVICE:                Result:= 'Pure hardware vertex processing';
   else                                  Result:= 'Unknown vertex processing type';
  end;
end;


//--------------------------------------------------------------------------------------
// Returns the string for the given present interval.
//--------------------------------------------------------------------------------------
function DXUTPresentIntervalToString(pi: LongWord): PWideChar;
begin
  case pi of
    D3DPRESENT_INTERVAL_IMMEDIATE: Result:= 'D3DPRESENT_INTERVAL_IMMEDIATE';
    D3DPRESENT_INTERVAL_DEFAULT:   Result:= 'D3DPRESENT_INTERVAL_DEFAULT';
    D3DPRESENT_INTERVAL_ONE:       Result:= 'D3DPRESENT_INTERVAL_ONE';
    D3DPRESENT_INTERVAL_TWO:       Result:= 'D3DPRESENT_INTERVAL_TWO';
    D3DPRESENT_INTERVAL_THREE:     Result:= 'D3DPRESENT_INTERVAL_THREE';
    D3DPRESENT_INTERVAL_FOUR:      Result:= 'D3DPRESENT_INTERVAL_FOUR';
   else                            Result:= 'Unknown PresentInterval';
  end;
end;

end.

