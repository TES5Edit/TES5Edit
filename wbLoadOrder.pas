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

unit wbLoadOrder;

{$I wbDefines.inc}

interface

uses
  wbInit,
  wbInterface;

type
  TwbModuleExtension = (
    meUnknown,
    meESM,
    meESL,
    meESP
  );

  TwbModuleFlag = (
    mfInvalid,
    mfMastersMissing,
    mfHasESMFlag,
    mfHasESLFlag,
    mfIsESM,
    mfActiveInPluginsTxt,
    mfActive,
    mfHasIndex,
    mfLoaded,
    mfLoading
  );

  TwbModuleFlags = set of TwbModuleFlag;

  PwbModuleInfo = ^TwbModuleInfo;
  TwbModuleInfo = record
    miName           : string;
    miUnghostedName  : string;
    miDateTime       : TDateTime;

    miExtension      : TwbModuleExtension;
    miIsGhost        : Boolean;

    miMasterNames    : TDynStrings;
    miMasters        : array of PwbModuleInfo;

    miFlags          : TwbModuleFlags;

    miOfficialIndex  : Integer;
    miCCIndex        : Integer;
    miPluginsIndex   : Integer;
    miLoadOrderIndex : Integer;

    miCombinedIndex  : Integer;

    function IsValid: Boolean;
    function HasIndex: Boolean;
    function IsActive: Boolean;
    procedure ActivateMasters(aRecursive: Boolean);
    procedure Activate(aActivateMasters: Boolean = False);
    function LoadOrderDescription: string;
    function FlagsDescription: string;
    function Description: string;
    function ToString(aInclDesc: Boolean): string;
  end;

  TwbModuleInfos = array of PwbModuleInfo;

  TwbModuleInfosHelper = record helper for TwbModuleInfos
    function ToStrings(aInclDesc: Boolean): TDynStrings;
    procedure DeactivateAll;
    procedure ActivateMasters;
    function SimulateLoad: TwbModuleInfos;
  end;

procedure wbLoadModules;
function wbModuleByName(const aName: string): PwbModuleInfo;
function wbModulesByLoadOrder: TwbModuleInfos;

implementation

uses
  System.Types,
  System.Classes,
  System.SysUtils,
  System.IOUtils,
  wbImplementation,
  wbSort;

type
    TwbDynModuleInfos = array of TwbModuleInfo;
var
  _Modules          : TwbDynModuleInfos;
  _ModulesByName    : TStringList;
  _InvalidModule    : TwbModuleInfo = (miFlags: [mfInvalid]);
  _ModulesLoadOrder : TwbModuleInfos;

const
  csDotGhost = '.ghost';
  csDotEsm   = '.esm';
  csDotEsl   = '.esl';
  csDotEsp   = '.esp';

function wbModuleByName(const aName: string): PwbModuleInfo;
var
  i: Integer;
begin
  if aName = '' then
    Exit(@_InvalidModule);
  wbLoadModules;
  if _ModulesByName.Find(aName, i) then
    Result := Pointer(_ModulesByName.Objects[i])
  else
    Result := @_InvalidModule;
end;

function _ModulesLoadOrderCompare(Item1, Item2: Pointer): Integer;
var
  a, b: PwbModuleInfo;
begin
  if Item1 = Item2 then
    Exit(0);

  a := Item1;
  b := Item2;
  Result := CmpI32(a.miOfficialIndex, b.miOfficialIndex);
  if Result = 0 then begin
    Result := CmpI32(a.miCCIndex, b.miCCIndex);
    if Result = 0 then begin
      if (mfIsESM in a.miFlags) = (mfIsESM in b.miFlags) then begin
        Result := CmpI32(a.miPluginsIndex, b.miPluginsIndex);
        if Result = 0 then begin
          Result := CmpDouble(a.miDateTime, b.miDateTime);
          if Result = 0 then begin
            Result := CompareText(a.miName, b.miName);
            if Result = 0 then
              Result := CmpPtr(Item1, Item2);
          end;
        end;
      end else
        if mfIsESM in a.miFlags then
          Result := -1
        else
          Result := 1;
    end;
  end;
end;

function _ModulesLoadOrderCompareCombined(Item1, Item2: Pointer): Integer;
var
  a, b: PwbModuleInfo;
