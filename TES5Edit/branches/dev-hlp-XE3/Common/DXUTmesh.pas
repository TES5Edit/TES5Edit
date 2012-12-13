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
 *  $Id: DXUTmesh.pas,v 1.13 2006/04/23 19:38:09 clootie Exp $
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

//-----------------------------------------------------------------------------
// File: DXUTMesh.h
//
// Desc: Support code for loading DirectX .X files.
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//-----------------------------------------------------------------------------

{$I DirectX.inc}

unit DXUTmesh;

interface

uses
  Windows, Direct3D9, DXTypes, D3DX9;

type
  PD3DMaterialArray = ^TD3DMaterialArray;
  TD3DMaterialArray = array [0..MaxInt div SizeOf(TD3DMaterial9)-1] of TD3DMaterial9;

  PD3DXMaterialArray = ^TD3DXMaterialArray;
  TD3DXMaterialArray = array [0..MaxInt div SizeOf(TD3DXMaterial)-1] of TD3DXMaterial;

  PAIDirect3DBaseTexture9 = ^AIDirect3DBaseTexture9;
  AIDirect3DBaseTexture9 = array[0..MaxInt div SizeOf(IDirect3DBaseTexture9)-1] of IDirect3DBaseTexture9;

  //-----------------------------------------------------------------------------
  // Name: class CDXUTMesh
  // Desc: Class for loading and rendering file-based meshes
  //-----------------------------------------------------------------------------
  CDXUTMesh = class
  private
    m_pMesh: ID3DXMesh; // Managed mesh

  public
    m_strName: array[0..511] of WideChar;
    // m_pMesh: ID3DXMesh; // Managed mesh

    // Cache of data in m_pMesh for easy access
    m_pVB: IDirect3DVertexBuffer9;
    m_pIB: IDirect3DIndexBuffer9;
    m_pDecl: IDirect3DVertexDeclaration9;
    m_dwNumVertices: DWORD;
    m_dwNumFaces: DWORD;
    m_dwBytesPerVertex: DWORD;

    m_dwNumMaterials: Integer;            // Materials for the mesh
    m_pMaterials: PD3DMaterialArray;
    m_strMaterials: array of String; // CHAR (*m_strMaterials)[MAX_PATH];
    m_pTextures: PAIDirect3DBaseTexture9;
    m_bUseMaterials: Boolean;

  public
    // Rendering
    function Render(pd3dDevice: IDirect3DDevice9;
                    bDrawOpaqueSubsets: Boolean = True;
                    bDrawAlphaSubsets: Boolean = True): HRESULT; overload;
    function Render(const pEffect: ID3DXEffect;
                    hTexture: TD3DXHandle = nil;
                    hDiffuse: TD3DXHandle = nil;
                    hAmbient: TD3DXHandle = nil;
                    hSpecular: TD3DXHandle = nil;
                    hEmissive: TD3DXHandle = nil;
                    hPower: TD3DXHandle = nil;
                    bDrawOpaqueSubsets: Boolean = True;
                    bDrawAlphaSubsets: Boolean = True): HRESULT; overload;

    // Mesh access
    property Mesh: ID3DXMesh read m_pMesh;

    // Rendering options
    procedure UseMeshMaterials(bFlag: Boolean); { m_bUseMaterials = bFlag; }
    function SetFVF(pd3dDevice: IDirect3DDevice9; dwFVF: DWORD): HRESULT;
    function SetVertexDecl(const pd3dDevice: IDirect3DDevice9; const pDecl: PD3DVertexElement9;
                           bAutoComputeNormals: Boolean = True; bAutoComputeTangents: Boolean = True;
                           bSplitVertexForOptimalTangents: Boolean = False): HRESULT;

    // Initializing
    function RestoreDeviceObjects(pd3dDevice: IDirect3DDevice9): HRESULT;
    function InvalidateDeviceObjects: HRESULT;

    // Creation/destruction
    function CreateMesh(const pd3dDevice: IDirect3DDevice9; strFilename: PWideChar): HRESULT; overload;
    {$IFNDEF FPC}
    function CreateMesh(const pd3dDevice: IDirect3DDevice9; strFilename: WideString): HRESULT; overload;
    {$ENDIF}
    function CreateMesh(const pd3dDevice: IDirect3DDevice9; pFileData: ID3DXFileData): HRESULT; overload;
    function CreateMesh(const pd3dDevice: IDirect3DDevice9; pInMesh: ID3DXMesh; pd3dxMaterials: PD3DXMaterial; dwMaterials: DWORD): HRESULT; overload;
    function CreateMaterials(strPath: PWideChar; const pd3dDevice: IDirect3DDevice9; d3dxMtrls: PD3DXMaterial; dwNumMaterials: DWORD): HRESULT;
    function DestroyMesh: HRESULT;

    constructor Create(strName: WideString = 'CDXUTMeshFile_Mesh');
    destructor Destroy; override;
  end;


  TEnumMeshCBProc = function(mesh: CDXUTMesh; data: Pointer): Boolean;


  //-----------------------------------------------------------------------------
  // Name: class CDXUTMeshFrame
  // Desc: Class for loading and rendering file-based meshes
  //-----------------------------------------------------------------------------
  CDXUTMeshFrame = class
  public
    m_strName: array[0..511] of WideChar;
    m_mat: TD3DXMatrix;
    m_pMesh: CDXUTMesh;

    m_pNext: CDXUTMeshFrame;
    m_pChild: CDXUTMeshFrame;

  public
    // Matrix access
    procedure SetMatrix(const pmat: TD3DXMatrix); { m_mat = *pmat; }
    function GetMatrix: PD3DXMatrix;              { return &m_mat; } 

    function FindMesh(strMeshName: PWideChar): CDXUTMesh;
    function FindFrame(strFrameName: PWideChar): CDXUTMeshFrame;
    function EnumMeshes(EnumMeshCB: TEnumMeshCBProc; pContext: Pointer): Boolean;

    function DestroyMesh: HRESULT;
    function RestoreDeviceObjects(pd3dDevice: IDirect3DDevice9): HRESULT;
    function InvalidateDeviceObjects: HRESULT;
    function Render(pd3dDevice: IDirect3DDevice9;
                    bDrawOpaqueSubsets: Boolean = True;
                    bDrawAlphaSubsets: Boolean = True;
                    pmatWorldMatrix: PD3DXMatrix = nil): HRESULT;

    constructor Create(strName: WideString = 'CDXUTMeshFile_Frame');
    destructor Destroy; override;

  end;




  //-----------------------------------------------------------------------------
  // Name: class CDXUTMeshFile
  // Desc: Class for loading and rendering file-based meshes
  //-----------------------------------------------------------------------------
  CDXUTMeshFile = class(CDXUTMeshFrame)
    function LoadMesh(pd3dDevice: IDirect3DDevice9; pFileData: ID3DXFileData;
                      pParentFrame: CDXUTMeshFrame): HRESULT;
    function LoadFrame(pd3dDevice: IDirect3DDevice9; pFileData: ID3DXFileData;
                       pParentFrame: CDXUTMeshFrame): HRESULT;
  public
    function CreateMesh(pd3dDevice: IDirect3DDevice9; strFilename: PWideChar): HRESULT;
    function CreateFromResource(pd3dDevice: IDirect3DDevice9; strResource, strType: PWideChar): HRESULT;
    // For pure devices, specify the world transform. If the world transform is not
    // specified on pure devices, this function will fail.
    function Render(pd3dDevice: IDirect3DDevice9; pmatWorldMatrix: PD3DXMatrix = nil): HRESULT;

    constructor Create; // CDXUTMeshFile() : CDXUTMeshFrame( L"CDXUTMeshFile_Root" ) {}
  end;



