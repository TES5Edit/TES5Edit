{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License, 
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain 
  one at https://mozilla.org/MPL/2.0/.

*******************************************************************************}

unit wbSaveInterface;

interface

uses
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

function wbCreateSaveTables: IwbSaveTables;
function wbSaveTablesOf(const aElement: IwbElement): IwbSaveTables;

function wbFindSaveElement(const aName: String; aElement: IwbElement): IwbElement;
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

uses
  System.SysUtils;

type
  ohfVMObjectHandleRecord = record
    Handle: Int64;
    VMType: Integer;
  end;

  ahfVMArrayHandleRecord = record
    Handle : Int64;
    Count  : Int64;
  end;

  TwbSaveTables = class(TInterfacedObject, IwbSaveTables)
  protected
    stVMTypes         : array of String;
    stObjectHandles   : array of ohfVMObjectHandleRecord;
    stDetachedHandles : array of ohfVMObjectHandleRecord;
    stArrayHandles    : array of ahfVMArrayHandleRecord;
    stWorldspaces     : array of IwbElement;
    stRefIDs          : TwbRefIDArray;
    stVMObjectArrayCount           : Integer;
    stVMSupplementObjectArrayCount : Integer;
    stVMObjectDetachedArrayCount   : Integer;
    stVMArrayTableCount            : Integer;
    stStackTableCount              : Integer;
    stPlayerRefIndex               : Cardinal;

    function GetVMObjectArrayCount: Integer;
    procedure SetVMObjectArrayCount(aValue: Integer);
    function GetVMSupplementObjectArrayCount: Integer;
    procedure SetVMSupplementObjectArrayCount(aValue: Integer);
    function GetVMObjectDetachedArrayCount: Integer;
    procedure SetVMObjectDetachedArrayCount(aValue: Integer);
    function GetVMArrayTableCount: Integer;
    procedure SetVMArrayTableCount(aValue: Integer);
    function GetStackTableCount: Integer;
    procedure SetStackTableCount(aValue: Integer);
    function GetPlayerRefIndex: Cardinal;
    procedure SetPlayerRefIndex(aValue: Cardinal);

    procedure InitializeVMTypeArray(const aContainer: IwbContainer);
    procedure InitializeVMObjectArray(const aContainer: IwbContainer);
    procedure InitializeVMObjectDetachedArray(const aContainer: IwbContainer);
    procedure InitializeVMArrayTable(const aContainer: IwbContainer);
    procedure InitializeSaveWorldspaceArray(const aContainer: IwbContainer);
    procedure InitializeSaveRefIDArray(const aContainer: IwbContainer);
    procedure SetRefIDArray(const anArray: TwbRefIDArray);
    function VMTypeName(aIndex: Int64): string;
    function ObjectName(aHandle: Int64): string;
    function VMArrayCount(aHandle: Int64): Int64;
    function SaveWorldspaceName(aIndex: Int64): string;
    function SaveRefID(aIndex: Cardinal): Cardinal;
    function GetRefIDArray: TwbRefIDArray;
  public
    constructor Create;
  end;

constructor TwbSaveTables.Create;
begin
  inherited Create;
  stVMObjectArrayCount := -1;
  stVMSupplementObjectArrayCount := -1;
  stVMObjectDetachedArrayCount := -1;
  stVMArrayTableCount := -1;
  stStackTableCount := -1;
end;

function TwbSaveTables.GetVMObjectArrayCount: Integer;
begin
  Result := stVMObjectArrayCount;
end;

procedure TwbSaveTables.SetVMObjectArrayCount(aValue: Integer);
begin
  stVMObjectArrayCount := aValue;
end;

function TwbSaveTables.GetVMSupplementObjectArrayCount: Integer;
begin
  Result := stVMSupplementObjectArrayCount;
end;

procedure TwbSaveTables.SetVMSupplementObjectArrayCount(aValue: Integer);
begin
  stVMSupplementObjectArrayCount := aValue;
end;

function TwbSaveTables.GetVMObjectDetachedArrayCount: Integer;
begin
  Result := stVMObjectDetachedArrayCount;
end;

procedure TwbSaveTables.SetVMObjectDetachedArrayCount(aValue: Integer);
begin
  stVMObjectDetachedArrayCount := aValue;
end;

function TwbSaveTables.GetVMArrayTableCount: Integer;
begin
  Result := stVMArrayTableCount;
end;

procedure TwbSaveTables.SetVMArrayTableCount(aValue: Integer);
begin
  stVMArrayTableCount := aValue;
end;

