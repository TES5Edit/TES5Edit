{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) 1999 Microsoft Corporation.  All Rights Reserved.           *}
{*                                                                            *}
{*  File:       dxfile.h, rmxfguid.h, rmxftmpl.h                              *}
{*  Content:    Interfaces to access Rendermorthics eXtensible file format    *}
{*                                                                            *}
{*  DirectX 9.0 Delphi / FreePascal adaptation by Alexey Barkovoy             *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Modified: 10-Dec-2002                                                     *}
{*                                                                            *}
{*  Partly based upon :                                                       *}
{*    DirectX 7.0 Delphi adaptation by                                        *}
{*      Erik Unger, e-Mail: DelphiDirectX@next-reality.com                    *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://clootie.ru                                                       *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
{*  This File contains interfaces to access Rendermorthics eXtensible file    *}
{*  known as 'X-file'. Also this file contains GUID's and templates from      *}
{*  Direct3D Retained mode "rmxfguid.h" and "rmxftmpl.h" (they are used by    *}
{*  Direct3D8 Immediate mode samples).                                        *}
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

unit DXFile;

interface

(*$HPPEMIT '#include "dxfile.h"'{*)
(*$HPPEMIT '#include "rmxfguid.h"'{*)
(*$HPPEMIT '#include "rmxftmpl.h"'{*)

uses Windows;

(***************************************************************************
{*
{*  Copyright (C) 1998-1999 Microsoft Corporation.  All Rights Reserved.
{*
{*  File:       dxfile.h
{*
{*  Content:    DirectX File public header file
{*
{***************************************************************************)

type
  DXFILEFORMAT = DWORD;
  {$EXTERNALSYM DXFILEFORMAT}
  TDXFileFormat = DXFILEFORMAT;

const
  DXFILEFORMAT_BINARY     = 0;
  {$EXTERNALSYM DXFILEFORMAT_BINARY}
  DXFILEFORMAT_TEXT       = 1;
  {$EXTERNALSYM DXFILEFORMAT_TEXT}
  DXFILEFORMAT_COMPRESSED = 2;
  {$EXTERNALSYM DXFILEFORMAT_COMPRESSED}

type
  DXFILELOADOPTIONS = type DWord;
  {$EXTERNALSYM DXFILELOADOPTIONS}
  TDXFileLoadOptions = DXFILELOADOPTIONS;

const
  DXFILELOAD_FROMFILE           = $00;
  {$EXTERNALSYM DXFILELOAD_FROMFILE}
  DXFILELOAD_FROMRESOURCE       = $01;
  {$EXTERNALSYM DXFILELOAD_FROMRESOURCE}
  DXFILELOAD_FROMMEMORY         = $02;
  {$EXTERNALSYM DXFILELOAD_FROMMEMORY}
  DXFILELOAD_FROMSTREAM         = $04;
  {$EXTERNALSYM DXFILELOAD_FROMSTREAM}
  DXFILELOAD_FROMURL            = $08;
  {$EXTERNALSYM DXFILELOAD_FROMURL}

type
  PDXFileLoadResource = ^TDXFileLoadResource;
  _DXFILELOADRESOURCE = packed record
    hModule: HModule;
    lpName: PChar;
    lpType: PChar;
  end;
  {$EXTERNALSYM _DXFILELOADRESOURCE}
  DXFILELOADRESOURCE = _DXFILELOADRESOURCE;
  {$EXTERNALSYM DXFILELOADRESOURCE}
  TDXFileLoadResource = _DXFILELOADRESOURCE;

  PDXFileLoadMemory = ^TDXFileLoadMemory;
  _DXFILELOADMEMORY = packed record
    lpMemory: Pointer;
    dSize: DWord;
  end;
  {$EXTERNALSYM _DXFILELOADMEMORY}
  DXFILELOADMEMORY = _DXFILELOADMEMORY;
  {$EXTERNALSYM DXFILELOADMEMORY}
  TDXFileLoadMemory = _DXFILELOADMEMORY;

(*
{* DirectX File object types.
{*)

type
  IDirectXFile = interface;
  {$EXTERNALSYM IDirectXFile}
  {$HPPEMIT 'typedef System::DelphiInterface<IDirectXFile> _di_IDirectXFile;'}
  IDirectXFileEnumObject = interface;
  {$EXTERNALSYM IDirectXFileEnumObject}
  {$HPPEMIT 'typedef System::DelphiInterface<IDirectXFileEnumObject> _di_IDirectXFileEnumObject;'}
  IDirectXFileSaveObject = interface;
  {$EXTERNALSYM IDirectXFileSaveObject}
  {$HPPEMIT 'typedef System::DelphiInterface<IDirectXFileSaveObject> _di_IDirectXFileSaveObject;'}
  IDirectXFileObject = interface;
  {$EXTERNALSYM IDirectXFileObject}
  {$HPPEMIT 'typedef System::DelphiInterface<IDirectXFileObject> _di_IDirectXFileObject;'}
  IDirectXFileData = interface;
  {$EXTERNALSYM IDirectXFileData}
  {$HPPEMIT 'typedef System::DelphiInterface<IDirectXFileData> _di_IDirectXFileData;'}
  IDirectXFileDataReference = interface;
  {$EXTERNALSYM IDirectXFileDataReference}
  {$HPPEMIT 'typedef System::DelphiInterface<IDirectXFileDataReference> _di_IDirectXFileDataReference;'}
  IDirectXFileBinary = interface;
  {$EXTERNALSYM IDirectXFileBinary}
  {$HPPEMIT 'typedef System::DelphiInterface<IDirectXFileBinary> _di_IDirectXFileBinary;'}

(*
{* DirectX File interfaces.
{*)

  IDirectXFile = interface(IUnknown)
    ['{3d82ab40-62da-11cf-ab39-0020af71e433}']
    function CreateEnumObject (pvSource: Pointer;
        dwLoadOptions: TDXFileLoadOptions;
        var ppEnumObj: IDirectXFileEnumObject): HResult; stdcall;
    function CreateSaveObject (szFileName: PChar; dwFileFormat: TDXFileFormat;
        var ppSaveObj: IDirectXFileSaveObject): HResult; stdcall;
    function RegisterTemplates (pvData: Pointer; cbSize: DWORD): HResult; stdcall;
  end;

  IDirectXFileEnumObject = interface (IUnknown)
    ['{3d82ab41-62da-11cf-ab39-0020af71e433}']
    function GetNextDataObject (var ppDataObj: IDirectXFileData) : HResult; stdcall;
    function GetDataObjectById
        (const rguid: TGUID; var ppDataObj: IDirectXFileData) : HResult; stdcall;
    function GetDataObjectByName
        (szName: PChar; var ppDataObj: IDirectXFileData) : HResult; stdcall;
  end;

  IDirectXFileSaveObject = interface (IUnknown)
    ['{3d82ab42-62da-11cf-ab39-0020af71e433}']
    function SaveTemplates
        (cTemplates: DWORD; var ppguidTemplates: PGUID) : HResult; stdcall;
    function CreateDataObject (const rguidTemplate: TGUID; szName: PChar;
        pguid: PGUID; cbSize: DWORD; pvData: Pointer;
        var ppDataObj: IDirectXFileData) : HResult; stdcall;
    function SaveData (pDataObj: IDirectXFileData) : HResult; stdcall;
  end;

  IDirectXFileObject = interface (IUnknown)
    ['{3d82ab43-62da-11cf-ab39-0020af71e433}']
    function GetName (pstrNameBuf: PChar; var dwBufLen: DWORD) : HResult; stdcall;
    function GetId (var pGuidBuf: TGUID) : HResult; stdcall;
  end;

  IDirectXFileData = interface (IDirectXFileObject)
    ['{3d82ab44-62da-11cf-ab39-0020af71e433}']
    function GetData
        (szMember: PChar; var pcbSize: DWORD; var ppvData: Pointer) : HResult; stdcall;
    function GetType (var ppguid: PGUID) : HResult; stdcall;
    function GetNextObject (var ppChildObj: IDirectXFileObject) : HResult; stdcall;
    function AddDataObject (pDataObj: IDirectXFileData) : HResult; stdcall;
    function AddDataReference (szRef: PChar; pguidRef: PGUID) : HResult; stdcall;
    function AddBinaryObject (szName: PChar; pguid: PGUID; szMimeType: PChar;
        pvData: Pointer; cbSize: DWORD) : HResult; stdcall;
  end;

  IDirectXFileDataReference = interface (IDirectXFileObject)
    ['{3d82ab45-62da-11cf-ab39-0020af71e433}']
    function Resolve (var ppDataObj: IDirectXFileData) : HResult; stdcall;
  end;

  IDirectXFileBinary = interface (IDirectXFileObject)
    ['{3d82ab46-62da-11cf-ab39-0020af71e433}']
    function GetSize (var pcbSize: DWORD) : HResult; stdcall;
    function GetMimeType (var pszMimeType: PChar) : HResult; stdcall;
    function Read(pvData: Pointer; cbSize: DWORD; pcbRead: PDWORD{?}) : HResult; stdcall;
  end;


(*
{* DirectXFile Object Class Id (for CoCreateInstance())
{*)

const
  CLSID_CDirectXFile: TGUID =
       (D1:$4516ec43;D2:$8f20;D3:$11d0;D4:($9b,$6d,$00,$00,$c0,$78,$1b,$c3));
  {$EXTERNALSYM CLSID_CDirectXFile}

(*
{* DirectX File Interface GUIDs.
{*)

type
  IID_IDirectXFile               = IDirectXFile;
  {$EXTERNALSYM IID_IDirectXFile}
  IID_IDirectXFileEnumObject     = IDirectXFileEnumObject;
  {$EXTERNALSYM IID_IDirectXFileEnumObject}
  IID_IDirectXFileSaveObject     = IDirectXFileSaveObject;
  {$EXTERNALSYM IID_IDirectXFileSaveObject}
  IID_IDirectXFileObject         = IDirectXFileObject;
  {$EXTERNALSYM IID_IDirectXFileObject}
  IID_IDirectXFileData           = IDirectXFileData;
  {$EXTERNALSYM IID_IDirectXFileData}
  IID_IDirectXFileDataReference  = IDirectXFileDataReference;
  {$EXTERNALSYM IID_IDirectXFileDataReference}
  IID_IDirectXFileBinary         = IDirectXFileBinary;
  {$EXTERNALSYM IID_IDirectXFileBinary}

(*
{* DirectX File Header template's GUID.
{*)

const
  TID_DXFILEHeader: TGUID =
      (D1:$3d82ab43;D2:$62da;D3:$11cf;D4:($ab,$39,$00,$20,$af,$71,$e4,$33));
  {$EXTERNALSYM TID_DXFILEHeader}

(*
{* DirectX File errors.
{*)

const
  _FACD3D = $876;
  {$EXTERNALSYM _FACD3D}

// #define MAKE_DDHRESULT( code )  MAKE_HRESULT( 1, _FACDD, code )
function MAKE_DDHRESULT(Code: DWord): DWord;
{$EXTERNALSYM MAKE_DDHRESULT}

const
  MAKE_DDHRESULT_D     = (1 shl 31) or (_FACD3D shl 16);

  DXFILE_OK                           = 0;
  {$EXTERNALSYM DXFILE_OK}

  DXFILEERR_BADOBJECT                 = HResult(MAKE_DDHRESULT_D or 850);
  {$EXTERNALSYM DXFILEERR_BADOBJECT}
  DXFILEERR_BADVALUE                  = HResult(MAKE_DDHRESULT_D or 851);
  {$EXTERNALSYM DXFILEERR_BADVALUE}
  DXFILEERR_BADTYPE                   = HResult(MAKE_DDHRESULT_D or 852);
  {$EXTERNALSYM DXFILEERR_BADTYPE}
  DXFILEERR_BADSTREAMHANDLE           = HResult(MAKE_DDHRESULT_D or 853);
  {$EXTERNALSYM DXFILEERR_BADSTREAMHANDLE}
  DXFILEERR_BADALLOC                  = HResult(MAKE_DDHRESULT_D or 854);
  {$EXTERNALSYM DXFILEERR_BADALLOC}
  DXFILEERR_NOTFOUND                  = HResult(MAKE_DDHRESULT_D or 855);
  {$EXTERNALSYM DXFILEERR_NOTFOUND}
  DXFILEERR_NOTDONEYET                = HResult(MAKE_DDHRESULT_D or 856);
  {$EXTERNALSYM DXFILEERR_NOTDONEYET}
  DXFILEERR_FILENOTFOUND              = HResult(MAKE_DDHRESULT_D or 857);
  {$EXTERNALSYM DXFILEERR_FILENOTFOUND}
  DXFILEERR_RESOURCENOTFOUND          = HResult(MAKE_DDHRESULT_D or 858);
  {$EXTERNALSYM DXFILEERR_RESOURCENOTFOUND}
  DXFILEERR_URLNOTFOUND               = HResult(MAKE_DDHRESULT_D or 859);
  {$EXTERNALSYM DXFILEERR_URLNOTFOUND}
  DXFILEERR_BADRESOURCE               = HResult(MAKE_DDHRESULT_D or 860);
  {$EXTERNALSYM DXFILEERR_BADRESOURCE}
  DXFILEERR_BADFILETYPE               = HResult(MAKE_DDHRESULT_D or 861);
  {$EXTERNALSYM DXFILEERR_BADFILETYPE}
  DXFILEERR_BADFILEVERSION            = HResult(MAKE_DDHRESULT_D or 862);
  {$EXTERNALSYM DXFILEERR_BADFILEVERSION}
  DXFILEERR_BADFILEFLOATSIZE          = HResult(MAKE_DDHRESULT_D or 863);
  {$EXTERNALSYM DXFILEERR_BADFILEFLOATSIZE}
  DXFILEERR_BADFILECOMPRESSIONTYPE    = HResult(MAKE_DDHRESULT_D or 864);
  {$EXTERNALSYM DXFILEERR_BADFILECOMPRESSIONTYPE}
  DXFILEERR_BADFILE                   = HResult(MAKE_DDHRESULT_D or 865);
  {$EXTERNALSYM DXFILEERR_BADFILE}
  DXFILEERR_PARSEERROR                = HResult(MAKE_DDHRESULT_D or 866);
  {$EXTERNALSYM DXFILEERR_PARSEERROR}
  DXFILEERR_NOTEMPLATE                = HResult(MAKE_DDHRESULT_D or 867);
  {$EXTERNALSYM DXFILEERR_NOTEMPLATE}
  DXFILEERR_BADARRAYSIZE              = HResult(MAKE_DDHRESULT_D or 868);
  {$EXTERNALSYM DXFILEERR_BADARRAYSIZE}
  DXFILEERR_BADDATAREFERENCE          = HResult(MAKE_DDHRESULT_D or 869);
  {$EXTERNALSYM DXFILEERR_BADDATAREFERENCE}
  DXFILEERR_INTERNALERROR             = HResult(MAKE_DDHRESULT_D or 870);
  {$EXTERNALSYM DXFILEERR_INTERNALERROR}
  DXFILEERR_NOMOREOBJECTS             = HResult(MAKE_DDHRESULT_D or 871);
  {$EXTERNALSYM DXFILEERR_NOMOREOBJECTS}
  DXFILEERR_BADINTRINSICS             = HResult(MAKE_DDHRESULT_D or 872);
  {$EXTERNALSYM DXFILEERR_BADINTRINSICS}
  DXFILEERR_NOMORESTREAMHANDLES       = HResult(MAKE_DDHRESULT_D or 873);
  {$EXTERNALSYM DXFILEERR_NOMORESTREAMHANDLES}
  DXFILEERR_NOMOREDATA                = HResult(MAKE_DDHRESULT_D or 874);
  {$EXTERNALSYM DXFILEERR_NOMOREDATA}
  DXFILEERR_BADCACHEFILE              = HResult(MAKE_DDHRESULT_D or 875);
  {$EXTERNALSYM DXFILEERR_BADCACHEFILE}
  DXFILEERR_NOINTERNET                = HResult(MAKE_DDHRESULT_D or 876);
  {$EXTERNALSYM DXFILEERR_NOINTERNET}

(*
{* API for creating IDirectXFile interface.
{*)

function DirectXFileCreate(out lplpDirectXFile: IDirectXFile): HResult; stdcall;
{$EXTERNALSYM DirectXFileCreate}



(***************************************************************************
{*
{*  Copyright (C) 1998-1999 Microsoft Corporation.  All Rights Reserved.
{*
{*  File:       rmxfguid.h
{*
{*  Content:    Defines GUIDs of D3DRM's templates.
{*
{***************************************************************************)

const
  TID_D3DRMInfo: TGUID                  = '{2B957100-9E9A-11cf-AB39-0020AF71E433}';
  {$EXTERNALSYM TID_D3DRMInfo}
  TID_D3DRMMesh: TGUID                  = '{3D82AB44-62DA-11cf-AB39-0020AF71E433}';
  {$EXTERNALSYM TID_D3DRMMesh}
  TID_D3DRMVector: TGUID                = '{3D82AB5E-62DA-11cf-AB39-0020AF71E433}';
  {$EXTERNALSYM TID_D3DRMVector}
  TID_D3DRMMeshFace: TGUID              = '{3D82AB5F-62DA-11cf-AB39-0020AF71E433}';
  {$EXTERNALSYM TID_D3DRMMeshFace}
  TID_D3DRMMaterial: TGUID              = '{3D82AB4D-62DA-11cf-AB39-0020AF71E433}';
  {$EXTERNALSYM TID_D3DRMMaterial}
  TID_D3DRMMaterialArray: TGUID         = '{35FF44E1-6C7C-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMMaterialArray}
  TID_D3DRMFrame: TGUID                 = '{3D82AB46-62DA-11cf-AB39-0020AF71E433}';
  {$EXTERNALSYM TID_D3DRMFrame}
  TID_D3DRMFrameTransformMatrix: TGUID  = '{F6F23F41-7686-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMFrameTransformMatrix}
  TID_D3DRMMeshMaterialList: TGUID      = '{F6F23F42-7686-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMMeshMaterialList}
  TID_D3DRMMeshTextureCoords: TGUID     = '{F6F23F40-7686-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMMeshTextureCoords}
  TID_D3DRMMeshNormals: TGUID           = '{F6F23F43-7686-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMMeshNormals}
  TID_D3DRMCoords2d: TGUID              = '{F6F23F44-7686-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMCoords2d}
  TID_D3DRMMatrix4x4: TGUID             = '{F6F23F45-7686-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMMatrix4x4}
  TID_D3DRMAnimation: TGUID             = '{3D82AB4F-62DA-11cf-AB39-0020AF71E433}';
  {$EXTERNALSYM TID_D3DRMAnimation}
  TID_D3DRMAnimationSet: TGUID          = '{3D82AB50-62DA-11cf-AB39-0020AF71E433}';
  {$EXTERNALSYM TID_D3DRMAnimationSet}
  TID_D3DRMAnimationKey: TGUID          = '{10DD46A8-775B-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMAnimationKey}
  TID_D3DRMFloatKeys: TGUID             = '{10DD46A9-775B-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMFloatKeys}
  TID_D3DRMMaterialAmbientColor: TGUID  = '{01411840-7786-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMMaterialAmbientColor}
  TID_D3DRMMaterialDiffuseColor: TGUID  = '{01411841-7786-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMMaterialDiffuseColor}
  TID_D3DRMMaterialSpecularColor: TGUID = '{01411842-7786-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMMaterialSpecularColor}
  TID_D3DRMMaterialEmissiveColor: TGUID = '{D3E16E80-7835-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMMaterialEmissiveColor}
  TID_D3DRMMaterialPower: TGUID         = '{01411843-7786-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMMaterialPower}
  TID_D3DRMColorRGBA: TGUID             = '{35FF44E0-6C7C-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMColorRGBA}
  TID_D3DRMColorRGB: TGUID              = '{D3E16E81-7835-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMColorRGB}
  TID_D3DRMGuid: TGUID                  = '{A42790E0-7810-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMGuid}
  TID_D3DRMTextureFilename: TGUID       = '{A42790E1-7810-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMTextureFilename}
  TID_D3DRMTextureReference: TGUID      = '{A42790E2-7810-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMTextureReference}
  TID_D3DRMIndexedColor: TGUID          = '{1630B820-7842-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMIndexedColor}
  TID_D3DRMMeshVertexColors: TGUID      = '{1630B821-7842-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMMeshVertexColors}
  TID_D3DRMMaterialWrap: TGUID          = '{4885AE60-78E8-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMMaterialWrap}
  TID_D3DRMBoolean: TGUID               = '{537DA6A0-CA37-11d0-941C-0080C80CFA7B}';
  {$EXTERNALSYM TID_D3DRMBoolean}
  TID_D3DRMMeshFaceWraps: TGUID         = '{ED1EC5C0-C0A8-11d0-941C-0080C80CFA7B}';
  {$EXTERNALSYM TID_D3DRMMeshFaceWraps}
  TID_D3DRMBoolean2d: TGUID             = '{4885AE63-78E8-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMBoolean2d}
  TID_D3DRMTimedFloatKeys: TGUID        = '{F406B180-7B3B-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMTimedFloatKeys}
  TID_D3DRMAnimationOptions: TGUID      = '{E2BF56C0-840F-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMAnimationOptions}
  TID_D3DRMFramePosition: TGUID         = '{E2BF56C1-840F-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMFramePosition}
  TID_D3DRMFrameVelocity: TGUID         = '{E2BF56C2-840F-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMFrameVelocity}
  TID_D3DRMFrameRotation: TGUID         = '{E2BF56C3-840F-11cf-8F52-0040333594A3}';
  {$EXTERNALSYM TID_D3DRMFrameRotation}
  TID_D3DRMLight: TGUID                 = '{3D82AB4A-62DA-11cf-AB39-0020AF71E433}';
  {$EXTERNALSYM TID_D3DRMLight}
  TID_D3DRMCamera: TGUID                = '{3D82AB51-62DA-11cf-AB39-0020AF71E433}';
  {$EXTERNALSYM TID_D3DRMCamera}
  TID_D3DRMAppData: TGUID               = '{E5745280-B24F-11cf-9DD5-00AA00A71A2F}';
  {$EXTERNALSYM TID_D3DRMAppData}
  TID_D3DRMLightUmbra: TGUID            = '{AED22740-B31F-11cf-9DD5-00AA00A71A2F}';
  {$EXTERNALSYM TID_D3DRMLightUmbra}
  TID_D3DRMLightRange: TGUID            = '{AED22742-B31F-11cf-9DD5-00AA00A71A2F}';
  {$EXTERNALSYM TID_D3DRMLightRange}
  TID_D3DRMLightPenumbra: TGUID         = '{AED22741-B31F-11cf-9DD5-00AA00A71A2F}';
  {$EXTERNALSYM TID_D3DRMLightPenumbra}
  TID_D3DRMLightAttenuation: TGUID      = '{A8A98BA0-C5E5-11cf-B941-0080C80CFA7B}';
  {$EXTERNALSYM TID_D3DRMLightAttenuation}
  TID_D3DRMInlineData: TGUID            = '{3A23EEA0-94B1-11d0-AB39-0020AF71E433}';
  {$EXTERNALSYM TID_D3DRMInlineData}
  TID_D3DRMUrl: TGUID                   = '{3A23EEA1-94B1-11d0-AB39-0020AF71E433}';
  {$EXTERNALSYM TID_D3DRMUrl}
  TID_D3DRMProgressiveMesh: TGUID       = '{8A63C360-997D-11d0-941C-0080C80CFA7B}';
  {$EXTERNALSYM TID_D3DRMProgressiveMesh}
  TID_D3DRMExternalVisual: TGUID        = '{98116AA0-BDBA-11d1-82C0-00A0C9697271}';
  {$EXTERNALSYM TID_D3DRMExternalVisual}
  TID_D3DRMStringProperty: TGUID        = '{7F0F21E0-BFE1-11d1-82C0-00A0C9697271}';
  {$EXTERNALSYM TID_D3DRMStringProperty}
  TID_D3DRMPropertyBag: TGUID           = '{7F0F21E1-BFE1-11d1-82C0-00A0C9697271}';
  {$EXTERNALSYM TID_D3DRMPropertyBag}
  TID_D3DRMRightHanded: TGUID           = '{7F5D5EA0-D53A-11d1-82C0-00A0C9697271}';
  {$EXTERNALSYM TID_D3DRMRightHanded}



(*==========================================================================;
{*
{*  Copyright (C) 1995-1997 Microsoft Corporation.  All Rights Reserved.
{*
{*  File:       rmxftmpl.h
{*  Content:    D3DRM XFile templates in binary form
{*
{***************************************************************************)

const
  D3DRM_XTEMPLATE_BYTES  = 3278;
  {$EXTERNALSYM D3DRM_XTEMPLATE_BYTES}

  {$EXTERNALSYM D3DRM_XTEMPLATES}
  D3DRM_XTEMPLATES: array [0..D3DRM_XTEMPLATE_BYTES-1] of byte = (
        $78, $6f, $66, $20, $30, $33, $30, $32, $62, $69, $6e, $20, $30, $30, $36, $34, $1f, 0, $1,
        0, $6, 0, 0, 0, $48, $65, $61, $64, $65, $72, $a, 0, $5, 0, $43, $ab, $82, $3d, $da,
        $62, $cf, $11, $ab, $39, 0, $20, $af, $71, $e4, $33, $28, 0, $1, 0, $5, 0, 0, 0, $6d,
        $61, $6a, $6f, $72, $14, 0, $28, 0, $1, 0, $5, 0, 0, 0, $6d, $69, $6e, $6f, $72, $14,
        0, $29, 0, $1, 0, $5, 0, 0, 0, $66, $6c, $61, $67, $73, $14, 0, $b, 0, $1f, 0,
        $1, 0, $6, 0, 0, 0, $56, $65, $63, $74, $6f, $72, $a, 0, $5, 0, $5e, $ab, $82, $3d,
        $da, $62, $cf, $11, $ab, $39, 0, $20, $af, $71, $e4, $33, $2a, 0, $1, 0, $1, 0, 0, 0,
        $78, $14, 0, $2a, 0, $1, 0, $1, 0, 0, 0, $79, $14, 0, $2a, 0, $1, 0, $1, 0,
        0, 0, $7a, $14, 0, $b, 0, $1f, 0, $1, 0, $8, 0, 0, 0, $43, $6f, $6f, $72, $64,
        $73, $32, $64, $a, 0, $5, 0, $44, $3f, $f2, $f6, $86, $76, $cf, $11, $8f, $52, 0, $40, $33,
        $35, $94, $a3, $2a, 0, $1, 0, $1, 0, 0, 0, $75, $14, 0, $2a, 0, $1, 0, $1, 0,
        0, 0, $76, $14, 0, $b, 0, $1f, 0, $1, 0, $9, 0, 0, 0, $4d, $61, $74, $72, $69,
        $78, $34, $78, $34, $a, 0, $5, 0, $45, $3f, $f2, $f6, $86, $76, $cf, $11, $8f, $52, 0, $40,
        $33, $35, $94, $a3, $34, 0, $2a, 0, $1, 0, $6, 0, 0, 0, $6d, $61, $74, $72, $69, $78,
        $e, 0, $3, 0, $10, 0, 0, 0, $f, 0, $14, 0, $b, 0, $1f, 0, $1, 0, $9, 0,
        0, 0, $43, $6f, $6c, $6f, $72, $52, $47, $42, $41, $a, 0, $5, 0, $e0, $44, $ff, $35, $7c,
        $6c, $cf, $11, $8f, $52, 0, $40, $33, $35, $94, $a3, $2a, 0, $1, 0, $3, 0, 0, 0, $72,
        $65, $64, $14, 0, $2a, 0, $1, 0, $5, 0, 0, 0, $67, $72, $65, $65, $6e, $14, 0, $2a,
        0, $1, 0, $4, 0, 0, 0, $62, $6c, $75, $65, $14, 0, $2a, 0, $1, 0, $5, 0, 0,
        0, $61, $6c, $70, $68, $61, $14, 0, $b, 0, $1f, 0, $1, 0, $8, 0, 0, 0, $43, $6f,
        $6c, $6f, $72, $52, $47, $42, $a, 0, $5, 0, $81, $6e, $e1, $d3, $35, $78, $cf, $11, $8f, $52,
        0, $40, $33, $35, $94, $a3, $2a, 0, $1, 0, $3, 0, 0, 0, $72, $65, $64, $14, 0, $2a,
        0, $1, 0, $5, 0, 0, 0, $67, $72, $65, $65, $6e, $14, 0, $2a, 0, $1, 0, $4, 0,
        0, 0, $62, $6c, $75, $65, $14, 0, $b, 0, $1f, 0, $1, 0, $c, 0, 0, 0, $49, $6e,
        $64, $65, $78, $65, $64, $43, $6f, $6c, $6f, $72, $a, 0, $5, 0, $20, $b8, $30, $16, $42, $78,
        $cf, $11, $8f, $52, 0, $40, $33, $35, $94, $a3, $29, 0, $1, 0, $5, 0, 0, 0, $69, $6e,
        $64, $65, $78, $14, 0, $1, 0, $9, 0, 0, 0, $43, $6f, $6c, $6f, $72, $52, $47, $42, $41,
        $1, 0, $a, 0, 0, 0, $69, $6e, $64, $65, $78, $43, $6f, $6c, $6f, $72, $14, 0, $b, 0,
        $1f, 0, $1, 0, $7, 0, 0, 0, $42, $6f, $6f, $6c, $65, $61, $6e, $a, 0, $5, 0, $a0,
        $a6, $7d, $53, $37, $ca, $d0, $11, $94, $1c, 0, $80, $c8, $c, $fa, $7b, $29, 0, $1, 0, $9,
        0, 0, 0, $74, $72, $75, $65, $66, $61, $6c, $73, $65, $14, 0, $b, 0, $1f, 0, $1, 0,
        $9, 0, 0, 0, $42, $6f, $6f, $6c, $65, $61, $6e, $32, $64, $a, 0, $5, 0, $63, $ae, $85,
        $48, $e8, $78, $cf, $11, $8f, $52, 0, $40, $33, $35, $94, $a3, $1, 0, $7, 0, 0, 0, $42,
        $6f, $6f, $6c, $65, $61, $6e, $1, 0, $1, 0, 0, 0, $75, $14, 0, $1, 0, $7, 0, 0,
        0, $42, $6f, $6f, $6c, $65, $61, $6e, $1, 0, $1, 0, 0, 0, $76, $14, 0, $b, 0, $1f,
        0, $1, 0, $c, 0, 0, 0, $4d, $61, $74, $65, $72, $69, $61, $6c, $57, $72, $61, $70, $a,
        0, $5, 0, $60, $ae, $85, $48, $e8, $78, $cf, $11, $8f, $52, 0, $40, $33, $35, $94, $a3, $1,
        0, $7, 0, 0, 0, $42, $6f, $6f, $6c, $65, $61, $6e, $1, 0, $1, 0, 0, 0, $75, $14,
        0, $1, 0, $7, 0, 0, 0, $42, $6f, $6f, $6c, $65, $61, $6e, $1, 0, $1, 0, 0, 0,
        $76, $14, 0, $b, 0, $1f, 0, $1, 0, $f, 0, 0, 0, $54, $65, $78, $74, $75, $72, $65,
        $46, $69, $6c, $65, $6e, $61, $6d, $65, $a, 0, $5, 0, $e1, $90, $27, $a4, $10, $78, $cf, $11,
        $8f, $52, 0, $40, $33, $35, $94, $a3, $31, 0, $1, 0, $8, 0, 0, 0, $66, $69, $6c, $65,
        $6e, $61, $6d, $65, $14, 0, $b, 0, $1f, 0, $1, 0, $8, 0, 0, 0, $4d, $61, $74, $65,
        $72, $69, $61, $6c, $a, 0, $5, 0, $4d, $ab, $82, $3d, $da, $62, $cf, $11, $ab, $39, 0, $20,
        $af, $71, $e4, $33, $1, 0, $9, 0, 0, 0, $43, $6f, $6c, $6f, $72, $52, $47, $42, $41, $1,
        0, $9, 0, 0, 0, $66, $61, $63, $65, $43, $6f, $6c, $6f, $72, $14, 0, $2a, 0, $1, 0,
        $5, 0, 0, 0, $70, $6f, $77, $65, $72, $14, 0, $1, 0, $8, 0, 0, 0, $43, $6f, $6c,
        $6f, $72, $52, $47, $42, $1, 0, $d, 0, 0, 0, $73, $70, $65, $63, $75, $6c, $61, $72, $43,
        $6f, $6c, $6f, $72, $14, 0, $1, 0, $8, 0, 0, 0, $43, $6f, $6c, $6f, $72, $52, $47, $42,
        $1, 0, $d, 0, 0, 0, $65, $6d, $69, $73, $73, $69, $76, $65, $43, $6f, $6c, $6f, $72, $14,
        0, $e, 0, $12, 0, $12, 0, $12, 0, $f, 0, $b, 0, $1f, 0, $1, 0, $8, 0, 0,
        0, $4d, $65, $73, $68, $46, $61, $63, $65, $a, 0, $5, 0, $5f, $ab, $82, $3d, $da, $62, $cf,
        $11, $ab, $39, 0, $20, $af, $71, $e4, $33, $29, 0, $1, 0, $12, 0, 0, 0, $6e, $46, $61,
        $63, $65, $56, $65, $72, $74, $65, $78, $49, $6e, $64, $69, $63, $65, $73, $14, 0, $34, 0, $29,
        0, $1, 0, $11, 0, 0, 0, $66, $61, $63, $65, $56, $65, $72, $74, $65, $78, $49, $6e, $64,
        $69, $63, $65, $73, $e, 0, $1, 0, $12, 0, 0, 0, $6e, $46, $61, $63, $65, $56, $65, $72,
        $74, $65, $78, $49, $6e, $64, $69, $63, $65, $73, $f, 0, $14, 0, $b, 0, $1f, 0, $1, 0,
        $d, 0, 0, 0, $4d, $65, $73, $68, $46, $61, $63, $65, $57, $72, $61, $70, $73, $a, 0, $5,
        0, $c0, $c5, $1e, $ed, $a8, $c0, $d0, $11, $94, $1c, 0, $80, $c8, $c, $fa, $7b, $29, 0, $1,
        0, $f, 0, 0, 0, $6e, $46, $61, $63, $65, $57, $72, $61, $70, $56, $61, $6c, $75, $65, $73,
        $14, 0, $34, 0, $1, 0, $9, 0, 0, 0, $42, $6f, $6f, $6c, $65, $61, $6e, $32, $64, $1,
        0, $e, 0, 0, 0, $66, $61, $63, $65, $57, $72, $61, $70, $56, $61, $6c, $75, $65, $73, $e,
        0, $1, 0, $f, 0, 0, 0, $6e, $46, $61, $63, $65, $57, $72, $61, $70, $56, $61, $6c, $75,
        $65, $73, $f, 0, $14, 0, $b, 0, $1f, 0, $1, 0, $11, 0, 0, 0, $4d, $65, $73, $68,
        $54, $65, $78, $74, $75, $72, $65, $43, $6f, $6f, $72, $64, $73, $a, 0, $5, 0, $40, $3f, $f2,
        $f6, $86, $76, $cf, $11, $8f, $52, 0, $40, $33, $35, $94, $a3, $29, 0, $1, 0, $e, 0, 0,
        0, $6e, $54, $65, $78, $74, $75, $72, $65, $43, $6f, $6f, $72, $64, $73, $14, 0, $34, 0, $1,
        0, $8, 0, 0, 0, $43, $6f, $6f, $72, $64, $73, $32, $64, $1, 0, $d, 0, 0, 0, $74,
        $65, $78, $74, $75, $72, $65, $43, $6f, $6f, $72, $64, $73, $e, 0, $1, 0, $e, 0, 0, 0,
        $6e, $54, $65, $78, $74, $75, $72, $65, $43, $6f, $6f, $72, $64, $73, $f, 0, $14, 0, $b, 0,
        $1f, 0, $1, 0, $10, 0, 0, 0, $4d, $65, $73, $68, $4d, $61, $74, $65, $72, $69, $61, $6c,
        $4c, $69, $73, $74, $a, 0, $5, 0, $42, $3f, $f2, $f6, $86, $76, $cf, $11, $8f, $52, 0, $40,
        $33, $35, $94, $a3, $29, 0, $1, 0, $a, 0, 0, 0, $6e, $4d, $61, $74, $65, $72, $69, $61,
        $6c, $73, $14, 0, $29, 0, $1, 0, $c, 0, 0, 0, $6e, $46, $61, $63, $65, $49, $6e, $64,
        $65, $78, $65, $73, $14, 0, $34, 0, $29, 0, $1, 0, $b, 0, 0, 0, $66, $61, $63, $65,
        $49, $6e, $64, $65, $78, $65, $73, $e, 0, $1, 0, $c, 0, 0, 0, $6e, $46, $61, $63, $65,
        $49, $6e, $64, $65, $78, $65, $73, $f, 0, $14, 0, $e, 0, $1, 0, $8, 0, 0, 0, $4d,
        $61, $74, $65, $72, $69, $61, $6c, $f, 0, $b, 0, $1f, 0, $1, 0, $b, 0, 0, 0, $4d,
        $65, $73, $68, $4e, $6f, $72, $6d, $61, $6c, $73, $a, 0, $5, 0, $43, $3f, $f2, $f6, $86, $76,
        $cf, $11, $8f, $52, 0, $40, $33, $35, $94, $a3, $29, 0, $1, 0, $8, 0, 0, 0, $6e, $4e,
        $6f, $72, $6d, $61, $6c, $73, $14, 0, $34, 0, $1, 0, $6, 0, 0, 0, $56, $65, $63, $74,
        $6f, $72, $1, 0, $7, 0, 0, 0, $6e, $6f, $72, $6d, $61, $6c, $73, $e, 0, $1, 0, $8,
        0, 0, 0, $6e, $4e, $6f, $72, $6d, $61, $6c, $73, $f, 0, $14, 0, $29, 0, $1, 0, $c,
        0, 0, 0, $6e, $46, $61, $63, $65, $4e, $6f, $72, $6d, $61, $6c, $73, $14, 0, $34, 0, $1,
        0, $8, 0, 0, 0, $4d, $65, $73, $68, $46, $61, $63, $65, $1, 0, $b, 0, 0, 0, $66,
        $61, $63, $65, $4e, $6f, $72, $6d, $61, $6c, $73, $e, 0, $1, 0, $c, 0, 0, 0, $6e, $46,
        $61, $63, $65, $4e, $6f, $72, $6d, $61, $6c, $73, $f, 0, $14, 0, $b, 0, $1f, 0, $1, 0,
        $10, 0, 0, 0, $4d, $65, $73, $68, $56, $65, $72, $74, $65, $78, $43, $6f, $6c, $6f, $72, $73,
        $a, 0, $5, 0, $21, $b8, $30, $16, $42, $78, $cf, $11, $8f, $52, 0, $40, $33, $35, $94, $a3,
        $29, 0, $1, 0, $d, 0, 0, 0, $6e, $56, $65, $72, $74, $65, $78, $43, $6f, $6c, $6f, $72,
        $73, $14, 0, $34, 0, $1, 0, $c, 0, 0, 0, $49, $6e, $64, $65, $78, $65, $64, $43, $6f,
        $6c, $6f, $72, $1, 0, $c, 0, 0, 0, $76, $65, $72, $74, $65, $78, $43, $6f, $6c, $6f, $72,
        $73, $e, 0, $1, 0, $d, 0, 0, 0, $6e, $56, $65, $72, $74, $65, $78, $43, $6f, $6c, $6f,
        $72, $73, $f, 0, $14, 0, $b, 0, $1f, 0, $1, 0, $4, 0, 0, 0, $4d, $65, $73, $68,
        $a, 0, $5, 0, $44, $ab, $82, $3d, $da, $62, $cf, $11, $ab, $39, 0, $20, $af, $71, $e4, $33,
        $29, 0, $1, 0, $9, 0, 0, 0, $6e, $56, $65, $72, $74, $69, $63, $65, $73, $14, 0, $34,
        0, $1, 0, $6, 0, 0, 0, $56, $65, $63, $74, $6f, $72, $1, 0, $8, 0, 0, 0, $76,
        $65, $72, $74, $69, $63, $65, $73, $e, 0, $1, 0, $9, 0, 0, 0, $6e, $56, $65, $72, $74,
        $69, $63, $65, $73, $f, 0, $14, 0, $29, 0, $1, 0, $6, 0, 0, 0, $6e, $46, $61, $63,
        $65, $73, $14, 0, $34, 0, $1, 0, $8, 0, 0, 0, $4d, $65, $73, $68, $46, $61, $63, $65,
        $1, 0, $5, 0, 0, 0, $66, $61, $63, $65, $73, $e, 0, $1, 0, $6, 0, 0, 0, $6e,
        $46, $61, $63, $65, $73, $f, 0, $14, 0, $e, 0, $12, 0, $12, 0, $12, 0, $f, 0, $b,
        0, $1f, 0, $1, 0, $14, 0, 0, 0, $46, $72, $61, $6d, $65, $54, $72, $61, $6e, $73, $66,
        $6f, $72, $6d, $4d, $61, $74, $72, $69, $78, $a, 0, $5, 0, $41, $3f, $f2, $f6, $86, $76, $cf,
        $11, $8f, $52, 0, $40, $33, $35, $94, $a3, $1, 0, $9, 0, 0, 0, $4d, $61, $74, $72, $69,
        $78, $34, $78, $34, $1, 0, $b, 0, 0, 0, $66, $72, $61, $6d, $65, $4d, $61, $74, $72, $69,
        $78, $14, 0, $b, 0, $1f, 0, $1, 0, $5, 0, 0, 0, $46, $72, $61, $6d, $65, $a, 0,
        $5, 0, $46, $ab, $82, $3d, $da, $62, $cf, $11, $ab, $39, 0, $20, $af, $71, $e4, $33, $e, 0,
        $12, 0, $12, 0, $12, 0, $f, 0, $b, 0, $1f, 0, $1, 0, $9, 0, 0, 0, $46, $6c,
        $6f, $61, $74, $4b, $65, $79, $73, $a, 0, $5, 0, $a9, $46, $dd, $10, $5b, $77, $cf, $11, $8f,
        $52, 0, $40, $33, $35, $94, $a3, $29, 0, $1, 0, $7, 0, 0, 0, $6e, $56, $61, $6c, $75,
        $65, $73, $14, 0, $34, 0, $2a, 0, $1, 0, $6, 0, 0, 0, $76, $61, $6c, $75, $65, $73,
        $e, 0, $1, 0, $7, 0, 0, 0, $6e, $56, $61, $6c, $75, $65, $73, $f, 0, $14, 0, $b,
        0, $1f, 0, $1, 0, $e, 0, 0, 0, $54, $69, $6d, $65, $64, $46, $6c, $6f, $61, $74, $4b,
        $65, $79, $73, $a, 0, $5, 0, $80, $b1, $6, $f4, $3b, $7b, $cf, $11, $8f, $52, 0, $40, $33,
        $35, $94, $a3, $29, 0, $1, 0, $4, 0, 0, 0, $74, $69, $6d, $65, $14, 0, $1, 0, $9,
        0, 0, 0, $46, $6c, $6f, $61, $74, $4b, $65, $79, $73, $1, 0, $6, 0, 0, 0, $74, $66,
        $6b, $65, $79, $73, $14, 0, $b, 0, $1f, 0, $1, 0, $c, 0, 0, 0, $41, $6e, $69, $6d,
        $61, $74, $69, $6f, $6e, $4b, $65, $79, $a, 0, $5, 0, $a8, $46, $dd, $10, $5b, $77, $cf, $11,
        $8f, $52, 0, $40, $33, $35, $94, $a3, $29, 0, $1, 0, $7, 0, 0, 0, $6b, $65, $79, $54,
        $79, $70, $65, $14, 0, $29, 0, $1, 0, $5, 0, 0, 0, $6e, $4b, $65, $79, $73, $14, 0,
        $34, 0, $1, 0, $e, 0, 0, 0, $54, $69, $6d, $65, $64, $46, $6c, $6f, $61, $74, $4b, $65,
        $79, $73, $1, 0, $4, 0, 0, 0, $6b, $65, $79, $73, $e, 0, $1, 0, $5, 0, 0, 0,
        $6e, $4b, $65, $79, $73, $f, 0, $14, 0, $b, 0, $1f, 0, $1, 0, $10, 0, 0, 0, $41,
        $6e, $69, $6d, $61, $74, $69, $6f, $6e, $4f, $70, $74, $69, $6f, $6e, $73, $a, 0, $5, 0, $c0,
        $56, $bf, $e2, $f, $84, $cf, $11, $8f, $52, 0, $40, $33, $35, $94, $a3, $29, 0, $1, 0, $a,
        0, 0, 0, $6f, $70, $65, $6e, $63, $6c, $6f, $73, $65, $64, $14, 0, $29, 0, $1, 0, $f,
        0, 0, 0, $70, $6f, $73, $69, $74, $69, $6f, $6e, $71, $75, $61, $6c, $69, $74, $79, $14, 0,
        $b, 0, $1f, 0, $1, 0, $9, 0, 0, 0, $41, $6e, $69, $6d, $61, $74, $69, $6f, $6e, $a,
        0, $5, 0, $4f, $ab, $82, $3d, $da, $62, $cf, $11, $ab, $39, 0, $20, $af, $71, $e4, $33, $e,
        0, $12, 0, $12, 0, $12, 0, $f, 0, $b, 0, $1f, 0, $1, 0, $c, 0, 0, 0, $41,
        $6e, $69, $6d, $61, $74, $69, $6f, $6e, $53, $65, $74, $a, 0, $5, 0, $50, $ab, $82, $3d, $da,
        $62, $cf, $11, $ab, $39, 0, $20, $af, $71, $e4, $33, $e, 0, $1, 0, $9, 0, 0, 0, $41,
        $6e, $69, $6d, $61, $74, $69, $6f, $6e, $f, 0, $b, 0, $1f, 0, $1, 0, $a, 0, 0, 0,
        $49, $6e, $6c, $69, $6e, $65, $44, $61, $74, $61, $a, 0, $5, 0, $a0, $ee, $23, $3a, $b1, $94,
        $d0, $11, $ab, $39, 0, $20, $af, $71, $e4, $33, $e, 0, $1, 0, $6, 0, 0, 0, $42, $49,
        $4e, $41, $52, $59, $f, 0, $b, 0, $1f, 0, $1, 0, $3, 0, 0, 0, $55, $72, $6c, $a,
        0, $5, 0, $a1, $ee, $23, $3a, $b1, $94, $d0, $11, $ab, $39, 0, $20, $af, $71, $e4, $33, $29,
        0, $1, 0, $5, 0, 0, 0, $6e, $55, $72, $6c, $73, $14, 0, $34, 0, $31, 0, $1, 0,
        $4, 0, 0, 0, $75, $72, $6c, $73, $e, 0, $1, 0, $5, 0, 0, 0, $6e, $55, $72, $6c,
        $73, $f, 0, $14, 0, $b, 0, $1f, 0, $1, 0, $f, 0, 0, 0, $50, $72, $6f, $67, $72,
        $65, $73, $73, $69, $76, $65, $4d, $65, $73, $68, $a, 0, $5, 0, $60, $c3, $63, $8a, $7d, $99,
        $d0, $11, $94, $1c, 0, $80, $c8, $c, $fa, $7b, $e, 0, $1, 0, $3, 0, 0, 0, $55, $72,
        $6c, $13, 0, $1, 0, $a, 0, 0, 0, $49, $6e, $6c, $69, $6e, $65, $44, $61, $74, $61, $f,
        0, $b, 0, $1f, 0, $1, 0, $4, 0, 0, 0, $47, $75, $69, $64, $a, 0, $5, 0, $e0,
        $90, $27, $a4, $10, $78, $cf, $11, $8f, $52, 0, $40, $33, $35, $94, $a3, $29, 0, $1, 0, $5,
        0, 0, 0, $64, $61, $74, $61, $31, $14, 0, $28, 0, $1, 0, $5, 0, 0, 0, $64, $61,
        $74, $61, $32, $14, 0, $28, 0, $1, 0, $5, 0, 0, 0, $64, $61, $74, $61, $33, $14, 0,
        $34, 0, $2d, 0, $1, 0, $5, 0, 0, 0, $64, $61, $74, $61, $34, $e, 0, $3, 0, $8,
        0, 0, 0, $f, 0, $14, 0, $b, 0, $1f, 0, $1, 0, $e, 0, 0, 0, $53, $74, $72,
        $69, $6e, $67, $50, $72, $6f, $70, $65, $72, $74, $79, $a, 0, $5, 0, $e0, $21, $f, $7f, $e1,
        $bf, $d1, $11, $82, $c0, 0, $a0, $c9, $69, $72, $71, $31, 0, $1, 0, $3, 0, 0, 0, $6b,
        $65, $79, $14, 0, $31, 0, $1, 0, $5, 0, 0, 0, $76, $61, $6c, $75, $65, $14, 0, $b,
        0, $1f, 0, $1, 0, $b, 0, 0, 0, $50, $72, $6f, $70, $65, $72, $74, $79, $42, $61, $67,
        $a, 0, $5, 0, $e1, $21, $f, $7f, $e1, $bf, $d1, $11, $82, $c0, 0, $a0, $c9, $69, $72, $71,
        $e, 0, $1, 0, $e, 0, 0, 0, $53, $74, $72, $69, $6e, $67, $50, $72, $6f, $70, $65, $72,
        $74, $79, $f, 0, $b, 0, $1f, 0, $1, 0, $e, 0, 0, 0, $45, $78, $74, $65, $72, $6e,
        $61, $6c, $56, $69, $73, $75, $61, $6c, $a, 0, $5, 0, $a0, $6a, $11, $98, $ba, $bd, $d1, $11,
        $82, $c0, 0, $a0, $c9, $69, $72, $71, $1, 0, $4, 0, 0, 0, $47, $75, $69, $64, $1, 0,
        $12, 0, 0, 0, $67, $75, $69, $64, $45, $78, $74, $65, $72, $6e, $61, $6c, $56, $69, $73, $75,
        $61, $6c, $14, 0, $e, 0, $12, 0, $12, 0, $12, 0, $f, 0, $b, 0, $1f, 0, $1, 0,
        $b, 0, 0, 0, $52, $69, $67, $68, $74, $48, $61, $6e, $64, $65, $64, $a, 0, $5, 0, $a0,
        $5e, $5d, $7f, $3a, $d5, $d1, $11, $82, $c0, 0, $a0, $c9, $69, $72, $71, $29, 0, $1, 0, $c,
        0, 0, 0, $62, $52, $69, $67, $68, $74, $48, $61, $6e, $64, $65, $64, $14, 0, $b, 0);



implementation

// #define MAKE_DDHRESULT( code )  MAKE_HRESULT( 1, _FACDD, code )
function MAKE_DDHRESULT(Code: DWord): DWord;
begin
  Result:= DWord((1 shl 31) or (_FACD3D shl 16)) or Code;
end;

(*
{* API for creating IDirectXFile interface.
{*)

const
  DXFileDLL = 'D3DXOF.DLL';

function DirectXFileCreate; external DXFileDLL;

end.
