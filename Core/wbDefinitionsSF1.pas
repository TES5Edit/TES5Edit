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
    .IncludeFlag(dfAllowAnyMember)
    .IncludeFlag(dfStructFirstNotRequired)
end;

function wbDamageTypeArray(aItemName: string): IwbSubRecordDef;
begin
  Result := wbArrayS(DAMA, aItemName+'s', wbStructSK([0], aItemName, [
    wbFormIDCk('Damage Type', [DMGT]),
    wbInteger('Value', itU32),
    wbFromVersion(152, wbFormIDCk('Curve Table', [CURV, NULL]))
  ]))
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
      ctCheck: Result := '<Warning: Quest Stage not found in "' + aQuest.Name + '">';
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

{ Alias to string conversion, requires quest reference or quest record specific to record that references alias }
function wbAliasLinksTo(aInt: Int64; const aQuestRef: IwbElement): IwbElement;
var
  MainRecord : IwbMainRecord;
  Aliases    : IwbContainerElementRef;
  Alias      : IwbContainerElementRef;
  i, j       : Integer;
  t          : string;
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
var
  Container  : IwbContainerElementRef;
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
  if lComponentName = 'BGSBlockEditorMetaData_Component' then
    Exit(4);
  if lComponentName = 'UniqueOverlayList_Component' then
    Exit(5);
  if lComponentName = 'UniquePatternPlacementInfo_Component' then
    Exit(6);
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
begin
  Result := 0;

  if not Assigned(aElement) then
    Exit;

  var lContainer: IwbContainer;
  if not Supports(aElement, IwbContainer, lContainer) then
    lContainer := aElement.Container;

  if not Assigned(lContainer) then
    Exit;

  var lElement := lContainer.ElementByPath['...\Has Island Data'];
  if not Assigned(lElement) then
    Exit;

  Result := lElement.NativeValue;
end;

function wbNAVIParentDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;

  if not Assigned(aElement) then
    Exit;

  var lContainer: IwbContainer;
  if not Supports(aElement, IwbContainer, lContainer) then
    lContainer := aElement.Container;

  if not Assigned(lContainer) then
    Exit;

  var lElement := lContainer.ElementByPath['...\Parent Worldspace'];
  if not Assigned(lElement) then
    Exit;

  if (lElement.NativeValue = 0) then
    Result := 1;
end;

function wbNVNMParentDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Container   : IwbContainer;
  Parent      : IwbElement;
  i           : integer;
