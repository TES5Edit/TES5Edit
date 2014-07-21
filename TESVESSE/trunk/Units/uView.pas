unit uView;

{$IF CompilerVersion >= 17} {$DEFINE USEREGION} {$IFEND}

interface

uses
  uESSFile, VirtualTrees, uHelper, SysUtils, Windows;

type
  tTES = record
    Unknown1: array of record
      formID: TRefID;
      Unknown: uint16;
    end;
    Unknown2: array of record
      formID: TRefID;
      Unknown: array [0..11] of uint8;
    end;
    Unknown3: array of TRefID;
  end;

  tMagicEffect = record
  {$IF Defined(USEREGION)}{$REGION 'tMagicEffect'}{$IFEND}
    effectID: TRefID;
    magnitude: float;
    duration, area: uint32;
    price: float;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
  tEnchantment = record
  {$IF Defined(USEREGION)}{$REGION 'tEnchantment'}{$IFEND}
    refID: TRefID;
    timesUsed: uint32;
    effects: array of tMagicEffect;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
  tEnchantments = array of tEnchantment;
  pEnchantments = ^tEnchantments;
  tCreatedObjects = record
  {$IF Defined(USEREGION)}{$REGION 'tCreatedObjects'}{$IFEND}
    weaponEnchTable: tEnchantments;
    armourEnchTable: tEnchantments;
    potionTable: tEnchantments;
    poisonTable: tEnchantments;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

  tEffect = record
  {$IF Defined(USEREGION)}{$REGION 'tEffect'}{$IFEND}
    strength, timestamp: float;
    unknown: uint32;
    effectID: TRefID;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
  tEffects = record
  {$IF Defined(USEREGION)}{$REGION 'tEffects'}{$IFEND}
    imageSpaceModifiers: array of tEffect;
    unknown1, unknown2: float;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

  tWeather = record
  {$IF Defined(USEREGION)}{$REGION 'tEffect'}{$IFEND}
    climate, weather, prevWeather, unkWeather1, unkWeather2, regnWeather: TRefID;
    curTime, begTime, weatherPct:	float;
    unknown1, unknown2, unknown3, unknown4, unknown5, unknown6: uint32;
    unknown7: float;
    unknown8: uint32;
    flags: uint8;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

  tAudio = record
  {$IF Defined(USEREGION)}{$REGION 'tAudio'}{$IFEND}
    unknown: TRefID;
    tracks: array of TRefID;
    bgm: TRefID;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

  tCell = record
  {$IF Defined(USEREGION)}{$REGION 'tCell'}{$IFEND}
    unknown1, unknown2: TRefID;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
  tSkyCells = record
  {$IF Defined(USEREGION)}{$REGION 'tSkyCells'}{$IFEND}
    Cells: array of tCell;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

  tCrime = record
  {$IF Defined(USEREGION)}{$REGION 'tCrime'}{$IFEND}
    witnessNum, crimeType: uint32;
    unknown1: uint8;
    quantity, serialNum: uint32;
    unknown2: uint8;
    unknown3: uint32;
    elapsedTime: float;
    victimID, criminalID, itemBaseID, ownershipID: TRefID;
    witnesses: array of TRefID;
    bounty: uint32;
    crimeFactionID: TRefID;
    isCleared: uint8;
    unknown4: uint16;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
  tCrimeType = array of tCrime;
  tProcessLists = record
  {$IF Defined(USEREGION)}{$REGION 'tProcessLists'}{$IFEND}
    unknown1, unknown2, unknown3: float;
    nextNum: uint32;
    allCrimes: array [0..6] of tCrimeType;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

  tUnknown = record
  {$IF Defined(USEREGION)}{$REGION 'tUnknown'}{$IFEND}
    unknown1, unknown2: wstring;
    unknown3, unknown4, unknown5, unknown6: uint32;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
  tInterface = record
  {$IF Defined(USEREGION)}{$REGION 'tInterface'}{$IFEND}
    shownHelpMsg: array of uint32;
    unknown1: uint8;
    lastUsedWeapons, lastUsedSpells, lastUsedShouts: array of TRefID;
    unknown2: uint8;
    unknown3: array of tUnknown;
    unknown4: array of wstring;
    unknown5: uint32;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

  tActorCause = record
  {$IF Defined(USEREGION)}{$REGION 'tActorCause'}{$IFEND}
    X, Y, Z: float;
    serialNum: uint32;
    actorID: TRefID;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
  tActorCauses = record
  {$IF Defined(USEREGION)}{$REGION 'tActorCauses'}{$IFEND}
    nextNum: uint32;
    ActorCauses: array of tActorCause;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

  tDetection = record
  {$IF Defined(USEREGION)}{$REGION 'tDetection'}{$IFEND}
    unknown1: TRefID;
    unknown2, unknown3: uint32;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
  tDetectionManager = record
  {$IF Defined(USEREGION)}{$REGION 'tDetectionManager'}{$IFEND}
    Detections: array of tDetection;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

  tMetaData = record
  {$IF Defined(USEREGION)}{$REGION 'tMetaData'}{$IFEND}
    unknown1: TRefID;
    unknown2: uint32;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
  tLocationMetaData = record
  {$IF Defined(USEREGION)}{$REGION 'tLocationMetaData'}{$IFEND}
    MetaData: array of tMetaData;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

  tMagicFavorites = record
  {$IF Defined(USEREGION)}{$REGION 'tMagicFavorites'}{$IFEND}
    favoritedMagics: array of TRefID;
    magicHotKeys: array of TRefID;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

  tIngredientsCombined = record
  {$IF Defined(USEREGION)}{$REGION 'tIngredientsCombined'}{$IFEND}
    ingredient1, ingredient2: TRefID;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
  tIngredientShared = record
  {$IF Defined(USEREGION)}{$REGION 'tIngredientShared'}{$IFEND}
    IngredientsCombined: array of tIngredientsCombined;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

  tAnimObject = record
  {$IF Defined(USEREGION)}{$REGION 'tAnimObject'}{$IFEND}
    achr, anim: TRefID;
    unk1: uint8;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
  tAnimObjects = record
  {$IF Defined(USEREGION)}{$REGION 'tAnimObjects'}{$IFEND}
    objects: array of tAnimObject;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure ClearAll;

procedure vtTESInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
procedure vtCreatedObjectsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
procedure vtEffectsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
procedure vtWeatherInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
procedure vtAudioInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
procedure vtSkyCellsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
procedure vtProcessListsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
procedure vtInterfaceInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
procedure vtActorCausesInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
procedure vtDetectionManagerInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
procedure vtLocationMetaDataInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
procedure vtMagicFavoritesInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
procedure vtIngredientSharedInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
procedure vtAnimObjectsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);

procedure tsTESShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
procedure tsCreatedObjectsShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
procedure tsEffectsShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
procedure tsWeatherShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
procedure tsAudioShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
procedure tsSkyCellsShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
procedure tsProcessListsShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
procedure tsInterfaceShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
procedure tsActorCausesShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
procedure tsDetectionManagerShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
procedure tsLocationMetaDataShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
procedure tsMagicFavoritesShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
procedure tsIngredientSharedShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
procedure tsAnimObjectsShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);

implementation

var
  vTES: tTES;
  vCreatedObjects: tCreatedObjects;
  vEffects: tEffects;
  vProcessLists: tProcessLists;
  vInterface: tInterface;
  vActorCauses: tActorCauses;
  vDetectionManager: tDetectionManager;
  vLocationMetaData: tLocationMetaData;
  vMagicFavorites: tMagicFavorites;
  vIngredientShared: tIngredientShared;
  vAnimObjects: tAnimObjects;
  vWeather: tWeather;
  vAudio: tAudio;
  vSkyCells: tSkyCells;

