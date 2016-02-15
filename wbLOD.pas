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
  Classes,
  SysUtils,
  wbInterface,
  wbNifScanner,
  ImagingTypes,
  ImagingFormats,
  ImagingCanvases,
  Imaging;

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
    SWCell: TwbGridCell;
    Stride, LODLevelMin, LODLevelMax: Integer;
    procedure Init;
    function GetSize: Integer;
    function BlockForCell(Cell: TwbGridCell; LODLevel: Integer): TwbGridCell;
    procedure LoadFromData(aData: TBytes);
    property Size: Integer read GetSize;
  end;

  TGameResourceType = (resMesh, resTexture, resSound, resMusic);

  // source texture for atlas builder
  TSourceAtlasTexture = record
    Name: string;
    Name_n: string;
    Image: TImageData;
    Image_n: TImageData;
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
    RefFormID: Cardinal;
    Unknown1: Integer;
    Unknown2: Integer;
  end;

  // tree data when building lod
  TwbLodTES5Tree = record
    Index : Integer;
    FormID: Cardinal;
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
    function GetTreeByFormID(aFormID: Cardinal): PwbLodTES5Tree;
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
    function BillboardFileName(aFileName, aModelName: string; aFormID: Cardinal): string;
    function AddTree(aFileName, aModelName: string; aFormID: Cardinal; aWidth, aHeight: Single): PwbLodTES5Tree;
    property WorldspaceID: string read fWorldspaceID write fWorldspaceID;
    property ListFileName: string read GetListFileName;
    property AtlasFileName: string read GetAtlasFileName;
    property TreesListCount: Integer read GetTreesListCount;
    property TreesList[Index: Integer]: TwbLodTES5TreeType read GetTreesList;
    property AtlasRect[Index: Integer]: TAtlasRect read GetAtlasRect;
    property Atlas: TImageData read fAtlas;
    property TreeByFormID[aFormID: Cardinal]: PwbLodTES5Tree read GetTreeByFormID;
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
    function AddReference(aFormID: Cardinal; aTreeIndex: Integer;
      Pos: TwbVector; Scale: Single): Boolean;
    property FileName: string read GetBlockFileName;
  end;

function wbLODSettingsFileName(WorldspaceID: string): string;
function wbLODTreeBlockFileExt: string;
function wbNormalizeResourceName(aName: string; aResType: TGameResourceType): string;
function wbDefaultNormalTexture(aGameMode: TwbGameMode): string;
procedure wbPrepareImageAlpha(img: TImageData; fmt: TImageFormat);
procedure wbBuildAtlas(var Images: TSourceAtlasTextures; aWidth, aHeight: Integer;
  aName: string; fmtDiffuse, fmtNormal: TImageFormat);


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

implementation

uses
  Math;

function wbLODSettingsFileName(WorldspaceID: string): string;
begin
  if wbGameMode = gmTES4 then
    Result := ''
  else if wbGameMode in [gmFO3, gmFNV] then
    Result := 'lodsettings\' + WorldspaceID + '.dlodsettings'
  else
    Result := 'lodsettings\' + WorldspaceID + '.lod';
end;

function wbLODTreeBlockFileExt: string;
begin
  if wbGameMode = gmTES5 then
    Result := 'btt'
  else if wbGameMode in [gmFO3, gmFNV] then
    Result := 'dtl'
  else
    Result := '';
end;

function wbDefaultNormalTexture(aGameMode: TwbGameMode): string;
begin
  if aGameMode = gmFO4 then
    Result := 'textures\shared\flatflat_n.dds'
  else if aGameMode = gmTES5 then
    Result := 'textures\default_n.dds'
  else if aGameMode in [gmFO3, gmFNV] then
    Result := 'textures\shared\shadefade01_n.dds'
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
  if wbGameMode in [gmFO3, gmFNV] then begin
    if Length(aData) <> 24 then
      raise Exception.Create(sError);
    LODLevelMin := PInteger(@aData[0])^;
    LODLevelMax := PInteger(@aData[4])^;
    Stride := PInteger(@aData[8])^;
    SWCell.x := PSmallInt(@aData[12])^;
    SWCell.y := PSmallInt(@aData[14])^;
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
  if wbGameMode = gmTES5 then
    Result := 'Meshes\Terrain\' + fWorldspaceID + '\Trees\' + fWorldspaceID + '.lst'
  else if wbGameMode in [gmFO3, gmFNV] then
    Result := 'Meshes\Landscape\LOD\' + fWorldspaceID + '\Trees\TreeTypes.lst'
  else
    Result := '';
end;

function TwbLodTES5TreeList.GetAtlasFileName: string;
begin
  if wbGameMode = gmTES5 then
    Result := 'Textures\Terrain\' + fWorldspaceID + '\Trees\' + fWorldspaceID + 'TreeLod.dds'
  else if wbGameMode in [gmFO3, gmFNV] then begin
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

function TwbLodTES5TreeList.GetTreeByFormID(aFormID: Cardinal): PwbLodTES5Tree;
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

function TwbLodTES5TreeList.BillboardFileName(aFileName, aModelName: string; aFormID: Cardinal): string;
begin
  Result := Format('Textures\Terrain\LODGen\%s\%s_%s.dds', [
    aFileName,
    ChangeFileExt(ExtractFileName(aModelName), ''),
    IntToHex(aFormID and $FFFFFF, 8)
  ]);
end;

function TwbLodTES5TreeList.AddTree(aFileName, aModelName: string; aFormID: Cardinal; aWidth, aHeight: Single): PwbLodTES5Tree;
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

  if wbGameMode = gmTES5 then
    Result := 'meshes\terrain\%s\trees\%s.%d.%d.%d.' + wbLODTreeBlockFileExt
  else if wbGameMode in [gmFO3, gmFNV] then
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

function TwbLodTES5TreeBlock.AddReference(aFormID: Cardinal; aTreeIndex: Integer;
  Pos: TwbVector; Scale: Single): Boolean;
var
  i, j: integer;
begin
  // check that FormID number is not duplicate
  if (not TreeList.RefAllowDuplicates) and (TreeList.RefFormIDs.IndexOf(Pointer(aFormID and $00FFFFFF)) <> -1) then begin
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

  TreeList.RefFormIDs.Add(Pointer(aFormID and $00FFFFFF));
  Result := True;
end;

function wbNormalizeResourceName(aName: string; aResType: TGameResourceType): string;
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
    Result := 'music\' + Result;
end;

procedure wbPrepareImageAlpha(img: TImageData; fmt: TImageFormat);
var
  x, y: integer;
  c: TColor32Rec;
begin
  // Max alpha for formats saved without alpha, otherwise they will become black
  if fmt in [ifDXT1, ifR8G8B8] then begin
    for x := 0 to Pred(img.Width) do
      for y := 0 to Pred(img.Height) do begin
        c := GetPixel32(img, x, y);
        if c.A <> 255 then begin
          c.A := 255;
          SetPixel32(img, x, y, c);
        end;
      end;
  end;
end;

procedure wbBuildAtlas(var Images: TSourceAtlasTextures; aWidth, aHeight: Integer;
  aName: string; fmtDiffuse, fmtNormal: TImageFormat
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

        wbPrepareImageAlpha(atlas, fmtDiffuse);
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

end.
