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

unit wbBSA;

{$I wbDefines.inc}

interface

uses
  Classes, SysUtils, IOUtils,
  wbInterface,
  ImagingDds;

function wbCreateContainerHandler: IwbContainerHandler;

implementation

uses
  wbStreams,
  zlibEx,
  lz4io;

const
  { https://github.com/Ethatron/bsaopt/blob/master/io/bsa.C }
  BSAHEADER_VERSION_OB = $67; // Oblivion
  BSAHEADER_VERSION_SK = $68; // Fallout3, Skyrim
  BSAHEADER_VERSION_SSE = $69; // Skyrim Special Edition
  BSAARCHIVE_COMPRESSFILES = $0004; // Whether the files are compressed in archive (invert file's compression flag)
  BSAARCHIVE_PREFIXFULLFILENAMES = $0100; // Whether the name is prefixed to the data?
  BSAFILE_COMPRESS = $40000000; // Whether the file is compressed
  { https://github.com/jonwd7/bae/blob/master/src/bsa.h }
  BA2HEADER_VERSION_FO4 = $01; // Fallout 4

type
  TwbContainerHandler = class(TInterfacedObject, IwbContainerHandler)
  private
    chContainers: array of IwbResourceContainer;
  protected
    procedure AddContainer(const aContainer: IwbResourceContainer);

    {---IwbContainerHandler---}
    procedure AddFolder(const aPath: string);
    procedure AddBSA(const aFileName: string);
    procedure AddBA2(const aFileName: string);

    function OpenResource(const aFileName: string): TDynResources;
    function OpenResourceData(const aContainerName, aFileName: string): TBytes;
    function ContainerExists(aContainerName: string): Boolean;
    procedure ContainerList(const aList: TStrings);
    procedure ContainerResourceList(const aContainerName: string; const aList: TStrings;
      const aFolder: string = '');
    function ResourceExists(const aFileName: string): Boolean;
    function ResolveHash(const aHash: Int64): TDynStrings;
    function ResourceCount(const aFileName: string; aContainers: TStrings = nil): Integer;
    procedure ResourceCopy(const aContainerName, aFileName, aPathOut: string);
  end;

  TwbBSAFileRec = record
    Name   : string;
    Hash   : Int64;
    Size   : Cardinal;
    Offset : Cardinal;
  end;

  TwbBSAFolderRec = record
    Name  : string;
    Hash  : Int64;
    Files : array of TwbBSAFileRec;
    Map   : TStringList;
  end;

  IwbBSAFileInternal = interface(IwbBSAFile)
    ['{A360B348-8F6B-4FC1-A869-9D5B833DCA5F}']
    function GetData(aOffset, aSize: Cardinal): TBytes;
  end;

  TwbBSAFile = class(TInterfacedObject, IwbResourceContainer, IwbBSAFile, IwbBSAFileInternal)
  private
    bfStream      : TwbReadOnlyCachedFileStream;
    bfFileName    : string;
    bfVersion     : Cardinal;
    bfOffset      : Cardinal;
    bfFlags       : Cardinal;
    bfFileFlags   : Cardinal;
    bfFolders     : array of TwbBSAFolderRec;
    bfFolderMap   : TStringList;

    procedure ReadDirectory;
  protected
    {---IwbResourceContainer---}
    function GetName: string;
    function OpenResource(const aFileName: string): IwbResource;
    function ResourceExists(const aFileName: string): Boolean;
    procedure ResourceList(const aList: TStrings; aFolder: string = '');
    procedure ResolveHash(const aHash: Int64; var Results: TDynStrings);

    {---IwbBSAFile---}
    function GetFileName: string;

    {---IwbBSAFileInternal---}
    function GetData(aOffset, aSize: Cardinal):TBytes;
  public
    constructor Create(const aFileName: string);
    destructor Destroy; override;
  end;

  TwbBSAResource = class(TInterfacedObject, IwbResource)
    brFile   : IwbBSAFileInternal;
    brOffset : Cardinal;
    brSize   : Cardinal;
  protected
    {---IwbResource---}
    function GetContainer: IwbResourceContainer;
    function GetData: TBytes;
  public
    constructor Create(aFile: TwbBSAFile; aSize, aOffset: Cardinal);
  end;


  TwbBA2TexChunkRec = record
    Size       : Cardinal;
    PackedSize : Cardinal;
    Offset     : Int64;
    StartMip   : Word;
    EndMip     : Word;
  end;

  TwbBA2FileRec = record
    Name       : string;
    NameHash   : Cardinal;
    DirHash    : Cardinal;
    Size       : Cardinal;
    PackedSize : Cardinal;
    Offset     : Int64;
    Height     : Word;
    Width      : Word;
    NumMips    : Byte;
    DXGIFormat : Byte;
    CubeMaps   : Word;
    TexChunks  : array of TwbBA2TexChunkRec;
  end;

  IwbBA2FileInternal = interface(IwbBA2File)
    ['{87D66150-746E-4B37-B295-45C4221CDCBE}']
    procedure ReadData(var Buffer; Offset: Int64; Count: Longint);
  end;

  TwbBA2File = class(TInterfacedObject, IwbResourceContainer, IwbBA2File, IwbBA2FileInternal)
  private
    bfStream      : TwbReadOnlyCachedFileStream;
    bfFileName    : string;
    bfVersion     : Cardinal;
    bfType        : TwbSignature;
    bfFiles       : array of TwbBA2FileRec;
    bfFolderMap   : TStringList;

    procedure ReadDirectory;
  protected
    {---IwbResourceContainer---}
    function GetName: string;
    function OpenResource(const aFileName: string): IwbResource;
    function ResourceExists(const aFileName: string): Boolean;
    procedure ResourceList(const aList: TStrings; aFolder: string = '');
    procedure ResolveHash(const aHash: Int64; var Results: TDynStrings);

    {---IwbBA2File---}
    function GetFileName: string;

    {---IwbBA2FileInternal---}
    procedure ReadData(var Buffer; Offset: Int64; Count: Longint);
  public
    constructor Create(const aFileName: string);
    destructor Destroy; override;
  end;

  TwbBA2Resource = class(TInterfacedObject, IwbResource)
    brFile    : IwbBA2FileInternal;
    brFileRec : TwbBA2FileRec;
  protected
    {---IwbResource---}
    function GetContainer: IwbResourceContainer;
    function GetData: TBytes;
  public
    constructor Create(aFile: TwbBA2File; var aFileRec: TwbBA2FileRec);
  end;


  IwbFolderInternal = interface(IwbFolder)
    ['{6DF2B964-5AF7-4732-BD28-CD7600407A83}']
  end;

  TwbFolder = class(TInterfacedObject, IwbResourceContainer, IwbFolder, IwbFolderInternal)
  private
    fPath : string;
  protected
    {---IwbResourceContainer---}
    function GetName: string;
    function OpenResource(const aFileName: string): IwbResource;
    function ResourceExists(const aFileName: string): Boolean;
    procedure ResourceList(const aList: TStrings; aFolder: string = '');
    procedure ResolveHash(const aHash: Int64; var Results: TDynStrings);

    {---IwbFolder---}
    function GetPathName: string;
  public
    constructor Create(const aPath: string);
    destructor Destroy; override;
  end;

  TwbFolderResource = class(TInterfacedObject, IwbResource)
    frFolder   : IwbFolderInternal;
    frFileName : string;
  protected
    {---IwbResource---}
    function GetContainer: IwbResourceContainer;
    function GetData: TBytes;
  public
    constructor Create(aFolder: IwbFolderInternal; const aFileName: string);
    destructor Destroy; override;
  end;


function wbCreateContainerHandler: IwbContainerHandler;
begin
  Result := TwbContainerHandler.Create;
end;

{ TwbContainerHandler }

procedure TwbContainerHandler.AddContainer(const aContainer: IwbResourceContainer);
begin
  SetLength(chContainers, Succ(Length(chContainers)));
  chContainers[High(chContainers)] := aContainer;
end;

function TwbContainerHandler.ContainerExists(aContainerName: string): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := Low(chContainers) to High(chContainers) do
    if SameText(chContainers[i].Name, aContainerName) then
      Exit;
  Result := False;
end;

procedure TwbContainerHandler.AddBSA(const aFileName: string);
begin
  if not ContainerExists(aFileName) then
    AddContainer(TwbBSAFile.Create(aFileName));
end;

procedure TwbContainerHandler.AddBA2(const aFileName: string);
begin
  if not ContainerExists(aFileName) then
    AddContainer(TwbBA2File.Create(aFileName));
end;

procedure TwbContainerHandler.AddFolder(const aPath: string);
begin
  if not ContainerExists(aPath) then
    AddContainer(TwbFolder.Create(aPath));
end;

function TwbContainerHandler.OpenResource(const aFileName: string): TDynResources;
var
  i, j: Integer;
begin
  SetLength(Result, Length(chContainers));
  j := 0;
  for i := Low(chContainers) to High(chContainers) do begin
    Result[j] := chContainers[i].OpenResource(aFileName);
    if Assigned(Result[j]) then
      Inc(j);
  end;
  SetLength(Result, j);
end;

function TwbContainerHandler.OpenResourceData(const aContainerName, aFileName: string): TBytes;
var
  Res : TDynResources;
  i   : Integer;
begin
  Res := OpenResource(aFileName);

  if Length(Res) = 0 then
    Exit;

  for i := High(Res) downto Low(Res) do
    if (aContainerName = '') or SameText(Res[i].Container.Name, aContainerName) then begin
      Result := Res[i].GetData;
      Break;
    end;
end;

procedure TwbContainerHandler.ContainerList(const aList: TStrings);
var
  i: Integer;
begin
  if not Assigned(aList) then
    Exit;

  for i := Low(chContainers) to High(chContainers) do
    aList.Add(chContainers[i].Name);
end;

procedure TwbContainerHandler.ContainerResourceList(const aContainerName: string; const aList: TStrings;
  const aFolder: string = '');
var
  i: Integer;
begin
  for i := Low(chContainers) to High(chContainers) do
    if (aContainerName = '') or SameText(chContainers[i].Name, aContainerName) then begin
      chContainers[i].ResourceList(aList, aFolder);
      if aContainerName <> '' then
        Break;
    end;
end;

function TwbContainerHandler.ResourceExists(const aFileName: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Low(chContainers) to High(chContainers) do
    if chContainers[i].ResourceExists(aFileName) then begin
      Result := True;
      Exit;
    end;
end;

function TwbContainerHandler.ResolveHash(const aHash: Int64): TDynStrings;
var
  i: Integer;
begin
  Result := nil;
  for i := Low(chContainers) to High(chContainers) do
    chContainers[i].ResolveHash(aHash, Result);
end;

function TwbContainerHandler.ResourceCount(const aFileName: string; aContainers: TStrings = nil): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := Low(chContainers) to High(chContainers) do
    if chContainers[i].ResourceExists(aFileName) then begin
      Inc(Result);
      if Assigned(aContainers) then
        aContainers.Add(chContainers[i].Name);
    end;
end;

procedure TwbContainerHandler.ResourceCopy(const aContainerName, aFileName, aPathOut: string);
var
  fn, dir    : string;
  aData      : TBytes;
  res        : TDynResources;
  i, residx  : integer;
begin
  if aPathOut = '' then
    raise Exception.Create('Destination path is not specified');

  res := OpenResource(aFileName);

  if Length(res) = 0 then
    raise Exception.Create('Resource doesn''t exist');

  residx := High(res);
  for i := High(res) downto Low(res) do
    if (aContainerName = '') or SameText(res[i].Container.Name, aContainerName) then begin
      residx := i;
      Break;
    end;

  // file name is provided instead of path
  if TPath.HasExtension(aPathOut) then
    fn := aPathOut
  // destination path is provided
  else
    fn := IncludeTrailingPathDelimiter(aPathOut) + aFileName;

  // create distination directory
  dir := ExtractFilePath(fn);
  if not DirectoryExists(dir) then
    if not ForceDirectories(dir) then
      raise Exception.Create('Unable to create destination directory ' + dir);

  // direct copy if file is loose, with overwriting
  if ExtractFileExt(res[residx].Container.Name) = '' then begin
    TFile.Copy(res[residx].Container.Name + aFileName, fn, True);
  end
  // otherwise extract from BSA
  else begin
    aData := res[residx].GetData;
    // exception handled outside
    with TFileStream.Create(fn, fmCreate) do try
      WriteBuffer(aData[0], Length(aData));
    finally
      Free;
    end;
  end;
end;


{ TwbBSAFile }

constructor TwbBSAFile.Create(const aFileName: string);
begin
  bfFileName := aFileName;
  bfStream := TwbReadOnlyCachedFileStream.Create(aFileName, fmOpenRead or fmShareDenyWrite);
  ReadDirectory;
end;

destructor TwbBSAFile.Destroy;
var
  i: Integer;
begin
  FreeAndNil(bfStream);
  for i := Low(bfFolders) to High(bfFolders) do with bfFolders[i] do
    FreeAndNil(Map);
  FreeAndNil(bfFolderMap);
  inherited;
end;

function TwbBSAFile.GetData(aOffset, aSize: Cardinal): TBytes;
var
  IsCompressed : Boolean;
  Buffer       : TBytes;
begin
  IsCompressed := (aSize and BSAFILE_COMPRESS) <> 0;
  if IsCompressed then
    aSize := aSize and not BSAFILE_COMPRESS;
  if (bfFlags and BSAARCHIVE_COMPRESSFILES) <> 0 then
    IsCompressed := not IsCompressed;
  bfStream.Position := aOffset;
  if (bfVersion >= BSAHEADER_VERSION_SK) and ((bfFlags and BSAARCHIVE_PREFIXFULLFILENAMES) <> 0) then
    // size - file name length (no terminator) - string length prefix
    aSize := aSize - Length(bfStream.ReadStringLen(False)) - 1;
  if IsCompressed then begin
    SetLength(Result, bfStream.ReadCardinal);
    aSize := aSize - 4;
    if (Length(Result) > 0) and (aSize > 0) then begin
      SetLength(Buffer, aSize);
      bfStream.ReadBuffer(Buffer[0], Length(Buffer));
      if bfVersion = BSAHEADER_VERSION_SSE then
        lz4DecompressToUserBuf(@Buffer[0], Length(Buffer), @Result[0], Length(Result))
      else
        DecompressToUserBuf(@Buffer[0], Length(Buffer), @Result[0], Length(Result));
    end;
  end else begin
    SetLength(Result, aSize);
    if aSize > 0 then
      bfStream.ReadBuffer(Result[0], aSize);
  end;
end;

function TwbBSAFile.GetFileName: string;
begin
  Result := bfFileName;
end;

function TwbBSAFile.GetName: string;
begin
  Result := GetFileName;
end;

function TwbBSAFile.OpenResource(const aFileName: string): IwbResource;
var
  lPath, lName: string;
  i, j: Integer;
begin
  Result := nil;
  lPath := ExtractFilePath(aFileName);
  SetLength(lPath, Pred(Length(lPath)));
  lName := ExtractFileName(aFileName);
  if bfFolderMap.Find(lPath, i) then
    with bfFolders[Integer(bfFolderMap.Objects[i])] do
      if Map.Find(lName, j) then
        with Files[Integer(Map.Objects[j])] do
          Result := TwbBSAResource.Create(Self, Size, Offset);
end;

function TwbBSAFile.ResourceExists(const aFileName: string): Boolean;
var
  lPath, lName: string;
  i: Integer;
begin
  Result := False;
  lPath := ExtractFilePath(aFileName);
  SetLength(lPath, Pred(Length(lPath)));
  lName := ExtractFileName(aFileName);
  if bfFolderMap.Find(lPath, i) then
    Result := bfFolders[Integer(bfFolderMap.Objects[i])].Map.IndexOf(lName) <> -1;
end;

procedure TwbBSAFile.ResourceList(const aList: TStrings; aFolder: string = '');
var
  i, j: Integer;
  Folder: string;
begin
  if not Assigned(aList) then
    Exit;
  Folder := ExcludeTrailingPathDelimiter(aFolder);
  for i := Low(bfFolders) to High(bfFolders) do with bfFolders[i] do
    if (Folder = '') or SameText(Copy(Name, 1, Length(Folder)), Folder) then
      for j := Low(Files) to High(Files) do
        aList.Add(Name + '\' + Files[j].Name);
end;

procedure TwbBSAFile.ReadDirectory;
var
  i, j   : Integer;
  OldPos : Int64;
  NewPos : Int64;
//  FileCount : Cardinal;
//  totalFolderNameLength : Cardinal;
  totalFileNameLength : Cardinal;
begin
  if IntToSignature(bfStream.ReadCardinal) <> 'BSA' then
    raise Exception.Create(bfFileName + ' is not a valid BSA file');
  bfVersion := bfStream.ReadCardinal;
  if not (bfVersion in [BSAHEADER_VERSION_OB, BSAHEADER_VERSION_SK, BSAHEADER_VERSION_SSE]) then
    raise Exception.Create(bfFileName + ' has unknown version: ' + IntToStr(bfVersion) );
  bfOffset := bfStream.ReadCardinal;
  if bfOffset <> $24 then
    raise Exception.Create(bfFileName + ' has unexpected Offset: ' + IntToStr(bfOffset) );
  bfFlags := bfStream.ReadCardinal;
  SetLength(bfFolders, bfStream.ReadCardinal);
  {FileCount := } bfStream.ReadCardinal; //skip file count
  {totalFolderNameLength := } bfStream.ReadCardinal; //skip totalFolderNameLength
  totalFileNameLength := bfStream.ReadCardinal; //skip totalFileNameLength
  bfFileFlags := bfStream.ReadCardinal;
  OldPos := bfStream.Position;
  for i := Low(bfFolders) to High(bfFolders) do with bfFolders[i] do begin
    bfStream.Position := OldPos;
    Hash := bfStream.ReadInt64; // skip hash
    SetLength(Files, bfStream.ReadCardinal);
    if bfVersion = BSAHEADER_VERSION_SSE then begin
      bfStream.ReadCardinal; // skip unk32
      NewPos := bfStream.ReadInt64;
    end else
      NewPos := bfStream.ReadCardinal;
    OldPos := bfStream.Position;
    bfStream.Position := NewPos - totalFileNameLength;
    Name := bfStream.ReadStringLen;
    for j := Low(Files) to High(Files) do with Files[j] do begin
      Hash := bfStream.ReadInt64; // skip hash
      Size := bfStream.ReadCardinal;
      Offset := bfStream.ReadCardinal;
    end;
  end;
  bfFolderMap := TwbFastStringList.Create;
  for i := Low(bfFolders) to High(bfFolders) do with bfFolders[i] do begin
    bfFolderMap.AddObject(Name, TObject(i));
    Map := TwbFastStringList.Create;
    for j := Low(Files) to High(Files) do with Files[j] do begin
      Name := bfStream.ReadStringTerm;
      Map.AddObject(Name, TObject(j));
    end;
    Map.Sorted := True;
  end;
  bfFolderMap.Sorted := True;
end;

procedure TwbBSAFile.ResolveHash(const aHash: Int64; var Results: TDynStrings);
var
  i, j: Integer;
begin
  for i := Low(bfFolders) to High(bfFolders) do with bfFolders[i] do begin
    if Hash = aHash then begin
      SetLength(Results, Succ(Length(Results)));
      Results[High(Results)] := Name;
    end;
    for j := Low(Files) to High(Files) do with Files[j] do begin
      if Hash = aHash then begin
        SetLength(Results, Succ(Length(Results)));
        Results[High(Results)] := Name;
      end;
    end;
  end;
end;

{ TwbBSAResource }

constructor TwbBSAResource.Create(aFile: TwbBSAFile; aSize, aOffset: Cardinal);
begin
  brFile := aFile;
  brOffset := aOffset;
  brSize := aSize;
end;

function TwbBSAResource.GetContainer: IwbResourceContainer;
begin
  Result := brFile;
end;

function TwbBSAResource.GetData: TBytes;
begin
  Result := brFile.GetData(brOffset, brSize);
end;


{ TwbBA2File }

constructor TwbBA2File.Create(const aFileName: string);
begin
  bfFileName := aFileName;
  bfStream := TwbReadOnlyCachedFileStream.Create(aFileName, fmOpenRead or fmShareDenyWrite);
  ReadDirectory;
end;

destructor TwbBA2File.Destroy;
var
  i: integer;
begin
  FreeAndNil(bfStream);
  for i := 0 to Pred(bfFolderMap.Count) do
    TStringList(bfFolderMap.Objects[i]).Free;
  FreeAndNil(bfFolderMap);
  inherited;
end;

procedure TwbBA2File.ReadDirectory;
var
  i, j   : Integer;
  OldPos : Int64;
  FileCount : Cardinal;
  FileTablePosition: Int64;
  NumChunks: Byte;
  folder: string;
begin
  if IntToSignature(bfStream.ReadCardinal) <> 'BTDX' then
    raise Exception.Create(bfFileName + ' is not a valid BA2 file');
  bfVersion := bfStream.ReadCardinal;
  if bfVersion <> BA2HEADER_VERSION_FO4 then
    raise Exception.Create(bfFileName + ' has unknown version: ' + IntToStr(bfVersion) );
  bfType := IntToSignature(bfStream.ReadCardinal);
  if (bfType <> 'GNRL') and (bfType <> 'DX10') then
    raise Exception.Create(bfFileName + ' has unknown type: ' + String(bfType));
  FileCount := bfStream.ReadCardinal;
  FileTablePosition := bfStream.ReadInt64;
  OldPos := bfStream.Position;
  bfStream.Position := FileTablePosition;
  SetLength(bfFiles, FileCount);
  for i := Low(bfFiles) to High(bfFiles) do
    bfFiles[i].Name := bfStream.ReadStringLen16.Replace('/','\');
  bfStream.Position := OldPos;

  if bfType = 'GNRL' then begin
    for i := Low(bfFiles) to High(bfFiles) do begin
      bfFiles[i].NameHash := bfStream.ReadCardinal;
      bfStream.ReadCardinal; // skip ext
      bfFiles[i].DirHash := bfStream.ReadCardinal;
      bfStream.ReadCardinal; // skip unk0C
      bfFiles[i].Offset := bfStream.ReadInt64;
      bfFiles[i].PackedSize := bfStream.ReadCardinal;
      bfFiles[i].Size := bfStream.ReadCardinal;
      bfStream.ReadCardinal; // skip BAADF00D
    end;
  end
  else if bfType = 'DX10' then begin
    for i := Low(bfFiles) to High(bfFiles) do begin
      bfFiles[i].NameHash := bfStream.ReadCardinal;
      bfStream.ReadCardinal; // skip ext
      bfFiles[i].DirHash := bfStream.ReadCardinal;
      bfStream.ReadByte; // skip unk0C
      NumChunks := bfStream.ReadByte;
      bfStream.ReadWord; // skip chunkHeaderSize
      bfFiles[i].Height := bfStream.ReadWord;
      bfFiles[i].Width := bfStream.ReadWord;
      bfFiles[i].NumMips := bfStream.ReadByte;
      bfFiles[i].DXGIFormat := bfStream.ReadByte;
      bfFiles[i].CubeMaps := bfStream.ReadWord;
      SetLength(bfFiles[i].TexChunks, NumChunks);
      for j := Low(bfFiles[i].TexChunks) to High(bfFiles[i].TexChunks) do
        with bfFiles[i].TexChunks[j] do begin
          Offset := bfStream.ReadInt64;
          PackedSize := bfStream.ReadCardinal;
          Size := bfStream.ReadCardinal;
          StartMip := bfStream.ReadWord;
          EndMip := bfStream.ReadWord;
          bfStream.ReadCardinal; // skip BAADF00D
        end;
    end;
  end;

  bfFolderMap := TwbFastStringList.Create;
  bfFolderMap.Sorted := True;
  for i := Low(bfFiles) to High(bfFiles) do begin
    folder := LowerCase(ExtractFilePath(bfFiles[i].Name));
    SetLength(folder, Pred(Length(folder)));
    j := bfFolderMap.IndexOf(folder);
    if not bfFolderMap.Find(folder, j) then begin
      bfFolderMap.AddObject(folder, TwbFastStringList.Create);
      if not bfFolderMap.Find(folder, j) then
        raise Exception.Create('Indexing error');
    end;
    TStringList(bfFolderMap.Objects[j]).AddObject(LowerCase(ExtractFileName(bfFiles[i].Name)), TObject(i));
  end;
  for i := 0 to Pred(bfFolderMap.Count) do
    TStringList(bfFolderMap.Objects[i]).Sorted := True;
end;

function TwbBA2File.GetFileName: string;
begin
  Result := bfFileName;
end;

function TwbBA2File.GetName: string;
begin
  Result := GetFileName;
end;

procedure TwbBA2File.ReadData(var Buffer; Offset: Int64; Count: Longint);
begin
  bfStream.Position := Offset;
  bfStream.ReadBuffer(Buffer, Count);
end;

function TwbBA2File.OpenResource(const aFileName: string): IwbResource;
var
  lFileName: string;
  lPath, lName: string;
  i, j: Integer;
begin
  lFileName := LowerCase(aFileName).Replace('/', '\');
  lPath := ExtractFilePath(lFileName);
  SetLength(lPath, Pred(Length(lPath)));
  lName := ExtractFileName(lFileName);
  if bfFolderMap.Find(lPath, i) then with TStringList(bfFolderMap.Objects[i]) do
    if Find(lName, j) then
      Result := TwbBA2Resource.Create(Self, bfFiles[Integer(Objects[j])]);
end;

procedure TwbBA2File.ResolveHash(const aHash: Int64; var Results: TDynStrings);
begin
  // ...
end;

function TwbBA2File.ResourceExists(const aFileName: string): Boolean;
var
  lFileName    : string;
  lPath, lName : string;
  i            : Integer;
begin
  Result := False;
  lFileName := LowerCase(aFileName).Replace('/', '\');
  lPath := ExtractFilePath(lFileName);
  SetLength(lPath, Pred(Length(lPath)));
  lName := ExtractFileName(lFileName);
  if bfFolderMap.Find(lPath, i) then
    Result := TStringList(bfFolderMap.Objects[i]).IndexOf(lName) <> -1;
end;

procedure TwbBA2File.ResourceList(const aList: TStrings; aFolder: string = '');
var
  i: Integer;
begin
  if not Assigned(aList) then
    Exit;
  aFolder := LowerCase(aFolder).Replace('/', '\');
  if aFolder <> '' then
    aFolder := IncludeTrailingPathDelimiter(aFolder);
  for i := Low(bfFiles) to High(bfFiles) do
    if (aFolder = '') or bfFiles[i].Name.StartsWith(aFolder, True) then
      aList.Add(LowerCase(bfFiles[i].Name));
end;


{ TwbBA2Resource }

constructor TwbBA2Resource.Create(aFile: TwbBA2File; var aFileRec: TwbBA2FileRec);
begin
  brFile := aFile;
  brFileRec := aFileRec;
end;

function TwbBA2Resource.GetContainer: IwbResourceContainer;
begin
  Result := brFile;
end;

function TwbBA2Resource.GetData: TBytes;
const
  FOURCC_BC7 = LongWord(Byte('B') or (Byte('C') shl 8) or (Byte('7') shl 16) or
    (Byte(0) shl 24));
var
  Buffer       : TBytes;
  Hdr: ^TDDSFileHeader;
  TexSize, i: integer;
begin
  // GNRL resource
  if (brFileRec.Size <> 0) and (Length(brFileRec.TexChunks) = 0) then begin
    if brFileRec.PackedSize <> 0 then begin
      SetLength(Buffer, brFileRec.PackedSize);
      brFile.ReadData(Buffer[0], brFileRec.Offset, Length(Buffer));
      SetLength(Result, brFileRec.Size);
      DecompressToUserBuf(@Buffer[0], Length(Buffer), @Result[0], Length(Result));
    end
    else begin
      SetLength(Result, brFileRec.Size);
      brFile.ReadData(Result[0], brFileRec.Offset, Length(Result));
    end;
  end
  // DX10 texture
  else if Length(brFileRec.TexChunks) <> 0 then begin
    // calculate texture size including header
    TexSize := SizeOf(TDDSFileHeader);
    for i := Low(brFileRec.TexChunks) to High(brFileRec.TexChunks) do
      Inc(TexSize, brFileRec.TexChunks[i].Size);
    SetLength(Result, TexSize);
    // fill DDS header
    Hdr := @Result[0];
    hdr.Magic := DDSMagic;
    hdr.Desc.Size := SizeOf(hdr.Desc);
    hdr.Desc.Width := brFileRec.Width;
    hdr.Desc.Height := brFileRec.Height;
    hdr.Desc.Flags := DDS_SAVE_FLAGS or DDSD_MIPMAPCOUNT;
    hdr.Desc.Caps.Caps1 := DDSCAPS_TEXTURE or DDSCAPS_MIPMAP;
    hdr.Desc.MipMaps := brFileRec.NumMips;
    if brFileRec.CubeMaps = 2049 then
      hdr.Desc.Caps.Caps2 := DDSCAPS2_POSITIVEX or DDSCAPS2_NEGATIVEX
                          or DDSCAPS2_POSITIVEY or DDSCAPS2_NEGATIVEY
                          or DDSCAPS2_POSITIVEZ or DDSCAPS2_NEGATIVEZ
                          or DDSCAPS2_CUBEMAP;
    hdr.Desc.PixelFormat.Size := SizeOf(hdr.Desc.PixelFormat);
    case TDXGIFormat(brFileRec.DXGIFormat) of
      DXGI_FORMAT_BC1_UNORM, DXGI_FORMAT_BC1_UNORM_SRGB: begin
        hdr.Desc.PixelFormat.Flags := DDPF_FOURCC;
        hdr.Desc.PixelFormat.FourCC := FOURCC_DXT1;
        hdr.Desc.PitchOrLinearSize := brFileRec.Width * brFileRec.Height div 4;
      end;
      DXGI_FORMAT_BC2_UNORM, DXGI_FORMAT_BC2_UNORM_SRGB: begin
        hdr.Desc.PixelFormat.Flags := DDPF_FOURCC;
        hdr.Desc.PixelFormat.FourCC := FOURCC_DXT3;
        hdr.Desc.PitchOrLinearSize := brFileRec.Width * brFileRec.Height;
      end;
      DXGI_FORMAT_BC3_UNORM, DXGI_FORMAT_BC3_UNORM_SRGB: begin
        hdr.Desc.PixelFormat.Flags := DDPF_FOURCC;
        hdr.Desc.PixelFormat.FourCC := FOURCC_DXT5;
        hdr.Desc.PitchOrLinearSize := brFileRec.Width * brFileRec.Height;
      end;
      DXGI_FORMAT_BC5_UNORM: begin
        hdr.Desc.PixelFormat.Flags := DDPF_FOURCC;
        hdr.Desc.PixelFormat.FourCC := FOURCC_ATI2;
        hdr.Desc.PitchOrLinearSize := brFileRec.Width * brFileRec.Height;
      end;
      DXGI_FORMAT_BC7_UNORM, DXGI_FORMAT_BC7_UNORM_SRGB: begin
        hdr.Desc.PixelFormat.Flags := DDPF_FOURCC;
        hdr.Desc.PixelFormat.FourCC := FOURCC_BC7;
        hdr.Desc.PitchOrLinearSize := brFileRec.Width * brFileRec.Height;
      end;
      DXGI_FORMAT_B8G8R8A8_UNORM, DXGI_FORMAT_B8G8R8A8_UNORM_SRGB: begin
        hdr.Desc.PixelFormat.Flags := DDPF_RGB;
        hdr.Desc.PixelFormat.BitCount := 32;
        hdr.Desc.PixelFormat.RedMask   := $00FF0000;
        hdr.Desc.PixelFormat.GreenMask := $0000FF00;
        hdr.Desc.PixelFormat.BlueMask  := $000000FF;
        hdr.Desc.PitchOrLinearSize := brFileRec.Width * brFileRec.Height * 4;
      end;
      DXGI_FORMAT_R8_UNORM: begin
        hdr.Desc.PixelFormat.Flags := DDPF_RGB;
        hdr.Desc.PixelFormat.BitCount := 8;
        hdr.Desc.PixelFormat.RedMask   := $FF;
        hdr.Desc.PitchOrLinearSize := brFileRec.Width * brFileRec.Height;
      end;
    end;
    // append chunks
    TexSize := SizeOf(TDDSFileHeader);
    for i := Low(brFileRec.TexChunks) to High(brFileRec.TexChunks) do with brFileRec.TexChunks[i] do begin
      // compressed chunk
      if PackedSize <> 0 then begin
        SetLength(Buffer, PackedSize);
        brFile.ReadData(Buffer[0], Offset, Length(Buffer));
        DecompressToUserBuf(@Buffer[0], Length(Buffer), @Result[TexSize], Size);
      end
      // uncompressed chunk
      else
        brFile.ReadData(Result[TexSize], Offset, Size);
      Inc(TexSize, Size);
    end;
  end;
end;


{ TwbFolder }

constructor TwbFolder.Create(const aPath: string);
begin
  fPath := IncludeTrailingPathDelimiter(aPath);
end;

destructor TwbFolder.Destroy;
begin

  inherited;
end;

function TwbFolder.GetPathName: string;
begin
  Result := fPath;
end;

function TwbFolder.GetName: string;
begin
  Result := GetPathName;
end;

function TwbFolder.OpenResource(const aFileName: string): IwbResource;
var
  s: string;
begin
  s := fPath + aFileName;
  if FileExists(s) then
    Result := TwbFolderResource.Create(Self, s);
end;

function TwbFolder.ResourceExists(const aFileName: string): Boolean;
begin
  Result := FileExists(fPath + aFileName);
end;

procedure TwbFolder.ResourceList(const aList: TStrings; aFolder: string = '');
var
  FileName: string;
begin
  if not Assigned(aList) then
    Exit;
  aFolder := aFolder.Replace('/', '\');
  if TDirectory.Exists(fPath + aFolder) then
    for FileName in TDirectory.GetFiles(fPath + aFolder, '*.*', TSearchOption.soAllDirectories) do
      aList.Add(LowerCase(Copy(FileName, Length(fPath) + 1, Length(FileName))));
end;

procedure TwbFolder.ResolveHash(const aHash: Int64; var Results: TDynStrings);
begin
  //...
end;

{ TwbFolderResource }

constructor TwbFolderResource.Create(aFolder: IwbFolderInternal; const aFileName: string);
begin
  frFolder := aFolder;
  frFileName := aFileName;
end;

destructor TwbFolderResource.Destroy;
begin

  inherited;
end;

function TwbFolderResource.GetContainer: IwbResourceContainer;
begin
  Result := frFolder;
end;

function TwbFolderResource.GetData: TBytes;
begin
  with TFileStream.Create(frFileName, fmOpenRead or fmShareDenyWrite) do try
    SetLength(Result, Size);
    if Length(Result) > 0 then
      ReadBuffer(Result[0], Length(Result));
  finally
    Free;
  end;
end;

end.
