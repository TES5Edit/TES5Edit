{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbDefinitionsFO4;

{$I wbDefines.inc}

interface

uses
  wbInterface;

var
  wbBipedObjectFlags: IwbFlagsDef;
  wbEquipType: IwbFlagsDef;
  wbPKDTInterruptFlags: IwbFlagsDef;

  wbActorBehaviorEnum: IwbEnumDef;
  wbActorPropertyEnum: IwbEnumDef;
  wbAdvanceActionEnum: IwbEnumDef;
  wbStaggerEnum: IwbEnumDef;
  wbArmorPropertyEnum: IwbEnumDef;
  wbBipedObjectEnum: IwbEnumDef;
  wbCastEnum: IwbEnumDef;
  wbCastingSourceEnum: IwbEnumDef;
  wbEmotionTypeEnum: IwbEnumDef;
  wbEntryPointsEnum: IwbEnumDef;
  wbEventFunctionEnum: IwbEnumDef;
  wbEventMemberEnum: IwbEnumDef;
  wbFormTypeEnum: IwbEnumDef;
  wbFurnitureAnimTypeEnum: IwbEnumDef;
  wbLocationEnum: IwbEnumDef;
  wbMiscStatEnum: IwbEnumDef;
  wbObjectModProperties: IwbArrayDef;
  wbObjectTypeEnum: IwbEnumDef;
  wbPropTypeEnum: IwbEnumDef;
  wbSoundLevelEnum: IwbEnumDef;
  wbTargetEnum: IwbEnumDef;
  wbVatsValueFunctionEnum: IwbEnumDef;
  wbWardStateEnum: IwbEnumDef;
  wbWeaponPropertyEnum: IwbEnumDef;
  wbKeywordTypeEnum: IwbEnumDef;
  wbReverbClassEnum: IwbEnumDef;
  wbHitBehaviourEnum: IwbEnumDef;

procedure DefineFO4;

implementation

uses
  Types,
  Classes,
  SysUtils,
  Math,
  Variants,
  wbHelpers,
  wbDefinitionsCommon,
  wbDefinitionsSignatures;

type
  TVarRecs = array of TVarRec;

const
  // signatures of reference records
  sigReferences : TwbSignatures = [
    'NULL', 'PLYR', 'ACHR', 'REFR', 'PGRE', 'PHZD',
    'PMIS', 'PARW', 'PBAR', 'PBEA', 'PCON', 'PFLA'
  ]
  ;

  // signatures of referenceable records (placed by references or constructable)
  sigBaseObjects : TwbSignatures = [
    'NULL', 'ACTI', 'ADDN', 'ALCH', 'AMMO', 'ARMO',
    'ARTO', 'ASPC', 'BNDS', 'BOOK', 'CMPO', 'COBJ',
    'CONT', 'DEBR', 'DOOR', 'EXPL', 'FLST', 'FLOR',
    'FURN', 'HAZD', 'IDLM', 'INGR', 'KEYM', 'LIGH',
    'LVLI', 'LVLN', 'LVSP', 'MISC', 'MSTT', 'NOTE',
    'NPC_', 'OMOD', 'PROJ', 'SCOL', 'SCRL', 'SOUN',
    'SPEL', 'STAT', 'TACT', 'TERM', 'TREE', 'TXST',
    'WATR', 'WEAP', 'ENCH'
  ];

var
  wbEDID: IwbSubRecordDef;
  wbCOED: IwbSubRecordDef;
  wbXLCM: IwbSubRecordDef;
  wbDEST: IwbSubRecordStructDef;
  wbDODT: IwbSubRecordDef;
  wbSPLO: IwbSubRecordDef;
  wbSPLOs: IwbSubRecordArrayDef;
  wbCNTO: IwbRecordMemberDef;
  wbCNTOs: IwbSubRecordArrayDef;
  wbAIDT: IwbRecordMemberDef;
  wbFULL: IwbSubRecordDef;
  wbFULLReq: IwbSubRecordDef;
  wbDESC: IwbSubRecordDef;
  wbDESCReq: IwbSubRecordDef;
  wbXSCL: IwbSubRecordDef;
  wbMODC: IwbSubRecordDef;
  wbModelFlags: IwbFlagsDef;
  wbMODF: IwbRecordMemberDef;
  wbMODS: IwbSubRecordDef;
  wbMO2S: IwbSubRecordDef;
  wbMO3S: IwbSubRecordDef;
  wbMO4S: IwbSubRecordDef;
  wbMO2F: IwbRecordMemberDef;
  wbMO3F: IwbRecordMemberDef;
  wbMO4F: IwbRecordMemberDef;
  wbMO5F: IwbRecordMemberDef;
  wbMO2C: IwbSubRecordDef;
  wbMO3C: IwbSubRecordDef;
  wbMO4C: IwbSubRecordDef;
  wbMO5C: IwbSubRecordDef;
  wbComponent: IwbValueDef;
  wbComponents: IwbSubRecordDef;
  wbConditions: IwbRecordMemberDef;
  wbXESP: IwbSubRecordDef;
  wbICON: IwbSubRecordDef;
  wbMICO: IwbSubRecordDef;
  wbActorValue: IwbIntegerDef;
  wbETYP: IwbSubRecordDef;
  wbETYPReq: IwbSubRecordDef;
  wbEFID: IwbSubRecordDef;
  wbEFIT: IwbSubRecordDef;
  wbEffectsReq: IwbSubRecordArrayDef;
  wbFirstPersonFlagsU32: IwbValueDef;
  wbBOD2: IwbSubRecordDef;
  wbScriptEntry: IwbValueDef;
  wbScriptFlags: IwbIntegerDef;
  wbScriptPropertyObject: IwbUnionDef;
  wbScriptPropertyStruct: IwbArrayDef;
  wbScriptProperty: IwbValueDef;
  wbScriptProperties: IwbArrayDef;
  wbScriptFragments: IwbValueDef;
  wbScriptFragmentsQuest: IwbValueDef;
  wbScriptFragmentsInfo: IwbValueDef;
  wbScriptFragmentsPack: IwbValueDef;
  wbScriptFragmentsScen: IwbValueDef;
  wbPLDT: IwbSubRecordDef;
  wbPLVD: IwbSubRecordDef;
  wbTargetData: IwbStructDef;
  wbAttackData: IwbSubRecordStructDef;
  wbLLCT: IwbSubRecordDef;
  wbLVLD: IwbSubRecordDef;
  wbVMAD: IwbSubRecordDef;
  wbVMADFragmentedPERK: IwbSubRecordDef;
  wbVMADFragmentedPACK: IwbSubRecordDef;
  wbVMADFragmentedQUST: IwbSubRecordDef;
  wbVMADFragmentedSCEN: IwbSubRecordDef;
  wbVMADFragmentedINFO: IwbSubRecordDef;
  wbCOCT: IwbSubRecordDef;
  wbCITC: IwbSubRecordDef;
  wbCITCReq: IwbSubRecordDef;
  wbMGEFData: IwbSubRecordStructDef;
  wbMGEFType: IwbIntegerDef;
  wbSPIT: IwbSubRecordDef;
  wbDMDC: IwbSubRecordDef;
  wbDMDS: IwbSubRecordDef;
  wbMO5S: IwbSubRecordDef;
  wbSPCT: IwbSubRecordDef;
  wbPhonemeTargets: IwbSubRecordDef;
  wbPHWT: IwbSubRecordStructDef;
  wbQUSTAliasFlags: IwbRecordMemberDef;
  wbPDTO: IwbSubRecordDef;
  wbPDTOs: IwbSubRecordArrayDef;
  wbUNAMs: IwbSubRecordArrayDef;
  wbNull: IwbValueDef;
  wbYNAM: IwbSubRecordDef;
  wbZNAM: IwbSubRecordDef;
  wbSPED: IwbSubRecordDef;
  wbCUSD: IwbSubRecordDef;
  wbINRD: IwbSubRecordDef;
  wbPTRN: IwbSubRecordDef;
  wbSTCP: IwbSubRecordDef;
  wbNTRM: IwbSubRecordDef;
  wbPRPS: IwbSubRecordDef;
  wbObjectProperty: IwbValueDef;
  wbFLTR: IwbSubRecordDef;
  wbAPPR: IwbSubRecordDef;
  wbObjectTemplate: IwbSubRecordStructDef;
  wbBSMPSequence: IwbSubRecordArrayDef;
  wbArmorAddonBSMPSequence: IwbSubRecordArrayDef;
  wbFTYP: IwbSubRecordDef;
  wbATTX: IwbSubRecordDef;
  wbMNAMFurnitureMarker: IwbRecordMemberDef;
  wbSNAMMarkerParams: IwbSubRecordDef;
  wbOBTSReq: IwbSubRecordDef;
  //wbTintTemplateGroups: IwbSubrecordArrayDef;
  //wbMorphGroups: IwbSubrecordArrayDef;
  //wbRaceFRMI: IwbSubrecordArrayDef;
  wbRaceRBPC: IwbSubRecordDef;
  wbNVNM: IwbSubRecordDef;
  wbBlendOperationEnum: IwbEnumDef;
  a, b, c : TVarRecs;

type
  TConditionParameterType = (
    //Misc
	  {1} ptNone,
    {2} ptFloat,
	  {3} ptInteger,
	  {4} ptString,
	  {5} ptAlias,
	  {6} ptEvent,
	  {7} ptPackdata,
	  {8} ptQuestStage,

	  //Enums
    {9}  ptAlignment,     //wbAlignmentEnum
	  {10} ptAxis,          //wbAxisEnum
	  {11} ptCastingSource, //wbCastingSourceEnum
	  {12} ptCrimeType,     //wbCrimeTypeEnum
	  {13} ptCriticalStage, //wbCriticalStageEnum
	  {14} ptFormType,      //wbFormTypeEnum
	  {15} ptMiscStat,      //wbMiscStatEnum
	  {16} ptSex,           //wbSexEnum
	  {17} ptWardState,     //wbWardStateEnum

	  //FormIDs
	  {18} ptActor,           //ACHR
    {19} ptActorBase,       //NPC_
    {20} ptActorValue,      //AVIF
	  {21} ptAssociationType, //ASTP
	  {22} ptBaseEffect,      //MGEF
	  {23} ptBaseObject,      //SigBaseObjects
	  {24} ptCell,            //CELL
	  {25} ptClass,           //CLAS
    {26} ptDamageType,      //DMGT
	  {27} ptEffectItem,      //ALCH, ENCH, INGR, SCRL, SPEL
	  {28} ptEncounterZone,   //ECZN
    {29} ptEquipType,       //EQUP
    {30} ptEventData,       //LCTN, KYWD or FLST
    {31} ptFaction,         //FACT
	  {32} ptFormList,        //FLST
    {33} ptFurniture,       //FURN
    {34} ptGlobal,          //GLOB
    {35} ptIdleForm,        //IDLE
    {36} ptKeyword,         //KYWD
    {37} ptLocation,        //LCTN
    {38} ptLocationRefType, //LCRT
  	{39} ptOwner,           //FACT, NPC_
	  {40} ptPackage,         //PACK
	  {41} ptPerk,            //PERK
	  {42} ptQuest,           //QUST
	  {43} ptRace,            //RACE
	  {44} ptReference,       //REFR, ACHR
    {45} ptRegion,          //REGN
    {46} ptScene,           //SCEN
    {47} ptVoiceType,       //VTYP
    {48} ptWeather,         //WTHR
    {49} ptWorldspace       //WRLD
  );

  PConditionFunction = ^TConditionFunction;
  TConditionFunction = record
    Index: Integer;
    Name: string;
    Desc: string;
    ParamType1: TConditionParameterType;
    ParamType2: TConditionParameterType;
    ParamType3: TConditionParameterType;
  end;

const
  wbConditionFunctions : array[0..478] of TConditionFunction = (
    (Index:   0; Name: 'GetWantBlocking'),
    (Index:   1; Name: 'GetDistance'; ParamType1: ptReference),
    (Index:   5; Name: 'GetLocked'),
    (Index:   6; Name: 'GetPos'; Paramtype1: ptAxis),
    (Index:   8; Name: 'GetAngle'; Paramtype1: ptAxis),
    (Index:  10; Name: 'GetStartingPos'; Paramtype1: ptAxis),
    (Index:  11; Name: 'GetStartingAngle'; Paramtype1: ptAxis),
    (Index:  12; Name: 'GetSecondsPassed'),
    (Index:  14; Name: 'GetValue'; Paramtype1: ptActorValue),
    (Index:  18; Name: 'GetCurrentTime'),
    (Index:  24; Name: 'GetScale'),
    (Index:  25; Name: 'IsMoving'),
    (Index:  26; Name: 'IsTurning'),
    (Index:  27; Name: 'GetLineOfSight'; ParamType1: ptReference),
    (Index:  32; Name: 'GetInSameCell'; ParamType1: ptReference),
    (Index:  35; Name: 'GetDisabled'),
    (Index:  36; Name: 'MenuMode'; Paramtype1: ptInteger),
    (Index:  39; Name: 'GetDisease'),
    (Index:  41; Name: 'GetClothingValue'),
    (Index:  42; Name: 'SameFaction'; Paramtype1: ptActor),
    (Index:  43; Name: 'SameRace'; Paramtype1: ptActor),
    (Index:  44; Name: 'SameSex'; Paramtype1: ptActor),
    (Index:  45; Name: 'GetDetected'; Paramtype1: ptActor),
    (Index:  46; Name: 'GetDead'),
    (Index:  47; Name: 'GetItemCount'; ParamType1: ptBaseObject),
    (Index:  48; Name: 'GetGold'),
    (Index:  49; Name: 'GetSleeping'),
    (Index:  50; Name: 'GetTalkedToPC'),
    (Index:  56; Name: 'GetQuestRunning'; Paramtype1: ptQuest),
    (Index:  58; Name: 'GetStage'; Paramtype1: ptQuest),
    (Index:  59; Name: 'GetStageDone'; ParamType1: ptQuest; ParamType2: ptQuestStage),
    (Index:  60; Name: 'GetFactionRankDifference'; Paramtype1: ptFaction; Paramtype2: ptActor),
    (Index:  61; Name: 'GetAlarmed'),
    (Index:  62; Name: 'IsRaining'),
    (Index:  63; Name: 'GetAttacked'),
    (Index:  64; Name: 'GetIsCreature'),
    (Index:  65; Name: 'GetLockLevel'),
    (Index:  66; Name: 'GetShouldAttack'; Paramtype1: ptActor),
    (Index:  67; Name: 'GetInCell'; Paramtype1: ptCell),
    (Index:  68; Name: 'GetIsClass'; Paramtype1: ptClass),
    (Index:  69; Name: 'GetIsRace'; Paramtype1: ptRace),
    (Index:  70; Name: 'GetIsSex'; Paramtype1: ptSex),
    (Index:  71; Name: 'GetInFaction'; Paramtype1: ptFaction),
    (Index:  72; Name: 'GetIsID'; ParamType1: ptBaseObject),
    (Index:  73; Name: 'GetFactionRank'; Paramtype1: ptFaction),
    (Index:  74; Name: 'GetGlobalValue'; Paramtype1: ptGlobal),
    (Index:  75; Name: 'IsSnowing'),
    (Index:  77; Name: 'GetRandomPercent'),
    (Index:  79; Name: 'WouldBeStealing'; ParamType1: ptReference),
    (Index:  80; Name: 'GetLevel'),
    (Index:  81; Name: 'IsRotating'),
    (Index:  84; Name: 'GetDeadCount'; ParamType1: ptActorBase),
    (Index:  91; Name: 'GetIsAlerted'),
    (Index:  98; Name: 'GetPlayerControlsDisabled'; Paramtype1: ptInteger; Paramtype2: ptInteger; Paramtype3: ptInteger),
    (Index:  99; Name: 'GetHeadingAngle'; ParamType1: ptReference),
    (Index: 101; Name: 'IsWeaponMagicOut'),
    (Index: 102; Name: 'IsTorchOut'),
    (Index: 103; Name: 'IsShieldOut'),
    (Index: 106; Name: 'IsFacingUp'),
    (Index: 107; Name: 'GetKnockedState'),
    (Index: 108; Name: 'GetWeaponAnimType'),
    (Index: 109; Name: 'IsWeaponSkillType'; ParamType1: ptActorValue),
    (Index: 110; Name: 'GetCurrentAIPackage'),
    (Index: 111; Name: 'IsWaiting'),
    (Index: 112; Name: 'IsIdlePlaying'),
    (Index: 116; Name: 'IsIntimidatedbyPlayer'),
    (Index: 117; Name: 'IsPlayerInRegion'; Paramtype1: ptRegion),
    (Index: 118; Name: 'GetActorAggroRadiusViolated'),
    (Index: 122; Name: 'GetCrime'; ParamType1: ptActor; ParamType2: ptCrimeType),
    (Index: 123; Name: 'IsGreetingPlayer'),
    (Index: 125; Name: 'IsGuard'),
    (Index: 127; Name: 'HasBeenEaten'),
    (Index: 128; Name: 'GetStaminaPercentage'),
    (Index: 129; Name: 'HasBeenRead'),
    (Index: 130; Name: 'GetDying'),
    (Index: 131; Name: 'GetSceneActionPercent'; ParamType1: ptScene; ParamType2: ptInteger),
    (Index: 132; Name: 'WouldRefuseCommand'; ParamType1: ptReference),
    (Index: 133; Name: 'SameFactionAsPC'),
    (Index: 134; Name: 'SameRaceAsPC'),
    (Index: 135; Name: 'SameSexAsPC'),
    (Index: 136; Name: 'GetIsReference'; ParamType1: ptReference),
    (Index: 141; Name: 'IsTalking'),
    (Index: 142; Name: 'GetComponentCount'; ParamType1: ptBaseObject),
    (Index: 143; Name: 'GetCurrentAIProcedure'),
    (Index: 144; Name: 'GetTrespassWarningLevel'),
    (Index: 145; Name: 'IsTrespassing'),
    (Index: 146; Name: 'IsInMyOwnedCell'),
    (Index: 147; Name: 'GetWindSpeed'),
    (Index: 148; Name: 'GetCurrentWeatherPercent'),
    (Index: 149; Name: 'GetIsCurrentWeather'; ParamType1: ptWeather),
    (Index: 150; Name: 'IsContinuingPackagePCNear'),
    (Index: 152; Name: 'GetIsCrimeFaction'; Paramtype1: ptFaction),
    (Index: 153; Name: 'CanHaveFlames'),
    (Index: 154; Name: 'HasFlames'),
    (Index: 157; Name: 'GetOpenState'),
    (Index: 159; Name: 'GetSitting'),
    (Index: 161; Name: 'GetIsCurrentPackage'; Paramtype1: ptPackage),
    (Index: 162; Name: 'IsCurrentFurnitureRef'; ParamType1: ptReference),
    (Index: 163; Name: 'IsCurrentFurnitureObj'; Paramtype1: ptFurniture),
    (Index: 170; Name: 'GetDayOfWeek'),
    (Index: 172; Name: 'GetTalkedToPCParam'; Paramtype1: ptActor),
    (Index: 175; Name: 'IsPCSleeping'),
    (Index: 176; Name: 'IsPCAMurderer'),
    (Index: 180; Name: 'HasSameEditorLocationAsRef'; ParamType1: ptReference; ParamType2: ptKeyword),
    (Index: 181; Name: 'HasSameEditorLocationAsRefAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),
    (Index: 182; Name: 'GetEquipped'; ParamType1: ptBaseObject),
    (Index: 185; Name: 'IsSwimming'),
    (Index: 190; Name: 'GetAmountSoldStolen'),
    (Index: 192; Name: 'GetIgnoreCrime'),
    (Index: 193; Name: 'GetPCExpelled'; Paramtype1: ptFaction),
    (Index: 195; Name: 'GetPCFactionMurder'; Paramtype1: ptFaction),
    (Index: 197; Name: 'GetPCEnemyofFaction'; Paramtype1: ptFaction),
    (Index: 199; Name: 'GetPCFactionAttack'; Paramtype1: ptFaction),
    (Index: 203; Name: 'GetDestroyed'),
    (Index: 214; Name: 'HasMagicEffect'; ParamType1: ptBaseEffect),
    (Index: 215; Name: 'GetDefaultOpen'),
    (Index: 223; Name: 'IsSpellTarget'; ParamType1: ptEffectItem),
    (Index: 224; Name: 'GetVATSMode'),
    (Index: 225; Name: 'GetPersuasionNumber'),
    (Index: 226; Name: 'GetVampireFeed'),
    (Index: 227; Name: 'GetCannibal'),
    (Index: 228; Name: 'GetIsClassDefault'; Paramtype1: ptClass),
    (Index: 229; Name: 'GetClassDefaultMatch'),
    (Index: 230; Name: 'GetInCellParam'; ParamType1: ptCell; ParamType2: ptReference),
    (Index: 231; Name: 'GetPlayerDialogueInput'),
    (Index: 235; Name: 'GetVatsTargetHeight'),
    (Index: 237; Name: 'GetIsGhost'),
    (Index: 242; Name: 'GetUnconscious'),
    (Index: 244; Name: 'GetRestrained'),
    (Index: 246; Name: 'GetIsUsedItem'; ParamType1: ptBaseObject),
    (Index: 247; Name: 'GetIsUsedItemType'; ParamType1: ptFormType),
    (Index: 248; Name: 'IsScenePlaying'; Paramtype1: ptScene),
    (Index: 249; Name: 'IsInDialogueWithPlayer'),
    (Index: 250; Name: 'GetLocationCleared'; Paramtype1: ptLocation),
    (Index: 254; Name: 'GetIsPlayableRace'),
    (Index: 255; Name: 'GetOffersServicesNow'),
    (Index: 258; Name: 'HasAssociationType'; Paramtype1: ptActor; Paramtype2: ptAssociationType),
    (Index: 259; Name: 'HasFamilyRelationship'; Paramtype1: ptActor),
    (Index: 261; Name: 'HasParentRelationship'; Paramtype1: ptActor),
    (Index: 262; Name: 'IsWarningAbout'; ParamType1: ptFormList),
    (Index: 263; Name: 'IsWeaponOut'),
    (Index: 264; Name: 'HasSpell'; ParamType1: ptEffectItem),
    (Index: 265; Name: 'IsTimePassing'),
    (Index: 266; Name: 'IsPleasant'),
    (Index: 267; Name: 'IsCloudy'),
    (Index: 274; Name: 'IsSmallBump'),
    (Index: 277; Name: 'GetBaseValue'; ParamType1: ptActorValue),
    (Index: 278; Name: 'IsOwner'; ParamType1: ptOwner),
    (Index: 280; Name: 'IsCellOwner'; ParamType1: ptCell; ParamType2: ptOwner),
    (Index: 282; Name: 'IsHorseStolen'),
    (Index: 285; Name: 'IsLeftUp'),
    (Index: 286; Name: 'IsSneaking'),
    (Index: 287; Name: 'IsRunning'),
    (Index: 288; Name: 'GetFriendHit'),
    (Index: 289; Name: 'IsInCombat'; ParamType1: ptInteger),
    (Index: 300; Name: 'IsInInterior'),
    (Index: 304; Name: 'IsWaterObject'),
    (Index: 305; Name: 'GetPlayerAction'),
    (Index: 306; Name: 'IsActorUsingATorch'),
    (Index: 309; Name: 'IsXBox'),
    (Index: 310; Name: 'GetInWorldspace'; Paramtype1: ptWorldSpace),
    (Index: 312; Name: 'GetPCMiscStat'; ParamType1: ptMiscStat),
    (Index: 313; Name: 'GetPairedAnimation'),
    (Index: 314; Name: 'IsActorAVictim'),
    (Index: 315; Name: 'GetTotalPersuasionNumber'),
    (Index: 318; Name: 'GetIdleDoneOnce'),
    (Index: 320; Name: 'GetNoRumors'),
    (Index: 323; Name: 'GetCombatState'),
    (Index: 325; Name: 'GetWithinPackageLocation'; ParamType1: ptPackdata),
    (Index: 327; Name: 'IsRidingMount'),
    (Index: 329; Name: 'IsFleeing'),
    (Index: 332; Name: 'IsInDangerousWater'),
    (Index: 338; Name: 'GetIgnoreFriendlyHits'),
    (Index: 339; Name: 'IsPlayersLastRiddenMount'),
    (Index: 353; Name: 'IsActor'),
    (Index: 354; Name: 'IsEssential'),
    (Index: 358; Name: 'IsPlayerMovingIntoNewSpace'),
    (Index: 359; Name: 'GetInCurrentLocation'; Paramtype1: ptLocation),
    (Index: 360; Name: 'GetInCurrentLocationAlias'; ParamType1: ptAlias),
    (Index: 361; Name: 'GetTimeDead'),
    (Index: 362; Name: 'HasLinkedRef'; Paramtype1: ptKeyword),
    (Index: 365; Name: 'IsChild'),
    (Index: 366; Name: 'GetStolenItemValueNoCrime'; Paramtype1: ptFaction),
    (Index: 367; Name: 'GetLastPlayerAction'),
    (Index: 368; Name: 'IsPlayerActionActive'; Paramtype1: ptInteger),
    (Index: 370; Name: 'IsTalkingActivatorActor'; Paramtype1: ptActor),
    (Index: 372; Name: 'IsInList'; ParamType1: ptFormList),
    (Index: 373; Name: 'GetStolenItemValue'; Paramtype1: ptFaction),
    (Index: 375; Name: 'GetCrimeGoldViolent'; ParamType1: ptFaction),
    (Index: 376; Name: 'GetCrimeGoldNonviolent'; ParamType1: ptFaction),
    (Index: 378; Name: 'IsOwnedBy'; Paramtype1: ptActor),
    (Index: 380; Name: 'GetCommandDistance'),
    (Index: 381; Name: 'GetCommandLocationDistance'),
    (Index: 390; Name: 'GetHitLocation'),
    (Index: 391; Name: 'IsPC1stPerson'),
    (Index: 396; Name: 'GetCauseofDeath'),
    (Index: 397; Name: 'IsLimbGone'; Paramtype1: ptInteger),
    (Index: 398; Name: 'IsWeaponInList'; ParamType1: ptFormList),
    (Index: 402; Name: 'IsBribedbyPlayer'),
    (Index: 403; Name: 'GetRelationshipRank'; Paramtype1: ptActor),
    (Index: 407; Name: 'GetVATSValue'; ParamType1: ptInteger; ParamType2: ptInteger),
    (Index: 408; Name: 'IsKiller'; Paramtype1: ptActor),
    (Index: 409; Name: 'IsKillerObject'; ParamType1: ptFormList),
    (Index: 410; Name: 'GetFactionCombatReaction'; Paramtype1: ptFaction; Paramtype2: ptFaction),
    (Index: 414; Name: 'Exists'; ParamType1: ptReference),
    (Index: 415; Name: 'GetGroupMemberCount'),
    (Index: 416; Name: 'GetGroupTargetCount'),
    (Index: 426; Name: 'GetIsVoiceType'; Paramtype1: ptVoiceType),
    (Index: 427; Name: 'GetPlantedExplosive'),
    (Index: 429; Name: 'IsScenePackageRunning'),
    (Index: 430; Name: 'GetHealthPercentage'),
    (Index: 432; Name: 'GetIsObjectType'; ParamType1: ptFormType),
    (Index: 434; Name: 'PlayerVisualDetection'),
    (Index: 435; Name: 'PlayerAudioDetection'),
    (Index: 437; Name: 'GetIsCreatureType'; Paramtype1: ptInteger),
    (Index: 438; Name: 'HasKey'; ParamType1: ptReference),
    (Index: 439; Name: 'IsFurnitureEntryType'; ParamType1: ptBaseObject),
    (Index: 444; Name: 'GetInCurrentLocationFormList'; ParamType1: ptFormList),
    (Index: 445; Name: 'GetInZone'; Paramtype1: ptEncounterZone),
    (Index: 446; Name: 'GetVelocity'; Paramtype1: ptAxis),
    (Index: 447; Name: 'GetGraphVariableFloat'; Paramtype1: ptString),
    (Index: 448; Name: 'HasPerk'; Paramtype1: ptPerk),
    (Index: 449; Name: 'GetFactionRelation'; Paramtype1: ptActor),
    (Index: 450; Name: 'IsLastIdlePlayed'; ParamType1: ptIdleForm),
    (Index: 453; Name: 'GetPlayerTeammate'),
    (Index: 454; Name: 'GetPlayerTeammateCount'),
    (Index: 458; Name: 'GetActorCrimePlayerEnemy'),
    (Index: 459; Name: 'GetCrimeGold'; ParamType1: ptFaction),
    (Index: 463; Name: 'IsPlayerGrabbedRef'; ParamType1: ptReference),
    (Index: 465; Name: 'GetKeywordItemCount'; Paramtype1: ptKeyword),
    (Index: 470; Name: 'GetDestructionStage'),
    (Index: 473; Name: 'GetIsAlignment'; Paramtype1: ptAlignment),
    (Index: 476; Name: 'IsProtected'),
    (Index: 477; Name: 'GetThreatRatio'; Paramtype1: ptActor),
    (Index: 479; Name: 'GetIsUsedItemEquipType'; Paramtype1: ptEquipType),
    (Index: 483; Name: 'GetPlayerActivated'),
    (Index: 485; Name: 'GetFullyEnabledActorsInHigh'),
    (Index: 487; Name: 'IsCarryable'),
    (Index: 488; Name: 'GetConcussed'),
    (Index: 491; Name: 'GetMapMarkerVisible'),
    (Index: 493; Name: 'PlayerKnows'; ParamType1: ptBaseObject),
    (Index: 494; Name: 'GetPermanentValue'; ParamType1: ptActorValue),
    (Index: 495; Name: 'GetKillingBlowLimb'),
    (Index: 497; Name: 'CanPayCrimeGold'; ParamType1: ptFaction),
    (Index: 499; Name: 'GetDaysInJail'),
    (Index: 500; Name: 'EPAlchemyGetMakingPoison'),
    (Index: 501; Name: 'EPAlchemyEffectHasKeyword'; Paramtype1: ptKeyword),
    (Index: 503; Name: 'GetAllowWorldInteractions'),
    (Index: 506; Name: 'DialogueGetAv'; ParamType1: ptActorValue),
    (Index: 507; Name: 'DialogueHasPerk'; Paramtype1: ptPerk),
    (Index: 508; Name: 'GetLastHitCritical'),
    (Index: 510; Name: 'DialogueGetItemCount'; ParamType1: ptBaseObject),
    (Index: 511; Name: 'LastCrippledCondition'; ParamType1: ptActorValue),
    (Index: 512; Name: 'HasSharedPowerGrid'; ParamType1: ptReference),
    (Index: 513; Name: 'IsCombatTarget'; Paramtype1: ptActor),
    (Index: 515; Name: 'GetVATSRightAreaFree'; ParamType1: ptReference),
    (Index: 516; Name: 'GetVATSLeftAreaFree'; ParamType1: ptReference),
    (Index: 517; Name: 'GetVATSBackAreaFree'; ParamType1: ptReference),
    (Index: 518; Name: 'GetVATSFrontAreaFree'; ParamType1: ptReference),
    (Index: 519; Name: 'GetIsLockBroken'),
    (Index: 520; Name: 'IsPS3'),
    (Index: 521; Name: 'IsWindowsPC'),
    (Index: 522; Name: 'GetVATSRightTargetVisible'; ParamType1: ptReference),
    (Index: 523; Name: 'GetVATSLeftTargetVisible'; ParamType1: ptReference),
    (Index: 524; Name: 'GetVATSBackTargetVisible'; ParamType1: ptReference),
    (Index: 525; Name: 'GetVATSFrontTargetVisible'; ParamType1: ptReference),
    (Index: 528; Name: 'IsInCriticalStage'; Paramtype1: ptCriticalStage),
    (Index: 530; Name: 'GetXPForNextLevel'),
    (Index: 533; Name: 'GetInfamy'; ParamType1: ptFaction),
    (Index: 534; Name: 'GetInfamyViolent'; ParamType1: ptFaction),
    (Index: 535; Name: 'GetInfamyNonViolent'; ParamType1: ptFaction),
    (Index: 536; Name: 'GetTypeCommandPerforming'),
    (Index: 543; Name: 'GetQuestCompleted'; Paramtype1: ptQuest),
    (Index: 544; Name: 'GetSpeechChallengeSuccessLevel'),
    (Index: 547; Name: 'IsGoreDisabled'),
    (Index: 550; Name: 'IsSceneActionComplete'; ParamType1: ptScene; ParamType2: ptInteger),
    (Index: 552; Name: 'GetSpellUsageNum'; ParamType1: ptEffectItem),
    (Index: 554; Name: 'GetActorsInHigh'),
    (Index: 555; Name: 'HasLoaded3D'),
    (Index: 560; Name: 'HasKeyword'; Paramtype1: ptKeyword),
    (Index: 561; Name: 'HasRefType'; Paramtype1: ptLocationRefType),
    (Index: 562; Name: 'LocationHasKeyword'; Paramtype1: ptKeyword),
    (Index: 563; Name: 'LocationHasRefType'; Paramtype1: ptLocationRefType),
    (Index: 565; Name: 'GetIsEditorLocation'; Paramtype1: ptLocation),
    (Index: 566; Name: 'GetIsAliasRef'; ParamType1: ptAlias),
    (Index: 567; Name: 'GetIsEditorLocationAlias'; ParamType1: ptAlias),
    (Index: 568; Name: 'IsSprinting'),
    (Index: 569; Name: 'IsBlocking'),
    (Index: 570; Name: 'HasEquippedSpell'; ParamType1: ptCastingSource),
    (Index: 571; Name: 'GetCurrentCastingType'; ParamType1: ptCastingSource),
    (Index: 572; Name: 'GetCurrentDeliveryType'; ParamType1: ptCastingSource),
    (Index: 574; Name: 'GetAttackState'),
    (Index: 576; Name: 'GetEventData'; ParamType1: ptEvent; ParamType2: ptEventData),
    (Index: 577; Name: 'IsCloserToAThanB'; ParamType1: ptReference; ParamType2: ptReference),
    (Index: 578; Name: 'LevelMinusPCLevel'),
    (Index: 580; Name: 'IsBleedingOut'),
    (Index: 584; Name: 'GetRelativeAngle'; ParamType1: ptReference; ParamType2: ptAxis),
    (Index: 589; Name: 'GetMovementDirection'),
    (Index: 590; Name: 'IsInScene'),
    (Index: 591; Name: 'GetRefTypeDeadCount'; Paramtype1: ptLocation; Paramtype2: ptLocationRefType),
    (Index: 592; Name: 'GetRefTypeAliveCount'; Paramtype1: ptLocation; Paramtype2: ptLocationRefType),
    (Index: 594; Name: 'GetIsFlying'),
    (Index: 595; Name: 'IsCurrentSpell'; ParamType1: ptEffectItem; ParamType2: ptCastingSource),
    (Index: 596; Name: 'SpellHasKeyword'; ParamType1: ptCastingSource; ParamType2: ptKeyword),
    (Index: 597; Name: 'GetEquippedItemType'; ParamType1: ptCastingSource),
    (Index: 598; Name: 'GetLocationAliasCleared'; ParamType1: ptAlias),
    (Index: 600; Name: 'GetLocationAliasRefTypeDeadCount'; ParamType1: ptAlias; ParamType2: ptLocationRefType),
    (Index: 601; Name: 'GetLocationAliasRefTypeAliveCount'; ParamType1: ptAlias; ParamType2: ptLocationRefType),
    (Index: 602; Name: 'IsWardState'; ParamType1: ptWardState),
    (Index: 603; Name: 'IsInSameCurrentLocationAsRef'; ParamType1: ptReference; ParamType2: ptKeyword),
    (Index: 604; Name: 'IsInSameCurrentLocationAsRefAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),
    (Index: 605; Name: 'LocationAliasIsLocation'; ParamType1: ptAlias; ParamType2: ptLocation),
    (Index: 606; Name: 'GetKeywordDataForLocation'; Paramtype1: ptLocation; Paramtype2: ptKeyword),
    (Index: 608; Name: 'GetKeywordDataForAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),
    (Index: 610; Name: 'LocationAliasHasKeyword'; ParamType1: ptAlias; ParamType2: ptKeyword),
    (Index: 611; Name: 'IsNullPackageData'; ParamType1: ptPackdata),
    (Index: 612; Name: 'GetNumericPackageData'; ParamType1: ptPackdata),
    (Index: 613; Name: 'IsPlayerRadioOn'),
    (Index: 614; Name: 'GetPlayerRadioFrequency'),
    (Index: 615; Name: 'GetHighestRelationshipRank'),
    (Index: 616; Name: 'GetLowestRelationshipRank'),
    (Index: 617; Name: 'HasAssociationTypeAny'; Paramtype1: ptAssociationType),
    (Index: 618; Name: 'HasFamilyRelationshipAny'),
    (Index: 619; Name: 'GetPathingTargetOffset'; Paramtype1: ptAxis),
    (Index: 620; Name: 'GetPathingTargetAngleOffset'; Paramtype1: ptAxis),
    (Index: 621; Name: 'GetPathingTargetSpeed'),
    (Index: 622; Name: 'GetPathingTargetSpeedAngle'; Paramtype1: ptAxis),
    (Index: 623; Name: 'GetMovementSpeed'),
    (Index: 624; Name: 'GetInContainer'; ParamType1: ptReference),
    (Index: 625; Name: 'IsLocationLoaded'; Paramtype1: ptLocation),
    (Index: 626; Name: 'IsLocationAliasLoaded'; ParamType1: ptAlias),
    (Index: 627; Name: 'IsDualCasting'),
    (Index: 629; Name: 'GetVMQuestVariable'; ParamType1: ptQuest; ParamType2: ptString),
    (Index: 630; Name: 'GetCombatAudioDetection'),
    (Index: 631; Name: 'GetCombatVisualDetection'),
    (Index: 632; Name: 'IsCasting'),
    (Index: 633; Name: 'GetFlyingState'),
    (Index: 635; Name: 'IsInFavorState'),
    (Index: 636; Name: 'HasTwoHandedWeaponEquipped'),
    (Index: 637; Name: 'IsFurnitureExitType'; ParamType1: ptBaseObject),
    (Index: 638; Name: 'IsInFriendStatewithPlayer'),
    (Index: 639; Name: 'GetWithinDistance'; ParamType1: ptReference; ParamType2: ptFloat),
    (Index: 640; Name: 'GetValuePercent'; ParamType1: ptActorValue),
    (Index: 641; Name: 'IsUnique'),
    (Index: 642; Name: 'GetLastBumpDirection'),
    (Index: 644; Name: 'GetInfoChallangeSuccess'),
    (Index: 645; Name: 'GetIsInjured'),
    (Index: 646; Name: 'GetIsCrashLandRequest'),
    (Index: 647; Name: 'GetIsHastyLandRequest'),
    (Index: 650; Name: 'IsLinkedTo'; ParamType1: ptReference; ParamType2: ptKeyword),
    (Index: 651; Name: 'GetKeywordDataForCurrentLocation'; Paramtype1: ptKeyword),
    (Index: 652; Name: 'GetInSharedCrimeFaction'; ParamType1: ptReference),
    (Index: 654; Name: 'GetBribeSuccess'),
    (Index: 655; Name: 'GetIntimidateSuccess'),
    (Index: 656; Name: 'GetArrestedState'),
    (Index: 657; Name: 'GetArrestingActor'),
    (Index: 659; Name: 'HasVMScript'; ParamType1: ptString),
    (Index: 660; Name: 'GetVMScriptVariable'; ParamType1: ptString; ParamType2: ptString),
    (Index: 661; Name: 'GetWorkshopResourceDamage'; ParamType1: ptActorValue),
    (Index: 664; Name: 'HasValidRumorTopic'; ParamType1: ptQuest),
    (Index: 672; Name: 'IsAttacking'),
    (Index: 673; Name: 'IsPowerAttacking'),
    (Index: 674; Name: 'IsLastHostileActor'),
    (Index: 675; Name: 'GetGraphVariableInt'; ParamType1: ptString),
    (Index: 678; Name: 'ShouldAttackKill'; Paramtype1: ptActor),
    (Index: 680; Name: 'GetActivationHeight'),
    (Index: 682; Name: 'WornHasKeyword'; Paramtype1: ptKeyword),
    (Index: 683; Name: 'GetPathingCurrentSpeed'),
    (Index: 684; Name: 'GetPathingCurrentSpeedAngle'; Paramtype1: ptAxis),
    (Index: 691; Name: 'GetWorkshopObjectCount'; ParamType1: ptBaseObject),
    (Index: 693; Name: 'EPMagic_SpellHasKeyword'; Paramtype1: ptKeyword),
    (Index: 694; Name: 'GetNoBleedoutRecovery'),
    (Index: 696; Name: 'EPMagic_SpellHasSkill'; ParamType1: ptActorValue),
    (Index: 697; Name: 'IsAttackType'; Paramtype1: ptKeyword),
    (Index: 698; Name: 'IsAllowedToFly'),
    (Index: 699; Name: 'HasMagicEffectKeyword'; Paramtype1: ptKeyword),
    (Index: 700; Name: 'IsCommandedActor'),
    (Index: 701; Name: 'IsStaggered'),
    (Index: 702; Name: 'IsRecoiling'),
    (Index: 703; Name: 'HasScopeWeaponEquipped'),
    (Index: 704; Name: 'IsPathing'),
    (Index: 705; Name: 'GetShouldHelp'; Paramtype1: ptActor),
    (Index: 706; Name: 'HasBoundWeaponEquipped'; ParamType1: ptCastingSource),
    (Index: 707; Name: 'GetCombatTargetHasKeyword'; Paramtype1: ptKeyword),
    (Index: 709; Name: 'GetCombatGroupMemberCount'),
    (Index: 710; Name: 'IsIgnoringCombat'),
    (Index: 711; Name: 'GetLightLevel'),
    (Index: 713; Name: 'SpellHasCastingPerk'; Paramtype1: ptPerk),
    (Index: 714; Name: 'IsBeingRidden'),
    (Index: 715; Name: 'IsUndead'),
    (Index: 716; Name: 'GetRealHoursPassed'),
    (Index: 718; Name: 'IsUnlockedDoor'),
    (Index: 719; Name: 'IsHostileToActor'; Paramtype1: ptActor),
    (Index: 720; Name: 'GetTargetHeight'; ParamType1: ptReference),
    (Index: 721; Name: 'IsPoison'),
    (Index: 722; Name: 'WornApparelHasKeywordCount'; Paramtype1: ptKeyword),
    (Index: 723; Name: 'GetItemHealthPercent'),
    (Index: 724; Name: 'EffectWasDualCast'),
    (Index: 725; Name: 'GetKnockStateEnum'),
    (Index: 726; Name: 'DoesNotExist'),
    (Index: 728; Name: 'GetPlayerWalkAwayFromDialogueScene'),
    (Index: 729; Name: 'GetActorStance'),
    (Index: 734; Name: 'CanProduceForWorkshop'),
    (Index: 735; Name: 'CanFlyHere'),
    (Index: 736; Name: 'EPIsDamageType'; ParamType1: ptDamageType),
    (Index: 738; Name: 'GetActorGunState'),
    (Index: 739; Name: 'GetVoiceLineLength'),
    (Index: 741; Name: 'ObjectTemplateItem_HasKeyword'; Paramtype1: ptKeyword),
    (Index: 742; Name: 'ObjectTemplateItem_HasUniqueKeyword'; Paramtype1: ptKeyword),
    (Index: 743; Name: 'ObjectTemplateItem_GetLevel'),
    (Index: 744; Name: 'MovementIdleMatches'; ParamType1: ptInteger; ParamType2: ptInteger),
    (Index: 745; Name: 'GetActionData'),
    (Index: 746; Name: 'GetActionDataShort'; Paramtype1: ptInteger),
    (Index: 747; Name: 'GetActionDataByte'; Paramtype1: ptInteger),
    (Index: 748; Name: 'GetActionDataFlag'; Paramtype1: ptInteger),
    (Index: 749; Name: 'ModdedItemHasKeyword'; Paramtype1: ptKeyword),
    (Index: 750; Name: 'GetAngryWithPlayer'),
    (Index: 751; Name: 'IsCameraUnderWater'),
    (Index: 753; Name: 'IsActorRefOwner'; ParamType1: ptActor),
    (Index: 754; Name: 'HasActorRefOwner'; ParamType1: ptActor),
    (Index: 756; Name: 'GetLoadedAmmoCount'),
    (Index: 757; Name: 'IsTimeSpanSunrise'),
    (Index: 758; Name: 'IsTimeSpanMorning'),
    (Index: 759; Name: 'IsTimeSpanAfternoon'),
    (Index: 760; Name: 'IsTimeSpanEvening'),
    (Index: 761; Name: 'IsTimeSpanSunset'),
    (Index: 762; Name: 'IsTimeSpanNight'),
    (Index: 763; Name: 'IsTimeSpanMidnight'),
    (Index: 764; Name: 'IsTimeSpanAnyDay'),
    (Index: 765; Name: 'IsTimeSpanAnyNight'),
    (Index: 766; Name: 'CurrentFurnitureHasKeyword'; Paramtype1: ptKeyword),
    (Index: 767; Name: 'GetWeaponEquipIndex'),
    (Index: 769; Name: 'IsOverEncumbered'),
    (Index: 770; Name: 'IsPackageRequestingBlockedIdles'),
    (Index: 771; Name: 'GetActionDataInt'),
    (Index: 772; Name: 'GetVATSRightMinusLeftAreaFree'; ParamType1: ptReference),
    (Index: 773; Name: 'GetInIronSights'; ParamType1: ptReference),
    (Index: 774; Name: 'GetActorStaggerDirection'),
    (Index: 775; Name: 'GetActorStaggerMagnitude'),
    (Index: 776; Name: 'WornCoversBipedSlot'; Paramtype1: ptInteger),
    (Index: 777; Name: 'GetInventoryValue'),
    (Index: 778; Name: 'IsPlayerInConversation'),
    (Index: 779; Name: 'IsInDialogueCamera'),
    (Index: 780; Name: 'IsMyDialogueTargetPlayer'),
    (Index: 781; Name: 'IsMyDialogueTargetActor'),
    (Index: 782; Name: 'GetMyDialogueTargetDistance'),
    (Index: 783; Name: 'IsSeatOccupied'; Paramtype1: ptKeyword),
    (Index: 784; Name: 'IsPlayerRiding'),
    (Index: 785; Name: 'IsTryingEventCamera'),
    (Index: 786; Name: 'UseLeftSideCamera'),
    (Index: 787; Name: 'GetNoteType'),
    (Index: 788; Name: 'LocationHasPlayerOwnedWorkshop'),
    (Index: 789; Name: 'IsStartingAction'),
    (Index: 790; Name: 'IsMidAction'),
    (Index: 791; Name: 'IsWeaponChargeAttack'),
    (Index: 792; Name: 'IsInWorkshopMode'),
    (Index: 793; Name: 'IsWeaponChargingHoldAttack'),
    (Index: 794; Name: 'IsEncounterAbovePlayerLevel'),
    (Index: 795; Name: 'IsMeleeAttacking'),
    (Index: 796; Name: 'GetVATSQueuedTargetsUnique'),
    (Index: 797; Name: 'GetCurrentLocationCleared'),
    (Index: 798; Name: 'IsPowered'),
    (Index: 799; Name: 'GetTransmitterDistance'),
    (Index: 800; Name: 'GetCameraPlaybackTime'),
    (Index: 801; Name: 'IsInWater'),
    (Index: 802; Name: 'GetWithinActivateDistance'; ParamType1: ptReference),
    (Index: 803; Name: 'IsUnderWater'),
    (Index: 804; Name: 'IsInSameSpace'; ParamType1: ptReference),
    (Index: 805; Name: 'LocationAllowsReset'),
    (Index: 806; Name: 'GetVATSBackRightAreaFree'; ParamType1: ptReference),
    (Index: 807; Name: 'GetVATSBackLeftAreaFree'; ParamType1: ptReference),
    (Index: 808; Name: 'GetVATSBackRightTargetVisible'; ParamType1: ptReference),
    (Index: 809; Name: 'GetVATSBackLeftTargetVisible'; ParamType1: ptReference),
    (Index: 810; Name: 'GetVATSTargetLimbVisible'; ParamType1: ptReference),
    (Index: 811; Name: 'IsPlayerListening'; Paramtype1: ptFloat),
    (Index: 812; Name: 'GetPathingRequestedQuickTurn'),
    (Index: 813; Name: 'EPIsCalculatingBaseDamage'),
    (Index: 814; Name: 'GetReanimating'),
    (Index: 817; Name: 'IsInRobotWorkbench')
  );

function wbConditionDescFromIndex(aIndex: Integer): PConditionFunction;
begin
  Result := nil;

  var L := Low(wbConditionFunctions);
  var H := High(wbConditionFunctions);
  while L <= H do begin
    var I := (L + H) shr 1;
    var C := CmpW32(wbConditionFunctions[I].Index, aIndex);
    if C < 0 then
      L := I + 1
    else begin
      H := I - 1;
      if C = 0 then begin
        L := I;
        Result := @wbConditionFunctions[L];
      end;
    end;
  end;
end;

function wbConditionFunctionToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  var Desc := wbConditionDescFromIndex(aInt);
  case aType of
    ctEditType: Result := 'ComboBox';
    ctToSortKey: Result := IntToHex(aInt, 8);
    ctCheck: if not Assigned(Desc) then Result := '<Unknown: '+aInt.ToString+'>';
    ctEditInfo: begin
      with TStringList.Create do try
        for var i := Low(wbConditionFunctions) to High(wbConditionFunctions) do
          Add(wbConditionFunctions[i].Name);
        Sort;
        Result := CommaText;
      finally
        Free;
      end;
    end;
  end;

  if Assigned(Desc) then begin
    case aType of
      ctToEditValue, ctToStr, ctToSummary: Result := Desc.Name;
    end;
  end else begin
    case aType of
      ctToEditValue, ctToSummary: Result := aInt.ToString;
      ctToStr: Result := '<Unknown: '+aInt.ToString+'>';
    end;
  end;
end;

function wbConditionFunctionToInt(const aString: string; const aElement: IwbElement): Int64;
begin
  for var i := Low(wbConditionFunctions) to High(wbConditionFunctions) do
    with wbConditionFunctions[i] do
      if SameText(Name, aString) then begin
        Result := Index;
        Exit;
      end;

  Result := StrToInt64(aString);
end;

function wbConditionParam1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  var Desc := wbConditionDescFromIndex(Container.ElementByName['Function'].NativeValue);
  if not Assigned(Desc) then
    Exit;

  var ParamType := Desc.ParamType1;
  var ParamFlag := Container.ElementByName['Type'].NativeValue;

  if ParamType in [ptReference, ptActor, ptPackage] then begin
    if ParamFlag and $02 > 0 then begin
      // except for this func when Run On = Quest Alias, then alias is param3 and package is param1
      // [INFO:00020D3C]
      if not ((Container.ElementByName['Run On'].NativeValue = 5) and (Desc.Name = 'GetIsCurrentPackage')) then
        ParamType := ptAlias    {>>> 'use aliases' is set <<<}
      end
      else if ParamFlag and $08 > 0 then
        ParamType := ptPackdata;  {>>> 'use packdata' is set <<<}
  end;

  Result := Succ(Integer(ParamType));
end;

function wbConditionParam2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  var Desc := wbConditionDescFromIndex(Container.ElementByName['Function'].NativeValue);
  if not Assigned(Desc) then
    Exit;

  var ParamType := Desc.ParamType2;
  var ParamFlag := Container.ElementByName['Type'].NativeValue;

  if ParamType in [ptReference, ptActor, ptPackage] then begin
    if ParamFlag and $02 > 0 then ParamType := ptAlias else {>>> 'use aliases' is set <<<}
    if ParamFlag and $08 > 0 then ParamType := ptPackdata;  {>>> 'use packdata' is set <<<}
  end;

  Result := Succ(Integer(ParamType));
end;

function wbConditionEventToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  var EventFunction := aInt and $FFFF;
  var EventMember := aInt shr 16;
  case aType of
    ctEditType: Result := 'ComboBox';
    ctToSortKey: Result := IntToHex(aInt, 8);
    ctToStr, ctToSummary, ctToEditValue: begin
      Result := wbEventFunctionEnum.ToEditValue(EventFunction, nil);
      Result := Result + ':' + wbEventMemberEnum.ToEditValue(EventMember, nil);
    end;
    ctCheck: begin
      var s1 := wbEventFunctionEnum.Check(EventFunction, nil);
      if s1 <> '' then
        s1 := 'EventFunction' + s1;
      var s2 := wbEventMemberEnum.Check(EventMember, nil);
      if s2 <> '' then
        s2 := 'EventMember' + s2;
      if (s1 <> '') or (s2 <> '') then
        Result := s1 + ':' + s2;
    end;
    ctEditInfo: begin
      var slMember := TStringList.Create;
      slMember.AddStrings(wbEventMemberEnum.EditInfo[nil]);
      with TStringList.Create do try
        for var i := 0 to Pred(wbEventFunctionEnum.NameCount) do
          for var j := 0 to Pred(slMember.Count) do
            Add(wbEventFunctionEnum.Names[i] + ':' + slMember[j]);
        Sort;
        Result := CommaText;
      finally
        Free;
      end;
    end;
  end;
end;

function wbConditionEventToInt(const aString: string; const aElement: IwbElement): Int64;
var
  EventFunction, EventMember: Integer;
begin
  var i := Pos(':', aString);
  if i > 0 then begin
    EventFunction := wbEventFunctionEnum.FromEditValue(Copy(aString, 1, i-1), nil);
    EventMember := wbEventMemberEnum.FromEditValue(Copy(aString, i+1, Length(aString)), nil);
  end
  else begin
    EventFunction := 0;
    EventMember := 0;
  end;
  Result := EventMember shl 16 + EventFunction;
end;

function wbConditionQuestStageToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  EditInfos  : TStringList;
  Stages     : IwbContainerElementRef;
  Stage      : IwbContainerElementRef;
begin
  Result := '';
  case aType of
    ctToSortKey: Exit(IntToHex64(aInt, 8));
    ctToEditValue, ctToSummary: Result := aInt.ToString;
    ctCheck: Result := '<Warning: Could not resolve Parameter 1>';
    ctToStr: Result := aInt.ToString + ' <Warning: Could not resolve Parameter 1>';
  end;

  if not wbTryGetContainerRefFromUnionOrValue(aElement, Container) then
    Exit;

  if not wbTryGetMainRecord(Container.ElementByName['Parameter #1'], MainRecord) then
    Exit;

  // get winning quest override except for partial forms
  if MainRecord.WinningOverride.Flags._Flags and $00004000 = 0 then
    MainRecord := MainRecord.WinningOverride
  else if MainRecord.Flags._Flags and $00004000 <> 0 then
    MainRecord := MainRecord.MasterOrSelf;

  if MainRecord.Signature <> QUST then begin
    case aType of
      ctCheck: Result := '<Warning: "' + MainRecord.ShortName + '" is not a Quest record>';
      ctToStr: Result := aInt.ToString + ' <Warning: "' + MainRecord.ShortName + '" is not a Quest record>';
    end;
    Exit;
  end;

  case aType of
    ctEditType: Exit('ComboBox');
    ctEditInfo: EditInfos := TStringList.Create;
  else
    EditInfos := nil;
  end;

  try
    if Supports(MainRecord.ElementByName['Stages'], IwbContainerElementRef, Stages) then begin
      for var i := 0 to Pred(Stages.ElementCount) do
        if Supports(Stages.Elements[i], IwbContainerElementRef, Stage) then begin
          var j := Stage.ElementNativeValues['INDX\Stage Index'];
          var s := Trim(Stage.ElementValues['Log Entries\Log Entry\CNAM']);
          var t := IntToStr(j);
          while Length(t) < 3 do
            t := '0' + t;
          if s <> '' then
            t := t + ' ' + s;
          if Assigned(EditInfos) then
            EditInfos.AddObject(t, TObject(Integer(j)))
          else if j = aInt then begin
            case aType of
              ctToStr, ctToSummary, ctToEditValue: Result := t;
              ctCheck: Result := '';
            end;
            Exit;
          end;
        end;
    end;

    case aType of
      ctCheck: Result := '<Warning: Quest Stage [' + aInt.ToString + '] not found in "' + MainRecord.Name + '">';
      ctToStr: Result := aInt.ToString + ' <Warning: Quest Stage [' + aInt.ToString + '] not found in "' + MainRecord.Name + '">';
      ctEditInfo: begin
        EditInfos.Sort;
        Result := EditInfos.CommaText;
      end;
    end;
  finally
    FreeAndNil(EditInfos);
  end;
end;

function wbConditionQuestOverlay(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): Int64;
var
  GroupRecord: IwbGroupRecord;
  Element    : IwbElement;
begin
  Result := aInt;
  if (aInt = 0) and (aType in [ctCheck, ctLinksTo, ctToSortKey, ctToStr, ctToSummary]) then begin
    if not Assigned(aElement) then
      Exit;

    var MainRecord := aElement.ContainingMainRecord;
    if not Assigned(MainRecord) then
      Exit;

    if MainRecord.Signature = QUST then
      Result := MainRecord.FixedFormID.ToCardinal
    else if MainRecord.Signature = SCEN then begin
      Element := MainRecord.ElementBySignature[PNAM];
      if Assigned(Element) then
        Result := Element.NativeValue;
    end else if MainRecord.Signature = PACK then begin
      Element := MainRecord.ElementBySignature[QNAM];
      if Assigned(Element) then
        Result := Element.NativeValue;
    end else if MainRecord.Signature = INFO then begin
      // get DIAL for INFO
      if Supports(MainRecord.Container, IwbGroupRecord, GroupRecord) then
        if Supports(GroupRecord.ChildrenOf, IwbMainRecord, MainRecord) then
          if MainRecord.Signature = DIAL then begin
            Element := MainRecord.ElementBySignature[QNAM];
            if Assigned(Element) then
              Result := Element.NativeValue;
          end;
    end;
  end;
end;

function wbGenericModel(aRequired: Boolean = False; aDontShow: TwbDontShowCallback = nil): IwbRecordMemberDef;
begin
  Result :=
    wbRStructSK([0], 'Model', [
      wbString(MODL, 'Model FileName'),
      wbMODT,
      wbMODC,
      wbMODS,
      wbMODF
    ], [], cpNormal, aRequired, aDontShow)
    .SetSummaryKey([0])
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfSummaryNoSortKey)
    .IncludeFlag(dfCollapsed, wbCollapseModels)
    .IncludeFlag(dfAllowAnyMember);
end;

function wbEPFDActorValueToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  AsCardinal : Cardinal;
  AsFloat    : Single;
begin
  AsCardinal := aInt;
  AsFloat := PSingle(@AsCardinal)^;
  aInt := Round(AsFloat);
  case aType of
    ctToStr, ctToSummary: Result := wbActorValueEnum.ToString(aInt, aElement, aType = ctToSummary);
    ctToSortKey: Result := wbActorValueEnum.ToSortKey(aInt, aElement);
    ctCheck: Result := wbActorValueEnum.Check(aInt, aElement);
    ctToEditValue: Result := wbActorValueEnum.ToEditValue(aInt, aElement);
    ctEditType: Result := 'ComboBox';
    ctEditInfo: Result := wbActorValueEnum.EditInfo[aElement].ToCommaText;
  end;
end;

function wbEPFDActorValueToInt(const aString: string; const aElement: IwbElement): Int64;
var
  AsCardinal : Cardinal;
  AsFloat    : Single;
begin
  AsFloat := wbActorValueEnum.FromEditValue(aString, aElement);
  PSingle(@AsCardinal)^ := AsFloat;
  Result := AsCardinal;
end;

function wbPerkDATAQuestStageToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
  Param1     : IwbElement;
  MainRecord : IwbMainRecord;
  EditInfos  : TStringList;
  Stages     : IwbContainerElementRef;
  Stage      : IwbContainerElementRef;
  i, j       : Integer;
  s, t       : string;
begin
  case aType of
    ctToStr, ctToSummary: begin
      Result := aInt.ToString;
      if aType = ctToStr then
        Result := Result + ' <Warning: Could not resolve Quest>';
    end;
    ctToEditValue: Result := aInt.ToString;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Quest>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not wbTryGetContainerRefFromUnionOrValue(aElement, Container) then
    Exit;

  Param1 := Container.ElementByName['Quest'];
  if not wbTryGetMainRecord(Param1, MainRecord) then
    Exit;

  // get winning quest override except for partial forms
  if MainRecord.WinningOverride.Flags._Flags and $00004000 = 0 then
    MainRecord := MainRecord.WinningOverride
  else if MainRecord.Flags._Flags and $00004000 <> 0 then
    MainRecord := MainRecord.MasterOrSelf;

  if MainRecord.Signature <> QUST then begin
    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: "'+MainRecord.ShortName+'" is not a Quest record>';
      end;
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" is not a Quest record>';
    end;
    Exit;
  end;

  case aType of
    ctEditType: begin
      Result := 'ComboBox';
      Exit;
    end;
    ctEditInfo:
      EditInfos := TStringList.Create;
  else
    EditInfos := nil;
  end;
  try
    if Supports(MainRecord.ElementByName['Stages'], IwbContainerElementRef, Stages) then begin
      for i := 0 to Pred(Stages.ElementCount) do
        if Supports(Stages.Elements[i], IwbContainerElementRef, Stage) then begin
          j := Stage.ElementNativeValues['INDX\Stage Index'];
          s := Trim(Stage.ElementValues['Log Entries\Log Entry\CNAM']);
          t := IntToStr(j);
          while Length(t) < 3 do
            t := '0' + t;
          if s <> '' then
            t := t + ' ' + s;
          if Assigned(EditInfos) then
            EditInfos.AddObject(t, TObject(j))
          else if j = aInt then begin
            case aType of
              ctToStr, ctToSummary, ctToEditValue: Result := t;
              ctCheck: Result := '';
            end;
            Exit;
          end;
        end;
    end;

    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: Quest Stage [' + aInt.ToString + '] not found in "' + MainRecord.Name + '">';
      end;
      ctCheck: Result := '<Warning: Quest Stage [' + aInt.ToString + '] not found in "' + MainRecord.Name + '">';
      ctEditInfo: begin
        EditInfos.Sort;
        Result := EditInfos.CommaText;
      end;
    end;
  finally
    FreeAndNil(EditInfos);
  end;
end;

function wbStringToInt(const aString: string; const aElement: IwbElement): Int64;
begin
  Result := StrToIntDef(aString, 0);
end;

function wbOBTEAddonIndexToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  MainRecord, OMOD: IwbMainRecord;
  Includes, Include: IwbContainer;
  Entries, Entry: IwbContainerElementRef;
  i, j, AddonIndex: Integer;
  bFoundOverride: Boolean;
begin
  Result := '';
  case aType of
    ctToStr, ctToSummary, ctToEditValue: Result := aInt.ToString;
    ctCheck: begin

      AddonIndex := aInt;

      // check index override from "AddonIndex" property of Includes
      bFoundOverride := False;
      if Assigned(aElement.Container) and Supports(aElement.Container.ElementByName['Includes'], IwbContainer, Includes) then
        for i := 0 to Pred(Includes.ElementCount) do begin
          if not Supports(Includes.Elements[i], IwbContainer, Include) then
            Continue;
          if not Supports(Include.ElementLinksTo['Mod'], IwbMainRecord, OMOD) then
            Continue;
          if not Supports(OMOD.ElementByPath['DATA\Properties'], IwbContainerElementRef, Entries) then
            Continue;
          for j := 0 to Pred(Entries.ElementCount) do
            if Supports(Entries.Elements[j], IwbContainerElementRef, Entry) then
              if Entry.ElementEditValues['Property'] = 'AddonIndex' then begin
                AddonIndex := Entry.ElementNativeValues['Value 1 - Int'];
                bFoundOverride := True;
                Break;
              end;

          if bFoundOverride then
            Break;
        end;

      if AddonIndex = -1 then
        Exit;

      MainRecord := aElement.ContainingMainRecord;
      if not Assigned(MainRecord) then
        Exit;

      if Supports(MainRecord.ElementByName['Models'], IwbContainerElementRef, Entries) then
        for i := 0 to Pred(Entries.ElementCount) do
          if Supports(Entries.Elements[i], IwbContainerElementRef, Entry) then
            if Entry.ElementNativeValues['INDX'] = AddonIndex then
              Exit;

      Result := '<Warning: Invalid Addon Index ' + IntToStr(AddonIndex) + '>';
    end;
  end;
end;

procedure wbMESGDNAMAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  OldValue, NewValue : Integer;
  Container          : IwbContainerElementRef;
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;

  if not Supports(aElement.Container, IwbContainerElementRef, Container) then
    Exit;

  OldValue := Integer(aOldValue) and 1;
  NewValue := Integer(aNewValue) and 1;

  if NewValue = OldValue then
    Exit;

  if NewValue = 1 then
    Container.RemoveElement('TNAM')
  else
    Container.Add('TNAM', True);
end;

procedure wbGMSTEDIDAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  OldValue, NewValue : string;
  Container          : IwbContainerElementRef;
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;

  if not Supports(aElement.Container, IwbContainerElementRef, Container) then
    Exit;

  OldValue := aOldValue;
  NewValue := aNewValue;

  if (Length(OldValue) < 1) or (Length(OldValue) < 1) or (OldValue[1] <> NewValue[1]) then begin
    Container.RemoveElement('DATA');
    Container.Add('DATA', True);
  end;
end;

procedure wbFLSTEDIDAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  OldValue, NewValue     : string;
  OldOrdered, NewOrdered : Boolean;
  Container              : IwbContainerElementRef;
const
  OrderedList = 'OrderedList';
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;

  if not Supports(aElement.Container, IwbContainerElementRef, Container) then
    Exit;

  OldValue := aOldValue;
  NewValue := aNewValue;

  if Length(OldValue) > Length(OrderedList) then
    Delete(OldValue, 1, Length(OldValue)-Length(OrderedList));

  if Length(NewValue) > Length(OrderedList) then
    Delete(NewValue, 1, Length(NewValue)-Length(OrderedList));

  OldOrdered := SameText(OldValue, OrderedList);
  NewOrdered := SameText(NewValue, OrderedList);

  if OldOrdered <> NewOrdered then
    Container.RemoveElement('FormIDs');
end;

procedure wbAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  Exit;
end;

{>>> Needs revision for Skyrim <<<}
//function wbIdleAnam(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
//begin
//  Result := '';
//  case aType of
//    ctToStr, ctToSummary: begin
//      case aInt and not $C0 of
//        0: Result := 'Idle';
//        1: Result := 'Movement';
//        2: Result := 'Left Arm';
//        3: Result := 'Left Hand';
//        4: Result := 'Weapon';
//        5: Result := 'Weapon Up';
//        6: Result := 'Weapon Down';
//        7: Result := 'Special Idle';
//       20: Result := 'Whole Body';
//       21: Result := 'Upper Body';
//      else
//        Result := '<Unknown: '+IntToStr(aInt and not $C0)+'>';
//      end;
//
//      if (aInt and $80) = 0 then
//        Result := Result + ', Must return a file';
//      if (aInt and $40) = 1 then
//        Result := Result + ', Unknown Flag';
//    end;
//    ctToSortKey: begin
//      Result := IntToHex64(aInt, 2);
//    end;
//    ctCheck: begin
//      case aInt and not $C0 of
//        0..7, 20, 21: Result := '';
//      else
//        Result := '<Unknown: '+IntToStr(aInt and not $C0)+'>';
//      end;
//    end;
//  end;
//end;

function wbShortXYtoStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  x, y: SmallInt;
begin
  y := aInt and $FFFF;
  x := aInt shr 16 and $FFFF;
  Result := '';
  case aType of
    ctToStr, ctToSummary, ctToEditValue: Result := Format('%d, %d', [x, y]);
    ctCheck: Result := '';
  end;
end;

function wbStrToShortXY(const aString: string; const aElement: IwbElement): Int64;
var
  x, y: SmallInt;
  Value: Cardinal;
begin
  y := StrToIntDef(Copy(aString, 1, Pred(Pos(', ', aString))), 0);
  x := StrToIntDef(Copy(aString, Pos(', ', aString) + 2, Length(aString)), 0);
  PWord(@Value)^ := x;
  PWord(Cardinal(@Value) + SizeOf(SmallInt))^ := y;
  Result := Value;
end;

function wbINFOGroupDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  MainRecord: IwbMainRecord;
begin
  Result := 0;
  if not Assigned(aElement) then
    Exit;
  MainRecord := aElement.GetContainingMainRecord;
  if not Assigned(MainRecord) then
    Exit;

  if (MainRecord.Flags._Flags and $40) > 0 then
    Result := 1;
end;

function wbMGEFAssocItemDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  Archtype      : Variant;
  DataContainer : IwbDataContainer;
  Element       : IwbElement;
const
  OffsetArchtype = 56;

begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  VarClear(ArchType);
  Element := Container.ElementByName['Archetype'];

  if Assigned(Element) then
    ArchType := Element.NativeValue
  else if Supports(Container, IwbDataContainer, DataContainer) and
          DataContainer.IsValidOffset(aBasePtr, aEndPtr, OffsetArchtype) then begin // we are part a proper structure
      aBasePtr := PByte(aBasePtr) + OffsetArchtype;
      ArchType := PCardinal(aBasePtr)^;
    end;

  if VarIsEmpty(ArchType) then
    Exit;

  case Integer(ArchType) of
    12: Result := 1; // Light
    17: Result := 2; // Bound Item
    18: Result := 3; // Summon Creature
    25: Result := 4; // Guide
    34: Result := 8; // Peak Mod
    35: Result := 5; // Cloak
    36: Result := 6; // Werewolf
    39: Result := 7; // Enhance Weapon
    40: Result := 4; // Spawn Hazard
    45: Result := 9; // Damage Type
    46: Result := 9; // Immunity
  end;
end;

procedure wbMGEFAssocItemAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container : IwbContainer;
  Element   : IwbElement;
begin
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  if not (aNewValue <> 0) then
    Exit;

  Element := Container.ElementByName['Archetype'];
  if Assigned(Element) and (Element.NativeValue = 0) then
      Element.NativeValue := $FF; // Signals ArchType that it should not mess with us on the next change!
        // I assume this will alo protect Second AV Weight (The two actor values are after ArchType)
end;

procedure wbMGEFAV2WeightAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container : IwbContainer;
  Element   : IwbElement;
begin
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  if not (aNewValue <> 0.0) then
    Exit;

  Element := Container.ElementByName['Archetype'];
  if Assigned(Element) and (Element.NativeValue = 0) then
      Element.NativeValue := $FF; // Signals ArchType that it should not mess with us on the next change!
end;

procedure wbMGEFArchtypeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container: IwbContainerElementRef;
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if (aNewValue < $FF) and (aOldValue < $FF) then begin
    Container.ElementNativeValues['..\Assoc. Item'] := 0;
    case Integer(aNewValue) of
      06: Container.ElementNativeValues['..\Actor Value'] := 00;//Agression
      07: Container.ElementNativeValues['..\Actor Value'] := 01;//Confidence
      08: Container.ElementNativeValues['..\Actor Value'] := 00;//Agression
      11: Container.ElementNativeValues['..\Actor Value'] := 54;//Invisibility
      21: Container.ElementNativeValues['..\Actor Value'] := 53;//Paralysis
      24: Container.ElementNativeValues['..\Actor Value'] := 01;//Confidence
      38: Container.ElementNativeValues['..\Actor Value'] := 01;//Confidence
      42: Container.ElementNativeValues['..\Actor Value'] := 01;//Confidence
    else
      Container.ElementNativeValues['..\Actor Value'] := -1;
    end;
    Container.ElementNativeValues['..\Second Actor Value'] := -1;
    Container.ElementNativeValues['..\Second AV Weight'] := 0.0;
  end;
end;

function wbSubrecordSizeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  SubRecord : IwbSubRecord;
begin
  Result := 0;
  if not Assigned(aElement) then
    Exit;

  if not Supports(aElement, IwbSubRecord, SubRecord) then
    Exit;

  if SubRecord.DataSize > 0 then
    Result := 1;
end;

function wbFLSTLNAMIsSorted(const aContainer: IwbContainer): Boolean;
var
  rEDID      : IwbRecord;
  s          : string;
const
  OrderedList = 'OrderedList';
begin
  Result := False; {>>> Should not be sorted according to Arthmoor and JustinOther <<<}
  rEDID := aContainer.RecordBySignature[EDID];
  if not Assigned(rEDID) then
    Exit;

  s := rEDID.Value;
  if Length(s) > Length(OrderedList) then
    Delete(s, 1, Length(s)-Length(OrderedList));

  if SameText(s, OrderedList) then
    Result := False;
end;

function wbPerkDATADecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rPRKE: IwbRecord;
  eType: IwbElement;
begin
  Result := 0;
  if not Assigned(aElement) then
    Exit;
  rPRKE := aElement.Container.RecordBySignature[PRKE];
  if not Assigned(rPRKE) then
    Exit;

  eType := rPRKE.ElementByName['Type'];
  if not Assigned(eType) then
    Exit;

  Result := eType.NativeValue;
end;

function wbEPFDDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainerElementRef;
begin
  Result := 0;
  if not Assigned(aElement) then
    Exit;

  if not Supports(aElement.Container, IwbContainerElementRef, Container) then
    Exit;

  Result := Container.ElementNativeValues['EPFT'];

  if Result = 2 then
    case Integer(Container.ElementNativeValues['..\DATA\Entry Point\Function']) of
      5, 12, 13, 14: Result := 8;
    end;
end;

function wbSceneActionSoundDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainerElementRef;
begin
  Result := 0;
  if not Assigned(aElement) then
    Exit;

  if not Supports(aElement.Container, IwbContainerElementRef, Container) then
    Exit;

  if Container.ElementNativeValues['ANAM'] <> 4 then
    Result := 1;
end;

function wbAECHDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container  : IwbContainer;
  rKNAM      : IwbElement;
  s: string;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  Container := Container.Container;
  if not Assigned(Container) then
    Exit;

  rKNAM := Container.ElementBySignature['KNAM'];
  if not Assigned(rKNAM) then
    Exit;

  s := rKNAM.EditValue;

  // TODO: is using EditValue the best way to do this?
  if s = 'BSOverdrive' then
    Result := 0
  else if s = 'BSStateVariableFilter' then
    Result := 1
  else if s = 'BSDelayEffect' then
    Result := 2;
end;

function wbCLFMColorToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainer;
  rFNAM      : IwbElement;
  i          : Integer;
  s          : string;
begin
  i := 0;
  Container := aElement.Container;
  if Assigned(Container) then begin
    rFNAM := Container.ElementBySignature['FNAM'];
    if Assigned(rFNAM) then
      i := rFNAM.NativeValue;
  end;

  if i and 2 <> 0 then
    s := FloatToStrF(PSingle(@aInt)^, ffFixed, 99, wbFloatDigits)
  else
    s := 'rgba(' + IntToStr(aInt and $FF) + ', ' +
                   IntToStr(aInt shr 8 and $FF) + ', ' +
                   IntToStr(aInt shr 16 and $FF) + ', ' +
                   IntToStr(aInt shr 24 and $FF) + ')';

  case aType of
    ctToStr, ctToSummary: Result := s;
    ctToSortKey: Result := IntToHex(aInt, 8);
    ctToEditValue: Result := s;
  end;
end;

function wbCLFMColorToInt(const aString: string; const aElement: IwbElement): Int64;
var
  s: string;
  value: Single;
begin
  if SameText(Copy(aString, 1, 5), 'rgba(') then begin
    s := Copy(aString, 6, Pos(')', aString) - 6);
    with TStringList.Create do try
      Delimiter := ',';
      StrictDelimiter := True;
      DelimitedText := s;
      Result := 0;
      if Count = 4 then begin
        PByte(@Result)[0] := StrToIntDef(Strings[0], 0);
        PByte(@Result)[1] := StrToIntDef(Strings[1], 0);
        PByte(@Result)[2] := StrToIntDef(Strings[2], 0);
        PByte(@Result)[3] := StrToIntDef(Strings[3], 0);
      end;
    finally
      Free;
    end;
    Exit;
  end;

  try
    value := StrToFloat(aString)
  except
    value := 0.0
  end;

  Result := PInteger(@value)^;
end;

function wbSNDRDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container  : IwbContainer;
  rCNAM      : IwbElement;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  Container := Container.Container;
  if not Assigned(Container) then
    Exit;

  rCNAM := Container.ElementBySignature['CNAM'];
  if not Assigned(rCNAM) then
    Exit;

  // TODO: F076 definition uses rCNAM.NativeValue = Int64($ED157AE3)
  if rCNAM.EditValue = 'AutoWeapon' then
    Result := 1;
end;


{>>> For VMAD <<<}
function wbScriptPropertyDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
begin
  Result := 0;

  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  case Integer(Container.ElementNativeValues['Type']) of
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

function wbScriptPropertyStructMemberDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  case Integer(Container.ElementNativeValues['Type']) of
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

procedure wbScriptPropertyTypeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container : IwbContainerElementRef;
begin
  if aOldValue <> aNewValue then
    if Supports(aElement.Container, IwbContainerElementRef, Container) then
      Container.ElementByName['Value'].SetToDefault;
end;

procedure wbScriptFragmentsQuestScriptNameAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container : IwbContainerElementRef;
begin
  if aOldValue <> aNewValue then
    if (aOldValue = '') <> (aNewValue = '') then
      if Supports(aElement.Container, IwbContainerElementRef, Container) then
        Container.ElementByName['Script'].SetToDefault;
end;

procedure wbAECHTypeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container      : IwbContainerElementRef;
  ValueContainer : IwbContainerElementRef;
begin
  if aOldValue <> aNewValue then
    if Supports(aElement.Container, IwbContainerElementRef, Container) then
      if Supports(Container.ElementByPath['DNAM\Value'], IwbContainerElementRef, ValueContainer) then
        ValueContainer.SetToDefault;
end;


{>>> For VMAD <<<}
function wbScriptFragmentsDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container  : IwbContainer;
  MainRecord : IwbMainRecord;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  while Assigned(Container) and (Container.ElementType <> etMainRecord) do
    Container := Container.Container;

  if not Assigned(Container) then
    Exit;

  // TODO: should this assume there's a MainRecord?
  Supports(Container, IwbMainRecord, MainRecord);

  if MainRecord.Signature = PERK then
    Result := 1
  else if MainRecord.Signature = TERM then
    Result := 1
  else if MainRecord.Signature = INFO then
    Result := 2
  else if MainRecord.Signature = PACK then
    Result := 3
  else if MainRecord.Signature = QUST then
    Result := 4
  else if MainRecord.Signature = SCEN then
    Result := 5;
end;

{>>> For VMAD <<<}
function wbScriptFragmentsInfoCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container     : IwbContainer;
  F             : Integer;
  i             : Integer;
begin
  Result := 0;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;

  if not Assigned(Container) then
    Exit;

  while Assigned(Container) and (Container.Name <> 'Script Fragments') do
    Container := Container.Container;

  if not Assigned(Container) then
    Exit;

  F := Container.ElementByName['Flags'].NativeValue;
  for i := 0 to 2 do begin
    if (F and 1) = 1 then
      Inc(Result);
    F := F shr 1;
  end;

  for i := 3 to 7 do begin
    if (F and 1) = 1 then begin
      Inc(Result);
      if wbHasProgressCallback then
        wbProgressCallback('==='+aElement.Name+'       ['+Container.Name+':'+Container.Path+'] = unknown info VMAD flag bit '+IntToStr(i));
    end;
    F := F shr 1;
  end;
end;

{>>> For VMAD <<<}
function wbScriptFragmentsSceneCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container     : IwbContainer;
  F             : Integer;
  i             : Integer;
begin
  Result := 0;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;

  if not Assigned(Container) then
    Exit;

  while Assigned(Container) and (Container.Name <> 'Script Fragments') do
    Container := Container.Container;

  if not Assigned(Container) then
    Exit;

  F := Container.ElementByName['Flags'].NativeValue;
  for i := 0 to 2 do begin
    if (F and 1) = 1 then
      Inc(Result);
    F := F shr 1;
  end;

  for i := 3 to 7 do begin
    if (F and 1) = 1 then begin
      Inc(Result);
      if wbHasProgressCallback then
        wbProgressCallback('==='+aElement.Name+'       ['+Container.Name+':'+Container.Path+'] = unknown scene VMAD flag bit '+IntToStr(i));
    end;
    F := F shr 1;
  end;
end;

{>>> For VMAD <<<}
function wbScriptFragmentsPackCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container     : IwbContainer;
  F             : Integer;
  i             : Integer;
begin
  Result := 0;
  if aElement.ElementType = etValue then
    Container := aElement.Container
  else
    Container := aElement as IwbContainer;

  if not Assigned(Container) then
    Exit;

  while Assigned(Container) and (Container.Name <> 'Script Fragments') do
    Container := Container.Container;

  if not Assigned(Container) then
    Exit;

  F := Container.ElementByName['Flags'].NativeValue;
  for i := 0 to 7 do begin
    if (F and 1) = 1 then
      Inc(Result);
    F := F shr 1;
  end;
end;

{>>> For VMAD <<<}
function wbScriptFragmentsEmptyScriptDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container  : IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  if Container.ElementEditValues['ScriptName'] = '' then
    Result := 1;
end;

function wbBOOKTeachesDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
  i: Int64;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  i := Container.ElementByName['Flags'].NativeValue;
  if i and $01 <> 0 then
    Result := 1
  else if i and $04 <> 0 then
    Result := 2
  else if i and $10 <> 0 then
    Result := 3
  else
    Result := 0;
end;

function wbMESGTNAMDontShow(const aElement: IwbElement): Boolean;
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  Result := False;
  if not Supports(aElement, IwbMainRecord, MainRecord) then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if Integer(Container.ElementNativeValues['DNAM']) and 1 <> 0 then
    Result := True;
end;

function wbEPFDDontShow(const aElement: IwbElement): Boolean;
var
  Container: IwbContainerElementRef;
begin
  Result := False;
  if aElement.Name <> 'Entry Point Function Parameters' then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if not (Integer(Container.ElementNativeValues['EPFT']) in [1..3]) then
    Result := True;
end;

function wbTES4ONAMDontShow(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  if not Assigned(aElement) then
    Exit;

  MainRecord := aElement.ContainingMainRecord;
  if not Assigned(MainRecord) then
    Exit;

  if not MainRecord.IsESM then
    Result := True;
end;

function wbEPF2DontShow(const aElement: IwbElement): Boolean;
var
  Container: IwbContainerElementRef;
begin
  Result := False;
  if aElement.Name <> 'Entry Point Function Parameters' then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if not (Integer(Container.ElementNativeValues['EPFT']) in [4]) then
    Result := True;
end;

function wbActorTemplateUseTraits(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  Element := aElement;
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if not Assigned(MainRecord) then
    Exit;

  i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
  Result := (i and $00000001) <> 0;
end;

function wbActorTemplateUseStats(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  Element := aElement;
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if not Assigned(MainRecord) then
    Exit;

  i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
  Result := (i and $00000002) <> 0;
end;

function wbActorAutoCalcDontShow(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  Element := aElement;
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if not Assigned(MainRecord) then
    Exit;

  i := MainRecord.ElementNativeValues['ACBS\Flags'];
  Result := (i and $00000010) <> 0;
end;

function wbActorTemplateUseStatsAutoCalc(const aElement: IwbElement): Boolean;
begin
  Result := wbActorTemplateUseStats(aElement) or wbActorAutoCalcDontShow(aElement);
end;

function wbActorTemplateUseFactions(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  Element := aElement;
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if not Assigned(MainRecord) then
    Exit;

  i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
  Result := (i and $00000004) <> 0;
end;

function wbActorTemplateUseActorEffectList(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  Element := aElement;
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if not Assigned(MainRecord) then
    Exit;

  i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
  Result := (i and $00000008) <> 0;
end;

function wbActorTemplateUseAIData(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  Element := aElement;
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if not Assigned(MainRecord) then
    Exit;

  i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
  Result := (i and $00000010) <> 0;
end;

function wbActorTemplateUseAIPackages(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  Element := aElement;
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if not Assigned(MainRecord) then
    Exit;

  i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
  Result := (i and $00000020) <> 0;
end;

function wbActorTemplateUseModelAnimation(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  Element := aElement;
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if not Assigned(MainRecord) then
    Exit;

  i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
  Result := (i and $00000040) <> 0;
end;

function wbActorTemplateUseBaseData(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  Element := aElement;
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if not Assigned(MainRecord) then
    Exit;

  i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
  Result := (i and $00000080) <> 0;
end;

function wbActorTemplateUseInventory(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  Element := aElement;
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if not Assigned(MainRecord) then
    Exit;

  i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
  Result := (i and $00000100) <> 0;
end;

function wbActorTemplateUseScript(const aElement: IwbElement): Boolean;
var
  Element    : IwbElement;
  MainRecord : IwbMainRecord;
  i          : Int64;
begin
  Result := False;
  Element := aElement;
  MainRecord := nil;

  while Assigned(Element) and not Supports(Element, IwbMainRecord, MainRecord) do
    Element := Element.Container;

  if not Assigned(MainRecord) then
    Exit;

  i := MainRecord.ElementNativeValues['ACBS\Template Flags'];
  Result := (i and $00000200) <> 0;
end;

procedure wbReplaceBODTwithBOD2(const aElement: IwbElement);
var
  MainRecord    : IwbMainRecord;
  ContainerBOD2 : IwbContainerElementRef;
  ContainerBODT : IwbContainerElementRef;
begin
  Exit; {>>> Looks like causes problems with Dawnguard.esm <<<}

  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if not Supports(MainRecord.ElementBySignature[BODT], IwbContainerElementRef, ContainerBODT) then
      Exit;

    if not Supports(MainRecord.Add('BOD2', True), IwbContainerElementRef, ContainerBOD2) then
      Exit;

    ContainerBOD2.ElementNativeValues['First Person Flags'] := ContainerBODT.ElementNativeValues['First Person Flags'];
    ContainerBOD2.ElementNativeValues['Armor Type'] := ContainerBODT.ElementNativeValues['Armor Type'];
    MainRecord.RemoveElement(BODT);
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbARMOAfterLoad(const aElement: IwbElement);
begin
  wbReplaceBODTwithBOD2(aElement);
end;

procedure wbARMAAfterLoad(const aElement: IwbElement);
{var
  MainRecord    : IwbMainRecord;}
begin
  wbReplaceBODTwithBOD2(aElement);
  {if wbBeginInternalEdit then try
    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;
    if MainRecord.ElementNativeValues['DNAM\Weight slider - Male'] = 0 then
      MainRecord.ElementNativeValues['DNAM\Weight slider - Male'] := 2;
    if MainRecord.ElementNativeValues['DNAM\Weight slider - Female'] = 0 then
      MainRecord.ElementNativeValues['DNAM\Weight slider - Female'] := 2;
  finally
    wbEndInternalEdit;
  end;}
end;

procedure wbCheckMorphKeyOrder(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  Master     : IwbMainRecord;
  MasterContainer : IwbContainerElementRef;
  lKeys       : IwbContainerElementRef;
  lMasterKeys : IwbContainerElementRef;
  lValues     : IwbContainerElementRef;
  i, j, k    : Integer;
  NeedsSort  : Boolean;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    Master := MainRecord.Master;
    if not Assigned(Master) then
      Exit;

    if not Supports(Master, IwbContainerElementRef, MasterContainer) then
      Exit;

    if not Supports(Container.ElementBySignature['MSDK'], IwbContainerElementRef, lKeys) then
      Exit;

    if not Supports(MasterContainer.ElementBySignature['MSDK'], IwbContainerElementRef, lMasterKeys) then
      Exit;

    if lKeys.ElementCount < lMasterKeys.ElementCount then
      Exit;

    if not Supports(Container.ElementBySignature['MSDV'], IwbContainerElementRef, lValues) then
      Exit;

    if lKeys.ElementCount <> lValues.ElementCount then
      Exit;

    with TStringList.Create do try
      for i := 0 to Pred(lMasterKeys.ElementCount) do
        AddObject(lMasterKeys.Elements[i].SortKey[True], Pointer(i));
      Sorted := True;

      NeedsSort := False;
      j := lMasterKeys.ElementCount;
      for i := 0 to Pred(lKeys.ElementCount) do
        if Find(lKeys.Elements[i].SortKey[True], k) then begin
          k := Integer(Objects[k]);
          if k <> i then
            NeedsSort := True;
          lKeys.Elements[i].SortOrder := k;
          lValues.Elements[i].SortOrder := k;
        end else begin
          lKeys.Elements[i].SortOrder := j;
          lValues.Elements[i].SortOrder := j;
          Inc(j);
        end;

      if not NeedsSort then
        Exit;

      if j <> lKeys.ElementCount then
        Exit;

      lKeys.SortBySortOrder;
      lValues.SortBySortOrder;
    finally
      Free;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbNPCAfterLoad(const aElement: IwbElement);
begin
  wbCheckMorphKeyOrder(aElement);
end;

procedure wbREFRAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if not Container.ElementExists['XLOC'] then
      Exit;

    if Container.ElementNativeValues['XLOC - Lock Data\Level'] = 0 then
      Container.ElementNativeValues['XLOC - Lock Data\Level'] := 1;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbWEAPAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  Flags      : Cardinal;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    // clear IronSights flags which are randomly assigned in CK
    if not Container.ElementExists['DNAM'] then
      Exit;

    Flags := Container.ElementNativeValues['DNAM - Data\Flags'];
    Flags := Flags and ($FFFF xor $0040);
    Container.ElementNativeValues['DNAM - Data\Flags'] := Flags;

    Flags := Container.ElementNativeValues['DNAM - Data\Flags2'];
    Flags := Flags and ($FFFFFFFF xor $0100);
    Container.ElementNativeValues['DNAM - Data\Flags2'] := Flags;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbCELLXCLWGetConflictPriority(const aElement: IwbElement; var aCP: TwbConflictPriority);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  DataRec    : IwbElement;
  Flags      : Cardinal;
begin
  if not Assigned(aElement) then
    Exit;

  if not Supports(aElement.Container, IwbContainerElementRef, Container) then
    Exit;

  if Container.ElementCount < 1 then
    Exit;

  if not Supports(Container, IwbMainRecord, MainRecord) then
    Exit;

  if MainRecord.IsDeleted then
    Exit;

  DataRec := MainRecord.ElementBySignature[DATA];
  if not Assigned(DataRec) then
    Exit;

  Flags := DataRec.NativeValue;

  {0x0001 Is Interior Cell}
  if (Flags and 1) = 1 then
    {Interior cells don't use water level in Skyrim at all}
    aCP := cpIgnore;
end;

procedure wbCELLDATAAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container : IwbContainer;
begin
  if not Assigned(aElement) then
    Exit;

  Container := aElement.Container;

  while Assigned(Container) and not (Container.Def.DefType = dtRecord) do
    Container := Container.Container;

  if Assigned(Container) then
    Container.ResetConflict;
end;

procedure wbCELLAfterLoad(const aElement: IwbElement);
var
  Container    : IwbContainerElementRef;
//  Container2   : IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
  DataSubRec   : IwbSubrecord;
  Flags        : Byte;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if Supports(Container.ElementBySignature['DATA'] , IwbSubRecord, DataSubRec) then begin
      // expand itU8 flags to itU16
      if DataSubRec.SubRecordHeaderSize = 1 then begin
        Flags := PByte(DataSubRec.DataBasePtr)^;
        DataSubRec.SetToDefault;
        DataSubRec.NativeValue := Flags;
      end;
      // 'Default' water height for exterior cells if not set (so water height will be taken from WRLD by game)
      if (not Container.ElementExists['XCLW']) and ((Integer(DataSubRec.NativeValue) and $02) <> 0) then begin
        Container.Add('XCLW', True);
        Container.ElementEditValues['XCLW'] := 'Default';
      end;
    end;

    // Min (-0 as in CK) water height is set to 0 when saving in CK
    if Container.ElementEditValues['XCLW'] = 'Min' then
      Container.ElementEditValues['XCLW'] := '0.0';

//    if Supports(Container.ElementBySignature[XCLR], IwbContainerElementRef, Container2) then begin
//      for i := Pred(Container2.ElementCount) downto 0 do
//        if not Supports(Container2.Elements[i].LinksTo, IwbMainRecord, MainRecord) or (MainRecord.Signature <> 'REGN') then
//          Container2.RemoveElement(i);
//      if Container2.ElementCount < 1 then
//        Container2.Remove;
//    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbMESGAfterLoad(const aElement: IwbElement);
var
  Container    : IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
  IsMessageBox : Boolean;
  HasTimeDelay : Boolean;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    IsMessageBox := (Integer(Container.ElementNativeValues['DNAM']) and 1) = 1;
    HasTimeDelay := Container.ElementExists['TNAM'];

    if not (IsMessageBox = HasTimeDelay) then
      Exit;
    
  if IsMessageBox then
      Container.RemoveElement('TNAM')
    else begin
      if not Container.ElementExists['DNAM'] then
        Container.Add('DNAM', True);
      Container.ElementNativeValues['DNAM'] := Integer(Container.ElementNativeValues['DNAM']) or 1;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbEFITAfterLoad(const aElement: IwbElement);
var
  Container : IwbContainerElementRef;
  Element   : IwbElement;
  ActorValue: Variant;
  MainRecord: IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    MainRecord := Container.ContainingMainRecord;
    if not Assigned(MainRecord) or MainRecord.IsDeleted then
      Exit;

    Element := Container.ElementByPath['..\EFID'];
    if not wbTryGetMainRecord(Element, MainRecord, 'MGEF') then
      Exit;

    ActorValue := MainRecord.ElementNativeValues['DATA - Data\Actor Value'];
    if VarIsNull(ActorValue) or VarIsClear(ActorValue) then
      Exit;

    if VarCompareValue(ActorValue, Container.ElementNativeValues['Actor Value']) <> vrEqual then
      Container.ElementNativeValues['Actor Value'] := ActorValue;
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbLLEAfterLoad(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  Entries    : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  i          : integer;
begin
  if wbBeginInternalEdit then try
    // zero entries' Chance None if Form Version < 69
    if wbFormVersionDecider(69)(nil, nil, aElement) = 1 then
      Exit;

    if not Supports(aElement, IwbContainerElementRef, Container) then
      Exit;

    if Container.ElementCount < 1 then
      Exit;

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.IsDeleted then
      Exit;

    if not Supports(MainRecord.ElementByName['Leveled List Entries'], IwbContainerElementRef, Entries) then
      Exit;

    for i := 0 to Pred(Entries.ElementCount) do begin
      if not Supports(Entries.Elements[i], IwbContainerElementRef, Container) then
        Exit;
      Container.ElementNativeValues['LVLO\Chance None'] := 0;
    end;
  finally
    wbEndInternalEdit;
  end;
end;

function wbPubPackCNAMDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rANAM: IwbRecord;
  ctype: string;
begin
  Result := 0;

  if not Assigned(aElement) then
    Exit;

  rANAM := aElement.Container.RecordBySignature[ANAM];
  if not Assigned(rANAM) then
    Exit;

  ctype := rANAM.NativeValue;
  if ctype = 'Bool' then Result := 1 else
  if ctype = 'Int' then Result := 2 else
  if ctype = 'Float' then Result := 3 else
  if ctype = 'ObjectList' then Result := 3;
end;

function wbTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
  Element   : IwbElement;
begin
  Result := 0;

  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  Element := Container.ElementByName['Type'];

  if Assigned(Element) then
    Result := Element.NativeValue
  else if wbMoreInfoForDecider then
    wbProgressCallback('"'+Container.Name+'" does not contain an element named Type');
end;

procedure wbPackageDataInputValueTypeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container : IwbContainerElementRef;
  Value     : IwbElement;
begin
  if aOldValue <> aNewValue then
    if Supports(aElement.Container, IwbContainerElementRef, Container) then begin
      Value := Container.ElementByPath['CNAM'];
      if Assigned(Value) then
        if (aNewValue = 'Bool') or (aNewValue = 'Int') or (aNewValue = 'Float') or (aNewValue = 'ObjectList') then
          Value.SetToDefault
        else
          Value.Remove
      else
        if (aNewValue = 'Bool') or (aNewValue = 'Int') or (aNewValue = 'Float') or (aNewValue = 'ObjectList') then
          Container.Add('CNAM');
    end;
end;

procedure wbOMODpropertyAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('Property Count', aElement);
end;

procedure wbOMODincludeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('Include Count', aElement);
end;

procedure wbOMODdataAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterContainerAfterSet('Property Count', 'Properties', aElement);
  wbCounterContainerAfterSet('Include Count', 'Includes', aElement);
end;

function wbOMODDataIncludeCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container       : IwbContainer;
begin
  Result := 0;
  if Supports(aElement.Container, IwbContainer, Container) then
    Result := Container.ElementNativeValues['Include Count'];
end;

function wbOMODDataPropertyCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container       : IwbContainer;
begin
  Result := 0;
  if Supports(aElement.Container, IwbContainer, Container) then
    Result := Container.ElementNativeValues['Property Count'];
end;

function GetObjectModPropertyEnum(const aElement: IwbElement): IwbEnumDef;
var
  MainRecord: IwbMainRecord;
  rDATA: IwbContainer;
  Signature: TwbSignature;
  FormType: Cardinal;
begin
  Result := nil;

  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;

  Signature := MainRecord.Signature;

  if Signature = OMOD then
    if Supports(MainRecord.ElementBySignature['DATA'], IwbContainer, rDATA) then begin
      FormType := rDATA.ElementNativeValues['Form Type'];
      Signature := PwbSignature(@FormType)^;
    end;

  if Signature = ARMO then
    Result := wbArmorPropertyEnum
  else if Signature = WEAP then
    Result := wbWeaponPropertyEnum
  else if Signature = NPC_ then
    Result := wbActorPropertyEnum;
end;

function wbObjectModPropertyToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  PropEnum: IwbEnumDef;
begin
  Result := '';

  PropEnum := GetObjectModPropertyEnum(aElement);

  if not Assigned(PropEnum) then begin
    case aType of
      ctToStr, ctToSummary, ctToSortKey, ctToEditValue: Result := aInt.ToString;
    end;
    Exit;
  end;

    case aType of
      ctToStr, ctToSummary: Result := PropEnum.ToString(aInt, aElement, aType = ctToSummary);
      ctToSortKey: Result := PropEnum.ToSortKey(aInt, aElement);
      ctCheck: Result := PropEnum.Check(aInt, aElement);
      ctToEditValue: Result := PropEnum.ToEditValue(aInt, aElement);
      ctEditType: Result := 'ComboBox';
      ctEditInfo: Result := PropEnum.EditInfo[aElement].ToCommaText;
    end;
end;

function wbObjectModPropertyToInt(const aString: string; const aElement: IwbElement): Int64;
var
  PropEnum: IwbEnumDef;
begin
  PropEnum := GetObjectModPropertyEnum(aElement);

  if not Assigned(PropEnum) then begin
    Result := StrToIntDef(aString, 0);
    Exit;
  end;

  Result := PropEnum.FromEditValue(aString, aElement);
end;

function wbOMODDataFunctionTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  ValueType      : Integer;
begin
  Result := 0;

  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  ValueType := Container.ElementNativeValues['Value Type'];

  case ValueType of
    0: Result := 0;
    1: Result := 0;
    2: Result := 1;
    4: Result := 3;
    5: Result := 2;
    6: Result := 0;
  end;
end;

function wbOMODDataPropertyValue1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;

  var lContainer: IwbContainer;
  if not wbTryGetContainerFromUnion(aElement, lContainer) then
    Exit;

  var lValueType := lContainer.ElementNativeValues['Value Type'];

  case lValueType of
    0: Result := 1;
    1: Result := 2;
    2: Result := 3;
    4, 6: Result := 4;
    5: begin
      var lPropName := lContainer.ElementEditValues['Property'];

      if lPropName = 'SoundLevel'    then Result := 6 else
      if lPropName = 'StaggerValue'  then Result := 7 else
      if lPropName = 'HitBehaviour'  then Result := 8 else
                                          Result := 5;
    end;
  end;
end;

function wbOMODDataPropertyValue2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  ValueType      : Integer;
begin
  Result := 0;

  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  ValueType := Container.ElementNativeValues['Value Type'];

  case ValueType of
    0: Result := 1;
    1: Result := 2;
    2: Result := 3;
    4: Result := 1;
    6: Result := 2;
  end;
end;

procedure wbOBTSCombinationsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('OBTE - Count', aElement);
end;

procedure wbINNRAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('VNAM - Count', aElement);
end;

function wbCELLCombinedMeshesCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container       : IwbContainer;
begin
  Result := 0;
  if Supports(aElement.Container, IwbContainer, Container) then
    Result := Container.ElementNativeValues['Meshes Count'];
end;

procedure wbCELLCombinedMeshesAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('Meshes Count', aElement);
end;

function wbCELLCombinedRefsCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container       : IwbContainer;
begin
  Result := 0;
  // the counter is double of entries (each member of struct is counted)
  if Supports(aElement.Container, IwbContainer, Container) then
    Result := Container.ElementNativeValues['References Count'] div 2;
end;

procedure wbCELLCombinedRefsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Element         : IwbElement;
  Container       : IwbContainer;
  SelfAsContainer : IwbContainer;
begin
  // the counter is double of entries (each member of struct is counted)
  if wbBeginInternalEdit(True) then try
    if not Supports(aElement.Container, IwbContainer, Container) then
      Exit;

    if not Supports(aElement, IwbContainer, SelfAsContainer) then
      Exit;

    Element := Container.ElementByName['References Count'];
    if Assigned(Element) then try
      if (Element.GetNativeValue <> (SelfAsContainer.GetElementCount * 2)) then
        Element.SetNativeValue(SelfAsContainer.GetElementCount * 2);
    except
      // TODO: yikes, suppressing exceptions?
    end;
  finally
    wbEndInternalEdit;
  end;
end;

function wbCombinedMeshIDToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Cell: IwbMainRecord;
  MasterFolder: string;
begin
  Result := IntToHex(aInt, 8);

  case aType of
    ctToStr, ctToSummary, ctToEditValue: begin
      Cell := aElement.ContainingMainRecord;
      if not Assigned(Cell) then
        Exit;

      Cell := Cell.MasterOrSelf;
      MasterFolder := '';
      if Assigned(Cell._File) and (Cell._File.LoadOrder > 0) then
        MasterFolder := Cell._File.FileName + '\';

      Result := 'Precombined\' + MasterFolder + Cell.FormID.ChangeFileID(TwbFileID.CreateFull(0)).ToString(False) + '_' + Result + '_OC.nif';
    end;
    ctCheck: Result := '';
  end;
end;

function wbCombinedMeshIDToInt(const aString: string; const aElement: IwbElement): Int64;
var
  s, f: string;
  i: Integer;
begin
  Result := 0;

  // hex number between first and second underscore in the file name
  f := ExtractFileName(aString);
  i := Pos('_', f);
  if not (i <> 0) then
    Exit;

  s := Copy(f, i + 1, Length(f) - i);
  i := Pos('_', s);
  if not (i <> 0) then
    Exit;

  s := Copy(s, 1, i - 1);
  if Length(s) = 8 then try
    Result := StrToInt64('$' + s);
  except
    // TODO: yikes, suppressing exceptions?
  end;
end;

function wbREFRRecordFlagsDecider(const aElement: IwbElement): Integer;
var
  MainRecord : IwbMainRecord;
  NameRec    : IwbElement;
begin
  Result := 0;

  if not wbTryGetContainingMainRecord(aElement, MainRecord) then
    Exit;

  NameRec := MainRecord.ElementBySignature[NAME];
  if not wbTryGetMainRecord(NameRec, MainRecord) then
    Exit;

  if (MainRecord.Signature = ACTI) or
     (MainRecord.Signature = STAT) or
     (MainRecord.Signature = SCOL) or
     (MainRecord.Signature = TREE)
  then
    Result := 1
  else if
     (MainRecord.Signature = CONT) or
     (MainRecord.Signature = TERM)
  then
    Result := 2
  else if MainRecord.Signature = DOOR then
    Result := 3
  else if MainRecord.Signature = LIGH then
    Result := 4
  else if MainRecord.Signature = MSTT then
    Result := 5
  else if MainRecord.Signature = ADDN then
    Result := 6
  else if
     (MainRecord.Signature = SCRL) or
     (MainRecord.Signature = AMMO) or
     (MainRecord.Signature = ARMO) or
     (MainRecord.Signature = BOOK) or
     (MainRecord.Signature = INGR) or
     (MainRecord.Signature = KEYM) or
     (MainRecord.Signature = MISC) or
     (MainRecord.Signature = FURN) or
     (MainRecord.Signature = WEAP) or
     (MainRecord.Signature = ALCH)
  then
    Result := 7;
end;

function wbIntToHexStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  case aType of
    ctToStr, ctToSummary, ctToSortKey, ctToEditValue: Result := IntToHex(aInt, 8);
  else
    Result := '';
  end;
end;

function wbHexStrToInt(const aString: string; const aElement: IwbElement): Int64;
var
  s: string;
  i: integer;
begin
  // ignore anything after space or :
  i := Pos(' ', aString);
  if i = 0 then
    i := Pos(':', aString);

  if i <> 0 then
    s := Copy(aString, 1, i - 1)
  else
    s := aString;

  try
    Result := StrToInt64('$' + s)
  except
    Result := 0;
  end;
end;

type
  TFaceGenFeature = record
    RaceID  : String;
    Female  : Boolean;
    Entries : array of record
      Index: Cardinal;
      Name : String;
    end;
  end;
  PFaceGenFeature = ^TFaceGenFeature;

var
  // cache of race specific face morphs
  FaceMorphs: array of TFaceGenFeature;
  // cache of race specific tint layers
  TintLayers: array of TFaceGenFeature;
  // cache of race specific morph groups/presets and values
  MorphValues: array of TFaceGenFeature;


function wbMorphValueToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;

  function GetCached(const aRaceID: string; aFemale: boolean): PFaceGenFeature;
  var
    i: integer;
  begin
    Result := nil;
    if Length(MorphValues) <> 0 then
      for i := Low(MorphValues) to High(MorphValues) do
        if (MorphValues[i].Female = aFemale) and (MorphValues[i].RaceID = aRaceID) then begin
          Result := @MorphValues[i];
          Break;
        end;
  end;

var
  Actor, Race       : IwbMainRecord;
  Element           : IwbElement;
  Container, Entry  : IwbContainerElementRef;
  Container2, Entry2: IwbContainerElementRef;
  Female, Female2   : Boolean;
  RaceID, EntryName : string;
  Cache             : PFaceGenFeature;
  Index             : Cardinal;
  i, j, k           : integer;
  slList            : TStringList;
begin
  // defaults
  case aType of
    ctToStr, ctToSummary, ctToEditValue: Result := IntToHex64(aInt, 8);
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve morph index ' + IntToHex64(aInt, 8) + '>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  Actor := aElement.ContainingMainRecord;
  if not Assigned(Actor) then
    Exit;

  Female := Actor.ElementEditValues['ACBS\Flags\Female'] = '1';

  Element := Actor.ElementBySignature['RNAM'];
  if not Assigned(Element) then
    Exit;

  Element := Element.LinksTo;
  if not Supports(Element, IwbMainRecord, Race) then
    Exit;

  Race := Race.WinningOverride;
  RaceID := Race.EditorID;

  Cache := GetCached(RaceID, Female);

  // cache not found, fill with data from RACE
  if not Assigned(Cache) then begin

    slList := TStringList.Create;

    for i := 0 to 1 do begin

      Female2 := i = 1;
      SetLength(MorphValues, Succ(Length(MorphValues)));
      Cache := @MorphValues[Pred(Length(MorphValues))];
      Cache.RaceID := RaceID;
      Cache.Female := Female2;

      slList.Clear;

      if not Female2 then
        Element := Race.ElementByName['Male Morph Groups']
      else
        Element := Race.ElementByName['Female Morph Groups'];

      // iterate over morph groups
      if Supports(Element, IwbContainerElementRef, Container) then
        for j := 0 to Pred(Container.ElementCount) do begin
          if not Supports(Container.Elements[j], IwbContainerElementRef, Entry) then
            Break;

          // group name
          EntryName := Entry.ElementEditValues['MPGN'];

          // iterate over morph group presets
          if not Supports(Entry.ElementByName['Morph Presets'], IwbContainerElementRef, Container2) then
            Continue;

          for k := 0 to Pred(Container2.ElementCount) do
            if Supports(Container2.Elements[k], IwbContainerElementRef, Entry2) then
              slList.AddObject(
                EntryName + ' - ' + Entry2.ElementEditValues['MPPN'],
                TObject(Cardinal(Entry2.ElementNativeValues['MPPI']))
              );
        end;

      // append morph values, same for both sexes
      if Supports(Race.ElementByName['Morph Values'], IwbContainerElementRef, Container) then
        for j := 0 to Pred(Container.ElementCount) do
          if Supports(Container.Elements[j], IwbContainerElementRef, Entry) then
            slList.AddObject(
              Entry.ElementEditValues['MSM0'] + '/' + Entry.ElementEditValues['MSM1'],
              TObject(Cardinal(Entry.ElementNativeValues['MSID']))
            );

      SetLength(Cache.Entries, slList.Count);

      for j := 0 to Pred(slList.Count) do begin
        Cache.Entries[j].Index := Cardinal(slList.Objects[j]);
        Cache.Entries[j].Name := slList[j];
      end;

    end;

    slList.Free;

    Cache := GetCached(RaceID, Female);
  end;

  if not Assigned(Cache) then
    Exit;

  EntryName := '';
  Index := Cardinal(aInt);
  if Length(Cache.Entries) <> 0 then
    for i := Low(Cache.Entries) to High(Cache.Entries) do
      if Cache.Entries[i].Index = Index then begin
        EntryName := Cache.Entries[i].Name;
        Break;
      end;

  case aType of
    ctToStr, ctToSummary: begin
      if EntryName <> '' then
        Result := IntToHex64(aInt, 8) + ' ' + EntryName
      else begin
        Result := IntToHex64(aInt, 8);
        if aType = ctToStr then
          Result := Result  + ' <Morph index [' + IntToHex64(aInt, 8) + '] not found in ' + Race.Name + '>';
      end;
    end;
    ctCheck: begin
      if EntryName = '' then
        Result := '<Morph index [' + IntToHex(aInt, 8) + '] not found in ' + Race.Name + '>'
      else
        Result := '';
    end;
    ctEditType: Result := 'ComboBox';
    ctEditInfo: begin
      Result := '';
      if Length(Cache.Entries) <> 0 then
        for i := Low(Cache.Entries) to High(Cache.Entries) do begin
          if Result <> '' then Result := Result + ',';
          Result := Result +  '"' + IntToHex(Cache.Entries[i].Index, 8) + ' ' + Cache.Entries[i].Name + '"';
        end;
    end;
  end;
end;

function wbFaceMorphToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
  function GetCached(const aRaceID: string; aFemale: boolean): PFaceGenFeature;
  var
    i: integer;
  begin
    Result := nil;
    if Length(FaceMorphs) <> 0 then
      for i := Low(FaceMorphs) to High(FaceMorphs) do
        if (FaceMorphs[i].Female = aFemale) and (FaceMorphs[i].RaceID = aRaceID) then begin
          Result := @FaceMorphs[i];
          Break;
        end;
  end;

var
  Actor, Race       : IwbMainRecord;
  Element           : IwbElement;
  Container, Entry  : IwbContainerElementRef;
  Female, Female2   : Boolean;
  RaceID, EntryName : string;
  Cache             : PFaceGenFeature;
  Index             : Cardinal;
  i, j              : integer;
begin
  // defaults
  case aType of
    ctToStr, ctToSummary, ctToEditValue: Result := IntToHex64(aInt, 8);
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve face morph index ' + IntToHex64(aInt, 8) + '>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  Actor := aElement.ContainingMainRecord;
  if not Assigned(Actor) then
    Exit;

  Female := Actor.ElementEditValues['ACBS\Flags\Female'] = '1';

  Element := Actor.ElementBySignature['RNAM'];
  if not Assigned(Element) then
    Exit;

  Element := Element.LinksTo;
  if not Supports(Element, IwbMainRecord, Race) then
    Exit;

  Race := Race.WinningOverride;
  RaceID := Race.EditorID;

  Cache := GetCached(RaceID, Female);

  // cache not found, fill with data from RACE
  if not Assigned(Cache) then begin

    for i := 0 to 1 do begin

      Female2 := i = 1;
      SetLength(FaceMorphs, Succ(Length(FaceMorphs)));
      Cache := @FaceMorphs[Pred(Length(FaceMorphs))];
      Cache.RaceID := RaceID;
      Cache.Female := Female2;

      if not Female2 then
        Element := Race.ElementByName['Male Face Morphs']
      else
        Element := Race.ElementByName['Female Face Morphs'];

      if not Supports(Element, IwbContainerElementRef, Container) then
        Continue;

      SetLength(Cache.Entries, Container.ElementCount);

      for j := 0 to Pred(Container.ElementCount) do begin
        if not Supports(Container.Elements[j], IwbContainerElementRef, Entry) then
          Break;
        Cache.Entries[j].Index := Entry.ElementNativeValues['FMRI'];
        Cache.Entries[j].Name := Entry.ElementEditValues['FMRN'];
      end;
    end;

    Cache := GetCached(RaceID, Female);
  end;

  if not Assigned(Cache) then
    Exit;

  EntryName := '';
  Index := Cardinal(aInt);
  if Length(Cache.Entries) <> 0 then
    for i := Low(Cache.Entries) to High(Cache.Entries) do
      if Cache.Entries[i].Index = Index then begin
        EntryName := Cache.Entries[i].Name;
        Break;
      end;

  case aType of
    ctToStr, ctToSummary: begin
      if EntryName <> '' then
        Result := IntToHex64(aInt, 8) + ' ' + EntryName
      else begin
        Result := IntToHex64(aInt, 8);
        if aType = ctToStr then
          Result := Result + ' <Face morph index [' + IntToHex64(aInt,8) + '] not found in ' + Race.Name + '>';
      end;
    end;
    ctCheck: begin
      if EntryName = '' then
        Result := '<Face morph index [' + IntToHex(aInt, 8) + '] not found in ' + Race.Name + '>'
      else
        Result := '';
    end;
    ctEditType: Result := 'ComboBox';
    ctEditInfo: begin
      Result := '';
      if Length(Cache.Entries) <> 0 then
        for i := Low(Cache.Entries) to High(Cache.Entries) do begin
          if Result <> '' then Result := Result + ',';
          Result := Result +  '"' + IntToHex(Cache.Entries[i].Index, 8) + ' ' + Cache.Entries[i].Name + '"';
        end;
    end;
  end;
end;

function wbTintLayerToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;

  function GetCached(const aRaceID: string; aFemale: boolean): PFaceGenFeature;
  var
    i: integer;
  begin
    Result := nil;
    if Length(TintLayers) <> 0 then
      for i := Low(TintLayers) to High(TintLayers) do
        if (TintLayers[i].Female = aFemale) and (TintLayers[i].RaceID = aRaceID) then begin
          Result := @TintLayers[i];
          Break;
        end;
  end;

var
  Actor, Race       : IwbMainRecord;
  Element           : IwbElement;
  Container, Entry  : IwbContainerElementRef;
  Container2, Entry2: IwbContainerElementRef;
  Female, Female2   : Boolean;
  RaceID, EntryName : string;
  Cache             : PFaceGenFeature;
  Index             : Cardinal;
  i, j, k           : integer;
  slList            : TStringList;
begin
  // defaults
  case aType of
    ctToStr, ctToSummary, ctToEditValue: Result := aInt.ToString;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve tint layer index ' + aInt.ToString + '>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  Actor := aElement.ContainingMainRecord;
  if not Assigned(Actor) then
    Exit;

  Female := Actor.ElementEditValues['ACBS\Flags\Female'] = '1';

  Element := Actor.ElementBySignature['RNAM'];
  if not Assigned(Element) then
    Exit;

  Element := Element.LinksTo;
  if not Supports(Element, IwbMainRecord, Race) then
    Exit;

  Race := Race.WinningOverride;
  RaceID := Race.EditorID;

  Cache := GetCached(RaceID, Female);

  // cache not found, fill with data from RACE
  if not Assigned(Cache) then begin

    slList := TStringList.Create;

    for i := 0 to 1 do begin
      Female2 := i = 1;
      SetLength(TintLayers, Succ(Length(TintLayers)));
      Cache := @TintLayers[Pred(Length(TintLayers))];
      Cache.RaceID := RaceID;
      Cache.Female := Female2;

      if not Female2 then
        Element := Race.ElementByName['Male Tint Layers']
      else
        Element := Race.ElementByName['Female Tint Layers'];

      if not Supports(Element, IwbContainerElementRef, Container) then
        Continue;

      slList.Clear;

      // iterate over tint groups
      for j := 0 to Pred(Container.ElementCount) do begin
        if not Supports(Container.Elements[j], IwbContainerElementRef, Entry) then
          Continue;

        // iterate over tint group options
        if not Supports(Entry.ElementByName['Options'], IwbContainerElementRef, Container2) then
          Continue;

        for k := 0 to Pred(Container2.ElementCount) do
          if Supports(Container2.Elements[k], IwbContainerElementRef, Entry2) then
            slList.AddObject(
              Entry.ElementEditValues['TTGP'] + ' - ' + Entry2.ElementEditValues['TTGP'],
              TObject(Cardinal(Entry2.ElementNativeValues['TETI\Index']))
            );
      end;

      SetLength(Cache.Entries, slList.Count);

      for j := 0 to Pred(slList.Count) do begin
        Cache.Entries[j].Index := Cardinal(slList.Objects[j]);
        Cache.Entries[j].Name := slList[j];
      end;
    end;

    slList.Free;

    Cache := GetCached(RaceID, Female);
  end;

  if not Assigned(Cache) then
    Exit;

  EntryName := '';
  Index := Cardinal(aInt);
  if Length(Cache.Entries) <> 0 then
    for i := Low(Cache.Entries) to High(Cache.Entries) do
      if Cache.Entries[i].Index = Index then begin
        EntryName := Cache.Entries[i].Name;
        Break;
      end;

  case aType of
    ctToStr, ctToSummary: begin
      if EntryName <> '' then
        Result := aInt.ToString + ' ' + EntryName
      else begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Tint Layer Index [' + aInt.ToString + '] not found in ' + Race.Name + '>';
      end;
    end;
    ctCheck: begin
      if EntryName = '' then
        Result := '<Tint Layer Index [' + aInt.ToString + '] not found in ' + Race.Name + '>'
      else
        Result := '';
    end;
    ctEditType: Result := 'ComboBox';
    ctEditInfo: begin
      Result := '';
      if Length(Cache.Entries) <> 0 then
        for i := Low(Cache.Entries) to High(Cache.Entries) do begin
          if Result <> '' then Result := Result + ',';
          Result := Result + '"' + IntToStr(Cache.Entries[i].Index) + ' ' + Cache.Entries[i].Name + '"';
        end;
    end;
  end;
end;

// Do this terribleness because fallout4.esm has some junk values
procedure wbSCENBehaviorEnumAfterLoad(const aElement: IwbElement);
begin
  if wbBeginInternalEdit then try
    if aElement.GetNativeValue > $00000003 then
      aElement.SetNativeValue($00000003)
  finally
    wbEndInternalEdit;
  end;
end;

function wbTintTemplateGroups(const aName: string): IwbSubRecordArrayDef;
  var
    wbTintTemplateGroup: IwbSubRecordStructDef;
    wbTintTemplateOption: IwbSubRecordStructDef;
  begin
    wbTintTemplateOption :=
      wbRStruct('Option', [
        wbStruct(TETI, 'Index', [
          wbInteger('Slot', itU16, wbEnum([
            'Forehead Mask',
            'Eyes Mask',
            'Nose Mask',
            'Ears Mask',
            'Cheeks Mask',
            'Mouth Mask',
            'Neck Mask',
            'Lip Color',
            'Cheek Color',
            'Eyeliner',
            'Eye Socket Upper',
            'Eye Socket Lower',
            'Skin Tone',
            'Paint',
            'Laugh Lines',
            'Cheek Color Lower',
            'Nose',
            'Chin',
            'Neck',
            'Forehead',
            'Dirt',
            'Scars',
            'Face Detail',
            'Brows',
            'Wrinkles',
            'Beards'
          ])),
          wbInteger('Index', itU16)
        ]),
        wbLString(TTGP, 'Name', 0, cpTranslate),
        wbInteger(TTEF, 'Flags', itU16, wbFlags([
          'On/Off only',
          'Chargen Detail',
          'Takes Skin Tone'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbConditions,
        wbRArray('Textures', wbString(TTET, 'Texture')),
        wbInteger(TTEB, 'Blend Operation', itU32, wbBlendOperationEnum),
        wbArray(TTEC, 'Template Colors', wbStruct('Template Color', [
          wbFormIDCk('Color', [CLFM]),
          wbFloat('Alpha'),
          wbInteger('Template Index', itU16),
          wbInteger('Blend Operation', itU32, wbBlendOperationEnum)
        ])),
        wbFloat(TTED, 'Default')
      ]);

    wbTintTemplateGroup :=
      wbRStruct('Group', [
        wbLString(TTGP, 'Group Name', 0, cpTranslate),
        wbRArray('Options', wbTintTemplateOption),
        wbInteger(TTGE, 'Category Index', itU32)
      ]);

    Result := wbRArray(aName, wbTintTemplateGroup);
  end;

  function wbMorphGroups(const aName: string): IwbSubRecordArrayDef;
  begin
    Result :=
      wbRArray(aName,
        wbRStruct('Morph Group', [
          wbString(MPGN, 'Name'),
          wbInteger(MPPC, 'Count', itU32, nil, cpBenign),
          wbRArray('Morph Presets',
            wbRStruct('Morph Preset', [
              wbInteger(MPPI, 'Index', itU32, wbIntToHexStr, wbHexStrToInt),
              wbLString(MPPN, 'Name', 0, cpTranslate),
              wbString(MPPM, 'Morph'),
              wbFormIDCk(MPPT, 'Texture', [TXST]),
              wbInteger(MPPF, 'Playable', itU8, wbBoolEnum)
            ]),
            cpNormal, False, nil, wbMorphPresetsAfterSet
          ),
          wbInteger(MPPK, 'Mask', itU16, wbEnum ([], [                                                       //Maps to Faceregion tint groups (male and female)

        //Male
        1171, 'Male Forehead Mask',
        1172, 'Male Eyes Mask',
        1173, 'Male Nose Mask',
        1174, 'Male Ears Mask',
        1175, 'Male Cheeks Mask',
        1176, 'Male Mouth Mask',
        1177, 'Male Neck Mask',
        //Female
        1221, 'Female Forehead Mask',
        1222, 'Female Eyes Mask',
        1223, 'Female Nose Mask',
        1224, 'Female Ears Mask',
        1225, 'Female Cheeks Mask',
        1226, 'Female Mouth Mask',
        1227, 'Female Neck Mask',
        65535, 'None'
      ])),
          wbArray(MPGS, 'Morph Group Sliders', wbInteger('Index', itU32, wbIntToHexStr, wbHexStrToInt))
        ])
      );
  end;

  function wbFaceMorphs(const aName: string): IwbSubRecordArrayDef;
  begin
    Result :=
      wbRArray(aName,
        wbRStruct('Face Morph', [
          wbInteger(FMRI, 'Index', itU32, wbIntToHexStr, wbHexStrToInt),
          wbLString(FMRN, 'Name')
        ])
      );
  end;

function CombineVarRecs(const a, b : array of const)
                                   : TVarRecs;
begin
  SetLength(Result, Length(a) + Length(b));
  if Length(a) > 0 then
    Move(a[0], Result[0], SizeOf(TVarRec) * Length(a));
  if Length(b) > 0 then
    Move(b[0], Result[Length(a)], SizeOf(TVarRec) * Length(b));
end;

function MakeVarRecs(const a : array of const)
                             : TVarRecs;
begin
  SetLength(Result, Length(a));
  if Length(a) > 0 then
    Move(a[0], Result[0], SizeOf(TVarRec) * Length(a));
end;


  procedure ReferenceRecord(aSignature: TwbSignature; const aName: string);
  begin
    wbRefRecord(aSignature, aName,
      wbFlags(wbFlagsList([
        {0x00000080}  7, 'Turn Off Fire',
        {0x00000400} 10, 'Persistent',
        {0x00000800} 11, 'Initially Disabled',
        {0x10000000} 28, 'Reflected By Auto Water',
        {0x20000000} 29, 'Don''t Havok Settle',
        {0x40000000} 30, 'No Respawn'
      ], True, True)), [
      wbEDID,
      wbVMAD,
      wbFormIDCk(NAME, 'Projectile', [PROJ, HAZD]),
      wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
      wbFloat(XHTW, 'Head-Tracking Weight'),
      wbFloat(XFVC, 'Favor Cost'),
      wbRArrayS('Reflected/Refracted By',
        wbStructSK(XPWR, [0], 'Water', [
          wbFormIDCk('Reference', [ACHR, REFR]),
          wbInteger('Type', itU32, wbFlags([
            'Reflection',
            'Refraction'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
        ], cpNormal, False, nil, 1)
      ),
      wbRArrayS('Linked References', wbStructSK(XLKR, [0], 'Linked Reference', [
        wbFormIDCk('Keyword/Ref', [KYWD, PLYR, ACHR, REFR, PGRE, PHZD, PMIS, PARW, PBAR, PBEA, PCON, PFLA, NULL]),
        wbFormIDCk('Ref', sigReferences)
      ], cpNormal, False, nil, 1)),
      wbRStruct('Activate Parents', [
        wbInteger(XAPD, 'Flags', itU8, wbFlags([
          'Parent Activate Only'
        ], True)).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbRArrayS('Activate Parent Refs',
          wbStructSK(XAPR, [0], 'Activate Parent Ref', [
            wbFormIDCk('Reference', sigReferences),
            wbFloat('Delay')
          ])
        )
      ]),

      wbFormIDCk(XASP, 'Acoustic Parent', [REFR]),
      wbEmpty(XATP, 'Activation Point'),
      wbInteger(XAMC, 'Ammo Count', itU32),
      wbEmpty(XLKT, 'Linked Ref Transient'),
      wbFormIDCk(XLYR, 'Layer', [LAYR]),
      wbFormIDCk(XMSP, 'Material Swap', [MSWP]),
      wbFormIDCk(XRFG, 'Reference Group', [RFGP]),
      wbStruct(XCVR, 'Water Current Zone Data', [
        wbFloat('Unknown'),
        wbFloat('Unknown'),
        wbFloat('Unknown')
      ]),
      wbXESP,
      wbOwnership,
      wbRagdoll,
      wbInteger(XHLT, 'Health %', itU32),
      wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),
      wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),
      wbEmpty(XIS2, 'Ignored by Sandbox'),
      wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),
      wbFormIDCk(XLRL, 'Location Reference', [LCRT, LCTN, NULL], False, cpBenignIfAdded),
      wbXSCL,
      wbXLOD,
      wbDataPosRot,
      wbString(MNAM, 'Comments')
    ], True).SetAddInfo(wbPlacedAddInfo);
  end;

procedure DefineFO4;
begin
  DefineCommon;

  wbRecordFlags := wbInteger('Record Flags', itU32, wbFlags(wbFlagsList([])));

  wbMainRecordHeader := wbRecordHeader(wbRecordFlags);

  wbSizeOfMainRecordStruct := 24;

  wbNull := wbUnused(-255);
  wbLLCT := wbInteger(LLCT, 'Count', itU8, nil, cpBenign);
  wbCITC := wbInteger(CITC, 'Condition Count', itU32, nil, cpBenign);
  wbCITCReq := wbInteger(CITC, 'Condition Count', itU32, nil, cpBenign, True);
  wbLVLD := wbInteger(LVLD, 'Chance None', itU8, nil, cpNormal, True);

  wbSPCT := wbInteger(SPCT, 'Count', itU32, nil, cpBenign);
  wbSPLO := wbFormIDCk(SPLO, 'Actor Effect', [SPEL, LVSP]);
  wbSPLOs := wbRArrayS('Actor Effects', wbSPLO, cpNormal, False, nil, wbSPLOsAfterSet);

  //wbActorValue := wbInteger('Actor Value', itS32, wbActorValueEnum);
  wbActorValue := wbFormIDCkNoReach('Actor Value', [AVIF, NULL]);

  wbCOED := wbStructExSK(COED, [2], [0, 1], 'Extra Data', [
    {00} wbFormIDCkNoReach('Owner', [NPC_, FACT, NULL]),
    {04} wbUnion('Global Variable / Required Rank', wbCOEDOwnerDecider, [
           wbUnused(4),
           wbFormIDCk('Global Variable', [GLOB, NULL]),
           wbInteger('Required Rank', itS32)
         ]),
    {08} wbFloat('Item Condition')
  ]);

  wbCNTO :=
    wbRStructExSK([0], [1], 'Item', [
      wbStructExSK(CNTO, [0], [1], 'Item', [
        wbFormIDCk('Item', sigBaseObjects),
        wbInteger('Count', itS32).SetDefaultNativeValue(1)
      ]),
      wbCOED
    ]).SetToStr(wbItemToStr).IncludeFlag(dfCollapsed, wbCollapseItems);
  wbCOCT := wbInteger(COCT, 'Count', itU32, nil, cpBenign);
  wbCNTOs := wbRArrayS('Items', wbCNTO, cpNormal, False, nil, wbCNTOsAfterSet);

  {>>> When NAME is user defined these will be incorrect <<<}
  wbBipedObjectEnum := wbEnum([
    '30 - Hair Top',
    '31 - Hair Long',
    '32 - FaceGen Head',
    '33 - BODY',
    '34 - L Hand',
    '35 - R Hand',
    '36 - [U] Torso',
    '37 - [U] L Arm',
    '38 - [U] R Arm',
    '39 - [U] L Leg',
    '40 - [U] R Leg',
    '41 - [A] Torso',
    '42 - [A] L Arm',
    '43 - [A] R Arm',
    '44 - [A] L Leg',
    '45 - [A] R Leg',
    '46 - Headband',
    '47 - Eyes',
    '48 - Beard',
    '49 - Mouth',
    '50 - Neck',
    '51 - Ring',
    '52 - Scalp',
    '53 - Decapitation',
    '54 - Unnamed',
    '55 - Unnamed',
    '56 - Unnamed',
    '57 - Unnamed',
    '58 - Unnamed',
    '59 - Shield',
    '60 - Pipboy',
    '61 - FX'
  ], [
    -1, 'None'
  ]);

  wbBipedObjectFlags := wbFlags([
    {0x00000001} '30 - Hair Top',
    {0x00000002} '31 - Hair Long',
    {0x00000004} '32 - FaceGen Head',
    {0x00000008} '33 - BODY',
    {0x00000010} '34 - L Hand',
    {0x00000020} '35 - R Hand',
    {0x00000040} '36 - [U] Torso',
    {0x00000080} '37 - [U] L Arm',
    {0x00000100} '38 - [U] R Arm',
    {0x00000200} '39 - [U] L Leg',
    {0x00000400} '40 - [U] R Leg',
    {0x00000800} '41 - [A] Torso',
    {0x00001000} '42 - [A] L Arm',
    {0x00002000} '43 - [A] R Arm',
    {0x00004000} '44 - [A] L Leg',
    {0x00008000} '45 - [A] R Leg',
    {0x00010000} '46 - Headband',
    {0x00020000} '47 - Eyes',
    {0x00040000} '48 - Beard',
    {0x00080000} '49 - Mouth',
    {0x00100000} '50 - Neck',
    {0x00200000} '51 - Ring',
    {0x00400000} '52 - Scalp',
    {0x00800000} '53 - Decapitation',
    {0x01000000} '54 - Unnamed',
    {0x02000000} '55 - Unnamed',
    {0x04000000} '56 - Unnamed',
    {0x08000000} '57 - Unnamed',
    {0x10000000} '58 - Unnamed',
    {0x20000000} '59 - Shield',
    {0x40000000} '60 - Pipboy',
    {0x80000000} '61 - FX'
  ], True);

  wbFirstPersonFlagsU32 := wbInteger('First Person Flags', itU32, wbBipedObjectFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);

  wbBOD2 := wbStruct(BOD2, 'Biped Body Template', [
    wbFirstPersonFlagsU32
  ], cpNormal, False)
  .SetSummaryKeyOnValue([0])
  .SetSummaryPrefixSuffixOnValue(0, '(', ')')
  .IncludeFlagOnValue(dfSummaryMembersNoName);

  wbDODT := wbStruct(DODT, 'Decal Data', [
    wbFloat('Min Width'),
    wbFloat('Max Width'),
    wbFloat('Min Height'),
    wbFloat('Max Height'),
    wbFloat('Depth'),
    wbFloat('Shininess'),
    wbStruct('Parallax', [
      wbFloat('Scale'),
      wbInteger('Passes', itU8) {>>> This can't be higher than 30 <<<}
    ]),
    wbInteger('Flags', itU8, wbFlags([
      {0x01} 'POM Shadows',
      {0x02} 'Alpha - Blending',
      {0x04} 'Alpha - Testing',
      {0x08} 'No Subtextures',
      {0x10} 'Multiplicative Blending'
    ], True)).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger('Alpha Threshold?', itU16),
    wbByteColors('Color')
  ]);

  wbIgnoreRecords.Add(XXXX);

  wbSoundLevelEnum := wbEnum([
     'Loud',
     'Normal',
     'Silent',
     'Very Loud',
     'Quiet'
    ]);

  wbEntryPointsEnum := wbEnum([
    { 0} 'Mod Breath Timer',
    { 1} 'Mod My Critical Hit Chance',
    { 2} 'Mod My Critical Hit Damage Mult',
    { 3} 'Mod Mine Explode Chance',
    { 4} 'Mod Incoming Limb Damage',
    { 5} 'Mod Book Actor Value Bonus',
    { 6} 'Mod Recovered Health',
    { 7} 'Set Should Attack',
    { 8} 'Mod Buy Prices',
    { 9} 'Add Leveled List On Death',
    {10} 'Set Max Carry Weight',
    {11} 'Mod Addiction Chance',
    {12} 'Mod Addiction Duration',
    {13} 'Mod Positive Chem Duration',
    {14} 'Activate',
    {15} 'Ignore Running During Detection',
    {16} 'Ignore Broken Lock',
    {17} 'Mod Enemy Critical Hit Chance',
    {18} 'Mod Sneak Attack Mult',
    {19} 'Mod Max Placeable Mines',
    {20} 'Mod Bow Zoom',
    {21} 'Mod Recover Arrow Chance',
    {22} 'Mod Exp',
    {23} 'Mod Telekinesis Distance',
    {24} 'Mod Telekinesis Damage Mult',
    {25} 'Mod Telekinesis Damage',
    {26} 'Mod Bashing Damage',
    {27} 'Mod Power Attack Action Points',
    {28} 'Mod Power Attack Damage',
    {29} 'Mod Spell Magnitude',
    {30} 'Mod Spell Duration',
    {31} 'Mod Secondary Value Weight',
    {32} 'Mod Armor Weight',
    {33} 'Mod Incoming Stagger',
    {34} 'Mod Target Stagger',
    {35} 'Mod Weapon Attack Damage',
    {36} 'Mod Incoming Weapon Damage',
    {37} 'Mod Target Damage Resistance',
    {38} 'Mod Spell Cost',
    {39} 'Mod Percent Blocked',
    {40} 'Mod Shield Deflect Arrow Chance',
    {41} 'Mod Incoming Spell Magnitude',
    {42} 'Mod Incoming Spell Duration',
    {43} 'Mod Player Intimidation',
    {44} 'Mod Ricochet Chance',
    {45} 'Mod Ricochet Damage',
    {46} 'Mod Bribe Amount',
    {47} 'Mod Detection Light',
    {48} 'Mod Detection Movement',
    {49} 'Mod Scrap Reward Mult',
    {50} 'Set Sweep Attack',
    {51} 'Apply Combat Hit Spell',
    {52} 'Apply Bashing Spell',
    {53} 'Apply Reanimate Spell',
    {54} 'Set Boolean Graph Variable',
    {55} 'Mod Spell Casting Sound Event',
    {56} 'Mod Pickpocket Chance',
    {57} 'Mod Detection Sneak Skill',
    {58} 'Mod Falling Damage',
    {59} 'Mod Lockpick Sweet Spot',
    {60} 'Mod Sell Prices',
    {61} 'Set Pickpocket Equipped Item',
    {62} 'Set Player Gate Lockpick',
    {63} 'Set Lockpick Starting Arc',
    {64} 'Set Progression Picking',
    {65} 'Set Lockpicks Unbreakable',
    {66} 'Mod Alchemy Effectiveness',
    {67} 'Apply Weapon Swing Spell',
    {68} 'Mod Commanded Actor Limit',
    {69} 'Apply Sneaking Spell',
    {70} 'Mod Player Magic Slowdown',
    {71} 'Mod Ward Magicka Absorption Pct',
    {72} 'Mod Initial Ingredient Effects Learned',
    {73} 'Purify Alchemy Ingredients',
    {74} 'Set Filter Activation',
    {75} 'Set Dual Cast',
    {76} 'Mod Outgoing Explosion Limb Damage',
    {77} 'Mod Enchantment Power',
    {78} 'Mod Soul Pct Captured to Weapon',
    {79} 'Mod VATS Attack Action Points',
    {80} 'Mod Reflect Damage Chance',
    {81} 'Set Activate Label',
    {82} 'Mod Kill Experience',
    {83} 'Mod Poison Dose Count',
    {84} 'Set Apply Placed Item',
    {85} 'Mod Armor Rating',
    {86} 'Mod lockpicking crime chance',
    {87} 'Mod ingredients harvested',
    {88} 'Mod Spell Range (Target Loc.)',
    {89} 'Mod Critical Charge Mult on Ricochet',
    {90} 'Mod lockpicking key reward chance',
    {91} 'Mod Auto Lockpicking Chance',
    {92} 'Mod Auto Hacking Chance',
    {93} 'Mod Typed Weapon Attack Damage',
    {94} 'Mod Typed Incoming Weapon Damage',
    {95} 'Mod Charisma Challenge Chance',
    {96} 'Mod Sprint AP Drain Rate',
    {97} 'Mod Drawn Weapon Weight Speed Effect',
    {98} 'Set Player Gate Hacking',
    {99} 'Mod Player Explosion Damage',
   {100} 'Mod Player Explosion Scale',
   {101} 'Set Rads To Health Mult',
   {102} 'Mod Actor Scope Stability',
   {103} 'Mod Actor Grenade Speed Mult',
   {104} 'Mod Explosion Force',
   {105} 'Mod VATS Penetration Min Visibility',
   {106} 'Mod Rads for Rad Health Max',
   {107} 'Mod VATS Player AP On Kill Chance',
   {108} 'Set VATS Fill Critical Bar On Hit',
   {109} 'Mod VATS Concentrated Fire Chance Bonus',
   {110} 'Mod VATS Critical Count',
   {111} 'Mod VATS Hold Em Steady Bonus',
   {112} 'Mod Typed Spell Magnitude',
   {113} 'Mod Typed Incoming Spell Magnitude',
   {114} 'Set VATS Gun-Fu Num Targets For Crits',
   {115} 'Mod Outgoing Limb Damage',
   {116} 'Mod Restore Action Cost Value',
   {117} 'Mod VATS Reload Action Points',
   {118} 'Mod Incoming Battery Damage',
   {119} 'Mod VATS Critical Charge',
   {120} 'Mod Exp Location',
   {121} 'Mod Exp Speech',
   {122} 'Mod VATS Head Shot Chance',
   {123} 'Mod VATS Hit Chance',
   {124} 'Mod Incoming Explosion Damage',
   {125} 'Mod Ammo Health Mult',
   {126} 'Mod Hacking Guesses',
   {127} 'Mod Terminal Lockout Time',
   {128} 'Set Undetectable',
   {129} 'Invest In Vendor',
   {130} 'Mod Outgoing Limb Bash Damage',
   {131} 'Set Run While Over Encumbered',
   {132} 'Get Component Radar Distance',
   {133} 'Show Grenade Trajectory',
   {134} 'Mod Cone-of-fire Mult',
   {135} 'Mod VATS Concentrated Fire Damage Mult',
   {136} 'Apply Bloody Mess Spell',
   {137} 'Mod VATS Critical Fill Chance On Bank',
   {138} 'Mod VATS Critical Fill Chance On Use',
   {139} 'Set VATS Critical Fill On AP Reward',
   {140} 'Set VATS Critical Fill On Stranger',
   {141} 'Mod Gun Range Mult',
   {142} 'Mod Scope Hold Breath AP Drain Mult',
   {143} 'Set Force Decapitate',
   {144} 'Mod VATS Shoot Explosive Damage Mult',
   {145} 'Mod Scrounger Fill Ammo Chance',
   {146} 'Set Can Explode Pants',
   {147} 'Set VATS Penetration Full Damage',
   {148} 'Mod VATS Gun-Fu 2nd Target Dmg Mult',
   {149} 'Mod VATS Gun-Fu 3rd Target Dmg Mult',
   {150} 'Mod VATS Gun-Fu 4th+ Target Dmg Mult',
   {151} 'Mod VATS Blitz Max Distance',
   {152} 'Set VATS Blitz Max Dmg Mult',
   {153} 'Mod VATS Blitz Dmg Bonus Dist',
   {154} 'Mod Bash Critical Chance',
   {155} 'VATS Apply Paralyzing Palm Spell',
   {156} 'Mod Fatigue for Fatigue AP Max',
   {157} 'Set Fatigue to AP Mult'
  ]);

  wbEquipType := wbFlags([
    {0x00000001} 'Hand To Hand Melee',
    {0x00000002} 'One Hand Sword',
    {0x00000004} 'One Hand Dagger',
    {0x00000008} 'One Hand Axe',
    {0x00000010} 'One Hand Mace',
    {0x00000020} 'Two Hand Sword',
    {0x00000040} 'Two Hand Axe',
    {0x00000080} 'Bow',
    {0x00000100} 'Staff',
    {0x00000200} 'Gun',
    {0x00000400} 'Grenade',
    {0x00000800} 'Mine',
    {0x00001000} 'Spell',
    {0x00002000} 'Shield',
    {0x00004000} 'Torch'
  ], True);

  wbEmotionTypeEnum := wbEnum([
    {0} 'Neutral',
    {1} 'Anger',
    {2} 'Disgust',
    {3} 'Fear',
    {4} 'Sad',
    {5} 'Happy',
    {6} 'Surprise',
    {7} 'Puzzled'
  ]);

  wbFurnitureAnimTypeEnum := wbEnum([
    {0} '',
    {1} 'Sit',
    {2} 'Lay',
    {3} '',
    {4} 'Lean'
  ]);

  wbWardStateEnum := wbEnum([
    'None',
    'Absorb',
    'Break'
  ]);

  wbEventFunctionEnum := wbEnum([
    'GetIsID',
    'IsInList',
    'GetValue',
    'HasKeyword',
    'GetItemValue'
  ]);

  // Event member names and availability are different depending on event type
  // Using generic names for the last 3 of them: Form, Value1, Value2
  wbEventMemberEnum := wbEnum([], [
    $0000, 'None',
    $314F, 'CreatedObject', //O1
    $3146, 'Form',          //F1
    $3147, 'Global',        //G1
    $3149, 'Identifier',    //I1
    $314B, 'Keyword1',      //K1
    $324B, 'Keyword2',      //K2
    $334B, 'Keyword3',      //K3
    $314C, 'Location1',     //L1
    $324C, 'Location2',     //L2
    $3150, 'Player1',       //P1
    $3250, 'Player2',       //P2
    $3251, 'Quest',         //Q1
    $3152, 'Reference1',    //R1
    $3252, 'Reference2',    //R2
    $3352, 'Reference3',    //R3
    $3156, 'Value1',        //V1
    $3256, 'Value2',        //V2
    $7FFFFFFF, 'All'
  ]);

  wbReverbClassEnum := wbEnum([
    'Default',
    'Class A',
    'Class B',
    'Class C',
    'Class D',
    'Class E'
  ]);

  wbHitBehaviourEnum := wbEnum([
    'Normal formula behaviour',
    'Dismember only',
    'Explode only',
    'No dismember/explode'
  ]);

  wbActorBehaviorEnum := wbEnum([
    'Set All Normal',
    'Set All Pause',
    'Set All End',
    'Don''t Set All'
  ]);

  wbEDID := wbStringKC(EDID, 'Editor ID', 0, cpOverride);
  wbFULL := wbLStringKC(FULL, 'Name', 0, cpTranslate);
  wbFULLReq := wbLStringKC(FULL, 'Name', 0, cpTranslate, True);
  wbDESC := wbLStringKC(DESC, 'Description', 0, cpTranslate);
  wbDESCReq := wbLStringKC(DESC, 'Description', 0, cpTranslate, True);
  wbXSCL := wbFloat(XSCL, 'Scale');

  wbPropTypeEnum := wbEnum([
    {00} 'None',
    {01} 'Object',
    {02} 'String',
    {03} 'Int32',
    {04} 'Float',
    {05} 'Bool',
    {06} 'Variable',
    {07} 'Struct',
    {08} '',
    {09} '',
    {10} '',
    {11} 'Array of Object',
    {12} 'Array of String',
    {13} 'Array of Int32',
    {14} 'Array of Float',
    {15} 'Array of Bool',
    {16} 'Array of Variable',
    {17} 'Array of Struct'
  ]);

  wbScriptFlags := wbInteger('Flags', itU8, wbEnum([
    {0x00} 'Local',
    {0x01} 'Inherited',
    {0x02} 'Removed',
    {0x03} 'Inherited and Removed'
  ]));

  wbScriptPropertyObject := wbUnion('Object Union', wbScriptObjFormatDecider, [
    wbStructSK([1], 'Object v2', [
      wbInteger('Unused', itU16, nil, cpIgnore, False, wbNeverShow),
      wbInteger('Alias', itS16, wbScriptObjectAliasToStr, wbAliasToInt).SetDefaultEditValue('None'),
      wbFormID('FormID').IncludeFlag(dfNoReport)
    ], [2, 1, 0])
      .SetSummaryKey([2, 1])
      .SetSummaryMemberPrefixSuffix(2, '', '')
      .SetSummaryMemberPrefixSuffix(1, ', Alias[', ']')
      .SetSummaryDelimiter('')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfSummaryNoSortKey),
    wbStructSK([0], 'Object v1', [
      wbFormID('FormID'),
      wbInteger('Alias', itS16, wbScriptObjectAliasToStr, wbAliasToInt),
      wbInteger('Unused', itU16, nil, cpIgnore)
    ])
      .SetSummaryKey([0, 1])
      .SetSummaryMemberPrefixSuffix(0, '', '')
      .SetSummaryMemberPrefixSuffix(1, ', Alias[', ']')
      .SetSummaryDelimiter('')
      .IncludeFlag(dfSummaryMembersNoName)
  ]);

  wbScriptPropertyStruct :=
    wbArrayS('Struct', wbStructSK([0], 'Member', [
      wbLenString('memberName', 2),
      wbInteger('Type', itU8, wbPropTypeEnum, cpNormal, False, nil, wbScriptPropertyTypeAfterSet),
      wbInteger('Flags', itU8, wbEnum([
        {0x00} '',
        {0x01} 'Edited',
        {0x02} '',
        {0x03} 'Removed'
      ])).SetDefaultEditValue('Edited'),
      wbUnion('Value', wbScriptPropertyDecider, [
        {00} wbNull,
        {01} wbScriptPropertyObject,
        {02} wbLenString('String', 2).OverrideEncoding(wbEncodingVMAD),
        {03} wbInteger('Int32', itS32),
        {04} wbFloat('Float'),
        {05} wbInteger('Bool', itU8, wbBoolEnum),
        {06} wbNull,
        {07} wbRecursive('Struct', 3),
        {11} wbArray('Array of Object', wbScriptPropertyObject, -1),
        {12} wbArray('Array of String', wbLenString('Element', 2).OverrideEncoding(wbEncodingVMAD), -1),
        {13} wbArray('Array of Int32', wbInteger('Element', itS32), -1),
        {14} wbArray('Array of Float', wbFloat('Element'), -1),
        {15} wbArray('Array of Bool', wbInteger('Element', itU8, wbBoolEnum), -1),
        {16} wbStruct('Array of Variable', [wbInteger('Element Count', itU32)]),
        {17} wbArray('Array of Struct', wbRecursive('Struct', 4), -1)
      ])
    ]), -1, cpNormal, False);

  wbScriptProperty :=
    wbStructSK([0], 'Property', [
      wbLenString('propertyName', 2),
      wbInteger('Type', itU8, wbPropTypeEnum, cpNormal, False, nil, wbScriptPropertyTypeAfterSet),
      wbInteger('Flags', itU8, wbEnum([
        {0x00} '',
        {0x01} 'Edited',
        {0x02} '',
        {0x03} 'Removed'
      ])).SetDefaultEditValue('Edited'),
      wbUnion('Value', wbScriptPropertyDecider, [
       {00} wbNull,
       {01} wbScriptPropertyObject,
       {02} wbLenString('String', 2).OverrideEncoding(wbEncodingVMAD),
       {03} wbInteger('Int32', itS32),
       {04} wbFloat('Float'),
       {05} wbInteger('Bool', itU8, wbBoolEnum),
       {06} wbNull,
       {07} wbScriptPropertyStruct,
       {11} wbArray('Array of Object', wbScriptPropertyObject, -1),
       {12} wbArray('Array of String', wbLenString('Element', 2).OverrideEncoding(wbEncodingVMAD), -1),
       {13} wbArray('Array of Int32', wbInteger('Element', itS32), -1),
       {14} wbArray('Array of Float', wbFloat('Element'), -1),
       {15} wbArray('Array of Bool', wbInteger('Element', itU8, wbBoolEnum), -1),
       {16} wbStruct('Array of Variable', [wbInteger('Element Count', itU32)]),
       {17} wbArray('Array of Struct', wbScriptPropertyStruct, -1)
      ])
    ])
    .SetSummaryKey([1, 3])
    .SetSummaryMemberPrefixSuffix(0, '', ':')
    .SetSummaryMemberPrefixSuffix(3, '= ', '')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseScriptProperties);

  wbScriptProperties :=
    wbArrayS('Properties', wbScriptProperty, -2, cpNormal, False, nil, nil, nil, wbCanAddScriptProperties)
    .SetSummaryPassthroughMaxLength(80)
    .SetSummaryPassthroughMaxDepth(1);

  wbScriptEntry := wbStructSK([0], 'Script', [
    wbLenString('ScriptName', 2),
    wbScriptFlags,
    wbScriptProperties
  ])
  .SetSummaryKey([2])
  .SetSummaryMemberPrefixSuffix(2, '(', ')')
  .SetSummaryDelimiter('')
  .IncludeFlag(dfCollapsed, wbCollapseScriptEntry)
  .IncludeFlag(dfSummaryMembersNoName);

  wbScriptFragmentsInfo := wbStruct('Script Fragments', [
    wbInteger('Extra bind data version', itS8).SetDefaultNativeValue(3),
    wbInteger('Flags', itU8, wbFlags([
      {1} 'OnBegin',
      {2} 'OnEnd'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbScriptEntry,
    wbArray('Fragments',  // Do NOT sort, ordered OnBegin, OnEnd
      wbStruct('Fragment', [
        wbInteger('Unknown', itS8),
        wbLenString('ScriptName', 2),
        wbLenString('FragmentName', 2)
      ])
      .SetSummaryKey([1, 2])
      .SetSummaryMemberPrefixSuffix(1, '', ':')
      .SetSummaryDelimiter('')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseFragments)
      , [], wbScriptFragmentsInfoCounter)
  ])
  .SetSummaryKey([1, 2, 3])
  .IncludeFlag(dfSummaryMembersNoName);

  wbScriptFragmentsPack := wbStruct('Script Fragments', [
    wbInteger('Extra bind data version', itS8).SetDefaultNativeValue(3),
    wbInteger('Flags', itU8, wbFlags([
      {1} 'OnBegin',
      {2} 'OnEnd',
      {4} 'OnChange'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbScriptEntry,
    wbArray('Fragments',  // Do NOT sort, ordered OnBegin, OnEnd, OnChange
      wbStruct('Fragment', [
        wbInteger('Unknown', itS8),
        wbLenString('ScriptName', 2),
        wbLenString('FragmentName', 2)
      ])
      .SetSummaryKey([1, 2])
      .SetSummaryMemberPrefixSuffix(1, '', ':')
      .SetSummaryDelimiter('')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseFragments)
      , [], wbScriptFragmentsPackCounter)
  ])
  .SetSummaryKey([1, 2, 3])
  .IncludeFlag(dfSummaryMembersNoName);

  wbScriptFragmentsQuest := wbStruct('Script Fragments', [
    wbInteger('Extra bind data version', itS8).SetDefaultNativeValue(3),
    wbInteger('FragmentCount', itU16, nil, cpBenign),
    wbLenString('ScriptName', 2).SetAfterSet(wbScriptFragmentsQuestScriptNameAfterSet),
    // if ScriptName = "" then no Flags and Properties
    wbUnion('Script', wbScriptFragmentsEmptyScriptDecider, [
      wbStruct('Script Data', [
        wbScriptFlags,
        wbScriptProperties
      ]),
//       Quest [000179EF] <DialogueGenericPlayer>
//       Quest [000792CA] <DialogueGenericMerchants> "Merchant Dialogue System"
//       Quest [00091FE1] <DialogueDiamondCityChapel>
//       MQ101KelloggSequence "Kellogg Sequence in Vault 111" [QUST:000D3997]
//       DialogueGlowingSeaAtom "Children of the Atom Dialogue" [QUST:0012DB31]
//       BoSIdleHandlerQuest [QUST:00157460]
      wbNull
    ]),
    wbArrayS('Fragments',
      wbStructSK([0, 2], 'Fragment', [
        wbInteger('Quest Stage', itU16),
        wbInteger('Unknown', itS16),
        wbInteger('Quest Stage Index', itS32),
        wbInteger('Unknown', itS8),
        wbLenString('ScriptName', 2),
        wbLenString('FragmentName', 2)
      ])
      .SetSummaryKey([4, 5])
      .SetSummaryMemberPrefixSuffix(0, '[', '/')
      .SetSummaryMemberPrefixSuffix(2, '', ']')
      .SetSummaryMemberPrefixSuffix(4, ' ', ':')
      .SetSummaryDelimiter('')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseFragments)
    ).SetCountPath('FragmentCount', True)
  ])
  .SetSummaryKey([2, 3])
  .IncludeFlag(dfSummaryMembersNoName);

  wbScriptFragmentsScen := wbStruct('Script Fragments', [
    wbInteger('Extra bind data version', itS8).SetDefaultNativeValue(3),
    wbInteger('Flags', itU8, wbFlags([
      {1} 'OnBegin',
      {2} 'OnEnd'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbScriptEntry,
    wbArray('Fragments',  // Do NOT sort, ordered OnBegin, OnEnd
      wbStruct('Fragment', [
        wbInteger('Unknown', itS8),
        wbLenString('ScriptName', 2),
        wbLenString('FragmentName', 2)
      ])
      .SetSummaryKey([1, 2])
      .SetSummaryMemberPrefixSuffix(1, '', ':')
      .SetSummaryDelimiter('')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseFragments)
      , [], wbScriptFragmentsSceneCounter),
    wbArray('Phase Fragments',
      wbStructSK([0, 1], 'Phase Fragment', [
        wbInteger('Phase Flag', itU8, wbFlags([
          {1} 'OnStart',
          {2} 'OnCompletion'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbInteger('Phase Index', itU8),
        wbInteger('Unknown', itS16),
        wbInteger('Unknown', itS8),
        wbInteger('Unknown', itS8),
        wbLenString('ScriptName', 2),
        wbLenString('FragmentName', 2)
      ])
      .SetSummaryKey([5, 6])
      .SetSummaryMemberPrefixSuffix(0, '[', ':')
      .SetSummaryMemberPrefixSuffix(1, '', ']')
      .SetSummaryMemberPrefixSuffix(5, ' ', ':')
      .SetSummaryDelimiter('')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseFragments)
      , -2)
  ])
  .SetSummaryKey([1, 2, 3, 4])
  .IncludeFlag(dfSummaryMembersNoName);

  wbScriptFragments := wbStruct('Script Fragments', [
    wbInteger('Extra bind data version', itS8).SetDefaultNativeValue(3),
    wbScriptEntry,
    wbArrayS('Fragments',
      wbStructSK([0], 'Fragment', [
        wbInteger('Fragment Index', itU16),
        wbInteger('Unused', itS16, nil, cpIgnore, False, wbNeverShow),
        wbInteger('Unknown', itS8),
        wbLenString('ScriptName', 2),
        wbLenString('FragmentName', 2)
      ])
      .SetSummaryKey([3, 4])
      .SetSummaryMemberPrefixSuffix(0, '[', ']')
      .SetSummaryMemberPrefixSuffix(3, ' ', ':')
      .SetSummaryDelimiter('')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseFragments)
      , -2)
  ])
  .SetSummaryKey([1, 2])
  .IncludeFlag(dfSummaryMembersNoName);

  {>>> http://www.uesp.net/wiki/Tes5Mod:Mod_File_Format/VMAD_Field <<<}

  var wbVMADVersion :=
    wbInteger('Version', itS16, nil, cpIgnore).SetDefaultNativeValue(6);

  var wbVMADObjectFormat :=
    wbInteger('Object Format', itS16, nil, cpIgnore).SetDefaultNativeValue(2);

  var wbVMADScripts :=
    wbArrayS('Scripts', wbScriptEntry, -2, cpNormal, False, nil, nil, nil, wbCanAddScripts)
    .SetSummaryPassthroughMaxLength(100);


  wbVMAD := wbStruct(VMAD, 'Virtual Machine Adapter', [
    wbVMADVersion,
    wbVMADObjectFormat,
    wbVMADScripts
  ])
  .SetSummaryKeyOnValue([2]);

  wbVMADFragmentedPERK := wbStruct(VMAD, 'Virtual Machine Adapter', [
    wbVMADVersion,
    wbVMADObjectFormat,
    wbVMADScripts,
    wbScriptFragments
  ], cpNormal, False, nil, 3)
  .SetSummaryKeyOnValue([2, 3]);

  wbVMADFragmentedPACK := wbStruct(VMAD, 'Virtual Machine Adapter', [
    wbVMADVersion,
    wbVMADObjectFormat,
    wbVMADScripts,
    wbScriptFragmentsPack
  ], cpNormal, False, nil, 3)
  .SetSummaryKeyOnValue([2, 3]);

  wbVMADFragmentedQUST := wbStruct(VMAD, 'Virtual Machine Adapter', [
    wbVMADVersion,
    wbVMADObjectFormat,
    wbVMADScripts,
    wbScriptFragmentsQuest,
    wbArrayS('Aliases', wbStructSK([0], 'Alias', [
      wbScriptPropertyObject.IncludeFlag(dfCollapsed, wbCollapseOther),
      wbVMADVersion,
      wbVMADObjectFormat,
      wbArrayS('Alias Scripts', wbScriptEntry, -2)
    ]).SetSummaryKey([0, 3])
      .SetSummaryMemberPrefixSuffix(3, 'Script:(', ')')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryMembersNoName)
    , -2)
  ], cpNormal, False, nil, 3)
  .SetSummaryKeyOnValue([2, 3, 4]);

  wbVMADFragmentedSCEN := wbStruct(VMAD, 'Virtual Machine Adapter', [
    wbVMADVersion,
    wbVMADObjectFormat,
    wbVMADScripts,
    wbScriptFragmentsScen
  ], cpNormal, False, nil, 3)
  .SetSummaryKeyOnValue([2, 3]);

  wbVMADFragmentedINFO := wbStruct(VMAD, 'Virtual Machine Adapter', [
    wbVMADVersion,
    wbVMADObjectFormat,
    wbVMADScripts,
    wbScriptFragmentsInfo
  ], cpNormal, False, nil, 3)
  .SetSummaryKeyOnValue([2, 3]);

  wbAttackData := wbRStructSK([1], 'Attack', [
    wbStruct(ATKD, 'Attack Data', [
      wbFloat('Damage Mult'),
      wbFloat('Attack Chance'),
      wbFormIDCk('Attack Spell', [SPEL, NULL]),
      wbInteger('Attack Flags', itU32, wbFlags([
        {0x00000001} 'Ignore Weapon',
        {0x00000002} 'Bash Attack',
        {0x00000004} 'Power Attack',
        {0x00000008} 'Charge Attack',
        {0x00000010} 'Rotating Attack',
        {0x00000020} 'Continuous Attack',
        {0x00000040} 'Unknown 6',
        {0x00000080} 'Unknown 7',
        {0x00000100} 'Unknown 8',
        {0x00000200} 'Unknown 9',
        {0x00000400} 'Unknown 10',
        {0x00000800} 'Unknown 11',
        {0x00001000} 'Unknown 12',
        {0x00002000} 'Unknown 13',
        {0x00004000} 'Unknown 14',
        {0x00008000} 'Unknown 15',
        {0x00010000} 'Unknown 16',
        {0x00020000} 'Unknown 17',
        {0x00040000} 'Unknown 18',
        {0x00080000} 'Unknown 19',
        {0x00100000} 'Unknown 20',
        {0x00200000} 'Unknown 21',
        {0x00400000} 'Unknown 22',
        {0x00800000} 'Unknown 23',
        {0x01000000} 'Unknown 24',
        {0x02000000} 'Unknown 25',
        {0x04000000} 'Unknown 26',
        {0x08000000} 'Unknown 27',
        {0x10000000} 'Unknown 28',
        {0x20000000} 'Unknown 29',
        {0x40000000} 'Unknown 30',
        {0x80000000} 'Override Data'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFloat('Attack Angle'),
      wbFloat('Strike Angle'),
      wbFloat('Stagger'),
      wbFloat('Knockdown'),
      wbFloat('Recovery Time'),
      wbFloat('Action Points Mult'),
      wbInteger('Stagger Offset', itS32)
    ]),
    wbString(ATKE, 'Attack Event'),
    wbFormIDCk(ATKW, 'Weapon Slot', [EQUP]),
    wbFormIDCk(ATKS, 'Required Slot', [EQUP]),
    wbString(ATKT, 'Description')
  ]);

  wbLocationEnum := wbEnum([
    {0} 'Near reference', // string dump: '%s' in '%s' radius %u
    {1} 'In cell', // string dump: In cell '%s'
    {2} 'Near package start location', // string dump: Near package start location, radius %u
    {3} 'Near editor location', // string dump: Near editor location, radius %u
    {4} 'Object ID',
    {5} 'Object Type',
    {6} 'Near linked reference', // string dump: Near linked reference, radius %u%s%s
    {7} 'At package location', // string dump: At package location, radius %u
    {8} 'Alias (reference)', // string dump: Alias: %s [item #%u], radius %u
    {9} 'Alias (location)', // string dump: Alias: %s, radius %u
   {10} 'Target', // string dump: <Target>
   {11} 'Target (location)', // string dump: Target: %s, radius %u
   {12} 'Near self', // Near Self, radius %u
   {13} 'Near Editor Location Cell',
   {14} 'Alias (ref collection)'
  ]);

  wbObjectTypeEnum := wbEnum([
    { 0} ' NONE',
    { 1} 'Activators',
    { 2} 'Armor',
    { 3} 'Books',
    { 4} 'Containers',
    { 5} 'Doors',
    { 6} 'Ingredients',
    { 7} 'Lights',
    { 8} 'Miscellaneous',
    { 9} 'Flora',
    {10} 'Furniture',
    {11} 'Weapons: Any',
    {12} 'Ammo',
    {13} 'Keys',
    {14} 'Alchemy',
    {15} 'Food',
    {16} 'Clothing',
    {17} 'All: Wearable',
    {18} 'Weapons: NONE',
    {19} 'Weapons: Melee',
    {20} 'Weapons: Ranged',
    {21} 'Spells: Any',
    {22} 'Spells: Range Target',
    {23} 'Spells: Range Touch',
    {24} 'Spells: Range Self',
    {25} 'Actors: Any',
    {26} 'Furniture: Beds',
    {27} 'Furniture: Chairs',
    {28} 'Shouts',
    {29} 'Headtrack Markers'
  ]);

  wbPLDT := wbStruct(PLDT, 'Location', [
    wbInteger('Type', itS32, wbLocationEnum),
    wbUnion('Location Value', wbTypeDecider, [
      {0} wbFormIDCkNoReach('Reference', sigReferences),
      {1} wbFormIDCkNoReach('Cell', [NULL, CELL]),
      {2} wbByteArray('Near Package Start Location', 4, cpIgnore),
      {3} wbByteArray('Near Editor Location', 4, cpIgnore),
      {4} wbFormIDCkNoReach('Object ID', [NULL, ACTI, DOOR, STAT, MSTT, FURN, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, OMOD, BOOK, NOTE, KEYM, ALCH, INGR, LIGH, FACT, FLST, IDLM, TXST, PROJ]),
      {5} wbInteger('Object Type', itU32, wbObjectTypeEnum),
      {6} wbFormIDCk('Keyword', [NULL, KYWD]),
      {7} wbUnused(4),
      {8} wbInteger('Ref Alias', itS32, wbPackageLocationAliasToStr, wbAliasToInt),
      {9} wbInteger('Loc Alias', itS32, wbPackageLocationAliasToStr, wbAliasToInt),
     {10} wbInteger('Interrupt Data', itU32),
     {11} wbInteger('Packdata Target', itU32),
     {12} wbByteArray('Unknown', 4, cpIgnore),
     {13} wbByteArray('Unknown', 4),
     {14} wbInteger('Ref Collection Alias', itS32, wbPackageLocationAliasToStr, wbAliasToInt)
    ]),
    wbInteger('Radius', itS32),
    wbInteger('Collection Index', itU32)
  ], cpNormal, False, nil, 3);

  wbPLVD := wbStruct(PLVD, 'Location', [
    wbInteger('Type', itS32, wbLocationEnum),
    wbUnion('Location Value', wbTypeDecider, [
      {0} wbFormIDCkNoReach('Reference', sigReferences),
      {1} wbFormIDCkNoReach('Cell', [NULL, CELL]),
      {2} wbByteArray('Near Package Start Location', 4, cpIgnore),
      {3} wbByteArray('Near Editor Location', 4, cpIgnore),
      {4} wbFormIDCkNoReach('Object ID', [NULL, ACTI, DOOR, STAT, MSTT, FURN, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, OMOD, BOOK, NOTE, KEYM, ALCH, INGR, LIGH, FACT, FLST, IDLM, TXST, PROJ]),
      {5} wbInteger('Object Type', itU32, wbObjectTypeEnum),
      {6} wbFormIDCk('Keyword', [NULL, KYWD]),
      {7} wbUnused(4),
      {8} wbInteger('Ref Alias', itS32, wbPackageLocationAliasToStr, wbAliasToInt),
      {9} wbInteger('Loc Alias', itS32, wbPackageLocationAliasToStr, wbAliasToInt),
     {10} wbInteger('Interrupt Data', itU32),
     {11} wbInteger('Packdata Target', itU32),
     {12} wbByteArray('Unknown', 4, cpIgnore),
     {13} wbByteArray('Unknown', 4),
     {14} wbInteger('Ref Collection Alias', itS32, wbPackageLocationAliasToStr, wbAliasToInt)
    ]),
    wbInteger('Radius', itS32),
    wbInteger('Collection Index', itU32)
  ], cpNormal, False, nil, 3);

  wbTargetData := wbStruct('Target Data', [
    wbInteger('Type', itS32, wbEnum([
      {0} 'Specific Reference',
      {1} 'Object ID',
      {2} 'Object Type',
      {3} 'Linked Reference',
      {4} 'Ref Alias',
      {5} 'Interrupt Data',
      {6} 'Self',
      {7} 'Keyword',
      {8} 'Unknown 8'
    ]), cpNormal, False, nil, nil, 2),
    wbUnion('Target', wbTypeDecider, [
      {0} wbFormIDCkNoReach('Reference', sigReferences, True),
      {1} wbFormIDCkNoReach('Object ID', [NULL, ACTI, DOOR, STAT, MSTT, FURN, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, OMOD, BOOK, NOTE, KEYM, ALCH, INGR, LIGH, FACT, FLST, IDLM, TXST, PROJ]),
      {2} wbInteger('Object Type', itU32, wbObjectTypeEnum),
      {3} wbFormIDCk('Keyword', [KYWD, NULL]),
      {4} wbInteger('Alias', itS32, wbPackageLocationAliasToStr, wbAliasToInt),
      {5} wbInteger('Interrupt Data', itU32),
      {6} wbByteArray('Unknown', 4, cpIgnore),
      {7} wbFormIDCk('Keyword', [KYWD, NULL]),
      {8} wbByteArray('Unknown', 4, cpIgnore)
    ]),
    wbInteger('Count / Distance', itS32)
  ]);

  wbMODS := wbFormIDCk(MODS, 'Material Swap', [MSWP]);
  wbMO2S := wbFormIDCk(MO2S, 'Material Swap', [MSWP]);
  wbMO3S := wbFormIDCk(MO3S, 'Material Swap', [MSWP]);
  wbMO4S := wbFormIDCk(MO4S, 'Material Swap', [MSWP]);
  wbMO5S := wbFormIDCk(MO5S, 'Material Swap', [MSWP]);

  wbModelFlags := wbFlags([
    'Has FaceBones Model',
    'Has 1stPerson Model'
  ]);
  wbMODF := wbInteger(MODF, 'Flags', itU8, wbModelFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);
  wbMO2F := wbInteger(MO2F, 'Flags', itU8, wbModelFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);
  wbMO3F := wbInteger(MO3F, 'Flags', itU8, wbModelFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);
  wbMO4F := wbInteger(MO4F, 'Flags', itU8, wbModelFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);
  wbMO5F := wbInteger(MO5F, 'Flags', itU8, wbModelFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);

  wbMODC := wbFloat(MODC, 'Color Remapping Index');
  wbMO2C := wbFloat(MO2C, 'Color Remapping Index');
  wbMO3C := wbFloat(MO3C, 'Color Remapping Index');
  wbMO4C := wbFloat(MO4C, 'Color Remapping Index');
  wbMO5C := wbFloat(MO5C, 'Color Remapping Index');

  wbDMDS := wbFormIDCk(DMDS, 'Material Swap', [MSWP]);
  wbDMDC := wbFloat(DMDC, 'Color Remapping Index');

  wbDEST := wbRStruct('Destructible', [
    wbStruct(DEST, 'Header', [
      wbInteger('Health', itS32),
      wbInteger('DEST Count', itU8),
      wbInteger('Flags', itU8, wbFlags([
        'VATS Targetable',
        'Large Actor Destroys'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbByteArray('Unknown', 2)
    ]).SetSummaryKeyOnValue([0, 2])
      .SetSummaryPrefixSuffixOnValue(0,'Health ','')
      .SetSummaryPrefixSuffixOnValue(2,'{','}')
      .IncludeFlag(dfCollapsed, wbCollapseDestruction),
    wbArrayS(DAMC, 'Resistances', wbStructSK([0], 'Resistance', [
      wbFormIDCk('Damage Type', [DMGT]),
      wbInteger('Value', itU32)
    ])),
    wbRArray('Stages',
      wbRStruct('Stage', [
        wbStruct(DSTD, 'Destruction Stage Data', [
          wbInteger('Health %', itU8),
          wbInteger('Index', itU8),
          wbInteger('Model Damage Stage', itU8),
          wbInteger('Flags', itU8, wbFlags([
            'Cap Damage',
            'Disable',
            'Destroy',
            'Ignore External Dmg',
            'Becomes Dynamic'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
          wbInteger('Self Damage per Second', itS32),
          wbFormIDCk('Explosion', [EXPL, NULL]),
          wbFormIDCk('Debris', [DEBR, NULL]),
          wbInteger('Debris Count', itS32)
        ], cpNormal, True)
        .SetSummaryKeyOnValue([0,5,6])
        .SetSummaryPrefixSuffixOnValue(0,'Health ','%')
        .SetSummaryDelimiterOnValue(', ')
        .IncludeFlagOnValue(dfSummaryExcludeNULL)
        .IncludeFlagOnValue(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed, wbCollapseDestruction),
        wbString(DSTA, 'Sequence Name'),
        wbRStructSK([0], 'Model', [
          wbString(DMDL, 'Model FileName', 0, cpNormal, True),
          wbDMDT,
          wbDMDC,
          wbDMDS
        ], [], cpNormal, False, nil, True)
          .SetSummaryKey([0])
          .IncludeFlag(dfCollapsed, wbCollapseModels),
        wbEmpty(DSTF, 'End Marker', cpNormal, True)
      ], [], cpNormal, False, nil)
        .SetSummaryKey([0, 2])
        .IncludeFlag(dfSummaryMembersNoName)
    )
  ], [], cpNormal, False, nil);

  wbXESP := wbStruct(XESP, 'Enable Parent', [
    wbFormIDCk('Reference', sigReferences),
    wbInteger('Flags', itU8, wbFlags([
      'Set Enable State to Opposite of Parent',
      'Pop In'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbUnused(3)
  ]);

  wbPDTO :=
    wbStruct(PDTO, 'Topic Data', [
      wbInteger('Type', itU32, wbEnum([
        'Topic Ref',
        'Topic Subtype'
      ])),
      wbUnion('Data', wbTypeDecider, [
        wbFormIDCk('Topic', [DIAL, NULL]),
        wbString('Subtype', 4)
      ])
    ]);

  wbPDTOs := wbRArray('Topic', wbPDTO, cpNormal, False, nil);

  wbXLCM := wbInteger(XLCM, 'Level Modifier', itS32, wbEnum([
    'Easy',
    'Medium',
    'Hard',
    'Very Hard'
  ]));

	wbNVNM :=
    wbStruct(NVNM, 'Navmesh Geometry', [
	    wbInteger('Version', itU32).SetDefaultNativeValue(15),
	    wbStruct('Pathing Cell', [
        wbInteger('CRC Hash', itU32, wbCRCValuesEnum).SetDefaultEditValue('PathingCell'),
        wbFormIDCk('Parent World', [WRLD, NULL]).IncludeFlag(dfSummaryExcludeNULL),
        wbUnion('Parent', wbNVNMParentDecider, [
          wbStruct('Coordinates', [
            wbInteger('Grid Y', itS16),
            wbInteger('Grid X', itS16)
          ]),
          wbFormIDCk('Parent Cell', [CELL])
        ])
	    ]).SetSummaryKey([2,1])
        .IncludeFlag(dfSummaryMembersNoName),
	    IfThen(wbSimpleRecords,
        wbArray('Vertices',
          wbByteArray('Vertex', 12),
        -1).IncludeFlag(dfNotAlignable),
        wbArray('Vertices',
          wbVec3('Vertex'),
        -1).IncludeFlag(dfNotAlignable)
      ),
	    IfThen(wbSimpleRecords,
        wbArray('Triangles',
          wbByteArray('Triangle', 21),
        -1).IncludeFlag(dfNotAlignable),
        wbArray('Triangles',
			    wbStruct('Triangle', [
				    wbInteger('Vertex 0', itU16, wbVertexToStr0, wbVertexToInt0).SetLinksToCallback(wbVertexLinksTo),
				    wbInteger('Vertex 1', itU16, wbVertexToStr1, wbVertexToInt1).SetLinksToCallback(wbVertexLinksTo),
				    wbInteger('Vertex 2', itU16, wbVertexToStr2, wbVertexToInt2).SetLinksToCallback(wbVertexLinksTo),
				    wbInteger('Edge 0-1', itS16, wbEdgeToStr0, wbEdgeToInt0).SetLinksToCallback(wbEdgeLinksTo0),
				    wbInteger('Edge 1-2', itS16, wbEdgeToStr1, wbEdgeToInt1).SetLinksToCallback(wbEdgeLinksTo1),
				    wbInteger('Edge 2-0', itS16, wbEdgeToStr2, wbEdgeToInt2).SetLinksToCallback(wbEdgeLinksTo2),
				    wbFloat('Height'),
				    wbInteger('Unknown', itU8),
				    wbInteger('Flags', itU16, wbNavmeshTriangleFlags)
              .IncludeFlag(dfCollapsed, wbCollapseFlags),
				    wbInteger('Cover Flags', itU16, wbNavmeshCoverFlags)
              .IncludeFlag(dfCollapsed, wbCollapseFlags)
			    ]),
        -1).IncludeFlag(dfNotAlignable)
      ),
	    wbArray('Edge Links',
		    wbStruct('Edge Link', [
			    wbInteger('Type', itU32, wbNavmeshEdgeLinkEnum),
			    wbFormIDCk('Navmesh', [NAVM], False, cpIgnore),
			    wbInteger('Triangle', itS16, nil, cpIgnore),
			    wbByteArray('Edge Index', 1, cpIgnore)
		    ], cpIgnore),
      -1, cpIgnore).IncludeFlag(dfNotAlignable),
	    wbArrayS('Door Links',
		    wbStructSK([0, 2], 'Door Link', [
			    wbInteger('Triangle', itS16).SetLinksToCallback(wbTriangleLinksTo),
			    wbInteger('CRC Hash', itU32, wbCRCValuesEnum).SetDefaultEditValue('PathingDoor'),
			    wbFormIDCk('Door Ref', [REFR])
		    ]),
      -1),
	    IfThen(wbSimpleRecords,
        wbArray('Cover Array',
          wbByteArray('Cover', 8),
        -1).IncludeFlag(dfNotAlignable),
        wbArray('Cover Array',  // if navmesh version gt 12
			    wbStruct('Cover', [
				    wbInteger('Vertex 1', itU16).SetLinksToCallback(wbVertexLinksTo),
				    wbInteger('Vertex 2', itU16).SetLinksToCallback(wbVertexLinksTo),
				    wbByteArray('Data', 4 {, wbFlags([]) ? })
			    ]),
        -1).IncludeFlag(dfNotAlignable)
      ),
	    IfThen(wbSimpleRecords,
        wbArray('Cover Triangle Mappings',
          wbByteArray('Cover Triangle', 4),
        -1).IncludeFlag(dfNotAlignable),
        wbArray('Cover Triangle Mappings',
			    wbStruct('Cover Triangle Map', [
				    wbInteger('Cover', itU16).SetLinksToCallback(wbCoverLinksTo),
				    wbInteger('Triangle', itS16).SetLinksToCallback(wbTriangleLinksTo)
			    ]),
        -1).IncludeFlag(dfNotAlignable)
      ),
	    IfThen(wbSimpleRecords,
        wbArray('Waypoints',
          wbByteArray('Waypoint', 18),
        -1).IncludeFlag(dfNotAlignable),
        wbArray('Waypoints',  // if navmesh version gt 11
			    wbStruct('Waypoint', [
				    wbFloat('X'),
				    wbFloat('Y'),
			   	  wbFloat('Z'),
			   	  wbInteger('Triangle', itS16).SetLinksToCallback(wbTriangleLinksTo),
			   	  wbInteger('Flags', itU32)
			    ]),
        -1).IncludeFlag(dfNotAlignable)
      ),
      wbStruct('Navmesh Grid', [
        wbInteger('Divisor', itU32),
        wbStruct('Grid Size', [
          wbFloat('X'),
          wbFloat('Y')
        ]),
        wbStruct('Navmesh Bounds', [
          wbVec3('Min'),
          wbVec3('Max')
        ]),
        IfThen(wbSimpleRecords,
          wbArray('Cells',
            wbArray('Cell',
              wbByteArray('Triangle', 2),
            -1).SetSummaryName('Triangles')
               .IncludeFlag(dfNotAlignable),
          wbNavmeshGridCounter).IncludeFlag(dfNotAlignable),
          wbArray('Cells',
            wbArray('Cell',
              wbInteger('Triangle', itS16).SetLinksToCallback(wbTriangleLinksTo),
            -1).SetSummaryName('Triangles')
               .IncludeFlag(dfNotAlignable),
          wbNavmeshGridCounter).IncludeFlag(dfNotAlignable)
        )
      ])
	  ]);

  wbRefRecord(ACHR, 'Placed NPC',
    wbFlags(wbFlagsList([
      9, 'Starts Dead',
     10, 'Persistent',
     11, 'Initially Disabled',
     13, 'Starts Unconscious',
     25, 'No AI Acquire',
     29, 'Don''t Havok Settle'
    ], True, True)), [
    wbEDID,
    wbVMAD,
    wbFormIDCk(NAME, 'Base', [NPC_], False, cpNormal, True),
    wbActionFlag,
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    {--- Ragdoll ---}
    wbRagdoll,

    {--- Lock ---}
    wbStruct(XLOC, 'Lock Data', [
      wbInteger('Level', itU8, wbEnum([], [
         0, 'None',
         1, 'Novice 1',
        25, 'Novice 25',
        50, 'Advanced',
        75, 'Expert',
       100, 'Master',
       253, 'Requires Terminal',
       251, 'Barred',
       252, 'Chained',
       254, 'Inaccessible',
       255, 'Requires Key'
      ])),
      wbUnused(3),
      wbFormIDCkNoReach('Key', [KEYM, NULL]),
      wbInteger('Flags', itU8, wbFlags(['', '', 'Leveled Lock'])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbUnused(3),
      wbUnknown
    ], cpNormal, False, nil, 4),

    {--- Lit Water ---}
    wbRArrayS('Lit Water',
      wbFormIDCk(XLTW, 'Water', [REFR, ACHR])
    ),
    wbRArrayS('Reflected/Refracted By',
      wbStructSK(XPWR, [0], 'Water', [
        wbFormIDCk('Reference', [ACHR, REFR]),
        wbInteger('Type', itU32, wbFlags([
          'Reflection',
          'Refraction'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
      ], cpNormal, False, nil, 1)
    ),

    {--- Patrol Data ---}
    wbRStruct('Patrol Data', [
      wbFloat(XPRD, 'Idle Time', cpNormal, True),
      wbEmpty(XPPA, 'Patrol Script Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbPDTOs,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal)
    ]),

    {--- Leveled Actor ----}
    wbXLCM,

    {--- Extra ---}
    wbInteger(XCNT, 'Count', itS32),
    wbFloat(XRDS, 'Radius'),
    wbInteger(XHLT, 'Health %', itU32),

    wbRArrayS('Linked References', wbStructSK(XLKR, [0], 'Linked Reference', [
      wbFormIDCk('Keyword/Ref', [KYWD, PLYR, ACHR, REFR, PGRE, PHZD, PMIS, PARW, PBAR, PBEA, PCON, PFLA, NULL]),
      wbFormIDCk('Ref', sigReferences)
    ], cpNormal, False, nil, 1)),

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', sigReferences),
          wbFloat('Delay')
        ])
      )
    ]),
    wbEmpty(XATP, 'Activation Point'),

    wbEmpty(XLKT, 'Linked Ref Transient'),
    wbFormIDCk(XRFG, 'Reference Group', [RFGP]),
    wbFormIDCk(XLYR, 'Layer', [LAYR]),
    wbFormIDCk(XMSP, 'Material Swap', [MSWP]),

    {--- Attach reference ---}
    wbFormIDCk(XATR, 'Attach Ref', [REFR, PGRE, PHZD, PMIS, PARW, PBAR, PBEA, PCON, PFLA, ACHR]),

    wbFormIDCk(XLCN, 'Persist Location', [LCTN]),
    wbFormIDCk(XLRL, 'Location Reference', [LCRT, LCTN, NULL], False, cpBenignIfAdded),
    wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),

    wbRStruct('Water Current Velocities', [
      wbInteger(XWCN, 'Velocity Count', itU32, nil, cpBenign),
      wbArray(XWCU, 'Velocities',
        wbStruct('Current', [
          wbVec3('Velocity'),
          wbFloat
        ])
      ).SetCountPathOnValue(XWCN, False)
       .SetRequired
       .IncludeFlag(dfCollapsed, wbCollapseOther)
       .IncludeFlag(dfNotAlignable)
    ]),

    wbEmpty(XIS2, 'Ignored by Sandbox'),
    wbRArray('Spline Connection', wbStruct(XPLK, 'Link', [
      wbFormIDCk('Ref', [REFR, ACHR]),
      wbUnknown  // always 00 00 00 00 so far in DLCWorkshop03.esm
    ])),
    wbFloat(XHTW, 'Head-Tracking Weight'),
    wbFloat(XFVC, 'Favor Cost'),

    {--- Enable Parent ---}
    wbXESP,

    {--- Ownership ---}
    wbOwnership,

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', sigReferences),

    {--- Flags ---}
    wbEmpty(XIBS, 'Ignored By Sandbox'),

    {--- 3D Data ---}
    wbXSCL,
    wbEmpty(ONAM, 'Open by Default'),
    wbDATAPosRot,
    wbString(MNAM, 'Comments')
  ], True).SetAddInfo(wbPlacedAddInfo);

  wbVatsValueFunctionEnum :=
    wbEnum([
      { 0} 'Weapon Is',
      { 1} 'Weapon In List',
      { 2} 'Target Is',
      { 3} 'Target In List',
      { 4} 'Target Distance',
      { 5} 'Target Part',
      { 6} 'VATS Action',
      { 7} 'Is Success',
      { 8} 'Is Critical',
      { 9} 'Critical Effect Is',
      {10} 'Critical Effect In List',
      {11} 'Is Fatal',
      {12} 'Explode Part',
      {13} 'Dismember Part',
      {14} 'Cripple Part',
      {15} 'Weapon Type Is',
      {16} 'Is Stranger',
      {17} 'Is Paralyzing Palm',
      {18} 'Projectile Type Is',
      {19} 'Delivery Type Is',
      {20} 'Casting Type Is'
    ]);

  wbActorValueEnum :=
    wbEnum([
    {00} 'Aggression',
    {01} 'Confidence',
    {02} 'Energy',
    {03} 'Morality',
    {04} 'Mood',
    {05} 'Assistance',
    {06} 'One-Handed',
    {07} 'Two-Handed',
    {08} 'Archery',
    {09} 'Block',
    {10} 'Smithing',
    {11} 'Heavy Armor',
    {12} 'Light Armor',
    {13} 'Pickpocket',
    {14} 'Lockpicking',
    {15} 'Sneak',
    {16} 'Alchemy',
    {17} 'Speech',
    {18} 'Alteration',
    {19} 'Conjuration',
    {20} 'Destruction',
    {21} 'Illusion',
    {22} 'Restoration',
    {23} 'Enchanting',
    {24} 'Health',
    {25} 'Magicka',
    {26} 'Stamina',
    {27} 'Heal Rate',
    {28} 'Magicka Rate',
    {29} 'Stamina Rate',
    {30} 'Speed Mult',
    {31} 'Inventory Weight',
    {32} 'Carry Weight',
    {33} 'Critical Chance',
    {34} 'Melee Damage',
    {35} 'Unarmed Damage',
    {36} 'Mass',
    {37} 'Voice Points',
    {38} 'Voice Rate',
    {39} 'Damage Resist',
    {40} 'Poison Resist',
    {41} 'Resist Fire',
    {42} 'Resist Shock',
    {43} 'Resist Frost',
    {44} 'Resist Magic',
    {45} 'Resist Disease',
    {46} 'Unknown 46',
    {47} 'Unknown 47',
    {48} 'Unknown 48',
    {49} 'Unknown 49',
    {50} 'Unknown 50',
    {51} 'Unknown 51',
    {52} 'Unknown 52',
    {53} 'Paralysis',
    {54} 'Invisibility',
    {55} 'Night Eye',
    {56} 'Detect Life Range',
    {57} 'Water Breathing',
    {58} 'Water Walking',
    {59} 'Unknown 59',
    {60} 'Fame',
    {61} 'Infamy',
    {62} 'Jumping Bonus',
    {63} 'Ward Power',
    {64} 'Right Item Charge',
    {65} 'Armor Perks',
    {66} 'Shield Perks',
    {67} 'Ward Deflection',
    {68} 'Variable01',
    {69} 'Variable02',
    {70} 'Variable03',
    {71} 'Variable04',
    {72} 'Variable05',
    {73} 'Variable06',
    {74} 'Variable07',
    {75} 'Variable08',
    {76} 'Variable09',
    {77} 'Variable10',
    {78} 'Bow Speed Bonus',
    {79} 'Favor Active',
    {80} 'Favors Per Day',
    {81} 'Favors Per Day Timer',
    {82} 'Left Item Charge',
    {83} 'Absorb Chance',
    {84} 'Blindness',
    {85} 'Weapon Speed Mult',
    {86} 'Shout Recovery Mult',
    {87} 'Bow Stagger Bonus',
    {88} 'Telekinesis',
    {89} 'Favor Points Bonus',
    {90} 'Last Bribed Intimidated',
    {91} 'Last Flattered',
    {92} 'Movement Noise Mult',
    {93} 'Bypass Vendor Stolen Check',
    {94} 'Bypass Vendor Keyword Check',
    {95} 'Waiting For Player',
    {96} 'One-Handed Modifier',
    {97} 'Two-Handed Modifier',
    {98} 'Marksman Modifier',
    {99} 'Block Modifier',
   {100} 'Smithing Modifier',
   {101} 'Heavy Armor Modifier',
   {102} 'Light Armor Modifier',
   {103} 'Pickpocket Modifier',
   {104} 'Lockpicking Modifier',
   {105} 'Sneaking Modifier',
   {106} 'Alchemy Modifier',
   {107} 'Speechcraft Modifier',
   {108} 'Alteration Modifier',
   {109} 'Conjuration Modifier',
   {110} 'Destruction Modifier',
   {111} 'Illusion Modifier',
   {112} 'Restoration Modifier',
   {113} 'Enchanting Modifier',
   {114} 'One-Handed Skill Advance',
   {115} 'Two-Handed Skill Advance',
   {116} 'Marksman Skill Advance',
   {117} 'Block Skill Advance',
   {118} 'Smithing Skill Advance',
   {119} 'Heavy Armor Skill Advance',
   {120} 'Light Armor Skill Advance',
   {121} 'Pickpocket Skill Advance',
   {122} 'Lockpicking Skill Advance',
   {123} 'Sneaking Skill Advance',
   {124} 'Alchemy Skill Advance',
   {125} 'Speechcraft Skill Advance',
   {126} 'Alteration Skill Advance',
   {127} 'Conjuration Skill Advance',
   {128} 'Destruction Skill Advance',
   {129} 'Illusion Skill Advance',
   {130} 'Restoration Skill Advance',
   {131} 'Enchanting Skill Advance',
   {132} 'Left Weapon Speed Multiply',
   {133} 'Dragon Souls',
   {134} 'Combat Health Regen Multiply',
   {135} 'One-Handed Power Modifier',
   {136} 'Two-Handed Power Modifier',
   {137} 'Marksman Power Modifier',
   {138} 'Block Power Modifier',
   {139} 'Smithing Power Modifier',
   {140} 'Heavy Armor Power Modifier',
   {141} 'Light Armor Power Modifier',
   {142} 'Pickpocket Power Modifier',
   {143} 'Lockpicking Power Modifier',
   {144} 'Sneaking Power Modifier',
   {145} 'Alchemy Power Modifier',
   {146} 'Speechcraft Power Modifier',
   {147} 'Alteration Power Modifier',
   {148} 'Conjuration Power Modifier',
   {149} 'Destruction Power Modifier',
   {150} 'Illusion Power Modifier',
   {151} 'Restoration Power Modifier',
   {152} 'Enchanting Power Modifier',
   {153} 'Dragon Rend',
   {154} 'Attack Damage Mult',
   {155} 'Heal Rate Mult',
   {156} 'Magicka Rate Mult',
   {157} 'Stamina Rate Mult',
   {158} 'Werewolf Perks',
   {159} 'Vampire Perks',
   {160} 'Grab Actor Offset',
   {161} 'Grabbed',
   {162} 'Unknown 162',
   {163} 'Reflect Damage'
      ], [
        -1, 'None'
      ]);

  wbCastEnum := wbEnum([
    {0} 'Constant Effect',
    {1} 'Fire and Forget',
    {2} 'Concentration',
    {3} 'Scroll'
  ]);

  wbTargetEnum := wbEnum([
    {0} 'Self',
    {1} 'Touch',
    {2} 'Aimed',
    {3} 'Target Actor',
    {4} 'Target Location'
  ]);

  wbCastingSourceEnum := wbEnum([
    'Left',
    'Right',
    'Voice',
    'Instant'
  ]);

  wbKeywordTypeEnum :=
    wbEnum([
      {00} 'None',
      {01} 'Component Tech Level',
      {02} 'Attach Point',
      {03} 'Component Property',
      {04} 'Instantiation Filter',
      {05} 'Mod Association',
      {06} 'Sound',
      {07} 'Anim Archetype',
      {08} 'Function Call',
      {09} 'Recipe Filter',
      {10} 'Attraction Type',
      {11} 'Dialogue Subtype',
      {12} 'Quest Target',
      {13} 'Anim Flavor',
      {14} 'Anim Gender',
      {15} 'Anim Face',
      {16} 'Quest Group',
      {17} 'Anim Injured',
      {18} 'Dispel Effect'
    ]);

  wbETYP := wbFormIDCk(ETYP, 'Equipment Type', [EQUP, NULL]);
  wbETYPReq := wbFormIDCk(ETYP, 'Equipment Type', [EQUP, NULL], False, cpNormal, True);

  wbFormTypeEnum := wbEnum([], [
     0, 'Activator',
     1, 'Armor',
     2, 'Book',
     3, 'Container',
     4, 'Door',
     5, 'Ingredient',
     6, 'Light',
     7, 'MiscItem',
     8, 'Static',
     9, 'Grass',
    10, 'Tree',
    12, 'Weapon',
    13, 'Actor',
    14, 'LeveledCharacter',
    15, 'Spell',
    16, 'Enchantment',
    17, 'Potion',
    18, 'LeveledItem',
    19, 'Key',
    20, 'Ammo',
    21, 'Flora',
    22, 'Furniture',
    23, 'Sound Marker',
    24, 'LandTexture',
    25, 'CombatStyle',
    26, 'LoadScreen',
    27, 'LeveledSpell',
    28, 'AnimObject',
    29, 'WaterType',
    30, 'IdleMarker',
    31, 'EffectShader',
    32, 'Projectile',
    33, 'TalkingActivator',
    34, 'Explosion',
    35, 'TextureSet',
    36, 'Debris',
    37, 'MenuIcon',
    38, 'FormList',
    39, 'Perk',
    40, 'BodyPartData',
    41, 'AddOnNode',
    42, 'MovableStatic',
    43, 'CameraShot',
    44, 'ImpactData',
    45, 'ImpactDataSet',
    46, 'Quest',
    47, 'Package',
    48, 'VoiceType',
    49, 'Class',
    50, 'Race',
    51, 'Eyes',
    52, 'HeadPart',
    53, 'Faction',
    54, 'Note',
    55, 'Weather',
    56, 'Climate',
    57, 'ArmorAddon',
    58, 'Global',
    59, 'Imagespace',
    60, 'Imagespace Modifier',
    61, 'Encounter Zone',
    62, 'Message',
    63, 'Constructible Object',
    64, 'Acoustic Space',
    65, 'Ragdoll',
    66, 'Script',
    67, 'Magic Effect',
    68, 'Music Type',
    69, 'Static Collection',
    70, 'Keyword',
    71, 'Location',
    72, 'Location Ref Type',
    73, 'Footstep',
    74, 'Footstep Set',
    75, 'Material Type',
    76, 'Actor Action',
    77, 'Music Track',
    78, 'Word of Power',
    79, 'Shout',
    80, 'Relationship',
    81, 'Equip Slot',
    82, 'Association Type',
    83, 'Outfit',
    84, 'Art Object',
    85, 'Material Object',
    87, 'Lighting Template',
    88, 'Shader Particle Geometry',
    89, 'Visual Effect',
    90, 'Apparatus',
    91, 'Movement Type',
    92, 'Hazard',
    93, 'SM Event Node',
    94, 'Sound Descriptor',
    95, 'Dual Cast Data',
    96, 'Sound Category',
    97, 'Soul Gem',
    98, 'Sound Output Model',
    99, 'Collision Layer',
   100, 'Scroll',
   101, 'ColorForm',
   102, 'Reverb Parameters',
   103, 'PackIn',
   104, 'Reference Group',
   105, 'BendableSpline',
   106, 'Layer',
   107, 'DefaultObject',
   108, 'AimModel',
   109, 'Component',
   110, 'Object Mod',
   111, 'Material Swap',
   112, 'Transform',
   113, 'ZoomData',
   114, 'Instance Naming Rules',
   115, 'Sound Keyword Mapping',
   116, 'Terminal',
   117, 'Effect Chain',
   118, 'Damage Type',
   119, 'Actor Value',
   120, 'AttractionRule',
   121, 'Category Snapshot',
   122, 'Animation Tag Set',
   123, 'LensFlare',
   125, 'GodRays'
  ]);

  wbMiscStatEnum := wbEnum([], [
    Int64($1EE71DBC), 'Animals Friended',
    Int64($FCDD5011), 'Animals Killed',
    Int64($366D84CF), 'Armor Improved',
    Int64($8E20D7C9), 'Assaults',
    Int64($B9B50725), 'Backstabs',
    Int64($EA01A954), 'Bobbleheads Collected',
    Int64($6932624D), 'Bright Ideas',
    Int64($7FF0CC3B), 'Brotherhood of Steel Quests Completed',
    Int64($FEA920AA), 'Buildings',
    Int64($1F84743B), 'Caps Found',
    Int64($9360004C), 'Chems Crafted',
    Int64($B2A78B7A), 'Chems Taken',
    Int64($53D9E9B5), 'Chests Looted',
    Int64($1E258BEE), 'Computers Hacked',
    Int64($3DE99B41), 'Cores Ejected',
    Int64($737EAA97), 'Corpses Eaten',
    Int64($40B11EFE), 'Creatures Killed',
    Int64($4C4B8DF3), 'Creatures Killed DLC03',
    Int64($22D5BA38), 'Critical Strikes',
    Int64($3C626A90), 'Days Passed',
    Int64($C5A52FD0), 'Days Survived',
    Int64($45FDBB1C), 'DLC01 Quests Completed',
    Int64($FA7CC7F9), 'DLC03 Locations Discovered',
    Int64($AA444695), 'Dungeons Cleared',
    Int64($F4E8FFD6), 'Fatman Deaths',
    Int64($66DAF3CF), 'Fits of Rage',
    Int64($554E59D5), 'Food',
    Int64($E1EB3490), 'Food Cooked',
    Int64($9311B22B), 'Food Eaten',
    Int64($F947D866), 'Four Leaf Clovers',
    Int64($7C586E7A), 'Fusion Cores Consumed',
    Int64($2826309E), 'Game Difficulty',
    Int64($A5EA7ABC), 'Grand Slams',
    Int64($F5A36770), 'Grim Reaper Sprints',
    Int64($52984AA4), 'Happiness',
    Int64($FA024018), 'Hours Slept',
    Int64($CAD2ECA1), 'Hours Waiting',
    Int64($8CC5DAB6), 'HSAtomicCommand',
    Int64($A2E4C1F2), 'HSAutomatron',
    Int64($20F9993D), 'HSGrognak',
    Int64($8D882844), 'HSJangles',
    Int64($910B02C0), 'HSPipfall',
    Int64($860E0723), 'HSRedMenace',
    Int64($3FFA8658), 'HSZetaInvaders',
    Int64($40CA9C83), 'Institute Quests Completed',
    Int64($7D2E57C0), 'Intimidations',
    Int64($FFE8010B), 'Investments Made',
    Int64($9AF17D9D), 'Items Crafted DLC03',
    Int64($CF48C0B9), 'Items Scrapped',
    Int64($82F190C2), 'Items Stolen',
    Int64($6D8671DD), 'Junk Collected',
    Int64($110B8D2F), 'Legendary Enemies Killed',
    Int64($8A24FDE2), 'Locations Discovered',
    Int64($5829CC2E), 'Locks Picked',
    Int64($7EA26C2D), 'Main Quests Completed',
    Int64($493B803C), 'Mines Disarmed',
    Int64($B1511B82), 'Minuteman Quests Completed',
    Int64($98EE55DC), 'Misc Objectives Completed',
    Int64($0F3315AC), 'Money Shots',
    Int64($5E457DAC), 'Most Caps Carried',
    Int64($D37C6909), 'Murders',
    Int64($B91253A4), 'Mysterious Stranger Visits',
    Int64($1DEEA18A), 'Nuka Cola Flavors Created',
    Int64($9CE72536), 'Nuka World Creatures Killed',
    Int64($EB0D60AC), 'Objects Built',
    Int64($73AD915B), 'Pants Exploded',
    Int64($53706A04), 'Paralyzing Punches',
    Int64($9E78CEB3), 'People',
    Int64($F22A8133), 'People Killed',
    Int64($D3F632FF), 'Plants Harvested',
    Int64($856FA4C1), 'PlayedFutureRetroHolotape',
    Int64($F2BAC234), 'Pockets Picked',
    Int64($AC69D9B9), 'Power',
    Int64($0D7B8B16), 'Quests Completed',
    Int64($0580BB9F), 'RadAway Taken',
    Int64($D2960073), 'Rad-X Taken',
    Int64($FDE20426), 'Railroad Quests Completed',
    Int64($3CBF7E59), 'Ricochets',
    Int64($01E1BC85), 'Robots Disabled',
    Int64($2CA4ECC0), 'Robots Improved',
    Int64($C8BC93BE), 'Robots Killed',
    Int64($98D5710C), 'Sandman Kills',
    Int64($B1AE4792), 'Side Quests Completed',
    Int64($ACE470D7), 'Skill Books Read',
    Int64($B556CC52), 'Sneak Attacks',
    Int64($32D1B38F), 'Speach Successes',
    Int64($5D6B18F1), 'Stimpaks Taken',
    Int64($C5321BC5), 'Supply Lines Created',
    Int64($3869002E), 'Survival Denied',
    Int64($F9DEC209), 'Survival Level-Ups',
    Int64($69AF5B9A), 'Synths Killed',
    Int64($0A872FA3), 'Times Addicted',
    Int64($7AEA9C2B), 'Trespasses',
    Int64($13752285), 'Turrets Killed',
    Int64($0B479511), 'Wasteland Whispers',
    Int64($FCD0CCC3), 'Water',
    Int64($61A5C5A9), 'Weapons Disarmed',
    Int64($1D3BA844), 'Weapons Improved',
    Int64($60A11697), 'Workshops Unlocked'
  ]);

  wbAdvanceActionEnum := wbEnum([
    'Normal Usage',
    'Power Attack',
    'Bash',
    'Lockpick Success',
    'Lockpick Broken'
  ]);

  wbStaggerEnum := wbEnum([
    'None',
    'Small',
    'Medium',
    'Large',
    'Extra Large'
  ]);

  wbEFID := wbFormIDCk(EFID, 'Base Effect', [MGEF]);

  wbEFIT :=
    wbStructSK(EFIT, [0,1,2], '', [
      wbFloat('Magnitude', cpNormal, True),
      wbInteger('Area', itU32),
      wbInteger('Duration', itU32)
    ], cpNormal, True, nil, -1, wbEFITAfterLoad);

  var wbConditionParameters := [
    //Misc
    {0} wbByteArray('Unknown', 4).IncludeFlag(dfZeroSortKey),
    {1} wbByteArray('None', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
    {2} wbFloat('Float'),
    {3} wbInteger('Integer', itS32),
    {4} wbInteger('String', itU32, wbConditionStringToStr, wbConditionStringToInt, cpIgnore),
    {5} wbInteger('Alias', itS32, wbConditionAliasToStr, wbAliasToInt),
    {6} wbInteger('Event', itU32, wbConditionEventToStr, wbConditionEventToInt),
    {7} wbInteger('Packdata ID', itU32),
    {8} wbInteger('Quest Stage', itU32, wbConditionQuestStageToStr, wbQuestStageToInt),

    //Enums
    {9}  wbInteger('Alignment', itU32, wbAlignmentEnum),
    {10} wbInteger('Axis', itU32, wbAxisEnum),
    {11} wbInteger('Casting Type', itU32, wbCastingSourceEnum),
    {12} wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
    {13} wbInteger('Critical Stage', itU32, wbCriticalStageEnum),
    {14} wbInteger('Form Type', itU32, wbFormTypeEnum),
    {15} wbInteger('Misc Stat', itU32, wbMiscStatEnum),
    {16} wbInteger('Sex', itU32, wbSexEnum),
    {17} wbInteger('Ward State', itU32, wbWardStateEnum),

    //FormIDs
    {18} wbFormIDCkNoReach('Actor', [ACHR,PLYR,REFR,TRGT], True),
    {19} wbFormIDCkNoReach('Actor Base', [NPC_]),
    {20} wbFormIDCkNoReach('Actor Value', [AVIF]),
    {21} wbFormIDCkNoReach('Association Type', [ASTP]),
    {22} wbFormIDCkNoReach('Base Effect', [MGEF]),
    {23} wbFormIDCkNoReach('Base Object', sigBaseObjects),
    {24} wbFormIDCkNoReach('Cell', [CELL]),
    {25} wbFormIDCkNoReach('Class', [CLAS]),
    {26} wbFormIDCkNoReach('Damage Type', [DMGT,FLST]),
    {27} wbFormIDCkNoReach('Effect Item', [ALCH,ENCH,INGR,SCRL,SPEL]),
    {28} wbFormIDCkNoReach('Encounter Zone', [ECZN]),
    {29} wbFormIDCkNoReach('Equip Type', [EQUP]),
    {30} wbFormIDCkNoReach('Event Data', [FLST,KYWD,LCTN]),
    {31} wbFormIDCkNoReach('Faction', [FACT]),
    {32} wbFormIDCkNoReach('Form List', [FLST]),
    {33} wbFormIDCkNoReach('Furniture', [FLST,FURN]),
    {34} wbFormIDCkNoReach('Global', [GLOB]),
    {35} wbFormIDCkNoReach('Idle', [IDLE]),
    {36} wbFormIDCkNoReach('Keyword', [FLST,KYWD,NULL]),
    {37} wbFormIDCkNoReach('Location', [LCTN]),
    {38} wbFormIDCkNoReach('Location Ref Type', [LCRT]),
    {39} wbFormIDCkNoReach('Owner', [FACT,NPC_]),
    {40} wbFormIDCkNoReach('Package', [PACK]),
    {41} wbFormIDCkNoReach('Perk', [PERK]),
    {42} wbFormIDCkNoReach('Quest', [QUST]).AddOverlay(wbConditionQuestOverlay),
    {43} wbFormIDCkNoReach('Race', [RACE]),
    {44} wbFormIDCkNoReach('Reference', [ACHR,PARW,PBAR,PBEA,PCON,PFLA,PGRE,PHZD,PLYR,PMIS,REFR,TRGT], True),
    {45} wbFormIDCkNoReach('Region', [REGN]),
    {46} wbFormIDCkNoReach('Scene', [SCEN]),
    {47} wbFormIDCkNoReach('Voice Type', [VTYP,FLST], [VTYP]),
    {48} wbFormIDCkNoReach('Weather', [WTHR]),
    {49} wbFormIDCkNoReach('Worldspace', [WRLD,FLST], [WRLD])
  ];

  wbConditions :=
    wbRArray('Conditions',
      wbRStructSK([0,1,2], 'Condition', [
      {0} wbStructSK(CTDA, [3,5,6], '', [
          {0} wbInteger('Type', itU8, wbConditionTypeToStr, wbConditionTypeToInt).SetAfterSet(wbConditionTypeAfterSet),
          {1} wbUnused(3),
          {2} wbUnion('Comparison Value', wbConditionCompValueDecider, [
              {0} wbFloat('Comparison Value - Float'),
              {1} wbFormIDCk('Comparison Value - Global', [GLOB])
              ]),
          {3} wbInteger('Function', itU16, wbConditionFunctionToStr, wbConditionFunctionToInt),
          {4} wbUnused(2),
          {5} wbUnion('Parameter #1', wbConditionParam1Decider, wbConditionParameters),
          {6} wbUnion('Parameter #2', wbConditionParam2Decider, wbConditionParameters),
          {7} wbInteger('Run On', itU32,
                wbEnum([
                {0}  'Subject',
                {1}  'Target',
                {2}  'Reference',
                {3}  'Combat Target',
                {4}  'Linked Reference',
                {5}  'Quest Alias',
                {6}  'Package Data',
                {7}  'Event Data',
                {8}  'Command Target',
                {9}  'Event Camera Ref',
                {10} 'My Killer'
                ])).SetAfterSet(wbConditionRunOnAfterSet),
          {8} wbUnion('Reference', wbConditionReferenceDecider, [
              {0} wbInteger('Unused', itU32, nil, cpIgnore),
              {1} wbFormIDCkNoReach('Reference', sigReferences)
              ]),
          {9} wbUnion('Parameter #3', wbConditionParam3Decider, [
              {0}  wbInteger('Parameter #3', itS32).SetDefaultNativeValue(-1),
              {1}  wbInteger('Parameter #3', itS32).SetDefaultNativeValue(-1),
              {2}  wbInteger('Parameter #3', itS32).SetDefaultNativeValue(-1),
              {3}  wbInteger('Parameter #3', itS32).SetDefaultNativeValue(-1),
              {4}  wbInteger('Parameter #3', itS32).SetDefaultNativeValue(-1),
              {5}  wbInteger('Quest Alias', itS32, wbConditionAliasToStr, wbAliasToInt).SetDefaultNativeValue(-1),
              {6}  wbInteger('Parameter #3', itS32).SetDefaultNativeValue(-1),
              {7}  wbInteger('Event Data', itS32,
                     wbEnum([], [
                      -1,    'None',
                      $314F, 'Created Object', //O1
                      $3146, 'Form',           //F1
                      $3147, 'Global',         //G1
                      $3149, 'Identifier',     //I1
                      $314B, 'Keyword 1',      //K1
                      $324B, 'Keyword 2',      //K2
                      $334B, 'Keyword 3',      //K3
                      $314C, 'Location 1',     //L1
                      $324C, 'Location 2',     //L2
                      $3150, 'Player 1',       //P1
                      $3250, 'Player 2',       //P2
                      $3251, 'Quest',          //Q1
                      $3152, 'Reference 1',    //R1
                      $3252, 'Reference 2',    //R2
                      $3352, 'Reference 3',    //R3
                      $3156, 'Value 1',        //V1
                      $3256, 'Value 2',        //V2
                      $7FFFFFFF, 'All'
                      ])).SetDefaultNativeValue(-1),
              {8}  wbInteger('Parameter #3', itS32).SetDefaultNativeValue(-1),
              {9}  wbInteger('Parameter #3', itS32).SetDefaultNativeValue(-1),
              {10} wbInteger('Parameter #3', itS32).SetDefaultNativeValue(-1)
              ])
          ]),
      {1} wbString(CIS1, 'Parameter #1'),
      {2} wbString(CIS2, 'Parameter #2')
      ]).SetToStr(wbConditionToStr)
        .IncludeFlag(dfCollapsed, wbCollapseConditions)
    ).SetCountPath(CITC);

  wbICON := wbString(ICON, 'Inventory Image');
  wbMICO := wbString(MICO, 'Message Icon');
  wbPTRN := wbFormIDCk(PTRN, 'Preview Transform', [TRNS]);
  wbSTCP := wbFormIDCk(STCP, 'Animation Sound', [STAG]);
  wbNTRM := wbFormIDCk(NTRM, 'Native Terminal', [TERM]);
  wbYNAM := wbFormIDCk(YNAM, 'Sound - Pick Up', [SNDR]);
  wbZNAM := wbFormIDCk(ZNAM, 'Sound - Put Down', [SNDR]);
  wbCUSD := wbFormIDCk(CUSD, 'Sound - Crafting', [SNDR]);
  wbINRD := wbFormIDCk(INRD, 'Instance Naming', [INNR]);

  wbObjectProperty :=
    wbStructSK([0], 'Property', [
      wbActorValue,
      wbFloat('Value')
    ]).SetToStr(wbObjectPropertyToStr).IncludeFlag(dfCollapsed, wbCollapseObjectProperties);

  wbPRPS := wbArrayS(PRPS, 'Properties', wbObjectProperty);

  wbFLTR := wbString(FLTR, 'Filter');
  wbAPPR := wbArrayS(APPR, 'Attach Parent Slots', wbFormIDCk('Keyword', [KYWD]));
  wbFTYP := wbFormIDCk(FTYP, 'Forced Loc Ref Type', [LCRT]);
  wbATTX := wbLStringKC(ATTX, 'Activate Text Override', 0, cpTranslate);

  wbMNAMFurnitureMarker := wbInteger(MNAM, 'Active Markers / Flags', itU32, wbFlags([
    {0x00000001} 'Interaction Point 0',
    {0x00000002} 'Interaction Point 1',
    {0x00000004} 'Interaction Point 2',
    {0x00000008} 'Interaction Point 3',
    {0x00000010} 'Interaction Point 4',
    {0x00000020} 'Interaction Point 5',
    {0x00000040} 'Interaction Point 6',
    {0x00000080} 'Interaction Point 7',
    {0x00000100} 'Interaction Point 8',
    {0x00000200} 'Interaction Point 9',
    {0x00000400} 'Interaction Point 10',
    {0x00000800} 'Interaction Point 11',
    {0x00001000} 'Interaction Point 12',
    {0x00002000} 'Interaction Point 13',
    {0x00004000} 'Interaction Point 14',
    {0x00008000} 'Interaction Point 15',
    {0x00010000} 'Interaction Point 16',
    {0x00020000} 'Interaction Point 17',
    {0x00040000} 'Interaction Point 18',
    {0x00080000} 'Interaction Point 19',
    {0x00100000} 'Interaction Point 20',
    {0x00200000} 'Interaction Point 21',
    {0x00400000} 'Allow Awake Sound',
    {0x00800000} 'Enter With Weapon Drawn',
    {0x01000000} 'Play Anim When Full',
    {0x02000000} 'Disables Activation',
    {0x04000000} 'Is Perch',
    {0x08000000} 'Must Exit to Talk',
    {0x10000000} 'Use Static Avoid Node',
    {0x20000000} 'Unknown 29',
    {0x40000000} 'Has Model?',
    {0x80000000} 'Is Sleep Furniture'
  ])).IncludeFlag(dfCollapsed, wbCollapseFlags);

  wbSNAMMarkerParams :=
    wbArray(SNAM, 'Marker Parameters', wbStruct('Marker', [
      wbFloat('Offset X'),
      wbFloat('Offset Y'),
      wbFloat('Offset Z'),
      wbFloatAngle('Rotation Z', cpNormal, True),
      wbFormIDCk('Keyword', [KYWD, NULL]),
      wbFromVersion(125, wbInteger('Entry Types', itU8, wbFlags([
        'Front',
        'Rear',
        'Right',
        'Left',
        'Other',
        'Unused 5',
        'Unused 6',
        'Unused 7'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags)),
      wbFromVersion(125, wbByteArray('Unknown', 3))
    ], cpNormal, False, nil, 4));

  wbArmorPropertyEnum := wbEnum([
    { 0} 'Enchantments',
    { 1} 'BashImpactDataSet',
    { 2} 'BlockMaterial',
    { 3} 'Keywords',
    { 4} 'Weight',
    { 5} 'Value',
    { 6} 'Rating',
    { 7} 'AddonIndex',
    { 8} 'BodyPart',
    { 9} 'DamageTypeValue',
    {10} 'ActorValues',
    {11} 'Health',
    {12} 'ColorRemappingIndex',
    {13} 'MaterialSwaps'
  ]);

  wbActorPropertyEnum := wbEnum([
    { 0} 'Keywords',
    { 1} 'ForcedInventory',
    { 2} 'XPOffset',
    { 3} 'Enchantments',
    { 4} 'ColorRemappingIndex',
    { 5} 'MaterialSwaps'
  ]);

  wbWeaponPropertyEnum := wbEnum([
    { 0} 'Speed',
    { 1} 'Reach',
    { 2} 'MinRange',
    { 3} 'MaxRange',
    { 4} 'AttackDelaySec',
    { 5} 'Unknown 5',
    { 6} 'OutOfRangeDamageMult',
    { 7} 'SecondaryDamage',
    { 8} 'CriticalChargeBonus',
    { 9} 'HitBehaviour',
    {10} 'Rank',
    {11} 'Unknown 11',
    {12} 'AmmoCapacity',
    {13} 'Unknown 13',
    {14} 'Unknown 14',
    {15} 'Type',
    {16} 'IsPlayerOnly',
    {17} 'NPCsUseAmmo',
    {18} 'HasChargingReload',
    {19} 'IsMinorCrime',
    {20} 'IsFixedRange',
    {21} 'HasEffectOnDeath',
    {22} 'HasAlternateRumble',
    {23} 'IsNonHostile',
    {24} 'IgnoreResist',
    {25} 'IsAutomatic',
    {26} 'CantDrop',
    {27} 'IsNonPlayable',
    {28} 'AttackDamage',
    {29} 'Value',
    {30} 'Weight',
    {31} 'Keywords',
    {32} 'AimModel',
    {33} 'AimModelMinConeDegrees',
    {34} 'AimModelMaxConeDegrees',
    {35} 'AimModelConeIncreasePerShot',
    {36} 'AimModelConeDecreasePerSec',
    {37} 'AimModelConeDecreaseDelayMs',
    {38} 'AimModelConeSneakMultiplier',
    {39} 'AimModelRecoilDiminishSpringForce',
    {40} 'AimModelRecoilDiminishSightsMult',
    {41} 'AimModelRecoilMaxDegPerShot',
    {42} 'AimModelRecoilMinDegPerShot',
    {43} 'AimModelRecoilHipMult',
    {44} 'AimModelRecoilShotsForRunaway',
    {45} 'AimModelRecoilArcDeg',
    {46} 'AimModelRecoilArcRotateDeg',
    {47} 'AimModelConeIronSightsMultiplier',
    {48} 'HasScope',
    {49} 'ZoomDataFOVMult',
    {50} 'FireSeconds',
    {51} 'NumProjectiles',
    {52} 'AttackSound',
    {53} 'AttackSound2D',
    {54} 'AttackLoop',
    {55} 'AttackFailSound',
    {56} 'IdleSound',
    {57} 'EquipSound',
    {58} 'UnEquipSound',
    {59} 'SoundLevel',
    {50} 'ImpactDataSet',
    {61} 'Ammo',
    {62} 'CritEffect',
    {63} 'BashImpactDataSet',
    {64} 'BlockMaterial',
    {65} 'Enchantments',
    {66} 'AimModelBaseStability',
    {67} 'ZoomData',
    {68} 'ZoomDataOverlay',
    {69} 'ZoomDataImageSpace',
    {70} 'ZoomDataCameraOffsetX',
    {71} 'ZoomDataCameraOffsetY',
    {72} 'ZoomDataCameraOffsetZ',
    {73} 'EquipSlot',
    {74} 'SoundLevelMult',
    {75} 'NPCAmmoList',
    {76} 'ReloadSpeed',
    {77} 'DamageTypeValues',
    {78} 'AccuracyBonus',
    {79} 'AttackActionPointCost',
    {80} 'OverrideProjectile',
    {81} 'HasBoltAction',
    {82} 'StaggerValue',
    {83} 'SightedTransitionSeconds',
    {84} 'FullPowerSeconds',
    {85} 'HoldInputToPower',
    {86} 'HasRepeatableSingleFire',
    {87} 'MinPowerPerShot',
    {88} 'ColorRemappingIndex',
    {89} 'MaterialSwaps',
    {90} 'CriticalDamageMult',
    {91} 'FastEquipSound',
    {92} 'DisableShells',
    {93} 'HasChargingAttack',
    {94} 'ActorValues'
  ]);

  wbObjectModProperties :=
    wbArrayS('Properties', wbStructSK([4], 'Property', [
      wbInteger('Value Type', itU8, wbEnum([
        {0} 'Int',
        {1} 'Float',
        {2} 'Bool',
        {3} 'String',
        {4} 'FormID,Int',
        {5} 'Enum',
        {6} 'FormID,Float'
      ])),
      wbUnused(3),
      wbUnion('Function Type', wbOMODDataFunctionTypeDecider, [
        { Float }  wbInteger('Function Type', itU8, wbEnum(['SET', 'MUL+ADD', 'ADD'])),
        { Bool }   wbInteger('Function Type', itU8, wbEnum(['SET', 'AND', 'OR'])),
        { Enum }   wbInteger('Function Type', itU8, wbEnum(['SET'])),
        { FormID } wbInteger('Function Type', itU8, wbEnum(['SET', 'REM', 'ADD']))
      ]),
      wbUnused(3),
      wbInteger('Property', itU16, wbObjectModPropertyToStr, wbObjectModPropertyToInt),
      wbUnused(2),
      wbUnion('Value 1', wbOMODDataPropertyValue1Decider, [
        { 0} wbByteArray('Value 1 - Unknown', 4),
        { 1} wbInteger('Value 1 - Int', itU32),
        { 2} wbFloat('Value 1 - Float'),
        { 3} wbInteger('Value 1 - Bool', itU32, wbBoolEnum),
        { 4} wbFormID('Value 1 - FormID'),
        { 5} wbInteger('Value 1 - Enum', itU32),
        { 6} wbInteger('Sound Level', itU32, wbSoundLevelEnum),
        { 7} wbInteger('Stagger Value', itU32, wbStaggerEnum),
        { 8} wbInteger('Hit Behaviour', itU32, wbHitBehaviourEnum)
      ]),
      wbUnion('Value 2', wbOMODDataPropertyValue2Decider, [
        wbUnused(4),
        wbInteger('Value 2 - Int', itU32),
        wbFloat('Value 2 - Float'),
        wbInteger('Value 2 - Bool', itU32, wbBoolEnum)
      ]),
      wbFloat('Step')
    ]), wbOMODDataPropertyCounter, cpNormal, False, nil, wbOMODpropertyAfterSet);

  wbOBTSReq := wbStruct(OBTS, 'Object Mod Template Item', [
    wbInteger('Include Count', itU32),  // fixed name for wbOMOD* handlers
    wbInteger('Property Count', itU32), // fixed name for wbOMOD* handlers
    wbInteger('Level Min', itU8),
    wbUnused(1),
    wbInteger('Level Max', itU8),
    wbUnused(1),
    wbInteger('Parent Combination Index', itS16{, wbOBTEAddonIndexToStr, nil, cpNormal, True, nil, nil, -1}),
    wbInteger('Default', itU8, wbBoolEnum),
    wbArray('Keywords', wbFormIDCk('Keyword', [KYWD, NULL]), -4).IncludeFlag(dfCollapsed, wbCollapseKeywords),
    wbInteger('Min Level For Ranks', itU8),
    wbInteger('Alt Levels Per Tier', itU8),
    wbArray('Includes', wbStruct('Include', [
      wbFormIDCk('Mod', [OMOD]),
      wbInteger('Attach Point Index', itU8),
      wbInteger('Optional', itU8, wbBoolEnum),
      wbInteger('Don''t Use All', itU8, wbBoolEnum)
    ]), wbOMODDataIncludeCounter, cpNormal, False, nil, wbOMODincludeAfterSet),
    wbObjectModProperties
  ], cpNormal, True);

  wbObjectTemplate := wbRStruct('Object Template', [
    wbInteger(OBTE, 'Count', itU32, nil, cpBenign),
    wbRArray('Combinations',
      wbRStruct('Combination', [
        wbEmpty(OBTF, 'Editor Only'),
        wbFULL,
        wbOBTSReq
      ], [], cpNormal, False, nil, True),
      cpNormal, False, nil, wbOBTSCombinationsAfterSet),
    wbEmpty(STOP, 'Marker', cpNormal, True)
  ]);

  // Sorting these where applicable, as I cannot reproduce any issues that arise from doing so
  var wbBoneDataItem :=
      wbRStruct('Bone Data Set', [
        wbRStruct('Bone Weight Scale Data', [
          wbInteger(BSMP, 'Weight Scale Target Gender', itU32, wbSexEnum),
          wbRArrayS('Bone Weight Scales',
            wbRStructSK([0], 'Bone Weight Scale Set', [
              wbString(BSMB, 'Name'),
              wbStruct(BSMS, 'Scale Set', [
                wbVec3('Thin'),
                wbVec3('Muscular'),
                wbVec3('Fat')
              ])
              .SetSummaryKeyOnValue([0,1,2])
              .SetSummaryPrefixSuffixOnValue(0, 'Thin: ', '')
              .SetSummaryPrefixSuffixOnValue(1, 'Muscular: ', '')
              .SetSummaryPrefixSuffixOnValue(2, 'Fat: ', '')
              .SetSummaryDelimiterOnValue(', ')
              .SetRequired
            ])
            .SetSummaryKey([1])
            .IncludeFlag(dfCollapsed, wbCollapseRACEBoneData)
          )
        ]),
        wbRStruct('Bone Range Modifier Data', [
          wbInteger(BMMP, 'Range Modifier Target Gender', itU32, wbSexEnum),
          wbRArrayS('Bone Range Modifiers',
            wbRStructSK([0], 'Bone Range Modifier', [
              wbString(BSMB, 'Name'),
              wbStruct(BSMS, 'Range', [
                wbFloat('Min Y'),
                wbFloat('Min Z'),
                wbFloat('Max Y'),
                wbFloat('Max Z')
              ])
              .SetSummaryKeyOnValue([0,2,1,3])
              .SetSummaryPrefixSuffixOnValue(0, 'Y: [', '')
              .SetSummaryPrefixSuffixOnValue(2, 'to ', '],')
              .SetSummaryPrefixSuffixOnValue(1, 'Z: [', '')
              .SetSummaryPrefixSuffixOnValue(3, 'to ', ']')
              .IncludeFlag(dfCollapsed, wbCollapseRange)
              .SetRequired
            ])
            .SetSummaryKey([1])
            .IncludeFlag(dfCollapsed, wbCollapseRACEBoneData)
          )
        ])
      ]);

  var wbArmorAddonBoneDataItem :=
      wbRStruct('Bone Scale Modifier Set', [
        wbInteger(BSMP, 'Target Gender', itU32, wbSexEnum),
        wbRArrayS('Bone Scale Modifiers',
          wbRStructSK([0], 'Bone Scale Modifier', [
            wbString(BSMB, 'Bone Name'),
            wbVec3(BSMS, 'Bone Scale Delta')
              .SetRequired
          ])
          .SetSummaryKey([1])
          .IncludeFlag(dfCollapsed, wbCollapseARMABoneData)
        )
      ]);

  wbBSMPSequence := wbRArray('Bone Scale Data', wbBoneDataItem);

  wbArmorAddonBSMPSequence := wbRArray('Sculpt Data', wbArmorAddonBoneDataItem);

  var wbEffect :=
    wbRStruct('Effect', [
      wbEFID,
      wbEFIT,
      wbConditions
    ], [], cpNormal, True)
    .SetSummaryKey([0,2])
    .IncludeFlag(dfSummaryMembersNoName);

  wbEffectsReq :=
    wbRArrayS('Effects', wbEffect, cpNormal, True);

  wbRecord(ACTI, 'Activator',
    wbFlags(wbFlagsList([
      2, 'Never Fades',
      4, 'Non Occluder',
      6, 'Unknown 6',
      7, 'Heading Marker',
      8, 'Must Update Anims',
      9, 'Hidden From Local Map',
     10, 'Headtrack Marker',
     11, 'Used as Platform',
     13, 'Pack-In Use Only',
     15, 'Has Distant LOD',
     16, 'Random Anim Start',
     17, 'Dangerous',
     20, 'Ignore Object Interaction',
     23, 'Is Marker',
     25, 'Obstacle',
     26, 'Navmesh - Filter',
     27, 'Navmesh - Bounding Box',
     29, 'Child Can Use',
     30, 'Navmesh - Ground'
    ])).SetFlagHasDontShow(26, wbFlagNavmeshFilterDontShow)
       .SetFlagHasDontShow(27, wbFlagNavmeshBoundingBoxDontShow)
       .SetFlagHasDontShow(30, wbFlagNavmeshGroundDontShow), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbSTCP,
    wbFULL,
    wbGenericModel,
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbNTRM,
    wbFTYP,
    wbByteColors(PNAM, 'Marker Color'),
    wbFormIDCk(SNAM, 'Sound - Looping', [SNDR]),
    wbFormIDCk(VNAM, 'Sound - Activation', [SNDR]),
    wbFormIDCk(WNAM, 'Water Type', [WATR]),
    wbATTX,
    wbInteger(FNAM, 'Flags', itU16, wbFlags([
      'No Displacement',
      'Ignored by Sandbox',
      'Unknown 2',
      'Unknown 3',
      'Is a Radio'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbFormIDCk(KNAM, 'Interaction Keyword', [KYWD]),
    wbStruct(RADR, 'Radio Receiver', [
      wbFormIDCk('Sound Model', [SOPM, NULL]),
      wbFloat('Frequency'),
      wbFloat('Volume').SetDefaultEditValue('1.0'),
      wbInteger('Starts Active', itU8, wbBoolEnum),
      wbInteger('No Signal Static', itU8, wbBoolEnum)
    ], cpNormal, False, nil, 4),
    wbCITC,
    wbConditions,
    wbNVNM
  ]);

  wbRecord(TACT, 'Talking Activator',
    wbFlags(wbFlagsList([
      9, 'Hidden From Local Map',
     16, 'Random Anim Start',
     17, 'Radio Station'
    ]), [17]), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbFULL,
    wbGenericModel,
    wbDEST,
    wbKeywords,
    wbUnknown(PNAM, cpIgnore, True),
    wbFormIDCk(SNAM, 'Looping Sound', [SNDR]),
    wbUnknown(FNAM, cpIgnore, True),
    wbFormIDCk(VNAM, 'Voice Type', [VTYP])
  ]);

  wbRecord(ALCH, 'Ingestible',
    wbFlags(wbFlagsList([
      29, 'Medicine'
    ])), [
    wbEDID,
    wbOBND(True),
    wbPTRN,
    wbFULL,
    wbKeywords,
    wbGenericModel,
    wbICON,
    wbMICO,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbETYP,
    wbCUSD,
    wbDESC,
    wbFloat(DATA, 'Weight', cpNormal, True),
    wbStruct(ENIT, 'Effect Data', [
      wbInteger('Value', itS32),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'No Auto-Calc',
        {0x00000002} 'Food Item',
        {0x00000004} 'Unknown 3',
        {0x00000008} 'Unknown 4',
        {0x00000010} 'Unknown 5',
        {0x00000020} 'Unknown 6',
        {0x00000040} 'Unknown 7',
        {0x00000080} 'Unknown 8',
        {0x00000100} 'Unknown 9',
        {0x00000200} 'Unknown 10',
        {0x00000400} 'Unknown 11',
        {0x00000800} 'Unknown 12',
        {0x00001000} 'Unknown 13',
        {0x00002000} 'Unknown 14',
        {0x00004000} 'Unknown 15',
        {0x00008000} 'Unknown 16',
        {0x00010000} 'Medicine',
        {0x00020000} 'Poison'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFormID('Addiction'),
      wbFloat('Addiction Chance'),
      wbFormIDCk('Sound - Consume', [SNDR, NULL])
    ], cpNormal, True),
    wbLStringKC(DNAM, 'Addiction Name', 0, cpTranslate),
    wbEffectsReq
  ]);

  wbRecord(AMMO, 'Ammunition',
    wbFlags(wbFlagsList([
      2, 'Non-Playable'
    ])), [
    wbEDID,
    wbOBND(True),
    wbPTRN,
    wbFULL,
    wbGenericModel,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbDESC,
    wbKeywords,
    wbStruct(DATA, 'Data', [
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True, nil, 1),
    wbStruct(DNAM, '', [
      wbFormIDCk('Projectile', [PROJ, NULL]),
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'Ignores Normal Weapon Resistance',
        {0x02} 'Non-Playable',
        {0x04} 'Has Count Based 3D'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbUnused(3),
      wbFloat('Damage'),
      wbInteger('Health', itU32)
    ], cpNormal, True),
    wbLStringKC(ONAM, 'Short Name', 0, cpTranslate),
    wbString(NAM1, 'Casing Model'),
    wbModelInfo(NAM2)
  ]);

  wbRecord(ANIO, 'Animated Object',
    wbFlags(wbFlagsList([
      9, 'Unknown 9'
    ]), [9]), [
    wbEDID,
    wbGenericModel,
    wbString(BNAM, 'Unload Event')
  ]);

  wbRecord(ARMO, 'Armor',
    wbFlags(wbFlagsList([
      2, 'Non-Playable',
      6, 'Shield',
     10, 'Unknown 10',
     15, 'Unknown 15'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbFULL,
    wbEnchantment,
    wbRStruct('Male', [
      wbTexturedModel('World Model', [MOD2, MO2T], [wbMODC, wbMO2S, nil]),
      wbString(ICON, 'Icon Image'),
      wbString(MICO, 'Message Icon')
    ]).IncludeFlag(dfAllowAnyMember)
      .IncludeFlag(dfStructFirstNotRequired),
    wbRStruct('Female', [
      wbTexturedModel('World Model', [MOD4, MO4T], [wbMODC, wbMO4S, nil]),
      wbString(ICO2, 'Icon Image'),
      wbString(MIC2, 'Message Icon')
    ]).IncludeFlag(dfAllowAnyMember)
      .IncludeFlag(dfStructFirstNotRequired),
    wbBOD2,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbETYP,
    wbFormIDCk(BIDS, 'Block Bash Impact Data Set', [IPDS, NULL]),
    wbFormIDCk(BAMT, 'Alternate Block Material', [MATT, NULL]),
    wbFormIDCk(RNAM, 'Race', [RACE]),
    wbKeywords,
    wbDESC,
    wbINRD,
    wbRArray('Models',
      wbRStruct('Model', [
        wbInteger(INDX, 'Addon Index', itU16),
        wbFormIDCk(MODL, 'Armor Addon', [ARMA])
      ])
    ),
    wbStruct(DATA, '', [
      wbInteger('Value', itS32),
      wbFloat('Weight'),
      wbInteger('Health', itU32)
    ], cpNormal, True),
    wbStruct(FNAM, '', [
      wbInteger('Armor Rating', itU16),
      wbInteger('Base Addon Index', itU16),
      wbInteger('Stagger Rating', itU8, wbStaggerEnum),
      wbUnused(3)
    ]),
    wbDamageTypeArray('Resistance'),
    wbFormIDCk(TNAM, 'Template Armor', [ARMO]),
    wbAPPR,
    wbObjectTemplate
  ], False, nil, cpNormal, False, wbARMOAfterLoad);

  wbRecord(ARMA, 'Armor Addon',
    wbFlags(wbFlagsList([
      6, 'No Underarmor Scaling',
      9, 'Has Sculpt Data',
     30, 'Hi-Res 1st Person Only'
    ])), [
    wbEDID,
    wbBOD2,
    wbFormIDCk(RNAM, 'Race', [RACE]),
    wbStruct(DNAM, 'Data', [
      wbInteger('Male Priority', itU8),
      wbInteger('Female Priority', itU8),
      // essentialy a number of world models for different weights (Enabled = 2 models _0.nif and _1.nif)
      wbInteger('Weight slider - Male', itU8, wbFlags([
        {0x01} 'Unknown 0',
        {0x02} 'Enabled'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Weight slider - Female', itU8, wbFlags([
        {0x01} 'Unknown 0',
        {0x02} 'Enabled'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbByteArray('Unknown', 2),
      wbInteger('Detection Sound Value', itU8),
      wbByteArray('Unknown', 1),
      wbFloat('Weapon Adjust')
    ], cpNormal, True),
    wbRStruct('Biped Model', [
      wbTexturedModel('Male', [MOD2, MO2T], [wbMO2C, wbMO2S, wbMO2F]),
      wbTexturedModel('Female', [MOD3, MO3T], [wbMO3C, wbMO3S, wbMO3F])
    ]).IncludeFlag(dfAllowAnyMember)
      .IncludeFlag(dfStructFirstNotRequired),
    wbRStruct('1st Person', [
      wbTexturedModel('Male', [MOD4, MO4T], [wbMO4C, wbMO4S, wbMO4F]),
      wbTexturedModel('Female', [MOD5, MO5T], [wbMO5C, wbMO5S, wbMO5F])
    ]).IncludeFlag(dfAllowAnyMember)
      .IncludeFlag(dfStructFirstNotRequired),
    wbFormIDCK(NAM0, 'Male Skin Texture', [TXST, NULL]),
    wbFormIDCK(NAM1, 'Female Skin Texture', [TXST, NULL]),
    wbFormIDCK(NAM2, 'Male Skin Texture Swap List', [FLST, NULL]),
    wbFormIDCK(NAM3, 'Female Skin Texture Swap List', [FLST, NULL]),
    wbRArrayS('Additional Races', wbFormIDCK(MODL, 'Race', [RACE, NULL])),
    wbFormIDCk(SNDD, 'Footstep Sound', [FSTS, NULL]),
    wbFormIDCk(ONAM, 'Art Object', [ARTO]),
    wbArmorAddonBSMPSequence
  ], False, nil, cpNormal, False, wbARMAAfterLoad);

  wbRecord(BOOK, 'Book', [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbFULL,
    wbGenericModel,
    wbICON,
    wbMICO,
    wbDESCreq,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbKeywords,
    wbFormIDCk(FIMD, 'Featured Item Message', [MESG]),
    wbStruct(DATA, 'Data', [
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbStruct(DNAM, '', [
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'Advance Actor Value',
        {0x02} 'Can''t be Taken',
        {0x04} 'Add Spell',
        {0x08} 'Unknown 3',
        {0x10} 'Add Perk'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbUnion('Teaches', wbBOOKTeachesDecider, [
        wbUnused(4),
        wbFormIDCk('Actor Value', [AVIF, NULL]),
        wbFormIDCk('Spell', [SPEL, NULL]),
        wbFormIDCk('Perk', [PERK, NULL])
      ]),
      wbStruct('Text Offset' , [
        wbInteger('X', itU32),
        wbInteger('Y', itU32)
      ])
    ], cpNormal, True),
    wbLStringKC(CNAM, 'Description', 0, cpTranslate),
    wbFormIDCk(INAM, 'Inventory Art', [STAT])
  ]);

{>>>
  Skrim has its own ref record for every projectile type
  PARW 'Arrow'
  PBEA 'Beam'
  PFLA 'Flame'
  PCON 'Cone' (voice)
  PBAR 'Barrier'
  PGRE 'Traps'
  PHZD 'Hazards'
  I guess all of them have the same structure
<<<}
  ReferenceRecord(PARW, 'Placed Arrow');
  ReferenceRecord(PBAR, 'Placed Barrier');
  ReferenceRecord(PBEA, 'Placed Beam');
  ReferenceRecord(PCON, 'Placed Cone/Voice');
  ReferenceRecord(PFLA, 'Placed Flame');
  ReferenceRecord(PGRE, 'Placed Projectile');
  ReferenceRecord(PHZD, 'Placed Hazard');
  ReferenceRecord(PMIS, 'Placed Missile');

  wbRecord(CELL, 'Cell',
    wbFlags(wbFlagsList([
      7, 'No Pre Vis',
     10, 'Persistent',
     14, 'Partial Form',
     17, 'Off Limits',
     18, 'Compressed',
     19, 'Can''t Wait'
    ]), [14, 18])
      .SetFlagHasDontShow(14, wbFlagPartialFormDontShow),
  [
    wbEDID,
    wbFULL,
    wbInteger(DATA, 'Flags', itU16, wbFlags([
      {0x0001} 'Is Interior Cell',
      {0x0002} 'Has Water',
      {0x0004} 'Can Travel From Here',
      {0x0008} 'No LOD Water',
      {0x0010} 'Unknown 5',
      {0x0020} 'Public Area',
      {0x0040} 'Hand Changed',
      {0x0080} 'Show Sky',
      {0x0100} 'Use Sky Lighting',
      {0x0200} 'Unknown 10',
      {0x0400} 'Hidden from Interior Cell List',
      {0x0800} 'Sunlight Shadows',
      {0x1000} 'Distant LOD only',
      {0x2000} 'Player Followers Can''t Travel Here',
      {0x4000} 'Unknown 15',
      {0x8000} 'Unknown 16'
    ]), cpNormal, True, False, nil, wbCELLDATAAfterSet).IncludeFlag(dfCollapsed, wbCollapseFlags),

    wbByteArray(VISI, 'PreVis Files Timestamp', 2).SetToStr(wbTimeStampToString),
    wbFormIDCk(RVIS, 'In PreVis File Of', [CELL]),
    wbByteArray(PCMB, 'PreCombined Files Timestamp', 2).SetToStr(wbTimeStampToString),

    wbCellGrid,

    wbStruct(XCLL, 'Lighting', [
      wbByteColors('Ambient Color'),
      wbByteColors('Directional Color'),
      wbByteColors('Fog Color Near'),
      wbFloat('Fog Near'),
      wbFloat('Fog Far'),
      wbInteger('Directional Rotation XY', itS32),
      wbInteger('Directional Rotation Z', itS32),
      wbFloat('Directional Fade').SetDefaultEditValue('1.0'),
      wbFloat('Fog Clip Distance'),
      wbFloat('Fog Power').SetDefaultEditValue('1.0'),
      wbAmbientColors('Ambient Colors'),
      wbByteColors('Fog Color Far'),
      wbFloat('Fog Max').SetDefaultEditValue('1.0'),
      wbFloat('Light Fade Begin'),
      wbFloat('Light Fade End'),
      wbInteger('Inherits', itU32, wbFlags([
        {0x00000001} 'Ambient Color',
        {0x00000002} 'Directional Color',
        {0x00000004} 'Fog Color',
        {0x00000008} 'Fog Near',
        {0x00000010} 'Fog Far',
        {0x00000020} 'Directional Rotation',
        {0x00000040} 'Directional Fade',
        {0x00000080} 'Clip Distance',
        {0x00000100} 'Fog Power',
        {0x00000200} 'Fog Max',
        {0x00000400} 'Light Fade Distances'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFloat('Near Height Mid'),
      wbFloat('Near Height Range').SetDefaultEditValue('10000.0'),
      wbByteColors('Fog Color High Near'),
      wbByteColors('Fog Color High Far'),
      wbFloat('High Density Scale').SetDefaultEditValue('1.0'),
      wbFloat('Fog Near Scale').SetDefaultEditValue('1.0'),
      wbFloat('Fog Far Scale').SetDefaultEditValue('1.0'),
      wbFloat('Fog High Near Scale').SetDefaultEditValue('1.0'),
      wbFloat('Fog High Far Scale').SetDefaultEditValue('1.0'),
      wbFloat('Far Height Mid'),
      wbFloat('Far Height Range')
    ], cpNormal, False, nil, 11)
      .SetDontShow(wbCellExteriorDontShow)
      .SetIsRemovable(wbCellLightingIsRemovable),

    wbInteger(CNAM, 'Precombined Object Level XY', itU8),
    wbInteger(ZNAM, 'Precombined Object Level Z', itU8),
    wbByteArray(TVDT, 'Unknown', 0, cpNormal),
    wbMHDTCELL,
    wbFormIDCk(LTMP, 'Lighting Template', [LGTM, NULL], False, cpNormal, True),

    {>>> XCLW sometimes has $FF7FFFFF and causes invalid floation point <<<}
    wbFloat(XCLW, 'Water Height', cpNormal, False, 1, -1, nil, nil, 0, wbCELLXCLWGetConflictPriority),
    wbArrayS(XCLR, 'Regions', wbFormIDCk('Region', [REGN])),
    wbFormIDCk(XLCN, 'Location', [LCTN]),
    wbRStruct('Water Current Velocities', [
      wbInteger(XWCN, 'Velocity Count', itU32, nil, cpBenign),
      wbArray(XWCU, 'Velocities',
        wbStruct('Current', [
          wbVec3('Velocity'),
          wbFloat
        ])
      ).SetCountPathOnValue(XWCN, False)
       .SetRequired
       .IncludeFlag(dfCollapsed, wbCollapseOther)
       .IncludeFlag(dfNotAlignable)
    ]),
    wbFormIDCk(XCWT, 'Water', [WATR]),

    {--- Ownership ---}
    wbOwnership,

    wbFormIDCk(XILL, 'Lock List', [FLST, NPC_]),

    wbStruct(XILW, 'Exterior LOD', [
      wbFormIDCk('Worldspace', [WRLD]),
      wbFloat('Offset X'),
      wbFloat('Offset Y'),
      wbFloat('Offset Z')
    ]),
    wbString(XWEM, 'Water Environment Map'),
    wbFormIDCk(XCCM, 'Sky/Weather from Region', [REGN]),
    wbFormIDCk(XCAS, 'Acoustic Space', [ASPC]),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
    wbFormIDCk(XCMO, 'Music Type', [MUSC]),
    wbFormIDCk(XCIM, 'Image Space', [IMGS]),
    wbFormIDCk(XGDR, 'God Rays', [GDRY]),

    // those can be sorted I think, but makes copying records very slow since some cells have over 22000+ entries
    // DLC01Lair01 "The Mechanist's Lair" [CELL:010008A3]
    wbArrayS(XPRI, 'PreVis Reference Index', wbFormIDCk('Reference', [REFR, PGRE, PHZD, PMIS, PARW, PBAR, PBEA, PCON, PFLA])),
    wbStruct(XCRI, 'Combined Reference Index', [
      wbInteger('Meshes Count', itU32),
      wbInteger('References Count', itU32),
      wbArrayS('Meshes', wbInteger('Combined Mesh', itU32, wbCombinedMeshIDToStr, wbCombinedMeshIDToInt), wbCELLCombinedMeshesCounter, cpNormal, False, nil, wbCELLCombinedMeshesAfterSet),
      wbArrayS('References',  wbStructSK([0], 'Reference', [
        wbFormIDCk('Reference', [REFR, PGRE, PHZD, PMIS, PARW, PBAR, PBEA, PCON, PFLA]),
        wbInteger('Combined Mesh', itU32, wbCombinedMeshIDToStr, wbCombinedMeshIDToInt)
      ]), wbCELLCombinedRefsCounter, cpNormal, False, nil, wbCELLCombinedRefsAfterSet)
    ])
  ], True).SetAddInfo(wbCellAddInfo);

  wbRecord(CLAS, 'Class', [
    wbEDID,
    wbFULLReq,
    wbDESCReq,
    wbICON,
    wbPRPS,
    wbStruct(DATA, 'Data', [
      wbUnknown(4),
      wbFloat('Bleedout Default')
        .SetDefaultEditValue('0.15')
    ]).SetRequired
  ]);

  wbRecord(CLMT, 'Climate', [
    wbEDID,
    wbArrayS(WLST, 'Weather Types', wbStructSK([0], 'Weather Type', [
      wbFormIDCk('Weather', [WTHR, NULL]),
      wbInteger('Chance', itS32),
      wbFormIDCk('Global', [GLOB, NULL])
    ])),
    wbString(FNAM, 'Sun Texture'),
    wbString(GNAM, 'Sun Glare Texture'),
    wbGenericModel,
    wbClimateTiming(wbClmtTime, wbClmtMoonsPhaseLength)
  ]);

  wbRecord(SPGD, 'Shader Particle Geometry', [
    wbEDID,
    wbStruct(DATA, 'Data', [
      wbFloat('Gravity Velocity'),
      wbUnused(4),
      wbFloat('Rotation Velocity'),
      wbUnused(4),
      wbFloat('Particle Size X'),
      wbUnused(4),
      wbFloat('Particle Size Y'),
      wbUnused(4),
      wbFloat('Center Offset Min'),
      wbUnused(4),
      wbFloat('Center Offset Max'),
      wbUnused(4),
      wbFloat('Initial Rotation'),
      wbUnused(4),
      wbInteger('# of Subtextures X', itU32),
      wbUnused(4),
      wbInteger('# of Subtextures Y', itU32),
      wbUnused(4),
      wbInteger('Type', itU32, wbEnum([
        'Rain',
        'Snow'
      ])),
      wbUnused(4),
      wbInteger('Box Size', itU32).SetDefaultEditValue('4096'),
      wbUnused(4),
      wbFloat('Particle Density'),
      wbUnused(4)
    ], cpNormal, True, nil, 10),
    wbString(MNAM, 'Particle Texture')
  ]);

  wbRecord(RFCT, 'Visual Effect', [
    wbEDID,
    wbStruct(DATA, 'Effect Data', [
      wbFormIDCK('Effect Art', [ARTO, NULL]),
      wbFormIDCK('Shader', [EFSH, NULL]),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Rotate to Face Target',
        {0x00000002} 'Attach to Camera',
        {0x00000004} 'Inherit Rotation'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ], cpNormal, True)
  ]);

  wbRecord(CONT, 'Container',
    wbFlags(wbFlagsList([
      15, 'Has Distant LOD',
      16, 'Random Anim Start',
      25, 'Obstacle',
      26, 'Navmesh - Filter',
      27, 'Navmesh - Bounding Box',
      30, 'Navmesh - Ground'
    ])).SetFlagHasDontShow(26, wbFlagNavmeshFilterDontShow)
       .SetFlagHasDontShow(27, wbFlagNavmeshBoundingBoxDontShow)
       .SetFlagHasDontShow(30, wbFlagNavmeshGroundDontShow), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbFULL,
    wbGenericModel,
    wbCOCT,
    wbCNTOs,
    wbDEST,
    wbStruct(DATA, '', [
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'Allow Sounds When Animation',
        {0x02} 'Respawns',
        {0x04} 'Show Owner'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFloat('Weight')
    ], cpNormal, True),
    wbKeywords,
    wbFTYP,
    wbPRPS,
    wbNTRM,
    wbFormIDCk(SNAM, 'Sound - Open', [SNDR]),
    wbFormIDCk(QNAM, 'Sound - Close', [SNDR]),
    wbFormIDCk(TNAM, 'Sound - Take All', [SNDR]),
    wbFormIDCk(ONAM, 'Filter List', [FLST])
  ], True, nil, cpNormal, False, nil, wbContainerAfterSet);

  wbAIDT :=
    wbStruct(AIDT, 'AI Data', [
     {00} wbInteger('Aggression', itU8, wbAggressionEnum),
     {01} wbInteger('Confidence', itU8, wbConfidenceEnum),
     {02} wbInteger('Energy Level', itU8),
     {03} wbInteger('Morality', itU8, wbMoralityEnum),
     {04} wbInteger('Mood', itU8, wbMoodEnum),
          wbInteger('Assistance', itU8, wbAssistanceEnum),
          wbStruct('Aggro', [
            wbInteger('Aggro Radius Behavior', itU8, wbBoolEnum),
            wbInteger('Unknown', itU8),
            wbInteger('Warn', itU32),
            wbInteger('Warn/Attack', itU32),
            wbInteger('Attack', itU32)
          ]),
          wbFromVersion(29, wbInteger('No Slow Approach', itU8, wbBoolEnum)),
          wbFromVersion(29, wbByteArray('Unknown', 3))
    ]).SetRequired;

  wbRecord(CSTY, 'Combat Style',
    wbFlags(wbFlagsList([
      19, 'Allow Dual Wielding'
    ])), [
    wbEDID,
    wbStruct(CSGD, 'General', [
      wbFloat('Offensive Mult').SetDefaultEditValue('0.5'),
      wbFloat('Defensive Mult').SetDefaultEditValue('0.5'),
      wbFloat('Group Offensive Mult').SetDefaultEditValue('1.0'),
      wbFloat('Equipment Score Mult - Melee').SetDefaultEditValue('1.0'),
      wbFloat('Equipment Score Mult - Magic').SetDefaultEditValue('1.0'),
      wbFloat('Equipment Score Mult - Ranged').SetDefaultEditValue('1.0'),
      wbFloat('Equipment Score Mult - Shout').SetDefaultEditValue('1.0'),
      wbFloat('Equipment Score Mult - Unarmed').SetDefaultEditValue('1.0'),
      wbFloat('Equipment Score Mult - Staff').SetDefaultEditValue('1.0'),
      wbFloat('Avoid Threat Chance').SetDefaultEditValue('0.8'),
      wbFloat('Dodge Threat Chance').SetDefaultEditValue('0.2'),
      wbFloat('Evade Threat Chance').SetDefaultEditValue('0.2')
    ], cpNormal, True),
    wbUnknown(CSMD, cpIgnore),
    wbStruct(CSME, 'Melee', [
      wbFloat('Attack Staggered Mult').SetDefaultEditValue('1.0'),
      wbFloat('Power Attack Staggered Mult').SetDefaultEditValue('1.0'),
      wbFloat('Power Attack Blocking Mult').SetDefaultEditValue('1.0'),
      wbFloat('Bash Mult').SetDefaultEditValue('1.0'),
      wbFloat('Bash Recoil Mult').SetDefaultEditValue('1.0'),
      wbFloat('Bash Attack Mult').SetDefaultEditValue('1.0'),
      wbFloat('Bash Power Attack Mult').SetDefaultEditValue('1.0'),
      wbFloat('Special Attack Mult').SetDefaultEditValue('0.1'),
      wbFloat('Block When Staggered Mult').SetDefaultEditValue('1.0'),
      wbFloat('Attack When Staggered Mult').SetDefaultEditValue('1.0')
    ], cpNormal, True, nil, 9),
    wbFloat(CSRA, 'Ranged Accuracy Mult', cpNormal, True).SetDefaultEditValue('0.75'),
    wbStruct(CSCR, 'Close Range', [
      wbFloat('Dueling - Circle Mult').SetDefaultEditValue('0.2'),
      wbFloat('Dueling - Fallback Mult').SetDefaultEditValue('0.2'),
      wbFloat('Flanking - Flank Distance').SetDefaultEditValue('0.2'),
      wbFloat('Flanking - Stalk Time').SetDefaultEditValue('0.2'),
      wbFloat('Charging - Charge Distance'),
      wbFloat('Charging - Throw Probability'),
      wbFloat('Charging - Sprint Fast Probability'),
      wbFloat('Charging - Sideswipe Probability'),
      wbFloat('Charging - Disengane Probability'),
      wbInteger('Charging - Throw Max Targets', itU32),
      wbFloat('Flanking - Flank Variance').SetDefaultEditValue('0.5')
    ], cpNormal, True),
    wbStruct(CSLR, 'Long Range', [
      wbFloat('Strafe Mult').SetDefaultEditValue('0.5'),
      wbFloat('Adjust Range Mult').SetDefaultEditValue('0.5'),
      wbFloat('Crouch Mult').SetDefaultEditValue('0.5'),
      wbFloat('Wait Mult').SetDefaultEditValue('0.5'),
      wbFloat('Range Mult').SetDefaultEditValue('0.5')
    ], cpNormal, True, nil, 3),
    wbFloat(CSCV, 'Cover Search Distance Mult', cpNormal, True).SetDefaultEditValue('0.5'),
    wbStruct(CSFL, 'Flight', [
      wbFloat('Hover Chance').SetDefaultEditValue('0.5'),
      wbFloat('Dive Bomb Chance').SetDefaultEditValue('1.0'),
      wbFloat('Ground Attack Chance').SetDefaultEditValue('0.5'),
      wbFloat('Hover Time').SetDefaultEditValue('0.5'),
      wbFloat('Ground Attack Time').SetDefaultEditValue('0.5'),
      wbFloat('Perch Attack Chance').SetDefaultEditValue('0.5'),
      wbFloat('Perch Attack Time').SetDefaultEditValue('0.5'),
      wbFloat('Flying Attack Chance').SetDefaultEditValue('0.75')
    ], cpNormal, True),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      {0x01} 'Dueling',
      {0x02} 'Flanking',
      {0x04} 'Allow Dual Wielding',
      {0x08} 'Charging',
      {0x10} 'Retarget Any Nearby Melee Target',
      {0x20} 'Unknown 5'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags)
  ]);

  wbRecord(DIAL, 'Dialog Topic',
    wbFlags(wbFlagsList([
      {0x00004000} 14, 'Partial Form'
    ]), [14]), [
    wbEDID,
    wbFULL
      .SetAfterLoad(wbDialogueTextAfterLoad)
      .SetAfterSet(wbDialogueTextAfterSet),
    wbFloat(PNAM, 'Priority', cpNormal, True, 1, -1, nil, nil, 50.0),
    wbFormIDCkNoReach(BNAM, 'Branch', [DLBR]),
    wbFormIDCkNoReach(QNAM, 'Quest', [QUST], False, cpNormal, False),
    wbFormIDCk(KNAM, 'Keyword', [KYWD]),
    wbStruct(DATA, 'Data', [
      // this should not be named Flags since TwbFile.BuildReachable
      // expects Top-Level flag here from FNV
      wbInteger('Topic Flags', itU8, wbFlags([
        'Do All Before Repeating',
        'Unknown 1',
        'Unknown 2'
      ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Category', itU8, wbEnum([
        {0} 'Player',
        {1} 'Command',
        {2} 'Scene',
        {3} 'Combat',
        {4} 'Favor',
        {5} 'Detection',
        {6} 'Service',
        {7} 'Miscellaneous'
      ])),
      wbInteger('Subtype', itU16, wbEnum([
        { 0} 'Custom',
        { 1} 'ForceGreet',
        { 2} 'Rumors',
        { 3} 'Custom',
        { 4} 'Call',
        { 5} 'Follow',
        { 6} 'Move',
        { 7} 'Attack',
        { 8} 'Inspect',
        { 9} 'Retrieve',
        {10} 'Stay',
        {11} 'Release',
        {12} 'ShowRelationships',
        {13} 'Reject',
        {14} 'Heal',
        {15} 'Assign',
        {16} 'Enter',
        {17} 'Custom',
        {18} 'Show',
        {19} 'Agree',
        {20} 'Refuse',
        {21} 'ExitFavorState',
        {22} 'MoralRefusal',
        {23} 'Trade',
        {24} 'PathingRefusal',
        {25} 'Attack',
        {26} 'PowerAttack',
        {27} 'Bash',
        {28} 'Hit',
        {29} 'Flee',
        {30} 'BleedOut',
        {31} 'AvoidThreat',
        {32} 'Death',
        {33} 'Block',
        {34} 'Taunt',
        {35} 'ThrowGrenade',
        {36} 'AllyKilled',
        {37} 'OrderFallback',
        {38} 'OrderMoveUp',
        {39} 'OrderFlank',
        {40} 'OrderTakeCover',
        {41} 'Retreat',
        {42} 'CoverMe',
        {43} 'SuppressiveFire',
        {44} 'CrippledLimb',
        {45} 'PairedAttack',
        {46} 'Steal',
        {47} 'Yield',
        {48} 'AcceptYield',
        {49} 'PickpocketCombat',
        {50} 'Assault',
        {51} 'Murder',
        {52} 'AssaultNC',
        {53} 'MurderNC',
        {54} 'PickpocketNC',
        {55} 'StealFromNC',
        {56} 'TrespassAgainstNC',
        {57} 'Trespass',
        {58} 'UNUSED01',
        {59} 'VoicePowerStartShort',
        {60} 'VoicePowerStartLong',
        {61} 'VoicePowerEndShort',
        {62} 'VoicePowerEndLong',
        {63} 'AlertIdle',
        {64} 'LostIdle',
        {65} 'NormalToAlert',
        {66} 'NormalToCombat',
        {67} 'NormalToLost',
        {68} 'AlertToNormal',
        {69} 'AlertToCombat',
        {70} 'CombatToNormal',
        {71} 'CombatToLost',
        {72} 'LostToNormal',
        {73} 'LostToCombat',
        {74} 'DetectFriendDie',
        {75} 'ServiceRefusal',
        {76} 'Repair',
        {77} 'Travel',
        {78} 'Training',
        {79} 'BarterExit',
        {80} 'RepairExit',
        {81} 'Recharge',
        {82} 'RechargeExit',
        {83} 'TrainingExit',
        {84} 'ObserveCombat',
        {85} 'NoticeCorpse',
        {86} 'TimeToGo',
        {87} 'Goodbye',
        {88} 'Hello',
        {89} 'SwingMeleeWeapon',
        {90} 'ShootBow',
        {91} 'ZKeyObject',
        {92} 'Jump',
        {93} 'KnockOverObject',
        {94} 'DestroyObject',
        {95} 'StandonFurniture',
        {96} 'LockedObject',
        {97} 'PickpocketTopic',
        {98} 'PursueIdleTopic',
        {99} 'SharedInfo',
       {100} 'SceneChoice',
       {101} 'PlayerCastProjectileSpell',
       {102} 'PlayerCastSelfSpell',
       {103} 'PlayerShout',
       {104} 'Idle',
       {105} 'EnterSprintBreath',
       {106} 'EnterBowZoomBreath',
       {107} 'ExitBowZoomBreath',
       {108} 'ActorCollidewithActor',
       {109} 'PlayerinIronSights',
       {110} 'OutofBreath',
       {111} 'CombatGrunt',
       {112} 'LeaveWaterBreath',
       {113} 'ImpatientPositive',
       {114} 'ImpatientNegative',
       {115} 'ImpatientNeutral',
       {116} 'ImpatientQuestion',
       {117} 'WaitingForPlayerInput',
       {118} 'Greeting',
       {119} 'PlayerActivateDoor',
       {120} 'PlayerActivateTerminals',
       {121} 'PlayerActivateFurniture',
       {122} 'PlayerActivateActivators',
       {123} 'PlayerActivateContainer',
       {124} 'PlayerAquireFeaturedItem'
      ]))
    ]),
    wbString(SNAM, 'Subtype Name', 4),
    wbInteger(TIFC, 'Info Count', itU32, nil, cpIgnore),
    wbINOM,
    wbINOA
  ]).SetAddInfo(wbDIALAddInfo);

  wbRecord(DOOR, 'Door',
    wbFlags(wbFlagsList([
      {0x00000010}  4, 'Non Occluder',
      {0x00008000} 15, 'Has Distant LOD',
      {0x00010000} 16, 'Random Anim Start',
      {0x00800000} 23, 'Is Marker'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbFULL,
    wbGenericModel,
    wbDEST,
    wbKeywords,
    wbNTRM,
    wbFormIDCk(SNAM, 'Sound - Open', [SNDR]),
    wbFormIDCk(ANAM, 'Sound - Close', [SNDR]),
    wbFormIDCk(BNAM, 'Sound - Loop', [SNDR]),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      '',
      'Automatic',
      'Hidden',
      'Minimal Use',
      'Sliding',
      'Do Not Open in Combat Search',
      'No "To" Text'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbLStringKC(ONAM, 'Alternate Text - Open', 0, cpTranslate),
    wbLStringKC(CNAM, 'Alternate Text - Close', 0, cpTranslate),
    wbRArrayS('Random teleport destinations', wbFormIDCk(TNAM, 'Destination', [CELL, WRLD]))
  ]);

  wbRecord(EFSH, 'Effect Shader', [
    wbEDID,
    wbString(ICON, 'Fill Texture').SetRequired,
    wbString(ICO2, 'Particle Shader Texture'),
    wbString(NAM7, 'Holes Texture').SetRequired,
    wbString(NAM8, 'Membrane Palette Texture').SetRequired,
    wbString(NAM9, 'Particle Palette Texture'),
    wbUnknown(DATA).SetRequired,  // if form version < 62, ignored otherwise
    // format depends on Form Version (appear with form version 62, changed in form version 106), different for older records starting from the first field
    wbUnion(DNAM, '', wbFormVersionDecider(106), [
      wbStruct('Data (old format)', [
        wbByteArray('Unknown', 1),
        wbInteger('Membrane Shader - Source Blend Mode', itU32, wbBlendModeEnum),
        wbInteger('Membrane Shader - Blend Operation', itU32, wbBlendOpEnum),
        wbInteger('Membrane Shader - Z Test Function', itU32, wbZTestFuncEnum),
        wbByteColors('Fill/Texture Effect - Color Key 1'),
        wbFloat('Fill/Texture Effect - Alpha Fade In Time'),
        wbFloat('Fill/Texture Effect - Full Alpha Time'),
        wbFloat('Fill/Texture Effect - Alpha Fade Out Time'),
        wbFloat('Fill/Texture Effect - Presistent Alpha Ratio'),
        wbFloat('Fill/Texture Effect - Alpha Pulse Amplitude'),
        wbFloat('Fill/Texture Effect - Alpha Pulse Frequency'),
        wbFloat('Fill/Texture Effect - Texture Animation Speed (U)'),
        wbFloat('Fill/Texture Effect - Texture Animation Speed (V)'),
        wbFloat('Edge Effect - Fall Off'),
        wbByteColors('Edge Effect - Color'),
        wbFloat('Edge Effect - Alpha Fade In Time'),
        wbFloat('Edge Effect - Full Alpha Time'),
        wbFloat('Edge Effect - Alpha Fade Out Time'),
        wbFloat('Edge Effect - Persistent Alpha Ratio'),
        wbFloat('Edge Effect - Alpha Pulse Amplitude'),
        wbFloat('Edge Effect - Alpha Pulse Frequency'),
        wbFloat('Fill/Texture Effect - Full Alpha Ratio'),
        wbFloat('Edge Effect - Full Alpha Ratio'),
        wbInteger('Membrane Shader - Dest Blend Mode', itU32, wbBlendModeEnum),
        wbInteger('Particle Shader - Source Blend Mode', itU32, wbBlendModeEnum),
        wbInteger('Particle Shader - Blend Operation', itU32, wbBlendOpEnum),
        wbInteger('Particle Shader - Z Test Function', itU32, wbZTestFuncEnum),
        wbInteger('Particle Shader - Dest Blend Mode', itU32, wbBlendModeEnum),
        wbFloat('Particle Shader - Particle Birth Ramp Up Time'),
        wbFloat('Particle Shader - Full Particle Birth Time'),
        wbFloat('Particle Shader - Particle Birth Ramp Down Time'),
        wbFloat('Particle Shader - Full Particle Birth Ratio'),
        wbFloat('Particle Shader - Persistant Particle Count'),
        wbFloat('Particle Shader - Particle Lifetime'),
        wbFloat('Particle Shader - Particle Lifetime +/-'),
        wbFloat('Particle Shader - Initial Speed Along Normal'),
        wbFloat('Particle Shader - Acceleration Along Normal'),
        wbFloat('Particle Shader - Initial Velocity #1'),
        wbFloat('Particle Shader - Initial Velocity #2'),
        wbFloat('Particle Shader - Initial Velocity #3'),
        wbFloat('Particle Shader - Acceleration #1'),
        wbFloat('Particle Shader - Acceleration #2'),
        wbFloat('Particle Shader - Acceleration #3'),
        wbFloat('Particle Shader - Scale Key 1'),
        wbFloat('Particle Shader - Scale Key 2'),
        wbFloat('Particle Shader - Scale Key 1 Time'),
        wbFloat('Particle Shader - Scale Key 2 Time'),
        wbByteColors('Color Key 1 - Color'),
        wbByteColors('Color Key 2 - Color'),
        wbByteColors('Color Key 3 - Color'),
        wbFloat('Color Key 1 - Color Alpha'),
        wbFloat('Color Key 2 - Color Alpha'),
        wbFloat('Color Key 3 - Color Alpha'),
        wbFloat('Color Key 1 - Color Key Time'),
        wbFloat('Color Key 2 - Color Key Time'),
        wbFloat('Color Key 3 - Color Key Time'),
        wbFloat('Particle Shader - Initial Speed Along Normal +/-'),
        wbFloat('Particle Shader - Initial Rotation (deg)'),
        wbFloat('Particle Shader - Initial Rotation (deg) +/-'),
        wbFloat('Particle Shader - Rotation Speed (deg/sec)'),
        wbFloat('Particle Shader - Rotation Speed (deg/sec) +/-'),
        wbFormIDCk('Addon Models', [DEBR, NULL]),
        wbFloat('Holes - Start Time'),
        wbFloat('Holes - End Time'),
        wbFloat('Holes - Start Val'),
        wbFloat('Holes - End Val'),
        wbFloat('Edge Width (alpha units)'),
        wbByteColors('Edge Color'),
        wbFloat('Explosion Wind Speed'),
        wbInteger('Texture Count U', itU32),
        wbInteger('Texture Count V', itU32),
        wbFloat('Addon Models - Fade In Time'),
        wbFloat('Addon Models - Fade Out Time'),
        wbFloat('Addon Models - Scale Start'),
        wbFloat('Addon Models - Scale End'),
        wbFloat('Addon Models - Scale In Time'),
        wbFloat('Addon Models - Scale Out Time'),
        wbFormIDCk('Ambient Sound', [SNDR, NULL]),
        wbByteColors('Fill/Texture Effect - Color Key 2'),
        wbByteColors('Fill/Texture Effect - Color Key 3'),
        wbStruct('Fill/Texture Effect - Color Key Scale/Time', [
          wbFloat('Color Key 1 - Scale'),
          wbFloat('Color Key 2 - Scale'),
          wbFloat('Color Key 3 - Scale'),
          wbFloat('Color Key 1 - Time'),
          wbFloat('Color Key 2 - Time'),
          wbFloat('Color Key 3 - Time')
        ]),
        wbFloat('Color Scale'),
        wbFloat('Birth Position Offset'),
        wbFloat('Birth Position Offset Range +/-'),
        wbStruct('Particle Shader Animated', [
          wbInteger('Start Frame', itU32),
          wbInteger('Start Frame Variation', itU32),
          wbInteger('End Frame', itU32),
          wbInteger('Loop Start Frame', itU32),
          wbInteger('Loop Start Variation', itU32),
          wbInteger('Frame Count', itU32),
          wbInteger('Frame Count Variation', itU32)
        ]),
        wbInteger('Flags', itU32, wbFlags([
          'No Membrane Shader',
          'Membrane Grayscale Color',
          'Membrane Grayscale Alpha',
          'No Particle Shader',
          'Edge Effect Inverse',
          'Affect Skin Only',
          'Ignore Alpha',
          'Project UVs',
          'Ignore Base Geometry Alpha',
          'Lighting',
          'No Weapons',
          'Unknown 11',
          'Unknown 12',
          'Unknown 13',
          'Unknown 14',
          'Particle Animated',
          'Particle Grayscale Color',
          'Particle Grayscale Alpha',
          'Unknown 18',
          'Unknown 19',
          'Unknown 20',
          'Unknown 21',
          'Unknown 22',
          'Unknown 23',
          'Use Blood Geometry'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbFloat('Fill/Texture Effect - Texture Scale (U)'),
        wbFloat('Fill/Texture Effect - Texture Scale (V)'),
        wbInteger('Scene Graph Emit Depth Limit (unused)', itU16)
      ]),
      wbStruct('Data', [
        wbInteger('Membrane Shader - Source Blend Mode', itU32, wbBlendModeEnum).SetDefaultNativeValue(5),
        wbInteger('Membrane Shader - Blend Operation', itU32, wbBlendOpEnum).SetDefaultNativeValue(1),
        wbInteger('Membrane Shader - Z Test Function', itU32, wbZTestFuncEnum).SetDefaultNativeValue(3),
        wbByteColors('Fill/Texture Effect - Color Key 1'),
        wbFloat('Fill/Texture Effect - Alpha Fade In Time'),
        wbFloat('Fill/Texture Effect - Full Alpha Time'),
        wbFloat('Fill/Texture Effect - Alpha Fade Out Time'),
        wbFloat('Fill/Texture Effect - Presistent Alpha Ratio'),
        wbFloat('Fill/Texture Effect - Alpha Pulse Amplitude'),
        wbFloat('Fill/Texture Effect - Alpha Pulse Frequency').SetDefaultEditValue('1.0'),
        wbFloat('Fill/Texture Effect - Texture Animation Speed (U)'),
        wbFloat('Fill/Texture Effect - Texture Animation Speed (V)'),
        wbFloat('Edge Effect - Fall Off').SetDefaultEditValue('1.0'),
        wbByteColors('Edge Effect - Color'),
        wbFloat('Edge Effect - Alpha Fade In Time'),
        wbFloat('Edge Effect - Full Alpha Time'),
        wbFloat('Edge Effect - Alpha Fade Out Time'),
        wbFloat('Edge Effect - Persistent Alpha Ratio'),
        wbFloat('Edge Effect - Alpha Pulse Amplitude'),
        wbFloat('Edge Effect - Alpha Pulse Frequency').SetDefaultEditValue('1.0'),
        wbFloat('Fill/Texture Effect - Full Alpha Ratio').SetDefaultEditValue('1.0'),
        wbFloat('Edge Effect - Full Alpha Ratio').SetDefaultEditValue('1.0'),
        wbInteger('Membrane Shader - Dest Blend Mode', itU32, wbBlendModeEnum).SetDefaultNativeValue(6),
        wbFloat('Holes Animation - Start Time'),
        wbFloat('Holes Animation - End Time').SetDefaultEditValue('10.0'),
        wbFloat('Holes Animation - Start Value').SetDefaultEditValue('255.0'),
        wbFloat('Holes Animation - End Value'),
        wbFormIDCk('Ambient Sound', [SNDR, NULL]),
        wbByteColors('Fill/Texture Effect - Color Key 2'),
        wbByteColors('Fill/Texture Effect - Color Key 3'),
        wbInteger('Unknown', itU8).SetDefaultEditValue('4'),
        wbStruct('Fill/Texture Effect - Color Key Scale/Time', [
          wbFloat('Color Key 1 - Scale').SetDefaultEditValue('1.0'),
          wbFloat('Color Key 2 - Scale').SetDefaultEditValue('1.0'),
          wbFloat('Color Key 3 - Scale').SetDefaultEditValue('1.0'),
          wbFloat('Color Key 1 - Time'),
          wbFloat('Color Key 2 - Time'),
          wbFloat('Color Key 3 - Time')
        ]),
        wbInteger('Flags', itU32, wbFlags([
          'No Membrane Shader',
          'Membrane Grayscale Color',
          'Membrane Grayscale Alpha',
          'No Particle Shader',
          'Edge Effect - Inverse',
          'Affect Skin Only',
          'Texture Effect - Ignore Alpha',
          'Texture Effect - Project UVs',
          'Ignore Base Geometry Alpha',
          'Texture Effect - Lighting',
          'Texture Effect - No Weapons',
          'Use Alpha Sorting',
          'Prefer Dismembered Limbs',
          'Unknown 13',
          'Unknown 14',
          'Particle Animated',
          'Particle Grayscale Color',
          'Particle Grayscale Alpha',
          'Unknown 18',
          'Unknown 19',
          'Unknown 20',
          'Unknown 21',
          'Unknown 22',
          'Unknown 23',
          'Use Blood Geometry (Weapons Only)'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbFloat('Fill/Texture Effect - Texture Scale (U)').SetDefaultEditValue('1.0'),
        wbFloat('Fill/Texture Effect - Texture Scale (V)').SetDefaultEditValue('1.0')
      ])
    ], cpNormal, True),
    wbGenericModel
  ]);

  wbRecord(ENCH, 'Enchantment', [
    wbEDID,
    wbOBND(True),
    wbFULL,
    wbStruct(ENIT, 'Effect Data', [
      wbInteger('Enchantment Cost', itS32),
      wbInteger('Flags', itU32, wbFlags([
        'No Auto-Calc',
        '',
        'Extend Duration On Recast'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Cast Type', itU32, wbCastEnum),
      wbInteger('Enchantment Amount', itS32),
      wbInteger('Target Type', itU32, wbTargetEnum),
      wbInteger('Enchant Type', itU32, wbEnum([], [
        $06, 'Enchantment',
        $0C, 'Staff Enchantment'
      ])),
      wbFloat('Charge Time'),
      wbFormIDCk('Base Enchantment', [ENCH, NULL]),
      wbFormIDCk('Worn Restrictions', [FLST, NULL])
    ], cpNormal, True, nil, 8),
    wbEffectsReq
  ]);

  wbRecord(EYES, 'Eyes',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Non-Playable'
    ])), [
    wbEDID,
    wbFULLReq,
    wbString(ICON, 'Texture', 0, cpNormal, True),
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      {0x01}'Playable',
      {0x02}'Not Male',
      {0x04}'Not Female',
      {0x08}'Unknown 4',
      {0x10}'Unknown 5',
      {0x20}'Unknown 6',
      {0x40}'Unknown 7',
      {0x80}'Unknown 8'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags)
  ]);

  var wbFactionRank :=
    wbRStructSK([0], 'Rank', [
      wbInteger(RNAM, 'Rank#', itU32),
      wbLString(MNAM, 'Male Title', 0, cpTranslate),
      wbLString(FNAM, 'Female Title', 0, cpTranslate),
      wbString(INAM, 'Insignia (unused)')
    ]).SetSummaryKey([0,1,2])
      .SetSummaryMemberPrefixSuffix(0, 'Rank: ', '')
      .SetSummaryMemberPrefixSuffix(1, 'M-Title: "', '"')
      .SetSummaryMemberPrefixSuffix(2, 'F-Title: "', '"')
      .SetSummaryDelimiter(', ')
      .IncludeFlag(dfSummaryNoSortKey)
      .IncludeFlag(dfCollapsed, wbCollapseFactionRanks);

  wbRecord(FACT, 'Faction', [
    wbEDID,
    wbFULL,
    wbFactionRelations,
    wbStruct(DATA, 'Flags', [
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Hidden From NPC',
        {0x00000002} 'Special Combat',
        {0x00000004} 'Unknown 3',
        {0x00000008} 'Unknown 4',
        {0x00000010} 'Unknown 5',
        {0x00000020} 'Unknown 6',
        {0x00000040} 'Track Crime',
        {0x00000080} 'Ignore Crimes: Murder',
        {0x00000100} 'Ignore Crimes: Assault',
        {0x00000200} 'Ignore Crimes: Stealing',
        {0x00000400} 'Ignore Crimes: Trespass',
        {0x00000800} 'Do Not Report Crimes Against Members',
        {0x00001000} 'Crime Gold - Use Defaults',
        {0x00002000} 'Ignore Crimes: Pickpocket',
        {0x00004000} 'Vendor',
        {0x00008000} 'Can Be Owner',
        {0x00010000} 'Ignore Crimes: Werewolf (unused)'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ], cpNormal, True, nil, 1),
    wbFormIDCk(JAIL, 'Exterior Jail Marker', [REFR]),
    wbFormIDCk(WAIT, 'Follower Wait Marker', [REFR]),
    wbFormIDCk(STOL, 'Stolen Goods Container', [REFR]),
    wbFormIDCk(PLCN, 'Player Inventory Container', [REFR]),
    wbFormIDCk(CRGR, 'Shared Crime Faction List', [FLST]),
    wbFormIDCk(JOUT, 'Jail Outfit', [OTFT]),
    wbStruct(CRVA, 'Crime Values', [
      wbInteger('Arrest', itU8, wbBoolEnum).SetDefaultEditValue('True'),
      wbInteger('Attack On Sight', itU8, wbBoolEnum).SetDefaultEditValue('True'),
      wbInteger('Murder', itU16),
      wbInteger('Assault', itU16),
      wbInteger('Trespass', itU16),
      wbInteger('Pickpocket', itU16),
      wbInteger('Unknown', itU16),
      wbFloat('Steal Multiplier'),
      wbInteger('Escape', itU16),
      wbInteger('Werewolf (unused)', itU16)
    ], cpNormal, True, nil, 7),
    wbRArrayS('Ranks', wbFactionRank),
    wbFormIDCk(VEND, 'Vendor Buy/Sell List', [FLST]),
    wbFormIDCk(VENC, 'Merchant Container', [REFR]),
    wbStruct(VENV, 'Vendor Values', [
      wbInteger('Start Hour', itU16),
      wbInteger('End Hour', itU16).SetDefaultEditValue('24'),
      wbInteger('Radius', itU16),
      wbUnknown(2),
      wbInteger('Buys Stolen Items', itU8, wbBoolEnum).SetDefaultEditValue('True'),
      wbInteger('Buy/Sell Everything Not In List?', itU8, wbBoolEnum),
      wbInteger('Buys NonStolen Items', itU8, wbBoolEnum).SetDefaultEditValue('True'),
      wbInteger('Unknown', itU8)
    ]).SetRequired,
    wbPLVD,
    wbCITC,
    wbConditions
  ], False, nil, cpNormal, False, nil {wbFACTAfterLoad}, wbConditionsAfterSet);

  wbRecord(FURN, 'Furniture',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Has Container',
      {0x00000010}  4, 'Unknown 4',
      {0x00000080}  7, 'Is Perch',
      {0x00002000} 13, 'Unknown 13',
      {0x00008000} 15, 'Has Distant LOD',
      {0x00010000} 16, 'Random Anim Start',
      {0x00800000} 23, 'Is Marker',
      {0x02000000} 25, 'Power Armor',
      {0x10000000} 28, 'Must Exit To Talk',
      {0x20000000} 29, 'Child Can Use'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbFULL,
    wbGenericModel,
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbNTRM,
    wbFTYP,
    wbByteColors(PNAM, 'Marker Color (Unused)').SetRequired,
    wbFormIDCk(WNAM, 'Drinking Water Type', [WATR]),
    wbATTX,
    wbInteger(FNAM, 'Flags', itU16, wbFlags([
      {0x0001} 'Unknown 0',
      {0x0002} 'Ignored By Sandbox'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
      .SetRequired,
    wbCITC,
    wbConditions,
    wbCOCT,
    wbCNTOs,
    wbMNAMFurnitureMarker,
    wbStruct(WBDT, 'Workbench Data', [
      wbInteger('Bench Type', itU8, wbEnum([
        {0} 'None',
        {1} 'Create Object', // used only for MS11Workbench [FURN:00091FD5]
        {2} 'Weapons', // used for the Weapons (plural) workbench
        {3} 'Enchanting (unused)', // not used
        {4} 'Enchanting Experiment (unused)', // not used
        {5} 'Alchemy', // used for Chemistry and Cooking, so Alchemy is probably okay
        {6} 'Alchemy Experiment (unused)', // not used
        {7} 'Armor', // FO4 calls this the Armor workbench, no mention of Smithing
        {8} 'Power Armor', // used for Power Armor stations
        {9} 'Robot Mod' // used for Robot stations
      ])),
      wbUnused(1)
    ], cpNormal, True, nil, 1),
    wbFormIDCk(NAM1, 'Associated Form', [ARMO, WEAP, PERK, SPEL, HAZD]),
    wbRArray('Markers', wbRStruct('Marker', [
      wbInteger(ENAM, 'Marker Index', itS32),
      wbStruct(NAM0, 'Disabled Entry Points', [
        wbByteArray('Unknown', 2),
        wbInteger('Disabled Points', itU16, wbFurnitureEntryTypeFlags).IncludeFlag(dfCollapsed, wbCollapseFlags)
      ])
      //wbFormIDCk(FNMK, 'Marker Keyword', [KYWD, NULL])
    ])),
    wbRArray('Marker Entry Points', wbStruct(FNPR, 'Marker', [
      wbInteger('Type', itU16, wbFurnitureAnimTypeEnum),
      wbInteger('Entry Points', itU16, wbFurnitureEntryTypeFlags).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ])),
    wbString(XMRK, 'Marker Model'),
    wbSNAMMarkerParams,
    wbAPPR,
    wbObjectTemplate,
    wbNVNM
  ]);

  wbRecord(GLOB, 'Global',
    wbFlags(wbFlagsList([
      {0x00000040}  6, 'Constant'
    ])), [
    wbEDID,
    wbInteger(FNAM, 'Type', itU8, wbEnum([], [
             0, 'Unknown',
      Ord('s'), 'Short',
      Ord('l'), 'Long',
      Ord('f'), 'Float',
      Ord('b'), 'Boolean'
    ]), cpNormal, True).SetDefaultEditValue('Float'),
    wbFloat(FLTV, 'Value', cpNormal, True)
  ]);

  wbRecord(GMST, 'Game Setting', [
    wbString(EDID, 'Editor ID', 0, cpCritical, True, nil, wbGMSTEDIDAfterSet),
    wbUnion(DATA, 'Value', wbGMSTUnionDecider, [
      wbLString('Name', 0, cpTranslate),
      wbInteger('Int', itS32),
      wbFloat('Float'),
      wbInteger('Bool', itU32, wbBoolEnum)
    ]).SetRequired
  ]).SetSummaryKey([1])
    .IncludeFlag(dfIndexEditorID);

  wbRecord(KYWD, 'Keyword',
    wbFlags(wbFlagsList([
      {0x00080000} {15} 15, 'Restricted'
    ])), [
    wbEDID,
    wbByteRGBA(CNAM).SetRequired,
    wbString(DNAM, 'Notes'),
    wbInteger(TNAM, 'Type', itU32, wbKeywordTypeEnum)
      .SetDefaultEditValue('None')
      .SetRequired,
    wbFormIDCk(DATA, 'Attraction Rule', [AORU]),
    wbFULL,
    wbString(NNAM, 'Display Name') {Legacy record replaced with FULL}
  ]);

  wbRecord(LCRT, 'Location Reference Type', [
    wbEDID,
    wbByteRGBA(CNAM).SetRequired,
    wbInteger(TNAM, 'Type', itU32, wbKeywordTypeEnum)
      .SetDefaultEditValue('None')
      .SetRequired
  ]);

  wbRecord(AACT, 'Action',
    wbFlags(wbFlagsList([
      {0x00080000} {15} 15, 'Restricted'
    ])), [
    wbEDID,
    wbByteRGBA(CNAM).SetRequired,
    wbString(DNAM, 'Notes'),
    wbInteger(TNAM, 'Type', itU32, wbKeywordTypeEnum)
      .SetDefaultEditValue('None')
      .SetRequired,
    wbFormIDCk(DATA, 'Attraction Rule', [AORU]),
    wbFULL
  ]);

  wbRecord(TXST, 'Texture Set', [
    wbEDID,
    wbOBND(True),
    wbRStruct('Textures (RGB/A)', [
      wbString(TX00, 'Diffuse'),
      wbString(TX01, 'Normal/Gloss'),
      wbString(TX03, 'Glow'),
      wbString(TX04, 'Height'),
      wbString(TX05, 'Environment'),
      wbString(TX02, 'Wrinkles'), {TX05 TX02 TX06 Yes this has to go here}
      wbString(TX06, 'Multilayer'),
      wbString(TX07, 'Smooth Spec')
    ]).SetSummaryKey([0]),
    wbDODT,
    wbInteger(DNAM, 'Flags', itU16, wbFlags([
      {0x0001} 'No Specular Map',
      {0x0002} 'Facegen Textures',
      {0x0004} 'Has Model Space Normal Map'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbString(MNAM, 'Material')
  ]).SetSummaryKey([2, 3]);

  wbRecord(HDPT, 'Head Part',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Non-Playable'
    ])), [
    wbEDID,
    wbFULL,
    wbGenericModel,
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      {0x01} 'Playable',
      {0x02} 'Male',
      {0x04} 'Female',
      {0x10} 'Is Extra Part',
      {0x20} 'Use Solid Tint',
      {0x40} 'Uses Body Texture'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(PNAM, 'Type', itU32, wbEnum([
      'Misc',
      'Face',
      'Eyes',
      'Hair',
      'Facial Hair',
      'Scar',
      'Eyebrows',
      'Meatcaps',
      'Teeth',
      'Head Rear'
    ])).SetRequired,
    wbRArrayS('Extra Parts',
      wbFormIDCk(HNAM, 'Part', [HDPT])
    ),
    wbRArray('Parts', wbRStruct('Part', [
      wbInteger(NAM0, 'Part Type', itU32, wbEnum([
        'Race Morph',
        'Tri',
        'Chargen Morph'
      ])),
      wbString(NAM1, 'FileName', 0, cpTranslate, True)
    ])),
    wbFormIDCk(TNAM, 'Texture Set', [TXST]),
    wbFormIDCk(CNAM, 'Color', [CLFM]),
    wbFormIDCk(RNAM, 'Valid Races', [FLST]),
    wbConditions
  ]);

  wbRecord(ASPC, 'Acoustic Space', [
    wbEDID,
    wbOBND(True),
    wbFormIDCk(SNAM, 'Looping Sound', [SNDR]),
    wbFormIDCk(RDAT, 'Use Sound from Region (Interiors Only)', [REGN]),
    wbFormIDCk(BNAM, 'Environment Type', [REVB]),
    wbInteger(XTRI, 'Is Interior', itU8, wbBoolEnum, cpNormal, True),
    wbInteger(WNAM, 'Weather Attenuation (dB)', itU16, wbDiv(100)).SetRequired
  ]);

  wbRecord(MSTT, 'Moveable Static',
    wbFlags(wbFlagsList([
       8, 'Must Update Anims',
       9, 'Hidden From Local Map',
      11, 'Used As Platform',
      13, 'Pack-In Use Only',
      15, 'Has Distant LOD',
      16, 'Random Anim Start',
      19, 'Has Currents',
      25, 'Obstacle',
      26, 'Navmesh - Filter',
      27, 'Navmesh - Bounding Box',
      30, 'Navmesh - Ground'
    ])).SetFlagHasDontShow(26, wbFlagNavmeshFilterDontShow)
       .SetFlagHasDontShow(27, wbFlagNavmeshBoundingBoxDontShow)
       .SetFlagHasDontShow(30, wbFlagNavmeshGroundDontShow), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbFULL,
    wbGenericModel,
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbInteger(DATA, 'On Local Map', itU8, wbBoolEnum)
      .SetDefaultNativeValue(1)
      .SetRequired,
    wbFormIDCk(SNAM, 'Looping Sound', [SNDR])
  ]);

  wbRecord(IDLM, 'Idle Marker',
    wbFlags(wbFlagsList([
    29, 'Child Can Use'
    ])), [
    wbEDID,
    wbOBND(True),
    wbKeywords,
    wbIdleAnimation.SetRequired,
    wbGenericModel,
    wbFormIDCk(PNAM, 'Anim Archtype', [KYWD])
      .SetAfterSet(wbIdleMarkerPNAMAfterSet)
      .SetDontShow(wbIdleMarkerPNAMDontShow),
    wbFormIDCk(QNAM, 'Flavor Anim', [KYWD])
      .SetAfterSet(wbIdleMarkerQNAMAfterSet)
      .SetDontShow(wbIdleMarkerQNAMDontShow)
  ]);

  wbRecord(PROJ, 'Projectile', [
    wbEDID,
    wbOBND(True),
    wbFULL,
    wbGenericModel,
    wbDEST,
    wbByteArray(DATA, 'Unused', 0, cpIgnore),
    wbStruct(DNAM, 'Data', [
      wbInteger('Flags', itU16, wbFlags([
        {0x00001} 'Hitscan',
        {0x00002} 'Explosion',
        {0x00004} 'Alt. Trigger',
        {0x00008} 'Muzzle Flash',
        {0x00010} 'Unknown 4',
        {0x00020} 'Can Be Disabled',
        {0x00040} 'Can Be Picked Up',
        {0x00080} 'Supersonic',
        {0x00100} 'Pins Limbs',
        {0x00200} 'Pass Through Small Transparent',
        {0x00400} 'Disable Combat Aim Correction',
        {0x00800} 'Penetrates Geometry',
        {0x01000} 'Continuous Update',
        {0x02000} 'Seeks Target'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Type', itU16, wbEnum([], [
        $01, 'Missile',
        $02, 'Lobber',
        $04, 'Beam',
        $08, 'Flame',
        $10, 'Cone',
        $20, 'Barrier',
        $40, 'Arrow'
      ])).SetDefaultEditValue('Missile'),
      wbFloat('Gravity'),
      wbFloat('Speed').SetDefaultEditValue('1000.0'),
      wbFloat('Range').SetDefaultEditValue('4000.0'),
      wbFormIDCk('Light', [LIGH, NULL]),
      wbFormIDCk('Muzzle Flash - Light', [LIGH, NULL]),
      wbFloat('Explosion - Alt. Trigger - Proximity'),
      wbFloat('Explosion - Alt. Trigger - Timer'),
      wbFormIDCk('Explosion', [EXPL, NULL]),
      wbFormIDCk('Sound', [SNDR, NULL]),
      wbFloat('Muzzle Flash - Duration'),
      wbFloat('Fade Duration'),
      wbFloat('Impact Force'),
      wbFormIDCk('Sound - Countdown', [SNDR, NULL]),
      wbFormIDCk('Sound - Disable', [SNDR, NULL]),
      wbFormIDCk('Default Weapon Source', [WEAP, NULL]),
      wbFloat('Cone Spread'),
      wbFloat('Collision Radius').SetDefaultEditValue('10.0'),
      wbFloat('Lifetime'),
      wbFloat('Relaunch Interval').SetDefaultEditValue('0.25'),
      wbFormIDCk('Decal Data', [TXST, NULL]),
      wbFormIDCk('Collision Layer', [COLL, NULL]),
      wbInteger('Tracer Frequency', itU8),
      wbFormIDCk('VATS Projectile', [PROJ, NULL])
    ]).SetRequired,
    wbRStructSK([0], 'Muzzle Flash Model', [
      wbString(NAM1, 'Model FileName'),
      wbModelInfo(NAM2)
    ], [], cpNormal, True),
    wbInteger(VNAM, 'Sound Level', itU32, wbSoundLevelEnum, cpNormal, True)
      .SetDefaultEditValue('Normal')
  ]);

  wbRecord(HAZD, 'Hazard', [
    wbEDID,
    wbOBND(True),
    wbFULL,
    wbGenericModel  ,
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD, NULL]),
    wbStruct(DNAM, 'Data', [
      wbInteger('Limit', itU32),
      wbFloat('Radius'),
      wbFloat('Lifetime'),
      wbFloat('Image Space Radius'),
      wbFloat('Target Interval').SetDefaultEditValue('0.3'),
      wbInteger('Flags', itU32, wbFlags([
        {0x01} 'Affects Player Only',
        {0x02} 'Inherit Duration from Spawn Spell',
        {0x04} 'Align to Impact Normal',
        {0x08} 'Inherit Radius from Spawn Spell',
        {0x10} 'Drop to Ground',
        {0x20} 'Taper Effectiveness by Proximity'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFormIDCk('Effect', [SPEL, ENCH, NULL]),
      wbFormIDCk('Light', [LIGH, NULL]),
      wbFormIDCk('Impact Data Set', [IPDS, NULL]),
      wbFormIDCk('Sound', [SNDR, NULL]),
      wbStruct('Taper Effectiveness', [
        wbFloat('Full Effect Radius'),
        wbFloat('Taper Weight'),
        wbFloat('Taper Curse')
      ])
    ]).SetRequired
  ]);

  wbRecord(NAVM, 'Navmesh',
    wbFlags(wbFlagsList([
      11, 'Initially Disabled',
      18, 'Compressed',
      26, 'AutoGen',
      31, 'Navmesh Gen Cell'
    ]), [18]), [
    wbEDID,
    wbNVNM,
    wbArray(ONAM,'Base Objects',
      wbFormID('Base Object')),
    wbArray(PNAM, 'Preferred Connectors',
      wbInteger('Vertex', itU16)),
    wbArray(NNAM, 'Non Connectors',
      wbInteger('Vertex', itU16)),
    IfThen(wbSimpleRecords,
      wbByteArray(MNAM),
      wbArrayS(MNAM, 'PreCut Map Entries',
        wbStructSK([0], 'PreCut Map Entry', [
          wbFormID('Reference'),
          wbArrayS('Triangles',
            wbInteger('Triangle', itU16).SetLinksToCallback(wbTriangleLinksTo),
          -2).IncludeFlag(dfCollapsed, wbCollapseNavmesh)
        ]).IncludeFlag(dfCollapsed, wbCollapseNavmesh)
      ).IncludeFlag(dfCollapsed, wbCollapseNavmesh)
    )
  ]).SetAddInfo(wbNAVMAddInfo);

  wbRecord(NAVI, 'Navmesh Info Map', [
    wbEDID,
    wbInteger(NVER, 'Version', itU32),
    wbRArrayS('Navmesh Infos',
      wbStructSK(NVMI, [0], 'Navmesh Info', [
        wbFormIDCk('Navmesh', [NAVM], false, cpNormalIgnoreEmpty).IncludeFlag(dfSummaryNoName),
        wbInteger('Flags', itU32,
          wbFlags(wbSparseFlags([
          5, 'Is Island',
          6, 'Not Edited'
          ], False, 7)), cpNormalIgnoreEmpty).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbVec3IgnoreEmpty('Approx Location'),
        wbFloat('Preferred %', cpNormalIgnoreEmpty),
        wbArrayS('Edge Links', wbFormIDCk('Navmesh', [NAVM], false, cpNormalIgnoreEmpty), -1).IncludeFlag(dfCollapsed, wbCollapseNavmesh),
        wbArrayS('Preferred Edge Links', wbFormIDCk('Navmesh', [NAVM], false, cpNormalIgnoreEmpty), -1).IncludeFlag(dfCollapsed, wbCollapseNavmesh),
        wbArrayS('Door Links',
          wbStructSK([1], 'Door Link', [
            wbInteger('CRC Hash', itU32, wbCRCValuesEnum, cpNormalIgnoreEmpty).SetDefaultEditValue('PathingDoor'),
            wbFormIDCk('Door Ref', [REFR], false, cpNormalIgnoreEmpty)
          ]).SetSummaryKey([1])
            .IncludeFlag(dfCollapsed, wbCollapseNavmesh)
            .IncludeFlag(dfSummaryMembersNoName),
        -1, cpNormalIgnoreEmpty).IncludeFlag(dfCollapsed, wbCollapseNavmesh),
        wbStruct('Optional Island Data', [
          wbInteger('Has Island Data', itU8, wbBoolEnum, cpNormalIgnoreEmpty).SetAfterSet(wbUpdateSameParentUnions),
          wbUnion('Island Data', wbNAVIIslandDataDecider, [
            wbStruct('Unused', [wbEmpty('Unused')]).IncludeFlag(dfCollapsed, wbCollapseOther),
            wbStruct('Island Data', [
              wbStruct('Navmesh Bounds', [
                wbVec3IgnoreEmpty('Min'),
                wbVec3IgnoreEmpty('Max')
              ]),
              wbArray('Triangles',
                wbStruct('Triangle', [
                  wbInteger('Vertex 0', itU16, nil, cpNormalIgnoreEmpty),
                  wbInteger('Vertex 1', itU16, nil, cpNormalIgnoreEmpty),
                  wbInteger('Vertex 2', itU16, nil, cpNormalIgnoreEmpty)
                ]).IncludeFlag(dfCollapsed, wbCollapseVertices),
              -1, cpNormalIgnoreEmpty).IncludeFlag(dfCollapsed, wbCollapseVertices)
                 .IncludeFlag(dfNotAlignable),
              wbArray('Vertices',
                wbVec3IgnoreEmpty('Vertex'),
              -1, cpNormalIgnoreEmpty).IncludeFlag(dfCollapsed, wbCollapseVertices)
                 .IncludeFlag(dfNotAlignable)
            ]).SetSummaryKey([1])
              .IncludeFlag(dfCollapsed, wbCollapseNavmesh)
              .IncludeFlag(dfSummaryMembersNoName)
          ]).IncludeFlag(dfCollapsed, wbCollapseNavmesh)
        ]).SetSummaryKey([1])
          .IncludeFlag(dfCollapsed, wbCollapseNavmesh)
          .IncludeFlag(dfSummaryMembersNoName),
        wbStruct('Pathing Cell', [
          wbInteger('CRC Hash', itU32, wbCRCValuesEnum, cpNormalIgnoreEmpty).SetDefaultEditValue('PathingCell'),
          wbFormIDCk('Parent World', [WRLD, NULL], false, cpNormalIgnoreEmpty).IncludeFlag(dfSummaryExcludeNull),
          wbUnion('', wbNAVIParentDecider, [
            wbStruct('Coordinates', [
              wbInteger('Grid Y', itS16, nil, cpNormalIgnoreEmpty),
              wbInteger('Grid X', itS16, nil, cpNormalIgnoreEmpty)
            ]).SetSummaryKey([1, 0])
              .SetSummaryMemberPrefixSuffix(0, 'Y: ', '>')
              .SetSummaryMemberPrefixSuffix(1, '<X: ', '')
              .SetSummaryDelimiter(', ')
              .IncludeFlag(dfCollapsed, wbCollapsePlacement)
              .IncludeFlag(dfSummaryMembersNoName),
            wbFormIDCk('Parent Cell', [CELL], false, cpNormalIgnoreEmpty)
          ]).IncludeFlag(dfCollapsed, wbCollapsePlacement)
        ]).SetSummaryKey([1, 2])
          .IncludeFlag(dfCollapsed, wbCollapseNavmesh)
          .IncludeFlag(dfSummaryMembersNoName)
      ]).SetSummaryKeyOnValue([0, 8, 7])
        .SetSummaryPrefixSuffixOnValue(0, '', '')
        .SetSummaryPrefixSuffixOnValue(8, 'in ', '')
        .SetSummaryPrefixSuffixOnValue(7, 'is island with ', '')
        .IncludeFlag(dfCollapsed, wbCollapseNavmesh)
        .IncludeFlag(dfFastAssign)
        .IncludeFlag(dfSummaryMembersNoName)
    ).IncludeFlag(dfCollapsed, wbCollapseNavmesh),
    wbStruct(NVPP, 'Precomputed Pathing', [
      wbArray('Precomputed Paths',
        wbArray('Path',
          wbFormIDCk('Navmesh', [NAVM]),
        -1).IncludeFlag(dfCollapsed, wbCollapseNavmesh),
      -1).IncludeFlag(dfCollapsed, wbCollapseNavmesh),
      wbArrayS('Road Marker Index',
        wbStructSK([1], 'Road Marker', [
          wbFormIDCk('Navmesh', [NAVM]),
          wbInteger('Index', itU32)
        ]).IncludeFlag(dfCollapsed, wbCollapseNavmesh),
      -1).IncludeFlag(dfCollapsed, wbCollapseNavmesh)
    ]).IncludeFlag(dfCollapsed, wbCollapseNavmesh),
    wbArrayS(NVSI, 'Deleted Navmeshes', wbFormIDCk('Navmesh', [NAVM], false, cpNormalIgnoreEmpty), -1, cpNormalIgnoreEmpty).IncludeFlag(dfCollapsed, wbCollapseNavmesh)
  ]);

  wbRecord(EXPL, 'Explosion', [
    wbEDID,
    wbOBND(True),
    wbFULL,
    wbGenericModel,
    wbEnchantment,
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD]),
    wbStruct(DATA, 'Data', [
      wbFormIDCk('Light', [LIGH, NULL]),
      wbFormIDCk('Sound 1', [SNDR, NULL]),
      wbFormIDCk('Sound 2', [SNDR, NULL]),
      wbFormIDCk('Impact Data Set', [IPDS, NULL]),
      wbFormID('Placed Object'),
      wbFormIDCk('Spawn Projectile', [PROJ, NULL]),
      wbFloat('Force'),
      wbFloat('Damage'),
      wbFromVersion(97, wbFloat('Inner Radius')),
      wbFloat('Outer Radius'),
      wbFloat('IS Radius'),
      wbFloat('Vertical Offset Mult'),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Unknown 0',
        {0x00000002} 'Always Uses World Orientation',
        {0x00000004} 'Knock Down - Always',
        {0x00000008} 'Knock Down - By Formula',
        {0x00000010} 'Ignore LOS Check',
        {0x00000020} 'Push Explosion Source Ref Only',
        {0x00000040} 'Ignore Image Space Swap',
        {0x00000080} 'Chain',
        {0x00000100} 'No Controller Vibration',
        {0x00000200} 'Placed Object Persists',
        {0x00000400} 'Skip Underwater Tests'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Sound Level', itU32, wbSoundLevelEnum)
        .SetDefaultEditValue('Normal'),
      wbFromVersion(70, wbFloat('Placed Object AutoFade Delay')),
      wbFromVersion(91, wbInteger('Stagger', itU32, wbEnum([
        'None',
        'Small',
        'Medium',
        'Large',
        'Extra Large'
      ]))),
      wbFromVersion(112, wbStruct('Spawn', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z'),
        wbFloat('Spread Degrees'),
        wbInteger('Count', itU32)
      ]))
    ], cpNormal, True, nil, 13)
  ]);

  wbRecord(DEBR, 'Debris', [
    wbEDID,
    wbRArray('Models', wbDebrisModel(wbMODT), cpNormal, True)
  ]);

  wbRecord(IMGS, 'Image Space', [
    wbEDID,
    wbStruct(ENAM, 'Image Space Data', [
      wbStruct('HDR', [
        wbFloat('Eye Adapt Speed'),
        wbFloat('Tonemap E'),
        wbFloat('Bloom Threshold'),
        wbFloat('Bloom Scale'),
        wbFloat('Auto Exposure Min/Max'),
        wbFloat('Sunlight Scale'),
        wbFloat('Sky Scale')
      ]),
      wbStruct('Cinematic', [
        wbFloat('Saturation'),
        wbFloat('Brightness'),
        wbFloat('Contrast')
      ]),
      wbStruct('Tint', [
        wbFloat('Amount'),
        wbFloatColors('Color')
      ])
    ]),
    wbStruct(HNAM, 'HDR', [
      wbFloat('Eye Adapt Speed').SetDefaultEditValue('3.0'),
      wbFloat('Tonemap E').SetDefaultEditValue('7.0'),
      wbFloat('Bloom Threshold').SetDefaultEditValue('0.6'),
      wbFloat('Bloom Scale').SetDefaultEditValue('0.5'),
      wbFloat('Auto Exposure Max').SetDefaultEditValue('0.15'),
      wbFloat('Auto Exposure Min').SetDefaultEditValue('0.15'),
      wbFloat('Sunlight Scale').SetDefaultEditValue('1.8'),
      wbFloat('Sky Scale').SetDefaultEditValue('1.5'),
      wbFloat('Middle Gray').SetDefaultEditValue('3.0')
    ], cpNormal, True),
    wbStruct(CNAM, 'Cinematic', [
      wbFloat('Saturation').SetDefaultEditValue('0.9'),
      wbFloat('Brightness').SetDefaultEditValue('1.5'),
      wbFloat('Contrast').SetDefaultEditValue('1.1')
    ], cpNormal, True),
    wbStruct(TNAM, 'Tint', [
      wbFloat('Amount'),
      wbFloatColors('Color')
    ], cpNormal, True),
    wbStruct(DNAM, 'Depth of Field', [
      wbFloat('Strength'),
      wbFloat('Distance'),
      wbFloat('Range'),
      wbUnused(2),
      wbInteger('Sky / Blur Radius', itU16, wbEnum([], [
            0, 'None',
        16384, 'Radius 0',
        16672, 'Radius 1',
        16784, 'Radius 2',
        16848, 'Radius 3',
        16904, 'Radius 4',
        16936, 'Radius 5',
        16968, 'Radius 6',
        17000, 'Radius 7',
        16576, 'No Sky, Radius 0',
        16736, 'No Sky, Radius 1',
        16816, 'No Sky, Radius 2',
        16880, 'No Sky, Radius 3',
        16920, 'No Sky, Radius 4',
        16952, 'No Sky, Radius 5',
        16984, 'No Sky, Radius 6',
        17016, 'No Sky, Radius 7'
      ])).SetDefaultEditValue('Radius 0'),
      wbFloat('Vignette Radius'),
      wbFloat('Vignette Strength')
    ], cpNormal, True, nil, 5),
    wbString(TX00, 'LUT')
  ]);

  wbRecord(IMAD, 'Image Space Adapter', [
    wbEDID.SetRequired,
    wbStruct(DNAM, 'Data', [
      wbInteger('Animatable', itU32, wbBoolEnum),
      wbFloat('Duration').SetDefaultEditValue('1.0'),
      wbStruct('HDR', [
        wbIMADMultAddCount('Eye Adapt Speed'),
        wbIMADMultAddCount('Bloom Blur Radius'),
        wbIMADMultAddCount('Bloom Threshold'),
        wbIMADMultAddCount('Scale'),
        wbIMADMultAddCount('Target Lum Min'),
        wbIMADMultAddCount('Target Lum Max'),
        wbIMADMultAddCount('Sunlight Scale'),
        wbIMADMultAddCount('Sky Scale'),
        wbIMADMultAddCount('Unused'),
        wbIMADMultAddCount('Unused'),
        wbIMADMultAddCount('Unused'),
        wbIMADMultAddCount('Unused'),
        wbIMADMultAddCount('Unused'),
        wbIMADMultAddCount('Unused'),
        wbIMADMultAddCount('Unused'),
        wbIMADMultAddCount('Unused'),
        wbIMADMultAddCount('Unused')
      ]),
      wbStruct('Cinematic', [
        wbIMADMultAddCount('Saturation'),
        wbIMADMultAddCount('Brightness'),
        wbIMADMultAddCount('Contrast'),
        wbIMADMultAddCount('Unused')
      ]),
      wbInteger('Tint Color', itU32).SetDefaultEditValue('2'),
      wbInteger('Blur Radius', itU32).SetDefaultEditValue('2'),
      wbInteger('Double Vision Strength', itU32).SetDefaultEditValue('2'),
      wbInteger('Radial Blur Strength', itU32).SetDefaultEditValue('2'),
      wbInteger('Radial Blur Ramp Up', itU32).SetDefaultEditValue('2'),
      wbInteger('Radial Blur Start', itU32).SetDefaultEditValue('2'),
      wbInteger('Radial Blur - Use Target', itU32, wbBoolEnum),
      wbFloat('Radial Blur Center X').SetDefaultEditValue('0.5'),
      wbFloat('Radial Blur Center Y').SetDefaultEditValue('0.5'),
      wbInteger('DoF Strength', itU32),
      wbInteger('DoF Distance', itU32),
      wbInteger('DoF Range', itU32),
      wbInteger('DoF - Use Target', itU8, wbBoolEnum),
      wbInteger('DoF Flags', itU8,
        wbFlags([
        {0} 'Mode - Front',
        {1} 'Mode - Back',
        {2} 'No Sky',
        {3} 'Unknown 3',
        {4} 'Unknown 4',
        {5} 'Unknown 5'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbUnused(2),
      wbInteger('Radial Blur Ramp Down', itU32).SetDefaultEditValue('2'),
      wbInteger('Radial Blur Down Start', itU32).SetDefaultEditValue('2'),
      wbInteger('Fade Color', itU32).SetDefaultEditValue('2'),
      wbInteger('Motion Blur Strength', itU32).SetDefaultEditValue('2'),
      wbFromVersion(116, wbInteger('Vignette Radius', itU32))
        .SetDefaultEditValue('2'),
      wbFromVersion(116, wbInteger('Vignette Strength', itU32))
        .SetDefaultEditValue('2')
    ]).SetRequired,
    wbTimeInterpolators(BNAM, 'Blur Radius'),
    wbTimeInterpolators(VNAM, 'Double Vision Strength'),
    wbArray(TNAM, 'Tint Color', wbColorInterpolator).SetRequired,
    wbArray(NAM3, 'Fade Color', wbColorInterpolator).SetRequired,
    wbRStruct('Radial Blur', [
      wbTimeInterpolators(RNAM, 'Strength'),
      wbTimeInterpolators(SNAM, 'Ramp Up'),
      wbTimeInterpolators(UNAM, 'Start'),
      wbTimeInterpolators(NAM1, 'Ramp Down'),
      wbTimeInterpolators(NAM2, 'Down Start')
    ]).SetRequired,
    wbRStruct('Depth of Field', [
      wbTimeInterpolators(WNAM, 'Strength'),
      wbTimeInterpolators(XNAM, 'Distance'),
      wbTimeInterpolators(YNAM, 'Range'),
      wbTimeInterpolators(NAM5, 'Vignette Radius'),
      wbTimeInterpolators(NAM6, 'Vignette Strength')
    ]).SetRequired,
    wbTimeInterpolators(NAM4, 'Motion Blur Strength'),
    wbRStruct('HDR', [
      wbTimeInterpolatorsMultAdd(_00_IAD, _40_IAD, 'Eye Adapt Speed'),
      wbTimeInterpolatorsMultAdd(_01_IAD, _41_IAD, 'Bloom Blur Radius'),
      wbTimeInterpolatorsMultAdd(_02_IAD, _42_IAD, 'Bloom Threshold'),
      wbTimeInterpolatorsMultAdd(_03_IAD, _43_IAD, 'Bloom Scale'),
      wbTimeInterpolatorsMultAdd(_04_IAD, _44_IAD, 'Target Lum Min'),
      wbTimeInterpolatorsMultAdd(_05_IAD, _45_IAD, 'Target Lum Max'),
      wbTimeInterpolatorsMultAdd(_06_IAD, _46_IAD, 'Sunlight Scale'),
      wbTimeInterpolatorsMultAdd(_07_IAD, _47_IAD, 'Sky Scale'),
      wbTimeInterpolatorsMultAdd(_08_IAD, _48_IAD, 'Unused'),
      wbTimeInterpolatorsMultAdd(_09_IAD, _49_IAD, 'Unused'),
      wbTimeInterpolatorsMultAdd(_0A_IAD, _4A_IAD, 'Unused'),
      wbTimeInterpolatorsMultAdd(_0B_IAD, _4B_IAD, 'Unused'),
      wbTimeInterpolatorsMultAdd(_0C_IAD, _4C_IAD, 'Unused'),
      wbTimeInterpolatorsMultAdd(_0D_IAD, _4D_IAD, 'Unused'),
      wbTimeInterpolatorsMultAdd(_0E_IAD, _4E_IAD, 'Unused'),
      wbTimeInterpolatorsMultAdd(_0F_IAD, _4F_IAD, 'Unused'),
      wbTimeInterpolatorsMultAdd(_10_IAD, _50_IAD, 'Unused')
    ]).SetRequired,
    wbRStruct('Cinematic', [
      wbTimeInterpolatorsMultAdd(_11_IAD, _51_IAD, 'Saturation'),
      wbTimeInterpolatorsMultAdd(_12_IAD, _52_IAD, 'Brightness'),
      wbTimeInterpolatorsMultAdd(_13_IAD, _53_IAD, 'Contrast'),
      wbTimeInterpolatorsMultAdd(_14_IAD, _54_IAD, 'Unused')
    ]).SetRequired
  ]);

  wbRecord(FLST, 'FormID List', [
    wbString(EDID, 'Editor ID', 0, cpBenign, True, nil, wbFLSTEDIDAfterSet),
    wbFULL,
    wbRArrayS('FormIDs', wbFormID(LNAM, 'FormID'), cpNormal, False, nil, nil, nil, wbFLSTLNAMIsSorted)
  ]);

  var wbPerkConditions :=
    wbRStructSK([0], 'Perk Condition', [
      wbInteger(PRKC, 'Run On (Tab Index)', itS8{, wbPRKCToStr, wbPRKCToInt}),
      wbConditions.SetRequired
    ], [], cpNormal, False{, nil, nil, wbPERKPRKCDontShow});

  var wbPerkEffect :=
    wbRStructSK([0, 1], 'Effect', [
    wbStructSK(PRKE, [1, 2, 0], 'Header', [
      wbPerkEffectType(wbPERKPRKETypeAfterSet),
      wbInteger('Rank', itU8),
      wbInteger('Priority', itU8)
    ]),
    wbUnion(DATA, 'Effect Data', wbPerkDATADecider, [
      wbStructSK([0, 1], 'Quest + Stage', [
        wbFormIDCk('Quest', [QUST]),
        wbInteger('Quest Stage', itU16, wbPerkDATAQuestStageToStr, wbQuestStageToInt)
      ]),
      wbFormIDCk('Ability', [SPEL]),
      wbStructSK([0, 1], 'Entry Point', [
        wbInteger('Entry Point', itU8, wbEntryPointsEnum, cpNormal, True, nil{, wbPERKEntryPointAfterSet}),
        wbInteger('Function', itU8, wbEnum([
          {0} 'Unknown 0',
          {1} 'Set Value', // EPFT=1
          {2} 'Add Value', // EPFT=1
          {3} 'Multiply Value', // EPFT=1
          {4} 'Add Range To Value', // EPFT=2
          {5} 'Add Actor Value Mult', // EPFT=2
          {6} 'Absolute Value', // no params
          {7} 'Negative Absolute Value', // no params
          {8} 'Add Leveled List', // EPFT=3
          {9} 'Add Activate Choice', // EPFT=4
         {10} 'Select Spell', // EPFT=5
         {11} 'Select Text', // EPFT=6
         {12} 'Set to Actor Value Mult', // EPFT=2
         {13} 'Multiply Actor Value Mult', // EPFT=2
         {14} 'Multiply 1 + Actor Value Mult', // EPFT=2
         {15} 'Set Text' // EPFT=7
        ])),
        wbInteger('Perk Condition Tab Count', itU8, nil, cpIgnore)
      ])
    ], cpNormal, True),

    wbRArrayS('Perk Conditions', wbPerkConditions),

    wbRStruct('Function Parameters', [
      wbInteger(EPFT, 'Type', itU8, wbEnum([
        {0} 'None',
        {1} 'Float',
        {2} 'Float/AV,Float',
        {3} 'LVLI',
        {4} 'SPEL,lstring,flags',
        {5} 'SPEL',
        {6} 'string',
        {7} 'lstring',
        {8} 'AVIF'
      ])),
      // case(EPFT) of
      // 1: EPFD=float
      // 2: EPFD=float,float
      // 3: EPFD=LVLI
      // 4: EPFD=SPEL, EPF2=lstring, EPF3=int32 flags
      // 5: EPFD=SPEL
      // 6: EPFD=string
      // 7: EPFD=lstring

      wbInteger(EPFB, 'Perk Entry ID (unique)', itU16),
      wbLString(EPF2, 'Button Label', 0, cpTranslate),
      // keeping as struct to be similar to tes5 format
      wbStruct(EPF3, 'Script Flags', [
        wbInteger('Script Flags', itU16, wbFlags([
          'Run Immediately',
          'Replace Default'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
      ]),
      wbUnion(EPFD, 'Data', wbEPFDDecider, [
        {0} wbByteArray('Unknown'),
        {1} wbFloat('Float'),
        {2} wbStruct('Float, Float', [
              wbFloat('Float 1'),
              wbFloat('Float 2')
            ]),
        {3} wbFormIDCk('Leveled Item', [LVLI]),
        {4} wbFormIDCk('Spell', [SPEL]),
        {5} wbFormIDCk('Spell', [SPEL]),
        {6} wbString('Text', 0, cpTranslate),
        {7} wbLString('Text', 0, cpTranslate),
        {8} wbStruct('Actor Value, Float', [
              wbActorValue, // wbInteger('Actor Value', itU32, wbEPFDActorValueToStr, wbEPFDActorValueToInt),
              wbFloat('Float')
            ])
      ], cpNormal, False{, wbEPFDDontShow})
    ], [], cpNormal, False{, wbPERKPRKCDontShow}),
    wbEmpty(PRKF, 'End Marker', cpIgnore, True)
  ]);

  wbRecord(PERK, 'Perk',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Non-Playable'
    ])), [
    wbEDID,
    wbVMADFragmentedPERK,
    wbFULL,
    wbDESCReq,
    wbString(ICON, 'Image'),
    wbConditions,
    wbStruct(DATA, 'Data', [
      wbInteger('Trait', itU8, wbBoolEnum),
      wbInteger('Level', itU8),
      wbInteger('Num Ranks', itU8).SetDefaultEditValue('1'),
      wbFromSize(4, wbInteger('Playable', itU8, wbBoolEnum)
        .SetDefaultEditValue('True')),
      wbFromSize(5, wbInteger('Hidden', itU8, wbBoolEnum))
    ], cpNormal, True),
    wbFormIDCk(SNAM, 'Sound', [SNDR]),
    wbFormIDCK(NNAM, 'Next Perk', [PERK, NULL]),
    wbString(FNAM, 'SWF'),
    wbRArrayS('Effects', wbPerkEffect)
  ]);

  wbRecord(BPTD, 'Body Part Data', [
    wbEDID,
    wbGenericModel,
    wbRArrayS('Body Parts',
      wbRStructSK([1], 'Body Part', [
        wbLString(BPTN, 'Part Name', 0, cpTranslate),
        wbString(BPNN, 'Part Node').SetRequired,
        wbString(BPNT, 'VATS Target').SetRequired,
        wbStruct(BPND, 'Node Data', [
          wbFloat('Damage Mult'),
          wbFormIDCk('Explodable - Debris', [DEBR, NULL]),
          wbFormIDCk('Explodable - Explosion', [EXPL, NULL]),
          wbFloat('Explodable - Debris Scale'),
          wbFormIDCk('Severable - Debris', [DEBR, NULL]),
          wbFormIDCk('Severable - Explosion', [EXPL, NULL]),
          wbFloat('Severable - Debris Scale'),
          wbFloat('Cut - Min'),
          wbFloat('Cut - Max'),
          wbFloat('Cut - Radius'),
          wbFloatAngle('Gore Effects - Local Rotate X'),
          wbFloatAngle('Gore Effects - Local Rotate Y'),
          wbFloat('Cut - Tesselation'),
          wbFormIDCk('Severable - Impact DataSet', [IPDS, NULL]),
          wbFormIDCk('Explodable - Impact DataSet', [IPDS, NULL]),
          wbFloat('Explodable - Limb Replacement Scale'),
          wbInteger('Flags', itU8,
            wbFlags([
              {0} 'Severable',
              {1} 'Hit Reaction',
              {2} 'Hit Reaction - Default',
              {3} 'Explodable',
              {4} 'Cut - Meat Cap Sever',
              {5} 'On Cripple',
              {6} 'Explodable - Absolute Chance',
              {7} 'Show Cripple Geometry'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
          wbInteger('Part Type', itU8,
            wbEnum([
              {0}  'Torso',
              {1}  'Head1',
              {2}  'Eye',
              {3}  'LookAt',
              {4}  'Fly Grab',
              {5}  'Head2',
              {6}  'LeftArm1',
              {7}  'LeftArm2',
              {8}  'RightArm1',
              {9}  'RightArm2',
              {10} 'LeftLeg1',
              {11} 'LeftLeg2',
              {12} 'LeftLeg3',
              {13} 'RightLeg1',
              {14} 'RightLeg2',
              {15} 'RightLeg3',
              {16} 'Brain',
              {17} 'Weapon',
              {18} 'Root',
              {19} 'COM',
              {20} 'Pelvis',
              {21} 'Camera',
              {22} 'Offset Root',
              {23} 'Left Foot',
              {24} 'Right Foot',
              {25} 'Face Target Source'
            ])),
          wbInteger('Health Percent', itU8),
          wbFormIDCk('Actor Value', [AVIF, NULL]),
          wbInteger('To Hit Chance', itU8),
          wbInteger('Explodable - Explosion Chance %', itU8),
          wbInteger('Non-Lethal Dismemberment Chance', itU8),
          wbInteger('Severable - Debris Count', itU8),
          wbInteger('Explodable - Debris Count', itU8),
          wbInteger('Severable - Decal Count', itU8),
          wbInteger('Explodable - Decal Count', itU8),
          wbInteger('Geometry Segment Index', itU8),
          wbFormIDCk('On Cripple - Art Object', [ARTO, NULL]),
          wbFormIDCk('On Cripple - Debris', [DEBR, NULL]),
          wbFormIDCk('On Cripple - Explosion', [EXPL, NULL]),
          wbFormIDCk('On Cripple - Impact DataSet', [IPDS, NULL]),
          wbFloat('On Cripple - Debris Scale'),
          wbInteger('On Cripple - Debris Count', itU8),
          wbInteger('On Cripple - Decal Count', itU8)
        ]).SetRequired,
        wbString(NAM1, 'Limb Replacement Model').SetRequired,
        wbString(NAM4, 'Gore Effects - Target Bone').SetRequired,
        wbModelInfo(NAM5),
        wbString(ENAM, 'Hit Reaction - Start'),
        wbString(FNAM, 'Hit Reaction - End'),
        wbFormIDCk(BNAM, 'Gore Effects - Dismember Blood Art', [ARTO]),
        wbFormIDCk(INAM, 'Gore Effects - Blood Impact Material Type', [MATT]),
        wbFormIDCk(JNAM, 'On Cripple - Blood Impact Material Type', [MATT]),
        wbFormIDCk(CNAM, 'Meat Cap TextureSet', [TXST]),
        wbFormIDCk(NAM2, 'Collar TextureSet', [TXST]),
        wbString(DNAM, 'Twist Variable Prefix')
      ]).SetSummaryKey([1])
        .IncludeFlag(dfAllowAnyMember)
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfSummaryNoSortKey)
        .IncludeFlag(dfStructFirstNotRequired)
    ).SetRequired
  ]).SetSummaryKey([1])
    .IncludeFlag(dfSummaryMembersNoName);

  wbRecord(ADDN, 'Addon Node', [
    wbEDID,
    wbOBND(True),
    wbGenericModel,
    wbInteger(DATA, 'Index', itU32)
      .SetDefaultEditValue('284')
      .SetRequired,
    wbFormIDCk(SNAM, 'Sound', [SNDR]),
    wbFormIDCk(LNAM, 'Light', [LIGH]),
    wbStruct(DNAM, 'Data', [
      wbInteger('Master Particle System Cap', itU16),
      wbInteger('Flags', itU16, wbEnum([
        'No Master Particle System',
        'Master Particle System',
        'Always Loaded',
        'Master Particle System and Always Loaded'
      ]))
    ]).SetRequired
  ]).SetBuildIndexKeys(procedure(const aMainRecord: IwbMainRecord; var aIndexKeys: TwbIndexKeys)
    begin
      if not Assigned(aMainRecord) then
        Exit;

      var lDATA := aMainRecord.ElementNativeValues[DATA];
      if not VarIsOrdinal(lDATA) then
        Exit;

      aIndexKeys.Keys[wbIdxAddonNode] := lDATA;
    end);

  wbRecord(AVIF, 'Actor Value Information', [
    wbEDID,
    wbFULL,
    wbDESCReq,
    wbLString(ANAM, 'Abbreviation', 0, cpTranslate),
    wbFloat(NAM0, 'Default Value').SetRequired, // Prior to form version 81, it was either 0.0, 1.0 or 100.0, so scale or multiplier ?
    wbInteger(AVFL, 'Flags', itU32, wbFlags([ // 32 bits Flags, it used to impact NAM0 loading (bits 10, 11, 12) (even though it loads later :) )
      {0x00000001} 'Unknown 0',
      {0x00000002} 'Skill',
      {0x00000004} 'Uses Enum',
      {0x00000008} 'Don''t allow Script edits',
      {0x00000010} 'Is Full AV Cached',
      {0x00000020} 'Is Permanant AV Cached',
      {0x00000040} 'Unknown 6',
      {0x00000080} 'Unknown 7',
      {0x00000100} 'Unknown 8',
      {0x00000200} 'Unknown 9',
      {0x00000400} 'Default to 0',
      {0x00000800} 'Default to 1.0',
      {0x00001000} 'Default to 100.0',
      {0x00002000} 'Unknown 13',
      {0x00004000} 'Unknown 14',
      {0x00008000} 'Contains List',
      {0x00010000} 'Unknown 16',
      {0x00020000} 'Unknown 17',
      {0x00040000} 'Unknown 18',
      {0x00080000} 'Value less than 1',
      {0x00100000} 'Minimum 1',
      {0x00200000} 'Maximum 10',
      {0x00400000} 'Maximum 100',
      {0x00800000} 'Multiply By 100',
      {0x01000000} 'Percentage',
      {0x02000000} 'Unknown 25',
      {0x04000000} 'Damage Is Positive',
      {0x08000000} 'God Mode Immune',
      {0x10000000} 'Unknown 28',
      {0x20000000} 'Unknown 39',
      {0x40000000} 'Unknown 30',
      {0x80000000} 'Hardcoded'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(NAM1, 'Type', itU32, wbEnum([
      'Derived Attribute',
      'Special (Attribute)',
      'Skill',
      'AI Attribute',
      'Resistance',
      'Condition',
      'Charge',
      'Int Value',
      'Variable',
      'Resource'
    ])).SetDefaultEditValue('Variable')
  ]); // S.P.E.C.I.A.L start at index 5, so FormID 0x2bc+5 to 0x2bc+11, RadResistIngestion at index 0x29

  wbRecord(CAMS, 'Camera Shot', [
    wbEDID,
    wbGenericModel,
    wbConditions,
    wbStruct(DATA, 'Data', [
      wbInteger('Action', itU32, wbEnum([
        {0} 'Shoot',
        {1} 'Fly',
        {2} 'Hit',
        {3} 'Zoom'
      ])).SetDefaultEditValue('Hit'),
      wbInteger('Location', itU32, wbEnum([
        {0} 'Attacker',
        {1} 'Projectile',
        {2} 'Target',
        {3} 'Lead Actor'
      ])).SetDefaultEditValue('Target'),
      wbInteger('Target', itU32, wbEnum([
        {0} 'Attacker',
        {1} 'Projectile',
        {2} 'Target',
        {3} 'Lead Actor'
      ])),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Position Follows Location',
        {0x00000002} 'Rotation Follows Target',
        {0x00000004} 'Don''t Follow Bone',
        {0x00000008} 'First Person Camera',
        {0x00000010} 'No Tracer',
        {0x00000020} 'Start At Time Zero',
        {0x00000040} 'Don''t Reset Location Spring',
        {0x00000080} 'Don''t Reset Target Spring'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbStruct('Time Multipliers', [
        wbFloat('Player'),
        wbFloat('Target'),
        wbFloat('Global').SetDefaultEditValue('1.0')
      ]),
      wbFloat('Max Time'),
      wbFloat('Min Time'),
      wbFloat('Target % Between Actors'),
      wbFloat('Near Target Distance'),
      wbFloat('Location Spring'),
      wbFloat('Target Spring'),
      wbVec3('Rotation Offset')
    ], cpNormal, True, nil, 9),
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD])
  ]);

  wbRecord(CPTH, 'Camera Path', [
    wbEDID,
    wbConditions,
    wbStruct(ANAM, 'Camera Paths', [
      wbFormIDCk('Parent', [CPTH, NULL], False, cpBenign),
      wbFormIDCk('Previous', [CPTH, NULL], False, cpBenign)
    ]).SetRequired,
    wbInteger(DATA, 'Camera Zoom / Flags', itU8, wbFlags([
      {0x01} 'Disable',
      {0x02} 'Shot List',
      {0x04} 'Dynamic Camera Times',
      {0x08} 'Unknown 3',
      {0x10} 'Unknown 4',
      {0x20} 'Unknown 5',
      {0x40} 'Randomize Paths',
      {0x80} 'Not Must Have Camera Shots'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbRArray('Camera Shots', wbFormIDCk(SNAM, 'Camera Shot', [CAMS]))
  ]);

  wbRecord(VTYP, 'Voice Type', [
    wbEDID,
    wbInteger(DNAM, 'Flags', itU8, wbFlags([
      'Allow Default Dialog',
      'Female'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags)
  ]);

  wbRecord(MATT, 'Material Type', [
    wbEDID,
    wbFormIDCk(PNAM, 'Material Parent', [MATT, NULL]),
    wbString(MNAM, 'Material Name'),
    wbFloatColors(CNAM, 'Havok Display Color')
      .SetRequired,
    wbFloat(BNAM, 'Buoyancy')
      .SetDefaultEditValue('1.0')
      .SetRequired,
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      'Stair Material',
      'Arrows Stick',
      'Can Tunnel'
    ], False)).IncludeFlag(dfCollapsed, wbCollapseFlags)
      .SetRequired,
    wbFormIDCk(HNAM, 'Havok Impact Data Set', [IPDS]),
    wbString(ANAM, 'Breakable FX'),
    wbMODT
  ]);

  wbRecord(IPCT, 'Impact', [
    wbEDID,
    wbGenericModel,
    wbStruct(DATA, '', [
      wbFloat('Effect - Duration').SetDefaultEditValue('0.25'),
      wbInteger('Effect - Orientation', itU32, wbEnum([
        'Surface Normal',
        'Projectile Vector',
        'Projectile Reflection'
      ])).SetDefaultEditValue('Projectile Reflection'),
      wbFloat('Angle Threshold').SetDefaultEditValue('15.0'),
      wbFloat('Placement Radius').SetDefaultEditValue('16.0'),
      wbInteger('Sound Level', itU32, wbSoundLevelEnum)
        .SetDefaultEditValue('Normal'),
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'No Decal Data'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Impact Result', itU8, wbEnum([
         {0} 'Default',
         {1} 'Destroy',
         {2} 'Bounce',
         {3} 'Impale',
         {4} 'Stick'
      ])),
      wbUnknown(2)
    ], cpNormal, True),
    wbDODT,
    wbFormIDCk(DNAM, 'Texture Set', [TXST]),
    wbFormIDCk(ENAM, 'Secondary Texture Set', [TXST]),
    wbFormIDCk(SNAM, 'Sound 1', [SNDR]),
    wbFormIDCk(NAM1, 'Sound 2', [SNDR]),
    wbFormIDCk(NAM3, 'Footstep Explosion', [EXPL]),
    wbFormIDCk(NAM2, 'Hazard', [HAZD]),
    wbFloat(FNAM, 'Footstep Particle Max Dist').SetDefaultEditValue('800.0')
  ]);

  wbRecord(IPDS, 'Impact Data Set', [
    wbEDID,
    wbRArrayS('Data', wbStructSK(PNAM, [0], '', [
      wbFormIDCk('Material', [MATT]),
      wbFormIDCk('Impact', [IPCT])
    ]))
  ]);

  wbRecord(ECZN, 'Encounter Zone', [
    wbEDID,
    wbStruct(DATA, '', [
      wbFormIDCkNoReach('Owner', [NPC_, FACT, NULL]),
      wbFormIDCk('Location', [LCTN, NULL]),
      wbInteger('Rank', itS8),
      wbInteger('Min Level', itS8),
      wbInteger('Flags', itU8, wbFlags([
        'Never Resets',
        'Match PC Below Minimum Level',
        'Disable Combat Boundary',
        'Workshop'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Max Level', itS8)
    ], cpNormal, True)
  ]);

  wbRecord(LCTN, 'Location',
    wbFlags(wbFlagsList([
    11, 'Interior Cells Use Ref Location for world map player marker',
    14, 'Unknown 14' //Partial Form
    ])), [
    wbEDID,
    wbArrayS(ACPR, 'Added Persist Location References',
      wbStructSK([0], 'Reference', [
        wbFormIDCk('Ref', sigReferences, False, cpBenign),
        wbFormIDCk('World/Cell', [WRLD, CELL], False, cpBenign),
        wbInteger('Grid Y', itS16, nil, cpBenign).SetDontShow(wbLCTNCellDontShow),
        wbInteger('Grid X', itS16, nil, cpBenign).SetDontShow(wbLCTNCellDontShow)
      ], cpBenign),
    0, cpBenign),
    wbArrayS(LCPR, 'Master Persist Location References',
      wbStructSK([0], 'Reference', [
        wbFormIDCk('Ref', sigReferences, False, cpBenign),
        wbFormIDCk('World/Cell', [WRLD, CELL], False, cpBenign),
        wbInteger('Grid Y', itS16, nil, cpBenign).SetDontShow(wbLCTNCellDontShow),
        wbInteger('Grid X', itS16, nil, cpBenign).SetDontShow(wbLCTNCellDontShow)
      ], cpBenign),
    0, cpBenign),
    wbArrayS(RCPR, 'Removed Persist Location References',
      wbFormIDCk('Reference', [ACHR, REFR], False, cpBenign),
    0, cpBenign),
    wbArrayS(ACUN, 'Added Unique NPCs',
      wbStructSK([1], 'Actor', [
        wbFormIDCk('NPC', [NPC_], False, cpBenign),
        wbFormIDCk('Actor Ref', [ACHR], False, cpBenign),
        wbFormIDCk('Location', [LCTN, NULL], False, cpBenign)
      ], cpBenign),
    0, cpBenign),
    wbArrayS(LCUN, 'Master Unique NPCs',
      wbStructSK([1], 'Actor', [
        wbFormIDCk('NPC', [NPC_], False, cpBenign),
        wbFormIDCk('Actor Ref', [ACHR], False, cpBenign),
        wbFormIDCk('Location', [LCTN, NULL], False, cpBenign)
      ], cpBenign),
    0, cpBenign),
    wbArrayS(RCUN, 'Removed Unique NPCs',
      wbFormIDCk('Actor', [NPC_], False, cpBenign),
    0, cpBenign),
    wbArrayS(ACSR, 'Added Special References',
      wbStructSK([1], 'Reference', [
        wbFormIDCk('Loc Ref Type', [LCRT], False, cpBenign),
        wbFormIDCk('Ref', sigReferences, False, cpBenign),
        wbFormIDCk('World/Cell', [WRLD, CELL], False, cpBenign),
        wbInteger('Grid Y', itS16, nil, cpBenign).SetDontShow(wbLCTNCellDontShow),
        wbInteger('Grid X', itS16, nil, cpBenign).SetDontShow(wbLCTNCellDontShow)
      ], cpBenign),
    0, cpBenign),
    wbArrayS(LCSR, 'Master Special References',
      wbStructSK([1], 'Reference', [
        wbFormIDCk('Loc Ref Type', [LCRT], False, cpBenign),
        wbFormIDCk('Ref', sigReferences, False, cpBenign),
        wbFormIDCk('World/Cell', [WRLD, CELL], False, cpBenign),
        wbInteger('Grid Y', itS16, nil, cpBenign).SetDontShow(wbLCTNCellDontShow),
        wbInteger('Grid X', itS16, nil, cpBenign).SetDontShow(wbLCTNCellDontShow)
      ], cpBenign),
    0, cpBenign),
    wbArrayS(RCSR, 'Removed Special References',
      wbFormIDCk('Reference', [ACHR, REFR], False, cpBenign),
    0, cpBenign),
    wbRArrayS('Added Worldspace Cells',
      wbStructSK(ACEC, [0], 'Worldspace', [
        wbFormIDCk('World', [WRLD], False, cpBenign),
        wbArrayS('Cells',
          wbStructSK([0,1], 'Coords', [
            wbInteger('Grid Y', itS16, nil, cpBenign),
            wbInteger('Grid X', itS16, nil, cpBenign)
          ], cpBenign),
        0, cpBenign)
      ], cpBenign),
    cpBenign),
    wbRArrayS('Master Worldspace Cells',
      wbStructSK(LCEC, [0], 'Worldspace', [
        wbFormIDCk('World', [WRLD], False, cpBenign),
        wbArrayS('Cells',
          wbStructSK([0,1], 'Coords', [
            wbInteger('Grid Y', itS16, nil, cpBenign),
            wbInteger('Grid X', itS16, nil, cpBenign)
          ], cpBenign),
        0, cpBenign)
      ], cpBenign),
    cpBenign),
    wbRArrayS('Removed Worldspace Cells',
      wbStructSK(RCEC, [0], 'Worldspace', [
        wbFormIDCk('World', [WRLD], False, cpBenign),
        wbArrayS('Cells',
          wbStructSK([0,1], 'Coords', [
            wbInteger('Grid Y', itS16, nil, cpBenign),
            wbInteger('Grid X', itS16, nil, cpBenign)
          ], cpBenign),
        0, cpBenign)
      ], cpBenign),
    cpBenign),
    wbArrayS(ACID, 'Added Initially Disabled References',
      wbFormIDCk('Ref', sigReferences, False, cpBenign),
    0, cpBenign),
    wbArrayS(LCID, 'Master Initially Disabled References',
      wbFormIDCk('Ref', sigReferences, False, cpBenign),
    0, cpBenign),
    wbArrayS(ACEP, 'Added Enable Parent References',
      wbStruct('Reference', [
        wbFormIDCk('Ref', sigReferences, False, cpBenign),
        wbFormIDCk('Enable Parent', sigReferences, False, cpBenign),
        wbInteger('Flags', itU8,
          wbFlags([
          {0} 'Set Enable State to Opposite of Parent',
          {1} 'Pop In'
          ]),
        cpBenign).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbUnused(3)
      ], cpBenign),
    0, cpBenign),
    wbArrayS(LCEP, 'Master Enable Parent References',
      wbStruct('Reference', [
        wbFormIDCk('Ref', sigReferences, False, cpBenign),
        wbFormIDCk('Enable Parent', sigReferences, False, cpBenign),
        wbInteger('Flags', itU8,
          wbFlags([
          {0} 'Set Enable State to Opposite of Parent',
          {1} 'Pop In'
          ]),
        cpBenign).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbUnused(3)
      ], cpBenign),
    0, cpBenign),
    wbFULL,
    wbKeywords,
    wbFormIDCk(PNAM, 'Parent Location', [LCTN, NULL]),
    wbFormIDCk(NAM1, 'Music', [MUSC, NULL]),
    wbFormIDCk(FNAM, 'Unreported Crime Faction', [FACT]),
    wbFormIDCk(MNAM, 'World Location Marker Ref', [REFR, ACHR]),
    wbFloat(RNAM, 'World Location Radius'),
    //wbFormIDCk(NAM0, 'Horse Marker Ref', [REFR]),
    wbFloat(ANAM, 'Actor Fade Mult').SetDefaultEditValue('1.0'),
    wbByteRGBA(CNAM)
  ]);

  var wbMenuButton :=
    wbRStruct('Menu Button', [
      wbLStringKC(ITXT, 'Button Text', 0, cpTranslate),
      wbConditions
    ]);

  wbRecord(MESG, 'Message', [
    wbEDID,
    wbDESCReq,
    wbFULL,
    wbFormIDCk(INAM, 'Icon (unused)', [NULL], False, cpIgnore, True), // leftover
    wbFormIDCk(QNAM, 'Owner Quest', [QUST]),
    wbInteger(DNAM, 'Flags', itU32, wbFlags([
      'Message Box',
      'Delay Initial Display'
    ]), cpNormal, True, False, nil, wbMESGDNAMAfterSet).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(TNAM, 'Display Time', itU32, nil, cpNormal, True, False, wbMESGTNAMDontShow)
      .SetDefaultEditValue('2'),
    wbString(SNAM, 'SWF'),
    wbLStringKC(NNAM, 'Short Title', 0, cpTranslate),
    wbRArray('Menu Buttons', wbMenuButton)
  ], False, nil, cpNormal, False, wbMESGAfterLoad);

  a := MakeVarRecs([
                  0, 'None',
    Sig2Int('AAAC'), 'Action Activate',
    Sig2Int('AAB1'), 'Action Bleedout Start',
    Sig2Int('AAB2'), 'Action Bleedout Stop',
    Sig2Int('AABA'), 'Action Block Anticipate',
    Sig2Int('AABH'), 'Action Block Hit',
    Sig2Int('AABI'), 'Action Bumped Into',
    Sig2Int('AADA'), 'Action Dual Attack',
    Sig2Int('AADE'), 'Action Death',
    Sig2Int('AADL'), 'Action Dual Release',
    Sig2Int('AADR'), 'Action Draw',
    Sig2Int('AADW'), 'Action Death Wait',
    Sig2Int('AAF1'), 'Action Fly Start',
    Sig2Int('AAF2'), 'Action Fly Stop',
    Sig2Int('AAFA'), 'Action Fall',
    Sig2Int('AAFQ'), 'Action Force Equip',
    Sig2Int('AAGU'), 'Action Get Up',
    Sig2Int('AAH1'), 'Action Hover Start',
    Sig2Int('AAH2'), 'Action Hover Stop',
    Sig2Int('AAID'), 'Action Idle',
    Sig2Int('AAIS'), 'Action Idle Stop',
    Sig2Int('AAJP'), 'Action Jump',
    Sig2Int('AALA'), 'Action Left Attack',
    Sig2Int('AALD'), 'Action Left Ready',
    Sig2Int('AALI'), 'Action Left Interrupt',
    Sig2Int('AALK'), 'Action Look',
    Sig2Int('AALM'), 'Action Large Movement Delta',
    Sig2Int('AALN'), 'Action Land',
    Sig2Int('AALR'), 'Action Left Release',
    Sig2Int('AALS'), 'Action Left Sync Attack',
    Sig2Int('AAMT'), 'Action Mantle',
    Sig2Int('AAOE'), 'Action AoE Attack',
    Sig2Int('AAPA'), 'Action Right Power Attack',
    Sig2Int('AAPE'), 'Action Path End',
    Sig2Int('AAPS'), 'Action Path Start',
    Sig2Int('AAR2'), 'Action Large Recoil',
    Sig2Int('AARA'), 'Action Right Attack',
    Sig2Int('AARC'), 'Action Recoil',
    Sig2Int('AARD'), 'Action Right Ready',
    Sig2Int('AARI'), 'Action Right Interrupt',
    Sig2Int('AARR'), 'Action Right Release',
    Sig2Int('AARS'), 'Action Right Sync Attack',
    Sig2Int('AAS1'), 'Action Stagger Start',
    Sig2Int('AASC'), 'Action Shield Change',
    Sig2Int('AASH'), 'Action Sheath',
    Sig2Int('AASN'), 'Action Sneak',
    Sig2Int('AASP'), 'Action Sprint Stop',
    Sig2Int('AASS'), 'Action Summoned Start',
    Sig2Int('AAST'), 'Action Sprint Start',
    Sig2Int('AASW'), 'Action Swim State Change',
    Sig2Int('AAVC'), 'Action Voice',
    Sig2Int('AAVD'), 'Action Voice Ready',
    Sig2Int('AAVI'), 'Action Voice Interrupt',
    Sig2Int('AAVR'), 'Action Voice Release',
    Sig2Int('AAWH'), 'Action Ward Hit',
    Sig2Int('ABLA'), 'Action Begin Looping Activate',
    Sig2Int('ABOL'), 'Action Bolt Charge',
    Sig2Int('ABSE'), 'Art Object Absorb Effect',
    Sig2Int('ACHI'), 'Action Hide',
    Sig2Int('ACSS'), 'Action Cover Sprint Start',
    Sig2Int('ACTN'), 'Action Tunnel',
    Sig2Int('ACWR'), 'Action Cower',
    Sig2Int('ADGE'), 'Action Dodge',
    Sig2Int('ADPA'), 'Action Dual Power Attack',
    Sig2Int('AECL'), 'Action Enter Cover',
    Sig2Int('AELA'), 'Action End Looping Activate',
    Sig2Int('AENC'), 'Action Enter Combat',
    Sig2Int('AENI'), 'Action Dialogue Enter',
    Sig2Int('AEVD'), 'Action Evade',
    Sig2Int('AEXC'), 'Action Exit Cover',
    Sig2Int('AEXI'), 'Action Dialogue Exit',
    Sig2Int('AEXT'), 'Action Exit Combat',
    Sig2Int('AFCH'), 'Action Fire Charge',
    Sig2Int('AFCO'), 'Action Fire Charge Hold',
    Sig2Int('AFEM'), 'Action Fire Empty',
    Sig2Int('AFIA'), 'Action Fire Auto',
    Sig2Int('AFIS'), 'Action Fire Single',
    Sig2Int('AFLT'), 'Action Flip-Throw',
    Sig2Int('AFNP'), 'Keyword Activator Furniture No Player',
    Sig2Int('AGAL'), 'Action Gun Alert',
    Sig2Int('AGCS'), 'Action Gun Charge Start',
    Sig2Int('AGDN'), 'Action Gun Down',
    Sig2Int('AGRX'), 'Action Gun Relaxed',
    Sig2Int('AGRY'), 'Action Gun Ready',
    Sig2Int('AIDW'), 'Action Idle Warn',
    Sig2Int('AIEN'), 'Action Interaction Enter',
    Sig2Int('AIEQ'), 'Action Interaction Exit Quick',
    Sig2Int('AIEX'), 'Action Interaction Exit',
    Sig2Int('AILN'), 'Action Dialogue Listen Negative',
    Sig2Int('AILp'), 'Action Dialogue Listen Positive',
    Sig2Int('AILQ'), 'Action Dialogue Listen Question',
    Sig2Int('AINT'), 'Action Intimidate',
    Sig2Int('AIVC'), 'Verlet Cape',
    Sig2Int('AIXA'), 'Action Interaction Exit Alternate',
    Sig2Int('AKDN'), 'Action Knockdown',
    Sig2Int('ALIC'), 'Action Limb Critical',
    Sig2Int('ALIK'), 'Alcohol Item keyword',
    Sig2Int('ALPA'), 'Action Left Power Attack',
    Sig2Int('ALTI'), 'Action Dialogue Listen',
    Sig2Int('AMBK'), 'Action Move Backward',
    Sig2Int('AMEL'), 'Action Melee',
    Sig2Int('AMFD'), 'Action Move Forward',
    Sig2Int('AMLT'), 'Action Move Left',
    Sig2Int('AMRT'), 'Action Move Right',
    Sig2Int('AMSP'), 'Action Move Stop',
    Sig2Int('AMST'), 'Action Move Start',
    Sig2Int('ANML'), 'Keyword Animal',
    Sig2Int('ANSC'), 'Action NonSupport Contact',
    Sig2Int('AODA'), 'Keyword Armor Material Daedric',
    Sig2Int('AODB'), 'Keyword Armor Material Dragonbone',
    Sig2Int('AODP'), 'Keyword Armor Material Dragonplate',
    Sig2Int('AODS'), 'Keyword Armor Material Dragonscale',
    Sig2Int('AODW'), 'Keyword Armor Material Dwarven',
    Sig2Int('AOEB'), 'Keyword Armor Material Ebony',
    Sig2Int('AOEL'), 'Keyword Armor Material Elven',
    Sig2Int('AOES'), 'Keyword Armor Material ElvenSplinted',
    Sig2Int('AOFE'), 'Keyword Armor Material Iron',
    Sig2Int('AOFL'), 'Keyword Armor Material FullLeather',
    Sig2Int('AOGL'), 'Keyword Armor Material Glass',
    Sig2Int('AOHI'), 'Keyword Armor Material Hide',
    Sig2Int('AOIB'), 'Keyword Armor Material IronBanded',
    Sig2Int('AOIH'), 'Keyword Armor Material ImperialHeavy',
    Sig2Int('AOIM'), 'Keyword Armor Material Imperial',
    Sig2Int('AOIR'), 'Keyword Armor Material ImperialReinforced',
    Sig2Int('AOOR'), 'Keyword Armor Material Orcish',
    Sig2Int('AOSC'), 'Keyword Armor Material Scaled',
    Sig2Int('AOSD'), 'Keyword Armor Material Studded',
    Sig2Int('AOSK'), 'Keyword Armor Material Stormcloak',
    Sig2Int('AOSP'), 'Keyword Armor Material SteelPlate',
    Sig2Int('AOST'), 'Keyword Armor Material Steel',
    Sig2Int('APIC'), 'Action Pipboy Close',
    Sig2Int('APID'), 'Action Pipboy Data',
    Sig2Int('APII'), 'Action Pipboy Inventory',
    Sig2Int('APIM'), 'Action Pipboy Map',
    Sig2Int('APIN'), 'Action Pipboy Inspect',
    Sig2Int('APIP'), 'Action Pipboy',
    Sig2Int('APIS'), 'Action Pipboy Stats',
    Sig2Int('APIT'), 'Action Pipboy Tab',
    Sig2Int('APIZ'), 'Action Pipboy Zoom',
    Sig2Int('APLH'), 'Action Pipboy Load Holotape',
    Sig2Int('APLN'), 'Action Dialogue Listen Neutral',
    Sig2Int('APNC'), 'Action Panic',
    Sig2Int('APPS'), 'Action Pipboy Select',
    Sig2Int('APR0'), 'Action Pipboy Radio Off',
    Sig2Int('APR1'), 'Action Pipboy Radio On',
    Sig2Int('APSH'), 'Allow Player Shout',
    Sig2Int('APTP'), 'Action Pipboy Tab Previous',
    Sig2Int('AREL'), 'Action Reload',
    Sig2Int('ARGI'), 'Action Ragdoll Instant',
    Sig2Int('ARTL'), 'Armor Material List',
    Sig2Int('ASFL'), 'Action Shuffle',
    Sig2Int('ASID'), 'Action Idle Stop Instant',
    Sig2Int('ASIR'), 'Action Sighted Release',
    Sig2Int('ASIT'), 'Action Sighted',
    Sig2Int('ATHR'), 'Action Throw',
    Sig2Int('ATKI'), 'Action Dialogue Talking',
    Sig2Int('ATLE'), 'Action Turn Left',
    Sig2Int('ATRI'), 'Action Turn Right',
    Sig2Int('ATSP'), 'Action Turn Stop',
    Sig2Int('AVVP'), 'Vampire Available Perks',
    Sig2Int('AVWP'), 'Unused',
    Sig2Int('AWWS'), 'Action Waterwalk Start',
    Sig2Int('AWWW'), 'Bunny Faction',
    Sig2Int('BAPO'), 'Base Potion',
    Sig2Int('BAPS'), 'Base Poison',
    Sig2Int('BEEP'), 'Keyword Robot',
    Sig2Int('BENA'), 'Base Armor Enchantment',
    Sig2Int('BENW'), 'Base Weapon Enchantment',
    Sig2Int('BTMS'), 'Battle Music',
    Sig2Int('CACA'), 'Commanded Actor Ability',
    Sig2Int('CHIK'), 'Chem Item keyword',
    Sig2Int('CLIK'), 'Clothes Item keyword',
    Sig2Int('CMPX'), 'Complex Scene Object',
    Sig2Int('CNMK'), 'Keyword nullptr Mod',
    Sig2Int('COEX'), 'Keyword Conditional Explosion',
    Sig2Int('COOK'), 'Keyword Cooking Pot',
    Sig2Int('CSTY'), 'Combat Style',
    Sig2Int('CWNE'), 'Keyword Civil War Neutral',
    Sig2Int('CWOK'), 'Keyword Civil War Owner',
    Sig2Int('DAED'), 'Keyword Daedra',
    Sig2Int('DBHF'), 'Dark Brotherhood Faction',
    Sig2Int('DCMS'), 'Dungeon Cleared Music',
    Sig2Int('DCZM'), 'Dragon Crash Zone Marker',
    Sig2Int('DDSC'), 'Dialogue Voice Category',
    Sig2Int('DEIS'), 'Drug Wears Off Image Space',
    Sig2Int('DFTS'), 'Footstep Set',
    Sig2Int('DGFL'), 'DialogueFollower Quest',
    Sig2Int('DIEN'), 'Keyword Disallow Enchanting',
    Sig2Int('DLMT'), 'Landscape Material',
    Sig2Int('DLZM'), 'Dragon Land Zone Marker',
    Sig2Int('DMFL'), 'Default Movement Type: Fly',
    Sig2Int('DMSN'), 'Default Movement Type: Sneak',
    Sig2Int('DMSW'), 'Default Movement Type: Swim',
    Sig2Int('DMWL'), 'Default Movement Type: Default',
    Sig2Int('DOP2'), 'Dialogue Output Model 3D',
    Sig2Int('DOP3'), 'Dialogue Output Model 2D',
    Sig2Int('DRAK'), 'Keyword Dragon',
    Sig2Int('DTMS'), 'Death Music',
    Sig2Int('EACA'), 'Every Actor Ability',
    Sig2Int('EPDF'), 'Eat Package Default Food',
    Sig2Int('FFFP'), 'Keyword Furniture Forces 1st Person',
    Sig2Int('FFTP'), 'Keyword Furniture Forces 3rd Person',
    Sig2Int('FOIK'), 'Food Item Keyword',
    Sig2Int('FORG'), 'Keyword Forge',
    Sig2Int('FTEL'), 'Male Face Texture Set: Eyes',
    Sig2Int('FTGF'), 'Fighters'' Guild Faction',
    Sig2Int('FTHD'), 'Male Face Texture Set: Head',
    Sig2Int('FTHF'), 'Female Face Texture Set: Head',
    Sig2Int('FTMF'), 'Female Face Texture Set: Mouth',
    Sig2Int('FTML'), 'Favor travel marker location',
    Sig2Int('FTMO'), 'Male Face Texture Set: Mouth',
    Sig2Int('FTNP'), 'Furniture Test NPC',
    Sig2Int('FTRF'), 'Female Face Texture Set: Eyes'
  ]);

  b := MakeVarRecs([
    Sig2Int('GCK1'), 'Keyword Generic Craftable Keyword 01',
    Sig2Int('GCK2'), 'Keyword Generic Craftable Keyword 02',
    Sig2Int('GCK3'), 'Keyword Generic Craftable Keyword 03',
    Sig2Int('GCK4'), 'Keyword Generic Craftable Keyword 04',
    Sig2Int('GCK5'), 'Keyword Generic Craftable Keyword 05',
    Sig2Int('GCK6'), 'Keyword Generic Craftable Keyword 06',
    Sig2Int('GCK7'), 'Keyword Generic Craftable Keyword 07',
    Sig2Int('GCK8'), 'Keyword Generic Craftable Keyword 08',
    Sig2Int('GCK9'), 'Keyword Generic Craftable Keyword 09',
    Sig2Int('GCKX'), 'Keyword Generic Craftable Keyword 10',
    Sig2Int('GFAC'), 'Guard Faction',
    Sig2Int('GLIK'), 'Gloves Item Keyword',
    Sig2Int('GOLD'), 'Gold',
    Sig2Int('GRIK'), 'Grenade Item Keyword',
    Sig2Int('HBAL'), 'Help Basic Alchemy',
    Sig2Int('HBBR'), 'Help Barter',
    Sig2Int('HBCO'), 'Help Basic Cooking',
    Sig2Int('HBEC'), 'Help Basic Enchanting',
    Sig2Int('HBFG'), 'Help Basic Forging',
    Sig2Int('HBFS'), 'Help Favorites',
    Sig2Int('HBFT'), 'Help Teammate Favor',
    Sig2Int('HBHJ'), 'Help Jail',
    Sig2Int('HBJL'), 'Help Journal',
    Sig2Int('HBLH'), 'Help Low Health',
    Sig2Int('HBLK'), 'Help Basic Lockpicking PC',
    Sig2Int('HBLM'), 'Help Low Magicka',
    Sig2Int('HBLS'), 'Help Low Stamina',
    Sig2Int('HBLU'), 'Help Leveling up',
    Sig2Int('HBLX'), 'Help Basic Lockpicking Console',
    Sig2Int('HBML'), 'Help Basic Smelting',
    Sig2Int('HBMM'), 'Help Map Menu',
    Sig2Int('HBOC'), 'Help Basic Object Creation',
    Sig2Int('HBSA'), 'Help Basic Smithing Armor',
    Sig2Int('HBSK'), 'Help Skills Menu',
    Sig2Int('HBSM'), 'Help Basic Smithing Weapon',
    Sig2Int('HBTA'), 'Help Basic Tanning',
    Sig2Int('HBWC'), 'Help Weapon Charge',
    Sig2Int('HCLL'), 'FormList Hair Color List',
    Sig2Int('HEIK'), 'Helmet Item Keyword',
    Sig2Int('HFSD'), 'Heartbeat Sound Fast',
    Sig2Int('HMPC'), 'Help Manual PC',
    Sig2Int('HMXB'), 'Help Manual XBox',
    Sig2Int('HRSK'), 'Keyword Horse',
    Sig2Int('HSSD'), 'Heartbeat Sound Slow',
    Sig2Int('HVFS'), 'Harvest Failed Sound',
    Sig2Int('HVSS'), 'Harvest Sound',
    Sig2Int('HWIK'), 'Heavy Weapon Item keyword',
    Sig2Int('IMDI'), 'Dialogue Imagespace',
    Sig2Int('IMID'), 'ImageSpaceModifier for inventory menu.',
    Sig2Int('IMLH'), 'Imagespace: Low Health',
    Sig2Int('IMPP'), 'ImageSpaceModifier for Pipboy menu in Power armor.',
    Sig2Int('IOPM'), 'Interface Output Model',
    Sig2Int('JRLF'), 'Jarl Faction',
    Sig2Int('JWLR'), 'Keyword Jewelry',
    Sig2Int('KHFL'), 'Kinect Help FormList',
    Sig2Int('KTRW'), 'Teammate Ready Weapon',
    Sig2Int('KWBR'), 'Color Form',
    Sig2Int('KWCU'), 'Keyword Cuirass',
    Sig2Int('KWDM'), 'Keyword DummyObject',
    Sig2Int('KWDO'), 'Keyword ClearableLocation',
    Sig2Int('KWGE'), 'Keyword UseGeometryEmitter',
    Sig2Int('KWMS'), 'Keyword MustStop',
    Sig2Int('LGH1'), 'Default Light 1',
    Sig2Int('LGH2'), 'Default Light 2',
    Sig2Int('LGH3'), 'Default Light 3',
    Sig2Int('LGH4'), 'Default Light 4',
    Sig2Int('LGHP'), 'Pipboy Light',
    Sig2Int('LKHO'), 'Keyword Hold Location',
    Sig2Int('LKPK'), 'Lockpick',
    Sig2Int('LMHP'), 'Local Map Hide Plane',
    Sig2Int('LRRD'), 'LocRefType Resource Destructible',
    Sig2Int('LRSO'), 'LocRefType Civil War Soldier',
    Sig2Int('LSIS'), 'Imagespace: Load screen',
    Sig2Int('MBIK'), 'Med Bag Item Keyword',
    Sig2Int('MDSC'), 'Music Sound Category',
    Sig2Int('MFSN'), 'Magic Fail Sound',
    Sig2Int('MGGF'), 'Mages'' Guild Faction',
    Sig2Int('MIIK'), 'Mine Item Keyword',
    Sig2Int('MMCL'), 'Main Menu Cell',
    Sig2Int('MMSD'), 'Map Menu Looping Sound',
    Sig2Int('MNTK'), 'Keyword Mount',
    Sig2Int('MTSC'), 'Master Sound Category',
    Sig2Int('MVBL'), 'Keyword Movable',
    Sig2Int('NASD'), 'No-Activation Sound',
    Sig2Int('NDSC'), 'Non-Dialogue Voice Category',
    Sig2Int('NMRD'), 'Road Marker',
    Sig2Int('NPCK'), 'Keyword NPC',
    Sig2Int('NRNT'), 'Keyword Nirnroot',
    Sig2Int('P3OM'), 'Player''s Output Model 3rd Person',
    Sig2Int('PDLC'), 'Pause During Loading Menu Category',
    Sig2Int('PDMC'), 'Pause During Menu Category Fade',
    Sig2Int('PDSA'), 'Putdown Sound Armor',
    Sig2Int('PDSB'), 'Putdown Sound Book',
    Sig2Int('PDSG'), 'Putdown Sound Generic',
    Sig2Int('PDSI'), 'Putdown Sound Ingredient',
    Sig2Int('PDSW'), 'Putdown Sound Weapon',
    Sig2Int('PFAC'), 'Player Faction',
    Sig2Int('PIMC'), 'Pause During Menu Category Immediate',
    Sig2Int('PIVV'), 'Player Is Vampire Variable',
    Sig2Int('PIWV'), 'UNUSED01',
    Sig2Int('PLOC'), 'PersistAll Location',
    Sig2Int('PLST'), 'Default Pack List',
    Sig2Int('POEQ'), 'Potion Equip',
    Sig2Int('POPM'), 'Player''s Output Model 1st Person',
    Sig2Int('PTEM'), 'Package Template',
    Sig2Int('PTFR'), 'PotentialFollower Faction',
    Sig2Int('PTNP'), 'Pathing Test NPC',
    Sig2Int('PUSA'), 'Pickup Sound Armor',
    Sig2Int('PUSB'), 'Pickup Sound Book',
    Sig2Int('PUSG'), 'Pickup Sound Generic',
    Sig2Int('PUSI'), 'Pickup Sound Ingredient',
    Sig2Int('PUSW'), 'Pickup Sound Weapon',
    Sig2Int('PVFA'), 'Player Voice Female',
    Sig2Int('PVFC'), 'Player Voice Female Child',
    Sig2Int('PVMA'), 'Player Voice Male',
    Sig2Int('PVMC'), 'Player Voice Male Child',
    Sig2Int('PWFD'), 'Wait-For-Dialogue Package',
    Sig2Int('QMEA'), 'Quest Marker Enemy Above',
    Sig2Int('QMEB'), 'Quest Marker Enemy Below',
    Sig2Int('QMEN'), 'Quest Marker Enemy',
    Sig2Int('QMFO'), 'Quest Marker Follower',
    Sig2Int('QMLO'), 'Quest Marker Location',
    Sig2Int('RIVR'), 'Vampire Race',
    Sig2Int('RIVS'), 'Vampire Spells',
    Sig2Int('RIWR'), 'UNUSED02',
    Sig2Int('RKIK'), 'Repair Kit Item Keyword',
    Sig2Int('RUSG'), 'Keyword Reusable SoulGem',
    Sig2Int('RVBT'), 'Reverb Type',
    Sig2Int('SALT'), 'Sitting Angle Limit',
    Sig2Int('SAT1'), 'Keyword Scale Actor To 1.0',
    Sig2Int('SCSD'), 'Soul Captured Sound',
    Sig2Int('SFDC'), 'SFX To Fade In Dialogue Category',
    Sig2Int('SFSN'), 'Shout Fail Sound',
    Sig2Int('SKLK'), 'Skeleton Key',
    Sig2Int('SLDM'), 'Snow LOD Material',
    Sig2Int('SLHD'), 'Snow LOD Material HD',
    Sig2Int('SMLT'), 'Keyword Smelter',
    Sig2Int('SMSC'), 'Stats Mute Category',
    Sig2Int('SPFK'), 'Keyword Special Furniture',
    Sig2Int('SSSC'), 'Stats Music',
    Sig2Int('TANN'), 'Keyword Tanning Rack',
    Sig2Int('TKAM'), 'Keyword Type Ammo',
    Sig2Int('TKAR'), 'Keyword Type Armor',
    Sig2Int('TKBK'), 'Keyword Type Book',
    Sig2Int('TKGS'), 'Telekinesis Grab Sound',
    Sig2Int('TKIG'), 'Keyword Type Ingredient',
    Sig2Int('TKKY'), 'Keyword Type Key',
    Sig2Int('TKMS'), 'Keyword Type Misc',
    Sig2Int('TKPT'), 'Keyword Type Potion',
    Sig2Int('TKSG'), 'Keyword Type SoulGem',
    Sig2Int('TKTS'), 'Telekinesis Throw Sound',
    Sig2Int('TKWP'), 'Keyword Type Weapon',
    Sig2Int('TVGF'), 'Thieves'' Guild Faction',
    Sig2Int('UNDK'), 'Keyword Undead',
    Sig2Int('URVT'), 'Underwater Reverb Type',
    Sig2Int('UWLS'), 'Underwater Loop Sound',
    Sig2Int('VAMP'), 'Keyword Vampire',
    Sig2Int('VLOC'), 'Virtual Location',
    Sig2Int('VOEQ'), 'Voice Equip',
    Sig2Int('WASN'), 'Ward Absorb Sound',
    Sig2Int('WBSN'), 'Ward Break Sound',
    Sig2Int('WDSN'), 'Ward Deflect Sound',
    Sig2Int('WEML'), 'Weapon Material List',
    Sig2Int('WMDA'), 'Keyword Weapon Material Daedric',
    Sig2Int('WMDH'), 'Keyword Weapon Material DraugrHoned',
    Sig2Int('WMDR'), 'Keyword Weapon Material Draugr',
    Sig2Int('WMDW'), 'Keyword Weapon Material Dwarven',
    Sig2Int('WMEB'), 'Keyword Weapon Material Ebony',
    Sig2Int('WMEL'), 'Keyword Weapon Material Elven',
    Sig2Int('WMFA'), 'Keyword Weapon Material Falmer',
    Sig2Int('WMFH'), 'Keyword Weapon Material FalmerHoned',
    Sig2Int('WMGL'), 'Keyword Weapon Material Glass',
    Sig2Int('WMIK'), 'Workshop Misc Item Keyword',
    Sig2Int('WMIM'), 'Keyword Weapon Material Imperial',
    Sig2Int('WMIR'), 'Keyword Weapon Material Iron',
    Sig2Int('WMOR'), 'Keyword Weapon Material Orcish',
    Sig2Int('WMST'), 'Keyword Weapon Material Steel',
    Sig2Int('WMWE'), 'World Map Weather',
    Sig2Int('WMWO'), 'Keyword Weapon Material Wood',
    Sig2Int('WPOK'), 'Workshop Player Ownership',
    Sig2Int('WTBA'), 'Keyword WeaponTypeBoundArrow',
    Sig2Int('WWSP'), 'UNUSED03'
  ]);

  c := CombineVarRecs(a, b);

  if wbGameMode = gmFO4VR then begin
    b := MakeVarRecs([
      Sig2Int('TUSW'), 'TUSW',
      Sig2Int('HMVW'), 'HMVW'
    ]);

    c := CombineVarRecs(c, b);
  end;

  wbRecord(DOBJ, 'Default Object Manager', [
    wbEDID,
    wbArrayS(DNAM, 'Objects',
      wbStructSK([0], 'Object', [
        wbInteger('Use', itU32, wbEnum([], c), cpNormalIgnoreEmpty),
        wbFormID('Object ID', cpNormalIgnoreEmpty)
      ]), 0, cpNormalIgnoreEmpty, True, wbDOBJObjectsAfterLoad
    )
  ]);

  wbRecord(LGTM, 'Lighting Template', [
    wbEDID,
    wbStruct(DATA, 'Lighting', [
      wbByteColors('Ambient Color'),
      wbByteColors('Directional Color'),
      wbByteColors('Fog Color Near'),
      wbFloat('Fog Near'),
      wbFloat('Fog Far'),
      wbInteger('Directional Rotation XY', itS32),
      wbInteger('Directional Rotation Z', itS32),
      wbFloat('Directional Fade').SetDefaultEditValue('1.0'),
      wbFloat('Fog Clip Distance'),
      wbFloat('Fog Power').SetDefaultEditValue('1.0'),
      wbUnused(32),
      wbByteColors('Fog Color Far'),
      wbFloat('Fog Max').SetDefaultEditValue('1.0'),
      wbFloat('Light Fade Begin'),
      wbFloat('Light Fade End'),
      wbUnused(4),
      wbFloat('Near Height Mid'),
      wbFloat('Near Height Range').SetDefaultEditValue('10000.0'),
      wbByteColors('Fog Color High Near'),
      wbByteColors('Fog Color High Far'),
      wbFloat('High Density Scale').SetDefaultEditValue('1.0'),
      wbFloat('Fog Near Scale').SetDefaultEditValue('1.0'),
      wbFloat('Fog Far Scale').SetDefaultEditValue('1.0'),
      wbFloat('Fog High Near Scale').SetDefaultEditValue('1.0'),
      wbFloat('Fog High Far Scale').SetDefaultEditValue('1.0'),
      wbFloat('Far Height Mid'),
      wbFloat('Far Height Range')
    ], cpNormal, True, nil, 15),
    wbAmbientColors(DALC).SetRequired,
    wbFormIDCk(WGDR, 'God Rays', [GDRY])
  ]);

  wbRecord(MUSC, 'Music Type', [
    wbEDID,
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      {0x01} 'Plays One Selection',
      {0x02} 'Abrupt Transition',
      {0x04} 'Cycle Tracks',
      {0x08} 'Maintain Track Order',
      {0x10} 'Removal Queued',
      {0x20} 'Ducks Current Track',
      {0x40} 'Doesn''t Queue'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbStruct(PNAM, 'Data', [
      wbInteger('Priority', itU16)
        .SetDefaultEditValue('50'),
      wbInteger('Ducking (dB)', itU16, wbDiv(100))
    ]).SetRequired,
    wbFloat(WNAM, 'Fade Duration')
      .SetRequired,
    wbArray(TNAM, 'Music Tracks', wbFormIDCk('Track', [MUST, NULL]))
  ]);

  wbRecord(FSTP, 'Footstep', [
    wbEDID,
    wbFormIDCk(DATA, 'Impact Data Set', [IPDS, NULL], False, cpNormal, True),
    wbString(ANAM, 'Tag', 0, cpNormal, True)
  ]);

  wbRecord(FSTS, 'Footstep Set', [
    wbEDID,
    wbStruct(XCNT, 'Footstep Counts', [
      wbInteger('Walking Count', itU32),
      wbInteger('Running Count', itU32),
      wbInteger('Sprinting Count', itU32),
      wbInteger('Sneaking Count', itU32),
      wbInteger('Swimming Count', itU32)
    ]).SetRequired,
    wbStruct(DATA, 'Footsteps', [
      wbArray('Swimming Footsteps',
        wbFormIDCk('Footstep', [FSTP])
      ).SetCountPath('..\XCNT\Swimming Count', True),
      wbArray('Sneaking Footsteps',
        wbFormIDCk('Footstep', [FSTP])
      ).SetCountPath('..\XCNT\Sneaking Count', True),
      wbArray('Sprinting Footsteps',
        wbFormIDCk('Footstep', [FSTP])
      ).SetCountPath('..\XCNT\Sprinting Count', True),
      wbArray('Running Footsteps',
        wbFormIDCk('Footstep', [FSTP])
      ).SetCountPath('..\XCNT\Running Count', True),
      wbArray('Walking Footsteps',
        wbFormIDCk('Footstep', [FSTP])
      ).SetCountPath('..\XCNT\Walking Count', True)
    ]).SetRequired
  ]);

  wbRecord(SMBN, 'Story Manager Branch Node', [
    wbEDID,
    wbFormIDCkNoReach(PNAM, 'Parent Node', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCkNoReach(SNAM, 'Previous Node', [SMQN, SMBN, SMEN, NULL], False, cpBenign),
    wbCITCReq,
    wbConditions,
    wbInteger(DNAM, 'Flags', itU32,
      wbFlags([
        'Random',
        'Warn if no child quest started'
      ])
    ).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(XNAM, 'Max concurrent quests', itU32)
  ], False, nil, cpNormal, False, nil, wbConditionsAfterSet);

  wbRecord(SMQN, 'Story Manager Quest Node', [
    wbEDID,
    wbFormIDCkNoReach(PNAM, 'Parent Node', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCkNoReach(SNAM, 'Previous Node', [SMQN, SMBN, SMEN, NULL], False, cpBenign),
    wbCITCReq,
    wbConditions,
    wbInteger(DNAM, 'Flags', itU32,
      wbFlags(wbSparseFlags([
        0, 'Random',
        1, 'Warn if no child quest started',
       16, 'Do all before repeating',
       17, 'Shares event',
       18, 'Num quests to run'
      ]))
    ).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(XNAM, 'Max concurrent quests', itU32),
    wbInteger(MNAM, 'Num quests to run', itU32),
    wbFloat(HNAM, 'Hours until reset'),
    wbInteger(QNAM, 'Quest Count', itU32, nil, cpBenign, True),
    wbRArray('Quests',
      wbRStructSK([0], 'Quest', [
        wbFormIDCk(NNAM, 'Quest', [QUST]),
        wbFloat(RNAM, 'Hours until reset', cpNormal, False, 1/24)
      ])
    ).SetCountPath(QNAM)
  ], False, nil, cpNormal, False, nil, wbConditionsAfterSet);

  wbRecord(SMEN, 'Story Manager Event Node', [
    wbEDID,
    wbFormIDCkNoReach(PNAM, 'Parent Node', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCkNoReach(SNAM, 'Previous Node', [SMQN, SMBN, SMEN, NULL], False, cpBenign),
    wbCITCReq,
    wbConditions,
    wbInteger(DNAM, 'Flags', itU32,
      wbFlags([
        'Random',
        'Warn if no child quest started'
      ])
    ).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(XNAM, 'Max concurrent quests', itU32),
    wbInteger(ENAM, 'Type', itU32, wbQuestEventEnum)
  ], False, nil, cpNormal, False, nil, wbConditionsAfterSet)
    .SetSummaryKey([7]);

  wbRecord(DLBR, 'Dialog Branch', [
    wbEDID,
    wbFormIDCk(QNAM, 'Quest', [QUST], False, cpNormal, True),
    wbInteger(TNAM, 'Category', itU32, wbEnum([
        {0} 'Player',
        {1} 'Command'
    ])),
    wbInteger(DNAM, 'Flags', itU32, wbFlags([
      {0x01} 'Top-Level',
      {0x02} 'Blocking',
      {0x04} 'Exclusive'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbFormIDCk(SNAM, 'Starting Topic', [DIAL], False, cpNormal, True)
  ]).SetAddInfo(wbDLBRAddInfo);

  wbRecord(MUST, 'Music Track', [
    wbEDID,
    wbInteger(CNAM, 'Track Type', itU32, wbEnum([], [
      Int64($23F678C3), 'Palette Track',
      Int64($6ED7E048), 'Single Track',
      Int64($A1A9C4D5), 'Silent Track'
    ]), cpNormal, True)
      .SetDefaultEditValue('Palette Track'),
    wbFloat(FLTV, 'Duration')
      .SetRequired,
    wbFloat(DNAM, 'Fade-Out'),
    wbString(ANAM, 'Track FileName'),
    wbString(BNAM, 'Finale FileName'),
    wbStruct(LNAM, 'Loop Data', [
      wbFloat('Loop Begins'),
      wbFloat('Loop Ends'),
      wbInteger('Loop Count', itU32)
    ]),
    wbArray(FNAM, 'Cue Points', wbFloat('Point')).IncludeFlag(dfNotAlignable),
    wbCITC,
    wbConditions,
    wbArray(SNAM, 'Tracks', wbFormIDCk('Track', [MUST, NULL]))
  ], False, nil, cpNormal, False, nil, wbConditionsAfterSet);

  wbRecord(DLVW, 'Dialog View', [
    wbEDID,
    wbFormIDCk(QNAM, 'Quest', [QUST]),
    wbFormIDCk(BNAM, 'Branch', [DLBR]),
    wbUnused(ENAM),
    wbUnused(DNAM)
  ]);

  {wbRecord(WOOP, 'Word of Power', [
    wbEDID
  ]);}

  {wbRecord(SHOU, 'Shout', [
    wbEDID
  ]);}

  wbRecord(EQUP, 'Equip Type', [
    wbEDID,
    wbArray(PNAM, 'Slot Parents', wbFormIDCk('Parent', [EQUP])),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      'Use All Parents',
      'Parents Optional',
      'Item Slot'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
      .SetRequired,
    wbFormIDCk(ANAM, 'Condition Actor Value', [AVIF, NULL, FFFF])
      .SetRequired
  ]);

  wbRecord(RELA, 'Relationship', [
    wbEDID,
    wbStruct(DATA, 'Data', [
      wbFormIDCk('Parent', [NPC_, NULL]),
      wbFormIDCk('Child', [NPC_, NULL]),
      wbInteger('Rank', itU8, wbEnum([
        'Lover',
        'Ally',
        'Confidant',
        'Friend',
        'Acquaintance',
        'Rival',
        'Foe',
        'Enemy',
        'Archnemesis'
      ])).SetDefaultEditValue('Friend'),
      wbByteArray('Unknown', 2),
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'Unknown 1',
        {0x02} 'Unknown 2',
        {0x04} 'Unknown 3',
        {0x08} 'Unknown 4',
        {0x10} 'Unknown 5',
        {0x20} 'Unknown 6',
        {0x40} 'Unknown 7',
        {0x80} 'Secret'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFormIDCk('Association Type', [ASTP, NULL])
    ]).SetRequired
  ]);

  wbRecord(SCEN, 'Scene', [
    wbEDID,
    wbVMADFragmentedSCEN,
    wbInteger(FNAM, 'Flags', itU32,
      wbFlags([
      {0}  'Begin on Quest Start',
      {1}  'Stop on Quest End',
      {2}  'Show All Text',
      {3}  'Repeat Conditions While True',
      {4}  'Interruptible',
      {5}  'Has Player Dialogue',
      {6}  'Prevent Player Exit Dialogue',
      {7}  'Unknown 7',
      {8}  'Unknown 8', // Often present with the 'Radio' Action type
      {9}  'Pause Actors Current Scenes',
      {10} 'Unknown 10',
      {11} 'Disable Dialogue Camera',
      {12} 'No Follower Idle Chatter'
      ])
    ).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbRArray('Phases',
      wbRStruct('Phase', [
        wbEmpty(HNAM, 'Marker Phase Start').SetRequired,
        wbString(NAM0, 'Name', 0).SetRequired,
        wbRStruct('Start Conditions', [wbConditions]),
        wbEmpty(NEXT, 'Marker Start Conditions').SetRequired,
        wbRStruct('Completion Conditions', [wbConditions]),
        wbEmpty(NEXT, 'Marker Completion Conditions').SetRequired,
        wbInteger(WNAM, 'Editor Width', itU32)
          .SetDefaultNativeValue(350)
          .SetRequired,
        wbInteger(FNAM, 'Flags', itU16,
          wbFlags([
          {0} 'Start - WalkAway Phase',
          {1} 'Don''t Run End Scripts on Scene Jump',
          {2} 'Start - Inherit In Templated Scenes'
          ])
        ).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbStruct(SCQS, 'Set Parent Quest Stage', [
          wbInteger('On Start', itS16),
          wbInteger('On Completion', itS16)
        ]),
        wbEmpty(HNAM, 'Marker Phase End').SetRequired
      ])
    ),
    wbRArray('Actors',
      wbRStruct('Actor', [
        wbInteger(ALID, 'Actor ID', itS32, wbSceneAliasToStr, wbAliasToInt)
          .SetDefaultNativeValue(-1)
          .SetLinksToCallbackOnValue(wbSCENAliasLinksTo)
          .SetRequired,
        wbInteger(LNAM, 'Flags', itU32,
          wbFlags([
          {0} 'No Player Activation',
          {1} 'Optional',
          {2} 'Run Only Scene Packages',
          {3} 'No Command State'
          ])
        ).IncludeFlag(dfCollapsed, wbCollapseFlags)
         .SetRequired,
        wbInteger(DNAM, 'Behaviour Flags', itU32,
          wbFlags([
          {0} 'Death Pause',
          {1} 'Death End',
          {2} 'Combat Pause',
          {3} 'Combat End',
          {4} 'Dialogue Pause',
          {5} 'Dialogue End',
          {6} 'OBS_COM Pause',
          {7} 'OBS_COM End'
          ])
        ).SetDefaultNativeValue(26)
         .SetRequired
         .IncludeFlag(dfCollapsed, wbCollapseFlags)
      ])),
    wbRArray('Actions',
      wbRStructSK([0, 1, 3, 4], 'Action', [
        wbInteger(ANAM, 'Type', itU16,
          wbEnum([
          {0} 'Dialogue',
          {1} 'Package',
          {2} 'Timer',
          {3} 'Player Dialogue',
          {4} 'Start Scene',
          {5} 'NPC Response Dialogue',
          {6} 'Radio'
          ])
        ).IncludeFlag(dfIncludeValueInDisplaySignature)
         .SetAfterSet(wbSceneActionTypeAfterSet)
         .SetRequired,
        wbString(NAM0, 'Name'),
        wbInteger(ALID, 'Actor ID', itS32, wbSceneAliasToStr, wbAliasToInt)
          .SetDefaultNativeValue(-1)
          .SetLinksToCallbackOnValue(wbSCENAliasLinksTo)
          .SetRequired,
        wbInteger(INAM, 'Index', itU32),
        wbInteger(FNAM, 'Flags', itU32,
          wbFlags([
          {0}  'Unknown 0',
          {1}  'Unknown 1',
          {2}  'Unknown 2',
          {3}  'Unknown 3',
          {4}  'Unknown 4',
          {5}  'Unknown 5',
          {6}  'Unknown 6',
          {7}  'Player Positive Use Dialogue Subtype / Hold Into Next Scene',
          {8}  'Player Negative Use Dialogue Subtype',
          {9}  'Player Neutral Use Dialogue Subtype',
          {10} 'Use Dialogue Subtype',
          {11} 'Player Question Use Dialogue Subtype',
          {12} 'Keep/Clear Target on Action End',
          {13} 'Unknown 13',
          {14} 'Run on End of Phase',
          {15} 'Face Target',
          {16} 'Looping',
          {17} 'Headtrack Player',
          {18} 'Unknown 18',
          {19} 'Ignore For Completion',
          {20} 'Unknown 20',
          {21} 'Camera Speaker Target',
          {22} 'Complete Face Target',
          {23} 'Unknown 23',
          {24} 'Unknown 24',
          {25} 'Unknown 25',
          {26} 'Unknown 26',
          {27} 'NPC Positive Use Dialogue Subtype',
          {28} 'NPC Negative Use Dialogue Subtype',
          {29} 'NPC Neutral Use Dialogue Subtype',
          {30} 'NPC Question Use Dialogue Subtype'
          ])
        ).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbInteger(SNAM, 'Start Phase', itU32),
        wbInteger(ENAM, 'End Phase', itU32),
        wbRUnion('Type Specific Action', wbSceneActionTypeDecider, [
        {0} wbRStruct('Dialogue', [
            wbFormIDCk(DATA, 'Topic', [DIAL,NULL]),
            wbFloat(DMAX, 'Looping - Max'),
            wbFloat(DMIN, 'Looping - Min'),
            wbStruct(CRIS, 'Camera', [
              wbFloat('FOV On Player Camera'),
              wbFloat('Rate Of Camera Change')
            ]),
            wbInteger(DEMO, 'Emotion Type', itU32, wbEmotionTypeEnum),
            wbInteger(DEVA, 'Emotion Value', itU32),
            wbArray(HTID, 'Player Headtracking',
              wbInteger('Actor ID', itS32, wbSceneAliasToStr, wbAliasToInt)
                .SetDefaultNativeValue(-1)
                .SetLinksToCallback(wbSCENAliasLinksTo)),
            wbFormIDCk(VENC, 'Dialogue Subtype', [KYWD]),
            wbFormIDCk(ONAM, 'Audio Output Override', [SOPM]),
            wbFormIDCk(PNAM, 'AnimArchType', [KYWD])
          ]).IncludeFlag(dfAllowAnyMember)
            .IncludeFlag(dfStructFirstNotRequired),
        {1} wbRStruct('Package', [
              wbRArray('Packages', wbFormIDCk(PNAM, 'Package', [PACK]))
            ]),
        {2} wbRStruct('Timer', [
              wbFloat(SNAM, 'Timer - Max Seconds'),
              wbInteger(SCQS, 'Set Parent Quest Stage', itS16),
              wbFloat(TNAM, 'Timer - Min Seconds')
            ]),
        {3} wbRStruct('Player Dialogue', [
              wbFormIDCk(PTOP, 'Player Positive Response', [DIAL]),
              wbFormIDCk(NTOP, 'Player Negative Response', [DIAL]),
              wbFormIDCk(NETO, 'Player Neutral Response', [DIAL]),
              wbFormIDCk(QTOP, 'Player Question Response', [DIAL]),
              wbFormIDCk(VENC, 'Player Positive Dialogue Subtype', [KYWD]),
              wbFormIDCk(PLVD, 'Player Negative Dialogue Subtype', [KYWD]),
              wbFormIDCk(JOUT, 'Player Neutral Dialogue Subtype', [KYWD]),
              wbFormIDCk(DALC, 'Player Question Dialogue Subtype', [KYWD]),
              wbArray(DTID, 'NPC Headtracking',
                wbInteger('Actor ID', itS32, wbSceneAliasToStr, wbAliasToInt)
                  .SetDefaultNativeValue(-1)
                  .SetLinksToCallback(wbSCENAliasLinksTo)),
              wbFormIDCk(ONAM, 'Audio Output Override', [SOPM]),
              wbFormIDCk(NPOT, 'NPC Positive Response', [DIAL]),
              wbFormIDCk(NNGT, 'NPC Negative Response', [DIAL]),
              wbFormIDCk(NNUT, 'NPC Neutral Response', [DIAL]),
              wbFormIDCk(NQUT, 'NPC Question Response', [DIAL]),
              wbFormIDCk(NPOS, 'NPC Positive Dialogue Subtype', [KYWD]),
              wbFormIDCk(NNGS, 'NPC Negative Dialogue Subtype', [KYWD]),
              wbFormIDCk(NNUS, 'NPC Neutral Dialogue Subtype', [KYWD]),
              wbFormIDCk(NQUS, 'NPC Question Dialogue Subtype', [KYWD]),
              wbInteger(DTGT, 'Dialogue Target Actor', itS32, wbSceneAliasToStr, wbAliasToInt)
                .SetDefaultNativeValue(-1)
                .SetLinksToCallbackOnValue(wbSCENAliasLinksTo)
            ]).IncludeFlag(dfAllowAnyMember)
              .IncludeFlag(dfStructFirstNotRequired),
        {4} wbRStruct('Start Scene', [
              wbFormIDCk(STSC, 'Topic?', [DIAL,NULL]), // CK Error claims this is a "Topic"
              wbRArray('Start Scenes', wbRStruct('Start Scene', [
                wbFormIDCk(LCEP, 'Scene', [SCEN]),
                wbInteger(INTT, 'Phase Index', itU16),
                wbString(SSPN, 'Start Phase for Scene'),
                wbCITC,
                wbConditions
              ])),
              wbEmpty(HTID, 'End Scene Say Greeting')
            ]).IncludeFlag(dfAllowAnyMember)
              .IncludeFlag(dfStructFirstNotRequired),
        {5} wbRStruct('NPC Response Dialogue', [
              wbFormIDCk(PTOP, 'Player Positive Response', [DIAL]),
              wbFormIDCk(NTOP, 'Player Negative Response', [DIAL]),
              wbFormIDCk(NETO, 'Player Neutral Response', [DIAL]),
              wbFormIDCk(QTOP, 'Player Question Response', [DIAL]),
              wbFormIDCk(VENC, 'Player Positive Dialogue Subtype', [KYWD]),
              wbFormIDCk(PLVD, 'Player Negative Dialogue Subtype', [KYWD]),
              wbFormIDCk(JOUT, 'Player Neutral Dialogue Subtype', [KYWD]),
              wbFormIDCk(DALC, 'Player Question Dialogue Subtype', [KYWD]),
              wbArray(DTID, 'NPC Headtracking',
                wbInteger('Actor ID', itS32, wbSceneAliasToStr, wbAliasToInt)
                  .SetDefaultNativeValue(-1)
                  .SetLinksToCallback(wbSCENAliasLinksTo)),
              wbFormIDCk(ONAM, 'Audio Output Override', [SOPM])
            ]).IncludeFlag(dfAllowAnyMember)
              .IncludeFlag(dfStructFirstNotRequired),
        {6} wbRStruct('Radio', [
              wbFormIDCk(DATA, 'Topic', [DIAL, NULL]),
              wbFormIDCk(HTID, 'Play Sound', [SNDR, NULL]),
              wbFloat(DMAX, 'Looping - Max'),
              wbFormIDCk(VENC, 'Dialogue Subtype', [KYWD])
            ]).IncludeFlag(dfAllowAnyMember)
              .IncludeFlag(dfStructFirstNotRequired)
        ]),
        wbMarkerReq(ANAM)
      ])),
    wbFormIDCk(PNAM, 'Parent Quest', [QUST]).SetRequired,
    wbInteger(INAM, 'Last Action Index', itU32),
    wbStruct(VNAM, 'Actor Behavior Settings', [
      wbInteger('Death', itU32,
        wbEnum([
        {0} 'Set All Normal',
        {1} '',
        {2} 'Set All End',
        {3} 'Don''t Set All'
        ])),
      wbInteger('Combat', itU32, wbActorBehaviorEnum),
      wbInteger('Player Dialogue', itU32, wbActorBehaviorEnum)
        .SetAfterLoad(wbSCENBehaviorEnumAfterLoad),
      wbInteger('Observe Combat', itU32, wbActorBehaviorEnum)
        .SetAfterLoad(wbSCENBehaviorEnumAfterLoad)
    ]),
    wbFloat(CNAM, 'Camera Distance Override'),
    wbFloat(ACTV, 'Dialogue Distance Override'),
    wbFloat(CRIS, 'FOV Override'),
    wbKeywords,
    wbConditions,
    wbStruct(SCQS, 'Set Parent Quest Stage', [
      wbInteger('On Begin', itS16),
      wbInteger('On End', itS16)
    ]),
    wbString(NNAM, 'Notes'),
    wbFormIDCk(TNAM, 'Template Scene', [SCEN]),
    wbInteger(XNAM, 'Index', itU32)
  ]).SetAddInfo(wbSCENAddInfo);

  wbRecord(ASTP, 'Association Type', [
    wbEDID,
    wbString(MPRT, 'Male Parent Title'),
    wbString(FPRT, 'Female Parent Title'),
    wbString(MCHT, 'Male Child Title'),
    wbString(FCHT, 'Female Child Title'),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      'Family Association'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
      .SetRequired
  ]);

  wbSPED := wbUnion(SPED, 'Movement Data', wbFormVersionDecider([28, 60, 104]), [
 {0}wbStruct('', [
      wbStruct('Left', [
        wbUnused,
        wbFloat('Walk'),
        wbFloat('Run'),
        wbUnused
      ]),
      wbStruct('Right', [
        wbUnused,
        wbFloat('Walk'),
        wbFloat('Run'),
        wbUnused
      ]),
      wbStruct('Forward', [
        wbUnused,
        wbFloat('Walk'),
        wbFloat('Run'),
        wbUnused
      ]),
      wbStruct('Back', [
        wbUnused,
        wbFloat('Walk'),
        wbFloat('Run'),
        wbUnused
      ]),

      wbStruct('Pitch, Roll, Yaw', [
        wbUnused,
        wbFloatAngle('Walk'),
        wbFloatAngle('Run'),
        wbUnused
      ]),

      wbStruct('Unused', [
        wbUnused,
        wbUnused,
        wbUnused,
        wbUnused
      ]),

      wbStruct('Unused', [
        wbUnused,
        wbUnused,
        wbUnused,
        wbUnused
      ]),

      wbUnused,
      wbUnused,
      wbUnused
    ], cpNormal, True),
 {1}wbStruct('', [
      wbStruct('Left', [
        wbUnused,
        wbFloat('Walk'),
        wbFloat('Run'),
        wbUnused
      ]),
      wbStruct('Right', [
        wbUnused,
        wbFloat('Walk'),
        wbFloat('Run'),
        wbUnused
      ]),
      wbStruct('Forward', [
        wbUnused,
        wbFloat('Walk'),
        wbFloat('Run'),
        wbUnused
      ]),
      wbStruct('Back', [
        wbUnused,
        wbFloat('Walk'),
        wbFloat('Run'),
        wbUnused
      ]),

      wbStruct('Pitch, Roll, Yaw', [
        wbUnused,
        wbFloatAngle('Walk'),
        wbFloatAngle('Run'),
        wbUnused
      ]),

      wbStruct('Unused', [
        wbUnused,
        wbUnused,
        wbUnused,
        wbUnused
      ]),

      wbStruct('Unused', [
        wbUnused,
        wbUnused,
        wbUnused,
        wbUnused
      ]),

      wbFloatAngle,
      wbUnused,
      wbUnused
    ], cpNormal, True),
 {2}wbStruct('', [
      wbStruct('Left', [
        wbUnused,
        wbFloat('Walk'),
        wbFloat('Run'),
        wbUnused
      ]),
      wbStruct('Right', [
        wbUnused,
        wbFloat('Walk'),
        wbFloat('Run'),
        wbUnused
      ]),
      wbStruct('Forward', [
        wbUnused,
        wbFloat('Walk'),
        wbFloat('Run'),
        wbUnused
      ]),
      wbStruct('Back', [
        wbUnused,
        wbFloat('Walk'),
        wbFloat('Run'),
        wbUnused
      ]),

      wbStruct('Pitch', [
        wbUnused,
        wbFloatAngle('Walk'),
        wbFloatAngle('Run'),
        wbUnused
      ]),

      wbStruct('Roll', [
        wbUnused,
        wbFloatAngle('Walk'),
        wbFloatAngle('Run'),
        wbUnused
      ]),

      wbStruct('Yaw', [
        wbUnused,
        wbFloatAngle('Walk'),
        wbFloatAngle('Run'),
        wbUnused
      ]),

      wbFloatAngle('Unknown'),
      wbFloatAngle('Unknown'),
      wbFloatAngle('Unknown')
    ], cpNormal, True),
 {3}wbStruct('', [
      wbStruct('Left', [
        wbFloat('Standing'),
        wbFloat('Walk'),
        wbFloat('Run'),
        wbFloat('Sprint')
      ]),

      wbStruct('Right', [
        wbFloat('Standing'),
        wbFloat('Walk'),
        wbFloat('Run'),
        wbFloat('Sprint')
      ]),

      wbStruct('Forward', [
        wbFloat('Standing'),
        wbFloat('Walk'),
        wbFloat('Run'),
        wbFloat('Sprint')
      ]),

      wbStruct('Back', [
        wbFloat('Standing'),
        wbFloat('Walk'),
        wbFloat('Run'),
        wbFloat('Sprint')
      ]),

      wbStruct('Pitch', [
        wbFloatAngle('Standing'),
        wbFloatAngle('Walk'),
        wbFloatAngle('Run'),
        wbFloatAngle('Sprint')
      ]),

      wbStruct('Roll', [
        wbFloatAngle('Standing'),
        wbFloatAngle('Walk'),
        wbFloatAngle('Run'),
        wbFloatAngle('Sprint')
      ]),

      wbStruct('Yaw', [
        wbFloatAngle('Standing'),
        wbFloatAngle('Walk'),
        wbFloatAngle('Run'),
        wbFloatAngle('Sprint')
      ]),

      wbUnused,
      wbUnused,
      wbUnused
    ], cpNormal, True)
  ]);

  wbRecord(OTFT, 'Outfit', [
    wbEDID,
    wbArrayS(INAM, 'Items', wbFormIDCk('Item', [ARMO, LVLI]))
  ]);

  wbRecord(ARTO, 'Art Object', [
    wbEDID,
    wbOBND(True),
    wbPTRN,
    wbKeywords,
    wbGenericModel,
    wbInteger(DNAM, 'Art Type', itU32, wbEnum([
      'Magic Casting',
      'Magic Hit Effect',
      'Enchantment Effect'
    ]))
  ]);

  wbRecord(MATO, 'Material Object', [
    wbEDID,
    wbGenericModel,
    wbRArray('Property Data',
      wbByteArray(DNAM, 'Data', 0, cpIgnore, False, False, wbNeverShow)
    ),
    wbStruct(DATA, 'Directional Material Data', [
      wbFloat('Falloff Scale'),
      wbFloat('Falloff Bias').SetDefaultEditValue('0.4'),
      wbFloat('Noise UV Scale').SetDefaultEditValue('512.0'),
      wbFloat('Material UV Scale').SetDefaultEditValue('512.0'),
      wbVec3('Projection Vector'),
      wbFromVersion(19, wbFloat('Normal Dampener')).SetDefaultEditValue('1.0'),
      wbFromVersion(25, wbFloatColors('Single Pass Color')),
      wbFromVersion(31, wbInteger('Single Pass', itU32, wbBoolEnum))
    ]).SetRequired
  ]);

  wbRecord(MOVT, 'Movement Type', [
    wbEDID,
    wbString(MNAM, 'Name'),
    wbSPED,
    wbStruct(INAM, 'Anim Change Thresholds (unused)', [
      wbFloat('Directional', cpNormal, True, 180/Pi),
      wbFloat('Movement Speed'),
      wbFloat('Rotation Speed', cpNormal, True, 180/Pi)
    ]),
    wbFloat(JNAM, 'Float Height'),
    wbFloat(LNAM, 'Flight - Angle Gain').SetDefaultEditValue('0.1')
  ]);

  wbRecord(SNDR, 'Sound Descriptor', [
    wbEDID,
    wbString(NNAM, 'Notes'),
    wbInteger(CNAM, 'Descriptor Type', itU32, wbEnum([], [
      Int64($1EEF540A), 'Standard',
      Int64($54651A43), 'Compound',
      Int64($ED157AE3), 'AutoWeapon'
    ])),
    wbFormIDCk(GNAM, 'Category', [SNCT]),
    wbFormIDCk(SNAM, 'Alternate Sound For', [SNDR]),
    wbSoundDescriptorSounds,
    wbFormIDCk(ONAM, 'Output Model', [SOPM]),
    wbConditions,
    wbStruct(LNAM, 'Values', [
      wbByteArray('Unknown', 1),
      wbInteger('Looping', itU8, wbEnum([], [
        $00, 'None',
        $08, 'Loop',
        $10, 'Envelope Fast',
        $20, 'Envelope Slow'
      ])),
      wbInteger('Sidechain', itU8),
      wbInteger('Rumble Send Value = (Small / 7) + ((Big / 7) * 16)', itU8)
    ]),
    wbUnion(BNAM, 'Data', wbSNDRDataDecider, [
      wbStruct('Values', [
        wbInteger('% Frequency Shift', itS8),
        wbInteger('% Frequency Variance', itS8),
        wbInteger('Priority', itU8),
        wbInteger('db Variance', itU8),
        wbInteger('Static Attenuation (db)', itU16, wbDiv(100))
      ]),
      wbFormIDCk('Base Descriptor', [SNDR])
    ]),
    wbRArray('Descriptors', wbFormIDCk(DNAM, 'Descriptor', [SNDR])),
    wbInteger(ITMC, 'Count', itU32, nil, cpBenign),
    wbRArrayS('Rates of Fire',
      wbRStructSK([1], 'Sound', [
        wbEmpty(ITMS, 'Marker Start'),
        wbInteger(INTV, 'RoF (RPM)', itU32),
        wbString(FNAM, 'File'),
        wbEmpty(ITME, 'Marker End')
      ]),
      cpNormal, False, nil, wbSNDRRatesOfFireAfterSet
    )
  ]);

  wbRecord(DUAL, 'Dual Cast Data', [
    wbEDID,
    wbOBND(True),
    wbStruct(DATA, 'Data', [
      wbFormIDCk('Projectile', [PROJ, NULL]),
      wbFormIDCk('Explosion', [EXPL, NULL]),
      wbFormIDCk('Effect Shader', [EFSH, NULL]),
      wbFormIDCk('Hit Effect Art', [ARTO, NULL]),
      wbFormIDCk('Impact Data Set', [IPDS, NULL]),
      wbInteger('Inherit Scale', itU32, wbFlags([
        'Hit Effect Art',
        'Projectile',
        'Explosion'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ], cpNormal, True)
  ]);

  wbRecord(SNCT, 'Sound Category', [
    wbEDID,
    wbFULL,
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      {0x0000001} 'Mute When Submerged',
      {0x0000002} 'Should Appear on Menu',
      {0x0000004} 'Immune to Time Speedup',
      {0x0000008} 'Pause During Menus (Immed)',
      {0x0000010} 'Pause During Menus (Fade)',
      {0x0000020} 'Exclude from Player OPM Override',
      {0x0000040} 'Pause During Start Menu'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbFormIDCk(PNAM, 'Parent Category', [SNCT]),
    wbFormIDCk(ONAM, 'Menu Slider Category', [SNCT]),
    wbInteger(VNAM, 'Static Volume Multiplier', itU16, wbDiv(65535)).SetDefaultEditValue('1.0'),
    wbInteger(UNAM, 'Default Menu Value', itU16, wbDiv(65535)).SetDefaultEditValue('1.0'),
    wbFloat(MNAM, 'Min Frequency Multiplier').SetDefaultEditValue('0.1'),
    wbFloat(CNAM, 'Sidechain Target Multiplier').SetDefaultEditValue('1.0')
  ]);

  wbRecord(SOPM, 'Sound Output Model', [
    wbEDID,
    wbStruct(NAM1, 'Data', [
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'Attenuates With Distance',
        {0x02} 'Allows Rumble',
        {0x04} 'Applies Doppler',
        {0x08} 'Applies Distance Delay',
        {0x10} 'Player Output Model',
        {0x20} 'Try Play on Controller',
        {0x40} 'Causes Ducking',
        {0x80} 'Avoids Ducking'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbByteArray('Unknown', 2),
      wbInteger('Reverb Send %', itU8)
    ]),
    wbInteger(MNAM, 'Type', itU32, wbEnum([
      'Uses HRTF',
      'Defined Speaker Output'
    ])),
    wbInteger(VNAM, 'Static Attenuation', itS16, wbDiv(100)),
    wbStruct(ONAM, 'Output Values', [
      wbArray('Channels', wbStruct('', [
        wbInteger('FL', itU8).SetDefaultEditValue('100'),
        wbInteger('FR', itU8).SetDefaultEditValue('100'),
        wbInteger('C', itU8),
        wbInteger('LFE', itU8),
        wbInteger('RL', itU8).SetDefaultEditValue('50'),
        wbInteger('RR', itU8).SetDefaultEditValue('50'),
        wbInteger('SL', itU8).SetDefaultEditValue('50'),
        wbInteger('SR', itU8).SetDefaultEditValue('50')
      ]), [
        'Channel 0',
        'Channel 1',
        'Channel 2? (unused)'
      ])
    ]),
    wbStruct(ATTN, 'Dynamic Attenuation Values', [
      wbFloat('Fade In Distance - Start'),
      wbFloat('Fade In Distance - End'),
      wbFloat('Fade Out Distance - Start'),
      wbFloat('Fade Out Distance - End'),
      wbStruct('Fade In Curve', [
        wbInteger('Value 1', itU8),
        wbInteger('Value 2', itU8).SetDefaultEditValue('50'),
        wbInteger('Value 3', itU8).SetDefaultEditValue('80'),
        wbInteger('Value 4', itU8).SetDefaultEditValue('95')
      ]),
      wbStruct('Fade Out Curve', [
        wbInteger('Value 1', itU8).SetDefaultEditValue('50'),
        wbInteger('Value 2', itU8).SetDefaultEditValue('20'),
        wbInteger('Value 3', itU8).SetDefaultEditValue('5'),
        wbInteger('Value 4', itU8)
      ])
    ]),
    wbFormIDCk(ENAM, 'Effect Chain', [AECH])
  ]);

  wbRecord(COLL, 'Collision Layer', [
    wbEDID,
    wbDESCReq,
    wbInteger(BNAM, 'Index', itU32, nil, cpNormal, True),
    wbByteColors(FNAM, 'Debug Color'),
    wbInteger(GNAM, 'Flags', itU32, wbFlags([
      {0x00000001} 'Trigger Volume',
      {0x00000002} 'Sensor',
      {0x00000004} 'Navmesh Obstacle'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbString(MNAM, 'Name', 0, cpNormal, True),
    wbInteger(INTV, 'Interactables Count', itU32, nil, cpNormal, True),
    wbArrayS(CNAM, 'Collides With', wbFormIDCk('Forms', [COLL]), 0, cpNormal, False)
  ]).SetBuildIndexKeys(procedure(const aMainRecord: IwbMainRecord; var aIndexKeys: TwbIndexKeys)
     begin
       if not Assigned(aMainRecord) then
         Exit;

       var lBNAM := aMainRecord.ElementNativeValues[BNAM];
       if not VarIsOrdinal(lBNAM) then
         Exit;

       aIndexKeys.Keys[wbIdxCollisionLayer] := lBNAM;
     end);

  wbRecord(CLFM, 'Color',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Non-Playable'
    ])), [
    wbEDID,
    wbFULL,
    // union decider doesn't work during copying since decision data FNAM is located after it
    // workaround using integer formatters
    wbInteger(CNAM, 'Color/Index', itU32, wbCLFMColorToStr, wbCLFMColorToInt),
    {wbUnion(CNAM, 'Value', wbCLFMColorDecider, [
      wbByteColors('Color'),
      wbFloat('Remapping Index')
    ]),}
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      'Playable',
      'Remapping Index',
      'Extended LUT'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbConditions
  ]);

  wbRecord(REVB, 'Reverb Parameters', [
    wbEDID,
    wbStruct(DATA, 'Data', [
      wbInteger('Decay Time (ms)', itU16).SetDefaultEditValue('1250'),
      wbInteger('HF Reference (Hz)', itU16).SetDefaultEditValue('800'),
      wbInteger('Room Filter', itS8),
      wbInteger('Room HF Filter', itS8),
      wbInteger('Reflections', itS8),
      wbInteger('Reverb Amp', itS8),
      wbInteger('Decay HF Ratio', itU8, wbDiv(100)).SetDefaultEditValue('1.0'),
      wbInteger('Reflect Delay (ms), scaled', itU8),
      wbInteger('Reverb Delay (ms)', itU8),
      wbInteger('Diffusion %', itU8).SetDefaultEditValue('100'),
      wbInteger('Density %', itU8).SetDefaultEditValue('100'),
      wbInteger('Unknown', itU8)
    ], cpNormal, True),
    wbInteger(ANAM, 'Reverb Class', itU32, wbReverbClassEnum, cpNormal, True)
  ]);

  wbRecord(GRAS, 'Grass', [
    wbEDID,
    wbOBND(True),
    wbGenericModel,
    wbStruct(DATA, '', [
      wbInteger('Density', itU8).SetDefaultEditValue('30'),
      wbInteger('Min Slope', itU8),
      wbInteger('Max Slope', itU8).SetDefaultEditValue('90'),
      wbUnused(1),
      wbInteger('Units From Water', itU16),
      wbUnused(2),
      wbInteger('Units From Water Type', itU32, wbEnum([
        'Above - At Least',
        'Above - At Most',
        'Below - At Least',
        'Below - At Most',
        'Either - At Least',
        'Either - At Most',
        'Either - At Most Above',
        'Either - At Most Below'
      ])),
      wbFloat('Position Range').SetDefaultEditValue('32.0'),
      wbFloat('Height Range').SetDefaultEditValue('0.2'),
      wbFloat('Color Range').SetDefaultEditValue('0.5'),
      wbFloat('Wave Period').SetDefaultEditValue('10.0'),
      wbInteger('Flags', itU8, wbFlags([
        'Vertex Lighting',
        'Uniform Scaling',
        'Fit to Slope'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbUnused(3)
    ], cpNormal, True)
  ]);

  wbRecord(IDLE, 'Idle Animation', [
    wbEDID,
    wbConditions,
    wbString(DNAM, 'Behavior Graph'),
    wbString(ENAM, 'Animation Event'),
    wbStruct(ANAM, 'Animations', [
      wbFormIDCk('Parent', [AACT, IDLE, NULL], False, cpBenign),
      wbFormIDCk('Previous', [AACT, IDLE, NULL], False, cpBenign)
    ]).SetRequired,
    wbStruct(DATA, '', [
      wbStruct('Looping seconds (both 255 forever)', [
        wbInteger('Min', itU8),
        wbInteger('Max', itU8)
      ]),
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'Parent',
        {0x02} 'Sequence',
        {0x04} 'No Attacking',
        {0x04} 'Blocking'
      ], True)).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Animation Group Section', itU8{, wbIdleAnam}),
      wbInteger('Replay Delay', itU16)
    ], cpNormal, True),
    wbString(GNAM, 'Animation File')
  ]);

  wbRecord(INFO, 'Dialog response',
    wbFlags(wbFlagsList([
      {0x00000040}  6, 'Info Group',
      {0x00000080}  7, 'Exclude From Export',
      {0x00002000} 13, 'Actor Changed'
    ])), [
    wbEDID,
    wbVMADFragmentedINFO,
    wbStruct(ENAM, 'Response flags', [
      wbUnion('Flags', wbINFOGroupDecider,[
        wbInteger('Flags', itU16, wbFlags([
          {0x0001} 'Start Scene on End',
          {0x0002} 'Random',
          {0x0004} 'Say Once',
          {0x0008} 'Requires Player Activation',
          {0x0010} 'Unknown 4',
          {0x0020} 'Random End',
          {0x0040} 'End Running Scene',
          {0x0080} 'ForceGreet Hello',
          {0x0100} 'Player Address',
          {0x0200} 'Force Subtitle',
          {0x0400} 'Can Move While Greeting',
          {0x0800} 'No LIP File',
          {0x1000} 'Requires post-processing',
          {0x2000} 'Audio Output Override',
          {0x4000} 'Has Capture',
          {0x8000} 'Unknown 15'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbInteger('Flags', itU16, wbFlags([   //Info groups
          {0x0001} 'Unknown 0', // Any changes to the idle group removes this flag
          {0x0002} 'Random',
          {0x0004} 'Unknown 2', // Any changes to the idle group removes this flag
          {0x0008} 'Force all children player activate only',
          {0x0010} 'Unknown 4',
          {0x0020} 'Random End',
          {0x0040} 'Unknown 6', // Any changes to the idle group removes this flag
          {0x0080} 'Unknown 7', // Any changes to the idle group removes this flag
          {0x0100} 'Child infos don''t inherit reset data',
          {0x0200} 'Force All Children Random',
          {0x0400} 'Unknown 10', // Any changes to the idle group removes this flag
          {0x0800} 'Don''t do all before repeating',
          {0x1000} 'Unknown 12', // Any changes to the idle group removes this flag
          {0x2000} 'Unknown 13', // Any changes to the idle group removes this flag
          {0x4000} 'Unknown 14', // Any changes to the idle group removes this flag
          {0x8000} 'Unknown 15'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
      ]),
      wbInteger('Reset Hours', itU16, wbDiv(2730))
    ]),
    wbFormIDCk(TPIC, 'Topic', [DIAL]),
    wbFormIDCkNoReach(PNAM, 'Previous INFO', [INFO, NULL], False, cpBenign),
    wbFormIDCk(DNAM, 'Shared INFO', [INFO]),
    wbFormIDCk(GNAM, 'INFO group', [INFO]),
    wbString(IOVR, 'Override FileName'),

    wbRArray('Responses', wbRStruct('Response', [
      wbStruct(TRDA, 'Response Data', [
        wbFormIDCk('Emotion', [KYWD, FFFF]),
        wbInteger('Response number', itU8),
        wbFormIDCk('Sound File', [SNDR, NULL]),
        wbByteArray('Unknown', 1),
        wbInteger('Interrupt Percentage', itU16),
        wbInteger('Camera Target Alias', itS32),
        wbInteger('Camera Location Alias', itS32)
      ]),
      wbLStringKC(NAM1, 'Response Text', 0, cpTranslate)
        .SetAfterLoad(wbDialogueTextAfterLoad)
        .SetAfterSet(wbDialogueTextAfterSet)
        .SetRequired,
      wbString(NAM2, 'Script Notes', 0, cpNormal, True),
      wbString(NAM3, 'Edits', 0, cpNormal, True),
      wbString(NAM4, 'Alternate LIP Text', 0, cpNormal, True),
      wbFormIDCk(SNAM, 'Idle Animations: Speaker', [IDLE]),
      wbFormIDCk(LNAM, 'Idle Animations: Listener', [IDLE]),
      wbInteger(TNAM, 'Interrupt Percentage', itU16),
      wbByteArray(NAM9, 'Text Hash'),
      wbFormIDCk(SRAF, 'Camera Path', [CPTH]),
      wbEmpty(WZMD, 'Stop on Scene End')
    ])),

    wbConditions,
    wbLStringKC(RNAM, 'Prompt', 0, cpTranslate)
      .SetAfterLoad(wbDialogueTextAfterLoad)
      .SetAfterSet(wbDialogueTextAfterSet),
    wbFormIDCk(ANAM, 'Speaker', [NPC_]),
    wbFormIDCk(TSCE, 'Start Scene', [SCEN]),
    wbUnknown(INTV),
    wbInteger(ALFA, 'Forced Alias', itS32),
    wbFormIDCk(ONAM, 'Audio Output Override', [SOPM]),
    wbInteger(GREE, 'Greet Distance', itU32),
    wbStruct(TIQS, 'Set Parent Quest Stage', [
      wbInteger('On Begin', itS16),
      wbInteger('On End', itS16)
    ]),
    wbString(NAM0, 'Start Scene Phase'),
    wbInteger(INCC, 'Challenge', itU32, wbEnum([
      {0} 'None',
      {1} 'Easy',
      {2} 'Medium',
      {3} 'Hard',
      {4} 'Always Succeeds',
      {5} 'Easy Repeatable',
      {6} 'Medium Repeatable',
      {7} 'Hard Repeatable'
    ])),
    wbFormIDCk(MODQ, 'Reset Global', [GLOB]),
    wbInteger(INAM, 'Subtitle Priority', itU32, wbEnum([
      'Low',
      'Normal',
      'Unknown 2',
      'Force'
    ]))
  ]).SetAddInfo(wbINFOAddInfo);

  wbRecord(INGR, 'Ingredient', [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbFULL,
    wbKeywords,
    wbGenericModel,
    wbICON,
    wbMICO,
    wbDEST,
    wbETYP,
    wbYNAM,
    wbZNAM,
    wbStruct(DATA, '', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbStruct(ENIT, 'Effect Data', [
      wbInteger('Ingredient Value', itS32),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'No auto-calculation',
        {0x00000002} 'Food item',
        {0x00000004} 'Unknown 3',
        {0x00000008} 'Unknown 4',
        {0x00000010} 'Unknown 5',
        {0x00000020} 'Unknown 6',
        {0x00000040} 'Unknown 7',
        {0x00000080} 'Unknown 8',
        {0x00000100} 'References Persist'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ], cpNormal, True),
    wbEffectsReq
  ]);

  wbRecord(KEYM, 'Key',
    wbFlags(wbFlagsList([
      {0x00000800} 11, 'Calc Value From Components',
      {0x00002000} 13, 'Pack-In Use Only'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbFULLReq,
    wbGenericModel,
    wbICON,
    wbMICO,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbKeywords,
    wbStruct(DATA, '', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True)
  ]);

  wbRecord(LAND, 'Landscape',
    wbFlags(wbFlagsList([
      {0x40000} 18, 'Compressed'
    ]), [18]), [
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      {0x001} 'Has Vertex Normals/Height Map',
      {0x002} 'Has Vertex Colours',
      {0x004} 'Has Layers',
      {0x008} 'Unknown 4',
      {0x010} 'Auto-Calc Normals',
      {0x020} 'Has Hi-Res Heightfield',
      {0x040} '',
      {0x080} '',
      {0x100} '',
      {0x200} '',
      {0x400} 'Ignored'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbLandNormals,
    wbLandHeights,
    wbLandColors,
    wbLandLayers,
    wbRArray('Hi-Res Heightfield',
      wbByteArray(MPCD, 'Heightfield Data'))
  ]).SetAddInfo(wbLANDAddInfo);

  wbRecord(LIGH, 'Light',
    wbFlags(wbFlagsList([
      {0x00010000} 16, 'Random Anim Start',
      {0x00020000} 17, 'Unknown 17',
      {0x00020000} 25, 'Obstacle',
      {0x00020000} 28, 'Portal-strict'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbGenericModel,
    wbKeywords,
    wbDEST,
    wbPRPS,
    wbFULL,
    wbICON,
    wbMICO,
    wbStruct(DATA, '', [
      wbInteger('Time', itS32),
      wbInteger('Radius', itU32),
      wbByteColors('Color'),
      // Omnidirectional is the default type
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Unknown 0',
        {0x00000002} 'Can be Carried',
        {0x00000004} 'Unknown 2',
        {0x00000008} 'Flicker',
        {0x00000010} 'Unknown 4',
        {0x00000020} 'Off By Default',
        {0x00000040} 'Unknown 6',
        {0x00000080} 'Pulse',
        {0x00000100} 'Unknown 8',
        {0x00000200} 'Unknown 9',
        {0x00000400} 'Shadow Spotlight',
        {0x00000800} 'Shadow Hemisphere',
        {0x00001000} 'Shadow OmniDirectional',
        {0x00002000} 'Unknown 13',
        {0x00004000} 'NonShadow Spotlight',
        {0x00008000} 'Non Specular',
        {0x00010000} 'Attenuation Only',
        {0x00020000} 'NonShadow Box',
        {0x00040000} 'Ignore Roughness',
        {0x00080000} 'No Rim Lighting',
        {0x00100000} 'Ambient Only',
        {0x00200000} 'Unknown 21' // only in [001C7F0C] <RandomSpot01GR>
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFloat('Falloff Exponent')
        .SetDefaultNativeValue(1),
      wbFloat('FOV')
        .SetDefaultNativeValue(90),
      wbFloat('Near Clip')
        .SetDefaultNativeValue(10.0),
      wbStruct('Flicker Effect', [
        wbFloat('Period'),
        wbFloat('Intensity Amplitude'),
        wbFloat('Movement Amplitude')
      ]),
      wbFloat('Constant'),
      wbFloat('Scalar'),
      wbFloat('Exponent'),
      wbFloat('God Rays - Near Clip'),
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True, nil, 10),
    wbFloat(FNAM, 'Fade value')
      .SetDefaultNativeValue(1.0)
      .SetRequired,
    wbString(NAM0, 'Gobo'),
    wbFormIDCk(SNAM, 'Sound', [SNDR]),
    wbFormIDCk(LNAM, 'Lens', [LENS]),
    wbFormIDCk(WGDR, 'God Rays', [GDRY])
  ]);

  wbRecord(LSCR, 'Load Screen',
    wbFlags(wbFlagsList([
      {0x00000400} 10, 'Displays In Main Menu',
      {0x00008000} 15, 'No Rotation'
    ])), [
    wbEDID,
    wbDESCReq,
    wbConditions,
    wbFormIDCk(NNAM, 'Loading Screen NIF', [STAT, SCOL, NULL], False, cpNormal, True),
    wbFormIDCk(TNAM, 'Transform', [TRNS]),
    wbStruct(ONAM, 'Rotation', [
      wbInteger('Min', itS16),
      wbInteger('Max', itS16)
    ]),
    wbStruct(ZNAM, 'Zoom', [
      wbFloat('Min').SetDefaultEditValue('-1.0'),
      wbFloat('Max').SetDefaultEditValue('1.0')
    ]),
    wbString(MOD2, 'Camera Path', 0, cpNormal, False)
  ]);

  wbRecord(LTEX, 'Landscape Texture', [
    wbEDID,
    wbFormIDCk(TNAM, 'Texture Set', [TXST], False, cpNormal, False),
    wbFormIDCk(MNAM, 'Material Type', [MATT, NULL], False, cpNormal, True),
    wbStruct(HNAM, 'Havok Data', [
      wbInteger('Friction', itU8).SetDefaultEditValue('30'),
      wbInteger('Restitution', itU8).SetDefaultEditValue('30')
    ], cpNormal, True),
    wbInteger(SNAM, 'Texture Specular Exponent', itU8, nil, cpNormal, True).SetDefaultEditValue('30'),
    wbRArray('Grasses', wbFormIDCk(GNAM, 'Grass', [GRAS]))
  ]);

  var wbFilterKeywordChances :=
    wbArrayS(LLKC, 'Filter Keyword Chances',
      wbStructSK([0], 'Filter', [
        wbFormIDCk('Keyword', [KYWD]),
        wbInteger('Chance', itU32)
      ]));

  wbRecord(LVLN, 'Leveled NPC', [
    wbEDID,
    wbOBND(True),
    wbLVLD,
    wbInteger(LVLM, 'Max Count', itU8), { Always 00 } {Unavailable}
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count',
      {0x04} 'Calculate All' {Still picks just one}
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries',
      wbRStructExSK([0], [1], 'Leveled List Entry', [
        wbLeveledListEntry('NPC', [LVLN, NPC_]),
        wbCOED
      ]).SetSummaryMemberMaxDepth(0, 1)
        .IncludeFlag(dfCollapsed, wbCollapseLeveledItems)
    ).SetCountPath(LLCT),
    wbFilterKeywordChances,
    wbGenericModel
  ]).SetAfterLoad(wbLLEAfterLoad);

  wbRecord(LVLI, 'Leveled Item', [
    wbEDID,
    wbOBND(True),
    wbLVLD,
    wbInteger(LVLM, 'Max Count', itU8), { Always 00 }
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count',
      {0x04} 'Use All'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries',
      wbRStructExSK([0], [1], 'Leveled List Entry', [
        wbLeveledListEntry('Item', sigBaseObjects),
        wbCOED
      ]).SetSummaryMemberMaxDepth(0, 1)
        .IncludeFlag(dfCollapsed, wbCollapseLeveledItems)
    ).SetCountPath(LLCT),
    wbFilterKeywordChances,
    wbFormIDCk(LVSG, 'Epic Loot Chance', [GLOB]),
    wbLStringKC(ONAM, 'Override Name', 0, cpTranslate)
  ]).SetAfterLoad(wbLLEAfterLoad);

  wbRecord(LVSP, 'Leveled Spell', [
    wbEDID,
    wbOBND(True),
    wbLVLD,
    wbInteger(LVLM, 'Max Count', itU8), { Always 00 }
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count',
      {0x04} 'Use All'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbLLCT,
    wbRArrayS('Leveled List Entries',
      wbRStructSK([0], 'Leveled List Entry', [
        wbLeveledListEntry('Spell', [LVSP, SPEL])
      ]).SetSummaryMemberMaxDepth(0, 1)
        .IncludeFlag(dfCollapsed, wbCollapseLeveledItems)
    ).SetCountPath(LLCT)
  ]);

  wbMGEFType := wbInteger('Archetype', itU32, wbEnum([
    {00} 'Value Modifier',
    {01} 'Script',
    {02} 'Dispel',
    {03} 'Cure Disease',
    {04} 'Absorb',
    {05} 'Dual Value Modifier',
    {06} 'Calm',
    {07} 'Demoralize',
    {08} 'Frenzy',
    {09} 'Disarm',
    {10} 'Command Summoned',
    {11} 'Invisibility',
    {12} 'Light',
    {13} 'Darkness',
    {14} 'Nighteye',
    {15} 'Lock',
    {16} 'Open',
    {17} 'Bound Weapon',
    {18} 'Summon Creature',
    {19} 'Detect Life',
    {20} 'Telekinesis',
    {21} 'Paralysis',
    {22} 'Reanimate',
    {23} 'Soul Trap',
    {24} 'Turn Undead',
    {25} 'Guide',
    {26} 'Unknown 26',
    {27} 'Cure Paralysis',
    {28} 'Cure Addiction',
    {29} 'Cure Poison',
    {30} 'Concussion',
    {31} 'Stimpak',
    {32} 'Accumulate Magnitude',
    {33} 'Stagger',
    {34} 'Peak Value Modifier',
    {35} 'Cloak',
    {36} 'Unknown 36',
    {37} 'Slow Time',
    {38} 'Rally',
    {39} 'Enhance Weapon',
    {40} 'Spawn Hazard',
    {41} 'Etherealize',
    {42} 'Banish',
    {43} 'Spawn Scripted Ref',
    {44} 'Disguise',
    {45} 'Damage',
    {46} 'Immunity',
    {47} 'Permanent Reanimate',
    {48} 'Jetpack',
    {49} 'Chameleon'
  ]), cpNormal, False, nil, wbMGEFArchtypeAfterSet);

  wbMGEFData := wbRStruct('Magic Effect Data', [
    wbStruct(DATA, 'Data', [
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001}  'Hostile',
        {0x00000002}  'Recover',
        {0x00000004}  'Detrimental',
        {0x00000008}  'Snap to Navmesh',
        {0x00000010}  'No Hit Event',
        {0x00000020}  'Unknown 6',
        {0x00000040}  'Unknown 7',
        {0x00000080}  'Unknown 8',
        {0x00000100}  'Dispel with Keywords',
        {0x00000200}  'No Duration',
        {0x00000400}  'No Magnitude',
        {0x00000800}  'No Area',
        {0x00001000}  'FX Persist',
        {0x00002000}  'Unknown 14',
        {0x00004000}  'Gory Visuals',
        {0x00008000}  'Hide in UI',
        {0x00010000}  'Unknown 17',
        {0x00020000}  'No Recast',
        {0x00040000}  'Unknown 19',
        {0x00080000}  'Unknown 20',
        {0x00100000}  'Unknown 21',
        {0x00200000}  'Power Affects Magnitude',
        {0x00400000}  'Power Affects Duration',
        {0x00800000}  'Unknown 24',
        {0x01000000}  'Unknown 25',
        {0x02000000}  'Unknown 26',
        {0x04000000}  'Painless',
        {0x08000000}  'No Hit Effect',
        {0x10000000}  'No Death Dispel',
        {0x20000000}  'Unknown 30',
        {0x40000000}  'Unknown 31',
        {0x80000000}  'Unknown 32'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFloat('Base Cost'),
      wbUnion('Assoc. Item', wbMGEFAssocItemDecider, [
        { 0} wbFormID('Unused', cpIgnore),
        { 1} wbFormIDCk('Assoc. Item', [LIGH, NULL]),
        { 2} wbFormIDCk('Assoc. Item', [WEAP, ARMO, NULL]),
        { 3} wbFormIDCk('Assoc. Item', [NPC_, NULL]),
        { 4} wbFormIDCk('Assoc. Item', [HAZD, NULL]),
        { 5} wbFormIDCk('Assoc. Item', [SPEL, NULL]),
        { 6} wbFormIDCk('Assoc. Item', [RACE, NULL]),
        { 7} wbFormIDCk('Assoc. Item', [ENCH, NULL]),
        { 8} wbFormIDCk('Assoc. Item', [KYWD, NULL]),
        { 9} wbFormIDCk('Assoc. Item', [DMGT, NULL])
      ], cpNormal, False, nil, wbMGEFAssocItemAfterSet),
      wbByteArray('Magic Skill (unused)', 4),
      wbFormIDCk('Resist Value', [AVIF, NULL]),
      wbInteger('Counter Effect count', itU16),
      wbUnused(2),
      wbFormIDCk('Casting Light', [LIGH, NULL]),
      wbFloat('Taper Weight'),
      wbFormIDCk('Hit Shader', [EFSH, NULL]),
      wbFormIDCk('Enchant Shader', [EFSH, NULL]),
      wbInteger('Minimum Skill Level', itU32),
      wbStruct('Spellmaking', [
        wbInteger('Area', itU32),
        wbFloat('Casting Time')
      ]),
      wbFloat('Taper Curve'),
      wbFloat('Taper Duration'),
      wbFloat('Second AV Weight', cpNormal, False, nil, wbMGEFAV2WeightAfterSet),
      wbMGEFType,
      wbActorValue,
      wbFormIDCk('Projectile', [PROJ, NULL]),
      wbFormIDCk('Explosion', [EXPL, NULL]),
      wbInteger('Casting Type', itU32, wbCastEnum),
      wbInteger('Delivery', itU32, wbTargetEnum),
      wbActorValue, //wbInteger('Second Actor Value', itS32, wbActorValueEnum),
      wbFormIDCk('Casting Art', [ARTO, NULL]),
      wbFormIDCk('Hit Effect Art', [ARTO, NULL]),
      wbFormIDCk('Impact Data', [IPDS, NULL]),
      wbFloat('Skill Usage Multiplier'),
      wbStruct('Dual Casting', [
        wbFormIDCk('Art', [DUAL, NULL]),
        wbFloat('Scale').SetDefaultEditValue('1.0')
      ]),
      wbFormIDCk('Enchant Art', [ARTO, NULL]),
      wbFormIDCk('Hit Visuals', [RFCT, NULL]),
      wbFormIDCk('Enchant Visuals', [RFCT, NULL]),
      wbFormIDCk('Equip Ability', [SPEL, NULL]),
      wbFormIDCk('Image Space Modifier', [IMAD, NULL]),
      wbFormIDCk('Perk to Apply', [PERK, NULL]),
      wbInteger('Casting Sound Level', itU32, wbSoundLevelEnum),
      wbStruct('Script Effect AI', [
        wbFloat('Score'),
        wbFloat('Delay Time')
      ])
    ], cpNormal, True)
  ]);

  wbRecord(MGEF, 'Magic Effect', [
    wbEDID,
    wbVMAD,
    wbFULL,
    wbMDOB,
    wbKeywords,
    wbMGEFData,
    wbRArrayS('Counter Effects', wbFormIDCk(ESCE, 'Effect', [MGEF]), cpNormal, False, nil, wbCounterEffectsAfterSet),
    wbMagicEffectSounds,
    wbLStringKC(DNAM, 'Magic Item Description', 0, cpTranslate),
    wbConditions
  ], False, nil, cpNormal, False, nil {wbMGEFAfterLoad}, wbMGEFAfterSet);

  wbRecord(MISC, 'Misc. Item',
    wbFlags(wbFlagsList([
      {0x00000004}  11, 'Calc From Components',
      {0x00000004}  13, 'Pack-In Use Only'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbFULL,
    wbGenericModel,
    wbICON,
    wbMICO,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbKeywords,
    wbFormID(FIMD, 'Featured Item Message'),
    wbStruct(DATA, 'Data', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True),
    // the amount of components is the same as size of CDIX, so should not be sorted probably
    wbArrayS(CVPA, 'Components',
      wbStructSK([0], 'Component', [
        wbFormIDCkNoReach('Component', sigBaseObjects),
        wbInteger('Count', itU32)
      ])
    ),
    wbArray(CDIX, 'Component Display Indices', wbInteger('Display Index', itU8))
  ]);

  wbComponent :=
    wbStructSK([0], 'Component', [
      wbFormIDCkNoReach('Component', sigBaseObjects),
      wbInteger('Count', itU32)
    ]).SetToStr(wbItemToStr).IncludeFlag(dfCollapsed, wbCollapseItems);

  wbComponents := wbArrayS(FVPA, 'Components', wbComponent);

  wbRecord(COBJ, 'Constructible Object', [
    wbEDID,
    wbYNAM,
    wbZNAM,
    wbComponents,
    wbDESC,
    wbConditions,
    wbFormIDCk(CNAM, 'Created Object', sigBaseObjects),
    wbFormIDCkNoReach(BNAM, 'Workbench Keyword', [KYWD]),
    wbByteArray(NAM1, 'Unused', 0, cpIgnore, False, False, wbNeverShow), // co_PA_FusionCore01
    wbByteArray(NAM2, 'Unused', 0, cpIgnore, False, False, wbNeverShow), // co_PA_FusionCore01
    wbByteArray(NAM3, 'Unused', 0, cpIgnore, False, False, wbNeverShow), // co_PA_FusionCore01
    wbFormIDCk(ANAM, 'Menu Art Object', [ARTO]),
    wbArrayS(FNAM, 'Category', wbFormIDCk('Keyword', [KYWD])),
    wbStruct(INTV, 'Data', [
      wbInteger('Created Object Count', itU16).SetDefaultEditValue('1'),
      wbInteger('Priority', itU16)
    ], cpNormal, False, nil, 1)
  ]);

  wbRecord(NPC_, 'Non-Player Character',
    wbFlags(wbFlagsList([
      {0x00000400} 10, 'Unknown 10',
      {0x00040000} 18, 'Compressed',
      {0x00080000} 19, 'Unknown 19',
      {0x20000000} 29, 'Bleedout Override'
    ]), [18]), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbSTCP,
    wbStruct(ACBS, 'Configuration', [
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Female',
        {0x00000002} 'Essential',
        {0x00000004} 'Is CharGen Face Preset',
        {0x00000008} 'Respawn',
        {0x00000010} 'Auto-calc stats',
        {0x00000020} 'Unique',
        {0x00000040} 'Doesn''t affect stealth meter',
        {0x00000080} 'PC Level Mult',
        {0x00000100} 'Unknown 8',
        {0x00000200} 'Calc For Each Template',
        {0x00000400} 'Unknown 10',
        {0x00000800} 'Protected',
        {0x00001000} 'Unknown 12',
        {0x00002000} 'Unknown 13',
        {0x00004000} 'Summonable',
        {0x00008000} 'Unknown 15',
        {0x00010000} 'Doesn''t bleed',
        {0x00020000} 'Unknown 17',
        {0x00040000} 'Bleedout Override',
        {0x00080000} 'Opposite Gender Anims',
        {0x00100000} 'Simple Actor',
        {0x00200000} 'Unknown 21',
        {0x00400000} 'Unknown 22',
        {0x00800000} 'No Activation/Hellos',
        {0x01000000} 'Diffuse Alpha Test',
        {0x02000000} 'Unknown 25',
        {0x04000000} 'Unknown 26',
        {0x08000000} 'Unknown 27',
        {0x10000000} 'Unknown 28',
        {0x20000000} 'Is Ghost',
        {0x40000000} 'Unknown 30',
        {0x80000000} 'Invulnerable'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('XP Value Offset', itS16),
      wbUnion('Level', wbACBSLevelDecider, [
        wbInteger('Level', itU16),
        wbInteger('Level Mult', itU16, wbDiv(1000, 2))
          .SetAfterLoad(wbACBSLevelMultAfterLoad)
      ]).SetAfterSet(wbACBSLevelMultAfterSet),
      wbInteger('Calc min level', itU16),
      wbInteger('Calc max level', itU16),
      wbInteger('Disposition Base', itS16),
      wbInteger('Template Flags', itU16, wbTemplateFlags)
        .IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Bleedout Override', itU16),
      wbByteArray('Unknown', 2)
    ], cpNormal, True),
    wbRArrayS('Factions', wbFaction),
    wbFormIDCk(INAM, 'Death item', [LVLI]),
    wbFormIDCk(VTCK, 'Voice', [VTYP]),
    wbFormIDCk(TPLT, 'Default Template', [LVLN, NPC_]),
    wbFormIDCk(LTPT, 'Legendary Template', [LVLN, NPC_]),
    wbFormIDCk(LTPC, 'Legendary Chance', [GLOB]),
    wbStruct(TPTA, 'Template Actors', [
      wbNPCTemplateActorEntry('Traits'),
      wbNPCTemplateActorEntry('Stats'),
      wbNPCTemplateActorEntry('Factions'),
      wbNPCTemplateActorEntry('Spell List'),
      wbNPCTemplateActorEntry('AI Data'),
      wbNPCTemplateActorEntry('AI Packages'),
      wbNPCTemplateActorEntry('Model/Animation'),
      wbNPCTemplateActorEntry('Base Data'),
      wbNPCTemplateActorEntry('Inventory'),
      wbNPCTemplateActorEntry('Script'),
      wbNPCTemplateActorEntry('Def Package List'),
      wbNPCTemplateActorEntry('Attack Data'),
      wbNPCTemplateActorEntry('Keywords')
    ]).SetSummaryKeyOnValue([0,1,2,3,4,5,6,7,8,9,10,11,12])
      .IncludeFlagOnValue(dfSummaryExcludeNULL)
      .SetDontShow(wbTemplateActorsDontShow),
    wbFormIDCk(RNAM, 'Race', [RACE]).SetRequired,
    wbSPCT,
    wbSPLOs,
    wbDEST,
    wbFormIDCk(WNAM, 'Skin', [ARMO], False, cpNormal, False),
    wbFormIDCk(ANAM, 'Far away model', [ARMO]),
    wbFormIDCk(ATKR, 'Attack Race', [RACE], False, cpNormal, False),
    wbRArrayS('Attacks', wbAttackData),
    wbFormIDCk(SPOR, 'Spectator Override Package List', [FLST]),
    wbFormIDCk(OCOR, 'Observe Dead Body Override Package List', [FLST]),
    wbFormIDCk(GWOR, 'Guard Warn Override Package List', [FLST]),
    wbFormIDCk(ECOR, 'Combat Override Package List', [FLST]),
    wbFormIDCk(FCPL, 'Follower Command Package List', [FLST]),
    wbFormIDCk(RCLR, 'Follower Elevator Package List', [FLST]),
    wbInteger(PRKZ, 'Perk Count', itU32, nil, cpBenign),
    wbRArrayS('Perks',
      wbStructSK(PRKR, [0], 'Perk', [
        wbFormIDCk('Perk', [PERK]),
        wbInteger('Rank', itU8)
      ]).SetSummaryKeyOnValue([1])
        .SetSummaryPrefixSuffixOnValue(1, '{Rank: ', '}')
        .IncludeFlagOnValue(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed, wbCollapsePerk)
        , cpNormal, False, nil, wbPRKRsAfterSet
    ),
    wbPRPS,
    wbFTYP,
    wbNTRM,
    wbCOCT,
    wbCNTOs,
    wbAIDT,
    wbRArray('Packages', wbFormIDCk(PKID, 'Package', [PACK])),
    wbKeywords,
    wbAPPR,
    wbObjectTemplate,
    wbFormIDCk(CNAM, 'Class', [CLAS], False, cpNormal, True),
    wbFULL,
    wbLStringKC(SHRT, 'Short Name', 0, cpTranslate),
    wbEmpty(DATA, 'Marker', cpNormal, True),
    wbStruct(DNAM, '', [
      wbInteger('Calculated Health', itU16),
      wbInteger('Calculated Action Points', itU16),
      wbInteger('Far Away Model Distance', itU16),
      wbInteger('Geared Up Weapons', itU8),
      wbUnused(1)
    ]),
    wbRArrayS('Head Parts', wbFormIDCk(PNAM, 'Head Part', [HDPT])),
    wbFormIDCk(HCLF, 'Hair Color', [CLFM], False, cpNormal, False),
    wbFormIDCk(BCLF, 'Facial Hair Color', [CLFM], False, cpNormal, False),
    wbFormIDCk(ZNAM, 'Combat Style', [CSTY], False, cpNormal, False),
    wbFormIDCk(GNAM, 'Gift Filter', [FLST], False, cpNormal, False),
    wbUnknown(NAM5, cpNormal, True),
    wbFloat(NAM6, 'Height Min', cpNormal, True),
    wbFloat(NAM7, 'Unused', cpNormal, True),
    wbFloat(NAM4, 'Height Max'),
    wbStruct(MWGT, 'Weight', [
       wbFloat('Thin'),
       wbFloat('Muscular'),
       wbFloat('Fat')
    ]),
    wbInteger(NAM8, 'Sound Level', itU32, wbSoundLevelEnum, cpNormal, True),
    wbRStruct('Actor Sounds', [
      wbInteger(CS2H, 'Count', itU32, nil, cpBenign, True),
      wbActorSounds,
      wbEmpty(CS2E, 'End Marker', cpNormal, True),
      wbByteArray(CS2F, 'Finalize', 1, cpNormal, True)
    ]),
    wbFormIDCk(CSCR, 'Inherits Sounds From', [NPC_], False, cpNormal, False),
    wbFormIDCk(PFRN, 'Power Armor Stand', [FURN]),
    wbFormIDCk(DOFT, 'Default Outfit', [OTFT], False, cpNormal, False),
    wbFormIDCk(SOFT, 'Sleeping Outfit', [OTFT], False, cpNormal, False),
    wbFormIDCk(DPLT, 'Default Package List', [FLST], False, cpNormal, False),
    wbFormIDCk(CRIF, 'Crime Faction', [FACT], False, cpNormal, False),
    wbFormIDCk(FTST, 'Head Texture', [TXST], False, cpNormal, False),
    wbFloatRGBA(QNAM, 'Texture lighting'),
    wbArray(MSDK, 'Morph Keys', wbInteger('Key', itU32, wbMorphValueToStr, wbHexStrToInt)),
    wbArray(MSDV, 'Morph Values', wbFloat('Value')),
    wbRArrayS('Face Tinting Layers',
      wbRStructSK([0], 'Layer', [
        wbStructSK(TETI, [1], 'Index', [
          wbInteger('Data Type', itU16, wbEnum(['', 'Value/Color', 'Value'])),
          wbInteger('Index', itU16, wbTintLayerToStr, wbStrToInt)
        ]),
        //wbByteArray(TEND, 'Data')
        wbStruct(TEND, 'Data', [
          wbInteger('Value', itU8, wbDiv(100)),
          wbByteColors('Color'),
          wbInteger('Template Color Index', itS16)
        ], cpNormal, True, nil, 1)
      ])
    ),
    wbStruct(MRSV, 'Body Morph Region Values', [
      wbFloat('Head'),
      wbFloat('Upper Torso'),
      wbFloat('Arms'),
      wbFloat('Lower Torso'),
      wbFloat('Legs')
    ]),
    // reported to cause issues when sorted
    wbRArrayS('Face Morphs',
      wbRStructSK([0], 'Face Morph', [
        wbInteger(FMRI, 'Index', itU32, wbFaceMorphToStr, wbHexStrToInt),
        //wbArray(FMRS, 'Unknown', wbFloat('Unknown'))
        wbStruct(FMRS, 'Values', [
          wbFloat('Position - X'),
          wbFloat('Position - Y'),
          wbFloat('Position - Z'),
          wbFloat('Rotation - X'),
          wbFloat('Rotation - Y'),
          wbFloat('Rotation - Z'),
          wbFloat('Scale'),
          wbByteArray('Unknown')
        ])
      ])
    ),
    wbFloat(FMIN, 'Facial Morph Intensity'),
    wbATTX
  ], False, nil, cpNormal, False, wbNPCAfterLoad, wbNPCAfterSet);

  wbPKDTInterruptFlags := wbFlags([
    {0x0001} 'Hellos to player',
    {0x0002} 'Random conversations',
    {0x0004} 'Observe combat behavior',
    {0x0008} 'Greet corpse behavior',
    {0x0010} 'Reaction to player actions',
    {0x0020} 'Friendly fire comments',
    {0x0040} 'Aggro Radius Behavior',
    {0x0080} 'Allow Idle Chatter',
    {0x0100} 'Unknown 9',
    {0x0200} 'World Interactions',
    {0x0400} 'Off For Important Scene',
    {0x0800} 'Unknown 12',
    {0x1000} 'Unknown 13',
    {0x2000} 'Unknown 14',
    {0x4000} 'Unknown 15',
    {0x8000} 'Unknown 16'
  ]);

  wbBlendOperationEnum := wbEnum([
            'Default',
            'Multiply',
            'Overlay',
            'Soft Light',
            'Hard Light'
          ]);

  wbUNAMs := wbRArray('Data Inputs', wbRStruct('Data Input', [
    wbInteger(UNAM, 'Index', itS8),
    wbString(BNAM, 'Name'),
    wbInteger(PNAM, 'Flags', itU32, wbFlags([
      'Public'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
  ]));

  wbRecord(PACK, 'Package', [
    wbEDID,
    wbVMADFragmentedPACK,

    wbStruct(PKDT, 'Pack Data', [
      wbInteger('General Flags', itU32, wbPackageFlags).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Type', itU8, wbEnum ([], [
        18, 'Package',
        19, 'Package Template'
      ])).SetDefaultEditValue('Package'),
      wbInteger('Interrupt Override', itU8, wbEnum([
        {0} 'None',
        {1} 'Spectator',
        {2} 'ObserveDead',
        {3} 'GuardWarn',
        {4} 'Combat',
        {5} 'Command Travel',
        {6} 'Command Activate',
        {7} 'Leave Workstation'
      ])),
      wbInteger('Preferred Speed', itU8, wbEnum([
        'Walk',
        'Jog',
        'Run',
        'Fast Walk'
      ])),
      wbUnknown(1),
      wbInteger('Interrupt Flags', itU16, wbPKDTInterruptFlags).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbUnknown(2)
    ]).SetRequired,

    wbStruct(PSDT, 'Schedule', [
      wbInteger('Month', itS8,
        wbEnum([
        {0}  'January',
        {1}  'February',
        {2}  'March',
        {3}  'April',
        {4}  'May',
        {5}  'June',
        {6}  'July',
        {7}  'August',
        {8}  'September',
        {9}  'October',
        {10} 'November',
        {11} 'December',
        {12} 'Spring (MAM)',
        {13} 'Summer (JJA)',
        {14} 'Autumn (SON)',
        {15} 'Winter (DJF)'
        ], [
        255, 'Any'
        ])).SetDefaultNativeValue(255),
      wbInteger('Day Of Week', itU8,
        wbEnum([
        {0}  'Sunday',
        {1}  'Monday',
        {2}  'Tuesday',
        {3}  'Wednesday',
        {4}  'Thursday',
        {5}  'Friday',
        {6}  'Saturday',
        {7}  'Weekdays',
        {8}  'Weekends',
        {9}  'Monday, Wednesday, Friday',
        {10} 'Tuesday, Thursday'
        ], [
        255, 'Any'
        ])).SetDefaultNativeValue(255),
      wbInteger('Date', itU8)
        .SetAfterLoad(wbPACKDateAfterLoad)
        .SetAfterSet(wbPACKDateAfterSet),
      wbInteger('Hour', itS8)
        .SetAfterLoad(wbPACKHourAfterLoad)
        .SetAfterSet(wbPACKHourAfterSet),
      wbInteger('Minute', itU8,
        wbEnum([
        {0} '00'
        ], [
        5,   '05',
        10,  '10',
        15,  '15',
        20,  '20',
        25,  '25',
        30,  '30',
        35,  '35',
        40,  '40',
        45,  '45',
        50,  '50',
        55,  '55',
        255, 'Any'
        ])),
      wbUnused(3),
      wbInteger('Duration', itU32, wbDiv(60))
    ]).SetRequired,

    wbConditions,
    wbIdleAnimation,
    wbFormIDCk(CNAM, 'Combat Style', [CSTY]),
    wbFormIDCk(QNAM, 'Owner Quest', [QUST]),
    wbStruct(PKCU, 'Counter', [
      wbInteger('Data Input Count', itU32),
      wbFormIDCk('Package Template', [PACK, NULL]),
      wbInteger('Version Counter (autoincremented)', itU32)
    ], cpNormal, True),

    wbRStruct('Package Data', [
      wbRArray('Data Input Values', wbRStruct('Value', [
        wbString(ANAM, 'Type').SetAfterSet(wbPackageDataInputValueTypeAfterSet),
        wbUnion(CNAM, 'Value', wbPubPackCNAMDecider, [
          {0} wbByteArray('Unknown'),
          {1} wbInteger('Bool', itU8, wbBoolEnum),
          {2} wbInteger('Integer', itU32),
          {3} wbFloat('Float')
        ]),
        wbUnknown(BNAM),
        wbPDTOs,
        wbPLDT,
        wbStruct(PTDA, 'Target', [wbTargetData]),
        wbFormIDCK(TPIC, 'Dialogue Topic', [DIAL])
      ], [], cpNormal, False)),
      wbUNAMs
    ]),
    wbByteArray(XNAM, 'Marker', 0, cpNormal, True),

    wbRStruct('Procedure Tree', [
      wbRArray('Branches', wbRStruct('Branch', [
        wbString(ANAM, 'Branch Type'),
        wbCITCReq,
        wbConditions,
        wbStruct(PRCB, 'Root', [
          wbInteger('Branch Count', itU32),
          wbInteger('Flags', itU32, wbFlags([
            'Repeat when Complete',
            'Unknown 1'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
        ]),
        wbString(PNAM, 'Procedure Type'),
        wbInteger(FNAM, 'Flags', itU32, wbFlags(['Success Completes Package'])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbRArray('Data Input Indexes', wbInteger(PKC2, 'Index', itU8)),
        {>>> PFO2 should be single, there is only 1 PACK [00095F46] <PatrolAndHunt> in Skyrim.esm with 2xPFO2 <<<}
        wbRArray('Flags Override',
          wbStruct(PFO2, 'Data', [
            wbInteger('Set General Flags', itU32, wbPackageFlags).IncludeFlag(dfCollapsed, wbCollapseFlags),
            wbInteger('Clear General Flags', itU32, wbPackageFlags).IncludeFlag(dfCollapsed, wbCollapseFlags),
            wbInteger('Set Interrupt Flags', itU16, wbPKDTInterruptFlags).IncludeFlag(dfCollapsed, wbCollapseFlags),
            wbInteger('Clear Interrupt Flags', itU16, wbPKDTInterruptFlags).IncludeFlag(dfCollapsed, wbCollapseFlags),
            wbInteger('Preferred Speed Override', itU8, wbEnum([
              'Walk',
              'Jog',
              'Run',
              'Fast Walk'
            ])),
            wbByteArray('Unknown', 3)
          ])
        ),
        wbRArray('Unknown', wbUnknown(PFOR), cpIgnore)
      ], [], cpNormal, False, nil, False, nil, wbConditionsAfterSet))
    ]),
    wbUNAMs,
    wbRStruct('OnBegin', [
      wbEmpty(POBA, 'OnBegin Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbPDTOs
    ], [], cpNormal, True),
    wbRStruct('OnEnd', [
      wbEmpty(POEA, 'OnEnd Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbPDTOs
    ], [], cpNormal, True),
    wbRStruct('OnChange', [
      wbEmpty(POCA, 'OnChange Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbPDTOs
    ], [], cpNormal, True)
  ], False, nil, cpNormal, False, nil {wbPACKAfterLoad});

  wbQUSTAliasFlags :=
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      {0x00000001} 'Reserves Location/Reference',
      {0x00000002} 'Optional',
      {0x00000004} 'Quest Object',
      {0x00000008} 'Allow Reuse in Quest',
      {0x00000010} 'Allow Dead',
      {0x00000020} 'Matching Ref - In Loaded Area',
      {0x00000040} 'Essential',
      {0x00000080} 'Allow Disabled',
      {0x00000100} 'Stores Text',
      {0x00000200} 'Allow Reserved',
      {0x00000400} 'Protected',
      {0x00000800} 'Forced by Aliases',
      {0x00001000} 'Allow Destroyed',
      {0x00002000} 'Matching Ref - Closest',
      {0x00004000} 'Uses Stored Text',
      {0x00008000} 'Initially Disabled',
      {0x00010000} 'Allow Cleared',
      {0x00020000} 'Clear Names When Removed',
      {0x00040000} 'Matching Ref - Actors Only',
      {0x00080000} 'Create Ref - Temp',
      {0x00100000} 'External Alias - Linked',
      {0x00200000} 'No Pickpocket',
      {0x00400000} 'Can Apply Data To Non-Aliased Refs',
      {0x00800000} 'Is Companion',
      {0x01000000} 'Optional All Scenes'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags);

  wbRecord(QUST, 'Quest',
    wbFlags(wbFlagsList([
      {0x00004000} 14, 'Partial Form'
    ]), [14]), [
    wbEDID,
    wbVMADFragmentedQUST,
    wbFULL,
    wbStruct(DNAM, 'General', [
      wbInteger('Flags', itU16, wbFlags([
        {0x0001} 'Start Game Enabled',
        {0x0002} 'Completed',
        {0x0004} 'Add Idle topic to Hello',
        {0x0008} 'Allow repeated stages',
        {0x0010} 'Starts Enabled',
        {0x0020} 'Displayed In HUD',
        {0x0040} 'Failed',
        {0x0080} 'Stage Wait',
        {0x0100} 'Run Once',
        {0x0200} 'Exclude from dialogue export',
        {0x0400} 'Warn on alias fill failure',
        {0x0800} 'Active',
        {0x1000} 'Repeats Conditions',
        {0x2000} 'Keep Instance',
        {0x4000} 'Want Dormant',
        {0x8000} 'Has Dialogue Data'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Priority', itU8),
      wbUnused(1),
      wbFloat('Delay Time'),
      wbInteger('Type', itU8, wbEnum([
        {0} 'None',
        {1} 'Main Quest',
        {2} 'Brotherhood of Steel',
        {3} 'Institute',
        {4} 'Minutemen',
        {5} 'Railroad',
        {6} 'Miscellaneous',
        {7} 'Side Quests',
        {8} 'DLC01',
        {9} 'DLC02',
       {10} 'DLC03',
       {11} 'DLC04',
       {12} 'DLC05',
       {13} 'DLC06',
       {14} 'DLC07'
      ])),
      wbUnused(3)
    ]).SetRequired,
    wbInteger(ENAM, 'Event', itU32, wbQuestEventEnum),
    wbFormIDCk(LNAM, 'Location', [LCTN]),
    wbFormIDCk(XNAM, 'Quest Completion XP', [GLOB]),
    wbRArray('Text Display Globals', wbFormIDCk(QTGL, 'Global', [GLOB])),
    wbFLTR,
    wbRStruct('Quest Dialogue Conditions', [wbConditions]),
    wbEmpty(NEXT, 'Marker', cpNormal, True),
    wbRStruct('Story Manager Conditions', [wbConditions]),
    wbRArrayS('Stages', wbRStructSK([0], 'Stage', [
      wbStructSK(INDX, [0], 'Stage Index', [
        wbInteger('Stage Index', itU16),
        wbInteger('Flags', itU8, wbFlags([
          {0x01} 'Unknown 1',
          {0x02} 'Run On Start',
          {0x04} 'Run On Stop',
          {0x08} 'Keep Instance Data From Here On'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbInteger('Unknown', itU8)
      ]).IncludeFlag(dfCollapsed, wbCollapseOther),
      wbRArray('Log Entries', wbRStruct('Log Entry', [
        wbInteger(QSDT, 'Stage Flags', itU8, wbFlags([
          {0x01} 'Complete Quest',
          {0x02} 'Fail Quest'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbConditions,
        wbString(NAM2, 'Note'),
        wbLStringKC(CNAM, 'Log Entry', 0, cpTranslate),
        wbFormIDCk(NAM0, 'Next Quest', [QUST])
      ]).SetSummaryKey([4,0,1])
        .SetSummaryMemberPrefixSuffix(4, 'Log: "', '"')
        .SetSummaryMemberPrefixSuffix(0, 'Flags: {', '}')
        .SetSummaryMemberPrefixSuffix(1, 'Conditions: [', ']')
        .SetSummaryDelimiter(' ')
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed, wbCollapseQuestLog))
    ]).SetSummaryKey([1])
      .SetSummaryMemberPrefixSuffix(0, '[', ']')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseQuestStage)),
    wbRArray('Objectives', wbRStruct('Objective', [
      wbInteger(QOBJ, 'Objective Index', itU16),
      wbInteger(FNAM, 'Flags', itU32, wbFlags([
        {0x01} 'ORed With Previous',
        {0x02} 'No Stats Tracking'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbLStringKC(NNAM, 'Display Text', 0, cpTranslate, True),
      wbRArray('Targets', wbRStruct('Target', [
        wbStruct(QSTA, 'Target', [
          wbInteger('Alias', itS32, wbQuestAliasToStr, wbAliasToInt),
          wbInteger('Flags', itU32, wbFlags([
            {0x01} 'Compass Marker Ignores Locks',
            {0x02} 'Hostile',
            {0x04} 'Use Straight Line Pathing'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
          wbFromVersion(82, wbFormIDCk('Keyword', [KYWD, NULL]))
        ]).SetSummaryKeyOnValue([0, 1])
          .SetSummaryPrefixSuffixOnValue(0, 'Alias[', ']')
          .SetSummaryPrefixSuffixOnValue(1, 'Flags{', '}')
          .SetSummaryDelimiterOnValue(' ')
          .IncludeFlag(dfSummaryMembersNoName),
        wbConditions
      ]).SetSummaryKey([0,1])
        .SetSummaryMemberPrefixSuffix(1, 'Conditions: [', ']')
        .SetSummaryDelimiter(' ')
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed, wbCollapseQuestObjectiveTarget))
    ]).SetSummaryKey([0, 2, 1, 3])
      .SetSummaryMemberPrefixSuffix(0, '[', ']')
      .SetSummaryMemberPrefixSuffix(1, 'Flags{', '}')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseQuestObjective)),

    wbInteger(ANAM, 'Next Alias ID', itU32).SetRequired,

    wbRArray('Aliases',
      wbRUnion('Alias', [

        // Reference Alias
        wbRStructSK([0], 'Alias', [
          wbInteger(ALST, 'Reference Alias ID', itU32, nil, cpNormal, True),
          wbString(ALID, 'Alias Name', 0, cpNormal, True),
          wbQUSTAliasFlags,
          wbInteger(ALFI, 'Force Into Alias When Filled', itS32, wbQuestAliasToStr, wbAliasToInt),
          //wbFormIDCk(ALFL, 'Specific Location', [LCTN]),
          wbFormID(ALFR, 'Forced Reference'),
          wbFormIDCk(ALUA, 'Unique Actor', [NPC_]),
          wbRStruct('Location Alias Reference', [
            wbInteger(ALFA, 'Alias', itS32, wbQuestAliasToStr, wbAliasToInt),
            wbFormIDCk(KNAM, 'Keyword', [KYWD]),
            wbFormIDCk(ALRT, 'Ref Type', [LCRT])
          ]),
          wbRStruct('External Alias Reference', [
            wbFormIDCk(ALEQ, 'Quest', [QUST]),
            wbInteger(ALEA, 'Alias', itS32, wbQuestExternalAliasToStr, wbAliasToInt)
          ]),
          wbRStruct('Create Reference to Object', [
            wbFormID(ALCO, 'Object'),
            wbStruct(ALCA, 'Alias', [
              wbInteger('Alias', itS16, wbQuestAliasToStr, wbAliasToInt),
              wbInteger('Create', itU16, wbEnum([] ,[
                $0000, 'At',
                $8000, 'In'
              ]))
            ]),
            wbInteger(ALCL, 'Level', itU32, wbEnum([
              'Easy',
              'Medium',
              'Hard',
              'Very Hard',
              'None'
            ]))
          ]),
          wbRStruct('Find Matching Reference Near Alias', [
            wbInteger(ALNA, 'Alias', itS32, wbQuestAliasToStr, wbAliasToInt),
            wbInteger(ALNT, 'Type', itU32, wbEnum([
              'Linked From',
              'Linked Ref'
            ]))
          ]),
          wbRStruct('Find Matching Reference From Event', [
            wbInteger(ALFE, 'From Event', itU32, wbQuestEventEnum),
            wbInteger(ALFD, 'Event Data', itU32, wbEventMemberEnum)
          ]),
          wbInteger(ALCC, 'Closest To Alias', itS32, wbQuestAliasToStr, wbAliasToInt),
          wbConditions,
          wbKeywords,
          wbCOCT,
          wbCNTOs,
          wbFormIDCk(SPOR, 'Spectator override package list', [FLST], False, cpNormal, False),
          wbFormIDCk(OCOR, 'Observe dead body override package list', [FLST], False, cpNormal, False),
          wbFormIDCk(GWOR, 'Guard warn override package list', [FLST], False, cpNormal, False),
          wbFormIDCk(ECOR, 'Combat override package list', [FLST], False, cpNormal, False),
          wbArray(ALLA, 'Linked Aliases', wbStruct('Linked Alias', [
            wbFormIDCk('Keyword', [KYWD, NULL]),
            wbInteger('Alias', itS32, wbQuestAliasToStr, wbAliasToInt)
          ])),
          wbFormIDCk(ALDN, 'Display Name', [MESG]),
          wbFormIDCk(ALFV, 'Forced Voice', [VTYP]),
          wbFormIDCk(ALDI, 'Death Item', [LVLI]),
          wbRArrayS('Alias Spells', wbFormIDCk(ALSP, 'Spell', [SPEL])),
          wbRArrayS('Alias Factions', wbFormIDCk(ALFC, 'Faction', [FACT])),
          wbRArray('Alias Package Data', wbFormIDCk(ALPC, 'Package', [PACK])),
          wbFormIDCk(VTCK, 'Voice Types', [NPC_, FACT, FLST, VTYP, NULL]),
          wbEmpty(ALED, 'Alias End', cpNormal, True)
        ], [], cpNormal, False, nil, False, nil, wbContainerAfterSet)
          .SetSummaryKey([1, 2])
          .SetSummaryDelimiter(' ')
          .SetSummaryMemberPrefixSuffix(0, 'Ref [', ']')
          .SetSummaryMemberPrefixSuffix(1, '', '')
          .SetSummaryMemberPrefixSuffix(2, '{', '}')
          .IncludeFlag(dfSummaryMembersNoName)
          .IncludeFlag(dfCollapsed, wbCollapseAliases),

        // Location Alias
        wbRStructSK([0], 'Alias', [
          wbInteger(ALLS, 'Location Alias ID', itU32),
          wbString(ALID, 'Alias Name'),
          wbQUSTAliasFlags,
          wbInteger(ALFI, 'Force Into Alias When Filled', itS32, wbQuestAliasToStr, wbAliasToInt),
          wbFormIDCk(ALFL, 'Specific Location', [LCTN]),
          wbRStruct('Reference Alias Location', [
            wbInteger(ALFA, 'Alias', itS32, wbQuestAliasToStr, wbAliasToInt),
            wbFormIDCk(KNAM, 'Keyword', [KYWD])
          ]),
          wbRStruct('External Alias Location', [
            wbFormIDCk(ALEQ, 'Quest', [QUST]),
            wbInteger(ALEA, 'Alias', itS32, wbQuestExternalAliasToStr, wbAliasToInt)
          ]),
          wbRStruct('Find Matching Location From Event', [
            wbInteger(ALFE, 'From Event', itU32, wbQuestEventEnum),
            wbInteger(ALFD, 'Event Data', itU32, wbEventMemberEnum)
          ]),
          wbConditions,
          wbInteger(ALCC, 'Closest To Alias', itS32, wbQuestAliasToStr, wbAliasToInt),
          wbEmpty(ALED, 'Alias End', cpNormal, True)
        ]).SetSummaryKey([1, 2])
          .SetSummaryDelimiter(' ')
          .SetSummaryMemberPrefixSuffix(0, 'Loc [', ']')
          .SetSummaryMemberPrefixSuffix(1, '', '')
          .SetSummaryMemberPrefixSuffix(2, '{', '}')
          .IncludeFlag(dfSummaryMembersNoName)
          .IncludeFlag(dfCollapsed, wbCollapseAliases),

        // Ref Collection Alias
        wbRStructSK([0], 'Alias', [
          wbInteger(ALCS, 'Collection Alias ID', itU32),
          wbInteger(ALMI, 'Max Initial Fill Count', itU8)
        ]).SetSummaryKey([1])
          .SetSummaryDelimiter(' ')
          .SetSummaryMemberPrefixSuffix(0, 'RefCol [', ']')
          .SetSummaryMemberPrefixSuffix(1, 'Max Init Fill [', ']')
          .IncludeFlag(dfSummaryMembersNoName)
          .IncludeFlag(dfCollapsed, wbCollapseAliases)

      ])
    ),

    wbString(NNAM, 'Description', 0, cpTranslate, False),
    wbFormIDCk(GNAM, 'Quest Group', [KYWD]),
    wbString(SNAM, 'SWF File')
  ]);

  wbPhonemeTargets := wbStruct(PHWT, 'Phoneme Target Weight', [
    wbFloat('Aah / LipBigAah'),
    wbFloat('BigAah / LipDST'),
    wbFloat('BMP / LipEee'),
    wbFloat('ChJsh / LipFV'),
    wbFloat('DST / LipK'),
    wbFloat('Eee / LipL'),
    wbFloat('Eh / LipR'),
    wbFloat('FV / LipTh'),
    wbFloat('I'),
    wbFloat('K'),
    wbFloat('N'),
    wbFloat('Oh'),
    wbFloat('OohQ'),
    wbFloat('R'),
    wbFloat('TH'),
    wbFloat('W'),
    wbUnknown
  ], cpNormal, False, nil, 1); // only a single value in HandyRace

  wbPHWT := wbRStruct('FaceFX Phonemes', [
    wbRStruct('IY', [wbPhonemeTargets]),
    wbRStruct('IH', [wbPhonemeTargets]),
    wbRStruct('EH', [wbPhonemeTargets]),
    wbRStruct('EY', [wbPhonemeTargets]),
    wbRStruct('AE', [wbPhonemeTargets]),
    wbRStruct('AA', [wbPhonemeTargets]),
    wbRStruct('AW', [wbPhonemeTargets]),
    wbRStruct('AY', [wbPhonemeTargets]),
    wbRStruct('AH', [wbPhonemeTargets]),
    wbRStruct('AO', [wbPhonemeTargets]),
    wbRStruct('OY', [wbPhonemeTargets]),
    wbRStruct('OW', [wbPhonemeTargets]),
    wbRStruct('UH', [wbPhonemeTargets]),
    wbRStruct('UW', [wbPhonemeTargets]),
    wbRStruct('ER', [wbPhonemeTargets]),
    wbRStruct('AX', [wbPhonemeTargets]),
    wbRStruct('S',  [wbPhonemeTargets]),
    wbRStruct('SH', [wbPhonemeTargets]),
    wbRStruct('Z',  [wbPhonemeTargets]),
    wbRStruct('ZH', [wbPhonemeTargets]),
    wbRStruct('F',  [wbPhonemeTargets]),
    wbRStruct('TH', [wbPhonemeTargets]),
    wbRStruct('V',  [wbPhonemeTargets]),
    wbRStruct('DH', [wbPhonemeTargets]),
    wbRStruct('M',  [wbPhonemeTargets]),
    wbRStruct('N',  [wbPhonemeTargets]),
    wbRStruct('NG', [wbPhonemeTargets]),
    wbRStruct('L',  [wbPhonemeTargets]),
    wbRStruct('R',  [wbPhonemeTargets]),
    wbRStruct('W',  [wbPhonemeTargets]),
    wbRStruct('Y',  [wbPhonemeTargets]),
    wbRStruct('HH', [wbPhonemeTargets]),
    wbRStruct('B',  [wbPhonemeTargets]),
    wbRStruct('D',  [wbPhonemeTargets]),
    wbRStruct('JH', [wbPhonemeTargets]),
    wbRStruct('G',  [wbPhonemeTargets]),
    wbRStruct('P',  [wbPhonemeTargets]),
    wbRStruct('T',  [wbPhonemeTargets]),
    wbRStruct('K',  [wbPhonemeTargets]),
    wbRStruct('CH', [wbPhonemeTargets]),
    wbRStruct('SIL', [wbPhonemeTargets]),
    wbRStruct('SHOTSIL', [wbPhonemeTargets]),
    wbRStruct('FLAP', [wbPhonemeTargets])
  ]);

  wbRaceRBPC :=
    wbArray(RBPC, 'Biped Object Conditions',
      wbUnion('Slot 30+', wbFormVersionDecider(78), [
        wbInteger('Slot 30+', itU32),
        wbFormIDCk('Slot 30+', [AVIF, NULL])
      ])
    );
    // since version 78: array of pair of AVIF FormID, before array of AVIF index. Similar to DamageType (and MGEF also somehow).
    {wbUnion(RBPC, 'Biped Object Conditions', wbFormVersionDecider(78), [
      wbArray('Biped Object Conditions', wbInteger('Condition AV', itU32)),
      wbArray('Biped Object Conditions', wbStruct('Condition AV', [
        wbFormIDck('AVIF 1', [AVIF, NULL]),
        wbFormIDck('AVIF 2', [AVIF, NULL])
      ]))
    ]);}

  var wbEquipSlot :=
    wbRStruct('Equip Slot', [
      wbFormIDCk(QNAM, 'Equip Slot', [EQUP]),
      wbString(ZNAM, 'Node')
    ])
    .SetSummaryKey([1, 0])
    .SetSummaryDelimiter(' = ')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseEquipSlots);

  var wbBodyParts :=
    wbRArrayS('Parts',
      wbRStructSK([0], 'Part', [
        wbUnused(INDX, 0),
        wbGenericModel
      ])
      .SetSummaryKey([0, 1])
      .SetSummaryMemberPrefixSuffix(0, '[', ']')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfSummaryNoSortKey)
      .IncludeFlag(dfCollapsed, wbCollapseBodyParts)
    , cpNormal, True);

  wbRecord(RACE, 'Race',
    wbFlags(wbFlagsList([
      {0x00080000} 19, 'Unknown 19'
    ])), [
    wbEDID,
    wbSTCP,
    wbFULL,
    wbDESCReq,
    wbSPCT,
    wbSPLOs,
    wbFormIDCk(WNAM, 'Skin', [ARMO, NULL]),
    wbBOD2,
    wbKeywords,
    wbPRPS,
    wbAPPR,
    wbStruct(DATA, 'Data', [
      wbFloat('Male Height'),
      wbFloat('Female Height'),
      wbFromVersion(109, wbStruct('Male Default Weight', [
        wbFloat('Thin'),
        wbFloat('Muscular'),
        wbFloat('Fat')
      ])),
      wbFromVersion(109, wbStruct('Female Default Weight', [
        wbFloat('Thin'),
        wbFloat('Muscular'),
        wbFloat('Fat')
      ])),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Playable',
        {0x00000002} 'FaceGen Head',
        {0x00000004} 'Child',
        {0x00000008} 'Tilt Front/Back',
        {0x00000010} 'Tilt Left/Right',
        {0x00000020} 'No Shadow',
        {0x00000040} 'Swims',
        {0x00000080} 'Flies',
        {0x00000100} 'Walks',
        {0x00000200} 'Immobile',
        {0x00000400} 'Not Pushable',
        {0x00000800} 'No Combat In Water',
        {0x00001000} 'No Rotating to Head-Track',
        {0x00002000} 'Don''t Show Blood Spray',
        {0x00004000} 'Don''t Show Blood Decal',
        {0x00008000} 'Uses Head Track Anims',
        {0x00010000} 'Spells Align w/Magic Node',
        {0x00020000} 'Use World Raycasts For FootIK',
        {0x00040000} 'Allow Ragdoll Collision',
        {0x00080000} 'Regen HP In Combat',
        {0x00100000} 'Can''t Open Doors',
        {0x00200000} 'Allow PC Dialogue',
        {0x00400000} 'No Knockdowns',
        {0x00800000} 'Allow Pickpocket',
        {0x01000000} 'Always Use Proxy Controller',
        {0x02000000} 'Don''t Show Weapon Blood',
        {0x04000000} 'Overlay Head Part List', {>>>Only one can be active<<<}
        {0x08000000} 'Override Head Part List', {>>>Only one can be active<<<}
        {0x10000000} 'Can Pickup Items',
        {0x20000000} 'Allow Multiple Membrane Shaders',
        {0x40000000} 'Can Dual Wield',
        {0x80000000} 'Avoids Roads'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFloat('Acceleration Rate'),
      wbFloat('Deceleration Rate'),
      wbInteger('Size', itU32, wbEnum([
        'Small',
        'Medium',
        'Large',
        'Extra Large'
      ])),
      wbByteArray('Unknown Bytes1', 4),
      wbByteArray('Unknown Bytes2', 4),
      wbFloat('Injured Health Pct'),
      wbInteger('Shield Biped Object', itS32, wbBipedObjectEnum),
      wbFromVersion(124, wbInteger('Beard Biped Object', itS32, wbBipedObjectEnum)),
      wbInteger('Body Biped Object', itS32, wbBipedObjectEnum),
      wbFloat('Aim Angle Tolerance'),
      wbFloat('Flight Radius'),
      wbFloat('Angular Acceleration Rate'),
      wbFloat('Angular Tolerance'),
      wbInteger('Flags 2', itU32, wbFlags([
        {0x00000001} 'Use Advanced Avoidance',
        {0x00000002} 'Non-Hostile',
        {0x00000004} 'Floats',
        {0x00000008} 'Unknown 3',
        {0x00000010} 'Unknown 4',
        {0x00000020} 'Head Axis Bit 0',
        {0x00000040} 'Head Axis Bit 1',
        {0x00000080} 'Can Melee When Knocked Down',
        {0x00000100} 'Use Idle Chatter During Combat',
        {0x00000200} 'Ungendered',
        {0x00000400} 'Can Move When Knocked Down',
        {0x00000800} 'Use Large Actor Pathing',
        {0x00001000} 'Use Subsegmented Damage',
        {0x00002000} 'Flight - Defer Kill',
        {0x00004000} 'Unknown 14',
        {0x00008000} 'Flight - Allow Procedural Crash Land',
        {0x00010000} 'Disable Weapon Culling',
        {0x00020000} 'Use Optimal Speeds',
        {0x00040000} 'Has Facial Rig',
        {0x00080000} 'Can Use Crippled Limbs',
        {0x00100000} 'Use Quadruped Controller',
        {0x00200000} 'Low Priority Pushable',
        {0x00400000} 'Cannot Use Playable Items'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFloat('Unknown Float1'),
      wbFloat('Unknown Float2'),
      wbByteArray('Unknown Bytes3',4),
      wbByteArray('Unknown Bytes4',4),
      wbByteArray('Unknown Bytes5',4),
      wbByteArray('Unknown Bytes6',4),
      wbByteArray('Unknown Bytes7',4),
      wbFloat('Unknown Float3'),
      wbByteArray('Unknown Bytes8',4),
      wbInteger('Pipboy Biped Object', itS32, wbBipedObjectEnum),
      wbInteger('XP Value', itS16),
      wbFloat('Severable - Debris Scale'),
      wbInteger('Severable - Debris Count', itU8),
      wbInteger('Severable - Decal Count', itU8),
      wbFloat('Explodable - Debris Scale'),
      wbInteger('Explodable - Debris Count', itU8),
      wbInteger('Explodable - Decal Count', itU8),
      wbFormIDCk('Severable - Explosion', [EXPL, NULL]),
      wbFormIDCk('Severable - Debris', [DEBR, NULL]),
      wbFormIDCk('Severable - Impact DataSet', [IPDS, NULL]),
      wbFormIDCk('Explodable - Explosion', [EXPL, NULL]),
      wbFormIDCk('Explodable - Debris', [DEBR, NULL]),
      wbFormIDCk('Explodable - Impact DataSet', [IPDS, NULL]),
      wbFromVersion(96, wbStruct('OnCripple', [
        wbFloat('Debris Scale'),
        wbInteger('Debris Count', itU8),
        wbInteger('Decal Count', itU8),
        wbFormIDCk('Explosion', [EXPL, NULL]),
        wbFormIDCk('Debris', [DEBR, NULL]),
        wbFormIDCk('Impact DataSet', [IPDS, NULL])
      ])),
      wbFromVersion(118, wbFormIDCk('Explodable - Subsegment Explosion', [EXPL, NULL])),
      wbFromVersion(98, wbFloat('Orientation Limits - Pitch')),
      wbFromVersion(101, wbFloat('Orientation Limits - Roll'))
    ], cpNormal, True),

    wbEmpty(MNAM, 'Male Marker'),
    wbString(ANAM, 'Male Skeletal Model'),
    wbMODT,
    wbEmpty(FNAM, 'Female Marker'),
    wbString(ANAM, 'Female Skeletal Model'),
    wbMODT,
    wbEmpty(NAM2, 'Marker NAM2 #1'),
    wbRArrayS('Movement Type Names', wbString(MTNM, 'Name', 4)),
    wbArray(VTCK, 'Voices', wbFormIDCk('Voice', [VTYP]), ['Male', 'Female'], cpNormal, True),
    //wbArray(DNAM, 'Decapitate Armors', wbFormIDCk('Decapitate Armor', [NULL, ARMO]), ['Male', 'Female'], cpNormal, False),
    wbArray(HCLF, 'Default Hair Colors', wbFormIDCk('Default Hair Color', [NULL, CLFM]), ['Male', 'Female'], cpNormal, False),
    wbInteger(TINL, 'Total Number of Tints in List', itU16, nil, nil, cpNormal, False), {>>> Needs Count Updated <<<}
    wbFloat(PNAM, 'FaceGen - Main clamp', cpNormal, True),
    wbFloat(UNAM, 'FaceGen - Face clamp', cpNormal, True),

    wbFormIDCk(ATKR, 'Attack Race', [RACE], False, cpNormal, False),
    wbRArrayS('Attacks', wbAttackData),

    wbRStruct('Body Data', [
      wbEmpty(NAM1, 'Body Data Marker', cpNormal, True),
      wbRStruct('Male Body Data', [
        wbEmpty(MNAM, 'Male Data Marker'),
        wbBodyParts
      ], [], cpNormal, True),
      wbRStruct('Female Body Data', [
        wbEmpty(FNAM, 'Female Data Marker', cpNormal, True),
        wbBodyParts
      ], [], cpNormal, True)
    ], [], cpNormal, True),
    wbFormIDCk(GNAM, 'Body Part Data', [BPTD]),

    wbEmpty(NAM2, 'Marker NAM2 #2', cpNormal),
    wbEmpty(NAM3, 'Marker NAM3 #3', cpNormal, True),
    wbRStruct('Male Behavior Graph', [
      wbEmpty(MNAM, 'Male Data Marker'),
      wbGenericModel
    ], [], cpNormal, True)
    .SetSummaryKey([1])
    .IncludeFlag(dfCollapsed, wbCollapseModels),
    wbRStruct('Female Behavior Graph', [
      wbEmpty(FNAM, 'Female Data Marker', cpNormal, True),
      wbGenericModel
    ], [], cpNormal, True)
    .SetSummaryKey([1])
    .IncludeFlag(dfCollapsed, wbCollapseModels),

    wbFormIDCk(NAM4, 'Impact Material Type', [MATT]),
    wbFormIDCk(NAM5, 'Impact Data Set', [IPDS]),
    wbFormIDCk(NAM7, 'Dismember Blood Art', [ARTO]),
    wbFormIDCk(CNAM, 'Meat Cap TextureSet', [TXST]),
    wbFormIDCk(NAM2, 'Collar TextureSet', [TXST]),
    wbFormIDCk(ONAM, 'Sound - Open Corpse', [SNDR]),
    wbFormIDCk(LNAM, 'Sound - Close Corpse', [SNDR]),
    wbRArray('Biped Object Names', wbString(NAME, 'Name')),
    wbRaceRBPC,
    wbRArrayS('Movement Data Overrides', wbRStructSK([0], 'Override', [
      wbFormIDCk(MTYP, 'Movement Type', [MOVT]),
      wbSPED
    ])),
    wbInteger(VNAM, 'Equipment Flags', itU32, wbEquipType).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbRArray('Equip Slots', wbEquipSlot),
    wbFormIDCk(UNWP, 'Unarmed Weapon', [WEAP]),

    wbRArray('Phoneme Target Names', wbString(PHTN, 'Name')),
    wbPHWT,

    wbFormIDCk(WKMV, 'Base Movement Defaults - Default', [MOVT]),
    wbFormIDCk(SWMV, 'Base Movement Defaults - Swim', [MOVT]),
    wbFormIDCk(FLMV, 'Base Movement Defaults - Fly', [MOVT]),
    wbFormIDCk(SNMV, 'Base Movement Defaults - Sneak', [MOVT]),

    // Male head
    wbEmpty(NAM0, 'Head Data Marker'),
    wbEmpty(MNAM, 'Male Data Marker'),
    wbStruct(NNAM, 'Male Neck Fat Adjustments Scale', [
      wbByteArray('Unknown', 4),
      wbFloat('X'),
      wbFloat('Y')
    ]),
    wbRArrayS('Male Head Parts', wbHeadPart),
    wbRArray('Male Race Presets', wbFormIDCk(RPRM, 'Preset NPC', [NPC_, NULL])),
    wbRArray('Male Hair Colors', wbFormIDCk(AHCM, 'Hair Color', [CLFM, NULL])),
    wbRArrayS('Male Face Details', wbFormIDCk(FTSM, 'Texture Set', [TXST, NULL])),
    wbFormIDCk(DFTM, 'Male Default Face Texture', [TXST]),
    wbTintTemplateGroups('Male Tint Layers'),
    wbMorphGroups('Male Morph Groups'),
    wbFaceMorphs('Male Face Morphs'),
    wbString(WMAP, 'Male Wrinkle Map Path'),

    // Female head
    wbEmpty(NAM0, 'Head Data Marker'),
    wbEmpty(FNAM, 'Female Data Marker'),
    wbStruct(NNAM, 'Female Neck Fat Adjustments Scale', [
      wbByteArray('Unknown', 4),
      wbFloat('X'),
      wbFloat('Y')
    ]),
    wbRArrayS('Female Head Parts', wbHeadPart),
    wbRArray('Female Race Presets', wbFormIDCk(RPRF, 'Preset NPC', [NPC_, NULL])),
    wbRArray('Female Hair Colors', wbFormIDCk(AHCF, 'Hair Color', [CLFM, NULL])),
    wbRArrayS('Female Face Details', wbFormIDCk(FTSF, 'Texture Set', [TXST, NULL])),
    wbFormIDCk(DFTF, 'Female Default Face Texture', [TXST]),
    wbTintTemplateGroups('Female Tint Layers'),
    wbMorphGroups('Female Morph Groups'),
    wbFaceMorphs('Female Face Morphs'),
    wbString(WMAP, 'Female Wrinkle Map Path'),

    wbFormIDCk(NAM8, 'Morph Race', [RACE]),
    wbFormIDCk(RNAM, 'Armor Race', [RACE]),
    wbFormIDCk(SRAC, 'Subgraph Template Race', [RACE]),
    wbFormIDCk(SADD, 'Subgraph Additive Race', [RACE]),
    wbRArray('Subgraph Data',
      wbRStruct('Data', [
        wbRArray('Actor Keywords', wbFormIDCk(SAKD, 'Keyword', [KYWD])).IncludeFlag(dfCollapsed, wbCollapseKeywords),
        wbString(SGNM, 'Behaviour Graph'),
        wbRArray('Animation Paths', wbString(SAPT, 'Path'), cpNormal, True),
        wbRArray('Target Keywords', wbFormIDCk(STKD, 'Keyword', [KYWD])).IncludeFlag(dfCollapsed, wbCollapseKeywords),
        // Values greater than $10000 sets a bool. Reading this "closes" the current record.
        wbStruct(SRAF, 'Flags', [
          wbInteger('Role', itU16, wbEnum([
            {0} 'MT',
            {1} 'Weapon',
            {2} 'Furniture',
            {3} 'Idle',
            {4} 'Pipboy'
          ])),
          wbInteger('Perspective', itU16, wbEnum([
            '3rd',
            '1st'
          ]))
        ], cpNormal, True)
        .SetSummaryKeyOnValue([0, 1])
        .IncludeFlag(dfTerminator)
      ], [], cpNormal, False, nil, True)
    ),
    wbFloat(PTOP, 'Idle Chatter Time Min'),
    wbFloat(NTOP, 'Idle Chatter Time Max'),
    wbRArray('Morph Values',
      wbRStruct('Value', [
        wbInteger(MSID, 'Index', itU32, wbIntToHexStr, wbHexStrToInt),
        wbString(MSM0, 'Min Name'),
        wbString(MSM1, 'Max Name')
      ])
    ),
    wbInteger(MLSI, 'Morph Last Index', itU32, wbIntToHexStr, wbHexStrToInt),
    wbString(HNAM, 'Hair Color Lookup Texture'),
    wbString(HLTX, 'Hair Color Extended Lookup Texture'),
    wbFormIDCk(QSTI, 'Dialogue Quest', [QUST]),
    wbBSMPSequence
  ], False, nil, cpNormal, False, nil, wbRACEAfterSet);


  wbRefRecord(REFR, 'Placed Object', wbFormaterUnion(wbREFRRecordFlagsDecider, [
    wbFlags(wbFlagsList([
      {0x00000010}  4, 'Ground Piece',
      {0x00000100}  8, 'LOD Respects Enable State',
      {0x00000400} 10, 'Persistent',
      {0x00000800} 11, 'Initially Disabled',
      {0x00010000} 16, 'Is Full LOD',
      {0x04000000} 26, 'Filter (Collision Geometry)',
      {0x08000000} 27, 'Bounding Box (Collision Geometry)',
      {0x10000000} 28, 'Reflected By Auto Water',
      {0x40000000} 30, 'Ground',
      {0x80000000} 31, 'Multibound'
    ], True, True)),
    {ACTI STAT SCOL TREE} wbFlags(wbFlagsList([
      {0x00000010}  4, 'Ground Piece',
      {0x00000100}  8, 'LOD Respects Enable State',
      {0x00000200}  9, 'Hidden From Local Map',
      {0x00000400} 10, 'Persistent',
      {0x00000800} 11, 'Initially Disabled',
      {0x00008000} 15, 'Visible when distant',
      {0x00010000} 16, 'Is Full LOD',
      {0x04000000} 26, 'Filter (Collision Geometry)',
      {0x08000000} 27, 'Bounding Box (Collision Geometry)',
      {0x10000000} 28, 'Reflected By Auto Water',
      {0x20000000} 29, 'Don''t Havok Settle',
      {0x40000000} 30, 'No Respawn',
      {0x80000000} 31, 'Multibound'
    ], True, True)),
    {CONT TERM} wbFlags(wbFlagsList([
      {0x00000010}  4, 'Ground Piece',
      {0x00000400} 10, 'Persistent',
      {0x00000800} 11, 'Initially Disabled',
      {0x00010000} 16, 'Is Full LOD',
      {0x02000000} 25, 'No AI Acquire',
      {0x04000000} 26, 'Filter (Collision Geometry)',
      {0x08000000} 27, 'Bounding Box (Collision Geometry)',
      {0x20000000} 29, 'Don''t Havok Settle',
      {0x40000000} 30, 'Ground',
      {0x80000000} 31, 'Multibound'
    ], True, True)),
    {DOOR} wbFlags(wbFlagsList([
      {0x00000004}  2, 'Minimal Use Door',
      {0x00000040}  6, 'Hidden From Local Map',
      {0x00000100}  8, 'Inaccessible',
      {0x00000400} 10, 'Persistent',
      {0x00000800} 11, 'Initially Disabled',
      {0x00010000} 16, 'Is Full LOD',
      {0x04000000} 26, 'Filter (Collision Geometry)',
      {0x08000000} 27, 'Bounding Box (Collision Geometry)',
      {0x20000000} 29, 'Don''t Havok Settle',
      {0x40000000} 30, 'No Respawn',
      {0x80000000} 31, 'Multibound'
    ], True, True)),
    {LIGH} wbFlags(wbFlagsList([
      {0x00000100}  8, 'Doesn''t Light Water',
      {0x00000200}  9, 'Casts Shadows',
      {0x00000400} 10, 'Persistent',
      {0x00000800} 11, 'Initially Disabled',
      {0x00010000} 16, 'Never Fades',
      {0x00020000} 17, 'Doesn''t Light Landscape',
      {0x02000000} 25, 'No AI Acquire',
      {0x10000000} 28, 'Reflected By Auto Water',
      {0x20000000} 29, 'Don''t Havok Settle',
      {0x40000000} 30, 'No Respawn',
      {0x80000000} 31, 'Multibound'
    ], True, True)),
    {MSTT} wbFlags(wbFlagsList([
      {0x00000010}  4, 'Ground Piece',
      {0x00000200}  9, 'Motion Blur',
      {0x00000400} 10, 'Persistent',
      {0x00000800} 11, 'Initially Disabled',
      {0x00010000} 16, 'Is Full LOD',
      {0x04000000} 26, 'Filter (Collision Geometry)',
      {0x08000000} 27, 'Bounding Box (Collision Geometry)',
      {0x10000000} 28, 'Reflected By Auto Water',
      {0x20000000} 29, 'Don''t Havok Settle',
      {0x40000000} 30, 'No Respawn',
      {0x80000000} 31, 'Multibound'
    ], True, True)),
    {ADDN} wbFlags(wbFlagsList([
      {0x00000400} 10, 'Persistent',
      {0x00000800} 11, 'Initially Disabled',
      {0x00010000} 16, 'Is Full LOD',
      {0x10000000} 28, 'Reflected By Auto Water',
      {0x20000000} 29, 'Don''t Havok Settle',
      {0x40000000} 30, 'No Respawn',
      {0x80000000} 31, 'Multibound'
    ], True, True)),
    {ALCH BOOK SCRL AMMO ARMO INGR KEYM MISC FURN WEAP}
    wbFlags(wbFlagsList([
      {0x00000010}  4, 'Ground Piece',
      {0x00000400} 10, 'Persistent',
      {0x00000800} 11, 'Initially Disabled',
      {0x00010000} 16, 'Is Full LOD',
      {0x02000000} 25, 'No AI Acquire',
      {0x10000000} 28, 'Reflected By Auto Water',
      {0x20000000} 29, 'Don''t Havok Settle',
      {0x40000000} 30, 'No Respawn',
      {0x80000000} 31, 'Multibound'
    ], True, True))
  ]), [
    wbEDID,
    wbVMAD,
    wbFormIDCk(NAME, 'Base', sigBaseObjects, False, cpNormal, True),

    {--- Bound Contents ---}
    {--- Bound Data ---}
    wbVec3(XMBO, 'Bound Half Extents'),

    {--- Primitive ---}
    wbStruct(XPRM, 'Primitive', [
      wbStruct('Bounds', [
        wbFloat('X', cpNormal, True, 2, 4),
        wbFloat('Y', cpNormal, True, 2, 4),
        wbFloat('Z', cpNormal, True, 2, 4)
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
      wbFloatColors('Color'),
      wbFloat('Unknown'),
      wbInteger('Type', itU32, wbEnum([
        'None',
        'Box',
        'Sphere',
        'Plane',
        'Line',
        'Ellipsoid'
      ]))
    ]),

    wbArray(XPOD, 'Portal Data', wbStruct('References', [
      wbFormIDCk('Origin', [REFR, NULL]),
      wbFormIDCk('Destination', [REFR, NULL])
    ])),

    // not seen in FO4 vanilla files, but can be added in CK
    wbSizePosRot(XPTL, 'Room Portal'),

    // Copied from FO3; assuming that the order is the same
    wbArray(XORD, 'Linked Occlusion References', wbFormIDCk('Reference', [REFR, NULL]), [
      'Right',
      'Left',
      'Bottom',
      'Top'
    ]),

    wbSizePosRot(XOCP, 'Occlusion Plane Data'),

    wbRStruct('Bound Data', [
      wbStruct(XRMR, 'Header', [
        wbInteger('Linked Rooms Count', itU8),
        wbInteger('Flags', itU8, wbFlags([
          'Unknown 1',
          'Unknown 2',
          'Unknown 3',
          'Unknown 4',
          'Unknown 5',
          'Unknown 6',
          'Has Image Space',
          'Has Lighting Template'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbByteArray('Unknown', 2)
      ]),
      wbFormIDCk(LNAM, 'Lighting Template', [LGTM]),
      wbFormIDCk(INAM, 'Image Space', [IMGS]),
      wbRArrayS('Linked Rooms',
        wbFormIDCk(XLRM, 'Linked Room', [REFR])
      ).SetCountPath('XRMR\Linked Rooms Count')
    ]),
    wbEmpty(XMBP, 'MultiBound Primitive Marker', cpIgnore),

    {--- Ragdoll ---}
    wbRagdoll,

    wbFloat(XRDS, 'Radius'),

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),
    wbStruct(XLIG, 'Light Data', [
      wbFloat('FOV 90+/-'),
      wbFloat('Fade 1.0+/-'),
      wbFloat('End Distance Cap'),
      wbFloat('Shadow Depth Bias'),
      wbFloat('Near Clip'),
      wbFloat('Volumetric Intensity')
    ], cpNormal, False, nil, 4),
    {--- Lit Water ---}
    wbRArrayS('Lit Water',
      wbFormIDCk(XLTW, 'Water', [ACHR, REFR])
    ),
    wbRArrayS('Reflected/Refracted By',
        wbStructSK(XPWR, [0], 'Water', [
          wbFormIDCk('Reference', [ACHR, REFR]),
          wbInteger('Type', itU32, wbFlags([
            'Reflection',
            'Refraction'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
        ], cpNormal, False, nil, 1)
      ),
    wbStruct(XALP, 'Alpha', [
      wbInteger('Cutoff', itU8),
      wbInteger('Base', itU8)
    ]),

    {--- Teleport ---}
    wbStruct(XTEL, 'Teleport Destination', [
      wbFormIDCk('Door', [REFR], True),
      wbPosRot,
      wbInteger('Flags', itU32, wbFlags([
        'No Alarm',
        'No Load Screen',
        'Relative Position'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFormIDCk('Transition Interior', [CELL, NULL])
    ]),
    wbFormIDCk(XTNM, 'Teleport Loc Name', [MESG]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

    {--- Placed Water ---}
    wbRStruct('Water Current Velocities', [
      wbInteger(XWCN, 'Velocity Count', itU32, nil, cpBenign),
      wbArray(XWCU, 'Velocities',
        wbStruct('Current', [
          wbVec3('Velocity'),
          wbFloat
        ])
      ).SetCountPathOnValue(XWCN, False)
       .SetRequired
       .IncludeFlag(dfCollapsed, wbCollapseOther)
       .IncludeFlag(dfNotAlignable)
    ]),

    wbFormIDCk(XASP, 'Acoustic Restriction', [REFR]),
    wbEmpty(XATP, 'Activation Point'),
    wbInteger(XAMC, 'Ammo Count', itU32),
    wbEmpty(XLKT, 'Linked Ref Transient'),
    wbFormIDCk(XLYR, 'Layer', [LAYR]),
    wbFormIDCk(XMSP, 'Material Swap', [MSWP]),
    wbFormIDCk(XRFG, 'Reference Group', [RFGP]),
    wbStruct(XRDO, 'Radio', [
      wbFloat('Frequency'),
      wbFloat('Min Weak Distance'),
      wbFloat('Max Weak Distance'),
      wbInteger('Flags', itU32, wbFlags(['Ignores Distance Checks'])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ]),
    wbStruct(XBSD, 'Spline', [
      wbFloat('Slack'),
      wbFloat('Thickness'),
      wbVec3('Half Extents'),
      wbInteger('Wind - Detached End', itU8, wbBoolEnum),
      wbUnused(0) // junk data?
    ], cpNormal, False, nil, 3),
    wbStruct(XPDD, 'Projected Decal', [
      wbFloat('Width Scale'),
      wbFloat('Height Scale')
      // "Uses Box Primitive" checkbox does the following:
      // 1. "Rounds" above floats (probably due to floating point precision)  [DIRTY EDITS?]
      // 2. "Rounds" DATA\Position floats (probably due to floating point precision)  [DIRTY EDITS?]
      // 3. Creates an XPRM subrecord (this is the "Primitive" tab in the editor)
      // 4. Fills out Primitive data:
      //    4a. Primitive type: Box
      //    4b. Collision layer: XTRI subrecord = 15
      //    4c. Bounds (XYZ): 256.0, 215.0, 256.0
      //    4d. Color (RGB): 0, 128, 128
      //    4e. Unknown: 0.4
    ]),
    wbFormIDCk(XSPC, 'Spawn Container', [REFR]),

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', sigReferences),
          wbFloat('Delay')
        ])
      )
    ]),

    wbFormIDCk(XLIB, 'Leveled Item Base Object', [LVLI]),
    wbXLCM,
    wbFormIDCk(XLCN, 'Persist Location', [LCTN]),

    {>>> COLL form Index value <<<}
    wbInteger(XTRI, 'Collision Layer', itU32)
      .SetLinksToCallbackOnValue(function(const aElement: IwbElement): IwbElement
      begin
        Result := nil;
        if not Assigned(aElement) then
          Exit;

        var lCollisionLayerIndex := aElement.NativeValue;
        if not VarIsOrdinal(lCollisionLayerIndex) then
          Exit;

        var lFile := aElement._File;
        if not Assigned(lFile) then
          Exit;

        Result := lFile.RecordFromIndexByKey[wbIdxCollisionLayer, lCollisionLayerIndex];
      end)
      .SetToStr(wbToStringFromLinksToMainRecordName),

    {--- Lock ---}
    wbStruct(XLOC, 'Lock Data', [
      wbInteger('Level', itU8, wbEnum([], [
         0, 'None',
         1, 'Novice 1',
        25, 'Novice 25',
        50, 'Advanced',
        75, 'Expert',
       100, 'Master',
       253, 'Requires Terminal',
       251, 'Barred',
       252, 'Chained',
       254, 'Inaccessible',
       255, 'Requires Key'
      ])),
      wbUnused(3),
      wbFormIDCkNoReach('Key', [KEYM, NULL]),
      wbInteger('Flags', itU8, wbFlags(['', '', 'Leveled Lock'])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbUnused(3),
      wbUnknown
    ], cpNormal, False, nil, 4),

    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    {--- Generated Data ---}
    wbStruct(XNDP, 'Navmesh Door Link', [
      wbFormIDCk('Navmesh', [NAVM]),
      wbInteger('Triangle', itS16, wbREFRNavmeshTriangleToStr, wbStringToInt),
      wbUnused(2)
    ]),

    wbFormIDCk(XLRL, 'Location Reference', [LCRT, LCTN, NULL], False, cpBenignIfAdded),
    wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),
    wbEmpty(XIS2, 'Ignored by Sandbox'),

    {--- Ownership ---}
    wbOwnership,

    wbInteger(XCNT, 'Item Count', itS32),
    wbInteger(XHLT, 'Health %', itU32),

    wbXESP,
    wbRArray('Linked References', wbStruct(XLKR, 'Linked Reference', [
      wbFormIDCk('Keyword/Ref', [KYWD, PLYR, ACHR, REFR, PGRE, PHZD, PMIS, PARW, PBAR, PBEA, PCON, PFLA, NULL]),
      wbFormIDCk('Ref', sigReferences)
    ], cpNormal, False, nil, 1)),

    wbRArray('Patrol', wbRStruct('Data', [
      wbFloat(XPRD, 'Idle Time', cpNormal, True),
      wbEmpty(XPPA, 'Patrol Script Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbPDTOs
    ])),

    {--- Flags ---}
    wbActionFlag,

    wbFloat(XHTW, 'Head-Tracking Weight'),
    wbFloat(XFVC, 'Favor Cost'),

    wbEmpty(ONAM, 'Open by Default'),

    {--- Map Data ---}
    wbRStruct('Map Marker', [
      wbEmpty(XMRK, 'Map Marker Data'),
      wbInteger(FNAM, 'Map Flags', itU8, wbFlags([
        {0x01} 'Visible',
        {0x02} 'Can Travel To',
        {0x04} '"Show All" Hidden',
        {0x08} 'Use Location Name'
      ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFULLReq,
      wbStruct(TNAM, '', [
        wbInteger('Type', itU8, wbEnum([], [
          {Vv = Verified Vanilla}
          {No new map markers for Automatron or Workshop}
          0, 'Cave', {Vv}
          1, 'City', {Vv}
          2, 'Diamond City', {Vv}
          3, 'Encampment', {Vv}
          4, 'Factory / Industrial Site', {Vv}
          5, 'Gov''t Building / Monument', {Vv}
          6, 'Metro Station', {Vv}
          7, 'Military Base', {Vv}
          8, 'Natural Landmark', {Vv}
          9, 'Office / Civic Building', {Vv}
          10, 'Ruins - Town', {Vv}
          11, 'Ruins - Urban', {Vv}
          12, 'Sanctuary', {Vv}
          13, 'Settlement', {Vv}
          14, 'Sewer / Utility Tunnels', {Vv}
          15, 'Vault', {Vv}
          16, 'Airfield', {Vv}
          17, 'Bunker Hill', {Vv}
          18, 'Camper', {Vv}
          19, 'Car', {Vv}
          20, 'Church', {Vv}
          21, 'Country Club', {Vv}
          22, 'Custom House', {Vv}
          23, 'Drive-In', {Vv}
          24, 'Elevated Highway', {Vv}
          25, 'Faneuil Hall', {Vv}
          26, 'Farm', {Vv}
          27, 'Filling Station', {Vv}
          28, 'Forested', {Vv}
          29, 'Goodneighbor', {Vv}
          30, 'Graveyard', {Vv}
          31, 'Hospital', {Vv}
          32, 'Industrial Dome', {Vv}
          33, 'Industrial Stacks', {Vv}
          34, 'Institute', {Vv}
          35, 'Irish Pride', {Vv}
          36, 'Junkyard', {Vv}
          37, 'Observatory', {Vv}
          38, 'Pier', {Vv}
          39, 'Pond / Lake', {Vv}
          40, 'Quarry', {Vv}
          41, 'Radioactive Area', {Vv}
          42, 'Radio Tower', {Vv}
          43, 'Salem', {Vv}
          44, 'School', {Vv}
          45, 'Shipwreck', {Vv}
          46, 'Submarine', {Vv}
          47, 'Swan Pond', {Vv}
          48, 'Synth Head', {Vv}
          49, 'Town', {Vv}
          50, 'Brotherhood of Steel', {Vv}
          51, 'Brownstone Townhouse', {Vv}
          52, 'Bunker', {Vv}
          53, 'Castle', {Vv}
          54, 'Skyscraper', {Vv}
          55, 'Libertalia', {Vv}
          56, 'Low-Rise Building', {Vv}
          57, 'Minutemen', {Vv}
          58, 'Police Station', {Vv}
          59, 'Prydwen', {Vv}
          60, 'Railroad - Faction', {Vv}
          61, 'Railroad', {Vv}
          62, 'Satellite', {Vv}
          63, 'Sentinel', {Vv}
          64, 'USS Constitution', {Vv}
          65, 'Mechanist Lair', {Vv}
          66, 'Raider settlement', {Vv}
          67, 'Vassal settlement', {Vv}
          68, 'Potential Vassal settlement', {Vv}
          69, 'Bottling Plant', {Vv}
          70, 'Galactic', {Vv}
          71, 'HUB', {Vv}
          72, 'Kiddie Kingdom', {Vv}
          73, 'Monorail', {Vv}
          74, 'Rides', {Vv}
          75, 'Safari', {Vv}
          76, 'Wild West', {Vv}
          77, 'POI', {Vv}
          78, 'Disciples', {Vv}
          79, 'Operators', {Vv}
          80, 'Pack', {Vv}
          81, 'Custom 81',
          82, 'Custom 82',
          83, 'Custom 83',
          84, 'Custom 84',
          85, 'Custom 85',
          86, 'Custom 86',
          87, 'Custom 87',
          88, 'Custom 88',
          89, 'Custom 89',
          90, 'Custom 90',
          91, 'Custom 91',
          92, 'Custom 92',
          93, 'Custom 93',
          94, 'Custom 94',
          95, 'Custom 95',
          96, 'Custom 96',
          97, 'Custom 97',
          98, 'Custom 98',
          99, 'Custom 99'
        ])),
        wbUnused(1)
      ], cpNormal, True)
    ]),

    {--- Attach reference ---}
    wbFormIDCk(XATR, 'Attach Ref', [REFR, PGRE, PHZD, PMIS, PARW, PBAR, PBEA, PCON, PFLA, ACHR]),

    wbRArray('Spline Connection', wbStruct(XPLK, 'Link', [
      wbFormIDCk('Ref', [REFR, ACHR]),
      wbUnknown  // always 00 00 00 00 so far in DLCWorkshop03.esm
    ])),

    wbRStruct('Power Grid', [
      wbInteger(XWPG, 'Count', itU32),
      wbRArray('Connections', wbStruct(XWPN, 'Connection', [
        wbFormIDCk('Node 1', [REFR, ACHR, NULL]),
        wbFormIDCk('Node 2', [REFR, ACHR, NULL]),
        wbFormIDCk('Line', [REFR, NULL]) // BNDS ref
      ]))
    ]),

    wbStruct(XCVR, 'Water Current Zone Data', [
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown')
    ]),
    wbStruct(XCVL, 'Water Current Zone Data', [
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown')
    ]),
    wbFormIDCk(XCZR, 'Current Zone Reference', sigReferences),
    wbUnknown(XCZA),
    wbFormIDCk(XCZC, 'Current Zone Cell', [CELL, NULL]),

    wbXSCL,
    wbXLOD, // not seen in FO4 vanilla files
    wbDataPosRot,
    wbString(MNAM, 'Comments')
  ], True).SetAddInfo(wbPlacedAddInfo).SetAfterLoad(wbREFRAfterLoad);

  wbRecord(REGN, 'Region',
    wbFlags(wbFlagsList([
      {0x00000040} 6, 'Border Region'
    ])), [
    wbEDID,
    wbByteColors(RCLR, 'Map Color'),
    wbFormIDCkNoReach(WNAM, 'Worldspace', [WRLD]),
    wbRegionAreas,
    wbRArrayS('Region Data Entries', wbRStructSK([0], 'Region Data Entry', [
      {always starts with an RDAT}
      wbStructSK(RDAT, [0], 'Data Header', [
        wbInteger('Type', itU32,
          wbEnum([], [
            2, 'Objects',
            3, 'Weather',
            4, 'Map',
            5, 'Land',
            6, 'Grass',
            7, 'Sound'
          ])
        ),
        wbInteger('Override', itU8, wbBoolEnum),
        wbInteger('Priority', itU8),
        wbByteArray('Unknown')
      ], cpNormal, True),

      {--- Icon ---}
      wbICON,

      {--- Sound ---}
      wbFormIDCk(RDMO, 'Music', [MUSC], False, cpNormal, False, wbREGNSoundDontShow),
      wbRegionSounds,

      {--- Map ---}
      wbLString(RDMP, 'Map Name', 0, cpTranslate, False, wbREGNMapDontShow),

      {followed by one of these: }

      {--- Objects ---}
      wbArray(RDOT, 'Objects', wbStruct('Object', [
        wbFormIDCk('Object', [TREE, FLOR, STAT, LTEX, MSTT, SCOL]),
        wbInteger('Parent Index', itU16, wbHideFFFF),
        wbByteArray('Unknown', 2),
        wbFloat('Density'),
        wbInteger('Clustering', itU8),
        wbInteger('Min Slope', itU8),
        wbInteger('Max Slope', itU8),
        wbInteger('Flags', itU8, wbFlags([
          {0}'Conform to slope',
          {1}'Paint Vertices',
          {2}'Size Variance +/-',
          {3}'X +/-',
          {4}'Y +/-',
          {5}'Z +/-',
          {6}'Tree',
          {7}'Huge Rock'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbInteger('Radius wrt Parent', itU16),
        wbInteger('Radius', itU16),
        wbFloat('Min Height'),
        wbFloat('Max Height'),
        wbFloat('Sink'),
        wbFloat('Sink Variance'),
        wbFloat('Size Variance'),
        wbStruct('Angle Variance', [
          wbInteger('X', itU16),
          wbInteger('Y', itU16),
          wbInteger('Z', itU16)
        ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
        wbByteArray('Unknown', 2),
        wbByteArray('Unknown', 4)
      ]), 0, nil, nil, cpNormal, False, wbREGNObjectsDontShow),

      {--- Grass ---}
      wbArrayS(RDGS, 'Grasses', wbStructSK([0], 'Grass', [
        wbFormIDCk('Grass', [GRAS]),
        wbByteArray('Unknown',4)
      ]), 0, cpNormal, False, nil, nil, wbREGNGrassDontShow),

      {--- Weather ---}
      wbArrayS(RDWT, 'Weather Types', wbStructSK([0], 'Weather Type', [
        wbFormIDCk('Weather', [WTHR]),
        wbInteger('Chance', itU32),
        wbFormIDCk('Global', [GLOB, NULL])
      ]), 0, cpNormal, False, nil, nil, wbREGNWeatherDontShow),

      wbFloat(RLDM, 'LOD Display Distance Multiplier'),
      wbFloat(ANAM, 'Occlusion Accuracy Dist')

    ]))
  ], True);

  wbRecord(SOUN, 'Sound Marker', [
    wbEDID,
    wbOBND(True),
    wbFormIDCk(SDSC, 'Sound Descriptor', [SNDR, NULL]),
    wbStruct(REPT, 'Repeat', [
      wbFloat('Min Time'),
      wbFloat('Max Time'),
      wbInteger('Stackable', itU8, wbBoolEnum)
    ], cpNormal, False, nil, 2)
  ]);

  wbSPIT := wbStruct(SPIT, 'Data', [
    wbInteger('Base Cost', itU32),
    wbInteger('Flags', itU32, wbFlags([
      {0x00000001} 'Manual Cost Calc',
      {0x00000002} 'Unknown 2',
      {0x00000004} 'Unknown 3',
      {0x00000008} 'Unknown 4',
      {0x00000010} 'Unknown 5',
      {0x00000020} 'Unknown 6',
      {0x00000040} 'Unknown 7',
      {0x00000080} 'Unknown 8',
      {0x00000100} 'Unknown 9',
      {0x00000200} 'Unknown 10',
      {0x00000400} 'Unknown 11',
      {0x00000800} 'Unknown 12',
      {0x00001000} 'Unknown 13',
      {0x00002000} 'Unknown 14',
      {0x00004000} 'Unknown 15',
      {0x00008000} 'Unknown 16',
      {0x00010000} 'Unknown 17',
      {0x00020000} 'PC Start Spell',
      {0x00040000} 'Instant Cast',
      {0x00080000} 'Area Effect Ignores LOS',
      {0x00100000} 'Ignore Resistance',
      {0x00200000} 'No Absorb/Reflect',
      {0x00400000} 'Unknown 23',
      {0x00800000} 'No Dual Cast Modification',
      {0x01000000} 'Unknown 25',
      {0x02000000} 'Unknown 26',
      {0x04000000} 'Unknown 27',
      {0x08000000} 'Unknown 28',
      {0x10000000} 'Unknown 29',
      {0x20000000} 'Unknown 30',
      {0x40000000} 'Unknown 31',
      {0x80000000} 'Unknown 32'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger('Type', itU32, wbEnum([
      {0} 'Spell',
      {1} 'Disease',
      {2} 'Power',
      {3} 'Lesser Power',
      {4} 'Ability',
      {5} 'Poison',
      {6} 'Unknown 6',
      {7} 'Unknown 7',
      {8} 'Unknown 8',
      {9} 'Unknown 9',
     {10} 'Addiction',
     {11} 'Voice'
    ])),
    wbFloat('Charge Time'),
    wbInteger('Cast Type', itU32, wbCastEnum),
    wbInteger('Target Type', itU32, wbTargetEnum),
    wbFloat('Cast Duration'),
    wbFloat('Range'),
    wbFormIDCk('Casting Perk', [NULL, PERK])
  ], cpNormal, True);

  wbRecord(SPEL, 'Spell', [
    wbEDID,
    wbOBND(True),
    wbFULL,
    wbKeywords,
    wbETYP,
    wbDESCReq,
    wbSPIT,
    wbEffectsReq
  ]);

  {wbRecord(SCRL, 'Scroll', [
    wbEDID
  ]);}

  wbRecord(STAT, 'Static',
    wbFlags(wbFlagsList([
      2, 'Heading Marker',
      4, 'Non Occluder',
      6, 'Has Tree LOD', // Used in Fallout 4 ?
      7, 'Add-On LOD Object',
      9, 'Hidden From Local Map',
     10, 'Headtrack Marker',
     11, 'Used as Platform',
     13, 'Pack-In Use Only',
     15, 'Has Distant LOD',
     17, 'Uses HD LOD Texture',
     19, 'Has Currents',
     23, 'Is Marker',
     25, 'Obstacle',
     26, 'NavMesh - Filter',
     27, 'NavMesh - Bounding Box',
     28, 'Show In World Map (Sky Cell Only)',
     30, 'NavMesh - Ground'
    ])).SetFlagHasDontShow(26, wbFlagNavmeshFilterDontShow)
       .SetFlagHasDontShow(27, wbFlagNavmeshBoundingBoxDontShow)
       .SetFlagHasDontShow(30, wbFlagNavmeshGroundDontShow), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbFTYP,
    wbGenericModel,
    wbPRPS,
    wbFULL,
    wbStruct(DNAM, 'Direction Material', [
      wbFloat('Max Angle (30-120)').SetDefaultNativeValue(90),
      wbFormIDCk('Material', [MATO, NULL]),
      wbFloat('Leaf Amplitude').SetDefaultNativeValue(1),
      wbFloat('Leaf Frequency').SetDefaultNativeValue(1)
    ], cpNormal, True, nil, 2),
    wbNVNM,
    wbStruct(MNAM, 'Distant LOD', [ {>>> Contains null-terminated mesh FileName followed by random data up to 260 bytes <<<}
      wbString(True, 'Level 0', 260),
      wbString(True, 'Level 1', 260),
      wbString(True, 'Level 2', 260),
      wbString(True, 'Level 3', 260)
    ])
  ], True);  // unordered, NVNM can be before or after MNAM

  wbRecord(TES4, 'Main File Header',
    wbFlags(wbFlagsList([
      0,  'ESM',
      4,  'Optimized',
      7,  'Localized',
      9,  IsVR(IsVRESL('ESL',''), 'ESL'),
      20, IsVRESL('Update', '')
    ], False), True), [
    wbHEDR,
    wbByteArray(OFST, 'Unknown', 0, cpIgnore),            // If possible then ignored by the runtime. Neither from the CK
    wbByteArray(DELE, 'Unknown', 0, cpIgnore),            // If possible then ignored by the runtime. Neither from the CK
    wbString(CNAM, 'Author', 0, cpTranslate, True),
    wbString(SNAM, 'Description', 0, cpTranslate),
    wbRArray('Master Files', wbRStruct('Master File', [
      wbStringForward(MAST, 'FileName', 0, cpNormal, True),
      // wbInteger(DATA, 'Filesize', itU64, nil, nil, cpIgnore, True)  // Should be set by CK but usually null
      wbByteArray(DATA, 'Unknown', 8, cpIgnore, True)
    ], [ONAM])).IncludeFlag(dfInternalEditOnly, not wbAllowMasterFilesEdit),
    wbArray(ONAM, 'Overridden Forms',                     // Valid in CK
      wbFormIDCk('Form', [ACHR, LAND, NAVM, REFR, PGRE, PHZD, PMIS, PARW, PBAR, PBEA, PCON, PFLA, DLBR, DIAL, INFO, SCEN]),
      0, nil, nil, cpNormal, False{, wbTES4ONAMDontShow}),
    wbByteArray(SCRN, 'Screenshot'),                      // If possible then ignored by the runtime. Neither from the CK
    wbRArray('Transient Types (CK only)', wbStruct(TNAM, 'Transient Type', [
      wbInteger('FormType', itU32), // seen TESTopic 78 (array of DIAL) and BGSScene 126 (array of SCEN)
      wbArray('Unknown', wbFormID('Unknown'))
    ])),          // Ignored by the runtime
    wbInteger(INTV, 'Unknown', itU32),                    // Ignored by the runtime, 4 bytes loaded in CK
    wbInteger(INCC, 'Interior Cell Count', itU32).SetRequired                     // Size of some array of 12 bytes elements
  ], True, nil, cpNormal, True);

  wbRecord(PLYR, 'Player Reference', [
    wbEDID,
    wbFormID(PLYR, 'Player', cpNormal, True).SetDefaultNativeValue($7)
  ]).IncludeFlag(dfInternalEditOnly);

  wbRecord(TREE, 'Tree',
    wbFlags(wbFlagsList([
      {0x00008000} 15, 'Has Distant LOD'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbGenericModel,
    wbFormIDCK(PFIG, 'Ingredient', sigBaseObjects),
    wbFormIDCK(SNAM, 'Harvest Sound', [SNDR, NULL]),
    wbStruct(PFPC, 'Ingredient Production', [
      wbInteger('Spring', itU8),
      wbInteger('Summer', itU8),
      wbInteger('Fall', itU8),
      wbInteger('Winter', itU8)
    ]),
    wbFULL,
    wbStruct(CNAM, 'Tree Data', [
      wbFloat('Trunk Flexibility').SetDefaultEditValue('1.0'),
      wbFloat('Branch Flexibility').SetDefaultEditValue('1.0'),
      wbFloat('Trunk Amplitude'),
      wbFloat('Front Amplitude'),
      wbFloat('Back Amplitude'),
      wbFloat('Side Amplitude'),
      wbFloat('Front Frequency'),
      wbFloat('Back Frequency'),
      wbFloat('Side Frequency'),
      wbFloat('Leaf Flexibility'),
      wbFloat('Leaf Amplitude').SetDefaultEditValue('1.0'),
      wbFloat('Leaf Frequency').SetDefaultEditValue('1.0')
    ], cpNormal, True)
  ]);

  wbRecord(FLOR, 'Flora', [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbFULLReq,
    wbGenericModel,
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbByteColors(PNAM, 'Marker Color (Unused)'),
    wbATTX,
    wbLStringKC(RNAM, 'Activate Text Override', 0, cpTranslate),
    wbInteger(FNAM, 'Flags', itU16, wbFlags([
      'No Displacement',
      'Ignored by Sandbox',
      'Unknown 2', {Only used on DefaultProceduralWater [ACTI:00000019]}
      'Unknown 3', {Currently Unused}
      'Is a Radio',
      'Is a Lookat Trigger',
      'Unknown 6' {Currently Unused}
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbFormIDCk(PFIG, 'Ingredient', [ALCH, AMMO, ARMO, BOOK, INGR, KEYM, LIGH, LVLI, MISC, NOTE, WEAP, NULL]),
    wbFormIDCK(SNAM, 'Harvest Sound', [SNDR]),
    wbStruct(PFPC, 'Ingredient Production', [
      wbInteger('Spring', itU8),
      wbInteger('Summer ', itU8),
      wbInteger('Fall', itU8),
      wbInteger('Winter', itU8)
    ], cpNormal, True)
  ]);

  {wbRecord(SCPT, 'SCPT', [
    wbEDID
  ]);}


{>>> Start of new Fallout 4 Records <<<}

  wbRecord(AECH, 'Audio Effect Chain', [
    wbEDID,
    wbRArray('Effects',
      wbRStruct('Effect', [
        wbInteger(KNAM, 'Type', itU32, wbEnum([], [
          Int64($864804BE), 'BSOverdrive',
          Int64($EF575F7F), 'BSStateVariableFilter',
          Int64($18837B4F), 'BSDelayEffect'
        ]), cpNormal, False, False, nil, nil, Int64($864804BE)).SetAfterSet(wbAECHTypeAfterSet),
        wbStruct(DNAM, 'Data', [
          wbInteger('Enabled', itU32, wbBoolEnum),
          wbUnion('Value', wbAECHDataDecider, [
            wbStruct('Overdrive', [
              wbFloat('Input Gain'), // exponentially(?) normalized from 0..10 to -80..20
              wbFloat('Output Gain'), // exponentially(?) normalized from 0..10 to -80..20
              wbFloat('Upper Threshold'), // exponentially(?) normalized from 0..1 to -74..0
              wbFloat('Lower Threshold') // exponentially(?) normalized from 0..1 to -80..0
            ]),
            wbStruct('State Variable Filter', [
              wbFloat('Center Freq'),
              wbFloat('Q Value'),
              wbInteger('Filter Mode', itU32, wbEnum([
                'High Pass',
                'Low Pass',
                'Band Pass',
                'Notch'
              ]))
            ]),
            wbStruct('Delay Effect', [
              wbFloat('Feedback %'),
              wbFloat('Wet Mix %'),
              wbInteger('Delay MS', itU32)
            ])
          ])
        ])
      ])
    )
  ]);

  wbRecord(AMDL, 'Aim Model', [
    wbEDID,
    wbStruct(DNAM, 'Data', [
      wbFloat('Cone of Fire - Min Angle').SetDefaultEditValue('2.0'),
      wbFloat('Cone of Fire - Max Angle').SetDefaultEditValue('8.0'),
      wbFloat('Cone of Fire - Increase Per Shot').SetDefaultEditValue('0.3'),
      wbFloat('Cone of Fire - Decrease Per Sec').SetDefaultEditValue('60.0'),
      wbInteger('Cone of Fire - Decrease Delay MS', itU32).SetDefaultEditValue('2'),
      wbFloat('Cone of Fire - Sneak Mult').SetDefaultEditValue('0.8'),
      wbFloat('Recoil - Diminish Spring Force').SetDefaultEditValue('125.0'),
      wbFloat('Recoil - Diminish Sights Mult').SetDefaultEditValue('1.0'),
      wbFloat('Recoil - Max Per Shot').SetDefaultEditValue('2.0'),
      wbFloat('Recoil - Min Per Shot').SetDefaultEditValue('0.25'),
      wbFloat('Recoil - Hip Mult').SetDefaultEditValue('1.0'),
      wbInteger('Runaway - Recoil Shots', itU32).SetDefaultEditValue('10'),
      wbFloat('Recoil - Arc').SetDefaultEditValue('60.0'),
      wbFloat('Recoil - Arc Rotate'),
      wbFloat('Cone of Fire - Iron Sights Mult'),
      wbFloat('Stability - Base Stability').SetDefaultEditValue('1.0')
    ])
  ]);

  wbRecord(AORU, 'Attraction Rule', [
    wbEDID,
    wbStruct(AOR2, 'Data', [
      wbFloat('Radius').SetDefaultEditValue('600'),
      wbFloat('Min Delay'),
      wbFloat('Max Delay').SetDefaultEditValue('30'),
      wbInteger('Requires Line of Sight', itU8, wbBoolEnum),
      wbInteger('Combat Target', itU8, wbBoolEnum),
      wbUnused(2)
    ], cpNormal, True)
  ]);

  wbRecord(BNDS, 'Bendable Spline', [
    wbEDID,
    wbOBND,
    wbStruct(DNAM, 'Data', [
      wbFloat('Default Number of Tiles').SetDefaultEditValue('1.0'),
      wbInteger('Default Number of Slices', itU16).SetDefaultEditValue('4.0'),
      wbInteger('Default Number of Tiles - Relative to Length', itU16, wbBoolEnum),
      wbFloatColors('Default Color'),
      wbFloat('Wind Settings - Sensibility'),
      wbFloat('Wind Settings - Flexibility')
    ]),
    wbFormIDCk(TNAM, 'Texture', [TXST])
  ]);

  wbRecord(CMPO, 'Component', [
    wbEDID,
    wbOBND,
    wbFULL,
    wbCUSD,
    wbInteger(DATA, 'Auto Calc Value', itU32),
    wbFormIDCk(MNAM, 'Scrap Item', [MISC]),
    wbFormIDCk(GNAM, 'Mod Scrap Scalar', [GLOB])
  ]);

  wbRecord(DFOB, 'Default Object', [
    wbEDID,
    wbFormID(DATA, 'Object')
  ])
  .IncludeFlag(dfIndexEditorID);

  wbRecord(DMGT, 'Damage Type', [
    wbEDID,
    // Before form version 78, it was an array of AVIF index, since then array of AVIF formID, coupled with a SPEL formID
    wbUnion(DNAM, 'Data', wbFormVersionDecider(78), [
      wbArray('Damage Types', wbInteger('Actor Value Index', itU32)),
      wbArray('Damage Types', wbStruct('Damage Type', [
        wbFormIDck('Actor Value', [AVIF, NULL]),
        wbFormIDck('Spell', [SPEL, NULL])
      ]))
    ])
  ]);

  wbRecord(GDRY, 'God Rays', [
    wbEDID,
    wbStruct(DATA, 'Data', [
      wbFloatColors('Back Color'),
      wbFloatColors('Fwd Color'),
      wbFloat('Intensity').SetDefaultEditValue('1.0'),
      wbFloat('Air Color - Scale').SetDefaultEditValue('3.0'),
      wbFloat('Back Color - Scale').SetDefaultEditValue('2.0'),
      wbFloat('Fwd Color - Scale').SetDefaultEditValue('4.0'),
      wbFloat('Back Phase'),
      wbFloatColors('Air Color'),
      wbFloat('Fwd Phase').SetDefaultEditValue('0.75')
    ])
  ]);

  wbRecord(INNR, 'Instance Naming Rules', [
    wbEDID,
    wbInteger(UNAM, 'Target', itU32, wbEnum([], [
        0, 'None',
      $1D, 'Armor',
      $2D, 'Actor',
      $2A, 'Furniture',
      $2B, 'Weapon'
    ])),
    wbRArray('Naming Rules',
      wbRStruct('Ruleset', [
        wbInteger(VNAM, 'Count', itU32),
        // should not be sorted
        wbRArray('Names',
          wbRStruct('Name', [
            wbLStringKC(WNAM, 'Text', 0, cpTranslate),
            wbKeywords,
            wbStruct(XNAM, 'Property', [
              wbFloat('Value'),
              wbInteger('Target', itU8, wbEnum([
                { 0} 'Enchantments',
                { 1} 'BashImpactDataSet',
                { 2} 'BlockMaterial',
                { 3} 'Keywords',
                { 4} 'Weight',
                { 5} 'Value',
                { 6} 'Rating',
                { 7} 'AddonIndex',
                { 8} 'BodyPart',
                { 9} 'DamageTypeValues',
                {10} 'ActorValues',
                {11} 'Health',
                {12} 'ColorRemappingIndex',
                {13} 'MaterialSwaps'
              ])),
              wbInteger('Op', itU8, wbEnum([
                {0} '>=',
                {1} '>',
                {2} '<=',
                {3} '<',
                {4} '='
              ]))
            ]),
            wbInteger(YNAM, 'Index', itU16)
          ]),
          cpNormal, False, nil, wbINNRAfterSet
        )
      ])
    )
  ]);

  wbRecord(KSSM, 'Sound Keyword Mapping', [
    wbEDID,
    wbFormIDCk(DNAM, 'Primary Descriptor', [SNDR]),
    wbFormIDCk(ENAM, 'Exterior Tail', [SNDR]),
    wbFormIDCk(VNAM, 'VATS Descriptor', [SNDR]),
    wbFloat(TNAM, 'VATS Threshold'),
    wbRArray('Keywords', wbFormIDCk(KNAM, 'Keyword', [KYWD])).IncludeFlag(dfCollapsed, wbCollapseKeywords),
    wbRArrayS('Sounds', wbStructSK(RNAM, [0], 'Sound', [
      wbInteger('Reverb Class', itU32, wbReverbClassEnum),
      wbFormIDCk('Descriptor', [SNDR])
    ])).IncludeFlag(dfCollapsed, wbCollapseSounds)
  ]);

  wbRecord(LAYR, 'Layer', [
    wbEDID,
    wbFormIDCk(PNAM, 'Parent', [LAYR])
  ]);

  wbRecord(LENS, 'Lens Flare', [
    wbEDID,
    wbFloat(CNAM, 'Color Influence'),
    wbFloat(DNAM, 'Fade Distance Radius Scale').SetDefaultEditValue('1.0'),
    wbInteger(LFSP, 'Count', itU32, nil, cpBenign),
    wbRArrayS('Lens Flare Sprites',
      wbRStructSK([0], 'Flare', [
        wbString(DNAM, 'Lens Flare Sprite ID'),
        wbString(FNAM, 'Texture'),
        wbStruct(LFSD, 'Lens Flare Data', [
          wbFloatColors('Tint'),
          wbFloat('Width'),
          wbFloat('Height'),
          wbFloat('Position'),
          wbFloat('Angular Fade'),
          wbFloat('Opacity'),
          wbInteger('Flags', itU32, wbFlags([
            {0x01} 'Rotates',
            {0x02} 'Shrinks When Occluded'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
        ])
      ]),
      cpNormal, False, nil, wbLENSAfterSet
    )
  ]);

  {wbRecord(LSPR, 'LSPR', [
    wbEDID
  ]);

  wbRecord(MICN, 'MICN', [
    wbEDID
  ]);}

  wbRecord(MSWP, 'Material Swap',
    wbFlags(wbFlagsList([
      {0x00010000} 16, 'Custom Swap'
    ])), [
    wbEDID,
    wbString(FNAM, 'Tree Folder'), {First FNAM}
    wbRArrayS('Material Substitutions',
      wbRStructSK([0], 'Substitution', [
        wbString(BNAM, 'Original Material'),
        wbString(SNAM, 'Replacement Material'),
        wbString(FNAM, 'Tree Folder (obsolete)'), {Unused, will be moved up to First FNAM}
        wbFloat(CNAM, 'Color Remapping Index')
      ])
    )
  ]);

  wbRecord(NOCM, 'Navmesh Obstacle Cover Manager', [
    wbEDID,
    wbRArray('Unknown',
        wbRStruct('Unknown', [
          wbInteger(INDX, 'Index', itU32),
          wbRArray('Unknown Datas',
            wbStruct(DATA, 'Unknown Data', [
              wbByteArray('Unknown 1',2),
              wbByteArray('Unknown 2',2),
              wbByteArray('Unknown 3',4)
            ])),
        wbUnknown(INTV)
      ])),
      wbString(NAM1, 'Model')
  ]);

  wbRecord(NOTE, 'Note', [
    wbEDID,
    wbVMAD,
    wbOBND,
    wbPTRN,
    wbFULL,
    wbGenericModel,
    wbICON,
    wbYNAM,
    wbZNAM,
    wbInteger(DNAM, 'Type', itU8,
      wbEnum([
        'Sound',
        'Voice',
        'Program',
        'Terminal'
      ])
    ),
    wbStruct(DATA, 'Attributes', [// was DNAM before form version 65. Now holds value and weight
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ]),
    wbUnion(SNAM, '', wbNoteTypeDecider, [
      wbUnused(4),
      wbFormIDCk('Sound', [SNDR]),
      wbFormIDCk('Scene', [SCEN]),
      wbFormIDCk('Terminal', [TERM])
    ]),
    wbString(PNAM, 'Program File')
  ]);

  wbRecord(OMOD, 'Object Modification',
    wbFlags(wbFlagsList([
      {0x00000008} 4, 'Legendary Mod',
      {0x00000040} 7, 'Mod Collection'
    ])), [
    wbEDID,
    wbFULL,
    wbDESC,
    wbGenericModel,
    wbStruct(DATA, 'Data', [
      wbInteger('Include Count', itU32),
      wbInteger('Property Count', itU32),
      wbInteger('Unknown Bool 1', itU8, wbBoolEnum),
      wbInteger('Unknown Bool 2', itU8, wbBoolEnum),
      wbInteger('Form Type', itU32, wbEnum([], [
        Sig2Int(ARMO), 'Armor',
        Sig2Int(NPC_), 'Non-player character',
        Sig2Int(WEAP), 'Weapon',
        Sig2Int(NONE), 'None'
      ])).SetDefaultEditValue('None'),
      wbInteger('Max Rank', itU8),
      wbInteger('Level Tier Scaled Offset', itU8),
      wbFormIDCk('Attach Point', [KYWD, NULL]),
      wbArray('Attach Parent Slots', wbFormIDCk('Keyword', [KYWD, NULL]), -1),
      // no way to change these in CK, legacy data leftover?
      wbArray('Items', wbStruct('Item', [
        wbByteArray('Value 1', 4),
        wbByteArray('Value 2', 4)
      ]), -1),
      // should not be sorted
      wbArray('Includes', wbStruct('Include', [
        wbFormIDCk('Mod', [OMOD]),
        wbInteger('Minimum Level', itU8),
        wbInteger('Optional', itU8, wbBoolEnum),
        wbInteger('Don''t Use All', itU8, wbBoolEnum)
      ]), wbOMODDataIncludeCounter, cpNormal, False, nil, wbOMODincludeAfterSet),
      wbObjectModProperties
    ], cpNormal, False, nil, -1, nil, wbOMODdataAfterSet),
    wbArray(MNAM, 'Target OMOD Keywords', wbFormIDCk('Keyword', [KYWD])).IncludeFlag(dfCollapsed, wbCollapseKeywords),
    wbArray(FNAM, 'Filter Keywords', wbFormIDCk('Keyword', [KYWD])).IncludeFlag(dfCollapsed, wbCollapseKeywords),
    wbFormIDCk(LNAM, 'Loose Mod', sigBaseObjects),
    wbInteger(NAM1, 'Priority', itU8),
    wbFLTR
  ]);

  wbRecord(OVIS, 'Object Visibility Manager', [
    wbEDID,
    wbRArray('Unknown',
      wbRStruct('Unknown', [
        wbFormIDCk(INDX, 'Object', [STAT]),
        wbStruct(DATA, 'Object Bounds', [
          wbFloat('X1'),
          wbFloat('Y1'),
          wbFloat('Z1'),
          wbFloat('X2'),
          wbFloat('Y2'),
          wbFloat('Z2')
        ])
        .SetSummaryKeyOnValue([0, 1, 2, 3, 4, 5])
        .SetSummaryPrefixSuffixOnValue(0, '(', '')
        .SetSummaryPrefixSuffixOnValue(2, '', ')')
        .SetSummaryPrefixSuffixOnValue(3, '(', '')
        .SetSummaryPrefixSuffixOnValue(5, '', ')')
        .SetSummaryDelimiterOnValue(', ')
        .IncludeFlagOnValue(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed, wbCollapseObjectBounds)
      ])
    )
  ]);

  wbRecord(PKIN, 'Pack-In',
    wbFlags(wbFlagsList([
      {0x00000200}  9, 'Prefab'
    ])), [
    wbEDID,
    wbOBND,
    wbFLTR,
    wbFormIDCk(CNAM, 'Cell', [CELL]),
    wbInteger(VNAM, 'Version', itU32)
  ]);

  wbRecord(RFGP, 'Reference Group', [
    wbEDID,
    wbString(NNAM, 'Name'),
    wbFormIDCk(RNAM, 'Reference', sigReferences),
    wbFormIDCk(PNAM, 'Pack-In', [PKIN])
  ]);

  {wbRecord(RGDL, 'RGDL', [
    wbEDID
  ]);}

  wbRecord(SCCO, 'Scene Collection', [
    wbEDID,
    wbFormIDCk(QNAM, 'Quest', [QUST]),
    wbRArray('Scene Layout',
      wbRStruct('Scene', [
        wbFormIDCk(SNAM, 'Scene', [SCEN]),
        wbStruct(XNAM, 'Coordinates', [
          wbInteger('X', itS32),
          wbInteger('Y', itS32)
        ])
        .SetSummaryKeyOnValue([0, 1])
        .SetRequired
      ])
      .SetSummaryKey([0, 1])
      .IncludeFlag(dfCollapsed, wbCollapsePlacement)
    ),
    wbUnknown(VNAM, cpNormal, True),
    wbRArray('Original Coordinates?',
      wbStruct(XNAM, 'Coordinates', [
        wbInteger('X', itS32),
        wbInteger('Y', itS32)
      ])
      .SetSummaryKeyOnValue([0, 1])
      .IncludeFlag(dfCollapsed, wbCollapsePlacement)
    ),
    wbUnknown(VNAM, cpNormal, True)
  ]);

  var wbStaticPart :=
    wbRStructSK([0], 'Part', [
      wbFormIDCk(ONAM, 'Static', [ACTI, ALCH, AMMO, BOOK, CONT, DOOR, FURN, MISC, MSTT, STAT, TERM, WEAP, FLOR]),
      wbStaticPartPlacements
    ], [], cpNormal, True);

  wbRecord(SCOL, 'Static Collection',
    wbFlags(wbFlagsList([
       4, 'Non Occluder',
       9, 'Hidden From Local Map',
     10, 'Loadscreen',
     11, 'Used as Platform',
     15, 'Has Distant LOD',
     25, 'Obstacle',
     26, 'Navmesh - Filter',
     27, 'Navmesh - Bounding Box',
     30, 'Navmesh - Ground'
    ])).SetFlagHasDontShow(26, wbFlagNavmeshFilterDontShow)
       .SetFlagHasDontShow(27, wbFlagNavmeshBoundingBoxDontShow)
       .SetFlagHasDontShow(30, wbFlagNavmeshGroundDontShow), [
    wbEDID,
    wbOBND(True),
    wbPTRN,
    wbGenericModel,
    wbFULL,
    wbFLTR,
    wbRArrayS('Parts', wbStaticPart, cpNormal, True)
  ]);

  wbRecord(SCSN, 'Audio Category Snapshot', [
    wbEDID,
    wbInteger(PNAM, 'Priority', itU16),
    wbRArray('Category Multipliers', wbStruct(CNAM, 'Category Multiplier', [
      wbFormIDCk('Category', [SNCT]),
      wbFloat('Multiplier')
    ]))
  ]);

  {wbRecord(SKIL, 'SKIL', [
    wbEDID
  ]);}

  wbRecord(STAG, 'Animation Sound Tag Set', [
    wbEDID,
    wbRArray('Sounds', wbStruct(TNAM, 'Sound', [
      wbFormIDCk('Sound', [SNDR, NULL]),
      wbString('Action')
    ]))
  ]);

  wbRecord(TERM, 'Terminal',
    wbFlags(wbFlagsList([
      {0x00000004}  4, 'Non Occluder',
      {0x00002000} 13, 'Pack-In Use Only',
      {0x00008000} 15, 'Has Distant LOD',
      {0x00010000} 16, 'Random Anim Start'
    ])), [
    wbEDID,
    wbVMADFragmentedPERK, // same fragments format as in PERK
    wbOBND(True),
    wbPTRN,
    wbLStringKC(NAM0, 'Header Text'),
    wbLStringKC(WNAM, 'Welcome Text'),
    wbFULL,
    wbGenericModel,
    wbKeywords,
    wbPRPS,
    wbByteColors(PNAM, 'Marker Color (Unused)'),
    wbFormIDCk(SNAM, 'Looping Sound', [SNDR]),
    wbInteger(FNAM, 'Flags', itU16, wbFlags([
      'No Displacement',
      'Ignored by Sandbox',
      'Unknown 2',
      'Unknown 3',
      'Is a Radio',
      'Unknown 5',
      'Unknown 6' {Currently Unused}
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(COCT, 'Holds Holotape (Count)', itU32),
    wbRArray('Holotapes',
      wbStruct(CNTO, 'Holotape', [
        wbFormIDCk('Item', [NULL, NOTE]),
        wbInteger('Count', itS32, nil, cpNormal, False, nil, nil, 1)
      ])
        .SetSummaryKeyOnValue([1, 0])
        .SetSummaryPrefixSuffixOnValue(1, '', 'x')
        .SetSummaryDelimiterOnValue(' ')
        .IncludeFlagOnValue(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed, wbCollapseItems),
      cpNormal, False, nil, wbTERMCNTOsAfterSet
    ),
    wbMNAMFurnitureMarker,
    wbByteArray(WBDT, 'Workbench Data (unused)', 0),
    wbString(XMRK, 'Marker Model'),
    wbSNAMMarkerParams,
    wbInteger(BSIZ, 'Count', itU32, nil, cpBenign),
    wbRArray('Body Text',
      wbRStruct('Item', [
        wbLStringKC(BTXT, 'Text', 0, cpTranslate),
        wbConditions
      ])
        .SetSummaryKey([0, 1])
        .SetSummaryMemberPrefixSuffix(1, '{', '}')
        .SetSummaryDelimiter(' ')
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed, wbCollapseOther),
      cpNormal, False, nil, wbTERMDisplayItemsAfterSet
    ),
    wbInteger(ISIZ, 'Count', itU32, nil, cpBenign),
    wbRArray('Menu Items',
      wbRStruct('Menu Item', [
        wbLStringKC(ITXT, 'Item Text', 0, cpTranslate),
        wbLStringKC(RNAM, 'Response Text', 0, cpTranslate),
        wbInteger(ANAM, 'Type', itU8, wbEnum([
          {0} 'Unknown 0',
          {1} 'Unknown 1',
          {2} 'Unknown 2',
          {3} 'Unknown 3',
          {4} 'Submenu - Terminal',
          {5} 'Submenu - Return to Top Level',
          {6} 'Submenu - Force Redraw',
          {7} 'Unknown 7',
          {8} 'Display Text',
          {9} 'Unknown 9',
         {10} 'Unknown 10',
         {11} 'Unknown 11',
         {12} 'Unknown 12',
         {13} 'Unknown 13',
         {14} 'Unknown 14',
         {15} 'Unknown 15',
         {16} 'Display Image'
        ]), cpNormal, True),
        wbInteger(ITID, 'Item ID', itU16),
        wbLStringKC(UNAM, 'Display Text', 0, cpTranslate),
        wbString(VNAM, 'Show Image'),
        wbFormIDCk(TNAM, 'Submenu', [TERM]),
        wbConditions
      ])
        .SetSummaryKey([3, 2, 0, 7])
        .SetSummaryMemberPrefixSuffix(3, '[', ']')
        .SetSummaryMemberPrefixSuffix(2, '[', ']')
        .SetSummaryMemberPrefixSuffix(7, '{', '}')
        .SetSummaryDelimiter(' ')
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed, wbCollapseOther),
      cpNormal, False, nil, wbTERMMenuItemsAfterSet
    )
  ]);

  {wbRecord(TLOD, 'TLOD', [
    wbEDID
  ]);

  wbRecord(TOFT, 'TOFT', [
    wbEDID
  ]);}

  wbRecord(TRNS, 'Transform',
    wbFlags(wbFlagsList([
      {0x00008000} 16, 'Around Origin'
    ])), [
    wbEDID,
    wbStruct(DATA, 'Data', [
      wbPosRot,
      wbFloat('Scale').SetDefaultEditValue('1.0'),
      wbFloat('Zoom Min').SetDefaultEditValue('-1.0'),
      wbFloat('Zoom Max').SetDefaultEditValue('1.0')
    ], cpNormal, True, nil, 2)
  ]);

  wbRecord(WATR, 'Water', [
    wbEDID,
    wbFULL,
    wbInteger(ANAM, 'Opacity (unused)', itU8),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      {0x01} 'Dangerous',
      {0x02} 'Unknown 1',
      {0x04} 'Directional Sound'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbFormIDCk(TNAM, 'Material (unused)', [MATT]),
    wbFormIDCk(SNAM, 'Open Sound', [SNDR, NULL]),
    wbFormIDCk(XNAM, 'Consume Spell', [SPEL]),
    wbFormIDCk(YNAM, 'Contact Spell', [SPEL]),
    wbFormIDCk(INAM, 'Image Space', [IMGS]),
    wbByteArray(DATA, 'Unused', 0),
    wbStruct(DNAM, 'Visual Data', [
      wbStruct('Fog Properties', [
        wbFloat('Depth Amount').SetDefaultEditValue('8192.0'),
        wbByteColors('Shallow Color'),
        wbByteColors('Deep Color'),
        wbFloat('Color Shallow Range').SetDefaultEditValue('0.6'),
        wbFloat('Color Deep Range').SetDefaultEditValue('0.3'),
        wbFloat('Shallow Alpha'),
        wbFloat('Deep Alpha').SetDefaultEditValue('1.0'),
        wbFloat('Alpha Shallow Range').SetDefaultEditValue('1.0'),
        wbFloat('Alpha Deep Range').SetDefaultEditValue('0.5'),
        wbByteColors('Underwater Color'),
        wbFloat('Underwater Fog Amount').SetDefaultEditValue('1.0'),
        wbFloat('Underwater Near Fog'),
        wbFloat('Underwater Far Fog').SetDefaultEditValue('1000.0')
      ]),
      wbStruct('Physical Properties', [
        wbFloat('Normal Magnitude').SetDefaultEditValue('0.5'),
        wbFloat('Shallow Normal Falloff').SetDefaultEditValue('1.0'),
        wbFloat('Deep Normal Falloff').SetDefaultEditValue('0.75'),
        wbFloat('Reflectivity Amount').SetDefaultEditValue('0.5'),
        wbFloat('Fresnel Amount').SetDefaultEditValue('0.025'),
        wbFloat('Surface Effect Falloff').SetDefaultEditValue('0.9'),
        wbStruct('Displacement Simulator', [
          wbFloat('Force').SetDefaultEditValue('0.4'),
          wbFloat('Velocity').SetDefaultEditValue('0.6'),
          wbFloat('Falloff').SetDefaultEditValue('0.985'),
          wbFloat('Dampener').SetDefaultEditValue('10.0'),
          wbFloat('Starting Size').SetDefaultEditValue('0.05')
        ]),
        wbByteColors('Reflection Color')
      ]),
      wbStruct('Specular Properties', [
        wbFloat('Sun Specular Power').SetDefaultEditValue('50.0'),
        wbFloat('Sun Specular Magnitude').SetDefaultEditValue('1.0'),
        wbFloat('Sun Sparkle Power').SetDefaultEditValue('1.0'),
        wbFloat('Sun Sparkle Magnitude').SetDefaultEditValue('1.0'),
        wbFloat('Interior Specular Radius').SetDefaultEditValue('100000.0'),
        wbFloat('Interior Specular Brightness').SetDefaultEditValue('1.0'),
        wbFloat('Interior Specular Power').SetDefaultEditValue('100.0')
      ]),
      wbStruct('Noise Properties', [
        wbFloat('Layer 1 - Wind Direction'),
        wbFloat('Layer 2 - Wind Direction'),
        wbFloat('Layer 3 - Wind Direction'),
        wbFloat('Layer 1 - Wind Speed'),
        wbFloat('Layer 2 - Wind Speed'),
        wbFloat('Layer 3 - Wind Speed'),
        wbFloat('Layer 1 - Amplitude Scale'),
        wbFloat('Layer 2 - Amplitude Scale'),
        wbFloat('Layer 3 - Amplitude Scale'),
        wbFloat('Layer 1 - UV Scale').SetDefaultEditValue('100.0'),
        wbFloat('Layer 2 - UV Scale').SetDefaultEditValue('100.0'),
        wbFloat('Layer 3 - UV Scale').SetDefaultEditValue('100.0'),
        wbFloat('Layer 1 - Noise Falloff').SetDefaultEditValue('300.0'),
        wbFloat('Layer 2 - Noise Falloff').SetDefaultEditValue('300.0'),
        wbFloat('Layer 3 - Noise Falloff').SetDefaultEditValue('300.0')
      ]),
      wbStruct('Silt Properties', [
        wbFloat('Silt Amount'),
        wbByteColors('Light Color'),
        wbByteColors('Dark Color')
      ]),
      wbInteger('Screen Space Reflections', itU8, wbBoolEnum).SetDefaultEditValue('True')
    ], cpNormal, True, nil, 4),
    wbByteArray(GNAM, 'Unused', 0),
    wbVec3(NAM0, 'Linear Velocity'),
    wbVec3(NAM1, 'Angular Velocity'),
    wbString(NAM2, 'Layer 1 Noise Texture'),
    wbString(NAM3, 'Layer 2 Noise Texture'),
    wbString(NAM4, 'Layer 3 Noise Texture')
  ]);

  wbRecord(WEAP, 'Weapon',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Non-Playable',
      {0x20000000} 30, 'High-Res 1st Person Only'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTRN,
    wbSTCP,
    wbFULL,
    wbGenericModel,
    wbICON,
    wbMICO,
    wbEnchantment(True),
    wbDEST,
    wbETYP,
    wbFormIDCk(BIDS, 'Block Bash Impact Data Set', [IPDS, NULL]),
    wbFormIDCk(BAMT, 'Alternate Block Material', [MATT, NULL]),
    wbYNAM,
    wbZNAM,
    wbKeywords,
    wbDESC,
    wbFormIDCk(INRD, 'Instance Naming', [INNR]),
    wbAPPR,
    wbObjectTemplate,
    wbFormIDCk(NNAM, 'Embedded Weapon Mod', [OMOD]),
    wbRStruct('1st Person Model', [
      wbString(MOD4, 'Model FileName'),
      wbModelInfo(MO4T),
      wbMO4S,
      wbMO4C,
      wbMO4F
    ]),
    wbStruct(DNAM, 'Data', [
      wbFormIDCk('Ammo', [AMMO, NULL]),
      wbFloat('Speed'),
      wbFloat('Reload Speed'),
      wbFloat('Reach'),
      wbFloat('Min Range'),
      wbFloat('Max Range'),
      wbFloat('Attack Delay'),
      wbFloat('Unused'),
      wbFloat('Damage - OutOfRange Mult').SetDefaultEditValue('0.5'),
      wbInteger('On Hit', itU32, wbHitBehaviourEnum),
      wbFormIDCk('Skill', [AVIF, NULL]),
      wbFormIDCk('Resist', [AVIF, NULL]),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Player Only',
        {0x00000002} 'NPCs Use Ammo',
        {0x00000004} 'No Jam After Reload',
        {0x00000008} 'Charging Reload',
        {0x00000010} 'Minor Crime',
        {0x00000020} 'Fixed Range',
        {0x00000040} 'Not Used In Normal Combat',
        {0x00000080} 'Unknown 8',
        {0x00000100} 'Crit Effect - on Death',
        {0x00000200} 'Charging Attack',
        {0x00000400} 'Unknown 11',
        {0x00000800} 'Hold Input To Power',
        {0x00001000} 'Non Hostile',
        {0x00002000} 'Bound Weapon',
        {0x00004000} 'Ignores Normal Weapon Resistance',
        {0x00008000} 'Automatic',
        {0x00010000} 'Repeatable Single Fire',
        {0x00020000} 'Can''t Drop',
        {0x00040000} 'Hide Backpack',
        {0x00080000} 'Embedded Weapon',
        {0x00100000} 'Not Playable',
        {0x00200000} 'Has Scope',
        {0x00400000} 'Bolt Action',
        {0x00800000} 'Secondary Weapon',
        {0x01000000} 'Disable Shells',
        {0x02000000} 'Unknown 26',
        {0x04000000} 'Unknown 27',
        {0x08000000} 'Unknown 28',
        {0x10000000} 'Unknown 29',
        {0x20000000} 'Unknown 30',
        {0x40000000} 'Unknown 31',
        {0x80000000} 'Unknown 32'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Capacity', itU16),
      wbInteger('Animation Type', itU8, wbEnum([
        'HandToHandMelee',
        'OneHandSword',
        'OneHandDagger',
        'OneHandAxe',
        'OneHandMace',
        'TwoHandSword',
        'TwoHandAxe',
        'Bow',
        'Staff',
        'Gun',
        'Grenade',
        'Mine'
      ])),
      wbFloat('Damage - Secondary'),
      wbFloat('Weight'),
      wbInteger('Value', itU32),
      wbInteger('Damage - Base', itU16),
      wbInteger('Sound Level', itU32, wbSoundLevelEnum),
      wbFormIDCk('Sound - Attack', [SNDR, NULL]),
      wbFormIDCk('Sound - Attack 2D', [SNDR, NULL]),
      wbFormIDCk('Sound - Attack Loop', [SNDR, NULL]),
      wbFormIDCk('Sound - Attack Fail', [SNDR, NULL]),
      wbFormIDCk('Sound - Idle', [SNDR, NULL]),
      wbFormIDCk('Sound - Equip Sound', [SNDR, NULL]),
      wbFormIDCk('Sound - UnEquip Sound', [SNDR, NULL]),
      wbFormIDCk('Sound - Fast Equip Sound', [SNDR, NULL]),
      wbInteger('Accuracy Bonus', itU8),
      wbFloat('Animation Attack Seconds').SetDefaultEditValue('0.3'),
      wbByteArray('Unknown', 2),
      wbFloat('Action Point Cost').SetDefaultEditValue('20.0'),
      wbFloat('Full Power Seconds'),
      wbFloat('Min Power Per Shot'),
      wbInteger('Stagger', itU32, wbStaggerEnum),
      wbByteArray('Unknown', 4)
    ]),
    wbStruct(FNAM, '', [
      wbFloat('Animation Fire Seconds'),
      wbFloat('Rumble - Left Motor Strength').SetDefaultEditValue('0.5'),
      wbFloat('Rumble - Right Motor Strength').SetDefaultEditValue('1.0'),
      wbFloat('Rumble - Duration').SetDefaultEditValue('0.33'),
      wbFloat('Animation Reload Seconds'),
      wbByteArray('Bolt Anim Seconds', 4),
      wbFloat('Sighted Transition Seconds').SetDefaultEditValue('0.25'),
      wbInteger('# Projectiles', itU8).SetDefaultEditValue('1'),
      wbFormIDCk('Override Projectile', [PROJ, NULL]),
      wbInteger('Pattern', itU32, wbEnum([
        'Constant',
        'Square',
        'Triangle',
        'Sawtooth'
      ])),
      wbInteger('Rumble - Peroid (ms)', itU32)
    ]),
    wbStruct(CRDT, 'Critical Data', [
      wbFloat('Crit Damage Mult').SetDefaultEditValue('2.0'),
      wbFloat('Crit Charge Bonus'),
      wbFormIDCk('Crit Effect', [SPEL, NULL])
    ]),
    wbFormIDCk(INAM, 'Impact Data Set', [IPDS]),
    wbFormIDCk(LNAM, 'NPC Add Ammo List', [LVLI]),
    wbFormIDCk(WAMD, 'Aim Model', [AMDL]),
    wbFormIDCk(WZMD, 'Zoom', [ZOOM]),
    wbFormIDCk(CNAM, 'Template', [WEAP]),
    wbDamageTypeArray('Damage Type'),
    wbFLTR,
    wbInteger(MASE, 'Melee Speed', itU32, wbEnum([
      'Very Slow',
      'Slow',
      'Medium',
      'Fast',
      'Very Fast'
    ]))
  ], False, nil, cpNormal, False, nil{wbWEAPAfterLoad});

  wbRecord(WTHR, 'Weather',
    wbFlags(wbFlagsList([
      9, 'Unknown 9'
    ])), [
    wbEDID,
    wbWeatherCloudTextures,
    wbInteger(LNAM, 'Max Cloud Layers', itU32)
      .SetDefaultNativeValue(16)
      .SetRequired,
    wbFormIDCK(MNAM, 'Precipitation Type', [SPGD, NULL])
      .SetRequired,
    wbFormIDCK(NNAM, 'Visual Effect', [RFCT, NULL])
      .SetRequired,
    wbWeatherCloudSpeed,
    wbWeatherCloudColors,
    wbWeatherCloudAlphas,
    wbWeatherColors,
    wbArray(NAM4, 'Unknown',
      wbFloat('Unknown')
        .SetDefaultNativeValue(1),
    32).IncludeFlag(dfNotAlignable)
       .SetRequired,
    wbWeatherFogDistance,
    wbStruct(DATA, 'Data', [
      wbInteger('Wind Speed', itU8), // scaled 0..1
      wbUnused(2),
      wbInteger('Trans Delta', itU8), // scaled 0..0,25
      wbInteger('Sun Glare', itU8), // scaled 0..1
      wbInteger('Sun Damage', itU8), // scaled 0..1
      wbInteger('Precipitation - Begin Fade In', itU8), // scaled 0..1
      wbInteger('Precipitation - End Fade Out', itU8), // scaled 0..1
      wbInteger('Thunder/Lightning - Begin Fade In', itU8),
      wbInteger('Thunder/Lightning - End Fade Out', itU8),
      wbInteger('Thunder/Lightning - Frequency', itU8)
        .SetDefaultNativeValue(255),
      wbInteger('Flags', itU8,
        wbFlags(wbSparseFlags([
          0, 'Weather - Pleasant',
          1, 'Weather - Cloudy',
          2, 'Weather - Rainy',
          3, 'Weather - Snow',
          4, 'Aurora - Always Visible',
          5, 'Aurora - Follows Sun Position',
          6, 'Rain Occlusion',
          7, 'HUD Rain Effects'
        ], False, 8))
      ).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbWeatherLightningColor,
      wbInteger('Visual Effect - Begin', itU8), // scaled 0..1
      wbInteger('Visual Effect - End', itU8), // scaled 0..1
      wbInteger('Wind Direction', itU8), // scaled 0..360
      wbInteger('Wind Direction Range', itU8), // scaled 0..180
      wbFromVersion(119, wbInteger('Wind Turbulance', itU8))
    ]).SetRequired,
    wbWeatherDisabledLayers,
    wbWeatherSounds,
    wbRArrayS('Sky Statics',
      wbFormIDCk(TNAM, 'Static', [STAT, NULL])
    ),
    wbWeatherImageSpaces,
    wbWeatherGodRays
      .SetRequired,
    wbWeatherDirectionalLighting,
    wbRStruct('Aurora', [
      wbGenericModel
    ]),
    wbFormIDCk(GNAM, 'Sun Glare Lens Flare', [LENS]),
    wbWeatherMagic,
    wbFloat(VNAM, 'Volatility Mult')
      .SetDefaultNativeValue(1)
      .SetRequired, //Form Version 126+
    wbFloat(WNAM, 'Visibility Mult')
      .SetDefaultNativeValue(1)
      .SetRequired  //Form Version 126+
  ]);

  wbRecord(WRLD, 'Worldspace',
    wbFlags(wbFlagsList([
      14, 'Partial Form',
      19, 'Can''t Wait'
    ]), [14]), [
    wbEDID,
    wbWorldLargeRefs,
    wbWorldMaxHeight,
    wbFULL,
    wbWorldFixedCenter,
    wbFormIDCk(LTMP, 'Interior Lighting', [LGTM])
      .SetDefaultNativeValue(196834),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN, NULL]),
    wbFormIDCk(XLCN, 'Location', [LCTN, NULL]),
    wbRStruct('Parent Worldspace', [
      wbFormIDCk(WNAM, 'World', [WRLD]),
      wbInteger(PNAM, 'Flags', itU16,
        wbFlags(wbSparseFlags([
          0, 'Use Land Data',
          1, 'Use LOD Data',
          2, 'Use Map Data',
          3, 'Use Water Data',
          4, 'Use Climate Data',
          6, 'Use Sky Cell'
        ], False, 7), True)
      ).SetRequired
       .IncludeFlag(dfCollapsed, wbCollapseFlags)
    ]),
    wbFormIDCk(CNAM, 'Climate', [CLMT])
      .SetDefaultNativeValue(351)
      .SetIsRemovable(wbWorldClimateIsRemovable),
    wbFormIDCk(NAM2, 'Water', [WATR])
      .SetDefaultNativeValue(24)
      .SetIsRemovable(wbWorldWaterIsRemovable),
    wbWorldLODData,
    wbWorldLandData,
    wbString(ICON, 'Map Image'),
    wbRStruct('Cloud Model', [
      wbGenericModel
    ]),
    wbWorldMapData,
    wbWorldMapOffset,
    wbFloat(NAMA, 'Distant LOD Multiplier')
      .SetDefaultNativeValue(1)
      .SetRequired,
    wbInteger(DATA, 'Flags', itU8,
      wbFlags(wbSparseFlags([
        0, 'Small World',
        1, 'Can''t Fast Travel',
        3, 'No LOD Water',
        4, 'No Landscape',
        5, 'No Sky',
        6, 'Fixed Dimensions',
        7, 'No Grass'
      ], False, 8), True)
    ).SetDefaultNativeValue(1)
     .SetRequired
     .IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbWorldObjectBounds,
    wbFormIDCk(ZNAM, 'Music', [MUSC]),
    wbString(NNAM, 'Canopy Shadow (unused)', 0, cpIgnore),
    wbString(XWEM, 'Water Environment Map'),
    wbString(TNAM, 'HD LOD Diffuse Texture'),
    wbString(UNAM, 'HD LOD Normal Texture'),
    wbWorldLevelData,
    wbWorldOffsetData,
    wbWorldCellSizeData
  ]).SetAfterLoad(wbWorldAfterLoad)
    .SetAfterSet(wbWorldAfterSet);

  wbRecord(ZOOM, 'Zoom', [
    wbEDID,
    wbStruct(GNAM, 'Data', [
      wbFloat('FOV Mult')
        .SetDefaultNativeValue(1),
      wbInteger('Overlay', itU32, wbZoomOverlayEnum),
      wbFormIDCk('Imagespace Modifier', [IMAD, NULL]),
      wbVec3('Camera Offset')
    ]).SetRequired
  ]);

   wbAddGroupOrder(GMST);
   wbAddGroupOrder(KYWD);
   wbAddGroupOrder(LCRT);
   wbAddGroupOrder(AACT);
   wbAddGroupOrder(TRNS);
   wbAddGroupOrder(CMPO);
   wbAddGroupOrder(TXST);
   //wbAddGroupOrder(MICN);
   wbAddGroupOrder(GLOB);
   wbAddGroupOrder(DMGT);
   wbAddGroupOrder(CLAS);
   wbAddGroupOrder(FACT);
   wbAddGroupOrder(HDPT);
   wbAddGroupOrder(EYES);
   wbAddGroupOrder(RACE);
   wbAddGroupOrder(SOUN);
   wbAddGroupOrder(ASPC);
   //wbAddGroupOrder(SKIL);
   wbAddGroupOrder(MGEF);
   //wbAddGroupOrder(SCPT);
   wbAddGroupOrder(LTEX);
   wbAddGroupOrder(ENCH);
   wbAddGroupOrder(SPEL);
   //wbAddGroupOrder(SCRL);
   wbAddGroupOrder(ACTI);
   wbAddGroupOrder(TACT);
   wbAddGroupOrder(ARMO);
   wbAddGroupOrder(BOOK);
   wbAddGroupOrder(CONT);
   wbAddGroupOrder(DOOR);
   wbAddGroupOrder(INGR);
   wbAddGroupOrder(LIGH);
   wbAddGroupOrder(MISC);
   wbAddGroupOrder(STAT);
   wbAddGroupOrder(SCOL);
   wbAddGroupOrder(MSTT);
   wbAddGroupOrder(GRAS);
   wbAddGroupOrder(TREE);
   wbAddGroupOrder(FLOR);
   wbAddGroupOrder(FURN);
   wbAddGroupOrder(WEAP);
   wbAddGroupOrder(AMMO);
   wbAddGroupOrder(NPC_);
   wbAddGroupOrder(PLYR);
   wbAddGroupOrder(LVLN);
   wbAddGroupOrder(KEYM);
   wbAddGroupOrder(ALCH);
   wbAddGroupOrder(IDLM);
   wbAddGroupOrder(NOTE);
   wbAddGroupOrder(PROJ);
   wbAddGroupOrder(HAZD);
   wbAddGroupOrder(BNDS);
   //wbAddGroupOrder(SLGM);
   wbAddGroupOrder(TERM);
   wbAddGroupOrder(LVLI);
   wbAddGroupOrder(WTHR);
   wbAddGroupOrder(CLMT);
   wbAddGroupOrder(SPGD);
   wbAddGroupOrder(RFCT);
   wbAddGroupOrder(REGN);
   wbAddGroupOrder(NAVI);
   wbAddGroupOrder(CELL);
   //wbAddGroupOrder(REFR);
   //wbAddGroupOrder(ACHR);
   //wbAddGroupOrder(PMIS);
   //wbAddGroupOrder(PARW);
   //wbAddGroupOrder(PGRE);
   //wbAddGroupOrder(PBEA);
   //wbAddGroupOrder(PFLA);
   //wbAddGroupOrder(PCON);
   //wbAddGroupOrder(PBAR);
   //wbAddGroupOrder(PHZD);
   wbAddGroupOrder(WRLD);
   //wbAddGroupOrder(LAND);
   //wbAddGroupOrder(NAVM);
   //wbAddGroupOrder(TLOD);
   //wbAddGroupOrder(DIAL);
   //wbAddGroupOrder(INFO);
   wbAddGroupOrder(QUST);
   wbAddGroupOrder(IDLE);
   wbAddGroupOrder(PACK);
   wbAddGroupOrder(CSTY);
   wbAddGroupOrder(LSCR);
   wbAddGroupOrder(LVSP);
   wbAddGroupOrder(ANIO);
   wbAddGroupOrder(WATR);
   wbAddGroupOrder(EFSH);
   //wbAddGroupOrder(TOFT);
   wbAddGroupOrder(EXPL);
   wbAddGroupOrder(DEBR);
   wbAddGroupOrder(IMGS);
   wbAddGroupOrder(IMAD);
   wbAddGroupOrder(FLST);
   wbAddGroupOrder(PERK);
   wbAddGroupOrder(BPTD);
   wbAddGroupOrder(ADDN);
   wbAddGroupOrder(AVIF);
   wbAddGroupOrder(CAMS);
   wbAddGroupOrder(CPTH);
   wbAddGroupOrder(VTYP);
   wbAddGroupOrder(MATT);
   wbAddGroupOrder(IPCT);
   wbAddGroupOrder(IPDS);
   wbAddGroupOrder(ARMA);
   wbAddGroupOrder(ECZN);
   wbAddGroupOrder(LCTN);
   wbAddGroupOrder(MESG);
   //wbAddGroupOrder(RGDL);
   wbAddGroupOrder(DOBJ);
   wbAddGroupOrder(DFOB);
   wbAddGroupOrder(LGTM);
   wbAddGroupOrder(MUSC);
   wbAddGroupOrder(FSTP);
   wbAddGroupOrder(FSTS);
   wbAddGroupOrder(SMBN);
   wbAddGroupOrder(SMQN);
   wbAddGroupOrder(SMEN);
   wbAddGroupOrder(DLBR);
   wbAddGroupOrder(MUST);
   wbAddGroupOrder(DLVW);
   //wbAddGroupOrder(WOOP);
   //wbAddGroupOrder(SHOU);
   wbAddGroupOrder(EQUP);
   wbAddGroupOrder(RELA);
   wbAddGroupOrder(SCEN);
   wbAddGroupOrder(ASTP);
   wbAddGroupOrder(OTFT);
   wbAddGroupOrder(ARTO);
   wbAddGroupOrder(MATO);
   wbAddGroupOrder(MOVT);
   wbAddGroupOrder(SNDR);
   wbAddGroupOrder(DUAL);
   wbAddGroupOrder(SNCT);
   wbAddGroupOrder(SOPM);
   wbAddGroupOrder(COLL);
   wbAddGroupOrder(CLFM);
   wbAddGroupOrder(REVB);
   wbAddGroupOrder(PKIN);
   wbAddGroupOrder(RFGP);
   wbAddGroupOrder(AMDL);
   wbAddGroupOrder(LAYR);
   wbAddGroupOrder(COBJ);
   wbAddGroupOrder(OMOD);
   wbAddGroupOrder(MSWP);
   wbAddGroupOrder(ZOOM);
   wbAddGroupOrder(INNR);
   wbAddGroupOrder(KSSM);
   wbAddGroupOrder(AECH);
   wbAddGroupOrder(SCCO);
   wbAddGroupOrder(AORU);
   wbAddGroupOrder(SCSN);
   wbAddGroupOrder(STAG);
   wbAddGroupOrder(NOCM);
   wbAddGroupOrder(LENS);
   //wbAddGroupOrder(LSPR);
   wbAddGroupOrder(GDRY);
   wbAddGroupOrder(OVIS);
  wbNexusModsUrl := 'https://www.nexusmods.com/fallout4/mods/2737';
  {if wbToolMode = tmLODgen then
    wbNexusModsUrl := '';}
  SetLength(wbOfficialDLC, 7);
  wbOfficialDLC[0] := 'DLCRobot.esm';
  wbOfficialDLC[1] := 'DLCworkshop01.esm';
  wbOfficialDLC[2] := 'DLCCoast.esm';
  wbOfficialDLC[3] := 'DLCworkshop02.esm';
  wbOfficialDLC[4] := 'DLCworkshop03.esm';
  wbOfficialDLC[5] := 'DLCNukaWorld.esm';
  wbOfficialDLC[6] := 'DLCUltraHighResolution.esm';
  if wbGameMode = gmFO4VR then begin
    // new VR esm is loaded after DLCs
    SetLength(wbOfficialDLC, Succ(Length(wbOfficialDLC)));
    wbOfficialDLC[Pred(Length(wbOfficialDLC))] := 'Fallout4_VR.esm';
  end else
    wbCreationClubContentFileName := 'Fallout4.ccc';
  if wbGameMode = gmFO4VR then
    wbHEDRVersion := 0.95
  else begin
    wbHEDRVersion := 1.0;
    wbHEDRNextObjectID := 1;
  end;
end;
end.
