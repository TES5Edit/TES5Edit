{*******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

unit wbNifScanner;

interface

uses
  Windows,
  SysUtils,
  Direct3D9;

type
  TSubsetInfo = record
    Center                  : TD3DVector;
    Radius                  : Single;
    Alpha                   : Single;
    vCount                  : Integer;
    iCount                  : Integer;
    containsTexCoords       : ByteBool;
    containsNormals         : ByteBool;
    containsColor           : ByteBool;
    containsTangentBinormal : ByteBool;
    containsTexture         : ByteBool;
    containsIndicies        : ByteBool;
    applyMode               : Byte;
    wireframe               : ByteBool;
    hasalpha                : ByteBool;
  end;

  TTexCoords = record
    u, v: Single;
  end;

  PConvertedVertex = ^TConvertedVertex;
  TConvertedVertex = record
    Position : TD3DVector;
    Tangent  : TD3DVector;
    Binormal : TD3DVector;
    Normal   : TD3DVector;
    TexCoords: TTexCoords;
    Color    : TD3DColorValue;
  end;

  TwbSubSetState = (
    sssHasInfo,
    sssHasTexture,
    sssHasMaterial,
    sssHasVerts,
    sssHasTransform,
    sssHasIndices
  );

  TwbSubSetStates = set of TwbSubSetState;

  TwbSubSet = record
    ssState      : TwbSubSetStates;
    ssInfo       : TSubsetInfo;
    ssTexture    : string;
    ssMaterial   : TD3DMaterial9;
    ssTransform  : TD3DMatrix;
    ssVerts      : array of TConvertedVertex;
    ssIndices    : array of Word;
  end;

  TwbMesh = record
    msFailedSubsets : Integer;
    msSubSets       : array of TwbSubSet;
    msMaxSize       : Single;
    msLog           : array of string;
  end;

function nsLoadMesh(aData: TBytes; out aMesh: TwbMesh): Boolean;

function nsLoaded: Boolean;
function nsUnload: Boolean;
function nsLoad: Boolean;

implementation

uses
  Classes;

type
  TLoadReturn = record
    Subsets       : Cardinal;
    FailedSubsets : Integer;
    MaxSize       : Single;
    Log           : PChar;
  end;

  TwbNifScannerLoad = function(Data: Pointer; Size: Integer): TLoadReturn; stdcall;
  TwbNifScannerGetInfo = function(ID: Cardinal; out Info: TSubsetInfo): LongBool; stdcall;
  TwbNifScannerGetTex = function(ID: Cardinal; out Texture: PChar): LongBool; stdcall;
  TwbNifScannerGetMaterial = function(ID: Cardinal; out Material: TD3DMaterial9): LongBool; stdcall;
  TwbNifScannerGetVerticies = function(ID: Cardinal; Verticies: PConvertedVertex): LongBool; stdcall;
  TwbNifScannerGetTransform = function(ID: Cardinal; out Matrix: TD3DMatrix): LongBool; stdcall;
  TwbNifScannerGetIndicies = function(ID: Cardinal; Strip: PShortInt): LongBool; stdcall;

var
  _Load         : TwbNifScannerLoad;
  _GetInfo      : TwbNifScannerGetInfo;
  _GetTex       : TwbNifScannerGetTex;
  _GetMaterial  : TwbNifScannerGetMaterial;
  _GetVerticies : TwbNifScannerGetVerticies;
  _GetTransform : TwbNifScannerGetTransform;
  _GetIndicies  : TwbNifScannerGetIndicies;

var
  NifScannerLib: THandle = 0;

function nsLoaded: Boolean;
begin
  Result:= NifScannerLib <> 0;
end;

function nsUnload: Boolean;
begin
  Result:= True;
  if nsLoaded then begin
    Result         := FreeLibrary(NifScannerLib);
    _Load         := nil;
    _GetInfo      := nil;
    _GetTex       := nil;
    _GetMaterial  := nil;
    _GetVerticies := nil;
    _GetTransform := nil;
    _GetIndicies  := nil;
    NifScannerLib  := 0;
  end;
end;

function nsLoad: Boolean;
begin
  Result:= nsLoaded;
  if not Result then begin
    NifScannerLib:= SafeLoadLibrary('NifScanner.dll');
    if nsLoaded then begin
      _Load := GetProcAddress(NifScannerLib, 'Load');
      _GetInfo := GetProcAddress(NifScannerLib, 'GetInfo');
      _GetTex := GetProcAddress(NifScannerLib, 'GetTex');
      _GetMaterial := GetProcAddress(NifScannerLib, 'GetMaterial');
      _GetVerticies := GetProcAddress(NifScannerLib, 'GetVerticies');
      _GetTransform := GetProcAddress(NifScannerLib, 'GetTransform');
      _GetIndicies := GetProcAddress(NifScannerLib, 'GetIndicies');
      Result:=
        Assigned(_Load) and
        Assigned(_GetInfo) and
        Assigned(_GetTex) and
        Assigned(_GetMaterial) and
        Assigned(_GetVerticies) and
        Assigned(_GetTransform) and
        Assigned(_GetIndicies);
      if not Result then
        nsUnload;
    end;
  end;
end;

function nsLoadMesh(aData: TBytes; out aMesh: TwbMesh): Boolean;
var
  i: Integer;
  p: PChar;
begin
  aMesh.msFailedSubsets := 0;
  aMesh.msSubsets := nil;
  aMesh.msMaxSize := 0;
  aMesh.msLog := nil;

  Result := nsLoad;
  if not Result then
    Exit;
  if Length(aData) < 1 then
    Exit;

  with TStringList.Create do try
    with aMesh, _Load(@aData[0], Length(aData)) do begin
      msFailedSubsets := FailedSubsets;
      msMaxSize := MaxSize;
      SetLength(msSubSets, Subsets);

      for i:= Low(msSubSets) to High(msSubSets) do
        with msSubSets[i] do begin

          if _GetInfo(i, ssInfo) then
            Include(ssState, sssHasInfo);

          if _GetTex(i, p) then begin
            ssTexture := p;
            Include(ssState, sssHasTexture);
          end;

          if _GetMaterial(i, ssMaterial) then
            Include(ssState, sssHasMaterial);

          if _GetTransform(i, ssTransform) then
            Include(ssState, sssHasTransform);

          if sssHasInfo in ssState then begin

            SetLength(ssVerts, ssInfo.vCount+1);
            if Length(ssVerts) > 0 then
              if _GetVerticies(i, @ssVerts[0]) then begin
                Include(ssState, sssHasVerts);
                SetLength(ssVerts, ssInfo.vCount);
              end else
                ssVerts := nil;

            SetLength(ssIndices, ssInfo.iCount+1);
            if Length(ssIndices) > 0 then
              if _GetIndicies(i, @ssIndices[0]) then begin
                Include(ssState, sssHasIndices);
                SetLength(ssIndices, ssInfo.iCount);
              end else
                ssIndices := nil;

          end;

        end;

      Text := Log;
      SetLength(msLog, Count);
      for i := 0 to Pred(Count) do
        msLog[i] := Strings[i];
    end;
  finally
    Free;
  end;
end;

end.
