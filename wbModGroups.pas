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
    mgifForbidden,
    mgifIgnoreLoadOrderAlways,
    mgifIgnoreLoadOrderInBlock,

    mgifValid,
    mgifValidChecked,
    mgifHasFile
  );
  TwbModGroupItemFlags = set of TwbModGroupItemFlag;

  PwbModGroupItem = ^TwbModGroupItem;
  TwbModGroupItem = record
  private
    function mgiLoad(aLine: string): Boolean;
    procedure mgiCheckValid(aForce: Boolean);
    procedure mgiFlagFilesMissingCRC;
    function mgiNeedsCRCUpdateForTaggedFiles(aAdd, aUpdate: Boolean): Boolean;
    function mgiUpdateCRC(aAdd, aUpdate: Boolean): Boolean;
  public
    mgiFlags     : TwbModGroupItemFlags;
    mgiFileName  : string;
    mgiModule    : PwbModuleInfo;
    mgiCRC32s    : TwbCRC32s;
    mgiValidMsgs : TwbMessages;

    function ToString: string;
  end;
  TwbModGroupItems = array of TwbModGroupItem;
  TwbModGroupItemPtrs = array of PwbModGroupItem;

  TwbModGroupFlag = (
    mgfNone,
    mgfValid,
    mgfValidChecked,
    mgfTagged,
    mgfNeedCRCUpdate
  );
  TwbModGroupFlags = set of TwbModGroupFlag;

  PwbModGroup = ^TwbModGroup;
  TwbModGroupPtrs = array of PwbModGroup;

  PwbModGroupsFile = ^TwbModGroupsFile;

  TwbModGroup = record
  private
    procedure mgLoad(aLines: TStrings);
    procedure mgCheckValid(aForce: Boolean);
    procedure mgAddSelfTo(var aList: TwbModGroupPtrs; aValidOnly: Boolean);
    procedure mgTagTargetFiles(aSource: PwbModuleInfo);
    procedure mgFlagFilesMissingCRC;
    procedure mgFlagModGroupsNeedingCRCUpdateForTaggedFiles(aAdd, aUpdate: Boolean);
    function mgUpdateCRC(aAdd, aUpdate: Boolean): Boolean;
    procedure mgSaveToFile;
  public
    mgModGroupsFile : PwbModGroupsFile;
    mgFlags         : TwbModGroupFlags;
    mgName          : string;
    mgItems         : TwbModGroupItems;
    mgValidMsgs     : TwbMessages;

    function IsValid: Boolean;
    function ToString: string;
    function ToStrings: TArray<string>;
    function GetValidationMessages: TwbMessagePtrs;
  end;
  TwbModGroups = array of TwbModGroup;

  TwbModGroupPtrsHelper = record helper for TwbModGroupPtrs
  public
    procedure ExcludeAll(aFlag: TwbModGroupFlag);
    procedure IncludeAll(aFlag: TwbModGroupFlag);

    function FilteredByFlag(aFlag: TwbModGroupFlag): TwbModGroupPtrs;
    function FilteredBy(const aFunc: TFunc<PwbModGroup, Boolean>): TwbModGroupPtrs;

    function ToString: string;

    function Activate: Boolean;
    procedure ShowValidationMessages;
    procedure FlagFilesMissingCRC;
    procedure FlagModGroupsNeedingCRCUpdateForTaggedFiles(aAdd, aUpdate: Boolean);
    function UpdateCRC(aAdd, aUpdate: Boolean): Integer;
  end;

  TwbModGroupFileFlag = (
    mgffValid,
    mgffValidChecked
  );
  TwbModGroupFileFlags = set of TwbModGroupFileFlag;

  TwbModGroupsFile = record
  private
    procedure mgfLoad;
    procedure mgfCheckValid(aForce: Boolean);
    procedure mgfAddModGroupsTo(var aList: TwbModGroupPtrs; aValidOnly: Boolean);
    function mgfAnyModuleHasFile: Boolean;
  public
    mgfFlags     : TwbModGroupFileFlags;
    mgfFileName  : string;
    mgfModules   : TwbModuleInfos;
    mgfModGroups : TwbModGroups;
  end;

  TwbModGroupsFiles = array of TwbModGroupsFile;

  TwbModGroupsFilesHelper = record helper for TwbModGroupsFiles
  private
    procedure mgfsAddModGroupsTo(var aList: TwbModGroupPtrs; aValidOnly: Boolean);
  end;

