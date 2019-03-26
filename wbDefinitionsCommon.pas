unit wbDefinitionsCommon;

{$I wbDefines.inc}

interface

uses
  wbInterface;

const
  SCDA : TwbSignature = 'SCDA';
  SCTX : TwbSignature = 'SCTX';

procedure wbConditionToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbFactionRelationToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbFactionToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbItemToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbLeveledListEntryToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbObjectBoundsToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbRecordHeaderToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbRGBAToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbObjectPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbScriptPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

procedure wbVec3ToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

{>>> Common Definitions <<<}

function wbActionFlag: IwbSubRecordDef;

function wbAlternateTexture: IwbStructDef;

function wbAxisEnum: IwbEnumDef;

function wbDebrisModel(aTextureFileHashes: IwbRecordMemberDef): IwbRecordMemberDef;

{>>> Common Functions <<<}

function Sig2Int(aSignature: TwbSignature): Cardinal; inline;

function wbNeverShow(const aElement: IwbElement): Boolean;

/// <summary>Calls and returns wbGetScriptObjFormat. Used for VMAD parsing.</summary>
function wbScriptObjFormatDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;

function wbTryGetContainerFromUnion(const aElement: IwbElement; out aContainer: IwbContainer): Boolean;

procedure wbScriptToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

implementation

uses
  Classes,
  Math,
  StrUtils,
  SysUtils;

const
  CTDA: TwbSignature = 'CTDA';
  DATA: TwbSignature = 'DATA';
  MODT: TwbSignature = 'MODT';
  TXST: TwbSignature = 'TXST';
  XACT: TwbSignature = 'XACT';


function Sig2Int(aSignature: TwbSignature): Cardinal; inline;
begin
  Result := PCardinal(@aSignature)^;
end;

function wbNeverShow(const aElement: IwbElement): Boolean;
begin
  Result := wbHideNeverShow;
end;

{>>> Common Definitions <<<}
function wbActionFlag: IwbSubRecordDef;
begin
  Result :=
    wbInteger(XACT, 'Action Flag', itU32, wbFlags([
      'Use Default',
      'Activate',
      'Open',
      'Open by Default'
    ]));
end;

function wbAlternateTexture: IwbStructDef;
begin
  Result :=
    wbStructSK([0, 2], 'Alternate Texture', [
      wbLenString('3D Name'),
      wbFormIDCk('New Texture', [TXST]),
      wbInteger('3D Index', itS32)
    ]);
end;

function wbAxisEnum: IwbEnumDef;
begin
  Result :=
    wbEnum([], [
      88, 'X',
      89, 'Y',
      90, 'Z'
    ]);
end;

