unit wbSaveInterface;

interface

uses
  SysUtils,
  wbInterface;

var
  dtArrays : set of TwbDefType = [
    dtSubRecordArray,
    dtArray
  ];

function wbVMType              : IwbIntegerDefFormater;
function wbVMObjectHandle      : IwbIntegerDefFormater;
function wbVMArrayHandle       : IwbIntegerDefFormater;
function wbSaveWorldspaceIndex : IwbIntegerDefFormater;

procedure InitializeVMTypeArray(aContainer: IwbContainer);
procedure InitializeVMObjectArray(aContainer: IwbContainer);
procedure InitializeVMObjectDetachedArray(aContainer: IwbContainer);
procedure InitializeVMArrayTable(aContainer: IwbContainer);

procedure InitializeSaveWorldspaceArray(aContainer: IwbContainer);
procedure InitializeSaveRefIDArray(aContainer: IwbContainer);
function GetSaveRefID(aIndex: Cardinal): Cardinal;

function QueryCountForVMArrayHandle(anArrayHandle: Int64): Int64;

implementation

{ wbVMType }

var
  sifVMTypeArray : array of String = nil;

procedure InitializeVMTypeArray(aContainer: IwbContainer);
var
  i   : Integer;
begin
  if Assigned(aContainer) and not assigned(sifVMTypeArray) then begin
    SetLength(sifVMTypeArray, aContainer.ElementCount);
    for i := 0 to Pred(aContainer.ElementCount) do
      sifVMTypeArray[i] := aContainer.Elements[i].NativeValue;
  end;
end;

function TwbVMTypeFormaterToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 8)
  else if (aInt >= 0) and (aInt < Length(sifVMTypeArray)) then
    Result := '[' + IntToHex64(aInt, 8) + '] '+ sifVMTypeArray[aInt]
  else
    Result := '[' + IntToHex64(aInt, 8) + '] <no such string>';
end;

{ wbVMObjectHandle }

type
  ohfVMObjectHandleRecord = record
    Handle: Int64;
    VMType: Integer;
  end;

var
  ohfVMObjectHandleTable : array of ohfVMObjectHandleRecord = nil;  // stores VMType
  ohfVMObjectDetachedHandleTable : array of ohfVMObjectHandleRecord = nil;  // stores VMType

procedure InitializeVMObjectArray(aContainer: IwbContainer);
var
  i         : Integer;
  Container : IwbContainer;
begin
  if Assigned(aContainer) and not Assigned(ohfVMObjectHandleTable) then begin
    SetLength(ohfVMObjectHandleTable, aContainer.ElementCount);
    for i := 0 to Pred(aContainer.ElementCount) do begin
      Container := (aContainer.Elements[i] as IwbContainer);
      ohfVMObjectHandleTable[i].Handle := Container.ElementByName['Object Handle'].NativeValue;
      ohfVMObjectHandleTable[i].VMType := Container.ElementByName['Name'].NativeValue;
    end;
  end;
end;

procedure InitializeVMObjectDetachedArray(aContainer: IwbContainer);
var
  i         : Integer;
  Container : IwbContainer;
begin
  if Assigned(aContainer) and not Assigned(ohfVMObjectDetachedHandleTable) and (aContainer.ElementCount>0) then begin
    SetLength(ohfVMObjectDetachedHandleTable, aContainer.ElementCount);
    for i := 0 to Pred(aContainer.ElementCount) do begin
      Container := (aContainer.Elements[i] as IwbContainer);
      ohfVMObjectDetachedHandleTable[i].Handle := Container.ElementByName['Object Handle'].NativeValue;
      ohfVMObjectDetachedHandleTable[i].VMType := Container.ElementByName['Name'].NativeValue;
    end;
  end;
end;

function ReadObjectName(aInt: Int64): String;
var
  VMType : Integer;
  i      : Integer;
begin
  Result := '';
  VMType := -1;
  for i := 0 to High(ohfVMObjectHandleTable) do
    if ohfVMObjectHandleTable[i].Handle=aInt then begin
      VMType := ohfVMObjectHandleTable[i].VMType;
    end;
  if VMType<0 then
    for i := 0 to High(ohfVMObjectDetachedHandleTable) do
      if ohfVMObjectDetachedHandleTable[i].Handle=aInt then begin
        VMType := ohfVMObjectDetachedHandleTable[i].VMType;
      end;
  if VMType >= 0 then
    Result := '[' + IntToHex64(aInt, 8) + '] '+ sifVMTypeArray[VMType];
