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

unit wbLOD;

interface

uses
  Windows,
  Classes,
  SysUtils,
  IniFiles,
  Forms,
  IOUtils,
  Masks,
  wbInterface,
  wbImplementation,
  wbHelpers,
  wbSort,
  wbStreams,
  wbDataFormat,
  wbDataFormatNif,
  wbDataFormatMaterial,
  ImagingTypes,
  ImagingFormats,
  ImagingCanvases,
  Imaging;

const
  {$IFDEF WIN64}
  sLODGenName = 'LODGenx64.exe';
  sTexconv = 'Texconvx64.exe';
  {$ELSE}
  sLODGenName = 'LODGen.exe';
  sTexconv = 'Texconv.exe';
  {$ENDIF}
  BooleanText: array[boolean] of string = ('False', 'True');
  iBillboardFlag = 4096; // mark texture as a tree billboard in atlas images

var
  iDefaultAtlasWidth: Integer = 2048;
  iDefaultAtlasHeight: Integer = 2048;
  fDefaultUVRange: Single = 1.5;
  iDefaultAtlasDiffuseFormat: TImageFormat = ifDXT3;
  iDefaultAtlasNormalFormat: TImageFormat = ifDXT1;
  iDefaultAtlasSpecularFormat: TImageFormat = ifATI2n;
  iDefaultAlphaThreshold: Integer = 128;

type
  PBinNode = ^TBinNode;

  TBinNode = record
    used: Boolean;
    x, y, w, h: Integer;
    down: PBinNode;
    right: PBinNode;
  end;

  TBinBlock = record
    Index: Integer;
    fit: Boolean;
    x, y, w, h: Integer;
    Data: Integer;
  end;

  TDynBinBlockArray = array of TBinBlock;

  // Based on http://codeincomplete.com/posts/2011/5/7/bin_packing/
  TwbBinPacker = class
  private
    fWidth, fHeight: Integer;
    fPaddingX: Integer;
    fPaddingY: Integer;
    fRoot: PBinNode;
  protected
    procedure Clear(Node: PBinNode);
    procedure NewNode(var Node: PBinNode);
    function FindNode(root: PBinNode; w, h: Integer): PBinNode;
    function SplitNode(node: PBinNode; w, h: Integer): PBinNode;
  public
    constructor Create;
    function Fit(var Blocks: TDynBinBlockArray): Boolean;
    property Width: Integer read fWidth write fWidth;
    property Height: Integer read fHeight write fHeight;
    property PaddingX: Integer read fPaddingX write fPaddingX;
    property PaddingY: Integer read fPaddingY write fPaddingY;
  end;

  TLODType = (lodTerrain, lodTrees, lodObjects);
  TLODTypes = set of TLODType;

  TAtlasRect = record
    x, y, w, h: Integer;
  end;

  TwbLodSettings = record
    SWCell, NECell: TwbGridCell;
    Stride, LODLevelMin, LODLevelMax, ObjectLevel: Integer;
    procedure Init;
    function GetSize: Integer;
    function BlockForCell(Cell: TwbGridCell; LODLevel: Integer): TwbGridCell;
    procedure LoadFromData(aData: TBytes);
    property Size: Integer read GetSize;
  end;

  TGameResourceType = (resMesh, resTexture, resSound, resMusic, resMaterial);

  // source texture for atlas builder
  TSourceAtlasTexture = record
    Name: string;
    Name_n: string;
    Name_s: string;
    Image: TImageData;
    Image_n: TImageData;
    Image_s: TImageData;
    AtlasName: string;
    X, Y, W, H: integer;
  end;
  TSourceAtlasTextures = array of TSourceAtlasTexture;

{============================== Skyrim LOD ===================================}

  // entry in LST file
  TwbLodTES5TreeType = packed record
    Index: Integer;
    Width: Single;
    Height: Single;
    UVMinX, UVMinY: Single;
    UVMaxX, UVMaxY: Single;
    Unknown: Integer;
  end;

  // entry in BTT file
  TwbLodTES5TreeRef = packed record
    X, Y, Z: Single;
    Rotation: Single; // 0..2*Pi
    Scale: Single;
    RefFormID: TwbFormID;
    Unknown1: Integer;
    Unknown2: Integer;
  end;

  // tree data when building lod
  TwbLodTES5Tree = record
    Index : Integer;
    FormID: TwbFormID;
    Billboard: string;
    CRC32: Integer;
    Width, Height: Single;
    ShiftX, ShiftY, ShiftZ, ScaleFactor: Single;
    Image: TImageData;
    function LoadFromData(aData: TBytes): Boolean;
  end;
  PwbLodTES5Tree = ^TwbLodTES5Tree;

  // handling atlas and LST file
  TwbLodTES5TreeList = class
  private
    fWorldspaceID: string;
    // structure for LST file
    fTreesList: array of TwbLodTES5TreeType;
    // list of trees when building a new LOD
    fTrees: array of TwbLodTES5Tree;
    fAtlas: TImageData;
    // list of tree references FormID numbers to avoid duplicates
    fRefFormIDs: TList;
    fRefAllowDuplicates: Boolean;
  protected
    function GetListFileName: string;
    function GetAtlasFileName: string;
    function GetTreesListCount: Integer;
    function GetTreesList(Index: Integer): TwbLodTES5TreeType;
    function GetAtlasRect(Index: Integer): TAtlasRect;
    function GetTreeByFormID(aFormID: TwbFormID): PwbLodTES5Tree;
  public
    constructor Create(WorldspaceID: string);
    destructor Destroy; override;
    procedure LoadFromData(aData: TBytes);
    procedure SaveToFile(aFileName: string);
    procedure LoadAtlas(aData: TBytes);
    function SaveAtlas(aFileName: string): Boolean;
    procedure ChangeAtlasBrightness(aBrightness: integer);
    procedure SaveFromAtlas(aIndex: Integer; aFileName: string);
    procedure CopyFromAtlas(aIndex: Integer; var Img: TImageData; ImgX, ImgY: Integer);
    function BuildAtlas(MaxAtlasSize: Integer): Boolean;
    function BillboardFileName(aFileName, aModelName: string; aFormID: TwbFormID): string;
    function AddTree(aFileName, aModelName: string; aFormID: TwbFormID; aWidth, aHeight: Single): PwbLodTES5Tree;
    property WorldspaceID: string read fWorldspaceID write fWorldspaceID;
    property ListFileName: string read GetListFileName;
    property AtlasFileName: string read GetAtlasFileName;
    property TreesListCount: Integer read GetTreesListCount;
    property TreesList[Index: Integer]: TwbLodTES5TreeType read GetTreesList;
    property AtlasRect[Index: Integer]: TAtlasRect read GetAtlasRect;
    property Atlas: TImageData read fAtlas;
    property TreeByFormID[aFormID: TwbFormID]: PwbLodTES5Tree read GetTreeByFormID;
    property RefAllowDuplicates: Boolean read fRefAllowDuplicates write fRefAllowDuplicates;
    property RefFormIDs: TList read fRefFormIDs;
  end;

  // handling BTT file
  TwbLodTES5TreeBlock = record
    TreeList: TwbLodTES5TreeList;
    Cell: TwbGridCell;
    LODLevel: Integer;
    Types: array of record Index, Count: Integer; end;
    Refs: array of array of TwbLodTES5TreeRef;
    function GetBlockFileName: string;
    procedure Init(Trees: TwbLodTES5TreeList; aCell: TwbGridCell; aLODLevel: Integer = 4);
    procedure Clear;
    procedure LoadFromData(aData: TBytes);
    procedure SaveToFile(aFileName: string);
    function AddReference(aFormID: TwbFormID; aTreeIndex: Integer;
      Pos: TwbVector; Scale: Single): Boolean;
    property FileName: string read GetBlockFileName;
  end;

function wbLODExtraOptionsFileName(const PluginName, WorldspaceID: string): string;
function wbLODSettingsFileName(const WorldspaceID: string): string;
function wbLODTreeBlockFileExt: string;
function wbNormalizeResourceName(const aName: string; aResType: TGameResourceType): string;
function wbDefaultNormalTexture(aGameMode: TwbGameMode): string;
function wbDefaultSpecularTexture(aGameMode: TwbGameMode): string;
procedure wbPrepareImageAlpha(img: TImageData; fmt: TImageFormat; threshold: Integer = 0);

procedure wbGetUVRangeTexturesList(slMeshes, slTextures: TStrings; UVRange: Single = 1.2);

procedure wbBuildAtlas(
  var Images: TSourceAtlasTextures;
  aWidth, aHeight: Integer;
  aName: string;
  fmtDiffuse, fmtNormal, fmtSpecular: TImageFormat;
  alphaThreshold: Integer
);

procedure wbBuildAtlasFromTexturesList(
  slTextures: TStrings;
  aMaxTextureSize,
  aMaxTileSize,
  aWidth, aHeight: integer;
  aName, aMapName: string;
  const Settings: TCustomIniFile
);

procedure wbBuildAtlasFromAtlasMap(slMap: TStrings; aBrightness: integer;
  GammaR, GammaG, GammaB: Single; const Settings: TCustomIniFile);

procedure wbGenerateLODTES4(const aWorldspace: IwbMainRecord; const Settings: TCustomIniFile);

procedure wbSplitTreeLOD(const aWorldspace: IwbMainRecord; const Files: TDynFiles);

procedure wbGenerateLODTES5(
  const aWorldspace: IwbMainRecord;
  const LODTypes: TLODTypes;
  const Files: TDynFiles;
  const Settings: TCustomIniFile
);

procedure wbGenerateLODFO4(
  const aWorldspace: IwbMainRecord;
  const Files: TDynFiles;
  const Settings: TCustomIniFile
);

const
  // vanilla lOD meshes having translation/rotation that must be ignored
  sMeshIgnoreTranslationTES5 =
    'meshes\lod\solitude\cwtower01_lod.nif' + ',' +
    'meshes\lod\solitude\sfarmhousesilo_lod.nif' + ',' +
    'meshes\lod\solitude\slumbermill01_lod.nif' + ',' +
    'meshes\lod\solitude\spatiowall02_lod.nif' + ',' +
    'meshes\lod\solitude\spatiowall03_lod.nif' + ',' +
    'meshes\lod\solitude\spatiowall30_lod.nif' + ',' +
    'meshes\lod\solitude\spatiowallsteps01_lod.nif' + ',' +
    'meshes\lod\solitude\spatiowallsteps02_lod.nif' + ',' +
    'meshes\lod\solitude\sstyrrshouse_lod.nif' + ',' +
    'meshes\lod\solitude\sthe winking skeever_lod.nif' + ',' +
    'meshes\lod\windhelm\wharena_lod.nif' + ',' +
    'meshes\lod\windhelm\whbrunwulfsq_lod.nif' + ',' +
    'meshes\lod\windhelm\whgrayquarter_lod.nif' + ',' +
    'meshes\lod\windhelm\whinnerwall01_lod.nif' + ',' +
    'meshes\lod\windhelm\whinnerwall02_lod.nif' + ',' +
    'meshes\lod\windhelm\whinnland_lod.nif' + ',' +
    'meshes\lod\windhelm\whmaingate_lod.nif' + ',' +
    'meshes\lod\windhelm\whmarket01_lod.nif' + ',' +
    'meshes\lod\windhelm\whouterwall3_lod.nif' + ',' +
    'meshes\lod\windhelm\whpalace_lod.nif' + ',' +
    'meshes\lod\windhelm\whtempletalos_lod.nif' + ',' +
    'meshes\lod\windhelm\whvalunstrad_lod.nif';

  sMeshIgnoreTranslationFNV = 'nif'; // all LOD meshes

  // vanilla lOD meshes to treat as untiled even though they have large UV values
  sMeshForceUntiled =
    // Skyrim
     'meshes\lod\whiterun\wrplainsdistrictterrainlod_lod.nif' +
    ',meshes\lod\whiterun\wrplainsdistrictterrainlod_lod_2.nif' +
    // Fallout 4
    ',meshes\lod\landscape\roads\bridge\roadstrbridgemidend02_lod_0.nif' +
    ',meshes\lod\neighborhoods\esplanade\esplanade_bld20lod.nif';


implementation

uses
  Math;

function wbLODExtraOptionsFileName(const PluginName, WorldspaceID: string): string;
begin
  Result := wbAppName + 'LODGen_' + PluginName + '_' + WorldSpaceID + '_Options.txt';
end;

function wbLODSettingsFileName(const WorldspaceID: string): string;
begin
  if wbGameMode = gmTES4 then
    Result := ''
  else if wbIsFallout3 then
    Result := 'lodsettings\' + WorldspaceID + '.dlodsettings'
  else
    Result := 'lodsettings\' + WorldspaceID + '.lod';
end;

function wbLODTreeBlockFileExt: string;
begin
  if wbIsSkyrim then
    Result := 'btt'
  else if wbIsFallout3 then
    Result := 'dtl'
  else
    Result := '';
end;

function wbDefaultNormalTexture(aGameMode: TwbGameMode): string;
begin
  if wbIsFallout4 then
    Result := 'textures\shared\flatflat_n.dds'
  else if wbIsSkyrim then
    Result := 'textures\default_n.dds'
  else if wbIsFallout3 then
    Result := 'textures\shared\shadefade01_n.dds'
  else
    Result := '';
end;

function wbDefaultSpecularTexture(aGameMode: TwbGameMode): string;
begin
  if wbIsFallout4 then
    Result := 'textures\shared\white01_s.dds'
  else
    Result := '';
end;


{ TwbLodSettings }

procedure TwbLodSettings.Init;
begin
  LODLevelMin := 4;
  LODLevelMax := 32;
end;

function TwbLodSettings.GetSize: Integer;
begin
  Result := Ceil(Stride/sqrt(2));
end;

function TwbLodSettings.BlockForCell(Cell: TwbGridCell; LODLevel: Integer): TwbGridCell;
begin
  Result.x := SWCell.x + ((Cell.x - SWCell.x) div LODLevel) * LODLevel;
  Result.y := SWCell.y + ((Cell.y - SWCell.y) div LODLevel) * LODLevel;
end;

procedure TwbLodSettings.LoadFromData(aData: TBytes);
const
  sError = 'Invalid lodsettings file';
begin
  // Fallouts
  if wbIsFallout3 then begin
    if Length(aData) <> 24 then
      raise Exception.Create(sError);
    LODLevelMin := PInteger(@aData[0])^;
    LODLevelMax := PInteger(@aData[4])^;
    Stride := PInteger(@aData[8])^;
    SWCell.x := PSmallInt(@aData[12])^;
    SWCell.y := PSmallInt(@aData[14])^;
    NECell.x := PSmallInt(@aData[16])^;
    NECell.y := PSmallInt(@aData[18])^;
    ObjectLevel := PInteger(@aData[20])^;
  end
  // Skyrim
  else begin
    if Length(aData) <> 16 then
      raise Exception.Create(sError);
    SWCell.x := PSmallInt(@aData[0])^;
    SWCell.y := PSmallInt(@aData[2])^;
    Stride := PInteger(@aData[4])^;
    LODLevelMin := PInteger(@aData[8])^;
    LODLevelMax := PInteger(@aData[12])^;
  end;
end;

{ TwbBinPacker }

constructor TwbBinPacker.Create;
begin
  fWidth := 1024;
  fHeight := 1024;
  fPaddingX := 0;
  fPaddingY := 0;
end;

procedure TwbBinPacker.Clear(Node: PBinNode);
begin
  if Assigned(Node) then begin
    Clear(Node^.right);
    Clear(Node^.down);
    Dispose(Node);
  end;
end;

procedure TwbBinPacker.NewNode(var Node: PBinNode);
begin
  New(Node);
  FillChar(Node^, SizeOf(TBinNode), 0);
end;

function TwbBinPacker.FindNode(root: PBinNode; w, h: Integer): PBinNode;
begin
  if root^.used then begin
    Result := FindNode(root^.right, w, h);
    if not Assigned(Result) then
      Result := FindNode(root^.down, w, h);
  end
  else if (w <= root^.w) and (h <= root^.h) then
    Result := root
  else
    Result := nil;
end;

function TwbBinPacker.SplitNode(node: PBinNode; w, h: Integer): PBinNode;
begin
  node^.used := True;
  NewNode(node^.down);
  node^.down^.x := node^.x;
  node^.down^.y := node^.y + h + fPaddingY;
  node^.down^.w := node^.w;
  node^.down^.h := node^.h - h - fPaddingY;
  NewNode(node^.right);
  node^.right^.x := node^.x + w + fPaddingX;
  node^.right^.y := node^.y;
  node^.right^.w := node^.w - w - fPaddingX;
  node^.right^.h := h;
  Result := node;
end;

function TwbBinPacker.Fit(var Blocks: TDynBinBlockArray): Boolean;

  procedure MaxSideSort(var Blocks: TDynBinBlockArray);
  var
    i: Integer;
    changed: Boolean;
    temp: TBinBlock;
  begin
    changed := True;
    while changed do begin
      changed := False;
      for i := Low(Blocks) to Pred(High(Blocks)) do
        if Max(Blocks[i].w, Blocks[i].h) < Max(Blocks[i+1].w, Blocks[i+1].h) then begin
        //if Blocks[i].w * Blocks[i].h < Blocks[i+1].w * Blocks[i+1].h then begin
          temp := Blocks[i+1];
          Blocks[i+1] := Blocks[i];
          Blocks[i] := temp;
          changed := True;
        end;
    end;
  end;

var
  i: integer;
  node: PBinNode;
begin
  Result := True;
  NewNode(fRoot);
  fRoot^.w := fWidth;
  fRoot^.h := fHeight;
  MaxSideSort(Blocks);
  for i := Low(Blocks) to High(Blocks) do begin
    node := FindNode(fRoot, Blocks[i].w, Blocks[i].h);
    if Assigned(node) then begin
      node := SplitNode(node, Blocks[i].w, Blocks[i].h);
      Blocks[i].x := node^.x;
      Blocks[i].y := node^.y;
      Blocks[i].fit := True;
    end else
      Result := False;
  end;
  Clear(fRoot);
  fRoot := nil;
end;

{============================== Skyrim LOD ===================================}

{ TwbLodTES5Tree }

function TwbLodTES5Tree.LoadFromData(aData: TBytes): Boolean;
begin
  InitImage(Image);
  Result := LoadImageFromMemory(@aData[0], Length(aData), Image);
end;


{ TwbLodTES5TreeList }

constructor TwbLodTES5TreeList.Create(WorldspaceID: string);
begin
  fWorldspaceID := WorldspaceID;
  if fWorldspaceID = '' then
    fWorldspaceID := 'Tamriel';
  RefAllowDuplicates := False;
  fRefFormIDs := TList.Create;
end;

destructor TwbLodTES5TreeList.Destroy;
var
  i: Integer;
begin
  if fAtlas.Format <> ifUnknown then
    FreeImage(fAtlas);
  for i := Low(fTrees) to High(fTrees) do
    if fTrees[i].Image.Format <> ifUnknown then
      FreeImage(fTrees[i].Image);
  fRefFormIDs.Free;
  inherited;
