{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbDefinitionsFO4Saves;

interface

procedure DefineFO4Saves;
procedure SwitchToFO4CoSave;

implementation

uses
  Types,
  Classes,
  SysUtils,
  Math,
  Variants,
  wbInterface,
  wbSaveInterface,
  wbImplementation,
  wbLocalization,
  wbDefinitionsCommon,
  wbDefinitionsFO4;

var
  wbExtraTypeEnum    : IwbEnumDef;
  wbCodeTypeEnum     : IwbEnumDef;
  wbRecordFlagsFlags : IwbFlagsDef;

var // forward type directives
  wbChangeTypes    : IwbEnumDef;
  wbQuestFlags     : IwbIntegerDef;
  wbSaveChapters   : IwbStructDef;
  wbCoSaveChapters : IwbStructDef;
  wbSaveHeader     : IwbStructDef;
  wbCoSaveHeader   : IwbStructDef;

procedure DefineFO4SavesA;
begin
  wbRecordFlagsFlags := wbFlags([
    {>>> 0x00000000 ACTI: Collision Geometry (default) <<<}
    {0x00000001}'ESM',
    {0x00000002}'Unknown 2',
    {>>> 0x00000004 ARMO: Not playable <<<}
    {0x00000004}'NotPlayable',
    {0x00000008}'Unknown 4',
    {0x00000010}'Unknown 5',
    {0x00000020}'Deleted',
    {>>> 0x00000040 ACTI: Has Tree LOD <<<}
    {>>> 0x00000040 REGN: Border Region <<<}
    {>>> 0x00000040 STAT: Has Tree LOD <<<}
    {>>> 0x00000040 REFR: Hidden From Local Map <<<}
    {0x00000040}'Constant HiddenFromLocalMap BorderRegion HasTreeLOD',
    {>>> 0x00000080 TES4: Localized <<<}
    {>>> 0x00000080 PHZD: Turn Off Fire <<<}
    {>>> 0x00000080 SHOU: Treat Spells as Powers <<<}
    {>>> 0x00000080 STAT: Add-on LOD Object <<<}
    {0x00000080}'Localized IsPerch AddOnLODObject TurnOffFire TreatSpellsAsPowers',
    {>>> 0x00000100 ACTI: Must Update Anims <<<}
    {>>> 0x00000100 REFR: Inaccessible <<<}
    {>>> 0x00000100 REFR for LIGH: Doesn't light water <<<}
    {0x00000100}'MustUpdateAnims Inaccessible DoesntLightWater',
    {>>> 0x00000200 ACTI: Local Map - Turns Flag Off, therefore it is Hidden <<<}
    {>>> 0x00000200 REFR: MotionBlurCastsShadows <<<}
    {0x00000200}'HiddenFromLocalMap StartsDead MotionBlurCastsShadows',
    {>>> 0x00000400 LSCR: Displays in Main Menu <<<}
    {0x00000400}'PersistentReference QuestItem DisplaysInMainMenu',
    {0x00000800}'InitiallyDisabled',
    {0x00001000}'Ignored',
    {0x00002000}'Unknown 14',
    {0x00004000}'Unknown 15',
    {>>> 0x00008000 STAT: Has Distant LOD <<<}
    {0x00008000}'VWD',
    {>>> 0x00010000 ACTI: Random Animation Start <<<}
    {>>> 0x00010000 REFR light: Never fades <<<}
    {0x00010000}'RandomAnimationStart NeverFades',
    {>>> 0x00020000 ACTI: Dangerous <<<}
    {>>> 0x00020000 REFR light: Doesn't light landscape <<<}
    {>>> 0x00020000 SLGM: Can hold NPC's soul <<<}
    {>>> 0x00020000 STAT: Use High-Detail LOD Texture <<<}
    {0x00020000}'Dangerous OffLimits DoesntLightLandscape HighDetailLOD CanHoldNPC',
    {0x00040000}'Compressed',
    {>>> 0x00080000 STAT: Has Currents <<<}
    {0x00080000}'CantWait HasCurrents',
    {>>> 0x00100000 ACTI: Ignore Object Interaction <<<}
    {0x00100000}'IgnoreObjectInteraction',
    {0x00200000}'Used by In Memory Changed Form',
    {0x00400000}'Unknown 23',
    {>>> 0x00800000 ACTI: Is Marker <<<}
    {0x00800000}'IsMarker',
    {0x01000000}'Unknown 25', // Initialized to (REFR.Destructible.unk004 is not null)
    {>>> 0x02000000 ACTI: Obstacle <<<}
    {>>> 0x02000000 REFR: No AI Acquire <<<}
    {0x02000000}'Obstacle NoAIAcquire',
    {>>> 0x04000000 ACTI: Filter <<<}
    {0x04000000}'NavMeshFilter',
    {>>> 0x08000000 ACTI: Bounding Box <<<}
    {0x08000000}'NavMeshBoundingBox',
    {>>> 0x10000000 STAT: Show in World Map <<<}
    {0x10000000}'MustExitToTalk ShowInWorldMap',
    {>>> 0x20000000 ACTI: Child Can Use <<<}
    {>>> 0x20000000 REFR: Don't Havok Settle <<<}
    {0x20000000}'ChildCanUse DontHavokSettle',
    {>>> 0x40000000 ACTI: GROUND <<<}
    {>>> 0x40000000 REFR: NoRespawn <<<}
    {0x40000000}'NavMeshGround NoRespawn',
    {>>> 0x80000000 REFR: MultiBound <<<}
    {0x80000000}'MultiBound'
  ]);

  wbQuestFlags := wbInteger('Flags', itU16, wbFlags([
    {0x0001} 'Start Game Enabled',
    {0x0002} 'Unknown 2',
    {0x0004} 'Unknown 3',
    {0x0008} 'Allow repeated stages',
    {0x0010} 'Unknown 5',
    {0x0020} 'Unknown 6',
    {0x0040} 'Unknown 7',
    {0x0080} 'Unknown 8',
    {0x0100} 'Run Once',
    {0x0200} 'Exclude from dialogue export',
    {0x0400} 'Warn on alias fill failure',
    {0x0800} 'Unknown 12',
    {0x1000} 'Unknown 13'
  ]));

  wbExtraTypeEnum := wbEnum([
    'Havok',
    'Cell3D',
    'CellWaterType',
    'RegionList',
    'SeenData',
    'EditorID',
    'CellMusicType',
    'CellSkyRegion',
    'ProcessMiddleLow',
    'DetachTime',
    'PersistentCell',
    'Unknown12',
    'Action',
    'StartingPosition',
    'Unknown15',
    'AnimGraphManager',
    'Unknown17',
    'UsedMarkers',
    'DistantData',
    'RagDollData',
    'ContainerChanges',
    'Worn',
    'WornLeft',
    'PackageStartLocation',
    'Package',
    'TresPassPackage',
    'RunOncePacks',
    'ReferenceHandle',
    'Follower',
    'LevCreaModifier',
    'Ghost',
    'OriginalReference',
    'Ownership',
    'Global',
    'Rank',
    'Count',
    'Health',
    'Unknown38',
    'TimeLeft',
    'Charge',
    'Light',
    'Lock',
    'Teleport',
    'MapMarker',
    'LeveledCreature',
    'LeveledItem',
    'Scale',
    'Seed',
    'MagicCaster',
    'Unknown50',
    'Unknown51',
    'PlayerCrimeList',
    'Unknown53',
    'EnableStateParent',
    'EnableStateChildren',
    'ItemDropper',
    'DroppedItemList',
    'RandomTeleportMarker',
    'Unknown59',
    'SavedHavokData',
    'CannotWear',
    'Poison',
    'Unknown63',
    'LastFinishedSequence',
    'SavedAnimation',
    'NorthRotation',
    'SpawnContainer',
    'FriendHits',
    'HeadingTarget',
    'Unknown70',
    'RefractionProperty',
    'StartingWorldOrCell',
    'Hotkey',
    'Unknown74',
    'EditiorRefMoveData',
    'InfoGeneralTopic',
    'HasNoRumors',
    'Sound',
    'TerminalState',
    'LinkedRef',
    'LinkedRefChildren',
    'ActivateRef',
    'ActivateRefChildren',
    'CanTalkToPlayer',
    'ObjectHealth',
    'CellImageSpace',
    'NavMeshPortal',
    'ModelSwap',
    'Radius',
    'Unknown90',
    'FactionChanges',
    'DismemberedLimbs',
    'ActorCause',
    'MultiBound',
    'MultiBoundData',
    'MultiBoundRef',
    'ReflectedRefs',
    'ReflectorRefs',
    'EmittanceSource',
    'RadioData',
    'CombatStyle',
    'Unknown102',
    'Primitive',
    'OpenCloseActivateRef',
    'AnimNoteReceiver',
    'Ammo',
    'PatrolRefData',
    'PackageData',
    'OcclusionShape',
    'CollisionData',
    'SayTopicInfoOnceADay',
    'EncounterZone',
    'SayTopicInfo',
    'OcclusionPlaneRefData',
    'PortalRefData',
    'Portal',
    'Room',
    'HealthPerc',
    'RoomRefData',
    'GuardedRefData',
    'CreatureAwakeSound',
    'Unknown122',
    'Horse',
    'IgnoredBySandbox',
    'CellAcousticSpace',
    'ReservedMarkers',
    'WeaponIdleSound',
    'WaterLightRefs',
    'LitWaterRefs',
    'WeaponAttackSound',
    'ActivateLoopSound',
    'PatrolRefInUseData',
    'AshPileRef',
    'Unknown134',
    'FollowerSwimBreadcrumbs',
    'AliasInstanceArray',
    'Location',
    'Unknown138',
    'LocationRefType',
    'PromotedRef',
    'Unknown141',
    'OutfitItem',
    'Unknown143',
    'LeveledItemBase',
    'LightData',
    'SceneData',
    'BadPosition',
    'HeadTrackingWeight',
    'FromAlias',
    'ShouldWear',
    'FavorCost',
    'AttachedArrows3D',
    'TextDisplayData',
    'AlphaCutoff',
    'Enchantment',
    'Soul',
    'ForcedTarget',
    'Unknown158',
    'UniqueID',
    'Flags',
    'RefrPath',
    'DecalGroup',
    'LockList',
    'ForcedLandingMarker',
    'LargeRefOwnerCells',
    'CellWaterEnvMap',
    'CellGrassData',
    'TeleportName',
    'Interaction',
    'WaterData',
    'WaterCurrentZoneData',
    'AttachRef',
    'AttachRefChildren',
    'GroupConstraint',
    'ScriptedAnimDependence',
    'CachedScale',
    'RaceData',
    'GIDBuffer',
    'MissingRefIDs'
  ]);
end;

{ TES5saves }

function SaveVersionDecider(aMinimum: Integer; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := aElement;
  while Assigned(Element.Container) do
    Element := Element.Container;

  if Supports(Element, IwbContainer, Container) then begin
    Element := Container.ElementByPath['Save File Header\Header\Version'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      if aType>aMinimum then
        Result := 1;
    end;
  end;
end;

function SaveVersionGreaterThan14Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
    Result := SaveVersionDecider(14, aBasePtr, aEndPtr, aElement);
end;

function SaveFormVersionDecider(aMinimum: Integer; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := aElement;
  while Assigned(Element.Container) do
    Element := Element.Container;

  if Supports(Element, IwbContainer, Container) then begin
    Element := Container.ElementByPath['Save File Header\Form Version'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      if aType>aMinimum then
        Result := 1;
    end;
  end;
end;

function SaveFormVersion55Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := aElement;
  while Assigned(Element.Container) do
    Element := Element.Container;

  if Supports(Element, IwbContainer, Container) then begin
    Element := Container.ElementByPath['Save File Header\Form Version'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      if aType = 55 then
        Result := 1;
    end;
  end;
end;

// Seen version checked so far 10, 36*, 55, 64, 73* and 74

function SaveFormVersionGreaterThan10Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
    Result := SaveFormVersionDecider(10, aBasePtr, aEndPtr, aElement);
end;

function SaveFormVersionGreaterThan35Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
    Result := SaveFormVersionDecider(36, aBasePtr, aEndPtr, aElement);
end;

function SaveFormVersionGreaterThan72Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
    Result := SaveFormVersionDecider(73, aBasePtr, aEndPtr, aElement);
end;

function GlobalData6FlagsBit0Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Weather', aElement);
  Assert(Element.BaseName = 'Weather');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Flags'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      if (Element.NativeValue and $1) = $1 then
        Result := 1;
    end;
  end;
end;

function GlobalData6FlagsBit1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Weather', aElement);
  Assert(Element.BaseName = 'Weather');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Flags'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      if (Element.NativeValue and $2) = $2 then
        Result := 1;
    end;
  end;
end;

function wbGlobalData6OwnedControllerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Reference Effect', aElement);
  Assert(Element.BaseName = 'Reference Effect');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Owned Controller Type'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      case Element.NativeValue of
        1: Result := 1;
        2: Result := 2;
      end;
    end;
  end;
end;

function wbBSTempEffectScreenSpaceDecalSixDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Temp Effect Screen Space Decal', aElement);
  Assert(Element.BaseName = 'Temp Effect Screen Space Decal');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Flag'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      if Element.NativeValue <> 0 then
        Result := 1;
    end;
  end;
end;

function wbBSTempEffectScreenSpaceDecalRemainDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Reference Effect', aElement);
  Assert(Element.BaseName = 'Reference Effect');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Flag2'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      if Element.NativeValue <> 0 then
        Result := 1;
    end;
  end;
end;

function wbBSTempEffectScreenSpaceDecalThirdDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Remain', aElement);
  Assert(Element.BaseName = 'Remain');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Flag3'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      if Element.NativeValue <> 0 then
        Result := 1;
    end;
  end;
end;

function wbGlobalData1000FlagDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Unknown 02 struct', aElement);
  Assert(Element.BaseName = 'Unknown 02 struct');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Flag'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      if Element.NativeValue <> 0 then
        Result := 1;
    end;
  end;
end;

function wbSubBufferCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('SubBuffer', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Length'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function wbGlobalData10TypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Unknown struct', aElement);
  Assert(Element.BaseName = 'Unknown struct');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      if aType < 5 then
        Result := 1 + aType;
    end;
  end;
end;

function ScreenShotDataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := aElement;
  while Assigned(Element.Container) do
    Element := Element.Container;

  if Supports(Element, IwbContainer, Container) then begin
    Element := Container.ElementByPath['Save File Header\Header\Screenshot Width'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
      Element := Container.ElementByPath['Save File Header\Header\Screenshot Height'];
      if Assigned(Element) then begin
        Result := 4 * Result * Element.NativeValue;
      end;
    end;
  end;
end;

function FileLocationTableCountCounter(aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := aElement;
  while Assigned(Element.Container) do
    Element := Element.Container;

  if Supports(Element, IwbContainer, Container) then begin
    Element := Container.ElementByPath['Save File Header\File Location Table\'+aName+' Count'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function GlobalDataCounter(aIndex: Integer; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := FileLocationTableCountCounter('Global Data Table '+IntToStr(aIndex), aBasePtr, aEndPtr, aElement);
end;

function GlobalData1Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := GlobalDataCounter(1, aBasePtr, aEndPtr, aElement);
end;

function GlobalData2Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := GlobalDataCounter(2, aBasePtr, aEndPtr, aElement);
end;

function GlobalData3Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := GlobalDataCounter(3, aBasePtr, aEndPtr, aElement);
end;

function ChangedFormsCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := FileLocationTableCountCounter('Changed Forms', aBasePtr, aEndPtr, aElement);
end;

function GlobalDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;

  if not Assigned(aElement) then Exit;
  Element := aElement;
  while (Pos('Global Data ', Element.Name)=0) and Assigned(Element.Container) do
    Element := Element.Container;

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      if (aType >= 0) and (aType <= 11) then // 0 to 11 = 12
        Result := aType + 1
      else if (aType >= 100) and (aType <= 117) then  // 100 to 117 = 18
        Result := aType - 100 + 12 + 1
      else  if (aType >= 1000) and (aType <= 1008) then // 1000 to 1007 = 8
        Result := aType - 1000 + 12 + 18 + 1;
    end;
//    if (aType > 100) and (aType < 1000) then Result := 0; //Others are not decoded yet
    if Assigned(ChaptersToSkip) and ChaptersToSkip.Find(IntToStr(aType), aType)  then // "Required" time optimisation (can save "hours" if used on 1001)
      Result := 0;
  end;
end;

function ArrayTableEntryOptionalStringDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Array Entry Data', aElement);
  Assert(Element.BaseName = 'Array Entry Data');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Array Type'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      case aType of
        1, 7: Result := 2;
      else
        Result := 1;
      end;
    end;
  end;
end;

var
  VMTypeCount : Integer = -1;

procedure VMTypeAfterLoad(const aElement: IwbElement);
begin
  if VMTypeCount < 0 then begin
    VMTypeCount := (aElement as IwbContainer).ElementCount;
    InitializeVMTypeArray(aElement as IwbContainer);
  end;
end;

var
  WorldspaceTableCount : Integer = -1;

procedure WorldspaceTableAfterLoad(const aElement: IwbElement);
begin
  if WorldspaceTableCount < 0 then begin
    WorldspaceTableCount := (aElement as IwbContainer).ElementCount;
    InitializeSaveWorldspaceArray(aElement as IwbContainer);
  end;
end;

var
  RefIDTableCount : Integer = -1;

procedure RefIDTableAfterLoad(const aElement: IwbElement);
begin
  if RefIDTableCount < 0 then begin
    RefIDTableCount := (aElement as IwbContainer).ElementCount;
    InitializeSaveRefIDArray(aElement as IwbContainer);
  end;
end;

var
  VMObjectArrayCount           : Integer = -1;
  VMSupplementObjectArrayCount : Integer = -1;
  VMObjectDetachedArrayCount   : Integer = -1;

procedure ObjectTableAfterLoad(const aElement: IwbElement);
begin
  if VMObjectArrayCount < 0 then begin
    VMObjectArrayCount := (aElement as IwbContainer).ElementCount;
    InitializeVMObjectArray(aElement as IwbContainer);
  end;
end;

procedure SupplementObjectTableAfterLoad(const aElement: IwbElement);
begin
  if VMSupplementObjectArrayCount < 0 then begin
    VMSupplementObjectArrayCount := (aElement as IwbContainer).ElementCount;
    InitializeVMObjectArray(aElement as IwbContainer);
    if VMObjectArrayCount >= 0 then
      VMObjectArrayCount := VMObjectArrayCount + VMSupplementObjectArrayCount;
  end;
end;

procedure ObjectDetachedTableAfterLoad(const aElement: IwbElement);
begin
  if VMObjectDetachedArrayCount < 0 then begin
    VMObjectDetachedArrayCount := (aElement as IwbContainer).ElementCount;
    InitializeVMObjectDetachedArray(aElement as IwbContainer);
  end;
end;

var
  VMArrayTableCount : Integer = -1;

procedure ArrayTableAfterLoad(const aElement: IwbElement);
begin
  if VMArrayTableCount < 0 then begin
    VMArrayTableCount := (aElement as IwbContainer).ElementCount;
    InitializeVMArrayTable(aElement as IwbContainer);
  end;
end;

function VariableDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Variable', aElement);
  Assert(Element.BaseName='Variable');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      case aType of
         1: Result := 1;
         2: Result := 2;
         3: Result := 3;
         4: Result := 4;
         5: Result := 5;
         6: Result := 6;
         7: Result := 7;
        11: Result := 8;
        12: Result := 9;
        13: Result := 10;
        14: Result := 11;
        15: Result := 12;
        16: Result := 13;
        17: Result := 14;
      end;
    end;
  end;
end;

function ArrayElementsTableValueDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Element', aElement);
  Assert(Element.BaseName = 'Element');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      case aType of
         1: Result := 1;
         2: Result := 2;
         3: Result := 3;
         4: Result := 4;
         5: Result := 5;
        11: Result := 6;
        12: Result := 7;
        13: Result := 8;
        14: Result := 9;
        15: Result := 10;
      end;
    end;
  end;
end;

var
  StackTableCount : Integer = -1;

procedure StackTableAfterLoad(const aElement: IwbElement);
begin
  if StackTableCount < 0 then begin
    StackTableCount := (aElement as IwbContainer).ElementCount;
  end;
end;

function StackDataTableValueDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Stack', aElement);
  Assert(Element.BaseName='Stack');

  if Supports(Element, IwbDataContainer, Container) and (Element.Name = 'Element') then begin
    Element := Container.ElementByName['Type'];
    Assert(Assigned(Element));
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      case aType of
         1: Result := 1;
         2: Result := 2;
         3: Result := 3;
         4: Result := 4;
         5: Result := 5;
        11: Result := 6;
        12: Result := 7;
        13: Result := 8;
        14: Result := 9;
        15: Result := 10;
      end;
    end;
  end;
end;

function TypeTable2Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  sElement  : IwbElement;
  Element   : IwbElement;
  Container : IwbDataContainer;

begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  sElement := wbFindSaveElement('Type tables for internal VM save data', aElement);
  Assert(sElement.BaseName='Type tables for internal VM save data');

  if Supports(sElement, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type table 2 Count'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function TypeTable1Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  sElement  : IwbElement;
  Element   : IwbElement;
  Container : IwbDataContainer;

begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  sElement := wbFindSaveElement('Type tables for internal VM save data', aElement);
  Assert(sElement.BaseName='Type tables for internal VM save data');

  if Supports(sElement, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type table 1 Count'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function ObjectTableDataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  sElement  : IwbElement;
  Element   : IwbElement;
  Container : IwbDataContainer;

begin
  if VMObjectArrayCount<0 then begin
    Result := 0;
    if not Assigned(aElement) then Exit;
    sElement := wbFindSaveElement('Papyrus Struct', aElement);
    Assert(sElement.BaseName='Papyrus Struct');

    if Supports(sElement, IwbDataContainer, Container) then begin
      Element := Container.ElementByName['Object Table'];
      if Supports(Element, IwbDataContainer, Container) then
        Result := Container.ElementCount;
    end;
  end else
    Result := VMObjectArrayCount;
end;

function DetachedObjectTableDataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  sElement  : IwbElement;
  Element   : IwbElement;
  Container : IwbDataContainer;

begin
  if VMObjectDetachedArrayCount<0 then begin
    Result := 0;
    if not Assigned(aElement) then Exit;
    sElement := wbFindSaveElement('Papyrus Struct', aElement);
    Assert(sElement.BaseName='Papyrus Struct');

    if Supports(sElement, IwbDataContainer, Container) then begin
      Element := Container.ElementByName['Detached Object Table'];
      if Supports(Element, IwbDataContainer, Container) then
        Result := Container.ElementCount;
    end;
  end else
    Result := VMObjectDetachedArrayCount;
end;

function ArrayContentTableCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element   : IwbElement;
  Container : IwbDataContainer;

begin
  if VMArrayTableCount<0 then begin
    Result := 0;
    if not Assigned(aElement) then Exit;
    Element := wbFindSaveElement('Papyrus Struct', aElement);
    Assert(Element.BaseName='Papyrus Struct');

    if Supports(Element, IwbDataContainer, Container) then begin
      Element := Container.ElementByName['Array Table'];
      if Supports(Element, IwbDataContainer, Container) then
        Result := Container.ElementCount;
    end
  end else
    Result := VMArrayTableCount;
end;

function StackContentTableCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element   : IwbElement;
  Container : IwbDataContainer;

begin
  if StackTableCount<0 then begin
    Result := 0;
    if not Assigned(aElement) then Exit;
    Element := wbFindSaveElement('Papyrus Struct', aElement);
    Assert(Element.BaseName='Papyrus Struct');

    if Supports(Element, IwbDataContainer, Container) then begin
      Element := Container.ElementByPath['Stacks\Stack Table'];
      if Supports(Element, IwbDataContainer, Container) then
        Result := Container.ElementCount;
    end
  end else
    Result := StackTableCount;
end;

const
  ArrayContentEntryData = 'Array Content Entry Data';

function ArrayElementsTableElementCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element       : IwbElement;
  Container     : IwbDataContainer;
  DataContainer : IwbDataContainer;
  Handle        : Int64;
  i             : Integer;
begin
  Result := 0;
  Handle := 0;
  if not Assigned(aElement) then Exit;

  Element := wbFindSaveElement(ArrayContentEntryData, aElement);
  Assert(Element.BaseName=ArrayContentEntryData);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Array Handle'];
    if Assigned(Element) then
      Handle := Element.NativeValue
    else
      Exit;
  end;

  if VMArrayTableCount<0 then begin
    Element := wbFindSaveElement('Papyrus Struct', aElement);
    Assert(Element.BaseName='Papyrus Struct');

    if Supports(Element, IwbDataContainer, Container) then begin
      Element := Container.ElementByName['Array Table'];
      if Supports(Element, IwbDataContainer, Container) then
        for i := 0 to Pred(Container.ElementCount) do
          if Supports(Container.Elements[i], IwbDataContainer, DataContainer) then
            if DataContainer.ElementByName['Array Handle'].NativeValue = Handle then begin
              Result := DataContainer.ElementByName['Count'].NativeValue;
              Break;
            end;
    end;
  end else
    Result := QueryCountForVMArrayHandle(Handle);
end;

function ObjectDataTableEntryExtraDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aFlags    : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Script', aElement);
  Assert(Element.BaseName='Script');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Unknown Flags'];
    if Assigned(Element) then begin
      aFlags := Element.NativeValue;
      case (aFlags and $4) of
        4: Result := 1;
      else
        Result := 0;
      end;
    end;
  end;
end;

function GroupedDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Grouped', aElement);
  Assert(Element.BaseName='Grouped');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Flag2bits'];
    if Assigned(Element) then begin
      if Element.NativeValue = 3 then
        Result := 1;
    end;
  end;
end;

function CodeParameterTypeValueDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Parameter', aElement);
  Assert(Element.BaseName='Parameter');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      Result := aType;
    end;
  end;
end;

function OpcodeVariableParameterDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
  anOpcode  : Integer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Code', aElement);
  Assert(Element.BaseName='Code');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Opcode'];
    if Assigned(Element) then begin
      anOpcode := Element.NativeValue;
      if anOpcode in [23, 24, 25] then
        Result := 1;
    end;
  end;
end;

function OpcodeParameterCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
  anOpcode  : Integer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Code', aElement);
  Assert(Element.BaseName='Code');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Opcode'];
    if Assigned(Element) then begin
      anOpcode := Element.NativeValue;
      case anOpcode of
        000: Result := 0;
        010,
        011,
        012,
        013,
        014: Result := 2;
        020: Result := 1;
        021,
        022,
        024: Result := 2;
        026: Result := 1;
        030,
        031: Result := 2;
        034,
        035: Result := 4;
        037: Result := 1;
        040,
        041: Result := 5;
        044,
        046: Result := 1;
      else
        Result := 3;
      end;
    end;
  end;
end;

function FrameExtraVariablesCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Frame', aElement);
  Assert(Element.BaseName='Frame');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Extra Variables'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function StackTableDataEntryStackExtraDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aFlags    : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Stack', aElement);
  Assert(Element.BaseName='Stack');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Extra Flag'];
    if Assigned(Element) then begin
      aFlags := Element.NativeValue;
      if (aFlags and $1)= 1 then
        Result := 1
      else if (aFlags and $2)= 2 then
        Result := 2
      else
        Result := 0;
    end;
  end;
end;

function StackCallBackTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : String;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Callback', aElement);
  Assert(Element.BaseName='Callback');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      if SameText(aType, 'TopicInfo') then
        Result := 0 // no parameters
      else if SameText(aType, 'QuestStage') then
        Result := 1
      else if SameText(aType, 'ScenePhaseResults') then
        Result := 2
      else if SameText(aType, 'SceneActionResults') then
        Result := 2
      else if SameText(aType, 'SceneResults') then
        Result := 3
      else
        Assert(False);
    end;
  end;
end;

function StackTableDataEntryStackTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('CallBacks', aElement);
  Assert(Element.BaseName='CallBacks');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      case aType of
        1: Result := 1;
        2: Result := 2;
//        3: Result := 3;
      else
        Result := 0;
      end;
    end;
  end;
end;

function wbCallbackTypeDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aTypeName : String;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('CallBack', aElement);
//  Assert(Element.BaseName='CallBack');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      aTypeName := Element.NativeValue;
      if SameStr(aTypeName, 'QuestStage') then
        Result := 1
      else
      if SameStr(aTypeName, 'SceneResults') then
        Result := 2
      else
      if SameStr(aTypeName, 'SceneActionResults') then
        Result := 3
      else
      if SameStr(aTypeName, 'ScenePhaseResults') then
        Result := 4;
    end;
  end;
end;

function VMVersionDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aVersion  : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Papyrus Struct', aElement);
  Assert(Element.BaseName='Papyrus Struct');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['VM_version'];
    if Assigned(Element) then begin
      aVersion := Element.NativeValue;
      case aVersion of
        1: Result := 1;
        2: Result := 2;
      else
        Result := 0;
      end;
    end;
  end;
end;

function VMVersionGreaterThan1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
  if VMVersionDecider(aBasePtr, aEndPtr, aElement) > 1 then
    Result := 1;
end;

function SaveFileVersionDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Papyrus Struct', aElement);
  Assert(Element.BaseName='Papyrus Struct');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Save File Version'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function SaveFileVersionGreaterThanDDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
  if SaveFileVersionDecider(aBasePtr, aEndPtr, aElement) > $D then
    Result := 1;
end;

function SaveFileVersionGreaterThanBDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
  if SaveFileVersionDecider(aBasePtr, aEndPtr, aElement) > $B then
    Result := 1;
end;

function wbGlobalData1002BooleanDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Anim Object', aElement);
  Assert(Element.BaseName='Anim Object');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Boolean'];
    if Assigned(Element) then begin
      if Element.NativeValue <> 0 then
        Result := 1;
    end;
  end;
end;

function SaveIsValidDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aVersion  : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Papyrus Struct', aElement);
  Assert(Element.BaseName='Papyrus Struct');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Save File Version'];
    if Assigned(Element) then begin
      aVersion := Element.NativeValue;
      if (0 <= aVersion) and (aVersion <= $E) then
        Result := 1;
    end;
  end;
end;

function VersionGreaterThan1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aVersion  : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Papyrus Struct', aElement);
  Assert(Element.BaseName='Papyrus Struct');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Save File Version'];
    if Assigned(Element) then begin
      aVersion :=Element.NativeValue;
      if (1 < aVersion) then
        Result := 1;
    end;
  end;
end;

function VersionGreaterThan3Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aVersion  : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Papyrus Struct', aElement);
  Assert(Element.BaseName='Papyrus Struct');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Save File Version'];
    if Assigned(Element) then begin
      aVersion :=Element.NativeValue;
      if (3 < aVersion) then
        Result := 1;
    end;
  end;
end;

function VersionGreaterThan4Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aVersion  : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Papyrus Struct', aElement);
  Assert(Element.BaseName='Papyrus Struct');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Save File Version'];
    if Assigned(Element) then begin
      aVersion :=Element.NativeValue;
      if (4 < aVersion) then
        Result := 1;
    end;
  end;
end;

function FunctionTypeAndFlagsDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aValue    : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  aValue := VMversionDecider(aBasePtr, aEndPtr, aElement);
  if aValue >1 then begin
    Element := wbFindSaveElement('Frame Data', aElement);
    Assert(Element.BaseName='Frame Data');

    if Supports(Element, IwbDataContainer, Container) then begin
      Element := Container.ElementByName['Flags'];
      if Assigned(Element) then begin
        aValue := Element.NativeValue;
        if (aValue and $1) = 0 then begin
          Element := Container.ElementByName['Function Type'];
          if Assigned(Element) then begin
            aValue := Element.NativeValue;
            if aValue = 0 then
              Result := 1;
          end;
        end;
      end;
    end;
  end else
    Result := 1;
end;

function HasUnknownS1Decider(aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement(aName, aElement);
  Assert(Element.BaseName=aName);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has UnknownS1'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function HasFunctionUnknownS1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := HasUnknownS1Decider('Function Call/Return Message', aBasePtr, aEndPtr, aElement);
end;

function HasStackUnknownS1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := HasUnknownS1Decider('Suspended Stack', aBasePtr, aEndPtr, aElement);
end;

function PreviousUnknownDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Tables', aElement);
  Assert(Element.BaseName='Tables');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Previous Unknown'];
    if Assigned(Element) then
      if Element.NativeValue > 0 then
        Result := 1;
  end;
end;

function wbLOSEventDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('LOS event', aElement);
  Assert(Element.BaseName='LOS event');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then
      if Element.NativeValue = 0 then
        Result := 1
      else if Element.NativeValue = 1 then
        Result := 2
  end;
end;

function FunctorDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aValue    : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Functor', aElement);
  Assert(Element.BaseName='Functor');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      aValue := Element.NativeValue;
      if (aValue >= 0) or (aValue<25) then
        Result := aValue+1;
    end;
  end;
end;

function FirstCountCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Dual RefID Table', aElement);
  Assert(Element.BaseName='Dual RefID Table');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['First Count'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function SecondCountCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Dual RefID Table', aElement);
  Assert(Element.BaseName='Dual RefID Table');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Second Count'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

//function Data6Key2Counter(aParent, aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
//var
//  Element : IwbElement;
//  Container: IwbDataContainer;
//begin
//  Result := 0;
//  if not Assigned(aElement) then Exit;
//  Element := wbFindSaveElement(aParent, aElement);
//  Assert(Element.BaseName=aParent);
//
//  if Supports(Element, IwbDataContainer, Container) then begin
//    Element := Container.ElementByName[aName];
//    if Assigned(Element) then
//      Result := Element.NativeValue;
//  end;
//end;

function Unknown1000_00001Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aValue : Integer;
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Unknown1000_0000', aElement);
  Assert(Element.BaseName='Unknown1000_0000');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Unknown1000_00000'];
    if Assigned(Element) then begin
      aValue := Element.NativeValue;
      case aValue of
        0: Result := 0;
      else
        Result := 1;
      end;
    end;
  end;
end;

function GlobalDataGetChapterType(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element    : IwbElement;
  Container : IwbContainer;
begin
  Result := -1;
  if Supports(aElement, IwbContainer, Container) then
    Element := Container.ElementByName['Type'];
  if Assigned(Element) then
    Result := Element.NativeValue;
end;

function GlobalDataGetChapterTypeName(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): String;
var
  Element    : IwbElement;
  Container : IwbContainer;
begin
  if Supports(aElement, IwbContainer, Container) then
    Element :=  Container.ElementByPath['Type'];
  if Assigned(aElement) then
    begin
      Result := Element.Value;
      if (Pos(' ', Result)>0) and (Length(Result)>1) then
        Result := Copy(Result, Pos(' ', Result)+1, Length(Result));
      if (Pos(' ', Result)>0) and (Length(Result)>1) then
        Result := Copy(Result, 1, Pos(' ', Result)-1);
    end
  else
    Result := IntToStr(GlobalDataGetChapterType(aBasePtr, aEndPtr, aElement));
end;

function ChangedFormGetRawType(var aElement: IwbElement): Integer;
const
  OffsetType = 7;
var
  Container : IwbDataContainer;
  BasePtr   : Pointer;
begin
  Result := -1;
  if not Assigned(aElement) then Exit;
  aElement := wbFindSaveElement('Changed Form', aElement);
  Assert(aElement.BaseName='Changed Form');

  if Supports(aElement, IwbDataContainer, Container) then begin
    with Container do if IsValidOffset(DataBasePtr, DataEndPtr, OffsetType) then begin // we are part a proper structure
      BasePtr := PByte(DataBasePtr) + OffsetType;
      Result := PByte(BasePtr)^;
    end;
  end;
end;

function GlobalDataSizer(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; var CompressedSize: Integer): Cardinal;
begin
  CompressedSize := PCardinal(PByte(aBasePtr) + SizeOf(cardinal))^ + 2*SizeOf(Cardinal);
  Result := CompressedSize;
end;

function ChangedFormDataSizer(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; var CompressedSize: Integer): Cardinal;
const
  OffsetLength = 9;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
  BasePtr    : Pointer;
  SizeLength : Integer;
  aType      : Integer;
begin
  Result := 0;
  Element := aElement;
  aType := ChangedFormGetRawType(Element);

  if (aType >= 0) and Supports(Element, IwbDataContainer, Container) then begin
    BasePtr := Container.DataBasePtr;
    SizeLength := aType shr 6;
    Element := Container.ElementByPath['Datas\CForm Data\Uncompressed Length'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end else with Container do if IsValidOffset(BasePtr, DataEndPtr, OffsetLength+SizeLength+1) then begin // we are part a proper structure
      aBasePtr := PByte(BasePtr) + OffsetLength + SizeLength + 1;
      case SizeLength of
        0: Result := PByte(aBasePtr)^;
        1: Result := PWord(aBasePtr)^;
        2: Result := PCardinal(aBasePtr)^;
      end;
    end;
    Element := Container.ElementByPath['Datas\CForm Data\Length'];
    if Assigned(Element) then begin
      CompressedSize := Element.NativeValue;
    end else with Container do if IsValidOffset(BasePtr, DataEndPtr, OffsetLength) then begin // we are part a proper structure
      aBasePtr := PByte(BasePtr) + OffsetLength;
      case sizeLength of
        0: CompressedSize := PByte(aBasePtr)^;
        1: CompressedSize := PWord(aBasePtr)^;
        2: CompressedSize := PCardinal(aBasePtr)^;
      end;
    end;
  end else
    CompressedSize := 0;
end;

function ChangedFormSizer(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; var CompressedSize: Integer): Cardinal;
var
  Struct : IwbStructCDef;
  i      : Integer;
  Size   : Int64;
begin
  CompressedSize := 0;
  if Assigned(aElement) and Supports(aElement.ValueDef, IwbStructCDef, Struct) then
    for i := 0 to Pred(Struct.MemberCount) do begin
      Size := Struct.Members[i].Size[aBasePtr, aEndPtr, aElement];
      if Size<>High(Integer) then begin
        aBasePtr := PByte(aBasePtr) + Size;
        Inc(CompressedSize, Size);
      end;
    end;
  Result := 0;
end;

function ChangedFormGetChapterType(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element : IwbElement;
begin
  Element := aElement;
  Result := ChangedFormGetRawType(Element);
  if Result >=0 then
    Result := wbChangedFormOffset + (Result and $3F);
end;

function ChangedFormGetChapterTypeName(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): String;
var
  aType : Integer;
begin
  aType := ChangedFormGetChapterType(aBasePtr, aEndPtr, aElement);
  if (aType>=wbChangedFormOffset) and (aType < wbChangedFormOffset+wbChangeTypes.NameCount) then
    Result := wbChangeTypes.Names[aType-wbChangedFormOffset];
  if (Pos(' ', Result)>0) and (Length(Result)>1) then
    Result := Copy(Result, Pos(' ', Result)+1, Length(Result));
  if (Pos(' ', Result)>0) and (Length(Result)>1) then
    Result := Copy(Result, 1, Pos(' ', Result)-1);
  if Length(Result)=0 then
    Result := IntToStr(aType);
end;

function ChangedFormGetChapterName(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): String;
var
  Element : IwbElement;
begin
  Result := '';
  if not Assigned(aElement) then
    Exit;
  Element := (aElement as iwbContainer).ElementByName['RefID'];
  if not Assigned(Element) then
    Exit;
  Result := Element.Value;
end;

function ChangedFormDataLengthDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType : Integer;
  Element : IwbElement;
begin
  Result := 3;
  Element := aElement;
  aType := ChangedFormGetRawType(Element) shr 6;

  if aType>=0 then begin
    case aType of
      0: Result := 0;
      1: Result := 1;
      2: Result := 2;
    end;
  end;
end;

function ChangedFormDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Element := aElement;
  Result := ChangedFormGetRawType(Element);

  if (Result>=0) and Supports(Element, IwbDataContainer, Container) then begin
    Result := 1 + (Result and $3F);
    if Assigned(ChaptersToSkip) and ChaptersToSkip.Find(IntToStr(wbChangedFormOffset+Result), aType)  then
      Result := 0;
  end else
    Result := 0;
end;

function ChangedFormNPCFaceHasHeadDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  Element := aElement;
  Element := wbFindSaveElement('Change Actor Face', Element);
  Assert(Element.BaseName='Change Actor Face');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Head Data'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function ChangedFormNPCFaceHasFaceMorphDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  Element := aElement;
  Element := wbFindSaveElement('Change Actor Face', Element);
  Assert(Element.BaseName='Change Actor Face');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Face Morph'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function ChangedFormProjectileHasInventoryDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  Element := aElement;
  Element := wbFindSaveElement('Change Projectile', Element);
  Assert(Element.BaseName='Change Projectile');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Inventory'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function ChangedFormExtraUnknown12HasUnk010Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  Element := aElement;
  Element := wbFindSaveElement('Extra Unknown 12', Element);
  Assert(Element.BaseName='Extra Unknown 12');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Unk010'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function ChangedFormActorHasEquipDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  Element := aElement;
  Element := wbFindSaveElement('Change Actor', Element);
  Assert(Element.BaseName='Change Actor');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Equip Data'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function ChangedFormHavokMovedSubBufferCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Havok Moved SubBuffer', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Length'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function ChangedFormAnimationSubBufferCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element    : IwbElement;
  Container  : IwbDataContainer;
begin
  Result := 0;
  Element := wbFindSaveElement('Animation SubBuffer', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Length'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function ChangedFormFlagsDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Element := aElement;
  Result := ChangedFormGetRawType(Element) and $3F;

  if (Result>=0) and Supports(Element, IwbDataContainer, Container) then begin
    Result := 1 + Result;
  end else
    Result := 0;
end;

function ChangedFlagXXDecider(aMask: Cardinal; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Changed Form', aElement);
  Assert(Element.BaseName='Changed Form');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Change Flags'];
    if Assigned(Element) then
      if (Element.NativeValue and aMask)<>0 then
        Result := 1;
  end;
end;

function ChangedFlagBitXXDecider(aMask: Cardinal; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagXXDecider(aMask, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag00Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000001, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag01Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000002, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag02Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000004, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag01or02Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000006, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag03Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000008, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag04Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000010, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag05Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000020, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag05or27Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($08000020, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag06Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000040, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag07Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000080, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag08Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000100, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag09Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000200, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag10Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000400, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag11Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00000800, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag12Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00001000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag13Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00002000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag14Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00004000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag15Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00008000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag16Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00010000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag17Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00020000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag18Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00040000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag19Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00080000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag20Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00100000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag21Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00200000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag22Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00400000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag23Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($00800000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag24Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($01000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag25Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($02000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag03or25Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($02000008, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag26Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($04000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag27Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($08000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag28Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($10000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag29Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($20000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag30Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($40000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag29or30Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($40000000, aBasePtr, aEndPtr, aElement);
end;

function ChangedFlag31Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := ChangedFlagBitXXDecider($80000000, aBasePtr, aEndPtr, aElement);
end;

var
  PlayerRefIndex : Cardinal = 0;

function IsActorPlayerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  anID      : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Changed Form', aElement);
  Assert(Element.BaseName='Changed Form');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['RefID'];
    if Assigned(Element) then begin
      anID := Element.NativeValue;
      if anID > 0 then begin
        if PlayerRefIndex = 0 then
          if (anID shr 22) = 0 then
            if GetSaveRefID(anID) = wbPlayerRefID then
                PlayerRefIndex := anID;
        if anID = PlayerRefIndex then
          Result := 1;
      end;
    end;
  end;
end;

function QuestRuntimeAliasTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Alias', aElement);
  Assert(Element.BaseName='Alias');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function QuestRuntimeHasEventDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Runtime Data', aElement);
  Assert(Element.BaseName='Runtime Data');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Has Event'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function QuestRuntimeParamTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Param', aElement);
  Assert(Element.BaseName='Param');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
      if Result>4 then
        Result := 0
      else
        Inc(Result);
    end;
  end;
end;

function InitialDataTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  Element := aElement;
  aType := ChangedFormGetRawType(Element) and $3f;

  if (aType>=0) and Supports(Element, IwbDataContainer, Container) then begin
    if aType = 6 then // CELL
      if (ChangedFlag30Decider(aBasePtr, aEndPtr, aElement)<>0) and
         (ChangedFlag29Decider(aBasePtr, aEndPtr, aElement)<>0) then
        Result := 1
      else if (ChangedFlag30Decider(aBasePtr, aEndPtr, aElement)<>0) and
              (ChangedFlag28Decider(aBasePtr, aEndPtr, aElement)<>0) then
        Result := 2
      else if (ChangedFlag30Decider(aBasePtr, aEndPtr, aElement)<>0) then
        Result := 3;
    if aType in [0,1,2,3,4,5,40,41,42] then begin  // REFR or descendant
      Element := Container.ElementByName['RefID'];
      if Assigned(Element) and (2 = (Element.NativeValue shr 22)) then // Form is Constructed
        Result := 5
      else if (ChangedFlag03or25Decider(aBasePtr, aEndPtr, aElement)<>0) then
        Result := 6
      else if (ChangedFlag01or02Decider(aBasePtr, aEndPtr, aElement)<>0) then
        Result := 4;
    end;
  end;
end;

function ChangedExtraUnionDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  ExtraTypeToDecider : array [0..164] of Byte = (
    0,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,1,2,3,4,5,6,7,
    8,9,$0A,$4A,$0B,$0C,$0D,$0E,$0F,$4A,$10,$11,$4A,$12,
    $13,$14,$15,$16,$17,$4A,$18,$19,$4A,$1A,$4A,$4A,$4A,
    $1B,$4A,$4A,$4A,$4A,$1C,$1D,$4A,$4A,$4A,$4A,$4A,$1E,
    $1F,$4A,$4A,$20,$21,$4A,$4A,$22,$23,$4A,$24,$4A,$4A,
    $4A,$25,$26,$27,$4A,$4A,$28,$29,$4A,$2A,$2B,$2C,$4A,
    $4A,$4A,$4A,$4A,$4A,$4A,$2D,$4A,$4A,$2E,$4A,$2F,$4A,
    $30,$4A,$4A,$31,$32,$33,$4A,$4A,$4A,$4A,$4A,$4A,$34,
    $4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$35,
    $4A,$36,$37,$4A,$4A,$4A,$38,$4A,$39,$4A,$4A,$4A,$3A,
    $4A,$4A,$3B,$3C,$4A,$3D,$3E,$4A,$3F,$40,$41,$4A,$42,
    $43,$44,$4A,$4A,$45,$4A,$4A,$4A,$4A,$46,$4A,$4A,$4A,
    $4A,$47,$48,$49
  );
var
  aType     : Integer;
  Element   : IwbElement;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Extra', aElement);
  Assert(Element.BaseName='Extra');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Extra Type'];
    if Assigned(Element) then begin
      aType := Element.NativeValue;
      if (aType>=$0C) and (aType<=$0C+164) then
        Result := 1+ExtraTypeToDecider[aType-$0C];
      if Result=$4A+1 then Result := 0;
    end;
  end;
  if Result > 1+$10 then Result := 0;
end;

function ChangedFormExtraDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  aType     : Integer;
  Element   : IwbElement;
begin
  Result := 0;

  Element := aElement;
  aType := ChangedFormGetRawType(Element) and $3f;

  if aType>=0 then begin
    if aType in [0,2,3,4,5,40, 41, 42, 47] then  // REFR or descendant
      if ChangedFlagXXDecider($0A6021C40, aBasePtr, aEndPtr, aElement)<>0 then
        Result := 1;
    if aType in [1] then  // Actor or descendant
      if ChangedFlagXXDecider($0A6061840, aBasePtr, aEndPtr, aElement)<>0 then
        Result := 1;
  end;
end;

function ChangedFormDataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('CForm Data', aElement);
  Assert(Element.BaseName='CForm Data');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Uncompressed Length'];
    if Assigned(Element) then
      if Element.NativeValue >0 then
        Result := Element.NativeValue
      else begin
        Element := Container.ElementByName['Length'];
        if Assigned(Element) then begin
          Result := Element.NativeValue;
        end;
      end;
  end;
end;

function ChangedFormRemainingDataFromHereCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
  EasC      : IwbDataContainer;
  Origin    : Cardinal;
  Consumed  : Cardinal;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('CForm Data', aElement);
  Assert(Element.BaseName='CForm Data');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Uncompressed Length'];
    if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
      Result := Element.NativeValue;
      if Result = 0 then begin
        Element := Container.ElementByName['Length'];
        if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
          Result := Element.NativeValue;
        end;
      end;
    end;
  end;

  if Result > 0 then begin
    Element := wbFindSaveElement('Changed Form Data', aElement);
    Assert(Element.BaseName='Changed Form Data');

    if Supports(Element, IwbDataContainer, Container) then begin
      Origin := Cardinal(Container.DataBasePtr);
      Consumed := Cardinal(aBasePtr) - Origin;
      Result := Result - Consumed;
    end;
  end;
end;

function ChangedFormRemainingDataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
  EasC      : IwbDataContainer;
  Origin    : Cardinal;
  Consumed  : Cardinal;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('CForm Data', aElement);
  Assert(Element.BaseName='CForm Data');

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Uncompressed Length'];
    if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
      Result := Element.NativeValue;
      if Result = 0 then begin
        Element := Container.ElementByName['Length'];
        if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
          Result := Element.NativeValue;
        end;
      end;
    end;
  end;

  if Result > 0 then begin
    Element := wbFindSaveElement('Changed Form Data', aElement);
    Assert(Element.BaseName='Changed Form Data');

    if Supports(Element, IwbDataContainer, Container) and (Container.ElementCount = 3) then begin
      Origin := Cardinal(Container.DataBasePtr);
      Element := Container.Elements[2];
      if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
        Consumed := Cardinal(EasC.DataBasePtr) - Origin;
        Result := Result - Consumed;
      end;
    end;
  end;
end;

function ChangedFormCellIsInteriorDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
const
  ExteriorSize = $20;
var
  RemainingBytes : Integer;
  BasePtr        : Pointer;
  Element        : IwbElement;
  Container      : IwbDataContainer;
  StringSize     : Integer;
begin
  Result := 0;
  // Let's see how many bytes remains:
  RemainingBytes := ChangedFormRemainingDataFromHereCounter(aBasePtr, aEndPtr, aElement);
  Element := wbFindSaveElement('Change CELL Data', aElement);
  Assert(Element.BaseName='Change CELL Data');
  if Supports(Element, IwbContainer, Container) then begin
    BasePtr := PByte(aBasePtr) + ExteriorSize;
    if ChangedFlag02Decider(BasePtr, aEndPtr, aElement) = 1 then begin
      StringSize := 2 + PWord(BasePtr)^;
      RemainingBytes := RemainingBytes - StringSize;
      BasePtr := PByte(aBasePtr) + StringSize;
    end;
    if ChangedFlag03Decider(BasePtr, aEndPtr, aElement) = 1 then begin
      RemainingBytes := RemainingBytes - 3;
    end;
    if RemainingBytes <> ExteriorSize then Result := 1;
  end;
end;

function SkipCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := wbBytesToSkip;
end;

function DumpCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  if wbBytesToDump = $FFFFFFFF then
    Result := ( Cardinal(aEndPtr) - Cardinal(aBasePtr) ) div wbBytesToGroup + 1
  else
    Result := wbBytesToDump div wbBytesToGroup + 1;
end;

function DataLengthCounter(aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aModifier: Integer = 0): Cardinal;
var
  Element   : IwbElement;
  Container : IwbDataContainer;

begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement(aName, aElement);
  Assert(Element.BaseName=aName);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['DataLength'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
      case aModifier of
        1: Result := Result div wbBytesToGroup;
        2: Result := Result mod wbBytesToGroup;
      end;
    end;
  end;
end;

function DataLengthRemainderCounter(aName: String; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aModifier: Integer = 0): Cardinal;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
  EasC      : IwbDataContainer;
  Origin    : Cardinal;
  Consumed   : Cardinal;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement(aName, aElement);
  Assert(Element.BaseName=aName);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['DataLength'];
    if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
      Result := Element.NativeValue + SizeOf(Cardinal);
      Origin := Cardinal(EasC.DataBasePtr);
      Element := Container.ElementByName['Remainder'];
      if Assigned(Element) and Supports(Element, IwbDataContainer, EasC) then begin
        Consumed := Cardinal(EasC.DataBasePtr) - Origin;
        Result := Result - Consumed;
        case aModifier of
          1: Result := Result div wbBytesToGroup;
          2: Result := Result mod wbBytesToGroup;
        end;
      end;
    end;
  end;
end;

function DataCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := DataLengthCounter('Global Data', aBasePtr, aEndPtr, aElement, 0);
end;

function DataQuartetCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := DataLengthRemainderCounter('Global Data', aBasePtr, aEndPtr, aElement, 1);
end;

function DataQuartetRemainderCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := DataLengthRemainderCounter('Global Data', aBasePtr, aEndPtr, aElement, 2);
end;


function CounterCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Quest Runtime Data', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Counter'];
    if Assigned(Element) then begin
      Result := Element.NativeValue;
    end;
  end;
end;

function DivByteBy4Counter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Factions', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Factions Length'];
    if Assigned(Element) then begin
      Result := Element.NativeValue div 4;
    end;
  end;
end;

var
  LastRegistrationStart : Integer = 0;

function F4SEChaptersDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element   : IwbElement;
  EValue    : String;
  Container : IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Chunk', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Type'];
    if Assigned(Element) then begin
      EValue := Element.Value;
           if EValue = 'MODS' then Result := 1
      else if EValue = 'LMOD' then Result := 2
  // Everything from here is copied from SKSE and totally unverrified
      else if EValue = 'REGS' then Result := 3
      else if EValue = 'REGE' then Result := 4
      else if EValue = 'MENR' then begin Result :=  5; LastRegistrationStart := Result; end
      else if EValue = 'KEYR' then begin Result :=  6; LastRegistrationStart := Result; end
      else if EValue = 'CTLR' then begin Result :=  7; LastRegistrationStart := Result; end
      else if EValue = 'MCBR' then begin Result :=  8; LastRegistrationStart := Result; end
      else if EValue = 'CHRR' then begin Result :=  9; LastRegistrationStart := Result; end
      else if EValue = 'CAMR' then begin Result := 10; LastRegistrationStart := Result; end
      else if EValue = 'AACT' then begin Result := 11; LastRegistrationStart := Result; end
      else Result := 12;
    end;
  end;
end;

function F4SERegKeyDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
  case LastRegistrationStart of
    5, 7, 8 : Result := 1;  // String
    6, 11:    Result := 2;  // UInt32
    9, 10:    Result := 3;  // Null
  end;
end;

function F4SERegDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
  case LastRegistrationStart of
    8:
      Result := 1;  // String
    5, 6, 7, 9, 10, 11:
      Result := 0;  // Null
  end;
end;

procedure DefineFO4SavesS;  // This is all based on current UESP, and HexDump, Triria TESSaveLib and the Runtime
var
  wbHeader                       : IwbStructDef;
  wbFileLocationTable            : IwbStructDef;
  wbGlobalData                   : IwbStructDef;
  wbChangedForm                  : IwbStructDef;
  wbChangedFormData              : IwbStructDef;
  wbNull                         : IwbValueDef;
  wbChangeFlags                  : IwbUnionDef;
  wbTypeData1                    : IwbStructDef;
  wbTypeData2                    : IwbStructDef;
  wbVMGroup                      : IwbStructDef;
  wbNonRecursiveVariable         : IwbStructDef;
  wbVariable                     : IwbStructDef;
  wbCodeOpcodes                  : IwbEnumDef;
  wbCodeParameter                : IwbStructDef;
  wbCode                         : IwbStructDef;
  wbFunction                     : IwbStructDef;
  wbObjectTableEntry             : IwbStructDef;
  wbObjectDetachedTableEntry     : IwbStructDef;
  wbArrayTableEntry              : IwbStructDef;
  wbStackTableEntry              : IwbStructDef;
  wbObjectDataTableEntry         : IwbStructDef;
  wbDetachedObjectDataTableEntry : IwbStructDef;
  wbArrayElementsTableEntry      : IwbStructDef;
  wbCallbackParameters           : IwbUnionDef;
  wbStackTableDataEntry          : IwbStructDef;
  wbUnknownS1                    : IwbStructDef;
  wbFunctionMessageDataEntry     : IwbStructDef;
  wbSuspendedStackDataEntry      : IwbStructDef;
  wbQueuedUnbindDataEntry        : IwbStructDef;
  wbStackTimeUpdateOffset        : IwbStructDef;
  wbObjectTimeUpdateOffset       : IwbStructDef;
  wbFunctor                      : IwbStructDef;
  wbFunctors                     : IwbStructDef;
  wbUnknown0900                  : IwbArrayDef;
  wbInitialDataType01            : IwbStructDef;
  wbInitialDataType02            : IwbStructDef;
  wbInitialDataType03            : IwbStructDef;
  wbInitialDataType04            : IwbStructDef;
  wbInitialDataType05            : IwbStructDef;
  wbInitialDataType06            : IwbStructDef;
  wbInitialDataType              : IwbUnionDef;
  wbCreatedObject                : IwbStructDef;
  wbBSTempEffect                 : IwbStructDef;
  wbReferenceEffect              : IwbStructDef;
  wbModelReferenceEffect         : IwbStructDef;
  wbBSTempEffectScreenSpaceDecal : IwbStructDef;
  wbOwnedController              : IwbStructDef;
  wbGlobalData10Unknown          : IwbStructDef;

  wbChangeDefaultFlags    : IwbIntegerDef;
  wbCoSaveChunk           : IwbStructDef;
  wbCoSaveChunks          : IwbArrayDef;
  wbCoSavePlugin          : IwbStructDef;
  wbCoSavePlugins         : IwbArrayDef;
  wbChangeFlags000        : IwbIntegerDef;
  wbChangeFlags001        : IwbIntegerDef;
  wbChangeFlags002        : IwbIntegerDef;
  wbChangeFlags003        : IwbIntegerDef;
  wbChangeFlags004        : IwbIntegerDef;
  wbChangeFlags005        : IwbIntegerDef;
  wbChangeFlags006        : IwbIntegerDef;
  wbChangeFlags007        : IwbIntegerDef;
  wbChangeFlags008        : IwbIntegerDef;
  wbChangeFlags009        : IwbIntegerDef;
  wbChangeFlags010        : IwbIntegerDef;
  wbChangeFlags011        : IwbIntegerDef;
  wbChangeFlags012        : IwbIntegerDef;
  wbChangeFlags013        : IwbIntegerDef;
  wbChangeFlags014        : IwbIntegerDef;
  wbChangeFlags015        : IwbIntegerDef;
  wbChangeFlags016        : IwbIntegerDef;
  wbChangeFlags017        : IwbIntegerDef;
  wbChangeFlags018        : IwbIntegerDef;
  wbChangeFlags019        : IwbIntegerDef;
  wbChangeFlags020        : IwbIntegerDef;
  wbChangeFlags021        : IwbIntegerDef;
  wbChangeFlags022        : IwbIntegerDef;
  wbChangeFlags023        : IwbIntegerDef;
  wbChangeFlags024        : IwbIntegerDef;
  wbChangeFlags025        : IwbIntegerDef;
  wbChangeFlags026        : IwbIntegerDef;
  wbChangeFlags027        : IwbIntegerDef;
  wbChangeFlags028        : IwbIntegerDef;
  wbChangeFlags029        : IwbIntegerDef;
  wbChangeFlags030        : IwbIntegerDef;
  wbChangeFlags031        : IwbIntegerDef;
  wbChangeFlags032        : IwbIntegerDef;
  wbChangeFlags033        : IwbIntegerDef;
  wbChangeFlags034        : IwbIntegerDef;
  wbChangeFlags035        : IwbIntegerDef;
  wbChangeFlags036        : IwbIntegerDef;
  wbChangeFlags037        : IwbIntegerDef;
  wbChangeFlags038        : IwbIntegerDef;
  wbChangeFlags039        : IwbIntegerDef;
  wbChangeFlags040        : IwbIntegerDef;
  wbChangeFlags041        : IwbIntegerDef;
  wbChangeFlags042        : IwbIntegerDef;
  wbChangeFlags043        : IwbIntegerDef;
  wbChangeFlags044        : IwbIntegerDef;
  wbChangeFlags045        : IwbIntegerDef;
  wbChangeFlags046        : IwbIntegerDef;
  wbChangeFlags047        : IwbIntegerDef;
  wbChangeFlags048        : IwbIntegerDef;
  wbChangeFlags049        : IwbIntegerDef;
  wbChangedActorBase      : IwbStructDef;
  wbChangedNPC            : IwbStructDef;
  wbChangedExtra          : IwbUnionDef;
  wbChangedREFR           : IwbStructDef;
  wbChangedActor          : IwbStructDef;
  wbChangedCharacter      : IwbStructDef;
  wbChangedProjectile     : IwbStructDef;
  wbChangedExtraData      : IwbArrayDef;
  wbChangedInventory      : IwbArrayDef;
  wbPosition              : IwbArrayDef;
  wbRotation              : IwbArrayDef;

  wbUnionCHANGE_FORM_FLAGS : IwbUnionDef;
  wbUnionCHANGE_REFR_MOVE : IwbUnionDef;
  wbUnionCHANGE_REFR_HAVOK_MOVE : IwbUnionDef;
  wbUnionCHANGE_REFR_CELL_CHANGED : IwbUnionDef;
  wbUnionCHANGE_REFR_SCALE : IwbUnionDef;
  wbUnionCHANGE_REFR_INVENTORY : IwbUnionDef;
//  wbUnionCHANGE_REFR_EXTRA_OWNERSHIP : IwbUnionDef;
  wbUnionCHANGE_REFR_BASEOBJECT : IwbUnionDef;
//  wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA : IwbUnionDef;
//  wbUnionCHANGE_OBJECT_EXTRA_AMMO : IwbUnionDef;
//  wbUnionCHANGE_OBJECT_EXTRA_LOCK : IwbUnionDef;
//  wbUnionCHANGE_OBJECT_EMPTY : IwbUnionDef;
//  wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE : IwbUnionDef;
  wbUnionCHANGE_OBJECT_OPEN_STATE : IwbUnionDef;
//  wbUnionCHANGE_REFR_PROMOTED : IwbUnionDef;
//  wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN : IwbUnionDef;
//  wbUnionCHANGE_REFR_LEVELED_INVENTORY : IwbUnionDef;
  wbUnionCHANGE_REFR_ANIMATION : IwbUnionDef;
//  wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE : IwbUnionDef;
  wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY : IwbUnionDef;
//  wbUnionCHANGE_REFR_EXTRA_GAME_ONLY : IwbUnionDef;
  wbUnionCHANGE_ACTOR_LIFESTATE : IwbUnionDef;
//  wbUnionCHANGE_ACTOR_EXTRA_PACKAGE_DATA : IwbUnionDef;
//  wbUnionCHANGE_ACTOR_EXTRA_MERCHANT_CONTAINER : IwbUnionDef;
//  wbUnionCHANGE_ACTOR_EXTRA_DISMEMBERED_LIMBS : IwbUnionDef;
//  wbUnionCHANGE_ACTOR_LEVELED_ACTOR : IwbUnionDef;
  wbUnionCHANGE_ACTOR_DISPOSITION_MODIFIERS : IwbUnionDef;
  wbUnionCHANGE_ACTOR_TEMP_MODIFIERS : IwbUnionDef;
  wbUnionCHANGE_ACTOR_DAMAGE_MODIFIERS : IwbUnionDef;
  wbUnionCHANGE_ACTOR_OVERRIDE_MODIFIERS : IwbUnionDef;
  wbUnionCHANGE_ACTOR_PERMANENT_MODIFIERS : IwbUnionDef;
  wbUnionCHANGE_CELL_FLAGS : IwbUnionDef;
  wbUnionCHANGE_CELL_FULLNAME : IwbUnionDef;
  wbUnionCHANGE_CELL_OWNERSHIP : IwbUnionDef;
  wbUnionCHANGE_CELL_EXTERIOR_SHORT : IwbUnionDef;
  wbUnionCHANGE_CELL_EXTERIOR_CHAR : IwbUnionDef;
  wbUnionCHANGE_CELL_DETACHTIME : IwbUnionDef;
  wbUnionCHANGE_CELL_SEENDATA : IwbUnionDef;
  wbUnionCHANGE_TOPIC_SAIDONCE : IwbUnionDef;
  wbUnionCHANGE_QUEST_FLAGS : IwbUnionDef;
  wbUnionCHANGE_QUEST_SCRIPT_DELAY : IwbUnionDef;
  wbUnionCHANGE_QUEST_ALREADY_RUN : IwbUnionDef;
  wbUnionCHANGE_QUEST_INSTANCES : IwbUnionDef;
  wbUnionCHANGE_QUEST_RUNDATA : IwbUnionDef;
  wbUnionCHANGE_QUEST_OBJECTIVES : IwbUnionDef;
  wbUnionCHANGE_QUEST_SCRIPT : IwbUnionDef;
  wbUnionCHANGE_QUEST_STAGES : IwbUnionDef;
  wbUnionCHANGE_ACTOR_BASE_DATA : IwbUnionDef;
  wbUnionCHANGE_ACTOR_BASE_ATTRIBUTES : IwbUnionDef;
  wbUnionCHANGE_ACTOR_BASE_AIDATA : IwbUnionDef;
  wbUnionCHANGE_ACTOR_BASE_SPELLLIST : IwbUnionDef;
  wbUnionCHANGE_ACTOR_BASE_FULLNAME : IwbUnionDef;
  wbUnionCHANGE_ACTOR_BASE_FACTIONS : IwbUnionDef;
  wbUnionCHANGE_NPC_SKILLS : IwbUnionDef;
  wbUnionCHANGE_NPC_CLASS : IwbUnionDef;
  wbUnionCHANGE_NPC_FACE : IwbUnionDef;
  wbUnionCHANGE_NPC_DEFAULT_OUTFIT : IwbUnionDef;
  wbUnionCHANGE_NPC_SLEEP_OUTFIT : IwbUnionDef;
  wbUnionCHANGE_NPC_GENDER : IwbUnionDef;
  wbUnionCHANGE_NPC_RACE : IwbUnionDef;
  wbUnionCHANGE_BASE_OBJECT_VALUE : IwbUnionDef;
  wbUnionCHANGE_BASE_OBJECT_FULLNAME : IwbUnionDef;
  wbUnionCHANGE_TALKING_ACTIVATOR_SPEAKER : IwbUnionDef;
  wbUnionCHANGE_BOOK_TEACHES : IwbUnionDef;
  wbUnionCHANGE_BOOK_READ : IwbUnionDef;
  wbUnionCHANGE_INGREDIENT_USE : IwbUnionDef;
  wbUnionCHANGE_NOTE_READ : IwbUnionDef;
  wbUnionCHANGE_ENCOUNTER_ZONE_FLAGS : IwbUnionDef;
  wbUnionCHANGE_ENCOUNTER_ZONE_GAME_DATA : IwbUnionDef;
  wbUnionCHANGE_CLASS_TAG_SKILLS : IwbUnionDef;
  wbUnionCHANGE_FACTION_FLAGS : IwbUnionDef;
  wbUnionCHANGE_FACTION_REACTIONS : IwbUnionDef;
  wbUnionCHANGE_FACTION_CRIME_COUNTS : IwbUnionDef;
  wbUnionCHANGE_PACKAGE_WAITING : IwbUnionDef;
  wbUnionCHANGE_PACKAGE_NEVER_RUN : IwbUnionDef;
  wbUnionCHANGE_QUEST_NODE_TIME_RUN : IwbUnionDef;
  wbUnionCHANGE_SCENE_ACTIVE : IwbUnionDef;
  wbUnionCHANGE_LOCATION_KEYWORDDATA : IwbUnionDef;
  wbUnionCHANGE_LOCATION_CLEARED : IwbUnionDef;
  wbUnionCHANGE_RELATIONSHIP_DATA : IwbUnionDef;
  wbUnionCHANGE_FORM_LIST_ADDED_FORM : IwbUnionDef;
  wbUnionCHANGE_LEVELED_LIST_ADDED_OBJECT : IwbUnionDef;
  wbUnionCHANGE_INR_MERGE_TARGET : IwbUnionDef;

  // (re)added until decoding properly
  wbUnionCHANGE_REFR_EXTRA_OWNERSHIP : IwbUnionDef;
  wbUnionCHANGE_REFR_EXTRA_LINK_REF : IwbUnionDef;
  wbUnionCHANGE_OBJECT_EXTRA_WORKSHOP : IwbUnionDef;
  wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA : IwbUnionDef;
  wbUnionCHANGE_OBJECT_EXTRA_AMMO : IwbUnionDef;
  wbUnionCHANGE_OBJECT_EXTRA_LOCK : IwbUnionDef;
  wbUnionCHANGE_OBJECT_FORCE_MOVE : IwbUnionDef;
  wbUnionCHANGE_OBJECT_EMPTY : IwbUnionDef;
  wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE : IwbUnionDef;
  wbUnionCHANGE_REFR_PROMOTED : IwbUnionDef;
  wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN : IwbUnionDef;
  wbUnionCHANGE_REFR_LEVELED_INVENTORY : IwbUnionDef;
  wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE : IwbUnionDef;
  wbUnionCHANGE_REFR_EXTRA_GAME_ONLY : IwbUnionDef;
  wbUnionCHANGE_ACTOR_EXTRA_PACKAGE_DATA : IwbUnionDef;
  wbUnionCHANGE_ACTOR_EXTRA_MERCHANT_CONTAINER : IwbUnionDef;
  wbUnionCHANGE_ACTOR_EXTRA_DISMEMBERED_LIMBS : IwbUnionDef;
  wbUnionCHANGE_ACTOR_LEVELED_ACTOR : IwbUnionDef;
  wbUnionCHANGE_NPC_BODY_SCALES : IwbUnionDef;

begin
  wbNull := wbByteArray('Unused', -255);
  wbTypeData2 := wbStruct('VM Type Data 2', [      // UESP : scriptInstance
    wbInteger('Script Name', itU16, wbVMType),
    wbInteger('Script Type', itU16, wbVMType),
    wbArray('Script Variables', wbStruct('Variable', [
      wbInteger('Name', itU16, wbVMType),
      wbInteger('Type', itU16, wbVMType)
    ]), -1)
  ]);
  wbTypeData1 := wbStruct('VM Type Data 1', [      // UESP : scriptInstance
    wbInteger('Script Name', itU16, wbVMType),
    wbArray('Script Variables', wbStruct('Variable', [
      wbInteger('Name', itU16, wbVMType),
      wbInteger('Type', itU16, wbVMType)
    ]), -1)
  ]);

  wbVMGroup := wbStruct('Grouped', [  // Seen repetivly while decoding VM
      wbInteger('Flag2bits', itU16, wbDumpInteger),
      wbInteger('Unknown', itS16, wbDumpInteger),   // returned as Dword = Word or (10000 * Flag2bits)
      wbUnion('', GroupedDecider, [wbRefID('RefID'), wbByteArray('Unknown', 4)]) // if flags is not 3, returned as 0 if unknown is -1/FFFFFFFF
    ]);

  wbObjectTableEntry := wbStruct('Full Object Table Entry', [  // UESP : reference
    wbInteger('Object Handle', itU64, wbVMHandle),
    wbInteger('Name', itU16, wbVMType),
    wbVMGroup,
    wbInteger('Unknown', itU8, wbDumpInteger)
  ]);

  wbObjectDetachedTableEntry := wbStruct('Simple Object Table Entry', [   // UESP : detachedReference
    wbInteger('Object Handle', itU64, wbVMHandle),
    wbInteger('Name', itU16, wbVMType)
  ]);

  wbNonRecursiveVariable := wbStruct('Variable', [
    wbInteger('Type', itU8, wbPropTypeEnum),
    wbUnion('Value', VariableDecider, [
      wbInteger('Int32', itS32),
      wbStruct('Object', [
        wbInteger('Object Type', itU16, wbVMType),
        wbInteger('Object Handle', itU64, wbVMObjectHandle)
      ]),
      wbInteger('String', itU16, wbVMType),
      wbInteger('Int32', itU32),
      wbFloat('Float'),
      wbInteger('Bool', itU32, wbEnum(['False', 'True'])),
      wbNull, // avoid recursive variable
      wbStruct('Struct', [
        wbInteger('Struct Type', itU16, wbVMType),
        wbInteger('Struct Handle', itU64, wbVMObjectHandle)
      ]),
      wbStruct('Object Array', [
        wbInteger('Object Type', itU16, wbVMType),
        wbInteger('Array Handle', itU64, wbVMArrayHandle)
      ]),
      wbInteger('String Array Handle', itU64, wbVMArrayHandle),
      wbInteger('Int32 Array Handle', itU64, wbVMArrayHandle),
      wbInteger('Float Array Handle', itU64, wbVMArrayHandle),
      wbInteger('Bool Array Handle', itU64, wbVMArrayHandle),
      wbInteger('Variable Array Handle', itU64, wbVMArrayHandle),
      wbStruct('Struct Array', [
        wbInteger('Struct Type', itU16, wbVMType),
        wbInteger('Array Handle', itU64, wbVMArrayHandle)
      ])
    ])
  ]);

  wbVariable := wbStruct('Variable', [
    wbInteger('Type', itU8, wbPropTypeEnum),
    wbUnion('Value', VariableDecider, [
      wbInteger('Int32', itS32),
      wbStruct('Object', [
        wbInteger('Object Type', itU16, wbVMType),
        wbInteger('Object Handle', itU64, wbVMObjectHandle)
      ]),
      wbInteger('String', itU16, wbVMType),
      wbInteger('Int32', itU32),
      wbFloat('Float'),
      wbInteger('Bool', itU32, wbEnum(['False', 'True'])),
      wbNonRecursiveVariable,
      wbStruct('Struct', [
        wbInteger('Struct Type', itU16, wbVMType),
        wbInteger('Struct Handle', itU64, wbVMObjectHandle)
      ]),
      wbStruct('Object Array', [
        wbInteger('Object Type', itU16, wbVMType),
        wbInteger('Array Handle', itU64, wbVMArrayHandle)
      ]),
      wbInteger('String Array Handle', itU64, wbVMArrayHandle),
      wbInteger('Int32 Array Handle', itU64, wbVMArrayHandle),
      wbInteger('Float Array Handle', itU64, wbVMArrayHandle),
      wbInteger('Bool Array Handle', itU64, wbVMArrayHandle),
      wbInteger('Variable Array Handle', itU64, wbVMArrayHandle),
      wbStruct('Struct Array', [
        wbInteger('Struct Type', itU16, wbVMType),
        wbInteger('Array Handle', itU64, wbVMArrayHandle)
      ])
    ])
  ]);

  wbCodeOpcodes := wbEnum([
    {000} 'Noop()',
    {001} 'IAdd(Identifier, Integer, Integer)',
    {002} 'FAdd(Identifier, Float, Float)',
    {003} 'ISubtract(Identifier, Integer, Integer)',
    {004} 'FSubtract(Identifier, Float, Float)',
    {005} 'IMultiply(Identifier, Integer, Integer)',
    {006} 'FMultiply(Identifier, Float, Float)',
    {007} 'IDivide(Identifier, Integer, Integer)',
    {008} 'FDivide(Identifier, Float, Float)',
    {009} 'IMod(Identifier, Integer, Integer)',
    {010} 'Not(Identifier, Any)',
    {011} 'INegate(Identifier, Integer)',
    {012} 'FNegate(Identifier, Float)',
    {013} 'Assign(Identifier, Any)',
    {014} 'Cast(Identifier, Any)',
    {015} 'CompareEQ(Identifier, Any, Any)',
    {016} 'CompareLT(Identifier, Any, Any)',
    {017} 'CompareLTE(Identifier, Any, Any)',
    {018} 'CompareGT(Identifier, Any, Any)',
    {019} 'CompareGTE(Identifier, Any, Any)',
    {020} 'Jump(Label)',
    {021} 'JumpT(Any, Label)',
    {022} 'JumpF(Any, Label)',
    {023} 'CallMethod(Name, Identifier, Identifier, *)',
    {024} 'CallParent(Name, Identifier, *)',
    {025} 'CallStatic(Name, Name, Identifier, *)',
    {026} 'Return(Any)',
    {027} 'StrCat(Identifier, String, String)',
    {028} 'PropGet(N, Identifier, Identifier)',
    {029} 'PropSet(N, Identifier, Any)',
    {030} 'ArrayCreate(Identifier, unsigned)',
    {031} 'ArrayLength(Identifier, Identifier)',
    {032} 'ArrayGetElement(Identifier, Identifier, Integer)',
    {033} 'ArraySetElement(Identifier, Integer, Any)',
    {034} 'ArrayFindElement(Identifier, Identifier, Any, Integer)',
    {035} 'ArrayRFindElement(Identifier, Identifier, Any, Integer)',
    {036} 'Is(Identifier, Any, Type)',
    {037} 'StructCreate(Struct)',
    {038} 'StructGet(Identifier)',
    {039} 'StructSet(Identifier, Name, Any',
    {040} 'ArrayFindStruct(Identifier, Identifier, String, Any, Integer)',
    {041} 'ArrayRFindStruct(Identifier, Identifier, String, Any, Integer)',
    {042} 'ArrayAddElements(Identifier, Any, Integer)',
    {043} 'ArrayInsertElement(Identifier, Any, Integer)',
    {044} 'ArrayRemoveLastElement(Identifier)',
    {045} 'ArrayRemoveElements(Identifier, Integer, Integer)',
    {046} 'ArrayClearElements(Identifier)'
  ]);
  // opCode parameter type Encoding:
  //  S : string    = Identifier
  //  I : integer   = an integer literal or an identifier
  //  u : unsigned  = an unsigned integer literal or an identifier
  //  F : float     = a float literal or an identifier
  //  Q :           = a string literal or an identifier
  //  L : label     = a label
  //  N : name      = a type, property or function name
  //  T : type      = a type name
  //  A : any
  //  * : optional

  wbCodeTypeEnum := wbEnum([
    {00} 'None',
    {01} 'Object',
    {02} 'String',
    {03} 'Int32',
    {04} 'Float',
    {05} 'Bool',
    {06} 'Unknown',
    {07} 'Unknown',   // Same format as 0, 3, 5, 6
    {08} 'Unknown'    // Same format as 1 and 2 wbPropType
  ]);

  wbCodeParameter := wbStruct('Parameter', [
    wbInteger('Type', itU8, wbCodeTypeEnum),  // Lower than 8 and lower than 5
    wbUnion('Value', CodeParameterTypeValueDecider, [
      wbNull,
      wbInteger('Object Type', itU16, wbVMType),
      wbInteger('String', itU16, wbVMType),
      wbInteger('Unsigned Integer', itU32),
      wbFloat('Float'),
      wbInteger('Boolean', itU8, wbEnum(['False', 'True'])),
      wbInteger('Unknown 6', itU32),  // Guess and/or placeholder
      wbInteger('Unknown 7', itU32),  // Guess and/or placeholder
      wbInteger('Unknown 8', itU16, wbVMType)  // Guess
    ])
  ]);

  wbCode := wbStruct('Code', [
    wbInteger('Opcode', itU8, wbCodeOpcodes),  // Lower than 36
    wbArray('Parameters', wbCodeParameter, OpcodeParameterCounter),
    wbUnion('Variable Parameters', OpcodeVariableParameterDecider, [
      wbNull,
      wbStruct('Variable Parameters', [
        wbInteger('Const', itU8),
        wbArray('Var. Parameters', wbCodeParameter, -1)
      ])
    ])
  ]);

  wbFunction := wbStruct('Function', [
    wbInteger('Return Type', itU16, wbVMType),
    wbInteger('DocString', itU16, wbVMType),
    wbInteger('User Flags', itU32, wbDumpInteger),
    wbInteger('Function Flags', itU8, wbDumpInteger),
    wbArray('Parameters', wbStruct('Parameter', [
      wbInteger('Name', itU16, wbVMType),
      wbInteger('Type', itU16, wbVMType)
    ]), -2),
    wbArray('Locals', wbStruct('Local', [
      wbInteger('Name', itU16, wbVMType),
      wbInteger('Type', itU16, wbVMType)
    ]), -2),
    wbArray('Codes', wbCode, -2)
  ]);

  wbObjectDataTableEntry := wbStruct('Object Table Data Entry', [  //  UESP: scriptData
    wbInteger('Object Handle', itU64, wbVMObjectHandle),
    wbStruct('Script', [
      wbInteger('Unknown Flags', itU8),
      wbInteger('Type', itU16, wbVMType),
      wbInteger('Unknown', itU32, wbDumpInteger),
      wbUnion('Unknown', ObjectDataTableEntryExtraDecider, [
        wbNull,
        wbInteger('Unknown', itU32, wbDumpInteger)
      ]),
      wbArray('Members', wbVariable, -1)
    ])
  ]);

  wbDetachedObjectDataTableEntry := wbStruct('Detached Object Table Data Entry', [  //  UESP: scriptData
    wbInteger('Object Handle', itU64, wbVMObjectHandle),
    wbStruct('Script', [
      wbInteger('Unknown Flags', itU8),
      wbArray('Members', wbVariable, -1)
    ])
  ]);

  wbArrayTableEntry := wbStruct('Array Entry Data', [  // UESP: arrayInfo
    wbInteger('Array Handle', itU64, wbVMHandle),
    wbInteger('Array Type', itU8, wbPropTypeEnum),    // valid values : 0 to 7, 0B to 11
    wbUnion('Data', ArrayTableEntryOptionalStringDecider, [
      wbNull,
      wbNull,
      wbInteger('Name', itU16, wbVMType)
    ]),
    wbInteger('Count', itU32)
  ]);

  wbArrayElementsTableEntry := wbStruct(ArrayContentEntryData, [   // UESP: arrayData
    wbInteger('Array Handle', itU64, wbVMArrayHandle),
    wbArrayS('Elements', wbvariable, ArrayElementsTableElementCounter)
  ]);

  wbStackTableEntry := wbStruct('Stack Entry Data', [
    wbInteger('Stack ID', itU32),
    wbInteger('Stack Type', itU8)
  ]);

  wbCallbackParameters := wbUnion('Parameters', StackCallBackTypeDecider, [
    wbNull,
    wbStruct('StageItemFinishedParameters', [
      wbRefID('RefID'),
      wbInteger('Unknown', itU16, wbDumpInteger),
      wbInteger('Unknown', itU8, wbDumpInteger)
    ]),
    wbStruct('SceneActionOrPhaseResultsParameters', [
      wbRefID('RefID'),
      wbInteger('Unknown', itU32, wbDumpInteger)
    ]),
    wbStruct('SceneResultsParameters', [
      wbRefID('RefID')
    ])
  ]);

  wbStackTableDataEntry := wbStruct('Stack Data Entry Data', [ // UESP: activeScriptData
    wbInteger('Stack ID', itU32),
    wbStruct('Stack', [
      wbInteger('Unknown', itU8),  // Should be lower than 9  (still in FO4)  UESP: Major version
      wbInteger('Unknown', itU8),  // Should be lower than 3  (still in FO4)  UESP: Minor version
      wbVariable,
      wbInteger('Extra Flag', itU8),
      wbInteger('Unknown', itU8, wbDumpInteger),  // Should be lower than 3 also
      wbUnion('Extra 1', StackTableDataEntryStackExtraDecider, [ // Extra Flag and $1 = $1
        wbNull,
        wbInteger('Unknown', itU32, wbDumpInteger),
        wbNull
      ]),
      wbStruct('CallBacks', [
        wbInteger('Type', itU8),  // Lower than 4 (in fact 3 errors out also)
        wbUnion('Unknown', StackTableDataEntryStackTypeDecider, [
          wbNull,       // < 1 or > 2
          wbStruct('Callback', [   // = 1  _anonymous_namespace_::EventCallbackAdapter::Func000A
            wbLenString('Type', 4),
            // Default is wbNull (REFREventCallbacks::IEventCallback virtual func 4)
            // TerminalRunResults is default
            // QuestStage id RefID (0x010), Word (0x014), Byte (0x016)
            // SceneResults is RefID (0x010)
            // SceneActionResults is RefID (0x010), DWord (0x014)
            // ScenePhaseResults is RefID (0x010), DWord (0x014)
            wbUnion('Callback Type Data', wbCallbackTypeDataDecider, [
              wbNull,
              wbStruct('Data', [
                wbRefID('RefID'),
                wbInteger('Unknown', itU16),
                wbInteger('Unknown', itU8)
              ]),
              wbRefID('RefID'),
              wbStruct('Data', [
                wbRefID('RefID'),
                wbInteger('Unknown', itU32)
              ]),
              wbStruct('Data', [
                wbRefID('RefID'),
                wbInteger('Unknown', itU32)
              ])
            ]),
            wbInteger('Unknown', itU32)
          ]),
          wbStruct('Callback', [  // = 2   _anonymous_namespace_::LatentCallback::Func000A
            wbInteger('Unknown', itU32),
            wbInteger('Unknown', itU8),
            wbInteger('Unknown 3', itU32)
          ])
        ])
      ]),
      wbInteger('Handle', itU64, wbVMObjectHandle),
      wbArray('Frames', wbStruct('Frame', [
        wbInteger('Extra Variables', itU32),
        wbStruct('Frame Data', [
          wbInteger('Flags', itU8),
          wbInteger('Function Type', itU8), // Should be lower than 3
          wbInteger('Unknown', itU16, wbVMType),
          wbInteger('Unknown', itU16, wbVMType),
          wbInteger('Unknown', itU16, wbVMType),
          wbUnion('Unknown', FunctionTypeAndFlagsDecider, [ // (version < 2 or Function Type = 0) and not Flags bit 0
            wbNull,
            wbInteger('Unknown', itU16, wbVMType)
          ]),
          wbInteger('Unknown', itU8, wbDumpInteger),
          wbInteger('Unknown', itU8, wbDumpInteger),
          wbFunction,
          wbInteger('Unknown', itU32, wbDumpInteger),
          wbVariable,
          wbArray('Variables', wbvariable, FrameExtraVariablesCounter)
        ])
      ]), -1),
      wbUnion('Extra 2', StackTableDataEntryStackExtraDecider, [ // Extra Flag and $2 = $2
        wbNull,
        wbNull,
        wbInteger('Unknown', itU8)  // Should be lower than 6
      ])
    ])
  ]);

  wbUnknownS1 := wbStruct('Unknown', [  // Shared between Function message and Suspended Stack
    wbInteger('Unknown', itU8, wbDumpInteger),  // lower than 4
    wbInteger('Unknown', itU16, wbVMType),
    wbInteger('Unknown', itU16, wbVMType),
    wbVariable,
    wbArray('Variables', wbVariable, -1)
  ]);

  wbFunctionMessageDataEntry := wbStruct('Function Message Data', [
    wbStruct('Function Call/Return Message', [
      wbInteger('Unknown', itU8, wbDumpInteger),  // lower than 3
      wbInteger('Unknown', itU32),
      wbInteger('Has UnknownS1', itU8, wbEnum(['False', 'True'])),
      wbUnion('Unknown', HasFunctionUnknownS1Decider, [
        wbNull,
        wbUnknownS1
      ])
    ])
  ]);

  wbSuspendedStackDataEntry := wbStruct('Suspended Stack', [
    wbInteger('Unknown', itU32),
    wbInteger('Has UnknownS1', itU8, wbEnum(['False', 'True'])),
    wbUnion('Unknown', HasStackUnknownS1Decider, [
      wbNull,
      wbUnknownS1
    ])
  ]);

  wbQueuedUnbindDataEntry := wbStruct('Queued Unbind Data', [
    wbInteger('Unknown', itU32),
    wbInteger('Unknown', itU32)
  ]);

  wbStackTimeUpdateOffset := wbStruct('Stack Time Update Offset', [
    wbInteger('Stack ID', itU32)
    ,wbInteger('Offset', itS32)
  ]);

  wbObjectTimeUpdateOffset := wbStruct('Object Time Update Offset', [
     wbInteger('Unknown', itU32)
    ,wbInteger('Unknown', itU32)
    ,wbInteger('Handle', itU64, wbVMHandle)
  ]);

  wbFunctor := wbStruct('Functor', [
    wbInteger('Type', itU8, wbEnum([
      'MoveTo',
      'MoveToOwnEditorLoc',
      'DamageObject',
      'Enable',
      'Disable',
      'Delete',
      'SetPosition',
      'SetAngle',
      'SetMotionType',
      'NonLatentDelete',
      'MoveToPackLoc',
      'SetScale',
      'DropObject',
      'Tether',
      'AttachAshPile',
      'AddRemoveConstraint',
      'ForceAddRemoveRagdoll',
      'ApplyHavokImpulse',
      'Reset',
      'SendPlayerToJail',
      'AddItem',
      'Resurrect',
      'Cast',
      'ScrollCast',
      'RemoveItem'
    ])),
    wbUnion('Data', FunctorDecider, [
      wbStruct('MoveTo', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU8),
        wbUnion('Unknown', VersionGreaterThan1Decider, [
          wbNull,
          wbInteger('Unknown', itU8)
        ])
      ]),
      wbStruct('MoveToOwnEditorLoc / Delete / NonLatentDelete', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID')
      ]),
      wbStruct('DamageObject / SetScale', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32)
      ]),
      wbStruct('Enable / Disable', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('Enable / Disable', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('MoveToOwnEditorLoc / Delete / NonLatentDelete', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID')
      ]),
      wbStruct('SetPosition / SetAngle', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32)
      ]),
      wbStruct('SetPosition / SetAngle', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32)
      ]),
      wbStruct('SetMotionType', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU8),
        wbInteger('Unknown', itU8),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('MoveToOwnEditorLoc / Delete / NonLatentDelete', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID')
      ]),
      wbStruct('MoveToPackLoc', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID')
      ]),
      wbStruct('DamageObject / SetScale', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32)
      ]),
      wbStruct('DropObject', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32)
      ]),
      wbStruct('Tether', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID')
      ]),
      wbStruct('AttachAshPile', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID')
      ]),
      wbStruct('AddRemoveConstraint', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbLenString('Unknown'),
        wbLenString('Unknown'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('ForceAddRemoveRagdoll', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('ApplyHavokImpulse', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32)
      ]),
      wbStruct('Reset', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID')
      ]),
      wbStruct('SendPlayerToJail', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('AddItem', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU8)
      ]),
      wbStruct('Resurrect', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID')
      ]),
      wbStruct('Cast', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbRefID('RefID')
      ]),
      wbStruct('ScrollCast', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbRefID('RefID')
      ]),
      wbStruct('RemoveItem', [
        wbInteger('Unknown', itU32),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbRefID('RefID'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU8)
      ])
    ])
  ]);

  wbFunctors := wbStruct('Functors', [
    wbArray('First Functor Table', wbFunctor, -1),
    wbArray('Second Functor Table', wbFunctor, -1),
    wbArray('Third Functor Table', wbFunctor, -1),
    wbArray('Fourth Functor Table', wbFunctor, -1)
  ]);

  wbUnknown0900 := wbArray('Unknown0900', wbStruct('Unknown', [
    wbInteger('Boolean', itU8, wbEnum(['False', 'True'])),
    wbInteger('Unknown', itU32),
    wbInteger('Unknown', itU32)
   ]), -1);

  wbCreatedObject := wbStruct('Created Object', [
    wbRefID('RefID'),
    wbInteger('Unknown', itU32),
    wbArray('Unknwon', wbStruct('Unknown', [
      wbRefID('RefID'),
      wbInteger('Unknown', itU32),
      wbInteger('Unknown', itU32),
      wbInteger('Unknown', itU32),
      wbInteger('Unknown', itU32)
    ]), -254)
  ]);

  wbOwnedController := wbStruct('Owned Controller', [
    wbRefID('Reference'),
    wbRefID('TESEffectShader'),
    wbRefID('BGSArtObject'),
    wbRefID('Reference')
  ]);
  wbBSTempEffect := wbStruct('Temp Effect', [
    wbFloat('Unknown'),
    wbFloat('Unknown'),
    wbInteger('Unknown', itU8),
    wbInteger('Unknown', itU32)
  ]);
  wbReferenceEffect := wbStruct('Reference Effect', [
    wbBSTempEffect,
    wbInteger('Unknown', itU8),
    wbRefID('Reference'),
    wbInteger('Owned Controller Type', itU8),
    wbUnion('Owned Controller', wbGlobalData6OwnedControllerDecider, [wbNull, wbOwnedController, wbStruct('Owned Camera Effect Controller', [
      wbInteger('Unknown', itU8),
      wbOwnedController
    ])])
  ]);
  wbModelReferenceEffect := wbStruct('Model Reference Effect', [
    wbReferenceEffect,
    wbRefID('BGSArtObject'),
    wbStruct('SubBuffer', [ // Also used in ActorMagicCaster
      wbInteger('Unknown', itU8),
      wbInteger('Length', itU6to30),
      wbByteArray('Unknown', wbSubBufferCounter)
    ]),
    wbInteger('Unknown', itU32)
  ]);
  wbBSTempEffectScreenSpaceDecal := wbStruct('Temp Effect Screen Space Decal', [
    wbBSTempEffect,
    wbRefID('Cell'),
    wbInteger('Unknown', itU8),
    wbInteger('Flag', itU8),
    wbUnion('Six', wbBSTempEffectScreenSpaceDecalSixDecider, [wbNull,
      wbStruct('Six struct', [
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU8),
        wbInteger('Unknown', itU8)
      ]),
      wbInteger('Flag2', itU8), // if null skip the rest
      wbUnion('Unknown', wbBSTempEffectScreenSpaceDecalRemainDecider, [ wbNull,
        wbStruct('Remain', [
          wbArray('Unknown', wbInteger('Unknown', itU64), {48 * constant / 48} 1), // need sample
          wbArray('Unknown', wbInteger('Unknown', itU64), {16 / 16} 1 ),
          wbInteger('Flag3', itU8),
          wbUnion('Unknown', wbBSTempEffectScreenSpaceDecalThirdDecider, [ wbNull,
            wbRefID('Reference'),
            wbLenString('Unknown', 2),
            wbInteger('Unknown', itU32),
            wbInteger('Unknown', itU32)
          ]),
          wbInteger('Unknown', itU32),
          wbInteger('Unknown', itU32),
          wbInteger('Unknown', itU32),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU16),
          wbInteger('Unknown', itU32),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU32),
          wbInteger('Unknown', itU8)
        ])
      ])
    ])
  ]);

  wbGlobalData10Unknown := wbStruct('Unknown struct', [
    wbInteger('Unknown', itU32),
    wbInteger('Unknown', itU32),
    wbInteger('Unknown', itU32),
    wbInteger('Type', itU32),
    wbUnion('Unknown', wbGlobalData10TypeDecider, [
      wbRefID('Keyword'),
      wbRefID('Reference'),
      wbRefID('RefID'),
      wbRefID('Location'),
      wbInteger('Unknown', itU32),
      wbNull
    ])
  ]);

  wbGlobalData := wbStructC('Global Data', GlobalDataSizer, GlobalDataGetChapterType, GlobalDataGetChapterTypeName, nil, [
    wbInteger('Type', itU32),
    wbInteger('DataLength', itU32),
    wbUnion('Data', GlobalDataDecider, [
      wbByteArray('Unknown', DataCounter)  // Single line
      // 0 to 8
     ,wbStruct('Misc Stats Struct', [
        wbArray('Misc Stats', wbStruct('Misc Stat',[
          wbLenString('Misc Stat Name', 2),
          wbInteger('Category', itU8 {, wbEnum([
            '0 = General',
            '1 = Quest',
            '2 = Combat',
            '3 = Magic',
            '4 = Crafting',
            '5 = Crime',
            '6 = Perks?'
          ])}),
          wbInteger('Value', itU32)
        ]), -1)
      ]),
      wbStruct('Player Location Struct', [  // Seems to be 30 bytes in version 64 and 31 in version 73 or 74
        wbByteArray('Unknown', 4)
        ,wbRefID('WorldSpace')
        ,wbInteger('Coord X', itS32)
        ,wbInteger('Coord Y', itS32)
        ,wbRefID('WorldSpace/Cell')
        ,wbFloat('Pos X')   // To be verified, read as 12 bytes
        ,wbFloat('Pos Y')
        ,wbFloat('Pos Z')
      ]),
      wbStruct('TES Struct', [
        wbArray('Unknown0', wbStruct('Unknown00', [
          wbRefID('Actor Base'),
          wbInteger('Unknown', itU16)
        ]), -254),
        wbArray('Unknown1', wbRefID('Unknown'), -241), // counter * counter elements
        wbArray('Unknown2', wbRefID('Reference'), -254)
      ]),
      wbArray('Global Variables', wbStruct('Global', [
        wbRefID('Global Name'),
        wbFloat('Value')
      ]), -254),
      wbStruct('Created Objects', [
        wbArray('Created Objects Array 1', wbCreatedObject, -254),
        wbArray('Created Objects Array 2', wbCreatedObject, -254),
        wbArray('Created Objects Array 3', wbCreatedObject, -254),
        wbArray('Created Objects Array 4', wbCreatedObject, -254)
      ]),
      wbStruct('Effects', [
        wbArray('Effect array', wbStruct('Effect', [
          wbInteger('Unknown', itU32),
          wbInteger('Unknown', itU32),
          wbInteger('Unknown', itU32),
          wbRefID('Image Space Modifier')
        ]), -254),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32)
      ]),
      wbStruct('Weather', [
        wbRefID('Climate'),
        wbRefID('Weather 1'),
        wbRefID('Weather 2'),
        wbRefID('Weather 3'),
        wbRefID('Weather 4'),
        wbRefID('Region'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Flags', itU8),
        wbUnion('Flags bit 0', GlobalData6FlagsBit0Decider, [wbNull, wbModelReferenceEffect]),
        wbUnion('Flags bit 1', GlobalData6FlagsBit1Decider, [wbNull, wbModelReferenceEffect])
      ]),
      wbStruct('Audio', [
        wbRefID('BGSSoundDescriptorForm'),
        wbArray('Unknown', wbRefID('BGSMusicType'), -254),
        wbStruct('BGSPlayerMusicChanger', [
          wbRefID('BGSMusicType')
        ]),
        wbStruct('Unknown', [
          wbArray('Unknown', wbStruct('Unknown', [
            wbRefID('BGSSoundCategorySnapshot'),
            wbInteger('Unknown', itU32)
          ]), -1)
        ]),
        wbArray('Unknown', wbRefID('Reference'), -254)
      ]),
      wbArray('Sky Cells', wbStruct('Sky Cell', [
        wbRefID('Worldspace'),
        wbRefID('RefID')
      ]), -254),
      wbStruct('Input Enable Manager', [
        wbInteger('Unknown', itU16),  // Required 0 or 1
        wbInteger('Unknown', itU32),
        wbArray('Unknown', wbStruct('Unknown', [
          wbInteger('Unknown', itU32),
          wbInteger('Unknown', itS32),
          wbInteger('Unknown', itS32),
          wbLenString('Unknown', 2)
        ]), -1)
      ]),
      wbStruct('StoryTeller', [
        wbArray('Unknown', wbGlobalData10Unknown, -1),
        wbArray('Unknown', wbGlobalData10Unknown, -1),
        wbArray('Quests 1', wbRefID('Quest'), -1),
        wbArray('Quests 2', wbRefID('Quest'), -1),
        wbArray('Quests 3', wbRefID('Quest'), -1),
        wbArray('Unknown', wbStruct('Unknown', [
          wbRefID('RefID'),
          wbArray('Unknown', wbStruct('Unknown', [
            wbInteger('Unknown', itU32),
            wbInteger('Unknown', itU32)
          ]), -254)
        ]), -254),
        wbInteger('Unknown', itU8)
      ]),
      wbArray('ReservedIDs', wbRefID('ReservedID'), -254),
      // 100 to 117
      wbStruct('Process List', [
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbArray('Unknown', wbArray('Unknown', wbStruct('Unknown', [
          wbInteger('Unknown', itU32),
          wbInteger('Unknown', itU32),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU32),
          wbInteger('Unknown', itU32),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU32),
          wbFloat('Unknown'),
          wbRefID('Reference'),
          wbRefID('Actor'),
          wbRefID('Bound Object'),
          wbRefID('RefID'),
          wbArray('Actors', wbRefID('Actor'), -254),
          wbInteger('Unknown', itU32),
          wbRefID('Faction'),
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itU16),
          wbInteger('Unknown', itU8),   // if form version > 26
          wbInteger('Unknown', itU32)   // if form version > 33
        ]), -254))
      ]),
      wbStruct('Combat', [
//        wbInteger('Unknown', itU32),
//        wbArray('Unknown1', wbStruct('Unknown1 struct', [
//          wbInteger('Unknown', itU32),
//          wbInteger('Unknown', itU32),
//          wbArray('Unknown12', wbStruct('Unknown12 struct' [
//            wbArray('Unknown120', wbStruct('Unknown120 struct', [
//              wbRefID('Actor'),
//              wbInteger('Unknown', itU32),
//              wbInteger('Unknown', itU32),
//              wbInteger('Unknown', itU32),  // if version > 17
//              wbInteger('Unknown', itU32),
//              wbInteger('Unknown', itU16),
//              wbInteger('Unknown', itU16),  // if version > 17
//              wbRefID('Actor'),
//              wbStruct('Unknown', [
//                wbInteger('Unknown', itU32),
//                wbRefID('RefID')
//              ]),
//              wbStruct('Unknown', [
//                wbInteger('Unknown', itU32),
//                wbRefID('RefID')
//              ]),
//              wbStruct('Unknown', [
//                wbInteger('Unknown', itU32),
//                wbRefID('RefID')
//              ]),
//              wbStruct('Unknown', [
//                wbInteger('Unknown', itU32),
//                wbRefID('RefID')
//              ]),
//              wbStruct('Unknown', [
//                wbInteger('Unknown', itU32),
//                wbRefID('RefID')
//              ]),
//              wbStruct('Unknown', [
//                wbInteger('Unknown', itU32),
//                wbRefID('RefID')
//              ]),
//              wbFloat('Unknown'),
//              wbFloat('Unknown'),
//              wbFloat('Unknown'),
//              wbFloat('Unknown'),
//              wbFloat('Unknown'),
//              wbFloat('Unknown'),
//              wbFloat('Unknown')
//            ]), -254),
//            wbArray('Unknown121', wbStruct('Unknown120 struct', [
//              wbRefID('Actor'),
//              wbInteger('Unknown', itU32),
//              wbInteger('Unknown', itU32),
//              wbInteger('Unknown', itU32),  // if version > 17
//              wbStruct('Unknown', [
//                wbInteger('Flags', itU64) // bit 0 used for next union
//              ])
//            ]), -254)
////            wbArray('Unknown122', , -254),
////            wbInteger('Unknown', itU32),
////            wbRefID('Actor'),
//          ]), -254)
//        ]), -254),
//        wbArray('Unused', wbInteger('Unused', itU8), -254)
      ]),
      wbByteArray('Interface'),
      wbByteArray('Actor Causes'),
      wbByteArray('Detection Manager'),
      wbByteArray('Location MetaData'),
      wbByteArray('Quest Static Data'),
      wbByteArray('Attraction Object LOS'),
      wbByteArray('Animation'),
      wbByteArray('Player Controls'),
      wbByteArray('Story Event Manager'),
      wbByteArray('Ingredient Shared'),
      wbByteArray('Menu Controls'),
      wbByteArray('Menu Topic Manager'),
      wbByteArray('Scene-filler Actors'),
      wbByteArray('Range Formations'),
      wbByteArray('Anim Objects'),
      wbByteArray('Radio Manager'),
      // 1000 to 1007
      wbStruct('Temp Effect', [
        wbArray('Unknown array 01', wbBSTempEffectScreenSpaceDecal, -254),
        wbArray('Unknown array 02', wbStruct('Unknown 02 struct', [
          wbInteger('Unknown', itU8),
          wbInteger('Flag', itU8),
          wbUnion('Unknown', wbGlobalData1000FlagDecider, [wbNull,
            wbStruct('Unknown', [
              wbRefID('Reference'),
              wbLenString('Unknown', 2),
              wbInteger('Unknown', itU32),
              wbInteger('Unknown', itU32)
            ])
          ]),
          wbInteger('NiNode count', itU32)
        ]), -254),
        wbInteger('Unknown', itU32),  // g_7FF7334407C8
        wbArray('Unknown array 11', wbStruct('Unknown', [
          wbInteger('Index', itU32), // Less than 12
          wbModelReferenceEffect
        ]), -254),
        wbArray('Unknown array 12', wbStruct('Unknown', [
          wbInteger('Index', itU32), // Less than 12
          wbModelReferenceEffect
        ]), -254),
        wbArray('Unknown array 13', wbStruct('Unknown', [
          wbInteger('Index', itU32), // Less than 12
          wbModelReferenceEffect
        ]), -254)
      ]),
      wbStruct('Papyrus Struct', [
        wbInteger('VM_version', itU16),  // FFFF marks an invalid save, 4 seems current max     UESP: header
        wbStruct('Tables', [
          wbArray('String Table for Internal VM save data', wbLenString('String', 2), -2, VMTypeAfterLoad),  // UESP strings
          wbStruct('Type tables for internal VM save data', [
           wbInteger('Type Table 2 Count', itU32),
           wbInteger('Type Table 1 Count', itU32),
           wbArray('Type table 2', wbTypeData2, TypeTable2Counter),  // Type table for internal VM save data  USEP:script
           wbArray('Type table 1', wbTypeData1, TypeTable1Counter)  // Type table for internal VM save data  USEP:script
          ]),
          wbArray('Object Table', wbObjectTableEntry, -1, ObjectTableAfterLoad),  // UESP: scriptInstance
          wbArray('Supplement Object Table', wbObjectDetachedTableEntry, -1, SupplementObjectTableAfterLoad),  // UESP: scriptInstance
          wbArray('Detached Object Table', wbObjectDetachedTableEntry, -1, ObjectDetachedTableAfterLoad), // UESP: reference
          wbArrayS('Array Table', wbArrayTableEntry, -1, ArrayTableAfterLoad), // UESP: arrayInfo
          wbStruct('Stacks', [
            wbInteger('Next Active Script ID', itU32),                // Part of Stack table
            wbArrayS('Stack Table', wbStackTableEntry, -1, StackTableAfterLoad) // UESP: activeScript
          ]),
          wbArray('Object Table Data', wbObjectDataTableEntry, ObjectTableDataCounter),     // UESP: scriptData and referenceData
          wbArray('Detached Object Table Data', wbDetachedObjectDataTableEntry, DetachedObjectTableDataCounter),     // UESP: scriptData and referenceData
          wbArray('Array Content Table', wbArrayElementsTableEntry, ArrayContentTableCounter), // UESP: arrayData
          wbArray('Stack Content Table', wbStackTableDataEntry, StackContentTableCounter),  // UESP: activeScriptData
          wbArray('Function Message Table', wbFunctionMessageDataEntry, -1),
          wbArray('First Suspended Stack Table', wbSuspendedStackDataEntry, -1),
          wbArray('Second Suspended Stack Table', wbSuspendedStackDataEntry, -1),
          wbInteger('Previous Unknown', itU32),
          wbUnion('Unknown', PreviousUnknownDecider, [
            wbNull,
            wbInteger('Unknown', itU32)
          ])
        ]),
        wbUnion('Version >= 2', VMVersionGreaterThan1Decider, [
           wbNull,
           wbArray('Unknown0', wbStruct('Unknown00', [
             wbInteger('Unknown', itU32),
             wbVariable
           ]), -1)
        ]),
        wbArray('Unknown Handle Table', wbInteger('Unknown Handle', itU64, wbVMHandle), -1),
        wbArray('Queued Unbind Array', wbStruct('Queued Unbind', [
          wbInteger('Handle', itU64, wbVMObjectHandle),
          wbInteger('Unknown', itU32)
        ]), -1),
        wbArray('Events', wbStruct('Event', [
          wbVMGroup,
          wbArray('Event Target List', wbStruct('Event Target', [
            wbInteger('Unknown', itU16, wbVMType),
            wbArray('Targets', wbInteger('Handle', itU64, wbVMObjectHandle), -1)
          ]), -1)
        ]), -1),
        wbInteger('Save File Version', itS16),
        wbUnion('', SaveIsValidDecider, [
          wbNull,
          wbStruct('Save File', [
            wbStruct('Updates', [
               wbArray('First Stack Time Update Table', wbStackTimeUpdateOffset, -1)
              ,wbArray('Second Stack Time Update Table', wbStackTimeUpdateOffset, -1)
              ,wbArray('Third Stack Time Update Table', wbStackTimeUpdateOffset, -1)
              ,wbArray('First Object Time Update Table', wbObjectTimeUpdateOffset, -1)
              ,wbArray('Second Object Time Update Table', wbObjectTimeUpdateOffset, -1)
            ]),
            wbArray('Long Strings', wbLenString('Unknown', 4), -1),
            wbFunctors,    // Still untested, no suitable save found
            wbArray('LOS events', wbStruct('LOS event', [
              wbInteger('Type', itU8), // valid if less than 2
              wbUnion('Data', wbLOSEventDataDecider, [
                wbNull,
                wbStruct('Detection event', [
                  wbInteger('Handle', itU64, wbVMObjectHandle),
                  wbUnion('VM Version > D', SaveFileVersionGreaterThanDDecider, [
                    wbStruct('Old version', [
                      wbRefID('Unknown'),
                      wbRefID('Unknown')
                    ]),
                    wbStruct('New Version', [
                      wbVMGroup,
                      wbVMGroup
                    ])
                  ]),
                  wbInteger('Unknown', itU8)  // valid if less than 3
                ]),  // Type = 0
                wbStruct('Direct event', [
                  wbInteger('Handle', itU64, wbVMObjectHandle),
                  wbUnion('VM Version > D', SaveFileVersionGreaterThanDDecider, [
                    wbStruct('Old version', [
                      wbRefID('Unknown'),
                      wbRefID('Unknown')
                    ]),
                    wbStruct('New Version', [
                      wbVMGroup,
                      wbVMGroup
                    ])
                  ]),
                  wbInteger('Unknown', itU8),  // valid if less than 3
                  wbInteger('String', itU16, wbVMType),
                  wbInteger('String', itU16, wbVMType)
                ])      // Type = 1
              ])
            ]), -1),
            wbArray('Sleep Event Handler', wbInteger('Handle', itU64, wbVMHandle), -1),
            wbArray('Tracked Stats Event Handler',
                wbUnion('VM Version > B', SaveFileVersionGreaterThanBDecider, [
                  wbArray('Handles', wbInteger('Handle', itU64, wbVMObjectHandle), -1),
                  wbStruct('Tracked Stat Event Handler', [
                    wbLenString('Stat', 4),
                    wbArray('Values', wbStruct('Value struct', [
                      wbInteger('Handle', itU64, wbVMObjectHandle),
                      wbInteger('Value', itU32)
                    ]), -1)
                  ])
              ]), -1),
            wbArray('Inventory Event Handler', wbStruct('Inventory Event', [
              wbInteger('Handle', itU64, wbVMObjectHandle),
              wbArray('Inventory Event Data', wbRefID('RefID'), -1) // Simplified version assuming vmVersion > 2, otherwize 2 counters then 2 arrays of refID
            ]), -1),
            wbArray('Custom Event Handler', wbStruct('Custom Event', [
              wbInteger('Handle', itU64, wbVMObjectHandle),
              wbArray('Custom Event Data', wbStruct('Data', [
                wbInteger('Unknown', itU16, wbVMType),
                wbArray('Unknown', wbInteger('Handle', itU64, wbVMObjectHandle), -1)
              ]), -1)
            ]), -1),
            wbStruct('Combat Event Handler', [ // Need version greater than 1
              wbArray('Unknown0', wbStruct('Unknwon00', [
                wbVMGroup,
                wbArray('Unknown000', wbStruct('Unknwon000 struct', [
                  wbInteger('Handle', itU64, wbVMObjectHandle),
                  wbArray('Unknown0000', wbStruct('Unknwon0000 struct', [
                    wbVMGroup,
                    wbRefID('RefID'),
                    wbRefID('RefID'),
                    wbInteger('Unknown', itU8),  // less than 3
                    wbInteger('Unknown', itU8),  // less than 3 also
                    wbInteger('Unknown', itU8),  // less than 3 still
                    wbInteger('Unknown', itU8),  // less than 3 again
                    wbInteger('Unknown', itU8)   // less than 3 final
                  ]), -1)
                ]), -1)
              ]), -1),
              wbArray('Unknown1', wbStruct('Unknown1 struct', [
                wbVMGroup,
                wbArray('Unknown10', wbStruct('Unknown10 struct',[
                  wbInteger('Handle', itU64, wbVMObjectHandle),
                  wbArray('Unknown100', wbStruct('Unknown100 struct',[
                    wbVMGroup,
                    wbRefID('RefID'),
                    wbInteger('Unknown', itU8)
                  ]), -1)
                ]), -1)
              ]), -1)
             ,wbArray('Unknown2', wbStruct('Unkwnon2 struct', [
                wbVMGroup,
                wbArray('Unknown20', wbInteger('Handle', itU64, wbVMObjectHandle), -1)
              ]), -1)
            ]),
            wbArray('Distance Event Handler', wbStruct('Distance Event struct', [ // Need version greater than 2
              wbInteger('Handle', itU64, wbVMObjectHandle),
              wbVMGroup,
              wbVMGroup,
              wbInteger('Unknown', itU8),  // should be less than 2
              wbFloat('Unknown')
            ]), -1),
            wbStruct('Menu Event Handler', [ // Need version greater than 4
              wbArray('Menu Events 1', wbStruct('Menu Event struct', [
                wbLenString('Unknown', 2),
                wbArray('Handles', wbInteger('Handle', itU64, wbVMObjectHandle), -1)
              ]), -1),
              wbArray('Handles 2', wbInteger('Handle', itU64, wbVMObjectHandle), -1), // Need version > 5
              wbArray('Menu Event 3', wbStruct('Menu Event struct', [ // Need version greater than 9
                wbLenString('Unknown', 2),
                wbArray('Handles', wbInteger('Handle', itU64, wbVMObjectHandle), -1)
              ]), -1)
              // wbArray('Handles 4', wbInteger('Handle', itU64, wbVMObjectHandle), -1) // Need version = 8 or 9
            ]),
            wbArray('Wait Event Handler', wbInteger('Handle', itU64, wbVMHandle), -1),
            wbArray('Teleport Event Handler', wbInteger('Handle', itU64, wbVMHandle), -1),
            wbArray('Unknown0', wbStruct('Unknown0 struct', [
              wbRefID('RefID'),
              wbInteger('Unknown', itU8)
            ]), -1),
           wbArray('Animation Callback Manager', wbStruct('Animation Callback', [  // this is about animations
              wbRefID('RefID'),
              wbArray('Unknown10', wbStruct('Unknown10 struct', [
                wbLenString('Unknown', 4),
                wbArray('Unknown100', wbStruct('Unknwon100 struct', [
                  wbInteger('Unknown', itU32),
                  wbInteger('Unknown', itU32)
                ]), -1),
                wbArray('Unknown101', wbInteger('Handle', itU64, wbVMObjectHandle), -1)
              ]), -1)
            ]), -1),
            wbArray('Pathing Callback manager', wbStruct('Pathing Callback', [  // Untested empty
              wbInteger('Unknown', itU32),
              wbInteger('Unknown', itU32)
            ]), -1),
            wbStruct('Quest Callback Manager', [
              wbArray('Quest Callbacks 1', wbStruct('Quest Callback', [
                wbRefID('RefID'),
                wbArray('Unknown30', wbStruct('Unknown30 struct', [
                  wbInteger('Unknown', itU8),
                  wbInteger('Unknown', itU32),
                  wbInteger('Unknown', itU32)
                ]), -1)
              ]), -1),
              wbArray('Quest Callbacks 2', wbStruct('Quest Callback', [
                wbRefID('RefID'),
                wbArray('Unknown31', wbStruct('Unknown31 struct', [
                  wbInteger('Unknown', itU32),
                  wbArray('Unknown310', wbInteger('Unknown', itU32), -1),
                  wbArray('Unknown311', wbStruct('Unknown311 struct', [
                    wbInteger('Unknown', itU32),
                    wbInteger('Unknown', itU8)
                  ]), -1),
                  wbInteger('Unknown', itU32)
                ]), -1)
              ]), -1),
              wbArray('Quest Callbacks 3', wbStruct('Quest Callback', [
                wbRefID('RefID'),
                wbArray('Unknown30', wbStruct('Unknown30 struct', [
                  wbInteger('Unknown', itU8),
                  wbInteger('Unknown', itU32),
                  wbInteger('Unknown', itU32)
                ]), -1)
              ]), -1)
            ]),
            wbArray('Sound Callback manager', wbStruct('Sound Callback', [
                wbInteger('Unknown', itU32),
                wbArray('Unknown10', wbInteger('Unknown', itU32), -1)
              ]), -1)
          ])
        ])
      ]),
      wbStruct('Anim Objects', [
//        wbArray('Anim Objects', wbStruct('Anim Object', [
//          wbRefID('REFR'),
//          wbRefID('ANIO'),
//          wbInteger('Boolean', itU8, wbEnum(['False', 'True'])),
//          wbUnion('Unknown', wbGlobalData1002BooleanDecider, [wbNull,
//            wbArray('Unknown', wbStruct('Unknown', [
//              wbLenString('Unknown', 2),
//              // Most likely variable
//              wbArray('Unknown', wbStruct('Unknown', [
//                wbLenString('Unknown', 2),
//                wbInteger('Unknown', itU32),
//                wbLenString('Unknown', 2),
//                wbInteger('Unknown', itU64),
//                wbInteger('Unknown', itU64),
//                wbInteger('Unknown', itU16),
//                wbInteger('Unknown', itU16),
//                wbInteger('Unknown', itU16),
//                wbInteger('Unknown', itU16)
//              ]), -1),
//              wbArray('Unknown', wbStruct('Unknown', [
//                wbLenString('Unknown', 2),
//                wbLenString('Unknown', 2),
//                wbInteger('Unknown', itU32)
//              ]), -1),
//              wbInteger('Unknown', itU32),
//              wbStruct(
//              wbLenString('Unknown', 2),
//
//              wbLenString('Unknown', 2),
//              wbInteger('Unknown', itU32),
//              wbStruct(
//              wbInteger('Unknown', itU32),
//              wbLenString('Unknown', 2),
//
//            ]), -1)
//          ])
//        ]), -1)
// Version for older Form Versions
//       ,wbStruct('Unknown1', [
//          wbInteger('Unknown', itU32),  // Version greater than 28 , need to be confirmed
//          wbArray('Anim Objects', wbStruct('Anim Object', [
//            wbRefID('REFR'),
//            wbRefID('ANIO'),
//            wbInteger('Boolean', itU8, wbEnum(['False', 'True']))
//          ]), -1)
//        ])
      ]),
      wbStruct('Timer', [
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32)
      ]),
      wbArray('Synchronized Animations', wbStruct('Unknown', [
        wbInteger('Unknown', itU32),
        wbInteger('Unknown', itU32),
        wbArray('Unknown', wbStruct('Unknown', [
          wbRefID('REFR'),
          wbLenString('String', 2)
        ]), -1)
      ]), -1),
      wbStruct('Main', []), // Empty
      wbArray('Topic Infos', wbStruct('Topic Info', [
        wbRefID('Topic Info'),
        wbInteger('Unknown', itU32)
      ]), -254),
      wbArray('Explosion Manager', wbRefID('Reference'), -254)
    ])
//    ,wbByteArray('Remainder', DataRemainderCounter)  // Single line
    ,wbArray('Remainder', wbByteArray('Unknown', wbBytesToGroup), DataQuartetCounter) // per Quartet
    ,wbByteArray('Unknown', DataQuartetRemainderCounter)
  ]);

  wbChangeTypes := wbKey2Data6Enum([
    '00 (040 : REFR)',
    '01 (041 : ACHR)',
    '02 (042 : PMIS)',
    '03 (044 : PGRE)',
    '04 (045 : PBEA)',
    '05 (046 : PFLA)',
    '06 (03F : CELL)',
    '07 (04F : INFO)',
    '08 (050 : QUST)',
    '09 (02D : NPC_)',
    '10 (01B : ACTI)',
    '11 (01C : TACT)',
    '12 (01D : ARMO)',
    '13 (01E : BOOK)',
    '14 (01F : CONT)',
    '15 (020 : DOOR)',
    '16 (021 : INGR)',
    '17 (022 : LIGH)',
    '18 (023 : MISC)',
    '19 (024 : STAT)',
    '20 (026 : MSTT)',
    '21 (02A : FURN)',
    '22 (02B : WEAP)',
    '23 (02C : AMMO)',
    '24 (02F : KEYM)',
    '25 (030 : ALCH)',
    '26 (031 : IDLM)',
    '27 (032 : NOTE)',
    '28 (06A : ECZN)',
    '29 (00D : CLAS)',
    '30 (00E : FACT)',
    '31 (052 : PACK)',
    '32 (04C : NAVM)',
    '33 (07A : WOOP)',
    '34 (015 : MGEF)',
    '35 (075 : SMQN)',
    '36 (07E : SCEN)',
    '37 (06B : LCTN)',
    '38 (07D : RELA)',
    '39 (049 : PHZD)',
    '40 (048 : PBAR)',
    '41 (047 : PCON)',
    '42 (05E : FLST)',
    '43 (02E : LVLN)',
    '44 (038 : LVLI)',
    '45 (055 : LVSP)',
    '46 (043 : PARW)',
    '47 (018 : ENCH)',
    '48 (037 : TERM)',
    '49 (093 : INNR)'
  ]);

  // changeType: 000 = formType: 064 : REFR
  wbChangeFlags000 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'CHANGE_REFR_BASEOBJECT', // BaseObject
    {08} 'CHANGE_REFR_EXTRA_LINK_REF', // Link Ref Extra
    {09} 'CHANGE_OBJECT_EXTRA_WORKSHOP', // Workshop Extra
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'CHANGE_OBJECT_FORCE_MOVE', // Force Move
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'CHANGE_OBJECT_EMPTY', // Empty
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'CHANGE_REFR_PROMOTED', // Promoted
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 001 = formType: 065 : ACHR
  wbChangeFlags001 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'CHANGE_REFR_BASEOBJECT', // BaseObject
    {08} 'CHANGE_REFR_EXTRA_LINK_REF', // Link Ref Extra
    {09} 'CHANGE_OBJECT_EXTRA_WORKSHOP', // Workshop Extra
    {10} 'CHANGE_ACTOR_LIFESTATE', // Life State
    {11} 'CHANGE_ACTOR_EXTRA_PACKAGE_DATA', // Package Data Extra
    {12} 'CHANGE_ACTOR_EXTRA_MERCHANT_CONTAINER', // Merchant Container
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'CHANGE_ACTOR_EXTRA_DISMEMBERED_LIMBS', // Dismembered Limbs
    {18} 'CHANGE_ACTOR_LEVELED_ACTOR', // Leveled Actor
    {19} 'CHANGE_ACTOR_DISPOSITION_MODIFIERS', // Disp Modifiers
    {20} 'CHANGE_ACTOR_TEMP_MODIFIERS', // Temp Modifiers
    {21} 'CHANGE_ACTOR_DAMAGE_MODIFIERS', // Damage Modifiers
    {22} 'CHANGE_ACTOR_OVERRIDE_MODIFIERS', // Override Modifiers
    {23} 'CHANGE_ACTOR_PERMANENT_MODIFIERS', // Permanent Modifiers
    {24} 'UnnamedFlag24',
    {25} 'CHANGE_REFR_PROMOTED', // Promoted
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 002 = formType: 066 : PMIS
  wbChangeFlags002 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'CHANGE_REFR_BASEOBJECT', // BaseObject
    {08} 'CHANGE_REFR_EXTRA_LINK_REF', // Link Ref Extra
    {09} 'CHANGE_OBJECT_EXTRA_WORKSHOP', // Workshop Extra
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'CHANGE_OBJECT_FORCE_MOVE', // Force Move
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'CHANGE_OBJECT_EMPTY', // Empty
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'CHANGE_REFR_PROMOTED', // Promoted
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 003 = formType: 068 : PGRE
  wbChangeFlags003 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'CHANGE_REFR_BASEOBJECT', // BaseObject
    {08} 'CHANGE_REFR_EXTRA_LINK_REF', // Link Ref Extra
    {09} 'CHANGE_OBJECT_EXTRA_WORKSHOP', // Workshop Extra
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'CHANGE_OBJECT_FORCE_MOVE', // Force Move
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'CHANGE_OBJECT_EMPTY', // Empty
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'CHANGE_REFR_PROMOTED', // Promoted
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 004 = formType: 069 : PBEA
  wbChangeFlags004 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'CHANGE_REFR_BASEOBJECT', // BaseObject
    {08} 'CHANGE_REFR_EXTRA_LINK_REF', // Link Ref Extra
    {09} 'CHANGE_OBJECT_EXTRA_WORKSHOP', // Workshop Extra
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'CHANGE_OBJECT_FORCE_MOVE', // Force Move
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'CHANGE_OBJECT_EMPTY', // Empty
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'CHANGE_REFR_PROMOTED', // Promoted
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 005 = formType: 070 : PFLA
  wbChangeFlags005 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'CHANGE_REFR_BASEOBJECT', // BaseObject
    {08} 'CHANGE_REFR_EXTRA_LINK_REF', // Link Ref Extra
    {09} 'CHANGE_OBJECT_EXTRA_WORKSHOP', // Workshop Extra
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'CHANGE_OBJECT_FORCE_MOVE', // Force Move
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'CHANGE_OBJECT_EMPTY', // Empty
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'CHANGE_REFR_PROMOTED', // Promoted
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 006 = formType: 063 : CELL
  wbChangeFlags006 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_CELL_FLAGS', // Flags
    {02} 'CHANGE_CELL_FULLNAME', // Full name
    {03} 'CHANGE_CELL_OWNERSHIP', // Ownership
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'CHANGE_CELL_EXTERIOR_SHORT', // Exterior Short
    {29} 'CHANGE_CELL_EXTERIOR_CHAR', // Exterior Char
    {30} 'CHANGE_CELL_DETACHTIME', // Detach Time
    {31} 'CHANGE_CELL_SEENDATA' // Seen Data
  ]));

  // changeType: 007 = formType: 079 : INFO
  wbChangeFlags007 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_TOPIC_SAIDONCE' // Said Once
  ]));

  // changeType: 008 = formType: 080 : QUST
  wbChangeFlags008 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_QUEST_FLAGS', // Quest Flags
    {02} 'CHANGE_QUEST_SCRIPT_DELAY', // Quest Script Delay
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'CHANGE_QUEST_ALREADY_RUN', // Quest Already Run
    {27} 'CHANGE_QUEST_INSTANCES', // Quest Instance Data
    {28} 'CHANGE_QUEST_RUNDATA', // Quest Runtime Data
    {29} 'CHANGE_QUEST_OBJECTIVES', // Quest Objectives
    {30} 'CHANGE_QUEST_SCRIPT', // Quest Script
    {31} 'CHANGE_QUEST_STAGES' // Quest Stages
  ]));

  // changeType: 009 = formType: 045 : NPC_
  wbChangeFlags009 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_ACTOR_BASE_DATA', // Base Data
    {02} 'CHANGE_ACTOR_BASE_ATTRIBUTES', // Attributes
    {03} 'CHANGE_ACTOR_BASE_AIDATA', // AI Data
    {04} 'CHANGE_ACTOR_BASE_SPELLLIST', // Spell List
    {05} 'CHANGE_ACTOR_BASE_FULLNAME', // Full Name
    {06} 'CHANGE_ACTOR_BASE_FACTIONS', // Factions
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'CHANGE_NPC_SKILLS', // NPC Skills
    {10} 'CHANGE_NPC_CLASS', // Class
    {11} 'CHANGE_NPC_FACE', // Face
    {12} 'CHANGE_NPC_DEFAULT_OUTFIT', // Default Outfit
    {13} 'CHANGE_NPC_SLEEP_OUTFIT', // Sleep Outfit
    {14} 'CHANGE_NPC_BODY_SCALES', // Body Scales
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'CHANGE_NPC_GENDER', // Gender
    {25} 'CHANGE_NPC_RACE', // Race
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 010 = formType: 027 : ACTI
  wbChangeFlags010 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 011 = formType: 028 : TACT
  wbChangeFlags011 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'CHANGE_TALKING_ACTIVATOR_SPEAKER', // Speaker
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 012 = formType: 029 : ARMO
  wbChangeFlags012 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 013 = formType: 030 : BOOK
  wbChangeFlags013 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'CHANGE_BOOK_TEACHES', // Teaches Skill
    {06} 'CHANGE_BOOK_READ', // Read
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 014 = formType: 031 : CONT
  wbChangeFlags014 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 015 = formType: 032 : DOOR
  wbChangeFlags015 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 016 = formType: 033 : INGR
  wbChangeFlags016 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_INGREDIENT_USE' // Ingredient Use
  ]));

  // changeType: 017 = formType: 034 : LIGH
  wbChangeFlags017 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 018 = formType: 035 : MISC
  wbChangeFlags018 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 019 = formType: 036 : STAT
  wbChangeFlags019 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 020 = formType: 038 : MSTT
  wbChangeFlags020 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 021 = formType: 042 : FURN
  wbChangeFlags021 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 022 = formType: 043 : WEAP
  wbChangeFlags022 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 023 = formType: 044 : AMMO
  wbChangeFlags023 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 024 = formType: 047 : KEYM
  wbChangeFlags024 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 025 = formType: 048 : ALCH
  wbChangeFlags025 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 026 = formType: 049 : IDLM
  wbChangeFlags026 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 027 = formType: 050 : NOTE
  wbChangeFlags027 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_NOTE_READ' // Note Read
  ]));

  // changeType: 028 = formType: 106 : ECZN
  wbChangeFlags028 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_ENCOUNTER_ZONE_FLAGS', // Zone Flags
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_ENCOUNTER_ZONE_GAME_DATA' // Game Data
  ]));

  // changeType: 029 = formType: 013 : CLAS
  wbChangeFlags029 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_CLASS_TAG_SKILLS', // Tag Skills
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 030 = formType: 014 : FACT
  wbChangeFlags030 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_FACTION_FLAGS', // Faction Flags
    {02} 'CHANGE_FACTION_REACTIONS', // Faction Reactions
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_FACTION_CRIME_COUNTS' // Faction Crime Counts
  ]));

  // changeType: 031 = formType: 082 : PACK
  wbChangeFlags031 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'CHANGE_PACKAGE_WAITING', // Waiting Flag
    {31} 'CHANGE_PACKAGE_NEVER_RUN' // Never Run Flag
  ]));

  // changeType: 032 = formType: 076 : NAVM
  wbChangeFlags032 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 033 = formType: 122 : WOOP
  wbChangeFlags033 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 034 = formType: 021 : MGEF
  wbChangeFlags034 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 035 = formType: 117 : SMQN
  wbChangeFlags035 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_QUEST_NODE_TIME_RUN' // Time Last Run
  ]));

  // changeType: 036 = formType: 126 : SCEN
  wbChangeFlags036 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_SCENE_ACTIVE' // Active
  ]));

  // changeType: 037 = formType: 107 : LCTN
  wbChangeFlags037 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'CHANGE_LOCATION_KEYWORDDATA', // KeywordData
    {31} 'CHANGE_LOCATION_CLEARED' // Cleared
  ]));

  // changeType: 038 = formType: 125 : RELA
  wbChangeFlags038 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_RELATIONSHIP_DATA', // Relationship Data
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 039 = formType: 073 : PHZD
  wbChangeFlags039 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'CHANGE_REFR_BASEOBJECT', // BaseObject
    {08} 'CHANGE_REFR_EXTRA_LINK_REF', // Link Ref Extra
    {09} 'CHANGE_OBJECT_EXTRA_WORKSHOP', // Workshop Extra
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'CHANGE_OBJECT_FORCE_MOVE', // Force Move
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'CHANGE_OBJECT_EMPTY', // Empty
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'CHANGE_REFR_PROMOTED', // Promoted
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 040 = formType: 072 : PBAR
  wbChangeFlags040 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'CHANGE_REFR_BASEOBJECT', // BaseObject
    {08} 'CHANGE_REFR_EXTRA_LINK_REF', // Link Ref Extra
    {09} 'CHANGE_OBJECT_EXTRA_WORKSHOP', // Workshop Extra
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'CHANGE_OBJECT_FORCE_MOVE', // Force Move
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'CHANGE_OBJECT_EMPTY', // Empty
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'CHANGE_REFR_PROMOTED', // Promoted
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 041 = formType: 071 : PCON
  wbChangeFlags041 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'CHANGE_REFR_BASEOBJECT', // BaseObject
    {08} 'CHANGE_REFR_EXTRA_LINK_REF', // Link Ref Extra
    {09} 'CHANGE_OBJECT_EXTRA_WORKSHOP', // Workshop Extra
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'CHANGE_OBJECT_FORCE_MOVE', // Force Move
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'CHANGE_OBJECT_EMPTY', // Empty
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'CHANGE_REFR_PROMOTED', // Promoted
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 042 = formType: 094 : FLST
  wbChangeFlags042 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_FORM_LIST_ADDED_FORM' // Added Form
  ]));

  // changeType: 043 = formType: 046 : LVLN
  wbChangeFlags043 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_LEVELED_LIST_ADDED_OBJECT' // Added Object
  ]));

  // changeType: 044 = formType: 056 : LVLI
  wbChangeFlags044 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_LEVELED_LIST_ADDED_OBJECT' // Added Object
  ]));

  // changeType: 045 = formType: 085 : LVSP
  wbChangeFlags045 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_LEVELED_LIST_ADDED_OBJECT' // Added Object
  ]));

  // changeType: 046 = formType: 067 : PARW
  wbChangeFlags046 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_REFR_MOVE', // Moved
    {02} 'CHANGE_REFR_HAVOK_MOVE', // Havok Moved
    {03} 'CHANGE_REFR_CELL_CHANGED', // Cell Changed
    {04} 'CHANGE_REFR_SCALE', // Scale
    {05} 'CHANGE_REFR_INVENTORY', // Inventory
    {06} 'CHANGE_REFR_EXTRA_OWNERSHIP', // Ownership Extra
    {07} 'CHANGE_REFR_BASEOBJECT', // BaseObject
    {08} 'CHANGE_REFR_EXTRA_LINK_REF', // Link Ref Extra
    {09} 'CHANGE_OBJECT_EXTRA_WORKSHOP', // Workshop Extra
    {10} 'CHANGE_OBJECT_EXTRA_ITEM_DATA', // Item Data Extra
    {11} 'CHANGE_OBJECT_EXTRA_AMMO', // Ammo Extra
    {12} 'CHANGE_OBJECT_EXTRA_LOCK', // Lock Extra
    {13} 'CHANGE_OBJECT_FORCE_MOVE', // Force Move
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'CHANGE_OBJECT_EMPTY', // Empty
    {22} 'CHANGE_OBJECT_OPEN_DEFAULT_STATE', // Open Default State
    {23} 'CHANGE_OBJECT_OPEN_STATE', // Open State
    {24} 'UnnamedFlag24',
    {25} 'CHANGE_REFR_PROMOTED', // Promoted
    {26} 'CHANGE_REFR_EXTRA_ACTIVATING_CHILDREN', // Activating Children
    {27} 'CHANGE_REFR_LEVELED_INVENTORY', // Leveled Inventory
    {28} 'CHANGE_REFR_ANIMATION', // Animation
    {29} 'CHANGE_REFR_EXTRA_ENCOUNTER_ZONE', // Enc Zone Extra
    {30} 'CHANGE_REFR_EXTRA_CREATED_ONLY', // Created Only Extra
    {31} 'CHANGE_REFR_EXTRA_GAME_ONLY' // Game Only Extra
  ]));

  // changeType: 047 = formType: 024 : ENCH
  wbChangeFlags047 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 048 = formType: 055 : TERM
  wbChangeFlags048 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'CHANGE_BASE_OBJECT_VALUE', // Object Value
    {02} 'CHANGE_BASE_OBJECT_FULLNAME', // Object Full Name
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  // changeType: 049 = formType: 147 : INNR
  wbChangeFlags049 := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'CHANGE_FORM_FLAGS', // Flags
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'CHANGE_INR_MERGE_TARGET' // Merge Target
  ]));

  wbChangeDefaultFlags := wbInteger('Change Flags', itU32 , wbFlags([
    {00} 'UnnamedFlag00',
    {01} 'UnnamedFlag01',
    {02} 'UnnamedFlag02',
    {03} 'UnnamedFlag03',
    {04} 'UnnamedFlag04',
    {05} 'UnnamedFlag05',
    {06} 'UnnamedFlag06',
    {07} 'UnnamedFlag07',
    {08} 'UnnamedFlag08',
    {09} 'UnnamedFlag09',
    {10} 'UnnamedFlag10',
    {11} 'UnnamedFlag11',
    {12} 'UnnamedFlag12',
    {13} 'UnnamedFlag13',
    {14} 'UnnamedFlag14',
    {15} 'UnnamedFlag15',
    {16} 'UnnamedFlag16',
    {17} 'UnnamedFlag17',
    {18} 'UnnamedFlag18',
    {19} 'UnnamedFlag19',
    {20} 'UnnamedFlag20',
    {21} 'UnnamedFlag21',
    {22} 'UnnamedFlag22',
    {23} 'UnnamedFlag23',
    {24} 'UnnamedFlag24',
    {25} 'UnnamedFlag25',
    {26} 'UnnamedFlag26',
    {27} 'UnnamedFlag27',
    {28} 'UnnamedFlag28',
    {29} 'UnnamedFlag29',
    {30} 'UnnamedFlag30',
    {31} 'UnnamedFlag31'
  ]));

  wbChangeFlags := wbUnion('Change Flags', ChangedFormFlagsDecider, [
    wbChangeDefaultFlags,
    wbChangeFlags000,
    wbChangeFlags001,
    wbChangeFlags002,
    wbChangeFlags003,
    wbChangeFlags004,
    wbChangeFlags005,
    wbChangeFlags006,
    wbChangeFlags007,
    wbChangeFlags008,
    wbChangeFlags009,
    wbChangeFlags010,
    wbChangeFlags011,
    wbChangeFlags012,
    wbChangeFlags013,
    wbChangeFlags014,
    wbChangeFlags015,
    wbChangeFlags016,
    wbChangeFlags017,
    wbChangeFlags018,
    wbChangeFlags019,
    wbChangeFlags020,
    wbChangeFlags021,
    wbChangeFlags022,
    wbChangeFlags023,
    wbChangeFlags024,
    wbChangeFlags025,
    wbChangeFlags026,
    wbChangeFlags027,
    wbChangeFlags028,
    wbChangeFlags029,
    wbChangeFlags030,
    wbChangeFlags031,
    wbChangeFlags032,
    wbChangeFlags033,
    wbChangeFlags034,
    wbChangeFlags035,
    wbChangeFlags036,
    wbChangeFlags037,
    wbChangeFlags038,
    wbChangeFlags039,
    wbChangeFlags040,
    wbChangeFlags041,
    wbChangeFlags042,
    wbChangeFlags043,
    wbChangeFlags044,
    wbChangeFlags045,
    wbChangeFlags046,
    wbChangeFlags047,
    wbChangeFlags048,
    wbChangeFlags049
  ]);

  wbPosition := wbArray('Position', wbFloat('Pos'), [ 'X', 'Y', 'Z' ]);
  wbRotation := wbArray('Rotation', wbFloat('Rot'), [ 'X', 'Y', 'Z' ]);

  wbUnionCHANGE_FORM_FLAGS := wbUnion('Flags', ChangedFlag00Decider, [wbNull,
    wbStruct('Change Form Flags', [
      wbInteger('Mask Invert Flags', itU32, wbRecordFlagsFlags),
      wbInteger('Mask Set unk018', itU16)
    ])
  ]);

  wbUnionCHANGE_REFR_MOVE := wbUnion('Moved', ChangedFlag01Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_HAVOK_MOVE := wbUnion('Havok Moved', ChangedFlag02Decider, [wbNull,
    wbStruct('Havok Moved SubBuffer', [
      wbInteger('Length', itU6to30),
      wbByteArray('Data', ChangedFormHavokMovedSubBufferCounter)
    ])
  ]);
  wbUnionCHANGE_REFR_CELL_CHANGED := wbUnion('Cell Changed', ChangedFlag03Decider, [wbNull, wbNull]);

  wbUnionCHANGE_REFR_SCALE := wbUnion('Scale', ChangedFlag04Decider, [wbNull,
    wbUnion('Change Scale', SaveFormVersion55Decider, [
      wbFloat('Scale'),
      wbArray('Scales', wbInteger('Scale', itU16), 1)
    ])
  ]);

// included in ExtraDataList  wbUnionCHANGE_REFR_EXTRA_OWNERSHIP := wbUnion('Ownership Extra', ChangedFlag06Decider, [wbNull, wbNull]);

  wbUnionCHANGE_REFR_BASEOBJECT := wbUnion('BaseObject', ChangedFlag07Decider, [wbNull, wbRefID('Change Base Form')]);

// included in ExtraDataList  wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA := wbUnion('Item Data Extra', ChangedFlag10Decider, [wbNull, wbNull]);
// included in ExtraDataList  wbUnionCHANGE_OBJECT_EXTRA_AMMO := wbUnion('Ammo Extra', ChangedFlag11Decider, [wbNull, wbNull]);
// included in ExtraDataList  wbUnionCHANGE_OBJECT_EXTRA_LOCK := wbUnion('Lock Extra', ChangedFlag12Decider, [wbNull, wbNull]);

// no actual data  wbUnionCHANGE_OBJECT_EMPTY := wbUnion('Empty', ChangedFlag21Decider, [wbNull, wbNull]);
// no actual data  wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE := wbUnion('Open Default State', ChangedFlag22Decider, [wbNull, wbNull]);
  wbUnionCHANGE_OBJECT_OPEN_STATE := wbUnion('Open State', ChangedFlag23Decider, [wbNull, wbNull]);

// no actual data  wbUnionCHANGE_REFR_PROMOTED := wbUnion('Promoted', ChangedFlag25Decider, [wbNull, wbNull]);
// included in ExtraDataList  wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN := wbUnion('Activating Children', ChangedFlag26Decider, [wbNull, wbNull]);

  wbUnionCHANGE_REFR_ANIMATION := wbUnion('Animation', ChangedFlag28Decider, [wbNull,
    wbStruct('Animation SubBuffer', [
      wbInteger('Length', itU6to30),
      wbByteArray('Data', ChangedFormAnimationSubBufferCounter)
    ])
  ]);

// included in ExtraDataList  wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE := wbUnion('Enc Zone Extra', ChangedFlag29Decider, [wbNull, wbNull]);

  wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY := wbUnion('Created Only Extra', ChangedFlag30Decider, [wbNull, wbNull]);

// included in ExtraDataList  wbUnionCHANGE_REFR_EXTRA_GAME_ONLY := wbUnion('Game Only Extra', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_ACTOR_LIFESTATE := wbUnion('Life State', ChangedFlag10Decider, [wbNull, wbNull]);

// included in ExtraDataList  wbUnionCHANGE_ACTOR_EXTRA_PACKAGE_DATA := wbUnion('Package Data Extra', ChangedFlag11Decider, [wbNull, wbNull]);
// included in ExtraDataList  wbUnionCHANGE_ACTOR_EXTRA_MERCHANT_CONTAINER := wbUnion('Merchant Container', ChangedFlag12Decider, [wbNull, wbNull]);
// included in ExtraDataList  wbUnionCHANGE_ACTOR_EXTRA_DISMEMBERED_LIMBS := wbUnion('Dismembered Limbs', ChangedFlag17Decider, [wbNull, wbNull]);
// included in ExtraDataList  wbUnionCHANGE_ACTOR_LEVELED_ACTOR := wbUnion('Leveled Actor', ChangedFlag18Decider, [wbNull, wbNull]);

  wbUnionCHANGE_ACTOR_DISPOSITION_MODIFIERS := wbUnion('Disp Modifiers', ChangedFlag19Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_TEMP_MODIFIERS := wbUnion('Temp Modifiers', ChangedFlag20Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_DAMAGE_MODIFIERS := wbUnion('Damage Modifiers', ChangedFlag21Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_OVERRIDE_MODIFIERS := wbUnion('Override Modifiers', ChangedFlag22Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_PERMANENT_MODIFIERS := wbUnion('Permanent Modifiers', ChangedFlag23Decider, [wbNull, wbNull]);

  wbUnionCHANGE_CELL_FLAGS := wbUnion('Flags', ChangedFlag01Decider, [wbNull, wbInteger('Flags', itU16)]);

  wbUnionCHANGE_CELL_FULLNAME := wbUnion('Full name', ChangedFlag02Decider, [wbNull, wbLenString('Change Full Name', 2)]);

  wbUnionCHANGE_CELL_OWNERSHIP := wbUnion('Ownership', ChangedFlag03Decider, [wbNull, wbRefID('Change Owner')]);

  wbUnionCHANGE_CELL_EXTERIOR_SHORT := wbUnion('Exterior Short', ChangedFlag28Decider, [wbNull, wbNull]);
  wbUnionCHANGE_CELL_EXTERIOR_CHAR := wbUnion('Exterior Char', ChangedFlag29Decider, [wbNull, wbNull]);
  wbUnionCHANGE_CELL_DETACHTIME := wbUnion('Detach Time', ChangedFlag30Decider, [wbNull, wbNull]);

  wbUnionCHANGE_CELL_SEENDATA := wbUnion('Seen Data', ChangedFlag31Decider, [wbNull,
    wbUnion('Change Seen Data', ChangedFormCellIsInteriorDecider, [
      wbByteArray('Change Seen Data', 32),
      wbStruct('Change Interior Seen Data', [
        wbArray('Unknown', wbStruct('Data', [
          wbInteger('Unknown', itU8),
          wbInteger('Unknown', itS8),
          wbByteArray('Change Seen Data', 32)
        ]), -254)
      ])
    ])
  ]);

  wbUnionCHANGE_TOPIC_SAIDONCE := wbUnion('Said Once', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_QUEST_FLAGS := wbUnion('Quest Flags', ChangedFlag01Decider, [wbNull, wbQuestFlags]);

  wbUnionCHANGE_QUEST_SCRIPT_DELAY := wbUnion('Quest Script Delay', ChangedFlag02Decider, [wbNull, wbInteger('Script Delay', itU32)]);

  wbUnionCHANGE_QUEST_ALREADY_RUN := wbUnion('Quest Already Run', ChangedFlag26Decider, [wbNull,
    wbInteger('Already Run', itU8, wbEnum(['False', 'True']))
  ]);

  wbUnionCHANGE_QUEST_INSTANCES := wbUnion('Quest Instance Data', ChangedFlag27Decider, [wbNull,
    wbStruct('Instance Data', [  // Multiple of 7 , no obvious array no obvious list
      wbInteger('Unknown', itU32),
      wbArray('Instances', wbStruct('Instance', [
        wbInteger('Unknown', itU32),                                          // Instance.unk000
        wbArray('Instance Aliases', wbStruct('Instance Alias', [
           wbInteger('Alias ID', itU32),
           wbRefID('RefID')
        ]), -254),
        wbArray('Instance Globals', wbStruct('Instance Global', [
           wbRefID('Global'),
           wbFloat('Value')
         ]), -254),
        wbInteger('Unknown', itU16),
        wbInteger('Unknown', itU8)
      ]), -254)
    ])
  ]);

  wbUnionCHANGE_QUEST_RUNDATA := wbUnion('Quest Runtime Data', ChangedFlag28Decider, [wbNull,
    wbStruct('Runtime Data', [
      wbInteger('Unknown', itU8),
      wbArray('Aliases', wbStruct('Alias', [
        wbInteger('Alias ID', itU32),
        wbInteger('Type', itU8),  // Should be either optional or filled at runtime, more saves needed
        wbUnion('Alias Data', QuestRuntimeAliasTypeDecider, [
          wbRefID('Alias Ref'),
          wbStruct('Alias Type 1', [
            wbRefID('New Reference'),
            wbRefID('BaseForm BoundObject'),
            wbRefID('Reference Location'),
            wbRefID('Starting Location'),
            wbRefID('BGSLocationRefType')
          ])
        ])
      ]), -1),
      wbArray('Locations', wbStruct('Location', [
        wbInteger('Location ID', itU32),
        wbRefID('Location')
      ]), -1),
      wbInteger('Has Event', itU8, wbEnum(['False', 'True'])),
      wbUnion('Event', QuestRuntimeHasEventDecider, [
        wbNull,
        wbStruct('Event Data', [
          wbInteger('Some ID', itU32),
          wbStringMgefCode('Code', 4),
          wbArray('Params', wbStruct('Param', [
            wbInteger('Type', itU32),
            wbUnion('Value', QuestRuntimeParamTypeDecider, [
              wbNull,
              wbRefID('TESObjectREFR'),
              wbRefID('RefID'),
              wbRefID('Location'),
              wbInteger('Unknown', itU32),
              wbRefID('Keyword')
            ])
          ]), -1)
        ])
      ])
    ])
  ]);

  wbUnionCHANGE_QUEST_OBJECTIVES := wbUnion('Quest Objectives', ChangedFlag29Decider, [wbNull,
    wbStruct('Objectives Data', [
      wbArray('Objectives', wbStruct('Objective', [
        wbInteger('Objective ID', itU32),
        wbInteger('Objective Status (Byte)', itU32, wbFlags(['Displayed', 'Completed']))
      ]), -254)
    ])
  ]);

  wbUnionCHANGE_QUEST_SCRIPT := wbUnion('Quest Script', ChangedFlag30Decider, [wbNull, wbNull]);

  wbUnionCHANGE_QUEST_STAGES := wbUnion('Quest Stages', ChangedFlag31Decider, [wbNull,
    wbStruct('Stages Data', [
      wbArray('Stages', wbStruct('Stage', [
        wbInteger('Stage ID', itU16),
        wbInteger('Sets Flag bit 0', itU8, wbEnum(['False', 'True']))
      ]), -254)
    ])
  ]);

  wbUnionCHANGE_ACTOR_BASE_DATA := wbUnion('Base Data', ChangedFlag01Decider, [wbNull, wbByteArray('Change Actor Base Data ACBS', 24)]);

  wbUnionCHANGE_ACTOR_BASE_ATTRIBUTES := wbUnion('Attributes', ChangedFlag02Decider, [wbNull, wbNull]);

  wbUnionCHANGE_ACTOR_BASE_AIDATA := wbUnion('AI Data', ChangedFlag03Decider, [wbNull, wbByteArray('Change Actor AI Data AIDT', 20)]);

  wbUnionCHANGE_ACTOR_BASE_SPELLLIST := wbUnion('Spell List', ChangedFlag04Decider, [wbNull,
    wbStruct('Change Actor Spell Lists', [
      wbArray('Spells', wbRefID('Spell'), -254),
      wbArray('Leveled Spells', wbRefID('Leveled Spell'), -254),
      wbArray('Shouts', wbRefID('Shout'), -254)
    ])
  ]);

  wbUnionCHANGE_ACTOR_BASE_FULLNAME := wbUnion('Full Name', ChangedFlag05Decider, [wbNull, wbLenString('Change Actor Full Name', 2)]);

  wbUnionCHANGE_ACTOR_BASE_FACTIONS := wbUnion('Factions', ChangedFlag06Decider, [wbNull,
    wbArray('Change Actor Factions', wbStruct('Faction and Rank', [
      wbInteger('Faction', itU24, wbRefID),
      wbInteger('Rank', itS8)
    ]), -254)
  ]);

  wbUnionCHANGE_NPC_SKILLS := wbUnion('NPC Skills', ChangedFlag09Decider, [wbNull,
    wbArray('Change Actor Skills', wbInteger('Skill', itU8), 52)
  ]);

  wbUnionCHANGE_NPC_CLASS := wbUnion('Class', ChangedFlag10Decider, [wbNull, wbRefID('Change Actor Class')]);

  wbUnionCHANGE_NPC_FACE := wbUnion('Face', ChangedFlag11Decider, [wbNull,
    wbStruct('Change Actor Face', [
      wbInteger('Has Head Data', itU8),
      wbUnion('Head Data', ChangedFormNPCFaceHasHeadDataDecider, [ wbNull,
        wbStruct('Data', [
          wbRefID('Hair Color'),
          wbArray('Skin Color', wbInteger('Color', itU8), ['R', 'G', 'B', 'T']),
          wbRefID('Texture Set')
        ])
      ]),
      wbArray('Head Parts', wbRefID('HeadPart'), -254),
      wbInteger('Has Face Morph', itU8),
      wbUnion('Face Morph', ChangedFormNPCFaceHasFaceMorphDecider, [ wbNull,
        wbStruct('Data', [
          wbArray('Options', wbFloat('Option'), -1),
          wbArray('Presets', wbInteger('Preset', itU32), -1)
        ])
      ])
    ])
  ]);

  wbUnionCHANGE_NPC_DEFAULT_OUTFIT := wbUnion('Default Outfit', ChangedFlag12Decider, [wbNull, wbRefID('Change Actor Default Outfit')]);

  wbUnionCHANGE_NPC_SLEEP_OUTFIT := wbUnion('Sleep Outfit', ChangedFlag13Decider, [wbNull, wbRefID('Change Actor Sleep Outfit')]);

  wbUnionCHANGE_NPC_GENDER := wbUnion('Gender', ChangedFlag24Decider, [wbNull, wbInteger('Change Actor Gender', itU8, wbSexEnum)]);

  wbUnionCHANGE_NPC_RACE := wbUnion('Race', ChangedFlag25Decider, [wbNull,
    wbStruct('Change Actor Race', [
      wbRefID('New'),
      wbRefID('Old')
    ])
  ]);

  wbUnionCHANGE_BASE_OBJECT_VALUE := wbUnion('Object Value', ChangedFlag01Decider, [wbNull, wbNull]);
  wbUnionCHANGE_BASE_OBJECT_FULLNAME := wbUnion('Object Full Name', ChangedFlag02Decider, [wbNull, wbNull]);

  wbUnionCHANGE_TALKING_ACTIVATOR_SPEAKER := wbUnion('Speaker', ChangedFlag23Decider, [wbNull, wbNull]);

  wbUnionCHANGE_BOOK_TEACHES := wbUnion('Teaches Skill', ChangedFlag05Decider, [wbNull, wbNull]);
  wbUnionCHANGE_BOOK_READ := wbUnion('Read', ChangedFlag06Decider, [wbNull, wbNull]);

  wbUnionCHANGE_INGREDIENT_USE := wbUnion('Ingredient Use', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_NOTE_READ := wbUnion('Note Read', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_ENCOUNTER_ZONE_FLAGS := wbUnion('Zone Flags', ChangedFlag01Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ENCOUNTER_ZONE_GAME_DATA := wbUnion('Game Data', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_CLASS_TAG_SKILLS := wbUnion('Tag Skills', ChangedFlag01Decider, [wbNull, wbNull]);

  wbUnionCHANGE_FACTION_FLAGS := wbUnion('Faction Flags', ChangedFlag01Decider, [wbNull, wbInteger('Change Flags', itU32)]);

  wbUnionCHANGE_FACTION_REACTIONS := wbUnion('Faction Reactions', ChangedFlag02Decider, [wbNull, wbNull]);
  wbUnionCHANGE_FACTION_CRIME_COUNTS := wbUnion('Faction Crime Counts', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_PACKAGE_WAITING := wbUnion('Waiting Flag', ChangedFlag30Decider, [wbNull, wbNull]);
  wbUnionCHANGE_PACKAGE_NEVER_RUN := wbUnion('Never Run Flag', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_QUEST_NODE_TIME_RUN := wbUnion('Time Last Run', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_SCENE_ACTIVE := wbUnion('Active', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_LOCATION_KEYWORDDATA := wbUnion('KeywordData', ChangedFlag30Decider, [wbNull, wbNull]);
  wbUnionCHANGE_LOCATION_CLEARED := wbUnion('Cleared', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_RELATIONSHIP_DATA := wbUnion('Relationship Data', ChangedFlag01Decider, [wbNull, wbNull]);

  wbUnionCHANGE_FORM_LIST_ADDED_FORM := wbUnion('Added Form', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_LEVELED_LIST_ADDED_OBJECT := wbUnion('Added Object', ChangedFlag31Decider, [wbNull, wbNull]);

  wbUnionCHANGE_INR_MERGE_TARGET := wbUnion('Merge Target', ChangedFlag31Decider, [wbNull, wbNull]);

  wbChangedActorBase := wbStruct('Changed Actor Base', [
    wbUnionCHANGE_FORM_FLAGS,
    wbUnionCHANGE_ACTOR_BASE_DATA,
    wbUnionCHANGE_ACTOR_BASE_FACTIONS,
    wbUnionCHANGE_ACTOR_BASE_SPELLLIST,
    wbUnionCHANGE_ACTOR_BASE_AIDATA,
    wbUnionCHANGE_ACTOR_BASE_FULLNAME
// not seen    wbUnionCHANGE_ACTOR_BASE_ATTRIBUTES
  ]);

  wbChangedNPC := wbStruct('Change Actor Data', [ {02A}
    wbChangedActorBase,
    wbUnionCHANGE_NPC_SKILLS,
    wbUnionCHANGE_NPC_CLASS,
    wbUnionCHANGE_NPC_RACE,
    wbUnionCHANGE_NPC_FACE,
    wbUnionCHANGE_NPC_GENDER,
    wbUnionCHANGE_NPC_DEFAULT_OUTFIT,
    wbUnionCHANGE_NPC_SLEEP_OUTFIT
  ]);

  wbInitialDataType01 := wbStruct('Detached CELL CHANGE_CELL_EXTERIOR_CHAR', [
    wbInteger('Worldspace Index', itU16, wbSaveWorldspaceIndex),  // index into Worldspace table
    wbInteger('coordX', itS8),
    wbInteger('coordY', itS8),
    wbInteger('detachTime', itU32)
//        ,wbUnionCHANGE_CELL_EXTERIOR_SHORT
//        ,wbUnionCHANGE_CELL_EXTERIOR_CHAR
//        ,wbUnionCHANGE_CELL_DETACHTIME
	]);

  wbInitialDataType02 := wbStruct('Detached CELL CHANGE_CELL_EXTERIOR_SHORT', [
    wbInteger('Worldspace Index', itU16, wbSaveWorldspaceIndex),  // index into Worldspace table
    wbInteger('coordX', itS16),
    wbInteger('coordY', itS16),
    wbInteger('detachTime', itU32)
//        ,wbUnionCHANGE_CELL_EXTERIOR_SHORT
//        ,wbUnionCHANGE_CELL_EXTERIOR_CHAR
//        ,wbUnionCHANGE_CELL_DETACHTIME
	]);

  wbInitialDataType03 := wbStruct('Detached CELL', [
    wbInteger('detachTime', itU32)
//        ,wbUnionCHANGE_CELL_EXTERIOR_SHORT
//        ,wbUnionCHANGE_CELL_EXTERIOR_CHAR
//        ,wbUnionCHANGE_CELL_DETACHTIME
	]);

  wbInitialDataType04 := wbStruct('Reference moved', [
    wbRefID('Cell/Worldspace'),
    wbPosition,
    wbRotation,
// no actual data     wbUnionCHANGE_REFR_MOVE
    wbUnionCHANGE_REFR_HAVOK_MOVE
// no actual data     wbUnionCHANGE_REFR_CELL_CHANGED
	]);

  wbInitialDataType05 := wbStruct('Constructed Reference', [
    wbRefID('Cell/Worldspace'),
    wbPosition,
    wbRotation,
    wbInteger('Flags', itU8),
    wbRefID('BaseForm ID'),
// no actual data     wbUnionCHANGE_REFR_MOVE
    wbUnionCHANGE_REFR_HAVOK_MOVE
// no actual data     wbUnionCHANGE_REFR_CELL_CHANGED
	]);

  wbInitialDataType06 := wbStruct('Reference Changed Cell or Promoted', [
    wbRefID('Cell/Worldspace'),
    wbPosition,
    wbRotation,
    wbRefID('new Cell/Worldspace'),
    wbInteger('CoordX', itS16),
    wbInteger('CoordY', itS16),
// no actual data     wbUnionCHANGE_REFR_MOVE
    wbUnionCHANGE_REFR_HAVOK_MOVE
// no actual data     wbUnionCHANGE_REFR_CELL_CHANGED
	]);

  wbInitialDataType := wbUnion('Initial Data Type', InitialDataTypeDecider, [
    wbNull,
    wbInitialDataType01,
    wbInitialDataType02,
    wbInitialDataType03,
    wbInitialDataType04,
    wbInitialDataType05,
    wbInitialDataType06
  ]);

  wbChangedExtraData := wbArray('Extras', wbStruct('Extra', [
    wbInteger('Extra Type', itU8, wbExtraTypeEnum),
    wbUnion('Extra Union', ChangedExtraUnionDecider, [
     wbByteArray('<ERROR BAD CODE ******************>'),
     wbStruct('Extra Unknown 12', [ // 00 Unknown12
       wbRefID('Unknown'),
       wbArray('Unk00C', wbStruct('Data', [
         wbInteger('Unknown', itU32),
         wbRefID('Unknown'),
         wbByteArray('Unknwon', 8)
       ]), -254),
       wbInteger('Has Unk010', itU8),
       wbUnion('Unk010', ChangedFormExtraUnknown12HasUnk010Decider, [ wbNull, wbByteArray('Unknwon', 8)]),
       wbInteger('Unknown', itU8)
     ]),
     wbNull,  // 01 ExtraWorn
     wbNull,  // 02 ExtraWornLeft
     wbStruct('Package Start Location', [                       // 003
       wbRefID('WorldSpace or Cell'),
       wbPosition,
       wbInteger('Unknown', itU32)
     ]),
     wbStruct('Package', [                                      // 004
       wbRefID('Package'),
       wbRefID('Reference'),
       wbInteger('Unk010', itU32),
       wbInteger('Byte018', itU8),  // Xor'ed flag, updates bit0 of unk014
       wbInteger('Byte019', itU8),  // Xor'ed flag, updates bit1 of unk014
       wbInteger('Byte01A', itU8)   // Xor'ed flag, updates bit2 of unk014
     ]),
     wbRefID('TresPass Package'),                               // 005
     wbArray('RunOncePacks', wbStruct('RunOncePack', [          // 006
       wbRefID('Package'),
       wbInteger('Unk004', itU8)
     ]), -254),
     wbRefID('Reference Handle'),                               // 007
     wbNull, // no effect                                       // 008 Follower
     wbInteger('Leveled Creature Modifier', itU32),             // 009
     wbInteger('Ghost', itU8),                                  // 00A
     wbRefID('Ownership'),                                      // 00B
     wbRefID('Global'),                                         // 00C
     wbInteger('Rank', itS32),                                  // 00D
     wbInteger('Count', itS16),                                 // 00E
     wbFloat('Heath'),                                          // 00F
     wbNull
    ])
  ]), -254);

  wbChangedInventory := wbArray('Entry Datas', wbStruct('Entry Data', [
    wbRefID('Type'),
    wbInteger('Delta', itS32),
    wbArray('Extend Datas', wbStruct('Extra Data List', [wbChangedExtraData]), -254)
  ]), -254);

  wbUnionCHANGE_REFR_INVENTORY := wbUnion('Inventory', ChangedFlag05or27Decider, [wbNull, wbChangedInventory]);
//identical to wbUnionCHANGE_REFR_INVENTORY  wbUnionCHANGE_REFR_LEVELED_INVENTORY := wbUnion('Leveled Inventory', ChangedFlag05or27Decider, [wbNull, wbChangedInventory]);

//  // check against 10100110000001100001100001000000 if Actor
//  //               31 29 26 25  18 17 12 11    6
//  // check against 10100110000000100001110001000000 if not Actor
//  //               31 29 26 25     17 12 11 10 6

  wbChangedExtra := wbUnion('Changed Extra', ChangedFormExtraDecider, [wbNull, wbChangedExtraData]);

  wbChangedREFR := wbStruct('Change REFR Data', [
     wbUnionCHANGE_FORM_FLAGS
    ,wbUnionCHANGE_REFR_BASEOBJECT
// no actual data   ,wbUnionCHANGE_OBJECT_EMPTY
// no actual data  wbUnionCHANGE_ACTOR_DAMAGE_MODIFIERS
    ,wbUnionCHANGE_REFR_SCALE
    ,wbChangedExtra
//        ,wbUnionCHANGE_REFR_MOVE
//        ,wbUnionCHANGE_REFR_HAVOK_MOVE
//        ,wbUnionCHANGE_REFR_CELL_CHANGED
//        ,wbUnionCHANGE_REFR_EXTRA_OWNERSHIP
//        ,wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA
//        ,wbUnionCHANGE_OBJECT_EXTRA_AMMO
//        ,wbUnionCHANGE_OBJECT_EXTRA_LOCK
//        ,wbUnionCHANGE_REFR_PROMOTED
//        ,wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN
//        ,wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE
//        ,wbUnionCHANGE_REFR_EXTRA_GAME_ONLY
    ,wbUnionCHANGE_REFR_INVENTORY
//    ,wbUnionCHANGE_REFR_LEVELED_INVENTORY
    ,wbUnionCHANGE_REFR_ANIMATION
// no actual data    ,wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE
  ]);
// not seen   ,wbUnionCHANGE_OBJECT_OPEN_STATE
// not seen   ,wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY

  wbChangedActor := wbStruct('Change Actor', [
     wbInteger('Has EquipData', itU32)
    ,wbInteger('flags1', itU32)
    ,wbChangedREFR
    ,wbUnion('Change Equip Data', ChangedFormActorHasEquipDataDecider, [ wbNull,
      wbStruct('Data', [
      ])
    ])
  ]);

//  wbUnionCHANGE_ACTOR_LIFESTATE := wbUnion('Life State', ChangedFlag10Decider, [wbNull, wbNull]);
//
//  wbUnionCHANGE_ACTOR_DISPOSITION_MODIFIERS := wbUnion('Disp Modifiers', ChangedFlag19Decider, [wbNull, wbNull]);
//  wbUnionCHANGE_ACTOR_TEMP_MODIFIERS := wbUnion('Temp Modifiers', ChangedFlag20Decider, [wbNull, wbNull]);
//  wbUnionCHANGE_ACTOR_DAMAGE_MODIFIERS := wbUnion('Damage Modifiers', ChangedFlag21Decider, [wbNull, wbNull]);
//  wbUnionCHANGE_ACTOR_OVERRIDE_MODIFIERS := wbUnion('Override Modifiers', ChangedFlag22Decider, [wbNull, wbNull]);
//  wbUnionCHANGE_ACTOR_PERMANENT_MODIFIERS := wbUnion('Permanent Modifiers', ChangedFlag23Decider, [wbNull, wbNull]);

  wbChangedCharacter := wbStruct('Changed Character', [
    wbChangedActor
  ]);

  wbChangedProjectile := wbStruct('Changed Projectile', [
    wbChangedREFR,
    wbInteger('Unknown', itU32),  // 138
    wbInteger('Unknown', itU32),  // 0FC
    wbInteger('Unknown', itU32),  // 104
    wbInteger('Unknown', itU32),  // 100
    wbInteger('Unknown', itU32),  // 108
    wbInteger('Unknown', itU32),  // 10C
    wbInteger('Unknown', itU32),  // 110
    wbInteger('Unknown', itU32),  // 114
    wbInteger('Unknown', itU32),  // 118
    wbRefID('Weapon'),            // 124
    wbRefID('Ammo'),              // 128
    wbRefID('Reference'),         // 0B8
    wbRefID('Reference'),         // 0BC
    wbInteger('Unknown', itU32),  // 094
    wbInteger('Unknown', itU32),  // 12C
    wbInteger('Unknown', itU32),  // 130
    wbStruct('Unknown', [         // 05C
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown')
    ]),
    wbInteger('Unknown', itU32),  // 080
    wbInteger('Unknown', itU32),  // 08C
    wbInteger('Unknown', itU32),  // 11C
    wbInteger('Unknown', itU32),  // 120
    wbInteger('Unknown', itU32),  // key in some array
    wbInteger('Has Inventory', itU8),
    wbUnion('Inventory', ChangedFormProjectileHasInventoryDecider, [ wbNull, wbChangedInventory]), // OBC
    wbArray('Unknown', wbStruct('Unknown', [    //
      wbPosition,
      wbRotation,
      wbRefID('Material Type'),
      wbInteger('Unknown', itU32),
      wbInteger('Unknown', itU8),
      wbInteger('Unknown', itU16),
      wbInteger('Unknown', itU16),
      wbRefID('Reference'),
      wbInteger('Unknown', itU32),
      wbInteger('Unknown', itU32),
      wbInteger('Unknown', itU8)
    ]), -254),
    wbByteArray('Unknown', 12),   // 0A0
    wbRefID('Explosion'),         // OE0
    wbInteger('Unknown', itU32),  // 134
    wbRefID('Magic Item'),        // 0E4
    wbUnion('Unknown', SaveFormVersionGreaterThan10Decider, [
      wbInteger('Unknown', itU32),      // 0E8
      wbStruct('Unknown', [
        wbInteger('Uknown', itU32),     // 0E8
        wbRefID('Reference')            // Seems lost !
      ])
    ])
  ]);

  // (re) added until decoded

  wbUnionCHANGE_ACTOR_BASE_AIDATA := wbUnion('AI Data', ChangedFlag03Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_BASE_ATTRIBUTES := wbUnion('Attributes', ChangedFlag02Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_BASE_DATA := wbUnion('Base Data', ChangedFlag01Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_BASE_FACTIONS := wbUnion('Factions', ChangedFlag06Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_BASE_FULLNAME := wbUnion('Full Name', ChangedFlag05Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_BASE_SPELLLIST := wbUnion('Spell List', ChangedFlag04Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_DAMAGE_MODIFIERS := wbUnion('Damage Modifiers', ChangedFlag21Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_DISPOSITION_MODIFIERS := wbUnion('Disp Modifiers', ChangedFlag19Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_EXTRA_DISMEMBERED_LIMBS := wbUnion('Dismembered Limbs', ChangedFlag17Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_EXTRA_MERCHANT_CONTAINER := wbUnion('Merchant Container', ChangedFlag12Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_EXTRA_PACKAGE_DATA := wbUnion('Package Data Extra', ChangedFlag11Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_LEVELED_ACTOR := wbUnion('Leveled Actor', ChangedFlag18Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_LIFESTATE := wbUnion('Life State', ChangedFlag10Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_OVERRIDE_MODIFIERS := wbUnion('Override Modifiers', ChangedFlag22Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_PERMANENT_MODIFIERS := wbUnion('Permanent Modifiers', ChangedFlag23Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ACTOR_TEMP_MODIFIERS := wbUnion('Temp Modifiers', ChangedFlag20Decider, [wbNull, wbNull]);
  wbUnionCHANGE_BASE_OBJECT_FULLNAME := wbUnion('Object Full Name', ChangedFlag02Decider, [wbNull, wbNull]);
  wbUnionCHANGE_BASE_OBJECT_VALUE := wbUnion('Object Value', ChangedFlag01Decider, [wbNull, wbNull]);
  wbUnionCHANGE_BOOK_READ := wbUnion('Read', ChangedFlag06Decider, [wbNull, wbNull]);
  wbUnionCHANGE_BOOK_TEACHES := wbUnion('Teaches Skill', ChangedFlag05Decider, [wbNull, wbNull]);
  wbUnionCHANGE_CELL_DETACHTIME := wbUnion('Detach Time', ChangedFlag30Decider, [wbNull, wbNull]);
  wbUnionCHANGE_CELL_EXTERIOR_CHAR := wbUnion('Exterior Char', ChangedFlag29Decider, [wbNull, wbNull]);
  wbUnionCHANGE_CELL_EXTERIOR_SHORT := wbUnion('Exterior Short', ChangedFlag28Decider, [wbNull, wbNull]);
  wbUnionCHANGE_CELL_FLAGS := wbUnion('Flags', ChangedFlag01Decider, [wbNull, wbNull]);
  wbUnionCHANGE_CELL_FULLNAME := wbUnion('Full name', ChangedFlag02Decider, [wbNull, wbNull]);
  wbUnionCHANGE_CELL_OWNERSHIP := wbUnion('Ownership', ChangedFlag03Decider, [wbNull, wbNull]);
  wbUnionCHANGE_CELL_SEENDATA := wbUnion('Seen Data', ChangedFlag31Decider, [wbNull, wbNull]);
  wbUnionCHANGE_CLASS_TAG_SKILLS := wbUnion('Tag Skills', ChangedFlag01Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ENCOUNTER_ZONE_FLAGS := wbUnion('Zone Flags', ChangedFlag01Decider, [wbNull, wbNull]);
  wbUnionCHANGE_ENCOUNTER_ZONE_GAME_DATA := wbUnion('Game Data', ChangedFlag31Decider, [wbNull, wbNull]);
  wbUnionCHANGE_FACTION_CRIME_COUNTS := wbUnion('Faction Crime Counts', ChangedFlag31Decider, [wbNull, wbNull]);
  wbUnionCHANGE_FACTION_FLAGS := wbUnion('Faction Flags', ChangedFlag01Decider, [wbNull, wbNull]);
  wbUnionCHANGE_FACTION_REACTIONS := wbUnion('Faction Reactions', ChangedFlag02Decider, [wbNull, wbNull]);
  wbUnionCHANGE_FORM_FLAGS := wbUnion('Flags', ChangedFlag00Decider, [wbNull, wbNull]);
  wbUnionCHANGE_FORM_LIST_ADDED_FORM := wbUnion('Added Form', ChangedFlag31Decider, [wbNull, wbArray('Forms', wbRefID('RefID'), -1)]);
  wbUnionCHANGE_INGREDIENT_USE := wbUnion('Ingredient Use', ChangedFlag31Decider, [wbNull, wbNull]);
  wbUnionCHANGE_LEVELED_LIST_ADDED_OBJECT := wbUnion('Added Object', ChangedFlag31Decider, [wbNull, wbNull]);
  wbUnionCHANGE_LOCATION_CLEARED := wbUnion('Cleared', ChangedFlag31Decider, [wbNull, wbNull]);
  wbUnionCHANGE_LOCATION_KEYWORDDATA := wbUnion('KeywordData', ChangedFlag30Decider, [wbNull, wbNull]);
  wbUnionCHANGE_NOTE_READ := wbUnion('Note Read', ChangedFlag31Decider, [wbNull, wbNull]);
  wbUnionCHANGE_NPC_BODY_SCALES := wbUnion('Body Scales', ChangedFlag14Decider, [wbNull, wbNull]);
  wbUnionCHANGE_NPC_CLASS := wbUnion('Class', ChangedFlag10Decider, [wbNull, wbNull]);
  wbUnionCHANGE_NPC_DEFAULT_OUTFIT := wbUnion('Default Outfit', ChangedFlag12Decider, [wbNull, wbNull]);
  wbUnionCHANGE_NPC_FACE := wbUnion('Face', ChangedFlag11Decider, [wbNull, wbNull]);
  wbUnionCHANGE_NPC_GENDER := wbUnion('Gender', ChangedFlag24Decider, [wbNull, wbNull]);
  wbUnionCHANGE_NPC_RACE := wbUnion('Race', ChangedFlag25Decider, [wbNull, wbNull]);
  wbUnionCHANGE_NPC_SKILLS := wbUnion('NPC Skills', ChangedFlag09Decider, [wbNull, wbNull]);
  wbUnionCHANGE_NPC_SLEEP_OUTFIT := wbUnion('Sleep Outfit', ChangedFlag13Decider, [wbNull, wbNull]);
  wbUnionCHANGE_OBJECT_EMPTY := wbUnion('Empty', ChangedFlag21Decider, [wbNull, wbNull]);
  wbUnionCHANGE_OBJECT_EXTRA_AMMO := wbUnion('Ammo Extra', ChangedFlag11Decider, [wbNull, wbNull]);
  wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA := wbUnion('Item Data Extra', ChangedFlag10Decider, [wbNull, wbNull]);
  wbUnionCHANGE_OBJECT_EXTRA_LOCK := wbUnion('Lock Extra', ChangedFlag12Decider, [wbNull, wbNull]);
  wbUnionCHANGE_OBJECT_EXTRA_WORKSHOP := wbUnion('Workshop Extra', ChangedFlag09Decider, [wbNull, wbNull]);
  wbUnionCHANGE_OBJECT_FORCE_MOVE := wbUnion('Force Move', ChangedFlag13Decider, [wbNull, wbNull]);
  wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE := wbUnion('Open Default State', ChangedFlag22Decider, [wbNull, wbNull]);
  wbUnionCHANGE_OBJECT_OPEN_STATE := wbUnion('Open State', ChangedFlag23Decider, [wbNull, wbNull]);
  wbUnionCHANGE_PACKAGE_NEVER_RUN := wbUnion('Never Run Flag', ChangedFlag31Decider, [wbNull, wbNull]);
  wbUnionCHANGE_PACKAGE_WAITING := wbUnion('Waiting Flag', ChangedFlag30Decider, [wbNull, wbNull]);
  wbUnionCHANGE_QUEST_ALREADY_RUN := wbUnion('Quest Already Run', ChangedFlag26Decider, [wbNull, wbNull]);
  wbUnionCHANGE_QUEST_FLAGS := wbUnion('Quest Flags', ChangedFlag01Decider, [wbNull, wbNull]);
  wbUnionCHANGE_QUEST_INSTANCES := wbUnion('Quest Instance Data', ChangedFlag27Decider, [wbNull, wbNull]);
  wbUnionCHANGE_QUEST_NODE_TIME_RUN := wbUnion('Time Last Run', ChangedFlag31Decider, [wbNull, wbNull]);
  wbUnionCHANGE_QUEST_OBJECTIVES := wbUnion('Quest Objectives', ChangedFlag29Decider, [wbNull, wbNull]);
  wbUnionCHANGE_QUEST_RUNDATA := wbUnion('Quest Runtime Data', ChangedFlag28Decider, [wbNull, wbNull]);
  wbUnionCHANGE_QUEST_SCRIPT := wbUnion('Quest Script', ChangedFlag30Decider, [wbNull, wbNull]);
  wbUnionCHANGE_QUEST_SCRIPT_DELAY := wbUnion('Quest Script Delay', ChangedFlag02Decider, [wbNull, wbNull]);
  wbUnionCHANGE_QUEST_STAGES := wbUnion('Quest Stages', ChangedFlag31Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_ANIMATION := wbUnion('Animation', ChangedFlag28Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_BASEOBJECT := wbUnion('BaseObject', ChangedFlag07Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_CELL_CHANGED := wbUnion('Cell Changed', ChangedFlag03Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN := wbUnion('Activating Children', ChangedFlag26Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY := wbUnion('Created Only Extra', ChangedFlag30Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE := wbUnion('Enc Zone Extra', ChangedFlag29Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_EXTRA_GAME_ONLY := wbUnion('Game Only Extra', ChangedFlag31Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_EXTRA_LINK_REF := wbUnion('Link Ref Extra', ChangedFlag08Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_EXTRA_OWNERSHIP := wbUnion('Ownership Extra', ChangedFlag06Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_HAVOK_MOVE := wbUnion('Havok Moved', ChangedFlag02Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_INVENTORY := wbUnion('Inventory', ChangedFlag05Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_LEVELED_INVENTORY := wbUnion('Leveled Inventory', ChangedFlag27Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_MOVE := wbUnion('Moved', ChangedFlag01Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_PROMOTED := wbUnion('Promoted', ChangedFlag25Decider, [wbNull, wbNull]);
  wbUnionCHANGE_REFR_SCALE := wbUnion('Scale', ChangedFlag04Decider, [wbNull, wbNull]);
  wbUnionCHANGE_RELATIONSHIP_DATA := wbUnion('Relationship Data', ChangedFlag01Decider, [wbNull, wbNull]);
  wbUnionCHANGE_SCENE_ACTIVE := wbUnion('Active', ChangedFlag31Decider, [wbNull, wbNull]);
  wbUnionCHANGE_TALKING_ACTIVATOR_SPEAKER := wbUnion('Speaker', ChangedFlag23Decider, [wbNull, wbNull]);
  wbUnionCHANGE_TOPIC_SAIDONCE := wbUnion('Said Once', ChangedFlag31Decider, [wbNull, wbNull]);

  wbChangedFormData := wbStruct('Changed Form Data', [
    wbInitialDataType,
    wbUnion('CForm Union', ChangedFormDataDecider, [
       wbNull
      ,wbStruct('Change REFR Data', [ {040}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_REFR_MOVE
        ,wbUnionCHANGE_REFR_HAVOK_MOVE
        ,wbUnionCHANGE_REFR_CELL_CHANGED
        ,wbUnionCHANGE_REFR_SCALE
        ,wbUnionCHANGE_REFR_INVENTORY
        ,wbUnionCHANGE_REFR_EXTRA_OWNERSHIP
        ,wbUnionCHANGE_REFR_BASEOBJECT
        ,wbUnionCHANGE_REFR_EXTRA_LINK_REF
        ,wbUnionCHANGE_OBJECT_EXTRA_WORKSHOP
        ,wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA
        ,wbUnionCHANGE_OBJECT_EXTRA_AMMO
        ,wbUnionCHANGE_OBJECT_EXTRA_LOCK
        ,wbUnionCHANGE_OBJECT_FORCE_MOVE
        ,wbUnionCHANGE_OBJECT_EMPTY
        ,wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE
        ,wbUnionCHANGE_OBJECT_OPEN_STATE
        ,wbUnionCHANGE_REFR_PROMOTED
        ,wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN
        ,wbUnionCHANGE_REFR_LEVELED_INVENTORY
        ,wbUnionCHANGE_REFR_ANIMATION
        ,wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE
        ,wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY
        ,wbUnionCHANGE_REFR_EXTRA_GAME_ONLY
       ])
      ,wbStruct('Change ACHR Data', [ {041}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_REFR_MOVE
        ,wbUnionCHANGE_REFR_HAVOK_MOVE
        ,wbUnionCHANGE_REFR_CELL_CHANGED
        ,wbUnionCHANGE_REFR_SCALE
        ,wbUnionCHANGE_REFR_INVENTORY
        ,wbUnionCHANGE_REFR_EXTRA_OWNERSHIP
        ,wbUnionCHANGE_REFR_BASEOBJECT
        ,wbUnionCHANGE_REFR_EXTRA_LINK_REF
        ,wbUnionCHANGE_OBJECT_EXTRA_WORKSHOP
        ,wbUnionCHANGE_ACTOR_LIFESTATE
        ,wbUnionCHANGE_ACTOR_EXTRA_PACKAGE_DATA
        ,wbUnionCHANGE_ACTOR_EXTRA_MERCHANT_CONTAINER
        ,wbUnionCHANGE_ACTOR_EXTRA_DISMEMBERED_LIMBS
        ,wbUnionCHANGE_ACTOR_LEVELED_ACTOR
        ,wbUnionCHANGE_ACTOR_DISPOSITION_MODIFIERS
        ,wbUnionCHANGE_ACTOR_TEMP_MODIFIERS
        ,wbUnionCHANGE_ACTOR_DAMAGE_MODIFIERS
        ,wbUnionCHANGE_ACTOR_OVERRIDE_MODIFIERS
        ,wbUnionCHANGE_ACTOR_PERMANENT_MODIFIERS
        ,wbUnionCHANGE_REFR_PROMOTED
        ,wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN
        ,wbUnionCHANGE_REFR_LEVELED_INVENTORY
        ,wbUnionCHANGE_REFR_ANIMATION
        ,wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE
        ,wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY
        ,wbUnionCHANGE_REFR_EXTRA_GAME_ONLY
       ])
      ,wbStruct('Change PMIS Data', [ {042}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_REFR_MOVE
        ,wbUnionCHANGE_REFR_HAVOK_MOVE
        ,wbUnionCHANGE_REFR_CELL_CHANGED
        ,wbUnionCHANGE_REFR_SCALE
        ,wbUnionCHANGE_REFR_INVENTORY
        ,wbUnionCHANGE_REFR_EXTRA_OWNERSHIP
        ,wbUnionCHANGE_REFR_BASEOBJECT
        ,wbUnionCHANGE_REFR_EXTRA_LINK_REF
        ,wbUnionCHANGE_OBJECT_EXTRA_WORKSHOP
        ,wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA
        ,wbUnionCHANGE_OBJECT_EXTRA_AMMO
        ,wbUnionCHANGE_OBJECT_EXTRA_LOCK
        ,wbUnionCHANGE_OBJECT_FORCE_MOVE
        ,wbUnionCHANGE_OBJECT_EMPTY
        ,wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE
        ,wbUnionCHANGE_OBJECT_OPEN_STATE
        ,wbUnionCHANGE_REFR_PROMOTED
        ,wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN
        ,wbUnionCHANGE_REFR_LEVELED_INVENTORY
        ,wbUnionCHANGE_REFR_ANIMATION
        ,wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE
        ,wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY
        ,wbUnionCHANGE_REFR_EXTRA_GAME_ONLY
       ])
      ,wbStruct('Change PGRE Data', [ {044}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_REFR_MOVE
        ,wbUnionCHANGE_REFR_HAVOK_MOVE
        ,wbUnionCHANGE_REFR_CELL_CHANGED
        ,wbUnionCHANGE_REFR_SCALE
        ,wbUnionCHANGE_REFR_INVENTORY
        ,wbUnionCHANGE_REFR_EXTRA_OWNERSHIP
        ,wbUnionCHANGE_REFR_BASEOBJECT
        ,wbUnionCHANGE_REFR_EXTRA_LINK_REF
        ,wbUnionCHANGE_OBJECT_EXTRA_WORKSHOP
        ,wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA
        ,wbUnionCHANGE_OBJECT_EXTRA_AMMO
        ,wbUnionCHANGE_OBJECT_EXTRA_LOCK
        ,wbUnionCHANGE_OBJECT_FORCE_MOVE
        ,wbUnionCHANGE_OBJECT_EMPTY
        ,wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE
        ,wbUnionCHANGE_OBJECT_OPEN_STATE
        ,wbUnionCHANGE_REFR_PROMOTED
        ,wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN
        ,wbUnionCHANGE_REFR_LEVELED_INVENTORY
        ,wbUnionCHANGE_REFR_ANIMATION
        ,wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE
        ,wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY
        ,wbUnionCHANGE_REFR_EXTRA_GAME_ONLY
       ])
      ,wbStruct('Change PBEA Data', [ {045}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_REFR_MOVE
        ,wbUnionCHANGE_REFR_HAVOK_MOVE
        ,wbUnionCHANGE_REFR_CELL_CHANGED
        ,wbUnionCHANGE_REFR_SCALE
        ,wbUnionCHANGE_REFR_INVENTORY
        ,wbUnionCHANGE_REFR_EXTRA_OWNERSHIP
        ,wbUnionCHANGE_REFR_BASEOBJECT
        ,wbUnionCHANGE_REFR_EXTRA_LINK_REF
        ,wbUnionCHANGE_OBJECT_EXTRA_WORKSHOP
        ,wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA
        ,wbUnionCHANGE_OBJECT_EXTRA_AMMO
        ,wbUnionCHANGE_OBJECT_EXTRA_LOCK
        ,wbUnionCHANGE_OBJECT_FORCE_MOVE
        ,wbUnionCHANGE_OBJECT_EMPTY
        ,wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE
        ,wbUnionCHANGE_OBJECT_OPEN_STATE
        ,wbUnionCHANGE_REFR_PROMOTED
        ,wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN
        ,wbUnionCHANGE_REFR_LEVELED_INVENTORY
        ,wbUnionCHANGE_REFR_ANIMATION
        ,wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE
        ,wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY
        ,wbUnionCHANGE_REFR_EXTRA_GAME_ONLY
       ])
      ,wbStruct('Change PFLA Data', [ {046}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_REFR_MOVE
        ,wbUnionCHANGE_REFR_HAVOK_MOVE
        ,wbUnionCHANGE_REFR_CELL_CHANGED
        ,wbUnionCHANGE_REFR_SCALE
        ,wbUnionCHANGE_REFR_INVENTORY
        ,wbUnionCHANGE_REFR_EXTRA_OWNERSHIP
        ,wbUnionCHANGE_REFR_BASEOBJECT
        ,wbUnionCHANGE_REFR_EXTRA_LINK_REF
        ,wbUnionCHANGE_OBJECT_EXTRA_WORKSHOP
        ,wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA
        ,wbUnionCHANGE_OBJECT_EXTRA_AMMO
        ,wbUnionCHANGE_OBJECT_EXTRA_LOCK
        ,wbUnionCHANGE_OBJECT_FORCE_MOVE
        ,wbUnionCHANGE_OBJECT_EMPTY
        ,wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE
        ,wbUnionCHANGE_OBJECT_OPEN_STATE
        ,wbUnionCHANGE_REFR_PROMOTED
        ,wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN
        ,wbUnionCHANGE_REFR_LEVELED_INVENTORY
        ,wbUnionCHANGE_REFR_ANIMATION
        ,wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE
        ,wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY
        ,wbUnionCHANGE_REFR_EXTRA_GAME_ONLY
       ])
      ,wbStruct('Change CELL Data', [ {03F}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_CELL_FLAGS
        ,wbUnionCHANGE_CELL_FULLNAME
        ,wbUnionCHANGE_CELL_OWNERSHIP
        ,wbUnionCHANGE_CELL_EXTERIOR_SHORT
        ,wbUnionCHANGE_CELL_EXTERIOR_CHAR
        ,wbUnionCHANGE_CELL_DETACHTIME
        ,wbUnionCHANGE_CELL_SEENDATA
       ])
      ,wbStruct('Change INFO Data', [ {04F}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_TOPIC_SAIDONCE
       ])
      ,wbStruct('Change QUST Data', [ {050}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_QUEST_FLAGS
        ,wbUnionCHANGE_QUEST_SCRIPT_DELAY
        ,wbUnionCHANGE_QUEST_ALREADY_RUN
        ,wbUnionCHANGE_QUEST_INSTANCES
        ,wbUnionCHANGE_QUEST_RUNDATA
        ,wbUnionCHANGE_QUEST_OBJECTIVES
        ,wbUnionCHANGE_QUEST_SCRIPT
        ,wbUnionCHANGE_QUEST_STAGES
       ])
      ,wbStruct('Change NPC_ Data', [ {02D}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_ACTOR_BASE_DATA
        ,wbUnionCHANGE_ACTOR_BASE_ATTRIBUTES
        ,wbUnionCHANGE_ACTOR_BASE_AIDATA
        ,wbUnionCHANGE_ACTOR_BASE_SPELLLIST
        ,wbUnionCHANGE_ACTOR_BASE_FULLNAME
        ,wbUnionCHANGE_ACTOR_BASE_FACTIONS
        ,wbUnionCHANGE_NPC_SKILLS
        ,wbUnionCHANGE_NPC_CLASS
        ,wbUnionCHANGE_NPC_FACE
        ,wbUnionCHANGE_NPC_DEFAULT_OUTFIT
        ,wbUnionCHANGE_NPC_SLEEP_OUTFIT
        ,wbUnionCHANGE_NPC_BODY_SCALES
        ,wbUnionCHANGE_NPC_GENDER
        ,wbUnionCHANGE_NPC_RACE
       ])
      ,wbStruct('Change ACTI Data', [ {01B}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change TACT Data', [ {01C}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
        ,wbUnionCHANGE_TALKING_ACTIVATOR_SPEAKER
       ])
      ,wbStruct('Change ARMO Data', [ {01D}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change BOOK Data', [ {01E}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
        ,wbUnionCHANGE_BOOK_TEACHES
        ,wbUnionCHANGE_BOOK_READ
       ])
      ,wbStruct('Change CONT Data', [ {01F}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change DOOR Data', [ {020}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change INGR Data', [ {021}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_INGREDIENT_USE
       ])
      ,wbStruct('Change LIGH Data', [ {022}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change MISC Data', [ {023}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change STAT Data', [ {024}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change MSTT Data', [ {026}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change FURN Data', [ {02A}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change WEAP Data', [ {02B}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change AMMO Data', [ {02C}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change KEYM Data', [ {02F}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change ALCH Data', [ {030}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change IDLM Data', [ {031}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change NOTE Data', [ {032}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_NOTE_READ
       ])
      ,wbStruct('Change ECZN Data', [ {06A}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_ENCOUNTER_ZONE_FLAGS
        ,wbUnionCHANGE_ENCOUNTER_ZONE_GAME_DATA
       ])
      ,wbStruct('Change CLAS Data', [ {00D}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_CLASS_TAG_SKILLS
       ])
      ,wbStruct('Change FACT Data', [ {00E}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_FACTION_FLAGS
        ,wbUnionCHANGE_FACTION_REACTIONS
        ,wbUnionCHANGE_FACTION_CRIME_COUNTS
       ])
      ,wbStruct('Change PACK Data', [ {052}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_PACKAGE_WAITING
        ,wbUnionCHANGE_PACKAGE_NEVER_RUN
       ])
      ,wbStruct('Change NAVM Data', [ {04C}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change WOOP Data', [ {07A}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change MGEF Data', [ {015}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change SMQN Data', [ {075}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_QUEST_NODE_TIME_RUN
       ])
      ,wbStruct('Change SCEN Data', [ {07E}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_SCENE_ACTIVE
       ])
      ,wbStruct('Change LCTN Data', [ {06B}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_LOCATION_KEYWORDDATA
        ,wbUnionCHANGE_LOCATION_CLEARED
       ])
      ,wbStruct('Change RELA Data', [ {07D}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_RELATIONSHIP_DATA
       ])
      ,wbStruct('Change PHZD Data', [ {049}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_REFR_MOVE
        ,wbUnionCHANGE_REFR_HAVOK_MOVE
        ,wbUnionCHANGE_REFR_CELL_CHANGED
        ,wbUnionCHANGE_REFR_SCALE
        ,wbUnionCHANGE_REFR_INVENTORY
        ,wbUnionCHANGE_REFR_EXTRA_OWNERSHIP
        ,wbUnionCHANGE_REFR_BASEOBJECT
        ,wbUnionCHANGE_REFR_EXTRA_LINK_REF
        ,wbUnionCHANGE_OBJECT_EXTRA_WORKSHOP
        ,wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA
        ,wbUnionCHANGE_OBJECT_EXTRA_AMMO
        ,wbUnionCHANGE_OBJECT_EXTRA_LOCK
        ,wbUnionCHANGE_OBJECT_FORCE_MOVE
        ,wbUnionCHANGE_OBJECT_EMPTY
        ,wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE
        ,wbUnionCHANGE_OBJECT_OPEN_STATE
        ,wbUnionCHANGE_REFR_PROMOTED
        ,wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN
        ,wbUnionCHANGE_REFR_LEVELED_INVENTORY
        ,wbUnionCHANGE_REFR_ANIMATION
        ,wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE
        ,wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY
        ,wbUnionCHANGE_REFR_EXTRA_GAME_ONLY
       ])
      ,wbStruct('Change PBAR Data', [ {048}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_REFR_MOVE
        ,wbUnionCHANGE_REFR_HAVOK_MOVE
        ,wbUnionCHANGE_REFR_CELL_CHANGED
        ,wbUnionCHANGE_REFR_SCALE
        ,wbUnionCHANGE_REFR_INVENTORY
        ,wbUnionCHANGE_REFR_EXTRA_OWNERSHIP
        ,wbUnionCHANGE_REFR_BASEOBJECT
        ,wbUnionCHANGE_REFR_EXTRA_LINK_REF
        ,wbUnionCHANGE_OBJECT_EXTRA_WORKSHOP
        ,wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA
        ,wbUnionCHANGE_OBJECT_EXTRA_AMMO
        ,wbUnionCHANGE_OBJECT_EXTRA_LOCK
        ,wbUnionCHANGE_OBJECT_FORCE_MOVE
        ,wbUnionCHANGE_OBJECT_EMPTY
        ,wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE
        ,wbUnionCHANGE_OBJECT_OPEN_STATE
        ,wbUnionCHANGE_REFR_PROMOTED
        ,wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN
        ,wbUnionCHANGE_REFR_LEVELED_INVENTORY
        ,wbUnionCHANGE_REFR_ANIMATION
        ,wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE
        ,wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY
        ,wbUnionCHANGE_REFR_EXTRA_GAME_ONLY
       ])
      ,wbStruct('Change PCON Data', [ {047}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_REFR_MOVE
        ,wbUnionCHANGE_REFR_HAVOK_MOVE
        ,wbUnionCHANGE_REFR_CELL_CHANGED
        ,wbUnionCHANGE_REFR_SCALE
        ,wbUnionCHANGE_REFR_INVENTORY
        ,wbUnionCHANGE_REFR_EXTRA_OWNERSHIP
        ,wbUnionCHANGE_REFR_BASEOBJECT
        ,wbUnionCHANGE_REFR_EXTRA_LINK_REF
        ,wbUnionCHANGE_OBJECT_EXTRA_WORKSHOP
        ,wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA
        ,wbUnionCHANGE_OBJECT_EXTRA_AMMO
        ,wbUnionCHANGE_OBJECT_EXTRA_LOCK
        ,wbUnionCHANGE_OBJECT_FORCE_MOVE
        ,wbUnionCHANGE_OBJECT_EMPTY
        ,wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE
        ,wbUnionCHANGE_OBJECT_OPEN_STATE
        ,wbUnionCHANGE_REFR_PROMOTED
        ,wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN
        ,wbUnionCHANGE_REFR_LEVELED_INVENTORY
        ,wbUnionCHANGE_REFR_ANIMATION
        ,wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE
        ,wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY
        ,wbUnionCHANGE_REFR_EXTRA_GAME_ONLY
       ])
      ,wbStruct('Change FLST Data', [ {05E}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_FORM_LIST_ADDED_FORM
       ])
      ,wbStruct('Change LVLN Data', [ {02E}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_LEVELED_LIST_ADDED_OBJECT
       ])
      ,wbStruct('Change LVLI Data', [ {038}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_LEVELED_LIST_ADDED_OBJECT
       ])
      ,wbStruct('Change LVSP Data', [ {055}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_LEVELED_LIST_ADDED_OBJECT
       ])
      ,wbStruct('Change PARW Data', [ {043}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_REFR_MOVE
        ,wbUnionCHANGE_REFR_HAVOK_MOVE
        ,wbUnionCHANGE_REFR_CELL_CHANGED
        ,wbUnionCHANGE_REFR_SCALE
        ,wbUnionCHANGE_REFR_INVENTORY
        ,wbUnionCHANGE_REFR_EXTRA_OWNERSHIP
        ,wbUnionCHANGE_REFR_BASEOBJECT
        ,wbUnionCHANGE_REFR_EXTRA_LINK_REF
        ,wbUnionCHANGE_OBJECT_EXTRA_WORKSHOP
        ,wbUnionCHANGE_OBJECT_EXTRA_ITEM_DATA
        ,wbUnionCHANGE_OBJECT_EXTRA_AMMO
        ,wbUnionCHANGE_OBJECT_EXTRA_LOCK
        ,wbUnionCHANGE_OBJECT_FORCE_MOVE
        ,wbUnionCHANGE_OBJECT_EMPTY
        ,wbUnionCHANGE_OBJECT_OPEN_DEFAULT_STATE
        ,wbUnionCHANGE_OBJECT_OPEN_STATE
        ,wbUnionCHANGE_REFR_PROMOTED
        ,wbUnionCHANGE_REFR_EXTRA_ACTIVATING_CHILDREN
        ,wbUnionCHANGE_REFR_LEVELED_INVENTORY
        ,wbUnionCHANGE_REFR_ANIMATION
        ,wbUnionCHANGE_REFR_EXTRA_ENCOUNTER_ZONE
        ,wbUnionCHANGE_REFR_EXTRA_CREATED_ONLY
        ,wbUnionCHANGE_REFR_EXTRA_GAME_ONLY
       ])
      ,wbStruct('Change ENCH Data', [ {018}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change TERM Data', [ {037}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_BASE_OBJECT_VALUE
        ,wbUnionCHANGE_BASE_OBJECT_FULLNAME
       ])
      ,wbStruct('Change INNR Data', [ {093}
         wbUnionCHANGE_FORM_FLAGS
        ,wbUnionCHANGE_INR_MERGE_TARGET
       ])
    ]),
    wbByteArray('Undecoded Data', ChangedFormRemainingDataCounter)
  ]);

  wbChangedForm := wbStructC('Changed Form',
    ChangedFormSizer,
    ChangedFormGetChapterType,
    ChangedFormGetChapterTypeName,
    ChangedFormGetChapterName,
    [
      wbRefID('RefID'),
      wbChangeFlags,
      wbInteger('Type', itU8, wbChangeTypes),
      wbInteger('Version', itU8),
      wbUnion('Datas', ChangedFormDataLengthDecider, [
        wbStruct('CForm Data', [
          wbInteger('Length', itU8),
          wbInteger('Uncompressed Length', itU8),   // added post save game version 50
          wbStructZ('Small Struct', ChangedFormDataSizer, ChangedFormGetChapterType, ChangedFormGetChapterTypeName, nil,
            [ wbChangedFormData ])
        ]),
        wbStruct('CForm Data', [
          wbInteger('Length', itU16),
          wbInteger('Uncompressed Length', itU16),
          wbStructZ('Medium Struct', ChangedFormDataSizer, ChangedFormGetChapterType, ChangedFormGetChapterTypeName, nil,
            [ wbChangedFormData ])
        ]),
        wbStruct('CForm Data', [
          wbInteger('Length', itU32),
          wbInteger('Uncompressed Length', itU32),
          wbStructZ('Large Struct', ChangedFormDataSizer, ChangedFormGetChapterType, ChangedFormGetChapterTypeName, nil,
            [ wbChangedFormData ])
        ]),
        wbUnknown() // If the type is invalid
      ])
    ]);

  wbHeader := wbStruct('Header', [
    wbInteger('Version', itU32),
    wbInteger('Save Number', itU32),
    wbLenString('Player Name', 2),
    wbInteger('Player Level', itU32),
    wbLenString('Save Cell', 2),
    wbLenString('Save Duration', 2),
    wbLenString('Player Race Editor ID', 2),
    wbInteger('Player Sex', itU16, wbSexEnum),
    wbFloat('Player Current Experience'),
    wbFloat('Player LevelUp Experience'),
    wbByteArray('Save Time', 8),
    wbInteger('Screenshot Width', itU32),
    wbInteger('Screenshot Height', itU32)
  ]);

  wbFileLocationTable := wbStruct('File Location Table', [
    wbInteger('RefID Array Count Offset', itU32),
    wbInteger('Unknown Table Offset', itU32),
    wbInteger('Global Data Table 1 Offset', itU32),
    wbInteger('Global Data Table 2 Offset', itU32),
    wbInteger('Changed Forms Offset', itU32),
    wbInteger('Global Data Table 3 Offset', itU32),
    wbInteger('Global Data Table 1 Count', itU32),
    wbInteger('Global Data Table 2 Count', itU32),
    wbInteger('Global Data Table 3 Count', itU32),
    wbInteger('Changed Forms Count', itU32),
    wbByteArray('Unused', 15 * 4)
  ]);

  wbSaveHeader := wbStruct('Save File Header', [
     wbString('Magic', 12)
    ,wbInteger('Header Size', itU32)
    ,wbHeader
    ,wbByteArray('Hidden: Screenshot Data', ScreenShotDataCounter)
    ,wbInteger('Form Version', itU8)
    ,wbLenString('Runtime version', 2)
    ,wbInteger('PluginInfo Size (?)', itU32)
    ,wbArray(wbFilePlugins, wbLenString('PluginName', 2), -4)
    ,wbUnion('', SaveVersionGreaterThan14Decider, [wbNull, wbArray('Light plugins', wbLenString('LightPluginName', 2), -2)])
    ,wbFileLocationTable
  ]);

  wbSaveChapters := wbStruct('Save File Chapters', [
     wbArray('Global Data 1', wbGlobalData, [], GlobalData1Counter)
    ,wbArray('Global Data 2', wbGlobalData, [], GlobalData2Counter)
    ,wbArray('Changed Forms', wbChangedForm, [], ChangedFormsCounter)
    ,wbArray('Global Data 3', wbGlobalData, [], GlobalData3Counter)
    ,wbArray('FormIDs', wbFormID('FormID', cpFormID), -1, RefIDTableAfterLoad)
    ,wbArray('Visited Worldspace', wbFormID('FormID', cpFormID), -1, WorldspaceTableAfterLoad)
    ,wbInteger('Unknown Table Size', itU32)
    ,wbArray('Unknown Table', wbLenString('Unknown', 2), -1)
//    ,wbByteArray('Unused', SkipCounter) // Lets you skip an arbitrary number of byte, Setable from CommandLine -bts:n
//    ,wbArray('Remaining',  WbByteArray('Unknown', wbBytesToGroup), DumpCounter) // Lets you dump an arbitrary number of quartet, Setable from CommandLine -btd:n
  ]);

  wbCoSaveHeader := wbStruct('CoSave File Header', [
     wbString('Magic', 4)
    ,wbInteger('Version', itU32)
    ,wbInteger('F4SE Version', itU16)
    ,wbInteger('F4SE Minor Version', itU16)
    ,wbInteger('Fallout Version', itU32)
    ,wbInteger('Plugins count', itU32)
  ]);

  wbCoSaveChunk := wbStructC('Chunk', nil, wbCoSaveChunkType, wbCoSaveChunkTypeName, nil, [
    wbInteger('Type', itU32, wbStr4),
    wbInteger('Version', itU32),
    wbInteger('Length', itU32),
    wbUnion('Data', F4SEChaptersDecider, [
      wbNull,
      wbArray('Modules', wbLenString('PluginName', 2), -4),
      wbArray('Light Modules', wbLenString('Light PluginName', 2), -2),
      wbStruct('Registered Event', [
        wbUnion('Key', F4SERegKeyDecider, [
          wbNull,
          wbLenString('String Key', -2),
          wbInteger('Numeric Key', itU32),
          wbNull
        ]),
        wbArray('Regs', wbStruct('Reg', [
          wbInteger('Handle', itU64),
          wbUnion('Data', F4SERegDataDecider, [
           wbNull,
           wbLenString('Callback', -2)
          ])
        ]), -1)
      ]),
      wbNull,  // REGE Registered Event End
      wbNull,  // MENR Menu Event Registration
      wbNull,  // KEYR Key Event Registration
      wbNull,  // CTLR Control Event Registration
      wbNull,  // MCBR Mod Callback Event Registration
      wbArray('Crosshair refs', wbInteger('Crosshair ref handle', itU64), -1),  // CHRR Crosshair Ref Event Registration
      wbArray('Cameras', wbInteger('Camera handle', itU64), -1),  // CAMR Camera Event Registration
      wbNull,  // AACT Actor Action Event Registration
      wbByteArray('Others', wbCoSaveChapterOtherCounter)  // For what we cannot hardcode
    ])
  ]);
//  wbCoSaveChunk.TreeLeaf := True;

  wbCoSaveChunks := wbArray('Chunks', wbCoSaveChunk, wbCoSaveChunkCounter, cpNormal, false, wbDontShowBranch);
  wbCoSavePlugin := wbStructC('Plugin', nil, wbCoSaveArrayType, wbCoSaveArrayTypeName, nil, [
    wbInteger('UID', itU32),
    wbInteger('Chunks count', itU32),
    wbInteger('Length', itU32),
    wbCoSaveChunks
  ]);
//  wbCoSavePlugin.TreeLeaf := True;
  wbCoSaveChunks.TreeBranch := True;
  wbCoSavePlugins := wbArray('Plugins', wbCoSavePlugin, wbCoSavePluginCounter);

  wbCoSaveChapters := wbStruct('CoSave File Chapters', [
    wbCoSavePlugins
  ]);

  wbFileChapters := wbSaveChapters;
  wbFileHeader := wbSaveHeader;
  wbSaveHeader.TreeHead := True;
  wbCoSaveHeader.TreeHead := True;
//  wbSaveHeader.TreeLeaf := True;
//  wbCoSaveHeader.TreeLeaf := True;
end;

var
  ExtractInfoSave:   TByteSet = [4, 5]; // SaveFileChapters that should be initialized before dumping to get more information
  ExtractInfoCoSave: TByteSet = [];     // CoSaveFileChapters that should be initialized before dumping to get more information

procedure DefineFO4Saves;
begin
  wbFileMagic := 'FO4_SAVEGAME';
  wbExtractInfo := @ExtractInfoSave;
  wbFilePlugins := 'Plugins';
  DefineFO4;
  DefineFO4SavesA;
  DefineFO4SavesS;
end;

procedure SwitchToFO4CoSave;
begin
  wbFileMagic := 'F4SE';
  wbExtractInfo := @ExtractInfoCoSave;
  wbFilePlugins := 'Absolute:44';
  wbFileChapters := wbCoSaveChapters;
  wbFileHeader := wbCoSaveHeader;
end;

initialization
end.
