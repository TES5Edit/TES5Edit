(*----------------------------------------------------------------------------*
 *                                                                            *
 *  Template application - Direct3D9 in VCL                                   *
 *                                                                            *
 *  This template provides simple VCL Delphi application that renders D3D     *
 *  objects in VCL TPanel in windowed mode and can also run render D3D (in    *
 *  special window) then running in fullscreen mode.                          *
 *  Template even allows to move/rotate 'The Teapot' with mouse.              *
 *                                                                            *
 *  Template was written to provide compact starting point then creating      *
 *  Direct3D applications with Delphi (using VCL library)                     *
 *                                                                            *
 *  Copyright (c) 2005 by Alexey Barkovoy                                     *
 *  E-Mail: clootie@clootie.ru                                                *
 *                                                                            *
 *  Modified: 29-Aug-2005                                                     *
 *                                                                            *
 *  Latest version can be downloaded from:                                    *
 *     http://www.clootie.ru                                                *
 *----------------------------------------------------------------------------*)

{$I DirectX.inc}

unit RenderUnit;

interface

uses
  Windows, Messages, SysUtils,
  DXTypes, Direct3D9, D3DX9,
  DXUT, DXUTcore, DXUTSettingsDlg, DXUTenum, DXUTmisc, DXUTgui;



//--------------------------------------------------------------------------------------
var
  fTeapot: ID3DXMesh;
  m_ArcBall: CD3DArcBall;   // Mouse rotation utility

//--------------------------------------------------------------------------------------
// Forward declarations
//--------------------------------------------------------------------------------------
function IsDeviceAcceptable(const pCaps: TD3DCaps9; AdapterFormat, BackBufferFormat: TD3DFormat; bWindowed: Boolean; pUserContext: Pointer): Boolean; stdcall;
function ModifyDeviceSettings(var pDeviceSettings: TDXUTDeviceSettings; const pCaps: TD3DCaps9; pUserContext: Pointer): Boolean; stdcall;
function OnCreateDevice(const pd3dDevice: IDirect3DDevice9; const pBackBufferSurfaceDesc: TD3DSurfaceDesc; pUserContext: Pointer): HRESULT; stdcall;
function OnResetDevice(const pd3dDevice: IDirect3DDevice9; const pBackBufferSurfaceDesc: TD3DSurfaceDesc; pUserContext: Pointer): HRESULT; stdcall;
procedure OnFrameMove(const pd3dDevice: IDirect3DDevice9; fTime: Double; fElapsedTime: Single; pUserContext: Pointer); stdcall;
procedure OnFrameRender(const pd3dDevice: IDirect3DDevice9; fTime: Double; fElapsedTime: Single; pUserContext: Pointer); stdcall;
function MsgProc(hWnd: HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM; out pbNoFurtherProcessing: Boolean; pUserContext: Pointer): LRESULT; stdcall;
procedure OnLostDevice(pUserContext: Pointer); stdcall;
procedure OnDestroyDevice(pUserContext: Pointer); stdcall;

procedure CreateCustomDXUTobjects;
procedure DestroyCustomDXUTobjects;

implementation


//--------------------------------------------------------------------------------------
// Called during device initialization, this code checks the device for some
// minimum set of capabilities, and rejects those that don't pass by returning false.
//--------------------------------------------------------------------------------------
function IsDeviceAcceptable(const pCaps: TD3DCaps9; AdapterFormat, BackBufferFormat: TD3DFormat; bWindowed: Boolean; pUserContext: Pointer): Boolean; stdcall;
begin
  Result:= False;

  // Skip backbuffer formats that don't support alpha blending
  if FAILED(DXUTGetD3DObject.CheckDeviceFormat(pCaps.AdapterOrdinal, pCaps.DeviceType,
                   AdapterFormat, D3DUSAGE_QUERY_POSTPIXELSHADER_BLENDING,
                   D3DRTYPE_TEXTURE, BackBufferFormat))
  then Exit;

  Result:= True;
end;


//--------------------------------------------------------------------------------------
// Before a device is created, modify the device settings as needed
//--------------------------------------------------------------------------------------
function ModifyDeviceSettings(var pDeviceSettings: TDXUTDeviceSettings; const pCaps: TD3DCaps9; pUserContext: Pointer): Boolean; stdcall;
begin
  Result:= True;
end;


//--------------------------------------------------------------------------------------
// Create any D3DPOOL_MANAGED resources here 
//--------------------------------------------------------------------------------------
function OnCreateDevice(const pd3dDevice: IDirect3DDevice9; const pBackBufferSurfaceDesc: TD3DSurfaceDesc; pUserContext: Pointer): HRESULT; stdcall;
begin
  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Create any D3DPOOL_DEFAULT resources here 
