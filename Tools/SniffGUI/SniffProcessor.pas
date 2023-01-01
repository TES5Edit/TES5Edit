{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit SniffProcessor;

interface

uses
  System.Classes, System.SysUtils, System.IniFiles, System.SyncObjs,
  Vcl.Forms, Vcl.Dialogs;

type
  TGameType = (gtTES3, gtTES4, gtFO3, gtFNV, gtTES5, gtSSE, gtFO4);
  TGameTypes = set of TGameType;
  TGameResourceType = (resMesh, resTexture, resSound, resMusic, resMaterial);

  TProcBase = class;

  TProcessObject = class
    FileName: string;
  end;

  TProcManager = class
  protected
    fSettings: TMemIniFile;
    fMessages: TStringList;
    fDirectories: TStringList;
    {$IF CompilerVersion >= 34.0} { Delphi 10.4 }
    Sync: TLightweightMREW;
    {$ELSE}
    Sync: IReadWriteSync;
    {$IFEND}
    fInputDirectory: string;
    fOutputDirectory: string;
    fCopyAll: Boolean;
    fSkipOnErrors: Boolean;
    fProc: TProcBase;
    fModifiedCount: Integer;
    fProcessedCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function GameTypeName(aGameType: TGameType): string;
    procedure SetIniFile(aFile: TMemIniFile);
    procedure AddMessage(const aText: string);
    procedure AddMessages(const aStrings: TStrings);
    procedure ClearMessages;
    procedure CreateDirectory(const aPath: string);
    procedure InitializeProcessing(aProc: TProcBase);
    procedure Process(aObject: TProcessObject);

    property Settings: TMemIniFile read fSettings;
    property Messages: TStringList read fMessages;
    property InputDirectory: string read fInputDirectory write fInputDirectory;
    property OutputDirectory: string read fOutputDirectory write fOutputDirectory;
    property CopyAll: Boolean read fCopyAll write fCopyAll;
    property SkipOnErrors: Boolean read fSkipOnErrors write fSkipOnErrors;
    property Proc: TProcBase read fProc;
    property ModifiedCount: Integer read fModifiedCount;
    property ProcessedCount: Integer read fProcessedCount;
  end;

  TProcBase = class
  protected
    fManager: TProcManager;
    fTitle: string;
    fSupportedGames: TGameTypes;
    fExtensions: array of string;
    fNoOutput: Boolean;
    fThreads: Integer;

    function GetSupportedGameNames: string;
    function GetExtensionNames: string;
    function GetStorageSection: string;

    procedure StorageSetBool(const aName: string; aValue: Boolean);
    procedure StorageSetInteger(const aName: string; aValue: Integer);
    procedure StorageSetString(const aName: string; const aValue: string);
    function StorageGetBool(const aName: string; aDefaultValue: Boolean): Boolean;
    function StorageGetInteger(const aName: string; aDefaultValue: Integer): Integer;
    function StorageGetString(const aName: string; const aDefaultValue: string): string;

  public
    constructor Create(aManager: TProcManager); virtual;
    function GetFrame(aOwner: TComponent): TFrame; virtual; abstract;
    function IsAcceptedFile(const aFileName: string): Boolean;
    function ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes; virtual;

    procedure OnShow; virtual;
    procedure OnHide; virtual;
    procedure OnStart; virtual;

    property Title: string read fTitle;
    property NoOutput: Boolean read fNoOutput;
    property Threads: Integer read fThreads;
    property SupportedGameNames: string read GetSupportedGameNames;
    property ExtensionNames: string read GetExtensionNames;
    property StorageSection: string read GetStorageSection;
  end;

function SelectFolder(var aPath: string): Boolean;
function wbNormalizeResourceName(const aName: string; aResType: TGameResourceType): string;


implementation


uses
  System.IOUtils;


function SelectFolder(var aPath: string): Boolean;
begin
  with TFileOpenDialog.Create(Application.MainForm) do try
    Options := [fdoPickFolders, fdoPathMustExist];
    DefaultFolder := aPath;

    Result := Execute;
    if Result then
      aPath := FileName;

  finally
    Free;
  end;
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

constructor TProcManager.Create;
begin
  fMessages := TStringList.Create;
  fDirectories := TStringList.Create;
  fDirectories.Sorted := True;
  {$IF CompilerVersion < 34.0}
  Sync := TReadWriteSync.Create;
  {$IFEND}
end;

destructor TProcManager.Destroy;
begin
  fMessages.Free;
  fDirectories.Free;
end;

procedure TProcManager.InitializeProcessing(aProc: TProcBase);
begin
  fProc := aProc;
  fMessages.Clear;
  fDirectories.Clear;
  fModifiedCount := 0;
  fProcessedCount := 0;
end;

procedure TProcManager.Process(aObject: TProcessObject);
var
  infile, outfile, d, err: string;
  data: TBytes;
  bUpdated: Boolean;
  bSkipped: Boolean;
begin
  bUpdated := False;
  bSkipped := False;

  infile := aObject.FileName;
  try
    data := Proc.ProcessFile(fInputDirectory, fOutputDirectory, infile);
  except
    on E: Exception do begin
      if fSkipOnErrors { Pos('Unknown NIF version', E.Message) <> 0 } then begin
        bSkipped := True;
        err := E.Message;
      end else
        raise;
    end;
  end;

  AtomicIncrement(fProcessedCount);

  if not bSkipped then begin
    if Proc.NoOutput then
      Exit;

    // file has been changed
    bUpdated := Length(data) <> 0;

    // if not changed but option to copy all is checked then load original
    if not bUpdated and fCopyAll then
      data := TFile.ReadAllBytes(fInputDirectory + infile);

    // if nothing to save at this point
    if Length(data) = 0 then
      Exit;

    // saving output file
    outfile := fOutputDirectory + infile;
    d := ExtractFilePath(outfile);
    if d <> fOutputDirectory then
      CreateDirectory(d);

    TFile.WriteAllBytes(outfile, data);
  end;

  if bSkipped then
    AddMessage('Skipped: ' + infile + ': ' + err)
  else if bUpdated then begin
    AddMessage('Updated: ' + infile);
    AtomicIncrement(fModifiedCount);
  end else
    AddMessage('Unchanged: ' + infile)
end;

procedure TProcManager.AddMessage(const aText: string);
begin
  Sync.BeginWrite;
  try
    fMessages.Add(aText);
  finally
    Sync.EndWrite;
  end;
end;

procedure TProcManager.AddMessages(const aStrings: TStrings);
begin
  Sync.BeginWrite;
  try
    fMessages.AddStrings(aStrings);
  finally
    Sync.EndWrite;
  end;
end;

procedure TProcManager.ClearMessages;
begin
  fMessages.Clear;
end;

procedure TProcManager.CreateDirectory(const aPath: string);
begin
  Sync.BeginWrite;
  try
    if fDirectories.IndexOf(aPath) <> -1 then
      Exit;

    if not ForceDirectories(aPath) then
      raise Exception.Create('Can not create directory: ' + aPath);

    fDirectories.Add(aPath);
  finally
    Sync.EndWrite;
  end;
end;

function TProcManager.GameTypeName(aGameType: TGameType): string;
const
  GameNames: array[TGameType] of string = (
    'Morrowind',
    'Oblivion',
    'Fallout 3',
    'New Vegas',
    'Skyrim LE',
    'Skyrim SE',
    'Fallout 4'
  );
begin
  Result := GameNames[aGameType];
end;

procedure TProcManager.SetIniFile(aFile: TMemIniFile);
begin
  fSettings := aFile;
end;






constructor TProcBase.Create(aManager: TProcManager);
begin
  fManager := aManager;
end;

function TProcBase.GetSupportedGameNames: string;
begin
  Result := '';
  for var g: TGameType in fSupportedGames do begin
    if Result <> '' then
      Result := Result + ', ';

    Result := Result + fManager.GameTypeName(g);
  end;
end;

function TProcBase.GetExtensionNames: string;
begin
  Result := '';
  for var s: string in fExtensions do begin
    if Result <> '' then
      Result := Result + ', ';

    Result := Result + '*.' + s
  end;
end;

function TProcBase.IsAcceptedFile(const aFileName: string): Boolean;
var
  ext: string;
begin
  Result := False;
  ext := LowerCase(ExtractFileExt(aFileName));
  if ext <> '' then
    Delete(ext, 1, 1);
  for var s: string in fExtensions do
    if s = ext then Exit(True)
end;

function TProcBase.ProcessFile(const aInputDirectory, aOutputDirectory: string; var aFileName: string): TBytes;
begin

end;


function TProcBase.GetStorageSection: string;
begin
  Result := StringReplace(fTitle, ' ', '', [rfReplaceAll]);
end;

procedure TProcBase.StorageSetBool(const aName: string; aValue: Boolean);
begin
  if Assigned(fManager.Settings) then
    fManager.Settings.WriteBool(StorageSection, aName, aValue);
end;

procedure TProcBase.StorageSetInteger(const aName: string; aValue: Integer);
begin
  if Assigned(fManager.Settings) then
    fManager.Settings.WriteInteger(StorageSection, aName, aValue);
end;

procedure TProcBase.StorageSetString(const aName: string; const aValue: string);
begin
  if Assigned(fManager.Settings) then
    fManager.Settings.WriteString(StorageSection, aName, aValue);
end;

function TProcBase.StorageGetBool(const aName: string; aDefaultValue: Boolean): Boolean;
begin
  Result := aDefaultValue;
  if Assigned(fManager.Settings) then
    Result := fManager.Settings.ReadBool(StorageSection, aName, aDefaultValue);
end;

function TProcBase.StorageGetInteger(const aName: string; aDefaultValue: Integer): Integer;
begin
  Result := aDefaultValue;
  if Assigned(fManager.Settings) then
    Result := fManager.Settings.ReadInteger(StorageSection, aName, aDefaultValue);
end;

function TProcBase.StorageGetString(const aName: string; const aDefaultValue: string): string;
begin
  Result := aDefaultValue;
  if Assigned(fManager.Settings) then
    Result := fManager.Settings.ReadString(StorageSection, aName, aDefaultValue);
end;

procedure TProcBase.OnShow;
begin

end;

procedure TProcBase.OnHide;
begin

end;

procedure TProcBase.OnStart;
begin

end;

end.
