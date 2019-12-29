{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbDataFormatMaterial;

interface

uses
  SysUtils, wbDataFormat, wbDataFormatNifTypes, JsonDataObjects;

type
  TwbBGSMFile = class(TdfStruct)
    constructor Create; reintroduce; overload;
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override;
    procedure FromJSON(const aText: string); override;
    function ToJSON(aCompact: Boolean): string; override;
  end;

  TwbBGEMFile = class(TdfStruct)
    constructor Create; reintroduce; overload;
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override;
    procedure FromJSON(const aText: string); override;
    function ToJSON(aCompact: Boolean): string; override;
  end;

implementation

type
  TMagic = array [0..3] of AnsiChar;
  PMagic = ^TMagic;

const
  sMagicBGSM: TMagic = 'BGSM';
  sMagicBGEM: TMagic = 'BGEM';

var
  dfBGSM: TdfStructDef;
  dfBGEM: TdfStructDef;

  jsBaseMap: array [1..44] of string = (
    'fUOffset', 'UOffset',
    'fVOffset', 'VOffset',
    'fUScale', 'UScale',
    'fVScale', 'VScale',
    'fAlpha', 'Alpha',
    'eAlphaBlendMode', 'AlphaBlendMode',
    'fAlphaTestRef', 'AlphaTestRef',
    'bAlphaTest', 'AlphaTest',
    'bZBufferWrite', 'ZBufferWrite',
    'bZBufferTest', 'ZBufferTest',
    'bScreenSpaceReflections', 'ScreenSpaceReflections',
    'bWetnessControl_ScreenSpaceReflections', 'WetnessControlScreenSpaceReflections',
    'bDecal', 'Decal',
    'bTwoSided', 'TwoSided',
    'bDecalNoFade', 'DecalNoFade',
    'bNonOccluder', 'NonOccluder',
    'bRefraction', 'Refraction',
    'bRefractionFalloff', 'RefractionFalloff',
    'fRefractionPower', 'RefractionPower',
    'bEnvironmentMapping', 'EnvironmentMapping',
    'fEnvironmentMappingMaskScale', 'EnvironmentMappingMaskScale',
    'bGrayscaleToPaletteColor', 'GrayscaleToPaletteColor'
  );
  jsShaderMap: array [1..110] of string = (
    'sDiffuseTexture', 'Textures\Diffuse',
    'sNormalTexture', 'Textures\Normal',
    'sSmoothSpecTexture', 'Textures\SmoothSpec',
    'sGreyscaleTexture', 'Textures\Grayscale', // yes, "grEyscale" for some reason
    'sEnvmapTexture', 'Textures\Envmap',
    'sGlowTexture', 'Textures\Glow',
    'sInnerLayerTexture', 'Textures\InnerLayer',
    'sWrinklesTexture', 'Textures\Wrinkles',
    'sDisplacementTexture', 'Textures\Displacement',
    'bEnableEditorAlphaRef', 'EnableEditorAlphaRef',
    'bRimLighting', 'RimLighting',
    'fRimPower', 'RimPower',
    'fBackLightPower', 'BackLightPower',
    'bSubsurfaceLighting', 'SubsurfaceLighting',
    'fSubsurfaceLightingRolloff', 'SubsurfaceLightingRolloff',
    'bSpecularEnabled', 'SpecularEnabled',
    'cSpecularColor', 'SpecularColor',
    'fSpecularMult', 'SpecularMult',
    'fSmoothness', 'Smoothness',
    'fFresnelPower', 'FresnelPower',
    'fWetnessControl_SpecScale', 'WetnessControlSpecScale',
    'fWetnessControl_SpecPowerScale', 'WetnessControlSpecPowerScale',
    'fWetnessControl_SpecMinvar', 'WetnessControlSpecMinvar',
    'fWetnessControl_EnvMapScale', 'WetnessControlEnvMapScale',
    'fWetnessControl_FresnelPower', 'WetnessControlFresnelPower',
    'fWetnessControl_Metalness', 'WetnessControlMetalness',
    'sRootMaterialPath', 'RootMaterialPath',
    'bAnisoLighting', 'AnisoLighting',
    'bEmitEnabled', 'EmitEnabled',
    'cEmittanceColor', 'EmittanceColor',
    'fEmittanceMult', 'EmittanceMult',
    'bModelSpaceNormals', 'ModelSpaceNormals',
    'bExternalEmittance', 'ExternalEmittance',
    'bBackLighting', 'BackLighting',
    'bReceiveShadows', 'ReceiveShadows',
    'bHideSecret', 'HideSecret',
    'bCastShadows', 'CastShadows',
    'bDissolveFade', 'DissolveFade',
    'bAssumeShadowmask', 'AssumeShadowmask',
    'bGlowmap', 'Glowmap',
    'bEnvironmentMappingWindow', 'EnvironmentMappingWindow',
    'bEnvironmentMappingEye', 'EnvironmentMappingEye',
    'bHair', 'Hair',
    'cHairTintColor', 'HairTintColor',
    'bTree', 'Tree',
    'bFacegen', 'Facegen',
    'bSkinTint', 'SkinTint',
    'bTessellate', 'Tessellate',
    'fDisplacementTextureBias', 'DisplacementTextureBias',
    'fDisplacementTextureScale', 'DisplacementTextureScale',
    'fTessellationPnScale', 'TessellationPnScale',
    'fTessellationBaseFactor', 'TessellationBaseFactor',
    'fTessellationFadeDistance', 'TessellationFadeDistance',
    'fGrayscaleToPaletteScale', 'GrayscaleToPaletteScale',
    'bSkewSpecularAlpha', 'SkewSpecularAlpha'
  );
  jsEffectMap: array [1..40] of string = (
    'sBaseTexture', 'Textures\Base',
    'sGrayscaleTexture', 'Textures\Grayscale',
    'sEnvmapTexture', 'Textures\Envmap',
    'sNormalTexture', 'Textures\Normal',
    'sEnvmapMaskTexture', 'Textures\EnvmapMask',
    'bBloodEnabled', 'BloodEnabled',
    'bEffectLightingEnabled', 'EffectLightingEnabled',
    'bFalloffEnabled', 'FalloffEnabled',
    'bFalloffColorEnabled', 'FalloffColorEnabled',
    'bGrayscaleToPaletteAlpha', 'GrayscaleToPaletteAlpha',
    'bSoftEnabled', 'SoftEnabled',
    'cBaseColor', 'BaseColor',
    'fBaseColorScale', 'BaseColorScale',
    'fFalloffStartAngle', 'FalloffStartAngle',
    'fFalloffStopAngle', 'FalloffStopAngle',
    'fFalloffStartOpacity', 'FalloffStartOpacity',
    'fFalloffStopOpacity', 'FalloffStopOpacity',
    'fLightingInfluence', 'LightingInfluence',
    'iEnvmapMinLOD', 'EnvmapMinLOD',
    'fSoftDepth', 'SoftDepth'
  );


procedure LenStringZ_SetText(const aElement: TdfElement; var aText: string);
begin
  // file names should be using '/' slashes only
  // and not start with 'materials'
  // at least vanilla materials follow such rules
  aText := StringReplace(aText, '\', '/', [rfReplaceAll]);

  if SameText(Copy(aText, 1, 10), 'materials/') then
    aText := Copy(aText, 11, Length(aText));
end;

function wbLenStringZ(const aName: string): TdfDef;
begin
  Result := dfChars(aName, -4, '', #0, True, []);
  Result.OnSetText := @LenStringZ_SetText;
end;

{
http://www.andersriggelsen.dk/glblendfunc.php

Blend SrcAlpha OneMinusSrcAlpha // Traditional transparency
Blend One OneMinusSrcAlpha // Premultiplied transparency
Blend One One // Additive
Blend OneMinusDstColor One // Soft Additive
Blend DstColor Zero // Multiplicative
Blend DstColor SrcColor // 2x Multiplicative
I don't know if "Multiplicative" in the options is One OneMinusSrcAlpha or DstColor Zero
}
procedure BGSMGetAlphaBlendValue(const aElement: TdfElement; var aValue: Variant);
var
  a, b, c: Integer;
begin
  a := aElement.NativeValues['..\AlphaBlendMode0'];
  b := aElement.NativeValues['..\AlphaBlendMode1'];
  c := aElement.NativeValues['..\AlphaBlendMode2'];

  if (a = 0) and (b = 6) and (c = 7) then aValue := 0 else
  if (a = 0) and (b = 0) and (c = 0) then aValue := 1 else
  if (a = 1) and (b = 6) and (c = 7) then aValue := 2 else
  if (a = 1) and (b = 6) and (c = 0) then aValue := 3 else
  if (a = 1) and (b = 4) and (c = 1) then aValue := 4;
end;

procedure BGSMSetAlphaBlendValue(const aElement: TdfElement; var aValue: Variant);
var
  i, a, b, c: Integer;
begin
  i := aValue; a := 0; b := 0; c := 0;
  if i = 0 then begin a := 0; b := 6; c := 7; end else
  if i = 1 then begin a := 0; b := 0; c := 0; end else
  if i = 2 then begin a := 1; b := 6; c := 7; end else
  if i = 3 then begin a := 1; b := 6; c := 0; end else
  if i = 4 then begin a := 1; b := 4; c := 1; end;

  aElement.NativeValues['..\AlphaBlendMode0'] := a;
  aElement.NativeValues['..\AlphaBlendMode1'] := b;
  aElement.NativeValues['..\AlphaBlendMode2'] := c;
end;

function BGSMEmittanceEnabled(const aElement: TdfElement): Boolean;
begin
  Result := aElement.NativeValues['..\EmitEnabled'] <> 0;
end;

function BGSMSkewAlphaEnabled(const aElement: TdfElement): Boolean;
begin
  Result := aElement.NativeValues['.\Version'] >= 1;
end;

procedure wbDefineMaterial;
var
  dfBaseMaterial: TdfStructDef;
begin
  if Assigned(dfBGSM) then
    Exit;

  dfBaseMaterial := dfStruct('Base Material', [
    dfFlags('TileFlags', dtU32, [
      0, 'V',
      1, 'U'
    ]),
    dfFloat('UOffset'),
    dfFloat('VOffset'),
    dfFloat('UScale', '1.0'),
    dfFloat('VScale',  '1.0'),
    dfFloat('Alpha', '1.0'),
    dfEnum('AlphaBlendMode', dtNone, [
      0, 'Unknown',
      1, 'None',
      2, 'Standard',
      3, 'Additive',
      4, 'Multiplicative'
    ], 'Unknown', [
      DF_OnGetValue, @BGSMGetAlphaBlendValue,
      DF_OnSetValue, @BGSMSetAlphaBlendValue
    ]),
    dfInteger('AlphaBlendMode0', dtU8),
    dfInteger('AlphaBlendMode1', dtU32),
    dfInteger('AlphaBlendMode2', dtU32),
    dfInteger('AlphaTestRef', dtU8),
    dfBool('AlphaTest', dtU8),
    dfBool('ZBufferWrite', dtU8, 'yes'),
    dfBool('ZBufferTest', dtU8, 'yes'),
    dfBool('ScreenSpaceReflections', dtU8),
    dfBool('WetnessControlScreenSpaceReflections', dtU8),
    dfBool('Decal', dtU8),
    dfBool('TwoSided', dtU8),
    dfBool('DecalNoFade', dtU8),
    dfBool('NonOccluder', dtU8),
    dfBool('Refraction', dtU8),
    dfBool('RefractionFalloff', dtU8),
    dfFloat('RefractionPower'),
    dfBool('EnvironmentMapping', dtU8),
    dfFloat('EnvironmentMappingMaskScale', '1.0'),
    dfBool('GrayscaleToPaletteColor', dtU8)
  ]);

  dfBGSM := dfStruct('BGSM', [
    dfChars('Magic', 4, 'BGSM', #0, False, []),
    dfInteger('Version', dtU32, '2'),
    // base material goes here
    dfStruct('Textures', [
      wbLenStringZ('Diffuse'),
      wbLenStringZ('Normal'),
      wbLenStringZ('SmoothSpec'),
      wbLenStringZ('Grayscale'),
      wbLenStringZ('Envmap'),
      wbLenStringZ('Glow'),
      wbLenStringZ('Inner Layer'),
      wbLenStringZ('Wrinkes'),
      wbLenStringZ('Displacement')
    ]),
    dfBool('EnableEditorAlphaRef', dtU8),
    dfBool('RimLighting', dtU8),
    dfFloat('RimPower'),
    dfFloat('BackLightPower'),
    dfBool('SurfaceLighting', dtU8),
    dfFloat('SubsurfaceLightingRolloff'),
    dfBool('SpecularEnabled', dtU8),
    wbColor3('SpecularColor'),
    dfFloat('SpecularMult'),
    dfFloat('Smoothness', '1.0'),
    dfFloat('FresnelPower', '5.0'),
    dfFloat('WetnessControlSpecScale', '-1.0'),
    dfFloat('WetnessControlSpecPowerScale', '-1.0'),
    dfFloat('WetnessControlSpecMinvar', '-1.0'),
    dfFloat('WetnessControlEnvMapScale', '-1.0'),
    dfFloat('WetnessControlFresnelPower', '-1.0'),
    dfFloat('WetnessControlMetalness', '-1.0'),
    wbLenStringZ('RootMaterialPath'),
    dfBool('AnisoLighting', dtU8),
    dfBool('EmitEnabled', dtU8),
    wbColor3('EmittanceColor', [DF_OnGetEnabled, @BGSMEmittanceEnabled]),
    dfFloat('EmittanceMult', '1.0'),
    dfBool('ModelSpaceNormals', dtU8),
    dfBool('ExternalEmittance', dtU8),
    dfBool('BackLighting', dtU8),
    dfBool('ReceiveShadows', dtU8),
    dfBool('HideSecret', dtU8),
    dfBool('CastShadows', dtU8),
    dfBool('DissolveFade', dtU8),
    dfBool('AssumeShadowmask', dtU8),
    dfBool('Glowmap', dtU8),
    dfBool('EnvironmentMappingWindow', dtU8),
    dfBool('EnvironmentMappingEye', dtU8),
    dfBool('Hair', dtU8),
    wbColor3('HairTintColor', '#808080', []),
    dfBool('Tree', dtU8),
    dfBool('Facegen', dtU8),
    dfBool('SkinTint', dtU8),
    dfBool('Tessellate', dtU8),
    dfFloat('DisplacementTextureBias'),
    dfFloat('DisplacementTextureScale'),
    dfFloat('TessellationPNScale'),
    dfFloat('TessellationBaseFactor'),
    dfFloat('TessellationFadeDistance'),
    dfFloat('GrayscaleToPaletteScale', '1.0'),
    dfBool('SkewSpecularAlpha', dtU8, [DF_OnGetEnabled, @BGSMSkewAlphaEnabled])
  ]);

  dfBGEM := dfStruct('BGEM', [
    dfChars('Magic', 4, 'BGEM', #0, False, []),
    dfInteger('Version', dtU32, '2'),
    // base material goes here
    dfStruct('Textures', [
      wbLenStringZ('Base'),
      wbLenStringZ('Grayscale'),
      wbLenStringZ('Envmap'),
      wbLenStringZ('Normal'),
      wbLenStringZ('EnvmapMask')
    ]),
    dfBool('BloodEnabled', dtU8),
    dfBool('EffectLightingEnabled', dtU8),
    dfBool('FalloffEnabled', dtU8),
    dfBool('FalloffColorEnabled', dtU8),
    dfBool('GrayscaleToPaletteAlpha', dtU8),
    dfBool('SoftEnabled', dtU8),
    wbColor3('BaseColor'),
    dfFloat('BaseColorScale', '1.0'),
    dfFloat('FalloffStartAngle'),
    dfFloat('FalloffStopAngle'),
    dfFloat('FalloffStartOpacity'),
    dfFloat('FalloffStopOpacity'),
    dfFloat('LightingInfluence', '1.0'),
    dfInteger('EnvmapMinLOD', dtU8),
    dfFloat('SoftDepth', '100.0')
  ]);

  dfBGSM.InsertDefsFrom(dfBaseMaterial, 2);
  dfBGEM.InsertDefsFrom(dfBaseMaterial, 2);
  dfBaseMaterial.Free;
end;

function b2i(b: Boolean): Integer; inline;
begin
  if b then Result := 1 else Result := 0;
end;

procedure ReadJSONValue(e: TdfElement; json: TJSONObject; const js, el: string);
begin
  if json.Contains(js) then
    case js[1] of
      'b': e.NativeValues[el] := b2i(json.B[js]);
      'f': e.NativeValues[el] := json.F[js];
      'i': e.NativeValues[el] := json.I[js];
    else
      e.EditValues[el] := json.S[js];
    end;
end;

procedure BaseMaterialFromJSON(e: TdfElement; json: TJSONObject);
var
  i: integer;
begin
  if json.Contains('bTileU') then e.Elements['TileFlags'].NativeValues['U'] := b2i(json.B['bTileU']);
  if json.Contains('bTileV') then e.Elements['TileFlags'].NativeValues['V'] := b2i(json.B['bTileV']);
  for i := 1 to Length(jsBaseMap) div 2 do
    ReadJSONValue(e, json, jsBaseMap[i*2-1], jsBaseMap[i*2]);
end;

procedure ShaderMaterialFromJSON(e: TdfElement; json: TJSONObject);
var
  i: integer;
begin
  for i := 1 to Length(jsShaderMap) div 2 do
    ReadJSONValue(e, json, jsShaderMap[i*2-1], jsShaderMap[i*2]);
end;

procedure EffectMaterialFromJSON(e: TdfElement; json: TJSONObject);
var
  i: integer;
begin
  for i := 1 to Length(jsEffectMap) div 2 do
    ReadJSONValue(e, json, jsEffectMap[i*2-1], jsEffectMap[i*2]);
end;

constructor TwbBGSMFile.Create;
begin
  wbDefineMaterial;
  inherited Create(dfBGSM, nil);
end;

function TwbBGSMFile.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
var
  json: TJsonBaseObject;
begin
  Result := PByte(aDataEnd) - PByte(aDataStart);

  // data can be either binary or json, need to detect that
  if (aDataStart = nil) or ((Result > SizeOf(TMagic)) and (PMagic(aDataStart)^ = sMagicBGSM)) then
    Result := inherited
  else begin
    json := TJsonBaseObject.ParseUtf8Bytes(aDataStart, Result);
    try
      SetToDefault;
      if json is TJsonObject then begin
        BaseMaterialFromJSON(Self, TJsonObject(json));
        ShaderMaterialFromJSON(Self, TJsonObject(json));
      end;
    finally
      json.Free;
    end;
  end;
end;

procedure TwbBGSMFile.FromJSON(const aText: string);
var
  json: TJSONObject;
begin
  json := TJSONObject.Create;
  try
    json.FromJSON(aText);
    SetToDefault;
    BaseMaterialFromJSON(Self, json);
    ShaderMaterialFromJSON(Self, json);
  finally
    json.Free;
  end;
end;

function TwbBGSMFile.ToJSON(aCompact: Boolean): string;
begin
  // no need to save materials in json
  raise Exception.Create('Not implemented');
end;

constructor TwbBGEMFile.Create;
begin
  wbDefineMaterial;
  inherited Create(dfBGEM, nil);
end;

function TwbBGEMFile.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
var
  json: TJsonBaseObject;
begin
  Result := PByte(aDataEnd) - PByte(aDataStart);

  // data can be either binary or json, need to detect that
  if (aDataStart = nil) or ((Result > SizeOf(TMagic)) and (PMagic(aDataStart)^ = sMagicBGEM)) then
    Result := inherited
  else begin
    json := TJsonBaseObject.ParseUtf8Bytes(aDataStart, Result);
    try
      SetToDefault;
      if json is TJsonObject then begin
        BaseMaterialFromJSON(Self, TJsonObject(json));
        EffectMaterialFromJSON(Self, TJsonObject(json));
      end;
    finally
      json.Free;
    end;
  end;
end;

procedure TwbBGEMFile.FromJSON(const aText: string);
var
  json: TJSONObject;
begin
  json := TJSONObject.Create;
  try
    json.FromJSON(aText);
    SetToDefault;
    BaseMaterialFromJSON(Self, json);
    EffectMaterialFromJSON(Self, json);
  finally
    json.Free;
  end;
end;

function TwbBGEMFile.ToJSON(aCompact: Boolean): string;
begin
  raise Exception.Create('Not implemented');
end;


initialization

finalization

  FreeAndNil(dfBGSM);
  FreeAndNil(dfBGEM);

end.

