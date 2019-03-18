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

  procedure wbObjectPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

  procedure wbScriptPropertyToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

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

  if not Assigned(Container) then
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
  i: Integer;
  ObjectVersion, ItemName: string;
  ObjectUnion: IwbContainerElementRef;
  FormID, Alias: IwbElement;
  MainRecord: IwbMainRecord;
  Items: TStringList;
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

// TODO: merge wbConditionToStr* procedures
procedure wbConditionToStrFNV(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Condition: IwbContainerElementRef;
  RunOn, Param1, Param2: IwbElement;
  Typ: Byte;
  i: Integer;
begin
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Condition) then
    Exit;

  if Condition.Collapsed <> tbTrue then
    Exit;

  Typ := Condition.Elements[0].NativeValue;

  if (Condition.ElementCount >= 9) and (Condition.Elements[7].Def.DefType <> dtEmpty) and (Condition.Elements[8].Def.DefType <> dtEmpty) then
  begin
    i := Condition.Elements[3].NativeValue;
    RunOn := Condition.Elements[7];
    if (i <> 106) and (i <> 285) and (RunOn.NativeValue = 2) then
      aValue := Condition.Elements[8].Value
    else
      aValue := RunOn.Value;
  end
  else
    if (Typ and $02) = 0 then
      aValue := 'Subject'
    else
      aValue := 'Target';

  aValue := aValue + '.' + Condition.Elements[3].Value;

  Param1 := Condition.Elements[5];
  if Param1.ConflictPriority <> cpIgnore then
  begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Value;
    Param2 := Condition.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Value;
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

  aValue := aValue + Condition.Elements[2].Value;

  if (Typ and $01) = 0 then
    aValue := aValue + ' AND'
  else
    aValue := aValue + ' OR';
end;

procedure wbConditionToStrFO3(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Condition: IwbContainerElementRef;
  RunOn, Param1, Param2: IwbElement;
  Typ: Byte;
begin
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Condition) then
    Exit;

  if Condition.Collapsed <> tbTrue then
    Exit;

  Typ := Condition.Elements[0].NativeValue;

  if (Condition.ElementCount >= 9) and (Condition.Elements[7].Def.DefType <> dtEmpty) and (Condition.Elements[8].Def.DefType <> dtEmpty) then
  begin
    RunOn := Condition.Elements[7];
    if RunOn.NativeValue = 2 then
      aValue := Condition.Elements[8].Value
    else
      aValue := RunOn.Value;
  end
  else
    if (Typ and $02) = 0 then
      aValue := 'Subject'
    else
      aValue := 'Target';

  aValue := aValue + '.' + Condition.Elements[3].Value;

  Param1 := Condition.Elements[5];
  if Param1.ConflictPriority <> cpIgnore then
  begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Value;
    Param2 := Condition.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Value;
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

  aValue := aValue + Condition.Elements[2].Value;

  if (Typ and $01) = 0 then
    aValue := aValue + ' AND'
  else
    aValue := aValue + ' OR';
end;

procedure wbConditionToStrTES4(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Condition: IwbContainerElementRef;
  Param1, Param2: IwbElement;
  Typ: Byte;
begin
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Condition) then
    Exit;

  if Condition.Collapsed <> tbTrue then
    Exit;

  Typ := Condition.Elements[0].NativeValue;
  if (Typ and $02) = 0 then
    aValue := 'Subject'
  else
    aValue := 'Target';

  aValue := aValue + '.' + Condition.Elements[3].Value;

  Param1 := Condition.Elements[5];
  if Param1.ConflictPriority <> cpIgnore then
  begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Value;
    Param2 := Condition.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Value;
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

  aValue := aValue + Condition.Elements[2].Value;

  if (Typ and $01) = 0 then
    aValue := aValue + ' AND'
  else
    aValue := aValue + ' OR';
end;

procedure wbConditionToStrTES5(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Condition: IwbContainerElementRef;
  lCTDA: IwbContainerElementRef;
  RunOn, Param1, Param2: IwbElement;
  Typ: Byte;
begin
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Condition) then
    Exit;

  if Condition.Collapsed <> tbTrue then
    Exit;

  if not Supports(Condition.RecordBySignature[CTDA], IwbContainerElementRef, lCTDA) then
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

  case Typ and $E0 of
    $00: aValue := aValue + ' = ';
    $20: aValue := aValue + ' <> ';
    $40: aValue := aValue + ' > ';
    $60: aValue := aValue + ' >= ';
    $80: aValue := aValue + ' < ';
    $A0: aValue := aValue + ' <= ';
  end;

  aValue := aValue + lCTDA.Elements[2].Value;

  if (Typ and $01) = 0 then
    aValue := aValue + ' AND'
  else
    aValue := aValue + ' OR';