begin  // Could be simplified by checking if Parent Worldspace is NULL, that's what the runtime does :)
  Result := 0;

  if not Assigned(aElement) then
    Exit;

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

  if not Assigned(aElement) then
    Exit;

  Container := aElement.Container;

  Parent := Container.ElementByName['Door Type'];

  if not Assigned(Parent) then
    Exit;

  i := Parent.NativeValue;

  // not sure if it would be an error in the file or if it really possible
  if i <> 0 then
    Result := 1;
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
    {65} ptSnapTemplateNode,
    {66} ptBiomeMask,
    {67} ptPerkCategory,
    {68} ptPerkSkillGroupComparison,
    {69} ptPerkSkillGroup,
    {70} ptReactionType,
    {71} ptLimbCategory
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
  wbCTDAFunctions : array[0..606] of TCTDAFunction = (
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
    (Index:  47; Name: 'GetItemCount'; ParamType1: ptReferencableObject),                                                                                      //   25
    (Index:  48; Name: 'GetGold'),                                                                                                                          //   26
    (Index:  49; Name: 'GetSleeping'),                                                                                                                      //   27
    (Index:  50; Name: 'GetTalkedToPC'),                                                                                                                    //   28
    (Index:  56; Name: 'GetQuestRunning'; ParamType1: ptQuest),                                                                                             //   29
    (Index:  58; Name: 'GetStage'; ParamType1: ptQuest),                                                                                                    //   30
    (Index:  59; Name: 'GetStageDone'; ParamType1: ptQuest; ParamType2: ptQuestStage),                                                                           //   31
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
    (Index:  72; Name: 'GetIsID'; ParamType1: ptReferencableObject),                                                                                                    //   44
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
    (Index: 142; Name: 'GetComponentCount'; ParamType1: ptReferencableObject),                                                                                            //   82
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
    (Index: 181; Name: 'HasSameEditorLocationAsRefAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),                                                 //   104
    (Index: 182; Name: 'GetEquipped'; ParamType1: ptReferencableObject),                                                                                       //   105
    (Index: 185; Name: 'IsSwimming'),                                                                                                                       //   106
    (Index: 190; Name: 'GetAmountSoldStolen'),                                                                                                              //   107
    (Index: 192; Name: 'GetIgnoreCrime'),                                                                                                                   //   108
    (Index: 193; Name: 'GetPCExpelled'; ParamType1: ptFaction),                                                                                             //   109
    (Index: 195; Name: 'GetPCFactionMurder'; ParamType1: ptFaction),                                                                                        //   110
    (Index: 197; Name: 'GetPCEnemyofFaction'; ParamType1: ptFaction),                                                                                       //   111
    (Index: 199; Name: 'GetPCFactionAttack'; ParamType1: ptFaction),                                                                                        //   112
    (Index: 203; Name: 'GetDestroyed'),                                                                                                                     //   113
    (Index: 214; Name: 'HasMagicEffect'; ParamType1: ptMagicEffect),                                                                                      //   114
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
    (Index: 246; Name: 'GetIsUsedItem'; ParamType1: ptReferencableObject),                                                                                            //   129
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
    (Index: 310; Name: 'GetInWorldspace'; ParamType1: ptWorldSpace),                                                                                    //   161
    (Index: 312; Name: 'GetPCMiscStat'; ParamType1: ptMiscStat),                                                                                   //   162
    (Index: 313; Name: 'GetPairedAnimation'),                                                                                                               //   163
    (Index: 314; Name: 'IsActorAVictim'),                                                                                                                   //   164
    (Index: 315; Name: 'GetTotalPersuasionNumber'),                                                                                                         //   165
    (Index: 318; Name: 'GetIdleDoneOnce'),                                                                                                                  //   166
    (Index: 320; Name: 'GetNoRumors'),                                                                                                                      //   167
    (Index: 323; Name: 'GetCombatState'),                                                                                                                   //   168
    (Index: 325; Name: 'GetWithinPackageLocation'; ParamType1: ptPackdata),                                                                     //   169
    (Index: 327; Name: 'IsRidingMount'),                                                                                                                    //   170
    (Index: 329; Name: 'IsFleeing'),                                                                                                                        //   171
    (Index: 332; Name: 'IsInDangerousWater'),                                                                                                               //   172
    (Index: 338; Name: 'GetIgnoreFriendlyHits'),                                                                                                            //   173
    (Index: 339; Name: 'IsPlayersLastRiddenMount'),                                                                                                         //   174
    (Index: 353; Name: 'IsActor'),                                                                                                                          //   175
    (Index: 354; Name: 'IsEssential'),                                                                                                                      //   176
    (Index: 358; Name: 'IsPlayerMovingIntoNewSpace'),                                                                                                       //   177
    (Index: 359; Name: 'GetIsCurrentLocation'; ParamType1: ptLocation),                                                                                     //   178
    (Index: 360; Name: 'GetIsCurrentLocationAlias'; ParamType1: ptAlias),                                                                              //   179
    (Index: 361; Name: 'GetTimeDead'),                                                                                                                      //   180
    (Index: 362; Name: 'HasLinkedRef'; ParamType1: ptKeyword),                                                                                              //   181
    (Index: 365; Name: 'IsChild'),                                                                                                                          //   182
    (Index: 366; Name: 'GetStolenItemValueNoCrime'; ParamType1: ptFaction),                                                                                 //   183
    (Index: 367; Name: 'GetLastPlayerAction'),                                                                                                              //   184
    (Index: 368; Name: 'IsPlayerActionActive'; ParamType1: ptInteger),                                                                                      //   185
    (Index: 370; Name: 'IsTalkingActivatorActor'; ParamType1: ptActor),                                                                                     //   186
    (Index: 372; Name: 'IsInList'; ParamType1: ptFormList),                                                                                                 //   187
    (Index: 373; Name: 'GetStolenItemValue'; ParamType1: ptFaction),                                                                                        //   188
    (Index: 375; Name: 'GetCrimeGoldViolent'; ParamType1: ptFaction),                                                                                       //   189
    (Index: 376; Name: 'GetCrimeGoldNonviolent'; ParamType1: ptFaction),                                                                                    //   190
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
    (Index: 408; Name: 'IsKiller'; ParamType1: ptActor),                                                                                          //   202
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
    (Index: 439; Name: 'IsFurnitureEntryType'; ParamType1: ptFurnitureEntry),                                                                           //   219
    (Index: 444; Name: 'GetInCurrentLocationFormList'; ParamType1: ptFormList),                                                                             //   220
    (Index: 445; Name: 'GetInZone'; ParamType1: ptLocation),                                                                                                //   221
    (Index: 446; Name: 'GetVelocity'; ParamType1: ptAxis),                                                                                                  //   222
    (Index: 447; Name: 'GetGraphVariableFloat'; ParamType1: ptString),                                                                                      //   223
    (Index: 448; Name: 'HasPerk'; ParamType1: ptPerk),                                                                                                      //   224
    (Index: 449; Name: 'GetFactionRelation'; ParamType1: ptActor),                                                                                //   225
    (Index: 450; Name: 'IsLastIdlePlayed'; ParamType1: ptIdleForm),                                                                                         //   226
    (Index: 453; Name: 'GetPlayerTeammate'),                                                                                                                //   227
    (Index: 454; Name: 'GetPlayerTeammateCount'),                                                                                                           //   228
    (Index: 458; Name: 'GetActorCrimePlayerEnemy'),                                                                                                         //   229
    (Index: 459; Name: 'GetCrimeGold'; ParamType1: ptFaction),                                                                                              //   230
    (Index: 463; Name: 'IsPlayerGrabbedRef'; ParamType1: ptObjectReference),                                                                                //   231
    (Index: 465; Name: 'GetKeywordItemCount'; ParamType1: ptKeyword),                                                                                       //   232
    (Index: 470; Name: 'GetDestructionStage'),                                                                                                              //   233
    (Index: 473; Name: 'GetIsAlignment'; ParamType1: ptAlignment),                                                                                          //   234
    (Index: 476; Name: 'IsProtected'),                                                                                                                      //   235
    (Index: 477; Name: 'GetThreatRatio'; ParamType1: ptActor),                                                                                              //   236
    (Index: 479; Name: 'GetIsUsedItemEquipType'; ParamType1: ptEquipType{ptEquipSlot}),                                                                                  //   237
    (Index: 483; Name: 'GetPlayerActivated'),                                                                                                               //   238
    (Index: 485; Name: 'GetFullyEnabledActorsInHigh'),                                                                                                      //   239
    (Index: 487; Name: 'IsCarryable'),                                                                                                                      //   240
    (Index: 488; Name: 'GetConcussed'),                                                                                                                     //   241
    (Index: 490; Name: 'GetBiomeScanPercent'; Desc:'Returns the biome scan percentage of this object type. 0 if it''s not part of this biome.'),                                                                                                              //   242
    (Index: 491; Name: 'GetMapMarkerVisible'),                                                                                                              //   243
    (Index: 493; Name: 'PlayerKnows'; ParamType1: ptReferencableObject),                                                                                          //   244
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
    (Index: 561; Name: 'HasRefType'; ParamType1: ptRefType),                                                                                        //   280
    (Index: 562; Name: 'LocationHasKeyword'; ParamType1: ptKeyword),                                                                                        //   281
    (Index: 563; Name: 'LocationHasRefType'; ParamType1: ptRefType),                                                                                //   282
    (Index: 565; Name: 'GetIsEditorLocation'; ParamType1: ptLocation),                                                                                      //   283
    (Index: 566; Name: 'GetIsAliasRef'; ParamType1: ptAlias),                                                                                          //   284
    (Index: 567; Name: 'GetIsEditorLocationAlias'; ParamType1: ptAlias),                                                                               //   285
    (Index: 568; Name: 'IsSprinting'),                                                                                                                      //   286
    (Index: 569; Name: 'IsBlocking'),                                                                                                                       //   287
    (Index: 570; Name: 'HasEquippedSpell'; ParamType1: ptCastingSource),                                                                                    //   288
    (Index: 571; Name: 'GetCurrentCastingType'; ParamType1: ptCastingSource),                                                                               //   289
    (Index: 572; Name: 'GetCurrentDeliveryType'; ParamType1: ptCastingSource),                                                                              //   290
    (Index: 574; Name: 'GetAttackState'),                                                                                                                   //   291
    (Index: 576; Name: 'GetEventData'; ParamType1: ptEvent {and EventMember in the same DWORD}; ParamType2: ptEventData),                                    //   292
    (Index: 577; Name: 'IsCloserToAThanB'; ParamType1: ptObjectReference; ParamType2: ptObjectReference),                                                   //   293
    (Index: 578; Name: 'LevelMinusPCLevel'),                                                                                                                //   294
    (Index: 580; Name: 'IsBleedingOut'),                                                                                                                    //   295
    (Index: 584; Name: 'GetRelativeAngle'; ParamType1: ptObjectReference; ParamType2: ptAxis),                                                              //   296
    (Index: 589; Name: 'GetMovementDirection'),                                                                                                             //   297
    (Index: 590; Name: 'IsInScene'),                                                                                                                        //   298
    (Index: 591; Name: 'GetRefTypeDeadCount'; ParamType1: ptLocation; ParamType2: ptRefType),                                                       //   299
    (Index: 592; Name: 'GetRefTypeAliveCount'; ParamType1: ptLocation; ParamType2: ptRefType),                                                      //   300
    (Index: 594; Name: 'GetIsFlying'),                                                                                                                      //   301
    (Index: 595; Name: 'IsCurrentSpell'; ParamType1: ptMagicItem; ParamType2: ptCastingSource),                                                             //   302
    (Index: 596; Name: 'SpellHasKeyword'; ParamType1: ptCastingSource; ParamType2: ptKeyword),                                                              //   303
    (Index: 597; Name: 'GetEquippedItemType'; ParamType1: ptCastingSource),                                                                                 //   304
    (Index: 598; Name: 'GetLocationAliasExplored'; ParamType1: ptAlias),                                                                               //   305
    (Index: 600; Name: 'GetLocationAliasRefTypeDeadCount'; ParamType1: ptAlias; ParamType2: ptRefType),                                        //   306
    (Index: 601; Name: 'GetLocationAliasRefTypeAliveCount'; ParamType1: ptAlias; ParamType2: ptRefType),                                       //   307
    (Index: 602; Name: 'IsWardState'; ParamType1: ptWardState),                                                                                             //   308
    (Index: 603; Name: 'IsInSameCurrentLocationAsRef'; ParamType1: ptObjectReference; ParamType2: ptKeyword),                                               //   309
    (Index: 604; Name: 'IsInSameCurrentLocationAsAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),                                                  //   310
    (Index: 605; Name: 'LocationAliasIsLocation'; ParamType1: ptAlias; ParamType2: ptLocation),                                                        //   311
    (Index: 606; Name: 'GetKeywordDataForLocation'; ParamType1: ptLocation; ParamType2: ptKeyword),                                                         //   312
    (Index: 608; Name: 'GetKeywordDataForAlias'; ParamType1: ptAlias; ParamType2: ptKeyword),                                                          //   313
    (Index: 610; Name: 'LocationAliasHasKeyword'; ParamType1: ptAlias; ParamType2: ptKeyword),                                                         //   314
    (Index: 611; Name: 'IsNullPackageData'; ParamType1: ptPackdata),                                                                        //   315
    (Index: 612; Name: 'GetNumericPackageData'; ParamType1: ptPackdata),                                                                         //   316
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
    (Index: 626; Name: 'IsLocationAliasLoaded'; ParamType1: ptAlias),                                                                                  //   330
    (Index: 627; Name: 'IsDualCasting'),                                                                                                                    //   331
    (Index: 629; Name: 'GetVMQuestVariable'; ParamType1: ptQuest; ParamType2: ptString),                                                       //   332
    (Index: 630; Name: 'GetCombatAudioDetection'),                                                                                                          //   333
    (Index: 631; Name: 'GetCombatVisualDetection'),                                                                                                         //   334
    (Index: 632; Name: 'IsCasting'),                                                                                                                        //   335
    (Index: 633; Name: 'GetFlyingState'),                                                                                                                   //   336
    (Index: 635; Name: 'IsInFavorState'),                                                                                                                   //   337
    (Index: 636; Name: 'HasTwoHandedWeaponEquipped'),                                                                                                       //   338
    (Index: 637; Name: 'IsFurnitureExitType'; ParamType1: ptFurnitureEntry),                                                                            //   339
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
    (Index: 659; Name: 'HasVMScript'; ParamType1: ptString),                                                                                         //   356
    (Index: 660; Name: 'GetVMScriptVariable'; ParamType1: ptString; ParamType2: ptString),                                              //   357
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
    (Index: 682; Name: 'WornHasKeyword'; ParamType1: ptKeyword),                                                                                        //   368
    (Index: 683; Name: 'GetPathingCurrentSpeed'),                                                                                                           //   369
    (Index: 684; Name: 'GetPathingCurrentSpeedAngle'; ParamType1: ptAxis),                                                                                  //   370
    (Index: 691; Name: 'GetWorkshopObjectCount'; ParamType1: ptReferencableObject),                                                                                     //   371
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
    (Index: 705; Name: 'GetShouldHelp'; ParamType1: ptActor),                                                                                     //   383
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
    (Index: 730; Name: 'SpeechScenarioHasKeyword'; ParamType1: ptKeyword; Desc:'See if Keyword is in current speech challenge game.'),                                                                                  //   404
    (Index: 734; Name: 'CanProduceForWorkshop'),                                                                                                            //   405
    (Index: 735; Name: 'CanFlyHere'),                                                                                                                       //   406
    (Index: 736; Name: 'EPIsDamageType'; ParamType1: ptDamageType),                                                                                         //   407
    (Index: 737; Name: 'IsCurrentSpeechChallengeObject'; ParamType1: ptSpeechChallenge),                                                                    //   408
    (Index: 738; Name: 'GetActorGunState'),                                                                                                                 //   409
    (Index: 739; Name: 'GetVoiceLineLength'),                                                                                                               //   410
    (Index: 741; Name: 'ObjectTemplateItem_HasKeyword'; ParamType1: ptKeyword),                                                                             //   411
    (Index: 742; Name: 'ObjectTemplateItem_HasUniqueKeyword'; ParamType1: ptKeyword),                                                                       //   412
    (Index: 743; Name: 'ObjectTemplateItem_GetLevel'),                                                                                                      //   413
    (Index: 744; Name: 'MovementIdleMatches'; ParamType1: ptInteger{ptMovementSelectIdleFromState}; ParamType2: ptInteger{ptMovementSelectIdleToState}),                          //   414
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
    (Index: 840; Name: 'IsSnappedTo'; ParamType1: ptObjectReference; ParamType2: ptSnapTemplateNode; Desc: 'Is the given reference snapped to this other reference?'),                                                       //   505
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
    (Index: 960; Name: 'EPIsResistanceActorValue'; ParamType1: ptActorValue; Desc: 'Is a specific resistance actor value passed into this check?')                                                                                //   606
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

procedure wbRemoveCLSZ(const aElement: IwbElement);
var
  Container: IwbContainer;
  rCLSZ: IwbRecord;
begin
  if not wbRemoveOffsetData then
    Exit;

  if not Supports(aElement, IwbContainer, Container) then
    Exit;

  if wbBeginInternalEdit then try
    Container.RemoveElement(CLSZ);
  finally
    wbEndInternalEdit;
  end else begin
    rCLSZ := Container.RecordBySignature[CLSZ];
    if Assigned(rCLSZ) then
      Container.RemoveElement(rCLSZ);
  end;
end;

procedure wbWRLDAfterLoad(const aElement: IwbElement);
begin
  wbRemoveOFST(aElement);
  wbRemoveCLSZ(aElement);
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
    ])
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

var
  wbRecordFlagsFlags, wbEmptyBaseFlags : IwbFlagsDef;

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
      wbWwiseGuid('Start'), // GUID 1
      wbWwiseGuid('Stop'), // GUID 2
      wbFormIDCk('Condition', [NULL, CNDF]).IncludeFlag(dfSummaryExcludeNULL),
      wbFormIDCk('Event Mapping', [NULL, WWED]).IncludeFlag(dfSummaryExcludeNULL)
    ])
      .SetSummaryKey([0, 1, 2, 3])
{      .SetSummaryMemberPrefixSuffix(0, 'Start: ', '')
      .SetSummaryMemberPrefixSuffix(1, 'Stop: ', '')
      .SetSummaryMemberPrefixSuffix(2, 'Cond: ', '')
      .SetSummaryMemberPrefixSuffix(3, 'Event: ', '')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfSummaryMembersNoName)}
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
  wbKnownSubRecordSignatures[ksrBaseFormComponents] := '____';
  wbHEDRVersion := 0.96;
  wbCellSizeFactor := 100;

  DefineCommon;


  var wbIdxSimpleGroup := wbNamedIndex('SimpleGroup', True);
  var wbIdxComplexGroup := wbNamedIndex('ComplexGroup', True);
  var wbIdxModulation := wbNamedIndex('Modulation', True);

  var wbIdxAVMByType : TArray<TwbNamedIndex> := [-1, wbIdxSimpleGroup, wbIdxComplexGroup, wbIdxModulation];

  var wbIdxCollisionLayer := wbNamedIndex('CollisionLayer', True);

  var wbNull := wbByteArray('Unused', -255);
  var wbLLCT := wbInteger(LLCT, 'Count', itU8, nil, cpBenign);
  var wbCITC := wbInteger(CITC, 'Condition Count', itU32, nil, cpBenign);
  var wbCITCReq := wbInteger(CITC, 'Condition Count', itU32, nil, cpBenign, True);
  var wbLVLD := wbFloat(LVLD, 'Chance None', cpNormal, True);

  var wbSPCT := wbInteger(SPCT, 'Count', itU32, nil, cpBenign);
  var wbSPLO := wbFormIDCk(SPLO, 'Actor Effect', [SPEL, LVSP]);
  var wbSPLOs := wbRArrayS('Actor Effects', wbSPLO, cpNormal, False, nil, wbSPLOsAfterSet, nil{wbActorTemplateUseActorEffectList});

  var wbKSIZ := wbInteger(KSIZ, 'Keyword Count', itU32, nil, cpBenign);
  var wbKWDAs := wbArrayS(KWDA, 'Keywords', wbFormIDCk('Keyword', [KYWD, NULL]), 0, cpNormal, False, nil, wbKWDAsAfterSet);
  var wbReqKWDAs := wbArrayS(KWDA, 'Keywords', wbFormIDCk('Keyword', [KYWD, NULL]), 0, cpNormal, True, nil, wbKWDAsAfterSet);

  var wbKeywords := wbRStruct('Keywords', [
    wbKSIZ,
    wbReqKWDAs
  ], []);

  var wbCVPA := wbStructs(CVPA, 'Components', 'Component', [
      wbFormIDCk('Component', sigBaseObjects), // CK allows only CMPO
      wbInteger('Count', itU32),
      wbUnknown(4)
    ]);

  //wbActorValue := wbInteger('Actor Value', itS32, wbActorValueEnum);
  var wbActorValue := wbFormIDCkNoReach('Actor Value', [AVIF, NULL]);

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

  var wbContainerItems := wbRStruct('Container Items', [
    wbCOCT,
    wbCNTOs.SetRequired
  ], []);

  var wbALSH := wbSoundReference(ALSH, 'Looping Sound');
  var wbACSH := wbSoundReference(ACSH, 'Activate Sound');
  var wbCUSH := wbSoundReference(CUSH, 'Crafting Sound');
  var wbPUSH := wbSoundReference(PUSH, 'Pickup Sound');
  var wbPDSH := wbSoundReference(PDSH, 'Dropdown Sound');

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

  var wbFirstPersonFlagsU64 := wbInteger('First Person Flags', itU64, wbBipedObjectFlags);

  var wbBO64 :=
    wbStruct(BO64, 'Biped Object Template', [
      wbFirstPersonFlagsU64
    ], cpNormal, False)
      .SetSummaryKeyOnValue([0])
      .SetSummaryPrefixSuffixOnValue(0, '(', ')')
      .IncludeFlagOnValue(dfSummaryMembersNoName);

  var wbDODT :=
    wbStruct(DODT, 'Decal Data', [
      wbFloat('Min Width'),
      wbFloat('Max Width'),
      wbFloat('Min Height'),
      wbFloat('Max Height'),
      wbFloat('Depth'),
      wbFloat('Shininess')
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

  var wbMusicEnum := wbEnum(['Default', 'Public', 'Dungeon']);
  var wbSoundLevelEnum := wbEnum([
     'Loud',
     'Normal',
     'Silent',
     'Very Loud',
     'Quiet',
     'Unknown 5'
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
    {250} 'Mod Armor Resistance'
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

  var wbObjectModPropertiesEnum := wbEnum([],[
    Sig2Int('AACT'), 'Armor - Actor Value',
    Sig2Int('ADMG'), 'Armor - Damage Resistance',
    Sig2Int('AENC'), 'Armor - Enchantment',
    Sig2Int('AKEY'), 'Armor - Keyword',
    Sig2Int('ARAT'), 'Armor - Rating',
    Sig2Int('AVAL'), 'Armor - Value',
    Sig2Int('AWGT'), 'Armor - Weight',
    Sig2Int('FLMS'), 'Flora - Layered Material Swap',
    Sig2Int('NACV'), 'NPC - Actor Value',
    Sig2Int('NARO'), 'NPC - Actor Race Override',
    Sig2Int('NAID'), 'NPC - AI Data',
    Sig2Int('NCST'), 'NPC - Combat Style ',
    Sig2Int('NENC'), 'NPC - Enchantment',
    Sig2Int('NFAC'), 'NPC - Faction',
    Sig2Int('NGFA'), 'NPC - Group Faction',
    Sig2Int('NINV'), 'NPC - Inventory',
    Sig2Int('NKEY'), 'NPC - Keyword',
    Sig2Int('NMSL'), 'NPC - Layered Material Swap',
    Sig2Int('NMMX'), 'NPC - Min-Max Size',
    Sig2Int('NPRK'), 'NPC - Perk',
    Sig2Int('NRCE'), 'NPC - Race',
    Sig2Int('NREA'), 'NPC - Reaction Radius',
    Sig2Int('NSKN'), 'NPC - Skin',
    Sig2Int('NSPL'), 'NPC - Spell',
    Sig2Int('NXPO'), 'NPC - XP Override',
    Sig2Int('SPAV'), 'Spaceship - Actor Value ',
    Sig2Int('SDMG'), 'Spaceship - System Damage',
    Sig2Int('AA01'), 'Weapon - Aim Assist Template',
    Sig2Int('AA02'), 'Weapon - Aim Inner Cone Angle (Degrees)',
    Sig2Int('WABS'), 'Weapon - Aim Model - Base Stability',
    Sig2Int('WAIM'), 'Weapon - Aim Model - Template',
    Sig2Int('WCO1'), 'Weapon - Aim Model Cone - Min Degrees',
    Sig2Int('WCO2'), 'Weapon - Aim Model Cone - Max Degrees',
    Sig2Int('WCO3'), 'Weapon - Aim Model Cone - Increase Per Shot',
    Sig2Int('WCO4'), 'Weapon - Aim Model Cone - Decrease Per Sec',
    Sig2Int('WCO5'), 'Weapon - Aim Model Cone - Decrease Delay Sec',
    Sig2Int('WCO6'), 'Weapon - Aim Model Cone - Iron Sights Multiplier',
    Sig2Int('WRC1'), 'Weapon - Aim Model Recoil - Diminish Spring Force',
    Sig2Int('WRC2'), 'Weapon - Aim Model Recoil - Diminish Sights Mult',
    Sig2Int('WRC5'), 'Weapon - Aim Model Recoil - Multiplier (Hip Fire)',
    Sig2Int('WAOS'), 'Weapon - Aim Optical Sight Marker',
    Sig2Int('ACPT'), 'Weapon - Ammo Capacity',
    Sig2Int('WACV'), 'Weapon - Actor Value',
    Sig2Int('WADL'), 'Weapon - Attack Delay (Seconds)',
    Sig2Int('WSDM'), 'Weapon - Bash Damage',
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
    Sig2Int('GVAL'), 'Weapon - Value',
    Sig2Int('GWEI'), 'Weapon - Weight',
    Sig2Int('ZFOV'), 'Weapon - Zoom FOV',
    Sig2Int('ZDTA'), 'Weapon - Zoom Template'

  ]);

  var wbEDID := wbStringKC(EDID, 'Editor ID', 0, cpOverride);
  var wbNLDT := wbString(NLDT, 'Context'); // localization note, explanation of variable, etc.
  var wbFULL := wbLStringKC(FULL, 'Name', 0, cpTranslate);
  var wbFULLActor := wbLStringKC(FULL, 'Name', 0, cpTranslate, False, nil{wbActorTemplateUseBaseData});
  var wbFULLReq := wbLStringKC(FULL, 'Name', 0, cpTranslate, True);
  var wbDESC := wbLStringKC(DESC, 'Description', 0, cpTranslate);
  var wbDESCReq := wbLStringKC(DESC, 'Description', 0, cpTranslate, True);
  var wbXSCL := wbFloat(XSCL, 'Scale');
  var wbXALGFlags := wbFlags([ //copied from FO76, probably wrong
    {0x00000001} 'Unknown 1 (No Havok??)',
    {0x00000002} 'Unknown 2',
    {0x00000004} 'Unknown 3 (Reference??)',
    {0x00000008} 'Unknown 4',
    {0x00000010} 'Unknown 5',
    {0x00000020} 'Unknown 6', //Unused
    {0x00000040} 'Unknown 7',
    {0x00000080} 'Unknown 8',
    {0x00000100} 'Unknown 9',      //'Atom Shop Item'
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

  var wbXALG := wbInteger(XALG, 'Flags', itU64, wbXALGFlags);

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

  var wbScriptFragmentsPack := wbStruct('Script Fragments', [
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

  var wbScriptFragmentsQuest := wbStruct('Script Fragments', [
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

  var wbScriptFragmentsScen := wbStruct('Script Fragments', [
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
    wbInteger('Version', itS16, nil, cpIgnore).SetDefaultNativeValue(6);

  var wbVMADObjectFormat :=
    wbInteger('Object Format', itS16, nil, cpIgnore).SetDefaultNativeValue(2);

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
      ])),
      wbFloat('Attack Angle'),
      wbFloat('Strike Angle'),
      wbFloat('Stagger'),
      wbFloat('Knockdown'),
      wbFloat('Recovery Time'),
      wbFloat('Action Points Mult'),
      wbInteger('Stagger Offset', itS32),
      wbFloat
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

  var wbPLDT := wbStruct(PLDT, 'Location', [
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
    wbInteger('Radius', itU32),
    wbInteger('Collection Index', itU32)
  ], cpNormal, False, nil, 3);

  var wbPLVD := wbStruct(PLVD, 'Location', [
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
     {14} wbInteger('Ref Collection Alias', itS32, wbPackageLocationAliasToStr, wbStrToAlias)
    ]),
    wbInteger('Radius', itS32),
    wbInteger('Collection Index', itU32)
  ], cpNormal, False, nil, 3)
  .SetSummaryKeyOnValue([0])
  .SetSummaryPrefixSuffixOnValue(0,'[Type] ','');

  var wbPTDA := wbStruct(PTDA, 'Target Data', [
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
      {1} wbFormIDCkNoReach('Object ID', [NULL, ACTI, DOOR, STAT, MSTT, FURN, SPEL, NPC_, CONT, ARMO, AMMO, MISC, WEAP, OMOD, BOOK, NOTE, KEYM, ALCH, INGR, LIGH, FACT, FLST, IDLM, TXST, PROJ, PKIN]),
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
    wbInteger('Flags', itU8, wbFlags(['Unknown 0', '', 'Leveled Lock'])),
    wbUnused(3),
    wbInteger('Unknown', itU32)
  ], cpNormal, False, nil, 4);

  var wbEITM := wbFormIDCk(EITM, 'Object Effect', [ENCH, SPEL]);

  var wbMODS := wbFormIDCk(MODS, 'Material Swap', [NULL, MSWP]);
  var wbMO2S := wbFormIDCk(MO2S, 'Material Swap', [NULL, MSWP]);
  var wbMO3S := wbFormIDCk(MO3S, 'Material Swap', [NULL, MSWP]);
  var wbMO4S := wbFormIDCk(MO4S, 'Material Swap', [NULL, MSWP]);
  var wbMO5S := wbFormIDCk(MO5S, 'Material Swap', [NULL, MSWP]);

  var wbModelFlags := wbFlags([
    'Has FaceBones Model',
    'Has 1stPerson Model'
  ]);
  var wbMODF := wbInteger(MODF, 'Flags', itU8, wbModelFlags);
  var wbMO2F := wbInteger(MO2F, 'Flags', itU8, wbModelFlags);
  var wbMO3F := wbInteger(MO3F, 'Flags', itU8, wbModelFlags);
  var wbMO4F := wbInteger(MO4F, 'Flags', itU8, wbModelFlags);
  var wbMO5F := wbInteger(MO5F, 'Flags', itU8, wbModelFlags);
  var wbMO6F := wbInteger(MO6F, 'Flags', itU8, wbModelFlags);
  var wbMO7F := wbInteger(MO7F, 'Flags', itU8, wbModelFlags);

  var wbMODC := wbFloat(MODC, 'Color Remapping Index');
  var wbMO2C := wbFloat(MO2C, 'Color Remapping Index');
  var wbMO3C := wbFloat(MO3C, 'Color Remapping Index');
  var wbMO4C := wbFloat(MO4C, 'Color Remapping Index');
  var wbMO5C := wbFloat(MO5C, 'Color Remapping Index');

  var wbFLLD := wbInteger(FLLD, 'Unknown', itU32, wbFlags([
    'Unknown 0',
    'Unknown 1',
    'Unknown 2',
    'Unknown 3'
  ]));

  var wbDMDS := wbFormIDCk(DMDS, 'Material Swap', [NULL, MSWP]);
  var wbDMDC := wbFloat(DMDC, 'Color Remapping Index');

  {subrecords checked against Starfield.esm}
  var wbDEST := wbRStruct('Destructible', [
    wbStruct(DEST, 'Header', [
      wbInteger('Health', itS32),
      wbInteger('DEST Count', itU8),
      wbInteger('Flags', itU8, wbFlags([
        'VATS Targetable',
        'Large Actor Destroys',
        'Unknown 2'
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
            'Becomes Dynamic',
            'Unknown 5',
            'Unknown 6'
          ])),
          wbInteger('Self Damage per Second', itS32),
          wbFormIDCk('Explosion', [EXPL, NULL]),
          wbFormIDCk('Debris', [DEBR, NULL]),
          wbInteger('Debris Count', itS32),
          wbFloat
        ], cpNormal, True),
        wbString(DSTA, 'Sequence Name'),
        wbRStructSK([0], 'Model', [
          wbString(DMDL, 'Model FileName', 0, cpNormal, True),
          wbFLLD,
//          wbDMDT,
//          wbDMDC,
          wbDMDS
        ], [], cpNormal, False, nil, True),
        wbEmpty(DSTF, 'End Marker', cpNormal, True)
      ], [], cpNormal, False, nil)
    )
  ], [], cpNormal, False, nil);

  var wbDESTActor := wbRStruct('Destructible', [
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
  ], []);

  var wbXESP := wbStruct(XESP, 'Enable State Parent', [
    wbFormIDCk('Reference', sigReferences),
    wbInteger('Flags', itU8, wbFlags([
      'Set Enable State to Opposite of Parent',
      'Pop In'
    ])),
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

  var wbSNTP := wbFormIDCk(SNTP, 'Snap Template', [STMP]);
  var wbSNBH := wbFormIDCk(SNBH, 'Snap Behavior', [STBH]);
  var wbODTY := wbFloat(ODTY, 'Unknown');
  var wbOPDS :=
    wbStruct(OPDS, 'Object Placement Defaults', [
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbInteger('Unknown', itU32),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloatAngle,
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloatAngle,
      wbFloat('Unknown'),
      wbFloat('Unknown')
    ])
      .IncludeFlag(dfCollapsed);
  var wbDEFL := wbFormIDCk(DEFL, 'Default Layer', [LAYR]);

  var wbPTT2 := wbStruct(PTT2, 'Transforms', [
    wbFormIDCk('Inventory Icon Transform', [NULL, TRNS]),
    wbFormIDCk('Outpost Transform', [NULL, TRNS]),
    wbFormIDCk('Ship Transform', [NULL, TRNS]),
    wbFormIDCk('Preview Transform', [NULL, TRNS]),
    wbFormIDCk('Inventory Transform', [NULL, TRNS]),
    wbFormIDCk('Workbench Transform ', [NULL, TRNS]),
    wbFormIDCk('Main Game UI Transform', [NULL, TRNS]),
    wbFormIDCk('Unknown 7', [NULL, TRNS])
  ]);

  var wbXLCM := wbInteger(XLCM, 'Level Modifier', itS32, wbEnum([
    'Easy',
    'Medium',
    'Hard',
    'Very Hard'
  ]));

  var wbXOWN := wbStruct(XOWN, 'Ownership', [
    wbFormIDCkNoReach('Owner', [FACT, ACHR, NPC_]),
    wbByteArray('Unknown', 4),
    wbInteger('Flags', itU8, wbFlags(['No Crime'])),
    wbUnused(3)
  ]);
  var wbXRNK := wbInteger(XRNK, 'Owner Faction Rank', itS32);

  var wbXEED :=
    wbStruct(XEED, 'External Emittance', [
    { 0} wbFloat,
    { 4} wbInteger('Unknown', itU8),
    { 5} wbUnused(3)
    { 8}
    ]);

  var wbNavmeshEdgeLinks := wbArray('Edge Links',
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

  var wbCRCValuesEnum :=
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
      Int64($DAF94F6D), 'PathingTraversalLink', //actually CRC of BSPathingTraversalLink
      Int64($6AF11190), 'QuestPathingRequest',
      Int64($FCD0CCC3), 'Water'
    ]);

  var wbNavmeshDoorTriangles := wbArrayS('Door Triangles',
    wbStructSK([0, 2], 'Door Triangle', [
      wbInteger('Triangle before door', itS16).SetLinksToCallback(wbTriangleLinksTo),
      wbInteger('Door Type', itU32, wbCRCValuesEnum).SetDefaultEditValue('PathingDoor'), //contains 0 or the CRC of "PathingDoor" = F3 73 8B E4
      wbUnion('Door', wbDoorTriangleDoorTriangleDecider, [wbNull, wbFormIDCk('Door', [REFR])])
    ])
  , -1);

  var wbNavmeshVertices: IwbValueDef;
  var wbNavmeshTriangles: IwbValueDef;
  var wbNavmeshCoverArray: IwbValueDef;
  var wbNavmeshCoverTriangleMap: IwbValueDef;
  var wbNavmeshWaypoints: IwbValueDef;

  if wbSimpleRecords then begin
    wbNavmeshVertices := wbArray('Vertices', wbByteArray('Vertex', 16), -1);
    wbNavmeshTriangles := wbArray('Triangles', wbByteArray('Triangle', 21), -1);
    wbNavmeshCoverArray := wbArray('Cover Array', wbByteArray('Cover', 12), -1);
    wbNavmeshCoverTriangleMap := wbArray('Cover Triangle Mappings', wbByteArray('Cover Triangle', 4), -1);
    wbNavmeshWaypoints := wbArray('Waypoints', wbByteArray('Waypoint', 18), -1);
  end else begin
    wbNavmeshVertices := wbArray('Vertices',
      wbStruct('Vertex', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z'),
        wbUnknown(4)
      ]).SetToStr(wbVec3ToStr).IncludeFlag(dfCollapsed, wbCollapseVec3)
    , -1);

    var wbEdgeLinksTo :=
      function(aEdge: Integer): TwbLinksToCallback
      begin
        Result :=
          function(const aElement: IwbElement): IwbElement
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
      end;

    wbNavmeshTriangles := wbArray('Triangles',
      wbStruct('Triangle', [
        wbInteger('Vertex 0', itS16, wbVertexToStr0, wbVertexToInt0).SetLinksToCallback(wbVertexLinksTo),
        wbInteger('Vertex 1', itS16, wbVertexToStr1, wbVertexToInt1).SetLinksToCallback(wbVertexLinksTo),
        wbInteger('Vertex 2', itS16, wbVertexToStr2, wbVertexToInt2).SetLinksToCallback(wbVertexLinksTo),
        wbInteger('Edge 0-1', itS16, wbEdgeToStr0, wbEdgeToInt0).SetLinksToCallback(wbEdgeLinksTo(0)),
        wbInteger('Edge 1-2', itS16, wbEdgeToStr1, wbEdgeToInt1).SetLinksToCallback(wbEdgeLinksTo(1)),
        wbInteger('Edge 2-0', itS16, wbEdgeToStr2, wbEdgeToInt1).SetLinksToCallback(wbEdgeLinksTo(2)),
        wbFloat('Height'), // this and next if form ver > 57
        wbInteger('Unknown', itU8), // flags
        wbInteger('Flags', itU16, wbFlags([
          'Edge 0-1 link',      //$0001 1
          'Edge 1-2 link',      //$0002 2
          'Edge 2-0 link',      //$0004 4
          'Unknown 3',          //$0008 8
          'No Large Creatures', //$0010 16   used in CK source according to Nukem
          'Overlapping',        //$0020 32
          'Preferred',          //$0040 64
          'Unknown 7',          //$0080 128
          'Unknown 8',          //$0100 256  used in CK source according to Nukem
          'Water',              //$0200 512
          'Door',               //$0400 1024
          'Found',              //$0800 2048
          'Unknown 12',         //$1000 4096 used in CK source according to Nukem
          'Unknown 13',         //$2000
          'Unknown 14',         //$4000
          'Unknown 15'          //$8000
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
          'Unknown 12',
          'Unknown 13',
          'Unknown 14',
          'Unknown 15'
        ]))
      ])
    , -1);

    wbNavmeshCoverArray := wbArray('Cover Array',  // if navmesh version gt 12
      wbStruct('Cover', [
        //wbInteger('Vertex 0', itS16, wbVertexToStr0, wbVertexToInt0).SetLinksToCallback(wbVertexLinksTo),
        //wbInteger('Vertex 1', itS16, wbVertexToStr1, wbVertexToInt1).SetLinksToCallback(wbVertexLinksTo),
        wbByteArray('Unknown', 2),
        wbByteArray('Unknown', 2),
        wbByteArray('Unknown', 4),
        wbByteArray('Unknown', 4)
      ])
    , -1);

    wbNavmeshCoverTriangleMap := wbArray('Cover Triangle Mappings',
      wbStruct('Cover Triangle Map', [
        {wbInteger('Cover', itU16).SetLinksToCallback(wbCoverLinksTo),
        wbInteger('Triangle', itU16).SetLinksToCallback(wbTriangleLinksTo)}
        wbByteArray('Unknown', 2),
        wbByteArray('Unknown', 2)
      ])
    , -1);

    wbNavmeshWaypoints := wbArray('Waypoints',  // if navmesh version gt 11
      wbStruct('Waypoint', [
        wbFloat('X'),
        wbFloat('Y'),
        wbFloat('Z'),
        wbInteger('Triangle', itS16).SetLinksToCallback(wbTriangleLinksTo),
        wbInteger('Flags', itU32)
      ])
    , -1);
  end;

  var wbNavmeshGrid := wbStruct('Navmesh Grid', [
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
    , function(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal
      begin
        var lContainer := aElement.Container;
        if not Assigned(lContainer) then
          Exit(0);

        var lGridSizeElement := lContainer.ElementByName['Navmesh Grid Size'];
        if not Assigned(lGridSizeElement) then
          Exit(0);

        var lGridSize: Integer := lGridSizeElement.NativeValue;
        if (lGridSize < 0) or (lGridSize > 12) then
          Exit(0);

        Result := lGridSize * lGridSize;
      end)
      .IncludeFlag(dfNotAlignable) // There are NavMeshGridSize^2 arrays to load
  ]);

  var wbNVNM := wbStruct(NVNM, 'Navmesh Geometry', [
    wbInteger('Version', itU32).SetDefaultNativeValue(15),  // Changes how the struct is loaded, should be 15 in FO4
    wbStruct('Pathing Cell', [
      wbInteger('Type', itU32, wbCRCValuesEnum).SetDefaultEditValue('PathingCell'),  // This looks like a magic number (always $A5E9A03C), loaded with the parents
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
    wbNavmeshGrid,
    wbUnknown(2),
    wbUnknown(2)
  ]);

  var wbMNAMNAVM := wbArrayS(MNAM, 'PreCut Map Entries', wbStructSK([0], 'PreCut Map Entry', [
    wbFormID('Reference'),
    wbArrayS('Triangles', wbInteger('Triangle', itU16).SetLinksToCallback(wbTriangleLinksTo), -2)
  ]));

  var wbHNAMHNAM := wbRStruct('Unknown', [
    wbMarker(HNAM).SetRequired,
    wbArray(HTID, 'Unknown', wbInteger('Reference Alias ID', itS32)),
    wbEmpty(FNAM, 'Unknown'),
    wbEmpty(PNAM, 'Unknown'),
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
    {2} 'Concentration',
    {3} 'Scroll'
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
      {10} 'Attraction Type',
      {11} 'Dialogue Subtype',
      {12} 'Quest Target',
      {13} 'Anim Flavor',
      {14} 'Anim Gender',
      {15} 'Anim Face',
      {16} 'Quest Group',
      {17} 'Anim Injured',
      {18} 'Dispel Effect',
      {19} 'Unknown 19',
      {20} 'Unknown 20',
      {21} 'Unknown 21',
      {22} 'Unknown 22',
      {23} 'Unknown 23',
      {24} 'Unknown 24',
      {25} 'Unknown 25',
      {26} 'Quest Type',
      {27} 'Faction',
      {28} 'Unknown 28',
      {29} 'Inventory Category',
      {30} 'Unknown 30',
      {31} 'Unknown 31',
      {32} 'Affliction',
      {33} 'Hazard Effect',
      {34} 'Unknown 34',
      {35} 'Planet Type',
      {36} 'Atmosphere Type',
      {37} 'Atmosphere Toxicity',
      {38} 'Planet Gravity',
      {39} 'Planet Water Abundance',
      {40} 'Planet Water Quality',
      {41} 'Magnetosphere Type',
      {42} 'Planet Flora Probability',
      {43} 'Planet Fauna Probability',
      {44} 'Planet Trait',
      {45} 'Planet Temperature',
      {46} 'Planet Pressure',
      {47} 'Planet Flora Abundance',
      {48} 'Planet Fauna Abundance',
      {49} 'Unknown 49',                     //Biome Clutter?
      {50} 'Hand Scanner Info',
      {51} 'Ship Module Class',
      {52} 'Unknown 52',
      {53} 'Unknown 53',
      {54} 'Mission Board Type',
      {55} 'Ship Engine',
      {56} 'Unknown 56',
      {57} 'Ship Cockpit',
      {58} 'Grav Drive',
      {59} 'Perk Restriction',
      {60} 'Creature Skin',
      {61} 'Creature Size',
      {62} 'Unknown 62',
      {63} 'Photomode Category',
      {64} 'Unknown 64',
      {65} 'Unknown 65',
      {66} 'Unknown 66',
      {67} 'Unknown 67',
      {68} 'Unknown 68',
      {69} 'Houdini Biome Style',
      {70} 'Unknown 70',
      {71} 'Unknown 71',
      {72} 'Unknown 72',
      {73} 'Unknown 73',
      {74} 'Unknown 74',
      {75} 'Unknown 75',
      {76} 'Unknown 76',                         //BCT something
      {77} 'Ship Upgrade',
      {78} 'Unknown 78',
      {79} 'Unknown 79',
      {80} 'Treatment',
      {81} 'Unknown 81',
      {82} 'Crafting Resource Type',
      {83} 'Weapon Display Type'

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
    Sig2Int('CUST'), 'Custom',
    Sig2Int('PFGT'), 'Force Greet',
    Sig2Int('RUMO'), 'Rumors',
    Sig2Int('FVDL'), 'Custom FVDL',
    Sig2Int('INTI'), 'Call',
    Sig2Int('FLAT'), 'Follow',
    Sig2Int('BRIB'), 'Move',
    Sig2Int('ASKG'), 'Attack',
    Sig2Int('GIFF'), 'Inspect',
    Sig2Int('ASKF'), 'Retrieve',
    Sig2Int('STAY'), 'Stay',
    Sig2Int('RELE'), 'Release',
    Sig2Int('SHRE'), 'Show Relationships',
    Sig2Int('FRJT'), 'Reject',
    Sig2Int('HEAL'), 'Heal',
    Sig2Int('ASSI'), 'Assign',
    Sig2Int('ENTE'), 'Enter',
    Sig2Int('SCEN'), 'Custom Scene',
    Sig2Int('SHOW'), 'Show',
    Sig2Int('AGRE'), 'Agree',
    Sig2Int('REFU'), 'Refuse',
    Sig2Int('FEXT'), 'Exit Favor State',
    Sig2Int('MREF'), 'Moral Refusal',
    Sig2Int('TRAD'), 'Trade',
    Sig2Int('PRJT'), 'Pathing Refusal',
    Sig2Int('ATCK'), 'Attack',
    Sig2Int('POAT'), 'Power Attack',
    Sig2Int('BASH'), 'Bash',
    Sig2Int('HIT_'), 'Hit',
    Sig2Int('FLEE'), 'Flee',
    Sig2Int('BLED'), 'Bleed Out',
    Sig2Int('AVTH'), 'Avoid Threat',
    Sig2Int('DETH'), 'Death',
    Sig2Int('BLOC'), 'Block',
    Sig2Int('TAUT'), 'Taunt',
    Sig2Int('THGR'), 'Throw Grenade',
    Sig2Int('ALKL'), 'Ally Killed',
    Sig2Int('ORFB'), 'Order Fallback',
    Sig2Int('ORAV'), 'Order Move Up',
    Sig2Int('ORFL'), 'Order Flank',
    Sig2Int('ORTC'), 'Order Take Cover',
    Sig2Int('FLBK'), 'Retreat',
    Sig2Int('RQST'), 'Cover Me',
    Sig2Int('BGST'), 'Suppressive Fire',
    Sig2Int('CRIL'), 'Crippled Limb',
    Sig2Int('PATT'), 'Paired Attack',
    Sig2Int('STEA'), 'Steal',
    Sig2Int('YIEL'), 'Yield',
    Sig2Int('ACYI'), 'Accept Yield',
    Sig2Int('PICC'), 'Pickpocket Combat',
    Sig2Int('ASSA'), 'Assault',
    Sig2Int('MURD'), 'Murder',
    Sig2Int('ASNC'), 'Assault NC',
    Sig2Int('MUNC'), 'Murder NC',
    Sig2Int('PICN'), 'Pickpocket NC',
    Sig2Int('STFN'), 'Steal From NC',
    Sig2Int('TRAN'), 'Trespass Against NC',
    Sig2Int('TRES'), 'Trespass',
    Sig2Int('WTCR'), 'UNUSED01',
    Sig2Int('VPSS'), 'Voice Power Start Short',
    Sig2Int('VPSL'), 'Voice Power Start Long',
    Sig2Int('VPES'), 'Voice Power End Short',
    Sig2Int('VPEL'), 'Voice Power End Long',
    Sig2Int('ALIL'), 'Alert Idle',
    Sig2Int('LOIL'), 'Lost Idle',
    Sig2Int('NOTA'), 'Normal To Alert',
    Sig2Int('NOTC'), 'Normal To Combat',
    Sig2Int('NOTL'), 'Normal To Lost',
    Sig2Int('ALTN'), 'Alert To Normal',
    Sig2Int('ALTC'), 'Alert To Combat',
    Sig2Int('COTN'), 'Combat To Normal',
    Sig2Int('COLO'), 'Combat To Lost',
    Sig2Int('LOTN'), 'Lost To Normal',
    Sig2Int('LOTC'), 'Lost To Combat',
    Sig2Int('DFDA'), 'Detect Friend Die',
    Sig2Int('SERU'), 'Service Refusal',
    Sig2Int('REPA'), 'Repair',
    Sig2Int('TRAV'), 'Travel',
    Sig2Int('TRAI'), 'Training',
    Sig2Int('BAEX'), 'Barter Exit',
    Sig2Int('REEX'), 'Repair Exit',
    Sig2Int('RECH'), 'Recharge',
    Sig2Int('RCEX'), 'Recharge Exit',
    Sig2Int('TREX'), 'Training Exit',
    Sig2Int('OBCO'), 'Observe Combat',
    Sig2Int('NOTI'), 'Notice Corpse',
    Sig2Int('TITG'), 'Time To Go',
    Sig2Int('GBYE'), 'Goodbye',
    Sig2Int('HELO'), 'Hello',
    Sig2Int('SWMW'), 'Swing Melee Weapon',
    Sig2Int('FIWE'), 'Shoot Bow',
    Sig2Int('ZKEY'), 'Z Key Object',
    Sig2Int('JUMP'), 'Jump',
    Sig2Int('KNOO'), 'Knock Over Object',
    Sig2Int('DEOB'), 'Destroy Object',
    Sig2Int('STOF'), 'Standon Furniture',
    Sig2Int('LOOB'), 'Locked Object',
    Sig2Int('PICT'), 'Pickpocket Topic',
    Sig2Int('PURS'), 'Pursue Idle Topic',
    Sig2Int('IDAT'), 'Shared Info',
    Sig2Int('SCCH'), 'Scene Choice',
    Sig2Int('PCPS'), 'Player Cast Projectile Spell',
    Sig2Int('PCSS'), 'Player Cast Self Spell',
    Sig2Int('PCSH'), 'Player Shout',
    Sig2Int('IDLE'), 'Idle',
    Sig2Int('BREA'), 'Enter Sprint Breath',
    Sig2Int('ENBZ'), 'Enter Bow Zoom Breath',
    Sig2Int('EXBZ'), 'Exit Bow Zoom Breath',
    Sig2Int('ACAC'), 'Actor Collidewith Actor',
    Sig2Int('PIRN'), 'Playerin Iron Sights',
    Sig2Int('OUTB'), 'Outof Breath',
    Sig2Int('GRNT'), 'Combat Grunt',
    Sig2Int('LWBS'), 'Leave Water Breath',
    Sig2Int('IMPT'), 'Impatient Positive',
    Sig2Int('IMNG'), 'Impatient Negative',
    Sig2Int('IMNU'), 'Impatient Neutral',
    Sig2Int('IMQU'), 'Impatient Question',
    Sig2Int('WFPI'), 'Waiting For Player Input',
    Sig2Int('GREE'), 'Greeting',
    Sig2Int('PADR'), 'Player Activate Door',
    Sig2Int('PATR'), 'Player Activate Terminals',
    Sig2Int('PAFU'), 'Player Activate Furniture',
    Sig2Int('PAAC'), 'Player Activate Activators',
    Sig2Int('PACO'), 'Player Activate Container',
    Sig2Int('PAFI'), 'Player Aquire Featured Item',

    // New To Starfield
    Sig2Int('SEED'), 'Ship Enemy Engine Down',
    Sig2Int('SEER'), 'Ship Enemy Engine Repaired',
    Sig2Int('SESD'), 'Ship Enemy Shields Down',
    Sig2Int('SESR'), 'Ship Enemy Shields Repaired',
    Sig2Int('SEGD'), 'Ship Enemy Grav Jump Down',
    Sig2Int('SEGR'), 'Ship Enemy Grav Jump Repaired',
    Sig2Int('SETD'), 'Ship Enemy Thrusters Down',
    Sig2Int('SETR'), 'Ship Enemy Thrusters Repaired',
    Sig2Int('SEWD'), 'Ship Enemy Weapons Down',
    Sig2Int('SEWR'), 'Ship Enemy Weapons Repaired',
    Sig2Int('SSEC'), 'Ship Enter Combat',
    Sig2Int('SSLC'), 'Ship Leave Combat',
    Sig2Int('SSED'), 'Ship Engines Down',
    Sig2Int('SSER'), 'Ship Engines Repaired',
    Sig2Int('SSGD'), 'Ship Grav Drive Down',
    Sig2Int('SSGR'), 'Ship Grav Drive Repaired',
    Sig2Int('SSWD'), 'Ship Weapons Down',
    Sig2Int('SSWR'), 'Ship Weapons Repaired',
    Sig2Int('SSSD'), 'Ship Shields Down',
    Sig2Int('SSSZ'), 'Ship Shields ZeroHealth',
    Sig2Int('SHRP'), 'Ship Shields Repaired',
    Sig2Int('SSTD'), 'Ship Thrusters Down',
    Sig2Int('SSTR'), 'Ship Thrusters Repaired',
    Sig2Int('SCUC'), 'Ship Undocking Complete',
    Sig2Int('SCTI'), 'Ship Crew Take Off Initiated',
    Sig2Int('SCRO'), 'Ship Crew Return To Orbit',
    Sig2Int('SCLS'), 'Ship Crew Landing Start',
    Sig2Int('SCJC'), 'Ship Crew Grav Jump Calculation Complete',
    Sig2Int('SCGC'), 'Ship Crew Grav Jump Completed',
    Sig2Int('SCDI'), 'Ship Crew Enemy Docking Initiated',
    Sig2Int('SCDC'), 'Ship Crew Docking Complete',
    Sig2Int('BLHE'), 'Blocking Hellos',
    Sig2Int('ENKL'), 'Enemy Kill',
    Sig2Int('THRB'), 'Threat Backdown',
    Sig2Int('TASF'), 'Take Suppressive Fire',
    Sig2Int('RANG'), 'Enemy In Range',
    Sig2Int('RELA'), 'Reload',
    Sig2Int('TRNV'), 'Tresspass No Visual',
    Sig2Int('MCO2'), 'Max Carbon Dioxide',
    Sig2Int('STEB'), 'Steal Caught', // guessed name
    Sig2Int('STTB'), 'Steal Took Back',
    Sig2Int('USMG'), 'Use Magic',
    Sig2Int('SRTW'), 'React To Warn'
  ]);

  var wbAdvanceActionEnum := wbEnum([
    'Normal Usage',
    'Power Attack',
    'Bash',
    'Lockpick Success',
    'Lockpick Broken'
  ]);

  var wbAlignmentEnum :=
    wbEnum([
      'Good',
      'Neutral',
      'Evil',
      'Very Good',
      'Very Evil'
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

  var wbEFID := wbFormIDCk(EFID, 'Base Effect', [MGEF]);

  var wbEFIT :=
    wbStructSK(EFIT, [3, 4], '', [
      wbFloat('Magnitude', cpNormal, True),
      wbInteger('Area', itU32),
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
          wbByteArray('DamageCauseType', 4),
          {63 ptSpeechChallenge}
          wbFormIDCkNoReach('Speech Challenge', [SPCH]),
          {63 ptForm}
          wbFormID('Form'),
          {64 ptAcousticSpace}
          wbFormIDCkNoReach('Acoustic Space', [ASPC]),
          {65 ptSnapTemplateNode}
          wbFormIDCkNoReach('Snap Template Node', [STMP]),
          {66 ptBiomeMask}
          wbByteArray('Biome Mask', 4),
          {67 ptPerkCategory}
          wbByteArray('Perk Category', 4),
          {68 ptPerkSkillGroupComparison}
          wbByteArray('Perk Skill Group Comparison', 4),
          {69 ptPerkSkillGroup}
          wbByteArray('Perk Skill Group', 4),
          {70 ptReactionType}
          wbByteArray('Reaction Type', 4),
          {71 ptLimbCategory}
          wbByteArray('Limb Category', 4)
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
          {65 ptSnapTemplateNode}
          wbFormIDCkNoReach('Snap Template Node', [STMP]),
          {66 ptBiomeMask}
          wbByteArray('Biome Mask', 4),
          {67 ptPerkCategory}
          wbByteArray('Perk Category', 4),
          {68 ptPerkSkillGroupComparison}
          wbByteArray('Perk Skill Group Comparison', 4),
          {69 ptPerkSkillGroup}
          wbByteArray('Perk Skill Group', 4),
          {70 ptReactionType}
          wbByteArray('Reaction Type', 4),
          {71 ptLimbCategory}
          wbByteArray('Limb Category', 4)
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
          { 8} 'Unknown 8',
          { 9} 'Command Target',
          {10} 'Event Camera Ref',
          {11} 'My Killer',
          {12} 'Unknown 12',
          {13} 'Unknown 13',
          {14} 'Player Ship'
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
        wbInteger('Parameter #3', itS32, nil, cpNormal, False, nil, nil, -1)
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

  var wbATCP := wbInteger(ATCP, 'Activity Count', itU32, nil, cpBenign);
  var wbATCPReq := wbInteger(ATCP, 'Activity Count', itU32, nil, cpBenign, True);
  var wbATAN := wbRStruct('Activity', [
      wbString(ATAN),
      wbFULL,
      wbDESC.SetRequired,
      wbRStructs('Progression Evaluator', 'Argument', [
        wbString(DNAM, 'Name').SetRequired,
        wbCITCReq,
        wbCTDAsCount.SetRequired(False)
      ], []).SetRequired,
      wbRStruct('Progression Configuration', [
        wbString(ANAM).SetRequired,
        wbString(ATAV, 'Configuration').IncludeFlag(dfNoZeroTerminator).SetRequired,
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
      wbActorValue,
      wbFloat('Value'),
      wbFromVersion(152, wbFormIDCk('Curve Table', [CURV, NULL]))
    ]).SetToStr(wbObjectPropertyToStr).IncludeFlag(dfCollapsed, wbCollapseObjectProperties);

  var wbPRPS := wbArrayS(PRPS, 'Properties', wbObjectProperty);

  var wbCrowdProperty :=
    wbStructSK([0], 'Property', [
      wbFormIDCk('Actor', [NPC_]),
      wbFloat('Value'),
      wbFromVersion(152, wbFormIDCk('Curve Table', [CURV, NULL]))
    ]).SetToStr(wbCrowdPropertyToStr).IncludeFlag(dfCollapsed, wbCollapseObjectProperties);

  var wbCrowdPRPS := wbArrayS(PRPS, 'Properties', wbCrowdProperty);

  var wbFLTR := wbString(FLTR, 'Filter');
  var wbAPPR := wbArray(APPR, 'Attach Parent Slots', wbFormIDCk('Keyword', [KYWD]));
  var wbFTYP := wbArray(FTYP, 'Forced Location Ref Types', wbFormIDCk('Forced Location Ref Type', [LCRT]));
  var wbATTX := wbLStringKC(ATTX, 'Activate Text Override', 0, cpTranslate);
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
    ])).SetAfterSet(wbUpdateSameParentUnions),
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

  wbBaseFormComponents := wbRArray('Components',
    wbRStructSK([0], 'Component', [
      wbString(BFCB, 'Component Type').SetFormaterOnValue(wbStringEnum([
        'BGSActivityTracker',
        'BGSAddToInventoryOnDestroy_Component',
        'BGSAnimationGraph_Component',
        'BGSAttachParentArray_Component',
        'BGSBlockCellHeighGrid_Component',
        'SurfaceTreePatternSwapInfo_Component',
        'BGSBlockEditorMetaData_Component',
        'BGSBodyPartInfo_Component',
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
        'BGSWorkshopItemColor',
        'BlockHeightAdjustment_Component',
        'Blueprint_Component',
        'HoudiniData_Component',
        'LensFlareAttachmentFormComponent',
        'LightAnimFormComponent',
        'LightAttachmentFormComponent',
        'ParticleSystem_Component',
        'ReflectionProbes_Component',
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
        wbRStruct('Component Data - Animation Graph', [
          wbString(ANAM, 'Animation Root'),
          wbString(BNAM, 'Skeleton'),
          wbString(CNAM, 'Animations'),
          wbString(DNAM, 'Response Handler'),
          wbString(ENAM)
        ], []),
        //BGSAttachParentArray_Component
        wbRStruct('Component Data - Attach Parent', [
          wbAPPR
        ], []),
        //BGSActivityTracker
        wbRStruct('Component Data - Activity Tracker', [
          wbActivityTracker
        ], []),
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
        ], []),
        //BGSCrowdComponent_Component
        wbRStruct('Component Data - Crowd', [
          wbFloat(CDND),
          wbUnknown(CDNS),
          wbRStructs('Unknown', 'Unknown', [
            wbCrowdPRPS,
            wbCITCReq,
            wbCTDAsCount,
            wbString(STRV),
            wbFloat(FLTV)
          ], [])
        ], []),
        wbRStruct('Component Data - Container Items', [
          wbContainerItems
        ], []),

        wbRStruct('Component Data - DAT2', [
          wbUnion(DAT2, 'Data', wbBFCDAT2Decider, [
            wbUnknown,
            //BlockHeightAdjustment_Component
            wbStruct('Block Height Adjustments', [
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
            .IncludeFlag(dfCollapsed)
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
              wbUnknown(8),
              wbFloat('Mass (in SM)', cpNormal, False, 1/1.98847E30, 2),
              wbFloat('Radius (in km)'),
              wbFloat('Unknown')
            ]),
            //BGSOrbitalDataComponent_Component
            wbStruct('', [
              wbUnknown()
            ]),
            //BGSBlockEditorMetaData_Component
            wbStruct('', [
              wbLenString('Unknown'),
              wbUnknown(1),
              wbLenString('Unknown'),
              wbLenString('Unknown'),
              wbArray('Unknown', wbUnknown(4), -1).IncludeFlag(dfNotAlignable),
              wbInteger('Unknown', itS32),
              wbInteger('Unknown', itS32),
              wbInteger('Unknown', itS32),
              wbInteger('Unknown', itS32),
              wbUnknown
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
          wbArray(DCSD, 'Unknown', wbStruct('Unknown', [
            wbFormIDCk('Display Filter', [FLST]),
            wbUnknown(4),
            wbInteger('Index', itU32),
            wbUnknown(4)
          ])),
          wbArray(DCED, 'Unknown', wbUnknown(4))
        ], []),
        wbRStruct('Component Data - Destructible', [
          wbDest
        ], []),
        //BGSSpaceshipEquipment_Component
        wbRStruct('Component Data - Spaceship Equipment', [
          wbUnknown(ESSF)
        ], []),
        //BGSExternalComponentDataSource_Component
        wbRStruct('Component Data - External Data Source', [
          wbFormIDCk(EXDC, 'External Base Template', [NULL, GBFM, LVLB]).SetRequired,
          wbRStruct('External Data Sources', [
            wbInteger(EXDZ, 'Data Source Count', itU32).SetRequired, // count for EXCN/EXCI struct array
            wbRArray('External Sources',
              wbRStruct('Component', [
                wbString(EXCN, 'Component Name').SetRequired,
                wbFormIDCk(EXCI, 'Component Source', [GBFM, LVLB]).SetRequired
              ], [])
            ).SetCountPath(EXDZ)
          ], []).SetRequired,
          wbRstruct('Unknown', [
            wbInteger(EXAC, 'Count', itU32).SetRequired, // count for EXAS array
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
          wbStruct(FLCS, 'Unknown', [
            wbFloat,
            wbFloat,
            wbFloat,
            wbFloat,
            wbFloat
          ])
        ], []),
        wbRStruct('Component Data - FLLD', [
          wbFLLD
        ], []),
        wbRStruct('Component Data - FTYP', [
          wbFTYP
        ], []),
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
        wbRStruct('Component Data - Add to inventory on destroy', [
          wbFormIDCk(INAM, 'Add to inventory on destroy', [LVLI])
        ], []),
        //BGSObjectWindowFilter_Component
        wbRStruct('Component Data - Object Window Filter', [
          wbUnknown(INTV),
          wbString(FLTR, 'Filter')
        ], []),
        //BGSFormLinkData_Component
        wbRStruct('Component Data - Form Links', [
          wbInteger(ITMC, 'Count', itU32),
          wbRArray('Linked Forms', wbRStruct('Linked Form', [
            wbFormIDCk(FLKW,'Keyword', [KYWD]),
            wbFormID(FLFM, 'Linked Form')
          ], []))
        ], []),
        wbRStruct('Component Data - Keywords', [
          wbKeywords
        ], []),
        //TESImageSpaceModifiableForm_Component
        wbRStruct('Component Data - Image Space Adapter', [
          wbFormIDCk(MNAM, 'Image Space Adapter', [IMAD])
        ], []),
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
        wbRStruct('Component Data - SNAM', [
          wbUnknown(SNAM),
          wbUnknown(PNAM),
          wbFormIDCk(BNAM, 'Surface Block', [SFBK])
        ], []),
        wbRStruct('Component Data - Spawn on destroy', [
          wbFormIDCk(SODA, 'Spawn on destroy', sigBaseObjects)
        ], []),
        //BGSSoundTag_Component
        wbRStruct('Component Data - Sound Tag', [
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
                wbFormIDCk('Unknown', [ACTI]),
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
          wbUnknown(ZNAM, 4),
          wbUnknown(YNAM, 1),
          wbUnknown(XNAM, 4),
          wbUnknown(WNAM, 4),
          wbUnknown(VNAM, 1),
          wbUnknown(UNAM, 4),
          wbFloat(NAM1),
          wbFormIDCk(NAM2, 'Unknown', [NULL, GLOB]),
          wbUnknown(NAM3, 4),
          wbUnknown(NAM4).IncludeFlag(dfNoReport),
          wbUnknown(NAM5, 4),
          wbUnknown(NAM6, 4),
          wbUnknown(NAM7, 4),
          wbUnknown(NAM8, 1),
          wbUnknown(NAM9, 4),
          wbCITCReq,
          wbCTDAsCount
        ], [])
      ], []),
      wbEmpty(BFCE, 'End Marker', cpIgnore, True)
    ], [])
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

  var wbSNAMMarkerParams :=
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
      ])).IncludeFlag(dfCollapsed)),
      wbFromVersion(125, wbByteArray('Unknown', 3)),
      wbFromVersion(555, wbByteArray('Unknown', 4))
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
      ])).SetCountPath(csPropertyCount);

  var wbOBTSReq := wbStruct(OBTS, 'Object Mod Template Item', [
    wbInteger(csIncludeCount, itU32),
    wbInteger(csPropertyCount, itU32),
    wbInteger('Level Min', itU16),
    wbInteger('Level Max', itU16),
    wbInteger('Addon Index', itS16),
    wbInteger('Default', itU8, wbBoolEnum),
    wbArray('Keywords', wbFormIDCk('Keyword', [KYWD, NULL]), -4),
    wbInteger('Min Level For Ranks', itU8),
    wbInteger('Alt Levels Per Tier', itU8),
    wbArray('Includes', wbStruct('Include', [
      wbFormIDCk('Mod', [OMOD]),
      wbInteger('Attach Point Index', itU8),
      wbInteger('Optional', itU8, wbBoolEnum),
      wbInteger('Don''t Use All', itU8, wbBoolEnum)
    ])).SetCountPath(csIncludeCount),
    wbObjectModProperties
    ], cpNormal, True)
      .SetSummaryKeyOnValue([6,9,10])
      .IncludeFlagOnValue(dfSummaryMembersNoName);

  var wbObjectTemplate := wbRStruct('Object Template', [
    wbInteger(OBTE, 'Count', itU32, nil, cpBenign),
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

  var wbBSMPSequence := wbRArray('Bone Data', wbBoneDataItem);

  var wbArmorAddonBSMPSequence := wbRArray('Bone Data', wbArmorAddonBoneDataItem);

  {subrecords checked against Starfield.esm}
  var wbEffect :=
    wbRStruct('Effect', [
      wbEFID,
      wbEFIT,
      wbCTDAs,
      wbFormIDCk(MNAM, 'Magnitude', [GLOB]),
      wbFormIDCk(ANAM, 'Area', [GLOB]),
      wbFormIDCk(ZNAM, 'Duration', [GLOB]),
      wbInteger(EFIF, 'Unknown', itU32),
      wbInteger(MUID, 'Unknown', itU32)
    ], [], cpNormal, True);

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
          wbMODT, // can still be read, might not be properly supported anymore, doesn't occur in Starfield.esm
          wbMOLM(MOLM),
          wbFLLD,
          wbUnknown(XFLG),
          wbMODC
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
      {0x10000000} 28, 'Unknown 28',
      {0x20000000} 29, 'Child Can Use',
      {0x40000000} 30, 'NavMesh Generation - Ground'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbXALG,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(),
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbFTYP,
    wbNTRM,
    wbByteColors(PNAM, 'Marker Color'),
    wbString(WMAT, 'Water Material'),
    wbFormIDCk(WTFM, 'Water', [WATR]),
    wbALSH,
    wbACSH,
    wbATTX,
    wbInteger(FNAM, 'Flags', itU16, wbFlags([
      'No Displacement',
      'Ignored by Sandbox',
      'Unknown 2',
      'Unknown 3',
      'Is a Radio',
      'Unknown 5',
      'Unknown 6'
    ])),
    wbInteger(JNAM, 'Activation Angle', itU16),
    wbEmpty(INAM), //unknown if here or any later position
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
  ]);

  (* still exists in game code, but not in Starfield.esm * )
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
    wbGenericModel(),
    wbDEST,
    wbKSIZ,
    wbKWDAs,
    wbUnknown(PNAM, cpIgnore, True),
    wbFormIDCk(SNAM, 'Looping Sound', [SNDR]),
    wbUnknown(FNAM, cpIgnore, True),
    wbFormIDCk(VNAM, 'Voice Type', [VTYP])
  ], False, nil, cpNormal, False, nil, wbKeywordsAfterSet);
  *)

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
    wbGenericModel(),
    wbPUSH,
    wbPDSH,
    wbCUSH,
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
      wbFormIDCk('Addiction', [NULL, SPEL]),
      wbFloat('Addiction Chance'),
      wbSoundReference
    ], cpNormal, True),
    wbLStringKC(DNAM, 'Addiction Name', 0, cpTranslate),
    wbEffects
  ], False, nil, cpNormal, False);

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
    wbGenericModel(),
    wbPUSH,
    wbPDSH,
    wbDESC,
    wbKeywords,
//    wbDEST,
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
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000200}  9, 'Unknown 9'
    ]), [9]), [
    wbEDID,
    wbXALG,
    wbBaseFormComponents,
    wbGenericModel()
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
    wbPTT2,
    wbBaseFormComponents,
    wbFULL,
    wbEITM,
    wbTexturedModel('Male world model', [MOD2, MO2T], [wbMOLM(MLM2), wbMO2C, wbMO2S, wbMO2F]),
    wbTexturedModel('Female world model', [MOD4, MO4T], [wbMOLM(MLM4), wbMO4C, wbMO4S, wbMO4F]),
    wbBO64,
    wbPUSH,
    wbPDSH,
//    wbDEST,
//    ,
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
      wbUnused(3)
    ]),
    wbDamageTypeArray('Resistance'),