function wbDebrisModel(aTextureFileHashes: IwbRecordMemberDef): IwbRecordMemberDef;
begin
  Result := wbRStruct('Model', [
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

{>>> For Collapsible Fields <<<}

function wbTrySetContainer(const aElement: IwbElement; aType: TwbCallbackType; out aContainer: IwbContainerElementRef): Boolean;
begin
  Result := (aType = ctToSummary) and Supports(aElement, IwbContainerElementRef, aContainer);
end;

function wbTryGetContainerFromUnion(const aElement: IwbElement; out aContainer: IwbContainer): Boolean;
begin
  if not Assigned(aElement) then
  begin
    Result := False;
    Exit;
  end;

  aContainer := GetContainerFromUnion(aElement);

  if not Assigned(aContainer) then
  begin
    Result := False;
    Exit;
  end;

  Result := True;
end;

/// <summary>Generates "{Count}x {FormID}" string for item. Supports single and double structs.</summary>
/// <param name="aContainer">The Item element</param>
/// <returns>string</return>
function wbGetItemStr(const aContainer: IwbContainerElementRef): string;
var
  MainRecord: IwbMainRecord;
begin
  Result := '';

  var FormID := aContainer.Elements[0];

  if not Assigned(FormID) then
    Exit;

  if not Supports(FormID.LinksTo, IwbMainRecord, MainRecord) then
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
    for var i := 0 to Pred(aContainer.ElementCount) do
    begin
      var ObjectUnion := aContainer.Elements[i] as IwbContainerElementRef;
      var ObjectVersion := IfThen(wbGetScriptObjFormat(ObjectUnion) = 0, 'v2', 'v1');

      var FormID := ObjectUnion.ElementByPath['Object ' + ObjectVersion + '\FormID'];
      var Alias := ObjectUnion.ElementByPath['Object ' + ObjectVersion + '\Alias'];

      if Supports(FormID.LinksTo, IwbMainRecord, MainRecord) then
        if MainRecord <> nil then
          ItemName := MainRecord.ShortName
        else
          ItemName := 'NULL';

      if not (CompareStr(Alias.Value, 'None') = 0) and not (Length(Alias.Value) = 0) then
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

procedure wbConditionToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  cerCTDA: IwbContainerElementRef;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  if wbGameMode > gmFNV then
  begin
    if not Supports(Container.RecordBySignature[CTDA], IwbContainerElementRef, cerCTDA) then
      Exit;
  end
  else
    cerCTDA := Container;

  var Typ : Byte := cerCTDA.Elements[0].NativeValue;
  var Func := cerCTDA.Elements[3];

  if (cerCTDA.ElementCount >= 9) and (cerCTDA.Elements[7].Def.DefType <> dtEmpty) and (cerCTDA.Elements[8].Def.DefType <> dtEmpty) then
  begin
    var RunOn := cerCTDA.Elements[7];
    var RunOnInt: Integer := RunOn.NativeValue;
    if wbGameMode = gmFNV then
    begin
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
  if Param1.ConflictPriority <> cpIgnore then
  begin
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

procedure wbFactionToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  MainRecord: IwbMainRecord;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var Faction := Container.Elements[0];
  if not Assigned(Faction.LinksTo) then
    Exit;

  var Rank := Container.Elements[1];

  aValue := Faction.Value;

  if Assigned(Rank) then
    aValue := aValue + ' {Rank: ' + IntToStr(Rank.NativeValue) + '}';
end;

procedure wbFactionRelationToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  MainRecord: IwbMainRecord;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var Faction := Container.Elements[0];
  if not Assigned(Faction.LinksTo) then
    Exit;

  var Rank := Container.Elements[1];

  aValue := Faction.Value;

  if wbGameMode = gmTES4 then
  begin
    var NativeRank := Rank.NativeValue;

    aValue := IntToStr(NativeRank) + ' ' + aValue;

    if NativeRank >= 0 then
      aValue := '+' + aValue;

    Exit;
  end;

  aValue := Container.Elements[2].Value + ' ' + aValue;
end;

procedure wbObjectBoundsToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var X1 := Container.Elements[0];
  var Y1 := Container.Elements[1];
  var Z1 := Container.Elements[2];

  var X2 := Container.Elements[3];
  var Y2 := Container.Elements[4];
  var Z2 := Container.Elements[5];

  var FacetPointA := X1.Value + ', ' + Y1.Value + ', ' + Z1.Value;
  var FacetPointB := X2.Value + ', ' + Y2.Value + ', ' + Z2.Value;

  aValue := '(' + FacetPointA + '), (' + FacetPointB + ')';
end;

procedure wbObjectPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  MainRecord: IwbMainRecord;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var ActorValueForm := Container.ElementByName['Actor Value'];

  if not Assigned(ActorValueForm) then
    Exit;

  if not Supports(ActorValueForm.LinksTo, IwbMainRecord, MainRecord) then
    Exit;

  var ActorValueData := Container.ElementByName['Value'];

  aValue := MainRecord.EditorID + ' = ' + Format('%.*g', [5, StrToFloat(ActorValueData.Value)]);

  if wbGameMode <> gmFO76 then
    Exit;

  var CurveTable := Container.ElementByName['Curve Table'] as IwbContainerElementRef;

  if not Assigned(CurveTable) then
    Exit;

  var CurveTableForm := CurveTable.ElementByName['Curve Table'];

  if not Assigned(CurveTableForm) then
    Exit;

  if not Supports(CurveTableForm.LinksTo, IwbMainRecord, MainRecord) then
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

procedure wbLeveledListEntryToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container, LeveledObject: IwbContainerElementRef; // Leveled List Entry
  Level, Ref, Count, ChanceNone: IwbElement;
  MainRecord: IwbMainRecord;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  LeveledObject := Container.ElementBySignature['LVLO'] as IwbContainerElementRef;
  if Assigned(LeveledObject) then
    Container := LeveledObject;

  Ref := Container.ElementByName['Reference'];

  if not Assigned(Ref) then
    Exit;

  if not Supports(Ref.LinksTo, IwbMainRecord, MainRecord) then
    Exit;

  Level := Container.ElementByName['Level'];
  Count := Container.ElementByName['Count'];

  // Fallout Only
  ChanceNone := Container.ElementByName['Chance None'];

  aValue := '[Lv' + Level.Value + '] ' + Count.Value + 'x ' + MainRecord.ShortName;

  if Assigned(ChanceNone) and (ChanceNone.NativeValue > 0) then
    aValue := aValue + ' {Chance None: ' + IntToStr(ChanceNone.NativeValue) + '%}';
end;

procedure wbRecordHeaderToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  RecordFlags, FormVersion: IwbElement;
  MainRecord: IwbMainRecord;
  RecordFlagsValue, DisplayValue: string;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  MainRecord := Container.ContainingMainRecord;
  RecordFlags := Container.ElementByName['Record Flags'];
  FormVersion := Container.ElementByName['Form Version'];

  RecordFlagsValue := RecordFlags.Value;

  DisplayValue := '[' + MainRecord.Signature + ':' + MainRecord.LoadOrderFormID.ToString(True) + ']';

  aValue := DisplayValue;

  if wbGameMode <> gmTES4 then
    aValue := '[v' + FormVersion.Value + '] ' + aValue;

  if Length(RecordFlagsValue) > 0 then
    aValue := aValue + ' {' + RecordFlagsValue + '}';
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
  var ObjectUnion := aContainer.ElementByPath['Value\Object Union'] as IwbContainerElementRef;

  var Version := IfThen(wbGetScriptObjFormat(ObjectUnion) = 0, 'v2', 'v1');

  var FormID := ObjectUnion.ElementByPath['Object ' + Version + '\FormID'];
  var Alias := ObjectUnion.ElementByPath['Object ' + Version + '\Alias'];

  var AliasValue := Alias.Value;

  // compare length, too, because v1 doesn't default to 'None'
  if not (CompareStr(AliasValue, 'None') = 0) and not (Length(AliasValue) = 0) then
  begin
    PropertyType := 'Alias';
    PropertyName := Alias.EditValue;
  end;

  if Supports(FormID.LinksTo, IwbMainRecord, MainRecord) then
    if MainRecord <> nil then
      PropertyValue := MainRecord.ShortName
    else
      PropertyValue := 'NULL';
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
  if PropertyTypeElement.NativeValue = 17 then
  begin
    PropertyValue := '';
    PropertyType := PropertyType.Substring(9) + '[]';
  end;

  // set display string
  aValue := PropertyType + ' ' + PropertyName;

  if Length(PropertyValue) > 0 then
    aValue := aValue + ' = ' + PropertyValue;
end;

procedure wbRGBAToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  A: IwbElement;
  R, G, B: string;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  if Container.ElementCount >= 3 then
  begin
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

procedure wbVec3ToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
begin
  if not wbTrySetContainer(aElement, aType, Container) then
    Exit;

  var X := Container.Elements[0].Summary;
  var Y := Container.Elements[1].Summary;
  var Z := Container.Elements[2].Summary;

  aValue := 'Vec3(' + X + ', ' + Y + ', ' + Z + ')';
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

  if not Assigned(eSCDA) then
  begin
    aValue := IfThen(Assigned(eSCTX), '<Source not compiled>', '<Empty>');
    Exit;
  end;

  if not Assigned(eSCTX) then
  begin
    aValue := '<Source missing>';
    Exit;
  end;

  with TStringList.Create do
  try
    Text := eSCTX.Value;

    for var i := Pred(Count) downto 0 do
    begin
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

end.

