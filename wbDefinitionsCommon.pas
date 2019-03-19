unit wbDefinitionsCommon;

{$I wbDefines.inc}

interface

uses
  wbInterface;

  procedure wbConditionToStrFNV(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbConditionToStrFO3(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbConditionToStrTES4(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbConditionToStrTES5(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType); {also used for FO4 and FO76}

  procedure wbEquipSlotToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbFactionRelationToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbFactionToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbItemToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbLeveledListEntryToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbModelToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbObjectBoundsToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbRecordHeaderToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbRGBAToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbObjectPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbScriptPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbVec3ToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  /// <summary>Calls and returns wbGetScriptObjFormat. Used for VMAD parsing.</summary>
  function wbScriptObjFormatDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;

implementation

uses
  Classes,
  Math,
  StrUtils,
  SysUtils;

const
  CTDA: TwbSignature = 'CTDA';

{>>> For Collapsible Fields <<<}

procedure wbTrySetContainer(const aElement: IwbElement; aType: TwbCallbackType; var aContainer: IwbContainerElementRef);
var
  Container: IwbContainerElementRef;
begin
  aContainer := nil;

  if aType <> ctToSummary then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  aContainer := Container;
end;

/// <summary>Generates "{Count}x {FormID}" string for item. Supports single and double structs.</summary>
/// <param name="aContainer">The Item element</param>
/// <returns>string</return>
function wbGetItemStr(const aContainer: IwbContainerElementRef): string;
var
  FormID, Count: IwbElement;
  MainRecord: IwbMainRecord;
begin
  FormID := aContainer.Elements[0];

  if not Assigned(FormID) then
  begin
    Result := '';
    Exit;
  end;

  if not Supports(FormID.LinksTo, IwbMainRecord, MainRecord) then
  begin
    Result := '';
    Exit;
  end;

  Count := aContainer.Elements[1];

  Result := Count.Value + 'x ' + MainRecord.ShortName;
end;

/// <summary>Returns Object Format version of Object Union. Corresponds to index of wbStructSK in Object Union array.</summary>
/// <param name="aElement">The Object Union element</param>
/// <returns>0 = Object v2, 1 = Object v1</returns>
function wbGetScriptObjFormat(const aElement: IwbElement): Integer;
var
  ObjFormat: Integer;
  Container: IwbContainer;
begin
  Result := 0;

  Container := aElement.Container;
  while Assigned(Container) and (Container.ElementType <> etSubRecord) do
    Container := Container.Container;

  if Container = nil then
    Exit;

  ObjFormat := Container.ElementNativeValues['Object Format'];

  if ObjFormat = 1 then
    Result := 1;
end;

/// <summary>Generates comma-delimited list of array values for an array-type property</summary>
/// <param name="aContainer">The Array Value element (e.g., "Value\Array of Object")</param>
/// <returns>string from TStringList.CommaText</returns>
function wbGetPropertyValueArrayItems(const aContainer: IwbContainerElementRef): string;
var
  ObjectUnion: IwbContainerElementRef;
  FormID, Alias: IwbElement;
  MainRecord: IwbMainRecord;
  Items: TStringList;
  ObjectVersion, ItemName: string;
  i: Integer;
begin
  Items := TStringList.Create;

  if CompareStr(aContainer.Name, 'Array of Object') = 0 then
    for i := 0 to Pred(aContainer.ElementCount) do
    begin
      ObjectUnion := aContainer.Elements[i] as IwbContainerElementRef;
      ObjectVersion := IfThen(wbGetScriptObjFormat(ObjectUnion) = 0, 'v2', 'v1');

      FormID := ObjectUnion.ElementByPath['Object ' + ObjectVersion + '\FormID'];
      Alias := ObjectUnion.ElementByPath['Object ' + ObjectVersion + '\Alias'];

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
    for i := 0 to Pred(aContainer.ElementCount) do
      Items.Add(aContainer.Elements[i].Value);

  Result := Items.CommaText;
  Items.Free;
end;

procedure wbBuildConditionStrWithOperators(const Container: IwbContainerElementRef; Typ: Byte; var aValue: string);
begin
  case Typ and $E0 of
    $00: aValue := aValue + ' = ';
    $20: aValue := aValue + ' <> ';
    $40: aValue := aValue + ' > ';
    $60: aValue := aValue + ' >= ';
    $80: aValue := aValue + ' < ';
    $A0: aValue := aValue + ' <= ';
  end;

  aValue := aValue + Container.Elements[2].Value;

  if (Typ and $01) = 0 then
    aValue := aValue + ' AND'
  else
    aValue := aValue + ' OR';
end;

// TODO: merge wbConditionToStr* procedures
procedure wbConditionToStrFNV(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  RunOn, Param1, Param2: IwbElement;
  Typ: Byte;
  i: Integer;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  Typ := Container.Elements[0].NativeValue;

  if (Container.ElementCount >= 9) and (Container.Elements[7].Def.DefType <> dtEmpty) and (Container.Elements[8].Def.DefType <> dtEmpty) then
  begin
    i := Container.Elements[3].NativeValue;
    RunOn := Container.Elements[7];
    if (i <> 106) and (i <> 285) and (RunOn.NativeValue = 2) then
      aValue := Container.Elements[8].Value
    else
      aValue := RunOn.Value;
  end
  else
    if (Typ and $02) = 0 then
      aValue := 'Subject'
    else
      aValue := 'Target';

  aValue := aValue + '.' + Container.Elements[3].Value;

  Param1 := Container.Elements[5];
  if Param1.ConflictPriority <> cpIgnore then
  begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Value;
    Param2 := Container.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Value;
    aValue := aValue + ')';
  end;

  wbBuildConditionStrWithOperators(Container, Typ, aValue);
end;

procedure wbConditionToStrFO3(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  RunOn, Param1, Param2: IwbElement;
  Typ: Byte;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  Typ := Container.Elements[0].NativeValue;

  if (Container.ElementCount >= 9) and (Container.Elements[7].Def.DefType <> dtEmpty) and (Container.Elements[8].Def.DefType <> dtEmpty) then
  begin
    RunOn := Container.Elements[7];
    if RunOn.NativeValue = 2 then
      aValue := Container.Elements[8].Value
    else
      aValue := RunOn.Value;
  end
  else
    if (Typ and $02) = 0 then
      aValue := 'Subject'
    else
      aValue := 'Target';

  aValue := aValue + '.' + Container.Elements[3].Value;

  Param1 := Container.Elements[5];
  if Param1.ConflictPriority <> cpIgnore then
  begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Value;
    Param2 := Container.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Value;
    aValue := aValue + ')';
  end;

  wbBuildConditionStrWithOperators(Container, Typ, aValue);
end;

procedure wbConditionToStrTES4(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  Param1, Param2: IwbElement;
  Typ: Byte;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  Typ := Container.Elements[0].NativeValue;
  if (Typ and $02) = 0 then
    aValue := 'Subject'
  else
    aValue := 'Target';

  aValue := aValue + '.' + Container.Elements[3].Value;

  Param1 := Container.Elements[5];
  if Param1.ConflictPriority <> cpIgnore then
  begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Value;
    Param2 := Container.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Value;
    aValue := aValue + ')';
  end;

  wbBuildConditionStrWithOperators(Container, Typ, aValue);
end;

procedure wbConditionToStrTES5(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  lCTDA: IwbContainerElementRef;
  RunOn, Param1, Param2: IwbElement;
  Typ: Byte;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  if not Supports(Container.RecordBySignature[CTDA], IwbContainerElementRef, lCTDA) then
    Exit;

  RunOn := lCTDA.Elements[7];
  if RunOn.NativeValue = 2 then
    aValue := lCTDA.Elements[8].Value
  else
    aValue := RunOn.Value;

  aValue := aValue + '.' + lCTDA.Elements[3].Value;

  Param1 := lCTDA.Elements[5];
  if Param1.ConflictPriority <> cpIgnore then
  begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Value;
    Param2 := lCTDA.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Value;
    aValue := aValue + ')';
  end;

  Typ := lCTDA.Elements[0].NativeValue;

  wbBuildConditionStrWithOperators(lCTDA, Typ, aValue);
end;

procedure wbEquipSlotToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  EquipSlot, EquipNode: IwbElement;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  EquipSlot := Container.ElementBySignature['QNAM'];
  EquipNode := Container.ElementBySignature['ZNAM'];

  if not Assigned(EquipNode) then
    aValue := EquipSlot.Value
  else
    aValue := EquipNode.Value + ' = ' + EquipSlot.Value;
end;

procedure wbFactionToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  Faction, Rank: IwbElement;
  MainRecord: IwbMainRecord;
  NativeRank: integer;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  Faction := Container.Elements[0];
  if not Assigned(Faction.LinksTo) then
    Exit;

  aValue := Faction.Value;

  if Assigned(Rank) then
  begin
    NativeRank := Rank.NativeValue;
    aValue := aValue + ' {Rank: ' + IntToStr(NativeRank) + '}';
  end;
end;

procedure wbFactionRelationToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  Faction, Rank: IwbElement;
  MainRecord: IwbMainRecord;
  NativeRank: integer;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  Faction := Container.Elements[0];
  if not Assigned(Faction.LinksTo) then
    Exit;

  Rank := Container.Elements[1];

  aValue := Faction.Value;

  if wbGameMode = gmTES4 then
  begin
    NativeRank := Rank.NativeValue;
    if NativeRank >= 0 then
      aValue := '+' + IntToStr(NativeRank) + ' ' + aValue
    else
      aValue := IntToStr(NativeRank) + ' ' + aValue;
    Exit;
  end;

  aValue := Container.Elements[2].Value + ' ' + aValue;
end;

procedure wbModelToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  aValue := Container.Elements[0].Value;
end;

procedure wbObjectBoundsToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  FacetPointA, FacetPointB: string;
  X1, X2, Y1, Y2, Z1, Z2: IwbElement;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  X1 := Container.Elements[0];
  Y1 := Container.Elements[1];
  Z1 := Container.Elements[2];

  X2 := Container.Elements[3];
  Y2 := Container.Elements[4];
  Z2 := Container.Elements[5];

  FacetPointA := X1.Value + ', ' + Y1.Value + ', ' + Z1.Value;
  FacetPointB := X2.Value + ', ' + Y2.Value + ', ' + Z2.Value;

  aValue := '(' + FacetPointA + '), (' + FacetPointB + ')';
end;

procedure wbObjectPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container, CurveTable: IwbContainerElementRef;
  ActorValueForm, ActorValueData, CurveTableForm: IwbElement;
  MainRecord: IwbMainRecord;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  ActorValueForm := Container.ElementByName['Actor Value'];
  if not Assigned(ActorValueForm) then
    Exit;

  if not Supports(ActorValueForm.LinksTo, IwbMainRecord, MainRecord) then
    Exit;

  ActorValueData := Container.ElementByName['Value'];

  aValue := MainRecord.EditorID + ' = ' + Format('%.*g', [5, StrToFloat(ActorValueData.Value)]);

  if wbGameMode <> gmFO76 then
    Exit;

  CurveTable := Container.ElementByName['Curve Table'] as IwbContainerElementRef;
  if not Assigned(CurveTable) then
    Exit;

  CurveTableForm := CurveTable.ElementByName['Curve Table'];
  if not Assigned(CurveTableForm) then
    Exit;

  if not Supports(CurveTableForm, IwbMainRecord, MainRecord) then
    Exit;

  aValue := aValue + ' {Curve Table: ' + MainRecord.ShortName + '}';
end;

procedure wbItemToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  ItemString: string;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
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
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
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
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  MainRecord := Container.ContainingMainRecord;
  RecordFlags := Container.ElementByName['Record Flags'];
  FormVersion := Container.ElementByName['Form Version'];

  RecordFlagsValue := RecordFlags.Value;

  DisplayValue := '[' + MainRecord.Signature + ':' + MainRecord.LoadOrderFormID.ToString(True) + ']';

  if wbGameMode = gmTES4 then
    aValue := DisplayValue
  else
    aValue := '[v' + FormVersion.Value + '] ' + DisplayValue;

  if Length(RecordFlagsValue) > 0 then
    aValue := aValue + ' {' + RecordFlagsValue + '}';
end;

/// <summary>Fills PropertyType and PropertyValue from array assigned to property</summary>
procedure wbScriptPropertyArrayToStr(const aContainer: IwbContainerElementRef; var PropertyType: string; var PropertyValue: string);
var
  ArrayContainer: IwbContainerElementRef;
begin
  ArrayContainer := aContainer.ElementByPath['Value\' + PropertyType] as IwbContainerElementRef;

  if not (ArrayContainer.ElementCount > 0) then
    Exit;

  PropertyValue := wbGetPropertyValueArrayItems(ArrayContainer);
  PropertyType := PropertyType.Substring(9) + '[]';
end;

/// <summary>Fills PropertyName, PropertyType, and PropertyName from object assigned to property</summary>
procedure wbScriptPropertyObjectToStr(const aContainer: IwbContainerElementRef; var PropertyName: string; var PropertyType: string; var PropertyValue: string);
var
  ObjectUnion: IwbContainerElementRef;
  FormID, Alias: IwbElement;
  MainRecord: IwbMainRecord;
  AliasValue, Version: string;
begin
  ObjectUnion := aContainer.ElementByPath['Value\Object Union'] as IwbContainerElementRef;

  Version := IfThen(wbGetScriptObjFormat(ObjectUnion) = 0, 'v2', 'v1');

  FormID := ObjectUnion.ElementByPath['Object ' + Version + '\FormID'];
  Alias := ObjectUnion.ElementByPath['Object ' + Version + '\Alias'];

  AliasValue := Alias.Value;

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
  PropertyTypeElement: IwbElement;
  PropertyName, PropertyType, PropertyValue: string;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  PropertyTypeElement := Container.ElementByName['Type'];

  // 0 = None
  if PropertyTypeElement.NativeValue = 0 then
    Exit;

  PropertyName := Container.ElementByName['propertyName'].Value;

  if Length(PropertyName) = 0 then
    Exit;

  PropertyType := PropertyTypeElement.Value;

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
  if Length(PropertyValue) > 0 then
    aValue := PropertyType + ' ' + PropertyName + ' = ' + PropertyValue
  else
    aValue := PropertyType + ' ' + PropertyName;
end;

procedure wbRGBAToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  A: IwbElement;
  R, G, B, RGB: string;
  AlphaDefType: TwbDefType;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  R := Container.Elements[0].Value;
  G := Container.Elements[1].Value;
  B := Container.Elements[2].Value;
  A := Container.Elements[3];

  RGB := 'RGB(' + R + ', ' + G + ', ' + B + ')';

  // handle RGB only
  if not Assigned(A) then
  begin
    aValue := RGB;
    Exit;
  end;

  // handle RGBA
  AlphaDefType := A.Def.DefType;

  if not (AlphaDefType = dtByteArray) then
    aValue := 'RGBA(' + R + ', ' + G + ', ' + B + ', ' + A.Value + ')'
  else
    aValue := RGB;
end;

procedure wbVec3ToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  X, Y, Z: string;
begin
  wbTrySetContainer(aElement, aType, Container);
  if Container = nil then
    Exit;

  X := Container.Elements[0].Value;
  Y := Container.Elements[1].Value;
  Z := Container.Elements[2].Value;

  aValue := 'Vec3(' + X + ', ' + Y + ', ' + Z + ')';
end;

{>>> For VMAD <<<}

function wbScriptObjFormatDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := wbGetScriptObjFormat(aElement);
end;

end.