function wbModGroupsByName(aValidOnly: Boolean = True): TwbModGroupPtrs;
procedure wbReloadModGroups;

implementation

uses
  System.IniFiles,
  wbHelpers,
  wbSort;

var
  _ModGroupFiles       : TwbModGroupsFiles;
  _ModGroupFilesLoaded : Boolean;

procedure wbLoadModGroups;
var
  ModGroupFilesByName : TStringList;
  Modules             : TwbModuleInfos;
  i, j, k             : Integer;
  ModGroupFileName    : string;
  ModGroupFile        : PwbModGroupsFile;
begin
  if _ModGroupFilesLoaded then
    Exit;
  _ModGroupFilesLoaded := True;

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
            ModGroupFilesByName.AddObject(ModGroupFileName, Pointer(ModGroupFile));
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
  for i := Low(_ModGroupFiles) to High(_ModGroupFiles) do
    _ModGroupFiles[i].mgfCheckValid(True);
end;

procedure wbReloadModGroups;

begin
  _ModGroupFilesLoaded := False;
  wbLoadModGroups;
end;


{ TwbModGroupsFile }

procedure TwbModGroupsFile.mgfAddModGroupsTo(var aList: TwbModGroupPtrs; aValidOnly: Boolean);
var
  i: Integer;
begin
  if aValidOnly then begin
    mgfCheckValid(False);
    if not (mgffValid in mgfFlags) then
      Exit;
  end;
  for i := Low(mgfModGroups) to High(mgfModGroups) do
    mgfModGroups[i].mgAddSelfTo(aList, aValidOnly);
end;

function TwbModGroupsFile.mgfAnyModuleHasFile: Boolean;
begin
  Result := Length(mgfModules.FilteredByFlag(mfHasFile)) > 0;
end;

procedure TwbModGroupsFile.mgfCheckValid(aForce: Boolean);
var
  i         : Integer;
  AnyValid  : Boolean;
  AnyModule : Boolean;
begin
  if (mgffValidChecked in mgfFlags) and not aForce then
    Exit;
  Include(mgfFlags, mgffValidChecked);

  Exclude(mgfFlags, mgffValid);
  AnyValid := False;
  for i := Low(mgfModGroups) to High(mgfModGroups) do
    with mgfModGroups[i] do begin
      mgModGroupsFile := @Self;
      mgCheckValid(aForce);
      AnyValid := AnyValid or (mgfValid in mgFlags);
    end;

  if (Length(mgfModules) < 1) or (Length(mgfModules.FilteredByFlag(mfHasFile)) > 0) then
    if AnyValid then
      Include(mgfFlags, mgffValid);
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

function TwbModGroup.GetValidationMessages: TwbMessagePtrs;
var
  i: Integer;
begin
  Result := nil;
  for i := Low(mgItems) to High(mgItems) do
    Result.AddMessages(mgItems[i].mgiValidMsgs);
  Result.AddMessages(mgValidMsgs);
end;

function TwbModGroup.IsValid: Boolean;
begin
  mgCheckValid(True);
  Result := mgfValid in mgFlags;
end;

procedure TwbModGroup.mgAddSelfTo(var aList: TwbModGroupPtrs; aValidOnly: Boolean);
begin
  if aValidOnly then begin
    mgCheckValid(False);
    if not (mgfValid in mgFlags) then
      Exit;
  end;

  SetLength(aList, Succ(Length(aList)));
  aList[High(aList)] := @Self;
end;

procedure TwbModGroup.mgCheckValid(aForce: Boolean);
var
  i                         : Integer;
  AnyInvalid                : Boolean;
  SourceCount               : Integer;
  TargetCount               : Integer;
  LastLoadOrder             : Integer;
  LastLoadOrderIndex        : Integer;
  HighLoadOrderInBlock      : Integer;
  HighLoadOrderInBlockIndex : Integer;