end;

function TwbLodTES5TreeList.GetListFileName: string;
begin
  if wbIsSkyrim then
    Result := 'Meshes\Terrain\' + fWorldspaceID + '\Trees\' + fWorldspaceID + '.lst'
  else if wbIsFallout3 then
    Result := 'Meshes\Landscape\LOD\' + fWorldspaceID + '\Trees\TreeTypes.lst'
  else
    Result := '';
end;

function TwbLodTES5TreeList.GetAtlasFileName: string;
begin
  if wbIsSkyrim then
    Result := 'Textures\Terrain\' + fWorldspaceID + '\Trees\' + fWorldspaceID + 'TreeLod.dds'
  else if wbIsFallout3 then begin
    if SameText(Copy(fWorldspaceID, 1, 4), 'DLC4') then
      Result := 'Textures\Landscape\Trees\TreeSwampLod.dds'
    else
      Result := 'Textures\Landscape\Trees\TreeDeadLod.dds';
  end else
    Result := '';
end;

function TwbLodTES5TreeList.GetTreesListCount: Integer;
begin
  Result := Length(fTreesList);
end;

function TwbLodTES5TreeList.GetTreesList(Index: Integer): TwbLodTES5TreeType;
begin
  Result := fTreesList[Index];
end;

function TwbLodTES5TreeList.GetAtlasRect(Index: Integer): TAtlasRect;
begin
  if fAtlas.Format = ifUnknown then
    Exit;

  with TreesList[Index] do begin
    Result.x := Round(fAtlas.Width * UVMinX);
    Result.y := Round(fAtlas.Height * UVMinY);
    Result.w := Round(fAtlas.Width * (UVMaxX - UVMinX));
    Result.h := Round(fAtlas.Height * (UVMaxY - UVMinY));
  end;
end;

function TwbLodTES5TreeList.GetTreeByFormID(aFormID: TwbFormID): PwbLodTES5Tree;
var
  i: Integer;
begin
  Result := nil;
  for i := Low(fTrees) to High(fTrees) do
    if fTrees[i].FormID = aFormID then begin
      Result := @fTrees[i];
      Break;
    end;
end;

function TwbLodTES5TreeList.BillboardFileName(aFileName, aModelName: string; aFormID: TwbFormID): string;
begin
  Result := Format('Textures\Terrain\LODGen\%s\%s_%s.dds', [
    aFileName,
    ChangeFileExt(ExtractFileName(aModelName), ''),
    aFormID.ChangeFileID(TwbFileID.Null).ToString(False)
  ]);
end;

function TwbLodTES5TreeList.AddTree(aFileName, aModelName: string; aFormID: TwbFormID; aWidth, aHeight: Single): PwbLodTES5Tree;
var
  i, idx: integer;
begin
  idx := -1;
  for i := Low(fTrees) to High(fTrees) do
    if fTrees[i].Index > idx then idx := fTrees[i].Index;
  SetLength(fTrees, Succ(Length(fTrees)));
  Result := @fTrees[Pred(Length(fTrees))];
  Result^.Index := Succ(idx);
  Result^.FormID := aFormID;
  Result^.BillBoard := BillboardFileName(aFileName, aModelName, aFormID);
  Result^.Width := aWidth;
  Result^.Height := aHeight;
  Result^.ShiftX := 0.0;
  Result^.ShiftY := 0.0;
  Result^.ShiftZ := 0.0;
  Result^.ScaleFactor := 1.0;
end;

procedure TwbLodTES5TreeList.LoadFromData(aData: TBytes);
var
  TreesNum: integer;
begin
  if Length(aData) < SizeOf(Integer) then begin
    SetLength(fTreesList, 0);
    Exit;
  end;

  TreesNum := PInteger(@aData[0])^;

  if Length(aData) - 4 < SizeOf(TwbLodTES5TreeType) * TreesNum then
    raise Exception.Create('Invalid LST file');

  SetLength(fTreesList, TreesNum);

  Move(aData[4], fTreesList[0], SizeOf(TwbLodTES5TreeType) * TreesNum);
end;

procedure TwbLodTES5TreeList.SaveToFile(aFileName: string);
var
  Value: Integer;
begin
  if TreesListCount > 0 then
  with TFileStream.Create(aFileName, fmCreate) do try
    Value := TreesListCount;
    Write(Value, SizeOf(Value));
    Write(fTreesList[0], SizeOf(TwbLodTES5TreeType) * TreesListCount);
  finally
    Free;
  end;
end;

procedure TwbLodTES5TreeList.LoadAtlas(aData: TBytes);
begin
  InitImage(fAtlas);
  LoadImageFromMemory(@aData[0], Length(aData), fAtlas);
end;

function TwbLodTES5TreeList.SaveAtlas(aFileName: string): Boolean;
var
  MipmapImg: TDynImageDataArray;
begin
  SetOption(ImagingMipMapFilter, Ord(sfLanczos));
  try
    Result := ConvertImage(fAtlas, ifDXT3);
    if not Result then
      raise Exception.Create('Can''t compress atlas')
    else
      Result := GenerateMipMaps(fAtlas, 0, MipmapImg);
    if not Result then
      raise Exception.Create('Can''t generate mipmaps')
    else
      Result := SaveMultiImageToFile(aFileName, MipmapImg);
  finally
    FreeImagesInArray(MipmapImg);
  end;
end;

procedure TwbLodTES5TreeList.ChangeAtlasBrightness(aBrightness: integer);
var
  Canvas: TImagingCanvas;
begin
  if aBrightness = 0 then
    Exit;

  Canvas := TImagingCanvas.CreateForData(@fAtlas);
  try
    Canvas.ModifyContrastBrightness(aBrightness / 10, aBrightness);
  finally
    Canvas.Free;
  end;
end;

procedure TwbLodTES5TreeList.SaveFromAtlas(aIndex: Integer; aFileName: string);
var
  img: TImageData;
begin
  if fAtlas.Format = ifUnknown then
    Exit;

  with AtlasRect[aIndex] do begin
    NewImage(w, h, ifDXT3, img);
    try
      CopyRect(fAtlas, x, y, w, h, img, 0, 0);
      SaveImageToFile(aFileName, img);
    finally
      FreeImage(img);
    end;
  end;
end;

procedure TwbLodTES5TreeList.CopyFromAtlas(aIndex: Integer; var Img: TImageData; ImgX, ImgY: Integer);
begin
  if fAtlas.Format = ifUnknown then
    Exit;

  with AtlasRect[aIndex] do
    CopyRect(fAtlas, x, y, w, h, Img, ImgX, ImgY);
end;

function TwbLodTES5TreeList.BuildAtlas(MaxAtlasSize: Integer): Boolean;
var
  i, j, k: Integer;
  Blocks: TDynBinBlockArray;
begin
  for i := Low(fTrees) to High(fTrees) do begin
    // skip trees with missing/invalid textures
    if fTrees[i].Index = -1 then
      Continue;

    // exclude duplicate textures by checksum
    k := -1;
    for j := Low(fTrees) to i - 1 do
      if fTrees[j].CRC32 = fTrees[i].CRC32 then begin
        k := j;
        Break;
      end;
    if k <> -1 then
      Continue;

    SetLength(Blocks, Succ(Length(Blocks)));
    with Blocks[Pred(Length(Blocks))] do begin
      Index := fTrees[i].Index;
      w := fTrees[i].Image.Width;
      h := fTrees[i].Image.Height;
      Data := fTrees[i].CRC32;
    end;
  end;

  Result := False;
  if Length(Blocks) = 0 then
    Exit;

  with TwbBinPacker.Create do try
    Width := Min(512, MaxAtlasSize);
    Height := Min(512, MaxAtlasSize);
    PaddingX := 2;
    PaddingY := 2;
    // increase atlas size until all blocks fit
    while not Fit(Blocks) do begin
      if Width <= Height then
        Width := Width * 2
      else
        Height := Height * 2;
      if (Width > MaxAtlasSize) or (Height > MaxAtlasSize) then
        raise Exception.Create('Can''t fit billboards on atlas, not enough space');
    end;
    NewImage(Width, Height, ifDefault, fAtlas);
  finally
    Free;
  end;

  // drawing atlas and creating a list of trees with UVs
  for i := Low(fTrees) to High(fTrees) do begin
    if fTrees[i].Index = -1 then
      Continue;
    // getting atlas block by checksum
    for j := Low(Blocks) to High(Blocks) do
      if Blocks[j].Data = fTrees[i].CRC32 then
        Break;
    if not CopyRect(fTrees[i].Image, 0, 0, Blocks[j].w, Blocks[j].h, fAtlas, Blocks[j].x, Blocks[j].y) then
      raise Exception.Create('Error when drawing atlas');

    SetLength(fTreesList, Succ(Length(fTreesList)));
    with fTreesList[Pred(Length(fTreesList))] do begin
      Index := fTrees[i].Index;
      Width := fTrees[i].Width;
      Height := fTrees[i].Height;
      UVMinX := Blocks[j].x / fAtlas.Width;
      UVMaxX := (Blocks[j].x + Blocks[j].w) / fAtlas.Width;
      UVMinY := Blocks[j].y / fAtlas.Height;
      UVMaxY := (Blocks[j].y + Blocks[j].h) / fAtlas.Height;
    end;
  end;

  Result := True;
end;


{ TwbLodTES5TreeBlock }

procedure TwbLodTES5TreeBlock.Init(Trees: TwbLodTES5TreeList; aCell: TwbGridCell; aLODLevel: Integer = 4);
begin
  TreeList := Trees;
  Cell := aCell;
  LODLevel := aLODLevel;
end;

procedure TwbLodTES5TreeBlock.Clear;
begin
  SetLength(Types, 0);
  SetLength(Refs, 0);
end;

function TwbLodTES5TreeBlock.GetBlockFileName: string;
begin
  Result := '';

  if wbIsSkyrim then
    Result := 'meshes\terrain\%s\trees\%s.%d.%d.%d.' + wbLODTreeBlockFileExt
  else if wbIsFallout3 then
    Result := 'meshes\landscape\lod\%s\trees\%s.level%d.x%d.y%d.' + wbLODTreeBlockFileExt
  else
    Exit;

  Result := Format(Result, [
    TreeList.WorldspaceID,
    TreeList.WorldspaceID,
    LODLevel,
    Cell.x,
    Cell.y
  ]);
end;

procedure TwbLodTES5TreeBlock.LoadFromData(aData: TBytes);
const
  sError = 'Invalid tree LOD block file';
var
  TypesNum, TreesNum, i, p: integer;
begin
  if Length(aData) < SizeOf(Integer) then begin
    Clear;
    Exit;
  end;

  p := 0;
  TypesNum := PInteger(@aData[p])^;
  Inc(p, SizeOf(Integer));

  SetLength(Types, TypesNum);
  SetLength(Refs, TypesNum);

  for i := 0 to TypesNum - 1 do begin
    if p >= Length(aData) then
      raise Exception.Create(sError);

    // tree type
    Types[i].Index := PInteger(@aData[p])^;
    Inc(p, SizeOf(Integer));
    if p >= Length(aData) then
      raise Exception.Create(sError);

    // number of trees
    TreesNum := PInteger(@aData[p])^;
    Types[i].Count := TreesNum;
    Inc(p, SizeOf(Integer));
    if p >= Length(aData) then
      raise Exception.Create(sError);

    // ref array
    SetLength(Refs[i], TreesNum);
    Move(aData[p], Refs[i][0], SizeOf(TwbLodTES5TreeRef) * TreesNum);
    Inc(p, SizeOf(TwbLodTES5TreeRef) * TreesNum);
  end;
end;

procedure TwbLodTES5TreeBlock.SaveToFile(aFileName: string);
var
  Value, i: Integer;
  fs: TFileStream;
begin
  with TMemoryStream.Create do try
    Value := Length(Types);
    Write(Value, SizeOf(Value));
    for i := 0 to Pred(Length(Types)) do begin
      Write(Types[i].Index , SizeOf(Types[i].Index));
      Write(Types[i].Count , SizeOf(Types[i].Count));
      Write(Refs[i][0], SizeOf(TwbLodTES5TreeRef) * Types[i].Count);
    end;
    fs := TFileStream.Create(aFileName, fmCreate);
    try
      SaveToStream(fs);
    finally
      fs.Free;
    end;
  finally
    Free;
  end;
end;

function TwbLodTES5TreeBlock.AddReference(aFormID: TwbFormID; aTreeIndex: Integer;
  Pos: TwbVector; Scale: Single): Boolean;
var
  i, j: integer;
begin
  // check that FormID number is not duplicate
  if (not TreeList.RefAllowDuplicates) and (TreeList.RefFormIDs.IndexOf(Pointer(aFormID.ObjectID)) <> -1) then begin
    Result := False;
    Exit;
  end;
  j := -1;
  for i := Low(Types) to High(Types) do
    if Types[i].Index = aTreeIndex then begin
      j := i;
      Break;
    end;
  if j = -1 then begin
    SetLength(Types, Succ(Length(Types)));
    j := Pred(Length(Types));
    Types[j].Index := aTreeIndex;
    SetLength(Refs, Succ(Length(Refs)));
  end;
  Inc(Types[j].Count);
  if Types[j].Count > Length(Refs[j]) then
    SetLength(Refs[j], Length(Refs[j]) + 64);
  i := Pred(Types[j].Count);
  Refs[j][i].RefFormID := aFormID;
  Refs[j][i].X := Pos.x;
  Refs[j][i].Y := Pos.y;
  Refs[j][i].Z := Pos.z;
  Refs[j][i].Scale := Scale;
  Refs[j][i].Rotation := 2*Pi*Random;

  TreeList.RefFormIDs.Add(Pointer(aFormID.ObjectID));
  Result := True;
end;

function wbNormalizeResourceName(const aName: string; aResType: TGameResourceType): string;
var
  i: integer;
