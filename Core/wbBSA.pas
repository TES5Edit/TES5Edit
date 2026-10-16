{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbBSA;

{$I wbDefines.inc}

interface

uses
  wbInterface;

function wbCreateContainerHandler(aGameDef: TwbGameDef): IwbContainerHandler;

implementation

uses
  Winapi.Windows,

  System.Classes,
  System.Generics.Collections,
  System.IOUtils,
  System.SysUtils,

  wbBSArchive,
  wbHash;

type
  TwbHashToStringDict = TDictionary<Int64, string>;

  TwbContainerCache = class
  private
    ccFileHashes   : TwbHashToStringDict;
    ccFolderHashes : TwbHashToStringDict;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Build(const aContainers: TArray<IwbResourceContainer>; const aCapabilities: TwbGameCapabilities; const aGameName: string);

    function ResolveFolderHash(const aHash: Int64): string;
    function ResolveFileHash(const aHash: Int64): string;
  end;

  TwbContainerCacheBuilder = class(TThread)
  private
    cbContainers   : TArray<IwbResourceContainer>;
    cbCapabilities : TwbGameCapabilities;
    cbGameName     : string;
    cbCache        : TwbContainerCache;
    cbError        : TObject;
  protected
    procedure Execute; override;
  public
    constructor Create(const aContainers: TArray<IwbResourceContainer>; const aCapabilities: TwbGameCapabilities; const aGameName: string);
    destructor Destroy; override;
  end;

  TwbContainerHandler = class(TInterfacedObject, IwbContainerHandler)
  private
    chContainers   : TArray<IwbResourceContainer>;
    chCache        : TwbContainerCache;
    chCacheBuilder : TwbContainerCacheBuilder;
    chGameDef      : TwbGameDef;
  public
    constructor Create(aGameDef: TwbGameDef);
    destructor Destroy; override;
  protected
    function AddContainer(aContainer: IwbResourceContainer): IwbResourceContainer;

    procedure InvalidateCache;

    procedure StartCache;
    procedure EnsureCache;

    {---IwbContainerHandler---}
    function AddFolder(const aPath: string): IwbResourceContainer;
    function AddBSA(const aFileName: string): IwbResourceContainer;
    function AddBA2(const aFileName: string): IwbResourceContainer;

    function OpenResource(const aFileName: string): TDynResources;
    function OpenResourceData(const aContainerName, aFileName: string): TBytes;

    function ContainerExists(const aContainerName: string): Boolean; overload;
    function ContainerExists(const aContainerName: string; out aContainer: IwbResourceContainer): Boolean; overload;
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
    function GetData(aFileEntry: TwbBSFileEntry): TBytes;
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
    function GetData(aFileEntry: TwbBSFileEntry): TBytes;
  public
    constructor Create(const aFileName: string);
    destructor Destroy; override; final;
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
    procedure AddFiles(const aRelPath: string; aList: TStrings; aDict: TwbResourceDict);
    procedure ListFiles(aFolder: string; aList: TStrings; aDict: TwbResourceDict);
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
    destructor Destroy; override; final;
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
    destructor Destroy; override; final;
  end;


function wbCreateContainerHandler(aGameDef: TwbGameDef): IwbContainerHandler;
begin
  Result := TwbContainerHandler.Create(aGameDef);
end;

{ TwbContainerHandler }

constructor TwbContainerHandler.Create(aGameDef: TwbGameDef);
begin
  inherited Create;
  chGameDef := aGameDef;
end;

destructor TwbContainerHandler.Destroy;
begin
  InvalidateCache;
  inherited;
end;

function TwbContainerHandler.AddContainer(aContainer: IwbResourceContainer): IwbResourceContainer;
begin
  Result := aContainer;
  TMonitor.Enter(Self);
  try
    SetLength(chContainers, Succ(Length(chContainers)));
    chContainers[High(chContainers)] := aContainer;
  finally
    TMonitor.Exit(Self);
  end;
end;

function TwbContainerHandler.ContainerExists(const aContainerName: string): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := Low(chContainers) to High(chContainers) do
    if SameText(chContainers[i].Name, aContainerName) then
      Exit;
  Result := False;
end;

function TwbContainerHandler.ContainerExists(const aContainerName: string; out aContainer: IwbResourceContainer): Boolean;
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
  if not ContainerExists(IncludeTrailingPathDelimiter(aPath), Result) then
    Result := AddContainer(TwbFolder.Create(aPath));
  InvalidateCache;
end;

procedure TwbContainerHandler.StartCache;
begin
  TMonitor.Enter(Self);
  try
    if not Assigned(chCache) and not Assigned(chCacheBuilder) then
      chCacheBuilder := TwbContainerCacheBuilder.Create(Copy(chContainers), chGameDef.Capabilities, chGameDef.GameName);
  finally
    TMonitor.Exit(Self);
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
  Result := nil;
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
  if Assigned(chCache) then
    Exit;
  TMonitor.Enter(Self);
  try
    if Assigned(chCache) then
      Exit;
    if Assigned(chCacheBuilder) then begin
      WaitForSingleObject(chCacheBuilder.Handle, INFINITE);
      if not Assigned(chCacheBuilder.cbCache) then
        chCacheBuilder.cbCache := TwbContainerCache.Create;
      var lError := chCacheBuilder.cbError;
      chCacheBuilder.cbError := nil;
      chCache := chCacheBuilder.cbCache;
      chCacheBuilder.cbCache := nil;
      FreeAndNil(chCacheBuilder);
      if Assigned(lError) then
        raise lError;
    end else begin
      var lCache := TwbContainerCache.Create;
      try
        lCache.Build(chContainers, chGameDef.Capabilities, chGameDef.GameName);
      finally
        chCache := lCache;
      end;
    end;
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TwbContainerHandler.InvalidateCache;
begin
  TMonitor.Enter(Self);
  try
    if Assigned(chCacheBuilder) then begin
      WaitForSingleObject(chCacheBuilder.Handle, INFINITE);
      FreeAndNil(chCacheBuilder);
    end;
    FreeAndNil(chCache);
  finally
    TMonitor.Exit(Self);
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

  residx := -1;
  for i := High(res) downto Low(res) do
    if (aContainerName = '') or SameText(res[i].Container.Name, aContainerName) then begin
      residx := i;
      Break;
    end;

  if residx < 0 then
    raise Exception.Create('Resource doesn''t exist in ' + aContainerName);

  // file name is provided instead of path
  if TPath.HasExtension(aPathOut) and not DirectoryExists(aPathOut) then
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

function TwbBSAFile.GetData(aFileEntry: TwbBSFileEntry): TBytes;
begin
  Result := nil;
  if Assigned(aFileEntry) then
    Result := bfArchive.Unpack(aFileEntry);
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
  FileRecord := bfArchive.FileByName(aFileName);
  if Assigned(FileRecord) then
    Result := TwbBSAResource.Create(Self, FileRecord);
end;

procedure TwbBSAFile.ResourceDict(const aDict: TwbResourceDict; aFolder: string);
begin
  if Assigned(aDict) then
    for var f in bfArchive.FilesByFolder(aFolder) do
      aDict.TryAdd(f.Name, wbNothing);
end;

function TwbBSAFile.ResourceExists(const aFileName: string): Boolean;
begin
  Result := Assigned(bfArchive.FileByName(aFileName));
end;

procedure TwbBSAFile.ResourceList(const aList: TStrings; aFolder: string = '');
begin
  if Assigned(aList) then
    for var f in bfArchive.FilesByFolder(aFolder) do
      aList.Add(f.Name);
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
  Result := nil;
  s := fPath + aFileName;
  if FileExists(s) then
    Result := TwbFolderResource.Create(Self, s);
end;

const
  FIND_FIRST_EX_LARGE_FETCH = 2;
  cSkippedFolder = '.git';

procedure TwbFolder.AddFiles(const aRelPath: string; aList: TStrings; aDict: TwbResourceDict);
var
  lData: TWin32FindData;
begin
  var lHandle := FindFirstFileEx(PChar(fPath + aRelPath + '*'), FindExInfoBasic, @lData, FindExSearchNameMatch, nil,
    FIND_FIRST_EX_LARGE_FETCH);
  if lHandle = INVALID_HANDLE_VALUE then
    Exit;
  try
    repeat
      var lName := string(PChar(@lData.cFileName[0]));
      if lData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0 then begin
        if (lName <> '.') and (lName <> '..') and not SameText(lName, cSkippedFolder) then
          AddFiles(aRelPath + lName + '\', aList, aDict);
      end else begin
        var lFileName := LowerCase(aRelPath + lName);
        if Assigned(aDict) then
          aDict.TryAdd(lFileName, wbNothing);
        if Assigned(aList) then
          aList.Add(lFileName);
      end;
    until not FindNextFile(lHandle, lData);
  finally
    Winapi.Windows.FindClose(lHandle);
  end;
end;

procedure TwbFolder.ListFiles(aFolder: string; aList: TStrings; aDict: TwbResourceDict);
begin
  aFolder := aFolder.Replace('/', '\').TrimRight(['\']);
  if aFolder <> '' then
    aFolder := aFolder + '\';
  for var lPart in aFolder.Split(['\']) do
    if SameText(lPart, cSkippedFolder) then
      Exit;
  AddFiles(aFolder, aList, aDict);
end;

procedure TwbFolder.ResourceDict(const aDict: TwbResourceDict; aFolder: string);
begin
  if Assigned(aDict) then
    ListFiles(aFolder, nil, aDict);
end;

function TwbFolder.ResourceExists(const aFileName: string): Boolean;
begin
  Result := FileExists(fPath + aFileName);
end;

procedure TwbFolder.ResourceList(const aList: TStrings; aFolder: string = '');
begin
  if Assigned(aList) then
    ListFiles(aFolder, aList, nil);
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

const
  _AllCount = 1000000;
  _OtherCount = 500000;

constructor TwbContainerCache.Create;
begin
  inherited Create;
  ccFileHashes := TwbHashToStringDict.Create(_OtherCount);
  ccFolderHashes := TwbHashToStringDict.Create(_OtherCount);
end;

destructor TwbContainerCache.Destroy;
begin
  ccFolderHashes.Free;
  ccFileHashes.Free;
  inherited;
end;

procedure TwbContainerCache.Build(const aContainers: TArray<IwbResourceContainer>; const aCapabilities: TwbGameCapabilities; const aGameName: string);
  function CalcHash(const aStr: string; aIsFolder: Boolean): Int64;
  begin
    if gcResourceKeyCRC32NoExtension in aCapabilities then
      Result := TwbHash.BSCRC32(aStr)
    else
      Result := TwbHash.TES4(aStr, not aIsFolder);
  end;

begin
  var lAll: TwbResourceDict := nil;
  var lFiles: TwbResourceDict := nil;
  var lFolders: TwbResourceDict := nil;
  try
    lAll := TwbResourceDict.Create(_AllCount);
    lFiles := TwbResourceDict.Create(_OtherCount);
    lFolders := TwbResourceDict.Create(_OtherCount);

    for var lContainer in aContainers do
      lContainer.ResourceDict(lAll, '');

    var lPath :=  IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
    var lHashSeedName := lPath + aGameName + '.HashSeed.txt';

    if FileExists(lHashSeedName) then
    with TStringList.Create do try
      try
        LoadFromFile(lHashSeedName);
        for var lHashSeedIdx := Pred(Count) downto 0 do begin
          var lHashSeed := Strings[lHashSeedIdx].ToLowerInvariant.Replace('/', '\');
          if not lAll.TryAdd(lHashSeed, wbNothing) then
            Delete(lHashSeedIdx);
        end;
        SaveToFile(lHashSeedName + '2');
      except
        on EStreamError do ;
      end;
    finally
      Free;
    end;

    for var lFullName in lAll.Keys do begin
      var lFolder := ExcludeTrailingBackslash(ExtractFilePath(lFullName)).ToLowerInvariant.Replace('/', '\');
      if lFolders.TryAdd(lFolder, wbNothing) then begin
        ccFolderHashes.TryAdd(CalcHash(lFolder, True), lFolder);
      end;

      var lFile := ExtractFileName(lFullName).ToLowerInvariant;
      if gcResourceKeyCRC32NoExtension in aCapabilities then
        lFile := ChangeFileExt(lFile, '');

      if lFiles.TryAdd(lFile, wbNothing) then begin
        ccFileHashes.TryAdd(CalcHash(lFile, False), lFile);

        if gcTextureDDXAlias in aCapabilities then
          if ExtractFileExt(lFile) = '.dds' then
            lFile := ChangeFileExt(lFile, '.ddx');
            if lFiles.TryAdd(lFile, wbNothing) then begin
              ccFileHashes.TryAdd(CalcHash(lFile, False), lFile);
            end;
      end;
    end;
  finally
    lFolders.Free;
    lFiles.Free;
    lAll.Free;
  end;
end;

function TwbContainerCache.ResolveFileHash(const aHash: Int64): string;
begin
  if not ccFileHashes.TryGetValue(aHash, Result) then
    Result := '';
end;

function TwbContainerCache.ResolveFolderHash(const aHash: Int64): string;
begin
  if not ccFolderHashes.TryGetValue(aHash, Result) then
    Result := '';
end;

{ TwbContainerCacheBuilder }

constructor TwbContainerCacheBuilder.Create(const aContainers: TArray<IwbResourceContainer>; const aCapabilities: TwbGameCapabilities;
  const aGameName: string);
begin
  cbContainers := aContainers;
  cbCapabilities := aCapabilities;
  cbGameName := aGameName;
  inherited Create(False);
end;

destructor TwbContainerCacheBuilder.Destroy;
begin
  inherited;
  cbError.Free;
  cbCache.Free;
end;

procedure TwbContainerCacheBuilder.Execute;
begin
  try
    cbCache := TwbContainerCache.Create;
    cbCache.Build(cbContainers, cbCapabilities, cbGameName);
  except
    cbError := AcquireExceptionObject;
  end;
  cbContainers := nil;
end;

{ TwbBA2File }

function TwbBA2File.GetVersion: Cardinal;
begin
  Result := bfArchive.Version;
end;

end.
