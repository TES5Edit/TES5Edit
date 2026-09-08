{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbDDS;

interface

uses
  System.SysUtils;

type
  TMagic4 = array [0..3] of AnsiChar;
  PMagic4 = ^TMagic4;

  TDXGI = (
    DXGI_FORMAT_UNKNOWN,
    DXGI_FORMAT_R32G32B32A32_TYPELESS,
    DXGI_FORMAT_R32G32B32A32_FLOAT,
    DXGI_FORMAT_R32G32B32A32_UINT,
    DXGI_FORMAT_R32G32B32A32_SINT,
    DXGI_FORMAT_R32G32B32_TYPELESS,
    DXGI_FORMAT_R32G32B32_FLOAT,
    DXGI_FORMAT_R32G32B32_UINT,
    DXGI_FORMAT_R32G32B32_SINT,
    DXGI_FORMAT_R16G16B16A16_TYPELESS,
    DXGI_FORMAT_R16G16B16A16_FLOAT,
    DXGI_FORMAT_R16G16B16A16_UNORM,
    DXGI_FORMAT_R16G16B16A16_UINT,
    DXGI_FORMAT_R16G16B16A16_SNORM,
    DXGI_FORMAT_R16G16B16A16_SINT,
    DXGI_FORMAT_R32G32_TYPELESS,
    DXGI_FORMAT_R32G32_FLOAT,
    DXGI_FORMAT_R32G32_UINT,
    DXGI_FORMAT_R32G32_SINT,
    DXGI_FORMAT_R32G8X24_TYPELESS,
    DXGI_FORMAT_D32_FLOAT_S8X24_UINT,
    DXGI_FORMAT_R32_FLOAT_X8X24_TYPELESS,
    DXGI_FORMAT_X32_TYPELESS_G8X24_UINT,
    DXGI_FORMAT_R10G10B10A2_TYPELESS,
    DXGI_FORMAT_R10G10B10A2_UNORM,
    DXGI_FORMAT_R10G10B10A2_UINT,
    DXGI_FORMAT_R11G11B10_FLOAT,
    DXGI_FORMAT_R8G8B8A8_TYPELESS,
    DXGI_FORMAT_R8G8B8A8_UNORM,
    DXGI_FORMAT_R8G8B8A8_UNORM_SRGB,
    DXGI_FORMAT_R8G8B8A8_UINT,
    DXGI_FORMAT_R8G8B8A8_SNORM,
    DXGI_FORMAT_R8G8B8A8_SINT,
    DXGI_FORMAT_R16G16_TYPELESS,
    DXGI_FORMAT_R16G16_FLOAT,
    DXGI_FORMAT_R16G16_UNORM,
    DXGI_FORMAT_R16G16_UINT,
    DXGI_FORMAT_R16G16_SNORM,
    DXGI_FORMAT_R16G16_SINT,
    DXGI_FORMAT_R32_TYPELESS,
    DXGI_FORMAT_D32_FLOAT,
    DXGI_FORMAT_R32_FLOAT,
    DXGI_FORMAT_R32_UINT,
    DXGI_FORMAT_R32_SINT,
    DXGI_FORMAT_R24G8_TYPELESS,
    DXGI_FORMAT_D24_UNORM_S8_UINT,
    DXGI_FORMAT_R24_UNORM_X8_TYPELESS,
    DXGI_FORMAT_X24_TYPELESS_G8_UINT,
    DXGI_FORMAT_R8G8_TYPELESS,
    DXGI_FORMAT_R8G8_UNORM,
    DXGI_FORMAT_R8G8_UINT,
    DXGI_FORMAT_R8G8_SNORM,
    DXGI_FORMAT_R8G8_SINT,
    DXGI_FORMAT_R16_TYPELESS,
    DXGI_FORMAT_R16_FLOAT,
    DXGI_FORMAT_D16_UNORM,
    DXGI_FORMAT_R16_UNORM,
    DXGI_FORMAT_R16_UINT,
    DXGI_FORMAT_R16_SNORM,
    DXGI_FORMAT_R16_SINT,
    DXGI_FORMAT_R8_TYPELESS,
    DXGI_FORMAT_R8_UNORM,
    DXGI_FORMAT_R8_UINT,
    DXGI_FORMAT_R8_SNORM,
    DXGI_FORMAT_R8_SINT,
    DXGI_FORMAT_A8_UNORM,
    DXGI_FORMAT_R1_UNORM,
    DXGI_FORMAT_R9G9B9E5_SHAREDEXP,
    DXGI_FORMAT_R8G8_B8G8_UNORM,
    DXGI_FORMAT_G8R8_G8B8_UNORM,
    DXGI_FORMAT_BC1_TYPELESS,
    DXGI_FORMAT_BC1_UNORM,
    DXGI_FORMAT_BC1_UNORM_SRGB,
    DXGI_FORMAT_BC2_TYPELESS,
    DXGI_FORMAT_BC2_UNORM,
    DXGI_FORMAT_BC2_UNORM_SRGB,
    DXGI_FORMAT_BC3_TYPELESS,
    DXGI_FORMAT_BC3_UNORM,
    DXGI_FORMAT_BC3_UNORM_SRGB,
    DXGI_FORMAT_BC4_TYPELESS,
    DXGI_FORMAT_BC4_UNORM,
    DXGI_FORMAT_BC4_SNORM,
    DXGI_FORMAT_BC5_TYPELESS,
    DXGI_FORMAT_BC5_UNORM,
    DXGI_FORMAT_BC5_SNORM,
    DXGI_FORMAT_B5G6R5_UNORM,
    DXGI_FORMAT_B5G5R5A1_UNORM,
    DXGI_FORMAT_B8G8R8A8_UNORM,
    DXGI_FORMAT_B8G8R8X8_UNORM,
    DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM,
    DXGI_FORMAT_B8G8R8A8_TYPELESS,
    DXGI_FORMAT_B8G8R8A8_UNORM_SRGB,
    DXGI_FORMAT_B8G8R8X8_TYPELESS,
    DXGI_FORMAT_B8G8R8X8_UNORM_SRGB,
    DXGI_FORMAT_BC6H_TYPELESS,
    DXGI_FORMAT_BC6H_UF16,
    DXGI_FORMAT_BC6H_SF16,
    DXGI_FORMAT_BC7_TYPELESS,
    DXGI_FORMAT_BC7_UNORM,
    DXGI_FORMAT_BC7_UNORM_SRGB,
    DXGI_FORMAT_AYUV,
    DXGI_FORMAT_Y410,
    DXGI_FORMAT_Y416,
    DXGI_FORMAT_NV12,
    DXGI_FORMAT_P010,
    DXGI_FORMAT_P016,
    DXGI_FORMAT_420_OPAQUE,
    DXGI_FORMAT_YUY2,
    DXGI_FORMAT_Y210,
    DXGI_FORMAT_Y216,
    DXGI_FORMAT_NV11,
    DXGI_FORMAT_AI44,
    DXGI_FORMAT_IA44,
    DXGI_FORMAT_P8,
    DXGI_FORMAT_A8P8,
    DXGI_FORMAT_B4G4R4A4_UNORM
    //DXGI_FORMAT_P208 = 130,
    //DXGI_FORMAT_V208 = 131,
    //DXGI_FORMAT_V408 = 132
  );
  TDXGIs = set of TDXGI;

  TD3DFORMAT = (
    D3DFMT_UNKNOWN              =  0,

    D3DFMT_R8G8B8               = 20,
    D3DFMT_A8R8G8B8             = 21,
    D3DFMT_X8R8G8B8             = 22,
    D3DFMT_R5G6B5               = 23,
    D3DFMT_X1R5G5B5             = 24,
    D3DFMT_A1R5G5B5             = 25,
    D3DFMT_A4R4G4B4             = 26,
    D3DFMT_R3G3B2               = 27,
    D3DFMT_A8                   = 28,
    D3DFMT_A8R3G3B2             = 29,
    D3DFMT_X4R4G4B4             = 30,
    D3DFMT_A2B10G10R10          = 31,
    D3DFMT_A8B8G8R8             = 32,
    D3DFMT_X8B8G8R8             = 33,
    D3DFMT_G16R16               = 34,
    D3DFMT_A2R10G10B10          = 35,
    D3DFMT_A16B16G16R16         = 36,

    D3DFMT_A8P8                 = 40,
    D3DFMT_P8                   = 41,

    D3DFMT_L8                   = 50,
    D3DFMT_A8L8                 = 51,
    D3DFMT_A4L4                 = 52,

    D3DFMT_V8U8                 = 60,
    D3DFMT_L6V5U5               = 61,
    D3DFMT_X8L8V8U8             = 62,
    D3DFMT_Q8W8V8U8             = 63,
    D3DFMT_V16U16               = 64,
    D3DFMT_A2W10V10U10          = 67
  );
  TD3DFORMATs = set of TD3DFORMAT;

  TDDSHeader = packed record
    Magic: TMagic4;
    dwSize: Cardinal;
    dwFlags: Cardinal;
    dwHeight: Cardinal;
    dwWidth: Cardinal;
    dwPitchOrLinearSize: Cardinal;
    dwDepth: Cardinal;
    dwMipMapCount: Cardinal;
    dwReserved1: array [0..10] of Cardinal;
    ddspf: packed record
      dwSize: Cardinal;
      dwFlags: Cardinal;
      dwFourCC: TMagic4;
      dwRGBBitCount: Cardinal;
      dwRBitMask: Cardinal;
      dwGBitMask: Cardinal;
      dwBBitMask: Cardinal;
      dwABitMask: Cardinal;
    end;
    dwCaps: Cardinal;
    dwCaps2: Cardinal;
    dwCaps3: Cardinal;
    dwCaps4: Cardinal;
    dwReserved2: Cardinal;
  end;
  PDDSHeader = ^TDDSHeader;

  TDDSHeaderDX10 = packed record
    dxgiFormat: Integer;
    resourceDimension: Cardinal;
    miscFlags: Cardinal;
    arraySize: Cardinal;
    miscFlags2: Cardinal;
  end;
  PDDSHeaderDX10 = ^TDDSHeaderDX10;

  TDDSHeaderXBOX = packed record
    tileMode: Cardinal; // see XG_TILE_MODE / XG_SWIZZLE_MODE
    baseAlignment: Cardinal;
    dataSize: Cardinal;
    xdkVer: Cardinal; // matching _XDK_VER / _GXDK_VER  end;
  end;
  PDDSHeaderXBOX = ^TDDSHeaderXBOX;

  TwbDDS = class abstract
  public
    class function IsDDS(aDDSData: Pointer; aSize: Integer): Boolean;
    class function IsXBOX(aDDSData: Pointer): Boolean;
    class function IsCubeMap(aDDSData: Pointer): Boolean;
    class function HasAlpha(aDXGI: TDXGI): Boolean;
    class function IsCompressed(aDXGI: TDXGI): Boolean;
    class function HeaderDX10(aDDSData: Pointer): PDDSHeaderDX10;
    class function HeaderXBOX(aDDSData: Pointer): PDDSHeaderXBOX;
    class function GetHeaderSize(aDDSData: Pointer): Integer;
    class function GetMipSize(aDDSData: Pointer): Integer;
    class function GetTileMode(aDDSData: Pointer): Integer;
    class function GetDXGIFormatName(aDXGI: TDXGI): string;
    class function GetDXGI(aDDSData: Pointer): TDXGI;
    class function GetD3DFMT(aDDSData: Pointer): TD3DFORMAT;
    class function GetD3DFMTFormatName(aD3DFMT: TD3DFORMAT): string;
    class procedure SetUpHeader(aDDSData: Pointer; aDXGI: TDXGI;
      aWidth, aHeight, aMipMapCount: Integer; aCubeMap: Boolean; aXBox: Boolean);
    class function GetBitsPerPixel(aDXGI: TDXGI): Byte; overload;
    class function GetBitsPerPixel(aDDSData: Pointer): Byte; overload;
    class function ConvertR8G8B8toB8G8R8X8(aDDSData: Pointer; aSize: Integer): TBytes;
  const
    MaxHeaderSize = SizeOf(TDDSHeader) + SizeOf(TDDSHeaderDX10) + SizeOf(TDDSHeaderXBOX);
    // formats which don't use additional DX10 header by SetUpHeader()
    DXGI_DX9: TDXGIs = [
      DXGI_FORMAT_BC1_UNORM,
      DXGI_FORMAT_BC2_UNORM,
      DXGI_FORMAT_BC3_UNORM,
      DXGI_FORMAT_BC4_SNORM,
      DXGI_FORMAT_BC4_UNORM,
      DXGI_FORMAT_BC5_SNORM,
      DXGI_FORMAT_BC5_UNORM,
      DXGI_FORMAT_R8G8B8A8_UNORM,
      DXGI_FORMAT_B8G8R8A8_UNORM,
      DXGI_FORMAT_B8G8R8X8_UNORM,
      DXGI_FORMAT_B5G6R5_UNORM,
      DXGI_FORMAT_B5G5R5A1_UNORM,
      DXGI_FORMAT_R8G8_UNORM,
      DXGI_FORMAT_A8_UNORM,
      DXGI_FORMAT_R8_UNORM
    ];
    // formats which use BC Block Compression
    DXGI_COMPRESSED: TDXGIs = [
      DXGI_FORMAT_BC1_UNORM, DXGI_FORMAT_BC1_UNORM_SRGB, DXGI_FORMAT_BC1_TYPELESS,
      DXGI_FORMAT_BC2_UNORM, DXGI_FORMAT_BC2_UNORM_SRGB, DXGI_FORMAT_BC2_TYPELESS,
      DXGI_FORMAT_BC3_UNORM, DXGI_FORMAT_BC3_UNORM_SRGB, DXGI_FORMAT_BC3_TYPELESS,
      DXGI_FORMAT_BC4_UNORM, DXGI_FORMAT_BC4_SNORM, DXGI_FORMAT_BC4_TYPELESS,
      DXGI_FORMAT_BC5_UNORM, DXGI_FORMAT_BC5_SNORM, DXGI_FORMAT_BC5_TYPELESS,
      DXGI_FORMAT_BC6H_UF16, DXGI_FORMAT_BC6H_SF16, DXGI_FORMAT_BC6H_TYPELESS,
      DXGI_FORMAT_BC7_UNORM, DXGI_FORMAT_BC7_UNORM_SRGB, DXGI_FORMAT_BC7_TYPELESS
    ];
    // formats with alpha channel
    DXGI_ALPHA: TDXGIs = [
      DXGI_FORMAT_R32G32B32A32_TYPELESS,
      DXGI_FORMAT_R32G32B32A32_FLOAT,
      DXGI_FORMAT_R32G32B32A32_UINT,
      DXGI_FORMAT_R32G32B32A32_SINT,
      DXGI_FORMAT_R16G16B16A16_TYPELESS,
      DXGI_FORMAT_R16G16B16A16_FLOAT,
      DXGI_FORMAT_R16G16B16A16_UNORM,
      DXGI_FORMAT_R16G16B16A16_UINT,
      DXGI_FORMAT_R16G16B16A16_SNORM,
      DXGI_FORMAT_R16G16B16A16_SINT,
      DXGI_FORMAT_R10G10B10A2_TYPELESS,
      DXGI_FORMAT_R10G10B10A2_UNORM,
      DXGI_FORMAT_R10G10B10A2_UINT,
      DXGI_FORMAT_R8G8B8A8_TYPELESS,
      DXGI_FORMAT_R8G8B8A8_UNORM,
      DXGI_FORMAT_R8G8B8A8_UNORM_SRGB,
      DXGI_FORMAT_R8G8B8A8_UINT,
      DXGI_FORMAT_R8G8B8A8_SNORM,
      DXGI_FORMAT_R8G8B8A8_SINT,
      DXGI_FORMAT_A8_UNORM,
      DXGI_FORMAT_BC1_TYPELESS,
      DXGI_FORMAT_BC1_UNORM,
      DXGI_FORMAT_BC1_UNORM_SRGB,
      DXGI_FORMAT_BC2_TYPELESS,
      DXGI_FORMAT_BC2_UNORM,
      DXGI_FORMAT_BC2_UNORM_SRGB,
      DXGI_FORMAT_BC3_TYPELESS,
      DXGI_FORMAT_BC3_UNORM,
      DXGI_FORMAT_BC3_UNORM_SRGB,
      DXGI_FORMAT_B5G5R5A1_UNORM,
      DXGI_FORMAT_B8G8R8A8_UNORM,
      DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM,
      DXGI_FORMAT_B8G8R8A8_TYPELESS,
      DXGI_FORMAT_B8G8R8A8_UNORM_SRGB,
      DXGI_FORMAT_BC7_TYPELESS,
      DXGI_FORMAT_BC7_UNORM,
      DXGI_FORMAT_BC7_UNORM_SRGB,
      DXGI_FORMAT_AYUV,
      DXGI_FORMAT_Y410,
      DXGI_FORMAT_Y416,
      DXGI_FORMAT_AI44,
      DXGI_FORMAT_IA44,
      DXGI_FORMAT_A8P8,
      DXGI_FORMAT_B4G4R4A4_UNORM
    ];
    // D3D formats not supported by DXGI
    // https://learn.microsoft.com/windows/win32/direct3d10/d3d10-graphics-programming-guide-resources-legacy-formats
    D3D_NODXGI: TD3DFORMATs = [
      D3DFMT_R8G8B8,
      D3DFMT_X1R5G5B5,
      D3DFMT_R3G3B2,
      D3DFMT_A8R3G3B2,
      D3DFMT_X4R4G4B4,
      D3DFMT_X8B8G8R8,
      D3DFMT_A2R10G10B10
    ];
  end;

  // PlayStation Graphics Native File Format V2
  TGNFSurfaceFormat = (
    { $00 } GNFFMT_INVALID,
    { $01 } GNFFMT_8,
    { $02 } GNFFMT_16,
    { $03 } GNFFMT_8_8,
    { $04 } GNFFMT_32,
    { $05 } GNFFMT_16_16,
    { $06 } GNFFMT_10_11_11,
    { $07 } GNFFMT_11_11_10,
    { $08 } GNFFMT_10_10_10_2,
    { $09 } GNFFMT_2_10_10_10,
    { $0A } GNFFMT_8_8_8_8,
    { $0B } GNFFMT_32_32,
    { $0C } GNFFMT_16_16_16_16,
    { $0D } GNFFMT_32_32_32,
    { $0E } GNFFMT_32_32_32_32,
    { $0F } GNF_UNKNOWN_0F,
    { $10 } GNFFMT_5_6_5,
    { $11 } GNFFMT_1_5_5_5,
    { $12 } GNFFMT_5_5_5_1,
    { $13 } GNFFMT_4_4_4_4,
    { $14 } GNFFMT_8_24,
    { $15 } GNFFMT_24_8,
    { $16 } GNFFMT_X42_8_32,
    { $17 } GNFFMT_UNKNOWN_17,
    { $18 } GNFFMT_UNKNOWN_18,
    { $19 } GNFFMT_UNKNOWN_19,
    { $1A } GNFFMT_UNKNOWN_1A,
    { $1B } GNFFMT_UNKNOWN_1B,
    { $1C } GNFFMT_UNKNOWN_1C,
    { $1D } GNFFMT_UNKNOWN_1D,
    { $1E } GNFFMT_UNKNOWN_1E,
    { $1F } GNFFMT_UNKNOWN_1F,
    { $20 } GNFFMT_GB_GR,
    { $21 } GNFFMT_BG_RG,
    { $22 } GNFFMT_5_9_9_9,
    { $23 } GNFFMT_BC1,
    { $24 } GNFFMT_BC2,
    { $25 } GNFFMT_BC3,
    { $26 } GNFFMT_BC4,
    { $27 } GNFFMT_BC5,
    { $28 } GNFFMT_BC6,
    { $29 } GNFFMT_BC7,
    { $2A } GNFFMT_UNKNOWN_2A,
    { $2B } GNFFMT_UNKNOWN_2B,
    { $2C } GNFFMT_FMASK8_S2_F1,
    { $2D } GNFFMT_FMASK8_S4_F1,
    { $2E } GNFFMT_FMASK8_S8_F1,
    { $2F } GNFFMT_FMASK8_S2_F2,
    { $30 } GNFFMT_FMASK8_S4_F2,
    { $31 } GNFFMT_FMASK8_S4_F4,
    { $32 } GNFFMT_FMASK16_S16_F1,
    { $33 } GNFFMT_FMASK16_S8_F2,
    { $34 } GNFFMT_FMASK32_S16_F2,
    { $35 } GNFFMT_FMASK32_S8_F4,
    { $36 } GNFFMT_FMASK32_S8_F8,
    { $37 } GNFFMT_FMASK32_S16_F4,
    { $38 } GNFFMT_FMASK32_S16_F8,
    { $39 } GNFFMT_4_4,
    { $3A } GNFFMT_6_5_5,
    { $3B } GNFFMT_1,
    { $3C } GNFFMT_1_REVERSED,
    { $3D } GNFFMT_32_AS_8,
    { $3E } GNFFMT_32_AS_8_8,
    { $3F } GNFFMT_32_AS_32_32_32_32
  );

  TGNFChannelType = (
    { $00 } GNFCHN_UNORM,
    { $01 } GNFCHN_SNORM,
    { $02 } GNFCHN_USCALED,
    { $03 } GNFCHN_SSCALED,
    { $04 } GNFCHN_UINT,
    { $05 } GNFCHN_SINT,
    { $06 } GNFCHN_SNORM_OGL,
    { $07 } GNFCHN_FLOAT,
    { $08 } GNFCHN_UNKNOWN_08,
    { $09 } GNFCHN_SRGB,
    { $0A } GNFCHN_UBNORM,
    { $0B } GNFCHN_UBNORM_OGL,
    { $0C } GNFCHN_UBINT,
    { $0D } GNFCHN_UBSCALED
  );

  TGNFTextureType = (
    GNF_TEXTURE_1D = $08,
    GNF_TEXTURE_2D = $09,
    GNF_TEXTURE_3D = $0A,
    GNF_TEXTURE_CUBEMAP = $0B,
    GNF_TEXTURE_1D_ARRAY = $0C,
    GNF_TEXTURE_2D_ARRAY = $0D,
    GNF_TEXTURE_2D_MSAA = $0E,
    GNF_TEXTURE_2D_ARRAY_MSAA = $0F
  );

  TGNFTextureDescriptor = packed record
    Meta1: Cardinal;
    Meta2: Cardinal;
    Meta3: Cardinal;
    Meta4: Cardinal;
    Meta5: Cardinal;
    Meta6: Cardinal;
    Meta7: Cardinal;
    TextureSize: Cardinal;
  private
    function GetWidth: Cardinal;
    function GetHeight: Cardinal;
    function GetSurfaceFormat: Cardinal;
    function GetSurfaceFormatName: string;
    function GetChannelType: Cardinal;
    function GetChannelTypeName: string;
    function GetTextureType: Cardinal;
    function GetLastMipLevel: Cardinal;
    function GetMipMapCount: Cardinal;
  public
    property Width: Cardinal read GetWidth;
    property Height: Cardinal read GetHeight;
    property SurfaceFormat: Cardinal read GetSurfaceFormat;
    property SurfaceFormatName: string read GetSurfaceFormatName;
    property ChannelType: Cardinal read GetChannelType;
    property ChannelTypeName: string read GetChannelTypeName;
    property TextureType: Cardinal read GetTextureType;
    property LastMipLevel: Cardinal read GetLastMipLevel;
    property MipMapCount: Cardinal read GetMipMapCount;
  end;

  TGNFHeader = packed record
    Magic: TMagic4;
    ContentSize: Cardinal;
    Version: Byte; // 2 (PS4) / 3 (PS5)
    NumTextures: Byte;
    Alignment: Byte;
    Unused: Byte;
    StreamSize: Cardinal;
    // this should be array Textures[NumTextures], but ba2 supports single texture only
    // so do we
    Texture: TGNFTextureDescriptor;
  end;
  PGNFHeader = ^TGNFHeader;

  TwbGNF = class abstract
  public
    class function IsGNF(aGNFData: Pointer; aSize: Integer): Boolean;
    class function GetHeaderSize(aGNFData: Pointer): Integer;
  end;


const
  MAGIC_DDS : TMagic4 = 'DDS ';
  MAGIC_GNF : TMagic4 = 'GNF ';
  MAGIC_DXT1: TMagic4 = 'DXT1';
  MAGIC_DXT3: TMagic4 = 'DXT3';
  MAGIC_DXT5: TMagic4 = 'DXT5';
  MAGIC_ATI1: TMagic4 = 'ATI1';
  MAGIC_ATI2: TMagic4 = 'ATI2';
  MAGIC_BC4S: TMagic4 = 'BC4S';
  MAGIC_BC4U: TMagic4 = 'BC4U';
  MAGIC_BC5S: TMagic4 = 'BC5S';
  MAGIC_BC5U: TMagic4 = 'BC5U';
  MAGIC_DX10: TMagic4 = 'DX10';
  MAGIC_XBOX: TMagic4 = 'XBOX';

  DDSD_CAPS        = $00000001;
  DDSD_HEIGHT      = $00000002;
  DDSD_WIDTH       = $00000004;
  DDSD_PITCH       = $00000008;
  DDSD_PIXELFORMAT = $00001000;
  DDSD_MIPMAPCOUNT = $00020000;
  DDSD_LINEARSIZE  = $00080000;
  DDSD_DEPTH       = $00800000;

  DDSCAPS_COMPLEX  = $00000008;
  DDSCAPS_TEXTURE  = $00001000;
  DDSCAPS_MIPMAP   = $00400000;

  DDSCAPS2_CUBEMAP           = $00000200;
  DDSCAPS2_CUBEMAP_POSITIVEX = $00000400;
  DDSCAPS2_CUBEMAP_NEGATIVEX = $00000800;
  DDSCAPS2_CUBEMAP_POSITIVEY = $00001000;
  DDSCAPS2_CUBEMAP_NEGATIVEY = $00002000;
  DDSCAPS2_CUBEMAP_POSITIVEZ = $00004000;
  DDSCAPS2_CUBEMAP_NEGATIVEZ = $00008000;
  DDSCAPS2_CUBEMAP_VOLUME    = $00200000;
  DDSCAPS2_CUBEMAP_ALLFACES  =
    DDSCAPS2_CUBEMAP_POSITIVEX or DDSCAPS2_CUBEMAP_NEGATIVEX or
    DDSCAPS2_CUBEMAP_POSITIVEY or DDSCAPS2_CUBEMAP_NEGATIVEY or
    DDSCAPS2_CUBEMAP_POSITIVEZ or DDSCAPS2_CUBEMAP_NEGATIVEZ;

  DDPF_ALPHAPIXELS = $00000001;
  DDPF_ALPHA       = $00000002;
  DDPF_FOURCC      = $00000004;
  DDPF_RGB         = $00000040;
  DDPF_YUV         = $00000200;
  DDPF_LUMINANCE   = $00020000;

  // DX10
  DDS_DIMENSION_TEXTURE2D       = $00000003;
  DDS_RESOURCE_MISC_TEXTURECUBE = $00000004;
  DDS_ALPHA_MODE_UNKNOWN        = $00000000;
  DDS_ALPHA_MODE_STRAIGHT       = $00000001;
  DDS_ALPHA_MODE_PREMULTIPLIED  = $00000002;
  DDS_ALPHA_MODE_OPAQUE         = $00000003;
  DDS_ALPHA_MODE_CUSTOM         = $00000004;

  // GNF
  GNF_VERSION_PS4        = 2;
  GNF_VERSION_PS5        = 3;
  GNF_ALIGNMENT          = 8;
  GNF_PADDED_HEADER_SIZE = 1 shl GNF_ALIGNMENT;


implementation

uses
  System.TypInfo;


{ TwbDDS }

class function TwbDDS.IsDDS(aDDSData: Pointer; aSize: Integer): Boolean;
begin
  Result := Assigned(aDDSData) and
    (aSize >= SizeOf(TDDSHeader)) and
    (PDDSHeader(aDDSData).Magic = MAGIC_DDS) and
    (aSize >= GetHeaderSize(aDDSData));
end;

class function TwbDDS.IsXBOX(aDDSData: Pointer): Boolean;
begin
  Result := PDDSHeader(aDDSData).ddspf.dwFourCC = MAGIC_XBOX;
end;

class function TwbDDS.IsCubeMap(aDDSData: Pointer): Boolean;
begin
  Result := PDDSHeader(aDDSData).dwCaps2 and DDSCAPS2_CUBEMAP <> 0;
end;

class function TwbDDS.HasAlpha(aDXGI: TDXGI): Boolean;
begin
  Result := aDXGI in DXGI_ALPHA;
end;

class function TwbDDS.IsCompressed(aDXGI: TDXGI): Boolean;
begin
  Result := aDXGI in DXGI_COMPRESSED;
end;

class function TwbDDS.GetHeaderSize(aDDSData: Pointer): Integer;
var
  DDSHeader: PDDSHeader;
begin
  DDSHeader := aDDSData;
  Result := SizeOf(TDDSHeader);
  if (DDSHeader.ddspf.dwFourCC = MAGIC_DX10) or (DDSHeader.ddspf.dwFourCC = MAGIC_XBOX) then
    Inc(Result, SizeOf(TDDSHeaderDX10));
  if DDSHeader.ddspf.dwFourCC = MAGIC_XBOX then
    Inc(Result, SizeOf(TDDSHeaderXBOX));
end;

class function TwbDDS.HeaderDX10(aDDSData: Pointer): PDDSHeaderDX10;
begin
  Result := PDDSHeaderDX10(PByte(aDDSData) + SizeOf(TDDSHeader));
end;

class function TwbDDS.HeaderXBOX(aDDSData: Pointer): PDDSHeaderXBOX;
begin
  Result := PDDSHeaderXBOX(PByte(aDDSData) + SizeOf(TDDSHeader) + SizeOf(TDDSHeaderDX10));
end;

class function TwbDDS.GetMipSize(aDDSData: Pointer): Integer;
var
  DDSHeader: PDDSHeader;
begin
  DDSHeader := aDDSData;
  Result := (DDSHeader.dwWidth * DDSHeader.dwHeight * GetBitsPerPixel(DDSHeader)) shr 3;
end;

class function TwbDDS.GetTileMode(aDDSData: Pointer): Integer;
begin
  if IsXBOX(aDDSData) then
    Result := HeaderXBOX(aDDSData).tileMode
  else
    Result := 8;
end;

class function TwbDDS.GetDXGIFormatName(aDXGI: TDXGI): string;
begin
  Result := GetEnumName(TypeInfo(TDXGI), Integer(aDXGI)).Replace('DXGI_FORMAT_', '');
end;

class function TwbDDS.GetD3DFMTFormatName(aD3DFMT: TD3DFORMAT): string;
begin
  case aD3DFMT of
    D3DFMT_UNKNOWN      : Result := 'UNKNOWN';
    D3DFMT_R8G8B8       : Result := 'R8G8B8';
    D3DFMT_A8R8G8B8     : Result := 'A8R8G8B8';
    D3DFMT_X8R8G8B8     : Result := 'X8R8G8B8';
    D3DFMT_R5G6B5       : Result := 'R5G6B5';
    D3DFMT_X1R5G5B5     : Result := 'X1R5G5B5';
    D3DFMT_A1R5G5B5     : Result := 'A1R5G5B5';
    D3DFMT_A4R4G4B4     : Result := 'A4R4G4B4';
    D3DFMT_R3G3B2       : Result := 'R3G3B2';
    D3DFMT_A8           : Result := 'A8';
    D3DFMT_A8R3G3B2     : Result := 'A8R3G3B2';
    D3DFMT_X4R4G4B4     : Result := 'X4R4G4B4';
    D3DFMT_A2B10G10R10  : Result := 'A2B10G10R10';
    D3DFMT_A8B8G8R8     : Result := 'A8B8G8R8';
    D3DFMT_X8B8G8R8     : Result := 'X8B8G8R8';
    D3DFMT_G16R16       : Result := 'G16R16';
    D3DFMT_A2R10G10B10  : Result := 'A2R10G10B10';
    D3DFMT_A16B16G16R16 : Result := 'A16B16G16R16';
    else
      Result := 'UNKNOWN';
  end;
end;

class function TwbDDS.GetDXGI(aDDSData: Pointer): TDXGI;
var
  DDSHeader: PDDSHeader;
  DDSHeaderDX10: PDDSHeaderDX10;
begin
  Result := DXGI_FORMAT_UNKNOWN;
  DDSHeader := aDDSData;

  with DDSHeader.ddspf do
  if dwFourCC = MAGIC_DXT1 then Result := DXGI_FORMAT_BC1_UNORM else
  if dwFourCC = MAGIC_DXT3 then Result := DXGI_FORMAT_BC2_UNORM else
  if dwFourCC = MAGIC_DXT5 then Result := DXGI_FORMAT_BC3_UNORM else
  if dwFourCC = MAGIC_ATI1 then Result := DXGI_FORMAT_BC4_UNORM else
  if dwFourCC = MAGIC_BC4U then Result := DXGI_FORMAT_BC4_UNORM else
  if dwFourCC = MAGIC_BC4S then Result := DXGI_FORMAT_BC4_SNORM else
  if dwFourCC = MAGIC_ATI2 then Result := DXGI_FORMAT_BC5_UNORM else
  if dwFourCC = MAGIC_BC5U then Result := DXGI_FORMAT_BC5_UNORM else
  if dwFourCC = MAGIC_BC5S then Result := DXGI_FORMAT_BC5_SNORM else
  if (dwFourCC = MAGIC_DX10) or (dwFourCC = MAGIC_XBOX) then begin
    DDSHeaderDX10 := Pointer(PByte(DDSHeader) + SizeOf(DDSHeader^));
    Result := TDXGI(DDSHeaderDX10.dxgiFormat);
  end else
  if dwFlags and (DDPF_RGB or DDPF_LUMINANCE) <> 0 then case dwRGBBitCount of
    32:
      if dwFlags and DDPF_ALPHAPIXELS = 0 then
        Result := DXGI_FORMAT_B8G8R8X8_UNORM
      else if dwRBitMask = $000000FF then
        Result := DXGI_FORMAT_R8G8B8A8_UNORM
      else
        Result := DXGI_FORMAT_B8G8R8A8_UNORM;
    16:
      if (dwRBitMask = $F800) and (dwGBitMask = $07E0) and (dwBBitMask = $001F) and (dwABitMask = $0000) then
        Result := DXGI_FORMAT_B5G6R5_UNORM
      else if (dwRBitMask = $7C00) and (dwGBitMask = $03E0) and (dwBBitMask = $001F) and (dwABitMask = $8000) then
        Result := DXGI_FORMAT_B5G5R5A1_UNORM
      else
        Result := DXGI_FORMAT_R8G8_UNORM;
    8:
      if dwFlags and DDPF_ALPHA <> 0 then
        Result := DXGI_FORMAT_A8_UNORM
      else
        Result := DXGI_FORMAT_R8_UNORM;
  end;
end;

class function TwbDDS.GetD3DFMT(aDDSData: Pointer): TD3DFORMAT;
var
  DDSHeader: PDDSHeader;
begin
  // https://learn.microsoft.com/windows/win32/direct3ddds/dx-graphics-dds-pguide
  Result := D3DFMT_UNKNOWN;
  DDSHeader := aDDSData;

  with DDSHeader.ddspf do
  if dwFlags and DDPF_RGB <> 0 then case dwRGBBitCount of
    32:
      if (dwFlags and DDPF_ALPHA <> 0) and (dwRBitMask = $FF0000) and (dwGBitMask = $FF00) and (dwBBitMask = $FF) and (dwABitMask = $FF000000) then
        Result := D3DFMT_A8R8G8B8
      else if (dwFlags and DDPF_ALPHA = 0) and (dwRBitMask = $FF0000) and (dwGBitMask = $FF00) and (dwBBitMask = $FF) then
        Result := D3DFMT_X8R8G8B8
      else if (dwFlags and DDPF_ALPHA = 0) and (dwRBitMask = $FF) and (dwGBitMask = $FF00) and (dwBBitMask = $FF0000) then
        Result := D3DFMT_X8B8G8R8
      else if (dwFlags and DDPF_ALPHA <> 0) and (dwRBitMask = $3FF00000) and (dwGBitMask = $FFC00) and (dwBBitMask = $3FF) and (dwABitMask = $C0000000) then
        Result := D3DFMT_A2R10G10B10;
    24:
      if (dwRBitMask = $FF0000) and (dwGBitMask = $FF00) and (dwBBitMask = $FF) and (dwABitMask = $00) then
        Result := D3DFMT_R8G8B8;
    16:
      if (dwRBitMask = $7C00) and (dwGBitMask = $03E0) and (dwBBitMask = $001F) and (dwABitMask = $8000) then
        Result := D3DFMT_X1R5G5B5
      else if (dwRBitMask = $F00) and (dwGBitMask = $F0) and (dwBBitMask = $F) and (dwABitMask = $F000) then
        Result := D3DFMT_A4R4G4B4
      else if (dwRBitMask = $F00) and (dwGBitMask = $F0) and (dwBBitMask = $F) and (dwABitMask = $0000) then
        Result := D3DFMT_X4R4G4B4
      else if (dwRBitMask = $E0) and (dwGBitMask = $1C) and (dwBBitMask = $3) and (dwABitMask = $FF00) then
        Result := D3DFMT_A8R3G3B2
  end;
end;

class procedure TwbDDS.SetUpHeader(aDDSData: Pointer; aDXGI: TDXGI;
  aWidth, aHeight, aMipMapCount: Integer; aCubeMap: Boolean; aXBox: Boolean);
var
  DDSHeader: PDDSHeader;
  DDSHeaderDX10: PDDSHeaderDX10;
  DDSHeaderXBOX: PDDSHeaderXBOX;
begin
  DDSHeader := aDDSData;
  DDSHeaderDX10 := HeaderDX10(aDDSData);
  DDSHeaderXBOX := HeaderXBOX(aDDSData);

  // header
  with DDSHeader^ do begin
    Magic := MAGIC_DDS;
    dwSize := SizeOf(TDDSHeader) - SizeOf(TMagic4);
    ddspf.dwSize := SizeOf(ddspf);
    dwWidth := aWidth;
    dwHeight := aHeight;
    dwFlags := DDSD_CAPS or DDSD_PIXELFORMAT or DDSD_WIDTH or DDSD_HEIGHT or DDSD_MIPMAPCOUNT;
    dwCaps := DDSCAPS_TEXTURE;
    dwDepth := 1;
    dwMipMapCount := aMipMapCount;
    if dwMipMapCount = 0 then Inc(dwMipMapCount);
    if dwMipMapCount > 1 then
      dwCaps := dwCaps or DDSCAPS_MIPMAP or DDSCAPS_COMPLEX;

    if aCubeMap then begin
      // Archive2.exe creates invalid textures like this
      // dwCaps := dwCaps or DDSCAPS2_CUBEMAP or DDSCAPS_COMPLEX or DDSCAPS2_CUBEMAP_ALLFACES
      // this is the correct way
      dwCaps := dwCaps or DDSCAPS_COMPLEX;
      dwCaps2 := DDSCAPS2_CUBEMAP or DDSCAPS2_CUBEMAP_ALLFACES;
    end;
  end;

  // DXGI specific settings
  with DDSHeader^ do case aDXGI of
    DXGI_FORMAT_BC1_UNORM: begin
      dwFlags := dwFlags or DDSD_LINEARSIZE;
      ddspf.dwFlags := DDPF_FOURCC;
      ddspf.dwFourCC := MAGIC_DXT1;
      dwPitchOrLinearSize := dwWidth * dwHeight div 2;
    end;
    DXGI_FORMAT_BC2_UNORM: begin
      dwFlags := dwFlags or DDSD_LINEARSIZE;
      ddspf.dwFlags := DDPF_FOURCC;
      ddspf.dwFourCC := MAGIC_DXT3;
      dwPitchOrLinearSize := dwWidth * dwHeight;
    end;
    DXGI_FORMAT_BC3_UNORM: begin
      dwFlags := dwFlags or DDSD_LINEARSIZE;
      ddspf.dwFlags := DDPF_FOURCC;
      ddspf.dwFourCC := MAGIC_DXT5;
      dwPitchOrLinearSize := dwWidth * dwHeight;
    end;
    DXGI_FORMAT_BC4_SNORM: begin
      dwFlags := dwFlags or DDSD_LINEARSIZE;
      ddspf.dwFlags := DDPF_FOURCC;
      ddspf.dwFourCC := MAGIC_BC4S;
      dwPitchOrLinearSize := dwWidth * dwHeight div 2;
    end;
    DXGI_FORMAT_BC4_UNORM: begin
      dwFlags := dwFlags or DDSD_LINEARSIZE;
      ddspf.dwFlags := DDPF_FOURCC;
      ddspf.dwFourCC := MAGIC_BC4U;
      dwPitchOrLinearSize := dwWidth * dwHeight div 2;
    end;
    DXGI_FORMAT_BC5_SNORM: begin
      dwFlags := dwFlags or DDSD_LINEARSIZE;
      ddspf.dwFlags := DDPF_FOURCC;
      ddspf.dwFourCC := MAGIC_BC5S;
      dwPitchOrLinearSize := dwWidth * dwHeight;
    end;
    DXGI_FORMAT_BC5_UNORM: begin
      dwFlags := dwFlags or DDSD_LINEARSIZE;
      ddspf.dwFlags := DDPF_FOURCC;
      ddspf.dwFourCC := MAGIC_BC5U;
      dwPitchOrLinearSize := dwWidth * dwHeight;
    end;
    DXGI_FORMAT_BC1_UNORM_SRGB: begin
      dwFlags := dwFlags or DDSD_LINEARSIZE;
      ddspf.dwFlags := DDPF_FOURCC;
      ddspf.dwFourCC := MAGIC_DX10;
      dwPitchOrLinearSize := dwWidth * dwHeight div 2;
    end;
    DXGI_FORMAT_BC2_UNORM_SRGB, DXGI_FORMAT_BC3_UNORM_SRGB,
    DXGI_FORMAT_BC6H_UF16, DXGI_FORMAT_BC6H_SF16,
    DXGI_FORMAT_BC7_UNORM, DXGI_FORMAT_BC7_UNORM_SRGB: begin
      dwFlags := dwFlags or DDSD_LINEARSIZE;
      ddspf.dwFlags := DDPF_FOURCC;
      ddspf.dwFourCC := MAGIC_DX10;
      dwPitchOrLinearSize := dwWidth * dwHeight;
    end;
    DXGI_FORMAT_B8G8R8A8_UNORM_SRGB, DXGI_FORMAT_B8G8R8X8_UNORM_SRGB,
    DXGI_FORMAT_R8G8B8A8_UNORM_SRGB,
    DXGI_FORMAT_R8G8B8A8_SINT, DXGI_FORMAT_R8G8B8A8_UINT: begin
      dwFlags := dwFlags or DDSD_PITCH;
      ddspf.dwFlags := DDPF_FOURCC;
      ddspf.dwFourCC := MAGIC_DX10;
      dwPitchOrLinearSize := dwWidth * 4;
    end;
    DXGI_FORMAT_R8G8B8A8_UNORM: begin
      dwFlags := dwFlags or DDSD_PITCH;
      ddspf.dwFlags := DDPF_RGB or DDPF_ALPHAPIXELS;
      ddspf.dwRGBBitCount := 32;
      ddspf.dwRBitMask := $000000FF;
      ddspf.dwGBitMask := $0000FF00;
      ddspf.dwBBitMask := $00FF0000;
      ddspf.dwABitMask := $FF000000;
      dwPitchOrLinearSize := dwWidth * 4;
    end;
    DXGI_FORMAT_B8G8R8A8_UNORM: begin
      dwFlags := dwFlags or DDSD_PITCH;
      ddspf.dwFlags := DDPF_RGB or DDPF_ALPHAPIXELS;
      ddspf.dwRGBBitCount := 32;
      ddspf.dwRBitMask := $00FF0000;
      ddspf.dwGBitMask := $0000FF00;
      ddspf.dwBBitMask := $000000FF;
      ddspf.dwABitMask := $FF000000;
      dwPitchOrLinearSize := dwWidth * 4;
    end;
    DXGI_FORMAT_B8G8R8X8_UNORM: begin
      dwFlags := dwFlags or DDSD_PITCH;
      ddspf.dwFlags := DDPF_RGB;
      ddspf.dwRGBBitCount := 32;
      ddspf.dwRBitMask := $00FF0000;
      ddspf.dwGBitMask := $0000FF00;
      ddspf.dwBBitMask := $000000FF;
      dwPitchOrLinearSize := dwWidth * 4;
    end;
    DXGI_FORMAT_B5G6R5_UNORM: begin
      dwFlags := dwFlags or DDSD_PITCH;
      ddspf.dwFlags := DDPF_RGB;
      ddspf.dwRGBBitCount := 16;
      ddspf.dwRBitMask := $0000F800;
      ddspf.dwGBitMask := $000007E0;
      ddspf.dwBBitMask := $0000001F;
      dwPitchOrLinearSize := dwWidth * 2;
    end;
    DXGI_FORMAT_B5G5R5A1_UNORM: begin
      dwFlags := dwFlags or DDSD_PITCH;
      ddspf.dwFlags := DDPF_RGB or DDPF_ALPHAPIXELS;
      ddspf.dwRGBBitCount := 16;
      ddspf.dwRBitMask := $00007C00;
      ddspf.dwGBitMask := $000003E0;
      ddspf.dwBBitMask := $0000001F;
      ddspf.dwABitMask := $00008000;
      dwPitchOrLinearSize := dwWidth * 2;
    end;
    DXGI_FORMAT_R8G8_UNORM: begin
      dwFlags := dwFlags or DDSD_PITCH;
      ddspf.dwFlags := DDPF_LUMINANCE OR DDPF_ALPHAPIXELS;
      ddspf.dwRGBBitCount := 16;
      ddspf.dwRBitMask := $000000FF;
      ddspf.dwABitMask := $0000FF00;
      dwPitchOrLinearSize := dwWidth * 2;
    end;
    DXGI_FORMAT_R8G8_SINT, DXGI_FORMAT_R8G8_UINT: begin
      dwFlags := dwFlags or DDSD_PITCH;
      ddspf.dwFlags := DDPF_FOURCC;
      ddspf.dwFourCC := MAGIC_DX10;
      dwPitchOrLinearSize := dwWidth * 2;
    end;
    DXGI_FORMAT_R8_SINT, DXGI_FORMAT_R8_SNORM, DXGI_FORMAT_R8_UINT: begin
      dwFlags := dwFlags or DDSD_PITCH;
      ddspf.dwFlags := DDPF_FOURCC;
      ddspf.dwFourCC := MAGIC_DX10;
      dwPitchOrLinearSize := dwWidth;
    end;
    DXGI_FORMAT_A8_UNORM: begin
      dwFlags := dwFlags or DDSD_PITCH;
      ddspf.dwFlags := DDPF_ALPHA;
      ddspf.dwRGBBitCount := 8;
      ddspf.dwABitMask := $000000FF;
      dwPitchOrLinearSize := dwWidth;
    end;
    DXGI_FORMAT_R8_UNORM: begin
      dwFlags := dwFlags or DDSD_PITCH;
      ddspf.dwFlags := DDPF_LUMINANCE;
      ddspf.dwRGBBitCount := 8;
      ddspf.dwRBitMask := $000000FF;
      dwPitchOrLinearSize := dwWidth;
    end
    // the rest of DXGI formats, unsupported by Bethesda?
    else begin
      dwFlags := dwFlags or DDSD_PITCH;
      ddspf.dwFlags := DDPF_FOURCC;
      ddspf.dwFourCC := MAGIC_DX10;
      dwPitchOrLinearSize := (dwWidth * TwbDDS.GetBitsPerPixel(aDXGI)) shr 3;
    end;
  end;

  // additional DX10 header
  if (DDSHeader.ddspf.dwFourCC = MAGIC_DX10) or aXBox then begin
    DDSHeaderDX10.dxgiFormat := Integer(aDXGI);
    DDSHeaderDX10.resourceDimension := DDS_DIMENSION_TEXTURE2D;
    DDSHeaderDX10.arraySize := 1;
    if aCubeMap then
      DDSHeaderDX10.miscFlags := DDS_RESOURCE_MISC_TEXTURECUBE;
  end;

  // additional XBOX header
  if aXBox then begin
    DDSHeader.ddspf.dwFlags := DDPF_FOURCC;
    DDSHeader.ddspf.dwFourCC := MAGIC_XBOX;
    DDSHeader.ddspf.dwRGBBitCount := 0;
    DDSHeader.ddspf.dwRBitMask := 0;
    DDSHeader.ddspf.dwGBitMask := 0;
    DDSHeader.ddspf.dwBBitMask := 0;
    DDSHeader.ddspf.dwABitMask := 0;
    DDSHeaderXBOX.xdkVer := 10705; // used by Archive2 when extracting xbox textures
  end;
end;

class function TwbDDS.GetBitsPerPixel(aDXGI: TDXGI): Byte;
begin
  case aDXGI of
    DXGI_FORMAT_R32G32B32A32_TYPELESS,
    DXGI_FORMAT_R32G32B32A32_FLOAT,
    DXGI_FORMAT_R32G32B32A32_UINT,
    DXGI_FORMAT_R32G32B32A32_SINT:
      Result := 128;

    DXGI_FORMAT_R32G32B32_TYPELESS,
    DXGI_FORMAT_R32G32B32_FLOAT,
    DXGI_FORMAT_R32G32B32_UINT,
    DXGI_FORMAT_R32G32B32_SINT:
      Result := 96;

    DXGI_FORMAT_R16G16B16A16_TYPELESS,
    DXGI_FORMAT_R16G16B16A16_FLOAT,
    DXGI_FORMAT_R16G16B16A16_UNORM,
    DXGI_FORMAT_R16G16B16A16_UINT,
    DXGI_FORMAT_R16G16B16A16_SNORM,
    DXGI_FORMAT_R16G16B16A16_SINT,
    DXGI_FORMAT_R32G32_TYPELESS,
    DXGI_FORMAT_R32G32_FLOAT,
    DXGI_FORMAT_R32G32_UINT,
    DXGI_FORMAT_R32G32_SINT,
    DXGI_FORMAT_R32G8X24_TYPELESS,
    DXGI_FORMAT_D32_FLOAT_S8X24_UINT,
    DXGI_FORMAT_R32_FLOAT_X8X24_TYPELESS,
    DXGI_FORMAT_X32_TYPELESS_G8X24_UINT,
    DXGI_FORMAT_Y416,
    DXGI_FORMAT_Y210,
    DXGI_FORMAT_Y216:
      Result := 64;

    DXGI_FORMAT_R10G10B10A2_TYPELESS,
    DXGI_FORMAT_R10G10B10A2_UNORM,
    DXGI_FORMAT_R10G10B10A2_UINT,
    DXGI_FORMAT_R11G11B10_FLOAT,
    DXGI_FORMAT_R8G8B8A8_TYPELESS,
    DXGI_FORMAT_R8G8B8A8_UNORM,
    DXGI_FORMAT_R8G8B8A8_UNORM_SRGB,
    DXGI_FORMAT_R8G8B8A8_UINT,
    DXGI_FORMAT_R8G8B8A8_SNORM,
    DXGI_FORMAT_R8G8B8A8_SINT,
    DXGI_FORMAT_R16G16_TYPELESS,
    DXGI_FORMAT_R16G16_FLOAT,
    DXGI_FORMAT_R16G16_UNORM,
    DXGI_FORMAT_R16G16_UINT,
    DXGI_FORMAT_R16G16_SNORM,
    DXGI_FORMAT_R16G16_SINT,
    DXGI_FORMAT_R32_TYPELESS,
    DXGI_FORMAT_D32_FLOAT,
    DXGI_FORMAT_R32_FLOAT,
    DXGI_FORMAT_R32_UINT,
    DXGI_FORMAT_R32_SINT,
    DXGI_FORMAT_R24G8_TYPELESS,
    DXGI_FORMAT_D24_UNORM_S8_UINT,
    DXGI_FORMAT_R24_UNORM_X8_TYPELESS,
    DXGI_FORMAT_X24_TYPELESS_G8_UINT,
    DXGI_FORMAT_R9G9B9E5_SHAREDEXP,
    DXGI_FORMAT_R8G8_B8G8_UNORM,
    DXGI_FORMAT_G8R8_G8B8_UNORM,
    DXGI_FORMAT_B8G8R8A8_UNORM,
    DXGI_FORMAT_B8G8R8X8_UNORM,
    DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM,
    DXGI_FORMAT_B8G8R8A8_TYPELESS,
    DXGI_FORMAT_B8G8R8A8_UNORM_SRGB,
    DXGI_FORMAT_B8G8R8X8_TYPELESS,
    DXGI_FORMAT_B8G8R8X8_UNORM_SRGB,
    DXGI_FORMAT_AYUV,
    DXGI_FORMAT_Y410,
    DXGI_FORMAT_YUY2:
      Result := 32;

    DXGI_FORMAT_P010,
    DXGI_FORMAT_P016:
      Result := 24;

    DXGI_FORMAT_R8G8_TYPELESS,
    DXGI_FORMAT_R8G8_UNORM,
    DXGI_FORMAT_R8G8_UINT,
    DXGI_FORMAT_R8G8_SNORM,
    DXGI_FORMAT_R8G8_SINT,
    DXGI_FORMAT_R16_TYPELESS,
    DXGI_FORMAT_R16_FLOAT,
    DXGI_FORMAT_D16_UNORM,
    DXGI_FORMAT_R16_UNORM,
    DXGI_FORMAT_R16_UINT,
    DXGI_FORMAT_R16_SNORM,
    DXGI_FORMAT_R16_SINT,
    DXGI_FORMAT_B5G6R5_UNORM,
    DXGI_FORMAT_B5G5R5A1_UNORM,
    DXGI_FORMAT_A8P8,
    DXGI_FORMAT_B4G4R4A4_UNORM:
      Result := 16;

    DXGI_FORMAT_NV12,
    DXGI_FORMAT_420_OPAQUE,
    DXGI_FORMAT_NV11:
      Result := 12;

    DXGI_FORMAT_R8_TYPELESS,
    DXGI_FORMAT_R8_UNORM,
    DXGI_FORMAT_R8_UINT,
    DXGI_FORMAT_R8_SNORM,
    DXGI_FORMAT_R8_SINT,
    DXGI_FORMAT_A8_UNORM,
    DXGI_FORMAT_BC2_TYPELESS,
    DXGI_FORMAT_BC2_UNORM,
    DXGI_FORMAT_BC2_UNORM_SRGB,
    DXGI_FORMAT_BC3_TYPELESS,
    DXGI_FORMAT_BC3_UNORM,
    DXGI_FORMAT_BC3_UNORM_SRGB,
    DXGI_FORMAT_BC5_TYPELESS,
    DXGI_FORMAT_BC5_UNORM,
    DXGI_FORMAT_BC5_SNORM,
    DXGI_FORMAT_BC6H_TYPELESS,
    DXGI_FORMAT_BC6H_UF16,
    DXGI_FORMAT_BC6H_SF16,
    DXGI_FORMAT_BC7_TYPELESS,
    DXGI_FORMAT_BC7_UNORM,
    DXGI_FORMAT_BC7_UNORM_SRGB,
    DXGI_FORMAT_AI44,
    DXGI_FORMAT_IA44,
    DXGI_FORMAT_P8:
      Result := 8;

    DXGI_FORMAT_R1_UNORM:
      Result := 1;

    DXGI_FORMAT_BC1_TYPELESS,
    DXGI_FORMAT_BC1_UNORM,
    DXGI_FORMAT_BC1_UNORM_SRGB,
    DXGI_FORMAT_BC4_TYPELESS,
    DXGI_FORMAT_BC4_UNORM,
    DXGI_FORMAT_BC4_SNORM:
      Result := 4;

    else
      Result := 0;
  end;
end;

class function TwbDDS.GetBitsPerPixel(aDDSData: Pointer): Byte;
begin
  Result := GetBitsPerPixel(GetDXGI(aDDSData));
end;

class function TwbDDS.ConvertR8G8B8toB8G8R8X8(aDDSData: Pointer; aSize: Integer): TBytes;
var
  DDSHeader: PDDSHeader;
  headersize, pixels: Integer;
  src, dst: PByte;
begin
  headersize := GetHeaderSize(aDDSData);
  pixels := (aSize - headersize) div 3;
  SetLength(Result, aSize + pixels); // extra byte per pixel
  System.Move(aDDSData^, Pointer(Result)^, headersize);
  DDSHeader := Pointer(Result);
  DDSHeader.ddspf.dwRGBBitCount := 32;
  DDSHeader.dwPitchOrLinearSize := DDSHeader.dwWidth * 4;
  src := PByte(aDDSData) + headersize;
  dst := @Result[headersize];
  for var i := 1 to pixels do begin
    PCardinal(dst)^ := PCardinal(src)^ or $FF000000;
    Inc(src, 3);
    Inc(dst, 4);
  end;
end;


{ TGNFTextureDescriptor }

function TGNFTextureDescriptor.GetWidth: Cardinal;
begin
  Result := (Meta3 and $00003FFF) + 1;
end;

function TGNFTextureDescriptor.GetHeight: Cardinal;
begin
  Result := ((Meta3 and $0FFFC000) shr 14) + 1;
end;

function TGNFTextureDescriptor.GetSurfaceFormat: Cardinal;
begin
  Result := (Meta2 and $03F00000) shr 20;
end;

function TGNFTextureDescriptor.GetSurfaceFormatName: string;
begin
  Result := GetEnumName(TypeInfo(TGNFSurfaceFormat), Integer(SurfaceFormat)).Replace('GNFFMT_', '');
end;

function TGNFTextureDescriptor.GetChannelType: Cardinal;
begin
  Result := (Meta2 and $3C000000) shr 26;
end;

function TGNFTextureDescriptor.GetChannelTypeName: string;
begin
  Result := GetEnumName(TypeInfo(TGNFChannelType), Integer(ChannelType)).Replace('GNFCHN_', '');
end;

function TGNFTextureDescriptor.GetTextureType: Cardinal;
begin
  Result := (Meta4 and $F0000000) shr 28;
end;

function TGNFTextureDescriptor.GetLastMipLevel: Cardinal;
begin
  Result := (Meta4 and $F0000) shr 16;
end;

function TGNFTextureDescriptor.GetMipMapCount: Cardinal;
begin
  Result := LastMipLevel + 1;
end;


{ TwbGNF }

class function TwbGNF.IsGNF(aGNFData: Pointer; aSize: Integer): Boolean;
begin
  Result := Assigned(aGNFData) and
    (aSize >= SizeOf(TGNFHeader)) and
    (PGNFHeader(aGNFData).Magic = MAGIC_GNF) and
    (aSize >= GetHeaderSize(aGNFData));
end;

class function TwbGNF.GetHeaderSize(aGNFData: Pointer): Integer;
var
  GNFHeader: PGNFHeader;
begin
  GNFHeader := aGNFData;
  Result := SizeOf(GNFHeader.Magic) + SizeOf(GNFHeader.ContentSize) + GNFHeader.ContentSize;
end;


end.