implementation

uses
  SysUtils, StrSafe, DXFile, DXUTcore, DXUTmisc;


//-----------------------------------------------------------------------------
// File: DXUTMesh.cpp
//
// Desc: Support code for loading DirectX .X files.
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//-----------------------------------------------------------------------------

{#include "dxstdafx.h"
#include <dxfile.h>
#include <rmxfguid.h>
#include <rmxftmpl.h>
#include "DXUTMesh.h"}

{CDXUTMesh}

//-----------------------------------------------------------------------------
constructor CDXUTMesh.Create(strName: WideString);
begin
  StringCchCopy(m_strName, 512, PWideChar(strName));
  m_pMesh              := nil;
  m_dwNumMaterials     := 0;
  m_pMaterials         := nil;
  m_pTextures          := nil;
  m_bUseMaterials      := True;
  m_pVB                := nil;
  m_pIB                := nil;
  m_pDecl              := nil;
  m_strMaterials       := nil;
end;


//-----------------------------------------------------------------------------
destructor CDXUTMesh.Destroy;
begin
  DestroyMesh;
  inherited;
end;



//-----------------------------------------------------------------------------
function CDXUTMesh.CreateMesh(const pd3dDevice: IDirect3DDevice9;
  strFilename: PWideChar): HRESULT; 
var
  strPath: array[0..MAX_PATH-1] of WideChar;
  pAdjacencyBuffer: ID3DXBuffer;
  pMtrlBuffer: ID3DXBuffer;
  pLastBSlash: PWideChar;
  d3dxMtrls: PD3DXMaterial;
  decl: TFVFDeclaration;
begin
  // Cleanup previous mesh if any
  DestroyMesh;

  // Find the path for the file, and convert it to ANSI (for the D3DX API)
  DXUTFindDXSDKMediaFile(strPath, SizeOf(strPath) div SizeOf(WideChar), strFilename);

  // Load the mesh
  Result := D3DXLoadMeshFromXW(@strPath, D3DXMESH_MANAGED, pd3dDevice,
                               @pAdjacencyBuffer, @pMtrlBuffer, nil,
                               @m_dwNumMaterials, m_pMesh);
  if FAILED(Result) then Exit;

  // Optimize the mesh for performance
  Result := m_pMesh.OptimizeInplace(
                D3DXMESHOPT_COMPACT or D3DXMESHOPT_ATTRSORT or D3DXMESHOPT_VERTEXCACHE,
                pAdjacencyBuffer.GetBufferPointer, nil, nil, nil);
  if FAILED(Result) then Exit;

  // Set strPath to the path of the mesh file
  pLastBSlash := WideStrRScan(strPath, '\');
  if (pLastBSlash <> nil) then (pLastBSlash+1)^:= #0
  else strPath[0]:= #0;

  d3dxMtrls := PD3DXMaterial(pMtrlBuffer.GetBufferPointer);
  Result := CreateMaterials(strPath, pd3dDevice, d3dxMtrls, m_dwNumMaterials);

  SAFE_RELEASE(pAdjacencyBuffer);
  SAFE_RELEASE(pMtrlBuffer);

  // Extract data from m_pMesh for easy access
  m_dwNumVertices    := m_pMesh.GetNumVertices;
  m_dwNumFaces       := m_pMesh.GetNumFaces;
  m_dwBytesPerVertex := m_pMesh.GetNumBytesPerVertex;
  m_pMesh.GetIndexBuffer(m_pIB);
  m_pMesh.GetVertexBuffer(m_pVB);
  m_pMesh.GetDeclaration(decl);
  pd3dDevice.CreateVertexDeclaration(@decl, m_pDecl);
end;


{$IFNDEF FPC}
function CDXUTMesh.CreateMesh(const pd3dDevice: IDirect3DDevice9; strFilename: WideString): HRESULT;
begin
  Result := CreateMesh(pd3dDevice, PWideChar(strFilename));
end;
{$ENDIF}


//-----------------------------------------------------------------------------
function CDXUTMesh.CreateMesh(const pd3dDevice: IDirect3DDevice9;
  pFileData: ID3DXFileData): HRESULT;
var
  pMtrlBuffer: ID3DXBuffer;
  pAdjacencyBuffer: ID3DXBuffer;
  d3dxMtrls: PD3DXMaterial;
  decl: TFVFDeclaration;
begin
  // Cleanup previous mesh if any
  DestroyMesh;

  // Load the mesh from the DXFILEDATA object
  Result := D3DXLoadMeshFromXof(pFileData, D3DXMESH_MANAGED, pd3dDevice,
                                @pAdjacencyBuffer, @pMtrlBuffer, nil,
                                @m_dwNumMaterials, m_pMesh);
  if FAILED(Result) then Exit;

  // Optimize the mesh for performance
  Result := m_pMesh.OptimizeInplace(
                D3DXMESHOPT_COMPACT or D3DXMESHOPT_ATTRSORT or D3DXMESHOPT_VERTEXCACHE,
                pAdjacencyBuffer.GetBufferPointer, nil, nil, nil);
  if FAILED(Result) then Exit;
  {
      SAFE_RELEASE( pAdjacencyBuffer );
      SAFE_RELEASE( pMtrlBuffer );
      return hr;
  }

  d3dxMtrls := PD3DXMaterial(pMtrlBuffer.GetBufferPointer);
  Result := CreateMaterials('', pd3dDevice, d3dxMtrls, m_dwNumMaterials);

  SAFE_RELEASE(pAdjacencyBuffer);
  SAFE_RELEASE(pMtrlBuffer);
  
  // Extract data from m_pMesh for easy access
  m_dwNumVertices    := m_pMesh.GetNumVertices;
  m_dwNumFaces       := m_pMesh.GetNumFaces;
  m_dwBytesPerVertex := m_pMesh.GetNumBytesPerVertex;
  m_pMesh.GetIndexBuffer(m_pIB);
  m_pMesh.GetVertexBuffer(m_pVB);
  m_pMesh.GetDeclaration(decl);
  pd3dDevice.CreateVertexDeclaration(@decl, m_pDecl);
end;


//-----------------------------------------------------------------------------
function CDXUTMesh.CreateMesh(const pd3dDevice: IDirect3DDevice9; pInMesh: ID3DXMesh;
  pd3dxMaterials: PD3DXMaterial; dwMaterials: DWORD): HRESULT;
var
  rgdwAdjacency: array of DWORD;
  decl: TFVFDeclaration; 
  dwOptions: DWORD;
  pTempMesh: ID3DXMesh;
begin
  // Cleanup previous mesh if any
  DestroyMesh;

  // Optimize the mesh for performance
  try
    SetLength(rgdwAdjacency, pInMesh.GetNumFaces * 3);
  except
    on EOutOfMemory do
    begin
      Result:= E_OUTOFMEMORY;
      Exit;
    end;
  end;
  pInMesh.GenerateAdjacency(1e-6, @rgdwAdjacency[0]);

  pInMesh.GetDeclaration(decl);

  dwOptions := pInMesh.GetOptions;
  dwOptions := dwOptions and not (D3DXMESH_32BIT or D3DXMESH_SYSTEMMEM or D3DXMESH_WRITEONLY);
  dwOptions := dwOptions or D3DXMESH_MANAGED;
  dwOptions := dwOptions or D3DXMESHOPT_COMPACT or D3DXMESHOPT_ATTRSORT or D3DXMESHOPT_VERTEXCACHE;

  if FAILED(pInMesh.Optimize(dwOptions, @rgdwAdjacency[0], nil, nil, nil, pTempMesh)) then
  begin
    rgdwAdjacency := nil;
    Result:= E_FAIL;
    Exit;
  end;

  rgdwAdjacency := nil;
  m_pMesh:= nil;
  m_pMesh := pTempMesh;

  Result := CreateMaterials('', pd3dDevice, pd3dxMaterials, dwMaterials);

  // Extract data from m_pMesh for easy access
  m_dwNumVertices    := m_pMesh.GetNumVertices;
  m_dwNumFaces       := m_pMesh.GetNumFaces;
  m_dwBytesPerVertex := m_pMesh.GetNumBytesPerVertex;
  m_pMesh.GetIndexBuffer(m_pIB);
  m_pMesh.GetVertexBuffer(m_pVB);
  m_pMesh.GetDeclaration(decl);
  pd3dDevice.CreateVertexDeclaration(@decl, m_pDecl);
end;


//-----------------------------------------------------------------------------
function CDXUTMesh.CreateMaterials(strPath: PWideChar; const pd3dDevice: IDirect3DDevice9;
  d3dxMtrls: PD3DXMaterial; dwNumMaterials: DWORD): HRESULT;
var
  i: Integer;
  strTexture: array[0..MAX_PATH-1] of WideChar;
  strTextureTemp: array[0..MAX_PATH-1] of WideChar;
  ImgInfo: TD3DXImageInfo;
  pTex: IDirect3DTexture9;
  pTexCube: IDirect3DCubeTexture9;
  pTexVol: IDirect3DVolumeTexture9;
begin
  // Get material info for the mesh
  // Get the array of materials out of the buffer
  m_dwNumMaterials := dwNumMaterials;
  if (d3dxMtrls <> nil) and (m_dwNumMaterials > 0) then
  begin
    // Allocate memory for the materials and textures
    try
      SetLength(m_strMaterials, m_dwNumMaterials);
      GetMem(m_pMaterials, m_dwNumMaterials * SizeOf(TD3DMaterial9));
      GetMem(m_pTextures,  m_dwNumMaterials * SizeOf(IDirect3DBaseTexture9));
      FillChar(m_pTextures^, m_dwNumMaterials * SizeOf(IDirect3DBaseTexture9), 0);
    except
      on EOutOfMemory do
      begin
        Result:= E_OUTOFMEMORY;
        Exit;
      end;
    end;

    // Copy each material and create its texture
    for i:= 0 to m_dwNumMaterials - 1 do
    begin
      // Copy the material
      m_pMaterials[i] := PD3DXMaterialArray(d3dxMtrls)[i].MatD3D;
      m_pTextures[i]  := nil;

      // Create a texture
      if (PD3DXMaterialArray(d3dxMtrls)[i].pTextureFilename <> nil) then
      begin
        // First attempt to look for texture in the same folder as the input folder.
        MultiByteToWideChar(CP_ACP, 0, PD3DXMaterialArray(d3dxMtrls)[i].pTextureFilename, -1, strTextureTemp, MAX_PATH );
        strTextureTemp[MAX_PATH-1] := #0;

        StringCchCopy(strTexture, MAX_PATH, strPath);
        StringCchCat(strTexture, MAX_PATH, strTextureTemp);

        // Inspect the texture file to determine the texture type.
        if FAILED(D3DXGetImageInfoFromFileW(@strTexture, ImgInfo)) then
        begin
          // Search the media folder
          if FAILED(DXUTFindDXSDKMediaFile(strTexture, MAX_PATH, strTextureTemp))
          then Continue;  // Can't find. Skip.

          D3DXGetImageInfoFromFileW(@strTexture, ImgInfo);
        end;

        // Call the appropriate loader according to the texture type.
        case  ImgInfo.ResourceType of
          D3DRTYPE_TEXTURE:
          begin
            if SUCCEEDED(D3DXCreateTextureFromFileW(pd3dDevice, strTexture, pTex)) then
            begin
              // Obtain the base texture interface
              m_pTextures[i] := pTex; // pTex->QueryInterface( IID_IDirect3DBaseTexture9, (LPVOID*)&m_pTextures[i] );
              // Release the specialized instance
              pTex:= nil;
            end;
          end;

          D3DRTYPE_CUBETEXTURE:
          begin
            if SUCCEEDED(D3DXCreateCubeTextureFromFileW(pd3dDevice, strTexture, pTexCube)) then
            begin
              // Obtain the base texture interface
              m_pTextures[i] := pTexCube; // pTex->QueryInterface( IID_IDirect3DBaseTexture9, (LPVOID*)&m_pTextures[i] );
              // Release the specialized instance
              pTexCube:= nil;
            end;
          end;

          D3DRTYPE_VOLUMETEXTURE:
          begin
            if SUCCEEDED(D3DXCreateVolumeTextureFromFileW(pd3dDevice, strTexture, pTexVol)) then
            begin
              // Obtain the base texture interface
              m_pTextures[i] := pTexVol; // pTex->QueryInterface( IID_IDirect3DBaseTexture9, (LPVOID*)&m_pTextures[i] );
              // Release the specialized instance
              pTexVol:= nil;
            end;
            break;
          end;
        end;
      end;
    end;
  end;
  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
function CDXUTMesh.SetFVF(pd3dDevice: IDirect3DDevice9; dwFVF: DWORD): HRESULT;
var
  pTempMesh: ID3DXMesh;
  dwOldFVF: DWORD;
begin
  if Assigned(m_pMesh) then
  begin
    if FAILED(m_pMesh.CloneMeshFVF(m_pMesh.GetOptions, dwFVF, pd3dDevice, pTempMesh)) then
    begin
      Result:= E_FAIL;
      Exit;
    end;

    dwOldFVF := m_pMesh.GetFVF;
    m_pMesh := pTempMesh;

    // Compute normals if they are being requested and
    // the old mesh does not have them.
    if (dwOldFVF and D3DFVF_NORMAL = 0) and (dwFVF and D3DFVF_NORMAL <> 0)
    then D3DXComputeNormals(m_pMesh, nil);
  end;

  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
// Convert the mesh to the format specified by the given vertex declarations.
//-----------------------------------------------------------------------------
function CDXUTMesh.SetVertexDecl(const pd3dDevice: IDirect3DDevice9; const pDecl: PD3DVertexElement9;
  bAutoComputeNormals: Boolean = True; bAutoComputeTangents: Boolean = True;
  bSplitVertexForOptimalTangents: Boolean = False): HRESULT;
var
  pTempMesh: ID3DXMesh;
  bHadNormal, bHadTangent: Boolean;
  index: Integer;
  aOldDecl, aNewDecl: TFVFDeclaration;
  bHaveNormalNow, bHaveTangentNow: Boolean;
  pNewMesh: ID3DXMesh;
  rgdwAdjacency: PDWORD;
  fPartialEdgeThreshold: Single;
  fSingularPointThreshold: Single;
  fNormalEdgeThreshold: Single;
begin
  if Assigned(m_pMesh) then
  begin
    if FAILED(m_pMesh.CloneMesh(m_pMesh.GetOptions, pDecl,
                                pd3dDevice, pTempMesh)) then
    begin
      // pTempMesh := nil;
      Result:= E_FAIL;
      Exit;
    end;
  end;


  // Check if the old declaration contains a normal.
  bHadNormal := False;
  bHadTangent := False;
  if Assigned(m_pMesh) and SUCCEEDED(m_pMesh.GetDeclaration(aOldDecl)) then
  begin
    for index := 0 to D3DXGetDeclLength(@aOldDecl) - 1 do
    begin
      if (aOldDecl[index].Usage = D3DDECLUSAGE_NORMAL) then bHadNormal := True;
      if (aOldDecl[index].Usage = D3DDECLUSAGE_TANGENT) then bHadTangent := True;
    end;
  end;

  // Check if the new declaration contains a normal.
  bHaveNormalNow := False;
  bHaveTangentNow := False;
  if Assigned(pTempMesh) and SUCCEEDED(pTempMesh.GetDeclaration(aNewDecl)) then
  begin
    for index := 0 to D3DXGetDeclLength(@aNewDecl) - 1 do
    begin
      if (aNewDecl[index].Usage = D3DDECLUSAGE_NORMAL) then bHaveNormalNow := True;
      if (aNewDecl[index].Usage = D3DDECLUSAGE_TANGENT) then bHaveTangentNow := True;
    end;
  end;

  m_pMesh := nil;

  if Assigned(pTempMesh) then
  begin
    m_pMesh := pTempMesh;

    if not bHadNormal and bHaveNormalNow and bAutoComputeNormals then
    begin
      // Compute normals in case the meshes have them
      D3DXComputeNormals(m_pMesh, nil);
    end;

    if bHaveNormalNow and not bHadTangent and bHaveTangentNow and bAutoComputeTangents then
    begin
      try
        GetMem(rgdwAdjacency,  SizeOf(DWORD) * m_pMesh.GetNumFaces * 3);
      except
        on EOutOfMemory do
        begin
          Result:= E_OUTOFMEMORY;
          Exit;
        end;
      end;

      V(m_pMesh.GenerateAdjacency(1e-6, rgdwAdjacency));

      if bSplitVertexForOptimalTangents then
      begin
        fPartialEdgeThreshold := 0.01;
        fSingularPointThreshold := 0.25;
        fNormalEdgeThreshold := 0.01;
      end else
      begin
        fPartialEdgeThreshold := -1.01;
        fSingularPointThreshold := 0.01;
        fNormalEdgeThreshold := -1.01;
      end;

      // Compute tangents, which are required for normal mapping
      Result := D3DXComputeTangentFrameEx(m_pMesh,
                    DWORD(D3DDECLUSAGE_TEXCOORD), 0,
                    DWORD(D3DDECLUSAGE_TANGENT), 0,
                    D3DX_DEFAULT, 0,
                    DWORD(D3DDECLUSAGE_NORMAL), 0,
                    0, rgdwAdjacency,
                    fPartialEdgeThreshold, fSingularPointThreshold, fNormalEdgeThreshold,
                    pNewMesh, nil);

      FreeMem(rgdwAdjacency);
      if FAILED(Result) then Exit;

      m_pMesh := pNewMesh;
    end;
  end;

  Result:= S_OK;
end;



//-----------------------------------------------------------------------------
function CDXUTMesh.RestoreDeviceObjects(pd3dDevice: IDirect3DDevice9): HRESULT;
begin
  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
function CDXUTMesh.InvalidateDeviceObjects: HRESULT;
begin
  m_pIB:= nil;
  m_pVB:= nil;
  m_pDecl:= nil;

  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
function CDXUTMesh.DestroyMesh: HRESULT;
var
  i: Integer;
begin
  InvalidateDeviceObjects;
  for i:= 0 to m_dwNumMaterials - 1 do m_pTextures[i] := nil;
  SAFE_FREEMEM(m_pTextures);
  SAFE_FREEMEM(m_pMaterials);

  m_strMaterials:= nil;
  m_pMesh := nil;

  m_dwNumMaterials := 0;

  Result:= S_OK;
end;




//-----------------------------------------------------------------------------
function CDXUTMesh.Render(pd3dDevice: IDirect3DDevice9; bDrawOpaqueSubsets,
  bDrawAlphaSubsets: Boolean): HRESULT;
var
  i: Integer;
begin
  if (m_pMesh = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  // Frist, draw the subsets without alpha
  if bDrawOpaqueSubsets then
  begin
    for i := 0 to m_dwNumMaterials - 1 do
    begin
      if m_bUseMaterials then
      begin
        if (m_pMaterials[i].Diffuse.a < 1.0) then Continue;
        pd3dDevice.SetMaterial(m_pMaterials[i]);
        pd3dDevice.SetTexture(0, m_pTextures[i]);
      end;
      m_pMesh.DrawSubset(i);
    end;
  end;

  // Then, draw the subsets with alpha
  if (bDrawAlphaSubsets and m_bUseMaterials) then
  begin
    for i := 0 to m_dwNumMaterials - 1 do
    begin
      if (m_pMaterials[i].Diffuse.a = 1.0) then Continue;

      // Set the material and texture
      pd3dDevice.SetMaterial(m_pMaterials[i]);
      pd3dDevice.SetTexture(0, m_pTextures[i]);
      m_pMesh.DrawSubset(i);
    end;
  end;

  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
function CDXUTMesh.Render(const pEffect: ID3DXEffect;
  hTexture, hDiffuse, hAmbient, hSpecular, hEmissive, hPower: TD3DXHandle;
  bDrawOpaqueSubsets, bDrawAlphaSubsets: Boolean): HRESULT;
var
  i: Integer;
  cPasses: LongWord;
  p: Integer;
begin
  if (m_pMesh = nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  // Frist, draw the subsets without alpha
  if bDrawOpaqueSubsets then
  begin
    pEffect._Begin(@cPasses, 0);
    for p := 0 to Integer(cPasses) - 1 do
    begin
      pEffect.BeginPass(p);
      for i := 0 to m_dwNumMaterials - 1 do
      begin
        if m_bUseMaterials then
        begin
          if (m_pMaterials[i].Diffuse.a < 1.0) then Continue;
          if (hTexture  <> nil) then pEffect.SetTexture(hTexture, m_pTextures[i]);
          // D3DCOLORVALUE and D3DXVECTOR4 are data-wise identical.
          // No conversion is needed.
          if (hDiffuse  <> nil) then pEffect.SetVector(hDiffuse,  PD3DXVector4(@m_pMaterials[i].Diffuse)^);
          if (hAmbient  <> nil) then pEffect.SetVector(hAmbient,  PD3DXVector4(@m_pMaterials[i].Ambient)^);
          if (hSpecular <> nil) then pEffect.SetVector(hSpecular, PD3DXVector4(@m_pMaterials[i].Specular)^);
          if (hEmissive <> nil) then pEffect.SetVector(hEmissive, PD3DXVector4(@m_pMaterials[i].Emissive)^);
          if (hPower    <> nil) then pEffect.SetFloat (hPower,    m_pMaterials[i].Power);
          pEffect.CommitChanges;
        end;
        m_pMesh.DrawSubset( i);
      end;
      pEffect.EndPass;
    end;
    pEffect._End;
  end;

  // Then, draw the subsets with alpha
  if (bDrawAlphaSubsets and m_bUseMaterials) then
  begin
    pEffect._Begin(@cPasses, 0);
    for p := 0 to Integer(cPasses) - 1 do
    begin
      pEffect.BeginPass(p);
      for i := 0 to m_dwNumMaterials - 1 do
      begin
        if m_bUseMaterials then
        begin
          if (m_pMaterials[i].Diffuse.a = 1.0) then Continue;
          if (hTexture  <> nil) then pEffect.SetTexture(hTexture, m_pTextures[i]);
          // D3DCOLORVALUE and D3DXVECTOR4 are data-wise identical.
          // No conversion is needed.
          if (hDiffuse  <> nil) then pEffect.SetVector(hDiffuse,  PD3DXVector4(@m_pMaterials[i].Diffuse)^);
          if (hAmbient  <> nil) then pEffect.SetVector(hAmbient,  PD3DXVector4(@m_pMaterials[i].Ambient)^);
          if (hSpecular <> nil) then pEffect.SetVector(hSpecular, PD3DXVector4(@m_pMaterials[i].Specular)^);
          if (hEmissive <> nil) then pEffect.SetVector(hEmissive, PD3DXVector4(@m_pMaterials[i].Emissive)^);
          if (hPower    <> nil) then pEffect.SetFloat (hPower,    m_pMaterials[i].Power);
          pEffect.CommitChanges;
        end;
        m_pMesh.DrawSubset(i);
      end;
      pEffect.EndPass;
    end;
    pEffect._End;
  end;

  Result:= S_OK;
end;


procedure CDXUTMesh.UseMeshMaterials(bFlag: Boolean);
begin
  m_bUseMaterials := bFlag;
end;



{ CDXUTMeshFrame }

//-----------------------------------------------------------------------------
constructor CDXUTMeshFrame.Create(strName: WideString);
begin
  StringCchCopy(m_strName, 512, PWideChar(strName));
  D3DXMatrixIdentity(m_mat);
  m_pMesh  := nil;

  m_pChild := nil;
  m_pNext  := nil;
end;


//-----------------------------------------------------------------------------
destructor CDXUTMeshFrame.Destroy;
begin
  SAFE_DELETE(m_pChild);
  SAFE_DELETE(m_pNext);
  inherited;
end;


//-----------------------------------------------------------------------------
function CDXUTMeshFrame.EnumMeshes(EnumMeshCB: TEnumMeshCBProc;
  pContext: Pointer): Boolean;
begin
  if (m_pMesh <> nil) then EnumMeshCB(m_pMesh, pContext);
  if (m_pChild <> nil) then m_pChild.EnumMeshes(EnumMeshCB, pContext);
  if (m_pNext <> nil) then m_pNext.EnumMeshes(EnumMeshCB, pContext);

  Result:= True;
end;


//-----------------------------------------------------------------------------
function CDXUTMeshFrame.FindMesh(strMeshName: PWideChar): CDXUTMesh;
begin
  if (m_pMesh <> nil) and (lstrcmpiW(m_pMesh.m_strName, strMeshName) = 0) then
  begin
    Result:= m_pMesh;
    Exit;
  end;

  if (m_pChild <> nil) then
  begin
    Result := m_pChild.FindMesh(strMeshName);
    if (Result <> nil) then Exit;
  end;

  if (m_pNext <> nil) then
  begin
    Result := m_pNext.FindMesh(strMeshName);
    if (Result <> nil) then Exit;
  end;

  Result:= nil;
end;




//-----------------------------------------------------------------------------
function CDXUTMeshFrame.FindFrame(strFrameName: PWideChar): CDXUTMeshFrame;
begin
  if (lstrcmpiW(@m_strName, strFrameName) = 0) then
  begin
    Result:= Self;
    Exit;
  end;

  if (m_pChild <> nil) then
  begin
    Result := m_pChild.FindFrame(strFrameName);
    if (Result <> nil) then Exit;
  end;

  if (m_pNext <> nil) then
  begin
    Result := m_pNext.FindFrame(strFrameName);
    if (Result <> nil) then Exit;
  end;

  Result:= nil;
end;



//-----------------------------------------------------------------------------
function CDXUTMeshFrame.DestroyMesh: HRESULT;
begin
  if (m_pMesh  <> nil) then m_pMesh.DestroyMesh;
  if (m_pChild <> nil) then m_pChild.DestroyMesh;
  if (m_pNext  <> nil) then m_pNext.DestroyMesh;

  SAFE_DELETE(m_pMesh);
  SAFE_DELETE(m_pNext);
  SAFE_DELETE(m_pChild);

  Result:= S_OK;
end;



//-----------------------------------------------------------------------------
function CDXUTMeshFrame.RestoreDeviceObjects(
  pd3dDevice: IDirect3DDevice9): HRESULT;
begin
  if (m_pMesh  <> nil) then m_pMesh.RestoreDeviceObjects(pd3dDevice);
  if (m_pChild <> nil) then m_pChild.RestoreDeviceObjects(pd3dDevice);
  if (m_pNext  <> nil) then m_pNext.RestoreDeviceObjects(pd3dDevice);
  Result:= S_OK;
end;



//-----------------------------------------------------------------------------
function CDXUTMeshFrame.InvalidateDeviceObjects: HRESULT;
begin
  if (m_pMesh  <> nil) then m_pMesh.InvalidateDeviceObjects;
  if (m_pChild <> nil) then m_pChild.InvalidateDeviceObjects;
  if (m_pNext  <> nil) then m_pNext.InvalidateDeviceObjects;
  Result:= S_OK;
end;



//-----------------------------------------------------------------------------
function CDXUTMeshFrame.Render(pd3dDevice: IDirect3DDevice9;
  bDrawOpaqueSubsets, bDrawAlphaSubsets: Boolean;
  pmatWorldMatrix: PD3DXMatrix): HRESULT;
var
  matSavedWorld, matWorld: TD3DXMatrix;
begin
  // For pure devices, specify the world transform. If the world transform is not
  // specified on pure devices, this function will fail.

  if (pmatWorldMatrix = nil)
  then pd3dDevice.GetTransform(D3DTS_WORLD, matSavedWorld)
  else matSavedWorld := pmatWorldMatrix^;

  D3DXMatrixMultiply(matWorld, m_mat, matSavedWorld);
  pd3dDevice.SetTransform(D3DTS_WORLD, matWorld);

  if (m_pMesh <> nil)
  then m_pMesh.Render(pd3dDevice, bDrawOpaqueSubsets, bDrawAlphaSubsets);

  if (m_pChild <> nil)
  then m_pChild.Render(pd3dDevice, bDrawOpaqueSubsets, bDrawAlphaSubsets, @matWorld);

  pd3dDevice.SetTransform(D3DTS_WORLD, matSavedWorld);

  if (m_pNext <> nil)
  then m_pNext.Render(pd3dDevice, bDrawOpaqueSubsets, bDrawAlphaSubsets, @matSavedWorld);

  Result:= S_OK;
end;


function CDXUTMeshFrame.GetMatrix: PD3DXMatrix;
begin
  Result := @m_mat;
end;


procedure CDXUTMeshFrame.SetMatrix(const pmat: TD3DXMatrix);
begin
  m_mat := pmat;
end;





{ CDXUTMeshFile }

constructor CDXUTMeshFile.Create;
begin
  inherited Create('CDXUTMeshFile_Root');
end;


function EqualGUID(const G1, G2: TGUID): Boolean;
begin
  Result := CompareMem(@G1, @G2, SizeOf(TGUID));
end;

//-----------------------------------------------------------------------------
function CDXUTMeshFile.LoadFrame(pd3dDevice: IDirect3DDevice9;
  pFileData: ID3DXFileData; pParentFrame: CDXUTMeshFrame): HRESULT;
var
  pChildData: ID3DXFileData;
  Guid: TGUID;
  cbSize: SIZE_T;
  pCurrentFrame: CDXUTMeshFrame;
  pmatMatrix: PD3DXMatrix;
  strAnsiName: array[0..511] of AnsiChar;
  strName: array[0..511] of WideChar;
  dwNameLength: SIZE_T;
  cChildren: SIZE_T;
  iChild: Integer;
begin
  // Get the type of the object
  Result := pFileData.GetType(Guid);
  if FAILED(Result) then Exit;

  if EqualGUID(Guid, TID_D3DRMMesh) then
  begin
    Result := LoadMesh(pd3dDevice, pFileData, pParentFrame);
    if FAILED(Result) then Exit;
  end;
  if EqualGUID(Guid, TID_D3DRMFrameTransformMatrix) then
  begin
    Result := pFileData.Lock(@cbSize, Pointer(pmatMatrix));
    if FAILED(Result) then Exit;

    // Update the parent's matrix with the new one
    pParentFrame.SetMatrix(pmatMatrix^);
  end;
  if EqualGUID(Guid, TID_D3DRMFrame) then
  begin
    // Get the frame name
    strAnsiName := '';
    dwNameLength := 512;
    Result := pFileData.GetName(strAnsiName, @dwNameLength);
    if FAILED(Result) then Exit;

    WideCharToMultiByte(CP_ACP, 0, strName, -1, strAnsiName, 512, nil, nil);
    strName[511] := #0;

    // Create the frame
    try
      pCurrentFrame := CDXUTMeshFrame.Create(WideString(@strName));
    except
      on EOutOfMemory do begin Result:= E_OUTOFMEMORY; Exit; end;
    end;

    pCurrentFrame.m_pNext := pParentFrame.m_pChild;
    pParentFrame.m_pChild := pCurrentFrame;

    // Enumerate child objects
    pFileData.GetChildren(cChildren);
    for iChild := 0 to cChildren - 1 do
    begin
      // Query the child for its FileData
      Result := pFileData.GetChild(iChild, pChildData);
      if SUCCEEDED(Result) then
      begin
        Result := LoadFrame(pd3dDevice, pChildData, pCurrentFrame);
        SAFE_RELEASE(pChildData);
      end;

      if FAILED(Result) then Exit;
    end;
  end;

  Result:= S_OK;
end;


//-----------------------------------------------------------------------------
function CDXUTMeshFile.LoadMesh(pd3dDevice: IDirect3DDevice9;
  pFileData: ID3DXFileData; pParentFrame: CDXUTMeshFrame): HRESULT;
var
  strAnsiName: array[0..511] of AnsiChar;
  strName: array[0..511] of WideChar;
  dwNameLength: SIZE_T;
begin
  // Currently only allowing one mesh per frame
  if (pParentFrame.m_pMesh <> nil) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  // Get the mesh name
  strAnsiName := #0;
  dwNameLength := 512;
  Result := pFileData.GetName(strAnsiName, @dwNameLength);
  if FAILED(Result) then Exit;

  MultiByteToWideChar(CP_ACP, 0, strAnsiName, -1, strName, 512);
  strName[511] := #0;

  // Create the mesh
  try
    pParentFrame.m_pMesh := CDXUTMesh.Create(WideString(@strName));
  except
    on EOutOfMemory do begin Result:= E_OUTOFMEMORY; Exit; end;
  end;
  pParentFrame.m_pMesh.CreateMesh(pd3dDevice, pFileData);

  Result:= S_OK;
end;




//-----------------------------------------------------------------------------
function CDXUTMeshFile.CreateFromResource(pd3dDevice: IDirect3DDevice9;
  strResource, strType: PWideChar): HRESULT;
var
  pDXFile: ID3DXFile;
  pEnumObj: ID3DXFileEnumObject;
  pFileData: ID3DXFileData;
  cChildren: SIZE_T;
  strTypeAnsi, strResourceAnsi: array[0..MAX_PATH-1] of Char;
  dxlr: TD3DXFFileLoadResource;
  iChild: Integer;
begin
  // Create a x file object
  Result := D3DXFileCreate(pDXFile);
  if FAILED(Result) then Exit;

  // Register templates for d3drm and patch extensions.
  Result := pDXFile.RegisterTemplates(@D3DRM_XTEMPLATES, D3DRM_XTEMPLATE_BYTES);
  if FAILED(Result) then
  begin
    SAFE_RELEASE(pDXFile);
    Result:= E_FAIL;
    Exit;
  end;

  WideCharToMultiByte(CP_ACP, 0, strType, -1, strTypeAnsi, MAX_PATH, nil, nil);
  strTypeAnsi[MAX_PATH-1] := #0;

  WideCharToMultiByte(CP_ACP, 0, strResource, -1, strResourceAnsi, MAX_PATH, nil, nil);
  strResourceAnsi[MAX_PATH-1] := #0;

  dxlr.hModule := 0;
  dxlr.lpName := strResourceAnsi;
  dxlr.lpType := strTypeAnsi;

  // Create enum object
  Result := pDXFile.CreateEnumObject(@dxlr, D3DXF_FILELOAD_FROMRESOURCE, pEnumObj);
  if FAILED(Result) then Exit;

  // Enumerate top level objects (which are always frames)
  pEnumObj.GetChildren(cChildren);
  for iChild := 0 to cChildren - 1 do
  begin
    Result := pEnumObj.GetChild(iChild, pFileData);
    if FAILED(Result) then Exit;

    Result := LoadFrame(pd3dDevice, pFileData, Self);
    SAFE_RELEASE(pFileData);
    if FAILED(Result) then
    begin
      SAFE_RELEASE(pEnumObj);
      SAFE_RELEASE(pDXFile);
      Result:= E_FAIL;
      Exit;
    end;
  end;

  SAFE_RELEASE(pFileData);
  SAFE_RELEASE(pEnumObj);
  SAFE_RELEASE(pDXFile);

  Result:= S_OK;
end;




//-----------------------------------------------------------------------------
function CDXUTMeshFile.CreateMesh(pd3dDevice: IDirect3DDevice9;
  strFilename: PWideChar): HRESULT;
var
  pDXFile: ID3DXFile;
  pEnumObj: ID3DXFileEnumObject;
  pFileData: ID3DXFileData;
  cChildren: SIZE_T;
  strPath: array[0..MAX_PATH-1] of WideChar;
  strPathANSI: array[0..MAX_PATH-1] of Char;
  iChild: Integer;
begin
  // Create a x file object
  Result := D3DXFileCreate(pDXFile);
  if FAILED(Result) then
  begin
    Result:= E_FAIL;
    Exit;
  end;

  // Register templates for d3drm and patch extensions.
  Result := pDXFile.RegisterTemplates(@D3DRM_XTEMPLATES, D3DRM_XTEMPLATE_BYTES);
  if FAILED(Result) then
  begin
    SAFE_RELEASE(pDXFile);
    Result:= E_FAIL;
    Exit;
  end;

  // Find the path to the file, and convert it to ANSI (for the D3DXOF API)
  DXUTFindDXSDKMediaFile(strPath, SizeOf(strPath) div SizeOf(WideChar), strFilename);

  WideCharToMultiByte(CP_ACP, 0, strPath, -1, strPathANSI, MAX_PATH, nil, nil);
  strPathANSI[MAX_PATH-1] := #0;

  // Create enum object
  Result := pDXFile.CreateEnumObject(@strPathANSI, D3DXF_FILELOAD_FROMFILE, pEnumObj);
  if FAILED(Result) then Exit;

  // Enumerate top level objects (which are always frames)
  pEnumObj.GetChildren(cChildren);
  for iChild := 0 to Integer(cChildren) - 1 do
  begin
    Result := pEnumObj.GetChild(iChild, pFileData);
    if FAILED(Result) then Exit;

    Result := LoadFrame(pd3dDevice, pFileData, Self);
    SAFE_RELEASE(pFileData);
    if FAILED(Result) then
    begin
      SAFE_RELEASE(pEnumObj);
      SAFE_RELEASE(pDXFile);
      Result:= E_FAIL;
      Exit;
    end;
  end;

  SAFE_RELEASE(pFileData);
  SAFE_RELEASE(pEnumObj);
  SAFE_RELEASE(pDXFile);

  Result:= S_OK;
end;




//-----------------------------------------------------------------------------
function CDXUTMeshFile.Render(pd3dDevice: IDirect3DDevice9;
  pmatWorldMatrix: PD3DXMatrix): HRESULT;
var
  matSavedWorld, matWorld: TD3DXMatrix;
begin
  // For pure devices, specify the world transform. If the world transform is not
  // specified on pure devices, this function will fail.

  // Set up the world transformation

  if (pmatWorldMatrix = nil)
  then pd3dDevice.GetTransform(D3DTS_WORLD, matSavedWorld)
  else matSavedWorld := pmatWorldMatrix^;

  D3DXMatrixMultiply(matWorld, matSavedWorld, m_mat);
  pd3dDevice.SetTransform(D3DTS_WORLD, matWorld);

  // Render opaque subsets in the meshes
  if (m_pChild <> nil) then m_pChild.Render(pd3dDevice, True, False, @matWorld);

  // Enable alpha blending
  pd3dDevice.SetRenderState(D3DRS_ALPHABLENDENABLE, iTrue);
  pd3dDevice.SetRenderState(D3DRS_SRCBLEND,  D3DBLEND_SRCALPHA);
  pd3dDevice.SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);

  // Render alpha subsets in the meshes
  if (m_pChild <> nil) then m_pChild.Render(pd3dDevice, False, True, @matWorld);

  // Restore state
  pd3dDevice.SetRenderState(D3DRS_ALPHABLENDENABLE, iFalse);
  pd3dDevice.SetTransform(D3DTS_WORLD, matSavedWorld);

  Result:= S_OK;
end;

end.