function GetCrimeType(Crime: uint32): string;
begin
  case Crime of
    0: Result := 'Theft';
    1: Result := 'Pickpocketing';
    2: Result := 'Trespassing';
    3: Result := 'Assault';
    4: Result := 'Murder';
    6: Result := 'Lycanthropy';
    else
      Result := '';
  end;
end;

procedure ClearTES;
begin
  SetLength(vTES.Unknown1, 0);
  SetLength(vTES.Unknown2, 0);
  SetLength(vTES.Unknown3, 0);
end;

procedure ClearCreatedObjects;
begin {$IF Defined(USEREGION)}{$REGION 'ClearCreatedObjects'}{$IFEND}
  with vCreatedObjects do
  begin
    while Length(weaponEnchTable) > 0 do
    begin
      with weaponEnchTable[Length(weaponEnchTable) - 1] do
        SetLength(effects, 0);
      SetLength(weaponEnchTable, Length(weaponEnchTable) - 1);
    end;
    while Length(armourEnchTable) > 0 do
    begin
      with armourEnchTable[Length(armourEnchTable) - 1] do
        SetLength(effects, 0);
      SetLength(armourEnchTable, Length(armourEnchTable) - 1);
    end;
    while Length(potionTable) > 0 do
    begin
      with potionTable[Length(potionTable) - 1] do
        SetLength(effects, 0);
      SetLength(potionTable, Length(potionTable) - 1);
    end;
    while Length(poisonTable) > 0 do
    begin
      with poisonTable[Length(poisonTable) - 1] do
        SetLength(effects, 0);
      SetLength(poisonTable, Length(poisonTable) - 1);
    end;
  end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}
end;

procedure ClearEffects;
begin
  SetLength(vEffects.imageSpaceModifiers, 0)
end;

procedure CleartProcessLists;
{$IF Defined(USEREGION)}{$REGION 'CleartProcessLists'}{$IFEND}
var
  i: integer;
begin
  with vProcessLists do
    for i := 0 to 6 do
      while Length(allCrimes[i]) > 0 do
      begin
        SetLength(allCrimes[i][Length(allCrimes[i]) - 1].witnesses, 0);
        SetLength(allCrimes[i], Length(allCrimes[i]) - 1);
      end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure ClearInterface;
{$IF Defined(USEREGION)}{$REGION 'CleartInterface'}{$IFEND}
begin
  with vInterface do
  begin
    SetLength(shownHelpMsg, 0);
    SetLength(lastUsedWeapons, 0);
    SetLength(lastUsedSpells, 0);
    SetLength(lastUsedShouts, 0);
    while Length(unknown3) > 0 do
    begin
      with unknown3[Length(unknown3) - 1] do
      begin
        unknown1 := StringTowstring('');
        unknown2 := StringTowstring('');
      end;
      SetLength(unknown3, Length(unknown3) - 1);
    end;
    while Length(unknown4) > 0 do
    begin
      unknown4[Length(unknown4) - 1] := StringTowstring('');
      SetLength(unknown4, Length(unknown4) - 1);
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure ClearActorCauses;
begin
  SetLength(vActorCauses.ActorCauses, 0);
end;

procedure ClearDetectionManager;
begin
  SetLength(vDetectionManager.Detections, 0);
end;

procedure ClearLocationMetaData;
begin
  SetLength(vLocationMetaData.MetaData, 0);
end;

procedure ClearMagicFavorites;
begin
  SetLength(vMagicFavorites.favoritedMagics, 0);
  SetLength(vMagicFavorites.magicHotKeys, 0);
end;

procedure ClearIngredientShared;
begin
  SetLength(vIngredientShared.IngredientsCombined, 0);
end;

procedure ClearAnimObjects;
begin
  SetLength(vAnimObjects.objects, 0);
end;

procedure ClearAudio;
begin
  SetLength(vAudio.tracks, 0);
end;

procedure ClearSkyCells;
begin
  SetLength(vSkyCells.Cells, 0);
end;

procedure vtTESInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtTESInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
begin
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vTES do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: case Node^.Index of
             0: _Caption := 'Unknown 1 (' + IntToStr(Length(Unknown1)) + ')';
             1: _Caption := 'Unknown 2 (' + IntToStr(Length(Unknown2)) + ')';
             2: _Caption := 'Unknown 3 (' + IntToStr(Length(Unknown3)) + ')';
           end;
        1: if Node^.Parent^.Index < 2 then
             _Caption := IntToStr(Node^.Index)
           else
             if Node^.Index < Cardinal(Length(Unknown3)) then
               _Caption := 'formID: ' + RefIDToString(Unknown3[Node^.Index]);
        2: case Node^.Parent^.Parent^.Index of
             0: if Node^.Parent^.Index < Cardinal(Length(Unknown1)) then
                  case Node^.Index of
                    0: _Caption := 'formID: ' + RefIDToString(Unknown1[Node^.Parent^.Index].formID);
                    1: _Caption := 'unknown: ' + IntToStr(Unknown1[Node^.Parent^.Index].Unknown);
                  end;
             1: if Node^.Parent^.Index < Cardinal(Length(Unknown2)) then
                  case Node^.Index of
                    0: _Caption := 'formID: ' + RefIDToString(Unknown2[Node^.Parent^.Index].formID);
                    1: _Caption := 'unknown (12)';
                  end;
           end;
        3: if (Node^.Parent^.Parent^.Parent^.Index = 1) and (Node^.Index < 12) then
             _Caption := IntToStr(Node^.Index) + ': ' + IntToStr(Unknown2[Node^.Parent^.Parent^.Index].Unknown[Node^.Index]);
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure vtCreatedObjectsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtCreatedObjectsInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
  Enchs: pEnchantments;
