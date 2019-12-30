{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbNifScanner;

interface

uses
  SysUtils,
  Classes;

const
  SLSF1_Environment_Mapping = 1 shl 7;
  SLSF2_Vertex_Colors = 1 shl 5;

type
  TNifCheck = (ncBSX, ncStringIndex, ncMultiName, ncShader, ncVertexColor);
  TNifCheckSet = set of TNifCheck;

  TNodeRef = Integer;
  TNiFlags = ShortInt;
  TNiFloat = Single;
  TNiVector3 = packed record
    X, Y, Z: TNiFloat;
  end;
  TNiMatrix33 = array [0..2, 0..2] of TNiFloat;
  TNiColor4 = packed record
    R, G, B, A: TNiFloat;
  end;
  TNiTexCoord = packed record
    X, Y: TNiFloat;
  end;

  TNiFile = class;

  TBaseNiNode = class
  protected
    NiFile: TNiFile;
    data: TBinaryReader;
    // read string terminated by $0A
    function ReadLineString: string;
    // read null terminated string, 1 byte prefix with length including null
    function ReadShortString: string;
    // read string with 4 byte prefix
    function ReadSizedString: string;
    // read string or string by index
    function ReadString: string;
  public
    Index: Integer;
    Name: string;
    constructor Create(aNiFile: TNiFile; aIndex: Integer); virtual;
    destructor Destroy; override;
    procedure Load(aStream: TStream); virtual;
  end;

  TNiHeader = class(TBaseNiNode)
  public
    Version: Cardinal;
    UserVersion, UserVersion2: Cardinal;
    Endianness: Byte;
    Creator, ExportInfo1, ExportInfo2: string;
    NodeCount: Integer;
    NodeTypes: array of string;
    NodeTypeIndex: array of word;
    NodeSizes: array of Cardinal;
    NodeStrings: array of string;
    NodeOffsets: array of integer;
    constructor Create(aNiFile: TNiFile; aIndex: Integer); override;
    procedure Load(aStream: TStream); override;
  end;

  TNodeNiNode = class(TBaseNiNode)
  public
    procedure Load(aStream: TStream); override;
  end;

  TNodeBSFadeNode = class(TBaseNiNode)
  public
    procedure Load(aStream: TStream); override;
  end;

  TNodeBSXFlags = class(TBaseNiNode)
  public
    Flags: Cardinal;
    procedure Load(aStream: TStream); override;
  end;

  TNodeNiAlphaProperty = class(TBaseNiNode)
  public
    procedure Load(aStream: TStream); override;
  end;

  TNodeBSShaderTextureSet = class(TBaseNiNode)
  public
    Textures: array of string;
    procedure Load(aStream: TStream); override;
  end;

  TNodeBSLightingShaderProperty = class(TBaseNiNode)
  public
    SkyrimShaderType: Cardinal;
    ExtraData: array of TNodeRef;
    Controller: TNodeRef;
    ShaderFlags1: Cardinal;
    ShaderFlags2: Cardinal;
    UVOffset: TNiTexCoord;
    UVScale: TNiTexCoord;
    TextureSet: TNodeRef;
    procedure Load(aStream: TStream); override;
  end;

  TNodeBSEffectShaderProperty = class(TBaseNiNode)
  public
    SourceTexture: string;
    GreyScaleTexture: string;
    procedure Load(aStream: TStream); override;
  end;

  TNodeNiTriShape = class(TBaseNiNode)
  public
    ExtraData: array of TNodeRef;
    Controller: TNodeRef;
    Flags: TNiFlags;
    UnknownShort1: word;
    Translation: TNiVector3;
    Rotation: TNiMatrix33;
    Scale: TNiFloat;
    Properties: array of TNodeRef;
    CollisionObject: TNodeRef;
    ShapeData: TNodeRef;
    SkinInstance: TNodeRef;
    MaterialName: array of string;
    MaterialExtraData: array of integer;
    ActiveMaterial: integer;
    DirtyFlag: Boolean;
    BSProperties: array of TNodeRef;
    procedure Load(aStream: TStream); override;
  end;

  TNodeNiTriShapeData = class(TBaseNiNode)
  public
    NumVertices: word;
    KeepFlags: Byte;
    CompressFlags: Byte;
    HasVertices: Boolean;
    Vertices: array of TNiVector3;
    BSNumUVSets: word;
    SkyrimMaterial: Cardinal;
    HasNormals: Boolean;
    Normals: array of TNiVector3;
    Tangents: array of TNiVector3;
    Bitangents: array of TNiVector3;
    Center: TNiVector3;
    Radius: TNiFloat;
    HasVertexColors: Boolean;
    VertexColors: array of TNiColor4;
    UVSets: array of array of TNiTexCoord;
    procedure Load(aStream: TStream); override;
  end;

  TNodeNiTriStrips = class(TNodeNiTriShape)
  public
    procedure Load(aStream: TStream); override;
  end;

  TNodeBSLODTriShape = class(TNodeNiTriShape)
  public
    procedure Load(aStream: TStream); override;
  end;

  TNiFile = class
  public
    Header: TNiHeader;
    Nodes: array of TBaseNiNode;
    constructor Create;
    destructor Destroy; override;
    procedure Load(aStream: TStream);
    function GetNode(aRef: TNodeRef): TBaseNiNode;
  end;

function NifBlockList(aNifData: TBytes; aBlocks: TStrings): Boolean;
function NifTextures(aNifData: TBytes; aTextures: TStrings): Boolean;
function NifTexturesUVRange(aNifData: TBytes; UVRange: Single; aTextures: TStrings): Boolean;

var
  wbWarningCallback: procedure(aCheck: TNifCheck; aNode: TBaseNiNode; aMessage: string);


implementation

//===========================================================================
function TBaseNiNode.ReadLineString: string;
var
  c: Char;
begin
  Result := '';
  repeat
    c := Char(data.ReadByte);
    if c <> #$0A then
      Result := Result + c;
  until c = #$0A;
end;

//===========================================================================
function TBaseNiNode.ReadShortString: string;
var
  i: byte;
begin
  i := data.ReadByte;
  if i > 0 then begin
    Result := TEncoding.ASCII.GetString(data.ReadBytes(i - 1));
    data.ReadByte; // skip null
  end else
    Result := '';
end;

//===========================================================================
function TBaseNiNode.ReadSizedString: string;
var
  i: integer;
begin
  i := data.ReadInt32;
  if i > 4000 then
    raise Exception.Create('Probably invalid Nif file, SizedString length > 4000');

  Result := TEncoding.ASCII.GetString(data.ReadBytes(i));
end;

//===========================================================================
function TBaseNiNode.ReadString: string;
var
  i: Integer;
begin
  // string is an index into strings table if version >= 20.1.0.3
  if NiFile.Header.Version >= $14010003 then begin
    i := data.ReadInt32;
    if (Length(NiFile.Header.NodeStrings) <> 0) and (i >= Low(NiFile.Header.NodeStrings)) and (i <= High(NiFile.Header.NodeStrings)) then
      Result := NiFile.Header.NodeStrings[i]
    else begin
      if Assigned(wbWarningCallback) and (i <> -1) then
        wbWarningCallback(ncStringIndex, Self, 'String index ' + IntToStr(i) + ' out of range in NiHeader strings table');
      Result := '';
    end;
  end else
    Result := ReadSizedString;
end;

//===========================================================================
procedure TBaseNiNode.Load(aStream: TStream);
begin
  if not Assigned(aStream) then
    raise Exception.Create('Invalid data stream');

  data := TBinaryReader.Create(aStream);
end;

//===========================================================================
constructor TBaseNiNode.Create(aNiFile: TNiFile; aIndex: Integer);
begin
  NiFile := aNiFile;
  Index := aIndex;
end;

//===========================================================================
destructor TBaseNiNode.Destroy;
begin
  if Assigned(data) then
    data.Free;
end;

//===========================================================================
constructor TNiHeader.Create(aNiFile: TNiFile; aIndex: Integer);
begin
  inherited;
end;

//===========================================================================
procedure TNiHeader.Load(aStream: TStream);
const
  NifMagic = 'Gamebryo File Format';
var
  i, j, n: Cardinal;
begin
  inherited;

  if TEncoding.ASCII.GetString(data.ReadBytes(Length(NifMagic))) <> NifMagic then
    raise Exception.Create('Invalid nif file signature');

  // skip the rest of header
  ReadLineString;

  // Version, Skyrim is $14020007
  Version := data.ReadUInt32;
  if Version < $14000000 then
    raise Exception.Create('Unsupported Nif file version');

  // Endianness
  if Version >= $14000004 then
    Endianness := data.ReadByte;

  // User version
  UserVersion := data.ReadUInt32;

  // Number of nodes
  NodeCount := data.ReadInt32;
  if NodeCount > 5000 then
    raise Exception.Create('Probably invalid Nif file, NifNumBlocks > 5000');

  // User version 2
  UserVersion2 := data.ReadUInt32;

  // Export Info \ Creator
  Creator := ReadShortString;
  // Export Info \ Export Info 1
  ReadShortString;
  // Export Info \ Export Info 2
  ReadShortString;

  // Num Block Types
  n := data.ReadUInt16;
  if n > 1000 then
    raise Exception.Create('Probably invalid Nif file, NifNumBlockTypes > 1000');

  if n > 0 then begin
    SetLength(NodeTypes, n);
    for i := Low(NodeTypes) to High(NodeTypes) do
      NodeTypes[i] := ReadSizedString;
  end;

  // block type index
  SetLength(NodeTypeIndex, NodeCount);
  for i := Low(NodeTypeIndex) to High(NodeTypeIndex) do
    NodeTypeIndex[i] := data.ReadUInt16;

  // Block sizes
  if Version >= $14020007 then begin
    SetLength(NodeSizes, NodeCount);
    for i := Low(NodeSizes) to High(NodeSizes) do
      NodeSizes[i] := data.ReadUInt32;
  end;

  // Oblivion meshes
  if Length(NodeSizes) = 0 then
    //raise Exception.Create('Unsupported Nif version, no block sizes data');
    Exit;

  // strings in header
  if Version >= $14010003 then begin
    n := data.ReadUInt32;
    data.ReadUInt32; // skip max string length
    if n > 0 then begin
      SetLength(NodeStrings, n);
      for i := Low(NodeStrings) to High(NodeStrings) do
        NodeStrings[i] := ReadSizedString;
    end;
  end;
  data.ReadUInt32; // skip Unknown Int 2

  // calculate blocks offsets
  SetLength(NodeOffsets, NodeCount);
  j := aStream.Position;
  for i := Low(NodeOffsets) to High(NodeOffsets) do begin
    NodeOffsets[i] := j;
    j := j + NodeSizes[i];
  end;
end;

//===========================================================================
procedure TNodeNiNode.Load(aStream: TStream);
begin
  inherited;
  Name := ReadString;
end;

//===========================================================================
procedure TNodeBSFadeNode.Load(aStream: TStream);
begin
  inherited;
  Name := ReadString;
end;

//===========================================================================
procedure TNodeBSXFlags.Load(aStream: TStream);
begin
  inherited;
  Name := ReadString;
  Flags := data.ReadUInt32;
end;

//===========================================================================
procedure TNodeNiAlphaProperty.Load(aStream: TStream);
begin
  inherited;
  Name := ReadString;
end;

//===========================================================================
procedure TNodeBSShaderTextureSet.Load(aStream: TStream);
var
  i, n: Cardinal;
begin
  inherited;
  n := data.ReadUInt32;
  SetLength(Textures, n);
  for i := Low(Textures) to High(Textures) do
    Textures[i] := ReadSizedString;
end;

//===========================================================================
procedure TNodeBSLightingShaderProperty.Load(aStream: TStream);
var
  i, n: Cardinal;
begin
  inherited;
  SkyrimShaderType := data.ReadUInt32;
  Name := ReadString;
  n := data.ReadUInt32; // Num Extra Data List
  if n > 0 then begin
    SetLength(ExtraData, n);
    for i := Low(ExtraData) to High(ExtraData) do
      ExtraData[i] := data.ReadInt32;
  end;
  Controller := data.ReadInt32;
  if NiFile.Header.UserVersion = 12 then begin
    ShaderFlags1 := data.ReadInt32;
    ShaderFlags2 := data.ReadInt32;
  end;
  aStream.Read(UVOffset, SizeOf(UVOffset));
  aStream.Read(UVScale, SizeOf(UVScale));
  TextureSet := data.ReadInt32;
  // don't need the rest
end;


//===========================================================================
procedure TNodeBSEffectShaderProperty.Load(aStream: TStream);
var
  n: Cardinal;
begin
  inherited;
  Name := ReadString;
  n := data.ReadUInt32; // Num Extra Data List
  data.ReadBytes(SizeOf(Integer) * n); // Extra Data List
  data.ReadInt32; // Controller
  data.ReadInt32; // Shader Flags 1
  data.ReadInt32; // Shader Flags 2
  data.ReadBytes(8); // UV Offset
  data.ReadBytes(8); // UV Scale
  SourceTexture := ReadSizedString;
  data.ReadInt32; // Texture clamp mode
  data.ReadBytes(SizeOf(Single) * 10); // different falloff and emissive data
  GreyScaleTexture := ReadSizedString;
end;

//===========================================================================
procedure TNodeNiTriShape.Load(aStream: TStream);
var
  i, n: Cardinal;
begin
  inherited;
  Name := ReadString;
  n := data.ReadUInt32; // Num Extra Data List
  if n > 0 then begin
    SetLength(ExtraData, n);
    for i := Low(ExtraData) to High(ExtraData) do
      ExtraData[i] := data.ReadInt32;
  end;
  Controller := data.ReadInt32;
  Flags := data.ReadUInt16;
  if (NiFile.Header.Version >= $14020007) and (NiFile.Header.UserVersion >= 11) and (NiFile.Header.UserVersion2 >= 26) then
    UnknownShort1 := data.ReadUInt16;
  aStream.Read(Translation, SizeOf(Translation));
  aStream.Read(Rotation, SizeOf(Rotation));
  Scale := data.ReadSingle;
  if (NiFile.Header.Version < $14020007) or (NiFile.Header.UserVersion <= 11) then begin
    n := data.ReadUInt32; // Num Properties
    if n > 0 then begin
      SetLength(Properties, n);
      for i := Low(Properties) to High(Properties) do
        Properties[i] := data.ReadInt32;
    end;
  end;
  CollisionObject := data.ReadInt32;
  ShapeData := data.ReadInt32;
  SkinInstance := data.ReadInt32;
  if NiFile.Header.Version >= $14020007 then begin
    n := data.ReadUInt32; // Num Materials
    if n > 0 then begin
      SetLength(MaterialName, n);
      for i := Low(MaterialName) to High(MaterialName) do
        MaterialName[i] := ReadString;
      SetLength(MaterialExtraData, n);
      for i := Low(MaterialExtraData) to High(MaterialExtraData) do
        MaterialExtraData[i] := data.ReadInt32;
    end;
    ActiveMaterial := data.ReadInt32;
    DirtyFlag := data.ReadBoolean;
    SetLength(BSProperties, 2);
    for i := Low(BSProperties) to High(BSProperties) do
      BSProperties[i] := data.ReadInt32;
  end;
end;

//===========================================================================
procedure TNodeNiTriShapeData.Load(aStream: TStream);
var
  i, n: Cardinal;
begin
  inherited;
  data.ReadInt32;
  NumVertices := data.ReadUInt16;
  KeepFlags := data.ReadByte;
  CompressFlags := data.ReadByte;
  HasVertices := data.ReadBoolean;
  if HasVertices then begin
    SetLength(Vertices, NumVertices);
    aStream.Read(Vertices[0], SizeOf(TNiVector3) * NumVertices);
  end;
  if (NiFile.Header.Version >= $14020007) and (NiFile.Header.UserVersion >= 11) then
    BSNumUVSets := data.ReadUInt16;
  if (NiFile.Header.Version >= $14020007) and (NiFile.Header.UserVersion = 12) then
    SkyrimMaterial := data.ReadUInt32;
  HasNormals := data.ReadBoolean;
  if HasNormals then begin
    SetLength(Normals, NumVertices);
    aStream.Read(Normals[0], SizeOf(TNiVector3) * NumVertices);
    if BSNumUVSets and 61440 <> 0 then begin
      SetLength(Tangents, NumVertices);
      aStream.Read(Tangents[0], SizeOf(TNiVector3) * NumVertices);
    end;
    if BSNumUVSets and 61440 <> 0 then begin
      SetLength(Bitangents, NumVertices);
      aStream.Read(Bitangents[0], SizeOf(TNiVector3) * NumVertices);
    end;
  end;
  aStream.Read(Center, SizeOf(Center));
  Radius := data.ReadSingle;
  HasVertexColors := data.ReadBoolean;
  if HasVertexColors then begin
    SetLength(VertexColors, NumVertices);
    aStream.Read(VertexColors[0], SizeOf(TNiColor4) * NumVertices);
  end;
  // number of uv sets
  n := BSNumUVSets and 1;
  if n > 0 then begin
    SetLength(UVSets, n);
    for i := Low(UVSets) to High(UVSets) do begin
      SetLength(UVSets[i], NumVertices);
      aStream.Read(UVSets[i][0], SizeOf(TNiTexCoord) * NumVertices);
    end;
  end;
  // don't need the rest
end;

//===========================================================================
procedure TNodeNiTriStrips.Load(aStream: TStream);
begin
  // same as NiTriShape loader
  inherited;
end;

//===========================================================================
procedure TNodeBSLODTriShape.Load(aStream: TStream);
begin
  // same as NiTriShape loader
  inherited;
end;

//===========================================================================
constructor TNiFile.Create;
begin
  //
end;

//===========================================================================
destructor TNiFile.Destroy;
var
  i: integer;
begin
  Header.Free;
  if Length(Nodes) > 0 then
    for i := Low(Nodes) to High(Nodes) do
      if Assigned(Nodes[i]) then
        Nodes[i].Free;
end;

//===========================================================================
function TNiFile.GetNode(aRef: TNodeRef): TBaseNiNode;
var
  i: integer;
begin
  Result := nil;
  for i := Low(Nodes) to High(Nodes) do
    if Assigned(Nodes[i]) and (Nodes[i].Index = aRef) then begin
      Result := Nodes[i];
      Break;
    end;
end;

//===========================================================================
procedure TNiFile.Load(aStream: TStream);
var
  i: integer;
  NodeType: string;
begin
  Header := TNiHeader.Create(Self, Low(Integer));
  Header.Load(aStream);

  if Length(Header.NodeSizes) = 0 then
    Exit;

  SetLength(Nodes, Header.NodeCount);
  for i := Low(Nodes) to High(Nodes) do begin
    NodeType := Header.NodeTypes[Header.NodeTypeIndex[i]];
    aStream.Position := Header.NodeOffsets[i];
    if NodeType = 'NiNode' then
      Nodes[i] := TNodeNiNode.Create(Self, i)
    else if NodeType = 'BSXFlags' then
      Nodes[i] := TNodeBSXFlags.Create(Self, i)
    else if NodeType = 'NiTriShape' then
      Nodes[i] := TNodeNiTriShape.Create(Self, i)
    else if NodeType = 'NiTriShapeData' then
      Nodes[i] := TNodeNiTriShapeData.Create(Self, i)
    else if NodeType = 'BSLODTriShape' then
      Nodes[i] := TNodeBSLODTriShape.Create(Self, i)
    else if NodeType = 'NiTriStrips' then
      Nodes[i] := TNodeNiTriStrips.Create(Self, i)
    else if NodeType = 'BSFadeNode' then
      Nodes[i] := TNodeBSFadeNode.Create(Self, i)
    else if NodeType = 'BSShaderTextureSet' then
      Nodes[i] := TNodeBSShaderTextureSet.Create(Self, i)
    else if NodeType = 'BSLightingShaderProperty' then
      Nodes[i] := TNodeBSLightingShaderProperty.Create(Self, i)
    else if NodeType = 'BSEffectShaderProperty' then
      Nodes[i] := TNodeBSEffectShaderProperty.Create(Self, i)
    else if NodeType = 'NiAlphaProperty' then
      Nodes[i] := TNodeNiAlphaProperty.Create(Self, i)
    else
      Nodes[i] := TBaseNiNode.Create(Self, i);

    if Assigned(Nodes[i]) then
      Nodes[i].Load(aStream);
  end;
end;

//===========================================================================
procedure StringsRemoveEmptyAndTrim(sl: TStrings);
var
  i: integer;
  s: string;
begin
  // remove empty lines, trim others
  for i := Pred(sl.Count) downto 0 do begin
    s := Trim(sl[i]);
    if s = '' then
      sl.Delete(i)
    else
      sl[i] := s;
  end;
end;

//===========================================================================
// Get the list of all blocks: index, name and type
function NifBlockList(aNifData: TBytes; aBlocks: TStrings): Boolean;
var
  bs: TBytesStream;
  nif: TNiFile;
  n: TBaseNiNode;
  i: integer;
begin
  Result := False;
  if Assigned(aBlocks) then
    aBlocks.Clear
  else
    Exit;

  bs := TBytesStream.Create(aNifData);
  nif := TNiFile.Create;
  try
    nif.Load(bs);
    for i := Low(nif.Nodes) to High(nif.Nodes) do begin
      n := nif.Nodes[i];
      if not Assigned(n) then
        Continue;
      aBlocks.AddObject(n.Name + '=' + nif.Header.NodeTypes[nif.Header.NodeTypeIndex[i]], Pointer(n.Index));
    end;
    StringsRemoveEmptyAndTrim(aBlocks);
    Result := True;
  finally
    nif.Free;
    bs.Free;
  end;
end;

//===========================================================================
// Get the list of all textures from Nif data into aTextures
// from all nif nodes that can contain texture file names
function NifTextures(aNifData: TBytes; aTextures: TStrings): Boolean;
var
  bs: TBytesStream;
  nif: TNiFile;
  n: TBaseNiNode;
  i, j: integer;
begin
  Result := False;

  if Length(aNifData) = 0 then
    Exit;

  if Assigned(aTextures) then
    aTextures.Clear
  else
    Exit;

  bs := TBytesStream.Create(aNifData);
  nif := TNiFile.Create;
  try
    nif.Load(bs);
    for i := Low(nif.Nodes) to High(nif.Nodes) do begin
      n := nif.Nodes[i];
      if not Assigned(n) then
        Continue;
      if n is TNodeBSShaderTextureSet then begin
        for j := Low(TNodeBSShaderTextureSet(n).Textures) to High(TNodeBSShaderTextureSet(n).Textures) do
          aTextures.AddObject(TNodeBSShaderTextureSet(n).Textures[j], Pointer(j));
      end
      else if n is TNodeBSEffectShaderProperty then begin
        aTextures.Add(TNodeBSEffectShaderProperty(n).SourceTexture);
        aTextures.Add(TNodeBSEffectShaderProperty(n).GreyScaleTexture);
      end;
    end;
    StringsRemoveEmptyAndTrim(aTextures);
    Result := True;
  finally
    nif.Free;
    bs.Free;
  end;
end;

//===========================================================================
// Get the list of textures within UV range from Nif data into aTextures
function NifTexturesUVRange(aNifData: TBytes; UVRange: Single; aTextures: TStrings): Boolean;
var
  bs: TBytesStream;
  nif: TNiFile;
  n: TBaseNiNode;
  TriShape: TNodeNiTriShape;
  TriShapeData: TNodeNiTriShapeData;
  BSShader: TNodeBSLightingShaderProperty;
  BSTexture: TNodeBSShaderTextureSet;
  i, j, k: integer;
  tiled: Boolean;
begin
  Result := False;

  if Length(aNifData) = 0 then
    Exit;

  if Assigned(aTextures) then
    aTextures.Clear
  else
    Exit;

  bs := TBytesStream.Create(aNifData);
  nif := TNiFile.Create;
  try
    nif.Load(bs);
    for i := Low(nif.Nodes) to High(nif.Nodes) do begin
      n := nif.Nodes[i];
      if not Assigned(n) then
        Continue;

      if n is TNodeNiTriShape then begin
        TriShape := TNodeNiTriShape(n);
        TriShapeData := TNodeNiTriShapeData(nif.GetNode(TriShape.ShapeData));
        if not Assigned(TriShapeData) then
          Continue;
        if Length(TriShape.BSProperties) = 0 then
          Continue;
        // check UVs
        if (TriShapeData.NumVertices = 0) or (Length(TriShapeData.UVSets) = 0) then
          Continue;
        tiled := False;
        for j := Low(TriShapeData.UVSets) to High(TriShapeData.UVSets) do
          if not tiled then
            for k := Low(TriShapeData.UVSets[j]) to High(TriShapeData.UVSets[j]) do
              if (TriShapeData.UVSets[j][k].X < -UVRange) or
                 (TriShapeData.UVSets[j][k].X > UVRange) or
                 (TriShapeData.UVSets[j][k].Y < -UVRange) or
                 (TriShapeData.UVSets[j][k].Y > UVRange)
              then begin
                tiled := True;
                Break;
              end;

        // skip tiled textures
        if tiled then
          Continue;

        BSShader := nil;
        for j := Low(TriShape.BSProperties) to High(TriShape.BSProperties) do begin
          n := nif.GetNode(TriShape.BSProperties[j]);
          if n is TNodeBSLightingShaderProperty then begin
            BSShader := TNodeBSLightingShaderProperty(n);
            Break;
          end;
        end;

        if not Assigned(BSShader) then
          Continue;

        n := nif.GetNode(BSShader.TextureSet);
        if n is TNodeBSShaderTextureSet then begin
          BSTexture := TNodeBSShaderTextureSet(n);
          if Length(BSTexture.Textures) > 0 then
            for j := Low(BSTexture.Textures) to High(BSTexture.Textures) do
              aTextures.AddObject(BSTexture.Textures[j], Pointer(j));
        end;
      end;
    end;
    StringsRemoveEmptyAndTrim(aTextures);
    Result := True;
  finally
    nif.Free;
    bs.Free;
  end;
end;




end.