begin
  if Item1 = Item2 then
    Exit(0);

  a := Item1;
  b := Item2;
  Result := CmpI32(a.miOfficialIndex, b.miOfficialIndex);
  if Result = 0 then begin
    Result := CmpI32(a.miCCIndex, b.miCCIndex);
    if Result = 0 then begin
      if (mfIsESM in a.miFlags) = (mfIsESM in b.miFlags) then begin
        Result := CmpI32(a.miCombinedIndex, b.miCombinedIndex);
        if Result = 0 then begin
          Result := CmpI32(a.miPluginsIndex, b.miPluginsIndex);
          if Result = 0 then begin
            Result := CmpDouble(a.miDateTime, b.miDateTime);
            if Result = 0 then begin
              Result := CompareText(a.miName, b.miName);
              if Result = 0 then
                Result := CmpPtr(Item1, Item2);
            end;
          end;
        end;
      end else
        if mfIsESM in a.miFlags then
          Result := -1
        else
          Result := 1;
    end;
  end;
end;

procedure wbLoadModules;
var
  Files      : TStringDynArray;
  i, j, k    : Integer;
  s          : string;
  IsESM      ,
  IsESL      : Boolean;
  lIsActive  : Boolean;
  sl         : TStringList;
  ThisModule ,
  PrevModule : PwbModuleInfo;
