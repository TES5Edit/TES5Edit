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

procedure DefineSF1;

implementation

uses
  System.Types,
  System.Classes,
  System.SysUtils,
  System.Math,
  System.StrUtils,
  System.Variants,
  System.Generics.Defaults,
  System.Generics.Collections,
  JsonDataObjects,
  wbHelpers,
  wbDefinitionsCommon,
  wbDefinitionsSignatures;

const
  // signatures of reference records
  sigReferences : TwbSignatures = [
    'NULL', 'PLYR', 'ACHR', 'REFR', 'PGRE', 'PHZD',
    'PMIS', 'PARW', 'PBAR', 'PBEA', 'PCON', 'PFLA'
  ];

  // signatures of referenceable records (placed by references or constructable)
  sigBaseObjects : TwbSignatures = [
    'NULL', 'ACTI', 'ADDN', 'ALCH', 'AMMO', 'ARMO',
    'ARTO', 'ASPC', 'BNDS', 'BOOK', 'CMPO', 'COBJ',
    'CONT', 'DEBR', 'DOOR', 'EXPL', 'FLST', 'FLOR',
    'FURN', 'HAZD', 'IDLM', 'INGR', 'KEYM', 'LIGH',
    'LVLI', 'LVLN', 'LVSP', 'MISC', 'MSTT', 'NOTE',
    'NPC_', 'OMOD', 'PROJ', 'SCOL', 'SCRL', 'SOUN',
    'SPEL', 'STAT', 'TERM', 'TREE', 'TXST',
    'WATR', 'WEAP', 'ENCH', 'SECH', 'LGDI', 'IRES',
    'BMMP', 'PDCL', 'PKIN', 'GBFM', 'AOPF', 'BMMO',
    'LVLP', 'GRAS'
  ];

type
  TwbWwiseGUIDsDicationary = TDictionary<TGUID, TJSONObject>;

function wbOBND(aRequired: Boolean = False): IwbRecordMemberDef;
begin
  Result :=
    wbStruct(OBND, 'Object Bounds', [
      wbVec3('Min', ''),
      wbVec3('Max', '')
    ], cpNormal, aRequired)
    .SetSummaryKeyOnValue([0, 1])
    .SetSummaryDelimiterOnValue(', ')
    .IncludeFlagOnValue(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseObjectBounds);
end;

function wbTexturedModel(aSubRecordName: string; const aSignatures: TwbSignatures; const aTextureSubRecords: array of IwbRecordMemberDef): IwbRecordMemberDef;
var
  Members: array of IwbRecordMemberDef;
begin
  SetLength(Members, Length(aTextureSubRecords) + 1);
  Members[0] := wbString(aSignatures[0], 'Model FileName');
  //Members[1] := wbModelInfo(aSignatures[1]);
  for var i := Low(aTextureSubRecords) to High(aTextureSubRecords) do
    Members[1 + i] := aTextureSubRecords[i];

  Result :=
    wbRStruct(aSubRecordName, Members, [])
    .SetSummaryKey([0])
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfSummaryNoSortKey)
    .IncludeFlag(dfCollapsed, wbCollapseModels)
    .IncludeFlag(dfAllowAnyMember)
    .IncludeFlag(dfStructFirstNotRequired)
end;

function wbDamageTypeArray(aItemName: string): IwbSubRecordDef;
begin
  Result := wbArrayS(DAMA, aItemName+'s', wbStructSK([0], aItemName, [
    wbFormIDCk('Damage Type', [DMGT]),
    wbInteger('Value', itU32),
    wbFromVersion(152, wbFormIDCk('Curve Table', [CURV, NULL]))
  ])
  .SetSummaryKey([1])
  .SetSummaryMemberPrefixSuffix(1, '= ','')
  .IncludeFlag(dfSummaryMembersNoName)
  )
end;

procedure wbBIOMScaleToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  tValue: Float32;
begin
  case aType of
    ctToStr:
      begin
      if aElement.NativeValue <> 0.0 then
        aValue := FloatToStrF(0.01 / aElement.NativeValue, ffFixed, 99, 1);
      end;
    ctFromEditValue:
      begin
        try
          tValue := StrToFloat(aValue);
          if tValue < 0.0 then
            tValue := 0.0
          else if tValue > 10.0 then
            tValue := 10.0;
          aElement.NativeValue := tValue;
          if tValue <> 0.0 then
          begin
            aElement.NativeValue := 0.01 / tValue;
            aValue := FloatToStr(aElement.NativeValue);
          end;
        except
        end;
      end ;
  end;
end;

function wbQuestStageToStr(aStageIndex : Int64;
                     const aElement    : IwbElement;
                           aType       : TwbCallbackType;
                     const aSourceName : string;
                     const aQuest      : IwbMainRecord;
                           aAllowNone  : Boolean)
                                       : string;
begin;
  case aType of
    ctToStr, ctToSummary: begin
      Result := aStageIndex.ToString;
      if aAllowNone and (aStageIndex < 0) then begin
        Result := Result + ' NONE';
        Exit;
      end;
      if aType = ctToStr then
        Result := Result + ' <Warning: Could not resolve ' + aSourceName + '>';
    end;
    ctToEditValue: begin
      Result := aStageIndex.ToString;
      if aAllowNone and (aStageIndex < 0) then
        Exit;
    end;
    ctToSortKey: begin
      Result := IntToHex64(aStageIndex, 8);
      Exit;
    end;
    ctCheck: begin
      if aAllowNone and (aStageIndex < 0) then
        Exit;
      Result := '<Warning: Could not resolve ' + aSourceName + '>';
    end;
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if not Assigned(aQuest) then
    Exit;

  // get winning quest override except for partial forms

  { this is not correct, the quest record that should be used is the passed in one
    (which is the highest override visible to the element) or, if that one is
    a partial form, the next previous override that isn't a partial form from
    amoung the direct or indirect masters of the current file only

  if aQuest.WinningOverride.Flags._Flags and $00004000 = 0 then
    aQuest := aQuest.WinningOverride
  else if aQuest.Flags._Flags and $00004000 <> 0 then
    aQuest := aQuest.MasterOrSelf;
  }

  if aQuest.Signature <> QUST then begin
    case aType of
      ctToStr, ctToSummary: begin
        Result := aStageIndex.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: "'+aQuest.ShortName+'" is not a Quest record>';
      end;
      ctCheck: Result := '<Warning: "'+aQuest.ShortName+'" is not a Quest record>';
    end;
    Exit;
  end;

  var lEditInfos: TStringList := nil;

  case aType of
    ctEditType: begin
      Result := 'ComboBox';
      Exit;
    end;
    ctEditInfo:
      lEditInfos := TStringList.Create;
  end;

  try
    if aAllowNone and Assigned(lEditInfos) then
      lEditInfos.AddObject('-1 NONE', TObject(-1));

    var lStages : IwbContainerElementRef;
    var lStage  : IwbContainerElementRef;

    if Supports(aQuest.ElementByName['Stages'], IwbContainerElementRef, lStages) then begin
      for var lStageElementIdx := 0 to Pred(lStages.ElementCount) do
        if Supports(lStages.Elements[lStageElementIdx], IwbContainerElementRef, lStage) then begin
          var lStageIndexValue := lStage.ElementNativeValues['INDX\Stage Index'];

          if not VarIsOrdinal(lStageIndexValue) then
            Continue;
          var lStageIndex := Integer(lStageIndexValue);

          if Assigned(lEditInfos) or (lStageIndex = aStageIndex) then begin

            var lIndexString := IntToStr(lStageIndex);
            while Length(lIndexString) < 3 do
              lIndexString := '0' + lIndexString;

            var lLogEntry := Trim(lStage.ElementValues['Log Entries\Log Entry\NAM2']);
            if lLogEntry <> '' then
              lIndexString := lIndexString + ' ' + lLogEntry;

            if Assigned(lEditInfos) then
              lEditInfos.AddObject(lIndexString, TObject(lStageIndex))
            else if lStageIndex = aStageIndex then begin
              case aType of
                ctToStr, ctToSummary, ctToEditValue: Result := lIndexString;
                ctCheck: Result := '';
              end;
              Exit;
            end;
          end;
        end;
    end;

    case aType of
      ctToStr, ctToSummary: begin
        Result := aStageIndex.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: Quest Stage not found in "' + aQuest.Name + '">';
      end;
      ctCheck: Result := '<Warning: Quest Stage [' + aStageIndex.ToString + '] not found in "' + aQuest.Name + '">';
      ctEditInfo: begin
        lEditInfos.Sort;
        Result := lEditInfos.CommaText;
      end;
    end;
  finally
    FreeAndNil(lEditInfos);
  end;
end;

function wbIntPrefixedStrToInt(const aString: string; const aElement: IwbElement): Int64;
var
  i    : Integer;
  s    : string;
begin
  i := 1;
  s := Trim(aString);
  while (i <= Length(s)) and (ANSIChar(s[i]) in ['-', '0'..'9']) do
    Inc(i);
  s := Copy(s, 1, Pred(i));

  Result := StrToInt(s);
end;

function wbStringToInt(const aString: string; const aElement: IwbElement): Int64;
begin
  Result := StrToIntDef(aString, 0);
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

  var iStarIndex := -1;
  for var i := 0 to Pred(LegendaryMods.ElementCount) do
  begin
    LegendaryMod := LegendaryMods.Elements[i] as IwbContainerElementRef;
    if LegendaryMod[0].NativeValue = BaseStarSlot then
    begin
      Inc(iStarIndex);
      if ModIndex = iStarIndex then
      begin
        LegendaryIndex := i;
        Break;
      end;
    end
  end;

  if LegendaryIndex = -1 then
    Exit;

  Result := LegendaryMod.Elements[1].LinksTo;
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
  Result := '';
  case aType of
    ctToStr, ctToSummary: if aInt = -1 then begin
        if aType <> ctToSummary then
          Result := 'None';
      end else if aInt = -2 then
        Result := 'Player'
      else if aInt = -3 then
        Result := 'Non-Actor Track'
      else if aInt = -4 then
        Result := 'Play Audio At Player(Voice Note)'
      else if aInt = -5 then
        Result := 'Dialogue For Scene'
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
    ctCheck: if (aInt = -1) or (aInt = -2) or (aInt = -3) or (aInt = -4) or (aInt = -5) then Result := '' else
      Result := '<Warning: Could not resolve alias [' + aInt.ToString + ']>';
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if ((aInt = -1) or (aInt = -2) or (aInt = -3) or (aInt = -4) or (aInt = -5)) and (aType <> ctEditType) and (aType <> ctEditInfo) then
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
          var lHasSignature: IwbHasSignature;
          if Supports(Alias, IwbHasSignature, lHasSignature) and (lHasSignature.Signature = ALCS) then begin
            var lALST := Alias.ElementBySignature[ALST];
            if Assigned(lALST) then
              if not Supports(lALST, IwbContainerElementRef, Alias) then
                Continue;
          end;
          j := Alias.Elements[0].NativeValue;
          if Assigned(EditInfos) or (j = aInt) then begin
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
    end;

    case aType of
      ctToStr, ctToSummary: begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: Quest Alias not found in "' + MainRecord.Name + '">';
      end;
      ctCheck: Result := '<Warning: Quest Alias [' + aInt.ToString + '] not found in "' + MainRecord.Name + '">';
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

{ Alias to string conversion, requires quest reference or quest record specific to record that references alias }
function wbAliasLinksTo(aInt: Int64; const aQuestRef: IwbElement): IwbElement;
var
  MainRecord : IwbMainRecord;
  Aliases    : IwbContainerElementRef;
  Alias      : IwbContainerElementRef;
  i, j       : Integer;
begin
  Result := nil;

  if aInt < 0 then
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

  if MainRecord.Signature <> QUST then
    Exit;

    if Supports(MainRecord.ElementByName['Aliases'], IwbContainerElementRef, Aliases) then
      for i := 0 to Pred(Aliases.ElementCount) do
        if Supports(Aliases.Elements[i], IwbContainerElementRef, Alias) then begin
          var lHasSignature: IwbHasSignature;
          if Supports(Alias, IwbHasSignature, lHasSignature) and (lHasSignature.Signature = ALCS) then begin
            var lALST := Alias.ElementBySignature[ALST];
            if Assigned(lALST) then
              if not Supports(lALST, IwbContainerElementRef, Alias) then
                Continue;
          end;
          j := Alias.Elements[0].NativeValue;
          if j = aInt then
            Exit(Alias);
        end;
(* may cause issue if scripts use LinksTo and expect a valid alias element or nil * )
    if Assigned(Aliases) then
      Exit(Aliases);

    Exit(MainRecord);
(**)
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
  while (i <= Length(s)) and (ANSIChar(s[i]) in ['-', '0'..'9']) do
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

function wbScriptObjectAliasLinksTo(const aElement: IwbElement): IwbElement;
var
  Container  : IwbContainerElementRef;
begin
  Result := nil;

  if not wbResolveAlias then
    Exit;

  if not wbTryGetContainerRefFromUnionOrValue(aElement, Container) then
    Exit;

  var lAlias := aElement.NativeValue;
  if not VarIsOrdinal(lAlias) then
    Exit;

  Result := wbAliasLinksTo(lAlias, Container.ElementByName['FormID']);
end;

function wbQuestAliasExternalAliasLinksTo(const aElement: IwbElement): IwbElement;
var
  Container  : IwbContainer;
begin
  Result := nil;

  if not wbResolveAlias then
    Exit;

  Container := aElement.Container;

  var lAlias := aElement.NativeValue;
  if not VarIsOrdinal(lAlias) then
    Exit;

  Result := wbAliasLinksTo(lAlias, Container.ElementBySignature[ALEQ]);
end;

function wbSameQuestAliasLinksTo(const aElement: IwbElement): IwbElement;
begin
  Result := nil;

  if not wbResolveAlias then
    Exit;

  var lAlias := aElement.NativeValue;
  if not VarIsOrdinal(lAlias) then
    Exit;

  Result := wbAliasLinksTo(lAlias, aElement.ContainingMainRecord);
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

// takes element being processed for toStr/toLink, returns Quest record or nil
function wbParentQuestHelper(const aElement: IwbElement): IwbElement;
var
  Container   : IwbContainer;
  MainRecord  : IwbMainRecord;
  Group       : IwbGroupRecord;
begin
  if not Assigned(aElement) then
    Exit;

  MainRecord := aElement.ContainingMainRecord;

  while MainRecord.Signature <> QUST do begin
    Container := MainRecord.Container;
    if Supports(Container, IwbGroupRecord, Group) then
      MainRecord := Group.ChildrenOf
    else
      Exit;

    if not Assigned(MainRecord) then
      Exit;
  end;

  Result := MainRecord;
end;

function wbSCENQuestAliasToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
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

  Container := aElement.ContainingMainRecord;

  if not Assigned(Container) then
    Exit;

  Result := wbAliasToStr(aInt, wbParentQuestHelper(aElement) , aType);
end;

function wbSCENAliasLinksTo(const aElement: IwbElement): IwbElement;
var
  Container  : IwbContainer;
begin
  Result := nil;

  if not wbResolveAlias then
    Exit;

  Container := aElement.ContainingMainRecord;

  if not Assigned(Container) then
    Exit;

  var lAlias := aElement.NativeValue;
  if not VarIsOrdinal(lAlias) then
    Exit;

  Result := wbAliasLinksTo(lAlias, wbParentQuestHelper(aElement));
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

function wbStarIDToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  lName : string;
  lContainer: IwbContainer;
  lLinksToRec : IwbElement;
  lStarID : int64;
begin
  Result := '';
  case aType of
    ctToStr, ctToSummary: if aInt = -1 then begin
        if aType <> ctToSummary then
          Result := 'Universe';
      end else begin
        Result := aInt.ToString;
        if aType = ctToStr then
          Result := Result + ' <Warning: Could not resolve Star>';
      end;
    ctToEditValue: if aInt = -1 then Result := 'Universe' else
      Result := aInt.ToString;
    ctToSortKey: begin
      Result := IntToHex64(aInt, 8);
      Exit;
    end;
    ctCheck: begin
      if (aInt = -1) or Assigned(aElement.LinksTo) then
        Result := ''
      else
        Result := '<Warning: Could not resolve Star [' + aInt.ToString + ']>';

      Exit;
    End;
    ctEditType: Result := '';
    ctEditInfo: Result := '';
  end;

  if (aInt = -1) and (aType <> ctEditType) and (aType <> ctEditInfo) then
    Exit;

  case aType of
    ctEditType: begin
      Result := '';
      Exit;
    end;
  end;

  lStarID := aElement.NativeValue;

  lLinksToRec := aElement.LinksTo;
  if not Assigned(lLinksToRec) then
    Exit;

  if not wbTryGetContainerFromUnion(lLinksToRec, lContainer) then
    Exit;

  lName := lContainer.ElementValues['ANAM'];

  Result := lStarID.ToString + ' (' + lName + ')';
end;

function wbStrToStarID(const aString: string; const aElement: IwbElement): Int64;
var
  i    : Integer;
  s    : string;
begin
  Result := -1;

  if aString = 'None' then
    Exit;

  if aString = 'Universe' then begin
    Result := -1;
    Exit;
  end;

  i := 1;
  s := Trim(aString);
  while (i <= Length(s)) and (ANSIChar(s[i]) in ['-', '0'..'9']) do
    Inc(i);
  s := Copy(s, 1, Pred(i));

  Result := StrToIntDef(s, -1);
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

function wbTMLMTypeDontShowCallback(const aElement: IwbElement): Boolean;
var
  lContainer: IwbContainerElementRef;
begin
  Result := True;
  if not Supports(aElement, IwbContainerElementRef, lContainer) then
    Exit;
  var lType := lContainer.ElementNativeValues['ISET\Type'];
  case lType of
    0{Display Text}, 1{Submenu}, 5{DataSlate}: Result := False;
  end;
end;

function wbTMLMTypeUnionDeciderCallback(const aContainer: IwbContainerElementRef): Integer;
begin
  var lType := aContainer.ElementNativeValues['...\ISET\Type'];
  case lType of
    0: Result := 0; // Display Text
    1: Result := 1; // Submenu
    5: Result := 2; // DataSlate
    else Result := 3;
  end;
end;

procedure wbTMLMTypeAfterSetCallback(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  lContainer: IwbContainerElementRef;
  lTemplate: TwbTemplateElements;
  lElement: IwbElement;
begin
  if not (VarIsOrdinal(aOldValue) and VarIsOrdinal(aNewValue)) then
    Exit;
  if aOldValue = aNewValue then
    Exit;
  if not Assigned(aElement) or not Supports(aElement.Container, IwbContainerElementRef, lContainer) then
    Exit;
  if not Assigned(lContainer.Container)  then
    Exit;
  var lSettingData := lContainer.Container.ElementBySortOrder[5];
  if Assigned(lSettingData) then
    lSettingData.Remove;

  if (aElement.NativeValue = 0) or (aElement.NativeValue = 1) or (aElement.NativeValue = 5) then
  begin
    lTemplate := lContainer.Container.GetAssignTemplates(5);
    Supports(IInterface(lTemplate[0]), IwbElement, lElement);
    lContainer.Container.Assign(5, lElement, False);
  end;
end;

procedure wbGPOFTypeAfterSetCallback(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  lContainer: IwbContainerElementRef;
  lTemplate: TwbTemplateElements;
  lElement: IwbElement;
begin
  if not (VarIsOrdinal(aOldValue) and VarIsOrdinal(aNewValue)) then
    Exit;
  if aOldValue = aNewValue then
    Exit;
  if not Assigned(aElement) or not Supports(aElement.Container, IwbContainerElementRef, lContainer) then
    Exit;
  var lSettingData := lContainer.ElementBySortOrder[1];
  if Assigned(lSettingData) then
    lSettingData.Remove;

  lTemplate := aElement.Container.GetAssignTemplates(1);
  if Length(lTemplate) > 0 then
  Supports(IInterface(lTemplate[0]), IwbElement, lElement);
  lContainer.Assign(1, lElement, False);
end;

procedure wbGPOGTypeAfterSetCallback(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  lContainer: IwbContainerElementRef;
  lTemplate: TwbTemplateElements;
  lElement: IwbElement;
begin
  if not (VarIsOrdinal(aOldValue) and VarIsOrdinal(aNewValue)) then
    Exit;
  if aOldValue = aNewValue then
    Exit;
  if not Assigned(aElement) or not Supports(aElement.Container, IwbContainerElementRef, lContainer) then
    Exit;
  var lSettingData := lContainer.ElementBySortOrder[1];
  if Assigned(lSettingData) then
    lSettingData.Remove;

  lTemplate := aElement.Container.GetAssignTemplates(1);
  if Length(lTemplate) > 0 then
  Supports(IInterface(lTemplate[0]), IwbElement, lElement);
  lContainer.Assign(1, lElement, False);
end;

procedure wbSCENTimelineTypeAfterSetCallback(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  lContainer: IwbContainerElementRef;
  lTemplate: TwbTemplateElements;
  lElement: IwbElement;
begin
  if not (VarIsOrdinal(aOldValue) and VarIsOrdinal(aNewValue)) then
    Exit;
  if aOldValue = aNewValue then
    Exit;
  if not Assigned(aElement) or not Supports(aElement.Container, IwbContainerElementRef, lContainer) then
    Exit;
  var lSettingData := lContainer.ElementBySortOrder[2];
  if Assigned(lSettingData) then
    lSettingData.Remove;

  lTemplate := aElement.Container.GetAssignTemplates(2);
  if Length(lTemplate) > 0 then
  Supports(IInterface(lTemplate[0]), IwbElement, lElement);
  lContainer.Assign(2, lElement, False);
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
  if lComponentName = 'UniqueOverlayList_Component' then
    Exit(4);
  if lComponentName = 'UniquePatternPlacementInfo_Component' then
    Exit(5);
end;

function wbBFCDAT2Decider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
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

  if lComponentName = 'BlockHeightAdjustment_Component' then
    Exit(1);
  if lComponentName = 'SurfaceTreePatternSwapInfo_Component' then
    Exit(2);
  if lComponentName = 'BGSBlockEditorMetaData_Component' then
    Exit(3);
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

function wbMGEFAssocItemDecider1(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  Archtype      : Variant;
  DataContainer : IwbDataContainer;
  Element       : IwbElement;
const
  OffsetArchtype = 80;

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
    26: Result := 5; // Unknown 26
    34: Result := 8; // Peak Mod
    35: Result := 5; // Cloak
    39: Result := 7; // Enhance Weapon
    40: Result := 4; // Spawn Hazard
    45: Result := 9; // Damage Type
    46: Result := 6; // Immunity
  end;
end;

function wbMGEFAssocItemDecider2(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  Archtype      : Variant;
  DataContainer : IwbDataContainer;
  Element       : IwbElement;
const
  OffsetArchtype = 80;

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
    0,  // value modifier
    4,  // absorb
    5,  // dual value modifier
    32, // accumulate magnitude
    34, // peak value modifier
    48, // boostpack
    50: // capacity value modifier
      Result := 1;
  end;
end;

function wbMGEFAssocItemDecider3(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
  Archtype      : Variant;
  DataContainer : IwbDataContainer;
  Element       : IwbElement;
const
  OffsetArchtype = 80;

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
    5: Result := 1;  // dual value modifier
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

procedure wbMGEFArchtypeAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
var
  Container: IwbContainerElementRef;
begin
  if VarSameValue(aOldValue, aNewValue) then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  // Element indices need to be used below because we're using unions to display an Unused label for unsupported fields

  // always zero the first element because whenever switching types it will always need a different record type reference
  Container.Container.Elements[0].NativeValue := 00;

  // only dual value modifier supports this element
  Container.Container.Elements[17].NativeValue := 00;
  Container.ElementNativeValues['..\Second AV Weight'] := 0.0;

  if not (Integer(aNewValue) in [0, 4, 5, 32, 34, 48, 50]) then
    Container.Container.Elements[14].NativeValue := 00;
end;

function wbVLMSTypeDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container     : IwbContainer;
begin
  Result := 0;

  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;

  case Integer(Container.ElementNativeValues['Type']) of
     1: Result := 0;
     3: Result := 1;
     5: Result := 2;
  end;
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
  if not Assigned(aElement) then
    Exit;

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
    s := 'RGBA(' + IntToStr(aInt and $FF) + ', ' +
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
    {17} ptEncounterZone,      // LCTN
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
    {56} ptDamageType,         // DMGT
    {57} ptResearchProject,    // RSPJ
    {58} ptConditionForm,      // CNDF
    {59} ptPronoun,            //Enum: Pronouns
    {60} ptResource,           //IRES
    {61} ptPlanet,             //?
    {62} ptDamageCauseType,
    {63} ptSpeechChallenge,
    {63} ptForm,
    {64} ptAcousticSpace,
    {65} ptSnapTemplate,
    {66} ptBiomeMask,
    {67} ptPerkCategory,
    {68} ptPerkSkillGroupComparison,
    {69} ptPerkSkillGroup,
    {70} ptReactionType,
    {71} ptLimbCategory,
    {72} ptFactionOpt,         // NULL, FACT
    {73} ptGamePlayOption
  );

  PCTDAFunction = ^TCTDAFunction;
  TCTDAFunction = record
    Index: Integer;
    Name: string;
    ParamType1: TCTDAFunctionParamType;
    ParamType2: TCTDAFunctionParamType;
    ParamType3: TCTDAFunctionParamType;
    Desc: string;
  end;

const
  wbCTDAFunctions : array[0..609] of TCTDAFunction = (
    (Index:   0; Name: 'GetWantBlocking'),                                                                                                                  //   0
    (Index:   1; Name: 'GetDistance'; ParamType1: ptObjectReference),                                                                                       //   1
    (Index:   5; Name: 'GetLocked'),                                                                                                                        //   2
    (Index:   6; Name: 'GetPos'; ParamType1: ptAxis),                                                                                                       //   3
    (Index:   8; Name: 'GetAngle'; ParamType1: ptAxis),                                                                                                     //   4
    (Index:  10; Name: 'GetStartingPos'; ParamType1: ptAxis),                                                                                               //   5
    (Index:  11; Name: 'GetStartingAngle'; ParamType1: ptAxis),                                                                                             //   6
    (Index:  12; Name: 'GetSecondsPassed'),                                                                                                                 //   7
    (Index:  14; Name: 'GetValue'; ParamType1: ptActorValue),                                                                                               //   8
    (Index:  18; Name: 'GetCurrentTime'),                                                                                                                   //   9
    (Index:  24; Name: 'GetScale'),                                                                                                                         //   10
    (Index:  25; Name: 'IsMoving'),                                                                                                                         //   11
    (Index:  26; Name: 'IsTurning'),                                                                                                                        //   12
    (Index:  27; Name: 'GetLineOfSight'; ParamType1: ptObjectReference{; ParamType2: ptInteger}),                                                           //   13
    (Index:  32; Name: 'GetInSameCell'; ParamType1: ptObjectReference),                                                                                     //   14
    (Index:  35; Name: 'GetDisabled'),                                                                                                                      //   15
    (Index:  36; Name: 'MenuPaused'),                                                                                                                       //   16
    (Index:  38; Name: 'GetCameraShipSize'),                                                                                                                //   17
    (Index:  39; Name: 'GetDisease'),                                                                                                                       //   18
    (Index:  41; Name: 'GetClothingValue'),                                                                                                                 //   19
    (Index:  42; Name: 'SameFaction'; ParamType1: ptActor),                                                                                                 //   20
    (Index:  43; Name: 'SameRace'; ParamType1: ptActor),                                                                                                    //   21
    (Index:  44; Name: 'SameSex'; ParamType1: ptActor),                                                                                                     //   22
    (Index:  45; Name: 'GetDetected'; ParamType1: ptActor),                                                                                                 //   23
    (Index:  46; Name: 'GetDead'),                                                                                                                          //   24
    (Index:  47; Name: 'GetItemCount'; ParamType1: ptReferencableObject),                                                                                   //   25
    (Index:  48; Name: 'GetGold'),                                                                                                                          //   26
    (Index:  49; Name: 'GetSleeping'),                                                                                                                      //   27
    (Index:  50; Name: 'GetTalkedToPC'),                                                                                                                    //   28
    (Index:  56; Name: 'GetQuestRunning'; ParamType1: ptQuest),                                                                                             //   29
    (Index:  58; Name: 'GetStage'; ParamType1: ptQuest),                                                                                                    //   30
    (Index:  59; Name: 'GetStageDone'; ParamType1: ptQuest; ParamType2: ptQuestStage),                                                                      //   31
    (Index:  60; Name: 'GetFactionRankDifference'; ParamType1: ptFaction; ParamType2: ptActor),                                                             //   32
    (Index:  61; Name: 'GetAlarmed'),                                                                                                                       //   33
    (Index:  62; Name: 'IsRaining'),                                                                                                                        //   34
    (Index:  63; Name: 'GetAttacked'),                                                                                                                      //   35
    (Index:  64; Name: 'GetIsCreature'),                                                                                                                    //   36
    (Index:  65; Name: 'GetLockLevel'),                                                                                                                     //   37
    (Index:  66; Name: 'GetShouldAttack'; ParamType1: ptActor),                                                                                             //   38
    (Index:  67; Name: 'GetInCell'; ParamType1: ptCell),                                                                                                    //   39
    (Index:  68; Name: 'GetIsClass'; ParamType1: ptClass),                                                                                                  //   40
    (Index:  69; Name: 'GetIsRace'; ParamType1: ptRace),                                                                                                    //   41
    (Index:  70; Name: 'GetIsSex'; ParamType1: ptSex),                                                                                                      //   42
    (Index:  71; Name: 'GetInFaction'; ParamType1: ptFaction),                                                                                              //   43
    (Index:  72; Name: 'GetIsID'; ParamType1: ptReferencableObject),                                                                                        //   44
    (Index:  73; Name: 'GetFactionRank'; ParamType1: ptFaction),                                                                                            //   45
    (Index:  74; Name: 'GetGlobalValue'; ParamType1: ptGlobal),                                                                                             //   46
    (Index:  75; Name: 'IsSnowing'),                                                                                                                        //   47
    (Index:  77; Name: 'GetRandomPercent'),                                                                                                                 //   48
    (Index:  79; Name: 'WouldBeStealing'; ParamType1: ptObjectReference),                                                                                   //   49
    (Index:  80; Name: 'GetLevel'),                                                                                                                         //   50
    (Index:  81; Name: 'IsRotating'),                                                                                                                       //   51
    (Index:  84; Name: 'GetDeadCount'; ParamType1: ptActorBase),                                                                                            //   52
    (Index:  91; Name: 'GetIsAlerted'),                                                                                                                     //   53
    (Index:  98; Name: 'GetPlayerControlsDisabled'; ParamType1: ptInteger; ParamType2: ptInteger; ParamType3: ptInteger),                                   //   54
    (Index:  99; Name: 'GetHeadingAngle'; ParamType1: ptObjectReference),                                                                                   //   55
    (Index: 101; Name: 'IsWeaponMagicOut'),                                                                                                                 //   56
    (Index: 102; Name: 'IsTorchOut'),                                                                                                                       //   57
    (Index: 103; Name: 'IsShieldOut'),                                                                                                                      //   58
    (Index: 106; Name: 'IsFacingUp'),                                                                                                                       //   59
    (Index: 107; Name: 'GetKnockedState'),                                                                                                                  //   60
    (Index: 108; Name: 'GetWeaponAnimType'),                                                                                                                //   61
    (Index: 109; Name: 'IsWeaponSkillType'; ParamType1: ptActorValue),                                                                                      //   62
    (Index: 110; Name: 'GetDistanceFromCelestialBody'; ParamType1: ptPlanet; ParamType2: ptInteger),                                                        //   63
    (Index: 111; Name: 'IsWaiting'),                                                                                                                        //   64
    (Index: 112; Name: 'IsIdlePlaying'),                                                                                                                    //   65
    (Index: 116; Name: 'IsIntimidatedbyPlayer'),                                                                                                            //   66
    (Index: 117; Name: 'IsPlayerInRegion'; ParamType1: ptRegion),                                                                                           //   67
    (Index: 118; Name: 'GetActorAggroRadiusViolated'),                                                                                                      //   68
    (Index: 122; Name: 'GetCrime'; ParamType1: ptActor; ParamType2: ptCrimeType),                                                                           //   69
    (Index: 123; Name: 'IsGreetingPlayer'),                                                                                                                 //   70
    (Index: 125; Name: 'IsGuard'),                                                                                                                          //   71
    (Index: 128; Name: 'GetStaminaPercentage'),                                                                                                             //   72
    (Index: 129; Name: 'HasBeenRead'),                                                                                                                      //   73
    (Index: 130; Name: 'GetDying'),                                                                                                                         //   74
    (Index: 131; Name: 'GetSceneActionPercent'; ParamType1: ptScene; ParamType2: ptInteger),                                                                //   75
    (Index: 132; Name: 'WouldRefuseCommand'; ParamType1: ptObjectReference),                                                                                //   76
    (Index: 133; Name: 'SameFactionAsPC'),                                                                                                                  //   77
    (Index: 134; Name: 'SameRaceAsPC'),                                                                                                                     //   78
    (Index: 135; Name: 'SameSexAsPC'),                                                                                                                      //   79
    (Index: 136; Name: 'GetIsReference'; ParamType1: ptObjectReference),                                                                                    //   80
    (Index: 141; Name: 'IsTalking'),                                                                                                                        //   81
    (Index: 142; Name: 'GetComponentCount'; ParamType1: ptReferencableObject),                                                                              //   82
    (Index: 143; Name: 'GetCurrentAIProcedure'),                                                                                                            //   83
    (Index: 144; Name: 'GetTrespassWarningLevel'),                                                                                                          //   84
    (Index: 145; Name: 'IsTrespassing'),                                                                                                                    //   85
    (Index: 146; Name: 'IsInMyOwnedCell'),                                                                                                                  //   86
    (Index: 147; Name: 'GetWindSpeed'),                                                                                                                     //   87
    (Index: 148; Name: 'GetCurrentWeatherPercent'),                                                                                                         //   88
    (Index: 149; Name: 'GetIsCurrentWeather'; ParamType1: ptWeather),                                                                                       //   89
    (Index: 150; Name: 'IsContinuingPackagePCNear'),                                                                                                        //   90
    (Index: 152; Name: 'GetIsCrimeFaction'; ParamType1: ptFaction),                                                                                         //   91
    (Index: 153; Name: 'CanHaveFlames'),                                                                                                                    //   92
    (Index: 154; Name: 'HasFlames'),                                                                                                                        //   93
    (Index: 157; Name: 'GetOpenState'),                                                                                                                     //   94
    (Index: 159; Name: 'GetSitting'),                                                                                                                       //   95
    (Index: 161; Name: 'GetIsCurrentPackage'; ParamType1: ptPackage),                                                                                       //   96
    (Index: 162; Name: 'IsCurrentFurnitureRef'; ParamType1: ptObjectReference),                                                                             //   97
    (Index: 163; Name: 'IsCurrentFurnitureObj'; ParamType1: ptFurniture),                                                                                   //   98
    (Index: 170; Name: 'GetDayOfWeek'),                                                                                                                     //   99
    (Index: 172; Name: 'GetTalkedToPCParam'; ParamType1: ptActor),                                                                                          //   100
    (Index: 175; Name: 'IsPCSleeping'),                                                                                                                     //   101
    (Index: 176; Name: 'IsPCAMurderer'),                                                                                                                    //   102
    (Index: 180; Name: 'HasSameEditorLocationAsRef'; ParamType1: ptObjectReference; ParamType2: ptKeyword),                                                 //   103
    (Index: 181; Name: 'HasSameEditorLocationAsRefAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),                                                      //   104
    (Index: 182; Name: 'GetEquipped'; ParamType1: ptReferencableObject),                                                                                    //   105
    (Index: 185; Name: 'IsSwimming'),                                                                                                                       //   106
    (Index: 190; Name: 'GetAmountSoldStolen'),                                                                                                              //   107
    (Index: 192; Name: 'GetIgnoreCrime'),                                                                                                                   //   108
    (Index: 193; Name: 'GetPCExpelled'; ParamType1: ptFaction),                                                                                             //   109
    (Index: 195; Name: 'GetPCFactionMurder'; ParamType1: ptFaction),                                                                                        //   110
    (Index: 197; Name: 'GetPCEnemyofFaction'; ParamType1: ptFaction),                                                                                       //   111
    (Index: 199; Name: 'GetPCFactionAttack'; ParamType1: ptFaction),                                                                                        //   112
    (Index: 203; Name: 'GetDestroyed'),                                                                                                                     //   113
    (Index: 214; Name: 'HasMagicEffect'; ParamType1: ptMagicEffect),                                                                                        //   114
    (Index: 215; Name: 'GetDefaultOpen'),                                                                                                                   //   115
    (Index: 223; Name: 'IsSpellTarget'; ParamType1: ptMagicItem),                                                                                           //   116
    (Index: 224; Name: 'GetVATSMode'),                                                                                                                      //   117
    (Index: 225; Name: 'GetPersuasionNumber'),                                                                                                              //   118
    (Index: 226; Name: 'GetVampireFeed'),                                                                                                                   //   119
    (Index: 227; Name: 'GetCannibal'),                                                                                                                      //   120
    (Index: 228; Name: 'GetIsClassDefault'; ParamType1: ptClass),                                                                                           //   121
    (Index: 229; Name: 'GetClassDefaultMatch'),                                                                                                             //   122
    (Index: 230; Name: 'GetInCellParam'; ParamType1: ptCell; ParamType2: ptObjectReference),                                                                //   123
    (Index: 231; Name: 'GetPlayerDialogueInput'),                                                                                                           //   124
    (Index: 235; Name: 'GetVatsTargetHeight'),                                                                                                              //   125
    (Index: 237; Name: 'GetIsGhost'),                                                                                                                       //   126
    (Index: 242; Name: 'GetUnconscious'),                                                                                                                   //   127
    (Index: 244; Name: 'GetRestrained'),                                                                                                                    //   128
    (Index: 246; Name: 'GetIsUsedItem'; ParamType1: ptReferencableObject),                                                                                  //   129
    (Index: 247; Name: 'GetIsUsedItemType'; ParamType1: ptFormType),                                                                                        //   130
    (Index: 248; Name: 'IsScenePlaying'; ParamType1: ptScene),                                                                                              //   131
    (Index: 249; Name: 'IsInDialogueWithPlayer'),                                                                                                           //   132
    (Index: 250; Name: 'GetLocationExplored'; ParamType1: ptLocation),                                                                                      //   133
    (Index: 254; Name: 'GetIsPlayableRace'),                                                                                                                //   134
    (Index: 255; Name: 'GetOffersServicesNow'),                                                                                                             //   135
    (Index: 258; Name: 'HasAssociationType'; ParamType1: ptActor; ParamType2: ptAssociationType),                                                           //   136
    (Index: 259; Name: 'HasFamilyRelationship'; ParamType1: ptActor),                                                                                       //   137
    (Index: 261; Name: 'HasParentRelationship'; ParamType1: ptActor),                                                                                       //   138
    (Index: 262; Name: 'IsWarningAbout'; ParamType1: ptFormList),                                                                                           //   139
    (Index: 263; Name: 'IsWeaponOut'),                                                                                                                      //   140
    (Index: 264; Name: 'HasSpell'; ParamType1: ptMagicItem),                                                                                                //   141
    (Index: 265; Name: 'IsTimePassing'),                                                                                                                    //   142
    (Index: 266; Name: 'IsPleasant'),                                                                                                                       //   143
    (Index: 267; Name: 'IsCloudy'),                                                                                                                         //   144
    (Index: 274; Name: 'IsSmallBump'),                                                                                                                      //   145
    (Index: 276; Name: 'AnimAction_EffectHasKeyword'; ParamType1: ptKeyword),                                                                               //   146
    (Index: 277; Name: 'GetBaseValue'; ParamType1: ptActorValue),                                                                                           //   147
    (Index: 278; Name: 'IsOwner'; ParamType1: ptOwner),                                                                                                     //   148
    (Index: 280; Name: 'IsCellOwner'; ParamType1: ptCell; ParamType2: ptOwner),                                                                             //   149
    (Index: 282; Name: 'IsHorseStolen'),                                                                                                                    //   150
    (Index: 285; Name: 'IsLeftUp'),                                                                                                                         //   151
    (Index: 286; Name: 'IsSneaking'),                                                                                                                       //   152
    (Index: 287; Name: 'IsRunning'),                                                                                                                        //   153
    (Index: 288; Name: 'GetFriendHit'),                                                                                                                     //   154
    (Index: 289; Name: 'IsInCombat'; ParamType1: ptInteger),                                                                                                //   155
    (Index: 300; Name: 'IsInInterior'),                                                                                                                     //   156
    (Index: 304; Name: 'IsWaterObject'),                                                                                                                    //   157
    (Index: 305; Name: 'GetPlayerAction'),                                                                                                                  //   158
    (Index: 306; Name: 'IsActorUsingATorch'),                                                                                                               //   159
    (Index: 309; Name: 'IsXBox'),                                                                                                                           //   160
    (Index: 310; Name: 'GetInWorldspace'; ParamType1: ptWorldSpace),                                                                                        //   161
    (Index: 312; Name: 'GetPCMiscStat'; ParamType1: ptMiscStat),                                                                                            //   162
    (Index: 313; Name: 'GetPairedAnimation'),                                                                                                               //   163
    (Index: 314; Name: 'IsActorAVictim'),                                                                                                                   //   164
    (Index: 315; Name: 'GetTotalPersuasionNumber'),                                                                                                         //   165
    (Index: 318; Name: 'GetIdleDoneOnce'),                                                                                                                  //   166
    (Index: 320; Name: 'GetNoRumors'),                                                                                                                      //   167
    (Index: 323; Name: 'GetCombatState'),                                                                                                                   //   168
    (Index: 325; Name: 'GetWithinPackageLocation'; ParamType1: ptPackdata),                                                                                 //   169
    (Index: 327; Name: 'IsRidingMount'),                                                                                                                    //   170
    (Index: 329; Name: 'IsFleeing'),                                                                                                                        //   171
    (Index: 332; Name: 'IsInDangerousWater'),                                                                                                               //   172
    (Index: 338; Name: 'GetIgnoreFriendlyHits'),                                                                                                            //   173
    (Index: 339; Name: 'IsPlayersLastRiddenMount'),                                                                                                         //   174
    (Index: 353; Name: 'IsActor'),                                                                                                                          //   175
    (Index: 354; Name: 'IsEssential'),                                                                                                                      //   176
    (Index: 358; Name: 'IsPlayerMovingIntoNewSpace'),                                                                                                       //   177
    (Index: 359; Name: 'GetIsCurrentLocation'; ParamType1: ptLocation),                                                                                     //   178
    (Index: 360; Name: 'GetIsCurrentLocationAlias'; ParamType1: ptAlias),                                                                                   //   179
    (Index: 361; Name: 'GetTimeDead'),                                                                                                                      //   180
    (Index: 362; Name: 'HasLinkedRef'; ParamType1: ptKeyword),                                                                                              //   181
    (Index: 365; Name: 'IsChild'),                                                                                                                          //   182
    (Index: 366; Name: 'GetStolenItemValueNoCrime'; ParamType1: ptFaction),                                                                                 //   183
    (Index: 367; Name: 'GetLastPlayerAction'),                                                                                                              //   184
    (Index: 368; Name: 'IsPlayerActionActive'; ParamType1: ptInteger),                                                                                      //   185
    (Index: 370; Name: 'IsTalkingActivatorActor'; ParamType1: ptActor),                                                                                     //   186
    (Index: 372; Name: 'IsInList'; ParamType1: ptFormList),                                                                                                 //   187
    (Index: 373; Name: 'GetStolenItemValue'; ParamType1: ptFaction),                                                                                        //   188
    (Index: 375; Name: 'GetCrimeGoldViolent'; ParamType1: ptFactionOpt),                                                                                    //   189
    (Index: 376; Name: 'GetCrimeGoldNonviolent'; ParamType1: ptFactionOpt),                                                                                 //   190
    (Index: 378; Name: 'IsOwnedBy'; ParamType1: ptActor),                                                                                                   //   191
    (Index: 380; Name: 'GetCommandDistance'),                                                                                                               //   192
    (Index: 381; Name: 'GetCommandLocationDistance'),                                                                                                       //   193
    (Index: 390; Name: 'GetHitLocation'),                                                                                                                   //   194
    (Index: 391; Name: 'IsPC1stPerson'),                                                                                                                    //   195
    (Index: 396; Name: 'GetCauseofDeath'; ParamType1: ptDamageCauseType),                                                                                   //   196
    (Index: 398; Name: 'IsWeaponInList'; ParamType1: ptFormList),                                                                                           //   197
    (Index: 402; Name: 'IsBribedbyPlayer'),                                                                                                                 //   198
    (Index: 403; Name: 'GetRelationshipRank'; ParamType1: ptActor),                                                                                         //   199
    (Index: 406; Name: 'GetStrongestEnemyHasKeyword'; ParamType1: ptKeyword),                                                                               //   200
    (Index: 407; Name: 'GetVATSValue'; ParamType1: ptInteger; ParamType2: ptInteger),                                                                       //   201
    (Index: 408; Name: 'IsKiller'; ParamType1: ptActor),                                                                                                    //   202
    (Index: 409; Name: 'IsPlayerInShipTargetingMode'),                                                                                                      //   203
    (Index: 410; Name: 'GetFactionCombatReaction'; ParamType1: ptFaction; ParamType2: ptFaction),                                                           //   204
    (Index: 411; Name: 'IsShipTargetInShipTargetingMode'),                                                                                                  //   205
    (Index: 414; Name: 'Exists'; ParamType1: ptObjectReference),                                                                                            //   206
    (Index: 415; Name: 'GetGroupMemberCount'),                                                                                                              //   207
    (Index: 416; Name: 'GetGroupTargetCount'),                                                                                                              //   208
    (Index: 426; Name: 'GetIsVoiceType'; ParamType1: ptVoiceType),                                                                                          //   209
    (Index: 427; Name: 'GetPlantedExplosive'),                                                                                                              //   210
    (Index: 429; Name: 'IsScenePackageRunning'),                                                                                                            //   211
    (Index: 430; Name: 'GetHealthPercentage'),                                                                                                              //   212
    (Index: 431; Name: 'GetActiveBoostDuration'),                                                                                                           //   213
    (Index: 432; Name: 'GetIsObjectType'; ParamType1: ptFormType),                                                                                          //   214
    (Index: 434; Name: 'PlayerVisualDetection'),                                                                                                            //   215
    (Index: 435; Name: 'PlayerAudioDetection'),                                                                                                             //   216
    (Index: 437; Name: 'GetIsCreatureType'; ParamType1: ptInteger),                                                                                         //   217
    (Index: 438; Name: 'HasKey'; ParamType1: ptObjectReference),                                                                                            //   218
    (Index: 439; Name: 'IsFurnitureEntryType'; ParamType1: ptFurnitureEntry),                                                                               //   219
    (Index: 444; Name: 'GetInCurrentLocationFormList'; ParamType1: ptFormList),                                                                             //   220
    (Index: 445; Name: 'GetInZone'; ParamType1: ptLocation),                                                                                                //   221
    (Index: 446; Name: 'GetVelocity'; ParamType1: ptAxis),                                                                                                  //   222
    (Index: 447; Name: 'GetGraphVariableFloat'; ParamType1: ptString),                                                                                      //   223
    (Index: 448; Name: 'HasPerk'; ParamType1: ptPerk),                                                                                                      //   224
    (Index: 449; Name: 'GetFactionRelation'; ParamType1: ptActor),                                                                                          //   225
    (Index: 450; Name: 'IsLastIdlePlayed'; ParamType1: ptIdleForm),                                                                                         //   226
    (Index: 453; Name: 'GetPlayerTeammate'),                                                                                                                //   227
    (Index: 454; Name: 'GetPlayerTeammateCount'),                                                                                                           //   228
    (Index: 458; Name: 'GetActorCrimePlayerEnemy'),                                                                                                         //   229
    (Index: 459; Name: 'GetCrimeGold'; ParamType1: ptFactionOpt),                                                                                           //   230
    (Index: 463; Name: 'IsPlayerGrabbedRef'; ParamType1: ptObjectReference),                                                                                //   231
    (Index: 465; Name: 'GetKeywordItemCount'; ParamType1: ptKeyword),                                                                                       //   232
    (Index: 470; Name: 'GetDestructionStage'),                                                                                                              //   233
    (Index: 473; Name: 'GetIsAlignment'; ParamType1: ptAlignment),                                                                                          //   234
    (Index: 476; Name: 'IsProtected'),                                                                                                                      //   235
    (Index: 477; Name: 'GetThreatRatio'; ParamType1: ptActor),                                                                                              //   236
    (Index: 479; Name: 'GetIsUsedItemEquipType'; ParamType1: ptEquipType{ptEquipSlot}),                                                                     //   237
    (Index: 483; Name: 'GetPlayerActivated'),                                                                                                               //   238
    (Index: 485; Name: 'GetFullyEnabledActorsInHigh'),                                                                                                      //   239
    (Index: 487; Name: 'IsCarryable'),                                                                                                                      //   240
    (Index: 488; Name: 'GetConcussed'),                                                                                                                     //   241
    (Index: 490; Name: 'GetBiomeScanPercent'; Desc:'Returns the biome scan percentage of this object type. 0 if it''s not part of this biome.'),            //   242                                                                                                  //   242
    (Index: 491; Name: 'GetMapMarkerVisible'),                                                                                                              //   243
    (Index: 493; Name: 'PlayerKnows'; ParamType1: ptReferencableObject),                                                                                    //   244
    (Index: 494; Name: 'GetPermanentValue'; ParamType1: ptActorValue),                                                                                      //   245
    (Index: 495; Name: 'EPMagic_EffectIsDetrimental'),                                                                                                      //   246
    (Index: 497; Name: 'CanPayCrimeGold'; ParamType1: ptFaction),                                                                                           //   247
    (Index: 499; Name: 'GetDaysInJail'),                                                                                                                    //   248
    (Index: 500; Name: 'EPAlchemyGetMakingPoison'),                                                                                                         //   249
    (Index: 501; Name: 'EPAlchemyEffectHasKeyword'; ParamType1: ptKeyword),                                                                                 //   250
    (Index: 503; Name: 'GetAllowWorldInteractions'),                                                                                                        //   251
    (Index: 507; Name: 'GetPerkRank'; ParamType1: ptPerk),                                                                                                  //   252
    (Index: 508; Name: 'GetLastHitCritical'),                                                                                                               //   253
    (Index: 511; Name: 'LastCrippledCondition'; ParamType1: ptActorValue),                                                                                  //   254
    (Index: 512; Name: 'HasSharedPowerGrid'; ParamType1: ptObjectReference),                                                                                //   255
    (Index: 513; Name: 'IsCombatTarget'; ParamType1: ptActor),                                                                                              //   256
    (Index: 515; Name: 'GetVATSRightAreaFree'; ParamType1: ptObjectReference),                                                                              //   257
    (Index: 516; Name: 'GetVATSLeftAreaFree'; ParamType1: ptObjectReference),                                                                               //   258
    (Index: 517; Name: 'GetVATSBackAreaFree'; ParamType1: ptObjectReference),                                                                               //   259
    (Index: 518; Name: 'GetVATSFrontAreaFree'; ParamType1: ptObjectReference),                                                                              //   260
    (Index: 519; Name: 'GetIsLockBroken'),                                                                                                                  //   261
    (Index: 521; Name: 'IsWindowsPC'),                                                                                                                      //   262
    (Index: 522; Name: 'GetVATSRightTargetVisible'; ParamType1: ptObjectReference),                                                                         //   263
    (Index: 523; Name: 'GetVATSLeftTargetVisible'; ParamType1: ptObjectReference),                                                                          //   264
    (Index: 524; Name: 'GetVATSBackTargetVisible'; ParamType1: ptObjectReference),                                                                          //   265
    (Index: 525; Name: 'GetVATSFrontTargetVisible'; ParamType1: ptObjectReference),                                                                         //   266
    (Index: 528; Name: 'IsInCriticalStage'; ParamType1: ptCriticalStage),                                                                                   //   267
    (Index: 530; Name: 'GetXPForNextLevel'),                                                                                                                //   268
    (Index: 533; Name: 'GetInfamy'; ParamType1: ptFaction),                                                                                                 //   269
    (Index: 534; Name: 'GetInfamyViolent'; ParamType1: ptFaction),                                                                                          //   270
    (Index: 535; Name: 'GetInfamyNonViolent'; ParamType1: ptFaction),                                                                                       //   271
    (Index: 536; Name: 'GetTypeCommandPerforming'),                                                                                                         //   272
    (Index: 543; Name: 'GetQuestCompleted'; ParamType1: ptQuest),                                                                                           //   273
    (Index: 544; Name: 'GetSpeechChallengeSuccessScene'),                                                                                                   //   274
    (Index: 547; Name: 'IsGoreDisabled'),                                                                                                                   //   275
    (Index: 550; Name: 'IsSceneActionComplete'; ParamType1: ptScene; ParamType2: ptInteger),                                                                //   276
    (Index: 554; Name: 'GetActorsInHigh'),                                                                                                                  //   277
    (Index: 555; Name: 'HasLoaded3D'),                                                                                                                      //   278
    (Index: 560; Name: 'HasKeyword'; ParamType1: ptKeyword),                                                                                                //   279
    (Index: 561; Name: 'HasRefType'; ParamType1: ptRefType),                                                                                                //   280
    (Index: 562; Name: 'LocationHasKeyword'; ParamType1: ptKeyword),                                                                                        //   281
    (Index: 563; Name: 'LocationHasRefType'; ParamType1: ptRefType),                                                                                        //   282
    (Index: 565; Name: 'GetIsEditorLocation'; ParamType1: ptLocation),                                                                                      //   283
    (Index: 566; Name: 'GetIsAliasRef'; ParamType1: ptAlias),                                                                                               //   284
    (Index: 567; Name: 'GetIsEditorLocationAlias'; ParamType1: ptAlias),                                                                                    //   285
    (Index: 568; Name: 'IsSprinting'),                                                                                                                      //   286
    (Index: 569; Name: 'IsBlocking'),                                                                                                                       //   287
    (Index: 570; Name: 'HasEquippedSpell'; ParamType1: ptCastingSource),                                                                                    //   288
    (Index: 571; Name: 'GetCurrentCastingType'; ParamType1: ptCastingSource),                                                                               //   289
    (Index: 572; Name: 'GetCurrentDeliveryType'; ParamType1: ptCastingSource),                                                                              //   290
    (Index: 574; Name: 'GetAttackState'),                                                                                                                   //   291
    (Index: 576; Name: 'GetEventData'; ParamType1: ptEvent {and EventMember in the same DWORD}; ParamType2: ptEventData),                                   //   292
    (Index: 577; Name: 'IsCloserToAThanB'; ParamType1: ptObjectReference; ParamType2: ptObjectReference),                                                   //   293
    (Index: 578; Name: 'LevelMinusPCLevel'),                                                                                                                //   294
    (Index: 580; Name: 'IsBleedingOut'),                                                                                                                    //   295
    (Index: 584; Name: 'GetRelativeAngle'; ParamType1: ptObjectReference; ParamType2: ptAxis),                                                              //   296
    (Index: 589; Name: 'GetMovementDirection'),                                                                                                             //   297
    (Index: 590; Name: 'IsInScene'),                                                                                                                        //   298
    (Index: 591; Name: 'GetRefTypeDeadCount'; ParamType1: ptLocation; ParamType2: ptRefType),                                                               //   299
    (Index: 592; Name: 'GetRefTypeAliveCount'; ParamType1: ptLocation; ParamType2: ptRefType),                                                              //   300
    (Index: 594; Name: 'GetIsFlying'),                                                                                                                      //   301
    (Index: 595; Name: 'IsCurrentSpell'; ParamType1: ptMagicItem; ParamType2: ptCastingSource),                                                             //   302
    (Index: 596; Name: 'SpellHasKeyword'; ParamType1: ptCastingSource; ParamType2: ptKeyword),                                                              //   303
    (Index: 597; Name: 'GetEquippedItemType'; ParamType1: ptCastingSource),                                                                                 //   304
    (Index: 598; Name: 'GetLocationAliasExplored'; ParamType1: ptAlias),                                                                                    //   305
    (Index: 600; Name: 'GetLocationAliasRefTypeDeadCount'; ParamType1: ptAlias; ParamType2: ptRefType),                                                     //   306
    (Index: 601; Name: 'GetLocationAliasRefTypeAliveCount'; ParamType1: ptAlias; ParamType2: ptRefType),                                                    //   307
    (Index: 602; Name: 'IsWardState'; ParamType1: ptWardState),                                                                                             //   308
    (Index: 603; Name: 'IsInSameCurrentLocationAsRef'; ParamType1: ptObjectReference; ParamType2: ptKeyword),                                               //   309
    (Index: 604; Name: 'IsInSameCurrentLocationAsAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),                                                       //   310
    (Index: 605; Name: 'LocationAliasIsLocation'; ParamType1: ptAlias; ParamType2: ptLocation),                                                             //   311
    (Index: 606; Name: 'GetKeywordDataForLocation'; ParamType1: ptLocation; ParamType2: ptKeyword),                                                         //   312
    (Index: 608; Name: 'GetKeywordDataForAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),                                                               //   313
    (Index: 610; Name: 'LocationAliasHasKeyword'; ParamType1: ptAlias; ParamType2: ptKeyword),                                                              //   314
    (Index: 611; Name: 'IsNullPackageData'; ParamType1: ptPackdata),                                                                                        //   315
    (Index: 612; Name: 'GetNumericPackageData'; ParamType1: ptPackdata),                                                                                    //   316
    (Index: 613; Name: 'IsPlayerRadioOn'),                                                                                                                  //   317
    (Index: 614; Name: 'GetPlayerRadioFrequency'),                                                                                                          //   318
    (Index: 615; Name: 'GetHighestRelationshipRank'),                                                                                                       //   319
    (Index: 616; Name: 'GetLowestRelationshipRank'),                                                                                                        //   320
    (Index: 617; Name: 'HasAssociationTypeAny'; ParamType1: ptAssociationType),                                                                             //   321
    (Index: 618; Name: 'HasFamilyRelationshipAny'),                                                                                                         //   322
    (Index: 619; Name: 'GetPathingTargetOffset'; ParamType1: ptAxis),                                                                                       //   323
    (Index: 620; Name: 'GetPathingTargetAngleOffset'; ParamType1: ptAxis),                                                                                  //   324
    (Index: 621; Name: 'GetPathingTargetSpeed'),                                                                                                            //   325
    (Index: 622; Name: 'GetPathingTargetSpeedAngle'; ParamType1: ptAxis),                                                                                   //   326
    (Index: 623; Name: 'GetMovementSpeed'),                                                                                                                 //   327
    (Index: 624; Name: 'GetInContainer'; ParamType1: ptObjectReference),                                                                                    //   328
    (Index: 625; Name: 'IsLocationLoaded'; ParamType1: ptLocation),                                                                                         //   329
    (Index: 626; Name: 'IsLocationAliasLoaded'; ParamType1: ptAlias),                                                                                       //   330
    (Index: 627; Name: 'IsDualCasting'),                                                                                                                    //   331
    (Index: 629; Name: 'GetVMQuestVariable'; ParamType1: ptQuest; ParamType2: ptString),                                                                    //   332
    (Index: 630; Name: 'GetCombatAudioDetection'),                                                                                                          //   333
    (Index: 631; Name: 'GetCombatVisualDetection'),                                                                                                         //   334
    (Index: 632; Name: 'IsCasting'),                                                                                                                        //   335
    (Index: 633; Name: 'GetFlyingState'),                                                                                                                   //   336
    (Index: 635; Name: 'IsInFavorState'),                                                                                                                   //   337
    (Index: 636; Name: 'HasTwoHandedWeaponEquipped'),                                                                                                       //   338
    (Index: 637; Name: 'IsFurnitureExitType'; ParamType1: ptFurnitureEntry),                                                                                //   339
    (Index: 638; Name: 'IsInFriendStatewithPlayer'),                                                                                                        //   340
    (Index: 639; Name: 'GetWithinDistance'; ParamType1: ptObjectReference; ParamType2: ptFloat),                                                            //   341
    (Index: 640; Name: 'GetValuePercent'; ParamType1: ptActorValue),                                                                                        //   342
    (Index: 641; Name: 'IsUnique'),                                                                                                                         //   343
    (Index: 642; Name: 'GetLastBumpDirection'),                                                                                                             //   344
    (Index: 644; Name: 'GetInfoChallangeSuccess'),                                                                                                          //   345
    (Index: 645; Name: 'GetIsInjured'),                                                                                                                     //   346
    (Index: 646; Name: 'GetIsCrashLandRequest'),                                                                                                            //   347
    (Index: 647; Name: 'GetIsHastyLandRequest'),                                                                                                            //   348
    (Index: 650; Name: 'IsLinkedTo'; ParamType1: ptObjectReference; ParamType2: ptKeyword),                                                                 //   349
    (Index: 651; Name: 'GetKeywordDataForCurrentLocation'; ParamType1: ptKeyword),                                                                          //   350
    (Index: 652; Name: 'GetInSharedCrimeFaction'; ParamType1: ptObjectReference),                                                                           //   351
    (Index: 654; Name: 'GetBribeSuccess'),                                                                                                                  //   352
    (Index: 655; Name: 'GetIntimidateSuccess'),                                                                                                             //   353
    (Index: 656; Name: 'GetArrestedState'),                                                                                                                 //   354
    (Index: 657; Name: 'GetArrestingActor'),                                                                                                                //   355
    (Index: 659; Name: 'HasVMScript'; ParamType1: ptString),                                                                                                //   356
    (Index: 660; Name: 'GetVMScriptVariable'; ParamType1: ptString; ParamType2: ptString),                                                                  //   357
    (Index: 661; Name: 'GetWorkshopResourceDamage'; ParamType1: ptActorValue),                                                                              //   358
    (Index: 664; Name: 'HasValidRumorTopic'; ParamType1: ptQuest),                                                                                          //   359
    (Index: 672; Name: 'IsAttacking'),                                                                                                                      //   360
    (Index: 673; Name: 'IsPowerAttacking'),                                                                                                                 //   361
    (Index: 674; Name: 'IsLastHostileActor'),                                                                                                               //   362
    (Index: 675; Name: 'GetGraphVariableInt'; ParamType1: ptString),                                                                                        //   363
    (Index: 676; Name: 'GetDockerOrientation'),                                                                                                             //   364
    (Index: 678; Name: 'ShouldAttackKill'; ParamType1: ptActor),                                                                                            //   365
    (Index: 680; Name: 'GetActivationHeight'),                                                                                                              //   366
    (Index: 681; Name: 'SSLPI_ReplacePayloadHasKeyword'; ParamType1: ptKeyword),                                                                            //   367
    (Index: 682; Name: 'WornHasKeyword'; ParamType1: ptKeyword),                                                                                            //   368
    (Index: 683; Name: 'GetPathingCurrentSpeed'),                                                                                                           //   369
    (Index: 684; Name: 'GetPathingCurrentSpeedAngle'; ParamType1: ptAxis),                                                                                  //   370
    (Index: 691; Name: 'GetWorkshopObjectCount'; ParamType1: ptReferencableObject),                                                                         //   371
    (Index: 693; Name: 'EPMagic_SpellHasKeyword'; ParamType1: ptKeyword),                                                                                   //   372
    (Index: 694; Name: 'GetNoBleedoutRecovery'),                                                                                                            //   373
    (Index: 696; Name: 'EPMagic_SpellHasSkill'; ParamType1: ptActorValue),                                                                                  //   374
    (Index: 697; Name: 'IsAttackType'; ParamType1: ptKeyword),                                                                                              //   375
    (Index: 698; Name: 'IsAllowedToFly'),                                                                                                                   //   376
    (Index: 699; Name: 'HasMagicEffectOrSpellKeyword'; ParamType1: ptKeyword),                                                                              //   377
    (Index: 700; Name: 'IsCommandedActor'),                                                                                                                 //   378
    (Index: 701; Name: 'IsStaggered'),                                                                                                                      //   379
    (Index: 702; Name: 'IsRecoiling'),                                                                                                                      //   380
    (Index: 703; Name: 'HasScopeWeaponEquipped'),                                                                                                           //   381
    (Index: 704; Name: 'IsPathing'),                                                                                                                        //   382
    (Index: 705; Name: 'GetShouldHelp'; ParamType1: ptActor),                                                                                               //   383
    (Index: 706; Name: 'HasBoundWeaponEquipped'; ParamType1: ptCastingSource),                                                                              //   384
    (Index: 707; Name: 'GetCombatTargetHasKeyword'; ParamType1: ptKeyword),                                                                                 //   385
    (Index: 709; Name: 'GetCombatGroupMemberCount'),                                                                                                        //   386
    (Index: 710; Name: 'IsIgnoringCombat'),                                                                                                                 //   387
    (Index: 711; Name: 'GetLightLevel'),                                                                                                                    //   388
    (Index: 713; Name: 'SpellHasCastingPerk'; ParamType1: ptPerk),                                                                                          //   389
    (Index: 714; Name: 'IsBeingRidden'),                                                                                                                    //   390
    (Index: 715; Name: 'IsUndead'),                                                                                                                         //   391
    (Index: 716; Name: 'GetRealHoursPassed'),                                                                                                               //   392
    (Index: 718; Name: 'IsUnlockedDoor'),                                                                                                                   //   393
    (Index: 719; Name: 'IsHostileToActor'; ParamType1: ptActor),                                                                                            //   394
    (Index: 720; Name: 'GetTargetHeight'; ParamType1: ptObjectReference),                                                                                   //   395
    (Index: 721; Name: 'IsPoison'),                                                                                                                         //   396
    (Index: 722; Name: 'WornApparelHasKeywordCount'; ParamType1: ptKeyword),                                                                                //   397
    (Index: 723; Name: 'GetItemHealthPercent'),                                                                                                             //   398
    (Index: 724; Name: 'EffectWasDualCast'),                                                                                                                //   399
    (Index: 725; Name: 'GetKnockStateEnum'),                                                                                                                //   400
    (Index: 726; Name: 'DoesNotExist'),                                                                                                                     //   401
    (Index: 728; Name: 'GetSpeechChallengeSuccessGame'),                                                                                                    //   402
    (Index: 729; Name: 'GetActorStance'),                                                                                                                   //   403
    (Index: 730; Name: 'SpeechScenarioHasKeyword'; ParamType1: ptKeyword; Desc:'See if Keyword is in current speech challenge game.'),                      //   404                                                             //   404
    (Index: 734; Name: 'CanProduceForWorkshop'),                                                                                                            //   405
    (Index: 735; Name: 'CanFlyHere'),                                                                                                                       //   406
    (Index: 736; Name: 'EPIsDamageType'; ParamType1: ptDamageType),                                                                                         //   407
    (Index: 737; Name: 'IsCurrentSpeechChallengeObject'; ParamType1: ptSpeechChallenge),                                                                    //   408
    (Index: 738; Name: 'GetActorGunState'),                                                                                                                 //   409
    (Index: 739; Name: 'GetVoiceLineLength'),                                                                                                               //   410
    (Index: 741; Name: 'ObjectTemplateItem_HasKeyword'; ParamType1: ptKeyword),                                                                             //   411
    (Index: 742; Name: 'ObjectTemplateItem_HasUniqueKeyword'; ParamType1: ptKeyword),                                                                       //   412
    (Index: 743; Name: 'ObjectTemplateItem_GetLevel'),                                                                                                      //   413
    (Index: 744; Name: 'MovementIdleMatches'; ParamType1: ptInteger{ptMovementSelectIdleFromState}; ParamType2: ptInteger{ptMovementSelectIdleToState}),    //   414
    (Index: 745; Name: 'GetActionData'),                                                                                                                    //   415
    (Index: 746; Name: 'GetActionDataShort'; ParamType1: ptInteger),                                                                                        //   416
    (Index: 747; Name: 'GetActionDataByte'; ParamType1: ptInteger),                                                                                         //   417
    (Index: 748; Name: 'GetActionDataFlag'; ParamType1: ptInteger),                                                                                         //   418
    (Index: 749; Name: 'ModdedItemHasKeyword'; ParamType1: ptKeyword),                                                                                      //   419
    (Index: 750; Name: 'GetAngryWithPlayer'),                                                                                                               //   420
    (Index: 751; Name: 'IsCameraUnderWater'),                                                                                                               //   421
    (Index: 753; Name: 'IsActorRefOwner'; ParamType1: ptActor),                                                                                             //   422
    (Index: 754; Name: 'HasActorRefOwner'; ParamType1: ptActor),                                                                                            //   423
    (Index: 756; Name: 'GetLoadedAmmoCount'),                                                                                                               //   424
    (Index: 757; Name: 'IsTimeSpanSunrise'),                                                                                                                //   425
    (Index: 758; Name: 'IsTimeSpanMorning'),                                                                                                                //   426
    (Index: 759; Name: 'IsTimeSpanAfternoon'),                                                                                                              //   427
    (Index: 760; Name: 'IsTimeSpanEvening'),                                                                                                                //   428
    (Index: 761; Name: 'IsTimeSpanSunset'),                                                                                                                 //   429
    (Index: 762; Name: 'IsTimeSpanNight'),                                                                                                                  //   430
    (Index: 763; Name: 'IsTimeSpanMidnight'),                                                                                                               //   431
    (Index: 764; Name: 'IsTimeSpanAnyDay'),                                                                                                                 //   432
    (Index: 765; Name: 'IsTimeSpanAnyNight'),                                                                                                               //   433
    (Index: 766; Name: 'CurrentFurnitureHasKeyword'; ParamType1: ptKeyword),                                                                                //   434
    (Index: 767; Name: 'GetWeaponEquipIndex'),                                                                                                              //   435
    (Index: 769; Name: 'IsOverEncumbered'),                                                                                                                 //   436
    (Index: 770; Name: 'IsPackageRequestingBlockedIdles'),                                                                                                  //   437
    (Index: 771; Name: 'GetActionDataInt'),                                                                                                                 //   438
    (Index: 772; Name: 'GetVATSRightMinusLeftAreaFree'; ParamType1: ptObjectReference),                                                                     //   439
    (Index: 773; Name: 'GetInIronSights'; ParamType1: ptObjectReference),                                                                                   //   440
    (Index: 774; Name: 'GetActorStaggerDirection'),                                                                                                         //   441
    (Index: 775; Name: 'GetActorStaggerMagnitude'),                                                                                                         //   442
    (Index: 776; Name: 'WornCoversBipedSlot'; ParamType1: ptInteger),                                                                                       //   443
    (Index: 777; Name: 'GetInventoryValue'),                                                                                                                //   444
    (Index: 778; Name: 'IsPlayerInConversation'),                                                                                                           //   445
    (Index: 779; Name: 'IsInDialogueCamera'),                                                                                                               //   446
    (Index: 780; Name: 'IsMyDialogueTargetPlayer'),                                                                                                         //   447
    (Index: 781; Name: 'IsMyDialogueTargetActor'),                                                                                                          //   448
    (Index: 782; Name: 'GetMyDialogueTargetDistance'),                                                                                                      //   449
    (Index: 783; Name: 'IsSeatOccupied'; ParamType1: ptKeyword),                                                                                            //   450
    (Index: 784; Name: 'IsPlayerRiding'),                                                                                                                   //   451
    (Index: 785; Name: 'IsTryingEventCamera'),                                                                                                              //   452
    (Index: 786; Name: 'UseLeftSideCamera'),                                                                                                                //   453
    (Index: 787; Name: 'GetNoteType'),                                                                                                                      //   454
    (Index: 788; Name: 'LocationHasPlayerOwnedWorkshop'),                                                                                                   //   455
    (Index: 789; Name: 'IsStartingAction'),                                                                                                                 //   456
    (Index: 790; Name: 'IsMidAction'),                                                                                                                      //   457
    (Index: 791; Name: 'IsWeaponChargeAttack'),                                                                                                             //   458
    (Index: 792; Name: 'IsInWorkshopMode'),                                                                                                                 //   459
    (Index: 793; Name: 'IsWeaponChargingHoldAttack'),                                                                                                       //   460
    (Index: 794; Name: 'IsEncounterAbovePlayerLevel'),                                                                                                      //   461
    (Index: 795; Name: 'IsMeleeAttacking'),                                                                                                                 //   462
    (Index: 796; Name: 'GetVATSQueuedTargetsUnique'),                                                                                                       //   463
    (Index: 797; Name: 'GetCurrentLocationExplored'),                                                                                                       //   464
    (Index: 798; Name: 'IsPowered'),                                                                                                                        //   465
    (Index: 799; Name: 'GetTransmitterDistance'),                                                                                                           //   466
    (Index: 800; Name: 'GetCameraPlaybackTime'),                                                                                                            //   467
    (Index: 801; Name: 'IsInWater'),                                                                                                                        //   468
    (Index: 802; Name: 'GetWithinActivateDistance'; ParamType1: ptObjectReference),                                                                         //   469
    (Index: 803; Name: 'IsUnderWater'),                                                                                                                     //   470
    (Index: 804; Name: 'IsInSameSpace'; ParamType1: ptObjectReference),                                                                                     //   471
    (Index: 805; Name: 'LocationAllowsReset'),                                                                                                              //   472
    (Index: 806; Name: 'GetVATSBackRightAreaFree'; ParamType1: ptObjectReference),                                                                          //   473
    (Index: 807; Name: 'GetVATSBackLeftAreaFree'; ParamType1: ptObjectReference),                                                                           //   474
    (Index: 808; Name: 'GetVATSBackRightTargetVisible'; ParamType1: ptObjectReference),                                                                     //   475
    (Index: 809; Name: 'GetVATSBackLeftTargetVisible'; ParamType1: ptObjectReference),                                                                      //   476
    (Index: 810; Name: 'GetVATSTargetLimbVisible'; ParamType1: ptObjectReference),                                                                          //   477
    (Index: 811; Name: 'IsPlayerListening'; ParamType1: ptFloat),                                                                                           //   478
    (Index: 812; Name: 'GetPathingRequestedQuickTurn'),                                                                                                     //   479
    (Index: 813; Name: 'EPIsCalculatingBaseDamage'),                                                                                                        //   480
    (Index: 814; Name: 'GetReanimating'),                                                                                                                   //   481
    (Index: 815; Name: 'GetCombatDialogueDataInt'; Desc: 'Gets the current Combat dialogue data as an int.'),                                                                                                         //   482
    (Index: 816; Name: 'IsDocked'; Desc: 'Check if a spaceship is docked.'),                                                                                                                         //   483
    (Index: 817; Name: 'IsDockedWith'; ParamType1: ptObjectReference; Desc: 'Check if a spaceship is docked with a specific target'),                                                                                      //   484
    (Index: 818; Name: 'GetLastDialogueCameraHasKeyword'; ParamType1: ptKeyword; Desc: '0/1 if last camera exists, -1 if no last camera'),                                                                           //   485
    (Index: 819; Name: 'GetActionDataForm'; ParamType1: ptForm; Desc: 'Gets the current action data as a form and compares it to the parameter.'),                                                                                            //   486
    (Index: 820; Name: 'IsInSpace'),                                                                                                                        //   487
    (Index: 822; Name: 'GetSpaceship'; ParamType1: ptObjectReference; Desc: 'Get the spaceship a ref is in'),                                                                                      //   488
    (Index: 823; Name: 'ShipContainsRef'; ParamType1: ptObjectReference; Desc: 'Does this spaceship contain a ref (player if no ref given)'),                                                                                   //   489
    (Index: 824; Name: 'IsInSpaceship'; Desc: 'Is this ref in a spaceship?'),                                                                                                                    //   490
    (Index: 825; Name: 'ShipHasActorInPilotSeat'; Desc: 'Is there any actor in the pilot seat of this spaceship?'),                                                                                                          //   491
    (Index: 826; Name: 'ActorPackageHasRandomConversationsFlagOn'; Desc: 'Is this ref allowed random conversation '),                                                                                         //   492
    (Index: 827; Name: 'GetActorInShipPilotSeat'; ParamType1: ptObjectReference; Desc: 'Is the ref in this spaceship''s pilot seat?'),                                                                           //   493
    (Index: 828; Name: 'IsSpaceship'; Desc: 'Check if the ref is a spaceship.'),                                                                                                                      //   494
    (Index: 829; Name: 'GetInAcousticSpace'; ParamType1: ptAcousticSpace; Desc: 'Is this reference in the given acoustic space?'),                                                                                  //   495
    (Index: 830; Name: 'CurrentShipLanded'; Desc: 'Check if the ref is on a landed spaceship'),                                                                                                                //   496
    (Index: 831; Name: 'IsDockedAsChild'; Desc: 'Check if a spaceship is docked as a child'),                                                                                                                  //   497
    (Index: 832; Name: 'PlayerHailResponse'; Desc: 'Player hail response.'),                                                                                                               //   498
    (Index: 833; Name: 'IsHerdLeader'; ParamType1: ptActor; Desc: 'Is actor a Leader.'),                                                                                                //   499
    (Index: 834; Name: 'HasHerdLeader'; ParamType1: ptActor; Desc: 'Has a herd Leader.'),                                                                                               //   500
    (Index: 836; Name: 'GetPlayerHomeSpaceShip'; Desc: ' Get Player Home Ship.'),                                                                                                           //   501
    (Index: 837; Name: 'IsTrueForConditionForm'; ParamType1: ptConditionForm; Desc: 'See if the condition is true or false for the subject.'),                                                                                  //   502
    (Index: 838; Name: 'GetNumElementsInRefCollection'; ParamType1: ptAlias; Desc: 'Gets the number of elements in a ref collection'),                                                                          //   503
    (Index: 839; Name: 'GetCurrentWeatherHasKeyword'; ParamType1: ptKeyword; Desc: 'Check to see if the current weather has the provided keyword.';),                                                                               //   504
    (Index: 840; Name: 'IsSnappedTo'; ParamType1: ptObjectReference; ParamType2: ptSnapTemplate; Desc: 'Is the given reference snapped to this other reference?'),                                                       //   505
    (Index: 841; Name: 'HasKeywordOnNode'; ParamType1: ptKeyword; Desc: 'Checks for a specific keyword on the node that is snapped to.'),                                                                                          //   506
    (Index: 842; Name: 'HasKeywordOnStacked'; ParamType1: ptKeyword; Desc: 'Checks for a specific keyword on the object I am stacked atop.'),                                                                                       //   507
    (Index: 843; Name: 'HasVisualDetection'; ParamType1: ptActor; Desc: 'Checks if an actor has visual detection on another actor'),                                                                                          //   508
    (Index: 844; Name: 'HasSoundDetection'; ParamType1: ptActor; Desc: 'Checks if an actor has sound detection on another actor'),                                                                                           //   509
    (Index: 845; Name: 'IsSuppressed'; Desc: 'Checks if the specified actor is suppressed'),                                                                                                                     //   510
    (Index: 846; Name: 'IsSpaceshipEngineDestroyed'; Desc: 'Check if a spaceship''s engine is destroyed.'),                                                                                                       //   511
    (Index: 847; Name: 'IsLanded'; Desc: 'Check if the ref is a landed spaceship'),                                                                                                                         //   512
    (Index: 848; Name: 'IsSpaceshipShieldsDestroyed'; Desc: 'Check if a spaceship''s shields are destroyed.'),                                                                                                      //   513
    (Index: 849; Name: 'IsSpaceshipGravDriveDestroyed'; Desc: 'Check if a spaceship''s grav drive is destroyed.'),                                                                                                    //   514
    (Index: 850; Name: 'GetNumberOfSpaceshipWeaponsDestroyed'; Desc: 'Get the number of destroyed spaceship''s weapons.'),                                                                                             //   515
    (Index: 851; Name: 'GetIsCurrentLocationExact'; ParamType1: ptLocation; Desc: 'Is the ref currently in the given location?'),                                                                                //   516
    (Index: 852; Name: 'GetIsEditorLocationExact'; ParamType1: ptLocation; Desc: 'Is the ref''s editor location in the given location?'),                                                                                 //   517
    (Index: 853; Name: 'IsInThreatBackdown'; Desc: 'Has the actor already done threadbackdown for current radius reaction?'),                                                                                                               //   518
    (Index: 854; Name: 'IsInsidePrimitive'; ParamType1: ptKeyword{ptPrimitive?}; Desc: 'Check if the reference is inside a specified primitive.';),                                                                                       //   519
    (Index: 855; Name: 'GetCameraActorCount'; Desc: 'Returns the number of non-player actors who will talk in the scene'),                                                                                                              //   520
    (Index: 856; Name: 'GetIsCurrentLocationAliasExact'; ParamType1: ptAlias; Desc: 'Is the ref currently in the exact given location of our owner quest?';),                                                                         //   521
    (Index: 857; Name: 'IsJailInSystem'; Desc: 'See if the ref''s crime faction has a jail in the player''s current system.'),                                                                                                                   //   522
    (Index: 858; Name: 'BodyHasKeyword'; ParamType1: ptKeyword; Desc: 'Does the ref object''s current planetary body use the keyword in the parameter data?'),                                                                                            //   523
    (Index: 859; Name: 'BiomeHasKeyword'; ParamType1: ptKeyword; Desc: 'Does the ref object''s current biome use the keyword in the parameter data?'),                                                                                           //   524
    (Index: 860; Name: 'SystemHasKeyword'; ParamType1: ptKeyword; Desc: 'Does the ref object''s current planetary system use the keyword in the parameter data?';),                                                                                          //   525
    (Index: 861; Name: 'GetDistanceFromLocationWithKeyword'; ParamType1: ptKeyword; Desc: 'Get the distance from the ref to any location with a specific keyword.'),                                                                        //   526
    (Index: 862; Name: 'GetPlanetVisited'; Desc: 'Has the ref object''s current planet been visited by the player?'),                                                                                                                 //   527
    (Index: 863; Name: 'IsLocalDay'; Desc: 'Check if the sun is up on the current planet.'),                                                                                                                       //   528
    (Index: 864; Name: 'SpeechChallengePreviousSceneHasKeyword'; ParamType1: ptKeyword; Desc: 'Does the last speech challenge scene have a keyword?'),                                                                    //   529
    (Index: 865; Name: 'GetBiomeMaskValue'; ParamType1: ptBiomeMask; ParamType2: ptBiomeMask; ParamType3: ptBiomeMask; Desc: 'Get the ref object''s biome mask on the terrain at its position.'),                                     //   530
    (Index: 866; Name: 'BodyIsType'; ParamType1: ptKeyword; Desc: 'Check if the planet type for the ref''s planet matches the given keyword.'),                                                                                                //   531
    (Index: 867; Name: 'BodyIsAtmosphereType'; ParamType1: ptKeyword; Desc: 'Check if the planet atmosphere type for the ref''s planet matches the given keyword.'),                                                                                      //   532
    (Index: 868; Name: 'BodyIsTemperatureType'; ParamType1: ptKeyword; Desc: 'Check if the planet temperature type for the ref''s planet matches the given keyword.'),                                                                                     //   533
    (Index: 869; Name: 'GetBodyTemperature'; Desc: 'Get the planet temperature for the ref''s planet.'),                                                                                                               //   534
    (Index: 870; Name: 'GetBodyPressure'; Desc: 'Get the atmosphere pressure for the ref''s planet.'),                                                                                                                  //   535
    (Index: 871; Name: 'GetBodyGravity'; Desc: 'Get the planet gravity for the ref''s planet.'),                                                                                                                   //   536
    (Index: 872; Name: 'GetBodySurveyPercent'; Desc: 'Get the planet survey percent for the ref''s planet.'),                                                                                                             //   537
    (Index: 873; Name: 'IsPlayerLoitering'; Desc: 'Returns whether the player is loitering or not.'),                                                                                                                //   538
    (Index: 874; Name: 'IsResearchComplete'; ParamType1: ptResearchProject; Desc: 'Check if a research project is completed.'),                                                                                //   539
    (Index: 875; Name: 'BodyIsPlanetTraitKnown'; ParamType1: ptKeyword; Desc: 'Does the ref object''s current planetary body has a specific planet trait known by the player?'),                                                                                    //   540
    (Index: 876; Name: 'HasPerkCategory'; ParamType1: ptPerkCategory; Desc: 'Checks if the owner of an activity is a perk of a certain category.'),                                                                                      //   541
    (Index: 877; Name: 'HasPerkSkillGroup'; ParamType1: ptPerkSkillGroupComparison; ParamType2: ptPerkSkillGroup; Desc: 'Checks if the owner of an activity is a perk of a certain skill group.'),                                          //   542
    (Index: 878; Name: 'CountAquiredPerkRanksByType'; ParamType1: ptPerkCategory; ParamType2: ptPerkSkillGroupComparison; ParamType3: ptPerkSkillGroup; Desc: 'Gets the total amount of acquired perk ranks.'),    //   543
    (Index: 879; Name: 'IsScanned'; Desc: 'Check if a object has been scanned.'),                                                                                                                        //   544
    (Index: 880; Name: 'IsScannableKeywordRevealed'; ParamType1: ptKeyword; Desc: 'Check if a scannable object has a piece of information revealed.'),                                                                                //   545
    (Index: 881; Name: 'IsMyVictim'; ParamType1: ptActor; ParamType2: ptInteger; Desc: 'Check if dead actor was killed by this actor or this actor''s ally/friend or this actor''s herd.'),                                                                           //   546
    (Index: 882; Name: 'GetResourceScarcity'; Desc: 'Get produced resource scarcity.'),                                                                                                              //   547
    (Index: 883; Name: 'CheckContrabandStatus'; ParamType1: ptInteger; Desc: 'Retrieve the ship''s contraband status.'),                                                                                     //   548
    (Index: 886; Name: 'IsPlayerSpaceFarTravelling'; Desc: 'Check if the player is performing space far travel'),                                                                                                       //   549
    (Index: 887; Name: 'IsPlayerSpaceFarTravelDeparture'; Desc: 'Check if the player is performing space far travel departure.'),                                                                                                  //   550
    (Index: 888; Name: 'IsPlayerSpaceFarTravelArrival'; Desc: 'Check if the player is performing space far travel arrival.'),                                                                                                    //   551
    (Index: 889; Name: 'BiomeHasWeather'; ParamType1: ptWeather; Desc: 'Check if the referenced object''s biome has a chance for the given weather.'),                                                                                           //   552
    (Index: 891; Name: 'GetSystemSurveyPercent'; Desc: 'Get the total planet survey percent for the ref''s system.'),                                                                                                           //   553
    (Index: 892; Name: 'SystemBodyHasKeyword'; ParamType1: ptKeyword; Desc: 'Does the ref object''s current planetary system use the given keyword?'),                                                                                      //   554
    (Index: 894; Name: 'GetShipGroupThreatRatio'; ParamType1: ptObjectReference; Desc: 'Calculates the threat ratio between the group of pilots defined by the subject''s group vs. the group of pilots defined by the target''s group.'),                                                                           //   555
    (Index: 895; Name: 'IsOnGrazingTerrain'; Desc: 'Is the actor standing on grazing ground?'),                                                                                                               //   556
    (Index: 896; Name: 'GetDistanceGalacticParsec'; ParamType1: ptObjectReference; Desc: 'Get the distance between two references in parsecs.'),                                                                         //   557
    (Index: 897; Name: 'GetDistanceGalacticMegaMeter'; ParamType1: ptObjectReference; Desc: 'Get the distance between two references in mega meters.'),                                                                      //   558
    (Index: 898; Name: 'GetShipToShipGroupThreatRatio'; ParamType1: ptObjectReference; Desc: 'Calculates the threat ratio between the ship (or pilot) of the subject vs. the group of ships allied to the target.'),                                                                     //   559
    (Index: 899; Name: 'GetGroupMembersInRadiusCount'; ParamType1: ptGlobal; Desc: 'Check if an AI has any combat group members within the radius.'),                                                                               //   560
    (Index: 900; Name: 'GetShipPiracyValue'; ParamType1: ptObjectReference; Desc: 'Calculates the piracy value of the subject ref vs the target ref''s group of allied ships.'),                                                                                //   561
    (Index: 901; Name: 'GetDistanceFromCelestialBodyAliasParsecs'; ParamType1: ptAlias; Desc: 'Gets the distance from the given alias in terms of parsecs.'),                                                               //   562
    (Index: 902; Name: 'GetDistanceFromCelestialBodyAliasMegaMeters'; ParamType1: ptAlias),                                                            //   563
    (Index: 904; Name: 'IsInsidePrimitiveTopAndBottom'; ParamType1: ptKeyword{ptPrimitive}; Desc: 'Check if the reference''s top and bottom are in a specified primitive.'),                                                                           //   564
    (Index: 905; Name: 'GetPlayerBountyCrimeFaction'; ParamType1: ptFaction; Desc: 'Check the last crime faction for player bounty.'),                                                                               //   565
    (Index: 906; Name: 'GetIsFloating'; Desc: 'Gets whether or not the actor is floating.'),                                                                                                                    //   566
    (Index: 907; Name: 'LocationOrParentHasKeyword'; ParamType1: ptKeyword; Desc: 'Determine if a location, or any of its parent locations, has a keyword.'),                                                                                //   567
    (Index: 908; Name: 'IsCelestialBodyScanned'; Desc: 'Get whether the celestial body is scanned.'),                                                                                                           //   568
    (Index: 912; Name: 'IsActorReactionInCooldown'; ParamType1: ptReactionType; Desc: 'Get whether an actor''s reaction is in cooldown or not.'),                                                                            //   569
    (Index: 916; Name: 'BiomeSupportsCreature'; ParamType1: ptActorBase; Desc: 'Does the actor parameter resolve to a creature in the planet''s biome''s creature list?'),                                                                                   //   570
    (Index: 919; Name: 'EPMagic_SpellHasMagicEffect'; ParamType1: ptMagicEffect; Desc:'The passed in reference is a temp reference whose referring object is a MagicItem. Does it have the given Magic Effect?';),                                                                         //   571
    (Index: 921; Name: 'IsFacingActor'; ParamType1: ptObjectReference; Desc: 'Is the actor facing the refr?'),                                                                                     //   572
    (Index: 922; Name: 'IsSameVoiceType'; ParamType1: ptObjectReference; Desc: 'Does the reference share a voice type with the specified ref?'),                                                                                   //   573
    (Index: 923; Name: 'GetValueCurrentLocation'; ParamType1: ptActorValue; Desc: 'Get an actor value from the reference''s current location'),                                                                                //   574
    (Index: 924; Name: 'IsBoostPackActive'; Desc: 'Is player''s boost pack active?'),                                                                                                                //   575
    (Index: 925; Name: 'GetTimeSinceLastBoostPackEnded'; Desc: 'Get time since last boost pack ended, in seconds.'),                                                                                                   //   576
    (Index: 926; Name: 'EPGetLastCombatHitCritical'; Desc: 'Was the last combat hit we caused a Critical?'),                                                                                                       //   577
    (Index: 927; Name: 'EPGetLastCombatHitKill'; Desc: 'Was the last combat hit we caused a kill?'),                                                                                                           //   578
    (Index: 928; Name: 'EPGetLastCombatHitGunBash'; Desc: 'Was the last combat hit we caused a gun bash?'),                                                                                                        //   579
    (Index: 929; Name: 'EPIsLastCombatHitLimbInCategory'; ParamType1: ptLimbCategory; Desc: 'Check if the last combat hit limb in limb category'),                                                                      //   580
    (Index: 930; Name: 'IsEditorLocationInsidePrimitive'; ParamType1: ptKeyword{ptPrimitive}; Desc: 'Check if the reference''s editor location is inside a specified primitive'),                                                                         //   581
    (Index: 931; Name: 'GetIsPronoun'; ParamType1: ptPronoun; Desc: 'Does the reference NPC use the given pronoun?'),                                                                                              //   582
    (Index: 932; Name: 'GetDistanceGalacticLightYears'; ParamType1: ptObjectReference; Desc: 'Get the distance between two references in lightyears.'),                                                                     //   583
    (Index: 933; Name: 'GetDistanceFromCelestialBodyAliasLightyears'; ParamType1: ptAlias; Desc: 'Gets the distance from the given alias in terms of lightyears.'),                                                            //   584
    (Index: 934; Name: 'IsOnPlayerHomeSpaceShip'; Desc: 'Is the ref on the player''s home ship?'),                                                                                                          //   585
    (Index: 935; Name: 'EPMagic_EffectHasKeyword'; ParamType1: ptKeyword; Desc:'The passed in reference is a temp reference whose referring object is a Magic Effect. Does the Magic Effect have the given keyword?'),                                                                                  //   586
    (Index: 936; Name: 'EPMagic_SpellIs'; ParamType1: ptMagicItem; Desc: 'The passed in reference is a temp reference whose referring object is a MagicItem. Does it match the given Magic Item?'),                                                                                         //   587
    (Index: 937; Name: 'IsPlayerSteadyingWeapon'; Desc: 'Is the player steadying their weapon?'),                                                                                                          //   588
    (Index: 938; Name: 'ResourceVeinHasKeyword'; ParamType1: ptKeyword; Desc: 'Checks to see if the resource produced by the vein where the ref is has the given keyword.'),                                                                                    //   589
    (Index: 939; Name: 'GetLastCombatHitActorConsecutiveHits'; Desc: 'Get the last combat hit actor consecutive hits.'),                                                                                             //   590
    (Index: 940; Name: 'GetCurrentAndLastWeatherHaveKeyword'; ParamType1: ptKeyword; Desc: 'Check to see if the current and previous weather have the provided keyword.'),                                                                       //   591
    (Index: 941; Name: 'IsPCEquippedWeaponNthAttack'; ParamType1: ptInteger; Desc: 'Is this the Nth attack with the currently equipped weapon'),                                                                               //   592
    (Index: 942; Name: 'GetWaterDepth'; Desc: 'Get the depth of the water at the position.'),                                                                                                                    //   593
    (Index: 943; Name: 'AreHostileActorsNear'; Desc: 'Check if hostile actors are near'),                                                                                                             //   594
    (Index: 944; Name: 'GetPlayerGravityScale'; Desc: 'Get the gravity scale for the player, including modifiers'),                                                                                                            //   595
    (Index: 945; Name: 'IsInSameGroup'; ParamType1: ptActor; Desc: 'Returns true if the actor it is called on is in same herd group.'),                                                                                               //   596
    (Index: 946; Name: 'IsBoostPackHovering'; Desc: 'Is player''s boost pack hovering?'),                                                                                                              //   597
    (Index: 947; Name: 'GetUsedWeightCapacityConditionFunction'; Desc: 'Get the used weight capacity for actors, ships, containers. 1.0f is 100%'),                                                                                           //   598
    (Index: 949; Name: 'BodyHasResource'; ParamType1: ptResource; ParamType2: ptInteger; Desc: 'Does the ref object''s current planetary body have the given resource? Optional integer 1 to include atmospheric resources.'),                                                                   //   599
    (Index: 950; Name: 'GetPCIsReloading'; Desc: 'Returns true if the Player is currently reloading.'),                                                                                                                 //   600
    (Index: 951; Name: 'ActorExposedToSky'; Desc: 'Test if actor is exposed to sky'),                                                                                                                //   601
    (Index: 954; Name: 'GetQuestStarting'; ParamType1: ptQuest; Desc: 'Is the given quest starting?'),                                                                                             //   602
    (Index: 955; Name: 'BodyHasResourceWithKeyword'; ParamType1: ptKeyword; ParamType2: ptInteger; Desc: 'Does the ref object''s current planetary body have a resource with the given keyword? Optional integer 1 to include atmospheric resources.'),                                                         //   603
    (Index: 957; Name: 'GetShipReactorClass'; Desc: 'Gets a value representing the ship reactor class (based on its index in the ShipClassOrder form list)'),                                                                                                              //   604
    (Index: 958; Name: 'ShipReactorHasClassKeyword'; ParamType1: ptKeyword; Desc: 'Check if the reactor of the supplied ship has the provided reactor class keyword (keywords in ShipClassOrder form list)'),                                                                                //   605
    (Index: 960; Name: 'EPIsResistanceActorValue'; ParamType1: ptActorValue; Desc: 'Is a specific resistance actor value passed into this check?'),                                                                                //   606
    (Index: 961; Name: 'GetGamePlayOptionCurrentValue'; ParamType1: ptGamePlayOption; Desc: 'Gets the current value of a Gameplay Option form.'),                                                                                //   607
    (Index: 965; Name: 'IsInVehicle';),
    (Index: 966; Name: 'AreVehiclesUnlocked';)
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
      if ((Container.ElementByName['Run On'].NativeValue = 14) and (Desc.Name = 'GetDistance')) then
          ParamType := ptAlias
      else if not ((Container.ElementByName['Run On'].NativeValue = 5) and (Desc.Name = 'GetIsCurrentPackage')) then
      // except for this func when Run On = Quest Alias, then alias is param3 and package is param1
      // [INFO:00020D3C]
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

procedure wbDOBJObjectsAfterLoad(const aElement: IwbElement);
var
  ObjectsContainer : IwbContainerElementRef;
  i                : Integer;
  ObjectContainer  : IwbContainerElementRef;
begin
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

function wbActorTemplatesUseTemplate13(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 13 and 1) = 0;
end;

function wbActorTemplatesUseTemplate14(const aElement: IwbElement): Boolean;
var
  MainRecord : IwbMainRecord;
begin
  Result := False;
  MainRecord := aElement.ContainingMainRecord;

  if not Assigned(MainRecord) then
    Exit;
  Result := (Cardinal(MainRecord.ElementNativeValues['ACBS\Use Template Actors']) shr 14 and 1) = 0;
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

function wbPubPackCNAMDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container : IwbContainer;
  rANAM: IwbRecord;
  ctype: string;
begin
  Result := 0;

  if not wbTryGetContainerFromUnion(aElement, Container) then
    Exit;
  Container := Container.Container;
  if not Assigned(Container) then
    Exit;

  rANAM := Container.RecordBySignature[ANAM];
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


function wbObjectModPropertiesDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  MainRecord : IwbMainRecord;
  PropName      : string;

begin
  Result := 0;

  if not wbTryGetContainingMainRecord(aElement, MainRecord) then
    Exit;


  PropName :=  MainRecord.Signature;

        if PropName = 'WEAP' then Result := 1 else
        if PropName = 'ARMO' then Result := 2 else
        if PropName = 'NPC_' then Result := 3
        else Result := 0;

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

procedure wbINNRAfterSet(const aElement: IwbElement; const aOldValue, aNewValue: Variant);
begin
  wbCounterAfterSet('VNAM - Count', aElement);
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

function wbResolveSnapTemplateNodeFromReference(const aReference    : IwbMainRecord;
                                                      aNodeID       : Integer;
                                                  out aBaseRecord   : IwbMainRecord;
                                                  out aSnapTemplate : IwbMainRecord;
                                                  out aSnapNode     : IwbMainRecord)
                                                                    : IwbElement; {node element on the snap template}
begin
  Result := nil;
  aBaseRecord := nil;
  aSnapTemplate := nil;
  aSnapNode := nil;

  if not Assigned(aReference) then
    Exit;

  aBaseRecord := aReference.BaseRecord;
  if not Assigned(aBaseRecord) then
    Exit;

  if not Supports(aBaseRecord.ElementLinksTo[SNTP], IwbMainRecord, aSnapTemplate) then
    Exit;

  var lNodes: IwbContainerElementRef;
  if not Supports(aSnapTemplate.ElementByName['Nodes'], IwbContainerElementRef, lNodes) then
    Exit;

  for var lNodeIdx := 0 to Pred(lNodes.ElementCount) do begin
    var lNode: IwbContainerElementRef;
    if not Supports(lNodes.Elements[lNodeIdx], IwbContainerElementRef, lNode) then
      Continue;
    var lNodeID := lNode.ElementNativeValues['Node ID'];
    if VarIsOrdinal(lNodeID) and (lNodeID = aNodeID) then
    begin
      Supports(lNode.ElementLinksTo['Node'], IwbMainRecord, aSnapNode);
      Exit(lNode);
    end;
  end;
end;

function wbLinksToNodeId(const aReferencePath: string = '...'): TwbLinksToCallback;
begin
  Result :=
    function(const aElement: IwbElement): IwbElement
    begin
      Result := nil;

      var lMainRecord: IwbMainRecord;
      if aReferencePath = '...' then begin
        if not wbTryGetContainingMainRecord(aElement, lMainRecord) then
          Exit;
      end else begin
        if not Assigned(aElement) then
          Exit;

        var lContainer: IwbContainerElementRef;
        if not Supports(aElement.Container, IwbContainerElementRef, lContainer) then
          Exit;

        if not Supports(lContainer.ElementLinksTo[aReferencePath], IwbMainRecord, lMainRecord) then
          Exit;
      end;

      var lNodeID := aElement.NativeValue;
        if not VarIsOrdinal(lNodeID) then
          Exit;

      var lBaseRecord: IwbMainRecord;
      var lSnapTemplate: IwbMainRecord;
      var lSnapNode: IwbMainRecord;

      Result := wbResolveSnapTemplateNodeFromReference(lMainRecord, lNodeID, lBaseRecord, lSnapTemplate, lSnapNode);
    end;
end;

{===Wwise GUIDs and SoundReference ============================================}
var
  wbWwiseSoundbankInfo      : TJSONObject;
  wbWwiseGUIDs              : TwbWwiseGUIDsDicationary;
  wbWwiseGuidEditInfo       : TwbStringArray;
{------------------------------------------------------------------------------}
procedure wbWwiseGuidToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
begin
  if not Assigned(wbWwiseGUIDs) then
    Exit;

  case aType of
    ctToStr, ctToSummary, ctToEditValue: begin
      if aValue = '' then
        Exit;

      if aValue = '{00000000-0000-0000-0000-000000000000}' then begin
        aValue := '';
        Exit;
      end;

      var lGUID := StringToGUID(aValue);

      var lObject: TJsonObject;
      if not wbWwiseGUIDs.TryGetValue(lGUID, lObject) then
        Exit;

      var lName := lObject.S['Name'];
      if lName <> '' then
        if aType = ctToSummary then begin
          aValue := lName;
          Exit;
        end else
          aValue := lName + ' ' + aValue;

      var lObjectPath := lObject.S['ObjectPath'];
      if lObjectPath <> '' then begin
        if (aType = ctToEditValue) and (Length(lObjectPath) > 64) then begin
          SetLength(lObjectPath, 61);
          lObjectPath := lObjectPath + '...';
        end;
        aValue := aValue + ' "' + lObjectPath + '"';
      end;
    end;

    ctFromEditValue: begin
      if aValue = '' then
        Exit;

      var lPos := Pos('{', aValue);
      if lPos < 1 then Exit;
      if lPos > 1 then
        Delete(aValue, 1, Pred(lPos));

      lPos := Pos('}', aValue);
      if lPos < 1 then Exit;
      if lPos > 1 then
        Delete(aValue, Succ(lPos), High(Integer));
    end;

    ctEditType:
      aValue := 'ComboBox';
  end;
end;
{------------------------------------------------------------------------------}
function wbWwiseGUID(const aSignature : TwbSignature;
                     const aName      : string = 'Wwise GUID';
                           aPriority  : TwbConflictPriority = cpNormal;
                           aRequired  : Boolean = False;
                           aDontShow  : TwbDontShowCallback = nil;
                           aGetCP     : TwbGetConflictPriority = nil)
                                      : IwbSubRecordDef; overload;
begin
  Result := wbGUID(aSignature, aName, aPriority, aRequired, aDontShow, aGetCP);
  Result.SetToStr(wbWwiseGuidToStr);
  Result.ForValue(procedure(const v: IwbValueDef)
  begin
    v.SetStaticEditInfo(@wbWwiseGuidEditInfo);
  end);
end;
{------------------------------------------------------------------------------}
function wbWwiseGUID(const aName      : string = 'Wwise GUID';
                           aPriority  : TwbConflictPriority = cpNormal;
                           aRequired  : Boolean = False;
                           aDontShow  : TwbDontShowCallback = nil;
                           aGetCP     : TwbGetConflictPriority = nil)
                                      : IwbGuidDef; overload;
begin
  Result := wbGUID(aName, aPriority, aRequired, aDontShow, aGetCP);
  Result.SetToStr(wbWwiseGuidToStr).SetStaticEditInfo(@wbWwiseGuidEditInfo);
end;
{------------------------------------------------------------------------------}
function wbSoundReference(const aName: string = 'Sound'): IwbValueDef; overload;
begin
  Result :=
    wbStruct(aName, [
      wbStruct('Event Set', [
        wbWwiseGuid('Start Event/Form'), // GUID 1
        wbWwiseGuid('Stop'), // GUID 2
        wbFormIDCk('Condition', [NULL, CNDF]).IncludeFlag(dfSummaryExcludeNULL)
      ]).SetSummaryKey([0, 1, 2]),
      wbStruct('Form Only', [
        wbFormIDCk('Start Form', [NULL, WWED]).IncludeFlag(dfSummaryExcludeNULL)
      ]).SetSummaryKey([0])
    ]).SetSummaryKey([0, 1])
      .IncludeFlag(dfCollapsed);
end;
{------------------------------------------------------------------------------}
function wbSoundReference(const aSignature: TwbSignature; const aName: string = 'Sound'): IwbRecordMemberDef; overload;
begin
  Result :=
    wbSubRecord(aSignature, aName, wbSoundReference(''))
//      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed);
end;
{==============================================================================}


const
 csPropertyCount = 'Property Count';
 csIncludeCount  = 'Include Count';

  wbKnownSubRecordSignaturesRFGP : TwbKnownSubRecordSignatures = (
    'EDID',
    'NNAM',
    '____',
    '____',
    'BFCB'
  );

procedure DefineSF1;
begin
  DefineCommon;

  wbRecordFlags := wbInteger('Record Flags', itU32, wbFlags(wbFlagsList([])));

  wbMainRecordHeader := wbRecordHeader(wbRecordFlags);

  wbSizeOfMainRecordStruct := 24;

  wbKnownSubRecordSignatures[ksrBaseFormComponents] := '____';
  wbHEDRVersion := 0.96;
  wbCellSizeFactor := 100;

  var wbIdxSimpleGroup := wbNamedIndex('SimpleGroup', True);
  var wbIdxComplexGroup := wbNamedIndex('ComplexGroup', True);
  var wbIdxModulation := wbNamedIndex('Modulation', True);

  var wbIdxAVMByType : TArray<TwbNamedIndex> := [-1, wbIdxSimpleGroup, wbIdxComplexGroup, wbIdxModulation];

  var wbIdxCollisionLayer := wbNamedIndex('CollisionLayer', True);

  var wbIdxStarID := wbNamedIndex('StarID', True);

  var wbNull := wbByteArray('Unused', -255);
  var wbLLCT := wbInteger(LLCT, 'Count', itU8, nil, cpBenign);
  var wbCITC := wbInteger(CITC, 'Condition Count', itU32, nil, cpBenign).IncludeFlag(dfSkipImplicitEdit);
  var wbCITCReq := wbInteger(CITC, 'Condition Count', itU32, nil, cpBenign, True).IncludeFlag(dfSkipImplicitEdit);
  var wbLVLDReq := wbFloat(LVLD, 'Chance None', cpNormal, True);

  var wbSPCT := wbInteger(SPCT, 'Count', itU32, nil, cpBenign);
  var wbSPLO := wbFormIDCk(SPLO, 'Actor Effect', [SPEL, LVSP]);
  var wbSPLOs := wbRArrayS('Actor Effects', wbSPLO, cpNormal, False, nil, wbSPLOsAfterSet, nil{wbActorTemplateUseActorEffectList});

  var wbCVPA := wbArray(CVPA,'Components',
    wbStruct('Component', [
      wbFormIDCk('Component', sigBaseObjects), // CK allows only IRES
      wbInteger('Count', itU32),
      wbUnused(4) // same struct used that normally carried curve table
    ])
    .SetSummaryKey([1,0])
    .SetSummaryMemberPrefixSuffix(1,'','x ')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed, wbCollapseItems));

  var wbCDIX := wbArray(CDIX, 'Component Display Indices', wbInteger('Display Index', itU8));

  //wbActorValue := wbInteger('Actor Value', itS32, wbActorValueEnum);
  var wbActorValue := function(aName: string = 'Actor Value'): IwbIntegerDef
  begin
    Result := wbFormIDCkNoReach(aName, [AVIF, NULL]);
  end;

  var wbStarSystemLookupCallback := function(): TwbLinksToCallback
  begin
    Result := function(const aElement: IwbElement): IwbElement
    begin
      Result := nil;

      var lStarID := aElement.NativeValue;
      if not VarIsOrdinal(lStarID) then
        Exit;

      var lFile := aElement._File;
      if not Assigned(lFile) then
        Exit;

      Result := lFile.RecordFromIndexByKey[wbIdxStarID, lStarID];
    end;
  end;

  var wbCOED := wbStructExSK(COED, [2], [0, 1], 'Extra Data', [
    {00} wbFormIDCkNoReach('Owner', [NPC_, FACT, NULL]),
    {04} wbUnion('Global Variable / Required Rank', wbCOEDOwnerDecider, [
           wbUnused(4),
           wbFormIDCk('Global Variable', [GLOB, NULL]),
           wbInteger('Required Rank', itS32)
         ]),
    {08} wbFloat('Item Condition')
  ]);

  var wbCNTO :=
    wbRStructExSK([0], [1], 'Item', [
      wbStructExSK(CNTO, [0], [1], 'Item', [
        wbFormIDCk('Item', sigBaseObjects),
        wbInteger('Count', itS32)
      ])
      .SetSummaryKeyOnValue([1, 0])
      .SetSummaryPrefixSuffixOnValue(0, '', '')
      .SetSummaryPrefixSuffixOnValue(1, '', 'x')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryNoSortKey)
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseItems),
      wbCOED
    ], [])
    .IncludeFlag(dfCollapsed, wbCollapseItems);

  var wbCOCT := wbInteger(COCT, 'Count', itU32, nil, cpBenign);
  var wbCNTOs := wbRArrayS('Items', wbCNTO, cpNormal, False, nil, wbCNTOsAfterSet);

  var wbContainerItems := wbRStructSK([1], 'Container Items', [
    wbCOCT,
    wbCNTOs.SetRequired
  ], []);

  var wbFIMD := wbFormIDCk(FIMD, 'Featured Item Message', [MESG]);

  var wbALSH := wbSoundReference(ALSH, 'Looping Sound');
  var wbACSH := wbSoundReference(ACSH, 'Activate Sound');
  var wbCUSH := wbSoundReference(CUSH, 'Crafting Sound');
  var wbPUSH := wbSoundReference(PUSH, 'Pickup Sound');
  var wbPDSH := wbSoundReference(PDSH, 'Putdown Sound');

  var wbLightRoundnessData := function(aSignature: TwbSignature; aRequired: boolean = False): IwbSubRecordWithStructDef
  begin
    Result := wbStruct(aSignature, 'Roundness', [
      { 0} wbFloat('Width'),
      { 4} wbFloat('Height'),
      { 8} wbFloat('Roundness'),
      {12} wbFloat('Falloff'),
      {16} wbInteger('Uses Roundness', itU8, wbBoolEnum),
      {17} wbUnused(3) // padding
    ], cpNormal, aRequired);
  end;

  var wbLightAreaLightData := function(aSignature: TwbSignature; aRequired: boolean = False): IwbSubRecordWithStructDef
  begin
    Result := wbStruct(aSignature, 'Area Light', [
      { 0} wbFloat('Width'),
      { 4} wbFloat('Height'),
      { 8} wbFloat('Radius'),
      {12} wbInteger('Area Light Type', itU8,
             wbEnum([], [
              0, 'None',
              1, 'Rectangle',
              2, 'Sphere',
             51, 'Unknown 51',
            102, 'Unknown 102'
           ])),
      {13} wbInteger('Is Diffuse', itU8, wbBoolEnum),
      {14} wbUnused(2) // padding
    ], cpNormal, aRequired)
  end;


  var wbLightGoboData := function(aSignature: TwbSignature; aRequired: boolean = False): IwbSubRecordWithStructDef
  begin
    Result := wbStruct(aSignature, 'Gobo Animated Properties', [
      { 0} wbFloat('Static Offset U'),
      { 4} wbFloat('Static Offset V'),
      { 8} wbFloat('Rotation Pivot U'),
      {12} wbFloat('Rotation Pivot V'),
      {16} wbFloatAngle('Static Rotation'),
      {20} wbFloatAngle('Animated Rotation Speed'),
      {24} wbFloat('Animated Wave Rotation Speed'),
      {28} wbFloatAngle('Animated Wave Rotation Amount'),
      {32} wbFloat('Static Scale U'),
      {36} wbFloat('Static Scale V'),
      {40} wbFloat('Wave Scaling U Speed'),
      {44} wbFloat('Wave Scaling V Speed'),
      {48} wbFloat('Wave Scaling U Amount'),
      {42} wbFloat('Wave Scaling V Amount'),
      {56} wbFloat('Scroll Speed U'),
      {60} wbFloat('Scroll Speed V'),
      {64} wbFloat('Wave Scroll Speed U'),
      {68} wbFloat('Wave Scroll Speed V'),
      {72} wbFloat('Wave Scroll Amount U'),
      {76} wbFloat('Wave Scroll Amount V'),
      {80} wbFloat('Random Time Offset Range'),
      {84} wbInteger('Is Animated', itU8, wbBoolEnum),
      {85} wbUnused(3)
    ], cpNormal, aRequired);
  end;

  var wbFLGDReq := wbLightGoboData(FLGD, True);
  var wbXLGD := wbLightGoboData(XLGD);
  var wbFLADReq := wbLightAreaLightData(FLAD, True);
  var wbXALD := wbLightAreaLightData(XALD);
  var wbFLRDReq := wbLightRoundnessData(FLRD, True);
  var wbXLRD := wbLightRoundnessData(XLRD);

  {>>> When NAME is user defined these will be incorrect <<<}
  var wbBipedObjectEnum := wbEnum([
    '0 - Hide Hair',
    '1 - Morph Hair',
    '2 - Hide Head',
    '3 - BODY',
    '4 - Hat',
    '5 - Backpack',
    '6 - Gloves',
    '7 - Lower Body (Vis Only)',
    '8 - Sleeves (Vis Only)',
    '9 - Head (Vis Only)',
    '10 - Upper Body 1 (Vis Only)',
    '11 - Upper Body 2 (Vis Only)',
    '12 - Upper Body 3 (Vis Only no 1st person)',
    '13 - Misc 1 (Vis Only)',
    '14 - Misc 2 (Vis Only)',
    '15 - Misc 3 (Vis Only)',
    '16 - Eyes',
    '17 - Beard',
    '18 - Neuroamp',
    '19 - Hide Ear',
    '20 - AddonRig',
    '21 - Unused',
    '22 - Chronomark',
    '23 - Chronomark1',
    '24 - Chronomark2',
    '25 - Chronomark3',
    '26 - Eyepatch',
    '27 - Morph Beard',
    '28 - Unused',
    '29 - Shield',
    '30 - BoostPackFX',
    '31 - Unused',
    '32 - SS Hide Hair',
    '33 - SS Morph Hair',
    '34 - SS Hide Head',
    '35 - SS BODY',
    '36 - SS Helmet',
    '37 - SS Backpack',
    '38 - SS Gloves',
    '39 - SS Lower Body',
    '40 - SS Sleeves',
    '41 - SS Head Vis',
    '42 - SS U Body 1',
    '43 - SS U Body 2',
    '44 - SS U Body 3',
    '45 - SS Misc 1',
    '46 - SS Misc 2',
    '47 - SS Misc 3',
    '48 - SS Eyes',
    '49 - SS Beard',
    '50 - SS Neuroamp',
    '51 - SS Hide Ear',
    '52 - SS Addon Rig',
    '53 - SS Backpack Misc',
    '54 - SS ChronoMark',
    '55 - Unused',
    '56 - Unused',
    '57 - Unused',
    '58 - Unused',
    '59 - SS Morph Beard',
    '60 - Unused',
    '61 - Unused',
    '62 - Unused',
    '63 - FaceLights'
  ], [
    -1, 'None'
  ]);

  var wbBipedObjectFlags := wbFlags([
    {0x000000000000001} '0 - Hide Hair',
    {0x000000000000002} '1 - Morph Hair',
    {0x000000000000004} '2 - Hide Head',
    {0x000000000000008} '3 - BODY',
    {0x000000000000010} '4 - Hat',
    {0x000000000000020} '5 - Backpack',
    {0x000000000000040} '6 - Gloves',
    {0x000000000000080} '7 - Lower Body (Vis Only)',
    {0x000000000000100} '8 - Sleeves (Vis Only)',
    {0x000000000000200} '9 - Head (Vis Only)',
    {0x000000000000400} '10 - Upper Body 1 (Vis Only)',
    {0x000000000000800} '11 - Upper Body 2 (Vis Only)',
    {0x000000000001000} '12 - Upper Body 3 (Vis Only no 1st person)',
    {0x000000000002000} '13 - Misc 1 (Vis Only)',
    {0x000000000004000} '14 - Misc 2 (Vis Only)',
    {0x000000000008000} '15 - Misc 3 (Vis Only)',
    {0x000000000010000} '16 - Eyes',
    {0x000000000020000} '17 - Beard',
    {0x000000000040000} '18 - Neuroamp',
    {0x000000000080000} '19 - Hide Ear',
    {0x000000000100000} '20 - AddonRig',
    {0x000000000200000} '21 - Unused',
    {0x000000000400000} '22 - Chronomark',
    {0x000000000800000} '23 - Chronomark1',
    {0x000000001000000} '24 - Chronomark2',
    {0x000000002000000} '25 - Chronomark3',
    {0x000000004000000} '26 - Eyepatch',
    {0x000000008000000} '27 - Morph Beard',
    {0x000000010000000} '28 - Unused',
    {0x000000020000000} '29 - Shield',
    {0x000000040000000} '30 - BoostPackFX',
    {0x000000080000000} '31 - Unused',
    {0x000000100000000} '32 - SS Hide Hair',
    {0x000000200000000} '33 - SS Morph Hair',
    {0x000000400000000} '34 - SS Hide Head',
    {0x000000800000000} '35 - SS BODY',
    {0x000001000000000} '36 - SS Helmet',
    {0x000002000000000} '37 - SS Backpack',
    {0x000004000000000} '38 - SS Gloves',
    {0x000008000000000} '39 - SS Lower Body',
    {0x000010000000000} '40 - SS Sleeves',
    {0x000020000000000} '41 - SS Head Vis',
    {0x000040000000000} '42 - SS U Body 1',
    {0x000080000000000} '43 - SS U Body 2',
    {0x000100000000000} '44 - SS U Body 3',
    {0x000200000000000} '45 - SS Misc 1',
    {0x000400000000000} '46 - SS Misc 2',
    {0x000800000000000} '47 - SS Misc 3',
    {0x001000000000000} '48 - SS Eyes',
    {0x002000000000000} '49 - SS Beard',
    {0x004000000000000} '50 - SS Neuroamp',
    {0x008000000000000} '51 - SS Hide Ear',
    {0x010000000000000} '52 - SS Addon Rig',
    {0x020000000000000} '53 - SS Backpack Misc',
    {0x040000000000000} '54 - SS ChronoMark',
    {0x080000000000000} '55 - Unused',
    {0x100000000000000} '56 - Unused',
    {0x020000000000000} '57 - Unused',
    {0x040000000000000} '58 - Unused',
    {0x080000000000000} '59 - SS Morph Beard',
    {0x100000000000000} '60 - Unused',
    {0x200000000000000} '61 - Unused',
    {0x400000000000000} '62 - Unused',
    {0x800000000000000} '63 - FaceLights'
  ], True);

  var wbFirstPersonFlagsU64 := wbInteger('First Person Flags', itU64, wbBipedObjectFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);

  var wbBO64 :=
    wbStruct(BO64, 'Biped Object Template', [
      wbFirstPersonFlagsU64
    ], cpNormal, False)
      .SetSummaryKeyOnValue([0])
      .SetSummaryPrefixSuffixOnValue(0, '(', ')')
      .IncludeFlag(dfSummaryMembersNoName);

  var wbDODT :=
    wbStruct(DODT, 'Decal Data', [
      wbFloat('Min Width'),
      wbFloat('Max Width'),
      wbFloat('Min Height'),
      wbFloat('Max Height'),
      wbFloat('Depth'),
      wbFloat('Alpha')
    ]);

  wbIgnoreRecords.Add(XXXX);

  var wbXRGD := wbArray(XRGD, 'Ragdoll Data', wbStruct('Ragdoll Data', [
    wbInteger('Bone Id', itU8),
    wbUnused(3),
    wbPosRot
  ]));

  var wbXFLG :=
    wbInteger(XFLG, 'Extra Flags', itU32, wbFlags([
      {0x01} '',
      {0x02} '',
      {0x04} '',
      {0x08} '',
      {0x10} '',
      {0x20} '',
      {0x40} 'Unknown 6'
    ]));

  var wbXRGB := wbStruct(XRGB, 'Ragdoll Biped Rotation', [
    wbFloat('X'),
    wbFloat('Y'),
    wbFloat('Z')
  ]);

  var wbSoundLevelEnum := wbEnum([
     'None',
     'Silent',
     'Quiet',
     'Normal',
     'Loud',
     'Very Loud'
    ]);

  var wbEntryPointsEnum := wbEnum([
    {000} 'Mod Breath Timer',
    {001} 'Mod My Critical Hit Chance',
    {002} 'Mod My Critical Hit Damage Mult',
    {003} 'Mod Mine Explode Chance',
    {004} 'Mod Incoming Limb Damage',
    {005} 'Mod Book Actor Value Bonus',
    {006} 'Mod Recovered Health',
    {007} 'Set Should Attack',
    {008} 'Mod Buy Prices',
    {009} 'Add Leveled List On Death',
    {010} 'Set Max Carry Weight',
    {011} 'Mod Addiction Chance',
    {012} 'Mod Addiction Duration',
    {013} 'Mod Positive Chem Duration',
    {014} 'Activate',
    {015} 'Ignore Running During Detection',
    {016} 'Ignore Broken Lock',
    {017} 'Mod Enemy Critical Hit Chance',
    {018} 'Mod Sneak Attack Mult',
    {019} 'Mod Max Placeable Mines',
    {020} 'Mod Bow Zoom',
    {021} 'Mod Recover Arrow Chance',
    {022} 'Mod Exp',
    {023} 'Mod Telekinesis Distance',
    {024} 'Mod Telekinesis Damage Mult',
    {025} 'Mod Telekinesis Damage',
    {026} 'Mod Bashing Damage',
    {027} 'Mod Power Attack Oxygen',
    {028} 'Mod Power Attack Damage',
    {029} 'Mod Spell Magnitude',
    {030} 'Mod Spell Duration',
    {031} 'Mod Secondary Value Weight',
    {032} 'Mod Armor Weight',
    {033} 'Mod Incoming Stagger',
    {034} 'Mod Target Stagger',
    {035} 'Mod Weapon Attack Damage',
    {036} 'Mod Incoming Weapon Damage',
    {037} 'Mod Target Damage Resistance',
    {038} 'Mod Spell Cost',
    {039} 'Mod Percent Blocked',
    {040} 'Mod Shield Deflect Arrow Chance',
    {041} 'Mod Incoming Spell Magnitude',
    {042} 'Mod Incoming Spell Duration',
    {043} 'Mod Player Intimidation',
    {044} 'Mod Ricochet Chance',
    {045} 'Mod Ricochet Damage',
    {046} 'Mod Bribe Amount',
    {047} 'Mod Detection Light',
    {048} 'Mod Detection Movement',
    {049} 'Mod Scrap Reward Mult',
    {050} 'Set Sweep Attack',
    {051} 'Apply Combat Hit Spell',
    {052} 'Apply Bashing Spell',
    {053} 'Apply Reanimate Spell',
    {054} 'Set Boolean Graph Variable',
    {055} 'Mod Spell Casting Sound Event',
    {056} 'Mod Pickpocket Chance',
    {057} 'Mod Detection Sneak Skill',
    {058} 'Mod Falling Damage',
    {059} 'Mod Lockpick Sweet Spot',
    {060} 'Mod Sell Prices',
    {061} 'Can Pickpocket Equipped Item',
    {062} 'Set Player Gate Lockpick',
    {063} 'Set Lockpick Starting Arc',
    {064} 'Set Progression Picking',
    {065} 'Set Lockpicks Unbreakable ',
    {066} 'Mod Alchemy Effectiveness',
    {067} 'Apply Weapon Swing Spell',
    {068} 'Mod Commanded Actor Limit',
    {069} 'Apply Sneaking Spell',
    {070} 'Mod Player Magic Slowdown',
    {071} 'Mod Ward Magicka Absorption Pct',
    {072} 'Mod Initial Ingredient Effects Learned',
    {073} 'Purify Alchemy Ingredients',
    {074} 'Set Filter Activation',
    {075} 'Set Dual Cast',
    {076} 'Mod Outgoing Explosion Limb Damage',
    {077} 'Mod Enchantment Power',
    {078} 'Mod Soul Pct Captured to Weapon',
    {079} 'Mod VATS Attack Oxygen',
    {080} 'Mod Reflect Damage Chance',
    {081} 'Set Activate Label',
    {082} 'Mod Kill Experience',
    {083} 'Mod Poison Dose Count',
    {084} 'Set Apply Placed Item',
    {085} 'Mod Armor Rating',
    {086} 'Mod lockpicking crime chance',
    {087} 'Mod ingredients harvested',
    {088} 'Mod Spell Range (Target Loc.)',
    {089} 'Mod Critical Charge Mult on Ricochet',
    {090} 'Mod lockpicking key reward chance',
    {091} 'Mod Auto Lockpicking Chance',
    {092} 'Mod Auto Hacking Chance',
    {093} 'Mod Typed Weapon Attack Damage',
    {094} 'Mod Typed Incoming Weapon Damage',
    {095} 'Mod Charisma Challenge Chance',
    {096} 'Mod Sprint Oxygen Drain Rate',
    {097} 'Mod Drawn Weapon Weight Speed Effect',
    {098} 'Set Player Gate Hacking',
    {099} 'Mod Player Explosion Damage',
    {100} 'Mod Player Explosion Scale',
    {101} 'Set Rads To Health Mult',
    {102} 'Mod Actor Scope Stability',
    {103} 'Mod Actor Grenade Speed Mult',
    {104} 'Mod Explosion Force',
    {105} 'Mod VATS Penetration Min Visibility',
    {106} 'Mod Rads for Rad Health Max',
    {107} 'Mod VATS Player O2 On Kill Chance',
    {108} 'Set VATS Fill Critical Bar On Hit',
    {109} 'Mod VATS Concentrated Fire Chance Bonus',
    {110} 'Mod VATS Critical Count',
    {111} 'Mod VATS Hold Em Steady Bonus',
    {112} 'Mod Typed Spell Magnitude',
    {113} 'Mod Typed Incoming Spell Magnitude',
    {114} 'Set VATS Gun-Fu Num Targets For Crits',
    {115} 'Mod Outgoing Limb Damage',
    {116} 'Mod Restore Oxygen Cost Value',
    {117} 'Mod VATS Reload Oxygen',
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
    {136} 'Mod Oxygen Use',
    {137} 'Mod VATS Critical Fill Chance On Bank',
    {138} 'Mod VATS Critical Fill Chance On Use',
    {139} 'Set VATS Critical Fill On Oxygen Reward',
    {140} 'Set VATS Critical Fill On Stranger',
    {141} 'Mod Gun Range Mult',
    {142} 'Mod Scope Hold Breath Oxygen Drain Mult',
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
    {155} 'Mod Jumping Oxygen',
    {156} 'Mod CarbonDioxide for CarbonDioxide Oxygen Max',
    {157} 'Set CarbonDioxide to Oxygen Mult',
    {158} 'Mod Oxygen Drain Rate for Running while Encumbered',
    {159} 'Iron-Sights Activate',
    {160} 'Mod Recovered Star Power',
    {161} 'Mod Workshop Production Timer',
    {162} 'Mod Activity Max Repetitions',
    {163} 'Mod Ship System Repair Rate',
    {164} 'Mod Magazine Size',
    {165} 'Mod Typed Incoming Weapon Damage Spaceship',
    {166} 'Mod Weapon Reload Speed',
    {167} 'Mod Magazine Draw Speed',
    {168} 'Mod Research Crit Chance',
    {169} 'Mod Research Cost',
    {170} 'Mod Ship Cargo Max',
    {171} 'Mod Ship Grav Jump Fuel Cost',
    {172} 'Mod Ship Grav Jump Calculation Time',
    {173} 'Mod Player Gravity',
    {174} 'Mod Workshop Build Cost',
    {175} 'Mod Workshop Repair Cost',
    {176} 'Mod Persuasion_Skill_Player_Success_Chance',
    {177} 'Mod Player_Bounty',
    {178} 'Mod Crafting Dupe Chance',
    {179} 'Mod Crafting Return Quantity',
    {180} 'Mod Spell Area',
    {181} 'Mod Crafting Creation Recipe Level',
    {182} 'Apply Combat Hit Spell Self',
    {183} 'Mod Item Weight',
    {184} 'Mod Ship Targeting Fire AP Cost',
    {185} 'Mod Spell Effect Magnitude',
    {186} 'Mod Spell Effect Duration',
    {187} 'Mod Spell Effect Area',
    {188} 'Mod Ship Grav Jump Distance',
    {189} 'Mod Social Skill Chance Base',
    {190} 'Mod Social Skill Chance Bonus',
    {191} 'Mod Social Skill Chance Max Level Delta',
    {192} 'Set Zero G Skill Rank',
    {193} 'Mod Ship Weapon Recharge Rate',
    {194} 'Mod Ship Weapon Explosion Scale',
    {195} 'Mod Ship Weapon Accuracy',
    {196} 'Mod Ship Turn Speed (Regular Mode)',
    {197} 'Mod Ship Turn Speed (Boost Mode)',
    {198} 'Mod Ship Turn Speed (Thruster Mode)',
    {199} 'Mod Ship Turn Sweet Spot',
    {200} 'Mod Planet Scan Max Distance',
    {201} 'Apply Jetpack Spell',
    {202} 'Mod Ship System Full Repair Chance',
    {203} 'Mod Player Zero G Weapon Recoil Scale',
    {204} 'Mod Crafting Freebie Chance',
    {205} 'Mod Weapon Shot Count',
    {206} 'Override Weapon Projectile',
    {207} 'Allow Pickpocket',
    {208} 'Mod Bleedout Chance',
    {209} 'Mod Bleedout Recover Chance',
    {210} 'Mod Bleedout Health Percent',
    {211} 'Apply Start Mantle Spell',
    {212} 'Apply Start Combat Slide Spell',
    {213} 'Apply Combat Hit Spell Attacker',
    {214} 'Ship Boost Defeats Missiles',
    {215} 'Ship Boost Disengages Enemies',
    {216} 'Add Produced Items',
    {217} 'Apply Spell on Spaceship Target Lock Acquired	',
    {218} 'Add Harvested Items',
    {219} 'Mod Power Generated',
    {220} 'Enable Stealth Meter',
    {221} 'Apply Aim Down Sight Spell',
    {222} 'Mod Affinity Gain',
    {223} 'Allow Jetpack',
    {224} 'Mod Sneak Door Sound Level',
    {225} 'Mod Crafting Cost',
    {226} 'Enable Player Ship Thruster Mode',
    {227} 'Mod Weapon Weight',
    {228} 'Mod Damage Resistance',
    {229} 'Set Highest Pilotable Class Rating',
    {230} 'Mod Critical Chance on Target Locked Spaceship',
    {231} 'Mod Jetpack Fuel Drain Mult',
    {232} 'Enable Jetpack Hover',
    {233} 'Enable Player Ship Targeting Mode',
    {234} 'Enable Scanning Targeted Ship''s Inventory',
    {235} 'Modify Piloted Spaceship''s Max Forward Speed',
    {236} 'Modify Weapon Fire Rate',
    {237} 'Modify Ship Boost Fuel',
    {238} 'Modify Ship Boost Recharge Rate',
    {239} 'Mod Ship System Damage Mitigation',
    {240} 'Apply Spell on Ship Boost',
    {241} 'Allow Scan Tracked Items',
    {242} 'Enable Scanner Zoom',
    {243} 'Mod Crafting Mod Freebie Chance',
    {244} 'Enable Scanning Targeted Ship''s Power Allocation',
    {245} 'Enable Scanning Targeted Ship''s Cargo Value',
    {246} 'Enable Scanning Targeted Ship''s Crew Count',
    {247} 'Enable Scanning Targeted Ship''s Health Values',
    {248} 'Enable Scanning Targeted Ship''s Damage Rating',
    {249} 'Enable Scanning Targeted Ship''s Weapon Stats',
    {250} 'Mod Armor Resistance',
    {251} 'Mod Ship Linear Acceleration',
    {252} 'Mod Final Player Ground Combat Damage',
    {253} 'Mod Final Player Ship Combat Damage'
  ]);

  var wbEquipType := wbFlags([
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

  var wbEmotionTypeEnum := wbEnum([
    {0} 'Neutral',
    {1} 'Anger',
    {2} 'Disgust',
    {3} 'Fear',
    {4} 'Sad',
    {5} 'Happy',
    {6} 'Surprise',
    {7} 'Puzzled'
  ]);

  var wbFurnitureAnimTypeEnum := wbEnum([
    {0} '',
    {1} 'Sit',
    {2} 'Lay',
    {3} '',
    {4} 'Lean'
  ]);

  var wbFurnitureEntryTypeFlags := wbFlags([
    {0x01} 'Front',
    {0x02} 'Behind',
    {0x04} 'Right',
    {0x08} 'Left',
    {0x10} 'Up'
  ]);

  var wbWardStateEnum := wbEnum([
    'None',
    'Absorb',
    'Break'
  ]);

  var wbEventFunctionEnum := wbEnum([
    'GetIsID',
    'IsInList',
    'GetValue',
    'HasKeyword',
    'GetItemValue'
  ]);

  var wbDamageCauseTypeEnum := wbEnum([
    { 0} 'None',
    { 1} 'Explosion',
    { 2} 'Gun',
    { 3} 'Blunt Weapon',
    { 4} 'Hand to Hand',
    { 5} 'Object Impact',
    { 6} 'Poison',
    { 7} 'Decapitation',
    { 8} 'Falling',
    { 9} 'Drowning',
    {10} 'Trap',
    {11} 'Ship Destroyed',
    {12} 'Other'
  ]);

  var wbPerkCategoryEnum := wbEnum([
    {0} 'None',
    {1} 'Combat',
    {2} 'Science',
    {3} 'Tech',
    {4} 'Physical',
    {5} 'Social',
    {6} 'All',
    {7} 'AllIncludingNone'
  ]);

  var wbPerkSkillGroupEnum := wbEnum([
    {0} 'None',
    {1} 'Basic',
    {2} 'Advanced',
    {3} 'Expert',
    {4} 'Master'
  ]);

  // Event member names and availability are different depending on event type
  // Using generic names for the last 3 of them: Form, Value1, Value2
  // Event member names and availability are different depending on event type
  // Using generic names for the last 3 of them: Form, Value1, Value2
  var wbEventMemberEnum := wbEnum([], [
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

  var wbWeaponAnimTypeEnum := wbEnum([
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

  var wbReverbClassEnum := wbEnum([
    'Default',
    'Class A',
    'Class B',
    'Class C',
    'Class D',
    'Class E'
  ]);

  var wbHitBehaviourEnum := wbEnum([
    'Normal formula behaviour',
    'Dismember only',
    'Explode only',
    'No dismember or explode'
  ]);

  var wbLGDIStarSlot := wbEnum([
    'First Star Slot',
    'Second Star Slot',
    'Third Star Slot',
    'Fourth Star Slot',
    'Fifth Star Slot'
  ]);

  var wbPronounEnum := wbEnum([
    {0} 'Unspecified',
    {1} 'He/Him',
    {2} 'She/Her',
    {3} 'They/Them'
  ]);

  var wbLearnMethodEnum  := wbEnum([
    {0} 'Learned when picked up or by script',
    {1} 'Learned by scrapping',
    {2} 'Learned when ingested',
    {3} 'Known by default or when conditions are met',
    {4} 'Learned from plan'
      ]);

  var wbPhotoModeEnum  := wbEnum([
    {0} 'Texture Overlay',
    {1} 'Frame',
    {2} 'Filter'
  ]);

  var wbObjectModPropertiesWEAPEnum := wbEnum([],[
                 28, 'Physical Weapon Damage',                    //Applied directly to WEAP records
                 29, 'Unknown 29',                    //Applied directly to WEAP records
                 71, 'Damage Type Value',                    //Applied directly to WEAP records
                 85, 'Layered Material Swap 85'                    //Applied directly to WEAP records
  ]);
  var wbObjectModPropertiesARMOEnum := wbEnum([],[
                 14, 'Layered Material Swap 14'      //applied directly to ARMO records
  ]);
  var wbObjectModPropertiesNPCEnum := wbEnum([],[
                  6, 'Layered Material Swap 6'       //Applied directly to NPC_ records
  ]);

  var wbQuestEventTypeEnum := wbEnum([],[
    Sig2Int('ADIA'), 'Actor Dialogue',
    Sig2Int('AHEL'), 'Actor Hello',
    Sig2Int('ARRT'), 'Arrest',
    Sig2Int('ASSU'), 'Assault Actor',
    Sig2Int('AOBJ'), 'Attraction Object',
    Sig2Int('BRIB'), 'Bribe',
    Sig2Int('CAST'), 'Cast Magic',
    Sig2Int('CLOC'), 'Change Location',
    Sig2Int('CHRR'), 'Change Relationship',
    Sig2Int('XPLL'), 'Clear Location',
    Sig2Int('CRFT'), 'Craft Item',
    Sig2Int('ADCR'), 'Crime Gold',
    Sig2Int('DEAD'), 'Dead Body',
    Sig2Int('ESJA'), 'Escape Jail',
    Sig2Int('FLAT'), 'Flatter',
    Sig2Int('HACK'), 'Hack Computer',
    Sig2Int('LEVL'), 'Increase Level',
    Sig2Int('INTM'), 'Intimidate',
    Sig2Int('IRON'), 'Iron Sights',
    Sig2Int('JAIL'), 'Jail',
    Sig2Int('KILL'), 'Kill Actor',
    Sig2Int('LCLD'), 'Location Loaded',
    Sig2Int('LOCK'), 'Lock Pick',
    Sig2Int('NVPE'), 'New Voice Power',
    Sig2Int('OAAT'), 'On Actor Attach',
    Sig2Int('OSCC'), 'On Speech Challenge Completion',
    Sig2Int('PFIN'), 'Pay Fine',
    Sig2Int('PICK'), 'Pick Pocket',
    Sig2Int('PIRA'), 'Piracy Actor',
    Sig2Int('AFAV'), 'Player Activate Actor',
    Sig2Int('AIPL'), 'Player Add Item',
    Sig2Int('CURE'), 'Player Cured',
    Sig2Int('INFC'), 'Player Infected',
    Sig2Int('PRFV'), 'Player Receives Favor',
    Sig2Int('REMP'), 'Player Remove Item',
    Sig2Int('SCPT'), 'Script Event',
    Sig2Int('STIJ'), 'Served Time',
    Sig2Int('DOCK'), 'Ship Docking',
    Sig2Int('LAND'), 'Ship Landing',
    Sig2Int('TRES'), 'Tresspass Actor',
    Sig2Int('TMEE'), 'Trigger Mine Explosion'
  ]);

  var wbObjectModPropertiesEnum := wbEnum([],[
    Sig2Int('AACT'), 'Armor - Actor Value',
    Sig2Int('ADMG'), 'Armor - Damage Resistance',
    Sig2Int('AENC'), 'Armor - Enchantment',
    Sig2Int('AKEY'), 'Armor - Keyword',
    Sig2Int('AMLS'), 'Armor - Layered Material Swap',
    Sig2Int('ARAT'), 'Armor - Rating',
    Sig2Int('AVAL'), 'Armor - Value',
    Sig2Int('AWGT'), 'Armor - Weight',
    Sig2Int('ABBI'), 'Armor - Bash Impact Data Set',
    Sig2Int('ABBM'), 'Armor - Block Material',
    Sig2Int('ABOD'), 'Armor - Body Part',
    Sig2Int('ACOL'), 'Armor - Color Remapping Index',
    Sig2Int('AHLT'), 'Armor - Health',
    Sig2Int('AIND'), 'Armor - Addon Index',
    Sig2Int('ATMC'), 'Armor - Mod Count',
    Sig2Int('CKEY'), 'Container - Keyword',
    Sig2Int('FLMS'), 'Flora - Layered Material Swap',
    Sig2Int('FKEY'), 'Flora - Keyword',
    Sig2Int('NACV'), 'NPC - Actor Value',
    Sig2Int('NARO'), 'NPC - NPC Race Override',
    Sig2Int('NAID'), 'NPC - AI Data',
    Sig2Int('NCST'), 'NPC - Combat Style ',
    Sig2Int('NENC'), 'NPC - Enchantment',
    Sig2Int('NFAC'), 'NPC - Faction',
    Sig2Int('NGFA'), 'NPC - Group Faction',
    Sig2Int('NINV'), 'NPC - Inventory',
    Sig2Int('NNAM'), 'NPC - Display Name',
    Sig2Int('NPAC'), 'NPC - Package',
    Sig2Int('NRCO'), 'NPC - Race Override',
    Sig2Int('NVTP'), 'NPC - Voice Type',
    Sig2Int('NCOL'), 'NPC - Color Remapping Index',
    Sig2Int('NKEY'), 'NPC - Keyword',
    Sig2Int('NMSL'), 'NPC - Layered Material Swap',
    Sig2Int('NMMX'), 'NPC - Min-Max Size',
    Sig2Int('NPRK'), 'NPC - Perk',
    Sig2Int('NRCE'), 'NPC - Race Change',
    Sig2Int('NREA'), 'NPC - Reaction Radius',
    Sig2Int('NSKN'), 'NPC - Skin',
    Sig2Int('NSPL'), 'NPC - Spell',
    Sig2Int('NXPO'), 'NPC - XP Override',
    Sig2Int('SPAV'), 'Spaceship - Actor Value ',
    Sig2Int('SDMG'), 'Spaceship - System Damage',
    Sig2Int('SENC'), 'Spaceship - Enchantment',
    Sig2Int('SINV'), 'Spaceship - Inventory',
    Sig2Int('SKEY'), 'Spaceship - Keyword',
    Sig2Int('SMLS'), 'Spaceship - Layered Material Swaps',
    Sig2Int('SCRI'), 'Spaceship - Color Remapping Index',
    Sig2Int('AA00'), 'Weapon (AAMD)- Aim Assist Template',
    Sig2Int('AA01'), 'Weapon (AAMD)- Aim Inner Cone Angle (Degrees)',
    Sig2Int('AA02'), 'Weapon (AAMD)- Aim Outer Cone Angle (Degrees)',
    Sig2Int('AA03'), 'Weapon (AAMD)- Steering Degrees per Second',
    Sig2Int('AA04'), 'Weapon (AAMD)- Pitch Scale',
    Sig2Int('AA05'), 'Weapon (AAMD)- Inner Steering Ring',
    Sig2Int('AA06'), 'Weapon (AAMD)- Outer Steering Ring',
    Sig2Int('AA07'), 'Weapon (AAMD)- Friction',
    Sig2Int('AA08'), 'Weapon (AAMD)- Move Follow Degrees per Second',
    Sig2Int('AA09'), 'Weapon (AAMD)- ADS Snap Steering Multiplier',
    Sig2Int('AA10'), 'Weapon (AAMD)- ADS Snap (Seconds)',
    Sig2Int('AA11'), 'Weapon (AAMD)- ADS Snap Cone Angle (Degrees)',
    Sig2Int('AA12'), 'Weapon (AAMD)- No Steering',
    Sig2Int('AA13'), 'Weapon (AAMD)- Bullet Bending Cone Angle (Degrees)',
    Sig2Int('AA14'), 'Weapon (AAMD)- ADS Snap Steering Multiplier Inner Ring',
    Sig2Int('AA15'), 'Weapon (AAMD)- ADS Snap Steering Multiplier Outer Ring',
    Sig2Int('AA16'), 'Weapon (AAMD)- ADS Multiplier Inner Cone Angle (Degrees)',
    Sig2Int('AA17'), 'Weapon (AAMD)- ADS Multiplier Outer Cone Angle (Degrees)',
    Sig2Int('AA18'), 'Weapon (AAMD)- ADS Multiplier Inner Steering Ring',
    Sig2Int('AA19'), 'Weapon (AAMD)- ADS Multiplier Outer Steering Ring',
    Sig2Int('AA20'), 'Weapon (AAMD)- ADS Multiplier Friction',
    Sig2Int('AA21'), 'Weapon (AAMD)- ADS Multiplier Steering Degree per Second',
    Sig2Int('AA22'), 'Weapon (AAMD)- Aim Assist Enabled',
    Sig2Int('ALIS'), 'Weapon - Ammo List',
    Sig2Int('AMMO'), 'Weapon - Ammo Type',
    Sig2Int('ACPT'), 'Weapon - Ammo Capacity',
    Sig2Int('AUSE'), 'Weapon - NPCs Use Ammo',
    Sig2Int('DRES'), 'Weapon - Resistance',
    Sig2Int('DSKL'), 'Weapon - Skill',
    Sig2Int('FBOL'), 'Weapon - Bolt Charge (Seconds)',
    Sig2Int('FHST'), 'Weapon - Has Staged Trigger',
    Sig2Int('GTYP'), 'Weapon - General Type',
    Sig2Int('GVAL'), 'Weapon - Value',
    Sig2Int('GWEI'), 'Weapon - Weight',
    Sig2Int('WAOC'), 'Weapon - Attack Oxygen Cost',
    Sig2Int('PAVI'), 'Weapon - Power',
    Sig2Int('PBAV'), 'Weapon - Power (Bonus)',
    Sig2Int('PFCT'), 'Weapon - Full Recharge Time',
    Sig2Int('PRCD'), 'Weapon - Recharge Delay',
//    Sig2Int('PUSE'), 'Weapon - Consume Ammo',                                           //Also "Use Power"?
    Sig2Int('WACB'), 'Weapon - Accuracy Bonus',
    Sig2Int('WABS'), 'Weapon (AMDL)- Aim Model - Base Stability',
    Sig2Int('WAIM'), 'Weapon (AMDL)- Aim Model - Template',
    Sig2Int('WCO1'), 'Weapon (AMDL)- Aim Model Cone - Min Degrees',
    Sig2Int('WCO2'), 'Weapon (AMDL)- Aim Model Cone - Max Degrees',
    Sig2Int('WCO3'), 'Weapon (AMDL)- Aim Model Cone - Increase Per Shot',
    Sig2Int('WCO4'), 'Weapon (AMDL)- Aim Model Cone - Decrease Per Sec',
    Sig2Int('WCO5'), 'Weapon (AMDL)- Aim Model Cone - Decrease Delay Per Sec',
    Sig2Int('WCO6'), 'Weapon (AMDL)- Aim Model Cone - Iron Sights Multiplier',
    Sig2Int('WRC1'), 'Weapon (AMDL)- Aim Model Recoil - Diminish Spring Force',
    Sig2Int('WRC2'), 'Weapon (AMDL)- Aim Model Recoil - Diminish Sights Mult',
    Sig2Int('WRC3'), 'Weapon (AMDL)- Aim Model Recoil - Max Degree Per Shot',
//    Sig2Int('WRC4'), 'Weapon (AMDL)- ',                                         {both "Aim Model Recoil Arc Degree" and "Aim Model Recoil Min Degree Per Shot"}
    Sig2Int('WRC5'), 'Weapon (AMDL)- Aim Model Recoil - Multiplier (Hip Fire)',
//    Sig2Int('WRC6'), 'Weapon (AMDL)- ',                                         {both "Aim Model Cone Sneak Multiplier" and "Aim Model Recoil Shots For Runaway"}
    Sig2Int('WRC8'), 'Weapon (AMDL)- Aim Model Recoil Arc Rotate Degrees',
    Sig2Int('WAOS'), 'Weapon - Aim Optical Sight Marker',
    Sig2Int('WACV'), 'Weapon - Actor Value',
    Sig2Int('WADL'), 'Weapon - Attack Delay (Seconds)',
    Sig2Int('WSDM'), 'Weapon - Bash Damage',
    Sig2Int('WREA'), 'Weapon - Reach',
    Sig2Int('WSTG'), 'Weapon - Stagger',
    Sig2Int('WATS'), 'Weapon - Attack (Seconds)',
    Sig2Int('WBMT'), 'Weapon - Block Material',
    Sig2Int('WBOL'), 'Weapon - Bolt Action',
    Sig2Int('WBSH'), 'Weapon - Bash Impact Data Set',
    Sig2Int('WCAT'), 'Weapon - Charging Attack',
    Sig2Int('WCCB'), 'Weapon - Critical Charge Bonus',
    Sig2Int('WCHR'), 'Weapon - Charging Reload',
    Sig2Int('FBDS'), 'Weapon - Burst Delay (Seconds)',
    Sig2Int('FBUR'), 'Weapon - Burst Shots',
    Sig2Int('WCDM'), 'Weapon - Critical Damage Multiplier',
    Sig2Int('WCIM'), 'Weapon - Critical Chance Inc. Multiplier',
    Sig2Int('WDMG'), 'Weapon - Damage (Physical)',
    Sig2Int('WDTV'), 'Weapon - Damage Type Value',
    Sig2Int('WEMT'), 'Weapon - Enable Marking Targets (Recon)',
    Sig2Int('WENC'), 'Weapon - Enchantment',
    Sig2Int('FREP'), 'Weapon - Full Auto',
    Sig2Int('FTYP'), 'Weapon - Firing Type',
    Sig2Int('FHDT'), 'Weapon - Has Dual Trigger',
    Sig2Int('WIMP'), 'Weapon - Impact Dataset',
    Sig2Int('WKEY'), 'Weapon - Keyword',
    Sig2Int('WMNR'), 'Weapon - Min Range',
    Sig2Int('WMXR'), 'Weapon - Max Range',
    Sig2Int('WTMC'), 'Weapon - Mod Count',
    Sig2Int('FORF'), 'Weapon - Override Rate of Fire',
    Sig2Int('WNPR'), 'Weapon - Projectile Count',
    Sig2Int('WOPR'), 'Weapon - Projectile Override',
    Sig2Int('WRSP'), 'Weapon - Reload Speed',
    Sig2Int('WSCP'), 'Weapon - Scope',
    Sig2Int('WSPS'), 'Weapon - Shots per Second',
    Sig2Int('WSTS'), 'Weapon - Sighted Transition (Seconds)',
    Sig2Int('WSLV'), 'Weapon - Sound Level',
    Sig2Int('WSPD'), 'Weapon - Speed',
    Sig2Int('WCOL'), 'Weapon - Color Remapping Index',
    Sig2Int('WCRT'), 'Weapon - Critical Effect',
    Sig2Int('WDSH'), 'Weapon - Disable Shell Case Eject',
    Sig2Int('WEDT'), 'Weapon - Critical Effect on Death Only',
    Sig2Int('WEQS'), 'Weapon - Equip Slot',
    Sig2Int('WFPS'), 'Weapon - Full Power (Seconds)',
    Sig2Int('WFSC'), 'Weapon - Fire (Seconds)',
    Sig2Int('WHBV'), 'Weapon - Hit Behavior',
    Sig2Int('WHIP'), 'Weapon - Hold Input',
    Sig2Int('WMCR'), 'Weapon - Minor Crime',
    Sig2Int('WMPS'), 'Weapon - Min Power per Shot',
    Sig2Int('WNDP'), 'Weapon - Can''t Drop',
    Sig2Int('WNHO'), 'Weapon - Non-Hostile',
    Sig2Int('WNPL'), 'Weapon - Non-Playable',
    Sig2Int('WOOR'), 'Weapon - Out of Range Damage Mult',
    Sig2Int('WOSC'), 'Weapon - Override Shell Casing',
    Sig2Int('WPLY'), 'Weapon - Player Only',
    Sig2Int('VAAC'), 'Weapon - Variable Range Aperture - Acceleration',
    Sig2Int('VADC'), 'Weapon - Variable Range Aperture - Deceleration',
    Sig2Int('VAIN'), 'Weapon - Variable Range Aperture - Input Range Min',
    Sig2Int('VAIX'), 'Weapon - Variable Range Aperture - Input Range Max',
    Sig2Int('VAVN'), 'Weapon - Variable Range Aperture - Value Range Min',
    Sig2Int('VAVX'), 'Weapon - Variable Range Aperture - Value Range Max',
    Sig2Int('VDAC'), 'Weapon - Variable Range Distance - Acceleration',
    Sig2Int('VDDC'), 'Weapon - Variable Range Distance - Deceleration',
    Sig2Int('VDIN'), 'Weapon - Variable Range Distance - Input Range Min',
    Sig2Int('VDIX'), 'Weapon - Variable Range Distance - Input Range Max',
    Sig2Int('VDVM'), 'Weapon - Variable Range Distance - Value Range Max',
    Sig2Int('VDVN'), 'Weapon - Variable Range Distance - Value Range Min',
    Sig2Int('VUSE'), 'Weapon - Use Variable Range',
    Sig2Int('WRET'), 'Weapon - Reticle Type',
    Sig2Int('WRNK'), 'Weapon - Rank',
    Sig2Int('WRSG'), 'Weapon - Reload Single',
    Sig2Int('WSLM'), 'Weapon - Sound Level Mult',
    Sig2Int('WSWL'), 'Weapon - Layered Material Swaps',
    Sig2Int('ZIMG'), 'Weapon (ZOOM)- ADS Image Space Modifier',
    Sig2Int('ZOFX'), 'Weapon (ZOOM)- ADS Offset X',
    Sig2Int('ZOFY'), 'Weapon (ZOOM)- ADS Offset Y',
    Sig2Int('ZOFZ'), 'Weapon (ZOOM)- ADS Offset Z',
    Sig2Int('ZOVL'), 'Weapon (ZOOM)- Overlay',
    Sig2Int('ZFOV'), 'Weapon (ZOOM)- FOV Mult',
    Sig2Int('ZDTA'), 'Weapon (ZOOM)- Template'

  ]);

  var wbEDID := wbStringKC(EDID, 'Editor ID', 0, cpOverride);
  var wbNLDT := wbString(NLDT, 'Context Notes'); // localization note, explanation of variable, etc.
  var wbFULL := wbLStringKC(FULL, 'Name', 0, cpTranslate);
  var wbFULLActor := wbLStringKC(FULL, 'Name', 0, cpTranslate, False, nil{wbActorTemplateUseBaseData});
  var wbFULLReq := wbLStringKC(FULL, 'Name', 0, cpTranslate, True);
  var wbDESC := function(aName: string = 'Description'):IwbSubRecordWithBaseStringDef
  begin
    Result := wbLStringKC(DESC, aName, 0, cpTranslate);
  end;
  var wbDESCReq := function(aName: string = 'Description'):IwbSubRecordWithBaseStringDef
  begin
    Result := wbLStringKC(DESC, aName, 0, cpTranslate, True);
  end;
  var wbXSCL := wbFloat(XSCL, 'Scale');
  var wbXALGFlags := wbFlags([ //copied from FO76, probably wrong
    {0x00000001} 'Disallow Permanent Projected Decals',
    {0x00000002} 'Unknown 1',
    {0x00000004} 'Unknown 2',
    {0x00000008} 'Disable Physics Sim',
    {0x00000010} 'Unknown 4',
    {0x00000020} 'Disable Audio Occlusion/Obstruction', //Unused
    {0x00000040} 'Ignore Audio Obstruction Hits',
    {0x00000080} 'Unknown 7',
    {0x00000100} 'High Cost Path',
    {0x00000200} 'Non-Interactive',
    {0x00000400} 'References Are Moveable',
    {0x00000800} 'Disable Loop Sound',
    {0x00001000} 'Unknown 12',
    {0x00002000} 'Unknown 13',
    {0x00004000} 'Unknown 14', //Unused
    {0x00008000} 'Unknown 15', //Unused
    {0x00010000} 'Unknown 16', //Unused
    {0x00020000} 'Unknown 17', //Unused
    {0x00040000} 'Unknown 18', //Unused
    {0x00080000} 'Unknown 19', //Unused
    {0x00100000} 'Unknown 20', //Unused
    {0x00200000} 'Unknown 21', //Unused
    {0x00400000} 'Unknown 22', //Unused
    {0x00800000} 'Unknown 23', //Unused
    {0x01000000} 'Unknown 24', //Unused
    {0x02000000} 'Unknown 25', //Unused
    {0x04000000} 'Unknown 26', //Unused
    {0x08000000} 'Unknown 27', //Unused
    {0x10000000} 'Unknown 28', //Unused
    {0x20000000} 'Unknown 29', //Unused
    {0x40000000} 'Unknown 30', //Unused
    {0x80000000} 'Unknown 31'  //Unused
  ]);

  var wbXALG := wbInteger(XALG, 'Flags', itU64, wbXALGFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);

  var wbPropTypeEnum := wbEnum([
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

  var wbScriptFlags := wbInteger('Flags', itU8, wbEnum([
    {0x00} 'Local',
    {0x01} 'Inherited',
    {0x02} 'Removed',
    {0x03} 'Inherited and Removed'
  ]));

  var wbScriptPropertyObject := wbUnion('Object Union', wbScriptObjFormatDecider, [
    wbStructSK([1], 'Object v2', [
      wbUnused(2),
      wbInteger('Alias', itS16, wbScriptObjectAliasToStr, wbStrToAlias)
        .SetDefaultEditValue('None')
        .SetLinksToCallback(wbScriptObjectAliasLinksTo),
      wbFormID('FormID').IncludeFlag(dfNoReport)
    ], [2, 1, 0])
      .SetSummaryKey([1, 2])
      .SetSummaryMemberPrefixSuffix(1, 'Alias[', '] on')
      .SetSummaryMemberPrefixSuffix(2, '', '')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfSummaryNoSortKey),
    wbStructSK([0], 'Object v1', [
      wbFormID('FormID'),
      wbInteger('Alias', itS16, wbScriptObjectAliasToStr, wbStrToAlias)
        .SetLinksToCallback(wbScriptObjectAliasLinksTo),
      wbUnused(2)
    ])
      .SetSummaryKey([1, 0])
      .SetSummaryMemberPrefixSuffix(1, 'Alias[', '] on')
      .SetSummaryMemberPrefixSuffix(0, '', '')
      .SetSummaryDelimiter('')
      .IncludeFlag(dfSummaryMembersNoName)
  ]);

  var wbScriptPropertyStruct :=
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

  var wbScriptProperty :=
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

  var wbScriptProperties :=
    wbArrayS('Properties', wbScriptProperty, -2, cpNormal, False, nil, nil, nil, wbCanAddScriptProperties)
    .SetSummaryPassthroughMaxLength(80)
    .SetSummaryPassthroughMaxDepth(1);

  var wbScriptEntry := wbStructSK([0], 'Script', [
    wbLenString('ScriptName', 2),
    wbScriptFlags,
    wbScriptProperties
  ])
  .SetSummaryKey([2])
  .SetSummaryMemberPrefixSuffix(2, '(', ')')
  .SetSummaryDelimiter('')
  .IncludeFlag(dfSummaryMembersNoName);

  var wbScriptFragmentsInfo := wbStruct('Script Fragments', [
    wbInteger('Extra bind data version', itS8).SetDefaultNativeValue(3).IncludeFlag(dfSkipImplicitEdit),
    wbInteger('Flags', itU8, wbFlags([
      {1} 'OnBegin',
      {2} 'OnEnd'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbScriptEntry,
    wbArray('Fragments',  // Do NOT sort, ordered OnBegin, OnEnd
      wbStruct('Fragment', [
        wbInteger('Unknown', itS8).IncludeFlag(dfSkipImplicitEdit),
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

  var wbScriptFragmentsPack := wbStruct('Script Fragments', [
    wbInteger('Extra bind data version', itS8).SetDefaultNativeValue(3).IncludeFlag(dfSkipImplicitEdit),
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

  var wbScriptFragmentsQuest := wbStruct('Script Fragments', [
    wbInteger('Extra bind data version', itS8).SetDefaultNativeValue(3).IncludeFlag(dfSkipImplicitEdit),
    wbInteger('FragmentCount', itU16, nil, cpBenign).IncludeFlag(dfSkipImplicitEdit),
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

  var wbScriptFragmentsScen := wbStruct('Script Fragments', [
    wbInteger('Extra bind data version', itS8).SetDefaultNativeValue(3).IncludeFlag(dfSkipImplicitEdit),
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

  var wbScriptFragments := wbStruct('Script Fragments', [
    wbInteger('Extra bind data version', itS8).SetDefaultNativeValue(3),
    wbScriptEntry,
    wbArrayS('Fragments',
      wbStructSK([0], 'Fragment', [
        wbInteger('Fragment Index', itU16),
        wbUnused(2),
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
    wbInteger('Version', itS16, nil, cpIgnore).SetDefaultNativeValue(6).IncludeFlag(dfSkipImplicitEdit);

  var wbVMADObjectFormat :=
    wbInteger('Object Format', itS16, nil, cpIgnore).SetDefaultNativeValue(2).IncludeFlag(dfSkipImplicitEdit);

  var wbVMADScripts :=
    wbArrayS('Scripts', wbScriptEntry, -2, cpNormal, False, nil, nil, nil, wbCanAddScripts)
    .SetSummaryPassthroughMaxLength(100);

  var wbVMAD := wbStruct(VMAD, 'Virtual Machine Adapter', [
    wbVMADVersion,
    wbVMADObjectFormat,
    wbVMADScripts
  ])
  .SetSummaryKeyOnValue([2]);

  var wbVMADFragmentedTMLM := wbStruct(VMAD, 'Virtual Machine Adapter',[
    wbVMADVersion,
    wbVMADObjectFormat,
    wbVMADScripts,
    wbScriptFragments
  ], cpNormal, False, nil, 3{some records are missing the fragments part})
  .SetSummaryKeyOnValue([2]);

  var wbVMADFragmentedPERK := wbStruct(VMAD, 'Virtual Machine Adapter', [
    wbVMADVersion,
    wbVMADObjectFormat,
    wbVMADScripts,
    wbScriptFragments
  ], cpNormal, False, nil, 3)
  .SetSummaryKeyOnValue([2, 3]);

  var wbVMADFragmentedPACK := wbStruct(VMAD, 'Virtual Machine Adapter', [
    wbVMADVersion,
    wbVMADObjectFormat,
    wbVMADScripts,
    wbScriptFragmentsPack
  ], cpNormal, False, nil, 3)
  .SetSummaryKeyOnValue([2, 3]);

  var wbVMADFragmentedQUST := wbStruct(VMAD, 'Virtual Machine Adapter', [
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

  var wbVMADFragmentedSCEN := wbStruct(VMAD, 'Virtual Machine Adapter', [
    wbVMADVersion,
    wbVMADObjectFormat,
    wbVMADScripts,
    wbScriptFragmentsScen
  ], cpNormal, False, nil, 3)
  .SetSummaryKeyOnValue([2, 3]);

  var wbVMADFragmentedINFO := wbStruct(VMAD, 'Virtual Machine Adapter', [
    wbVMADVersion,
    wbVMADObjectFormat,
    wbVMADScripts,
    wbScriptFragmentsInfo
  ], cpNormal, False, nil, 3)
  .SetSummaryKeyOnValue([2, 3]);

  var wbAttackData := wbRStructSK([1], 'Attack', [
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
      wbFloat('Hit Cone'),
      wbFloat('Stagger'),  // not visible in CK
      wbFloat('Knockdown'),
      wbFloat('Recovery Time'),
      wbFloat('Action Points Mult'),
      wbInteger('Stagger Offset', itS32, wbEnum([], [
        -2, '-2',
        -1, '-1',
         0, '0',
         1, '1',
         2, '2'
      ])),
      wbFloat('Strike Angle')
    ]),
    wbString(ATKE, 'Attack Event'),
    wbFormIDCk(ATKW, 'Weapon Slot', [EQUP]),
    wbFormIDCk(ATKS, 'Required Slot', [EQUP]),
    wbString(ATKT, 'Description')
  ], []);

  var wbLocationEnum := wbEnum([
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
   {14} 'Alias (ref collection)',
   {15} 'Unknown 15',
   {16} 'Unknown 16'
  ]);

  var wbObjectTypeEnum := wbEnum([
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

  var wbLocation :=
    function(aSignature : TwbSignature; aName: string = 'Location'): IwbSubRecordDef
    begin
      Result := wbStruct(aSignature, aName, [
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
          {8} wbInteger('Ref Alias', itS32, wbPackageLocationAliasToStr, wbStrToAlias),
          {9} wbInteger('Loc Alias', itS32, wbPackageLocationAliasToStr, wbStrToAlias),
         {10} wbInteger('Interrupt Data', itU32),
         {11} wbInteger('Packdata Target', itU32),
         {12} wbByteArray('Unknown', 4, cpIgnore),
         {13} wbByteArray('Unknown', 4),
         {14} wbInteger('Ref Collection Alias', itS32, wbPackageLocationAliasToStr, wbStrToAlias),
         {15} wbUnknown(4),
         {16} wbFormIDCkNoReach('Keyword', [KYWD])
        ]),
        wbFloat('Radius'),
        wbInteger('Collection Index', itU32)
      ], cpNormal, False, nil, 3)
       .SetSummaryKeyOnValue([0, 1])
       .SetSummaryPrefixSuffixOnValue(0,'[',']')
       .SetSummaryPrefixSuffixOnValue(1,'','')
       .IncludeFlagOnValue(dfSummaryMembersNoName);
    end;

  var wbPLDT := wbLocation(PLDT);
  var wbPLVD := wbLocation(PLVD, 'Vendor Location');

  var wbPTDA := wbStruct(PTDA, 'Target Data', [
    wbInteger('Type', itS32,
      wbEnum([], [
        0, 'Specific Reference',
        1, 'Object ID',
        2, 'Object Type',
        3, 'Linked Reference',
        4, 'Ref Alias',
        5, 'Interrupt Data',
        6, 'Self',
        7, 'Keyword',
        8, 'Ref Collection Alias',
        9, 'Scene Primary Actor'
      ]),
    cpNormal, False, nil, nil, 2),
    wbUnion('Target', wbTypeDecider, [
      {0} wbFormIDCkNoReach('Reference', sigReferences, True),
      {1} wbFormIDCkNoReach('Object ID', [NULL, ACTI, DOOR, STAT, MSTT, FURN, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, OMOD, BOOK, NOTE, KEYM, ALCH, INGR, LIGH, FACT, FLST, IDLM, TXST, PROJ, PKIN]),
      {2} wbInteger('Object Type', itU32, wbObjectTypeEnum),
      {3} wbFormIDCk('Keyword', [KYWD, NULL]),
      {4} wbInteger('Alias', itS32, wbPackageLocationAliasToStr, wbStrToAlias),
      {5} wbInteger('Interrupt Data', itU32),
      {6} wbByteArray('Unused', 4, cpIgnore), // padding unused by Self reference
      {7} wbFormIDCk('Keyword', [KYWD, NULL]),
      {8} wbInteger('Alias Collection', itS32, wbPackageLocationAliasToStr, wbStrToAlias),
      {9} wbByteArray('Unused', 4, cpIgnore) // padding unused by Scene Primary Actor
    ]),
    wbInteger('Count / Distance / Index', itS32)
  ]);

  var wbXLOC := wbStruct(XLOC, 'Lock Data', [
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
    wbInteger('Flags', itU8, wbFlags(['Unknown 0', '', 'Leveled Lock'])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbUnused(3),
    wbInteger('Unknown', itU32)
  ], cpNormal, False, nil, 4);

  var wbEITM := wbFormIDCk(EITM, 'Object Effect', [ENCH, SPEL]);

  var wbMODS := wbFloat(MODS, 'Color Remapping Index');
  var wbMO2S := wbFloat(MO2S, 'Color Remapping Index');
  var wbMO3S := wbFloat(MO3S, 'Color Remapping Index');
  var wbMO4S := wbFloat(MO4S, 'Color Remapping Index');
  var wbMO5S := wbFloat(MO5S, 'Color Remapping Index');

  var wbModelFlags := wbFlags([
    'Has FaceBones Model',
    'Support Model Only Swap'
  ]);

  var wbMODF := wbInteger(MODF, 'Flags', itU8, wbModelFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);
  var wbMO2F := wbInteger(MO2F, 'Flags', itU8, wbModelFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);
  var wbMO3F := wbInteger(MO3F, 'Flags', itU8, wbModelFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);
  var wbMO4F := wbInteger(MO4F, 'Flags', itU8, wbModelFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);
  var wbMO5F := wbInteger(MO5F, 'Flags', itU8, wbModelFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);
  var wbMO6F := wbInteger(MO6F, 'Flags', itU8, wbModelFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);
  var wbMO7F := wbInteger(MO7F, 'Flags', itU8, wbModelFlags).IncludeFlag(dfCollapsed, wbCollapseFlags);

  var wbMODC := wbFloat(MODC, 'Color Remapping Index');
  var wbMO2C := wbFloat(MO2C, 'Color Remapping Index');
  var wbMO3C := wbFloat(MO3C, 'Color Remapping Index');
  var wbMO4C := wbFloat(MO4C, 'Color Remapping Index');
  var wbMO5C := wbFloat(MO5C, 'Color Remapping Index');

  var wbFLLD := wbInteger(FLLD, 'Light Layer', itU32, wbFlags([
    'Default Light Layer',
    'Helmet Light',
    'Ship Interior',
    'Ship Exterior'
  ])).SetDefaultNativeValue(1).IncludeFlag(dfCollapsed, wbCollapseFlags);

  var wbDMDS := wbFormIDCk(DMDS, 'Material Swap', [NULL, MSWP]);
  var wbDMDC := wbFloat(DMDC, 'Color Remapping Index');

  {subrecords checked against Starfield.esm}
  var wbDEST := wbRStruct('Destructible', [
    wbStruct(DEST, 'Header', [
      wbInteger('Health', itS32),
      wbInteger('Stage Count', itU8).IncludeFlag(dfSkipImplicitEdit),
      wbInteger('Flags', itU8, wbFlags([
        'VATS Targetable',
        'Large Actor Destroys',
        'Resist All Except'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbUnused(2)
    ])
    .SetSummaryKeyOnValue([0,2])
    .SetSummaryPrefixSuffixOnValue(0,'Health ',' '),
    wbArrayS(DAMC, 'Resistances', wbStructSK([0], 'Resistance', [
      wbFormIDCk('Damage Type', [DMGT]),
      wbInteger('Value', itU32),
      wbUnknown(4)
    ])),
    wbFormIDCk(DSDL, 'Secondary Damage List', [SDLT]),
    wbRArray('Stages',
      wbRStruct('Stage', [
        wbStruct(DSTD, 'Data', [
          wbInteger('Health %', itU8),
          wbInteger('Index', itU8),
          wbInteger('Model Damage Stage', itU8),
          wbInteger('Flags', itU8, wbFlags([
            'Cap Damage',
            'Disable',
            'Destroy',
            'Ignore External Dmg',
            'Becomes Dynamic',
            'Object Cleared',
            'Fallback: Spawn At Bounds Center'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
          wbInteger('Self Damage per Second', itS32),
          wbFormIDCk('Explosion', [EXPL, NULL]),
          wbFormIDCk('Debris', [DEBR, NULL]),
          wbInteger('Debris Count', itS32),
          wbFloat('Replacement Model Delay')
        ], cpNormal, True)
        .SetSummaryKeyOnValue([0,5,6])
        .SetSummaryPrefixSuffixOnValue(0,'Health ','%')
        .SetSummaryDelimiterOnValue(', ')
        .IncludeFlagOnValue(dfSummaryExcludeNULL)
        .IncludeFlagOnValue(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed, wbCollapseDestruction)
        ,
        wbString(DSTA, 'Anim Event'),
        wbRStructSK([0], 'Model', [
          wbString(DMDL, 'Model FileName', 0, cpNormal, True),
          wbFLLD,
//          wbDMDT,
//          wbDMDC,
          wbDMDS.IncludeFlagOnValue(dfSummaryExcludeNULL)
        ], [], cpNormal, False, nil, True).IncludeFlag(dfCollapsed, wbCollapseModels),
        wbEmpty(DSTF, 'End Marker', cpNormal, True)
      ], [], cpNormal, False, nil)
      .SetSummaryKey([0,2]).IncludeFlag(dfSummaryMembersNoName)
    ).SetCountPath('...\DEST - Header\Stage Count')
  ], [], cpNormal, False, nil)
  .SetSummaryKey([3]);

  var wbDESTActor := wbRStruct('Destructible', [
    wbStruct(DEST, 'Header', [
      wbInteger('Health', itS32),
      wbInteger('Count', itU8),
      wbInteger('VATS Targetable', itU8, wbBoolEnum),
      wbUnused(2)
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
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
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
  ], []);

  var wbXESP := wbStruct(XESP, 'Enable State Parent', [
    wbFormIDCk('Reference', sigReferences),
    wbInteger('Flags', itU8, wbFlags([
      'Set Enable State to Opposite of Parent',
      'Pop In'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbUnused(3)
  ]);

  var wbPDTO :=
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

  var wbPDTOs := wbRArray('Topic', wbPDTO, cpNormal, False, nil);

  var wbFloatScale0to1 := wbNormalizeToRange(0.0, 1.0);
  var wbFloatScale0to10 := wbNormalizeToRange(0.0, 10.0);
  var wbFloatScale0to100 := wbNormalizeToRange(0.0, 100.0);

  var wbSNTP := wbFormIDCk(SNTP, 'Snap Template', [STMP]);
  var wbSNBH := wbFormIDCk(SNBH, 'Snap Behavior', [STBH]);
  var wbODTYReq := wbFloat(ODTY, 'Dirtiness Scale', cpNormal, True, 1, -1, nil, wbFloatScale0to1); // any record which can have ODTY should always have it
  var wbOPDS :=
    wbStruct(OPDS, 'Object Palette Defaults', [
      wbInteger('Flags', itU8, wbFlags([
        'Conform To Slope',
        '',
        'Rotate Z To Slope',
        'Slope Limit Is Min Slope',
        'Place As Marker',
        'Outside Water Height'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbUnused(3),
      wbFloat('Sink (Meters)'),
      wbFloat('Sink Variance +/-'),
      wbFloat('X/Y Offset Variance +/-'),
      wbInteger('Footprint (Meters)', itU32, wbEnum([], [ // looks like stored integer value but in CK is displayed as a float value but only allows certain values
        0, 'X-Large 51.0',
        1, 'Large 27.0',
        2, 'Medium 11.0',
        3, 'Small 7.0',
        5, 'None 0.0'
      ])),
      wbFloat('Scale % +/-'),
      wbFloat('Scale Variance +/-'),
      wbFloatAngle('Angle X (Deg)'),
      wbFloatAngle('Angle X Variance +/-'),
      wbFloatAngle('Angle Y (Deg)'),
      wbFloatAngle('Angle Y Variance +/-'),
      wbFloatAngle('Angle Z (Deg)'),
      wbFloatAngle('Angle Z Variance +/-'),
      wbFloat('Slope %'),
      wbFloat('Slope % Variance +/-'),
      wbFloat('Density'),
      wbFloat('Frequency %', cpNormal, False, 100),
      wbFloatAngle('Slope Limit'),
      wbFloat('Distance Below Water'),
      wbFloat('Distance Above Water')
    ])
      .IncludeFlag(dfCollapsed);
  var wbDEFL := wbFormIDCk(DEFL, 'Default Layer', [LAYR]);

  var wbPTT2 := wbStruct(PTT2, 'Transforms', [
    wbFormIDCk('Inventory Icon Transform', [NULL, TRNS]),
    wbFormIDCk('Workshop Icon Transform', [NULL, TRNS]),
    wbFormIDCk('Ship Builder Icon Transform', [NULL, TRNS]),
    wbFormIDCk('Preview Transform', [NULL, TRNS]),
    wbFormIDCk('Inventory 3D Override Transform', [NULL, TRNS]),
    wbFormIDCk('Workbench 3D Override Transform ', [NULL, TRNS]),
    wbFormIDCk('Data Menu 3D Override Transform', [NULL, TRNS]),
    wbFormIDCk('Research Menu 3D Override Transform', [NULL, TRNS])
  ])
  .SetSummaryKeyOnValue([0,1,2,3,4,5,6,7])
  .SetSummaryDelimiterOnValue(', ')
  .IncludeFlagOnValue(dfSummaryExcludeNULL)
  .IncludeFlag(dfCollapsed, wbCollapseTransforms);

  var wbXLCM := wbInteger(XLCM, 'Level Modifier', itS32, wbEnum([
    'Easy',
    'Medium',
    'Hard',
    'Very Hard'
  ]));

  var wbXOWN := wbStruct(XOWN, 'Ownership', [
    wbFormIDCkNoReach('Owner', [FACT, ACHR, NPC_]),
    wbByteArray('Unknown', 4),
    wbInteger('Flags', itU8, wbFlags(['No Crime'])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbUnused(3)
  ]);
  var wbXRNK := wbInteger(XRNK, 'Owner Faction Rank', itS32);

  var wbXEED :=
    wbStruct(XEED, 'External Emittance', [
    { 0} wbFloat('External Emittance Luminance Scale'),
    { 4} wbInteger('Override Enabled', itU8, wbBoolEnum),
    { 5} wbUnused(3)
    { 8}
    ]);

  var wbNVNM :=
    wbStruct(NVNM, 'Navmesh Geometry', [
      wbInteger('Version', itU32).SetDefaultNativeValue(17),
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
          wbByteArray('Vertex', 16),
        -1).IncludeFlag(dfNotAlignable),
        wbArray('Vertices',
          wbStruct('Vertex', [
            wbFloat('X'),
            wbFloat('Y'),
            wbFloat('Z'),
            wbUnknown(4)
          ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3),
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
            wbInteger('Edge 0-1', itU16, wbEdgeToStr0, wbEdgeToInt0).SetLinksToCallback(wbEdgeLinksTo0),
            wbInteger('Edge 1-2', itU16, wbEdgeToStr1, wbEdgeToInt1).SetLinksToCallback(wbEdgeLinksTo1),
            wbInteger('Edge 2-0', itU16, wbEdgeToStr2, wbEdgeToInt2).SetLinksToCallback(wbEdgeLinksTo2),
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
          wbByteArray('Cover', 12),
        -1).IncludeFlag(dfNotAlignable),
        wbArray('Cover Array',  // if navmesh version gt 12
          wbStruct('Cover', [
            //wbInteger('Vertex 0', itS16, wbVertexToStr0, wbVertexToInt0).SetLinksToCallback(wbVertexLinksTo),
            //wbInteger('Vertex 1', itS16, wbVertexToStr1, wbVertexToInt1).SetLinksToCallback(wbVertexLinksTo),
            wbByteArray('Unknown', 2),
            wbByteArray('Unknown', 2),
            wbByteArray('Unknown', 4),
            wbByteArray('Unknown', 4)
          ]),
        -1).IncludeFlag(dfNotAlignable)
      ),
      IfThen(wbSimpleRecords,
        wbArray('Cover Triangle Mappings',
          wbByteArray('Cover Triangle', 4),
        -1).IncludeFlag(dfNotAlignable),
        wbArray('Cover Triangle Mappings',
          wbStruct('Cover Triangle Map', [
            //wbInteger('Cover', itU16).SetLinksToCallback(wbCoverLinksTo),
            //wbInteger('Triangle', itU16).SetLinksToCallback(wbTriangleLinksTo)
            wbByteArray('Unknown', 2),
            wbByteArray('Unknown', 2)
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
            wbInteger('Triangle', itU16).SetLinksToCallback(wbTriangleLinksTo),
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
        wbVec3('Min'),
        wbVec3('Max'),
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
      ]),
      wbUnknown(2),
      wbUnknown(2)
    ]);

  var wbHNAMHNAM := wbRStruct('Head Tracking', [
    wbMarker(HNAM).SetRequired,
    wbArray(HTID, ' Aliases', wbInteger('Alias ID', itS32, wbSCENQuestAliasToStr, wbStrToAlias, cpNormal, True)
      .SetLinksToCallback(wbSCENAliasLinksTo)),
    wbEmpty(FNAM, 'Force Rotate'),
    wbEmpty(PNAM, 'Force Rotate Must Complete'),
    wbMarker(HNAM).SetRequired
  ], []).IncludeFlag(dfTemplate);
{
var
  _ReflectionChunkSignatures : TArray<TwbSignature>;
  _ReflectionChunkStructs    : TArray<IwbValueDef>;

function wbReflectionChunk(const aSignature : TwbSignature;
                           const aName      : string;
                           const aMembers   : array of IwbValueDef)
                                            : IwbStructDef;
var
  lMembers: TArray<IwbValueDef>;
begin
  SetLength(lMembers, Length(aMembers) + 2);
  lMembers[0] := wbString('Signature', 4);
  lMembers[1] := wbInteger('Size', itU32);
  for var lIdx := Low(aMembers) to High(aMembers) do
    lMembers[lIdx + 2] := aMembers[lIdx];
  Result := wbStruct(aName, lMembers)
    .SetSizeCallback(function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal
    begin
      Result := 0;
      if not Assigned(aBasePtr) then
        Exit;
      var lBasePtr: PCardinal := aBasePtr;
      Inc(lBasePtr);//skip signature
      Result := lBasePtr^ + 8;
    end);
  var lLength := Length(_ReflectionChunkSignatures);
  var lNewLength := Succ(lLength);
  SetLength(_ReflectionChunkSignatures, lNewLength);
  SetLength(_ReflectionChunkStructs,    lNewLength);
  _ReflectionChunkSignatures[lLength] := aSignature;
  _ReflectionChunkStructs[lLength] := Result;
end;
}

  var wbVatsValueFunctionEnum :=
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

  var wbActorValueEnum :=
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

  var wbSkillEnum :=
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

  var wbCastEnum := wbEnum([
    {0} 'Constant Effect',
    {1} 'Fire and Forget',
    {2} 'Concentration'
  ]);

  var wbTargetEnum := wbEnum([
    {0} 'Self',
    {1} 'Touch',
    {2} 'Aimed',
    {3} 'Target Actor',
    {4} 'Target Location'
  ]);

  var wbCastingSourceEnum := wbEnum([
    'Left',
    'Right',
    'Voice',
    'Instant'
  ]);

  var wbCrimeTypeEnum :=
    wbEnum([
      'Steal',
      'Pickpocket',
      'Trespass',
      'Attack',
      'Murder',
      'Escape Jail',
      'Werewolf Transformation',
      'Smuggling'
    ], [
      -1, 'None'
    ]);

  var wbKeywordTypeEnum :=
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
      {10} 'Attraction',
      {11} 'Dialogue Subtype',
      {12} 'Quest Target',
      {13} 'Anim Flavor',
      {14} 'Anim Gender',
      {15} 'Anim Face',
      {16} 'Quest Group',
      {17} 'Anim Injured',
      {18} 'Dispel Effect',
      {19} 'Crowd Target',
      {20} 'Exclusive Location Encounter',
      {21} 'Weapon Holster',
      {22} 'HUD Marker Override',
      {23} 'Interaction Root Offset',
      {24} 'Misc Item Quality',
      {25} 'Component Quantity',
      {26} 'Quest',
      {27} 'Faction',
      {28} 'Traversal',
      {29} 'Inventory Category',
      {30} 'Form Link',
      {31} 'Manufacturer',
      {32} 'UI Icon Personal Effect',
      {33} 'UI Icon Environment Effect',
      {34} 'Primitive',
      {35} 'Planet',
      {36} 'Planet Atmosphere',
      {37} 'Planet Atmosphere Toxicity',
      {38} 'Planet Gravity',
      {39} 'Planet Water Abundance',
      {40} 'Planet Water Quality',
      {41} 'Planet Magnetosphere',
      {42} 'Planet Flora Probability',
      {43} 'Planet Fauna Probability',
      {44} 'Planet Traits',
      {45} 'Planet Temperature',
      {46} 'Planet Pressure',
      {47} 'Planet Flora Abundance',
      {48} 'Planet Fauna Abundance',
      {49} 'Biome Marker',
      {50} 'Hand Scanner Info',
      {51} 'Ship Module Class',
      {52} 'Layered Material Swap Key',
      {53} 'UI Icon Linkage Name',
      {54} 'Mission',
      {55} 'Sound Engine',
      {56} 'Sound Engine Mod',
      {57} 'Sound Cockpit',
      {58} 'Sound Grav Drive',
      {59} 'Perk Trait Restriction',
      {60} 'Sound CCT Skin',
      {61} 'Sound CCT Size',
      {62} 'Sound CCT Speed',
      {63} 'PhotoMode Category',
      {64} 'Exclude From GI / Raytracing',
      {65} 'Include In GI / Raytracing',
      {66} 'Hair Color',
      {67} 'Facial Hair Color',
      {68} 'Eye Color',
      {69} 'Biome Houdini Style',
      {70} 'Anim Flavor (AnimObject)',
      {71} 'Brow Color',
      {72} 'Hair Subtype',
      {73} 'Facial Hair Subtype',
      {74} 'Brow Subtype',
      {75} 'AVMS Condition Sequence',
      {76} 'Biome Creature',
      {77} 'Ship Module Upgrade',
      {78} 'Display Name',
      {79} 'AVMS Appearance Variation Mod',
      {80} 'UI Icon Treatment',
      {81} 'Form Pair',
      {82} 'Item Description',
      {83} 'Weapon Display'

    ]);

  var wbETYP := wbFormIDCk(ETYP, 'Equipment Type', [EQUP, NULL]);
  var wbETYPReq := wbFormIDCk(ETYP, 'Equipment Type', [EQUP, NULL], False, cpNormal, True);

  var wbFormTypeEnum := wbEnum([], [
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

  var wbMiscStatEnum := wbEnum([], [
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

  var wbDialogueSubtypeEnum := wbEnum([],[
    Sig2Int('ACAC'), 'Actor Collidewith Actor',
    Sig2Int('ACYI'), 'Accept Yield',
    Sig2Int('AGRE'), 'Agree',
    Sig2Int('ALIL'), 'Alert Idle',
    Sig2Int('ALKL'), 'Ally Killed',
    Sig2Int('ALTC'), 'Alert To Combat',
    Sig2Int('ALTN'), 'Alert To Normal',
    Sig2Int('ASKF'), 'Retrieve',
    Sig2Int('ASKG'), 'Attack (Command)',
    Sig2Int('ASNC'), 'Assault NC',
    Sig2Int('ASSA'), 'Assault',
    Sig2Int('ASSI'), 'Assign',
    Sig2Int('ATCK'), 'Melee Attack',
    Sig2Int('AVTH'), 'Avoid Threat',
    Sig2Int('BAEX'), 'Barter Exit',
    Sig2Int('BASH'), 'Bash',
    Sig2Int('BGST'), 'Suppressive Fire',
    Sig2Int('BLED'), 'Bleed Out',
    Sig2Int('BLHE'), 'Blocking Hellos',
    Sig2Int('BLOC'), 'Block',
    Sig2Int('BREA'), 'Enter Sprint Breath',
    Sig2Int('BRIB'), 'Move',
    Sig2Int('COLO'), 'Combat To Lost',
    Sig2Int('COTN'), 'Combat To Normal',
    Sig2Int('CRIL'), 'Crippled Limb',
    Sig2Int('CUST'), 'Custom',
    Sig2Int('DEOB'), 'Destroy Object',
    Sig2Int('DETH'), 'Death',
    Sig2Int('DFDA'), 'Detect Friend Die',
    Sig2Int('ENBZ'), 'Enter Bow Zoom Breath',
    Sig2Int('ENKL'), 'Enemy Killed',
    Sig2Int('ENTE'), 'Enter',
    Sig2Int('EXBZ'), 'Exit Bow Zoom Breath',
    Sig2Int('FEXT'), 'Exit Favor State',
    Sig2Int('FIWE'), 'Shoot Near',
    Sig2Int('FLAT'), 'Follow',
    Sig2Int('FLBK'), 'Fallback',
    Sig2Int('FLEE'), 'Flee',
    Sig2Int('FRJT'), 'Reject',
    Sig2Int('FVDL'), 'Custom FVDL',
    Sig2Int('GBYE'), 'Goodbye',
    Sig2Int('GIFF'), 'Inspect',
    Sig2Int('GREE'), 'Greeting',
    Sig2Int('GRNT'), 'Combat Grunt',
    Sig2Int('HEAL'), 'Heal',
    Sig2Int('HELO'), 'Hello',
    Sig2Int('HIT_'), 'Hit',
    Sig2Int('IDAT'), 'Shared Info',
    Sig2Int('IDLE'), 'Idle',
    Sig2Int('IMNG'), 'Impatient Negative',
    Sig2Int('IMNU'), 'Impatient Neutral',
    Sig2Int('IMPT'), 'Impatient Positive',
    Sig2Int('IMQU'), 'Impatient Question',
    Sig2Int('INTI'), 'Call',
    Sig2Int('JUMP'), 'Jump',
    Sig2Int('KNOO'), 'Knock Over Object',
    Sig2Int('LOIL'), 'Lost Idle',
    Sig2Int('LOOB'), 'Locked Object',
    Sig2Int('LOTC'), 'Lost To Combat',
    Sig2Int('LOTN'), 'Lost To Normal',
    Sig2Int('LWBS'), 'Leave Water Breath',
    Sig2Int('MCO2'), 'Max Carbon Dioxide',
    Sig2Int('MREF'), 'Moral Refusal',
    Sig2Int('MUNC'), 'Murder NC',
    Sig2Int('MURD'), 'Murder',
    Sig2Int('NOTA'), 'Normal To Alert',
    Sig2Int('NOTC'), 'Normal To Combat',
    Sig2Int('NOTI'), 'Notice Corpse',
    Sig2Int('NOTL'), 'Normal To Lost',
    Sig2Int('OBCO'), 'Observe Combat',
    Sig2Int('ORAV'), 'Order Move Up',
    Sig2Int('ORFB'), 'Order Fallback',
    Sig2Int('ORFL'), 'Order Flank',
    Sig2Int('ORTC'), 'Order Take Cover',
    Sig2Int('OUTB'), 'Outof Breath',
    Sig2Int('PAAC'), 'Player Activate Activators',
    Sig2Int('PACO'), 'Player Activate Container',
    Sig2Int('PADR'), 'Player Activate Door',
    Sig2Int('PAFI'), 'Player Aquire Featured Item',
    Sig2Int('PAFU'), 'Player Activate Furniture',
    Sig2Int('PATR'), 'Player Activate Terminals',
    Sig2Int('PATT'), 'Paired Attack',
    Sig2Int('PCPS'), 'Player Cast Projectile Spell',
    Sig2Int('PCSH'), 'Player Shout',
    Sig2Int('PCSS'), 'Player Cast Self Spell',
    Sig2Int('PFGT'), 'Force Greet',
    Sig2Int('PICC'), 'Pickpocket Combat',
    Sig2Int('PICN'), 'Pickpocket NC',
    Sig2Int('PICT'), 'Pickpocket Topic',
    Sig2Int('PIRA'), 'Piracy',
    Sig2Int('PIRN'), 'Playerin Iron Sights',
    Sig2Int('POAT'), 'Power Attack',
    Sig2Int('PRJT'), 'Pathing Refusal',
    Sig2Int('PURS'), 'Pursue Idle Topic',
    Sig2Int('RANG'), 'Ranged Attack',
    Sig2Int('RCEX'), 'Recharge Exit',
    Sig2Int('RECH'), 'Recharge',
    Sig2Int('REEX'), 'Repair Exit',
    Sig2Int('REFU'), 'Refuse',
    Sig2Int('RELA'), 'Reload',
    Sig2Int('RELE'), 'Release',
    Sig2Int('REPA'), 'Repair',
    Sig2Int('RQST'), 'Cover Me',
    Sig2Int('RUMO'), 'Rumors',
    Sig2Int('SCCH'), 'Scene Choice',
    Sig2Int('SCDC'), 'Ship Crew Docking Complete',
    Sig2Int('SCDI'), 'Ship Crew Enemy Docking Initiated',
    Sig2Int('SCEN'), 'Custom Scene',
    Sig2Int('SCGC'), 'Ship Crew Grav Jump Completed',
    Sig2Int('SCJC'), 'Ship Crew Grav Jump Calculation Complete',
    Sig2Int('SCLS'), 'Ship Crew Landing Start',
    Sig2Int('SCRO'), 'Ship Crew Return To Orbit',
    Sig2Int('SCTI'), 'Ship Crew Take Off Initiated',
    Sig2Int('SCUC'), 'Ship Undocking Complete',
    Sig2Int('SEED'), 'Ship Enemy Engine Down',
    Sig2Int('SEER'), 'Ship Enemy Engine Repaired',
    Sig2Int('SEGD'), 'Ship Enemy Grav Jump Down',
    Sig2Int('SEGR'), 'Ship Enemy Grav Jump Repaired',
    Sig2Int('SERU'), 'Service Refusal',
    Sig2Int('SESD'), 'Ship Enemy Shields Down',
    Sig2Int('SESR'), 'Ship Enemy Shields Repaired',
    Sig2Int('SETD'), 'Ship Enemy Thrusters Down',
    Sig2Int('SETR'), 'Ship Enemy Thrusters Repaired',
    Sig2Int('SEWD'), 'Ship Enemy Weapons Down',
    Sig2Int('SEWR'), 'Ship Enemy Weapons Repaired',
    Sig2Int('SGNC'), 'Smuggling NC',
    Sig2Int('SHOW'), 'Show',
    Sig2Int('SHRE'), 'Show Relationships',
    Sig2Int('SHOK'), 'ElectromagneticShocked',
    Sig2Int('SHRP'), 'Ship Shields Repaired',
    Sig2Int('SMUG'), 'Smuggling',
    Sig2Int('SRTW'), 'React To Warn',
    Sig2Int('SSEC'), 'Ship Enter Combat',
    Sig2Int('SSED'), 'Ship Engines Down',
    Sig2Int('SSER'), 'Ship Engines Repaired',
    Sig2Int('SSGD'), 'Ship Grav Drive Down',
    Sig2Int('SSGR'), 'Ship Grav Drive Repaired',
    Sig2Int('SSLC'), 'Ship Leave Combat',
    Sig2Int('SSSD'), 'Ship Shields Down',
    Sig2Int('SSSZ'), 'Ship Shields ZeroHealth',
    Sig2Int('SSTD'), 'Ship Thrusters Down',
    Sig2Int('SSTR'), 'Ship Thrusters Repaired',
    Sig2Int('SSWD'), 'Ship Weapons Down',
    Sig2Int('SSWR'), 'Ship Weapons Repaired',
    Sig2Int('STAY'), 'Stay',
    Sig2Int('STEA'), 'Steal',
    Sig2Int('STEB'), 'Steal Takeback',
    Sig2Int('STFN'), 'Steal From NC',
    Sig2Int('STOF'), 'Standon Furniture',
    Sig2Int('STTB'), 'Steal Takeback Success',
    Sig2Int('SWMW'), 'Swing Melee Weapon',
    Sig2Int('TASF'), 'Take Suppressive Fire',
    Sig2Int('TAUT'), 'Taunt',
    Sig2Int('THGR'), 'Throw Grenade',
    Sig2Int('THRB'), 'Threat Backdown',
    Sig2Int('TITG'), 'Time To Go',
    Sig2Int('TRAD'), 'Trade',
    Sig2Int('TRAI'), 'Training',
    Sig2Int('TRAN'), 'Trespass Against NC',
    Sig2Int('TRAV'), 'Travel',
    Sig2Int('TRES'), 'Trespass',
    Sig2Int('TREX'), 'Training Exit',
    Sig2Int('TRNV'), 'Tresspass No Visual',
    Sig2Int('USMG'), 'Use Magic',
    Sig2Int('VPAW'), 'Vehicle Passenger Aim Mounted Weapon',
    Sig2Int('VPEB'), 'Vehicle Passenger Engage Boost',
    Sig2Int('VPEL'), 'Voice Power End Long',
    Sig2Int('VPES'), 'Voice Power End Short',
    Sig2Int('VPEV'), 'Vehicle Passenger Enter Vehicle',
    Sig2Int('VPEW'), 'Vehicle Passenger Enter Water',
    Sig2Int('VPHC'), 'Vehicle Passenger Horizontal Collision',
    Sig2Int('VPLV'), 'Vehicle Passenger Vertical Collision Low Velocity',
    Sig2Int('VPKC'), 'Vehicle Passenger Kill With Collision',
    Sig2Int('VPKW'), 'Vehicle Passenger Kill With Weapon',
    Sig2Int('VPNM'), 'Vehicle Passenger Non Moving Idle',
    Sig2Int('VPSL'), 'Voice Power Start Long',
    Sig2Int('VPSS'), 'Voice Power Start Short',
    Sig2Int('VPTM'), 'Vehicle Passenger Trigger Mine',
    Sig2Int('VPVC'), 'Vehicle Passenger Vertical Collision',
    Sig2Int('WFPI'), 'Waiting For Player Input',
    Sig2Int('WTCR'), 'Curious',
    Sig2Int('YIEL'), 'Yield',
    Sig2Int('ZKEY'), 'Z Key Object'
  ]);

  var wbAdvanceActionEnum := wbEnum([
    'Normal Usage',
    'Power Attack',
    'Bash',
    'Lockpick Success',
    'Lockpick Broken'
  ]);

  var wbCriticalStageEnum :=
    wbEnum([
      'None',
      'Goo Start',
      'Goo End',
      'Disintegrate Start',
      'Disintegrate End'
    ]);

  var wbStaggerEnum := wbEnum([
    'None',
    'Small',
    'Medium',
    'Large',
    'Extra Large'
  ]);

  var wbAttackSpeedEnum := wbEnum([
    'VerySlow',
    'Slow',
    'Medium',
    'Fast',
    'VeryFast'
  ]);

  var wbEFID := wbFormIDCk(EFID, 'Base Effect', [MGEF]);

  var wbEFIT :=
    wbStructSK(EFIT, [0,1,2], '', [
      wbFloat('Magnitude', cpNormal, True),
      wbFloat('Area'),
      wbInteger('Duration', itU32)
    ], cpNormal, True, nil, -1);

  var wbEventFunctionAndMemberEditInfo: string;

  var wbCTDAParamEvent :=  wbInteger('Event', itU32,
    function{wbEventFunctionAndMemberToStr}(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string
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
            slMember.AddStrings(wbEventMemberEnum.EditInfo[nil]);
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
    end,
    function{wbEventFunctionAndMemberToInt}(const aString: string; const aElement: IwbElement): Int64
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
    end);

  var wbCTDAParamQuestOverlay: TwbIntOverlayCallback :=
    function(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): Int64
    begin
      Result := aInt;
      if (aInt = 0) and (aType in [ctCheck, ctToStr, ctToSummary, ctToSortKey, ctLinksTo]) then begin
        if not Assigned(aElement) then
          Exit;
        var MainRecord := aElement.ContainingMainRecord;
        if not Assigned(MainRecord) then
          Exit;

        var GroupRecord : IwbGroupRecord;
        var Element     : IwbElement;
        if MainRecord.Signature = QUST then
          Result := MainRecord.FixedFormID.ToCardinal
        else if MainRecord.Signature = SCEN then begin
          Element := MainRecord.ElementBySignature[PNAM];
          if Assigned(Element) then
            Result := Element.NativeValue
          else
            if Supports(MainRecord.Container, IwbGroupRecord, GroupRecord) then
              if Supports(GroupRecord.ChildrenOf, IwbMainRecord, MainRecord) then
                if MainRecord.Signature = QUST then
                  Result := MainRecord.FixedFormID.ToCardinal
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
                  Result := Element.NativeValue
                else
                  if Supports(MainRecord.Container, IwbGroupRecord, GroupRecord) then
                    if Supports(GroupRecord.ChildrenOf, IwbMainRecord, MainRecord) then
                      if MainRecord.Signature = QUST then
                        Result := MainRecord.FixedFormID.ToCardinal
              end;
        end;
      end;
    end;

  var wbCTDA :=
    wbRStructSK([0], 'Condition', [
      wbStructSK(CTDA, [3, 5, 6], '', [
     {0}wbInteger('Type', itU8, wbCtdaTypeToStr, wbCtdaTypeToInt, cpNormal, False, nil, wbCtdaTypeAfterSet),
     {1}wbUnused(3),
     {2}wbUnion('Comparison Value', wbCTDACompValueDecider, [
          wbFloat('Comparison Value - Float'),
          wbFormIDCk('Comparison Value - Global', [GLOB])
        ]),
     {3}wbInteger('Function', itU16, wbCTDAFunctionToStr, wbCTDAFunctionToInt),
     {4}wbUnused(2),
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
          wbFormIDCkNoReach('Actor Base', [NPC_, NULL]),
          { 6 ptActorValue }
          wbActorValue(),
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
          wbFormIDCkNoReach('Cell', [CELL, NULL]),
          {14 ptClass}
          wbFormIDCkNoReach('Class', [CLAS, NULL]),
          {15 ptCrimeType}
          wbInteger('Crime Type', itU32, wbCrimeTypeEnum),
          {16 ptCriticalStage}
          wbInteger('Critical Stage', itU32, wbCriticalStageEnum),
          {17 ptEncounterZone}
          wbFormIDCkNoReach('Encounter Location', [LCTN]),
          {18 ptEquipType}
          wbFormIDCkNoReach('Equip Type', [EQUP]),
          {19 ptEvent}
          wbCTDAParamEvent,
          {20 ptEventData}
          wbFormID('Event Data'),
          {21 ptFaction}
          wbFormIDCkNoReach('Faction', [FACT, NULL]),
          {22 ptFormList}
          wbFormIDCkNoReach('Form List', [FLST, NULL]),
          {23 ptFormType}
          wbInteger('Form Type', itU32, wbFormTypeEnum),
          {24 ptFurniture}
          wbFormIDCkNoReach('Furniture', [FURN, FLST]),
          {25 ptFurnitureAnim}
          wbInteger('Furniture Anim', itU32, wbFurnitureAnimTypeEnum),
          {26 ptFurnitureEntry}
          wbInteger('Furniture Entry', itU32, wbEnum([], [
            $01, 'Front',
            $02, 'Behind',
            $04, 'Right',
            $08, 'Left',
            $10, 'Up'
          ])),
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
          {41 ptQuestStage - normally only in Param2!}
          wbInteger('Quest Stage', itU32),
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
          wbFormIDCkNoReach('Damage Type', [DMGT, FLST]),
          {57 ptResearchProject}
          wbFormIDCkNoReach('Research Project', [RSPJ]),
          {58 ptConditionForm}
          wbFormIDCkNoReach('Condition Form', [CNDF]),
          {59 ptPronoun}
          wbInteger('Pronouns', itU32, wbPronounEnum),
          {60 ptResource}
          wbFormIDCkNoReach('Resource', [IRES]),
          {61 ptPlanet}
          wbFormIDCkNoReach('Planet', [PNDT]),
          {62 ptDamageCauseType}
          wbInteger('DamageCauseType', itU32, wbDamageCauseTypeEnum),
          {63 ptSpeechChallenge}
          wbFormIDCkNoReach('Speech Challenge', [SPCH]),
          {63 ptForm}
          wbFormID('Form'),
          {64 ptAcousticSpace}
          wbFormIDCkNoReach('Acoustic Space', [ASPC]),
          {65 ptSnapTemplate}
          wbFormIDCkNoReach('Snap Template', [STMP]),
          {66 ptBiomeMask}
          wbByteArray('Biome Mask', 4),
          {67 ptPerkCategory}
          wbInteger('Perk Category', itU32, wbPerkCategoryEnum),
          {68 ptPerkSkillGroupComparison}
          wbInteger('Perk Skill Group Comparison', itU32, wbPerkSkillGroupEnum),
          {69 ptPerkSkillGroup}
          wbInteger('Perk Skill Group', itU32, wbPerkSkillGroupEnum),
          {70 ptReactionType}
          wbByteArray('Reaction Type', 4),
          {71 ptLimbCategory}
          wbByteArray('Limb Category', 4),
          {72 ptFactionOpt}
          wbFormIDCkNoReach('Faction', [NULL, FACT]),
          {73 ptGamePlayOption}
          wbFormIDCk('GamePlayOption', [GPOF])
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
          wbActorValue(),
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
          wbFormIDCkNoReach('Encounter Location', [LCTN]),
          {18 ptEquipType}
          wbFormIDCkNoReach('Equip Type', [EQUP]),
          {19 ptEvent}
          wbCTDAParamEvent,
          {20 ptEventData}
          wbFormIDCk('Event Data', [KYWD,LCTN,NULL]),
          {21 ptFaction}
          wbFormIDCkNoReach('Faction', [FACT, NULL]),
          {22 ptFormList}
          wbFormIDCkNoReach('Form List', [FLST]),
          {23 ptFormType}
          wbInteger('Form Type', itU32, wbFormTypeEnum),
          {24 ptFurniture}
          wbFormIDCkNoReach('Furniture', [FURN, FLST]),
          {25 ptFurnitureAnim}
          wbInteger('Furniture Anim', itU32, wbFurnitureAnimTypeEnum),
          {26 ptFurnitureEntry}
          wbInteger('Furniture Entry', itU32, wbEnum([], [
            $01, 'Front',
            $02, 'Behind',
            $04, 'Right',
            $08, 'Left',
            $10, 'Up'
          ])),
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
          wbInteger('Quest Stage', itU32,
            function(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string
            begin
              var lMainRecord: IwbMainRecord;

              var lContainer: IwbContainerElementRef;
              if wbTryGetContainerRefFromUnionOrValue(aElement, lContainer) then begin
                var lElement := lContainer.ElementByName['Parameter #1'];
                if not wbTryGetMainRecord(lElement, lMainRecord) then
                  lMainRecord := nil;
              end else
                lMainRecord := nil;

              Result := wbQuestStageToStr(aInt, aElement, aType, 'Quest in Parameter #1', lMainRecord, True);
            end, wbIntPrefixedStrToInt),
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
          wbFormIDCkNoReach('Damage Type', [DMGT, FLST]),
          {57 ptResearchProject}
          wbFormIDCkNoReach('Research Project', [RSPJ]),
          {58 ptConditionForm}
          wbFormIDCkNoReach('Condition Form', [CNDF]),
          {59 ptPronoun}
          wbInteger('Pronouns', itU32, wbPronounEnum),
          {60 ptResource}
          wbFormIDCkNoReach('Resource', [IRES]),
          {61 ptPlanet}
          wbFormIDCkNoReach('Planet', [PNDT]),
          {62 ptDamageCauseType}
          wbByteArray('DamageCauseType', 4),
          {63 ptSpeechChallenge}
          wbFormIDCkNoReach('Speech Challenge', [SPCH]),
          {63 ptForm}
          wbFormID('Form'),
          {64 ptAcousticSpace}
          wbFormIDCkNoReach('Acoustic Space', [ASPC]),
          {65 ptSnapTemplate}
          wbFormIDCkNoReach('Snap Template', [STMP]),
          {66 ptBiomeMask}
          wbByteArray('Biome Mask', 4),
          {67 ptPerkCategory}
          wbInteger('Perk Category', itU32, wbPerkCategoryEnum),
          {68 ptPerkSkillGroupComparison}
          wbInteger('Perk Skill Group Comparison', itU32, wbPerkSkillGroupEnum),
          {69 ptPerkSkillGroup}
          wbInteger('Perk Skill Group', itU32, wbPerkSkillGroupEnum),
          {70 ptReactionType}
          wbByteArray('Reaction Type', 4),
          {71 ptLimbCategory}
          wbByteArray('Limb Category', 4),
          {72 ptFactionOpt}
          wbFormIDCkNoReach('Faction', [NULL, FACT]),
          {73 ptGamePlayOption}
          wbFormIDCk('GamePlayOption', [GPOF])
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
          { 8} 'Command Target',
          { 9} 'Event Camera Ref',
          {10} 'My Killer',
          {11} 'Self Packin',
          {12} 'Target Packin',
          {13} 'My Ship',
          {14} 'Player Home Ship',
          {15} 'Player'
        ]), cpNormal, False, nil, wbCTDARunOnAfterSet),
        wbUnion('Reference', wbCTDAReferenceDecider, [
          wbInteger('Unused', itU32, nil, cpIgnore),
          wbFormIDCkNoReach('Reference', sigReferences, False)
        ])
          .SetDontShow(function(const aElement: IwbElement): Boolean
          begin
            Result := True;
            var lContainer: IwbContainer;
            if not Supports(aElement, IwbContainer, lContainer) then
              Exit;
            if lContainer.ElementValues['..\Run On'] = 'Reference' then
              Exit(False);
          end),
        wbUnion('Parameter #3', wbCTDAParam3Decider, [
          wbInteger('Parameter #3', itS32, nil, cpNormal, False, nil, nil, -1),
          wbFormIDCk('Linked Keyword', [KYWD, NULL])
        ])
      ], cpNormal, False{, nil, 0, wbCTDAAfterLoad}),
      wbString(CIS1, 'Parameter #1'),
      wbString(CIS2, 'Parameter #2')
    ], [], cpNormal)
      .SetToStr(wbConditionToStr)
      .SetSummaryLinksToCallback(wbConditionSummaryLinksTo)
      .IncludeFlag(dfCollapsed, wbCollapseConditions);

  var wbCTDAs := wbRArray('Conditions', wbCTDA, cpNormal, False);
  var wbCTDAsCount := wbRArray('Conditions', wbCTDA).SetCountPath(CITC);
  var wbCTDAsCountReq := wbRArray('Conditions', wbCTDA, cpNormal, True).SetCountPath(CITC);
  var wbCTDAsReq := wbRArray('Conditions', wbCTDA, cpNormal, True);

  var wbConditions := wbRStruct('Conditions', [
    wbCITCReq,
    wbCTDAsCountReq
  ], []);

  var wbPerkActivityTypes := [
    'Actor Value',
    'Apply Magic Effect',
    'Barter',
    'Bleedout',
    'Build Workshop Item',
    'Consume',
    'Craft',
    'Cripple Limb',
    'Destroy Ship',
    'Dock Ship',
    'Grav Jump',
    'Harvest',
    'Kill',
    'Land Planet',
    'Location Discovered',
    'Lockpick',
    'LootContainer',
    'Lose Enemy',
    'Player Pickpocket',
    'Produce',
    'Reload Weapon',
    'Research Completed',
    'Scan Planet',
    'Scan Surface',
    'ShipBuilder',
    'ShipCollection',
    'Speech Challenge',
    'Sprint',
    'Take Actor Damage',
    'Take Hit Damage'
    ];
  var wbATCP := wbInteger(ATCP, 'Activity Count', itU32, nil, cpBenign).IncludeFlag(dfSkipImplicitEdit);
  var wbATCPReq := wbInteger(ATCP, 'Activity Count', itU32, nil, cpBenign, True).IncludeFlag(dfSkipImplicitEdit);
  var wbATAN := wbRStruct('Activity', [
      wbString(ATAN, 'Activity Type')
        .SetFormaterOnValue(wbStringEnum(wbPerkActivityTypes))
        .SetRequired,
      wbFULL,
      wbDESC.SetRequired,
      wbRStructs('Progression Evaluator', 'Argument', [
        wbString(DNAM, 'Name').SetRequired,
        wbCITCReq,
        wbCTDAsCount.SetRequired(False)
      ], []).SetRequired,
      wbRStruct('Progression Configuration', [
        wbString(ANAM).SetRequired,
        wbString(ATAV, 'Configuration')
          .IncludeFlag(dfNoZeroTerminator)
          .SetRequired,
        wbEmpty(ATAF, 'Unknown').SetRequired // always empty
      ], []).SetRequired], []);
  var wbATANs := wbRArray('Activities', wbATAN, cpNormal, False);
  var wbATANsCount := wbRArray('Activities', wbATAN).SetCountPath(ATCP);
  var wbActivityTracker := wbRStruct('Activity Tracker', [
    wbATCPReq,
    wbATANsCount.SetRequired
  ], []);

  var wbICON := wbString(ICON, 'Inventory Image');
  var wbMICO := wbString(MICO, 'Message Icon');
  var wbPTRN := wbFormIDCk(PTRN, 'Preview Transform', [TRNS]);
  var wbSTCP := wbFormIDCk(STCP, 'Animation Sound', [STAG]);
  var wbNTRM := wbFormIDCk(NTRM, 'Native Terminal', [TMLM]);
  var wbINRD := wbFormIDCk(INRD, 'Instance Naming', [INNR]);

  var wbObjectProperty :=
    wbStructSK([0], 'Property', [
      wbActorValue(),
      wbFloat('Value'),
      wbFromVersion(152, wbFormIDCk('Curve Table', [CURV, NULL]))
    ]).SetToStr(wbObjectPropertyToStr).IncludeFlag(dfCollapsed, wbCollapseObjectProperties);

  var wbPRPS := wbArrayS(PRPS, 'Properties', wbObjectProperty);

  var wbCrowdProperty :=
    wbStructSK([0], 'Actor Data', [
      wbFormIDCk('Actor', [NPC_]),
      wbFloat('Value'),
      wbFromVersion(152, wbFormIDCk('Curve Table', [CURV, NULL]))
    ]).SetToStr(wbCrowdPropertyToStr).IncludeFlag(dfCollapsed, wbCollapseObjectProperties);

  var wbCrowdPRPS := wbArrayS(PRPS, 'Proportions', wbCrowdProperty);

  var wbFLTR := wbString(FLTR, 'Filter');
  var wbAPPR := wbArray(APPR, 'Attach Parent Slots', wbFormIDCk('Keyword', [KYWD]));
  var wbFTYP := wbArray(FTYP, 'Forced Location Ref Types', wbFormIDCk('Forced Location Ref Type', [LCRT]));
  var wbATTX := wbLStringKC(ATTX, 'Activate Text Override', 0, cpTranslate);

  var wbBNAMAnimation := wbRStruct('Animation', [
    wbFormIDCk(BNAM, 'NPC Anim', [NULL, IDLE]).SetRequired,             //BNAM  uint32 // +0x28 array; repeated; allocates new item for the array; value set to item+0x28 probably formid; kicks off component-style read
    wbString(STRV, 'Animation Subgraph'),                               //STRV  string
    wbFormIDCk(VCLR, 'Anim Body Archetype', [NULL, KYWD]).SetRequired,  //VCLR  uint32 // +0x30  probably formid
    wbFormIDCk(FLMV, 'Anim Face Archetype', [NULL, KYWD]).SetRequired,  //FLMV  uint32 // +0x38  probably formid
    wbFormIDCk(FLAV, 'Anim Flavor', [NULL, KYWD]).SetRequired,          //FALV  uint32 // +0x40  probably formid
    wbEmpty(QUAL, 'Use Dialogue Animation'),                            //QUAL  none // sets +0x58 to 1 (uint8/bool)
    wbEmpty(DOFT, 'Use Anim Body Archetype'),                           //DOFT  none // sets +0x59 to 1 (uint8/bool)
    wbEmpty(SOFT, 'Has Anim Face Archetype'),                           //SOFT  none // sets +0x5A to 1 (uint8/bool)
    wbEmpty(DPLT, 'Animation Complete Ends Phase'),                     //DPLT  none // sets +0x5B to 1 (uint8/bool) //does not occur in Starfield.esm
    wbEmpty(SPOR, 'Animation Only Movement'),                           //SPOR  none // sets +0x5C to 1 (uint8/bool)
    wbEmpty(OCOR, 'Use Flavor Anim'),                                   //not documented by gibbed, occurs in Starfield.esm
    wbFloat(LVCR, 'Delay Start Time Action').SetRequired,               //LVCR  uint32 // +0x50
    wbCTDAs,                                                            //CTDA  standard CTDA reading // +0x08
    wbFormIDCk(ATAC, 'Action', [NULL, AACT]).SetRequired,               //ATAC  uint32 // +0x48  probably formid
    wbEmpty(SHRT, 'Use Actor Anim Action'),                             //SHRT  none // sets +0x5F to 1 (uint8/bool)
    wbEmpty(PLRL, 'Animation Hold Event'),                              //PLRL  none // sets +0x5D to 1 (uint8/bool)
    wbUnknown(DTGT, 4),                                                 //DTGT  uint32 // +0x54 //does not occur in Starfield.esm
    wbEmpty(ACEP, 'Unknown'),                                           //ACEP  none // sets +0x5E to 1 (uint8/bool) //does not occur in Starfield.esm
    wbMarkerReq(XNAM)                                                   //XNAM  end marker for BNAM fields
  ], []);

{
  _ReflectionChunkSignatures := [NULL];
  _ReflectionChunkStructs    := [wbEmpty('Empty')];

  wbReflectionChunk(NULL, 'Unknown', [
    wbUnknown
  ]);

  wbReflectionChunk(BETH, 'Reflection Header', [
    wbInteger('Version', itU32),
    wbInteger('Chunk Count', itU32)
  ]);

  wbReflectionChunk(STRT, 'String Table', [
    wbArray('Strings', wbString('String'))
  ]);

  var wbStringTableLookup :=
    wbCallback( function(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string begin
      Result := '';
      if aInt < 0 then
        case aInt of
          Integer($FFFFFF01): Exit('Null');
          Integer($FFFFFF02): Exit('String');
          Integer($FFFFFF03): Exit('List');
          Integer($FFFFFF04): Exit('Map');
          Integer($FFFFFF05): Exit('Ref');
          Integer($FFFFFF08): Exit('Int8');
          Integer($FFFFFF09): Exit('UInt8');
          Integer($FFFFFF0A): Exit('Int16');
          Integer($FFFFFF0B): Exit('UInt16');
          Integer($FFFFFF0C): Exit('Int32');
          Integer($FFFFFF0D): Exit('UInt32');
          Integer($FFFFFF0E): Exit('Int64');
          Integer($FFFFFF0F): Exit('UInt64');
          Integer($FFFFFF10): Exit('Bool');
          Integer($FFFFFF11): Exit('Float');
          Integer($FFFFFF12): Exit('Double');
        else
          Exit('<unknown build-in type>');
        end;
      if not (aType in [ctToStr, ctToSortKey, ctToEditValue]) then
        Exit;
      if not Assigned(aElement) then
        Exit;
      var lContainer := aElement.Container;
      while Assigned(lContainer) do begin
        var lValueDef := lContainer.ValueDef;
        if not Assigned(lValueDef) then
          Exit;
        if (lValueDef.DefType = dtArray) and
           (lValueDef as IwbArrayDef).Element.Root.Equals(wbReflectionChunkUnion.Root)
        then
          Break;
        lContainer := lContainer.Container;
      end;
      var lContainerElementRef: IwbContainerElementRef;
      if not Supports(lContainer, IwbContainerElementRef, lContainerElementRef) then
        Exit;
      if lContainerElementRef.ElementCount < 2 then
        Exit;
      var lStringTableChunkUnion := lContainerElementRef.Elements[1];
      if not Supports(lStringTableChunkUnion, IwbContainerElementRef, lContainerElementRef) then
        Exit;
      if lContainerElementRef.ElementCount <> 1 then
        Exit;
      if not Supports(lContainerElementRef.Elements[0], IwbContainerElementRef, lContainerElementRef) then
        Exit;
      if lContainerElementRef.ElementCount < 3 then
        Exit;
      if lContainerElementRef.Elements[0].EditValue <> STRT then
        Exit;
      var lStringTable := lContainerElementRef.Elements[2];
      var lDataContainer: IwbDataContainer;
      if not Supports(lStringTable, IwbDataContainer, lDataContainer) then
        Exit;
      var lBasePtr: PAnsiChar := lDataContainer.DataBasePtr;
      //!!! this isn't safe access, should check against DataEndPtr and handle cases of missing terminating #0
      Result := PAnsiChar(@lBasePtr[aInt]);
    end, nil);

  wbReflectionChunk(&TYPE, 'Type', [
    wbInteger('Class Count', itU32)
  ]);

  wbReflectionChunk(CLAS, 'Class', [
    wbInteger('Name', itS32, wbStringTableLookup),
    wbInteger('Type', itU32, wbStringTableLookup),
    wbInteger('Flags', itU16, wbFlags([
      '',
      '',
      'User',
      'Struct'
    ])),
    wbArray('Fields', wbStruct('Field', [
      wbInteger('Name', itS32, wbStringTableLookup),
      wbInteger('Type', itS32, wbStringTableLookup),
      wbInteger('Offset', itU16),
      wbInteger('Size', itU16)
    ]), -2)
  ]);


  wbReflectionChunk(DIFF, 'Diff', [
    wbInteger('Type', itU32, wbStringTableLookup),
    wbArray('Fields', wbStruct('Field', [
      wbInteger('FieldIndex', itU16)
    ]))
  ]);


  wbReflectionChunkUnion :=
    wbUnion('', function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer begin
      Result := 0;
      if not Assigned(aBasePtr) then
        Exit;
      if NativeInt(aEndPtr) - NativeInt(aBasePtr) < 8 then
        Exit;
      Result := 1;
      for var lIdx := 2 to High(_ReflectionChunkSignatures) do
        if _ReflectionChunkSignatures[lIdx] = PwbSignature(aBasePtr)^ then
          Exit(lIdx);
    end, _ReflectionChunkStructs);
}
  var wbREFL := wbReflection(REFL);
  var wbRDIF := wbReflection(RDIF, 'Reflection Diff');

  var wbBaseFormComponents: IwbRecordMemberDef;

  var wbLinksToBluePrintComponent:TwbLinksToCallback  := function(const aElement: IwbElement): IwbElement
  begin
    if not Assigned(aElement) then
      Exit(nil);
    var lElementValue: Integer := aElement.NativeValue;
    if lElementValue < 0 then
      Exit(nil);
    var lContainer := aElement.Container;
    while Assigned(lContainer) do begin
      var lDef := lContainer.Def;
      if not Assigned(lDef) or (lDef.DefType = dtRecord) then
        Exit(nil);
      if lDef.Root.Equals(wbBaseFormComponents.Root) then
        Break;
      lContainer := lContainer.Container;
    end;
    if not Assigned(lContainer) then
      Exit(nil);
    for var lArrayIdx := 0 to Pred (lContainer.ElementCount) do begin
      var lComponentStruct: IwbContainerElementRef;
      if Supports(lContainer.Elements[lArrayIdx], IwbContainerElementRef, lComponentStruct) then begin
        var lBFCB := lComponentStruct.ElementBySignature[BFCB];
        if Assigned(lBFCB) and (lBFCB.Value = 'Blueprint_Component') then begin
          var lItems: IwbContainerElementRef;
          if Supports(lComponentStruct.ElementByPath['Component Data\BUO4 - Blue Print Components'], IwbContainerElementRef, lItems) then begin
            var lItemIdx := lElementValue;
            var lElementCount := lItems.ElementCount;
            lItemIdx := Min(lItemIdx, Pred(lElementCount));
            var lItem: IwbContainerElementRef;
            var lMoveBy := 0;
            repeat
              if Supports(lItems[lItemIdx], IwbContainerElementRef, lItem) then begin
                var lPart := lItem.ElementByName['Part ID'];
                if Assigned(lPart) then begin
                  var lPartValue: Integer := lPart.NativeValue;
                  var lDiff := lElementValue - lPartValue;
                  if lDiff = 0 then
                    Exit(lItem);
                  if lDiff < 0 then begin
                    if lMoveBy <= 0 then
                      lMoveBy := -1
                    else
                      Exit(nil);
                  end else begin
                    if lMoveBy >= 0 then
                      lMoveBy := 1
                    else
                      Exit(nil);
                  end;
                  lItemIdx := lItemIdx + lMoveBy;
                  if (lItemIdx < 0) or (lItemIdx >= lElementCount) then
                    Exit(nil);
                end;
              end else
                Exit(nil);
            until False;
          end;
        end;
      end;
    end;
    Result := nil;
  end;

  var wbTraversalData := wbStruct('Traversal', [
    wbUnknown(4),
    wbVec3('From'),
    wbVec3('To'),
    wbVec3,
    wbInteger('Flags', itU32, wbFlags([
      'Unknown 0',
      'Unknown 1',
      'No Traversal FormID'
    ]))
      .SetAfterSet(wbUpdateSameParentUnions)
      .IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbIsNotFlag(2, wbFormIDCk('Traversal', [TRAV])), //when they contain NULL, it's because Bethesda did an oopsie and don't calculated the length of their arrays correctly
    wbHalf,
    wbHalf,
    wbHalf,
    wbHalf
  ])
    .SetSummaryKey([1, 2, 5])
    .SetSummaryMemberPrefixSuffix(1, 'from ', '')
    .SetSummaryMemberPrefixSuffix(2, 'to ', '')
    .SetSummaryMemberPrefixSuffix(5, 'using ', '')
    .IncludeFlag(dfSummaryMembersNoName)
    .IncludeFlag(dfCollapsed)
    .IncludeFlag(dfExcludeFromBuildRef);

  var wbAngleToStr: TwbToStrCallback :=
    procedure(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType)
    begin
      var loFull := 360;
      var loHalf := 180;

      case aType of
        ctToStr, ctToSummary: begin
          var lVariant: Variant;
          if Assigned(aElement) then
            lVariant := aElement.NativeValue;

          if not VarIsFloat(lVariant) then
            Exit;

          var lValue: Extended := lVariant;

          var lAngle := lValue * wbRadiansToDegreesScale;
          while lAngle > loFull do
            lAngle := lAngle - loFull;
          while lAngle < -loFull do
            lAngle := lAngle + loFull;

          aValue := Format('%g'#$00B0, [ lAngle ]);
        end;
        ctFromEditValue: begin
          if not Assigned(aElement) then
            Exit;

          // Check length (at least one digit + degree symbol)
          if Length(aValue) < 2 then
            Exit;

          // Get position of degree symbol and check for presence
          var lPosDegree := Pos(#$00B0, aValue);
          if lPosDegree = 0 then
            Exit;

          // Check numeric value
          var lDeg := -1.0;
          try
            lDeg := StrToFloat(Copy(aValue, 1, lPosDegree - 1))
          except
            Exit
          end;

          if (lDeg < -loFull) or (lDeg > loFull) then
            Exit;

          // Return result
          aElement.NativeValue := lDeg / wbRadiansToDegreesScale;
          aValue := wbIgnoreStringValue;
        end;
      end;
    end;

  var wbLonLanFunc :=
    function(aIsLat: Boolean): TwbToStrCallback
    begin
      var loFull := 360;
      if aIsLat then
        loFull := loFull div 2;
      var loHalf := loFull div 2;

      var loNegDir: Char := 'W';
      var loPosDir: Char := 'E';
      if aIsLat then begin
        loNegDir := 'S';
        loPosDir := 'N';
      end;

      Result :=
        procedure(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType)
        begin
          case aType of
            ctToStr{, ctToEditValue}, ctToSummary{, ctToSortKey}: begin
              var lVariant: Variant;
              if Assigned(aElement) then
                lVariant := aElement.NativeValue;

              if not VarIsFloat(lVariant) then
                Exit;

              var lValue: Extended := lVariant;

              var lCoord := lValue * wbRadiansToDegreesScale;

              while lCoord > loHalf do
                lCoord := lCoord - loFull;
              while lCoord < -loHalf do
                lCoord := lCoord + loFull;

              var lCoordDeg := Trunc(lCoord);
              var lCoordMin := Trunc(Abs(lCoord - lCoordDeg) * 60);
              var lCoordSec := Round((Abs(lCoord - lCoordDeg) * 60 - lCoordMin) * 60);
              if lCoordSec = 60 then begin
                lCoordSec := 0;
                Inc(lCoordMin);
                if lCoordMin = 60 then begin
                  Inc(lCoordDeg);
                  lCoordMin := 0;
                end;
              end;

              if aType = ctToSortKey then
                aValue := IfThen(lCoord >= 0, '+', '-') + IntToHex(lCoordDeg, 2) + IntToHex(lCoordMin, 2) + IntToHex(lCoordSec, 2)
              else
                aValue := Format('%d'#$00B0'%d''%d"%s', [ Abs(lCoordDeg), lCoordMin, lCoordSec, IfThen(lCoord >= 0, loPosDir, loNegDir) ]);
            end;
            ctFromEditValue: begin
              if not Assigned(aElement) then
                Exit;

              // Check Length
              if Length(aValue) < 7 then
                Exit;

              // Get positions of symbols
              var lPosDegree := Pos(#$00B0, aValue);
              var lPosMinute := Pos('''', aValue);
              var lPosSecond := Pos('"', aValue);

              // Check Valid Symbols and Direction
              if (lPosDegree = 0) or (lPosMinute = 0) or (lPosSecond = 0) then
                Exit;

              var lDirection := aValue[Length(aValue)];
              if (lDirection <> loPosDir) and (lDirection <> loNegDir) then
                Exit;

              // Check Numeric Values
              var lDeg := StrToIntDef(Copy(aValue, 1, lPosDegree - 1), -1);
              var lMin := StrToIntDef(Copy(aValue, lPosDegree + 1, lPosMinute - lPosDegree - 1), -1);
              var lSec := StrToIntDef(Copy(aValue, lPosMinute + 1, lPosSecond - lPosMinute - 1), -1);

              if (lDeg < 0) or (lDeg >= loHalf+1) or
                 ((lDeg = loHalf) and ( (lMin > 0) or (lSec > 0) ) ) or
                 (lMin < 0) or (lMin > 59) or
                 (lSec < 0) or (lSec > 59)
              then
                Exit;

              // Conversion to Decimal Degrees and Return Result
              var lDecimalDeg := lDeg + (lMin / 60) + (lSec / 3600);
              if (lDirection = loNegDir) or (lDecimalDeg = 180.0)  then
                lDecimalDeg := -lDecimalDeg;

              aElement.NativeValue := lDecimalDeg / wbRadiansToDegreesScale;
              aValue := wbIgnoreStringValue;
            end;
          end;
        end;
    end;

  var wbLongitudeToStr := wbLonLanFunc(False);
  var wbLatitudeToStr := wbLonLanFunc(True);

  var wbLongitudeDouble := wbDouble('Longitude', cpNormal, True, 1, 12).SetToStr(wbLongitudeToStr);
  var wbLatitudeDouble := wbDouble('Latitude', cpNormal, True, 1, 12).SetToStr(wbLatitudeToStr);

  wbBaseFormComponents := wbRArray('Base Form Components',
    wbRStructSK([0], 'Component', [
      wbString(BFCB, 'Component Type').SetFormaterOnValue(wbStringEnum([
        'BGSActivityTracker',
        'BGSAddToInventoryOnDestroy_Component',
        'BGSAnimationGraph_Component',
        'BGSAttachParentArray_Component',
        'BGSBlockCellHeighGrid_Component',
        'BGSBlockEditorMetaData_Component',
        'BGSBodyPartInfo_Component',
        'BGSCityMapsUsage_Component',
        'BGSContactShadowComponent_Component',
        'BGSCrowdComponent_Component',
        'BGSDestructibleObject_Component',
        'BGSDisplayCase',
        'BGSEffectSequenceComponent',
        'BGSExternalComponentDataSource_Component',
        'BGSForcedLocRefType_Component',
        'BGSFormLinkData_Component',
        'BGSKeywordForm_Component',
        'BGSLinkedVoiceType_Component',
        'BGSLodOwner_Component',
        'BGSMaterialPropertyComponent',
        'BGSObjectPaletteDefaults_Component',
        'BGSObjectWindowFilter_Component',
        'BGSOrbitalDataComponent_Component',
        'BGSOrbitedDataComponent_Component',
        'BGSPapyrusScripts_Component',
        'BGSPathingData_Component',
        'BGSPlanetContentManagerContentProperties_Component',
        'BGSPrimitive_Component',
        'BGSPropertySheet_Component',
        'BGSScannable',
        'BGSShipManagement',
        'BGSSkinForm_Component',
        'BGSSoundTag_Component',
        'BGSSpacePhysicsComponent',
        'BGSSpaceshipAIActor_Component',
        'BGSSpaceshipEquipment_Component',
        'BGSSpaceshipHullCode_Component',
        'BGSSpaceshipWeaponBindings_Component',
        'BGSSpawnOnDestroy_Component',
        'BGSStarDataComponent_Component',
        'BGSStoredTraversals_Component',
        'BGSVehicleConfig',
        'BGSVehicleManagement',
        'BGSWorkshopItemColor',
        'BGSWorldSpaceOverlay_Component',
        'BlockHeightAdjustment_Component',
        'Blueprint_Component',
        'HoudiniData_Component',
        'LensFlareAttachmentFormComponent',
        'LightAnimFormComponent',
        'LightAttachmentFormComponent',
        'ParticleSystem_Component',
        'ReflectionProbes_Component',
        'SurfaceTreePatternSwapInfo_Component',
        'TESContainer_Component',
        'TESFullName_Component',
        'TESImageSpaceModifiableForm_Component',
        'TESMagicTargetForm_Component',
        'TESModel_Component',
        'TESPlanetModel_Component',
        'UniqueOverlayList_Component',
        'UniquePatternPlacementInfo_Component',
        'Volumes_Component'
      ]))
      .IncludeFlag(dfIncludeValueInDisplaySignature),
      wbRUnion('Component Data', [
        //BGSAnimationGraph_Component
        wbRStructSK([0,2], 'Component Data - Animation Graph', [
          wbString(ANAM, 'Root Animation Graph'),
          wbString(BNAM, 'Rig File'),
          wbString(CNAM, 'Animations Path'),
          wbString(DNAM, 'Response File'),
          wbEmpty(ENAM) // bool flag whose prescense indicates true
        ], [])
        .SetSummaryDelimiter(', ')
        .IncludeFlag(dfAllowAnyMember),
        //BGSAttachParentArray_Component
        wbRStruct('Component Data - Attach Parent', [
          wbAPPR
        ], []),
        //BGSActivityTracker
        wbRStruct('Component Data - Activity Tracker', [
          wbActivityTracker
        ], []),
        //Blueprint_Component
        wbRStruct('Component Data - Blue Print Components', [
          wbArray(BUO4, 'Blue Print Components',
            wbStruct('Item', [
              wbFormIDCk('Base Item', [GBFM]),
              wbFormIDCk('Construction Object', [NULL, COBJ]),
              wbVec3PosRot,
              wbInteger('Part ID', itU32)
            ])
            .SetSummaryKey([3, 0, 2, 1])
            .SetSummaryMemberPrefixSuffix(3, '[', ']')
            .SetSummaryMemberPrefixSuffix(0, '', '')
            .SetSummaryMemberPrefixSuffix(2, '', '')
            .SetSummaryMemberPrefixSuffix(1, '', '')
            .IncludeFlag(dfSummaryMembersNoName)
            .IncludeFlag(dfCollapsed, wbCollapseBluePrintItem)
          ),
          wbRStruct('Component Configurations', [
            wbInteger(BODM, 'Count', itU32).SetRequired,  // count for the following array of struct BODC+BODS/BODV
            wbRArray('Unknown', wbRStruct('Unknown', [
              wbInteger(BODC, 'Count', itU32).SetRequired, // count for the follow array of struct BODS/BODV
              wbRArrayS('Unknown', wbRStructSK([0], 'Unknown', [
                wbString(BODS, 'Name'),
                wbStruct(BODV, 'Configuration', [
                  wbFloatColors('Color 1'),
                  wbFloatColors('Color 2'),
                  wbFloatColors('Color 3'),
                  wbInteger('Unknown', itU32) // known values 0 - 7, possible enum?
                ])
                .SetSummaryKeyOnValue([0, 1, 2, 3])
                .IncludeFlag(dfSummaryMembersNoName)
                .IncludeFlag(dfHideText)
                .IncludeFlag(dfCollapsed)
              ], []), cpNormal, False, nil, wbBODSsAfterSet)
            ], []), cpNormal, False, nil, wbBODCsAfterSet).SetRequired
          ], []).SetRequired,
          wbInteger(BLUF, 'Unknown', itU8),
          wbInteger(BOID, 'Next Part ID', itU32)
        ], []).IncludeFlag(dfAllowAnyMember).IncludeFlag(dfStructFirstNotRequired),
        //BGSCityMapsUsage_Component
        wbRStruct('Component Data - City Map', [
          wbString(MOD2, 'Model Path', 260).IncludeFlag(dfHasZeroTerminator)
        ], []),

        //BGSCrowdComponent_Component
        wbRStruct('Component Data - Crowd', [
          wbFloat(CDND, 'Density'),
          wbInteger(CDNS, 'Populations Count', itU32),
          wbRStructs('Population Proportions', 'Population Proportion', [
            wbCrowdPRPS,
            wbCITCReq,
            wbCTDAsCount,
            wbString(STRV, 'Name'),
            wbFloat(FLTV, 'Population Scale')
          ], []).SetCountPath(CDNS)
        ], []),
        wbRStruct('Component Data - Container Items', [
          wbContainerItems
        ], []),

        wbRStruct('Component Data - DAT2', [
          wbUnion(DAT2, 'Data', wbBFCDAT2Decider, [
        {0} wbUnknown,
            //BlockHeightAdjustment_Component
        {1} wbStruct('Block Height Adjustments', [
              wbArray('Rows',
                wbArray('Columns',
                  wbStruct('Block Height Adjustment', [
                    wbFloat,
                    wbFloat
                  ]).IncludeFlag(dfCollapsed)
                , 16).IncludeFlag(dfCollapsed)
              , 16).IncludeFlag(dfCollapsed)
            ])
            .SetSummaryKey([0])
            .IncludeFlag(dfSummaryMembersNoName)
            .IncludeFlag(dfCollapsed),
            // SurfaceTreePatternSwapInfo_Component
        {2} wbStruct('Surface Tree Pattern Swap', [
              wbUnknown
              {wbArray('Forms', wbStruct('Form', [
                wbFormIDCk('Pattern', [SFPT]),
                wbInteger('Unknown', itS8),
                wbUnknown(4)
              ]), -1)}
            ]),
            //BGSBlockEditorMetaData_Component
        {3} wbStruct('Block Creation Meta Data', [
              wbLenString('Created Time'),
              wbInteger('Source Type', itU8, wbEnum([], [
                1, 'Block',
                6, 'Planet'
              ])),
              wbLenString('Also Created Time'),
              wbLenString('Source Editor ID'),
              wbArray('Unknown', wbStruct('Unknown', [
//                wbFormIDCk('Source Block', [SFBK]),
                wbUnknown(4), // Appears to usually point at the same FormID of the source block. Though sometimes a random REFR or a broken ID. Inconsistent, but it's a read only reference data point not used in gameplay.
                wbUnknown(1)
              ]), -1).IncludeFlag(dfNotAlignable),

              wbInteger('Location X', itS32),
              wbInteger('Location Y', itS32),
              wbInteger('Planet System ID', itS32),
              wbInteger('Satellite ID', itS32),
              wbLongitudeDouble,
              wbLatitudeDouble    // There is one vanilla record which has a very old date where the data structure is 8 bytes short. Possibly they used 2 floats instead of 2 doubles for lon/lat.
            ], cpNormal, False, nil, 9)

          ]).IncludeFlag(dfUnionStaticResolve)
        ], []),
        //BGSStarDataComponent_Component
        //BGSOrbitedDataComponent_Component
        wbRStruct('Component Data - DATA', [
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
              wbDouble('Gravity Well', cpNormal, False, 1, Low(Integer)),
              wbFloat('Mass (in SM)', cpNormal, False, 1/1.98847E30, 2),
//              wbFloat('Mass (in Earth Masses)', cpNormal, False, 1/5.972E24, 3),
              wbFloat('Radius (in km)'),
              wbFloat('Surface Gravity')
            ]),
            //BGSOrbitalDataComponent_Component
            wbStruct('', [
              wbDouble('Major Axis', cpNormal, False, 1, Low(Integer)),
              wbDouble('Minor Axis', cpNormal, False, 1, Low(Integer)),
              wbDouble('Aphelion', cpNormal, False, 1, Low(Integer)),
              wbDouble('Eccentricity', cpNormal, False, 1, Low(Integer)),
              wbDouble('Incline', cpNormal, False, 1, Low(Integer)).SetToStr(wbAngleToStr),
              wbDouble('Mean Orbit', cpNormal, False, 1, Low(Integer)),
              wbFloat('Axial Tilt').SetToStr(wbAngleToStr),
              wbFloat('Rotational Velocity'),
              wbInteger('Apply Orbital Velocity', itU8, wbBoolEnum),
              wbInteger('Geostationary Orbit', itU8, wbBoolEnum)
            ]),
            //UniqueOverlayList_Component
            wbStruct('', [
              wbArray('Worldspaces',
                wbStruct('Worldspace', [
                  wbFormIDCk('Worldspace', [WRLD]),
                  wbInteger('Grid Y', itS32),
                  wbInteger('Grid X', itS32)
                ])
              , -1).IncludeFlag(dfNotAlignable)
            ]),
            //UniquePatternPlacementInfo_Component
             wbStruct('', [
              wbFormIDCK('Planet', [PNDT, NULL]),
              wbStruct('Position', [
                wbLongitudeDouble,
                wbLatitudeDouble
              ])
                .SetSummaryKey([1, 0])
                .SetSummaryMemberPrefixSuffix(1, '(', '')
                .SetSummaryMemberPrefixSuffix(0, '', ')')
                .SetSummaryDelimiter(', ')
                .IncludeFlag(dfSummaryMembersNoName)
                .IncludeFlag(dfCollapsed, wbCollapsePosRot)
            ])
          ]).IncludeFlag(dfUnionStaticResolve)
        ], []),
        //BGSDisplayCase
        wbRStruct('Component Data - Display Case', [
          wbArray(DCSD, 'Display Case Slot Snap Templates', // DO NOT SORT. The later DCED exclusivity uses the same order as here
            wbStruct('Template Slot', [
              wbFormIDCk('Display Filter', [FLST]),
              wbFormIDCk('Exclusion Filter Keyword', [NULL, KYWD]),
              wbInteger('Display Slot', itU32),
              wbInteger('Number', itU32)
            ])
            .SetSummaryKey([0,2,1,3])
            .SetSummaryMemberPrefixSuffix(2, 'Slot: ','')
            .SetSummaryMemberPrefixSuffix(1, 'Excl: ','')
            .SetSummaryMemberPrefixSuffix(3, 'No: ','')
            .IncludeFlag(dfSummaryMembersNoName)
            .IncludeFlag(dfSummaryExcludeNULL)
            ),
          wbArray(DCED, 'Exclusivity',  // DO NOT SORT. The earlier DCSD uses the same order as here
            wbArray('Template Slot', wbInteger('Exclusive Display Slot', itU32), -1) // DO NOT SORT this is intentionally ordered in CK
          )
        ], []),
        //BGSDestructibleObject_Component
        wbRStruct('Component Data - Destructible', [
          wbDest
        ], []),
        //BGSSpaceshipEquipment_Component
        wbRStruct('Component Data - Spaceship Equipment', [
          wbInteger(ESSF, 'Essential Flag', itU32, wbBoolEnum)
        ], []),
        //BGSExternalComponentDataSource_Component
        wbRStruct('Component Data - External Data Source', [
          wbFormIDCk(EXDC, 'External Base Template', [NULL, GBFM, LVLB]).SetRequired,
          wbRStruct('External Data Sources', [
            wbInteger(EXDZ, 'Data Source Count', itU32).SetRequired.IncludeFlag(dfSkipImplicitEdit), // count for EXCN/EXCI struct array
            wbRArray('External Sources',
              wbRStruct('Component', [
                wbString(EXCN, 'Component Name').SetRequired,
                wbFormIDCk(EXCI, 'Component Source', [GBFM, LVLB]).SetRequired
              ], [])
            ).SetCountPath(EXDZ)
          ], []).SetRequired,
          wbRstruct('Unknown', [
            wbInteger(EXAC, 'Count', itU32).SetRequired.IncludeFlag(dfSkipImplicitEdit), // count for EXAS array
            wbRArray('Unknown', wbString(EXAS), cpNormal, False, nil).SetCountPath(EXAC)
          ], []).SetRequired,
          wbString(EXBS).SetRequired
        ], []),
        //BGSLinkedVoiceType_Component
        wbRStruct('Component Data - Linked Voice Type', [
          wbFormIDCk(FCTF, 'Voice Type', [NULL, VTYP])
        ], []),
        //BGSContactShadowComponent_Component
        wbRStruct('Component Data - Contact Shadow', [
          wbStruct(FLCS, 'Contact Shadows', [
            wbFloat('Thickness'),
            wbFloat('Fade Length'),
            wbFloat('Fade Start'),
            wbFloat('Max Distance'),
            wbFloat('Proximity Limit')
          ])
        ], []),
        wbRStruct('Component Data - FLLD', [
          wbFLLD
        ], []),
        wbRStruct('Component Data - FTYP', [
          wbFTYP
        ], []),
        //TESFullName_Component
        wbRStruct('Component Data - Fullname', [
          wbFULL
        ], []),
        wbRStruct('Component Data - GNAM', [
          wbUnknown(GNAM)
        ], []),
        //BGSSpaceshipHullCode_Component
        wbRStruct('Component Data - Spaceship Hull Code', [
          wbLStringKC(HULL, 'Hull Code', 0, cpTranslate)
        ], []),
        //BGSAddToInventoryOnDestroy_Component
        wbRStructSK([0],'Component Data - Add to inventory on destroy', [
          wbFormIDCk(INAM, 'Add to inventory on destroy', [LVLI])
        ], []),
        //BGSObjectWindowFilter_Component
        wbRStruct('Component Data - Object Window Filter', [
          wbInteger(INTV, 'Count', itU32),
          wbRArrayS('Filters', wbString(FLTR, 'Filter')).SetCountPath(INTV)
        ], []),
        //BGSFormLinkData_Component
        wbRStruct('Component Data - Form Links', [
          wbInteger(ITMC, 'Count', itU32),
          wbRArray('Linked Forms', wbRStruct('Linked Form', [
            wbFormIDCk(FLKW,'Keyword', [KYWD]),
            wbFormID(FLFM, 'Linked Form')
          ], []))
        ], []),
        wbRStructSK([0], 'Component Data - Keywords', [
          wbKeywords
        ], []),
        //TESImageSpaceModifiableForm_Component
        wbRStructSK([0],'Component Data - Image Space Adapter', [
          wbFormIDCk(MNAM, 'Image Space Adapter', [IMAD])
        ], []),
        //TESPlanetModel_Component
        wbRStruct('Component Data - Planet Model', [
          wbString(MODL, 'Model'),
          wbFLLD,
          wbStruct(XMPM, 'Unknown', [
            wbArray('Unknown', wbLenString('Unknown', 2), -2),
            wbArrayS('Unknown', wbStructSK([0], 'Unknown', [
              wbLenString('Resource:ID', 2),
              wbInteger('File Hash', itU32, wbFileHashCallback),
              wbString('Extension', 4),
              wbInteger('Folder Hash', itU32, wbFolderHashCallback)
            ]), -2)
          ]),
          wbString(MCQP, 'Ring model'),
          wbString(XMSP, 'Ring material'),
          wbString(XLMS, 'Ring id')
        ], []),
        //BGSObjectPaletteDefaults_Component
        wbRStruct('Component Data - Object Placement Defaults', [
          wbOPDS
        ], []),
        //HoudiniData_Component
        wbRStruct('Component Data - Houdini Data', [
          wbReflection(PCCC)
        ], []),
        //BGSPropertySheet_Component
        wbRStruct('Component Data - Property Sheet', [
          wbPRPS
        ], []),
        //ParticleSystem_Component
        wbRStruct('Component Data - Particle System', [
          wbReflection(PTCL)
        ], []),
        //BGSLodOwner_Component
        //BGSEffectSequenceComponent
        wbRStruct('Component Data - Reflection', [
          wbREFL
        ], []),
        //BGSSpaceshipAIActor_Component
        wbRStruct('Component Data - Spaceship AI Actor', [
          wbFormIDCk(SAIA, 'Spaceship AI Actor', [NPC_])
        ], []),
        //BGSSpaceshipWeaponBindings_Component
        wbRStruct('Component Data - Spaceship Weapon Bindings', [
          wbStruct(SHWB, 'Ship Weapon Binding', [
            wbInteger('Weapon Slot 1', itS32).SetLinksToCallback(wbLinksToBluePrintComponent).SetToStr(wbToStringFromLinksToSummary),
            wbInteger('Weapon Slot 2', itS32).SetLinksToCallback(wbLinksToBluePrintComponent).SetToStr(wbToStringFromLinksToSummary),
            wbInteger('Weapon Slot 3', itS32).SetLinksToCallback(wbLinksToBluePrintComponent).SetToStr(wbToStringFromLinksToSummary)
          ])
        ], []),
        //BGSWorldSpaceOverlay_Component
        wbRStruct('Component Data - Worldspace Overlay', [
          wbInteger(SNAM, 'Star System ID', itS32, wbStarIDToStr, wbStrToStarID)
            .SetLinksToCallbackOnValue(wbStarSystemLookupCallback()),
          wbInteger(PNAM, 'Planet ID', itS32),
          wbFormIDCk(BNAM, 'Surface Block', [SFBK])
        ], []),
        //BGSSpawnOnDestroy_Component
        wbRStructSK([0],'Component Data - Spawn on destroy', [
          wbFormIDCk(SODA, 'Spawn on destroy', sigBaseObjects)
        ], []),
        //BGSSoundTag_Component
        wbRStructSK([0], 'Component Data - Sound Tag', [
          wbSTCP
        ], []),
        //BGSStoredTraversals_Component
        wbRStruct('Component Data - Stored Traversals', [
          wbStruct(STRD, 'Stored Traversal Data', [
            wbArray('Unknown', wbTraversalData, -1)
            .IncludeFlag(dfFastAssign)
            .IncludeFlag(dfCollapsed)
            .IncludeFlag(dfNotAlignable),
            wbArray('Unknown',
              wbStruct('Unknown', [
                wbFormIDCk('Unknown', [ACTI, REFR]),
                wbVec3,
                wbArray('Unknown', wbTraversalData, -1)
                .IncludeFlag(dfCollapsed)
                .IncludeFlag(dfNotAlignable)
              ])
              .SetSummaryKey([0])
              .SetSummaryMemberPrefixSuffix(0, '', '')
              .IncludeFlag(dfSummaryMembersNoName)
              .IncludeFlag(dfCollapsed)
            , -1)
            .IncludeFlag(dfFastAssign)
            .IncludeFlag(dfCollapsed)
            .IncludeFlag(dfNotAlignable)
          ])
          .IncludeFlag(dfExcludeFromBuildRef)
          .IncludeFlag(dfFastAssign)
        ], []),
        //Volumes_Component
        wbRStruct('Component Data - Volumes', [
          wbStruct(VLMS, 'Unknown', [
            wbArray('Unknown', wbStruct('Unknown', [
              wbInteger('Type', itU32, wbEnum([], [
                $1, '1',
                $3, '3',
                $5, '5'
              ])).SetAfterSet(wbUpdateSameParentUnions),
              wbArray('Matrix', wbStruct('Matrix', [
                wbFloat,
                wbFloat,
                wbFloat,
                wbFloat
              ])
              .SetSummaryKey([0, 1, 2, 3])
              .SetSummaryDelimiter(', ')
              .IncludeFlag(dfSummaryMembersNoName)
              .IncludeFlag(dfSummaryNoSortKey)
              .IncludeFlag(dfCollapsed, wbCollapseItems), 4),
              wbFloat,
              wbFloat,
              wbFloat,
              wbUnion('Unknown', wbVLMSTypeDecider, [
                wbStruct('Unknown', [
                  wbFloat               // type 1
                ]),
                wbStruct('Unknown', [   // type 3
                  wbFloat,
                  wbFloat
                  ]),
                wbStruct('Unknown', [   // type 5
                  wbFloat,
                  wbFloat,
                  wbFloat
                ])
              ])
            ]), -1)
          ])
        ], []),
        //BGSPlanetContentManagerContentProperties_Component
        wbRStruct('Component Data - Planet Content Manager Content Properties', [
          wbUnknown(ZNAM, 4), // presume this is the Days Until Reset manual value but CK doesn't save when putting one in
          wbInteger(YNAM, 'Do All Before Repeating', itU8, wbBoolEnum),
          wbInteger(XNAM, 'Number of Times Allowed (Global)', itU32),
          wbInteger(WNAM, 'Number of Times Allowed (per system)', itU32),
          wbInteger(VNAM, 'Save Placement', itU8, wbBoolEnum),
          wbFormIDCk(UNAM, 'Days Until Reset GLOB', [NULL, GLOB]),
          wbFloat(NAM1, 'Minimum Density Chance'),
          wbFormIDCk(NAM2, 'Minimum Density Chance GLOB', [NULL, GLOB]),
          wbInteger(NAM3, 'Number of Times Allowed (per planet)', itU32),
          wbByteColors(NAM4, 'Debug Color'),
          wbFormIDCk(NAM5, 'Number of Times Per Request Curve', [CURV, NULL]),
          wbFormIDCk(NAM6, 'Spawn Groups Limit Curve', [CURV, NULL]),
          wbFormIDCk(NAM7, 'Spawn Group Distance Override Curve', [CURV, NULL]),
          wbInteger(NAM8, 'Allow Invalid Biome Markers', itU8, wbBoolEnum),
          wbInteger(NAM9, 'Number of Times Allowed (per planet world)', itU32),
          wbCITCReq,
          wbCTDAsCount
        ], []),
        //BGSVehicleConfig
        wbRStruct('Component Data - Vehicle Config', [
          wbArray(VCSB, 'Suspension Bone Modifiers',
            wbFormIDCk('Bone Modifier', [BMOD])
          ).IncludeFlag(dfCollapsed),
          wbStruct(VCCD, 'Vehicle Config Data', [
            wbStruct('Node Names', [
              wbStruct('Suspension', [
                wbLenString('Front Left'),
                wbLenString('Front Right'),
                wbLenString('Rear Left'),
                wbLenString('Rear Right')
              ]).IncludeFlag(dfCollapsed),
              wbStruct('Wheel', [
                wbLenString('Front Left'),
                wbLenString('Front Right'),
                wbLenString('Rear Left'),
                wbLenString('Rear Right')
              ]).IncludeFlag(dfCollapsed)
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Chassis', [
              wbInteger('Forward Axis', itU32),
              wbInteger('Up Axis', itU32),
              wbFloat('Vehicle Mass'),
              wbFloat('Friction Equalizer'),
              wbStruct('Torque', [
                wbFloat('Roll'),
                wbFloat('Pitch'),
                wbFloat('Yaw')
              ]).IncludeFlag(dfCollapsed),
              wbStruct('Inertia', [
                wbFloat('Yaw'),
                wbFloat('Roll'),
                wbFloat('Pitch')
              ]).IncludeFlag(dfCollapsed),
              wbFloat('Extra Torque'),
              wbFloat('Max Velocity Positional Friction'),
              wbFloat('Friction'),
              wbFloat('Restitution'),
              wbFloat('COM Offset Forward'),
              wbFloat('COM Offset Up')
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Wheel', [
              wbFloat('Slip Angle'),
              wbFloat('Friction'),
              wbFloat('Scale'),
              wbFloat('Mass'),
              wbFloat('Viscosity Friction'),
              wbInteger('Wheel Cast Type', itS32)
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Suspension', [
              wbFloat('Strength'),
              wbFloat('Damping Compression'),
              wbFloat('Damping Relaxation'),
              wbFloat('Length'),
              wbStruct('Offsets', [
                wbFloat('Up Front'),
                wbFloat('Up Back'),
                wbFloat('Front'),
                wbFloat('Back'),
                wbFloat('Lateral')
              ]).IncludeFlag(dfCollapsed)
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Steering', [
              wbFloat('Max Angle'),
              wbFloat('Max Angle at Max Speed')
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Engine', [
              wbFloat('Max Speed'),
              wbFloat('Max Torque'),
              wbFloat('Min RPM'),
              wbFloat('Max RPM'),
              wbFloat('Opt RPM'),
              wbStruct('Torque', [
                wbFloat('Min RPM'),
                wbFloat('Max RPM')
              ]).IncludeFlag(dfCollapsed),
              wbStruct('Resistance', [
                wbFloat('Min RPM'),
                wbFloat('Max RPM'),
                wbFloat('Opt RPM')
              ]).IncludeFlag(dfCollapsed)
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Transmission', [
              wbFloat('Downshift RPM'),
              wbFloat('Upshift RPM'),
              wbFloat('Clutch Delay Time'),
              wbStruct('Gear Ratios', [
                wbFloat('Reverse'),
                wbFloat('First'),
                wbFloat('Second'),
                wbFloat('Third'),
                wbFloat('Fourth')
              ]).IncludeFlag(dfCollapsed),
              wbStruct('Torque Ratios', [
                wbFloat('Front Wheels'),
                wbFloat('Back Wheels')
              ]).IncludeFlag(dfCollapsed)
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Brakes', [
              wbFloat('Max Torque'),
              wbFloat('Min Pedal Input To Block'),
              wbFloat('Wheels Min Time To Block')
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Aerodynamics', [
              wbFloat('Air Density'),
              wbFloat('Front Area'),
              wbFloat('Drag Coefficient'),
              wbFloat('Lift Coefficient'),
              wbFloat('Extra Gravity Multiplier')
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Velocity Damping', [
              wbFloat('Normal Spin'),
              wbFloat('Collision Spin'),
              wbFloat('Collision Threshold')
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Handling', [
              wbFloat('Reorient Strength'),
              wbFloat('Reorient Damping'),
              wbFloat('Vertical Boost Force'),
              wbFloat('Forward Boost Force'),
              wbFloat('Boost Max Velocity'),
              wbFloat('Boost Duration'),
              wbFloat('Vertical Boost Duration'),
              wbFloat('Boost Recharge Delay'),
              wbFloat('Boost Recharge Duration')
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Water', [
              wbFloat('Strength Front'),
              wbFloat('Strength Back'),
              wbFloat('Damp Front'),
              wbFloat('Damp Back'),
              wbFloat('Drive'),
              wbFloat('Rotation Damp')
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Bumper', [
              wbInteger('Enable Bumper', itU8, wbBoolEnum),
              wbFloat('Forward'),
              wbFloat('Up'),
              wbFloat('Width'),
              wbFloat('Radius')
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Collision Damping', [
              wbFloat('Angular'),
              wbFloat('Min Slope Cos')
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Controls', [
              wbStruct('Steering PID Third Person', [
                wbFloat('P-Value'),
                wbFloat('I-Value'),
                wbFloat('D-Value')
              ]).IncludeFlag(dfCollapsed),
              wbStruct('Steering PID First Person', [
                wbFloat('P-Value'),
                wbFloat('I-Value'),
                wbFloat('D-Value')
              ]).IncludeFlag(dfCollapsed)
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Unknown', [
              wbFloat,
              wbFloat,
              wbFloat,
              wbFloat,
              wbFloat,
              wbFloat
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Camera', [
              wbStruct('Base Zoom', [
                wbFloat('First Person'),
                wbFloat('Third Person Near'),
                wbFloat('Third Person Far')
              ]).IncludeFlag(dfCollapsed),
              wbStruct('Base Height', [
                wbFloat('First Person'),
                wbFloat('Third Person Near'),
                wbFloat('Third Person Far')
              ]).IncludeFlag(dfCollapsed),
              wbStruct('Base FOV', [
                wbFloat('First Person'),
                wbFloat('Third Person Near'),
                wbFloat('Third Person Far')
              ]).IncludeFlag(dfCollapsed),
                wbStruct('Boost FOV Offset', [
                wbFloat('Third Person Near'),
                wbFloat('Third Person Far')
              ]).IncludeFlag(dfCollapsed),
              wbStruct('Speed Ratio Zoom Offset', [
                wbFloat('Third Person Near'),
                wbFloat('Third Person Far')
              ]).IncludeFlag(dfCollapsed),
              wbStruct('Speed PID', [
                wbFloat('P-Value'),
                wbFloat('I-Value'),
                wbFloat('D-Value')
              ]).IncludeFlag(dfCollapsed),
                wbStruct('FOV Blend Factor', [
                wbFloat('Aiming'),
                wbFloat('Boosting')
              ]).IncludeFlag(dfCollapsed),
                wbStruct('Position', [
                wbFloat('Blend Filtering Factor'),
                wbFloat('R/L Offset for First Person')
              ]).IncludeFlag(dfCollapsed)
            ]).IncludeFlag(dfCollapsed),
            wbFloat('Handling Forward Boost Force In Water'),
            wbFloat('Water Lin Damp'),
            wbFloat('Wheel Max Friction'),
            wbStruct('Water Bob', [
              wbStruct('Acceleration', [
                wbFloat('DeadZone'),
                wbFloat('Pitch'),
                wbFloat('Roll')
              ]).IncludeFlag(dfCollapsed),
              wbStruct('Natural', [
                wbFloat('Pitch Period'),
                wbFloat('Roll Period'),
                wbFloat('Amplitude')
              ]).IncludeFlag(dfCollapsed),
              wbStruct('Torque', [
              wbFloat('Pitch'),
              wbFloat('Roll')
              ]).IncludeFlag(dfCollapsed)
            ]).IncludeFlag(dfCollapsed),
            wbFloat('Chassis Linear Damping'),
            wbFloat('Suspension Max Visual Speed Compression'),
            wbFloat('Suspension Max Visual Speed Relaxation'),
            wbStruct('Slide Factor', [
              wbFloat('Gain/S > Threshold'),
              wbFloat('Lost/S <= Threshold'),
              wbFloat('Threshold'),
              wbFloat('Friction At Max Slide Factor'),
              wbFloat('Viscosity Friction At Max Slide Factor')
            ]).IncludeFlag(dfCollapsed)
          ]).IncludeFlag(dfCollapsed),
          wbFormIDCk(VCMT, 'Mounted Weapon', [WEAP]),
          wbStruct(VCTT, 'Weapon Data', [
            wbFloat('Offset X'),
            wbFloat('Offset Y'),
            wbFloat('Offset Z'),
            wbFloat('Pitch'),
            wbFloat('Yaw'),
            wbFloat('Roll'),
            wbFloat('Scale')
          ]).IncludeFlag(dfCollapsed),
          wbStruct(VWWD, 'Vehicle WWise Data', [
            wbSoundReference('Motor Sound'),
            wbSoundReference('Tire Sound Front Left'),
            wbSoundReference('Tire Sound Front Right'),
            wbSoundReference('Tire Sound Rear Left'),
            wbSoundReference('Tire Sound Rear Right'),
            wbSoundReference('Headlight On'),
            wbSoundReference('Headlight Off'),
            wbSoundReference('Landing Sound - Ground'),
            wbSoundReference('Landing Sound - Water'),
            wbSoundReference('Horn Sound')
          ]).IncludeFlag(dfCollapsed),
          wbStruct(VMRT, 'Vehicle Material Table', [
            wbWWiseGUID('Material ID'),
            wbStruct('Audio', [
              wbInteger('Count', itU32),
              wbUnused(4),
              wbArrayS('Audio Rules',
                wbStructSK([0], 'Rules', [
                  wbLenString('Rule', 1),
                  wbWWiseGUID('Sound')
                ]).IncludeFlag(dfCollapsed)
              ).SetCountPath('Count', True)
            ]).IncludeFlag(dfCollapsed),
            wbStruct('VFX', [
              wbInteger('Count', itU32),
              wbUnused(4),
              wbArrayS('VFX Rules',
                wbStructSK([0], 'Rules', [
                  wbLenString('Rule', 1),
                  wbFormID('Bound Object')
                ]).IncludeFlag(dfCollapsed)
              ).SetCountPath('Count', True)
            ]).IncludeFlag(dfCollapsed),
            wbStruct('Friction', [
              wbInteger('Count', itU32),
              wbUnused(4),
              wbArrayS('Friction Rules',
                wbStructSK([0], 'Rules', [
                  wbLenString('Rule', 1),
                  wbFloat('Friction')
                ]).IncludeFlag(dfCollapsed)
              ).SetCountPath('Count', True)
            ]).IncludeFlag(dfCollapsed)
          ]).IncludeFlag(dfCollapsed)
        ], [])
      ], []),
      wbEmpty(BFCE, 'End Marker', cpIgnore, True)
    ], [])
//    .IncludeFlag(dfCollapsed, wbCollapseComponents)
  );

  var wbMNAMFurnitureMarker := wbInteger(MNAM, 'Active Markers / Flags', itU32, wbFlags([
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
    {0x00100000} 'Allow Cloth Sim',
    {0x00200000} 'Disable Physics',
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

  var wbMarkerEntryExitTypes :=
    wbFlags([
      'Front',
      'Rear',
      'Right',
      'Left',
      'Other',
      '',
      '',
      ''
    ], True); // storage memory is initialized to FF so bits 6-8 are always set

  var wbSNAMMarkerParams :=
    wbArray(SNAM, 'Marker Parameters', wbStruct('Marker', [
      wbFloat('Offset X'),
      wbFloat('Offset Y'),
      wbFloat('Offset Z'),
      wbFloatAngle('Rotation Z', cpNormal, True),
      wbFormIDCk('Keyword', [KYWD, NULL]),
      wbFromVersion(125, wbInteger('Entry Types', itU8, wbMarkerEntryExitTypes).IncludeFlag(dfCollapsed, wbCollapseFlags)),
      wbFromVersion(125, wbUnused(3)), // padding
      wbFromVersion(555, wbInteger('Exit Types', itU8, wbMarkerEntryExitTypes).IncludeFlag(dfCollapsed, wbCollapseFlags)),
      wbFromVersion(555, wbUnused(3)) // padding
    ], cpNormal, False, nil, 4));

  var wbArmorPropertyEnum := wbEnum([
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

  var wbActorPropertyEnum := wbEnum([
    { 0} 'Keywords',
    { 1} 'ForcedInventory',
    { 2} 'XPOffset',
    { 3} 'Enchantments',
    { 4} 'ColorRemappingIndex',
    { 5} 'MaterialSwaps'
  ]);

  var wbWeaponPropertyEnum := wbEnum([
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

  var wbObjectModProperties :=
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
      wbUnion('Value', wbObjectModPropertiesDecider, [
       {0} wbInteger('Property Name', itU32, wbObjectModPropertiesEnum),
       {1} wbInteger('Property Name', itU32, wbObjectModPropertiesWEAPEnum),
       {2} wbInteger('Property Name', itU32, wbObjectModPropertiesARMOEnum),
       {3} wbInteger('Property Name', itU32, wbObjectModPropertiesNPCEnum)
      ]),

      wbUnion('Value 1', wbOMODDataPropertyValue1Decider, [
        { 0} wbByteArray('Value 1 - Unknown', 4),
        { 1} wbInteger('Value 1 - Int', itS32),
        { 2} wbFloat('Value 1 - Float'),
        { 3} wbInteger('Value 1 - Bool', itU32, wbBoolEnum),
        { 4} wbFormID('Value 1 - FormID'),
        { 5} wbInteger('Value 1 - Enum', itU32),
        { 6} wbInteger('Value 1 - Sound Level', itU32, wbSoundLevelEnum),
        { 7} wbInteger('Value 1 - Stagger Value', itU32, wbStaggerEnum),
        { 8} wbInteger('Value 1 - Hit Behaviour', itU32, wbHitBehaviourEnum)
      ]),
      wbUnion('Value 2', wbOMODDataPropertyValue2Decider, [
        wbUnused(4),
        wbInteger('Value 2 - Int', itS32),
        wbFloat('Value 2 - Float'),
        wbInteger('Value 2 - Bool', itU32, wbBoolEnum)
      ]),
      wbFloat('Step')
      ])).SetCountPath(csPropertyCount, True);

  var wbOBTSReq := wbStruct(OBTS, 'Object Mod Template Item', [
    wbInteger(csIncludeCount, itU32, nil, cpBenign).IncludeFlag(dfSkipImplicitEdit),
    wbInteger(csPropertyCount, itU32, nil, cpBenign).IncludeFlag(dfSkipImplicitEdit),
    wbInteger('Level Min', itU16),
    wbInteger('Level Max', itU16),
    wbInteger('Parent Combination Index', itS16).SetDefaultNativeValue(-1),
    wbInteger('Default', itU8, wbBoolEnum).SetDefaultNativeValue(1),
    wbArray('Keywords', wbFormIDCk('Keyword', [KYWD, NULL]), -4),
    wbInteger('Min Level For Ranks', itU8),
    wbInteger('Alt Levels Per Tier', itU8),
    wbArray('Includes', wbStructSK([0],'Include', [
      wbFormIDCk('Mod', [OMOD]),
      wbInteger('Attach Point Index', itU8),
      wbInteger('Optional', itU8, wbBoolEnum),
      wbInteger('Don''t Use All', itU8, wbBoolEnum)
    ])).SetCountPath(csIncludeCount, True),
    wbObjectModProperties
    ], cpNormal, True)
      .SetSummaryKeyOnValue([6,9,10])
      .IncludeFlagOnValue(dfSummaryMembersNoName);

  var wbObjectTemplate := wbRStruct('Object Template', [
    wbInteger(OBTE, 'Count', itU32, nil, cpBenign).IncludeFlag(dfSkipImplicitEdit),
    wbRArray('Combinations',
      wbRStruct('Combination', [
        wbEmpty(OBTF, 'Editor Only'),
        wbFULL,
        wbOBTSReq.IncludeFlag(dfTerminator)
      ], [])
      .SetSummaryKey([1])
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfAllowAnyMember)
      .IncludeFlag(dfStructFirstNotRequired)
    ).SetCountPath(OBTE).SetRequired
  ], []).SetSummaryKey([1]);

  // sorting /should/ be applicable, but will need testing first
  var wbBoneDataItem :=
      wbRStruct('Bone Data Set', [
        wbRStruct('Bone Weight Scale Data', [
          wbInteger(BSMP, 'Weight Scale Target Gender', itU32, wbEnum(['Male', 'Female'])),
          // should not be sorted!!!
          wbRArray('Bone Weight Scales',
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
            ], [])
            .SetSummaryKey([1])
            .IncludeFlag(dfCollapsed, wbCollapseRACEBoneData)
          )
        ],[]),
        wbRStruct('Bone Range Modifier Data', [
          wbInteger(BMMP, 'Range Modifier Target Gender', itU32, wbEnum(['Male', 'Female'])),
          // should not be sorted!!!
          wbRArray('Bone Range Modifiers',
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
            ], [])
            .SetSummaryKey([1])
            .IncludeFlag(dfCollapsed, wbCollapseRACEBoneData)
          )
        ],[])
      ], []);

  var wbArmorAddonBoneDataItem :=
      wbRStruct('Bone Scale Modifier Set', [
        wbInteger(BSMP, 'Target Gender', itU32, wbEnum(['Male', 'Female'])),
        wbRArray('Bone Scale Modifiers',
          wbRStructSK([0], 'Bone Scale Modifier', [
            wbString(BSMB, 'Bone Name'),
            wbStruct(BSMS, 'Bone Scale Delta', [
              wbFloat('X'),
              wbFloat('Y'),
              wbFloat('Z')
            ])
            .SetSummaryKeyOnValue([0,1,2])
            .SetSummaryPrefixSuffixOnValue(0, '[', '')
            .SetSummaryPrefixSuffixOnValue(1, ' ', '')
            .SetSummaryPrefixSuffixOnValue(2, ' ', ']')
            .SetSummaryDelimiterOnValue(',')
            .IncludeFlag(dfSummaryNoName)
            .includeFlag(dfCollapsed, wbCollapseVec3)
            .SetRequired
          ], [])
          .SetSummaryKey([1])
          .IncludeFlag(dfCollapsed, wbCollapseARMABoneData)
        )
      ], []);

  var wbBSMPSequence := wbRArray('Bone Scale Data', wbBoneDataItem);

  var wbArmorAddonBSMPSequence := wbRArray('Sculpt Data', wbArmorAddonBoneDataItem);

  {subrecords checked against Starfield.esm}
  var wbEffect :=
    wbRStruct('Effect', [
      wbEFID,
      wbEFIT,
      wbCTDAs,
      wbFormIDCk(MNAM, 'Magnitude Global', [GLOB]),
      wbFormIDCk(ANAM, 'Area Global', [GLOB]),
      wbFormIDCk(ZNAM, 'Duration Global', [GLOB]),
      wbInteger(EFIF, 'Flags', itU32, wbFlags([
        'Value as Ratio',
        'Always Show in Item Card'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger(MUID, 'Index UID', itU32)
    ], [], cpNormal, True)
    .SetSummaryKey([0,2]).IncludeFlag(dfSummaryMembersNoName)
    ;

  var wbEffects :=
    wbRArrayS('Effects', wbEffect);

  var wbEffectsReq :=
    wbRArrayS('Effects', wbEffect, cpNormal, True);

  var wbMOLM :=
    function(const aSignature: TwbSignature): IwbSubRecordDef
    begin
      Result :=
        wbArrayS(aSignature, 'Material Swaps', wbFormIDCk('Layered Material Swap', [LMSW]), -2);
      Result.IncludeFlag(dfMergeIfMultiple);
    end;

  var wbGenericModel :=
    function (aRequired: Boolean = False; aDontShow: TwbDontShowCallback = nil): IwbRecordMemberDef
    begin
      {subrecords checked against Starfield.esm}
      Result :=
        wbRStructSK([0], 'Model', [
          wbString(MODL, 'Model FileName'),
    //      wbMODT, // can still be read, might not be properly supported anymore, doesn't occur in Starfield.esm
          wbMOLM(MOLM),
          wbFLLD.SetRequired(True),
          wbMODC,
          wbInteger(XFLG, 'Flags', itU8, wbModelFlags).IncludeFlag(dfCollapsed, wbCollapseFlags)
    //      wbMODS, // can still be read, might not be properly supported anymore, doesn't occur in Starfield.esm
    //      wbMODF  // can still be read, might not be properly supported anymore, doesn't occur in Starfield.esm
        ], [], cpNormal, aRequired, aDontShow)
        .SetSummaryKey([1])
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed, wbCollapseModels)
        .IncludeFlag(dfAllowAnyMember)
        .IncludeFlag(dfStructFirstNotRequired);
    end;

  {subrecords checked against Starfield.esm}
  wbRecord(ACTI, 'Activator',
    wbFlags(wbFlagsList([
       2, 'Heading Marker',
       4, 'Non Occluder',
       6, 'Never Fades',
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
      28, 'Navmesh - Only Cut',
      29, 'Navmesh - Ignore Erosion',
      30, 'Navmesh - Ground'
    ])).SetFlagHasDontShow(26, wbFlagNavmeshFilterDontShow)
       .SetFlagHasDontShow(27, wbFlagNavmeshBoundingBoxDontShow)
       .SetFlagHasDontShow(28, wbFlagNavmeshOnlyCutDontShow)
       .SetFlagHasDontShow(29, wbFlagNavmeshIgnoreErosionDontShow)
       .SetFlagHasDontShow(30, wbFlagNavmeshGroundDontShow), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbDEFL,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbFTYP,
    wbNTRM,
    wbByteColors(PNAM, 'Marker Color'),
    wbString(WMAT, 'Water Material'),
    wbALSH,
    wbACSH,
    wbATTX,
    wbFormIDCk(WTFM, 'Water', [WATR]),
    wbInteger(FNAM, 'Flags', itU16, wbFlags([
      'No Displacement',
      'Ignored by Sandbox',
      'Is Water',
      'Non-Planar',
      'Is a Radio',
      'Allow Displacements',
      'Use Global Probe'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(JNAM, 'Activation Angle - For Player', itU16),
    wbEmpty(INAM, 'Activation Angle - Invert Facing'),
//    wbFormIDCk(KNAM, 'Interaction Keyword', [KYWD]),
    wbStruct(RADR, 'Radio Receiver', [
      wbFloat('Frequency'),
      wbFloat('Volume'),
      wbInteger('Starts Active', itU8, wbBoolEnum),
      wbInteger('No Signal Static', itU8, wbBoolEnum)
    ], cpNormal, False, nil),
    wbConditions,
    wbNVNM
  ]);

  (* still exists in game code, but not in Starfield.esm *)
  wbRecord(TACT, 'Talking Activator',
    wbFlags(wbFlagsList([
      {0x00000200}  9, 'Hidden From Local Map',
      {0x00010000} 16, 'Random Anim Start',
      {0x00020000} 17, 'Radio Station'
    ]), [17]), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbDEFL,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbDEST,
    wbKeywords,
    wbUnknown(PNAM, cpIgnore, True),
    wbSoundReference(ALSH, 'Looping Sound'),
    wbUnknown(FNAM, cpIgnore, True),
    wbUnknown(JNAM, cpNormal, True).SetDefaultEditValue('68 01'),
    wbFormIDCk(VNAM, 'Voice Type', [VTYP])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ALCH, 'Ingestible',
    wbFlags(wbFlagsList([
      {0x20000000} 29, 'Medicine'
    ])), [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbKeywords,
    wbGenericModel(True),
    wbDEST,
    wbPUSH,
    wbPDSH,
    wbETYP,
    wbCUSH,
    wbDESC(),
    wbCVPA,
    wbCDIX,
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
      ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFormIDCk('Addiction', [NULL, SPEL]),
      wbFloat('Addiction Chance'),
      wbSoundReference
    ], cpNormal, True),
    wbLStringKC(DNAM, 'Addiction Name', 0, cpTranslate),
    wbEffects
  ], False, nil, cpNormal, False);

  {subrecords checked against Starfield.esm}
  wbRecord(AMMO, 'Ammunition',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Non-Playable'
    ])), [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbPTT2,
    wbFULL,
    wbGenericModel(True),
    wbPUSH,
    wbPDSH,
    wbDESC().SetRequired,
    wbKeywords,
    wbDEST,
    wbStruct(DATA, 'Data', [
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True, nil, 1)
    .SetSummaryKeyOnValue([0,1])
    .SetSummaryPrefixSuffixOnValue(0, 'Value = ',', ')
    .SetSummaryPrefixSuffixOnValue(1, 'Weight = ','')
    ,
    wbStructSK(DNAM, [0], '', [
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
    //wbModelInfo(NAM2)
    wbFLLD
  ], False, nil, cpNormal, False);

  {subrecords checked against Starfield.esm}
  wbRecord(ANIO, 'Animated Object',
    wbFlags(wbFlagsList([
      {0x00000200}  9, 'Unknown 9'
    ]), [9]), [
    wbEDID,
    wbXALG,
    wbBaseFormComponents,
    wbGenericModel(True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ARMO, 'Armor',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Non-Playable',
      {0x00000040}  6, 'Shield',
      {0x00000400} 10, 'Unknown 10',
      {0x00008000} 15, 'Unknown 15'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbPTT2,
    wbBaseFormComponents,
    wbFULL,
    wbEITM,
    wbTexturedModel('Male World Model', [MOD2], [wbMOLM(MLM2), wbMO2S, wbMO2F]),
    wbTexturedModel('Female World Model', [MOD4], [wbMOLM(MLM4), wbMO4S, wbMO4F]),
    wbBO64,
    wbDEST,
    wbPUSH,
    wbPDSH,
    wbETYP,
    wbFormIDCk(BIDS, 'Block Bash Impact Data Set', [IPDS, NULL]),
    wbFormIDCk(BAMT, 'Alternate Block Material', [MATT, NULL]),
    wbFormIDCk(RNAM, 'Race', [RACE]),
    wbKeywords,
    wbDESC(),
    wbINRD,
    wbRArray('Models',
      wbRStructSK([1], 'Model', [
        wbInteger(INDX, 'Addon Index', itU16),
        wbFormIDCk(MODL, 'Armor Addon', [ARMA])
      ], []).IncludeFlag(dfCollapsed, wbCollapseModels)
    ),
    wbStructSK(DATA, [0,1,2], '', [
      wbInteger('Value', itS32),
      wbFloat('Weight'),
      wbInteger('Health', itU32)
    ], cpNormal, True),
    wbStructSK(FNAM, [0], '', [
      wbInteger('Armor Rating', itU16),
      wbInteger('Base Addon Index', itU16),
      wbInteger('Stagger Rating', itU8, wbStaggerEnum),
      wbUnused(3)
    ]).SetSummaryPrefixSuffixOnValue(0, 'Armor Rating = ',''),
    wbDamageTypeArray('Resistance'),
//    wbFormIDCk(TNAM, 'Template Armor', [ARMO]),
    wbAPPR,
    wbObjectTemplate,
    wbEmpty(STOP, 'Marker', cpNormal, True),
    wbStructSK(AVSG, [0,1], 'Voice Switch', [
      wbWwiseGuid('Category'),
      wbWwiseGuid('Variant')
    ]).IncludeFlag(dfCollapsed, wbCollapseSounds),
    wbStructSK(AFSG, [0,1], 'Foley Switch', [
      wbWwiseGuid('Category'),
      wbWwiseGuid('Variant')
    ]).IncludeFlag(dfCollapsed, wbCollapseSounds)
  ], False, nil, cpNormal, False).SetIgnoreList([FLLD, XFLG]);

  var wbAVMDMNAMReq :=
    wbInteger(MNAM, 'AVM Group Type', itU32, wbEnumSummary([
      'None'          , 'None',  // None - Cannot be set in CK
      'Simple Group'  , 'Simple',
      'Complex Group' , 'Complex',
      'Modulation'    , 'Modulation'
    ])).SetRequired;

  {subrecords checked against Starfield.esm}
  wbRecord(ARMA, 'Armor Addon',
    wbFlags(wbFlagsList([
      {0x00000040}  6, 'No Underarmor Scaling',
      {0x00000080}  7, 'Is Skin',
      {0x00000100}  8, 'Is Skin Hands',
      {0x00000400} 10, 'No Model',
      {0x40000000} 30, 'Hi-Res 1st Person Only'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbBO64,
    wbFormIDCk(RNAM, 'Race', [RACE]),
    wbStruct(DNAM, 'Data', [
      wbFloat('Weapon Adjust'),
      wbInteger('Male Priority', itU8),
      wbInteger('Female Priority', itU8),
      wbInteger('Unknown', itU8),
      wbInteger('Unknown', itU8),
      wbInteger('Detection Sound Value', itU8),
      wbFloat('Health Bar Offset')
    ], cpNormal, True),
    wbTexturedModel('Male Biped Model',   [MOD2], [wbMOLM(MLM1), wbMO2C, wbMO2F]),
    wbTexturedModel('Female Biped Model', [MOD3], [wbMOLM(MLM2), wbMO3C, wbMO3F]),
    wbTexturedModel('Male 1st Person',    [MOD4], [wbMOLM(MLM3), wbMO4C, wbMO4F]),
    wbTexturedModel('Female 1st Person',  [MOD5], [wbMOLM(MLM4), wbMO5C, wbMO5F]),

    wbString(MOD6, 'Male Alt Skeleton'),
    wbString(MOD7, 'Female Alt Skeleton'),

    wbFormIDCk(NAM0, 'Male Skin Texture', [TXST]),
    wbFormIDCk(NAM1, 'Female Skin Texture', [TXST]),
    wbFormIDCk(NAM2, 'Male Skin Texture Swap List', [FLST]),
    wbFormIDCk(NAM3, 'Female Skin Texture Swap List', [FLST]),

    wbFormIDCk(NAM4, 'Male World Morph', [MRPH]),
    wbFormIDCk(NAM5, 'Male 1st Person Morph', [MRPH]),
    wbFormIDCk(NAM6, 'Female World Morph', [MRPH]),
    wbFormIDCk(NAM7, 'Female 1st Person Morph', [MRPH]),

    wbRArrayS('Additional Races', wbFormIDCK(MODL, 'Race', [RACE, NULL])),
    wbFormIDCk(SNDD, 'Footstep Sound', [FSTS, NULL]),
    wbFormIDCk(ONAM, 'Art Object', [ARTO]),
    wbFormIDCk(PNAM, 'Body Part Data', [BPTD]),
    wbRStruct('AVM Data',[
      wbAVMDMNAMReq,
      wbString(TNAM, 'Entry Type')
        .SetLinksToCallbackOnValue(function(const aElement: IwbElement): IwbElement
        begin
          Result := nil;
          var lContainer: IwbContainer;
          if not Supports(aElement, IwbContainer, lContainer) then
            Exit;

          var lAVMDName := aElement.NativeValue;
          if not VarIsStr(lAVMDName) or (lAVMDName = '') then
            Exit;

          var lFile := aElement._File;
          if not Assigned(lFile) then
            Exit;

          var lMNAMValue := lContainer.ElementNativeValues['...\MNAM'];
          if not VarIsOrdinal(lMNAMValue) then
            Exit;
          var lType := Integer(lMNAMValue);

          if (lType >= Low(wbIdxAVMByType)) and (lType <= High(wbIdxAVMByType)) then
            Result := lFile.RecordFromIndexByKey[wbIdxAVMByType[lType], lAVMDName];
        end)
        .SetToStr(wbToStringFromLinksToMainRecordName),
       wbString(SNAM, 'Entry Sub Type'),
       wbString(VNAM, 'Entry Value')
    ], []),
    wbRStructs('Bone Datas', 'Bone Data', [
      wbInteger(BSMP, 'Gender', itU32, wbEnum(['Male', 'Female'])),
      wbRArrayS('Modifiers', wbFormIDCk(BNAM, 'Modifier', [BMOD]))
    ], [])
  ], False, nil, cpNormal, False).SetIgnoreList([FLLD, XFLG]);

  {subrecords checked against Starfield.esm}
  wbRecord(BOOK, 'Book', [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbPTT2,
    wbDEFL,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbDESCreq('Book Text'),
    wbDEST,
    wbPUSH,
    wbPDSH,
    wbKeywords,
    wbFIMD,
    wbStructSK(DATA, [0,1], 'Data', [
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
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbUnion('Teaches', wbBOOKTeachesDecider, [
        wbUnused(4),
        wbFormIDCk('Actor Value', [AVIF, NULL]),
        wbFormIDCk('Spell', [SPEL, NULL]),
        wbFormIDCk('Perk', [PERK, NULL])
      ]),
      wbStructSK([0,1], 'Text Offset' , [
        wbInteger('X', itU32),
        wbInteger('Y', itU32)
      ]),
      wbInteger('Data Slate Type', itU32, wbEnum([
        'None (normal book)',
        'Text',
        'Image',
        'Audio'
      ]))
    ], cpNormal, True),
    wbLStringKC(CNAM, 'Description', 0, cpTranslate),
    wbRStruct('Data Slate Headers', [
      wbLStringKC(ENAM, 'Left (2 lines)', 0, cpTranslate),
      wbLStringKC(FNAM, 'Right (2 lines)', 0, cpTranslate)
    ], []).IncludeFlag(dfAllowAnyMember),
    wbFormIDCk(INAM, 'Inventory Art', [STAT]),
    wbFormIDCk(GNAM, 'Scene', [SCEN])
  ]);

  var wbXLKRs :=
    wbRArrayS('Linked References', wbStruct(XLKR, 'Linked Reference', [
      wbFormIDCk('Keyword/Ref', [KYWD] + sigReferences),
      wbFormIDCk('Ref', sigReferences)
    ], cpNormal, False, nil, 1));

  var wbLinkedReferences :=
    wbRStruct('Linked References', [
      wbXLKRs,
      wbEmpty(XLKT, 'Transient')
    ], []);

  var wbXPCS := wbFormIDCk(XPCS, 'Source Pack-in', [PKIN]);

  var wbXPLKs :=
    wbRArray('Power Links', wbStruct(XPLK, 'Power Link', [
      wbFormIDCk('Ref', [REFR, ACHR]),
      wbInteger('Unknown', itU32, wbEnum([
        '',
        '',
        'Unknown 2'
      ]))
    ]));

  var ReferenceRecord :=
    procedure(aSignature: TwbSignature; const aName: string)
    begin
      {subrecords checked against Starfield.esm}
      wbRefRecord(aSignature, aName,
        wbFlags(wbFlagsList([
          {0x00000080}  7, 'Turn Off Fire',
          {0x00000400} 10, 'Persistent',
          {0x00000800} 11, 'Initially Disabled',
          {0x10000000} 28, 'Reflected By Auto Water',
          {0x20000000} 29, 'Don''t Havok Settle',
          {0x40000000} 30, 'No Respawn'
        ], True, True)), [
        wbEDID, //not in Starfield.esm
        wbVMAD,
        wbFormIDCk(NAME, 'Projectile', [PROJ, HAZD]),

        wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

        wbXRGD,

        wbFormIDCk(XRFG, 'Reference Group', [RFGP]),

        wbXPCS,

        wbEmpty(XIS2, 'Ignored by Sandbox'),

        wbXRNK,

        wbLinkedReferences,

        wbXOWN,

        wbFormIDCk(XEZN, 'Location Override', [LCTN]),

        wbFormIDCk(XLYR, 'Layer', [LAYR]),

        wbFloat(XHTW, 'Head-Tracking Weight'),

        wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),

        wbXESP,

        wbEmpty(XATP, 'Activation Point'),

        wbXSCL,
        wbDataPosRot,
        wbString(MNAM, 'Comments')
      ], True, wbPlacedAddInfo);
    end;

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

  var wbXTV2 :=
    wbArray(XTV2, 'Traversals', wbTraversalData)
    .SetWronglyAssumedFixedSizePerElementOnValue(56)
    .IncludeFlag(dfCollapsed)
    .IncludeFlag(dfExcludeFromBuildRef)
    .IncludeFlag(dfFastAssign)
    .IncludeFlag(dfNotAlignable);

  {subrecords checked against Starfield.esm}
  wbRecord(CELL, 'Cell',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Is Unique',
      {0x00000400}  7, 'No Pre Vis',
      {0x00000400} 10, 'Persistent',
      {0x00004000} 14, 'Partial Form',
      {0x00020000} 17, 'Off Limits',
      {0x00040000} 18, 'Compressed',
      {0x00080000} 19, 'Can''t Wait',
      {0x00400000} 22, 'Unknown 22'
    ]), [14, 18])
      .SetFlagHasDontShow(14, wbFlagPartialFormDontShow),
  [
    wbEDID,
    wbBaseFormComponents,
    wbFULL,
    wbInteger(DATA, 'Flags', itU32,
      wbFlags(wbSparseFlags([
        0, 'Is Interior Cell',
        1, 'Has Water',
        2, 'Can Travel From Here',
        3, 'No LOD Water',
        5, 'Public Area',
        6, 'Hand Changed',
        7, 'Show Sky',
        8, 'Use Sky Lighting',
       10, 'Hidden from Interior Cell List',
       11, 'Sunlight Shadows',
       12, 'Distant LOD only',
       13, 'Player Followers Can''t Travel Here',
       14, 'Unknown 14',
       15, 'Unknown 15',
       16, 'Use Location as Name',
       17, 'Use Planet Gravity',
       19, 'Use IS Volumes Interior Criteria',
       20, 'Do Not Apply Biome Layered Material Swaps'
    ])), cpNormal, True, False, nil, wbCELLDATAAfterSet)
      .IncludeFlag(dfCollapsed, wbCollapseFlags),

    wbCellGrid,

    wbStruct(XCLL, 'Lighting', [
    {  0} wbByteColors('Ambient Color'),
    {  4} wbByteColors('Directional Color'),
    {  8} wbByteColors('Fog Color Near'),
    { 12} wbFloat('Fog Near'),
    { 16} wbFloat('Fog Far'),
    { 20} wbInteger('Directional Rotation XY', itS32),
    { 24} wbInteger('Directional Rotation Z', itS32),
    { 28} wbFloat('Gravity Scale'),                                             {checked via ck}
    { 32} wbFloat('Fog Clip Distance'),
    { 36} wbFloat('Fog Power'),
    { 40} wbByteColors('Fog Color Far'),
    { 44} wbFloat('Fog Max'),
    { 48} wbFloat('Light Fade Begin'),
    { 52} wbFloat('Light Fade End'),
    { 56} wbByteColors('Unknown'),
    { 60} wbFloat('Near Height Mid'),
    { 64} wbFloat('Near Height Range'),
    { 68} wbByteColors('Fog Color High Near'),
    { 72} wbByteColors('Fog Color High Far'),
    { 76} wbFloat('High Density Scale'),
    { 80} wbFloat('Fog Near Scale'),
    { 84} wbFloat('Fog Far Scale'),
    { 84} wbFloat('Fog High Near Scale'),
    { 92} wbFloat('Fog High Far Scale'),
    { 96} wbFloat('Far Height Mid'),
    {100} wbFloat('Far Height Range'),
    {104} wbInteger('Interior Type', itU8, wbEnum([                             {checked via ck}
            'Interior',
            'Ship Cell',
            'Space Cell',
            'PackIn',
            'Instanceable Interior'
          ])),
    {105} wbUnused(3)
    {108}
    ]),

    wbMHDTCELL
    .IncludeFlag(dfCollapsed),

    wbFormIDCk(LTMP, 'Lighting Template', [LGTM, NULL], False, cpNormal, True),

    {>>> XCLW sometimes has $FF7FFFFF and causes invalid floation point <<<}
    wbFloat(XCLW, 'Water Height'),// cpNormal, False, 1, -1, nil, nil, 0, wbCELLXCLWGetConflictPriority),

    wbFloat(XILS),
    wbRStructs('Unknown', 'Unknown', [
      wbInteger(XCLA, 'Unknown', itU32),
      wbString(XCLD)
    ], []),

    wbByteArray(XWCN, 'Water Data', 0, cpIgnore), // leftover

    wbFormIDCk(XCCM, 'Cell Sky Region', [REGN]),

    wbXOWN,

    wbFormIDCk(XLCN, 'Location', [LCTN]),

    wbFormIDCk(XCWT, 'Water', [WATR]),

    wbString(XCWM, 'Water Type'),

    wbArray(XBPS, 'Ship Blueprint Snap Links', wbStruct('Ship Blueprint Snap Link', [
      wbFormIDCk('Parent Reference', sigReferences),
      wbFormIDCk('Linked Reference', sigReferences),
      wbInteger('Parent Node', itU32)
        .SetLinksToCallback(wbLinksToNodeId('...\Parent Reference'))
        .SetToStr(wbToStringFromLinksToSummary),
      wbInteger('Linked Node', itU32)
        .SetLinksToCallback(wbLinksToNodeId('...\Linked Reference'))
        .SetToStr(wbToStringFromLinksToSummary)
    ])),

    wbStruct(XWCU, 'Water Velocity', [
      wbVec3('Offset'),
      wbByteArray('Unknown', 4),
      wbVec3('Angle'),
      wbByteArray('Unknown', 0)
    ]),

    wbFormIDCk(XCAS, 'Acoustic Space', [ASPC]),

    wbFormIDCk(XCIM, 'Image Space', [IMGS]),

    wbString(XWEM, 'Water Environment Map'),

    wbFormIDCk(XILL, 'Lock List', [FLST]),

    wbFormIDCk(XCMO, 'Music Type', [MUSC]),

    wbRStruct('Global Dirt Layer', [
      wbString(XCGD, 'Material'),
      wbInteger(XCIB, 'Inherit Biome Layer', itU8, wbBoolEnum)
    ], [])
      .IncludeFlag(dfAllowAnyMember)
      .IncludeFlag(dfStructFirstNotRequired),

    wbFormIDCk(TODD, 'Time Of Day Data', [TODD]),

    wbLinkedReferences,

    wbString(XEMP, 'Environment Map'),

    wbXTV2
  ], True, wbCellAddInfo, cpNormal, False{, wbCELLAfterLoad});

  {subrecords checked against Starfield.esm}
  wbRecord(CLAS, 'Class', [
    wbEDID,
    wbFULLReq,
    wbDESCReq(),
    wbICON,
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

  {subrecords checked against Starfield.esm}
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
        'Snow',
        'Unknown 2'
      ])),
      wbUnused(4),
      wbInteger('Box Size', itU32),
      wbUnused(4),
      wbFloat('Particle Density'),
      wbUnused(4)
    ], cpNormal, True, nil, 10),
    wbString(MNAM, 'Particle Texture')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CONT, 'Container',
    wbFlags(wbFlagsList([
      15, 'Has Distant LOD',
      16, 'Random Anim Start',
      25, 'Obstacle',
      26, 'Navmesh - Filter',
      27, 'Navmesh - Bounding Box',
      28, 'Navmesh - Only Cut',
      29, 'Navmesh - Ignore Erosion',
      30, 'Navmesh - Ground'
    ])).SetFlagHasDontShow(26, wbFlagNavmeshFilterDontShow)
       .SetFlagHasDontShow(27, wbFlagNavmeshBoundingBoxDontShow)
       .SetFlagHasDontShow(28, wbFlagNavmeshOnlyCutDontShow)
       .SetFlagHasDontShow(29, wbFlagNavmeshIgnoreErosionDontShow)
       .SetFlagHasDontShow(30, wbFlagNavmeshGroundDontShow), [

    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbXALG,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbUnknown(XFLG),
    wbContainerItems,
    wbDEST,
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      {0x01} 'Allow Sounds When Animation',
      {0x02} 'Respawns',
      {0x04} 'Show Owner',
      {0x08} 'Unknown 3'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbKeywords,
    wbFTYP,
    wbNTRM,
    wbPRPS,
    wbAPPR,
    wbObjectTemplate,
    wbEmpty(STOP, 'Marker'),
    wbSoundReference(WED0, 'Open Sound'),
    wbSoundReference(WED1, 'Close Sound'),
    wbFormIDCk(ONAM, 'Contains Only Filter', [FLST])
  ], False, nil, cpNormal, False, nil, wbContainerAfterSet);

  var wbAIDT :=
    wbStruct(AIDT, 'AI Data', [
     {00} wbInteger('Aggression', itU8, wbAggressionEnum),
     {01} wbInteger('Confidence', itU8, wbConfidenceEnum),
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
          wbInteger('Assistance', itU8, wbAssistanceEnum),
          wbInteger('Has Reaction Radius Behavior', itU8, wbBoolEnum)
    ], cpNormal, True);

    var wbCSTYPowerWeightingStruct := wbStruct('Power Weighting', [
      wbFloat('Engines', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Shields', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Guns', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbStruct('Shield Based Guns', [
        wbFloat('EM', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
        wbFloat('Hull', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
        wbFloat('Shield', cpNormal, True, 1, -1, nil, wbFloatScale0to10)
      ]),
        wbStruct('Hull Based Guns', [
        wbFloat('EM', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
        wbFloat('Hull', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
        wbFloat('Shield', cpNormal, True, 1, -1, nil, wbFloatScale0to10)
      ])
    ]);

    var wbCSTYNormalizeFloat30 := wbNormalizeToRange(0.0, 30.0);
    var wbCSTYNormalizeFloat600 := wbNormalizeToRange(0.0, 600.0);
    var wbCSTYManneuverTimingStruct := function(aName: string = 'Timings'):IwbStructDef
    begin
      Result := wbStruct(aName, [
        wbFloat('Engage', cpNormal, True, 1, -1, nil, wbCSTYNormalizeFloat600),
        wbFloat('Evade', cpNormal, True, 1, -1, nil, wbCSTYNormalizeFloat600),
        wbFloat('Acquire', cpNormal, True, 1, -1, nil, wbCSTYNormalizeFloat600),
        wbFloat('Persue', cpNormal, True, 1, -1, nil, wbCSTYNormalizeFloat600),
        wbFloat('Disengage', cpNormal, True, 1, -1, nil, wbCSTYNormalizeFloat600),
        wbFloat('Surround', cpNormal, True, 1, -1, nil, wbCSTYNormalizeFloat600),
        wbUnknown(4),
        wbFloat('Break Stalemate', cpNormal, True, 1, -1, nil, wbCSTYNormalizeFloat600)
      ]);
    end;
  {subrecords checked against Starfield.esm}
  wbRecord(CSTY, 'Combat Style',
    wbFlags(wbFlagsList([
      {0x00080000} 19, 'Allow Dual Wielding'
    ])), [
    wbEDID,
    wbStruct(CSGD, 'General', [
      wbFloat('Offensive Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Defensive Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Group Offensive Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Equipment Score Mult - Melee', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Equipment Score Mult - Magic', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Equipment Score Mult - Ranged', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Equipment Score Mult - Shout', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Equipment Score Mult - Unarmed', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Equipment Score Mult - Staff', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Avoid Threat Chance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Dodge Threat Chance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Evade Threat Chance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Heal Ally Distance', cpNormal, True, 1, -1, nil, wbFloatScale0to100),
      wbFloat('Jump Cost Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Taunt Delay Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to10)
    ], cpNormal, True),
    wbStruct(CSME, 'Melee', [
      wbFloat('Attack Staggered Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Power Attack Staggered Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Power Attack Blocking Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Bash Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Bash Recoil Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Bash Attack Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Bash Power Attack Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Special Attack Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Block When Staggered Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Attack When Staggered Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to10)
    ], cpNormal, True, nil, 9),
    wbStruct(CSRA, 'Ranged', [
      wbFloat('Ranged Accuracy Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Throw Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Grenade - Advanced Throwing Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Grenade - Flash Target Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Grenade - Throw At Group Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Grenade - Close Range Attack Chance Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1)
    ], cpNormal, True),
    wbStruct(CSCR, 'Close Range', [
      wbFloat('Dueling - Circle Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Dueling - Fallback Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Flanking - Flank Distance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Flanking - Stalk Time', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Charging - Charge Distance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Charging - Throw Probability', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Charging - Sprint Fast Probability', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Charging - Sideswipe Probability', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Charging - Disengane Probability', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbInteger('Charging - Throw Max Targets', itU32),
      wbFloat('Flanking - Flank Variance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Retreat - Chance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Retreat - Distance Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1)
    ], cpNormal, True),
    wbStruct(CSLR, 'Long Range', [
      wbFloat('Strafe Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Adjust Range Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Crouch Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Wait Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Range Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Provide Suppressive Fire Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Retreat - Chance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Retreat - Hide Time Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Retreat - Distance Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1)
    ], cpNormal, True, nil, 3),
    wbStruct(CSCV, 'Cover Search', [
      wbFloat('Cover Search Distance Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Suppression Sensitivity', cpNormal, True, 1, -1, nil, wbFloatScale0to1)
    ], cpNormal, True),
    wbStruct(CSFL, 'Flight', [
      wbFloat('Hover Chance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Dive Bomb Chance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Ground Attack Chance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Hover Time', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Ground Attack Time', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Perch Attack Chance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Perch Attack Time', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Flying Attack Chance', cpNormal, True, 1, -1, nil, wbFloatScale0to1)
    ], cpNormal, True),
    wbStruct(CSTN, 'Tunnel', [
      wbFloat('Cost Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Chance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Max Distance', cpNormal, True, 1, -1, nil, wbNormalizeToRange(0.0, 1000.0)),
      wbFloat('Speed Mult', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Min Time', cpNormal, True, 1, -1, nil, wbCSTYNormalizeFloat30),
      wbFloat('Max Time', cpNormal, True, 1, -1, nil, wbCSTYNormalizeFloat30),
      wbFloat('Maximum Time', cpNormal, True, 1, -1, nil, wbCSTYNormalizeFloat30),
      wbFloat('Cooldown', cpNormal, True, 1, -1, nil, wbCSTYNormalizeFloat30)
    ]),
    wbStruct(CSSG, 'Space General', [
      wbFloat('Pilot Skill', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Accuracy', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Target Shield', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Adjustment', cpNormal, True, 1, -1, nil, wbNormalizeToRange(0.0, 60.0)),
      wbStruct('Engage Maneuver Chance', [
        wbFloat('Direct Attack', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
        wbFloat('Pass', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
        wbFloat('Lead Turn', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
        wbFloat('Slide Turn', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
        wbFloat('Barrel Roll', cpNormal, True, 1, -1, nil, wbFloatScale0to1)
      ]),
      wbStruct('Evade Maneuver Chance', [
        wbFloat('Break', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
        wbFloat('Scissors', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
        wbFloat('Cut', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
        wbFloat('Boost', cpNormal, True, 1, -1, nil, wbFloatScale0to1)
      ]),
      wbStruct('Acquire Maneuver Chance', [
        wbFloat('Sliceback', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
        wbFloat('Strafe Turn', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
        wbFloat('Acquire', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
        wbFloat('Turn', cpNormal, True, 1, -1, nil, wbFloatScale0to1)
      ]),
      wbFloat('Disengage Maneuver Chance'),
      wbFloat('Missile Seeking Strength', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      wbFloat('Min Time Between Boosts', cpNormal, True, 1, -1, nil, wbNormalizeToRange(0.0, 60.0)),
      wbInteger('Combat Strafing', itU8, wbBoolEnum),
      wbInteger('Rolls During Boost', itU8, wbBoolEnum),
      wbUnused(2), //padding
      wbCSTYPowerWeightingStruct
    ]),
    wbStruct(CSSM, 'Space Manneuver Types', [
      wbCSTYManneuverTimingStruct('Max Time'),
      wbCSTYManneuverTimingStruct('Reentry Delays')
    ]),
    wbStruct(CSSR, 'Space Repair', [
      wbFloat('Damage Threshold', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Faraway Distance %', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbFloat('Power to Use', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbStruct('In Close Power Weighting Tables', [
        wbCSTYPowerWeightingStruct
      ]),
      wbStruct('Faraway Power Weighting Tables', [
        wbCSTYPowerWeightingStruct
      ])
    ]),
    wbStruct(CSSA, 'Space Approaching', [
      wbFloat('Min Distance', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      wbCSTYPowerWeightingStruct
    ]),
    wbStruct(CSSD, 'Space Detection', [
      wbFloat('Detection Rating 1'),
      wbFloat('Detection Rating 2'),
      wbFloat('Detection Rating 3')
    ]),
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      {0x01} 'Dueling',
      {0x02} 'Flanking',
      {0x04} 'Allow Dual Wielding',
      {0x08} 'Charging',
      {0x10} 'Retarget Any Nearby Melee Target',
      {0x20} 'Prefer Walking While Strafing',
      {0x40} 'Use Group Cohesion',
      {0x80} 'Maintain Attack From Cover Until Suppressed'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbUnknown(FNAM),
    wbFormIDCk(TNAM, 'Template Default Combat Style', [CSTY]),
    wbStruct(UNAM, 'Templates', [
      wbFormIDCk('Offsensive Defensive Mults', [NULL, CSTY]),
      wbFormIDCk('Avoid Threats', [NULL, CSTY]),
      wbFormIDCk('Equipment Score Mults', [NULL, CSTY]),
      wbFormIDCk('Melee', [NULL, CSTY]),
      wbFormIDCk('Ranged', [NULL, CSTY]),
      wbFormIDCk('Close Range', [NULL, CSTY]),
      wbFormIDCk('Long Range', [NULL, CSTY]),
      wbFormIDCk('Cover', [NULL, CSTY]),
      wbFormIDCk('Flight', [NULL, CSTY]),
      wbFormIDCk('Tunnel', [NULL, CSTY]),
      wbFormIDCk('Space General', [NULL, CSTY]),
      wbFormIDCk('Space Power', [NULL, CSTY]),
      wbFormIDCk('Space Repair', [NULL, CSTY]),
      wbFormIDCk('Space Approaching', [NULL, CSTY]),
      wbFormIDCk('Space Detection', [NULL, CSTY]),
      wbFormIDCk('Misc', [NULL, CSTY]),
      wbFormIDCk('Space Maneuver Types', [NULL, CSTY])
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(DIAL, 'Dialog Topic',
    wbFlags(wbFlagsList([
      {0x00004000} 14, 'Partial Form'
    ]), [14]), [
    wbEDID,
    wbBaseFormComponents, // unknown if before or after FULL
    wbFULL,
    wbFloat(PNAM, 'Priority', cpNormal, True, 1, -1, nil, nil, 50.0),
    wbFormIDCkNoReach(BNAM, 'Branch', [DLBR]),
    wbFormIDCkNoReach(QNAM, 'Quest', [QUST], False, cpNormal, False),
    wbFormIDCk(KNAM, 'Keyword', [KYWD]),
    wbFormIDCk(ANAM, 'Affinity Event', [AFFE]),
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
        { 3} 'Custom (Command)',
        { 4} 'Call',
        { 5} 'Follow',
        { 6} 'Move',
        { 7} 'Attack (Command)',
        { 8} 'Inspect',
        { 9} 'Retrieve',
        {10} 'Stay',
        {11} 'Release',
        {12} 'Show Relationships',
        {13} 'Reject',
        {14} 'Heal',
        {15} 'Assign',
        {16} 'Enter',
        {17} 'Custom Scene',
        {18} 'Show',
        {19} 'Agree',
        {20} 'Refuse',
        {21} 'Exit Favor State',
        {22} 'Moral Refusal',
        {23} 'Trade',
        {24} 'Pathing Refusal',
        {25} 'Melee Attack',
        {26} 'Power Attack',
        {27} 'Bash',
        {28} 'Hit',
        {29} 'Flee',
        {30} 'Bleed Out',
        {31} 'ElectromagneticShocked',
        {32} 'Avoid Threat',
        {33} 'Death',
        {34} 'Block',
        {35} 'Taunt',
        {36} 'Throw Grenade',
        {37} 'Use Magic',
        {38} 'Ally Killed',
        {39} 'Enemy Killed',
        {40} 'Order Fallback',
        {41} 'Order Move Up',
        {42} 'Order Flank',
        {43} 'Order Take Cover',
        {44} 'Fallback',
        {45} 'Cover Me',
        {46} 'Suppressive Fire',
        {47} 'Crippled Limb',
        {48} 'Paired Attack',
        {49} 'Take Suppressive Fire',
        {50} 'Ranged Attack',
        {51} 'Reload',
        {52} 'Ship Engines Down',
        {53} 'Ship Thrusters Down',
        {54} 'Ship Shields Down',
        {55} 'Ship Grav Drive Down',
        {56} 'Ship Weapons Down',
        {57} 'Ship Engines Repaired',
        {58} 'Ship Grav Drive Repaired',
        {59} 'Ship Thrusters Repaired',
        {60} 'Ship Shields Repaired',
        {61} 'Ship Weapons Repaired',
        {62} 'Ship Enemy Engine Down',
        {63} 'Ship Enemy Grav Jump Down',
        {64} 'Ship Enemy Shields Down',
        {65} 'Ship Enemy Thrusters Down',
        {66} 'Ship Enemy Weapons Down',
        {67} 'Ship Enemy Engine Repaired',
        {68} 'Ship Enemy Grav Jump Repaired',
        {69} 'Ship Enemy Shields Repaired',
        {70} 'Ship Enemy Thrusters Repaired',
        {71} 'Ship Enemy Weapons Repaired',
        {72} 'Ship Shields ZeroHealth',
        {73} 'Ship Enter Combat',
        {74} 'Ship Leave Combat',
        {75} 'Steal',
        {76} 'Yield',
        {77} 'Accept Yield',
        {78} 'Pickpocket Combat',
        {79} 'Assault',
        {80} 'Murder',
        {81} 'Assault NC',
        {82} 'Murder NC',
        {83} 'Pickpocket NC',
        {84} 'Steal From NC',
        {85} 'Trespass Against NC',
        {86} 'Trespass',
        {87} 'Tresspass No Visual',
        {88} 'Curious',
        {89} 'Threat Backdown',
        {90} 'Steal Takeback',
        {91} 'Steal Takeback Success',
        {92} 'Piracy',
        {93} 'Smuggling NC',
        {94} 'Smuggling',
        {95} 'React To Warn',
        {96} 'Voice Power Start Short',
        {97} 'Voice Power Start Long',
        {98} 'Voice Power End Short',
        {99} 'Voice Power End Long',
       {100} 'Alert Idle',
       {101} 'Lost Idle',
       {102} 'Normal To Alert',
       {103} 'Normal To Combat',
       {104} 'Normal To Lost',
       {105} 'Alert To Normal',
       {106} 'Alert To Combat',
       {107} 'Combat To Normal',
       {108} 'Combat To Lost',
       {109} 'Lost To Normal',
       {110} 'Lost To Combat',
       {111} 'Detect Friend Die',
       {112} 'Service Refusal',
       {113} 'Repair',
       {114} 'Travel',
       {115} 'Training',
       {116} 'Barter Exit',
       {117} 'Repair Exit',
       {118} 'Recharge',
       {119} 'Recharge Exit',
       {120} 'Training Exit',
       {121} 'Observe Combat',
       {122} 'Notice Corpse',
       {123} 'Time To Go',
       {124} 'Goodbye',
       {125} 'Hello',
       {126} 'Swing Melee Weapon',
       {127} 'Shoot Bow',
       {128} 'Z Key Object',
       {129} 'Jump',
       {130} 'Knock Over Object',
       {131} 'Destroy Object',
       {132} 'Standon Furniture',
       {133} 'Locked Object',
       {134} 'Pickpocket Topic',
       {135} 'Ship Crew Grav Jump Calculation Complete',
       {136} 'Ship Crew Landing Start',
       {137} 'Ship Crew Return To Orbit',
       {138} 'Ship Crew Docking Complete',
       {139} 'Ship Undocking Complete',
       {140} 'Ship Crew Enemy Docking Initiated',
       {141} 'Ship Crew Grav Jump Completed',
       {142} 'Ship Crew Take Off Initiated',
       {143} 'Pursue Idle Topic',
       {144} 'Shared Info',
       {145} 'Scene Choice',
       {146} 'Player Cast Projectile Spell',
       {147} 'Player Cast Self Spell',
       {148} 'Player Shout',
       {149} 'Idle',
       {150} 'Enter Sprint Breath',
       {151} 'Enter Bow Zoom Breath',
       {152} 'Exit Bow Zoom Breath',
       {153} 'Actor Collidewith Actor',
       {154} 'Playerin Iron Sights',
       {155} 'Outof Breath',
       {156} 'Combat Grunt',
       {157} 'Leave Water Breath',
       {158} 'Impatient Positive',
       {159} 'Impatient Negative',
       {160} 'Impatient Neutral',
       {161} 'Impatient Question',
       {162} 'Waiting For Player Input',
       {163} 'Greeting',
       {164} 'Player Activate Door',
       {165} 'Player Activate Terminals',
       {166} 'Player Activate Furniture',
       {167} 'Player Activate Activators',
       {168} 'Player Activate Container',
       {169} 'Player Aquire Featured Item',
       {170} 'Max Carbon Dioxide',
       {171} 'Blocking Hellos',
       {172} 'Vehicle Passenger Enter Vehicle',
       {173} 'Vehicle Passenger Engage Boost',
       {174} 'Vehicle Passenger Horizontal Collision',
       {175} 'Vehicle Passenger Vertical Collision',
       {176} 'Vehicle Passenger Enter Water',
       {177} 'Vehicle Passenger Non Moving Idle',
       {178} 'Vehicle Passenger Trigger Mine',
       {179} 'Vehicle Passenger Aim Mounted Weapon',
       {180} 'Vehicle Passenger Kill With Collision',
       {181} 'Vehicle Passenger Kill With Weapon',
       {182} 'Vehicle Passenger Vertical Collision Low Velocity'
      ]))
    ]),
    wbInteger(SNAM, 'Subtype Name', itU32, wbDialogueSubtypeEnum),
    wbArray(TIFL, 'Topic Info List', wbFormIDCk('Topic', [INFO])).SetCountPathOnValue(TIFC, False),
    wbInteger(TIFC, 'Info Count', itU32, nil, cpIgnore),
    wbINOM,
    wbINOA
  ]);

  {subrecords checked against Starfield.esm}
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
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
//    wbSNBH,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbDEST,
    wbKeywords,
    wbNTRM,
    wbFTYP,
    wbPRPS,
    wbSoundReference(DOSH, 'Open Sound'),
    wbSoundReference(DCSH, 'Close Sound'),
    wbSoundReference(DLSH, 'Loop Sound'),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      'No Quest Target',
      'Automatic',
      'Hidden',
      'Minimal Use',
      'Sliding',
      'Do Not Open in Combat Search',
      'No "To" Text',
      'No Direct Activation'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbLStringKC(ONAM, 'Alternate Text - Open', 0, cpTranslate),
    wbLStringKC(CNAM, 'Alternate Text - Close', 0, cpTranslate),
    wbInteger(DEVT, 'Sound Level', itU32, wbSoundLevelEnum, cpNormal, True),
    wbInteger(ANAM, 'Facing Axis Override', itU32, wbEnum([
      'Use X Axis',
      'Use Y Axis',
      'Based on Bounds'
    ]), cpNormal, True),
    wbNVNM
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(EFSH, 'Effect Shader', [
    wbEDID,
    wbBaseFormComponents,
    wbFormIDCk(ENAM, 'Effect Sequence', [EFSQ]),
    wbEmpty(DATA, 'Empty', cpIgnore),
    wbStruct(DNAM, 'Data', [
      wbStruct('Edge Effect', [
        wbFloat('Fall Off'),
        wbByteColors,
        wbFloat('Alpha Fade In Time'),
        wbFloat('Full Alpha Time'),
        wbFloat('Alpha Fade Out Time'),
        wbFloat('Persistent Alpha Ratio [0-1]'),
        wbFloat('Alpha Pulse Amplitude'),
        wbFloat('Alpha Pulse Frequency'),
        wbFloat('Full Alpha Ratio [0-1]')
      ]),
      wbStruct('Holes - Alpha Test Animation', [
        wbFloat('Start Time'),
        wbFloat('Stop Time'),
        wbFloat('Start Val'),
        wbFloat('Stop Val')
      ]),
      wbSoundReference('Sounds'),
      wbInteger('Bone Depth', itU8),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} { 0} 'Membrane Shader Off',
        {0x00000002} { 1} '',
        {0x00000004} { 2} '',
        {0x00000008} { 3} 'Unknown 3', // doesn't appear to have a UI element and every record gets it set, including new ones
        {0x00000010} { 4} 'Edge Effect - Inverse',
        {0x00000020} { 4} 'Affect Skin Only',
        {0x00000040} { 6} '',
        {0x00000080} { 7} '',
        {0x00000100} { 8} '',
        {0x00000200} { 9} 'Ignore Base Geometry Texture Alpha',
        {0x00000400} {10} '',
        {0x00000800} {11} 'Use Alpha Sorting',
        {0x00001000} {12} '',
        {0x00002000} {13} 'Dither Shields',
        {0x00004000} {14} '',
        {0x00008000} {15} '',
        {0x00010000} {16} '',
        {0x00020000} {17} '',
        {0x00040000} {18} '',
        {0x00080000} {19} '',
        {0x00100000} {20} '',
        {0x00200000} {21} '',
        {0x00400000} {22} '',
        {0x00800000} {23} '',
        {0x01000000} {24} 'Use Blood Geometry (Weapons Only)',
        {0x02000000} {25} '',
        {0x04000000} {26} '',
        {0x08000000} {27} '',
        {0x10000000} {28} '',
        {0x20000000} {29} '',
        {0x40000000} {30} '',
        {0x80000000} {31} ''
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ]),
    wbGenericModel(True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ENCH, 'Object Effect', [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbFULL,
    wbStruct(ENIT, 'Effect Data', [
      wbInteger('Enchantment Cost', itS32),
      wbInteger('Flags', itU32, wbFlags([
        'No Auto-Calc',
        '',
        'Extend Duration On Recast'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Cast Type', itU8, wbCastEnum),
      wbInteger('Enchantment Amount', itS32),
      wbInteger('Target Type', itU8, wbTargetEnum),
      wbInteger('Enchant Type', itU8, wbEnum([], [
        $06, 'Enchantment',
        $0C, 'Staff Enchantment'
      ])),
      wbFloat('Charge Time'),
      wbFormIDCk('Base Enchantment', [ENCH, NULL]),
      wbFormIDCk('Worn Restrictions', [FLST, NULL])
    ], cpNormal, True, nil),
    wbEffectsReq
  ]);

  {still exists in game code, but not in Starfield.esm}
  wbRecord(EYES, 'Eyes',
    wbFlags(wbFlagsList([
      2, 'Non-Playable'
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
    wbFormIDCk(DNAM, 'Faction Type', [KYWD]),
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
        {0x00010000} 'Ignore Crimes: Piracy',
        {0x00020000} 'Ignore Crimes: Smuggling',
        {0x00040000} 'Report Crimes By Members Against Members'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ], cpNormal, True, nil, 1).SetSummaryKeyOnValue([0]),
    wbFormIDCk(CRGR, 'Shared Crime Faction List', [FLST]),
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
      wbInteger('Piracy', itU16),
      wbFloat('Smuggle Multiplier')
    ], cpNormal, False, nil, 7)
    .SetSummaryKeyOnValue([0,1]),
    wbArray(PRIS, 'Prisons',
      wbStruct('Prison Location', [
        wbFormIDCk('Prison Door Marker', [NULL, REFR]),
        wbFormIDCk('Ship Landing Marker', [NULL, REFR]),
        wbFormIDCk('Cargo Contraband', [NULL, REFR]),
        wbFormIDCk('Inventory Contraband', [NULL, REFR]),
        wbFormIDCk('Companion Wait Marker', [NULL, REFR])
      ])
      .SetSummaryKey([0])
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed, wbCollapseLocations)
    ),
    wbRArrayS('Ranks', wbFactionRank),
    wbFormIDCk(VEND, 'Vendor Buy/Sell List', [FLST]),
    wbFormIDCk(VENC, 'Merchant Container', [REFR]),
    wbStruct(VENV, 'Vendor Values', [
      wbInteger('Start Hour', itU16),
      wbInteger('End Hour', itU16),
      wbFloat('Radius'),
      wbInteger('Buys Stolen Items', itU8, wbBoolEnumSummary('Fence,')),
      wbInteger('Buy/Sell Everything Not In List?', itU8, wbBoolEnumSummary('Specialized Inventory')),
      wbInteger('Buys NonStolen Items', itU8, wbBoolEnum),
      wbUnused(1) // padding
    ])
    .SetSummaryKeyOnValue([0,1,3,4])
    .SetSummaryPrefixSuffixOnValue(0,'',':00')
    .SetSummaryPrefixSuffixOnValue(1,'to ',':00,')
    .IncludeFlagOnValue(dfSummaryMembersNoName),
    wbPLVD,
    wbConditions,
    wbFormIDCk(VTCK, 'Voice', [FLST, VTYP]),
    wbRStruct('Herd', [
      wbMarkerReq(CRHR),
      wbStruct(HERD, 'Unknown', [
        wbFloat('Search Radius'),
        wbInteger('Min Herd Members', itU16),
        wbInteger('Max Herd Members', itU16),
        wbFloat('Idle Chatter Min Time'),
        wbFloat('Idle Chatter Max Time')
      ]).SetRequired
    ], []),
    wbRStruct('Create Group', [
      wbMarkerReq(CRGP),
      wbFloat(GRPH, 'Formation Radius').SetRequired
    ], [])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AFFE, 'Affinity Event', [
    wbEDID.SetRequired,
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      'Allow Repeated Events',
      'Template Affinity Event',
      'Fill Companion Dialogue'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags).SetRequired,
    wbNLDT,
    wbRArray('Reaction Data',
      wbRStructSK([0], 'Follower', [
        wbFormIDCk(NNAM, 'Actor', [NPC_]),
        wbFormIDCk(RNAM, 'Reaction Value', [GLOB]).SetRequired
      ], []).SetSummaryKey([1]).IncludeFlag(dfCollapsed)
    ),
    wbFormIDCk(ANAM, 'Actor Value', [AVIF]),
    wbFormIDCk(ENAM, 'Event Size', [GLOB]),
    wbFormIDCk(DNAM, 'Distance to Player', [GLOB]),
    wbFormIDCk(CNAM, 'Cooldown in Minutes', [GLOB]),
    wbFormIDCk(BNAM, 'Required Faction', [FACT]),
    wbFormIDCK(PNAM, 'Add to Event', [AFFE])
  ])
  .SetSummaryKey([2])
  .IncludeFlag(dfSummaryMembersNoName)
  ;

  {subrecords checked against Starfield.esm}
  wbRecord(FURN, 'Furniture',
    wbFlags(wbFlagsList([
       2, 'Heading Marker',
       4, 'Non Occluder',
       6, 'Never Fades',
       7, 'Is Template',
       8, 'Must Update Anims',
       9, 'Hidden From Local Map',
      10, 'Headtrack Marker',
      11, 'Used as Platform',
      13, 'Pack-In Use Only',
      15, 'Unknown 15', // was Has Distant LOD
      16, 'Random Anim Start',
      17, 'Dangerous',
      20, 'Ignore Object Interaction',
      23, 'Is Marker',
      25, 'Obstacle',
      26, 'Navmesh - Filter',
      27, 'Navmesh - Bounding Box',
      28, 'Navmesh - Only Cut',
      29, 'Navmesh - Ignore Erosion',
      30, 'Navmesh - Ground'
    ])).SetFlagHasDontShow(26, wbFlagNavmeshFilterDontShow)
       .SetFlagHasDontShow(27, wbFlagNavmeshBoundingBoxDontShow)
       .SetFlagHasDontShow(28, wbFlagNavmeshOnlyCutDontShow)
       .SetFlagHasDontShow(29, wbFlagNavmeshIgnoreErosionDontShow)
       .SetFlagHasDontShow(30, wbFlagNavmeshGroundDontShow), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbFTYP,
    wbNTRM,
    wbByteColors(PNAM, 'Marker Color (Unused)'),
    wbALSH,
    wbFormIDCk(WTFM, 'Water', [WATR]),
    wbATTX,
    wbInteger(FNAM, 'Flags', itU16, wbFlags([
      {0x0001} 'Unknown 0',
      {0x0002} 'Ignored By Sandbox'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(JNAM, 'Activation Angle - For Player', itU16),
    wbEmpty(INAM, 'Activation Angle - Invert Facing'),
    wbContainerItems,
    wbMNAMFurnitureMarker,
    wbInteger(GNAM, 'Activation Angle - For Sitting Actor', itU16),
    wbStructSK(WBDT, [0], 'Workbench Data', [
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
       {10} 'Extractor',
       {11} 'Research'
      ])),
      wbInteger('Uses Skill', itS8, wbSkillEnum)
    ], cpNormal, True, nil, 1),
    wbFormIDCk(NAM1, 'Associated Form', sigBaseObjects),
    wbFormIDCk(FTMP, 'Furniture Template', [FURN]),
    wbRArray('Marker Entry Points', wbStruct(FNPR, 'Marker', [
      wbInteger('Type', itU16, wbFurnitureAnimTypeEnum),
      wbInteger('Entry Points', itU16, wbFurnitureEntryTypeFlags).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ]).SetSummaryKeyOnValue([0,1])
    .SetSummaryPrefixSuffixOnValue(0, '[','] ')
    ),
    wbString(XMRK, 'Marker Model'),
    wbSNAMMarkerParams,
    wbArray(NNAM, 'Marker Files', wbStruct('Marker', [
      wbString('Name'),
      wbString('Model FileName')
      ]).SetSummaryKey([0,1])
      .SetSummaryMemberPrefixSuffix(0,'[','] ')
      .IncludeFlag(dfSummaryMembersNoName)
      ),
    //wbObjectTemplate, not in Starfield.esm, but based on the STOP below likely...
    wbEmpty(STOP, 'Marker', cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(GLOB, 'Global',
    wbFlags(wbFlagsList([
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
  ])
  .SetSummaryKey([2]);

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
  ])
  .SetSummaryKey([2])
  .IncludeFlag(dfIndexEditorID);

  {subrecords checked against Starfield.esm}
  wbRecord(KYWD, 'Keyword',
    wbFlags(wbFlagsList([
      {0x00080000} {15} 15, 'Restricted'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbCNAM.SetRequired,
    wbString(DNAM, 'Notes'),
    wbInteger(TNAM, 'Type', itU32, wbKeywordTypeEnum, cpNormal, True),
    wbUnknown(FNAM).SetRequired, // always present, no UI element in CK, and always written as zeros
    wbFormIDCk(DATA, 'Attraction Rule', [AORU]),
    wbString(ENAM, 'Flash Linkage Name'),
    wbFULL
  ])
  .SetSummaryKey([8,4])
  .SetSummaryMemberPrefixSuffix(4, '[Type] ','')
  ;

  {subrecords checked against Starfield.esm}
  wbRecord(FFKW, 'Form Folder Keyword List', [
    wbEDID,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(LCRT, 'Location Reference Type', [
    wbEDID,
    wbBaseFormComponents,
    wbCNAM,
    wbUnknown(TNAM),
    wbUnknown(FNAM)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AACT, 'Action',
    wbFlags(wbFlagsList([
      {0x00080000} {15} 15, 'Restricted'
    ])), [
    wbEDID,
    wbCNAM,
    wbString(DNAM, 'Notes'),
    wbInteger(TNAM, 'Type', itU32, wbKeywordTypeEnum),
    wbUnknown(FNAM),
    wbFULL,
    wbFormIDCk(DATA, 'AttractionRule', [NULL, AORU]),
    wbString(ENAM, 'Flash Linkage Name')
  ]).SetSummaryKey([2]);

  {subrecords checked against Starfield.esm}
  wbRecord(TXST, 'Texture Set', [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbRStruct('Textures (RGB/A)', [
      wbString(TX00, 'Diffuse'),
      wbString(TX01, 'Normal/Gloss'),
      (* not seen in
      wbString(TX03, 'Glow'),
      wbString(TX04, 'Height'),
      wbString(TX05, 'Environment'),
      wbString(TX02, 'Wrinkles'), {TX05 TX02 TX06 Yes this has to go here}
      wbString(TX06, 'Multilayer'),
      wbString(TX07, 'Smooth Spec')
      *)
      wbString(TX08, 'Metal'),
      wbString(TX09, 'Rough'),
      wbString(TX17, 'AO'),
      wbString(TX19, 'Opacity')
    ], []).SetSummaryKey([0]).IncludeFlag(dfAllowAnyMember),
    wbDODT,
    wbInteger(DNAM, 'Flags', itU16, wbFlags([
      {0x0001} 'No Specular Map',
      {0x0002} 'Facegen Textures',
      {0x0004} 'Has Model Space Normal Map',
      {0x0010} 'Default To Box Decal'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbString(MNAM, 'Material')
  ]).SetSummaryKey([3, 4]);

  {subrecords checked against Starfield.esm}
  wbRecord(HDPT, 'Head Part',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Non-Playable'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      {0x01} 'Playable',
      {0x02} 'Male',
      {0x04} 'Female',
      {0x10} 'Is Extra Part',
      {0x20} 'Use Solid Tint',
      {0x40} 'Uses Body Texture',
      {0x80} 'Hide with "HideEar" Morph'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(PNAM, 'Type', itU32, wbEnum([
      { 0} 'Misc',
      { 1} 'Face',
      { 2} 'Right Eye',
      { 3} 'Hair',
      { 4} 'Facial Hair',
      { 5} 'Scar',
      { 6} 'Eyebrows',
      { 7} 'Jewelry',
      { 8} 'Meatcaps',
      { 9} 'Teeth',
      {10} 'Head Rear',
      {11} 'Extra Hair',
      {12} 'Left Eye',
      {13} 'Eyelashes',
      {14} 'Creature Head',
      {15} 'Creature Torso',
      {16} 'Creature Arms',
      {17} 'Creature Legs',
      {18} 'Creature Tail',
      {19} 'Creature Wings'
    ]), cpNormal, True),
    wbRArrayS('Extra Parts',
      wbFormIDCk(HNAM, 'Part', [HDPT])
    ),
    wbString(NAM2, 'Color Mapping')
      .SetLinksToCallbackOnValue(function(const aElement: IwbElement): IwbElement
      begin
        Result := nil;
        if not Assigned(aElement) then
          Exit;
        var lAVMDName := aElement.NativeValue;
        if not VarIsStr(lAVMDName) then
          Exit;

        var lFile := aElement._File;
        if not Assigned(lFile) then
          Exit;

        Result := lFile.RecordFromIndexByKey[wbIdxSimpleGroup, lAVMDName];
      end)
      .SetToStr(wbToStringFromLinksToMainRecordName),
    wbString(NAM3, 'Mask'),
    wbFormIDCk(TNAM, 'Texture Set', [TXST]),
    wbFormIDCk(RNAM, 'Valid Races', [FLST]),
    wbFormIDCk(MNAM, 'Morph', [MRPH]),
    wbCTDAs
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ASPC, 'Acoustic Space', [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbSoundReference(ASLS, 'Looping Sound'),
    wbSoundReference(WED0, 'Interior Sound'),
    wbSoundReference(WED1, 'Exterior Sound'),
    wbFormIDCk(AAMB, 'Ambience Set', [AMBS]),
    wbFormIDCk(AMUS, 'Music Type', [MUSC]),
    wbFormIDCk(BNAM, 'Environment Type', [REVB]),
    wbFloat(AEAR, 'Exterior/Weather Attenuation (RTPC)', cpNormal, True),
    wbFloat(FLTV, 'Interior:Exterior Ratio (RTPC)'),
    wbInteger(XTRI, 'Is Interior', itU8, wbBoolEnum, cpNormal, True),
    wbInteger(BOLV, 'Allow Exterior', itU8, wbBoolEnum, cpNormal, True),
    wbInteger(DEVT, 'Sound Detection Level', itU32, wbSoundLevelEnum, cpNormal, True),
    wbInteger(ASDF, 'Disable Flags', itU64, wbFlags([
      'Environment Type',
      'Music Type',
      'Sound Detection Level',
      'Looping Sound',
      'Exterior/Weather Attenuation',
      'Is Interior',
      'Crowd Walla',
      'Affects Parented Sound Markers'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
  ]);

  {subrecords checked against Starfield.esm}
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
      28, 'Navmesh - Only Cut',
      29, 'Navmesh - Ignore Erosion',
      30, 'Navmesh - Ground'
    ])).SetFlagHasDontShow(26, wbFlagNavmeshFilterDontShow)
       .SetFlagHasDontShow(27, wbFlagNavmeshBoundingBoxDontShow)
       .SetFlagHasDontShow(28, wbFlagNavmeshOnlyCutDontShow)
       .SetFlagHasDontShow(29, wbFlagNavmeshIgnoreErosionDontShow)
       .SetFlagHasDontShow(30, wbFlagNavmeshGroundDontShow), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbDEFL,
    wbXALG,
    wbBaseFormComponents,
    wbPTT2,
    wbFULL,
    wbGenericModel(True),
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbInteger(DATA, 'Mass Override Flags', itU8, wbFlags([
      '',
      'Use Mass Override',
      'Scale'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbSoundReference(MSLS, 'Looping Sound'),
    wbFloat(MSMO, 'Mass Override Value')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(IDLM, 'Idle Marker',
    wbFlags(wbFlagsList([
      {0x20000000} 29, 'Child Can Use'
    ])), [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbKeywords,
    wbInteger(IDLF, 'Flags', itU8, wbFlags([
      'Run in Sequence',
      'Unknown 1',
      'Do Once',
      'Unknown 3',
      'Ignored by Sandbox',
      'Ignore Conditions For Sandbox'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbRStruct('Animations', [
      wbInteger(IDLC, 'Animation Count', itU32, nil, cpBenign),
      wbFloat(IDLT, 'Idle Timer Setting', cpNormal, True),
      wbArray(IDLA, 'Animations', wbFormIDCk('Animation', [IDLE]), 0, nil, wbIDLAsAfterSet, cpNormal, True)
    ], []),
    wbGenericModel(True),
    wbFormIDCk(RNAM, 'Actor Action', [AACT]),
    wbFormIDCk(QNAM, 'Animation Flavor', [KYWD]),
    wbFormIDCk(PNAM, 'Animation Archetype', [KYWD])
  ], False, nil, cpNormal, False);

  {subrecords checked against Starfield.esm}
  wbRecord(PROJ, 'Projectile',
    wbFlags(wbFlagsList([
      15, 'Apply Charge Multiplier'
    ])), [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbDEFL,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbDEST,
    wbUnused(DATA, True),
    wbStruct(PROD, 'Data', [
    {  0} wbInteger('Flags', itU32, wbFlags([
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
            {0x00800} 'Penetrates Through Actors',
            {0x01000} 'Continuous Update',
            {0x02000} 'Seeks Target',
            {0x04000} 'Predictive Aim Assist',
            {0x08000} 'Align On Projectile',
            {0x10000} 'Continuous Impacts',
            {0x20000} 'No Explosive Indicator',
            {0x40000} 'Variable Intensity',
            {0x80000} 'Apply Charge Multiplier'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    {  4} wbFloat('Gravity'),
    {  8} wbFloat('Speed'),
    { 12} wbFloat('Range'),
    { 16} wbFormIDCk('Light', [LIGH, NULL]),
    { 20} wbFormIDCk('Muzzle Flash - Light', [LIGH, NULL]),
    { 24} wbFloat('Explosion - Proximity'),
    { 28} wbFloat('Explosion - Timer'),
    { 32} wbFormIDCk('Explosion', [EXPL, NULL]),
    { 36} wbFloat('Muzzle Flash - Duration'),
    { 40} wbFloat('Fade Duration'),
    { 44} wbFloat('Impact Force'),
    { 48} wbFormIDCk('Default Weapon Source', [WEAP, NULL]),
    { 52} wbFloat('Cone Spread'),
    { 56} wbFloat('Collision Radius'),
    { 60} wbFloat('Lifetime'),
    { 64} wbFloat('Relaunch Interval'),
    { 68} wbFormIDCk('Decal Data', [TXST, NULL]),
    { 72} wbFormIDCk('Collision Layer', [COLL, NULL]),
    { 76} wbInteger('Tracer Frequency', itU8),
    { 77} wbFormIDCk('VATS Projectile', [PROJ, NULL]),
    { 81} wbLenString('Muzzle Flash - Particle Define').IncludeFlag(dfHasZeroTerminator),
          wbFloat('Seek Strength'),
          wbInteger('Sound Activation Condition', itU32, wbEnum([
            'Play On Spawn',
            'Play On Near Miss Player',
            'Default'
          ])),
          wbInteger('Type', itU8, wbEnum([
            'Missile',
            'Lobber',
            'Beam',
            'Flame',
            'Cone',
            'Barrier',
            'Arrow',
            'Plasma',
            'Emitter'
          ])),
          wbLenString('Particle Define').IncludeFlag(dfHasZeroTerminator),
          wbFloat('Tracer Speed'),
          wbFloat('ZeroG Recoil Strength'),
          wbFloat('ZeroG Recoil Length'),
          wbFloat('Explosion - Delay Before Removal')
    ]).SetRequired,

    wbRStructSK([0], 'Muzzle Flash Model', [
      wbString(NAM1, 'Model FileName'),
      wbFLLD
      //wbModelInfo(NAM2)
    ], [], cpNormal, True),
    wbSoundReference(PRAS, 'Active Sound'),
    wbSoundReference(PRCS, 'Countdown End Sound'),
    wbSoundReference(PRDS, 'Disable Sound'),
    wbInteger(VNAM, 'Sound Level', itU32, wbSoundLevelEnum, cpNormal, True),
    wbFormIDCk(NAM3, 'Curve Table', [CURV])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(HAZD, 'Hazard', [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD, NULL]),
    wbStruct(DNAM, 'Data', [
      { 0} wbSoundReference,
      {40} wbFormIDCk('Effect', [SPEL, ENCH, NULL]),
      {44} wbFormIDCk('Light', [LIGH, NULL]),
      {48} wbFormIDCk('Impact Data Set', [IPDS, NULL]),
      {52} wbFloat('Radius'),
      {56} wbFloat('Lifetime'),
      {60} wbFloat('Image Space Radius'),
      {64} wbFloat('Target Interval'),
           wbStruct('Taper Effectiveness', [
      {68}   wbFloat('Full Effect Radius'),
      {72}   wbFloat('Taper Weight'),
      {76}   wbFloat('Taper Curse')
           ]),
      {80} wbFloat('Gravity'),
      {84} wbInteger('Limit', itU32),
      {88} wbInteger('Flags', itU32, wbFlags([
             {0x01} 'Affects Player Only',
             {0x02} 'Inherit Duration from Spawn Spell',
             {0x04} 'Align to Impact Normal',
             {0x08} 'Inherit Radius from Spawn Spell',
             {0x10} 'Drop to Ground',
             {0x20} 'Taper Effectiveness by Proximity',
             {0x40} 'Gravity Point Source',
             {0x80} 'Gravity Override'
           ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
      {92}
    ]).SetRequired,
    wbCTDAs
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(NAVM, 'Navmesh',
    wbFlags(wbFlagsList([
      11, 'Initially Disabled',
      18, 'Compressed',
      26, 'AutoGen',
      31, 'Navmesh Gen Cell'
    ]), [18]), [
    wbEDID,
    wbVMAD,
    wbBaseFormComponents,
    wbNVNM,
    IfThen(wbSimpleRecords,
      wbByteArray(MNAM),
      wbArrayS(MNAM, 'PreCut Map Entries',
        wbStructSK([0], 'PreCut Map Entry', [
          wbFormID('Reference'),
          wbArrayS('Triangles',
            wbInteger('Triangle', itU16).SetLinksToCallback(wbTriangleLinksTo),
          -2).IncludeFlag(dfCollapsed)
        ]).IncludeFlag(dfCollapsed)
      ).IncludeFlag(dfCollapsed)
    )
  ], False, wbNAVMAddInfo);

  {subrecords checked against Starfield.esm}
  wbRecord(NAVI, 'Navmesh Info Map', [
    wbEDID,
    wbInteger(NVER, 'Version', itU32),
    wbRArrayS('Navmesh Infos',
      wbStructSK(NVMI, [0], 'Navmesh Info', [
        wbFormIDCk('Navmesh', [NAVM])
          .IncludeFlag(dfSummaryNoName),
        wbInteger('Category', itU32,
          wbEnum([], [
            0, 'Is Edited',
           32, 'Is Island',
           64, 'Not Edited'
          ])
        ),
        wbArray('Unknown', wbFloat, 4),
        wbArrayS('Edge Links',
          wbFormIDCk('Navmesh', [NAVM]),
        -1).IncludeFlag(dfCollapsed),
        wbArrayS('Preferred Edge Links',
          wbFormIDCk('Navmesh', [NAVM]),
        -1).IncludeFlag(dfCollapsed),
        wbArrayS('Door Links',
          wbStructSK([1], 'Door Link', [
            wbInteger('CRC Hash', itU32, wbCRCValuesEnum)
              .SetDefaultEditValue('PathingDoor'),
            wbFormIDCk('Door Ref', [REFR])
          ]).SetSummaryKey([1])
            .IncludeFlag(dfCollapsed)
            .IncludeFlag(dfSummaryMembersNoName),
        -1).IncludeFlag(dfCollapsed),
        wbArray('Traversals',
          wbStruct('Traversal', [
            wbInteger('Type', itU32, wbCRCValuesEnum)
              .SetDefaultEditValue('PathingTraversalLink'),
            wbFormIDCk('Cell or Object', [CELL, REFR]),
            wbFormIDCk('Traversal', [TRAV, REFR]),
            wbVec3('From Position'),
            wbVec3('To Position'),
            wbFloat,
            wbFloat,
            wbFloat,
            wbInteger('Flags', itU32,
              wbFlags(wbSparseFlags([
                2, 'Unknown 2'
              ]))
            ).IncludeFlag(dfCollapsed, wbCollapseFlags),
            wbFormIDCk('From Navmesh', [NAVM]),
            wbFormIDCk('To Navmesh', [NAVM])
          ]).SetSummaryKey([2, 1, 3, 9, 4, 10])
            .SetSummaryMemberPrefixSuffix(2, '', '')
            .SetSummaryMemberPrefixSuffix(1, 'in/with ', '')
            .SetSummaryMemberPrefixSuffix(3, 'from ', '')
            .SetSummaryMemberPrefixSuffix(9, 'in ', '')
            .SetSummaryMemberPrefixSuffix(4, 'to ', '')
            .SetSummaryMemberPrefixSuffix(10, 'in ', '')
            .IncludeFlag(dfCollapsed)
            .IncludeFlag(dfSummaryMembersNoName),
        -1).IncludeFlag(dfCollapsed),
        wbStruct('Optional Island Data', [
          wbInteger('Has Island Data', itU8, wbBoolEnum)
            .SetAfterSet(wbUpdateSameParentUnions),
          wbUnion('Island Data', wbNAVIIslandDataDecider, [
            wbEmpty('Island Data'),
            wbStruct('Island Data', [
              wbVec3('Min'),
              wbVec3('Max'),
              wbArray('Triangles',
                wbStruct('Triangle', [
                  wbInteger('Vertex 0', itU16),
                  wbInteger('Vertex 1', itU16),
                  wbInteger('Vertex 2', itU16)
                ]).IncludeFlag(dfCollapsed),
              -1).IncludeFlag(dfCollapsed),
              wbArray('Vertices',
                wbVec3('Vertex'),
              -1).IncludeFlag(dfCollapsed)
            ]).SetSummaryKey([2])
              .IncludeFlag(dfCollapsed)
              .IncludeFlag(dfSummaryMembersNoName)
          ]).IncludeFlag(dfCollapsed)
        ]).SetSummaryKey([1])
          .IncludeFlag(dfCollapsed)
          .IncludeFlag(dfSummaryMembersNoName),
        wbStruct('Pathing Cell', [
          wbInteger('CRC Hash', itU32, wbCRCValuesEnum)
            .SetDefaultEditValue('PathingCell'),
          wbFormIDCk('Parent World', [WRLD, NULL])
            .IncludeFlag(dfSummaryExcludeNull),
          wbUnion('', wbNAVIParentDecider, [
            wbStruct('Coordinates', [
              wbInteger('Grid Y', itS16),
              wbInteger('Grid X', itS16)
            ]).SetSummaryKey([0, 1])
              .SetSummaryMemberPrefixSuffix(0, '<X: ', '')
              .SetSummaryMemberPrefixSuffix(1, 'Y: ', '>')
              .SetSummaryDelimiter(', ')
              .IncludeFlag(dfCollapsed)
              .IncludeFlag(dfSummaryMembersNoName),
            wbFormIDCk('Parent Cell', [CELL])
          ]).IncludeFlag(dfCollapsed)
        ]).SetSummaryKey([1, 2])
          .IncludeFlag(dfCollapsed)
          .IncludeFlag(dfSummaryMembersNoName),
        wbUnknown(1),
        wbArray('Unknown',
          wbInteger('Type', itU32, wbCRCValuesEnum),
        -1)
      ]).SetSummaryKeyOnValue([0, 8, 6, 7])
        .SetSummaryPrefixSuffixOnValue(0, '', '')
        .SetSummaryPrefixSuffixOnValue(8, 'in ', '')
        .SetSummaryPrefixSuffixOnValue(6, 'with ', '')
        .SetSummaryPrefixSuffixOnValue(7, 'is island with ', '')
        .IncludeFlag(dfCollapsed)
        .IncludeFlag(dfSummaryMembersNoName)
    ).IncludeFlag(dfCollapsed),
    wbStruct(NVPP, 'Precomputed Pathing', [
      wbArray('Precomputed Paths',
        wbArray('Path',
          wbFormIDCk('Navmesh', [NAVM]),
        -1).IncludeFlag(dfCollapsed),
      -1).IncludeFlag(dfCollapsed),
      wbArrayS('Road Marker Index',
        wbStructSK([1], 'Road Marker', [
          wbFormIDCk('Navmesh', [NAVM]),
          wbInteger('Index', itU32)
        ]).IncludeFlag(dfCollapsed),
      -1).IncludeFlag(dfCollapsed)
    ]).IncludeFlag(dfCollapsed)
    //wbArrayS(NVSI, 'Deleted Navmeshes', wbFormIDCk('Navmesh', [NAVM])).IncludeFlag(dfCollapsed)
  ]);


  {subrecords checked against Starfield.esm}
  wbRecord(EXPL, 'Explosion', [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbDEFL,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbEITM,
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD]),
    wbStruct(ENAM, 'Data', [
      wbFormIDCk('Light', [LIGH, NULL]),
      wbSoundReference,                                   //struct // +0x38   //same struct as STAT's STLS, could be optimization reusing same reading code or the same struct
      wbSoundReference('Unused'),                         //struct unused     //same struct as STAT's STLS, could be optimization reusing same reading code or the same struct
      wbFormIDCk('Impact Data Set', [IPDS, NULL]),
      wbFormIDCk('Placed Object', sigBaseObjects),
      wbFormIDCk('Spawn Projectile', [PROJ, NULL]),
      wbFormIDCk('Condition Form', [CNDF, NULL]),
      wbFloat('Force'),
      wbFloat('Damage'),
      wbFloat('Inner Radius'),
      wbFloat('Outer Radius'),
      wbFloat('IS Radius'),
      wbFloat('Vertical Offset Mult'),
      wbInteger('Flags', itU32, wbFlags([
        {0x00000001} 'Taper Effectiveness',
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
      wbInteger('Sound Level', itU32, wbSoundLevelEnum),
      wbFloat('Placed Object AutoFade Delay'),
      wbInteger('Stagger', itU32, wbEnum([
        'None',
        'Small',
        'Medium',
        'Large',
        'Extra Large'
      ])),
      wbStruct('Spawn', [
        wbFloat('X', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
        wbFloat('Y', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
        wbFloat('Z', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
        wbFloat('Spread Degrees', cpNormal, True, 1, -1, nil, wbNormalizeToRange(0, 180)),
        wbInteger('Count', itU32)
      ]),
      wbFloat('Duration')
    ]),
    wbDamageTypeArray('Damage Type')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(DEBR, 'Debris', [
    wbEDID,
    wbRArray('Models', wbDebrisModel(wbMODT), cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(IMGS, 'Image Space', [
    wbEDID,
    wbREFL,
    wbFormIDCk(RFDP, 'Reflection Parent', [IMGS]),
    wbRDIF
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(IMAD, 'Image Space Adapter', [
    wbEDID,
    wbREFL
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
      wbCTDAsCountReq
    ], []),
    wbFormIDCk(ANAM, 'Add To List', [FLST, NULL])
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
          wbInteger('Quest Stage', itU16,
            function(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string
            begin
              var lMainRecord: IwbMainRecord;

              var lContainer: IwbContainerElementRef;
              if wbTryGetContainerRefFromUnionOrValue(aElement, lContainer) then begin
                var lElement := lContainer.ElementByName['Quest'];
                if not wbTryGetMainRecord(lElement, lMainRecord) then
                  lMainRecord := nil;
              end else
                lMainRecord := nil;

              Result := wbQuestStageToStr(aInt, aElement, aType, 'Quest', lMainRecord, False);
            end,
            wbIntPrefixedStrToInt)
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
           {15} 'Set Text', // EPFT=7
           {16} 'Legendary Magic Effect Event' // EPFT=9
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
          {8} 'AVIF',
          {9} 'Replacement Projectile'
        ])),
        // case(EPFT) of
        // 1: EPFD=float
        // 2: EPFD=float,float
        // 3: EPFD=LVLI
        // 4: EPFD=SPEL, EPF2=lstring, EPF3=int32 flags
        // 5: EPFD=SPEL
        // 6: EPFD=string
        // 7: EPFD=lstring
        // 8: EPFD=AVIF
        // 9: EPFD=PROJ

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
                wbActorValue(), // wbInteger('Actor Value', itU32, wbEPFDActorValueToStr, wbEPFDActorValueToInt),
                wbFloat('Float')
              ]),
          {9} wbFormIDCk('Projectile',[PROJ])
        ], cpNormal, False{, wbEPFDDontShow})
      ], [], cpNormal, False{, wbPERKPRKCDontShow}),
      wbEmpty(PRKF, 'End Marker', cpIgnore, True)
    ], []);

  {subrecords checked against Starfield.esm}
  wbRecord(PERK, 'Perk',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Non-Playable'
    ])), [
    wbEDID.SetRequired,
    wbVMADFragmentedPERK,
    wbFULL,
    wbDESCReq(),
    wbStruct(DATA, 'Data', [
      wbInteger('Perk Category', itU8, wbPerkCategoryEnum),
      wbInteger('Perk Skill Group', itU8, wbPerkSkillGroupEnum),
      wbFromSize(4, wbInteger('Crew Assignment Requirement', itU8, wbEnum([
        {0} 'No Requirements (Any Role)',
        {1} 'Ship',
        {2} 'Outpost'
      ]))),
      wbInteger('Flags', itU8, wbFlags([
        {0x0001} 'Trait',
        {0x0002} 'Playable',
        {0x0004} 'Hidden',
        {0x0008} 'Crew',
        {0x0010} 'Background',
        {0x0020} 'Hidden on Data Menu'
      ]))
        .SetDefaultEditValue('01')
        .IncludeFlag(dfCollapsed, wbCollapseFlags)
     ], cpNormal, True),
    wbFormIDCk(TNAM, 'Restriction' , [KYWD]),
    wbFormIDCk(UNAM, 'Training' , [PERK]),
    wbString(GNAM, 'Perk Icon'),

    wbRStructs('Ranks', 'Rank', [
      wbEmpty(PRRK, 'Header Marker').SetRequired,
      wbRArrayS('Effects', wbPerkEffect),
      wbCTDAs,
      wbActivityTracker,
      wbDESC.SetRequired,
      wbEmpty(PRRF, 'End Marker').SetRequired
    ], [], cpNormal, True),
    wbRArray('Bonus Perks', wbFormIDCk(RNAM, 'Perk', [PERK]))

    (*
    //wbString(ICON, 'Image'), not in Starfield.esm
    //wbCTDAs,                 not in Starfield.esm
    wbFormIDCk(SNAM, 'Sound', [SNDR]),
    wbFormIDCK(NNAM, 'Next Perk', [PERK, NULL]),
    wbString(FNAM, 'SWF'),
    *)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(BPTD, 'Body Part Data', [
    wbEDID,
    wbBaseFormComponents,
    wbGenericModel(True),
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
        wbStruct(BPD2, 'Data', [
          wbFloat('Damage Mult'),                                     //     uint32 +0x00
          wbInteger('Flags', itU8, wbFlags([                          //     uint8  +0x08 - flags of some kind
            {0x01} 'Severable',
            {0x02} 'Hit Reaction',
            {0x04} 'Hit Reaction - Default',
            {0x08} 'Explodable',
            {0x10} 'Cut - Meat Cap Sever',
            {0x20} 'On Cripple',
            {0x40} 'Explodable - Absolute Chance',
            {0x80} 'Show Cripple Geometry'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
          wbInteger('Part Type', itU8, wbEnum([                       //     uint8  +0x09
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
          wbInteger('Health Percent', itU8),                          //     uint8  +0x0A
          wbFormIDCk('Actor Value', [AVIF, NULL]),                    //     formid +0x28
          wbInteger('To Hit Chance', itU8),                           //     uint8  +0x0B
          wbFormIDCk('On Cripple - Art Object', [ARTO, NULL]),        //     formid +0x30
          wbFormIDCk('On Cripple - Debris', [DEBR, NULL]),            //     formid +0x10
          wbFormIDCk('On Cripple - Explosion', [EXPL, NULL]),         //     formid +0x18
          wbFormIDCk('On Cripple - Impact DataSet', [IPDS, NULL]),    //     formid +0x20
          wbFloat('On Cripple - Debris Scale'),                       //     uint32 +0x04
          wbInteger('On Cripple - Debris Count', itU8),               //     uint8  +0x0C
          wbInteger('On Cripple - Decal Count', itU8)                 //     uint8  +0x0D
       ], cpNormal, True),
//        wbString(NAM1, 'Limb Replacement Model', 0, cpNormal, True),
        wbString(NAM4, 'Gore Effects - Target Bone', 0, cpNormal, True),
//        wbModelInfo(NAM5),
        wbString(ENAM, 'Hit Reaction - Start'),
        wbString(FNAM, 'Hit Reaction - End'),
//        wbFormIDCk(BNAM, 'Gore Effects - Dismember Blood Art', [ARTO]),
        wbFormIDCk(INAM, 'Gore Effects - Blood Impact Material Type', [MATT]),
        wbFormIDCk(JNAM, 'On Cripple - Blood Impact Material Type', [MATT]),
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
    wbODTYReq,
    wbBaseFormComponents,
    wbGenericModel(True),
    wbInteger(DATA, 'Node Index', itS32, nil, cpNormal, True),
    wbFormIDCk(LNAM, 'Light', [LIGH]),
    wbReflection(PSDF),
    wbStruct(DNAM, 'Data', [
      wbInteger('Master Particle System Cap', itU16),
      wbInteger('Flags', itU16, wbEnum([
        'No Master Particle System',
        'Master Particle System',
        'Always Loaded',
        'Master Particle System and Always Loaded'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ], cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AVIF, 'Actor Value Information', [
    wbEDID,
    wbFULL,
    wbNLDT,
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
      'Resource',
      'Anim Graph Variable'
    ])),
    wbFloat(NAM2, 'Min'),
    wbFloat(NAM3, 'Max')
  ])
  .SetSummaryKey([2]);

  {subrecords checked against Starfield.esm}
  wbRecord(CAMS, 'Camera Shot', [
    wbEDID,
    wbGenericModel(True),
    wbKeywords,
    wbNLDT,
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
        {0x00000100} 'Selectable Scene Camera',
        {0x00000200} 'Free Cam',
        {0x00000400} 'Unknown 10'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
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
      wbVec3('Rotation Offset')
    ], cpNormal, True, nil, 9),
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD]),
    wbString(GNAM, 'Animation')
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
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbRArray('Camera Shots', wbFormIDCk(SNAM, 'Camera Shot', [CAMS]))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(VTYP, 'Voice Type', [
    wbEDID,
    wbInteger(DNAM, 'Flags', itU8, wbFlags([
      'Allow Default Dialog',
      'Female'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbFormIDCk(ANAM, 'Animation Face Archetype', [KYWD]),
    wbInteger(PNAM, 'Pronoun Override', itU8, wbEnum([
      'Unselected',
      'He/Him',
      'She/Her',
      'They/Them'
    ]))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(MATT, 'Material Type', [
    wbEDID,
    wbFormIDCk(PNAM, 'Material Parent', [MATT, NULL]),
    wbString(MNAM, 'Material Name'),
    wbFloatColors(CNAM, 'Havok Display Color'),
    wbFloat(BNAM, 'Buoyancy'),
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      'Stair Material',
      'Arrows Stick',
      'Can Tunnel',
      'Is Slippery'
    ], False)).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbFormIDCk(HNAM, 'Havok Impact Data Set', [IPDS]),
    wbString(ANAM, 'Breakable FX'),
    wbFLLD
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(IPCT, 'Impact', [
    wbEDID,
    wbBaseFormComponents,
    wbGenericModel(True),
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
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Impact Result', itU8, wbEnum([
         {0} 'Default',
         {1} 'Destroy',
         {2} 'Bounce',
         {3} 'Impale',
         {4} 'Stick'
      ])),
      wbUnused(2) // padding
    ], cpNormal, True),
    wbArray(GNAM, 'Projected Decals', wbFormIDCk('Projected Decal', [PDCL])),
    wbArray(HNAM, 'Scatter Projected Decals', wbFormIDCk('Projected Decal', [PDCL])),
    wbDODT,
    wbSoundReference(IDSH, 'Impact Sound - Default'),
    wbSoundReference(IDP1, 'Impact Sound - Player 1st/Shooter'),
    wbSoundReference(IDP3, 'Impact Sound - Player 3rd/Target'),
    wbFormIDCk(NAM3, 'Footstep Explosion', [EXPL]),
    wbFormIDCk(NAM2, 'Hazard', [HAZD]),
    wbFloat(FNAM, 'Footstep Particle Max Dist'),
    wbFloat(INAM, 'Decal Lifetime')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(IPDS, 'Impact Data Set', [
    wbEDID,
    wbRArrayS('Data', wbStructSK(PNAM, [0], '', [
      wbFormIDCk('Material Type', [MATT]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole),
      wbFormIDCk('Impact Data', [IPCT])
    ])),
    wbFormIDCk(ENAM, 'Parent Impact Data Set', [IPDS])
  ]);

  var lDontShowForCellLocation: TwbDontShowCallback :=
    function(const aElement: IwbElement): Boolean
    begin
      var lContainer: IwbContainer;
      if not Supports(aElement, IwbContainer, lContainer) then
        Exit(False);

      var lLocation := lContainer.ElementByPath['..\Location'];
      if not Assigned(lLocation) then
        Exit(False);

      var lMainRecord: IwbMainRecord;
      if not Supports(lLocation.LinksTo, IwbMainRecord, lMainRecord) then
        Exit(False);

      Result := lMainRecord.Signature = CELL;
    end;

  {subrecords checked against Starfield.esm}
  wbRecord(LCTN, 'Location',
    wbFlags(wbFlagsList([
      {0x00000800} 11, 'Interior Cells Use Ref Location for world map player marker',
      {0x00020000} 17, 'Off Limits',
      {0x00080000} 19, 'Can''t Wait',
      {0x00100000} 20, 'Public Area'
    ])), [
    wbEDID,
    wbPRPS,

    wbArrayS(ACPR, 'Added Persist Location References', wbStructSK([0], 'References', [
      wbFormIDCk('Actor', sigReferences, False, cpBenign),
      wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
      wbInteger('Grid Y', itS16, nil, cpBenign, True, lDontShowForCellLocation),
      wbInteger('Grid X', itS16, nil, cpBenign, True, lDontShowForCellLocation),
      wbInteger('Unknown', itS32, nil, cpBenign)
    ])),
    wbArrayS(LCPR, 'Master Persist Location References', wbStructSK([0], 'References', [
      wbFormIDCk('Actor', sigReferences, False, cpBenign),
      wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
      wbInteger('Grid Y', itS16, nil, cpBenign, True, lDontShowForCellLocation),
      wbInteger('Grid X', itS16, nil, cpBenign, True, lDontShowForCellLocation),
      wbInteger('Unknown', itS32, nil, cpBenign)
    ])),
    wbArrayS(RCPR,'Removed Persist Location References', wbFormIDCk('Reference', [ACHR, REFR], False, cpBenign), 0, cpBenign),

    wbArrayS(ACUR, 'Added Unique Base Forms', wbStructSK([0], 'Base Form', [
     wbFormIDCk('Generic Base Form', [GBFM]),
     wbFormIDCk('Placed Object', [REFR]),
     wbFormIDCk('Location', [LCTN])
    ])),
    wbArrayS(LCUR, 'Master Unique Base Forms', wbStructSK([0], 'Base Form', [
     wbFormIDCk('Generic Base Form', [GBFM]),
     wbFormIDCk('Placed Object', [REFR]),
     wbFormIDCk('Location', [LCTN])
    ])),
    wbArrayS(RCUR, 'Removed Unique Base Forms', wbFormIDCk('Generic Base Form', [GBFM], False, cpBenign), 0, cpBenign),

    wbArrayS(ACUN, 'Added Unique NPCs', wbStructSK([0], 'Actor', [
      wbFormIDCk('Actor', [NPC_], False, cpBenign),
      wbFormIDCk('Ref', [ACHR], False, cpBenign),
      wbFormIDCk('Location', [LCTN, NULL], False, cpBenign)
    ])),
    wbArrayS(LCUN, 'Master Unique NPCs', wbStructSK([0], 'Actor', [
      wbFormIDCk('Actor', [NPC_], False, cpBenign),
      wbFormIDCk('Ref', [ACHR], False, cpBenign),
      wbFormIDCk('Location', [LCTN, NULL], False, cpBenign)
    ])),
    wbArrayS(RCUN, 'Removed Unique NPCs', wbFormIDCk('Actor', [NPC_], False, cpBenign), 0, cpBenign),

    wbArrayS(ACSR, 'Added Special References', wbStructSK([0], 'Reference', [
      wbFormIDCk('Loc Ref Type', [LCRT], False, cpBenign),
      wbFormIDCk('Marker', sigReferences, False, cpBenign),
      wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
      wbInteger('Grid Y', itS16, nil, cpBenign, True, lDontShowForCellLocation),
      wbInteger('Grid X', itS16, nil, cpBenign, True, lDontShowForCellLocation),
      wbInteger('Unknown', itS32, nil, cpBenign)
    ])),
    wbArrayS(LCSR, 'Master Special References', wbStructSK([0], 'Reference', [
      wbFormIDCk('Loc Ref Type', [LCRT], False, cpBenign),
      wbFormIDCk('Marker', sigReferences, False, cpBenign),
      wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
      wbInteger('Grid Y', itS16, nil, cpBenign, True, lDontShowForCellLocation),
      wbInteger('Grid X', itS16, nil, cpBenign, True, lDontShowForCellLocation),
      wbInteger('Unknown', itS32, nil, cpBenign)
    ])),
    wbArrayS(RCSR,'Removed Special References', wbFormIDCk('Reference', [ACHR, REFR], False, cpBenign), 0, cpBenign),

    wbRArray('Master Worldspace Cells',
      wbStructSK(LCEC, [0], 'Unknown', [
        wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
        wbArray('Coordinates', wbStruct('', [
          wbInteger('Grid Y', itS16, nil, cpBenign, True, lDontShowForCellLocation),
          wbInteger('Grid X', itS16, nil, cpBenign, True, lDontShowForCellLocation)
        ]))
      ])
    ),

    wbArray(ACID, 'Master Initially Disabled References', wbFormIDCk('Ref', sigReferences, False, cpBenign)),
    wbArray(LCID, 'Master Initially Disabled References', wbFormIDCk('Ref', sigReferences, False, cpBenign)),

    wbArray(ACEP, 'Added Enable Point References', wbStruct('Reference', [
      wbFormIDCk('Actor', sigReferences, False, cpBenign),
      wbFormIDCk('Ref', sigReferences, False, cpBenign),
      wbInteger('Set Enable State to Opposite of Parent', itU8, wbBoolEnum),
      wbUnused(3)
    ])),
    wbArray(LCEP, 'Master Enable Point References', wbStruct('Reference', [
      wbFormIDCk('Actor', sigReferences, False, cpBenign),
      wbFormIDCk('Ref', sigReferences, False, cpBenign),
      wbInteger('Set Enable State to Opposite of Parent', itU8, wbBoolEnum),
      wbUnused(3)
    ])),

    wbFULL,
    wbKeywords,
    wbPRPS,
    wbStruct(DATA, '', [
      wbFormIDCk('Ownership', [FACT, NPC_, NULL]),
      wbInteger('Faction Rank', itS8).SetDefaultEditValue('-1'),
      wbStruct('Encounter Leveling Data', [
        wbInteger('Min Level', itu8),
        wbInteger('Flags', itU8, wbFlags([
          'Never Resets',
          'Match PC Level',
          'Disable Combat Boundry',
          'Workshop',
          'Use Parent''s Locked Level'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbInteger('Max Level', itu8)
      ])
    ]),
    wbFormIDCk(PNAM, 'Parent Location', [LCTN, NULL]),
    wbFormIDCk(NAM1, 'Music Type', [MUSC]),
    wbFormIDCk(FNAM, 'Unreported Crime Faction', [FACT]),
    wbFormIDCk(MNAM, 'World Location Marker Ref', [REFR, ACHR]),
    wbFloat(RNAM, 'World Location Radius'),
    wbFloat(ANAM, 'Actor Fade Mult'),
    wbFloat(TNAM, 'Random Conversation Timer'),
    wbByteArray(NAM0, 'Horse Marker (Unused', 4),
    wbCNAM,
    wbInteger(XNAM, 'Star ID', itS32, wbStarIDToStr, wbStrToStarID)
      .SetLinksToCallbackOnValue(function(const aElement: IwbElement): IwbElement
        begin
          Result := nil;

          var lStarID := aElement.NativeValue;
          if not VarIsOrdinal(lStarID) then
            Exit;

          var lFile := aElement._File;
          if not Assigned(lFile) then
            Exit;

          Result := lFile.RecordFromIndexByKey[wbIdxStarID, lStarID];
        end),
    wbInteger(YNAM, 'Planet ID', itS32)
  ]);


  var wbMenuButton :=
    wbRStruct('Menu Button', [
      wbLStringKC(ITXT, 'Button Text', 0, cpTranslate),
      wbString(IBIN, 'Event Name'),  // unsure if localized or not
      wbCTDAs,
      wbFormIDCk(DODT, 'Reference', [REFR, PLYR, NULL])
    ], []);

  {subrecords checked against Starfield.esm}
  wbRecord(MESG, 'Message', [
    wbEDID,
    wbBaseFormComponents,
    wbDESCReq(),
    wbFULL,
    wbFormIDCk(INAM, 'Icon (unused)', [NULL], False, cpIgnore, True), // leftover
    wbFormIDCk(QNAM, 'Owner Quest', [QUST]),
    wbICON,
    wbInteger(DNAM, 'Flags', itU32, wbFlags([
      'Message Box',
      'Delay Initial Display',
      'Allow Back Out'
    ]), cpNormal, True, False, nil, wbMESGDNAMAfterSet).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(TNAM, 'Display Time', itU32, nil, cpNormal, False, False, wbMESGTNAMDontShow),
    wbString(SNAM, 'SWF'),
    wbInteger(BNAM, 'Index Chosen On Back Out', itS32),
    wbLStringKC(NNAM, 'Short Title', 0, cpTranslate),
    wbRArray('Menu Buttons', wbMenuButton)
  ], False, nil, cpNormal, False);

  var lDOBJUsesVarRecs1 := wbMakeVarRecs([
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

  var lDOBJUsesVarRecs2 := wbMakeVarRecs([
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
    Sig2Int('WWSP'), 'UNUSED03',
    Sig2Int('ATLB'), 'Action Threat Listen Back',
    Sig2Int('ASNB'), 'Action Sneak Begin',
    Sig2Int('ATBD'), 'Action Threat Back Down',
    Sig2Int('ASNE'), 'Action Sneak End',
    Sig2Int('ATRE'), 'Action Threat Assess',
    Sig2Int('ACTE'), 'Action Traversal End',
    Sig2Int('ATLF'), 'Action Threat Listen Front',
    Sig2Int('AGOF'), 'Action Gravity Off',
    Sig2Int('ACFL'), 'Action Flight Landing',
    Sig2Int('ATFL'), 'Action Flee Start',
    Sig2Int('ATIN'), 'Action Threat/Intimidate',
    Sig2Int('AGON'), 'Action Gravity On',
    Sig2Int('AAVO'), 'Action Avoid',
    Sig2Int('ABSP'), 'Action Blind Fire Stop',
    Sig2Int('ASTP'), 'Action Step in Talking to Player',
    Sig2Int('ACTS'), 'Action Traversal Start',
    Sig2Int('ACFT'), 'Action Flight TakeOff',
    Sig2Int('ABST'), 'Action Blind Fire Start',
    Sig2Int('ACTT'), 'Action Taunt',
    Sig2Int('ATCU'), 'Action Threat Curious',
    Sig2Int('AEM1'), 'Action Electromagnetic Shock Start',
    Sig2Int('AEM2'), 'Action Electromagnetic Shock Stop'
  ]);

  var lDOBJUsesVarRecs3 := wbCombineVarRecs(lDOBJUsesVarRecs1, lDOBJUsesVarRecs2);

  {subrecords checked against Starfield.esm}
  wbRecord(DOBJ, 'Default Object Manager', [
    wbEDID,
    wbArrayS(DNAM, 'Objects',
      wbStructSK([0], 'Object', [
        wbInteger('Use', itU32, wbEnum([], lDOBJUsesVarRecs3), cpNormalIgnoreEmpty),
        wbFormID('Object ID', cpNormalIgnoreEmpty)
      ]), 0, cpNormalIgnoreEmpty, True, wbDOBJObjectsAfterLoad
    )
  ]);

  {subrecords checked against Starfield.esm}
  // Lighting Templates are no longer used and are legacy records
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
      wbByteColors('Fog Color Far'),
      wbFLoat('Fog Max'),
      wbFloat('Light Fade Distance Start'),
      wbFloat('Light Fade Distance Stop'),
      wbUnused(4),
      wbFloat('Height Mid'),
      wbFloat('Height Range'),
      wbByteColors('Fog Color High Near'),
      wbByteColors('Fog Color High Far'),
      wbFloat('High Density Scale'),
      wbFloat('Fog Near Scale'),
      wbFloat('Fog Far Scale'),
      wbFloat('High Near Scale'),
      wbFloat('High Far Scale'),
      wbFloat('Far Height Mid'),
      wbFloat('Far Height Range'),
      wbUnknown(4)
    ], cpNormal, True, nil, 15),
    wbAmbientColors(DALC)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(MUSC, 'Music Type', [
    wbEDID,
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      {0x01} 'Plays One Selection',
      {0x02} 'Abrupt Transition',
      {0x04} 'Cycle Tracks',
      {0x08} 'Maintain Track Order',
      {0x10} '',
      {0x20} 'Ducks Current Track',
      {0x40} 'Doesn''t Queue'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbStruct(PNAM, 'Data', [
      wbInteger('Priority', itU16),
      wbInteger('Ducking (dB)', itU16, wbDiv(100))
    ], cpNormal, True),
    wbFloat(WNAM, 'Fade Duration', cpNormal, True),
    wbInteger(VNAM, 'Re-evaluate Interval', itU64, wbDiv(1000), cpNormal, True),
    wbInteger(UNAM, 'Stability Interval', itU64, wbDiv(1000), cpNormal, True),
    wbArray(TNAM, 'Music Tracks', wbFormIDCk('Track', [MUST]))
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

  var wbSMNodeFlags := wbFlags([
    'Random',
    'Warn if no child quest started'
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SMBN, 'Story Manager Branch Node', [
    wbEDID,
    wbFormIDCkNoReach(PNAM, 'Parent ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCkNoReach(SNAM, 'Previous Sibling ', [SMQN, SMBN, SMEN, NULL], False, cpBenign),
    wbCITCReq,
    wbCTDAsCount,
    wbInteger(DNAM, 'Flags', itU32, wbSMNodeFlags).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(XNAM, 'Max concurrent quests', itU32)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SMQN, 'Story Manager Quest Node', [
    wbEDID,
    wbFormIDCkNoReach(PNAM, 'Parent ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCkNoReach(SNAM, 'Previous Sibling ', [SMQN, SMBN, SMEN, NULL], False, cpBenign),
    wbCITCReq,
    wbCTDAsCount,
    wbStruct(DNAM, 'Flags', [
      wbInteger('Node Flags', itU16, wbSMNodeFlags).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Quest Flags', itU16, wbFlags([
        'Do all before repeating',
        'Shares event',
        'Num quests to run'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ]),
    wbInteger(XNAM, 'Max concurrent quests', itU32),
    wbInteger(MNAM, 'Num quests to run', itU32),
    wbFloat(HNAM, 'Hours until reset'),
    wbInteger(QNAM, 'Quest Count', itU32, nil, cpBenign, True),
    wbRArray('Quests', wbRStructSK([0], 'Quest', [
      wbFormIDCk(NNAM, 'Quest', [QUST]),
      //wbInteger(FNAM, 'Flags', itU32, wbFlags(wbSparseFlags([]))),
      wbFloat(RNAM, 'Hours until reset', cpNormal, False, 1/24)
    ], []), cpNormal, False, nil, wbSMQNQuestsAfterSet)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SMEN, 'Story Manager Event Node', [
    wbEDID,
    wbFormIDCkNoReach(PNAM, 'Parent ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCkNoReach(SNAM, 'Previous Sibling ', [SMQN, SMBN, SMEN, NULL], False, cpBenign),
    wbCITCReq,
    wbCTDAsCount,
    wbInteger(DNAM, 'Flags', itU32, wbSMNodeFlags).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(XNAM, 'Max concurrent quests', itU32),
    wbInteger(ENAM, 'Type', itU32, wbQuestEventEnum)
  ])
    .SetSummaryKey([7]);

  {subrecords checked against Starfield.esm}
  wbRecord(DLBR, 'Dialog Branch', [
    wbEDID,
    wbFormIDCk(QNAM, 'Quest', [QUST], False, cpNormal, True)
      .IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole),
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
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(MUST, 'Music Track', [
    wbEDID,
    wbInteger(CNAM, 'Track Type', itU32, wbEnum([], [
      Int64($23F678C3), 'Palette',
      Int64($6ED7E048), 'Single Track',
      Int64($A1A9C4D5), 'Silent Track'
    ]), cpNormal, True).SetDefaultEditValue('Palette'),
    wbFloat(FLTV, 'Duration'),
    wbFloat(DNAM, 'Fade-Out'),
    wbSoundReference(MTSH, 'Single Track Sound'),
    wbArray(FNAM, 'Cue Points', wbFloat('Point')).IncludeFlag(dfNotAlignable),
    wbInteger(MSTF, 'Conditions can''t fail after success', itU8, wbBoolEnum),
    wbConditions,
    wbArray(SNAM, 'Tracks', wbFormIDCk('Track', [MUST, NULL])) // do not sort. NULL entry acts as a divider for groups
  ]);

  //still exists in game code, but not in Starfield.esm
  wbRecord(DLVW, 'Dialog View', []);

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
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags).SetRequired,
    wbFormIDCk(ANAM, 'Condition Actor Value', [AVIF, NULL, FFFF]).SetRequired
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
      wbUnused(2),
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

  {subrecords checked against Starfield.esm}
  wbRecord(SCEN, 'Scene', [
    wbEDID,
    wbVMADFragmentedSCEN,
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      {0x00000001} 'Begin on Quest Start',
      {0x00000002} 'Stop on Quest End',
      {0x00000004} 'Top Level Topics On End',
      {0x00000008} 'Interruptable',
      {0x00000010} 'Player Dialogue',
      {0x00000020} 'Prevent Player Exit Dialogue',
      {0x00000040} 'Unknown 6',
      {0x00000080} 'Unknown 7',
      {0x00000100} 'Speech Challenge',
      {0x00000200} 'Unknown 9',
      {0x00000400} 'Allow/Disable Dialogue Camera',
      {0x00000800} 'No Follower Idle Chatter',
      {0x00001000} 'Greeting',
      {0x00002000} 'Top Level',
      {0x00004000} 'Force Primary Actor Alias',
      {0x00008000} 'Hailing',
      {0x00010000} 'Ship Dialogue Only',
      {0x00020000} 'Unknown 17',
      {0x00040000} 'Unknown 18',
      {0x00080000} 'Unknown 19',
      {0x00100000} 'Unknown 20',
      {0x00200000} 'Unknown 21'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbRArray('Phases',
      wbRStruct('Phase', [
        wbEmpty(HNAM, 'Marker Phase Start', cpNormal, True),
        wbString(NAM0, 'Name', 0, cpNormal, True),
        wbRStruct('Start Conditions', [wbCTDAs], []),
        wbEmpty(NEXT, 'End Marker Start Conditions', cpNormal, True),
        wbRStruct('Completion Conditions', [wbCTDAs], []),
        wbEmpty(NEXT, 'End Marker Completion Conditions', cpNormal, True),
        wbInteger(WNAM, 'Editor Width', itU32, nil, cpNormal, True, false, nil, nil, 350),
        wbInteger(FNAM, 'Flags', itU16, wbFlags([
          {0x0001} 'Start - WalkAway Phase',
          {0x0002} 'Don''t Run End Scripts on Scene Jump',
          {0x0004} 'Start - Inherit In Templated Scenes',
          {0x0008} 'FX Actions - Random',
          {0x0010} 'FX Actions - Do All Once'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbStruct(SCQS, 'Set Parent Quest Stage', [
          wbInteger('On Start', itS16),
          wbInteger('On Completion', itS16)
        ]),
        wbEmpty(SPMV, 'Phase Visibility Marker'),
        wbEmpty(HNAM, 'Marker Phase End', cpNormal, True)
      ], [])
    ),
    wbRArray('Actors', wbRStruct('Actor', [
      wbInteger(ALID, 'Alias ID', itS32, wbSCENQuestAliasToStr, wbStrToAlias, cpNormal, True)
        .SetDefaultNativeValue(-1)
        .SetLinksToCallbackOnValue(wbSCENAliasLinksTo),
      wbInteger(LNAM, 'Flags', itU32, wbFlags([
        'No Player Activation',
        'Optional',
        'Can Be Removed',
        'Run Only Scene Packages',
        'No Command State',
        'No Player Dialogue',
        'Timeline Headtracking',
        'Timeline Cameras'
      ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger(DNAM, 'Behaviour Flags', itU32, wbFlags([
        'Death Pause',
        'Death End',
        'Combat Pause',
        'Combat End',
        'Dialogue Pause',
        'Dialogue End',
        'Observe Combat Pause',
        'Observe Combat End',
        'Reaction Radius Pause',
        'Reaction Radius End'
      ]), cpNormal, True, false, nil, nil, 26).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ], [])),
    wbRArray('Actions', wbRStructSK([0, 1, 3, 4], 'Action', [
      wbInteger(ANAM, 'Type', itU16, wbEnum([
        {0} 'Dialogue',
        {1} 'Package',
        {2} 'Timer',
        {3} 'Player Dialogue',
        {4} 'Start Scene',
        {5} 'Radio',
        {6} 'Move',
        {7} 'Camera',
        {8} 'FX',
        {9} 'Animation',
        {10}'Timeline'
      ]), cpNormal, True)
      .SetAfterSet(procedure(const aElement: IwbElement; const aOldValue, aNewValue: Variant)
        begin
          if not (VarIsOrdinal(aOldValue) and VarIsOrdinal(aNewValue)) then
            Exit;
          if aOldValue = aNewValue then
            Exit;
          if not Assigned(aElement) then
            Exit;
          var lContainer: IwbContainerElementRef;
          if not Supports(aElement.Container, IwbContainerElementRef, lContainer) then
            Exit;
          var lDataElement := lContainer.ElementBySortOrder[8]; //'Type Specific Action' is the member with index 8 in this struct, be sure to adjust if adding more members before
          if Assigned(lDataElement) and (lDataElement.Name <> aElement.Value) then
            lDataElement.Remove;

          {var lTemplate := aElement.Container.GetAssignTemplates(8);
          if Length(lTemplate) > 0 then
          Supports(IInterface(lTemplate[0]), IwbElement, lDataElement);
          lContainer.Assign(8, lDataElement, False);}
        end)
      .IncludeFlag(dfIncludeValueInDisplaySignature),
      wbString(NAM0, 'Name').SetRequired,
      wbString(SNOT, 'Scene Notes'),
      wbInteger(ALID, 'Alias ID', itS32, wbSCENQuestAliasToStr, wbStrToAlias, cpNormal, True)
        .SetDefaultNativeValue(-1)
        .SetLinksToCallbackOnValue(wbSCENAliasLinksTo),                         //ALID  uint32 // +0x08 - only used if the value is not 0xFFFFFFFB (-5)
      wbInteger(INAM, 'Index', itU32).SetRequired,                              //INAM  uint32 // +0x10
      wbInteger(FNAM, 'Flags', itU32, wbFlags([                                 //FNAM  uint32 // +0x0C
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
        {0x00004000} 'Run on End of Phase',
        {0x00008000} 'Face Target',
        {0x00010000} 'Looping',
        {0x00020000} 'Headtrack Player',
        {0x00040000} 'Unknown 18',
        {0x00080000} 'Ignore For Completion',
        {0x00100000} 'Unknown 20',
        {0x00200000} 'Disable Camera Speaker Target',
        {0x00400000} 'Complete Face Target',
        {0x00800000} 'Animation Only Movement',
        {0x01000000} 'Unknown 24',
        {0x02000000} 'Unknown 25',
        {0x04000000} 'Unknown 26',
        {0x08000000} 'NPC Positive Use Dialogue Subtype',
        {0x10000000} 'NPC Negative Use Dialogue Subtype',
        {0x20000000} 'NPC Neutral Use Dialogue Subtype',
        {0x40000000} 'NPC Question Use Dialogue Subtype'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
      .SetRequired,
      wbInteger(SNAM, 'Start Phase', itU32).SetRequired,                        //SNAM  uint32 // +0x14 - cast to uint16, ie upper two bytes are dropped
      wbInteger(ENAM, 'End Phase', itU32).SetRequired,                          //ENAM  uint32 // +0x16 - cast to uint16, ie upper two bytes are dropped

      wbRUnion('Type Specific Action', function(const aContainer: IwbContainerElementRef): Integer
        begin
          Result := -1;
          if not Assigned(aContainer) then
            Exit;
          var lType := aContainer.ElementNativeValues[ANAM];
          if not VarIsOrdinal(lType) then
            Exit;
          Result := lType;
        end,
      [
        {0 Dialogue}
        wbRStruct('Dialogue', [
          wbFormIDCk(DATA, 'Topic', [DIAL, NULL]).SetRequired,                  //DATA  uint32 // +0x70
          wbFloat(DMAX, 'Looping - Max').SetRequired,                           //DMAX  uint32 // +0x80
          wbFloat(DMIN, 'Looping - Min').SetRequired,                           //DMIN  uint32 // +0x84
          wbHNAMHNAM.SetRequired,                                               //HNAM  none   // +0x50; probably formid; kicks off component-style read (see HNAM fields)
          wbFormIDCk(VENC, 'Dialogue Subtype', [KYWD]),                         //VENC  uint32 // +0x78
          wbSoundReference(WED0, 'Voice Override')                              //WED0  SoundReference // +0x20
        ], []),
        {1 Package}
        wbRStruct('Package', [
          wbRArray('Packages', wbFormIDCk(PNAM, 'Package', [PACK]))
        ], []),
        {2 Timer}
        wbRStruct('Timer', [
          wbFloat(SNAM, 'Max Seconds'),                                         //SNAM  uint32 // +0x20, +0x24
          wbInteger(SCQS, 'Set Parent Quest Stage', itS16),                     //SCQS  int16 // if not -1, registers the timer action in some list with the value //never seen in Starfield.esm
          wbFloat(TNAM, 'Min Seconds'),                                         //TNAM  uint32 // +0x24
          wbEmpty(HNAM, 'Hold For Animation Event'),                            //not documented by gibbed, always (4x) empty in Starfield.esm
          wbInteger(INTV, 'Unknown', itS16)                                     //INTV  int16 // same as SCQS //never seen in Starfield.esm
        ], []),
        {3 Player Dialogue}
        wbRStruct('Player Dialogue', [
          wbSoundReference(WED0).SetRequired(False),                            //WED0  SoundReference // +0x40
          wbHNAMHNAM.SetRequired,                                               //HNAM  none // +0x20; probably formid; kicks off component-style read (see HNAM fields)
          wbInteger(DTGT, 'Dialogue Target Actor', itS32, wbSCENQuestAliasToStr, wbStrToAlias, cpNormal, True)
            .SetDefaultNativeValue(-1)
            .SetLinksToCallbackOnValue(wbSCENAliasLinksTo),                     //DTGT  uint32 // +0x90 // as an alias ID
          wbRStructs('Dialogue Topics', 'Choice', [
            wbFormIDCk(ESCE, 'Player Choice', [DIAL, NULL]),                    //ESCE  uint32 // +0x88 array; repeated; appears to allocate a new item into the array, with the value set to item+0x00 and item+0x08; likely acts as start marker for an item in this array
            wbFormIDCk(PPST, 'Player Dialogue Subtype', [KYWD]),                //PPST  uint32 // +0x88 array; repeated; stored in item+0x10, also sets item+0x24 to 1 (uint8/byte)
            wbRStruct('NPC Dialogue Subtype', [
              wbFormIDCk(PNST, 'Subtype', [KYWD], False, cpNormal, True),       //PNST  uint32 // +0x88 array; repeated; stored in item+0x18, also sets item+0x25 to 1 (uint8/byte)
              wbFormIDCk(PASP, 'Start Scene', [NULL, SCEN]),                    //PASP  uint32 // +0x88 array; repeated; stored in item+0x28
              wbInteger(PAPI, 'Phase Index', itU32),                            //PAPI  uint32 // +0x88 array; repeated; stored in item+0x20; some sort of parenting/hierarchy index with the items in the array
              wbString(PAPN, 'Phase Name'),
              wbUnknown(PAQO)                                                   //PAQO  uint32 // Seems to get set if a NPC dialogue subtype is present and the 'Only Parent Quest Scenes' box is unchecked. But has 4 bytes of zero.
            ], []),
            wbFormIDCk(ESCS, 'NPC Response', [DIAL, NULL]).SetRequired          //ESCS  uint32 // +0x88 array; repeated; each item is 0x30 bytes; stored in item+0x08; increases +0x88 index *after* storing the value, likely acts as end marker for an item in this array
          ], []),
          wbRStruct('NPC Reaction', [
            wbInteger(ATTR, 'React to Action', itU32, nil, cpNormal, True),     //ATTR  uint32 // +0x94
            wbEmpty(ACBS, 'NPC Reaction flag', cpNormal, True)                  //ACBS  nothing // +0x98 set to 1 (uint8/bool)
          ], []),
          wbEmpty(JAIL, 'Unknown')                                              //JAIL  none // +0x99 set to 1 (uint8/bool) // never seen in Starfield.esm
        ], [])
        .IncludeFlag(dfAllowAnyMember)
        .IncludeFlag(dfStructFirstNotRequired),
        {4 Start Scene}
        wbRStruct('Start Scene', [
          wbRStructs('Start Scenes', 'Start Scene', [
            wbRUnion('Scene', [
              wbFormIDCk(LCEP, 'Scene', [SCEN]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole),  //LCEP same as STSC
              wbFormIDCk(STSC, 'Scene', [SCEN]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole)   //STSC +0x28 array; repeated; appears to allocate a new item into the array, with the value set to item+0x18; likely acts as start marker for an item in this array
            ],[]),
            wbRUnion('Phase Index', [
              wbInteger(INTT, 'Phase Index', itU16).SetRequired,                //INTT  uint16 // +0x28 array; repeated; sets to item+0x0E
              wbInteger(ACTV, 'Phase Index', itU16).SetRequired                 //ACTV  same as INTT
            ],[]).SetRequired,
            wbString(SSPN, 'Start Phase for Scene'),                            //not documented by gibbed from source, occurs in Starfield.esm
            wbCITCReq,                                                          //CITC uint32 // +0x28 array; repeated; item+0x08; count of following fields, CTDA/CNDD, others will be ignored
            wbCTDAsCount
          ], []).SetRequired(False),
          wbEmpty(HTID, 'End Scene Flag')
        ], [], cpNormal, True)
        .IncludeFlag(dfAllowAnyMember)
        .IncludeFlag(dfStructFirstNotRequired),
        {5 Radio}
        wbRStruct('Radio', [
          wbFormIDCk(DATA, 'Topic', [DIAL, NULL]).SetRequired,                  //DATA  uint32 // +0x80  probably formid
          wbSoundReference(WED0, 'Voice Override'),                             //WED0  SoundReference // +0x20
          wbSoundReference(WED1, 'Sound Effect'),                               //WED1  SoundReference // +0x50
          wbFormIDCk(VENC, 'Dialogue Subtype', [KYWD])                          //uint32 // +0x88  probably formid
        ], []),
        {6 Move}
        wbRStruct('Move', [
          wbEmpty(DNAM, 'Disable Character Controller'),                        //DNAM  none // sets +0x3D to 1 (uint8/bool)
          wbEmpty(NVCI, 'Off Navmesh Flag'),                                    //NVCI  none // sets +0x3C to 0 (uint8/bool)
          wbInteger(ALLA, 'Target Alias', itS32, wbSCENQuestAliasToStr, wbStrToAlias, cpNormal, True)
            .SetDefaultNativeValue(-1)
            .SetLinksToCallbackOnValue(wbSCENAliasLinksTo),                     //ALLA  uint32 // +0x34
          wbFormIDCk(REPL, 'Target Reference', sigReferences).SetRequired,      //REPL  uint32 // +0x20  probably formid
          wbFloat(HNAM, 'Front/Back').SetRequired,                              //HNAM  uint32 // +0x28
          wbFloat(VCLR, 'Left/Right').SetRequired,                              //VCLR  uint32 // +0x2C
          wbFloat(VNML, 'Up/Down').SetRequired,                                 //VNML  uint32 // +0x30
          wbInteger(FLMV, 'Flags', itU32, wbFlags([                             //FLMV  uint32 // +0x38
            {0x00000001} 'Front',
            {0x00000002} 'Back',
            {0x00000004} 'Right',
            {0x00000008} 'Left',
            {0x00000010} 'Target Alias',
            {0x00000020} 'Target Reference',
            {0x00000040} 'Up',
            {0x00000080} 'Down',
            {0x00000100} 'Unknown 8',
            {0x00000200} 'Unknown 9',
            {0x00000400} 'Unknown 10',
            {0x00000800} 'Unknown 11',
            {0x00001000} 'Unknown 12',
            {0x00002000} 'Unknown 13',
            {0x00004000} 'Unknown 14',
            {0x00008000} 'Unknown 15',
            {0x00010000} 'Unknown 16'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags).SetRequired
        ], [])
        .IncludeFlag(dfAllowAnyMember)
        .IncludeFlag(dfStructFirstNotRequired),
        {7 Camera}
        wbRStruct('Camera', [
          wbRStructs('Camera Shots', 'Camera Shot', [
            wbFormIDCk(CNAM, 'Camera Shot', [NULL, CAMS]),                      //CNAM  uint32 // +0x28 array; repeated; allocates new item for the array; value set to item+0x20 probably formid; kicks off component-style read
            wbFormIDCk(ALLA, 'Camera Location Reference', sigReferences).SetRequired, //ALLA  formid // +0x28
            wbFormIDCk(REPL, 'Look Target Reference', sigReferences).SetRequired,     //REPL  formid // +0x30
            wbInteger(HNAM, 'Look Target Alias', itS32, wbSCENQuestAliasToStr, wbStrToAlias, cpNormal, True)
              .SetDefaultNativeValue(-1)
              .SetLinksToCallbackOnValue(wbSCENAliasLinksTo),                   //HNAM  uint32 // +0x40
            wbInteger(VCLR, 'Camera Location Alias', itS32, wbSCENQuestAliasToStr, wbStrToAlias, cpNormal, True)
              .SetDefaultNativeValue(-1)
              .SetLinksToCallbackOnValue(wbSCENAliasLinksTo),                   //VCLR  uint32 // +0x3C
            wbFloat(LVCR, 'Delay Start Time Action').SetRequired,               //LVCR  uint32 // +0x38
            wbEmpty(BTXT, 'Use Camera Location Reference'),                     //BTXT  none // sets +0x44 to 1 (uint8/bool)
            wbEmpty(ATXT, 'Use Look Target Reference'),                         //ATXT  none // sets +0x45 to 1 (uint8/bool)
            wbEmpty(VTXT, 'Use Camera Location Alias'),                         //VTXT  none // sets +0x46 to 1 (uint8/bool)
            wbEmpty(AIDT, 'Ignore Collision'),                                  //AIDT  none // sets +0x48 to 1 (uint8/bool)
            wbEmpty(MPCD, 'Use Look Target Alias'),                             //MPCD  none // sets +0x47 to 1 (uint8/bool)
            wbEmpty(VNAM, 'Force Look At 1st Person Camera'),                   //VNAM  none // sets +0x49 to 1 (uint8/bool)
            wbCTDAs,                                                            //CTDA  standard CTDA reading // +0x10 //not found in Starfield.esm
            wbMarkerReq(XNAM)                                                   //XNAM  end marker for CNAM fields
          ], [])
        ], []),
        {8 FX}
        wbRStruct('FX', [
          wbFormIDCk(REPL, 'Image Space Mod', [NULL, IMAD]).SetRequired,        //REPL  uint32 // +0x68  probably formid
          wbFloat(HNAM, 'Fade Out Time').SetRequired,                           //HNAM  uint32 // +0x78
          wbFloat(VCLR, 'IS Strength/Sound Volume').SetRequired,                //VCLR  uint32 // +0x7C
          wbFloat(BTXT, 'Start Time').SetRequired,                              //BTXT  uint32 // +0x80
          wbInteger(FLMV, 'Flags', itU32, wbFlags([                             //FLMV  uint32 // +0x88
            {0x00000001} 'Fade Out',
            {0x00000002} 'Fade In',
            {0x00000004} 'Fader - White',
            {0x00000008} 'Fader - Black',
            {0x00000010} 'Use Fader Opts',
            {0x00000020} 'Use Image Space Mod',
            {0x00000040} 'Hold Fade Out',
            {0x00000080} 'Use Sound File',
            {0x00000100} 'Use Reference',
            {0x00000200} 'Use Alias',
            {0x00000400} 'Use Disable/Enable Reference',
            {0x00000800} 'Enable Reference',
            {0x00001000} 'Disable Reference',
            {0x00002000} 'Unknown 13',
            {0x00004000} 'Unknown 14',
            {0x00008000} 'Unknown 15',
            {0x00010000} 'Unknown 16'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags).SetRequired,
          wbSoundReference(WED0),                                               //WED0  SoundReference // +0x38
          wbCTDAs,                                                              //CTDA  standard CTDA reading // +0x20
          wbFormIDCk(BIPL, 'Reference', [REFR, PLYR, NULL]).SetRequired,        //BIPL  uint32 // +0x70  probably formid
          wbInteger(LVLO, 'Alias', itS32, wbSCENQuestAliasToStr, wbStrToAlias, cpNormal, True)
            .SetDefaultNativeValue(-1)
            .SetLinksToCallbackOnValue(wbSCENAliasLinksTo)                      //LVLO  uint32 // +0x84
        ], []),
        {9 Animation}
        wbRStruct('Animation', [
          wbRArray('Animations', wbBNAMAnimation)
        ], []),
        {10 Timeline}
        wbRStruct('Timeline', [
          wbInteger(TNAM, 'Type', itU32, wbEnum([
            {0} 'Headtrack',
            {1} 'Headtrack Stop',
            {2} 'Camera',
            {3} 'Phase Time',
            {4} 'Headtrack Angles',
            {5} 'Eyetrack Angles',
            {6} 'Headtrack Disable',
            {7} 'Headtrack Enable'
          ])).SetAfterSet(wbSCENTimelineTypeAfterSetCallback),
          wbFloat(SNAM, 'Start Time', cpNormal, True),
          wbRUnion('Data', function(const aContainer: IwbContainerElementRef): Integer
            begin
              Result := -1;
              if not Assigned(aContainer) then
                Exit;
              var lType := aContainer.ElementNativeValues[TNAM];
              if not VarIsOrdinal(lType) then
                Exit;

              case lType of
                2:      // Camera
                  Result := 1;
                4, 5:   // Headtrack/Eyetrack Angles
                  Result := 2;
                0, 7:   // Headtrack/Headtrack Enable
                  Result := 3;
                else
                 Result := 0;
              end;
            end, [
          {0} wbRStruct('Data', [
                wbByteArray(UNAM, 'Unused', 4, cpIgnore, True),
                wbByteArray(LNAM, 'Unused', 4, cpIgnore, True),
                wbByteArray(CNAM, 'Unused', 4, cpIgnore, True)
              ], []),
          {1} wbRStruct('Data', [  //  Camera
                wbInteger(UNAM, 'Target Alias ID', itS32, wbSCENQuestAliasToStr, wbStrToAlias, cpNormal, True)
                  .SetLinksToCallbackOnValue(wbSCENAliasLinksTo)
                  .SetDefaultNativeValue(-1),
                wbInteger(LNAM, 'Location Alias ID', itS32, wbSCENQuestAliasToStr, wbStrToAlias, cpNormal, True)
                  .SetLinksToCallbackOnValue(wbSCENAliasLinksTo)
                  .SetDefaultNativeValue(-1),
                wbFormIDCk(CNAM, 'Unknown', [CAMS], False, cpNormal, True)
              ], [], cpNormal, True),
          {2} wbRStruct('Data', [  // Headtrack/Eyetrack Angles
                wbInteger(UNAM, 'Track Angle X', itS32, nil, cpNormal, True),
                wbInteger(LNAM, 'Track Angle Y', itS32, nil, cpNormal, True),
                wbByteArray(CNAM, 'Unused', 4, cpIgnore, True)
              ], [], cpNormal, True),
          {3} wbRStruct('Data', [  // Headtrack/Headtrack Enable
                wbInteger(UNAM, 'Target Alias ID', itS32, wbSCENQuestAliasToStr, wbStrToAlias, cpNormal, True)
                  .SetLinksToCallbackOnValue(wbSCENAliasLinksTo)
                  .SetDefaultNativeValue(-1),
                wbByteArray(LNAM, 'Unused', 4, cpIgnore, True),
                wbByteArray(CNAM, 'Unused', 4, cpIgnore, True)
              ], [], cpNormal, True)
           ], [], cpNormal, True).IncludeFlag(dfMustBeUnion)
           {end Timeline Runion Data}
        ], [])
      {end Type Specific Union}
      ], []),
      wbMarkerReq(ANAM)
    ], [])),

    wbFormIDCk(PNAM, 'Quest', [QUST], False, cpNormal, True),
    wbInteger(INAM, 'Last Action Index', itU32),
    wbUnknown(VNAM),
    wbCTDAs,
    wbStruct(SCQS, 'Set Parent Quest Stage', [
      wbInteger('On Begin', itS16),
      wbInteger('On End', itS16)
    ]),
    wbString(NNAM, 'Notes'),
    wbFormIDCk(TNAM, 'Template Scene', [SCEN]),
    wbEmpty(BOLV, 'Unknown'), // seems to always be present unless DEVT is present
    wbInteger(XNAM, 'Index', itU32),
    wbInteger(SCPI, 'Priority', itU16),
    wbInteger(JNAM, 'Override Subtitle Priority', itU32, wbEnum([
      'Low',
      'Normal',
      'High',
      'Force'
    ])),
    wbFormIDCk(SCPP, 'Unknown', [NULL, SCEN]),
    wbRStruct('Speech Challenge Data', [
      wbEmpty(SCSP, 'Marker', cpNormal, True),
      wbArray(SPMA, 'Mandatory Next Challenges', wbFormIDCk('Challenge Scene', [SCEN])),
      wbArray(SPEX, 'Excluded Challenges', wbFormIDCk('Challenge Scene', [SCEN])),
      wbInteger(SPRK, 'Risk', itU16, wbEnum([
        'Easy',
        'Medium',
        'Hard',
        'Always'
      ]), cpNormal, True),
      wbInteger(SPRW, 'Reward', itU32, nil, cpNormal, True),
      wbEmpty(SPRP, 'Repeatable Flag'),
      wbEmpty(SPDF, 'Default Flag'),
      wbEmpty(SPPQ, 'Unknown', cpNormal, True),
      wbArray(SPKW, 'AND - Keywords', wbFormIDCk('Keyword',[KYWD])),
      wbArray(SPKY, 'OR - Keywords', wbFormIDCk('Keyword',[KYWD])),
      wbArray(SPPK, 'Perks', wbFormIDCk('Perk', [PERK]))
    ], []),
    wbEmpty(DEVT, 'Show One Dialogue Track Flag')
  ]);

  (* still exists in game code, but not in Starfield.esm *)
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

  var wbSPEDRotationSpeedAngles := function(aName: string = 'Unknown'): IwbStructDef
  begin
    Result :=
      wbStruct(aName, [
        wbFloatAngle('Stand'),
        wbFloatAngle('Walk'),
        wbFloatAngle('Jog'),
        wbFloatAngle('Run'),
        wbFloatAngle('Sprint'),
        wbFloatAngle('Acceleration'),
        wbFloat('Unused')
      ]);
  end;

  var wbSPEDMovementSpeeds := function(aName: string = 'Unknown'): IwbStructDef
  begin
    Result :=
      wbStruct(aName, [
        wbFloat('Unused'),
        wbFloat('Walk'),
        wbFloat('Jog'),
        wbFloat('Run'),
        wbFloat('Unused'),
        wbFloat('Acceleration'),
        wbFloat('Deceleration')
      ]);
  end;

  var wbSPED := wbStruct(SPED, 'Movement Data', [
        wbStruct('Max Speed Forward', [
  {  0}   wbFloat('Unused'),
  {  4}   wbFloat('Walk'),
  {  8}   wbFloat('Jog'),
  { 12}   wbFloat('Run'),
  { 16}   wbFloat('Sprint'),
  { 20}   wbFloat('Acceleration'),
  { 24}   wbFloat('Deceleration')
        ]),
        wbSPEDMovementSpeeds('Max Speed Left'),
        wbSPEDMovementSpeeds('Max Speed Right'),
        wbSPEDMovementSpeeds('Max Speed Back'),
        wbSPEDMovementSpeeds('Max Speed Up'),
        wbSPEDMovementSpeeds('Max Speed Down'),
        wbSPEDRotationSpeedAngles('Max Rotation Speed Pitch'),
        wbSPEDRotationSpeedAngles('Max Rotation Speed Roll'),
        wbSPEDRotationSpeedAngles('Max Rotation Speed Yaw')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(OTFT, 'Outfit', [
    wbEDID,
    wbArrayS(INAM, 'Items', wbFormIDCk('Item', [ARMO, LVLI]))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ARTO, 'Art Object', [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbXALG,
    wbPTT2,
    wbBaseFormComponents,
    wbKeywords,
    wbGenericModel(True),
    wbStruct(DNAM, 'Data', [
      wbInteger('Art Type', itU32, wbEnum([
        'Magic Casting',
        'Magic Hit Effect',
        'Enchantment Effect',
        'Misc Art Object'
      ])),
      wbInteger('Flags', itU32, wbFlags(nil, wbSparseFlags([
        0, 'Rotate To Face Target',
        1, 'Attach To Camera',
        2, 'Inherit Rotation',
        31, 'Reference Effect'
      ]))).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ]),
    wbFormIDCK(ENAM, 'Effect Shader', [EFSH])
  ]);

  (* still exists in game code, but not in Starfield.esm * )
  wbRecord(MATO, 'Material Object', [
    wbEDID,
    wbGenericModel(True),
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
  *)

  {subrecords checked against Starfield.esm}
  wbRecord(MOVT, 'Movement Type', [
    wbEDID,
    wbString(MNAM, 'Name'),
    wbSPED.SetRequired,
    wbFloat(LNAM, 'Flight - Angle Gain').SetDefaultNativeValue(0.1).SetRequired,
    wbFloat(KNAM, 'Fast Walk').SetDefaultNativeValue(1.15).SetRequired,
    wbStruct(INTV, 'Flags', [
      wbInteger('Clamp Max Animation Speeds', itU8, wbBoolEnum),
      wbUnused(3)
    ]).SetRequired,
    wbEmpty(BOLV, 'Display For Non Characters') // CK value "Display Character Only" default enabled where element is missing. Disabled means element present.
  ]);

  (* still exists in game code, but not in Starfield.esm *)
  wbRecord(DUAL, 'Dual Cast Data', [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbDEFL,
    wbXALG,
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

  {subrecords checked against Starfield.esm}
  wbRecord(COLL, 'Collision Layer', [
    wbEDID,
    //wbDESCReq,
    wbNLDT,
    wbInteger(BNAM, 'Index', itU32, nil, cpNormal, True),
    wbByteColors(FNAM, 'Debug Color'),
    wbInteger(GNAM, 'Flags', itU32, wbFlags([
      {0x00000001} 'Trigger Volume',
      {0x00000002} 'Sensor',
      {0x00000004} 'Navmesh Obstacle'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbString(MNAM, 'Name', 0, cpNormal, True),
//    wbInteger(INTV, 'Interactables Count', itU32, nil, cpNormal, True),
    wbArrayS(CNAM, 'Collides With', wbFormIDCk('Forms', [COLL]), 0, cpNormal, False)
  ])
  .SetBuildIndexKeys(procedure(const aMainRecord: IwbMainRecord; var aIndexKeys: TwbIndexKeys)
   begin
     if not Assigned(aMainRecord) then
       Exit;

     var lBNAM := aMainRecord.ElementNativeValues[BNAM];
     if not VarIsOrdinal(lBNAM) then
       Exit;

     aIndexKeys.Keys[wbIdxCollisionLayer] := lBNAM;
   end) ;

  {subrecords checked against Starfield.esm}
  wbRecord(CLFM, 'Color',
    wbFlags(wbFlagsList([
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
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbCTDAs
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(REVB, 'Reverb Parameters', [
    wbEDID,
    wbBaseFormComponents,
    wbWwiseGUID(RABG, 'Aux Bus'),
    wbInteger(ANAM, 'Reverb Class', itU32, wbReverbClassEnum, cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(GRAS, 'Grass',
    wbFlags(wbFlagsList([
      {0x00008000} 15, 'Unknown 15'
    ])), [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbXALG,
    wbBaseFormComponents,
    wbGenericModel(True),
    wbStruct(DNAM, 'Data', [
      { 0} wbFloat('Contrast', cpNormal, True, 1, -1, nil, wbFloatScale0to100),
      { 4} wbFloat('Cluster Scale', cpNormal, True, 1, -1, nil, wbFloatScale0to10),
      { 8} wbFloat('Height Range', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      {12} wbFloat('Color Range', cpNormal, True, 1, -1, nil, wbFloatScale0to1),
      {16} wbFloat('Wind Frequency'),
      {20} wbFloat('Above Water Clamp - Value').SetDefaultEditValue('Default'),
      {24} wbFloat('Below Water Clamp - Value').SetDefaultEditValue('Default'),
      {25} wbInteger('Max Density', itU8),
      {26} wbInteger('Min Slope', itU8),
      {27} wbInteger('Max Slope', itU8),
      {28} wbInteger('Flags', itU8, wbFlags([
        'Vertex Lighting',
        'Uniform Scaling',
        'Fits Slope',
        'Apply Between'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      {32} wbFloat('Coverage', cpNormal, True, 1, -1, nil, wbFloatScale0to100),
      {36} wbInteger('Dirtiness Min', itU8, wbDiv(255)),
      {37} wbInteger('Dirtiness Max', itu8, wbDiv(255))
    ], cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(IDLE, 'Animation', [
    wbEDID,
    wbCTDAs,
    wbString(DNAM, 'Behavior Graph'),
    wbString(ENAM, 'Animation Event'),
    wbArray(ANAM, 'Related Animations', wbFormIDCk('Related Animation', [AACT, IDLE, NULL]),
      ['Parent', 'Previous Sibling'], cpNormal, True),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      'Loose',
      'Preview',
      '',
      '',
      'Unknown 4'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbString(GNAM, 'Animation File'),
    wbFULL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(INFO, 'Dialog response',
    wbFlags(wbFlagsList([
      {0x00000040}  6, 'Info Group',
      {0x00000080}  7, 'Exclude From Export',
      {0x00002000} 13, 'Actor Changed'
    ])), [
    wbEDID,
    wbVMADFragmentedINFO,
    wbBaseFormComponents,
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
          {0x0080} 'Needs Review',
          {0x0100} 'Player Address',
          {0x0200} 'Unknown 9',
          {0x0400} 'Can Move While Greeting',
          {0x0800} 'No LIP File',
          {0x1000} 'Don''t Gray Out',
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
    wbFormIDCk(DNAM, 'Shared INFO', [INFO]),
    wbFormIDCk(GNAM, 'INFO group', [INFO]),

    wbRArray('Responses', wbRStruct('Response', [
      wbStruct(TRDA, 'Response Data', [
        wbFormIDCk('Emotion', [KYWD, FFFF]),
        wbInteger('WEM File', itU32, wbIntToHexStr, wbHexStrToInt),
        wbFloat('Emotion Out') // Interrupt Percentage?
      ]),
      wbRArray('Unknown', wbStruct(TROT, 'Unknown', [
        wbFormIDCk('Voice Type', [VTYP]),
        wbFloat('Emotion Out')
      ])),
      wbLStringKC(NAM1, 'Response Text', 0, cpTranslate, True),
      wbString(NAM2, 'Script Notes', 0, cpNormal, True),
      wbString(NAM3, 'Edits', 0, cpNormal, True),
      wbString(NAM4, 'Alternate LIP Text', 0, cpNormal, True),
      wbByteArray(NAM9, 'Text Hash'),
      wbBNAMAnimation,
      wbHNAMHNAM,
      wbSoundReference(RVSH)
    ], [])),
    wbCTDAs,
    wbLStringKC(RNAM, 'Prompt', 0, cpTranslate),
    wbFormIDCk(ANAM, 'Speaker', [NPC_]),
    wbFormIDCk(TSCE, 'Start Scene', [SCEN]),
    wbUnknown(INTV),
    wbSoundReference(WED0),
    wbStruct(TIQS, 'Set Parent Quest Stage', [
      wbInteger('On Begin', itS16),
      wbInteger('On End', itS16)
    ]),
    wbString(NAM0, 'Start Scene Phase').SetRequired,
    (*
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
    *)
    wbFormIDCk(MODQ, 'Reset Global', [GLOB]),
    wbInteger(INAM, 'Subtitle Priority', itU32, wbEnum([
      'Low',
      'Normal',
      'High',
      'Force'
    ])),
    wbEmpty(COCT, 'Unknown'), // container count? never followed by CNTO in Starfield.esm
    wbFormIDCk(NAM8, 'Affinity Event', [AFFE]),
    wbFormIDCk(SCSP, 'Speech Challenge', [SPCH]),
    wbFormIDCk(PERK, 'Skill/Perk', [PERK])
  ], False, wbINFOAddInfo, cpNormal, False, nil{wbINFOAfterLoad});

  (*{still exists in game code, but not in Starfield.esm}
  wbRecord(INGR, 'Ingredient', [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbDEFL,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbKeywords,
    wbGenericModel(True),
    wbETYP,
    wbSoundReference(PUSH),
    wbSoundReference(PDSH),
    wbStruct(DATA, 'Data', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ]).SetRequired,
    wbStruct(ENIT, 'Effect Data', [
      wbInteger('Ingredient Value', itS32),
      wbInteger('Flags', itU32,
        wbFlags(wbSparseFlags([
          0, 'No auto-calculation',
          1, 'Food item',
          8, 'References Persist'
        ], False, 9))
      )
    ]).SetRequired,
    wbEffects
  ]);*)

  wbRecord(KEYM, 'Key',
    wbFlags(wbFlagsList([
      {0x00000002} 2, 'Non-Playable',
      {0x00000800} 11, 'Calc Value From Components',
      {0x00002000} 13, 'Pack-In Use Only'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbXALG,
    wbFULL,
    wbGenericModel(True),
    wbDEST,
    wbCUSH,
    wbPUSH,
    wbPDSH,
    wbKeywords,
    wbFIMD,
    wbCVPA,
    wbCDIX,
    wbStruct(DATA, '', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbInteger(FLAG, 'Flags', itU32, wbFlags([
      'Allow Quest Item Crafting',
      'Non-Instanced Key'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbLStringKC(NNAM, 'Short Name', 0, cpTranslate)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(LIGH, 'Light',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Non-Playable',
      {0x00000080}  7, 'Unknown 7',
      {0x00000200}  9, 'Hidden From Local Map',
      {0x00008000} 15, 'Adaptive Lighting',
      {0x00010000} 16, 'Random Anim Start',
      {0x00020000} 17, 'Unknown 17',
      {0x00080000} 19, 'Has Currents',
      {0x02000000} 25, 'Obstacle',
      {0x10000000} 28, 'Portal-strict'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbDEFL,
    wbXALG,
    wbBaseFormComponents,
    wbGenericModel(True),
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbFULL,
    wbStruct(DAT2, 'Data', [
      { 0} wbInteger('Time', itS32),
      { 4} wbFloat('Radius'),
      { 8} wbByteColors('Color'),
      {12} wbInteger('Flags', itU16, wbFlags([
            'Unknown 0',
            'Can be Carried',
            '',
            '',
            'Off by Default',
            'Disable Specular',
            'Disable Distance Attenuation',
            'Is Direct Spotlight',
            'Use PBR Value',
            'Focus Spotlight Beam',
            'Unknown 10',
            '',
            'Externally Controlled'
           ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      {14} wbUnused(2),
      {16} wbFloat('Falloff Exponent'),
      {20} wbFloat('FOV'),
      {24} wbFloat('Near Clip'),
           wbStruct('Flicker Effect', [
      {28}   wbFloat('Period'),
      {32}   wbFloat('Intensity Amplitude'),
      {36}   wbFloat('Movement Amplitude')
           ]),
      {40} wbFloat('Shadow Offset'),
      {44} wbFloat('Inner FOV'),
      {48} wbInteger('PBR - Light Temperature (K)', itU32),
      {52} wbInteger('PBR - Luminous Power (lm)', itU32),
      {56} wbInteger('Light Type', itU8, wbEnum([
             'Omnidirectional',
             'Shadow Spotlight',
             'NonShadow Spotlight'
           ])),
      {57} wbInteger('Flicker Effect', itU8, wbEnum([
            'None',
            'Flicker',
            'Pulse'
           ])),
           wbStruct('Adaptive Lighting', [
      {58}   wbInteger('Use Adaptive Lighting', itU8, wbBoolEnum),
      {59}   wbUnused(1), // padding
      {60}   wbFloat('Adaptive Light Ec'),
      {64}   wbFloat('Adaptive Light Ev 100 Min'),
      {68}   wbFloat('Adaptive Light Ev 100 Max')
           ]),
      {72} wbFloat('Radius Falloff Exponent')
    ], cpNormal, True),
    wbString(NAM0, 'Gobo'),
    wbSoundReference(LLSH),
    wbFormIDCk(LNAM, 'Lens', [LENS]),
    wbStruct(FLBD, 'Barndoors', [
      { 0} wbFloat('Left'),
      { 4} wbFloat('Bottom'),
      { 8} wbFloat('Right'),
      {12} wbFloat('Top'),
      {16} wbFloat('Falloff Intensity'),
      {20} wbInteger('Has Fallout', itU8, wbBoolEnum),
      {21} wbInteger('Has Barndoors', itU8, wbBoolEnum),
      {22} wbUnused(2) // padding
    ], cpNormal, True),
    wbFLRDReq,
    wbFLGDReq,
    wbInteger(LLLD, 'Light Layer', itU32, wbEnum([], [ // same bits as the flags except CK has a drop down list to only allow single selection
      $01, 'Default Light Layer',
      $02, 'Helmet Light',
      $04, 'Ship Interior',
      $08, 'Ship Exterior',
      $0F, 'All Layers'
    ]), cpNormal, True).SetDefaultNativeValue(1).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbFLADReq,
    wbFloat(FVLD, 'Volumetric Light Intensity Scale')
  ], False, nil, cpNormal, False);

  {subrecords checked against Starfield.esm}
  wbRecord(LSCR, 'Load Screen',
    wbFlags(wbFlagsList([
      {0x00000400} 10, 'Displays In Main Menu',
      {0x00008000} 15, 'No Rotation'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbDESCReq(),
    wbCTDAs,
    wbString(ICON, 'Loadscreen')
    {
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
    }
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(LTEX, 'Landscape Texture',
    wbFlags(wbFlagsList([
      {0x00000200}  9, 'Unknown 9'
    ])), [
    wbEDID,
    wbString(BNAM, 'Material File'),
    wbFormIDCk(MNAM, 'Material Type', [MATT, NULL], False, cpNormal, True),
    wbStruct(HNAM, 'Havok Data', [
      wbInteger('Friction', itU8),
      wbInteger('Restitution', itU8)
    ], cpNormal, True).SetSummaryKeyOnValue([0,1]),
    wbFloat(QNAM, 'Dirtiness', cpNormal, True, 1, -1, nil, wbFloatScale0to1).SetDefaultEditValue('1.0')
  ]).SetSummaryKey([1]);

  var wbLeveledListEntryItem :=
    wbRStructExSK([0], [1], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itU16),
        wbUnused(2),
        wbFormIDCk('Reference', sigBaseObjects),
        wbInteger('Count', itU16),
        wbInteger('Chance None', itU8),
        wbUnused(1)
      ])
      .SetSummaryKeyOnValue([0, 3, 2, 4])
      .SetSummaryPrefixSuffixOnValue(0, '[Lv', ']')
      .SetSummaryPrefixSuffixOnValue(3, '', 'x')
      .SetSummaryPrefixSuffixOnValue(4, '{Chance None:', '%}')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlagOnValue(dfSummaryNoSortKey),
      wbCOED,
      wbCTDAs
    ], [])
    .SetSummaryMemberMaxDepth(0, 1)
    .IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  var wbLeveledListEntryNPC :=
    wbRStructExSK([0], [1], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itU16),
        wbUnused(2),
        wbFormIDCk('Reference', [NPC_, LVLN]),
        wbInteger('Count', itS16),
        wbInteger('Chance None', itU8),
        wbUnused(1)
      ])
      .SetSummaryKeyOnValue([0, 3, 2, 4])
      .SetSummaryPrefixSuffixOnValue(0, '[Lv', ']')
      .SetSummaryPrefixSuffixOnValue(3, '', 'x')
      .SetSummaryPrefixSuffixOnValue(4, '{Chance None:', '%}')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlagOnValue(dfSummaryNoSortKey),
      wbCOED,
      wbCTDAs
    ], [])
    .SetSummaryMemberMaxDepth(0, 1)
    .IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  var wbLeveledListEntryPackIn :=
    wbRStructExSK([0], [1], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itU16),
        wbUnused(2),
        wbFormIDCk('Reference', [PKIN, LVLP]),
        wbInteger('Count', itS16),
        wbInteger('Chance None', itU8),
        wbUnused(1)
      ])
      .SetSummaryKeyOnValue([0, 3, 2, 4])
      .SetSummaryPrefixSuffixOnValue(0, '[Lv', ']')
      .SetSummaryPrefixSuffixOnValue(3, '', 'x')
      .SetSummaryPrefixSuffixOnValue(4, '{Chance None:', '%}')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlagOnValue(dfSummaryNoSortKey),
      wbCTDAs.IncludeFlag(dfSummaryMembersNoName)
    ], [])
    .SetSummaryMemberMaxDepth(0, 1)
    .IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  var wbLeveledListEntrySpell :=
    wbRStructSK([0], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itU16),
        wbUnused(2),
        wbFormIDCk('Reference', [SPEL, LVSP]),
        wbInteger('Count', itU16),
        wbInteger('Chance None', itU8),
        wbUnused(1)
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
        wbInteger('Chance', itU32),
        wbUnused(4) // UI shows curve box but disabled
      ])
        .SetSummaryKey([0, 1])
        .SetSummaryMemberPrefixSuffix(1, '{Chance:', '%}')
        .IncludeFlag(dfCollapsed, wbCollapseLeveledItems)
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfSummaryNoSortKey)
      );

  {subrecords checked against Starfield.esm}
  wbRecord(LVLN, 'Leveled NPC',
    wbFlags(wbFlagsList([
      {0x00008000}  15, 'Calculate All (Still picks just one)'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbXALG,
    wbBaseFormComponents,
    wbXALG,
    wbLVLDReq,
    wbInteger(LVLM, 'Max Count', itU8, nil, cpNormal, True), { Always 00 } {Unavailable}
    wbInteger(LVLF, 'Flags', itU16, wbFlags([
      {0x0001} 'Calculate from all levels <= player''s level',
      {0x0002} 'Calculate for each item in count',
      {0x0004} 'Calculate All (Still picks just one)',
      {0x0008} 'Disable If Does Not Resolve 1',
      {0x0010} 'Disable If Does Not Resolve 2',
      {0x0020} 'Eval As Stack',
      {0x0040} 'Allow Shift Up',
      {0x0080} '',
      {0x0100} 'Do All Before Repeating'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbCTDAs,
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntryNPC, cpNormal, False, nil, wbLVLOsAfterSet),
    wbFilterKeywordChances,
    wbLStringKC(ONAM, 'Override Name', 0, cpTranslate),
    wbGenericModel(True)
  ], False, nil, cpNormal, False, nil, wbLLEAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(LVLI, 'Leveled Item',
    wbFlags(wbFlagsList([
      {0x00008000}  15, 'Use All'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbXALG,
    wbBaseFormComponents,
    wbLVLDReq,
    wbInteger(LVLM, 'Max Count', itU8, nil, cpNormal, True), { Always 00 }
    wbInteger(LVLF, 'Flags', itU16, wbFlags([
      {0x0001} 'Calculate from all levels <= player''s level',
      {0x0002} 'Calculate for each item in count',
      {0x0004} 'Use All',
      {0x0008} 'Show as Marker 1',
      {0x0010} 'Show as Marker 2',
      {0x0020} 'Eval As Stack',
      {0x0040} '',
      {0x0080} 'Get Chance From Required Biome',
      {0x0100} 'Do All Before Repeating'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbCTDAs,
    wbFormIDCk(LVLG, 'Use Chance None Global', [GLOB]),
    wbFormIDCk(LLRB, 'Required Biome', [BIOM]),
    wbFormIDCk(LLRV, 'Required Resource Vein', [IRES]),
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntryItem, cpNormal, False, nil, wbLVLOsAfterSet),
    wbFilterKeywordChances,
    wbFormIDCk(LVSG, 'Epic Loot Chance', [GLOB]),
    wbByteColors(LIMC, 'Marker Color'),
    wbLStringKC(ONAM, 'Override Name', 0, cpTranslate),
    wbInteger(LVLL, 'Legendary Item Default List Rank', itU8),
    wbGenericModel(True),
    wbFTYP
  ], False, nil, cpNormal, False, nil, wbLLEAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(LVLP, 'Leveled Pack In',
    wbFlags(wbFlagsList([
      {0x00000080}   7, 'Apply LRT To All But Pivot'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbXALG,
    wbBaseFormComponents,
    wbLVLDReq,
    wbInteger(LVLM, 'Max Count', itU8, nil, cpNormal, True), { Always 00 }
    wbInteger(LVLF, 'Flags', itU16, wbFlags([
      {0x0001} '',
      {0x0002} 'Calculate for each item in count',
      {0x0004} '',
      {0x0008} '',
      {0x0010} '',
      {0x0020} 'Eval As Stack',
      {0x0040} '',
      {0x0080} '',
      {0x0100} 'Do All Before Repeating'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbCTDAs,
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntryPackIn, cpNormal, False, nil, wbLVLOsAfterSet),
    //wbFilterKeywordChances,
    //wbLStringKC(ONAM, 'Override Name', 0, cpTranslate)
    wbGenericModel(True),
    wbFTYP
  ], False, nil, cpNormal, False, nil, wbLLEAfterSet);

  (* still exists in game code, but not in Starfield.esm *)
  wbRecord(LVSP, 'Leveled Spell',
    wbFlags(wbFlagsList([
      {0x00008000}  15, 'Use All'
    ])), [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbXALG,
    wbBaseFormComponents,
    wbLVLDReq,
    wbInteger(LVLM, 'Max Count', itU8, nil, cpNormal, True), { Always 00 } {Unavailable}
    wbInteger(LVLF, 'Flags', itU16, wbFlags([
      {0x0001} 'Calculate from all levels <= player''s level',
      {0x0002} 'Calculate for each item in count',
      {0x0004} 'Use All',
      {0x0008} '',
      {0x0010} '',
      {0x0020} '',
      {0x0040} '',
      {0x0080} '',
      {0x0100} 'Do All Before Repeating'
    ]), cpNormal, True),
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntrySpell, cpNormal, False, nil, wbLVLOsAfterSet)
  ]);
  (**)

  var wbMGEFType := wbInteger('Archetype', itU32, wbEnum([
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
    {26} 'Summon Duplicate',
    {27} 'Cure Paralysis',
    {28} 'Cure Addiction',
    {29} 'Cure Poison',
    {30} 'Concussion',
    {31} 'Stimpak',
    {32} 'Accumulate Magnitude',
    {33} 'Stagger',
    {34} 'Peak Value Modifier',
    {35} 'Cloak',
    {36} 'Command',
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
    {48} 'Boostpack',
    {49} 'Chameleon',
    {50} 'Capacity Value Modifier',
    {51} 'Reset Flora',
    {52} 'Drop Resources',
    {53} 'Antigravity'
  ])).SetAfterSet(wbMGEFArchtypeAfterSet);

  var wbMGEFData :=
    wbStruct(DATA, 'Magic Effect Data', [
      {  0} wbUnion('Assoc. Item', wbMGEFAssocItemDecider1, [
              wbFormID('Unused', cpIgnore),
              wbFormIDCk('Assoc. Item 1', [LIGH, NULL]),        // light
              wbFormIDCk('Assoc. Item 1', [WEAP, ARMO, NULL]),  // bound item
              wbFormIDCk('Assoc. Item 1', [NPC_, NULL]),        // summon creature
              wbFormIDCk('Assoc. Item 1', [HAZD, NULL]),        // guide, spawn hazard
              wbFormIDCk('Assoc. Item 1', [SPEL, NULL]),        // cloak
              wbFormIDCk('Assoc. Item 1', [DMGT, NULL]),        // immunity
              wbFormIDCk('Assoc. Item 1', [ENCH, NULL]),        // enhance weapon
              wbFormIDCk('Assoc. Item 2', [KYWD, NULL]),        // peak modifier
              wbFormIDCk('Assoc. Item 1', [DMGT, NULL])         // damage type
            ]),
      {  4} wbActorValue('Magic Skill'),
      {  8} wbFormIDCk('Casting Art', [NULL, ARTO]),
      { 12} wbFormIDCk('Unknown', [NULL, MOVT]),
      { 16} wbFormIDCk('Hit Shader', [NULL, EFSH]),
      { 20} wbFormIDCk('Enchant Shader', [NULL, EFSH]),
      { 24} wbFormIDCk('Enchant Art', [NULL, ARTO]),
      { 28} wbFormIDCk('Equip Ability', [NULL, SPEL]),
      { 32} wbFormIDCk('Explosion', [NULL, EXPL]),
      { 36} wbFormIDCk('Hit Effect Art', [NULL, ARTO]),
      { 40} wbFormIDCk('Image Space Modifier', [NULL, IMAD]),
      { 44} wbFormIDCk('Impact Data', [NULL, IPDS]),
      { 48} wbFormIDCk('Casting Light', [NULL, LIGH]),
      { 52} wbFormIDCk('Perk to Apply', [NULL, PERK]),
      { 56} wbUnion('Assoc. Item', wbMGEFAssocItemDecider2, [
              wbFormID('Unused', cpIgnore),
              wbActorValue('Assoc. Item 1')
            ]),
      { 60} wbFormIDCk('Projectile', [NULL, PROJ]),
      { 64} wbFormIDCk('Resist Value', [AVIF, NULL]),
      { 68} wbUnion('Assoc. Item', wbMGEFAssocItemDecider3, [
              wbFormID('Unused', cpIgnore),
              wbActorValue('Assoc. Item 2')
            ]),
            wbStruct('Script Effect AI', [
      { 72}   wbFloat('Delay Time'),
      { 76}   wbFloat('Score')
            ]),
      { 80} wbMGEFType,
            wbStruct('Spellmaking', [
      { 84}   wbFloat('Spellmaking - Area'),
      { 88}   wbFloat('Spellmaking - Casting Time')
            ]),
      { 92} wbFloat('Base Cost'),
      { 96} wbInteger('Casting Sound Level', itU32, wbSoundLevelEnum),
      {100} wbInteger('Casting Type', itU8, wbCastEnum),
      {101} wbInteger('Delivery Type', itU8, wbTargetEnum),
      {102} wbFloat('Dual Casting - Scale'),
      {106} wbInteger('Flags', itU32, wbFlags([
        {0x00000001}  'Hostile',
        {0x00000002}  'Recover',
        {0x00000004}  'Detrimental',
        {0x00000008}  'Snap to Navmesh',
        {0x00000010}  'No Hit Event',
        {0x00000020}  'Dynamic Restart',
        {0x00000040}  'Animate Start/Stop Reaction',
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
        {0x00080000}  'Difficulty Affects Magnitude',
        {0x00100000}  'Difficulty Affects Duration',
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
      wbInteger('Minimum Skill Level', itU32),
      {114} wbUnknown(2), // unused Counter Effect count?
      {116} wbFloat('Second AV Weight'),
      {120} wbFloat('Skill Usage Multiplier'),
      {124} wbFloat('Taper Curve'),
      {128} wbFloat('Taper Duration'),
      {132} wbFloat('Taper Weight')
    ], cpNormal, True)
    .IncludeFlag(dfFastAssign);

  {subrecords checked against Starfield.esm}
  wbRecord(MGEF, 'Magic Effect', [
    wbEDID,
    wbVMAD,
    wbFULL,
    wbFormIDCk(MDOB, 'Menu Display Object', [STAT]),
    wbKeywords,
    wbMGEFData,
    wbRArrayS('Counter Effects', wbFormIDCk(ESCE, 'Effect', [MGEF]){, cpNormal, False, nil, wbCounterEffectsAfterSet}),
    wbRArray('Sounds', wbStructSK(ESSH, [0], 'Sound Reference', [
      wbInteger('Type', itU8, wbEnum([
        {00} 'Draw/Sheathe',
        {01} 'Charge',
        {02} 'Ready',
        {03} 'Release',
        {04} 'Cast Loop (Conc)',
        {05} 'OnHit'
        ])),
      wbSoundReference('Sound Reference')
    ]).SetSummaryKeyOnValue([1]).IncludeFlag(dfCollapsed, wbCollapseSounds)
    ),
    wbLStringKC(DNAM, 'Magic Item Description', 0, cpTranslate),
    wbCTDAs
  ], False, nil, cpNormal, False, nil {wbMGEFAfterLoad}, wbMGEFAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(MISC, 'Misc. Item',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Non-Playable',
      {0x00000004}  11, 'Calc From Components',
      {0x00000004}  13, 'Pack-In Use Only'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbDEST,
    wbCUSH,
    wbPUSH,
    wbPDSH,
    wbKeywords,
    wbFIMD,
    wbCVPA,
    wbCDIX,
    wbStructSK(DATA, [0,1], 'Data', [
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ], cpNormal, True),
    // the amount of components is the same as size of CDIX, so should not be sorted probably
    wbInteger(FLAG, 'Flags', itU32, wbFlags([
      'Allow Quest Item Crafting',
      'Non-Instanced Key'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbLStringKC(NNAM, 'Short Name', 0, cpTranslate)
  ], False, nil, cpNormal, False);

  var wbComponent :=
    wbStructSK([0], 'Component', [
      wbFormIDCkNoReach('Component', sigBaseObjects),
      wbInteger('Count', itU32),
      wbFormIDCk('Curve Table', [NULL, CURV])
    ])
      .SetSummaryKey([1, 0])
      .SetSummaryMemberPrefixSuffix(0, '', '')
      .SetSummaryMemberPrefixSuffix(1, '', 'x')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfCollapsed, wbCollapseItems)
      .IncludeFlag(dfSummaryNoSortKey)
      .IncludeFlag(dfSummaryMembersNoName);

  var wbComponents := wbArrayS(FVPA, 'Components', wbComponent);
  var wbRepairComponents := wbArrayS(REPR, 'Repair Components', wbComponent);
  {subrecords checked against Starfield.esm}
  wbRecord(COBJ, 'Constructible Object',
    wbFlags(wbFlagsList([
      {0x04000000}  26, 'List Contains Variants'
    ])), [
    wbEDID.SetRequired,
    wbBaseFormComponents,
    wbDESC().SetRequired,
    wbFormIDCkNoReach(BNAM, 'Workbench Keyword', [NULL, KYWD]).SetRequired,
    wbCTDAs,
    wbComponents,
    wbArrayS(RQPK, 'Required Perks',
      wbStructSK([0], 'Required Perk', [
        wbFormIDCk('Perk', [PERK]),
        wbInteger('Rank', itU32),
        wbUnused(4) // disable curve field
      ])
        .SetSummaryKey([0, 1])
        .SetSummaryDelimiter(', ')
        .IncludeFlag(dfCollapsed, wbCollapseConditions)
      ),
    wbFormIDCk(CNAM, 'Created Object', sigBaseObjects).SetRequired,
    wbInteger(NNAM, 'Amount Produced', itU16).SetRequired,
    wbFloat(SNAM, 'Menu Priority Order').SetRequired,
    wbInteger(TNAM, 'Tier', itU8, wbEnum([
      '0',
      '1',
      '2',
      '3',
      '4',
      '5'
    ])).SetRequired,
    wbCUSH,
    wbPUSH,
    wbPDSH,
    wbRepairComponents,
    wbInteger(LRNM, 'Learn Method', itU8, wbLearnMethodEnum).SetRequired,
    wbInteger(DATA, 'Value', itU32).SetRequired,
    wbFormIDCk(ANAM, 'Menu Art Object', [ARTO]),
    wbFormIDCk(GNAM, 'Learned From', sigBaseObjects),
    wbFormIDCk(CVT0, 'Base Return Scale Table', [CURV]),
    wbFormIDCk(LRNC, 'Learn Chance', [GLOB]),
    wbFormIDCk(JNAM, 'Max Build Count Global', [GLOB]),
    wbArrayS(FNAM, 'Recipe Filters', wbFormIDCk('Keyword', [KYWD])),
    wbInteger(RECF, 'Unknown', itU64, wbFlags([
      'Filter Not Required To Learn',
      'Unknown 1',
      'Exclude From Workshop LOD'
     ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags)
  ]);

  var wbRaceOverrideDontShow :=
    function(aFlag: Byte): TwbDontShowCallback
    begin
      Result :=
        function(const aElement: IwbElement): Boolean
        begin
          Result := False;
          var lContainer: IwbContainerElementRef;
          if not Supports(aElement, IwbContainerElementRef, lContainer) then
            Exit;

          var lActiveOverridesValue := lContainer.ElementNativeValues['...\ONA2\General\General\Active Overrides']; //Unknown 6 double because of union
          if not VarIsOrdinal(lActiveOverridesValue) then
            Exit;

          var lActiveOverrides: Int64 := lActiveOverridesValue;

          Result := (lActiveOverrides and (1 shl aFlag)) = 0;
        end;
    end;

  var wbRACEDAT2Flags :=
    wbFlags([
      {0x0000000000000001} 'Playable',
      {0x0000000000000002} 'FaceGen Head',
      {0x0000000000000004} 'Child',
      {0x0000000000000008} 'Tilt Front/Back',
      {0x0000000000000010} 'Tilt Left/Right',
      {0x0000000000000020} 'Jumps',
      {0x0000000000000040} 'Swims',
      {0x0000000000000080} 'Flies',
      {0x0000000000000100} 'Walks',
      {0x0000000000000200} 'Immobile',
      {0x0000000000000400} 'Not Pushable',
      {0x0000000000000800} 'No Combat In Water',
      {0x0000000000001000} 'No Rotating to Head-Track',
      {0x0000000000002000} 'Don''t Show Blood Spray',
      {0x0000000000004000} 'Don''t Show Blood Decal',
      {0x0000000000008000} 'Uses Head Track Anims',
      {0x0000000000010000} 'Spells Align w/Magic Node',
      {0x0000000000020000} 'Use World Raycasts For FootIK',
      {0x0000000000040000} 'Allow Ragdoll Collision',
      {0x0000000000080000} 'Regen HP In Combat',
      {0x0000000000100000} 'Can''t Open Doors',
      {0x0000000000200000} 'Allow PC Dialogue',
      {0x0000000000400000} 'No Knockdowns',
      {0x0000000000800000} 'Allow Pickpocket',
      {0x0000000001000000} 'Always Use Proxy Controller',
      {0x0000000002000000} 'Don''t Show Weapon Blood',
      {0x0000000004000000} 'Overlay Head Part List', {>>>Only one can be active<<<}
      {0x0000000008000000} 'Override Head Part List', {>>>Only one can be active<<<}
      {0x0000000010000000} 'Can Pickup Items',
      {0x0000000020000000} 'Allow Multiple Membrane Shaders',
      {0x0000000040000000} 'Can Dual Wield',
      {0x0000000080000000} 'Avoids Roads',
      {0x0000000100000000} 'Use Advanced Avoidance',
      {0x0000000200000000} 'Non-Hostile',
      {0x0000000400000000} 'Floats',
      {0x0000000800000000} 'Unknown 35',
      {0x0000001000000000} 'Unknown 36',
      {0x0000002000000000} 'Head Axis Bit - Y',
      {0x0000004000000000} 'Head Axis Bit - Z',
      {0x0000008000000000} 'Can Melee When Knocked Down',
      {0x0000010000000000} 'Use Idle Chatter During Combat',
      {0x0000020000000000} 'Ungendered',
      {0x0000040000000000} 'Can Move When Knocked Down',
      {0x0000080000000000} 'Use Large Actor Pathing',
      {0x0000100000000000} 'Unknown 44',
      {0x0000200000000000} 'Flight - Defer Kill',
      {0x0000400000000000} 'Calc Character Controller Rotation Center OFF',
      {0x0000800000000000} 'Flight - Allow Procedural Crash Land',
      {0x0001000000000000} 'Disable Weapon Culling',
      {0x0002000000000000} 'Simulate Cloth On Down',
      {0x0004000000000000} 'Has Facial Rig',
      {0x0008000000000000} 'Can Use Crippled Limbs',
      {0x0010000000000000} 'Use Quadruped Controller',
      {0x0020000000000000} 'Low Priority Pushable',
      {0x0040000000000000} 'Cannot Use Playable Items',
      {0x0080000000000000} 'Unknown 55',
      {0x0100000000000000} 'Unknown 56',
      {0x0200000000000000} 'Tunnels',
      {0x0400000000000000} 'Hops',
      {0x0800000000000000} 'Teleport',
      {0x1000000000000000} 'Unknown 60',
      {0x2000000000000000} 'Unknown 61',
      {0x4000000000000000} 'Unknown 62',
      {0x8000000000000000} 'Unknown 63'
    ]);

  var wbRaceSizeEnum :=
    wbEnum([], [
     -1, 'Unknown',
      0, 'Small',
      1, 'Medium',
      2, 'Large',
      3, 'Extra Large'
    ]);

  var wbRACEDAT2Size := function(aName: string = 'Size'): IwbIntegerDef
  begin
    Result := wbInteger(aName, itS32, wbRaceSizeEnum);
  end;

  {subrecords checked against Starfield.esm}
  wbRecord(NPC_, 'Non-Player Character (Actor)',
    wbFlags(wbFlagsList([
      {0x00000400} 10, 'Unknown 10',
      {0x00040000} 18, 'Compressed',
      {0x00080000} 19, 'Unknown 19',
      {0x00400000} 22, 'Unknown 22',
      {0x20000000} 29, 'Bleedout Override'
    ]), [18]), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbDEFL,
    wbXALG,
    wbBaseFormComponents,
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
        {0x02000000} 'Forced Starts Dead',
        {0x04000000} 'Unknown 26',
        {0x08000000} 'Unknown 27',
        {0x10000000} 'Unknown 28',
        {0x20000000} 'Is Ghost',
        {0x40000000} 'Ignore Friendly Hits',
        {0x80000000} 'Invulnerable'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
      ,
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
        {0x1000} 'Keywords',
        {0x2000} 'Reaction Radius',
        {0x4000} 'Combat Style'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ], cpNormal, True)
      .SetSummaryKeyOnValue([0,6])
      .SetSummaryPrefixSuffixOnValue(0, '[',']')
      .SetSummaryPrefixSuffixOnValue(1, '[',']'),
    wbRArrayS('Factions', wbFaction, cpNormal, False, nil, nil, nil{wbActorTemplateUseFactions}),
    wbFormIDCk(INAM, 'Death item', [LVLI], False, cpNormal, False, nil{wbActorTemplateUseTraits}),
    wbFormIDCk(VTCK, 'Voice', [VTYP], False, cpNormal, False, nil{wbActorTemplateUseTraits}),
    wbFormIDCk(TPLT, 'Default Template', [BMMO, LVLN, NPC_]),
    wbFormIDCk(LTPT, 'Legendary Template', [BMMO, LVLN, NPC_]),
    wbFormIDCk(LTPC, 'Legendary Chance', [GLOB]),
    wbStruct(TPTA, 'Template Actors', [
      wbFormIDCk('Traits', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate0),
      wbFormIDCk('Stats', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate1),
      wbFormIDCk('Factions', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate2),
      wbFormIDCk('Spell List', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate3),
      wbFormIDCk('AI Data', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate4),
      wbFormIDCk('AI Packages', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate5),
      wbFormIDCk('Model/Animation', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate6),
      wbFormIDCk('Base Data', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate7),
      wbFormIDCk('Inventory', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate8),
      wbFormIDCk('Script', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate9),
      wbFormIDCk('Def Pack List', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate10),
      wbFormIDCk('Attack Data', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate11),
      wbFormIDCk('Keywords', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate12),
      wbFormIDCk('Reaction Radius', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate13),
      wbFormIDCk('Combat Style', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate14)
    ], cpNormal, False, wbActorTemplatesUseTemplateAny)
    .SetSummaryKeyOnValue([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14])
    .IncludeFlagOnValue(dfSummaryExcludeNULL)
    ,
    wbFormIDCk(RNAM, 'Race', [RACE], False, cpNormal, True, nil{wbActorTemplateUseTraits}),
//    wbSPCT,
    wbSPLOs,
    wbDEST,
    wbFormIDCk(WNAM, 'Skin', [ARMO], False, cpNormal, False),
//    wbFormIDCk(ANAM, 'Far away model', [ARMO], False, cpNormal, False, nil{wbActorTemplateUseTraits}),
    wbFormIDCk(ATKR, 'Attack Race', [RACE], False, cpNormal, False),
    wbFormIDCk(SPOR, 'Spectator Override Package List', [FLST]),
    wbFormIDCk(OCOR, 'Observe Dead Body Override Package List', [FLST]),
    wbFormIDCk(GWOR, 'Guard Warn Override Package List', [FLST]),
    wbFormIDCk(ECOR, 'Combat Override Package List', [FLST]),
    wbFormIDCk(FCPL, 'Follower Command Package List', [FLST]),
    wbFormIDCk(RCLR, 'Follower Elevator Package List', [FLST]),
    wbFormIDCk(RPLD, 'Sound Detection Package List', [FLST]),
    wbFormIDCk(RPLI, 'Sight Detection Package List', [FLST]),
    wbRStruct('Perks', [
      wbInteger(PRKZ, 'Perk Count', itU32, nil, cpBenign),
      wbRArrayS('Perks',
        wbStructSK(PRKR, [0], 'Perk', [
          wbFormIDCk('Perk', [PERK]),
          wbInteger('Rank', itU8)
        ])
        .SetSummaryKeyOnValue([1])
        .SetSummaryPrefixSuffixOnValue(1, '{Rank: ', '}')
        .IncludeFlagOnValue(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed)
        , cpNormal, False, nil, wbPRKRsAfterSet
      ).SetRequired
    ], []).SetSummaryKey([1]),
    wbPRPS,
    wbFTYP,
    wbNTRM,
    wbContainerItems.SetSummaryKey([1]),
    wbAIDT,
    wbRArray('Packages', wbFormIDCk(PKID, 'Package', [PACK]), cpNormal, False, nil{wbActorTemplateUseAIPackages}),
    wbArray(RDSA, 'Reaction Radius Behavior',
      wbStruct('Entry', [
        {  0} wbInteger('Reaction Type', itU32, wbEnum([
          'Warn',
          'Warn and Attack',
          'Attack',
          'Curious',
          'Flee',
          'Warn and Alarm'
        ])),
        {  4} wbInteger('Reaction Target', itU32, wbEnum([
          'Player',
          'Enemies',
          'Neutral',
          'PlayerNeutralEnemies',
          'PlayerNeutral',
          'PlayerEnemies',
          'Enemies Neutral'
        ])),
        {  8} wbFormIDCk('Packages', [NULL, FLST]),
        { 12} wbInteger('Flags', itU32, wbFlags([
                {0x00000001} { 0} 'Use GLOB Reaction Radius',
                {0x00000002} { 1} 'Use GLOB Exit Radius',
                {0x00000004} { 2} 'Use GLOB Max Number Of Times To React',
                {0x00000008} { 3} 'Use GLOB Max Herd Members To Animate',
                {0x00000010} { 4} 'Use GLOB Number of Warnings Before Attack',
                {0x00000020} { 4} 'Reaction Center Override',
                {0x00000040} { 6} 'Use Linked Reference',
                {0x00000080} { 7} 'Use Specific Reference',
                {0x00000100} { 8} 'Number of Warnings Before Attack',
                {0x00000200} { 9} 'Warn Timer On Warn/Attack',
                {0x00000400} {10} 'Use GLOB Warn Timer On Warn/Attack',
                {0x00000800} {11} 'All Reaction Behavior',
                {0x00001000} {12} 'Avoid Target',
                {0x00002000} {13} 'Use GLOB Cool Down Timer',
                {0x00004000} {14} 'Fight Back',
                {0x00008000} {15} 'Disallow Threat Backdown'
        ])),
        { 16} wbFormIDCk('Reaction Radius GLOB', [NULL, GLOB]),
        { 20} wbFormIDCk('Exit Radius GLOB', [NULL, GLOB]),
        { 24} wbFormIDCk('Max Number Of Times To React GLOB', [NULL, GLOB]),
        { 28} wbFormIDCk('Max Herd Members To Animate GLOB', [NULL, GLOB]),
        { 32} wbFormIDCk('Number of Warnings Before Attack GLOB', [NULL, GLOB]),
        { 36} wbFloat('Max Number Of Times To React'),
        { 40} wbFloat('Reaction Radius'),
        { 44} wbFloat('Exit Radius'),
        { 48} wbFloat('Max Herd Members To Animate'),
        { 52} wbFloat('Number of Warnings Before Attack'),
        { 56} wbFormIDCk('Linked Ref Keyword', [NULL, KYWD]),
        { 60} wbFormIDCk('Specific Reference', sigReferences),
        { 64} wbFormIDCk('Warn Timer On Warn/Attack GLOB', [NULL, GLOB]),
        { 68} wbFloat('Warn Timer On Warn/Attack'),
        { 72} wbFloat('Cool Down Timer'),
        { 76} wbFormIDCk('Cool Down Timer GLOB', [NULL, GLOB])
      ])
        .SetSummaryKey([14])
        .IncludeFlag(dfCollapsed, wbCollapseRDSA)
    ),
    wbStruct(FLEE, 'Flee Settings', [
      wbFormID('Flee Distance GLOB'),
      wbFormID('Safe Timer GLOB'),
      wbFormID('Chance of Diversion Animation GLOB'),
      wbFloat('Flee Distance'),
      wbFloat('Safe Timer'),
      wbFloat('Chance of Diversion Animation')
    ]),
    wbKeywords,
    wbAPPR,
    wbObjectTemplate,
    wbMarkerReq(STOP),
    wbFormIDCk(CNAM, 'Class', [CLAS], False),
    wbFULL,
    wbLStringKC(SHRT, 'Short Name', 0, cpTranslate),
    wbLStringKC(LNAM, 'Plural Name', 0, cpTranslate),
    wbMarkerReq(DATA),
    wbStruct(DNAM, '', [
      wbInteger('Calculated Health', itU16),
      wbInteger('Calculated Action Points', itU16),
      wbInteger('Far Away Model Distance', itU16),
      wbInteger('Geared Up Weapons', itU8),
      wbUnused(1)
    ])
      .SetSummaryKeyOnValue([0,1,2,3])
      .SetSummaryPrefixSuffixOnValue(0, 'Health: ','')
      .SetSummaryPrefixSuffixOnValue(1, 'AP: ','')
      .SetSummaryPrefixSuffixOnValue(2, 'Model Distance: ','')
      .SetSummaryPrefixSuffixOnValue(3, 'Weapons: ','')
      .SetSummaryDelimiterOnValue(', '),
    wbRArrayS('Head Parts', wbFormIDCk(PNAM, 'Head Part', [HDPT]), cpNormal, False, nil, nil, nil{wbActorTemplateUseModelAnimation}),
//    wbFormIDCk(HCLF, 'Hair Color', [CLFM], False, cpNormal, False),
//    wbFormIDCk(BCLF, 'Facial Hair Color', [CLFM], False, cpNormal, False),
    wbFormIDCk(ZNAM, 'Combat Style', [CSTY], False, cpNormal, False),
//    wbFormIDCk(GNAM, 'Gift Filter', [FLST], False, cpNormal, False),
    wbUnknown(NAM5, cpNormal, True),
    wbFloat(NAM6, 'Height Min', cpNormal, True),
//    wbFloat(NAM7, 'Unused', cpNormal, True),
    wbFloat(NAM4, 'Height Max'),
    wbStruct(MWGT, 'Weight', [
       wbFloat('Thin'),
       wbFloat('Muscular'),
       wbFloat('Fat')
    ])
      .SetSummaryKeyOnValue([0,1,2])
      .SetSummaryPrefixSuffixOnValue(0, 'Thin: ','')
      .SetSummaryPrefixSuffixOnValue(1, 'Muscular: ','')
      .SetSummaryPrefixSuffixOnValue(2, 'Fat: ','')
      .SetSummaryDelimiterOnValue(', '),
//    wbInteger(NAM8, 'Sound Level', itU32, wbSoundLevelEnum, cpNormal, True),
    wbRStructSK([1],'Actor Sounds', [
      wbInteger(CS3H, 'Count', itU32, nil, cpBenign, True),
      wbRArray('Sounds',
        wbRStruct('Sound', [
          wbFormIDCk(CS3K, 'ArcheType', [KYWD]),
          wbSoundReference(CS3S)
        ], [])
          .IncludeFlag(dfAllowAnyMember)
          .IncludeFlag(dfStructFirstNotRequired),
      cpNormal, True)
        .SetCountPath(CS3H),
      wbInteger(CS3F, 'Stop Concious Loop When Unconscious', itU8, wbBoolEnum, cpNormal, True),
      wbMarkerReq(CS3E)
    ], []),
    wbFormIDCk(CSCR, 'Inherits Sounds From', [NPC_], False, cpNormal, False),
//    wbFormIDCk(PFRN, 'Power Armor Stand', [FURN]),
    wbFormIDCk(QSTA, 'Affinity Event Quest', [QUST]),
    wbFormIDCk(BNAM, 'Affinity Event Dialogue', [DLBR]),
    wbFormIDCk(DOFT, 'Default Outfit', [OTFT], False, cpNormal, False),
    wbFormIDCk(SOFT, 'Space Outfit', [OTFT], False, cpNormal, False),
    wbFormIDCk(DPLT, 'Default Package List', [FLST], False, cpNormal, False),
    wbFormIDCk(CRIF, 'Crime Faction', [FACT], False, cpNormal, False),
    wbFormIDCk(HEFA, 'Formation Faction', [FACT]),
    wbInteger(EDCT, 'Tint Count', itU8, nil, cpBenign).IncludeFlag(dfSkipImplicitEdit),
    wbRArray('AVMD Tints',
      wbRStruct('Tint', [
        wbAVMDMNAMReq,
        wbString(TNAM, 'Tint Group').SetRequired,
        wbString(QNAM, 'Tint Name').SetRequired,
        wbString(VNAM, 'Tint Texture').SetRequired,
        wbByteColors(NNAM, 'Tint Color').SetRequired,
        wbInteger(INTV, 'Intensity', itU32).SetRequired       //1-128
      ], [])
        .SetSummaryKey([4,1,2,5,3])
        .SetSummaryMemberPrefixSuffix(4, '',' for')
        .SetSummaryMemberPrefixSuffix(1, '',':')
        .SetSummaryMemberPrefixSuffix(2, '','')
        .SetSummaryMemberPrefixSuffix(5, 'at ',' intensity')
        .SetSummaryMemberPrefixSuffix(3, 'using "','"')
        .IncludeFlag(dfSummaryMembersNoName)
    ).SetCountPath(EDCT),

    wbStruct(MRSV, 'Body Morph Region Values', [
      wbFloat('Head'),
      wbFloat('Upper Torso'),
      wbFloat('Arms'),
      wbFloat('Lower Torso'),
      wbFloat('Legs')
    ]).SetSummaryKeyOnValue([0,1,2,3,4]),

    wbRArrayS('Face Dial Positions',
      wbRStructSK([0], 'Face Dial Position', [
        wbInteger(FMSI, 'Index', itU32,
          function(aFaceDialIndex: Int64; const aElement: IwbElement; aType: TwbCallbackType): string
          begin
            var lContainer: IwbContainer;
            if not Supports(aElement, IwbContainer, lContainer) then
              Exit;

            case aType of
              ctToStr, ctToSummary, ctToEditValue: begin
                Result := aFaceDialIndex.ToString;
                if aType = ctToStr then
                  Result := Result + ' <Warning: Could not resolve face dial>';
              end;
              ctToSortKey: begin
                Result := IntToHex64(aFaceDialIndex, 8);
                Exit;
              end;
              ctCheck: begin
                Result := '<Warning: Could not resolve face dial>';
              end;
              ctEditType: begin
                Result := 'ComboBox';
                Exit;
              end;
              ctEditInfo: Result := '';
            end;

            var lRace := lContainer.ElementLinksTo['...\RNAM'];
            var lRaceMainRecord : IwbMainRecord;
            if not Supports(lRace, IwbMainRecord, lRaceMainRecord) then
              Exit;

            if lRaceMainRecord.Signature <> RACE then begin
              case aType of
                ctToStr: Result := aFaceDialIndex.ToString + ' <Warning: "' + lRaceMainRecord.ShortName + '" is not a Race record>';
                ctCheck: Result := '<Warning: "' + lRaceMainRecord.ShortName + '" is not a Race record>';
              end;
              Exit;
            end;

            var lIsFemale := lContainer.ElementExists['...\ACBS\Flags\Female'];
            var lGender := 'Male';
            if lIsFemale then
              lGender := 'Female';

            var lRaceFaceDials := lRaceMainRecord.ElementByPath['Chargen and Skintones\' + lGender + '\Chargen\Face Dials'];

            var lRaceFaceDialsContainer: IwbContainerElementRef;
            if not Supports(lRaceFaceDials, IwbContainerElementRef, lRaceFaceDialsContainer) then begin
              case aType of
                ctToStr: Result := aFaceDialIndex.ToString + ' <Warning: "' + lRaceMainRecord.ShortName + '" does not contain ' + lGender + ' Chargen Face Dials>';
                ctCheck: Result := '<Warning: "' + lRaceMainRecord.ShortName + '" does not contain ' + lGender + ' Chargen Face Dials>';
              end;
              Exit;
            end;

            var lEditInfos: TStringList := nil;
            if aType = ctEditInfo then
              lEditInfos := TStringList.Create;
            try
              for var lRaceFaceDialsIdx := 0 to Pred(lRaceFaceDialsContainer.ElementCount) do begin
                var lRaceFaceDial := lRaceFaceDialsContainer.Elements[lRaceFaceDialsIdx];

                var lRaceFaceDialContainer: IwbContainerElementRef;
                if not Supports(lRaceFaceDial, IwbContainerElementRef, lRaceFaceDialContainer) then
                  Continue;

                var lSkinIndexValue := lRaceFaceDialContainer.ElementNativeValues[FDSI];
                if not VarIsOrdinal(lSkinIndexValue) then
                  Continue;
                var lSkinIndex: Integer := lSkinIndexValue;

                if (lSkinIndex = aFaceDialIndex) or Assigned(lEditInfos) then begin
                  var lIndexString := IntToStr(lSkinIndex);
                  while Length(lIndexString) < 3 do
                    lIndexString := '0' + lIndexString;

                  var lLabel: string;
                  case aType of
                    ctToSummary: lLabel := lRaceFaceDialContainer.ElementSummaries[FDSL];
                    ctToEditValue, ctEditInfo: lLabel := lRaceFaceDialContainer.ElementValues[FDSL];
                  else
                    lLabel := lRaceFaceDialContainer.ElementValues[FDSL];
                  end;

                  if lLabel <> '' then
                    lIndexString := lIndexString + ' ' + lLabel;

                  if Assigned(lEditInfos) then
                    lEditInfos.Add(lIndexString)
                  else if lSkinIndex = aFaceDialIndex then begin
                    case aType of
                      ctToStr, ctToSummary, ctToEditValue: Result := lIndexString;
                      ctCheck: Result := '';
                    end;
                    Exit;
                  end;
                end;
              end;

              case aType of
                ctToStr, ctToSummary: begin
                  Result := aFaceDialIndex.ToString;
                  if aType = ctToStr then
                    Result := Result + ' <Warning: Face Dial not found in "' + lRaceMainRecord.Name + '">';
                end;
                ctCheck: Result := '<Warning: Face Dial not found in "' + lRaceMainRecord.Name + '">';
                ctEditInfo: begin
                  lEditInfos.Sort;
                  Result := lEditInfos.CommaText;
                end;
              end;
            finally
              FreeAndNil(lEditInfos);
            end;
          end,
          wbIntPrefixedStrToInt
        )
          .SetLinksToCallbackOnValue(
            function(const aElement: IwbElement): IwbElement
            begin
              Result := nil;

              var lContainer: IwbContainer;
              if not Supports(aElement, IwbContainer, lContainer) then
                Exit;

              var lFaceDialIndexValue := aElement.NativeValue;
              if not VarIsOrdinal(lFaceDialIndexValue) then
                Exit;
              var lFaceDialIndex: Integer := lFaceDialIndexValue;

              var lRace := lContainer.ElementLinksTo['...\RNAM'];
              var lRaceMainRecord : IwbMainRecord;
              if not Supports(lRace, IwbMainRecord, lRaceMainRecord) then
                Exit;

              var lIsFemale := lContainer.ElementExists['...\ACBS\Flags\Female'];
              var lGender := 'Male';
              if lIsFemale then
                lGender := 'Female';

              var lRaceFaceDials := lRaceMainRecord.ElementByPath['Chargen and Skintones\' + lGender + '\Chargen\Face Dials'];

              var lRaceFaceDialsContainer: IwbContainerElementRef;
              if not Supports(lRaceFaceDials, IwbContainerElementRef, lRaceFaceDialsContainer) then
                Exit;

              for var lRaceFaceDialsIdx := 0 to Pred(lRaceFaceDialsContainer.ElementCount) do begin
                var lRaceFaceDial := lRaceFaceDialsContainer.Elements[lRaceFaceDialsIdx];

                var lRaceFaceDialContainer: IwbContainerElementRef;
                if not Supports(lRaceFaceDial, IwbContainerElementRef, lRaceFaceDialContainer) then
                  Continue;

                var lSkinIndexValue := lRaceFaceDialContainer.ElementNativeValues[FDSI];
                if not VarIsOrdinal(lSkinIndexValue) then
                  Continue;
                var lSkinIndex: Integer := lSkinIndexValue;

                if lSkinIndex = lFaceDialIndex then
                  Exit(lRaceFaceDial);
              end;
            end)
          .SetRequired,
        wbFloat(FMRS, 'Position').SetRequired
      ], [])
        .SetSummaryMemberPrefixSuffix(0, '[',']')
        .SetSummaryKey([1])
        .IncludeFlag(dfSummaryNoName)
        .IncludeFlag(dfCollapsed)
    ),

    wbRArrayS('Face Morphs',
      wbRStructSK([0], 'Face Morph Phenotype', [
        wbInteger(FMRI, 'Face Morph Index', itU32,
        function(aFaceMorphIndex: Int64; const aElement: IwbElement; aType: TwbCallbackType): string
            begin
              var lContainer: IwbContainer;
              if not Supports(aElement, IwbContainer, lContainer) then
                Exit;

              case aType of
                ctToStr, ctToSummary, ctToEditValue: begin
                  Result := aFaceMorphIndex.ToString;
                  if aType = ctToStr then
                    Result := Result + ' <Warning: Could not resolve face morph phenotype>';
                end;
                ctToSortKey: begin
                  Result := IntToHex64(aFaceMorphIndex, 8);
                  Exit;
                end;
                ctCheck: begin
                  Result := '<Warning: Could not resolve face morph phenotype>';
                end;
                ctEditType: begin
                  Result := 'ComboBox';
                  Exit;
                end;
                ctEditInfo: Result := '';
              end;

              var lRace := lContainer.ElementLinksTo['...\RNAM'];
              var lRaceMainRecord : IwbMainRecord;
              if not Supports(lRace, IwbMainRecord, lRaceMainRecord) then
                Exit;

              if lRaceMainRecord.Signature <> RACE then begin
                case aType of
                  ctToStr: Result := aFaceMorphIndex.ToString + ' <Warning: "' + lRaceMainRecord.ShortName + '" is not a Race record>';
                  ctCheck: Result := '<Warning: "' + lRaceMainRecord.ShortName + '" is not a Race record>';
                end;
                Exit;
              end;

              var lIsFemale := lContainer.ElementExists['...\ACBS\Flags\Female'];
              var lGender := 'Male';
              if lIsFemale then
                lGender := 'Female';

              var lRaceFaceMorphs := lRaceMainRecord.ElementByPath['Chargen and Skintones\' + lGender + '\Chargen\Face Morph Phenotypes'];

              var lRaceFaceMorphsContainer: IwbContainerElementRef;
              if not Supports(lRaceFaceMorphs, IwbContainerElementRef, lRaceFaceMorphsContainer) then begin
                case aType of
                  ctToStr: Result := aFaceMorphIndex.ToString + ' <Warning: "' + lRaceMainRecord.ShortName + '" does not contain ' + lGender + ' Chargen Face Morph Phenotype>';
                  ctCheck: Result := '<Warning: "' + lRaceMainRecord.ShortName + '" does not contain ' + lGender + ' Chargen Face Morph Phenotype>';
                end;
                Exit;
              end;

              var lEditInfos: TStringList := nil;
              if aType = ctEditInfo then
                lEditInfos := TStringList.Create;
              try
                for var lRaceFaceMorphIdx := 0 to Pred(lRaceFaceMorphsContainer.ElementCount) do begin
                  var lRaceFaceMorph := lRaceFaceMorphsContainer.Elements[lRaceFaceMorphIdx];

                  var lRaceFaceMorphContainer: IwbContainerElementRef;
                  if not Supports(lRaceFaceMorph, IwbContainerElementRef, lRaceFaceMorphContainer) then
                    Continue;

                  var lMorphIndexValue := lRaceFaceMorphContainer.ElementNativeValues[FMRI];
                  if not VarIsOrdinal(lMorphIndexValue) then
                    Continue;
                  var lMorphIndex: Integer := lMorphIndexValue;

                  if (lMorphIndex = aFaceMorphIndex) or Assigned(lEditInfos) then begin
                    var lIndexString := IntToStr(lMorphIndex);
                    while Length(lIndexString) < 3 do
                      lIndexString := '0' + lIndexString;

                    var lName: string;
                    case aType of
                      ctToSummary: lName := lRaceFaceMorphContainer.ElementSummaries[FMRN];
                      ctToEditValue, ctEditInfo: lName := lRaceFaceMorphContainer.ElementValues[FMRN];
                    else
                      lName := lRaceFaceMorphContainer.ElementValues[FMRN];
                    end;

                    if lName <> '' then
                      lIndexString := lIndexString + ' ' + lName;

                    if Assigned(lEditInfos) then
                      lEditInfos.Add(lIndexString)
                    else if lMorphIndex = aFaceMorphIndex then begin
                      case aType of
                        ctToStr, ctToSummary, ctToEditValue: Result := lIndexString;
                        ctCheck: Result := '';
                      end;
                      Exit;
                    end;
                  end;
                end;

                case aType of
                  ctToStr, ctToSummary: begin
                    Result := aFaceMorphIndex.ToString;
                    if aType = ctToStr then
                      Result := Result + ' <Warning: Face Morph Phenotype not found in "' + lRaceMainRecord.Name + '">';
                  end;
                  ctCheck: Result := '<Warning: Face Morph Phenotype not found in "' + lRaceMainRecord.Name + '">';
                  ctEditInfo: begin
                    lEditInfos.Sort;
                    Result := lEditInfos.CommaText;
                  end;
                end;
              finally
                FreeAndNil(lEditInfos);
              end;
            end,
            wbIntPrefixedStrToInt

        )
        .SetLinksToCallbackOnValue(
              function(const aElement: IwbElement): IwbElement
              begin
                Result := nil;

                var lContainer: IwbContainer;
                if not Supports(aElement, IwbContainer, lContainer) then
                  Exit;

                var lFaceMorphIndexValue := aElement.NativeValue;
                if not VarIsOrdinal(lFaceMorphIndexValue) then
                  Exit;
                var lFaceMorphIndex: Integer := lFaceMorphIndexValue;

                var lRace := lContainer.ElementLinksTo['...\RNAM'];
                var lRaceMainRecord : IwbMainRecord;
                if not Supports(lRace, IwbMainRecord, lRaceMainRecord) then
                  Exit;

                var lIsFemale := lContainer.ElementExists['...\ACBS\Flags\Female'];
                var lGender := 'Male';
                if lIsFemale then
                  lGender := 'Female';

                var lRaceFaceMorphs := lRaceMainRecord.ElementByPath['Chargen and Skintones\' + lGender + '\Chargen\Face Morph Phenotypes'];

                var lRaceFaceMorphsContainer: IwbContainerElementRef;
                if not Supports(lRaceFaceMorphs, IwbContainerElementRef, lRaceFaceMorphsContainer) then
                  Exit;

                for var lRaceFaceMorphsIdx := 0 to Pred(lRaceFaceMorphsContainer.ElementCount) do begin
                  var lRaceFaceMorph := lRaceFaceMorphsContainer.Elements[lRaceFaceMorphsIdx];

                  var lRaceFaceMorphContainer: IwbContainerElementRef;
                  if not Supports(lRaceFaceMorph, IwbContainerElementRef, lRaceFaceMorphContainer) then
                    Continue;

                  var lMorphIndexValue := lRaceFaceMorphContainer.ElementNativeValues[FMRI];
                  if not VarIsOrdinal(lMorphIndexValue) then
                    Continue;
                  var lMorphIndex: Integer := lMorphIndexValue;

                  if lMorphIndex = lFaceMorphIndex then
                    Exit(lRaceFaceMorph);
                end;
              end)
          .SetRequired,
        wbRArrayS('Morph Groups',
          wbRStructSK([0], 'Morph Group',  [
            wbString(FMRG, 'Morph Group').SetRequired,
            wbFloat(FMRS, 'Blend Intensity').SetRequired
          ], [])
            .SetSummaryMemberPrefixSuffix(0, '[',']')
            .SetSummaryKey([1])
            .IncludeFlag(dfCollapsed)
        )
      ], []).SetSummaryKey([1])
    ),
    wbRArrayS('Morph Groups',
      wbRStructSK( [0], 'Morph Blend', [
        wbString(BMPN, 'Blend Name').SetRequired,
        wbFloat(BMPV, 'Intensity').SetRequired
      ], [])
        .SetSummaryKey([1])
        .IncludeFlag(dfCollapsed)
    ),
    wbATTX,
    wbInteger(STON, 'Skin Tone Index', itU8, wbEnum([
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9'
    ])),
    wbString(HCOL, 'Hair Color'),
    wbString(FHCL, 'Facial Hair Color'),
    wbString(BCOL, 'Eyebrow Color'),
    wbString(ECOL, 'Eye Color'),
    wbString(JCOL, 'Jewelry Color'),
    wbString(TETC, 'Teeth Color'),
    wbInteger(PRON, 'Pronoun', itU8, wbPronounEnum),
    wbStruct(ONA2, 'Race Overrides', [
      wbInteger('Flags', itU32, wbFlags([
        'Size',
        'Movement',
        'Flight',
        'Unarmed Weapon',
        'Flag Overrides',
        'Bleedout',
        'General',
        'Electromagnetic'
      ]))
        .IncludeFlag(dfCollapsed, wbCollapseFlags)
        .SetAfterSet(wbUpdateSameParentUnions),

      wbIsFlag(0, wbStruct('Size', [
        wbInteger('Size', itS8, wbRaceSizeEnum)
          .SetDontShow(wbRaceOverrideDontShow(0))
      ])),

      wbIsFlag(1, wbStruct('Movement Accel/Decel', [
        wbFloat('Acceleration (m)')
          .IncludeFlag(dfFloatSometimesBroken)
          .SetDontShow(wbRaceOverrideDontShow(1)),
        wbFloat('Deceleration (m)')
          .IncludeFlag(dfFloatSometimesBroken)
          .SetDontShow(wbRaceOverrideDontShow(2)),
        wbFloat('Angular Acceleration (deg)')
          .IncludeFlag(dfFloatSometimesBroken)
          .SetDontShow(wbRaceOverrideDontShow(3)),
        wbFloat('Angular Tolerance (deg)')
          .SetDontShow(wbRaceOverrideDontShow(4))
      ])),

      wbIsFlag(2, wbStruct('Flight', [
        wbFloat('Flight Radius').SetDontShow(wbRaceOverrideDontShow(5))
      ])),

      wbIsFlag(3, wbStruct('Unarmed Weapon', [
        wbFloat('Injured Health Pct').SetDontShow(wbRaceOverrideDontShow(7)),
        wbFormIDCk('Unarmed Weapon', [NULL, WEAP])
          .SetDontShow(wbRaceOverrideDontShow(6))
      ])),

      wbIsFlag(4, wbStruct('Flag Overrides', [
        wbInteger('Race Data Flags', itU64, wbRACEDAT2Flags
          .SetDontShowMaskPath('...\Override Active', True))
          .IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbInteger('Override Active', itU64, wbRACEDAT2Flags)
          .IncludeFlag(dfCollapsed, wbCollapseFlags)
      ])),

      wbIsFlag(5, wbStruct('Bleedout Data', [
        wbFloat('Health %').SetDontShow(wbRaceOverrideDontShow(8)),
        wbFloat('Chance').SetDontShow(wbRaceOverrideDontShow(9)),
        wbFloat('Recover Chance').SetDontShow(wbRaceOverrideDontShow(10)),
        wbFloat('Time Min').SetDontShow(wbRaceOverrideDontShow(11)),
        wbFloat('Time Max').SetDontShow(wbRaceOverrideDontShow(12)),
        wbFloat('Health Drain Rate').SetDontShow(wbRaceOverrideDontShow(13))
      ])),

      wbIsFlag(6, wbStruct('General', [
        wbFormIDCk('Impact Material Type', [NULL, MATT])
          .SetDontShow(wbRaceOverrideDontShow(14)),
        wbSoundReference('Sound - Corpse Open').SetDontShow(wbRaceOverrideDontShow(18)),
        wbSoundReference('Sound - Corpse Close').SetDontShow(wbRaceOverrideDontShow(19)),
        wbStruct('OnCripple', [
          wbFormIdCk('Explosion Type', [NULL, EXPL]),
          wbFormIdCk('Generic Debris', [NULL, DEBR]),
          wbFormIdCk('Blood Spurt/Decal Impact', [NULL, IPDS]),
          wbFloat('Debris Scale'),
          wbInteger('Debris Count', itU8),
          wbInteger('Decal Count', itU8)
        ]).SetDontShow(wbRaceOverrideDontShow(22)),
        wbInteger('Active Overrides', itU32, wbFlags([
          {0x00000001} { 0} 'Size',
          {0x00000002} { 1} 'Movement - Acceleration',
          {0x00000004} { 2} 'Movement - Deceleration',
          {0x00000008} { 3} 'Movement - Angular Acceleration',
          {0x00000010} { 4} 'Movement - Angular Tolerance',
          {0x00000020} { 5} 'Flight Radius',
          {0x00000040} { 6} 'Unarmed Weapon - Unarmed Weapon',
          {0x00000080} { 7} 'Unarmed Weapon - Injured Health %',
          {0x00000100} { 8} 'Bleedout - Health %',
          {0x00000200} { 9} 'Bleedout - Chance',
          {0x00000400} {10} 'Bleedout - Recover Chance',
          {0x00000800} {11} 'Bleedout - Time Min',
          {0x00001000} {12} 'Bleedout - Time Max',
          {0x00002000} {13} 'Bleedout - Health Drain Rate',
          {0x00004000} {14} 'Blood Data - Impact Material Type',
          {0x00008000} {15} '',
          {0x00010000} {16} '',
          {0x00020000} {17} '',
          {0x00040000} {18} 'Blood Data - Sound Open Corpse',
          {0x00080000} {19} 'Blood Data - Sound Close Corpse',
          {0x00100000} {20} '',
          {0x00200000} {21} '',
          {0x00400000} {22} 'Blood Data - OnCripple',
          {0x00800000} {23} 'EM - Support Shocked',
          {0x01000000} {24} 'EM - Recover Chance',
          {0x02000000} {25} 'EM - Time Min',
          {0x04000000} {26} 'EM - Time Max',
          {0x08000000} {27} 'EM - Recover Chance on Damage',
          {0x10000000} {28} 'EM - Health Drain Rate',
          {0x20000000} {29} 'EM - Health After Recovery',
          {0x40000000} {30} 'EM - Immunity Duration',
          {0x80000000} {31} ''
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
      ])),

      wbIsFlag(7, wbStruct('Electromagnetic Shocked Data', [
        wbInteger('Support Electromagnetic Shocked', itU8, wbBoolEnum).SetDontShow(wbRaceOverrideDontShow(23)),
        wbFloat('Recover Chance').SetDontShow(wbRaceOverrideDontShow(24)),
        wbFloat('Time Min').SetDontShow(wbRaceOverrideDontShow(25)),
        wbFloat('Time Max').SetDontShow(wbRaceOverrideDontShow(26)),
        wbFloat('Recover Chance On Damage Received').SetDontShow(wbRaceOverrideDontShow(27)),
        wbFloat('Health Drain Rate').SetDontShow(wbRaceOverrideDontShow(28)),
        wbFloat('Health After Recovery').SetDontShow(wbRaceOverrideDontShow(29)),
        wbFloat('Immunity Duration After Recovery').SetDontShow(wbRaceOverrideDontShow(30))
      ]))
    ])
  ]);

  var wbPKDTSpecificFlagsUnused := False;

  var wbPKDTFlags := wbFlags([
    {0x00000001} 'Offers Services',
    {0x00000002} 'Unknown 2',
    {0x00000004} 'Must complete',
    {0x00000008} 'Maintain Speed at Goal',
    {0x00000010} 'Treat As Player Follower',
    {0x00000020} 'After Combat Reset',
    {0x00000040} 'Unlock doors at package start',
    {0x00000080} 'Unlock doors at package end',
    {0x00000100} 'Request Block Idles',
    {0x00000200} 'Continue if PC Near',
    {0x00000400} 'Once per day',
    {0x00000800} 'Low Priority',
    {0x00001000} 'Skip Load Into Furniture',
    {0x00002000} 'Preferred Speed',
    {0x00004000} 'Unknown 15',
    {0x00008000} 'Unknown 16',
    {0x00010000} 'Disable Headtracking',
    {0x00020000} 'Always Sneak',
    {0x00040000} 'Allow Swimming',
    {0x00080000} 'Disable Advanced Traversals',
    {0x00100000} 'Ignore Combat',
    {0x00200000} 'Weapons Unequipped',
    {0x00400000} 'Unknown 23',
    {0x00800000} 'Weapon Drawn',
    {0x01000000} 'Unknown 25',
    {0x02000000} 'Unknown 26',
    {0x04000000} 'Unknown 27',
    {0x08000000} 'No Combat Alert',
    {0x10000000} 'Unknown 29',
    {0x20000000} 'Weapon Drawn: Ready',
    {0x40000000} 'Group Package',
    {0x80000000} 'Weapon Drawn: Alert'
  ]); // CK has no facility to set or view these flags [2, 15, 16, 23, 25, 26, 27, 29] may want to ignore

  var wbPKDTInterruptFlags := wbFlags([
    {0x0001} 'Hellos to player',
    {0x0002} 'Random conversations',
    {0x0004} 'Observe combat behavior',
    {0x0008} 'Greet corpse behavior',
    {0x0010} 'Reaction to player actions',
    {0x0020} 'Friendly fire comments',
    {0x0040} 'Aggro Radius Behavior',
    {0x0080} 'Allow Idle Chatter',
    {0x0100} 'Unknown 9', // CK sets this when flag overriding Chatter Off Important Scene
    {0x0200} 'World Interactions',
    {0x0400} 'Off For Important Scene', // CK sets this when flag override choosing World Interactions
    {0x0800} 'React To Warn',
    {0x1000} 'Unknown 13',
    {0x2000} 'Unknown 14',
    {0x4000} 'Unknown 15',
    {0x8000} 'Unknown 16'
  ]); // // CK has no facility to set or view these flags [13, 14, 15, 16] appears to be garbage data leftover from memory re-use and isn't cleared or read by CK

  var wbBlendOperationEnum: IwbEnumDef;

  var wbTintTemplateGroups :=
  function(const aName: string): IwbSubRecordArrayDef
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

  var wbMorphGroups :=
  function(const aName: string): IwbSubRecordArrayDef
  begin
    Result :=
      wbRArray(aName,
        wbRStruct('Morph Group', [
          wbString(MPGN, 'Name'),
          wbRArray('Morphs', wbString(MPGM, 'Morph'))
          {
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
          }
        ], [])
      );
  end;

  var wbFaceMorphs :=
  function (const aName: string): IwbSubRecordArrayDef
  begin
    Result :=
      wbRArray(aName,
        wbRStruct('Face Morph Phenotype', [
          wbInteger(FMRI, 'Index', itU32),
          wbString(FMRU),
          wbLString(FMRN, 'Name'),
          wbString(FMRS),
          wbRStructs('Unknown', 'Unknown', [
            wbInteger(FMSR, 'Index', itU32),
            wbString(FMRU),
            wbLString(FMRN, 'Name')
          ], [])
        ], []).IncludeFlag(dfAllowAnyMember)
      );
  end;

  wbBlendOperationEnum := wbEnum([
            'Default',
            'Multiply',
            'Overlay',
            'Soft Light',
            'Hard Light'
          ]);

  var wbUNAMs := wbRArray('Data Inputs', wbRStruct('Data Input', [
    wbInteger(UNAM, 'Index', itS8),
    wbString(BNAM, 'Name'),
    wbInteger(PNAM, 'Flags', itU32, wbFlags([
      'Public'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
  ], []));

  {subrecords checked against Starfield.esm}
  wbRecord(PACK, 'Package', [
    wbEDID.SetRequired,
    wbVMADFragmentedPACK,

    wbStruct(PKDT, 'Pack Data', [
      wbInteger('General Flags', itU32, wbPKDTFlags).IncludeFlag(dfCollapsed, wbCollapseFlags),
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
      wbUnused(1),
      wbInteger('Interrupt Flags', itU16, wbPKDTInterruptFlags).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbUnused(2)
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
      wbUnused(3),
      wbInteger('Duration (minutes)', itS32)
    ], cpNormal, True),

    wbCTDAs,

    wbRStruct('Animations', [
      wbInteger(IDLF, 'Flags', itU8, wbEnum([], [
         0, 'Unknown 0',
         8, 'Random',
         9, 'Run in Sequence',
        12, 'Random, Do Once',
        13, 'Run in Sequence, Do Once'
      ]), cpNormal, True),
      wbInteger(IDLC, 'Animation Count', itU32, nil, cpBenign),
      wbFloat(IDLT, 'Idle Timer Setting'),
      wbArray(IDLA, 'Animations', wbFormIDCk('Animation', [IDLE]), 0, nil, wbIDLAsAfterSet)
    ], []),

    wbFormIDCk(CNAM, 'Combat Style', [CSTY]),
    wbFormIDCk(QNAM, 'Owner Quest', [QUST]),
    wbFormIDCk(FLAV, 'Anim Flavor', [KYWD]),
    wbStruct(PKCU, 'Counter', [
      wbInteger('Data Input Count', itU32),
      wbFormIDCk('Package Template', [PACK, NULL]),
      wbInteger('Version Counter (autoincremented)', itU32)
    ], cpNormal, True),

    wbRStruct('Package Data', [
      wbRArray('Data Input Values', wbRStruct('Value', [
        wbString(ANAM, 'Type').SetAfterSet(wbPackageDataInputValueTypeAfterSet),
        wbRUnion('Typed Input Value', [
          wbUnion(CNAM, 'Value', wbPubPackCNAMDecider, [
            {0} wbByteArray(''),
            {1} wbInteger('', itU8, wbBoolEnum),
            {2} wbInteger('', itS32),
            {3} wbFloat('')
          ]).IncludeFlag(dfUnionStaticResolve),
          wbPLDT,
          wbRStruct('Target', [
            wbPTDA,
            wbCITCReq,
            wbCTDAsCount
          ], []),
          wbFormIDCk(STSC, 'Scene', [SCEN]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole)
        ], [])
      ], [], cpNormal, False)),
      wbUNAMs
    ], []),

    wbInteger(XNAM, 'Package Group', itU8, wbEnum([], [ // these are all guesses
         0, 'Sandbox',
         1, 'HoldPosition',
         2, 'Unknown 2',
         3, 'SitLinkedRef',
         4, 'TravelToLinkedRef',
         //5
         6, 'RetreatPackage',
         7, 'Follow NPC',
         8, 'StayAtSelf',
         9, 'Unknown 9',
        10, 'Headtrack',
        11, 'Patrol',
        12, 'Unknown 12', //guard packages, watch the player
        13, 'Unknown 13',
        14, 'HeadtrackPlayer',
        15, 'FleeArea',
        16, 'Unknown 16',
        17, 'FollowPlayer',
        18, 'Unknown 18',
        19, 'Unknown 19',
        20, 'TravelBetweenLandings',
        21, 'SandboxEditorLocation',
        22, 'Ambush',
        23, 'EscortPlayer',
        24, 'Unknown 24',
        25, 'Unknown 25',
        26, 'Unknown 26',
        27, 'SandboxInteriorUnlockDoors',
        28, 'Unknown 28',
        29, 'KeepEyeOn',
        30, 'Sleep',
        31, 'Unknown 31',
        32, 'DefaultPassengerPackage',
        33, 'Unknown 33',
        34, 'UseWeapon',
        35, 'ForceGreetWhileAimWeapon',
        36, 'SandboxWalk',
        37, 'Unknown 37',
        38, 'SandboxAtFoundLocation',
        39, 'ForceGreet 1',
        40, 'ForceGreet 2',
        41, 'SuspiciousPatrol',
        42, 'AmbushAtFoundLocation',
        43, 'Patrol_Creature',
        //44
        45, 'UseMagicAndWait',
        46, 'SleepAtLair',
        //47
        //48
        49, 'AnimTest_Patrol',
        50, 'UseMagicAndWait_NoTravel',
        //51
        //52
        53, 'AnimTest_Sandbox_Package',
        //54
        55, 'ForceGreetPatrolGuard',
        //56
        57, 'PredatorSeekPrey',
        //58
        //59
        60, 'FollowPlayer',
        //61-65
        66, 'RangingWithPlayer',
        67, 'FollowPlayer',
        //68-80
        81, 'DefaultCombatMasterTemplate',
       134, 'Master_ShootTarget',
       145, 'ShootTarget'
    ]), cpNormal, True),
    wbRStruct('Procedure Tree', [
      wbRArray('Branches', wbRStruct('Branch', [
        wbString(ANAM, 'Branch Type'),
        wbString(NNAM, 'Note'),
        wbCITCReq,
        wbCTDAsCount,
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
            wbInteger('Set General Flags', itU32, wbPKDTFlags).IncludeFlag(dfCollapsed, wbCollapseFlags),
            wbInteger('Clear General Flags', itU32, wbPKDTFlags).IncludeFlag(dfCollapsed, wbCollapseFlags),
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
        )
        //wbRArray('Unknown', wbUnknown(PFOR), cpIgnore) not in Starfield.esm
      ], []))
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

  var wbQUSTLocationAliasFlags :=
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      {0x00000001} {00} 'Reserves Location',
      {0x00000002} {01} 'Optional',
      {0x00000004} {02} 'Unknown 2',
      {0x00000008} {03} 'Allow Reuse in Quest',
      {0x00000010} {04} 'Unknown 4',
      {0x00000020} {05} 'Unknown 5',
      {0x00000040} {06} 'Unknown 6',
      {0x00000080} {07} 'Unknown 7',
      {0x00000100} {08} 'Stores Text',
      {0x00000200} {09} 'Allow Reserved',
      {0x00000400} {10} 'Unknown 10',
      {0x00000800} {11} 'Unknown 11',
      {0x00001000} {12} 'Unknown 12',
      {0x00002000} {13} 'Unknown 13',
      {0x00004000} {14} 'Unknown 14',
      {0x00008000} {15} 'Unknown 15',
      {0x00010000} {16} 'Allow Explored',
      {0x00020000} {17} 'Unknown 17',
      {0x00040000} {18} 'Unknown 18',
      {0x00080000} {19} 'Unknown 19',
      {0x00100000} {20} 'External Alias - Linked',
      {0x00200000} {21} 'Unknown 21',
      {0x00400000} {22} 'Unknown 22',
      {0x00800000} {23} 'Discard on shutdown if unused',
      {0x01000000} {24} 'Unknown 24',
      {0x02000000} {25} 'Unknown 25',
      {0x04000000} {26} 'Unknown 26',
      {0x08000000} {27} 'Search Ship Locations',
      {0x10000000} {28} 'Matching Loc - Planets And Systems Only',
      {0x20000000} {29} 'Current Alias System',
      {0x40000000} {30} 'Current Alias Planet',
      {0x80000000} {31} 'Unknown 31'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags);

  var wbQUSTReferenceAliasFlags :=
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      {0x00000001} {00} 'Reserves Reference',
      {0x00000002} {01} 'Optional',
      {0x00000004} {02} 'Quest Object',
      {0x00000008} {03} 'Allow Reuse in Quest',
      {0x00000010} {04} 'Allow Dead',
      {0x00000020} {05} 'Matching Ref - In Loaded Area',
      {0x00000040} {06} 'Essential',
      {0x00000080} {07} 'Allow Disabled',
      {0x00000100} {08} 'Stores Text',
      {0x00000200} {09} 'Allow Reserved',
      {0x00000400} {10} 'Protected',
      {0x00000800} {11} 'Forced by Aliases',
      {0x00001000} {12} 'Allow Destroyed',
      {0x00002000} {13} 'Matching Ref - Closest',
      {0x00004000} {14} 'Uses Stored Text',
      {0x00008000} {15} 'Initially Disabled',
      {0x00010000} {16} 'Unknown 16',
      {0x00020000} {17} 'Clear Names When Removed',
      {0x00040000} {18} 'Matching Ref - Actors Only',
      {0x00080000} {19} 'Create Ref - Temp',
      {0x00100000} {20} 'External Alias - Linked',
      {0x00200000} {21} 'No Pickpocket',
      {0x00400000} {22} 'Can Apply Data To Non-Aliased Refs',
      {0x00800000} {23} 'Is Companion',
      {0x01000000} {24} 'Optional All Scenes',
      {0x02000000} {25} 'Matching Ref - From Crowd',
      {0x04000000} {26} 'Quest Object Cargo',
      {0x08000000} {27} 'Unknown 27',
      {0x10000000} {28} 'Unknown 28',
      {0x20000000} {29} 'Unknown 29',
      {0x40000000} {30} 'Unknown 30',
      {0x80000000} {31} 'Consumable'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags);

(*  var wbQUSTAliasFlags :=
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
      {0x00010000} 'Allow Explored',
      {0x00020000} 'Clear Names When Removed',
      {0x00040000} 'Matching Ref - Actors Only',
      {0x00080000} 'Create Ref - Temp',
      {0x00100000} 'External Alias - Linked',
      {0x00200000} 'No Pickpocket',
      {0x00400000} 'Can Apply Data To Non-Aliased Refs',
      {0x00800000} 'Is Companion/Discard on shutdown if unused',
      {0x01000000} 'Optional All Scenes',
      {0x02000000} 'Matching Ref - From Crowd',
      {0x04000000} 'Quest Object Cargo',
      {0x08000000} 'Search Ship Locations',
      {0x10000000} 'Matching Loc - Planets And Systems Only',
      {0x20000000} 'Current Alias System',
      {0x40000000} 'Current Alias Planet',
      {0x80000000} 'Consumable'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags); *)

  var lReferenceAlias :=
    wbRStructSK([0], 'Reference Alias', [
      wbInteger(ALST, 'Reference Alias ID', itU32, nil, cpNormal, True),
      wbString(ALID, 'Alias Name', 0, cpNormal, True),
//      wbQUSTAliasFlags,
      wbQUSTReferenceAliasFlags,
      wbUnknown(ALFG,4).SetDefaultEditValue('00 00 00 00').SetRequired,

      wbInteger(ALLR, 'Legendary Rank', itU8, wbEnum([], [
        $0001, '1',
        $0002, '2',
        $0003, '3'
      ])).SetDefaultNativeValue(1),
      wbInteger(ALFI, 'Force Into Alias When Filled', itS32, wbQuestAliasToStr, wbStrToAlias)
        .SetLinksToCallbackOnValue(wbSameQuestAliasLinksTo),

      wbRUnion('Alias Type', [
      {0} wbRStruct('Closest To Alias', [
            wbInteger(ALCC, 'Closest To Alias', itS32, wbQuestAliasToStr, wbStrToAlias)
              .SetLinksToCallbackOnValue(wbSameQuestAliasLinksTo)
          ], []),
      {1} wbRStruct('Forced Reference', [
            wbFormIDCk(ALFR, 'Forced Reference', [REFR, ACHR, PLYR])
          ], []),
      {2} wbRStruct('Location Alias Reference', [
            wbInteger(ALFA, 'Alias', itS32, wbQuestAliasToStr, wbStrToAlias)
              .SetLinksToCallbackOnValue(wbSameQuestAliasLinksTo),
            wbFormIDCk(KNAM, 'Keyword', [KYWD]),
            wbFormIDCk(ALRT, 'Ref Type', [LCRT]).SetRequired
          ], []),
      {3} wbRStruct('Find Matching Reference From Event', [
            wbInteger(ALFE, 'From Event', itU32, wbQuestEventEnum),
            wbInteger(ALFD, 'Event Data', itU32, wbEventMemberEnum).SetRequired
          ], []),
      {4} wbRStruct('Create Reference to Object', [
            wbFormIDCk(ALCO, 'Object', [ACTI,ARMO,BOOK,CELL,CONT,DOOR,FLOR,FURN,GBFM,IDLM,KEYM,LVLI,LVSC,MISC,NPC_,PKIN,SOUN,STAT,WEAP]), // yee haw
            wbStruct(ALCA, 'Alias', [
              wbInteger('Alias', itS16, wbQuestAliasToStr, wbStrToAlias)
                .SetLinksToCallback(wbSameQuestAliasLinksTo),
              wbInteger('Create', itU16, wbEnum([] ,[
                $0000, 'At',
                $8000, 'In'
              ]))
            ]).SetRequired,
            wbInteger(ALCL, 'Level', itU32, wbEnum([
              'Easy',
              'Medium',
              'Hard',
              'Very Hard',
              'None'
            ])).SetRequired
          ], []),
      {5} wbRStruct('External Alias Reference', [
            wbFormIDCk(ALEQ, 'Quest', [QUST]),
            wbInteger(ALEA, 'Alias', itS32, wbQuestExternalAliasToStr, wbStrToAlias)
              .SetLinksToCallbackOnValue(wbQuestAliasExternalAliasLinksTo)
              .SetRequired
          ], []),
      {6} wbRStruct('Unique Actor', [
            wbFormIDCk(ALUA, 'Unique Actor', [NPC_])
          ], []),
      {6} wbRStruct('Unique Base Form', [
            wbFormIDCk(ALUB, 'Unique Base Form', [GBFM])
          ], []),
      {7} wbRStruct('Find Matching Reference Near Alias', [
            wbInteger(ALNA, 'Alias', itS32, wbQuestAliasToStr, wbStrToAlias)
              .SetLinksToCallbackOnValue(wbSameQuestAliasLinksTo),
            wbInteger(ALNT, 'Type', itU32, wbEnum([
              'Linked Form',
              'Linked Ref',
              'Linked Interior Cell',
              'Linked Exterior Cell',
              'Same Module'
            ])).SetRequired,
            wbFormIDCk(ALNR, 'Ref Type', [LCRT, NULL])
          ], []),
      {8} wbRStruct('Ref Collection', [
            wbInteger(ALCS, 'Ref Collection', itS32, wbQuestAliasToStr, wbStrToAlias)
          ], []),
      {9} wbRStruct('Create Object Template', [
            wbInteger(ALCM, 'Template Alias', itS32, wbQuestAliasToStr, wbStrToAlias)
              .SetLinksToCallbackOnValue(wbSameQuestAliasLinksTo),
            wbInteger(ALCA, 'Target Override Alias', itS32, wbQuestAliasToStr, wbStrToAlias)
              .SetLinksToCallbackOnValue(wbSameQuestAliasLinksTo)
          ], [])
      ], []).IncludeFlag(dfMustBeUnion),

      wbCTDAs,
      wbKeywords,
      wbContainerItems,

      wbFormIDCk(SPOR, 'Spectator override package list', [FLST], False, cpNormal, False),
      wbFormIDCk(OCOR, 'Observe dead body override package list', [FLST], False, cpNormal, False),
      wbFormIDCk(GWOR, 'Guard warn override package list', [FLST], False, cpNormal, False),
      wbFormIDCk(ECOR, 'Combat override package list', [FLST], False, cpNormal, False),

      wbArray(ALLA, 'Linked Aliases', wbStruct('Linked Alias', [
        wbFormIDCk('Keyword', [KYWD, NULL]),
        wbInteger('Alias', itS32, wbQuestAliasToStr, wbStrToAlias)
          .SetLinksToCallback(wbSameQuestAliasLinksTo)
      ])),
      wbFormIDCk(ALDN, 'Display Name', [MESG]),
      wbFormIDCk(ALDI, 'Death Item', [LVLI]),
      wbFormIDCk(ALFV, 'Forced Voice', [VTYP]),
      wbRArrayS('Alias Spells', wbFormIDCk(ALSP, 'Spell', [SPEL])),
      wbRArrayS('Alias Factions', wbFormIDCk(ALFC, 'Faction', [FACT])),
      wbRArray('Alias Package Data', wbFormIDCk(ALPC, 'Package', [PACK])),
      wbString(SCCM, 'Script Comment'),
      wbFormIDCk(VTCK, 'Voice Types', [NPC_, FACT, FLST, VTYP, NULL]).SetRequired,
      wbRArrayS('Alias Terminals', wbFormIDCk(ALTM, 'Terminal Menu', [TMLM])),
      wbEmpty(ALED, 'Alias End Marker', cpNormal, True)
    ], [], cpNormal, False, nil, False, nil, wbContainerAfterSet)
      .SetSummaryKey([0, 1])
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryNoSortKey)
      .IncludeFlag(dfSummaryMembersNoName);

  var lLocationAlias :=
    wbRStructSK([0], 'Location Alias', [
      wbInteger(ALLS, 'Location Alias ID', itU32),
      wbString(ALID, 'Alias Name'),
//      wbQUSTAliasFlags,
      wbQUSTLocationAliasFlags,
      wbUnknown(ALFG, 4),

      wbInteger(ALFI, 'Force Into Alias When Filled', itS32, wbQuestAliasToStr, wbStrToAlias)
        .SetLinksToCallbackOnValue(wbSameQuestAliasLinksTo),

      wbRUnion('Alias Type', [
      {1} wbRStruct('Specific Location', [
            wbFormIDCk(ALFL, 'Specific Location', [LCTN])
          ], []),
      {2} wbRStruct('Reference Alias Location', [
            wbInteger(ALFA, 'Alias', itS32, wbQuestAliasToStr, wbStrToAlias)
              .SetLinksToCallbackOnValue(wbSameQuestAliasLinksTo),
            wbFormIDCk(KNAM, 'Keyword', [KYWD])
          ], []),
      {3} wbRStruct('Find Matching Location From Event', [
            wbInteger(ALFE, 'From Event', itU32, wbQuestEventEnum),
            wbInteger(ALFD, 'Event Data', itU32, wbEventMemberEnum)
          ], []),
      {5} wbRStruct('External Alias Location', [
            wbFormIDCk(ALEQ, 'Quest', [QUST]),
            wbInteger(ALEA, 'Alias', itS32, wbQuestExternalAliasToStr, wbStrToAlias)
              .SetLinksToCallbackOnValue(wbQuestAliasExternalAliasLinksTo)
          ], [])
      ], []).IncludeFlag(dfMustBeUnion),

      wbCTDAs,

      wbRStruct('Unknown', [
        wbMarkerReq(ALPS),
        wbCTDAs,
        wbFormIDCk(LNAM, 'PCM Type Keyword', [KYWD])
      ], []),

      wbInteger(ALCC, 'Closest To Alias', itS32, wbQuestAliasToStr, wbStrToAlias)
        .SetLinksToCallbackOnValue(wbSameQuestAliasLinksTo),

      wbInteger(ALSY, 'Current Alias System ID', itS32, wbQuestAliasToStr, wbStrToAlias)
              .SetLinksToCallbackOnValue(wbSameQuestAliasLinksTo),

      wbInteger(ALPN, 'Current Alias Planet ID', itS32, wbQuestAliasToStr, wbStrToAlias)
              .SetLinksToCallbackOnValue(wbSameQuestAliasLinksTo),

      wbFormIDCk(ALKF, 'Location Type Keyword', [KYWD]),
      wbFormIDCk(ALDN, 'Display Name', [MESG]),

      wbEmpty(ALED, 'Alias End Marker', cpNormal, True)
    ], [])
      .SetSummaryKey([0, 1])
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryNoSortKey)
      .IncludeFlag(dfSummaryMembersNoName);

  var lRefCollectionAlias :=
    wbRStructSK([0], 'Collection Alias', [
      wbInteger(ALCS, 'Collection Alias ID', itU32),
      wbInteger(ALMI, 'Max Initial Fill Count', itU8).SetRequired,
      wbUnknown(ALAM, 4).SetDefaultEditValue('00 00 00 00').SetRequired,
      wbRUnion('Reference Alias or Alias End Marker', [
        wbRStruct('Alias End Marker', [
          wbEmpty(ALED, 'Alias End Marker', cpNormal, True)
        ], []),
        lReferenceAlias
      ], [], cpNormal, True)
    ], []);

  {subrecords checked against Starfield.esm}
  wbRecord(QUST, 'Quest',
    wbFlags(wbFlagsList([
      {0x00004000} 14, 'Partial Form'
    ]), [14]), [
    wbEDID,
    wbVMADFragmentedQUST,
    wbFULL,
    wbBaseFormComponents,
    wbStruct(DNAM, 'General', [
      wbInteger('Flags', itU32, wbFlags([
        {0x000001} 'Start Game Enabled',
        {0x000002} 'Completed',
        {0x000004} 'Add Idle topic to Hello',
        {0x000008} 'Allow repeated stages',
        {0x000010} 'Starts Enabled',
        {0x000020} 'Displayed In HUD',
        {0x000040} 'Failed',
        {0x000080} 'Stage Wait',
        {0x000100} 'Run Once',
        {0x000200} 'Exclude from dialogue export',
        {0x000400} 'Warn on alias fill failure',
        {0x000800} 'Active',
        {0x001000} 'Repeats Conditions',
        {0x002000} 'Keep Instance',
        {0x004000} 'Want Dormant',
        {0x008000} 'Has Dialogue Data',
        {0x010000} 'Unknown 16',
        {0x020000} 'Unknown 17',
        {0x040000} 'Ship Dialogue Only',
        {0x080000} 'Can Be Rejected',
        {0x100000} 'Audio Log Only',
        {0x200000} 'Don''t Stop Interrupt Packages On Alias Fill',
        {0x400000} 'Don''t Dump Old Location Event Parameter'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbInteger('Priority', itU8),
      wbUnused(3),
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
    ]),
    wbFormIDCk(QTYP, 'Quest Type', [KYWD]),
    wbFormIDCk(FTYP, 'Quest Faction', [KYWD]), // was FACT but now separate from FACT
    wbInteger(ENAM, 'Event', itU32, wbQuestEventTypeEnum),
    wbFormIDCk(LNAM, 'Location', [LCTN]),
    wbFormIDCk(QTLM, 'Quest Time Limit', [GLOB]),
    wbFormIDCk(QSRC, 'Source Quest', [QUST]),
    wbRArray('Text Display Globals', wbFormIDCk(QTGL, 'Global', [GLOB])),
    wbFLTR,
    wbString(NAM3, 'Summary'),
    wbRStruct('Quest Dialogue Conditions', [wbCTDAs], [], cpNormal, False),
    wbMarkerReq(NEXT),
    wbRStruct('Story Manager Conditions', [wbCTDAs], [], cpNormal, False),
    wbRArrayS('Stages', wbRStructSK([0], 'Stage', [
      wbStructSK(INDX, [0], 'Stage Index', [
        wbInteger('Stage Index', itU16),
        wbInteger('Flags', itU8, wbFlags([
          {0x01} '',
          {0x02} 'Run On Start',
          {0x04} 'Run On Stop',
          {0x08} 'Keep Instance Data From Here On',
          {0x10} 'Run On Timer End',
          {0x20} 'Start Quest Timer',
          {0x40} 'Ready To Display On UI'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbUnused(1)
      ]),
      wbRArray('Log Entries', wbRStruct('Log Entry', [
        wbInteger(QSDT, 'Stage Flags', itU8, wbFlags([
          {0x01} 'Complete Quest',
          {0x02} 'Fail Quest'
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbCTDAs,
        wbString(NAM2, 'Note'),
        wbString(SCFC, 'Script Flag Comment'),
        wbLStringKC(CNAM, 'Log Entry', 0, cpTranslate),
        wbRStruct('Stage Complete Data', [
          wbRStruct('Reward Data', [
          wbInteger(QSRD, 'Count', itU32, nil, cpNormal, True),
          wbRArray('Rewards', wbRStruct('Reward', [
            wbFormIDCk(QRXP, 'XP', [NULL, GLOB], False, cpNormal, True),
            wbFormIDCk(QRCR, 'Currency', [NULL, GLOB], False, cpNormal, True),
            wbRArray('Items', wbStruct(QRRD, 'Item', [
              wbFormIDCk('Item', sigBaseObjects, False, cpNormal, True),
              wbInteger('Count', itU32)
            ])),
            wbCTDAs
          ], [])).SetCountPath(QSRD),
          wbEmpty(QSRD, 'End Marker', cpNormal, True)
          ], []),
          wbFormIDCk(NAM1, 'Affinity Change', [AFFE, NULL])
        ], [], cpNormal, True)
      ], []))
    ], [])),
    wbRArray('Objectives', wbRStruct('Objective', [
      wbInteger(QOBJ, 'Objective Index', itU16),
      wbInteger(FNAM, 'Flags', itU32, wbFlags([
        {0x01} 'ORed With Previous',
        {0x02} 'No Stats Tracking'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbLStringKC(NNAM, 'Display Text', 0, cpTranslate, True),
      wbRArray('Targets', wbRStruct('Target', [
        wbStruct(QSTA, 'Target', [
          wbInteger('Alias', itS32, wbQuestAliasToStr, wbStrToAlias),
          wbInteger('Flags', itU32, wbFlags([
            {0x01} 'Compass Marker Ignores Locks',
            {0x02} 'Hostile',
            {0x04} 'Use Straight Line Pathing'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
          wbFromVersion(82, wbFormIDCk('Keyword', [KYWD, NULL]))
        ]),
        wbCTDAs
      ], []))
    ], [])
      .SetSummaryKey([0, 2])
      .SetSummaryMemberPrefixSuffix(0, '[', ']')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryMembersNoName)),

    wbInteger(ANAM, 'Next Alias ID', itU32, nil, cpNormal, True),

    wbRArray('Aliases',
      wbRUnion('Alias', [
        lReferenceAlias,
        lLocationAlias,
        lRefCollectionAlias
      ], [])
    ),

//    wbString(NNAM, 'Description', 0, cpTranslate, False),
    wbFormIDCk(GNAM, 'Quest Group', [KYWD]),
    wbString(SNAM, 'SWF File'),

    wbRStruct('Mission Board Info', [
      wbFormIDCk(QMTY, 'Mission Type Keyword', [KYWD, NULL]),
      wbLStringKC(QMSU, 'Mission Summary', 0, cpTranslate),
      wbRArray('Details', wbRStruct('Detail Item', [
        wbLStringKC(QMDT, 'Title', 0, cpTranslate),
        wbLStringKC(QMDP, 'Primary', 0, cpTranslate),
        wbLStringKC(QMDS, 'Secondary', 0, cpTranslate)
      ], []), 6),
      wbKeywords
    ], []),

    wbString(SCCM, 'Script Comment')
  ]);

  var wbRACEDAT2UnknownStruct :=
    wbStruct('Unknown', [
      wbUnknown(1),
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbUnknown(4),
      wbFloat,
      wbFloat
    ]);

  {subrecords checked against Starfield.esm}
  wbRecord(RACE, 'Race',
    wbFlags(wbFlagsList([
      {0x00080000} 19, 'Unknown 19'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbFULL,
    wbDESCReq(),
    wbSPLOs,
    wbFormIDCk(WNAM, 'Skin', [ARMO, NULL]),
    wbBO64,
    wbKeywords,
    wbPRPS,
    wbAPPR,
    wbFormIDCk(GNAM, 'Body Part Data', [BPTD]),
    wbStruct(DAT2, 'Data', [
      {  0} wbFloat('Male Height'),                                             // +0x60
      {  4} wbFloat('Female Height'),                                           // +0x64
            wbStruct('Male Default Weight', [
      {  8}   wbFloat('Thin'),                                                  // +0x68
      { 12}   wbFloat('Muscular'),                                              // +0x6C
      { 16}   wbFloat('Fat')                                                    // +0x70
            ]),
            wbStruct('Female Default Weight', [
      { 20}   wbFloat('Thin'),                                                  // +0x74
      { 24}   wbFloat('Muscular'),                                              // +0x78
      { 28}   wbFloat('Fat')                                                    // +0x7C
            ]),
      { 32} wbInteger('Flags', itU64, wbRACEDAT2Flags).IncludeFlag(dfCollapsed, wbCollapseFlags),                         // +0x80
      { 40} wbFloat('Acceleration Rate'),                                       // +0x04
      { 44} wbFloat('Deceleration Rate'),                                       // +0x08
      { 48} wbRACEDAT2Size(),                                                   // +0x00
      { 52} wbInteger('Head Biped Object', itS32, wbBipedObjectEnum),           // +0x88
      { 56} wbInteger('Hair Biped Object', itS32, wbBipedObjectEnum),           // +0x8C
      { 60} wbFloat('Injured Health Pct'),                                      // +0x20 must have to do with unarmed weapon
      { 64} wbInteger('Shield Biped Object', itS32, wbBipedObjectEnum),         // +0x94
      { 68} wbInteger('Beard Biped Object', itS32, wbBipedObjectEnum),          // +0x90
      { 72} wbInteger('Body Biped Object', itS32, wbBipedObjectEnum),           // +0x98
      { 76} wbFloat('Aim Angle Tolerance'),                                     // +0x9C
      { 80} wbFloat('Flight Radius'),                                           // +0x14
      { 84} wbFloat('Angular Acceleration Rate'),                               // +0x0C
      { 88} wbFloat('Angular Tolerance'),                                       // +0x10
      { 92} wbUnknown(4),                                                       // +0xA0
      { 96} wbUnknown(4),                                                       // +0xA4
      {100} wbUnknown(4),                                                       // +0xA8
      {104} wbUnknown(4),                                                       // +0xAC
      {108} wbUnknown(4),                                                       // +0xB0
      {112} wbUnknown(4),                                                       // +0xB4
      {116} wbUnknown(4),                                                       // +0xB8
      {120} wbFloat,                                                            // +0xBC
      {124} wbUnknown(4),                                                       // +0xC0
      {128} wbInteger('Pipboy Biped Object', itS32, wbBipedObjectEnum),         // +0xC4
      {132} wbInteger('XP Value', itS16),                                       // +0xC8
            wbStruct('OnCripple', [
      {134}   wbFloat('Debris Scale'),                                          // +0xE8
      {138}   wbInteger('Debris Count', itU8),                                  // +0xEC
      {139}   wbInteger('Decal Count', itU8),                                   // +0xED
      {140}   wbFormIDCk('Explosion', [NULL, EXPL]),                            // +0xD0  expected to be EXPL
      {144}   wbFormIDCk('Debris', [NULL, DEBR]),                               // +0xD8  expected to be DEBR
      {148}   wbFormIDCk('Impact Data Set', [NULL, IPDS])                       // +0xE0  expected to be IPDS
            ]),
      {152} wbFloat('Orientation Limits - Pitch'),                              // +0xF0
      {156} wbFloat('Orientation Limits - Roll'),                               // +0xF4
            wbStruct('Bleedout', [
      {160}   wbFloat('Health %'),                                              // +0x28
      {164}   wbFloat('Chance'),                                                // +0x2C
      {168}   wbFloat('Recover Chance'),                                        // +0x30
      {172}   wbFloat('Time Min'),                                              // +0x34
      {176}   wbFloat('Time Max'),                                              // +0x38
      {180}   wbFloat('Health Drain Rate')                                      // +0x3C
            ]),
      {184} wbRACEDAT2Size('Max Size'),                                         // +0xF8
      {188} wbInteger('Intelligence Level', itU32, wbEnum([                     // +0x24
              'None',
              'Moderate',
              'Normal',
              'High'
            ])),
      {192} wbStruct('Electromagnetic Shocked', [                               // Same as NPC_ -> ONA2 - Unknown 7
      {192}   wbInteger('Support EM Shock', itU8, wbBoolEnum),                  // +0x5C
      {193}   wbFloat('Recover Chance'),                                        // +0x40
      {197}   wbFloat('Time Min'),                                              // +0x44
      {201}   wbFloat('Time Max'),                                              // +0x48
      {205}   wbFloat('Recover Chance On Damage Received'),                     // +0x4C
      {209}   wbFloat('Health Drain Rate'),                                     // +0x50
      {213}   wbFloat('Health After Recovery'),                                 // +0x54
      {217}   wbFloat('Immunity Duration After Recovery')                       // +0x58
      {221} ])
    ]),
    (*
      Likely related data to the "unknowns" above.
      Though not exposed in CK and appear to be unused in game.

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
    *)

    wbRStruct('Skeleton Data', [
      wbRStruct('Male Data', [
        wbEmpty(MNAM, 'Male Marker').SetRequired,
        wbString(ANAM, 'Skeletal Model'),
        wbFLLD,
        wbString(NAM5, 'Skeleton Rig'),
        wbString(NAM6, 'Animation Root'),
        wbString(DNAM, 'Animations')
      ], [], cpNormal, True),

      wbRStruct('Female Data', [
        wbEmpty(FNAM, 'Female Marker').SetRequired,
        wbString(ANAM, 'Skeletal Model'),
        wbFLLD,
        wbString(NAM5, 'Skeleton Rig'),
        wbString(NAM6, 'Animation Root'),
        wbString(DNAM, 'Animations')
      ], [], cpNormal, True)
    ], [], cpNormal, True),

    wbRArrayS('Movement Type Names', wbString(MTNM, 'Name', 4)),
    wbArray(VTCK, 'Voices', wbFormIDCk('Voice', [VTYP]), ['Male', 'Female'], cpNormal, True),

    wbFloat(PNAM, 'FaceGen - Main clamp', cpNormal, True),
    wbFloat(UNAM, 'FaceGen - Face clamp', cpNormal, True),

    wbRArrayS('Attacks', wbAttackData),

    wbRStruct('Junk Data', [
      wbMarkerReq(NAM1, cpIgnore),
      wbRStruct('Male Body Data', [
        wbMarkerReq(MNAM, cpIgnore),
        wbInteger(INDX, 'Unknown', itU32).SetDefaultNativeValue(0).SetRequired,
        wbUnknown(FLLD, 4).SetDefaultEditValue('01 00 00 00').SetRequired
      ], [], cpIgnore, True),
      wbRStruct('Female', [
        wbMarkerReq(FNAM, cpIgnore),
        wbInteger(INDX, 'Unknown', itU32).SetDefaultNativeValue(0).SetRequired,
        wbUnknown(FLLD, 4).SetDefaultEditValue('01 00 00 00').SetRequired
      ], [], cpIgnore, True)
    ], [], cpIgnore, True).IncludeFlag(dfCollapsed),

    wbFormIDCk(ENAM, 'Aim Assist Pose Data', [AAPD]),
    wbMarkerReq(NAM3),
    wbFormIDCk(NAM4, 'Impact Material Type', [MATT]),

    wbRStruct('Sounds made when looted', [
      wbSoundReference(WED0, 'Open Corpse'),
      wbSoundReference(WED1, 'Close Corpse')
    ], []),

    wbRArray('Biped Object Names', wbString(NAME, 'Name'), 64).IncludeFlag(dfNotAlignable),
    wbArray(RBPC, 'Biped Object Conditions', wbFormIDCk('Condition', [AVIF, NULL]), 64).IncludeFlag(dfNotAlignable),

    wbRArrayS('Movement Data Overrides', wbRStructSK([0], 'Override', [
      wbFormIDCk(MTYP, 'Movement Type', [MOVT]),
      wbSPED
    ], [])),
    wbInteger(VNAM, 'Equipment Flags', itU32, wbEquipType).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbRArray('Equip Slots', wbRStructSK([0], 'Equip Slot', [ //CAN NOT BE SORTED!!!!
        wbFormIDCk(QNAM, 'Equip Slot', [EQUP]),
        wbString(ZNAM, 'Node')
      ], [])
      .SetSummaryKey([1, 0])
      .SetSummaryDelimiter(' = ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfSummaryNoSortKey)
      .IncludeFlag(dfCollapsed, wbCollapseEquipSlots)
    ),
    wbFormIDCk(UNWP, 'Unarmed Weapon', [WEAP]),

    wbFormIDCk(WKMV, 'Base Movement Defaults - Default', [MOVT]),
    wbFormIDCk(SWMV, 'Base Movement Defaults - Swim', [MOVT]),
    wbFormIDCk(FLMV, 'Base Movement Defaults - Fly', [MOVT]),
    wbFormIDCk(SNMV, 'Base Movement Defaults - Sneak', [MOVT]),

    wbRStruct('Chargen and Skintones', [
      wbRStruct('Male', [
        wbMarkerReq(MNAM),
        wbRStruct('Chargen', [
          wbMarkerReq(NAM0),
          wbUnknown(NNAM, 12),
          wbRArray('Race Presets', wbFormIDCk(RPRM, 'Preset NPC', [NPC_, NULL])),
          wbMorphGroups('Morph Groups'),
          wbFaceMorphs('Face Morph Phenotypes'),
          wbString(FDDS, 'Skin Tone AVMS Subtype'),
          wbRStructs('Face Dials', 'Face Dial', [
            wbInteger(FDSI, 'Skin Index', itU32),
            wbLString(FDSL, 'Label', 0, cpTranslate)
          ], [])
        ], []),
        wbString(BSTT, 'Body Skin Tones'),
        wbString(HSTT, 'Hand Skin Tones'),
        wbString(FCTP, 'Face Custom Textures Base Path'),
        wbString(FSTT, 'Face Skin Tones')
      ], [], cpNormal, True),
      wbRStruct('Female', [
        wbMarkerReq(FNAM),
        wbRStruct('Chargen', [
          wbMarkerReq(NAM0),
          wbUnknown(NNAM, 12),
          wbRArray('Race Presets', wbFormIDCk(RPRF, 'Preset NPC', [NPC_, NULL])),
          wbMorphGroups('Morph Groups'),
          wbFaceMorphs('Face Morph Phenotypes'),
          wbString(FDDS, 'Skin Tone AVMS Subtype'),
          wbRStructs('Face Dials', 'Face Dial', [
            wbInteger(FDSI, 'Skin Index', itU32),
            wbLString(FDSL, 'Label', 0, cpTranslate)
          ], [])
        ], []),
        wbString(BSTT, 'Body Skin Tones'),
        wbString(HSTT, 'Hand Skin Tones'),
        wbString(FCTP, 'Face Custom Textures Base Path'),
        wbString(FSTT, 'Face Skin Tones')
      ], [], cpNormal, True)
    ], []),

    wbFormIDCk(NAM8, 'Morph Race', [RACE]),
    wbFormIDCk(RNAM, 'Armor Race', [RACE]),

    wbFormIDCk(SRAC, 'Subgraph Template Race', [RACE]),

    wbRArray('Subgraph Data',
      wbRStruct('Data', [
        wbFormIDCk(SADD, 'Race', [RACE]),
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
            {3} 'Linking Only',
            {4} 'Pipboy',
            {5} 'MT Generation',
            {6} 'Weapon Generation',
            {7} 'Furniture Generation'
          ])),
          wbInteger('Perspective', itU16, wbEnum([
            '3rd',
            '1st'
          ]))
        ], cpNormal, True)
        .SetSummaryKeyOnValue([0, 1])
        .IncludeFlag(dfTerminator)
      ], [], cpNormal, False, nil, True)
      .IncludeFlag(dfAllowAnyMember)
    ),

    wbFloat(PTOP, 'Idle Chatter Time Min'),
    wbFloat(NTOP, 'Idle Chatter Time Max'),

    wbFormIDCk(QSTI, 'Dialogue Quest', [QUST]),

    wbRStruct('Head Parts and Bone Modifiers', [
      wbRStruct('Male Data', [
        wbEmpty(MNAM, 'Male Data Marker'),
        wbRStructs('Head Parts', 'Head Part', [
          wbInteger(INDX, 'Index', itU32),
          wbFormIDCk(HEAD, 'Part', [HDPT] ).SetRequired
        ], []),
        wbRArray('Bone Modifiers', wbFormIDCk(BNAM, 'Bone Modifier', [BMOD]))
      ], [], cpNormal, True),
      wbRStruct('Female Data', [
        wbEmpty(FNAM, 'Female Data Marker', cpNormal, True),
        wbRStructs('Head Parts', 'Head Part', [
          wbInteger(INDX, 'Index', itU32),
          wbFormIDCk(HEAD, 'Part', [HDPT] ).SetRequired
        ], []),
        wbRArray('Bone Modifiers', wbFormIDCk(BNAM, 'Bone Modifier', [BMOD]))
      ], [], cpNormal, True)
    ], []),

    wbRStructs('Mannequin Skin Swaps', 'Gender Selection', [
      wbInteger(MSSS, 'Gender', itU32, wbEnum([
        'Male',
        'Female'
      ])),
      wbRStructs('Skin Swaps', 'Swap Entry', [
        wbInteger(MSSI, 'Skin Swap Index', itU32, wbEnum([
          'Body',
          'Hands'
        ])),
        wbFormIDCk(MSSA, 'Material Swap', [LMSW]).SetRequired
      ], [])
    ], []),

    wbLString(SNAM, 'Plural Name', 0, cpTranslate)

  ]);

  {subrecords checked against Starfield.esm}
  wbRefRecord(ACHR, 'Placed NPC',
    wbFlags(wbFlagsList([ {not checked for Starfield}
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

    wbXLCM,

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

    wbFloat(XRDS, 'Radius'),

    wbXRGD,

    wbFormIDCk(XRFG, 'Reference Group', [RFGP]),

    wbXPCS,

    wbFormIDCk(XLCN, 'Persist Location', [LCTN]),

    wbFormIDCk(XLRL, 'Location Reference', [LCTN]),

    wbEmpty(XIS2, 'Ignored by Sandbox'),

    wbXRNK,

    wbXPLKs,

    wbLinkedReferences,

    //wbInteger(XCNT, 'Count', itS32),

    wbXEED,

    {--- Ownership ---}
    wbXOWN,

    wbFormIDCk(XEZN, 'Location Override', [LCTN]),

    wbFormIDCk(XLYR, 'Layer', [LAYR]),

    wbFloat(XHTW, 'Head-Tracking Weight'),

    wbFloat(XFVC, 'Favor Cost'),

    wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),

    wbXRGB,

    wbInteger(XHLT, 'Health %', itU32),

    {--- Enable Parent ---}
    wbXESP,

    wbEmpty(XATP, 'Activation Point'),

    wbXSCL,
    wbDATAPosRot,
    wbString(MNAM, 'Comments')
  ], True, wbPlacedAddInfo);

  var TES4: TwbSignature := 'TES4';

  {subrecords checked against Starfield.esm}
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
      {0x00000080}  7, 'Turn Off Fire',
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
      {0x00000080}  7, 'Turn Off Fire',
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
      {0x00000080}  7, 'Turn Off Fire',
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
      {0x00000080}  7, 'Turn Off Fire',
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
      {0x00000080}  7, 'Turn Off Fire',
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
    wbXALG,
    wbBaseFormComponents,
    wbFormIDCk(NAME, 'Base', sigBaseObjects, False, cpNormal, True),

    wbStruct(XVL2, 'Volume Data', [
      { 0} wbUnknown(8),
      { 8} wbFormIDCk('Unknown', [NULL, IMGS]),
      {12} wbFormIDCk('Unknown', [NULL, FOGV]),
      {16} wbUnknown(4),
      {20} wbFloat,
      {24} wbFloat,
      {28} wbFloat,
      {32} wbFloat,
      {36} wbUnknown(4),
      {40} wbFloat,
      {44} wbFloat,
      {48} wbFloat,
      {52} wbUnknown(4),
      {56} wbFloat,
      {60} wbFloat,
      {64} wbFloat,
      {68} wbFloat,
      {72} wbFloat,
      {76} wbFloat,
      {80} wbUnknown(1),
      {81} wbFloat
    ]),

    wbXALD,

    wbStruct(XSAD, 'Ship Arrival', [
      wbFormIDCk('Target', sigReferences),
      wbInteger('Location', itU32, wbEnum([
        'Editor Location',
        'Target - Above',
        'Target - Below',
        'Target - Behind',
        'Target - Front',
        'Target - Left',
        'Target - Right'
      ])),
      wbFloat('Distance (m)'),
      wbFloat('Delay (s)'),
      wbInteger('GravJump FX', itU8, wbBoolEnum)
    ]),

    wbXLCM,

    wbActionFlag,

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
        'Ellipsoid',
        '',
        'Unknown 7'
      ]))
    ]),

    wbStruct(XVOI, 'Volume Reflection Probe Offset Intensity', [
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat
    ]),

    {--- Debug Text ---}
    wbRStruct('Debug Text', [
      wbString(XDTS, 'String'),
      wbStruct(XDTF, 'Format', [
        wbByteRGBA,
        wbInteger('Size', itU32)
      ]).SetRequired
    ], []),

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),
    wbStruct(XLIG, 'Light Data', [
      wbFloat('FOV 90+/-'),             // 1st float value changes designation of meaning based on BASE light type Omnidirection/Spotlight
      wbFloat('Luminous Scale'),
      wbFloat('End Distance Cap'),
      wbFloat('Near Clip/Cut On'),
      wbFloat('Inner FOV'),             // 5th float value changes designation of meaning based on BASE light type Omnidirection/Spotlight
      wbFloat('Shadow Offset'),
      wbUnknown(4),
      wbUnknown(4)
    ], cpNormal, False, nil, 4),

    wbFloat(XRDS, 'Radius'),

    wbRArray('Water Current Data',
      wbRStruct('Current', [
        wbRUnion('', [
          wbFormIDCk(XCZR, 'Reference', [REFR]),
          wbFormIDCk(XCZC, 'Cell', [CELL])
        ], []),
        wbUnknown(XCZA)
      ], [])
    ),
    wbRStruct('Water Current Velocities', [
      wbInteger(XWCN, 'Velocity Count', itU32, nil, cpBenign),
      wbArray(XWCU, 'Velocities',
        wbStruct('Current', [
          wbVec3('Velocity'),
          wbInteger('Unknown', itU32)
        ])
      ).SetCountPathOnValue(XWCN, False)
    ], []),

    wbRArray('Patrol', wbRStruct('Data', [
      wbFloat(XPRD, 'Idle Time', cpNormal, True),
      wbEmpty(XPPA, 'Patrol Script Marker', cpNormal, True),
      wbFormIDCk(INAM, 'Idle', [IDLE, NULL], False, cpNormal, True),
      wbPDTOs
    ], [])),

    {--- Ragdoll ---}
    wbXRGD,

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
    wbFormIDCk(XTNM, 'Teleport Name', [MESG]),

    wbFormIDCk(XRFG, 'Reference Group', [RFGP]),

    wbFormIDCk(XPCK, 'Unknown', [RFGP]),

    wbInteger(XBPO, 'Blueprint Part Origin', itU32),

    wbArray(XSL1, 'Snap Links', wbStruct('Snap Link', [
      wbFormIDCk('Linked Reference', [REFR]),
      wbArray('Links', wbStruct('Link', [
        wbInteger('Parent Node', itU32)
          .SetLinksToCallback(wbLinksToNodeId())
          .SetToStr(wbToStringFromLinksToSummary),
        wbInteger('Linked Node', itU32)
          .SetLinksToCallback(wbLinksToNodeId('...\Linked Reference'))
          .SetToStr(wbToStringFromLinksToSummary)
      ]), -1)
    ]), -1),

    wbXPCS,

    wbFormIDCk(XLCN, 'Persist Location', [LCTN]),

    wbFormIDCk(XLRL, 'Location Reference', [LCRT, LCTN, NULL], False, cpBenignIfAdded),

    wbRStruct('Projected Decal', [
      wbStruct(XPDD, 'Projected Decal Data', [
        wbFloat('Width Scale'),
        wbFloat('Height Scale'),
        wbFloat,
        wbInteger('Unknown', itU8),
        wbUnused(3)
      ]),
      wbArray(XPDO, 'Projected Decal References', wbFormIDCk('Projected Decal Reference', sigReferences))
    ], []),
    wbVec3(XCDD, 'Constrained Decal'),

    wbEmpty(XIS2, 'Ignored by Sandbox'),

    wbXRNK,

    wbStruct(XLGD, 'Gobo Animated Properties', [
      wbFloat('Static Rotation'),
      wbFloat('Animated Rotation Speed'),
      wbFloat('Animated Wave Rotation Speed'),
      wbFloat('Animated Wave Rotation Amount'),
      wbFloat('Static Scale U 1.0+/-'),
      wbFloat('Static Scale V 1.0+/-'),
      wbFloat('Wave Scaling U Speed'),
      wbFloat('Wave Scaling V Speed'),
      wbFloat('Wave Scaling U Amount'),
      wbFloat('Wave Scaling V Amount'),
      wbFloat('Static Offset U'),
      wbFloat('Static Offset V'),
      wbFloat('Rotation Pivot U 0.5+/-'),
      wbFloat('Rotation Pivot V 0.5+/-'),
      wbFloat('Scroll Speed U'),
      wbFloat('Scroll Speed V'),
      wbFloat('Wave Scroll Speed U'),
      wbFloat('Wave Scroll Speed V'),
      wbFloat('Wave Scroll Amount U'),
      wbFloat('Wave Scroll Amount V'),
      wbFloat('Random Time Offset Range'),
      wbInteger('Is Animated', itU8, wbBoolEnum),
      wbUnused(3)
    ]),

    wbStruct(XCOL, 'Collision', [
    { 0} wbInteger('Collision Layer', itU32)
           .SetLinksToCallback(function(const aElement: IwbElement): IwbElement
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
    { 4} wbFormIDCk('Unknown', [NULL, MATT])
    { 8}
    ]),

    wbXPLKs,

    wbLinkedReferences,

    wbFormIDCk(XLIB, 'Leveled Item Base Object', [LVLI]),

    wbInteger(XCNT, 'Item Count', itS32),

    wbXFLG,

    wbStruct(XLFD, 'Light Flicker', [
      wbFloat('Period'),
      wbFloat('Intensity Amplitude'),
      wbFloat('Movement Amplitude'),
      wbInteger('Flicker Effect', itU8, wbEnum([
        'None',
        'Flicker',
        'Pulse'
      ])),
      wbUnused(3)
    ]),

    {--- Map Data ---}
    wbRStruct('Map Marker', [
      wbMarkerReq(XMRK),
      wbInteger(FNAM, 'Map Flags', itU32,
        wbFlags(wbSparseFlags([
          0, 'Visible',
          1, 'Can Travel To',
          2, '"Show All" Hidden',
          3, 'Use Location Name',
          4, 'Visible on Star Map',
          5, 'Discovered',
          6, 'Requires Scanning',
          7, 'Allow Grav Jump',
          9, 'Suppress Discovery',
         10, 'Use Accurate Z-Height',
         11, 'Limit Map Visibility To Compass Range'
        ], False, 12))
      ).SetRequired
       .IncludeFlag(dfCollapsed, wbCollapseFlags),
      wbFULLReq,
      wbInteger(TNAM, 'Type', itU16, wbEnum([
        { 0} 'Akila City',
        { 1} 'Cydonia',
        { 2} 'Dazra',
        { 3} 'Neon',
        { 4} 'New Atlantis',
        { 5} 'Ryujin Industries',
        { 6} 'Scaled Citadel',
        { 7} 'The Lodge',
        { 8} 'The MAST',
        { 9} 'The Rock',
        {10} 'Cave',
        {11} 'Mining Base',
        {12} 'Outpost',
        {13} 'Science Lab',
        {14} 'Natural Landmark',
        {15} 'Mech Graveyard',
        {16} 'Fractured Earth',
        {17} 'Mountain Peak',
        {18} 'Crystal Grotto',
        {19} 'Crashed Starship',
        {20} 'Farm',
        {21} 'Industrial',
        {22} 'Military Base',
        {23} 'NASA',
        {24} 'Starborn Temple',
        {25} 'Coral Colony',
        {26} 'Fossil Outcropping',
        {27} 'Animal Den',
        {28} 'Frozen Watersource',
        {29} 'Geysers',
        {30} 'Boiling Hotsprings',
        {31} 'Acid Fog',
        {32} 'Radiation Zone',
        {33} 'Star Station',
        {34} 'Star Yard',
        {35} 'Settlement',
        {36} 'Legendary Ship',
        {37} 'The Vigilance',
        {38} 'Derelict Ship',
        {39} 'Space Graveyard',
        {40} 'Icy Asteroids',
        {41} 'Rocky Asteroids',
        {42} 'The Unity',
        {43} 'The Eye',
        {44} 'The Key',
        {45} 'POI',
        {46} 'Debris Field',
        {47} 'Ship',
        {48} 'Surface Settlement',
        {49} 'Distress Call',
        {50} 'Starborn Temple Obelisk',
        {51} 'Bar',
        {52} 'Food',
        {53} 'Vendor',
        {54} 'Armor Vendor',
        {55} 'Weapon Vendor',
        {56} 'Aid Vendor',
        {57} 'Surgery',
        {58} 'Realtor',
        {59} 'Player House',
        {60} 'Transit',
        {61} 'The Well',
        {62} 'Trackers Alliance',
        {63} '',
        {64} 'Shrine - Devotion',
        {65} 'Shrine - Obedience',
        {66} 'Shrine - Perseverance',
        {67} 'Shrine - Redemption',
        {68} 'Shrine - Strength',
        {69} 'Shrine - Generic'
      ]), cpNormal, True),
      wbInteger(VNAM, 'Category', itU16, wbEnum([
        {0}'None',
        {1}'Landmark',
        {2}'Structure',
        {3}'Life Signs',
        {4}'Hazard',
        {5}'Space Landmark',
        {6}'Ship',
        {7}'Station',
        {8}'Asteroids',
        {9}'Simple'
      ]), cpNormal, True),
      wbLString(UNAM, 'Unexplored Name', 0, cpTranslate),
      wbInteger(VISI, 'Undiscovered Visibility', itU8, wbEnum([
        'Always',
        'System',
        'Planet'
      ]))
    ], []),

    wbInteger(XLLD, 'Light Layer Data', itU32, wbBoolEnum),

    wbFloat(XLVD, 'Light Volumetric Data'),

    wbFloat(XRFE, 'Light Radius Fallout Exponent'),

    wbXEED,

    wbXOWN,

    wbXLRD,

    wbStruct(XLBD, 'Barndoors', [
      { 4} wbFloat('Bottom'),
      { 8} wbFloat('Right 1.0+/-'),
      { 0} wbFloat('Left'),
      {12} wbFloat('Top 1.0+/-'),
      {16} wbFloat('Falloff Intensity 100.0+/-'),
      {20} wbInteger('Has Barndoors', itU8, wbBoolEnum),
      {21} wbInteger('Has Fallout', itU8, wbBoolEnum),
      {22} wbUnused(2) // padding
    ]),

    wbInteger(XLSM, 'Light Static Shadow Map', itU32, wbBoolEnum),

    wbRArray('Light Colors', wbStruct(XLCD, 'Light Color', [
      wbByteRGBA,
      wbUnknown(5),
      wbUnused(3)
    ])),

    wbArray(XLMS, 'Layered Material Swaps', wbFormIDCk('Layered Material Swap', [LMSW])),

    wbFormIDCk(XEZN, 'Location Override', [LCTN]),

    wbFloat(XGDS, 'Geometry Dirtyness Scale'),

    wbRStruct('Grouped Pack-In', [
      wbMarkerReq(XWPK),
      wbFormIDCk(GNAM, 'Unknown', [PKIN]),
      wbFormIDCk(HNAM, 'Unknown', [REFR]),
      wbInteger(INAM, 'Unknown', itU16, wbBoolEnum).SetRequired,
      wbFormIDCk(JNAM, 'Unknown', [PKIN]),
      wbUnknown(LNAM, 4).SetRequired,
      wbEmpty(XGOM, 'Unknown'),
      wbMarkerReq(XWPK)
    ], []),

    {--- Lock ---}
    wbXLOC,

    wbArrayS(XPPS, 'Properties', wbObjectProperty),

    wbFormIDCk(XLYR, 'Layer', [LAYR]),

    wbFloat(XHTW, 'Head-Tracking Weight'),

    wbFloat(XFVC, 'Favor Cost'),

    wbInteger(BOLV, 'Water Reflection', itU16, wbEnum([
      '',
      'Unknown 1'
    ])),

    wbStruct(XBSD, 'Bendable Spline', [
      wbFloat('Slack'),
      wbFloat('Thickness'),
      wbStruct('Half Extents', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z')
      ]),
      wbInteger('Wind - Detached End', itU8, wbBoolEnum),
      wbUnused(3)
    ], cpNormal, False, nil, 5),

    wbReflection(XNSE),

    wbFormIDCk(XATR, 'Attach Ref', sigReferences),


    wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),

    wbXRGB,

    wbInteger(XHLT, 'Health %', itU32),

    wbFormIDCk(TODD, 'Time Of Day Data', [TODD]),

    wbXESP,

    wbXTV2,

    wbStruct(XNDP, 'Namesh Door Link', [
      wbFormIDCk('Namesh', [NAVM]),
      wbInteger('Triangle', itS16, wbREFRNavmeshTriangleToStr, wbStringToInt),
      wbUnused(2)
    ]),

    wbEmpty(XATP, 'Activation Point'),

    wbXSCL,

    wbEmpty(ONAM, 'Open by Default'),

    wbDataPosRot,

    wbString(MNAM, 'Comments')
  ], True, wbPlacedAddInfo, cpNormal, False);

  {subrecords checked against Starfield.esm}
  wbRecord(REGN, 'Region',
    wbFlags(wbFlagsList([
      {0x00000040} 6, 'Border Region'
    ])), [
    wbEDID,
    wbByteColors(RCLR, 'Map Color'),
    wbRArray('Region Areas', wbRStruct('Region Area', [
      wbInteger(RPLI, 'Edge Fall-off', itU32),
      wbArray(RPLD, 'Region Point List Data', wbStruct('Point', [
        wbFloat('X'),
        wbFloat('Y')
      ]), 0, wbRPLDAfterLoad)
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
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
        wbInteger('Priority', itU8),
        wbByteArray('Unknown')
      ], cpNormal, True),

      {--- Weather ---}
      wbArrayS(RDWT, 'Weather Types', wbStructSK([0], 'Weather Type', [
        wbFormIDCk('Weather', [WTHR]),
        wbInteger('Chance', itU32),
        wbFormIDCk('Global', [GLOB, NULL])
      ]), 0, cpNormal, False, nil, nil, wbREGNWeatherDontShow)
    ], []))
  ], True);

  {subrecords checked against Starfield.esm}
  wbRecord(SOUN, 'Sound Marker', [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbXALG,
    wbKeywords,
    wbSoundReference(SMLS),
    wbStruct(DEVT, 'Sound Detection', [
      wbInteger('Level', itU32, wbSoundLevelEnum),
      wbFloat('Radius')
    ])
  ]).SetSummaryKey([5]);

  var wbSPIT := wbStruct(SPIT, 'Data', [
    { 0} wbInteger('Base Cost', itU32),
    { 4} wbInteger('Flags', itU32, wbFlags([
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
           {0x00800000} 'No Dual Cast Modifications',
           {0x01000000} 'Unknown 25',
           {0x02000000} 'Unknown 26',
           {0x04000000} 'Unknown 27',
           {0x08000000} 'Unknown 28',
           {0x10000000} 'Unknown 29',
           {0x20000000} 'Unknown 30',
           {0x40000000} 'Unknown 31',
           {0x80000000} 'Unknown 32'
         ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    { 8} wbInteger('Type', itU8, wbEnum([
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
           {11} 'Voice Power'
         ])),
    { 9} wbFloat('Charge Time'),
    {13} wbInteger('Cast Type', itU8, wbCastEnum),
    {14} wbInteger('Target Type', itU8, wbTargetEnum),
    {15} wbFloat('Cast Duration'),
    {19} wbFloat('Range'),
    {23} wbFormIDCk('Casting Perk', [NULL, PERK])
  ], cpNormal, True);

  {subrecords checked against Starfield.esm}
  wbRecord(SPEL, 'Spell', [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbFULL,
    wbKeywords,
    wbMDOB,
    wbETYP,
    wbPUSH,
    wbPDSH,
    wbDESCReq(),
    wbSPIT,
    wbEffects
  ], False, nil, cpNormal, False, nil, nil);

  {wbRecord(SCRL, 'Scroll', [
    wbEDID
  ]);}

  {subrecords checked against Starfield.esm}
  wbRecord(STAT, 'Static',
    wbFlags(wbFlagsList([
      2,'Heading Marker',
      4, 'Non Occluder',
      9, 'Hidden From Local Map',
     10,'Headtrack Marker',
     11, 'Used as Platform',
     13, 'Pack-In Use Only',
     15, 'Has Distant LOD',
     16, 'Uses HD LOD Texture',
     19, 'Has Currents',
     23,'Is Marker',
     25,'Obstacle',
     26, 'Navmesh - Filter',
     27, 'Navmesh - Bounding Box',
     28, 'Navmesh - Only Cut',
     29, 'Navmesh - Ignore Erosion',
     30, 'Navmesh - Ground'
    ])).SetFlagHasDontShow(26, wbFlagNavmeshFilterDontShow)
       .SetFlagHasDontShow(27, wbFlagNavmeshBoundingBoxDontShow)
       .SetFlagHasDontShow(28, wbFlagNavmeshOnlyCutDontShow)
       .SetFlagHasDontShow(29, wbFlagNavmeshIgnoreErosionDontShow)
       .SetFlagHasDontShow(30, wbFlagNavmeshGroundDontShow), [
    wbEDID,
//    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbDEFL,
    wbXALG,
    wbBaseFormComponents,
    wbFTYP,
    wbGenericModel(True),
    wbPRPS,
    wbFULL,
    wbStruct(DNAM, 'Direction Material', [
      wbFloat('Max Angle (30-120)'),
      wbFloat,
      wbFloat('Leaf Amplitude'),
      wbFloat('Leaf Frequency')
    ], cpNormal, True, nil, 2),
    wbSoundReference(STLS, 'Ambient Sound'),
    wbNVNM
  ], False);

  {subrecords checked against Starfield.esm}
  wbRecord(TES4, 'Main File Header',
    wbFlags(wbFlagsList([
      {0x001}  0, 'Master',
      {0x010}  4, 'Optimized',
      {0x080}  7, 'Localized',
      {0x100}  8, 'Small',
      {0x200}  9, 'Update',
      {0x400} 10, 'Medium',
      {0x800} 11, 'Blueprint'
    ], False), True), [
    wbHEDR,

    wbByteArray(OFST, 'Unknown', 0, cpIgnore),                        // If possible then ignored by the runtime. Neither from the CK

    wbByteArray(DELE, 'Unknown', 0, cpIgnore),                        // If possible then ignored by the runtime. Neither from the CK

    wbString(CNAM, 'Author', 0, cpTranslate, True),

    wbString(SNAM, 'Description', 0, cpTranslate),

    wbRArray('Master Files', wbRStruct('Master File', [
      wbStringForward(MAST, 'FileName', 0, cpNormal, True)
    ], [ONAM])).IncludeFlag(dfInternalEditOnly, not wbAllowMasterFilesEdit),

    wbArray(ONAM, 'Overridden Forms',                                 // Valid in CK
      wbFormIDCk('Form', [ACHR, LAND, NAVM, REFR, PGRE, PHZD, PMIS, PARW, PBAR, PBEA, PCON, PFLA, DLBR, DIAL, INFO, SCEN])
    )
    .IncludeFlag(dfExcludeFromBuildRef)
    .IncludeFlag(dfCollapsed),

    wbByteArray(SCRN, 'Screenshot'),                                  // If possible then ignored by the runtime. Neither from the CK

    wbRArray('Transient Types (CK only)', wbStruct(TNAM, 'Transient Type', [ // Ignored by the runtime
      wbInteger('FormType', itU32),                                   // seen TESTopic 78 (array of DIAL) and BGSScene 126 (array of SCEN)
      wbArray('Unknown', wbFormIDCk('Unknown',[DIAL,SCEN]))
    ]))
    .IncludeFlag(dfExcludeFromBuildRef)
    .IncludeFlag(dfCollapsed),

    wbString(BNAM, 'Branch'),

    wbInteger(INTV, 'Unknown', itU32),                                // Ignored by the runtime, 4 bytes loaded in CK

    wbInteger(INCC, 'Internal Cell Count', itU32),                    // Size of some array of 12 bytes elements

    wbUnknown(CHGL)
  ], True, nil, cpNormal, True);

  {xEdit internal subrecord type}
  wbRecord(PLYR, 'Player Reference', [
    wbEDID,
    wbFormID(PLYR, 'Player', cpNormal, True).SetDefaultNativeValue($7)
  ]).IncludeFlag(dfInternalEditOnly);

  {subrecords checked against Starfield.esm}
  wbRecord(FLOR, 'Flora', [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbByteColors(PNAM, 'Marker Color (Unused)'),
    wbATTX,
    wbUnknown(FNAM).SetRequired(True),                               // FNAM/JNAM look like remnants from ACTI struct
    wbUnknown(JNAM).SetDefaultEditValue('68 01').SetRequired(True),
    wbFormIDCk(PFIG, 'Ingredient', sigBaseObjects),
    wbSoundReference(PFHS, 'Harvest Sound'),
    wbStruct(PFPC, 'Ingredient Production', [
      wbInteger('Spring', itU8),
      wbInteger('Summer ', itU8),
      wbInteger('Fall', itU8),
      wbInteger('Winter', itU8)
    ], cpNormal, True),
    wbAPPR,
    wbObjectTemplate,
    wbEmpty(STOP, 'Marker').SetRequired,
    wbFormIDCk(ANAM, 'Action Keyword', [KYWD]),
    wbFloat(BNAM, 'Damage Required To Harvest').SetRequired,
    wbFloat(FMAH, 'Max Harvest Count').SetRequired,
    wbFloat(FMIH, 'Min Harvest Count').SetRequired,
    wbFormIDCk(FMAG, 'Max Global', [GLOB]),
    wbFormIDCk(FMIG, 'Min Global', [GLOB]),
    wbFormIDCk(FLXP, 'Explosion', [EXPL]),
    wbSoundReference(FHLS, 'Harvest Looping Sound')
  ], False, nil, cpNormal, False, nil, nil);

  var wbTypeEnum := wbEnum([
    { 0} 'Unarmed',
    { 1} 'One Hand Sword',
    { 2} 'One Hand Dagger',
    { 3} 'One Hand Axe',
    { 4} 'One Hand Mace',
    { 5} 'Two Hand Sword',
    { 6} 'Two Hand Axe',
    { 7} 'Bow',
    { 8} 'Staff',
    { 9} 'Gun',
    {10} 'Grenade',
    {11} 'Mine',
    {12} 'Mounted'
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AMDL, 'Aim Model', [
    wbEDID,
    wbBaseFormComponents,
    wbStruct(ANAM, 'Data', [
       wbFloat('Cone of Fire - Degrees X'),
       wbFloat('Cone of Fire - Degrees Y'),
       wbFloat('Cone of Fire - Increase Per Shot'),
       wbFloat('Cone of Fire - Decrease Per Sec'),
       wbFloat('Cone of Fire - Decrease Delay in Sec'),
       wbFloat('Cone of Fire - Sneak Mult'),
       wbFloat('Recoil - Diminish Spring Force'),
       wbFloat('Recoil - Diminish Sights Mult'),
       wbFloat('Recoil - Degrees Per Shot X'),
       wbFloat('Recoil - Degrees Per Shot Y'),
       wbFloat('Recoil - Hip Mult'),
       wbInteger('Recoil - Shots for Runaway', itU32),
       wbFloat('Recoil - Arc'),
       wbFloat('Recoil - Arc Rotate'),
       wbFloat('Cone of Fire - Iron Sights Mult'),
       wbFloat('Recoil - Base Stability'),
       wbInteger('Cone of Fire Ignores Movement', itU8, wbBoolEnum)
    ])
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
      wbUnused(2)
    ], cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(BNDS, 'Bendable Spline',
    wbFlags(wbFlagsList([
      {0x00800000} 23, 'Unknown 23'
    ])), [
    wbEDID,
    wbOBND,
    wbODTYReq,
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

  {subrecords checked against Starfield.esm}
  wbRecord(DFOB, 'Default Object', [
    wbEDID,
    wbXALG,
    wbFormID(DATA, 'Object')
  ])
  .IncludeFlag(dfIndexEditorID);

  {subrecords checked against Starfield.esm}
  wbRecord(DMGT, 'Damage Type', [
    wbEDID,
    wbFULL,
    wbStruct(DNAM, 'Damage Type', [
      wbFormIDck('Resistance Actor Value', [AVIF, NULL]),
      wbFormIDck('Spell', [SPEL, NULL])
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(INNR, 'Instance Naming Rules', [
    wbEDID,
    wbInteger(UNAM, 'Target', itU32, wbEnum([], [
        0, 'None',
      $22, 'Armor',
      $24, 'Container',
      $2E, 'Flora',
      $2F, 'Furniture',
      $30, 'Weapon',
      $32, 'Actor'
    ])).SetRequired,
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
          ], []),
          cpNormal, False, nil, wbINNRAfterSet
        )
      ], [])
    , 10).SetRequired
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(KSSM, 'Sound Keyword Mapping', [
    wbEDID,
    wbSoundReference(WED0),
    wbRArray('Keywords', wbFormIDCk(KNAM, 'Keyword', [KYWD]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole)),
    wbInteger(RSMC, 'Count', itU32, nil, cpNormal, True)                        // yes they use the same signature for count and other data below
      .IncludeFlag(dfSkipImplicitEdit),
    wbRStructs('Reverb Sounds', 'Entry', [
      wbInteger(RSMC, 'Class', itU32, wbEnum([                                  // yes same signature as count
        'Default',
        'Class A',
        'Class B',
        'Class C',
        'Class D',
        'Class E'
      ])),
      wbSoundReference(RSMH)
    ], []).SetCountPath(RSMC)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(LAYR, 'Layer',
    wbFlags(wbFlagsList([
      {0x08000000} {27} 27, 'Starts Frozen'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbFormIDCk(PNAM, 'Parent', [LAYR]),
    wbByteColors(XCLP).SetRequired,
    wbInteger(LODB, 'LOD Behavior', itU32, wbEnum([
      'Default',
      'Aggregate',
      'No LODs'
    ]), cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(LENS, 'Lens Flare', [
    wbEDID,
    wbFloat(CNAM, 'Color Influence', cpNormal, True),
    wbFloat(DNAM, 'Fade Distance Radius Scale', cpNormal, True).SetDefaultEditValue('1.0'),
    wbFloat(ENAM, 'Exposure Influence', cpNormal, True),
    wbFloat(MNAM, 'Min EV 100', cpNormal, True).SetDefaultEditValue('4.0'),
    wbFloat(XNAM, 'Max EV 100', cpNormal, True).SetDefaultEditValue('6.0'),
    wbInteger(LFSP, 'Count', itU32, nil, cpBenign, True),
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
            {0x02} 'Shrinks When Occluded',
            {0x04} 'Glare Flare'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
        ])
      ], []),
      cpNormal, False
    ).SetCountPath(LFSP)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(NOCM, 'Navmesh Obstacle Cover Manager', [
    wbEDID,
    wbRArray('Unknown',
      wbRStruct('Unknown', [
        wbInteger(INDX, 'Index', itU32),
        wbRArray('Unknown datas',
          wbStruct(DATA, 'Unknown data', [
            wbUnknown
          ])
        ),
        wbUnknown(INTV),
        wbString(NAM1, 'Model')
      ], [])
    )
  ]);

  var wbStarSlot :=
    wbInteger('Star Slot', itU32, wbLGDIStarSlot)
    .SetSetToDefault(function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Boolean
      begin
        var lContainer: IwbContainerElementRef;

        if not Assigned(aBasePtr) or
           not Assigned(aEndPtr) or
           ((IntPtr(aEndPtr) - IntPtr(aBasePtr)) < SizeOf(Integer)) or
           not Assigned(aElement) or
           not Supports(aElement.Container, IwbContainerElementRef, lContainer) or
           not Supports(lContainer.Container, IwbContainerElementRef, lContainer) or
           not (lContainer.ElementType = etArray) or
           (lContainer.MemoryOrder < 0) or
           (lContainer.MemoryOrder > Pred(wbLGDIStarSlot.NameCount))
        then
          Exit(False);

        PInteger(aBasePtr)^ := lContainer.MemoryOrder;
        Result := True;
      end)
    .SetDontShow(wbNeverShow)
    .IncludeFlag(dfInternalEditOnly);

  var wbArrayShouldIncludeStarSlotMatchesMemoryOrder: TwbShouldIncludeCallback :=
    function(aBasePtr: Pointer; aEndPtr: Pointer; const aArray: IwbElement): Boolean
      begin
        if not Assigned(aArray) or
           not Assigned(aBasePtr) or
           not Assigned(aEndPtr) or
           ((IntPtr(aEndPtr) - IntPtr(aBasePtr)) < SizeOf(Integer))
        then
          Exit(False);

        Result := PInteger(aBasePtr)^ = aArray.MemoryOrder;
      end;

  var wbLGDIStarSlotArray :=
    function(aSignature: TwbSignature; const aElement: IwbValueDef; aSorted: Boolean): IwbRecordMemberDef
    begin
      var lInnerArray: IwbArrayDef;
      if aSorted then
        lInnerArray := wbArrayS('', aElement)
      else
        lInnerArray := wbArray('', aElement);

      var lPluralName: string := aElement.Name + 's';

      var lElementDef := lInnerArray
        .SetShouldInclude(wbArrayShouldIncludeStarSlotMatchesMemoryOrder)
        .IncludeFlag(dfArrayCanBeEmpty)
        .SetSummaryName(lPluralName);

      if not aSorted then
        lElementDef := lElementDef
          .IncludeFlag(dfNoMove)
          .IncludeFlag(dfRemoveLastOnly);

      Result :=
        wbArray(aSignature, lPluralName, lElementDef)
        .SetSummaryPassthroughMaxCountOnValue(5)
        .SetCountFromEnumOnValue(wbLGDIStarSlot)
        .SetSummaryName('Star Slots')
        .IncludeFlag(dfNoMove)
    end;

  var wbLGDIFiltersToStr: TwbIntToStrCallback :=
    function(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string
    begin
      Result := '';
      case aType of
        ctToStr, ctToSummary: begin
          Result := aInt.ToString;
          if aType = ctToStr then
            Result := Result + ' <Warning: Could not resolve mod index>';
        end;
        ctToEditValue:
          Result := aInt.ToString;
        ctToSortKey: begin
          Result := IntToHex64(aInt, 8);
          Exit;
        end;
        ctCheck:
          Result := '<Warning: Could not resolve mod index>';
        ctEditType: Exit('ComboBox');
        ctEditInfo: ;
      else
        Exit;
      end;

      if not Assigned(aElement) then
        Exit;

      var lFilter: IwbContainerElementRef;

      if not Supports(aElement.Container, IwbContainerElementRef, lFilter) then
        Exit;

      var lMainRecord := aElement.ContainingMainRecord;

      var lStarSlots: IwbContainerElementRef;
      if not Supports(lMainRecord.ElementBySignature[BNAM], IwbContainerElementRef, lStarSlots) then
        Exit;

      var lStarSlotValue := lFilter.Elements[0].NativeValue;
      if not VarIsOrdinal(lStarSlotValue) then
        Exit;
      var lStarSlotIndex: Integer := lStarSlotValue;

      if (lStarSlotIndex < 0) or (lStarSlotIndex >= lStarSlots.ElementCount) then
        Exit;

      var lStarSlot: IwbContainerElementRef;
      if not Supports(lStarSlots.Elements[lStarSlotIndex], IwbContainerElementRef, lStarSlot) then
        Exit;

      if aType = ctEditInfo then
        with TwbFastStringListIC.Create do try
          for var lModIdx := 0 to Pred(lStarSlot.ElementCount) do begin
            var lInfoMod := lStarSlot.Elements[lModIdx] as IwbContainerElementRef;
            var lIndexString := IntToStr(lModIdx);
            while Length(lIndexString) < 2 do
              lIndexString := '0' + lIndexString;
            Add(lIndexString + ' ' + lInfoMod[1].EditValue);
          end;
          Sort;
          Exit(CommaText);
        finally
          Free;
        end;

      var lModIndexValue := aElement.NativeValue;
      if not VarIsOrdinal(lModIndexValue) then
        Exit;
      var lModIndex: Integer := lModIndexValue;

      if (lModIndex < 0) or (lModIndex >= lStarSlot.ElementCount) then
        Exit;

      var lMod := lStarSlot.Elements[lModIndex] as IwbContainerElementRef;
      var lModName := lMod[1].EditValue;
      if lModName = '' then
        Exit;

      case aType of
        ctCheck: Exit('');
        ctToSummary: begin
          var lOMOD: IwbMainRecord;
          if Supports(lMod.Elements[1].LinksTo, IwbMainRecord, lOMOD) then begin
            lModName := lOMOD.EditorID;
            if lModName = '' then
              lModName := lOMOD.ShortName;
            Exit(lModName);
          end else
            Exit('');
        end;
        else
          Result := IntToStr(lModIndex);
          while Length(Result) < 2 do
            Result := '0' + Result;
      end;

      Result := Result + ' ' + lModName;
    end;


  var wbStrToLGDIFilter: TwbStrToIntCallback :=
    function(const aString: string; const aElement: IwbElement): Int64
    var
      i    : Integer;
      s    : string;
    begin
      Result := -1;

      i := 1;
      s := Trim(aString);
      while (i <= Length(s)) and (ANSIChar(s[i]) in ['0'..'9']) do
        Inc(i);
      s := Copy(s, 1, Pred(i));

      Result := StrToIntDef(s, 0);
    end;

  var wbLGDIFilter :=
    function(aSignature: TwbSignature; const aName: string): IwbRecordMemberDef
    begin
      Result :=
        wbLGDIStarSlotArray(aSignature,
          wbStructExSK([1], [2], aName, [
            wbStarSlot,
            wbInteger('Referenced Mod', itU32, wbLGDIFiltersToStr, wbStrToLGDIFilter{).SetLinksToCallback(wbLGDIFiltersLinksTo}),
            wbFormIDCk('Keyword', [KYWD])
          ])//.SetSummaryKey([1, 2])
            .SetSummaryMemberPrefixSuffix(1, '<', '>')
            .SetSummaryMemberPrefixSuffix(2, '', '')
            .SetSummaryDelimiter(' ')
            .IncludeFlag(dfSummaryMembersNoName)
            //.IncludeFlag(dfSummaryNoSortKey)
            .IncludeFlag(dfCollapsed, wbCollapseItems)
        , True);
    end;

  {subrecords checked against Starfield.esm}
  wbRecord(LGDI, 'Legendary Item', [
    wbEDID,
    wbOBND,
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbXALG,
    wbBaseFormComponents,
    wbGenericModel(True),
    wbFULL,
    wbEmpty(DATA).SetRequired,
    wbFormIDCk(ANAM, 'Base Object List', [LVLI]),
    wbFormIDCk(ENAM, 'Rank Template', [LGDI]),

    wbLGDIStarSlotArray(BNAM,
      wbStruct('Mod', [
        wbStarSlot,
        wbFormIDCk('Object Modification', [OMOD])
      ])
      .SetSummaryKey([1])
      .SetSummaryMemberPrefixSuffix(1, '', '')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfSummaryNoSortKey)
      .IncludeFlag(dfCollapsed, wbCollapseItems)
    , False),

    wbLGDIFilter(CNAM, 'Include Filter'),
    wbLGDIFilter(DNAM, 'Exclude Filter')
  ]);

  { still exists in game code, but not in Starfield.esm }
  wbRecord(NOTE, 'Note', [
    wbEDID,
    wbVMAD,
    wbOBND,
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbDEFL,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbSoundReference(PUSH),
    wbSoundReference(PDSH),
    wbInteger(DNAM, 'Type', itU8,
      wbEnum([
        'Sound',
        'Voice',
        'Program',
        'Terminal'
      ])
    ).SetRequired,
    wbStruct(DATA, 'Attributes', [      // was DNAM before form version 65. Now holds value and weight
      wbInteger('Value', itU32),
      wbFloat('Weight')
    ]),
    wbUnion(SNAM, 'Data', wbNoteTypeDecider, [
      wbUnused(4),
      wbFormIDCk('Sound', [SNDR]),
      wbFormIDCk('Scene', [SCEN]),
      wbFormIDCk('Terminal', [TERM])
    ]),
    wbString(PNAM, 'Program File')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(OMOD, 'Object Modification',
    wbFlags(wbFlagsList([
      {0x00000010} 4, 'Legendary Mod',
      {0x00000080} 7, 'Mod Collection',
      {0x00000100} 8, 'Property Collection'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbFULL,
    wbDESC(),
    wbGenericModel(True),
    wbUnknown(XFLG),
    wbStruct(DATA, 'Data', [
      wbInteger(csIncludeCount, itU32, nil, cpBenign).IncludeFlag(dfSkipImplicitEdit),
      wbInteger(csPropertyCount, itU32, nil, cpBenign).IncludeFlag(dfSkipImplicitEdit),
      wbUnknown(2),
      wbLenString('Name').SetFormater(wbStringEnum([
          'Container_InstanceData',
          'Spaceship_InstanceData',
          'TESFlora_InstanceData',
          'TESFurniture_InstanceData',
          'TESNPC_InstanceData',
          'TESObjectARMOR_InstanceData',
          'TESObjectWEAP_InstanceData',
          'NONE'
        ])).IncludeFlag(dfHasZeroTerminator),
      wbInteger('Max Rank', itU8),
      wbInteger('Level Tier Scaled Offset', itU8),
      wbFormIDCk('Attach Point', [KYWD, NULL]),
      wbArray('Attach Parent Slots', wbFormIDCk('Keyword', [KYWD, NULL]), -1),
      wbUnknown(4),
      wbArray('Includes', wbStruct('Include', [
        wbFormIDCk('Mod', [OMOD]),
        wbInteger('Minimum Level', itU8),
        wbInteger('Optional', itU8, wbBoolEnum),
        wbInteger('Don''t Use All', itU8, wbBoolEnum)
      ])).SetCountPath(csIncludeCount, True),
      wbObjectModProperties
    ]),
    wbArray(MNAM, 'Target OMOD Keywords', wbFormIDCk('Keyword', [KYWD])),
    wbArray(FNAM, 'Filter Keywords', wbFormIDCk('Keyword', [KYWD])),
    wbFormIDCk(LNAM, 'Loose Mod', sigBaseObjects),
    wbInteger(NAM1, 'Priority', itU8),
    wbFLTR,
    wbFormIDCk(NAM2, '3rd Person Morphable Object', [MRPH]),
    wbFormIDCk(NAM3, '1st Person Morphable Object', [MRPH])
  ]);

  {subrecords checked against Starfield.esm}
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

  {subrecords checked against Starfield.esm}
  wbRecord(PKIN, 'Pack-In',
    wbFlags(wbFlagsList([
      {0x00000200}  9, 'Instanced',
      {0x00000400} 10, 'Calc LPIs',
      {0x00000800} 11, 'Instanced Static',
      {0x00002000} 13, 'Pack-In Use Only',
      {0x02000000} 25, 'Obstacle'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND,
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbXALG,
    wbBaseFormComponents,
    wbFLTR,
    wbOPDS,
    wbFormIDCk(CNAM, 'Cell', [CELL]),
    wbInteger(VNAM, 'Version', itU32),
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      'Unknown 0',
      'Grouped Workshop Object',
      'Fixed',
      'Grouped',
      'One Motion',
      'User-defined Primitives',
      'Override Dirtiness',
      'Unknown 7',
      'Unknown 8',
      '',
      'Unknown 10',
      '',
      'Unknown 12',
      'Unknown 13',
      '',
      '',
      'Unknown 16',
      'Unknown 17',
      'Unknown 18',
      'Unknown 19',
      '',
      'Unknown 21',
      '',
      '',
      '',
      '',
      '',
      'Unknown 27',
      'Unknown 28',
      '',
      'Unknown 30'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbKeywords,
    wbFTYP,
    wbPRPS,
    wbNTRM,
    wbStruct(MOLM, 'Material Swaps', [
      wbArrayS('Material Swaps', wbFormIDCk('Layered Material Swap', [LMSW]), -2),
      wbByteArray('Unused', 0, cpIgnore).SetDontShow(wbNeverShow).IncludeFlag(dfDontAssign)
    ]),
    wbFULL
  ]).SetSummaryKey([12]);

  {subrecords checked against Starfield.esm}
  wbRecord(RFGP, 'Reference Group', @wbKnownSubRecordSignaturesRFGP, [
    wbEDID,
    wbBaseFormComponents,
    wbString(NNAM, 'Name'),
    wbFormIDCk(RNAM, 'Reference', sigReferences),
    wbFormIDCk(PNAM, 'Pack-in', [PKIN]),
    wbFormIDCk(LNAM, 'Unknown', sigReferences),
    wbArray(MNAM,'Unknown', wbUnknown(4), 3)
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
    wbUnknown(VNAM)
  ]);

  var wbStaticPart :=
    wbRStructSK([0], 'Part', [
      wbStructSK(ONAM, [0], 'Unknown', [
        wbFormIDCk('Static', [ACTI, ALCH, AMMO, BOOK, CONT, DOOR, FURN, MISC, MSTT, STAT, TERM, WEAP, FLOR]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole),
        wbUnknown(4)
      ]),
      wbStaticPartPlacements
    ], [], cpNormal, True)
    .SetSummaryKey([1]);

  {subrecords checked against Starfield.esm}
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
      28, 'Navmesh - Only Cut',
      29, 'Navmesh - Ignore Erosion',
      30, 'Navmesh - Ground'
    ])).SetFlagHasDontShow(26, wbFlagNavmeshFilterDontShow)
       .SetFlagHasDontShow(27, wbFlagNavmeshBoundingBoxDontShow)
       .SetFlagHasDontShow(28, wbFlagNavmeshOnlyCutDontShow)
       .SetFlagHasDontShow(29, wbFlagNavmeshIgnoreErosionDontShow)
       .SetFlagHasDontShow(30, wbFlagNavmeshGroundDontShow), [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbSNTP,
    wbBaseFormComponents,
    wbGenericModel(True),
    wbFULL,
    wbFLTR,
    wbRArrayS('Parts', wbStaticPart, cpNormal, True)
  ]);


  {subrecords checked against Starfield.esm}
  wbRecord(STAG, 'Animation Sound Tag Set', [
    wbEDID,
    wbInteger(STMS, 'Count', itU32, nil, cpBenign).IncludeFlag(dfSkipImplicitEdit),
    wbRStructsSK('Entries', 'Entry', [0], [
      wbString(STAE, 'Tag').SetRequired,
      wbSoundReference(STAD).SetRequired
    ], []).SetCountPath(STMS)
  ]);

  var wbTerminalArtThemeEnum := wbEnum([], [
    0, 'Constellation',
    1, 'Freestar Collective',
    2, 'Generic',
    3, 'NASA',
    4, 'Ryujin Industries',
    5, 'Slayton Aerospace',
    6, 'United Colonies',
    7, 'Crimson Fleet',
    9, 'House Varuun'
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(TERM, 'Terminal',
    wbFlags(wbFlagsList([
      2, 'Heading Marker',
      4, 'Non Occluder',
      6, 'Never Fades',
      8, 'Must Update Anims',
      9, 'Hidden From Local Map',
     10, 'Headtrack Marker',
     11, 'Used As Platform',
     13, 'Pack-In Use Only',
     15, 'Has Distant LOD',
     16, 'Random Anim Start',
     17, 'Dangerous',
     19, 'Unknown 19',
     20, 'Ignore Object Interaction',
     23, 'Is Marker',
     25, 'Obstacle',
     26, 'Navmesh - Filter',
     27, 'Navmesh - Bounding Box',
     28, 'Navmesh - Cut Only',
     29, 'Navmesh - Ignore Erosion',
     30, 'Navmesh - Ground',
     31, 'Must Be Unique'
    ])).SetFlagHasDontShow(26, wbFlagNavmeshFilterDontShow)
       .SetFlagHasDontShow(27, wbFlagNavmeshBoundingBoxDontShow)
       .SetFlagHasDontShow(28, wbFlagNavmeshOnlyCutDontShow)
       .SetFlagHasDontShow(29, wbFlagNavmeshIgnoreErosionDontShow)
       .SetFlagHasDontShow(30, wbFlagNavmeshGroundDontShow), [
    wbEDID,
    wbVMADFragmentedPERK, // same fragments format as in PERK
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbDEFL,
    wbXALG,
    wbBaseFormComponents,
    wbFormIDCk(DNAM, 'Terminal Menu', [TMLM]),
    wbInteger(NAM1, 'Art Theme', itU8, wbTerminalArtThemeEnum)
      .SetDefaultNativeValue(2)
      .SetRequired,
    wbFULL,
    wbGenericModel(True),
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbFTYP,
    wbNTRM,
    wbByteColors(PNAM, 'Default Primitive Color')
      .SetRequired,
    wbALSH,
    wbACSH,
    wbFormIDCk(WTFM, 'Water', [WATR]),
    wbATTX,
    wbInteger(FNAM, 'Flags', itU16,
      wbFlags(wbSparseFlags([
        0, 'Non-Planar',
        1, 'Ignored By Sandbox',
        2, 'Unknown 2',
        4, 'Is A Radio',
        5, 'Allow Water Displacements'
      ], False, 6))
    ).SetRequired,
    wbInteger(JNAM, 'Activation Angle - For Player', itU16)
      .SetDefaultNativeValue(360)
      .SetRequired,
    wbStruct(RADR, 'Radio Receiver', [
      wbFloat('Frequency'),
      wbFloat('Volume'),
      wbInteger('Starts Active', itU8, wbBoolEnum),
      wbInteger('No Signal Static', itU8, wbBoolEnum)
    ]),
    wbConditions,
    wbMNAMFurnitureMarker.SetRequired,
    wbInteger(GNAM, 'Activation Angle - For Sitting Actor', itU16)
      .SetDefaultNativeValue(360)
      .SetRequired,
    wbUnused(WBDT, 0)
      .SetRequired,
    wbFormIDCk(FTMP, 'Furniture Template', [FURN]),
    wbUnknown(FNPR),     // only used by one official record CY_GlenHurst_CondoTerminal and unable to find corresponding data in CK
    wbString(XMRK, 'Marker Model'),
    wbSNAMMarkerParams,
    wbRArray('Object Template Instance Data', wbString(STRV)),
    wbObjectTemplate,
    wbMarkerReq(STOP)
  ]);

  {wbRecord(TLOD, 'TLOD', [
    wbEDID
  ]);

  wbRecord(TOFT, 'TOFT', [
    wbEDID
  ]);}

  {subrecords checked against Starfield.esm}
  wbRecord(TRNS, 'Transform',
    wbFlags(wbFlagsList([
      {0x00008000} 16, 'Around Origin',
      {0x00010000} 17, 'Apply Translation'
    ])), [
    wbEDID,
    wbStruct(DATA, 'Data', [
      wbPosRot,
      wbFloat('Scale'),
      wbFloat('Zoom Min'),
      wbFloat('Zoom Max')
    ], cpNormal, True, nil, 2)
    .SetSummaryKeyOnValue([0,1,2,3])
    .SetSummaryPrefixSuffixOnValue(1, '','x')
    .SetSummaryPrefixSuffixOnValue(2, 'From ','')
    .SetSummaryPrefixSuffixOnValue(3, 'to ',' ')
    .IncludeFlagOnValue(dfSummaryMembersNoName),
    wbInteger(BNAM, 'Basis', itU8, wbEnum([
      'World Bound',
      'Object Origin'
    ])),
    wbInteger(ENAM, 'Color Mode Flags', itU32, wbFlags([
      'Normal',
      'Monochromatic',
      'Alpha Fill'
    ]))
  ]).SetSummaryKey([1]);

  {subrecords checked against Starfield.esm}
  wbRecord(AAPD, 'Aim Assist Pose Data', [
    wbEDID,
    wbRStruct('Aim Assist Pill', [
      wbEmpty(AAAP, 'Aim Assist Pill Marker'),
      wbString(ANAM, 'Start Bone Name'),
      wbString(BNAM, 'End Bone Name'),
      wbFloat(RADR, 'Radius'),
      wbFloat(WTMX, 'Weight')
    ], []).SetRequired(True),
    wbInteger(AAPS, 'Count', itU32, nil, cpBenign).SetRequired(True).IncludeFlag(dfSkipImplicitEdit),
    wbRStructS('Bullet Bending Pills', 'Pill', [
      wbString(ANAM, 'Start Bone Name'),
      wbString(BNAM, 'End Bone Name'),
      wbFloat(RADR, 'Radius'),
      wbFloat(WTMX, 'Weight')
    ], []).SetCountPath(AAPS)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AAMD, 'Aim Assist Model Data', [
    wbEDID,
    wbStruct(SNAM, 'Data', [
      wbFloat('Inner Cone Angle Degrees'),
      wbFloat('Outer Cone Angle Degrees'),
      wbFloat('Steering Degrees Per Sec'),
      wbFloat('Pitch Scale'),
      wbFloat('Inner Steering Ring'),
      wbFloat('Outer Steering Ring'),
      wbFloat('Friction'),
      wbFloat('Move Follow Degrees Per Sec'),
      wbFloat('ADS Snap Steering Mult'),
      wbFloat('ADS Snap Seconds'),
      wbFloat('ADS Snap Cone Angle Degrees'),
      wbFloat('No Steering'),
      wbFloat('Bullet Bending Cone Angle Degrees'),
      wbFloat('ADS Snap Steering Mutliplier Inner Ring'),
      wbFloat('ADS Snap Steering Mutliplier Outer Ring'),
      wbFloat('ADS Multiplier Inner Cone Angle Degrees'),
      wbFloat('ADS Multiplier Outer Cone Angle Degrees'),
      wbFloat('ADS Multiplier Inner Steering Ring'),
      wbFloat('ADS Multiplier Outer Steering Ring'),
      wbFloat('ADS Multiplier Friction'),
      wbFloat('ADS Multiplier Steering Degrees Per Sec'),
      wbInteger('Aim Assist Enabled', itU8, wbBoolEnum)
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SECH, 'Sound Echo Marker', [
    wbEDID,
    wbOBND,
    wbODTYReq,
    wbXALG,
    wbString(NNAM, 'Description'),
    wbSoundReference(ECHL, 'Looping Sound'),
    wbRArray('Echos',
      wbRStruct('Echo', [
        wbRUnion('Echo Marker', [
          wbEmpty(ECHO, 'Echo Start Marker'),
          wbEmpty(ECHD, 'Echo Default Start Marker')
        ], []),
        wbWwiseGuid(ECTE),
        wbSoundReference(ECSH),
        wbInteger(ANAM, 'Voice Count', itU32),
        wbFloat(BNAM, 'Duration'),
        wbInteger(CNAM, 'Action At Limit', itU8, wbEnum([
          'Steal',
          'Skip'
        ])),
        wbInteger(DNAM, 'Use', itU8, wbEnum([
          'On Each Playback',
          'On Limit Reached'
        ])),
        wbInteger(ENAM, 'Trigger Release', itU8, wbBoolEnum),
        wbString(NNAM, 'Description'),
        wbCTDAs,
        wbEmpty(ECHE, 'Echo End Marker')
      ], []).SetSummaryKey([1,2])
    )
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CURV, 'Curve Table', [
    wbEDID,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(STND, 'Snap Template Node', [
    wbEDID,
    wbOBND,
    wbODTYReq,
    wbBaseFormComponents,
    wbGenericModel(True),
    wbKeywords,
    wbByteRGBA(CNAM),
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      {0x00000001} 'Snaps To Self',
      {0x00000002} 'Is Hinge',
      {0x00000004} 'Display Node',
      {0x00000008} 'Run Behaviors When Not Snapped'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(SNST, 'Stairway Type', itU32, wbEnum([
      'None',
      'Upstairs',
      'Downstairs'
    ])),
    wbRArray('Adjacent Snap Nodes', wbFormIDCk(NNAM, 'Adjacent Snap Node', [STND]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole)),
    wbRStruct('Angles', [
      wbFloat(FLTV, 'Min'),
      wbFloat(FLTV, 'Max'),
      wbFloat(FLTV, 'Step')
    ], []),
    wbFormIDCk(ANAM, 'Art Object', [ARTO])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(STMP, 'Snap Template', [
    wbEDID,
    wbBaseFormComponents,
    wbPTT2,
    wbFormIDCk(PNAM, 'Parent', [STMP]),
    wbFormIDCk(HNAM, 'Snap Template Behavior', [STBH]),
    wbRArray('Node Instancess',
      wbStruct(ENAM, 'Instance', [
        wbInteger('Instance ID', itU32),
        wbFormIDCk('Template Node', [STND]),
        wbVec3PosRotDegrees('Orientation', 'Offset', 'Rotation', 'Ofs:', 'Rot:'),
        wbInteger('Display Case Slot', itU32),
        wbUnknown(4)
      ])
      .SetSummaryKeyOnValue([0,1,2,3])
      .SetSummaryPrefixSuffixOnValue(0, '[', ']')
      .SetSummaryPrefixSuffixOnValue(1, '', '')
      .SetSummaryPrefixSuffixOnValue(2, '', '')
      .SetSummaryPrefixSuffixOnValue(3, '', '')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed)
    ),
    wbRArray('Inherited Overrides', wbRStruct('Parent Instance', [
      wbInteger(ONAM, 'Instance ID', itU32),
      wbVec3PosRotDegrees(TNAM, 'Transform Data')
    ], [])),
    wbStruct(BNAM, 'Bound Override', [
      wbVec3('Override -'),
      wbVec3('Override +')
    ])
      .SetSummaryKeyOnValue([0, 1])
      .IncludeFlag(dfCollapsed),
    wbVec3(GNAM, 'Origin Override'),
    wbInteger(INAM, 'Next Node ID', itU32),
    wbInteger(STPT, 'Snap Piece Type', itU32, wbEnum([
      'Invalid',
      'Starting Foundation',
      'Foundation',
      'Floor',
      'Stair',
      'Wall',
      'Roof'
    ])), // snap piece type: Invalid, Starting Foundation, Foundation, Floor, Stair, Wall, Roof
    //wbUnknown(SNFG)
    wbRArray('Traversal Categories', wbRStruct('Category', [
      wbString(CNAM, 'Name'),
      wbRStructsSK('Traversal Nodes', 'Node', [0], [
        wbFormIDCk(RNAM, 'Traversal', [TRAV]),
        wbRArrayS('Instances', wbInteger(SNAM, 'Instance ID', itU32))
      ], [])
    ], []))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(GCVR, 'Ground Cover', [
    wbEDID,
    wbBaseFormComponents,
    wbRArray('Grasses', wbRStruct('Grass', [
      wbFormIDCk(GNAM, 'Grass', [GRAS]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole),
      wbInteger(DNAM, 'Override Density', itS16).SetDefaultEditValue('-1')
    ], [])),
    wbRArray('Landscape Textures', wbFormIDCk(LNAM, 'Landscape Texture', [LTEX])),
    wbFloat(YNAM, 'Painted Material Threshold', cpNormal, True, 100.0, 0, nil, wbNormalizeToRange(0.1, 1.0))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(VOLI, 'Volumetric Lighting', [
    wbEDID,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PMFT, 'Photo Mode Feature', [
    wbEDID,
    wbFULL,
    wbCTDAs,
    wbStruct(FNAM, 'Data', [
      wbInteger('Type', itU8, wbPhotoModeEnum),
      wbFloat('X offset'),
      wbFloat('Y offset'),
      wbInteger('Texture Width', itU32),
      wbInteger('Texture Height', itU32),
      wbInteger('Content Width', itU32),
      wbInteger('Content Height', itU32),
      wbInteger('Flags', itU32, wbFlags([
        'Tile X',
        'Tile Y',
        'Top Most'
      ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
    ], cpNormal, True),
    wbString(HNAM, 'Texture'),
    wbFormIDCk(INAM, 'Image Space', [IMAD])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CHAL, 'Challenge', [
    wbEDID,
    wbBaseFormComponents
  ]);

  wbRecord(FXPD, 'Facial Expression', [
    wbEDID,
    wbFULL,
    wbRArray('Morphs', wbRStruct('Morph Data', [
        wbString(MNAM, 'Morph'),
        wbFloat(MWGT, 'Value')
    ], []))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CNDF, 'Condition Form', [
    wbEDID,
    wbCTDAs,
    wbFormIDCk(QNAM, 'Owner Quest', [QUST]),
    wbFormIDCk(PNAM, 'Owner Package', [PACK])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AOPF, 'Audio Occlusion Primitive', [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbFloat(OBSV, 'Obstruction'),
    wbFloat(OCCV, 'Occlusion')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PDCL, 'Projected Decal', [
    wbEDID,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbDEFL,
    wbXALG,
    wbBaseFormComponents,
    wbFormIDCk(DODT, 'Material', [MTPT]),
    wbStruct(DATA, 'Data', [
      { 0} wbFloat('Min Width'),
      { 4} wbFloat('Max Width'),
      { 8} wbFloat('Min Height'),
      {12} wbFloat('Max Height'),
      {16} wbFloat('Depth'),
      {20} wbFloat('Cutoff Angle (Degrees)')
    ])
  ]).SetSummaryKey([7]);

  {subrecords checked against Starfield.esm}
  wbRecord(CUR3, 'Curve 3D', [
    wbEDID,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(BMMO, 'Biome Marker',
    wbFlags(wbFlagsList([
      {0x00100000} 20, 'Calculate Once Per Location' //all occurences on prey/preditor BMMOs
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbBaseFormComponents,
    wbGenericModel(True),
    wbKeywords,
    wbCTDAs,
    wbFormIDCk(KNAM, 'Marker Type', [NULL, KYWD]).SetRequired,
    wbFormIDCk(LNAM, 'Fallback List', [NULL, LVLI]).SetRequired,
    wbFormIDCk(LNA2, 'Navmesh Object', [NULL, FLOR, PKIN, STAT]).SetRequired //probably any type of non-actor reference?
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(GBFT, 'Generic Base Form Template', [
    wbEDID,
    wbRArray('Components', wbString(STRV, 'Component'))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(GBFM, 'Generic Base Form',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Unique'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbBaseFormComponents,
    wbFLTR,
    wbFormIDCk(ANAM, 'Template', [GBFT]),
    wbRArray('Object Template Instance Data', wbString(STRV)),
    wbObjectTemplate,
    wbMarkerReq(STOP),
    wbMarkerReq(STOP),
    wbNVNM
  ]);

  {subrecords checked against Starfield.esm}
  var wbLeveledListEntryBaseForm :=
    wbRStructExSK([0], [1], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itU16),
        wbUnused(2),
        wbFormIDCk('Generic Base Form', [GBFM, LVLB]),
        wbInteger('Count', itS16),
        wbInteger('Chance None', itU8),
        wbUnused(1)
      ])
      .SetSummaryKeyOnValue([0, 3, 2, 4])
      .SetSummaryPrefixSuffixOnValue(0, '[Lv', ']')
      .SetSummaryPrefixSuffixOnValue(3, '', 'x')
      .SetSummaryPrefixSuffixOnValue(4, '{Chance None:', '%}')
      .SetSummaryDelimiterOnValue(' ')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
      .IncludeFlagOnValue(dfSummaryNoSortKey),
      wbCOED,
      wbCTDAs
    ], [])
    .SetSummaryMemberMaxDepth(0, 1)
    .IncludeFlag(dfCollapsed, wbCollapseLeveledItems);

  {subrecords checked against Starfield.esm}
  wbRecord(LVLB, 'Leveled Base Form',
    wbFlags(wbFlagsList([
      {0x00008000}  15, 'Calculate All (Still picks just one)'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbXALG,
    wbBaseFormComponents,
    wbLVLDReq,
    wbInteger(LVLM, 'Max Count', itU8, nil, cpNormal, True), { Always 00 } {Unavailable}
    wbInteger(LVLF, 'Flags', itU16, wbFlags([
      {0x0001} 'Calculate from all levels <= player''s level',
      {0x0002} 'Calculate for each item in count',
      {0x0004} 'Calculate All (Still picks just one)',
      {0x0008} 'Disable If Does Not Resolve 1',
      {0x0010} 'Disable If Does Not Resolve 2',
      {0x0020} '',
      {0x0040} 'Allow Shift Up',
      {0x0080} '',
      {0x0100} 'Do All Before Repeating',
      {0x0200} 'Contains Only Spaceship Base Forms'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbCTDAs,
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbLLCT.IncludeFlag(dfSkipImplicitEdit),
    wbRArrayS('Leveled List Entries', wbLeveledListEntryBaseForm, cpNormal, False, nil, wbLVLOsAfterSet),
    wbFilterKeywordChances,
    wbGenericModel(True)
  ], False, nil, cpNormal, False, nil, wbLLEAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(MAAM, 'Melee Aim Assist Model', [
    wbEDID,
    wbBaseFormComponents,
    wbStruct(SNAM, 'Data', [
      wbFloat('Inner Cone Angle Degrees'),
      wbFloat('Outer Cone Angle Degrees'),
      wbFloat('Steering Degrees Per Sec'),
      wbFloat('Acelleration Deg Per Sec'),
      wbFloat('Decelleration Deg Per Sec'),
      wbFloat('Actor Target Finder Max Distance'),
      wbInteger('Melee Aim Assist Enabled', itU8, wbBoolEnum),
      wbFloat('Max Capsule Angle For Vertical Aiming Correction Deg')
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(IRES, 'Resource', [
    wbEDID,
    wbBaseFormComponents,
    wbFULL,
    wbKeywords,
    wbCUSH,
    wbFormIDCk(FNAM, 'Surface Item', [LVLI]),
    wbInteger(SNAM, 'Rarity', itU32, wbEnum ([], [
        0, 'Common',
        1, 'Uncommon',
        2, 'Rare',
        3, 'Exotic',
        4, 'Unique',
        5, 'Special',
        6, 'Everywhere'
      ])),
    wbEmpty(ENAM, 'Veins have rounded end points'),
    wbRArray('Child Resources', wbFormIDCk(CNAM, 'Resource', [IRES])),
    wbByteColors(TINC, 'Surface color'), // not the color in the icons but that on the surface
    wbLStringKC(NNAM, 'Short Name', 0, cpTranslate),
    wbString(GNAM, 'Art Name'),
    wbFormIDCk(NAM1, 'Resource AV', [NULL, AVIF]),
    wbFormIDCk(NAM2, 'Resource Item', [NULL, LVLI, COBJ]),
    wbFormIDCK(NAM3, 'Production Interval (hours)', [NULL, GLOB])
  ]);

  var wbBIOMMaskNameStringEnum := wbStringEnum([
    'Base',
    'Solid',
    'FlatOuter',
    'FlatInner',
    'Talus',
    'Flow',
    'Path'
  ]);

  var wbBIOMMaskNamesEnum := wbEnum([
    'Base',
    'Solid',
    'FlatOuter',
    'FlatInner',
    'Talus',
    'Flow',
    'Path'
  ]);

  var wbBIOMBTPSStruct := function(aName: string = 'Unknown'): IwbValueDef
  begin
    Result := wbStruct(aName, [
      wbFloat('Noise Offset U'),
      wbFloat('Noise Offset V'),
      wbFloat('Noise Scale U').SetToStr(wbBIOMScaleToStr),
      wbFloat('Noise Scale V ').SetToStr(wbBIOMScaleToStr),
      wbFloat('Noise Contrast'),
      wbFloat('Alt Texture Coverage'),
      wbFloat('Alternate Data Contribution Min'),
      wbFloat('Alternate Data Contribution Max')
    ]);
  end;

  {subrecords checked against Starfield.esm}
  wbRecord(BIOM, 'Biome', [
    wbEDID.SetRequired,
    wbFULL,
    wbKeywords,
    wbString(SNAM, 'Filter String'),
    wbArrayS(PNAM, 'Flora', wbFormIDCk('Flora', [FLOR])).IncludeFlag(dfCollapsed),
    wbRArrayS('Resource Generation', wbFormIDCk(RNAM, 'Resource Generation Data', [RSGD])),
    wbRStructsSK('Procedural Object Generation', 'Mask', [0], [
      wbString(FNAM, 'Mask Name', 0, cpNormal, True)
        .SetFormaterOnValue(wbBIOMMaskNameStringEnum),
      wbUnknown(BNAM, cpNormal, True).SetDefaultEditValue('01 00 00 00'),  //Always 01 00 00 00 if it exists, probably a bool flag to load this mask. Only ever present if the mask is as well.
      wbRArrayS('Objects', wbStructSK(GNAM, [0], 'Object', [
        wbFormIDCk('Pack-In/Ref', [CONT, LVLP, PKIN, REFR]),
        wbStruct('Data', [
          wbUnknown(4),
          wbUnknown(4),
          wbUnknown(4),
          wbUnknown(4),
          wbFloat,
          wbUnknown(4),
          wbUnknown(4),
          wbUnknown(4),
          wbUnknown(4),
          wbUnknown(4),
          wbUnknown(4),
          wbUnknown(4),
          wbFloat,
          wbUnknown(4),
          wbFloat('Object Density'),
          wbFloat,
          wbUnknown(4),
          wbUnknown(4),
          wbUnknown(4),
          wbUnknown(4)
        ])
      ]), cpNormal, True),
      wbStruct(DNAM,'Footprints', [
        wbFloat('Giant'),
        wbFloat('Large'),
        wbFloat('Medium'),
        wbFloat('Small')
      ], cpNormal, True)
    ], []),
    wbRArrayS('Object Swaps', wbFormIDCk(ONAM, 'Object Swap', [OSWP])),
    wbRArrayS('Material Swaps', wbFormIDCk(NAM1, 'Material Swap', [LMSW])),
    wbFormIDCk(ENAM, 'Climate', [CLMT]),
    wbRStruct('Water Data', [
      wbInteger(MNAM, 'Has Water', itU8, wbBoolEnum), //implicit required
      wbFormIDCk(INAM, 'Water', [WATR]),
      wbString(JNAM, 'Water Material').SetRequired
    ], []).SetRequired,
    wbFloat(WNAM, 'Block Density Mult').SetDefaultEditValue('1.0').SetRequired,
    wbFloat(YNAM, 'Cell Density Mult').SetDefaultEditValue('1.0').SetRequired,
    wbFloat(UNAM, 'Scan Worldspace Mult').SetDefaultEditValue('1.0').SetRequired,
    wbFormIDCk(ZNAM, 'Child', [BIOM]),
    wbFormIDCk(BIAS, 'Ambience Set', [AMBS]),
    wbFormIDCk(BIMT, 'Music Type', [MUSC]),
    wbFormIDCk(NAM0,'Time of Day Data', [TODD]),
    wbFormIDCk(NNAM, 'Pattern Style', [PTST]),
    wbByteBGRA(CNAM, 'Color').SetRequired,
    wbByteBGRA(BMC1, 'Surface Color 1').SetRequired,
    wbByteBGRA(BMC2, 'Surface Color 2').SetRequired,
    wbByteBGRA(BMC3, 'Rock Tint').SetRequired,
    wbInteger(TNAM, 'Biome Type', itU32, wbEnum([
      'Default',
      'Ocean',
      'Polar',
      'Mountain',
      'Swamp',
      'Archipelago',
      'Gas Giant'
    ])).SetRequired,
    wbRStructs('Marker Objects Keywords', 'Marker Data', [
      wbFormIDCk(KNAM, 'Marker Type', [KYWD]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole),
      wbKeywords
    ], []),
//    wbRStructs('Terrain Data', 'Terrain Data', [
    wbRArrayS('Terrain Data', wbRUnion('Terrain Data', [
      wbStructSK(LNAM, [0, 1, 2], 'Main Data', [
        wbInteger('Mask', itU32, wbBIOMMaskNamesEnum),
        wbFormIDCk('Land Texture', [LTEX]),
        wbFormIDCk('Ground Cover', [NULL, GCVR])
      ]),
      wbStructSK(ANAM, [0, 1, 2], 'Alternate Data', [
        wbInteger('Mask', itU32, wbBIOMMaskNamesEnum),
        wbFormIDCk('Land Texture', [LTEX]),
        wbFormIDCk('Ground Cover', [GCVR, NULL])
      ]),
      wbString(TX00, 'Base - Noise Data Texture'),
      wbString(UX00, 'Flow - Noise Data Texture'),
      wbString(VX00, 'FlatOuter - Noise Data Texture'),
      wbString(WX00, 'FlatIn - Noise Data Texture'),
      wbString(XX00, 'Talus - Noise Data Texture'),
      wbString(YX00, 'Solid - Noise Data Texture')
    ], [])),
    wbString(TX16, 'Ground Layer Normal'),
    wbStruct(BTPS, 'Unknown Terrain Settings', [
      wbBIOMBTPSStruct('Base'),
      wbBIOMBTPSStruct('Flow'),
      wbBIOMBTPSStruct('FlatOut'),
      wbBIOMBTPSStruct('FlatIn'),
      wbBIOMBTPSStruct('Talus'),
      wbBIOMBTPSStruct('Solid'),
      wbBIOMBTPSStruct('Path?')
     ]).SetRequired,
    wbStruct(BDFS, 'Distant View', [
      wbFloat('Texture Offset U'),
      wbFloat('Texture Offset V'),
      wbFloat('Texture Scale U').SetToStr(wbBIOMScaleToStr),
      wbFloat('Texture Scale V').SetToStr(wbBIOMScaleToStr),
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat('Normal Strength'),
      wbFloat('Slope Start'),
      wbFloat('Slope Range')
      ], cpNormal, True),
    wbString(EFSD, 'Global Layer Material'),
    wbFormIDCk(NAM2, 'Block Density Mult Global', [NULL, GLOB]).SetRequired,
    wbFormIDCk(NAM3, 'Cell Density Mult Global', [NULL, GLOB]).SetRequired,
    wbFormIDCk(NAM4, 'Scan Worldspace Mult Global', [NULL, GLOB]).SetRequired
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AMBS, 'Ambience Set', [
    wbEDID,
    wbRStruct('Ambient Sounds', [
      wbInteger(ASAS, 'Count', itU32, nil, cpBenign, True).IncludeFlag(dfSkipImplicitEdit), //count
      wbRArray('Sounds', wbStruct(ASAE, 'Sound Events', [ // DO NOT SORT - this array appears deliberately ordered in CK
        wbSoundReference('Sound Event/Form'),
        wbArrayS('Weather Keywords', wbFormIDCk('Keyword', [KYWD]), -1).IncludeFlag(dfCollapsed),
        wbArrayS('Marker Keywords', wbFormIDCk('Keyword', [KYWD]), -1).IncludeFlag(dfCollapsed),
        wbWwiseGuid('Switch Group'),
        wbStruct('Re-evaluate Interval', [
          wbInteger('Use Custom Interval', itU8, wbBoolEnum),
          wbFloat('Interval (Seonds)')
        ])
          .SetSummaryKey([0, 1])
          .SetSummaryMemberPrefixSuffix(0, 'Use:(', ')')
          .SetSummaryMemberPrefixSuffix(1, 'Secs:(', ')')
          .SetSummaryDelimiter(', ')
          .IncludeFlag(dfCollapsed),
        wbArrayS('Planet Customization', wbStructSK([0, 1], 'Planet Data', [
          wbFormIDCk('Planet', [PNDT]),
          wbLenString('Switch State', 4)
            .SetFormater(wbStringEnum([
              'aggressive_rumble',
              'medium_rumble',
              'soft_rumble'
            ]))
            .IncludeFlag(dfHasZeroTerminator)
        ])
          .SetSummaryKey([0, 1])
          .SetSummaryDelimiter(', '), -1)
          .IncludeFlag(dfCollapsed)
      ]))
        .SetCountPath(ASAS)
        .SetRequired
    ], []),
    wbInteger(ASMB, 'Merge Behavior', itU8, wbEnum([
      'Override Parent',
      'Merge with Parent'
    ])).SetRequired,
    wbSoundReference(WED0, 'Walla Exterior')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AOPS, 'Aim Optical Sight Marker', [
    wbEDID,
    wbBaseFormComponents,
    wbStruct(ANAM, 'Data', [
      wbInteger('Activate Sight on Sighted Mode', itU8, wbBoolEnum),
      wbLenString('Otical Sight Attach Node'),
      wbFloat('Delay Before Sight Activation'),
      wbFloat('Delay Before Sight Deactivation'),
      wbFormIdCk('Optical Sight Light', [NULL, LIGH]),
      wbFloat('Focal Point Distance'),
      wbFloat('Focal Point Distance During Aiming'),
      wbFloat('Delay Between Shots'),
      wbFormIdCk('Laser Art Object', [ARTO, NULL]),
      wbFormIdCk('Laser Dot Art Object', [ARTO,  NULL]),
      wbFloat('Max Laser Pointer Distance'),
      wbInteger('Sight Controls Firing Direction', itU8, wbBoolEnum),
      wbInteger('Activate Sight on Non Sighted Mode', itU8, wbBoolEnum),
      wbInteger('Activate Sight on Scoped Mode', itU8, wbBoolEnum)
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ATMO, 'Atmosphere', [
    wbEDID,
    wbREFL,
    wbFormIDCk(RFDP, 'Reflection Parent', [ATMO]),
    wbRDIF
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AVMD, 'AVMS Data', [
    wbEDID,
    wbBaseFormComponents,
    wbAVMDMNAMReq,
    wbString(YNAM, 'Name').SetRequired,
    wbString(TNAM, 'Name').SetRequired,
    wbInteger(ITMC, 'Entry Count', itU32, nil, cpBenign).SetRequired.IncludeFlag(dfSkipImplicitEdit),
    wbRArray('Entries',
      wbRStruct('Entry', [
        wbString(LNAM, 'Name')
          .SetLinksToCallbackOnValue(function(const aElement: IwbElement): IwbElement
          begin
            Result := nil;

            var lContainer: IwbContainer;
            if not wbTryGetContainerFromUnion(aElement, lContainer) then
              Exit;

            if lContainer.ElementValues['...\MNAM'] <> 'Complex Group' then
              Exit;

            if lContainer.ElementExists['..\VNAM'] then
              Exit;

            var lAVMDName := aElement.NativeValue;
            if not VarIsStr(lAVMDName) then
              Exit;

            var lFile := aElement._File;
            if not Assigned(lFile) then
              Exit;

            Result := lFile.RecordFromIndexByKey[wbIdxSimpleGroup, lAVMDName];
            if not Assigned(Result) then
              Result := lFile.RecordFromIndexByKey[wbIdxComplexGroup, lAVMDName];
            if not Assigned(Result) then
              Result := lFile.RecordFromIndexByKey[wbIdxModulation, lAVMDName];
          end)
          .SetToStr(procedure(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType)
          begin
            var lContainer: IwbContainer;
            if not wbTryGetContainerFromUnion(aElement, lContainer) then
              Exit;

            if lContainer.ElementValues['...\MNAM'] <> 'Complex Group' then
              Exit;

            if lContainer.ElementExists['..\VNAM'] then
              Exit;

            wbToStringFromLinksToMainRecordName(aValue, aBasePtr, aEndPtr, aElement, aType);
          end),
        wbString(VNAM, 'Value')
          .SetLinksToCallbackOnValue(function(const aElement: IwbElement): IwbElement
          begin
            Result := nil;

            var lContainer: IwbContainer;
            if not wbTryGetContainerFromUnion(aElement, lContainer) then
              Exit;

            if lContainer.ElementValues['...\MNAM'] <> 'Complex Group' then
              Exit;

            var lAVMDNameValue := aElement.NativeValue;
            if not VarIsStr(lAVMDNameValue) then
              Exit;

            var lAVMDName: string := lAVMDNameValue;
            var lUnderlinePos := Pos('_', lAVMDName);
            if lUnderlinePos < 11 then
              Exit;

            var lPrefix := Copy(lAVMDName, 1, Pred(lUnderlinePos));

            var lIndex: TwbNamedIndex := -1;
            if lPrefix = 'SimpleGroup' then
              lIndex := wbIdxSimpleGroup
            else if lPrefix = 'ComplexGroup' then
              lIndex := wbIdxComplexGroup
            else if lPrefix = 'Modulation' then
              lIndex := wbIdxModulation;

            if lIndex < 0 then
              Exit;

            Delete(lAVMDName, 1, lUnderlinePos);

            if lAVMDName = '' then
              Exit;

            var lFile := aElement._File;
            if not Assigned(lFile) then
              Exit;

            Result := lFile.RecordFromIndexByKey[lIndex, lAVMDName];
          end)
          .SetToStr(procedure(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType)
          begin
            var lContainer: IwbContainer;
            if not wbTryGetContainerFromUnion(aElement, lContainer) then
              Exit;

            if lContainer.ElementValues['...\MNAM'] <> 'Complex Group' then
              Exit;

            wbToStringFromLinksToMainRecordName(aValue, aBasePtr, aEndPtr, aElement, aType);
          end)
          .SetDontShow(function(const aElement: IwbElement): Boolean
          begin
            var lContainer: IwbContainer;
            if not wbTryGetContainerFromUnion(aElement, lContainer) then
              Exit(False);
            Result := lContainer.ElementValues['...\MNAM'] = 'Modulation';
          end),
        wbByteABGR(NNAM, 'Color')
          .SetDontShow(function(const aElement: IwbElement): Boolean
          begin
            var lContainer: IwbContainer;
            if not wbTryGetContainerFromUnion(aElement, lContainer) then
              Exit(False);
            Result := lContainer.ElementValues['...\MNAM'] <> 'Modulation';
          end)
      ], [])
      .SetSummaryKey([2, 0, 1])
      .SetSummaryMemberPrefixSuffix(2, '', ' as')
      .SetSummaryMemberPrefixSuffix(0, '"', '"')
      .SetSummaryMemberPrefixSuffix(1, 'using ', '')
      .IncludeFlag(dfSummaryMembersNoName)
      .IncludeFlag(dfCollapsed)
    ).SetCountPath(ITMC),
    wbInteger(MODT, 'Texture Type', itU32, wbFlags([
          {0} '',
          {1} 'Rough',
          {2} 'Opacity',
          {3} 'Normal',
          {4} 'AO',
          {5} 'Metal',
          {6} 'Biome Conditions',
          {7} 'Emissive'
        ], True)
    ).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbFormIDCk(AVMP, 'AVMS Parent', [AVMD])
  ])
  .SetSummaryKey([2, 4, 6])
  .SetSummaryMemberPrefixSuffix(2, '[', ']')
  .SetBuildIndexKeys(procedure(const aMainRecord: IwbMainRecord; var aIndexKeys: TwbIndexKeys)
  begin
    var lType := aMainRecord.ElementNativeValues[MNAM];
    if not VarIsOrdinal(lType) then
      Exit;

    var lName := aMainRecord.ElementEditValues[TNAM];
    if lName = '' then
      Exit;

    case Integer(lType) of
      1: aIndexKeys.Keys[wbIdxSimpleGroup] := lName;
      2: aIndexKeys.Keys[wbIdxComplexGroup] := lName;
      3: aIndexKeys.Keys[wbIdxModulation] := lName;
    end;
  end)
  .IncludeFlag(dfSummaryMembersNoName);

  var wbBoneModAxisEnum := wbEnum([
    'X',
    'Y',
    'Z'
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(BMOD, 'Bone Modifier', [
    wbEDID,
    wbBaseFormComponents,
    wbStruct(DATA, 'Data', [
      wbLenString('Type')
        .SetFormater(wbStringEnum([
          'LookAtChain',
          'MorphDriver',
          'PoseDeformer',
          'SpringBone'
        ]))
        .SetAfterSet(wbUpdateSameParentUnions)
        .IncludeFlag(dfHasZeroTerminator),
      wbLenString('Driver').IncludeFlag(dfHasZeroTerminator),
      wbLenString('Target').IncludeFlag(dfHasZeroTerminator),
      wbFloat('Max Anim Distance'),
      wbUnion('Type Dependant Data', function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer
      begin
        Result := 0;
        var lContainer: IwbContainer;
        if not Supports(aElement, IwbContainer, lContainer) then
          Exit;
        var lType := lContainer.ElementEditValues['...\Type'];
        if SameText(lType, 'LookAtChain') then
          Result := 1
        else if SameText(lType, 'MorphDriver') then
          Result := 2
        else if SameText(lType, 'PoseDeformer') then
          Result := 3
        else if SameText(lType, 'SpringBone') then
          Result := 4;
      end, [
        wbStruct('Unknown', [
          wbUnknown
        ]),
        wbStruct('LookAtChain Data', [
          wbLenString('Chain End').IncludeFlag(dfHasZeroTerminator)
        ]),
        wbStruct('MorphDriver Data', [
          wbStruct('Vector', [
            wbFloat('X'),
            wbFloat('Y'),
            wbFloat('Z')
          ]),
          wbStruct('Radius', [
            wbFloat('Inner'),
            wbFloat('Outer')
          ]),
          wbInteger('Axis', itU8, wbBoneModAxisEnum)
        ]),
        wbStruct('PoseDeformer Data', [
          wbStruct('Vector', [
            wbFloat('X'),
            wbFloat('Y'),
            wbFloat('Z')
          ]),
          wbStruct('Position', [
            wbFloat('X'),
            wbFloat('Y'),
            wbFloat('Z')
          ]),
          wbStruct('Angle', [
            wbFloat('X'),
            wbFloat('Y'),
            wbFloat('Z')
          ]),
          wbStruct('Scale', [
            wbFloat('X'),
            wbFloat('Y'),
            wbFloat('Z')
          ]),
          wbStruct('Radius', [
            wbFloat('Inner'),
            wbFloat('Outer')
          ]),
          wbInteger('Axis', itU8, wbBoneModAxisEnum)
        ]),
        wbStruct('SpringBone Data', [
          wbStruct('Strength', [
            wbFloat('X'),
            wbFloat('Y'),
            wbFloat('Z')
          ]),
          wbFloat, // not listed in inspector
          wbStruct('Damp', [
            wbFloat('X'),
            wbFloat('Y'),
            wbFloat('Z')
          ]),
          wbFloat, // not listed in inspector
          wbStruct('Scale', [
            wbFloat('X'),
            wbFloat('Y'),
            wbFloat('Z')
          ]),
          wbFloat, // not listed in inspector
          wbStruct('MaxDist', [
            wbFloat('X'),
            wbFloat('Y'),
            wbFloat('Z')
          ]),
          wbUnknown(4), // not listed in inspector
          wbInteger('Look At Parent', itU8, wbBoolEnum)
        ])
      ])
      .IncludeFlag(dfMustBeUnion)
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CLDF, 'Clouds', [
    wbEDID,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(EFSQ, 'Effect Sequence', [
    wbEDID,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(FOGV, 'Fog Volume', [
    wbEDID,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(FORC, 'Force Data', [
    wbEDID,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(LMSW, 'Layered Material Swap', [
    wbEDID,
    wbBaseFormComponents,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  var wbLeveledListEntrySpaceCell :=
    wbRStructExSK([0], [1], 'Leveled List Entry', [
      wbStructExSK(LVLO, [0, 2], [3], 'Base Data', [
        wbInteger('Level', itU16),
        wbUnused(2),
        wbFormIDCk('Space Cell', [CELL, LVSC]),
        wbInteger('Count', itS16),
        wbInteger('Chance None', itU8),
        wbUnused(1)
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
  wbRecord(LVSC, 'Leveled Space Cell', [
    wbEDID,
    wbLVLDReq,
    wbInteger(LVLM, 'Max Count', itU8, nil, cpNormal, True), { Always 00 } {Unavailable}
    wbInteger(LVLF, 'Flags', itU16, wbFlags([
      {0x0001} '',
      {0x0002} '',
      {0x0004} '',
      {0x0008} '',
      {0x0010} '',
      {0x0020} '',
      {0x0040} '',
      {0x0080} '',
      {0x0100} 'Do All Before Repeating'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbCTDAs,
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntrySpaceCell, cpNormal, False, nil, wbLVLOsAfterSet)
  ], False, nil, cpNormal, False, nil, wbLLEAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(MRPH, 'Morphable Object', [
    wbEDID,
    wbString(TMPP, 'Target Morph Path'),
    wbString(TCMP, 'Target Chargen Morph Path'),
    wbString(BMPP, 'Bone Morph Definition File'),
    wbStruct(MOBC, 'Base Vertex Color', [
      wbInteger('Base Vertex Color', itU8),
      wbUnused(3)
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(MTPT, 'Material Path', [
    wbEDID,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(OSWP, 'Object Swap', [
    wbEDID,
    wbRArrayS('Swap Map', wbRStructSK([0,1], 'Item', [
      wbFormID(KNAM, 'Original Object'),
      wbFormID(VNAM, 'Replacement Object')
    ], []))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PCBN, 'Planet Content Manager Branch Node', [
    wbEDID,
    wbBaseFormComponents,
    wbInteger(NAM1, 'Node Type', itU32, wbEnum([
      '', // Root only for PCMT
      'Branch Node',
      'Content Node'
    ]), cpNormal, True),
    wbInteger(NAM2, 'Child Selection', itU32, wbEnum([
      'Random',
      'Stacked'
    ]), cpNormal, True),
    wbFormIDCk(NAM3, 'Count Curve', [CURV]),
    wbFormIDCk(NAM4, 'Distribution Curve', [CURV]),
    wbInteger(NAM5, 'Consume request even on failure', itU8, wbBoolEnum, cpNormal, True),
    wbRArray('Nodes', wbFormIDCk(PCCB, 'Node', [PCBN, PCCN])),
    wbCITCReq,
    wbCTDAsCount,
    wbKWDAs,
    wbFormIDCk(PRTN, 'Parent Node', [PCBN, PCMT, NULL]),
    wbFormIDCk(PRVN, 'Previous Node', [PCBN, NULL])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PCCN, 'Planet Content Manager Content Node', [
    wbEDID,
    wbBaseFormComponents,
    wbFormIDCk(PCCC, 'Content', [WRLD, LVLP, PKIN], False, cpNormal, True),
    wbEmpty(IOVR, 'Override Content Placement Properties and Conditions'),
    wbKWDAs,
    wbFormIDCk(PRTN, 'Parent Node', [PCBN, NULL]),
    wbFormIDCk(PRVN, 'Previous Node', [PCCN, NULL])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PCMT, 'Planet Content Manager Tree', [
    wbEDID.SetRequired,
    wbInteger(NAM1, 'Node Type', itU32, wbEnum(['Root']), cpIgnore, True),      // PCMT only has root type
    wbInteger(NAM2, 'Child Selection', itU32, wbEnum(['','Stacked']), cpNormal, True)
      .SetDefaultNativeValue(1),                                                // PCMT only allows stacked node
    wbInteger(NAM5, 'Consume request even on failure', itU8, wbBoolEnum, cpNormal, True), // PCMT does not allow changing flag to true
    wbRArray('Nodes', wbFormIDCk(PCCB, 'Node', [PCBN])),
    wbCITCReq,
    wbCTDAsCount,
    wbKWDAs
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PNDT, 'Planet',
    wbFlags(wbFlagsList([
      {0x00040000} 18, 'Compressed'
    ]), [18]), [
    wbEDID,
    wbBaseFormComponents,
    wbArray(CNAM, 'Master Worldspaces',
      wbStruct('Worldspace', [
        wbStruct('Position', [
          wbLatitudeDouble,
          wbLongitudeDouble
        ]).SetSummaryKey([0, 1])
          .SetSummaryMemberPrefixSuffix(0, '(', '')
          .SetSummaryMemberPrefixSuffix(1, '', ')')
          .SetSummaryDelimiter(', ')
          .IncludeFlag(dfSummaryMembersNoName)
          .IncludeFlag(dfCollapsed, wbCollapsePosRot),
        wbFormIDCk('Worldspace', [WRLD])
      ])
    ).SetRequired,
    wbArray(EOVR, 'Added Worldspaces',
      wbStruct('Worldspace', [
        wbStruct('Position', [
          wbLatitudeDouble,
          wbLongitudeDouble
        ]).SetSummaryKey([0, 1])
          .SetSummaryMemberPrefixSuffix(0, '(', '')
          .SetSummaryMemberPrefixSuffix(1, '', ')')
          .SetSummaryDelimiter(', ')
          .IncludeFlag(dfSummaryMembersNoName)
          .IncludeFlag(dfCollapsed, wbCollapsePosRot),
        wbFormIDCk('Worldspace', [WRLD]),
        wbByteArray('Unknown', 1)
      ]),
    0, nil, nil, cpBenign),
    wbRArray('Biomes',
      wbStructSK(PPBD, [0], 'Biome', [
        wbFormIDCK('Biome', [BIOM]),
        wbFloat('Chance'),
        wbUnknown(4),
        wbFormIDCk('Resource Generation', [NULL, RSGD]).IncludeFlag(dfSummaryExcludeNULL),
        wbArray('Fauna', wbFormIDCk('Fauna', [NPC_]), -1),
        wbArray('Keywords', wbFormIDCk('Keyword', [KYWD]), -1),
        wbStruct('Flora', [
          wbInteger('Count', itU32, nil, cpBenign).IncludeFlag(dfSkipImplicitEdit),
          wbInteger('Entry Size', itU32).SetDefaultNativeValue(9).IncludeFlag(dfSkipImplicitEdit),
          wbArray('Entries',
            wbStruct('Entry', [
              wbFormIDCk('Flora', [FLOR]),
              wbFormIDCk('Resource', [MISC]),
              wbInteger('Frequency', itU8)
            ])
          ).SetCountPath('Count', True)
           .SetSummaryName('Flora')
        ]).SetSummaryKey([2]),
        wbArray('Unknown',
          wbStruct('Unknown', [
            wbUnknown(4),
            wbUnknown(4),
            wbUnknown(4),
            wbUnknown(4)
          ]),
        -1)
      ]).SetSummaryKeyOnValue([1, 3, 4, 6])
        .SetSummaryPrefixSuffixOnValue(0, '', '')
        .SetSummaryPrefixSuffixOnValue(1, 'Chance: ', '%')
        .SetSummaryPrefixSuffixOnValue(3, '', '')
        .SetSummaryPrefixSuffixOnValue(4, '', '')
        .SetSummaryPrefixSuffixOnValue(6, '', '')
        .IncludeFlagOnValue(dfSummaryMembersNoName)
    ),
    wbFormIDCk(FNAM, 'Surface Tree', [NULL, SFTR]).SetRequired,
    wbFloat(GNAM, 'Scan Worldspace Multiplier').SetDefaultNativeValue(1.0).SetRequired,

    wbRStruct('Body', [
      wbMarkerReq(BDST),
      wbString(ANAM, 'Name', 0, cpNormal, True),
      wbString(XEMP, 'Environment Map'),
      wbInteger(CNAM, 'Body type', itU8, wbEnum([
        {0} 'Undefined',
        {1} 'Star',
        {2} 'Planet',
        {3} 'Moon',
        {4} 'Orbital',
        {5} 'Asteroid Belt',
        {6} 'Station'
      ]), cpNormal, True),
      wbStruct(DNAM, 'Space Cell', [
        wbLenString('Cell EditorID').IncludeFlag(dfHasZeroTerminator),
        wbInteger('Is Unique', itU8, wbBoolEnum)
      ], cpNormal, True),
      wbStruct(ENAM, 'Orbital Data', [
        wbDouble('Major Axis', cpNormal, False, 1, Low(Integer)),
        wbDouble('Minor Axis', cpNormal, False, 1, Low(Integer)),
        wbDouble('Aphelion', cpNormal, False, 1, Low(Integer)),
        wbDouble('Eccentricity', cpNormal, False, 1, Low(Integer)),
        wbDouble('Incline', cpNormal, False, 1, Low(Integer)).SetToStr(wbAngleToStr),
        wbDouble('Mean Orbit', cpNormal, False, 1, Low(Integer)),
        wbFloat('Axial Tilt').SetToStr(wbAngleToStr),
        wbFloat('Rotational Velocity'),
        wbFloatAngle('Start Angle'),
        wbFloatAngle('Perihelion Angle'),
        wbInteger('Apply Orbital Velocity', itU8, wbBoolEnum),
        wbInteger('Geostationary Orbit', itU8, wbBoolEnum),
        wbUnused(6) // all data appears to be stored as a sequence of doubles
      ], cpNormal, True),
      wbStruct(FNAM, 'Orbited Data', [
        wbDouble('Gravity Well', cpNormal, False, 1, Low(Integer)),
        wbFloat('Mass (in Earth Masses)', cpNormal, False, 1/5.972E24, 3),
        wbFloat('Radius in km'),
        wbFloat('Surface Gravity'),
        wbUnknown(4) // all data appears to be stored as a sequence of doubles
      ]),
      wbStruct(GNAM, 'Galaxy Data', [
        wbInteger('Star System ID', itu32, wbStarIDToStr, wbStrToStarID)
         .SetLinksToCallback(wbStarSystemLookupCallback()),
        wbInteger('Parent Planet ID', itu32),
        wbInteger('Planet ID', itu32)
      ]),
      wbStruct(HNAM, 'Unknown', [
        wbUnknown(4),
        wbLenString('Spectral Class').IncludeFlag(dfHasZeroTerminator),
        wbLenString('Catalogue ID').IncludeFlag(dfHasZeroTerminator),
        wbLenString('Life').IncludeFlag(dfHasZeroTerminator),
        wbLenString('Magnetosphere').IncludeFlag(dfHasZeroTerminator),
        wbLenString('Mass in kg').IncludeFlag(dfHasZeroTerminator),
        wbLenString('Type').IncludeFlag(dfHasZeroTerminator),
        wbLenString('Settled star').IncludeFlag(dfHasZeroTerminator), // This is "old" csv data and does not always use the correct ingame star name
        wbLenString('Special').IncludeFlag(dfHasZeroTerminator),
        wbDouble('Perihelion', cpNormal, False, 1, Low(Integer)),
        wbDouble('Star Dist', cpNormal, False, 1, Low(Integer)),
        wbFloat('Density'),
        wbFloat('Heat'),
        wbFloat('Hydro'),
        wbFloat('Inner HZ'),
        wbFloat('Outer HZ'),
        wbFloat('Peri. Angle'),
        wbUnknown(4),
        wbFloat('Start angle in deg'),
        wbFloat('Year length in days'),
        wbInteger('Asteroids', itu32),
        wbInteger('Geostationary', itu32, wbBoolEnum),
        wbInteger('Random Seed', itu32),
        wbInteger('Rings', itu32, wbBoolEnum)
      ]),
      wbStruct(INAM, 'Atmosphere Data', [
        wbFormIDCk('Atmosphere', [ATMO]),
        wbFloat('Avg Density Frac.'),
        wbFloat('Rayleight Scattering Coefficient'),
        wbFloat('Mie Scattering Coefficient')
      ]),
      wbStruct(KNAM, 'Biome Noise', [
        wbLenString('Noise Filename').IncludeFlag(dfHasZeroTerminator),
        wbDouble('Biome Frequency', cpNormal, False, 1, Low(Integer)),
        wbDouble('Terrain Height Frequency', cpNormal, False, 1, Low(Integer)),
        wbInteger('Noise Type', itU8),
        wbInteger('Terrain Height Seed', itS32),
        wbFloat('Terrain Max Height (m)')
      ]),
      wbInteger(NNAM, 'Player Knowlege', itU32,
        wbFlags(wbSparseFlags([
          0, 'Initial Scan',
          1, 'Visited',
          2, 'Entered System',
         31, 'Unknown 31'
        ]))
      ),
      wbMarkerReq(BDED)
    ], []),

    wbFloat(TEMP, 'Temperature in C'),
    wbFloat(DENS, 'Density'),
    wbFloat(PHLA, 'Perihelion Angle (Deg)'),
    wbInteger(RSCS, 'Resource Creation Seed', itS32)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PSDC, 'Particle System Define Collision', [ //PSDC -> EDID REFL  (9)
    wbEDID,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PTST, 'Surface Pattern Style', [ //PTST -> EDID  (46)
    wbEDID
  ]);

  var wbRSGDBiomeDataCommon := function(aName: string = 'Unknown'): IwbStructDef
  begin
    Result := wbStruct(aName, [
      wbFloat('Vein Nodes Min'),
      wbFloat('Vein Nodes Max'),
      wbFloat('Node Size Min'),
      wbFloat('Node Size Max'),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Max Angle Offset'),
      wbFloat('Chance to Appear'),
      wbFloat('Unknown'),
      wbFloat('Unknown')
    ]);
  end;

  var wbRSGDBiomeDataNotcommon := function(aName: string = 'Unknown'): IwbStructDef
  begin
    Result := wbStruct(aName, [
      wbFloat('Vein Nodes Min'),
      wbFloat('Vein Nodes Max'),
      wbFloat('Node Size Min'),
      wbFloat('Node Size Max'),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Max Node Offset'),
      wbFloat('Chance per Node'),
      wbFloat('Unknown'),
      wbFloat('Unknown')
    ]);
  end;

  var wbRSGDBCellData := function(aName: string = 'Unknown'): IwbStructDef
  begin
    Result := wbStruct(aName, [
      wbFloat('Vein Nodes Min'),
      wbFloat('Vein Nodes Max'),
      wbFloat('Node Size Min'),
      wbFloat('Node Size Max'),
      wbFloat('Segment Length Min'),
      wbFloat('Segment Length Max'),
      wbFloat('Max Angle Offset'),
      wbFloat('Chance to Appear'),
      wbFloat('Surface Item Chance None'),
      wbFloat('Blobbiness')
    ]);
  end;

  {subrecords checked against Starfield.esm}
  wbRecord(RSGD, 'Resource Generation Data', [
    wbEDID,
    wbRArray('Resources',
      wbRStruct('Resource', [
        wbFormIDCk(RNAM, 'Resource', [IRES], False, cpNormal, True),
        wbStruct(DNAM, 'Generation Data', [
          wbStruct('Biome', [
            wbRSGDBiomeDataCommon('Common'),
            wbRSGDBiomeDataNotcommon('Uncommon'),
            wbRSGDBiomeDataNotcommon('Rare'),
            wbRSGDBiomeDataNotcommon('Exotic'),
            wbRSGDBiomeDataNotcommon('Unique'),
            wbRSGDBiomeDataNotcommon('Special'),
            wbRSGDBiomeDataNotcommon('Everywhere')
          ]),
          wbStruct('Cell', [
            wbRSGDBCellData('Common'),
            wbRSGDBCellData('Uncommon'),
            wbRSGDBCellData('Rare'),
            wbRSGDBCellData('Exotic'),
            wbRSGDBCellData('Unique'),
            wbRSGDBCellData('Special'),
            wbRSGDBCellData('Everywhere')
          ])
        ], cpNormal, True) // structure appears to fixed size
      ], []))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(RSPJ, 'Research Project', [
    wbEDID,
    wbBaseFormComponents,
    wbFULL,
    wbDESC(),
    wbFormIDCk(BNAM,'Workbench Keyword', [KYWD]),
    wbCTDAs,
    wbStructs(FVPA, 'Required Items', 'Item', [
      wbFormIDCk('Item', [ALCH,AMMO,ARMO,BOOK,COBJ,IRES,KEYM,LIGH,LVLI,MISC,WEAP]),
      wbInteger('Required Count', itU32),
      wbFormIDCk('Curve Table', [CURV, NULL])
    ]),
    wbStructs(RQPK, 'Required Perks', 'Perk', [
      wbFormIDCk('Perk', [PERK]),
      wbInteger('Rank', itU32),
      wbFormIDCk('Curve Table', [CURV, NULL])
    ]),
    wbFormID(CNAM, 'Created Item'),
    wbInteger(NNAM, 'Number Created', itU16),
    wbFloat(SNAM, 'Sorting Priority'),
    wbInteger(TNAM, 'Tier', itU8,
      wbEnum([
        '0', '1', '2', '3', '4', '5'
      ])
    ).SetRequired,
    wbFormIDCk(KNAM,'Category Keyword', [KYWD]),
    wbRArray('Required Researches', wbFormIDCk(RNAM, 'Research', [RSPJ]))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SDLT, 'Secondary Damage List', [
    wbEDID,
    wbInteger(ITMC, 'Secondary List Count', itU32).SetRequired,
    wbRArray('Secondary Damages',
      wbRStruct('Secondary Damage', [
        wbFormIDCk(DAMA, 'Damage Type', [DMGT], False, cpNormal, True),
        wbFormIDCk(ACTV, 'Actor Value', [AVIF], False, cpNormal, True)
      ], []), cpNormal, False, nil, wbSDLTListAfterSet).SetRequired
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SFBK, 'Surface Block', [
    wbEDID,
    wbBaseFormComponents,
    wbString(ANAM, 'Data File'),
    wbStruct(DNAM, 'Size', [
      wbInteger('X', itU32),
      wbInteger('Y', itU32)
    ], cpNormal, True)
    .SetSummaryKeyOnValue([0, 1])
    .IncludeFlag(dfCollapsed),
    wbStruct(ENAM, 'Height', [
      wbFloat('Min'),
      wbFloat('Max')
    ], cpNormal, True)
    .SetSummaryKeyOnValue([0, 1])
    .IncludeFlag(dfCollapsed),
    wbArray(FNAM, 'Connections', wbInteger('Unknown', itS16)),
    wbInteger(GNAM, 'Rarity', itU8, wbEnum([
      'Common',
      'Uncommon',
      'Rare'
    ]), cpNormal, True),
    wbRStruct('Placement', [
      wbInteger(HNAM, 'Manual Alignment Value', itS16, nil, cpNormal, True),
      wbInteger(INAM, 'Manual Alignment Mode', itU8, wbEnum([
        'Relative',
        'Absolute'
      ]), cpNormal, True),
      wbInteger(JNAM, 'Grid Alignment Override', itU8, wbEnum([
        'Default (INI: Median)',
        'Min',
        'Max',
        'Average',
        'Median',
        'Percent'
      ])),
      wbInteger(KNAM, 'Grid Sampling Override', itU8, wbEnum([
        'Default (INI: Borders)',
        'Legacy',
        'Full',
        'Borders',
        'Corners'
      ]), cpNormal, True)
    ], [], cpNormal, True),
    wbFloat(WHGT, 'Water Height', cpNormal, True),
    wbString(NAM0, 'Source File'),
    wbString(NAM1),
    wbStruct(NAM2, 'Cell Min', [
      wbInteger('X', itS32),
      wbInteger('Y', itS32)
    ], cpNormal, True)
    .SetSummaryKeyOnValue([0, 1])
    .IncludeFlag(dfCollapsed, wbCollapsePlacement),
    wbStruct(NAM3, 'Cell Max', [
      wbInteger('X', itS32),
      wbInteger('Y', itS32)
    ], cpNormal, True)
    .SetSummaryKeyOnValue([0, 1])
    .IncludeFlag(dfCollapsed, wbCollapsePlacement),
    wbStruct(NAM4, 'Height Range', [
      wbFloat('Min'),
      wbFloat('Max')
    ], cpNormal, True)
    .SetSummaryKeyOnValue([0, 1])
    .IncludeFlag(dfCollapsed, wbCollapsePlacement),
    wbFormIDCk(NAM5, 'Source Block', [SFBK, NULL] )
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SFPC, 'Surface Pattern Config', [
    wbEDID,
    wbFormIDCk(ENAM, 'Surface Pattern Style', [NULL, PTST]).SetRequired,
    wbRStructs('Styles', 'Style', [
      wbString(BNAM, 'Style'),
      wbFloat(CNAM, 'Weight')
    ], []),
    wbStruct(DNAM, 'Rarity', [
      wbFloat('Common'),
      wbFloat('Uncommon'),
      wbFloat('Rare')
    ]).SetRequired
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SFPT, 'Surface Pattern', [
    wbEDID,
    wbBaseFormComponents,

    wbFormIDCk(CNAM, 'Surface Pattern Style', [NULL, PTST]).SetRequired,

    wbStruct(BNAM, 'Surface Blocks', [
      wbArray('Rows',
        wbArray('Columns',
          wbFormIDCk('Surface Block', [SFBK]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole)
        , 16).IncludeFlag(dfCollapsed)
      , 16)
      .IncludeFlag(dfCollapsed)
    ])
    .SetSummaryKeyOnValue([0])
    .IncludeFlag(dfCollapsed),
//    .SetRequired,

    wbStruct(FNAM, 'Surface Blocks', [
      wbArray('Rows',
        wbArray('Columns',
          wbFormIDCk('Surface Block', [SFBK]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole)
        , 16).IncludeFlag(dfCollapsed)
      , 16)
      .IncludeFlag(dfCollapsed)
    ])
    .SetSummaryKeyOnValue([0])
    .IncludeFlag(dfCollapsed)
    .SetRequired,

    wbStruct(GNAM, 'Surface Blocks', [
      wbArray('Rows',
        wbArray('Columns',
          wbInteger('Surface Block', itS8)
        , 16).IncludeFlag(dfCollapsed)
      , 16)
      .IncludeFlag(dfCollapsed)
    ])
    .SetSummaryKeyOnValue([0])
    .IncludeFlag(dfCollapsed)
    .SetRequired,

    wbArray(DNAM, 'Worldspaces', wbFormIDCk('Worldspace', [WRLD]))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SFTR, 'Surface Tree',
    wbFlags(wbFlagsList([
      4, 'Unknown 4',
     18, 'Compressed'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbUnknown(CNAM).SetRequired,
    wbUnknown(DNAM).SetRequired,

    wbArray(ENAM, 'Surface Patterns', wbFormIDCk('Surface Pattern', [SFPT]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole), 65536).IncludeFlag(dfCollapsed),
    wbArray(ENAM, 'Surface Patterns', wbFormIDCk('Surface Pattern', [SFPT]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole), 65536).IncludeFlag(dfCollapsed),

    wbRArray('Surface Pattern Data', wbRStruct('Surface Patterns', [
      wbArray(FNAM, 'Surface Patterns', wbFormIDCk('Surface Pattern', [SFPT]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole), 65536).IncludeFlag(dfCollapsed),
      wbArray(GNAM, 'Unknown', wbinteger('Unknown', itS8), 65536).IncludeFlag(dfCollapsed)
    ], []), 2),
    wbString(NAM1, 'Filter').SetRequired
  ]);

  var wbSPCHQuestStage :=
    function(aSignature: TwbSignature; const aName: string): IwbRecordMemberDef
    begin
      Result :=
        wbInteger(aSignature, aName, itS16,
          function(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string
          begin
            var lMainRecord: IwbMainRecord;

            if wbTryGetContainingMainRecord(aElement, lMainRecord) then begin
              var lElement := lMainRecord.ElementBySignature[SPQU];
              if not wbTryGetMainRecord(lElement, lMainRecord) then
                lMainRecord := nil;
            end else
              lMainRecord := nil;

            Result := wbQuestStageToStr(aInt, aElement, aType, 'Quest', lMainRecord, True);
          end,
        wbIntPrefixedStrToInt)
          .SetDefaultNativeValue(-1)
          .SetRequired;
    end;

  {subrecords checked against Starfield.esm}
  wbRecord(SPCH, 'Speech Challenge', [
    wbEDID,
    wbSPCHQuestStage(SPWI, 'Quest Stage on Win'),
    wbSPCHQuestStage(SPLO, 'Quest Stage on Loss'),
    wbEmpty(SRAN, 'Sequential Scenes'),
    wbEmpty(SGEN, 'Don''t Allow No Keyword Scenes'),
    wbFormIDCk(SPQU, 'Quest', [QUST], False, cpNormal, True),
    wbKeywords,
    wbArray(SPMA, 'Scenes', wbFormIDCk('Scene', [SCEN])),
    wbInteger(DIFF, 'Difficulty', itU16, wbEnum([
      'Easy',
      'Medium',
      'Hard'
    ]))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(STBH, 'Snap Template Behavior', [
    wbEDID,
    wbBaseFormComponents,
    wbRStructs('Behaviors', 'Behavior', [
      wbInteger(ENAM, 'Operation', itU32, wbEnum([
        'Replace',
        'Remove',
        'Add',
        'Foundation',
        'Disable Node'
      ])).SetRequired,
      wbFormIDCk(PNAM, 'Payload', sigBaseObjects + [FLST], sigBaseObjects).SetRequired,
      wbCITCReq,
      wbCTDAsCount,
      wbFormIDCk(UNAM, 'Snap Template Node', [NULL, STND]).SetRequired,
      wbFormIDCk(VNAM, 'Group Keyword', [NULL, KYWD]).SetRequired
    ], [])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(STDT, 'Star',
    wbFlags(wbFlagsList([  {flags not checked against Starfield}
      {0x10000000} 28, 'Starts Hidden',
      {0x20000000} 29, 'Always Display Name'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbKeywords,
    wbString(ANAM, 'Name'),
    wbVec3Pos(BNAM, 'System Parsec Location', 'Parsecs'),
    wbUnknown(ONAM),                                    //related to BGSOrbitalDataComponent_Component
    wbInteger(DNAM, 'System ID', itU32),
    wbByteColors(ENAM, 'Color'),
    wbFormIDCk(SNAM, 'Binary Star', [STDT]),
    wbFormIDCk(PNAM, 'Sun Preset', [SUNP]),
    wbFormIDCk(HNAM, 'Time of Day Data', [TODD]),
    wbSoundReference(WED0, 'Star Sound')
  ])
  .SetBuildIndexKeys(procedure(const aMainRecord: IwbMainRecord; var aIndexKeys: TwbIndexKeys)
  begin
    var lStarID := aMainRecord.ElementNativeValues[DNAM];
    if not VarIsOrdinal(lStarID) then
      Exit;

    aIndexKeys.Keys[wbIdxStarID] := lStarID;
  end);

  {subrecords checked against Starfield.esm}
  wbRecord(SUNP, 'Sun Preset', [
    wbEDID,
    wbREFL,
    wbFormIDCk(RFDP, 'Reflection Parent', [SUNP]),
    wbRDIF
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(TMLM, 'Terminal Menu', [
    wbEDID,
    wbVMADFragmentedTMLM,
    wbFULL,
    wbInteger(TMVT, 'Show Body Text', itU32, wbEnum([
      'Folder',
      'Document'
    ])),
    wbInteger(DNAM, 'Menu Button Style', itU8, wbFlags([
      {0x01} 'Can Be Desktop',
      {0x02} 'Use Long Kiosk Entry'
    ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(SNAM, 'Style', itU32, wbEnum([
      {0} 'Windows',
      {1} 'Kiosk'
    ])),
    wbLStringKC(INAM, 'Unknown', 0, cpTranslate, True),
    wbRStruct('Body Text', [
      wbInteger(BSIZ, 'Count', itU32, nil, cpBenign).IncludeFlag(dfSkipImplicitEdit),
      wbRStructs('Items', 'Item', [
        wbLStringKC(BTXT, 'Text', 0, cpTranslate, True),
        wbCTDAs,
        wbInteger(TPLT, 'Uses Templated Text', itU8, wbBoolEnum) // note that this is not set on text that uses aliases or script token replacement
      ], []).SetCountPath(BSIZ)
    ], []),
    wbRStruct('Menu Items', [
      wbInteger(ISIZ, 'Count', itU32, nil, cpBenign).IncludeFlag(dfSkipImplicitEdit),
      wbRStructs('Items', 'Item', [
        wbLStringKC(ITXT, 'Text', 0, cpTranslate, True),
        wbLStringKC(ISTX, 'Short Text', 0, cpTranslate, True), // sometimes icon label, sometimes debug text... weird
        wbStruct(ISET, 'Settings', [
          wbInteger('Type', itU16, wbEnum([
            'Display Text',
            'Submenu - TerminalMenu',
            'Action - Return to Desktop', // not present in starfield.esm
            'Action - Return to Previous',
            'Action - Force Redraw',
            'DataSlate - BOOK'
          ])).SetDefaultEditValue('Submenu - TerminalMenu')
          .SetAfterSet(wbTMLMTypeAfterSetCallback),
          wbUnused(2),
          wbInteger('Flags', itU8, wbFlags([
            {0x01} 'Template Item',
            {0x02} 'Starts Open',
            {0x04} 'Override Item Text',
            {0x08} 'Creates New Window'
          ])).IncludeFlag(dfCollapsed, wbCollapseFlags),
          wbUnused(3)
        ]).SetRequired(True),
        wbInteger(ITID, 'ID', itU16).SetRequired(True),
        wbXLOC,
        wbRUnion('Text/Submenu', wbTMLMTypeUnionDeciderCallback, [
            {0} wbLStringKC(UNAM, 'Display Text', 0, cpTranslate).SetRequired(True),
            {1} wbFormIDCk(TNAM, 'Submenu - TerminalMenu', [TMLM]).SetRequired(True),
            {2} wbFormIDCk(BNAM, 'DataSlate - BOOK', [BOOK]).SetRequired(True),
            {3} wbEmpty(NULL) // placeholder - can't actually be set
                .IncludeFlag(dfDontAssign)
                .IncludeFlag(dfDontSave)
          ], [], cpNormal, False, wbTMLMTypeDontShowCallback),
        wbCTDAs
      ], []).SetCountPath(ISIZ)
    ],[])
  ]);

  wbRecord(GPOF, 'Gameplay Option', [
    wbEDID.SetRequired,
    wbLStringKC(NNAM, 'Name').SetRequired,
    wbLStringKC(DNAM, 'Description').SetRequired,
    wbRStruct('Type Data', [
      wbInteger(TNAM, 'Type', itU8, wbEnum([
        'Bool',
        'Float'
      ]))
        .SetAfterSet(wbGPOFTypeAfterSetCallback)
        .SetRequired,
      wbRUnion('Type Dependent Data', function(const aContainer: IwbContainerElementRef): Integer
        begin
          Result := -1;
          if not Assigned(aContainer) then
            Exit;
          var lType := aContainer.ElementNativeValues[TNAM];
          if not VarIsOrdinal(lType) then
            Exit;
          Result := lType;
        end,
        [
          wbRStruct('Bool Data', [
            wbInteger(VNAM, 'Default Value', itU8, wbBoolEnum).SetRequired,
            wbInteger(WNAM, 'Default Value', itU8, wbBoolEnum).SetRequired,
            wbUnused(GPOD).IncludeFlag(dfDontAssign).IncludeFlag(dfDontSave) // only here to allow comparison alignment
          ], [], cpNormal, True),
          wbRStruct('Float Data', [
            wbFloat(VNAM, 'Default Value').SetRequired,
            wbFloat(WNAM, 'Default Value').SetRequired,
            wbStruct(GPOD, 'Data Range', [
              wbFloat('Min'),
              wbFloat('Max'),
              wbFloat('Step')
            ], cpNormal, True)
          ], [], cpNormal, True)
        ], [], cpNormal, True)
      ], [], cpNormal, True),
    wbRStructs('Rewards', 'Reward', [
      wbLStringKC(VOVS, 'Description'),
      wbFloat(VORV, 'Setting Value'),
      wbLStringKC(RESN, 'Name'),
      wbFloat(VORN, 'Reward Value')
    ], []),
    wbKWDAs
  ]);

  wbRecord(GPOG, 'Gameplay Options Group', [
    wbEDID.SetRequired,
    wbLStringKC(NNAM, 'Name').SetRequired,
    wbRStruct('Type Data', [
      wbInteger(BNAM, 'Root Group', itU8, wbBoolEnum)
        .SetAfterSet(wbGPOGTypeAfterSetCallback)
        .SetRequired,
      wbRUnion('Type Dependent Options', function(const aContainer: IwbContainerElementRef): Integer
        begin
          Result := -1;
          if not Assigned(aContainer) then
            Exit;
          var lType := aContainer.ElementNativeValues[BNAM];
          if not VarIsOrdinal(lType) then
            Exit;
          Result := lType;
        end,
        [
          wbArray(GOGL, 'Gameplay Options', wbFormIDCk('Gameplay Option', [GPOF])), // intentionally not sorted as CK allows deliberate ordering
          wbArray(GOGL, 'Gameplay Option Groups', wbFormIDCk('Gameplay Option Gropu', [GPOG])) // intentionally not sorted as CK allows deliberate ordering
        ], [], cpNormal, True).IncludeFlag(dfUnionStaticResolve)
    ], [], cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(TODD, 'Time Of Day Data', [
    wbEDID,
    wbBaseFormComponents,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(TRAV, 'Traversal', [
    wbEDID,
    wbBaseFormComponents,
    wbStruct(DNAM, 'Data', [
      wbInteger('Type', itU32, wbEnum([
        {0} 'Jump',
        {1} 'Jump Up',
        {2} 'Jump Down',
        {3} 'Vault',
        {4} 'Ladder',
        {5} 'Doorway',
        {6} 'Activate'
      ])),
      wbFloat('Min Height'),
      wbFloat('Max Height'),
      wbInteger('Unknown', itU32)
    ])
  ]);

  var wbWMKFDecider := function:TwbRUnionDecider
  begin
    Result := function(const aContainer: IwbContainerElementRef): Integer
    begin
      Result := -1;
        var lContainer := aContainer.ContainingMainRecord;
        var lType := lContainer.ElementBySignature[WMTI];
        if Assigned(lType) then
          Result := lType.NativeValue;
    end;
  end;

  {subrecords checked against Starfield.esm}
  // TESDataHandlerPersistentCreatedUtil::BGSPersistentIDsForm
  wbRecord(PERS, 'Unknown', [
    wbInteger(DATA, 'Unknown', itU32),
    wbRArray('Unknown', wbStructs(DAT2, 'Unknown', 'Unknown', [
      wbFormID('Unknown'),
      wbUnknown(4),
      wbUnknown(4)
    ])).IncludeFlag(dfExcludeFromBuildRef)
  ]);

  wbRegisterResourcesLoadedHandler(procedure
  begin
    var lSoundbankInfo := wbContainerHandler.OpenResourceData('', 'sound\soundbanks\soundbanksinfo.json');
    if Length(lSoundbankInfo) > 0 then begin
      wbProgress('Loading Wwise Soundbank Info...');
      wbWwiseSoundbankInfo := TJSONObject.Create;
      try
        wbWwiseSoundbankInfo.FromUtf8JSON(PByte(@lSoundbankInfo[0]), Length(lSoundbankInfo));
        wbProgress('Building Wwise GUID Index...');

        wbWwiseGUIDs := TwbWwiseGUIDsDicationary.Create(20000);
        wbWwiseSoundbankInfo.Iterate(procedure(aContainer: TJsonBaseObject)
        begin
          if not (aContainer is TJsonObject) then
            Exit;
          var lObject := TJsonObject(aContainer);
          var lGUIDString := lObject.S['GUID'];
          if lGUIDString = '' then
            Exit;

          var lGUID := StringToGUID(lGUIDString);

          if not wbWwiseGUIDs.TryAdd(lGUID, lObject) then begin

            var lName := lObject.S['Name'];
            if lName <> '' then begin
              var lExistingObject: TJsonObject;
              if wbWwiseGUIDs.TryGetValue(lGUID, lExistingObject) then begin
                var lExistingName := lExistingObject.S['Name'];
                if lExistingName = '' then begin
                  wbWwiseGUIDs.Remove(lGUID);
                  wbWwiseGUIDs.Add(lGUID, lObject);
                end else if lName <> lExistingName then begin
                  wbProgress('Warning: Multiple names for GUID %s: [%s] <> [%s]', [lGUIDString, lExistingName, LNAM]);
                end;
              end;
            end;
          end;
        end);
        wbProgress('Indexed %d GUIDs successfully.', [wbWwiseGUIDs.Count]);

        with TStringList.Create do try
          for var lObject in wbWwiseGUIDs.Values do begin
            var lGuid := lObject.S['GUID'];
            var lName := lObject.S['Name'];
            var lObjectPath := lObject.S['ObjectPath'];

            if lGuid <> '' then begin
              if lName <> '' then
                lGuid := lName + ' ' + lGuid;
              if lObjectPath <> '' then begin
                if Length(lObjectPath) > 64 then begin
                  SetLength(lObjectPath, 61);
                  lObjectPath := lObjectPath + '...';
                end;

                lGuid := lGuid + ' "' + lObjectPath + '"';
              end;
              Add(lGuid);
            end;
          end;
          Sort;
          wbWwiseGuidEditInfo := ToStringArray;
        finally
          Free;
        end;

      except
        on E: Exception do begin
//          FreeAndNil(wbWwiseGUIDs);
//          FreeAndNil(wbWwiseSoundbankInfo);
          wbProgress('Error: Loading Wwise Soundbank Info failed: [%s] %s', [E.ClassName, E.Message]);
        end;
      end;
    end else
      wbProgress('Warning: Could not find Wwise Soundbank Info.');
  end);

  {subrecords checked against Starfield.esm}
  wbRecord(WATR, 'Water', [
    wbEDID,
    wbFULL,
    wbInteger(ANAM, 'Opacity (unused)', itU8),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      {0x01} 'Dangerous',
      {0x02} '',
      {0x04} 'Directional Sound',
      {0x08} 'Enable Flowmap',
      {0x10} 'Blend Normals'
    ]), cpNormal, True).IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbSoundReference(WASH),
    wbFormIDCk(XNAM, 'Consume Spell', [SPEL]),
    wbFormIDCk(YNAM, 'Contact Spell', [SPEL]),
    wbFormIDCk(INAM, 'Image Space', [IMGS]),
    wbUnused(DATA, True),
    wbStruct(DNAM, 'Visual Data', [
      wbFloat('Depth Amount'),
      wbStruct('Color Absorbtion Ranges', [
        wbFloat('Red'),
        wbFloat('Green'),
        wbFloat('Blue')
      ]),
      wbStruct('Concentration Properties', [
        wbFloat('Phytoplankton'),
        wbFloat('Sediment'),
        wbFloat('Yellow Matter'),
        wbFloat('Oceanness')
      ]),
      wbStruct('Underwater Properties', [
        wbByteColors('Color'),
        wbFloat('Fog Amount'),
        wbFloat('Near Fog'),
        wbFloat('Far Fog')
      ]),
      wbStruct('Surface Effects', [
        wbFloat('Normal Magnitude'),
        wbFloat('Shallow Normal Falloff'),
        wbFloat('Deep Normal Falloff'),
        wbFloat('Surface Effect Falloff')
      ]),
      wbStruct('Displacement Simulator', [
        wbFloat('Force'),
        wbFloat('Velocity'),
        wbFloat('Falloff'),
        wbFloat('Dampener'),
        wbFloat('Starting Size')
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
      wbFloat('Flowmap Scale'),
      wbFloat('Roughnes')
    ], cpNormal, True),
    wbUnused(GNAM, 12),
    wbVec3(NAM0, 'Linear Velocity'),
    wbVec3(NAM1, 'Angular Velocity'),
    wbFormIDCk(ENAM, 'River Absorption Curve', [CUR3]),
    wbFormIDCk(HNAM, 'Ocean Absorption Curve', [CUR3]),
    wbFormIDCk(JNAM, 'River Scattering Curve', [CUR3]),
    wbFormIDCk(LNAM, 'Ocean Scattering Curve', [CUR3]),
    wbFormIDCk(MNAM, 'Phytoplankton Curve', [CUR3]),
    wbFormIDCk(QNAM, 'Sediment Curve', [CUR3]),
    wbFormIDCk(UNAM, 'Yellow-Matter Curve', [CUR3])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(WEAP, 'Weapon',
    wbFlags(wbFlagsList([
      {0x00000004}  2, 'Non-Playable',
      {0x20000000} 30, 'High-Res 1st Person Only'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTYReq,
    wbOPDS,
    wbPTT2,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(True),
    wbEITM,
    wbInteger(EAMT, 'Enchantment Amount', itU16),
    wbDEST,
    wbETYP,
    wbFormIDCk(BIDS, 'Block Bash Impact Data Set', [IPDS, NULL]),
    wbFormIDCk(BAMT, 'Alternate Block Material', [MATT, NULL]),
    wbPUSH,
    wbPDSH,
    wbKeywords,
    wbDESC(),
    wbFormIDCk(INRD, 'Instance Naming', [INNR]),
    wbAPPR,
    wbObjectTemplate,
    wbEmpty(STOP, 'Marker', cpNormal, True),
    wbFormIDCk(NNAM, 'Embedded Weapon Mod', [NULL, OMOD]),
    wbEmpty(BNAM, 'Is Embedded Weapon'),
    wbStruct(WAIM, 'Aim', [
      wbFloat('Sighted Transition (Seconds)'),
      wbFormIDCk('Aim Down Sight Template', [NULL, ZOOM]),
      wbFormIDCk('Aim Model', [NULL, AMDL]),
      wbInteger('Accuracy Bonus', itS8),
      wbInteger('Has Scope', itU8, wbBoolEnum),
      wbFormIDCk('Aim Assist Template', [NULL, AAMD]),
      wbFormIDCk('Aim Optical Sight Model', [NULL, AOPS]),
      wbFormIDCk('Melee Aim Assist Model', [NULL, MAAM]),
      wbInteger('Update Advanced Aim Info', itU8, wbBoolEnum),
      wbInteger('Enable Orient Fire Nodes To Aiming Direction', itU8, wbBoolEnum),
      wbInteger('Enable Marking Targets', itU8, wbBoolEnum),
      wbInteger('Reticle Type', itU32, wbEnum([
        'None',
        'Unarmed',
        'Pistol',
        'Shotgun',
        'Rifle',
        'Laser',
        'Tool',
        'Custom Crosshair 1'
      ])),                                                //enum
      wbInteger('Inverse Reticle Spread', itU8, wbBoolEnum),
      wbInteger('Displayed Reticle on UI Ignores Player Movement', itU8, wbBoolEnum)
     ]),
    wbStruct(WAM2, 'Ammunition', [
      wbFormIDCk('Ammo Type', [NULL, AMMO]),
      wbInteger('Ammo Capacity', itu32),
      wbFormIDCk('Ammo List', [NULL, LVLI]),
      wbFormIDCk('Override Projectile', [NULL, PROJ]),
      wbFormIDCk('Override Shell Casing', [NULL, ARTO]),
      wbInteger('Projectiles Count', itU8),
      wbInteger('NPCs Use Ammo', itU8, wbBoolEnum),
      wbInteger('Number of Impact Sounds', itU8)
    ]),
    wbStruct(WAUD, 'Audio', [
      wbSoundReference('Attack Sound'),
      wbSoundReference('Throwable Primed Sound'),
      wbSoundReference('Attack Fail Sound'),
      wbSoundReference('Idle Sound'),
      wbSoundReference('Equip Sound'),
      wbSoundReference('Unequip Sound'),
      wbSoundReference('Fast Equip Sound'),
      wbInteger('Sound Level', itU32, wbSoundLevelEnum),
      wbInteger('Melee Detection Sound Level', itU32, wbSoundLevelEnum)
    ]),
    wbStruct(WTUR, 'Turret', [
      wbInteger('Enabled', itU8, wbBoolEnum),
      wbStruct('Heading', [
        wbFloat('Min'),
        wbFloat('Max')
      ]),
      wbStruct('Pitch', [
        wbFloat('Min'),
        wbFloat('Max')
      ]),
      wbFloat('Heading Speed'),
      wbFloat('Pitch Speed'),
      wbFloat('Accuracy')
    ]),
    wbStruct(WCHG, 'Charge Data', [
      wbFloat('Full Power (Seconds)'),
      wbFloat('Min Power Per Shot'),
      wbFloat('Crit Charge Bonus'),
      wbInteger('Hold Input', itU8, wbBoolEnum),
      wbInteger('Charging Attack Enabled', itU8, wbBoolEnum)
    ]),
    wbStruct(WDMG, 'Damage', [
      wbFloat('Base Damage'),
      wbFloat('Range - Min'),
      wbFloat('Range - Max'),
      wbFloat('Out of Range Damage Mult'),
      wbFloat('Crit Damage Mult'),
      wbFormIDCk('Crit Effect (Spell)', [NULL, SPEL]),
      wbInteger('Crit Effect on Death Only', itU8, wbBoolEnum),
      wbInteger('Hit Behavior', itU8, wbHitBehaviourEnum),
      wbFormIDCk('Resistance', [NULL, AVIF]),
      wbFormIDCk('Skill', [NULL, AVIF]),
      wbStruct('Low Gravity', [
        wbFloat('Scale Control Point'),
        wbStruct('Range Multipler at Control Point', [
          wbFloat('Min'),
          wbFloat('Max')
        ])
      ]),
      wbStruct('High Gravity', [
        wbFloat('Scale Control Point'),
        wbStruct('Range Multipler at Control Point', [
          wbFloat('Min'),
          wbFloat('Max')
        ])
      ]),
      wbFloat('Crit Chance Inc Mult')
    ]),
    wbDamageTypeArray('Damage Type'),
    wbStruct(WFIR, 'Firing', [
      wbInteger('Firing Type', itU8, wbEnum([
        {0} 'Single or Binary',
        {1} 'Burst',
        {2} 'Automatic'
      ])),
      wbInteger('Burst count', itU8),
      wbInteger('Repeatable Fire', itU8, wbBoolEnum),
      wbFloat('Attack (Seconds)'),
      wbFloat('Fire (Seconds)'),
      wbFloat('Attack Delay (Seconds)'),
      wbFloat('Bolt Charge (Seconds)'),
      wbInteger('Bolt Action', itU8, wbBoolEnum),
      wbInteger('Disable ShellCase Eject', itU8, wbBoolEnum),
      wbFloat('Shots Per Second'),
      wbFloat('Weapon Attack Animation Duration'), // contains same value as Attack Delay Seconds CK matches both values as updated
      wbInteger('Override Rate of Fire', itU8, wbBoolEnum),
      wbFloat('Trigger Threshold - Primary Trigger'),
      wbInteger('Override Trigger Threshold', itU8, wbBoolEnum),
      wbFloat('Trigger Threshold - Second Stage'),
      wbInteger('Use Staged Trigger', itU8, wbBoolEnum),
      wbInteger('Has Dual Trigger', itU8, wbBoolEnum),
      wbFloat('Burst Delay (Seconds)')
    ]),
    wbStruct(WFLG, 'Flags', [
      wbInteger('Non-Playable', itU8, wbBoolEnum),
      wbInteger('Player Only', itU8, wbBoolEnum),
      wbInteger('Prevent Use In Normal Combat', itU8, wbBoolEnum),
      wbInteger('Is Secondary', itU8, wbBoolEnum),

      wbInteger('Can''t Drop', itU8, wbBoolEnum),
      wbInteger('Minor Crime', itU8, wbBoolEnum),
      wbInteger('Non-Hostile', itU8, wbBoolEnum),
      wbInteger('Bound', itU8, wbBoolEnum),

      wbInteger('NPC Prefers Long Bursts', itU8, wbBoolEnum),
      wbInteger('NPCs Only Fire When Magazine Full', itU8, wbBoolEnum),
      wbInteger('Use Sequential Fire Nodes', itU8, wbBoolEnum),
      wbInteger('Use Random Fire Nodes', itU8, wbBoolEnum)
    ]),
    wbStruct(WGEN, 'General', [
      wbInteger('Type', itu32, wbTypeEnum),
      wbFloat('Base weight'),
      wbInteger('Base value', itu32),
      wbFloat('Base Speed'),
      wbFloat('Attack Oxygen Cost'),
      wbFormIDCk('Weapon Barrel', [NULL, WBAR])
    ]),
    wbLStringKC(WABB, 'Abbreviation', 0, cpTranslate),
    wbStruct(WMEL, 'Melee', [
      wbInteger('Attack Speed', itU8, wbAttackSpeedEnum),
      wbFloat('Bash Damage'),
      wbFloat('Reach'),
      wbInteger('Stagger', itU32, wbStaggerEnum)
    ]),
    wbStruct(QNAM, 'Power', [
      { 0} wbFormIDCK('Power', [NULL, AVIF]),
      { 4} wbFloat('Recharge time'),
      { 8} wbFloat('Recharge delay'),
      {12} wbInteger('Consume Ammo', itU8, wbBoolEnum),
      {13} wbFormIDCK('Power - Bonus', [NULL, AVIF]),
      {17} wbInteger('Use Power', itU8, wbBoolEnum),
      {18} wbInteger('Variable Power Enabled', itU8, wbBoolEnum),
      {19} wbFloat('Variable Power Transition Duration'),
      {23} wbInteger('Use Charge Only In Focus Mode', itU8, wbBoolEnum),
      {24} wbFormIDCK('Power Intensity Curve', [NULL, CURV]),
      {28} wbFloat('Power Damage Multiplier'),
      {32} wbFormIDCK('Power Consumption Multiplier Curve', [NULL, CURV])
    ]),
    wbStruct(WRLO, 'Reload', [
      wbFloat('Reload Seconds'),
      wbFloat('Reload Speed'),
      wbInteger('Charging', itU8, wbBoolEnum),
      wbInteger('Single', itU8, wbBoolEnum)
    ]),
    wbStruct(WVAR, 'Variable Range', [
        wbStruct('Aperture', [
          { 0} wbFloat('Value - Min'),
          { 4} wbFloat('Value - Max'),
          { 8} wbFloat('Input - Min'),
          {12} wbFloat('Input - Max'),
          {16} wbFloat('Acceleration'),
          {20} wbFloat('Deceleration')
        ]),
        wbStruct('Distance', [
          {24} wbFloat('Value - Min'),
          {28} wbFloat('Value - Max'),
          {32} wbFloat('Input - Min'),
          {36} wbFloat('Input - Max'),
          {40} wbFloat('Acceleration'),
          {44} wbFloat('Deceleration')
      ]),
        {48} wbInteger('Use Variable Range', itU8, wbBoolEnum)
    ]),
    wbRStruct('1st Person Model', [
      wbString(MOD4, 'Model FileName'),
      wbUnknown(MO4C),
      wbFLLD,
      wbFloat(MO4S, 'Color Remapping Index')
    ], []).IncludeFlag(dfAllowAnyMember),
    wbStruct(WVIS, 'Art Visuals Data', [
      wbStruct('First Person Offset', [                        //Data where used looks like three sets of 4, but this is speculation. Only ever has a value in the 4th of each set, and that value is always 128
        { 0} wbFloat('X'),
        { 4} wbFloat('Y'),
        { 8} wbFloat('Z')
      ]),
      {12} wbFormIDCk('Impact Data Set', [NULL, IPDS]),
      {16} wbFloat('Color Remapping Index'),
      {20} wbFormIDCK('Image Space Adapter', [NULL, IMAD])
    ]),                 // impact colour, maybe? if so it's the same for all weaps in Starfield.esm
    wbStruct(WTRM, 'Ship Weapon', [
      { 0} wbFloat('Attack Action Point Cost'),
      { 4} wbInteger('Override Default Camera Shake', itU8, wbBoolEnum),
      { 5} wbFloat('Firing Camera Shake Intensity'),
      { 9} wbFloat('Firing Camera Shake Duration'),
      {13} wbFloat('AI Firing Arc')
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(WBAR, 'Weapon Barrel Model', [
    wbEDID,
    wbBaseFormComponents,
    wbStruct(ZNAM, 'Data', [
      wbInteger('Support Gun Down State', itU8, wbBoolEnum),
      wbFloat('Distance From Wall'),
      wbFloat('GunUp to GunDown Transition Duration (s)'),
      wbFloat('GunDown to GunUp Transition Duration (s)')
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(WTHR, 'Weather',
    wbFlags(wbFlagsList([
      9, 'Unknown 9'
    ])), [
    wbEDID.SetRequired,
    wbKeywords,
    wbInteger(LNAM, 'Max Cloud Layers', itU32)
      .SetDefaultNativeValue(0)
      .SetRequired,
    wbFormIDCK(MNAM, 'Precipitation Type', [SPGD, NULL])
      .SetRequired,
    wbFormIDCK(NNAM, 'Visual Effect', [ARTO, NULL])
      .SetRequired,
    wbFormIDCK(CLDC, 'Cloud Type', [CLDF, NULL])
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
      wbInteger('Thunder/Lightning - Frequency', itU8),
      wbInteger('Flags', itU8,
        wbFlags(wbSparseFlags([
          0, 'Weather - Pleasant',
          1, 'Weather - Cloudy',
          2, 'Weather - Rainy',
          3, 'Weather - Snow',
          4, 'Sky Statics - Always Visible',
          5, 'Sky Statics - Follows Sun Position',
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
    wbRStruct('Sounds', [
      wbInteger(WSLS, 'Sounds Count', itU32),
      wbRArray('Sounds',
        wbStruct(WSLD, 'Sound', [
          wbSoundReference,
          wbUnknown(4)
        ])
      ).SetCountPath(WSLS)
    ], []),
    wbRArrayS('Sky Statics',
      wbFormIDCk(TNAM, 'Static', [STAT, NULL])
    ),
    wbWeatherImageSpaces,
    wbWeatherVolumetricLighting
      .SetRequired,
    wbWeatherDirectionalLighting,
    wbRStruct('Aurora', [
      wbGenericModel(True)
    ], []).SetRequired,
    wbFormIDCk(GNAM, 'Sun Glare Lens Flare', [LENS]),
    wbWeatherMagic,
    wbFloat(VNAM, 'Volatility Mult')
      .SetDefaultNativeValue(1)
      .SetRequired, //Form Version 126+
    wbFloat(WNAM, 'Visibility Mult')
      .SetDefaultNativeValue(1)
      .SetRequired  //Form Version 126+
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(WTHS, 'Weather Settings', [
    wbEDID,
    wbREFL,
    wbFormIDCk(RFDP, 'Reflection Parent', [WTHS]),
    wbRDIF
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(WRLD, 'Worldspace',
    wbFlags(wbFlagsList([
       2, 'Unique',
      14, 'Partial Form',
      19, 'Can''t Wait'
    ]), [14]), [
    wbEDID,
    wbBaseFormComponents,
    wbWorldLargeRefs,
    wbWorldMaxHeight,
    wbFULL,
    wbWorldFixedCenter,
    wbFormIDCk(XLCN, 'Location', [LCTN]),
    wbFormIDCk(BNAM, 'Biome', [BIOM]),
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
    ], []),
    wbFormIDCk(CNAM, 'Climate', [CLMT])
      .SetDefaultNativeValue(351)
      .SetIsRemovable(wbWorldClimateIsRemovable),
    wbFormIDCk(NAM2, 'Water', [WATR])
      .SetDefaultNativeValue(24)
      .SetIsRemovable(wbWorldWaterIsRemovable),
    wbString(NAM7, 'Water Material'),
    wbWorldLODData,
    wbWorldLandData,
    wbString(ICON, 'Map Image'),
    wbWorldMapData,
    wbWorldMapOffset,
    wbFloat(NAMA, 'Distant LOD Multiplier')
      .SetDefaultNativeValue(1)
      .SetRequired,
    wbInteger(DATA, 'Flags', itU8,
      wbFlags(wbSparseFlags([
        0, 'Small World',
        1, 'Can''t Fast Travel From Here',
        3, 'No LOD Water',
        4, 'No Landscape',
        5, 'No Sky',
        6, 'Fixed Dimensions',
        7, 'No Grass'
      ], False, 8), True)
    ).SetDefaultNativeValue(1)
     .SetRequired
     .IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbInteger(FNAM, 'Flags', itU8,
      wbFlags(wbSparseFlags([
        0, 'Player Followers Can''t Warp Here',
        1, 'Show Space',
        2, 'Prevent Merge Cell Content',
        3, 'Allow ProcGen',
        4, 'Allow Cell Content'
      ], False, 5))
    ).SetRequired
     .IncludeFlag(dfCollapsed, wbCollapseFlags),
    wbWorldRegionEditorMap,
    wbWorldObjectBounds,
    wbFormIDCk(ZNAM, 'Music', [MUSC]),
    wbFormIDCk(WAMB, 'Ambient Set', [AMBS]),
    wbString(XEMP, 'Environment Map'),
    wbString(XWEM, 'Water Environment Map'),
    wbFloat(GNAM, 'Gravity Scale')
      .SetDefaultNativeValue(1)
      .SetRequired,
    wbRArray('Ordered Land Textures',
      wbFormIDCk(LNAM, 'Land Texture', [LTEX])
    ).IncludeFlag(dfNotAlignable),
    wbWorldWaterHeightData.SetRequired,
    wbByteArray(HNAM, 'Unknown', 1)
      .SetRequired,
    wbWorldLevelData,
    wbWorldOffsetData,
    wbWorldCellSizeData
  ]).SetAfterLoad(wbWorldAfterLoad)
    .SetAfterSet(wbWorldAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(WWED, 'Wwise Event Data', [
    wbEDID,
    wbWwiseGuid(WSED, 'Start'),
    wbFormIDCk(CNAM, 'Condition', [CNDF]),
    wbWwiseGuid(WTED, 'End')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(WKMF, 'Wwise Keyword Mapping', [
    wbEDID,
    wbInteger(WMTI, 'Mapping Template', itU16,
      wbEnum([
        'Ship Engine',
        'Cockpit',
        'Grav Drive',
        'Creature Anim'
      ])
    ).SetAfterSet(wbWwiseKeywordMappingTemplateAfterSet)
     .SetRequired,
    wbArrayS(WMKA, 'Keywords',
      wbFormIDCk('Keyword', [KYWD])
    ).SetRequired,
    wbInteger(WMSS, 'Count', itU32)
      .IncludeFlag(dfSkipImplicitEdit),
    wbRStructs('Sound Mappings', 'Sound Mapping', [
      wbUnion(WMSI, 'Sound ID', wbWwiseKeywordMappingSoundDecider, [
        wbInteger('', itU16,
          wbEnum([], [ // 0 Ship Engine
            0, 'Main Loop',
            1, 'Interior',
            2, 'Afterburner'
          ])
        ),
        wbInteger('', itU16,
          wbEnum([], [ // 1 Cockpit
            3, 'Cockpit'
          ])
        ).SetDefaultNativeValue(3),
        wbInteger('', itU16,
          wbEnum([], [ // 2 Grav Drive
            4, 'Grav Jump Pending',
            5, 'Grav Jump Anim Started',
            6, 'Grav Jump Complete',
            7, 'Grav Jump Warmup',
            9, 'Grav Jump Initiate'
          ])
        ).SetDefaultNativeValue(4),
        wbInteger('', itU16,
          wbEnum([], [ // 3 Creature Anim
            8, 'Creature Anim'
          ])
        ).SetDefaultNativeValue(8)
      ]).IncludeFlag(dfUnionStaticResolve),
      wbStruct(WMSD, 'Sounds', [
        wbSoundReference,
        wbArray('Switch Data List',
          wbStruct('Data', [
            wbWwiseGuid('Switch Group'),
            wbWwiseGuid('Switch State')
          ]),
        -1)
      ]).SetRequired
    ], []).SetCountPath(WMSS)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ZOOM, 'Zoom', [
    wbEDID,
    wbBaseFormComponents,
    wbStruct(ZNAM, 'Data', [
      wbFormIDCk('Image Space Modifier', [IMAD, NULL]),
      wbVec3('Geometry Offset'),
      wbFloat('FOV Mult')
        .SetDefaultNativeValue(1),
      wbInteger('Overlay', itU8, wbZoomOverlayEnum),
      wbFloat('FOV Offset'),
      wbStruct('Geometry', [
        wbInteger('Override Offset', itU8, wbBoolEnum),
        wbFloat('Offset Duration')
      ]),
      wbStruct('FOV', [
        wbInteger('Override Offset', itU8, wbBoolEnum),
        wbFloat('Offset Duration')
      ])
    ]).SetRequired
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
  wbAddGroupOrder(EYES);
  wbAddGroupOrder(RACE);
  wbAddGroupOrder(SOUN);
  wbAddGroupOrder(SECH);
  wbAddGroupOrder(ASPC);
  wbAddGroupOrder(AOPF);
  wbAddGroupOrder(MGEF);
  //wbAddGroupOrder(SCPT);
  wbAddGroupOrder(LTEX);
  wbAddGroupOrder(PDCL);
  wbAddGroupOrder(ENCH);
  wbAddGroupOrder(SPEL);
  //wbAddGroupOrder(SCRI);
  wbAddGroupOrder(ACTI);
  wbAddGroupOrder(TACT); // doesn't exist but can be created in CK
  wbAddGroupOrder(CURV);
  wbAddGroupOrder(CUR3);
  wbAddGroupOrder(ARMO);
  wbAddGroupOrder(BOOK);
  wbAddGroupOrder(CONT);
  wbAddGroupOrder(DOOR);
  //wbAddGroupOrder(INGR);
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
  wbAddGroupOrder(PLYR);
  wbAddGroupOrder(LVLN);
  wbAddGroupOrder(LVLP);
  wbAddGroupOrder(KEYM);
  wbAddGroupOrder(ALCH);
  wbAddGroupOrder(IDLM);
  wbAddGroupOrder(BMMO);
  wbAddGroupOrder(NOTE);
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
  //wbAddGroupOrder(REFR);
  //wbAddGroupOrder(ACHR);
  //wbAddGroupOrder(PMIS);
  //wbAddGroupOrder(PARW);
  //wbAddGroupOrder(PGRE);
  //wbAddGroupOrder(PBEA);
  //wbAddGroupOrder(PFLA);
  //wbAddGroupOrder(PCON);
  //wbAddGroupOrder(PPLA);
  //wbAddGroupOrder(PBAR);
  //wbAddGroupOrder(PEMI);
  //wbAddGroupOrder(PHZD);
  wbAddGroupOrder(WRLD);
  wbAddGroupOrder(NAVM);
  //wbAddGroupOrder(TLOD);
  wbAddGroupOrder(DIAL);
  wbAddGroupOrder(INFO);
  wbAddGroupOrder(QUST);
  wbAddGroupOrder(IDLE);
  wbAddGroupOrder(PACK);
  wbAddGroupOrder(CSTY);
  wbAddGroupOrder(LSCR);
  wbAddGroupOrder(LVSP); // doesn't exist but can be created in CK
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
  //wbAddGroupOrder(DLVW);
  //wbAddGroupOrder(WOOP);
  //wbAddGroupOrder(SHOU);
  wbAddGroupOrder(EQUP);
  wbAddGroupOrder(RELA); // doesn't exist but can be created in CK
  wbAddGroupOrder(SCEN);
  wbAddGroupOrder(ASTP); // doesn't exist but can be created in CK
  wbAddGroupOrder(OTFT);
  wbAddGroupOrder(ARTO);
  wbAddGroupOrder(MOVT);
  wbAddGroupOrder(DUAL); // doesn't exist but can be created in CK
  wbAddGroupOrder(COLL);
  wbAddGroupOrder(CLFM);
  wbAddGroupOrder(REVB);
  wbAddGroupOrder(RFGP);
  wbAddGroupOrder(PERS);
  wbAddGroupOrder(AMDL);
  wbAddGroupOrder(AAMD);
  wbAddGroupOrder(MAAM);
  wbAddGroupOrder(LAYR);
  wbAddGroupOrder(COBJ);
  wbAddGroupOrder(OMOD);
  wbAddGroupOrder(ZOOM);
  wbAddGroupOrder(INNR);
  wbAddGroupOrder(KSSM);
  wbAddGroupOrder(SCCO);
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
  wbAddGroupOrder(FXPD);
  wbAddGroupOrder(GPOF);
  wbAddGroupOrder(GPOG);

  wbNexusModsUrl := 'https://www.nexusmods.com/starfield/mods/239';

  SetLength(wbOfficialDLC, 9);
  wbOfficialDLC[0] := 'ShatteredSpace.esm';
  wbOfficialDLC[1] := 'Constellation.esm';
  wbOfficialDLC[2] := 'OldMars.esm';
  wbOfficialDLC[3] := 'SFBGS003.esm';
  wbOfficialDLC[4] := 'SFBGS004.esm';
  wbOfficialDLC[5] := 'SFBGS006.esm';
  wbOfficialDLC[6] := 'SFBGS007.esm';
  wbOfficialDLC[7] := 'SFBGS008.esm';
  wbOfficialDLC[8] := 'BlueprintShips-Starfield.esm';
  wbCreationClubContentFileName := 'Starfield.ccc';

  {
  if wbGameMode = gmSF1VR then begin
    // new VR esm is loaded after DLCs
    SetLength(wbOfficialDLC, Succ(Length(wbOfficialDLC)));
    wbOfficialDLC[Pred(Length(wbOfficialDLC))] := 'Fallout4_VR.esm';
  end else
    wbCreationClubContentFileName := 'Fallout4.ccc';
  }

end;

initialization
end.
