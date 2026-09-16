{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbLoadOrder;

{$I wbDefines.inc}

interface

uses
  System.SysUtils,

  wbHash,
  wbInterface;

type
  TwbModuleExtension = (
    meUnknown,
    meESM,
    meESL,
    meESP,
    meESU
  );

  TwbModuleExtensionHelper = record helper for TwbModuleExtension
    function ToString: string;
  end;

  TwbModuleFlag = (
    mfInvalid,
    mfValid,
    mfGhost,
    mfMastersMissing,
    mfHasESMFlag,
    mfHasLightFlag,
    mfHasMediumFlag,
    mfHasBlueprintFlag,
    mfHasUpdateFlag,
    mfHasLocalizedFlag,
    mfHasESMExtension,
    mfIsESM,
    mfActiveInPluginsTxt,
    mfActive,
    mfForceLoad,
    mfHasIndex,
    mfLoaded,
    mfLoading,
    mfTagged,
    mfHasFile,
    mfIsHardcoded,
    mfIsGameMaster,
    mfNew,
    mfTemplate,
    mfIsModGroupTarget,
    mfIsModGroupSource,
    mfEphemeralModGroupTagged,
    mfTaggedForPluginMode,
    mfModGroupMissingCurrentCRC,
    mfModGroupMissingAnyCRC
  );

  TwbModuleFlags = set of TwbModuleFlag;

  PwbModuleInfo = ^TwbModuleInfo;
  TwbModuleInfos = array of PwbModuleInfo;
  TwbModuleInfo = record
  private
    miCRC32             : TwbCRC32;
  public
    miOriginalName      : string;
    miName              : string;
    miDateTime          : TDateTime;

    miExtension         : TwbModuleExtension;

    miMasterNames       : TDynStrings;
    miMasters           : TwbModuleInfos;

    miFlags             : TwbModuleFlags;

    miOfficialIndex     : Integer;
    miCCIndex           : Integer;
    miPluginsTxtIndex   : Integer;
    miLoadOrderTxtIndex : Integer;

    miCombinedIndex     : Integer;

    miFileID            : TwbFileID;
    miLoadOrder         : Integer;

    miFile              : TObject;
    miContext           : TwbGameContext;

    miModGroupTargets   : TwbModuleInfos;
    miModGroupSources   : TwbModuleInfos;

    function IsValid: Boolean;
    function HasIndex: Boolean;
    function IsActive: Boolean;
    function IsTemplate: Boolean;
    procedure ActivateMasters(aRecursive: Boolean);
    procedure Activate(aActivateMasters: Boolean = False);
    function LoadOrderDescription: string;
    function FlagsDescription: string;
    function Description: string;
    function ToString(aInclDesc: Boolean): string;
    function _File: IwbFile;
    class function AddNewModule(const aFileName: string; aTemplate: Boolean): PwbModuleInfo; static;

    function GetModuleType: TwbModuleType;

    function HasCRC32(aCRC32: TwbCRC32): Boolean;
    function GetCRC32(out aCRC32: TwbCRC32): Boolean;
  end;

  TwbModuleInfosHelper = record helper for TwbModuleInfos
    function ToStrings(aInclDesc: Boolean = False): TDynStrings;
    procedure DeactivateAll;
    procedure ExcludeAll(aFlag: TwbModuleFlag);
    procedure IncludeAll(aFlag: TwbModuleFlag);
    procedure ActivateMasters;
    function SimulateLoad: TwbModuleInfos;
    procedure DisableSimulatedLoad;
    function FilteredByFlag(aFlag: TwbModuleFlag; aHasFlag: Boolean = True): TwbModuleInfos;
    function FilteredBy(const aFunc: TFunc<PwbModuleInfo, Boolean>): TwbModuleInfos;
  end;

procedure wbLoadModules;
function wbModuleByName(const aName: string): PwbModuleInfo;
function wbModulesByLoadOrder(aIncludeTemplates: Boolean = False): TwbModuleInfos;

implementation

uses
  System.Classes,
  System.IOUtils,
  System.Types,

  wbGameDefGlobals,
  wbHelpers,
  wbImplementation,
  wbSort;

function TwbModuleExtensionHelper.ToString: string;
begin
  case Self of
    meESM: Result := csDotEsm;
    meESL: Result := csDotEsl;
    meESP: Result := csDotEsp;
    meESU: Result := csDotEsu;
  else
    Result := '';
  end;
end;

type
  TwbDynModuleInfos = array of TwbModuleInfo;

  TwbModuleList = class
  private
    mlContext               : TwbGameContext;
    mlModules               : TwbDynModuleInfos;
    mlModulesByName         : TStringList;
    mlModulesLoadOrder      : TwbModuleInfos;
    mlAdditionalModules     : TwbModuleInfos;
    mlTemplateModules       : TwbModuleInfos;
    mlUpdateIndex           : Integer;
    mlNextFullSlot          : Integer;
    mlNextMediumSlot        : Integer;
    mlNextLightSlot         : Integer;
    mlSimulatedLoadDisabled : Boolean;
  public
    constructor Create(aContext: TwbGameContext);
    destructor Destroy; override;

    procedure LoadModules;
    function ModuleByName(const aName: string): PwbModuleInfo;
    function ModulesByLoadOrder(aIncludeTemplates: Boolean): TwbModuleInfos;
    function AddNewModule(const aFileName: string; aTemplate: Boolean): PwbModuleInfo;
    procedure ResetSimulatedLoad;
    procedure DisableSimulatedLoad;
  end;

var
  _InvalidModule     : TwbModuleInfo = (miFlags: [mfInvalid]);

function wbCurrentModuleList: TwbModuleList;
begin
  Result := TwbModuleList(_CurrentContext.ModuleList);
  if not Assigned(Result) then begin
    Result := TwbModuleList.Create(_CurrentContext);
    _CurrentContext.ModuleList := Result;
  end;
end;

procedure FreeAllocatedModules(var aList: TwbModuleInfos);
var
  i: Integer;
begin
  for i := Low(aList) to High(aList) do
    Dispose(aList[i]);
  aList := nil;
end;

{ TwbModuleList }

constructor TwbModuleList.Create(aContext: TwbGameContext);
begin
  inherited Create;
  mlContext := aContext;
  mlUpdateIndex := -1;
end;

destructor TwbModuleList.Destroy;
begin
  FreeAndNil(mlModulesByName);
  FreeAllocatedModules(mlTemplateModules);
  FreeAllocatedModules(mlAdditionalModules);
  inherited;
end;

function TwbModuleList.ModuleByName(const aName: string): PwbModuleInfo;
var
  i: Integer;
  s: string;
begin
  s := aName;
  if s.EndsWith(csDotGhost, True) then
    SetLength(s, Length(s) - Length(csDotGhost));
  if s = '' then
    Exit(@_InvalidModule);
  LoadModules;
  if mlModulesByName.Find(s, i) then
    Result := Pointer(mlModulesByName.Objects[i])
  else
    Result := @_InvalidModule;
end;

function wbModuleByName(const aName: string): PwbModuleInfo;
begin
  Result := wbCurrentModuleList.ModuleByName(aName);
end;

function _ModulesLoadOrderCompare(Item1, Item2: Pointer): Integer;
var
  a, b: PwbModuleInfo;
begin
  if Item1 = Item2 then
    Exit(0);

  a := Item1;
  b := Item2;
  if (mfHasBlueprintFlag in a.miFlags) = (mfHasBlueprintFlag in b.miFlags) then begin
    Result := CmpI32(a.miOfficialIndex, b.miOfficialIndex);
    if Result = 0 then begin
      Result := CmpI32(a.miCCIndex, b.miCCIndex);
      if Result = 0 then begin
        if ((mfIsESM in a.miFlags) = (mfIsESM in b.miFlags)) or not (gcMastersLoadFirst in a.miContext.GameDefObj.Capabilities) then begin
          Result := CmpI32(a.miPluginsTxtIndex, b.miPluginsTxtIndex);
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
  end else
    if mfHasBlueprintFlag in a.miFlags then
      Result := 1
    else
      Result := -1;
end;

function _ModulesLoadOrderCompareCombined(Item1, Item2: Pointer): Integer;
var
  a, b: PwbModuleInfo;
begin
  if Item1 = Item2 then
    Exit(0);

  a := Item1;
  b := Item2;
  if (mfHasBlueprintFlag in a.miFlags) = (mfHasBlueprintFlag in b.miFlags) then begin
    Result := CmpI32(a.miOfficialIndex, b.miOfficialIndex);
    if Result = 0 then begin
      Result := CmpI32(a.miCCIndex, b.miCCIndex);
      if Result = 0 then begin
          if ((mfIsESM in a.miFlags) = (mfIsESM in b.miFlags)) or not (gcMastersLoadFirst in a.miContext.GameDefObj.Capabilities) then begin
            Result := CmpI32(a.miCombinedIndex, b.miCombinedIndex);
            if Result = 0 then begin
              Result := CmpI32(a.miPluginsTxtIndex, b.miPluginsTxtIndex);
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
  end else
    if mfHasBlueprintFlag in a.miFlags then
      Result := 1
    else
      Result := -1;
end;

procedure TwbModuleList.LoadModules;
var
  Files       : TStringDynArray;
  i, j, k     : Integer;
  s           : string;
  IsESM       : Boolean;
  IsLight     : Boolean;
  IsMedium    : Boolean;
  IsBlueprint : Boolean;
  IsUpdate    : Boolean;
  IsLocalized : Boolean;
  lIsActive   : Boolean;
  sl          : TStringList;
  ThisModule  : PwbModuleInfo;
  PrevModule  : PwbModuleInfo;
  MadeAChange : Boolean;
  lGameDef    : TwbGameDef;
begin
  if Assigned(mlModulesByName) then {already loaded}
    Exit;

  lGameDef := mlContext.GameDefObj;
  if lGameDef.GameMode = gmEnderalSE then
    mlUpdateIndex := Pred(High(Integer));

  if mlContext.Settings.DataPath <> '' then begin
    Files := TDirectory.GetFiles(mlContext.Settings.DataPath);
    i := Length(Files);
    if i > 1 then
      wbMergeSortPtr(@Files[0], i, TListSortCompare(@CompareText));

    SetLength(mlModules, Succ(Length(Files)));
    with mlModules[0] do begin
      miFlags := [];
      miContext := mlContext;
      miOriginalName := wbGameExeName;
      miName := miOriginalName;
      miExtension := meESM;

      Include(miFlags, mfHasESMFlag);
      Include(miFlags, mfIsESM);
      Include(miFlags, mfIsHardcoded);
    end;
    j := 1;
    for i := Low(Files) to High(Files) do
      with mlModules[j] do try
        miFlags := [];
        miContext := mlContext;
        miOriginalName := ExtractFileName(Files[i]);
        if miOriginalName.EndsWith(csDotGhost, True) then begin
          miName := Copy(miOriginalName, 1, Length(miOriginalName) - Length(csDotGhost));
          Include(miFlags, mfGhost);
          if (j > 0) and SameText(miName, mlModules[Pred(j)].miName) then
            Continue; {ignore ghost if original exists}
        end else
          miName := miOriginalName;
        miExtension := meUnknown;
        if miName.EndsWith(csDotEsm, True) then
          miExtension := meESM
        else if miName.EndsWith(csDotEsp, True) then
          miExtension := meESP
        else if miName.EndsWith(csDotEsu, True) then
          miExtension := meESU
        else if miName.EndsWith(csDotEsl, True) and lGameDef.IsLightSupported then
          miExtension := meESL;
        if miExtension = meUnknown then
          Continue;

        if gcMasterFlagFromExtension in lGameDef.Capabilities then
          if miExtension in [meESM, meESL] then begin
            Include(miFlags, mfHasESMExtension);
            Include(miFlags, mfIsESM);
          end;

        miDateTime := wbGetLastWriteTime(mlContext.Settings.DataPath + miOriginalName);

        if not mlContext.MastersForFile(mlContext.Settings.DataPath + miOriginalName, miMasterNames, @IsESM, @IsLight, @IsLocalized, @IsUpdate, @IsMedium, @IsBlueprint) then
          Continue;

        if IsESM then begin
          Include(miFlags, mfHasESMFlag);
          if (wbToolMode in [tmMasterUpdate, tmMasterRestore]) and lGameDef.IsFallout3 then
            {ignore header flag for load order, only extension counts}
          else
            Include(miFlags, mfIsESM);
        end;

        {
        if the 0x200 flag is set then begin
          if there is no master list, or the 0x100 flag is set then
            remove the 0x200 flag
        end else
          if the extension is .esl then
            force 0x100 flag
        }
        if IsUpdate then begin
          if {(Length(miMasterNames) < 1) or} IsLight or IsMedium then
            IsUpdate := False;
        end else
          if miExtension in [meESL] then
            Include(miFlags, mfHasLightFlag);

        if IsUpdate then
          Include(miFlags, mfHasUpdateFlag);

        if IsLight then
          Include(miFlags, mfHasLightFlag);

        if IsMedium then
          Include(miFlags, mfHasMediumFlag);

        if IsBlueprint then
          Include(miFlags, mfHasBlueprintFlag);

        if IsLocalized then
          Include(miFlags, mfHasLocalizedFlag);

        Include(miFlags, mfValid);

        Inc(j);
      except
        on E: Exception do
        wbProgress('Error loading module information for "%s": [%s] %s', [Files[i], E.ClassName, E.Message]);
      end;
    SetLength(mlModules, j);
  end;
  {do NOT perform SetLength on mlModules after this, it could invalidate pointer into the array}
  mlModulesByName := TStringList.Create;
  for i := Low(mlModules) to High(mlModules) do
    mlModulesByName.AddObject(mlModules[i].miName, @mlModules[i]);
  mlModulesByName.Sorted := True;

  SetLength(mlModulesLoadOrder, Length(mlModules));
  for i := Low(mlModules) to High(mlModules) do
    with mlModules[i] do begin
      mlModulesLoadOrder[i] := @mlModules[i];
      SetLength(miMasters, Length(miMasterNames));
      for j := Low(miMasterNames) to High(miMasterNames) do
        if mlModulesByName.Find(miMasterNames[j], k) then
          miMasters[j] := Pointer(mlModulesByName.Objects[k])
        else
          Include(miFlags, mfMastersMissing);
      miOfficialIndex  := High(Integer);
      miCCIndex        := High(Integer);
      miPluginsTxtIndex   := High(Integer);
      miLoadOrderTxtIndex := High(Integer);
    end;

  if Length(mlModules) < 1 then
    Exit;

  repeat
    MadeAChange := False;
    for i := Low(mlModules) to High(mlModules) do
      with mlModules[i] do begin
        if not (mfMastersMissing in miFlags) then
          for j := Low(miMasters) to High(miMasters) do
            if not Assigned(miMasters[j]) or (mfMastersMissing in miMasters[j].miFlags) then begin
              Include(miFlags, mfMastersMissing);
              MadeAChange := True;
            end
      end;
  until not MadeAChange;

  sl := TStringList.Create;
  try
    if FileExists(mlContext.Settings.PluginsFileName) then begin
      sl.LoadFromFile(mlContext.Settings.PluginsFileName);
      for i := 0 to Pred(sl.Count) do begin
        s := sl[i];
        j := Pos('#', s);
        if j > 0 then
          Delete(s, j, High(Integer));
        s := Trim(s);
        lIsActive := gcPluginsTxtAllActive in lGameDef.Capabilities;
        if not lIsActive then begin
          lIsActive := s.StartsWith('*');
          if lIsActive then
            Delete(s, 1, 1);
          s := Trim(s);
        end;
        with ModuleByName(s)^ do
          if IsValid then begin
            if gcOrderFromPluginsTxt in lGameDef.Capabilities then begin
              miPluginsTxtIndex := i;
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

  for i := Low(mlModules) to High(mlModules) do
    with mlModules[i] do
      if mfMastersMissing in miFlags then
        Exclude(miFlags, mfActive);

  with ModuleByName(wbGameMasterEsm)^ do
    if IsValid then begin
      miOfficialIndex := Low(Integer);
      Include(miFlags, mfActive);
      Include(miFlags, mfHasIndex);
      Include(miFlags, mfIsGameMaster);
    end;
  with ModuleByName(wbGameExeName)^ do begin
    miOfficialIndex := Succ(Low(Integer));
    Include(miFlags, mfHasIndex);
  end;

  if lGameDef.IsSkyrim then
    with ModuleByName('Update.esm')^ do
      if IsValid then begin
        miOfficialIndex := mlUpdateIndex;
        Include(miFlags, mfActive);
        Include(miFlags, mfHasIndex);
      end;

  for i := Low(lGameDef.OfficialDLC) to High(lGameDef.OfficialDLC) do
    with ModuleByName(lGameDef.OfficialDLC[i])^ do
      if IsValid then begin
        miOfficialIndex := i;
        Include(miFlags, mfActive);
        Include(miFlags, mfHasIndex);
      end;

  for i := Low(mlContext.Settings.CreationClubContent) to High(mlContext.Settings.CreationClubContent) do
    with ModuleByName(mlContext.Settings.CreationClubContent[i])^ do
      if IsValid then begin
        miCCIndex := Succ(i);
        Include(miFlags, mfActive);
        Include(miFlags, mfHasIndex);
      end;

  i := Length(mlModulesLoadOrder);
  if i > 1 then
    wbMergeSortPtr(@mlModulesLoadOrder[0], i, _ModulesLoadOrderCompare);

  if gcOrderFromLoadOrderTxt in lGameDef.Capabilities then begin
    s := ExtractFilePath(mlContext.Settings.PluginsFileName) + 'loadorder.txt';
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
          ThisModule := ModuleByName(s);
          if ThisModule.IsValid then begin
            sl[i] := s;
            sl.Objects[i] := Pointer(i);
          end else
            sl.Delete(i);
        end;
        if sl.Count > 1 then begin
          for i := Low(mlModulesLoadOrder) to High(mlModulesLoadOrder) do
            with mlModulesLoadOrder[i]^ do
              miCombinedIndex := Succ(i) * 1000;

          for i := 1 to Pred(sl.Count) do begin
            ThisModule := ModuleByName(sl[i]);
            if ThisModule.IsValid then begin
              ThisModule.miLoadOrderTxtIndex := Integer(sl.Objects[i]);
              if not ThisModule.HasIndex then begin
                PrevModule := @_InvalidModule;
                for j := Pred(i) downto 0 do begin
                  PrevModule := ModuleByName(sl[j]);
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

          wbMergeSortPtr(@mlModulesLoadOrder[0], Length(mlModulesLoadOrder), _ModulesLoadOrderCompareCombined);
        end;
      finally
        sl.Free;
      end;
    end;
  end;

  for i := Low(mlModulesLoadOrder) to High(mlModulesLoadOrder) do
    mlModulesLoadOrder[i].miCombinedIndex := i;

  AddNewModule('<new file>.esp', True);
  if not lGameDef.IsStarfield then
    with AddNewModule('<new file>.esp', True)^ do begin
      Include(miFlags, mfHasESMFlag);
      Include(miFlags, mfIsESM);
    end;
  if lGameDef.IsLightSupported and not lGameDef.IsStarfield then begin
    with AddNewModule('<new file>.esp', True)^ do
      Include(miFlags, mfHasLightFlag);
    with AddNewModule('<new file>.esp', True)^ do begin
      Include(miFlags, mfHasESMFlag);
      Include(miFlags, mfHasLightFlag);
      Include(miFlags, mfIsESM);
    end;
  end;
  if lGameDef.IsMediumSupported and not lGameDef.IsStarfield then begin
    with AddNewModule('<new file>.esp', True)^ do
      Include(miFlags, mfHasMediumFlag);
    with AddNewModule('<new file>.esp', True)^ do begin
      Include(miFlags, mfHasESMFlag);
      Include(miFlags, mfHasMediumFlag);
      Include(miFlags, mfIsESM);
    end;
  end;
  if lGameDef.IsUpdateSupported and not lGameDef.IsStarfield then begin
    with AddNewModule('<new file>.esp', True)^ do
      Include(miFlags, mfHasUpdateFlag);
    with AddNewModule('<new file>.esp', True)^ do begin
      Include(miFlags, mfHasESMFlag);
      Include(miFlags, mfHasUpdateFlag);
      Include(miFlags, mfIsESM);
    end;
  end;

  with AddNewModule('<new file>.esm', True)^ do begin
    Include(miFlags, mfHasESMFlag);
    Include(miFlags, mfIsESM);
    if lGameDef.IsLightSupported then begin
      with AddNewModule('<new file>.esm', True)^ do begin
        Include(miFlags, mfHasLightFlag);
        Include(miFlags, mfHasESMFlag);
        Include(miFlags, mfIsESM);
      end;
    end;
    if lGameDef.IsMediumSupported then begin
      with AddNewModule('<new file>.esm', True)^ do begin
        Include(miFlags, mfHasMediumFlag);
        Include(miFlags, mfHasESMFlag);
        Include(miFlags, mfIsESM);
      end;
    end;
    if lGameDef.IsUpdateSupported and not lGameDef.IsStarfield then begin
      with AddNewModule('<new file>.esm', True)^ do begin
        Include(miFlags, mfHasUpdateFlag);
        Include(miFlags, mfHasESMFlag);
        Include(miFlags, mfIsESM);
      end;
    end;
  end;

  if not lGameDef.IsStarfield then begin
    if lGameDef.IsLightSupported then begin
      with AddNewModule('<new file>.esl', True)^ do begin
        Include(miFlags, mfHasESMFlag);
        Include(miFlags, mfHasLightFlag);
        Include(miFlags, mfIsESM);
      end;
      if lGameDef.IsUpdateSupported then begin
        with AddNewModule('<new file>.esl', True)^ do begin
          Include(miFlags, mfHasUpdateFlag);
          Include(miFlags, mfHasESMFlag);
          Include(miFlags, mfIsESM);
        end;
      end;
    end;
  end;
end;

function TwbModuleList.ModulesByLoadOrder(aIncludeTemplates: Boolean): TwbModuleInfos;
var
  i, j : Integer;
begin
  LoadModules;
  Result := Copy(mlModulesLoadOrder);
  i := Length(mlAdditionalModules);
  if i > 0 then begin
    j := Length(Result);
    SetLength(Result, j + i);
    for i := 0 to Pred(i) do
      Result[j + i] := mlAdditionalModules[i];
  end;
  if aIncludeTemplates then begin
    i := Length(mlTemplateModules);
    if i > 0 then begin
      j := Length(Result);
      SetLength(Result, j + i);
      for i := 0 to Pred(i) do
        Result[j + i] := mlTemplateModules[i];
    end;
  end;
end;

procedure wbLoadModules;
begin
  wbCurrentModuleList.LoadModules;
end;

function wbModulesByLoadOrder(aIncludeTemplates: Boolean = False):  TwbModuleInfos;
begin
  Result := wbCurrentModuleList.ModulesByLoadOrder(aIncludeTemplates);
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

class function TwbModuleInfo.AddNewModule(const aFileName: string; aTemplate: Boolean): PwbModuleInfo;
begin
  Result := wbCurrentModuleList.AddNewModule(aFileName, aTemplate);
end;

function TwbModuleList.AddNewModule(const aFileName: string; aTemplate: Boolean): PwbModuleInfo;
begin
  Result := AllocMem(SizeOf(TwbModuleInfo));
  with Result^ do begin
    miContext := mlContext;
    miOriginalName := aFileName;
    miName := aFileName;

    miExtension := meUnknown;
    if miName.EndsWith(csDotEsm, True) then
      miExtension := meESM
    else if miName.EndsWith(csDotEsp, True) then
      miExtension := meESP
    else if miName.EndsWith(csDotEsu, True) then
      miExtension := meESU
    else if miName.EndsWith(csDotEsl, True) and mlContext.GameDefObj.IsLightSupported then
      miExtension := meESL;

    if miExtension in [meESM, meESL] then
      Include(miFlags, mfIsESM);

    miDateTime := Now;
    Include(miFlags, mfValid);
    if aTemplate then
      Include(miFlags, mfTemplate)
    else
      Include(miFlags, mfNew);

    miOfficialIndex := High(Integer);
    miCCIndex := High(Integer);
    miPluginsTxtIndex := High(Integer);
    miLoadOrderTxtIndex := High(Integer);
    miCombinedIndex := High(Integer);

    miFileID := TwbFileID.Invalid;
    miLoadOrder := High(Integer);
  end;
  if aTemplate then begin
    SetLength(mlTemplateModules, Succ(Length(mlTemplateModules)));
    mlTemplateModules[High(mlTemplateModules)] := Result;
    Result.miLoadOrder := 10000 + High(mlTemplateModules);
  end else begin
    SetLength(mlAdditionalModules, Succ(Length(mlAdditionalModules)));
    mlAdditionalModules[High(mlAdditionalModules)] := Result;
    mlModulesByName.AddObject(aFileName, Pointer(Result));
  end;
end;

function TwbModuleInfo.Description: string;
begin
  Result := Trim(LoadOrderDescription + ' ' + FlagsDescription);
end;

function TwbModuleInfo.FlagsDescription: string;
begin
  Result := '';
  if mfHasBlueprintFlag in miFlags then
    Result := Result + '<BP>';
  if mfGhost in miFlags then
    Result := Result + '<Ghost>';
  if mfHasESMFlag in miFlags then
    Result := Result + '<ESM>';
  if mfHasLightFlag in miFlags then
    Result := Result + '<Light>';
  if mfHasMediumFlag in miFlags then
    Result := Result + '<Medium>';
  if mfHasUpdateFlag in miFlags then
    Result := Result + '<Update>';
  if mfHasLocalizedFlag in miFlags then
    Result := Result + '<Localized>';
  if mfMastersMissing in miFlags then
    Result := Result + '<MissingMasters>';
end;

function TwbModuleInfo.GetCRC32(out aCRC32: TwbCRC32): Boolean;
begin
  if Assigned(miFile) then
    aCRC32 := _File.CRC32
  else begin
    if miCRC32 = 0 then
      miCRC32 := TwbHash.CRC32(wbDataPath + miOriginalName);
    aCRC32 := miCRC32;
  end;
  Result := aCRC32.IsValid;
end;

function TwbModuleInfo.GetModuleType: TwbModuleType;
begin
  if mfHasLightFlag in miFlags then
    Result := mtLight
  else if mfHasMediumFlag in miFlags then
    Result := mtMedium
  else
    Result := mtFull;
end;

function TwbModuleInfo.HasCRC32(aCRC32: TwbCRC32): Boolean;
begin
  if Assigned(miFile) then
    Exit(_File.CRC32 = aCRC32);
  if miCRC32 = 0 then
    miCRC32 := TwbHash.CRC32(wbDataPath + miOriginalName);
  Result := aCRC32 = miCRC32;
end;

function TwbModuleInfo.HasIndex: Boolean;
begin
  Result := IsValid and (mfHasIndex in miFlags);
end;

function TwbModuleInfo.IsActive: Boolean;
begin
  Result := IsValid and (mfActive in miFlags);
end;

function TwbModuleInfo.IsTemplate: Boolean;
begin
  Result := IsValid and (mfTemplate in miFlags);
end;

function TwbModuleInfo.IsValid: Boolean;
begin
  Result := not ((mfInvalid in miFlags) or (@Self = @_InvalidModule));
end;

function TwbModuleInfo.LoadOrderDescription: string;
begin
  if mfTemplate in miFlags then
    Exit('[Template]');

  Result := '';
  if (mfHasBlueprintFlag in miFlags) and (gcBlueprintPlugins in miContext.GameDefObj.Capabilities) then
    Result := Result + '[BP]';
  if miOfficialIndex = Low(Integer) then
    Result := Result + '[GameMaster]'
  else if miOfficialIndex = Succ(Low(Integer)) then
    Result := Result + '[Hardcoded]'
  else if miOfficialIndex = wbCurrentModuleList.mlUpdateIndex then
    Result := Result + '[Update]'
  else if miOfficialIndex < High(Integer) then
    Result := Result + '[DLC:'+miOfficialIndex.ToString+']';
  if miCCIndex < High(Integer) then
    Result := Result + '[CC:'+miCCIndex.ToString+']';
  if Result = '' then begin
    if (mfIsESM in miFlags) and (gcMastersLoadFirst in miContext.GameDefObj.Capabilities) then
      Result := Result + '[ESM]';

    if miPluginsTxtIndex < High(Integer) then
      Result := Result + '[Plugins.txt:'+miPluginsTxtIndex.ToString+']';
    if miLoadOrderTxtIndex < High(Integer) then
      Result := Result + '[LoadOrder.txt:'+miLoadOrderTxtIndex.ToString+']';

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

function TwbModuleInfo._File: IwbFile;

begin
  if not Supports(miFile, IwbFile, Result) then
    Result := nil;
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
begin
  ExcludeAll(mfActive);
end;

procedure TwbModuleList.ResetSimulatedLoad;
var
  i: Integer;
begin
  for i := Low(mlModules) to High(mlModules) do
    with mlModules[i] do begin
      Exclude(miFlags, mfLoaded);
      Exclude(miFlags, mfLoading);
      miFileID := TwbFileID.Invalid;
      miLoadOrder := High(Integer);
    end;
  mlNextFullSlot := 0;
  mlNextLightSlot := 0;
  mlNextMediumSlot := 0;
end;

procedure TwbModuleList.DisableSimulatedLoad;
begin
  if mlSimulatedLoadDisabled then
    Exit;
  mlSimulatedLoadDisabled := True;
  ResetSimulatedLoad;
end;

procedure TwbModuleInfosHelper.DisableSimulatedLoad;
begin
  wbCurrentModuleList.DisableSimulatedLoad;
end;

procedure TwbModuleInfosHelper.ExcludeAll(aFlag: TwbModuleFlag);
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
    with Self[i]^ do
      Exclude(miFlags, aFlag);
end;

function TwbModuleInfosHelper.FilteredBy(const aFunc: TFunc<PwbModuleInfo, Boolean>): TwbModuleInfos;
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

function TwbModuleInfosHelper.FilteredByFlag(aFlag: TwbModuleFlag; aHasFlag: Boolean = True): TwbModuleInfos;
var
  i, j: Integer;
begin
  SetLength(Result, Length(Self));
  j := 0;
  for i := Low(Self) to High(Self) do
    if (not (aFlag in Self[i]^.miFlags)) xor aHasFlag then begin
      Result[j] := Self[i];
      Inc(j);
    end;
  SetLength(Result, j);
end;

procedure TwbModuleInfosHelper.IncludeAll(aFlag: TwbModuleFlag);
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
    with Self[i]^ do
      Include(miFlags, aFlag);
end;

function TwbModuleInfosHelper.SimulateLoad: TwbModuleInfos;
var
  lList             : TwbModuleList;
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
        miLoadOrder := NewLoadOrderCount;
        NewLoadOrder[NewLoadOrderCount] := aModule;
        Inc(NewLoadOrderCount);
        if not (wbPseudoLight or wbPseudoUpdate) then
          if (mfHasUpdateFlag in miFlags) and not wbIgnoreUpdate then begin
            miFileID := TwbFileID.Invalid;
          end else if (mfHasLightFlag in miFlags) and not wbIgnoreLight then begin
            if lList.mlNextLightSlot > TwbFileID.MaxLightSlot then
              raise Exception.Create('Too many light modules');
            miFileID := TwbFileID.CreateLight(lList.mlNextLightSlot);
            Inc(lList.mlNextLightSlot);
          end else if (mfHasMediumFlag in miFlags) and not wbIgnoreMedium then begin
            if lList.mlNextMediumSlot > TwbFileID.MaxMediumSlot then
              raise Exception.Create('Too many heavy modules');
            miFileID := TwbFileID.CreateMedium(lList.mlNextMediumSlot);
            Inc(lList.mlNextMediumSlot);
          end else begin
            if lList.mlNextFullSlot > TwbFileID.MaxFullSlot then
              raise Exception.Create('Too many full modules');
            miFileID := TwbFileID.CreateFull(lList.mlNextFullSlot);
            Inc(lList.mlNextFullSlot);
          end;
      finally
        Exclude(miFlags, mfLoading);
      end;
    end;
  end;

begin
  lList := wbCurrentModuleList;
  if lList.mlSimulatedLoadDisabled then
    raise Exception.Create('Simulated Load has been disabled');

  lList.ResetSimulatedLoad;
  SetLength(NewLoadOrder, Length(lList.mlModules));
  NewLoadOrderCount := 0;
  for var lSelfIdx := Low(Self) to High(Self) do
    with Self[lSelfIdx]^ do
      if miFlags * [mfActive, mfForceLoad] <> [] then
        Load(Self[lSelfIdx]);
  SetLength(NewLoadOrder, NewLoadOrderCount);

  var lActiveCount := 0;
  for var lNewLoadOrderIdx := Low(NewLoadOrder) to High(NewLoadOrder) do
    with NewLoadOrder[lNewLoadOrderIdx]^ do
      if miFlags * [mfActive] <> [] then
        Inc(lActiveCount);
  if lActiveCount < 1 then
    Exit(nil);

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

end.

