unit wbDataFormatMisc;

interface

uses
  SysUtils, wbDataFormat;

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
    function UnSerialize(const aDataStart, aDataEnd: Pointer; const aDataSize: Integer): Integer; override;
  end;

  // DDS file
  TwbDDSFile = class(TdfStruct)
    constructor Create; reintroduce; overload;
  end;

implementation

var
  dfLODSettingsTES5: TdfStructDef;
  dfLODSettingsFO3: TdfStructDef;
  dfLODTreeLST: TdfArrayDef;
  dfLODTreeBTT: TdfArrayDef;
  dfFUZ: TdfStructDef;
  dfDDS: TdfStructDef;

procedure FUZ_GetLIPSize(const e: TdfElement; var aCount: Integer); begin aCount := e.NativeValues['..\LIP Size']; end;
procedure FUZ_BeforeSaveLIPSize(const e: TdfElement); begin e.NativeValue := e.Elements['..\LIP Data'].DataSize; end;
function DDS_EnDX10(const e: TdfElement): Boolean; begin Result := e.EditValues['..\HEADER\ddspf\dwFourCC'] = 'DX10'; end;

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
    dfInteger('Unknown', dtU32),
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
      dfArray('References', dfStruct('Refefence', [
        dfFloat('X'),
        dfFloat('Y'),
        dfFloat('Z'),
        dfFloat('Rotation'),
        dfFloat('Scale', '1.0'),
        dfInteger('FormID', dtU32),
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
        dfChars('dwFourCC', 4, '', #0, False, []),
        dfInteger('dwRGBBitCount', dtU32),
        dfInteger('dwRBitMask', dtU32),
        dfInteger('dwGBitMask', dtU32),
        dfInteger('dwBBitMask', dtU32),
        dfInteger('dwABitMask', dtU32)
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
        0, 'DXGI_FORMAT_UNKNOWN',
        1, 'DXGI_FORMAT_R32G32B32A32_TYPELESS',
        2, 'DXGI_FORMAT_R32G32B32A32_FLOAT',
        3, 'DXGI_FORMAT_R32G32B32A32_UINT',
        4, 'DXGI_FORMAT_R32G32B32A32_SINT',
        5, 'DXGI_FORMAT_R32G32B32_TYPELESS',
        6, 'DXGI_FORMAT_R32G32B32_FLOAT',
        7, 'DXGI_FORMAT_R32G32B32_UINT',
        8, 'DXGI_FORMAT_R32G32B32_SINT',
        9, 'DXGI_FORMAT_R16G16B16A16_TYPELESS',
        10, 'DXGI_FORMAT_R16G16B16A16_FLOAT',
        11, 'DXGI_FORMAT_R16G16B16A16_UNORM',
        12, 'DXGI_FORMAT_R16G16B16A16_UINT',
        13, 'DXGI_FORMAT_R16G16B16A16_SNORM',
        14, 'DXGI_FORMAT_R16G16B16A16_SINT',
        15, 'DXGI_FORMAT_R32G32_TYPELESS',
        16, 'DXGI_FORMAT_R32G32_FLOAT',
        17, 'DXGI_FORMAT_R32G32_UINT',
        18, 'DXGI_FORMAT_R32G32_SINT',
        19, 'DXGI_FORMAT_R32G8X24_TYPELESS',
        20, 'DXGI_FORMAT_D32_FLOAT_S8X24_UINT',
        21, 'DXGI_FORMAT_R32_FLOAT_X8X24_TYPELESS',
        22, 'DXGI_FORMAT_X32_TYPELESS_G8X24_UINT',
        23, 'DXGI_FORMAT_R10G10B10A2_TYPELESS',
        24, 'DXGI_FORMAT_R10G10B10A2_UNORM',
        25, 'DXGI_FORMAT_R10G10B10A2_UINT',
        26, 'DXGI_FORMAT_R11G11B10_FLOAT',
        27, 'DXGI_FORMAT_R8G8B8A8_TYPELESS',
        28, 'DXGI_FORMAT_R8G8B8A8_UNORM',
        29, 'DXGI_FORMAT_R8G8B8A8_UNORM_SRGB',
        30, 'DXGI_FORMAT_R8G8B8A8_UINT',
        31, 'DXGI_FORMAT_R8G8B8A8_SNORM',
        32, 'DXGI_FORMAT_R8G8B8A8_SINT',
        33, 'DXGI_FORMAT_R16G16_TYPELESS',
        34, 'DXGI_FORMAT_R16G16_FLOAT',
        35, 'DXGI_FORMAT_R16G16_UNORM',
        36, 'DXGI_FORMAT_R16G16_UINT',
        37, 'DXGI_FORMAT_R16G16_SNORM',
        38, 'DXGI_FORMAT_R16G16_SINT',
        39, 'DXGI_FORMAT_R32_TYPELESS',
        40, 'DXGI_FORMAT_D32_FLOAT',
        41, 'DXGI_FORMAT_R32_FLOAT',
        42, 'DXGI_FORMAT_R32_UINT',
        43, 'DXGI_FORMAT_R32_SINT',
        44, 'DXGI_FORMAT_R24G8_TYPELESS',
        45, 'DXGI_FORMAT_D24_UNORM_S8_UINT',
        46, 'DXGI_FORMAT_R24_UNORM_X8_TYPELESS',
        47, 'DXGI_FORMAT_X24_TYPELESS_G8_UINT',
        48, 'DXGI_FORMAT_R8G8_TYPELESS',
        49, 'DXGI_FORMAT_R8G8_UNORM',
        50, 'DXGI_FORMAT_R8G8_UINT',
        51, 'DXGI_FORMAT_R8G8_SNORM',
        52, 'DXGI_FORMAT_R8G8_SINT',
        53, 'DXGI_FORMAT_R16_TYPELESS',
        54, 'DXGI_FORMAT_R16_FLOAT',
        55, 'DXGI_FORMAT_D16_UNORM',
        56, 'DXGI_FORMAT_R16_UNORM',
        57, 'DXGI_FORMAT_R16_UINT',
        58, 'DXGI_FORMAT_R16_SNORM',
        59, 'DXGI_FORMAT_R16_SINT',
        60, 'DXGI_FORMAT_R8_TYPELESS',
        61, 'DXGI_FORMAT_R8_UNORM',
        62, 'DXGI_FORMAT_R8_UINT',
        63, 'DXGI_FORMAT_R8_SNORM',
        64, 'DXGI_FORMAT_R8_SINT',
        65, 'DXGI_FORMAT_A8_UNORM',
        66, 'DXGI_FORMAT_R1_UNORM',
        67, 'DXGI_FORMAT_R9G9B9E5_SHAREDEXP',
        68, 'DXGI_FORMAT_R8G8_B8G8_UNORM',
        69, 'DXGI_FORMAT_G8R8_G8B8_UNORM',
        70, 'DXGI_FORMAT_BC1_TYPELESS',
        71, 'DXGI_FORMAT_BC1_UNORM',
        72, 'DXGI_FORMAT_BC1_UNORM_SRGB',
        73, 'DXGI_FORMAT_BC2_TYPELESS',
        74, 'DXGI_FORMAT_BC2_UNORM',
        75, 'DXGI_FORMAT_BC2_UNORM_SRGB',
        76, 'DXGI_FORMAT_BC3_TYPELESS',
        77, 'DXGI_FORMAT_BC3_UNORM',
        78, 'DXGI_FORMAT_BC3_UNORM_SRGB',
        79, 'DXGI_FORMAT_BC4_TYPELESS',
        80, 'DXGI_FORMAT_BC4_UNORM',
        81, 'DXGI_FORMAT_BC4_SNORM',
        82, 'DXGI_FORMAT_BC5_TYPELESS',
        83, 'DXGI_FORMAT_BC5_UNORM',
        84, 'DXGI_FORMAT_BC5_SNORM',
        85, 'DXGI_FORMAT_B5G6R5_UNORM',
        86, 'DXGI_FORMAT_B5G5R5A1_UNORM',
        87, 'DXGI_FORMAT_B8G8R8A8_UNORM',
        88, 'DXGI_FORMAT_B8G8R8X8_UNORM',
        89, 'DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM',
        90, 'DXGI_FORMAT_B8G8R8A8_TYPELESS',
        91, 'DXGI_FORMAT_B8G8R8A8_UNORM_SRGB',
        92, 'DXGI_FORMAT_B8G8R8X8_TYPELESS',
        93, 'DXGI_FORMAT_B8G8R8X8_UNORM_SRGB',
        94, 'DXGI_FORMAT_BC6H_TYPELESS',
        95, 'DXGI_FORMAT_BC6H_UF16',
        96, 'DXGI_FORMAT_BC6H_SF16',
        97, 'DXGI_FORMAT_BC7_TYPELESS',
        98, 'DXGI_FORMAT_BC7_UNORM',
        99, 'DXGI_FORMAT_BC7_UNORM_SRGB',
        100, 'DXGI_FORMAT_AYUV',
        101, 'DXGI_FORMAT_Y410',
        102, 'DXGI_FORMAT_Y416',
        103, 'DXGI_FORMAT_NV12',
        104, 'DXGI_FORMAT_P010',
        105, 'DXGI_FORMAT_P016',
        106, 'DXGI_FORMAT_420_OPAQUE',
        107, 'DXGI_FORMAT_YUY2',
        108, 'DXGI_FORMAT_Y210',
        109, 'DXGI_FORMAT_Y216',
        110, 'DXGI_FORMAT_NV11',
        111, 'DXGI_FORMAT_AI44',
        112, 'DXGI_FORMAT_IA44',
        113, 'DXGI_FORMAT_P8',
        114, 'DXGI_FORMAT_A8P8',
        115, 'DXGI_FORMAT_B4G4R4A4_UNORM',
        130, 'DXGI_FORMAT_P208',
        131, 'DXGI_FORMAT_V208',
        132, 'DXGI_FORMAT_V408',
         -1, 'DXGI_FORMAT_FORCE_UINT'
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
    ], [DF_OnGetEnabled, @DDS_EnDX10])
  ]);
end;

constructor TwbLODSettingsTES5File.Create;
begin
  wbDefineMisc;
  inherited Create(dfLODSettingsTES5, nil);
end;

constructor TwbLODSettingsFO3File.Create;
begin
  wbDefineMisc;
  inherited Create(dfLODSettingsFO3, nil);
end;

constructor TwbLODTreeLSTFile.Create;
begin
  wbDefineMisc;
  inherited Create(dfLODTreeLST, nil);
end;

constructor TwbLODTreeBTTFile.Create;
begin
  wbDefineMisc;
  inherited Create(dfLODTreeBTT, nil);
end;

constructor TwbFUZFile.Create;
begin
  wbDefineMisc;
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
  wbDefineMisc;
  inherited Create(dfDDS, nil);
end;



initialization

finalization

  FreeAndNil(dfLODSettingsTES5);
  FreeAndNil(dfLODSettingsFO3);
  FreeAndNil(dfLODTreeLST);
  FreeAndNil(dfLODTreeBTT);
  FreeAndNil(dfFUZ);
  FreeAndNil(dfDDS);


end.
