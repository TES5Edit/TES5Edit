{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbLoadOrder;

{$I wbDefines.inc}

interface

uses
  System.Classes,
  System.SysUtils,

  wbHash,
  wbInterface;

type
  TwbLoadingModuleList = class(TwbModuleList)
  public
    procedure LoadModules; override;
  end;

implementation

uses
  System.IOUtils,
  System.Types,

  wbHelpers,
  wbImplementation,
  wbSort;

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

procedure TwbLoadingModuleList.LoadModules;
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
      miOriginalName := lGameDef.GameExeName;
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
          if mlContext.Settings.IgnoreESMFlagForLoadOrder and lGameDef.IsFallout3 then
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

  with ModuleByName(lGameDef.GameMasterEsm)^ do
    if IsValid then begin
      miOfficialIndex := Low(Integer);
      Include(miFlags, mfActive);
      Include(miFlags, mfHasIndex);
      Include(miFlags, mfIsGameMaster);
    end;
  with ModuleByName(lGameDef.GameExeName)^ do
    if IsValid then begin
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
                PrevModule := InvalidModule;
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

initialization
  wbModuleListClass := TwbLoadingModuleList;
end.