begin
  Enchs := nil;
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vCreatedObjects do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: case Node^.Index of
             0: _Caption := 'weaponEnchTable (' + IntToStr(Length(weaponEnchTable)) + ')';
             1: _Caption := 'armourEnchTable (' + IntToStr(Length(armourEnchTable)) + ')';
             2: _Caption := 'potionTable (' + IntToStr(Length(potionTable)) + ')';
             3: _Caption := 'poisonTable (' + IntToStr(Length(poisonTable)) + ')';
           end;
        1: _Caption := IntToStr(Node^.Index);
        2: begin
             case Node^.Parent^.Parent^.Index of
               0: Enchs := @weaponEnchTable;
               1: Enchs := @armourEnchTable;
               2: Enchs := @potionTable;
               3: Enchs := @poisonTable;
             end;
             if Assigned(Enchs) and (Node^.Parent^.Index < Cardinal(Length(Enchs^))) then
               case Node^.Index of
                 0: _Caption := 'refID: ' + RefIDToString(Enchs^[Node^.Parent^.Index].refID);
                 1: _Caption := 'timesUsed: ' + IntToStr(Enchs^[Node^.Parent^.Index].timesUsed);
                 2: _Caption := 'effects (' + IntToStr(Length(Enchs^[Node^.Parent^.Index].effects)) + ')';
               end;
           end;
        3: _Caption := IntToStr(Node^.Index);
        4: begin
             case Node^.Parent^.Parent^.Parent^.Parent^.Index of
               0: Enchs := @weaponEnchTable;
               1: Enchs := @armourEnchTable;
               2: Enchs := @potionTable;
               3: Enchs := @poisonTable;
             end;
             if Assigned(Enchs) and (Node^.Parent^.Parent^.Parent^.Index < Cardinal(Length(Enchs^))) and (Node^.Parent^.Index < Cardinal(Length(Enchs^[Node^.Parent^.Parent^.Parent^.Index].effects))) then
               case Node^.Index of
                 0: _Caption := 'effectID: ' + RefIDToString(Enchs^[Node^.Parent^.Parent^.Parent^.Index].effects[Node^.Parent^.Index].effectID);
                 1: _Caption := 'magnitude: ' + FloatToStr(Enchs^[Node^.Parent^.Parent^.Parent^.Index].effects[Node^.Parent^.Index].magnitude);
                 2: _Caption := 'duration: ' + IntToStr(Enchs^[Node^.Parent^.Parent^.Parent^.Index].effects[Node^.Parent^.Index].duration);
                 3: _Caption := 'area: ' + IntToStr(Enchs^[Node^.Parent^.Parent^.Parent^.Index].effects[Node^.Parent^.Index].area);
                 4: _Caption := 'price: ' + FloatToStr(Enchs^[Node^.Parent^.Parent^.Parent^.Index].effects[Node^.Parent^.Index].price);
               end;
           end;
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure vtEffectsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtEffectsInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
begin
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vEffects do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: case Node^.Index of
             0: _Caption := 'imageSpaceModifiers (' + IntToStr(Length(imageSpaceModifiers)) + ')';
             1: _Caption := 'Unknown 1: ' + FloatToStr(unknown1);
             2: _Caption := 'Unknown 2: ' + FloatToStr(unknown2);
           end;
        1: _Caption := IntToStr(Node^.Index);
        2: if Node^.Parent^.Parent^.Index = 0 then
             if Node^.Parent^.Index < Cardinal(Length(imageSpaceModifiers)) then
                case Node^.Index of
                  0: _Caption := 'strength: ' + FloatToStr(imageSpaceModifiers[Node^.Parent^.Index].strength);
                  1: _Caption := 'timestamp: ' + FloatToStr(imageSpaceModifiers[Node^.Parent^.Index].timestamp);
                  2: _Caption := 'unknown: ' + IntToStr(imageSpaceModifiers[Node^.Parent^.Index].Unknown);
                  3: _Caption := 'effectID: ' + RefIDToString(imageSpaceModifiers[Node^.Parent^.Index].effectID);
                end;
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure vtWeatherInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtWeatherInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
begin
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vWeather do
    begin
      _Caption := '';
      case Node^.Index of
        0: _Caption := 'climate: ' + RefIDToString(climate);
        1: _Caption := 'weather: ' + RefIDToString(weather);
        2: _Caption := 'prevWeather: ' + RefIDToString(prevWeather);
        3: _Caption := 'unkWeather1: ' + RefIDToString(unkWeather1);
        4: _Caption := 'unkWeather2: ' + RefIDToString(unkWeather2);
        5: _Caption := 'regnWeather: ' + RefIDToString(regnWeather);
        6: _Caption := 'curTime: ' + FloatToStr(curTime);
        7: _Caption := 'begTime: ' + FloatToStr(begTime);
        8: _Caption := 'weatherPct: ' + FloatToStr(weatherPct);
        9: _Caption := 'unknown 1: ' + IntToStr(unknown1);
        10: _Caption := 'unknown 2: ' + IntToStr(unknown2);
        11: _Caption := 'unknown 3: ' + IntToStr(unknown3);
        12: _Caption := 'unknown 4: ' + IntToStr(unknown4);
        13: _Caption := 'unknown 5: ' + IntToStr(unknown5);
        14: _Caption := 'unknown 6: ' + IntToStr(unknown6);
        15: _Caption := 'unknown 7: ' + FloatToStr(unknown7);
        16: _Caption := 'unknown 8: ' + IntToStr(unknown8);
        17: _Caption := 'flags: ' + IntToStr(flags);
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure vtAudioInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtAudioInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
begin
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vAudio do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: case Node^.Index of
             0: _Caption := 'unknown: ' + RefIDToString(unknown);
             1: _Caption := 'tracks: (' + IntToStr(Length(tracks)) + ')';
             2: _Caption := 'bgm: ' + RefIDToString(bgm);
           end;
        1: if Node^.Index < Cardinal(Length(tracks)) then
             _Caption := IntToStr(Node^.Index) + ': ' + RefIDToString(tracks[Node^.Index]) ;
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure vtSkyCellsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtSkyCellsInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
begin
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vSkyCells do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: _Caption := 'Cells (' + IntToStr(Length(Cells)) + ')';
        1: _Caption := IntToStr(Node^.Index);
        2: if Node^.Parent^.Index < Cardinal(Length(Cells)) then
              case Node^.Index of
                0: _Caption := 'unknown1: ' + RefIDToString(Cells[Node^.Parent^.Index].unknown1);
                1: _Caption := 'unknown2: ' + RefIDToString(Cells[Node^.Parent^.Index].unknown2);
              end;
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure vtProcessListsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtProcessListsInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
begin
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vProcessLists do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: case Node^.Index of
             0: _Caption := 'Unknown 1: ' + FloatToStr(unknown1);
             1: _Caption := 'Unknown 2: ' + FloatToStr(unknown2);
             2: _Caption := 'Unknown 3: ' + FloatToStr(unknown3);
             3: _Caption := 'nextNum: ' + FloatToStr(nextNum);
             4: _Caption := 'imageSpaceModifiers (7)';
           end;
        1: if GetCrimeType(Node^.Index) <> '' then
             _Caption := GetCrimeType(Node^.Index) + ' (' + IntToStr(Length(allCrimes[Node^.Index])) + ')'
           else
             _Caption := 'imageSpaceModifiers[' + IntToStr(Node^.Index)+ '] (' + IntToStr(Length(allCrimes[Node^.Index])) + ')';
        2: _Caption := IntToStr(Node^.Index);
        3: if Node^.Parent^.Index < Cardinal(Length(allCrimes[Node^.Parent^.Parent^.Index])) then
             with allCrimes[Node^.Parent^.Parent^.Index][Node^.Parent^.Index] do
               case Node^.Index of
                 0: _Caption := 'witnessNum: ' + IntToStr(witnessNum);
                 1: _Caption := 'crimeType: ' + IntToStr(crimeType) + ' [' + GetCrimeType(crimeType) + ']';
                 2: _Caption := 'unknown1: ' + IntToStr(unknown1);
                 3: _Caption := 'quantity: ' + IntToStr(quantity);
                 4: _Caption := 'serialNum: ' + IntToStr(serialNum);
                 5: _Caption := 'unknown2: ' + IntToStr(unknown2);
                 6: _Caption := 'unknown3: ' + IntToStr(unknown3);
                 7: _Caption := 'elapsedTime: ' + FloatToStr(elapsedTime);
                 8: _Caption := 'victimID: ' + RefIDToString(victimID);
                 9: _Caption := 'criminalID: ' + RefIDToString(criminalID);
                 10: _Caption := 'itemBaseID: ' + RefIDToString(itemBaseID);
                 11: _Caption := 'ownershipID: ' + RefIDToString(ownershipID);
                 12: _Caption := 'witnesses: (' + IntToStr(Length(witnesses)) + ')';
                 13: _Caption := 'bounty: ' + IntToStr(bounty);
                 14: _Caption := 'crimeFactionID: ' + RefIDToString(crimeFactionID);
                 15: _Caption := 'isCleared: ' + IntToStr(isCleared);
                 16: _Caption := 'unknown4: ' + IntToStr(unknown4);
               end;
        4: if Node^.Index < Cardinal(Length(allCrimes[Node^.Parent^.Parent^.Parent^.Index][Node^.Parent^.Parent^.Index].witnesses)) then
           _Caption := IntToStr(Node^.Index) + ': ' + RefIDToString(allCrimes[Node^.Parent^.Parent^.Parent^.Index][Node^.Parent^.Parent^.Index].witnesses[Node^.Index]);
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure vtInterfaceInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtInterfaceInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
begin
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vInterface do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: case Node^.Index of
             0: _Caption := 'shownHelpMsg (' + IntToStr(Length(shownHelpMsg)) + ')';
             1: _Caption := 'Unknown 1: ' + IntToStr(Unknown1) + ' [0x' + IntToHex(Unknown1, 2) + ']';
             2: _Caption := 'lastUsedWeapons (' + IntToStr(Length(lastUsedWeapons)) + ')';
             3: _Caption := 'lastUsedSpells (' + IntToStr(Length(lastUsedSpells)) + ')';
             4: _Caption := 'lastUsedShouts (' + IntToStr(Length(lastUsedShouts)) + ')';
             5: _Caption := 'Unknown 2: ' + IntToStr(Unknown2) + ' [0x' + IntToHex(Unknown2, 2) + ']';
             6: _Caption := 'Unknown 3 (' + IntToStr(Length(unknown3)) + ')';
             7: _Caption := 'Unknown 4 (' + IntToStr(Length(unknown4)) + ')';
             8: _Caption := 'Unknown 5: ' + IntToStr(Unknown5) + ' [0x' + IntToHex(Unknown5, 8) + ']';
           end;
        1: case Node^.Parent^.Index of
             0: if Node^.Index < Cardinal(Length(shownHelpMsg)) then
                  _Caption := IntToStr(Node^.Index) + ': 0x' + IntToHex(shownHelpMsg[Node^.Index], 8);
             2:  if Node^.Index < Cardinal(Length(lastUsedWeapons)) then
                  _Caption := IntToStr(Node^.Index) + ': ' + RefIDToString(lastUsedWeapons[Node^.Index]);
             3:  if Node^.Index < Cardinal(Length(lastUsedSpells)) then
                  _Caption := IntToStr(Node^.Index) + ': ' + RefIDToString(lastUsedSpells[Node^.Index]);
             4:  if Node^.Index < Cardinal(Length(lastUsedShouts)) then
                  _Caption := IntToStr(Node^.Index) + ': ' + RefIDToString(lastUsedShouts[Node^.Index]);
             6: _Caption := IntToStr(Node^.Index);
             7:  if Node^.Index < Cardinal(Length(unknown4)) then
                  _Caption := IntToStr(Node^.Index) + ': ' + wstringToString(unknown4[Node^.Index]);
           end;
        2: if (Node^.Parent^.Parent^.Index = 6) and (Node^.Parent^.Index < Cardinal(Length(unknown3))) then
              case Node^.Index of
                0: _Caption := 'unknown 1: ' + wstringToString(Unknown3[Node^.Parent^.Index].unknown1);
                1: _Caption := 'unknown 2: ' + wstringToString(Unknown3[Node^.Parent^.Index].unknown2);
                3: _Caption := 'unknown 3: ' + IntToStr(Unknown3[Node^.Parent^.Index].Unknown3);
                4: _Caption := 'unknown 4: ' + IntToStr(Unknown3[Node^.Parent^.Index].Unknown4);
                5: _Caption := 'unknown 5: ' + IntToStr(Unknown3[Node^.Parent^.Index].Unknown5);
                6: _Caption := 'unknown 6: ' + IntToStr(Unknown3[Node^.Parent^.Index].Unknown6);
              end;
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure vtActorCausesInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtActorCausesInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
begin
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vActorCauses do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: case Node^.Index of
             0: _Caption := 'nextNum: ' + IntToStr(nextNum);
             1: _Caption := 'ActorCauses (' + IntToStr(Length(ActorCauses)) + ')';
           end;
        1: _Caption := IntToStr(Node^.Index);
        2: if Node^.Parent^.Index < Cardinal(Length(ActorCauses)) then
              case Node^.Index of
                0: _Caption := 'X: ' + FloatToStr(ActorCauses[Node^.Parent^.Index].X);
                1: _Caption := 'Y: ' + FloatToStr(ActorCauses[Node^.Parent^.Index].Y);
                2: _Caption := 'Z: ' + FloatToStr(ActorCauses[Node^.Parent^.Index].Z);
                3: _Caption := 'serialNum: ' + IntToStr(ActorCauses[Node^.Parent^.Index].serialNum);
                4: _Caption := 'actorID: ' + RefIDToString(ActorCauses[Node^.Parent^.Index].actorID);
              end;
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure vtDetectionManagerInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtDetectionManagerInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
begin
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vDetectionManager do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: _Caption := 'Detections (' + IntToStr(Length(Detections)) + ')';
        1: _Caption := IntToStr(Node^.Index);
        2: if Node^.Parent^.Index < Cardinal(Length(Detections)) then
              case Node^.Index of
                0: _Caption := 'unknown1: ' + RefIDToString(Detections[Node^.Parent^.Index].unknown1);
                1: _Caption := 'unknown2: ' + IntToStr(Detections[Node^.Parent^.Index].unknown2);
                2: _Caption := 'unknown3: ' + IntToStr(Detections[Node^.Parent^.Index].unknown3);
              end;
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure vtLocationMetaDataInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtLocationMetaDataInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
begin
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vLocationMetaData do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: _Caption := 'LocationMetaData (' + IntToStr(Length(MetaData)) + ')';
        1: _Caption := IntToStr(Node^.Index);
        2: if Node^.Parent^.Index < Cardinal(Length(MetaData)) then
              case Node^.Index of
                0: _Caption := 'unknown1: ' + RefIDToString(MetaData[Node^.Parent^.Index].unknown1);
                1: _Caption := 'unknown2: ' + IntToStr(MetaData[Node^.Parent^.Index].unknown2);
              end;
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure vtMagicFavoritesInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtMagicFavoritesInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
begin
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vMagicFavorites do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: case Node^.Index of
             0: _Caption := 'favoritedMagics (' + IntToStr(Length(favoritedMagics)) + ')';
             1: _Caption := 'magicHotKeys (' + IntToStr(Length(magicHotKeys)) + ')';
           end;
        1: case Node^.Parent^.Index of
             0: if Node^.Index < Cardinal(Length(favoritedMagics)) then
                  _Caption := IntToStr(Node^.Index) + ': ' + RefIDToString(favoritedMagics[Node^.Index]);
             1: if Node^.Index < Cardinal(Length(magicHotKeys)) then
                  _Caption := IntToStr(Node^.Index) + ': ' + RefIDToString(magicHotKeys[Node^.Index]);
           end;
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure vtIngredientSharedInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtIngredientSharedInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
begin
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vIngredientShared do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: _Caption := 'IngredientsCombined (' + IntToStr(Length(IngredientsCombined)) + ')';
        1: _Caption := IntToStr(Node^.Index);
        2: if Node^.Parent^.Index < Cardinal(Length(IngredientsCombined)) then
              case Node^.Index of
                0: _Caption := 'ingredient1: ' + RefIDToString(IngredientsCombined[Node^.Parent^.Index].ingredient1);
                1: _Caption := 'ingredient2: ' + RefIDToString(IngredientsCombined[Node^.Parent^.Index].ingredient2);
              end;
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure vtAnimObjectsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
{$IF Defined(USEREGION)}{$REGION 'vtAnimObjectsInitNode'}{$IFEND}
var
  Rec: PPapyrusRec;
