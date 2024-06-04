{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbDefinitionsCommon;

{$I wbDefines.inc}

interface

uses
  wbInterface,
  wbDefinitionsSignatures;

type
  TwbVarRecs = TArray<TVarRec>;

var
  wbActionFlag: IwbSubRecordDef;
  wbAlternateTexture: IwbValueDef;
  wbAxisEnum: IwbEnumDef;
  wbCellGrid: IwbRecordMemberDef;
  wbCinematicIMAD: IwbSubRecordStructDef;
  wbColorInterpolator: IwbStructDef;
  wbDATAPosRot: IwbRecordMemberDef;
  wbFaction: IwbRecordMemberDef;
  wbFactionRelations: IwbRecordMemberDef;
  wbHEDR: IwbSubRecordDef;
  wbMDOB: IwbSubRecordDef;
  wbNextSpeaker: IwbIntegerDef;
  wbPosRot: IwbValueDef;
  wbQuadrantEnum: IwbEnumDef;
  wbSeasons: IwbRecordMemberDef;
  wbSexEnum: IwbEnumDef;
  wbActorSounds: IwbRecordMemberDef;
  wbMagicEffectSounds: IwbRecordMemberDef;
  wbQuestEventVarRecs: TwbVarRecs;
  wbQuestEventEnum: IwbEnumDef;
  wbRegionSounds: IwbRecordMemberDef;
  wbSoundDescriptorSounds: IwbRecordMemberDef;
  wbSoundTypeSounds: IwbRecordMemberDef;
  wbWeatherSounds: IwbRecordMemberDef;
  wbTimeInterpolator: IwbValueDef;
  wbVertexHeightMap: IwbRecordMemberDef;
  wbWorldspaceOBND: IwbRecordMemberDef;
  wbXLOD: IwbSubRecordDef;
  wbLargeReferences: IwbRecordMemberDef;
  wbMaxHeightDataCELL: IwbSubRecordDef;
  wbMaxHeightDataWRLD: IwbSubRecordDef;
  wbOFST: IwbSubRecordDef;
  wbCLSZ: IwbSubRecordDef;
  wbVISI: IwbSubRecordDef;
  wbMODT: IwbRecordMemberDef;
  wbDMDT: IwbRecordMemberDef;
  wbBoolEnum: IwbEnumDef;
  wbStaticPartPlacements: IwbRecordMemberDef;

  wbINOM: IwbRecordMemberDef;
  wbINOA: IwbRecordMemberDef;

const
  wbWorldMHDTConflictPriority : array[Boolean] of TwbConflictPriority = (cpNormalIgnoreEmpty, cpIgnore);

procedure DefineCommon;

{>>> Common Procedure Callbacks <<<}

procedure wbCTDARunOnAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbPERKPRKETypeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbCNTOsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbTERMCNTOsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbContainerAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbSPLOsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbKWDAsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbNPCAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbRaceAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbKeywordsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbLVLOsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbLLEAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbPRKRsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbSMQNQuestsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbCTDAsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbSDLTListAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbATANsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbBODCsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbBODSsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbConditionsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbCounterEffectsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbMGEFAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbTERMDisplayItemsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbTERMMenuItemsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbSNDRRatesOfFireAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbNPCActorSoundsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbMorphPresetsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

procedure wbLENSAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

{>>> Common Summary Callbacks <<<}

function wbConditionSummaryLinksTo(const aElement: IwbElement): IwbElement;

procedure wbConditionToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbFactionRelationToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbItemToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbRGBAToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbObjectPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
procedure wbCrowdPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbScriptPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbScriptToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbVec3ToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

{>>> Common Function Callbacks <<<}

function wbAtxtPosition(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;

function wbCTDAParam2QuestObjectiveToInt(const aString: string; const aElement: IwbElement): Int64;

function wbCTDAParam2QuestStageToInt(const aString: string; const aElement: IwbElement): Int64;

function wbCTDAReferenceDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;

function wbPxDTLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;

function wbHideFFFF(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;

function wbFolderHashCallback(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
function wbFileHashCallback(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;

function GetREGNType(aElement: IwbElement): Integer;

function wbREGNObjectsDontShow(const aElement: IwbElement): Boolean;

function wbREGNWeatherDontShow(const aElement: IwbElement): Boolean;

function wbREGNMapDontShow(const aElement: IwbElement): Boolean;

function wbREGNLandDontShow(const aElement: IwbElement): Boolean;

function wbREGNGrassDontShow(const aElement: IwbElement): Boolean;

function wbREGNSoundDontShow(const aElement: IwbElement): Boolean;

function wbREGNImposterDontShow(const aElement: IwbElement): Boolean;

function wbScaledInt4ToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;

function wbScaledInt4ToInt(const aString: string; const aElement: IwbElement): Int64;

function wbStrToInt(const aString: string; const aElement: IwbElement): Int64;

function wbScriptObjFormatDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;

function wbBoolEnumSummary(const aTrueSummary: string; const aFalseSummary: string = ''): IwbEnumDef;

{>>> Common Definitions <<<}

function wbRecordHeader(aRecordFlags: IwbIntegerDef): IwbValueDef;

function wbClimateTiming(aTimeCallback: TwbIntToStrCallback; aPhaseCallback: TwbIntToStrCallback): IwbRecordMemberDef;

function wbCNAM(aRequired: Boolean = False): IwbRecordMemberDef;

function wbDebrisModel(aTextureFileHashes: IwbRecordMemberDef): IwbRecordMemberDef;

function wbHeadPart(aHeadPartIndexEnum: IwbEnumDef = nil; aModel: IwbRecordMemberDef = nil; aHeadPartsAfterSet: TwbAfterSetCallback = nil): IwbRecordMemberDef;

function wbLandscapeLayers(aSimpleRecords: Boolean = True): IwbRecordMemberDef;

function wbOBND(aRequired: Boolean = False): IwbRecordMemberDef;

function wbOwnership(aOwner: IwbSubRecordDef; aSkipSigs: TwbSignatures; aGlobal: IwbSubRecordDef = nil): IwbRecordMemberDef;

function wbPerkEffectType(aAfterSetCallback: TwbAfterSetCallback): IwbIntegerDef;

function wbSizePosRot(aSignature: TwbSignature; aName: string; aPriority: TwbConflictPriority = cpNormal): IwbSubRecordDef;

function wbVertexColumns(aSignature: TwbSignature; aName: string): IwbRecordMemberDef;

function wbModelInfo(aSignature: TwbSignature; aName: string = ''): IwbRecordMemberDef;
function wbModelInfos(aSignature: TwbSignature; aName: string = ''; aDontShow  : TwbDontShowCallback = nil): IwbRecordMemberDef;

function wbTimeInterpolators(const aSignature: TwbSignature; const aName: string): IwbRecordMemberDef;
function wbTimeInterpolatorsMultAdd(const aSignatureMult, aSignatureAdd: TwbSignature; const aName: string): IwbRecordMemberDef;

function wbFloatColorRGBA(const aName: string): IwbValueDef;


{>>> Common Functions <<<}

function Sig2Int(aSignature: TwbSignature): Cardinal; inline;

function wbCellAddInfo(const aMainRecord: IwbMainRecord): string;

function wbTryGetContainerWithValidMainRecord(const aElement: IwbElement; out aContainer: IwbContainerElementRef; out aMainRecord: IwbMainRecord): Boolean;

function wbTryGetContainerFromUnion(const aElement: IwbElement; out aContainer: IwbContainer): Boolean;

function wbTryGetContainerRefFromUnionOrValue(const aElement: IwbElement; out aContainer: IwbContainerElementRef): Boolean;

function wbTryGetContainingMainRecord(const aElement: IwbElement; out aMainRecord: IwbMainRecord): Boolean;

function wbTryGetMainRecord(const aElement: IwbElement; out aMainRecord: IwbMainRecord; aSignature: string = ''): Boolean;

function wbFormVersionDecider(aVersion: Integer): TwbUnionDecider; overload;
function wbFormVersionDecider(aMinVersion, aMaxVersion: Integer): TwbUnionDecider; overload;
function wbFormVersionDecider(const aVersions: array of Integer): TwbUnionDecider; overload;

function wbFromVersion(aVersion: Integer; const aSignature: TwbSignature; const aValue: IwbValueDef): IwbRecordMemberDef; overload;
function wbFromVersion(aVersion: Integer; const aValue: IwbValueDef): IwbValueDef; overload;

function wbBelowVersion(aVersion: Integer; const aSignature: TwbSignature; const aValue: IwbValueDef): IwbRecordMemberDef; overload;
function wbBelowVersion(aVersion: Integer; const aValue: IwbValueDef): IwbValueDef; overload;

function wbRecordSizeDecider(aSize: Integer): TwbUnionDecider; overload;
function wbRecordSizeDecider(aMinSize, aMaxSize: Integer): TwbUnionDecider; overload;
function wbRecordSizeDecider(const aSizes: array of Integer): TwbUnionDecider; overload;

function wbFlagDecider(aFlag: Byte): TwbUnionDecider;
function wbNoFlagsDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;

function wbFromSize(aSize: Integer; const aSignature: TwbSignature; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbRecordMemberDef; overload;
function wbFromSize(aSize: Integer; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbValueDef; overload;

function wbBelowSize(aSize: Integer; const aSignature: TwbSignature; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbRecordMemberDef; overload;
function wbBelowSize(aSize: Integer; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbValueDef; overload;

function wbIsFlag(aFlag: Integer; const aSignature: TwbSignature; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbRecordMemberDef; overload;
function wbIsFlag(aFlag: Integer; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbValueDef; overload;

function wbIsNotFlag(aFlag: Integer; const aSignature: TwbSignature; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbRecordMemberDef; overload;
function wbIsNotFlag(aFlag: Integer; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbValueDef; overload;

function wbHasNoFlags(const aSignature: TwbSignature; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbRecordMemberDef; overload;
function wbHasNoFlags(const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbValueDef; overload;

procedure wbUpdateSameParentUnions(const aElement: IwbElement; const aOldValue, aNewValue: Variant);

function wbByteColors(const aName: string = 'Color'): IwbValueDef; overload;
function wbByteColors(const aSignature: TwbSignature; const aName: string = 'Color'): IwbRecordMemberDef; overload;
function wbFloatColors(const aName: string = 'Color'): IwbValueDef; overload;
function wbFloatColors(const aSignature: TwbSignature; const aName: string = 'Color'): IwbRecordMemberDef; overload;
function wbRFloatColors(const aName: string = 'Color'; const aSigs: TwbSignatures = []): IwbRecordMemberDef;
function wbFloatRGBA(const aName: string = 'Color'): IwbValueDef; overload;
function wbFloatRGBA(const aSignature: TwbSignature; const aName: string = 'Color'): IwbRecordMemberDef; overload;
function wbByteRGBA(const aName: string = 'Color'): IwbValueDef; overload;
function wbByteRGBA(const aSignature: TwbSignature; const aName: string = 'Color'): IwbRecordMemberDef; overload;

const
  wbVec3Prefix = '';//'Vec3';
  wbPosPrefix  = 'Pos:';
  wbRotPrefix  = 'Rot:';

function wbVec3(const aName: string = 'Unknown'; const aPrefix: string = wbVec3Prefix): IwbValueDef; overload;
function wbVec3(const aSignature: TwbSignature; const aName: string = 'Unknown'; const aPrefix: string = wbVec3Prefix): IwbRecordMemberDef; overload;

function wbVec3Pos(const aName: string = 'Position'; const aPrefix: string = wbPosPrefix): IwbValueDef; overload;
function wbVec3Pos(const aSignature: TwbSignature; const aName: string = 'Position'; const aPrefix: string = wbPosPrefix): IwbRecordMemberDef; overload;

function wbVec3Rot(const aName: string = 'Rotation'; const aPrefix: string = wbRotPrefix): IwbValueDef; overload;
function wbVec3Rot(const aSignature: TwbSignature; const aName: string = 'Rotation'; const aPrefix: string = wbRotPrefix): IwbRecordMemberDef; overload;

function wbVec3PosRot(const aCombinedName: string = 'Position/Rotation'; const aPosName: string = 'Position'; const aRotName: string = 'Rotation'; const aPosPrefix: string = wbPosPrefix; const aRotPrefix: string = wbRotPrefix): IwbValueDef; overload;
function wbVec3PosRot(const aSignature: TwbSignature; const aCombinedName: string = 'Position/Rotation'; aPosName: string = 'Position'; const aRotName: string = 'Rotation'; const aPosPrefix: string = wbPosPrefix; const aRotPrefix: string = wbRotPrefix): IwbRecordMemberDef; overload;

function wbVec3PosRotDegrees(const aCombinedName: string = 'Position/Rotation'; const aPosName: string = 'Position'; const aRotName: string = 'Rotation'; const aPosPrefix: string = wbPosPrefix; const aRotPrefix: string = wbRotPrefix): IwbValueDef; overload;
function wbVec3PosRotDegrees(const aSignature: TwbSignature; const aCombinedName: string = 'Position/Rotation'; aPosName: string = 'Position'; const aRotName: string = 'Rotation'; const aPosPrefix: string = wbPosPrefix; const aRotPrefix: string = wbRotPrefix): IwbRecordMemberDef; overload;

function wbCombineVarRecs(const a, b : array of const)
                                     : TwbVarRecs;
function wbMakeVarRecs(const a : array of const)
                               : TwbVarRecs;

procedure wbToStringFromLinksToSummary(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
procedure wbToStringFromLinksToMainRecordName(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

implementation

uses
  Classes,
  Math,
  StrUtils,
  SysUtils,
  wbHelpers;

function IfThen(aBoolean: Boolean; const aTrue: TwbSignature; const aFalse: TwbSignature): TwbSignature; overload;
begin
  Result := aFalse;
  if aBoolean then
    Result := aTrue;
end;

function IfThen(aBoolean: Boolean; const aTrue: TwbToStrCallback; const aFalse: TwbToStrCallback): TwbToStrCallback; overload;
begin
  Result := aFalse;
  if aBoolean then
    Result := aTrue;
end;

function IfThen(aBoolean: Boolean; const aTrue: IwbRecordMemberDef; const aFalse: IwbRecordMemberDef): IwbRecordMemberDef; overload;
begin
  Result := aFalse;
  if aBoolean then
    Result := aTrue;
end;

function IfThen(aBoolean: Boolean; const aTrue: IwbValueDef; const aFalse: IwbValueDef): IwbValueDef; overload;
begin
  Result := aFalse;
  if aBoolean then
    Result := aTrue;
end;

function wbOffsetDataColsCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container: IwbDataContainer;
  Element: IwbElement;
  fResult: Extended;
  MinX, MaxX: Integer;
begin
  Result := 0;

  if not Supports(aElement.Container, IwbDataContainer, Container) then
    Exit;

  if not (Container.Name = 'OFST - Offset Data') then
    Exit;

  if not Supports(Container.Container, IwbDataContainer, Container) then
    Exit;

  // Retrieve the minimum X value
  Element := Container.ElementByPath['Object Bounds\NAM0 - Min\X'];
  if not Assigned(Element) then
    Exit;
  MinX := Element.NativeValue;

  // Retrieve the maximum X value
  Element := Container.ElementByPath['Object Bounds\NAM9 - Max\X'];
  if not Assigned(Element) then
    Exit;
  MaxX := Element.NativeValue;

  // Calculate the total number of columns
  Result := MaxX - MinX + 1;
end;

function wbCellSizeDataColsCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container: IwbDataContainer;
  Element: IwbElement;
  fResult: Extended;
  MinX, MaxX: Integer;
begin
  Result := 0;

  if not Supports(aElement.Container, IwbDataContainer, Container) then
    Exit;

  if not (Container.Name = 'CLSZ - Cell Size Data') then
    Exit;

  if not Supports(Container.Container, IwbDataContainer, Container) then
    Exit;

  // Retrieve the minimum X value
  Element := Container.ElementByPath['Object Bounds\NAM0 - Min\X'];
  if not Assigned(Element) then
    Exit;
  MinX := Element.NativeValue;

  // Retrieve the maximum X value
  Element := Container.ElementByPath['Object Bounds\NAM9 - Max\X'];
  if not Assigned(Element) then
    Exit;
  MaxX := Element.NativeValue;

  // Calculate the total number of columns
  Result := MaxX - MinX + 1;
end;

function wbVisibleCellIndexColsCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container: IwbDataContainer;
  Element: IwbElement;
  fResult: Extended;
  MinX, MaxX: Integer;
begin
  Result := 0;

  if not Supports(aElement.Container, IwbDataContainer, Container) then
    Exit;

  if not (Container.Name = 'VISI - Visible Cell Index') then
    Exit;

  if not Supports(Container.Container, IwbDataContainer, Container) then
    Exit;

  // Retrieve the minimum X value
  Element := Container.ElementByPath['Object Bounds\NAM0 - Min\X'];
  if not Assigned(Element) then
    Exit;
  MinX := Element.NativeValue;

  // Retrieve the maximum X value
  Element := Container.ElementByPath['Object Bounds\NAM9 - Max\X'];
  if not Assigned(Element) then
    Exit;
  MaxX := Element.NativeValue;

  // Calculate the total number of columns
  Result := MaxX - MinX + 1;
end;

function wbTimeInterpolators(const aSignature: TwbSignature; const aName: string): IwbRecordMemberDef;
begin
  Result :=
    wbSubRecord(aSignature, aName,
      wbArray('', wbTimeInterpolator)
      .SetSummaryPassthroughMaxCount(10)
      .SetSummaryPassthroughMaxLength(100)
    )
    .IncludeFlag(dfCollapsed, wbCollapseTimeInterpolators);
end;

function wbTimeInterpolatorsMultAdd(const aSignatureMult, aSignatureAdd: TwbSignature; const aName: string): IwbRecordMemberDef;
begin
  var sMult := 'Mult';
  var sAdd := 'Add';
  if SameText(aName, 'Unused') then begin
    sMult := aName;
    sAdd := aName;
  end;

  Result :=
    wbRStruct(aName, [
      wbTimeInterpolators(aSignatureMult, sMult),
      wbTimeInterpolators(aSignatureAdd, sAdd)
    ], [])
    .SetSummaryKey([0, 1])
    .IncludeFlag(dfCollapsed, wbCollapseTimeInterpolatorsMultAdd);
end;

function wbBoolEnumSummary(const aTrueSummary: string; const aFalseSummary: string = ''): IwbEnumDef;
    begin
      Result :=
        wbEnumSummary([
          'False', aFalseSummary,
          'True',  aTrueSummary
        ]);
    end;

procedure DefineCommon;
begin
  wbBoolEnum := wbEnum(['False', 'True']);

  wbHEDR :=
    wbStruct(HEDR, 'Header', [
      wbFloat('Version'),
      wbInteger('Number of Records', itU32),
      wbInteger('Next Object ID', itU32, wbNextObjectIDToString, wbNextObjectIDToInt)
    ], cpNormal, True);

  wbColorInterpolator :=
    wbStructSK([0], 'Data', [
      wbFloat('Time'),
      wbFloatColorRGBA('Value')
    ]);

  wbTimeInterpolator :=
    wbStructSK([0], 'Data', [
      wbFloat('Time'),
      wbFloat('Value')
    ])
    .SetSummaryKey([0, 1])
    .SetSummaryMemberPrefixSuffix(0, '@', '')
    .SetSummaryMemberPrefixSuffix(1, '=', '')
    .SetSummaryDelimiter('')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseTimeInterpolator);

  wbActionFlag :=
    wbInteger(XACT, 'Action Flag', itU32, wbFlags([
      'Use Default',
      'Activate',
      'Open',
      'Open by Default'
    ]));

  wbAlternateTexture :=
    wbStructSK([0, 2], 'Alternate Texture', [
      wbLenString('3D Name'),
      wbFormIDCk('New Texture', [TXST]),
      wbInteger('3D Index', itS32)
    ])
    .SetSummaryKey([2, 0, 1])
    .SetSummaryMemberPrefixSuffix(2, '[', ']')
    .SetSummaryMemberPrefixSuffix(0, '', ' =')
    .SetSummaryDelimiter(' ')
    .IncludeFlag(dfSummaryNoSortKey)
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed);

  wbAxisEnum :=
    wbEnum([], [
      88, 'X',
      89, 'Y',
      90, 'Z'
    ]);

  var wbLandFlags :=
    wbFlags([
      'Hide - Quad 1',
      'Hide - Quad 2',
      'Hide - Quad 3',
      'Hide - Quad 4'
    ], True);
  if wbGameMode in [gmFO4, gmFO76, gmSF1] then
    wbLandFlags :=
      wbFlags([
        'Hide - Quad 1',
        'Hide - Quad 2',
        'Hide - Quad 3',
        'Hide - Quad 4',
        'No Collision - Quad 1',
        'No Collision - Quad 2',
        'No Collision - Quad 3',
        'No Collision - Quad 4'
      ], True);
      
  wbCellGrid :=
    wbStruct(XCLC, 'Grid', [
      wbInteger('X', itS32),
      wbInteger('Y', itS32),
      wbInteger('Land Flags', itU32, wbLandFlags)
    ], cpNormal, False, nil, 2)
    .SetSummaryKeyOnValue([0, 1, 2])
    .SetSummaryPrefixSuffixOnValue(0, '(', '')
    .SetSummaryPrefixSuffixOnValue(1, '', ')')
    .SetSummaryPrefixSuffixOnValue(2, ' {Land: ', '}')
    .IncludeFlagOnValue(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed);

  if wbGameMode in [gmSSE] then
    wbCellGrid :=
      wbStruct(XCLC, 'Grid', [
        wbInteger('X', itS32),
        wbInteger('Y', itS32),
        wbInteger('Land Flags', itU8, wbLandFlags),
        wbByteArray('Unused', 3, cpIgnore)
      ], cpNormal, False, nil, 2)
      .SetSummaryKeyOnValue([0, 1, 2])
      .SetSummaryPrefixSuffixOnValue(0, '(', '')
      .SetSummaryPrefixSuffixOnValue(1, '', ')')
      .SetSummaryPrefixSuffixOnValue(2, ' {Land: ', '}')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed);

  if wbGameMode <= gmFNV then
    wbCinematicIMAD :=
      wbRStruct('Cinematic', [
        wbTimeInterpolatorsMultAdd(_11_IAD, _51_IAD, 'Saturation'),
        wbTimeInterpolatorsMultAdd(_12_IAD, _52_IAD, 'Contrast'),
        wbTimeInterpolatorsMultAdd(_13_IAD, _53_IAD, 'Contrast Avg Lum'),
        wbTimeInterpolatorsMultAdd(_14_IAD, _54_IAD, 'Brightness')
      ], [])
  else
    wbCinematicIMAD :=
      wbRStruct('Cinematic', [
        wbTimeInterpolatorsMultAdd(_11_IAD, _51_IAD, 'Saturation'),
        wbTimeInterpolatorsMultAdd(_12_IAD, _52_IAD, 'Brightness'),
        wbTimeInterpolatorsMultAdd(_13_IAD, _53_IAD, 'Contrast'),
        wbTimeInterpolatorsMultAdd(_14_IAD, _54_IAD, 'Unused')
      ], []);

  wbDATAPosRot :=
    wbVec3PosRot(DATA).SetRequired;

  wbFaction :=
    wbStructSK(SNAM, [0], 'Faction', [
      wbFormIDCk('Faction', [FACT]),
      wbInteger('Rank', itS8),
      IfThen(wbGameMode in [gmFO4, gmFO76, gmSF1], nil, wbByteArray('Unused', 3))
    ])
    .SetSummaryKeyOnValue([0, 1])
    .SetSummaryPrefixSuffixOnValue(1, '{Rank: ', '}')
    .IncludeFlagOnValue(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseFactions);

  wbFactionRelations :=
    wbRArrayS('Relations',
      wbStructSK(XNAM, [0], 'Relation', [
        wbFormIDCkNoReach('Faction', [FACT, RACE]),
        wbInteger('Modifier', itS32),
        IfThen(wbGameMode = gmTES4,
          nil,
          wbInteger('Group Combat Reaction', itU32, wbEnum([
            {0x00000001} 'Neutral',
            {0x00000002} 'Enemy',
            {0x00000004} 'Ally',
            {0x00000008} 'Friend'
          ])))
      ])
      .SetToStr(wbFactionRelationToStr)
      .IncludeFlag(dfCollapsed, wbCollapseFactionRelations));

  wbMDOB := wbFormID(MDOB, 'Menu Display Object', cpNormal, False);

  wbNextSpeaker :=
    wbInteger('Next Speaker', itU8, wbEnum([
      {0} 'Target',
      {1} 'Self',
      {2} 'Either'
    ]));

  wbPosRot :=
    wbVec3PosRot;

  wbQuadrantEnum :=
    wbEnum([
      {0} 'Bottom Left',
      {1} 'Bottom Right',
      {2} 'Top Left',
      {3} 'Top Right'
    ]);

  wbQuestEventVarRecs := wbMakeVarRecs([
    Sig2Int(ADBO), 'Bounty Event',
    Sig2Int(ADCR), 'Crime Gold Event',
    Sig2Int(ADIA), 'Actor Dialogue Event',
    Sig2Int(AFAV), 'Player Activate Actor',
    Sig2Int(AHEL), 'Actor Hello Event',
    Sig2Int(AIPL), 'Player Add Item',
    Sig2Int(AOBJ), 'Attraction Object Event',
    Sig2Int(ARRT), 'Arrest Event',
    Sig2Int(ASSU), 'Assault Actor Event',
    Sig2Int(BRIB), 'Bribe',
    Sig2Int(CAST), 'Cast Magic Event',
    Sig2Int(CHRR), 'Change Relationship Rank',
    Sig2Int(CLOC), 'Change Location Event',
    Sig2Int(CLRL), 'Clear Location Event',
    Sig2Int(CRFT), 'Craft Item',
    Sig2Int(CURE), 'Player Cured',
    Sig2Int(DEAD), 'Dead Body',
    Sig2Int(ESJA), 'Escape Jail',
    Sig2Int(FLAT), 'Flatter',
    Sig2Int(HACK), 'Hack Computer',
    Sig2Int(ILOC), 'Instanced Location Created Event',
    Sig2Int(INFC), 'Player Infected',
    Sig2Int(INTM), 'Intimidate',
    Sig2Int(IRON), 'Iron Sights',
    Sig2Int(JAIL), 'Jail Event',
    Sig2Int(KILL), 'Kill Actor Event',
    Sig2Int(LCLD), 'Location Loaded',
    Sig2Int(LCPG), 'LCP Global Value Event',
    Sig2Int(LEVL), 'Increase Level',
    Sig2Int(LOCK), 'Lock Pick',
    Sig2Int(NVPE), 'New Voice Power',
    Sig2Int(OAAT), 'On Actor Attach',
    Sig2Int(PCON), 'Player Connect',
    Sig2Int(PFIN), 'Pay Fine Event',
    Sig2Int(PRFV), 'Player Recieves Favor',
    Sig2Int(QPMT), 'QuickPlay Match Event',
    Sig2Int(QSTR), 'Quest Start',
    Sig2Int(REMP), 'Player Remove Item',
    Sig2Int(SCPT), 'Script Event',
    Sig2Int(SKIL), 'Skill Increase',
    Sig2Int(STIJ), 'Served Time',
    Sig2Int(TMEE), 'Trigger Mine Explosion Event',
    Sig2Int(TRES), 'Trespass Actor Event'
  ]);

  wbQuestEventEnum := wbEnum([], wbQuestEventVarRecs);

  wbSeasons :=
    wbStruct(PFPC, 'Seasonal ingredient production', [
      wbInteger('Spring', itU8),
      wbInteger('Summer ', itU8),
      wbInteger('Fall', itU8),
      wbInteger('Winter', itU8)
    ], cpNormal, True);

  wbSexEnum :=
    wbEnum(['Male','Female']);

  wbActorSounds :=
    wbRArrayS('Sounds',
      wbRStructSK([0], 'Sound', [
        wbFormIDCk(CS2K, 'Keyword', [KYWD]),
        wbFormIDCk(CS2D, 'Sound', [SNDR], False, cpNormal, True)
      ], [], cpNormal, False, nil, True)
      .SetSummaryKey([1, 0])
      .SetSummaryMemberPrefixSuffix(0, '{', '}')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfSummaryNoSortKey)
      .IncludeFlag(dfCollapsed),
      cpNormal, False, nil, wbNPCActorSoundsAfterSet);

  wbMagicEffectSounds :=
    wbArray(SNDD, 'Sounds',
      wbStruct('', [
        wbInteger('Type', itU32, wbEnum([
          'Sheathe/Draw',
          'Charge',
          'Ready',
          'Release',
          'Concentration Cast Loop',
          'On Hit'
        ])),
        wbFormIDCk('Sound', [SNDR])
      ])
      .SetSummaryKey([0, 1])
      .SetSummaryMemberPrefixSuffix(0, '[', ']')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed)
    );

  wbRegionSounds :=
    wbArrayS(IfThen(wbGameMode in [gmTES4, gmFO3, gmFNV], RDSD, RDSA), 'Sounds', wbStructSK([0], 'Sound', [
        wbFormIDCk('Sound', [SNDR, SOUN, NULL]),
        wbInteger('Flags', itU32, wbFlags([
          'Pleasant',
          'Cloudy',
          'Rainy',
          'Snowy'
        ])),
        IfThen(wbGameMode in [gmTES4, gmFO3, gmFNV], wbInteger('Chance', itU32, wbScaledInt4ToStr, wbScaledInt4ToInt), wbFloat('Chance'))
      ]), 0, cpNormal, False, nil, nil, wbREGNSoundDontShow);

  wbSoundDescriptorSounds :=
    wbRArray('Sounds',
      wbRStruct('Sound Files', [
        wbString(ANAM, 'File Name')
      ], [])
      .SetSummaryKey([0])
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed)
    );

  wbSoundTypeSounds :=
    wbRArrayS('Sounds',
      wbRStructSK([0], 'Sound', [
        wbFormIDCk(CSDI, 'Sound', [SNDR, NULL], False, cpNormal, True),
        wbInteger(CSDC, 'Sound Chance', itU8, nil, cpNormal, True)
      ], [])
      .SetSummaryKey([0, 1])
      .SetSummaryMemberPrefixSuffix(1, '{Chance: ', '}')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfSummaryNoSortKey)
      .IncludeFlag(dfCollapsed)
    , cpNormal, True);

  wbWeatherSounds :=
    wbRArray('Sounds',
      wbStruct(SNAM, 'Sound', [
        wbFormIDCK('Sound', [SNDR, SOUN, NULL]),
        wbInteger('Type', itU32, wbEnum([
          {0x01} 'Default',
          {0x02} 'Precipitation',
          {0x04} 'Wind',
          {0x08} 'Thunder'
        ]))
      ]).SetSummaryKeyOnValue([1, 0])
      .SetSummaryPrefixSuffixOnValue(1, '[', ']')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed)
    );

  wbVertexHeightMap :=
    wbStruct(VHGT, 'Vertex Height Map', [
      wbFloat('Offset'),
      wbArray('Rows', wbStruct('Row', [
        wbArray('Columns', wbInteger('Column', itS8), 33)
      ]), 33),
      wbByteArray('Unused', 3)
    ]);

  var lScaleFactor := 1/wbCellSizeFactor;

  wbWorldspaceOBND :=
    wbRStruct('Worldspace Bounds', [
      wbStruct(NAM0, 'Min', [
        wbFloat('X', cpNormal, False, lScaleFactor),
        wbFloat('Y', cpNormal, False, lScaleFactor)
      ], cpIgnore, True)
      .SetSummaryKeyOnValue([0, 1])
      .SetSummaryPrefixSuffixOnValue(0, 'Min(', '')
      .SetSummaryPrefixSuffixOnValue(1, '', ')')
      .SetSummaryDelimiterOnValue(', ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseObjectBounds),
      wbStruct(NAM9, 'Max', [
        wbFloat('X', cpNormal, False, lScaleFactor),
        wbFloat('Y', cpNormal, False, lScaleFactor)
      ], cpIgnore, True)
      .SetSummaryKeyOnValue([0, 1])
      .SetSummaryPrefixSuffixOnValue(0, 'Max(', '')
      .SetSummaryPrefixSuffixOnValue(1, '', ')')
      .SetSummaryDelimiterOnValue(', ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseObjectBounds)
    ], [])
    .SetSummaryKey([0, 1])
    .SetSummaryMemberPrefixSuffix(0, '[', '')
    .SetSummaryMemberPrefixSuffix(1, '', ']')
    .SetSummaryDelimiter(', ')
    .IncludeFlag(dfCollapsed, wbCollapseObjectBounds);

  wbXLOD := wbArray(XLOD, 'Distant LOD Data', wbFloat('Unknown'), 3);

  if wbSimpleRecords then
    wbLargeReferences := wbRArray('Large References',
                           wbByteArray(RNAM, 'Large Reference'),
                         cpIgnore, False, nil, nil, wbNeverShow)
  else
    wbLargeReferences := wbRArray('Large References',
                           wbStruct(RNAM, 'Grid', [
                             wbInteger('Y', itS16, nil, cpIgnore),
                             wbInteger('X', itS16, nil, cpIgnore),
                             wbArray('References',
                               wbStruct('Reference', [
                                 wbFormIDCk('Ref', [REFR], False, cpIgnore),
                                 wbInteger('Y', itS16, nil, cpIgnore),
                                 wbInteger('X', itS16, nil, cpIgnore)
                               ]).IncludeFlag(dfCollapsed)
                               .IncludeFlag(dfFastAssign),
                             -1).IncludeFlag(dfCollapsed)
                             .IncludeFlag(dfFastAssign)
                             .IncludeFlag(dfNotAlignable)
                           ]).SetSummaryKeyOnValue([1,0])
                           .SetSummaryPrefixSuffixOnValue(1, 'X: ', '')
                           .SetSummaryPrefixSuffixOnValue(0, 'Y: ', '')
                           .SetSummaryDelimiterOnValue(' ')
                           .IncludeFlag(dfCollapsed)
                           .IncludeFlag(dfFastAssign),
                         cpIgnore, False, nil, nil, wbNeverShow);

  if wbSimpleRecords then
    wbMaxHeightDataCELL := wbByteArray(MHDT, 'Max Height Data')
  else
    wbMaxHeightDataCELL := wbStruct(MHDT, 'Max Height Data', [
      wbFloat('Offset'),
      wbArray('Rows',
        wbArray('Columns',
          wbInteger('Column', itU8),
        32).IncludeFlag(dfCollapsed),
      32).IncludeFlag(dfCollapsed)]);

    if wbSimpleRecords then
      wbMaxHeightDataWRLD := wbByteArray(MHDT, 'Max Height Data', 0, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT])
    else
      wbMaxHeightDataWRLD := wbStruct(MHDT, 'Max Height Data', [
      wbStruct('Min', [
        wbInteger('X', itS16, nil, nil, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT]),
        wbInteger('Y', itS16, nil, nil, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT])
      ]),
      wbStruct('Max', [
        wbInteger('X', itS16, nil, nil, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT]),
        wbInteger('Y', itS16, nil, nil, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT])
      ]),
      wbArray('Cell Data',
        wbStruct('Quad Height', [
          wbInteger('Bottom Left', itU8, nil, nil, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT]),
          wbInteger('Bottom Right', itU8, nil, nil, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT]),
          wbInteger('Top Left', itU8, nil, nil, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT]),
          wbInteger('Top Right', itU8, nil, nil, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT])],
        wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT])
        .IncludeFlag(dfCollapsed)
        .IncludeFlag(dfFastAssign))
      .IncludeFlag(dfCollapsed)
      .IncludeFlag(dfFastAssign)
      .IncludeFlag(dfNotAlignable)
    ], wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT]);

  if wbSimpleRecords then
    wbOFST := wbByteArray(OFST, 'Offset Data', 0, cpIgnore, False, False, wbNeverShow)
  else
    wbOFST := wbArray(OFST, 'Offset Data',
                wbArray('Row',
                  wbInteger('Column', itU32, nil, cpIgnore),
                  wbOffsetDataColsCounter, cpIgnore)
                .IncludeFlag(dfCollapsed)
                .IncludeFlag(dfFastAssign)
                .IncludeFlag(dfNotAlignable), 0, nil, nil, cpIgnore, False, wbNeverShow);

  if wbSimpleRecords then
    wbCLSZ := wbByteArray(CLSZ, 'Cell Size Data', 0, cpIgnore, False, False, wbNeverShow)
  else
    wbCLSZ := wbArray(CLSZ, 'Cell Size Data',
                wbArray('Row',
                  wbInteger('Column', itU32, nil, cpIgnore),
                  wbCellSizeDataColsCounter, cpIgnore)
                .IncludeFlag(dfCollapsed)
                .IncludeFlag(dfFastAssign)
                .IncludeFlag(dfNotAlignable), 0, nil, nil, cpIgnore, False, wbNeverShow);

  if wbSimpleRecords then
    wbVISI := wbByteArray(VISI, 'Visible Cell Index Data', 0, cpIgnore, False, False, wbNeverShow)
  else
    wbVISI := wbStruct(VISI, 'Visible Cell Index Data', [
                wbArray('Visible Cell Index',
                  wbArray('Row',
                    wbFormIDCK('Cell', [CELL, NULL], false, cpIgnore),
                  wbVisibleCellIndexColsCounter, cpIgnore)
                  .IncludeFlag(dfCollapsed)
                  .IncludeFlag(dfFastAssign)
                  .IncludeFlag(dfNotAlignable),
                nil, cpIgnore)
                .IncludeFlag(dfCollapsed)
                .IncludeFlag(dfFastAssign)
                .IncludeFlag(dfNotAlignable),
                wbStruct('Dimensions', [
                  wbInteger('Min Y', itS16, nil, cpIgnore),
                  wbInteger('Min X', itS16, nil, cpIgnore),
                  wbInteger('Rows', itU32, nil, cpIgnore)
                ], cpIgnore)
              ], cpIgnore, False, wbNeverShow);

  wbMODT := wbModelInfo(MODT);
  wbDMDT := wbModelInfo(DMDT);

  wbStaticPartPlacements :=
    wbArrayS(DATA, 'Placements',
      wbStruct('Placement', [
        wbVec3Pos,
        wbVec3Rot,
        wbFloat('Scale')
      ])
      .SetSummaryKey([0, 1, 2])
      .SetSummaryMemberPrefixSuffix(2, 'Scale: ', '')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapsePlacement)
    , 0, cpNormal, True);

  wbINOM :=
    wbArray(INOM, 'INFO Order (Masters only)',
      wbFormIDCk('INFO', [INFO], False, cpBenign)
        .IncludeFlag(dfUseLoadOrder)
    , 0, nil, nil, cpBenign)
      .IncludeFlag(dfInternalEditOnly)
      .IncludeFlag(dfDontSave)
      .IncludeFlag(dfDontAssign);

  wbINOA :=
    wbArray(INOA, 'INFO Order (All previous modules)',
      wbFormIDCk('INFO', [INFO], False, cpBenign)
        .IncludeFlag(dfUseLoadOrder)
    , 0, nil, nil, cpBenign)
      .IncludeFlag(dfInternalEditOnly)
      .IncludeFlag(dfDontSave)
      .IncludeFlag(dfDontAssign);