begin
  if (mgfValidChecked in mgFlags) and not aForce then
    Exit;
  Include(mgFlags, mgfValidChecked);
  mgValidMsgs.Clear;

  Exclude(mgFlags, mgfValid);
  AnyInvalid := False;
  SourceCount := 0;
  TargetCount := 0;
  LastLoadOrder := -1;
  HighLoadOrderInBlock := -1;
  LastLoadOrderIndex := -1;
  HighLoadOrderInBlockIndex := -1;
  for i := Low(mgItems) to High(mgItems) do
    with mgItems[i] do begin
      mgiCheckValid(aForce);
      if mgifValid in mgiFlags then begin
        if mgifHasFile in mgiFlags then begin
          if mgifIsSource in mgiFlags then
            if TargetCount > 0 then
              Inc(SourceCount)
            else
              if i > 0 then
                mgValidMsgs.AddMessage(wbmtHint, Format('"%s" is ignored as a source as it has no valid targets above it', [mgiFileName]));

          if mgifIsTarget in mgiFlags then
            Inc(TargetCount);

          if not (mgifIgnoreLoadOrderAlways in mgiFlags) then begin

            if mgifIgnoreLoadOrderInBlock in mgiFlags then begin
              if mgiModule.miLoadOrder > HighLoadOrderInBlock then begin
                HighLoadOrderInBlock := mgiModule.miLoadOrder;
                HighLoadOrderInBlockIndex := i;
            end end else
              if HighLoadOrderInBlock >= 0 then begin
                if HighLoadOrderInBlock > LastLoadOrder then begin
                  LastLoadOrder := HighLoadOrderInBlock;
                  LastLoadOrderIndex := HighLoadOrderInBlockIndex;
                end;
                HighLoadOrderInBlock := -1;
              end;

            if LastLoadOrder >= 0 then
              if mgiModule.miLoadOrder < LastLoadOrder then begin
                AnyInvalid := True;
                mgValidMsgs.AddMessage(wbmtError, Format('"%s" has a lower load order than "%s"', [mgiFileName, mgItems[LastLoadOrderIndex].mgiFileName]));
              end;

            if not (mgifIgnoreLoadOrderInBlock in mgiFlags) then begin
              LastLoadOrder := mgiModule.miLoadOrder;
              LastLoadOrderIndex := i;
            end;
          end;

        end;
      end else
        AnyInvalid := True
    end;
  if SourceCount < 1 then
    mgValidMsgs.AddMessage(wbmtError, 'No active sources');
  if not AnyInvalid and (SourceCount > 0) then
    Include(mgFlags, mgfValid);
end;

procedure TwbModGroup.mgFlagFilesMissingCRC;
var
  i: Integer;
begin
  for i := Low(mgItems) to High(mgItems) do
    mgItems[i].mgiFlagFilesMissingCRC;
end;

procedure TwbModGroup.mgFlagModGroupsNeedingCRCUpdateForTaggedFiles(aAdd, aUpdate: Boolean);
var
  i: Integer;
begin
  for i := Low(mgItems) to High(mgItems) do
    if mgItems[i].mgiNeedsCRCUpdateForTaggedFiles(aAdd, aUpdate) then begin
      Include(mgFlags, mgfNeedCRCUpdate);
      Exit;
    end;
end;

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

procedure TwbModGroup.mgSaveToFile;
var
  sl: TStringList;
begin
  if not Assigned(mgModGroupsFile) then
    Exit;

  sl := TStringList.Create;
  try
    with TMemIniFile.Create(mgModGroupsFile.mgfFileName) do try
      EraseSection(mgName);
      GetStrings(sl);
    finally
      Free;
    end;
    sl.AddStrings(ToStrings);
    sl.SaveToFile(mgModGroupsFile.mgfFileName);
  finally
    sl.Free;
  end;
end;

procedure TwbModGroup.mgTagTargetFiles(aSource: PwbModuleInfo);
var
  i, j : Integer;
begin
  mgCheckValid(False);
  if not (mgfValid in mgFlags) then
    Exit;

  for i := Low(mgItems) to High(mgItems) do
    if mgItems[i].mgiModule = aSource then
      with mgItems[i] do
        if mgiFlags * [mgifIsSource, mgifHasFile] = [mgifIsSource, mgifHasFile] then
          for j := Pred(i) downto Low(mgItems) do
            with mgItems[j] do
              if Assigned(mgiModule) and (mgiFlags * [mgifIsTarget, mgifHasFile] = [mgifIsTarget, mgifHasFile]) then
                Include(mgiModule.miFlags, mfIsModGroupTarget);