//    wbFormIDCk(TNAM, 'Template Armor', [ARMO]),
    wbAPPR,
    wbObjectTemplate,
    wbEmpty(STOP, 'Marker', cpNormal, True),
    wbStruct(AVSG, 'Voice', [
      wbWwiseGuid('Category'),
      wbWwiseGuid('Value')
    ]),
    wbStruct(AFSG, 'Footstep', [
      wbWwiseGuid('Category'),
      wbWwiseGuid('Value')
    ])
  ], False, nil, cpNormal, False).SetIgnoreList([FLLD, XFLG]);

  var wbAVMDMNAMReq :=
    wbInteger(MNAM, 'Type', itU32, wbEnumSummary([
      ''              , '',
      'Simple Group'  , 'Simple',
      'Complex Group' , 'Complex',
      'Modulation'    , 'Modulation'
    ])).SetRequired;

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
    wbBO64,
    wbFormIDCk(RNAM, 'Race', [RACE]),
    wbStruct(DNAM, 'Data', [
      wbUnknown(9), //always 00 00 00 00 00 00 00 00 00 in Starfield.esm
      wbFloat
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
      wbByteArray('Unknown', 2),
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
    wbFormIDCk(PNAM, 'Body Part Data', [BPTD]),
    wbRStruct('AVM Data',[
      wbAVMDMNAMReq,
      wbString(TNAM, 'Color Mapping')
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
       wbString(SNAM, 'Entry Name'),
       wbString(VNAM, 'Entry Value')
    ], []),
    wbRStructs('Bone Datas', 'Bone Data', [
      wbInteger(BSMP, 'Gender', itU32, wbEnum(['Male', 'Female'])),
      wbRArray('Modifiers', wbFormIDCk(BNAM, 'Modifier', [BMOD]))
    ], [])
  ], False, nil, cpNormal, False).SetIgnoreList([FLLD, XFLG]);

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
    wbGenericModel(),
    wbDESCreq,
    wbPUSH,
    wbPDSH,
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
        wbUnused(4),
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
    wbLStringKC(ENAM, 'Unknown', 0, cpTranslate),
    wbLStringKC(FNAM, 'Unknown', 0, cpTranslate),
    wbFormIDCk(INAM, 'Inventory Art', [STAT]),
    wbFormIDCk(GNAM, 'Scene', [SCEN])
  ], False, nil, cpNormal, False, nil, wbKeywordsAfterSet);

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
        wbFlags(wbRecordFlagsFlags, wbFlagsList([
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

        wbFormIDCk(XEZN, 'Encounter Location', [LCTN]),

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
    .IncludeFlag(dfFastAssign);

  {subrecords checked against Starfield.esm}
  wbRecord(CELL, 'Cell',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  2, 'Unknown 2',
      {0x00000400}  7, 'No Pre Vis',
      {0x00000400} 10, 'Persistent',
      {0x00020000} 17, 'Off Limits',
      {0x00040000} 18, 'Compressed',
      {0x00080000} 19, 'Can''t Wait',
      {0x00400000} 22, 'Unknown 22'
    ]), [18]), [
    wbEDID,
    wbBaseFormComponents,
    wbFULL,
    wbInteger(DATA, 'Flags', itU32, wbFlags([
      {0x00000001} 'Is Interior Cell',
      {0x00000002} 'Has Water',
      {0x00000004} 'Can Travel From Here',
      {0x00000008} 'No LOD Water',
      {0x00000010} 'Unknown 4',
      {0x00000020} 'Public Area',
      {0x00000040} 'Hand Changed',
      {0x00000080} 'Show Sky',
      {0x00000100} 'Use Sky Lighting',
      {0x00000200} 'Unknown 9',
      {0x00000400} 'Hidden from Interior Cell List',
      {0x00000800} 'Sunlight Shadows',
      {0x00001000} 'Distant LOD only',
      {0x00002000} 'Player Followers Can''t Travel Here',
      {0x00004000} 'Unknown 14',
      {0x00008000} 'Unknown 15',
      {0x00010000} 'Unknown 16',
      {0x00020000} 'Unknown 17',
      {0x00040000} '',
      {0x00080000} 'Unknown 19'
    ]), cpNormal, True, False, nil, wbCELLDATAAfterSet),

    wbCellGrid,

    wbStruct(XCLL, 'Lighting', [
    {  0} wbByteColors('Ambient Color'),
    {  4} wbByteColors('Directional Color'),
    {  8} wbByteColors('Fog Color Near'),
    { 12} wbFloat('Fog Near'),
    { 16} wbFloat('Fog Far'),
    { 20} wbInteger('Directional Rotation XY', itS32),
    { 24} wbInteger('Directional Rotation Z', itS32),
    { 28} wbFloat('Directional Fade'),
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
    {104} wbInteger('Flags', itU8, wbFlags([
            'Unknown 0',
            'Unknown 1',
            'Unknown 2'
          ])),
    {105} wbUnused(3)
    {108}
    ]),

    wbUnused(MHDT, 2504, False).SetDontShow(wbNeverShow),

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

    wbFormIDCk(XCMO, 'Music Type', [MUSC]),

    wbRStruct('Global Dirt Layer', [
      wbString(XCGD, 'Material'),
      wbInteger(XCIB, 'Unknown', itU8, wbBoolEnum)
    ], []),

    wbFormIDCk(TODD, 'Time Of Day Data', [TODD]),

    wbFormIDCk(XEZN, 'Encounter Location', [LCTN]),

    wbLinkedReferences,

    wbString(XEMP, 'Environment Map'),

    wbXTV2
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

  {subrecords checked against Starfield.esm}
  wbRecord(SPGD, 'Shader Particle Geometry', [
    wbEDID,
    wbStruct(DATA, 'Data', [
      wbFloat('Gravity Velocity'),
      wbUnknown(4),
      wbFloat('Rotation Velocity'),
      wbUnknown(4),
      wbFloat('Particle Size X'),
      wbFloat('Center Offset Min'),
      wbFloat('Particle Size Y'),
      wbUnknown(4),
      wbFloat('Center Offset Min'),
      wbUnknown(4),
      wbFloat('Center Offset Max'),
      wbUnknown(4),
      wbFloat('Initial Rotation'),
      wbUnknown(4),
      wbInteger('# of Subtextures X', itU32),
      wbUnknown(4),
      wbInteger('# of Subtextures Y', itU32),
      wbUnknown(4),
      wbInteger('Type', itU32, wbEnum([
        'Rain',
        'Snow',
        'Unknown 2'
      ])),
      wbUnknown(4),
      wbInteger('Box Size', itU32),
      wbUnknown(4),
      wbFloat('Particle Density'),
      wbUnknown
    ], cpNormal, True, nil, 10),
    wbString(MNAM, 'Particle Texture')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CONT, 'Container',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00008000} 15, 'Has Distant LOD',
      {0x00010000} 16, 'Random Anim Start',
      {0x02000000} 25, 'Obstacle',
      {0x04000000} 26, 'NavMesh Generation - Filter',
      {0x08000000} 27, 'NavMesh Generation - Bounding Box',
      {0x10000000} 28, 'Unknown 28',
      {0x40000000} 30, 'NavMesh Generation - Ground'
    ])), [

    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbXALG,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(),
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
    wbNTRM,
    wbPRPS,
    wbAPPR,
//    wbObjectTemplate, likely, but doesn't occur in Starfield.esm
    wbEmpty(STOP, 'Marker'),
    wbSoundReference(WED0),
    wbSoundReference(WED1),
    wbFormIDCk(ONAM, 'Display Filter', [FLST])
  ], False, nil, cpNormal, False, nil, wbContainerAfterSet);

  var wbAIDT :=
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
          wbUnknown(1)
    ], cpNormal, True);

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
      wbFloat,
      wbFloat,
      wbFloat
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
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat
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
      wbFloat,
      wbFloat
    ], cpNormal, True),
    wbStruct(CSLR, 'Long Range', [
      wbFloat('Strafe Mult'),
      wbFloat('Adjust Range Mult'),
      wbFloat('Crouch Mult'),
      wbFloat('Wait Mult'),
      wbFloat('Range Mult'),
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat
    ], cpNormal, True, nil, 3),
    wbStruct(CSCV, 'Cover Search', [
      wbFloat('Cover Search Distance Mult', cpNormal, True),
      wbFloat
    ], cpNormal, True),
    wbStruct(CSFL, 'Flight', [
      wbFloat('Hover Chance'),
      wbFloat('Dive Bomb Chance'),
      wbFloat('Ground Attack Chance'),
      wbFloat('Hover Time'),
      wbFloat('Ground Attack Time'),
      wbFloat('Perch Attack Chance'),
      wbFloat('Perch Attack Time'),
      wbFloat('Flying Attack Chance')
    ], cpNormal, True),
    wbStruct(CSTN, 'Unknown', [
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat
    ]),
    wbStruct(CSSG, 'Unknown', [
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbInteger('Unknown', itU8, wbBoolEnum),
      wbInteger('Unknown', itU8, wbBoolEnum),
      wbUnknown(2),
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat
    ]),
    wbStruct(CSSM, 'Unknown', [
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbUnknown(4),
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbUnknown(8),
      wbFloat
    ]),
    wbStruct(CSSR, 'Unknown', [
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat
    ]),
    wbStruct(CSSA, 'Unknown', [
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat
    ]),
    wbStruct(CSSD, 'Unknown', [
      wbFloat,
      wbFloat,
      wbFloat
    ]),
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

  {subrecords checked against Starfield.esm}
  wbRecord(DIAL, 'Dialog Topic', [
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
        { 3} 'Custom FVDL',
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
        {17} 'Custom Scene',
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
       {124} 'PlayerAquireFeaturedItem',
       {125} 'QuestOrSpecialHellos', // special hellos?
       {126} 'Unknown 126',
       {127} 'Unknown 127',
       {128} 'Unknown 128',
       {129} 'Unknown 129',
       {130} 'Unknown 130',
       {131} 'Unknown 131',
       {132} 'Unknown 132',
       {133} 'Unknown 133',
       {134} 'Unknown',
       {135} 'GravJumpCalcComplete',
       {136} 'LandingStart',
       {137} 'ReturnToOrbit',
       {138} 'DockingComplete',
       {139} 'UndockingComplete',
       {140} 'EnemyDockingInitiated',
       {141} 'GravJumpCompleted',
       {142} 'TakeOffInitiated',
       {143} 'GuardPursue',   // stop right there, criminal scum
       {144} 'SharedInfos', // lines used across many interactions, both for player and npc. distinct from 99 somehow?
       {145} 'Unknown 145',
       {146} 'Unknown 146',
       {147} 'Unknown 147',
       {148} 'Unknown 148',
       {149} 'Idles',
       {150} 'SprintBreathing', // 0005C8C5
       {151} 'BowZoomHoldBreath', // 0005C8C7
       {152} 'BowZoomReleaseBreath', // 0005C8C6
       {153} 'Unknown 153',
       {154} 'Unknown 154',
       {155} 'PlayerOutOfBreath', // 0005C8CA
       {156} 'Unknown 156',
       {157} 'LeaveWaterBreath', // 0005C8C8
       {158} 'Unknown 158',
       {159} 'Unknown 159',
       {160} 'Unknown 160',
       {161} 'Unknown 161',
       {162} 'WaitingForPlayerInput',
       {163} 'Unknown 163',
       {164} 'Unknown 164',
       {165} 'Unknown 165',
       {166} 'Unknown 166',
       {167} 'Unknown 167',
       {168} 'Unknown 168',
       {169} 'Unknown 169',
       {170} 'MaxCO2OutOfBreath', // 00076E87
       {171} 'BlockingHellos'
      ]))
    ]),
    wbInteger(SNAM, 'Subtype Name', itU32, wbDialogueSubtypeEnum),
    wbArray(TIFL, 'Topic Info List', wbFormIDCk('Topic', [INFO])),
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
    wbXALG,
//    wbPTT2,
//    wbSNTP,
//    wbSNBH,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(),
//    wbDEST,
    wbKeywords,
    wbNTRM,
    wbFTYP,
    wbPRPS,

    wbSoundReference(DOSH, 'Open Sound'),
    wbSoundReference(DCSH, 'Close Sound'),
    wbSoundReference(DLSH, 'Lock Sound'),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      'Unknown 0',
      'Automatic',
      'Hidden',
      'Minimal Use',
      'Sliding',
      'Do Not Open in Combat Search',
      'No "To" Text',
      'Unknown 7'
    ]), cpNormal, True),
    wbLStringKC(ONAM, 'Alternate Text - Open', 0, cpTranslate),
    wbLStringKC(CNAM, 'Alternate Text - Close', 0, cpTranslate),
    wbUnknown(DEVT),
    wbUnknown(ANAM),
    wbNVNM
  ]);

  var wbBlendModeEnum := wbEnum([
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

  var wbBlendOpEnum := wbEnum([
    '',
    'Add',
    'Subtract',
    'Reverse Subtract',
    'Minimum',
    'Maximum'
  ]);

  var wbZTestFuncEnum := wbEnum([
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
    wbFormIDCk(ENAM, 'Effect Sequence', [EFSQ]),
    wbEmpty(DATA, 'Empty', cpIgnore),
    wbStruct(DNAM, 'Data', [
      wbFloat,
      wbByteColors,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbSoundReference('Sounds'),
      wbUnknown(5)                                                       //Flags?
    ]),
    wbGenericModel()
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ENCH, 'Object Effect', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbFULL,
    wbStruct(ENIT, 'Effect Data', [
      wbUnknown(27)
      {
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
      wbUnknown}
    ], cpNormal, True, nil, 8),
    wbEffectsReq
  ]);

  (* still exists in game code, but not in Starfield.esm
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
  *)

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
        {0x00010000} 'Unknown 16',
        {0x00020000} 'Unknown 17',
        {0x00040000} 'Unknown 18'
      ])).IncludeFlag(dfCollapsed)
    ], cpNormal, True, nil, 1).SetSummaryKeyOnValue([0]),
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
    ], cpNormal, False, nil, 7)
    .SetSummaryKeyOnValue([0,1]),
