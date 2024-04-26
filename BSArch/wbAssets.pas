{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbAssets;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils, System.IniFiles,
  wbBSArchive, JsonDataObjects;

type
  TArchiveManager = class
    FList: TArray<TwbBSArchive>;
  protected
    function GetCount: Integer;
    function Get(Index: Integer): TwbBSArchive;
  public
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TwbBSArchive read Get; default;
    constructor Create;
    destructor Destroy; override;
    function IndexOf(const aFileName: string): Integer;
    function OpenArchive(const aFileName: string): TwbBSArchive;
    procedure CloseArchive(const aFileName: string);
    procedure CloseAll;
  end;

  TPackingOptions = record
    ArchiveType: TBSArchiveType;
    ArchiveFileName: string;
    ArchiveFlags: Cardinal;
    FileFlags: Cardinal;
    bAutodetectFlags: Boolean;
    bMultiThreaded: Boolean;
    bSharedData: Boolean;
    procedure LoadSettings(const Settings: TMemIniFile);
    procedure SaveSettings(const Settings: TMemIniFile);
  end;
  PPackingOptions = ^TPackingOptions;

  TAsset = class
    ArchiveName: string;
    FileName: string;
    AssetName: string;
    Compressed: Boolean;
    DDSInfo: TDDSInfo;
    function Equals(aAsset: TAsset): Boolean; reintroduce;
    function FileNameDescr: string;
    function GetData: TBytes;
    procedure GetDDSInfo(var aInfo: TDDSInfo);
    function IsValidAssetName: Boolean;
    procedure ToJson(const js: TJsonBaseObject);
    procedure FromJson(const js: TJsonBaseObject);
  end;
  TAssets = TArray<TAsset>;

  TAssetType = record
    Root: string;
    Ext: TArray<String>;
  end;

const
  cBSArchExtension = '.bsarch';
  cArchiveExtensions: TArray<String> = ['.bsa', '.ba2'];
  cSkippedExtensions: TArray<String> = [
    '.bsa', '.ba2', '.esm', '.esp', '.esl', '.nam', '.sdp', '.cdx', '.csg',
    '.override', '.ghost',
    '.exe', '.dll', '.pdb', '.ini', '.bak', '.db', '.psd', '.jpg', '.jpeg',
    '.3ds', '.max', '.blend', '.obj', '.xlsx', '.docx',
    '.7z', '.zip', '.rar'
  ];
  cDataFolders: TArray<String> = ['Data', 'Data Files'];

  cAssetMesh:       TAssetType = (Root: 'meshes';       Ext: ['.nif', '.kf', '.kfm', '.egm', '.egt', '.tri', '.hkt', '.hkx', '.ssf', '.btr', '.bto', '.btt', '.dtl']);
  cAssetTexture:    TAssetType = (Root: 'textures';     Ext: ['.dds', '.tga']);
  cAssetMaterial:   TAssetType = (Root: 'materials';    Ext: ['.bgsm', '.bgem']);
  cAssetSound:      TAssetType = (Root: 'sound';        Ext: ['.lip', '.wav', '.xwm', '.mp3', '.ogg', '.fuz']);
  cAssetMusic:      TAssetType = (Root: 'sound';        Ext: ['.xwm', '.mp3']);
  cAssetScript:     TAssetType = (Root: 'scripts';      Ext: ['.pex', '.psc']);
  cAssetStrings:    TAssetType = (Root: 'strings';      Ext: ['.strings', '.ilstrings', '.dlstrings']);
  cAssetSpeedTree:  TAssetType = (Root: 'trees';        Ext: ['.spt']);
  cAssetVideo:      TAssetType = (Root: 'video';        Ext: ['.bik', '.bk2']);
  cAssetLODSettings:TAssetType = (Root: 'lodsettings';  Ext: ['.lodsettings', '.dlodsettings', '.lod']);
  cAssetDistantLOD: TAssetType = (Root: 'distantlod';   Ext: ['.cmp', '.lod']); // TES4
  cAssetInterface:  TAssetType = (Root: 'interface';    Ext: ['.swf']);
  cAssetPrograms:   TAssetType = (Root: 'programs';     Ext: ['.swf']);
  cAssetMenu:       TAssetType = (Root: 'menus';        Ext: ['.xml', '.txt', '.scc']); // TES4
  cAssetFont:       TAssetType = (Root: 'fonts';        Ext: ['.fnt']); // TES4
  cAssetFacegen:    TAssetType = (Root: 'facegen';      Ext: ['.ctl']); // TES4
  cAssetLSData:     TAssetType = (Root: 'lsdata';       Ext: ['.dat']); // TES4
  cAssetGrass:      TAssetType = (Root: 'grass';        Ext: ['.gid']);
  cAssetPreVis:     TAssetType = (Root: 'vis';          Ext: ['.uvd']);
  cAssetSeq:        TAssetType = (Root: 'seq';          Ext: ['.seq']);
  cAssetDialogueViews:TAssetType = (Root: 'dialogueviews'; Ext: ['.xml']);
  cAssetBookArt:    TAssetType = (Root: 'bookart';      Ext: ['.dds', '.tga']); // TES3
  cAssetIcon:       TAssetType = (Root: 'icons';        Ext: ['.dds', '.tga']); // TES3

var
  ArchiveManager: TArchiveManager;
  AssetTypes: TArray<TAssetType>;


function IsArchive(const aFileName: string): Boolean;
function IsSkippedFile(const aFileName: string): Boolean;
function CreateAsset(
  const aFileName: string;
  const aAssetName: string = '';
  const aArchiveName: string = '';
  aCompressed: Boolean = False
): TAsset;


implementation

uses
  System.StrUtils;


//============================================================================
function IsArchive(const aFileName: string): Boolean;
begin
  var ext: string := LowerCase(ExtractFileExt(aFileName));
  for var s in cArchiveExtensions do
    if s = ext then begin
      Result := True;
      Exit;
    end;
  Result := False;
end;

//============================================================================
function IsSkippedFile(const aFileName: string): Boolean;
begin
  var ext: string := LowerCase(ExtractFileExt(aFileName));
  for var s in cSkippedExtensions do
    if s = ext then begin
      Result := True;
      Exit;
    end;
  Result := False;
end;

//============================================================================
function GetAssetName(const aFileName: string): string;
var
  i: Integer;
  bFound: Boolean;
begin
  Result := '';
  if aFileName = '' then
    Exit;

  var parts := aFileName.Split([TPath.DirectorySeparatorChar]);
  // remove the drive part if present
  if Pos(':', parts[0]) <> 0 then
    Delete(parts, 0, 1);

  // let's try to find the root data folder or a known asset type root folder
  bFound := False;
  i := Low(parts);
  for var part in parts do begin

    for var folder in cDataFolders do
      if SameText(part, folder) then begin
        bFound := True;
        Inc(i);
        Break;
      end;

    for var a in AssetTypes do
      if SameText(part, a.Root) then begin
        bFound := True;
        Break;
      end;

    if bFound then Break;
    Inc(i);
  end;

  if bFound then begin
    Result := String.Join(TPath.DirectorySeparatorChar, parts, i, Length(parts));
    Exit;
  end;

  // if not found then leave only the last subfolder and detect asset type by extension
  Result := parts[High(parts)];
  if Length(parts) > 1 then
    Result := TPath.Combine(parts[Pred(High(parts))], Result);

  var ext := TPath.GetExtension(parts[High(parts)]);
  for var a in AssetTypes do
    for var e in a.Ext do
        if SameText(ext, e) then begin
          Result := TPath.Combine(a.Root, Result);
          Exit;
        end;

  // we are here if extension is unknown, put into Meshes by default
  Result := TPath.Combine(cAssetMesh.Root, Result);
end;

//============================================================================
function CreateAsset(
  const aFileName: string;
  const aAssetName: string = '';
  const aArchiveName: string = '';
  aCompressed: Boolean = False
): TAsset;
begin
  Result := TAsset.Create;
  Result.FileName := aFileName;
  if aAssetName <> '' then
    Result.AssetName := aAssetName
  else
    Result.AssetName := GetAssetName(aFileName);
  Result.ArchiveName := aArchiveName;
  Result.Compressed := aCompressed;
end;

//============================================================================
function TAsset.Equals(aAsset: TAsset): Boolean;
begin
  Result :=
    SameText(AssetName, aAsset.AssetName) and
    SameText(FileName, aAsset.FileName) and
    SameText(ArchiveName, aAsset.ArchiveName);
end;

//============================================================================
function TAsset.FileNameDescr: string;
begin
  if ArchiveName = '' then
    Result := FileName
  else
    Result := ArchiveName + ' -> ' + FileName;
end;

//============================================================================
function TAsset.GetData: TBytes;
begin
  //try
    if ArchiveName <> '' then
      Result := ArchiveManager.OpenArchive(ArchiveName).ExtractFileData(FileName)
    else
      Result := TFile.ReadAllBytes(FileName);
  //except
  //  on E: Exception do
  //    raise Exception.CreateFmt('Error reading asset "%s": %s', [AssetName, E.Message]);
  //end;
end;

//============================================================================
procedure TAsset.GetDDSInfo(var aInfo: TDDSInfo);
const
  MAGIC_DDS : TMagic4 = 'DDS ';
begin
  if LowerCase(ExtractFileExt(FileName)) <> '.dds' then
    raise Exception.Create('Invalid extension for a texture, must be *.dds');

  if DDSInfo.Width = 0 then begin

    if ArchiveName <> '' then begin
      var i := ArchiveManager.IndexOf(ArchiveName);
      if (i <> -1) and (ArchiveManager[i].ArchiveType in [baFO4dds, baFO4NGdds, baFO4NG2dds, baSFdds]) then begin
        var r: PwbBSFileFO4 := ArchiveManager[i].FindFileRecord(FileName);
        if not Assigned(r) then
          raise Exception.Create('Error reading texture parameters from DDS archive');

        DDSInfo.Width := r.Width;
        DDSInfo.Height := r.Height;
        DDSInfo.MipMaps := r.NumMips;
      end;
    end;

    if DDSInfo.Width = 0 then begin
      var dds := GetData;
      if (Length(dds) < SizeOf(TDDSHeader)) or (PDDSHeader(@dds[0]).Magic <> MAGIC_DDS) then
        raise Exception.Create('Not a valid DDS file');

      DDSInfo.Width := PDDSHeader(@dds[0]).dwWidth;
      DDSInfo.Height := PDDSHeader(@dds[0]).dwHeight;
      DDSInfo.MipMaps := PDDSHeader(@dds[0]).dwMipMapCount
    end;
  end;

  aInfo := DDSInfo;
end;

//============================================================================
function TAsset.IsValidAssetName: Boolean;
begin
  Result := False;
  Result := Result or AssetName.IsEmpty;
  Result := Result or AssetName.Contains('\\');
  Result := Result or (AssetName.IndexOf('/') <> -1);
  Result := Result or (AssetName.IndexOf('\') < 1);
  Result := Result or (AssetName.LastIndexOf('\') = Pred(Length(AssetName)));
  Result := Result or not TPath.HasValidPathChars(TPath.GetDirectoryName(AssetName), False);
  Result := Result or not TPath.HasValidFileNameChars(TPath.GetFileName(AssetName), False);
  Result := Result or not TPath.IsRelativePath(TPath.GetDirectoryName(AssetName));
  Result := not Result;
end;

//============================================================================
procedure TAsset.ToJson(const js: TJsonBaseObject);
var
  arr: TJsonArray;
begin
  arr := js as TJsonArray;
  if ArchiveName <> '' then arr.Count := 4 else arr.Count := 3;
  if Compressed then arr.I[0] := 1 else arr.I[0] := 0;
  arr.S[1] := AssetName;
  arr.S[2] := IfThen(FileName = AssetName, '', FileName);
  if arr.Count = 4 then
    arr.S[3] := ArchiveName;
end;

//============================================================================
procedure TAsset.FromJson(const js: TJsonBaseObject);
var
  arr: TJsonArray;
begin
  arr := js as TJsonArray;
  Compressed := arr.I[0] <> 0;
  AssetName := arr.S[1];
  FileName := arr.S[2];
  if FileName = '' then
    FileName := AssetName;

  if arr.Count = 4 then
    ArchiveName := arr.S[3]
  else
    ArchiveName := '';
end;

//============================================================================
constructor TArchiveManager.Create;
begin
  //
end;

//============================================================================
destructor TArchiveManager.Destroy;
begin
  CloseAll;
end;

//============================================================================
function TArchiveManager.GetCount: Integer;
begin
  Result := Length(FList);
end;

//============================================================================
function TArchiveManager.Get(Index: Integer): TwbBSArchive;
begin
  Result := FList[Index];
end;

//============================================================================
function TArchiveManager.IndexOf(const aFileName: string): Integer;
begin
  for Result := Low(FList) to High(FList) do
    if SameText(FList[Result].FileName, aFileName) then
      Exit;
  Result := -1;
end;

//============================================================================
function TArchiveManager.OpenArchive(const aFileName: string): TwbBSArchive;
begin
  var i := IndexOf(aFileName);
  if i <> -1 then begin
    Result := Get(i);
    Exit;
  end;

  Result := TwbBSArchive.Create;
  try
    Result.LoadFromFile(aFileName);
    Result.MultiThreaded := True;
    FList := FList + [Result];
  except
    on E: Exception do begin
      Result.Free;
      raise Exception.CreateFmt('Error opening archive:'#13'%s'#13#13'%s', [aFileName, E.Message]);
    end;
  end;
end;

//============================================================================
procedure TArchiveManager.CloseAll;
begin
  for var arch in FList do
      arch.Free;

  SetLength(FList, 0);
end;

//============================================================================
procedure TArchiveManager.CloseArchive(const aFileName: string);
begin
  var i := IndexOf(aFileName);
  if i <> -1 then begin
    FList[i].Free;
    Delete(FList, i, 1);
  end;
end;

//============================================================================
procedure TPackingOptions.LoadSettings(const Settings: TMemIniFile);
begin
  ArchiveType := TBSArchiveType(Settings.ReadInteger('General', 'ArchiveType',
    Integer(High(TBSArchiveType))) );
  ArchiveFileName := Settings.ReadString('General', 'ArchiveFileName',
    ExtractFilePath(ParamStr(0)) + 'New' + cArchiveTypeExtensions[ArchiveType]);
  ArchiveFlags := Settings.ReadInteger('General', 'ArchiveFlags', 0);
  FileFlags := Settings.ReadInteger('General', 'FileFlags', 0);
  bAutodetectFlags := Settings.ReadBool('General', 'AutodetectFlags', True);
  bMultiThreaded := Settings.ReadBool('General', 'MultiThreaded', True);
  bSharedData := Settings.ReadBool('General', 'SharedData', True);
end;

//============================================================================
procedure TPackingOptions.SaveSettings(const Settings: TMemIniFile);
begin
  Settings.WriteInteger('General', 'ArchiveType', Integer(ArchiveType));
  Settings.WriteString('General', 'ArchiveFileName', ArchiveFileName);
  Settings.WriteInteger('General', 'ArchiveFlags', ArchiveFlags);
  Settings.WriteInteger('General', 'FileFlags', FileFlags);
  Settings.WriteBool('General', 'AutodetectFlags', bAutodetectFlags);
  Settings.WriteBool('General', 'MultiThreaded', bMultiThreaded);
  Settings.WriteBool('General', 'SharedData', bSharedData);
end;


initialization
  ArchiveManager := TArchiveManager.Create;
  AssetTypes := [
    cAssetMesh,
    cAssetTexture,
    cAssetMaterial,
    cAssetSound,
    cAssetMusic,
    cAssetScript,
    cAssetStrings,
    cAssetSpeedTree,
    cAssetVideo,
    cAssetLODSettings,
    cAssetDistantLOD,
    cAssetInterface,
    cAssetPrograms,
    cAssetMenu,
    cAssetFont,
    cAssetFacegen,
    cAssetLSData,
    cAssetGrass,
    cAssetPreVis,
    cAssetSeq,
    cAssetDialogueViews,
    cAssetBookArt,
    cAssetIcon
  ];

finalization
  if Assigned(ArchiveManager) then
    ArchiveManager.Free;

end.