end;

procedure wbEquipSlotToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  EquipSlot, EquipNode: IwbElement;
begin
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if Container.Collapsed <> tbTrue then
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
  FormID, Rank: IwbElement;
  MainRecord: IwbMainRecord;
  NativeRank: integer;
begin
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if Container.Collapsed <> tbTrue then
    Exit;

  FormID := Container.Elements[0];
  if not Assigned(FormID) then
    Exit;

  if not Supports(FormID.LinksTo, IwbMainRecord, MainRecord) then
    Exit;

  Rank := Container.Elements[1];
  NativeRank := Rank.NativeValue;

  aValue := MainRecord.ShortName + ' {Rank: ' + IntToStr(NativeRank) + '}';
end;

procedure wbFactionRelationToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Container: IwbContainerElementRef;
  FormID, Rank, CombatReaction: IwbElement;
  MainRecord: IwbMainRecord;
  RankMod: string;
  NativeRank: integer;
begin
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if Container.Collapsed <> tbTrue then
    Exit;

  FormID := Container.Elements[0];
  if not Assigned(FormID) then
    Exit;

  if not Supports(FormID.LinksTo, IwbMainRecord, MainRecord) then
    Exit;

  Rank := Container.Elements[1];
  NativeRank := Rank.NativeValue;

  if wbGameMode = gmTES4 then begin
    if NativeRank >= 0 then
      aValue := '+' + IntToStr(NativeRank) + ' ' + MainRecord.ShortName
    else
      aValue := IntToStr(NativeRank) + ' ' + MainRecord.ShortName;
    Exit;
  end;

  CombatReaction := Container.Elements[2];
  aValue := CombatReaction.Value + ' ' + MainRecord.ShortName;
end;

procedure wbModelToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Model: IwbContainerElementRef;
begin
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Model) then
    Exit;

  if Model.Collapsed <> tbTrue then
    Exit;

  aValue := Model.Elements[0].Value;
end;

procedure wbObjectBoundsToStr(var aValue: string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  OBND: IwbContainerElementRef;
  FacetPointA, FacetPointB: string;
  X1, X2, Y1, Y2, Z1, Z2: IwbElement;
begin
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, OBND) then
    Exit;

  if OBND.Collapsed <> tbTrue then
    Exit;

  X1 := OBND.Elements[0];
  Y1 := OBND.Elements[1];
  Z1 := OBND.Elements[2];

  X2 := OBND.Elements[3];
  Y2 := OBND.Elements[4];
  Z2 := OBND.Elements[5];

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
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if Container.Collapsed <> tbTrue then
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
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if Container.Collapsed <> tbTrue then
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
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if Container.Collapsed <> tbTrue then
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
  RecordHeader: IwbContainerElementRef;
  RecordFlags, FormVersion: IwbElement;
  MainRecord: IwbMainRecord;
begin
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, RecordHeader) then
    Exit;

  if RecordHeader.Collapsed <> tbTrue then
    Exit;

  MainRecord := RecordHeader.ContainingMainRecord;

  FormVersion := RecordHeader.ElementByName['Form Version'];
  if Assigned(FormVersion) then
    aValue := '[v' + FormVersion.Value + '] '
  else
    aValue := '';

  aValue := aValue + '[' + MainRecord.Signature + ':' + MainRecord.LoadOrderFormID.ToString(True) + ']';

  RecordFlags := RecordHeader.ElementByName['Record Flags'];
  if Assigned(RecordFlags) then begin
    var RecordFlagsValue: string := RecordFlags.Value;
    if Length(RecordFlagsValue) > 0 then
      aValue := aValue + ' {' + RecordFlagsValue + '}';
  end;
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
  Version: string;
  FormID, Alias: IwbElement;
  MainRecord: IwbMainRecord;
begin
  ObjectUnion := aContainer.ElementByPath['Value\Object Union'] as IwbContainerElementRef;

  Version := IfThen(wbGetScriptObjFormat(ObjectUnion) = 0, 'v2', 'v1');

  FormID := ObjectUnion.ElementByPath['Object ' + Version + '\FormID'];
  Alias := ObjectUnion.ElementByPath['Object ' + Version + '\Alias'];

  // compare length, too, because v1 doesn't default to 'None'
  if not (CompareStr(Alias.Value, 'None') = 0) and not (Length(Alias.Value) = 0) then
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
  if aType <> ctToStr then
    Exit;

  if not Supports(aElement, IwbContainerElementRef, Container) then
    Exit;

  if Container.Collapsed <> tbTrue then
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

{>>> For VMAD <<<}

function wbScriptObjFormatDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := wbGetScriptObjFormat(aElement);
end;

end.

