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
  end;

  TDynBinBlockArray = array of TBinBlock;

  // Based on http://codeincomplete.com/posts/2011/5/7/bin_packing/
  TwbBinPacker = class
  private
    fNodes: array of TBinNode;
    fWidth, fHeight: Integer;
    fPaddingX: Integer;
    fPaddingY: Integer;
    fRoot: PBinNode;
  protected
    function AddNode: PBinNode;
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
    function BlockForCell(x, y, LODLevel: Integer): TwbGridCell;
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

  TwbLodTES5Tree = record
    BillboardName: string;
    CRC32: Integer;
    Width, Height: Single;
  end;

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
  public
    constructor Create(WorldspaceID: string);
    destructor Destroy; override;
    procedure LoadFromData(aData: TBytes);
    procedure SaveToFile(aFileName: string);
    procedure LoadAtlas(aData: TBytes);
    procedure SaveFromAtlas(aIndex: Integer; aFileName: string);
    procedure CopyFromAtlas(aIndex: Integer; var Img: TImageData; ImgX, ImgY: Integer);
    property WorldspaceID: string read fWorldspaceID write fWorldspaceID;
    property ListFileName: string read GetListFileName;
    property AtlasFileName: string read GetAtlasFileName;
    property TreesListCount: Integer read GetTreesListCount;
    property TreesList[Index: Integer]: TwbLodTES5TreeType read GetTreesList;// default;
    property AtlasRect[Index: Integer]: TAtlasRect read GetAtlasRect;
    property Atlas: TImageData read fAtlas;
  end;

  // handling BTT file
  TwbLodTES5TreeBlock = record
    TreeList: TwbLodTES5TreeList;
    Cell: TwbGridCell;
    LODLevel: Integer;
    Types: array of Integer;
    Refs: array of array of TwbLodTES5TreeRef;
    function GetBlockFileName: string;
    procedure Init(Trees: TwbLodTES5TreeList; CellX, CellY: Integer;
      aLODLevel: Integer = 4);
    procedure Clear;
    procedure LoadFromData(aData: TBytes);
    procedure SaveToFile(aFileName: string);
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

function TwbLodSettings.BlockForCell(x, y, LODLevel: Integer): TwbGridCell;
begin
  Result.x := SWCell.x + ((x - SWCell.x) div LODLevel) * LODLevel;
  Result.y := SWCell.y + ((y - SWCell.y) div LODLevel) * LODLevel;
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

function TwbBinPacker.AddNode: PBinNode;
begin
  SetLength(fNodes, Succ(Length(fNodes)));
  Result := @fNodes[Pred(Length(fNodes))];
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
  node^.down := AddNode;
  node^.down^.x := node^.x;
  node^.down^.y := node^.y + h + fPaddingY;
  node^.down^.w := node^.w;
  node^.down^.h := node^.h - h - fPaddingY;
  node^.right := AddNode;
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
  SetLength(fNodes, 0);
  fRoot := AddNode;
  fRoot^.w := fWidth;
  fRoot^.h := fHeight;
  MaxSideSort(Blocks);
  for i := 0 to Pred(Length(Blocks)) do begin
    node := FindNode(fRoot, Blocks[i].w, Blocks[i].h);
    if Assigned(node) then
      node := SplitNode(node, Blocks[i].w, Blocks[i].h);

    if Assigned(node) then begin
      Blocks[i].x := node^.x;
      Blocks[i].y := node^.y;
      Blocks[i].fit := True;
    end else
      Result := False;
  end;
end;

{============================== Skyrim LOD ===================================}

{ TwbLodTES5TreeList }

constructor TwbLodTES5TreeList.Create(WorldspaceID: string);
begin
  fWorldspaceID := WorldspaceID;
  if fWorldspaceID = '' then
    fWorldspaceID := 'Tamriel';
end;

destructor TwbLodTES5TreeList.Destroy;
begin
  if fAtlas.Format <> ifUnknown then
    FreeImage(fAtlas);

  inherited;
end;

function TwbLodTES5TreeList.GetListFileName: string;
begin
  Result := 'meshes\terrain\' + fWorldspaceID + '\trees\' + fWorldspaceID + '.lst';
end;

function TwbLodTES5TreeList.GetAtlasFileName: string;
begin
  Result := 'textures\terrain\' + fWorldspaceID + '\trees\' + fWorldspaceID + 'TreeLod.dds';
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


{ TwbLodTES5TreeBlock }

procedure TwbLodTES5TreeBlock.Init(Trees: TwbLodTES5TreeList; CellX, CellY: Integer;
  aLODLevel: Integer = 4);
begin
  TreeList := Trees;
  Cell.x := CellX;
  Cell.y := CellY;
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
    Types[i] := PInteger(@aData[p])^;
    Inc(p, SizeOf(Integer));
    if p >= Length(aData) then
      raise Exception.Create(sError);

    // number of trees
    TreesNum := PInteger(@aData[p])^;
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
      Write(Types[i], SizeOf(Types[i]));
      Value := Length(Refs[i]);
      Write(Value, SizeOf(Value));
      Write(Refs[i][0], SizeOf(TwbLodTES5TreeRef) * Length(Refs[i]));
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

end.
