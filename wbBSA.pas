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
  lz4io,
  wbBSArchive;

type
  TwbContainerHandler = class(TInterfacedObject, IwbContainerHandler)
  private
    chContainers: array of IwbResourceContainer;
  protected
    procedure AddContainer(aContainer: IwbResourceContainer);

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
    procedure ResolveHash(const aHash: Int64; var Results: TDynStrings);

    {---IwbBSAFile---}
    function GetFileName: string;

    {---IwbBSAFileInternal---}
    function GetData(aFileRecord: Pointer): TBytes;
  public
    constructor Create(const aFileName: string);
    destructor Destroy; override;
  end;

  TwbBSAResource = class(TInterfacedObject, IwbResource)
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

procedure TwbContainerHandler.AddContainer(aContainer: IwbResourceContainer);
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
    AddContainer(TwbBSAFile.Create(aFileName));
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

function TwbBSAFile.ResourceExists(const aFileName: string): Boolean;
begin
  Result := Assigned(bfArchive.FindFileRecord(aFileName));
end;

procedure TwbBSAFile.ResourceList(const aList: TStrings; aFolder: string = '');
begin
  bfArchive.ResourceList(aList, aFolder);
end;

procedure TwbBSAFile.ResolveHash(const aHash: Int64; var Results: TDynStrings);
begin
  bfArchive.ResolveHash(aHash, Results);
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
