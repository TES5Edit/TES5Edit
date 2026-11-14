{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

{
  Locates the Steam client and installed Steam games.

  Both functions always return a trimmed, unquoted path without a trailing
  backslash, or '' when nothing valid was found. They never raise.
}
unit wbSteamTools;

interface

/// Folder of the Steam client, e.g. 'C:\Program Files (x86)\Steam', or ''.
function GetSteamInstallFolder: string;

/// Install folder of a Steam app, e.g. '...\steamapps\common\Skyrim Special Edition', or ''.
/// aSteamID is the numeric app ID ('489830'); surrounding whitespace is ignored.
function GetInstallPathBySteamID(const aSteamID: string): string;

implementation

uses
  System.SysUtils,
  System.Generics.Collections,
  System.Win.Registry,
  Winapi.Windows,

  wbKeyValues;

{ Helpers --------------------------------------------------------------------- }

/// Trims, removes quotes (never valid in a Windows path), normalises '/' to '\'
/// and drops a trailing backslash (except on a drive root such as 'C:\').
function CleanPath(const aPath: string): string;
begin
  Result := Trim(StringReplace(aPath, '"', '', [rfReplaceAll]));
  Result := StringReplace(Result, '/', '\', [rfReplaceAll]);
  if (Length(Result) > 3) then
    Result := ExcludeTrailingPathDelimiter(Result);
end;

function JoinPath(const aBase, aName: string): string;
begin
  Result := IncludeTrailingPathDelimiter(aBase) + aName;
end;

function IsAllDigits(const s: string): Boolean;
var
  c: Char;
begin
  Result := s <> '';
  for c in s do
    if not CharInSet(c, ['0'..'9']) then
      Exit(False);
end;

function ReadRegistryString(aRootKey: HKEY; aView: LongWord; const aKey, aName: string): string;
var
  lRegistry: TRegistry;
begin
  Result := '';
  try
    lRegistry := TRegistry.Create(KEY_READ or aView);
    try
      lRegistry.RootKey := aRootKey;
      if lRegistry.OpenKey(aKey, False) then
      try
        if lRegistry.ValueExists(aName) then
          Result := lRegistry.ReadString(aName);
      finally
        lRegistry.CloseKey;
      end;
    finally
      lRegistry.Free;
    end;
  except
    Result := ''; // wrong value type, access denied, ...
  end;
end;

{ Libraries ------------------------------------------------------------------- }

/// Adds aPath once (case-insensitive). Preferred paths go to the front.
procedure AddLibrary(aList: TList<string>; const aPath: string; aPreferred: Boolean);
var
  lPath: string;
  i: Integer;
begin
  lPath := CleanPath(aPath);
  if lPath = '' then
    Exit;

  for i := 0 to aList.Count - 1 do
    if SameText(aList[i], lPath) then
    begin
      if aPreferred and (i > 0) then
        aList.Move(i, 0);
      Exit;
    end;

  if aPreferred then
    aList.Insert(0, lPath)
  else
    aList.Add(lPath);
end;

/// Fills aList with every Steam library folder. The library whose "apps" list
/// names aAppID (if any) comes first, so it is checked first; the others are
/// still checked because that list can be stale.
procedure CollectLibraryFolders(const aSteamFolder, aAppID: string; aList: TList<string>);
var
  lDoc, lFolders, lEntry: TKeyValues;
  lPath: string;
begin
  lDoc := TKeyValues.Create;
  try
    if lDoc.TryLoadFromFile(JoinPath(aSteamFolder, 'steamapps\libraryfolders.vdf')) then
    begin
      lFolders := lDoc.GetKey('libraryfolders');
      if Assigned(lFolders) then
        for lEntry in lFolders do
        begin
          if lEntry.IsSection then
          begin
            // Current format:  "0" { "path" "D:\\SteamLibrary"  "apps" { "489830" "..." } }
            if lEntry.TryGetString('path', lPath) then
              AddLibrary(aList, lPath, lEntry.HasKey('apps/' + aAppID));
          end
          else if IsAllDigits(lEntry.Name) then
            // Pre-2021 format:  "1"  "D:\\SteamLibrary"
            AddLibrary(aList, lEntry.Value, False);
        end;
    end;
  finally
    lDoc.Free;
  end;

  // The Steam folder is always a library, even when the file doesn't list it.
  AddLibrary(aList, aSteamFolder, False);
end;

/// Reads <library>\steamapps\appmanifest_<id>.acf and returns the game folder.
function GetInstallPathFromLibrary(const aLibrary, aAppID: string): string;
var
  lAppsFolder, lManifest, lInstallDir, lFullPath: string;
  lManifestDoc: TKeyValues;
begin
  Result := '';
  lAppsFolder := JoinPath(aLibrary, 'steamapps');
  lManifest := JoinPath(lAppsFolder, 'appmanifest_' + aAppID + '.acf');
  if not FileExists(lManifest) then
    Exit;

  lManifestDoc := TKeyValues.Create;
  try
    if not lManifestDoc.TryLoadFromFile(lManifest) then
      Exit;
    if not lManifestDoc.TryGetString('AppState/installdir', lInstallDir) then
      Exit;
  finally
    lManifestDoc.Free;
  end;

  lInstallDir := CleanPath(lInstallDir);
  if lInstallDir = '' then
    Exit;

  if ExtractFileDrive(lInstallDir) <> '' then
    lFullPath := lInstallDir // already absolute
  else
    lFullPath := CleanPath(JoinPath(JoinPath(lAppsFolder, 'common'), lInstallDir));

  if DirectoryExists(lFullPath) then
    Result := lFullPath;
end;

{ Public API ------------------------------------------------------------------ }

function GetSteamInstallFolder: string;
const
  cMachineKey = 'SOFTWARE\Valve\Steam';
  cUserKey    = 'Software\Valve\Steam';
var
  lCandidates: array[0..2] of string;
  lCandidate: string;
begin
  Result := '';
  try
    lCandidates[0] := ReadRegistryString(HKEY_LOCAL_MACHINE, KEY_WOW64_32KEY, cMachineKey, 'InstallPath');
    lCandidates[1] := ReadRegistryString(HKEY_LOCAL_MACHINE, KEY_WOW64_64KEY, cMachineKey, 'InstallPath');
    // Per-user fallback, written by the client itself (uses forward slashes).
    lCandidates[2] := ReadRegistryString(HKEY_CURRENT_USER, 0, cUserKey, 'SteamPath');

    for lCandidate in lCandidates do
    begin
      Result := CleanPath(lCandidate);
      if (Result <> '') and DirectoryExists(Result) then
        Exit;
    end;
    Result := '';
  except
    Result := '';
  end;
end;

function GetInstallPathBySteamID(const aSteamID: string): string;
var
  lAppID, lSteamFolder, lLibrary: string;
  lLibraries: TList<string>;
begin
  Result := '';
  try
    lAppID := Trim(aSteamID);
    if not IsAllDigits(lAppID) then // also blocks path tricks in the manifest name
      Exit;

    lSteamFolder := GetSteamInstallFolder;
    if lSteamFolder = '' then
      Exit;

    lLibraries := TList<string>.Create;
    try
      CollectLibraryFolders(lSteamFolder, lAppID, lLibraries);
      for lLibrary in lLibraries do
      begin
        Result := GetInstallPathFromLibrary(lLibrary, lAppID);
        if Result <> '' then
          Exit;
      end;
    finally
      lLibraries.Free;
    end;
  except
    Result := '';
  end;
end;

end.