end;

function Sig2Int(aSignature: TwbSignature): Cardinal; inline;
begin
  Result := PCardinal(@aSignature)^;
end;

{>>> Common Callbacks <<<}

function wbAtxtPosition(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';

  if aType = ctToSortKey then begin
    Result := IntToHex64(aInt div 17, 2) + IntToHex64(aInt mod 17, 2);
    Exit;
  end;

  if aType = ctCheck then begin
    if (aInt < 0) or (aInt > 288) then
      Result := '<Out of range: '+aInt.ToString+'>'
    else
      Exit;
  end;

  if aType in [ctToStr, ctToSummary] then
    Result := aInt.ToString + ' -> ' + IntToStr(aInt div 17) + ':' + IntToStr(aInt mod 17);
end;

function wbCTDAReferenceDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  if wbGameMode = gmFNV then begin
    // IsFacingUp, IsLeftUp
    var i := Container.ElementNativeValues['Function'];
    if (i = 106) or (i = 285) then
      Exit;
  end;

  if Integer(Container.ElementNativeValues['Run On']) = 2 then
    Result := 1;
end;

function wbPxDTLocationDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  Result := Container.ElementByName['Type'].NativeValue;
end;

function wbCTDAParam2QuestObjectiveToInt(const aString: string; const aElement: IwbElement): Int64;
var
  i    : Integer;
  s    : string;
begin
  i := 1;
  s := Trim(aString);
  while (i <= Length(s)) and (s[i] in ['0'..'9']) do
    Inc(i);
  s := Copy(s, 1, Pred(i));

  Result := StrToInt(s);
end;

function wbCTDAParam2QuestStageToInt(const aString: string; const aElement: IwbElement): Int64;
var
  i    : Integer;
  s    : string;
begin
  i := 1;
  s := Trim(aString);
  while (i <= Length(s)) and (s[i] in ['0'..'9']) do
    Inc(i);
  s := Copy(s, 1, Pred(i));

  Result := StrToInt(s);
end;

procedure wbCTDARunOnAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  if aOldValue <> aNewValue then
    if aNewValue <> 2 then
      aElement.Container.ElementNativeValues['Reference'] := 0;
end;

procedure wbPERKPRKETypeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container : IwbContainerElementRef;
begin
  if not (aOldValue <> aNewValue) then
    Exit;

  if not Supports(aElement.Container, IwbContainerElementRef, Container) then
    Exit;

  if not Supports(Container.Container, IwbContainerElementRef, Container) then
    Exit;

  Container.RemoveElement('DATA');
  Container.Add('DATA', True);
  Container.RemoveElement('Perk Conditions');
  Container.RemoveElement('Entry Point Function Parameters');

  if not (aNewValue = 2) then
    Exit;

  Container.Add('EPFT', True);
  Container.ElementNativeValues['DATA\Entry Point\Function'] := 2;
end;

procedure wbCNTOsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('COCT - Count', aElement);
end;

procedure wbTERMCNTOsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('COCT - Holds Holotape (Count)', aElement);
end;

procedure wbContainerAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterContainerAfterSet('COCT - Count', 'Items', aElement);
  wbCounterContainerAfterSet('KSIZ - Keyword Count', 'KWDA - Keywords', aElement);
end;

procedure wbSPLOsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('SPCT - Count', aElement);
end;

procedure wbKWDAsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('KSIZ - Keyword Count', aElement);
end;

procedure wbNPCAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterContainerAfterSet('COCT - Count', 'Items', aElement);
  wbCounterContainerAfterSet('SPCT - Count', 'Actor Effects', aElement);
  wbCounterContainerAfterSet('LLCT - Count', 'Leveled List Entries', aElement);
  wbCounterContainerAfterSet('KSIZ - Keyword Count', 'KWDA - Keywords', aElement);
  wbCounterContainerAfterSet('PRKZ - Perk Count', 'Perks', aElement);
end;

procedure wbRaceAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterContainerAfterSet('SPCT - Count', 'Actor Effects', aElement);
  wbCounterContainerAfterSet('KSIZ - Keyword Count', 'KWDA - Keywords', aElement);
end;

procedure wbKeywordsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterContainerAfterSet('KSIZ - Keyword Count', 'KWDA - Keywords', aElement);
end;

procedure wbLVLOsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('LLCT - Count', aElement);
end;

procedure wbLLEAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterContainerAfterSet('LLCT - Count', 'Leveled List Entries', aElement);
end;

procedure wbPRKRsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('PRKZ - Perk Count', aElement);
end;

procedure wbSMQNQuestsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('QNAM - Quest Count', aElement);
end;

procedure wbCTDAsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('CITC - Condition Count', aElement);
end;

procedure wbSDLTListAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('ITMC - Secondary List Count', aElement);
end;

procedure wbATANsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('ATCP - Activity Count', aElement);
end;

procedure wbBODSsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('BODC - Count', aElement);
end;

procedure wbBODCsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('BODM - Count', aElement);
end;

procedure wbConditionsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterContainerAfterSet('CITC - Condition Count', 'Conditions', aElement);
end;

procedure wbCounterEffectsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  // if it is really possible to have both counter effects and multiple data, this is going to be tricky.
  wbCounterByPathAfterSet('Magic Effect Data\DATA - Data\Counter effect count', aElement);
end;

procedure wbMGEFAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbKeywordsAfterSet(aElement, aOldValue, aNewValue);
  wbCounterContainerByPathAfterSet('Magic Effect Data\DATA - Data\Counter effect count', 'Counter Effects', aElement);
end;

procedure wbTERMDisplayItemsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('BSIZ - Count', aElement);
end;

procedure wbTERMMenuItemsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('ISIZ - Count', aElement);
end;

procedure wbSNDRRatesOfFireAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('ITMC - Count', aElement);
end;

procedure wbNPCActorSoundsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('CS2H - Count', aElement);
end;

procedure wbMorphPresetsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('MPPC - Count', aElement);
end;

procedure wbLENSAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('LFSP - Count', aElement);
end;

function wbHideFFFF(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 4)
  else if aType in [ctToStr, ctToSummary] then
    if aInt = $FFFF then
      Result := 'None'
    else
      Result := aInt.ToString;
end;

function wbFolderHashCallback(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Strings: TDynStrings;
  i: Integer;
begin
  Result := '';
  if wbLoaderDone and (aType in [ctToStr, ctToSummary, ctToSortKey] ) then
    Result := wbContainerHandler.ResolveFolderHash(aInt);

  if Result = '' then
    case aType of
      ctToSortKey:
        Result := IntToHex64(aInt, 16);
      ctToStr, ctToSummary:
        if (aInt > High(Cardinal)) or (aType = ctToStr) then
          Result := '{' + IntToHex64(aInt, 16) + '}'
        else
          Result := '{' + IntToHex64(aInt, 8) + '}';
      ctToEditValue:
        Result := aInt.ToString;
    end;
end;

function wbFileHashCallback(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Strings: TDynStrings;
  i: Integer;
begin
  Result := '';
  if wbLoaderDone and (aType in [ctToStr, ctToSummary, ctToSortKey] ) then
    Result := wbContainerHandler.ResolveFileHash(aInt);

  if Result = '' then
    case aType of
      ctToSortKey:
        Result := IntToHex64(aInt, 16);
      ctToStr, ctToSummary:
        if (aInt > High(Cardinal)) or (aType = ctToStr) then
          Result := '{' + IntToHex64(aInt, 16) + '}'
        else
          Result := '{' + IntToHex64(aInt, 8) + '}';
      ctToEditValue:
        Result := aInt.ToString;
    end;
end;

function GetREGNType(aElement: IwbElement): Integer;
var
  Container: IwbContainerElementRef;
begin
  Result := -1;
  if not Assigned(aElement) then
    Exit;

  while aElement.Name <> 'Region Data Entry' do begin
    aElement := aElement.Container;
    if not Assigned(aElement) then
      Exit;
  end;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  Result := Container.ElementNativeValues['RDAT\Type'];
end;

function wbREGNObjectsDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 2;
end;

function wbREGNWeatherDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 3;
end;

function wbREGNMapDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 4;
end;

function wbREGNLandDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 5;
end;

function wbREGNGrassDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 6;
end;

function wbREGNSoundDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 7;
end;

function wbREGNImposterDontShow(const aElement: IwbElement): Boolean;
begin
  Result := GetREGNType(aElement) <> 8;
end;

function wbScaledInt4ToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
const
  PlusMinus : array[Boolean] of string = ('+', '-');
begin
  Result := '';
  case aType of
    ctToStr, ctToSummary, ctToEditValue: Result := FloatToStrF(aInt / 10000, ffFixed, 99, 4);
    ctToSortKey: begin
      Result := FloatToStrF(aInt / 10000, ffFixed, 99, 4);
      if Length(Result) < 22 then
        Result := StringOfChar('0', 22 - Length(Result)) + Result;
      Result := PlusMinus[aInt < 0] + Result;
    end;
    ctCheck: Result := '';
  end;
end;

function wbScaledInt4ToInt(const aString: string; const aElement: IwbElement): Int64;
var
  f: Extended;
begin
  f := StrToFloat(aString);
  f := f * 10000;
  Result := Round(f);
end;

function wbStrToInt(const aString: string; const aElement: IwbElement): Int64;
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
    Result := StrToInt64(s)
  except
    Result := 0;
  end;
end;

{>>> Common Definitions <<<}

function wbRecordHeader(aRecordFlags: IwbIntegerDef): IwbValueDef;
begin
  Result := wbStruct('Record Header', [
    wbString('Signature', 4, cpCritical),
    wbInteger('Data Size', itU32, nil, cpIgnore),
    aRecordFlags.IncludeFlag(dfIsRecordFlags),
    wbFormID('FormID', cpFormID).IncludeFlag(dfSummarySelfAsShortName),
    IfThen(wbIsSkyrim,
      wbUnion('Version Control Info 1', wbFormVersionDecider(44), [
        wbByteArray('Version Control Info 1', 4, cpIgnore).SetToStr(wbVCI1ToStrBeforeFO4),
        wbByteArray('Version Control Info 1', 4, cpIgnore).SetToStr(wbVCI1ToStrAfterFO4)
      ]),
      wbByteArray('Version Control Info 1', 4, cpIgnore).SetToStr(
        IfThen(wbGameMode in [gmFO3, gmFNV], wbVCI1ToStrBeforeFO4, wbVCI1ToStrAfterFO4)
      )
    ),
    wbInteger('Form Version', itU16, nil, cpIgnore).IncludeFlag(dfSummaryShowIgnore),
    wbByteArray('Version Control Info 2', 2, cpIgnore)
  ])
  .SetSummaryKey([5, 3, 2])
  .SetSummaryMemberPrefixSuffix(5, '[v', ']')
  .SetSummaryMemberPrefixSuffix(2, '{', '}')
  .SetSummaryDelimiter(' ')
  .IncludeFlag(dfSummaryMembersNoName)
  .IncludeFlag(dfCollapsed, wbCollapseRecordHeader);
end;

function wbClimateTiming(aTimeCallback: TwbIntToStrCallback; aPhaseCallback: TwbIntToStrCallback): IwbRecordMemberDef;
var
  lMoonPhase: IwbValueDef;
begin
  if Assigned(aPhaseCallback) then
    lMoonPhase := wbInteger('Moons / Phase Length', itU8, aPhaseCallback)
  else
    lMoonPhase := nil;

  Result :=
    wbStruct(TNAM, 'Timing', [
      wbStruct('Sunrise', [
        wbInteger('Begin', itU8, aTimeCallback),
        wbInteger('End', itU8, aTimeCallback)
      ]),
      wbStruct('Sunset', [
        wbInteger('Begin', itU8, aTimeCallback),
        wbInteger('End', itU8, aTimeCallback)
      ]),
      wbInteger('Volatility', itU8),
      lMoonPhase
    ], cpNormal, True);
end;

function wbCNAM(aRequired: Boolean = False): IwbRecordMemberDef;
begin
  Result :=
    wbStruct(CNAM, 'Color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbInteger('Alpha', itU8)
    ], cpNormal, aRequired)
    .SetToStr(wbRGBAToStr)
    .IncludeFlag(dfCollapsed, wbCollapseRGBA);
end;

function wbFloatColorRGBA(const aName: string): IwbValueDef;
begin
  Result :=
    wbStruct(aName, [
      wbFloat('Red', cpNormal, False, 255, 0),
      wbFloat('Green', cpNormal, False, 255, 0),
      wbFloat('Blue', cpNormal, False, 255, 0),
      wbFloat('Alpha', cpNormal, False, 255, 0)
    ])
    .SetToStr(wbRGBAToStr)
    .IncludeFlag(dfCollapsed, wbCollapseRGBA);
end;

function wbDebrisModel(aTextureFileHashes: IwbRecordMemberDef): IwbRecordMemberDef;
begin
  Result :=
    wbRStruct('Model', [
      wbStruct(DATA, 'Data', [
        wbInteger('Percentage', itU8),
        wbString('Model FileName'),
        wbInteger('Flags', itU8, wbFlagsSummary([
          'Has Collision Data', 'Collision'
        ]))
      ], cpNormal, True)
      .SetSummaryKeyOnValue([0, 1, 2])
      .SetSummaryPrefixSuffixOnValue(0, '[', '%]')
      .SetSummaryPrefixSuffixOnValue(2, '{', '}')
      .SetSummaryMemberMaxDepthOnValue(0, 1)
      .IncludeFlagOnValue(dfSummaryMembersNoName),
      aTextureFileHashes
    ], [], cpNormal, True)
    .SetSummaryKey([0])
    .IncludeFlag(dfCollapsed, wbCollapseModels);
end;

function wbHeadPart(aHeadPartIndexEnum: IwbEnumDef = nil; aModel: IwbRecordMemberDef = nil; aHeadPartsAfterSet: TwbAfterSetCallback = nil): IwbRecordMemberDef;
begin
  var wbICON: IwbRecordMemberDef := nil;

  if wbGameMode = gmTES4 then
    wbICON := wbString(ICON, 'Icon FileName')
  else if wbGameMode = gmFNV then
    wbICON := wbRStruct('Icon', [
      wbString(ICON, 'Large Icon FileName', 0, cpNormal, True),
      wbString(MICO, 'Small Icon FileName')
    ], [], cpNormal, False, nil, True)
  else if wbGameMode = gmFO3 then
    wbICON := wbRStruct('Icon', [
      wbString(ICON, 'Large Icon FileName'),
      wbString(MICO, 'Small Icon FileName')
    ], []);

  Result :=
    wbRStructSK([0], IfThen(wbGameMode in [gmTES4, gmFO3, gmFNV], 'Part', 'Head Part'), [
      wbInteger(INDX, IfThen(wbGameMode in [gmTES4, gmFO3, gmFNV], 'Index', 'Head Part Number'), itU32, aHeadPartIndexEnum),
      IfThen(wbGameMode in [gmTES4, gmFO3, gmFNV], aModel, nil),
      IfThen(wbGameMode in [gmTES4, gmFO3, gmFNV], nil, wbFormIDCk(HEAD, 'Head', [HDPT, NULL])),
      IfThen(wbGameMode in [gmTES4, gmFO3, gmFNV], wbICON, nil)
    ], [], cpNormal, False, nil, False, nil, aHeadPartsAfterSet)
    .SetSummaryKey([0, 1])
    .SetSummaryMemberPrefixSuffix(0, '[', ']')
    .SetSummaryDelimiter(' ')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfSummaryNoSortKey)
    .IncludeFlag(dfCollapsed, wbCollapseHeadParts);
end;

function wbLandscapeLayers(aSimpleRecords: Boolean = True): IwbRecordMemberDef;
var
  alphaLayerData: IwbSubRecordDef;
begin
  if aSimpleRecords then
    alphaLayerData := wbByteArray(VTXT, 'Alpha Layer Data')
  else
    alphaLayerData :=
      wbArrayS(VTXT, 'Alpha Layer Data', wbStructSK([0], 'Cell', [
        wbInteger('Position', itU16, wbAtxtPosition),
        wbByteArray('Unused', 2),
        wbFloat('Opacity')
      ]));

  Result :=
    wbRArrayS('Layers', wbRUnion('Layer', [
      wbRStructSK([0],'Base Layer', [
        wbStructSK(BTXT, [1, 3], 'Base Layer Header', [
          wbFormIDCk('Texture', [LTEX, NULL]),
          wbInteger('Quadrant', itU8, wbQuadrantEnum),
          wbByteArray('Unused', 1),
          wbInteger('Layer', itS16)
        ])
      ], []),
      wbRStructSK([0],'Alpha Layer', [
        wbStructSK(ATXT, [1, 3], 'Alpha Layer Header', [
          wbFormIDCk('Texture', [LTEX, NULL]),
          wbInteger('Quadrant', itU8, wbQuadrantEnum),
          wbByteArray('Unused', 1),
          wbInteger('Layer', itS16)
        ]),
        alphaLayerData
      ], [])
    ], []));
end;

function wbOBND(aRequired: Boolean = False): IwbRecordMemberDef;
begin
  Result :=
    wbStruct(OBND, 'Object Bounds', [
      wbInteger('X1', itS16),
      wbInteger('Y1', itS16),
      wbInteger('Z1', itS16),
      wbInteger('X2', itS16),
      wbInteger('Y2', itS16),
      wbInteger('Z2', itS16)
    ], cpNormal, aRequired)
    .SetSummaryKeyOnValue([0, 1, 2, 3, 4, 5])
    .SetSummaryPrefixSuffixOnValue(0, '(', '')
    .SetSummaryPrefixSuffixOnValue(2, '', ')')
    .SetSummaryPrefixSuffixOnValue(3, '(', '')
    .SetSummaryPrefixSuffixOnValue(5, '', ')')
    .SetSummaryDelimiterOnValue(', ')
    .IncludeFlagOnValue(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseObjectBounds);
end;

function wbOwnership(aOwner: IwbSubRecordDef; aSkipSigs: TwbSignatures; aGlobal: IwbSubRecordDef = nil): IwbRecordMemberDef;
begin
  Result :=
    wbRStruct('Ownership', [
      aOwner,
      wbInteger(XRNK, 'Faction rank', itS32),
      IfThen(wbGameMode = gmTES4, aGlobal, nil)
    ], aSkipSigs)
    .SetSummaryKey([0, 1])
    .SetSummaryMemberPrefixSuffix(1, '{Rank: ', '}')
    .SetSummaryDelimiter(' ')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfSummaryNoSortKey)
    .IncludeFlag(dfCollapsed, wbCollapseFactions);