begin
  with Sender do
  begin
    Rec := GetNodeData(Node);
    with Rec^, vAnimObjects do
    begin
      _Caption := '';
      case GetNodeLevel(Node) of
        0: _Caption := 'AnimObjects (' + IntToStr(Length(objects)) + ')';
        1: _Caption := IntToStr(Node^.Index);
        2: if Node^.Parent^.Index < Cardinal(Length(objects)) then
              case Node^.Index of
                0: _Caption := 'achr: ' + RefIDToString(objects[Node^.Parent^.Index].achr);
                1: _Caption := 'anim: ' + RefIDToString(objects[Node^.Parent^.Index].anim);
                2: _Caption := 'unk1: ' + IntToStr(objects[Node^.Parent^.Index].unk1);
              end;
      end;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

{$IF Defined(USEREGION)}{$REGION 'Internal read and check'}{$IFEND}
procedure Read_uint32_(var Result: uint32; var Buf: TBytes; var FromPos: Integer);
begin
  if FromPos > 0 then
    Result := Read_uint32(Buf, FromPos);
end;

procedure Read_uint16_(var Result: uint16; var Buf: TBytes; var FromPos: Integer);
begin
  if FromPos > 0 then
    Result := Read_uint16(Buf, FromPos);
end;
procedure Read_uint8_(var Result: uint8; var Buf: TBytes; var FromPos: Integer);
begin
  if FromPos > 0 then
    Result := Read_uint8(Buf, FromPos);
