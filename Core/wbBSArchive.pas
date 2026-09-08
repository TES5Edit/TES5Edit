{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbBSArchive;

interface

uses
  System.Classes,
  System.SyncObjs,
  System.SysUtils,

  wbCompression,
  wbDDS,
  wbHash,
  wbStreams;

const
  cBSArchVersion = '1.1';
  cBSArchExtension = '.bsarch';

type
  TwbBSArchiveType = (baNone, baTES3, baTES4, baFO3, baSSE, baFO4, baFO4dds, baSF, baSFdds);
  TwbBSArchiveTypes = set of TwbBSArchiveType;
  TwbBSArchiveTarget = (btPC, btXBox, btPS);
  TwbBSArchive = class;
  TwbBSArchives = array of TwbBSArchive;
  TwbBSArchivePacker = class;

  TwbDDSInfo = record Width, Height, MipMaps: Integer; end;
  TwbDDSInfoProc = procedure(aArchive: TwbBSArchive; const aFileName: string;
    var aInfo: TwbDDSInfo);

  TwbBSHeader = record
    Magic: TMagic4;
    Version: Cardinal;
    FileCount: Cardinal;
    // tes3
    HashOffset: Cardinal;
    // tes4
    FoldersOffset: Cardinal;
    Flags: Cardinal;
    FolderCount: Cardinal;
    FolderNamesLength: Cardinal;
    FileNamesLength: Cardinal;
    FileFlags: Cardinal;
    // fo4
    Magic2: TMagic4;
    FileTableOffset: Int64;
    // sf
    CompressionMethod: Cardinal;

    const
      // Magic, HashOffset, FileCount
      SizeOfTES3 = SizeOf(Cardinal) * 3;
      // Magic, Version, FoldersOffset, Flags, FolderCount, FileCount, FolderNamesLength, FileNamesLength, FileFlags
      SizeOfTES4 = SizeOf(Cardinal) * 9;
      // Magic, Version, Magic2, FileCount, FileTableOffset
      SizeOfFO4 = SizeOf(Cardinal) * 4 + SizeOf(Int64);
      // FO4 + unused UInt64
      SizeOfSFv2 = SizeOfFO4 + SizeOf(UInt64);
      // SF2 + CompressionMethod
      SizeOfSFv3 = SizeOfSFv2 + SizeOf(Cardinal);
  end;

  TwbBSFileChunk = class
  private
    function GetCompressed: Boolean; virtual;
  public
    Offset: Int64;
    Size: Cardinal;
    PackedSize: Cardinal;
    property Compressed: Boolean read GetCompressed;
  end;

  TwbBSFileChunkTex = class(TwbBSFileChunk)
  public
    StartMip: Word;
    EndMip: Word;
  end;

  TwbBSFileEntry = class(TwbBSFileChunk)
  private
    function GetCompressed: Boolean; override;
  public
    Archive: TwbBSArchive;
    Name: string;
    LookupHash: TwbLookupHash;
    Compress: Boolean;
    FileObject: Pointer;
    DirHash32, NameHash32: Cardinal;
    DirHash64, NameHash64: UInt64;
    Ext: TMagic4;
    ModIndex: Byte;
    DDS: record
      Height     : Word;
      Width      : Word;
      NumMips    : Byte;
      DXGIFormat : Byte;
      Flags      : Byte;
      TileMode   : Byte;
    end;
    GNF: TGNFTextureDescriptor;
    TexChunks  : array of TwbBSFileChunkTex;
    constructor Create(aArchive: TwbBSArchive);
    destructor Destroy; override;
    function DXGIFormatName: string;
    function IsCubeMap: Boolean;
    function Unpack: TBytes;
    function Info: string;
    property Compressed: Boolean read GetCompressed;
  end;
  TwbBSFileEntries = array of TwbBSFileEntry;

  TwbBSArchiveEnumerator = class
  private
    fIndex: NativeInt;
    fArchive: TwbBSArchive;
  public
    constructor Create(aArchive: TwbBSArchive);
    function GetCurrent: TwbBSFileEntry; inline;
    function MoveNext: Boolean; inline;
    property Current: TwbBSFileEntry read GetCurrent;
  end;

  TwbCustomBSArchive = class abstract
  private
    fType: TwbBSArchiveType;
    fTarget: TwbBSArchiveTarget;
    fFileName: string;
    fCompressionType: TwbCompressionType;
    fShareData: Boolean;
    fMultiThreaded: Boolean;
    fArchiveFlags: Cardinal;
    fFileFlags: Cardinal;
    fMaxChunkCount: Integer;
    fSingleMipChunkX: Integer;
    fSingleMipChunkY: Integer;
    fArchiveSize: Int64;
    fArchiveSharedFiles: Integer;
    fArchiveSharedSize: Int64;

    {$IF CompilerVersion >= 34.0} { Delphi 10.4 }
    Sync: TLightweightMREW;
    {$ELSE}
    Sync: IReadWriteSync;
    {$IFEND}
    procedure SetMultiThreaded(aValue: Boolean);
    function GetDDSMipChunkNum(aWidth, aHeight, aMipMaps: Integer): Integer;

  public
  const
    cExceptionInvalidDDS = 'Not a valid DDS file';
    cExceptionInvalidGNF = 'Not a valid GNF file';
    cExceptionUnsupportedDDS = 'Unsupported DDS format';
    cExceptionUnsupportedGNF = 'Unsupported GNF format';
    cExceptionIsXboxDDS = 'DDS is in XBox format';
    cExceptionIsNotXboxDDS = 'DDS is not in XBox format';
    cExceptionSingleChunk = 'Archive supports single chunk only';

    cArchiveTargetNames: array[TwbBSArchiveTarget] of string = (
      'PC',
      'XBox',
      'PS'
    );
    // max game supported file offset in .bsa archives
    BSA_MAX_OFFSET = High(Integer);
    // texture archive types with chunked textures
    cDDSArchiveTypes: TwbBSArchiveTypes = [baFO4dds, baSFdds];
    cArchiveFormatNames: array[TwbBSArchiveType] of string = (
      'None',
      'Morrowind',
      'Oblivion',
      'Skyrim LE, New Vegas, Fallout 3',
      'Skyrim AE, Skyrim SE',
      'Fallout 4',
      'Fallout 4 DDS',
      'Starfield',
      'Starfield DDS'
    );
    // supported compression types, first is the default one
    cArchiveCompressionTypes: array[TwbBSArchiveType] of TwbCompressionTypes = (
      [ctNone],
      [ctNone],
      [ctZLib],
      [ctZLib],
      [ctLZ4F],
      [ctZLib],
      [ctZLib],
      [ctZLib, ctLZ4],
      [ctLZ4, ctZLib]
    );
    // default archive extension
    cArchiveTypeExtensions: array[TwbBSArchiveType] of string = (
      '.bsa',
      '.bsa',
      '.bsa',
      '.bsa',
      '.bsa',
      '.ba2',
      '.ba2',
      '.ba2',
      '.ba2'
    );
    cArchiveFlagNames: array [0..9] of string = (
      'Include Directory Names', 'Include File Names', 'Compressed',
      'Retain Directory Names', 'Retain File Names',
      'Retain File Name Offsets', 'XBox 360 Archive',
      'Retain Strings During Startup',
      'Embedded File Names', 'XMem Codec'
    );
    cFileFlagNames: array [0..8] of string = (
      'Meshes', 'Textures', 'Menus', 'Sounds',
      'Voices', 'Shaders', 'Trees', 'Fonts',
      'Misc'
    );

    class function IsArchive(const aFileName: string): Boolean;
    class function IsDDSArchive(aType: TwbBSArchiveType): Boolean; inline;
    class function FormatName(aType: TwbBSArchiveType): string; inline;
    class function DefaultSplitSize(aType: TwbBSArchiveType): Int64;
    class function DefaultExtension(aType: TwbBSArchiveType): string; inline;
    class function DefaultCompression(aType: TwbBSArchiveType): TwbCompressionType; inline;
    class function SupportsCompression(aType: TwbBSArchiveType; aCType: TwbCompressionType): Boolean;
    class procedure DetectFlags(aType: TwbBSArchiveType; aFilesList: TStrings;
      const aFilesCompression: TArray<Boolean>; out aArchiveFlags, aFileFlags: Cardinal);
    constructor Create; virtual;
    destructor Destroy; override;
    procedure SyncBeginWrite; inline;
    procedure SyncEndWrite; inline;
    procedure CreateArchive(const aFileName: string; aType: TwbBSArchiveType;
      aFilesList: TStringList = nil; const aFilesCompression: TArray<Boolean> = nil); virtual; abstract;
    procedure Save; virtual; abstract;
    procedure Close; virtual;

    property FileName: string read fFileName;
    property ArchiveType: TwbBSArchiveType read fType;
    property ArchiveTarget: TwbBSArchiveTarget read fTarget write fTarget;
    property CompressionType: TwbCompressionType read fCompressionType write fCompressionType;
    property ShareData: Boolean read fShareData write fShareData;
    property MultiThreaded: Boolean read fMultiThreaded write SetMultiThreaded;
    property ArchiveFlags: Cardinal read fArchiveFlags write fArchiveFlags;
    property FileFlags: Cardinal read fFileFlags write fFileFlags;
    property MaxChunkCount: Integer read fMaxChunkCount write fMaxChunkCount;
    property SingleMipChunkX: Integer read fSingleMipChunkX write fSingleMipChunkX;
    property SingleMipChunkY: Integer read fSingleMipChunkY write fSingleMipChunkY;
    property ArchiveSize: Int64 read fArchiveSize;
    property ArchiveSharedSize: Int64 read fArchiveSharedSize;
    property ArchiveSharedFiles: Integer read fArchiveSharedFiles;
  end;

  TwbBSArchive = class(TwbCustomBSArchive)
  type
    TArchiveState = (stReading, stWriting);
    TArchiveStates = set of TArchiveState;
    TPackedDataIndex = record
      Chunk: TwbBSFileChunk;
      Size: Cardinal;
      Hash: TwbLookupHash;
      Compress: Boolean;
    end;
    TwbBSFolderTES4 = record
      Hash: UInt64;
      Offset: Int64;
      Name: string;
      Files: array of TwbBSFileEntry;
    end;

  private
    fStream: TwbBaseCachedFileStream;
    fStates: TArchiveStates;
    fDDSInfoProc: TwbDDSInfoProc;
    fPacker: TwbBSArchivePacker;
    fHeader: TwbBSHeader;
    fFiles: TList;
    fFoldersTES4: array of TwbBSFolderTES4;
    fDataOffset: Int64;
    fPackedData: array of TPackedDataIndex;
    fPackedDataCount: Integer;

    function GetFileEntry(Index: NativeInt): TwbBSFileEntry;
    function GetFilesCount: NativeInt;
    procedure SetFilesCount(aCount: NativeInt);
    function FindPackedData(aSize: Cardinal; aHash: TwbLookupHash; aChunk: TwbBSFileChunk): Boolean;
    procedure AddPackedData(aSize: Cardinal; aHash: TwbLookupHash; aChunk: TwbBSFileChunk);
    procedure PackData(aFile: TwbBSFileEntry; aChunk: TwbBSFileChunk;
      aData: Pointer; aSize, aUncompressedSize: Integer);
    procedure DecompressBuf(aSrc: Pointer; aSrcSize: Integer; aDst: Pointer; aDstSize: Integer);

  public
    constructor Create; override;
    destructor Destroy; override;
    function GetEnumerator: TwbBSArchiveEnumerator; inline;
    procedure LoadFromFile(const aFileName: string);
    procedure CreateArchive(const aFileName: string; aType: TwbBSArchiveType;
      aFilesList: TStringList = nil; const aFilesCompression: TArray<Boolean> = nil); override;
    procedure Save; override;
    procedure Close; override;
    function Info: string;
    function Warnings: TArray<string>;
    procedure Pack(aFile: TwbBSFileEntry; aData: Pointer; aSize: Integer); overload;
    procedure Pack(aFile: TwbBSFileEntry; const aData: TBytes); overload;
    procedure Pack(const aFileName: string; const aData: TBytes); overload;
    function Unpack(aFile: TwbBSFileEntry): TBytes; overload;
    function Unpack(const aFileName: string): TBytes; overload;
    procedure Unpack(const aFileName: string; aStream: TStream); overload;
    procedure Unpack(const aFileName, aSaveAs: string); overload;
    function FileByName(const aFileName: string): TwbBSFileEntry;
    function FilesByFolder(const aFolder: string): TwbBSFileEntries;
    function FileExists(const aFileName: string): Boolean;

    property Version: Cardinal read fHeader.Version;
    property Items[Index: NativeInt]: TwbBSFileEntry read GetFileEntry; default;
    property Count: NativeInt read GetFilesCount write SetFilesCount;
    property DDSInfoProc: TwbDDSInfoProc read fDDSInfoProc write fDDSInfoProc;
    property Packer: TwbBSArchivePacker read fPacker write fPacker;
  end;


  // Packer provides preprocessed data for TwbBSArchive ready to be written as is:
  // compressed when needed and chunked for DDS archives
  // aFileObject param is from aFilesList.Objects[] property of CreateArchive()
  TwbBSArchivePacker = class(TwbCustomBSArchive)
    // called by TwbBSArchive to get data to directly write into archive
    procedure GetChunk(const aFileName: string; aFileObject: Pointer;
      out aBuffer: Pointer; out aSize, aUncompressedSize: Integer;
      aChunkIndex: Integer = 0); virtual; abstract;
  end;


  // Creates multiple archives split by size in SplitSize property
  // Process() must be called ProcessCount times to fully complete packing
  // supports multihtreading
  TwbSplitPacker = class(TwbBSArchivePacker)
  type
    TPackedFile = record
      Next: Pointer;
      FileName: string;
      FileObject: Pointer;
      Compress: Boolean;
      ArchiveIndex: Integer;
      ShareSize: Integer;
      ShareHash: TwbLookupHash;
      Chunks: array of record
        UncompressedSize: Integer;
        Data: TBytes;
      end;
      procedure AddChunk(const aData: TBytes; aUncompressedSize: Integer);
    end;
    PPackedFile = ^TPackedFile;

  private
    fSplitSize: Int64;
    fFiles: array of TPackedFile;
    fArchives: TwbBSArchives;
    fLoadedSize: Int64;
    fLoadingCount: Integer;
    fErrorCount: Integer;
    fProcessCount: Integer;
    fProcessTick: Integer;
    // file chains: waiting to be loaded, loaded, waiting to be written
    fPending: PPackedFile;
    fLoaded: PPackedFile;
    fWritten: PPackedFile;
    function NewArchiveName: string;
    function AddArchive: TwbBSArchive;
    procedure MakeArchiveForLoaded;
    function GetFile(var aChain: PPackedFile; aWait: Boolean = False): PPackedFile;
    procedure LoadFile(aPackedFile: PPackedFile);
    procedure WriteFile(aPackedFile: PPackedFile);

  protected
    // must be overridden in descendant class to return the source file's data
    function GetSourceFileData(const aFileName: string; aFileObject: Pointer): TBytes; virtual; abstract;

  public
    procedure CreateArchive(const aFileName: string; aType: TwbBSArchiveType;
      aFilesList: TStringList = nil; const aFilesCompression: TArray<Boolean> = nil); override;
    procedure Save; override;
    procedure Close; override;
    procedure GetChunk(const aFileName: string; aFileObject: Pointer;
      out aBuffer: Pointer; out aSize, aUncompressedSize: Integer;
      aChunkIndex: Integer = 0); override;
    procedure Process;
    property ProcessCount: Integer read fProcessCount;
    property SplitSize: Int64 read fSplitSize write fSplitSize;
    property Archives: TwbBSArchives read fArchives;
  end;

  // Packs files from multiple source locations: archives, folders, individual files
  // Sources are added with AddSource* methods in overriding order
  // later ones win on assets with matching names
  // Compression is set globally for all files by Compressed property
  TwbMultiSourcePacker = class(TwbSplitPacker)
  private
    fCompress: Boolean;
    fFilters: TArray<string>;
    fSourceFiles: array of record
      AssetName: string;
      Hash: TwbLookupHash;
      SourceFileName: string;
      SourceFileEntry: TwbBSFileEntry;
      Compress: Boolean;
    end;
    fSourceFilesCount: Integer;
    fSourceArchives: array of TwbBSArchive;
    procedure SetFilters(aFilters: TArray<string>);
    function Add(const aAssetName, aSourceFileName: string; aSourceFileEntry: TwbBSFileEntry;
      aCheck: Boolean = True): Boolean;

  protected
    function GetSourceFileData(const aFileName: string; aFileObject: Pointer): TBytes; override;

  public
    procedure Close; override;
    procedure CreateArchive(const aFileName: string; aType: TwbBSArchiveType;
      aFilesList: TStringList = nil; const aFilesCompression: TArray<Boolean> = nil); override;
    function AddSourceFile(const aFileName: string): Integer;
    function AddSourceFolder(const aFolder: string): Integer;
    function AddSourceArchive(const aArchive: string): Integer;
    function AddSource(const aPath: string): Integer;
    property Compress: Boolean read fCompress write fCompress;
    property Filters: TArray<string> read fFilters write SetFilters;
    property SourceFilesCount: Integer read fSourceFilesCount;
  end;

  // Group identical datas
  TwbSameData = record
    Sync: TLightweightMREW;
    Datas: array of record
      Hash: TwbLookupHash;
      DataSize: UInt64;
      DataIndices: array of Integer;
    end;
    DatasCount: Integer;
    class operator Initialize(out Dest: TwbSameData);
    procedure Add(aDataIndex: Integer; aData: Pointer; aDataSize: UInt64); overload;
    procedure Add(aDataIndex: Integer; const aData: TBytes); overload;
  end;


  TwbAssetType = (
    atNone,
    atMesh, atTexture, atMaterial, atGeometry,
    atSound, atVoice, atMusic,
    atScript, atSource, atSourceSSE,
    atStrings, atSpeedTree, atVideo, atLODSettings, atDistantLOD,
    atInterface, atProgram,
    atMenus, atFont, atFacegen, atLSData, atShaders, atShadersFX,
    atGrass, atPreVis, atSeq, atDialogueViews,
    atBookArt, atIcon, atSplash
  );

  TwbAsset = class abstract
  type
    TAssetParts = record
      Folder: string;
      FolderNoDelimiter: string;
      FileName: string;
      FileNameNoExtension: string;
      Extension: string;
      ExtensionNoDot: string;
    end;
    TAssetDesc = record
      Typ: TwbAssetType;
      Root: string;
      Ext: array of string;
    end;
  const
    cDataFolders: array [0..1] of string = ('data', 'data files');
    cBSAssets: array [0..29] of TAssetDesc = (
      (Typ: atMesh;           Root: 'meshes';         Ext: ['.nif', '.kf', '.kfm', '.egm', '.egt', '.tri', '.psa', '.hkt', '.hkx', '.ssf', '.btr', '.bto', '.btt', '.dtl']),
      (Typ: atTexture;        Root: 'textures';       Ext: ['.dds', '.tga', '.png']),
      (Typ: atMaterial;       Root: 'materials';      Ext: ['.bgsm', '.bgem']),
      (Typ: atGeometry;       Root: 'geometries';     Ext: ['.mesh']),
      (Typ: atVoice;          Root: 'sound\voice';    Ext: ['.lip', '.wav', '.xwm', '.mp3', '.ogg', '.fuz']),
      (Typ: atSound;          Root: 'sound';          Ext: ['.wav', '.xwm', '.ogg']),
      (Typ: atMusic;          Root: 'music';          Ext: ['.xwm', '.mp3']),
      (Typ: atSource;         Root: 'scripts\source'; Ext: ['.psc']),
      (Typ: atSourceSSE;      Root: 'source\scripts'; Ext: ['.psc']),
      (Typ: atScript;         Root: 'scripts';        Ext: ['.pex', '.psc']),
      (Typ: atStrings;        Root: 'strings';        Ext: ['.strings', '.ilstrings', '.dlstrings']),
      (Typ: atSpeedTree;      Root: 'trees';          Ext: ['.spt']),
      (Typ: atVideo;          Root: 'video';          Ext: ['.bik', '.bk2']),
      (Typ: atLODSettings;    Root: 'lodsettings';    Ext: ['.lodsettings', '.dlodsettings', '.lod']),
      (Typ: atDistantLOD;     Root: 'distantlod';     Ext: ['.cmp', '.lod']), // TES4
      (Typ: atInterface;      Root: 'interface';      Ext: ['.swf', '.png', '.txt']),
      (Typ: atProgram;        Root: 'programs';       Ext: ['.swf']), // FO4
      (Typ: atMenus;          Root: 'menus';          Ext: ['.xml', '.htm', '.txt', '.scc', '.bat']), // TES4
      (Typ: atFont;           Root: 'fonts';          Ext: ['.fnt', '.tex']), // TES4
      (Typ: atFacegen;        Root: 'facegen';        Ext: ['.ctl']), // TES4
      (Typ: atLSData;         Root: 'lsdata';         Ext: ['.dat']), // TES4
      (Typ: atShaders;        Root: 'shaders';        Ext: ['.sdp']), // TES4
      (Typ: atShadersFX;      Root: 'shadersfx';      Ext: ['.fxp']), // TES5
      (Typ: atGrass;          Root: 'grass';          Ext: ['.gid']),
      (Typ: atPreVis;         Root: 'vis';            Ext: ['.uvd']),
      (Typ: atSeq;            Root: 'seq';            Ext: ['.seq']), // TES5
      (Typ: atDialogueViews;  Root: 'dialogueviews';  Ext: ['.xml']),
      (Typ: atBookArt;        Root: 'bookart';        Ext: ['.dds', '.tga']), // TES3
      (Typ: atIcon;           Root: 'icons';          Ext: ['.dds', '.tga']), // TES3
      (Typ: atSplash;         Root: 'splash';         Ext: ['.dds', '.tga']) // TES3
    );
    cSkippedExtensions: array [0..28] of string = (
      '.bsa', '.ba2', '.esm', '.esp', '.esl',
      '.nam', '.sdp', '.cdx', '.csg', '.override',
      '.ghost', '.exe', '.dll', '.pdb',
      '.bak', '.db', '.psd', '.jpg', '.jpeg',
      '.3ds', '.max', '.blend', '.obj', '.xlsx',
      '.docx', '.7z', '.zip', '.rar', '.tmp'
    );

    class function LastCharPos(const s: string; const Chr: Char): Integer; inline;
    class function SplitDirName(const aFileName: string; var Dir, Name: string): Integer;
    class function SplitNameExt(const aFileName: string; var Name, Ext: string; aNoExtDot: Boolean = False): Integer;
    class function Split(const aFileName: string): TAssetParts;
    class function AssetTypeByFolder(const aAssetName: string): TwbAssetType;
    class function AssetTypeByExtension(const aAssetName: string): TwbAssetType;
    class function GetAssetName(const aFileName: string; const aRoot: string = '';
      AssetType: TwbAssetType = atNone): string;
    class function GetNonASCII(const aFileName: string): string;
    class function IsValidAssetName(const aName: string): Boolean;
    class function DoNotPack(const aFileName: string): Boolean;
    class function DoNotCompress(const aFileName: string): Boolean;
  end;

function FormatSize(Bytes: Int64): string;


implementation

uses
  System.Math,
  System.IOUtils;

const
  MAGIC_TES3: TMagic4 = #0#1#0#0;
  MAGIC_BSA : TMagic4 = 'BSA'#0;
  MAGIC_BTDX: TMagic4 = 'BTDX';
  MAGIC_GNRL: TMagic4 = 'GNRL';
  MAGIC_GNMF: TMagic4 = 'GNMF';

  // max allowed chunks in BA2 texture archives, hardcoded to 4 in BGS engine
  CHUNK_COUNT_MAX = 4;
  CHUNK_HEADER_SIZE_GNRL = 16;
  CHUNK_HEADER_SIZE_DX10 = 24;
  CHUNK_HEADER_SIZE_GNMF = 48;
  COMPRESSION_METHOD_ZLIB = 0;
  COMPRESSION_METHOD_LZ4 = 3;
  DDS_FLAG_CUBEMAP = $01;
  iFileFO4Tail = $BAADF00D;

  // header versions
  HEADER_VERSION_TES4    = $67; // Oblivion
  HEADER_VERSION_FO3     = $68; // FO3, FNV, TES5
  HEADER_VERSION_SSE     = $69; // SSE
  HEADER_VERSION_FO4v1   = $01; // FO4
  HEADER_VERSION_SFv2    = $02; // SF
  HEADER_VERSION_SFv3    = $03; // SF
  HEADER_VERSION_FO4v7   = $07; // FO4 NG/AE
  HEADER_VERSION_FO4v8   = $08; // FO4 NG/AE


  // archive flags
  {
    HAS_DIRECTORY_STRINGS            = 1u << 0,
    HAS_FILE_STRINGS                = 1u << 1,
    COMPRESSED                        = 1u << 2,
    RETAIN_DIRECTORY_NAMES            = 1u << 3,
    RETAIN_FILE_NAMES                = 1u << 4,
    RETAIN_FILE_NAME_OFFSETS        = 1u << 5,
    XBOX_ARCHIVE                    = 1u << 6,
    RETAIN_STRINGS_DURING_STARTUP    = 1u << 7,
    EMBEDDED_FILE_NAMES                = 1u << 8,
    XBOX_COMPRESSED                    = 1u << 9,
  }
  ARCHIVE_PATHNAMES  = $0001; // Whether the BSA has names for paths
  ARCHIVE_FILENAMES  = $0002; // Whether the BSA has names for files
  ARCHIVE_COMPRESS   = $0004; // Whether the files are compressed in archive (inverts FILE_SIZE_COMPRESS flag)
  ARCHIVE_RETAINDIR  = $0008;
  ARCHIVE_RETAINNAME = $0010;
  ARCHIVE_RETAINFOFF = $0020;
  ARCHIVE_XBOX360    = $0040;
  ARCHIVE_STARTUPSTR = $0080;
  ARCHIVE_EMBEDNAME  = $0100; // Whether the name is prefixed to the data
  ARCHIVE_XMEM       = $0200;
  ARCHIVE_UNKNOWN10  = $0400;
  ARCHIVE_DEFAULT    = ARCHIVE_PATHNAMES or ARCHIVE_FILENAMES; // always set flags

  // file flags
  FILE_MESHES   = $0001;
  FILE_TEXTURES = $0002;
  FILE_MENUS    = $0004;
  FILE_SOUNDS   = $0008;
  FILE_VOICES   = $0010;
  FILE_SHADERS  = $0020; // TXT, HTML, BAT, SCC
  FILE_TREES    = $0040;
  FILE_FONTS    = $0080; // TEX, FNT
  FILE_MISC     = $0100; // CTL and others

  FILE_SIZE_COMPRESS = $40000000; // Whether the file is compressed


function Magic2Int(const aMagic: TMagic4): Cardinal; inline;
begin
  Result := PCardinal(@aMagic)^;
end;

function Int2Magic(aInt: Cardinal): TMagic4; inline;
begin
  Result := PMagic4(@aInt)^;
end;

function String2Magic(const aStr: string): TMagic4;
begin
  Result := #0#0#0#0;
  if Length(aStr) > 0 then Result[0] := AnsiChar(aStr[1]);
  if Length(aStr) > 1 then Result[1] := AnsiChar(aStr[2]);
  if Length(aStr) > 2 then Result[2] := AnsiChar(aStr[3]);
  if Length(aStr) > 3 then Result[3] := AnsiChar(aStr[4]);
end;

function FormatSize(Bytes: Int64): string;
const
  Description: array [0..8] of string = ('Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB');
begin
  var i := 0;
  while Bytes >= IntPower(1024, i + 1) do Inc(i);
  Result := FormatFloat('###0.##', Bytes / IntPower(1024, i)) + ' ' + Description[i];
end;


{TwbAsset}

class function TwbAsset.LastCharPos(const s: string; const Chr: Char): Integer;
begin
  for Result := Length(s) downto 1 do
    if s[Result] = Chr then
      Exit;
  Result := 0;
end;

class function TwbAsset.SplitDirName(const aFileName: string; var Dir, Name: string): Integer;
begin
  Result := LastCharPos(aFileName, '\');
  if Result = 0 then
    Result := LastCharPos(aFileName, '/');
  if Result <> 0 then begin
    Dir := Copy(aFileName, 1, Pred(Result));
    Name := Copy(aFileName, Succ(Result), Length(aFileName) - Result);
  end
  else begin
    Dir := '';
    Name := aFileName;
  end;
end;

class function TwbAsset.SplitNameExt(const aFileName: string; var Name, Ext: string; aNoExtDot: Boolean = False): Integer;
begin
  Result := LastCharPos(aFileName, '.');
  if Result <> 0 then begin
    Name := Copy(aFileName, 1, Pred(Result));
    if aNoExtDot then
      Inc(Result);
    Ext := Copy(aFileName, Result, Length(aFileName) - Result + 1);
  end
  else begin
    Name := aFileName;
    Ext := '';
  end;
end;

class function TwbAsset.Split(const aFileName: string): TAssetParts;
begin
  SplitDirName(aFileName, Result.FolderNoDelimiter, Result.FileName);
  Result.Folder := Result.FolderNoDelimiter + '\';
  SplitNameExt(Result.FileName, Result.FileNameNoExtension, Result.ExtensionNoDot, True);
  Result.Extension := '.' + Result.ExtensionNoDot;
end;

class function TwbAsset.AssetTypeByFolder(const aAssetName: string): TwbAssetType;
begin
  for var a in cBSAssets do
    if SameText(aAssetName, a.Root) or aAssetName.StartsWith(a.Root + '\', True) then begin
      Result := a.Typ;
      Exit;
    end;
  Result := atNone;
end;

class function TwbAsset.AssetTypeByExtension(const aAssetName: string): TwbAssetType;
var
  n, ext: string;
begin
  SplitNameExt(aAssetName, n, ext);
  ext := LowerCase(ext);
  for var a in cBSAssets do
    for var i := Low(a.Ext) to High(a.Ext) do
      if ext = a.Ext[i] then begin
        Result := a.Typ;
        Exit;
      end;
  Result := atNone;
end;

class function TwbAsset.GetAssetName(const aFileName: string; const aRoot: string = '';
  AssetType: TwbAssetType = atNone): string;
var
  i: Integer;
begin
  Result := '';

  // skip too short, empty and beth slop
  if (Length(aFileName) < 2) or (Trim(aFileName) = '') or (Pos(#8'NOR', aFileName) <> 0) then
    Exit;

  var path := '\' + StringReplace(LowerCase(aFileName), '/', '\', [rfReplaceAll]);

  try

  // searching for Data folder first
  for var f in cDataFolders do begin
    i := Pos('\' + f + '\', path);
    if i <> 0 then begin
      Result := Copy(aFileName, i + Length(f) + 1, Length(aFileName));
      Exit;
    end;
  end;

  // searching for known asset folders
  for var a in cBSAssets do begin
    if (AssetType <> atNone) and (a.Typ <> AssetType) then Continue;
    i := Pos('\' + a.Root + '\', path);
    if i <> 0 then begin
      Result := Copy(aFileName, i, Length(aFileName));
      Exit;
    end;
  end;

  // if root folder is provided use it
  if aRoot <> '' then begin
    path := IncludeTrailingPathDelimiter(aRoot);
    Result := Copy(aFileName, Length(path) + 1, Length(aFileName));
    Exit;
  end;

  // last resort - detect asset type by extension if not provided
  if AssetType = atNone then begin
    AssetType := AssetTypeByExtension(path);
    // priority goes to sound over voice and music (audio uses the same extensions mostly)
    if AssetType in [atVoice, atMusic] then AssetType := atSound;
    // unknonws go into meshes by default
    if AssetType = atNone then AssetType := atMesh;
  end;

  // prepend with Asset type root
  for var a in cBSAssets do
    if a.Typ = AssetType then begin
      // use file name only from absolute paths
      if TPath.IsPathRooted(aFileName) then
        Result := a.Root + '\' + ExtractFileName(aFileName)
      else
        Result := a.Root + '\' + aFileName;
      Exit;
    end;

  finally
    Result := StringReplace(Result, '/', '\', [rfReplaceAll]);
    Result := StringReplace(Result, '\\', '\', [rfReplaceAll]);
  end;
end;

class function TwbAsset.GetNonASCII(const aFileName: string): string;
begin
  Result := '';
  for var c in aFileName do
    if Word(c) > 127 then Result := Result + c;
end;

class function TwbAsset.IsValidAssetName(const aName: string): Boolean;
begin
  Result := False;
  Result := Result or aName.IsEmpty;
  Result := Result or aName.Contains('\\');
  Result := Result or (aName.IndexOf('/') <> -1);
  Result := Result or (aName.IndexOf('\') < 1);
  Result := Result or (aName.LastIndexOf('\') = Pred(Length(aName)));
  Result := Result or not TPath.HasValidPathChars(TPath.GetDirectoryName(aName), False);
  Result := Result or not TPath.HasValidFileNameChars(TPath.GetFileName(aName), False);
  Result := Result or not TPath.IsRelativePath(TPath.GetDirectoryName(aName));
  Result := not Result;
end;

class function TwbAsset.DoNotPack(const aFileName: string): Boolean;
begin
  var ext := LowerCase(ExtractFileExt(aFileName));
  for var s in cSkippedExtensions do begin
    Result := ext = s;
    if Result then
      Exit;
  end;
  Result := False;
end;

class function TwbAsset.DoNotCompress(const aFileName: string): Boolean;
begin
  Result :=
    (AssetTypeByFolder(aFileName) in [atSound, atVoice, atMusic, atStrings])
    and not aFileName.EndsWith('.fuz', True)
    and not aFileName.EndsWith('.hkx', True); // anims for dialogue lines in sounds\voice folder
end;


{ TwbSameData }

class operator TwbSameData.Initialize(out Dest: TwbSameData);
begin
  Dest.DatasCount := 0;
end;

procedure TwbSameData.Add(aDataIndex: Integer; aData: Pointer; aDataSize: UInt64);
begin
  var Hash := TwbHash.LookupHash(aData, aDataSize);
  Sync.BeginWrite;
  try
    for var i := 0 to Pred(DatasCount) do
      if (Datas[i].DataSize = aDataSize) and (Datas[i].Hash = Hash) then begin
        Datas[i].DataIndices := Datas[i].DataIndices + [aDataIndex];
        Exit;
      end;

    if DatasCount = Length(Datas) then
      if Length(Datas) = 0 then
        SetLength(Datas, 8192)
      else
        SetLength(Datas, Length(Datas) * 2);

    Datas[DatasCount].DataSize := aDataSize;
    Datas[DatasCount].Hash := Hash;
    Datas[DatasCount].DataIndices := [aDataIndex];
    Inc(DatasCount);
  finally
    Sync.EndWrite;
  end;
end;

procedure TwbSameData.Add(aDataIndex: Integer; const aData: TBytes);
begin
  Add(aDataIndex, aData, Length(aData));
end;


{ TwbBSFileChunk }

function TwbBSFileChunk.GetCompressed: Boolean;
begin
  Result := PackedSize <> 0;
end;


{ TwbBSFileEntry }

constructor TwbBSFileEntry.Create(aArchive: TwbBSArchive);
begin
  inherited Create;
  Archive := aArchive;
end;

destructor TwbBSFileEntry.Destroy;
begin
  for var c in TexChunks do c.Free;
  inherited;
end;

function TwbBSFileEntry.GetCompressed: Boolean;
begin
  if Archive.IsDDSArchive(Archive.ArchiveType) then
    Result := (Length(TexChunks) <> 0) and TexChunks[0].Compressed
  else
    Result := inherited;
end;

function TwbBSFileEntry.DXGIFormatName: string;
begin
  Result := TwbDDS.GetDXGIFormatName(TDXGI(DDS.DXGIFormat));
end;

function TwbBSFileEntry.IsCubeMap: Boolean;
begin
  if Archive.ArchiveTarget in [btPC, btXBox] then
    Result := DDS.Flags and DDS_FLAG_CUBEMAP <> 0
  else
    Result := GNF.TextureType = Cardinal(GNF_TEXTURE_CUBEMAP);
end;

function TwbBSFileEntry.Unpack: TBytes;
begin
  Result := Archive.Unpack(Self);
end;

function TwbBSFileEntry.Info: string;
  function IfThen(aCondition: Boolean; const aValue1, aValue2: string): string; inline;
  begin
    if aCondition then Result := aValue1 else Result := aValue2;
  end;
begin
  case Archive.ArchiveType of
    baTES3:
      Result := Format('  Hash: %s  Size: %d  Offset: %d', [
        NameHash64.ToHexString,
        Size,
        Offset
      ]);
    baTES4, baFO3, baSSE:
      Result := Format('  DirHash: %s  NameHash: %s  %sSize: %d  Offset: %d', [
        DirHash64.ToHexString,
        NameHash64.ToHexString,
        IfThen(Compressed, 'Packed', ''),
        Size,
        Offset
      ]);
    baFO4, baFO4dds, baSF, baSFdds: begin
      Result := Format('  DirHash: %s  NameHash: %s  Ext: %s', [
        DirHash32.ToHexString,
        NameHash32.ToHexString,
        string(Ext)
      ]);
      if Archive.ArchiveType in [baFO4, baSF] then
        Result := Result + Format('  Size: %d  PackedSize: %d  Offset: %d', [
          Size,
          PackedSize,
          Offset
        ])
      else if Archive.IsDDSArchive(Archive.ArchiveType) then begin
        if Archive.ArchiveTarget in [btPC, btXBox] then
          Result := Result + Format(#13#10'  Width: %04d  Height: %04d  CubeMap: %s  Format: %s', [
            DDS.Width,
            DDS.Height,
            IfThen(IsCubeMap, 'Yes', 'No'),
            DXGIFormatName
          ]);
        if Archive.ArchiveTarget = btPS then
          Result := Result + Format(#13#10'  Width: %04d  Height: %04d  CubeMap: %s  Format: %s_%s', [
            GNF.Width,
            GNF.Height,
            IfThen(IsCubeMap, 'Yes', 'No'),
            GNF.SurfaceFormatName,
            GNF.ChannelTypeName
          ]);
        for var c in TexChunks do
          Result := Result + Format(#13#10'    MipMaps %.2d-%.2d  Size: %8d  PackedSize: %8d  Offset: %d', [
            c.StartMip,
            c.EndMip,
            c.Size,
            c.PackedSize,
            c.Offset
          ]);
      end;
    end;
  end;
end;


{ TwbCustomBSArchive }

constructor TwbCustomBSArchive.Create;
begin
  fType := baNone;
  fMaxChunkCount := CHUNK_COUNT_MAX;
  fSingleMipChunkX := 512;
  fSingleMipChunkY := 512;
end;

destructor TwbCustomBSArchive.Destroy;
begin
  Close;
  inherited;
end;

procedure TwbCustomBSArchive.Close;
begin
  fType := baNone;
  fFileName := '';
  fCompressionType := ctNone;
  fArchiveFlags := 0;
  fFileFlags := 0;
  fArchiveSize := 0;
  fArchiveSharedSize := 0;
  fArchiveSharedFiles := 0;
end;

function TwbCustomBSArchive.GetDDSMipChunkNum(aWidth, aHeight, aMipMaps: Integer): Integer;
begin
  Result := 1;
  if aMipMaps = 0 then Inc(aMipMaps);
  while (Result < aMipMaps) and
        (Result < fMaxChunkCount) and
        (aWidth >= fSingleMipChunkX) and
        (aHeight >= fSingleMipChunkY)
  do begin
    Inc(Result);
    aWidth := aWidth div 2;
    aHeight := aHeight div 2;
  end;
end;

procedure TwbCustomBSArchive.SetMultiThreaded(aValue: Boolean);
begin
  fMultiThreaded := aValue;
  {$IF CompilerVersion < 34.0}
  if fMultiThreaded and not Assigned(Sync) then
    Sync := TReadWriteSync.Create;
  {$IFEND}
end;

class function TwbCustomBSArchive.FormatName(aType: TwbBSArchiveType): string;
begin
  Result := cArchiveFormatNames[aType];
end;

class function TwbCustomBSArchive.DefaultSplitSize(aType: TwbBSArchiveType): Int64;
begin
  if aType in [baTES3, baTES4, baFO3, baSSE] then
    Result := BSA_MAX_OFFSET
  else
    Result := 0;
end;

class function TwbCustomBSArchive.DefaultExtension(aType: TwbBSArchiveType): string;
begin
  Result := cArchiveTypeExtensions[aType];
end;

class function TwbCustomBSArchive.DefaultCompression(aType: TwbBSArchiveType): TwbCompressionType;
begin
  Result :=cArchiveCompressionTypes[aType][0];
end;

class function TwbCustomBSArchive.SupportsCompression(aType: TwbBSArchiveType; aCType: TwbCompressionType): Boolean;
begin
  Result := False;
  for var ct in cArchiveCompressionTypes[aType] do begin
    Result := ct = aCType;
    if Result then Break;
  end;
end;

procedure TwbCustomBSArchive.SyncBeginWrite;
begin
  if fMultiThreaded then
    Sync.BeginWrite;
end;

procedure TwbCustomBSArchive.SyncEndWrite;
begin
  if fMultiThreaded then
    Sync.EndWrite;
end;

class function TwbCustomBSArchive.IsArchive(const aFileName: string): Boolean;
begin
  var ext := LowerCase(ExtractFileExt(aFileName));
  for var s in cArchiveTypeExtensions do begin
    Result := ext = s;
    if Result then
      Exit;
  end;
  Result := False;
end;

class function TwbCustomBSArchive.IsDDSArchive(aType: TwbBSArchiveType): Boolean;
begin
  Result := aType in cDDSArchiveTypes;
end;

class procedure TwbCustomBSArchive.DetectFlags(aType: TwbBSArchiveType; aFilesList: TStrings;
  const aFilesCompression: TArray<Boolean>; out aArchiveFlags, aFileFlags: Cardinal);
begin
  aFileFlags := 0;
  aArchiveFlags := ARCHIVE_DEFAULT;
  if aType = baTES4 then
    aArchiveFlags := aArchiveFlags or ARCHIVE_EMBEDNAME or ARCHIVE_XMEM or ARCHIVE_UNKNOWN10;

  for var i := 0 to Pred(aFilesList.Count) do begin
    var AssetType := TwbAsset.AssetTypeByFolder(aFilesList[i]);
    if AssetType = atNone then
      AssetType := TwbAsset.AssetTypeByExtension(aFilesList[i]);

    // determine file flags
    case AssetType of
      atMesh:         aFileFlags := aFileFlags or FILE_MESHES;
      atTexture:      aFileFlags := aFileFlags or FILE_TEXTURES;
      atSound:        aFileFlags := aFileFlags or FILE_SOUNDS;
      atVoice:        aFileFlags := aFileFlags or FILE_VOICES;
      atSpeedTree:    aFileFlags := aFileFlags or FILE_TREES;
      atFont:         aFileFlags := aFileFlags or FILE_FONTS;
      atMenus:        aFileFlags := aFileFlags or FILE_SHADERS;
      atDistantLOD,
      atLODSettings:  aFileFlags := aFileFlags or FILE_MESHES or FILE_MISC;
      else
        aFileFlags := aFileFlags or FILE_MISC;
    end;

    // FO3/FNV always set sounds+voices together like in vanilla archives
    // radio songs require voices but can have any path in sound folder and extension
    if (aType = baFO3) and (AssetType in [atSound, atVoice]) then
      aFileFlags := aFileFlags or FILE_SOUNDS or FILE_VOICES;

    // TES4 only
    if (aType = baTES4) and aFilesList[i].EndsWith('.xml', True) then
      aFileFlags := aFileFlags or FILE_MENUS;

    // determine archive flags

    // packed scripts can't be added to objects in the SSE CK if the archive was packed
    // without the "RetainNames" flag (the scripts aren't shown in the script adding window)
    if AssetType = atScript then
      aArchiveFlags := aArchiveFlags or ARCHIVE_RETAINNAME;
  end;

  // final flags detection

  // menus, shaders and fonts are Oblivion only
  if aType <> baTES4 then
    aFileFlags := aFileFlags and not (FILE_MENUS or FILE_SHADERS or FILE_FONTS);

  // misc file flag is not in Skyrim SE
  if aType = baSSE then
    aFileFlags := aFileFlags and not FILE_MISC;

  // embedded names flag in textures only archives
  if aFileFlags = FILE_TEXTURES then
    aArchiveFlags := aArchiveFlags or ARCHIVE_EMBEDNAME;

  // startupstr flag in archives with meshes
  if aFileFlags and FILE_MESHES <> 0 then
    aArchiveFlags := aArchiveFlags or ARCHIVE_STARTUPSTR;

  // retainname flag in archives with sounds
  if aFileFlags and FILE_SOUNDS <> 0 then
    aArchiveFlags := aArchiveFlags or ARCHIVE_RETAINNAME;

  // compressed flag if at least one file is compressed
  for var c in aFilesCompression do
    if c then begin
      aArchiveFlags := aArchiveFlags or ARCHIVE_COMPRESS;
      Break;
    end;
end;


{ TwbBSArchiveEnumerator }

constructor TwbBSArchiveEnumerator.Create(aArchive: TwbBSArchive);
begin
  inherited Create;
  fIndex := -1;
  fArchive := aArchive;
end;

function TwbBSArchiveEnumerator.GetCurrent: TwbBSFileEntry;
begin
  Result := fArchive[fIndex];
end;

function TwbBSArchiveEnumerator.MoveNext: Boolean;
begin
  Result := fIndex < fArchive.Count - 1;
  if Result then
    Inc(fIndex);
end;


{ TwbBSArchive }

constructor TwbBSArchive.Create;
begin
  inherited;
  fFiles := TList.Create;
end;

destructor TwbBSArchive.Destroy;
begin
  inherited;
  FreeAndNil(fFiles);
end;

function TwbBSArchive.GetFileEntry(Index: NativeInt): TwbBSFileEntry;
begin
  Result := TwbBSFileEntry(fFiles[Index]);
end;

function TwbBSArchive.GetFilesCount: NativeInt;
begin
  Result := fFiles.Count;
end;

procedure TwbBSArchive.SetFilesCount(aCount: NativeInt);
begin
  for var f in Self do f.Free;
  fFiles.Count := aCount;
  for var i := 0 to Pred(fFiles.Count) do
    fFiles[i] := TwbBSFileEntry.Create(Self);
end;

function TwbBSArchive.GetEnumerator: TwbBSArchiveEnumerator;
begin
  Result := TwbBSArchiveEnumerator.Create(Self);
end;

function TwbBSArchive.Info: string;
begin
  Result := '';
  Result := Result + Format('%014s: %s', ['Archive Name', FileName]);
  Result := Result + Format(#13#10'%014s: %s [%s]', ['Format', FormatName(fType), cArchiveTargetNames[fTarget]]);
  if ArchiveType <> baTES3 then
    Result := Result + Format(#13#10'%014s: 0x%s', ['Version', IntToHex(Version, 2)]);
  Result := Result + Format(#13#10'%014s: %d', ['Files', Count]);
  var c := 0;
  for var f in Self do if f.Compressed then Inc(c);
  Result := Result + Format(#13#10'%014s: %d (%s)', ['Compressed', c, TwbCompression.Name(CompressionType)]);
  if ArchiveType in [baTES4, baFO3, baSSE] then begin
    Result := Result + Format(#13#10'%014s: 0x%s%024s: 0x%s', [
      'Archive Flags', ArchiveFlags.ToHexString(4),
      'File Flags', FileFlags.ToHexString(4)
    ]);
    for var i := Low(cArchiveFlagNames) to High(cArchiveFlagNames) do begin
      var s := ''; var s2 := '';
      if (ArchiveFlags shr i) and 1 = 1 then s := '*' else s := ' ';
      if cArchiveFlagNames[i] <> '' then
        s := s + cArchiveFlagNames[i]
      else
        s := s + 'Bit ' + IntToStr(i);
      s := Format('%16s%s', [' ', s]);

      if i <= High(cFileFlagNames) then begin
        if (FileFlags shr i) and 1 = 1 then s2 := '*' else s2 := ' ';
        if cFileFlagNames[i] <> '' then
          s2 := s2 + cFileFlagNames[i]
        else
          s2 := s2 + 'Bit ' + IntToStr(i);
      end;
      Result := Result + Format(#13#10'%s%s%s', [s, StringOfChar(' ', 48 - Length(s)), s2]);
    end;
  end;
end;

function TwbBSArchive.Warnings: TArray<string>;
begin
  if fType = baTES3 then
    for var f in Self do
      if TwbAsset.AssetTypeByFolder(f.Name) in [atSound, atMusic, atVideo, atFont, atSplash] then begin
        Result := Result + ['Sound, Music, Video, Fonts and Splash folders don''t work when packed in Morrowind archives'];
        Break;
      end;

  if fType in [baTES3, baTES4, baFO3, baSSE] then begin
    var bad := 0;
    for var f in Self do
      if f.Offset > BSA_MAX_OFFSET then Inc(bad);
    if bad <> 0 then
      Result := Result + [bad.ToString + ' file(s) start above 2 GB max allowed BSA size, they won''t work or crash the game'];
  end;

  // embedded names is used for textures, isn't used for loose textures
  // Engine grabs file entries for textures in the texturelist on form load (MODT, TXST)
  // speeds up their loading (game searches for all file handles on form load instead of later)
  // texture is loaded as cubemap if contains "_e.dd" in embedded name (to also account for .ddx on xbox)
  // if texture is not loose and embedded names are missing then cubemaps aren't loaded properly!
  // Seems like crashing on anything but textures
  if (fType in [baTES4, baFO3, baSSE]) and (fHeader.Flags and ARCHIVE_EMBEDNAME = 0) then
    for var f in Self do
      if f.Name.EndsWith('_e.dds', True) then begin
        Result := Result + ['Contains cubemap _e.dds textures which aren''t loaded properly in the game without Embedded File Names flag'];
        Break;
      end;

  if (fType in [baFO3, baSSE]) and (fHeader.Flags and ARCHIVE_EMBEDNAME <> 0) then
    for var f in Self do
      if not f.Name.EndsWith('.dds', True) then begin
        Result := Result + ['Contains non texture files which may crash the game when packed with Embedded File Names flag'];
        Break;
      end;

  if IsDDSArchive(fType) or (fType = baSSE) then
    for var f in Self do
      if not f.Compressed then begin
        if (fType = baSSE) and (fHeader.Flags and ARCHIVE_EMBEDNAME <> 0) then
          Result := Result + ['Contains uncompressed files with Embedded File Names flag, such combination crashes Skyrim SE/AE']
        else if IsDDSArchive(fType) then
          Result := Result + ['DDS archive contains uncompressed textures which crash the game'];
        Break;
      end;
end;

function TwbBSArchive.FindPackedData(aSize: Cardinal; aHash: TwbLookupHash; aChunk: TwbBSFileChunk): Boolean;
begin
  Result := False;

  if not fShareData then
    Exit;

  for var i := 0 to Pred(fPackedDataCount) do
    if (aSize = fPackedData[i].Size) and TwbHash.SameLookupHash(aHash, fPackedData[i].Hash) then begin
      aChunk.Offset := fPackedData[i].Chunk.Offset;
      aChunk.Size := fPackedData[i].Chunk.Size;
      aChunk.PackedSize := fPackedData[i].Chunk.PackedSize;
      // in DDS archives count shared files for the first 0 mipmap chunk only
      if not ( (aChunk is TwbBSFileChunkTex) and (TwbBSFileChunkTex(aChunk).StartMip <> 0) ) then
        Inc(fArchiveSharedFiles);
      if aChunk.PackedSize <> 0 then
        Inc(fArchiveSharedSize, aChunk.PackedSize and not FILE_SIZE_COMPRESS)
      else
        Inc(fArchiveSharedSize, aChunk.Size);

      Result := True;
      Exit;
    end;
end;

procedure TwbBSArchive.AddPackedData(aSize: Cardinal; aHash: TwbLookupHash; aChunk: TwbBSFileChunk);
begin
  if not fShareData then
    Exit;

  if fPackedDataCount = Length(fPackedData) then
    if Length(fPackedData) = 0 then
      SetLength(fPackedData, 2048)
    else
      SetLength(fPackedData, Length(fPackedData) * 2);

  fPackedData[fPackedDataCount].Size := aSize;
  fPackedData[fPackedDataCount].Hash := aHash;
  fPackedData[fPackedDataCount].Chunk := aChunk;
  Inc(fPackedDataCount);
end;

procedure TwbBSArchive.LoadFromFile(const aFileName: string);
begin
  //if fStates * [stReading, stWriting] <> [] then
  Close;

  fFileName := aFileName;
  fStream := TwbReadOnlyCachedFileStream.Create(fFileName, fmOpenRead or fmShareDenyWrite);

  // magic
  fHeader.Magic := Int2Magic(fStream.ReadCardinal);
  if fHeader.Magic = MAGIC_TES3 then fType := baTES3 else
  if fHeader.Magic = MAGIC_BSA  then fType := baTES4 else
  if fHeader.Magic = MAGIC_BTDX then fType := baFO4 else
    raise Exception.Create('Unknown archive format');

  // archive version except Morrowind
  if fType <> baTES3 then begin
    fHeader.Version := fStream.ReadCardinal;
    case fHeader.Version of
      HEADER_VERSION_TES4:  fType := baTES4;
      HEADER_VERSION_FO3:   fType := baFO3;
      HEADER_VERSION_SSE:   fType := baSSE;
      HEADER_VERSION_FO4v1,
      HEADER_VERSION_FO4v7,
      HEADER_VERSION_FO4v8: fType := baFO4;
      HEADER_VERSION_SFv2,
      HEADER_VERSION_SFv3:  fType := baSF;
    else
      raise Exception.Create('Unknown archive version 0x' + IntToHex(fHeader.Version, 8));
    end;
  end;

  case fType of
    //--------------------------------------------------
    // Load Morrowind
    baTES3: begin
      // read header
      fHeader.HashOffset := fStream.ReadCardinal;
      fHeader.FileCount := fStream.ReadCardinal;
      Count := fHeader.FileCount;
      // read file records
      for var f in Self do begin
        f.Size := fStream.ReadCardinal;
        f.Offset := fStream.ReadCardinal;
      end;
      // skip name offsets
      fStream.Position := fStream.Position + 4 * Count;
      // read names
      for var f in Self do f.Name := fStream.ReadStringTerm;
      // read hashes
      for var f in Self do
        f.NameHash64 := fStream.ReadUInt64;
      // remember binary data offset since stored files offsets are relative
      fDataOffset := fStream.Position;
    end;

    //--------------------------------------------------
    // Load Oblivion, Fallout 3, New Vegas, Skyrim, Skyrim SE
    baTES4, baFO3, baSSE: begin
      // read header
      fHeader.FoldersOffset := fStream.ReadCardinal;
      fHeader.Flags := fStream.ReadCardinal;
      fHeader.FolderCount := fStream.ReadCardinal;
      fHeader.FileCount := fStream.ReadCardinal;
      fHeader.FolderNamesLength := fStream.ReadCardinal;
      fHeader.FileNamesLength := fStream.ReadCardinal;
      fHeader.FileFlags := fStream.ReadCardinal;
      fArchiveFlags := fHeader.Flags;
      fFileFlags := fHeader.FileFlags;

      // read folder records
      fStream.Position := fHeader.FoldersOffset;
      SetLength(fFoldersTES4, fHeader.FolderCount);
      for var i := Low(fFoldersTES4) to High(fFoldersTES4) do begin
        fFoldersTES4[i].Hash := fStream.ReadUInt64;
        SetLength(fFoldersTES4[i].Files, fStream.ReadCardinal); // FileCount
        if fType = baSSE then fStream.ReadCardinal; // padding
        fFoldersTES4[i].Offset := fStream.ReadCardinal;
        if fType = baSSE then fStream.ReadCardinal; // padding
      end;

      // read folder names and file records
      Count := fHeader.FileCount;
      var idx := 0;
      for var i := Low(fFoldersTES4) to High(fFoldersTES4) do begin
        fFoldersTES4[i].Name := fStream.ReadStringLen;
        for var j := Low(fFoldersTES4[i].Files) to High(fFoldersTES4[i].Files) do begin
          fFoldersTES4[i].Files[j] := Items[idx]; // not using this anywhere, not required for unpacking
          Items[idx].Name := fFoldersTES4[i].Name + '\';
          Items[idx].DirHash64 := fFoldersTES4[i].Hash;
          Items[idx].NameHash64 := fStream.ReadUInt64;
          Items[idx].Size := fStream.ReadCardinal;
          Items[idx].Offset := fStream.ReadCardinal;
          // compressed when either of flags present
          if (fHeader.Flags and ARCHIVE_COMPRESS <> 0) xor (Items[idx].Size and FILE_SIZE_COMPRESS <> 0) then
            Items[idx].PackedSize := Items[idx].Size;
          Items[idx].Size := Items[idx].Size and not FILE_SIZE_COMPRESS;
          Items[idx].PackedSize := Items[idx].PackedSize and not FILE_SIZE_COMPRESS;
          Inc(idx);
        end;
      end;

      // read file names
      for var f in Self do
        f.Name := f.Name + fStream.ReadStringTerm;
    end;

    //--------------------------------------------------
    // Load Fallout 4, Starfield
    baFO4, baSF: begin
      fCompressionType := ctZLib;
      // read header
      fHeader.Magic2 := Int2Magic(fStream.ReadCardinal);
      if (fHeader.Magic2 <> MAGIC_GNRL) and (fHeader.Magic2 <> MAGIC_DX10) and (fHeader.Magic2 <> MAGIC_GNMF) then
        raise Exception.Create('Unsupported BA2 archive type: ' + fHeader.Magic2);

      if (fHeader.Magic2 = MAGIC_DX10) or (fHeader.Magic2 = MAGIC_GNMF) then begin
        case fType of
          baFO4: fType := baFO4dds;
          baSF : fType := baSFdds;
        end;
        if fHeader.Magic2 = MAGIC_GNMF then
          fTarget := btPS
        // idk how to differentiare between PC and XBox, something in the image data itself
        // use archive filename
        else if LowerCase(FileName).Contains('_xbox.') then
          fTarget := btXBox;
      end;

      fHeader.FileCount := fStream.ReadCardinal;
      fHeader.FileTableOffset := fStream.ReadInt64;
      // SF header
      if fType in [baSF, baSFdds] then begin
        if fHeader.Version >= HEADER_VERSION_SFv2 then
          fStream.ReadUInt64; // always set to 1, immediately discarded on load
        if fHeader.Version >= HEADER_VERSION_SFv3 then begin
          fHeader.CompressionMethod := fStream.ReadCardinal;
          if fHeader.CompressionMethod = COMPRESSION_METHOD_LZ4 then
            fCompressionType := ctLZ4;
        end;
      end;

      // read files
      Count := fHeader.FileCount;
      for var f in Self do begin
        f.NameHash32 := fStream.ReadCardinal;
        f.Ext := Int2Magic(fStream.ReadCardinal);
        f.DirHash32 := fStream.ReadCardinal;
        f.ModIndex := fStream.ReadByte; // always 0
        var chunkscount := fStream.ReadByte;
        var headersize := fStream.ReadWord;
        // General
        if fHeader.Magic2 = MAGIC_GNRL then begin
          //if headersize <> CHUNK_HEADER_SIZE_GNRL then
          //  raise Exception.Create('Invalid chunk header size: ' + IntToStr(headersize));
          // GNRL must always have 1 chunk
          if chunkscount <> 1 then
            raise Exception.Create('Invalid chunks count ' + IntToStr(chunkscount) + ' for: ' + f.Name);
          f.Offset := fStream.ReadInt64;
          f.PackedSize := fStream.ReadCardinal;
          f.Size := fStream.ReadCardinal;
          fStream.ReadCardinal; // BAADF00D
        end
        // Textures
        else begin
          if fHeader.Magic2 = MAGIC_DX10 then begin
            //if headersize <> CHUNK_HEADER_SIZE_DX10 then
            //  raise Exception.Create('Invalid chunk header size: ' + IntToStr(headersize));
            f.DDS.Height := fStream.ReadWord;
            f.DDS.Width := fStream.ReadWord;
            f.DDS.NumMips := fStream.ReadByte;
            f.DDS.DXGIFormat := fStream.ReadByte;
            f.DDS.Flags := fStream.ReadByte;
            f.DDS.TileMode := fStream.ReadByte;
          end
          else if fHeader.Magic2 = MAGIC_GNMF then begin
            //if headersize <> CHUNK_HEADER_SIZE_GNMF then
            //  raise Exception.Create('Invalid chunk header size: ' + IntToStr(headersize));
            fStream.ReadBuffer(f.GNF, SizeOf(f.GNF));
          end;

          SetLength(f.TexChunks, chunkscount);
          for var i := Low(f.TexChunks) to High(f.TexChunks) do
            f.TexChunks[i] := TwbBSFileChunkTex.Create;
          for var c in f.TexChunks do begin
            c.Offset := fStream.ReadInt64;
            c.PackedSize := fStream.ReadCardinal;
            c.Size := fStream.ReadCardinal;
            c.StartMip := fStream.ReadWord;
            c.EndMip := fStream.ReadWord;
            fStream.ReadCardinal; // BAADF00D
          end;
        end;
      end;

      // read file names if present
      if (fHeader.FileTableOffset <> 0) and (fHeader.FileTableOffset < fStream.Size) then begin
        fStream.Position := fHeader.FileTableOffset;
        for var f in Self do
          f.Name := StringReplace(fStream.ReadStringLen16, '/', '\', [rfReplaceAll]); // archive2.exe uses /
      end else
        for var f in Self do
          f.Name := f.DirHash32.ToHexString + '\' + f.NameHash32.ToHexString + '.' + string(f.Ext);
    end;

  end;

  // default compression type if not decided during load
  if fCompressionType = ctNone then
    fCompressionType := DefaultCompression(fType);

  for var f in Self do
    f.LookupHash := TwbHash.LookupHash(f.Name, True);

  Include(fStates, stReading);
end;

function HashSortTES3(Item1, Item2: Pointer): Integer;
var
  f1, f2: TwbBSFileEntry;
  d1, n1, d2, n2: Cardinal;
begin
  f1 := TwbBSFileEntry(Item1);
  f2 := TwbBSFileEntry(Item2);
  d1 := f1.NameHash64 and $FFFFFFFF; n1 := f1.NameHash64 shr 32;
  d2 := f2.NameHash64 and $FFFFFFFF; n2 := f2.NameHash64 shr 32;
  if d1 < d2 then Result := -1 else
  if d1 > d2 then Result := 1  else
  if n1 < n2 then Result := -1 else
  if n1 > n2 then Result := 1  else
                  Result := 0;
end;

function HashSortTES4(Item1, Item2: Pointer): Integer;
var
  f1, f2: TwbBSFileEntry;
begin
  f1 := TwbBSFileEntry(Item1);
  f2 := TwbBSFileEntry(Item2);
  if f1.DirHash64 < f2.DirHash64 then   Result := -1 else
  if f1.DirHash64 > f2.DirHash64 then   Result := 1  else
  if f1.NameHash64 < f2.NameHash64 then Result := -1 else
  if f1.NameHash64 > f2.NameHash64 then Result := 1  else
                                        Result := 0;
end;

function AlphabeticalSort(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := CompareStr(List[Index1], List[Index2]);
end;

procedure TwbBSArchive.CreateArchive(const aFileName: string; aType: TwbBSArchiveType;
  aFilesList: TStringList = nil; const aFilesCompression: TArray<Boolean> = nil);

  function FileCompression(i: Integer): Boolean;
  begin
    if i < Length(aFilesCompression) then
      Result := aFilesCompression[i]
    else
      Result := False;
  end;

var
  fdir, fname, fext: string;
  i, len: Integer;
begin
  if stReading in fStates then
    Close;

  if stWriting in fStates then
    raise Exception.Create('Archive is already being created');

  if not Assigned(aFilesList) or (aFilesList.Count = 0) then
    raise Exception.Create('Files list to pack is empty');

  fFileName := aFileName;
  fType := aType;

  if fCompressionType = ctNone then
    fCompressionType := DefaultCompression(fType)
  else if not SupportsCompression(fType, fCompressionType) then
    raise Exception.Create('Unsupported compression type');

  // Magic, version
  case fType of
    baTES3: begin
      fHeader.Magic := MAGIC_TES3;
    end;
    baTES4: begin
      fHeader.Magic := MAGIC_BSA;
      fHeader.Version := HEADER_VERSION_TES4;
    end;
    baFO3: begin
      fHeader.Magic := MAGIC_BSA;
      fHeader.Version := HEADER_VERSION_FO3;
    end;
    baSSE: begin
      fHeader.Magic := MAGIC_BSA;
      fHeader.Version := HEADER_VERSION_SSE;
    end;
    baFO4: begin
      fHeader.Magic := MAGIC_BTDX;
      fHeader.Magic2 := MAGIC_GNRL;
      fHeader.Version := HEADER_VERSION_FO4v1;
    end;
    baFO4dds: begin
      fHeader.Magic := MAGIC_BTDX;
      if fTarget in [btPC, btXBox] then fHeader.Magic2 := MAGIC_DX10 else fHeader.Magic2 := MAGIC_GNMF;
      fHeader.Version := HEADER_VERSION_FO4v1;
    end;
    baSF: begin
      fHeader.Magic := MAGIC_BTDX;
      fHeader.Magic2 := MAGIC_GNRL;
      // official Archive2 tool creates v3 archives for lz4 compression only
      if fCompressionType = ctLZ4 then
        fHeader.Version := HEADER_VERSION_SFv3
      else
        fHeader.Version := HEADER_VERSION_SFv2;
    end;
    baSFdds: begin
      fHeader.Magic := MAGIC_BTDX;
      if fTarget in [btPC, btXBox] then fHeader.Magic2 := MAGIC_DX10 else fHeader.Magic2 := MAGIC_GNMF;
      if fCompressionType = ctLZ4 then
        fHeader.Version := HEADER_VERSION_SFv3
      else
        fHeader.Version := HEADER_VERSION_SFv2;
    end;
  else
    raise Exception.Create('Unsupported archive type');
  end;

  //--------------------------------------------------
  // Create Morrowind
  if fType = baTES3 then begin
    fHeader.FileCount := aFilesList.Count;
    Count := aFilesList.Count;
    len := 0;
    // fill in file entries and calculate total names length
    for i := 0 to Pred(Count) do begin
      Items[i].Name := LowerCase(aFilesList[i]);
      Items[i].FileObject := aFilesList.Objects[i];
      Items[i].NameHash64 := TwbHash.TES3(Items[i].Name);
      Inc(len, Length(Items[i].Name) + 1); // including terminator
    end;
    // sort files by hashes
    fFiles.Sort(HashSortTES3);

    // offset to hash table
    fDataOffset := fHeader.SizeOfTES3 +
      8 * Count + // File sizes/offsets
      4 * Count + // Archive directory/name offsets
      len; // Filename records

    // stored without header size
    fHeader.HashOffset := fDataOffset - fHeader.SizeOfTES3;

    // offset to files data
    fDataOffset := fDataOffset + 8 * Count; // Hash table

    // files are stored alphabetically in the data section in vanilla archives
    // not really needed but whatever
    //aFilesList.CustomSort(AlphabeticalSort);
  end

  //--------------------------------------------------
  // Create Oblivion, Fallout 3, New Vegas, Skyrim, Skyrim SE
  else if fType in [baTES4, baFO3, baSSE] then begin
    fHeader.FolderNamesLength := 0;
    fHeader.FileNamesLength := 0;
    fHeader.FileCount := aFilesList.Count;
    Count := aFilesList.Count;
    // fill in file entries and calculate total names length
    for i := 0 to Pred(Count) do begin
      Items[i].Name := LowerCase(aFilesList[i]);
      Items[i].FileObject := aFilesList.Objects[i];
      Items[i].Compress := FileCompression(i);
      if TwbAsset.SplitDirName(aFilesList[i], fdir, fname) = 0 then
        raise Exception.Create('File is missing the folder part: ' + aFilesList[i]);
      Items[i].DirHash64 := TwbHash._TES4(fdir, False, fType = baTES4) ;
      Items[i].NameHash64 := TwbHash._TES4(fname, True, fType = baTES4);
      // calculate file names length
      Inc(fHeader.FileNamesLength, Length(fname) + 1); // + terminator
    end;
    // sort files by hashes
    fFiles.Sort(HashSortTES4);

    // create folders
    var prevdir: UInt64 := 0;
    for var f in Self do begin
      if f.DirHash64 <> prevdir then begin
        prevdir := f.DirHash64;
        TwbAsset.SplitDirName(f.Name, fdir, fname);
        SetLength(fFoldersTES4, Succ(Length(fFoldersTES4)));
        fFoldersTES4[High(fFoldersTES4)].Name := fdir;
        fFoldersTES4[High(fFoldersTES4)].Hash := f.DirHash64;
        // calculate folder names length
        Inc(fHeader.FolderNamesLength, Length(fdir) + 1); // + terminator only, length prefix is not counted
      end;
      fFoldersTES4[High(fFoldersTES4)].Files := fFoldersTES4[High(fFoldersTES4)].Files + [f];
    end;
    fHeader.FolderCount := Length(fFoldersTES4);
    fHeader.FoldersOffset := fHeader.SizeOfTES4;

    // calculate folders offsets
    // at the end fDataOffset will hold the total size of header, folder and file records
    // in other words the start of files data
    fDataOffset := fHeader.FoldersOffset + 16 * Cardinal(Length(fFoldersTES4));
    // SSE folder record has 2 additional Cardinal padding fields
    if fType = baSSE then
      Inc(fDataOffset, 2 * SizeOf(Cardinal) * Length(fFoldersTES4));
    // Offsets are stored including this value
    Inc(fDataOffset, fHeader.FileNamesLength);
    for i := Low(fFoldersTES4) to High(fFoldersTES4) do begin
      fFoldersTES4[i].Offset := fDataOffset;
      // add folder name length
      Inc(fDataOffset, Length(fFoldersTES4[i].Name) + 2); // + length prefix + terminator
      // add file records length
      Inc(fDataOffset, 16 * Length(fFoldersTES4[i].Files));
    end;

    // flags detection
    DetectFlags(fType, aFilesList, aFilesCompression, fHeader.Flags, fHeader.FileFlags);
    var bTexturesOnly := fHeader.FileFlags = FILE_TEXTURES;

    // flags override
    if fArchiveFlags <> 0 then fHeader.Flags := fArchiveFlags or ARCHIVE_DEFAULT;
    if fFileFlags <> 0 then fHeader.FileFlags := fFileFlags;

    // fixes to avoid game crashes with wrong flags
    // embedded names in textures only archives, might crash on other files
    if not bTexturesOnly then
      fHeader.Flags := fHeader.Flags and not ARCHIVE_EMBEDNAME
    // SSE crashing bug - textures with embedded names must be compressed
    else if not Assigned(fPacker) and (fType = baSSE) and (fHeader.Flags and ARCHIVE_EMBEDNAME <> 0) then
      for var f in Self do f.Compress := True;
  end

  //--------------------------------------------------
  // Create Fallout 4, Starfield
  else if fType in [baFO4, baFO4dds, baSF, baSFdds] then begin
    fHeader.FileCount := aFilesList.Count;
    Count := aFilesList.Count;
    for i := 0 to Pred(Count) do begin
      with TwbAsset.Split(aFilesList[i]) do begin
        fdir := FolderNoDelimiter;
        fname := FileNameNoExtension;
        fext := ExtensionNoDot;
      end;
      if fdir = '' then
        raise Exception.Create('File is missing the folder part: ' + aFilesList[i]);
      Items[i].Name := aFilesList[i];
      Items[i].FileObject := aFilesList.Objects[i];
      Items[i].Compress := FileCompression(i);
      Items[i].DirHash32 := TwbHash.FO4(fdir);
      Items[i].NameHash32 := TwbHash.FO4(fname);
      Items[i].Ext := String2Magic(LowerCase(fext));
    end;

    // offset to files data
    case fType of
      baFO4, baFO4dds:
         fDataOffset := fHeader.SizeOfFO4;
      baSF, baSFdds:
        case fHeader.Version of
          HEADER_VERSION_SFv2: fDataOffset := fHeader.SizeOfSFv2;
          HEADER_VERSION_SFv3: fDataOffset := fHeader.SizeOfSFv3;
        end;
    end;

    // file records have fixed length in general archive
    if fType in [baFO4, baSF] then
      fDataOffset := fDataOffset + 36 * Count

    // variable file record length depending on DDS chunks number
    else if IsDDSArchive(fType) then
      for var f in Self do begin
        // get required chunks if dds info callback is present, otherwise assume max chunks
        var chunks := fMaxChunkCount;
        if Assigned(fDDSInfoProc) then begin
          var ddsinfo: TwbDDSInfo;
          fDDSInfoProc(Self, f.Name, ddsinfo);
          chunks := GetDDSMipChunkNum(ddsinfo.Width, ddsinfo.Height, ddsinfo.MipMaps);
        end;
        var hsize := CHUNK_HEADER_SIZE_DX10;
        if fHeader.Magic2 = MAGIC_GNMF then
          hsize := CHUNK_HEADER_SIZE_GNMF;
        fDataOffset := fDataOffset + hsize {size of file record} + 24 {size of each texchunk} * chunks;
      end;

  end;

  for var f in Self do
    f.LookupHash := TwbHash.LookupHash(f.Name, True);

  fStream := TwbWriteCachedFileStream.Create(fFileName, fmCreate);
  Include(fStates, stWriting);
  // reserve space for the header
  var buf: TBytes;
  SetLength(buf, fDataOffset);
  fStream.Write(buf, Length(buf));
end;

procedure TwbBSArchive.Save;
begin
  if not (stWriting in fStates) then
    raise Exception.Create('Archive is not in writing mode');

  case fType of
    //--------------------------------------------------
    // Save Morrowind
    baTES3: begin
      for var f in Self do if f.Offset = 0 then
        raise Exception.Create('Packed file has no data: ' + f.Name);

      fArchiveSize := fStream.Position;
      fStream.Position := 0;
      // write header
      fStream.Write(fHeader.Magic, SizeOf(fHeader.Magic));
      fStream.WriteCardinal(fHeader.HashOffset);
      fStream.WriteCardinal(fHeader.FileCount);
      // file sizes/offsets
      for var f in Self do begin
        fStream.WriteCardinal(f.Size);
        fStream.WriteCardinal(f.Offset - fDataOffset); // offsets are relative
      end;
      // Archive directory/name offsets
      var i := 0;
      for var f in Self do begin
        fStream.WriteCardinal(i);
        Inc(i, Length(f.Name) + 1); // including terminator
      end;
      // Filename records
      for var f in Self do fStream.WriteStringTerm(f.Name);
      // Hash table
      for var f in Self do fStream.WriteUInt64(f.NameHash64);
    end;

    //--------------------------------------------------
    // Save Oblivion, Fallout 3, New Vegas, Skyrim, Skyrim SE
    baTES4, baFO3, baSSE: begin
      for var f in Self do if f.Offset = 0 then
        raise Exception.Create('Packed file has no data: ' + f.Name);

      fArchiveSize := fStream.Position;
      fStream.Position := 0;
      // write header
      fStream.Write(fHeader.Magic, SizeOf(fHeader.Magic));
      fStream.WriteCardinal(fHeader.Version);
      fStream.WriteCardinal(fHeader.FoldersOffset);
      fStream.WriteCardinal(fHeader.Flags);
      fStream.WriteCardinal(fHeader.FolderCount);
      fStream.WriteCardinal(fHeader.FileCount);
      fStream.WriteCardinal(fHeader.FolderNamesLength);
      fStream.WriteCardinal(fHeader.FileNamesLength);
      fStream.WriteCardinal(fHeader.FileFlags);
      // write folder records
      for var d in fFoldersTES4 do begin
        fStream.WriteUInt64(d.Hash);
        fStream.WriteCardinal(Length(d.Files));
        if fType = baSSE then fStream.WriteCardinal(0); // padding
        fStream.WriteCardinal(d.Offset);
        if fType = baSSE then fStream.WriteCardinal(0); // padding
      end;
      // write file records
      for var d in fFoldersTES4 do begin
        fStream.WriteStringLen(d.Name);
        for var f in d.Files do begin
          fStream.WriteUInt64(f.NameHash64);
          fStream.WriteCardinal(f.Size);
          fStream.WriteCardinal(f.Offset);
        end;
      end;
      // write file names
      for var d in fFoldersTES4 do
        for var f in d.Files do begin
          // f.Name contains path and name, need name only here
          var dir, name: string;
          TwbAsset.SplitDirName(f.Name, dir, name);
          fStream.WriteStringTerm(name);
        end;
    end;

    //--------------------------------------------------
    // Save Fallout4, Starfield
    baFO4, baFO4dds, baSF, baSFdds: begin
      for var f in Self do begin
        if (fHeader.Magic2 = MAGIC_GNRL) and (f.Offset = 0) then
          raise Exception.Create('Packed file has no data: ' + f.Name);
        if (fHeader.Magic2 = MAGIC_DX10) and (Length(f.TexChunks) = 0) then
          raise Exception.Create('Packed file has no data: ' + f.Name);
      end;

      // file names table at the end of file
      fHeader.FileTableOffset := fStream.Position;
      for var f in Self do
        fStream.WriteStringLen16(StringReplace(f.Name, '\', '/', [rfReplaceAll])); // archive2.exe uses /

      fArchiveSize := fStream.Position;
      fStream.Position := 0;
      // write header
      fStream.Write(fHeader.Magic, SizeOf(fHeader.Magic));
      fStream.WriteCardinal(fHeader.Version);
      fStream.Write(fHeader.Magic2, SizeOf(fHeader.Magic2));
      fStream.WriteCardinal(fHeader.FileCount);
      fStream.WriteInt64(fHeader.FileTableOffset);
      // SF header
      if fHeader.Version in [HEADER_VERSION_SFv2, HEADER_VERSION_SFv3] then
        fStream.WriteUInt64(1); // always set to 1, immediately discarded on load
      if fHeader.Version = HEADER_VERSION_SFv3 then begin
        if fCompressionType = ctLZ4 then
          fHeader.CompressionMethod := COMPRESSION_METHOD_LZ4
        else
          fHeader.CompressionMethod := COMPRESSION_METHOD_ZLIB;
        fStream.WriteCardinal(fHeader.CompressionMethod);
      end;

      // write file entries
      for var f in Self do begin
        fStream.WriteCardinal(f.NameHash32);
        fStream.WriteBuffer(f.Ext[0], SizeOf(f.Ext));
        fStream.WriteCardinal(f.DirHash32);
        fStream.WriteByte(f.ModIndex); // always 0
        if fHeader.Magic2 = MAGIC_GNRL then begin
          fStream.WriteByte(1); // always single chunk
          fStream.WriteWord(CHUNK_HEADER_SIZE_GNRL);
          fStream.WriteInt64(f.Offset);
          fStream.WriteCardinal(f.PackedSize);
          fStream.WriteCardinal(f.Size);
          fStream.WriteCardinal(iFileFO4Tail);
        end
        else begin
          fStream.WriteByte(Length(f.TexChunks));
          if fHeader.Magic2 = MAGIC_DX10 then begin
            fStream.WriteWord(CHUNK_HEADER_SIZE_DX10);
            fStream.WriteWord(f.DDS.Height);
            fStream.WriteWord(f.DDS.Width);
            fStream.WriteByte(f.DDS.NumMips);
            fStream.WriteByte(f.DDS.DXGIFormat);
            fStream.WriteByte(f.DDS.Flags);
            fStream.WriteByte(f.DDS.TileMode);
          end
          else if fHeader.Magic2 = MAGIC_GNMF then begin
            fStream.WriteWord(CHUNK_HEADER_SIZE_GNMF);
            fStream.Write(f.GNF, SizeOf(f.GNF));
          end;
          for var c in f.TexChunks do begin
            fStream.WriteInt64(c.Offset);
            fStream.WriteCardinal(c.PackedSize);
            fStream.WriteCardinal(c.Size);
            fStream.WriteWord(c.StartMip);
            fStream.WriteWord(c.EndMip);
            fStream.WriteCardinal(iFileFO4Tail);
          end;
        end;
      end;

    end;

  end;

  FreeAndNil(fStream);
  Exclude(fStates, stWriting);
end;

procedure TwbBSArchive.DecompressBuf(aSrc: Pointer; aSrcSize: Integer; aDst: Pointer; aDstSize: Integer);
begin
  if fCompressionType = ctNone then
    raise Exception.Create('Undefined compression type');

  SyncEndWrite;
  try
    TwbCompression.Decompress(fCompressionType, aSrc, aSrcSize, aDst, aDstSize);
  finally
    SyncBeginWrite;
  end;
end;

{$WARN USE_BEFORE_DEF OFF} // suppress warning for DataHash
procedure TwbBSArchive.PackData(aFile: TwbBSFileEntry; aChunk: TwbBSFileChunk;
  aData: Pointer; aSize, aUncompressedSize: Integer);
var
  buf: TBytes;
  DataHash: TwbLookupHash;
  StartPosition: Int64;
begin
  if fShareData then
    DataHash := TwbHash.LookupHash(aData, aSize);

  SyncBeginWrite;
  try
    if FindPackedData(aUncompressedSize, DataHash, aChunk) then
      Exit;

    // data compression (except data from Packer which is already compressed)
    if aFile.Compress and not Assigned(fPacker) then begin
      if fCompressionType = ctNone then
        raise Exception.Create('Undefined compression type');
      SyncEndWrite;
      try
        buf := TwbCompression.Compress(fCompressionType, aData, aUncompressedSize, aSize);
        aData := buf;
      finally
        SyncBeginWrite;
      end;
      // try to find existing data again if multithreaded
      // maybe some other thread has written the same data while we've been busy compressing
      if fMultiThreaded and FindPackedData(aUncompressedSize, DataHash, aChunk) then
        Exit;
    end;

    StartPosition := fStream.Position;

    // embedded filename for Fallout 3/NV/Skyrim/Skyrim SE
    if (fType in [baFO3, baSSE]) and (fHeader.Flags and ARCHIVE_EMBEDNAME <> 0) then
      fStream.WriteStringLen(aFile.Name, False);

    // if compressed then write uncompressed size first for Oblivion/Fallout 3/NV/Skyrim/Skyrim SE
    if (fType in [baTES4, baFO3, baSSE]) and aFile.Compress then
      fStream.WriteCardinal(aUncompressedSize);

    // write file data
    fStream.Write(aData^, aSize);

    // updating file entry
    aChunk.Offset := StartPosition;

    case fType of
      baTES3: aChunk.Size := aUncompressedSize;
      baTES4, baFO3, baSSE: begin
        // Size includes embedded filename and uncompressed size field
        aChunk.Size := fStream.Position - StartPosition;
        if aFile.Compress xor (fHeader.Flags and ARCHIVE_COMPRESS <> 0) then
          aChunk.Size := aChunk.Size or FILE_SIZE_COMPRESS;
        // this is purely for warnings check on newly created archives to signal that the file was compressed
        if aFile.Compress then
          aChunk.PackedSize := aSize;
      end;
      // baFO4, bfFO4dds, baSF, baSFdds
      else begin
        aChunk.Size := aUncompressedSize;
        if aFile.Compress then
          aChunk.PackedSize := aSize;
      end;
    end;

    AddPackedData(aUncompressedSize, DataHash, aChunk);

  finally
    SyncEndWrite;
  end;
end;
{$WARN USE_BEFORE_DEF ON}

procedure TwbBSArchive.Pack(aFile: TwbBSFileEntry; aData: Pointer; aSize: Integer);
var
  i, chunks, mips, Off, MipSize, UncompressedSize: Integer;
  DDSHeader: PDDSHeader;
  GNFHeader: PGNFHeader;
  buf: TBytes;
begin
  if not (stWriting in fStates) then
    raise Exception.Create('Archive is not in writing mode');

  // getting preloaded data from the Packer for chunk 0 (holds dds header for dds archives)
  if Assigned(fPacker) then
    fPacker.GetChunk(aFile.Name, aFile.FileObject, aData, aSize, UncompressedSize)
  else
    UncompressedSize := aSize;

  // file packing
  if not IsDDSArchive(fType) then begin
    PackData(aFile, aFile, aData, aSize, UncompressedSize);
    Exit;
  end;

  // texture chunks packing
  // DDS
  if fTarget in [btPC, btXBox] then begin
    if not TwbDDS.IsDDS(aData, aSize) then
      raise Exception.Create(cExceptionInvalidDDS);

    if (fTarget = btPC) and TwbDDS.IsXBOX(aData) then
      raise Exception.Create(cExceptionIsXboxDDS);

    if (fTarget = btXBox) and not TwbDDS.IsXBOX(aData) then
      raise Exception.Create(cExceptionIsNotXboxDDS);

    DDSHeader := aData;
    // convert unsupported uncompressed 24 bit RGB to 32 bit BGRX
    if not Assigned(fPacker) and (TwbDDS.GetD3DFMT(DDSHeader) = D3DFMT_R8G8B8) then begin
      buf := TwbDDS.ConvertR8G8B8toB8G8R8X8(aData, aSize);
      aData := @buf[0];
      aSize := Length(buf);
      DDSHeader := aData;
    end;
    aFile.DDS.DXGIFormat := Byte(TwbDDS.GetDXGI(DDSHeader));
    if TDXGI(aFile.DDS.DXGIFormat) = DXGI_FORMAT_UNKNOWN then
      raise Exception.Create(cExceptionUnsupportedDDS);
    aFile.DDS.Width := DDSHeader.dwWidth;
    aFile.DDS.Height := DDSHeader.dwHeight;
    aFile.DDS.NumMips := DDSHeader.dwMipMapCount;
    // DirectXTexDDS.cpp, in DecodeDDSHeader, if dwMipMapCount is 0, it is forced to 1
    if aFile.DDS.NumMips = 0 then Inc(aFile.DDS.NumMips);
    aFile.DDS.TileMode := TwbDDS.GetTileMode(DDSHeader);
    aFile.DDS.Flags := 0;
    if TwbDDS.IsCubeMap(DDSHeader) then begin
      aFile.DDS.Flags := aFile.DDS.Flags or DDS_FLAG_CUBEMAP;
      chunks := 1; // cubemaps are not chunked
    end else
      chunks := GetDDSMipChunkNum(aFile.DDS.Width, aFile.DDS.Height, aFile.DDS.NumMips);

    Off := TwbDDS.GetHeaderSize(DDSHeader); // offset to image data
    MipSize := (aFile.DDS.Width * aFile.DDS.Height * TwbDDS.GetBitsPerPixel(TDXGI(aFile.DDS.DXGIFormat))) shr 3;
    mips := aFile.DDS.NumMips;
  end

  // GNF
  else begin
    if fMaxChunkCount <> 1 then
      raise Exception.Create(cExceptionSingleChunk);

    if not TwbGNF.IsGNF(aData, aSize) then
      raise Exception.Create(cExceptionInvalidGNF);

    GNFHeader := aData;
    if GNFHeader.NumTextures <> 1 then
      raise Exception.Create(cExceptionUnsupportedGNF);

    System.Move(GNFHeader.Texture, aFile.GNF, SizeOf(aFile.GNF));
    Off := TwbGNF.GetHeaderSize(GNFHeader);
    mips := GNFHeader.Texture.MipMapCount;
    MipSize := 0; // suppress compiler warning, recalculated for single chunk below
    chunks := fMaxChunkCount;
  end;

  // store chunks
  SetLength(aFile.TexChunks, chunks);
  for i := Low(aFile.TexChunks) to High(aFile.TexChunks) do begin
    aFile.TexChunks[i] := TwbBSFileChunkTex.Create;
    aFile.TexChunks[i].StartMip := i;
    if i < High(aFile.TexChunks) then
      aFile.TexChunks[i].EndMip := i
    else begin
      // last chunk stores all remaining mipmaps
      aFile.TexChunks[i].EndMip := Pred(mips);
      MipSize := aSize - Off;
    end;

    if Assigned(fPacker) then begin
      var d := nil; var s := 0; var u := 0;
      fPacker.GetChunk(aFile.Name, aFile.FileObject, d, s, u, i + 1);
      PackData(aFile, aFile.TexChunks[i], d, s, u);
    end else
      PackData(aFile, aFile.TexChunks[i], PByte(aData) + Off, MipSize, MipSize);

    Inc(Off, MipSize);
    MipSize := MipSize div 4;
  end;

end;

procedure TwbBSArchive.Pack(aFile: TwbBSFileEntry; const aData: TBytes);
begin
  Pack(aFile, Pointer(aData), Length(aData));
end;

procedure TwbBSArchive.Pack(const aFileName: string; const aData: TBytes);
begin
  var f := FileByName(aFileName);
  if Assigned(f) then
    Pack(f, Pointer(aData), Length(aData))
  else
    raise Exception.Create('File to pack not found in archive: ' + aFileName);
end;

function TwbBSArchive.Unpack(aFile: TwbBSFileEntry): TBytes;
var
  Size, TexSize, MipOffset: Integer;
  Buffer: TBytes;
begin
  if not (stReading in fStates) then
    raise Exception.Create('Archive is not loaded');

  if not Assigned(aFile) then
    Exit;

  SyncBeginWrite;
  try
    case fType of
      baTES3: begin
        fStream.Position := fDataOffset + aFile.Offset;
        SetLength(Result, aFile.Size);
        fStream.Read(Result, Length(Result));
      end;

      baTES4, baFO3, baSSE: begin
        fStream.Position := aFile.Offset;
        Size := aFile.Size;

        // skip embedded file name + length prefix
        if (fType in [baFO3, baSSE]) and (fHeader.Flags and ARCHIVE_EMBEDNAME <> 0) then
          Dec(Size, Length(fStream.ReadStringLen(False)) + 1);

        if aFile.Compressed then begin
          // allocate uncompressed size space
          SetLength(Result, fStream.ReadCardinal);
          Dec(Size, SizeOf(Cardinal));
          if (Length(Result) > 0) and (Size > 0) then begin
            SetLength(Buffer, Size);
            fStream.Read(Buffer, Length(Buffer));
            DecompressBuf(Buffer, Length(Buffer), Result, Length(Result));
          end;
        end
        else begin
          SetLength(Result, Size);
          fStream.Read(Result, Length(Result));
        end;
      end;

      baFO4, baSF: begin
        fStream.Position := aFile.Offset;
        if aFile.Compressed then begin
          SetLength(Buffer, aFile.PackedSize);
          fStream.Read(Buffer, Length(Buffer));
          SetLength(Result, aFile.Size);
          DecompressBuf(Buffer, Length(Buffer), Result, Length(Result));
        end
        else begin
          SetLength(Result, aFile.Size);
          fStream.Read(Result, Length(Result));
        end;
      end;

      baFO4dds, baSFdds: begin
        // allocate space for total texture size
        // header first
        if fTarget = btPS then
          TexSize := GNF_PADDED_HEADER_SIZE
        else begin
          TexSize := SizeOf(TDDSHeader);
          if (fTarget = btXBox) or not (TDXGI(aFile.DDS.DXGIFormat) in TwbDDS.DXGI_DX9) then begin
            Inc(TexSize, SizeOf(TDDSHeaderDX10));
            if ArchiveTarget = btXBox then
              Inc(TexSize, SizeOf(TDDSHeaderXBOX));
          end;
        end;

        // offset to image data (total size of texture header)
        MipOffset := TexSize;
        for var c in aFile.TexChunks do Inc(TexSize, c.Size);
        SetLength(Result, TexSize);

        // set up GNF header
        if fTarget = btPS then begin
          var gnf: PGNFHeader := @Result[0];
          gnf.Magic := MAGIC_GNF;
          gnf.Version := GNF_VERSION_PS4;
          gnf.ContentSize := GNF_PADDED_HEADER_SIZE - SizeOf(gnf.Magic) - SizeOf(gnf.ContentSize);
          gnf.Alignment := GNF_ALIGNMENT;
          gnf.NumTextures := 1;
          gnf.StreamSize := TexSize;
          System.Move(aFile.GNF, gnf.Texture, SizeOf(aFile.GNF));
        end
        // set up DDS header
        else begin
          TwbDDS.SetUpHeader(Result, TDXGI(aFile.DDS.DXGIFormat), aFile.DDS.Width, aFile.DDS.Height, aFile.DDS.NumMips, aFile.IsCubeMap, ArchiveTarget = btXBox);
          if ArchiveTarget = btXBox then
            TwbDDS.HeaderXBOX(Result).tileMode := aFile.DDS.TileMode;
        end;

        // append mipmap chunks
        for var c in aFile.TexChunks do begin
          fStream.Position := c.Offset;
          if c.Compressed then begin
            SetLength(Buffer, c.PackedSize);
            fStream.Read(Buffer, Length(Buffer));
            DecompressBuf(Buffer, Length(Buffer), @Result[MipOffset], c.Size);
          end else
            fStream.Read(Result[MipOffset], c.Size);

          Inc(MipOffset, c.Size);
        end;
      end;

      else
        raise Exception.Create('Extraction is not supported for this archive');
    end;
  finally
    SyncEndWrite;
  end;
end;

function TwbBSArchive.Unpack(const aFileName: string): TBytes;
begin
  if not (stReading in fStates) then
    raise Exception.Create('Archive is not loaded');

  var f := FileByName(aFileName);
  if not Assigned(f) then
    raise Exception.Create('File not found in archive: ' + aFileName);

  Result := Unpack(f);
end;

procedure TwbBSArchive.Unpack(const aFileName: string; aStream: TStream);
begin
  var FileData := Unpack(aFileName);
  if Length(FileData) <> 0 then
    aStream.Write(FileData, Length(FileData));
end;

procedure TwbBSArchive.Unpack(const aFileName, aSaveAs: string);
var
  fs: TFileStream;
begin
  if not (stReading in fStates) then
    raise Exception.Create('Archive is not loaded');

  fs := TFileStream.Create(aSaveAs, fmCreate);
  try
    Unpack(aFileName, fs);
  finally
    fs.Free;
  end;
end;

function TwbBSArchive.FileByName(const aFileName: string): TwbBSFileEntry;
begin
  Result := nil;
  var hash := TwbHash.LookupHash(aFileName, True);
  for var f in Self do
    if f.LookupHash = hash then begin
      Result := f;
      Exit;
    end;
end;

function TwbBSArchive.FilesByFolder(const aFolder: string): TwbBSFileEntries;
begin
  var Folder := ExcludeTrailingPathDelimiter(aFolder);
  var j := 0;
  SetLength(Result, Count);
  for var f in Self do
    if (Folder = '') or f.Name.StartsWith(Folder, True) then begin
      Result[j] := f;
      Inc(j);
    end;
  SetLength(Result, j);
end;

function TwbBSArchive.FileExists(const aFileName: string): Boolean;
begin
  Result := Assigned(FileByName(aFileName));
end;

procedure TwbBSArchive.Close;
begin
  if Assigned(fStream) then
    FreeAndNil(fStream);

  if stWriting in fStates then try
    System.SysUtils.DeleteFile(fFileName);
  except end;

  fStates := [];
  fDataOffset := 0;
  FillChar(fHeader, SizeOf(fHeader), 0);
  Count := 0;
  SetLength(fFoldersTES4, 0);

  if fShareData then begin
    SetLength(fPackedData, 0);
    fPackedDataCount := 0;
  end;

  inherited;
end;


{ TwbSplitPacker }

procedure TwbSplitPacker.TPackedFile.AddChunk(const aData: TBytes; aUncompressedSize: Integer);
begin
  SetLength(Chunks, Succ(Length(Chunks)));
  with Chunks[Pred(Length(Chunks))] do begin
    Data := aData;
    UncompressedSize := aUncompressedSize;
  end;
end;

procedure TwbSplitPacker.Close;
begin
  fPending := nil;
  fLoaded := nil;
  fWritten := nil;
  fLoadedSize := 0;
  fLoadingCount := 0;
  fProcessCount := 0;
  fProcessTick := 0;
  SetLength(fFiles, 0);
  for var bsa in fArchives do bsa.Free;
  SetLength(fArchives, 0);
  inherited;
end;

procedure TwbSplitPacker.CreateArchive(const aFileName: string; aType: TwbBSArchiveType;
  aFilesList: TStringList = nil; const aFilesCompression: TArray<Boolean> = nil);
var
  i: Integer;
  f, prevf: PPackedFile;
  bsa: TwbBSArchive;
begin
  if aFilesList.Count = 0 then
    raise Exception.Create('Files list is empty');

  fFileName := aFileName;
  fType := aType;

  if fCompressionType = ctNone then
    fCompressionType := DefaultCompression(fType);

  // small gimmick for TES3 archives, repacked vanilla ones will be binary identical
  if (fType = baTES3) and not fMultiThreaded then
    aFilesList.CustomSort(AlphabeticalSort);

  SetLength(fFiles, aFilesList.Count);
  prevf := nil;
  for i := 0 to Pred(aFilesList.Count) do begin
    f := @fFiles[i];
    f.Next := nil;
    f.FileName := aFilesList[i];
    f.FileObject := aFilesList.Objects[i];
    if i < Length(aFilesCompression) then
      f.Compress := aFilesCompression[i]
    else
      f.Compress := False;

    if Assigned(prevf) then
      prevf.Next := f
    else
      fPending := f;

    prevf := f;
  end;

  // if no splitting then create a single archive right now
  if fSplitSize = 0 then begin
    bsa := AddArchive;
    bsa.CreateArchive(NewArchiveName, fType, aFilesList, aFilesCompression);
    // 1 tick per file when no splitting
    fProcessCount := Length(fFiles);
  end else
    // 2 ticks per file when splitting for separate loading and writing
    fProcessCount := Length(fFiles) * 2;
end;

procedure TwbSplitPacker.Save;
begin
  for var bsa in fArchives do bsa.Save;
end;

procedure TwbSplitPacker.GetChunk(const aFileName: string; aFileObject: Pointer;
  out aBuffer: Pointer; out aSize, aUncompressedSize: Integer;
  aChunkIndex: Integer = 0);
var
  f: PPackedFile;
begin
  f := aFileObject;
  if aChunkIndex > High(f.Chunks) then
    raise Exception.CreateFmt('Chunk index %d not found for %s', [aChunkIndex, f.FileName]);

  aBuffer := f.Chunks[aChunkIndex].Data;
  aSize := Length(f.Chunks[aChunkIndex].Data);
  aUncompressedSize := f.Chunks[aChunkIndex].UncompressedSize;
end;

function TwbSplitPacker.NewArchiveName: string;
var
  s: string;
  i: Integer;
begin
  if Length(fArchives) > 1 then s := IntToStr(Length(fArchives)) else s := '';
  Result := fFileName;
  i := TwbAsset.LastCharPos(Result, '.');
  if i <> 0 then Insert(s, Result, i) else Result := Result + s;
end;

function TwbSplitPacker.AddArchive: TwbBSArchive;
begin
  Result := TwbBSArchive.Create;
  Result.ArchiveTarget := fTarget;
  Result.MultiThreaded := fMultiThreaded;
  Result.ShareData := fShareData;
  Result.ArchiveFlags := fArchiveFlags;
  Result.FileFlags := fFileFlags;
  Result.CompressionType := fCompressionType;
  Result.MaxChunkCount := fMaxChunkCount;
  Result.SingleMipChunkX := fSingleMipChunkX;
  Result.SingleMipChunkY := fSingleMipChunkY;
  fArchives := fArchives + [Result];
end;

procedure TwbSplitPacker.MakeArchiveForLoaded;
var
  sl: TStringList;
  fcomp: TArray<Boolean>;
  f: PPackedFile;
  bsa: TwbBSArchive;
begin
  sl := TStringList.Create;
  try
    f := fLoaded;
    while Assigned(f) do begin
      sl.AddObject(f.FileName, TObject(f));
      fcomp := fcomp + [f.Compress];
      f.ArchiveIndex := Length(fArchives);
      // last file in loaded chain
      if f.Next = nil then begin
        // append written to loaded
        f.Next := fWritten;
        // start written with loaded
        fWritten := fLoaded;
        // clear loaded
        fLoaded := nil;
        Break;
      end;
      f := f.Next;
    end;

    bsa := AddArchive;
    // BSA will use us to get preloaded files data
    bsa.Packer := Self;
    bsa.CreateArchive(NewArchiveName, fType, sl, fcomp);
  finally
    sl.Free;
  end;
end;

procedure TwbSplitPacker.LoadFile(aPackedFile: PPackedFile);
var
  buf: TBytes;
  Size, Off, MipSize, chunks: Integer;
  DDSHeader: PDDSHeader;
  GNFHeader: PGNFHeader;

  procedure AddChunk(const aData: TBytes; aCompress: Boolean);
  var
    zBuf: TBytes;
    zSize: Integer;
  begin
    if aCompress then begin
      if fCompressionType = ctNone then
        raise Exception.Create('Undefined compression type');
      zBuf := TwbCompression.Compress(fCompressionType, aData, Length(aData), zSize);
      SetLength(zBuf, zSize);
    end else
      zBuf := aData;

    aPackedFile.AddChunk(zBuf, Length(aData));
    Inc(Size, Length(zBuf));
  end;

begin
  Size := 0;

  Inc(fLoadingCount);
  SyncEndWrite;
  try
    buf := GetSourceFileData(aPackedFile.FileName, aPackedFile.FileObject);

    // non DDS archives - single chunk holding entire file data
    if not IsDDSArchive(fType) then
      AddChunk(buf, aPackedFile.Compress)

    // texture archives - multiple chunks for mipmaps
    else begin
      // DDS
      if fTarget in [btPC, btXBox] then begin
        if not TwbDDS.IsDDS(buf, Length(buf)) then
          raise Exception.Create(cExceptionInvalidDDS);

        if (fTarget = btPC) and TwbDDS.IsXBOX(buf) then
          raise Exception.Create(cExceptionIsXboxDDS);

        if (fTarget = btXBox) and not TwbDDS.IsXBOX(buf) then
          raise Exception.Create(cExceptionIsNotXboxDDS);

        DDSHeader := @buf[0];
        // convert unsupported uncompressed 24 bit RGB to 32 bit BGRX
        if TwbDDS.GetD3DFMT(DDSHeader) = D3DFMT_R8G8B8 then begin
          buf := TwbDDS.ConvertR8G8B8toB8G8R8X8(buf, Length(buf));
          DDSHeader := @buf[0];
        end;
        if TwbDDS.GetDXGI(DDSHeader) = DXGI_FORMAT_UNKNOWN then
          raise Exception.Create(cExceptionUnsupportedDDS);

        Off := TwbDDS.GetHeaderSize(DDSHeader);
        MipSize := TwbDDS.GetMipSize(DDSHeader);
        chunks := GetDDSMipChunkNum(DDSHeader.dwWidth, DDSHeader.dwHeight, DDSHeader.dwMipMapCount);
        if TwbDDS.IsCubeMap(DDSHeader) then chunks := 1; // cubemaps are not chunked
      end
      // GNF
      else begin
        if fMaxChunkCount <> 1 then
          raise Exception.Create(cExceptionSingleChunk);

        if not TwbGNF.IsGNF(buf, Length(buf)) then
          raise Exception.Create(cExceptionInvalidGNF);

        GNFHeader := @buf[0];
        if GNFHeader.NumTextures <> 1 then
          raise Exception.Create(cExceptionUnsupportedGNF);

        Off := TwbGNF.GetHeaderSize(GNFHeader);
        chunks := fMaxChunkCount;
        MipSize := 0; // suppress compiler warning, recalculated for single chunk below
      end;

      // chunk 0 is uncompressed texture header
      AddChunk(Copy(buf, 0, Off), False);

      for var i := 1 to chunks do begin
        if i = chunks then MipSize := Length(buf) - Off;
        AddChunk(Copy(buf, Off, MipSize), aPackedFile.Compress);
        Inc(Off, MipSize);
        MipSize := MipSize div 4;
      end;
    end;

    if fShareData then begin
      aPackedFile.ShareSize := Length(buf);
      aPackedFile.ShareHash := TwbHash.LookupHash(buf, Length(buf));
    end;

  finally
    SyncBeginWrite;
    Dec(fLoadingCount);
  end;

  if fShareData then begin
    var f := fLoaded;
    while Assigned(f) do begin
      if (f.ShareSize = aPackedFile.ShareSize) and TwbHash.SameLookupHash(f.ShareHash, aPackedFile.ShareHash) then begin
        Size := 0;
        Break;
      end;
      f := f.Next;
    end;
  end;

  // very rough archive size (over)estimation, don't need to be precize
  // reserve space for all service data per file in BSA
  Inc(Size, 200);
  Inc(Size, Length(aPackedFile.FileName));
  // possible embedded file name
  if fType in [baFO3, baSSE] then
    Inc(Size, Length(aPackedFile.FileName));
  Inc(fLoadedSize, Size);

  // time to create a new BSA if greater than split size
  if fLoadedSize > fSplitSize then begin
    // nothing is loaded yet, we are the only file to be packed
    // can only happen when packing some big file larger than split size
    if fLoaded = nil then begin
      fLoaded := aPackedFile;
      fLoaded.Next := nil;
      aPackedFile := nil;
      fLoadedSize := 0;
    end else
      fLoadedSize := Size;

    MakeArchiveForLoaded;
  end;

  if aPackedFile = nil then
    Exit;

  // insert file into loaded chain
  aPackedFile.Next := fLoaded;
  fLoaded := aPackedFile;

  // final BSA if we loaded the last pending file
  if (fPending = nil) and (fLoadingCount = 0) then
    MakeArchiveForLoaded;
end;

procedure TwbSplitPacker.WriteFile(aPackedFile: PPackedFile);
var
  buf: TBytes;
  bsa: TwbBSArchive;
begin
  bsa := fArchives[aPackedFile.ArchiveIndex];
  SyncEndWrite;
  try
    // we are not preloading files when no splitting
    if SplitSize = 0 then
      buf := GetSourceFileData(aPackedFile.FileName, aPackedFile.FileObject);

    bsa.Pack(aPackedFile.FileName, buf);
    // free memory
    SetLength(aPackedFile.Chunks, 0);
  finally
    SyncBeginWrite;
  end;
end;

function TwbSplitPacker.GetFile(var aChain: PPackedFile; aWait: Boolean = False): PPackedFile;
begin
  repeat
    Result := aChain;
    if Assigned(Result) then
      aChain := Result.Next
    else
    if aWait then begin
      SyncEndWrite;
      try
        Sleep(100);
      finally
        SyncBeginWrite;
      end;
    end;
  until Assigned(Result) or not aWait
    // stop if nothing is being loaded and chain is empty
    or ( (fLoadingCount = 0) and (aChain = nil) )
    // stop on errors
    or (fErrorCount <> 0);
end;

procedure TwbSplitPacker.Process;
var
  f: PPackedFile;
begin
  SyncBeginWrite;
  try
    if fErrorCount <> 0 then
      Exit;

    f := nil; // suppress compiler warning
    try
      // when no splitting just load and write the pending file directly
      if fSplitSize = 0 then begin
        f := GetFile(fPending);
        if Assigned(f) then
          WriteFile(f);
        Exit;
      end;

      // 2 out of 3 threads attempt to write first and free preloaded data to reduce memory usage
      // 1 out of 3 will keep loading to make CPU busy compressing data
      // if no pending files left then always write
      if Assigned(fWritten) then
        if not Assigned(fPending) or (fProcessTick mod 3 <> 0) then begin
          f := GetFile(fWritten);
          WriteFile(f);
          Exit;
        end;

      // load pending file
      f := GetFile(fPending);
      if Assigned(f) then begin
        LoadFile(f);
        Exit;
      end;

      // we are here if there are no more files available to load or write
      // but other threads might still be busy loading
      // wait when multithreaded for their files to write them
      // are there any loading threads actually?
      // this can only happen if Process() is called more than ProcessCount times
      if fLoadingCount <> 0 then begin
        f := GetFile(fWritten, fMultiThreaded);
        if Assigned(f) then
          WriteFile(f);
      end;

    except
      on E: Exception do begin
        Inc(fErrorCount);
        if f <> nil then
          raise Exception.CreateFmt('Error processing "%s": %s', [f.FileName, E.Message])
        else
          raise;
      end;
    end;

  finally
    Inc(fProcessTick);
    SyncEndWrite;
  end;
end;


{ TwbMultiSourcePacker }

procedure TwbMultiSourcePacker.Close;
begin
  for var bsa in fSourceArchives do bsa.Free;
  SetLength(fSourceArchives, 0);
  SetLength(fSourceFiles, 0);
  fSourceFilesCount := 0;
  inherited;
end;

function TwbMultiSourcePacker.GetSourceFileData(const aFileName: string; aFileObject: Pointer): TBytes;
var
  SourceName: string;
begin
  try
    with fSourceFiles[Integer(aFileObject)] do
      if Assigned(SourceFileEntry) then begin
        SourceName := SourceFileEntry.Archive.FileName + '\' + SourceFileEntry.Name;
        Result := SourceFileEntry.Unpack;
      end
      else begin
        SourceName := SourceFileName;
        Result := TFile.ReadAllBytes(SourceFileName);
      end;
  except
    on E: Exception do
      raise Exception.Create('Error reading source "' + SourceName + '": ' + E.Message);
  end;
end;

procedure TwbMultiSourcePacker.CreateArchive(const aFileName: string; aType: TwbBSArchiveType;
  aFilesList: TStringList = nil; const aFilesCompression: TArray<Boolean> = nil);
var
  flist: TStringList;
  fcomp: TArray<Boolean>;
begin
  if (aFilesList <> nil) or (aFilesCompression <> nil) then
    raise Exception.Create('Multisource packer doesn''t require files list');

  if fSourceFilesCount = 0 then
    raise Exception.Create('No source files have been added for packing');

  flist := TStringList.Create;
  try
    flist.Capacity := Length(fSourceFiles);
    SetLength(fcomp, Length(fSourceFiles));
    for var i := 0 to Pred(fSourceFilesCount) do begin
      flist.AddObject(fSourceFiles[i].AssetName, TObject(i));
      fcomp[i] := fSourceFiles[i].Compress;
    end;

    inherited CreateArchive(aFileName, aType, flist, fcomp);
  finally
    flist.Free;
  end;
end;

procedure TwbMultiSourcePacker.SetFilters(aFilters: TArray<string>);
begin
  for var f in aFilters do
    if Trim(f) <> '' then
      fFilters := fFilters + [Trim(f)];
end;

function TwbMultiSourcePacker.Add(const aAssetName, aSourceFileName: string; aSourceFileEntry: TwbBSFileEntry;
  aCheck: Boolean = True): Boolean;
var
  i: Integer;
  Hash: TwbLookupHash;
  bFound: Boolean;
begin
  Result := False;
  if Length(fFilters) <> 0 then begin
    bFound := False;
    var s := ExtractFileName(aAssetName);
    for i := Low(fFilters) to High(fFilters) do begin
      bFound := TPath.MatchesPattern(s, fFilters[i], False);
      if bFound then
        Break;
    end;

    if not bFound then
      Exit;
  end;

  bFound := False;
  Hash := TwbHash.LookupHash(aAssetName, True);
  i := 0; // suppress compiler warning
  if aCheck then
    for i := 0 to Pred(fSourceFilesCount) do
      if TwbHash.SameLookupHash(fSourceFiles[i].Hash, Hash) then begin
        bFound := True;
        Break;
      end;

  if not bFound then begin
    if fSourceFilesCount = Length(fSourceFiles) then
      if Length(fSourceFiles) = 0 then
        SetLength(fSourceFiles, 4096)
      else
        SetLength(fSourceFiles, Length(fSourceFiles) * 2);

    i := fSourceFilesCount;
    fSourceFiles[i].AssetName := aAssetName;
    fSourceFiles[i].Hash := Hash;
    fSourceFiles[i].Compress := fCompress and not TwbAsset.DoNotCompress(aAssetName);
    Inc(fSourceFilesCount);
  end;
  fSourceFiles[i].SourceFileName := aSourceFileName;
  fSourceFiles[i].SourceFileEntry := aSourceFileEntry;
  Result := True;
end;

function TwbMultiSourcePacker.AddSourceFile(const aFileName: string): Integer;
begin
  Result := 0;
  if FileExists(aFileName) then
    if Add(TwbAsset.GetAssetName(aFileName), aFileName, nil) then
      Inc(Result);
end;

function TwbMultiSourcePacker.AddSourceFolder(const aFolder: string): Integer;
begin
  Result := 0;
  var check := fSourceFilesCount <> 0;
  var path := IncludeTrailingPathDelimiter(aFolder);
  for var f in TDirectory.GetFiles(path, '*.*', TSearchOption.soAllDirectories) do
    if not TwbAsset.DoNotPack(f) then
      if Add(TwbAsset.GetAssetName(f, path), f, nil, check) then
        Inc(Result);
end;

function TwbMultiSourcePacker.AddSourceArchive(const aArchive: string): Integer;
var
  bsa: TwbBSArchive;
begin
  Result := 0;
  for bsa in fSourceArchives do
    if SameText(bsa.FileName, aArchive) then
      Exit;

  bsa := TwbBSArchive.Create;
  bsa.MultiThreaded := Self.MultiThreaded;
  try
    bsa.LoadFromFile(aArchive);
  except
    bsa.Free;
    raise;
  end;

  var check := fSourceFilesCount <> 0;
  fSourceArchives := fSourceArchives + [bsa];
  for var f in bsa do
    if Add(f.Name, '', f, check) then
      Inc(Result);
end;

function TwbMultiSourcePacker.AddSource(const aPath: string): Integer;
begin
  Result := 0;
  if DirectoryExists(aPath) then
    Result := AddSourceFolder(aPath)
  else if FileExists(aPath) then
    if TwbBSArchive.IsArchive(aPath) then
      Result := AddSourceArchive(aPath)
    else
      Result := AddSourceFile(aPath);
end;


end.
