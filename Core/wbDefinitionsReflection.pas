unit wbDefinitionsReflection;

{$I wbDefines.inc}

interface

uses
  wbInterface;

function wbREFLStringToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
function wbREFLStringToInt(const aString: string; const aElement: IwbElement): Int64;
function wbREFLDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
function wbREFLShouldInclude(aBasePtr: Pointer; aEndPtr: Pointer; const aArray: IwbElement): Boolean;

function wbREFLColor(const aName: string): IwbValueDef;
function wbREFLEffect(const aName: string): IwbValueDef;
function wbREFLFloat(const aName: string; const aDefaultValue: Integer = 0): IwbValueDef;
function wbREFLFormID(const aName: string; const aSigs: TwbSignatures = []): IwbValueDef;
function wbREFLWwiseGUID(const aName: string = 'GUID'): IwbValueDef;

function wbREFLColorEnum : IwbEnumDef;
function wbREFLFloatEnum : IwbEnumDef;

function wbREFLOperationEnum : IwbStringDefFormater;

function wbReflection(const aSig  : TwbSignature;
                      const aData : IwbValueDef = nil)
                                  : IwbRecordMemberDef;

implementation

uses
  System.Variants,

  wbDefinitionsCommon,
  wbDefinitionsSignatures,
  wbHelpers;