end;

procedure Read_float32_(var Result: float32; var Buf: TBytes; var FromPos: Integer);
begin
  if FromPos > 0 then
    Result := Read_float32(Buf, FromPos);
end;

procedure Read_RefID_(var Result: TRefID; var Buf: TBytes; var FromPos: Integer);
begin
  if FromPos > 0 then
    Result := Read_RefID(Buf, FromPos);
end;

procedure Read_wstring_(var Result: wstring; var Buf: TBytes; var FromPos: Integer);
begin
  if FromPos > 0 then
    Result := Read_wstring(Buf, FromPos);
end;

procedure Read_vsval_(var Result: vsval; var Buf: TBytes; var FromPos: Integer);
begin
  if FromPos > 0 then
    Result := Read_vsval(Buf, FromPos);
end;
{$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsTESShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsTESShow'}{$IFEND}
var
  iPos, i, j: Integer;
  MyData: PMyRec;
  iCount: uInt32;
  pRoot, pLvl1, pLvl2: PVirtualNode;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vTES do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        iCount := Read_vsval(TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(Unknown1, iCount);
          for i := 0 to iCount - 1 do
            with Unknown1[i] do
            begin
              Read_RefID_(formID, TBytes(MyData^._Pointer^), iPos);
              Read_uint16_(Unknown, TBytes(MyData^._Pointer^), iPos);
            end;
        end;
        Read_uint32_(iCount, TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(Unknown2, iCount);
          for i := 0 to iCount - 1 do
            with Unknown2[i] do
            begin
              ZeroMemory(@Unknown[0], SizeOf(Unknown));
              Read_RefID_(formID, TBytes(MyData^._Pointer^), iPos);
              for j := 0 to 11 do
                Read_uint8_(Unknown[j], TBytes(MyData^._Pointer^), iPos);
            end;
        end;
        Read_vsval_(iCount, TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(Unknown3, iCount);
          for i := 0 to iCount - 1 do
            Read_RefID_(Unknown3[i], TBytes(MyData^._Pointer^), iPos);
        end;
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vTES do
  begin
    BeginUpdate;
    try
      RootNodeCount := 3;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        case pRoot^.Index of
          0: ChildCount[pRoot] := Length(Unknown1);
          1: ChildCount[pRoot] := Length(Unknown2);
          2: ChildCount[pRoot] := Length(Unknown3);
        end;
        Expanded[pRoot] := pRoot^.Index = 0;
        InvalidateToBottom(pRoot);
        if pRoot^.Index < 2 then
        begin
          pLvl1 := pRoot.FirstChild;
          if Assigned(pLvl1) then
          repeat
            Expanded[pLvl1] := False;
            ChildCount[pLvl1] := 2;
            InvalidateToBottom(pLvl1);
            if pRoot^.Index = 1 then
            begin
              pLvl2 := pLvl1.FirstChild;
              if Assigned(pLvl2) then
              repeat
                Expanded[pLvl2] := False;
                if pLvl2^.Index = 1 then
                  ChildCount[pLvl2] := 12;
                InvalidateToBottom(pLvl2);
                pLvl2 := pLvl2.NextSibling;
              until not Assigned(pLvl2);
            end;
            pLvl1 := pLvl1.NextSibling;
          until not Assigned(pLvl1);
        end;
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsCreatedObjectsShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsCreatedObjectsShow'}{$IFEND}
var
  iPos, i, j, k: Integer;
  MyData: PMyRec;
  iCount, iEffect: uInt32;
  pRoot, pLvl1, pLvl2, pLvl3: PVirtualNode;
  Enchs: pEnchantments;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vCreatedObjects do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        Enchs := nil;
        iCount := 0;
        iEffect := 0;
        for j := 0 to 3 do
        begin
          case j of
            0: Enchs := @weaponEnchTable;
            1: Enchs := @armourEnchTable;
            2: Enchs := @potionTable;
            3: Enchs := @poisonTable;
          end;
          if Assigned(Enchs) then
          begin
            if (j = 0) or (iPos > 0) then
              iCount := Read_vsval(TBytes(MyData^._Pointer^), iPos);
            if iPos > 0 then
            begin
              SetLength(Enchs^, iCount);
              for i := 0 to iCount - 1 do
                with Enchs^[i] do
                begin
                  Read_RefID_(refID, TBytes(MyData^._Pointer^), iPos);
                  Read_uint32_(timesUsed, TBytes(MyData^._Pointer^), iPos);
                  Read_vsval_(iEffect, TBytes(MyData^._Pointer^), iPos);
                  if iPos > 0 then
                  begin
                    SetLength(effects, iEffect);
                    for k := 0 to iEffect - 1 do
                      with effects[k] do
                      begin
                        Read_RefID_(effectID, TBytes(MyData^._Pointer^), iPos);
                        Read_float32_(magnitude, TBytes(MyData^._Pointer^), iPos);
                        Read_uint32_(duration, TBytes(MyData^._Pointer^), iPos);
                        Read_uint32_(area, TBytes(MyData^._Pointer^), iPos);
                        Read_float32_(price, TBytes(MyData^._Pointer^), iPos);
                      end;
                  end;
                end;
            end;
          end;
        end;
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vCreatedObjects do
  begin
    BeginUpdate;
    try
      RootNodeCount := 4;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        case pRoot^.Index of
          0: Enchs := @weaponEnchTable;
          1: Enchs := @armourEnchTable;
          2: Enchs := @potionTable;
          3: Enchs := @poisonTable;
        else
          Enchs := nil;
        end;
        if Assigned(Enchs) then
        begin
          ChildCount[pRoot] := Length(Enchs^);
          Expanded[pRoot] := pRoot^.Index = 0;
          InvalidateToBottom(pRoot);
          pLvl1 := pRoot.FirstChild;
          if Assigned(pLvl1) then
          repeat
            Expanded[pLvl1] := False;
            ChildCount[pLvl1] := 3;
            InvalidateToBottom(pLvl1);
            pLvl2 := pLvl1.FirstChild;
            if Assigned(pLvl2) then
            repeat
              Expanded[pLvl2] := False;
              if pLvl2^.Index = 2 then
                ChildCount[pLvl2] := Length(Enchs^[pLvl1^.Index].effects);
              InvalidateToBottom(pLvl2);
              pLvl3 := pLvl2.FirstChild;
              if Assigned(pLvl3) then
              repeat
                Expanded[pLvl3] := False;
                ChildCount[pLvl3] := 5;
                InvalidateToBottom(pLvl3);
                pLvl3 := pLvl3.NextSibling;
              until not Assigned(pLvl3);
              pLvl2 := pLvl2.NextSibling;
            until not Assigned(pLvl2);
            pLvl1 := pLvl1.NextSibling;
          until not Assigned(pLvl1);
        end;
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsEffectsShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsEffectsShow'}{$IFEND}
var
  iPos, i: Integer;
  MyData: PMyRec;
  iCount: uInt32;
  pRoot, pLvl1: PVirtualNode;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vEffects do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        iCount := Read_vsval(TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(imageSpaceModifiers, iCount);
          for i := 0 to iCount - 1 do
            with imageSpaceModifiers[i] do
            begin
              Read_float32_(strength, TBytes(MyData^._Pointer^), iPos);
              Read_float32_(timestamp, TBytes(MyData^._Pointer^), iPos);
              Read_uint32_(Unknown, TBytes(MyData^._Pointer^), iPos);
              Read_RefID_(effectID, TBytes(MyData^._Pointer^), iPos);
            end;
        end;
        Read_float32_(unknown1, TBytes(MyData^._Pointer^), iPos);
        Read_float32_(unknown2, TBytes(MyData^._Pointer^), iPos);
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vEffects do
  begin
    BeginUpdate;
    try
      RootNodeCount := 3;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        if pRoot^.Index = 0 then
          ChildCount[pRoot] := Length(imageSpaceModifiers);
        Expanded[pRoot] := pRoot^.Index = 0;
        InvalidateToBottom(pRoot);
        if pRoot^.Index = 0 then
        begin
          pLvl1 := pRoot.FirstChild;
          if Assigned(pLvl1) then
          repeat
            Expanded[pLvl1] := False;
            ChildCount[pLvl1] := 4;
            InvalidateToBottom(pLvl1);
            pLvl1 := pLvl1.NextSibling;
          until not Assigned(pLvl1);
        end;
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsWeatherShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsWeatherShow'}{$IFEND}
var
  iPos: Integer;
  MyData: PMyRec;
  pRoot: PVirtualNode;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vWeather do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        climate := Read_RefID(TBytes(MyData^._Pointer^), iPos);
        Read_RefID_(weather, TBytes(MyData^._Pointer^), iPos);
        Read_RefID_(prevWeather, TBytes(MyData^._Pointer^), iPos);
        Read_RefID_(unkWeather1, TBytes(MyData^._Pointer^), iPos);
        Read_RefID_(unkWeather2, TBytes(MyData^._Pointer^), iPos);
        Read_RefID_(regnWeather, TBytes(MyData^._Pointer^), iPos);
        Read_float32_(curTime, TBytes(MyData^._Pointer^), iPos);
        Read_float32_(begTime, TBytes(MyData^._Pointer^), iPos);
        Read_float32_(weatherPct, TBytes(MyData^._Pointer^), iPos);
        Read_uint32_(unknown1, TBytes(MyData^._Pointer^), iPos);
        Read_uint32_(unknown2, TBytes(MyData^._Pointer^), iPos);
        Read_uint32_(unknown3, TBytes(MyData^._Pointer^), iPos);
        Read_uint32_(unknown4, TBytes(MyData^._Pointer^), iPos);
        Read_uint32_(unknown5, TBytes(MyData^._Pointer^), iPos);
        Read_uint32_(unknown6, TBytes(MyData^._Pointer^), iPos);
        Read_float32_(unknown7, TBytes(MyData^._Pointer^), iPos);
        Read_uint32_(unknown8, TBytes(MyData^._Pointer^), iPos);
        Read_uint8_(flags, TBytes(MyData^._Pointer^), iPos);
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vWeather do
  begin
    BeginUpdate;
    try
      RootNodeCount := 18;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        InvalidateToBottom(pRoot);
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsAudioShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsAudioShow'}{$IFEND}
var
  iPos, i: Integer;
  MyData: PMyRec;
  iCount: uInt32;
  pRoot: PVirtualNode;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vAudio do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        iCount := 0;
        unknown := Read_RefID(TBytes(MyData^._Pointer^), iPos);
        Read_vsval_(iCount, TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(tracks, iCount);
          for i := 0 to iCount - 1 do
            Read_RefID_(tracks[i], TBytes(MyData^._Pointer^), iPos);
        end;
        Read_RefID_(bgm, TBytes(MyData^._Pointer^), iPos);
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vAudio do
  begin
    BeginUpdate;
    try
      RootNodeCount := 3;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        if pRoot^.Index = 1 then
          ChildCount[pRoot] := Length(tracks);
        Expanded[pRoot] := pRoot^.Index = 1;
        InvalidateToBottom(pRoot);
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsSkyCellsShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsSkyCellsShow'}{$IFEND}
var
  iPos, i: Integer;
  MyData: PMyRec;
  iCount: uInt32;
  pRoot, pLvl1: PVirtualNode;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vSkyCells do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        iCount := Read_vsval(TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(Cells, iCount);
          for i := 0 to iCount - 1 do
            with Cells[i] do
            begin
              Read_RefID_(unknown1, TBytes(MyData^._Pointer^), iPos);
              Read_RefID_(unknown2, TBytes(MyData^._Pointer^), iPos);
            end;
        end;
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vSkyCells do
  begin
    BeginUpdate;
    try
      RootNodeCount := 1;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        ChildCount[pRoot] := Length(Cells);
        Expanded[pRoot] := True;
        InvalidateToBottom(pRoot);
        pLvl1 := pRoot.FirstChild;
        if Assigned(pLvl1) then
        repeat
          Expanded[pLvl1] := False;
          ChildCount[pLvl1] := 2;
          InvalidateToBottom(pLvl1);
          pLvl1 := pLvl1.NextSibling;
        until not Assigned(pLvl1);
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsProcessListsShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsProcessListsShow'}{$IFEND}
var
  iPos, i, j, k: Integer;
  MyData: PMyRec;
  iCount, iCount2: uInt32;
  pRoot, pLvl1, pLvl2, pLvl3: PVirtualNode;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vProcessLists do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        unknown1 := Read_float32(TBytes(MyData^._Pointer^), iPos);
        Read_float32_(unknown2, TBytes(MyData^._Pointer^), iPos);
        Read_float32_(unknown3, TBytes(MyData^._Pointer^), iPos);
        Read_uint32_(nextNum, TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
          for i := 0 to 6 do
          begin
            iCount := 0;
            Read_vsval_(iCount, TBytes(MyData^._Pointer^), iPos);
            if iPos > 0 then
            begin
              SetLength(allCrimes[i], iCount);
              for j := 0 to iCount - 1 do
                with allCrimes[i][j] do
                begin
                  Read_uint32_(witnessNum, TBytes(MyData^._Pointer^), iPos);
                  Read_uint32_(crimeType, TBytes(MyData^._Pointer^), iPos);
                  Read_uint8_(unknown1, TBytes(MyData^._Pointer^), iPos);
                  Read_uint32_(quantity, TBytes(MyData^._Pointer^), iPos);
                  Read_uint32_(serialNum, TBytes(MyData^._Pointer^), iPos);
                  Read_uint8_(unknown2, TBytes(MyData^._Pointer^), iPos);
                  Read_uint32_(unknown3, TBytes(MyData^._Pointer^), iPos);
                  Read_float32_(elapsedTime, TBytes(MyData^._Pointer^), iPos);
                  Read_RefID_(victimID, TBytes(MyData^._Pointer^), iPos);
                  Read_RefID_(criminalID, TBytes(MyData^._Pointer^), iPos);
                  Read_RefID_(itemBaseID, TBytes(MyData^._Pointer^), iPos);
                  Read_RefID_(ownershipID, TBytes(MyData^._Pointer^), iPos);
                  iCount2 := 0;
                  Read_vsval_(iCount2, TBytes(MyData^._Pointer^), iPos);
                  if iPos > 0 then
                  begin
                    SetLength(witnesses, iCount2);
                    for k := 0 to iCount2 - 1 do
                      Read_RefID_(witnesses[k], TBytes(MyData^._Pointer^), iPos);
                  end;
                  Read_uint32_(bounty, TBytes(MyData^._Pointer^), iPos);
                  Read_RefID_(crimeFactionID, TBytes(MyData^._Pointer^), iPos);
                  Read_uint8_(isCleared, TBytes(MyData^._Pointer^), iPos);
                  Read_uint16_(unknown4, TBytes(MyData^._Pointer^), iPos);
                end;
            end;
          end;
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vProcessLists do
  begin
    BeginUpdate;
    try
      RootNodeCount := 5;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        if pRoot^.Index = 4 then
          ChildCount[pRoot] := 7;
        Expanded[pRoot] := pRoot^.Index = 4;
        InvalidateToBottom(pRoot);
        pLvl1 := pRoot.FirstChild;
        if Assigned(pLvl1) then
        repeat
          Expanded[pLvl1] := False;
          ChildCount[pLvl1] := Length(allCrimes[pLvl1^.Index]);
          InvalidateToBottom(pLvl1);
          pLvl2 := pLvl1.FirstChild;
          if Assigned(pLvl2) then
          repeat
            Expanded[pLvl2] := False;
            ChildCount[pLvl2] := 17;
            InvalidateToBottom(pLvl2);
            pLvl3 := pLvl2.FirstChild;
            if Assigned(pLvl3) then
            repeat
              Expanded[pLvl3] := False;
              if pLvl3^.Index = 12 then
                ChildCount[pLvl3] := Length(allCrimes[pLvl1^.Index][pLvl2^.Index].witnesses);
              InvalidateToBottom(pLvl3);
              pLvl3 := pLvl3.NextSibling;
            until not Assigned(pLvl3);
            pLvl2 := pLvl2.NextSibling;
          until not Assigned(pLvl2);
          pLvl1 := pLvl1.NextSibling;
        until not Assigned(pLvl1);
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsInterfaceShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsInterfaceShow'}{$IFEND}
var
  iPos, i: Integer;
  MyData: PMyRec;
  iCount: uInt32;
  pRoot, pLvl1: PVirtualNode;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vInterface do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        iCount := Read_uint32(TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(shownHelpMsg, iCount);
          for i := 0 to iCount - 1 do
            Read_uint32_(shownHelpMsg[i], TBytes(MyData^._Pointer^), iPos);
        end;
        Read_uint8_(unknown1, TBytes(MyData^._Pointer^), iPos);
        Read_vsval_(iCount, TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(lastUsedWeapons, iCount);
          for i := 0 to iCount - 1 do
            Read_RefID_(lastUsedWeapons[i], TBytes(MyData^._Pointer^), iPos);
        end;
        Read_vsval_(iCount, TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(lastUsedSpells, iCount);
          for i := 0 to iCount - 1 do
            Read_RefID_(lastUsedSpells[i], TBytes(MyData^._Pointer^), iPos);
        end;
        Read_vsval_(iCount, TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(lastUsedShouts, iCount);
          for i := 0 to iCount - 1 do
            Read_RefID_(lastUsedShouts[i], TBytes(MyData^._Pointer^), iPos);
        end;
        Read_uint8_(unknown2, TBytes(MyData^._Pointer^), iPos);
        if (iPos > 0) and ((MyData^._Size <> iPos) and (iPos > 0)) then
        begin
          iCount := Read_vsval(TBytes(MyData^._Pointer^), iPos);
          if iPos > 0 then
          begin
            SetLength(unknown3, iCount);
            for i := 0 to iCount - 1 do
              with unknown3[i] do
              begin
                Read_wstring_(unknown1, TBytes(MyData^._Pointer^), iPos);
                Read_wstring_(unknown2, TBytes(MyData^._Pointer^), iPos);
                Read_uint32_(unknown3, TBytes(MyData^._Pointer^), iPos);
                Read_uint32_(unknown4, TBytes(MyData^._Pointer^), iPos);
                Read_uint32_(unknown5, TBytes(MyData^._Pointer^), iPos);
                Read_uint32_(unknown6, TBytes(MyData^._Pointer^), iPos);
              end;
          end;
          Read_vsval_(iCount, TBytes(MyData^._Pointer^), iPos);
          if iPos > 0 then
          begin
            SetLength(unknown4, iCount);
            for i := 0 to iCount - 1 do
              Read_wstring_(unknown4[i], TBytes(MyData^._Pointer^), iPos);
          end;
          Read_uint32_(unknown5, TBytes(MyData^._Pointer^), iPos);
        end;
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vInterface do
  begin
    BeginUpdate;
    try
      RootNodeCount := 9;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        case pRoot^.Index of
          0: ChildCount[pRoot] := Length(shownHelpMsg);
          2: ChildCount[pRoot] := Length(lastUsedWeapons);
          3: ChildCount[pRoot] := Length(lastUsedSpells);
          4: ChildCount[pRoot] := Length(lastUsedShouts);
          6: ChildCount[pRoot] := Length(unknown3);
          7: ChildCount[pRoot] := Length(unknown4);
        end;
        Expanded[pRoot] := pRoot^.Index = 0;
        InvalidateToBottom(pRoot);
        pLvl1 := pRoot.FirstChild;
        if Assigned(pLvl1) then
        repeat
          Expanded[pLvl1] := False;
          if pRoot^.Index = 6 then
            ChildCount[pLvl1] := 6;
          InvalidateToBottom(pLvl1);
          pLvl1 := pLvl1.NextSibling;
        until not Assigned(pLvl1);
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsActorCausesShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsActorCausesShow'}{$IFEND}
var
  iPos, i: Integer;
  MyData: PMyRec;
  iCount: uInt32;
  pRoot, pLvl1: PVirtualNode;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vActorCauses do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        iCount := 0;
        nextNum := Read_uint32(TBytes(MyData^._Pointer^), iPos);
        Read_vsval_(iCount, TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(ActorCauses, iCount);
          for i := 0 to iCount - 1 do
            with ActorCauses[i] do
            begin
              Read_float32_(X, TBytes(MyData^._Pointer^), iPos);
              Read_float32_(Y, TBytes(MyData^._Pointer^), iPos);
              Read_float32_(Z, TBytes(MyData^._Pointer^), iPos);
              Read_uint32_(serialNum, TBytes(MyData^._Pointer^), iPos);
              Read_RefID_(actorID, TBytes(MyData^._Pointer^), iPos);
            end;
        end;
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vActorCauses do
  begin
    BeginUpdate;
    try
      RootNodeCount := 2;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        if pRoot^.Index = 1 then
          ChildCount[pRoot] := Length(ActorCauses);
        Expanded[pRoot] := pRoot^.Index = 1;
        InvalidateToBottom(pRoot);
        pLvl1 := pRoot.FirstChild;
        if Assigned(pLvl1) then
        repeat
          Expanded[pLvl1] := False;
          if pRoot^.Index = 1 then
            ChildCount[pLvl1] := 5;
          InvalidateToBottom(pLvl1);
          pLvl1 := pLvl1.NextSibling;
        until not Assigned(pLvl1);
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsDetectionManagerShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsDetectionManagerShow'}{$IFEND}
var
  iPos, i: Integer;
  MyData: PMyRec;
  iCount: uInt32;
  pRoot, pLvl1: PVirtualNode;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vDetectionManager do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        iCount := Read_vsval(TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(Detections, iCount);
          for i := 0 to iCount - 1 do
            with Detections[i] do
            begin
              Read_RefID_(unknown1, TBytes(MyData^._Pointer^), iPos);
              Read_uint32_(unknown2, TBytes(MyData^._Pointer^), iPos);
              Read_uint32_(unknown3, TBytes(MyData^._Pointer^), iPos);
            end;
        end;
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vDetectionManager do
  begin
    BeginUpdate;
    try
      RootNodeCount := 1;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        ChildCount[pRoot] := Length(Detections);
        Expanded[pRoot] := True;
        InvalidateToBottom(pRoot);
        pLvl1 := pRoot.FirstChild;
        if Assigned(pLvl1) then
        repeat
          Expanded[pLvl1] := False;
          if pRoot^.Index = 0 then
            ChildCount[pLvl1] := 3;
          InvalidateToBottom(pLvl1);
          pLvl1 := pLvl1.NextSibling;
        until not Assigned(pLvl1);
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsLocationMetaDataShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsLocationMetaDataShow'}{$IFEND}
var
  iPos, i: Integer;
  MyData: PMyRec;
  iCount: uInt32;
  pRoot, pLvl1: PVirtualNode;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vLocationMetaData do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        iCount := Read_vsval(TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(MetaData, iCount);
          for i := 0 to iCount - 1 do
            with MetaData[i] do
            begin
              Read_RefID_(unknown1, TBytes(MyData^._Pointer^), iPos);
              Read_uint32_(unknown2, TBytes(MyData^._Pointer^), iPos);
            end;
        end;
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vLocationMetaData do
  begin
    BeginUpdate;
    try
      RootNodeCount := 1;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        ChildCount[pRoot] := Length(MetaData);
        Expanded[pRoot] := True;
        InvalidateToBottom(pRoot);
        pLvl1 := pRoot.FirstChild;
        if Assigned(pLvl1) then
        repeat
          Expanded[pLvl1] := False;
          if pRoot^.Index = 0 then
            ChildCount[pLvl1] := 2;
          InvalidateToBottom(pLvl1);
          pLvl1 := pLvl1.NextSibling;
        until not Assigned(pLvl1);
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsMagicFavoritesShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsMagicFavoritesShow'}{$IFEND}
var
  iPos, i: Integer;
  MyData: PMyRec;
  iCount: uInt32;
  pRoot: PVirtualNode;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vMagicFavorites do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        iCount := Read_vsval(TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(favoritedMagics, iCount);
          for i := 0 to iCount - 1 do
            Read_RefID_(favoritedMagics[i], TBytes(MyData^._Pointer^), iPos);
        end;
        Read_vsval_(iCount, TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(magicHotKeys, iCount);
          for i := 0 to iCount - 1 do
            Read_RefID_(magicHotKeys[i], TBytes(MyData^._Pointer^), iPos);
        end;
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vMagicFavorites do
  begin
    BeginUpdate;
    try
      RootNodeCount := 2;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        if pRoot^.Index = 0 then
          ChildCount[pRoot] := Length(favoritedMagics)
        else
          ChildCount[pRoot] := Length(magicHotKeys);
        Expanded[pRoot] := pRoot^.Index = 0;
        InvalidateToBottom(pRoot);
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsIngredientSharedShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsIngredientSharedShow'}{$IFEND}
var
  iPos, i: Integer;
  MyData: PMyRec;
  iCount: uInt32;
  pRoot, pLvl1: PVirtualNode;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vIngredientShared do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        iCount := Read_uint32(TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(IngredientsCombined, iCount);
          for i := 0 to iCount - 1 do
            with IngredientsCombined[i] do
            begin
              Read_RefID_(ingredient1, TBytes(MyData^._Pointer^), iPos);
              Read_RefID_(ingredient2, TBytes(MyData^._Pointer^), iPos);
            end;
        end;
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vIngredientShared do
  begin
    BeginUpdate;
    try
      RootNodeCount := 1;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        ChildCount[pRoot] := Length(IngredientsCombined);
        Expanded[pRoot] := True;
        InvalidateToBottom(pRoot);
        pLvl1 := pRoot.FirstChild;
        if Assigned(pLvl1) then
        repeat
          Expanded[pLvl1] := False;
          if pRoot^.Index = 0 then
            ChildCount[pLvl1] := 2;
          InvalidateToBottom(pLvl1);
          pLvl1 := pLvl1.NextSibling;
        until not Assigned(pLvl1);
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure tsAnimObjectsShow(Handle: THandle; vtTMP, vtStructure: TVirtualStringTree; var BufNode: PVirtualNode);
{$IF Defined(USEREGION)}{$REGION 'tsAnimObjectsShow'}{$IFEND}
var
  iPos, i: Integer;
  MyData: PMyRec;
  iCount: uInt32;
  pRoot, pLvl1: PVirtualNode;
begin
  vtTMP.Clear;
  ClearAll;
  if BufNode <> nil then
    with vAnimObjects do
    begin
      MyData := vtStructure.GetNodeData(BufNode);
      if Assigned(MyData) and (MyData^._Type = btGlobal) and (MyData^._Size > 0) then
      begin
        iPos := 0;
        iCount := Read_uint32(TBytes(MyData^._Pointer^), iPos);
        if iPos > 0 then
        begin
          SetLength(objects, iCount);
          for i := 0 to iCount - 1 do
            with objects[i] do
            begin
              Read_RefID_(achr, TBytes(MyData^._Pointer^), iPos);
              Read_RefID_(anim, TBytes(MyData^._Pointer^), iPos);
              Read_uint8_(unk1, TBytes(MyData^._Pointer^), iPos);
            end;
        end;
        if iPos = 0 then
          MessageBox(Handle, 'Input buffer size in not enough!', 'Error', MB_OK or MB_ICONSTOP);
        if (MyData^._Size <> iPos) and (iPos > 0) then
          MessageBox(Handle, 'Not all data are parsed', 'Warning', MB_OK or MB_ICONWARNING);
      end;
    end;
  BufNode := nil;
  with vtTMP, vAnimObjects do
  begin
    BeginUpdate;
    try
      RootNodeCount := 1;
      pRoot := GetFirst(False);
      if Assigned(pRoot) then
      repeat
        ChildCount[pRoot] := Length(objects);
        Expanded[pRoot] := True;
        InvalidateToBottom(pRoot);
        pLvl1 := pRoot.FirstChild;
        if Assigned(pLvl1) then
        repeat
          Expanded[pLvl1] := False;
          if pRoot^.Index = 0 then
            ChildCount[pLvl1] := 3;
          InvalidateToBottom(pLvl1);
          pLvl1 := pLvl1.NextSibling;
        until not Assigned(pLvl1);
        pRoot := pRoot.NextSibling;
      until not Assigned(pRoot);
    finally
      EndUpdate;
    end;
  end;
end; {$IF Defined(USEREGION)}{$ENDREGION}{$IFEND}

procedure ClearAll;
begin
  ClearTES;
  ClearCreatedObjects;
  ClearEffects;
  CleartProcessLists;
  ClearInterface;
  ClearActorCauses;
  ClearDetectionManager;
  ClearLocationMetaData;
  ClearMagicFavorites;
  ClearIngredientShared;
  ClearAnimObjects;
  ClearAudio;
  ClearSkyCells;
end;

initialization

finalization
  ClearAll;

end.
