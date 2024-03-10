{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbSteamVDFParser;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections;

type
  TSteamVDFNode = class
  private
    FName: string;
    FValue: string;
    FChildren: TObjectList<TSteamVDFNode>;
    ParentNode: TSteamVDFNode;
  public
    constructor Create;
    destructor Destroy; override;
    property Name: string read FName write FName;
    property Value: string read FValue write FValue;
    property Children: TObjectList<TSteamVDFNode> read FChildren;
    property Parent: TSteamVDFNode read ParentNode write ParentNode;
    function FindChildByName(const aName: string): TSteamVDFNode;
    function FindNodeByPath(const KeyPath: string): TSteamVDFNode;
    function GetValueByPath(const KeyPath: string): string;
  end;

  TSteamVDFParser = class
  private
    FRootNode: TSteamVDFNode;
    procedure ParseNode(const Lines: TStringList; var Index: Integer; ParentNode: TSteamVDFNode);
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromFile(const FileName: string);
    function FindNodeByPath(const KeyPath: string): TSteamVDFNode;
    function GetValueByPath(const KeyPath: string): string;
  end;

  function GetSteamInstallFolder: string;
  function GetSteamLibraryListFile: string;
  function GetInstallPathBySteamID(SteamID: string): string;
implementation

Uses
  Windows,
  Registry;

{ TSteamVDFParser }

constructor TSteamVDFParser.Create;
begin
  FRootNode := TSteamVDFNode.Create;
end;

destructor TSteamVDFParser.Destroy;
begin
  FRootNode.Free;
  inherited;
end;

procedure TSteamVDFParser.LoadFromFile(const FileName: string);
var
  Lines: TStringList;
  Index: Integer;
begin
  Lines := TStringList.Create;
  try
    Lines.LoadFromFile(FileName);
    Index := 0;
    ParseNode(Lines, Index, FRootNode);
  finally
    Lines.Free;
  end;
end;

// This parsing logic assumes the Steam formatted VDF and ACF files.
procedure TSteamVDFParser.ParseNode(const Lines: TStringList; var Index: Integer; ParentNode: TSteamVDFNode);
var
  Line: string;
  NextLine: string;
  Node: TSteamVDFNode;
begin
  while Index < Lines.Count do
  begin
    Line := Trim(Lines[Index]);
    if Lines.Count > Index + 1 then
      NextLine := Trim(Lines[Index + 1])
    else
      NextLine := '';

    Inc(Index);

    if Line = '}' then
      Break;

    Node := TSteamVDFNode.Create;
    Node.Parent := ParentNode;
    ParentNode.Children.Add(Node);

    // Parse key and value
    { Adjusted to handle nested structures and quoted strings appropriately
      Check for sub object nest as Steam stores the nesting on its own line after
      the one that would define the name }
    if Pos('{', NextLine) > 0 then
    begin
      Node.Name := StringReplace(Line,'"','',[rfReplaceAll]);
      Inc(Index);
      // Recursively parse children
      ParseNode(Lines, Index, Node);
    end
    else
    begin
      // Parse key and value for a key-value pair
      Node.Name := StringReplace(Trim(Copy(Line, 1, Pos(#9, Line) - 1)),'"','',[rfReplaceAll]);
      Node.Value := StringReplace(Trim(Copy(Line, Pos(#9, Line) + 1, MaxInt)),'"','',[rfReplaceAll]);
      Node.Value := StringReplace(Node.Value, '\\', '\',[rfReplaceAll]);
    end;
  end;
end;

function TSteamVDFNode.FindChildByName(const aName: string): TSteamVDFNode;
begin
  for var Node in Children do
    if SameText(Node.Name, aName) then
      Exit(Node);
  Result := nil;
end;

function TSteamVDFNode.FindNodeByPath(const KeyPath: string): TSteamVDFNode;
begin
  Result := nil;
  for var Key in KeyPath.Split(['\']) do begin
    if not Assigned(Result) then
      Result := Self;
    Result := Result.FindChildByName(Key);
    if not Assigned(Result) then
      Exit;
  end;
end;

function TSteamVDFParser.FindNodeByPath(const KeyPath: string): TSteamVDFNode;
begin
  Result := FRootNode.FindNodeByPath(KeyPath);
end;

function TSteamVDFParser.GetValueByPath(const KeyPath: string): string;
var
  Node: TSteamVDFNode;
begin
  Result := '';
  Node := FindNodeByPath(KeyPath);
  if Assigned(Node) then
    Result := Node.Value;
end;

function TSteamVDFNode.GetValueByPath(const KeyPath: string): string;
var
  Node: TSteamVDFNode;
begin
  Result := '';
  Node := FindNodeByPath(KeyPath);
  if Assigned(Node) then
    Result := Node.Value;
end;

{ TSteamVDFNode }

constructor TSteamVDFNode.Create;
begin
  FChildren := TObjectList<TSteamVDFNode>.Create;
end;

destructor TSteamVDFNode.Destroy;
begin
  FChildren.Free;
  inherited;
end;

// Returns empty string if it could not find the registry key with a path or the path does not exist.
function GetSteamInstallFolder: string;
const
  sSteamKey   = '\SOFTWARE\Valve\Steam\';
  sRegKey     = 'InstallPath';
var
  s: string;
begin
  Result := '';
  with TRegistry.Create do try
    Access  := KEY_READ or KEY_WOW64_32KEY;
    RootKey := HKEY_LOCAL_MACHINE;

    if not OpenKey(sSteamKey, False) then begin
      Access := KEY_READ or KEY_WOW64_64KEY;
      if not OpenKey(sSteamKey, False) then begin
        Result := '';
        Exit;
      end;
    end;

    s := ReadString(sRegKey);
    s := StringReplace(s, '"', '', [rfReplaceAll]);
    if DirectoryExists(s) then
      Result := s;
  finally
    Free;
  end;
end;

// Returns empty string if the determined library folder doesn't exist.
function GetSteamLibraryListFile: string;
var
  sSteamFolder: string;
begin
  sSteamFolder := GetSteamInstallFolder;
  if sSteamFolder = '' then
    Result := ''
  else
    Result := sSteamFolder + '\SteamApps\libraryfolders.vdf';

  if not FileExists(Result) then
    Result := '';
end;

// Returns empty string if it could not locate the game path.
function GetInstallPathBySteamID(SteamID: string): string;
var
  SteamParser: TSteamVDFParser;
  LibraryFolder: string;
  LibraryFile: string;
begin
  Result := '';
  LibraryFolder := '';

  if SteamID = '' then
    Exit;

  LibraryFile := GetSteamLibraryListFile;
  if LibraryFile = '' then
    Exit;

  SteamParser := TSteamVDFParser.Create;
  try
    SteamParser.LoadFromFile(LibraryFile);
    var lRootNode := SteamParser.FindNodeByPath('libraryfolders');
    if not Assigned(lRootNode) then
      Exit; // this should only happen if the library file is corrupted
    for var Node in lRootNode.Children do
    begin
      var lMatch := Node.FindNodeByPath('apps\'+SteamID);
      if Assigned(lMatch) then
      begin
        LibraryFolder := lMatch.Parent.Parent.GetValueByPath('path');
        break;
      end;
    end;
  finally
    SteamParser.Free;
  end;

  if LibraryFolder = '' then
    Exit;

  var lAppsFolder := LibraryFolder + '\SteamApps\';
  var lManifestFile := lAppsFolder+'appmanifest_'+SteamID+'.acf';
  if not FileExists(lManifestFile) then
    Exit;
  SteamParser := TSteamVDFParser.Create;
  try
    SteamParser.LoadFromFile(lManifestFile);
    var lFolder := SteamParser.GetValueByPath('AppState\installdir');
    if lFolder <> '' then
    begin
      var lFullPath := lAppsFolder + 'common\' + lFolder;
      if DirectoryExists(lFullPath) then
        Result := lFullPath;
    end;
  finally
    SteamParser.Free;
  end;

end;

end.