begin
  if Assigned(_ModulesByName) then {already loaded}
    Exit;

  Files := TDirectory.GetFiles(wbDataPath);
  SetLength(_Modules, Length(Files));
  j := 0;
  for i := Low(Files) to High(Files) do
    with _Modules[j] do begin
      miFlags := [];
      miName := ExtractFileName(Files[i]);
      miIsGhost := miName.EndsWith('.ghost', True);
      if miIsGhost then
        miUnghostedName := Copy(miName, 1, Length(miName) - Length(csDotGhost))
      else
        miUnghostedName := miName;
      miExtension := meUnknown;
      if miUnghostedName.EndsWith(csDotEsm) then
        miExtension := meESM
      else if miUnghostedName.EndsWith(csDotEsp) then
        miExtension := meESP
      else if miUnghostedName.EndsWith(csDotEsl) and wbIsEslSupported then
        miExtension := meESL;
      if miExtension = meUnknown then
        Continue;

      if miExtension in [meESM, meESL] then
        Include(miFlags, mfIsESM);

      miDateTime := TFile.GetLastWriteTime(wbDataPath + miName);

      if not wbMastersForFile(wbDataPath+miName, miMasterNames, @IsESM, @IsESL) then
        Continue;

      if IsESM then begin
        Include(miFlags, mfHasESMFlag);
        if (wbToolMode in [tmMasterUpdate, tmMasterRestore]) and wbIsFallout3 then
          {ignore header flag for load order, only extension counts}
        else
          Include(miFlags, mfIsESM);
       end;

      if IsESL then
        Include(miFlags, mfHasESLFlag);
      Inc(j);
  end;
  SetLength(_Modules, j);
  {do NOT perform SetLength on _Modules after this, it could invalidate pointer into the array}
  _ModulesByName := TStringList.Create;
  for i := Low(_Modules) to High(_Modules) do
    _ModulesByName.AddObject(_Modules[i].miName, @_Modules[i]);
  _ModulesByName.Sorted := True;

  SetLength(_ModulesLoadOrder, Length(_Modules));
  for i := Low(_Modules) to High(_Modules) do
    with _Modules[i] do begin
      _ModulesLoadOrder[i] := @_Modules[i];
      SetLength(miMasters, Length(miMasterNames));
      for j := Low(miMasterNames) to High(miMasterNames) do
        if _ModulesByName.Find(miMasterNames[j], k) then
          miMasters[j] := Pointer(_ModulesByName.Objects[k])
        else
          Include(miFlags, mfMastersMissing);
      miOfficialIndex  := High(Integer);
      miCCIndex        := High(Integer);
      miPluginsIndex   := High(Integer);
      miLoadOrderIndex := High(Integer);
    end;

  if Length(_Modules) < 1 then
    Exit;

  sl := TStringList.Create;
  try
    if FileExists(wbPluginsFileName) then begin
      sl.LoadFromFile(wbPluginsFileName);
      for i := 0 to Pred(sl.Count) do begin
        s := sl[i];
        j := Pos('#', s);
        if j > 0 then
          Delete(s, j, High(Integer));
        s := Trim(s);
        lIsActive := wbGameMode in wbSimplePluginsTxt;
        if not lIsActive then begin
          lIsActive := s.StartsWith('*');
          if lIsActive then
            Delete(s, 1, 1);
          s := Trim(s);
        end;
        with wbModuleByName(s)^ do
          if IsValid then begin
            if wbGameMode in wbOrderFromPluginsTxt then begin
              miPluginsIndex := i;
              Include(miFlags, mfHasIndex);
            end;
            if lIsActive then begin
              Include(miFlags, mfActiveInPluginsTxt);
              Include(miFlags, mfActive);
            end;
          end;
      end;
    end;

  finally
    sl.Free;
  end;

  with wbModuleByName(wbGameName + csDotEsm)^ do
    if IsValid then begin
      miOfficialIndex := Low(Integer);
      Include(miFlags, mfActive);
      Include(miFlags, mfHasIndex);
    end;

  if wbIsSkyrim then
    with wbModuleByName('Update.esm')^ do
      if IsValid then begin
        miOfficialIndex := -1;
        Include(miFlags, mfActive);
        Include(miFlags, mfHasIndex);
      end;

  for i := Low(wbOfficialDLC) to High(wbOfficialDLC) do
    with wbModuleByName(wbOfficialDLC[i])^ do
      if IsValid then begin
        miOfficialIndex := i;
        Include(miFlags, mfActive);
        Include(miFlags, mfHasIndex);
      end;

  for i := Low(wbCreationClubContent) to High(wbCreationClubContent) do
    with wbModuleByName(wbCreationClubContent[i])^ do
      if IsValid then begin
        miCCIndex := Succ(i);
        Include(miFlags, mfActive);
        Include(miFlags, mfHasIndex);
      end;

  i := Length(_ModulesLoadOrder);
  if i > 1 then
    wbMergeSort(@_ModulesLoadOrder[0], i, _ModulesLoadOrderCompare);

  if wbGameMode = gmTES5 then begin
    s := ExtractFilePath(wbPluginsFileName) + 'loadorder.txt';
    if FileExists(s) then begin
      sl := TStringList.Create;
      try
        sl.LoadFromFile(s);
        for i := Pred(sl.Count) downto 0  do begin
          s := sl[i];
          j := Pos('#', s);
          if j > 0 then
            Delete(s, j, High(Integer));
          s := Trim(s);
          ThisModule := wbModuleByName(s);
          if ThisModule.IsValid then begin
            sl[i] := s;
            sl.Objects[i] := Pointer(i);
          end else
            sl.Delete(i);
        end;
        if sl.Count > 1 then begin
          for i := Low(_ModulesLoadOrder) to High(_ModulesLoadOrder) do
            with _ModulesLoadOrder[i]^ do
              miCombinedIndex := Succ(i) * 1000;

          for i := 1 to Pred(sl.Count) do begin
            ThisModule := wbModuleByName(sl[i]);
            if ThisModule.IsValid then begin
              ThisModule.miLoadOrderIndex := Integer(sl.Objects[i]);
              if not ThisModule.HasIndex then begin
                PrevModule := @_InvalidModule;
                for j := Pred(i) downto 0 do begin
                  PrevModule := wbModuleByName(sl[j]);
                  if PrevModule.HasIndex then
                    Break;
                end;
                if PrevModule.HasIndex then begin
                  ThisModule.miCombinedIndex := PrevModule.miCombinedIndex + 1;
                  Include(ThisModule.miFlags, mfHasIndex);
                end;
              end;
            end;
          end;

          wbMergeSort(@_ModulesLoadOrder[0], Length(_ModulesLoadOrder), _ModulesLoadOrderCompareCombined);
        end;
      finally
        sl.Free;
      end;
    end;
  end;

  for i := Low(_ModulesLoadOrder) to High(_ModulesLoadOrder) do
    _ModulesLoadOrder[i].miCombinedIndex := i;
end;

function wbModulesByLoadOrder:  TwbModuleInfos;
begin
  wbLoadModules;
  Result := Copy(_ModulesLoadOrder);
end;

{ TwbModuleInfo }

procedure TwbModuleInfo.Activate(aActivateMasters: Boolean);
begin
  Include(miFlags, mfActive);
  if aActivateMasters then
    ActivateMasters(True);
end;

procedure TwbModuleInfo.ActivateMasters(aRecursive: Boolean);
var
  i: Integer;
begin
  for i := High(miMasters) downto Low(miMasters) do
    if Assigned(miMasters[i]) then
      with miMasters[i]^ do
        if not (mfActive in miFlags) then
          Activate(aRecursive);
end;

