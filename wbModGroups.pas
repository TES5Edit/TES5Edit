{******************************************************************************

     The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

*******************************************************************************}

unit wbModGroups;

{$I wbDefines.inc}

interface

uses
  System.Types,
  System.Classes,
  System.SysUtils,
  wbInterface,
  wbLoadOrder;

type
  TwbModGroupItemFlag = (
    mgifOptional,
    mgifIsTarget,
    mgifIsSource,
    mgifForbidden
  );
  TwbModGroupItemFlags = set of TwbModGroupItemFlag;

  PwbModGroupItem = ^TwbModGroupItem;
  TwbModGroupItem = record
  private
    function mgiLoad(aLine: string): Boolean;
  public
    mgiFileName : string;
    mgiModule   : PwbModuleInfo;
    mgiFlags    : TwbModGroupItemFlags;
    mgiCRC32s   : TwbCRC32s;
  end;
  TwbModGroupItems = array of TwbModGroupItem;

  PwbModGroup = ^TwbModGroup;
  TwbModGroup = record
  private
    procedure mgLoad(aLines: TStrings);
  public
    mgName  : string;
    mgItems : TwbModGroupItems;
  end;
  TwbModGroups = array of TwbModGroup;

  PwbModGroupsFile = ^TwbModGroupsFile;
  TwbModGroupsFile = record
  private
    procedure mgfLoad;
    procedure mgfCheckValid;
  public
    mgfFileName  : string;
    mgfModules   : TwbModuleInfos;
    mgfModGroups : TwbModGroups;
  end;

  TwbModGroupsFiles = array of TwbModGroupsFile;

procedure wbLoadModGroups;

implementation

uses
  System.IniFiles,
  wbHelpers;

var
  _ModGroupFiles : TwbModGroupsFiles;

procedure wbLoadModGroups;
var
  ModGroupFilesByName : TStringList;
  Modules             : TwbModuleInfos;
  i, j, k             : Integer;
  ModGroupFileName    : string;
  ModGroupFile        : PwbModGroupsFile;
begin
  _ModGroupFiles := nil;
  try
    ModGroupFilesByName := TStringList.Create;
    try
      ModGroupFilesByName.Sorted := True;
      ModGroupFilesByName.Duplicates := dupError;
      Modules := wbModulesByLoadOrder{.FilteredByFlag(mfHasFile)};
      SetLength(_ModGroupFiles, Succ(Length(Modules)));
      j := 0;
      for i := Low(Modules) to Length(Modules) do begin
        if i > High(Modules) then
          ModGroupFileName := wbModGroupFileName
        else
          ModGroupFileName := wbExpandFileName(ChangeFileExt(Modules[i].miOriginalName, '.modgroups'));

        ModGroupFile := nil;
        if ModGroupFilesByName.Find(ModGroupFileName, k) then
          ModGroupFile := Pointer(ModGroupFilesByName.Objects[k])
        else
          if FileExists(ModGroupFileName) then begin
            ModGroupFile := @_ModGroupFiles[j];
            with ModGroupFile^ do begin
              mgfFileName := ModGroupFileName;
              mgfLoad;
              Inc(j);
            end;

          end;
        if Assigned(ModGroupFile) and (i <= High(Modules)) then
          with ModGroupFile^ do begin
            SetLength(mgfModules, Succ(Length(mgfModules)));
            mgfModules[High(mgfModules)] := Modules[i];
          end;
      end;
    finally
      ModGroupFilesByName.Free;
    end;
    SetLength(_ModGroupFiles, j);
  except
    _ModGroupFiles := nil;
    raise;
  end;
end;

{ TwbModGroupsFile }

procedure TwbModGroupsFile.mgfCheckValid;
begin
  //...
end;

procedure TwbModGroupsFile.mgfLoad;
var
  Sections : TStringList;
  Section  : TStringList;
  i        : Integer;
begin
  mgfModGroups := nil;
  with TMemIniFile.Create(mgfFileName) do try
    Sections := TStringList.Create;
    Section := TStringList.Create;
    try
      ReadSections(Sections);
      SetLength(mgfModGroups, Sections.Count);
      for i := Low(mgfModGroups) to High(mgfModGroups) do
        with mgfModGroups[i] do begin
          mgName := Sections[i];
          ReadSectionValues(mgName, Section);
          mgLoad(Section);
        end;
    finally
      Section.Free;
      Sections.Free;
    end;
  finally
    Free;
  end;
end;

{ TwbModGroup }

procedure TwbModGroup.mgLoad(aLines: TStrings);
var
  i, j: Integer;
begin
  mgItems := nil;
  SetLength(mgItems, aLines.Count);
  j := 0;
  for i := 0 to Pred(aLines.Count) do
    if mgItems[j].mgiLoad(aLines[i]) then
      Inc(j);
  SetLength(mgItems, j);
end;

{ TwbModGroupItem }

function TwbModGroupItem.mgiLoad(aLine: string): Boolean;
var
  Fragments : TArray<string>;
  i, j      : Integer;
begin
  mgiFileName := '';
  mgiModule   := nil;
  mgiFlags    := [];
  mgiCRC32s   := nil;

  aLine := aLine.Trim;
  if aLine.IsEmpty or aLine.StartsWith(';') then
    Exit(False);

  Include(mgiFlags, mgifIsTarget);
  Include(mgiFlags, mgifIsSource);

  j := 1;
  while j <= Length(aLine) do begin
    case aLine[1] of
      ' ': {};
      '+': Include(mgiFlags, mgifOptional);
      '-': begin //neither hides nor is being hidden
             Exclude(mgiFlags, mgifIsTarget);
             Exclude(mgiFlags, mgifIsSource);
           end;
      '!': Include(mgiFlags, mgifForbidden);
      '@': Exclude(mgiFlags, mgifIsSource); //being hidden, doesn't hide others
      '#': Exclude(mgiFlags, mgifIsTarget); //hides others, isn't being hidden
    else
      Break;
    end;
    Inc(j);
  end;
  if j > 1 then
    Delete(aLine, 1, Pred(j));

  aLine := aLine.Trim;
  if aLine.IsEmpty then
    Exit(False);

  Fragments := aLine.Split([':']).ForEach(Trim);
  if Length(Fragments) > 2 then
    Exit(False);

  mgiFileName := Fragments[0];
  if mgiFileName.IsEmpty then
    Exit;

  mgiModule := wbModuleByName(mgiFileName);

  if Length(Fragments) > 1 then begin
    Fragments := Fragments[1].Split([',']).ForEach(Trim).RemoveEmpty;
    j := 0;
    SetLength(mgiCRC32s, Length(Fragments));
    for i := Low(Fragments) to High(Fragments) do
      if mgiCRC32s[j].AssignFromString(Fragments[i]) then
        Inc(j);
    if j = 0 then
      mgiCRC32s := [$FFFFFFFF]
    else
      SetLength(mgiCRC32s, j);
  end;

  Result := True;
end;


initialization
finalization
end.

