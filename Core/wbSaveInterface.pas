{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

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
function wbVMHandle            : IwbIntegerDefFormater;
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

function wbFindSaveElement(aName: String; aElement: IwbElement): IwbElement;
function wbDontShowBranch(const aElement: IwbElement): Boolean;

// CoSave shared data

var
  wbCoSaveArrayTypeEnum : IwbEnumDef;

function wbCoSaveChapterOtherCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
function wbCoSavePluginCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
function wbCoSaveChunkCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
function wbCoSaveChunkType(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
function wbCoSaveChunkTypeName(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): String;
function wbCoSaveArrayKeyElementDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
function wbCoSaveArrayDataElementDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
function wbCoSaveArrayType(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
function wbCoSaveArrayTypeName(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): String;

// Place holder during decoding...

function ToBeDeterminedDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
function ToBeDeterminedCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
function ToBeDeterminedCountCallback(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;

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

function TwbHandleFormaterToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := IntToHex64(aInt, 16)
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
      Break;
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
  Result := wbCallback(TwbVMTypeFormaterToString, nil);
end;

function wbVMHandle : IwbIntegerDefFormater; overload;
begin
  Result := wbCallback(TwbHandleFormaterToString, nil);
end;

function wbVMObjectHandle : IwbIntegerDefFormater; overload;
begin
  Result := wbCallback(TwbObjectHandleFormaterToString, nil);
end;

function wbVMArrayHandle : IwbIntegerDefFormater;
begin
  Result := wbCallback(TwbVMArrayHandleFormaterToString, nil);
end;

function wbSaveWorldspaceIndex : IwbIntegerDefFormater;
begin
  Result := wbCallback(TwbSaveWorldspaceIndexFormaterToString, nil);
end;

function wbFindSaveElement(aName: String; aElement: IwbElement): IwbElement;
var
  Container : IwbContainer;

  function FindOurself(aName: String; aContainer: IwbContainer; var aElement: IwbElement): Boolean;
  var
    i          : Integer;
    tContainer : IwbContainer;
  begin
    Result := False;
    for i := 0 to Pred(aContainer.ElementCount) do
      if SameText(aContainer.Elements[i].BaseName, aName) then begin
        aElement := aContainer.Elements[i];
        Result := True;
        break;
      end else if Supports(aContainer.Elements[i], IwbContainer, tContainer) then
        if FindOurself(aName, tContainer, aElement) then begin
          Result := True;
          break;
        end;
  end;

begin
  Result := aElement;
  while (not SameText(aName, Result.BaseName)) and Assigned(Result.Container) do
    Result := Result.Container;
  if (not SameText(aName, Result.BaseName)) then begin // try again in reverse
    Result := aElement;
    if Supports(Result, IwbContainer, Container) then
      FindOurself(aName, Container, Result);
  end;
end;

function wbDontShowBranch(const aElement: IwbElement): Boolean;
begin
  Result := wbHideNeverShow;
end;

function wbCoSaveChapterOtherCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Chunk', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Length'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function wbCoSavePluginCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element   : IwbElement;
  Container : IwbDataContainer;
  aFile     : IwbFile;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  aFile := aElement.GetFile;
  if not Assigned(aFile) then Exit;
  Element := aFile.ElementByName['CoSave File Header'];

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Plugins count'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function wbCoSaveChunkCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Plugin', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Chunks count'];
    if Assigned(Element) then
      Result := Element.NativeValue;
  end;
end;

function wbCoSaveChunkType(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := -1;
  if not Assigned(aBasePtr) then Exit;
  Result := PCardinal(aBasePtr)^;
end;

function wbCoSaveChunkTypeName(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): String;
begin
  Result := '';
  if not Assigned(aBasePtr) then Exit;
  Result := wbStr4ToString(PCardinal(aBasePtr)^);
end;

function wbCoSaveArrayKeyElementDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Array_var', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Key Type'];
    if Assigned(Element) then
      case Element.NativeValue of
        1: Result := 1;
      else
        Result := 2;
      end;
  end;
end;

function wbCoSaveArrayDataElementDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
var
  Element : IwbElement;
  Container: IwbDataContainer;
begin
  Result := 0;
  if not Assigned(aElement) then Exit;
  Element := wbFindSaveElement('Element', aElement);

  if Supports(Element, IwbDataContainer, Container) then begin
    Element := Container.ElementByName['Data Type'];
    if Assigned(Element) then
      case Element.NativeValue of
        1: Result := 1;   // Numeric
        2: Result := 2;   // Form
        3: Result := 3;   // String
        4: Result := 4;   // Array
      end;
  end;
end;

function wbCoSaveArrayType(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := -1;
  if not Assigned(aBasePtr) then Exit;
  Result := PCardinal(aBasePtr)^;
end;

function wbCoSaveArrayTypeName(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): String;
begin
  Result := '';
  if not Assigned(aBasePtr) then Exit;
  Result := IntToHex(PCardinal(aBasePtr)^, 8);
end;

function ToBeDeterminedDecider(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Integer;
begin
  Result := 0;
end;

function ToBeDeterminedCounter(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := 0;
end;

function ToBeDeterminedCountCallback(aBasePtr: Pointer; aEndPtr: Pointer; const aElement: IwbElement): Cardinal;
begin
  Result := 0;
end;

initialization

  wbCoSaveArrayTypeEnum := wbEnum([
    'Invalid',
    'Numeric',
    'Form',
    'String',
    'Array'
  ]);


end.
