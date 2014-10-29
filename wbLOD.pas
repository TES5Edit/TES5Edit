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
  ImagingTypes,
  ImagingFormats,
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
    procedure SaveFromAtlas(aIndex: Integer; aFileName: string);
    procedure CopyFromAtlas(aIndex: Integer; var Img: TImageData; ImgX, ImgY: Integer);
    function BuildAtlas(MaxAtlasSize: Integer): Boolean;
    function AddTree(aFileName, aModelName: string; aFormID: Cardinal; aWidth, aHeight: Single): PwbLodTES5Tree;
    property WorldspaceID: string read fWorldspaceID write fWorldspaceID;
    property ListFileName: string read GetListFileName;
    property AtlasFileName: string read GetAtlasFileName;
    property TreesListCount: Integer read GetTreesListCount;
    property TreesList[Index: Integer]: TwbLodTES5TreeType read GetTreesList;
    property AtlasRect[Index: Integer]: TAtlasRect read GetAtlasRect;
    property Atlas: TImageData read fAtlas;
    property TreeByFormID[aFormID: Cardinal]: PwbLodTES5Tree read GetTreeByFormID;
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
    procedure AddReference(aFormID: Cardinal; aTreeIndex: Integer;
      Pos: TwbVector; Scale: Single);
    property FileName: string read GetBlockFileName;
  end;

function wbLODSettingsFileName(WorldspaceID: string): string;

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
    if Length(aData) <> 16 then
      raise Exception.Create(sError);
    Stride := PInteger(@aData[0])^;
    LODLevelMin := PInteger(@aData[4])^;
    LODLevelMax := PInteger(@aData[8])^;
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
  inherited;
end;

function TwbLodTES5TreeList.GetListFileName: string;
begin
  Result := 'Meshes\Terrain\' + fWorldspaceID + '\Trees\' + fWorldspaceID + '.lst';
end;

function TwbLodTES5TreeList.GetAtlasFileName: string;
begin
  Result := 'Textures\Terrain\' + fWorldspaceID + '\Trees\' + fWorldspaceID + 'TreeLod.dds';
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
  Result^.BillBoard := Format('Textures\Terrain\LODGen\%s\%s_%s.dds', [
    aFileName,
    ChangeFileExt(ExtractFileName(aModelName), ''),
    IntToHex(aFormID and $FFFFFF, 8)
  ]);
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
  Result := Format('meshes\terrain\%s\trees\%s.%d.%d.%d.btt', [
    TreeList.WorldspaceID,
    TreeList.WorldspaceID,
    LODLevel,
    Cell.x,
    Cell.y
  ]);
end;

procedure TwbLodTES5TreeBlock.LoadFromData(aData: TBytes);
const
  sError = 'Invalid BTT file';
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

procedure TwbLodTES5TreeBlock.AddReference(aFormID: Cardinal; aTreeIndex: Integer;
  Pos: TwbVector; Scale: Single);
var
  i, j: integer;
begin
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
end;

end.