end;

function TwbModGroup.mgUpdateCRC(aAdd, aUpdate: Boolean): Boolean;
var
  i        : Integer;
begin
  Result := False;
  for i := Low(mgItems) to High(mgItems) do
    Result := mgItems[i].mgiUpdateCRC(aAdd, aUpdate) or Result;
  if Result then
    mgSaveToFile;
end;

function TwbModGroup.ToString: string;
var
  i: Integer;
begin
  with TStringList.Create do try
    Add('[' + mgName + ']');
    for i := Low(mgItems) to High(mgItems) do
      Add(mgItems[i].ToString);
    Result := Text;
  finally
    Free;
  end;
end;

function TwbModGroup.ToStrings: TArray<string>;
var
  i: Integer;
begin
  with TStringList.Create do try
    Add('[' + mgName + ']');
    for i := Low(mgItems) to High(mgItems) do
      Add(mgItems[i].ToString);
    Result := ToStringArray;
  finally
    Free;
  end;
end;

{ TwbModGroupItem }

procedure TwbModGroupItem.mgiFlagFilesMissingCRC;
var
  CRC32: TwbCRC32;
begin
  if mgifForbidden in mgiFlags then
    Exit;
  if not Assigned(mgiModule) then
    Exit;
  if mgiModule.GetCRC32(CRC32) then
    if Length(mgiCRC32s) > 0 then begin
      if not mgiCRC32s.Contains(CRC32) then
        Include(mgiModule.miFlags, mfModGroupMissingCurrentCRC);
    end else
      Include(mgiModule.miFlags, mfModGroupMissingAnyCRC);
end;

procedure TwbModGroupItem.mgiCheckValid(aForce: Boolean);
const
  NoCRCMatch = '%s module "%s" is present, but will be ignored as it doesn''t match any of the specified CRC32s';
begin
  if (mgifValidChecked in mgiFlags) and not aForce then
    Exit;
  mgiValidMsgs.Clear;
  Include(mgiFlags, mgifValidChecked);

  mgiFlags := mgiFlags - [mgifValid, mgifHasFile];

  if Assigned(mgiModule) then
    if Assigned(mgiModule.miFile) then begin
      if Length(mgiCRC32s) > 0 then begin
        if mgiCRC32s.Contains(mgiModule._File.CRC32) then
          Include(mgiFlags, mgifHasFile)
        else begin
          if mgifForbidden in mgiFlags then
            mgiValidMsgs.AddMessage(wbmtHint, Format(NoCRCMatch, ['Forbidden', mgiFileName]))
          else if mgifOptional in mgiFlags then
            mgiValidMsgs.AddMessage(wbmtWarning, Format(NoCRCMatch, ['Optional', mgiFileName]))
          else
            mgiValidMsgs.AddMessage(wbmtError, Format(NoCRCMatch, ['Required', mgiFileName]))
        end;
      end else
        Include(mgiFlags, mgifHasFile);
    end;

  if mgiFlags * [mgifHasFile, mgifForbidden] = [mgifHasFile, mgifForbidden]  then
    Exit;

  if mgiFlags * [mgifHasFile, mgifOptional] <> []  then
    Include(mgiFlags, mgifValid);
end;

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
    case aLine[j] of
      ' ': {};
      '+': Include(mgiFlags, mgifOptional);
      '-': begin //neither hides nor is being hidden
             Exclude(mgiFlags, mgifIsTarget);
             Exclude(mgiFlags, mgifIsSource);
           end;
      '!': begin
             Include(mgiFlags, mgifForbidden);
             Exclude(mgiFlags, mgifIsTarget);
             Exclude(mgiFlags, mgifIsSource);
            end;
      '@': Exclude(mgiFlags, mgifIsSource); //being hidden, doesn't hide others
      '#': Exclude(mgiFlags, mgifIsTarget); //hides others, isn't being hidden
      '}': Include(mgiFlags, mgifIgnoreLoadOrderAlways);
      '{': Include(mgiFlags, mgifIgnoreLoadOrderInBlock);
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