//    wbRArrayS('Ranks', wbFactionRank),
    wbFormIDCk(VEND, 'Vendor Buy/Sell List', [FLST]),
    wbFormIDCk(VENC, 'Merchant Container', [REFR]),
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
      .IncludeFlag(dfCollapsed)
    ),

    wbStruct(VENV, 'Vendor Values', [
      wbInteger('Start Hour', itU16),
      wbInteger('End Hour', itU16),
//     wbInteger('Radius', itU16),
//      wbByteArray('Unknown 1', 2),
      wbFloat,
      wbInteger('Buys Stolen Items', itU8, wbBoolEnum),
      wbInteger('Buy/Sell Everything Not In List?', itU8, wbBoolEnum),
      wbInteger('Buys NonStolen Items', itU8, wbBoolEnum),
      wbInteger('Unknown', itU8)
    ])
    .SetSummaryKeyOnValue([0,1,4,5])
    .SetSummaryPrefixSuffixOnValue(4,'Fence = ',',')
    .SetSummaryPrefixSuffixOnValue(5,'Limited Inv. = ','')
    .SetSummaryPrefixSuffixOnValue(0,'Hours = ',' to')
    .SetSummaryPrefixSuffixOnValue(1,'',',')
    .IncludeFlagOnValue(dfSummaryMembersNoName),
    wbPLVD,
    wbFormIDCk(VTCK, 'Voice', [FLST, VTYP]),
    wbRStruct('Unknown', [
      wbMarkerReq(CRHR),
      wbStruct(HERD, 'Unknown', [
        wbFloat,
        wbUnknown
      ]).SetRequired
    ], []),
    wbRStruct('Unknown', [
      wbMarkerReq(CRGP),
      wbFloat(GRPH).SetRequired
    ], [])

    //wbCITC,
    //wbCTDAsCount
  ], False, nil, cpNormal, False, nil {wbFACTAfterLoad}, wbConditionsAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(AFFE, 'Affinity Event', [
    wbEDID,
    wbInteger(FNAM, 'Flags', itU32, wbFlags([
      'Unknown 0',
      'Unknown 1',
      'Unknown 2'
    ])).SetRequired, //req
    wbNLDT,
    wbRStructsSK('Reaction Data', 'Follower', [0], [
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
      {0x00020000} 17, 'Unknown 17',
      {0x00800000} 23, 'Is Marker',
      {0x02000000} 25, 'Power Armor',
      {0x08000000} 27, 'Unknown 27',
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
    wbGenericModel(),
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbFTYP,
    wbUnknown(PNAM),
    wbATTX,
    wbALSH,
    wbInteger(FNAM, 'Flags', itU16, wbFlags([
      {0x0001} 'Unknown 0',
      {0x0002} 'Ignored By Sandbox'
    ])),
    wbUnknown(JNAM),
    wbEmpty(INAM, 'Unknown'),
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
    wbFormIDCk(FTMP, 'Furniture Template', [FURN]),
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
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00080000} {15} 15, 'Restricted'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbCNAM,
    wbString(DNAM, 'Notes'),
    wbInteger(TNAM, 'Type', itU32, wbKeywordTypeEnum),
    wbUnknown(FNAM),
    wbString(ENAM),
    wbFormIDCk(DATA, 'Attraction Rule', [AORU]),
    wbFULL
    //wbString(NNAM, 'Display Name') {Legacy record replaced with FULL}
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
  ]).SetSummaryKey([2]);

  {subrecords checked against Starfield.esm}
  wbRecord(TXST, 'Texture Set', [
    wbEDID,
    wbOBND(True),
    wbODTY,
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
      {0x0010} 'Unknown 3'
    ]), cpNormal, True),
    wbString(MNAM, 'Material')
  ]).SetSummaryKey([3, 4]);

  {subrecords checked against Starfield.esm}
  wbRecord(HDPT, 'Head Part',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  2, 'Non-Playable'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(),
    wbInteger(DATA, 'Flags', itU8, wbFlags([
      {0x01} 'Playable',
      {0x02} 'Male',
      {0x04} 'Female',
      {0x10} 'Is Extra Part',
      {0x20} 'Use Solid Tint',
      {0x40} 'Uses Body Texture',
      {0x80} 'Unknown 6'
    ]), cpNormal, True),
    wbInteger(PNAM, 'Type', itU32, wbEnum([
      'Misc',
      'Face',
      'Right Eye',
      'Hair',
      'Facial Hair',
      'Scar',
      'Eyebrows',
      'Meatcaps',
      'Teeth',
      'Head Rear',
      'Unknown 10',
      'Unknown 11',             //Only used on "Buzz front" extra head parts, which are atttached to the "buzz back"  chargen option
      'Left Eye',
      'Eyelashes'
    ])),
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
//    wbFormIDCk(CNAM, 'Color', [CLFM]),
    wbFormIDCk(RNAM, 'Valid Races', [FLST]),
    wbFormIDCk(MNAM, 'Morph', [MRPH])
//    wbCTDAs
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(ASPC, 'Acoustic Space', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbSoundReference(ASLS),
    wbSoundReference(WED0),
    wbSoundReference(WED1),
    wbFormIDCk(AAMB, 'Ambient Set', [AMBS]),
    wbFormIDCk(AMUS, 'Music', [MUSC]),
    wbFormIDCk(BNAM, 'Environment Type', [REVB]),
    wbFloat(AEAR),
    wbFloat(FLTV),
    wbInteger(XTRI, 'Is Interior', itU8, wbBoolEnum, cpNormal, True),
    wbInteger(BOLV, 'Unknown', itU8), // looks like probably a boolean
    wbUnknown(DEVT),
    wbUnknown(ASDF)
  ]);

  {subrecords checked against Starfield.esm}
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
      {0x10000000} 28, 'Unknown 28',
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
    wbXALG,
    wbBaseFormComponents,
    wbPTT2,
    wbFULL,
    wbGenericModel(),
    wbDEST,
    wbKeywords,
    wbPRPS,
    //wbInteger(DATA, 'On Local Map', itU8, wbBoolEnum, cpNormal, True),
    wbInteger(DATA, 'Unknown', itU8).SetRequired,        //Values seen are 02, 04, and 06
    wbSoundReference(MSLS),
    wbFloat(MSMO, 'Unknown')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(IDLM, 'Idle Marker',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x20000000} 29, 'Child Can Use'
    ])), [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbKeywords,
    wbInteger(IDLF, 'Flags', itU8, wbFlags([
      'Run in Sequence',
      'Unknown 1',
      'Do Once',
      'Unknown 3',
      'Ignored by Sandbox',
      'Unknown 5'
    ]), cpNormal, False),
    wbRStruct('Animations', [
      wbInteger(IDLC, 'Animation Count', itU32, nil, cpBenign),
      wbFloat(IDLT, 'Idle Timer Setting', cpNormal, True),
      wbArray(IDLA, 'Animations', wbFormIDCk('Animation', [IDLE]), 0, nil, wbIDLAsAfterSet, cpNormal, True)
    ], []),
    wbGenericModel(),
    wbFormIDCk(QNAM, 'Animation Flavor', [KYWD]),
    wbFormIDCk(PNAM, 'Unknown', [KYWD])                              //Anim Archetype? Only one record uses it
  ], False, nil, cpNormal, False);

  {subrecords checked against Starfield.esm}
  wbRecord(PROJ, 'Projectile', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(),
    wbDEST,
    wbUnused(DATA, True),
    wbStruct(PROD, 'Data', [
    {  0} wbInteger('Flags', itU16, wbFlags([
            {0x0001} 'Hitscan',
            {0x0002} 'Explosion',
            {0x0004} 'Alt. Trigger',
            {0x0008} 'Muzzle Flash',
            {0x0010} 'Unknown 4',
            {0x0020} 'Can Be Disabled',
            {0x0040} 'Can Be Picked Up',
            {0x0080} 'Supersonic',
            {0x0100} 'Pins Limbs',
            {0x0200} 'Pass Through Small Transparent',
            {0x0400} 'Disable Combat Aim Correction',
            {0x0800} 'Penetrates Geometry',
            {0x1000} 'Continuous Update',
            {0x2000} 'Seeks Target',
            {0x4000} 'Unknown 14',
            {0x8000} 'Unknown 15'
          ])),
    {  2} wbInteger('Type', itU16, wbEnum([], [
              0, 'Bullet',
            $01, 'Missile',
            $02, 'Lobber',
            $04, 'Beam',
              5, 'Cutter Beam',
            $08, 'Flame',
            $10, 'Cone',
            $20, 'Barrier',
            $40, 'Arrow'
          ])),
    {  4} wbFloat('Gravity'),
    {  8} wbFloat('Speed'),
    { 12} wbFloat('Range'),
    { 16} wbFormIDCk('Light', [LIGH, NULL]),
    { 20} wbFormIDCk('Muzzle Flash - Light', [LIGH, NULL]),
    { 24} wbFloat('Explosion - Alt. Trigger - Proximity'),
    { 28} wbFloat('Explosion - Alt. Trigger - Timer'),
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
    { 77} wbUnknown(4),
    { 81} wbLenString('Unknown'), //variable length!
          wbFloat,
          wbInteger('Unknown', itU32),
          wbInteger('Unknown', itU8),
          wbLenString('Unknown'), //variable length!
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat
    ]).SetRequired,

    wbRStructSK([0], 'Muzzle Flash Model', [
      wbString(NAM1, 'Model FileName'),
      wbFLLD
      //wbModelInfo(NAM2)
    ], [], cpNormal, True),
    wbSoundReference(PRAS),
    wbSoundReference(PRCS),
    wbInteger(VNAM, 'Sound Level', itU32, wbSoundLevelEnum, cpNormal, True),
    wbFormIDCk(NAM3, 'Curve Table', [CURV])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(HAZD, 'Hazard', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbXALG,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(),
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD, NULL]),
    wbStruct(DNAM, 'Data', [
      { 0} wbSoundReference,
      {40} wbFormIDCk('Effect', [SPEL, ENCH, NULL]),
      {44} wbUnknown(8),
      {52} wbFloat,
      {56} wbFloat,
      {60} wbFloat,
      {64} wbFloat,
      {68} wbFloat,
      {72} wbFloat,
      {76} wbFloat,
      {80} wbFloat,
      {84} wbUnknown(4),
      {88} wbInteger('Flags', itU32, wbFlags([
             {0x01} 'Affects Player Only',               //copied from FO4, might be wrong
             {0x02} 'Inherit Duration from Spawn Spell', //copied from FO4, might be wrong
             {0x04} 'Align to Impact Normal',            //copied from FO4, might be wrong
             {0x08} 'Inherit Radius from Spawn Spell',   //copied from FO4, might be wrong
             {0x10} 'Drop to Ground',                    //copied from FO4, might be wrong
             {0x20} 'Taper Effectiveness by Proximity',  //copied from FO4, might be wrong
             {0x40} 'Increased Gravity',
             {0x80} 'Reversed Gravity'
           ]))
      {92}

      (*
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
      *)
    ]),
    wbCTDAs
  ]);

  if wbSimpleRecords then begin

    {subrecords checked against Starfield.esm}
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
            wbInteger('Door Type', itU32, wbCRCValuesEnum),
            wbFormIDCk('Door Ref', [REFR])
          ]), -1),
          wbUnknown{
          wbInteger('Has Island Data', itU8, wbBoolEnum),
          wbUnion('Island', wbNAVIIslandDataDecider, [
            wbNull,
            wbStruct('Island Data', [
              wbByteArray('Unknown', 24),
              wbArray('Triangles', wbByteArray('Triangle', 6), -1),
              wbArray('Vertices', wbByteArray('Vertex', 12), -1)
            ])
          ]),
          wbStruct('Pathing Cell', [
            wbInteger('Type', itU32, wbCRCValuesEnum).SetDefaultEditValue('3C A0 E9 A5'),
            wbFormIDCk('Parent Worldspace', [WRLD, NULL]),
            wbUnion('Parent', wbNAVIParentDecider, [
              wbStruct('Coordinates', [
                wbInteger('Grid Y', itS16),
                wbInteger('Grid X', itS16)
              ]),
              wbFormIDCk('Parent Cell', [CELL])
            ])
          ])}
        ])
      ),
      wbStruct(NVPP, 'Preferred Pathing', [
        wbArray('NavMeshes', wbArray('Set', wbFormIDCk('', [NAVM]), -1), -1),
        wbArray('NavMesh Tree?', wbStruct('', [
          wbFormIDCk('NavMesh', [NAVM]),
          wbInteger('Index/Node', itU32)
        ]), -1)
      ])
      //wbArray(NVSI, 'Unknown', wbFormIDCk('Navigation Mesh', [NAVM]))
      //wbUnknown(NVSI)
    ]).IncludeFlag(dfExcludeFromBuildRef);

    {subrecords checked against Starfield.esm}
    wbRecord(NAVM, 'Navigation Mesh',
      wbFlags(wbRecordFlagsFlags, wbFlagsList([
        {0x00040000} 18, 'Compressed',
        {0x04000000} 26, 'AutoGen',
        {0x80000000} 31, 'Unknown 31'
      ]), [18]), [
      wbEDID,
      wbVMAD,
      wbBaseFormComponents,
      wbNVNM,
      wbMNAMNAVM
    ], False, wbNAVMAddInfo);

  end else begin

    {subrecords checked against Starfield.esm}
    wbRecord(NAVI, 'Navigation Mesh Info Map', [
      wbEDID,
      wbInteger(NVER, 'Version', itU32),
      wbRArray('Navigation Map Infos',
        wbStruct(NVMI, 'Navigation Map Info', [
          wbFormIDCk('Navigation Mesh', [NAVM]).IncludeFlag(dfSummaryNoName),
          wbInteger('Flags', itU32, wbFlags([
            '',
            '',
            '',
            '',
            '',
            'Island'
          ])).IncludeFlag(dfCollapsed), //Only the first byte is used
          wbVec3,
          wbFloat,
          //wbInteger('Preferred Merges Flag', itU32),
          wbArray('Merged To', wbFormIDCk('Mesh', [NAVM]), -1).IncludeFlag(dfCollapsed),
          wbArray('Preferred Merges', wbFormIDCk('Mesh', [NAVM]), -1).IncludeFlag(dfCollapsed),
          wbArray('Linked Doors',
            wbStruct('Door', [
              wbInteger('Door Type', itU32, wbCRCValuesEnum).SetDefaultEditValue('PathingDoor'),
              wbFormIDCk('Door Ref', [REFR])
            ])
            .SetSummaryKey([0, 1])
            .IncludeFlag(dfSummaryMembersNoName)
            .IncludeFlag(dfCollapsed)
          , -1).IncludeFlag(dfCollapsed),
          wbArray('Traversals',
            wbStruct('Traversal', [
              wbInteger('Type', itU32, wbCRCValuesEnum).SetDefaultEditValue('PathingTraversalLink'),
              wbFormIDCk('Cell or Object', [CELL, REFR]),
              wbFormIDCk('Traversal', [TRAV, REFR]),
              wbVec3('From Position'),
              wbVec3('To Position'),
              wbFloat,
              wbFloat,
              wbFloat,
              wbInteger('Flags', itU32, wbFlags([
                '',
                '',
                'Unknown 2'
              ])),
              wbFormIDCk('From Mesh', [NAVM]),
              wbFormIDCk('To Mesh', [NAVM])
            ])
            .SetSummaryKey([2, 1, 3, 9, 4, 10])
              .SetSummaryMemberPrefixSuffix(2, '', '')
              .SetSummaryMemberPrefixSuffix(1, 'in/with ', '')
              .SetSummaryMemberPrefixSuffix(3, 'from ', '')
              .SetSummaryMemberPrefixSuffix(9, 'in ', '')
              .SetSummaryMemberPrefixSuffix(4, 'to ', '')
              .SetSummaryMemberPrefixSuffix(10, 'in ', '')
            .IncludeFlag(dfSummaryMembersNoName)
            .IncludeFlag(dfCollapsed),
          -1).IncludeFlag(dfCollapsed),
          wbStruct('Optional Island Data', [
            wbInteger('Has Island Data', itU8, wbBoolEnum).SetAfterSet(wbUpdateSameParentUnions),
            wbUnion('', wbNAVIIslandDataDecider, [
              wbNull,
              wbStruct('Island Data', [

                wbVec3('Min'),
                wbVec3('Max'),

                wbArray('Triangles',
                  wbArray('Vertices', wbInteger('Vertex', itS16), 3)
                  .SetSummaryPassthroughMaxCount(3)
                , -1)
                .IncludeFlag(dfCollapsed),

                wbArray('Vertices', wbVec3('Vertex'), -1)
                .IncludeFlag(dfCollapsed)
              ])
              .SetSummaryKey([2])
              .IncludeFlag(dfSummaryMembersNoName)
              .IncludeFlag(dfCollapsed)
            ])
            .IncludeFlag(dfCollapsed)
          ])
          .SetSummaryKey([1])
          .IncludeFlag(dfSummaryMembersNoName)
          .IncludeFlag(dfCollapsed),
          wbStruct('Pathing Cell', [
            wbInteger('Type', itU32, wbCRCValuesEnum).SetDefaultEditValue('PathingCell'),
            wbFormIDCk('Parent Worldspace', [WRLD, NULL]),
            wbUnion('', wbNAVIParentDecider, [
              wbStruct('Coordinates', [
                wbInteger('Grid Y', itS16),
                wbInteger('Grid X', itS16)
              ])
              .SetSummaryKey([0, 1])
              .SetSummaryMemberPrefixSuffix(0, '<X:', '')
              .SetSummaryMemberPrefixSuffix(1, 'Y:', '>')
              .SetSummaryDelimiter(', ')
              .IncludeFlag(dfSummaryMembersNoName)
              .IncludeFlag(dfCollapsed),

              wbFormIDCk('Parent Cell', [CELL])
            ])
            .IncludeFlag(dfUnionStaticResolve)
            .IncludeFlag(dfCollapsed)
          ])
          .SetSummaryKey([1, 2])
          .IncludeFlag(dfSummaryMembersNoName)
          .IncludeFlag(dfCollapsed),
          wbUnknown(1),
          wbArray('Unknown', wbStruct('Unknown', [
            wbInteger('Type', itU32, wbCRCValuesEnum)
            // don't know?
          ]), -1)
        ])
        .SetSummaryKeyOnValue([0, 9, 7, 8])
        .SetSummaryPrefixSuffixOnValue(0, '', '')
        .SetSummaryPrefixSuffixOnValue(9, 'in ', '')
        .SetSummaryPrefixSuffixOnValue(7, 'with ', '')
        .SetSummaryPrefixSuffixOnValue(8, 'is island with ', '')
        .IncludeFlag(dfSummaryMembersNoName)
        .IncludeFlag(dfCollapsed)
      ),
      wbStruct(NVPP, 'Preferred Pathing', [
        wbArray('NavMesh Sets', wbArray('Set', wbFormIDCk('Mesh', [NAVM]), -1), -1),
        wbArray('NavMesh Tree', wbStruct('Node', [
          wbFormIDCk('Mesh', [NAVM]),
          wbInteger('Index/Node', itU32)
        ]), -1)
      ])
    ]).IncludeFlag(dfExcludeFromBuildRef);;

    {subrecords checked against Starfield.esm}
    wbRecord(NAVM, 'Navigation Mesh',
      wbFlags(wbRecordFlagsFlags, wbFlagsList([
        {0x00040000} 18, 'Compressed',
        {0x04000000} 26, 'AutoGen'
      ]), [18]), [
      wbEDID,
      wbVMAD,
      wbBaseFormComponents,
      wbNVNM,
      wbMNAMNAVM
    ], False, wbNAVMAddInfo);

  end;


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
    wbGenericModel(),
    wbEITM,
    wbFormIDCk(MNAM, 'Image Space Modifier', [IMAD]),
    wbStruct(ENAM, 'Data', [
      wbFormIDCk('Light', [LIGH, NULL]),                  //formid // +0x28   //+0x28 is expected to be LIGH
      wbSoundReference,                                   //struct // +0x38   //same struct as STAT's STLS, could be optimization reusing same reading code or the same struct
      wbSoundReference,                                   //struct unused     //same struct as STAT's STLS, could be optimization reusing same reading code or the same struct
      wbFormIDCk('Impact Data Set', [IPDS, NULL]),        //formid // +0x10   //+0x10 is expected to be IDPS
      wbFormIDCk('Placed Object', sigBaseObjects),        //formid? // +0x20  //+0x20 has a check of some kind, but it's not form type, but a function on the class vftable, if it returns non-zero then it's not allowed
      wbFormIDCk('Spawn Projectile', [PROJ, NULL]),       //formid // +0x18   //+0x18 is expected to be PRO
      wbFormIDCk('Condition', [CNDF, NULL]),              //if form_version >= 507 formid? // +0x30  +0x30 is expected to be CNDF
      wbFloat,                                            //uint32 // +0x84
      wbFloat,                                            //uint32 // +0x88
      wbFloat,                                            //uint32 // +0x90   // +0x90, +0x94 are floats
      wbFloat,                                            //uint32 // +0x94   // it's basically doing +0x94 = max(+0x90, +0x94)
      wbFloat,                                            //uint32 // +0x98
      wbFloat,                                            //uint32 // +0x9C
      wbUnknown(4),                                       //uint32 // +0x78
      wbInteger('Unknown Enum', itU32),                   //uint32 unknown_70 // +0x70
                                                          //if form_version < 295  unknown_70 += 1
      wbFloat,                                            //uint32 // +0xA0
      wbInteger('Unknown', itU32),                        //uint32 // +0x74
      wbUnknown(4),                                       //uint32 // +0x00
      wbFloat,                                            //uint32 // +0x04
      wbFloat,                                            //uint32 // +0x08
      wbFloat,                                            //uint32 // +0x80
      wbUnknown(4),                                       //uint32 // +0x7C
      wbFloat                                             //if form_version >= 250 uint32 // +0x8C
    ]),
    wbDamageTypeArray('Damage Type')
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

  var flstValidRefs : TwbSignatures;
  flstValidRefs := [AACT, ACTI, AFFE, ALCH, ARMO,
                    AVIF, BOOK, CLFM, CNDF, COBJ,
                    CONT, EXPL, FACT, FLST, FURN,
                    GBFM, GLOB, HAZD, HDPT, IDLE,
                    IPCT, IRES, KYWD, LCRT, LCTN,
                    LGDI, MATT, MESG, MISC, MSTT,
                    NPC_, OMOD, PACK, PERK, PKIN,
                    PMFT, QUST, RACE, SPEL, STAT,
                    STND, VTYP, WEAP];

  {subrecords checked against Starfield.esm}
  wbRecord(FLST, 'FormID List', [
    wbString(EDID, 'Editor ID', 0, cpBenign, True, nil, wbFLSTEDIDAfterSet),
    wbBaseFormComponents,
    wbFULL,
    wbRArrayS('FormIDs', wbFormIDCk(LNAM, 'FormID', flstValidRefs), cpNormal, False, nil, nil, nil, wbFLSTLNAMIsSorted),
    wbRStructs('Conditional Entries', 'Conditional Entry', [
      wbInteger(INAM, 'Index', itU32),
      wbCITCReq,
      wbCTDAsCountReq
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
              ]),
          {9} wbFormIDCk('Projectile',[PROJ])
        ], cpNormal, False{, wbEPFDDontShow})
      ], [], cpNormal, False{, wbPERKPRKCDontShow}),
      wbEmpty(PRKF, 'End Marker', cpIgnore, True)
    ], []);

  {subrecords checked against Starfield.esm}
  wbRecord(PERK, 'Perk',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  2, 'Non-Playable'
    ])), [
    wbEDID,
    wbVMADFragmentedPERK,
    wbFULL,
    wbDESCReq,
    wbStruct(DATA, 'Data', [
      wbInteger('Perk Category', itU8, wbEnum([
        {0} 'None',
        {1} 'Combat',
        {2} 'Science',
        {3} 'Tech',
        {4} 'Physical',
        {5} 'Social',
        {6} 'All',
        {7} 'AllIncludingNone'
      ])),
      wbInteger('Perk Skill Group', itU8, wbEnum([
        {0} 'None',
        {1} 'Basic',
        {2} 'Advanced',
        {3} 'Expert',
        {4} 'Master'
      ])),
      wbFromSize(4, wbInteger('Crew Assignment', itU8, wbEnum([
        {0} 'None',
        {1} 'Crew Ship',
        {2} 'Crew Outpost'
      ]))),
      wbInteger('Flags', itU8, wbFlags([
        {0x0001} 'PC Trait',
        {0x0002} 'PC Playable',
        {0x0004} 'Unknown 2',
        {0x0008} 'Show in crew UI',
        {0x0010} 'PC Background',
        {0x0020} 'Unknown 5',
        {0x0040} 'Unused 6',
        {0x0080} 'Unused 7'
      ]))
      {
      wbInteger('Trait', itU8, wbBoolEnum),
      wbInteger('Level', itU8),
      wbInteger('Num Ranks', itU8),
      wbFromSize(4, wbInteger('Playable', itU8, wbBoolEnum)),
      wbFromSize(5, wbInteger('Hidden', itU8, wbBoolEnum)
      }
    ], cpNormal, True),
    wbFormIDCk(TNAM, 'Restriction' , [KYWD]),
    wbString(GNAM, 'Perk Icon'),
    wbFormIDCk(UNAM, 'Training' , [PERK]), // unknown what order relative to TNAM and GNAM

    wbRStructs('Ranks', 'Rank', [
      wbEmpty(PRRK, 'Header Marker').SetRequired,
      wbRArrayS('Effects', wbPerkEffect),
      wbCTDAs,
      wbActivityTracker,
      wbDESC.SetRequired,
      wbEmpty(PRRF, 'End Marker').SetRequired
    ], []),
    wbRArray('Background Skills', wbFormIDCk(RNAM, 'Unknown', [PERK]))

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
    wbGenericModel(),
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
          ])),
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
    wbODTY,
    wbBaseFormComponents,
    wbGenericModel(),
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
      ]))
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
    wbGenericModel(),
    wbKeywords,
    wbNLDT, //unknown if before or after CTDAs
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
        {0x00000200} 'Unknown 9',
        {0x00000400} 'Unknown 10'
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
    ]), cpNormal, True),
    wbRArray('Camera Shots', wbFormIDCk(SNAM, 'Camera Shot', [CAMS]))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(VTYP, 'Voice Type', [
    wbEDID,
    wbInteger(DNAM, 'Flags', itU8, wbFlags([
      'Allow Default Dialog',
      'Female'
    ]), cpNormal, True),
    wbFormIDCk(ANAM, 'Animation Face Archetype', [KYWD]),
    wbUnknown(PNAM)
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
      'Unknown 3'
    ], False)),
    wbFormIDCk(HNAM, 'Havok Impact Data Set', [IPDS]),
    wbString(ANAM, 'Breakable FX'),
    wbFLLD
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(IPCT, 'Impact', [
    wbEDID,
    wbBaseFormComponents,
    wbGenericModel(),
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
    wbArray(GNAM, 'Projected Decals', wbFormIDCk('Projected Decal', [PDCL])),
    wbStruct(HNAM, 'Unknown', [
      wbFormIDCk('Unknown', [PDCL, NULL]),
      wbFormIDCk('Unknown', [PDCL, NULL]),
      wbFormIDCk('Unknown', [PDCL, NULL]),
      wbFormIDCk('Unknown', [PDCL, NULL])
    ]),
    wbDODT,
    wbSoundReference(IDSH),
    wbSoundReference(IDP1),
    wbSoundReference(IDP3),
    wbFloat(FNAM, 'Footstep Particle Max Dist')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(IPDS, 'Impact Data Set', [
    wbEDID,
    wbRArrayS('Data', wbStructSK(PNAM, [0], '', [
      wbFormIDCk('Material', [MATT]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole),
      wbFormIDCk('Impact', [IPCT])
    ]))
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
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000800} 11, 'Interior Cells Use Ref Location for world map player marker',
      {0x00004000} 14, 'Partial Form',
      {0x00080000} 19, 'Unknown 19',
      {0x00100000} 20, 'Unknown 20'
    ])), [
    wbEDID,
    wbPRPS,

    wbArray(LCPR, 'Location Cell Persistent Reference', wbStruct('', [
      wbFormIDCk('Actor', sigReferences, False, cpBenign),
      wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
      wbInteger('Grid Y', itS16, nil, cpBenign, True, lDontShowForCellLocation),
      wbInteger('Grid X', itS16, nil, cpBenign, True, lDontShowForCellLocation),
      wbInteger('Unknown', itS32, nil, cpBenign)
    ])),

    wbArray(LCUR, 'Location Cell Unique Reference', wbStruct('', [
     wbFormIDCk('Generic Base Form', [GBFM]),
     wbFormIDCk('Placed Object', [REFR]),
     wbFormIDCk('Location', [LCTN])
    ])),

    wbArray(LCUN, 'Location Cell Unique', wbStruct('', [
      wbFormIDCk('Actor', [NPC_], False, cpBenign),
      wbFormIDCk('Ref', [ACHR], False, cpBenign),
      wbFormIDCk('Location', [LCTN, NULL], False, cpBenign)
    ])),

    wbArray(LCSR, 'Location Cell Static Reference', wbStruct('', [
      wbFormIDCk('Loc Ref Type', [LCRT], False, cpBenign),
      wbFormIDCk('Marker', sigReferences, False, cpBenign),
      wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
      wbInteger('Grid Y', itS16, nil, cpBenign, True, lDontShowForCellLocation),
      wbInteger('Grid X', itS16, nil, cpBenign, True, lDontShowForCellLocation),
      wbInteger('Unknown', itS32, nil, cpBenign)
    ])),

    wbRArray('Location Cell Encounter Cell',
      wbStruct(LCEC, 'Unknown', [
        wbFormIDCk('Location', [WRLD, CELL], False, cpBenign),
        wbInteger('Grid Y', itS16, nil, cpBenign, True, lDontShowForCellLocation),
        wbInteger('Grid X', itS16, nil, cpBenign, True, lDontShowForCellLocation)
      ])
    ),

    wbArray(LCID, 'Location Cell Marker Reference', wbFormIDCk('Ref', sigReferences, False, cpBenign)),

    wbArray(LCEP, 'Location Cell Enable Point', wbStruct('', [
      wbFormIDCk('Actor', sigReferences, False, cpBenign),
      wbFormIDCk('Ref', sigReferences, False, cpBenign),
      wbInteger('Set Enable State to Opposite of Parent', itU8, wbBoolEnum),
      wbUnused(3)
    ])),

    wbFULL,
    wbKeywords,
    wbPRPS,
    wbStruct(DATA, 'Unknown', [
      wbFormIDCk('Faction', [FACT, NULL]),
      wbUnknown(1),
      wbInteger('System level', itu8),
      wbUnknown(1),
      wbInteger('Unknown', itu8)
    ]),
    wbFormIDCk(PNAM, 'Parent Location', [LCTN, NULL]),
    wbFormIDCk(FNAM, 'Unreported Crime Faction', [FACT]),
    wbFormIDCk(MNAM, 'World Location Marker Ref', [REFR, ACHR]),
    wbFloat(RNAM, 'World Location Radius'),
    wbFloat(ANAM, 'Actor Fade Mult'),
    wbFloat(TNAM, 'Unknown'),    //Usually 600 (00 00 16 44), two have 00 00 34 42 (45) and are labeled Starstations
    wbCNAM,
    wbUnknown(XNAM),
    wbInteger(YNAM, 'Unknown', itS32)
  ], False, nil, cpNormal, False, nil, wbKeywordsAfterSet);


  var wbMenuButton :=
    wbRStruct('Menu Button', [
      wbLStringKC(ITXT, 'Button Text', 0, cpTranslate),
      wbCTDAs,
      wbFormIDCk(DODT, 'Reference', [REFR, PLYR, NULL])
    ], []);

  {subrecords checked against Starfield.esm}
  wbRecord(MESG, 'Message', [
    wbEDID,
    wbDESCReq,
    wbFULL,
    wbFormIDCk(INAM, 'Icon (unused)', [NULL], False, cpIgnore, True), // leftover
    wbFormIDCk(QNAM, 'Owner Quest', [QUST]),
    wbInteger(DNAM, 'Flags', itU32, wbFlags([
      'Message Box',
      'Delay Initial Display',
      'Unknown 2'
    ]), cpNormal, True, False, nil, wbMESGDNAMAfterSet),
    wbInteger(TNAM, 'Display Time', itU32, nil, cpNormal, False, False, wbMESGTNAMDontShow),
    wbInteger(BNAM, 'Unknown', itS32),
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
      wbUnused(32),
      wbByteColors('Fog Color Far'),
      wbFloat('Fog Max'),
      wbFloat('Light Fade Begin'),
      wbFloat('Light Fade End'),
      wbUnused(4),
      wbFloat('Near Height Mid'),
      wbFloat('Near Height Range'),
      wbByteColors('Fog Color High Near'),
      wbByteColors('Fog Color High Far')
    ], cpNormal, True, nil, 15),
    wbAmbientColors(DALC)
    //wbFormIDCk(WGDR, 'God Rays', [GDRY])
  ]);

  {subrecords checked against Starfield.esm}
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
    wbUnknown(VNAM),
    wbUnknown(UNAM),
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
    wbInteger(DNAM, 'Flags', itU32, wbSMNodeFlags),
    wbInteger(XNAM, 'Max concurrent quests', itU32)
  ], False, nil, cpNormal, False, nil, wbConditionsAfterSet);

  {subrecords checked against Starfield.esm}
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
      //wbInteger(FNAM, 'Flags', itU32, wbEmptyBaseFlags),
      wbFloat(RNAM, 'Hours until reset', cpNormal, False, 1/24)
    ], []), cpNormal, False, nil, wbSMQNQuestsAfterSet)
  ], False, nil, cpNormal, False, nil, wbConditionsAfterSet);

  var lQuestEventVarRecsSF1 := wbMakeVarRecs([
    Sig2Int(LAND), 'Ship Landing',
    Sig2Int(DOCK), 'Ship Docking',
    Sig2Int(XPLL), 'Unknown XPLL'
  ]);

  var wbQuestEventEnumSF1 := wbEnum([], wbCombineVarRecs(wbQuestEventVarRecs, lQuestEventVarRecsSF1));

  {subrecords checked against Starfield.esm}
  wbRecord(SMEN, 'Story Manager Event Node', [
    wbEDID,
    wbFormIDCkNoReach(PNAM, 'Parent ', [SMQN, SMBN, SMEN, NULL]),
    wbFormIDCkNoReach(SNAM, 'Previous Sibling ', [SMQN, SMBN, SMEN, NULL], False, cpBenign),
    wbCITCReq,
    wbCTDAsCount,
    wbInteger(DNAM, 'Flags', itU32, wbSMNodeFlags),
    wbInteger(XNAM, 'Max concurrent quests', itU32),
    wbInteger(ENAM, 'Type', itU32, wbQuestEventEnumSF1)
  ], False, nil, cpNormal, False, nil, wbConditionsAfterSet)
    .SetSummaryKey([7]);

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

  {subrecords checked against Starfield.esm}
  wbRecord(MUST, 'Music Track', [
    wbEDID,
    wbInteger(CNAM, 'Track Type', itU32, wbEnum([], [
      Int64($23F678C3), 'Palette',
      Int64($6ED7E048), 'Single Track',
      Int64($A1A9C4D5), 'Silent Track'
    ]), cpNormal, True),
    wbFloat(FLTV, 'Duration'),
    wbFloat(DNAM, 'Fade-Out'),
    {
    wbString(ANAM, 'Track FileName'),
    wbString(BNAM, 'Finale FileName'),
    wbStruct(LNAM, 'Loop Data', [
      wbFloat('Loop Begins'),
      wbFloat('Loop Ends'),
      wbInteger('Loop Count', itU32)
    ]),
    }
    wbSoundReference(MTSH),
    wbArray(FNAM, 'Cue Points', wbFloat('Point')).IncludeFlag(dfNotAlignable),
    wbConditions,
    wbArray(SNAM, 'Tracks', wbFormIDCk('Track', [MUST, NULL]))
  ], False, nil, cpNormal, False, nil, wbConditionsAfterSet);

  (* still exists in game code, but not in Starfield.esm
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
  *)
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

  (*
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
  *)

  {subrecords checked against Starfield.esm}
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
      {0x00001000} 'No Follower Idle Chatter',
      {0x00002000} 'Unknown 13',
      {0x00004000} 'Unknown 14',
      {0x00008000} 'Unknown 15',
      {0x00010000} 'Unknown 16',
      {0x00020000} 'Unknown 17',
      {0x00040000} 'Unknown 18',
      {0x00080000} 'Unknown 19',
      {0x00100000} 'Unknown 20',
      {0x00200000} 'Unknown 21'
    ])),
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
          {0x0008} 'Unknown 3',
          {0x0010} 'Unknown 4'
        ])),
        wbStruct(SCQS, 'Set Parent Quest Stage', [
          wbInteger('On Start', itS16),
          wbInteger('On Completion', itS16)
        ]),
        wbEmpty(SPMV, 'Unknown'),
        wbEmpty(HNAM, 'Marker Phase End', cpNormal, True)
      ], [])
    ),
    wbRArray('Actors', wbRStruct('Actor', [
      wbInteger(ALID, 'Alias ID', itS32, nil, cpNormal, True),
      wbInteger(LNAM, 'Flags', itU32, wbFlags([
        'No Player Activation',
        'Optional',
        'Run Only Scene Packages',
        'No Command State',
        'Unknown 4',
        'Unknown 5'
      ]), cpNormal, True),
      wbInteger(DNAM, 'Behaviour Flags', itU32, wbFlags([
        'Death Pause',
        'Death End',
        'Combat Pause',
        'Combat End',
        'Dialogue Pause',
        'Dialogue End',
        'OBS_COM Pause',
        'OBS_COM End',
        'Unknown 8',
        'Unknown 9'
      ]), cpNormal, True, false, nil, nil, 26)
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
        end)
      .IncludeFlag(dfIncludeValueInDisplaySignature),
      wbString(NAM0, 'Name').SetRequired,
      wbString(SNOT, 'Scene Notes'),
      wbInteger(ALID, 'Alias ID', itS32).SetRequired(),                         //ALID  uint32 // +0x08 - only used if the value is not 0xFFFFFFFB (-5)
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
      ]))
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
          wbSoundReference(WED0)                                                //WED0  SoundReference // +0x20
        ], []),
        {1 Package}
        wbRStruct('Package', [
          wbRArray('Packages', wbFormIDCk(PNAM, 'Package', [PACK]))
        ], []),
        {2 Timer}
        wbRStruct('Timer', [
          wbFloat(SNAM, 'Max Seconds'),                                         //SNAM  uint32 // +0x20, +0x24
          wbFloat(TNAM, 'Min Seconds'),                                         //TNAM  uint32 // +0x24
          wbEmpty(HNAM),                                                        //not documented by gibbed, always (4x) empty in Starfield.esm
          wbInteger(SCQS, 'Unknown', itS16),                                    //SCQS  int16 // if not -1, registers the timer action in some list with the value //never seen in Starfield.esm
          wbInteger(INTV, 'Unknown', itS16)                                     //INTV  int16 // same as SCQS //never seen in Starfield.esm
        ], []),
        {3 Player Dialogue}
        wbRStruct('Player Dialogue', [
          wbSoundReference(WED0).SetRequired(False),                            //WED0  SoundReference // +0x40
          wbHNAMHNAM.SetRequired,                                               //HNAM  none // +0x20; probably formid; kicks off component-style read (see HNAM fields)
          wbInteger(DTGT, 'Dialogue Target Actor', itS32).SetRequired,          //DTGT  uint32 // +0x90 // as an alias ID
          wbRStructs('Dialogue List', 'Item', [
            wbFormIDCk(ESCE, 'Player Choice', [DIAL, NULL]),                    //ESCE  uint32 // +0x88 array; repeated; appears to allocate a new item into the array, with the value set to item+0x00 and item+0x08; likely acts as start marker for an item in this array
            wbFormIDCk(PPST, 'Unknown', [NULL, KYWD]),                          //PPST  uint32 // +0x88 array; repeated; stored in item+0x10, also sets item+0x24 to 1 (uint8/byte)
            wbFormIDCk(PNST, 'Unknown', [NULL, KYWD]),                          //PNST  uint32 // +0x88 array; repeated; stored in item+0x18, also sets item+0x25 to 1 (uint8/byte)
            wbFormIDCk(PASP, 'Start Scene', [NULL, SCEN]),                      //PASP  uint32 // +0x88 array; repeated; stored in item+0x28
            wbInteger(PAPI, 'Phase Index', itU32),                              //PAPI  uint32 // +0x88 array; repeated; stored in item+0x20; some sort of parenting/hierarchy index with the items in the array
            wbString(PAPN),
            wbFormIDCk(ESCS, 'NPC Response', [DIAL, NULL]).SetRequired          //ESCS  uint32 // +0x88 array; repeated; each item is 0x30 bytes; stored in item+0x08; increases +0x88 index *after* storing the value, likely acts as end marker for an item in this array
          ], []),
          wbUnknown(ATTR),                                                      //ATTR  uint32 // +0x94
          wbEmpty(ACBS, 'Unknown'),                                             //ACBS  nothing // +0x98 set to 1 (uint8/bool)
          wbEmpty(JAIL, 'Unknown')                                              //JAIL  none // +0x99 set to 1 (uint8/bool) // never seen in Starfield.esm
        ], [])
        .IncludeFlag(dfAllowAnyMember)
        .IncludeFlag(dfStructFirstNotRequired),
        {4 Start Scene}
        wbRStruct('Start Scene', [
          wbRStructs('Start Scenes', 'Start Scene', [
            wbRUnion('Scene', [
              wbFormIDCk(LCEP, 'Scene', [SCEN]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole),  //LCEP same as STSC
              wbFormIDCk(STSC, 'Scene', [SCEN])                                 //STSC +0x28 array; repeated; appears to allocate a new item into the array, with the value set to item+0x18; likely acts as start marker for an item in this array
            ],[]),
            wbRUnion('Phase Index', [
              wbInteger(INTT, 'Phase Index', itU16).SetRequired,                //INTT  uint16 // +0x28 array; repeated; sets to item+0x0E
              wbInteger(ACTV, 'Phase Index', itU16).SetRequired                 //ACTV  same as INTT
            ],[]).SetRequired,
            wbString(SSPN, 'Start Phase for Scene'),                            //not documented by gibbed from source, occurs in Starfield.esm
            wbCITCReq,                                                          //CITC uint32 // +0x28 array; repeated; item+0x08; count of following fields, CTDA/CNDD, others will be ignored
            wbCTDAsCount
          ], []).SetRequired(False),
          wbEmpty(HTID, 'Unknown')
        ], [])
        .IncludeFlag(dfAllowAnyMember)
        .IncludeFlag(dfStructFirstNotRequired),
        {5 Radio}
        wbRStruct('Radio', [
          wbFormIDCk(DATA, 'Topic', [DIAL, NULL]).SetRequired,                  //DATA  uint32 // +0x80  probably formid
          wbSoundReference(WED0),                                               //WED0  SoundReference // +0x20
          wbSoundReference(WED1),                                               //WED1  SoundReference // +0x50
          wbFormIDCk(VENC, 'Dialogue Subtype', [KYWD])                          //uint32 // +0x88  probably formid
        ], []),
        {6 Move}
        wbRStruct('Move', [
          wbEmpty(DNAM, 'Unknown'),                                             //DNAM  none // sets +0x3D to 1 (uint8/bool)
          wbEmpty(NVCI, 'Unknown'),                                             //NVCI  none // sets +0x3C to 0 (uint8/bool)
          wbInteger(ALLA, 'Unknown', itS32).SetRequired,                        //ALLA  uint32 // +0x34
          wbFormIDCk(REPL, 'Unknown', sigReferences).SetRequired,               //REPL  uint32 // +0x20  probably formid
          wbFloat(HNAM).SetRequired,                                            //HNAM  uint32 // +0x28
          wbFloat(VCLR).SetRequired,                                            //VCLR  uint32 // +0x2C
          wbFloat(VNML).SetRequired,                                            //VNML  uint32 // +0x30
          wbInteger(FLMV, 'Flags', itU32, wbFlags([                             //FLMV  uint32 // +0x38
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
            {0x00010000} 'Unknown 16'
          ])).SetRequired
        ], [])
        .IncludeFlag(dfAllowAnyMember)
        .IncludeFlag(dfStructFirstNotRequired),
        {7 Camera}
        wbRStruct('Camera', [
          wbRStructs('Camera Shots', 'Camera Shot', [
            wbFormIDCk(CNAM, 'Camera Shot', [NULL, CAMS]),                      //CNAM  uint32 // +0x28 array; repeated; allocates new item for the array; value set to item+0x20 probably formid; kicks off component-style read
            wbInteger(ALLA, 'Unknown', itS32).SetRequired,                      //ALLA  formid // +0x28
            wbFormIDCk(REPL, 'Unknown', sigReferences).SetRequired,             //REPL  formid // +0x30
            wbUnknown(HNAM, 4).SetRequired,                                     //HNAM  uint32 // +0x40
            wbUnknown(VCLR, 4).SetRequired,                                     //VCLR  uint32 // +0x3C
            wbUnknown(LVCR, 4).SetRequired,                                     //LVCR  uint32 // +0x38
            wbEmpty(BTXT, 'Unknown'),                                           //BTXT  none // sets +0x44 to 1 (uint8/bool)
            wbEmpty(ATXT, 'Unknown'),                                           //ATXT  none // sets +0x45 to 1 (uint8/bool)
            wbEmpty(VTXT, 'Unknown'),                                           //VTXT  none // sets +0x46 to 1 (uint8/bool)
            wbEmpty(AIDT, 'Unknown'),                                           //AIDT  none // sets +0x48 to 1 (uint8/bool)
            wbEmpty(MPCD, 'Unknown'),                                           //MPCD  none // sets +0x47 to 1 (uint8/bool)
            wbEmpty(VNAM, 'Unknown'),                                           //VNAM  none // sets +0x49 to 1 (uint8/bool)
            wbCTDAs,                                                            //CTDA  standard CTDA reading // +0x10 //not found in Starfield.esm
            wbMarkerReq(XNAM)                                                   //XNAM  end marker for CNAM fields
          ], [])
        ], []),
        {8 FX}
        wbRStruct('FX', [
          wbFormIDCk(REPL, 'Unknown', [NULL, IMAD]).SetRequired,                //REPL  uint32 // +0x68  probably formid
          wbFloat(HNAM).SetRequired,                                            //HNAM  uint32 // +0x78
          wbFloat(VCLR).SetRequired,                                            //VCLR  uint32 // +0x7C
          wbUnknown(BTXT, 4).SetRequired,                                       //BTXT  uint32 // +0x80
          wbInteger(FLMV, 'Flags', itU32, wbFlags([                             //FLMV  uint32 // +0x88
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
            {0x00010000} 'Unknown 16'
          ])).SetRequired,
          wbSoundReference(WED0),                                               //WED0  SoundReference // +0x38
          wbFormIDCk(BIPL, 'Unknown', [REFR, PLYR, NULL]).SetRequired,          //BIPL  uint32 // +0x70  probably formid
          wbInteger(LVLO, 'Unknown', itS32).SetRequired,                        //LVLO  uint32 // +0x84
          wbCTDAs                                                               //CTDA  standard CTDA reading // +0x20 //not found in Starfield.esm
        ], []),
        {9 Animation}
        wbRStruct('Animation', [
          wbRStructs('Animations', 'Animation', [
            wbFormIDCk(BNAM, 'NPC Anim', [NULL, IDLE]),                         //BNAM  uint32 // +0x28 array; repeated; allocates new item for the array; value set to item+0x28 probably formid; kicks off component-style read
            wbString(STRV),                                                     //STRV  string
            wbFormIDCk(VCLR, 'Unknown', [NULL, KYWD]).SetRequired,              //VCLR  uint32 // +0x30  probably formid
            wbFormIDCk(FLMV, 'Unknown', [NULL, KYWD]).SetRequired,              //FLMV  uint32 // +0x38  probably formid
            wbFormIDCk(FLAV, 'Unknown', [NULL, KYWD]).SetRequired,              //FALV  uint32 // +0x40  probably formid
            wbEmpty(QUAL, 'Unknown'),                                           //QUAL  none // sets +0x58 to 1 (uint8/bool)
            wbEmpty(SPOR, 'Unknown'),                                           //SPOR  none // sets +0x5C to 1 (uint8/bool)
            wbEmpty(OCOR, 'Unknown'),                                           //not documented by gibbed, occurs in Starfield.esm
            wbEmpty(SOFT, 'Unknown'),                                           //SOFT  none // sets +0x5A to 1 (uint8/bool)
            wbEmpty(DOFT, 'Unknown'),                                           //DOFT  none // sets +0x59 to 1 (uint8/bool)
            wbFloat(LVCR).SetRequired,                                          //LVCR  uint32 // +0x50
            wbCTDAs,                                                            //CTDA  standard CTDA reading // +0x08
            wbFormIDCk(ATAC, 'Unknown', [NULL, AACT]).SetRequired,              //ATAC  uint32 // +0x48  probably formid
            wbEmpty(PLRL, 'Unknown'),                                           //PLRL  none // sets +0x5D to 1 (uint8/bool)
            wbEmpty(SHRT, 'Unknown'),                                           //SHRT  none // sets +0x5F to 1 (uint8/bool)
            wbUnknown(DTGT, 4),                                                 //DTGT  uint32 // +0x54 //does not occur in Starfield.esm
            wbEmpty(DPLT, 'Unknown'),                                           //DPLT  none // sets +0x5B to 1 (uint8/bool) //does not occur in Starfield.esm
            wbEmpty(ACEP, 'Unknown'),                                           //ACEP  none // sets +0x5E to 1 (uint8/bool) //does not occur in Starfield.esm
            wbMarkerReq(XNAM)                                                   //XNAM  end marker for BNAM fields
          ], [])
        ], []),
        {10 Timeline}
        wbRStruct('Timeline', [
          wbUnknown(TNAM, 4),                                                   //TNAM  uint32 // +0x20
          wbUnknown(SNAM, 4),                                                   //SNAM  uint32 // +0x24
          wbUnknown(UNAM, 4),                                                   //UNAM  uint32 // +0x2C
          wbUnknown(LNAM, 4),                                                   //LNAM  uint32 // +0x30
          wbUnknown(CNAM, 4)                                                    //CNAM  uint32 // +0x34
        ], [])
      ], []),
      wbMarkerReq(ANAM)
    ], [])),

    wbFormIDCk(PNAM, 'Quest', [QUST]),
    wbInteger(INAM, 'Last Action Index', itU32),
    wbUnknown(VNAM),
    wbCTDAs,
    wbStruct(SCQS, 'Set Parent Quest Stage', [
      wbInteger('On Begin', itS16),
      wbInteger('On End', itS16)
    ]),
    wbString(NNAM, 'Notes'),
    wbFormIDCk(TNAM, 'Template Scene', [SCEN]),
    wbEmpty(BOLV, 'Unknown'),
    wbInteger(XNAM, 'Index', itU32),
    wbUnknown(SCPI),    // seems to be 1-100 - skill req? percentage increase?
    wbUnknown(JNAM),
    wbFormIDCk(SCPP, 'Unknown', [NULL, SCEN]),
    wbEmpty(DEVT, 'Unknown'),
    wbEmpty(SCSP, 'Unknown'),
    wbArray(SPMA, 'Unknown', wbFormIDCk('Unknown', [SCEN])),
    wbArray(SPEX, 'Unknown', wbFormIDCk('Unknown', [SCEN])),
    wbUnknown(SPRK), // seems to correlate with CF05_Guard_SpeechChallenge*, maybe minimum level of skill?
    wbUnknown(SPRW),
    wbEmpty(SPRP, 'Unknown'),
    wbEmpty(SPDF, 'Unknown'),
    wbEmpty(SPPQ, 'Unknown'),
    wbArray(SPKW, 'Keywords', wbFormIDCk('Keyword',[KYWD])),
    wbArray(SPPK, 'Perks', wbFormIDCk('Perk', [PERK])),
    wbArray(SPKY, 'Keywords', wbFormIDCk('Keyword',[KYWD]))
  ]);

  (* still exists in game code, but not in Starfield.esm
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
  *)

  var wbSPED := wbStruct(SPED, 'Movement Data', [
  {  0} wbFloat,
  {  4} wbFloat,
  {  8} wbFloat,
  { 12} wbFloat,
  { 16} wbFloat,
  { 20} wbFloat,
  { 24} wbFloat,
  { 28} wbFloat,
  { 32} wbFloat,
  { 36} wbFloat,
  { 40} wbFloat,
  { 44} wbFloat,
  { 48} wbFloat,
  { 52} wbFloat,
  { 56} wbFloat,
  { 60} wbFloat,
  { 64} wbFloat,
  { 68} wbFloat,
  { 72} wbFloat,
  { 76} wbFloat,
  { 80} wbFloat,
  { 84} wbFloat{Angle},
  { 88} wbFloat,
  { 92} wbFloat,
  { 96} wbFloat,
  {100} wbFloat,
  {104} wbFloat,
  {108} wbFloat,
  {112} wbFloat{Angle},
  {116} wbFloat,
  {120} wbFloat,
  {124} wbFloat,
  {128} wbFloat{Angle},
  {132} wbFloat,
  {136} wbFloat,
  {140} wbFloat,
  {144} wbFloat,
  {148} wbFloat,
  {152} wbFloat,
  {156} wbFloat,
  {160} wbFloat,
  {164} wbFloat,
  {168} wbFloat{Angle},
  {172} wbFloat{Angle},
  {176} wbFloat{Angle},
  {180} wbFloat{Angle},
  {184} wbFloat{Angle},
  {188} wbFloat{Angle},
  {192} wbFloat,
  {196} wbFloat{Angle},
  {200} wbFloat{Angle},
  {204} wbFloat{Angle},
  {208} wbFloat{Angle},
  {212} wbFloat{Angle},
  {216} wbFloat{Angle},
  {220} wbFloat,
  {224} wbFloat{Angle},
  {228} wbFloat{Angle},
  {232} wbFloat{Angle},
  {236} wbFloat{Angle},
  {240} wbFloat{Angle},
  {244} wbFloat{Angle},
  {248} wbFloat
  ]);

  (*
  wbUnion(SPED, 'Movement Data', wbFormVersionDecider([28, 60, 104]), [
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
  *)
  {subrecords checked against Starfield.esm}
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
    wbXALG,
    wbPTT2,
    wbBaseFormComponents,
    wbKeywords,
    wbGenericModel(),
    wbStruct(DNAM, 'Data', [
      wbInteger('Art Type', itU32, wbEnum([
        'Magic Casting',
        'Magic Hit Effect',
        'Enchantment Effect',
        'Unknown 3'
      ])),
      wbUnknown(4)
    ]),
    wbFormIDCK(ENAM, 'Effect Shader', [EFSH])
  ]);

  (* still exists in game code, but not in Starfield.esm * )
  wbRecord(MATO, 'Material Object', [
    wbEDID,
    wbGenericModel(),
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
    wbSPED,
    {
    wbStruct(INAM, 'Anim Change Thresholds (unused)', [
      wbFloat('Directional', cpNormal, True, 180/Pi),
      wbFloat('Movement Speed'),
      wbFloat('Rotation Speed', cpNormal, True, 180/Pi)
    ]),
    wbFloat(JNAM, 'Float Height'),
    }
    wbFloat(LNAM, 'Flight - Angle Gain'),
    wbFloat(KNAM),
    wbUnknown(INTV, 4),
    wbEmpty(BOLV, 'Unknown')
  ]);

  (* still exists in game code, but not in Starfield.esm * )
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
  (*)

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
    ]), cpNormal, True),
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

  {subrecords checked against Starfield.esm}
  wbRecord(REVB, 'Reverb Parameters', [
    wbEDID,
    wbWwiseGUID(RABG, 'Audio Bus'),
    {
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
    }
    wbInteger(ANAM, 'Reverb Class', itU32, wbReverbClassEnum, cpNormal, True)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(GRAS, 'Grass',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00008000} 15, 'Unknown 15'
    ])), [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbBaseFormComponents,
    wbGenericModel(),
    wbStruct(DNAM, '', [
      { 0} wbFloat,
      { 4} wbFloat,
      { 8} wbFloat,
      {12} wbFloat,
      {16} wbFloat,
      {20} wbUnknown(12),
      {32} wbFloat,
      {36} wbUnknown(2)
    ])
    {
    wbStruct(DNAM, '', [
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
    }
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(IDLE, 'Animation', [
    wbEDID,
    wbCTDAs,
    wbString(DNAM, 'Behavior Graph'),
    wbString(ENAM, 'Animation Event'),
    wbArray(ANAM, 'Related Animations', wbFormIDCk('Related Animation', [AACT, IDLE, NULL]),
      ['Parent', 'Previous Sibling'], cpNormal, True),
    wbUnknown(FNAM),
    (*
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
    *)
    wbString(GNAM, 'Animation File'),
    wbFULL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(INFO, 'Dialog response',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
//    wbFormIDCk(TPIC, 'Topic', [DIAL]),
//    wbFormIDCkNoReach(PNAM, 'Previous INFO', [INFO, NULL], False, cpBenign),
    wbFormIDCk(DNAM, 'Shared INFO', [INFO]),
    wbFormIDCk(GNAM, 'INFO group', [INFO]),

    wbRArray('Responses', wbRStruct('Response', [
      wbStruct(TRDA, 'Response Data', [
        wbFormIDCk('Emotion', [KYWD, FFFF]),
        // wbInteger('Response number', itU8),
        wbInteger('WEM File', itU32, wbIntToHexStr, wbHexStrToInt),
        wbFloat('Unknown') // Interrupt Percentage?
        // wbByteArray('Unknown', 1),
        // wbInteger('Interrupt Percentage', itU16)
        // wbInteger('Camera Target Alias', itS32),
        // wbInteger('Camera Location Alias', itS32)
      ]),
      wbRArray('Unknown', wbStruct(TROT, 'Unknown', [
        wbFormIDCk('Unknown', [VTYP]),
        wbFloat('Unknown')
      ])),
      wbLStringKC(NAM1, 'Response Text', 0, cpTranslate, True),
      wbString(NAM2, 'Script Notes', 0, cpNormal, True),
      wbString(NAM3, 'Edits', 0, cpNormal, True),
      wbString(NAM4, 'Alternate LIP Text', 0, cpNormal, True),
      wbByteArray(NAM9, 'Text Hash'),
      wbFormIDCk(BNAM, 'Unknown', [NULL, IDLE]),
      wbString(STRV),
      wbFormIDCk(VCLR, 'Unknown', [NULL, KYWD]),
      wbUnknown(FLMV),
      wbUnknown(FLAV),
      wbEmpty(QUAL, 'Unknown'), // order between QUAL
      wbEmpty(DOFT, 'Unknown'), // and DOFT is unknown
      wbEmpty(DPLT, 'Unknown'),
      wbEmpty(OCOR, 'Unknown'),
      wbFloat(LVCR),
      wbUnknown(ATAC),
      wbEmpty(PLRL, 'Unknown'),
      wbEmpty(XNAM, 'Unknown'),
      wbHNAMHNAM,
      wbSoundReference(RVSH)
    ], [])),
    wbCTDAs,
    wbLStringKC(RNAM, 'Prompt', 0, cpTranslate),
    wbFormIDCk(ANAM, 'Speaker', [NPC_]),
    wbFormIDCk(TSCE, 'Start Scene', [SCEN]),
    wbUnknown(INTV),
    wbSoundReference(WED0),
//    wbInteger(ALFA, 'Forced Alias', itS32),
//    wbFormIDCk(ONAM, 'Audio Output Override', [SOPM]),
//    wbInteger(GREE, 'Greet Distance', itU32),
    wbStruct(TIQS, 'Set Parent Quest Stage', [
      wbInteger('On Begin', itS16),
      wbInteger('On End', itS16)
    ]),
    wbString(NAM0, 'Start Scene Phase'),
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
      'Unknown 2',
      'Force'
    ])),
    wbEmpty(COCT, 'Unknown'), // container count? never followed by CNTO in Starfield.esm
    wbFormIDCk(NAM8, 'Unknown', [AFFE]), // order between COCT and NAM8 unknown
    wbFormIDCk(PERK, 'Perk', [PERK]),             // order between PERK
    wbFormIDCk(SCSP, 'Speech Challenge', [SPCH])  // and SCSP unknown
  ], False, wbINFOAddInfo, cpNormal, False, nil{wbINFOAfterLoad});

  (* still exists in game code, but not in Starfield.esm * )
  wbRecord(INGR, 'Ingredient', [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbFULL,
    wbKSIZ,
    wbKWDAs,
    wbGenericModel(),
    wbICON,
    wbMICO,
    wbDEST,
    wbETYP,
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
  (**)

  wbRecord(KEYM, 'Key',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000800} 11, 'Calc Value From Components',
      {0x00002000} 13, 'Pack-In Use Only'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbPTT2,
    wbXALG,
    wbFULL,
    wbGenericModel(),
    wbKeywords,
//    wbDEST,
    wbStruct(DATA, '', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True),
    wbInteger(FLAG, 'Flags', itU32, wbFlags([
      'Unknown 0',
      'Unknown 1'
    ]))
  ], False, nil, cpNormal, False, nil, wbKeywordsAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(LIGH, 'Light',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000080}  7, 'Unknown 7',
      {0x00008000} 15, 'Unknown 15',
      {0x00010000} 16, 'Random Anim Start',
      {0x00020000} 17, 'Unknown 17',
      {0x02000000} 25, 'Obstacle',
      {0x10000000} 28, 'Portal-strict'
    ])), [
    wbEDID,
//    wbVMAD,
    wbOBND(True),
    wbODTY,
//    wbPTT2,
    wbBaseFormComponents,
    wbGenericModel(),
    wbKSIZ,
    wbKWDAs,
    wbStruct(DAT2, 'Data', [
      { 0} wbUnknown(16),
      {16} wbFloat,
      {20} wbUnknown(12),
      {32} wbFloat,
      {36} wbFloat,
      {40} wbUnknown(4),
      {44} wbFloat,
      {48} wbUnknown(12),
      {60} wbFloat,
      {64} wbFloat,
      {68} wbFloat,
      {72} wbFloat
    ]),
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
    wbStruct(FLBD, 'Unknown', [
      { 0} wbFloat,
      { 4} wbFloat,
      { 8} wbFloat,
      {12} wbFloat,
      {16} wbFloat,
      {20} wbUnknown(4)
    ]),
    wbStruct(FLRD, 'Unknown', [
      { 0} wbFloat,
      { 4} wbFloat,
      { 8} wbFloat,
      {12} wbFloat,
      {16} wbUnknown(4)
    ]),
    wbStruct(FLGD, 'Unknown', [
      { 0} wbFloat,
      { 4} wbFloat,
      { 8} wbFloat,
      {12} wbFloat,
      {16} wbUnknown(16),
      {32} wbFloat,
      {36} wbFloat,
      {40} wbUnknown(16),
      {56} wbFloat,
      {60} wbFloat,
      {64} wbUnknown(4),
      {68} wbFloat,
      {72} wbUnknown(8),
      {80} wbFloat,
      {84} wbUnknown(4)
    ]),
    wbUnknown(LLLD),
    wbStruct(FLAD, 'Unknown', [
      { 0} wbFloat,
      { 4} wbFloat,
      { 8} wbFloat,
      {12} wbUnknown(4)
    ]),
    wbFloat(FVLD)
  ], False, nil, cpNormal, False);

  {subrecords checked against Starfield.esm}
  wbRecord(LSCR, 'Load Screen',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000400} 10, 'Displays In Main Menu',
      {0x00008000} 15, 'No Rotation'
    ])), [
    wbEDID,
    wbDESCReq,
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
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000200}  9, 'Unknown 9'
    ])), [
    wbEDID,
    wbString(BNAM),
    wbFormIDCk(MNAM, 'Material Type', [MATT, NULL], False, cpNormal, True),
    wbStruct(HNAM, 'Havok Data', [
      wbInteger('Friction', itU8),
      wbInteger('Restitution', itU8)
    ], cpNormal, True),
    wbFloat(QNAM)
//    wbInteger(SNAM, 'Texture Specular Exponent', itU8, nil, cpNormal, True),
//    wbRArray('Grasses', wbFormIDCk(GNAM, 'Grass', [GRAS]))
  ]);

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
        wbUnknown(4)
      ]));

  {subrecords checked against Starfield.esm}
  wbRecord(LVLN, 'Leveled NPC',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00008000}  15, 'Unknown 15'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbBaseFormComponents,
    wbXALG,
    wbLVLD,
    wbInteger(LVLM, 'Max Count', itU8), { Always 00 } {Unavailable}
    wbInteger(LVLF, 'Flags', itU16, wbFlags([
      {0x0001} 'Calculate from all levels <= player''s level',
      {0x0002} 'Calculate for each item in count',
      {0x0004} 'Calculate All', {Still picks just one}
      {0x0008} 'Unknown 3',
      {0x0010} 'Unknown 4',
      {0x0020} 'Unknown 5',
      {0x0040} 'Unknown 6',
      {0x0080} '',
      {0x0100} 'Unknown 8'
    ]), cpNormal, True),
    wbCTDAs,
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntryNPC, cpNormal, False, nil, wbLVLOsAfterSet),
    wbFilterKeywordChances,
    wbLStringKC(ONAM, 'Override Name', 0, cpTranslate),
    wbGenericModel()
  ], False, nil, cpNormal, False, nil, wbLLEAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(LVLI, 'Leveled Item',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00008000}  15, 'Unknown 15'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbBaseFormComponents,
    wbXALG,
    wbLVLD,
    wbInteger(LVLM, 'Max Count', itU8), { Always 00 }
    wbInteger(LVLF, 'Flags', itU16, wbFlags([
      {0x0001} 'Calculate from all levels <= player''s level',
      {0x0002} 'Calculate for each item in count',
      {0x0004} 'Use All',
      {0x0008} 'Unknown 3',
      {0x0010} 'Unknown 4',
      {0x0020} 'Unknown 5',
      {0x0040} '',
      {0x0080} '',
      {0x0100} 'Unknown 8'
    ]), cpNormal, True),
    wbCTDAs,
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntryItem, cpNormal, False, nil, wbLVLOsAfterSet),
    wbFilterKeywordChances,
    //wbFormIDCk(LVSG, 'Epic Loot Chance', [GLOB]),
    wbUnknown(LVLL),                                  //Likely ENUM (value is either 01, 02, or 03)
    wbUnknown(LIMC),
    wbLStringKC(ONAM, 'Override Name', 0, cpTranslate),
    wbGenericModel(),
    wbFTYP
  ], False, nil, cpNormal, False, nil, wbLLEAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(LVLP, 'Leveled Pack In',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000080}   7, 'Unknown 7',
      {0x00008000}  15, 'Unknown 15'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbBaseFormComponents,
    wbXALG,
    wbLVLD,
    wbInteger(LVLM, 'Max Count', itU8), { Always 00 }
    wbInteger(LVLF, 'Flags', itU16, wbFlags([
      {0x0001} 'Calculate from all levels <= player''s level',
      {0x0002} 'Calculate for each item in count',
      {0x0004} 'Use All',
      {0x0008} 'Unknown 3',
      {0x0010} 'Unknown 4',
      {0x0020} 'Unknown 5',
      {0x0040} 'Unknown 6',
      {0x0080} '',
      {0x0100} 'Unknown 8'
    ]), cpNormal, True),
    wbCTDAs,
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntryPackIn, cpNormal, False, nil, wbLVLOsAfterSet),
    //wbFilterKeywordChances,
    //wbLStringKC(ONAM, 'Override Name', 0, cpTranslate)
    wbGenericModel(),
    wbFTYP
  ], False, nil, cpNormal, False, nil, wbLLEAfterSet);

  (* still exists in game code, but not in Starfield.esm * )
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
    {49} 'Chameleon',
    {50} 'Unknown 50',
    {51} 'Unknown 51',
    {52} 'Unknown 52',
    {53} 'Unknown 53'
  ]));

  var wbMGEFData :=
    wbStruct(DATA, 'Magic Effect Data', [
      {  0} wbUnion('Assoc. Item', wbMGEFAssocItemDecider, [
              wbFormID('Unused', cpIgnore),
              wbFormIDCk('Assoc. Item', [LIGH, NULL]),        // light
              wbFormIDCk('Assoc. Item', [WEAP, ARMO, NULL]),  // bound item
              wbFormIDCk('Assoc. Item', [NPC_, NULL]),        // summon creature
              wbFormIDCk('Assoc. Item', [HAZD, NULL]),        // guide, spawn hazard
              wbFormIDCk('Assoc. Item', [SPEL, NULL]),        // cloak
              wbFormIDCk('Assoc. Item', [DMGT, NULL]),        // immunity
              wbFormIDCk('Assoc. Item', [ENCH, NULL]),        // enhance weapon
              wbFormIDCk('Assoc. Item', [KYWD, NULL]),        // peak modifier
              wbFormIDCk('Assoc. Item', [DMGT, NULL])         // damage type
            ]),
      {  4} wbActorValue,
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
      { 56} wbActorValue,
      { 60} wbFormIDCk('Projectile', [NULL, PROJ]),
      { 64} wbFormIDCk('Resist Value', [AVIF, NULL]),
      { 68} wbActorValue,
      { 72} wbFloat,
      { 76} wbFloat,
      { 80} wbMGEFType,
      { 84} wbFloat,
      { 88} wbUnknown(4),
      { 92} wbFloat,
      { 96} wbInteger('Unknown', itU32),
      {100} wbInteger('Casting Type', itU8, wbCastEnum),
      {101} wbInteger('Delivery Type', itU8, wbTargetEnum),
      {102} wbUnknown(4),
      {106} wbInteger('Flags', itU32, wbFlags([
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
      {110} wbFromVersion(164, wbInteger('Flags 2', itU32, wbFlags([
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
      ]))),
      {114} wbUnknown(2),
      {116} wbUnknown(4),
      {120} wbUnknown(4),
      {124} wbFloat,
      {128} wbFloat,
      {132} wbFloat
    ], cpNormal, True)
    .IncludeFlag(dfFastAssign);

  {subrecords checked against Starfield.esm}
  wbRecord(MGEF, 'Magic Effect', [
    wbEDID,
    wbVMAD,
    wbFULL,
    wbKeywords,
    wbMGEFData,
//    wbRArrayS('Counter Effects', wbFormIDCk(ESCE, 'Effect', [MGEF]), cpNormal, False, nil, wbCounterEffectsAfterSet),
    wbRArray('Sounds', wbStruct(ESSH, 'Sound Reference', [
      wbInteger('Unknown', itU8),
      wbSoundReference('Sound Reference')
    ])),
    wbLStringKC(DNAM, 'Magic Item Description', 0, cpTranslate),
    wbCTDAs
  ], False, nil, cpNormal, False, nil {wbMGEFAfterLoad}, wbMGEFAfterSet);

  {subrecords checked against Starfield.esm}
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
    wbGenericModel(),
    wbDEST,
    wbCUSH,
    wbPUSH,
    wbPDSH,
    wbKeywords,
    wbCVPA,
    wbStruct(DATA, 'Data', [
      wbInteger('Value', itS32),
      wbFloat('Weight')
    ], cpNormal, True),
    // the amount of components is the same as size of CDIX, so should not be sorted probably
    wbUnknown(FLAG),
    wbLStringKC(NNAM, 'Unknown', 0, cpTranslate)
  ], False, nil, cpNormal, False);

  var wbComponent :=
    wbStructSK([0], 'Component', [
      wbFormIDCkNoReach('Component', sigBaseObjects),
      wbInteger('Count', itU32),
      wbByteArray('Unknown', 4)
    ])
      .SetSummaryKey([1, 0])
      .SetSummaryMemberPrefixSuffix(0, '', '')
      .SetSummaryMemberPrefixSuffix(1, '', 'x')
      .SetSummaryDelimiter(' ')
      .IncludeFlag(dfCollapsed, wbCollapseItems)
      .IncludeFlag(dfSummaryNoSortKey)
      .IncludeFlag(dfSummaryMembersNoName);

  var wbComponents := wbArrayS(FVPA, 'Components', wbComponent);

  {subrecords checked against Starfield.esm}
  wbRecord(COBJ, 'Constructible Object',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x04000000}  26, 'Unknown 26'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbDESC,
    wbFormIDCkNoReach(BNAM, 'Workbench Keyword', [NULL, KYWD]),
    wbCTDAs,
    wbComponents,
    wbStructs(RQPK, 'Required Perks', 'Required Perk', [
      wbFormIDCk('Perk', [PERK]),
      wbInteger('Rank', itU32),
      wbUnknown(4)
    ]),
    wbFormIDCk(CNAM, 'Created Object', sigBaseObjects),
    wbInteger(NNAM, 'Amount Produced', itU16), // req
    wbFloat(SNAM, 'Menu Sort Order'), // req
    wbUnknown(TNAM), // req - always 1 byte value $00
    wbCUSH,
    wbPUSH,
    wbPDSH,
    wbInteger(LRNM, 'Learn Method', itU8, wbLearnMethodEnum),
    wbInteger(DATA, 'Value', itU32), // req
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
      {0x0000000000000020} 'No Shadow',
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
      {0x0000002000000000} 'Head Axis Bit 0',
      {0x0000004000000000} 'Head Axis Bit 1',
      {0x0000008000000000} 'Can Melee When Knocked Down',
      {0x0000010000000000} 'Use Idle Chatter During Combat',
      {0x0000020000000000} 'Ungendered',
      {0x0000040000000000} 'Can Move When Knocked Down',
      {0x0000080000000000} 'Use Large Actor Pathing',
      {0x0000100000000000} 'Use Subsegmented Damage',
      {0x0000200000000000} 'Flight - Defer Kill',
      {0x0000400000000000} 'Unknown 46',
      {0x0000800000000000} 'Flight - Allow Procedural Crash Land',
      {0x0001000000000000} 'Disable Weapon Culling',
      {0x0002000000000000} 'Use Optimal Speeds',
      {0x0004000000000000} 'Has Facial Rig',
      {0x0008000000000000} 'Can Use Crippled Limbs',
      {0x0010000000000000} 'Use Quadruped Controller',
      {0x0020000000000000} 'Low Priority Pushable',
      {0x0040000000000000} 'Cannot Use Playable Items',
      {0x0080000000000000} 'Unknown 55',
      {0x0100000000000000} 'Unknown 56',
      {0x0200000000000000} 'Unknown 57',
      {0x0400000000000000} 'Unknown 58',
      {0x0800000000000000} 'Unknown 59',
      {0x1000000000000000} 'Unknown 60',
      {0x2000000000000000} 'Unknown 61'
    ]);

  var wbRaceSizeEnum :=
    wbEnum([
      'Small',
      'Medium',
      'Large',
      'Extra Large'
    ]);

  var wbRACEDAT2Size :=
    wbInteger('Size', itU32, wbRaceSizeEnum);

  var wbNPC_ONA2Size :=
    wbInteger('Size', itU8, wbRaceSizeEnum);

  {subrecords checked against Starfield.esm}
  wbRecord(NPC_, 'Non-Player Character (Actor)',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000400} 10, 'Unknown 10',
      {0x00040000} 18, 'Compressed',
      {0x00080000} 19, 'Unknown 19',
      {0x00400000} 22, 'Unknown 22',
      {0x20000000} 29, 'Bleedout Override'
    ]), [18]), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbXALG,
    wbPTT2,
    wbSNTP,
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
        {0x02000000} 'Unknown 25',
        {0x04000000} 'Unknown 26',
        {0x08000000} 'Unknown 27',
        {0x10000000} 'Unknown 28',
        {0x20000000} 'Is Ghost',
        {0x40000000} 'Unknown 30',
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
        {0x2000} 'Unknown 13',
        {0x4000} 'Unknown 14'
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
      wbFormIDCk('Unknown 13', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate13),
      wbFormIDCk('Unknown 14', [BMMO, LVLN, NPC_, NULL], False, cpNormal, False, wbActorTemplatesUseTemplate14)
    ], cpNormal, False, wbActorTemplatesUseTemplateAny),
    wbFormIDCk(RNAM, 'Race', [RACE], False, cpNormal, True, nil{wbActorTemplateUseTraits}),
