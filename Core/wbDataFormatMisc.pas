{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbDataFormatMisc;

interface

uses
  wbDataFormat;

type
  // LOD settings file *.lod for Skyrim, SSE and FO4
  TwbLODSettingsTES5File = class(TdfStruct)
    constructor Create; reintroduce; overload;
  end;

  // LOD settings file *.dlossettings for FO3 and FNV
  TwbLODSettingsFO3File = class(TdfStruct)
    constructor Create; reintroduce; overload;
  end;

  // Tree LOD index file (*.LST in Skyrim, SSE, Fallout3 and New Vegas)
  TwbLODTreeLSTFile = class(TdfArray)
    constructor Create; reintroduce; overload;
  end;

  // Tree LOD references file (*.BTT in Skyrim and SSE, *.DTL in Fallout3 and New Vegas)
  TwbLODTreeBTTFile = class(TdfArray)
    constructor Create; reintroduce; overload;
  end;

  // Tree LOD references file (*.BTT in Skyrim and SSE, *.DTL in Fallout3 and New Vegas)
  TwbFUZFile = class(TdfStruct)
    constructor Create; reintroduce; overload;
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override; final;
  end;

  // DDS file
  TwbDDSFile = class(TdfStruct)
    constructor Create; reintroduce; overload;
  end;

implementation

uses
  System.SysUtils;

var
  dfLODSettingsTES5: TdfStructDef;
  dfLODSettingsFO3: TdfStructDef;
  dfLODTreeLST: TdfArrayDef;
  dfLODTreeBTT: TdfArrayDef;
  dfFUZ: TdfStructDef;
  dfDDS: TdfStructDef;

procedure FUZ_GetLIPSize(const e: TdfElement; var aCount: Integer); begin aCount := e.NativeValues['..\LIP Size']; end;
procedure FUZ_BeforeSaveLIPSize(const e: TdfElement); begin e.NativeValue := e.Elements['..\LIP Data'].DataSize; end;
function DDS_EnDX10(const e: TdfElement): Boolean; begin var s := e.EditValues['..\HEADER\ddspf\dwFourCC']; Result := (s = 'DX10') or (s = 'XBOX'); end;
function DDS_EnXBOX(const e: TdfElement): Boolean; begin var s := e.EditValues['..\HEADER\ddspf\dwFourCC']; Result := s = 'XBOX'; end;

procedure GetTextFourCC(const aElement: TdfElement; var aText: string);
begin
  if aText = #0#0#0#0 then
    aText := '';
end;

procedure SetTextFourCC(const aElement: TdfElement; var aText: string);
begin
  if aText = '' then
    aText := #0#0#0#0;
end;

procedure wbDefineMisc;
begin
  if Assigned(dfLODTreeLst) then
    Exit;

  dfLODSettingsTES5 := dfStruct('LOD', [
    dfInteger('Min X', dtS16),
    dfInteger('Min Y', dtS16),
    dfInteger('Stride', dtU16),
    dfInteger('Min Level', dtU16),
    dfInteger('Max Level', dtU16)
  ]);

  dfLODSettingsFO3 := dfStruct('LOD', [
    dfInteger('Min Terrain Level', dtU32),
    dfInteger('Max Terrain Level', dtU32),
    dfInteger('Stride', dtU32),
    dfInteger('Min X', dtS16),
    dfInteger('Min Y', dtS16),
    dfInteger('Max X', dtS16),
    dfInteger('Max Y', dtS16),
    dfInteger('Object Level', dtU32)
  ]);

  dfLODTreeLST :=
    dfArray('Trees', dfStruct('Tree', [
      dfInteger('Type', dtU32),
      dfFloat('Width'),
      dfFloat('Height'),
      dfStruct('Atlas Position', [
        dfStruct('Min', [
          dfFloat('U'),
          dfFloat('V')
        ]),
        dfStruct('Max', [
          dfFloat('U'),
          dfFloat('V')
        ])
      ]),
      dfInteger('Unknown', dtU32)
    ]), -4);

  dfLODTreeBTT :=
    dfArray('Trees', dfStruct('Tree', [
      dfInteger('Type', dtU32),
      dfArray('References', dfStruct('Reference', [
        dfFloat('X'),
        dfFloat('Y'),
        dfFloat('Z'),
        dfFloat('Rotation'),
        dfFloat('Scale', '1.0'),
        dfHexInteger('FormID', dtU32),
        dfInteger('Unknown 1', dtU32),
        dfInteger('Unknown 2', dtU32)
      ]), -4)
    ]), -4);

  dfFUZ := dfStruct('FUZ', [
    dfChars('Magic', 4, 'FUZE', #0, False, []),
    dfInteger('Version', dtU32, '1'),
    // keeping LIP Size separate from data so LoadFromFile/SaveToFile can be used directly on LIP Data
    dfInteger('LIP Size', dtU32, [DF_OnBeforeSave, @FUZ_BeforeSaveLIPSize]),
    dfBytes('LIP Data', 0, [DF_OnGetCount, @FUZ_GetLIPSize]),
    dfBytes('XWM Data', 0)
  ]);

  dfDDS := dfStruct('DDS', [
    dfChars('Magic', 4, 'DDS', #0, False, []),
    dfStruct('HEADER', [
      dfInteger('dwSize', dtU32),
      dfFlags('dwFlags', dtU32, [
         0, 'DDSD_CAPS',
         1, 'DDSD_HEIGHT',
         2, 'DDSD_WIDTH',
         3, 'DDSD_PITCH',
        12, 'DDSD_PIXELFORMAT',
        17, 'DDSD_MIPMAPCOUNT',
        19, 'DDSD_LINEARSIZE',
        23, 'DDSD_DEPTH'
      ]),
      dfInteger('dwHeight', dtU32),
      dfInteger('dwWidth', dtU32),
      dfInteger('dwPitchOrLinearSize', dtU32),
      dfInteger('dwDepth', dtU32),
      dfInteger('dwMipMapCount', dtU32),
      dfBytes('dwReserved1', 11 * SizeOf(LongWord)),
      dfStruct('ddspf', [
        dfInteger('dwSize', dtU32),
        dfFlags('dwFlags', dtU32, [
           0, 'DDPF_ALPHAPIXELS',
           1, 'DDPF_ALPHA',
           2, 'DDPF_FOURCC',
           6, 'DDPF_RGB',
           9, 'DDPF_YUV',
          17, 'DDPF_LUMINANCE'
        ]),
        dfChars('dwFourCC', 4, '', #0, False, [])
          .SetOnGetText(GetTextFourCC)
          .SetOnSetText(SetTextFourCC),
        dfInteger('dwRGBBitCount', dtU32),
        dfHexInteger('dwRBitMask', dtU32),
        dfHexInteger('dwGBitMask', dtU32),
        dfHexInteger('dwBBitMask', dtU32),
        dfHexInteger('dwABitMask', dtU32)
      ]),
      dfFlags('dwCaps', dtU32, [
         3, 'DDSCAPS_COMPLEX',
        12, 'DDSCAPS_TEXTURE',
        22, 'DDSCAPS_MIPMAP'
      ]),
      dfFlags('dwCaps2', dtU32, [
         9, 'DDSCAPS2_CUBEMAP',
        10, 'DDSCAPS2_CUBEMAP_POSITIVEX',
        11, 'DDSCAPS2_CUBEMAP_NEGATIVEX',
        12, 'DDSCAPS2_CUBEMAP_POSITIVEY',
        13, 'DDSCAPS2_CUBEMAP_NEGATIVEY',
        14, 'DDSCAPS2_CUBEMAP_POSITIVEZ',
        15, 'DDSCAPS2_CUBEMAP_NEGATIVEZ',
        21, 'DDSCAPS2_VOLUME'
      ]),
      dfInteger('dwCaps3', dtU32),
      dfInteger('dwCaps4', dtU32),
      dfInteger('dwReserved2', dtU32)
    ]),
    dfStruct('HEADER_DXT10', [
      dfEnum('dxgiFormat', dtS32, [
        0, 'UNKNOWN',
        1, 'R32G32B32A32_TYPELESS',
        2, 'R32G32B32A32_FLOAT',
        3, 'R32G32B32A32_UINT',
        4, 'R32G32B32A32_SINT',
        5, 'R32G32B32_TYPELESS',
        6, 'R32G32B32_FLOAT',
        7, 'R32G32B32_UINT',
        8, 'R32G32B32_SINT',
        9, 'R16G16B16A16_TYPELESS',
        10, 'R16G16B16A16_FLOAT',
        11, 'R16G16B16A16_UNORM',
        12, 'R16G16B16A16_UINT',
        13, 'R16G16B16A16_SNORM',
        14, 'R16G16B16A16_SINT',
        15, 'R32G32_TYPELESS',
        16, 'R32G32_FLOAT',
        17, 'R32G32_UINT',
        18, 'R32G32_SINT',
        19, 'R32G8X24_TYPELESS',
        20, 'D32_FLOAT_S8X24_UINT',
        21, 'R32_FLOAT_X8X24_TYPELESS',
        22, 'X32_TYPELESS_G8X24_UINT',
        23, 'R10G10B10A2_TYPELESS',
        24, 'R10G10B10A2_UNORM',
        25, 'R10G10B10A2_UINT',
        26, 'R11G11B10_FLOAT',
        27, 'R8G8B8A8_TYPELESS',
        28, 'R8G8B8A8_UNORM',
        29, 'R8G8B8A8_UNORM_SRGB',
        30, 'R8G8B8A8_UINT',
        31, 'R8G8B8A8_SNORM',
        32, 'R8G8B8A8_SINT',
        33, 'R16G16_TYPELESS',
        34, 'R16G16_FLOAT',
        35, 'R16G16_UNORM',
        36, 'R16G16_UINT',
        37, 'R16G16_SNORM',
        38, 'R16G16_SINT',
        39, 'R32_TYPELESS',
        40, 'D32_FLOAT',
        41, 'R32_FLOAT',
        42, 'R32_UINT',
        43, 'R32_SINT',
        44, 'R24G8_TYPELESS',
        45, 'D24_UNORM_S8_UINT',
        46, 'R24_UNORM_X8_TYPELESS',
        47, 'X24_TYPELESS_G8_UINT',
        48, 'R8G8_TYPELESS',
        49, 'R8G8_UNORM',
        50, 'R8G8_UINT',
        51, 'R8G8_SNORM',
        52, 'R8G8_SINT',
        53, 'R16_TYPELESS',
        54, 'R16_FLOAT',
        55, 'D16_UNORM',
        56, 'R16_UNORM',
        57, 'R16_UINT',
        58, 'R16_SNORM',
        59, 'R16_SINT',
        60, 'R8_TYPELESS',
        61, 'R8_UNORM',
        62, 'R8_UINT',
        63, 'R8_SNORM',
        64, 'R8_SINT',
        65, 'A8_UNORM',
        66, 'R1_UNORM',
        67, 'R9G9B9E5_SHAREDEXP',
        68, 'R8G8_B8G8_UNORM',
        69, 'G8R8_G8B8_UNORM',
        70, 'BC1_TYPELESS',
        71, 'BC1_UNORM',
        72, 'BC1_UNORM_SRGB',
        73, 'BC2_TYPELESS',
        74, 'BC2_UNORM',
        75, 'BC2_UNORM_SRGB',
        76, 'BC3_TYPELESS',
        77, 'BC3_UNORM',
        78, 'BC3_UNORM_SRGB',
        79, 'BC4_TYPELESS',
        80, 'BC4_UNORM',
        81, 'BC4_SNORM',
        82, 'BC5_TYPELESS',
        83, 'BC5_UNORM',
        84, 'BC5_SNORM',
        85, 'B5G6R5_UNORM',
        86, 'B5G5R5A1_UNORM',
        87, 'B8G8R8A8_UNORM',
        88, 'B8G8R8X8_UNORM',
        89, 'R10G10B10_XR_BIAS_A2_UNORM',
        90, 'B8G8R8A8_TYPELESS',
        91, 'B8G8R8A8_UNORM_SRGB',
        92, 'B8G8R8X8_TYPELESS',
        93, 'B8G8R8X8_UNORM_SRGB',
        94, 'BC6H_TYPELESS',
        95, 'BC6H_UF16',
        96, 'BC6H_SF16',
        97, 'BC7_TYPELESS',
        98, 'BC7_UNORM',
        99, 'BC7_UNORM_SRGB',
        100, 'AYUV',
        101, 'Y410',
        102, 'Y416',
        103, 'NV12',
        104, 'P010',
        105, 'P016',
        106, '420_OPAQUE',
        107, 'YUY2',
        108, 'Y210',
        109, 'Y216',
        110, 'NV11',
        111, 'AI44',
        112, 'IA44',
        113, 'P8',
        114, 'A8P8',
        115, 'B4G4R4A4_UNORM',
        130, 'P208',
        131, 'V208',
        132, 'V408',
         -1, 'FORCE_UINT'
      ]),
      dfEnum('resourceDimension', dtU32, [
        2, 'DDS_DIMENSION_TEXTURE1D',
        3, 'DDS_DIMENSION_TEXTURE2D',
        4, 'DDS_DIMENSION_TEXTURE3D'
      ]),
      dfFlags('miscFlags', dtU32, [
        2, 'DDS_RESOURCE_MISC_TEXTURECUBE'
      ]),
      dfInteger('arraySize', dtU32),
      dfEnum('miscFlags2', dtU32, [
        0, 'DDS_ALPHA_MODE_UNKNOWN',
        1, 'DDS_ALPHA_MODE_STRAIGHT',
        2, 'DDS_ALPHA_MODE_PREMULTIPLIED',
        3, 'DDS_ALPHA_MODE_OPAQUE',
        4, 'DDS_ALPHA_MODE_CUSTOM'
      ])
    ]).SetOnEnabled(DDS_EnDX10),
    dfStruct('HEADER_XBOX', [
      dfInteger('tileMode', dtU32), // see XG_TILE_MODE / XG_SWIZZ
      dfInteger('baseAlignment', dtU32),
      dfInteger('dataSize', dtU32),
      dfInteger('xdkVer', dtU32) // matching _XDK_VER / _GXDK_VER
    ]).SetOnEnabled(DDS_EnXBOX)
  ]);
end;

constructor TwbLODSettingsTES5File.Create;
begin
  inherited Create(dfLODSettingsTES5, nil);
end;

constructor TwbLODSettingsFO3File.Create;
begin
  inherited Create(dfLODSettingsFO3, nil);
end;

constructor TwbLODTreeLSTFile.Create;
begin
  inherited Create(dfLODTreeLST, nil);
end;

constructor TwbLODTreeBTTFile.Create;
begin
  inherited Create(dfLODTreeBTT, nil);
end;

constructor TwbFUZFile.Create;
begin
  inherited Create(dfFUZ, nil);
end;

function TwbFUZFile.UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer;
type
  TMagic = array [0..3] of AnsiChar;
  PMagic = ^TMagic;
const
  sMagicFUZ: TMagic = 'FUZE';
begin
  Result := PByte(aDataEnd) - PByte(aDataStart);

  if Assigned(aDataStart) and not ((Result > SizeOf(TMagic)) and (PMagic(aDataStart)^ = sMagicFUZ)) then
    raise Exception.Create('Not a FUZ file');

  Result := inherited;
end;

constructor TwbDDSFile.Create;
begin
  inherited Create(dfDDS, nil);
end;



initialization
  wbDefineMisc;

finalization

  FreeAndNil(dfLODSettingsTES5);
  FreeAndNil(dfLODSettingsFO3);
  FreeAndNil(dfLODTreeLST);
  FreeAndNil(dfLODTreeBTT);
  FreeAndNil(dfFUZ);
  FreeAndNil(dfDDS);


end.
