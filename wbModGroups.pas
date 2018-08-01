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
    mgifDontHide,
    mgifNotAllowed
  );
  TwbModGroupItemFlags = set of TwbModGroupItemFlag;

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

  TwbModGroupsFile = record
  private
    procedure mgfLoad;
  public
    mgfFileName: string;
    mgfModGroups: TwbModGroups;
  end;

  TwbModGroupsFiles = array of TwbModGroupsFile;

procedure wbLoadModGroups;

type
  TwbModGroupItemList = class(TStringList)
  protected
    mgilModGroup: PwbModGroup;
  public
    property ModGroup: PwbModGroup
      read mgilModGroup;
  end;

  TwbModGroupList = class(TStringList)
  protected
    function mglGetModGroup(aIndex: Integer): TwbModGroupItemList;
  public
    property ModGroups[aIndex: Integer]: TwbModGroupItemList
      read mglGetModGroup;
  end;

function wbProcessModGroups: TwbModGroupList;

implementation

uses
  System.IniFiles,
  wbHelpers;

var
  _ModGroupFiles: TwbModGroupsFiles;

procedure wbLoadModGroups;
var
  Modules      : TwbModuleInfos;
  i, j         : Integer;
  ModGroupFile : string;
begin
  _ModGroupFiles := nil;
  Modules := wbModulesByLoadOrder.FilteredByFlag(mfHasFile);
  SetLength(_ModGroupFiles, Succ(Length(Modules)));
  j := 0;
  for i := Low(Modules) to Length(Modules) do begin
    if i > High(Modules) then
      ModGroupFile := wbModGroupFileName
    else
      ModGroupFile := wbExpandFileName(ChangeFileExt(Modules[i].miOriginalName, '.modgroups'));
    if FileExists(ModGroupFile) then
      with _ModGroupFiles[j] do begin
        mgfFileName := ModGroupFile;
        mgfLoad;
        Inc(j);
      end;
  end;
  SetLength(_ModGroupFiles, j);
end;

{ TwbModGroupsFile }

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

  if aLine.StartsWith('+') then begin
    Include(mgiFlags, mgifOptional);
    Delete(aLine, 1, 1);
  end else if aLine.StartsWith('-') then begin
    Include(mgiFlags, mgifDontHide);
    Delete(aLine, 1, 1);
  end else if aLine.StartsWith('!') then begin
    Include(mgiFlags, mgifNotAllowed);
    Delete(aLine, 1, 1);
  end;

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
    SetLength(mgiCRC32s, j);
  end;

  Result := True;
end;

{ TwbModGroupList }

function TwbModGroupList.mglGetModGroup(aIndex: Integer): TwbModGroupItemList;
begin
  Result := Objects[aIndex] as TwbModGroupItemList;
end;

function wbProcessModGroups: TwbModGroupList;
begin

end;


initialization
finalization
end.