//    wbSPCT,
    wbSPLOs,
//    wbDEST,
    wbFormIDCk(WNAM, 'Skin', [ARMO], False, cpNormal, False),
//    wbFormIDCk(ANAM, 'Far away model', [ARMO], False, cpNormal, False, nil{wbActorTemplateUseTraits}),
    wbFormIDCk(ATKR, 'Attack Race', [RACE], False, cpNormal, False),
//    wbRArrayS('Attacks', wbAttackData),
    wbFormIDCk(SPOR, 'Spectator Override Package List', [FLST]),
//    wbFormIDCk(OCOR, 'Observe Dead Body Override Package List', [FLST]),
//    wbFormIDCk(GWOR, 'Guard Warn Override Package List', [FLST]),
    wbFormIDCk(ECOR, 'Combat Override Package List', [FLST]),
//    wbFormIDCk(FCPL, 'Follower Command Package List', [FLST]),
//    wbFormIDCk(RCLR, 'Follower Elevator Package List', [FLST]),
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
    wbStruct(FLEE, 'Unknown', [
      wbFormID('Unknown'),
      wbFormID('Unknown'),
      wbFormID('Unknown'),
      wbFloat,
      wbFloat,
      wbUnknown(4)
    ]),
    wbArray(RDSA, 'Unknown',
      wbStruct('Unknown', [
        {  0} wbInteger('Unknown', itU32),
        {  4} wbInteger('Unknown', itU32),
        {  8} wbFormIDCk('Unknown', [NULL, FLST]),
        { 12} wbUnknown(4),
        { 16} wbFormIDCk('Unknown', [NULL, GLOB]),
        { 20} wbFormIDCk('Unknown', [NULL, GLOB]),
        { 24} wbFormIDCk('Unknown', [NULL, GLOB]),
        { 28} wbFormIDCk('Unknown', [NULL, GLOB]),
        { 32} wbFormIDCk('Unknown', [NULL, GLOB]),
        { 36} wbFloat,
        { 40} wbFloat,
        { 44} wbFloat,
        { 48} wbFloat,
        { 52} wbFloat,
        { 56} wbFormIDCk('Unknown', [NULL, KYWD]),
        { 60} wbUnknown(4),
        { 64} wbFormIDCk('Unknown', [NULL, GLOB]),
        { 68} wbFloat,
        { 72} wbUnknown(4),
        { 76} wbFormIDCk('Unknown', [NULL, GLOB])
      ])
        .SetSummaryKey([14])
        .IncludeFlag(dfCollapsed, wbCollapseRDSA)
    ),
    wbKeywords.SetSummaryKey([1]),
    wbAPPR,
    wbObjectTemplate,
    wbMarkerReq(STOP),
    wbFormIDCk(CNAM, 'Class', [CLAS], False),
    wbFULL,
    wbLStringKC(SHRT, 'Short Name', 0, cpTranslate),
    wbLStringKC(LNAM, 'Long Name', 0, cpTranslate),
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
    {
      wbInteger(CS2H, 'Count', itU32, nil, cpBenign, True),
      wbActorSounds,
      wbEmpty(CS2E, 'End Marker', cpNormal, True),
      wbByteArray(CS2F, 'Finalize', 1, cpNormal, True)
    }
      wbInteger(CS3H, 'Count', itU32, nil, cpBenign, True),
      wbSoundReference(CS3S),
      wbUnknown(CS3F),
      wbMarkerReq(CS3E)
    ], []),
    wbFormIDCk(CSCR, 'Inherits Sounds From', [NPC_], False, cpNormal, False),