function TwbSaveTables.GetStackTableCount: Integer;
begin
  Result := stStackTableCount;
end;

procedure TwbSaveTables.SetStackTableCount(aValue: Integer);
begin
  stStackTableCount := aValue;
end;

function TwbSaveTables.GetPlayerRefIndex: Cardinal;
begin
  Result := stPlayerRefIndex;
end;

procedure TwbSaveTables.SetPlayerRefIndex(aValue: Cardinal);
begin
  stPlayerRefIndex := aValue;
end;

function wbCreateSaveTables: IwbSaveTables;
begin
  Result := TwbSaveTables.Create;
end;

function wbSaveTablesOf(const aElement: IwbElement): IwbSaveTables;
var
  lFile    : IwbFile;
  lContext : IwbGameContext;
begin
  Result := nil;
  if not Assigned(aElement) then
    Exit;
  lFile := aElement._File;
  if not Assigned(lFile) then
    Exit;
  lContext := lFile.Context;
  if not Assigned(lContext) then
    Exit;
  Result := lContext.SaveTables;
  if not Assigned(Result) then begin
    Result := wbCreateSaveTables;
    lContext.SaveTables := Result;
  end;
end;

{ wbVMType }

procedure TwbSaveTables.InitializeVMTypeArray(const aContainer: IwbContainer);
var
  i   : Integer;
begin
  if Assigned(aContainer) and not assigned(stVMTypes) then begin
    SetLength(stVMTypes, aContainer.ElementCount);
    for i := 0 to Pred(aContainer.ElementCount) do
      stVMTypes[i] := aContainer.Elements[i].NativeValue;
  end;
end;

function TwbSaveTables.VMTypeName(aIndex: Int64): string;
begin
  if (aIndex >= 0) and (aIndex < Length(stVMTypes)) then
    Result := '[' + IntToHex64(aIndex, 8) + '] '+ stVMTypes[aIndex]
  else
    Result := '[' + IntToHex64(aIndex, 8) + '] <no such string>';
end;

function TwbVMTypeFormaterToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  lTables : IwbSaveTables;
begin
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 8)
  else begin
    lTables := wbSaveTablesOf(aElement);
    if Assigned(lTables) then
      Result := lTables.VMTypeName(aInt)
    else
      Result := '[' + IntToHex64(aInt, 8) + '] <no such string>';
  end;
end;

{ wbVMObjectHandle }

procedure TwbSaveTables.InitializeVMObjectArray(const aContainer: IwbContainer);
var
  i         : Integer;
  Container : IwbContainer;
begin
  if Assigned(aContainer) and not Assigned(stObjectHandles) then begin
    SetLength(stObjectHandles, aContainer.ElementCount);
    for i := 0 to Pred(aContainer.ElementCount) do begin
      Container := (aContainer.Elements[i] as IwbContainer);
      stObjectHandles[i].Handle := Container.ElementByName['Object Handle'].NativeValue;
      stObjectHandles[i].VMType := Container.ElementByName['Name'].NativeValue;
    end;
  end;
end;

procedure TwbSaveTables.InitializeVMObjectDetachedArray(const aContainer: IwbContainer);
var
  i         : Integer;
  Container : IwbContainer;
begin
  if Assigned(aContainer) and not Assigned(stDetachedHandles) and (aContainer.ElementCount>0) then begin
    SetLength(stDetachedHandles, aContainer.ElementCount);
    for i := 0 to Pred(aContainer.ElementCount) do begin
      Container := (aContainer.Elements[i] as IwbContainer);
      stDetachedHandles[i].Handle := Container.ElementByName['Object Handle'].NativeValue;
      stDetachedHandles[i].VMType := Container.ElementByName['Name'].NativeValue;
    end;
  end;
end;

function TwbSaveTables.ObjectName(aHandle: Int64): string;
var
  VMType : Integer;
  i      : Integer;
begin
  Result := '';
  VMType := -1;
  for i := 0 to High(stObjectHandles) do
    if stObjectHandles[i].Handle=aHandle then begin
      VMType := stObjectHandles[i].VMType;
      Break;
    end;
  if VMType<0 then
    for i := 0 to High(stDetachedHandles) do
      if stDetachedHandles[i].Handle=aHandle then begin
        VMType := stDetachedHandles[i].VMType;
        Break;
      end;
  if VMType < 0 then
    Exit;
  if VMType < Length(stVMTypes) then
    Result := '[' + IntToHex64(aHandle, 8) + '] '+ stVMTypes[VMType]
  else
    Result := '[' + IntToHex64(aHandle, 8) + '] <no such type>';
end;

function TwbHandleFormaterToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
begin
  Result := IntToHex64(aInt, 16)
end;

function TwbObjectHandleFormaterToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  lTables : IwbSaveTables;
begin
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 8)
  else begin
    Result := '';
    lTables := wbSaveTablesOf(aElement);
    if Assigned(lTables) then
      Result := lTables.ObjectName(aInt);
    if Result = '' then
      if aInt = 0 then
        Result := '[' + IntToHex64(aInt, 8) + '] [empty]'
      else
        Result := '[' + IntToHex64(aInt, 8) + '] <no such object>';
  end;
end;

{ wbVMArrayHandle }

procedure TwbSaveTables.InitializeVMArrayTable(const aContainer: IwbContainer);
var
  i         : Integer;
  Container : IwbContainer;
begin
  if Assigned(aContainer) and not Assigned(stArrayHandles) then begin
    SetLength(stArrayHandles, aContainer.ElementCount);
    for i := 0 to Pred(aContainer.ElementCount) do begin
      Container := (aContainer.Elements[i] as IwbContainer);
      stArrayHandles[i].Handle := Container.ElementByName['Array Handle'].NativeValue;
      stArrayHandles[i].Count := Container.ElementByName['Count'].NativeValue;
    end;
  end;
end;

function TwbSaveTables.VMArrayCount(aHandle: Int64): Int64;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to High(stArrayHandles) do
    if stArrayHandles[i].Handle = aHandle then begin
      Result := stArrayHandles[i].Count;
      Break;
    end;
  if result < 0 then
    result := 0;
end;

function TwbVMArrayHandleFormaterToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  Count   : Int64;
  lTables : IwbSaveTables;
begin
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 8)
  else begin
    Count := 0;
    lTables := wbSaveTablesOf(aElement);
    if Assigned(lTables) then
      Count := lTables.VMArrayCount(aInt);
    Result := '[' + IntToHex64(aInt, 8) + '] Count = '+ IntToStr(Count);
  end;
end;

{ wbSaveWorldspaceIndex }

procedure TwbSaveTables.InitializeSaveWorldspaceArray(const aContainer: IwbContainer);
var
  i   : Integer;
begin
  if Assigned(aContainer) and not assigned(stWorldspaces) then begin
    SetLength(stWorldspaces, aContainer.ElementCount);
    for i := 0 to Pred(aContainer.ElementCount) do
      stWorldspaces[i] := aContainer.Elements[i];
  end;
end;

function TwbSaveTables.SaveWorldspaceName(aIndex: Int64): string;
begin
  if (aIndex > 0) and (aIndex <= Length(stWorldspaces)) then
    Result := '[' + IntToHex64(aIndex, 8) + '] '+ stWorldspaces[aIndex-1].Value
  else
    Result := '[' + IntToHex64(aIndex, 8) + '] <no such worldspace>';
end;

function TwbSaveWorldspaceIndexFormaterToString(aInt: Int64; const aElement: IwbElement; aType: TwbCallbackType): string;
var
  lTables : IwbSaveTables;
begin
  if aType = ctToSortKey then
    Result := IntToHex64(aInt, 8)
  else begin
    lTables := wbSaveTablesOf(aElement);
    if Assigned(lTables) then
      Result := lTables.SaveWorldspaceName(aInt)
    else
      Result := '[' + IntToHex64(aInt, 8) + '] <no such worldspace>';
  end;
end;

procedure TwbSaveTables.InitializeSaveRefIDArray(const aContainer: IwbContainer);
var
  i : Integer;
begin
  if Assigned(aContainer) and not assigned(stRefIDs) then begin
    SetLength(stRefIDs, aContainer.ElementCount);
    for i := 0 to Pred(aContainer.ElementCount) do
      stRefIDs[i] := aContainer.Elements[i].NativeValue;
  end;
end;

procedure TwbSaveTables.SetRefIDArray(const anArray: TwbRefIDArray);
begin
  stRefIDs := anArray;
end;

function TwbSaveTables.SaveRefID(aIndex: Cardinal): Cardinal;
begin
  if (aIndex>0) and (aIndex<=Length(stRefIDs)) then
    Result := stRefIDs[aIndex-1]
  else
    Result := 0;
end;

function TwbSaveTables.GetRefIDArray: TwbRefIDArray;
begin
  Result := stRefIDs;
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

function wbFindSaveElement(const aName: String; aElement: IwbElement): IwbElement;
var
  Container : IwbContainer;

  function FindOurself(const aName: String; aContainer: IwbContainer; var aElement: IwbElement): Boolean;
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