function TwbModGroupItem.mgiNeedsCRCUpdateForTaggedFiles(aAdd, aUpdate: Boolean): Boolean;
var
  CRC32: TwbCRC32;
begin
  Result := False;
  if mgifForbidden in mgiFlags then
    Exit;
  if not Assigned(mgiModule) then
    Exit;
  if not (mfTagged in mgiModule.miFlags) then
    Exit;
  if mgiModule.GetCRC32(CRC32) then
    if Length(mgiCRC32s) > 0 then begin
      if not mgiCRC32s.Contains(CRC32) then
        Result := aUpdate
    end else
      Result := aAdd;
end;

function TwbModGroupItem.mgiUpdateCRC(aAdd, aUpdate: Boolean): Boolean;
var
  CRC32: TwbCRC32;
begin
  Result := False;
  if mgifForbidden in mgiFlags then
    Exit;
  if not Assigned(mgiModule) then
    Exit;
  if not mgiModule.GetCRC32(CRC32) then
    Exit;

  if Length(mgiCRC32s) > 0 then begin
    if not mgiCRC32s.Contains(CRC32) then
      Result := aUpdate
  end else
    Result := aAdd;

  if Result then
    mgiCRC32s.Add(CRC32);
end;

function TwbModGroupItem.ToString: string;
var
  i: Integer;
begin
  Result := '';
  if mgifIgnoreLoadOrderAlways in mgiFlags then
    Result := '}'
  else if mgifIgnoreLoadOrderInBlock in mgiFlags then
    Result := '{';

  if mgifForbidden in mgiFlags then
    Result := Result + '!'
  else if mgifOptional in mgiFlags then
    Result := Result + '+';

  if mgifIsTarget in mgiFlags then
    if mgifIsSource in mgiFlags then
      Result := Result
    else
      Result := Result + '@'
  else
    if mgifIsSource in mgiFlags then
      Result := Result + '#'
    else
      Result := Result + '-';

  Result := Result + mgiFileName;

  if Length(mgiCRC32s) > 0 then begin
    Result := Result + ':';
    for i := Low(mgiCRC32s) to High(mgiCRC32s) do begin
      if i > Low(mgiCRC32s) then
        Result := Result + ',';
      Result := Result + mgiCRC32s[i].ToString;
    end;
  end;
end;

function CompareModGroupPtrsByName(Item1, Item2: Pointer): Integer;

begin

  Result := CompareText(PwbModGroup(Item1).mgName, PwbModGroup(Item2).mgName);
end;


function wbModGroupsByName(aValidOnly: Boolean = True): TwbModGroupPtrs;

begin

  wbLoadModGroups;
  _ModGroupFiles.mgfsAddModGroupsTo(Result, aValidOnly);
  if Length(Result) > 1 then
    wbMergeSortPtr(@Result[0], Length(Result), CompareModGroupPtrsByName);
end;



{ TwbModGroupsFilesHelper }

procedure TwbModGroupsFilesHelper.mgfsAddModGroupsTo(var aList: TwbModGroupPtrs; aValidOnly: Boolean);
var
  i: Integer;
begin
  aList := nil;
  for i := Low(Self) to High(Self) do
    Self[i].mgfAddModGroupsTo(aList, aValidOnly);
end;

{ TwbModGroupPtrsHelper }

function TwbModGroupPtrsHelper.Activate: Boolean;
var
  Modules : TwbModuleInfos;
  i, j, k    : Integer;
  Targets : TwbModuleInfos;
  SourceReported : Boolean;