end;

function wbPerkEffectType(aAfterSetCallback: TwbAfterSetCallback): IwbIntegerDef;
begin
  Result :=
    wbInteger('Type', itU8, wbEnum([
      'Quest + Stage',
      'Ability',
      'Entry Point'
    ]), cpNormal, False, nil, aAfterSetCallback);
end;

function wbSizePosRot(aSignature: TwbSignature; aName: string; aPriority: TwbConflictPriority = cpNormal): IwbSubRecordDef;
begin
  Result :=
    wbStruct(aSignature, aName, [
      wbStruct('Size', [
        wbFloat('Width', cpNormal, False, 2),
        wbFloat('Height', cpNormal, False, 2)
      ])
      .SetSummaryKey([0, 1])
      .SetSummaryMemberPrefixSuffix(0, 'Size(', '')
      .SetSummaryMemberPrefixSuffix(1, '', ')')
      .SetSummaryDelimiter(', ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed),

      wbVec3Pos,

      wbStruct('Rotation (Quaternion?)', [
        wbFloat('q1'),
        wbFloat('q2'),
        wbFloat('q3'),
        wbFloat('q4')
      ])
      .SetSummaryKey([0, 1, 2, 3])
      .SetSummaryMemberPrefixSuffix(0, 'Quat(', '')
      .SetSummaryMemberPrefixSuffix(3, '', ')')
      .SetSummaryDelimiter(', ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed)
    ], aPriority);
end;

function wbVertexColumns(aSignature: TwbSignature; aName: string): IwbRecordMemberDef;
begin
  Result :=
    wbArray(aSignature, aName, wbStruct('Row', [
      wbArray('Columns', wbStruct('Column', [
        wbInteger('X', itU8),
        wbInteger('Y', itU8),
        wbInteger('Z', itU8)
      ])
      .SetSummaryKey([0, 1, 2])
      .SetSummaryMemberPrefixSuffix(0, wbVec3Prefix + '(', '')
      .SetSummaryMemberPrefixSuffix(2, '', ')')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseVec3), 33)
    ]), 33);
end;

{>>> For Collapsible Fields <<<}

function wbTrySetContainer(const aElement: IwbElement; aType: TwbCallbackType; out aContainer: IwbContainerElementRef): Boolean;
begin
  Result := (aType = ctToSummary) and Supports(aElement, IwbContainerElementRef, aContainer);
end;

{>>> Common Functions <<<}

function wbCellAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Rec: IwbRecord;
  Container: IwbContainer;
  GroupRecord : IwbGroupRecord;
  s: string;
begin
  Result := '';

  if not aMainRecord.IsPersistent then begin
    Rec := aMainRecord.RecordBySignature['XCLC'];
    if Assigned(Rec) then
      Result := 'at ' + Rec.Elements[0].Value + ',' + Rec.Elements[1].Value;
  end;

  Container := aMainRecord.Container;
  while Assigned(Container) and not
    (Supports(Container, IwbGroupRecord, GroupRecord) and (GroupRecord.GroupType = 1)) do
    Container := Container.Container;

  if not Assigned(Container) then
    Exit;

  s := wbFormID.ToString(GroupRecord.GroupLabel, aMainRecord, False);
  if not (s <> '') then
    Exit;

  if Result <> '' then
    s := s + ' ';

  Result := 'in ' + s + Result;
end;

function wbTryGetContainerWithValidMainRecord(const aElement: IwbElement; out aContainer: IwbContainerElementRef; out aMainRecord: IwbMainRecord): Boolean;
begin
  Result := False;

  if not Supports(aElement, IwbContainerElementRef, aContainer) then
    Exit;
  if aContainer.ElementCount < 1 then
    Exit;
  if not Supports(aElement, IwbMainRecord, aMainRecord) then
    Exit;
  if aMainRecord.IsDeleted then
    Exit;

  Result := True;
end;

function wbTryGetContainerFromUnion(const aElement: IwbElement; out aContainer: IwbContainer): Boolean;
begin
  Result := False;

  if not Assigned(aElement) then
    Exit;

  aContainer := GetContainerFromUnion(aElement);
  if not Assigned(aContainer) then
    Exit;

  Result := True;
end;

function wbTryGetContainerRefFromUnionOrValue(const aElement: IwbElement; out aContainer: IwbContainerElementRef): Boolean;
begin
  Result := False;

  if not Assigned(aElement) then
    Exit;

  aContainer := GetContainerRefFromUnionOrValue(aElement);
  if not Assigned(aContainer) then
    Exit;

  Result := True;
end;

function wbTryGetContainingMainRecord(const aElement: IwbElement; out aMainRecord: IwbMainRecord): Boolean;
begin
  Result := False;

  if not Assigned(aElement) then
    Exit;

  aMainRecord := aElement.ContainingMainRecord;

  if not Assigned(aMainRecord) then
    Exit;

  Result := True;
end;

function wbTryGetMainRecord(const aElement: IwbElement; out aMainRecord: IwbMainRecord; aSignature: string = ''): Boolean;
begin
  Result := False;

  if not Assigned(aElement) then
    Exit;

  if not Supports(aElement.LinksTo, IwbMainRecord, aMainRecord) then
    Exit;

  if not SameText(aSignature, '') then
    if aMainRecord.Signature <> aSignature then
      Exit;

  Result := True;
end;

{>>> Common Callbacks <<<}

/// <summary>Generates "{Count}x {FormID}" string for item. Supports single and double structs.</summary>
/// <param name="aContainer">The Item element</param>
/// <returns>string</return>
function wbGetItemStr(const aContainer: IwbContainerElementRef): string;
var
  MainRecord: IwbMainRecord;
begin
  Result := '';

  var FormID := aContainer.Elements[0];
  if not wbTryGetMainRecord(FormID, MainRecord) then
    Exit;

  var Count := aContainer.Elements[1];

  Result := Count.Value + 'x ' + MainRecord.ShortName;
end;

/// <summary>Returns Object Format version of Object Union. Corresponds to index of wbStructSK in Object Union array.</summary>
/// <param name="aElement">The Object Union element</param>
/// <returns>0 = Object v2, 1 = Object v1</returns>
function wbGetScriptObjFormat(const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;

  if not Assigned(aElement) then
    Exit;

  Container := aElement.Container;
  while Assigned(Container) and (Container.ElementType <> etSubRecord) do
    Container := Container.Container;

  if Container = nil then
    Exit;

  var ObjFormat := Container.ElementNativeValues['Object Format'];

  if ObjFormat = 1 then
    Result := 1;
end;

/// <summary>Generates comma-delimited list of array values for an array-type property</summary>
/// <param name="aContainer">The Array Value element (e.g., "Value\Array of Object")</param>
/// <returns>string from TStringList.CommaText</returns>
function wbGetPropertyValueArrayItems(const aContainer: IwbContainerElementRef): string;
var
  MainRecord: IwbMainRecord;
  ItemName: string;
begin
  var Items := TStringList.Create;

  if CompareStr(aContainer.Name, 'Array of Object') = 0 then
    for var i := 0 to Pred(aContainer.ElementCount) do begin
      var ObjectUnion := aContainer.Elements[i] as IwbContainerElementRef;
      var ObjectVersion := IfThen(wbGetScriptObjFormat(ObjectUnion) = 0, 'v2', 'v1');

      var FormID := ObjectUnion.ElementByPath['Object ' + ObjectVersion + '\FormID'];
      var Alias := ObjectUnion.ElementByPath['Object ' + ObjectVersion + '\Alias'];
      var AliasValue := Alias.Value;

      if Supports(FormID.LinksTo, IwbMainRecord, MainRecord) then
        if MainRecord <> nil then
          ItemName := MainRecord.ShortName
        else
          ItemName := 'NULL';

      if not (CompareStr(AliasValue, 'None') = 0) and not (Length(AliasValue) = 0) then
        Items.Add(Alias.EditValue + IfThen(Length(ItemName) > 0, ' = ' + ItemName, ''))
      else
        if MainRecord <> nil then
          Items.Add(MainRecord.ShortName)
        else
          Items.Add('NULL');
    end
  else
    for var i := 0 to Pred(aContainer.ElementCount) do
      Items.Add(aContainer.Elements[i].Value);

  Result := Items.CommaText;
  Items.Free;
end;

function wbConditionSummaryLinksTo(const aElement: IwbElement): IwbElement;
var
  Container : IwbContainerElementRef;
  cerCTDA   : IwbContainerElementRef;
begin
  if not wbTrySetContainer(aElement, ctToSummary, Container) then
    Exit;

  if wbGameMode > gmFNV then begin
    if not Supports(Container.RecordBySignature[CTDA], IwbContainerElementRef, cerCTDA) then
      Exit;
  end else
    cerCTDA := Container;

  Result := cerCTDA.Elements[5].LinksTo;
  if Assigned(Result) then
    Exit;

  Result := cerCTDA.Elements[6].LinksTo;
  if Assigned(Result) then
    Exit;

  Result := cerCTDA.Elements[2].LinksTo;
end;

procedure wbConditionToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  cerCTDA: IwbContainerElementRef;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  if wbGameMode > gmFNV then begin
    if not Supports(Container.RecordBySignature[CTDA], IwbContainerElementRef, cerCTDA) then
      Exit;
  end else
    cerCTDA := Container;

  var Typ : Byte := cerCTDA.Elements[0].NativeValue;
  var Func := cerCTDA.Elements[3];

  if (cerCTDA.ElementCount >= 9)
  and (cerCTDA.Elements[7].Def.DefType <> dtEmpty)
  and (cerCTDA.Elements[8].Def.DefType <> dtEmpty) then begin
    var RunOn := cerCTDA.Elements[7];

    var RunOnInt: Integer := RunOn.NativeValue;

    if wbGameMode = gmFNV then begin
      var FuncInt: Integer := Func.NativeValue;
      if (FuncInt = 106) or (FuncInt = 285) then
        RunOnInt := 0;
    end;

    if RunOnInt = 2 then
      aValue := '(' + cerCTDA.Elements[8].Summary + ')'
    else
      aValue := RunOn.Summary.Replace(' ', '', [rfReplaceAll]);
  end
  else
    if (Typ and $02) = 0 then
      aValue := 'Subject'
    else
      aValue := 'Target';

  aValue := aValue + '.' + Func.Summary;

  var Param1 := cerCTDA.Elements[5];
  if Param1.ConflictPriority <> cpIgnore then begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Summary;

    var Param2 := cerCTDA.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Summary;

    aValue := aValue + ')';
  end;

  case Typ and $E0 of
    $00: aValue := aValue + ' = ';
    $20: aValue := aValue + ' <> ';
    $40: aValue := aValue + ' > ';
    $60: aValue := aValue + ' >= ';
    $80: aValue := aValue + ' < ';
    $A0: aValue := aValue + ' <= ';
  end;

  aValue := aValue + cerCTDA.Elements[2].Summary;

  var Conditions: IwbContainerElementRef;
  if Supports(Container.Container, IwbContainerElementRef, Conditions) then
  begin
    var l := Conditions.ElementCount;
    if (l < 2) or Container.Equals(Conditions.Elements[Pred(l)]) then
      Exit;
  end;

  if (Typ and $01) = 0 then
    aValue := aValue + ' AND'
  else
    aValue := aValue + ' OR';
end;

procedure wbFactionRelationToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var Faction := Container.Elements[0];
  if not Assigned(Faction.LinksTo) then
    Exit;

  var Rank := Container.Elements[1];

  aValue := Faction.Value;

  if wbGameMode = gmTES4 then begin
    var NativeRank := Rank.NativeValue;

    aValue := IntToStr(NativeRank) + ' ' + aValue;

    if NativeRank >= 0 then
      aValue := '+' + aValue;

    Exit;
  end;

  aValue := Container.Elements[2].Value + ' ' + aValue;
end;

procedure wbObjectPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  MainRecord: IwbMainRecord;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var ActorValueForm := Container.ElementByName['Actor Value'];
  if not wbTryGetMainRecord(ActorValueForm, MainRecord) then
    Exit;

  var ActorValueData := Container.ElementByName['Value'];

  aValue := MainRecord.EditorID + ' = ' + Format('%.*g', [5, StrToFloat(ActorValueData.Value)]);

  if not (wbGameMode in [gmFO76, gmSF1]) then
    Exit;

  var CurveTable := Container.ElementByName['Curve Table'] as IwbContainerElementRef;
  if not Assigned(CurveTable) then
    Exit;

  var CurveTableForm := CurveTable.ElementByName['Curve Table'];
  if not wbTryGetMainRecord(CurveTableForm, MainRecord) then
    Exit;

  aValue := aValue + ' {Curve Table: ' + MainRecord.ShortName + '}';
end;

procedure wbCrowdPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  MainRecord: IwbMainRecord;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var ActorForm := Container.ElementByName['Actor'];
  if not wbTryGetMainRecord(ActorForm, MainRecord) then
    Exit;

  var ActorValueData := Container.ElementByName['Value'];

  aValue := MainRecord.EditorID + ' = ' + Format('%.*g', [5, StrToFloat(ActorValueData.Value)]);

  if not (wbGameMode in [gmFO76, gmSF1]) then
    Exit;

  var CurveTable := Container.ElementByName['Curve Table'] as IwbContainerElementRef;
  if not Assigned(CurveTable) then
    Exit;

  var CurveTableForm := CurveTable.ElementByName['Curve Table'];
  if not wbTryGetMainRecord(CurveTableForm, MainRecord) then
    Exit;

  aValue := aValue + ' {Curve Table: ' + MainRecord.ShortName + '}';
end;


procedure wbItemToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  ItemString: string;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  // check for second struct
  if Container.Elements[0].ElementType = etSubRecord then
    Container := Container.Elements[0] as IwbContainerElementRef;

  ItemString := wbGetItemStr(Container);

  if Length(ItemString) = 0 then
    Exit;

  aValue := ItemString;
end;

/// <summary>Fills PropertyType and PropertyValue from array assigned to property</summary>
procedure wbScriptPropertyArrayToStr(const aContainer: IwbContainerElementRef; var PropertyType: string; var PropertyValue: string);
begin
  var ArrayContainer := aContainer.ElementByPath['Value\' + PropertyType] as IwbContainerElementRef;

  if not (ArrayContainer.ElementCount > 0) then
    Exit;

  PropertyValue := wbGetPropertyValueArrayItems(ArrayContainer);
  PropertyType := PropertyType.Substring(9) + '[]';
end;

/// <summary>Fills PropertyName, PropertyType, and PropertyName from object assigned to property</summary>
procedure wbScriptPropertyObjectToStr(const aContainer: IwbContainerElementRef; var PropertyName: string; var PropertyType: string; var PropertyValue: string);
var
  MainRecord: IwbMainRecord;
begin
  PropertyValue := 'NULL';

  var ObjectUnion := aContainer.ElementByPath['Value\Object Union'] as IwbContainerElementRef;

  var Version := IfThen(wbGetScriptObjFormat(ObjectUnion) = 0, 'v2', 'v1');

  var FormID := ObjectUnion.ElementByPath['Object ' + Version + '\FormID'];
  var Alias := ObjectUnion.ElementByPath['Object ' + Version + '\Alias'];

  var AliasValue := Alias.Value;

  // compare length, too, because v1 doesn't default to 'None'
  if not (CompareStr(AliasValue, 'None') = 0) and not (Length(AliasValue) = 0) then begin
    PropertyType := 'Alias';
    PropertyName := Alias.EditValue;
  end;

  if not wbTryGetMainRecord(FormID, MainRecord) then
    Exit;

  PropertyValue := MainRecord.Name;
end;

procedure wbScriptPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  PropertyValue: string;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var PropertyTypeElement := Container.ElementByName['Type'];

  // 0 = None
  if PropertyTypeElement.NativeValue = 0 then
    Exit;

  var PropertyName := Container.ElementByName['propertyName'].Value;

  if Length(PropertyName) = 0 then
    Exit;

  var PropertyType := PropertyTypeElement.Value;

  // 1 = Object
  if PropertyTypeElement.NativeValue = 1 then
    wbScriptPropertyObjectToStr(Container, PropertyName, PropertyType, PropertyValue);

  // 2-5 = String, Int32, Float, Bool
  if InRange(PropertyTypeElement.NativeValue, 2, 5) then
    PropertyValue := Container.ElementByName[PropertyType].Value;

  // 11-15 = Arrays of String, Int32, Float, Bool
  if InRange(PropertyTypeElement.NativeValue, 11, 15) then
    wbScriptPropertyArrayToStr(Container, PropertyType, PropertyValue);

  // 16 = Array of Variable (FO76, Not Implemented)
  if PropertyTypeElement.NativeValue = 16 then
    Exit;

  // 17 = Array of Struct
  if PropertyTypeElement.NativeValue = 17 then begin
    PropertyValue := '';
    PropertyType := PropertyType.Substring(9) + '[]';
  end;

  // set display string
  aValue := PropertyType + ' ' + PropertyName;

  if Length(PropertyValue) > 0 then
    aValue := aValue + ' = ' + PropertyValue;
end;

// TODO: used in too many places to replace with summary callbacks
procedure wbRGBAToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  A: IwbElement;
  R, G, B: string;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  if Container.ElementCount >= 3 then begin
    R := Container.Elements[0].Summary;
    G := Container.Elements[1].Summary;
    B := Container.Elements[2].Summary;
  end else
    Exit;

  if Container.ElementCount >= 4 then
    A := Container.Elements[3]
  else
    A := nil;

  if Assigned(A) then
    if (A.ConflictPriority <= cpIgnore) or (A.Def.DefType = dtByteArray) then
      A := nil;

  if Assigned(A) then
    aValue := 'RGBA(' + R + ', ' + G + ', ' + B + ', ' + A.Summary + ')'
  else
    aValue := 'RGB(' + R + ', ' + G + ', ' + B + ')';
end;


// TODO: used in too many places to replace with summary callbacks
procedure wbVec3ToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var X := Container.Elements[0].Summary;
  var Y := Container.Elements[1].Summary;
  var Z := Container.Elements[2].Summary;

  aValue := wbVec3Prefix + '(' + X + ', ' + Y + ', ' + Z + ')';
end;

{>>> For VMAD <<<}

function wbScriptObjFormatDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := wbGetScriptObjFormat(aElement);
end;

procedure wbScriptToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  CER: IwbContainerElementRef;
begin
  if not wbTrySetContainer(aElement, aType, CER) then
    Exit;

  var eSCDA := CER.ElementBySignature[SCDA];
  var eSCTX := CER.ElementBySignature[SCTX];

  if not Assigned(eSCDA) then begin
    aValue := IfThen(Assigned(eSCTX), '<Source not compiled>', '<Empty>');
    Exit;
  end;

  if not Assigned(eSCTX) then begin
    aValue := '<Source missing>';
    Exit;
  end;

  with TStringList.Create do
  try
    Text := eSCTX.Value;

    for var i := Pred(Count) downto 0 do begin
      var s := Strings[i].Trim;

      if s.StartsWith(';') then
        s := '';

      if s = '' then
        Delete(i);
    end;

    if Count = 0 then
      aValue := '<Source missing>'
    else
      if Count = 1 then
        aValue := Strings[0].Trim
      else
        aValue := '<'+Count.ToString+' lines>';
  finally
    Free;
  end;
end;

function wbModelInfoDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;

  if not Assigned(aElement) then
    Exit;

  var MainRecord := aElement.GetContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;

  var Version := MainRecord.Version;

  if Version >= 40 then begin
    if Assigned(aBasePtr) and Assigned(aEndPtr) and ((NativeUInt(aEndPtr)-NativeUInt(aBasePtr)) >= SizeOf(Cardinal)) and (PCardinal(aBasePtr)^ > 8 {arbitary limit of 8 supported headers for now}) then
      Exit(1); // most likely older version format in FormVersion 40+ record
    Exit(3)
  end else if Version >= 38 then begin
    if Assigned(aBasePtr) and Assigned(aEndPtr) and ((NativeUInt(aEndPtr)-NativeUInt(aBasePtr)) >= SizeOf(Cardinal)) and (PCardinal(aBasePtr)^ <= 8 {arbitary limit of 8 supported headers for now}) then
      Exit(1); // most likely newer version format in FormVersion 38-39 record
    Exit(2);
  end;
end;

function wbModelInfoTextureFileCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container: IwbContainerElementRef;
  Headers: IwbContainerElementRef;
begin
  Result := 0;

  if not Supports(GetContainerFromUnion(aElement), IwbContainerElementRef, Container) then
    Exit;

  if not Supports(Container.Container, IwbContainerElementRef, Container) then
    Exit;

  if not Supports(Container.Elements[0], IwbContainerElementRef, Headers) then
    Exit;

  if Headers.ElementCount < 1 then
    Exit;

  Result := Headers.Elements[0].NativeValue;
end;

function wbModelInfoAddonCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container : IwbContainerElementRef;
  Headers   : IwbContainerElementRef;
begin
  Result := 0;

  if not Supports(GetContainerFromUnion(aElement), IwbContainerElementRef, Container) then
    Exit;

  if not Supports(Container.Container, IwbContainerElementRef, Container) then
    Exit;

  if not Supports(Container.Elements[0], IwbContainerElementRef, Headers) then
    Exit;

  if Headers.ElementCount < 2 then
    Exit;

  Result := Headers.Elements[1].NativeValue;
end;

function wbModelInfoMaterialFileCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container : IwbContainerElementRef;
  Headers   : IwbContainerElementRef;
begin
  Result := 0;

  if not Supports(GetContainerFromUnion(aElement), IwbContainerElementRef, Container) then
    Exit;

  if not Supports(Container.Container, IwbContainerElementRef, Container) then
    Exit;

  if not Supports(Container.Elements[0], IwbContainerElementRef, Headers) then
    Exit;

  if Headers.ElementCount < 4 then
    Exit;

  Result := Headers.Elements[3].NativeValue;
end;


function wbModelInfoHeaderIsRemoveable(const aElement: IwbElement): Boolean;
begin
  Result := Assigned(aElement) and (aElement.NativeValue = 0);
end;

function wbModelInfoDontShow(const aElement: IwbElement): Boolean;
begin
  if wbGameMode < gmTES5 then
    Exit(False);

  Result := True;

  if not Assigned(aElement) then
    Exit;

  var MainRecord := aElement.GetContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;

  Result := MainRecord.Version < 38;
end;

procedure wbModelInfoGetCP(const aElement: IwbElement; var aConflictPriority: TwbConflictPriority);
begin
  aConflictPriority := cpNormal;

  if wbGameMode < gmTES5 then
    Exit;

  if not Assigned(aElement) then
    Exit;

  var MainRecord := aElement.GetContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;

  if MainRecord.Version < 38 then
    aConflictPriority := cpIgnore;
end;

procedure wbModelInfoUnknownGetCP(const aElement: IwbElement; var aConflictPriority: TwbConflictPriority);
begin
  aConflictPriority := cpNormal;
  if aElement.EditValue = '' then
    aConflictPriority := cpIgnore;
end;

procedure wbModelInfoAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container    : IwbContainerElementRef;

  Headers   : IwbContainerElementRef;
  Textures  : IwbContainerElementRef;
  Addons    : IwbContainerElementRef;
  Materials : IwbContainerElementRef;
begin
  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if Container.ElementCount < 4 then
    Exit;

  Container.BeginUpdate;
  try
    if not Supports(Container.Elements[0], IwbContainerElementRef, Headers) then
      Exit;
    if not Supports(Container.Elements[1], IwbContainerElementRef, Textures) then
      Exit;
    if not Supports(Container.Elements[2], IwbContainerElementRef, Addons) then
      Exit;
    if not Supports(Container.Elements[3], IwbContainerElementRef, Materials) then
      Exit;

    var MinHeaders := 0;
    if Materials.ElementCount > 0 then
      MinHeaders := 4
    else if Addons.ElementCount > 0 then
      MinHeaders := 2
    else if Textures.ElementCount > 0 then
      MinHeaders := 1;

    while Headers.ElementCount < MinHeaders do
      Headers.Add('');

    if Headers.ElementCount > 0 then
      if Headers.Elements[0].NativeValue <> Textures.ElementCount then
        Headers.Elements[0].NativeValue := Textures.ElementCount;
    if Headers.ElementCount > 1 then
      if Headers.Elements[1].NativeValue <> Addons.ElementCount then
        Headers.Elements[1].NativeValue := Addons.ElementCount;
    if Headers.ElementCount > 3 then
      if Headers.Elements[3].NativeValue <> Materials.ElementCount then
        Headers.Elements[3].NativeValue := Materials.ElementCount;
  finally
    Container.EndUpdate;
  end;
end;

function wbModelInfo(aSignature: TwbSignature; aName: string = ''): IwbRecordMemberDef;
begin
  if wbGameMode >= gmTES5 then begin
    if aName = '' then
      aName := 'Model Information';

    if not wbDecodeTextureHashes then
      Exit(wbByteArray(aSignature, aName, 0, cpIgnore, False, False, wbNeverShow));

    var CreateFileEntry := function(const aName: string): IwbValueDef begin
      Result := wbStruct(aName, [
        wbInteger('File Hash', itU32, wbFileHashCallback),
        wbString('Extension', 4),
        wbInteger('Folder Hash', itU32, wbFolderHashCallback)
      ])
      .SetSummaryKey([2,0,1])
      .SetSummaryDelimiter('')
      .SetSummaryMemberPrefixSuffix(0, '', '')
      .SetSummaryMemberPrefixSuffix(1, '.', '')
      .SetSummaryMemberPrefixSuffix(2, '', '\')
      .IncludeFlag(dfSummaryMembersNoName);
    end;

    var TextureFile := CreateFileEntry('Texture').IncludeFlag(dfCollapsed, wbCollapseModelInfoTexture);
    var MaterialFile := CreateFileEntry('Material').IncludeFlag(dfCollapsed, wbCollapseModelInfoMaterial);

    var NewModelInfo := wbStruct('', [
      wbArray('Headers',
        wbInteger('Header', itU32, nil, nil, cpIgnore).SetIsRemovable(wbModelInfoHeaderIsRemoveable)
      , arcU32, ['Textures Count', 'Addons Count', 'TextureSets', 'Materials Count'], cpIgnore)
        .IncludeFlag(dfNotAlignable)
        .IncludeFlag(dfRemoveLastOnly)
        .IncludeFlag(dfCollapsed, wbCollapseModelInfoHeader),

      wbArray('Textures', TextureFile, wbModelInfoTextureFileCounter)
        .SetSummaryPassthroughMaxLength(80)
        .SetSummaryPassthroughMaxDepth(1)
        .IncludeFlag(dfCollapsed, wbCollapseModelInfoTextures),

      wbArray('Addons', wbInteger('Addon', itU32), wbModelInfoAddonCounter)
        .SetSummaryPassthroughMaxLength(80)
        .SetSummaryPassthroughMaxDepth(1)
        .IncludeFlag(dfCollapsed, wbCollapseModelInfoAddons),

      wbArray('Materials', MaterialFile, wbModelInfoMaterialFileCounter)
        .SetSummaryPassthroughMaxLength(80)
        .SetSummaryPassthroughMaxDepth(1)
        .IncludeFlag(dfCollapsed, wbCollapseModelInfoMaterials),

      wbByteArray('Unknown', 0, cpNormal, False, nil, wbModelInfoUnknownGetCP)
    ])
    .SetSummaryKey([1, 2, 3])
    .IncludeFlag(dfSummaryMembersNoName)
    .SetAfterSet(wbModelInfoAfterSet);

    Result := wbUnion(aSignature, aName, wbModelInfoDecider, [
      wbStruct('', [
        wbEmpty('Unused'),
        wbByteArray('Unused'),
        wbEmpty('Unused'),
        wbEmpty('Unused')
      ], cpIgnore),
      wbStruct('', [
        wbEmpty('Unused'),
        wbByteArray('ERROR').SetToStr(procedure(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType) begin
          if aType = ctCheck then
            aValue := 'SubRecord has invalid format for the Form Version of this record';
        end),
        wbEmpty('Unused'),
        wbEmpty('Unused')
      ], cpCritical),
      wbStruct('', [
        wbEmpty('Unused'),
        wbArray('Textures', TextureFile).IncludeFlag(dfCollapsed, wbCollapseModelInfoTextures),
        wbEmpty('Unused'),
        wbEmpty('Unused')
      ]).SetSummaryKey([1]),
      NewModelInfo
    ], cpNormal, False, wbModelInfoDontShow, wbModelInfoGetCP).IncludeFlag(dfCollapsed, wbCollapseModelInfo);
  end else begin
    if aName = '' then
      aName := 'Textures';

    if not wbDecodeTextureHashes then
      Exit(wbByteArray(aSignature, aName, 0, cpIgnore, False, False, wbNeverShow));

    var TextureFile := wbStruct('Texture', [
      wbInteger('File Hash (PC)', itU64, wbFileHashCallback),
      wbInteger('File Hash (Console)', itU64, wbFileHashCallback),
      wbInteger('Folder Hash', itU64, wbFolderHashCallback)
    ])
    .SetSummaryKey([2,0])
    .SetSummaryDelimiter('')
    .SetSummaryMemberPrefixSuffix(0, '', '')
    .SetSummaryMemberPrefixSuffix(2, '', '\')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseModelInfoTexture);

    Result := wbArray(aSignature, aName, TextureFile).IncludeFlag(dfCollapsed, wbCollapseModelInfoTextures);
  end;

end;

function wbModelInfos(aSignature: TwbSignature; aName: string = ''; aDontShow  : TwbDontShowCallback = nil): IwbRecordMemberDef;
begin
  if wbGameMode >= gmTES5 then
    raise Exception.Create('Not Supported');

  if aName = '' then
    aName := 'Model List Textures';

  if not wbDecodeTextureHashes then
    Exit(wbByteArray(aSignature, aName, 0, cpIgnore, False, False, wbNeverShow));

  var TextureFile := wbStruct('Texture', [
    wbInteger('File Hash (PC)', itU64, wbFileHashCallback),
    wbInteger('File Hash (Console)', itU64, wbFileHashCallback),
    wbInteger('Folder Hash', itU64, wbFolderHashCallback)
  ])
  .SetSummaryKey([2,0])
  .SetSummaryDelimiter('')
  .SetSummaryMemberPrefixSuffix(0, '', '')
  .SetSummaryMemberPrefixSuffix(2, '', '\')
  .IncludeFlag(dfSummaryMembersNoName)
  .IncludeFlag(dfCollapsed, wbCollapseModelInfoTexture);

  Result := wbArray(aSignature, aName,
    wbStruct('Model', [
      wbArray('Textures', TextureFile, arcU8).IncludeFlag(dfCollapsed, wbCollapseModelInfoTextures)
    ]).SetSummaryKey([0])
  , arcU32, nil, nil, cpNormal, False, aDontShow).IncludeFlag(dfCollapsed, wbCollapseModelInfo);
end;

var
  _FormVersionDeciders : array of TwbUnionDecider;

function wbFormVersionDecider(aVersion: Integer): TwbUnionDecider;
begin
  if aVersion > High(_FormVersionDeciders) then
    SetLength(_FormVersionDeciders, Succ(aVersion));

  if not Assigned(_FormVersionDeciders[aVersion]) then
    _FormVersionDeciders[aVersion] :=
      function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer
      var
        MainRecord : IwbMainRecord;
      begin
        if not Assigned(aElement) then
          Exit(0);

        MainRecord := aElement.GetContainingMainRecord;
        if not Assigned(MainRecord) then
          Exit(0);

        if MainRecord.Version >= aVersion then
          Exit(1);

        Exit(0);
      end;

  Result := _FormVersionDeciders[aVersion];
end;

function wbFormVersionDecider(aMinVersion, aMaxVersion: Integer): TwbUnionDecider; overload;
begin
  Result :=
    function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer
    var
      MainRecord : IwbMainRecord;
    begin
      if not Assigned(aElement) then
        Exit(0);

      MainRecord := aElement.GetContainingMainRecord;
      if not Assigned(MainRecord) then
        Exit(0);

      if not ((MainRecord.Version < aMinVersion) or (MainRecord.Version > aMaxVersion)) then
        Exit(1);

      Exit(0);
    end;
end;

function wbFormVersionDecider(const aVersions: array of Integer): TwbUnionDecider; overload;
var
  Versions : TArray<Integer>;
begin
  SetLength(Versions, Length(aVersions));
  for var i := Low(aVersions) to High(aVersions) do
    Versions[i] := aVersions[i];

  Result :=
    function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer
    var
      MainRecord : IwbMainRecord;
    begin
      if not Assigned(aElement) then
        Exit(0);

      MainRecord := aElement.GetContainingMainRecord;
      if not Assigned(MainRecord) then
        Exit(0);

      var FormVersion := MainRecord.Version;

      for var i := Low(Versions) to High(Versions) do
        if FormVersion < Versions[i] then
          Exit(i);

      Exit(Length(Versions));
    end;
end;

function wbFromVersion(aVersion: Integer; const aSignature: TwbSignature; const aValue: IwbValueDef): IwbRecordMemberDef; overload;
begin
  Result :=
    wbUnion(aSignature, aValue.Name, wbFormVersionDecider(aVersion), [
      wbUnused,
      aValue
    ]).IncludeFlagOnValue(dfUnionStaticResolve);
end;

function wbFromVersion(aVersion: Integer; const aValue: IwbValueDef): IwbValueDef;
begin
  Result :=
    wbUnion(aValue.Name, wbFormVersionDecider(aVersion), [
      wbUnused(),
      aValue
    ]).IncludeFlag(dfUnionStaticResolve);
end;

function wbBelowVersion(aVersion: Integer; const aSignature: TwbSignature; const aValue: IwbValueDef): IwbRecordMemberDef; overload;
begin
  Result :=
    wbUnion(aSignature, aValue.Name, wbFormVersionDecider(aVersion), [
      aValue,
      wbUnused()
    ]).IncludeFlagOnValue(dfUnionStaticResolve);
end;

function wbBelowVersion(aVersion: Integer; const aValue: IwbValueDef): IwbValueDef;
begin
  Result :=
    wbUnion(aValue.Name, wbFormVersionDecider(aVersion), [
      aValue,
      wbUnused()
    ]).IncludeFlag(dfUnionStaticResolve);
end;

var
  _RecordSizeDeciders : array of TwbUnionDecider;

function wbRecordSizeDecider(aSize: Integer): TwbUnionDecider;
begin
  if aSize > High(_RecordSizeDeciders) then
    SetLength(_RecordSizeDeciders, Succ(aSize));

  if not Assigned(_RecordSizeDeciders[aSize]) then
    _RecordSizeDeciders[aSize] :=
      function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer
      var
        SubRecord : IwbSubRecord;
      begin
        if not Assigned(aElement) then
          Exit(0);

        if not Supports(aElement, IwbSubRecord, SubRecord) then
          Exit(0);

        if not Assigned(SubRecord.DataBasePtr) or (SubRecord.DataSize >= aSize) then
          Exit(1);

        Exit(0);
      end;

  Result := _RecordSizeDeciders[aSize];
end;

var
  _FlagDeciders : array of TwbUnionDecider;

function wbFlagDecider(aFlag: Byte): TwbUnionDecider;
begin
  if aFlag > High(_FlagDeciders) then
    SetLength(_FlagDeciders, Succ(aFlag));

  if not Assigned(_FlagDeciders[aFlag]) then
    _FlagDeciders[aFlag] :=
      function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer
      var
        lContainer: IwbContainerElementRef;
      begin
        if not wbTryGetContainerRefFromUnionOrValue(aElement, lContainer) then
          Exit(0);

        var lFlags := lContainer.ElementByPath['Flags'];
        if not Assigned(lFlags) then
          Exit(0);

        var lFlagBits: Int64 := lFlags.NativeValue;
        if (lFlagBits and (1 shl aFlag)) <> 0 then
          Exit(1);

        Exit(0);
      end;

  Result := _FlagDeciders[aFlag];
end;

function wbNoFlagsDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  lContainer: IwbContainerElementRef;
begin
  if not wbTryGetContainerRefFromUnionOrValue(aElement, lContainer) then
    Exit(0);

  var lFlags := lContainer.ElementByPath['Flags'];
  if not Assigned(lFlags) then
    Exit(0);

  var lFlagBits: Integer := lFlags.NativeValue;
  if lFlagBits = 0 then
    Exit(1);

  Exit(0);
end;

function wbRecordSizeDecider(aMinSize, aMaxSize: Integer): TwbUnionDecider; overload;
begin
  Result :=
    function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer
    var
      SubRecord : IwbSubRecord;
    begin
      if not Assigned(aElement) then
        Exit(0);

      if not Supports(aElement, IwbSubRecord, SubRecord) then
        Exit(0);

      if (SubRecord.DataSize > aMaxSize) or (SubRecord.DataSize < aMinSize) then
        Exit(1);

      Exit(0);
    end;
end;

function wbRecordSizeDecider(const aSizes: array of Integer): TwbUnionDecider; overload;
var
  Sizes : TArray<Integer>;
begin
  SetLength(Sizes, Length(aSizes));
  for var i := Low(aSizes) to High(aSizes) do
    Sizes[i] := aSizes[i];

  Result :=
    function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer
    var
      SubRecord : IwbSubRecord;
    begin
      if not Assigned(aElement) then
        Exit(0);

      if not Supports(aElement, IwbSubRecord, SubRecord) then
        Exit(0);

      var DataSize := SubRecord.DataSize;

      for var i := Low(Sizes) to High(Sizes) do
        if DataSize < Sizes[i] then
          Exit(i);

      Exit(Length(Sizes));
    end;
end;

function wbFromSize(aSize: Integer; const aSignature: TwbSignature; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbRecordMemberDef; overload;
begin
  if aIsUnused then begin
    Result :=
      wbUnion(aSignature, aValue.Name, wbRecordSizeDecider(aSize), [
        wbUnused(),
        aValue
      ]).IncludeFlagOnValue(dfUnionStaticResolve);
  end else begin
      Result :=
      wbUnion(aSignature, aValue.Name, wbRecordSizeDecider(aSize), [
        wbEmpty(aValue.Name),
        aValue
      ]).IncludeFlagOnValue(dfUnionStaticResolve);
  end;
end;



function wbFromSize(aSize: Integer; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbValueDef;
begin
  if aIsUnused then
    Result :=
      wbUnion(aValue.Name, wbRecordSizeDecider(aSize), [
        wbUnused(),
        aValue
      ]).IncludeFlag(dfUnionStaticResolve)
  else
      Result :=
      wbUnion(aValue.Name, wbRecordSizeDecider(aSize), [
        wbEmpty(aValue.Name),
        aValue
      ]).IncludeFlag(dfUnionStaticResolve);
end;

function wbBelowSize(aSize: Integer; const aSignature: TwbSignature; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbRecordMemberDef; overload;
begin
  if aIsUnused then
    Result :=
      wbUnion(aSignature, aValue.Name, wbRecordSizeDecider(aSize), [
        aValue,
        wbUnused()
      ]).IncludeFlagOnValue(dfUnionStaticResolve)
  else
      Result :=
      wbUnion(aSignature, aValue.Name, wbRecordSizeDecider(aSize), [
        aValue,
        wbEmpty(aValue.Name)
      ]).IncludeFlagOnValue(dfUnionStaticResolve);

end;

function wbBelowSize(aSize: Integer; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbValueDef;
begin
  if aIsUnused then
    Result :=
      wbUnion(aValue.Name, wbRecordSizeDecider(aSize), [
        aValue,
        wbUnused()
      ]).IncludeFlag(dfUnionStaticResolve)
  else
      Result :=
      wbUnion(aValue.Name, wbRecordSizeDecider(aSize), [
        aValue,
        wbEmpty(aValue.Name)
      ]).IncludeFlag(dfUnionStaticResolve);
end;

function wbIsFlag(aFlag: Integer; const aSignature: TwbSignature; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbRecordMemberDef; overload;
begin
  if aIsUnused then
    Result :=
      wbUnion(aSignature, aValue.Name, wbFlagDecider(aFlag), [
        aValue,
        wbUnused()
      ]).IncludeFlagOnValue(dfMustBeUnion)
  else
      Result :=
      wbUnion(aSignature, aValue.Name, wbFlagDecider(aFlag), [
        aValue,
        wbEmpty(aValue.Name)
      ]).IncludeFlagOnValue(dfMustBeUnion);
end;

function wbIsFlag(aFlag: Integer; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbValueDef;
begin
  if aIsUnused then
    Result :=
      wbUnion(aValue.Name, wbFlagDecider(aFlag), [
        wbUnused(),
        aValue
      ]).IncludeFlag(dfMustBeUnion)
  else
      Result :=
      wbUnion(aValue.Name, wbFlagDecider(aFlag), [
        wbEmpty(aValue.Name),
        aValue
      ]).IncludeFlag(dfMustBeUnion);
end;

function wbIsNotFlag(aFlag: Integer; const aSignature: TwbSignature; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbRecordMemberDef; overload;
begin
  if aIsUnused then
    Result :=
      wbUnion(aSignature, aValue.Name, wbFlagDecider(aFlag), [
        wbUnused(),
        aValue
      ]).IncludeFlagOnValue(dfMustBeUnion)
  else
      Result :=
      wbUnion(aSignature, aValue.Name, wbFlagDecider(aFlag), [
        wbEmpty(aValue.Name),
        aValue
      ]).IncludeFlagOnValue(dfMustBeUnion);
end;

function wbIsNotFlag(aFlag: Integer; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbValueDef;
begin
  if aIsUnused then
    Result :=
      wbUnion(aValue.Name, wbFlagDecider(aFlag), [
        aValue,
        wbUnused()
      ]).IncludeFlag(dfMustBeUnion)
  else
      Result :=
      wbUnion(aValue.Name, wbFlagDecider(aFlag), [
        aValue,
        wbEmpty(aValue.Name)
      ]).IncludeFlag(dfMustBeUnion);
end;


function wbHasNoFlags(const aSignature: TwbSignature; const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbRecordMemberDef; overload;
begin
  if aIsUnused then
    Result :=
      wbUnion(aSignature, aValue.Name, wbNoFlagsDecider, [
        aValue,
        wbUnused()
      ]).IncludeFlagOnValue(dfMustBeUnion)
  else
      Result :=
      wbUnion(aSignature, aValue.Name, wbNoFlagsDecider, [
        aValue,
        wbEmpty(aValue.Name)
      ]).IncludeFlagOnValue(dfMustBeUnion);
end;

function wbHasNoFlags(const aValue: IwbValueDef; aIsUnused: Boolean = True): IwbValueDef;
begin
  if aIsUnused then
    Result :=
      wbUnion(aValue.Name, wbNoFlagsDecider, [
        wbUnused(),
        aValue
      ]).IncludeFlag(dfMustBeUnion)
  else
      Result :=
      wbUnion(aValue.Name, wbNoFlagsDecider, [
        wbEmpty(aValue.Name),
        aValue
      ]).IncludeFlag(dfMustBeUnion);
end;

procedure wbUpdateSameParentUnions(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  lContainer: IwbContainerElementRef;
begin
  if not Assigned(aElement) or not Supports(aElement.Container, IwbContainerElementRef, lContainer) then
    Exit;
  for var lElementIdx := 0 to Pred(lContainer.ElementCount) do
    //will trigger Unions to re-evaluate their type and fix themselves
    var lResolvedDef := lContainer.Elements[lElementIdx].ResolvedValueDef;
end;

function wbByteColors(const aName: string = 'Color'): IwbValueDef;
begin
  Result := wbStruct(aName, [
    wbInteger('Red', itU8),
    wbInteger('Green', itU8),
    wbInteger('Blue', itU8),
    wbByteArray('Unused', 1)
  ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA);
end;

function wbByteColors(const aSignature: TwbSignature; const aName: string = 'Color'): IwbRecordMemberDef; overload;
begin
  Result := wbStruct(aSignature, aName, [
    wbInteger('Red', itU8),
    wbInteger('Green', itU8),
    wbInteger('Blue', itU8),
    wbByteArray('Unused', 1)
  ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA);
end;


function wbFloatColors(const aName: string = 'Color'): IwbValueDef;
begin
  Result := wbStruct(aName, [
    wbFloat('Red', cpNormal, True, 255, 0),
    wbFloat('Green', cpNormal, True, 255, 0),
    wbFloat('Blue', cpNormal, True, 255, 0)
  ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA);
end;

function wbFloatColors(const aSignature: TwbSignature; const aName: string = 'Color'): IwbRecordMemberDef; overload;
begin
  Result := wbStruct(aSignature, aName, [
    wbFloat('Red', cpNormal, True, 255, 0),
    wbFloat('Green', cpNormal, True, 255, 0),
    wbFloat('Blue', cpNormal, True, 255, 0)
  ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA);
end;

function wbRFloatColors(const aName: string = 'Color'; const aSigs: TwbSignatures = []): IwbRecordMemberDef;
begin
  Assert(Length(aSigs) = 3, 'wbRFloatColors called with incorrect number of signatures.');

  Result := wbRStruct(aName, [
    wbFloat(aSigs[0], 'Red', cpNormal, False, 255, 0).SetRequired(True),
    wbFloat(aSigs[1], 'Green', cpNormal, False, 255, 0).SetRequired(True),
    wbFloat(aSigs[2], 'Blue', cpNormal, False, 255, 0).SetRequired(True)
  ], []).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA);
end;

function wbFloatRGBA(const aName: string = 'Color'): IwbValueDef;
begin
  Result := wbStruct(aName, [
    wbFloat('Red', cpNormal, True, 255, 0),
    wbFloat('Green', cpNormal, True, 255, 0),
    wbFloat('Blue', cpNormal, True, 255, 0),
    wbFloat('Alpha', cpNormal, True, 255, 0)
  ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA);
end;

function wbFloatRGBA(const aSignature: TwbSignature; const aName: string = 'Color'): IwbRecordMemberDef; overload;
begin
  Result := wbStruct(aSignature, aName, [
    wbFloat('Red', cpNormal, True, 255, 0),
    wbFloat('Green', cpNormal, True, 255, 0),
    wbFloat('Blue', cpNormal, True, 255, 0),
    wbFloat('Alpha', cpNormal, True, 255, 0)
  ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA);
end;

function wbByteRGBA(const aName: string = 'Color'): IwbValueDef; overload;
begin
  Result := wbStruct(aName, [
    wbInteger('Red', itU8),
    wbInteger('Green', itU8),
    wbInteger('Blue', itU8),
    wbInteger('Alpha', itU8)
  ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA);
end;

function wbByteRGBA(const aSignature: TwbSignature; const aName: string = 'Color'): IwbRecordMemberDef; overload;
begin
  Result := wbStruct(aSignature, aName, [
    wbInteger('Red', itU8),
    wbInteger('Green', itU8),
    wbInteger('Blue', itU8),
    wbInteger('Alpha', itU8)
  ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA);
end;

function wbVec3(const aName: string; const aPrefix: string): IwbValueDef; overload;
begin
  Result :=
    wbStruct(aName, [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ])
    .SetSummaryKey([0, 1, 2])
    .SetSummaryMemberPrefixSuffix(0, aPrefix + '(', '')
    .SetSummaryMemberPrefixSuffix(2, '', ')')
    .SetSummaryDelimiter(', ')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseVec3);
end;

function wbVec3(const aSignature: TwbSignature; const aName: string; const aPrefix: string): IwbRecordMemberDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbVec3(aName, aPrefix));
end;

function wbVec3Pos(const aName: string; const aPrefix: string): IwbValueDef; overload;
begin
  Result := wbVec3(aName, aPrefix);
end;

function wbVec3Pos(const aSignature: TwbSignature; const aName: string; const aPrefix: string): IwbRecordMemberDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbVec3Pos(''));
end;

function wbVec3Rot(const aName: string; const aPrefix: string): IwbValueDef; overload;
begin
  Result :=
    wbStruct(aName, [
      wbFloatAngle('X', cpNormal, True),
      wbFloatAngle('Y', cpNormal, True),
      wbFloatAngle('Z', cpNormal, True)
    ])
    .SetSummaryKey([0, 1, 2])
    .SetSummaryMemberPrefixSuffix(0, aPrefix + '(', '')
    .SetSummaryMemberPrefixSuffix(2, '', ')')
    .SetSummaryDelimiter(', ')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseVec3);
end;

function wbVec3Rot(const aSignature: TwbSignature; const aName: string; const aPrefix: string): IwbRecordMemberDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbVec3Rot(''));
end;

function wbVec3PosRot(const aCombinedName: string; const aPosName: string; const aRotName: string; const aPosPrefix: string; const aRotPrefix: string): IwbValueDef; overload;
begin
  Result :=
    wbStruct(aCombinedName, [
      wbVec3Pos(aPosName, aPosPrefix),
      wbVec3Rot(aRotName, aRotPrefix)
    ])
    .SetSummaryKey([0, 1])
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapsePosRot);
end;

function wbVec3PosRot(const aSignature: TwbSignature; const aCombinedName: string; aPosName: string; const aRotName: string; const aPosPrefix: string; const aRotPrefix: string): IwbRecordMemberDef; overload;
begin
  Result := wbSubRecord(aSignature, aCombinedName, wbVec3PosRot('', aPosName, aRotName, aPosPrefix, aRotPrefix));
end;

function wbVec3PosRotDegrees(const aCombinedName: string; const aPosName: string; const aRotName: string; const aPosPrefix: string; const aRotPrefix: string): IwbValueDef; overload;
begin
  Result :=
    wbStruct(aCombinedName, [
      wbVec3Pos(aPosName, aPosPrefix),
      wbVec3(aRotName, aRotPrefix)
    ])
    .SetSummaryKey([0, 1])
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapsePosRot);
end;

function wbVec3PosRotDegrees(const aSignature: TwbSignature; const aCombinedName: string; aPosName: string; const aRotName: string; const aPosPrefix: string; const aRotPrefix: string): IwbRecordMemberDef; overload;
begin
  Result := wbSubRecord(aSignature, aCombinedName, wbVec3PosRotDegrees('', aPosName, aRotName, aPosPrefix, aRotPrefix));
end;


function wbCombineVarRecs(const a, b : array of const)
                                     : TwbVarRecs;
begin
  SetLength(Result, Length(a) + Length(b));
  if Length(a) > 0 then
    Move(a[0], Result[0], SizeOf(TVarRec) * Length(a));
  if Length(b) > 0 then
    Move(b[0], Result[Length(a)], SizeOf(TVarRec) * Length(b));
end;

function wbMakeVarRecs(const a : array of const)
                               : TwbVarRecs;
begin
  SetLength(Result, Length(a));
  if Length(a) > 0 then
    Move(a[0], Result[0], SizeOf(TVarRec) * Length(a));
end;

procedure wbToStringFromLinksToSummary(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
begin
  case aType of
    ctToStr:
    begin
      if Assigned(aElement) then begin
        var lLinksTo := aElement.LinksTo;
        if Assigned(lLinksTo) then begin
          var lSummary := lLinksTo.Summary;
          if lSummary <> '' then begin
            aValue := lSummary;
            var lMainRecord: IwbMainRecord;
            if not Supports(lLinksTo, IwbMainRecord) and
                   wbTryGetContainingMainRecord(lLinksTo, lMainRecord)
            then begin
              var lRecordName := lMainRecord.Name;
              if lRecordName <> '' then
                aValue := aValue + ' on ' + lRecordName;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure wbToStringFromLinksToMainRecordName(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
begin
  case aType of
    ctToStr:
    begin
      if aValue = '' then
        Exit;

      aValue := '[' + aValue + ']';

      if not Assigned(aElement) then
        Exit;

      var lLinksTo := aElement.LinksTo;
      if not Assigned(lLinksTo) then
        Exit;

      var lMainRecord: IwbMainRecord;
      if not Supports(lLinksTo, IwbMainRecord, lMainRecord) then
        Exit;

      var lRecordName := lMainRecord.Name;
      if lRecordName <> '' then
        aValue := aValue + ' ' + lRecordName;
    end;
  end;
end;


end.

