{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbBSA;

{$I wbDefines.inc}

interface

uses
  System.Classes,
  System.IOUtils,
  System.SysUtils,
  System.Diagnostics,
  System.Generics.Defaults,
  System.Generics.Collections,
  ImagingDds,
  lz4io,
  zlibEx,
  wbBSArchive,
  wbInterface,
  wbSort,
  wbStreams;

function wbCreateContainerHandler: IwbContainerHandler;

implementation

type
  TwbHashToStringDict = TDictionary<Int64, string>;

  PwbContainerCache = ^TwbContainerCache;
  TwbContainerCache = record
    ccAll             : TwbResourceDict;
    ccFiles           : TwbResourceDict;
    ccFolders         : TwbResourceDict;
    ccFileHashes      : TwbHashToStringDict;
    ccFolderHashes    : TwbHashToStringDict;

    function ResolveFolderHash(const aHash: Int64): string;
    function ResolveFileHash(const aHash: Int64): string;
  end;

  TwbContainerHandler = class(TInterfacedObject, IwbContainerHandler)
  private
    chContainers : array of IwbResourceContainer;
    chCache      : TwbContainerCache;
  protected
    function AddContainer(aContainer: IwbResourceContainer): IwbResourceContainer;

    procedure BuildCache;
    procedure InvalidateCache;
    procedure EnsureCache;

    {---IwbContainerHandler---}
    function AddFolder(const aPath: string): IwbResourceContainer;
    function AddBSA(const aFileName: string): IwbResourceContainer;
    function AddBA2(const aFileName: string): IwbResourceContainer;

    function OpenResource(const aFileName: string): TDynResources;
    function OpenResourceData(const aContainerName, aFileName: string): TBytes;

    function ContainerExists(aContainerName: string): Boolean; overload;
    function ContainerExists(aContainerName: string; out aContainer: IwbResourceContainer): Boolean; overload;
    procedure ContainerList(const aList: TStrings);
    procedure ContainerResourceList(const aContainerName: string; const aList: TStrings; const aFolder: string = '');
    procedure ContainerResourceDict(const aContainerName: string; const aDict: TwbResourceDict; const aFolder: string = '');

    function ResourceExists(const aFileName: string): Boolean;
    function ResourceCount(const aFileName: string; aContainers: TStrings = nil): Integer;
    procedure ResourceCopy(const aContainerName, aFileName, aPathOut: string);

    function ResolveFolderHash(const aHash: Int64): string;
    function ResolveFileHash(const aHash: Int64): string;
  end;

  IwbBSAFileInternal = interface(IwbBSAFile)
    ['{A360B348-8F6B-4FC1-A869-9D5B833DCA5F}']
    function GetData(aFileRecord: Pointer): TBytes;
  end;

  TwbBSAFile = class(TInterfacedObject, IwbResourceContainer, IwbBSAFile, IwbBSAFileInternal)
  private
    bfFileName: string;
    bfArchive: TwbBSArchive;
  protected
    {---IwbResourceContainer---}
    function GetName: string;
    function OpenResource(const aFileName: string): IwbResource;
    function ResourceExists(const aFileName: string): Boolean;
    procedure ResourceList(const aList: TStrings; aFolder: string = '');
    procedure ResourceDict(const aDict: TwbResourceDict; aFolder: string = '');

    {---IwbBSAFile---}
    function GetFileName: string;

    {---IwbBSAFileInternal---}
    function GetData(aFileRecord: Pointer): TBytes;
  public
    constructor Create(const aFileName: string);
    destructor Destroy; override;
  end;

  TwbBA2File = class(TwbBSAFile, IwbBA2File)
  protected
    {---IwbBA2File---}
    function GetVersion: Cardinal;
  end;

  TwbBSAResource = class(TInterfacedObject, IwbResource)
  protected {private}
    brFile       : IwbBSAFileInternal;
    brFileRecord : Pointer;
  protected
    {---IwbResource---}
    function GetContainer: IwbResourceContainer;
    function GetData: TBytes;
  public
    constructor Create(aFile: TwbBSAFile; aFileRecord: Pointer);
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
    procedure ResourceDict(const aDict: TwbResourceDict; aFolder: string = '');
    procedure ResolveHash(const aHash: Int64; var Results: TDynStrings);

    {---IwbFolder---}
    function GetPathName: string;
  public
    constructor Create(const aPath: string);
    destructor Destroy; override;
  end;

  TwbFolderResource = class(TInterfacedObject, IwbResource)
  protected {private}
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

function TwbContainerHandler.AddContainer(aContainer: IwbResourceContainer): IwbResourceContainer;
begin
  Result := aContainer;
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

function TwbContainerHandler.ContainerExists(aContainerName: string; out aContainer: IwbResourceContainer): Boolean;
var
  i: Integer;
begin
  aContainer := nil;
  for i := Low(chContainers) to High(chContainers) do
    if SameText(chContainers[i].Name, aContainerName) then begin
      aContainer := chContainers[i];
      Exit(True);
    end;
  Result := False;
end;

function TwbContainerHandler.AddBSA(const aFileName: string): IwbResourceContainer;
begin
  if not ContainerExists(aFileName, Result) then
    Result := AddContainer(TwbBSAFile.Create(aFileName));
  InvalidateCache;
end;

function TwbContainerHandler.AddBA2(const aFileName: string): IwbResourceContainer;
begin
  if not ContainerExists(aFileName, Result) then
    Result := AddContainer(TwbBA2File.Create(aFileName));
  InvalidateCache;
end;

function TwbContainerHandler.AddFolder(const aPath: string): IwbResourceContainer;
begin
  if not ContainerExists(aPath, Result) then
    Result := AddContainer(TwbFolder.Create(aPath));
  InvalidateCache;
end;

threadvar
  _cc: PwbContainerCache;

const
  _AllCount = 1000000;
  _OtherCount = 500000;

procedure TwbContainerHandler.BuildCache;
begin
  InvalidateCache;
  with chCache do begin

    ccAll := TwbResourceDict.Create(_AllCount);
    ccFiles := TwbResourceDict.Create(_OtherCount);
    ccFolders := TwbResourceDict.Create(_OtherCount);
    ccFileHashes := TwbHashToStringDict.Create(_OtherCount);
    ccFolderHashes := TwbHashToStringDict.Create(_OtherCount);

    ContainerResourceDict('', ccAll, '');

    var lPath :=  IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
    var lHashSeedName := lPath + wbGameName + '.HashSeed.txt';

    if FileExists(lHashSeedName) then
    with TStringList.Create do try
      LoadFromFile(lHashSeedName);
      for var lHashSeedIdx := Pred(Count) downto 0 do begin
        var lHashSeed := Strings[lHashSeedIdx].ToLowerInvariant.Replace('/', '\');
        if not ccAll.TryAdd(lHashSeed, wbNothing) then
          Delete(lHashSeedIdx);
      end;
      SaveToFile(lHashSeedName + '2');
    finally
      Free;
    end;

    for var lFullName in ccAll.Keys do begin
      var lFolder := ExcludeTrailingBackslash(ExtractFilePath(lFullName)).ToLowerInvariant.Replace('/', '\');
      if ccFolders.TryAdd(lFolder, wbNothing) then begin
        var lFolderHash: Int64;
        if wbGameMode >= gmTES5 then
          lFolderHash := CreateHashFO4(lFolder)
        else
          lFolderHash := CreateHashTES4(lFolder);
        ccFolderHashes.TryAdd(lFolderHash, lFolder);
      end;

      var lFile := ExtractFileName(lFullName).ToLowerInvariant;
      if wbGameMode >= gmTES5 then
        lFile := ChangeFileExt(lFile, '');

      if ccFiles.TryAdd(lFile, wbNothing) then begin
        var lFileHash: Int64;
        if wbGameMode >= gmTES5 then
          lFileHash := CreateHashFO4(lFile)
        else
          lFileHash := CreateHashTES4(lFile);
        ccFileHashes.TryAdd(lFileHash, lFile);

        if wbGameMode < gmTES5 then
          if ExtractFileExt(lFile) = '.dds' then
            lFile := ChangeFileExt(lFile, '.ddx');
            if ccFiles.TryAdd(lFile, wbNothing) then begin
              if wbGameMode >= gmTES5 then
                lFileHash := CreateHashFO4(lFile)
              else
                lFileHash := CreateHashTES4(lFile);
              ccFileHashes.TryAdd(lFileHash, lFile);
            end;
      end;
    end;
  end;
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

procedure TwbContainerHandler.ContainerResourceDict(const aContainerName: string; const aDict: TwbResourceDict; const aFolder: string);
begin
  for var i := Low(chContainers) to High(chContainers) do
    if (aContainerName = '') or SameText(chContainers[i].Name, aContainerName) then begin
      chContainers[i].ResourceDict(aDict, aFolder);
      if aContainerName <> '' then
        Break;
    end;
end;

procedure TwbContainerHandler.ContainerResourceList(const aContainerName: string; const aList: TStrings; const aFolder: string = '');
begin
  for var i := Low(chContainers) to High(chContainers) do
    if (aContainerName = '') or SameText(chContainers[i].Name, aContainerName) then begin
      chContainers[i].ResourceList(aList, aFolder);
      if aContainerName <> '' then
        Break;
    end;
end;

procedure TwbContainerHandler.EnsureCache;
begin
  if not Assigned(chCache.ccAll) then
    BuildCache;
end;

procedure TwbContainerHandler.InvalidateCache;
begin
  with chCache do begin
    FreeAndNil(ccAll);
    FreeAndNil(ccFiles);
    FreeAndNil(ccFolders);
    FreeAndNil(ccFileHashes);
    FreeAndNil(ccFolderHashes);
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

function TwbContainerHandler.ResolveFileHash(const aHash: Int64): string;
begin
  EnsureCache;
  Result := chCache.ResolveFileHash(aHash);
end;

function TwbContainerHandler.ResolveFolderHash(const aHash: Int64): string;
begin
  EnsureCache;
  Result := chCache.ResolveFolderHash(aHash);
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
  bfArchive := TwbBSArchive.Create;
  bfArchive.LoadFromFile(aFileName);
end;

destructor TwbBSAFile.Destroy;
begin
  FreeAndNil(bfArchive);
  inherited;
end;

function TwbBSAFile.GetData(aFileRecord: Pointer): TBytes;
begin
  Result := nil;
  if Assigned(aFileRecord) then
    Result := bfArchive.ExtractFileData(aFileRecord);
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
  FileRecord: Pointer;
begin
  Result := nil;
  FileRecord := bfArchive.FindFileRecord(aFileName);
  if Assigned(FileRecord) then
    Result := TwbBSAResource.Create(Self, FileRecord);
end;

procedure TwbBSAFile.ResourceDict(const aDict: TwbResourceDict; aFolder: string);
begin
  bfArchive.ResourceDict(aDict, aFolder);
end;

function TwbBSAFile.ResourceExists(const aFileName: string): Boolean;
begin
  Result := Assigned(bfArchive.FindFileRecord(aFileName));
end;

procedure TwbBSAFile.ResourceList(const aList: TStrings; aFolder: string = '');
begin
  bfArchive.ResourceList(aList, aFolder);
end;

{ TwbBSAResource }

constructor TwbBSAResource.Create(aFile: TwbBSAFile; aFileRecord: Pointer);
begin
  brFile := aFile;
  brFileRecord := aFileRecord;
end;

function TwbBSAResource.GetContainer: IwbResourceContainer;
begin
  Result := brFile;
end;

function TwbBSAResource.GetData: TBytes;
begin
  Result := brFile.GetData(brFileRecord);
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

procedure TwbFolder.ResourceDict(const aDict: TwbResourceDict; aFolder: string);
var
  FileName: string;
begin
  if not Assigned(aDict) then
    Exit;
  aFolder := aFolder.Replace('/', '\');
  if TDirectory.Exists(fPath + aFolder) then
    for FileName in TDirectory.GetFiles(fPath + aFolder, '*.*', TSearchOption.soAllDirectories) do begin
      var lFileName := LowerCase(Copy(FileName, Length(fPath) + 1, Length(FileName)));
      aDict.TryAdd(lFileName, wbNothing);
    end;
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

{ TwbContainerCache }

function TwbContainerCache.ResolveFileHash(const aHash: Int64): string;
begin
  if not (Assigned(ccFileHashes) and ccFileHashes.TryGetValue(aHash, Result)) then
    Result := '';
end;

function TwbContainerCache.ResolveFolderHash(const aHash: Int64): string;
begin
  if not (Assigned(ccFolderHashes) and ccFolderHashes.TryGetValue(aHash, Result)) then
    Result := '';
end;

{ TwbBA2File }

function TwbBA2File.GetVersion: Cardinal;
begin
  Result := bfArchive.Version;
end;

end.