//--------------------------------------------------------------------------------------
function OnResetDevice(const pd3dDevice: IDirect3DDevice9; const pBackBufferSurfaceDesc: TD3DSurfaceDesc; pUserContext: Pointer): HRESULT; stdcall;
var
  fAspect: Single;
  m_matProjection: TD3DXMatrix;
  matView: TD3DXMatrix;
  vEyePt, vLookatPt, vUpVec: TD3DXVector3;
  Light: TD3DLight9;
  Mtrl: TD3DMaterial9;
begin
  D3DXCreateTeapot(pd3dDevice, fTeapot, nil);
  m_ArcBall.SetWindow(pBackBufferSurfaceDesc.Width, pBackBufferSurfaceDesc.Height);

  // Update projection matrix based on window dimensions
  fAspect := pBackBufferSurfaceDesc.Width / pBackBufferSurfaceDesc.Height;
  D3DXMatrixPerspectiveFovLH(m_matProjection, D3DX_PI / 4, fAspect, 1.0, 1000.0);
  pd3dDevice.SetTransform(D3DTS_PROJECTION, m_matProjection);

  vEyePt    := D3DXVector3(0.0, 1.0, -5.0);
  vLookatPt := D3DXVector3(0.0, 0.0,  0.0);
  vUpVec    := D3DXVector3(0.0, 1.0,  0.0);
  D3DXMatrixLookAtLH(matView, vEyePt, vLookatPt, vUpVec);
  pd3dDevice.SetTransform(D3DTS_VIEW, matView);

  ZeroMemory(@Light, SizeOf(Light));
  Light._Type:= D3DLIGHT_DIRECTIONAL;
  Light.Direction:= D3DXVector3(1, -1, 1);
  Light.Diffuse:= D3DXColor(0, 1, 0.5, 0);
  pd3dDevice.SetLight(0, Light);
  pd3dDevice.LightEnable(0, True);

  ZeroMemory(@Mtrl, SizeOf(Mtrl));
  Mtrl.Diffuse:= D3DXColor(1, 0, 1, 1);
  pd3dDevice.SetMaterial(Mtrl);

  pd3dDevice.SetRenderState(D3DRS_AMBIENT, $60606060);

  pd3dDevice.SetRenderState(D3DRS_LIGHTING, iTrue);
  pd3dDevice.SetRenderState(D3DRS_ZENABLE, iTrue);

  pd3dDevice.SetTextureStageState(0, D3DTSS_COLOROP,   D3DTOP_MODULATE);
  pd3dDevice.SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE);
  pd3dDevice.SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_DIFFUSE);
  pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAOP,   D3DTOP_DISABLE);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Handle updates to the scene
//--------------------------------------------------------------------------------------
procedure OnFrameMove(const pd3dDevice: IDirect3DDevice9; fTime: Double; fElapsedTime: Single; pUserContext: Pointer); stdcall;
begin
end;


//--------------------------------------------------------------------------------------
// Render the scene 
//--------------------------------------------------------------------------------------
procedure OnFrameRender(const pd3dDevice: IDirect3DDevice9; fTime: Double; fElapsedTime: Single; pUserContext: Pointer); stdcall;
begin
  // Clear the render target and the zbuffer
  V(pd3dDevice.Clear(0, nil, D3DCLEAR_TARGET or D3DCLEAR_ZBUFFER, D3DCOLOR_ARGB(0, 45, 50, 170), 1.0, 0));

  // Render the scene
  if SUCCEEDED(pd3dDevice.BeginScene) then
  begin
    fTeapot.DrawSubset(0);
    
    V(pd3dDevice.EndScene);
  end;
end;


//--------------------------------------------------------------------------------------
// Handle messages to the application 
//--------------------------------------------------------------------------------------
function MsgProc(hWnd: HWND; uMsg: LongWord; wParam: WPARAM; lParam: LPARAM; out pbNoFurtherProcessing: Boolean; pUserContext: Pointer): LRESULT; stdcall;
begin
  if Assigned(m_ArcBall) then
    m_ArcBall.HandleMessages(hWnd, uMsg, wParam, lParam);
    
  Result:= 0;
end;


//--------------------------------------------------------------------------------------
// Release resources created in the OnResetDevice callback here 
//--------------------------------------------------------------------------------------
procedure OnLostDevice; stdcall;
begin
  fTeapot:= nil;
end;


//--------------------------------------------------------------------------------------
// Release resources created in the OnCreateDevice callback here
//--------------------------------------------------------------------------------------
procedure OnDestroyDevice; stdcall;
begin
end;


procedure CreateCustomDXUTobjects;
begin
  m_ArcBall:= CD3DArcBall.Create;
end;

procedure DestroyCustomDXUTobjects;
begin
  FreeAndNil(m_ArcBall);
end;

end.