begin
  Result := False;
  Modules := wbModulesByLoadOrder;
  for i := Low(Modules) to High(Modules) do
    with Modules[i]^ do begin
      miModGroupTargets := nil;
      miModGroupSources := nil;
    end;

  for i := Low(Modules) to High(Modules) do begin
    Modules.ExcludeAll(mfIsModGroupTarget);
    for j := Low(Self) to High(Self) do
      Self[j].mgTagTargetFiles(Modules[i]);

    Targets := nil;
    SetLength(Targets, i);
    k := 0;
    for j := Pred(i) downto 0 do
      if mfIsModGroupTarget in Modules[j].miFlags then begin
        Targets[k] := Modules[j];
        Inc(k);
      end;
    SetLength(Targets, k);
    Modules[i].miModGroupTargets := Targets;
  end;

  Modules.ExcludeAll(mfIsModGroupTarget);
  Modules.ExcludeAll(mfIsModGroupSource);

  for i := Low(Modules) to High(Modules) do
    with Modules[i]^ do
      if Length(miModGroupTargets) > 0 then begin
        Include(miFlags, mfIsModGroupSource);
        SourceReported := False;
        for j := Low(miModGroupTargets) to High(miModGroupTargets) do
          with miModGroupTargets[j]^ do begin
            if not SourceReported then begin
              if wbReportModGroups then
                wbProgress('Records in "'+Modules[i].miName+'" will hide records from:');
              SourceReported := True;
            end;
            Result := True;
            Include(miFlags, mfIsModGroupTarget);
            SetLength(miModGroupSources, Succ(Length(miModGroupSources)));
            miModGroupSources[High(miModGroupSources)] := Modules[i];
            if wbReportModGroups then
              wbProgress(' - ' + miName);
          end;
      end;
end;

procedure TwbModGroupPtrsHelper.ExcludeAll(aFlag: TwbModGroupFlag);
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
    with Self[i]^ do
      Exclude(mgFlags, aFlag);
end;

function TwbModGroupPtrsHelper.FilteredBy(const aFunc: TFunc<PwbModGroup, Boolean>): TwbModGroupPtrs;
var
  i, j: Integer;
begin
  SetLength(Result, Length(Self));
  j := 0;
  for i := Low(Self) to High(Self) do
    if aFunc(Self[i]) then begin
      Result[j] := Self[i];
      Inc(j);
    end;
  SetLength(Result, j);
end;

function TwbModGroupPtrsHelper.FilteredByFlag(aFlag: TwbModGroupFlag): TwbModGroupPtrs;
var
  i, j: Integer;
begin
  SetLength(Result, Length(Self));
  j := 0;
  for i := Low(Self) to High(Self) do
    if (aFlag = mgfNone) or (aFlag in Self[i]^.mgFlags) then begin
      Result[j] := Self[i];
      Inc(j);
    end;
  SetLength(Result, j);
end;

procedure TwbModGroupPtrsHelper.FlagFilesMissingCRC;
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
    Self[i].mgFlagFilesMissingCRC;
end;

procedure TwbModGroupPtrsHelper.FlagModGroupsNeedingCRCUpdateForTaggedFiles(aAdd, aUpdate: Boolean);
var
  i: Integer;
begin
  ExcludeAll(mgfNeedCRCUpdate);
  for i := Low(Self) to High(Self) do
    Self[i].mgFlagModGroupsNeedingCRCUpdateForTaggedFiles(aAdd, aUpdate);
end;

procedure TwbModGroupPtrsHelper.IncludeAll(aFlag: TwbModGroupFlag);
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
    with Self[i]^ do
      Include(mgFlags, aFlag);
end;

procedure TwbModGroupPtrsHelper.ShowValidationMessages;
var
  i, j     : Integer;
  Messages : TwbMessagePtrs;
  s        : string;
begin
  for i := Low(Self) to High(Self) do
    with Self[i]^ do begin
      if IsValid then
        s := 'ModGroup "%s" is valid, but has messages:'
      else begin
        if Assigned(mgModGroupsFile) and not mgModGroupsFile.mgfAnyModuleHasFile then
          Continue;
        s := 'ModGroup "%s" is invalid:';
      end;
      Messages := GetValidationMessages;
      if Length(Messages) > 0 then begin
        wbProgress(s, [mgName]);
        Messages.ToStrings.AddPrefix(' - ').ReportAsProgress;
      end;
  end;

end;

function TwbModGroupPtrsHelper.ToString: string;
var
  i: Integer;
begin
  with TStringList.Create do try
    for i := Low(Self) to High(Self) do
      Add(Self[i].mgName);
    Result := Text;
  finally
    Free;
  end;
end;

function TwbModGroupPtrsHelper.UpdateCRC(aAdd, aUpdate: Boolean): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := Low(Self) to High(Self) do
    if Self[i].mgUpdateCRC(aAdd, aUpdate) then
      Inc(Result);
end;

initialization
finalization
end.