//    wbFormIDCk(PFRN, 'Power Armor Stand', [FURN]),
    wbRStruct('Companion Info', [
      wbFormIDCk(QSTA, 'Quest', [QUST]),
      wbFormIDCk(BNAM, 'Dialogue', [DLBR])
    ], []),
    wbFormIDCk(DOFT, 'Default Outfit', [OTFT], False, cpNormal, False),
    wbFormIDCk(SOFT, 'Space Outfit', [OTFT], False, cpNormal, False),
    wbFormIDCk(DPLT, 'Default Package List', [FLST], False, cpNormal, False),
    wbFormIDCk(CRIF, 'Crime Faction', [FACT], False, cpNormal, False),
    wbFormIDCk(HEFA, 'Formation Faction', [FACT]),
    wbInteger(EDCT, 'Tint Count', itU8, nil, cpBenign),
    wbRArray('Tints',
      wbRStruct('Tint', [
        wbInteger(MNAM, 'Unknown', itU32).SetRequired,
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
    wbInteger(STON, 'Skin Tone Index', itU8),
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
        'Unknown 1',
        'Unknown 2',
        'Unarmed Weapon',
        'Flag Overrides',
        'Unknown 5',
        'General',
        'Unknown 7'
      ]))
        .IncludeFlag(dfCollapsed, wbCollapseFlags)
        .SetAfterSet(wbUpdateSameParentUnions),

      wbIsFlag(0, wbStruct('Size', [
        wbNPC_ONA2Size.SetDontShow(wbRaceOverrideDontShow(0))                   // +0x00 - flag  0 (0x00000001)  -> RACE DAT2+0x00
      ])),

      wbIsFlag(1, wbStruct('Unknown 1', [
        wbFloat('Acceleration Rate')
          .IncludeFlag(dfFloatSometimesBroken)
          .SetDontShow(wbRaceOverrideDontShow(1)),                              // +0x04 - flag  1 (0x00000002)  -> RACE DAT2+0x04
        wbFloat('Deceleration Rate')
          .IncludeFlag(dfFloatSometimesBroken)
          .SetDontShow(wbRaceOverrideDontShow(2)),                              // +0x08 - flag  2 (0x00000004)  -> RACE DAT2+0x08
        wbFloat
          .IncludeFlag(dfFloatSometimesBroken)
          .SetDontShow(wbRaceOverrideDontShow(3)),                              // +0x0C - flag  3 (0x00000008)  -> RACE DAT2+0x0C
        wbFloat
          .SetDontShow(wbRaceOverrideDontShow(4))                               // +0x10 - flag  4 (0x00000010)  -> RACE DAT2+0x10
      ])),

      wbIsFlag(2, wbStruct('Unknown 2', [
        wbFloat.SetDontShow(wbRaceOverrideDontShow(5))                          // +0x14 - flag  5 (0x00000020)  -> RACE DAT2+0x14
      ])),

      wbIsFlag(3, wbStruct('Unarmed Weapon', [
        wbFloat.SetDontShow(wbRaceOverrideDontShow(7)),                         // +0x20 - flag  7 (0x00000080)  -> RACE DAT2+0x20
        wbFormIDCk('Unarmed Weapon', [NULL, WEAP])
          .SetDontShow(wbRaceOverrideDontShow(6))                               // +0x18 - flag  6 (0x00000040)  -> RACE DAT2+0x18 RACE's UNWP field
      ])),

      wbIsFlag(4, wbStruct('Flag Overrides', [
        wbInteger('Race Data Flags', itU64, wbRACEDAT2Flags
          .SetDontShowMaskPath('...\Override Active', True)),
        wbInteger('Override Active', itU64, wbRACEDAT2Flags)
      ])),

      wbIsFlag(5, wbStruct('Unknown 5', [
        wbFloat.SetDontShow(wbRaceOverrideDontShow(8)),                         // +0x28 - flag  8 (0x00000100)  -> RACE DAT2+0x28
        wbFloat.SetDontShow(wbRaceOverrideDontShow(9)),                         // +0x2C - flag  9 (0x00000200)  -> RACE DAT2+0x2C
        wbFloat.SetDontShow(wbRaceOverrideDontShow(10)),                        // +0x30 - flag 10 (0x00000400)  -> RACE DAT2+0x30
        wbFloat.SetDontShow(wbRaceOverrideDontShow(11)),                        // +0x34 - flag 11 (0x00000800)  -> RACE DAT2+0x34
        wbFloat.SetDontShow(wbRaceOverrideDontShow(12)),                        // +0x38 - flag 12 (0x00001000)  -> RACE DAT2+0x38
        wbFloat.SetDontShow(wbRaceOverrideDontShow(13))                         // +0x3C - flag 13 (0x00002000)  -> RACE DAT2+0x3C
      ])),

      wbIsFlag(6, wbStruct('General', [
        wbFormIDCk('Impact Material Type', [NULL, MATT])
          .SetDontShow(wbRaceOverrideDontShow(14)),                             // +0x40 - flag 14 (0x00004000)  -> RACE+0x100 RACE's NAM4 field
        wbSoundReference('WED0').SetDontShow(wbRaceOverrideDontShow(18)),       // +0x48 - flag 18 (0x00040000)  -> RACE+0x108 RACE's WED0 field
        wbSoundReference('WED1').SetDontShow(wbRaceOverrideDontShow(15)),       // +0x78 - flag 15 (0x00008000)  -> RACE+0x138 RACE's WED1 field
        wbStruct('Unknown', [                                                   // - flag 22 (0x00400000)
          wbFormIdCk('Unknown', [NULL, EXPL]),                                  // +0xA8                         -> RACE DAT2+0xD0
          wbFormIdCk('Unknown', [NULL, DEBR]),                                  // +0xB0                         -> RACE DAT2+0xD8
          wbFormIdCk('Unknown', [NULL, IPDS]),                                  // +0xB8                         -> RACE DAT2+0xE0
          wbFloat,                                                              // +0xC0                         -> RACE DAT2+0xE8
          wbUnknown(1),                                                         // +0xC4                         -> RACE DAT2+0xEC
          wbUnknown(1)                                                          // +0xC5                         -> RACE DAT2+0xED
        ]).SetDontShow(wbRaceOverrideDontShow(22)),
        wbInteger('Active Overrides', itU32, wbFlags([                          // +0xF8
          {0x00000001} { 0} 'Size',
          {0x00000002} { 1} 'Unknown 1 - Acceleration Rate',
          {0x00000004} { 2} 'Unknown 1 - Deceleration Rate',
          {0x00000008} { 3} 'Unknown 1 - Float@2',
          {0x00000010} { 4} 'Unknown 1 - Float@3',
          {0x00000020} { 4} 'Unknown 2 - Float@0',
          {0x00000040} { 6} 'Unarmed Weapon - Unarmed Weapon',
          {0x00000080} { 7} 'Unarmed Weapon - Float@0',
          {0x00000100} { 8} 'Unknown 5 - Float@0',
          {0x00000200} { 9} 'Unknown 5 - Float@1',
          {0x00000400} {10} 'Unknown 5 - Float@2',
          {0x00000800} {11} 'Unknown 5 - Float@3',
          {0x00001000} {12} 'Unknown 5 - Float@4',
          {0x00002000} {13} 'Unknown 5 - Float@5',
          {0x00004000} {14} 'General - Impact Material Type',
          {0x00008000} {15} 'General - WED1',
          {0x00010000} {16} '',
          {0x00020000} {17} '',
          {0x00040000} {18} 'General - WED0',
          {0x00080000} {19} '',
          {0x00100000} {20} '',
          {0x00200000} {21} '',
          {0x00400000} {22} 'Unknown 6 - Struct@3',
          {0x00800000} {23} 'Unknown 7 - Int@0',
          {0x01000000} {24} 'Unknown 7 - Float@1',
          {0x02000000} {25} 'Unknown 7 - Float@2',
          {0x04000000} {26} 'Unknown 7 - Float@3',
          {0x08000000} {27} 'Unknown 7 - Float@4',
          {0x10000000} {28} 'Unknown 7 - Float@5',
          {0x20000000} {29} 'Unknown 7 - Float@6',
          {0x40000000} {30} 'Unknown 7 - Float@7',
          {0x80000000} {31} ''
        ])).IncludeFlag(dfCollapsed, wbCollapseFlags)
      ])),

      wbIsFlag(7, wbStruct('Unknown 7', [
        wbUnknown(1).SetDontShow(wbRaceOverrideDontShow(23)),                   // +0xC8+0x1C - flag 23 (0x00800000)
        wbFloat.SetDontShow(wbRaceOverrideDontShow(24)),                        // +0xC8+0x00 - flag 24 (0x01000000)
        wbFloat.SetDontShow(wbRaceOverrideDontShow(25)),                        // +0xC8+0x04 - flag 25 (0x02000000)
        wbFloat.SetDontShow(wbRaceOverrideDontShow(26)),                        // +0xC8+0x08 - flag 26 (0x04000000)
        wbFloat.SetDontShow(wbRaceOverrideDontShow(27)),                        // +0xC8+0x0C - flag 27 (0x08000000)
        wbFloat.SetDontShow(wbRaceOverrideDontShow(28)),                        // +0xC8+0x10 - flag 28 (0x10000000)
        wbFloat.SetDontShow(wbRaceOverrideDontShow(29)),                        // +0xC8+0x14 - flag 29 (0x20000000)
        wbFloat.SetDontShow(wbRaceOverrideDontShow(30))                         // +0xC8+0x18 - flag 30 (0x40000000)
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

  var wbPKDTInterruptFlags := wbFlags([
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
    ]))
  ], []));

  {subrecords checked against Starfield.esm}
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
            {2} wbInteger('', itU32),
            {3} wbFloat('')
          ]).IncludeFlag(dfUnionStaticResolve),
          wbPLDT,
          wbRStruct('Target', [
            wbPTDA,
            wbCITCReq,
            wbCTDAsCount
          ], []),
          wbFormIDCk(STSC, 'Scene', [SCEN])
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
        38, 'Unknown 38',
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
        67, 'Unknown 67',
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
        )
        //wbRArray('Unknown', wbUnknown(PFOR), cpIgnore) not in Starfield.esm
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

  var wbQUSTAliasFlags :=
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
      {0x01000000} 'Optional All Scenes',
      {0x02000000} 'Unknown 26',
      {0x04000000} 'Unknown 27',
      {0x08000000} 'Unknown 28',
      {0x10000000} 'Unknown 29',
      {0x20000000} 'Unknown 30',
      {0x40000000} 'Unknown 31',
      {0x80000000} 'Unknown 32'
    ]), cpNormal, True);

  var lReferenceAlias :=
    wbRStructSK([0], 'Reference Alias', [
      wbInteger(ALST, 'Reference Alias ID', itU32, nil, cpNormal, True),
      wbString(ALID, 'Alias Name', 0, cpNormal, True),
      wbQUSTAliasFlags,
      wbUnknown(ALFG,4), // always zero?

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
            wbInteger(ALFE, 'From Event', itU32, wbQuestEventEnumSF1),
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
              'Unknown 3',  // DebugMQ101HelperQuest
              'Unknown 4',  // BE series 1 - quests & derelicts (10)
              'Unknown 5'   // BE series 2 - mostly generic derelicts (10)
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
      wbFormIDCk(VTCK, 'Voice Types', [NPC_, FACT, FLST, VTYP, NULL]),
      wbFormIDCk(ALTM, 'Terminal Menu', [TMLM]),
      wbEmpty(ALED, 'Alias End Marker', cpNormal, True)
    ], [], cpNormal, False, nil, False, nil, wbContainerAfterSet);

  var lLocationAlias :=
    wbRStructSK([0], 'Location Alias', [
      wbInteger(ALLS, 'Location Alias ID', itU32),
      wbString(ALID, 'Alias Name'),
      wbQUSTAliasFlags,
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
            wbInteger(ALFE, 'From Event', itU32, wbQuestEventEnumSF1),
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

      wbInteger(ALPN, 'Parent System Location Alias ID', itS32), // ALPN points to the alias who's ALSY matches the value
      wbInteger(ALSY, 'System Location Alias ID', itS32),        // need a new alias to str routine for this

      wbFormIDCk(ALKF, 'Location Type Keyword', [KYWD]),
      wbFormIDCk(ALDN, 'Display Name', [MESG]),

      wbEmpty(ALED, 'Alias End Marker', cpNormal, True)
    ], []);

  var lRefCollectionAlias :=
    wbRStructSK([0], 'Collection Alias', [
      wbInteger(ALCS, 'Collection Alias ID', itU32),
      wbInteger(ALMI, 'Max Initial Fill Count', itU8).SetRequired,
      wbUnknown(ALAM, 4),  // always zero
      wbRUnion('Reference Alias or Alias End Marker', [
        wbRStruct('Alias End Marker', [
          wbEmpty(ALED, 'Alias End Marker', cpNormal, True)
        ], []),
        lReferenceAlias
      ], [], cpNormal, True)
    ], []);

  {subrecords checked against Starfield.esm}
  wbRecord(QUST, 'Quest',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00004000} 14, 'Partial Form'  // Allows the Record to inherit some subrecords from its master
    ])), [
    wbEDID,
    wbVMADFragmentedQUST,
    wbFULL,
    wbBaseFormComponents,
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
      wbUnused(1),
      wbInteger('Delay Time', itS32),
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
    wbString(ENAM, 'Event', 4),
    wbFormIDCk(LNAM, 'Location', [LCTN]),
//    wbFormIDCk(XNAM, 'Quest Completion XP', [GLOB]),
    wbFormIDCk(QTLM, 'Quest Time Limit', [GLOB]),
    wbFormIDCk(QSRC, 'Source Quest', [QUST]),
    wbRArray('Text Display Globals', wbFormIDCk(QTGL, 'Global', [GLOB])),
    wbFLTR,
    wbString(NAM3, 'Summary'),
    wbRStruct('Quest Dialogue Conditions', [wbCTDAs], [], cpNormal, False),
    wbMarkerReq(NEXT),
    wbCTDAs, {>>> Unknown, doesn't show up in CK <<<}
    wbRArrayS('Stages', wbRStructSK([0], 'Stage', [
      wbStructSK(INDX, [0], 'Stage Index', [
        wbInteger('Stage Index', itU16),
        wbInteger('Flags', itU8, wbFlags([
          {0x01} 'Unknown 1',
          {0x02} 'Run On Start',
          {0x04} 'Run On Stop',
          {0x08} 'Keep Instance Data From Here On',
          'Unknown 4',
          'Unknown 5',
          'Unknown 6'
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
        wbString(SCFC, 'Script Flag Comment'),
        wbLStringKC(CNAM, 'Log Entry', 0, cpTranslate),
        wbRArray('Stage Complete Data', wbRStruct('Datum', [
//          wbInteger(QSRD, 'Reward Scenario Count', itU32), // I am 100% sure of this but the empty record afterwards stumps me
          wbUnknown(QSRD),
          wbFormIDCk(NAM1, 'Affinity Change', [AFFE, NULL]),
          wbRArray('Reward List', wbRStruct('Reward Data', [
            wbFormIDCk(QRXP, 'XP Awarded', [NULL, GLOB]),
            wbFormIDCk(QRCR, 'Bonus Credits', [NULL, GLOB]),
            wbRArray('Rewards', wbStruct(QRRD, 'Reward', [
              wbFormIDCk('Item', sigBaseObjects, False, cpNormal, True),
              wbInteger('Count', itU32)
            ])),
            wbCTDAs
          ], []))
        ], []))
//        wbFormIDCk(NAM0, 'Next Quest', [QUST])
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
        lReferenceAlias,
        lLocationAlias,
        lRefCollectionAlias
      ], [])
    ),

//    wbString(NNAM, 'Description', 0, cpTranslate, False),
    wbFormIDCk(GNAM, 'Quest Group', [KYWD]),
//    wbString(SNAM, 'SWF File'),

    wbRStruct('Mission Board Info', [
      wbFormIDCk(QMTY, 'Mission Type Keyword', [KYWD, NULL]),
      wbLStringKC(QMSU, 'Description', 0, cpTranslate),
      wbRArray('Info Panel', wbRStruct('Panel Item', [
        wbLStringKC(QMDT, 'Header', 0, cpTranslate),
        wbLStringKC(QMDP, 'Line 1', 0, cpTranslate),
        wbLStringKC(QMDS, 'Line 2', 0, cpTranslate)
      ], []))
    ], []),

    wbKeywords,
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
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00080000} 19, 'Unknown 19'
    ])), [
    wbEDID,
    wbFULL,
    wbDESCReq,
    wbSPLOs,
    wbFormIDCk(WNAM, 'Skin', [ARMO, NULL]),
    wbBO64,
    wbKeywords,
    wbPRPS,
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
      { 32} wbInteger('Flags', itU64, wbRACEDAT2Flags),                         // +0x80
      { 40} wbFloat('Acceleration Rate'),                                       // +0x04
      { 44} wbFloat('Deceleration Rate'),                                       // +0x08
      { 48} wbRACEDAT2Size,                                                     // +0x00
      { 52} wbUnknown(4),                                                       // +0x88
      { 56} wbUnknown(4),                                                       // +0x8C
      { 60} wbFloat,                                                            // +0x20 must have to do with unarmed weapon
      { 64} wbInteger('Shield Biped Object', itS32, wbBipedObjectEnum),         // +0x94
      { 68} wbInteger('Beard Biped Object', itS32, wbBipedObjectEnum),          // +0x90
      { 72} wbInteger('Body Biped Object', itS32, wbBipedObjectEnum),           // +0x98
      { 76} wbFloat,                                                            // +0x9C
      { 80} wbUnknown(4),                                                       // +0x14
      { 84} wbFloat,                                                            // +0x0C
      { 88} wbFloat,                                                            // +0x10
      { 92} wbUnknown(4),                                                       // +0xA0
      { 96} wbUnknown(4),                                                       // +0xA4
      {100} wbUnknown(4),                                                       // +0xA8
      {104} wbUnknown(4),                                                       // +0xAC
      {108} wbUnknown(4),                                                       // +0xB0
      {112} wbUnknown(4),                                                       // +0xB4
      {116} wbUnknown(4),                                                       // +0xB8
      {120} wbFloat,                                                            // +0xBC
      {124} wbUnknown(4),                                                       // +0xC0
      {128} wbUnknown(4),                                                       // +0xC4
      {132} wbUnknown(2),                                                       // +0xC8
      {134} wbUnknown(4),                                                       // +0xE8
      {138} wbUnknown(1),                                                       // +0xEC
      {139} wbUnknown(1),                                                       // +0xED
      {140} wbFormIDCk('Explosion', [NULL, EXPL]),                              // +0xD0  expected to be EXPL
      {144} wbFormIDCk('Debris', [NULL, DEBR]),                                 // +0xD8  expected to be DEBR
      {148} wbFormIDCk('Impact Data Set', [NULL, IPDS]),                        // +0xE0  expected to be IPDS
      {152} wbFloat('Orientation Limits - Pitch'),                              // +0xF0
      {156} wbFloat('Orientation Limits - Roll'),                               // +0xF4
      {160} wbFloat,                                                            // +0x28
      {164} wbFloat,                                                            // +0x2C
      {168} wbFloat,                                                            // +0x30
      {172} wbFloat,                                                            // +0x34
      {176} wbFloat,                                                            // +0x38
      {180} wbFloat,                                                            // +0x3C
      {184} wbUnknown(4),                                                       // +0xF8
      {188} wbUnknown(4),                                                       // +0x24
      {192} wbStruct('Unknown', [                                               // Same as NPC_ -> ONA2 - Unknown 7
      {192}   wbUnknown(1),                                                     // +0x5C
      {193}   wbFloat,                                                          // +0x40
      {197}   wbFloat,                                                          // +0x44
      {201}   wbFloat,                                                          // +0x48
      {205}   wbFloat,                                                          // +0x4C
      {209}   wbFloat,                                                          // +0x50
      {213}   wbFloat,                                                          // +0x54
      {217}   wbFloat                                                           // +0x58
      {221} ])
    ]),
    (*
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
    *)

    wbRStruct('Sekleton Data', [
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

//    wbFormIDCk(ATKR, 'Attack Race', [RACE], False, cpNormal, False),
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
    wbSoundReference(WED0),
    wbSoundReference(WED1),

    wbRArray('Biped Object Names', wbString(NAME, 'Name'), 64).IncludeFlag(dfNotAlignable),
    wbArray(RBPC, 'Biped Object Conditions', wbFormIDCk('Condition', [AVIF, NULL]), 64).IncludeFlag(dfNotAlignable),

    wbRArrayS('Movement Data Overrides', wbRStructSK([0], 'Override', [
      wbFormIDCk(MTYP, 'Movement Type', [MOVT]),
      wbSPED
    ], [])),
    wbInteger(VNAM, 'Equipment Flags', itU32, wbEquipType),
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
//    wbFormIDCk(SNMV, 'Base Movement Defaults - Sneak', [MOVT]),

    wbRStruct('Chargen and Skintones', [
      wbRStruct('Male', [
        wbMarkerReq(MNAM),
        wbRStruct('Chargen', [
          wbMarkerReq(NAM0),
          wbUnknown(NNAM, 12),
          wbRArray('Race Presets', wbFormIDCk(RPRM, 'Preset NPC', [NPC_, NULL])),
          wbMorphGroups('Morph Groups'),
          wbFaceMorphs('Face Morph Phenotypes'),
          wbRStructs('Face Dials', 'Face Dial', [
            wbInteger(FDSI, 'Skin Index', itU32),
            wbLString(FDSL, 'Label', 0, cpTranslate)
          ], [])
        ], []),
        wbString(BSTT, 'Body Skin Tones'),
        wbString(HSTT, 'Hand Skin Tones'),
        wbString(FCTP),
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
          wbRStructs('Face Dials', 'Face Dial', [
            wbInteger(FDSI, 'Skin Index', itU32),
            wbLString(FDSL, 'Label', 0, cpTranslate)
          ], [])
        ], []),
        wbString(BSTT, 'Body Skin Tones'),
        wbString(HSTT, 'Hand Skin Tones'),
        wbString(FCTP),
        wbString(FSTT, 'Face Skin Tones')
      ], [], cpNormal, True)
    ], []),

    wbFormIDCk(RNAM, 'Armor Race', [RACE]),

    wbFormIDCk(SRAC, 'Subgraph Template Race', [RACE]),

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

    wbRStructs('Unknown', 'Unknown', [
      wbUnknown(MSSS),
      wbRStructs('Unknown', 'Unknown', [
        wbUnknown(MSSI),
        wbFormIDCk(MSSA, 'Material Swap', [LMSW]).SetRequired
      ], [])
    ], []),

    wbLString(SNAM, 'Unknown', 0, cpTranslate)

  ]);

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

    wbXLCM,

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),

    wbFloat(XRDS, 'Radius'),

    wbXRGD,

    wbFormIDCk(XRFG, 'Reference Group', [RFGP]),

    wbXPCS,

    wbFormIDCk(XLCN, 'Persistent Location', [LCTN]),

    wbEmpty(XIS2, 'Ignored by Sandbox'),

    wbXRNK,

    wbXPLKs,

    wbLinkedReferences,

    //wbInteger(XCNT, 'Count', itS32),

    wbXEED,

    {--- Ownership ---}
    wbXOWN,

    wbFormIDCk(XEZN, 'Encounter Location', [LCTN]),

    wbFormIDCk(XLYR, 'Layer', [LAYR]),

    wbFloat(XHTW, 'Head-Tracking Weight'),

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

  var wbREFRNavmeshTriangleToStr: TwbIntToStrCallback :=
    function(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string
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

  {subrecords checked against Starfield.esm}
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

    wbStruct(XALD, 'Light Area', [
      wbFloat,
      wbFloat,
      wbUnknown(8)
    ]),

    wbStruct(XSAD, 'Ship Arrival', [
      wbUnknown(17)
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
      wbFloat('FOV 90+/-'),
      wbFloat('Fade 1.0+/-'),
      wbFloat('End Distance Cap'),
      wbFloat('Shadow Depth Bias'),
      wbFloat('Near Clip'),
      wbFloat('Volumetric Intensity'),
      wbUnused(4),
      wbInteger('Unknown', itU8),
      wbUnused(3)
    ], cpNormal, False, nil, 4),

    wbFloat(XRDS, 'Radius'),

    wbFormIDCk(XCZC, 'Current Zone Cell', [CELL, NULL]),
    wbUnknown(XCZA),

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
      ])),
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

    wbFormIDCk(XLCN, 'Persistent Location', [LCTN]),

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

    wbStruct(XLGD, 'Light Gobo', [
    { 0} wbUnknown(4),
    { 4} wbFloat,
    { 8} wbUnknown(8),
    {16} wbFloat,
    {20} wbFloat,
    {24} wbUnknown(64)
    {88}
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

    wbInteger(XCNT, 'Item Count', itS32),

    wbXFLG,

    wbStruct(XLFD, 'Light Flicker', [
    { 0} wbFloat,
    { 4} wbFloat,
    { 8} wbUnknown(8)
    {16}
    ]),

    {--- Map Data ---}
    wbRStruct('Map Marker', [
      wbMarkerReq(XMRK),
      wbInteger(FNAM, 'Map Flags', itU32, wbFlags([
        {0x0001} 'Visible',
        {0x0002} 'Can Travel To',
        {0x0004} '"Show All" Hidden',
        {0x0008} 'Use Location Name',
        {0x0010} 'Unknown 4',
        {0x0020} 'Unknown 5',
        {0x0040} 'Unknown 6',
        {0x0080} 'Unknown 7',
        {0x0100} '',
        {0x0200} 'Unknown 9'
      ]), cpNormal, True),
      wbFULLReq,
      wbStruct(TNAM, 'Type', [
        wbInteger('Type', itU8, wbEnum([
          'Unknown 0',
          'Unknown 1',
          '',
          'Unknown 3',
          'Unknown 4',
          '',
          '',
          'Unknown 7',
          'Unknown 8',
          '',
          'Unknown 10',
          'Unknown 11',
          'Unknown 12',
          'Unknown 13',
          'Unknown 14',
          'Unknown 15',
          'Unknown 16',
          '',
          'Unknown 18',
          'Unknown 19',
          'Unknown 20',
          'Unknown 21',
          'Unknown 22',
          'Unknown 23',
          'Unknown 24',
          'Unknown 25',
          '',
          'Unknown 27',
          'Unknown 28',
          'Unknown 29',
          'Unknown 30',
          'Unknown 31',
          'Unknown 32',
          'Unknown 33',
          'Unknown 34',
          'Unknown 35',
          'Unknown 36',
          'Unknown 37',
          'Unknown 38',
          'Unknown 39',
          'Unknown 40',
          'Unknown 41',
          '',
          'Unknown 43',
          'Unknown 44',
          'Unknown 45',
          'Unknown 46',
          'Unknown 47',
          'Unknown 48',
          '',
          'Unknown 50'
        ])),
        wbUnused(1)
      ], cpNormal, True),
      wbUnknown(VNAM, 2),
      wbLString(UNAM, 'Unknown', 0, cpTranslate),
      wbUnknown(VISI, 1)
    ], []),

    wbInteger(XLLD, 'Light Layer Data', itU32, wbBoolEnum),

    wbFloat(XLVD, 'Light Volumetric Data'),

    wbXEED,

    wbXOWN,

    wbStruct(XLRD, 'Light Roundness', [
    { 0} wbFloat,
    { 4} wbFloat,
    { 8} wbFloat,
    {12} wbFloat,
    {16} wbInteger('Unknown', itU8),
    {17} wbUnused(3)
    ]),

    wbStruct(XLBD, 'Light Barndoor Data', [
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbInteger('Unknown', itU8),
      wbInteger('Unknown', itU8),
      wbUnused(2)
    ]),

    wbInteger(XLSM, 'Light Static Shadow Map', itU32, wbBoolEnum),

    wbRArray('Light Colors', wbStruct(XLCD, 'Light Color', [
      wbByteRGBA,
      wbUnknown(5),
      wbUnused(3)
    ])),

    wbArray(XLMS, 'Layered Material Swaps', wbFormIDCk('Layered Material Swap', [LMSW])),

    wbFormIDCk(XEZN, 'Encounter Location', [LCTN]),

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

    wbStruct(XNDP, 'Navigation Door Link', [
      wbFormIDCk('Navigation Mesh', [NAVM]),
      wbInteger('Teleport Marker Triangle', itS16, wbREFRNavmeshTriangleToStr, wbStringToInt),
      wbUnused(2)
    ]),

    wbEmpty(XATP, 'Activation Point'),

    wbXSCL,

    wbEmpty(ONAM, 'Open by Default'),

    wbDataPosRot,

    wbString(MNAM, 'Comments')
  ], True, wbPlacedAddInfo, cpNormal, False);

  var lS: PAnsiChar := @TES4;

  {subrecords checked against Starfield.esm}
  wbRecord(REGN, 'Region',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
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
        ])),
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

  var lTM := Ord(wbToolMode);

  {subrecords checked against Starfield.esm}
  wbRecord(SOUN, 'Sound Marker', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbXALG,
    wbKeywords,
    wbSoundReference(SMLS),
    wbStruct(DEVT, 'Unknown', [
      wbUnknown(4),
      wbFloat
    ])
  ]);

  var wbSPIT := wbStruct(SPIT, 'Data', [
    { 0} wbUnknown(9),
    { 9} wbFloat,
    {13} wbUnknown(14)


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
    wbPUSH,
    wbPDSH,
    wbDESCReq,
    wbSPIT,
    wbEffects
  ], False, nil, cpNormal, False, nil, nil);

  {wbRecord(SCRL, 'Scroll', [
    wbEDID
  ]);}

  if lTM - 1 = 0  then
    Inc(lS[0]);

  {subrecords checked against Starfield.esm}
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
      {0x20000000} {29} 'Unknown 29',
      {0x40000000} {30} 'NavMesh Generation - Ground',
      {0x80000000} {31} ''
    ]), [
    wbEDID,
//    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH, //order between SNBH
    wbXALG, //and XALG unknown
    wbDEFL,
    wbBaseFormComponents,
    wbFTYP,
    wbGenericModel(),
    wbPRPS,
    wbFULL,
    wbStruct(DNAM, 'Direction Material', [
      wbFloat('Max Angle (30-120)'),
      wbFloat,
      wbFloat('Leaf Amplitude'),
      wbFloat('Leaf Frequency')
    ], cpNormal, True, nil, 2),
    wbSoundReference(STLS),
    wbNVNM
  ], False);

  {subrecords checked against Starfield.esm}
  wbRecord(TES4, 'Main File Header',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000001}  0, 'ESM',
      {0x00000010}  4, 'Optimized File',
      {0x00000080}  7, 'Localized',
      {0x00000100}  8, 'ESL',
      {0x00000200}  9, 'Overlay'
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

    wbInteger(INTV, 'Unknown', itU32),                                // Ignored by the runtime, 4 bytes loaded in CK

    wbInteger(INCC, 'Internal Cell Count', itU32),                    // Size of some array of 12 bytes elements

    wbUnknown(CHGL)
  ], True, nil, cpNormal, True, wbRemoveOFST);

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
    wbODTY,
    wbOPDS,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(),
    wbDEST,
    wbKeywords,
    wbPRPS,
    wbUnknown(PNAM),
    wbATTX,
    wbUnknown(FNAM),
    wbUnknown(JNAM),
    wbFormIDCk(PFIG, 'Ingredient', sigBaseObjects),
    wbSoundReference(PFHS),
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
    wbFloat(BNAM),
    wbFloat(FMAH),
    wbFloat(FMIH),
    wbFormIDCk(FMAG, 'Max Global', [GLOB]),
    wbFormIDCk(FMIG, 'Min Global', [GLOB]),
    wbFormIDCk(FLXP, 'Explosion', [EXPL]),
    wbSoundReference(FHLS)
  ], False, nil, cpNormal, False, nil, nil);

  {subrecords checked against Starfield.esm}
  wbRecord(WATR, 'Water', [
    wbEDID,
    wbFULL,
    wbInteger(ANAM, 'Opacity (unused)', itU8),
    wbInteger(FNAM, 'Flags', itU8, wbFlags([
      {0x01} 'Dangerous',
      {0x02} 'Unknown 1',
      {0x04} 'Directional Sound'
    ]), cpNormal, True),
    wbSoundReference(WASH),
    wbFormIDCk(XNAM, 'Consume Spell', [SPEL]),
    wbFormIDCk(YNAM, 'Contact Spell', [SPEL]),
//    wbFormIDCk(INAM, 'Image Space', [IMGS]),
    wbUnused(DATA, True),
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
        wbFloat('Layer 3 - Wind Speed')
      ]),
      wbStruct('Silt Properties', [
        wbFloat('Silt Amount'),
        wbByteColors('Light Color'),
        wbByteColors('Dark Color')
      ]),
      wbInteger('Screen Space Reflections', itU8, wbBoolEnum)
    ], cpNormal, True, nil, 4),
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
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  2, 'Non-Playable',
      {0x20000000} 30, 'High-Res 1st Person Only'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbPTT2,
    wbBaseFormComponents,
    wbFULL,
    wbGenericModel(),
    wbEITM,
    wbInteger(EAMT, 'Enchantment Amount', itU16),
