unit wbDefinitionsCommon;

{$I wbDefines.inc}

interface

uses
  wbInterface;

procedure wbConditionToStrFNV(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
procedure wbConditionToStrFO3(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
procedure wbConditionToStrFO76(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
procedure wbConditionToStrTES4(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
procedure wbConditionToStrTES5(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType); {also used for FO4}
procedure wbFactionRelationToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
procedure wbModelToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
procedure wbObjectBoundsToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
procedure wbRecipeComponentToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
procedure wbRecipeItemToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
procedure wbRecordHeaderToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);

implementation

uses
  SysUtils;

const
  CTDA : TwbSignature = 'CTDA';

procedure wbConditionToStrFNV(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Condition: IwbContainerElementRef;
  RunOn, Param1, Param2: IwbElement;
  Typ: Byte;
  i: Integer;
begin
  if not Supports(aElement, IwbContainerElementRef, Condition) then
    Exit;
  if Condition.Collapsed <> tbTrue then
    Exit;

  Typ := Condition.Elements[0].NativeValue;

  if (Condition.ElementCount >= 9) and (Condition.Elements[7].Def.DefType <> dtEmpty) and (Condition.Elements[8].Def.DefType <> dtEmpty) then begin
    i := Condition.Elements[3].NativeValue;
    RunOn := Condition.Elements[7];
    if (i <> 106) and (i <> 285) and (RunOn.NativeValue = 2) then
      aValue := Condition.Elements[8].Value
    else
      aValue := RunOn.Value;
  end else
    if (Typ and $02) = 0 then
      aValue := 'Subject'
    else
      aValue := 'Target';

  aValue := aValue + '.' + Condition.Elements[3].Value;

  Param1 := Condition.Elements[5];
  if Param1.ConflictPriority <> cpIgnore then begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Value;
    Param2 := Condition.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then begin
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Value;
    end;
    aValue := aValue + ')';
  end;

  case Typ and $E0 of
    $00 : aValue := aValue + ' = ';
    $20 : aValue := aValue + ' <> ';
    $40 : aValue := aValue + ' > ';
    $60 : aValue := aValue + ' >= ';
    $80 : aValue := aValue + ' < ';
    $A0 : aValue := aValue + ' <= ';
  end;

  aValue := aValue + Condition.Elements[2].Value;

  if (Typ and $01) = 0 then
    aValue := aValue + ' AND'
  else
    aValue := aValue + ' OR';
end;

procedure wbConditionToStrFO3(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Condition: IwbContainerElementRef;
  RunOn, Param1, Param2: IwbElement;
  Typ: Byte;
begin
  if not Supports(aElement, IwbContainerElementRef, Condition) then
    Exit;
  if Condition.Collapsed <> tbTrue then
    Exit;

  Typ := Condition.Elements[0].NativeValue;

  if (Condition.ElementCount >= 9) and (Condition.Elements[7].Def.DefType <> dtEmpty) and (Condition.Elements[8].Def.DefType <> dtEmpty) then begin
    RunOn := Condition.Elements[7];
    if RunOn.NativeValue = 2 then
      aValue := Condition.Elements[8].Value
    else
      aValue := RunOn.Value;
  end else
    if (Typ and $02) = 0 then
      aValue := 'Subject'
    else
      aValue := 'Target';

  aValue := aValue + '.' + Condition.Elements[3].Value;

  Param1 := Condition.Elements[5];
  if Param1.ConflictPriority <> cpIgnore then begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Value;
    Param2 := Condition.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then begin
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Value;
    end;
    aValue := aValue + ')';
  end;

  case Typ and $E0 of
    $00 : aValue := aValue + ' = ';
    $20 : aValue := aValue + ' <> ';
    $40 : aValue := aValue + ' > ';
    $60 : aValue := aValue + ' >= ';
    $80 : aValue := aValue + ' < ';
    $A0 : aValue := aValue + ' <= ';
  end;

  aValue := aValue + Condition.Elements[2].Value;

  if (Typ and $01) = 0 then
    aValue := aValue + ' AND'
  else
    aValue := aValue + ' OR';
end;

procedure wbConditionToStrFO76(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Condition: IwbContainerElementRef;
  lCTDA: IwbContainerElementRef;
  RunOn, Param1, Param2: IwbElement;
  Typ: Byte;
begin
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
  if Param1.ConflictPriority <> cpIgnore then begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Value;
    Param2 := lCTDA.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then begin
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Value;
    end;
    aValue := aValue + ')';
  end;

  Typ := lCTDA.Elements[0].NativeValue;

  case Typ and $E0 of
    $00 : aValue := aValue + ' = ';
    $20 : aValue := aValue + ' <> ';
    $40 : aValue := aValue + ' > ';
    $60 : aValue := aValue + ' >= ';
    $80 : aValue := aValue + ' < ';
    $A0 : aValue := aValue + ' <= ';
  end;

  aValue := aValue + lCTDA.Elements[2].Value;

  if (Typ and $01) = 0 then
    aValue := aValue + ' AND'
  else
    aValue := aValue + ' OR';
end;

procedure wbConditionToStrTES4(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Condition: IwbContainerElementRef;
  RunOn, Param1, Param2: IwbElement;
  Typ: Byte;
begin
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
  if Param1.ConflictPriority <> cpIgnore then begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Value;
    Param2 := Condition.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then begin
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Value;
    end;
    aValue := aValue + ')';
  end;

  case Typ and $E0 of
    $00 : aValue := aValue + ' = ';
    $20 : aValue := aValue + ' <> ';
    $40 : aValue := aValue + ' > ';
    $60 : aValue := aValue + ' >= ';
    $80 : aValue := aValue + ' < ';
    $A0 : aValue := aValue + ' <= ';
  end;

  aValue := aValue + Condition.Elements[2].Value;

  if (Typ and $01) = 0 then
    aValue := aValue + ' AND'
  else
    aValue := aValue + ' OR';
end;

procedure wbConditionToStrTES5(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Condition: IwbContainerElementRef;
  lCTDA: IwbContainerElementRef;
  RunOn, Param1, Param2: IwbElement;
  Typ: Byte;
begin
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
  if Param1.ConflictPriority <> cpIgnore then begin
    aValue := aValue + '(' {+ Param1.Name + ': '} + Param1.Value;
    Param2 := lCTDA.Elements[6];
    if Param2.ConflictPriority <> cpIgnore then begin
      aValue := aValue + ', ' {+ Param2.Name + ': '} + Param2.Value;
    end;
    aValue := aValue + ')';
  end;

  Typ := lCTDA.Elements[0].NativeValue;

  case Typ and $E0 of
    $00 : aValue := aValue + ' = ';
    $20 : aValue := aValue + ' <> ';
    $40 : aValue := aValue + ' > ';
    $60 : aValue := aValue + ' >= ';
    $80 : aValue := aValue + ' < ';
    $A0 : aValue := aValue + ' <= ';
  end;

  aValue := aValue + lCTDA.Elements[2].Value;

  if (Typ and $01) = 0 then
    aValue := aValue + ' AND'
  else
    aValue := aValue + ' OR';
end;

procedure wbFactionRelationToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Relation: IwbContainerElementRef;
begin
  if not Supports(aElement, IwbContainerElementRef, Relation) then
    Exit;
  if Relation.Collapsed <> tbTrue then
    Exit;

  aValue := Relation.Elements[2].Value + ' ' + Relation.Elements[0].Value;
end;

procedure wbModelToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Model: IwbContainerElementRef;
begin
  if not Supports(aElement, IwbContainerElementRef, Model) then
    Exit;
  if Model.Collapsed <> tbTrue then
    Exit;

  aValue := Model.Elements[0].Value;
end;

procedure wbObjectBoundsToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  OBND: IwbContainerElementRef;
  FacetPointA, FacetPointB: String;
  X1, X2, Y1, Y2, Z1, Z2: IwbElement;
begin
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

procedure wbRecipeComponentToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Component: IwbContainerElementRef;
begin
  if not Supports(aElement, IwbContainerElementRef, Component) then
    Exit;
  if Component.Collapsed <> tbTrue then
    Exit;

  aValue := Component.Elements[1].Value + 'x ' + Component.Elements[0].Value;
end;

procedure wbRecipeItemToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  Item, CNTO: IwbContainerElementRef;
begin
  if not Supports(aElement, IwbContainerElementRef, Item) then
    Exit;
  if Item.Collapsed <> tbTrue then
    Exit;

  CNTO := Item.Elements[0] as IwbContainerElementRef;

  aValue := CNTO.Elements[1].Value + 'x ' + CNTO.Elements[0].Value;
end;

procedure wbRecordHeaderToStr(var aValue:string; aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement; aType: TwbCallbackType);
var
  RecordHeader: IwbContainerElementRef;
  RecordFlags: IwbElement;
  MainRecord: IwbMainRecord;
begin
  if not Supports(aElement, IwbContainerElementRef, RecordHeader) then
    Exit;
  if RecordHeader.Collapsed <> tbTrue then
    Exit;

  MainRecord := RecordHeader.ContainingMainRecord;
  RecordFlags := RecordHeader.Elements[2];

  aValue := '[' + MainRecord.Signature + ':' + MainRecord.LoadOrderFormID.ToString(True) + ']';
  if Length(RecordFlags.Value) > 0 then
    aValue := aValue + ' {' + RecordFlags.Value + '}';
end;

end.
