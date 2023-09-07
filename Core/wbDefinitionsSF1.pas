{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbDefinitionsSF1;

{$I wbDefines.inc}

interface

uses
  wbInterface;

var
  wbBipedObjectFlags: IwbFlagsDef;
  wbEquipType: IwbFlagsDef;
  wbFurnitureEntryTypeFlags: IwbFlagsDef;
  wbPKDTFlags: IwbFlagsDef;
  wbPKDTInterruptFlags: IwbFlagsDef;
  wbSMNodeFlags: IwbFlagsDef;
  wbXALGFlags: IwbFlagsDef;

  wbCRCValuesEnum: IwbEnumDef;
  wbActorPropertyEnum: IwbEnumDef;
  wbAdvanceActionEnum: IwbEnumDef;
  wbStaggerEnum: IwbEnumDef;
  wbAlignmentEnum: IwbEnumDef;
  wbArmorPropertyEnum: IwbEnumDef;
  wbBipedObjectEnum: IwbEnumDef;
  wbBlendModeEnum: IwbEnumDef;
  wbBlendOpEnum: IwbEnumDef;
  wbCastEnum: IwbEnumDef;
  wbCastingSourceEnum: IwbEnumDef;
  wbCrimeTypeEnum: IwbEnumDef;
  wbCriticalStageEnum: IwbEnumDef;
  wbEmotionTypeEnum: IwbEnumDef;
  wbEntryPointsEnum: IwbEnumDef;
  wbEventFunctionEnum: IwbEnumDef;
  wbEventMemberEnum: IwbEnumDef;
  wbFormTypeEnum: IwbEnumDef;
  wbFurnitureAnimTypeEnum: IwbEnumDef;
  wbLocationEnum: IwbEnumDef;
  wbMiscStatEnum: IwbEnumDef;
  wbMusicEnum: IwbEnumDef;
  wbObjectModProperties: IwbArrayDef;
  wbObjectTypeEnum: IwbEnumDef;
  wbPropTypeEnum: IwbEnumDef;
  wbSkillEnum: IwbEnumDef;
  wbSoundLevelEnum: IwbEnumDef;
  wbTargetEnum: IwbEnumDef;
  wbVatsValueFunctionEnum: IwbEnumDef;
  wbWardStateEnum: IwbEnumDef;
  wbWeaponAnimTypeEnum: IwbEnumDef;
  wbWeaponPropertyEnum: IwbEnumDef;
  wbZTestFuncEnum: IwbEnumDef;
  wbKeywordTypeEnum: IwbEnumDef;
  wbReverbClassEnum: IwbEnumDef;
  wbHitBehaviourEnum: IwbEnumDef;
  wbLGDIStarSlot: IwbEnumDef;

procedure DefineSF1;

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
    'WATR', 'WEAP', 'ENCH', 'SECH', 'LGDI', 'IRES'
  ];

var
  wbPKDTSpecificFlagsUnused : Boolean;
  wbEDID: IwbSubRecordDef;
  wbCOED: IwbSubRecordDef;
  wbXLCM: IwbSubRecordDef;
  wbEITM: IwbSubRecordDef;
  wbDEST: IwbSubRecordStructDef;
  wbDESTActor: IwbSubRecordStructDef;
  wbDODT: IwbSubRecordDef;
  wbXRGD: IwbSubRecordDef;
  wbXRGB: IwbSubRecordDef;
  wbSPLO: IwbSubRecordDef;
  wbSPLOs: IwbSubRecordArrayDef;
  wbCNTO: IwbRecordMemberDef;
  wbCNTOs: IwbSubRecordArrayDef;
  wbAIDT: IwbSubRecordDef;
  wbFULL: IwbSubRecordDef;
  wbSNTP: IwbSubRecordDef;
  wbSNBH: IwbSubRecordDef;
  wbODTY: IwbSubRecordDef;
  wbOPDS: IwbSubRecordDef;
  wbDEFL: IwbSubRecordDef;
  wbBaseFormComponents: IwbSubRecordArrayDef;
  wbPTT2: IwbSubRecordDef;
  wbFULLActor: IwbSubRecordDef;
  wbFULLReq: IwbSubRecordDef;
  wbDESC: IwbSubRecordDef;
  wbDESCReq: IwbSubRecordDef;
  wbXSCL: IwbSubRecordDef;
  wbMODC: IwbSubRecordDef;
  wbModelFlags: IwbFlagsDef;
  wbMODF: IwbSubRecordDef;
  wbMODS: IwbSubRecordDef;
  wbMO2S: IwbSubRecordDef;
  wbMO3S: IwbSubRecordDef;
  wbMO4S: IwbSubRecordDef;
  wbMO2F: IwbSubRecordDef;
  wbMO3F: IwbSubRecordDef;
  wbMO4F: IwbSubRecordDef;
  wbMO5F: IwbSubRecordDef;
  wbMO6F: IwbSubRecordDef;
  wbMO7F: IwbSubRecordDef;
  wbMO2C: IwbSubRecordDef;
  wbMO3C: IwbSubRecordDef;
  wbMO4C: IwbSubRecordDef;
  wbMO5C: IwbSubRecordDef;
  wbComponent: IwbValueDef;
  wbComponents: IwbSubRecordDef;
  wbCTDA: IwbRecordMemberDef;
  wbCTDAs: IwbSubRecordArrayDef;
  wbCTDAsReq: IwbSubRecordArrayDef;
  wbCTDAsCount: IwbSubRecordArrayDef;
  wbXESP: IwbSubRecordDef;
  wbICON: IwbSubRecordDef;
  wbMICO: IwbSubRecordDef;
  wbActorValue: IwbIntegerDef;
  wbETYP: IwbSubRecordDef;
  wbETYPReq: IwbSubRecordDef;
  wbEFID: IwbSubRecordDef;
  wbEFIT: IwbSubRecordDef;
  wbEffectsReq: IwbSubRecordArrayDef;
  wbFirstPersonFlagsU32: IwbIntegerDef;
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
  wbKSIZ: IwbSubRecordDef;
  wbKWDAs: IwbSubRecordDef;
  wbReqKWDAs: IwbSubRecordDef;
  wbKeywords: IwbSubRecordStructDef;
  wbCVPA: IwbSubRecordDef;
  wbContainerItems: IwbSubRecordStructDef;
  wbWED01: IwbSubRecordStructDef;
  wbPUSHPDSH: IwbSubRecordStructDef;
  wbCITC: IwbSubRecordDef;
  wbCITCReq: IwbSubRecordDef;
  wbMGEFData: IwbSubRecordStructDef;
  wbMGEFType: IwbIntegerDef;
  wbSPIT: IwbSubRecordDef;
  wbDMDC: IwbSubRecordDef;
  wbDMDS: IwbSubRecordDef;
  wbMO5S: IwbSubRecordDef;
  wbSPCT: IwbSubRecordDef;
  wbXOWN: IwbSubRecordDef;
  wbXRNK: IwbSubRecordDef;
  wbPhonemeTargets: IwbSubRecordDef;
  wbPHWT: IwbSubRecordStructDef;
  wbQUSTAliasFlags: IwbSubRecordDef;
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
  wbMNAMFurnitureMarker: IwbSubRecordDef;
  wbSNAMMarkerParams: IwbSubRecordDef;
  wbOBTSReq: IwbSubRecordDef;
  //wbTintTemplateGroups: IwbSubrecordArrayDef;
  //wbMorphGroups: IwbSubrecordArrayDef;
  //wbRaceFRMI: IwbSubrecordArrayDef;
  wbRaceRBPC: IwbSubRecordDef;
  wbNVNM: IwbSubRecordDef;
  wbNavmeshVertices: IwbArrayDef;
  wbNavmeshTriangles: IwbArrayDef;
  wbNavmeshEdgeLinks: IwbArrayDef;
  wbNavmeshDoorTypeEnum: IwbEnumDef;
  wbNavmeshDoorTriangles: IwbArrayDef;
  wbNavmeshCoverArray: IwbArrayDef;
  wbNavmeshCoverTriangleMap: IwbArrayDef;
  wbNavmeshWaypoints: IwbArrayDef;
  wbNavmeshGrid: IwbStructDef;
  wbMNAMNAVM: IwbSubRecordDef;
  wbMaxHeightDataCELL: IwbSubRecordDef;
  wbMaxHeightDataWRLD: IwbSubRecordDef;
  wbXALG: IwbRecordMemberDef;

function wbOBND(aRequired: Boolean = False): IwbRecordMemberDef;
begin
  Result :=
    wbStruct(OBND, 'Object Bounds', [
      wbFloat('X1'),
      wbFloat('Y1'),
      wbFloat('Z1'),
      wbFloat('X2'),
      wbFloat('Y2'),
      wbFloat('Z2')
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

function wbMOLM(const aSignature: TwbSignature): IwbSubRecordDef;
begin
  Result :=
    wbArrayS(aSignature, 'Material Swaps', wbFormIDCk('Layered Material Swap', [LMSW]), -2);
end;

function wbGenericModel(aRequired: Boolean = False; aDontShow: TwbDontShowCallback = nil): IwbRecordMemberDef;
begin
  {subrecords checked against Starfield.esm}
  Result :=
    wbRStructSK([0], 'Model', [
      wbString(MODL, 'Model FileName'),
      wbMODT, // can still be read, might not be properly supported anymore, doesn't occur in Starfield.esm
      wbMOLM(MOLM),
      wbUnknown(FLLD),
      wbUnknown(XFLG),
      wbMODC, // can still be read, might not be properly supported anymore, doesn't occur in Starfield.esm
      wbMODS, // can still be read, might not be properly supported anymore, doesn't occur in Starfield.esm
      wbMODF  // can still be read, might not be properly supported anymore, doesn't occur in Starfield.esm
    ], [], cpNormal, aRequired, aDontShow)
    .SetSummaryKey([0])
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfSummaryNoSortKey)
    .IncludeFlag(dfCollapsed, wbCollapseModels)
    .IncludeFlag(dfAllowAnyMember);
end;

function wbTexturedModel(aSubRecordName: string; const aSignatures: TwbSignatures; const aTextureSubRecords: array of IwbRecordMemberDef): IwbRecordMemberDef;
var
  Members: array of IwbRecordMemberDef;
begin
  SetLength(Members, Length(aTextureSubRecords) + 2);
  Members[0] := wbString(aSignatures[0], 'Model FileName');
  Members[1] := wbModelInfo(aSignatures[1]);
  for var i := Low(aTextureSubRecords) to High(aTextureSubRecords) do
    Members[2 + i] := aTextureSubRecords[i];

  Result :=
    wbRStruct(aSubRecordName, Members, [])
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
    ctEditInfo: Result := wbActorValueEnum.EditInfo[aInt, aElement].ToCommaText;
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

function wbCTDAParam2QuestStageToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
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
        Result := Result + ' <Warning: Could not resolve Parameter 1>';
    end;
    ctToEditValue: Result := aInt.ToString;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '<Warning: Could not resolve Parameter 1>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not wbTryGetContainerRefFromUnionOrValue(aElement, Container) then
    Exit;

  Param1 := Container.ElementByName['Parameter #1'];
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
          Result := Result + ' <Warning: Quest Stage not found in "' + MainRecord.Name + '">';
      end;
      ctCheck: Result := '<Warning: Quest Stage not found in "' + MainRecord.Name + '">';
      ctEditInfo: begin
        EditInfos.Sort;
        Result := EditInfos.CommaText;
      end;
    end;
  finally
    FreeAndNil(EditInfos);
  end;
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
          Result := Result + ' <Warning: Quest Stage not found in "' + MainRecord.Name + '">';
      end;
      ctCheck: Result := '<Warning: Quest Stage not found in "' + MainRecord.Name + '">';
      ctEditInfo: begin
        EditInfos.Sort;
        Result := EditInfos.CommaText;
      end;
    end;
  finally
    FreeAndNil(EditInfos);
  end;
end;

function wbQuestStageToInt(const aString: string; const aElement: IwbElement): Int64;
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

function wbCTDAParamQuestOverlay(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): Int64;

  procedure ResolveOverlay;
  var
    MainRecord : IwbMainRecord;
    GroupRecord: IwbGroupRecord;
    Element    : IwbElement;
  begin
    if not Assigned(aElement) then
      Exit;
    MainRecord := aElement.ContainingMainRecord;
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

begin
  Result := aInt;
  if (aInt = 0) and (aType in [ctCheck, ctToStr, ctToSummary, ctToSortKey, ctLinksTo]) then
    ResolveOverlay;
end;

function wbREFRNavmeshTriangleToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
  Navmesh    : IwbElement;
  MainRecord : IwbMainRecord;
  Triangles  : IwbContainerElementRef;
begin
  case aType of
    ctToStr, ctToSummary: Result := aInt.ToString;
    ctToEditValue: Result := aInt.ToString;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: Result := '';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not wbTryGetContainerRefFromUnionOrValue(aElement, Container) then
    Exit;

  Navmesh := Container.Elements[0];
  if not wbTryGetMainRecord(Navmesh, MainRecord) then
    Exit;

  MainRecord := MainRecord.WinningOverride;

  if MainRecord.Signature <> NAVM then begin
    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: "'+MainRecord.ShortName+'" is not a Navmesh record>';
      end;
      ctCheck: Result := '<Warning: "'+MainRecord.ShortName+'" is not a Navmesh record>';
    end;
    Exit;
  end;

  if Supports(MainRecord.ElementByPath['NVNM\Triangles'], IwbContainerElementRef, Triangles) and (aType = ctCheck) then
    if aInt >= Triangles.ElementCount then
      Result := '<Warning: Navmesh triangle not found in "' + MainRecord.Name + '">';
end;

function wbStringToInt(const aString: string; const aElement: IwbElement): Int64;
begin
  Result := StrToIntDef(aString, 0);
end;

function wbEdgeToStr(aEdge: Integer; aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Triangle   : IwbContainerElementRef;
  Flags      : Int64;
  MainRecord : IwbMainRecord;
  EdgeLinks  : IwbContainerElementRef;
  EdgeLink   : IwbContainerElementRef;
  FormID     : TwbFormID;
begin
  case aType of
    ctToStr, ctToSummary: begin
      if aInt < 0 then
        Exit('None');

      Result := aInt.ToString;

      if not Assigned(aElement) then
        Exit;

      Triangle := aElement.Container as IwbContainerElementRef;
      if not Assigned(Triangle) then
        Exit;

      MainRecord := aElement.ContainingMainRecord;
      if not Assigned(MainRecord) then
        Exit;

      Flags := Triangle.ElementNativeValues['Flags'];
      if Flags and (1 shl aEdge) <> 0 then begin
        if not Supports(MainRecord.ElementByPath['NVNM\Edge Links'], IwbContainerElementRef, EdgeLinks) then
          Exit;

        if aInt >= EdgeLinks.ElementCount then
          Exit;

        if aInt < 0 then
          Exit;

        EdgeLink := EdgeLinks.Elements[aInt] as IwbContainerElementRef;

        MainRecord := nil;
        if not Supports(EdgeLink.ElementLinksTo['Mesh'], IwbMainRecord, MainRecord) then
          Exit;

        aInt := EdgeLink.ElementNativeValues['Triangle'];

        Result := Result + ' (#' + aInt.ToString + ' in ' + MainRecord.Name + ')';
      end;
    end;
    ctToSortKey: begin
      Result := '00000000' + IntToHex(aInt, 4);
      if not Assigned(aElement) then
        Exit;

      Triangle := aElement.Container as IwbContainerElementRef;
      if not Assigned(Triangle) then
        Exit;

      MainRecord := aElement.ContainingMainRecord;
      if not Assigned(MainRecord) then
        Exit;

      FormID := MainRecord.LoadOrderFormID;

      Flags := Triangle.ElementNativeValues['Flags'];
      if Flags and (1 shl aEdge) <> 0 then begin
        if not Supports(MainRecord.ElementByPath['NVNM\Edge Links'], IwbContainerElementRef, EdgeLinks) then
          Exit;
        if aInt >= EdgeLinks.ElementCount then
          Exit;
        if aInt < 0 then
          Exit;
        EdgeLink := EdgeLinks.Elements[aInt] as IwbContainerElementRef;
        if not Assigned(EdgeLink) then
          Exit;

        MainRecord := nil;
        if not Supports(EdgeLink.ElementLinksTo['Mesh'], IwbMainRecord, MainRecord) then
          Exit;
        if Assigned(MainRecord) then
          FormID := MainRecord.LoadOrderFormID
        else
          FormID := TwbFormID.Null;
        aInt := EdgeLink.ElementNativeValues['Triangle'];
      end;

      Result := FormID.ToString + IntToHex(aInt, 4);
    end;
    ctCheck: Result := '';
    ctToEditValue: if aInt < 0 then
                     Result := ''
                   else
                     Result := aInt.ToString;
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;
end;

function wbEdgeLinksTo(aEdge: Integer; const aElement: IwbElement): IwbElement;
var
  aInt       : Int64;
  Triangle   : IwbContainerElementRef;
  Triangles  : IwbContainerElementRef;
  Flags      : Int64;
  MainRecord : IwbMainRecord;
  EdgeLinks  : IwbContainerElementRef;
  EdgeLink   : IwbContainerElementRef;
begin
  Result := nil;
  if not Assigned(aElement) then
    Exit;

  Triangle := aElement.Container as IwbContainerElementRef;
  if not Assigned(Triangle) then
    Exit;

  MainRecord := aElement.ContainingMainRecord;
  if not Assigned(MainRecord) then
    Exit;

  aInt := aElement.NativeValue;

  Flags := Triangle.ElementNativeValues['Flags'];
  if Flags and (1 shl aEdge) <> 0 then begin
    if not Supports(MainRecord.ElementByPath['NVNM\Edge Links'], IwbContainerElementRef, EdgeLinks) then
      Exit;

    if aInt >= EdgeLinks.ElementCount then
      Exit;

    if aInt < 0 then
      Exit;

    EdgeLink := EdgeLinks.Elements[aInt] as IwbContainerElementRef;

    MainRecord := nil;
    if not Supports(EdgeLink.ElementLinksTo['Mesh'], IwbMainRecord, MainRecord) then
      Exit;

    aInt := EdgeLink.ElementNativeValues['Triangle'];
  end;

  if not Supports(MainRecord.ElementByPath['NVNM\Triangles'], IwbContainerElementRef, Triangles) then
    Exit;

  if aInt >= Triangles.ElementCount then
    Exit;

  if aInt < 0 then
    Exit;

  Triangle := Triangles.Elements[aInt] as IwbContainerElementRef;

  Result := Triangle;
end;

function wbEdgeLinksTo0(const aElement: IwbElement): IwbElement;
begin
  Result := wbEdgeLinksTo(0, aElement);
end;

function wbEdgeLinksTo1(const aElement: IwbElement): IwbElement;
begin
  Result := wbEdgeLinksTo(1, aElement);
end;

function wbEdgeLinksTo2(const aElement: IwbElement): IwbElement;
begin
  Result := wbEdgeLinksTo(2, aElement);
end;

function wbTriangleLinksTo(const aElement: IwbElement): IwbElement;
var
  aInt       : Int64;
  Triangle   : IwbContainerElementRef;
  Triangles  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  Result := nil;
  if not Assigned(aElement) then
    Exit;

  Triangle := aElement.Container as IwbContainerElementRef;
  if not Assigned(Triangle) then
    Exit;

  MainRecord := aElement.ContainingMainRecord;
  if not Assigned(MainRecord) then
    Exit;

  aInt := aElement.NativeValue;

  if not Supports(MainRecord.ElementByPath['NVNM\Triangles'], IwbContainerElementRef, Triangles) then
    Exit;

  if aInt >= Triangles.ElementCount then
    Exit;

  if aInt < 0 then
    Exit;

  Triangle := Triangles.Elements[aInt] as IwbContainerElementRef;

  Result := Triangle;
end;

function wbVertexToStr(aVertex: Integer; aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Triangle   : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  Vertices  : IwbContainerElementRef;
  Vertex   : IwbContainerElementRef;
begin
  case aType of
    ctToStr, ctToSummary: begin
      Result := aInt.ToString;
      if not Assigned(aElement) then
        Exit;

      Triangle := aElement.Container as IwbContainerElementRef;
      if not Assigned(Triangle) then
        Exit;

      MainRecord := aElement.ContainingMainRecord;
      if not Assigned(MainRecord) then
        Exit;

      if not Supports(MainRecord.ElementByPath['NVNM\Vertices'], IwbContainerElementRef, Vertices) then
        Exit;

      if aInt >= Vertices.ElementCount then
        Exit;

      if aInt < 0 then
        Exit;

      Vertex := Vertices.Elements[aInt] as IwbContainerElementRef;

      with Vertex do try
        Result := Result + Format(' (%s, %s, %s)', [ElementEditValues['X'], ElementEditValues['Y'], ElementEditValues['Z']]);
      except
        // TODO: yikes, suppressing exceptions?
      end;
    end;
    ctToSortKey: begin
      Result := IntToHex(aInt, 4);
      if not Assigned(aElement) then
        Exit;

      Triangle := aElement.Container as IwbContainerElementRef;
      if not Assigned(Triangle) then
        Exit;

      MainRecord := aElement.ContainingMainRecord;
      if not Assigned(MainRecord) then
        Exit;

      if not Supports(MainRecord.ElementByPath['NVNM\Vertices'], IwbContainerElementRef, Vertices) then
        Exit;

      if aInt >= Vertices.ElementCount then
        Exit;

      Vertex := Vertices.Elements[aInt] as IwbContainerElementRef;

      with Vertex do try
        Result := SortKey[False];
      except
        // yikes, suppressing exceptions?
      end;
    end;
    ctCheck: Result := '';
    ctToEditValue: Result := aInt.ToString;
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;
end;


function wbVertexLinksTo(const aElement: IwbElement): IwbElement;
var
  aInt       : Int64;
  Triangle   : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  Vertices   : IwbContainerElementRef;
  Vertex     : IwbContainerElementRef;
begin
  Result := nil;
  if not Assigned(aElement) then
    Exit;

  Triangle := aElement.Container as IwbContainerElementRef;
  if not Assigned(Triangle) then
    Exit;

  MainRecord := aElement.ContainingMainRecord;
  if not Assigned(MainRecord) then
    Exit;

  if not Supports(MainRecord.ElementByPath['NVNM\Vertices'], IwbContainerElementRef, Vertices) then
    Exit;

  aInt := aElement.NativeValue;

  if aInt >= Vertices.ElementCount then
    Exit;
  if aInt < 0 then
    Exit;

  Vertex := Vertices.Elements[aInt] as IwbContainerElementRef;

  Result := Vertex;
end;

function wbCoverLinksTo(const aElement: IwbElement): IwbElement;
var
  aInt       : Int64;
  Triangle   : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
  CoverArray   : IwbContainerElementRef;
  Cover     : IwbContainerElementRef;
begin
  Result := nil;
  if not Assigned(aElement) then
    Exit;

  Triangle := aElement.Container as IwbContainerElementRef;
  if not Assigned(Triangle) then
    Exit;

  MainRecord := aElement.ContainingMainRecord;
  if not Assigned(MainRecord) then
    Exit;

  if not Supports(MainRecord.ElementByPath['NVNM\Cover Array'], IwbContainerElementRef, CoverArray) then
    Exit;

  aInt := aElement.NativeValue;

  if aInt >= CoverArray.ElementCount then
    Exit;
  if aInt < 0 then
    Exit;

  Cover := CoverArray.Elements[aInt] as IwbContainerElementRef;

  Result := Cover;
end;

function wbVertexToInt(aVertex: Integer; const aString: string; const aElement: IwbElement): Int64;
begin
  Result := StrToIntDef(aString, 0);
end;

function wbVertexToStr0(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := wbVertexToStr(0, aInt, aElement, aType);
end;

function wbVertexToInt0(const aString: string; const aElement: IwbElement): Int64;
begin
  Result := wbVertexToInt(0, aString, aElement);
end;

function wbVertexToStr1(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := wbVertexToStr(1, aInt, aElement, aType);
end;

function wbVertexToInt1(const aString: string; const aElement: IwbElement): Int64;
begin
  Result := wbVertexToInt(1, aString, aElement);
end;

function wbVertexToStr2(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := wbVertexToStr(2, aInt, aElement, aType);
end;

function wbVertexToInt2(const aString: string; const aElement: IwbElement): Int64;
begin
  Result := wbVertexToInt(2, aString, aElement);
end;


function wbEdgeToInt(aEdge: Integer; const aString: string; const aElement: IwbElement): Int64;
var
  s: string;
begin
  s := Trim(aString);
  if (s = '')  or SameText(s, 'None') then
    Result := -1
  else
    Result := StrToIntDef(aString, 0);
end;

function wbEdgeToStr0(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := wbEdgeToStr(0, aInt, aElement, aType);
end;

function wbEdgeToInt0(const aString: string; const aElement: IwbElement): Int64;
begin
  Result := wbEdgeToInt(0, aString, aElement);
end;

function wbEdgeToStr1(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := wbEdgeToStr(1, aInt, aElement, aType);
end;

function wbEdgeToInt1(const aString: string; const aElement: IwbElement): Int64;
begin
  Result := wbEdgeToInt(1, aString, aElement);
end;

function wbEdgeToStr2(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := wbEdgeToStr(2, aInt, aElement, aType);
end;

function wbEdgeToInt2(const aString: string; const aElement: IwbElement): Int64;
begin
  Result := wbEdgeToInt(2, aString, aElement);
end;

function wbLGDIFiltersLinksTo(const aElement: IwbElement): IwbElement;
var
  LegendaryIndex : Integer;
  Filter         : IwbContainerElementRef;
  MainRecord     : IwbMainRecord;
  LegendaryMods  : IwbContainerElementRef;
  LegendaryMod   : IwbContainerElementRef;
  BaseStarSlot   : Integer;
  ModIndex       : Integer;
  ModBase        : IwbContainerElementRef;
begin
  Result := nil;
  if not Assigned(aElement) then
    Exit;

  Filter := aElement.Container as IwbContainerElementRef;
  if not Assigned(Filter) then
    Exit;

  MainRecord := aElement.ContainingMainRecord;
  if not Assigned(MainRecord) then
    Exit;

  if not Supports(MainRecord.ElementBySignature[BNAM], IwbContainerElementRef, LegendaryMods) then
    Exit;

  BaseStarSlot := Filter.Elements[0].NativeValue;
  ModIndex := aElement.NativeValue;
  LegendaryIndex := -1;

  for var i := 0 to Pred(LegendaryMods.ElementCount) do
  begin
    LegendaryMod := LegendaryMods.Elements[i] as IwbContainerElementRef;
    if LegendaryMod[0].NativeValue = BaseStarSlot then
    begin
       LegendaryIndex := i + ModIndex;
       Break;
    end
  end;

  if LegendaryIndex = -1 then
    Exit;
    
  if not Supports(LegendaryMods.Elements[LegendaryIndex], IwbContainerElementRef, ModBase) then
    Exit;
  

  Result := ModBase.Elements[1].LinksTo;
end;

function wbLGDIFiltersToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  LegendaryIndex : Integer;
  Filter         : IwbContainerElementRef;
  MainRecord     : IwbMainRecord;
  LegendaryMods  : IwbContainerElementRef;
  LegendaryMod   : IwbContainerElementRef;
  BaseStarSlot   : Integer;
  ModIndex       : Integer;
begin
  Result := 'Unknown Ref';
  if not Assigned(aElement) then
    Exit;

  Filter := aElement.Container as IwbContainerElementRef;
  if not Assigned(Filter) then
    Exit;

  MainRecord := aElement.ContainingMainRecord;
  if not Assigned(MainRecord) then
    Exit;

  if not Supports(MainRecord.ElementBySignature[BNAM], IwbContainerElementRef, LegendaryMods) then
    Exit;

  BaseStarSlot := Filter.Elements[0].NativeValue;
  ModIndex := aElement.NativeValue;
  LegendaryIndex := -1;

  for var i := 0 to Pred(LegendaryMods.ElementCount) do
  begin
    LegendaryMod := LegendaryMods.Elements[i] as IwbContainerElementRef;
    if LegendaryMod[0].NativeValue = BaseStarSlot then
    begin
       LegendaryIndex := i + ModIndex;
       Break;
    end
  end;
  if LegendaryIndex = -1 then
    Exit;

  LegendaryMod := LegendaryMods.Elements[LegendaryIndex] as IwbContainerElementRef;

  Result := LegendaryMod[1].EditValue;
end;

{ Alias to string conversion, requires quest reference or quest record specific to record that references alias }
function wbAliasToStr(aInt: Int64; const aQuestRef: IwbElement; aType: TwbCallbackType): string;
var
  MainRecord : IwbMainRecord;
  EditInfos  : TStringList;
  Aliases    : IwbContainerElementRef;
  Alias      : IwbContainerElementRef;
  i, j       : Integer;
  s, t       : string;
begin
  case aType of
    ctToStr, ctToSummary: if aInt = -1 then
        Result := 'None'
      else if aInt = -2 then
        Result := 'Player'
      else begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: Could not resolve alias>';
      end;
    ctToEditValue: if aInt = -1 then Result := 'None' else
      Result := aInt.ToString;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: if (aInt = -1) or (aInt = -2) then Result := '' else
      Result := '<Warning: Could not resolve alias>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if ((aInt = -1) or (aInt = -2)) and (aType <> ctEditType) and (aType <> ctEditInfo) then
    Exit;

  if not Assigned(aQuestRef) then
    Exit;

  // aQuestRef can be a QUST record or reference to QUST record
  if not Supports(aQuestRef, IwbMainRecord, MainRecord) then
    if not Supports(aQuestRef.LinksTo, IwbMainRecord, MainRecord) then
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
          Result := Result + ' <Warning: "' + MainRecord.ShortName + '" is not a Quest record>';
      end;
      ctCheck: Result := '<Warning: "' + MainRecord.ShortName + '" is not a Quest record>';
    end;
    Exit;
  end;

  case aType of
    ctEditType: begin
      Result := 'ComboBox';
      Exit;
    end;
    ctEditInfo: begin
      EditInfos := TStringList.Create;
    end;
  else
    EditInfos := nil;
  end;

  try
    if Supports(MainRecord.ElementByName['Aliases'], IwbContainerElementRef, Aliases) then begin
      for i := 0 to Pred(Aliases.ElementCount) do
        if Supports(Aliases.Elements[i], IwbContainerElementRef, Alias) then begin
          // skip alias collection
          if Assigned(Alias.ElementBySignature['ALCS']) then
            Continue;
          j := Alias.Elements[0].NativeValue;
          s := Alias.ElementEditValues['ALID'];
          t := IntToStr(j);
          while Length(t) < 3 do
            t := '0' + t;
          if s <> '' then
            t := t + ' ' + s;
          if Assigned(EditInfos) then
            EditInfos.Add(t)
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
          Result := Result + ' <Warning: Quest Alias not found in "' + MainRecord.Name + '">';
      end;
      ctCheck: Result := '<Warning: Quest Alias not found in "' + MainRecord.Name + '">';
      ctEditInfo: begin
        EditInfos.Add('None');
        EditInfos.Sort;
        Result := EditInfos.CommaText;
      end;
    end;
  finally
    FreeAndNil(EditInfos);
  end;
end;

function wbStrToAlias(const aString: string; const aElement: IwbElement): Int64;
var
  i    : Integer;
  s    : string;
begin
  Result := -1;

  if aString = 'None' then
    Exit;

  if aString = 'Player' then begin
    Result := -2;
    Exit;
  end;

  i := 1;
  s := Trim(aString);
  while (i <= Length(s)) and (s[i] in ['-', '0'..'9']) do
    Inc(i);
  s := Copy(s, 1, Pred(i));

  Result := StrToIntDef(s, -1);
end;

function wbScriptObjectAliasToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
begin
  if not wbResolveAlias then begin
    case aType of
      ctToStr, ctToSummary, ctToEditValue: Result := aInt.ToString;
      ctToSortKey: Result := IntToHex64(aInt, 8);
    else
      Result := '';
    end;
    Exit;
  end;

  if not wbTryGetContainerRefFromUnionOrValue(aElement, Container) then
    Exit;

  Result := wbAliasToStr(aInt, Container.ElementByName['FormID'], aType);
end;

function wbPackageLocationAliasToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainer;
begin
  if not wbResolveAlias then begin
    case aType of
      ctToStr, ctToSummary, ctToEditValue: Result := aInt.ToString;
      ctToSortKey: Result := IntToHex64(aInt, 8);
    else
      Result := '';
    end;
    Exit;
  end;

  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  while Assigned(Container) and (Container.ElementType <> etMainRecord) do
    Container := Container.Container;

  if not Assigned(Container) then
    Exit;

  Result := wbAliasToStr(aInt, Container.ElementBySignature['QNAM'], aType);
end;

function wbQuestAliasToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainer;
begin
  if not wbResolveAlias then begin
    case aType of
      ctToStr, ctToSummary, ctToEditValue: Result := aInt.ToString;
      ctToSortKey: Result := IntToHex64(aInt, 8);
    else
      Result := '';
    end;
    Exit;
  end;

  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  while Assigned(Container) and (Container.ElementType <> etMainRecord) do
    Container := Container.Container;

  if not Assigned(Container) then
    Exit;

  Result := wbAliasToStr(aInt, Container, aType);
end;

function wbQuestExternalAliasToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainer;
begin
  if not wbResolveAlias then begin
    case aType of
      ctToStr, ctToSummary, ctToEditValue: Result := aInt.ToString;
      ctToSortKey: Result := IntToHex64(aInt, 8);
    else
      Result := '';
    end;
    Exit;
  end;

  if not Assigned(aElement) then
    Exit;

  Container := aElement.Container;

  if not Assigned(Container) then
    Exit;

  Result := wbAliasToStr(aInt, Container.ElementBySignature['ALEQ'] , aType);
end;

function wbCTDAParam1StringToInt(const aString: string; const aElement: IwbElement): Int64;
var
  Container  : IwbContainerElementRef;
begin
  Result := 0;

  if not Assigned(aElement) then
    Exit;

  Container := GetContainerFromUnion(aElement) as IwbContainerElementRef;
  if not Assigned(Container) then
    Exit;

  Container.ElementEditValues['..\CIS1'] := aString
end;

function wbCTDAParam1StringToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
begin
  case aType of
    ctToStr, ctToSummary, ctToSortKey, ctToEditValue, ctToNativeValue: begin
      Result := '';

      if not Assigned(aElement) then
        Exit;

      Container := GetContainerFromUnion(aElement) as IwbContainerElementRef;
      if not Assigned(Container) then
        Exit;

      case aType of
        ctToSummary:
          Result := Container.ElementEditValues['..\CIS1'];
        ctToEditValue, ctToNativeValue:
          Result := Container.ElementEditValues['..\CIS1'];
      else
        Result := Container.ElementValues['..\CIS1'];
      end;
    end;
    ctCheck, ctEditType, ctEditInfo, ctLinksTo:
      Result := '';
  else
    Result := aInt.ToString;
  end;
end;

function wbCTDAParam2StringToInt(const aString: string; const aElement: IwbElement): Int64;
var
  Container  : IwbContainerElementRef;
begin
  Result := 0;

  if not Assigned(aElement) then
    Exit;

  Container := GetContainerFromUnion(aElement) as IwbContainerElementRef;
  if not Assigned(Container) then
    Exit;

  Container.ElementEditValues['..\CIS2'] := aString
end;

function wbCTDAParam2StringToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainerElementRef;
begin
  case aType of
    ctToStr, ctToSummary, ctToSortKey, ctToEditValue, ctToNativeValue: begin
      Result := '';

      if not Assigned(aElement) then
        Exit;

      Container := GetContainerFromUnion(aElement) as IwbContainerElementRef;
      if not Assigned(Container) then
        Exit;

      case aType of
        ctToSummary:
          Result := Container.ElementSummaries['..\CIS2'];
        ctToEditValue, ctToNativeValue:
          Result := Container.ElementEditValues['..\CIS2'];
      else
        Result := Container.ElementValues['..\CIS2'];
      end;
    end;
    ctCheck, ctEditType, ctEditInfo, ctLinksTo:
      Result := '';
  else
    Result := aInt.ToString;
  end;
end;

function wbConditionAliasToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Container  : IwbContainer;
  MainRecord : IwbMainRecord;
  GroupRecord : IwbGroupRecord;
begin
  if not wbResolveAlias then begin
    case aType of
      ctToStr, ctToSummary, ctToEditValue: Result := aInt.ToString;
      ctToSortKey: Result := IntToHex64(aInt, 8);
    else
      Result := '';
    end;
    Exit;
  end;

  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  while Assigned(Container) and (Container.ElementType <> etMainRecord) do
    Container := Container.Container;

  if not Assigned(Container) then
    Exit;

  if not Supports(Container, IwbMainRecord, MainRecord) then
    Exit;

  if MainRecord.Signature = QUST then
    Result := wbAliasToStr(aInt, Container, aType)
  else if MainRecord.Signature = SCEN then
    Result := wbAliasToStr(aInt, Container.ElementBySignature['PNAM'], aType)
  else if MainRecord.Signature = PACK then
    Result := wbAliasToStr(aInt, Container.ElementBySignature['QNAM'], aType)
  else if MainRecord.Signature = INFO then begin
    // get DIAL for INFO
    if Supports(MainRecord.Container, IwbGroupRecord, GroupRecord) then
      if Supports(GroupRecord.ChildrenOf, IwbMainRecord, MainRecord) then
        Result := wbAliasToStr(aInt, MainRecord.ElementBySignature['QNAM'], aType);
  end else
  // this should never be called since aliases in conditions can be in the forms above only
  // but just in case
  case aType of
    ctToStr, ctToSummary, ctToEditValue: Result := aInt.ToString;
    ctToSortKey: Result := IntToHex64(aInt, 8);
  else
    Result := '';
  end;
end;

function wbClmtMoonsPhaseLength(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  PhaseLength : Byte;
  Masser      : Boolean;
  Secunda     : Boolean;
begin
  Result := '';
  if aType = ctToSortKey then begin
    Result := IntToHex64(aInt, 2);
    Exit;
  end;

  if aType in [ctToStr, ctToSummary] then begin
    PhaseLength := aInt mod 64;
    Masser := (aInt and 64) <> 0;
    Secunda := (aInt and 128) <> 0;
    if Masser then
      if Secunda then
        Result := 'Masser, Secunda / '
      else
        Result := 'Masser / '
    else
      if Secunda then
        Result := 'Secunda / '
      else
        Result := 'No Moon / ';
    Result := Result + IntToStr(PhaseLength);
  end;
end;

function wbClmtTime(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 4)
  else if aType in [ctToStr, ctToSummary] then
    Result := TimeToStr( EncodeTime(aInt div 6, (aInt mod 6) * 10, 0, 0) )
  else
    Result := '';
end;


var
  wbCtdaTypeFlags : IwbFlagsDef;

function wbCtdaTypeToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  s: string;
begin
  Result := '';

  if not Assigned(wbCtdaTypeFlags) then
    wbCtdaTypeFlags := wbFlags([
      {0x01} 'Or',
      {0x02} 'Use aliases',
      {0x04} 'Use global',
      {0x08} 'Use packdata',
      {0x10} 'Swap Subject and Target'
    ]);
{
    Compare operator (upper 3 bits)
    LGE
    000    0=Equal to
    001    1=Not equal to
    010    2=Greater than
    011    3=Greater than or equal to
    100    4=Less than
    101    5=Less than or equal to

    Flags (lower 5 bits)
        0x01=OR (default is to AND conditions together)
        0x02=Parameters (use aliases) : Force function parameters to use quest alias data (exclusive with "use pack data")
        0x04=Use global
        0x08=Use Pack Data : Force function parameters to use pack data (exclusive with "use aliases")
        0x10=Swap Subject and Target
}
  case aType of
    ctEditType:
      Result := 'CheckComboBox';
    ctEditInfo:
      Result := 'Equal,Greater,Lesser,Or,"Use Aliases","Use Global","Use Packdata","Swap Subject and Target"';
    ctToEditValue: begin
      Result := '00000000';
      case aInt and $E0 of
        $00 : Result[1] := '1';
        $40 : Result[2] := '1';
        $60 : begin
                Result[1] := '1';
                Result[2] := '1';
              end;
        $80 : Result[3] := '1';
        $A0 : begin
                Result[1] := '1';
                Result[3] := '1';
              end;
      end;
      if (aInt and $01) <> 0 then // Or
        Result[4] := '1';
      if (aInt and $02) <> 0 then // Use aliases
        Result[5] := '1';
      if (aInt and $04) <> 0 then // Use global
        Result[6] := '1';
      if (aInt and $08) <> 0 then // Use packdata
        Result[7] := '1';
      if (aInt and $10) <> 0 then // Swap Subject and Target
        Result[8] := '1';
    end;
    ctToStr, ctToSummary: begin
      case aInt and $E0 of
        $00 : Result := 'Equal to';
        $20 : Result := 'Not equal to';
        $40 : Result := 'Greater than';
        $60 : Result := 'Greater than or equal to';
        $80 : Result := 'Less than';
        $A0 : Result := 'Less than or equal to';
      else
        Result := '<Unknown Compare operator>'
      end;
      s := wbCtdaTypeFlags.ToString(aInt and $1F, aElement, aType = ctToSummary);
      if s <> '' then
        Result := Result + ' / ' + s;
    end;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 2);
      Exit;
    end;
    ctCheck: begin
      case aInt and $E0 of
        $00, $20, $40, $60, $80, $A0 : Result := '';
      else
        Result := '<Unknown Compare operator>'
      end;
      s := wbCtdaTypeFlags.Check(aInt and $1F, aElement);
      if s <> '' then
        Result := Result + ' / ' + s;
    end;
  end;
end;

function wbCtdaTypeToInt(const aString: string; const aElement: IwbElement): Int64;
var
  s: string;
begin
  s := aString + '00000000';
  if s[1] = '1' then begin
    if s[2] = '1' then begin
      if s[3] = '1' then begin
        Result := $00;
      end else begin
        Result := $60;
      end;
    end else begin
      if s[3] = '1' then begin
        Result := $A0;
      end else begin
        Result := $00;
      end;
    end;
  end else begin
    if s[2] = '1' then begin
      if s[3] = '1' then begin
        Result := $20;
      end else begin
        Result := $40;
      end;
    end else begin
      if s[3] = '1' then begin
        Result := $80;
      end else begin
        Result := $20;
      end;
    end;
  end;
  // Or
  if s[4] = '1' then
    Result := Result or $01;
  // Use aliases
  if s[5] = '1' then
    Result := Result or $02;
  // Use global
  if s[6] = '1' then
    Result := Result or $04;
  // Use packdata
  if s[7] = '1' then
    Result := Result or $08;
  // Swap Subject and Target
  if s[8] = '1' then
    Result := Result or $10;
end;

var
  wbEventFunctionAndMemberEditInfo: string;

function wbEventFunctionAndMemberToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  EventFunction, EventMember: Integer;
  i, j: Integer;
  s1, s2: string;
  slMember: TStringList;
begin
  Result := '';
  EventFunction := aInt and $FFFF;
  EventMember := aInt shr 16;
  case aType of
    ctToStr, ctToSummary, ctToEditValue: begin
      Result := wbEventFunctionEnum.ToEditValue(EventFunction, nil);
      Result := Result + ':' + wbEventMemberEnum.ToEditValue(EventMember, nil);
    end;
    ctToSortKey: Result := IntToHex(aInt, 8);
    ctCheck: begin
      s1 := wbEventFunctionEnum.Check(EventFunction, nil);
      if s1 <> '' then
        s1 := 'EventFunction' + s1;
      s2 := wbEventMemberEnum.Check(EventMember, nil);
      if s2 <> '' then
        s2 := 'EventMember' + s2;
      if (s1 <> '') or (s2 <> '') then
        Result := s1 + ':' + s2;
    end;
    ctEditType:
      Result := 'ComboBox';
    ctEditInfo: begin
      Result := wbEventFunctionAndMemberEditInfo;
      if Result = '' then try
        slMember := TStringList.Create;
        slMember.AddStrings(wbEventMemberEnum.EditInfo[0, nil]);
        with TStringList.Create do try
          for i := 0 to Pred(wbEventFunctionEnum.NameCount) do
            for j := 0 to Pred(slMember.Count) do
              Add(wbEventFunctionEnum.Names[i] + ':' + slMember[j]);
          Sort;
          Result := CommaText;
        finally
          Free;
        end;
        wbEventFunctionAndMemberEditInfo := Result;
      finally
        FreeAndNil(slMember);
      end
    end;
  end;
end;

function wbEventFunctionAndMemberToInt(const aString: string; const aElement: IwbElement): Int64;
var
  EventFunction, EventMember, i: Integer;
begin
  i := Pos(':', aString);
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

procedure wbCtdaTypeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  OldValue, NewValue: Integer;
  Container: IwbContainerElementRef;
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  // reset value if "use global" has changed
  OldValue := aOldValue and $04;
  NewValue := aNewValue and $04;

  if OldValue <> NewValue then
    Container.ElementNativeValues['..\Comparison Value'] := 0;

  {>>> "run on target", no such flag in Skyrim <<<}
//  if aNewValue and $02 then begin
//    Container.ElementNativeValues['..\Run On'] := 1;
//    if Integer(Container.ElementNativeValues['..\Run On']) = 1 then
//      aElement.NativeValue := Byte(aNewValue) and not $02;
//  end;
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

function wbCloudSpeedToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := '';
  case aType of
    ctToStr, ctToSummary, ctToEditValue: Result := FloatToStrF((aInt - 127)/127/10, ffFixed, 99, 4);
    ctCheck: Result := '';
  end;
end;

function wbCloudSpeedToInt(const aString: string; const aElement: IwbElement): Int64;
var
  f: Extended;
begin
  f := StrToFloat(aString);
  f := f*10*127 + 127;
  Result := Min(Round(f), 254);
end;

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

function wbPlacedAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Rec: IwbRecord;
  Container: IwbContainer;
  s: string;
  Cell: IwbMainRecord;
  Position: TwbVector;
  Grid: TwbGridCell;
begin
  Result := '';

  Rec := aMainRecord.RecordBySignature['NAME'];
  if Assigned(Rec) then begin
    s := Trim(Rec.Value);
    if s <> '' then
      Result := 'places ' + s;
  end;

  Container := aMainRecord.Container;
  while Assigned(Container) and (Container.ElementType <> etGroupRecord) do
    Container := Container.Container;

  if not Assigned(Container) then
    Exit;

  s := Trim(Container.Name);
    if s <> '' then begin
    if Result <> '' then
      Result := Result + ' ';

    Result := Result + 'in ' + s;

    // grid position of persistent reference in exterior persistent cell (interior cells are not persistent)
    if Supports(aMainRecord.Container, IwbGroupRecord, Container) then
      Cell := IwbGroupRecord(Container).ChildrenOf;

    if Assigned(Cell) and Cell.IsPersistent and (Cell.Signature = 'CELL') then
        if aMainRecord.GetPosition(Position) then begin
        Grid := wbPositionToGridCell(Position);
        Result := Result + ' at ' + IntToStr(Grid.x) + ',' + IntToStr(Grid.y);
      end;

    // in precombined mesh
    if aMainRecord.HasPrecombinedMesh then
      Result := Result + ' in ' + aMainRecord.PrecombinedMesh;
  end;
end;

function wbINFOAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Container: IwbContainer;
  s: string;
begin
  Result := Trim(aMainRecord.ElementValues['Responses\Response\NAM1']);
  if Result <> '' then
    Result := '''' + Result + '''';

  Container := aMainRecord.Container;
  while Assigned(Container) and (Container.ElementType <> etGroupRecord) do
    Container := Container.Container;

  if Assigned(Container) then begin
    s := Trim(Container.Name);
    if s <> '' then begin
      if Result <> '' then
        Result := Result + ' ';
      Result := Result + 'in ' + s;
    end;
  end;

  s := Trim(aMainRecord.ElementValues['QNAM']);
  if s <> '' then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + 'for ' + s;
  end;
end;

function wbNAVMAddInfo(const aMainRecord: IwbMainRecord): string;
var
  Container: IwbContainer;
  s: string;
begin
  Result := '';

  Container := aMainRecord.Container;
  while Assigned(Container) and (Container.ElementType <> etGroupRecord) do
    Container := Container.Container;

  if not Assigned(Container) then
    Exit;

  s := Trim(Container.Name);
    if s <> '' then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + 'in ' + s;
  end;
end;

//function wbNAVMAddInfo(const aMainRecord: IwbMainRecord): string;
//var
//  Rec        : IwbRecord;
//  Element    : IwbElement;
//  s          : string;
//begin
//  Result := '';
//
//  Rec := aMainRecord.RecordBySignature['DATA'];
//  if Assigned(Rec) then begin
//    Element := Rec.ElementByName['Cell'];
//    if Assigned(Element) then
//      Element := Element.LinksTo;
//    if Assigned(Element) then
//      s := Trim(Element.Name);
//    if s <> '' then
//      Result := 'for ' + s;
//  end;
//end;

function wbNPCLevelDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
  i: Int64;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  i := Container.ElementByName['Flags'].NativeValue;
  if i and $00000080 <> 0 then
    Result := 1;
end;

function wbBFCDATADecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  lContainer           : IwbContainer;
  lContainerElementRef :  IwbContainerElementRef;
  lComponentName       : string;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, lContainer) then
    Exit;
  lContainer := lContainer.Container;
  if not Assigned(lContainer) then
    Exit;
  lContainer := lContainer.Container;
  if not Assigned(lContainer) then
    Exit;
  if not Supports(lContainer, IwbContainerElementRef, lContainerElementRef) then
    Exit;
  if lContainerElementRef.ElementCount < 2 then
    Exit;

  var lBFCB := lContainerElementRef.Elements[0];
  if not Assigned(lBFCB) then
    Exit;

  lComponentName := lBFCB.EditValue;

  if lComponentName = 'BGSStarDataComponent_Component' then
    Exit(1);
  if lComponentName = 'BGSOrbitedDataComponent_Component' then
    Exit(2);
  if lComponentName = 'BGSOrbitalDataComponent_Component' then
    Exit(3);
end;


function wbINFOGroupDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  MainRecord: IwbMainRecord;
begin
  Result := 0;
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
    46: Result := 6; // Vampire Lord
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

function wbNAVIIslandDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container   : IwbContainer;
  SubRecord   : IwbMainRecord;
  Element     : IwbElement;
begin
  Result := 0;

  Container := aElement.Container;
  while Assigned(Container) and (Container.ElementType <> etSubRecord) do
    Container := Container.Container;

  if not Supports(Container, IwbSubRecord, SubRecord) then
    Exit;

  Element := SubRecord.ElementByName['Is Island'];
  if not Assigned(Element) then
    Exit;

  Result := Element.NativeValue;
end;

function wbNAVIParentDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container   : IwbContainer;
  SubRecord   : IwbMainRecord;
  Element     : IwbElement;
begin
  Result := 0;

  Container := aElement.Container;
  while Assigned(Container) and (Container.ElementType <> etsubRecord) do
    Container := Container.Container;

  if not Supports(Container, IwbSubRecord, SubRecord) then
    Exit;

  Element := SubRecord.ElementByName['Pathing Worldspace'];
  if not Assigned(Element) then
    Exit;

  if (Element.NativeValue = 0) then
    Result := 1;
end;

function wbNVNMParentDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container   : IwbContainer;
  Parent      : IwbElement;
  i           : integer;
begin  // Could be simplified by checking if Parent Worldspace is NULL, that's what the runtime does :)
  Result := 0;

  Container := aElement.Container;

  Parent := Container.ElementByName['Pathing Worldspace'];

  if not Assigned(Parent) then
    Exit;

  i := Parent.NativeValue;

  // is interior cell?
  if i = 0 then
    Result := 1;
end;

function wbDoorTriangleDoorTriangleDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container   : IwbContainer;
  Parent      : IwbElement;
  i           : int64;
begin
  Result := 0;

  Container := aElement.Container;

  Parent := Container.ElementByName['Door Type'];

  if not Assigned(Parent) then
    Exit;

  i := Parent.NativeValue;

  // not sure if it would be an error in the file or if it really possible
  if i <> 0 then
    Result := 1;
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

function wbCOEDOwnerDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container  : IwbContainer;
  LinksTo    : IwbElement;
  MainRecord : IwbMainRecord;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  LinksTo := Container.ElementLinksTo['Owner'];
  if not Supports(LinksTo, IwbMainRecord, MainRecord) then
    Exit;

  if MainRecord.Signature = 'NPC_' then
    Result := 1
  else if MainRecord.Signature = 'FACT' then
    Result := 2;
end;

function wbGMSTUnionDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  rEDID: IwbRecord;
  s: string;
begin
  Result := 1;
  rEDID := aElement.Container.RecordBySignature[EDID];
  if not Assigned(rEDID) then
    Exit;

  s := rEDID.Value;
  if Length(s) > 0 then
    case s[1] of
      's': Result := 0; {String} {>>> Localization Strings <<<}
      'i': Result := 1; {intS32}
      'f': Result := 2; {Float}
      'b': Result := 3; {Boolean}
    end;
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

function wbCLFMColorDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container  : IwbContainer;
  rFNAM      : IwbElement;
  i          : Integer;
begin
  Result := 0;

  // resolving to a float causes data loss when copying
  // since deciding field FNAM comes after a value CNAM
  Exit;

  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  Container := Container.Container;
  if not Assigned(Container) then
    Exit;

  rFNAM := Container.ElementBySignature['FNAM'];
  if not Assigned(rFNAM) then
    Exit;

  i := rFNAM.NativeValue;

  if i and 2 <> 0 then
    Result := 1;
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

function wbNOTEDataDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container  : IwbContainer;
  rDNAM      : IwbElement;
  i          : Integer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  Container := Container.Container;
  if not Assigned(Container) then
    Exit;

  rDNAM := Container.ElementBySignature['DNAM'];
  if not Assigned(rDNAM) then
    Exit;

  i := rDNAM.NativeValue;

  case i of
    0: Result := 1;
    1: Result := 2;
    3: Result := 3;
  end;
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
    17: Result := 13;
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
function wbScriptFragmentsQuestCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Container     : IwbContainer;
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

  Result := Integer(Container.ElementNativeValues['FragmentCount']);
end;

procedure wbScriptFragmentsQuestAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterContainerAfterSet('FragmentCount', 'Fragments', aElement);
end;

procedure wbScriptFragmentsQuestFragmentsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('FragmentCount', aElement);
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

type
  TCTDAFunctionParamType = (
    { 0} ptNone,
    { 1} ptString,
    { 2} ptInteger,
    { 3} ptFloat,
    { 4} ptActor,              // ACHR
    { 5} ptActorBase,          // NPC_
    { 6} ptActorValue,         // AVIF?
    { 7} ptAdvanceAction,      // ?? Enum
    { 8} ptAlias,              // index into QUST quest aliases
    { 9} ptAlignment,          // ?? Enum
    {10} ptAssociationType,    // ASTP
    {11} ptAxis,               // ?? Char
    {12} ptCastingSource,      // ?? Enum
    {13} ptCell,               // CELL
    {14} ptClass,              // CLAS
    {15} ptCrimeType,          // ?? Enum
    {16} ptCriticalStage,      // ?? Enum
    {17} ptEncounterZone,      // ECZN
    {18} ptEquipType,          // ?? Enum
    {19} ptEvent,              // Struct
    {20} ptEventData,          // LCTN, KYWD or FLST
    {21} ptFaction,            // FACT
    {22} ptFormList,           // FLST
    {23} ptFormType,           // ?? Enum
    {24} ptFurniture,          // FURN
    {25} ptFurnitureAnim,      // enum
    {26} ptFurnitureEntry,     // flags
    {27} ptGlobal,             // GLOB
    {28} ptIdleForm,           // IDLE
    {29} ptInventoryObject,    // ARMO, BOOK, MISC, WEAP, AMMO, KEYM, ALCH, ARMA, LIGH, LVLI, COBJ
    {30} ptKeyword,            // KYWD
    {31} ptLocation,           // LCTN
    {32} ptMagicEffect,        // MGEF
    {33} ptMagicItem,          // SPEL
    {34} ptMiscStat,           // ?? Enum
    {35} ptObjectReference,    // REFR, ACHR
    {36} ptOwner,              // FACT, NPC_
    {37} ptPackage,            // PACK
    {38} ptPackdata,           // index into PACK package data inputs
    {39} ptPerk,               // PERK
    {40} ptQuest,              // QUST
    {41} ptQuestStage,         // ?? Integer
    {42} ptRace,               // RACE
    {43} ptReferencableObject,
    {44} ptRefType,            // LCRT
    {45} ptRegion,             // REGN
    {46} ptScene,              // SCEN
    {47} ptSex,                // Enum: Male, Female
    {48} ptShout,              // SHOU
    {49} ptVariableName,       // Integer
    {50} ptVATSValueFunction,  //
    {51} ptVATSValueParam,
    {52} ptVoiceType,          // VTYP
    {53} ptWardState,          // enum
    {54} ptWeather,            // WTHR
    {55} ptWorldspace,         // WRLD
    {56} ptDamageType          // DMGT
  );

  PCTDAFunction = ^TCTDAFunction;
  TCTDAFunction = record
    Index: Integer;
    Name: string;
    Desc: string;
    ParamType1: TCTDAFunctionParamType;
    ParamType2: TCTDAFunctionParamType;
    ParamType3: TCTDAFunctionParamType;
  end;

const
  wbCTDAFunctions : array[0..478] of TCTDAFunction = (
    (Index:   0; Name: 'GetWantBlocking'),    //   0
    (Index:   1; Name: 'GetDistance'; ParamType1: ptObjectReference),
    (Index:   5; Name: 'GetLocked'),    //   2
    (Index:   6; Name: 'GetPos'; Paramtype1: ptAxis),    //   3
    (Index:   8; Name: 'GetAngle'; Paramtype1: ptAxis),    //   4
    (Index:  10; Name: 'GetStartingPos'; Paramtype1: ptAxis),    //   5
    (Index:  11; Name: 'GetStartingAngle'; Paramtype1: ptAxis),    //   6
    (Index:  12; Name: 'GetSecondsPassed'),    //   7
    (Index:  14; Name: 'GetValue'; Paramtype1: ptActorValue),    //   8
    (Index:  18; Name: 'GetCurrentTime'),    //   9
    (Index:  24; Name: 'GetScale'),    //  10
    (Index:  25; Name: 'IsMoving'),    //  11
    (Index:  26; Name: 'IsTurning'),    //  12
    (Index:  27; Name: 'GetLineOfSight'; ParamType1: ptObjectReference),
    (Index:  32; Name: 'GetInSameCell'; ParamType1: ptObjectReference),
    (Index:  35; Name: 'GetDisabled'),    //  15
    (Index:  36; Name: 'MenuMode'; Paramtype1: ptInteger),
    (Index:  39; Name: 'GetDisease'),    //  17
    (Index:  41; Name: 'GetClothingValue'),    //  18
    (Index:  42; Name: 'SameFaction'; Paramtype1: ptActor),    //  19
    (Index:  43; Name: 'SameRace'; Paramtype1: ptActor),    //  20
    (Index:  44; Name: 'SameSex'; Paramtype1: ptActor),    //  21
    (Index:  45; Name: 'GetDetected'; Paramtype1: ptActor),    //  22
    (Index:  46; Name: 'GetDead'),    //  23
    (Index:  47; Name: 'GetItemCount'; ParamType1: ptReferencableObject),
    (Index:  48; Name: 'GetGold'),    //  25
    (Index:  49; Name: 'GetSleeping'),    //  26
    (Index:  50; Name: 'GetTalkedToPC'),    //  27
    (Index:  56; Name: 'GetQuestRunning'; Paramtype1: ptQuest),    //  28
    (Index:  58; Name: 'GetStage'; Paramtype1: ptQuest),    //  29
    (Index:  59; Name: 'GetStageDone'; ParamType1: ptQuest; ParamType2: ptQuestStage),
    (Index:  60; Name: 'GetFactionRankDifference'; Paramtype1: ptFaction; Paramtype2: ptActor),    //  31
    (Index:  61; Name: 'GetAlarmed'),    //  32
    (Index:  62; Name: 'IsRaining'),    //  33
    (Index:  63; Name: 'GetAttacked'),    //  34
    (Index:  64; Name: 'GetIsCreature'),    //  35
    (Index:  65; Name: 'GetLockLevel'),    //  36
    (Index:  66; Name: 'GetShouldAttack'; Paramtype1: ptActor),    //  37
    (Index:  67; Name: 'GetInCell'; Paramtype1: ptCell),    //  38
    (Index:  68; Name: 'GetIsClass'; Paramtype1: ptClass),    //  39
    (Index:  69; Name: 'GetIsRace'; Paramtype1: ptRace),    //  40
    (Index:  70; Name: 'GetIsSex'; Paramtype1: ptSex),    //  41
    (Index:  71; Name: 'GetInFaction'; Paramtype1: ptFaction),    //  42
    (Index:  72; Name: 'GetIsID'; ParamType1: ptReferencableObject),
    (Index:  73; Name: 'GetFactionRank'; Paramtype1: ptFaction),    //  44
    (Index:  74; Name: 'GetGlobalValue'; Paramtype1: ptGlobal),    //  45
    (Index:  75; Name: 'IsSnowing'),    //  46
    (Index:  77; Name: 'GetRandomPercent'),    //  47
    (Index:  79; Name: 'WouldBeStealing'; ParamType1: ptObjectReference),
    (Index:  80; Name: 'GetLevel'),    //  49
    (Index:  81; Name: 'IsRotating'),    //  50
    (Index:  84; Name: 'GetDeadCount'; ParamType1: ptActorBase),
    (Index:  91; Name: 'GetIsAlerted'),    //  52
    (Index:  98; Name: 'GetPlayerControlsDisabled'; Paramtype1: ptInteger; Paramtype2: ptInteger; Paramtype3: ptInteger),
    (Index:  99; Name: 'GetHeadingAngle'; ParamType1: ptObjectReference),
    (Index: 101; Name: 'IsWeaponMagicOut'),    //  55
    (Index: 102; Name: 'IsTorchOut'),    //  56
    (Index: 103; Name: 'IsShieldOut'),    //  57
    (Index: 106; Name: 'IsFacingUp'),    //  58
    (Index: 107; Name: 'GetKnockedState'),    //  59
    (Index: 108; Name: 'GetWeaponAnimType'),    //  60
    (Index: 109; Name: 'IsWeaponSkillType'; ParamType1: ptActorValue),
    (Index: 110; Name: 'GetCurrentAIPackage'),    //  62
    (Index: 111; Name: 'IsWaiting'),    //  63
    (Index: 112; Name: 'IsIdlePlaying'),    //  64
    (Index: 116; Name: 'IsIntimidatedbyPlayer'),    //  65
    (Index: 117; Name: 'IsPlayerInRegion'; Paramtype1: ptRegion),    //  66
    (Index: 118; Name: 'GetActorAggroRadiusViolated'),    //  67
    (Index: 122; Name: 'GetCrime'; ParamType1: ptActor; ParamType2: ptCrimeType),
    (Index: 123; Name: 'IsGreetingPlayer'),    //  69
    (Index: 125; Name: 'IsGuard'),    //  70
    (Index: 127; Name: 'HasBeenEaten'),    //  71
    (Index: 128; Name: 'GetStaminaPercentage'),    //  72
    (Index: 129; Name: 'HasBeenRead'),    //  73
    (Index: 130; Name: 'GetDying'),    //  74
    (Index: 131; Name: 'GetSceneActionPercent'; ParamType1: ptScene; ParamType2: ptInteger),
    (Index: 132; Name: 'WouldRefuseCommand'; ParamType1: ptObjectReference),
    (Index: 133; Name: 'SameFactionAsPC'),    //  77
    (Index: 134; Name: 'SameRaceAsPC'),    //  78
    (Index: 135; Name: 'SameSexAsPC'),    //  79
    (Index: 136; Name: 'GetIsReference'; ParamType1: ptObjectReference),
    (Index: 141; Name: 'IsTalking'),    //  81
    (Index: 142; Name: 'GetComponentCount'; ParamType1: ptReferencableObject),
    (Index: 143; Name: 'GetCurrentAIProcedure'),    //  83
    (Index: 144; Name: 'GetTrespassWarningLevel'),    //  84
    (Index: 145; Name: 'IsTrespassing'),    //  85
    (Index: 146; Name: 'IsInMyOwnedCell'),    //  86
    (Index: 147; Name: 'GetWindSpeed'),    //  87
    (Index: 148; Name: 'GetCurrentWeatherPercent'),    //  88
    (Index: 149; Name: 'GetIsCurrentWeather'; ParamType1: ptWeather),
    (Index: 150; Name: 'IsContinuingPackagePCNear'),    //  90
    (Index: 152; Name: 'GetIsCrimeFaction'; Paramtype1: ptFaction),    //  91
    (Index: 153; Name: 'CanHaveFlames'),    //  92
    (Index: 154; Name: 'HasFlames'),    //  93
    (Index: 157; Name: 'GetOpenState'),    //  94
    (Index: 159; Name: 'GetSitting'),    //  95
    (Index: 161; Name: 'GetIsCurrentPackage'; Paramtype1: ptPackage),    //  96
    (Index: 162; Name: 'IsCurrentFurnitureRef'; ParamType1: ptObjectReference),
    (Index: 163; Name: 'IsCurrentFurnitureObj'; Paramtype1: ptFurniture),    //  98
    (Index: 170; Name: 'GetDayOfWeek'),    //  99
    (Index: 172; Name: 'GetTalkedToPCParam'; Paramtype1: ptActor),    // 100
    (Index: 175; Name: 'IsPCSleeping'),    // 101
    (Index: 176; Name: 'IsPCAMurderer'),    // 102
    (Index: 180; Name: 'HasSameEditorLocationAsRef'; ParamType1: ptObjectReference; ParamType2: ptKeyword),
    (Index: 181; Name: 'HasSameEditorLocationAsRefAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),
    (Index: 182; Name: 'GetEquipped'; ParamType1: ptReferencableObject),
    (Index: 185; Name: 'IsSwimming'),    // 106
    (Index: 190; Name: 'GetAmountSoldStolen'),    // 107
    (Index: 192; Name: 'GetIgnoreCrime'),    // 108
    (Index: 193; Name: 'GetPCExpelled'; Paramtype1: ptFaction),    // 109
    (Index: 195; Name: 'GetPCFactionMurder'; Paramtype1: ptFaction),    // 110
    (Index: 197; Name: 'GetPCEnemyofFaction'; Paramtype1: ptFaction),    // 111
    (Index: 199; Name: 'GetPCFactionAttack'; Paramtype1: ptFaction),    // 112
    (Index: 203; Name: 'GetDestroyed'),    // 113
    (Index: 214; Name: 'HasMagicEffect'; ParamType1: ptMagicEffect),
    (Index: 215; Name: 'GetDefaultOpen'),    // 115
    (Index: 223; Name: 'IsSpellTarget'; ParamType1: ptMagicItem),
    (Index: 224; Name: 'GetVATSMode'),    // 117
    (Index: 225; Name: 'GetPersuasionNumber'),    // 118
    (Index: 226; Name: 'GetVampireFeed'),    // 119
    (Index: 227; Name: 'GetCannibal'),    // 120
    (Index: 228; Name: 'GetIsClassDefault'; Paramtype1: ptClass),    // 121
    (Index: 229; Name: 'GetClassDefaultMatch'),    // 122
    (Index: 230; Name: 'GetInCellParam'; ParamType1: ptCell; ParamType2: ptObjectReference),
    (Index: 231; Name: 'GetPlayerDialogueInput'),    // 124
    (Index: 235; Name: 'GetVatsTargetHeight'),    // 125
    (Index: 237; Name: 'GetIsGhost'),    // 126
    (Index: 242; Name: 'GetUnconscious'),    // 127
    (Index: 244; Name: 'GetRestrained'),    // 128
    (Index: 246; Name: 'GetIsUsedItem'; ParamType1: ptReferencableObject),
    (Index: 247; Name: 'GetIsUsedItemType'; ParamType1: ptFormType),
    (Index: 248; Name: 'IsScenePlaying'; Paramtype1: ptScene),    // 131
    (Index: 249; Name: 'IsInDialogueWithPlayer'),    // 132
    (Index: 250; Name: 'GetLocationCleared'; Paramtype1: ptLocation),    // 133
    (Index: 254; Name: 'GetIsPlayableRace'),    // 134
    (Index: 255; Name: 'GetOffersServicesNow'),    // 135
    (Index: 258; Name: 'HasAssociationType'; Paramtype1: ptActor; Paramtype2: ptAssociationType),    // 136
    (Index: 259; Name: 'HasFamilyRelationship'; Paramtype1: ptActor),    // 137
    (Index: 261; Name: 'HasParentRelationship'; Paramtype1: ptActor),    // 138
    (Index: 262; Name: 'IsWarningAbout'; ParamType1: ptFormList),
    (Index: 263; Name: 'IsWeaponOut'),    // 140
    (Index: 264; Name: 'HasSpell'; ParamType1: ptMagicItem),
    (Index: 265; Name: 'IsTimePassing'),    // 142
    (Index: 266; Name: 'IsPleasant'),    // 143
    (Index: 267; Name: 'IsCloudy'),    // 144
    (Index: 274; Name: 'IsSmallBump'),    // 145
    (Index: 277; Name: 'GetBaseValue'; ParamType1: ptActorValue),
    (Index: 278; Name: 'IsOwner'; ParamType1: ptOwner),
    (Index: 280; Name: 'IsCellOwner'; ParamType1: ptCell; ParamType2: ptOwner),
    (Index: 282; Name: 'IsHorseStolen'),    // 149
    (Index: 285; Name: 'IsLeftUp'),    // 150
    (Index: 286; Name: 'IsSneaking'),    // 151
    (Index: 287; Name: 'IsRunning'),    // 152
    (Index: 288; Name: 'GetFriendHit'),    // 153
    (Index: 289; Name: 'IsInCombat'; ParamType1: ptInteger),
    (Index: 300; Name: 'IsInInterior'),    // 155
    (Index: 304; Name: 'IsWaterObject'),    // 156
    (Index: 305; Name: 'GetPlayerAction'),    // 157
    (Index: 306; Name: 'IsActorUsingATorch'),    // 158
    (Index: 309; Name: 'IsXBox'),    // 159
    (Index: 310; Name: 'GetInWorldspace'; Paramtype1: ptWorldSpace),    // 160
    (Index: 312; Name: 'GetPCMiscStat'; ParamType1: ptMiscStat),
    (Index: 313; Name: 'GetPairedAnimation'),    // 162
    (Index: 314; Name: 'IsActorAVictim'),    // 163
    (Index: 315; Name: 'GetTotalPersuasionNumber'),    // 164
    (Index: 318; Name: 'GetIdleDoneOnce'),    // 165
    (Index: 320; Name: 'GetNoRumors'),    // 166
    (Index: 323; Name: 'GetCombatState'),    // 167
    (Index: 325; Name: 'GetWithinPackageLocation'; ParamType1: ptPackdata),
    (Index: 327; Name: 'IsRidingMount'),    // 169
    (Index: 329; Name: 'IsFleeing'),    // 170
    (Index: 332; Name: 'IsInDangerousWater'),    // 171
    (Index: 338; Name: 'GetIgnoreFriendlyHits'),    // 172
    (Index: 339; Name: 'IsPlayersLastRiddenMount'),    // 173
    (Index: 353; Name: 'IsActor'),    // 174
    (Index: 354; Name: 'IsEssential'),    // 175
    (Index: 358; Name: 'IsPlayerMovingIntoNewSpace'),    // 176
    (Index: 359; Name: 'GetInCurrentLocation'; Paramtype1: ptLocation),    // 177
    (Index: 360; Name: 'GetInCurrentLocationAlias'; ParamType1: ptAlias),
    (Index: 361; Name: 'GetTimeDead'),    // 179
    (Index: 362; Name: 'HasLinkedRef'; Paramtype1: ptKeyword),    // 180
    (Index: 365; Name: 'IsChild'),    // 181
    (Index: 366; Name: 'GetStolenItemValueNoCrime'; Paramtype1: ptFaction),    // 182
    (Index: 367; Name: 'GetLastPlayerAction'),    // 183
    (Index: 368; Name: 'IsPlayerActionActive'; Paramtype1: ptInteger),    // 184
    (Index: 370; Name: 'IsTalkingActivatorActor'; Paramtype1: ptActor),    // 185
    (Index: 372; Name: 'IsInList'; ParamType1: ptFormList),
    (Index: 373; Name: 'GetStolenItemValue'; Paramtype1: ptFaction),    // 187
    (Index: 375; Name: 'GetCrimeGoldViolent'; ParamType1: ptFaction),
    (Index: 376; Name: 'GetCrimeGoldNonviolent'; ParamType1: ptFaction),
    (Index: 378; Name: 'IsOwnedBy'; Paramtype1: ptActor),    // 190
    (Index: 380; Name: 'GetCommandDistance'),    // 191
    (Index: 381; Name: 'GetCommandLocationDistance'),    // 192
    (Index: 390; Name: 'GetHitLocation'),    // 193
    (Index: 391; Name: 'IsPC1stPerson'),    // 194
    (Index: 396; Name: 'GetCauseofDeath'),    // 195
    (Index: 397; Name: 'IsLimbGone'; Paramtype1: ptInteger),    // 196
    (Index: 398; Name: 'IsWeaponInList'; ParamType1: ptFormList),
    (Index: 402; Name: 'IsBribedbyPlayer'),    // 198
    (Index: 403; Name: 'GetRelationshipRank'; Paramtype1: ptActor),    // 199
    (Index: 407; Name: 'GetVATSValue'; ParamType1: ptInteger; ParamType2: ptInteger),
    (Index: 408; Name: 'IsKiller'; Paramtype1: ptActor),    // 201
    (Index: 409; Name: 'IsKillerObject'; ParamType1: ptFormList),
    (Index: 410; Name: 'GetFactionCombatReaction'; Paramtype1: ptFaction; Paramtype2: ptFaction),    // 203
    (Index: 414; Name: 'Exists'; ParamType1: ptObjectReference),
    (Index: 415; Name: 'GetGroupMemberCount'),    // 205
    (Index: 416; Name: 'GetGroupTargetCount'),    // 206
    (Index: 426; Name: 'GetIsVoiceType'; Paramtype1: ptVoiceType),    // 207
    (Index: 427; Name: 'GetPlantedExplosive'),    // 208
    (Index: 429; Name: 'IsScenePackageRunning'),    // 209
    (Index: 430; Name: 'GetHealthPercentage'),    // 210
    (Index: 432; Name: 'GetIsObjectType'; ParamType1: ptFormType),
    (Index: 434; Name: 'PlayerVisualDetection'),    // 212
    (Index: 435; Name: 'PlayerAudioDetection'),    // 213
    (Index: 437; Name: 'GetIsCreatureType'; Paramtype1: ptInteger),    // 214
    (Index: 438; Name: 'HasKey'; ParamType1: ptObjectReference),
    (Index: 439; Name: 'IsFurnitureEntryType'; ParamType1: ptReferencableObject),
    (Index: 444; Name: 'GetInCurrentLocationFormList'; ParamType1: ptFormList),
    (Index: 445; Name: 'GetInZone'; Paramtype1: ptEncounterZone),    // 218
    (Index: 446; Name: 'GetVelocity'; Paramtype1: ptAxis),    // 219
    (Index: 447; Name: 'GetGraphVariableFloat'; Paramtype1: ptString),    // 220
    (Index: 448; Name: 'HasPerk'; Paramtype1: ptPerk),    // 221
    (Index: 449; Name: 'GetFactionRelation'; Paramtype1: ptActor),    // 222
    (Index: 450; Name: 'IsLastIdlePlayed'; ParamType1: ptIdleForm),
    (Index: 453; Name: 'GetPlayerTeammate'),    // 224
    (Index: 454; Name: 'GetPlayerTeammateCount'),    // 225
    (Index: 458; Name: 'GetActorCrimePlayerEnemy'),    // 226
    (Index: 459; Name: 'GetCrimeGold'; ParamType1: ptFaction),
    (Index: 463; Name: 'IsPlayerGrabbedRef'; ParamType1: ptObjectReference),
    (Index: 465; Name: 'GetKeywordItemCount'; Paramtype1: ptKeyword),    // 229
    (Index: 470; Name: 'GetDestructionStage'),    // 230
    (Index: 473; Name: 'GetIsAlignment'; Paramtype1: ptAlignment),    // 231
    (Index: 476; Name: 'IsProtected'),    // 232
    (Index: 477; Name: 'GetThreatRatio'; Paramtype1: ptActor),    // 233
    (Index: 479; Name: 'GetIsUsedItemEquipType'; Paramtype1: ptEquipType),    // 234
    (Index: 483; Name: 'GetPlayerActivated'),    // 235
    (Index: 485; Name: 'GetFullyEnabledActorsInHigh'),    // 236
    (Index: 487; Name: 'IsCarryable'),    // 237
    (Index: 488; Name: 'GetConcussed'),    // 238
    (Index: 491; Name: 'GetMapMarkerVisible'),    // 239
    (Index: 493; Name: 'PlayerKnows'; ParamType1: ptReferencableObject),
    (Index: 494; Name: 'GetPermanentValue'; ParamType1: ptActorValue),
    (Index: 495; Name: 'GetKillingBlowLimb'),    // 242
    (Index: 497; Name: 'CanPayCrimeGold'; ParamType1: ptFaction),
    (Index: 499; Name: 'GetDaysInJail'),    // 244
    (Index: 500; Name: 'EPAlchemyGetMakingPoison'),    // 245
    (Index: 501; Name: 'EPAlchemyEffectHasKeyword'; Paramtype1: ptKeyword),    // 246
    (Index: 503; Name: 'GetAllowWorldInteractions'),    // 247
    (Index: 506; Name: 'DialogueGetAv'; ParamType1: ptActorValue),
    (Index: 507; Name: 'DialogueHasPerk'; Paramtype1: ptPerk),    // 249
    (Index: 508; Name: 'GetLastHitCritical'),    // 250
    (Index: 510; Name: 'DialogueGetItemCount'; ParamType1: ptReferencableObject),
    (Index: 511; Name: 'LastCrippledCondition'; ParamType1: ptActorValue),
    (Index: 512; Name: 'HasSharedPowerGrid'; ParamType1: ptObjectReference),
    (Index: 513; Name: 'IsCombatTarget'; Paramtype1: ptActor),    // 254
    (Index: 515; Name: 'GetVATSRightAreaFree'; ParamType1: ptObjectReference),
    (Index: 516; Name: 'GetVATSLeftAreaFree'; ParamType1: ptObjectReference),
    (Index: 517; Name: 'GetVATSBackAreaFree'; ParamType1: ptObjectReference),
    (Index: 518; Name: 'GetVATSFrontAreaFree'; ParamType1: ptObjectReference),
    (Index: 519; Name: 'GetIsLockBroken'),    // 259
    (Index: 520; Name: 'IsPS3'),    // 260
    (Index: 521; Name: 'IsWindowsPC'),    // 261
    (Index: 522; Name: 'GetVATSRightTargetVisible'; ParamType1: ptObjectReference),
    (Index: 523; Name: 'GetVATSLeftTargetVisible'; ParamType1: ptObjectReference),
    (Index: 524; Name: 'GetVATSBackTargetVisible'; ParamType1: ptObjectReference),
    (Index: 525; Name: 'GetVATSFrontTargetVisible'; ParamType1: ptObjectReference),
    (Index: 528; Name: 'IsInCriticalStage'; Paramtype1: ptCriticalStage),    // 266
    (Index: 530; Name: 'GetXPForNextLevel'),    // 267
    (Index: 533; Name: 'GetInfamy'; ParamType1: ptFaction),
    (Index: 534; Name: 'GetInfamyViolent'; ParamType1: ptFaction),
    (Index: 535; Name: 'GetInfamyNonViolent'; ParamType1: ptFaction),
    (Index: 536; Name: 'GetTypeCommandPerforming'),    // 271
    (Index: 543; Name: 'GetQuestCompleted'; Paramtype1: ptQuest),    // 272
    (Index: 544; Name: 'GetSpeechChallengeSuccessLevel'),    // 273
    (Index: 547; Name: 'IsGoreDisabled'),    // 274
    (Index: 550; Name: 'IsSceneActionComplete'; ParamType1: ptScene; ParamType2: ptInteger),
    (Index: 552; Name: 'GetSpellUsageNum'; ParamType1: ptMagicItem),
    (Index: 554; Name: 'GetActorsInHigh'),    // 277
    (Index: 555; Name: 'HasLoaded3D'),    // 278
    (Index: 560; Name: 'HasKeyword'; Paramtype1: ptKeyword),    // 279
    (Index: 561; Name: 'HasRefType'; Paramtype1: ptRefType),    // 280
    (Index: 562; Name: 'LocationHasKeyword'; Paramtype1: ptKeyword),    // 281
    (Index: 563; Name: 'LocationHasRefType'; Paramtype1: ptRefType),    // 282
    (Index: 565; Name: 'GetIsEditorLocation'; Paramtype1: ptLocation),    // 283
    (Index: 566; Name: 'GetIsAliasRef'; ParamType1: ptAlias),
    (Index: 567; Name: 'GetIsEditorLocationAlias'; ParamType1: ptAlias),
    (Index: 568; Name: 'IsSprinting'),    // 286
    (Index: 569; Name: 'IsBlocking'),    // 287
    (Index: 570; Name: 'HasEquippedSpell'; ParamType1: ptCastingSource),
    (Index: 571; Name: 'GetCurrentCastingType'; ParamType1: ptCastingSource),
    (Index: 572; Name: 'GetCurrentDeliveryType'; ParamType1: ptCastingSource),
    (Index: 574; Name: 'GetAttackState'),    // 291
    (Index: 576; Name: 'GetEventData'; ParamType1: ptEvent; ParamType2: ptEventData; ParamType3: ptString),  // fireundubh: Event Function, Event Member, Data (SF1)
    (Index: 577; Name: 'IsCloserToAThanB'; ParamType1: ptObjectReference; ParamType2: ptObjectReference),
    (Index: 578; Name: 'LevelMinusPCLevel'),    // 294
    (Index: 580; Name: 'IsBleedingOut'),    // 295
    (Index: 584; Name: 'GetRelativeAngle'; ParamType1: ptObjectReference; ParamType2: ptAxis),
    (Index: 589; Name: 'GetMovementDirection'),    // 297
    (Index: 590; Name: 'IsInScene'),    // 298
    (Index: 591; Name: 'GetRefTypeDeadCount'; Paramtype1: ptLocation; Paramtype2: ptRefType),    // 299
    (Index: 592; Name: 'GetRefTypeAliveCount'; Paramtype1: ptLocation; Paramtype2: ptRefType),    // 300
    (Index: 594; Name: 'GetIsFlying'),    // 301
    (Index: 595; Name: 'IsCurrentSpell'; ParamType1: ptMagicItem; ParamType2: ptCastingSource),
    (Index: 596; Name: 'SpellHasKeyword'; ParamType1: ptCastingSource; ParamType2: ptKeyword),
    (Index: 597; Name: 'GetEquippedItemType'; ParamType1: ptCastingSource),
    (Index: 598; Name: 'GetLocationAliasCleared'; ParamType1: ptAlias),
    (Index: 600; Name: 'GetLocationAliasRefTypeDeadCount'; ParamType1: ptAlias; ParamType2: ptRefType),
    (Index: 601; Name: 'GetLocationAliasRefTypeAliveCount'; ParamType1: ptAlias; ParamType2: ptRefType),
    (Index: 602; Name: 'IsWardState'; ParamType1: ptWardState),
    (Index: 603; Name: 'IsInSameCurrentLocationAsRef'; ParamType1: ptObjectReference; ParamType2: ptKeyword),
    (Index: 604; Name: 'IsInSameCurrentLocationAsRefAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),
    (Index: 605; Name: 'LocationAliasIsLocation'; ParamType1: ptAlias; ParamType2: ptLocation),
    (Index: 606; Name: 'GetKeywordDataForLocation'; Paramtype1: ptLocation; Paramtype2: ptKeyword),    // 312
    (Index: 608; Name: 'GetKeywordDataForAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),
    (Index: 610; Name: 'LocationAliasHasKeyword'; ParamType1: ptAlias; ParamType2: ptKeyword),
    (Index: 611; Name: 'IsNullPackageData'; ParamType1: ptPackdata),
    (Index: 612; Name: 'GetNumericPackageData'; ParamType1: ptPackdata),
    (Index: 613; Name: 'IsPlayerRadioOn'),    // 317
    (Index: 614; Name: 'GetPlayerRadioFrequency'),    // 318
    (Index: 615; Name: 'GetHighestRelationshipRank'),    // 319
    (Index: 616; Name: 'GetLowestRelationshipRank'),    // 320
    (Index: 617; Name: 'HasAssociationTypeAny'; Paramtype1: ptAssociationType),    // 321
    (Index: 618; Name: 'HasFamilyRelationshipAny'),    // 322
    (Index: 619; Name: 'GetPathingTargetOffset'; Paramtype1: ptAxis),    // 323
    (Index: 620; Name: 'GetPathingTargetAngleOffset'; Paramtype1: ptAxis),    // 324
    (Index: 621; Name: 'GetPathingTargetSpeed'),    // 325
    (Index: 622; Name: 'GetPathingTargetSpeedAngle'; Paramtype1: ptAxis),    // 326
    (Index: 623; Name: 'GetMovementSpeed'),    // 327
    (Index: 624; Name: 'GetInContainer'; ParamType1: ptObjectReference),
    (Index: 625; Name: 'IsLocationLoaded'; Paramtype1: ptLocation),    // 329
    (Index: 626; Name: 'IsLocationAliasLoaded'; ParamType1: ptAlias),
    (Index: 627; Name: 'IsDualCasting'),    // 331
    (Index: 629; Name: 'GetVMQuestVariable'; ParamType1: ptQuest; ParamType2: ptString),
    (Index: 630; Name: 'GetCombatAudioDetection'),    // 333
    (Index: 631; Name: 'GetCombatVisualDetection'),    // 334
    (Index: 632; Name: 'IsCasting'),    // 335
    (Index: 633; Name: 'GetFlyingState'),    // 336
    (Index: 635; Name: 'IsInFavorState'),    // 337
    (Index: 636; Name: 'HasTwoHandedWeaponEquipped'),    // 338
    (Index: 637; Name: 'IsFurnitureExitType'; ParamType1: ptReferencableObject),
    (Index: 638; Name: 'IsInFriendStatewithPlayer'),    // 340
    (Index: 639; Name: 'GetWithinDistance'; ParamType1: ptObjectReference; ParamType2: ptFloat),
    (Index: 640; Name: 'GetValuePercent'; ParamType1: ptActorValue),
    (Index: 641; Name: 'IsUnique'),    // 343
    (Index: 642; Name: 'GetLastBumpDirection'),    // 344
    (Index: 644; Name: 'GetInfoChallangeSuccess'),    // 345
    (Index: 645; Name: 'GetIsInjured'),    // 346
    (Index: 646; Name: 'GetIsCrashLandRequest'),    // 347
    (Index: 647; Name: 'GetIsHastyLandRequest'),    // 348
    (Index: 650; Name: 'IsLinkedTo'; ParamType1: ptObjectReference; ParamType2: ptKeyword),
    (Index: 651; Name: 'GetKeywordDataForCurrentLocation'; Paramtype1: ptKeyword),    // 350
    (Index: 652; Name: 'GetInSharedCrimeFaction'; ParamType1: ptObjectReference),
    (Index: 654; Name: 'GetBribeSuccess'),    // 352
    (Index: 655; Name: 'GetIntimidateSuccess'),    // 353
    (Index: 656; Name: 'GetArrestedState'),    // 354
    (Index: 657; Name: 'GetArrestingActor'),    // 355
    (Index: 659; Name: 'HasVMScript'; ParamType1: ptString),
    (Index: 660; Name: 'GetVMScriptVariable'; ParamType1: ptString; ParamType2: ptString),
    (Index: 661; Name: 'GetWorkshopResourceDamage'; ParamType1: ptActorValue),
    (Index: 664; Name: 'HasValidRumorTopic'; Paramtype1: ptQuest),    // 359
    (Index: 672; Name: 'IsAttacking'),    // 360
    (Index: 673; Name: 'IsPowerAttacking'),    // 361
    (Index: 674; Name: 'IsLastHostileActor'),    // 362
    (Index: 675; Name: 'GetGraphVariableInt'; ParamType1: ptString),
    (Index: 678; Name: 'ShouldAttackKill'; Paramtype1: ptActor),    // 364
    (Index: 680; Name: 'GetActivationHeight'),    // 365
    (Index: 682; Name: 'WornHasKeyword'; Paramtype1: ptKeyword),    // 366
    (Index: 683; Name: 'GetPathingCurrentSpeed'),    // 367
    (Index: 684; Name: 'GetPathingCurrentSpeedAngle'; Paramtype1: ptAxis),    // 368
    (Index: 691; Name: 'GetWorkshopObjectCount'; ParamType1: ptReferencableObject),
    (Index: 693; Name: 'EPMagic_SpellHasKeyword'; Paramtype1: ptKeyword),    // 370
    (Index: 694; Name: 'GetNoBleedoutRecovery'),    // 371
    (Index: 696; Name: 'EPMagic_SpellHasSkill'; ParamType1: ptActorValue),
    (Index: 697; Name: 'IsAttackType'; Paramtype1: ptKeyword),    // 373
    (Index: 698; Name: 'IsAllowedToFly'),    // 374
    (Index: 699; Name: 'HasMagicEffectKeyword'; Paramtype1: ptKeyword),    // 375
    (Index: 700; Name: 'IsCommandedActor'),    // 376
    (Index: 701; Name: 'IsStaggered'),    // 377
    (Index: 702; Name: 'IsRecoiling'),    // 378
    (Index: 703; Name: 'HasScopeWeaponEquipped'),    // 379
    (Index: 704; Name: 'IsPathing'),    // 380
    (Index: 705; Name: 'GetShouldHelp'; Paramtype1: ptActor),    // 381
    (Index: 706; Name: 'HasBoundWeaponEquipped'; ParamType1: ptCastingSource),
    (Index: 707; Name: 'GetCombatTargetHasKeyword'; Paramtype1: ptKeyword),    // 383
    (Index: 709; Name: 'GetCombatGroupMemberCount'),    // 384
    (Index: 710; Name: 'IsIgnoringCombat'),    // 385
    (Index: 711; Name: 'GetLightLevel'),    // 386
    (Index: 713; Name: 'SpellHasCastingPerk'; Paramtype1: ptPerk),    // 387
    (Index: 714; Name: 'IsBeingRidden'),    // 388
    (Index: 715; Name: 'IsUndead'),    // 389
    (Index: 716; Name: 'GetRealHoursPassed'),    // 390
    (Index: 718; Name: 'IsUnlockedDoor'),    // 391
    (Index: 719; Name: 'IsHostileToActor'; Paramtype1: ptActor),    // 392
    (Index: 720; Name: 'GetTargetHeight'; ParamType1: ptObjectReference),
    (Index: 721; Name: 'IsPoison'),    // 394
    (Index: 722; Name: 'WornApparelHasKeywordCount'; Paramtype1: ptKeyword),    // 395
    (Index: 723; Name: 'GetItemHealthPercent'),    // 396
    (Index: 724; Name: 'EffectWasDualCast'),    // 397
    (Index: 725; Name: 'GetKnockStateEnum'),    // 398
    (Index: 726; Name: 'DoesNotExist'),    // 399
    (Index: 728; Name: 'GetPlayerWalkAwayFromDialogueScene'),    // 400
    (Index: 729; Name: 'GetActorStance'),    // 401
    (Index: 734; Name: 'CanProduceForWorkshop'),    // 402
    (Index: 735; Name: 'CanFlyHere'),    // 403
    (Index: 736; Name: 'EPIsDamageType'; ParamType1: ptDamageType),
    (Index: 738; Name: 'GetActorGunState'),    // 405
    (Index: 739; Name: 'GetVoiceLineLength'),    // 406
    (Index: 741; Name: 'ObjectTemplateItem_HasKeyword'; Paramtype1: ptKeyword),    // 407
    (Index: 742; Name: 'ObjectTemplateItem_HasUniqueKeyword'; Paramtype1: ptKeyword),    // 408
    (Index: 743; Name: 'ObjectTemplateItem_GetLevel'),    // 409
    (Index: 744; Name: 'MovementIdleMatches'; ParamType1: ptInteger; ParamType2: ptInteger), // TODO: determine correct param types (2)
    (Index: 745; Name: 'GetActionData'),    // 411
    (Index: 746; Name: 'GetActionDataShort'; Paramtype1: ptInteger),    // 412
    (Index: 747; Name: 'GetActionDataByte'; Paramtype1: ptInteger),    // 413
    (Index: 748; Name: 'GetActionDataFlag'; Paramtype1: ptInteger),    // 414
    (Index: 749; Name: 'ModdedItemHasKeyword'; Paramtype1: ptKeyword),    // 415
    (Index: 750; Name: 'GetAngryWithPlayer'),    // 416
    (Index: 751; Name: 'IsCameraUnderWater'),    // 417
    (Index: 753; Name: 'IsActorRefOwner'; ParamType1: ptActor),
    (Index: 754; Name: 'HasActorRefOwner'; ParamType1: ptActor),
    (Index: 756; Name: 'GetLoadedAmmoCount'),    // 420
    (Index: 757; Name: 'IsTimeSpanSunrise'),    // 421
    (Index: 758; Name: 'IsTimeSpanMorning'),    // 422
    (Index: 759; Name: 'IsTimeSpanAfternoon'),    // 423
    (Index: 760; Name: 'IsTimeSpanEvening'),    // 424
    (Index: 761; Name: 'IsTimeSpanSunset'),    // 425
    (Index: 762; Name: 'IsTimeSpanNight'),    // 426
    (Index: 763; Name: 'IsTimeSpanMidnight'),    // 427
    (Index: 764; Name: 'IsTimeSpanAnyDay'),    // 428
    (Index: 765; Name: 'IsTimeSpanAnyNight'),    // 429
    (Index: 766; Name: 'CurrentFurnitureHasKeyword'; Paramtype1: ptKeyword),    // 430
    (Index: 767; Name: 'GetWeaponEquipIndex'),    // 431
    (Index: 769; Name: 'IsOverEncumbered'),    // 432
    (Index: 770; Name: 'IsPackageRequestingBlockedIdles'),    // 433
    (Index: 771; Name: 'GetActionDataInt'),    // 434
    (Index: 772; Name: 'GetVATSRightMinusLeftAreaFree'; ParamType1: ptObjectReference),
    (Index: 773; Name: 'GetInIronSights'; ParamType1: ptObjectReference),
    (Index: 774; Name: 'GetActorStaggerDirection'),    // 437
    (Index: 775; Name: 'GetActorStaggerMagnitude'),    // 438
    (Index: 776; Name: 'WornCoversBipedSlot'; Paramtype1: ptInteger),    // 439
    (Index: 777; Name: 'GetInventoryValue'),    // 440
    (Index: 778; Name: 'IsPlayerInConversation'),    // 441
    (Index: 779; Name: 'IsInDialogueCamera'),    // 442
    (Index: 780; Name: 'IsMyDialogueTargetPlayer'),    // 443
    (Index: 781; Name: 'IsMyDialogueTargetActor'),    // 444
    (Index: 782; Name: 'GetMyDialogueTargetDistance'),    // 445
    (Index: 783; Name: 'IsSeatOccupied'; Paramtype1: ptKeyword),    // 446
    (Index: 784; Name: 'IsPlayerRiding'),    // 447
    (Index: 785; Name: 'IsTryingEventCamera'),    // 448
    (Index: 786; Name: 'UseLeftSideCamera'),    // 449
    (Index: 787; Name: 'GetNoteType'),    // 450
    (Index: 788; Name: 'LocationHasPlayerOwnedWorkshop'),    // 451
    (Index: 789; Name: 'IsStartingAction'),    // 452
    (Index: 790; Name: 'IsMidAction'),    // 453
    (Index: 791; Name: 'IsWeaponChargeAttack'),    // 454
    (Index: 792; Name: 'IsInWorkshopMode'),    // 455
    (Index: 793; Name: 'IsWeaponChargingHoldAttack'),    // 456
    (Index: 794; Name: 'IsEncounterAbovePlayerLevel'),    // 457
    (Index: 795; Name: 'IsMeleeAttacking'),    // 458
    (Index: 796; Name: 'GetVATSQueuedTargetsUnique'),    // 459
    (Index: 797; Name: 'GetCurrentLocationCleared'),    // 460
    (Index: 798; Name: 'IsPowered'),    // 461
    (Index: 799; Name: 'GetTransmitterDistance'),    // 462
    (Index: 800; Name: 'GetCameraPlaybackTime'),    // 463
    (Index: 801; Name: 'IsInWater'),    // 464
    (Index: 802; Name: 'GetWithinActivateDistance'; ParamType1: ptObjectReference),
    (Index: 803; Name: 'IsUnderWater'),    // 466
    (Index: 804; Name: 'IsInSameSpace'; ParamType1: ptObjectReference),
    (Index: 805; Name: 'LocationAllowsReset'),    // 468
    (Index: 806; Name: 'GetVATSBackRightAreaFree'; ParamType1: ptObjectReference),
    (Index: 807; Name: 'GetVATSBackLeftAreaFree'; ParamType1: ptObjectReference),
    (Index: 808; Name: 'GetVATSBackRightTargetVisible'; ParamType1: ptObjectReference),
    (Index: 809; Name: 'GetVATSBackLeftTargetVisible'; ParamType1: ptObjectReference),
    (Index: 810; Name: 'GetVATSTargetLimbVisible'; ParamType1: ptObjectReference),
    (Index: 811; Name: 'IsPlayerListening'; Paramtype1: ptFloat),    // 474
    (Index: 812; Name: 'GetPathingRequestedQuickTurn'),    // 475
    (Index: 813; Name: 'EPIsCalculatingBaseDamage'),    // 476
    (Index: 814; Name: 'GetReanimating'),    // 477
    (Index: 817; Name: 'IsInRobotWorkbench')    // 478
  );

var
  wbCTDAFunctionEditInfo: string;

function wbCTDAParamDescFromIndex(aIndex: Integer): PCTDAFunction;
var
  L, H, I, C: Integer;
begin
  Result := nil;

  L := Low(wbCTDAFunctions);
  H := High(wbCTDAFunctions);
  while L <= H do begin
    I := (L + H) shr 1;
    C := CmpW32(wbCTDAFunctions[I].Index, aIndex);
    if C < 0 then
      L := I + 1
    else begin
      H := I - 1;
      if C = 0 then begin
        L := I;
        Result := @wbCTDAFunctions[L];
      end;
    end;
  end;
end;

function wbCTDACompValueDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container: IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  // "use global" flag
  if Integer(Container.ElementByName['Type'].NativeValue) and $04 <> 0 then
    Result := 1;
end;

function wbCTDAParam1Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
  ParamFlag: Byte;
  ParamType: TCTDAFunctionParamType;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['Function'].NativeValue);
  if not Assigned(Desc) then
    Exit;

  ParamType := Desc.ParamType1;
  ParamFlag := Container.ElementByName['Type'].NativeValue;

  if ParamType in [ptObjectReference, ptActor, ptPackage] then begin
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

function wbCTDAParam2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Desc: PCTDAFunction;
  Container: IwbContainer;
  ParamFlag: Byte;
  ParamType: TCTDAFunctionParamType;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  Desc := wbCTDAParamDescFromIndex(Container.ElementByName['Function'].NativeValue);
  if not Assigned(Desc) then
    Exit;

  ParamType := Desc.ParamType2;
  ParamFlag := Container.ElementByName['Type'].NativeValue;

  if ParamType in [ptObjectReference, ptActor, ptPackage] then begin
    if ParamFlag and $02 > 0 then ParamType := ptAlias else {>>> 'use aliases' is set <<<}
    if ParamFlag and $08 > 0 then ParamType := ptPackdata;  {>>> 'use packdata' is set <<<}
  end;

  Result := Succ(Integer(ParamType));
end;

function wbCTDAParam2VATSValueParamDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
begin
  Result := 0;
  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  Result := Container.ElementByName['Parameter #1'].NativeValue;
end;

function wbCTDAFunctionToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Desc : PCTDAFunction;
  i    : Integer;
begin
  Result := '';
  case aType of
    ctToStr, ctToSummary, ctToEditValue: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := Desc.Name
      else if aType in [ctToSummary, ctToEditValue] then
        Result := aInt.ToString
      else
        Result := '<Unknown: '+aInt.ToString+'>';
    end;
    ctToSortKey: Result := IntToHex(aInt, 8);
    ctCheck: begin
      Desc := wbCTDAParamDescFromIndex(aInt);
      if Assigned(Desc) then
        Result := ''
      else
        Result := '<Unknown: '+aInt.ToString+'>';
    end;
    ctEditType:
      Result := 'ComboBox';
    ctEditInfo: begin
      Result := wbCTDAFunctionEditInfo;
      if Result = '' then begin
        with TStringList.Create do try
          for i := Low(wbCTDAFunctions) to High(wbCTDAFunctions) do
            Add(wbCTDAFunctions[i].Name);
          Sort;
          Result := CommaText;
        finally
          Free;
        end;
        wbCTDAFunctionEditInfo := Result;
      end;
    end;
  end;
end;

function wbCTDAFunctionToInt(const aString: string; const aElement: IwbElement): Int64;
var
  i: Integer;
begin
  for i := Low(wbCTDAFunctions) to High(wbCTDAFunctions) do
    with wbCTDAFunctions[i] do
      if SameText(Name, aString) then begin
        Result := Index;
        Exit;
      end;

  Result := StrToInt64(aString);
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

procedure wbRemoveOFST(const aElement: IwbElement);
var
  Container: IwbContainer;
  rOFST: IwbRecord;
begin
  if not wbRemoveOffsetData then
    Exit;

  if not Supports(aElement, IwbContainer, Container) then
    Exit;

    if wbBeginInternalEdit then try
    Container.RemoveElement(OFST);
  finally
    wbEndInternalEdit;
  end else begin
    rOFST := Container.RecordBySignature[OFST];
    if Assigned(rOFST) then
      Container.RemoveElement(rOFST);
  end;
end;

procedure wbWRLDAfterLoad(const aElement: IwbElement);
  function OutOfRange(aValue: Integer; aRange: Integer = 256): Boolean;
  begin
    Result := (aValue < -aRange) or (aValue > aRange);
  end;
var
  MainRecord: IwbMainRecord;
  Container: IwbContainer;
begin
  if wbBeginInternalEdit then try

    if not Supports(aElement, IwbMainRecord, MainRecord) then
      Exit;

    if MainRecord.ElementExists['Unused RNAM'] then
      MainRecord.RemoveElement('Unused RNAM');

    //if MainRecord.ElementExists['World Default Level Data'] then
    //  MainRecord.RemoveElement('World Default Level Data');

    //if MainRecord.ElementExists['MHDT'] then
    //  MainRecord.RemoveElement('MHDT');

    if MainRecord.ElementExists['CLSZ'] then
      MainRecord.RemoveElement('CLSZ');

    // large values in object bounds cause stutter and performance issues in game (reported by Arthmoor)
    // CK can occasionally set them wrong, so make a warning
    if Supports(MainRecord.ElementByName['Object Bounds'], IwbContainer, Container) then
      if OutOfRange(StrToIntDef(Container.ElementEditValues['NAM0\X'], 0)) or
         OutOfRange(StrToIntDef(Container.ElementEditValues['NAM0\Y'], 0)) or
         OutOfRange(StrToIntDef(Container.ElementEditValues['NAM9\X'], 0)) or
         OutOfRange(StrToIntDef(Container.ElementEditValues['NAM9\Y'], 0))
      then
        wbProgressCallback('<Warning: Object Bounds in ' + MainRecord.Name + ' are abnormally large and can cause performance issues in game>');

  finally
    wbEndInternalEdit;
  end;
end;

procedure wbDOBJObjectsAfterLoad(const aElement: IwbElement);
var
  ObjectsContainer : IwbContainerElementRef;
  i                : Integer;
  ObjectContainer  : IwbContainerElementRef;
begin
  wbRemoveOFST(aElement);

  if wbBeginInternalEdit then try

    if not Supports(aElement, IwbContainerElementRef, ObjectsContainer) then
      Exit;

    for i := Pred(ObjectsContainer.ElementCount) downto 0 do
      if Supports(ObjectsContainer.Elements[i], IwbContainerElementRef, ObjectContainer) then
        if ObjectContainer.ElementNativeValues['Use'] = 0 then
          ObjectsContainer.RemoveElement(i, True);
  finally
    wbEndInternalEdit;
  end;
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

function wbActorTemplatesUseTemplate0(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 0 and 1) = 0;
end;

function wbActorTemplatesUseTemplate1(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 1 and 1) = 0;
end;

function wbActorTemplatesUseTemplate2(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 2 and 1) = 0;
end;

function wbActorTemplatesUseTemplate3(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 3 and 1) = 0;
end;

function wbActorTemplatesUseTemplate4(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 4 and 1) = 0;
end;

function wbActorTemplatesUseTemplate5(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 5 and 1) = 0;
end;

function wbActorTemplatesUseTemplate6(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 6 and 1) = 0;
end;

function wbActorTemplatesUseTemplate7(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 7 and 1) = 0;
end;

function wbActorTemplatesUseTemplate8(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 8 and 1) = 0;
end;

function wbActorTemplatesUseTemplate9(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 9 and 1) = 0;
end;

function wbActorTemplatesUseTemplate10(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 10 and 1) = 0;
end;

function wbActorTemplatesUseTemplate11(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 11 and 1) = 0;
end;

function wbActorTemplatesUseTemplate12(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 12 and 1) = 0;
end;


function wbActorTemplatesUseTemplateAny(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) = 0;
end;

procedure wbRemoveEmptyKWDA(const aElement: IwbElement);
var
  Container  : IwbContainerElementRef;
  MainRecord : IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if Assigned(Container.ElementBySignature['KSIZ']) then
      Exit;

  if Assigned(Container.ElementBySignature['KWDA']) then
    Container.ElementBySignature['KWDA'].Remove;
  finally
    wbEndInternalEdit;
  end;
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
  wbRemoveEmptyKWDA(aElement);
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
  wbRemoveEmptyKWDA(aElement);
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
  wbRemoveEmptyKWDA(aElement);

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

procedure wbLIGHAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainerElementRef;
  MainRecord   : IwbMainRecord;
begin
  if wbBeginInternalEdit then try
    if not wbTryGetContainerWithValidMainRecord(aElement, Container, MainRecord) then
      Exit;

    if not Container.ElementExists['FNAM'] then begin
      Container.Add('FNAM', True);
      Container.ElementNativeValues['FNAM'] := 1.0;
    end;

    if not Container.ElementExists['DATA'] then
      Exit;

      if SameValue(Container.ElementNativeValues['DATA\Falloff Exponent'], 0.0) then
        Container.ElementNativeValues['DATA\Falloff Exponent'] := 1.0;

      if SameValue(Container.ElementNativeValues['DATA\FOV'], 0.0) then
        Container.ElementNativeValues['DATA\FOV'] := 90.0;
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

procedure wbRPLDAfterLoad(const aElement: IwbElement);
var
  Container: IwbContainer;
  a, b: Single;
  NeedsFlip: Boolean;
begin
  if wbBeginInternalEdit then try
    if not Supports(aElement, IwbContainer, Container) then
      Exit;

    NeedsFlip := False;

    if Container.ElementCount > 1 then begin
      a := StrToFloat((Container.Elements[0] as IwbContainer).Elements[0].Value);
      b := StrToFloat((Container.Elements[Pred(Container.ElementCount)] as IwbContainer).Elements[0].Value);

      case CompareValue(a, b) of
        EqualsValue: begin
          a := StrToFloat((Container.Elements[0] as IwbContainer).Elements[1].Value);
          b := StrToFloat((Container.Elements[Pred(Container.ElementCount)] as IwbContainer).Elements[1].Value);
          NeedsFlip := CompareValue(a, b) = GreaterThanValue;
        end;
        GreaterThanValue:
          NeedsFlip := True;
      end;
    end;

    if NeedsFlip then
      Container.ReverseElements;
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

procedure wbIDLAsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Element         : IwbElement;
  Container       : IwbContainer;
  SelfAsContainer : IwbContainer;
begin
  if wbBeginInternalEdit(True) then try
    if wbCounterAfterSet('IDLC - Animation Count', aElement) then
      Exit;

    if not Supports(aElement.Container, IwbContainer, Container) then
      Exit;

    Element := Container.ElementByPath['IDLC'];
    if Assigned(Element) and Supports(aElement, IwbContainer, SelfAsContainer) and
      (Element.GetNativeValue<>SelfAsContainer.GetElementCount) then
      Element.SetNativeValue(SelfAsContainer.GetElementCount);
  finally
    wbEndInternalEdit;
  end;
end;

procedure wbAnimationsAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Element         : IwbElement;
  Elems           : IwbElement;
  Container       : IwbContainer;
begin
  if wbBeginInternalEdit(True) then try
    if wbCounterContainerAfterSet('IDLC - Animation Count', 'IDLA - Animations', aElement) then
      Exit;

    if not Supports(aElement, IwbContainer, Container) then
      Exit;

    Element := Container.ElementByPath['IDLC\Animation Count'];
    Elems   := Container.ElementByName['IDLA - Animations'];

    if Assigned(Element) and not Assigned(Elems) then
      if Element.GetNativeValue <> 0 then
        Element.SetNativeValue(0);
  finally
    wbEndInternalEdit;
  end;
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
      ctEditInfo: Result := PropEnum.EditInfo[aInt, aElement].ToCommaText;
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
var
  Container     : IwbContainer;
  ValueType     : Integer;
  PropName      : string;
begin
  Result := 0;

  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  ValueType := Container.ElementNativeValues['Value Type'];
  PropName := Container.ElementEditValues['Property'];

  case ValueType of
    0: Result := 1;
    1: Result := 2;
    2: Result := 3;
    4, 6: Result := 4;
    5: begin
      if PropName = 'SoundLevel'    then Result := 6 else
      if PropName = 'StaggerValue'  then Result := 7 else
      if PropName = 'HitBehaviour'  then Result := 8 else
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

      Result := 'Precombined\' + MasterFolder + Cell.FormID.ChangeFileID(TwbFileID.Create(0)).ToString(False) + '_' + Result + '_OC.nif';
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

function wbWeatherColors(const aName: string): IwbValueDef;
begin
  Result := wbStruct(aName, [
    wbByteColors('Sunrise'),      //0
    wbByteColors('Day'),          //1
    wbByteColors('Sunset'),       //2
    wbByteColors('Night'),        //3
    wbFromVersion(111, wbByteColors('EarlySunrise')), //4
    wbFromVersion(111, wbByteColors('LateSunrise')),  //5
    wbFromVersion(111, wbByteColors('EarlySunset')),  //6
    wbFromVersion(111, wbByteColors('LateSunset'))    //7
  ], cpNormal, True)
    .SetSummaryKey([4, 0, 5, 1, 6, 2, 7, 3])
    .SetSummaryMemberPrefixSuffix(4, 'ESR:', '')
    .SetSummaryMemberPrefixSuffix(0, 'SR:', '')
    .SetSummaryMemberPrefixSuffix(5, 'LSR:', '')
    .SetSummaryMemberPrefixSuffix(1, 'D:', '')
    .SetSummaryMemberPrefixSuffix(6, 'ESS:', '')
    .SetSummaryMemberPrefixSuffix(2, 'SS:', '')
    .SetSummaryMemberPrefixSuffix(7, 'LSS:', '')
    .SetSummaryMemberPrefixSuffix(3, 'N:', '')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfHideText);
end;

function wbAmbientColors(const aName: string = 'Directional Ambient Lighting Colors'): IwbStructDef; overload;
begin
  Result := wbStruct(aName, [
    wbStruct('Directional', [
      wbByteColors('X+'),
      wbByteColors('X-'),
      wbByteColors('Y+'),
      wbByteColors('Y-'),
      wbByteColors('Z+'),
      wbByteColors('Z-')
    ]),
    wbByteColors('Specular'),
    wbFloat('Scale', cpIgnore).SetDefaultNativeValue(1.0)
  ]);
end;


function wbAmbientColors(const aSignature: TwbSignature; const aName: string = 'Directional Ambient Lighting Colors'): IwbSubRecordDef; overload;
begin
  Result := wbSubRecord(aSignature, aName, wbAmbientColors(aName));
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
          Result := Result  + ' <Morph index not found in ' + Race.Name + '>';
      end;
    end;
    ctCheck: begin
      if EntryName = '' then
        Result := '<Morph index ' + IntToHex(aInt, 8) + ' not found in ' + Race.Name + '>'
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
          Result := Result + ' <Face morph index not found in ' + Race.Name + '>';
      end;
    end;
    ctCheck: begin
      if EntryName = '' then
        Result := '<Face morph index ' + IntToHex(aInt, 8) + ' not found in ' + Race.Name + '>'
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
          Result := Result + ' <Tint layer index not found in ' + Race.Name + '>';
      end;
    end;
    ctCheck: begin
      if EntryName = '' then
        Result := '<Tint layer index ' + aInt.ToString + ' not found in ' + Race.Name + '>'
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

var
  wbRecordFlagsFlags, wbEmptyBaseFlags : IwbFlagsDef;

procedure DefineSF1a;
begin
  wbNull := wbByteArray('Unused', -255);
  wbLLCT := wbInteger(LLCT, 'Count', itU8, nil, cpBenign);
  wbCITC := wbInteger(CITC, 'Condition Count', itU32, nil, cpBenign);
  wbCITCReq := wbInteger(CITC, 'Condition Count', itU32, nil, cpBenign, True);
  wbLVLD := wbFloat(LVLD, 'Chance None', cpNormal, True);

  wbSPCT := wbInteger(SPCT, 'Count', itU32, nil, cpBenign);
  wbSPLO := wbFormIDCk(SPLO, 'Actor Effect', [SPEL, LVSP]);
  wbSPLOs := wbRArrayS('Actor Effects', wbSPLO, cpNormal, False, nil, wbSPLOsAfterSet, nil{wbActorTemplateUseActorEffectList});

  wbKSIZ := wbInteger(KSIZ, 'Keyword Count', itU32, nil, cpBenign);
  wbKWDAs := wbArrayS(KWDA, 'Keywords', wbFormIDCk('Keyword', [KYWD, NULL]), 0, cpNormal, False, nil, wbKWDAsAfterSet);
  wbReqKWDAs := wbArrayS(KWDA, 'Keywords', wbFormIDCk('Keyword', [KYWD, NULL]), 0, cpNormal, True, nil, wbKWDAsAfterSet);

  wbKeywords := wbRStruct('Keywords', [
    wbKSIZ,
    wbReqKWDAs
  ], []);

  wbCVPA := wbStructs(CVPA, 'Components', 'Component', [
      wbFormIDCk('Component', sigBaseObjects), // CK allows only CMPO
      wbInteger('Count', itU32),
      wbUnknown(4)
    ]);

  //wbActorValue := wbInteger('Actor Value', itS32, wbActorValueEnum);
  wbActorValue := wbFormIDCkNoReach('Actor Value', [AVIF, NULL]);

  wbCOED := wbStructExSK(COED, [2], [0, 1], 'Extra Data', [
    {00} wbFormIDCkNoReach('Owner', [NPC_, FACT, NULL]),
    {04} wbUnion('Global Variable / Required Rank', wbCOEDOwnerDecider, [
           wbByteArray('Unused', 4, cpIgnore),
           wbFormIDCk('Global Variable', [GLOB, NULL]),
           wbInteger('Required Rank', itS32)
         ]),
    {08} wbFloat('Item Condition')
  ]);

  wbCNTO :=
    wbRStructExSK([0], [1], 'Item', [
      wbStructExSK(CNTO, [0], [1], 'Item', [
        wbFormIDCk('Item', sigBaseObjects),
        wbInteger('Count', itS32)
      ]),
      wbCOED
    ], []).SetToStr(wbItemToStr).IncludeFlag(dfCollapsed, wbCollapseItems);

  wbCOCT := wbInteger(COCT, 'Count', itU32, nil, cpBenign);
  wbCNTOs := wbRArrayS('Items', wbCNTO, cpNormal, False, nil, wbCNTOsAfterSet);

  wbContainerItems := wbRStruct('Container Items', [
    wbCOCT,
    wbCNTOs.SetRequired
  ], []);

  wbWED01 := wbRStruct('Unknown', [
    wbUnknown(WED0).SetRequired,
    wbUnknown(WED1).SetRequired
  ], []);

  wbPUSHPDSH := wbRStruct('Unknown', [
    wbUnknown(PUSH).SetRequired,
    wbUnknown(PDSH).SetRequired
  ], []);

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

  wbFirstPersonFlagsU32 := wbInteger('First Person Flags', itU32, wbBipedObjectFlags);

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
    ], True)),
    wbInteger('Alpha Threshold?', itU16),
    wbByteColors('Color')
  ]);

//  wbRecordFlagsFlags := wbFlags([
//    {>>> 0x00000000 ACTI: Collision Geometry (default) <<<}
//    {0x00000001}'ESM',
//    {0x00000002}'Unknown 2',
//    {>>> 0x00000004 ARMO: Not playable <<<}
//    {0x00000004}'NotPlayable',
//    {0x00000008}'Unknown 4',
//    {0x00000010}'Unknown 5',
//    {0x00000020}'Deleted',
//    {>>> 0x00000040 ACTI: Has Tree LOD <<<}
//    {>>> 0x00000040 REGN: Border Region <<<}
//    {>>> 0x00000040 STAT: Has Tree LOD <<<}
//    {>>> 0x00000040 REFR: Hidden From Local Map <<<}
//    {0x00000040}'Constant HiddenFromLocalMap BorderRegion HasTreeLOD',
//    {>>> 0x00000080 TES4: Localized <<<}
//    {>>> 0x00000080 PHZD: Turn Off Fire <<<}
//    {>>> 0x00000080 SHOU: Treat Spells as Powers <<<}
//    {>>> 0x00000080 STAT: Add-on LOD Object <<<}
//    {0x00000080}'Localized IsPerch AddOnLODObject TurnOffFire TreatSpellsAsPowers',
//    {>>> 0x00000100 ACTI: Must Update Anims <<<}
//    {>>> 0x00000100 REFR: Inaccessible <<<}
//    {>>> 0x00000100 REFR for LIGH: Doesn't light water <<<}
//    {0x00000100}'MustUpdateAnims Inaccessible DoesntLightWater',
//    {>>> 0x00000200 ACTI: Local Map - Turns Flag Off, therefore it is Hidden <<<}
//    {>>> 0x00000200 REFR: MotionBlurCastsShadows <<<}
//    {0x00000200}'HiddenFromLocalMap StartsDead MotionBlurCastsShadows',
//    {>>> 0x00000400 LSCR: Displays in Main Menu <<<}
//    {0x00000400}'PersistentReference QuestItem DisplaysInMainMenu',
//    {0x00000800}'InitiallyDisabled',
//    {0x00001000}'Ignored',
//    {0x00002000}'ActorChanged',
//    {0x00004000}'Unknown 15',
//    {>>> 0x00008000 STAT: Has Distant LOD <<<}
//    {0x00008000}'VWD',
//    {>>> 0x00010000 ACTI: Random Animation Start <<<}
//    {>>> 0x00010000 REFR light: Never fades <<<}
//    {0x00010000}'RandomAnimationStart NeverFades',
//    {>>> 0x00020000 ACTI: Dangerous <<<}
//    {>>> 0x00020000 REFR light: Doesn't light landscape <<<}
//    {>>> 0x00020000 SLGM: Can hold NPC's soul <<<}
//    {>>> 0x00020000 STAT: Use High-Detail LOD Texture <<<}
//    {0x00020000}'Dangerous OffLimits DoesntLightLandscape HighDetailLOD CanHoldNPC',
//    {0x00040000}'Compressed',
//    {>>> 0x00080000 STAT: Has Currents <<<}
//    {0x00080000}'CantWait HasCurrents',
//    {>>> 0x00100000 ACTI: Ignore Object Interaction <<<}
//    {0x00100000}'IgnoreObjectInteraction',
//    {0x00200000}'(Used in Memory Changed Form)',
//    {0x00400000}'Unknown 23',
//    {>>> 0x00800000 ACTI: Is Marker <<<}
//    {0x00800000}'IsMarker',
//    {0x01000000}'Unknown 25',
//    {>>> 0x02000000 ACTI: Obstacle <<<}
//    {>>> 0x02000000 REFR: No AI Acquire <<<}
//    {0x02000000}'Obstacle NoAIAcquire',
//    {>>> 0x04000000 ACTI: Filter <<<}
//    {0x04000000}'NavMeshFilter',
//    {>>> 0x08000000 ACTI: Bounding Box <<<}
//    {0x08000000}'NavMeshBoundingBox',
//    {>>> 0x10000000 STAT: Show in World Map <<<}
//    {0x10000000}'MustExitToTalk ShowInWorldMap',
//    {>>> 0x20000000 ACTI: Child Can Use <<<}
//    {>>> 0x20000000 REFR: Don't Havok Settle <<<}
//    {0x20000000}'ChildCanUse DontHavokSettle',
//    {>>> 0x40000000 ACTI: GROUND <<<}
//    {>>> 0x40000000 REFR: NoRespawn <<<}
//    {0x40000000}'NavMeshGround NoRespawn',
//    {>>> 0x80000000 REFR: MultiBound <<<}
//    {0x80000000}'MultiBound'
//  ], [18]);

  wbRecordFlagsFlags := wbFlags(wbRecordFlagsFlags, [
    {0x00000001} { 0} 'Unknown 0',
    {0x00000002} { 1} 'Unknown 1',
    {0x00000004} { 2} 'Unknown 2',
    {0x00000008} { 3} 'Unknown 3',
    {0x00000010} { 4} 'Unknown 4',
    {0x00000020} { 4} 'Unknown 5',
    {0x00000040} { 6} 'Unknown 6',
    {0x00000080} { 7} 'Unknown 7',
    {0x00000100} { 8} 'Unknown 8',
    {0x00000200} { 9} 'Unknown 9',
    {0x00000400} {10} 'Unknown 10',
    {0x00000800} {11} 'Unknown 11',
    {0x00001000} {12} 'Unknown 12',
    {0x00002000} {13} 'Unknown 13',
    {0x00004000} {14} 'Unknown 14',
    {0x00008000} {15} 'Unknown 15',
    {0x00010000} {16} 'Unknown 16',
    {0x00020000} {17} 'Unknown 17',
    {0x00040000} {18} 'Unknown 18',
    {0x00080000} {19} 'Unknown 19',
    {0x00100000} {20} 'Unknown 20',
    {0x00200000} {21} 'Unknown 21',
    {0x00400000} {22} 'Unknown 22',
    {0x00800000} {23} 'Unknown 23',
    {0x01000000} {24} 'Unknown 24',
    {0x02000000} {25} 'Unknown 25',
    {0x04000000} {26} 'Unknown 26',
    {0x08000000} {27} 'Unknown 27',
    {0x10000000} {28} 'Unknown 28',
    {0x20000000} {29} 'Unknown 29',
    {0x40000000} {30} 'Unknown 30',
    {0x80000000} {31} 'Unknown 31'
  ]);

  wbEmptyBaseFlags := wbFlags(wbEmptyBaseFlags, [
    {0x00000001} { 0} 'Unknown 0',
    {0x00000002} { 1} 'Unknown 1',
    {0x00000004} { 2} 'Unknown 2',
    {0x00000008} { 3} 'Unknown 3',
    {0x00000010} { 4} 'Unknown 4',
    {0x00000020} { 4} 'Unknown 5',
    {0x00000040} { 6} 'Unknown 6',
    {0x00000080} { 7} 'Unknown 7',
    {0x00000100} { 8} 'Unknown 8',
    {0x00000200} { 9} 'Unknown 9',
    {0x00000400} {10} 'Unknown 10',
    {0x00000800} {11} 'Unknown 11',
    {0x00001000} {12} 'Unknown 12',
    {0x00002000} {13} 'Unknown 13',
    {0x00004000} {14} 'Unknown 14',
    {0x00008000} {15} 'Unknown 15',
    {0x00010000} {16} 'Unknown 16',
    {0x00020000} {17} 'Unknown 17',
    {0x00040000} {18} 'Unknown 18',
    {0x00080000} {19} 'Unknown 19',
    {0x00100000} {20} 'Unknown 20',
    {0x00200000} {21} 'Unknown 21',
    {0x00400000} {22} 'Unknown 22',
    {0x00800000} {23} 'Unknown 23',
    {0x01000000} {24} 'Unknown 24',
    {0x02000000} {25} 'Unknown 25',
    {0x04000000} {26} 'Unknown 26',
    {0x08000000} {27} 'Unknown 27',
    {0x10000000} {28} 'Unknown 28',
    {0x20000000} {29} 'Unknown 29',
    {0x40000000} {30} 'Unknown 30',
    {0x80000000} {31} 'Unknown 31'
  ]);

  wbRecordFlags := wbInteger('Record Flags', itU32, wbFlags(wbRecordFlagsFlags, wbFlagsList([])));

  wbMainRecordHeader := wbRecordHeader(wbRecordFlags);

  wbSizeOfMainRecordStruct := 24;

  wbIgnoreRecords.Add(XXXX);

  wbXRGD := wbArray(XRGD, 'Ragdoll Data', wbStruct('Ragdoll Data', [
    wbInteger('Bone Id', itU8),
    wbByteArray('Unknown/Unused', 3),
    wbPosRot
  ]));

  wbXRGB := wbStruct(XRGB, 'Ragdoll Biped Rotation', [
    wbFloat('X'),
    wbFloat('Y'),
    wbFloat('Z')
  ]);

  wbMusicEnum := wbEnum(['Default', 'Public', 'Dungeon']);
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

  wbFurnitureEntryTypeFlags := wbFlags([
    {0x01} 'Front',
    {0x02} 'Behind',
    {0x04} 'Right',
    {0x08} 'Left',
    {0x10} 'Up'
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
  // Event member names and availability are different depending on event type
  // Using generic names for the last 3 of them: Form, Value1, Value2
  wbEventMemberEnum := wbEnum([], [
    $0000, 'None',
    $3146, 'Form',          { F1: ObjectForm, SpellForm, Infection, pCrimeGroup, Weapon Aimed, Voice Power }
    $3147, 'Global',        { G1: GlobalValue }
    $3149, 'Identifier',    { I1: QuestID }
    $314B, 'Keyword1',      { K1: GameModeKeyword, Keyword }
    $324B, 'Keyword2',      { K2: (Exists but unused) }
    $334B, 'Keyword3',      { K3: (Exists but unused) }
    $314C, '(Old)Location',  { L1: Location, Old Location, BenchLocation }
    $324C, '(New)Location',  { L2: New Location }
    $314F, 'CreatedObject', { O1: CreatedObject }
    $3150, 'Player1',       { P1: Player, Victim }
    $3250, 'Player2',       { P2: Criminal }
    $3251, 'Quest1',        { Q1: Quest }
    $3152, 'Reference1',    { R1: Victim, OwnerRef, ArrestingGuard, ActorSeesObject, Actor, CastingActor, Workbench, Actor 1, Actor , Computer, Transmitting Actor, Actor in Ironsights, hGuard, hCriminal, RootObject, NPC 1, Ref 1, OwningActor }
    $3252, 'Reference2',    { R2: Attacker, Killer, Mine, OriginalContainer, Criminal, Object, SpellTarget, Actor 2, Dead Actor, hGuard, Lock Object, NPC 2, ItemRef, Ref 2, Trespasser }
    $3352, 'Reference3',    { R3: Workshop, Player }
    $3156, 'Value1',        { V1: Crime, Crime Status, AquireType, iCrimeType, iCommanded, iBountyAmount, Gold Value, Success, New Level, Crime Gold, Is Crime, Connected, Old Relationship, RemoveType, Value 1 }
    $3256, 'Value2',        { V2: Relationship Rank to Killer Before Death, ItemValue, iBountyReason, New Relationship, Value 2, Days Jail }
    $7FFFFFFF, 'All'
  ]);

  wbWeaponAnimTypeEnum := wbEnum([
    {0} 'HandToHandMelee',
    {1} 'OneHandSword',
    {2} 'OneHandDagger',
    {3} 'OneHandAxe',
    {4} 'OneHandMace',
    {5} 'TwoHandSword',
    {6} 'TwoHandAxe',
    {7} 'Bow',
    {8} 'Staff',
    {9} 'Crossbow'
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
    'No dismember or explode'
  ]);

  wbLGDIStarSlot := wbEnum([
    'First Star Slot',
    'Second Star Slot',
    'Third Star Slot',
    'Fourth Star Slot',
    'Fifth Star Slot'
  ]);

  wbEDID := wbStringKC(EDID, 'Editor ID', 0, cpOverride);
  wbFULL := wbLStringKC(FULL, 'Name', 0, cpTranslate);
  wbFULLActor := wbLStringKC(FULL, 'Name', 0, cpTranslate, False, nil{wbActorTemplateUseBaseData});
  wbFULLReq := wbLStringKC(FULL, 'Name', 0, cpTranslate, True);
  wbDESC := wbLStringKC(DESC, 'Description', 0, cpTranslate);
  wbDESCReq := wbLStringKC(DESC, 'Description', 0, cpTranslate, True);
  wbXSCL := wbFloat(XSCL, 'Scale');
  wbXALGFlags := wbFlags([ //copied from FO76, probably wrong
    {0x00000001} 'Unknown 1 (No Havok??)',
    {0x00000002} 'Unknown 2',
    {0x00000004} 'Unknown 3 (Reference??)',
    {0x00000008} 'Unknown 4',
    {0x00000010} 'Unknown 5',
    {0x00000020} 'Unknown 6', //Unused
    {0x00000040} 'Unknown 7',
    {0x00000080} 'Unknown 8',
    {0x00000100} 'Atom Shop Item',
    {0x00000200} 'Unknown 10',
    {0x00000400} 'Unknown 11',
    {0x00000800} 'Fallout 1st',
    {0x00001000} 'Unknown 13',
    {0x00002000} 'Unknown 14',
    {0x00004000} 'Unknown 15', //Unused
    {0x00008000} 'Unknown 16', //Unused
    {0x00010000} 'Unknown 17', //Unused
    {0x00020000} 'Unknown 18', //Unused
    {0x00040000} 'Unknown 19', //Unused
    {0x00080000} 'Unknown 20', //Unused
    {0x00100000} 'Unknown 21', //Unused
    {0x00200000} 'Unknown 22', //Unused
    {0x00400000} 'Unknown 23', //Unused
    {0x00800000} 'Unknown 24', //Unused
    {0x01000000} 'Unknown 25', //Unused
    {0x02000000} 'Unknown 26', //Unused
    {0x04000000} 'Unknown 27', //Unused
    {0x08000000} 'Unknown 28', //Unused
    {0x10000000} 'Unknown 29', //Unused
    {0x20000000} 'Unknown 30', //Unused
    {0x40000000} 'Unknown 31', //Unused
    {0x80000000} 'Unknown 32'  //Unused
  ]);

  wbXALG := wbInteger(XALG, 'Flags', itU64, wbXALGFlags);

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
      wbInteger('Alias', itS16, wbScriptObjectAliasToStr, wbStrToAlias).SetDefaultEditValue('None'),
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
      wbInteger('Alias', itS16, wbScriptObjectAliasToStr, wbStrToAlias),
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
        {06} wbRecursive('Struct', 3), // Variable. No idea if possible or how to decode, leaving like that for the moment
        {07} wbRecursive('Struct', 3),
        {11} wbArray('Array of Object', wbScriptPropertyObject, -1),
        {12} wbArray('Array of String', wbLenString('Element', 2).OverrideEncoding(wbEncodingVMAD), -1),
        {13} wbArray('Array of Int32', wbInteger('Element', itS32), -1),
        {14} wbArray('Array of Float', wbFloat('Element'), -1),
        {15} wbArray('Array of Bool', wbInteger('Element', itU8, wbBoolEnum), -1),
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
       {06} wbScriptPropertyStruct, // Variable. No idea if possible or how to decode, leaving like that for the moment
       {07} wbScriptPropertyStruct,
       {11} wbArray('Array of Object', wbScriptPropertyObject, -1),
       {12} wbArray('Array of String', wbLenString('Element', 2).OverrideEncoding(wbEncodingVMAD), -1),
       {13} wbArray('Array of Int32', wbInteger('Element', itS32), -1),
       {14} wbArray('Array of Float', wbFloat('Element'), -1),
       {15} wbArray('Array of Bool', wbInteger('Element', itU8, wbBoolEnum), -1),
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
  .IncludeFlag(dfSummaryMembersNoName);

  wbScriptFragmentsInfo := wbStruct('Script Fragments', [
    wbInteger('Extra bind data version', itS8).SetDefaultNativeValue(3),
    wbInteger('Flags', itU8, wbFlags([
      {1} 'OnBegin',
      {2} 'OnEnd'
    ])),
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
    ])),
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
      , wbScriptFragmentsQuestCounter).SetAfterSet(wbScriptFragmentsQuestFragmentsAfterSet)
  ])
  .SetSummaryKey([2, 3])
  .IncludeFlag(dfSummaryMembersNoName)
  .SetAfterSet(wbScriptFragmentsQuestAfterSet);

  wbScriptFragmentsScen := wbStruct('Script Fragments', [
    wbInteger('Extra bind data version', itS8).SetDefaultNativeValue(3),
    wbInteger('Flags', itU8, wbFlags([
      {1} 'OnBegin',
      {2} 'OnEnd'
    ])),
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
        ])),
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
      wbScriptPropertyObject,
      wbVMADVersion,
      wbVMADObjectFormat,
      wbArrayS('Alias Scripts', wbScriptEntry, -2)
    ]), -2)
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
      ])),
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
  ], []);

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
      {7} wbByteArray('Unused', 4, cpIgnore),
      {8} wbInteger('Ref Alias', itS32, wbPackageLocationAliasToStr, wbStrToAlias),
      {9} wbInteger('Loc Alias', itS32, wbPackageLocationAliasToStr, wbStrToAlias),
     {10} wbInteger('Interrupt Data', itU32),
     {11} wbInteger('Packdata Target', itU32),
     {12} wbByteArray('Unknown', 4, cpIgnore),
     {13} wbByteArray('Unknown', 4),
     {14} wbInteger('Ref Collection Alias', itS32, wbPackageLocationAliasToStr, wbStrToAlias)
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
      {7} wbByteArray('Unused', 4, cpIgnore),
      {8} wbInteger('Ref Alias', itS32, wbPackageLocationAliasToStr, wbStrToAlias),
      {9} wbInteger('Loc Alias', itS32, wbPackageLocationAliasToStr, wbStrToAlias),
     {10} wbInteger('Interrupt Data', itU32),
     {11} wbInteger('Packdata Target', itU32),
     {12} wbByteArray('Unknown', 4, cpIgnore),
     {13} wbByteArray('Unknown', 4),
     {14} wbInteger('Ref Collection Alias', itS32, wbPackageLocationAliasToStr, wbStrToAlias)
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
      {4} wbInteger('Alias', itS32, wbPackageLocationAliasToStr, wbStrToAlias),
      {5} wbInteger('Interrupt Data', itU32),
      {6} wbByteArray('Unknown', 4, cpIgnore),
      {7} wbFormIDCk('Keyword', [KYWD, NULL]),
      {8} wbByteArray('Unknown', 4, cpIgnore)
    ]),
    wbInteger('Count / Distance', itS32)
  ]);

  wbEITM := wbFormIDCk(EITM, 'Object Effect', [ENCH, SPEL]);

  wbMODS := wbFormIDCk(MODS, 'Material Swap', [MSWP]);
  wbMO2S := wbFormIDCk(MO2S, 'Material Swap', [MSWP]);
  wbMO3S := wbFormIDCk(MO3S, 'Material Swap', [MSWP]);
  wbMO4S := wbFormIDCk(MO4S, 'Material Swap', [MSWP]);
  wbMO5S := wbFormIDCk(MO5S, 'Material Swap', [MSWP]);

  wbModelFlags := wbFlags([
    'Has FaceBones Model',
    'Has 1stPerson Model'
  ]);
  wbMODF := wbInteger(MODF, 'Flags', itU8, wbModelFlags);
  wbMO2F := wbInteger(MO2F, 'Flags', itU8, wbModelFlags);
  wbMO3F := wbInteger(MO3F, 'Flags', itU8, wbModelFlags);
  wbMO4F := wbInteger(MO4F, 'Flags', itU8, wbModelFlags);
  wbMO5F := wbInteger(MO5F, 'Flags', itU8, wbModelFlags);
  wbMO6F := wbInteger(MO6F, 'Flags', itU8, wbModelFlags);
  wbMO7F := wbInteger(MO7F, 'Flags', itU8, wbModelFlags);

  wbMODC := wbFloat(MODC, 'Color Remapping Index');
  wbMO2C := wbFloat(MO2C, 'Color Remapping Index');
  wbMO3C := wbFloat(MO3C, 'Color Remapping Index');
  wbMO4C := wbFloat(MO4C, 'Color Remapping Index');
  wbMO5C := wbFloat(MO5C, 'Color Remapping Index');

  wbDMDS := wbFormIDCk(DMDS, 'Material Swap', [MSWP]);
  wbDMDC := wbFloat(DMDC, 'Color Remapping Index');

  {subrecords checked against Starfield.esm}
  wbDEST := wbRStruct('Destructible', [
    wbStruct(DEST, 'Header', [
      wbInteger('Health', itS32),
      wbInteger('DEST Count', itU8),
      wbInteger('Flags', itU8, wbFlags([
        'VATS Targetable',
        'Large Actor Destroys'
      ])),
      wbByteArray('Unknown', 2)
    ]),
    wbArrayS(DAMC, 'Resistances', wbStructSK([0], 'Resistance', [
      wbFormIDCk('Damage Type', [DMGT]),
      wbInteger('Value', itU32),
      wbUnknown(4)
    ])),
    wbFormIDCk(DSDL, 'Unknown', [SDLT]),
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
          ])),
          wbInteger('Self Damage per Second', itS32),
          wbFormIDCk('Explosion', [EXPL, NULL]),
          wbFormIDCk('Debris', [DEBR, NULL]),
          wbInteger('Debris Count', itS32),
          wbUnknown {whole thing needs to be checked for Starfield}
        ], cpNormal, True),
        wbString(DSTA, 'Sequence Name'),
        wbRStructSK([0], 'Model', [
          wbString(DMDL, 'Model FileName', 0, cpNormal, True),
          wbUnknown(FLLD),
//          wbDMDT,
//          wbDMDC,
          wbDMDS
        ], [], cpNormal, False, nil, True),
        wbEmpty(DSTF, 'End Marker', cpNormal, True)
      ], [], cpNormal, False, nil)
    )
  ], [], cpNormal, False, nil);

  wbDESTActor := wbRStruct('Destructible', [
    wbStruct(DEST, 'Header', [
      wbInteger('Health', itS32),
      wbInteger('Count', itU8),
      wbInteger('VATS Targetable', itU8, wbBoolEnum),
      wbByteArray('Unknown', 2)
    ]),
    wbRArray('Stages',  // Begin Stage Array
      wbRStruct('Stage', [ // Begin Stage RStruct
        wbStruct(DSTD, 'Destruction Stage Data', [ // Begin DSTD
          wbInteger('Health %', itU8),
          wbInteger('Index', itU8),
          wbInteger('Damage Stage', itU8),
          wbInteger('Flags', itU8, wbFlags([
            'Cap Damage',
            'Disable',
            'Destroy'
          ])),
          wbInteger('Self Damage per Second', itS32),
          wbFormIDCk('Explosion', [EXPL, NULL]),
          wbFormIDCk('Debris', [DEBR, NULL]),
          wbInteger('Debris Count', itS32)
        ], cpNormal, True), // End DSTD
        wbRStructSK([0], 'Model', [ // Begin DMDL
          wbString(DMDL, 'Model FileName')
        ], []), // End DMDL
        wbDMDT,
        wbDMDC,
        wbDMDS,
        wbEmpty(DSTF, 'End Marker', cpNormal, True)
      ], []) // Begin Stage RStruct
    ) // End Stage Array
  ], [], cpNormal, False, nil{wbActorTemplateUseModelAnimation});

  wbXESP := wbStruct(XESP, 'Enable Parent', [
    wbFormIDCk('Reference', sigReferences),
    wbInteger('Flags', itU8, wbFlags([
      'Set Enable State to Opposite of Parent',
      'Pop In'
    ])),
    wbByteArray('Unused', 3, cpIgnore)
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

  wbSNTP := wbFormIDCk(SNTP, 'Snap Template', [STMP]);
  wbSNBH := wbFormIDCk(SNBH, 'Unknown', [STBH]);
  wbODTY := wbFloat(ODTY, 'Unknown');
  wbOPDS := wbUnknown(OPDS);
  wbDEFL := wbFormIDCk(DEFL, 'Default Layer', [LAYR]);

// PTT2 is some kind of transform list
  wbPTT2 := wbArray(PTT2, 'Unknown', wbFormIDCk('Unknown', [NULL, TRNS]), 8);

  wbXLCM := wbInteger(XLCM, 'Level Modifier', itS32, wbEnum([
    'Easy',
    'Medium',
    'Hard',
    'Very Hard'
  ]));

  if wbSimpleRecords then begin
    wbMaxHeightDataCELL := wbByteArray(MHDT, 'Max Height Data', 0, cpNormal);
    wbMaxHeightDataWRLD := wbByteArray(MHDT, 'Max Height Data', 0, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT]);
  end
  else begin
    wbMaxHeightDataCELL := wbStruct(MHDT, 'Max Height Data', [
      wbFloat('Offset'),
      wbArray('Rows',
        wbByteArray('Columns', 32)
        // way too verbose for no practical use
        //wbStruct('Row', [ wbArray('Columns', wbInteger('Column', itU8), 32) ])
      , 32)
    ]);
    wbMaxHeightDataWRLD := wbStruct(MHDT, 'Max Height Data', [
      wbStruct('Min', [
        wbInteger('X', itS16, nil, nil, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT]),
        wbInteger('Y', itS16, nil, nil, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT])
      ]),
      wbStruct('Max', [
        wbInteger('X', itS16, nil, nil, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT]),
        wbInteger('Y', itS16, nil, nil, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT])
      ]),
      wbByteArray('Cell Data', 0, wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT])
      // way too verbose for no practical use
      {wbArray('Cell Data', wbStruct('Quad Height', [
        wbInteger('Bottom Left', itU8),
        wbInteger('Bottom Right', itU8),
        wbInteger('Top Left', itU8),
        wbInteger('Top Right', itU8)
      ]))}
    ], wbWorldMHDTConflictPriority[wbIgnoreWorldMHDT]);
  end;

  wbXOWN := wbStruct(XOWN, 'Owner', [
    wbFormIDCkNoReach('Owner', [FACT, ACHR, NPC_]),
    wbByteArray('Unknown', 4),
    wbInteger('Flags', itU8, wbFlags(['No Crime'])),
    wbByteArray('Unused', 3)
  ]);
  wbXRNK := wbInteger(XRNK, 'Owner Faction Rank', itS32);

  wbNavmeshEdgeLinks := wbArray('Edge Links',
    wbStruct('Edge Link', [
      wbInteger('Type', itU32,
        wbEnum([
          'Portal',
          'Ledge Up',
          'Ledge Down',
          'Enable/Disable Portal'
        ])
      ),
      wbFormIDCk('Mesh', [NAVM], False, cpIgnore), // those last three are a structure
      wbInteger('Triangle Index', itS16, nil, cpIgnore),
      wbByteArray('Edge Index', 1, cpIgnore) // if form ver > 127
    ], cpIgnore)
  , -1, cpIgnore);

  wbCRCValuesEnum :=
    wbEnum([],[
      Int64(0), 'None',
      Int64($ED157AE3), 'BGSAutoWeaponSoundDef',
      Int64($54651A43), 'BGSCompoundSoundDef',
      Int64($23F678C3), 'BGSMusicPaletteTrack',
      Int64($A1A9C4D5), 'BGSMusicSilenceTrack',
      Int64($6ED7E048), 'BGSMusicSingleTrack',
      Int64($1EEF540A), 'BGSStandardSoundDef',
      Int64($18837B4F), 'BSDelayEffect',
      Int64($864804BE), 'BSOverdrive',
      Int64($0534ED31), 'BSPathingRequest',
      Int64($7C61EBDB), 'BSPathingSolution',
      Int64($FF5A7BF9), 'BSPathingStreamSimpleBufferRead',
      Int64($B8B926AB), 'BSPathingStreamSimpleBufferWrite',
      Int64($EF575F7F), 'BSStateVariableFilter',
      Int64($D2B19B80), 'CharacterBumper',
      Int64($DFD9D295), 'Combat Area Shape',
      Int64($FB4E3968), 'Combat Cluster Shape',
      Int64($6F1CAA87), 'CombatAcquireSearchDebugData',
      Int64($86D330A0), 'CombatAimController',
      Int64($C7356584), 'CombatAnimatedPath',
      Int64($19BD0D6F), 'CombatApproachTargetPathController',
      Int64($55FAB455), 'CombatAreaHoldPosition',
      Int64($55C1257B), 'CombatAreaReference',
      Int64($05E817A3), 'CombatAreaShape',
      Int64($A9BDAAFE), 'CombatAreaStandard',
      Int64($8DF7108B), 'CombatChangePositionPathController',
      Int64($2C7605EF), 'CombatChargingSearch',
      Int64($C0C58495), 'CombatCluster',
      Int64($4F117E2B), 'CombatCoverLocation',
      Int64($93409B55), 'CombatCoverSearch',
      Int64($CEF2A87C), 'CombatCoverSearchDebugData',
      Int64($3BD0B457), 'CombatCoverSearchResult',
      Int64($2F77502E), 'CombatCoveredPath',
      Int64($9B04E6C7), 'CombatCoveredPathDebugData',
      Int64($D092ED0A), 'CombatDebugTaskPath',
      Int64($EE1CC4C7), 'CombatDisableActionController',
      Int64($BE236AC9), 'CombatDisableAimController',
      Int64($46F5F91D), 'CombatEnterCoverPathController',
      Int64($884737D6), 'CombatFindCoverPathSpeedController',
      Int64($D6BCB796), 'CombatFlankingSearch',
      Int64($FD16CDF5), 'CombatFollowTargetPathController',
      Int64($D10237D8), 'CombatInventoryItemGrenade',
      Int64($9C2A0B47), 'CombatInventoryItemMagic',
      Int64($84226BD5), 'CombatInventoryItemMagicT',
      Int64($5ACB99C8), 'CombatInventoryItemMelee',
      Int64($8121581D), 'CombatInventoryItemOneHandedBlock',
      Int64($AC4FAA3E), 'CombatInventoryItemPotion',
      Int64($71B72E31), 'CombatInventoryItemRanged',
      Int64($0BEE2410), 'CombatInventoryItemScroll',
      Int64($F86AC87B), 'CombatInventoryItemShield',
      Int64($D74211FB), 'CombatInventoryItemStaff',
      Int64($26038F0F), 'CombatInventoryItemThrown',
      Int64($66D5D91E), 'CombatInventoryItemTorch',
      Int64($11126C48), 'CombatMagicCasterArmor',
      Int64($3DBA3C9A), 'CombatMagicCasterBoundItem',
      Int64($E18FED78), 'CombatMagicCasterChameleon',
      Int64($22784EA4), 'CombatMagicCasterCloak',
      Int64($B6B0FCAD), 'CombatMagicCasterDisarm',
      Int64($A3055CFB), 'CombatMagicCasterInvisibility',
      Int64($C52FCE43), 'CombatMagicCasterLight',
      Int64($41A74F91), 'CombatMagicCasterOffensive',
      Int64($EC01479B), 'CombatMagicCasterParalyze',
      Int64($0304EC9F), 'CombatMagicCasterReanimate',
      Int64($58A60AE1), 'CombatMagicCasterRestore',
      Int64($02212AB0), 'CombatMagicCasterScript',
      Int64($E694BC11), 'CombatMagicCasterStagger',
      Int64($D2CA5063), 'CombatMagicCasterSummon',
      Int64($5AD2B911), 'CombatMagicCasterTargetEffect',
      Int64($22FDD6D5), 'CombatMagicCasterWard',
      Int64($58D2BC02), 'CombatMantlePathController',
      Int64($4CDADCA1), 'CombatMatchTargetAimController',
      Int64($64927B7C), 'CombatMeleeAimController',
      Int64($9F5CADD3), 'CombatMeleeDebugData',
      Int64($4CAE1AF1), 'CombatMovementRequestFollowActor',
      Int64($E4487BAD), 'CombatPath',
      Int64($3E84D96B), 'CombatPathBuilderOpen',
      Int64($1EBC034E), 'CombatPathBuilderStandard',
      Int64($06546465), 'CombatPathDestinationActor',
      Int64($8D41F733), 'CombatPathDestinationFollowActor',
      Int64($F4CF5520), 'CombatPathDestinationLocation',
      Int64($F296CF1B), 'CombatPathDestinationLocations',
      Int64($E35080C0), 'CombatPathDestinationNone',
      Int64($D283E841), 'CombatPathDestinationRef',
      Int64($C805D268), 'CombatPathDestinationRefs',
      Int64($8103C3F5), 'CombatPathMovementMessage',
      Int64($F8BF5B28), 'CombatPathMovementMessageEvent',
      Int64($FDBCC031), 'CombatPathRequestFlight',
      Int64($42107172), 'CombatPathRequestFlyingAttack',
      Int64($F2148845), 'CombatPathRequestGeneric',
      Int64($AB922554), 'CombatPathRequestHover',
      Int64($8B61E783), 'CombatPathRequestLanding',
      Int64($BEC8C98B), 'CombatPathRequestMultiGoal',
      Int64($E5389793), 'CombatPathRequestOrbit',
      Int64($6254EDF9), 'CombatPathRequestRotatePath',
      Int64($DBFD5552), 'CombatPathRequestStandard',
      Int64($181A275D), 'CombatPathRequestStraightPath',
      Int64($1126F62D), 'CombatPathRequestWeightedMultiGoal',
      Int64($69C1DE5A), 'CombatPathTeleportEvent',
      Int64($0EAB162A), 'CombatPathingDebugData',
      Int64($915016AC), 'CombatPathingGoalPolicyAvoidThreat',
      Int64($EDF37547), 'CombatPathingGoalPolicyCharge',
      Int64($BA6CF790), 'CombatPathingGoalPolicyCovered',
      Int64($8BCD672F), 'CombatPathingGoalPolicyDistract',
      Int64($BCAF5C77), 'CombatPathingGoalPolicyFindAttackLocation',
      Int64($0BD293B3), 'CombatPathingGoalPolicyFindCover',
      Int64($908492DD), 'CombatPathingGoalPolicyFindFlankCover',
      Int64($5B1BCF07), 'CombatPathingGoalPolicyFindPotentialCoverLocations',
      Int64($8E7989FB), 'CombatPathingGoalPolicyFindTargetLocation',
      Int64($A51384C9), 'CombatPathingGoalPolicyFindValidLocation',
      Int64($E3B56EB4), 'CombatPathingGoalPolicyFlank',
      Int64($DABA9C1C), 'CombatPathingGoalPolicyFlankDistant',
      Int64($25DBBA6F), 'CombatPathingGoalPolicyFlee',
      Int64($D0AC9503), 'CombatPathingGoalPolicyFollow',
      Int64($AB978C95), 'CombatPathingGoalPolicyInvestigateLocation',
      Int64($EA81EBDB), 'CombatPathingGoalPolicyLocation',
      Int64($0DE21F5F), 'CombatPathingGoalPolicyRetreat',
      Int64($EEBD7774), 'CombatPathingGoalPolicyReturnToCombatArea',
      Int64($0C680AD4), 'CombatPathingGoalPolicySearch',
      Int64($B3E86A9C), 'CombatPathingGoalPolicySearchWander',
      Int64($01C13D8E), 'CombatPathingGoalPolicyWithdraw',
      Int64($BA27000F), 'CombatPathingRequestAdapter',
      Int64($0221C439), 'CombatPathingRequestCovered',
      Int64($35B4C5A0), 'CombatPathingRequestGeneric',
      Int64($95AC34AF), 'CombatPathingRequestMultiGoal',
      Int64($0B5AE3E8), 'CombatPathingRequestStandard',
      Int64($30290669), 'CombatPathingSearchArea',
      Int64($5C75F15E), 'CombatPathingSearchPolicyCharge',
      Int64($DEB6D9D4), 'CombatPathingSearchPolicyCovered',
      Int64($FA183888), 'CombatPathingSearchPolicyDistract',
      Int64($6ED8538F), 'CombatPathingSearchPolicyFlank',
      Int64($D53DEA30), 'CombatPathingSearchPolicyStandard',
      Int64($70146229), 'CombatPathingSearchPolicyWithdraw',
      Int64($38E53D12), 'CombatPathingTweener',
      Int64($A0DD2269), 'CombatPositionTracker',
      Int64($F06E7A91), 'CombatProjectileAimController',
      Int64($AACFA802), 'CombatProjectileDebugData',
      Int64($D55D0153), 'CombatSearchLockData',
      Int64($D5039E9E), 'CombatSharedPath',
      Int64($150B2FA1), 'CombatSuppressiveFireBehavior',
      Int64($1EE53011), 'CombatTargetLocation',
      Int64($9C2C29FA), 'CombatTargetLocationSearch',
      Int64($C331439E), 'CombatTargetLocationSearchResult',
      Int64($D6E95B87), 'CombatTargetSelector',
      Int64($F7B17BBC), 'CombatTargetSelectorFixed',
      Int64($56E7D0C9), 'CombatTargetSelectorPreferred',
      Int64($CE50E3CA), 'CombatTargetSelectorRandom',
      Int64($C3719B85), 'CombatTargetSelectorStandard',
      Int64($3767DCBF), 'CombatThreatExplosion',
      Int64($3C2E5014), 'CombatThreatLOF',
      Int64($A7A21566), 'CombatThreatMelee',
      Int64($A160AF0F), 'CombatThreatProjectile',
      Int64($5AD9B53F), 'CombatTrackTargetAimController',
      Int64($34F693AE), 'CombatTunnelPathController',
      Int64($CB90834C), 'CombatViewController',
      Int64($5222E337), 'CombatViewControllerGlance',
      Int64($C5642853), 'CombatViewControllerPath',
      Int64($C8CC82FC), 'CombatViewControllerStandard',
      Int64($120782F9), 'Covered Path Shape',
      Int64($B1AA41D8), 'CoveredPath',
      Int64($5894CF75), 'DiveBombPathController',
      Int64($6241C761), 'EquippedWeaponData',
      Int64($76FC2C53), 'MasterFilePathingStreamGetSize',
      Int64($3F0FBE34), 'MasterFilePathingStreamWriteToBuffer',
      Int64($5CC2A237), 'MovementMessageActivateDoor',
      Int64($77A37BFA), 'MovementMessageActorCollision',
      Int64($7663F86A), 'MovementMessageApproachingDoor',
      Int64($C8B4153E), 'MovementMessageBlocked',
      Int64($3BED430B), 'MovementMessageFreezeDirection',
      Int64($00DC870E), 'MovementMessageJump',
      Int64($CDED4F63), 'MovementMessageNewPath',
      Int64($C4D7F551), 'MovementMessageNewPathImmediate',
      Int64($D7578F99), 'MovementMessagePathComplete',
      Int64($8BCEF6C4), 'MovementMessagePathFailed',
      Int64($119563E6), 'MovementMessagePlayIdle',
      Int64($616653D5), 'MovementMessageSetStaticPath',
      Int64($67DA9023), 'MovementMessageWarpToLocation',
      Int64($3CF364EC), 'MovementMessageWarpToMultiple',
      Int64($7291261A), 'MovementNodeAvoidance',
      Int64($3B18904B), 'MovementNodeGoal',
      Int64($0C28D1C5), 'MovementParameters',
      Int64($BCDCF728), 'MovementParametersFixed',
      Int64($CD4E67C5), 'NoSupport',
      Int64($A5E9A03C), 'PathingCell',
      Int64($E48B73F3), 'PathingDoor',
      Int64($5826A5DD), 'PathingLockData',
      Int64($330EB0E3), 'PathingRequest',
      Int64($EB5ED874), 'PathingRequestClosePoint',
      Int64($F31543AB), 'PathingRequestClosestGoal',
      Int64($0618E573), 'PathingRequestCover',
      Int64($FA2763CE), 'PathingRequestFlee',
      Int64($3C5FF134), 'PathingRequestFly',
      Int64($A5021751), 'PathingRequestFlyAction',
      Int64($8353103B), 'PathingRequestFlyHover',
      Int64($F075EEF7), 'PathingRequestFlyLand',
      Int64($CDF9A2FC), 'PathingRequestFlyOrbit',
      Int64($98C4C679), 'PathingRequestFlyTakeOff',
      Int64($0528E757), 'PathingRequestHide',
      Int64($54DACA55), 'PathingRequestLOS',
      Int64($CA622528), 'PathingRequestOptimalLocation',
      Int64($C702BB5B), 'PathingRequestRotate',
      Int64($4773B11D), 'PathingRequestSafeStraightLine',
      Int64($8B2152AF), 'PathingRequestStopMoving',
      Int64($13A2CF42), 'PathingStreamLoadGame',
      Int64($7377FDD0), 'PathingStreamMasterFileRead',
      Int64($C5B58C0B), 'PathingStreamSaveGame',
      Int64($6AF11190), 'QuestPathingRequest',
      Int64($FCD0CCC3), 'Water'
    ]);

  wbNavmeshDoorTriangles := wbArrayS('Door Triangles',
    wbStructSK([0, 2], 'Door Triangle', [
      wbInteger('Triangle before door', itU16).SetLinksToCallback(wbTriangleLinksTo),
      wbInteger('Door Type', itU32, wbCRCValuesEnum).SetDefaultEditValue('PathingDoor'), //contains 0 or the CRC of "PathingDoor" = F3 73 8B E4
      wbUnion('Door', wbDoorTriangleDoorTriangleDecider, [wbNull, wbFormIDCk('Door', [REFR])])
    ])
  , -1);

  if wbSimpleRecords then begin
    wbNavmeshVertices := wbArray('Vertices', wbByteArray('Vertex', 12), -1);
    wbNavmeshTriangles := wbArray('Triangles', wbByteArray('Triangle', 21), -1);
    wbNavmeshCoverArray := wbArray('Cover Array', wbByteArray('Cover', 16), -1);
    wbNavmeshCoverTriangleMap := wbArray('Cover Triangle Mappings', wbByteArray('Cover Triangle', 8), -1);
    wbNavmeshWaypoints := wbArray('Waypoints', wbByteArray('Waypoint', 18), -1);
    wbNavmeshGrid := wbStruct('Navmesh Grid', [wbUnknown])
  end else begin
    wbNavmeshVertices := wbArray('Vertices',
      wbStruct('Vertex', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3)
    , -1);

    wbNavmeshTriangles := wbArray('Triangles',
      wbStruct('Triangle', [
        wbInteger('Vertex 0', itS16, wbVertexToStr0, wbVertexToInt0).SetLinksToCallback(wbVertexLinksTo),
        wbInteger('Vertex 1', itS16, wbVertexToStr1, wbVertexToInt1).SetLinksToCallback(wbVertexLinksTo),
        wbInteger('Vertex 2', itS16, wbVertexToStr2, wbVertexToInt2).SetLinksToCallback(wbVertexLinksTo),
        wbInteger('Edge 0-1', itS16, wbEdgeToStr0, wbEdgeToInt0).SetLinksToCallback(wbEdgeLinksTo0),
        wbInteger('Edge 1-2', itS16, wbEdgeToStr1, wbEdgeToInt1).SetLinksToCallback(wbEdgeLinksTo1),
        wbInteger('Edge 2-0', itS16, wbEdgeToStr2, wbEdgeToInt1).SetLinksToCallback(wbEdgeLinksTo2),
        wbFloat('Height'), // this and next if form ver > 57
        wbInteger('Unknown', itU8), // flags
        wbInteger('Flags', itU16, wbFlags([
          'Edge 0-1 link',      //$0001 1
          'Edge 1-2 link',      //$0002 2
          'Edge 2-0 link',      //$0004 4
          '',                   //$0008 8
          'No Large Creatures',          //$0010 16   used in CK source according to Nukem
          'Overlapping',        //$0020 32
          'Preferred',          //$0040 64
          '',                   //$0080 128
          'Unknown 9',          //$0100 256  used in CK source according to Nukem
          'Water',              //$0200 512
          'Door',               //$0400 1024
          'Found',              //$0800 2048
          'Unknown 13',         //$1000 4096 used in CK source according to Nukem
          '',                   //$2000 \
          '',                   //$4000  |-- used as 3 bit counter inside CK, probably stripped before save
          ''                    //$8000 /
        ])),
        { Flags below are wrong. The first 4 bit are an enum as follows:
        0000 = Open Edge No Cover
        1000 = wall no cover
        0100 = ledge cover
        1100 = UNUSED
        0010 = cover  64
        1010 = cover  80
        0110 = cover  96
        1110 = cover 112
        0001 = cover 128
        1001 = cover 144
        0101 = cover 160
        1101 = cover 176
        0011 = cover 192
        1011 = cover 208
        0111 = cover 224
        1111 = max cover
        then 2 bit flags, then another such enum, and the rest is probably flags.
        Can't properly represent that with current record definition methods.
        }
        wbInteger('Cover Flags', itU16, wbFlags([
          'Edge 0-1 Cover Value 1/4',
          'Edge 0-1 Cover Value 2/4',
          'Edge 0-1 Cover Value 3/4',
          'Edge 0-1 Cover Value 4/4',
          'Edge 0-1 Left',
          'Edge 0-1 Right',
          'Edge 1-2 Cover Value 1/4',
          'Edge 1-2 Cover Value 2/4',
          'Edge 1-2 Cover Value 3/4',
          'Edge 1-2 Cover Value 4/4',
          'Edge 1-2 Left',
          'Edge 1-2 Right',
          'Unknown 13',
          'Unknown 14',
          'Unknown 15',
          'Unknown 16'
        ]))
      ])
    , -1);

    wbNavmeshCoverArray := wbArray('Cover Array',  // if navmesh version gt 12
      wbStruct('Cover', [
        wbInteger('Vertex 1', itU16).SetLinksToCallback(wbVertexLinksTo),
        wbInteger('Vertex 2', itU16).SetLinksToCallback(wbVertexLinksTo),
        wbByteArray('Data', 4 {, wbFlags([]) ? })
      ])
    , -1);

    wbNavmeshCoverTriangleMap := wbArray('Cover Triangle Mappings',
      wbStruct('Cover Triangle Map', [
        wbInteger('Cover', itU16).SetLinksToCallback(wbCoverLinksTo),
        wbInteger('Triangle', itU16).SetLinksToCallback(wbTriangleLinksTo)
      ])
    , -1);

    wbNavmeshWaypoints := wbArray('Waypoints',  // if navmesh version gt 11
      wbStruct('Waypoint', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z'),
        wbInteger('Triangle', itU16).SetLinksToCallback(wbTriangleLinksTo),
        wbInteger('Flags', itU32)
      ])
    , -1);

    wbNavmeshGrid := wbStruct('Navmesh Grid', [
      wbInteger('Navmesh Grid Size', itU32),  // max 12
      wbFloat('Max X Distance'),
      wbFloat('Max Y Distance'),
      wbFloat('Min X'),
      wbFloat('Min Y'),
      wbFloat('Min Z'),
      wbFloat('Max X'),
      wbFloat('Max Y'),
      wbFloat('Max Z'),
      wbArray('NavMesh Grid Arrays',
        wbArray('NavMeshGridCell',
          wbInteger('Triangle', itS16).SetLinksToCallback(wbTriangleLinksTo)
        , -1).IncludeFlag(dfNotAlignable)
      ).IncludeFlag(dfNotAlignable) // There are NavMeshGridSize^2 arrays to load
    ])
  end;

  wbNVNM := wbStruct(NVNM, 'Navmesh Geometry', [
    wbInteger('Version', itU32).SetDefaultNativeValue(15),  // Changes how the struct is loaded, should be 15 in FO4
    wbStruct('Pathing Cell', [
      wbInteger('CRC Hash', itU32, wbCRCValuesEnum).SetDefaultEditValue('PathingCell'),  // This looks like a magic number (always $A5E9A03C), loaded with the parents
      wbFormIDCk('Pathing Worldspace', [WRLD, NULL]),
      wbUnion('Pathing Cell Data', wbNVNMParentDecider, [  // same as TES5 cell if worldspace is null or Grid X Y
        wbStruct('Coordinates', [
          wbInteger('Grid Y', itS16),
          wbInteger('Grid X', itS16)
        ]),
        wbFormIDCk('Pathing Cell', [CELL])
      ])
    ]),
    wbNavmeshVertices.IncludeFlag(dfNotAlignable),
    wbNavmeshTriangles.IncludeFlag(dfNotAlignable),
    wbNavmeshEdgeLinks.IncludeFlag(dfNotAlignable),
    wbNavmeshDoorTriangles.IncludeFlag(dfNotAlignable),
    wbNavmeshCoverArray.IncludeFlag(dfNotAlignable),
    wbNavmeshCoverTriangleMap.IncludeFlag(dfNotAlignable),
    wbNavmeshWaypoints.IncludeFlag(dfNotAlignable),
    wbNavmeshGrid
  ]);

  wbMNAMNAVM := wbArrayS(MNAM, 'PreCut Map Entries', wbStructSK([0], 'PreCut Map Entry', [
    wbFormID('Reference'),
    wbArrayS('Triangles', wbInteger('Triangle', itU16).SetLinksToCallback(wbTriangleLinksTo), -2)
  ]))
end;

procedure DefineSF1b;
begin
  {subrecords checked against Starfield.esm}
  wbRefRecord(ACHR, 'Placed NPC',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([ {not checked for Starfield}
      {0x00000200}  9, 'Starts Dead',
      {0x00000400} 10, 'Persistent',
      {0x00000800} 11, 'Initially Disabled',
      {0x00002000} 13, 'Starts Unconscious',
      {0x02000000} 25, 'No AI Acquire',
      {0x20000000} 29, 'Don''t Havok Settle'
    ], True, True)), [
    wbEDID,
    wbVMAD,
    wbBaseFormComponents,
    wbXALG,
    wbFormIDCk(NAME, 'Base', [NPC_], False, cpNormal, True),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    {--- Ragdoll ---}
    wbRStruct('Ragdoll Data', [
      wbXRGD,
      wbXRGB
    ], []),

    (*
    {--- Patrol Data ---}
    wbRStruct('Patrol Data', [
      wbFloat(XPRD, 'Idle Time', cpNormal, True),
      wbEmpty(XPPA, 'Patrol Script Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbPDTOs,
      wbFormIDCk(TNAM, 'Topic', [DIAL, NULL], False, cpNormal)
    ], []),
    *)

    {--- Leveled Actor ----}
    wbXLCM,

    {--- Extra ---}
    //wbInteger(XCNT, 'Count', itS32),
    //wbFloat(XRDS, 'Radius'),
    wbInteger(XHLT, 'Health %', itU32),

    wbRArrayS('Linked References', wbStructSK(XLKR, [0], 'Linked Reference', [
      wbFormIDCk('Keyword/Ref', [KYWD, PLYR, ACHR, REFR, PGRE, PHZD, PMIS, PARW, PBAR, PBEA, PCON, PFLA, NULL]),
      wbFormIDCk('Ref', sigReferences)
    ], cpNormal, False, nil, 1)),

    (*
    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbInteger(XAPD, 'Flags', itU8, wbFlags([
        'Parent Activate Only'
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', sigReferences),
          wbFloat('Delay')
        ])
      )
    ], []),
    wbEmpty(XATP, 'Activation Point'),
    *)

    wbEmpty(XLKT, 'Linked Ref Transient'),
    wbFormIDCk(XRFG, 'Reference Group', [RFGP]),
    wbFormIDCk(XLYR, 'Layer', [LAYR]),
    //wbFormIDCk(XMSP, 'Material Swap', [MSWP]),

    wbFormIDCk(XLCN, 'Persistent Location', [LCTN]),
    wbFormIDCk(XLRL, 'Location Reference', [LCRT, LCTN, NULL], False, cpBenignIfAdded),
    wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),

    wbEmpty(XIS2, 'Ignored by Sandbox'),
    (*
    wbRArray('Spline Connection', wbStruct(XPLK, 'Link', [
      wbFormIDCk('Ref', [REFR, ACHR]),
      wbUnknown  // always 00 00 00 00 so far in DLCWorkshop03.esm
    ])),
    *)
    //wbFloat(XHTW, 'Head-Tracking Weight'),
    //wbFloat(XFVC, 'Favor Cost'),

    {--- Enable Parent ---}
    wbXESP,

    {--- Ownership ---}
    wbXOWN,
    wbXRNK,

    {--- Emittance ---}
    //wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

    {--- MultiBound ---}
    //wbFormIDCk(XMBR, 'MultiBound Reference', sigReferences),

    {--- Flags ---}
    //wbEmpty(XIBS, 'Ignored By Sandbox'),

    wbUnknown(XEED),

    wbUnknown(XPCS),

    {--- 3D Data ---}
    wbXSCL,
    wbDATAPosRot,
    wbString(MNAM, 'Comments')
  ], True, wbPlacedAddInfo);

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

  wbSkillEnum :=
    wbEnum([
      'Unknown 1',
      'Unknown 2',
      'Unknown 3',
      'Unknown 4',
      'Unknown 5',
      'Unknown 6',
      'One Handed',
      'Two Handed',
      'Archery',
      'Block',
      'Smithing',
      'Heavy Armor',
      'Light Armor',
      'Pickpocket',
      'Lockpicking',
      'Sneak',
      'Alchemy',
      'Speech',
      'Alteration',
      'Conjuration',
      'Destruction',
      'Illusion',
      'Restoration',
      'Enchanting'
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

  wbCrimeTypeEnum :=
    wbEnum([
      'Steal',
      'Pickpocket',
      'Trespass',
      'Attack',
      'Murder',
      'Escape Jail',
      'Werewolf Transformation'
    ], [
      -1, 'None'
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
   116, 'Terminal'
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

  wbAlignmentEnum :=
    wbEnum([
      'Good',
      'Neutral',
      'Evil',
      'Very Good',
      'Very Evil'
    ]);

  wbCriticalStageEnum :=
    wbEnum([
      'None',
      'Goo Start',
      'Goo End',
      'Disintegrate Start',
      'Disintegrate End'
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
    wbStructSK(EFIT, [3, 4], '', [
      wbFloat('Magnitude', cpNormal, True),
      wbInteger('Area', itU32),
      wbInteger('Duration', itU32)
    ], cpNormal, True, nil, -1, wbEFITAfterLoad);

  wbCTDA :=
    wbRStructSK([0], 'Condition', [
      wbStructSK(CTDA, [3, 5, 6], '', [
     {0}wbInteger('Type', itU8, wbCtdaTypeToStr, wbCtdaTypeToInt, cpNormal, False, nil, wbCtdaTypeAfterSet),
     {1}wbByteArray('Unused', 3, cpIgnore, False, wbNeverShow),
     {2}wbUnion('Comparison Value', wbCTDACompValueDecider, [
          wbFloat('Comparison Value - Float'),
          wbFormIDCk('Comparison Value - Global', [GLOB])
        ]),
     {3}wbInteger('Function', itU16, wbCTDAFunctionToStr, wbCTDAFunctionToInt),
     {4}wbByteArray('Unused', 2, cpIgnore, False, wbNeverShow),
     {5}wbUnion('Parameter #1', wbCTDAParam1Decider, [
          { unknown }
          wbByteArray('Unknown', 4).IncludeFlag(dfZeroSortKey),
          { 0 ptNone}
          wbByteArray('None', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
          { 1 ptString}
          wbInteger('String', itU32, wbCTDAParam1StringToString, wbCTDAParam1StringToInt),
          { 2 ptInteger}
          wbInteger('Integer', itS32),
          { 3 ptFloat}
          wbFloat('Float'),
          { 4 ptActor}
          wbFormIDCkNoReach('Actor', [NULL, PLYR, ACHR, REFR]),
          { 5 ptActorBase}
          wbFormIDCkNoReach('Actor Base', [NPC_]),
          { 6 ptActorValue}
          wbActorValue,
          { 7 ptAdvanceAction}
          wbInteger('Player Action', itU32, wbAdvanceActionEnum),
          { 8 ptAlias}
          wbInteger('Alias', itS32, wbConditionAliasToStr, wbStrToAlias),
          { 9 ptAlignment}
          wbInteger('Alignment', itU32, wbAlignmentEnum),
          {10 ptAssociationType}
          wbFormIDCk('Association Type', [ASTP]),
          {11 ptAxis}
          wbInteger('Axis', itU32, wbAxisEnum),
          {12 ptCastingSource}
          wbInteger('Casting Type', itU32, wbCastingSourceEnum),
          {13 ptCell}
          wbFormIDCkNoReach('Cell', [CELL]),
          {14 ptClass}
          wbFormIDCkNoReach('Class', [CLAS]),
          {15 ptCrimeType}
          wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
          {16 ptCriticalStage}
          wbInteger('Critical Stage', itU32, wbCriticalStageEnum),
          {17 ptEncounterZone}
          wbFormIDCkNoReach('Encounter Zone', [ECZN]),
          {18 ptEquipType}
          wbFormIDCkNoReach('Equip Type', [EQUP]),
          {19 ptEvent}
          wbInteger('Event', itU32, wbEventFunctionAndMemberToStr, wbEventFunctionAndMemberToInt),
          {20 ptEventData}
          wbFormID('Event Data'),
          {21 ptFaction}
          wbFormIDCkNoReach('Faction', [FACT]),
          {22 ptFormList}
          wbFormIDCkNoReach('Form List', [FLST]),
          {23 ptFormType}
          wbInteger('Form Type', itU32, wbFormTypeEnum),
          {24 ptFurniture}
          wbFormIDCkNoReach('Furniture', [FURN, FLST]),
          {25 ptFurnitureAnim}
          wbInteger('Furniture Anim', itU32, wbFurnitureAnimTypeEnum),
          {26 ptFurnitureEntry}
          wbInteger('Furniture Entry', itU32, wbEnum([], [$010000, 'Front', $020000, 'Behind', $040000, 'Right', $80000, 'Left', $100000, 'Up'])),
          {27 ptGlobal}
          wbFormIDCkNoReach('Global', [GLOB]),
          {28 ptIdleForm}
          wbFormIDCkNoReach('Idle', [IDLE]),
          {29 ptInventoryObject}
          wbFormIDCkNoReach('Inventory Object', sigBaseObjects),
          {30 ptKeyword}
          wbFormIDCkNoReach('Keyword', [KYWD, FLST, NULL]),
          {31 ptLocation}
          wbFormIDCkNoReach('Location', [LCTN]),
          {32 ptMagicEffect}
          wbFormIDCkNoReach('Base Effect', [MGEF]),
          {33 ptMagicItem}
          wbFormIDCkNoReach('Effect Item', [SPEL, ENCH, ALCH, INGR, SCRL]),
          {34 ptMiscStat}
          wbInteger('Misc Stat', itU32, wbMiscStatEnum),
          {35 ptObjectReference}
          wbFormIDCkNoReach('Object Reference', sigReferences),
          {36 ptOwner}
          wbFormIDCkNoReach('Owner', [NULL, FACT, NPC_]),
          {37 ptPackage}
          wbFormIDCkNoReach('Package', [PACK]),
          {38 ptPackdata}
          wbInteger('Packdata ID', itU32),
          {39 ptPerk}
          wbFormIDCkNoReach('Perk', [PERK]),
          {40 ptQuest}
          wbFormIDCkNoReach('Quest', [QUST]).AddOverlay(wbCTDAParamQuestOverlay),
          {41 ptQuestStage}
          wbInteger('Quest Stage', itU32, wbCTDAParam2QuestStageToStr, wbQuestStageToInt),
          {42 ptRace}
          wbFormIDCkNoReach('Race', [RACE]),
          {43 ptReferencableObject}
          wbFormIDCkNoReach('Referenceable Object', sigBaseObjects),
          {44 ptRefType}
          wbFormIDCkNoReach('Location Ref Type', [LCRT]),
          {45 ptRegion}
          wbFormIDCkNoReach('Region', [REGN]),
          {46 ptScene}
          wbFormIDCk('Scene', [NULL, SCEN]),
          {47 ptSex}
          wbInteger('Sex', itU32, wbSexEnum),
          {48 ptShout}
          wbFormIDCkNoReach('Shout', [SHOU]),
          {49 ptVariableName}
          wbByteArray('Variable Name (unused)', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
          {50 ptVATSValueFunction}
          wbInteger('VATS Value Function', itU32, wbVATSValueFunctionEnum),
          {51 ptVATSValueParam}
          wbInteger('VATS Value Param (unused)', itU32).IncludeFlag(dfZeroSortKey),
          {52 ptVoiceType}
          wbFormIDCkNoReach('Voice Type', [VTYP, FLST]),
          {53 ptWardState}
          wbInteger('Ward State', itU32, wbWardStateEnum),
          {54 ptWeather}
          wbFormIDCkNoReach('Weather', [WTHR]),
          {55 ptWorldspace}
          wbFormIDCkNoReach('Worldspace', [WRLD, FLST]),
          {56 ptDamageType}
          wbFormIDCkNoReach('Damage Type', [DMGT, FLST])
        ]),

        wbUnion('Parameter #2', wbCTDAParam2Decider, [
          { unknown }
          wbByteArray('Unknown', 4).IncludeFlag(dfZeroSortKey),
          { 0 ptNone}
          wbByteArray('None', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
          { 1 ptString}
          wbInteger('String', itU32, wbCTDAParam2StringToString, wbCTDAParam2StringToInt),
          { 2 ptInteger}
          wbInteger('Integer', itS32),
          { 3 ptFloat}
          wbFloat('Float'),
          { 4 ptActor}
          wbFormIDCkNoReach('Actor', [NULL, PLYR, ACHR, REFR]),
          { 5 ptActorBase}
          wbFormIDCkNoReach('Actor Base', [NPC_]),
          { 6 ptActorValue}
          wbActorValue,
          { 7 ptAdvanceAction}
          wbInteger('Player Action', itU32, wbAdvanceActionEnum),
          { 8 ptAlias}
          wbInteger('Alias', itS32, wbConditionAliasToStr, wbStrToAlias),
          { 9 ptAlignment}
          wbInteger('Alignment', itU32, wbAlignmentEnum),
          {10 ptAssociationType}
          wbFormIDCk('Association Type', [ASTP]),
          {11 ptAxis}
          wbInteger('Axis', itU32, wbAxisEnum),
          {12 ptCastingSource}
          wbInteger('Casting Type', itU32, wbCastingSourceEnum),
          {13 ptCell}
          wbFormIDCkNoReach('Cell', [CELL]),
          {14 ptClass}
          wbFormIDCkNoReach('Class', [CLAS]),
          {15 ptCrimeType}
          wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
          {16 ptCriticalStage}
          wbInteger('Critical Stage', itU32, wbCriticalStageEnum),
          {17 ptEncounterZone}
          wbFormIDCkNoReach('Encounter Zone', [ECZN]),
          {18 ptEquipType}
          wbFormIDCkNoReach('Equip Type', [EQUP]),
          {19 ptEvent}
          wbInteger('Event', itU32, wbEventFunctionAndMemberToStr, wbEventFunctionAndMemberToInt),
          {20 ptEventData}
          wbFormID('Event Data'),
          {21 ptFaction}
          wbFormIDCkNoReach('Faction', [FACT]),
          {22 ptFormList}
          wbFormIDCkNoReach('Form List', [FLST]),
          {23 ptFormType}
          wbInteger('Form Type', itU32, wbFormTypeEnum),
          {24 ptFurniture}
          wbFormIDCkNoReach('Furniture', [FURN, FLST]),
          {25 ptFurnitureAnim}
          wbInteger('Furniture Anim', itU32, wbFurnitureAnimTypeEnum),
          {26 ptFurnitureEntry}
          wbInteger('Furniture Entry', itU32, wbEnum([], [$010000, 'Front', $020000, 'Behind', $040000, 'Right', $80000, 'Left', $100000, 'Up'])),
          {27 ptGlobal}
          wbFormIDCkNoReach('Global', [GLOB]),
          {28 ptIdleForm}
          wbFormIDCkNoReach('Idle', [IDLE]),
          {29 ptInventoryObject}
          wbFormIDCkNoReach('Inventory Object', sigBaseObjects),
          {30 ptKeyword}
          wbFormIDCkNoReach('Keyword', [KYWD, FLST, NULL]),
          {31 ptLocation}
          wbFormIDCkNoReach('Location', [LCTN]),
          {32 ptMagicEffect}
          wbFormIDCkNoReach('Base Effect', [MGEF]),
          {33 ptMagicItem}
          wbFormIDCkNoReach('Effect Item', [SPEL, ENCH, ALCH, INGR, SCRL]),
          {34 ptMiscStat}
          wbInteger('Misc Stat', itU32, wbMiscStatEnum),
          {35 ptObjectReference}
          wbFormIDCkNoReach('Object Reference', sigReferences),
          {36 ptOwner}
          wbFormIDCkNoReach('Owner', [NULL, FACT, NPC_]),
          {37 ptPackage}
          wbFormIDCkNoReach('Package', [PACK]),
          {38 ptPackdata}
          wbInteger('Packdata ID', itU32),
          {39 ptPerk}
          wbFormIDCkNoReach('Perk', [PERK]),
          {40 ptQuest}
          wbFormIDCkNoReach('Quest', [QUST]),
          {41 ptQuestStage}
          wbInteger('Quest Stage', itU32, wbCTDAParam2QuestStageToStr, wbQuestStageToInt),
          {42 ptRace}
          wbFormIDCkNoReach('Race', [RACE]),
          {43 ptReferencableObject}
          wbFormIDCkNoReach('Referenceable Object', sigBaseObjects),
          {44 ptRefType}
          wbFormIDCkNoReach('Location Ref Type', [LCRT]),
          {45 ptRegion}
          wbFormIDCkNoReach('Region', [REGN]),
          {46 ptScene}
          wbFormIDCk('Scene', [NULL, SCEN]),
          {47 ptSex}
          wbInteger('Sex', itU32, wbSexEnum),
          {48 ptShout}
          wbFormIDCkNoReach('Shout', [SHOU]),
          {49 ptVariableName}
          wbByteArray('Variable Name (unused)', 4, cpIgnore),
          {50 ptVATSValueFunction}
          wbInteger('VATS Value Function', itU32, wbVATSValueFunctionEnum),
          {51 ptVATSValueParam}
          wbUnion('VATS Value Param', wbCTDAParam2VATSValueParamDecider, [
           { 0} wbFormIDCkNoReach('Weapon', [WEAP]),
           { 1} wbFormIDCkNoReach('Weapon List', [FLST], [WEAP]),
           { 2} wbFormIDCkNoReach('Target', [NPC_]),
           { 3} wbFormIDCkNoReach('Target List', [FLST], [NPC_]),
           { 4} wbByteArray('Unknown', 4, cpIgnore),
           { 5} wbInteger('Target Part', itS32, wbActorValueEnum),
           { 6} wbInteger('VATS Action', itU32, wbEnum([
                  'Unarmed Attack',
                  'One Hand Melee Attack',
                  'Two Hand Melee Attack',
                  'Magic Attack',
                  'Ranged Attack',
                  'Reload',
                  'Crouch',
                  'Stand',
                  'Switch Weapon',
                  'Toggle Weapon Drawn',
                  'Heal',
                  'Player Death'
            ])),
           { 7} wbByteArray('Unknown', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
           { 8} wbByteArray('Unknown', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
           { 9} wbFormIDCkNoReach('Critical Effect', [SPEL]),
           {10} wbFormIDCkNoReach('Critical Effect List', [FLST], [SPEL]),
           {11} wbByteArray('Unknown', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
           {12} wbByteArray('Unknown', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
           {13} wbByteArray('Unknown', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
           {14} wbByteArray('Unknown', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
           {15} wbInteger('Weapon Type', itU32, wbWeaponAnimTypeEnum),
           {16} wbByteArray('Unknown', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
           {17} wbByteArray('Unknown', 4, cpIgnore).IncludeFlag(dfZeroSortKey),
           {18} wbInteger('Projectile Type', itU32, wbEnum([
                  'Missile',
                  'Lobber',
                  'Beam',
                  'Flame',
                  'Cone',
                  'Barrier',
                  'Arrow'
                ])),
           {19} wbInteger('Delivery Type', itU32, wbTargetEnum),
           {20} wbInteger('Casting Type', itU32, wbCastEnum)
          ]),
          {52 ptVoiceType}
          wbFormIDCkNoReach('Voice Type', [VTYP, FLST]),
          {53 ptWardState}
          wbInteger('Ward State', itU32, wbWardStateEnum),
          {54 ptWeather}
          wbFormIDCkNoReach('Weather', [WTHR]),
          {55 ptWorldspace}
          wbFormIDCkNoReach('Worldspace', [WRLD, FLST]),
          {56 ptDamageType}
          wbFormIDCkNoReach('Damage Type', [DMGT, FLST])
        ]),
        wbInteger('Run On', itU32, wbEnum([
          { 0} 'Subject',
          { 1} 'Target',
          { 2} 'Reference',
          { 3} 'Combat Target',
          { 4} 'Linked Reference',
          { 5} 'Quest Alias',
          { 6} 'Package Data',
          { 7} 'Event Data',
          { 9} 'Command Target',
          {10} 'Event Camera Ref',
          {11} 'My Killer'
        ]), cpNormal, False, nil, wbCTDARunOnAfterSet),
        wbUnion('Reference', wbCTDAReferenceDecider, [
          wbInteger('Unused', itU32, nil, cpIgnore),
          wbFormIDCkNoReach('Reference', sigReferences, False)
        ]),
        wbInteger('Parameter #3', itS32, nil, cpNormal, False, nil, nil, -1)
      ], cpNormal, False{, nil, 0, wbCTDAAfterLoad}),
      wbString(CIS1, 'Parameter #1'),
      wbString(CIS2, 'Parameter #2')
    ], [], cpNormal).SetToStr(wbConditionToStr).IncludeFlag(dfCollapsed, wbCollapseConditions);

  wbCTDAs := wbRArray('Conditions', wbCTDA, cpNormal, False);
  wbCTDAsCount := wbRArray('Conditions', wbCTDA, cpNormal, False, nil, wbCTDAsAfterSet);
  wbCTDAsReq := wbRArray('Conditions', wbCTDA, cpNormal, True);

  wbICON := wbString(ICON, 'Inventory Image');
  wbMICO := wbString(MICO, 'Message Icon');
  wbPTRN := wbFormIDCk(PTRN, 'Preview Transform', [TRNS]);
  wbSTCP := wbFormIDCk(STCP, 'Animation Sound', [STAG]);
  wbNTRM := wbFormIDCk(NTRM, 'Native Terminal', [TMLM]);
  wbYNAM := wbFormIDCk(YNAM, 'Sound - Pick Up', [SNDR]);
  wbZNAM := wbFormIDCk(ZNAM, 'Sound - Put Down', [SNDR]);
  wbCUSD := wbFormIDCk(CUSD, 'Sound - Crafting', [SNDR]);
  wbINRD := wbFormIDCk(INRD, 'Instance Naming', [INNR]);

  wbObjectProperty :=
    wbStructSK([0], 'Property', [
      wbActorValue,
      wbFloat('Value'),
      wbFromVersion(152, wbFormIDCk('Curve Table', [CURV, NULL]))
    ]).SetToStr(wbObjectPropertyToStr).IncludeFlag(dfCollapsed, wbCollapseObjectProperties);

  wbPRPS := wbArrayS(PRPS, 'Properties', wbObjectProperty);

  wbFLTR := wbString(FLTR, 'Filter');
  wbAPPR := wbArray(APPR, 'Attach Parent Slots', wbFormIDCk('Keyword', [KYWD]));
  wbFTYP := wbArray(FTYP, 'Forced Location Ref Types', wbFormIDCk('Forced Location Ref Type', [LCRT]));
  wbATTX := wbLStringKC(ATTX, 'Activate Text Override', 0, cpTranslate);

  wbBaseFormComponents := wbRStructsSK('Components', 'Component', [0], [
      wbString(BFCB, 'Component Type'),
      wbRUnion('Component Data', [
        //BGSAnimationGraph_Component
        wbRStruct('Component Data', [
          wbString(ANAM),
          wbString(BNAM),
          wbString(CNAM),
          wbString(DNAM),
          wbString(ENAM)
        ], []),
        //BGSAttachParentArray_Component
        wbRStruct('Component Data', [
          wbAPPR
        ], []),
        //BGSActivityTracker
        wbRStruct('Component Data', [
          wbUnknown(ATCP),
          wbString(ATAN),
          wbFULL,
          wbDESC,
          wbRStructs('Unknown', 'Unknown', [
            wbString(DNAM),
            wbCITCReq,
            wbCTDAsCount
          ], []),
          wbString(ANAM),
          wbUnknown(ATAV),
          wbUnknown(ATAF)
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(BUO4),
          wbUnknown(BODM),
          wbRStructs('Unknown', 'Unknown', [
            wbUnknown(BODC),
            wbRStructs('Unknown', 'Unknown', [
              wbString(BODS),
              wbUnknown(BODV)
            ], [])
          ], []),
          wbUnknown(BLUF),
          wbUnknown(BOID)
        ], []),
        //BGSCrowdComponent_Component
        wbRStruct('Component Data', [
          wbUnknown(CDND),
          wbUnknown(CDNS),
          wbRStructs('Unknown', 'Unknown', [
            wbPRPS,
            wbCITCReq,
            wbCTDAsCount,
            wbString(STRV),
            wbUnknown(FLTV)
          ], [])
        ], []),
        wbRStruct('Component Data', [
          wbContainerItems
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(DAT2)
        ], []),
        //BGSStarDataComponent_Component
        //BGSOrbitedDataComponent_Component
        wbRStruct('Component Data', [
          wbUnion(DATA, 'Data', wbBFCDATADecider, [
            wbUnknown,
            //BGSStarDataComponent_Component
            wbStruct('', [
              wbLenString('Catalogue ID'),
              wbLenString('Spectral class'),
              wbFloat('Magnitude'),
              wbFloat('Mass (in SM)', cpNormal, False, 1/1.98847E30, 2),
              wbFloat('Inner habitable zone'),
              wbFloat('Outer habitable zone'),
              wbInteger('HIP', itU32),
              wbInteger('Radius', itU32),
              wbInteger('Temperature in K', itU32)
            ]),
            //BGSOrbitedDataComponent_Component
            wbStruct('', [
              wbUnknown(8),
              wbFloat('Mass (in SM)', cpNormal, False, 1/1.98847E30, 2),
              wbFloat('Radius (in km)'),
              wbUnknown(4)
            ]),
            //BGSOrbitalDataComponent_Component
            wbStruct('', [
              wbUnknown()
            ])
          ]).IncludeFlag(dfUnionStaticResolve)
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(DCSD),
          wbUnknown(DCED)
        ], []),
        wbRStruct('Component Data', [
          wbDest
        ], []),
        //BGSSpaceshipEquipment_Component
        wbRStruct('Component Data', [
          wbUnknown(ESSF)
        ], []),
        //BGSExternalComponentDataSource_Component
        wbRStruct('Component Data', [
          wbFormID(EXDC),
          wbUnknown(EXDZ),
          wbRStructs('Unknown', 'Unknown', [
            wbString(EXCN),
            wbFormID(EXCI)
          ], []),
          wbUnknown(EXAC),
          wbRArray('Unknown', wbString(EXAS)),
          wbUnknown(EXBS)
        ], []),
        //BGSLinkedVoiceType_Component
        wbRStruct('Component Data', [
          wbFormIDCk(FCTF, 'Voice Type', [VTYP])
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(FLCS)
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(FLLD)
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(FTYP)
        ], []),
        wbRStruct('Component Data', [
          wbFULL
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(GNAM)
        ], []),
        wbRStruct('Component Data', [
          wbFormID(HULL)
        ], []),
        wbRStruct('Component Data', [
          wbFormID(INAM, 'Add to inventory on destroy')
        ], []),
        //BGSObjectWindowFilter_Component
        wbRStruct('Component Data', [
          wbUnknown(INTV),
          wbString(FLTR)
        ], []),
        //BGSFormLinkData_Component
        wbRStruct('Component Data', [
          wbUnknown(ITMC),
          wbRArray('Unknown', wbFormID(FLKW))
        ], []),
        wbRStruct('Component Data', [
          wbKeywords
        ], []),
        wbRStruct('Component Data', [
          wbFormID(MNAM, 'Unknown')
        ], []),
        wbRStruct('Component Data', [
          wbString(MODL, 'Model'),
          wbUnknown(FLLD),
          wbUnknown(XMPM),
          wbUnknown(MCQP),
          wbUnknown(XMSP),
          wbUnknown(XLMS)
        ], []),
        wbRStruct('Component Data', [
          wbOPDS
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(PCCC)
        ], []),
        //BGSPropertySheet_Component
        wbRStruct('Component Data', [
          wbPRPS
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(PCCC)
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(PTCL)
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(REFL)
        ], []),
        //BGSSpaceshipAIActor_Component
        wbRStruct('Component Data', [
          wbFormID(SAIA, 'Spaceship AI Actor')
        ], []),
        //BGSSpaceshipWeaponBindings_Component
        wbRStruct('Component Data', [
          wbUnknown(SHWB)
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(SNAM),
          wbUnknown(PNAM),
          wbUnknown(BNAM)
        ], []),
        wbRStruct('Component Data', [
          wbFormID(SODA, 'Spawn on destroy')
        ], []),
        //BGSSoundTag_Component
        wbRStruct('Component Data', [
          wbFormID(STCP)
        ], []),
        //BGSStoredTraversals_Component
        wbRStruct('Component Data', [
          wbUnknown(STRD)
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(VLMS)
        ], []),
        wbRStruct('Component Data', [
          wbUnknown(ZNAM),
          wbUnknown(YNAM),
          wbUnknown(XNAM),
          wbUnknown(WNAM),
          wbUnknown(VNAM),
          wbUnknown(UNAM),
          wbUnknown(NAM1),
          wbUnknown(NAM2),
          wbUnknown(NAM3),
          wbUnknown(NAM4),
          wbUnknown(NAM5),
          wbUnknown(NAM6),
          wbUnknown(NAM7),
          wbUnknown(NAM8),
          wbUnknown(NAM9),
          wbCITCReq,
          wbCTDAsCount
        ], [])
      ], []),
      wbEmpty(BFCE, 'End Marker', cpIgnore, True)
    ], []);

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
  ]));

  wbSNAMMarkerParams :=
    wbArray(SNAM, 'Marker Parameters', wbStruct('Marker', [
      wbFloat('Offset X'),
      wbFloat('Offset Y'),
      wbFloat('Offset Z'),
      wbFloat('Rotation Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
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
      ])).IncludeFlag(dfCollapsed)),
      wbFromVersion(125, wbByteArray('Unknown', 3)),
      wbFromVersion(555, wbByteArray('Unknown', 4))
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
      wbByteArray('Unused', 3, cpIgnore),
      wbUnion('Function Type', wbOMODDataFunctionTypeDecider, [
        { Float }  wbInteger('Function Type', itU8, wbEnum(['SET', 'MUL+ADD', 'ADD'])),
        { Bool }   wbInteger('Function Type', itU8, wbEnum(['SET', 'AND', 'OR'])),
        { Enum }   wbInteger('Function Type', itU8, wbEnum(['SET'])),
        { FormID } wbInteger('Function Type', itU8, wbEnum(['SET', 'REM', 'ADD']))
      ]),
      wbByteArray('Unused', 3, cpIgnore),
      wbInteger('Property', itU16, wbObjectModPropertyToStr, wbObjectModPropertyToInt),
      wbByteArray('Unused', 2, cpIgnore),
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
        wbByteArray('Unused', 4, cpIgnore),
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
    wbByteArray('Unused', 1),
    wbInteger('Level Max', itU8),
    wbByteArray('Unused', 1),
    wbInteger('Addon Index', itS16{, wbOBTEAddonIndexToStr, nil, cpNormal, True, nil, nil, -1}),
    wbInteger('Default', itU8, wbBoolEnum),
    wbArray('Keywords', wbFormIDCk('Keyword', [KYWD, NULL]), -4),
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
    cpNormal, False, nil, wbOBTSCombinationsAfterSet)
  ], []);

  var wbBoneDataItem :=
    wbRStruct('Data', [
      wbRArray('Bone Datas',
        wbRStruct('Bone Data', [
          wbInteger(BSMP, 'Bone Scale Gender', itU32, wbEnum(['Male', 'Female'])),
          // should not be sorted!!!
          wbRArray('Bone Weight Scales',
            wbRStructSK([0], 'Bone Weight Scale', [
              wbString(BSMB, 'Name'),
              wbStruct(BSMS, 'Weight Scale Values', [
                wbStruct('Thin', [
                  wbFloat('X'),
                  wbFloat('Y'),
                  wbFloat('Z')
                ]),
                wbStruct('Muscular', [
                  wbFloat('X'),
                  wbFloat('Y'),
                  wbFloat('Z')
                ]),
                wbStruct('Fat', [
                  wbFloat('X'),
                  wbFloat('Y'),
                  wbFloat('Z')
                ])
              ])
            ], [])
          ),
          wbInteger(BMMP, 'Bone Modifiers Gender', itU32, wbEnum(['Male', 'Female'])),
          wbRArray('Bone Modifier',
            wbRStructSK([0], 'Bone', [
              wbString(BSMB, 'Name'),
              wbStruct(BSMS, 'Modifiers', [
                wbFloat('Min Y'),
                wbFloat('Min Z'),
                wbFloat('Max Y'),
                wbFloat('Max Z')
              ])
            ], [])
          )
        ],[])
      )
    ], []);

  var wbArmorAddonBoneDataItem :=
    wbRStruct('Data', [
      wbRArray('Bone Datas',
        wbRStruct('Bone Data', [
          wbInteger(BSMP, 'Bone Scale Gender', itU32, wbEnum(['Male', 'Female'])),
          // should not be sorted!!!
          wbRArray('Bone Weight Scales',
            wbRStructSK([0], 'Bone Weight Scale', [
              wbString(BSMB, 'Name'),
              wbStruct(BSMS, 'Weight Scale Values', [
                wbFloat('X'),
                wbFloat('Y'),
                wbFloat('Z')
              ])
            ], [])
          )
        ],[])
      )
    ], []);

  wbBSMPSequence := wbRArray('Bone Data', wbBoneDataItem);

  wbArmorAddonBSMPSequence := wbRArray('Bone Data', wbArmorAddonBoneDataItem);

  {subrecords checked against Starfield.esm}
  var wbEffect :=
    wbRStruct('Effect', [
      wbEFID,
      wbEFIT,
      wbCTDAs,
      wbUnknown(MNAM),
      wbUnknown(ANAM), // order between ANAM
      wbUnknown(ZNAM), // and ZNAM unknown
      wbUnknown(EFIF),
      wbUnknown(MUID)
    ], [], cpNormal, True);

  wbEffectsReq :=
    wbRArrayS('Effects', wbEffect, cpNormal, True);

  {subrecords checked against Starfield.esm}
  wbRecord(ACTI, 'Activator',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([  {flags not checked against Starfield}
      {0x00000004}  2, 'Never Fades',
      {0x00000010}  4, 'Non Occluder',
      {0x00000040}  6, 'Unknown 6',
      {0x00000080}  7, 'Heading Marker',
      {0x00000100}  8, 'Must Update Anims',
      {0x00000200}  9, 'Hidden From Local Map',
      {0x00000400} 10, 'Headtrack Marker',
      {0x00000800} 11, 'Used as Platform',
      {0x00001000} 13, 'Pack-In Use Only',
      {0x00008000} 15, 'Has Distant LOD',
      {0x00010000} 16, 'Random Anim Start',
      {0x00020000} 17, 'Dangerous',
      {0x00100000} 20, 'Ignore Object Interaction',
      {0x00800000} 23, 'Is Marker',
      {0x02000000} 25, 'Obstacle',
      {0x04000000} 26, 'NavMesh Generation - Filter',
      {0x08000000} 27, 'NavMesh Generation - Bounding Box',
      {0x20000000} 29, 'Child Can Use',
      {0x40000000} 30, 'NavMesh Generation - Ground'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbUnknown(XALG),
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel,
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbFTYP,
    wbNTRM,
    wbStruct(PNAM, 'Marker Color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbInteger('Unused', itU8)
    ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
//    wbFormIDCk(SNAM, 'Sound - Looping', [SNDR]),
//    wbFormIDCk(VNAM, 'Sound - Activation', [SNDR]),
//    wbFormIDCk(WNAM, 'Water Type', [WATR]),
    wbUnknown(WMAT),
    wbUnknown(WTFM),
    wbUnknown(ALSH),
    wbUnknown(ACSH),
    wbATTX,
    wbInteger(FNAM, 'Flags', itU16, wbFlags([
      'No Displacement',
      'Ignored by Sandbox',
      'Unknown 2',
      'Unknown 3',
      'Is a Radio'
    ])),
    wbUnknown(JNAM),
    wbUnknown(INAM), //unknown if here or any later position
//    wbFormIDCk(KNAM, 'Interaction Keyword', [KYWD]),
{    wbStruct(RADR, 'Radio Receiver', [
      wbFormIDCk('Sound Model', [SOPM, NULL]),
      wbFloat('Frequency'),
      wbFloat('Volume'),
      wbInteger('Starts Active', itU8, wbBoolEnum),
      wbInteger('No Signal Static', itU8, wbBoolEnum)
    ], cpNormal, False, nil, 4),}
    wbCITC,
    wbCTDAs,
    wbNVNM
  ], False, nil, cpNormal, False, nil, wbKeywordsAfterSet);

  wbRecord(TACT, 'Talking Activator',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000200}  9, 'Hidden From Local Map',
      {0x00010000} 16, 'Random Anim Start',
      {0x00020000} 17, 'Radio Station'
    ]), [17]), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbFULL,
    wbGenericModel,
    wbDEST,
    wbKSIZ,
    wbKWDAs,
    wbUnknown(PNAM, cpIgnore, True),
    wbFormIDCk(SNAM, 'Looping Sound', [SNDR]),
    wbUnknown(FNAM, cpIgnore, True),
    wbFormIDCk(VNAM, 'Voice Type', [VTYP])
  ], False, nil, cpNormal, False, nil, wbKeywordsAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(ALCH, 'Ingestible',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x20000000} 29, 'Medicine'
    ])), [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbPTT2,
    wbBaseFormComponents,
    wbXALG,
    wbFULL,
    wbKeywords,
    wbGenericModel,
    wbPUSHPDSH,
    wbUnknown(CUSH),
//    wbICON,
//    wbMICO,
//    wbYNAM,
//    wbZNAM,
//    wbETYP,
//    wbCUSD,
//    wbDEST,
    wbDESC,
    wbCVPA,
    wbArray(CDIX, 'Component Display Indices', wbInteger('Display Index', itU8)),
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
      ])),
      wbFormID('Addiction'),
      wbFloat('Addiction Chance'),
      wbFormIDCk('Sound - Consume', [SNDR, NULL]),
      wbUnknown
    ], cpNormal, True),
    wbLStringKC(DNAM, 'Addiction Name', 0, cpTranslate),
    wbEffectsReq
  ], False, nil, cpNormal, False, wbRemoveEmptyKWDA, wbKeywordsAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(AMMO, 'Ammunition',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  2, 'Non-Playable'
    ])), [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbPTT2,
    wbFULL,
    wbGenericModel,
    wbPUSHPDSH,
    wbDESC,
    wbKeywords,
//    wbDEST,
//    wbYNAM,
//    wbZNAM,
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
      ])),
      wbByteArray('Unused', 3),
      wbFloat('Damage'),
      wbInteger('Health', itU32)
    ], cpNormal, True),
    wbLStringKC(ONAM, 'Short Name', 0, cpTranslate),
    wbString(NAM1, 'Casing Model'),
    //wbModelInfo(NAM2)
    wbUnknown(FLLD)
  ], False, nil, cpNormal, False, wbRemoveEmptyKWDA, wbKeywordsAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(ANIO, 'Animated Object',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000200}  9, 'Unknown 9'
    ]), [9]), [
    wbEDID,
    wbXALG,
    wbBaseFormComponents,
    wbGenericModel
    //wbString(BNAM, 'Unload Event')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ARMO, 'Armor',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  2, 'Non-Playable',
      {0x00000040}  6, 'Shield',
      {0x00000400} 10, 'Unknown 10',
      {0x00008000} 15, 'Unknown 15'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
//    wbPTT2,
    wbPTT2,
    wbBaseFormComponents,
    wbFULL,
    wbEITM,
    wbTexturedModel('Male world model', [MOD2, MO2T], [wbMOLM(MLM2), wbMO2C, wbMO2S, wbMO2F]),
    wbTexturedModel('Female world model', [MOD4, MO4T], [wbMOLM(MLM4), wbMO4C, wbMO4S, wbMO4F]),
    wbUnknown(BO64),
    wbPUSHPDSH,
//    wbDEST,
//    wbYNAM,
//    wbZNAM,
//    wbETYP,
//    wbFormIDCk(BIDS, 'Block Bash Impact Data Set', [IPDS, NULL]),
    wbFormIDCk(BAMT, 'Alternate Block Material', [MATT, NULL]),
    wbFormIDCk(RNAM, 'Race', [RACE]),
    wbKeywords,
    wbDESC,
    wbINRD,
    wbRArray('Models',
      wbRStruct('Model', [
        wbInteger(INDX, 'Addon Index', itU16),
        wbFormIDCk(MODL, 'Armor Addon', [ARMA])
      ], [])
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
      wbByteArray('Unused', 3, cpIgnore, false, wbNeverShow)
    ]),
    wbArrayS(DAMA, 'Resistances', wbStructSK([0], 'Resistance', [
      wbFormIDCk('Damage Type', [DMGT]),
      wbInteger('Value', itU32)
    ])),
//    wbFormIDCk(TNAM, 'Template Armor', [ARMO]),
    wbAPPR,
    wbObjectTemplate,
    wbEmpty(STOP, 'Marker', cpNormal, True),
    wbUnknown(AVSG),
    wbUnknown(AFSG)
  ], False, nil, cpNormal, False, wbARMOAfterLoad, wbKeywordsAfterSet).SetIgnoreList([FLLD, XFLG]);

  {subrecords checked against Starfield.esm}
  wbRecord(ARMA, 'Armor Addon',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000040}  6, 'No Underarmor Scaling', //need to confirm
      {0x00000080}  7, 'Unknown 7',
      {0x00000100}  8, 'Unknown 8',
      {0x00000200}  9, 'Unknown 9',
      {0x40000000} 30, 'Hi-Res 1st Person Only' //need to confirm
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbUnknown(BO64),
    wbFormIDCk(RNAM, 'Race', [RACE]),
    wbStruct(DNAM, 'Data', [
      wbUnknown
      (*
      wbInteger('Male Priority', itU8),
      wbInteger('Female Priority', itU8),
      // essentialy a number of world models for different weights (Enabled = 2 models _0.nif and _1.nif)
      wbInteger('Weight slider - Male', itU8, wbFlags([
        {0x01} 'Unknown 0',
        {0x02} 'Enabled'
      ])),
      wbInteger('Weight slider - Female', itU8, wbFlags([
        {0x01} 'Unknown 0',
        {0x02} 'Enabled'
      ])),
      wbByteArray('Unknown', 2),
      wbInteger('Detection Sound Value', itU8),
      wbByteArray('Unknown', 1),
      wbFloat('Weapon Adjust')
      *)
    ], cpNormal, True),
    wbTexturedModel('Male world model',   [MOD2, MO2T], [wbMOLM(MLM1), wbMO2C, wbMO2S, wbMO2F]),
    wbTexturedModel('Female world model', [MOD3, MO3T], [wbMOLM(MLM2), wbMO3C, wbMO3S, wbMO3F]),
    wbTexturedModel('Male 1st person',    [MOD4, MO4T], [wbMOLM(MLM3), wbMO4C, wbMO4S, wbMO4F]),
    wbTexturedModel('Female 1st person',  [MOD5, MO5T], [wbMOLM(MLM4), wbMO5C, wbMO5S, wbMO5F]),
    wbTexturedModel('Skeleton',           [MOD6, MO6T], [wbMOLM(MLM5), wbMO6F]),
    //wbTexturedModel('Unknown',  [MOD7, MO7T], [wbMOLM(MLM6), wbMO7F]), does not occur in Starfield.esm, but the code support loading it

    wbFormIDCk(NAM4, 'Male world Morph', [MRPH]),
    wbFormIDCk(NAM5, 'Male 1st person Morph', [MRPH]),
    wbFormIDCk(NAM6, 'Female world Morph', [MRPH]),
    wbFormIDCk(NAM7, 'Female 1st person Morph', [MRPH]),

    wbRArrayS('Additional Races', wbFormIDCK(MODL, 'Race', [RACE, NULL])),
    wbFormIDCk(SNDD, 'Footstep Sound', [FSTS, NULL]),
    wbFormIDCk(ONAM, 'Art Object', [ARTO]),
    wbFormID(PNAM),
    wbUnknown(MNAM),
    wbString(TNAM),
    wbString(SNAM),
    wbString(VNAM),
    wbRStructs('Bone Datas', 'Bone Data', [
      wbInteger(BSMP, 'Gender', itU32, wbEnum(['Male', 'Female'])),
      wbRArray('Modifiers', wbFormIDCk(BNAM, 'Modifier', [BMOD]))
    ], [])
  ], False, nil, cpNormal, False, wbARMAAfterLoad).SetIgnoreList([FLLD, XFLG]);

  {subrecords checked against Starfield.esm}
  wbRecord(BOOK, 'Book', [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbPTT2,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel,
    wbDESCreq,
    wbPUSHPDSH,
//    wbDEST,
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
        {0x10} 'Add Perk',
        {0x20} 'Unknown 5'
      ])),
      wbUnion('Teaches', wbBOOKTeachesDecider, [
        wbByteArray('Unused', 4),
        wbFormIDCk('Actor Value', [AVIF, NULL]),
        wbFormIDCk('Spell', [SPEL, NULL]),
        wbFormIDCk('Perk', [PERK, NULL])
      ]),
      wbStruct('Text Offset' , [
        wbInteger('X', itU32),
        wbInteger('Y', itU32)
      ]),
      wbUnknown
    ], cpNormal, True),
    wbLStringKC(CNAM, 'Description', 0, cpTranslate),
    wbUnknown(ENAM),
    wbUnknown(FNAM),
    wbFormIDCk(INAM, 'Inventory Art', [STAT]),
    wbFormIDCk(GNAM, 'Scene', [SCEN])
  ], False, nil, cpNormal, False, nil, wbKeywordsAfterSet);
end;

procedure DefineSF1c;

  procedure ReferenceRecord(aSignature: TwbSignature; const aName: string);
  begin
    wbRefRecord(aSignature, aName,
      wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
          wbFormIDCk('Reference', [REFR]),
          wbInteger('Type', itU32, wbFlags([
            'Reflection',
            'Refraction'
          ]))
        ], cpNormal, False, nil, 1)
      ),
      wbRArrayS('Linked References', wbStructSK(XLKR, [0], 'Linked Reference', [
        wbFormIDCk('Keyword/Ref', [KYWD, PLYR, ACHR, REFR, PGRE, PHZD, PMIS, PARW, PBAR, PBEA, PCON, PFLA, NULL]),
        wbFormIDCk('Ref', sigReferences)
      ], cpNormal, False, nil, 1)),
      wbRStruct('Activate Parents', [
        wbInteger(XAPD, 'Flags', itU8, wbFlags([
          'Parent Activate Only'
        ], True)),
        wbRArrayS('Activate Parent Refs',
          wbStructSK(XAPR, [0], 'Activate Parent Ref', [
            wbFormIDCk('Reference', sigReferences),
            wbFloat('Delay')
          ])
        )
      ], []),

      wbFormIDCk(XASP, 'Unknown', [REFR]),
      wbUnknown(XATP),
      wbInteger(XAMC, 'Ammo Count', itU32),
      wbEmpty(XLKT, 'Linked Ref Transient'),
      wbFormIDCk(XLYR, 'Layer', [LAYR]),
      wbFormIDCk(XMSP, 'Material Swap', [MSWP]),
      wbFormIDCk(XRFG, 'Reference Group', [RFGP]),
      wbUnknown(XCVR),
      wbXESP,
      wbXOWN,
      wbXRNK,
      wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),
      wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),
      wbEmpty(XIS2, 'Ignored by Sandbox'),
      wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),
      wbFormIDCk(XLRL, 'Location Reference', [LCRT, LCTN, NULL], False, cpBenignIfAdded),
      wbXSCL,
      wbXLOD,
      wbDataPosRot,
      wbString(MNAM, 'Comments')
    ], True, wbPlacedAddInfo);
  end;

begin
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

  {subrecords checked against Starfield.esm}
  wbRecord(CELL, 'Cell',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000400}  7, 'No Pre Vis',
      {0x00000400} 10, 'Persistent',
      {0x00020000} 17, 'Off Limits',
      {0x00040000} 18, 'Compressed',
      {0x00080000} 19, 'Can''t Wait'
    ]), [18]), [
    wbEDID,
    wbBaseFormComponents,
    wbFULL,
    wbInteger(DATA, 'Flags', itU32, wbFlags([
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
    ]), cpNormal, True, False, nil, wbCELLDATAAfterSet),

    wbCellGrid,

    wbStruct(XCLL, 'Lighting', [
      wbByteColors('Ambient Color'),
      wbByteColors('Directional Color'),
      wbByteColors('Fog Color Near'),
      wbFloat('Fog Near'),
      wbFloat('Fog Far'),
      wbInteger('Directional Rotation XY', itS32),
      wbInteger('Directional Rotation Z', itS32),
      wbFloat('Directional Fade'),
      wbFloat('Fog Clip Distance'),
      wbFloat('Fog Power'),
      wbAmbientColors,
      wbByteColors('Fog Color Far'),
      wbFloat('Fog Max'),
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
      ])),
      wbFloat('Near Height Mid'),
      wbFloat('Near Height Range'),
      wbByteColors('Fog Color High Near'),
      wbByteColors('Fog Color High Far'),
      wbFloat('High Density Scale'),
      wbFloat('Fog Near Scale'),
      wbFloat('Fog Far Scale'),
      wbFloat('Fog High Near Scale'),
      wbFloat('Fog High Far Scale'),
      wbFloat('Far Height Mid'),
      wbFloat('Far Height Range')
    ], cpNormal, False, nil, 11),

    wbMaxHeightDataCELL,

    wbFormIDCk(LTMP, 'Lighting Template', [LGTM, NULL], False, cpNormal, True),

    {>>> XCLW sometimes has $FF7FFFFF and causes invalid floation point <<<}
    wbFloat(XCLW, 'Water Height', cpNormal, False, 1, -1, nil, nil, 0, wbCELLXCLWGetConflictPriority),

    wbUnknown(XILS),
    wbRStructs('Unknown', 'Unknown', [
      wbUnknown(XCLA),
      wbString(XCLD)
    ], []),

    wbFormIDCk(XLCN, 'Location', [LCTN]),

    wbByteArray(XWCN, 'Unknown', 0, cpIgnore), // leftover
    wbStruct(XWCU, 'Water Velocity', [
      wbFloat('X Offset'),
      wbFloat('Y Offset'),
      wbFloat('Z Offset'),
      wbByteArray('Unknown', 4),
      wbFloat('X Angle'),
      wbFloat('Y Angle'),
      wbFloat('Z Angle'),
      wbByteArray('Unknown', 0)
    ]),
    wbFormIDCk(XCWT, 'Water', [WATR]),

    {--- Ownership ---}
    wbXOWN,
//    wbXRNK,

//    wbFormIDCk(XILL, 'Lock List', [FLST, NPC_]),

{
    wbStruct(XILW, 'Exterior LOD', [
      wbFormIDCk('Worldspace', [WRLD]),
      wbFloat('Offset X'),
      wbFloat('Offset Y'),
      wbFloat('Offset Z')
    ]),
}
    wbString(XWEM, 'Water Environment Map'),
    wbFormIDCk(XCCM, 'Sky/Weather from Region', [REGN]),
    wbFormIDCk(XCAS, 'Acoustic Space', [ASPC]),
//    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),
    wbFormIDCk(XCMO, 'Music Type', [MUSC]),
    wbFormIDCk(XCIM, 'Image Space', [IMGS]),
//    wbFormIDCk(XGDR, 'God Rays', [GDRY]),

    wbUnknown(TODD),
    wbUnknown(XBPS),
    wbUnknown(XCGD),
    wbUnknown(XCIB),
    wbUnknown(XCWM),
    wbString(XEMP),
    wbUnknown(XTV2)
  ], True, wbCellAddInfo, cpNormal, False{, wbCELLAfterLoad});

  {subrecords checked against Starfield.esm}
  wbRecord(CLAS, 'Class', [
    wbEDID,
    wbFULLReq,
    wbDESCReq,
    wbPRPS,
    wbStruct(DATA, 'Data', [
      wbUnknown(4)
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CLMT, 'Climate', [
    wbEDID,
    wbArrayS(WLST, 'Weather Types', wbStructSK([0], 'Weather Type', [
      wbFormIDCk('Weather', [WTHR, NULL]),
      wbInteger('Chance', itS32),
      wbFormIDCk('Global', [GLOB, NULL])
    ])),
    wbArrayS(WSLT, 'Weather Settings', wbStructSK([0], 'Weather Settings', [
      wbFormIDCk('Weather Settings', [WTHS, NULL]),
      wbInteger('Chance', itS32),
      wbFormIDCk('Global', [GLOB, NULL])
    ])),
    wbClimateTiming(wbClmtTime, nil)
  ]);

  wbRecord(SPGD, 'Shader Particle Geometry', [
    wbEDID,
    wbStruct(DATA, 'Data', [
      wbFloat('Gravity Velocity'),
      wbByteArray('Unknown', 4),
      wbFloat('Rotation Velocity'),
      wbByteArray('Unknown', 4),
      wbFloat('Particle Size X'),
      wbFloat('Center Offset Min'),
      wbFloat('Particle Size Y'),
      wbByteArray('Unknown', 4),
      wbFloat('Center Offset Min'),
      wbByteArray('Unknown', 4),
      wbFloat('Center Offset Max'),
      wbByteArray('Unknown', 4),
      wbFloat('Initial Rotation'),
      wbByteArray('Unknown', 4),
      wbInteger('# of Subtextures X', itU32),
      wbByteArray('Unknown', 4),
      wbInteger('# of Subtextures Y', itU32),
      wbByteArray('Unknown', 4),
      wbInteger('Type', itU32, wbEnum([
        'Rain',
        'Snow'
      ])),
      wbByteArray('Unknown', 4),
      wbInteger('Box Size', itU32),
      wbByteArray('Unknown', 4),
      wbFloat('Particle Density'),
      wbUnknown
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
      ]))
    ], cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CONT, 'Container',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00008000} 15, 'Has Distant LOD',
      {0x00010000} 16, 'Random Anim Start',
      {0x02000000} 25, 'Obstacle',
      {0x04000000} 26, 'NavMesh Generation - Filter',
      {0x08000000} 27, 'NavMesh Generation - Bounding Box',
      {0x40000000} 30, 'NavMesh Generation - Ground'
    ])), [

    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbUnknown(XALG),
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel,
    wbUnknown(XFLG),
    wbContainerItems,
    wbDEST,
    wbStruct(DATA, '', [
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'Allow Sounds When Animation',
        {0x02} 'Respawns',
        {0x04} 'Show Owner',
        {0x08} 'Unknown 3'
      ]))
//      wbFloat('Weight')
    ], cpNormal, True),
    wbKeywords,
    wbFTYP,
    wbPRPS,
    wbAPPR,
//    wbObjectTemplate, likely, but doesn't occur in Starfield.esm
    wbEmpty(STOP, 'Marker'),
    wbWED01,
    wbFormIDCk(ONAM, 'Display Filter', [FLST])
  ], False, nil, cpNormal, False, nil, wbContainerAfterSet);

  wbAIDT :=
    wbStruct(AIDT, 'AI Data', [
     {00} wbInteger('Aggression', itU8, wbEnum([
            'Unaggressive',
            'Aggressive',
            'Very Aggressive',
            'Frenzied'
          ])),
     {01} wbInteger('Confidence', itU8, wbEnum([
            'Cowardly',
            'Cautious',
            'Average',
            'Brave',
            'Foolhardy'
          ])),
     {02} wbInteger('Energy Level', itU8),
     {03} wbInteger('Responsibility', itU8, wbEnum([
            'Any crime',
            'Violence against enemies',
            'Property crime only',
            'No crime'
          ])),
     {04} wbInteger('Mood', itU8, wbEnum([
            'Neutral',
            'Angry',
            'Fear',
            'Happy',
            'Sad',
            'Surprised',
            'Puzzled',
            'Disgusted'
          ])),
          wbInteger('Assistance', itU8, wbEnum([
            'Helps Nobody',
            'Helps Allies',
            'Helps Friends and Allies'
          ])),
          wbStruct('Aggro', [
            wbInteger('Aggro Radius Behavior', itU8, wbBoolEnum),
            wbInteger('Unknown', itU8),
            wbInteger('Warn', itU32),
            wbInteger('Warn/Attack', itU32),
            wbInteger('Attack', itU32)
          ]),
          wbFromVersion(29, wbInteger('No Slow Approach', itU8, wbBoolEnum)),
          wbFromVersion(29, wbByteArray('Unknown', 3))
    ], cpNormal, True, nil{wbActorTemplateUseAIData});

  {subrecords checked against Starfield.esm}
  wbRecord(CSTY, 'Combat Style',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00080000} 19, 'Allow Dual Wielding'
    ])), [
    wbEDID,
    wbStruct(CSGD, 'General', [
      wbFloat('Offensive Mult'),
      wbFloat('Defensive Mult'),
      wbFloat('Group Offensive Mult'),
      wbFloat('Equipment Score Mult - Melee'),
      wbFloat('Equipment Score Mult - Magic'),
      wbFloat('Equipment Score Mult - Ranged'),
      wbFloat('Equipment Score Mult - Shout'),
      wbFloat('Equipment Score Mult - Unarmed'),
      wbFloat('Equipment Score Mult - Staff'),
      wbFloat('Avoid Threat Chance'),
      wbFloat('Dodge Threat Chance'),
      wbFloat('Evade Threat Chance'),
      wbUnknown
    ], cpNormal, True),
//    wbUnknown(CSMD, cpIgnore),
    wbStruct(CSME, 'Melee', [
      wbFloat('Attack Staggered Mult'),
      wbFloat('Power Attack Staggered Mult'),
      wbFloat('Power Attack Blocking Mult'),
      wbFloat('Bash Mult'),
      wbFloat('Bash Recoil Mult'),
      wbFloat('Bash Attack Mult'),
      wbFloat('Bash Power Attack Mult'),
      wbFloat('Special Attack Mult'),
      wbFloat('Block When Staggered Mult'),
      wbFloat('Attack When Staggered Mult')
    ], cpNormal, True, nil, 9),
    wbStruct(CSRA, 'Ranged Accuracy', [
      wbFloat('Ranged Accuracy Mult', cpNormal, True),
      wbUnknown
    ], cpNormal, True),
    wbStruct(CSCR, 'Close Range', [
      wbFloat('Dueling - Circle Mult'),
      wbFloat('Dueling - Fallback Mult'),
      wbFloat('Flanking - Flank Distance'),
      wbFloat('Flanking - Stalk Time'),
      wbFloat('Charging - Charge Distance'),
      wbFloat('Charging - Throw Probability'),
      wbFloat('Charging - Sprint Fast Probability'),
      wbFloat('Charging - Sideswipe Probability'),
      wbFloat('Charging - Disengane Probability'),
      wbInteger('Charging - Throw Max Targets', itU32),
      wbFloat('Flanking - Flank Variance'),
      wbUnknown
    ], cpNormal, True),
    wbStruct(CSLR, 'Long Range', [
      wbFloat('Strafe Mult'),
      wbFloat('Adjust Range Mult'),
      wbFloat('Crouch Mult'),
      wbFloat('Wait Mult'),
      wbFloat('Range Mult'),
      wbUnknown
    ], cpNormal, True, nil, 3),
    wbStruct(CSCV, 'Cover Search', [
      wbFloat('Cover Search Distance Mult', cpNormal, True),
      wbUnknown
    ], cpNormal, True),
    wbStruct(CSFL, 'Flight', [
      wbFloat('Hover Chance'),
      wbFloat('Dive Bomb Chance'),
      wbFloat('Ground Attack Chance'),
      wbFloat('Hover Time'),
      wbFloat('Ground Attack Time'),
      wbFloat('Perch Attack Chance'),
      wbFloat('Perch Attack Time'),
      wbFloat('Flying Attack Chance'),
      wbUnknown
    ], cpNormal, True),
    wbUnknown(CSTN),
    wbUnknown(CSSG),
    wbUnknown(CSSM),
    wbUnknown(CSSR),
    wbUnknown(CSSA),
    wbUnknown(CSSD),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      {0x01} 'Dueling',
      {0x02} 'Flanking',
      {0x04} 'Allow Dual Wielding',
      {0x08} 'Charging',
      {0x10} 'Retarget Any Nearby Melee Target',
      {0x20} 'Unknown 5',
      {0x40} 'Unknown 6',
      {0x80} 'Unknown 7'
    ]), cpNormal, True),
    wbUnknown(FNAM),
    wbFormIDCk(TNAM, 'Unknown', [CSTY]),
    wbArray(UNAM, 'Unknown', wbFormIDCk('Unknown', [NULL, CSTY]), 17)
  ]);
end;

procedure DefineSF1d;
begin
  {subrecords checked against Starfield.esm}
  wbRecord(DIAL, 'Dialog Topic', [
    wbEDID,
    wbBaseFormComponents, // unknown if before or after FULL
    wbFULL,
    wbFloat(PNAM, 'Priority', cpNormal, True, 1, -1, nil, nil, 50.0),
    wbFormIDCkNoReach(BNAM, 'Branch', [DLBR]),
    wbFormIDCkNoReach(QNAM, 'Quest', [QUST], False, cpNormal, False),
    wbFormIDCk(KNAM, 'Keyword', [KYWD]),
    wbUnknown(ANAM),
    wbStruct(DATA, 'Data', [
      // this should not be named Flags since TwbFile.BuildReachable
      // expects Top-Level flag here from FNV
      wbInteger('Topic Flags', itU8, wbFlags([
        'Do All Before Repeating',
        'Unknown 1',
        'Unknown 2'
      ]), cpNormal, True),
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
    wbArray(TIFL, 'Unknown', wbFormIDCk('Unknown', [INFO])),
    wbInteger(TIFC, 'Info Count', itU32, nil, cpBenign),
    wbArray(INOM, 'INFO Order (Masters only)', wbFormIDCk('INFO', [INFO], False, cpBenign).IncludeFlag(dfUseLoadOrder), 0, nil, nil, cpBenign).IncludeFlag(dfInternalEditOnly).IncludeFlag(dfDontSave).IncludeFlag(dfDontAssign),
    wbArray(INOA, 'INFO Order (All previous modules)', wbFormIDCk('INFO', [INFO], False, cpBenign).IncludeFlag(dfUseLoadOrder), 0, nil, nil, cpBenign).IncludeFlag(dfInternalEditOnly).IncludeFlag(dfDontSave).IncludeFlag(dfDontAssign)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(DOOR, 'Door',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000010}  4, 'Non Occluder',
      {0x00008000} 15, 'Has Distant LOD',
      {0x00010000} 16, 'Random Anim Start',
      {0x00800000} 23, 'Is Marker'
    ])), [

    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbUnknown(XALG),
//    wbPTT2,
//    wbSNTP,
//    wbSNBH,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel,
//    wbDEST,
    wbKeywords,
    wbNTRM,
    wbFTYP,
    wbPRPS,

    wbUnknown(DOSH),
    wbUnknown(DCSH),
    wbUnknown(DLSH),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      '',
      'Automatic',
      'Hidden',
      'Minimal Use',
      'Sliding',
      'Do Not Open in Combat Search',
      'No "To" Text'
    ]), cpNormal, True),
    wbLStringKC(ONAM, 'Alternate Text - Open', 0, cpTranslate),
    wbLStringKC(CNAM, 'Alternate Text - Close', 0, cpTranslate),
    wbUnknown(DEVT),
    wbUnknown(ANAM),
    wbNVNM
  ]);

  wbBlendModeEnum := wbEnum([
    '',
    'Zero',
    'One',
    'Source Color',
    'Source Inverse Color',
    'Source Alpha',
    'Source Inverted Alpha',
    'Dest Alpha',
    'Dest Inverted Alpha',
    'Dest Color',
    'Dest Inverse Color',
    'Source Alpha SAT'
  ]);

  wbBlendOpEnum := wbEnum([
    '',
    'Add',
    'Subtract',
    'Reverse Subtract',
    'Minimum',
    'Maximum'
  ]);

  wbZTestFuncEnum := wbEnum([
    '',
    '',
    '',
    'Equal To',
    '',
    'Greater Than',
    '',
    'Greater Than or Equal To'
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(EFSH, 'Effect Shader', [
    wbEDID,
    wbBaseFormComponents,
    wbFormIDCk(ENAM, 'Unknown', [EFSQ]),
    wbEmpty(DATA, 'Empty', cpIgnore),
    wbStruct(DNAM, 'Data', [
      wbUnknown
    ]),
    wbGenericModel
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ENCH, 'Object Effect', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbFULL,
    wbStruct(ENIT, 'Effect Data', [
      wbInteger('Enchantment Cost', itS32),
      wbInteger('Flags', itU32, wbFlags([
        'No Auto-Calc',
        '',
        'Extend Duration On Recast'
      ])),
      wbInteger('Cast Type', itU32, wbCastEnum),
      wbInteger('Enchantment Amount', itS32),
      wbInteger('Target Type', itU32, wbTargetEnum),
      wbInteger('Enchant Type', itU32, wbEnum([], [
        $06, 'Enchantment',
        $0C, 'Staff Enchantment'
      ])),
      wbFloat('Charge Time'),
      wbFormIDCk('Base Enchantment', [ENCH, NULL]),
      wbFormIDCk('Worn Restrictions', [FLST, NULL]),
      wbUnknown
    ], cpNormal, True, nil, 8),
    wbEffectsReq
  ]);

  wbRecord(EYES, 'Eyes',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
    ]), cpNormal, True)
  ]);

  var wbFactionRank :=
    wbRStructSK([0], 'Rank', [
      wbInteger(RNAM, 'Rank#', itU32),
      wbLString(MNAM, 'Male Title', 0, cpTranslate),
      wbLString(FNAM, 'Female Title', 0, cpTranslate),
      wbString(INAM, 'Insignia (unused)')
    ], []);

  {subrecords checked against Starfield.esm}
  wbRecord(FACT, 'Faction', [
    wbEDID,
    wbBaseFormComponents,
    wbFULL,
    wbFactionRelations,
    wbFormIDCk(DNAM, 'Unknown', [KYWD]),
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
        {0x00010000} 'Unknown 16',
        {0x00020000} 'Unknown 17',
        {0x00040000} 'Unknown 18'
      ]))
    ], cpNormal, True, nil, 1),
//    wbFormIDCk(JAIL, 'Exterior Jail Marker', [REFR]),
//    wbFormIDCk(WAIT, 'Follower Wait Marker', [REFR]),
//    wbFormIDCk(STOL, 'Stolen Goods Container', [REFR]),
//    wbFormIDCk(PLCN, 'Player Inventory Container', [REFR]),
    wbFormIDCk(CRGR, 'Shared Crime Faction List', [FLST]),
//    wbFormIDCk(JOUT, 'Jail Outfit', [OTFT]),
    wbStruct(CRVA, 'Crime Values', [
      wbInteger('Arrest', itU8, wbBoolEnum),
      wbInteger('Attack On Sight', itU8, wbBoolEnum),
      wbInteger('Murder', itU16),
      wbInteger('Assault', itU16),
      wbInteger('Trespass', itU16),
      wbInteger('Pickpocket', itU16),
      wbInteger('Unknown', itU16),
      wbFloat('Steal Multiplier'),
      wbInteger('Escape', itU16),
      wbUnknown
    ], cpNormal, False, nil, 7),
//    wbRArrayS('Ranks', wbFactionRank),
    wbFormIDCk(VEND, 'Vendor Buy/Sell List', [FLST]),
    wbFormIDCk(VENC, 'Merchant Container', [REFR]),
    wbArray(PRIS, 'Unknown', wbFormIDCk('Unknown', [NULL, REFR])), //could be earlier, can't determine from data
    wbStruct(VENV, 'Vendor Values', [
      wbInteger('Start Hour', itU16),
      wbInteger('End Hour', itU16),
      wbInteger('Radius', itU16),
      wbByteArray('Unknown 1', 2),
      wbInteger('Buys Stolen Items', itU8, wbBoolEnum),
      wbInteger('Buy/Sell Everything Not In List?', itU8, wbBoolEnum),
      wbInteger('Buys NonStolen Items', itU8, wbBoolEnum),
      wbInteger('Unknown', itU8)
    ]),
    wbPLVD,
    wbFormIDCk(VTCK, 'Unknown', [FLST, VTYP]),
    wbRStruct('Unknown', [
      wbEmpty(CRHR, 'Marker').SetRequired(True),
      wbUnknown(HERD).SetRequired(True)
    ], []),
    wbRStruct('Unknown', [
      wbEmpty(CRGP, 'Marker').SetRequired(True),
      wbUnknown(GRPH).SetRequired(True)
    ], [])

    //wbCITC,
    //wbCTDAsCount
  ], False, nil, cpNormal, False, nil {wbFACTAfterLoad}, wbConditionsAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(AFFE, 'Affinity Event', [
    wbEDID,
    wbUnknown(FNAM, 4).SetRequired, //req
    wbUnknown(NLDT),
    wbRStructsSK('Unknown', 'Unknown', [0], [
      wbFormIDCk(NNAM, 'Actor', [NPC_]),
      wbFormIDCk(RNAM, 'Reaction', [GLOB]).SetRequired
    ], []),
    wbFormIDCk(ANAM, 'Actor Value', [AVIF]).SetRequired,
    wbFormIDCk(ENAM, 'Size', [GLOB]).SetRequired,
    wbFormIDCk(DNAM, 'Distance', [GLOB]),
    wbFormIDCk(CNAM, 'Cooldown', [GLOB]),
    wbFormIDCk(BNAM, 'Faction', [FACT])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(FURN, 'Furniture',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  2, 'Has Container',
      {0x00000010}  4, 'Unknown 4',
      {0x00000080}  7, 'Is Perch',
      {0x00000100}  8, 'Unknown',
      {0x00000200}  9, 'Unknown' ,
      {0x00000400} 10, 'Unknown' ,
      {0x00002000} 13, 'Unknown 13',
      {0x00008000} 15, 'Has Distant LOD',
      {0x00010000} 16, 'Random Anim Start',
      {0x00020000} 17, 'Unknown',
      {0x00800000} 23, 'Is Marker',
      {0x02000000} 25, 'Power Armor',
      {0x08000000} 27, 'Unknown',
      {0x10000000} 28, 'Must Exit To Talk',
      {0x20000000} 29, 'Child Can Use'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel,
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbFTYP,
    wbUnknown(PNAM),
    wbATTX,
    wbUnknown(ALSH),
    wbInteger(FNAM, 'Flags', itU16, wbFlags([
      {0x0001} 'Unknown 0',
      {0x0002} 'Ignored By Sandbox'
    ])),
    wbUnknown(JNAM),
    wbUnknown(INAM),
    wbMNAMFurnitureMarker,
    wbUnknown(GNAM),
    wbStruct(WBDT, 'Workbench Data', [
      wbInteger('Bench Type', itU8, wbEnum([
        {0} 'None',
        {1} 'Create Object', // used only for MS11Workbench [FURN:00091FD5]
        {2} 'Weapons', // used for the Weapons (plural) workbench
        {3} 'Enchanting (unused)', // not used
        {4} 'Enchanting Experiment (unused)', // not used
        {5} 'Alchemy', // used for Cooking, Industrial, Pharmaceutical
        {6} 'Alchemy Experiment (unused)', // not used
        {7} 'Armor', // aka Spacesuit workbench
        {8} 'Power Armor', // used for Power Armor stations
        {9} 'Robot Mod', // used for Robot stations
       {10} 'Unknown 10',
       {11} 'Research'
      ])),
      wbInteger('Uses Skill', itS8, wbSkillEnum)
    ], cpNormal, True, nil, 1),
    wbUnknown(FTMP),
    wbRArray('Marker Entry Points', wbStruct(FNPR, 'Marker', [
      wbInteger('Type', itU16, wbFurnitureAnimTypeEnum),
      wbInteger('Entry Points', itU16, wbFurnitureEntryTypeFlags)
    ])),
    wbString(XMRK, 'Marker Model'),
    wbSNAMMarkerParams,
    wbArray(NNAM, 'Marker Files', wbStruct('Marker', [
      wbString('Name'),
      wbString('Model FileName')
      ])),
    //wbObjectTemplate, not in Starfield.esm, but based on the STOP below likely...
    wbEmpty(STOP, 'Marker', cpNormal, True)
  ], False, nil, cpNormal, False, nil, wbKeywordsAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(GLOB, 'Global',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000040}  6, 'Constant'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    {
    wbInteger(FNAM, 'Type', itU8, wbEnum([], [
             0, 'Unknown',
      Ord('s'), 'Short',
      Ord('l'), 'Long',
      Ord('f'), 'Float',
      Ord('b'), 'Boolean'
    ]), cpNormal, True).SetDefaultEditValue('Float'),
    }
    wbFloat(FLTV, 'Value', cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(GMST, 'Game Setting', [
    wbString(EDID, 'Editor ID', 0, cpCritical, True, nil, wbGMSTEDIDAfterSet),
    wbXALG,
    wbUnion(DATA, 'Value', wbGMSTUnionDecider, [
      wbLString('Name', 0, cpTranslate),
      wbInteger('Int', itS32),
      wbFloat('Float'),
      wbInteger('Bool', itU32, wbBoolEnum)
    ], cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(KYWD, 'Keyword',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00080000} {15} 15, 'Restricted'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbCNAM,
    wbString(DNAM, 'Notes'),
    wbInteger(TNAM, 'Type', itU32, wbKeywordTypeEnum),
    wbUnknown(FNAM),
    wbUnknown(ENAM),
    wbFormIDCk(DATA, 'Attraction Rule', [AORU]),
    wbFULL
    //wbString(NNAM, 'Display Name') {Legacy record replaced with FULL}
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(FFKW, 'Form Folder Keyword List', [
    wbEDID,
    wbUnknown(REFL)
  ]);

end;

procedure DefineSF1e;
begin
  wbRecord(LCRT, 'Location Reference Type', [
    wbEDID,
    wbCNAM,
    wbUnknown(TNAM)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AACT, 'Action',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00080000} {15} 15, 'Restricted'
    ])), [
    wbEDID,
    wbCNAM,
    wbString(DNAM, 'Notes'),
    wbInteger(TNAM, 'Type', itU32, wbKeywordTypeEnum),
//    wbFormIDCk(DATA, 'Attraction Rule', [AORU]),
//    wbFULL,
    wbUnknown(FNAM)
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
    ], []).SetSummaryKey([0]),
    wbDODT,
    wbInteger(DNAM, 'Flags', itU16, wbFlags([
      {0x0001} 'No Specular Map',
      {0x0002} 'Facegen Textures',
      {0x0004} 'Has Model Space Normal Map'
    ]), cpNormal, True),
    wbString(MNAM, 'Material')
  ]).SetSummaryKey([2, 3]);

  wbRecord(HDPT, 'Head Part',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
    ]), cpNormal, True),
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
    ])),
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
    ], [])),
    wbFormIDCk(TNAM, 'Texture Set', [TXST]),
    wbFormIDCk(CNAM, 'Color', [CLFM]),
    wbFormIDCk(RNAM, 'Valid Races', [FLST]),
    wbCTDAs
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ASPC, 'Acoustic Space', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbUnknown(ASLS),
    wbWED01,
    wbFormIDCk(AAMB, 'Ambient Set', [AMBS]),
    wbFormIDCk(AMUS, 'Music', [MUSC]),
    wbFormIDCk(BNAM, 'Environment Type', [REVB]),
    wbUnknown(AEAR),
    wbUnknown(FLTV),
    wbInteger(XTRI, 'Is Interior', itU8, wbBoolEnum, cpNormal, True),
    wbUnknown(BOLV),
    wbUnknown(DEVT),
    wbUnknown(ASDF)
  ]);

  wbRecord(MSTT, 'Moveable Static',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000100}  8, 'Must Update Anims',
      {0x00000200}  9, 'Hidden From Local Map',
      {0x00000800} 11, 'Used As Platform',
      {0x00002000} 13, 'Pack-In Use Only',
      {0x00008000} 15, 'Has Distant LOD',
      {0x00010000} 16, 'Random Anim Start',
      {0x00080000} 19, 'Has Currents',
      {0x02000000} 25, 'Obstacle',
      {0x04000000} 26, 'NavMesh Generation - Filter',
      {0x08000000} 27, 'NavMesh Generation - Bounding Box',
      {0x40000000} 30, 'NavMesh Generation - Ground'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbDEFL,
    wbUnknown(XALG),
    wbBaseFormComponents,
    wbPTT2,
    wbFULL,
    wbGenericModel,
    wbUnknown(XFLG),
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbInteger(DATA, 'On Local Map', itU8, wbBoolEnum, cpNormal, True),
    wbUnknown(MSLS),
    wbFloat(MSMO, 'Unknown'),
    wbFormIDCk(SNAM, 'Looping Sound', [SNDR])
  ]);
end;

procedure DefineSF1f;
begin
  wbRecord(IDLM, 'Idle Marker',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x20000000} 29, 'Child Can Use'
    ])), [
    wbEDID,
    wbOBND(True),
    wbKSIZ,
    wbKWDAs,
    wbInteger(IDLF, 'Flags', itU8, wbFlags([
      'Run in Sequence',
      'Unknown 1',
      'Do Once',
      'Unknown 3',
      'Ignored by Sandbox'
    ]), cpNormal, False),
    wbInteger(IDLC, 'Animation Count', itU8, nil, cpBenign),
    wbFloat(IDLT, 'Idle Timer Setting', cpNormal, False),
    wbArray(IDLA, 'Animations', wbFormIDCk('Animation', [IDLE]), 0, nil, wbIDLAsAfterSet, cpNormal, False),
    wbFormIDCk(QNAM, 'Unknown', [KYWD]),
    wbGenericModel
  ], False, nil, cpNormal, False, nil, wbAnimationsAfterSet);

  wbRecord(PROJ, 'Projectile', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel,
    wbDEST,
    wbUnknown(DATA),
    wbUnknown(PROD),
    (*
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
      ])),
      wbInteger('Type', itU16, wbEnum([], [
        $01, 'Missile',
        $02, 'Lobber',
        $04, 'Beam',
        $08, 'Flame',
        $10, 'Cone',
        $20, 'Barrier',
        $40, 'Arrow'
      ])),
      wbFloat('Gravity'),
      wbFloat('Speed'),
      wbFloat('Range'),
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
      wbFloat('Collision Radius'),
      wbFloat('Lifetime'),
      wbFloat('Relaunch Interval'),
      wbFormIDCk('Decal Data', [TXST, NULL]),
      wbFormIDCk('Collision Layer', [COLL, NULL]),
      wbInteger('Tracer Frequency', itU8),
      wbFormIDCk('VATS Projectile', [PROJ, NULL])
    ]),

    *)
    wbRStructSK([0], 'Muzzle Flash Model', [
      wbString(NAM1, 'Model FileName'),
      wbUnknown(FLLD)
      //wbModelInfo(NAM2)
    ], [], cpNormal, True),
    wbUnknown(PRAS),
    wbUnknown(PRCS),
    wbInteger(VNAM, 'Sound Level', itU32, wbSoundLevelEnum, cpNormal, True),
    wbFormID(NAM3)
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
      wbFloat('Target Interval'),
      wbInteger('Flags', itU32, wbFlags([
        {0x01} 'Affects Player Only',
        {0x02} 'Inherit Duration from Spawn Spell',
        {0x04} 'Align to Impact Normal',
        {0x08} 'Inherit Radius from Spawn Spell',
        {0x10} 'Drop to Ground',
        {0x20} 'Taper Effectiveness by Proximity'
      ])),
      wbFormIDCk('Effect', [SPEL, ENCH, NULL]),
      wbFormIDCk('Light', [LIGH, NULL]),
      wbFormIDCk('Impact Data Set', [IPDS, NULL]),
      wbFormIDCk('Sound', [SNDR, NULL]),
      wbStruct('Taper Effectiveness', [
        wbFloat('Full Effect Radius'),
        wbFloat('Taper Weight'),
        wbFloat('Taper Curse')
      ])
    ])
  ]);

  if wbSimpleRecords then begin

    wbRecord(NAVI, 'Navigation Mesh Info Map', [
      wbEDID,
      wbInteger(NVER, 'Version', itU32),
      wbRArray('Navigation Map Infos',
        wbStruct(NVMI, 'Navigation Map Info', [
          wbFormIDCk('Navigation Mesh', [NAVM]),
          wbByteArray('Data', 20),
          wbArray('Merged To', wbFormIDCk('Mesh', [NAVM]), -1),
          wbArray('Preferred Merges', wbFormIDCk('Mesh', [NAVM]), -1),
          wbArray('Linked Doors', wbStruct('Door', [
            wbByteArray('Unknown', 4),
            wbFormIDCk('Door Ref', [REFR])
          ]), -1),
          wbInteger('Is Island', itU8, wbBoolEnum),
          wbUnion('Island', wbNAVIIslandDataDecider, [
            wbNull,
            wbStruct('Island Data', [
              wbByteArray('Unknown', 24),
              wbArray('Triangles', wbByteArray('Triangle', 6), -1),
              wbArray('Vertices', wbByteArray('Vertex', 12), -1)
            ])
          ]),
          wbStruct('Pathing Cell', [
            wbInteger('CRC Hash', itU32, wbCRCValuesEnum).SetDefaultEditValue('3C A0 E9 A5'),
            wbFormIDCk('Parent Worldspace', [WRLD, NULL]),
            wbUnion('Parent', wbNAVIParentDecider, [
              wbStruct('Coordinates', [
                wbInteger('Grid Y', itS16),
                wbInteger('Grid X', itS16)
              ]),
              wbFormIDCk('Parent Cell', [CELL])
            ])
          ])
        ])
      ),
      wbStruct(NVPP, 'Preferred Pathing', [
        wbArray('NavMeshes', wbArray('Set', wbFormIDCk('', [NAVM]), -1), -1),
        wbArray('NavMesh Tree?', wbStruct('', [
          wbFormIDCk('NavMesh', [NAVM]),
          wbInteger('Index/Node', itU32)
        ]), -1)
      ]),
      //wbArray(NVSI, 'Unknown', wbFormIDCk('Navigation Mesh', [NAVM]))
      wbUnknown(NVSI)
    ]);

    wbRecord(NAVM, 'Navigation Mesh',
      wbFlags(wbRecordFlagsFlags, wbFlagsList([
        {0x00040000} 18, 'Compressed',
        {0x04000000} 26, 'AutoGen',
        {0x80000000} 31, 'Unknown 31'
      ]), [18]), [
      wbEDID,
      wbNVNM,
      wbFormID(ONAM),
      wbUnknown(NNAM),
      wbMNAMNAVM
    ], False, wbNAVMAddInfo);

  end else begin

    wbRecord(NAVI, 'Navigation Mesh Info Map', [
      wbEDID,
      wbInteger(NVER, 'Version', itU32),
      wbRArray('Navigation Map Infos',
        wbStruct(NVMI, 'Navigation Map Info', [
          wbFormIDCk('Navigation Mesh', [NAVM]),
          wbByteArray('Unknown 1', 4), //Only the first byte is used
          wbFloat('X'),
          wbFloat('Y'),
          wbFloat('Z'),
          wbFloat('Unknown float 2'),
          //wbInteger('Preferred Merges Flag', itU32),
          wbArray('Merged To', wbFormIDCk('Mesh', [NAVM]), -1),
          wbArray('Preferred Merges', wbFormIDCk('Mesh', [NAVM]), -1),
          wbArray('Linked Doors', wbStruct('Door', [
            wbInteger('Door Type', itu32, wbNavmeshDoorTypeEnum),
            wbFormIDCk('Door Ref', [REFR])
          ]), -1),
          wbInteger('Is Island', itU8, wbBoolEnum),
          wbUnion('Island', wbNAVIIslandDataDecider, [
            wbNull,
            wbStruct('Island Data', [
              wbFloat('Min X'),
              wbFloat('Min Y'),
              wbFloat('Min Z'),
              wbFloat('Max X'),
              wbFloat('Max Y'),
              wbFloat('Max Z'),
              wbArray('Triangles',
                wbStruct('Triangle', [
                  wbArray('Vertices', wbInteger('Vertex', itS16), 3)
                ])
              , -1),
              wbArray('Vertices', wbStruct('Vertex', [
                wbFloat('X'),
                wbFloat('Y'),
                wbFloat('Z')
              ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3), -1)
            ])
          ]),
          wbStruct('Pathing Cell', [
            wbInteger('CRC Hash', itU32, wbCRCValuesEnum).SetDefaultEditValue('3C A0 E9 A5'),
            wbFormIDCk('Parent Worldspace', [WRLD, NULL]),
            wbUnion('Parent', wbNAVIParentDecider, [
              wbStruct('Coordinates', [
                wbInteger('Grid Y', itS16),
                wbInteger('Grid X', itS16)
              ]),
              wbFormIDCk('Parent Cell', [CELL])
            ])
          ])
        ])
      ),
      wbStruct(NVPP, 'Preferred Pathing', [
        wbArray('NavMeshes', wbArray('Set', wbFormIDCk('', [NAVM]), -1), -1),
        wbArray('NavMesh Tree?', wbStruct('', [
          wbFormIDCk('NavMesh', [NAVM]),
          wbInteger('Index/Node', itU32)
        ]), -1)
      ]),
      wbArray(NVSI, 'Unknown', wbFormIDCk('Navigation Mesh', [NAVM]))
    ]);

    wbRecord(NAVM, 'Navigation Mesh',
      wbFlags(wbRecordFlagsFlags, wbFlagsList([
        {0x00040000} 18, 'Compressed',
        {0x04000000} 26, 'AutoGen'
      ]), [18]), [
      wbEDID,
      wbNVNM,
      wbFormID(ONAM),
      wbArray(NNAM, 'Unknown', wbInteger('Unknown', itU16)),
      wbMNAMNAVM
    ], False, wbNAVMAddInfo);

  end;

end;

procedure DefineSF1g;
begin
  {subrecords checked against Starfield.esm}
  wbRecord(EXPL, 'Explosion', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbXALG,
    wbDEFL,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel,
    wbEITM,
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD]),
    wbUnknown(ENAM),
    wbStruct(DAMA, 'Damage', [
      wbFormIDCk('Damage Type', [DMGT]),
      wbUnknown
    ])
    (*
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
      ])),
      wbInteger('Sound Level', itU32, wbSoundLevelEnum),
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
    *)
  ]);

  {subrecords checked against Starfield.esm}
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
      wbFloat('Eye Adapt Speed'),
      wbFloat('Tonemap E'),
      wbFloat('Bloom Threshold'),
      wbFloat('Bloom Scale'),
      wbFloat('Auto Exposure Max'),
      wbFloat('Auto Exposure Min'),
      wbFloat('Sunlight Scale'),
      wbFloat('Sky Scale'),
      wbFloat('Middle Gray')
    ], cpNormal, True),
    wbStruct(CNAM, 'Cinematic', [
      wbFloat('Saturation'),
      wbFloat('Brightness'),
      wbFloat('Contrast')
    ], cpNormal, True),
    wbStruct(TNAM, 'Tint', [
      wbFloat('Amount'),
      wbFloatColors('Color')
    ], cpNormal, True),
    wbStruct(DNAM, 'Depth of Field', [
      wbFloat('Strength'),
      wbFloat('Distance'),
      wbFloat('Range'),
      wbByteArray('Unused', 2, cpIgnore),
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
      ])),
      wbFloat('Vignette Radius'),
      wbFloat('Vignette Strength')
    ], cpNormal, True, nil, 5),
    wbString(TX00, 'LUT')
  ]);

  wbRecord(IMAD, 'Image Space Adapter', [
    wbEDID,
    wbStruct(DNAM, 'Data', [
      wbInteger('Animatable', itU32, wbBoolEnum),
      wbFloat('Duration'),
      wbStruct('HDR', [
        wbInteger('Eye Adapt Speed Mult Count', itU32),
        wbInteger('Eye Adapt Speed Add Count', itU32),
        wbInteger('Bloom Blur Radius Mult Count', itU32),
        wbInteger('Bloom Blur Radius Add Count', itU32),
        wbInteger('Bloom Threshold Mult Count', itU32),
        wbInteger('Bloom Threshold Add Count', itU32),
        wbInteger('Bloom Scale Mult Count', itU32),
        wbInteger('Bloom Scale Add Count', itU32),
        wbInteger('Target Lum Min Mult Count', itU32),
        wbInteger('Target Lum Min Add Count', itU32),
        wbInteger('Target Lum Max Mult Count', itU32),
        wbInteger('Target Lum Max Add Count', itU32),
        wbInteger('Sunlight Scale Mult Count', itU32),
        wbInteger('Sunlight Scale Add Count', itU32),
        wbInteger('Sky Scale Mult Count', itU32),
        wbInteger('Sky Scale Add Count', itU32)
      ]),
      wbInteger('Unused08 Mult Count', itU32),
      wbInteger('Unused48 Add Count', itU32),
      wbInteger('Unused09 Mult Count', itU32),
      wbInteger('Unused49 Add Count', itU32),
      wbInteger('Unused0A Mult Count', itU32),
      wbInteger('Unused4A Add Count', itU32),
      wbInteger('Unused0B Mult Count', itU32),
      wbInteger('Unused4B Add Count', itU32),
      wbInteger('Unused0C Mult Count', itU32),
      wbInteger('Unused4C Add Count', itU32),
      wbInteger('Unused0D Mult Count', itU32),
      wbInteger('Unused4D Add Count', itU32),
      wbInteger('Unused0E Mult Count', itU32),
      wbInteger('Unused4E Add Count', itU32),
      wbInteger('Unused0F Mult Count', itU32),
      wbInteger('Unused4F Add Count', itU32),
      wbInteger('Unused10 Mult Count', itU32),
      wbInteger('Unused50 Add Count', itU32),
      wbStruct('Cinematic', [
        wbInteger('Saturation Mult Count', itU32),
        wbInteger('Saturation Add Count', itU32),
        wbInteger('Brightness Mult Count', itU32),
        wbInteger('Brightness Add Count', itU32),
        wbInteger('Contrast Mult Count', itU32),
        wbInteger('Contrast Add Count', itU32),
        wbInteger('Unused14 Mult Count', itU32),
        wbInteger('Unused54 Add Count', itU32)
      ]),
      wbInteger('Tint Color Count', itU32),
      wbInteger('Blur Radius Count', itU32),
      wbInteger('Double Vision Strength Count', itU32),
      wbInteger('Radial Blur Strength Count', itU32),
      wbInteger('Radial Blur Ramp Up Count', itU32),
      wbInteger('Radial Blur Start Count', itU32),
      wbInteger('Radial Blur Use Target', itU32, wbBoolEnum),
      wbFloat('Radial Blur Center X'),
      wbFloat('Radial Blur Center Y'),
      wbInteger('DoF Strength Count', itU32),
      wbInteger('DoF Distance Count', itU32),
      wbInteger('DoF Range Count', itU32),
      wbInteger('DoF Use Target', itU8, wbBoolEnum),
      wbInteger('DoF Flags', itU8, wbFlags([
        {0x00000001} 'Mode - Front',
        {0x00000002} 'Mode - Back',
        {0x00000004} 'No Sky',
        {0x00000008} 'Blur Radius Bit 2',
        {0x00000010} 'Blur Radius Bit 1',
        {0x00000020} 'Blur Radius Bit 0'
      ])),
      wbInteger('Unused', itU16),
      wbInteger('Radial Blur Ramp Down Count', itU32),
      wbInteger('Radial Blur Down Start Count', itU32),
      wbInteger('Fade Color Count', itU32),
      wbInteger('Motion Blur Strength Count', itU32),
      wbFromSize(248, wbInteger('Vignette Radius Count', itU32)),
      wbFromSize(252, wbInteger('Vignette Strength Count', itU32))
    ]),
    wbTimeInterpolators(BNAM, 'Blur Radius'),
    wbTimeInterpolators(VNAM, 'Double Vision Strength'),
    wbArray(TNAM, 'Tint Color', wbColorInterpolator),
    wbArray(NAM3, 'Fade Color', wbColorInterpolator),
    wbRStruct('Radial Blur', [
      wbTimeInterpolators(RNAM, 'Strength'),
      wbTimeInterpolators(SNAM, 'Ramp Up'),
      wbTimeInterpolators(UNAM, 'Start'),
      wbTimeInterpolators(NAM1, 'Ramp Down'),
      wbTimeInterpolators(NAM2, 'Down Start')
    ], []),
    wbRStruct('Depth of Field', [
      wbTimeInterpolators(WNAM, 'Strength'),
      wbTimeInterpolators(XNAM, 'Distance'),
      wbTimeInterpolators(YNAM, 'Range'),
      wbTimeInterpolators(NAM5, 'Vignette Radius'),
      wbTimeInterpolators(NAM6, 'Vignette Strength')
    ], []),
    wbTimeInterpolators(NAM4, 'Motion Blur Strength'),
    wbRStruct('HDR', [
      wbTimeInterpolatorsMultAdd(_00_IAD, _40_IAD, 'Eye Adapt Speed'),
      wbTimeInterpolatorsMultAdd(_01_IAD, _41_IAD, 'Bloom Blur Radius'),
      wbTimeInterpolatorsMultAdd(_02_IAD, _42_IAD, 'Bloom Threshold'),
      wbTimeInterpolatorsMultAdd(_03_IAD, _43_IAD, 'Bloom Scale'),
      wbTimeInterpolatorsMultAdd(_04_IAD, _44_IAD, 'Target Lum Min'),
      wbTimeInterpolatorsMultAdd(_05_IAD, _45_IAD, 'Target Lum Max'),
      wbTimeInterpolatorsMultAdd(_06_IAD, _46_IAD, 'Sunlight Scale'),
      wbTimeInterpolatorsMultAdd(_07_IAD, _47_IAD, 'Sky Scale')
    ], []),
    wbTimeInterpolatorsMultAdd(_08_IAD, _48_IAD, 'Unused'),
    wbTimeInterpolatorsMultAdd(_09_IAD, _49_IAD, 'Unused'),
    wbTimeInterpolatorsMultAdd(_0A_IAD, _4A_IAD, 'Unused'),
    wbTimeInterpolatorsMultAdd(_0B_IAD, _4B_IAD, 'Unused'),
    wbTimeInterpolatorsMultAdd(_0C_IAD, _4C_IAD, 'Unused'),
    wbTimeInterpolatorsMultAdd(_0D_IAD, _4D_IAD, 'Unused'),
    wbTimeInterpolatorsMultAdd(_0E_IAD, _4E_IAD, 'Unused'),
    wbTimeInterpolatorsMultAdd(_0F_IAD, _4F_IAD, 'Unused'),
    wbTimeInterpolatorsMultAdd(_10_IAD, _50_IAD, 'Unused'),
    wbCinematicIMAD
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(FLST, 'FormID List', [
    wbString(EDID, 'Editor ID', 0, cpBenign, True, nil, wbFLSTEDIDAfterSet),
    wbBaseFormComponents,
    wbFULL,
    wbRArrayS('FormIDs', wbFormID(LNAM, 'FormID'), cpNormal, False, nil, nil, nil, wbFLSTLNAMIsSorted),
    wbRStructs('Conditional Entries', 'Conditional Entry', [
      wbInteger(INAM, 'Index', itU32),
      wbCITCReq,
      wbCTDAsCount.SetRequired(True)
    ], [])
  ]);

  var wbPerkConditions :=
    wbRStructSK([0], 'Perk Condition', [
      wbInteger(PRKC, 'Run On (Tab Index)', itS8{, wbPRKCToStr, wbPRKCToInt}),
      wbCTDAsReq
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
        ]))
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
  ], []);

  wbRecord(PERK, 'Perk',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  2, 'Non-Playable'
    ])), [
    wbEDID,
    wbVMADFragmentedPERK,
    wbFULL,
    wbDESCReq,
    wbString(ICON, 'Image'),
    wbCTDAs,
    wbStruct(DATA, 'Data', [
      wbInteger('Trait', itU8, wbBoolEnum),
      wbInteger('Level', itU8),
      wbInteger('Num Ranks', itU8),
      wbFromSize(4, wbInteger('Playable', itU8, wbBoolEnum)),
      wbFromSize(5, wbInteger('Hidden', itU8, wbBoolEnum))
    ], cpNormal, True),
    wbFormIDCk(SNAM, 'Sound', [SNDR]),
    wbFormIDCK(NNAM, 'Next Perk', [PERK, NULL]),
    wbString(FNAM, 'SWF'),
    wbRArrayS('Effects', wbPerkEffect)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(BPTD, 'Body Part Data', [
    wbEDID,
    wbGenericModel,
    wbRArrayS('Body Parts',
      wbRStructSK([1], 'Body Part', [
        wbLString(BPTN, 'Part Name', 0, cpTranslate), // optional
        wbString(BPNN, 'Part Node', 0, cpNormal, True),
        wbString(BPNT, 'VATS Target', 0, cpNormal, True),
        (*
        wbStruct(BPND, '', [
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
          wbFloat('Gore Effects - Local Rotate X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
          wbFloat('Gore Effects - Local Rotate Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
          wbFloat('Cut - Tesselation'),
          wbFormIDCk('Severable - Impact DataSet', [IPDS, NULL]),
          wbFormIDCk('Explodable - Impact DataSet', [IPDS, NULL]),
          wbFloat('Explodable - Limb Replacement Scale'),
          wbInteger('Flags', itU8, wbFlags([
            {0x01} 'Severable',
            {0x02} 'Hit Reaction',
            {0x04} 'Hit Reaction - Default',
            {0x08} 'Explodable',
            {0x10} 'Cut - Meat Cap Sever',
            {0x20} 'On Cripple',
            {0x40} 'Explodable - Absolute Chance',
            {0x80} 'Show Cripple Geometry'
          ])),
          wbInteger('Part Type', itU8, wbEnum([
            { 0} 'Torso',
            { 1} 'Head1',
            { 2} 'Eye',
            { 3} 'LookAt',
            { 4} 'Fly Grab',
            { 5} 'Head2',
            { 6} 'LeftArm1',
            { 7} 'LeftArm2',
            { 8} 'RightArm1',
            { 9} 'RightArm2',
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
        ], cpNormal, True),
        *)
        wbUnknown(BPD2),
//        wbString(NAM1, 'Limb Replacement Model', 0, cpNormal, True),
        wbString(NAM4, 'Gore Effects - Target Bone', 0, cpNormal, True),
//        wbModelInfo(NAM5),
        wbString(ENAM, 'Hit Reaction - Start'),
        wbString(FNAM, 'Hit Reaction - End'),
//        wbFormIDCk(BNAM, 'Gore Effects - Dismember Blood Art', [ARTO]),
        wbFormIDCk(INAM, 'Gore Effects - Blood Impact Material Type', [MATT]),
//        wbFormIDCk(JNAM, 'On Cripple - Blood Impact Material Type', [MATT]),
//        wbFormIDCk(CNAM, 'Meat Cap TextureSet', [TXST]),
//        wbFormIDCk(NAM2, 'Collar TextureSet', [TXST]),
        wbString(DNAM, 'Twist Variable Prefix')
      ], [], cpNormal, False, nil, True)
    )
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ADDN, 'Addon Node', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbBaseFormComponents,
    wbGenericModel,
    wbInteger(DATA, 'Node Index', itS32, nil, cpNormal, True),
    //wbFormIDCk(SNAM, 'Sound', [SNDR]),
    wbFormIDCk(LNAM, 'Light', [LIGH]),
    wbUnknown(PSDF),
    wbStruct(DNAM, 'Data', [
      wbInteger('Master Particle System Cap', itU16),
      wbInteger('Flags', itU16, wbEnum([
        'No Master Particle System',
        'Master Particle System',
        'Always Loaded',
        'Master Particle System and Always Loaded'
      ]))
    ], cpNormal, True)
  ]);
end;

procedure DefineSF1h;
begin
  {subrecords checked against Starfield.esm}
  wbRecord(AVIF, 'Actor Value Information', [
    wbEDID,
    wbFULL,
    wbString(NLDT),
    wbLString(ANAM, 'Abbreviation', 0, cpTranslate),
    wbFloat(NAM0, 'Default Value'), // Prior to form version 81, it was either 0.0, 1.0 or 100.0, so scale or multiplier ?
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
    ])),
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
    ])),
    wbUnknown(NAM2),
    wbUnknown(NAM3)
  ]); // S.P.E.C.I.A.L start at index 5, so FormID 0x2bc+5 to 0x2bc+11, RadResistIngestion at index 0x29

  {subrecords checked against Starfield.esm}
  wbRecord(CAMS, 'Camera Shot', [
    wbEDID,
    wbGenericModel,
    wbKeywords,
    wbString(NLDT), //unknown if before or after CTDAs
    wbCTDAs,
    wbStruct(DATA, 'Data', [
      wbInteger('Action', itU32, wbEnum([
        {0} 'Shoot',
        {1} 'Fly',
        {2} 'Hit',
        {3} 'Zoom'
      ])),
      wbInteger('Location', itU32, wbEnum([
        {0} 'Attacker',
        {1} 'Projectile',
        {2} 'Target',
        {3} 'Lead Actor'
      ])),
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
        {0x00000080} 'Don''t Reset Target Spring',
        {0x00000100} 'Unknown 8',
        {0x00000200} 'Unknown 9'
      ])),
      wbStruct('Time Multipliers', [
        wbFloat('Player'),
        wbFloat('Target'),
        wbFloat('Global')
      ]),
      wbFloat('Max Time'),
      wbFloat('Min Time'),
      wbFloat('Target % Between Actors'),
      wbFloat('Near Target Distance'),
      wbFloat('Location Spring'),
      wbFloat('Target Spring'),
      wbStruct('Rotation Offset', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3)
    ], cpNormal, True, nil, 9),
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD]),
    wbString(GNAM)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CPTH, 'Camera Path', [
    wbEDID,
    wbCTDAs,
    wbArray(ANAM, 'Related Camera Paths', wbFormIDCk('Related Camera Path', [CPTH, NULL]), ['Parent', 'Previous Sibling'], cpNormal, True),
    wbInteger(DATA, 'Camera Zoom / Flags', itU8, wbFlags([
      {0x01} 'Disable',
      {0x02} 'Shot List',
      {0x04} 'Dynamic Camera Times',
      {0x08} 'Unknown 3',
      {0x10} 'Unknown 4',
      {0x20} 'Unknown 5',
      {0x40} 'Randomize Paths',
      {0x80} 'Not Must Have Camera Shots'
    ]), cpNormal, True),
    wbRArray('Camera Shots', wbFormIDCk(SNAM, 'Camera Shot', [CAMS]))
  ]);

  wbRecord(VTYP, 'Voice Type', [
    wbEDID,
    wbInteger(DNAM, 'Flags', itU8, wbFlags([
      'Allow Default Dialog',
      'Female'
    ]), cpNormal, True)
  ]);

  wbRecord(MATT, 'Material Type', [
    wbEDID,
    wbFormIDCk(PNAM, 'Material Parent', [MATT, NULL]),
    wbString(MNAM, 'Material Name'),
    wbStruct(CNAM, 'Havok Display Color', [
      wbFloat('Red', cpNormal, True, 255, 0),
      wbFloat('Green', cpNormal, True, 255, 0),
      wbFloat('Blue', cpNormal, True, 255, 0)
    ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
    wbFloat(BNAM, 'Buoyancy'),
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      'Stair Material',
      'Arrows Stick',
      'Can Tunnel'
    ], False)),
    wbFormIDCk(HNAM, 'Havok Impact Data Set', [IPDS]),
    wbString(ANAM, 'Breakable FX'),
    wbMODT
  ]);

  wbRecord(IPCT, 'Impact', [
    wbEDID,
    wbGenericModel,
    wbStruct(DATA, '', [
      wbFloat('Effect - Duration'),
      wbInteger('Effect - Orientation', itU32, wbEnum([
        'Surface Normal',
        'Projectile Vector',
        'Projectile Reflection'
      ])),
      wbFloat('Angle Threshold'),
      wbFloat('Placement Radius'),
      wbInteger('Sound Level', itU32, wbSoundLevelEnum),
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'No Decal Data'
      ])),
      wbInteger('Impact Result', itU8, wbEnum([
         {0} 'Default',
         {1} 'Destroy',
         {2} 'Bounce',
         {3} 'Impale',
         {4} 'Stick'
      ])),
      wbByteArray('Unknown', 2)
    ], cpNormal, True),
    wbDODT,
    wbFormIDCk(DNAM, 'Texture Set', [TXST]),
    wbFormIDCk(ENAM, 'Secondary Texture Set', [TXST]),
    wbFormIDCk(SNAM, 'Sound 1', [SNDR]),
    wbFormIDCk(NAM1, 'Sound 2', [SNDR]),
    wbFormIDCk(NAM3, 'Footstep Explosion', [EXPL]),
    wbFormIDCk(NAM2, 'Hazard', [HAZD]),
    wbFloat(FNAM, 'Footstep Particle Max Dist')
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
      ])),
      wbInteger('Max Level', itS8)
    ], cpNormal, True)
  ]);

  wbRecord(LCTN, 'Location',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000800} 11, 'Interior Cells Use Ref Location for world map player marker',
      {0x00004000} 14, 'Partial Form'
    ])), [
    wbEDID,

    wbArray(ACPR, 'Actor Cell Persistent Reference', wbStruct('', [
      wbFormIDCk('Actor', sigReferences, False, cpBenign),
      wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
      wbInteger('Grid Y', itS16, nil, cpBenign),
      wbInteger('Grid X', itS16, nil, cpBenign)
    ])),
    wbArray(LCPR, 'Location Cell Persistent Reference', wbStruct('', [
      wbFormIDCk('Actor', sigReferences, False, cpBenign),
      wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
      wbInteger('Grid Y', itS16, nil, cpBenign),
      wbInteger('Grid X', itS16, nil, cpBenign)
    ])),
    wbArray(RCPR, 'Reference Cell Persistent Reference', wbFormIDCk('Ref', [ACHR, REFR], False, cpBenign)),

    wbArray(ACUN, 'Actor Cell Unique', wbStruct('', [
      wbFormIDCk('Actor', [NPC_], False, cpBenign),
      wbFormIDCk('Ref', [ACHR], False, cpBenign),
      wbFormIDCk('Location', [LCTN, NULL], False, cpBenign)
    ])),
    wbArray(LCUN, 'Location Cell Unique', wbStruct('', [
      wbFormIDCk('Actor', [NPC_], False, cpBenign),
      wbFormIDCk('Ref', [ACHR], False, cpBenign),
      wbFormIDCk('Location', [LCTN, NULL], False, cpBenign)
    ])),
    wbArray(RCUN, 'Reference Cell Unique', wbFormIDCk('Actor', [NPC_], False, cpBenign)),

    wbArray(ACSR, 'Actor Cell Static Reference', wbStruct('', [
      wbFormIDCk('Loc Ref Type', [LCRT], False, cpBenign),
      wbFormIDCk('Marker', sigReferences, False, cpBenign),
      wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
      wbInteger('Grid Y', itS16, nil, cpBenign),
      wbInteger('Grid X', itS16, nil, cpBenign)
    ])),
    wbArray(LCSR, 'Location Cell Static Reference', wbStruct('', [
      wbFormIDCk('Loc Ref Type', [LCRT], False, cpBenign),
      wbFormIDCk('Marker', sigReferences, False, cpBenign),
      wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
      wbInteger('Grid Y', itS16, nil, cpBenign),
      wbInteger('Grid X', itS16, nil, cpBenign)
    ])),
    wbArray(RCSR, 'Reference Cell Static Reference', wbFormIDCk('Ref', [ACHR, REFR], False, cpBenign)),

    wbRArray('Actor Cell Encounter Cell',
      wbStruct(ACEC, 'Unknown', [
        wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
        wbArray('Coordinates', wbStruct('', [
          wbInteger('Grid Y', itS16, nil, cpBenign),
          wbInteger('Grid X', itS16, nil, cpBenign)
        ]))
      ])
    ),
    wbRArray('Location Cell Encounter Cell',
      wbStruct(LCEC, 'Unknown', [
        wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
        wbArray('Coordinates', wbStruct('', [
          wbInteger('Grid Y', itS16, nil, cpBenign),
          wbInteger('Grid X', itS16, nil, cpBenign)
        ]))
      ])
    ),
    wbRArray('Reference Cell Encounter Cell',
      wbStruct(RCEC, 'Unknown', [
        wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
        wbArray('Coordinates', wbStruct('', [
          wbInteger('Grid Y', itS16, nil, cpBenign),
          wbInteger('Grid X', itS16, nil, cpBenign)
        ]))
      ])
    ),

    wbArray(ACID, 'Actor Cell Marker Reference', wbFormIDCk('Ref', sigReferences, False, cpBenign)),
    wbArray(LCID, 'Location Cell Marker Reference', wbFormIDCk('Ref', sigReferences, False, cpBenign)),

    wbArray(ACEP, 'Actor Cell Enable Point', wbStruct('', [
      wbFormIDCk('Actor', sigReferences, False, cpBenign),
      wbFormIDCk('Ref', sigReferences, False, cpBenign),
      wbInteger('Grid Y', itS16, nil, cpBenign),
      wbInteger('Grid X', itS16, nil, cpBenign)
    ])),
    wbArray(LCEP, 'Location Cell Enable Point', wbStruct('', [
      wbFormIDCk('Actor', sigReferences, False, cpBenign),
      wbFormIDCk('Ref', sigReferences, False, cpBenign),
      wbInteger('Grid Y', itS16, nil, cpBenign),
      wbInteger('Grid X', itS16, nil, cpBenign)
    ])),

    wbFULL,
    wbKSIZ,
    wbKWDAs,
    wbFormIDCk(PNAM, 'Parent Location', [LCTN, NULL]),
    wbFormIDCk(NAM1, 'Music', [MUSC, NULL]),
    wbFormIDCk(FNAM, 'Unreported Crime Faction', [FACT]),
    wbFormIDCk(MNAM, 'World Location Marker Ref', [REFR, ACHR]),
    wbFloat(RNAM, 'World Location Radius'),
    //wbFormIDCk(NAM0, 'Horse Marker Ref', [REFR]),
    wbFloat(ANAM, 'Actor Fade Mult'),
    wbCNAM
  ], False, nil, cpNormal, False, nil, wbKeywordsAfterSet);

end;

{this is required to prevent XE6 compiler error}
type
  TVarRecs = array of TVarRec;

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


procedure DefineSF1i;
var
  a, b, c : TVarRecs;
begin
  var wbMenuButton :=
    wbRStruct('Menu Button', [
      wbLStringKC(ITXT, 'Button Text', 0, cpTranslate),
      wbCTDAs
    ], []);

  wbRecord(MESG, 'Message', [
    wbEDID,
    wbDESCReq,
    wbFULL,
    wbFormIDCk(INAM, 'Icon (unused)', [NULL], False, cpIgnore, True), // leftover
    wbFormIDCk(QNAM, 'Owner Quest', [QUST]),
    wbInteger(DNAM, 'Flags', itU32, wbFlags([
      'Message Box',
      'Delay Initial Display'
    ]), cpNormal, True, False, nil, wbMESGDNAMAfterSet),
    wbInteger(TNAM, 'Display Time', itU32, nil, cpNormal, False, False, wbMESGTNAMDontShow),
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

  {subrecords checked against Starfield.esm}
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
      wbFloat('Directional Fade'),
      wbFloat('Fog Clip Distance'),
      wbFloat('Fog Power'),
      wbByteArray('Unused', 32, cpIgnore),
      wbByteColors('Fog Color Far'),
      wbFloat('Fog Max'),
      wbFloat('Light Fade Begin'),
      wbFloat('Light Fade End'),
      wbByteArray('Unused', 4, cpIgnore),
      wbFloat('Near Height Mid'),
      wbFloat('Near Height Range'),
      wbByteColors('Fog Color High Near'),
      wbByteColors('Fog Color High Far'),
      wbFloat('High Density Scale'),
      wbFloat('Fog Near Scale'),
      wbFloat('Fog Far Scale'),
      wbFloat('Fog High Near Scale'),
      wbFloat('Fog High Far Scale'),
      wbFloat('Far Height Mid'),
      wbFloat('Far Height Range')
    ], cpNormal, True, nil, 15),
    wbAmbientColors(DALC),
    wbFormIDCk(WGDR, 'God Rays', [GDRY])
  ]);

  wbRecord(MUSC, 'Music Type', [
    wbEDID,
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      {0x01} 'Plays One Selection',
      {0x02} 'Abrupt Transition',
      {0x04} 'Cycle Tracks',
      {0x08} 'Maintain Track Order',
      {0x10} 'Unknown 5',
      {0x20} 'Ducks Current Track',
      {0x40} 'Doesn''t Queue'
    ]), cpNormal, True),
    wbStruct(PNAM, 'Data', [
      wbInteger('Priority', itU16),
      wbInteger('Ducking (dB)', itU16, wbDiv(100))
    ]),
    wbFloat(WNAM, 'Fade Duration'),
    wbArray(TNAM, 'Music Tracks', wbFormIDCk('Track', [MUST, NULL]))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(FSTP, 'Footstep', [
    wbEDID,
    wbFormIDCk(DATA, 'Impact Data Set', [IPDS, NULL], False, cpNormal, True),
    wbString(ANAM, 'Tag', 0, cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(FSTS, 'Footstep Set', [
    wbEDID,
    wbStruct(XCNT, 'Count', [
      wbInteger('Walking', itU32),
      wbInteger('Running', itU32),
      wbInteger('Sprinting', itU32),
      wbInteger('Sneaking', itU32),
      wbInteger('Swimming', itU32)
    ], cpNormal, True),
    wbArray(DATA, 'Footstep Sets', wbFormIDCk('Footstep', [FSTP]), 0, nil, nil, cpNormal, True)
  ]);

  wbSMNodeFlags := wbFlags([
    'Random',
    'Warn if no child quest started'
  ]);

  wbRecord(SMBN, 'Story Manager Branch Node', [
    wbEDID,
    wbFormIDCkNoReach(PNAM, 'Parent ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCkNoReach(SNAM, 'Previous Sibling ', [SMQN, SMBN, SMEN, NULL], False, cpBenign),
    wbCITCReq,
    wbCTDAsCount,
    wbInteger(DNAM, 'Flags', itU32, wbSMNodeFlags),
    wbInteger(XNAM, 'Max concurrent quests', itU32)
  ], False, nil, cpNormal, False, nil, wbConditionsAfterSet);

  wbRecord(SMQN, 'Story Manager Quest Node', [
    wbEDID,
    wbFormIDCkNoReach(PNAM, 'Parent ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCkNoReach(SNAM, 'Previous Sibling ', [SMQN, SMBN, SMEN, NULL], False, cpBenign),
    wbCITCReq,
    wbCTDAsCount,
    wbStruct(DNAM, 'Flags', [
      wbInteger('Node Flags', itU16, wbSMNodeFlags),
      wbInteger('Quest Flags', itU16, wbFlags([
        'Do all before repeating',
        'Shares event',
        'Num quests to run'
      ]))
    ]),
    wbInteger(XNAM, 'Max concurrent quests', itU32),
    wbInteger(MNAM, 'Num quests to run', itU32),
    wbFloat(HNAM, 'Hours until reset'),
    wbInteger(QNAM, 'Quest Count', itU32, nil, cpBenign, True),
    wbRArray('Quests', wbRStructSK([0], 'Quest', [
      wbFormIDCk(NNAM, 'Quest', [QUST]),
      wbInteger(FNAM, 'Flags', itU32, wbEmptyBaseFlags),
      wbFloat(RNAM, 'Hours until reset', cpNormal, False, 1/24)
    ], []), cpNormal, False, nil, wbSMQNQuestsAfterSet)
  ], False, nil, cpNormal, False, nil, wbConditionsAfterSet);

  wbRecord(SMEN, 'Story Manager Event Node', [
    wbEDID,
    wbFormIDCkNoReach(PNAM, 'Parent ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCkNoReach(SNAM, 'Previous Sibling ', [SMQN, SMBN, SMEN, NULL], False, cpBenign),
    wbCITCReq,
    wbCTDAsCount,
    wbInteger(DNAM, 'Flags', itU32, wbSMNodeFlags),
    wbInteger(XNAM, 'Max concurrent quests', itU32),
    wbInteger(ENAM, 'Type', itU32, wbQuestEventEnum)
  ], False, nil, cpNormal, False, nil, wbConditionsAfterSet)
    .SetSummaryKey([7]);
end;

procedure DefineSF1j;
begin
  {subrecords checked against Starfield.esm}
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
    ])),
    wbFormIDCk(SNAM, 'Starting Topic', [DIAL], False, cpNormal, True)
  ]);

  wbRecord(MUST, 'Music Track', [
    wbEDID,
    wbInteger(CNAM, 'Track Type', itU32, wbEnum([], [
      Int64($23F678C3), 'Palette',
      Int64($6ED7E048), 'Single Track',
      Int64($A1A9C4D5), 'Silent Track'
    ]), cpNormal, True),
    wbFloat(FLTV, 'Duration'),
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
    wbCTDAsCount,
    wbArray(SNAM, 'Tracks', wbFormIDCk('Track', [MUST, NULL]))
  ], False, nil, cpNormal, False, nil, wbConditionsAfterSet);

  wbRecord(DLVW, 'Dialog View', [
    wbEDID,
    wbFormIDCk(QNAM, 'Quest', [QUST], False, cpNormal, True),
    wbRArray('Branches', wbFormIDCk(BNAM, 'Branch', [DLBR])),
    wbRArray('Unknown TNAM', wbRStruct('Unknown', [
      wbUnknown(TNAM)
    ], [])),
    wbUnknown(ENAM),
    wbUnknown(DNAM)
  ]);

  {wbRecord(WOOP, 'Word of Power', [
    wbEDID
  ]);}

  {wbRecord(SHOU, 'Shout', [
    wbEDID
  ]);}

  {subrecords checked against Starfield.esm}
  wbRecord(EQUP, 'Equip Type', [
    wbEDID,
    wbArray(PNAM, 'Slot Parents', wbFormIDCk('Parent', [EQUP])),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      'Use All Parents',
      'Parents Optional',
      'Item Slot'
    ])),
    wbFormIDCk(ANAM, 'Condition Actor Value', [AVIF, NULL, FFFF])
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
      ])),
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
      ])),
      wbFormIDCk('Association Type', [ASTP, NULL])
    ])
  ]);

  var wbStartScene :=
    wbRStruct('Start Scene', [
        wbFormIDCk(LCEP, 'Scene', [SCEN]),
        wbInteger(INTT, 'Phase Index', itU16),
        wbString(SSPN, 'Start Phase for Scene'),
        wbCITC,
        wbCTDAs
      ], []);

  wbRecord(SCEN, 'Scene', [
    wbEDID,
    wbVMADFragmentedSCEN,
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      {0x00000001} 'Begin on Quest Start',
      {0x00000002} 'Stop on Quest End',
      {0x00000004} 'Show All Text',
      {0x00000008} 'Repeat Conditions While True',
      {0x00000010} 'Interruptible',
      {0x00000020} 'Unknown 5',
      {0x00000040} 'Prevent Player Exit Dialogue',
      {0x00000080} 'Unknown 7',
      {0x00000100} 'Unknown 8',
      {0x00000200} 'Unknown 9',
      {0x00000400} 'Unknown 10',
      {0x00000800} 'Disable Dialogue Camera',
      {0x00001000} 'No Follower Idle Chatter'
    ])),
    wbRArray('Phases',
      wbRStruct('Phase', [
        wbEmpty(HNAM, 'Marker Phase Start', cpNormal, True),
        wbString(NAM0, 'Name', 0, cpNormal, True),
        wbRStruct('Start Conditions', [wbCTDAs], []),
        wbEmpty(NEXT, 'Marker Start Conditions', cpNormal, True),
        wbRStruct('Completion Conditions', [wbCTDAs], []),
        wbEmpty(NEXT, 'Marker Completion Conditions', cpNormal, True),
        wbInteger(WNAM, 'Editor Width', itU32, nil, cpNormal, True, false, nil, nil, 350),
        wbInteger(FNAM, 'Flags', itU16, wbFlags([
          {0x0001} 'Start - WalkAway Phase',
          {0x0002} 'Don''t Run End Scripts on Scene Jump',
          {0x0004} 'Start - Inherit In Templated Scenes'
        ])),
        wbStruct(SCQS, 'Set Parent Quest Stage', [
          wbInteger('On Start', itS16),
          wbInteger('On Completion', itS16)
        ]),
        wbEmpty(HNAM, 'Marker Phase End', cpNormal, True)
      ], [])
    ),
    wbRArray('Actors', wbRStruct('Actor', [
      wbInteger(ALID, 'Alias ID', itS32, nil, cpNormal, True),
      wbInteger(LNAM, 'Flags', itU32, wbFlags([
        'No Player Activation',
        'Optional',
        'Run Only Scene Packages',
        'No Command State'
      ]), cpNormal, True),
      wbInteger(DNAM, 'Behaviour Flags', itU32, wbFlags([
        'Death Pause',
        'Death End',
        'Combat Pause',
        'Combat End',
        'Dialogue Pause',
        'Dialogue End',
        'OBS_COM Pause',
        'OBS_COM End'
      ]), cpNormal, True, false, nil, nil, 26)
    ], [])),
    wbRArray('Actions', wbRStruct('Action', [
      wbInteger(ANAM, 'Type', itU16, wbEnum([
        {0} 'Dialogue',
        {1} 'Package',
        {2} 'Timer',
        {3} 'Player Dialogue',
        {4} 'Start Scene',
        {5} 'NPC Response Dialogue',
        {6} 'Radio'
      ]), cpNormal, True),
      wbString(NAM0, 'Name'),
      wbInteger(ALID, 'Alias ID', itS32),
      wbInteger(INAM, 'Index', itU32),
      wbInteger(FNAM, 'Flags', itU32, wbFlags([
        {0x00000001} 'Unknown 0',
        {0x00000002} 'Unknown 1',
        {0x00000004} 'Unknown 2',
        {0x00000008} 'Unknown 3',
        {0x00000010} 'Unknown 4',
        {0x00000020} 'Unknown 5',
        {0x00000040} 'Unknown 6',
        {0x00000080} 'Player Positive Use Dialogue Subtype / Hold Into Next Scene',
        {0x00000100} 'Player Negative Use Dialogue Subtype',
        {0x00000200} 'Player Neutral Use Dialogue Subtype',
        {0x00000400} 'Use Dialogue Subtype',
        {0x00000800} 'Player Question Use Dialogue Subtype',
        {0x00001000} 'Keep/Clear Target on Action End',
        {0x00002000} 'Unknown 13',
        {0x00004000} 'Unknown 14',
        {0x00008000} 'Face Target',
        {0x00010000} 'Looping',
        {0x00020000} 'Headtrack Player',
        {0x00040000} 'Unknown 18',
        {0x00080000} 'Ignore For Completion',
        {0x00100000} 'Unknown 20',
        {0x00200000} 'Camera Speaker Target',
        {0x00400000} 'Complete Face Target',
        {0x00800000} 'Unknown 23',
        {0x01000000} 'Unknown 24',
        {0x02000000} 'Unknown 25',
        {0x04000000} 'Unknown 26',
        {0x08000000} 'NPC Positive Use Dialogue Subtype',
        {0x10000000} 'NPC Negative Use Dialogue Subtype',
        {0x20000000} 'NPC Neutral Use Dialogue Subtype',
        {0x40000000} 'NPC Question Use Dialogue Subtype'
      ])),
      wbInteger(SNAM, 'Start Phase', itU32),
      wbInteger(ENAM, 'End Phase', itU32),
      wbFloat(SNAM, 'Timer - Max Seconds'),
      wbInteger(SCQS, 'Set Parent Quest Stage', itS16),
      wbFloat(TNAM, 'Timer - Min Seconds'),
      wbUnknown(STSC),
      wbRArray('Start Scenes', wbStartScene),
      wbFormIDCk(PTOP, 'Player Positive Response', [DIAL]),
      wbFormIDCk(NTOP, 'Player Negative Response', [DIAL]),
      wbFormIDCk(NETO, 'Player Neutral Response', [DIAL]),
      wbFormIDCk(QTOP, 'Player Question Response', [DIAL]),
      wbFormIDCk(VENC, 'Player Positive Dialogue Subtype', [KYWD]),
      wbFormIDCk(PLVD, 'Player Negative Dialogue Subtype', [KYWD]),
      wbFormIDCk(JOUT, 'Player Neutral Dialogue Subtype', [KYWD]),
      wbFormIDCk(DALC, 'Player Question Dialogue Subtype', [KYWD]),
      wbArray(DTID, 'NPC Headtracking', wbInteger('Actor ID', itS32)),
      wbFormIDCk(NPOT, 'NPC Positive Response', [DIAL]),
      wbFormIDCk(NNGT, 'NPC Negative Response', [DIAL]),
      wbFormIDCk(NNUT, 'NPC Neutral Response', [DIAL]),
      wbFormIDCk(NQUT, 'NPC Question Response', [DIAL]),
      wbFormIDCk(NPOS, 'NPC Positive Dialogue Subtype', [KYWD]),
      wbFormIDCk(NNGS, 'NPC Negative Dialogue Subtype', [KYWD]),
      wbFormIDCk(NNUS, 'NPC Neutral Dialogue Subtype', [KYWD]),
      wbFormIDCk(NQUS, 'NPC Question Dialogue Subtype', [KYWD]),
      wbInteger(DTGT, 'Dialogue Target Actor', itS32),
      wbRArray('Packages', wbFormIDCk(PNAM, 'Package', [PACK])),
      wbFormIDCk(DATA, 'Topic', [DIAL, NULL]),
      wbUnion(HTID, '', wbSceneActionSoundDecider, [
        wbEmpty('End Scene Say Greeting'),
        wbFormIDCk('Play Sound', [SNDR, NULL])
      ]),
      wbFloat(DMAX, 'Looping - Max'),
      wbFloat(DMIN, 'Looping - Min'),
      wbStruct(CRIS, 'Camera', [
        wbFloat('FOV On Player Camera'),
        wbFloat('Rate Of Camera Change')
      ]),
      wbInteger(DEMO, 'Emotion Type', itU32, wbEmotionTypeEnum),
      wbInteger(DEVA, 'Emotion Value', itU32),
      wbArray(HTID, 'Player Headtracking', wbInteger('Actor ID', itS32)),
      wbFormIDCk(VENC, 'Dialogue Subtype', [KYWD]),
      wbFormIDCk(PNAM, 'AnimArchType', [KYWD]),
      wbFormIDCk(ONAM, 'Audio Output Override', [SOPM]),
      wbEmpty(ANAM, 'End Marker', cpNormal, True)
    ], [])),
    wbFormIDCk(PNAM, 'Quest', [QUST]),
    wbInteger(INAM, 'Last Action Index', itU32),
    wbUnknown(VNAM),
    wbFloat(CNAM, 'Camera Distance Override'),
    wbFloat(ACTV, 'Dialogue Distance Override'),
    wbFloat(CRIS, 'FOV Override'),
    wbKSIZ,
    wbKWDAs,
    wbCTDAs,
    wbStruct(SCQS, 'Set Parent Quest Stage', [
      wbInteger('On Begin', itS16),
      wbInteger('On End', itS16)
    ]),
    wbString(NNAM, 'Notes'),
    wbFormIDCk(TNAM, 'Template Scene', [SCEN]),
    wbInteger(XNAM, 'Index', itU32)
  ]);

  wbRecord(ASTP, 'Association Type', [
    wbEDID,
    wbString(MPRT, 'Male Parent Title'),
    wbString(FPRT, 'Female Parent Title'),
    wbString(MCHT, 'Male Child Title'),
    wbString(FCHT, 'Female Child Title'),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      'Family Association'
    ]))
  ]);
end;

procedure DefineSF1k;
begin
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
        wbFloat('Walk', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Run', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
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
        wbFloat('Walk', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Run', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
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

      wbFloat('Unknown', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
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
        wbFloat('Walk', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Run', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbUnused
      ]),

      wbStruct('Roll', [
        wbUnused,
        wbFloat('Walk', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Run', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbUnused
      ]),

      wbStruct('Yaw', [
        wbUnused,
        wbFloat('Walk', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Run', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbUnused
      ]),

      wbFloat('Unknown', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
      wbFloat('Unknown', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
      wbFloat('Unknown', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
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
        wbFloat('Standing', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Walk', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Run', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Sprint', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
      ]),

      wbStruct('Roll', [
        wbFloat('Standing', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Walk', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Run', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Sprint', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
      ]),

      wbStruct('Yaw', [
        wbFloat('Standing', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Walk', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Run', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
        wbFloat('Sprint', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
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

  {subrecords checked against Starfield.esm}
  wbRecord(ARTO, 'Art Object', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbUnknown(XALG),
    wbPTT2,
    wbBaseFormComponents,
    wbKeywords,
    wbGenericModel,
    wbStruct(DNAM, 'Data', [
      wbInteger('Art Type', itU32, wbEnum([
        'Magic Casting',
        'Magic Hit Effect',
        'Enchantment Effect'
      ])),
      wbUnknown(4)
    ])
  ]);

  wbRecord(MATO, 'Material Object', [
    wbEDID,
    wbGenericModel,
    wbRArray('Property Data',
      wbByteArray(DNAM, 'Data', 0, cpIgnore, False, False, wbNeverShow)
    ),
    wbStruct(DATA, 'Directional Material Data', [
      wbFloat('Falloff Scale'),
      wbFloat('Falloff Bias'),
      wbFloat('Noise UV Scale'),
      wbFloat('Material UV Scale'),
      wbStruct('Projection Vector', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
      wbFloat('Normal Dampener'),
      wbFloatColors('Single Pass Color'),
      wbInteger('Flags', itU32, wbFlags(['Single Pass']))
    ], cpNormal, True, nil, 5)
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
    wbFloat(LNAM, 'Flight - Angle Gain')
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
    wbCTDAs,
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
      ], []),
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
      ]))
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
    ]), cpNormal, True),
    wbFormIDCk(PNAM, 'Parent Category', [SNCT]),
    wbFormIDCk(ONAM, 'Menu Slider Category', [SNCT]),
    wbInteger(VNAM, 'Static Volume Multiplier', itU16, wbDiv(65535)),
    wbInteger(UNAM, 'Default Menu Value', itU16, wbDiv(65535)),
    wbFloat(MNAM, 'Min Frequency Multiplier'),
    wbFloat(CNAM, 'Sidechain Target Multiplier')
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
      ])),
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
        wbInteger('FL', itU8),
        wbInteger('FR', itU8),
        wbInteger('C', itU8),
        wbInteger('LFE', itU8),
        wbInteger('RL', itU8),
        wbInteger('RR', itU8),
        wbInteger('SL', itU8),
        wbInteger('SR', itU8)
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
        wbInteger('Value 2', itU8),
        wbInteger('Value 3', itU8),
        wbInteger('Value 4', itU8)
      ]),
      wbStruct('Fade Out Curve', [
        wbInteger('Value 1', itU8),
        wbInteger('Value 2', itU8),
        wbInteger('Value 3', itU8),
        wbInteger('Value 4', itU8)
      ])
    ]),
    wbFormIDCk(ENAM, 'Effect Chain', [AECH])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(COLL, 'Collision Layer', [
    wbEDID,
    //wbDESCReq,
    wbString(NLDT),
    wbInteger(BNAM, 'Index', itU32, nil, cpNormal, True),
    wbStruct(FNAM, 'Debug Color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbInteger('Unused', itU8)
    ], cpNormal, True).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
    wbInteger(GNAM, 'Flags', itU32, wbFlags([
      {0x00000001} 'Trigger Volume',
      {0x00000002} 'Sensor',
      {0x00000004} 'Navmesh Obstacle'
    ]), cpNormal, True),
    wbString(MNAM, 'Name', 0, cpNormal, True),
//    wbInteger(INTV, 'Interactables Count', itU32, nil, cpNormal, True),
    wbArrayS(CNAM, 'Collides With', wbFormIDCk('Forms', [COLL]), 0, cpNormal, False)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CLFM, 'Color',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  2, 'Non-Playable'
    ])), [
    wbEDID,
//    wbFULL,
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
    ]), cpNormal, True)
//    wbCTDAs
  ]);
end;

procedure DefineSF1l;
begin
  wbRecord(REVB, 'Reverb Parameters', [
    wbEDID,
    wbStruct(DATA, 'Data', [
      wbInteger('Decay Time (ms)', itU16),
      wbInteger('HF Reference (Hz)', itU16),
      wbInteger('Room Filter', itS8),
      wbInteger('Room HF Filter', itS8),
      wbInteger('Reflections', itS8),
      wbInteger('Reverb Amp', itS8),
      wbInteger('Decay HF Ratio', itU8, wbDiv(100)),
      wbInteger('Reflect Delay (ms), scaled', itU8),
      wbInteger('Reverb Delay (ms)', itU8),
      wbInteger('Diffusion %', itU8),
      wbInteger('Density %', itU8),
      wbInteger('Unknown', itU8)
    ], cpNormal, True),
    wbInteger(ANAM, 'Reverb Class', itU32, wbReverbClassEnum, cpNormal, True)
  ]);

  wbRecord(GRAS, 'Grass', [
    wbEDID,
    wbOBND(True),
    wbGenericModel,
    wbStruct(DATA, '', [
      wbInteger('Density', itU8),
      wbInteger('Min Slope', itU8),
      wbInteger('Max Slope', itU8),
      wbByteArray('Unknown', 1),
      wbInteger('Units From Water', itU16),
      wbByteArray('Unknown', 2),
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
      wbFloat('Position Range'),
      wbFloat('Height Range'),
      wbFloat('Color Range'),
      wbFloat('Wave Period'),
      wbInteger('Flags', itU8, wbFlags([
        'Vertex Lighting',
        'Uniform Scaling',
        'Fit to Slope'
      ])),
      wbByteArray('Unknown', 3)
    ], cpNormal, True)
  ]);

  wbRecord(IDLE, 'Idle Animation', [
    wbEDID,
    wbCTDAs,
    wbString(DNAM, 'Behavior Graph'),
    wbString(ENAM, 'Animation Event'),
    wbArray(ANAM, 'Related Idle Animations', wbFormIDCk('Related Idle Animation', [AACT, IDLE, NULL]),
      ['Parent', 'Previous Sibling'], cpNormal, True),
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
      ], True)),
      wbInteger('Animation Group Section', itU8{, wbIdleAnam}),
      wbInteger('Replay Delay', itU16)
    ], cpNormal, True),
    wbString(GNAM, 'Animation File')
  ]);

  wbRecord(INFO, 'Dialog response',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
        ])),
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
        ]))
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
      wbLStringKC(NAM1, 'Response Text', 0, cpTranslate, True),
      wbString(NAM2, 'Script Notes', 0, cpNormal, True),
      wbString(NAM3, 'Edits', 0, cpNormal, True),
      wbString(NAM4, 'Alternate LIP Text', 0, cpNormal, True),
      wbFormIDCk(SNAM, 'Idle Animations: Speaker', [IDLE]),
      wbFormIDCk(LNAM, 'Idle Animations: Listener', [IDLE]),
      wbInteger(TNAM, 'Interrupt Percentage', itU16),
      wbByteArray(NAM9, 'Text Hash'),
      wbFormIDCk(SRAF, 'Camera Path', [CPTH]),
      wbEmpty(WZMD, 'Stop on Scene End')
    ], [])),

    wbCTDAs,
    wbLStringKC(RNAM, 'Prompt', 0, cpTranslate),
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
  ], False, wbINFOAddInfo, cpNormal, False, nil{wbINFOAfterLoad});

  wbRecord(INGR, 'Ingredient', [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbFULL,
    wbKSIZ,
    wbKWDAs,
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
      ])),
      wbUnknown
    ], cpNormal, True),
    wbEffectsReq
  ], False, nil, cpNormal, False, nil, wbKeywordsAfterSet);

  wbRecord(KEYM, 'Key',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000800} 11, 'Calc Value From Components',
      {0x00002000} 13, 'Pack-In Use Only'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTT2,
    wbFULLReq,
    wbGenericModel,
    wbICON,
    wbMICO,
    wbDEST,
    wbYNAM,
    wbZNAM,
    wbKSIZ,
    wbKWDAs,
    wbStruct(DATA, '', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True)
  ], False, nil, cpNormal, False, nil, wbKeywordsAfterSet);

  if wbSimpleRecords then begin

    wbRecord(LAND, 'Landscape',
      wbFlags(wbRecordFlagsFlags, wbFlagsList([
        {0x00040000} 18, 'Compressed'
      ]), [18]), [
      wbByteArray(DATA, 'Unknown'),
      wbByteArray(VNML, 'Vertex Normals'),
      wbByteArray(VHGT, 'Vertex Height Map'),
      wbByteArray(VCLR, 'Vertex Colours'),
      wbLandscapeLayers(wbSimpleRecords),
      wbArray(VTEX, 'Textures', wbFormIDCk('Texture', [LTEX, NULL])),
      wbRArray('Unknown', wbUnknown(MPCD))
    ]);

  end else begin

    wbRecord(LAND, 'Landscape',
      wbFlags(wbRecordFlagsFlags, wbFlagsList([
        {0x00040000} 18, 'Compressed'
      ]), [18]), [
      wbByteArray(DATA, 'Unknown'),
      wbVertexColumns(VNML, 'Vertex Normals'),
      wbVertexHeightMap,
      wbVertexColumns(VCLR, 'Vertex Colours'),
      wbLandscapeLayers(wbSimpleRecords),
      wbArray(VTEX, 'Textures', wbFormIDCk('Texture', [LTEX, NULL])),
      wbRArray('Unknown', wbUnknown(MPCD))
    ]);

  end;

  wbRecord(LIGH, 'Light',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00010000} 16, 'Random Anim Start',
      {0x00020000} 17, 'Unknown 17',
      {0x00020000} 25, 'Obstacle',
      {0x00020000} 28, 'Portal-strict'
    ])), [
    wbEDID,
//    wbVMAD,
    wbOBND(True),
    wbODTY,
//    wbPTT2,
    wbBaseFormComponents,
    wbGenericModel,
    wbKSIZ,
    wbKWDAs,
    wbUnknown(DAT2),
//    wbDEST,
//    wbPRPS,
//    wbFULL,
//    wbICON,
//    wbMICO,

//    wbStruct(DATA, '', [
//      wbInteger('Time', itS32),
//      wbInteger('Radius', itU32),
//      wbByteColors('Color'),
//      // Omnidirectional is the default type
//      wbInteger('Flags', itU32, wbFlags([
//        {0x00000001} 'Unknown 0',
//        {0x00000002} 'Can be Carried',
//        {0x00000004} 'Unknown 2',
//        {0x00000008} 'Flicker',
//        {0x00000010} 'Unknown 4',
//        {0x00000020} 'Off By Default',
//        {0x00000040} 'Unknown 6',
//        {0x00000080} 'Pulse',
//        {0x00000100} 'Unknown 8',
//        {0x00000200} 'Unknown 9',
//        {0x00000400} 'Shadow Spotlight',
//        {0x00000800} 'Shadow Hemisphere',
//        {0x00001000} 'Shadow OmniDirectional',
//        {0x00002000} 'Unknown 13',
//        {0x00004000} 'NonShadow Spotlight',
//        {0x00008000} 'Non Specular',
//        {0x00010000} 'Attenuation Only',
//        {0x00020000} 'NonShadow Box',
//        {0x00040000} 'Ignore Roughness',
//        {0x00080000} 'No Rim Lighting',
//        {0x00100000} 'Ambient Only',
//        {0x00200000} 'Unknown 21' // only in [001C7F0C] <RandomSpot01GR>
//      ])),
//      wbFloat('Falloff Exponent'),
//      wbFloat('FOV'),
//      wbFloat('Near Clip'),
//      wbStruct('Flicker Effect', [
//        wbFloat('Period'),
//        wbFloat('Intensity Amplitude'),
//        wbFloat('Movement Amplitude')
//      ]),
//      wbFloat('Constant'),
//      wbFloat('Scalar'),
//      wbFloat('Exponent'),
//      wbFloat('God Rays - Near Clip'),
//      wbInteger('Value', itU32),
//      wbFloat('Weight')
//    ], cpNormal, True, nil, 10),

//    wbFloat(FNAM, 'Fade value', cpNormal, True),
    wbString(NAM0, 'Gobo'),
    wbFormIDCk(LNAM, 'Lens', [LENS]),
    wbUnknown(FLBD),
    wbUnknown(FLRD),
    wbUnknown(FLGD),
    wbUnknown(LLLD),
    wbUnknown(FLAD),
    wbUnknown(FVLD)
//    wbFormIDCk(WGDR, 'God Rays', [GDRY]),
//    wbFormIDCk(SNAM, 'Sound', [SNDR])
  ], False, nil, cpNormal, False, wbLIGHAfterLoad);
end;

procedure DefineSF1m;
begin
  wbRecord(LSCR, 'Load Screen',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000400} 10, 'Displays In Main Menu',
      {0x00008000} 15, 'No Rotation'
    ])), [
    wbEDID,
    wbDESCReq,
    wbCTDAs,
    wbFormIDCk(NNAM, 'Loading Screen NIF', [STAT, SCOL, NULL], False, cpNormal, True),
    wbFormIDCk(TNAM, 'Transform', [TRNS]),
    wbStruct(ONAM, 'Rotation', [
      wbInteger('Min', itS16),
      wbInteger('Max', itS16)
    ]),
    wbStruct(ZNAM, 'Zoom', [
      wbFloat('Min'),
      wbFloat('Max')
    ]),
    wbString(MOD2, 'Camera Path', 0, cpNormal, False)
  ]);

  wbRecord(LTEX, 'Landscape Texture', [
    wbEDID,
    wbFormIDCk(TNAM, 'Texture Set', [TXST], False, cpNormal, False),
    wbFormIDCk(MNAM, 'Material Type', [MATT, NULL], False, cpNormal, True),
    wbStruct(HNAM, 'Havok Data', [
      wbInteger('Friction', itU8),
      wbInteger('Restitution', itU8)
    ], cpNormal, True),
    wbInteger(SNAM, 'Texture Specular Exponent', itU8, nil, cpNormal, True),
    wbRArray('Grasses', wbFormIDCk(GNAM, 'Grass', [GRAS]))
  ]);

  var wbLeveledListEntryItem :=
    wbRStructExSK([0], [1], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itU16),
        wbByteArray('Unused', 2, cpIgnore, false, wbNeverShow),
        wbFormIDCk('Reference', sigBaseObjects),
        wbInteger('Count', itU16),
        wbInteger('Chance None', itU8),
        wbByteArray('Unused', 1, cpIgnore, false, wbNeverShow)
      ])
      .SetSummaryKeyOnValue([0, 3, 2, 4])
      .SetSummaryPrefixSuffixOnValue(0, '[Lv', ']')
      .SetSummaryPrefixSuffixOnValue(3, '', 'x')
      .SetSummaryPrefixSuffixOnValue(4, '{Chance None:', '%}')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlagOnValue(dfSummaryNoSortKey)
      , wbCOED
    ], [])
    .SetSummaryMemberMaxDepth(0, 1)
    .IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  var wbLeveledListEntryNPC :=
    wbRStructExSK([0], [1], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itU16),
        wbByteArray('Unused', 2, cpIgnore, false, wbNeverShow),
        wbFormIDCk('Reference', [NPC_, LVLN]),
        wbInteger('Count', itS16),
        wbInteger('Chance None', itU8),
        wbByteArray('Unused', 1, cpIgnore, false, wbNeverShow)
      ])
      .SetSummaryKeyOnValue([0, 3, 2, 4])
      .SetSummaryPrefixSuffixOnValue(0, '[Lv', ']')
      .SetSummaryPrefixSuffixOnValue(3, '', 'x')
      .SetSummaryPrefixSuffixOnValue(4, '{Chance None:', '%}')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlagOnValue(dfSummaryNoSortKey)
      , wbCOED
    ], [])
    .SetSummaryMemberMaxDepth(0, 1)
    .IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  var wbLeveledListEntryPackIn :=
    wbRStructExSK([0], [1], 'Leveled List Entry', [
      wbFormIDCk(LVLO, 'Reference', sigBaseObjects)
      //wbCOED,
      //wbCTDAs,
//      wbLVOV,
      //wbLVOC,
      //wbLVOT,
//      wbLVIV,
      //wbLVIG,
//      wbLVLV
      //wbLVOG,
      //wbLVLT
    ], [])
    .SetSummaryKey([0])
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  var wbLeveledListEntrySpell :=
    wbRStructSK([0], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itU16),
        wbByteArray('Unused', 2, cpIgnore, false, wbNeverShow),
        wbFormIDCk('Reference', [SPEL, LVSP]),
        wbInteger('Count', itU16),
        wbInteger('Chance None', itU8),
        wbByteArray('Unused', 1, cpIgnore, false, wbNeverShow)
      ])
      .SetSummaryKeyOnValue([0, 3, 2, 4])
      .SetSummaryPrefixSuffixOnValue(0, '[Lv', ']')
      .SetSummaryPrefixSuffixOnValue(3, '', 'x')
      .SetSummaryPrefixSuffixOnValue(4, '{Chance None:', '%}')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlagOnValue(dfSummaryNoSortKey)
    ], [])
    .SetSummaryMemberMaxDepth(0, 1)
    .IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

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
    ]), cpNormal, True),
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntryNPC, cpNormal, False, nil, wbLVLOsAfterSet),
    wbFilterKeywordChances,
    wbGenericModel
  ], False, nil, cpNormal, False, wbLLEAfterLoad, wbLLEAfterSet);

  wbRecord(LVLI, 'Leveled Item', [
    wbEDID,
    wbOBND(True),
    wbLVLD,
    wbInteger(LVLM, 'Max Count', itU8), { Always 00 }
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count',
      {0x04} 'Use All'
    ]), cpNormal, True),
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntryItem, cpNormal, False, nil, wbLVLOsAfterSet),
    wbFilterKeywordChances,
    wbFormIDCk(LVSG, 'Epic Loot Chance', [GLOB]),
    wbLStringKC(ONAM, 'Override Name', 0, cpTranslate)
  ], False, nil, cpNormal, False, wbLLEAfterLoad, wbLLEAfterSet);

  wbRecord(LVLP, 'Leveled Pack In', [
    wbEDID,
    wbOBND(True),
    //wbOPDSs,
    //wbDEFL,
    //wbXALG,
    wbLVLD,
//    wbLVMV,
    //wbLVMG,
    //wbLVMT,
//    wbLVCV,
    //wbInteger(LVLM, 'Max Count', itU8), { Always 00 }
    //wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    //wbLVCT,
//    wbUnion(LVLF, 'Flags', wbFormVersionDecider(185), [
//      wbInteger('', itU8, wbLVLFFlags),
//      wbInteger('', itU16, wbLVLFFlags)
//    ], cpNormal, True),
    //wbCTDAs,
    //wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntryPackIn, cpNormal, False, nil, wbLVLOsAfterSet),
    {
    wbArrayS(LLKC, 'Filter Keyword Chances',
      wbStructSK([0], 'Filter', [
        wbFormIDCk('Keyword', [KYWD]),
        wbInteger('Chance', itU32),
        wbFromVersion(152, wbFormIDCk('Curve Table', [CURV, NULL]))
      ])
    ),
    }
    //wbFormIDCk(LVSG, 'Epic Loot Chance', [GLOB]),
    //wbDIQO,
    //wbUnknown(LIMC),
    wbGenericModel
    //wbLStringKC(ONAM, 'Override Name', 0, cpTranslate)
  ], False, nil, cpNormal, False, wbLLEAfterLoad, wbLLEAfterSet);

  wbRecord(LVSP, 'Leveled Spell', [
    wbEDID,
    wbOBND(True),
    wbLVLD,
    wbInteger(LVLM, 'Max Count', itU8), { Always 00 }
    wbInteger(LVLF, 'Flags', itU8, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count',
      {0x04} 'Use All'
    ]), cpNormal, True),
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntrySpell, cpNormal, False, nil, wbLVLOsAfterSet)
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
      wbUnknown
      (*
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
      ])),
      wbFloat('Base Cost'),
      wbUnion('Assoc. Item', wbMGEFAssocItemDecider, [
        wbFormID('Unused', cpIgnore),
        wbFormIDCk('Assoc. Item', [LIGH, NULL]),
        wbFormIDCk('Assoc. Item', [WEAP, ARMO, NULL]),
        wbFormIDCk('Assoc. Item', [NPC_, NULL]),
        wbFormIDCk('Assoc. Item', [HAZD, NULL]),
        wbFormIDCk('Assoc. Item', [SPEL, NULL]),
        wbFormIDCk('Assoc. Item', [RACE, NULL]),
        wbFormIDCk('Assoc. Item', [ENCH, NULL]),
        wbFormIDCk('Assoc. Item', [KYWD, NULL]),
        wbFormIDCk('Assoc. Item', [DMGT, NULL])
      ], cpNormal, False, nil, wbMGEFAssocItemAfterSet),
      wbByteArray('Magic Skill (unused)', 4),
      wbFormIDCk('Resist Value', [AVIF, NULL]),
      wbInteger('Counter Effect count', itU16),
      wbByteArray('Unused', 2),
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
        wbFloat('Scale')
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
     *)
    ], cpNormal, True)
  ], []);

  {subrecords checked against Starfield.esm}
  wbRecord(MGEF, 'Magic Effect', [
    wbEDID,
    wbVMAD,
    wbFULL,
//    wbMDOB,
    wbKeywords,
    wbMGEFData,
//    wbRArrayS('Counter Effects', wbFormIDCk(ESCE, 'Effect', [MGEF]), cpNormal, False, nil, wbCounterEffectsAfterSet),
    //wbMagicEffectSounds,
    wbRArray('Unknown', wbUnknown(ESSH)),
    wbLStringKC(DNAM, 'Magic Item Description', 0, cpTranslate),
    wbCTDAs
  ], False, nil, cpNormal, False, nil {wbMGEFAfterLoad}, wbMGEFAfterSet);

  wbRecord(MISC, 'Misc. Item',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  11, 'Calc From Components',
      {0x00000004}  13, 'Pack-In Use Only'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbPTT2,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel,
    wbDEST,
    wbUnknown(CUSH),
    wbPUSHPDSH,
    wbKeywords,
    wbCVPA,
    wbStruct(DATA, 'Data', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True),
    // the amount of components is the same as size of CDIX, so should not be sorted probably
    wbUnknown(FLAG),
    wbUnknown(NNAM)
  ], False, nil, cpNormal, False, wbRemoveEmptyKWDA, wbKeywordsAfterSet);

  wbComponent :=
    wbStructSK([0], 'Component', [
      wbFormIDCkNoReach('Component', sigBaseObjects),
      wbInteger('Count', itU32),
      wbByteArray('Unknown', 4)
    ]).SetToStr(wbItemToStr).IncludeFlag(dfCollapsed, wbCollapseItems);

  wbComponents := wbArrayS(FVPA, 'Components', wbComponent);

  {subrecords checked against Starfield.esm}
  wbRecord(COBJ, 'Constructible Object', [
    wbEDID,
    wbBaseFormComponents,
//    wbYNAM,
//    wbZNAM,
    wbDESC,
    wbFormIDCkNoReach(BNAM, 'Workbench Keyword', [KYWD]),
    wbCTDAs,
    wbComponents,
    wbStructs(RQPK, 'Required Perks', 'Required Perk', [
      wbFormIDCk('Perk', [PERK]),
      wbInteger('Rank', itU32),
      wbUnknown(4)
    ]),
    wbFormIDCk(CNAM, 'Created Object', sigBaseObjects),
    wbUnknown(NNAM), // req
    wbUnknown(SNAM), // req
    wbUnknown(TNAM), // req - always 1 byte value $00
    wbUnknown(CUSH),
    wbPUSHPDSH,
    wbUnknown(LRNM), // always 1 byte value $03
    wbInteger(DATA, 'Unknown', itU32), // req
//    wbByteArray(NAM1, 'Unused', 0, cpIgnore, False, False, wbNeverShow), // co_PA_FusionCore01
//    wbByteArray(NAM2, 'Unused', 0, cpIgnore, False, False, wbNeverShow), // co_PA_FusionCore01
//    wbByteArray(NAM3, 'Unused', 0, cpIgnore, False, False, wbNeverShow), // co_PA_FusionCore01
    wbFormIDCk(ANAM, 'Menu Art Object', [ARTO]),
    wbFormIDCk(JNAM, 'Build Limit', [GLOB]),
    wbArrayS(FNAM, 'Category', wbFormIDCk('Keyword', [KYWD])),
    wbStruct(RECF, 'Unknown', [
      wbInteger('Unknown', itU32),
      wbByteArray('Unknown', 4)
    ])
//    wbStruct(INTV, 'Data', [
//      wbInteger('Created Object Count', itU16),
//      wbInteger('Priority', itU16)
//    ], cpNormal, False, nil, 1)
  ]);

  wbRecord(NPC_, 'Non-Player Character (Actor)',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000400} 10, 'Unknown 10',
      {0x00040000} 18, 'Compressed',
      {0x00080000} 19, 'Unknown 19',
      {0x20000000} 29, 'Bleedout Override'
    ]), [18]), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTT2,
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
      ])),
      wbInteger('XP Value Offset', itS16, nil, cpNormal, True, nil{wbActorTemplateUseStats}),
      wbUnion('Level', wbNPCLevelDecider, [
        wbInteger('Level', itS16, nil, cpNormal, True, nil{wbActorTemplateUseStats}),
        wbInteger('Level Mult', itS16, wbDiv(1000), cpNormal, True, nil{wbActorTemplateUseStats})
      ], cpNormal, True, nil{wbActorTemplateUseStats}),
      wbInteger('Calc min level', itU16, nil, cpNormal, True, nil{wbActorTemplateUseStats}),
      wbInteger('Calc max level', itU16, nil, cpNormal, True, nil{wbActorTemplateUseStats}),
      wbInteger('Disposition Base', itS16),
      wbInteger('Use Template Actors', itU16, wbFlags([
        {0x0001} 'Traits',
        {0x0002} 'Stats',
        {0x0004} 'Factions',
        {0x0008} 'Spell List',
        {0x0010} 'AI Data',
        {0x0020} 'AI Packages',
        {0x0040} 'Model/Animation',
        {0x0080} 'Base Data',
        {0x0100} 'Inventory',
        {0x0200} 'Script',
        {0x0400} 'Def Pack List',
        {0x0800} 'Attack Data',
        {0x1000} 'Keywords'
      ])),
      wbInteger('Bleedout Override', itU16),
      wbByteArray('Unknown', 2)
    ], cpNormal, True),
    wbRArrayS('Factions', wbFaction, cpNormal, False, nil, nil, nil{wbActorTemplateUseFactions}),
    wbFormIDCk(INAM, 'Death item', [LVLI], False, cpNormal, False, nil{wbActorTemplateUseTraits}),
    wbFormIDCk(VTCK, 'Voice', [VTYP], False, cpNormal, False, nil{wbActorTemplateUseTraits}),
    wbFormIDCk(TPLT, 'Default Template', [LVLN, NPC_]),
    wbFormIDCk(LTPT, 'Legendary Template', [LVLN, NPC_]),
    wbFormIDCk(LTPC, 'Legendary Chance', [GLOB]),
    wbStruct(TPTA, 'Template Actors', [
      wbFormIDCk('Traits', [LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate0),
      wbFormIDCk('Stats', [LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate1),
      wbFormIDCk('Factions', [LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate2),
      wbFormIDCk('Spell List', [LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate3),
      wbFormIDCk('AI Data', [LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate4),
      wbFormIDCk('AI Packages', [LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate5),
      wbFormIDCk('Model/Animation', [LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate6),
      wbFormIDCk('Base Data', [LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate7),
      wbFormIDCk('Inventory', [LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate8),
      wbFormIDCk('Script', [LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate9),
      wbFormIDCk('Def Pack List', [LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate10),
      wbFormIDCk('Attack Data', [LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate11),
      wbFormIDCk('Keywords', [LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate12)
    ], cpNormal, False, wbActorTemplatesUseTemplateAny),
    wbFormIDCk(RNAM, 'Race', [RACE], False, cpNormal, True, nil{wbActorTemplateUseTraits}),
    wbSPCT,
    wbSPLOs,
    wbDEST,
    wbFormIDCk(WNAM, 'Skin', [ARMO], False, cpNormal, False),
    wbFormIDCk(ANAM, 'Far away model', [ARMO], False, cpNormal, False, nil{wbActorTemplateUseTraits}),
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
      ]), cpNormal, False, nil, wbPRKRsAfterSet
    ),
    wbPRPS,
    wbFTYP,
    wbNTRM,
    wbCOCT,
    wbCNTOs,
    wbAIDT,
    wbRArray('Packages', wbFormIDCk(PKID, 'Package', [PACK]), cpNormal, False, nil{wbActorTemplateUseAIPackages}),
    wbKSIZ,
    wbKWDAs,
    wbAPPR,
    wbObjectTemplate,
    wbEmpty(STOP, 'Marker', cpNormal, True),
    wbFormIDCk(CNAM, 'Class', [CLAS], False, cpNormal, True),
    wbFULL,
    wbLStringKC(SHRT, 'Short Name', 0, cpTranslate),
    wbEmpty(DATA, 'Marker', cpNormal, True),
    wbStruct(DNAM, '', [
      wbInteger('Calculated Health', itU16),
      wbInteger('Calculated Action Points', itU16),
      wbInteger('Far Away Model Distance', itU16),
      wbInteger('Geared Up Weapons', itU8),
      wbByteArray('Unused', 1, cpIgnore)
    ]),
    wbRArrayS('Head Parts', wbFormIDCk(PNAM, 'Head Part', [HDPT]), cpNormal, False, nil, nil, nil{wbActorTemplateUseModelAnimation}),
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
    ], []),
    wbFormIDCk(CSCR, 'Inherits Sounds From', [NPC_], False, cpNormal, False),
    wbFormIDCk(PFRN, 'Power Armor Stand', [FURN]),
    wbFormIDCk(DOFT, 'Default Outfit', [OTFT], False, cpNormal, False),
    wbFormIDCk(SOFT, 'Sleeping Outfit', [OTFT], False, cpNormal, False),
    wbFormIDCk(DPLT, 'Default Package List', [FLST], False, cpNormal, False),
    wbFormIDCk(CRIF, 'Crime Faction', [FACT], False, cpNormal, False),
    wbFormIDCk(FTST, 'Head Texture', [TXST], False, cpNormal, False),
    wbStruct(QNAM, 'Texture lighting', [
      wbFloat('Red', cpNormal, True, 255, 0),
      wbFloat('Green', cpNormal, True, 255, 0),
      wbFloat('Blue', cpNormal, True, 255, 0),
      wbFloat('Alpha')
    ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
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
      ], [])
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
      ], [])
    ),
    wbFloat(FMIN, 'Facial Morph Intensity'),
    wbATTX
  ], False, nil, cpNormal, False, wbNPCAfterLoad, wbNPCAfterSet);

  wbPKDTSpecificFlagsUnused := False;

  wbPKDTFlags := wbFlags([
    {0x00000001} 'Offers Services',
    {0x00000002} 'Unknown 2',
    {0x00000004} 'Must complete',
    {0x00000008} 'Maintain Speed at Goal',
    {0x00000010} 'Treat As Player Follower',
    {0x00000020} 'Unknown 6',
    {0x00000040} 'Unlock doors at package start',
    {0x00000080} 'Unlock doors at package end',
    {0x00000100} 'Request Block Idles',
    {0x00000200} 'Continue if PC Near',
    {0x00000400} 'Once per day',
    {0x00000800} 'Unknown 12',
    {0x00001000} 'Skip Load Into Furniture',
    {0x00002000} 'Preferred Speed',
    {0x00004000} 'Unknown 15',
    {0x00008000} 'Unknown 16',
    {0x00010000} 'Unknown 17',
    {0x00020000} 'Always Sneak',
    {0x00040000} 'Allow Swimming',
    {0x00080000} 'Unknown 20',
    {0x00100000} 'Ignore Combat',
    {0x00200000} 'Weapons Unequipped',
    {0x00400000} 'Unknown 23',
    {0x00800000} 'Weapon Drawn',
    {0x01000000} 'Unknown 25',
    {0x02000000} 'Unknown 26',
    {0x04000000} 'Unknown 27',
    {0x08000000} 'No Combat Alert',
    {0x10000000} 'Unknown 29',
    {0x20000000} 'Wear Sleep Outfit',
    {0x40000000} 'Unknown 31',
    {0x80000000} 'Unknown 32'
  ], [29]);

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
end;


procedure DefineSF1n;
var
  wbBlendOperationEnum: IwbEnumDef;

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
        ])),
        wbCTDAs,
        wbRArray('Textures', wbString(TTET, 'Texture')),
        wbInteger(TTEB, 'Blend Operation', itU32, wbBlendOperationEnum),
        wbArray(TTEC, 'Template Colors', wbStruct('Template Color', [
          wbFormIDCk('Color', [CLFM]),
          wbFloat('Alpha'),
          wbInteger('Template Index', itU16),
          wbInteger('Blend Operation', itU32, wbBlendOperationEnum)
        ])),
        wbFloat(TTED, 'Default')
      ], []);

    wbTintTemplateGroup :=
      wbRStruct('Group', [
        wbLString(TTGP, 'Group Name', 0, cpTranslate),
        wbRArray('Options', wbTintTemplateOption),
        wbInteger(TTGE, 'Category Index', itU32)
      ], []);

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
              wbString(MPPM, 'Unknown'),
              wbFormIDCk(MPPT, 'Texture', [TXST]),
              wbUnknown(MPPF)
            ], []),
            cpNormal, False, nil, wbMorphPresetsAfterSet
          ),
          wbUnknown(MPPK),
          wbArray(MPGS, 'Unknown', wbInteger('Index', itU32, wbIntToHexStr, wbHexStrToInt))
        ], [])
      );
  end;

  function wbFaceMorphs(const aName: string): IwbSubRecordArrayDef;
  begin
    Result :=
      wbRArray(aName,
        wbRStruct('Face Morph', [
          wbInteger(FMRI, 'Index', itU32, wbIntToHexStr, wbHexStrToInt),
          wbLString(FMRN, 'Name')
        ], [])
      );
  end;

begin
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
    ]))
  ], []));

  wbRecord(PACK, 'Package', [
    wbEDID,
    wbVMADFragmentedPACK,

    wbStruct(PKDT, 'Pack Data', [
      wbInteger('General Flags', itU32, wbPKDTFlags),
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
      wbByteArray('Unknown', 1),
      wbInteger('Interrupt Flags', itU16, wbPKDTInterruptFlags),
      wbByteArray('Unknown', 2)
    ], cpNormal, True),

    wbStruct(PSDT, 'Schedule', [
      wbInteger('Month', itS8),
      wbInteger('Day of week', itS8, wbEnum([
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Weekdays',
        'Weekends',
        'Monday, Wednesday, Friday',
        'Tuesday, Thursday'
      ], [
        -1, 'Any'
      ])),
      wbInteger('Date', itU8),
      wbInteger('Hour', itS8),
      wbInteger('Minute', itS8),
      wbByteArray('Unused', 3, cpIgnore),
      wbInteger('Duration (minutes)', itS32)
    ], cpNormal, True),

    wbCTDAs,

    wbRStruct('Idle Animations', [
      wbInteger(IDLF, 'Flags', itU8, wbEnum([], [
         0, 'Unknown',
         8, 'Random',
         9, 'Run in Sequence',
        12, 'Random, Do Once',
        13, 'Run in Sequence, Do Once'
      ]), cpNormal, True),
      wbInteger(IDLC, 'Animation Count', itU8, nil, cpBenign),
      wbFloat(IDLT, 'Idle Timer Setting', cpNormal, True),
      wbArray(IDLA, 'Animations', wbFormIDCk('Animation', [IDLE]), 0, nil, wbIDLAsAfterSet, cpNormal, True),
      wbByteArray(IDLB, 'Unknown', 4, cpIgnore)
    ], [], cpNormal, False, nil, False, nil {cannot be totally removed , wbAnimationsAfterSet}),

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
        wbUnknown(TPIC)
      ], [], cpNormal, False)),
      wbUNAMs
    ], []),
    wbByteArray(XNAM, 'Marker', 0, cpNormal, True),

    wbRStruct('Procedure Tree', [
      wbRArray('Branches', wbRStruct('Branch', [
        wbString(ANAM, 'Branch Type'),
        wbCITCReq,
        wbCTDAsCount,
        wbStruct(PRCB, 'Root', [
          wbInteger('Branch Count', itU32),
          wbInteger('Flags', itU32, wbFlags([
            'Repeat when Complete',
            'Unknown 1'
          ]))
        ]),
        wbString(PNAM, 'Procedure Type'),
        wbInteger(FNAM, 'Flags', itU32, wbFlags(['Success Completes Package'])),
        wbRArray('Data Input Indexes', wbInteger(PKC2, 'Index', itU8)),
        {>>> PFO2 should be single, there is only 1 PACK [00095F46] <PatrolAndHunt> in Skyrim.esm with 2xPFO2 <<<}
        wbRArray('Flags Override',
          wbStruct(PFO2, 'Data', [
            wbInteger('Set General Flags', itU32, wbPKDTFlags),
            wbInteger('Clear General Flags', itU32, wbPKDTFlags),
            wbInteger('Set Interrupt Flags', itU16, wbPKDTInterruptFlags),
            wbInteger('Clear Interrupt Flags', itU16, wbPKDTInterruptFlags),
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
    ], []),
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
    ]), cpNormal, True);

  wbRecord(QUST, 'Quest',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00004000} 14, 'Partial Form'  // Allows the Record to inherit some subrecords from its master
    ])), [
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
      ])),
      wbInteger('Priority', itU8),
      wbByteArray('Unused', 1),
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
      wbByteArray('Unused', 3)
    ]),
    wbString(ENAM, 'Event', 4),
    wbFormIDCk(LNAM, 'Location', [LCTN]),
    wbFormIDCk(XNAM, 'Quest Completion XP', [GLOB]),
    wbRArray('Text Display Globals', wbFormIDCk(QTGL, 'Global', [GLOB])),
    wbFLTR,
    wbRStruct('Quest Dialogue Conditions', [wbCTDAs], [], cpNormal, False),
    wbEmpty(NEXT, 'Marker', cpNormal, True),
    wbCTDAs, {>>> Unknown, doesn't show up in CK <<<}
    wbRArrayS('Stages', wbRStructSK([0], 'Stage', [
      wbStructSK(INDX, [0], 'Stage Index', [
        wbInteger('Stage Index', itU16),
        wbInteger('Flags', itU8, wbFlags([
          {0x01} 'Unknown 1',
          {0x02} 'Run On Start',
          {0x04} 'Run On Stop',
          {0x08} 'Keep Instance Data From Here On'
        ])),
        wbInteger('Unknown', itU8)
      ]),
      wbRArray('Log Entries', wbRStruct('Log Entry', [
        wbInteger(QSDT, 'Stage Flags', itU8, wbFlags([
          {0x01} 'Complete Quest',
          {0x02} 'Fail Quest'
        ])),
        wbCTDAs,
        wbString(NAM2, 'Note'),
        wbLStringKC(CNAM, 'Log Entry', 0, cpTranslate),
        wbFormIDCk(NAM0, 'Next Quest', [QUST])
      ], []))
    ], [])),
    wbRArray('Objectives', wbRStruct('Objective', [
      wbInteger(QOBJ, 'Objective Index', itU16),
      wbInteger(FNAM, 'Flags', itU32, wbFlags([
        {0x01} 'ORed With Previous',
        {0x02} 'No Stats Tracking'
      ])),
      wbLStringKC(NNAM, 'Display Text', 0, cpTranslate, True),
      wbRArray('Targets', wbRStruct('Target', [
        wbStruct(QSTA, 'Target', [
          wbInteger('Alias', itS32, wbQuestAliasToStr, wbStrToAlias),
          wbInteger('Flags', itU32, wbFlags([
            {0x01} 'Compass Marker Ignores Locks',
            {0x02} 'Hostile',
            {0x04} 'Use Straight Line Pathing'
          ])),
          wbFromVersion(82, wbFormIDCk('Keyword', [KYWD, NULL]))
        ]),
        wbCTDAs
      ], []))
    ], [])),

    wbInteger(ANAM, 'Next Alias ID', itU32),

    wbRArray('Aliases',
      wbRUnion('Alias', [

        // Reference Alias
        wbRStructSK([0], 'Alias', [
          wbInteger(ALST, 'Reference Alias ID', itU32, nil, cpNormal, True),
          wbString(ALID, 'Alias Name', 0, cpNormal, True),
          wbQUSTAliasFlags,
          wbInteger(ALFI, 'Force Into Alias When Filled', itS32, wbQuestAliasToStr, wbStrToAlias),
          //wbFormIDCk(ALFL, 'Specific Location', [LCTN]),
          wbFormID(ALFR, 'Forced Reference'),
          wbFormIDCk(ALUA, 'Unique Actor', [NPC_]),
          wbRStruct('Location Alias Reference', [
            wbInteger(ALFA, 'Alias', itS32, wbQuestAliasToStr, wbStrToAlias),
            wbFormIDCk(KNAM, 'Keyword', [KYWD]),
            wbFormIDCk(ALRT, 'Ref Type', [LCRT])
          ], []),
          wbRStruct('External Alias Reference', [
            wbFormIDCk(ALEQ, 'Quest', [QUST]),
            wbInteger(ALEA, 'Alias', itS32, wbQuestExternalAliasToStr, wbStrToAlias)
          ], []),
          wbRStruct('Create Reference to Object', [
            wbFormID(ALCO, 'Object'),
            wbStruct(ALCA, 'Alias', [
              wbInteger('Alias', itS16, wbQuestAliasToStr, wbStrToAlias),
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
          ], []),
          wbRStruct('Find Matching Reference Near Alias', [
            wbInteger(ALNA, 'Alias', itS32, wbQuestAliasToStr, wbStrToAlias),
            wbInteger(ALNT, 'Type', itU32, wbEnum([
              'Linked From',
              'Linked Ref'
            ]))
          ], []),
          wbRStruct('Find Matching Reference From Event', [
            wbInteger(ALFE, 'From Event', itU32, wbQuestEventEnum),
            wbInteger(ALFD, 'Event Data', itU32, wbEventMemberEnum)
          ], []),
          wbInteger(ALCC, 'Closest To Alias', itS32, wbQuestAliasToStr, wbStrToAlias),
          wbCTDAs,
          wbKSIZ,
          wbKWDAs,
          wbCOCT,
          wbCNTOs,
          wbFormIDCk(SPOR, 'Spectator override package list', [FLST], False, cpNormal, False),
          wbFormIDCk(OCOR, 'Observe dead body override package list', [FLST], False, cpNormal, False),
          wbFormIDCk(GWOR, 'Guard warn override package list', [FLST], False, cpNormal, False),
          wbFormIDCk(ECOR, 'Combat override package list', [FLST], False, cpNormal, False),
          wbArray(ALLA, 'Linked Aliases', wbStruct('Linked Alias', [
            wbFormIDCk('Keyword', [KYWD, NULL]),
            wbInteger('Alias', itS32, wbQuestAliasToStr, wbStrToAlias)
          ])),
          wbFormIDCk(ALDN, 'Display Name', [MESG]),
          wbFormIDCk(ALFV, 'Forced Voice', [VTYP]),
          wbFormIDCk(ALDI, 'Death Item', [LVLI]),
          wbRArrayS('Alias Spells', wbFormIDCk(ALSP, 'Spell', [SPEL])),
          wbRArrayS('Alias Factions', wbFormIDCk(ALFC, 'Faction', [FACT])),
          wbRArray('Alias Package Data', wbFormIDCk(ALPC, 'Package', [PACK])),
          wbFormIDCk(VTCK, 'Voice Types', [NPC_, FACT, FLST, VTYP, NULL]),
          wbEmpty(ALED, 'Alias End', cpNormal, True)
        ], [], cpNormal, False, nil, False, nil, wbContainerAfterSet),

        // Location Alias
        wbRStructSK([0], 'Alias', [
          wbInteger(ALLS, 'Location Alias ID', itU32),
          wbString(ALID, 'Alias Name'),
          wbQUSTAliasFlags,
          wbInteger(ALFI, 'Force Into Alias When Filled', itS32, wbQuestAliasToStr, wbStrToAlias),
          wbFormIDCk(ALFL, 'Specific Location', [LCTN]),
          wbRStruct('Reference Alias Location', [
            wbInteger(ALFA, 'Alias', itS32, wbQuestAliasToStr, wbStrToAlias),
            wbFormIDCk(KNAM, 'Keyword', [KYWD])
          ], []),
          wbRStruct('External Alias Location', [
            wbFormIDCk(ALEQ, 'Quest', [QUST]),
            wbInteger(ALEA, 'Alias', itS32, wbQuestExternalAliasToStr, wbStrToAlias)
          ], []),
          wbRStruct('Find Matching Location From Event', [
            wbInteger(ALFE, 'From Event', itU32, wbQuestEventEnum),
            wbInteger(ALFD, 'Event Data', itU32, wbEventMemberEnum)
          ], []),
          wbCTDAs,
          wbInteger(ALCC, 'Closest To Alias', itS32, wbQuestAliasToStr, wbStrToAlias),
          wbEmpty(ALED, 'Alias End', cpNormal, True)
        ], []),

        // Ref Collection Alias
        wbRStructSK([0], 'Alias', [
          wbInteger(ALCS, 'Collection Alias ID', itU32),
          wbInteger(ALMI, 'Max Initial Fill Count', itU8)
        ], [])

      ], [])
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
    wbRStruct('IY', [wbPhonemeTargets], []),
    wbRStruct('IH', [wbPhonemeTargets], []),
    wbRStruct('EH', [wbPhonemeTargets], []),
    wbRStruct('EY', [wbPhonemeTargets], []),
    wbRStruct('AE', [wbPhonemeTargets], []),
    wbRStruct('AA', [wbPhonemeTargets], []),
    wbRStruct('AW', [wbPhonemeTargets], []),
    wbRStruct('AY', [wbPhonemeTargets], []),
    wbRStruct('AH', [wbPhonemeTargets], []),
    wbRStruct('AO', [wbPhonemeTargets], []),
    wbRStruct('OY', [wbPhonemeTargets], []),
    wbRStruct('OW', [wbPhonemeTargets], []),
    wbRStruct('UH', [wbPhonemeTargets], []),
    wbRStruct('UW', [wbPhonemeTargets], []),
    wbRStruct('ER', [wbPhonemeTargets], []),
    wbRStruct('AX', [wbPhonemeTargets], []),
    wbRStruct('S',  [wbPhonemeTargets], []),
    wbRStruct('SH', [wbPhonemeTargets], []),
    wbRStruct('Z',  [wbPhonemeTargets], []),
    wbRStruct('ZH', [wbPhonemeTargets], []),
    wbRStruct('F',  [wbPhonemeTargets], []),
    wbRStruct('TH', [wbPhonemeTargets], []),
    wbRStruct('V',  [wbPhonemeTargets], []),
    wbRStruct('DH', [wbPhonemeTargets], []),
    wbRStruct('M',  [wbPhonemeTargets], []),
    wbRStruct('N',  [wbPhonemeTargets], []),
    wbRStruct('NG', [wbPhonemeTargets], []),
    wbRStruct('L',  [wbPhonemeTargets], []),
    wbRStruct('R',  [wbPhonemeTargets], []),
    wbRStruct('W',  [wbPhonemeTargets], []),
    wbRStruct('Y',  [wbPhonemeTargets], []),
    wbRStruct('HH', [wbPhonemeTargets], []),
    wbRStruct('B',  [wbPhonemeTargets], []),
    wbRStruct('D',  [wbPhonemeTargets], []),
    wbRStruct('JH', [wbPhonemeTargets], []),
    wbRStruct('G',  [wbPhonemeTargets], []),
    wbRStruct('P',  [wbPhonemeTargets], []),
    wbRStruct('T',  [wbPhonemeTargets], []),
    wbRStruct('K',  [wbPhonemeTargets], []),
    wbRStruct('CH', [wbPhonemeTargets], []),
    wbRStruct('SIL', [wbPhonemeTargets], []),
    wbRStruct('SHOTSIL', [wbPhonemeTargets], []),
    wbRStruct('FLAP', [wbPhonemeTargets], [])
  ], []);

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
    ], [])
    .SetSummaryKey([1, 0])
    .SetSummaryDelimiter(' = ')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseEquipSlots);

  var wbBodyPartIndexEnum := wbEnum([
    'Body Texture'
  ]);

  var wbBodyParts :=
    wbRArrayS('Parts',
      wbRStructSK([0], 'Part', [
        wbInteger(INDX, 'Index', itU32, wbBodyPartIndexEnum),
        wbGenericModel
      ], [])
      .SetSummaryKey([0, 1])
      .SetSummaryMemberPrefixSuffix(0, '[', ']')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfSummaryNoSortKey)
      .IncludeFlag(dfCollapsed, wbCollapseBodyParts)
    , cpNormal, True);

  wbRecord(RACE, 'Race',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
    wbKSIZ,
    wbKWDAs,
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
      ])),
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
      ])),
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
    ], [])),
    wbInteger(VNAM, 'Equipment Flags', itU32, wbEquipType),
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
        wbRArray('Actor Keywords', wbFormIDCk(SAKD, 'Keyword', [KYWD])),
        wbString(SGNM, 'Behaviour Graph'),
        wbRArray('Animation Paths', wbString(SAPT, 'Path'), cpNormal, True),
        wbRArray('Target Keywords', wbFormIDCk(STKD, 'Keyword', [KYWD])),
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
      ], [])
    ),
    wbInteger(MLSI, 'Morph Last Index', itU32, wbIntToHexStr, wbHexStrToInt),
    wbString(HNAM, 'Hair Color Lookup Texture'),
    wbString(HLTX, 'Hair Color Extended Lookup Texture'),
    wbFormIDCk(QSTI, 'Dialogue Quest', [QUST]),
    wbBSMPSequence
  ], False, nil, cpNormal, False, nil, wbRACEAfterSet);


  wbRefRecord(REFR, 'Placed Object', wbFormaterUnion(wbREFRRecordFlagsDecider, [
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
    {ACTI STAT SCOL TREE} wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
    {CONT TERM} wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
    {DOOR} wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
    {LIGH} wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
    {MSTT} wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
    {ADDN} wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000400} 10, 'Persistent',
      {0x00000800} 11, 'Initially Disabled',
      {0x00010000} 16, 'Is Full LOD',
      {0x10000000} 28, 'Reflected By Auto Water',
      {0x20000000} 29, 'Don''t Havok Settle',
      {0x40000000} 30, 'No Respawn',
      {0x80000000} 31, 'Multibound'
    ], True, True)),
    {ALCH BOOK SCRL AMMO ARMO INGR KEYM MISC FURN WEAP}
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
    wbStruct(XMBO, 'Bound Half Extents', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),

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

    wbUnknown(XORD),

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
        ])),
        wbByteArray('Unknown', 2)
      ]),
      wbFormIDCk(LNAM, 'Lighting Template', [LGTM]),
      wbFormIDCk(INAM, 'Image Space', [IMGS]),
      wbRArrayS('Linked Rooms',
        wbFormIDCk(XLRM, 'Linked Room', [REFR])
      ).SetCountPath('XRMR\Linked Rooms Count')
    ], []),
    wbEmpty(XMBP, 'MultiBound Primitive Marker', cpIgnore),

    {--- Ragdoll ---}
    wbXRGD,
    wbXRGB,

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
      wbFormIDCk(XLTW, 'Water', [REFR])
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
      ])),
      wbFormIDCk('Transition Interior', [CELL, NULL])
    ]),
    wbFormIDCk(XTNM, 'Teleport Loc Name', [MESG]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

    {--- Placed Water ---}
    wbUnknown(XWCN),
    wbStruct(XWCU, 'Water Velocity', [
      wbFloat('X Offset'),
      wbFloat('Y Offset'),
      wbFloat('Z Offset'),
      wbByteArray('Unknown', 4),
      wbFloat('X Angle'),
      wbFloat('Y Angle'),
      wbFloat('Z Angle'),
      wbByteArray('Unknown', 0)
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
      wbInteger('Flags', itU32, wbFlags(['Ignores Distance Checks']))
    ]),
    wbStruct(XBSD, 'Spline', [
      wbFloat('Slack'),
      wbFloat('Thickness'),
      wbStruct('Half Extents', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]),
      wbInteger('Wind - Detached End', itU8, wbBoolEnum),
      wbByteArray('Unused', 0) // junk data?
    ], cpNormal, False, nil, 5),
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
      ], True)),
      wbRArrayS('Activate Parent Refs',
        wbStructSK(XAPR, [0], 'Activate Parent Ref', [
          wbFormIDCk('Reference', sigReferences),
          wbFloat('Delay')
        ])
      )
    ], []),

    wbFormIDCk(XLIB, 'Leveled Item Base Object', [LVLI]),
    wbXLCM,
    wbFormIDCk(XLCN, 'Persistent Location', [LCTN]),

    {>>> COLL form Index value <<<}
    wbInteger(XTRI, 'Collision Layer', itU32),

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
      wbByteArray('Unused', 3, cpIgnore),
      wbFormIDCkNoReach('Key', [KEYM, NULL]),
      wbInteger('Flags', itU8, wbFlags(['', '', 'Leveled Lock'])),
      wbByteArray('Unused', 3, cpIgnore),
      wbUnknown
    ], cpNormal, False, nil, 4),

    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),

    {--- Generated Data ---}
    wbStruct(XNDP, 'Navigation Door Link', [
      wbFormIDCk('Navigation Mesh', [NAVM]),
      wbInteger('Teleport Marker Triangle', itS16, wbREFRNavmeshTriangleToStr, wbStringToInt),
      wbByteArray('Unused', 2, cpIgnore)
    ]),

    wbFormIDCk(XLRL, 'Location Reference', [LCRT, LCTN, NULL], False, cpBenignIfAdded),
    wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),
    wbEmpty(XIS2, 'Ignored by Sandbox'),

    {--- Ownership ---}
    wbXOWN,
    wbXRNK,

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
    ], [])),

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
      ]), cpNormal, True),
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
          65, 'Mechanist LairRaider settlementVassal settlementPotential Vassal settlement', {Vv}
          66, 'Custom 66',
          67, 'Custom 67',
          68, 'Custom 68',
          69, 'Custom 69',
          70, 'Custom 70',
          71, 'Custom 71',
          72, 'Custom 72',
          73, 'Custom 73',
          74, 'Custom 74',
          75, 'Custom 75',
          76, 'Custom 76',
          77, 'Custom 77',
          78, 'Custom 78',
          79, 'Custom 79',
          80, 'Custom 80',
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
        wbByteArray('Unused', 1)
      ], cpNormal, True)
    ], []),

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
    ], []),

    wbUnknown(XCVR),
    wbUnknown(XCVL),
    wbFormIDCk(XCZR, 'Current Zone Reference', sigReferences),
    wbUnknown(XCZA),
    wbFormIDCk(XCZC, 'Current Zone Cell', [CELL, NULL]),

    wbXSCL,
    wbXLOD, // not seen in FO4 vanilla files
    wbDataPosRot,
    wbString(MNAM, 'Comments')
  ], True, wbPlacedAddInfo, cpNormal, False, wbREFRAfterLoad);

  wbRecord(REGN, 'Region',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000040} 6, 'Border Region'
    ])), [
    wbEDID,
    wbStruct(RCLR, 'Map Color', [
      wbInteger('Red', itU8),
      wbInteger('Green', itU8),
      wbInteger('Blue', itU8),
      wbByteArray('Unknown', 1)
    ], cpNormal, True).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
    wbFormIDCkNoReach(WNAM, 'Worldspace', [WRLD]),
    wbRArray('Region Areas', wbRStruct('Region Area', [
      wbInteger(RPLI, 'Edge Fall-off', itU32),
      wbArray(RPLD, 'Region Point List Data', wbStruct('Point', [
        wbFloat('X'),
        wbFloat('Y')
      ]), 0, wbRPLDAfterLoad),
      wbUnknown(ANAM)
    ], [])),
    wbRArrayS('Region Data Entries', wbRStructSK([0], 'Region Data Entry', [
      {always starts with an RDAT}
      wbStructSK(RDAT, [0], 'Data Header', [
        wbInteger('Type', itU32, wbEnum([
          {0} 'Unknown 0',
          {1} 'Unknown 1',
          {2} 'Objects',
          {3} 'Weather',
          {4} 'Map',
          {5} 'Land',
          {6} 'Grass',
          {7} 'Sound',
          {8} 'Imposter',
          {9} 'Unknown 10',
          {10}'Unknown 11',
          {11}'Unknown 12',
          {12}'Unknown 13',
          {13}'Unknown 14',
          {14}'Unknown 15',
          {15}'Unknown 16'
        ])),
        wbInteger('Flags', itU8, wbFlags([
          'Override'
        ])),
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
        ])),
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

    ], []))
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
    wbUnknown
    (*
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
    ])),
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
    *)
  ], cpNormal, True);

  {subrecords checked against Starfield.esm}
  wbRecord(SPEL, 'Spell', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbFULL,
    wbKeywords,
    wbETYP,
    wbPUSHPDSH,
    wbDESCReq,
    wbSPIT,
    wbEffectsReq
  ], False, nil, cpNormal, False, nil, nil);

  {wbRecord(SCRL, 'Scroll', [
    wbEDID
  ]);}

  wbRecord(STAT, 'Static',
    wbFlags(wbRecordFlagsFlags, [ //flags not checked aginst Starfield
      {0x00000001} { 0} '',
      {0x00000002} { 1} '',
      {0x00000004} { 2} 'Heading Marker',
      {0x00000008} { 3} '',
      {0x00000010} { 4} 'Non Occluder',
      {0x00000020} { 5} 'Deleted',
      {0x00000040} { 6} 'Has Tree LOD', // Used in Fallout 4 ?
      {0x00000080} { 7} 'Add-On LOD Object',
      {0x00000100} { 8} '',
      {0x00000200} { 9} 'Hidden From Local Map',
      {0x00000400} {10} 'Headtrack Marker',
      {0x00000800} {11} 'Used as Platform',
      {0x00001000} {12} '',
      {0x00002000} {13} 'Pack-In Use Only',
      {0x00004000} {14} '',
      {0x00008000} {15} 'Has Distant LOD',
      {0x00010000} {16} '',
      {0x00020000} {17} 'Uses HD LOD Texture',
      {0x00040000} {18} '',
      {0x00080000} {19} 'Has Currents',
      {0x00100000} {20} '',
      {0x00200000} {21} '',
      {0x00400000} {22} '',
      {0x00800000} {23} 'Is Marker',
      {0x01000000} {24} '',
      {0x02000000} {25} 'Obstacle',
      {0x04000000} {26} 'NavMesh Generation - Filter',
      {0x08000000} {27} 'NavMesh Generation - Bounding Box',
      {0x10000000} {28} 'Show In World Map (Sky Cell Only)',
      {0x20000000} {29} '',
      {0x40000000} {30} 'NavMesh Generation - Ground',
      {0x80000000} {31} ''
    ]), [
    wbEDID,
//    wbVMAD,
    wbOBND(True),
//    wbPTT2,
    wbODTY,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH, //order between SNBH
    wbXALG, //and XALG unknown
    wbDEFL,
    wbBaseFormComponents,
    wbFTYP,
    wbGenericModel,
    wbPRPS,
    wbFULL,
    wbStruct(DNAM, 'Direction Material', [
      wbFloat('Max Angle (30-120)'),
      wbFormIDCk('Material', [MATO, NULL]),
      wbFloat('Leaf Amplitude'),
      wbFloat('Leaf Frequency')
    ], cpNormal, True, nil, 2),
    wbUnknown(STLS), //order between STLS
    wbNVNM           //and NVNM unknown
    (*
    wbArray(MNAM, 'Distant LOD',
      wbStruct('LOD', [
        {>>> Contains null-terminated mesh FileName followed by random data up to 260 bytes <<<}
        wbString(True, 'Mesh', 260)
        //wbByteArray('Mesh', 260, cpIgnore)
      ]), [
        'Level 0',
        'Level 1',
        'Level 2',
        'Level 3'
      ],
      cpNormal, False
    )
    *)
  ], True);  // unordered, NVNM can be before or after MNAM

  wbRecord(TES4, 'Main File Header',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000001}  0, 'ESM',
      {0x00000010}  4, 'Optimized File',
      {0x00000080}  7, 'Localized',
      {0x00000100}  8, 'ESL',
      {0x00000200}  9, 'Unknown'
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
    wbInteger(INCC, 'Internal Cell Count', itU32),                    // Size of some array of 12 bytes elements
    wbUnknown(CHGL)
  ], True, nil, cpNormal, True, wbRemoveOFST);

  wbRecord(PLYR, 'Player Reference', [
    wbEDID,
    wbFormID(PLYR, 'Player', cpNormal, True).SetDefaultNativeValue($7)
  ]).IncludeFlag(dfInternalEditOnly);
end;

procedure DefineSF1o;
begin
  wbRecord(TREE, 'Tree',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
      wbFloat('Trunk Flexibility'),
      wbFloat('Branch Flexibility'),
      wbFloat('Trunk Amplitude'),
      wbFloat('Front Amplitude'),
      wbFloat('Back Amplitude'),
      wbFloat('Side Amplitude'),
      wbFloat('Front Frequency'),
      wbFloat('Back Frequency'),
      wbFloat('Side Frequency'),
      wbFloat('Leaf Flexibility'),
      wbFloat('Leaf Amplitude'),
      wbFloat('Leaf Frequency')
    ], cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(FLOR, 'Flora', [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel,
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbUnknown(PNAM),
    wbATTX,
    wbUnknown(FNAM),
    wbUnknown(JNAM),
    wbFormIDCk(PFIG, 'Ingredient', sigBaseObjects),
    wbUnknown(PFHS),
    wbStruct(PFPC, 'Ingredient Production', [
      wbInteger('Spring', itU8),
      wbInteger('Summer ', itU8),
      wbInteger('Fall', itU8),
      wbInteger('Winter', itU8)
    ], cpNormal, True),
    wbAPPR,
    wbObjectTemplate,
    wbEmpty(STOP, 'Marker').SetRequired(True),
    wbFormIDCk(ANAM, 'Action Keyword', [KYWD]),
    wbUnknown(BNAM),
    wbUnknown(FMAH),
    wbUnknown(FMIH),
    wbFormIDCk(FMAG, 'Max Global', [GLOB]),
    wbFormIDCk(FMIG, 'Min Global', [GLOB]),
    wbFormIDCk(FLXP, 'Explosion', [EXPL]),
    wbUnknown(FHLS)
  ], False, nil, cpNormal, False, nil, nil);

  wbRecord(WATR, 'Water', [
    wbEDID,
    wbFULL,
    wbInteger(ANAM, 'Opacity (unused)', itU8),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      {0x01} 'Dangerous',
      {0x02} 'Unknown 1',
      {0x04} 'Directional Sound'
    ]), cpNormal, True),
    wbFormIDCk(TNAM, 'Material (unused)', [MATT]),
    wbFormIDCk(SNAM, 'Open Sound', [SNDR, NULL]),
    wbFormIDCk(XNAM, 'Consume Spell', [SPEL]),
    wbFormIDCk(YNAM, 'Contact Spell', [SPEL]),
    wbFormIDCk(INAM, 'Image Space', [IMGS]),
    wbByteArray(DATA, 'Unused', 0),
    wbStruct(DNAM, 'Visual Data', [
      wbStruct('Fog Properties', [
        wbFloat('Depth Amount'),
        wbByteColors('Shallow Color'),
        wbByteColors('Deep Color'),
        wbFloat('Color Shallow Range'),
        wbFloat('Color Deep Range'),
        wbFloat('Shallow Alpha'),
        wbFloat('Deep Alpha'),
        wbFloat('Alpha Shallow Range'),
        wbFloat('Alpha Deep Range'),
        wbByteColors('Underwater Color'),
        wbFloat('Underwater Fog Amount'),
        wbFloat('Underwater Near Fog'),
        wbFloat('Underwater Far Fog')
      ]),
      wbStruct('Physical Properties', [
        wbFloat('Normal Magnitude'),
        wbFloat('Shallow Normal Falloff'),
        wbFloat('Deep Normal Falloff'),
        wbFloat('Reflectivity Amount'),
        wbFloat('Fresnel Amount'),
        wbFloat('Surface Effect Falloff'),
        wbStruct('Displacement Simulator', [
          wbFloat('Force'),
          wbFloat('Velocity'),
          wbFloat('Falloff'),
          wbFloat('Dampener'),
          wbFloat('Starting Size')
        ]),
        wbByteColors('Reflection Color')
      ]),
      wbStruct('Specular Properties', [
        wbFloat('Sun Specular Power'),
        wbFloat('Sun Specular Magnitude'),
        wbFloat('Sun Sparkle Power'),
        wbFloat('Sun Sparkle Magnitude'),
        wbFloat('Interior Specular Radius'),
        wbFloat('Interior Specular Brightness'),
        wbFloat('Interior Specular Power')
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
        wbFloat('Layer 1 - UV Scale'),
        wbFloat('Layer 2 - UV Scale'),
        wbFloat('Layer 3 - UV Scale'),
        wbFloat('Layer 1 - Noise Falloff'),
        wbFloat('Layer 2 - Noise Falloff'),
        wbFloat('Layer 3 - Noise Falloff')
      ]),
      wbStruct('Silt Properties', [
        wbFloat('Silt Amount'),
        wbByteColors('Light Color'),
        wbByteColors('Dark Color')
      ]),
      wbInteger('Screen Space Reflections', itU8, wbBoolEnum)
    ], cpNormal, True, nil, 4),
    wbByteArray(GNAM, 'Unused', 0),
    wbStruct(NAM0, 'Linear Velocity', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ], cpNormal, False).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
    wbStruct(NAM1, 'Angular Velocity', [
      wbFloat('X'),
      wbFloat('Y'),
      wbFloat('Z')
    ], cpNormal, False).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
    wbString(NAM2, 'Layer 1 Noise Texture'),
    wbString(NAM3, 'Layer 2 Noise Texture'),
    wbString(NAM4, 'Layer 3 Noise Texture')
  ]);

  wbRecord(WEAP, 'Weapon',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  2, 'Non-Playable',
      {0x20000000} 30, 'High-Res 1st Person Only'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbPTT2,
    wbSTCP,
    wbFULL,
    wbGenericModel,
    wbICON,
    wbMICO,
    wbEITM,
    wbInteger(EAMT, 'Enchantment Amount', itU16),
    wbDEST,
    wbETYP,
    wbFormIDCk(BIDS, 'Block Bash Impact Data Set', [IPDS, NULL]),
    wbFormIDCk(BAMT, 'Alternate Block Material', [MATT, NULL]),
    wbYNAM,
    wbZNAM,
    wbKSIZ,
    wbKWDAs,
    wbDESC,
    wbFormIDCk(INRD, 'Instance Naming', [INNR]),
    wbAPPR,
    wbObjectTemplate,
    wbEmpty(STOP, 'Marker', cpNormal, True),
    wbFormIDCk(NNAM, 'Embedded Weapon Mod', [OMOD]),
    wbRStruct('1st Person Model', [
      wbString(MOD4, 'Model FileName'),
      wbModelInfo(MO4T),
      wbMO4S,
      wbMO4C,
      wbMO4F
    ], []),
    wbStruct(DNAM, 'Data', [
      wbFormIDCk('Ammo', [AMMO, NULL]),
      wbFloat('Speed'),
      wbFloat('Reload Speed'),
      wbFloat('Reach'),
      wbFloat('Min Range'),
      wbFloat('Max Range'),
      wbFloat('Attack Delay'),
      wbByteArray('Unknown', 4),
      wbFloat('Damage - OutOfRange Mult'),
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
      ])),
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
      wbFloat('Animation Attack Seconds'),
      wbByteArray('Unknown', 2),
      wbFloat('Action Point Cost'),
      wbFloat('Full Power Seconds'),
      wbFloat('Min Power Per Shot'),
      wbInteger('Stagger', itU32, wbStaggerEnum),
      wbByteArray('Unknown', 4)
    ]),
    wbStruct(FNAM, '', [
      wbFloat('Animation Fire Seconds'),
      wbFloat('Rumble - Left Motor Strength'),
      wbFloat('Rumble - Right Motor Strength'),
      wbFloat('Rumble - Duration'),
      wbFloat('Animation Reload Seconds'),
      wbByteArray('Bolt Anim Seconds', 4),
      wbFloat('Sighted Transition Seconds'),
      wbInteger('# Projectiles', itU8),
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
      wbFloat('Crit Damage Mult'),
      wbFloat('Crit Charge Bonus'),
      wbFormIDCk('Crit Effect', [SPEL, NULL])
    ]),
    wbFormIDCk(INAM, 'Impact Data Set', [IPDS]),
    wbFormIDCk(LNAM, 'NPC Add Ammo List', [LVLI]),
    wbFormIDCk(WAMD, 'Aim Model', [AMDL]),
    wbFormIDCk(WZMD, 'Zoom', [ZOOM]),
    wbFormIDCk(CNAM, 'Template', [WEAP]),
    wbStructs(DAMA, 'Damage Types', 'Damage Type', [
      wbFormIDCk('Type', [DMGT]),
      wbInteger('Amount', itU32)
    ]),
    wbFLTR,
    wbInteger(MASE, 'Melee Speed', itU32, wbEnum([
      'Very Slow',
      'Slow',
      'Medium',
      'Fast',
      'Very Fast'
    ]))
  ], False, nil, cpNormal, False, nil{wbWEAPAfterLoad}, wbKeywordsAfterSet);

  wbRecord(WRLD, 'Worldspace',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00080000} 19, 'Can''t Wait'
    ])), [
    wbEDID,
    wbRArray('Unused RNAM', wbUnknown(RNAM), cpIgnore, False{, wbNeverShow}),
    wbMaxHeightDataWRLD,
    wbFULL,
    wbStruct(WCTR, 'Fixed Dimensions Center Cell', [
      wbInteger('X', itS16),
      wbInteger('Y', itS16)
    ]),
    wbFormIDCk(LTMP, 'Interior Lighting', [LGTM]),
    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN, NULL]),
    wbFormIDCk(XLCN, 'Location', [LCTN, NULL]),
    wbRStruct('Parent', [
      wbFormIDCk(WNAM, 'Worldspace', [WRLD]),
      wbStruct(PNAM, '', [
        wbInteger('Flags', itU8, wbFlags([
          {0x0001} 'Use Land Data',
          {0x0002} 'Use LOD Data',
          {0x0004} 'Use Map Data',
          {0x0008} 'Use Water Data',
          {0x0010} 'Use Climate Data',
          {0x0020} 'Use Image Space Data (unused)',
          {0x0040} 'Use Sky Cell'
        ], [5])),
        wbByteArray('Unknown', 1)
      ], cpNormal, True)
    ], []),
    wbFormIDCk(CNAM, 'Climate', [CLMT]),
    wbFormIDCk(NAM2, 'Water', [WATR]),
    wbFormIDCk(NAM3, 'LOD Water Type', [WATR]),
    wbFloat(NAM4, 'LOD Water Height'),
    wbStruct(DNAM, 'Land Data', [
      wbFloat('Default Land Height'),
      wbFloat('Default Water Height')
    ]),
    wbString(ICON, 'Map Image'),
    wbRStruct('Cloud Model', [wbGenericModel], []),
    wbStruct(MNAM, 'Map Data', [
      wbStruct('Usable Dimensions', [
        wbInteger('X', itS32),
        wbInteger('Y', itS32)
      ]),
      wbStruct('Cell Coordinates', [
        wbStruct('NW Cell', [
          wbInteger('X', itS16),
          wbInteger('Y', itS16)
        ]),
        wbStruct('SE Cell', [
          wbInteger('X', itS16),
          wbInteger('Y', itS16)
        ])
      ])
    ]),
    wbStruct(ONAM, 'World Map Offset Data', [
      wbFloat('World Map Scale'),
      wbFloat('Cell X Offset'),
      wbFloat('Cell Y Offset'),
      wbFloat('Cell Z Offset')
    ], cpNormal, True),
    wbFloat(NAMA, 'Distant LOD Multiplier'),
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      {0x01} 'Small World',
      {0x02} 'Can''t Fast Travel',
      {0x04} 'Unknown 3',
      {0x08} 'No LOD Water',
      {0x10} 'No Landscape',
      {0x20} 'No Sky',
      {0x40} 'Fixed Dimensions',
      {0x80} 'No Grass'
    ]), cpNormal, True),
    {>>> Object Bounds doesn't show up in CK <<<}
    wbWorldspaceOBND,
    wbFormIDCk(ZNAM, 'Music', [MUSC]),
    wbString(NNAM, 'Canopy Shadow (unused)', 0, cpIgnore),
    wbString(XWEM, 'Water Environment Map'),
    wbString(TNAM, 'HD LOD Diffuse Texture'),
    wbString(UNAM, 'HD LOD Normal Texture'),
    wbRStruct('World Default Level Data', [
      wbStruct(WLEV, 'Dimension', [
        wbStruct('NW Cell', [
          wbInteger('X', itS8),
          wbInteger('Y', itS8)
        ]),
        wbStruct('Size', [
          wbInteger('Width', itU8),
          wbInteger('Height', itU8)
        ])
      ]),
      wbByteArray(WLEV, 'Data')
    ], []),
    wbOFST,
    wbByteArray(CLSZ, 'Cell Size Data')
  ], False, nil, cpNormal, False, wbWRLDAfterLoad);


  wbRecord(WTHR, 'Weather',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000200}  9, 'Unknown 9'
    ])), [
    wbEDID,
    wbString(_30_0TX, 'Cloud Texture Layer #0'),
    wbString(_31_0TX, 'Cloud Texture Layer #1'),
    wbString(_32_0TX, 'Cloud Texture Layer #2'),
    wbString(_33_0TX, 'Cloud Texture Layer #3'),
    wbString(_34_0TX, 'Cloud Texture Layer #4'),
    wbString(_35_0TX, 'Cloud Texture Layer #5'),
    wbString(_36_0TX, 'Cloud Texture Layer #6'),
    wbString(_37_0TX, 'Cloud Texture Layer #7'),
    wbString(_38_0TX, 'Cloud Texture Layer #8'),
    wbString(_39_0TX, 'Cloud Texture Layer #9'),
    wbString(_3A_0TX, 'Cloud Texture Layer #10'),
    wbString(_3B_0TX, 'Cloud Texture Layer #11'),
    wbString(_3C_0TX, 'Cloud Texture Layer #12'),
    wbString(_3D_0TX, 'Cloud Texture Layer #13'),
    wbString(_3E_0TX, 'Cloud Texture Layer #14'),
    wbString(_3F_0TX, 'Cloud Texture Layer #15'),
    wbString(_40_0TX, 'Cloud Texture Layer #16'),
    wbString(A0TX, 'Cloud Texture Layer #17'),
    wbString(B0TX, 'Cloud Texture Layer #18'),
    wbString(C0TX, 'Cloud Texture Layer #19'),
    wbString(D0TX, 'Cloud Texture Layer #20'),
    wbString(E0TX, 'Cloud Texture Layer #21'),
    wbString(F0TX, 'Cloud Texture Layer #22'),
    wbString(G0TX, 'Cloud Texture Layer #23'),
    wbString(H0TX, 'Cloud Texture Layer #24'),
    wbString(I0TX, 'Cloud Texture Layer #25'),
    wbString(J0TX, 'Cloud Texture Layer #26'),
    wbString(K0TX, 'Cloud Texture Layer #27'),
    wbString(L0TX, 'Cloud Texture Layer #28'),
    wbString(M0TX, 'Cloud Texture Layer #29'),
    wbString(N0TX, 'Cloud Texture Layer #30'),
    wbString(O0TX, 'Cloud Texture Layer #31'),
    wbUnknown(LNAM),
    wbFormIDCK(MNAM, 'Precipitation Type', [SPGD, NULL]),
    wbFormIDCK(NNAM, 'Visual Effect', [RFCT, NULL], False, cpNormal, True),
    wbByteArray(ONAM, 'Unused', 0, cpIgnore),
    wbRStruct('Cloud Speed', [
      wbArray(RNAM, 'Y Speed', wbInteger('Layer', itU8, wbCloudSpeedToStr, wbCloudSpeedToInt)).IncludeFlag(dfNotAlignable),
      wbArray(QNAM, 'X Speed', wbInteger('Layer', itU8, wbCloudSpeedToStr, wbCloudSpeedToInt)).IncludeFlag(dfNotAlignable)
    ], []),
    wbArray(PNAM, 'Cloud Colors', wbWeatherColors('Layer'), 32).IncludeFlag(dfNotAlignable),
    wbArray(JNAM, 'Cloud Alphas', wbStruct('Layer', [
      wbFloat('Sunrise').SetDefaultNativeValue(1.0),
      wbFloat('Day').SetDefaultNativeValue(1.0),
      wbFloat('Sunset').SetDefaultNativeValue(1.0),
      wbFloat('Night').SetDefaultNativeValue(1.0),
      wbFromVersion(111, wbFloat('EarlySunrise').SetDefaultNativeValue(1.0)),
      wbFromVersion(111, wbFloat('LateSunrise').SetDefaultNativeValue(1.0)),
      wbFromVersion(111, wbFloat('EarlySunset').SetDefaultNativeValue(1.0)),
      wbFromVersion(111, wbFloat('EarlySunrise').SetDefaultNativeValue(1.0))
    ]), 32).IncludeFlag(dfNotAlignable),
    wbStruct(NAM0, 'Weather Colors', [
      wbWeatherColors('Sky-Upper'),
      wbWeatherColors('Fog Near'),
      wbWeatherColors('Unknown'),
      wbWeatherColors('Ambient'),
      wbWeatherColors('Sunlight'),
      wbWeatherColors('Sun'),
      wbWeatherColors('Stars'),
      wbWeatherColors('Sky-Lower'),
      wbWeatherColors('Horizon'),
      wbWeatherColors('Effect Lighting'),
      wbWeatherColors('Cloud LOD Diffuse'),
      wbWeatherColors('Cloud LOD Ambient'),
      wbWeatherColors('Fog Far'),
      wbWeatherColors('Sky Statics'),
      wbWeatherColors('Water Multiplier'),
      wbWeatherColors('Sun Glare'),
      wbWeatherColors('Moon Glare'),
      wbFromVersion(119, wbWeatherColors('Fog Near High')),
      wbFromVersion(119, wbWeatherColors('Fog Far High'))
    ], cpNormal, True),
    wbArray(NAM4, 'Unknown', wbFloat('Unknown').SetDefaultNativeValue(1.0), 32).IncludeFlag(dfNotAlignable),
    wbStruct(FNAM, 'Fog Distance', [
      wbFloat('Day - Near'),
      wbFloat('Day - Far'),
      wbFloat('Night - Near'),
      wbFloat('Night - Far'),
      wbFloat('Day - Power'),
      wbFloat('Night - Power'),
      wbFloat('Day - Max'),
      wbFloat('Night - Max'),
      wbFromVersion(119, wbFloat('Day - Near Height Mid').SetDefaultNativeValue(0.0)),
      wbFromVersion(119, wbFloat('Day - Near Height Range').SetDefaultNativeValue(10000.0)),
      wbFromVersion(119, wbFloat('Night - Near Height Mid').SetDefaultNativeValue(0.0)),
      wbFromVersion(119, wbFloat('Night - Near Height Range').SetDefaultNativeValue(10000.0)),
      wbFromVersion(119, wbFloat('Day - High Density Scale').SetDefaultNativeValue(1.0)),
      wbFromVersion(119, wbFloat('Night - High Density Scale').SetDefaultNativeValue(1.0)),
      wbFromVersion(120, wbFloat('Day - Far Height Mid').SetDefaultNativeValue(0.0)),
      wbFromVersion(120, wbFloat('Day - Far Height Range').SetDefaultNativeValue(10000.0)),
      wbFromVersion(120, wbFloat('Night - Far Height Mid').SetDefaultNativeValue(0.0)),
      wbFromVersion(120, wbFloat('Night - Far Height Range').SetDefaultNativeValue(10000.0))
    ], cpNormal, True),
    wbStruct(DATA, 'Data', [
      wbInteger('Wind Speed', itU8), // scaled 0..1
      wbByteArray('Unknown', 2),
      wbInteger('Trans Delta', itU8), // scaled 0..0,25
      wbInteger('Sun Glare', itU8), // scaled 0..1
      wbInteger('Sun Damage', itU8), // scaled 0..1
      wbInteger('Precipitation - Begin Fade In', itU8), // scaled 0..1
      wbInteger('Precipitation - End Fade Out', itU8), // scaled 0..1
      wbInteger('Thunder/Lightning - Begin Fade In', itU8),
      wbInteger('Thunder/Lightning - End Fade Out', itU8),
      wbInteger('Thunder/Lightning - Frequency', itU8),
      wbInteger('Flags', itU8, wbFlags([
        {0x01} 'Weather - Pleasant',
        {0x02} 'Weather - Cloudy',
        {0x04} 'Weather - Rainy',
        {0x08} 'Weather - Snow',
        {0x10} 'Sky Statics - Always Visible',
        {0x20} 'Sky Statics - Follows Sun Position',
        {0x40} 'Rain Occlusion',
        {0x80} 'HUD Rain Effects'
      ])),
      wbStruct('Lightning Color', [
        wbInteger('Red', itU8),
        wbInteger('Green', itU8),
        wbInteger('Blue', itU8)
      ]).SetToStr(wbRGBAToStr).IncludeFlag(dfCollapsed, wbCollapseRGBA),
      wbInteger('Visual Effect - Begin', itU8), // scaled 0..1
      wbInteger('Visual Effect - End', itU8), // scaled 0..1
      wbInteger('Wind Direction', itU8), // scaled 0..360
      wbInteger('Wind Direction Range', itU8), // scaled 0..180
      wbFromVersion(119, wbInteger('Wind Turbulance', itU8).SetDefaultNativeValue(51))
    ], cpNormal, True),
    wbInteger(NAM1, 'Disabled Cloud Layers', itU32, wbFlags(['0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'])),
    wbWeatherSounds,
    wbRArrayS('Sky Statics', wbFormIDCk(TNAM, 'Static', [STAT, NULL])),
    wbStruct(IMSP, 'Image Spaces', [
      wbFormIDCK('Sunrise', [IMGS, NULL]),
      wbFormIDCK('Day', [IMGS, NULL]),
      wbFormIDCK('Sunset', [IMGS, NULL]),
      wbFormIDCK('Night', [IMGS, NULL]),
      wbFromVersion(111, wbFormIDCK('EarlySunrise', [IMGS, NULL])),
      wbFromVersion(111, wbFormIDCK('LateSunrise', [IMGS, NULL])),
      wbFromVersion(111, wbFormIDCK('EarlySunset', [IMGS, NULL])),
      wbFromVersion(111, wbFormIDCK('EarlySunrise', [IMGS, NULL]))
    ], cpNormal, True),
    wbStruct(WGDR, 'God Rays', [ //Form Version 120+
      wbFormIDCK('Sunrise', [GDRY, NULL]),
      wbFormIDCK('Day', [GDRY, NULL]),
      wbFormIDCK('Sunset', [GDRY, NULL]),
      wbFormIDCK('Night', [GDRY, NULL]),
      wbFormIDCK('EarlySunrise', [GDRY, NULL]),
      wbFormIDCK('LateSunrise', [GDRY, NULL]),
      wbFormIDCK('EarlySunset', [GDRY, NULL]),
      wbFormIDCK('LateSunset', [GDRY, NULL])
    ]),
    wbRStruct('Directional Ambient Lighting Colors', [
      wbAmbientColors(DALC, 'Sunrise'),
      wbAmbientColors(DALC, 'Day'),
      wbAmbientColors(DALC, 'Sunset'),
      wbAmbientColors(DALC, 'Night'),
      wbAmbientColors(DALC, 'EarlySunrise'), //Form Version 111+
      wbAmbientColors(DALC, 'LateSunrise'),  //Form Version 111+
      wbAmbientColors(DALC, 'EarlySunset'),  //Form Version 111+
      wbAmbientColors(DALC, 'LateSunset')    //Form Version 111+
    ], [], cpNormal, True),
    wbRStruct('Aurora', [wbGenericModel], []),
    wbFormIDCk(GNAM, 'Sun Glare Lens Flare', [LENS]),
    wbStruct(UNAM, 'Magic', [
      wbFormIDCk('On Lightning Strike - Spell', [SPEL, NULL]),
      wbFloat('On Lightning Strike - Threshold'),
      wbFormIDCk('On Weather Activate - Spell', [SPEL, NULL]),
      wbFromVersion(130, wbFloat('On Weather Activate - Threshold')),
      wbFromVersion(130, wbByteArray('Unused', 4)), // SPEL FormID for another context but unresolved in Fallout4.esm, legacy data
      wbFromVersion(130, wbFloat('Unused'))
    ], cpNormal, False),
    wbFloat(VNAM, 'Volatility Mult'), //Form Version 126+
    wbFloat(WNAM, 'Visibility Mult')  //Form Version 126+
  ]);
end;

procedure DefineSF1p;
begin
  {wbRecord(SCPT, 'SCPT', [
    wbEDID
  ]);}
end;

{>>> Start of new Fallout 4 Records <<<}

procedure DefineSF1q;
begin
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
      ], [])
    )
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AMDL, 'Aim Model', [
    wbEDID,
    wbUnknown(ANAM)
    {
    wbStruct(DNAM, 'Data', [
      wbFloat('Cone of Fire - Min Angle'),
      wbFloat('Cone of Fire - Max Angle'),
      wbFloat('Cone of Fire - Increase Per Shot'),
      wbFloat('Cone of Fire - Decrease Per Sec'),
      wbInteger('Cone of Fire - Decrease Delay MS', itU32),
      wbFloat('Cone of Fire - Sneak Mult'),
      wbFloat('Recoil - Diminish Spring Force'),
      wbFloat('Recoil - Diminish Sights Mult'),
      wbFloat('Recoil - Max Per Shot'),
      wbFloat('Recoil - Min Per Shot'),
      wbFloat('Recoil - Hip Mult'),
      wbInteger('Runaway - Recoil Shots', itU32),
      wbFloat('Recoil - Arc'),
      wbFloat('Recoil - Arc Rotate'),
      wbFloat('Cone of Fire - Iron Sights Mult'),
      wbFloat('Stability - Base Stability')
    ])
    }
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AORU, 'Attraction Rule', [
    wbEDID,
    wbStruct(AOR2, 'Data', [
      wbFloat('Radius'),
      wbFloat('Min Delay'),
      wbFloat('Max Delay'),
      wbInteger('Requires Line of Sight', itU8, wbBoolEnum),
      wbInteger('Combat Target', itU8, wbBoolEnum),
      wbByteArray('Unused', 2)
    ], cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(BNDS, 'Bendable Spline', [
    wbEDID,
    wbOBND,
    wbODTY,
    wbBaseFormComponents,
    wbStruct(DNAM, 'Data', [
      wbFloat('Default Number of Tiles'),
      wbInteger('Default Number of Slices', itU16),
      wbInteger('Default Number of Tiles - Relative to Length', itU16, wbBoolEnum),
      wbFloatColors('Default Color'),
      wbFloat('Wind Settings - Sensibility'),
      wbFloat('Wind Settings - Flexibility')
    ]),
    wbFormIDCk(MNAM, 'Material Path', [NULL, MTPT])
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

  {subrecords checked against Starfield.esm}
  wbRecord(DFOB, 'Default Object', [
    wbEDID,
    wbXALG,
    wbFormID(DATA, 'Object')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(DMGT, 'Damage Type', [
    wbEDID,
    wbFULL,
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
      wbFloat('Intensity'),
      wbFloat('Air Color - Scale'),
      wbFloat('Back Color - Scale'),
      wbFloat('Fwd Color - Scale'),
      wbFloat('Back Phase'),
      wbFloatColors('Air Color'),
      wbFloat('Fwd Phase')
    ])
  ]);

end;

procedure DefineSF1r;
begin
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
            wbKSIZ,
            wbKWDAs,
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
          ], []),
          cpNormal, False, nil, wbINNRAfterSet
        )
      ], [])
    )
  ]);

  wbRecord(KSSM, 'Sound Keyword Mapping', [
    wbEDID,
    wbFormIDCk(DNAM, 'Primary Descriptor', [SNDR]),
    wbFormIDCk(ENAM, 'Exterior Tail', [SNDR]),
    wbFormIDCk(VNAM, 'VATS Descriptor', [SNDR]),
    wbFloat(TNAM, 'VATS Threshold'),
    wbRArray('Keywords', wbFormIDCk(KNAM, 'Keyword', [KYWD])),
    wbRArrayS('Sounds', wbStructSK(RNAM, [0], 'Sound', [
      wbInteger('Reverb Class', itU32, wbReverbClassEnum),
      wbFormIDCk('Descriptor', [SNDR])
    ]))
  ]);

  wbRecord(LAYR, 'Layer', [
    wbEDID,
    wbFormIDCk(PNAM, 'Parent', [LAYR])
  ]);

  wbRecord(LENS, 'Lens Flare', [
    wbEDID,
    wbFloat(CNAM, 'Color Influence'),
    wbFloat(DNAM, 'Fade Distance Radius Scale'),
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
          ]))
        ])
      ], []),
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
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
      ], [])
    )
  ]);

  wbRecord(NOCM, 'Navigation Mesh Obstacle Manager', [
    wbEDID,
    wbRArray('Unknown',
      wbRStruct('Unknown', [
        wbInteger(INDX, 'Index', itU32),
        wbRArray('Unknown datas',
          wbStruct(DATA, 'Unknown data', [
            wbByteArray('Unknown 1',2),
            wbByteArray('Unknown 2',2),
            wbByteArray('Unknown 4',4)
          ])
        ),
        wbUnknown(INTV),
        wbString(NAM1, 'Model')
      ], [])
    )
  ]);


  wbRecord(LGDI, 'Legendary Item', [
    wbEDID,
    wbOBND,
    wbPTT2,
    wbGenericModel,
//    wbENLT,
//    wbENLS,
//    wbAUUV,
    wbFULL,
//    wbVCRY,
    wbInteger(DATA, 'Scrip Cost', itU32),
    wbFormID(ANAM, 'Applicable Item List'),
    wbArray(BNAM, 'Legendary Mods', wbStruct('Legendary Mod', [
      wbInteger('Star Slot', itU32, wbLGDIStarSlot),
      wbFormID('Legendary Modifier')
    ])),

    wbArray(CNAM, 'Include Filters', wbStruct('Include Filter', [
      wbInteger('Star Slot', itU32, wbLGDIStarSlot),
      wbInteger('Referenced Mod', itU32, wbLGDIFiltersToStr).SetLinksToCallback(wbLGDIFiltersLinksTo),
      wbFormIDCk('Keyword', [KYWD])
    ])),

    wbArray(DNAM, 'Exclude Filters', wbStruct('Exclude Filter', [
      wbInteger('Star Slot', itU32, wbLGDIStarSlot),
      wbInteger('Referenced Mod', itU32, wbLGDIFiltersToStr).SetLinksToCallback(wbLGDIFiltersLinksTo),
      wbFormIDCk('Keyword', [KYWD])
    ])),
    wbFormID(ENAM, 'Legendary Template List')
  ]);

end;

procedure DefineSF1s;
begin
  wbRecord(NOTE, 'Note', [
    wbEDID,
    wbVMAD,
    wbOBND,
    wbPTT2,
    wbFULL,
    wbGenericModel,
    wbICON,
    wbYNAM,
    wbZNAM,
    wbInteger(DNAM, 'Type', itU8, wbEnum([
      'Sound',
      'Voice',
      'Program',
      'Terminal'
    ]), cpNormal, True),
    wbStruct(DATA, '', [      // was DNAM before form version 65. Now holds value and weight
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ]),
    wbUnion(SNAM, 'Data', wbNOTEDataDecider, [
      wbByteArray('Unused', 4),
      wbFormIDCk('Sound', [SNDR]),
      wbFormIDCk('Scene', [SCEN]),
      wbFormIDCk('Terminal', [TERM])
    ]),
    wbString(PNAM, 'Program File')
  ]);

  wbRecord(OMOD, 'Object Modification',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000008} 4, 'Legendary Mod',
      {0x00000040} 7, 'Mod Collection'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbFULL,
    wbDESC,
    wbGenericModel,
    wbUnknown(XFLG),
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
    wbArray(MNAM, 'Target OMOD Keywords', wbFormIDCk('Keyword', [KYWD])),
    wbArray(FNAM, 'Filter Keywords', wbFormIDCk('Keyword', [KYWD])),
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
      ], [])
    )
  ]);

  wbRecord(PKIN, 'Pack-In',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
    wbUnknown(PNAM)
  ]);

  {wbRecord(RGDL, 'RGDL', [
    wbEDID
  ]);}

  wbRecord(SCCO, 'Scene Collection', [
    wbEDID,
    wbFormIDCk(QNAM, 'Quest', [QUST]),
    wbRArray('Scenes',
      wbRStruct('Scene', [
        wbFormIDCk(SNAM, 'Scene', [SCEN]),
        wbStruct(XNAM, 'Unknown', [
          wbInteger('Unknown', itS32),
          wbInteger('Unknown', itS32)
        ])
      ], [])
    ),
    wbUnknown(VNAM, cpNormal, True),
    wbRArray('Unknown', wbStruct(XNAM, 'Unknown', [
      wbInteger('Unknown', itS32),
      wbInteger('Unknown', itS32)
    ])),
    wbUnknown(VNAM, cpNormal, True)
  ]);

  var wbStaticPart :=
    wbRStructSK([0], 'Part', [
      wbFormIDCk(ONAM, 'Static', [ACTI, ALCH, AMMO, BOOK, CONT, DOOR, FURN, MISC, MSTT, STAT, TERM, WEAP, FLOR]),
      wbArrayS(DATA, 'Placements', wbStruct('Placement', [
        wbStruct('Position', [
          wbFloat('X'),
          wbFloat('Y'),
          wbFloat('Z')
        ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
        wbStruct('Rotation', [
          wbFloat('X', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
          wbFloat('Y', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize),
          wbFloat('Z', cpNormal, True, wbRotationFactor, wbRotationScale, nil, RadiansNormalize)
        ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
        wbFloat('Scale')
      ]), 0, cpNormal, True)
    ], [], cpNormal, True);

  wbRecord(SCOL, 'Static Collection',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  4, 'Non Occluder',
      {0x00000200}  9, 'Hidden From Local Map',
      {0x00000400} 10, 'Loadscreen',
      {0x00000800} 11, 'Used as Platform',
      {0x00008000} 15, 'Has Distant LOD',
      {0x02000000} 25, 'Obstacle',
      {0x04000000} 26, 'NavMesh Generation - Filter',
      {0x08000000} 27, 'NavMesh Generation - Bounding Box',
      {0x40000000} 30, 'NavMesh Generation - Ground'
    ])), [
    wbEDID,
    wbOBND(True),
    wbPTT2,
    wbGenericModel,
    wbFULL,
    wbFLTR,
    wbRArrayS('Parts', wbStaticPart, cpNormal, True)
  ]);

  wbRecord(SCSN, 'Audio Category Snapshot', [
    wbEDID,
    wbInteger(PNAM, 'Priority', itU16),
    wbRArray('Category Multipliers', wbStruct(CNAM, 'Category Multiplier', [
      wbFormIDCk('Categoty', [SNCT]),
      wbFloat('Multiplier')
    ]))
  ]);

end;

procedure DefineSF1t;
begin
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
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  4, 'Unknown 4',
      {0x00002000} 13, 'Unknown 13',
      {0x00008000} 15, 'Has Distant LOD',
      {0x00010000} 16, 'Random Anim Start'
    ])), [
    wbEDID,
    wbVMADFragmentedPERK, // same fragments format as in PERK
    wbOBND(True),
    wbPTT2,
    wbLStringKC(NAM0, 'Header Text'),
    wbLStringKC(WNAM, 'Welcome Text'),
    wbFULL,
    wbGenericModel,
    wbKSIZ,
    wbKWDAs,
    wbPRPS,
    wbUnknown(PNAM),
    wbFormIDCk(SNAM, 'Looping Sound', [SNDR]),
    wbUnknown(FNAM),
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
        .IncludeFlag(dfCollapsed),
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
        wbCTDAs
      ], [])
        .SetSummaryKey([0, 1])
        .SetSummaryMemberPrefixSuffix(1, '{', '}')
        .SetSummaryDelimiter(' ')
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed),
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
        wbCTDAs
      ], [])
        .SetSummaryKey([3, 2, 0, 7])
        .SetSummaryMemberPrefixSuffix(3, '[', ']')
        .SetSummaryMemberPrefixSuffix(2, '[', ']')
        .SetSummaryMemberPrefixSuffix(7, '{', '}')
        .SetSummaryDelimiter(' ')
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed),
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
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00008000} 16, 'Around Origin'
    ])), [
    wbEDID,
    wbStruct(DATA, 'Data', [
      wbPosRot,
      wbFloat('Scale'),
      wbFloat('Zoom Min'),
      wbFloat('Zoom Max')
    ], cpNormal, True, nil, 2)
  ]);

  wbRecord(ZOOM, 'Zoom', [
    wbEDID,
    (*
    wbStruct(GNAM, 'Data', [
      wbFloat('FOV Mult'),
      wbInteger('Overlay', itU32, wbEnum([
        { 0} 'Default',
        { 1} 'Fine',
        { 2} 'Duplex',
        { 3} 'German',
        { 4} 'Dot',
        { 5} 'Mil-Dot',
        { 6} 'Circle',
        { 7} 'Old Rangefind',
        { 8} 'Modern Rangefind',
        { 9} 'SVD',
        {10} 'Hand Painted',
        {11} 'Binoculars',
        {12} 'Cross',
        {13} 'Double Zero',
        {14} 'Rangefinder 1',
        {15} 'Rangefinder 2',
        {16} 'Rectangle'
      ])),
      wbFormIDCk('Imagespace Modifier', [IMAD, NULL]),
      wbStruct('Camera Offset', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3)
    ])*)
    wbUnknown(ZNAM)
  ]);

end;

procedure DefineSF1u;
begin
  {subrecords checked against Starfield.esm}
  wbRecord(AAPD, 'Aim Assist Pose Data', [
    wbEDID,
    wbRStruct('Attach Point', [
      wbEmpty(AAAP, 'Attach Point Marker'),
      wbString(ANAM, 'Part'),
      wbString(BNAM, 'Part'),
      wbFloat(RADR),
      wbFloat(WTMX)
    ], []),
    wbInteger(AAPS, 'Count', itU64),
    wbRStructS('Connections', 'Connection', [
      wbString(ANAM, 'Part'),
      wbString(BNAM, 'Part'),
      wbFloat(RADR),
      wbFloat(WTMX)
    ], [])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AAMD, 'Aim Assist Model Data', [
    wbEDID,
    wbUnknown(SNAM)
    {
    wbFloat(ANAM, 'Inner Cone Angle Degrees'),
    wbFloat(BNAM, 'Outer Cone Angle Degrees'),
    wbFloat(CNAM, 'Steering Degrees Per Sec'),
    wbFloat(DNAM, 'Pitch Scale'),
    wbFloat(ENAM, 'Inner Steering Ring'),
    wbFloat(FNAM, 'Outer Steering Ring'),
    wbFloat(GNAM, 'Friction'),
    wbFloat(HNAM, 'Move Follow Degrees Per Sec'),
    wbFloat(INAM, 'ADS Snap Steering Mult'),
    wbFloat(JNAM, 'ADS Snap Seconds'),
    wbFloat(KNAM, 'ADS Snap Cone Angle Degrees'),
    wbFloat(LNAM, 'No Steering'),
    wbFloat(MNAM, 'Bullet Bending Cone Angle Degrees'),
    wbFloat(NNAM, 'ADS Snap Steering Mutliplier Inner Ring'),
    wbFloat(ONAM, 'ADS Snap Steering Mutliplier Outer Ring'),
    wbFloat(PNAM, 'ADS Multiplier Inner Cone Angle Degrees'),
    wbFloat(QNAM, 'ADS Multiplier Outer Cone Angle Degrees'),
    wbFloat(RNAM, 'ADS Multiplier Inner Steering Ring'),
    wbFloat(SNAM, 'ADS Multiplier Outer Steering Ring'),
    wbFloat(TNAM, 'ADS Multiplier Friction'),
    wbFloat(UNAM, 'ADS Multiplier Steering Degrees Per Sec'),
    wbFloat(VNAM, 'Aim Assist Enabled')
    }
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SECH, 'Sound Echo Marker', [
    wbEDID,
    wbOBND,
    wbODTY,
    wbXALG, //unknown if before or after NNAM
    wbString(NNAM, 'Description'),
    wbRArray('Echos',
      wbRStruct('Echo', [
        wbRUnion('Echo Marker', [
          wbEmpty(ECHO, 'Echo Start Marker'),
          wbEmpty(ECHD, 'Echo Default Start Marker')
        ], []),
        wbUnknown(ECTE),
        wbUnknown(ECSH),
        wbUnknown(ANAM),
        wbFloat(BNAM),
        wbUnknown(CNAM),
        wbUnknown(DNAM),
        wbUnknown(ENAM),
        wbString(NNAM, 'Description'),
        wbEmpty(ECHE, 'Echo End Marker')
      ], [])
    )
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CURV, 'Curve Table', [
    wbEDID,
    wbUnknown(REFL)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(STND, 'Snap Template Node', [
    wbEDID,
    wbOBND,
    wbBaseFormComponents,
    wbGenericModel,
    wbKeywords,
    wbByteRGBA(CNAM, 'Unknown Colors'),
    wbInteger(FNAM, 'Unknown Flags', itU32, wbFlags([
      {0x00000001} 'Unknown 0',
      {0x00000002} 'Unknown 1',
      {0x00000004} 'Unknown 2',
      {0x00000008} 'Unknown 3',
      {0x00000010} 'Unknown 4',
      {0x00000020} 'Unknown 5',
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
      {0x80000000} 'Unknown 31'
    ])),
    wbInteger(SNST, 'Unknown', itU32),
    wbRArray('Adjacent Snap Nodes', wbFormID(NNAM, 'Adjacent Snap Node')),
    wbRArray('Snap Angles', wbFloat(FLTV, 'Snap Angle'), 3),
    wbFormID(ANAM)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(STMP, 'Snap Template', [
    wbEDID,
    wbBaseFormComponents,
    //wbPTT2,
    wbFormIDCk(PNAM, 'Parent', [STMP]),
    wbRArray('Nodes', wbStruct(ENAM, 'Node', [
      wbInteger('Node ID', itU32),
      wbFormIDCk('Node', [STND]),
      wbArray('Unknown', wbFloat('Unknown'), 4),
      wbFromVersion(187, wbFloat('Unknown')),
      wbFromVersion(187, wbFloat('Unknown')),
      wbFromVersion(187, wbInteger('Unknown', itU32)),
      wbUnknown
   ])),
    wbRArray('Parent Nodes', wbRStruct('Parent Node', [
      wbInteger(ONAM, 'Node ID', itU32),
      wbStruct(TNAM, 'Unknown', [
        wbArray('Unknown', wbFloat('Unknown'), 4),
        wbFromVersion(187, wbFloat('Unknown')),
        wbFromVersion(187, wbFloat('Unknown'))
      ])
    ], [])),
    wbArray(BNAM, 'Unknown', wbFloat('Unknown'), 6),
    //wbArray(GNAM, 'Unknown', wbFloat('Unknown'), 3),
    wbInteger(INAM, 'Next Node ID', itU32),
    wbUnknown(STPT, 4),
    //wbUnknown(SNFG)
    wbString(CNAM),
    wbRStructsSK('Unknown', 'Unknown', [0], [
      wbFormIDCk(RNAM, 'Traversal', [TRAV]),
      wbRArrayS('Unknown', wbInteger(SNAM, 'Node ID', itU32))
    ], [])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(GCVR, 'Ground Cover', [
    wbEDID,
    wbBaseFormComponents,
    wbRArray('Grasses', wbRStruct('Grass', [
      wbFormID(GNAM, 'Grass Texture'),
      wbInteger(DNAM, 'Unknown Int', itU16)
    ], [])),
    wbRArray('Landscape Textures', wbFormID(LNAM, 'Landscape Texture')),
    wbFloat(YNAM)
    //wbFloat(ZNAM, 'Unused Float')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(VOLI, 'Volumetric Lighting', [
    wbEDID,
    wbUnknown(REFL)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PMFT, 'Photo Mode Feature', [
    wbEDID,
//    wbXALG,
//    wbFTAGs,
    wbFULL,
//    wbICON,
//    wbCTDAs,
    wbUnknown(FNAM),
    wbUnknown(HNAM),
    //wbStruct(FNAM, 'Unknown', [
    //  wbInteger('Unknown 1', itU32),
    //  wbFloat('Unknown 2'),
    //  wbFloat('Unknown 3'),
    //  wbByteArray('Unknown 4', 4),
    //  wbByteArray('Unknown 5', 4),
    //  wbByteArray('Unknown 6', 4),
    //  wbByteArray('Unknown 7', 4),
    //  wbByteArray('Unknown 8', 4)
    //]),
    wbFormIDCk(INAM, 'Image Space', [IMAD])
    //wbFormIDCk(KNAM, 'Keyword', [KYWD])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CHAL, 'Challenge', [
    wbEDID,
    wbBaseFormComponents
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CNDF, 'Condition Form', [
    wbEDID,
    wbCTDAs,
    {
    wbRStruct('Unknown', [
      wbUnknown(CIS1),
      wbCTDAs,
      wbUnknown(CIS1)
    ], []),
    wbRStruct('Unknown', [
      wbUnknown(CIS2),
      wbCTDAs,
      wbUnknown(CIS2)
    ], []);
    }
    wbFormIDCk(QNAM, 'Quest', [QUST])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AOPF, 'Audio Occlusion Primitive', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbUnknown(OBSV),
    wbUnknown(OCCV)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PDCL, 'Projected Decal', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbBaseFormComponents,
    wbUnknown(PTT2), // order between PTT2
    wbFormID(SNBH),  // and SNBH is unknown
    wbFormID(DODT),
    wbUnknown(DATA)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CUR3, 'Curve 3D', [
    wbEDID,
    wbUnknown(REFL)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(BMMO, 'Biome Marker', [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbGenericModel,
    wbKeywords,
    wbCTDAs,
    wbFormID(KNAM),
    wbFormID(LNAM),
    wbFormID(LNA2)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(GBFT, 'Generic Base Form Template', [
    wbEDID,
    wbRArray('Unknown', wbString(STRV))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(GBFM, 'Generic Base Form', [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbBaseFormComponents,
    wbFLTR,
    wbFormID(ANAM),
    wbRArray('Unknown', wbString(STRV)),
    wbUnknown(OBTE),
    wbUnknown(OBTF),
    wbUnknown(OBTS),
    wbUnknown(STOP),
    wbUnknown(STOP),
    wbNVNM
  ]);

  {subrecords checked against Starfield.esm}
  var wbLeveledListEntryBaseForm :=
    wbRStructExSK([0], [1], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itU16),
        wbByteArray('Unused', 2, cpIgnore, false, wbNeverShow),
        wbFormIDCk('Generic Base Form', [GBFM, LVLB]),
        wbInteger('Count', itS16),
        wbInteger('Chance None', itU8),
        wbByteArray('Unused', 1, cpIgnore, false, wbNeverShow)
      ])
      .SetSummaryKeyOnValue([0, 3, 2, 4])
      .SetSummaryPrefixSuffixOnValue(0, '[Lv', ']')
      .SetSummaryPrefixSuffixOnValue(3, '', 'x')
      .SetSummaryPrefixSuffixOnValue(4, '{Chance None:', '%}')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlagOnValue(dfSummaryNoSortKey),
      wbCTDAs
    ], [])
    .SetSummaryMemberMaxDepth(0, 1)
    .IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  {subrecords checked against Starfield.esm}
  wbRecord(LVLB, 'Leveled Base Form', [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbLVLD,
    wbInteger(LVLM, 'Max Count', itU8), { Always 00 } {Unavailable}
    wbInteger(LVLF, 'Flags', itU16, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count',
      {0x04} 'Calculate All' {Still picks just one}
    ]), cpNormal, True),
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbCTDAs,
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntryBaseForm, cpNormal, False, nil, wbLVLOsAfterSet),
    wbGenericModel
  ], False, nil, cpNormal, False, wbLLEAfterLoad, wbLLEAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(WTHS, 'Weather Settings', [
    wbEDID,
    wbUnknown(REFL),
    wbFormID(RFDP),
    wbUnknown(RDIF)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(MAAM, 'Melee Aim Assist Model', [
    wbEDID,
    wbUnknown(SNAM)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(IRES, 'Resource', [
    wbEDID,
    wbFULL,
    wbKeywords,
    wbUnknown(CUSH),
    wbFormID(FNAM, 'Item List'),
    wbUnknown(SNAM),
    wbFormID(CNAM, 'Next Rarity'),
    wbUnknown(TINC),
    wbLString(NNAM, 'Short Name'),
    wbString(GNAM, 'Unknown Name'),
    wbFormIDCk(NAM1, 'Actor Value', [AVIF]),
    wbFormIDCk(NAM2, 'Produce', [LVLI, NULL]),
    wbFormIDCK(NAM3, 'Interval', [GLOB])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(BIOM, 'Biome', [
    wbEDID,
    wbFULL,
    wbKeywords,
    wbString(SNAM),
    wbArray(PNAM, 'Plants', wbFormIDCk('Flora', [FLOR])),
    wbFormID(RNAM),
    wbRStructs('Unknown', 'Unknown', [
      wbString(FNAM),
      wbUnknown(BNAM),
      wbRArray('Unknown', wbStruct(GNAM, 'Unknown', [
        wbFormIDCk('Pack-In', [PKIN]),
        wbUnknown
      ])),
      wbUnknown(DNAM)
    ], []),
    wbUnknown(ONAM),
    wbRArray('Unknown', wbFormID(NAM1)),
    wbFormIDCk(ENAM, 'Climate', [CLMT]),
    wbUnknown(MNAM),
    wbFormIDCk(INAM, 'Water', [WATR]),
    wbString(JNAM),
    wbUnknown(WNAM),
    wbUnknown(YNAM),
    wbUnknown(UNAM),
    wbFormIDCk(BIAS, 'Ambient Set', [AMBS]),
    wbFormIDCk(BIMT, 'Music', [MUSC]),
    wbUnknown(NAM0),
    wbFormIDCk(NNAM, 'Pattern Style', [PTST]),
    wbUnknown(CNAM),
    wbUnknown(BMC1),
    wbUnknown(BMC2),
    wbUnknown(BMC3),
    wbUnknown(TNAM),
    wbRStructs('Unknown', 'Unknown', [
      wbFormIDCk(KNAM, 'Keyword', [KYWD]),
      wbKSIZ,
      wbKWDAs
    ], []),
    wbRStructs('Unknown', 'Unknown', [
      wbStruct(LNAM, 'Unknown', [
        wbByteArray('Unknown', 4),
        wbFormIDCk('Land Texture', [LTEX]),
        wbFormIDCk('Ground Cover', [GCVR])
      ]),
      wbStruct(ANAM, 'Unknown', [
        wbByteArray('Unknown', 4),
        wbFormIDCk('Land Texture', [LTEX]),
        wbFormIDCk('Ground Cover', [GCVR])
      ]),
      wbString(TX00),
      wbString(UX00),
      wbString(VX00),
      wbString(WX00),
      wbString(XX00),
      wbString(YX00)
    ], []),
    wbString(TX16),
    wbUnknown(BTPS),
    wbUnknown(BDFS),
    wbString(EFSD),
    wbUnknown(NAM2),
    wbUnknown(NAM3),
    wbUnknown(NAM4)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AMBS, 'Ambience Set', [
    wbEDID,
    wbUnknown(ASAS), //count
    wbRArray('Unknown', wbUnknown(ASAE)),
    wbUnknown(ASMB),
    wbUnknown(WED0)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AOPS, 'Aim Optical Sight Marker', [
    wbEDID,
    wbUnknown(ANAM)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ATMO, 'Atmosphere', [
    wbEDID,
    wbUnknown(REFL),
    wbFormID(RFDP),
    wbUnknown(RDIF)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AVMD, 'Actor Value Modulations', [
    wbEDID,
    wbBaseFormComponents,
    wbUnknown(MNAM), //req
    wbString(YNAM),  //req
    wbString(TNAM),  //req
    wbUnknown(ITMC), //req
    wbRStructs('Unknown', 'Unknown', [
      wbString(LNAM), //req
      wbString(VNAM),
      wbUnknown(NNAM)  //req
    ], []),
    wbUnknown(MODT)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(BMOD, 'Bone Modifier', [
    wbEDID,
    wbBaseFormComponents,
    wbUnknown(DATA)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CLDF, 'Clouds', [
    wbEDID,
    wbUnknown(REFL)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(EFSQ, 'Effect Sequence', [
    wbEDID,
    wbUnknown(REFL)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(FOGV, 'Fog Volume', [
    wbEDID,
    wbUnknown(REFL)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(FORC, 'Force Data', [
    wbEDID,
    wbUnknown(REFL)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(LMSW, 'Layered Material Swap', [
    wbEDID,
    wbBaseFormComponents,
    wbUnknown(REFL)
  ]);

  {subrecords checked against Starfield.esm}
  var wbLeveledListEntrySpaceCell :=
    wbRStructExSK([0], [1], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itU16),
        wbByteArray('Unused', 2, cpIgnore, false, wbNeverShow),
        wbFormIDCk('Space Cell', [CELL, LVSC]),
        wbInteger('Count', itS16),
        wbInteger('Chance None', itU8),
        wbByteArray('Unused', 1, cpIgnore, false, wbNeverShow)
      ])
      .SetSummaryKeyOnValue([0, 3, 2, 4])
      .SetSummaryPrefixSuffixOnValue(0, '[Lv', ']')
      .SetSummaryPrefixSuffixOnValue(3, '', 'x')
      .SetSummaryPrefixSuffixOnValue(4, '{Chance None:', '%}')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlagOnValue(dfSummaryNoSortKey)
//      , wbCOED
    ], [])
    .SetSummaryMemberMaxDepth(0, 1)
    .IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  {subrecords checked against Starfield.esm}
  wbRecord(LVSC, 'Leveled Space Cell', [
    wbEDID,
    wbLVLD,
    wbInteger(LVLM, 'Max Count', itU8), { Always 00 } {Unavailable}
    wbInteger(LVLF, 'Flags', itU16, wbFlags([
      {0x01} 'Calculate from all levels <= player''s level',
      {0x02} 'Calculate for each item in count',
      {0x04} 'Calculate All' {Still picks just one}
    ]), cpNormal, True),
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntrySpaceCell, cpNormal, False, nil, wbLVLOsAfterSet)
//    wbFilterKeywordChances,
//    wbGenericModel
  ], False, nil, cpNormal, False, wbLLEAfterLoad, wbLLEAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(MRPH, 'Morphable Object', [
    wbEDID,
    wbUnknown(TMPP),
    wbUnknown(TCMP),
    wbUnknown(MOBC)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(MTPT, 'Material Path', [
    wbEDID,
    wbUnknown(REFL)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(OSWP, 'Biome Swap', [ //OSWP -> EDID  (3)
    wbEDID
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PCBN, 'Planet Content Manager Branch Node', [
    wbEDID,
    wbBaseFormComponents,
    wbUnknown(NAM1), //req
    wbUnknown(NAM2), //req
    wbUnknown(NAM3),
    wbUnknown(NAM4),
    wbUnknown(NAM5), //req
    wbRArray('Unknown', wbFormIDCk(PCCB, 'Unknown', [PCCN])),
    wbCITCReq,
    wbCTDAsCount,
    wbKWDAs
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PCCN, 'Planet Content Manager Content Node', [
    wbEDID,
    wbBaseFormComponents,
    wbFormIDCk(PCCC, 'Worldspace', [WRLD]), //req
    wbUnknown(IOVR),
    wbKWDAs
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PCMT, 'Planet Content Manager Tree', [
    wbEDID,
    wbUnknown(NAM1), //req
    wbUnknown(NAM2), //req
    wbUnknown(NAM5), //req
    wbRArray('Unknown', wbFormIDCk(PCCB, 'Unknown', [PCBN])),
    wbCITCReq,
    wbCTDAsCount
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PNDT, 'Planet Data', [
    wbEDID,
    wbBaseFormComponents,
    wbUnknown(CNAM), //req
    wbRArray('Unknown', wbUnknown(PPBD)),
    wbUnknown(FNAM), //req
    wbUnknown(GNAM), //req
    wbRStructs('Unknown', 'Unknown', [
      wbUnknown(BDST), //req
      wbString(ANAM),  //req
      wbUnknown(CNAM), //req
      wbUnknown(DNAM), //req
      wbUnknown(ENAM),
      wbUnknown(FNAM),
      wbUnknown(GNAM), //req?
      wbUnknown(HNAM),
      wbUnknown(INAM),
      wbUnknown(NNAM)
    ], []),
    wbUnknown(BDED), //req
    wbUnknown(TEMP), //req
    wbUnknown(DENS), //req
    wbUnknown(PHLA), //req
    wbUnknown(RSCS)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PSDC, 'Particle System Define Collision', [ //PSDC -> EDID REFL  (9)
    wbEDID,
    wbUnknown(REFL)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PTST, 'Surface Pattern Style', [ //PTST -> EDID  (46)
    wbEDID
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(RSGD, 'Resource Generation Data', [
    wbEDID,
    wbRStructs('Unknown', 'Unknown', [
      wbFormIDCk(RNAM, 'Resource', [IRES]), //req
      wbUnknown(DNAM)                       //req
    ], [])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(RSPJ, 'Research Project', [
    wbEDID,
    wbFULL,
    wbDESC,
    wbFormIDCk(BNAM,'Workbench Keyword', [KYWD]),
    wbStructs(FVPA, 'Resources', 'Resource', [
      wbFormIDCk('Resource', [IRES, ALCH]),
      wbByteArray('Unknown', 4),
      wbFormID('Unknown')
    ]),
    wbStructs(RQPK, 'Perks', 'Perk', [
      wbFormIDCk('Perk', [PERK]),
      wbByteArray('Unknown', 4),
      wbFormID('Unknown')
    ]),
    wbFormID(CNAM),
    wbUnknown(NNAM),
    wbUnknown(SNAM),
    wbUnknown(TNAM),
    wbFormIDCk(KNAM,'Category Keyword', [KYWD]),
    wbRArray('Required Projects', wbFormIDCk(RNAM, 'Required Project', [RSPJ]))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SDLT, 'Secondary Damage List', [
    wbEDID,
    wbUnknown(ITMC), //count?
    wbRStructs('Secondary Damages', 'Secondary Damage', [
      wbFormIDCk(DAMA, 'Damage Type', [DMGT]),
      wbFormIDCk(ACTV, 'Actor Value', [AVIF])
    ], [])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SFBK, 'Surface Block', [
    wbEDID,
    wbBaseFormComponents,
    wbString(ANAM),
    wbUnknown(DNAM), //req
    wbUnknown(ENAM), //req
    wbUnknown(FNAM),
    wbUnknown(GNAM), //req
    wbUnknown(HNAM), //req
    wbUnknown(INAM), //req
    wbUnknown(JNAM), //req
    wbUnknown(KNAM), //req
    wbUnknown(WHGT), //req
    wbUnknown(NAM0),
    wbString(NAM1),
    wbUnknown(NAM2),
    wbUnknown(NAM3),
    wbUnknown(NAM4),
    wbFormIDCk(NAM5, 'Surface Block', [SFBK, NULL] )
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SFPC, 'Surface Pattern Config', [
    wbEDID,
    wbFormIDCk(ENAM, 'Unknown', [PTST]), //req
    wbRStructs('Unknown', 'Unknown', [
      wbString(BNAM),
      wbUnknown(CNAM)
    ], []),
    wbUnknown(DNAM)  //req
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SFPT, 'Surface Pattern', [
    wbEDID,
    wbBaseFormComponents,
    wbFormID(CNAM),  //req
    wbUnknown(BNAM), //req
    wbUnknown(DNAM)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SFTR, 'Surface Tree', [
    wbEDID,
    wbBaseFormComponents,
    wbUnknown(CNAM), //req
    wbUnknown(DNAM), //req
    wbUnknown(ENAM), //req
    wbUnknown(ENAM), //req
    wbString(NAM1)   //req
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SPCH, 'Speech Challenge', [
    wbEDID,
    wbUnknown(SPWI), //req
    wbUnknown(SPLO), //req
    wbUnknown(SRAN),
    wbUnknown(SGEN),
    wbFormIDCk(SPQU, 'Quest', [QUST], False, cpNormal, True),
    wbKeywords,
    wbArray(SPMA, 'Scenes', wbFormIDCk('Scene', [SCEN])),
    wbUnknown(DIFF) //req
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(STBH, 'Snap Template Behavior', [
    wbEDID,
    wbBaseFormComponents,
    wbRStructs('Unknown', 'Unknown', [
      wbUnknown(ENAM), //req
      wbFormID(PNAM), //req
      wbCITCReq,
      wbCTDAsCount,
      wbFormID(UNAM), //req
      wbFormID(VNAM)  //req
    ], [])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(STDT, 'Galaxy Star Data', [
    wbEDID,
    wbBaseFormComponents,
    wbKeywords,
    wbString(ANAM),
    wbStruct(BNAM, 'Galaxy position', [
      wbFloat('x'),
      wbFloat('y'),
      wbFloat('z')
    ]),
    wbUnknown(ONAM),
    wbInteger(DNAM, 'Star ID', itU32),
    wbByteColors(ENAM, 'Star color'),
    wbFormID(PNAM, 'Sun Preset')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SUNP, 'Galaxy Sun Preset', [
    wbEDID,
    wbUnknown(REFL),
    wbFormID(RFDP),
    wbUnknown(RDIF)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(TMLM, 'Terminal Menu', [
    wbEDID,
    wbVMAD,
    wbFULL,
    wbUnknown(TMVT),
    wbUnknown(DNAM),
    wbUnknown(SNAM),
    wbUnknown(INAM),
    wbUnknown(BSIZ),
    wbRStructs('Unknown', 'Unknown', [
      wbUnknown(BTXT),
      wbCTDAs,
      wbUnknown(CIS1),
      wbUnknown(CIS2),
      wbCTDAs,
      wbUnknown(CIS2),
      wbUnknown(TPLT)
    ], []),
    wbUnknown(ISIZ),
    wbRStructs('Unknown', 'Unknown', [
      wbUnknown(ITXT),
      wbUnknown(ISTX),
      wbUnknown(ISET),
      wbUnknown(ITID),
      wbUnknown(XLOC),
      wbUnknown(TNAM),
      wbUnknown(UNAM),
      wbCTDAs,
      wbUnknown(CIS1),
      wbCTDAs,
      wbUnknown(CIS1),
      wbUnknown(CIS2),
      wbCTDAs,
      wbUnknown(CIS2)
    ], [])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(TODD, 'Time Of Day Data', [
    wbEDID,
    wbBaseFormComponents,
    wbUnknown(REFL)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(TRAV, 'Traversal', [
    wbEDID,
    wbUnknown(DNAM)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(WBAR, 'Weapon Barrel Model', [
    wbEDID,
    wbUnknown(ZNAM)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(WKMF, 'WWise Keyword Mapping', [
    wbEDID,
    wbUnknown(WMTI),
    wbUnknown(WMKA),
    wbRStructs('Unknown', 'Unknown', [
      wbUnknown(WMSI),
      wbUnknown(WMSD)
    ], [])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(WWED, 'WWise Event Data', [
    wbEDID,
    wbUnknown(WSED),
    wbUnknown(CNAM),
    wbUnknown(WTED)
  ]);

  wbAddGroupOrder(GMST);
  wbAddGroupOrder(KYWD);
  wbAddGroupOrder(FFKW);
  wbAddGroupOrder(LCRT);
  wbAddGroupOrder(AACT);
  wbAddGroupOrder(TRNS);
  wbAddGroupOrder(TXST);
  wbAddGroupOrder(GLOB);
  wbAddGroupOrder(DMGT);
  wbAddGroupOrder(CLAS);
  wbAddGroupOrder(FACT);
  wbAddGroupOrder(AFFE);
  wbAddGroupOrder(HDPT);
  wbAddGroupOrder(RACE);
  wbAddGroupOrder(SOUN);
  wbAddGroupOrder(SECH);
  wbAddGroupOrder(ASPC);
  wbAddGroupOrder(AOPF);
  wbAddGroupOrder(MGEF);
  wbAddGroupOrder(LTEX);
  wbAddGroupOrder(PDCL);
  wbAddGroupOrder(ENCH);
  wbAddGroupOrder(SPEL);
  wbAddGroupOrder(ACTI);
  wbAddGroupOrder(CURV);
  wbAddGroupOrder(CUR3);
  wbAddGroupOrder(ARMO);
  wbAddGroupOrder(BOOK);
  wbAddGroupOrder(CONT);
  wbAddGroupOrder(DOOR);
  wbAddGroupOrder(LIGH);
  wbAddGroupOrder(MISC);
  wbAddGroupOrder(STAT);
  wbAddGroupOrder(SCOL);
  wbAddGroupOrder(PKIN);
  wbAddGroupOrder(MSTT);
  wbAddGroupOrder(GRAS);
  wbAddGroupOrder(FLOR);
  wbAddGroupOrder(FURN);
  wbAddGroupOrder(WEAP);
  wbAddGroupOrder(AMMO);
  wbAddGroupOrder(NPC_);
  wbAddGroupOrder(LVLN);
  wbAddGroupOrder(LVLP);
  wbAddGroupOrder(KEYM);
  wbAddGroupOrder(ALCH);
  wbAddGroupOrder(IDLM);
  wbAddGroupOrder(BMMO);
  wbAddGroupOrder(PROJ);
  wbAddGroupOrder(HAZD);
  wbAddGroupOrder(BNDS);
  wbAddGroupOrder(TERM);
  wbAddGroupOrder(LVLI);
  wbAddGroupOrder(GBFT);
  wbAddGroupOrder(GBFM);
  wbAddGroupOrder(LVLB);
  wbAddGroupOrder(WTHR);
  wbAddGroupOrder(WTHS);
  wbAddGroupOrder(CLMT);
  wbAddGroupOrder(SPGD);
  wbAddGroupOrder(REGN);
  wbAddGroupOrder(NAVI);
  wbAddGroupOrder(CELL);
  wbAddGroupOrder(WRLD);
  wbAddGroupOrder(NAVM);
  wbAddGroupOrder(DIAL);
  wbAddGroupOrder(INFO);
  wbAddGroupOrder(QUST);
  wbAddGroupOrder(IDLE);
  wbAddGroupOrder(PACK);
  wbAddGroupOrder(CSTY);
  wbAddGroupOrder(LSCR);
  wbAddGroupOrder(ANIO);
  wbAddGroupOrder(WATR);
  wbAddGroupOrder(EFSH);
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
  wbAddGroupOrder(LCTN);
  wbAddGroupOrder(MESG);
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
  wbAddGroupOrder(EQUP);
  wbAddGroupOrder(SCEN);
  wbAddGroupOrder(OTFT);
  wbAddGroupOrder(ARTO);
  wbAddGroupOrder(MOVT);
  wbAddGroupOrder(COLL);
  wbAddGroupOrder(CLFM);
  wbAddGroupOrder(REVB);
  wbAddGroupOrder(RFGP);
  wbAddGroupOrder(AMDL);
  wbAddGroupOrder(AAMD);
  wbAddGroupOrder(MAAM);
  wbAddGroupOrder(LAYR);
  wbAddGroupOrder(COBJ);
  wbAddGroupOrder(OMOD);
  wbAddGroupOrder(ZOOM);
  wbAddGroupOrder(INNR);
  wbAddGroupOrder(KSSM);
  wbAddGroupOrder(AORU);
  wbAddGroupOrder(STAG);
  wbAddGroupOrder(IRES);
  wbAddGroupOrder(BIOM);
  wbAddGroupOrder(NOCM);
  wbAddGroupOrder(LENS);
  wbAddGroupOrder(OVIS);
  wbAddGroupOrder(STND);
  wbAddGroupOrder(STMP);
  wbAddGroupOrder(GCVR);
  wbAddGroupOrder(MRPH);
  wbAddGroupOrder(TRAV);
  wbAddGroupOrder(RSGD);
  wbAddGroupOrder(OSWP);
  wbAddGroupOrder(ATMO);
  wbAddGroupOrder(LVSC);
  wbAddGroupOrder(SPCH);
  wbAddGroupOrder(AAPD);
  wbAddGroupOrder(VOLI);
  wbAddGroupOrder(SFBK);
  wbAddGroupOrder(SFPC);
  wbAddGroupOrder(SFPT);
  wbAddGroupOrder(SFTR);
  wbAddGroupOrder(PCMT);
  wbAddGroupOrder(BMOD);
  wbAddGroupOrder(STBH);
  wbAddGroupOrder(PNDT);
  wbAddGroupOrder(CNDF);
  wbAddGroupOrder(PCBN);
  wbAddGroupOrder(PCCN);
  wbAddGroupOrder(STDT);
  wbAddGroupOrder(WWED);
  wbAddGroupOrder(RSPJ);
  wbAddGroupOrder(AOPS);
  wbAddGroupOrder(AMBS);
  wbAddGroupOrder(WBAR);
  wbAddGroupOrder(PTST);
  wbAddGroupOrder(LMSW);
  wbAddGroupOrder(FORC);
  wbAddGroupOrder(TMLM);
  wbAddGroupOrder(EFSQ);
  wbAddGroupOrder(SDLT);
  wbAddGroupOrder(MTPT);
  wbAddGroupOrder(CLDF);
  wbAddGroupOrder(FOGV);
  wbAddGroupOrder(WKMF);
  wbAddGroupOrder(LGDI);
  wbAddGroupOrder(PSDC);
  wbAddGroupOrder(SUNP);
  wbAddGroupOrder(PMFT);
  wbAddGroupOrder(TODD);
  wbAddGroupOrder(AVMD);
  wbAddGroupOrder(CHAL);
end;

procedure DefineSF1;
begin
  wbNexusModsUrl := 'https://www.nexusmods.com/starfield/mods/239';

  DefineSF1a;
  DefineSF1b;
  DefineSF1c;
  DefineSF1d;
  DefineSF1e;
  DefineSF1f;
  DefineSF1g;
  DefineSF1h;
  DefineSF1i;
  DefineSF1j;
  DefineSF1k;
  DefineSF1l;
  DefineSF1m;
  DefineSF1n;
  DefineSF1o;
  DefineSF1p;
  DefineSF1q;
  DefineSF1r;
  DefineSF1s;
  DefineSF1t;
  DefineSF1u;
  {
  SetLength(wbOfficialDLC, 7);
  wbOfficialDLC[0] := 'DLCRobot.esm';
  wbOfficialDLC[1] := 'DLCworkshop01.esm';
  wbOfficialDLC[2] := 'DLCCoast.esm';
  wbOfficialDLC[3] := 'DLCworkshop02.esm';
  wbOfficialDLC[4] := 'DLCworkshop03.esm';
  wbOfficialDLC[5] := 'DLCNukaWorld.esm';
  wbOfficialDLC[6] := 'DLCUltraHighResolution.esm';

  if wbGameMode = gmSF1VR then begin
    // new VR esm is loaded after DLCs
    SetLength(wbOfficialDLC, Succ(Length(wbOfficialDLC)));
    wbOfficialDLC[Pred(Length(wbOfficialDLC))] := 'Fallout4_VR.esm';
  end else
    wbCreationClubContentFileName := 'Fallout4.ccc';

  if wbGameMode = gmSF1VR then
    wbHEDRVersion := 0.95
  else begin
    wbHEDRVersion := 1.0;
    wbHEDRNextObjectID := 1;
  end;
}
  wbHEDRVersion := 0.96;
end;

initialization
end.