end;

function TwbObjectHandleFormaterToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 8)
  else begin
    Result := ReadObjectName(aInt);
    if Result = '' then
      if aInt = 0 then
        Result := '[' + IntToHex64(aInt, 8) + '] [empty]'
      else
        Result := '[' + IntToHex64(aInt, 8) + '] <no such object>';
  end;
end;

{ wbVMArrayHandle }

type
  ahfVMArrayHandleRecord = record
    Handle : Int64;
    Count  : Int64;
  end;

var
  ahfVMArrayHandleTable : array of ahfVMArrayHandleRecord = nil;  // stores VMType

procedure InitializeVMArrayTable(aContainer: IwbContainer);
var
  i         : Integer;
  Container : IwbContainer;
begin
  if Assigned(aContainer) and not Assigned(ahfVMArrayHandleTable) then begin
    SetLength(ahfVMArrayHandleTable, aContainer.ElementCount);
    for i := 0 to Pred(aContainer.ElementCount) do begin
      Container := (aContainer.Elements[i] as IwbContainer);
      ahfVMArrayHandleTable[i].Handle := Container.ElementByName['Array Handle'].NativeValue;
      ahfVMArrayHandleTable[i].Count := Container.ElementByName['Count'].NativeValue;
    end;
  end;
end;

function QueryCountForVMArrayHandle(anArrayHandle: Int64): Int64;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to High(ahfVMArrayHandleTable) do
    if ahfVMArrayHandleTable[i].Handle = anArrayHandle then begin
      Result := ahfVMArrayHandleTable[i].Count;
    end;
  if result < 0 then
    result := 0;
end;

function TwbVMArrayHandleFormaterToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Count : Int64;
begin
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 8)
  else begin
    Count := QueryCountForVMArrayHandle(aInt);
    Result := '[' + IntToHex64(aInt, 8) + '] Count = '+ IntToStr(Count);
  end;
end;

{ wbSaveWorldspaceIndex }

var
  sifSaveWorldspaceArray : array of IwbElement = nil;

procedure InitializeSaveWorldspaceArray(aContainer: IwbContainer);
var
  i   : Integer;
begin
  if Assigned(aContainer) and not assigned(sifSaveWorldspaceArray) then begin
    SetLength(sifSaveWorldspaceArray, aContainer.ElementCount);
    for i := 0 to Pred(aContainer.ElementCount) do
      sifSaveWorldspaceArray[i] := aContainer.Elements[i];
  end;
end;

function TwbSaveWorldspaceIndexFormaterToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 8)
  else if (aInt > 0) and (aInt <= Length(sifSaveWorldspaceArray)) then begin
    Result := '[' + IntToHex64(aInt, 8) + '] '+ sifSaveWorldspaceArray[aInt-1].Value
  end else
    Result := '[' + IntToHex64(aInt, 8) + '] <no such worldspace>';
end;

var
  SaveRefIDArray: TwbRefIDArray = nil;

procedure InitializeSaveRefIDArray(aContainer: IwbContainer);
var
  i : Integer;
begin
  if Assigned(aContainer) and not assigned(SaveRefIDArray) then begin
    SetLength(SaveRefIDArray, aContainer.ElementCount);
    for i := 0 to Pred(aContainer.ElementCount) do
      SaveRefIDArray[i] := aContainer.Elements[i].NativeValue;
    InitializeRefIDArray(SaveRefIDArray);
  end;
end;

function GetSaveRefID(aIndex: Cardinal): Cardinal;
begin
  if (aIndex>0) and (aIndex<Length(SaveRefIDArray)) then
    Result := SaveRefIDArray[aIndex-1]
  else
    Result := 0;
end;

function wbVMType : IwbIntegerDefFormater;
begin
  Result := wbCallback(@TwbVMTypeFormaterToString, nil);
end;

function wbVMObjectHandle : IwbIntegerDefFormater; overload;
begin
  Result := wbCallback(@TwbObjectHandleFormaterToString, nil);
end;

function wbVMArrayHandle : IwbIntegerDefFormater;
begin
  Result := wbCallback(@TwbVMArrayHandleFormaterToString, nil);
end;

function wbSaveWorldspaceIndex : IwbIntegerDefFormater;
begin
  Result := wbCallback(@TwbSaveWorldspaceIndexFormaterToString, nil);
end;

end.