begin
  Result := Trim(StringReplace(LowerCase(aName), '/', '\', [rfReplaceAll]));
  if Length(Result) < 2 then
    Exit;

  // absolute path, cut everything before Data or leave only file name
  if Result[2] = ':' then begin
    i := Pos('data\', Result);
    if i <> 0 then
      Delete(Result, 1, Pred(i))
    else
      Result := ExtractFileName(Result);
  end;
  // starts with slash, remove it
  if Result[1] = '\' then Delete(Result, 1, 1);
  // starts with Data, remove it
  if Copy(Result, 1, 5) = 'data\' then Delete(Result, 1, 5);
  // root folder in Data for different resource types
  if (aResType = resMesh) and (Copy(Result, 1, 7) <> 'meshes\') then
    Result := 'meshes\' + Result
  else if (aResType = resTexture) and (Copy(Result, 1, 9) <> 'textures\') then
    Result := 'textures\' + Result
  else if (aResType = resSound) and (Copy(Result, 1, 6) <> 'sound\') then
    Result := 'sound\' + Result
  else if (aResType = resMusic) and (Copy(Result, 1, 6) <> 'music\') then
    Result := 'music\' + Result
  else if (aResType = resMaterial) and (Copy(Result, 1, 10) <> 'materials\') then
    Result := 'materials\' + Result;
end;

procedure wbPrepareImageAlpha(img: TImageData; fmt: TImageFormat; threshold: Integer = 0);
var
  x, y: integer;
  c: TColor32Rec;
  fmtInfo: TImageFormatInfo;
begin
  // threshold = 0, convert to max alpha for formats saved without alpha, otherwise they will become black
  // threshold <> 0, convert alpha to 0/1 transparency
  GetImageFormatInfo(fmt, fmtInfo);
  // do not convert formats that support alpha (DXT1 supports 0/1 transparancy)
  if fmtINfo.HasAlphaChannel and not (fmt in [ifDXT1]) then
    Exit;
  // always convert formats that do not support alpha to max alpha
  if not fmtINfo.HasAlphaChannel then
    threshold := 0;
  for x := 0 to Pred(img.Width) do
    for y := 0 to Pred(img.Height) do begin
      c := GetPixel32(img, x, y);
      if c.A >= threshold then
        c.A := 255
      else
        c.A := 0;
      SetPixel32(img, x, y, c);
    end;
end;

procedure wbGetUVRangeTexturesList(slMeshes, slTextures: TStrings; UVRange: Single = 1.2);
const
  // UV values outside of this +/- range will be considered an error and ignored
  fCheckRange = 100.0;

  procedure AddTexture(const s: string);
  var
    t: string;
  begin
    if s <> '' then begin
      t := wbNormalizeResourceName(s, resTexture);
      if slTextures.IndexOf(t) = -1 then
        slTextures.Add(t);
    end;
  end;

  function Tiled(u, v: single): Boolean;
  begin
    Result := False;
    // there are NaN UVs in FO4: meshes\lod\landscape\roads\bridge\roadstrbridgemidend01_lod_0.nif
    if not (IsNan(u) or IsNan(v)) then
      // check only UVs that fall into checking range, others are errors in meshes which can be ignored
      if (u > -fCheckRange) and (u < fCheckRange) and (v > -fCheckRange) and (v < fCheckRange) then
        if (u < -UVRange) or (u > UVRange) or (v < -UVRange) or (v > UVRange) then
          Result := True;
  end;

var
  i, b, j: integer;
  nif: TwbNifFile;
  bgsm: TwbBGSMFile;
  Shape, ShapeData, Shader, TextureSet: TwbNifBlock;
  Entries, Entry: TdfElement;
  u, v: Single;
  bTiled: Boolean;
  nifname, s: string;
begin
  if not Assigned(slMeshes) or not Assigned(slTextures) then
    Exit;

  nif := TwbNifFile.Create;
  bgsm := TwbBGSMFile.Create;
  try
    for i := 0 to Pred(slMeshes.Count) do begin
      // if dds is passed then use it as is (billboard for 3D Trees LOD)
      if SameText(ExtractFileExt(slMeshes[i]), '.dds') then begin
        slTextures.AddObject(slMeshes[i], Pointer(iBillboardFlag)); // flag as billboard
        Continue;
      end;

      nifname := wbNormalizeResourceName(slMeshes[i], resMesh);
      if ExtractFileExt(nifname) <> '.nif' then
        Continue;

      //WriteLn(nifname);
      //if nifname <> 'meshes\lod\whiterun\wrplainsdistrictterrainlod_lod.nif' then Continue;

      if not wbContainerHandler.ResourceExists(nifname) then begin
        wbProgressCallback('<Warning: LOD mesh not found "' + nifname + '">');
        Continue;
      end;

      try
        nif.LoadFromResource(nifname);
      except
        on E: Exception do begin
          wbProgressCallback('<Warning: Error when loading "' + nifname + '": ' + E.Message + '>');
          Continue;
        end;
      end;

      for b := 0 to Pred(nif.BlocksCount) do begin
        Shape := nif.Blocks[b];

        // BSTriShape and inherited blocks
        if Shape.IsNiObject('BSTriShape', True) then begin
          // skip if no shader
          Shader := Shape.PropertyByType('BSLightingShaderProperty');
          if not Assigned(Shader) then
            Continue;

          // skip if no UVs
          if not Shape.NativeValues['VertexDesc\VF\VF_UV'] then
            Continue;

          Entries := Shape.Elements['Vertex Data'];
          if not Assigned(Entries) then
            Continue;

          bTiled := Entries.Count = 0;
          if Pos(nifname, sMeshForceUntiled) = 0 then
            for j := 0 to Pred(Entries.Count) do begin
              Entry := Entries[j].Elements['UV'];
              u := Entry.NativeValues['U'];
              v := Entry.NativeValues['V'];
              bTiled := Tiled(u, v);
              if bTiled then
                Break;
            end;

          if not bTiled then begin
            s := wbNormalizeResourceName(Shader.EditValues['Name'], resMaterial);
            // getting textures from material first, it has priority over textureset
            if (ExtractFileExt(s) = '.bgsm') and wbContainerHandler.ResourceExists(s) then begin
              try
                bgsm.LoadFromResource(s);
                AddTexture(bgsm.EditValues['Textures\Diffuse']);
              except
                on E: Exception do
                  wbProgressCallback('<Warning: Error when loading "' + s + '": ' + E.Message + '>');
              end;
            end
            // getting textures from textureset
            else begin
              TextureSet := TwbNifBlock(Shader.Elements['Texture Set'].LinksTo);
              if not Assigned(TextureSet) then
                Continue;
              Entries := TextureSet.Elements['Textures'];
              if Entries.Count <> 0 then
                AddTexture(Entries[0].EditValue);
            end;
          end;// else WriteLn('Tiled: ' + nifname);
        end

        // NiTriShape/NiTriStrips
        else if Shape.IsNiObject('NiTriBasedGeom', True) then begin
          // skip if no shader
          Shader := Shape.PropertyByType('BSLightingShaderProperty');
          // FO3 shader
          if not Assigned(Shader) then
            Shader := Shape.PropertyByType('BSShaderPPLightingProperty');
          if not Assigned(Shader) then
            Continue;

          // skip if no textureset
          TextureSet := TwbNifBlock(Shader.Elements['Texture Set'].LinksTo);
          if not Assigned(TextureSet) then
            Continue;

          // skip if no Data
          ShapeData := TwbNifBlock(Shape.Elements['Data'].LinksTo);
          if not Assigned(ShapeData) then
            Continue;

          // skip if no UVs
          Entries := ShapeData.Elements['UV Sets'];
          if not Assigned(Entries) or (Entries.Count = 0) then
            Continue;

          Entries := Entries[0];
          bTiled := Entries.Count = 0;

          if Pos(nifname, sMeshForceUntiled) = 0 then
            for j := 0 to Pred(Entries.Count) do begin
              u := Entries[j].NativeValues['U'];
              v := Entries[j].NativeValues['V'];
              bTiled := Tiled(u, v);
              if bTiled then
                Break;
            end;

          if not bTiled then begin
            Entries := TextureSet.Elements['Textures'];
            if Entries.Count <> 0 then
              AddTexture(Entries[0].EditValue);
          end;// else WriteLn('Tiled: ' + nifname);
        end;

      end;
    end;
  finally
    nif.Free;
    bgsm.Free;
  end;
end;

function wbLoadImageFromMemory(Data: Pointer; aSize: LongInt; var Image: TImageData): Boolean;
type
  TMagic = array [0..3] of AnsiChar;
  PMagic = ^TMagic;
const
  sDDSMagic: TMagic = 'DDS ';
var
  s, c: string;
  b: TBytes;
  ErrCode: cardinal;
begin
  // native function
  Result := LoadImageFromMemory(Data, aSize, Image);

  // image loaded without problem?
  if Result then
    Exit;

  // try to convert unknown format DDS texture to the known one and load again
  if not ( (aSize > Length(sDDSMagic)) and (PMagic(Data)^ = sDDSMagic) ) then
    Exit;

  // temp file - better to use TPath.GetGUIDFileName if multithreaded
  s := wbTempPath + TPath.GetGUIDFileName + '.dds';

  // check temp path
  if not ForceDirectories(wbTempPath) then
    Exit;

  // write image to temp file
  with TFileStream.Create(s, fmCreate) do try
    WriteBuffer(Data^, aSize);
  finally
    Free;
  end;

  // command line
  c := '"' + wbScriptsPath + sTexconv + '" -nologo -y -f R32G32B32A32_FLOAT -o "' + ExcludeTrailingPathDelimiter(wbTempPath) + '" "' + s + '"';
  // execute command
  ErrCode := ExecuteCaptureConsoleOutput(c);

  // load the converted image from temp file if no error reported
  if (ErrCode = 0) and FileExists(s) then begin
    b := TFile.ReadAllBytes(s);
    Result := wbLoadImageFromMemory(@b[0], Length(b), Image);
  end;

  // remove temp file
  if FileExists(s) then
    DeleteFile(s);
end;

procedure wbBuildAtlas(
  var Images: TSourceAtlasTextures;
  aWidth, aHeight: Integer;
  aName: string;
  fmtDiffuse, fmtNormal, fmtSpecular: TImageFormat;
  alphaThreshold: Integer
);
var
  i, num, maxw, maxh: integer;
  Blocks, Blocks2: TDynBinBlockArray;
  atlas, crop: TImageData;
  mipmap: TDynImageDataArray;
  fname: string;
begin
  if Length(Images) = 0 then
    Exit;

  SetLength(Blocks, Length(Images));
  for i := Low(Blocks) to High(Blocks) do begin
    Blocks[i].Index := i;
    Blocks[i].w := Images[i].Image.Width;
    Blocks[i].h := Images[i].Image.Height;
  end;

  SetOption(ImagingMipMapFilter, Ord(sfLanczos));
  num := 0;
  aName := ChangeFileExt(aName, '');

  InitImage(atlas);
  InitImage(crop);

  with TwbBinPacker.Create do try
    Width := aWidth;
    Height := aHeight;
    repeat
      // try to fit images on atlas
      while not Fit(Blocks) do begin
        // if not fit, remove images one by one from the end and try again
        // at least 2 textures per atlas, useless otherwise
        if Length(Blocks) > 2 then begin
          SetLength(Blocks2, Succ(Length(Blocks2)));
          Blocks2[Pred(Length(Blocks2))] := Blocks[Pred(Length(Blocks))];
          SetLength(Blocks, Pred(Length(Blocks)));
        end else
          Exit;
      end;
      // we are here if Blocks fit
      // if unfitted blocks are left, then numerate atlases
      if (Length(Blocks2) <> 0) or (num <> 0) then
        fname := aName + Format('%.2d', [num]) + '.dds'
      else
        fname := aName + '.dds';

      // diffuse atlas
      NewImage(aWidth, aHeight, ifDefault, atlas);
      try
        maxw := 0;
        maxh := 0;
        for i := Low(Blocks) to High(Blocks) do begin
          CopyRect(
            Images[Blocks[i].Index].Image, 0, 0, Blocks[i].w, Blocks[i].h,
            atlas, Blocks[i].x, Blocks[i].y
          );
          Images[Blocks[i].Index].AtlasName := fname;
          Images[Blocks[i].Index].X := Blocks[i].x;
          Images[Blocks[i].Index].Y := Blocks[i].y;
          // find the actual width and height of atlas tiles
          if maxw < Blocks[i].x + Blocks[i].w then
            maxw := Blocks[i].x + Blocks[i].w;
          if maxh < Blocks[i].y + Blocks[i].h then
            maxh := Blocks[i].y + Blocks[i].h;
        end;

        // round to the larger power of 2 value
        i := 1; while i < maxw do i := i * 2; maxw := i;
        i := 1; while i < maxh do i := i * 2; maxh := i;
        // crop if less than atlas size
        if (maxw < aWidth) or (maxh < aHeight) then begin
          NewImage(maxw, maxh, ifDefault, crop);
          try
            CopyRect(atlas, 0, 0, maxw, maxh, crop, 0, 0);
            CloneImage(crop, atlas);
          finally
            FreeImage(crop);
          end;
        end;
        // store atlas size
        for i := Low(Blocks) to High(Blocks) do begin
          Images[Blocks[i].Index].W := maxw;
          Images[Blocks[i].Index].H := maxh;
        end;

        wbPrepareImageAlpha(atlas, fmtDiffuse, alphaThreshold);
        if not ConvertImage(atlas, fmtDiffuse) then
          raise Exception.Create('Image convertion error');

        try
          GenerateMipMaps(atlas, 0, mipmap);
          SaveMultiImageToFile(fname, mipmap);
        finally
          FreeImagesInArray(mipmap);
        end;
      finally
        FreeImage(atlas);
      end;

      // normals atlas
      if (Length(Blocks2) <> 0) or (num <> 0) then
        fname := aName + Format('%.2d', [num]) + '_n.dds'
      else
        fname := aName + '_n.dds';

      NewImage(aWidth, aHeight, ifDefault, atlas);
      try
        for i := Low(Blocks) to High(Blocks) do
          CopyRect(
            Images[Blocks[i].Index].Image_n, 0, 0, Blocks[i].w, Blocks[i].h,
            atlas, Blocks[i].x, Blocks[i].y
          );

        // crop if less than atlas size
        if (maxw < aWidth) or (maxh < aHeight) then begin
          NewImage(maxw, maxh, ifDefault, crop);
          try
            CopyRect(atlas, 0, 0, maxw, maxh, crop, 0, 0);
            CloneImage(crop, atlas);
          finally
            FreeImage(crop);
          end;
        end;

        wbPrepareImageAlpha(atlas, fmtNormal);
        if not ConvertImage(atlas, fmtNormal) then
          raise Exception.Create('Image convertion error');

        try
          GenerateMipMaps(atlas, 0, mipmap);
          SaveMultiImageToFile(fname, mipmap);
        finally
          FreeImagesInArray(mipmap);
        end;
      finally
        FreeImage(atlas);
      end;

      // speculars atlas
      if wbIsFallout4 then begin

        if (Length(Blocks2) <> 0) or (num <> 0) then
          fname := aName + Format('%.2d', [num]) + '_s.dds'
        else
          fname := aName + '_s.dds';

        NewImage(aWidth, aHeight, ifDefault, atlas);
        try
          for i := Low(Blocks) to High(Blocks) do
            CopyRect(
              Images[Blocks[i].Index].Image_s, 0, 0, Blocks[i].w, Blocks[i].h,
              atlas, Blocks[i].x, Blocks[i].y
            );

          if (maxw < aWidth) or (maxh < aHeight) then begin
            NewImage(maxw, maxh, ifDefault, crop);
            try
              CopyRect(atlas, 0, 0, maxw, maxh, crop, 0, 0);
              CloneImage(crop, atlas);
            finally
              FreeImage(crop);
            end;
          end;

          wbPrepareImageAlpha(atlas, fmtSpecular);
          if not ConvertImage(atlas, fmtSpecular) then
            raise Exception.Create('Image convertion error');

          try
            GenerateMipMaps(atlas, 0, mipmap);
            SaveMultiImageToFile(fname, mipmap);
          finally
            FreeImagesInArray(mipmap);
          end;
        finally
          FreeImage(atlas);
        end;

      end;

      // copy remaining blocks back
      SetLength(Blocks, Length(Blocks2));
      if Length(Blocks) <> 0 then
        for i := Low(Blocks) to High(Blocks) do
          Blocks[i] := Blocks2[i];
      SetLength(Blocks2, 0);
      Inc(num);
    until Length(Blocks) = 0;
  finally
    Free;
  end;
end;

procedure wbBuildAtlasFromTexturesList(
  slTextures: TStrings;
  aMaxTextureSize,
  aMaxTileSize,
  aWidth, aHeight: integer;
  aName, aMapName: string;
  const Settings: TCustomIniFile
);
var
  i, j: integer;
  s: string;
  scl: double;
  res: TDynResources;
  data: TBytes;
  Images: TSourceAtlasTextures;
  slMap: TStringList;
  fmtDiffuse, fmtNormal, fmtSpecular: TImageFormat;
  alphaThreshold: Integer;
  Canvas: TImagingCanvas;
begin
  for i := 0 to Pred(slTextures.Count) do begin
    s := slTextures[i];
    if not wbContainerHandler.ResourceExists(s) then begin
      // default diffuse texture to use, only for fallouts since they can't use loose textures in LOD
      if wbIsFallout3 then begin
        wbProgressCallback('<Note: ' + s + ' diffuse texture not found, using replacement>');
        s := 'textures\shared\shadefade01.dds';
      end;
    end;

    res := wbContainerHandler.OpenResource(s);
    if Length(res) = 0 then
      Continue;

    data := res[High(res)].GetData;
    SetLength(Images, Succ(Length(Images)));

    // load diffuse
    InitImage(Images[Pred(Length(Images))].Image);
    if not wbLoadImageFromMemory(@data[0], Length(data), Images[Pred(Length(Images))].Image) then begin
      SetLength(Images, Pred(Length(Images)));
      Continue;
    end;
    // texture is too large
    if (Images[Pred(Length(Images))].Image.Width > aMaxTextureSize) or (Images[Pred(Length(Images))].Image.Height > aMaxTextureSize) then begin
      SetLength(Images, Pred(Length(Images)));
      Continue;
    end;
    // resize tile if over the limit
    if (Images[Pred(Length(Images))].Image.Width > aMaxTileSize) or (Images[Pred(Length(Images))].Image.Height > aMaxTileSize) then begin
      scl := Min(aMaxTileSize / Images[Pred(Length(Images))].Image.Width, aMaxTileSize / Images[Pred(Length(Images))].Image.Height);
      ResizeImage(
        Images[Pred(Length(Images))].Image,
        Round(Images[Pred(Length(Images))].Image.Width * scl),
        Round(Images[Pred(Length(Images))].Image.Height * scl),
        rfLanczos
      );
    end;
    Images[Pred(Length(Images))].Name := slTextures[i];

    // change brightness if it is a billboard
    if Integer(slTextures.Objects[i]) = iBillboardFlag then begin
      j := Settings.ReadInteger(wbAppName + ' LOD Options', 'TreesBrightness', 0);
      if j <> 0 then begin
        ConvertImage(Images[Pred(Length(Images))].Image, ifA8R8G8B8);
        Canvas := TImagingCanvas.CreateForData(@Images[Pred(Length(Images))].Image);
        try
          Canvas.ModifyContrastBrightness(j / 10, j);
        finally
          Canvas.Free;
        end;
      end;
    end;

    // load normal
    InitImage(Images[Pred(Length(Images))].Image_n);
    s := slTextures[i];
    if Pos('_d.dds', s) <> 0 then begin
      s := StringReplace(s, '_d.dds', '_n.dds', [rfIgnoreCase]);
      // fallback to simple _n addition if not found
      if not wbContainerHandler.ResourceExists(s) then
        s := ChangeFileExt(slTextures[i], '') + '_n.dds';
    end else
      s := ChangeFileExt(slTextures[i], '') + '_n.dds';

    if not wbContainerHandler.ResourceExists(s) then begin
      wbProgressCallback('<Note: ' + s + ' normal map not found, using flat replacement>');
      // default normals texture to use
      s := wbDefaultNormalTexture(wbGameMode);
    end;
    res := wbContainerHandler.OpenResource(s);
    if Length(res) <> 0 then
      data := res[High(res)].GetData;
    if (Length(res) <> 0) and wbLoadImageFromMemory(@data[0], Length(data), Images[Pred(Length(Images))].Image_n) then begin
      // resize normals to match diffuse
      if ((Images[Pred(Length(Images))].Image.Width <> Images[Pred(Length(Images))].Image_n.Width) or (Images[Pred(Length(Images))].Image.Height <> Images[Pred(Length(Images))].Image_n.Height)) then
        ResizeImage(
          Images[Pred(Length(Images))].Image_n,
          Images[Pred(Length(Images))].Image.Width,
          Images[Pred(Length(Images))].Image.Height,
          rfLanczos
        );
    end
    // error loading normal
    else begin
      SetLength(Images, Pred(Length(Images)));
      Continue;
    end;
    Images[Pred(Length(Images))].Name_n := s;

    // load specular
    if wbIsFallout4 then begin
      InitImage(Images[Pred(Length(Images))].Image_s);
      s := slTextures[i];
      if Pos('_d.dds', s) <> 0 then
        s := StringReplace(s, '_d.dds', '_s.dds', [rfIgnoreCase])
      else
        s := ChangeFileExt(slTextures[i], '') + '_s.dds';

      if not wbContainerHandler.ResourceExists(s) then begin
        wbProgressCallback('<Note: ' + s + ' specular map not found, using flat replacement>');
        s := wbDefaultSpecularTexture(wbGameMode);
      end;
      res := wbContainerHandler.OpenResource(s);
      if Length(res) <> 0 then
        data := res[High(res)].GetData;
      if (Length(res) <> 0) and wbLoadImageFromMemory(@data[0], Length(data), Images[Pred(Length(Images))].Image_s) then begin
        if ((Images[Pred(Length(Images))].Image.Width <> Images[Pred(Length(Images))].Image_s.Width) or (Images[Pred(Length(Images))].Image.Height <> Images[Pred(Length(Images))].Image_s.Height)) then
          ResizeImage(
            Images[Pred(Length(Images))].Image_s,
            Images[Pred(Length(Images))].Image.Width,
            Images[Pred(Length(Images))].Image.Height,
            rfLanczos
          );
      end
      else begin
        SetLength(Images, Pred(Length(Images)));
        Continue;
      end;
      Images[Pred(Length(Images))].Name_s := s;
    end;
  end;

  slMap := TStringList.Create;
  try
    if Length(Images) <> 0 then begin
      fmtDiffuse := TImageFormat(Settings.ReadInteger(wbAppName + ' LOD Options', 'AtlasDiffuseFormat', Integer(iDefaultAtlasDiffuseFormat)));
      fmtNormal := TImageFormat(Settings.ReadInteger(wbAppName + ' LOD Options', 'AtlasNormalFormat', Integer(iDefaultAtlasNormalFormat)));
      fmtSpecular := TImageFormat(Settings.ReadInteger(wbAppName + ' LOD Options', 'AtlasSpecularFormat', Integer(iDefaultAtlasSpecularFormat)));
      alphaThreshold := Settings.ReadInteger(wbAppName + ' LOD Options', 'DefaultAlphaThreshold', iDefaultAlphaThreshold);
      wbBuildAtlas(Images, aWidth, aHeight, aName, fmtDiffuse, fmtNormal, fmtSpecular, alphaThreshold);
      for i := Low(Images) to High(Images) do
        if Images[i].AtlasName <> '' then begin
          // atlas name in map file must be relative to data folder
          Delete(Images[i].AtlasName, 1, Pred(Pos('textures\', LowerCase(Images[i].AtlasName))));
          slMap.Add(
            Images[i].Name + #9 +
            IntToStr(Images[i].Image.Width)  + #9 +
            IntToStr(Images[i].Image.Height)  + #9 +
            IntToStr(Images[i].X) + #9 +
            IntToStr(Images[i].Y) + #9 +
            Images[i].AtlasName + #9 +
            IntToStr(Images[i].W) + #9 +
            IntToStr(Images[i].H)
          );
        end;
      if slMap.Count <> 0 then
        slMap.SaveToFile(aMapName);
    end;
  finally
    slMap.Free;
    if Length(Images) <> 0 then
      for i := Low(Images) to High(Images) do begin
        FreeImage(Images[i].Image);
        FreeImage(Images[i].Image_n);
        if wbIsFallout4 then
          FreeImage(Images[i].Image_s);
      end;
  end;
end;

procedure wbBuildAtlasFromAtlasMap(slMap: TStrings; aBrightness: integer;
  GammaR, GammaG, GammaB: Single; const Settings: TCustomIniFile);
var
  l, i: integer;
  sl, slAtlas: TStringList;
  res: TDynResources;
  data: TBytes;
  img, img_n: TImageData;
  Atlases, Atlases_n: array of TImageData;
  mipmap: TDynImageDataArray;
  fname: string;
  imgcanv: TImagingCanvas;
  fmtDiffuse, fmtNormal: TImageFormat;
begin
  if not Assigned(slMap) then
    Exit;

  slAtlas := TStringList.Create;
  sl := TStringList.Create;
  sl.Delimiter := #9;
  sl.StrictDelimiter := True;
  InitImage(img);
  InitImage(img_n);
  try
    for l := 0 to Pred(slMap.Count) do begin
      sl.DelimitedText := slMap[l];
      if sl.Count <> 8 then Continue;

      // load diffuse tile
      res := wbContainerHandler.OpenResource(sl[0]);
      if Length(res) = 0 then
        raise Exception.Create('Source tile not found ' + sl[0]);

      data := res[High(res)].GetData;
      if not wbLoadImageFromMemory(@data[0], Length(data), img) then
        raise Exception.Create('Error loading tile ' + sl[0]);

      // load normal tile
      fname := ChangeFileExt(sl[0], '') + '_n.dds';
      res := wbContainerHandler.OpenResource(fname);
      if Length(res) = 0 then begin
        wbProgressCallback('<Note: ' + fname + ' normal map not found, using flat replacement>');
        // default normals texture to use
        fname := wbDefaultNormalTexture(wbGameMode);
        res := wbContainerHandler.OpenResource(fname);
        if Length(res) = 0 then
          raise Exception.Create('Source tile normal map not found for ' + sl[0]);
      end;

      data := res[High(res)].GetData;
      if not wbLoadImageFromMemory(@data[0], Length(data), img_n) then
        raise Exception.Create('Error loading tile normal map for ' + sl[0]);

      // resize diffuse as set in atlas map
      if (img.Width <> StrToInt(sl[1])) or (img.Height <> StrToInt(sl[2])) then
        ResizeImage(img, StrToInt(sl[1]), StrToInt(sl[2]), rfLanczos);

      // resize normal to diffuse if doesn't match
      if (img.Width <> img_n.Width) or (img.Height <> img_n.Height) then
        ResizeImage(img_n, img.Width, img.Height, rfLanczos);

      i := slAtlas.IndexOf(sl[5]);
      if i = -1 then begin
        slAtlas.Add(sl[5]);
        i := Pred(slAtlas.Count);
        SetLength(Atlases, slAtlas.Count);
        NewImage(StrToInt(sl[6]), StrToInt(sl[7]), ifDefault, Atlases[i]);
        SetLength(Atlases_n, slAtlas.Count);
        NewImage(StrToInt(sl[6]), StrToInt(sl[7]), ifDefault, Atlases_n[i]);
      end;

      CopyRect(img, 0, 0, img.Width, img.Height, Atlases[i], StrToInt(sl[3]), StrToInt(sl[4]));
      CopyRect(img_n, 0, 0, img_n.Width, img_n.Height, Atlases_n[i], StrToInt(sl[3]), StrToInt(sl[4]));
    end;

    SetOption(ImagingMipMapFilter, Ord(sfLanczos));
    fmtDiffuse := TImageFormat(Settings.ReadInteger(wbAppName + ' LOD Options', 'AtlasDiffuseFormat', Integer(iDefaultAtlasDiffuseFormat)));
    fmtNormal := TImageFormat(Settings.ReadInteger(wbAppName + ' LOD Options', 'AtlasNormalFormat', Integer(iDefaultAtlasNormalFormat)));

    for i := 0 to Pred(slAtlas.Count) do begin
      // change brightness or gamma
      imgcanv := TImagingCanvas.CreateForData(@Atlases[i]);
      try
        if aBrightness <> 0 then
          imgcanv.ModifyContrastBrightness(aBrightness / 10, aBrightness);
        if (not SameValue(GammaR, 1.0)) or (not SameValue(GammaG, 1.0)) or (not SameValue(GammaB, 1.0)) then
          imgcanv.GammaCorection(GammaR, GammaG, GammaB);
      finally
        imgcanv.Free;
      end;

      wbPrepareImageAlpha(Atlases[i], fmtDiffuse);
      if not ConvertImage(Atlases[i], fmtDiffuse) then
        raise Exception.Create('Image convertion error');

      fname := slAtlas[i];
      if SameText(Copy(fname, 1, 9), 'textures\') then
        fname := wbOutputPath + fname;

      if not DirectoryExists(ExtractFilePath(fname)) then
        if not ForceDirectories(ExtractFilePath(fname)) then
          raise Exception.Create('Error creating atlas folder');

      try
        GenerateMipMaps(Atlases[i], 0, mipmap);
        SaveMultiImageToFile(fname, mipmap);
      finally
        FreeImagesInArray(mipmap);
      end;

      wbPrepareImageAlpha(Atlases_n[i], fmtNormal);
      if not ConvertImage(Atlases_n[i], fmtNormal) then
        raise Exception.Create('Image convertion error');

      try
        GenerateMipMaps(Atlases_n[i], 0, mipmap);
        SaveMultiImageToFile(ChangeFileExt(fname, '') + '_n.dds', mipmap);
      finally
        FreeImagesInArray(mipmap);
      end;
    end;
  finally
    slAtlas.Free;
    sl.Free;
    FreeImage(img);
    FreeImage(img_n);
    if Length(Atlases) <> 0 then
      for i := Low(Atlases) to High(Atlases) do
        FreeImage(Atlases[i]);
    if Length(Atlases_n) <> 0 then
      for i := Low(Atlases_n) to High(Atlases_n) do
        FreeImage(Atlases_n[i]);
  end;
end;

procedure wbSplitTreeLOD(const aWorldspace: IwbMainRecord; const Files: TDynFiles);
var
  Lst             : TwbLodTES5TreeList;
  LodSet          : TwbLodSettings;
  Res             : TDynResources;
  BTT             : TwbLodTES5TreeBlock;
  i, j, n, r, k   : Integer;
  LstIndex        : Integer;
  LodLevel        : Integer;
  bFound          : Boolean;
  slCont, slList  : TwbFastStringList;
  TreeRecords     : array of array of IwbMainRecord;
  loFiles         : array [0..254] of IwbFile;
  Ref             : IwbMainRecord;
  SplitPath       : string;
  TreeFileName    : string;
  ini             : TMemIniFile;
  Cell            : TwbGridCell;
begin
  // split Skyrim's Trees LOD atlas into separate billboard textures
  Res := wbContainerHandler.OpenResource(wbLODSettingsFileName(aWorldspace.EditorID));
  if Length(Res) > 0 then
    LodSet.LoadFromData(Res[High(Res)].GetData)
  else begin
    wbProgressCallback('[' + aWorldspace.EditorID + '] Lodsettings file not found for worldspace.');
    Exit;
  end;
  Lst := TwbLodTES5TreeList.Create(aWorldspace.EditorID);
  try
    Res := wbContainerHandler.OpenResource(Lst.ListFileName);
    if Length(Res) > 0 then
      Lst.LoadFromData(Res[High(Res)].GetData)
    else begin
      wbProgressCallback('[' + Lst.ListFileName + '] Worldspace doesn''t have a Trees LOD list file.');
      Exit;
    end;

    Res := wbContainerHandler.OpenResource(Lst.AtlasFileName);
    if Length(Res) > 0 then
      Lst.LoadAtlas(Res[High(Res)].GetData)
    else begin
      wbProgressCallback('[' + Lst.AtlasFileName + '] Trees LOD atlas texture not found.');
      Exit;
    end;

    Application.MainForm.Caption := 'Scanning LOD Blocks: ' + aWorldspace.Name + ',  please wait...';
    Application.ProcessMessages;

    // scan BTT files to associate lod trees indexes with TREE FormIDs
    slCont := TwbFastStringList.Create;
    slList := TwbFastStringList.Create;
    try
      wbContainerHandler.ContainerList(slCont);
      for i := Pred(slCont.Count) downto 0 do
        wbContainerHandler.ContainerResourceList(slCont[i], slList, ExtractFilePath(Lst.ListFileName));
      slList.Duplicates := dupIgnore;
      slList.Sorted := True;

      // array of found TREE records indexed by LST index
      SetLength(TreeRecords, Lst.TreesListCount);

      // list of loaded plugins by load order
      for i := High(Files) downto Low(Files) do
        loFiles[Files[i].LoadOrder] := Files[i];

      if wbIsFallout3 then LodLevel := 8 else LodLevel := 4;
      BTT.Init(Lst, Cell, LodLevel);
      // for each btt file
      for i := 0 to Pred(slList.Count) do begin
        if not SameText(ExtractFileExt(slList[i]), '.' + wbLODTreeBlockFileExt) then
          Continue;
        Res := wbContainerHandler.OpenResource(slList[i]);
        if Length(Res) = 0 then Continue;
        BTT.LoadFromData(Res[High(Res)].GetData);
        // for each tree type in btt file
        if Length(BTT.Types) > 0 then
        for j := Low(BTT.Types) to High(BTT.Types) do
          // for each reference of tree type
          for r := 0 to BTT.Types[j].Count - 1 do begin
            // a mod the reference is supposed to be from
            k := BTT.Refs[j][r].RefFormID.FileID.FullSlot;
            if not Assigned(loFiles[k]) then
              Continue;
            Ref := loFiles[k].RecordByFormID[loFiles[k].LoadOrderFormIDtoFileFormID(BTT.Refs[j][r].RefFormID), False];
            // found a matching reference of TREE
            if Assigned(Ref) and Assigned(Ref.BaseRecord) and ((Ref.BaseRecord.Signature = 'TREE') or (Ref.BaseRecord.Signature = 'STAT')) then begin
              LstIndex := BTT.Types[j].Index;
              // check if we already associated that TREE record with LST index
              bFound := False;
              for n := 0 to Pred(Length(TreeRecords[LstIndex])) do
                if TreeRecords[LstIndex][n].LoadOrderFormID = Ref.BaseRecord.LoadOrderFormID then begin
                  bFound := True;
                  Break;
                end;
              if not bFound then begin
                SetLength(TreeRecords[LstIndex], Succ(Length(TreeRecords[LstIndex])));
                TreeRecords[LstIndex][Pred(Length(TreeRecords[LstIndex]))] := Ref.BaseRecord.MasterOrSelf;
              end;
            end;
          end;
      end;
    finally
      slCont.Free;
      slList.Free;
    end;

    SplitPath := wbOutputPath + 'Textures\Terrain\LODGen\AtlasSplit_' + ChangeFileExt(ExtractFileName(Lst.AtlasFileName), '') + '\';

    for i := 0 to Pred(Lst.TreesListCount) do with Lst.TreesList[i] do begin
      for n := Low(TreeRecords[Index]) to High(TreeRecords[Index]) do begin
        if Length(TreeRecords[Index]) > 0 then
          TreeFileName := Format('%s\%s_%s.dds', [
            TreeRecords[Index][n]._File.FileName,
            ChangeFileExt(ExtractFileName(TreeRecords[Index][n].WinningOverride.ElementEditValues['Model\MODL']), ''),
            TreeRecords[Index][n].FormID.ChangeFileID(TwbFileID.Null).ToString(False)
          ])
        else
          TreeFileName := Format('Tree Type %d.dds', [Index]);
        TreeFileName := SplitPath + TreeFileName;

        wbProgressCallback('[' + TreeFileName + '] Saving billboard texture');

        ForceDirectories(ExtractFilePath(TreeFileName));
        Lst.SaveFromAtlas(Index, TreeFileName);
        ini := TMemIniFile.Create(ChangeFileExt(TreeFileName, '.txt'));
        try
          ini.WriteString('LOD', 'Width', FloatToStrF(Width, ffFixed, 99, wbFloatDigits));
          ini.WriteString('LOD', 'Height', FloatToStrF(Height, ffFixed, 99, wbFloatDigits));
          if Length(TreeRecords[Index]) > 0 then
            ini.WriteString('LOD', 'Model', TreeRecords[Index][n].WinningOverride.ElementEditValues['Model\MODL']);
          ini.UpdateFile;
        finally
          ini.Free;
        end;
      end;
    end;
     wbProgressCallback('[Split atlas] Done.');
  finally
    Lst.Free;
    Application.MainForm.Caption := Application.Title;
  end;
end;

procedure wbFindREFRs(
  const aWorldspace: IwbMainRecord;
  const aElement: IwbElement;
  var REFRs: TDynMainRecords;
  var TotalCount, Count: Integer;
  var StartTick: Cardinal
);
var
  MainRecord : IwbMainRecord;
  Container  : IwbContainerElementRef;
  i          : Integer;
begin
  if StartTick + 500 < GetTickCount then begin
    Application.MainForm.Caption := 'Scanning References: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(TotalCount) +
      ' References Found: ' + IntToStr(Count) +
      ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
    Application.ProcessMessages;
    StartTick := GetTickCount;
  end;

  if Supports(aElement, IwbMainRecord, MainRecord) then begin
    if MainRecord.Signature = 'REFR' then begin
      if High(REFRs) < Count then
        SetLength(REFRs, Length(REFRs) * 2);
      REFRs[Count] := MainRecord;
      Inc(Count);
    end;
  end else if Supports(aElement, IwbContainerElementRef, Container) then
    for i := 0 to Pred(Container.ElementCount) do
      wbFindREFRs(aWorldspace, Container.Elements[i], REFRs, TotalCount, Count, StartTick);
end;

procedure wbFindUniqueWorldspaceREFRs(
  const aWorldspace: IwbMainRecord;
  var REFRs: TDynMainRecords
);
var
  StartTick: Cardinal;
  Master     : IwbMainRecord;
  Count      : Integer;
  TotalCount : Integer;
  i, j       : Integer;
begin
  Application.MainForm.Caption := 'Scanning References: ' + aWorldspace.Name + ' Processed Records: 0 '+
    'References Found: 0 Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
  Application.ProcessMessages;
  StartTick := GetTickCount;

  Master := aWorldspace.MasterOrSelf;
  Count := 0;
  TotalCount := 0;
  REFRs := nil;
  SetLength(REFRs, 1024);

  wbFindREFRs(aWorldspace, Master.ChildGroup, REFRs, TotalCount, Count, StartTick);
  for i := 0 to Pred(Master.OverrideCount) do
    wbFindREFRs(aWorldspace, Master.Overrides[i].ChildGroup, REFRs, TotalCount, Count, StartTick);
  SetLength(REFRs, Count);

  {only keep the newest version of each}
  if Length(REFRs) > 1 then begin
    Application.MainForm.Caption := 'Sorting References: ' + aWorldspace.Name +
      ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
    Application.ProcessMessages;

    wbMergeSortPtr(@REFRs[0], Length(REFRs), CompareElementsFormIDAndLoadOrder);

    Application.MainForm.Caption := 'Removing duplicates: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(0) +
      ' Unique References Found: ' + IntToStr(0) +
      ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
    Application.ProcessMessages;
    StartTick := GetTickCount;

    j := 0;
    for i := Succ(Low(REFRs)) to High(REFRs) do begin
      if REFRs[j].LoadOrderFormID <> REFRs[i].LoadOrderFormID then
        Inc(j);
      if j <> i then
        REFRs[j] := REFRs[i];

      if wbForceTerminate then
        Abort;
      if StartTick + 500 < GetTickCount then begin
        Application.MainForm.Caption := 'Removing duplicates: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(i) +
          ' Unique References Found: ' + IntToStr(j) +
          ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
        Application.ProcessMessages;
        StartTick := GetTickCount;
      end;
    end;
    SetLength(REFRs, Succ(j));
  end;
end;

function wbGetLODMeshName(const aStat: IwbMainRecord; const aLODLevel: Integer; aTrees3D: Boolean = False): string;
begin
  Result := '';
  // full mesh
  if aLODLevel = -1 then
    Result := aStat.ElementEditValues['Model\MODL']
  else if wbIsSkyrim or wbIsFallout4 then begin
    // use MNAM data of STAT record for lod meshes if exists
    if aStat.ElementExists['MNAM'] then
      Result := aStat.ElementEditValues[Format('MNAM\LOD #%d (Level %d)\Mesh', [aLODLevel, aLODLevel])]

    // otherwise meshes with the same path and name as full one with _lod_0, _lod_1 and _lod_2 suffixes
    // can be used to generate objects LOD for TREE records which don't have MNAM
    else if aTrees3D and (aStat.Signature = 'TREE') then
      Result := ChangeFileExt(aStat.ElementEditValues['Model\MODL'], '') + '_lod_' + IntToStr(aLODLevel) + '.nif';
  end
  else if wbIsFallout3 and (aLODLevel = 0) then
    // fallouts always use _lod mesh only
    Result := ChangeFileExt(aStat.ElementEditValues['Model\MODL'], '') + '_lod.nif';

  Result := wbNormalizeResourceName(Result, resMesh);
  if (aLODLevel <> -1) and not wbContainerHandler.ResourceExists(Result) then
    Result := '';
end;


type
  TCoords = TwbVector;

  PRefInfo = ^TRefInfo;
  TRefInfo = record
    FormID : TwbFormID;
    Pos    : TCoords;
    Rot    : TCoords;
    Scale  : Single;
    Next   : PRefInfo;
  end;

function CompareRefInfos(Item1, Item2: Pointer): Integer;
begin
  if Item1 = Item2 then begin
    Result := 0;
    Exit;
  end;

  Result := TwbFormID.Compare(PRefInfo(Item1).FormID, PRefInfo(Item2).FormID);

  if wbForceTerminate then
    Abort;
end;

procedure wbGenerateLODTES4(const aWorldspace: IwbMainRecord; const Settings: TCustomIniFile);
type
  TRule = (rSkip, rClear, rReplace);
var
  StartTick: Cardinal;
  LODPath    : string;
  Master     : IwbMainRecord;
  REFRs      : TDynMainRecords;
  Count      : Integer;
  TotalCount : Integer;
  i, j, k, l : Integer;
  NameRec    : IwbContainerElementRef;
  DataRec    : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  RefInfos   : array of TRefInfo;
  MinX, MaxX : Single;
  MinY, MaxY : Single;
  MinCell    : TwbGridCell;
  MaxCell    : TwbGridCell;
  Cells      : array of array of PRefInfo;
  RefInfo    : PRefInfo;
  RefsInCell : array of PRefInfo;
  CmpStream  : TwbWriteCachedFileStream;
  LODScale   : Single;
  LODAdd     : Single;
  F          : TSearchRec;
  s          : string;
  Rule       : TRule;
  lx,ly      : Integer;
begin
  LODScale := 100;
  LODAdd := 0.970001220703;

  Master := aWorldspace.MasterOrSelf;

  s := Settings.ReadString('Worldspace', Master.EditorID, '');
  if s = '' then
    s := Settings.ReadString('Default', 'Rule', 'Replace');

  Rule := rSkip;
  if SameText(s, 'Replace') then begin
    Rule := rReplace;
    s := 'Replacing';
  end else if SameText(s, 'Clear') then begin
    Rule := rClear;
    s := 'Clearing';
  end else if not SameText(s, 'Skip') then begin
    wbProgressCallback('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] <Warning: Unknown Rule "'+s+'"> Worldspace is being skipped.');
    s := 'Skipping';
  end else
    s := 'Skipping';

  wbProgressCallback('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] LOD Generator: '+s+' ' + Master.Name);

  if Rule = rSkip then
    Exit;

  if Rule > rClear then begin
    wbFindUniqueWorldspaceREFRs(aWorldspace, REFRs);

    MinX := MaxSingle;
    MaxX := -MaxSingle;
    MinY := MaxSingle;
    MaxY := -MaxSingle;

    Application.MainForm.Caption := 'Filtering VWD References: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(0) +
      ' Matching Records: ' + IntToStr(0) +
      ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
    Application.ProcessMessages;
    StartTick := GetTickCount;

    SetLength(RefInfos, Length(REFRs));
    if Length(REFRs) > 0 then begin
      j := -1;
      for i := Low(REFRs) to High(REFRs) do begin

        if Supports(REFRs[i].RecordBySignature['NAME'], IwbContainerElementRef, NameRec) and
           Supports(NameRec.LinksTo, IwbMainRecord, MainRecord) and
           MainRecord.WinningOverride.HasVisibleWhenDistantMesh and
           Supports(REFRs[i].RecordBySignature['DATA'], IwbContainerElementRef, DataRec) and
           (DataRec.ElementCount = 2) and
           (not REFRs[i].FormID.IsNull) and // Some Oblivion worldspace mods have refs with zero FormID
           not REFRs[i].Flags.IsInitiallyDisabled and
           not REFRs[i].Flags.IsDeleted then begin
          try
            with RefInfos[Succ(j)] do begin
              FormID := MainRecord.LoadOrderFormID;

              with Pos, (DataRec.Elements[0] as IwbContainerElementRef) do begin
                if ElementCount >= 1 then
                  X := Round(Elements[0].NativeValue)+0.5;
                if ElementCount >= 2 then
                  Y := Round(Elements[1].NativeValue)+0.5;
                if ElementCount >= 3 then
                  Z := Round(Elements[2].NativeValue)+0.970703125;

                if (x < -10000000.0) or (x > 10000000.0) or
                   (y < -10000000.0) or (y > 10000000.0) then
                  raise Exception.Create('Position out of bounds');

                if X < MinX then
                  MinX := x;
                if X > MaxX then
                  MaxX := x;
                if Y < MinY then
                  MinY := Y;
                if Y > MaxY then
                  MaxY := Y;
              end;
              with Rot, (DataRec.Elements[1] as IwbContainerElementRef) do begin
                if ElementCount >= 1 then
                  X := Elements[0].NativeValue / wbRotationFactor;
                if ElementCount >= 2 then
                  Y := Elements[1].NativeValue / wbRotationFactor;
                if ElementCount >= 3 then
                  Z := Elements[2].NativeValue / wbRotationFactor;
              end;
              if Supports(REFRs[i].RecordBySignature['XSCL'], IwbContainerElementRef, DataRec) then
                Scale := DataRec.NativeValue
              else
                Scale := 1;
              Scale := RoundTo(Scale, -2);
              Scale := (Scale * LODScale);
              Scale := Scale + LODAdd;
            end;
            Inc(j);
          except
            on E: Exception do
              wbProgressCallback('[' + FormatDateTime('nn:ss', Now - wbStartTime) + '] LOD Generator: <Error while processing ' + REFRs[i].Name+': '+E.Message + '>');
          end;
        end;

        if wbForceTerminate then
          Abort;
        if StartTick + 500 < GetTickCount then begin
          Application.MainForm.Caption := 'Filtering VWD References: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(i) +
            ' Matching Records: ' + IntToStr(Succ(j)) +
            ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
          Application.ProcessMessages;
          StartTick := GetTickCount;
        end;

      end;
      SetLength(RefInfos, Succ(j));
    end;

    if Length(RefInfos) < 1 then
      Exit;

    MinCell.x := Trunc(MinX / 4096);
    if MinX < 0 then
      Dec(MinCell.x);
    MinCell.y := Trunc(MinY / 4096);
    if MinY < 0 then
      Dec(MinCell.y);
    MaxCell.x := Trunc(MaxX / 4096);
    if MaxX < 0 then
      Dec(MaxCell.x);
    MaxCell.y := Trunc(MaxY / 4096);
    if MaxY < 0 then
      Dec(MaxCell.y);

    SetLength(Cells, Succ(-(MinCell.x-MaxCell.x)), Succ(-(MinCell.y-MaxCell.y)));

    if wbForceTerminate then
      Abort;
  end;

  LODPath := wbOutputPath + 'DistantLOD\';

  ForceDirectories(LODPath);

  i := 0;
  Application.MainForm.Caption := 'Deleting old .lod files: ' + aWorldspace.Name + ' Processed Files: ' + IntToStr(i) +
    ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
  Application.ProcessMessages;
  StartTick := GetTickCount;

  if wbForceTerminate then
    Abort;

  if FindFirst(LODPath + aWorldspace.EditorID + '*.lod', faAnyFile, F) = 0 then try
    repeat
      DeleteFile(LODPath + F.Name);
      Inc(i);

      if StartTick + 500 < GetTickCount then begin
        Application.MainForm.Caption := 'Deleting old .lod files: ' + aWorldspace.Name + ' Processed Files: ' + IntToStr(i) +
          ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
        Application.ProcessMessages;
        StartTick := GetTickCount;
      end;

      if wbForceTerminate then
        Abort;

    until FindNext(F) <> 0;
  finally
    FindClose(F);
  end;

  if Rule > rClear then begin
    CmpStream := TwbWriteCachedFileStream.Create(LODPath + aWorldspace.EditorID + '.cmp', fmCreate);
    try
      Application.MainForm.Caption := 'Assigning References to Cells: ' + aWorldspace.Name + ' Processed References: ' + IntToStr(0) +
        ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
      Application.ProcessMessages;
      StartTick := GetTickCount;

      for i := Low(RefInfos) to High(RefInfos) do
        with RefInfos[i], wbPositionToGridCell(Pos) do begin
          lX := x - MinCell.x;
          ly := y - MinCell.y;
          Next := Cells[lx,ly];
          Cells[lx,ly] := @RefInfos[i];

          if wbForceTerminate then
            Abort;
          if StartTick + 500 < GetTickCount then begin
            Application.MainForm.Caption := 'Assigning References to Cells: ' + aWorldspace.Name + ' Processed References: ' + IntToStr(i) +
              ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
            Application.ProcessMessages;
            StartTick := GetTickCount;
          end;
        end;

      Application.MainForm.Caption := 'Writing .lod files: ' + aWorldspace.Name + ' Processed Cells: ' + IntToStr(0) +
        ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
      Application.ProcessMessages;
      StartTick := GetTickCount;

      for i := Low(Cells) to High(Cells) do
        for j := Low(Cells[i]) to High(Cells[i]) do begin
          RefInfo := Cells[i,j];
          Count := 0;
          while Assigned(RefInfo) do begin
            Inc(Count);
            RefInfo := RefInfo.Next;
          end;
          if Count > 0 then begin
            SetLength(RefsInCell, Count);

            RefInfo := Cells[i,j];
            Count := 0;
            while Assigned(RefInfo) do begin
              RefsInCell[Count] := RefInfo;
              RefInfo := RefInfo.Next;
              RefsInCell[Count].Next := nil;
              Inc(Count);
            end;

            wbMergeSortPtr(@RefsInCell[0], Length(RefsInCell), CompareRefInfos);

            l := 0;
            for k := Succ(Low(RefsInCell)) to High(RefsInCell) do begin
              if RefsInCell[l].FormID = RefsInCell[k].FormID then begin
                RefsInCell[k].Next := RefsInCell[l];
              end else
                Inc(l);
              if l <> k then
                RefsInCell[l] := RefsInCell[k];
            end;
            SetLength(RefsInCell, Succ(l));

            with TwbWriteCachedFileStream.Create(LODPath + aWorldspace.EditorID + '_' + IntToStr(i+MinCell.x) + '_' + IntToStr(j+MinCell.y) + '.lod', fmCreate) do try
              WriteCardinal(Length(RefsInCell));

              for l := Low(RefsInCell) to High(RefsInCell) do begin
                RefInfo := RefsInCell[l];
                WriteCardinal(RefInfo.FormID.ToCardinal);

                Count := 0;
                while Assigned(RefInfo) do begin
                  Inc(Count);
                  RefInfo := RefInfo.Next;
                end;
                WriteCardinal(Count);

                RefInfo := RefsInCell[l];
                while Assigned(RefInfo) do begin
                  WriteBuffer(RefInfo.Pos, SizeOf(RefInfo.Pos));
                  RefInfo := RefInfo.Next;
                end;

                RefInfo := RefsInCell[l];
                while Assigned(RefInfo) do begin
                  WriteBuffer(RefInfo.Rot, SizeOf(RefInfo.Rot));
                  RefInfo := RefInfo.Next;
                end;

                RefInfo := RefsInCell[l];
                while Assigned(RefInfo) do begin
                  WriteBuffer(RefInfo.Scale, SizeOf(RefInfo.Scale));
                  RefInfo := RefInfo.Next;
                end;

              end;
            finally
              Free;
            end;
            CmpStream.WriteSmallInt(j+MinCell.y);
            CmpStream.WriteSmallInt(i+MinCell.x);
          end;

          if StartTick + 500 < GetTickCount then begin
            Application.MainForm.Caption := 'Writing .lod files: ' + aWorldspace.Name + ' Processed Cells: ' + IntToStr(i * Length(Cells[i]) + j) +
              ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
            Application.ProcessMessages;
            StartTick := GetTickCount;
          end;
        end;
      CmpStream.WriteCardinal(7);
    finally
      CmpStream.Free;
    end;
  end;
end;

procedure wbGenerateLODTES5(
  const aWorldspace: IwbMainRecord;
  const LODTypes: TLODTypes;
  const Files: TDynFiles;
  const Settings: TCustomIniFile
);
var
  StartTick: Cardinal;

  function LoadBillboard(Lst: TwbLodTES5TreeList; const TreeRec: IwbMainRecord): PwbLodTES5Tree;
  var
    Ovr: IwbMainRecord;
    Res: TDynResources;
    ini: TMemIniFile;
    slIni: TStringList;
    bsIni: TBytesStream;
    Width, Height: Single;
  begin
    // calculate default width and height of a tree from object bounds
    Ovr := TreeRec.WinningOverride;
    if Ovr.ElementExists['OBND'] then begin
       Width  := Ovr.ElementNativeValues['OBND\X2'] - Ovr.ElementNativeValues['OBND\X1'];
       Height := Ovr.ElementNativeValues['OBND\Z2'] - Ovr.ElementNativeValues['OBND\Z1'];
    end
    else begin
      Width  := 0;
      Height := 0;
    end;
    Result := Lst.AddTree(TreeRec._File.FileName, Ovr.ElementEditValues['Model\MODL'], TreeRec.LoadOrderFormID, Width, Height);
    // load billboard texture
    Res := wbContainerHandler.OpenResource(Result^.Billboard);
    if (Length(Res) > 0) and Result^.LoadFromData(Res[High(Res)].GetData) then begin
      //slLog.Add(TreeRec.Name + ' using LOD ' + Result^.Billboard);
      // store checksum of billboard to avoid duplicates in atlas
      Result^.CRC32 := wbCRC32Data(Res[High(Res)].GetData);
      // load tree data
      Res := wbContainerHandler.OpenResource(ChangeFileExt(Result^.Billboard, '.txt'));
      if Length(Res) > 0 then begin
        bsIni := TBytesStream.Create(Res[High(Res)].GetData);
        slIni := TStringList.Create;
        ini := TMemIniFile.Create('');
        try
          slIni.LoadFromStream(bsIni);
          ini.SetStrings(slIni);
          // don't read Width and Height from ini if they are 0
          if not SameValue(ini.ReadFloat('LOD', 'Width', 0.0), 0.0) then
            Result^.Width := ini.ReadFloat('LOD', 'Width', Result^.Width);
          if not SameValue(ini.ReadFloat('LOD', 'Height', 0.0), 0.0) then
            Result^.Height := ini.ReadFloat('LOD', 'Height', Result^.Height);
          Result^.ShiftX := ini.ReadFloat('LOD', 'ShiftX', 0.0);
          Result^.ShiftY := ini.ReadFloat('LOD', 'ShiftY', 0.0);
          Result^.ShiftZ := ini.ReadFloat('LOD', 'ShiftZ', 0.0);
          Result^.ScaleFactor := ini.ReadFloat('LOD', 'Scale', 1.0);
        finally
          bsIni.Free;
          slIni.Free;
          ini.Free;
        end;
      end;
    end else
      Result^.Index := -1;
  end;

  procedure GetLargeReferencesPlugin(const aElement: IwbElement; sl: TStringList; ChunkSW, ChunkNE: TwbGridCell);
  var
    i, j: integer;
    Grids, GridEntry, References, ReferenceEntry: IwbContainerElementRef;
    Reference: IwbMainRecord;
    Pos: TwbVector;
    Grid, Cell: TwbGridCell;
  begin
    if not Assigned(aElement) then
      Exit;
    // RNAM data working in ESM only for now
    if not aElement._File.IsESM then
      Exit;
    if Supports(aElement, IwbContainerElementRef, Grids) then
      for i := 0 to Pred(Grids.ElementCount) do
        if Supports(Grids.Elements[i], IwbContainerElementRef, GridEntry) then begin
          Grid.x := GridEntry.ElementByPath['X'].NativeValue;
          Grid.y := GridEntry.ElementByPath['Y'].NativeValue;
          // skip references not in specific chunk
          if ChunkSW.x <> Low(Integer) then
            if (Grid.x < ChunkSW.x) or (Grid.x > ChunkNE.x) then
              Continue;
          if ChunkSW.y <> Low(Integer) then
            if (Grid.y < ChunkSW.y) or (Grid.y > ChunkNE.y) then
              Continue;
          if Supports(GridEntry.ElementByPath['References'], IwbContainerElementRef, References) then
            for j := 0 to Pred(References.ElementCount) do
              if Supports(References.Elements[j], IwbContainerElementRef, ReferenceEntry) then
                if Supports(ReferenceEntry.ElementByPath['Ref'].LinksTo, IwbMainRecord, Reference) then begin
                  Reference.GetPosition(Pos);
                  Cell := wbPositionToGridCell(Pos);
                  // the origin of reference needs to be in the grids cell
                  // references listed in other grids has no effect
                  // ToDo test Overrides moving reference out of cell
                  if (Grid.x = Cell.x) and (Grid.y = Cell.y) then
                    sl.AddObject(Reference.MasterOrSelf.LoadOrderFormID.ToString(False), Pointer(Reference.MasterOrSelf));
                end;
          if StartTick + 500 < GetTickCount then begin
            Application.MainForm.Caption := 'Gathering Large References: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(i) +
              ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
            Application.ProcessMessages;
            StartTick := GetTickCount;
          end;
        end;
  end;

  procedure GetLargeReferences(Wrld: IwbMainRecord; sl: TStringList; ChunkSW, ChunkNE: TwbGridCell);
  var
    i: integer;
  begin
    Wrld := Wrld.MasterOrSelf;
    // RNAM data merges accross all plugins
    GetLargeReferencesPlugin(Wrld.ElementByPath['RNAM'], sl, ChunkSW, ChunkNE);
    for i := 0 to Pred(Wrld.OverrideCount) do begin
      GetLargeReferencesPlugin(Wrld.Overrides[i].ElementByPath['RNAM'], sl, ChunkSW, ChunkNE);
    end;
  end;

var
  LODPath, AtlasName, AtlasMapName{, TexturesListFile}: string;
  Section             : string;
  s, mat, m4, m8, m16, scl: string;
  F                   : TSearchRec;
  Master, Ovr         : IwbMainRecord;
  TreeRec, StatRec    : IwbMainRecord;
  Group               : IwbGroupRecord;
  Sigs                : TwbSignatures;
  REFRs               : TDynMainRecords;
  XESPRef             : IwbElement;
  XESPLink            : IwbMainRecord;
  RefFormID           : TwbFormID;
  ErrCode             : Cardinal;
  Count, TreesCount   : Integer;
  TreesDupCount       : Integer;
  TotalCount          : Integer;
  LodLevel, ChunkSize : Integer;
  i, j, k, l          : Integer;
  Lst                 : TwbLodTES5TreeList;
  LodSet              : TwbLodSettings;
  Res                 : TDynResources;
  PTree               : PwbLodTES5Tree;
  slLog, slCache, slCacheHPLod, slRefs, slExport, sl, slLargeReferences: TStringList;
  slLODMeshes, slLODTextures: TStringList;
  RefPos, RefRot      : TwbVector;
  RefCell, RefBlock, ChunkSW, ChunkNE: TwbGridCell;
  Scale, UVRange, LargeRefMinSize: Single;
  LOD4                : array of TwbLodTES5TreeBlock;
  bChunk, bArea, bBuildAtlas, bTrees3D : Boolean;
  Bytes               : TBytes;
begin
  Master := aWorldspace.MasterOrSelf;

  // need an existing lodsettings file to align lod blocks
  Res := wbContainerHandler.OpenResource(wbLODSettingsFileName(aWorldspace.EditorID));
  if Length(Res) > 0 then
    LodSet.LoadFromData(Res[High(Res)].GetData)
  else begin
    wbProgressCallback('[' + aWorldspace.EditorID + '] Lodsettings file not found for worldspace.');
    Exit;
  end;

  // settings file LOD options section
  Section := wbAppName + ' LOD Options';
  bTrees3D := Settings.ReadBool(Section, 'Trees3D', True);

  wbFindUniqueWorldspaceREFRs(aWorldspace, REFRs);
  if Length(REFRs) = 0 then
    Exit;

  wbProgressCallback('[' + aWorldspace.EditorID + '] Generating LOD');

  // Trees LOD, only if not generated as 3D objects LOD
  if (lodTrees in LODTypes) and not bTrees3D then begin
    Application.MainForm.Caption := 'Building Trees LOD blocks: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(0) +
      ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
    Application.ProcessMessages;
    StartTick := GetTickCount;

    TreesCount := 0;
    TreesDupCount := 0;
    slLog := TStringList.Create;
    if wbIsFallout3 then LodLevel := 8 else LodLevel := 4;
    Lst := TwbLodTES5TreeList.Create(aWorldspace.EditorID);
    try

    // Fallouts use common atlas for all worldspaces, so we need to collect all available billboards
    // instead of adding them only for trees in specific worldspace
    if wbIsFallout3 then begin
      // Tree can be STAT, ACTI or TREE record with Has Tree LOD flag
      SetLength(Sigs, 3);
      Sigs[0] := 'STAT'; Sigs[1] := 'ACTI'; Sigs[2] := 'TREE';
      for i := Low(Files) to High(Files) do
        for j := Low(Sigs) to High(Sigs) do begin
          Group := Files[i].GroupBySignature[Sigs[j]];
          if Assigned(Group) then
          for k := 0 to Pred(Group.ElementCount) do
            if Supports(Group.Elements[k], IwbMainRecord, TreeRec) and
               TreeRec.IsMaster and
               (TreeRec.WinningOverride.Flags._Flags and $00000040 <> 0)
            then begin
              PTree := LoadBillboard(Lst, TreeRec);
              if PTree^.Index <> - 1 then
                slLog.Add(TreeRec.Name + ' using LOD ' + PTree^.Billboard)
              else
                slLog.Add('<Note: ' + TreeRec.Name + ' LOD not found ' + PTree^.Billboard + '>');
            end;
        end;
    end;

    try
      for i := Low(REFRs) to High(REFRs) do begin
        if not Assigned(REFRs[i].BaseRecord) then
          Continue;

        TreeRec := REFRs[i].BaseRecord.MasterOrSelf;

        // Skyrim: only for TREE and STAT
        if wbIsSkyrim then begin
          if (TreeRec.Signature <> 'TREE') and (TreeRec.Signature <> 'STAT') then
            Continue;
          // STAT with Has Tree LOD flag only
          // for Dragonborn DLC: xx03383D and xx03383C
          if (TreeRec.Signature = 'STAT') and (TreeRec.Flags._Flags and $00000040 = 0) then
            Continue;
        end;

        // Fallouts: only for already added trees
        if wbIsFallout3 and not Assigned(Lst.TreeByFormID[TreeRec.LoadOrderFormID]) then
          Continue;

        if not REFRs[i].GetPosition(RefPos) then
          Continue;

        RefCell := wbPositionToGridCell(RefPos);
        RefBlock := Lodset.BlockForCell(RefCell, LodLevel);

        // reference is out of lod range
        if (RefBlock.x < Lodset.SWCell.x) or (RefBlock.y < Lodset.SWCell.y) then
          Continue;

        // find existing block or add a new one
        // this ensures that empty blocks are created for cells even will all deleted/disabled trees to override vanilla lod files
        k := -1;
        for j := Low(LOD4) to High(LOD4) do
          if (LOD4[j].Cell.x = RefBlock.x) and (LOD4[j].Cell.y = RefBlock.y) then begin
            k := j;
            Break;
          end;
        if k = -1 then begin
          SetLength(LOD4, Succ(Length(LOD4)));
          k := Pred(Length(LOD4));
          LOD4[k].Init(Lst, RefBlock, LodLevel);
        end;

        // skip invisible references
        if REFRs[i].Flags.IsInitiallyDisabled or
           REFRs[i].Flags.IsDeleted or
           REFRs[i].ElementExists['XESP']
        then
          Continue;

        // Skyrim: skip persistent "Is Full LOD" tree refs
        if wbIsSkyrim then
          if REFRs[i].IsPersistent and (REFRs[i].Flags._Flags and $00010000 <> 0) then
            Continue;

        PTree := Lst.TreeByFormID[TreeRec.LoadOrderFormID];
        // adding a new tree to the list
        if not Assigned(PTree) then begin
          PTree := LoadBillboard(Lst, TreeRec);
          if PTree^.Index <> - 1 then
            slLog.Add(TreeRec.Name + ' using LOD ' + PTree^.Billboard)
          else
            slLog.Add('<Note: ' + TreeRec.Name + ' LOD not found ' + PTree^.Billboard + '>');
        end;

        // tree has no billboard texture, skip it's references
        if PTree^.Index = -1 then
          Continue;

        // Trees LOD can't be rotated around x and y (z is ignored), reject "fallen" trees
        if REFRs[i].GetRotation(RefRot) then
          if ((RefRot.x > 30.0) and (RefRot.x < 330.0)) or ((RefRot.y > 30.0) and (RefRot.y < 330.0)) then
            Continue;

        RefPos.x := RefPos.x + PTree^.ShiftX;
        RefPos.y := RefPos.y + PTree^.ShiftY;
        RefPos.z := RefPos.z + PTree^.ShiftZ;

        if REFRs[i].ElementExists['XSCL'] then
          Scale := REFRs[i].ElementNativeValues['XSCL']
        else
          Scale := 1.0;
        Scale := Scale * PTree^.ScaleFactor;

        // Skyrim
        if wbIsSkyrim then
          RefFormID := REFRs[i].LoadOrderFormID
        // Fallouts
        else if REFRs[i].IsMaster then
          RefFormID := REFRs[i].FixedFormID
        else
          RefFormID := REFRs[i].FixedFormID.ChangeFileID(TwbFileID.Create(1));

        if LOD4[k].AddReference(RefFormID, PTree^.Index, RefPos, Scale) then
          Inc(TreesCount)
        else
          Inc(TreesDupCount);

        if wbForceTerminate then
          Abort;
        if StartTick + 500 < GetTickCount then begin
          Application.MainForm.Caption := 'Building Trees LOD blocks: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(i) +
            ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
          Application.ProcessMessages;
          StartTick := GetTickCount;
        end;
      end;

      slLog.Sort;
      wbProgressCallback(Trim(slLog.Text));
      Application.ProcessMessages;

      if not Lst.BuildAtlas(StrToIntDef(Settings.ReadString('Worldspace', 'AtlasSizeMax', ''), 8192)) then begin
        // will return false without exception only if atlas is empty, skip this silenty
        //wbProgressCallback('[' + aWorldspace.EditorID + '] Error occured when building an atlas (empty?).');
        //Exit;
      end;

      // nothing on atlas or in LOD
      if (Lst.TreesListCount = 0) or (wbIsFallout3 and (TreesCount = 0)) then
        wbProgressCallback('<Note: Can not build Trees LOD for ' + aWorldspace.EditorID + ', no resource billboards or valid tree references found>')
      else begin
        LODPath := wbOutputPath; // -O switch override

        Application.MainForm.Caption := 'Deleting old LOD files: ' + aWorldspace.Name +
          ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
        Application.ProcessMessages;
        StartTick := GetTickCount;

        if wbForceTerminate then
          Abort;

        if FindFirst(ExtractFilePath(LODPath + Lst.AtlasFileName) + '*.' + wbLODTreeBlockFileExt, faAnyFile, F) = 0 then try
          repeat
            DeleteFile(ExtractFilePath(LODPath + Lst.AtlasFileName) + F.Name);
            if StartTick + 500 < GetTickCount then begin
              Application.MainForm.Caption := 'Deleting old LOD files: ' + aWorldspace.Name +
                ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
              Application.ProcessMessages;
              StartTick := GetTickCount;
            end;
            if wbForceTerminate then
              Abort;
          until FindNext(F) <> 0;
        finally
          FindClose(F);
        end;

        if Length(LOD4) > 0 then begin
          Application.MainForm.Caption := 'Saving Trees LOD files: ' + aWorldspace.Name;
          Application.ProcessMessages;

          i := Settings.ReadInteger(Section, 'TreesBrightness', 0);
          Lst.ChangeAtlasBrightness(i);
          ForceDirectories(ExtractFilePath(LODPath + Lst.AtlasFileName));
          if not Lst.SaveAtlas(LODPath + Lst.AtlasFileName) then
            raise Exception.Create('Can''t save atlas');
          ForceDirectories(ExtractFilePath(LODPath + Lst.ListFileName));
          Lst.SaveToFile(LODPath + Lst.ListFileName);
          for i := Low(LOD4) to High(LOD4) do
            LOD4[i].SaveToFile(LODPath + LOD4[i].FileName);
        end;

        wbProgressCallback('[' + aWorldspace.EditorID + '] Trees LOD Done.');
        if TreesDupCount <> 0 then
          wbProgressCallback('<Warning: ' + IntToStr(TreesDupCount) + ' duplicate FormID numbers of trees references were detected, excluded from LOD>');
      end;
    except on E: Exception do
      wbProgressCallback('[' + aWorldspace.EditorID + '] Trees LOD generation error: ' + E.Message);
    end;
    finally
      Lst.Free;
      slLog.Free;
      Application.MainForm.Caption := Application.Title;
    end;
  end;

  // Objects LOD
  if lodObjects in LODTypes then begin
    Application.MainForm.Caption := 'Building Objects LOD: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(0) +
      ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
    Application.ProcessMessages;
    StartTick := GetTickCount;

    slCache := TStringList.Create;
    slCacheHPLod := TStringList.Create;
    slRefs := TStringList.Create;
    slExport := TStringList.Create;
    slLODMeshes := TStringList.Create;
    slLODMeshes.Sorted := True;
    slLODMeshes.Duplicates := dupIgnore;
    slLODTextures := TStringList.Create;
    slLODTextures.Sorted := True;
    slLODTextures.Duplicates := dupIgnore;
    slLargeReferences := TStringList.Create;
    slLargeReferences.Sorted := True;
    slLargeReferences.Duplicates := dupIgnore;
    Lst := TwbLodTES5TreeList.Create(aWorldspace.EditorID);

    bChunk := Settings.ReadBool(Section, 'Chunk', False);
    // chunk option will work as an area limiter if upper boundaries are set
    // to build destroyed Megaton LOD area in FO3
    bArea := (Settings.ReadString(Section, 'LODX2', '') <> '') and (Settings.ReadString(Section, 'LODY2', '') <> '');
    bBuildAtlas := Settings.ReadBool(Section, 'BuildAtlas', True);

    // calculate SW and NE corners for building specific chunk
    ChunkSW.x := Low(Integer);
    ChunkSW.y := Low(Integer);
    if wbIsFallout4 then ChunkSize := 32 else ChunkSize := 16;

    if bChunk then begin
      ChunkSize := StrToIntDef(Settings.ReadString(Section, 'LODLevel', ''), ChunkSize);
      ChunkSW.x := StrToIntDef(Settings.ReadString(Section, 'LODX', IntToStr(Low(Integer))), Low(Integer));
      ChunkSW.y := StrToIntDef(Settings.ReadString(Section, 'LODY', IntToStr(Low(Integer))), Low(Integer));
      ChunkNE.x := ChunkSW.x + ChunkSize;
      ChunkNE.y := ChunkSW.y + ChunkSize;
    end;
    // if building in area, then read upper right cell
    if bArea then begin
      ChunkNE.x := StrToIntDef(Settings.ReadString(Section, 'LODX2', IntToStr(High(Integer))), High(Integer));
      ChunkNE.y := StrToIntDef(Settings.ReadString(Section, 'LODY2', IntToStr(High(Integer))), High(Integer));
    end;

    // gather large references if LOD level 4 is generated
    if (wbGameMode in [gmSSE, gmTES5VR]) then
      if (Settings.ReadString(Section, 'LODLevel', '') = '') or (Settings.ReadString(Section, 'LODLevel', '') = '4') then
        GetLargeReferences(Master, slLargeReferences, ChunkSW, ChunkNE);

    try
    try
      for i := Low(REFRs) to High(REFRs) do begin
        StatRec := REFRs[i].BaseRecord;
        if not Assigned(StatRec) then
          Continue;

        // Skyrim: only STAT and TREE objects
        if wbIsSkyrim and ((StatRec.Signature <> 'STAT') and (StatRec.Signature <> 'TREE')) then
          Continue;

        // Fallouts: only STAT, SCOL, ACTI and MSTT objects
        if wbIsFallout3 and ((StatRec.Signature <> 'STAT') and (StatRec.Signature <> 'SCOL') and (StatRec.Signature <> 'ACTI') and (StatRec.Signature <> 'MSTT')) then
          Continue;

        // skip invisible references
        if REFRs[i].Flags.IsInitiallyDisabled or
           REFRs[i].Flags.IsDeleted
        then
          Continue;

        // Skip parent enabled refs which have XESP element
        // If VWD is set on reference it gets static LOD regardless of XESP
        if not REFRs[i].IsVisibleWhenDistant then begin
          XESPRef := REFRs[i].ElementByPath['XESP\Reference'];
          if Assigned(XESPRef) and not wbIsFallout3 then
            Continue;
          // The only exception is Fallout 3 (and TTW) Megaton refs hardcoded to use separate 'apocalypse' LOD meshes when destroyed
          // enabled by MS11MegatonToggle [REFR:0006D4AE]
          if Assigned(XESPRef) and wbIsFallout3 and Supports(XESPRef.LinksTo, IwbMainRecord, XESPLink) then begin
            // skip ordinary enabled refs
            if XESPLink.EditorID <> 'MS11MegatonToggle' then
              Continue
            // but if it is hardcoded engine toggle, then skip only if ref is opposite enabled
            else if REFRs[i].ElementNativeValues['XESP\Flags'] and 1 = 1 then
              Continue;
          end;
        end;

        StatRec := StatRec.WinningOverride;

        // Skyrim: skip persistent refs of "never fade" statics and "Is Full LOD" refs
        if wbIsSkyrim then
          if REFRs[i].IsPersistent and ((StatRec.Flags._Flags and $00000004 <> 0) or (REFRs[i].Flags._Flags and $00010000 <> 0)) then
            Continue;

        if not REFRs[i].GetPosition(RefPos) then
          Continue;

        RefCell := wbPositionToGridCell(RefPos);
        RefBlock := Lodset.BlockForCell(RefCell, 4);

        // reference is out of lod range
        if (RefBlock.x < Lodset.SWCell.x) or (RefBlock.y < Lodset.SWCell.y) then
          Continue;

        // reference not in specific chunk
        // skip references only if no atlas needs to be build
        // or skip if building in area only
        if bArea or (bChunk and not bBuildAtlas) then begin
          if ChunkSW.x <> Low(Integer) then
            if (RefCell.x < ChunkSW.x) or (RefCell.x > ChunkNE.x) then
              Continue;
          if ChunkSW.y <> Low(Integer) then
            if (RefCell.y < ChunkSW.y) or (RefCell.y > ChunkNE.y) then
              Continue;
        end;

        if REFRs[i].ElementExists['XSCL'] then
          scl := REFRs[i].ElementEditValues['XSCL']
        else
          scl := '1.0';

        k := slCache.IndexOfObject(Pointer(StatRec.LoadOrderFormID.ToCardinal));
        if k = -1 then begin
          s := '';
          // Skyrim: process only VWD statics and trees, Fallouts: process all statics
          if (wbIsSkyrim and ((StatRec.Signature = 'TREE') or StatRec.Flags.IsVisibleWhenDistant)) or wbIsFallout3 then begin
            // getting lod models
            m4 := wbGetLODMeshName(StatRec, 0, bTrees3D);
            // notify about 3D tree mesh or fallback to billboard
            if bTrees3D and (StatRec.Signature = 'TREE') then
              if m4 <> '' then
                wbProgressCallback(StatRec.Name + ' using 3D mesh in LOD4 ' + m4)
              else begin
                PTree := Lst.TreeByFormID[StatRec.LoadOrderFormID];
                if not Assigned(PTree) then
                  PTree := LoadBillboard(Lst, StatRec);
                if PTree^.Index <> -1 then begin
                  m4 := PTree^.Billboard;
                  wbProgressCallback(StatRec.Name + ' using 3D flat billboard in LOD4 ' + m4);
                end else
                  wbProgressCallback('<Note: ' + StatRec.Name + ' LOD4 not found ' + PTree^.Billboard + '>');
              end;
            if m4 <> '' then slLODMeshes.Add(m4);

            m8 := wbGetLODMeshName(StatRec, 1, bTrees3D);
            // notify about 3D tree mesh or fallback to billboard
            if bTrees3D and (StatRec.Signature = 'TREE') then
              if m8 <> '' then
                wbProgressCallback(StatRec.Name + ' using 3D mesh in LOD8 ' + m8)
              else begin
                PTree := Lst.TreeByFormID[StatRec.LoadOrderFormID];
                if not Assigned(PTree) then
                  PTree := LoadBillboard(Lst, StatRec);
                if PTree^.Index <> -1 then begin
                  m8 := PTree^.Billboard;
                  wbProgressCallback(StatRec.Name + ' using 3D flat billboard in LOD8 ' + m8);
                end else
                  wbProgressCallback('<Note: ' + StatRec.Name + ' LOD8 not found ' + PTree^.Billboard + '>');
              end;
            if m8 <> '' then slLODMeshes.Add(m8);

            m16 := wbGetLODMeshName(StatRec, 2, bTrees3D);
            // don't fallback to billboards in LOD16 since it is used for the map
            if bTrees3D and (StatRec.Signature = 'TREE') then
              if m16 <> '' then
                wbProgressCallback(StatRec.Name + ' using 3D mesh in LOD16 ' + m16);
            if m16 <> '' then slLODMeshes.Add(m16);

            if (m4 <> '') or (m8 <> '') or (m16 <> '') then begin
              // detecting LOD material
              if wbIsSkyrim and StatRec.ElementExists['DNAM\Material'] and Supports(StatRec.ElementByPath['DNAM\Material'].LinksTo, IwbMainRecord, Ovr) then begin
                mat := LowerCase(Ovr.EditorID);
                if Pos('snow', mat) > 0 then mat := 'Snow' else
                  if Pos('ash', mat) > 0 then mat := 'Ash' else
                    // Sheson: So the material name needs to be 'PassThru', then it will simply use the entire shader effect/lighting as is in the source fie.
                    if Pos('passthru', mat) > 0 then mat := 'PassThru';
              end else
                mat := '';

              // a tab separated string of Editor ID, flags, material, full mesh and lod files
              s := StatRec.EditorID + #9 + IntToHex(StatRec.Flags._Flags, 8) + #9 +
                   mat + #9 + wbGetLODMeshName(StatRec, -1) + #9 +
                   m4 + #9 + m8 + #9 + m16;
            end;
          end;
          k := slCache.Count;
          slCache.AddObject(s, Pointer(StatRec.LoadOrderFormID.ToCardinal));

          // Fallouts: High Priority LOD info with m4 model for m8, at the same index as normal cache
          if wbIsFallout3 then begin
            if s <> '' then
              s := StatRec.EditorID + #9 + IntToHex(StatRec.Flags._Flags, 8) + #9 +
                   mat + #9 + wbGetLODMeshName(StatRec, -1) + #9 +
                   m4 + #9 + m4 + #9 + m16;
            slCacheHPLod.Add(s)
          end;
        end;

        if slCache[k] = '' then
          Continue;

        // Fallouts: High Priority LOD references info from separate cache
        if wbIsFallout3 and (REFRs[i].Flags._Flags and $00010000 <> 0) then
          s := slCacheHPLod[k]
        else
          s := slCache[k];

        // SSE adds -LargeRef to shape name and adds BSDistantObjectLargeRefExtraData with 1 byte = 1 in BTO for new uLargeRefLODGridSize
        // add -LargeRef to material for LODGen.exe
        if (wbGameMode in [gmSSE, gmTES5VR]) and (slLargeReferences.IndexOfObject(Pointer(REFRs[i].MasterOrSelf)) <> -1) then begin
          sl := TStringList.Create;
          sl.Delimiter := #9;
          sl.StrictDelimiter := True;
          try
            sl.DelimitedText := s;
            s := '';
            for j := 0 to Pred(sl.Count) do begin
              if j <> 2 then
                s := s + sl[j]
              else
                s := s + sl[j] + '-LargeRef';
              if j < Pred(sl.Count) then
                s := s + #9;
            end;
          finally
            sl.Free;
          end;
        end;

        s := REFRs[i].LoadOrderFormID.ToString(False) + #9 +
             IntToHex(REFRs[i].Flags._Flags, 8) + #9 +
             REFRs[i].ElementEditValues['DATA\Position\X'] + #9 +
             REFRs[i].ElementEditValues['DATA\Position\Y'] + #9 +
             REFRs[i].ElementEditValues['DATA\Position\Z'] + #9 +
             REFRs[i].ElementEditValues['DATA\Rotation\X'] + #9 +
             REFRs[i].ElementEditValues['DATA\Rotation\Y'] + #9 +
             REFRs[i].ElementEditValues['DATA\Rotation\Z'] + #9 +
             scl + #9 + s;
        slRefs.Add(s);

        if wbForceTerminate then
          Abort;
        if StartTick + 500 < GetTickCount then begin
          Application.MainForm.Caption := 'Building Objects LOD: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(i) +
            ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
          Application.ProcessMessages;
          StartTick := GetTickCount;
        end;
      end;

      // nothing to export for LODGen
      if slRefs.Count = 0 then
        wbProgressCallback('<Note: Can not build Objects LOD for ' + aWorldspace.EditorID + ', no valid references found>')
      else begin
        // creating lod textures atlas part 1 - set file paths to be used in export file
        if bBuildAtlas then begin
          UVRange := StrToFloatDef(Settings.ReadString(Section, 'AtlasTextureUVRange', '1.5'), 1.5);
          // atlas file name
          if wbIsSkyrim then
            AtlasName := wbOutputPath + 'textures\terrain\' + aWorldspace.EditorID  + '\Objects\' + aWorldspace.EditorID + 'ObjectsLOD.dds'
          else if wbIsFallout3 then
            AtlasName := wbOutputPath + 'textures\landscape\lod\' + aWorldspace.EditorID  + '\Blocks\' + aWorldspace.EditorID + '.Buildings.dds';
          // atlas map name
          AtlasMapName := wbScriptsPath + 'LODGenAtlasMap.txt';
          // textures list file name
          //if wbGameMode in [ gmSSE ] then
          //  TexturesListFile := wbScriptsPath + 'LODGenTexturesList.txt';
          // make sure atlas folder exists
          if not DirectoryExists(ExtractFilePath(AtlasName)) then
            if not ForceDirectories(ExtractFilePath(AtlasName)) then
              raise Exception.Create('Can not create output folder for atlas ' + ExtractFilePath(AtlasName));
        end
        else
          // use vanilla atlas if build atlas is not selected
          if wbIsSkyrim then begin
            AtlasMapName := wbScriptsPath + wbAppName + '-AtlasMap-' + aWorldspace.EditorID + '.txt';
            UVRange := 10000;
          end;

        // creating lodgen data file
        // use same Export file for gathering textures list for texture atlas and to generate static LOD
        slExport.Add('GameMode=' + wbAppName);
        slExport.Add('Worldspace=' + aWorldspace.EditorID);
        slExport.Add('CellSW=' + Format('%d %d', [Lodset.SWCell.x, Lodset.SWCell.y]));
        if wbIsSkyrim then begin
          // LODGen ignores this texture when building textures list for atlas
          slExport.Add('TextureDiffuseHD=' + aWorldspace.WinningOverride.ElementEditValues['TNAM']);
          slExport.Add('TextureNormalHD=' + aWorldspace.WinningOverride.ElementEditValues['UNAM']);
        end;

        // which LOD level to generate depending on dlodsettings
        if wbIsFallout3 and (LodSet.ObjectLevel = 8) then
          slExport.Add('Level8=True');

        // list file that will be created by LODGen containing all textures that have UV inside UVRange, uses AtlasTolerance=
        //if (TexturesListFile <> '') then
        //  slExport.Add('TexturesListFile=' + TexturesListFile);
        if (AtlasMapName <> '') then begin
          slExport.Add('TextureAtlasMap=' + AtlasMapName);
          slExport.Add('AtlasTolerance=' + Format('%1.1f', [UVRange - 1.0]));
        end;
        slExport.Add('PathData=' + wbDataPath);
        if wbIsSkyrim then
          slExport.Add('PathOutput=' + wbOutputPath + 'meshes\terrain\' + aWorldspace.EditorID  + '\Objects')
        else if wbIsFallout3 then
          slExport.Add('PathOutput=' + wbOutputPath + 'meshes\landscape\lod\' + aWorldspace.EditorID  + '\Blocks')
        else
          raise Exception.Create('Unsupported LODGen game');
        // list of BSAs
        if Assigned(wbContainerHandler) then begin
          sl := TStringList.Create;
          try
            wbContainerHandler.ContainerList(sl);
            for i := 0 to sl.Count - 2 do  // exclude the last Data folder
              slExport.Add('Resource=' + sl[i]);
          finally
            sl.Free;
          end;
        end;

        // adding list of meshes to ignore translation/rotation
        with TStringList.Create do try
          Delimiter := ',';
          StrictDelimiter := True;
          if wbIsSkyrim then
            DelimitedText := Settings.ReadString(Section, 'IgnoreTranslation', sMeshIgnoreTranslationTES5)
          else if wbIsFallout3 then
            DelimitedText := Settings.ReadString(Section, 'IgnoreTranslation', sMeshIgnoreTranslationFNV);
          for i := 0 to Pred(Count) do
            slExport.Add('IgnoreTranslation=' + Strings[i]);
        finally
          Free;
        end;

        // billboards list for 3D trees LOD
        if bTrees3D then begin
          sl := TStringList.Create;
          try
            for i := Low(Lst.fTrees) to High(Lst.fTrees) do
              if Lst.fTrees[i].Index <> -1 then begin
                sl.Add(
                  Lst.fTrees[i].Billboard + #9 +
                  FloatToStr(Lst.fTrees[i].Width) + #9 +
                  FloatToStr(Lst.fTrees[i].Height) + #9 +
                  FloatToStr(Lst.fTrees[i].ShiftZ) + #9 +
                  FloatToStr(Lst.fTrees[i].ScaleFactor) + #9 +
                  '1' + #9 +  // float for BillboardsEffectLighting
                  wbScriptsPath + 'LODGen_flat_lod.nif' + #9 +
                  '' + #9 + // glow texture
                  '-1' + #9 + // float vertex color
                  '-1' // float vertexcolor range
                );
              end;
            s := wbScriptsPath + 'LODGenFlatTextures.txt';
            sl.SaveToFile(s);
            slExport.Add('FlatTextures=' + s);
          finally
            sl.Free;
          end;
        end;

        // adding Extra Options
        s := wbScriptsPath + wbLODExtraOptionsFileName(
          ChangeFileExt(ExtractFileName(aWorldspace.MasterOrSelf._File.FileName), ''),
          aWorldspace.EditorID
        );
        if FileExists(s) then begin
          sl := TStringList.Create;
          try
            sl.LoadFromFile(s);
            slExport.AddStrings(sl);
            wbProgressCallback('[' + aWorldspace.EditorID + '] Using options file: ' + s);
          finally
            sl.Free;
          end;
        end else
          wbProgressCallback('[' + aWorldspace.EditorID + '] No options file found: ' + s);

        // adding references list
        slExport.AddStrings(slRefs);

        // saving export file
        s := wbScriptsPath + 'LODGen.txt';
        wbProgressCallback('[' + aWorldspace.EditorID + '] Saving LODGen data: ' + s);
        slExport.SaveToFile(s);

        // creating lod textures atlas part 2 - gather list of used textures and create atlas textures
        if bBuildAtlas then begin
          {if wbGameMode in [ gmSSE ] then begin
            // use LODGen.exe to build texture list, output file defined by TexturesListFile= in export file
            wbProgressCallback('[' + aWorldspace.EditorID + '] Gathering list of textures for atlas');
            Application.ProcessMessages;
            s := Format('"%s" "%s"', [wbScriptsPath + sLODGenName, s]);
            // this overwrites GameMode set in export file
            s := s + ' --GameMode textureslist';

            Application.MainForm.Caption := 'Running LODGen, press ESC to abort';
            wbProgressCallback('[' + aWorldspace.EditorID + '] Running ' + s);
            Application.ProcessMessages;

            // execute LODGen.exe to generate texture list
            ErrCode := ExecuteCaptureConsoleOutput(s);
            if ErrCode <> 0 then
              raise Exception.Create('LODGen process error, exit code ' + IntToHex(ErrCode, 8));

            // load textures from file created by LODGen.exe
            if (TexturesListFile <> '') and FileExists(TexturesListFile) then
              slLODTextures.LoadFromFile(TexturesListFile);
          end}

          // Fallout 3 and FNV don't support several shapes in LOD quads, treat all meshes as untiled
          if wbIsFallout3 then
            UVRange := 10000;

          wbGetUVRangeTexturesList(slLODMeshes, slLODTextures, UVRange);

          if slLODTextures.Count > 1 then begin
            // remove HD LOD texture if there
            if wbIsSkyrim then begin
              i := slLODTextures.IndexOf(wbNormalizeResourceName(aWorldspace.WinningOverride.ElementEditValues['TNAM'], resTexture));
              if i <> -1 then slLODTextures.Delete(i);
            end;

            wbProgressCallback('[' + aWorldspace.EditorID + '] Building LOD textures atlas: ' + AtlasName);
            Application.ProcessMessages;

            wbBuildAtlasFromTexturesList(
              slLODTextures,
              Settings.ReadInteger(Section, 'AtlasTextureSize', 512),
              Settings.ReadInteger(Section, 'AtlasTextureSize', 512), // tile size, same as texture size
              Settings.ReadInteger(Section, 'AtlasWidth', 2048),
              Settings.ReadInteger(Section, 'AtlasHeight', 2048),
              AtlasName,
              AtlasMapName,
              Settings
            );
          end;
        end;

        s := wbScriptsPath + 'LODGen.txt';
        s := Format('"%s" "%s"', [wbScriptsPath + sLODGenName, s]);
        s := s + ' --dontFixTangents';
        s := s + ' --removeUnseenFaces';
        // if "No LOD Water" flag is set for a worldspace, then don't remove underwater meshes
        i := aWorldspace.WinningOverride.ElementNativeValues['DATA'];
        if (wbIsSkyrim and (i and $08 <> 0)) or (wbIsFallout3 and (i and $10 <> 0)) then
          s := s + ' --ignoreWater';
        if Settings.ReadBool(wbAppName + ' LOD Options', 'ObjectsNoVertexColors', False) then
          s := s + ' --dontGenerateVertexColors';
        if Settings.ReadBool(wbAppName + ' LOD Options', 'ObjectsNoTangents', False) then
          s := s + ' --dontGenerateTangents';
        if bChunk and not bArea then begin
          if Settings.ReadString(Section, 'LODLevel', '') <> '' then
            s := s + ' --lodLevel ' + Settings.ReadString(Section, 'LODLevel', '');
          if Settings.ReadString(Section, 'LODX', '') <> '' then
            s := s + ' --x ' + Settings.ReadString(Section, 'LODX', '');
          if Settings.ReadString(Section, 'LODY', '') <> '' then
            s := s + ' --y ' + Settings.ReadString(Section, 'LODY', '');
        end;

        Application.MainForm.Caption := 'Running LODGen, press ESC to abort';
        wbProgressCallback('[' + aWorldspace.EditorID + '] Running ' + s);
        Application.ProcessMessages;

        ErrCode := ExecuteCaptureConsoleOutput(s);
        if ErrCode <> 0 then
          raise Exception.Create('LODGen process error, exit code ' + IntToHex(ErrCode, 8));

        // disable traditional Trees LOD if trees are generated as objects
        if bTrees3D and (ErrCode = 0) then begin
          s := wbDataPath + lst.ListFileName;
          if FileExists(s) then DeleteFile(s);
          if wbContainerHandler.ResourceExists(lst.ListFileName) then begin
            ForceDirectories(ExtractFilePath(s));
            SetLength(Bytes, 4);
            TFile.WriteAllBytes(s, Bytes);
            wbProgressCallback('<Note: Trees LOD list file exists in archives, creating an empty loose one to disable native LOD: ' + lst.ListFileName + '>');
          end;
        end;

        wbProgressCallback('[' + aWorldspace.EditorID + '] Objects LOD Done.');

        // DynDOLOD reference message, tribute to Sheson who made TES5LODGen possible
        if wbIsSkyrim then begin
          wbProgressCallback(StringOfChar('*', 120));
          wbProgressCallback('If you want more detailed, dynamic LOD with wide customization, please check DynDOLOD by Sheson');
          wbProgressCallback('http://www.nexusmods.com/skyrim/mods/59721/');
          wbProgressCallback('It uses the same LODGen building process as TES5LODGen internally, but with more options.');
          wbProgressCallback(StringOfChar('*', 120));
          wbProgressCallback('');
        end;
      end;
    except on E: Exception do
      wbProgressCallback('[' + aWorldspace.EditorID + '] Objects LOD generation error: ' + E.Message);
    end;
    finally
      slCache.Free;
      slCacheHPLod.Free;
      slRefs.Free;
      slLODMeshes.Free;
      slLODTextures.Free;
      slLargeReferences.Free;
      slExport.Free;
      Lst.Free;
      Application.MainForm.Caption := Application.Title;
    end;
  end;
end;

procedure wbGenerateLODFO4(
  const aWorldspace: IwbMainRecord;
  const Files: TDynFiles;
  const Settings: TCustomIniFile
);
var
  StartTick, ErrCode  : Cardinal;
  AtlasName, AtlasMapName: string;
  Section, s          : string;
  REFRs               : TDynMainRecords;
  ChunkSize, i, j     : Integer;
  LodSet              : TwbLodSettings;
  Res                 : TDynResources;
  ChunkSW, ChunkNE    : TwbGridCell;
  slCache, slRefs, slExport, sl: TStringList;
  slLODMeshes, slLODTextures, slBGSM: TStringList;
  slCont, slList      : TwbFastStringList;
  bChunk, bBuildAtlas : Boolean;
  UVRange             : Single;
  bgsm                : TwbBGSMFile;

    procedure ProcessReference(const e: IwbMainRecord; iPart: Integer = 0; iPlacement: Integer = 0; bRecursive: Boolean = False);
    var
      StatRec, XESP, MSWP, StatMultiRefLOD: IwbMainRecord;
      s, mat, m4, m8, m16, m32, scl, xespid, basemat, swapmat, transrot: string;
      RefPos: TwbVector;
      RefCell, RefBlock: TwbGridCell;
      k, n, iMaxPlacement: Integer;
      Entries, Entry: IwbContainer;
      sl, slBaseMat, slSwapMat: TStringList;
      bInitiallyDisabled: Boolean;
    begin
      // skip deleted references
      if e.Flags.IsDeleted then
        Exit;

      StatRec := e.BaseRecord.WinningOverride;
      if not Assigned(StatRec) then
        Exit;

      if (StatRec.Signature <> 'STAT') and (StatRec.Signature <> 'SCOL') then
        Exit;

      if not e.GetPosition(RefPos) then
        Exit;

      // skip markers, markers with VWD are MultiRef LODs and need to be kept
      if e.IsPersistent and not e.Flags.IsVisibleWhenDistant and (StatRec.Flags._Flags and $00000004 <> 0) then
        Exit;

      // skip initially disabled without XESP and without VWD
      if e.Flags.IsInitiallyDisabled and not e.ElementExists['XESP'] and not e.Flags.IsVisibleWhenDistant then
        Exit;

      // get form id of XESP marker and check if flag LOD Respects Enable State
      // this potentially has the same duplicate form id problem as 2D tree LOD in Skyrim
      if e.ElementExists['XESP'] then begin
        XESP := e.ElementLinksTo['XESP\Reference'] as IwbMainRecord;
        if Assigned(XESP) and (XESP.Flags._Flags and $100 = $100) then
          xespid := XESP.FormID.ToString(False)
        // if the reference is inititally enabled it gets LOD, VWD always gets LOD
        else if Assigned(XESP) and not e.Flags.IsVisibleWhenDistant then begin
          bInitiallyDisabled := XESP.Flags.IsInitiallyDisabled;
          if e.ElementNativeValues['XESP\Flags'] and $1 = $1 then
            bInitiallyDisabled := not bInitiallyDisabled;
          if bInitiallyDisabled then
            Exit;
        end;
      end;

      RefCell := wbPositionToGridCell(RefPos);
      RefBlock := Lodset.BlockForCell(RefCell, 4);

      // reference is out of lod range
      if (RefBlock.x < Lodset.SWCell.x) or (RefBlock.y < Lodset.SWCell.y) then
        Exit;

      // reference not in specific chunk - only skip references if no atlas needs to be build
      if bChunk and not bBuildAtlas then begin
        if ChunkSW.x <> Low(Integer) then
          if (RefCell.x < ChunkSW.x) or (RefCell.x > ChunkNE.x) then
            Exit;
        if ChunkSW.y <> Low(Integer) then
          if (RefCell.y < ChunkSW.y) or (RefCell.y > ChunkNE.y) then
            Exit;
      end;

    // SCOL static collection
    // get transformation and rotation of a part in relation to reference for export file
    transrot := #9#9#9#9#9#9;
    iMaxPlacement := -1;
    if StatRec.Signature = 'SCOL' then
      if StatRec.ElementExists['Parts'] and Supports(StatRec.ElementByName['Parts'], IwbContainer, Entries) then begin
        // get current part
        Entry := Entries[iPart] as IwbContainer;
        // process the next part
        if (iPlacement = 0) and (iPart < Pred(Entries.ElementCount)) then
          ProcessReference(e, iPart + 1, iPlacement, False);
        // get STAT for current part
        StatRec := (Entry.ElementLinksTo['ONAM - Static'] as IwbMainRecord);
        if not Assigned(StatRec) then
          Exit;
        StatRec := StatRec.WinningOverride;
        if Entry.ElementExists['DATA - Placements'] and Supports(Entry.ElementByName['DATA - Placements'], IwbContainer, Entries) then begin
          iMaxPlacement := Pred(Entries.ElementCount);
          // get current placement
          Entry := Entries.Elements[iPlacement] as IwbContainer;
          transrot := Format('%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s', [
            Entry.ElementEditValues['Position\X'],
            Entry.ElementEditValues['Position\Y'],
            Entry.ElementEditValues['Position\Z'],
            Entry.ElementEditValues['Rotation\X'],
            Entry.ElementEditValues['Rotation\Y'],
            Entry.ElementEditValues['Rotation\Z'],
            Entry.ElementEditValues['Scale']
          ]);
        end;
      end;

      k := slCache.IndexOfObject(Pointer(StatRec.LoadOrderFormID.ToCardinal));

      if (k = -1) then begin
        s := '';
        // process only VWD statics
        if StatRec.Flags.IsVisibleWhenDistant then begin
          // getting lod models
          m4 := wbGetLODMeshName(StatRec, 0);
          m8 := wbGetLODMeshName(StatRec, 1);
          m16 := wbGetLODMeshName(StatRec, 2);
          m32 := wbGetLODMeshName(StatRec, 3);

          if (m4 <> '') or (m8 <> '') or (m16 <> '') or (m32 <> '') then begin
            // snow shaders and snow LOD are still defined in esm, need to test if it works
            mat := '';
            // a tab separated string of Editor ID, flags, material, full mesh and lod files
            s := StatRec.EditorID + #9 + IntToHex(StatRec.Flags._Flags, 8) + #9 +
                 mat + #9 + wbGetLODMeshName(StatRec, -1) + #9 +
                 m4 + #9 + m8 + #9 + m16 + #9 + m32;
          end;
        end;
        k := slCache.Count;
        slCache.AddObject(s, Pointer(StatRec.LoadOrderFormID.ToCardinal));
      end;

      s := slCache[k];

      if s = '' then begin
        Exit;
      end;

      // check for KYWD 0x00195411 MultirefLOD
      // LOD4 uses traditional LOD models for each full model of the group
      // LOD8/16/32 uses 1 simple LOD model for entire group, defined by the linked reference (it is a persistent marker with VWD)
      if e.ElementExists['Linked References'] and Supports(e.ElementByName['Linked References'], IwbContainer, Entries) then begin
        for n := 0 to Pred(Entries.ElementCount) do begin
          Entry := Entries[n] as IwbContainer;
          if Assigned(Entry.ElementLinksTo['Keyword/Ref']) and ((Entry.ElementLinksTo['Keyword/Ref'] as IwbMainRecord).EditorID = 'MultirefLOD') then begin
            // get the base record of the linked reference
            StatMultiRefLOD := (Entry.ElementLinksTo['Ref'] as IwbMainRecord).WinningOverride.BaseRecord.WinningOverride;
            Break;
          end;
        end;
        if Assigned(StatMultiRefLOD) then begin
          sl := TStringList.Create;
          try
            sl.Delimiter := #9;
            sl.StrictDelimiter := True;
            sl.DelimitedText := s;
            // remove level if it has LOD in linked base record
            if (sl.Count = 8) and Assigned(StatMultiRefLOD) then begin
              if wbGetLODMeshName(StatMultiRefLOD, 0) <> '' then
                sl[4] := '';
              if wbGetLODMeshName(StatMultiRefLOD, 1) <> '' then
                sl[5] := '';
              if wbGetLODMeshName(StatMultiRefLOD, 2) <> '' then
                sl[6] := '';
              if wbGetLODMeshName(StatMultiRefLOD, 3) <> '' then
                sl[7] := '';
            end;
            s := StringReplace(sl.CommaText, ',', #9, [rfReplaceAll]);
          finally
            sl.Free;
          end;
        end;
      end;

      scl := e.ElementEditValues['XSCL'];
      if scl = '' then
        scl := '1.0';

      // material swap on a reference
      if e.ElementExists['XMSP'] then
        MSWP := e.ElementLinksTo['XMSP'] as IwbMainRecord
      // material swap on a base record (this could be added to slCache, but then would have to replaced in case of XMSP
      else if StatRec.ElementExists['Model'] and Supports(StatRec.ElementByName['Model'], IwbContainer, Entries) then
        if Entries.ElementExists['MODS'] then
          MSWP := Entries.ElementLinksTo['MODS'] as IwbMainRecord;
      // build a list of base and swap materials for export file for LODGen
      if Assigned(MSWP) and Supports(MSWP.WinningOverride.ElementByName['Material Substitutions'], IwbContainer, Entries) then begin
        slBaseMat := TStringList.Create;
        slSwapMat := TStringList.Create;
        try
          for n := 0 to Pred(Entries.ElementCount) do begin
            Entry := Entries.Elements[n] as IwbContainer;
            // export everything in case full model is used for LOD - there may be a wild card * for base
            basemat := Lowercase(wbNormalizeResourceName(Entry.ElementEditValues['BNAM'], resMaterial));
            swapmat := Lowercase(wbNormalizeResourceName(Entry.ElementEditValues['SNAM'], resMaterial));
            slSwapMat.Add(swapmat);
            slBaseMat.Add(basemat);
            // list of swap materials for atlas
            if Pos('lod\', swapmat) > 0 then
              slBGSM.Add(swapmat);
          end;
          basemat := slBaseMat.DelimitedText;
          swapmat := slSwapMat.DelimitedText;
          // there are quite a lot of "missing" LOD swaps for vanilla, but this would be a helpful debug message for mod authors for other plugins
          //if (Pos('lod\', basemat) = 0) and (Pos('lod\', swapmat) = 0) then
          //  wbProgressCallback('<Note: Material swap did not define substitutions for LOD, using default texture [' + IntToHex(MSWP.FormID, 8) + '] ' + MSWP.EditorID + '>');
        finally
          slBaseMat.Free;
          slSwapMat.Free;
        end;
      end;

      s := e.LoadOrderFormID.ToString(False) + #9 +
           IntToHex(e.Flags._Flags, 8) + #9 +
           e.ElementEditValues['DATA\Position\X'] + #9 +
           e.ElementEditValues['DATA\Position\Y'] + #9 +
           e.ElementEditValues['DATA\Position\Z'] + #9 +
           e.ElementEditValues['DATA\Rotation\X'] + #9 +
           e.ElementEditValues['DATA\Rotation\Y'] + #9 +
           e.ElementEditValues['DATA\Rotation\Z'] + #9 +
           scl + #9 +
           s + #9 +
           xespid + #9 +
           basemat + #9 +
           swapmat + #9 +
           transrot;
      slRefs.Add(s);

      // list of used LOD meshes for atlas
      if m4 <> '' then slLODMeshes.Add(m4);
      if m8 <> '' then slLODMeshes.Add(m8);
      if m16 <> '' then slLODMeshes.Add(m16);
      if m32 <> '' then slLODMeshes.Add(m16);

      if wbForceTerminate then
        Abort;
      if StartTick + 500 < GetTickCount then begin
        Application.MainForm.Caption := 'Building Objects LOD: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(i) +
          ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
        Application.ProcessMessages;
        StartTick := GetTickCount;
      end;

      // process the next placements of this part of a SCOL
      if not bRecursive and (iPlacement < iMaxPlacement) then
        for n := iPlacement to Pred(iMaxPlacement) do
          ProcessReference(e, iPart, n + 1, True);

    end;

begin
  // need an existing lodsettings file to align lod blocks
  Res := wbContainerHandler.OpenResource(wbLODSettingsFileName(aWorldspace.EditorID));
  if Length(Res) > 0 then
    LodSet.LoadFromData(Res[High(Res)].GetData)
  else begin
    wbProgressCallback('[' + aWorldspace.EditorID + '] Lodsettings file not found for worldspace.');
    Exit;
  end;

  // settings file LOD options section
  Section := wbAppName + ' LOD Options';

  wbFindUniqueWorldspaceREFRs(aWorldspace, REFRs);
  if Length(REFRs) = 0 then
    Exit;

  wbProgressCallback('[' + aWorldspace.EditorID + '] Generating LOD');
  Application.MainForm.Caption := 'Building Objects LOD: ' + aWorldspace.Name + ' Processed Records: ' + IntToStr(0) +
    ' Elapsed Time: ' + FormatDateTime('nn:ss', Now - wbStartTime);
  Application.ProcessMessages;
  StartTick := GetTickCount;

  slCache := TStringList.Create;
  slRefs := TStringList.Create;
  slExport := TStringList.Create;
  slLODMeshes := TStringList.Create; slLODMeshes.Sorted := True; slLODMeshes.Duplicates := dupIgnore;
  slLODTextures := TStringList.Create; slLODTextures.Sorted := True; slLODTextures.Duplicates := dupIgnore;
  slBGSM := TStringList.Create; slBGSM.Sorted := True; slBGSM.Duplicates := dupIgnore;

  bChunk := Settings.ReadBool(Section, 'Chunk', False);
  bBuildAtlas := Settings.ReadBool(Section, 'BuildAtlas', True);
  // calculate SW and NE corners for building specific chunk
  ChunkSW.x := Low(Integer);
  ChunkSW.y := Low(Integer);
  ChunkSize := 32;

  if bChunk then begin
    if Settings.ReadString(Section, 'LODLevel', '') <> '' then
      ChunkSize  := StrToInt(Settings.ReadString(Section, 'LODLevel', ''));
    if Settings.ReadString(Section, 'LODX', IntToStr(Low(Integer))) <> '' then
      ChunkSW.x := StrToInt(Settings.ReadString(Section, 'LODX', IntToStr(Low(Integer))));
    if Settings.ReadString(Section, 'LODY', IntToStr(Low(Integer))) <> '' then
      ChunkSW.y := StrToInt(Settings.ReadString(Section, 'LODY', IntToStr(Low(Integer))));
  end;
  ChunkNE.x := ChunkSW.x + ChunkSize;
  ChunkNE.y := ChunkSW.y + ChunkSize;

  try
    try
      for i := Low(REFRs) to High(REFRs) do
        ProcessReference(REFRs[i]);

      // nothing to export for LODGen
      if slRefs.Count = 0 then begin
        wbProgressCallback('<Note: Can not build Objects LOD for ' + aWorldspace.EditorID + ', no valid references found>');
        Exit;
      end;

      UVRange := StrToFloatDef(Settings.ReadString(Section, 'AtlasTextureUVRange', '1.5'), 1.5);

      // creating lod textures atlas part 1 - set file paths to be used in export file
      if bBuildAtlas then begin
        // atlas file name
        AtlasName := wbOutputPath + 'textures\terrain\' + aWorldspace.EditorID  + '\Objects\' + aWorldspace.EditorID + 'ObjectsLOD.dds';
        // atlas map name
        AtlasMapName := wbScriptsPath + 'LODGenAtlasMap.txt';
        // make sure atlas folder exists
        if not DirectoryExists(ExtractFilePath(AtlasName)) then
          if not ForceDirectories(ExtractFilePath(AtlasName)) then
            raise Exception.Create('Can not create output folder for atlas ' + ExtractFilePath(AtlasName));
      end
      else begin
        // use vanilla atlas if build atlas is not selected
        AtlasMapName := wbScriptsPath + wbAppName + '-AtlasMap-' + aWorldspace.EditorID + '.txt';
        UVRange := 10000;
      end;

      // creating lodgen data file
      slExport.Add('GameMode=' + wbAppName);
      slExport.Add('Worldspace=' + aWorldspace.EditorID);
      slExport.Add('CellSW=' + Format('%d %d', [Lodset.SWCell.x, Lodset.SWCell.y]));
      slExport.Add('RemoveUnseenFaces=True');
      slExport.Add('IgnoreWater=' + BooleanText[Boolean(aWorldspace.ElementNativeValues['DATA\No LOD Water'])]);
      // most of FO4 LOD models have no vertex colors/all white, vanilla BTO never have any vertex colors, but they are supported
      // LODGen.exe optimizes all white away so not
      slExport.Add('DontGenerateVertexColors=' + BooleanText[Settings.ReadBool(wbAppName + ' LOD Options', 'ObjectsNoVertexColors', False)]);
      slExport.Add('DontGenerateTangents=' + BooleanText[Settings.ReadBool(wbAppName + ' LOD Options', 'ObjectsNoTangents', False)]);
      // FO4 sets alpha threshold on shapes, the default is 128
      slExport.Add('DefaultAlphaThreshold=' + IntToStr(Settings.ReadInteger(wbAppName + ' LOD Options', 'DefaultAlphaThreshold', iDefaultAlphaThreshold)));
      // LODGen uses the alpha threshold found in source model / material instead of the defaut value
      slExport.Add('UseAlphaThreshold=' + BooleanText[Settings.ReadBool(wbAppName + ' LOD Options', 'ObjectsUseAlphaThreshold', False)]);
      // LODGen applies the BacklightPower found on source model / material instead of default 0.0 - useful for double sided
      // vanilla models / materials have 0 defined, while tree LOD with double sided leafs *should* have >=1.0 like their full models, so front/back side are equally lit
      slExport.Add('UseBacklightPower=' + BooleanText[Settings.ReadBool(wbAppName + ' LOD Options', 'ObjectsUseBacklightPower', False)]);

      if AtlasMapName <> '' then begin
        slExport.Add('TextureAtlasMap=' + AtlasMapName);
        slExport.Add('AtlasTolerance=' + Format('%1.1f', [UVRange - 1.0]));
      end;
      slExport.Add('PathData=' + wbDataPath);
      slExport.Add('PathOutput=' + wbOutputPath + 'meshes\terrain\' + aWorldspace.EditorID  + '\Objects');

      // list of archives
      if Assigned(wbContainerHandler) then begin
        sl := TStringList.Create;
        try
          wbContainerHandler.ContainerList(sl);
          for i := 0 to sl.Count - 2 do  // exclude the last Data folder
            slExport.Add('Resource=' + sl[i]);
        finally
          sl.Free;
        end;
      end;

      // adding Extra Options
      s := wbScriptsPath + wbLODExtraOptionsFileName(
        ChangeFileExt(ExtractFileName(aWorldspace.MasterOrSelf._File.FileName), ''),
        aWorldspace.EditorID
      );
      if FileExists(s) then begin
        sl := TStringList.Create;
        try
          sl.LoadFromFile(s);
          slExport.AddStrings(sl);
          wbProgressCallback('[' + aWorldspace.EditorID + '] Using options file: ' + s);
        finally
          sl.Free;
        end;
      end else
        wbProgressCallback('[' + aWorldspace.EditorID + '] No options file found: ' + s);

      // adding references list
      slExport.AddStrings(slRefs);

      // saving export file
      s := wbScriptsPath + 'LODGen.txt';
      wbProgressCallback('[' + aWorldspace.EditorID + '] Saving LODGen data: ' + s);
      slExport.SaveToFile(s);

      // creating lod textures atlas part 2 - gather list of used textures and create atlas textures
      if bBuildAtlas then begin
        // textures from LOD meshes
        wbGetUVRangeTexturesList(slLODMeshes, slLODTextures, UVRange);

        // textures from LOD material swaps
        if slBGSM.Count > 0 then begin

          bgsm := TwbBGSMFile.Create;
          slCont := TwbFastStringList.Create;
          slList := TwbFastStringList.Create;
          try
            // get list of all files in materials\lod\ for wildcard replacements
            wbContainerHandler.ContainerList(slCont);
            for i := Pred(slCont.Count) downto 0 do
              wbContainerHandler.ContainerResourceList(slCont[i], slList, 'materials\lod\');
            slList.Duplicates := dupIgnore;
            slList.Sorted := True;

            i := -1;
            while i < Pred(slBGSM.Count) do begin
              inc(i);
              // replace wildcard swaps with matching files
              if Pos('*', slBGSM[i]) > 0 then begin
                for j := 0 to Pred(slList.Count) do
                  if MatchesMask(slList[j], slBGSM[i]) then
                    slBGSM.Add(slList[j]);
                Continue;
              end;
              // textures from LOD material swaps
              try
                s := slBGSM[i];
                // fix bug in dlcnukaworld xx01F5B3
                if s = 'materials\dlc04\lod\architecture\galacticzone\metalpaneltrim01_lod__black17.bgsm' then
                  s := 'materials\dlc04\lod\architecture\galacticzone\metalpaneltrim01_lod_black17.bgsm';

                if not wbContainerHandler.ResourceExists(s) then
                  raise Exception.Create('Not found');

                bgsm.LoadFromResource(s);
              except on E: Exception do
                wbProgressCallback('<Warning: Error reading "' + s + '": ' + E.Message + '>');
              end;
              slLODTextures.Add(wbNormalizeResourceName(bgsm.EditValues['Textures\Diffuse'], resTexture));
            end;
          finally
            bgsm.Free;
            slCont.Free;
            slList.Free;
          end;
        end;

        if slLODTextures.Count > 1 then begin
          wbProgressCallback('[' + aWorldspace.EditorID + '] Building LOD textures atlas: ' + AtlasName);
          Application.ProcessMessages;
          wbBuildAtlasFromTexturesList(
            slLODTextures,
            Settings.ReadInteger(Section, 'AtlasTextureSize', 512),
            Settings.ReadInteger(Section, 'AtlasTextureSize', 512), // tile size, same as texture size
            Settings.ReadInteger(Section, 'AtlasWidth', 4096),
            Settings.ReadInteger(Section, 'AtlasHeight', 4096),
            AtlasName,
            AtlasMapName,
            Settings
          );
        end;
      end;

      s := wbScriptsPath + 'LODGen.txt';
      s := Format('"%s" "%s"', [wbScriptsPath + sLODGenName, s]);
      if bChunk then begin
        if Settings.ReadString(Section, 'LODLevel', '') <> '' then
          s := s + ' --lodLevel ' + Settings.ReadString(Section, 'LODLevel', '');
        if Settings.ReadString(Section, 'LODX', '') <> '' then
          s := s + ' --x ' + Settings.ReadString(Section, 'LODX', '');
        if Settings.ReadString(Section, 'LODY', '') <> '' then
          s := s + ' --y ' + Settings.ReadString(Section, 'LODY', '');
      end;

      Application.MainForm.Caption := 'Running LODGen, press ESC to abort';
      wbProgressCallback('[' + aWorldspace.EditorID + '] Running ' + s);
      Application.ProcessMessages;

      ErrCode := ExecuteCaptureConsoleOutput(s);
      if ErrCode <> 0 then
        raise Exception.Create('LODGen process error, exit code ' + IntToHex(ErrCode, 8));
      wbProgressCallback('[' + aWorldspace.EditorID + '] Objects LOD Done.');

    except on E: Exception do
      wbProgressCallback('[' + aWorldspace.EditorID + '] Objects LOD generation error: ' + E.Message);
    end;

  finally
    slCache.Free;
    slRefs.Free;
    slLODMeshes.Free;
    slLODTextures.Free;
    slBGSM.Free;
    slExport.Free;
    Application.MainForm.Caption := Application.Title;
  end;
end;




end.