//    wbDEST,
    wbETYP,
    wbFormIDCk(BIDS, 'Block Bash Impact Data Set', [IPDS, NULL]),
    wbFormIDCk(BAMT, 'Alternate Block Material', [MATT, NULL]),
    wbPUSH,
    wbPDSH,
    wbKeywords,
    wbDESC,
    wbFormIDCk(INRD, 'Instance Naming', [INNR]),
    wbAPPR,
    wbObjectTemplate,
    wbEmpty(STOP, 'Marker', cpNormal, True),
    wbFormIDCk(NNAM, 'Embedded Weapon Mod', [NULL, OMOD]),
    wbEmpty(BNAM, 'Unknown'),
    wbStruct(WAIM, 'Unknown', [
      wbFloat('Unknown'),
      wbFormIDCk('Zoom', [NULL, ZOOM]),
      wbFormIDCk('Aim Model', [NULL, AMDL]),
      wbUnknown(2),
      wbFormIDCk('Aim Assist Model Data', [NULL, AAMD]),
      wbFormIDCk('Aim Optical Sight Marker', [NULL, AOPS]),
      wbFormIDCk('Melee Aim Assist Model', [NULL, MAAM]),
      wbUnknown
    ]),
    wbStruct(WAM2, 'Unknown', [
      wbFormIDCk('Ammo Type', [NULL, AMMO]),
      wbInteger('Magazine size', itu32),
      wbFormIDCk('Ammo List', [NULL, LVLI]),
      wbFormIDCk('Projectile', [NULL, PROJ]),
      wbFormIDCk('Ejections', [NULL, ARTO]),
      wbUnknown
    ]),
    wbStruct(WAUD, 'Audio', [
      wbSoundReference('Melee or Creature'),
      wbSoundReference('Primed (Explosive)'),
      wbSoundReference('Dry Fire'),
      wbSoundReference('Idle'),
      wbSoundReference('Equip'),
      wbSoundReference('Unequip'),
      wbSoundReference('Fast Equip'),
      wbInteger('Unknown', itU32),
      wbInteger('Unknown', itU32)
    ]),
    wbStruct(WTUR, 'Unknown', [
      wbUnknown(1),
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat
    ]),
    wbStruct(WCHG, 'Unknown', [
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbUnknown
    ]),
    wbStruct(WDMG, 'Unknown', [
      wbFloat('Physical Damage'),
      wbFloat('Optimal Range'),
      wbFloat('Max Range'),
      wbFloat,
      wbFloat,
      wbFormIDCk('Crit Hit Spell', [NULL, SPEL]),
      wbUnknown(10),
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat
    ]),
    wbDamageTypeArray('Damage Type'),
    wbStruct(WFIR, 'Unknown', [
      wbInteger('Firing Type', itU8, wbEnum([
        {0} 'Single or Binary',
        {1} 'Burst',
        {2} 'Automatic'
      ])),
      wbInteger('Burst count', itU8),
      wbUnknown(1),
      wbFloat,
      wbFloat,
      wbFloat,
      wbFloat,
      wbUnknown(2),
      wbFloat('Fire Rate'),
      wbFloat,
      wbUnknown(1),
      wbFloat,
      wbUnknown(1),
      wbFloat,
      wbUnknown(2),
      wbFloat
    ]),
    wbUnknown(WFLG),
    wbStruct(WGEN, 'Unknown', [
      wbInteger('Unknown', itu32),
      wbFloat('Base weight'),
      wbInteger('Base value', itu32),
      wbFloat,
      wbFloat,
      wbFormIDCk('Weapon Barrel', [NULL, WBAR])
    ]),
    wbLStringKC(WABB, 'Unknown', 0, cpTranslate),
    wbStruct(WMEL, 'Unknown', [
      wbUnknown(1),
      wbFloat,
      wbFloat,
      wbInteger('Unknown', itU32)
    ]),
    wbUnknown(WMEL),
    wbStruct(QNAM, 'Unknown', [
      { 0} wbUnknown(4),
      { 4} wbFloat('Recharge time'),
      { 8} wbFloat('Recharge delay'),
      {12} wbUnknown(16),
      {28} wbFloat,
      {32} wbUnknown(4)
    ]),
    wbStruct(WRLO, 'Unknown', [
      wbFloat,
      wbFloat,
      wbUnknown(2)
    ]),
    wbStruct(WVAR, 'Unknown', [
      { 0} wbUnknown(4),
      { 4} wbFloat,
      { 8} wbUnknown(4),
      {12} wbFloat,
      {16} wbFloat,
      {20} wbFloat,
      {24} wbFloat,
      {28} wbFloat,
      {32} wbUnknown(4),
      {36} wbFloat,
      {40} wbFloat,
      {44} wbFloat,
      {48} wbUnknown(1)
    ]),
    wbRStruct('1st Person Model', [
      wbString(MOD4, 'Model FileName'),
      wbFLLD,
      wbMO4S
    ], []).IncludeFlag(dfAllowAnyMember),
    wbStruct(WVIS, 'Unknown', [
      { 0} wbUnknown(12),
      {12} wbFormIDCk('Impact Data Set', [NULL, IPDS]),
      {16} wbUnknown(8) // suspect first 4 bytes are RGBA 255, 255, 127, 127
    ]),                 // impact colour, maybe? if so it's the same for all weaps in Starfield.esm
    wbStruct(WTRM, 'Unknown', [
      { 0} wbFloat,
      { 4} wbUnknown(1),
      { 5} wbFloat,
      { 9} wbFloat,
      {13} wbFloat
    ])
  ], False, nil, cpNormal, False, nil{wbWEAPAfterLoad}, wbKeywordsAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(WRLD, 'Worldspace',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00080000} 19, 'Can''t Wait'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbRArray('Large References',
      wbStruct(RNAM, 'Grid', [
        wbInteger('Y', itS16, nil, cpIgnore),
        wbInteger('X', itS16, nil, cpIgnore),
        wbArray('References', wbStruct('Reference', [
          wbFormIDCk('Ref', [REFR], False, cpIgnore),
          wbInteger('Y', itS16, nil, cpIgnore),
          wbInteger('X', itS16, nil, cpIgnore)
        ]), -1).IncludeFlag(dfNotAlignable)
      ]),
      cpIgnore, False, nil, nil, wbNeverShow
    )
    .IncludeFlag(dfNotAlignable)
    .IncludeFlag(dfFastAssign),
    wbFULL,
    {
    wbStruct(WCTR, 'Fixed Dimensions Center Cell', [
      wbInteger('X', itS16),
      wbInteger('Y', itS16)
    ]),
    wbFormIDCk(LTMP, 'Interior Lighting', [LGTM]),
    }
    wbFormIDCk(XEZN, 'Encounter Location', [LCTN, NULL]),
    wbFormIDCk(XLCN, 'Location', [LCTN, NULL]),
    wbFormIDCk(BNAM, 'Biome', [BIOM]),
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
    wbString(NAM7),
    wbFormIDCk(NAM3, 'LOD Water Type', [WATR]),
    wbFloat(NAM4, 'LOD Water Height'),
    wbStruct(DNAM, 'Land Data', [
      wbFloat('Default Land Height'),
      wbFloat('Default Water Height')
    ]),
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
    wbUnknown(FNAM),
    wbWorldspaceOBND,
    wbFormIDCk(ZNAM, 'Music', [MUSC]),
    wbFormIDCk(WAMB, 'Ambient Set', [AMBS]),
    wbString(XEMP, 'Environment Map'),
    wbString(XWEM, 'Water Environment Map'),
    wbFloat(GNAM),
    wbRArray('Unknown', wbFormIDCk(LNAM, 'Unknown', [LTEX])),
    wbArray(XCLW, 'Unknown', wbFloat()), // seems to always have the same
    wbArray(WHGT, 'Unknown', wbFloat()), // length of both XCLW and WHGT?
    wbUnknown(HNAM),
    wbOFST,
    wbByteArray(CLSZ, 'Cell Size Data')
  ], False, nil, cpNormal, False, wbWRLDAfterLoad);

  {subrecords checked against Starfield.esm}
  wbRecord(WTHR, 'Weather',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000200}  9, 'Unknown 9'
    ])), [
    wbEDID,
    wbKeywords,
    wbUnknown(LNAM),
    wbFormIDCK(MNAM, 'Precipitation Type', [SPGD, NULL]),
    wbFormIDCK(NNAM, 'Visual Effect', [ARTO, NULL], False, cpNormal, True),
    wbUnknown(CLDC),
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
    wbStruct(HNAM, 'Volumetric Lighting', [
      wbFormIDCK('Sunrise',[VOLI, NULL]),
      wbFormIDCK('Day',[VOLI, NULL]),
      wbFormIDCK('Sunset',[VOLI, NULL]),
      wbFormIDCK('Night',[VOLI, NULL]),
      wbFormIDCK('EarlySunrise',[VOLI, NULL]),
      wbFormIDCK('LateSunrise',[VOLI, NULL]),
      wbFormIDCK('EarlySunset',[VOLI, NULL]),
      wbFormIDCK('EarlySunrise',[VOLI, NULL])
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
    wbRStruct('Aurora', [wbGenericModel()], []),
    wbFormIDCk(GNAM, 'Sun Glare Lens Flare', [LENS]),
    wbStruct(UNAM, 'Magic', [
      wbFormIDCk('On Lightning Strike - Spell', [SPEL, NULL]),
      wbFloat('On Lightning Strike - Threshold'),
      wbFormIDCk('On Weather Activate - Spell', [SPEL, NULL]),
      wbFromVersion(130, wbFloat('On Weather Activate - Threshold')),
      wbFromVersion(130, wbUnused(4)), // SPEL FormID for another context but unresolved in Fallout4.esm, legacy data
      wbFromVersion(130, wbFloat('Unused'))
    ], cpNormal, False),
    wbFloat(VNAM, 'Volatility Mult'), //Form Version 126+
    wbFloat(WNAM, 'Visibility Mult')  //Form Version 126+
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AMDL, 'Aim Model', [
    wbEDID,
    wbStruct(ANAM, 'Data', [
       wbFloat('Cone of Fire - Min Angle'),
       wbFloat('Cone of Fire - Max Angle'),
       wbFloat('Cone of Fire - Increase Per Shot'),
       wbFloat('Cone of Fire - Decrease Per Sec'),
       wbFloat('Cone of Fire - Decrease Delay in Sec'),
       wbFloat('Cone of Fire - Sneak Mult'),
       wbFloat('Recoil - Diminish Spring Force'),
       wbFloat('Recoil - Diminish Sights Mult'),
       wbFloat('Recoil - Min Per Shot'),
       wbFloat('Recoil - Max Per Shot'),
       wbFloat('Recoil - Hip Mult'),
       wbInteger('Runaway - Recoil Shots', itU32),
       wbFloat('Recoil - Arc'),
       wbFloat('Recoil - Arc Rotate'),
       wbFloat('Cone of Fire - Iron Sights Mult'),
       wbFloat('Stability - Base Stability')
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
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00800000} 23, 'Unknown 23'
    ])), [
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
    wbUnion(DNAM, 'Data', wbFormVersionDecider(78), [
      wbArray('Damage Types', wbInteger('Actor Value Index', itU32)),
      wbArray('Damage Types', wbStruct('Damage Type', [
        wbFormIDck('Actor Value', [AVIF, NULL]),
        wbFormIDck('Spell', [SPEL, NULL])
      ])
      .SetSummaryKey([0,1])
      .IncludeFlag(dfSummaryExcludeNULL)
      )
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(INNR, 'Instance Naming Rules', [
    wbEDID,
    wbInteger(UNAM, 'Target', itU32, wbEnum([], [
        0, 'None',
      $1D, 'Armor',
      $2D, 'Actor',
      $2A, 'Furniture',
      $2B, 'Weapon',
      $22, 'AdjectiveArmor',
      $30, 'AdjectiveWeapon',
      $32, 'CreaturePrefixSuffix'
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
    wbRStructs('Unknown', 'Unknown', [
      wbInteger(RSMC, 'Unknown', itU32),
      wbSoundReference(RSMH)
    ], [])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(LAYR, 'Layer', [
    wbEDID,
    wbFormIDCk(PNAM, 'Parent', [LAYR]),
    wbByteColors(XCLP),
    wbInteger(LODB, 'Unknown', itU32)                    //Values are 0,1, and 2
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(LENS, 'Lens Flare', [
    wbEDID,
    wbFloat(CNAM, 'Color Influence'),
    wbFloat(DNAM, 'Fade Distance Radius Scale'),
    wbFloat(ENAM),
    wbFloat(MNAM),
    wbFloat(XNAM),
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
            {0x02} 'Shrinks When Occluded',
            {0x04} 'Unknown 2'
          ]))
        ])
      ], []),
      cpNormal, False, nil, wbLENSAfterSet
    )
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(NOCM, 'Navigation Mesh Obstacle Cover Manager', [
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
    wbODTY,
    wbGenericModel(),
    wbEmpty(DATA),
    wbFormIDCk(ANAM, 'Applicable Item List', [LVLI]),
    wbFormIDCk(ENAM, 'Legendary Template List', [LGDI]),

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

  (* still exists in game code, but not in Starfield.esm * )
  wbRecord(NOTE, 'Note', [
    wbEDID,
    wbVMAD,
    wbOBND,
    wbPTT2,
    wbFULL,
    wbGenericModel(),
    wbICON,
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
      wbUnused(4),
      wbFormIDCk('Sound', [SNDR]),
      wbFormIDCk('Scene', [SCEN]),
      wbFormIDCk('Terminal', [TERM])
    ]),
    wbString(PNAM, 'Program File')
  ]);
  (**)

  {subrecords checked against Starfield.esm}
  wbRecord(OMOD, 'Object Modification',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000010} 4, 'Legendary Mod',
      {0x00000080} 7, 'Mod Collection',
      {0x00000100} 8, 'Unknown 8'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbFULL,
    wbDESC,
    wbGenericModel(),
    wbUnknown(XFLG),
//    wbStruct(DATA, 'Data', [
//      wbInteger('Include Count', itU32),
//      wbInteger('Property Count', itU32),
//      wbInteger('Unknown Bool 1', itU8, wbBoolEnum),
//      wbInteger('Unknown Bool 2', itU8, wbBoolEnum),
//      wbInteger('Form Type', itU32, wbEnum([], [
//        Sig2Int(ARMO), 'Armor',
//        Sig2Int(NPC_), 'Non-player character',
//        Sig2Int(WEAP), 'Weapon',
//        Sig2Int(NONE), 'None'
//      ])).SetDefaultEditValue('None'),
//      wbInteger('Max Rank', itU8),
//      wbInteger('Level Tier Scaled Offset', itU8),
//      wbFormIDCk('Attach Point', [KYWD, NULL]),
//      wbArray('Attach Parent Slots', wbFormIDCk('Keyword', [KYWD, NULL]), -1),
//      // no way to change these in CK, legacy data leftover?
//      wbArray('Items', wbStruct('Item', [
//        wbByteArray('Value 1', 4),
//        wbByteArray('Value 2', 4)
//      ]), -1),
//      // should not be sorted
//      wbArray('Includes', wbStruct('Include', [
//        wbFormIDCk('Mod', [OMOD]),
//        wbInteger('Minimum Level', itU8),
//        wbInteger('Optional', itU8, wbBoolEnum),
//        wbInteger('Don''t Use All', itU8, wbBoolEnum)
//      ]), wbOMODDataIncludeCounter, cpNormal, False, nil, wbOMODincludeAfterSet),
//      wbObjectModProperties
//    ], cpNormal, False, nil, -1, nil, wbOMODdataAfterSet),
    wbStruct(DATA, 'Data', [
      wbInteger(csIncludeCount, itU32),
      wbInteger(csPropertyCount, itU32),
      wbUnknown(2),
      wbLenString('Name', 4),
      wbUnknown(2),
      wbFormIDCk('Attach Point', [KYWD, NULL]),
      wbArray('Attach Parent Slots', wbFormIDCk('Keyword', [KYWD, NULL]), -1),
      wbUnknown(4),
      wbArray('Includes', wbStruct('Include', [
        wbFormIDCk('Mod', [OMOD]),
        wbInteger('Minimum Level', itU8),
        wbInteger('Optional', itU8, wbBoolEnum),
        wbInteger('Don''t Use All', itU8, wbBoolEnum)
      ])).SetCountPath(csIncludeCount),
      wbObjectModProperties
    ]),
    wbArray(MNAM, 'Target OMOD Keywords', wbFormIDCk('Keyword', [KYWD])),
    wbArray(FNAM, 'Filter Keywords', wbFormIDCk('Keyword', [KYWD])),
    wbFormIDCk(LNAM, 'Loose Mod', sigBaseObjects), //not in Starfield.esm
    wbInteger(NAM1, 'Priority', itU8),
    wbFLTR
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
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000200}  9, 'Prefab',
      {0x00000400} 10, 'Unknown 10',
      {0x00000800} 11, 'Unknown 11',
      {0x02000000} 25, 'Unknown 25'
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND,
    wbODTY,
    wbOPDS,
    wbPTT2,
    wbSNTP,
    wbSNBH,
    wbXALG,
    wbBaseFormComponents,
    wbFLTR,
    wbOPDS,
    //wbUnknown(CNAM),
    wbFormIDCk(CNAM, 'Cell', [CELL]),
    wbInteger(VNAM, 'Version', itU32),
    wbUnknown(FNAM),
    wbKeywords,
    wbNTRM,
    wbFTYP,
    wbPRPS,
    wbStruct(MOLM, 'Material Swaps', [
      wbArrayS('Material Swaps', wbFormIDCk('Layered Material Swap', [LMSW]), -2),
      wbByteArray('Unused', 0, cpIgnore).SetDontShow(wbNeverShow).IncludeFlag(dfDontAssign)
    ]),
    wbFULL
  ]);

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

  (* still exists in game code, but not in Starfield.esm * )
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
  (**)

  var wbStaticPart :=
    wbRStructSK([0], 'Part', [
      wbStruct(ONAM, 'Unknown', [
        wbFormIDCk('Static', [ACTI, ALCH, AMMO, BOOK, CONT, DOOR, FURN, MISC, MSTT, STAT, TERM, WEAP, FLOR]),
        wbUnknown(4)
      ]),
      wbStaticPartPlacements
    ], [], cpNormal, True);

  {subrecords checked against Starfield.esm}
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
    wbODTY,
    wbSNTP,
    wbBaseFormComponents,
    wbGenericModel(),
    wbFULL,
    wbFLTR,
    wbRArrayS('Parts', wbStaticPart, cpNormal, True)
  ]);


  {subrecords checked against Starfield.esm}
  wbRecord(STAG, 'Animation Sound Tag Set', [
    wbEDID,
    wbInteger(STMS, 'Count', itU32),
    wbRStructsSK('Entries', 'Entry', [0], [
      wbString(STAE, 'Name'),
      wbSoundReference(STAD).SetRequired
    ], []).SetCountPath(STMS)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(TERM, 'Terminal',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  4, 'Unknown 4',
      {0x00002000} 13, 'Unknown 13',
      {0x00008000} 15, 'Has Distant LOD',
      {0x00010000} 16, 'Random Anim Start',
      {0x08000000} 27, 'Unknown 27',
      {0x20000000} 29, 'Unknown 29',
      {0x40000000} 30, 'Unknown 30'
    ])), [
    wbEDID,
    wbVMADFragmentedPERK, // same fragments format as in PERK
    wbOBND(True),
    wbODTY,
    wbPTT2,
    wbBaseFormComponents,
    wbFormIDCk(DNAM, 'Menu', [TMLM]),
    wbUnknown(NAM1),
//    wbLStringKC(NAM0, 'Header Text'),
//    wbLStringKC(WNAM, 'Welcome Text'),
    wbFULL,
    wbGenericModel(),
    wbKeywords,
    wbPRPS,
    wbFTYP,
    wbUnknown(PNAM),
    wbUnknown(FNAM),
    wbUnknown(JNAM),
    wbMNAMFurnitureMarker,
    wbUnknown(GNAM),
    wbByteArray(WBDT, 'Workbench Data (unused)', 0),
    wbFormIDCk(FTMP, 'Furniture Template', [FURN]),
    wbUnknown(FNPR),
    wbString(XMRK, 'Marker Model'),
    wbSNAMMarkerParams,
    //wbObjectTemplate, not in Starfield.esm, but likely given STOP marker
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
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00008000} 16, 'Around Origin',
      {0x00010000} 17, 'Unknown'
    ])), [
    wbEDID,
    wbStruct(DATA, 'Data', [
      wbPosRot,
      wbFloat('Scale'),
      wbFloat('Zoom Min'),
      wbFloat('Zoom Max')
    ], cpNormal, True, nil, 2)
    .SetSummaryKeyOnValue([0,1,2,3])
    .SetSummaryPrefixSuffixOnValue(1, '[Scale] ',' ')
    .SetSummaryPrefixSuffixOnValue(2, '[Min] ',' ')
    .SetSummaryPrefixSuffixOnValue(3, '[Max] ',' ')
    .IncludeFlagOnValue(dfSummaryMembersNoName),
    wbUnknown(BNAM),
    wbUnknown(ENAM)
  ]).SetSummaryKey([1]);

  {subrecords checked against Starfield.esm}
  wbRecord(ZOOM, 'Zoom', [
    wbEDID,
    wbStruct(ZNAM, 'Data', [
      wbFormIDCk('Image Space Modifier', [IMAD, NULL]),
      wbVec3('Camera Offset'),
      wbFloat('FOV Mult'),
      wbInteger('Overlay', itU8, wbEnum([
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
        {16} 'Rectangle',
        {17} 'Tactical 4x',
        {18} 'Tactical 2x'
      ])),
      wbFloat('ADS Distance from Camera Offset'),
      wbInteger('ADS Height Delay Enabled', itU8, wbBoolEnum),
      wbFloat('ADS Height Delay S'),
      wbInteger('ADS Depth Enabled', itU8, wbBoolEnum),
      wbFloat('ADS Depth Delay S')
    ])
  ]);


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
    wbInteger(AAPS, 'Count', itU32),
    wbRStructS('Connections', 'Connection', [
      wbString(ANAM, 'Part'),
      wbString(BNAM, 'Part'),
      wbFloat(RADR),
      wbFloat(WTMX)
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
    wbODTY,
    wbXALG, //unknown if before or after NNAM
    wbString(NNAM, 'Description'),
    wbRArray('Echos',
      wbRStruct('Echo', [
        wbRUnion('Echo Marker', [
          wbEmpty(ECHO, 'Echo Start Marker'),
          wbEmpty(ECHD, 'Echo Default Start Marker')
        ], []),
        wbWwiseGuid(ECTE),
        wbSoundReference(ECSH),
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
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(STND, 'Snap Template Node', [
    wbEDID,
    wbOBND,
    wbODTY,
    wbBaseFormComponents,
    wbGenericModel(),
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
    wbRArray('Adjacent Snap Nodes', wbFormIDCk(NNAM, 'Adjacent Snap Node', [STND]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole)),
    wbRArray('Snap Angles', wbFloat(FLTV, 'Snap Angle'), 3),
    wbFormIDCk(ANAM, 'Art Object', [ARTO])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(STMP, 'Snap Template', [
    wbEDID,
    wbBaseFormComponents,
    //wbPTT2,
    wbFormIDCk(PNAM, 'Parent', [STMP]),
    wbRArray('Nodes',
      wbStruct(ENAM, 'Node', [
        wbInteger('Node ID', itU32),
        wbFormIDCk('Node', [STND]),
        wbVec3PosRotDegrees('Orientation', 'Offset', 'Rotation', 'Ofs:', 'Rot:'),
 //       wbVec3('Offset', 'Ofs:'),
 //       wbVec3('Rotation', 'Rot:'),
        wbInteger('Unknown', itU32),
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
    wbRArray('Parent Nodes', wbRStruct('Parent Node', [
      wbInteger(ONAM, 'Node ID', itU32),
      wbVec3PosRotDegrees(TNAM, 'Unknown')
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
      wbFormIDCk(GNAM, 'Grass', [GRAS]),
      wbInteger(DNAM, 'Unknown', itS16)
    ], [])),
    wbRArray('Landscape Textures', wbFormIDCk(LNAM, 'Landscape Texture', [LTEX])),
    wbFloat(YNAM)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(VOLI, 'Volumetric Lighting', [
    wbEDID,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PMFT, 'Photo Mode Feature', [
    wbEDID,
//    wbXALG,
//    wbFTAGs,
    wbFULL,
//    wbICON,
//    wbCTDAs,
    wbStruct(FNAM, 'Unknown', [
      wbInteger('Feature Type', itU8, wbPhotoModeEnum)          ,
      wbFloat('X offset'),
      wbFloat('Y offset'),
      wbUnknown(8),
      wbInteger('Width', itU32),
      wbInteger('Height', itU32),
      wbUnknown()
    ]),
    wbString(HNAM, 'Texture'),
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
    wbFormIDCk(QNAM, 'Quest', [QUST])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AOPF, 'Audio Occlusion Primitive', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbFloat(OBSV),
    wbFloat(OCCV)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PDCL, 'Projected Decal', [
    wbEDID,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbBaseFormComponents,
    wbPTT2,
    wbSNBH,
    wbFormIDCk(DODT, 'Material', [MTPT]),
    wbStruct(DATA, 'Data', [// possibly the same format as wbDODT? which is different from the DODT usage above...
      { 0} wbFloat,
      { 4} wbFloat,
      { 8} wbFloat,
      {12} wbFloat,
      {16} wbFloat,
      {20} wbFloat
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(CUR3, 'Curve 3D', [
    wbEDID,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(BMMO, 'Biome Marker',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00100000} 20, 'Unknown 20' //all occurences on prey/preditor BMMOs
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY.SetRequired,
    wbOPDS,
    wbGenericModel(),
    wbKeywords,
    wbCTDAs,
    wbFormIDCk(KNAM, 'Marker Type', [NULL, KYWD]).SetRequired,
    wbFormIDCk(LNAM, 'Flora List', [NULL, LVLI]).SetRequired,
    wbFormIDCk(LNA2, 'Unknown', [NULL, FLOR, PKIN, STAT]).SetRequired //probably any type of non-actor reference?
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(GBFT, 'Generic Base Form Template', [
    wbEDID,
    wbRArray('Components', wbString(STRV, 'Component'))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(GBFM, 'Generic Base Form',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([
      {0x00000004}  2, 'Unknown 2'                      //Possibly "Unique"
    ])), [
    wbEDID,
    wbVMAD,
    wbOBND(True),
    wbODTY,
    wbOPDS,
    wbBaseFormComponents,
    wbFLTR,
    wbFormIDCk(ANAM, 'Template', [GBFT]),
    wbRArray('Unknown', wbString(STRV)),
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
      {0x0001} 'Calculate from all levels <= player''s level',
      {0x0002} 'Calculate for each item in count',
      {0x0004} 'Calculate All',
      {0x0008} 'Unknown 3',
      {0x0010} 'Unknown 4',
      {0x0020} '',
      {0x0040} 'Unknown 6',
      {0x0080} '',
      {0x0100} '',
      {0x0200} 'Unknown 9'
    ]), cpNormal, True),
    wbFormIDCk(LVLG, 'Use Global', [GLOB]),
    wbCTDAs,
    wbLLCT,
    wbRArrayS('Leveled List Entries', wbLeveledListEntryBaseForm, cpNormal, False, nil, wbLVLOsAfterSet),
    wbGenericModel()
  ], False, nil, cpNormal, False, nil, wbLLEAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(WTHS, 'Weather Settings', [
    wbEDID,
    wbREFL,
    wbFormIDCk(RFDP, 'Reflection Parent', [WTHS]),
    wbRDIF
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(MAAM, 'Melee Aim Assist Model', [
    wbEDID,
    wbStruct(SNAM, 'Data', [
      wbFloat('Outer Cone Angle Degrees'),
      wbFloat('Inner Cone Angle Degrees'),
      wbFloat('Steering Degrees Per Sec'),
      wbFloat('Snap Steering Multiplier Outer Ring'),
      wbFloat('Snap Steering Multiplier Inner Ring'), { default 'MeleeBase_AA' entry has a value of -8000, this seems to be read as absolute by the engine }
      wbFloat('Max Aim Assist Distance'),
      wbInteger('Melee Aim Assist Enabled', itU8, wbBoolEnum),
      wbFloat('Unknown') { possibly 'Move Follow Degrees Per Sec'? couldn't figre out what this is doing }
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(IRES, 'Resource', [
    wbEDID,
    wbFULL,
    wbKeywords,
    wbCUSH,
    wbFormIDCk(FNAM, 'Item List', [LVLI]),
    wbInteger(SNAM, 'Rarity', itU32, wbEnum ([], [
        0, 'Common',
        1, 'Uncommon',
        2, 'Rare',
        3, 'Exotic',
        4, 'Unique',
        5, 'Unique to He-3',
        6, 'Unique to H2O'
      ])),
    wbRArray('Next rarities', wbFormIDCk(CNAM, 'Next Rarity', [IRES])),
    wbByteColors(TINC, 'Surface color'), // not the color in the icons but that on the surface
    wbLString(NNAM, 'Short Name'),
    wbString(GNAM, 'Resource Type'),
    wbFormIDCk(NAM1, 'Actor Value', [NULL, AVIF]),
    wbFormIDCk(NAM2, 'Produce', [NULL, LVLI, COBJ]),
    wbFormIDCK(NAM3, 'Interval', [NULL, GLOB])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(BIOM, 'Biome', [
    wbEDID,
    wbFULL,
    wbKeywords,
    wbString(SNAM, 'Biome Type'),
    wbArray(PNAM, 'Plants', wbFormIDCk('Flora', [FLOR])),
    wbFormIDCk(RNAM, 'Resource Generation Data', [RSGD]),
    wbRStructs('Unknown', 'Unknown', [
      wbString(FNAM),
      wbUnknown(BNAM),       //Always 01 00 00 00 if it exists
      wbRArray('Unknown', wbStruct(GNAM, 'Unknown', [
        wbFormIDCk('Pack-In', [PKIN, LVLP]),
        wbArray('Unknown', wbUnknown(4), 20)
      ])),
      wbArray(DNAM,'Unknown', wbFloat(), 4)
    ], []),
    wbFormIDCk(ONAM, 'Biome Swap', [OSWP]),
    wbRArray('Material Swaps', wbFormIDCk(NAM1, 'Material Swap', [LMSW])),
    wbFormIDCk(ENAM, 'Climate', [CLMT]),
    wbRStruct('Water Data', [
      wbInteger(MNAM, 'Has Water', itU8, wbBoolEnum), //implicit required
      wbFormIDCk(INAM, 'Water', [WATR]),
      wbString(JNAM, 'Water Material')
    ], []),
    wbFloat(WNAM, 'Unknown'),
    wbFloat(YNAM, 'Unknown'),
    wbFloat(UNAM, 'Unknown'),
    wbFormIDCk(BIAS, 'Ambient Set', [AMBS]),
    wbFormIDCk(BIMT, 'Music', [MUSC]),
    wbFormIDCk(NAM0,'Unknown', [TODD]),
    wbFormIDCk(NNAM, 'Pattern Style', [PTST]),
    wbByteRGBA(CNAM),
    wbByteRGBA(BMC1, 'Biome Color 1'),
    wbByteRGBA(BMC2, 'Biome Color 2'),
    wbByteRGBA(BMC3, 'Biome Color 3'),
    wbInteger(TNAM, 'Unknown', itU32),
    wbRStructs('Marker Type', 'Type', [
      wbFormIDCk(KNAM, 'Keyword', [KYWD]),
      wbKeywords
    ], []),
    wbRStructs('Unknown', 'Unknown', [
      wbStruct(LNAM, 'Unknown', [
        wbInteger('Unknown', itU32),
        wbFormIDCk('Land Texture', [LTEX]),
        wbFormIDCk('Ground Cover', [NULL, GCVR])
      ]),
      wbStruct(ANAM, 'Unknown', [
        wbInteger('Unknown', itU32),
        wbFormIDCk('Land Texture', [LTEX]),
        wbFormIDCk('Ground Cover', [GCVR, NULL])
      ]),
      wbString(TX00, 'Mask - Type 0'),
      wbString(UX00, 'Mask - Type 1'),
      wbString(VX00, 'Mask - Type 2'),
      wbString(WX00, 'Mask - Type 3'),
      wbString(XX00, 'Mask - Type 4'),
      wbString(YX00, 'Mask - Type 5')
    ], []),
    wbString(TX16, 'Ground Layer Normal'),
    wbArray(BTPS, 'Unknown', wbUnknown(4), 56),
    wbArray(BDFS, 'Unknown', wbUnknown(4), 11),
    wbString(EFSD, 'Ground Layer Material'),
    wbFormIDCk(NAM2, 'Unknown', [NULL, GLOB]),
    wbFormIDCk(NAM3, 'Unknown', [GLOB]),
    wbFormIDCk(NAM4, 'Unknown', [GLOB])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AMBS, 'Ambience Set', [
    wbEDID,
    wbRStruct('Ambient Sounds', [
      wbInteger(ASAS, 'Count', itU32, nil, cpBenign, True), //count
      wbRArray('Sounds', wbStruct(ASAE, 'Unknown', [
      { 0} wbSoundReference,
      {40} wbUnknown(8),
      {48} wbWwiseGuid('Variation'),
      {64} wbInteger('Unknown', itU8, wbBoolEnum),
      {65} wbFloat,
      {69} wbUnknown(4)
      {73}
      ]))
        .SetCountPath(ASAS)
        .SetRequired
    ], []),
    wbInteger(ASMB, 'Unknown', itU8, wbBoolEnum),
    wbSoundReference(WED0, 'Walla')
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(AOPS, 'Aim Optical Sight Marker', [
    wbEDID,
    wbStruct(ANAM, 'Data', [
      wbInteger('Hide Beam By Default', itU8, wbBoolEnum),
      wbLenString('Node Name'),
      wbFloat('Beam Reactivation Delay After Equip/Reload S'),
      wbFloat('Beam Deactivation Delay After Reload S'),
      wbFormIdCk('Light', [LIGH]),
      wbFloat('Unknown'),
      wbFloat('Unknown'),
      wbFloat('Beam Reactivation Delay After Firing S'),
      wbFormIdCk('Beam Art Object', [ARTO, NULL]),
      wbFormIdCk('Dot Art Object', [ARTO,  NULL]),
      wbFloat('Unknown'), { vaguely related to length/range, but not range itself }
      wbUnknown(1),
      wbInteger('Show Beam At Hip', itU8, wbBoolEnum),
      wbUnknown(1)
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
  wbRecord(AVMD, 'AVM Data', [
    wbEDID,
    wbBaseFormComponents,
    wbAVMDMNAMReq,
    wbString(YNAM).SetRequired,
    wbString(TNAM, 'Name').SetRequired,
    wbInteger(ITMC, 'Entry Count',itU32).SetRequired,
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
        wbByteRGBA(NNAM, 'Color')
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
          {0} 'None',
          {1} 'Rough',
          {2} 'Opacity',
          {3} 'Normal',
          {4} 'AO',
          {5} 'Metal',
          {6} 'Conditions',
          {7} 'Emissive'
        ])
    )
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
      wbLenString('Unknown').IncludeFlag(dfHasZeroTerminator),
      wbLenString('Unknown').IncludeFlag(dfHasZeroTerminator),
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
          wbFloat,
          wbLenString('Unknown').IncludeFlag(dfHasZeroTerminator)
        ]),
        wbStruct('MorphDriver Data', [
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbUnknown(1)
        ]),
        wbStruct('PoseDeformer Data', [
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbUnknown(1)
        ]),
        wbStruct('SpringBone Data', [
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbFloat,
          wbUnknown(1)
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
  ], False, nil, cpNormal, False, nil, wbLLEAfterSet);

  {subrecords checked against Starfield.esm}
  wbRecord(MRPH, 'Morphable Object', [
    wbEDID,
    wbString(TMPP, 'Unknown'),
    wbString(TCMP, 'Unknown'),
    wbUnknown(MOBC)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(MTPT, 'Material Path', [
    wbEDID,
    wbREFL
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(OSWP, 'Biome Swap', [ //OSWP -> EDID  (3)
    wbEDID
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PCBN, 'Planet Content Manager Branch Node', [
    wbEDID,
    wbBaseFormComponents,
    wbInteger(NAM1, 'Unknown', itU32, wbFlags([
      'Unknown 0',
      'Unknown 1'
    ])).SetRequired,
    wbInteger(NAM2, 'Unknown', itU32, wbEnum([
      'Unknown 0',
      'Unknown 1'
    ])).SetRequired,
    wbFormIDCk(NAM3, 'Count Curve', [CURV]),
    wbFormIDCk(NAM4, 'Distribution Curve', [CURV]),
    wbInteger(NAM5, 'Unknown', itU8, wbBoolEnum).SetRequired,
    wbRArray('Nodes', wbFormIDCk(PCCB, 'Node', [PCBN, PCCN])),
    wbCITCReq,
    wbCTDAsCount,
    wbKWDAs
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PCCN, 'Planet Content Manager Content Node', [
    wbEDID,
    wbBaseFormComponents,
    wbFormIDCk(PCCC, 'Content', [WRLD, LVLP, PKIN]),
    wbEmpty(IOVR),
    wbKWDAs
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PCMT, 'Planet Content Manager Tree', [
    wbEDID,
    wbUnknown(NAM1), //req
    wbUnknown(NAM2), //req
    wbUnknown(NAM5), //req
    wbRArray('Nodes', wbFormIDCk(PCCB, 'Node', [PCBN])),
    wbCITCReq,
    wbCTDAsCount
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(PNDT, 'Planet', [
    wbEDID,
    wbBaseFormComponents,
    wbArray(CNAM, 'Worldspaces',
      wbStruct('Worldspace', [
        wbStruct('Position', [
          wbLatitudeDouble,
          wbLongitudeDouble
        ])
          .SetSummaryKey([0, 1])
          .SetSummaryMemberPrefixSuffix(0, '(', '')
          .SetSummaryMemberPrefixSuffix(1, '', ')')
          .SetSummaryDelimiter(', ')
          .IncludeFlag(dfSummaryMembersNoName)
          .IncludeFlag(dfCollapsed, wbCollapsePosRot),
        wbFormIDCk('Worldspace', [WRLD])
      ])
    ).SetRequired,
    wbRArray('Biomes',
      wbStructSK(PPBD, [0], 'Biome', [
        wbFormIDCK('Biome', [BIOM]),
        wbFloat('Chance'),
        wbUnknown(4),
        wbFormIDCk('Resource Generation', [NULL, RSGD]).IncludeFlag(dfSummaryExcludeNULL),
        wbArray('Fauna', wbFormIDCk('Fauna', [NPC_]), -1),
        wbUnknown(4),
        wbStruct('Flora', [
          wbInteger('Count', itU32),
          wbInteger('Entry Size', itU32).SetDefaultNativeValue(9),
          wbArray('Entries',
            wbStruct('Entry', [
              wbFormIDCk('Flora', [FLOR]),
              wbFormIDCk('Resource', [MISC]),
              wbInteger('Frequency', itU8)
            ])
          )
            .SetCountPath('Count')
            .SetSummaryName('Flora')
        ])
          .SetSummaryKey([2]),
        wbUnknown()
      ])
      .SetSummaryKeyOnValue([1, 3, 4, 6])
      .SetSummaryPrefixSuffixOnValue(0, '', '')
      .SetSummaryPrefixSuffixOnValue(1, 'Chance: ', '%')
      .SetSummaryPrefixSuffixOnValue(3, '', '')
      .SetSummaryPrefixSuffixOnValue(4, '', '')
      .SetSummaryPrefixSuffixOnValue(6, '', '')
      .IncludeFlagOnValue(dfSummaryMembersNoName)
    ),
    wbFormIDCk(FNAM, 'Surface Tree', [NULL, SFTR]).SetRequired,
    wbFloat(GNAM).SetDefaultNativeValue(1.0).SetRequired,

    wbRStruct('Body', [
      wbMarkerReq(BDST),
      wbString(ANAM).SetRequired,
      wbInteger(CNAM, 'Body type', itU8, wbEnum([], [
        2, 'Planet',
        3, 'Moon',
        4, 'Orbital',
        5, 'Asteroid Belt'
      ])),
      wbStruct(DNAM, 'Unknown', [
        wbLenString.IncludeFlag(dfHasZeroTerminator),
        wbInteger('Unknown', itU8)
      ]).SetRequired,
      wbStruct(ENAM, 'Unknown', [
        wbDouble('Unknown', cpNormal, False, 1, Low(Integer)),
        wbDouble('Unknown', cpNormal, False, 1, Low(Integer)),
        wbDouble('Unknown', cpNormal, False, 1, Low(Integer)),
        wbDouble('Unknown', cpNormal, False, 1, Low(Integer)),
        wbUnknown(8),
        wbDouble('Unknown', cpNormal, False, 1, Low(Integer)),
        wbFloat,
        wbFloat,
        wbFloat,
        wbFloat,
        wbUnknown(1),
        wbUnknown(1),
        wbUnused(6)
      ]),
      wbStruct(FNAM, 'Unknown', [
        wbUnknown(4),
        wbFloat('Spawn-In Projection Offset'),
        wbFloat('Mass (in Earth Masses)', cpNormal, False, 1/5.972E24, 3),
        wbFloat('Radius in km'),
        wbFloat('Gravity'),
        wbUnknown(4)
      ]),
      wbStruct(GNAM, 'Unknown', [
        wbInteger('Star ID', itu32),
        wbInteger('Primary planet ID', itu32),
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
      wbStruct(INAM, 'Unknown', [
        wbInteger('Atmos Handle', itu32),
        wbFloat,
        wbFloat,
        wbFloat
      ]),
      wbStruct(KNAM, 'Unknown', [
        wbLenString,
        wbDouble('Unknown', cpNormal, False, 1, Low(Integer)),
        wbDouble('Unknown', cpNormal, False, 1, Low(Integer)),
        wbUnknown(1),
        wbUnknown(4),
        wbUnknown(4)
      ]),
      wbUnknown(NNAM),
      wbMarkerReq(BDED)
    ], []),

    wbFloat(TEMP, 'Temperature in C'),
    wbFloat(DENS, 'Density'),
    wbFloat(PHLA, 'Peri angle in deg'),
    wbInteger(RSCS, 'Resource Creation Seed', itU32)
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

  {subrecords checked against Starfield.esm}
  wbRecord(RSGD, 'Resource Generation Data', [
    wbEDID,
    wbRStructs('Unknown', 'Unknown', [
      wbFormIDCk(RNAM, 'Resource', [IRES]), //req
      wbArray(DNAM, 'Unknown',                // req
        wbArray('Unknown',
          wbFloat('Unknown'), 10), 14) // structure appears to fixed size
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
      wbInteger('Required Count', itU32),
      wbUnknown(4)
    ]),
    wbStructs(RQPK, 'Required Perks', 'Perk', [
      wbFormIDCk('Perk', [PERK]),
      wbInteger('Rank', itU32),
      wbUnknown(4)
    ]),
    wbFormID(CNAM, 'Icon Source'),
    wbUnknown(NNAM,2), // always 2 byte $0000
    wbFloat(SNAM, 'Menu Sort Order'),
    wbUnknown(TNAM,1), // always 1 byte $00
    wbFormIDCk(KNAM,'Category Keyword', [KYWD]),
    wbRArray('Required Projects', wbFormIDCk(RNAM, 'Required Project', [RSPJ]))
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
    wbString(ANAM),
    wbArray(DNAM, 'Unknown', wbInteger('Unknown', itU32), 2), //req
    wbArray(ENAM, 'Unknown', wbFloat('Unknown'), 2), //req
    wbUnknown(FNAM),
    wbUnknown(GNAM), //req always 1 byte $00
    wbInteger(HNAM, 'Unknown', itS16), //req
    wbUnknown(INAM), //req boolean?
    wbUnknown(JNAM), //req boolean?
    wbInteger(KNAM, 'Unknown', itU8), //req
    wbFloat(WHGT), //req
    wbString(NAM0),
    wbString(NAM1),
    wbUnknown(NAM2), // always 8 bytes zero
    wbArray(NAM3, 'Unknown', wbInteger('Unknown', itU32), 2),
    wbArray(NAM4, 'Unknown', wbFloat('Unknown'), 2),
    wbFormIDCk(NAM5, 'Surface Block', [SFBK, NULL] )
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SFPC, 'Surface Pattern Config', [
    wbEDID,
    wbFormIDCk(ENAM, 'Surface Pattern Style', [NULL, PTST]).SetRequired,
    wbRStructs('Unknown', 'Unknown', [
      wbString(BNAM, 'Type'),
      wbFloat(CNAM, 'Chance') // chance or weight?
    ], []),
    wbArray(DNAM, 'Unknown', wbFloat('Unknown'), 3).SetRequired  // seems to be fixed length
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
    .IncludeFlag(dfCollapsed)
    .SetRequired,

    wbArray(DNAM, 'Worldspaces', wbFormIDCk('Worldspace', [WRLD]))
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(SFTR, 'Surface Tree',
  wbFlags(wbRecordFlagsFlags, [
      {0x00000001} { 0} '',
      {0x00000002} { 1} '',
      {0x00000004} { 2} '',
      {0x00000008} { 3} '',
      {0x00000010} { 4} 'Unknown 4',
      {0x00000020} { 5} '',
      {0x00000040} { 6} '',
      {0x00000080} { 7} '',
      {0x00000100} { 8} '',
      {0x00000200} { 9} '',
      {0x00000400} {10} '',
      {0x00000800} {11} '',
      {0x00001000} {12} '',
      {0x00002000} {13} '',
      {0x00004000} {14} '',
      {0x00008000} {15} '',
      {0x00010000} {16} '',
      {0x00020000} {17} '',
      {0x00040000} {18} 'Unknown 18',
      {0x00080000} {19} '',
      {0x00100000} {20} '',
      {0x00200000} {21} '',
      {0x00400000} {22} '',
      {0x00800000} {23} '',
      {0x01000000} {24} '',
      {0x02000000} {25} '',
      {0x04000000} {26} '',
      {0x08000000} {27} '',
      {0x10000000} {28} '',
      {0x20000000} {29} '',
      {0x40000000} {30} '',
      {0x80000000} {31} ''
    ]), [
    wbEDID,
    wbBaseFormComponents,
    wbUnknown(CNAM).SetRequired,
    wbUnknown(DNAM).SetRequired,
    wbArray(ENAM, 'Surface Patterns', wbFormIDCk('Surface Pattern', [SFPT]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole), 65536).IncludeFlag(dfCollapsed).SetRequired,
    wbArray(ENAM, 'Surface Patterns', wbFormIDCk('Surface Pattern', [SFPT]).IncludeFlag(dfUnmappedFormID, wbStarfieldIsABugInfestedHellhole), 65536).IncludeFlag(dfCollapsed).SetRequired,
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
    wbEmpty(SRAN, 'Unknown'),
    wbEmpty(SGEN, 'Unknown'),
    wbFormIDCk(SPQU, 'Quest', [QUST], False, cpNormal, True),
    wbKeywords,
    wbArray(SPMA, 'Scenes', wbFormIDCk('Scene', [SCEN])),
    wbUnknown(DIFF) //req - 0, 1, 2 - difficulty of check?
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(STBH, 'Snap Template Behavior', [
    wbEDID,
    wbBaseFormComponents,
    wbRStructs('Unknown', 'Unknown', [
      wbInteger(ENAM, 'Unknown', itU32, wbFlags([
        'Unknown 0',
        'Unknown 1'
      ])).SetRequired,
      wbFormIDCk(PNAM, 'Base Object', sigBaseObjects + [FLST], sigBaseObjects).SetRequired,
      wbCITCReq,
      wbCTDAsCount,
      wbFormIDCk(UNAM, 'Snap Template Node', [NULL, STND]).SetRequired,
      wbFormIDCk(VNAM, 'Keyword', [NULL, KYWD]).SetRequired
    ], [])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(STDT, 'Star',
    wbFlags(wbRecordFlagsFlags, wbFlagsList([  {flags not checked against Starfield}
      {0x10000000} 28, 'Unknown 28',
      {0x20000000} 29, 'Unknown 29'
    ])), [
    wbEDID,
    wbBaseFormComponents,
    wbKeywords,
    wbString(ANAM, 'Name'),
    wbVec3Pos(BNAM),
    wbUnknown(ONAM),                                    //related to BGSOrbitalDataComponent_Component
    wbInteger(DNAM, 'ID', itU32),
    wbByteColors(ENAM, 'Color'),
    wbFormIDCk(PNAM, 'Sun Preset', [SUNP])
  ]);

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
    wbUnknown(TMVT),
    wbUnknown(DNAM),
    wbUnknown(SNAM),
    wbLStringKC(INAM, 'Unknown', 0, cpTranslate, True),
    wbRStruct('Body Text', [
      wbInteger(BSIZ, 'Count', itU32),
      wbRStructs('Items', 'Item', [
        wbLStringKC(BTXT, 'Text', 0, cpTranslate, True),
      wbCTDAs,
      wbInteger(TPLT, 'Uses Templated Text', itU8, wbBoolEnum) // note that this is not set on text that uses aliases or script token replacement
      ], [])
    ], []),
    wbRStruct('Menu', [
      wbInteger(ISIZ, 'Options Count', itU32),
      wbRStructs('Menu Items', 'Menu Item', [
        wbLStringKC(ITXT, 'Item Text', 0, cpTranslate, True),
        wbLStringKC(ISTX, 'Item Short Text', 0, cpTranslate, False), // sometimes icon label, sometimes debug text... weird

        wbArray(ISET, 'Unknown',wbInteger('Unknown',itU8),8),
        wbInteger(ITID, 'Item ID', itU16),
        wbXLOC,
        wbFormIDCk(TNAM, 'Submenu', [NULL, TMLM]),
        wbLStringKC(UNAM, 'Display Text', 0, cpTranslate),
      wbCTDAs
    ], [])
      ],[] )
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
    wbUnknown(DNAM)
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(WBAR, 'Weapon Barrel Model', [
    wbEDID,
    wbStruct(ZNAM, 'Data', [
      wbInteger('Allow Cover State', itU8, wbBoolEnum),
      wbFloat('Cover Detection Distance'),
      wbFloat('Enter Cover Animation Time S'),
      wbFloat('Hipfire During Cover Animation Time S')
    ])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(WKMF, 'Wwise Keyword Mapping', [
    wbEDID,
    wbInteger(WMTI, 'Unknown', itU16),
    wbArrayS(WMKA, 'Keywords', wbFormIDCk('Keyword', [KYWD])),
    wbInteger(WMSS, 'Unknown', itU32),
    wbRStructs('Unknown', 'Unknown', [
      wbInteger(WMSI, 'Unknown', itU16),
      wbStruct(WMSD, 'Unknown', [
        wbSoundReference('Unknown'),
        wbArray('Unknown', wbStruct('Unknown', [
          wbWwiseGuid('Unknown'),
          wbWwiseGuid('Unknown')
        ]), -1)
      ])
    ], [])
  ]);

  {subrecords checked against Starfield.esm}
  wbRecord(WWED, 'Wwise Event Data', [
    wbEDID,
    wbWwiseGuid(WSED, 'Start'),
    wbFormIDCk(CNAM, 'Condition', [CNDF]),
    wbWwiseGuid(WTED, 'End')
  ]);

  {subrecords checked against Starfield.esm}
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

  wbAddGroupOrder(GMST); {SF1Dump: no errors}
  wbAddGroupOrder(KYWD); {SF1Dump: no errors}
  wbAddGroupOrder(FFKW); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(LCRT); {SF1Dump: no errors}
  wbAddGroupOrder(AACT); {SF1Dump: no errors}
  wbAddGroupOrder(TRNS); {SF1Dump: no errors}
  wbAddGroupOrder(TXST); {SF1Dump: no errors}
  wbAddGroupOrder(GLOB); {SF1Dump: no errors}
  wbAddGroupOrder(DMGT); {SF1Dump: no errors}
  wbAddGroupOrder(CLAS); {SF1Dump: no errors}
  wbAddGroupOrder(FACT); {SF1Dump: no errors}
  wbAddGroupOrder(AFFE); {SF1Dump: no errors}
  wbAddGroupOrder(HDPT); {SF1Dump: no errors}
  wbAddGroupOrder(RACE); {SF1Dump: no errors}
  wbAddGroupOrder(SOUN); {SF1Dump: no errors}
  wbAddGroupOrder(SECH); {SF1Dump: no errors}
  wbAddGroupOrder(ASPC); {SF1Dump: no errors}
  wbAddGroupOrder(AOPF); {SF1Dump: no errors}
  wbAddGroupOrder(MGEF); {SF1Dump: no errors}
  wbAddGroupOrder(LTEX); {SF1Dump: no errors}
  wbAddGroupOrder(PDCL); {SF1Dump: no errors}
  wbAddGroupOrder(ENCH); {SF1Dump: no errors}
  wbAddGroupOrder(SPEL); {SF1Dump: no errors}
  wbAddGroupOrder(ACTI); {SF1Dump: no errors}
  wbAddGroupOrder(CURV); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(CUR3); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(ARMO); {SF1Dump: no errors}
  wbAddGroupOrder(BOOK); {SF1Dump: no errors}
  wbAddGroupOrder(CONT); {SF1Dump: no errors}
  wbAddGroupOrder(DOOR); {SF1Dump: no errors}
  wbAddGroupOrder(LIGH); {SF1Dump: no errors}
  wbAddGroupOrder(MISC); {SF1Dump: no errors}
  wbAddGroupOrder(STAT); {SF1Dump: no errors}
  wbAddGroupOrder(SCOL); {SF1Dump: no errors}
  wbAddGroupOrder(PKIN); {SF1Dump: no errors}
  wbAddGroupOrder(MSTT); {SF1Dump: no errors}
  wbAddGroupOrder(GRAS); {SF1Dump: no errors}
  wbAddGroupOrder(FLOR); {SF1Dump: no errors}
  wbAddGroupOrder(FURN); {SF1Dump: no errors}
  wbAddGroupOrder(WEAP); {SF1Dump: no errors}
  wbAddGroupOrder(AMMO); {SF1Dump: no errors}
  wbAddGroupOrder(NPC_); {SF1Dump: no errors}
  wbAddGroupOrder(PLYR); {purely internal type}
  wbAddGroupOrder(LVLN); {SF1Dump: no errors}
  wbAddGroupOrder(LVLP); {SF1Dump: no errors}
  wbAddGroupOrder(KEYM); {SF1Dump: no errors}
  wbAddGroupOrder(ALCH); {SF1Dump: no errors}
  wbAddGroupOrder(IDLM); {SF1Dump: no errors}
  wbAddGroupOrder(BMMO); {SF1Dump: no errors}
  wbAddGroupOrder(PROJ); {SF1Dump: no errors}
  wbAddGroupOrder(HAZD); {SF1Dump: no errors}
  wbAddGroupOrder(BNDS); {SF1Dump: no errors}
  wbAddGroupOrder(TERM); {SF1Dump: no errors}
  wbAddGroupOrder(LVLI); {SF1Dump: no errors}
  wbAddGroupOrder(GBFT); {SF1Dump: no errors}
  wbAddGroupOrder(GBFM); {SF1Dump: no errors}
  wbAddGroupOrder(LVLB); {SF1Dump: no errors}
  wbAddGroupOrder(WTHR); {SF1Dump: no errors}
  wbAddGroupOrder(WTHS); {SF1Dump: no errors}
  wbAddGroupOrder(CLMT); {SF1Dump: no errors}
  wbAddGroupOrder(SPGD); {SF1Dump: no errors}
  wbAddGroupOrder(REGN); {SF1Dump: no errors}
  wbAddGroupOrder(NAVI); {SF1Dump: no errors}
  wbAddGroupOrder(CELL); {SF1Dump: no errors}
  wbAddGroupOrder(WRLD); {SF1Dump: no errors}
  wbAddGroupOrder(NAVM); {SF1Dump: no errors}
  wbAddGroupOrder(DIAL); {SF1Dump: no errors}
  wbAddGroupOrder(INFO); {SF1Dump: no errors}
  wbAddGroupOrder(QUST); {SF1Dump: no errors}
  wbAddGroupOrder(IDLE); {SF1Dump: no errors}
  wbAddGroupOrder(PACK); {SF1Dump: no errors}
  wbAddGroupOrder(CSTY); {SF1Dump: no errors}
  wbAddGroupOrder(LSCR); {SF1Dump: no errors}
  wbAddGroupOrder(ANIO); {SF1Dump: no errors}
  wbAddGroupOrder(WATR); {SF1Dump: no errors}
  wbAddGroupOrder(EFSH); {SF1Dump: no errors}
  wbAddGroupOrder(EXPL); {SF1Dump: no errors}
  wbAddGroupOrder(DEBR); {SF1Dump: no errors}
  wbAddGroupOrder(IMGS); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(IMAD); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(FLST); {SF1Dump: no errors}
  wbAddGroupOrder(PERK); {SF1Dump: no errors}
  wbAddGroupOrder(BPTD); {SF1Dump: no errors}
  wbAddGroupOrder(ADDN); {SF1Dump: no errors} {contains Reflection}
  wbAddGroupOrder(AVIF); {SF1Dump: no errors}
  wbAddGroupOrder(CAMS); {SF1Dump: no errors}
  wbAddGroupOrder(CPTH); {SF1Dump: no errors}
  wbAddGroupOrder(VTYP); {SF1Dump: no errors}
  wbAddGroupOrder(MATT); {SF1Dump: no errors}
  wbAddGroupOrder(IPCT); {SF1Dump: no errors}
  wbAddGroupOrder(IPDS); {SF1Dump: no errors}
  wbAddGroupOrder(ARMA); {SF1Dump: no errors}
  wbAddGroupOrder(LCTN); {SF1Dump: no errors}
  wbAddGroupOrder(MESG); {SF1Dump: no errors}
  wbAddGroupOrder(DOBJ); {SF1Dump: only errors are from the incomplete Use enum }
  wbAddGroupOrder(DFOB); {SF1Dump: no errors}
  wbAddGroupOrder(LGTM); {SF1Dump: no errors}
  wbAddGroupOrder(MUSC); {SF1Dump: no errors}
  wbAddGroupOrder(FSTP); {SF1Dump: no errors}
  wbAddGroupOrder(FSTS); {SF1Dump: no errors}
  wbAddGroupOrder(SMBN); {SF1Dump: no errors}
  wbAddGroupOrder(SMQN); {SF1Dump: no errors}
  wbAddGroupOrder(SMEN); {SF1Dump: no errors}
  wbAddGroupOrder(DLBR); {SF1Dump: no errors}
  wbAddGroupOrder(MUST); {SF1Dump: no errors}
  wbAddGroupOrder(EQUP); {SF1Dump: no errors}
  wbAddGroupOrder(SCEN); {SF1Dump: no errors}
  wbAddGroupOrder(OTFT); {SF1Dump: no errors}
  wbAddGroupOrder(ARTO); {SF1Dump: no errors}
  wbAddGroupOrder(MOVT); {SF1Dump: no errors}
  wbAddGroupOrder(COLL); {SF1Dump: no errors}
  wbAddGroupOrder(CLFM); {SF1Dump: no errors}
  wbAddGroupOrder(REVB); {SF1Dump: no errors}
  wbAddGroupOrder(RFGP); {SF1Dump: no errors}
  wbAddGroupOrder(PERS); {SF1Dump: no errors}
  wbAddGroupOrder(AMDL); {SF1Dump: no errors}
  wbAddGroupOrder(AAMD); {SF1Dump: no errors}
  wbAddGroupOrder(MAAM); {SF1Dump: no errors}
  wbAddGroupOrder(LAYR); {SF1Dump: no errors}
  wbAddGroupOrder(COBJ); {SF1Dump: no errors}
  wbAddGroupOrder(OMOD); {SF1Dump: no errors}
  wbAddGroupOrder(ZOOM); {SF1Dump: no errors}
  wbAddGroupOrder(INNR); {SF1Dump: no errors}
  wbAddGroupOrder(KSSM); {SF1Dump: no errors}
  wbAddGroupOrder(AORU); {SF1Dump: no errors}
  wbAddGroupOrder(STAG); {SF1Dump: no errors}
  wbAddGroupOrder(IRES); {SF1Dump: no errors}
  wbAddGroupOrder(BIOM); {SF1Dump: no errors}
  wbAddGroupOrder(NOCM); {SF1Dump: no errors}
  wbAddGroupOrder(LENS); {SF1Dump: no errors}
  wbAddGroupOrder(OVIS); {SF1Dump: no errors}
  wbAddGroupOrder(STND); {SF1Dump: no errors}
  wbAddGroupOrder(STMP); {SF1Dump: no errors}
  wbAddGroupOrder(GCVR); {SF1Dump: no errors}
  wbAddGroupOrder(MRPH); {SF1Dump: no errors}
  wbAddGroupOrder(TRAV); {SF1Dump: no errors}
  wbAddGroupOrder(RSGD); {SF1Dump: no errors}
  wbAddGroupOrder(OSWP); {SF1Dump: no errors}
  wbAddGroupOrder(ATMO); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(LVSC); {SF1Dump: no errors}
  wbAddGroupOrder(SPCH); {SF1Dump: no errors}
  wbAddGroupOrder(AAPD); {SF1Dump: no errors}
  wbAddGroupOrder(VOLI); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(SFBK); {SF1Dump: no errors}
  wbAddGroupOrder(SFPC); {SF1Dump: no errors}
  wbAddGroupOrder(SFPT); {SF1Dump: no errors}
  wbAddGroupOrder(SFTR); {SF1Dump: no errors}
  wbAddGroupOrder(PCMT); {SF1Dump: no errors}
  wbAddGroupOrder(BMOD); {SF1Dump: no errors}
  wbAddGroupOrder(STBH); {SF1Dump: no errors}
  wbAddGroupOrder(PNDT); {SF1Dump: no errors}
  wbAddGroupOrder(CNDF); {SF1Dump: no errors}
  wbAddGroupOrder(PCBN); {SF1Dump: no errors}
  wbAddGroupOrder(PCCN); {SF1Dump: no errors except real ones}
  wbAddGroupOrder(STDT); {SF1Dump: no errors}
  wbAddGroupOrder(WWED); {SF1Dump: no errors}
  wbAddGroupOrder(RSPJ); {SF1Dump: no errors}
  wbAddGroupOrder(AOPS); {SF1Dump: no errors}
  wbAddGroupOrder(AMBS); {SF1Dump: no errors}
  wbAddGroupOrder(WBAR); {SF1Dump: no errors}
  wbAddGroupOrder(PTST); {SF1Dump: no errors}
  wbAddGroupOrder(LMSW); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(FORC); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(TMLM); {SF1Dump: remaining errors are, I think, real}
  wbAddGroupOrder(EFSQ); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(SDLT); {SF1Dump: no errors}
  wbAddGroupOrder(MTPT); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(CLDF); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(FOGV); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(WKMF); {SF1Dump: no errors}
  wbAddGroupOrder(LGDI); {SF1Dump: no errors}
  wbAddGroupOrder(PSDC); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(SUNP); {SF1Dump: no errors} {Reflection only}
  wbAddGroupOrder(PMFT); {SF1Dump: no errors}
  wbAddGroupOrder(TODD); {SF1Dump: no errors} {Reflection and BFCs only}
  wbAddGroupOrder(AVMD); {SF1Dump: no errors}
  wbAddGroupOrder(CHAL); {SF1Dump: no errors}

  wbNexusModsUrl := 'https://www.nexusmods.com/starfield/mods/239';

  SetLength(wbOfficialDLC, 3);
  wbOfficialDLC[0] := 'Constellation.esm';
  wbOfficialDLC[1] := 'OldMars.esm';
  wbOfficialDLC[2] := 'BlueprintShips-Starfield.esm';

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