function TwbModuleInfo.Description: string;
begin
  Result := Trim(LoadOrderDescription + ' ' + FlagsDescription);
end;

function TwbModuleInfo.FlagsDescription: string;
begin
  Result := '';
  if mfHasESMFlag in miFlags then
    Result := Result + '<ESM>';
  if mfHasESLFlag in miFlags then
    Result := Result + '<ESL>';
  if mfMastersMissing in miFlags then
    Result := Result + '<MissingMasters>';
end;

function TwbModuleInfo.HasIndex: Boolean;
begin
  Result := IsValid and (mfHasIndex in miFlags);
end;

function TwbModuleInfo.IsActive: Boolean;
begin
  Result := IsValid and (mfActive in miFlags);
end;

function TwbModuleInfo.IsValid: Boolean;
begin
  Result := not ((mfInvalid in miFlags) or (@Self = @_InvalidModule));
end;

function TwbModuleInfo.LoadOrderDescription: string;
begin
  Result := '';
  if miOfficialIndex = Low(Integer) then
    Result := Result + '[GameMaster]'
  else if miOfficialIndex = -1 then
    Result := Result + '[Update]'
  else if miOfficialIndex < High(Integer) then
    Result := Result + '[DLC:'+miOfficialIndex.ToString+']';
  if miCCIndex < High(Integer) then
    Result := Result + '[CC:'+miCCIndex.ToString+']';
  if Result = '' then begin
    if mfIsESM in miFlags then
      Result := Result + '[ESM]';

    if miPluginsIndex < High(Integer) then
      Result := Result + '[Plugins.txt:'+miPluginsIndex.ToString+']';
    if miLoadOrderIndex < High(Integer) then
      Result := Result + '[LoadOrder.txt:'+miLoadOrderIndex.ToString+']';

    if (Result = '') or (Result = '[ESM]') then
      Result := Result + '[Time:'+FormatDateTime('yyyy-mm-dd hh:mm:ss', miDateTime)+']';
  end;
end;

function TwbModuleInfo.ToString(aInclDesc: Boolean): string;
begin
  Result := miName;
  if aInclDesc then
    Result := Trim(Result + '    ' + Description);
end;

{ TwbModuleInfosHelper }

procedure TwbModuleInfosHelper.ActivateMasters;
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
    with Self[i]^ do
      if mfActive in miFlags then
        ActivateMasters(True);
end;

procedure TwbModuleInfosHelper.DeactivateAll;
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
    with Self[i]^ do
      Exclude(miFlags, mfActive);
end;

function TwbModuleInfosHelper.SimulateLoad: TwbModuleInfos;
var
  NewLoadOrder      : TwbModuleInfos;
  NewLoadOrderCount : Integer;

  procedure Load(aModule: PwbModuleInfo);
  var
    i: Integer;
  begin
    with aModule^ do begin
      if mfLoaded in miFlags then
        Exit;
      if mfLoading in miFlags then
        raise Exception.Create('Modules contain circular references. Can''t load "'+miName+'"');
      Include(miFlags, mfLoading);
      try
        for i := Low(miMasters) to High(miMasters) do
          if Assigned(miMasters[i]) then
            Load(miMasters[i])
          else
            raise Exception.Create('Module "'+miName+'" requires master "'+miMasterNames[i]+'" which can not be found');
        Include(miFlags, mfLoaded);
        NewLoadOrder[NewLoadOrderCount] := aModule;
        Inc(NewLoadOrderCount);
      finally
        Exclude(miFlags, mfLoading);
      end;
    end;
  end;

var
  i: Integer;
begin
  for i := Low(_Modules) to High(_Modules) do
    with _Modules[i] do begin
      Exclude(miFlags, mfLoaded);
      Exclude(miFlags, mfLoading);
    end;
  SetLength(NewLoadOrder, Length(_Modules));
  NewLoadOrderCount := 0;
  for i := Low(Self) to High(Self) do
    with Self[i]^ do
      if mfActive in miFlags then
        Load(Self[i]);
  SetLength(NewLoadOrder, NewLoadOrderCount);
  Result := NewLoadOrder;
end;

function TwbModuleInfosHelper.ToStrings(aInclDesc: Boolean): TDynStrings;
var
  i: Integer;
begin
  SetLength(Result ,Length(Self));
  for i := Low(Self) to High(Self) do
    Result[i] := Self[i].ToString(aInclDesc);
end;

initialization
finalization
  FreeAndNil(_ModulesByName);
end.