function wbREFLStringToStr(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  if not Assigned(aElement) then
    Exit('');

  if not (aType in [ctToEditValue, ctToSortKey, ctToStr, ctToSummary, ctCheck]) then
    Exit('');

  if aInt < 0 then begin
    if aType = ctCheck then
      Exit('');
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
      Integer($FFFFFF13): Exit('Diff');
    else
      Exit('<Warning: Unknown Type>');
    end;
  end else begin
    var lSubRecord := aElement.ContainingSubRecord;
    if not Assigned(lSubRecord) then
      Exit('');

    var lStringTable := lSubRecord.ElementByPath['String Table\Strings'] as IwbDataContainer;
    if not Assigned(lStringTable) then
      Exit('');

    var lBasePtr : PAnsiChar := lStringTable.DataBasePtr;
    var lEndPtr  : PAnsiChar := lStringTable.DataEndPtr;
    if aInt >= lEndPtr - lBasePtr then
      Exit('<Warning: Offset outside String Table>');
    if aType = ctCheck then
      Exit('');

    var lStringPtr : PAnsiChar := @lBasePtr[aInt];
    var lLength := 0;
    while (lStringPtr + lLength < lEndPtr) and (lStringPtr[lLength] <> #0) do
      Inc(lLength);
    var lString : AnsiString;
    SetString(lString, lStringPtr, lLength);
    Result := string(lString);
  end;
end;

function wbREFLStringToInt(const aString: string; const aElement: IwbElement): Int64;
begin
  Result := 0;
  if aString = '' then
    Exit;

  if not Assigned(aElement) then
    Exit;

  if aString = 'Null'   then Exit($FFFFFF01) else
  if aString = 'String' then Exit($FFFFFF02) else
  if aString = 'List'   then Exit($FFFFFF03) else
  if aString = 'Map'    then Exit($FFFFFF04) else
  if aString = 'Ref'    then Exit($FFFFFF05) else
  if aString = 'Int8'   then Exit($FFFFFF08) else
  if aString = 'UInt8'  then Exit($FFFFFF09) else
  if aString = 'Int16'  then Exit($FFFFFF0A) else
  if aString = 'UInt16' then Exit($FFFFFF0B) else
  if aString = 'Int32'  then Exit($FFFFFF0C) else
  if aString = 'UInt32' then Exit($FFFFFF0D) else
  if aString = 'Int64'  then Exit($FFFFFF0E) else
  if aString = 'UInt64' then Exit($FFFFFF0F) else
  if aString = 'Bool'   then Exit($FFFFFF10) else
  if aString = 'Float'  then Exit($FFFFFF11) else
  if aString = 'Double' then Exit($FFFFFF12) else
  if aString = 'Diff'   then Exit($FFFFFF13) else

  begin
    var lSubRecord := aElement.ContainingSubRecord;
    if not Assigned(lSubRecord) then
      Exit;

    var lStringTable := lSubRecord.ElementByPath['String Table\Strings'] as IwbContainerElementRef;
    if not Assigned(lStringTable) then
      Exit;

    var lTablePtr := (lStringTable as IwbDataContainer).DataBasePtr;
    for var i := 0 to Pred(lStringTable.ElementCount) do begin
      var lString := lStringTable.Elements[i];
      if aString = lString.EditValue then begin
        var lStringPtr := (lString as IwbDataContainer).DataBasePtr;
        Result := Int64(lStringPtr) - Int64(lTablePtr);
        Exit;
      end;
    end;
  end;
end;

function wbREFLDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
  if not Assigned(aElement) then
    Exit;

  var lContainer : IwbContainer;
  if not wbTryGetContainerFromUnion(aElement, lContainer) then
    Exit;

  Result := lContainer.Elements[0].NativeValue;
end;

function wbREFLShouldInclude(aBasePtr: Pointer; aEndPtr: Pointer; const aArray: IwbElement): Boolean;
begin
  Result := PWord(aBasePtr)^ <> $FFFF;
end;

function wbREFLColor(const aName: string): IwbValueDef;
begin
  Result :=
    wbStruct(aName, [
      wbLenString('Operation', 2)
        .SetFormater(wbREFLOperationEnum)
        .SetDefaultEditValue('Replace'),
      wbFloatRGBA('Value'),
      wbFloat('Blend Amount').SetDefaultNativeValue(1)
    ]).SetSummaryKey([1])
      .IncludeFlag(dfCollapsed)
end;

function wbREFLEffect(const aName: string): IwbValueDef;
begin
  Result :=
    wbStructSK([0], aName, [
      wbREFLFormID('Spell', [SPEL,NULL]),
      wbFloat('Threshold')
    ]).SetSummaryKey([0])
      .IncludeFlag(dfCollapsed);
end;

function wbREFLFloat(const aName: string; const aDefaultValue: Integer = 0): IwbValueDef;
begin
  Result :=
    wbStruct(aName, [
      wbLenString('Operation', 2)
        .SetFormater(wbREFLOperationEnum)
        .SetDefaultEditValue('Replace'),
      wbFloat('Value').SetDefaultNativeValue(aDefaultValue),
      wbFloat('Blend Amount').SetDefaultNativeValue(1)
    ]).SetSummaryKey([1])
      .IncludeFlag(dfCollapsed)
end;

function wbREFLFormID(const aName : string;
                      const aSigs : TwbSignatures = [])
                                  : IwbValueDef;
begin
  Result :=
    wbStructSK([1], aName, [
      wbInteger('Data Type', itS32, wbREFLStringToStr, wbREFLStringToInt).SetDefaultEditValue('UInt32'),
      wbFormIDCK(aName, aSigs)
    ]).SetSummaryKey([1])
      .IncludeFlag(dfCollapsed);
end;

function wbREFLWwiseGUID(const aName: string = 'GUID'): IwbValueDef;
begin
  Result :=
    wbStruct(aName, [
      wbInteger('Data Type', itS32, wbREFLStringToStr, wbREFLStringToInt).SetDefaultEditValue('UInt32'),
      wbUnknown(8)
    ]);
end;

function wbREFLColorEnum : IwbEnumDef;
begin
  Result :=
    wbEnum([
    {0} 'Red',
    {1} 'Green',
    {2} 'Blue',
    {3} 'Alpha'
    ]);
end;

function wbREFLFloatEnum : IwbEnumDef;
begin
  Result :=
    wbEnum([
    {0} 'Operation',
    {1} 'Value',
    {2} 'Blend Amount'
    ]);
end;

function wbREFLOperationEnum : IwbStringDefFormater;
begin
  Result :=
    wbStringEnum([
    {0} 'Add',
    {1} 'Greater',
    {2} 'Multiply',
    {4} 'Replace'
    ]);
end;

function wbReflection(const aSig  : TwbSignature;
                      const aData : IwbValueDef = nil)
                                  : IwbRecordMemberDef;
begin
  var lBoolean := False;
  if not Assigned(aData) then
    lBoolean := True;

  Result :=
    wbStruct(aSig, 'Reflection', [
      wbStruct('Reflection Header', [
        wbString('Signature', 4).SetDefaultEditValue('BETH'),
        wbInteger('Data Size', itU32).SetDefaultNativeValue(8),
        wbInteger('Version', itU32),
        wbInteger('Chunk Count', itU32)
      ]).IncludeFlag(dfFastAssign)
        .IncludeFlag(dfInternalEditOnly),
      wbStruct('String Table', [
        wbString('Signature', 4).SetDefaultEditValue('STRT'),
        wbInteger('Data Size', itU32),
        wbArray('Strings',
          wbString('String')
        ).SetShouldInclude(function(aBasePtr: Pointer; aEndPtr: Pointer; const aArray: IwbElement): Boolean
         begin
           Result := (NativeUInt(aEndPtr) - NativeUInt(aBasePtr) < 4) or (PLongWord(aBasePtr)^ <> $45505954);
         end)
      ]).SetSummaryKey([2])
        .IncludeFlag(dfCollapsed)
        .IncludeFlag(dfInternalEditOnly),
      wbStruct('Type', [
        wbString('Signature', 4).SetDefaultEditValue('TYPE'),
        wbInteger('Data Size', itU32).SetDefaultNativeValue(4),
        wbInteger('Class Count', itU32)
      ]).SetSummaryKey([2])
        .SetSummaryMemberPrefixSuffix(2, 'Class Count: ', '')
        .IncludeFlag(dfCollapsed)
        .IncludeFlag(dfInternalEditOnly),
      wbArray('Classes',
        wbStruct('Class', [
          wbString('Signature', 4).SetDefaultEditValue('CLAS'),
          wbInteger('Data Size', itU32),
          wbInteger('Class Name', itS32, wbREFLStringToStr, wbREFLStringToInt),
          wbInteger('Form', itS32, wbREFLStringToStr, wbREFLStringToInt),
          wbInteger('Flags', itU16,
            wbFlags(wbSparseFlags([
            2, 'User',
            3, 'Struct'
            ], False, 4))
          ).IncludeFlag(dfCollapsed, wbCollapseFlags),
          wbArray('Fields',
            wbStruct('Field', [
              wbInteger('Field Name', itS32, wbREFLStringToStr, wbREFLStringToInt),
              wbInteger('Field Type', itS32, wbREFLStringToStr, wbREFLStringToInt),
              wbInteger('Offset', itU16),
              wbInteger('Size', itU16)
            ]).SetSummaryKey([0])
              .IncludeFlag(dfCollapsed),
          -2).IncludeFlag(dfCollapsed)
        ]).SetSummaryKey([2])
          .IncludeFlag(dfCollapsed)
      ).SetCountPath('Type\Class Count', True)
       .IncludeFlag(dfCollapsed)
       .IncludeFlag(dfInternalEditOnly),
      IfThen(lBoolean, wbUnknown(0), nil),
      aData
    ]).IncludeFlag(dfCanContainReflection)
      .IncludeFlag(dfFastAssign)
      .IncludeFlag(dfIsReflection);
end;

end.
